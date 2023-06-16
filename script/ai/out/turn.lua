--[[*******************************************************************************************
	�^�[�Q�b�g�����֐���
	����^�[�Q�b�g�̕���������܂ł��̏�Ő��񂵑����܂��B
	�����ł�����^�[�Q�b�g�̕������������琬�����܂��B
	�������s�����玸�s�ł��B

	�p�����[�^0  ����^�[�Q�b�g
	�p�����[�^1  ���ʔ���p�x
	�p�����[�^2  �Ȃ�
	�p�����[�^3	 �Ȃ�
*********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_Turn, "Turn");

-- �X�V�Ԋu�ݒ�
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_Turn, 0.2, 0.5);
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_Turn, true);

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Turn, 0, "����^�[�Q�b�g", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Turn, 1, "���ʔ���p�x", 0);

--[[*****************************************************
	�S�[���X�V
*******************************************************]]
function Turn_Update(ai, goal)
	
	local turnTarget 	= goal:GetParam(0);		-- ����^�[�Q�b�g
	local angle_range 	= goal:GetParam(1);		-- ���ʔ���p�x
	
	--�O�ȉ��̏ꍇ�́A�f�t�H���g�l�i�P�O�x�j�����Ă����B
	if ( angle_range <= 0 ) then
		angle_range = 10;
	end
		
	-- �^�[�Q�b�g������
	ai:TurnTo( turnTarget );
	
	if ai:IsLookToTarget( angle_range) == true then
		-- �^�[�Q�b�g���������Ă����琬��
		return GOAL_RESULT_Success;
	end
	
	return GOAL_RESULT_Continue;
end

--[[*********************
	�N���E�I���E���荞�݂Ȃ��B
***********************]]
function Turn_Activate(ai, goal)end
function Turn_Terminate(ai, goal)end
function Turn_Interupt(ai, goal)return false;end
