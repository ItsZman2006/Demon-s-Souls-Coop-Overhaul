-----------------------------------------------------------------------------------------------
--	�ˌ�����
--	�w��^�[�Q�b�g�ɑ΂��āA�ړ��ʂ��������U���A�j���œˌ����܂�
--	��莞�ԍU���������邩�A�U�������������ꍇ�ɐ������܂��B
--	��苗���A�G������Ă��܂����ꍇ�ɂ͎��s�Ƃ��܂��B
--
--	�p�����[�^0  EzState�ԍ�
--	�p�����[�^1  �U���ΏہyType�z					�iTARGET�j
--	�p�����[�^2  ���������y���z
--	�p�����[�^3�@�U�������������琬���Ƃ݂Ȃ���		�itrue�Afalse�j
--
--	�g�p��
--	-- �^�[�Q�b�g0�ɑ΂��āA�ߋ����́A�s��3000�����s�B
--	-- ���������琬���B�Q�T�����ꂽ�玸�s�B
--	goal:AddSubGoal(GOAL_COMMON_ContinueAttack, ����, 3000, TARGET_ENE_0, 25, true);
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_COMMON_ContinueAttack, "ContinueAttack");

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ContinueAttack, 0, "EzState�ԍ�", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ContinueAttack, 1, "�U���ΏہyType�z", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ContinueAttack, 2, "���������y���z", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ContinueAttack, 3, "���������琬���H", 0);

---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function ContinueAttack_Activate(ai, goal)
	-- EzState�ԍ�
	local behaviorNo = goal:GetParam(0);
	-- �U���Ώ�
	local target = goal:GetParam(1)
	
	-- ���񂵂Ȃ���U������
	ai:TurnTo(target);
	ai:SetAttackRequest(behaviorNo);

	-- �`�[���ɍU�����Ă��邱�Ƃ�ʒm
	goal:AddGoalScopedTeamRecord(COORDINATE_TYPE_Attack, target, 0.0);
	
end


---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function ContinueAttack_Update(ai, goal)
	-- EzState�ԍ�
	local behaviorNo = goal:GetParam(0);
	-- �U���Ώ�
	local target = goal:GetParam(1)
	-- ��������
	local distType = goal:GetParam(2);
	-- ���������琬���H
	local successType = goal:GetParam(3);
	
	-- �^�[�Q�b�g�Ƃ̋���
	local targetDist = ai:GetDist(target);
	
	
	-- �U�������������ꂽ�玸�s
	if targetDist >= distType then
		return GOAL_RESULT_Failed;
		
		--�������s�����琬��
	elseif goal:GetLife() <= 0.0 then
		return GOAL_RESULT_Success;
		
		--���������琬���i�ݒ肳��Ă���΁j
	elseif successType == true then
		if ai:IsHitAttack() == true then
			return GOAL_RESULT_Success;
		end
	end
	
	
	-- ���񂵂Ȃ���U������
	ai:TurnTo(target);
	ai:SetAttackRequest(behaviorNo);

	
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function ContinueAttack_Terminate(ai, goal)
end


-- ���荞�݂Ȃ��錾
-- ���ꂪtrue�̏ꍇ�ɂ͊��荞�݂��Ă΂�Ȃ��̂Œ��ӂ��Ă��������B
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ContinueAttack, true);

---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function ContinueAttack_Interupt(ai, goal)
	return false;
end
