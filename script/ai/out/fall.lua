--[[*******************************************************************************************
	落下。

	パラメータ0  ターゲット
	パラメータ1  落下開始EzState番号
	パラメータ2  落下停止EzState番号
	パラメータ3	 なし
*********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_Fall, "Fall");

-- 更新間隔設定
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_Fall, 0.1, 0.2);
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_Fall, true);

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Fall, 0, "ターゲット【Type】", 	0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Fall, 1, "落下開始EzState番号", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Fall, 2, "落下停止EzState番号", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Fall, 3, "落下停止マージン[m]", 0);


--[[*****************************************************
	ゴール開始。
*******************************************************]]
function Fall_Activate(ai, goal)
	
	local target		= goal:GetParam(0);
	local ezFallID		= goal:GetParam(1);
	local height_dist 	= ai:GetDistYSigned(target);
	
	if ( height_dist<=0 ) then
		--下方にターゲットがあったら、落下。
		ai:SetAttackRequest(ezFallID);
	end

end

--[[*****************************************************
	ゴール更新
*******************************************************]]
function Fall_Update(ai, goal)
	
	local target		= goal:GetParam(0);
	local ezFallID		= goal:GetParam(1);
	local margin		= goal:GetParam(3);
	local height_dist 	= ai:GetDistYSigned(target);
	
	if ( margin<height_dist ) then
		--Terminateで落下停止。
		return GOAL_RESULT_Success;
	else
		--下方にターゲットがあったら、落下。
		ai:SetAttackRequest(ezFallID);
	end
	
	return GOAL_RESULT_Continue;
end

--[[*****************************************************
	ゴール終了。
*******************************************************]]
function Fall_Terminate(ai, goal)

	--落下停止
	local ezStopID		= goal:GetParam(2);
	ai:SetAttackRequest(ezStopID);
	
end

--[[*********************
	割り込みなし。
***********************]]
function Fall_Interupt(ai, goal)return false;end
