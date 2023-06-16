--[[********************************************************************************************
	@goal	�U������ver2
	@brief	�w��ΏۂɌ������čU�������s���܂��B
			�U�����I������i�K�ŁA�G���������ɂ����ꍇ�ɐ������A
			�G������Ă��܂����ꍇ�ɂ͎��s�Ƃ��܂��B
	
	@note	ver1�Ƃ̈Ⴂ�B
			�U���O���񎞊Ԃ��w��ł���B
	

	�p�����[�^0  EzState�ԍ�
	�p�����[�^1  �U���ΏہyType�z		�iTARGET�j
	�p�����[�^2  ���������yType�z		�iDIST�j
	�p�����[�^3�@�U���O���񎞊ԁy�b�z	�i�}�C�i�X�ŁA�f�t�H���g���񎞊ԁj

	�g�p��
	-- �^�[�Q�b�g0�ɑ΂��āA�ߋ����́A�s��3000�����s
	goal:AddSubGoal(GOAL_COMMON_Attack2, ����, 3000, TARGET_ENE_0, DIST_Near, 0);
**********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_Attack2, "Attack2");

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack2, 0, "EzState�ԍ�", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack2, 1, "�U���ΏہyType�z", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack2, 2, "���������yType�z", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack2, 3, "�U���O���񎞊ԁy�b�z", 0);

-- 
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_Attack2, 0, 0);	--���t���[��Update
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_Attack2, true);	--���荞�݂��Ȃ��B

--[[******************************************************
	�S�[���N��
********************************************************]]
function Attack2_Activate(ai, goal)

	local behaviorNo 	= goal:GetParam(0);	-- EzState�ԍ�
	local target 		= goal:GetParam(1);	-- �U���Ώ�
	local turn_time		= goal:GetParam(3);	-- �U���O���񎞊ԁB

	if (turn_time<0) then
		turn_time = 1.5;
	end

	--���񂠂���߃^�C�}�[���Z�b�g
	goal:SetTimer(0, turn_time);

	-- ���񂷂�
	ai:TurnTo(target);
	
	--��O�̈ړ��S�[���̖ڕW�ʒu���Đݒ�B
	--		�ړ��S�[����Terminate()���Ɉړ��悪���Z�b�g����A
	--		���̒���̍U���n�S�[���ňړ���ݒ肵�Ȃ����߁A
	--		�A�N�V�������n�܂�܂ł̎��ԁA�ړ����j���[�g������ԂɂȂ�B
	--		���̂��߁A�ҋ@�A�j�������܂�܂��B���̎��Ԃ��Z����ΒZ���قǁA
	--		�A�j������񂾂悤�Ɍ����s���R�B
	--		���͂��̑Ή��Bhasem 08/9/18
	ai:MoveToLastTargetPosition();

	-- ����ł�����U��
	if ai:IsLookToTarget() == true then
		ai:SetAttackRequest(behaviorNo);
	end
	
	-- �`�[���ɍU�����Ă��邱�Ƃ�ʒm
	goal:AddGoalScopedTeamRecord(COORDINATE_TYPE_Attack, target, 0.0);
	
end


--[[******************************************************
	�S�[���X�V
********************************************************]]
function Attack2_Update(ai, goal)

	local behaviorNo 	= goal:GetParam(0);	-- EzState�ԍ�
	local target 		= goal:GetParam(1);	-- �U���Ώ�
	local distType 		= goal:GetParam(2);	-- ��������

	-- �U���I�������
	if ( ai:IsFinishAttack()) then
		local targetDist 	= ai:GetDist(target);
		local typeDist		= ai:GetDistParam(distType);
		
		if ( ai:IsHitAttack()) then
			-- �U�������������琬��
			return GOAL_RESULT_Success;
		elseif ( targetDist > typeDist) then
			-- �G�����������O�Ȃ玸�s	
			return GOAL_RESULT_Failed;
		else
			-- �G�������������Ȃ琬��
			return GOAL_RESULT_Success;
		end
		
	end

	-- �U���A�j���J�n���Ă��Ȃ��Ƃ��������N�G�X�g����
	if ai:IsStartAttack() == false then
		-- ����ł�����U��
		if ( ai:IsLookToTarget())then
			ai:SetAttackRequest(behaviorNo);
			
		-- ������߃^�C�}�[���[���ɂȂ�����U��
		elseif (goal:IsFinishTimer(0)) then
			ai:SetAttackRequest(behaviorNo);
		end
	end

	-- ���񂷂�
	ai:TurnTo(target);
	
	return GOAL_RESULT_Continue;
end


--[[******************************************************
	�S�[���I���B
********************************************************]]
function Attack2_Terminate(ai, goal)
end


--[[******************************************************
	���荞��(���Ȃ����ǁA�ꉞ�B)
********************************************************]]
function Attack2_Interupt(ai, goal)	return false;end
