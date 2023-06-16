-----------------------------------------------------------------------------------------------
--	�ʏ�s��
--	�����F�Ƃ肠�����f�t�H���g�Őݒ肷��s���ł��B
--		  ��ʂ�̍s���������ۂɎg�p���Ă��������B
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3  �Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_COMMON_Normal, "Normal");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_COMMON_Normal, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function Normal_Activate(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);
	--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)
	--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)
	--�m������Ŏg�p����^���̐����@���̂Q


--���퓬�s���p�p�����[�^
local trigDistNear				=	2.0
	--���������y�߁z
local trigDistMid				=	4.0
	--���������y���z
local trigDistFar				=	0
	--���������y���z
	
local ezsNoNear					=	3000
	--ezstate�ԍ��y�ߋ����s���z
local ezsNoMid					=	3000
	--ezstate�ԍ��y�������s���z
local ezsNoFar					=	3000
	--ezstate�ԍ��y�������s���z
	
local moveDistNear				=	3.0
	--���E�����y�߁����z
local moveDistMid				=	1.0
	--�ڋߋ����y�����߁z
local moveDistFar				=	3.0
	--�ڋߋ����y�������z

local movePerNear				=	20
	--���E�m���y�߁����z
local movePerMid				=	30
	--�ڋߊm���y�����߁z
local movePerFar				=	40
	--�ڋߊm���y�������z


local maaiDistNear				=	1.5
	--�ԍ��������y�߁z
local maaiDistMid				=	3.5
	--�ԍ��������y���z
local maaiDistFar				=	5.5
	--�ԍ��������y���z

local maaiPerNear				=	40
	--�ԍ����m���y�߁z
local maaiPerMid				=	30
	--�ԍ����m���y���z
local maaiPerFar				=	20
	--�ԍ����m���y���z

	
--���U���͈͊O�̍s���p�p�����[�^
local attActDist				=	6.0
	--�U���s�������鋗��
	
local trigDistDash				=	0
	--�ڋ߂̏��������y�_�b�V���z
local trigDistWalk				=	9.0
	--�ڋ߂̏��������y���s�z
	
local moveDistDash				=	7.0
	--�ڋߋ����y�_�b�V���z
local moveDistWalk				=	3.0
	--�ڋߋ����y���s�z
	

	--�G�^�[�Q�b�g���U���͈͓��ɂ���Ȃ�
	if targetDist <= attActDist then
		--�ߋ����s��
		if targetDist < trigDistNear then
			--���E
			if fate <= movePerNear then
				goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 5.0 , TARGET_ENE_0, AI_DIR_TYPE_CENTER, moveDistNear, TARGET_ENE_0, true);
				
			--�A�N�V����
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, ezsNoNear, TARGET_ENE_0, DIST_Near, 0);
				if fate2 <= maaiPerNear then
					goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 5.0 , TARGET_ENE_0, AI_DIR_TYPE_CENTER, maaiDistNear, TARGET_ENE_0, true);
				end
			end
		--�������s��	
		elseif targetDist < trigDistMid then
			--�ڋ�
			if fate <= movePerMid then
				goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 5.0 , TARGET_ENE_0, AI_DIR_TYPE_CENTER, moveDistMid, TARGET_ENE_0, true);
				
			--�A�N�V����
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, ezsNoMid, TARGET_ENE_0, DIST_Near, 0);
				if fate2 <= maaiPerMid then
					goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 5.0 , TARGET_ENE_0, AI_DIR_TYPE_CENTER, maaiDistMid, TARGET_ENE_0, true);
				end
			end
			
		--�������s��
		else
			--�ڋ�
			if fate <= movePerFar then
				goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 5.0 , TARGET_ENE_0, AI_DIR_TYPE_CENTER, moveDistFar, TARGET_ENE_0, true);
				
			--�A�N�V����
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, ezsNoFar, TARGET_ENE_0, DIST_Near, 0);
				if fate2 <= maaiPerFar then
					goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 5.0 , TARGET_ENE_0, AI_DIR_TYPE_CENTER, maaiDistFar, TARGET_ENE_0, true);
				end
			end
		end
		
	--�U���͈͓��ɂ��Ȃ��Ȃ�	
	else
		--�ڋ߁i���s�j
		if targetDist <= trigDistWalk then
			goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 10.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, moveDistWalk , TARGET_ENE_0, true );
			
		--�ڋ߁i�_�b�V�������s�j
		else
			goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 10.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, moveDistDash , TARGET_ENE_0, false );
			goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 10.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, moveDistWalk , TARGET_ENE_0, true );
		end
	end	

end


---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function Normal_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function Normal_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function Normal_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);
	--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)
	--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)
	--�m������Ŏg�p����^���̐����@���̂Q


local guardDist						=	3.0
	--�K�[�h����
local guardPer						=	50
	--�K�[�h�m��
local ezsNoguard					=	9910
	--ezstate�ԍ��y�K�[�h�z	
	
local missContDist					=	3.0
	--��U�蔽������
local missContPer					=	50
	--��U�蔽���m��
local ezsNoMissCont					=	3300
	--ezstate�ԍ��y��U�蔽���z

local guardBreakAttDist				=	3.0
	--�K�[�h���ꎞ�̍U������
local guardBreakAttPer				=	75
	--�K�[�h���ꎞ�̍U���m��
local ezsNoguardBreakAtt			=	3300
	--ezstate�ԍ��y�K�[�h���ꎞ�z
	
local guardDownAttDist				=	3.0
	--�K�[�h�������̍U������
local guardDownAttPer				=	40
	--�K�[�h�������̍U���m��
local ezsNoguardDownAtt				=	3000
	--ezstate�ԍ��y�K�[�h�������z


	--�K�[�h����
	if ai:IsInterupt( INTERUPT_FindAttack ) then
		if targetDist <= guardDist then
			if fate <= guardPer then
				goal:ClearSubGoal();
				goal:AddSubGoal(GOAL_COMMON_Guard, 5.0, ezsNoguard, TARGET_ENE_0, 0, 0);
				return true;
			end
		end
	end

	--��U�肵���甽������
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < missContDist then
			if fate <= missContPer then
				goal:ClearSubGoal();
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, ezsNoMissCont, TARGET_ENE_0, DIST_Near, 0);
				return true;
			end
		end
	end

	--�K�[�h���ꂽ��U������
	if ai:IsInterupt( INTERUPT_GuardBreak ) then
		if targetDist < guardBreakAttDist then
			if fate <= guardBreakAttPer then
				goal:ClearSubGoal();
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, ezsNoguardBreakAtt, TARGET_ENE_0, DIST_Near, 0);
				return true;
			end
		end
	end

	--�K�[�h�~�߂���U������
	if ai:IsInterupt( INTERUPT_GuardFinish ) then
		if targetDist < guardDownAttDist then
			if fate <= guardDownAttPer then
				goal:ClearSubGoal();
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, ezsNoguardDownAtt, TARGET_ENE_0, DIST_Near, 0);
				return true;
			end
		end
	end
	
	return false;
end

