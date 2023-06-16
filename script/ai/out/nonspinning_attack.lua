-----------------------------------------------------------------------------------------------
--	旋回せずに攻撃する
--	向きを変えずに指定ターゲットに対して攻撃を実行します。
--	攻撃が終わった段階で、敵が距離内にいた場合に成功し、
--	敵が離れてしまった場合には失敗とします。
--
--	パラメータ0  EzState番号
--	パラメータ1  攻撃対象【Type】	（TARGET）
--	パラメータ2  成功距離【Type】	（DIST）
--	パラメータ3　なし
--
--	使用例
--	-- ターゲット0に対して、近距離の、行動3000を実行
--	goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 寿命, 3000, TARGET_ENE_0, DIST_Near, 0);
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_COMMON_NonspinningAttack, "NonspinningAttack");

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningAttack, 0, "EzState番号", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningAttack, 1, "攻撃対象【Type】", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningAttack, 2, "成功距離【Type】", 0);

---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function NonspinningAttack_Activate(ai, goal)

	-- パラメータ取得
	-- EzState番号
	local behaviorNo = goal:GetParam(0);
	-- 攻撃対象
	local target = goal:GetParam(1)

	-- 旋回する
--	ai:TurnTo(target);

--	if ai:IsLookToTarget() == true then
		-- 攻撃する
		ai:SetAttackRequest(behaviorNo);
--	end

	-- チームに攻撃していることを通知
	goal:AddGoalScopedTeamRecord(COORDINATE_TYPE_Attack, target, 0.0);

end


---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function NonspinningAttack_Update(ai, goal)

	-- パラメータ取得
	-- EzState番号
	local behaviorNo = goal:GetParam(0);
	-- 攻撃対象
	local target = goal:GetParam(1);
	-- 成功距離
	local distType = goal:GetParam(2);

	-- 攻撃終わったら終了
	if ai:IsFinishAttack() == true then
		local targetDist = ai:GetDist(target);
		
		-- 攻撃が当たったら成功
		if ai:IsHitAttack() == true then
			return GOAL_RESULT_Success;
			
		-- 敵が成功距離外なら失敗	
		elseif targetDist > ai:GetDistParam(distType) then
			return GOAL_RESULT_Failed;
			
		-- 敵が成功距離内なら成功	
		else
			return GOAL_RESULT_Success;
		end
--		return GOAL_RESULT_Success;
	end
	
	-- 攻撃アニメ開始していないときだけリクエストする
	if ai:IsStartAttack() == false then
		-- 攻撃する
		ai:SetAttackRequest(behaviorNo);
	end
	
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function NonspinningAttack_Terminate(ai, goal)
end


-- 割り込みなし宣言
-- これがtrueの場合には割り込みが呼ばれないので注意してください。
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_NonspinningAttack, true);

---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function NonspinningAttack_Interupt(ai, goal)
	return false;
end
