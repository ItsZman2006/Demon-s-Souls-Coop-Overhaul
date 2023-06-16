--[[*******************************************************************************************
	�_�b�V���U���B


	�p�����[�^0  �ړ��Ώ�			�yType�z"		(POINT)
	�p�����[�^1  �U���J�n����		�ym�z		���͈͓̔��ɓ������琬��
	�p�����[�^2  �U��EzState�ԍ�
	�p�����[�^3  �K�[�hEzState�ԍ�

	�g�p��
	-- �^�[�Q�b�g0��10m�ȓ��܂ŃK�[�h�ړ�����
	goal:AddSubGoal( GOAL_COMMON_DashAttack, ����, TARGET_ENE_0, 10.0, NPC_ATK_NormalR, -1);
*********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_DashAttack, "DashAttack");

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashAttack, 0, "�ړ��ΏہyType�z", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashAttack, 1, "�U���J�n�����ym�z", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashAttack, 2, "�U��EzState�ԍ�", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashAttack, 3, "�K�[�hEzState�ԍ�", 0);

-- 
REGISTER_GOAL_NO_UPDATE(GOAL_COMMON_DashAttack, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_DashAttack, true);

--[[******************************************************
	�S�[���N��
********************************************************]]
function DashAttack_Activate(ai, goal)

	--�_�b�V���J�n�B
	ai:StartDash();
	
	--�܂��́A�ڋ߁B
	--	���̐ڋ߃S�[��������������A���̍U���S�[���ֈڂ�B
	
	local target 		= goal:GetParam(0);
	local arrive_range 	= goal:GetParam(1);
	local guard_ezno	= goal:GetParam(3);
	
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, target, arrive_range, TARGET_SELF, false, guard_ezno);

	
	--�U���B
	
	local attack_ezno	= goal:GetParam(2);
	goal:AddSubGoal(GOAL_COMMON_DashAttack_Attack, 10, target, attack_ezno);
	
	
end


--[[******************************************************
	�I���B
********************************************************]]
function DashAttack_Terminate(ai, goal) 

	--�_�b�V����߂�B
	ai:EndDash();

end

--[[******************************************************
	�X�V���Ȃ��A���荞�܂Ȃ��B
********************************************************]]
function DashAttack_Update(ai, goal, dT) return GOAL_RESULT_Continue; end
function DashAttack_Interupt(ai, goal)	return false; end


--[[************************************************************************************
	�_�b�V���U���B
		�U�����o���Ƃ����A�ړ����͂�����Ă��Ȃ��Ƒʖڂ݂����B
		�Ȃ̂ŁA�ړ��{�U�������B
		ai:MoveTo()������Ă���̂́A�U�����Ă��鎞�Ԃ��Z�����낤����A
		�p�X����������K�v�͖����Ɠ���ł̎��B
**************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_DashAttack_Attack, "DashAttack_Attack");
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashAttack_Attack, 0, "�ړ��ΏہyType�z", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashAttack_Attack, 1, "�U��EzState�ԍ�", 0);
REGISTER_GOAL_NO_UPDATE(GOAL_COMMON_DashAttack_Attack, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_DashAttack_Attack, true);

function DashAttack_Attack_Activate(ai, goal)
	local target 		= goal:GetParam(0);
	local attack_ezno	= goal:GetParam(1);
	ai:MoveTo(target, AI_DIR_TYPE_CENTER, 0, false);
	goal:AddSubGoal(GOAL_COMMON_Attack, 10, attack_ezno, target, DIST_None);
end
function DashAttack_Attack_Update(ai, goal)  return GOAL_RESULT_Continue; end
function DashAttack_Attack_Terminate(ai, goal)end
function DashAttack_Attack_Interupt(ai, goal) return false; end

