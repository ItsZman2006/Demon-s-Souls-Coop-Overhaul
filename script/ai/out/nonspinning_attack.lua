-----------------------------------------------------------------------------------------------
--	���񂹂��ɍU������
--	������ς����Ɏw��^�[�Q�b�g�ɑ΂��čU�������s���܂��B
--	�U�����I������i�K�ŁA�G���������ɂ����ꍇ�ɐ������A
--	�G������Ă��܂����ꍇ�ɂ͎��s�Ƃ��܂��B
--
--	�p�����[�^0  EzState�ԍ�
--	�p�����[�^1  �U���ΏہyType�z	�iTARGET�j
--	�p�����[�^2  ���������yType�z	�iDIST�j
--	�p�����[�^3�@�Ȃ�
--
--	�g�p��
--	-- �^�[�Q�b�g0�ɑ΂��āA�ߋ����́A�s��3000�����s
--	goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, ����, 3000, TARGET_ENE_0, DIST_Near, 0);
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_COMMON_NonspinningAttack, "NonspinningAttack");

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningAttack, 0, "EzState�ԍ�", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningAttack, 1, "�U���ΏہyType�z", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningAttack, 2, "���������yType�z", 0);

---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function NonspinningAttack_Activate(ai, goal)

	-- �p�����[�^�擾
	-- EzState�ԍ�
	local behaviorNo = goal:GetParam(0);
	-- �U���Ώ�
	local target = goal:GetParam(1)

	-- ���񂷂�
--	ai:TurnTo(target);

--	if ai:IsLookToTarget() == true then
		-- �U������
		ai:SetAttackRequest(behaviorNo);
--	end

	-- �`�[���ɍU�����Ă��邱�Ƃ�ʒm
	goal:AddGoalScopedTeamRecord(COORDINATE_TYPE_Attack, target, 0.0);

end


---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function NonspinningAttack_Update(ai, goal)

	-- �p�����[�^�擾
	-- EzState�ԍ�
	local behaviorNo = goal:GetParam(0);
	-- �U���Ώ�
	local target = goal:GetParam(1);
	-- ��������
	local distType = goal:GetParam(2);

	-- �U���I�������I��
	if ai:IsFinishAttack() == true then
		local targetDist = ai:GetDist(target);
		
		-- �U�������������琬��
		if ai:IsHitAttack() == true then
			return GOAL_RESULT_Success;
			
		-- �G�����������O�Ȃ玸�s	
		elseif targetDist > ai:GetDistParam(distType) then
			return GOAL_RESULT_Failed;
			
		-- �G�������������Ȃ琬��	
		else
			return GOAL_RESULT_Success;
		end
--		return GOAL_RESULT_Success;
	end
	
	-- �U���A�j���J�n���Ă��Ȃ��Ƃ��������N�G�X�g����
	if ai:IsStartAttack() == false then
		-- �U������
		ai:SetAttackRequest(behaviorNo);
	end
	
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function NonspinningAttack_Terminate(ai, goal)
end


-- ���荞�݂Ȃ��錾
-- ���ꂪtrue�̏ꍇ�ɂ͊��荞�݂��Ă΂�Ȃ��̂Œ��ӂ��Ă��������B
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_NonspinningAttack, true);

---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function NonspinningAttack_Interupt(ai, goal)
	return false;
end
