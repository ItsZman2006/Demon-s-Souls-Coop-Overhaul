--[[*******************************************************************************************
	�^�[�Q�b�g�̎w��͈͓��ɋ߂Â�
	�w��͈͂ɋ߂Â���ΐ����B


	�p�����[�^0  �ړ��ΏہyType�z		(POINT)
	�p�����[�^1  ���B���苗���ym�z		���͈͓̔��ɓ������琬��
	�p�����[�^2  ����ΏہyType�z		(TARGET)
	�p�����[�^3  ������					(true�Afalse)
	�p�����[�^4  �K�[�hEzState�ԍ�

	�g�p��
	-- �^�[�Q�b�g0��10m�ȓ��܂ŃK�[�h�ړ�����
	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, ����, TARGET_ENE_0, 10.0, TARGET_ENE_0, true, 6000 );
*********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_ApproachTarget, "ApproachTarget");

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 0, "�ړ��ΏہyType�z", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 1, "���B���苗���ym�z", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 2, "����ΏہyType�z", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 3, "����?", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 4, "�K�[�hEzState�ԍ�", 0);

-- 
REGISTER_GOAL_NO_UPDATE(GOAL_COMMON_ApproachTarget, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ApproachTarget, true);

--[[******************************************************
	�S�[���N��
********************************************************]]
function ApproachTarget_Activate(ai, goal)

	-- �p�����[�^�擾
	local targetType 	= goal:GetParam(0);	-- �ړ��Ώ�
	local range 		= goal:GetParam(1);	-- ���B���苗��
	local turnTarget 	= goal:GetParam(2);	-- ����Ώ�
	local bWalk 		= goal:GetParam(3);	-- ������
	local guardActionId = goal:GetParam(4);	-- �K�[�h���邩
	
	local life_time		= goal:GetLife();
	
	-- �ړ��T�u�S�[��
	goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, life_time, 
						targetType, 
						AI_DIR_TYPE_CENTER,
						range,
						turnTarget,
						bWalk);
	

	if guardActionId > 0 then
	
		-- �������łɓ��������ɂ���ꍇ�́A�K�[�h���Ȃ��B
		local targetDist = ai:GetDist(targetType);
		if (range < targetDist) then
			-- �K�[�h�s��
			ai:DoEzAction( life_time, guardActionId);
		end
	end
end

--[[******************************************************
	�X�V���Ȃ��A���荞�܂Ȃ��B�S�[���I���ŉ������Ȃ��B
********************************************************]]
function ApproachTarget_Update(ai, goal, dT)end
function ApproachTarget_Terminate(ai, goal) end
function ApproachTarget_Interupt(ai, goal)	return false; end
