--[[******************************************************************************************
	�����p�̎v�l���W�b�N
	�����F���s�l�v�l�i210005�j����R�s�[
********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_Ryosyu207005, "Ryosyu207005_Logic", "Ryosyu207005_Interupt");

--[[******************************************
	���W�b�N�B
********************************************]]
function	Ryosyu207005_Logic(ai)

	--�A�N�V�����O�A�ԁB
	local wait_time = ai:GetRandam_Float( 0.5, 2.5);
	ai:AddTopGoal( GOAL_COMMON_Wait, wait_time, TARGET_NONE);
	
	--�܂��A�N�V�����B
	ai:AddTopGoal( GOAL_COMMON_ComboAttack, 100, 3302, TARGET_NONE, DIST_None);

	local distToInipos = ai:GetDist(POINT_INITIAL);
	if (1<distToInipos) then
		--�z�u�ʒu���牓���ꍇ�B
		ai:AddTopGoal(GOAL_COMMON_MoveToSomewhere, 10, POINT_INITIAL, AI_DIR_TYPE_CENTER, 0, TARGET_SELF, true);
	else
		--�z�u�ʒu�ɋ߂���΁A	
		--�C��Ɍ����B
		local turn_time = ai:GetRandam_Float( 0.5, 2.5);
		ai:AddTopGoal(GOAL_COMMON_Turn, turn_time, POINT_EVENT, 10);
	end
	
end

--[[******************************************
	���荞�݁B
********************************************]]
function	Ryosyu207005_Interupt(ai, goal)
end



