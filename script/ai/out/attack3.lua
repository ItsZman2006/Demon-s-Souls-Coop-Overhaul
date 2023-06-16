--[[********************************************************************************************
	@goal	攻撃するver３
	@brief	必ず成功する攻撃。
	
	@note	ver1との違い。
			攻撃前旋回時間が指定できる。
	

	パラメータ0  EzState番号
	パラメータ1  攻撃対象【Type】		（TARGET）
	パラメータ2  成功距離【Type】		（DIST）
	パラメータ3　攻撃前旋回時間【秒】	（マイナスで、デフォルト旋回時間　1.5）
	パラメータ4　正面判定角度【度】		（マイナスで、デフォルト角度　　　10）
	パラメータ5　必ず成功するか？		（０以外で、必ず成功）

	使用例
	-- ターゲット0に対して、近距離の、行動3000を実行
	goal:AddSubGoal(GOAL_COMMON_Attack3, 寿命, 3000, TARGET_ENE_0, DIST_Near, -1, -1, 1);
**********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_Attack3, "Attack3");

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack3, 0, "EzState番号", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack3, 1, "攻撃対象【Type】", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack3, 2, "成功距離【Type】", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack3, 3, "攻撃前旋回時間【秒】", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack3, 4, "正面判定角度【度】", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack3, 5, "必ず成功するか？", 0);

-- 
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_Attack3, 0, 0);	--
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_Attack3, true);	--割り込みしない。

--[[******************************************************
	ゴール起動
********************************************************]]
function Attack3_Activate(ai, goal)

	local behaviorNo 	= goal:GetParam(0);	-- EzState番号
	local target 		= goal:GetParam(1);	-- 攻撃対象
	local turn_time		= goal:GetParam(3);	-- 攻撃前旋回時間。
	local angle			= goal:GetParam(4);	-- 角度。

	if (turn_time<0) then 	turn_time 	= 1.5; end
	if (angle<0) then 		angle 		= 10; end
	
	--変更された角度を保存しておく。
	goal:SetNumber(0, angle);

	--旋回あきらめタイマーをセット
	goal:SetTimer(0, turn_time);

	-- 旋回する
	ai:TurnTo(target);

	-- 旋回できたら攻撃
	if ( ai:IsLookToTarget(angle)) then
		ai:SetAttackRequest(behaviorNo);
	end
	
	-- チームに攻撃していることを通知
	goal:AddGoalScopedTeamRecord(COORDINATE_TYPE_Attack, target, 0.0);
	
end


--[[******************************************************
	ゴール更新
********************************************************]]
function Attack3_Update(ai, goal)

	local behaviorNo 	= goal:GetParam(0);		-- EzState番号
	local target 		= goal:GetParam(1);		-- 攻撃対象
	local distType 		= goal:GetParam(2);		-- 成功距離
	local angle			= goal:GetNumber(0);	-- 角度。
	local force_success	= goal:GetParam(5);		-- 必ず成功するか？

	-- 攻撃終わったら
	if ( ai:IsFinishAttack()) then
		local targetDist 	= ai:GetDist(target);
		local typeDist		= ai:GetDistParam(distType);
		
		if ( ai:IsHitAttack()) then
			-- 攻撃が当たったら成功
			return GOAL_RESULT_Success;
		elseif ( targetDist > typeDist) then
			-- 敵が成功距離外でも。。。
			if ( force_success==0 ) then
				return GOAL_RESULT_Failed;
			else
				return GOAL_RESULT_Success;
			end
		else
			-- 敵が成功距離内なら成功
			return GOAL_RESULT_Success;
		end
		
	end

	-- 攻撃アニメ開始していないときだけリクエストする
	if (ai:IsStartAttack() == false) then
		-- 旋回できたら攻撃
		if ( ai:IsLookToTarget( angle )) then
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
	終了・割り込み。
********************************************************]]
function Attack3_Terminate(ai, goal)end
function Attack3_Interupt(ai, goal) return false; end
