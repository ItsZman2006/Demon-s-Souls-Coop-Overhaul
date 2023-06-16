-----------------------------------------------------------------------------------------------
--	���_�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_sinigami401000_Battle, "sinigami401000Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_sinigami401000_Battle, 1 );


--------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function sinigami401000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂Q

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 2.8					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3001_Dist_min = 0.0					--3001�Ԃ̓K���ԍ����i�ŏ��j
local Att3001_Dist_max = 2.8					--3001�Ԃ̓K���ԍ����i�ő�j
local Att3002_Dist_min = 0.0					--3002�Ԃ̓K���ԍ����i�ŏ��j
local Att3002_Dist_max = 2.8					--3002�Ԃ̓K���ԍ����i�ő�j
local Att3300_Dist_min = 0.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
local Att3300_Dist_max = 10.0					--3300�Ԃ̓K���ԍ����i�ő�j

local Act01Per = 0		--�����������U��
local Act02Per = 0		--����������U��
local Act03Per = 0		--���������U�艺�낵�U��
local Act04Per = 0		--�����������@�U��

	--PC�����߂Ȃ�
	if targetDist >= 7.5 then
		--PC���K�[�h���Ă����Ȃ�
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 0		--�����������U��
			Act02Per = 0		--����������U��
			Act03Per = 5		--���������U�艺�낵�U��
			Act04Per = 95		--�����������@�U��
			
		--�����łȂ����
		else
			Act01Per = 0		--�����������U��
			Act02Per = 0		--����������U��
			Act03Per = 0		--���������U�艺�낵�U��
			Act04Per = 100		--�����������@�U��
		end
		
	--�o�b���߂߂Ȃ�	
	elseif targetDist >= 3.0 then
		--PC���K�[�h���Ă����Ȃ�
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 5		--�����������U��
			Act02Per = 5		--����������U��
			Act03Per = 30		--���������U�艺�낵�U��
			Act04Per = 60		--�����������@�U��
			
		--�����łȂ����
		else
			Act01Per = 5		--�����������U��
			Act02Per = 5		--����������U��
			Act03Per = 5		--���������U�艺�낵�U��
			Act04Per = 85		--�����������@�U��
		end	
		
	--PC������Ƌ߂��Ȃ�
	else
		--PC���K�[�h���Ă����Ȃ�
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 10		--�����������U��
			Act02Per = 10		--����������U��
			Act03Per = 40		--���������U�艺�낵�U��
			Act04Per = 40		--�����������@�U��
			
		--�����łȂ����
		else
			Act01Per = 25		--�����������U��
			Act02Per = 25		--����������U��
			Act03Per = 10		--���������U�艺�낵�U��
			Act04Per = 50		--�����������@�U��
		end
	end
	
	--�s��01�@�����������U��
	if fate2 <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��02�@����������U��
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3001_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��03�@���������U�艺�낵�U��
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��04�@�����������@�U��
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3300_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);	
		
	end
	sinigami401000Battle_Kougeki_Noato(ai, goal)
	
end

---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function sinigami401000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

local KNAct01Per	= 75	--�������Ȃ�
local KNAct02Per	= 20	--�����������ړ�
local KNAct06Per	= 5		--�����������

	--�s��01�@�������Ȃ�
	if  KN_fate <= KNAct01Per then
   		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.0,1.0) ,0,0,0,0)
		
	--�s��02�@�����������ړ�
	elseif  KN_fate <= (KNAct01Per + KNAct02Per) then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
		
	--�s��03�@�����������
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, 5.0, TARGET_SELF, true, -1 );
		
	end
end
	
	
---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function sinigami401000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function sinigami401000Battle_Terminate(ai, goal)
end

---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function sinigami401000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐����@���̂Q

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 3.1					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3001_Dist_min = 0.0					--3001�Ԃ̓K���ԍ����i�ŏ��j
local Att3001_Dist_max = 3.1					--3001�Ԃ̓K���ԍ����i�ő�j
local Att3002_Dist_min = 0.0					--3002�Ԃ̓K���ԍ����i�ŏ��j
local Att3002_Dist_max = 3.1					--3002�Ԃ̓K���ԍ����i�ő�j
local Att3300_Dist_min = 0.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
local Att3300_Dist_max = 10.0					--3300�Ԃ̓K���ԍ����i�ő�j

	--��ѓ���ǂ�����
	--�^�[�Q�b�g����ѓ���𔭎˂�����A�܂�ɋ߂Â�
local farResDist	=5.0	--�������鋗��
local farResPer		=20		--��������m��
	if FarDamaged_Act(ai, goal, farResDist, farResPer ) then
		goal:ClearSubGoal();
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		return true;
	end	

	--�K�[�h���󂵂���U���@�����ʊ֐�
local guardBreakConutDist = 10.0			--�K�[�h����ōU�����鋗��
local guardBreakConutPer = 50			--�K�[�h����ōU������m��
	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
		goal:ClearSubGoal();
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);	
		return true;
	end	
	

return false;
end




			


