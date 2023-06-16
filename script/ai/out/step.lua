-----------------------------------------------------------------------------------------------
--	�X�e�b�v�ňړ����܂�
--	�ړ��ʂ̓A�j���[�V�����Ɉˑ����܂�
--	���s����ΕK�������Ɣ��肵�܂�
--
--	�p�����[�^0  EzState�ԍ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
--
--	�g�p��
--	-- 3700�̃X�e�b�v�ړ������s
--	goal:AddSubGoal(GOAL_COMMON_Step, ����, 3000, 0, 0, 0);
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_COMMON_Step, "Step");

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Step, 0, "EzState�ԍ�", 0);

-- �X�V�Ԋu�ݒ�
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_Step, 0, 0);

---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function Step_Activate(ai, goal)

	-- �p�����[�^�擾
	-- EzState�ԍ�
	local behaviorNo = goal:GetParam(0);

	-- �X�e�b�v�ړ�
	ai:SetAttackRequest(behaviorNo);

end


---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function Step_Update(ai, goal)

	-- �p�����[�^�擾
	-- EzState�ԍ�
	local behaviorNo = goal:GetParam(0);

	
	local bFinish = false;
	
	-- ���̘A���U�����\��
	if ai:IsEnableComboAttack() == true then
		bFinish = true;
	end
	
	-- �U���I����Ă��܂�����
	if ai:IsFinishAttack() == true then
		-- �A���U���Ȃ̂����玸�s�ɂ����ق��������̂��E�E�H
		bFinish = true;
	end
	
	-- �U���I������琬��
	if bFinish== true then
		return GOAL_RESULT_Success;
	end
	
	-- �U���A�j���J�n���Ă��Ȃ��Ƃ��������N�G�X�g����
	if ai:IsStartAttack() == false then
		-- �X�e�b�v�ړ�
		ai:SetAttackRequest(behaviorNo);
	end
	
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function Step_Terminate(ai, goal)
end


-- ���荞�݂Ȃ��錾
-- ���ꂪtrue�̏ꍇ�ɂ͊��荞�݂��Ă΂�Ȃ��̂Œ��ӂ��Ă��������B
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_Step, true);

---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function Step_Interupt(ai, goal)
	return false;
end
