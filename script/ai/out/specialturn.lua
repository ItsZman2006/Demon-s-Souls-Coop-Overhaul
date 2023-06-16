--[[********************************************************************************************
	@goal	特殊旋回
	@brief	指定対象に向かって旋回（実際には攻撃）を実行します。
			アニメ再生が終わったら成功します。
			すでにターゲットが指定範囲角度内にいる場合には
			アニメ再生せずに終了します。
	
	@note	内部で攻撃ゴールver2を呼び出します。
	

	パラメータ0  EzState番号
	パラメータ1  攻撃対象【Type】		（TARGET）
	パラメータ2  アニメ再生しない角度（中心0度で左右に0～180）

	使用例
	-- ターゲット0が左右90度以内にいなければ行動3000を実行
	goal:AddSubGoal(GOAL_COMMON_SpecialTurn, 寿命, 3000, TARGET_ENE_0, 90);
**********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_SpecialTurn, "SpecialTurn");

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SpecialTurn, 0, "EzState番号", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SpecialTurn, 1, "攻撃対象【Type】", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SpecialTurn, 2, "旋回角度", 0);

-- 
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_SpecialTurn, 0, 0);	--毎フレームUpdate
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_SpecialTurn, true);	--割り込みしない。

--[[******************************************************
	ゴール起動
********************************************************]]
function SpecialTurn_Activate(ai, goal)

	local behaviorNo 	= goal:GetParam(0);	-- EzState番号
	local target 		= goal:GetParam(1);	-- 攻撃対象
	local turnAng		= goal:GetParam(2);	-- 対象角度

	if ai:IsLookToTarget(target, turnAng) then
		-- 向いていたのですぐに成功
		goal:SetNumber(0, 1);
	else
		-- サブゴール追加
		goal:AddSubGoal(GOAL_COMMON_Attack2, goal:GetLife(), behaviorNo, target, DIST_None, 0);
	end
end


--[[******************************************************
	ゴール更新
********************************************************]]
function SpecialTurn_Update(ai, goal) 
	if goal:GetNumber(0) == 1 then
		-- すぐに向いていたので成功
		return GOAL_RESULT_Success;
	end
	return GOAL_RESULT_Continue;
end


--[[******************************************************
	ゴール終了。
********************************************************]]
function SpecialTurn_Terminate(ai, goal) end


--[[******************************************************
	割り込み(しないけど、一応。)
********************************************************]]
function SpecialTurn_Interupt(ai, goal)	return false;end
