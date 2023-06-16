--[[*******************************************************************************************
	ArasiSensi602000の思考ロジック
	説明：
	
	●ai:SetNumber()使用状況
		０：
		１：
		２：
		３：Battle中？	
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_ArasiSensi602000, "ArasiSensi602000_Logic", "ArasiSensi602000_Interupt");

--[[************************************************************************
	ArasiSensi602000用の思考ロジック
**************************************************************************]]
function	ArasiSensi602000_Logic(ai)

	if( ai:IsBattleState() ) then
	
		--非戦闘時から戦闘時に最初に移行するとき。
		if ( 0==ai:GetNumber(3)) then
			ArasiSensi602000_OnShiftBattleMode(ai);
		end
		
		--戦闘中フラグを立てておく。
		ai:SetNumber(3, 1);
	
		--戦闘。
		ai:AddTopGoal( GOAL_ArasiSensi602000_Battle, -1);
	else
	
		--非戦闘行動。
		ai:SetNumber(3, 0);
		ai:AddTopGoal( GOAL_ArasiSensi602000_NonBattle, -1);
	end

end

--[[************************************************************************
	ロジック割り込み
**************************************************************************]]
function	ArasiSensi602000_Interupt(ai, goal)
end

--[[************************************************************************
	戦闘状態へ移行する時。
**************************************************************************]]
function	ArasiSensi602000_OnShiftBattleMode(ai)

	local rand_val		= ai:GetRandam_Int(0, 100);
	local idAction		= 3300;
	
	if ( rand_val<50 ) then
		idAction		= 3300;
	else
		idAction		= 3301;
	end
	
	ai:AddTopGoal(GOAL_COMMON_NonspinningAttack, 100, idAction, TARGET_ENE_0, DIST_None);
end



--[[************************************************************************************************]]
--[[************************************** 非戦闘ゴール ********************************************]]
--[[************************************************************************************************]]

--[[*******************************************************************************************
	ArasiSensi602000の思考ロジック
	説明：
*********************************************************************************************]]

REGISTER_GOAL(GOAL_ArasiSensi602000_NonBattle, "ArasiSensi602000NonBattle");
REGISTER_GOAL_NO_UPDATE( GOAL_ArasiSensi602000_NonBattle, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_ArasiSensi602000_NonBattle, true);

--[[************************************************************************
	起動。
**************************************************************************]]
function ArasiSensi602000NonBattle_Activate(ai, goal)

--[[■企画調整項目■]]
	
	local idThreatAction1	= 3000;
	local idThreatAction2	= 3004;
	local idThreatAction3	= 3005;
	
	local rate1	= 10;
	local rate2	= 50;
	local rate3	= 50;

	--ポイント移動時間[sec]。
	local POINT_MOVE_TIME_LENGTH	= 7;
	
--[[■企画調整項目■]]

	--ポイント移動。
	goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, POINT_MOVE_TIME_LENGTH, POINT_MOVE_POINT, AI_DIR_TYPE_CENTER, 3, TARGET_SELF, true);	

	--威嚇攻撃
local fate = ai:GetRandam_Float(0, 100);
	if fate <= 20 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 100, 3004, TARGET_NONE, DIST_None);
		
	elseif fate <=50 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 100, 3004, TARGET_NONE, DIST_None);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 100, 3005, TARGET_NONE, DIST_None);	
		
	elseif fate <=70 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 100, 3005, TARGET_NONE, DIST_None);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 100, 3005, TARGET_NONE, DIST_None);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 100, 3004, TARGET_NONE, DIST_None);
	end

end

--[[************************************************************************
	更新・終了・割り込みなし。
**************************************************************************]]
function ArasiSensi602000NonBattle_Update(ai, goal) return GOAL_RESULT_Continue; end
function ArasiSensi602000NonBattle_Terminate(ai, goal)end
function ArasiSensi602000NonBattle_Interupt(ai, goal) return false; end





