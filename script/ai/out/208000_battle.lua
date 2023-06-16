-----------------------------------------------------------------------------------------------
--	�y�����z�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Gokuri208000_Battle, "gokuri208000Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Gokuri208000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function gokuri208000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 1.4					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3002_Dist_min = 1.5					--3002�Ԃ̓K���ԍ����i�ŏ��j
local Att3002_Dist_max = 4.3					--3002�Ԃ̓K���ԍ����i�ő�j
local Att3003_Dist_min = 0.0					--3003�Ԃ̓K���ԍ����i�ŏ��j
local Att3003_Dist_max = 2.0					--3003�Ԃ̓K���ԍ����i�ő�j
local Att3301_Dist_min = 4.0					--3301�Ԃ̓K���ԍ����i�ŏ��j
local Att3301_Dist_max = 15.0					--3301�Ԃ̓K���ԍ����i�ő�j
local Att3303_Dist_min = 0.0					--3303�Ԃ̓K���ԍ����i�ŏ��j
local Att3303_Dist_max = 0.6					--3303�Ԃ̓K���ԍ����i�ő�j
local Att3304_Dist_min = 6.0					--3304�Ԃ̓K���ԍ����i�ŏ��j
local Att3304_Dist_max = 15.0					--3304�Ԃ̓K���ԍ����i�ő�j

local Act01Per = 0		--�_�b�V���ڋ߁��W�����v�A�^�b�N
local Act02Per = 0		--�_�b�V���ڋ߁��ガ����
local Act03Per = 0		--�_�b�V���ڋ߁��A���U��	
local Act04Per = 0		--�_�b�V���ڋ߁�����
local Act05Per = 0		--���s�ڋ߁��W�����v�A�^�b�N
local Act06Per = 0		--���s�ڋ߁��ガ����
local Act07Per = 0		--���s�ڋ߁��A���U��
local Act08Per = 0		--���s�ڋ߁��t�@�C�A�i���j
local Act09Per = 0		--���s�ڋ߁��t�@�C�A�i�Z�j


	if targetDist >= 16.0 then
		Act01Per = 15		--�_�b�V���ڋ߁��W�����v�A�^�b�N
		Act02Per = 0		--�_�b�V���ڋ߁��ガ����
		Act03Per = 0		--�_�b�V���ڋ߁��A���U��	
		Act04Per = 5		--�_�b�V���ڋ߁�����
		Act05Per = 0		--���s�ڋ߁��W�����v�A�^�b�N
		Act06Per = 0		--���s�ڋ߁��ガ����
		Act07Per = 0		--���s�ڋ߁��A���U��
		Act08Per = 40		--���s�ڋ߁��t�@�C�A�i���j
		Act09Per = 40		--���s�ڋ߁��t�@�C�A�i�Z�j
		
	elseif targetDist >= 8.0 then
		Act01Per = 25		--�_�b�V���ڋ߁��W�����v�A�^�b�N
		Act02Per = 5		--�_�b�V���ڋ߁��ガ����
		Act03Per = 5		--�_�b�V���ڋ߁��A���U��	
		Act04Per = 5		--�_�b�V���ڋ߁�����
		Act05Per = 0		--���s�ڋ߁��W�����v�A�^�b�N
		Act06Per = 0		--���s�ڋ߁��ガ����
		Act07Per = 0		--���s�ڋ߁��A���U��
		Act08Per = 30		--���s�ڋ߁��t�@�C�A�i���j
		Act09Per = 30		--���s�ڋ߁��t�@�C�A�i�Z�j
		
	elseif targetDist >= 5.0 then	
		Act01Per = 0		--�_�b�V���ڋ߁��W�����v�A�^�b�N
		Act02Per = 10		--�_�b�V���ڋ߁��ガ����
		Act03Per = 10		--�_�b�V���ڋ߁��A���U��	
		Act04Per = 10		--�_�b�V���ڋ߁�����
		Act05Per = 20		--���s�ڋ߁��W�����v�A�^�b�N
		Act06Per = 0		--���s�ڋ߁��ガ����
		Act07Per = 0		--���s�ڋ߁��A���U��
		Act08Per = 20		--���s�ڋ߁��t�@�C�A�i���j
		Act09Per = 30		--���s�ڋ߁��t�@�C�A�i�Z�j
		
	elseif targetDist >= 3.0 then
		Act01Per = 0		--�_�b�V���ڋ߁��W�����v�A�^�b�N
		Act02Per = 0		--�_�b�V���ڋ߁��ガ����
		Act03Per = 20		--�_�b�V���ڋ߁��A���U��	
		Act04Per = 20		--�_�b�V���ڋ߁�����
		Act05Per = 20		--���s�ڋ߁��W�����v�A�^�b�N
		Act06Per = 10		--���s�ڋ߁��ガ����
		Act07Per = 10		--���s�ڋ߁��A���U��
		Act08Per = 0		--���s�ڋ߁��t�@�C�A�i���j
		Act09Per = 20		--���s�ڋ߁��t�@�C�A�i�Z�j
		
	elseif targetDist >= 1.0 then
		Act01Per = 0		--�_�b�V���ڋ߁��W�����v�A�^�b�N
		Act02Per = 0		--�_�b�V���ڋ߁��ガ����
		Act03Per = 0		--�_�b�V���ڋ߁��A���U��	
		Act04Per = 20		--�_�b�V���ڋ߁�����
		Act05Per = 10		--���s�ڋ߁��W�����v�A�^�b�N
		Act06Per = 25		--���s�ڋ߁��ガ����
		Act07Per = 40		--���s�ڋ߁��A���U��
		Act08Per = 0		--���s�ڋ߁��t�@�C�A�i���j
		Act09Per = 5		--���s�ڋ߁��t�@�C�A�i�Z�j
		
	else
		Act01Per = 0		--�_�b�V���ڋ߁��W�����v�A�^�b�N
		Act02Per = 0		--�_�b�V���ڋ߁��ガ����
		Act03Per = 0		--�_�b�V���ڋ߁��A���U��	
		Act04Per = 20		--�_�b�V���ڋ߁�����
		Act05Per = 0		--���s�ڋ߁��W�����v�A�^�b�N
		Act06Per = 40		--���s�ڋ߁��ガ����
		Act07Per = 40		--���s�ڋ߁��A���U��
		Act08Per = 0		--���s�ڋ߁��t�@�C�A�i���j
		Act09Per = 0		--���s�ڋ߁��t�@�C�A�i�Z�j
		
	end
	
	--�s��01�@�_�b�V���ڋ߁��W�����v�A�^�b�N
	if fate2 <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��02�@�_�b�V���ڋ߁��ガ����
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��03�@�_�b�V���ڋ߁��A���U��
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, -1 );
		gokuri208000Battle_Kougeki(ai, goal)
		
	--�s��04�@�_�b�V���ڋ߁�����
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3303_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��05�@���s�ڋ߁��W�����v�A�^�b�N
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��06�@���s�ڋ߁��ガ����
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��07�@���s�ڋ߁��A���U��
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, -1 );
		gokuri208000Battle_Kougeki(ai, goal)
		
	--�s��08�@���s�ڋ߁��t�@�C�A�i���j
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per + Act08Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3304_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);

	--�s��09�@���s�ڋ߁��t�@�C�A�i�Z�j
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3301_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
		
	end
	gokuri208000Battle_Kougeki_Noato(ai, goal)
	
end


---------------------------------------------------------
--  �U��
---------------------------------------------------------
function gokuri208000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--20% 3000
	--50% 3000-3001
	--30% 3000-3001-3303
	if K_fate <= 30 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function gokuri208000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--70% �Ȃɂ����Ȃ�
	--5% �K���ɉ��Ɉړ�
	--25% ���Ɉړ�
	if KN_fate <= 70 then
	
	elseif KN_fate < 0 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true, -1);
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, true, -1 );				
	end
end

	
	
---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function gokuri208000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function gokuri208000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function gokuri208000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂Q
	
local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 1.4					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3002_Dist_min = 1.5					--3002�Ԃ̓K���ԍ����i�ŏ��j
local Att3002_Dist_max = 4.3					--3002�Ԃ̓K���ԍ����i�ő�j
local Att3003_Dist_min = 0.0					--3003�Ԃ̓K���ԍ����i�ŏ��j
local Att3003_Dist_max = 2.0					--3003�Ԃ̓K���ԍ����i�ő�j
local Att3301_Dist_min = 4.0					--3301�Ԃ̓K���ԍ����i�ŏ��j
local Att3301_Dist_max = 15.0					--3301�Ԃ̓K���ԍ����i�ő�j
local Att3303_Dist_min = 0.0					--3303�Ԃ̓K���ԍ����i�ŏ��j
local Att3303_Dist_max = 0.6					--3303�Ԃ̓K���ԍ����i�ő�j
local Att3304_Dist_min = 6.0					--3304�Ԃ̓K���ԍ����i�ŏ��j
local Att3304_Dist_max = 15.0					--3304�Ԃ̓K���ԍ����i�ő�j

local Act01Per = 0		--�_�b�V���ڋ߁��W�����v�A�^�b�N
local Act02Per = 0		--�_�b�V���ڋ߁��ガ����
local Act03Per = 0		--�_�b�V���ڋ߁��A���U��	
local Act04Per = 0		--�_�b�V���ڋ߁�����
local Act05Per = 0		--���s�ڋ߁��W�����v�A�^�b�N
local Act06Per = 0		--���s�ڋ߁��ガ����
local Act07Per = 0		--���s�ڋ߁��A���U��
local Act08Per = 0		--���s�ڋ߁��t�@�C�A�i���j
local Act09Per = 0		--���s�ڋ߁��t�@�C�A�i�Z�j


	-- �R���{����@�����ʊ֐�
local combRunDist		= 1.6		--�R���{���ꂷ�鋗��
local combRunPer		= 30		--�R���{���ꂷ��m��
	if Damaged_Act(ai, goal, combRunDist, combRunPer ) then
		goal:ClearSubGoal();
		gokuri208000Battle_Kougeki(ai, goal)
		gokuri208000Battle_Kougeki_Noato(ai, goal)
		return true;
	end	
	
	--�K�[�h���󂵂���U���@�����ʊ֐�
local guardBreakConutDist = 4.5			--�K�[�h����ōU�����鋗��
local guardBreakConutPer = 65			--�K�[�h����ōU������m��
	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
		goal:ClearSubGoal();
		--�����ʂɑΉ�
		if targetDist >= Att3002_Dist_min then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
			
		else
			gokuri208000Battle_Kougeki(ai, goal)
			
		end
		gokuri208000Battle_Kougeki_Noato(ai, goal)
		return true;
	end	
	
return false;

end


	