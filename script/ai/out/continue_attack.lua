-----------------------------------------------------------------------------------------------
--	突撃する
--	指定ターゲットに対して、移動量を持った攻撃アニメで突撃します
--	一定時間攻撃し続けるか、攻撃が命中した場合に成功します。
--	一定距離、敵が離れてしまった場合には失敗とします。
--
--	パラメータ0  EzState番号
--	パラメータ1  攻撃対象【Type】					（TARGET）
--	パラメータ2  成功距離【ｍ】
--	パラメータ3　攻撃が命中したら成功とみなすか		（true、false）
--
--	使用例
--	-- ターゲット0に対して、近距離の、行動3000を実行。
--	-- 命中したら成功。２５ｍ離れたら失敗。
--	goal:AddSubGoal(GOAL_COMMON_ContinueAttack, 寿命, 3000, TARGET_ENE_0, 25, true);
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_COMMON_ContinueAttack, "ContinueAttack");

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ContinueAttack, 0, "EzState番号", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ContinueAttack, 1, "攻撃対象【Type】", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ContinueAttack, 2, "成功距離【ｍ】", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ContinueAttack, 3, "命中したら成功？", 0);

---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function ContinueAttack_Activate(ai, goal)
	-- EzState番号
	local behaviorNo = goal:GetParam(0);
	-- 攻撃対象
	local target = goal:GetParam(1)
	
	-- 旋回しながら攻撃する
	ai:TurnTo(target);
	ai:SetAttackRequest(behaviorNo);

	-- チームに攻撃していることを通知
	goal:AddGoalScopedTeamRecord(COORDINATE_TYPE_Attack, target, 0.0);
	
end


---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function ContinueAttack_Update(ai, goal)
	-- EzState番号
	local behaviorNo = goal:GetParam(0);
	-- 攻撃対象
	local target = goal:GetParam(1)
	-- 成功距離
	local distType = goal:GetParam(2);
	-- 命中したら成功？
	local successType = goal:GetParam(3);
	
	-- ターゲットとの距離
	local targetDist = ai:GetDist(target);
	
	
	-- 攻撃距離よりも離れたら失敗
	if targetDist >= distType then
		return GOAL_RESULT_Failed;
		
		--寿命が尽きたら成功
	elseif goal:GetLife() <= 0.0 then
		return GOAL_RESULT_Success;
		
		--命中したら成功（設定されていれば）
	elseif successType == true then
		if ai:IsHitAttack() == true then
			return GOAL_RESULT_Success;
		end
	end
	
	
	-- 旋回しながら攻撃する
	ai:TurnTo(target);
	ai:SetAttackRequest(behaviorNo);

	
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function ContinueAttack_Terminate(ai, goal)
end


-- 割り込みなし宣言
-- これがtrueの場合には割り込みが呼ばれないので注意してください。
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ContinueAttack, true);

---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function ContinueAttack_Interupt(ai, goal)
	return false;
end
