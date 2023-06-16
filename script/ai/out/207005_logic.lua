--[[******************************************************************************************
	虜囚用の思考ロジック
	説明：腐敗人思考（210005）からコピー
********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_Ryosyu207005, "Ryosyu207005_Logic", "Ryosyu207005_Interupt");

--[[******************************************
	ロジック。
********************************************]]
function	Ryosyu207005_Logic(ai)

	--アクション前、間。
	local wait_time = ai:GetRandam_Float( 0.5, 2.5);
	ai:AddTopGoal( GOAL_COMMON_Wait, wait_time, TARGET_NONE);
	
	--まちアクション。
	ai:AddTopGoal( GOAL_COMMON_ComboAttack, 100, 3302, TARGET_NONE, DIST_None);

	local distToInipos = ai:GetDist(POINT_INITIAL);
	if (1<distToInipos) then
		--配置位置から遠い場合。
		ai:AddTopGoal(GOAL_COMMON_MoveToSomewhere, 10, POINT_INITIAL, AI_DIR_TYPE_CENTER, 0, TARGET_SELF, true);
	else
		--配置位置に近ければ、	
		--燭台に向く。
		local turn_time = ai:GetRandam_Float( 0.5, 2.5);
		ai:AddTopGoal(GOAL_COMMON_Turn, turn_time, POINT_EVENT, 10);
	end
	
end

--[[******************************************
	割り込み。
********************************************]]
function	Ryosyu207005_Interupt(ai, goal)
end



