--[[*******************************************************************************************
	�����B

	�p�����[�^0  �^�[�Q�b�g
	�p�����[�^1  �����J�nEzState�ԍ�
	�p�����[�^2  ������~EzState�ԍ�
	�p�����[�^3	 �Ȃ�
*********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_Fall, "Fall");

-- �X�V�Ԋu�ݒ�
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_Fall, 0.1, 0.2);
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_Fall, true);

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Fall, 0, "�^�[�Q�b�g�yType�z", 	0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Fall, 1, "�����J�nEzState�ԍ�", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Fall, 2, "������~EzState�ԍ�", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Fall, 3, "������~�}�[�W��[m]", 0);


--[[*****************************************************
	�S�[���J�n�B
*******************************************************]]
function Fall_Activate(ai, goal)
	
	local target		= goal:GetParam(0);
	local ezFallID		= goal:GetParam(1);
	local height_dist 	= ai:GetDistYSigned(target);
	
	if ( height_dist<=0 ) then
		--�����Ƀ^�[�Q�b�g����������A�����B
		ai:SetAttackRequest(ezFallID);
	end

end

--[[*****************************************************
	�S�[���X�V
*******************************************************]]
function Fall_Update(ai, goal)
	
	local target		= goal:GetParam(0);
	local ezFallID		= goal:GetParam(1);
	local margin		= goal:GetParam(3);
	local height_dist 	= ai:GetDistYSigned(target);
	
	if ( margin<height_dist ) then
		--Terminate�ŗ�����~�B
		return GOAL_RESULT_Success;
	else
		--�����Ƀ^�[�Q�b�g����������A�����B
		ai:SetAttackRequest(ezFallID);
	end
	
	return GOAL_RESULT_Continue;
end

--[[*****************************************************
	�S�[���I���B
*******************************************************]]
function Fall_Terminate(ai, goal)

	--������~
	local ezStopID		= goal:GetParam(2);
	ai:SetAttackRequest(ezStopID);
	
end

--[[*********************
	���荞�݂Ȃ��B
***********************]]
function Fall_Interupt(ai, goal)return false;end
