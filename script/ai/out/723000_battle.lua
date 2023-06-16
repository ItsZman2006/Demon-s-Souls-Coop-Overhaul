-----------------------------------------------------------------------------------------------
--	�����h�����p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_King723000_Battle, "king723000Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_King723000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function king723000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

	-- �ԍ�0��1�������Ă���Ƃ��͊����݂��L�����Z������
	ai:SetNumber(0, 0);	-- �f�t�H���g�ŃI�t
	
local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local Att3010_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3010_Dist_max = 2.8					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3030_Dist_min = 2.5					--3030�Ԃ̓K���ԍ����i�ŏ��j
local Att3030_Dist_max = 5.6					--3030�Ԃ̓K���ԍ����i�ő�j
local Att3040_Dist_min = 0.0					--3030�Ԃ̓K���ԍ����i�ŏ��j
local Att3040_Dist_max = 1.3					--3030�Ԃ̓K���ԍ����i�ő�j
local Att3050_Dist_min = 0.0					--3050�Ԃ̓K���ԍ����i�ŏ��j
local Att3050_Dist_max = 3.5					--3050�Ԃ̓K���ԍ����i�ő�j
local Att3080_Dist_min = 0.0					--3080�Ԃ̓K���ԍ����i�ŏ��j
local Att3080_Dist_max = 3.0					--3080�Ԃ̓K���ԍ����i�ő�j
local Att3090_Dist_min = 4.5					--3090�Ԃ̓K���ԍ����i�ŏ��j
local Att3090_Dist_max = 6.0					--3090�Ԃ̓K���ԍ����i�ő�j	*��6.5��
local Att3100_Dist_min = 0.0					--3100�Ԃ̓K���ԍ����i�ŏ��j
local Att3100_Dist_max = 2.4					--3100�Ԃ̓K���ԍ����i�ő�j
local Att3110_Dist_min = 0.0					--3110�Ԃ̓K���ԍ����i�ŏ��j
local Att3110_Dist_max = 1.0					--3110�Ԃ̓K���ԍ����i�ő�j
local Att3130_Dist_min = 8.0					--3130�Ԃ̓K���ԍ����i�ŏ��j
local Att3130_Dist_max = 20.0					--3130�Ԃ̓K���ԍ����i�ő�j

--memo 3100 3020 3070 3080 �͍U����̃��[�V�����L�����Z�������x�߂Ō��ɂȂ�

local Act01Per = 0		--�_�b�V���ڋ߁�3070�a��
local Act02Per = 0		--���s�ڋ߁����W�����v�a��R���{
local Act03Per = 0		--���s�ڋ߁��O�X�e�b�v�a��R���{
local Act04Per = 0		--���s�ڋ߁������Ȃ�͂�
local Act05Per = 0		--���s�ڋ߁��ߐڃR���{
local Act06Per = 0		--���s�ڋ߁����b�V��
local Act07Per = 0		--��X�e�b�v�a��
local Act08Per = 0		--���W�����v�a��ڋ߁����b�V���ȂǍU��
local Act09Per = 0		--���a��
local Act10Per = 0		--���̏�ōU���i�Ռ��g�ɗ���j
local Act11Per = 0		--���̏�ōL�͈͍U��

	--����Ɖ����Ȃ�
	if targetDist >= 22.0 then
		Act01Per = 90		--�_�b�V���ڋ߁�3070�a��
		Act02Per = 0		--���s�ڋ߁����W�����v�a��R���{
		Act03Per = 0		--���s�ڋ߁��O�X�e�b�v�a��R���{
		Act04Per = 0		--���s�ڋ߁������Ȃ�͂�
		Act05Per = 0		--���s�ڋ߁��ߐڃR���{
		Act06Per = 0		--���s�ڋ߁����b�V��
		Act07Per = 0		--��X�e�b�v�a��
		Act08Per = 0		--���W�����v�a��ڋ߁����b�V���ȂǍU��
		Act09Per = 0		--���s�ڋ߁����a��
		Act10Per = 10		--���̏�ōU���i�Ռ��g�ɗ���j
		Act11Per = 0		--���̏�ōL�͈͍U��
		
	--�����Ȃ�
	elseif targetDist >= 9.0 then
		Act01Per = 50		--�_�b�V���ڋ߁�3070�a��
		Act02Per = 0		--���s�ڋ߁����W�����v�a��R���{
		Act03Per = 0		--���s�ڋ߁��O�X�e�b�v�a��R���{
		Act04Per = 0		--���s�ڋ߁������Ȃ�͂�
		Act05Per = 0		--���s�ڋ߁��ߐڃR���{
		Act06Per = 0		--���s�ڋ߁����b�V��
		Act07Per = 0		--��X�e�b�v�a��
		Act08Per = 0		--���W�����v�a��ڋ߁����b�V���ȂǍU��
		Act09Per = 0		--���s�ڋ߁����a��
		Act10Per = 10		--���̏�ōU���i�Ռ��g�ɗ���j
		Act11Per = 40		--���̏�ōL�͈͍U��
		
	--���r���[�ɉ����Ȃ�i��ԍ��鋗���j
	elseif targetDist >= 7.0 then
		Act01Per = 35		--�_�b�V���ڋ߁�3070�a��
		Act02Per = 15		--���s�ڋ߁����W�����v�a��R���{
		Act03Per = 15		--���s�ڋ߁��O�X�e�b�v�a��R���{
		Act04Per = 0		--���s�ڋ߁������Ȃ�͂�
		Act05Per = 0		--���s�ڋ߁��ߐڃR���{
		Act06Per = 0		--���s�ڋ߁����b�V��
		Act07Per = 0		--��X�e�b�v�a��
		Act08Per = 0		--���W�����v�a��ڋ߁����b�V���ȂǍU��
		Act09Per = 0		--���s�ڋ߁����a��
		Act10Per = 5		--���̏�ōU���i�Ռ��g�ɗ���j
		Act11Per = 30		--���̏�ōL�͈͍U��
		
	--���W�����v�a������Ă��ςłȂ��Ȃ�	
	elseif targetDist >= 5.0 then
		Act01Per = 0		--�_�b�V���ڋ߁�3070�a��
		Act02Per = 30		--���s�ڋ߁����W�����v�a��R���{
		Act03Per = 30		--���s�ڋ߁��O�X�e�b�v�a��R���{
		Act04Per = 5		--���s�ڋ߁������Ȃ�͂�
		Act05Per = 5		--���s�ڋ߁��ߐڃR���{
		Act06Per = 0		--���s�ڋ߁����b�V��
		Act07Per = 0		--��X�e�b�v�a��
		Act08Per = 10		--���W�����v�a��ڋ߁����b�V���ȂǍU��	
		Act09Per = 5		--���s�ڋ߁����a��
		Act10Per = 0		--���̏�ōU���i�Ռ��g�ɗ���j
		Act11Per = 15		--���̏�ōL�͈͍U��
		
	--������͋߂��āA�G���K�[�h���Ă����Ȃ�A�U�O���̊m����
	elseif ai:IsTargetGuard( TARGET_ENE_0 )  and fate <= 60 then
		Act09Per = 100		--���s�ڋ߁����a��	
		
	--�O�X�e�b�v�a������Ă��ςłȂ��Ȃ�	
	elseif targetDist >= 2.5 then
		Act01Per = 0		--�_�b�V���ڋ߁�3070�a��
		Act02Per = 0		--���s�ڋ߁����W�����v�a��R���{
		Act03Per = 30		--���s�ڋ߁��O�X�e�b�v�a��R���{
		Act04Per = 20		--���s�ڋ߁������Ȃ�͂�
		Act05Per = 20		--���s�ڋ߁��ߐڃR���{
		Act06Per = 20		--���s�ڋ߁����b�V��
		Act07Per = 0		--��X�e�b�v�a��
		Act08Per = 0		--���W�����v�a��ڋ߁����b�V���ȂǍU��	
		Act09Per = 10		--���s�ڋ߁����a��
		Act10Per = 0		--���̏�ōU���i�Ռ��g�ɗ���j
		Act11Per = 0		--���̏�ōL�͈͍U��
		
	--��X�e�b�v�a����ł��Ȃ����x�ɗ���Ă���Ȃ�
	elseif targetDist >= 1.3 then
		Act01Per = 0		--�_�b�V���ڋ߁�3070�a��
		Act02Per = 0		--���s�ڋ߁����W�����v�a��R���{
		Act03Per = 0		--���s�ڋ߁��O�X�e�b�v�a��R���{
		Act04Per = 20		--���s�ڋ߁������Ȃ�͂�
		Act05Per = 40		--���s�ڋ߁��ߐڃR���{
		Act06Per = 20		--���s�ڋ߁����b�V��
		Act07Per = 0		--��X�e�b�v�a��
		Act08Per = 0		--���W�����v�a��ڋ߁����b�V���ȂǍU��
		Act09Per = 20		--���s�ڋ߁����a��
		Act10Per = 0		--���̏�ōU���i�Ռ��g�ɗ���j
		Act11Per = 0		--���̏�ōL�͈͍U��
		
	--�����Ƌ߂��Ȃ�
	else
		Act01Per = 0		--�_�b�V���ڋ߁�3070�a��
		Act02Per = 0		--���s�ڋ߁����W�����v�a��R���{
		Act03Per = 0		--���s�ڋ߁��O�X�e�b�v�a��R���{
		Act04Per = 20		--���s�ڋ߁������Ȃ�͂�
		Act05Per = 20		--���s�ڋ߁��ߐڃR���{
		Act06Per = 20		--���s�ڋ߁����b�V��
		Act07Per = 20		--��X�e�b�v�a��
		Act08Per = 0		--���W�����v�a��ڋ߁����b�V���ȂǍU��
		Act09Per = 20		--���s�ڋ߁����a��
		Act10Per = 0		--���̏�ōU���i�Ռ��g�ɗ���j
		Act11Per = 0		--���̏�ōL�͈͍U��
		
	end
	
	--�s��01�@�_�b�V���ڋ߁�3070�a��
	if fate2 <= Act01Per then
		ai:SetNumber(0, 1);	-- �_�b�V���؂蒆�͊����ݕs��
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal( GOAL_COMMON_Attack2, 10.0, 3070, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��02�@���s�ڋ߁����W�����v�a��R���{
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, Att3090_Dist_max, TARGET_ENE_0, true, -1 );
		king723000Battle_Att3090(ai, goal)
		
	--�s��03�@���s�ڋ߁��O�X�e�b�v�a��R���{
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, Att3030_Dist_max, TARGET_ENE_0, true, -1 );
		king723000Battle_Att3030(ai, goal)
		
	--�s��04�@���s�ڋ߁������Ȃ�͂�
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, Att3080_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3080, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��05�@���s�ڋ߁��ߐڃR���{
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per) then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, Att3010_Dist_max, TARGET_ENE_0, true, -1 );
		king723000Battle_Att3010(ai, goal)
		
	--�s��06�@���s�ڋ߁����b�V��
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per) then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, Att3100_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3100, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��07�@��X�e�b�v�a��
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per) then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, Att3040_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��08�@���W�����v�a��ڋ߁����b�V���ȂǍU��
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per + Act08Per) then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3090, TARGET_ENE_0, DIST_Middle, 0);	
		if fate3 <= 80 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3100, TARGET_ENE_0, DIST_Middle, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	--�s��09�@���a��
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per + Act08Per + Act09Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, Att3050_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
		if fate3 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3080, TARGET_ENE_0, DIST_Middle, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3100, TARGET_ENE_0, DIST_Middle, 0);
		end	
		
	--�s��10�@���̏�ōU���i�Ռ��g�ɗ���j
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per + Act08Per + Act09Per + Act10Per) then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��10�@���̏�ōL�͈͍U��	
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3130, TARGET_ENE_0, DIST_None, 0);
		
	end
	king723000Battle_Kougeki_Noato(ai, goal)
	
end

---------------------------------------------------------
--  �U��3010�`
---------------------------------------------------------
function king723000Battle_Att3010(ai, goal)

local Att3010_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local Att3010_fate2 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂Q


	--10�� 3010-3020
	--45�� 3010-3000-3010-3020
	--15�� 3010-3000-3010
	--10�� 3010-3000-3010-3040
	--20�� 3010-3000-step-3050
	if Att3010_fate <=10 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
	elseif Att3010_fate <= 55 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Middle, 0);
		elseif Att3010_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
	elseif Att3010_fate <= 80 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		if Att3010_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0.0, AI_DIR_TYPE_L, 3);
		else
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0.0, AI_DIR_TYPE_R, 3);
		end
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
---------------------------------------------------------
--  �U��3030�`
---------------------------------------------------------
function king723000Battle_Att3030(ai, goal)

local Att3030_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--50�� 3030
	--20�� 3030-3010-3020
	--5�� 3030-3010-3020-3040
	--20�� 3030-3100
	--5�� 3030-3100-3040
	if Att3030_fate <= 50 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3030_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3030_fate <= 75 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3030_fate <= 95 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3100, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3100, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
	end
end

---------------------------------------------------------
--  �U��3090�`
---------------------------------------------------------
function king723000Battle_Att3090(ai, goal)

local Att3090_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--50�� 3090
	--20�� 3090-3010-3020
	--5�� 3090-3010-3020-3040
	--20�� 3090-3100
	--5�� 3090-3100-3040
	if Att3090_fate <= 50 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3090, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3090_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3090, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3090_fate <= 75 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3090, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3090_fate <= 95 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3090, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3100, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3090, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3100, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
	end
end


	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function king723000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local KN_fate2 = ai:GetRandam_Int(1,100)		--�m������p

	--40���@�Ȃɂ����Ȃ�
	--25���@���ɕ��s�ړ�
	--20���@���ɃX�e�b�v�ړ�
	--5���@��ɃX�e�b�v�ړ�
	--10���@��X�e�b�v�a��
	if KN_fate <= 40 then
		
	elseif KN_fate <= 65 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
		
	elseif KN_fate <= 85 then
		if KN_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0.0, AI_DIR_TYPE_L, 3);
		else
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0.0, AI_DIR_TYPE_R, 3);
		end	
		
	elseif KN_fate <= 90 then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 701, TARGET_ENE_0, 0.0, AI_DIR_TYPE_B, 3);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
	end
end


---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function king723000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function king723000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function king723000Battle_Interupt(ai, goal)

	if ai:GetNumber(0) == 1 then
		-- �ԍ��X���b�g0��1���ݒ肳��Ă���ꍇ�͊����ݕs��
		
-- �X�[�p�[�A�[�}�[����邻���Ȃ̂Ń��Z�b�g���Ȃ�		
--		-- �X�[�p�[�A�[�}�[�������Ă��Ȃ��̂ŁA�H������烊�Z�b�g����
--		if ai:IsInterupt( INTERUPT_Damaged ) then
--			-- �_���[�W�H������ꍇ�͂�蒼��
--			ai:Replaning();
--			return true;
--		end
		return false;
	end

	
-- PC�����S�����ہA�s�����~�߂�
	if ai:IsInterupt( INTERUPT_ForgetTarget ) then
		goal:ClearSubGoal();
		ai:Replaning(); 
		return true; 
	end

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local Att3010_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3010_Dist_max = 2.8					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3030_Dist_min = 2.5					--3030�Ԃ̓K���ԍ����i�ŏ��j
local Att3030_Dist_max = 5.6					--3030�Ԃ̓K���ԍ����i�ő�j
local Att3040_Dist_min = 0.0					--3030�Ԃ̓K���ԍ����i�ŏ��j
local Att3040_Dist_max = 1.3					--3030�Ԃ̓K���ԍ����i�ő�j
local Att3050_Dist_min = 0.0					--3050�Ԃ̓K���ԍ����i�ŏ��j
local Att3050_Dist_max = 3.5					--3050�Ԃ̓K���ԍ����i�ő�j
local Att3080_Dist_min = 0.0					--3080�Ԃ̓K���ԍ����i�ŏ��j
local Att3080_Dist_max = 3.0					--3080�Ԃ̓K���ԍ����i�ő�j
local Att3090_Dist_min = 4.5					--3090�Ԃ̓K���ԍ����i�ŏ��j
local Att3090_Dist_max = 6.0					--3090�Ԃ̓K���ԍ����i�ő�j	*��6.5��
local Att3100_Dist_min = 0.0					--3100�Ԃ̓K���ԍ����i�ŏ��j
local Att3100_Dist_max = 2.4					--3100�Ԃ̓K���ԍ����i�ő�j
local Att3110_Dist_min = 0.0					--3110�Ԃ̓K���ԍ����i�ŏ��j
local Att3110_Dist_max = 1.0					--3110�Ԃ̓K���ԍ����i�ő�j
local Att3130_Dist_min = 8.0					--3130�Ԃ̓K���ԍ����i�ŏ��j
local Att3130_Dist_max = 20.0					--3130�Ԃ̓K���ԍ����i�ő�j


	--��U��ǌ��@�����ʊ֐�
local missSwingDist = 2.4			--��U��ǌ����鋗��
local missSwingAttPer = 50			--��U��ǌ�����m��	
	if MissSwing_Act(ai, goal, missSwingDist, missSwingAttPer ) then
		goal:ClearSubGoal();
		--40�� �͂�
		--30�� ���a��
		--30�� ���b�V��
		if fate <= 40 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3080, TARGET_ENE_0, DIST_Middle, 0);
		elseif fate <= 70 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3100, TARGET_ENE_0, DIST_Middle, 0);
		end
		king723000Battle_Kougeki_Noato(ai, goal)
		return true;
	end

	
	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Č��
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist	 = 1.5			--�R���{���ꂷ�鋗��
local combRunPer	 = 60			--�R���{���ꂷ��m��
local bkStepAttPer	 = 25			--����X�e�b�v�U���œ���悤�Ƃ���m��
local rushAttPer	 = 25			--���b�V���U������m��
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				if fate2 <= bkStepAttPer then
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
					
				elseif fate2 <= (bkStepAttPer + rushAttPer) then	
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3100, TARGET_ENE_0, DIST_Middle, 0);
					king723000Battle_Kougeki_Noato(ai, goal)
					
				else
					if fate3 <= 60 then
						goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 701, TARGET_ENE_0, 0.0, AI_DIR_TYPE_B, 3);
					elseif fate3 <= 80 then
						goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0.0, AI_DIR_TYPE_L, 3);
					else
						goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0.0, AI_DIR_TYPE_R, 3);
					end
				end
				return true;
			end
		end
	end	

	
	--���ߋ����ōU�����ꂻ���ɂȂ�����X�e�b�v�@�����ʊ֐�
local superStepDist		=2.0	--�������鋗��
local superStepPer		=25		--��������m��	
local bkStepPer			=60		--�o�b�N�X�e�b�v�m��
local leftStepPer		=20		--���X�e�b�v�m��
local rightStepPer		=20		--�E�X�e�b�v�m��
local safetyDist		=3.0	--���S�m�F����	
FindAttack_SafetyStep(ai, goal, superStepDist, superStepPer, bkStepPer, leftStepPer, rightStepPer, safetyDist )

	
	--�K�[�h���󂵂���U��
	if ai:IsInterupt( INTERUPT_GuardBreak ) then
local guardBreakConutDist = 3.7			--�K�[�h����ōU�����鋗��
local guardBreakConutPer = 40			--�K�[�h����ōU������m��
		if targetDist <= guardBreakConutDist then
			if fate <= guardBreakConutPer then
				goal:ClearSubGoal();
				if fate <= 25 then
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3080, TARGET_ENE_0, DIST_Middle, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3100, TARGET_ENE_0, DIST_Middle, 0);
					king723000Battle_Kougeki_Noato(ai, goal)
				end
				return true;
			end
		end
	end
	
	--��ѓ���������Ă�����œK�s��
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 40					--��ѓ���g�p���ɍœK�s�������m���i�߂��Ƃ��j
local shootIntPer2 = 65					--��ѓ���g�p���ɍœK�s�������m���i��≓���Ƃ��j
local shootIntPer3 = 90					--��ѓ���g�p���ɍœK�s�������m���i�����Ƃ��j
local Per2_Dist = 4.5					--�u��≓���v�̋���
local Per3_Dist = 10.0					--�u�����v�̋���

		--�߂�
		if targetDist <= Per2_Dist then
			if fate <= shootIntPer then
				goal:ClearSubGoal();
				if fate2 <= 50 then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0.0, AI_DIR_TYPE_L, 3);
				else
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0.0, AI_DIR_TYPE_R, 3);
				end
				return true
			end
			
		--��≓��
		elseif targetDist <= Per3_Dist then
			if fate <= shootIntPer2 then
				goal:ClearSubGoal();
				if fate2 <= 50 then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0.0, AI_DIR_TYPE_L, 3);
				else
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0.0, AI_DIR_TYPE_R, 3);
				end
				return true
			end
			
		--����
		else
			if fate <= shootIntPer3 then
				goal:ClearSubGoal();
				if fate2 <= 50 then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0.0, AI_DIR_TYPE_L, 3);
				else
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0.0, AI_DIR_TYPE_R, 3);
				end
				return true
			end	
		end
	end
	
	--�A�C�e�����g������œK�s��
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 75				--�A�C�e���g�p���ɍœK�s�������m���i�߂��Ƃ��j
local itemUseIntPer2 = 60				--�A�C�e���g�p���ɍœK�s�������m���i��≓���Ƃ��j
local itemUseIntPer3 = 45				--�A�C�e���g�p���ɍœK�s�������m���i�����Ƃ��j
local Per2_Dist = 3.7					--�u��≓���v�̋���
local Per3_Dist = 10.0					--�u�����v�̋���

		--�߂�
		if targetDist <= Per2_Dist then
			if fate <= itemUseIntPer then
				goal:ClearSubGoal();
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3080, TARGET_ENE_0, DIST_Middle, 0);
				return true
			end	
			
		--��≓��
		elseif targetDist <= Per3_Dist then
			if fate <= itemUseIntPer2 then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, 6.5, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3090, TARGET_ENE_0, DIST_Middle, 0);	
				return true
			end	
			
		--����
		else
			if fate <= itemUseIntPer3 then
				ai:SetNumber(0, 1);	-- �_�b�V���؂蒆�͊����ݕs��
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal( GOAL_COMMON_Attack2, 10.0, 3070, TARGET_ENE_0, DIST_Middle, 0);
				return true
			end
		end	
	end
	
return false;
end

