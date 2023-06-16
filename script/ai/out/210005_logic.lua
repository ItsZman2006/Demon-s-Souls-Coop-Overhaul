--[[******************************************************************************************
	���s�r�g�p�̎v�l���W�b�N
	�����F
********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_Huhai210005, "Huhai210005_Logic", "Huhai210005_Interupt");

--[[******************************************
	���W�b�N�B
********************************************]]
function	Huhai210005_Logic(ai)

	--�A�N�V�����O�A�ԁB
	local wait_time = ai:GetRandam_Float( 0.5, 2.5);
	ai:AddTopGoal( GOAL_COMMON_Wait, wait_time, TARGET_NONE);
	
	--�܂��A�N�V�����B
	ai:AddTopGoal( GOAL_COMMON_ComboAttack, 100, 3301, TARGET_NONE, DIST_None);

	--���[�u���Ɍ����B
	local turn_time = ai:GetRandam_Float( 0.5, 2.5);
	ai:AddTopGoal(GOAL_COMMON_Turn, turn_time, TARGET_EVENT, 10);
	
end

--[[******************************************
	���荞�݁B
********************************************]]
function	Huhai210005_Interupt(ai, goal)
end



