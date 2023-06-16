--[[********************************************************************************************
	@goal	�������
	@brief	�w��ΏۂɌ������Đ���i���ۂɂ͍U���j�����s���܂��B
			�A�j���Đ����I������琬�����܂��B
			���łɃ^�[�Q�b�g���w��͈͊p�x���ɂ���ꍇ�ɂ�
			�A�j���Đ������ɏI�����܂��B
	
	@note	�����ōU���S�[��ver2���Ăяo���܂��B
	

	�p�����[�^0  EzState�ԍ�
	�p�����[�^1  �U���ΏہyType�z		�iTARGET�j
	�p�����[�^2  �A�j���Đ����Ȃ��p�x�i���S0�x�ō��E��0�`180�j

	�g�p��
	-- �^�[�Q�b�g0�����E90�x�ȓ��ɂ��Ȃ���΍s��3000�����s
	goal:AddSubGoal(GOAL_COMMON_SpecialTurn, ����, 3000, TARGET_ENE_0, 90);
**********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_SpecialTurn, "SpecialTurn");

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SpecialTurn, 0, "EzState�ԍ�", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SpecialTurn, 1, "�U���ΏہyType�z", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SpecialTurn, 2, "����p�x", 0);

-- 
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_SpecialTurn, 0, 0);	--���t���[��Update
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_SpecialTurn, true);	--���荞�݂��Ȃ��B

--[[******************************************************
	�S�[���N��
********************************************************]]
function SpecialTurn_Activate(ai, goal)

	local behaviorNo 	= goal:GetParam(0);	-- EzState�ԍ�
	local target 		= goal:GetParam(1);	-- �U���Ώ�
	local turnAng		= goal:GetParam(2);	-- �Ώۊp�x

	if ai:IsLookToTarget(target, turnAng) then
		-- �����Ă����̂ł����ɐ���
		goal:SetNumber(0, 1);
	else
		-- �T�u�S�[���ǉ�
		goal:AddSubGoal(GOAL_COMMON_Attack2, goal:GetLife(), behaviorNo, target, DIST_None, 0);
	end
end


--[[******************************************************
	�S�[���X�V
********************************************************]]
function SpecialTurn_Update(ai, goal) 
	if goal:GetNumber(0) == 1 then
		-- �����Ɍ����Ă����̂Ő���
		return GOAL_RESULT_Success;
	end
	return GOAL_RESULT_Continue;
end


--[[******************************************************
	�S�[���I���B
********************************************************]]
function SpecialTurn_Terminate(ai, goal) end


--[[******************************************************
	���荞��(���Ȃ����ǁA�ꉞ�B)
********************************************************]]
function SpecialTurn_Interupt(ai, goal)	return false;end
