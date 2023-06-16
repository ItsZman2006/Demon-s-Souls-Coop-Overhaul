-----------------------------------------------------------------------------------------------
--	�[�����m�i���E���j�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_honeKEN402100_Battle, "honeKEN402100Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_honeKEN402100_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function honeKEN402100Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐����@���̂Q

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 1.5					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3001_Dist_min = 0.0					--3001�Ԃ̓K���ԍ����i�ŏ��j
local Att3001_Dist_max = 1.3					--3001�Ԃ̓K���ԍ����i�ő�j
local Att3002_Dist_min = 3.0					--3002�Ԃ̓K���ԍ����i�ŏ��j
local Att3002_Dist_max = 4.5					--3002�Ԃ̓K���ԍ����i�ő�j
local Att3303_Dist_min = 3.0					--3303�Ԃ̓K���ԍ����i�ŏ��j
local Att3303_Dist_max = 5.5					--3303�Ԃ̓K���ԍ����i�ő�j
local Att3300_Dist_min = 1.5					--3300�Ԃ̓K���ԍ����i�ŏ��j
local Att3300_Dist_max = 3.0					--3300�Ԃ̓K���ԍ����i�ő�j


	--�˂������Ă��ςł͂Ȃ����炢����Ă���Ƃ�
	if targetDist >= 9.0 then
		--�K�[�h���Ă�����A���m���ŃK�[�h�Ԃ�
		if ai:IsTargetGuard( TARGET_ENE_0 ) and fate2 <= 80 then
			goal:AddSubGoal(GOAL_COMMON_ApproachStep, 5.0, 700, TARGET_ENE_0, Att3300_Dist_max, 0)
			goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			if fate2 <= 50 then
				honeKEN402100Battle_Att3002(ai, goal)
			else
				honeKEN402100Battle_Att3000(ai, goal)
			end
		else
			if fate <= 25 then
				goal:AddSubGoal(GOAL_COMMON_ApproachStep, 5.0, 700, TARGET_ENE_0, Att3303_Dist_max, 0)
				honeKEN402100Battle_Att3303(ai, goal)
				
			elseif fate <= 50 then
				goal:AddSubGoal(GOAL_COMMON_ApproachStep, 5.0, 700, TARGET_ENE_0, Att3002_Dist_max, 0)
				honeKEN402100Battle_Att3002(ai, goal)
				
			else
				goal:AddSubGoal(GOAL_COMMON_ApproachStep, 5.0, 700, TARGET_ENE_0, Att3000_Dist_max, 0)
				honeKEN402100Battle_Att3000(ai, goal)
			end
		end
		honeKEN402100Battle_Kougeki_Noato(ai, goal)
		
	--��]�U�������Ă��ςł͂Ȃ����炢����Ă��鎞	
	elseif targetDist >= 4.0 then
		--�K�[�h���Ă�����A���m���ŃK�[�h�Ԃ�
		if ai:IsTargetGuard( TARGET_ENE_0 ) and fate2 <= 80 then
			goal:AddSubGoal(GOAL_COMMON_ApproachStep, 5.0, 700, TARGET_ENE_0, Att3300_Dist_max, 0)
			goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			if fate2 <= 50 then
				honeKEN402100Battle_Att3002(ai, goal)
			else
				honeKEN402100Battle_Att3000(ai, goal)
			end
		else
			if fate <= 25 then
				goal:AddSubGoal(GOAL_COMMON_ApproachStep, 5.0, 700, TARGET_ENE_0, Att3303_Dist_max, 0)
				honeKEN402100Battle_Att3303(ai, goal)
				
			else
				goal:AddSubGoal(GOAL_COMMON_ApproachStep, 5.0, 700, TARGET_ENE_0, Att3000_Dist_max, 0)
				honeKEN402100Battle_Att3000(ai, goal)
			end
		end
		honeKEN402100Battle_Kougeki_Noato(ai, goal)	
		
	--�ߐڂ���Ȃ��ƕςȂ��炢�߂��Ƃ�
	else
		--�K�[�h���Ă�����A���m���ŃK�[�h�Ԃ�
		if ai:IsTargetGuard( TARGET_ENE_0 ) and fate2 <= 80 then
			goal:AddSubGoal(GOAL_COMMON_ApproachStep, 5.0, 700, TARGET_ENE_0, Att3300_Dist_max, 0)
			goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			if fate2 <= 50 then
				honeKEN402100Battle_Att3002(ai, goal)
			else
				honeKEN402100Battle_Att3000(ai, goal)
			end
		else
			goal:AddSubGoal(GOAL_COMMON_ApproachStep, 5.0, 700, TARGET_ENE_0, Att3000_Dist_max, 0)
			honeKEN402100Battle_Att3000(ai, goal)
		end
		honeKEN402100Battle_Kougeki_Noato(ai, goal)	
	end
	
end

---------------------------------------------------------
--  �U��3000�`
---------------------------------------------------------
function honeKEN402100Battle_Att3000(ai, goal)

local Att3300_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--10% 3000-3001
	--40% 3000-3001-3000
	--35% 3000-3001-3000-3001
	--15% 3000-3001-3300
	if Att3300_fate <= 10 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3300_fate <= 50 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3300_fate <= 85 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
	end
end


---------------------------------------------------------
--  �U��3303
---------------------------------------------------------
function honeKEN402100Battle_Att3303(ai, goal)

local Att3303_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--25% 3303
	--10% 3303-3001
	--30% 3303-3001-3000
	--35% 3303-3001-3000-3001
	if Att3303_fate <= 25 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3303_fate <= 35 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3303_fate <= 65 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);

	end
end


---------------------------------------------------------
--  �U��3002
---------------------------------------------------------
function honeKEN402100Battle_Att3002(ai, goal)

local Att3002_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--80% 3002
	--20% 3002-3001-3000
	if Att3002_fate <= 80 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function honeKEN402100Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local LeaveDist = ai:GetRandam_Int(8,12)		--����鋗��

local myThinkId = ai:GetNpcThinkParamID()		--�v�lID���擾

local KNAct01Per	= 10	--�������Ȃ�
local KNAct02Per	= 25	--�E�X�e�b�v
local KNAct03Per	= 25	--���X�e�b�v
local KNAct04Per	= 30	--�S���S���ގU
local KNAct05Per	= 5		--�����������ړ�
local KNAct06Per	= 5		--�o�b�N�X�e�b�v

	if myThinkId == 402102 then		--�����Ƃ���p
		KNAct01Per	= 50	--�������Ȃ�
		KNAct02Per	= 10	--�E�X�e�b�v
		KNAct03Per	= 10	--���X�e�b�v
		KNAct04Per	= 0		--�S���S���ގU
		KNAct05Per	= 0		--�����������ړ�
		KNAct06Per	= 30	--�o�b�N�X�e�b�v
	end
	
	--�s��01�@�������Ȃ�
	if  KN_fate <= KNAct01Per then
   		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.5,1.0) ,0,0,0,0)
		
	--�s��02�@�E�X�e�b�v
	elseif  KN_fate <= (KNAct01Per + KNAct02Per) then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 703, TARGET_ENE_0, 0);
		
	--�s��03�@���X�e�b�v
	elseif  KN_fate <= (KNAct01Per + KNAct02Per + KNAct03Per) then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 702, TARGET_ENE_0, 0);
		
	--�s��04�@�S���S���ގU
	elseif  KN_fate <= (KNAct01Per + KNAct02Per + KNAct03Per + KNAct04Per) then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 700, TARGET_SELF, 0, AI_DIR_TYPE_F, 4.0);
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 700, TARGET_SELF, 0, AI_DIR_TYPE_F, 4.0);
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 700, TARGET_SELF, 0, AI_DIR_TYPE_F, 4.0);
		
	--�s��05�@�����������ړ�
	elseif  KN_fate <= (KNAct01Per + KNAct02Per + KNAct03Per + KNAct04Per + KNAct05Per) then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
		
	--�s��06�@�o�b�N�X�e�b�v
	else
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0.0);
		
	end
end

	
	
---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function honeKEN402100Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function honeKEN402100Battle_Terminate(ai, goal)
end

---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function honeKEN402100Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 1.5					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3001_Dist_min = 0.0					--3001�Ԃ̓K���ԍ����i�ŏ��j
local Att3001_Dist_max = 1.3					--3001�Ԃ̓K���ԍ����i�ő�j
local Att3002_Dist_min = 3.0					--3002�Ԃ̓K���ԍ����i�ŏ��j
local Att3002_Dist_max = 4.5					--3002�Ԃ̓K���ԍ����i�ő�j
local Att3303_Dist_min = 3.0					--3303�Ԃ̓K���ԍ����i�ŏ��j
local Att3303_Dist_max = 5.5					--3303�Ԃ̓K���ԍ����i�ő�j
local Att3300_Dist_min = 1.5					--3300�Ԃ̓K���ԍ����i�ŏ��j
local Att3300_Dist_max = 3.0					--3300�Ԃ̓K���ԍ����i�ő�j

	--��U��ǌ��@�����ʊ֐�
local missSwingDist = 4.5			--��U��ǌ����鋗��
local missSwingAttPer = 30			--��U��ǌ�����m��	
	if MissSwing_Act(ai, goal, missSwingDist, missSwingAttPer ) then
		goal:ClearSubGoal();
		
		--�����ʂɑΉ�
		if targetDist >= Att3002_Dist_min then
			honeKEN402100Battle_Att3002(ai, goal)
		elseif targetDist >= Att3300_Dist_min then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		else
			honeKEN402100Battle_Att3000(ai, goal)
		end
		honeKEN402100Battle_Kougeki_Noato(ai, goal)
		return true;
	end

	--�R���{����@�����ʊ֐�
local combRunDist = 1.5				--�R���{���ꂷ�鋗��
local combRunPer = 40				--�R���{���ꂷ��m��
	if Damaged_Act(ai, goal, combRunDist, combRunPer ) then
		goal:ClearSubGoal();
		
		--���E�ɃX�e�b�v
		if fate <= 50 then
			goal:AddSubGoal( GOAL_COMMON_Step, 10.0, 702, 0, 0, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_Step, 10.0, 703, 0, 0, 0);
		end
		return true;
	end	

	--�K�[�h���󂵂���U���@�����ʊ֐�
local guardBreakConutDist = 4.5			--�K�[�h����ōU�����鋗��
local guardBreakConutPer = 65			--�K�[�h����ōU������m��
	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
		goal:ClearSubGoal();
		
		--�����ʂɑΉ�
		if targetDist >= Att3002_Dist_min then
			honeKEN402100Battle_Att3002(ai, goal)
		elseif targetDist >= Att3300_Dist_min then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		else
			honeKEN402100Battle_Att3000(ai, goal)
		end
		honeKEN402100Battle_Kougeki_Noato(ai, goal)
		return true;
	end

return false;
end



