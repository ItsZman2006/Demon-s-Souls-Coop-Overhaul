-----------------------------------------------------------------------------------------------
--	�f�t�H���g�̎v�l���W�b�N
--	�����F�e�X�g�L�����Ȃǂɐݒ肵�Ă��������B
-----------------------------------------------------------------------------------------------
REGISTER_LOGIC_FUNC(LOGIC_ID_Default, "Default_Logic", "Default_Interupt");

-----------------------------------------------------------------------------------------------
--	�f�t�H���g�̎v�l���W�b�N
--	���̒��Ō��݂̏󋵂𔻕ʂ��A�g�p����S�[�����ЂƂ��肵�܂��B
-----------------------------------------------------------------------------------------------
function	Default_Logic(ai)

	if ai:IsSearchTarget(TARGET_ENE_0) == true then
		-- �G�������Ă�����퓬
		ai:AddTopGoal( GOAL_COMMON_Normal, -1, 0,0,0,0 );
		return;
	end;
	
	ai:AddTopGoal( GOAL_COMMON_WalkAround, -1, ai:GetDistParam(DIST_Far),0,0,0 );
	return;
end


-----------------------------------------------------------------------------------------------
--	�f�t�H���g�̊��荞�݃��W�b�N
--	���荞�ݔ�����s���ăS�[����ǉ����܂��B
-----------------------------------------------------------------------------------------------
function	Default_Interupt(ai, goal)
end