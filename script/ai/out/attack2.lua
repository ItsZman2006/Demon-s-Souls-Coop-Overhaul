--[[********************************************************************************************
	@goal	攻撃するver2
	@brief	指定対象に向かって攻撃を実行します。
			攻撃が終わった段階で、敵が距離内にいた場合に成功し、
			敵が離れてしまった場合には失敗とします。
	
	@note	ver1との違い。
			攻撃前旋回時間が指定できる。
	

	パラメータ0  EzState番号
	パラメータ1  攻撃対象【Type】		（TARGET）
	パラメータ2  成功距離【Type】		（DIST）
	パラメータ3　攻撃前旋回時間【秒】	（マイナスで、デフォルト旋回時間）

	使用例
	-- ターゲット0に対して、近距離の、行動3000を実行
	goal:AddSubGoal(GOAL_COMMON_Attack2, 寿命, 3000, TARGET_ENE_0, DIST_Near, 0);
**********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_Attack2, "Attack2");

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack2, 0, "EzState番号", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack2, 1, "攻撃対象【Type】", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack2, 2, "成功距離【Type】", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack2, 3, "攻撃前旋回時間【秒】", 0);

-- 
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_Attack2, 0, 0);	--毎フレームUpdate
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_Attack2, true);	--割り込みしない。

--[[******************************************************
	ゴール起動
********************************************************]]
function Attack2_Activate(ai, goal)

	local behaviorNo 	= goal:GetParam(0);	-- EzState番号
	local target 		= goal:GetParam(1);	-- 攻撃対象
	local turn_time		= goal:GetParam(3);	-- 攻撃前旋回時間。

	if (turn_time<0) then
		turn_time = 1.5;
	end

	--旋回あきらめタイマーをセット
	goal:SetTimer(0, turn_time);

	-- 旋回する
	ai:TurnTo(target);
	
	--一つ前の移動ゴールの目標位置を再設定。
	--		移動ゴールのTerminate()時に移動先がリセットされ、
	--		その直後の攻撃系ゴールで移動を設定しないため、
	--		アクションが始まるまでの時間、移動がニュートラル状態になる。
	--		そのため、待機アニメが挟まります。その時間が短ければ短いほど、
	--		アニメが飛んだように見え不自然。
	--		↓はその対応。hasem 08/9/18
	ai:MoveToLastTargetPosition();

	-- 旋回できたら攻撃
	if ai:IsLookToTarget() == true then
		ai:SetAttackRequest(behaviorNo);
	end
	
	-- チームに攻撃していることを通知
	goal:AddGoalScopedTeamRecord(COORDINATE_TYPE_Attack, target, 0.0);
	
end


--[[******************************************************
	ゴール更新
********************************************************]]
function Attack2_Update(ai, goal)

	local behaviorNo 	= goal:GetParam(0);	-- EzState番号
	local target 		= goal:GetParam(1);	-- 攻撃対象
	local distType 		= goal:GetParam(2);	-- 成功距離

	-- 攻撃終わったら
	if ( ai:IsFinishAttack()) then
		local targetDist 	= ai:GetDist(target);
		local typeDist		= ai:GetDistParam(distType);
		
		if ( ai:IsHitAttack()) then
			-- 攻撃が当たったら成功
			return GOAL_RESULT_Success;
		elseif ( targetDist > typeDist) then
			-- 敵が成功距離外なら失敗	
			return GOAL_RESULT_Failed;
		else
			-- 敵が成功距離内なら成功
			return GOAL_RESULT_Success;
		end
		
	end

	-- 攻撃アニメ開始していないときだけリクエストする
	if ai:IsStartAttack() == false then
		-- 旋回できたら攻撃
		if ( ai:IsLookToTarget())then
			ai:SetAttackRequest(behaviorNo);
			
		-- 旋回諦めタイマーがゼロになったら攻撃
		elseif (goal:IsFinishTimer(0)) then
			ai:SetAttackRequest(behaviorNo);
		end
	end

	-- 旋回する
	ai:TurnTo(target);
	
	return GOAL_RESULT_Continue;
end


--[[******************************************************
	ゴール終了。
********************************************************]]
function Attack2_Terminate(ai, goal)
end


--[[******************************************************
	割り込み(しないけど、一応。)
********************************************************]]
function Attack2_Interupt(ai, goal)	return false;end
