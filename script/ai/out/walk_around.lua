-----------------------------------------------------------------------------------------------
--	���낤��s��
--	�����F�����ʒu�𒆐S�ɂ��낤��Ƃ���s��
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_COMMON_WalkAround, "WalkAround");




---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function WalkAround_Activate(ai, goal)
	
	-- �p�����[�^�擾
	-- �G�ɔ������鋗��
	local attackDist = goal:GetParam(0);
	
	-- �������(0:�E���, 1:�����)
	local turnDir = ai:GetRandam_Int(0, 1);
	-- �����~�̔��a
	local dist = 1.5;	
	-- ������
	local walk = 1;	
	-- ����
	local life = 10.0;

	if turnDir == 0 then
		-- �E���
		
		-- �����ʒu�̑O�Ɉړ�
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, life, POINT_INITIAL, AI_DIR_TYPE_F, dist, TARGET_SELF, walk);
		-- �����ʒu�̉E�Ɉړ�
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, life, POINT_INITIAL, AI_DIR_TYPE_R, dist, TARGET_SELF, walk);
		-- �����ʒu�̌�Ɉړ�
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, life, POINT_INITIAL, AI_DIR_TYPE_B, dist, TARGET_SELF, walk);
		-- �����ʒu�̍��Ɉړ�
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, life, POINT_INITIAL, AI_DIR_TYPE_L, dist, TARGET_SELF, walk);
	else
		-- �����
		
		-- �����ʒu�̌�Ɉړ�
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, life, POINT_INITIAL, AI_DIR_TYPE_B, dist, TARGET_SELF, walk);
		-- �����ʒu�̍��Ɉړ�
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, life, POINT_INITIAL, AI_DIR_TYPE_L, dist, TARGET_SELF, walk);
		-- �����ʒu�̑O�Ɉړ�
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, life, POINT_INITIAL, AI_DIR_TYPE_F, dist, TARGET_SELF, walk);
		-- �����ʒu�̉E�Ɉړ�
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, life, POINT_INITIAL, AI_DIR_TYPE_R, dist, TARGET_SELF, walk);
	end

	-- �����ʒu�Ɉړ�
--	goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, life, POINT_INITIAL, AI_DIR_TYPE_CENTER, 1.0, TARGET_SELF, walk);
end


---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function WalkAround_Update(ai, goal)
	
	-- �p�����[�^�擾
	-- �G�ɔ������鋗��
	local attackDist = goal:GetParam(0);
	
	if ai:IsSearchTarget(TARGET_ENE_0) == true then
		if ai:GetDist(TARGET_ENE_0) < attackDist then
			return GOAL_RESULT_Failed;
		end
	end
	
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function WalkAround_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function WalkAround_Interupt(ai, goal)
	return false;
end
