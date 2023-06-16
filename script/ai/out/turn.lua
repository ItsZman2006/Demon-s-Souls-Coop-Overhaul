--[[*******************************************************************************************
	ターゲット方向へ旋回
	旋回ターゲットの方向を見るまでその場で旋回し続けます。
	少しでも旋回ターゲットの方向を向けたら成功します。
	寿命が尽きたら失敗です。

	パラメータ0  旋回ターゲット
	パラメータ1  正面判定角度
	パラメータ2  なし
	パラメータ3	 なし
*********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_Turn, "Turn");

-- 更新間隔設定
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_Turn, 0.2, 0.5);
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_Turn, true);

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Turn, 0, "旋回ターゲット", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Turn, 1, "正面判定角度", 0);

--[[*****************************************************
	ゴール更新
*******************************************************]]
function Turn_Update(ai, goal)
	
	local turnTarget 	= goal:GetParam(0);		-- 旋回ターゲット
	local angle_range 	= goal:GetParam(1);		-- 正面判定角度
	
	--０以下の場合は、デフォルト値（１０度）を入れておく。
	if ( angle_range <= 0 ) then
		angle_range = 10;
	end
		
	-- ターゲットを向く
	ai:TurnTo( turnTarget );
	
	if ai:IsLookToTarget( angle_range) == true then
		-- ターゲット方向を見ていたら成功
		return GOAL_RESULT_Success;
	end
	
	return GOAL_RESULT_Continue;
end

--[[*********************
	起動・終了・割り込みなし。
***********************]]
function Turn_Activate(ai, goal)end
function Turn_Terminate(ai, goal)end
function Turn_Interupt(ai, goal)return false;end
