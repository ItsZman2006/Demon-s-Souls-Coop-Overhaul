--[[******************************************************************************************
	腐敗ビト用の思考ロジック
	説明：
********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_Huhai210005, "Huhai210005_Logic", "Huhai210005_Interupt");

--[[******************************************
	ロジック。
********************************************]]
function	Huhai210005_Logic(ai)

	--アクション前、間。
	local wait_time = ai:GetRandam_Float( 0.5, 2.5);
	ai:AddTopGoal( GOAL_COMMON_Wait, wait_time, TARGET_NONE);
	
	--まちアクション。
	ai:AddTopGoal( GOAL_COMMON_ComboAttack, 100, 3301, TARGET_NONE, DIST_None);

	--リーブラに向く。
	local turn_time = ai:GetRandam_Float( 0.5, 2.5);
	ai:AddTopGoal(GOAL_COMMON_Turn, turn_time, TARGET_EVENT, 10);
	
end

--[[******************************************
	割り込み。
********************************************]]
function	Huhai210005_Interupt(ai, goal)
end



