--[[*******************************************************************************************
	�K���E���B�������h�p�퓬
	�����F

	�p�����[�^0  �Ȃ�
	�p�����[�^1  �Ȃ�
	�p�����[�^2  �Ȃ�
	�p�����[�^3�@�Ȃ�
	
	��ai:SetNumber()�̎g�p�󋵁B
		�O�F0�őO�q�}�����[�h�A1�őދp���[�h�A2�Ń��[�v����q���[�h�B
		�P�F
		�Q�F
		�R�F
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_GalV816000, "GalV816000_Logic", "GalV816000_Interupt");

--[[*******************************************************
	���W�b�N�B
*********************************************************]]
function GalV816000_Logic(ai)

	--�C�x���g���N�G�X�g�O�Ԃ��O�ȊO�ŁA
	--�ދp���[�h�֑J��OK.
	if ( not(-1==ai:GetEventRequest()) ) then
		--�܂��A�O�q�}�����[�h�Ȃ�B
		if ( 0==ai:GetNumber(0) ) then
			--�ދp���[�h��
			ai:SetNumber(0, 1);
		end
	end

	
	--�s���I���B
	if (1==ai:GetNumber(0)) then
		
		--�ދp�B
		--	�퓬�����낤�����\���Ȃ��B
		ai:AddTopGoal(GOAL_GalV_816000_Battle_Retreat, -1);

	elseif (ai:IsBattleState()) then
	
		--�퓬��ԁB
		if ( 0==ai:GetNumber(0) ) then
			--�O�q�}���퓬�B
			ai:AddTopGoal(GOAL_GalV_816000_Battle_Forward, -1);
		else
			--���[�u����q�퓬�B
			ai:AddTopGoal(GOAL_GalV_816000_Battle_Guard, -1);
		end
		
	else
		--�퓬��Ԃɓ����Ă��Ȃ�����A��퓬�B
		ai:AddTopGoal(GOAL_GalV_816000_NonBattle, -1);
	end
end

--[[*******************************************************
	���荞�݁B
*********************************************************]]
function GalV816000_Interupt(ai, goal)
end


