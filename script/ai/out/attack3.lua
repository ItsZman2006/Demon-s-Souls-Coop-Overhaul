--[[********************************************************************************************
	@goal	�U������ver�R
	@brief	�K����������U���B
	
	@note	ver1�Ƃ̈Ⴂ�B
			�U���O���񎞊Ԃ��w��ł���B
	

	�p�����[�^0  EzState�ԍ�
	�p�����[�^1  �U���ΏہyType�z		�iTARGET�j
	�p�����[�^2  ���������yType�z		�iDIST�j
	�p�����[�^3�@�U���O���񎞊ԁy�b�z	�i�}�C�i�X�ŁA�f�t�H���g���񎞊ԁ@1.5�j
	�p�����[�^4�@���ʔ���p�x�y�x�z		�i�}�C�i�X�ŁA�f�t�H���g�p�x�@�@�@10�j
	�p�����[�^5�@�K���������邩�H		�i�O�ȊO�ŁA�K�������j

	�g�p��
	-- �^�[�Q�b�g0�ɑ΂��āA�ߋ����́A�s��3000�����s
	goal:AddSubGoal(GOAL_COMMON_Attack3, ����, 3000, TARGET_ENE_0, DIST_Near, -1, -1, 1);
**********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_Attack3, "Attack3");

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack3, 0, "EzState�ԍ�", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack3, 1, "�U���ΏہyType�z", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack3, 2, "���������yType�z", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack3, 3, "�U���O���񎞊ԁy�b�z", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack3, 4, "���ʔ���p�x�y�x�z", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack3, 5, "�K���������邩�H", 0);

-- 
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_Attack3, 0, 0);	--
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_Attack3, true);	--���荞�݂��Ȃ��B

--[[******************************************************
	�S�[���N��
********************************************************]]
function Attack3_Activate(ai, goal)

	local behaviorNo 	= goal:GetParam(0);	-- EzState�ԍ�
	local target 		= goal:GetParam(1);	-- �U���Ώ�
	local turn_time		= goal:GetParam(3);	-- �U���O���񎞊ԁB
	local angle			= goal:GetParam(4);	-- �p�x�B

	if (turn_time<0) then 	turn_time 	= 1.5; end
	if (angle<0) then 		angle 		= 10; end
	
	--�ύX���ꂽ�p�x��ۑ����Ă����B
	goal:SetNumber(0, angle);

	--���񂠂���߃^�C�}�[���Z�b�g
	goal:SetTimer(0, turn_time);

	-- ���񂷂�
	ai:TurnTo(target);

	-- ����ł�����U��
	if ( ai:IsLookToTarget(angle)) then
		ai:SetAttackRequest(behaviorNo);
	end
	
	-- �`�[���ɍU�����Ă��邱�Ƃ�ʒm
	goal:AddGoalScopedTeamRecord(COORDINATE_TYPE_Attack, target, 0.0);
	
end


--[[******************************************************
	�S�[���X�V
********************************************************]]
function Attack3_Update(ai, goal)

	local behaviorNo 	= goal:GetParam(0);		-- EzState�ԍ�
	local target 		= goal:GetParam(1);		-- �U���Ώ�
	local distType 		= goal:GetParam(2);		-- ��������
	local angle			= goal:GetNumber(0);	-- �p�x�B
	local force_success	= goal:GetParam(5);		-- �K���������邩�H

	-- �U���I�������
	if ( ai:IsFinishAttack()) then
		local targetDist 	= ai:GetDist(target);
		local typeDist		= ai:GetDistParam(distType);
		
		if ( ai:IsHitAttack()) then
			-- �U�������������琬��
			return GOAL_RESULT_Success;
		elseif ( targetDist > typeDist) then
			-- �G�����������O�ł��B�B�B
			if ( force_success==0 ) then
				return GOAL_RESULT_Failed;
			else
				return GOAL_RESULT_Success;
			end
		else
			-- �G�������������Ȃ琬��
			return GOAL_RESULT_Success;
		end
		
	end

	-- �U���A�j���J�n���Ă��Ȃ��Ƃ��������N�G�X�g����
	if (ai:IsStartAttack() == false) then
		-- ����ł�����U��
		if ( ai:IsLookToTarget( angle )) then
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
	�I���E���荞�݁B
********************************************************]]
function Attack3_Terminate(ai, goal)end
function Attack3_Interupt(ai, goal) return false; end
