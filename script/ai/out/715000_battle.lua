-----------------------------------------------------------------------------------------------
--	�q���C���퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Heroine_715000_Battle, "heroine_715000Battle");

--local c801000_NormalR_Dist = 2.5			--�E��U���̓K���ԍ���
--local c801000_farDist = 15.0				--�����Ɣ��f���鋗��
--local c801000_nearDist = 4.0				--�߂��Ɣ��f���鋗��

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Heroine_715000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function heroine_715000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local playerDist = ai:GetDist(TARGET_LOCALPLAYER);		--���[�J���v���C���[�Ƃ̋������擾
local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q

local NormalR_Dist = 2.5					--�E��U���̓K���ԍ���
local eventNo = ai:GetEventRequest();		--�C�x���g���N�G�X�g�擾�@�X���b�g0

	--�C�x���g���N�G�X�g�i�X���b�g0��10�ԁj�����Ă�����
	if eventNo == 10 then
		--�v���C���[������������A�v���C���[�ɋ߂Â�
		if playerDist >= 2.5 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_LOCALPLAYER, 2.0, TARGET_SELF, true, -1 );
			
		else
			goal:AddSubGoal( GOAL_COMMON_Wait, 5.0,0,0,0,0)
		end
		
	--�C�x���g���N�G�X�g�����Ă��Ȃ�������A�������G�Ɍ�����
	else
		goal:AddSubGoal( GOAL_COMMON_Wait, 5.0,0,0,0,0)
	end
end


---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function heroine_715000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function heroine_715000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function heroine_715000Battle_Interupt(ai, goal)

return false;
end
