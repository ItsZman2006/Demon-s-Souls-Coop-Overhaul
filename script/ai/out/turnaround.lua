--[[******************************************************************************************
	�w��^�[�Q�b�g�𒆐S�ɉ��ړ������ĉ�荞�����Ƃ���B
	�^�[�Q�b�g�̂��ĕ����E�w��p�x���ɓ���Ɛ����B

	���ړ��̕����͖ڕW�ʒu�ɑ΂��čŒZ�œ����ł�������Ɉړ����܂��B

	�p�����[�^0  �ړ��ΏہyType�z			TARGET_XXXX
	�p�����[�^1  �Ώۂ̕����yType�z			AI_DIR_TYPE_XXXX
	�p�����[�^2  �p�x�y�x�z
	�p�����[�^3  ������						(true�Afalse)
	�p�����[�^4  �����s���Ă������Ƃ��邩	(true, false)
	�p�����[�^5  �K�[�h�p��EzState�s��ID

	�g�p��
	-- �^�[�Q�b�g0�𒆐S�ɉ�荞��
	ai:AddTopGoal( GOAL_COMMON_TurnAround, -1, TARGET_ENE_0, AI_DIR_TYPE_B, 10, true, false, -1);
********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_TurnAround, "TurnAround");

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_TurnAround, 0, 	"�ړ��ΏہyType�z",		0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_TurnAround, 1, 	"�Ώۂ̕����yType�z",	0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_TurnAround, 2, 	"�p�x�y�x�z", 			0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_TurnAround, 3, 	"����?", 				0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_TurnAround, 4, 	"�����Ő����H", 		0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_TurnAround, 5, 	"�K�[�hEzState�ԍ�", 	0);

-- �X�V�Ԋu�ݒ�
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_TurnAround, 0.1, 0.2);


--[[***************************************************************************
	�N��
*****************************************************************************]]
function TurnAround_Activate(ai, goal)

	-- �p�����[�^�擾
	local targetType 	= goal:GetParam(0);	-- �ړ��Ώ�
	local targetDir		= goal:GetParam(1);	-- �Ώە���
	local bWalk 		= goal:GetParam(3);	-- ������
	local guardActionId = goal:GetParam(5);	-- �K�[�h���邩

	if guardActionId > 0 then
		-- �K�[�h�s��
		goal:AddSubGoal( GOAL_COMMON_Guard, goal:GetLife(), guardActionId, targetType, 0, 0);	
	end

	-- �^�[�Q�b�g������
	ai:TurnTo( targetType );
	
	--�ړ�����������B
	local move_dir = ai:GetTurnAroundOptimizedDirection( targetType, targetDir);

	-- ���E�ړ��ݒ�
	ai:SetMoveLROnly(true);
	
	-- �ړ��B
	ai:MoveTo( TARGET_SELF, move_dir, 10.0, bWalk );
	
	
	-- �`�[���ɉ��ړ����Ă��邱�Ƃ�ʒm
	if ( move_dir==AI_DIR_TYPE_L) then
		goal:AddGoalScopedTeamRecord(COORDINATE_TYPE_SideWalk_L, targetType, 0);
	elseif ( move_dir==AI_DIR_TYPE_R ) then
		goal:AddGoalScopedTeamRecord(COORDINATE_TYPE_SideWalk_R, targetType, 0);
	end
end


--[[***************************************************************************
	�X�V
*****************************************************************************]]
function TurnAround_Update(ai, goal, dT)

	-- �p�����[�^�擾
	local dirType		= goal:GetParam(1);	-- �Ώە���
	local turnAng 		= goal:GetParam(2);	-- �p�x
	local bLifeSucces 	= goal:GetParam(4);	-- �����������琬���Ƃ��邩
	local distRange		= 999;				--	�K���Ȓ������B

	-- �p�x����
	if ai:IsInsideTargetEx( targetType, TARGET_SELF, dirType, turnAng, distRange) then
		-- �w��p�x�������ړ����A����̕��������Ă���
		return GOAL_RESULT_Success;
	end
	
	-- �����s�����琬���ɂ���
	if bLifeSucces ~= 0.0 then
		if goal:GetLife() <= 0.0 then
			return GOAL_RESULT_Success;
		end
	end
	
	-- �ړ��ł��Ȃ��Ȃ��Ă�����A�I��������B
	if ( ai:CannotMove()) then
		return GOAL_RESULT_Success;
	end

	return GOAL_RESULT_Continue;
end

--[[***************************************************************************
	�I��
*****************************************************************************]]
function TurnAround_Terminate(ai, goal) end
--[[***************************************************************************
	���荞��
*****************************************************************************]]
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_TurnAround, true);
function TurnAround_Interupt(ai, goal) return false; end
