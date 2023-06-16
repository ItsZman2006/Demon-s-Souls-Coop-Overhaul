-----------------------------------------------------------------------------------------------
--	arasiSensi602000��p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�

-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_ArasiSensi602000_Battle, "ArasiSensi602000Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_ArasiSensi602000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function ArasiSensi602000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐���	
local fate2 = ai:GetRandam_Int(1,100)
local fate3 = ai:GetRandam_Int(1,100)
local fate4 = ai:GetRandam_Int(1,100)

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 4.8					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3001_Dist_min = 0.0					--3001�Ԃ̓K���ԍ����i�ŏ��j
local Att3001_Dist_max = 4.5					--3001�Ԃ̓K���ԍ����i�ő�j
local Att3002_Dist_min = 0.0					--3002�Ԃ̓K���ԍ����i�ŏ��j
local Att3002_Dist_max = 6.8					--3002�Ԃ̓K���ԍ����i�ő�j
local Att3003_Dist_min = 0.0					--3003�Ԃ̓K���ԍ����i�ŏ��j
local Att3003_Dist_max = 3.7					--3003�Ԃ̓K���ԍ����i�ő�j
local Att3302_Dist_min = 8.5					--3302�Ԃ̓K���ԍ����i�ŏ��j
local Att3302_Dist_max = 15.0					--3302�Ԃ̓K���ԍ����i�ő�j
local Att3304_Dist_min = 3.0					--3304�Ԃ̓K���ԍ����i�ŏ��j
local Att3304_Dist_max = 8.2					--3304�Ԃ̓K���ԍ����i�ő�j
local Att3306_Dist_min = 0.0					--3306�Ԃ̓K���ԍ����i�ŏ��j
local Att3306_Dist_max = 6.2					--3306�Ԃ̓K���ԍ����i�ő�j

local Act01Per = 0		--�_�b�V������э���
local Act02Per = 0		--�_�b�V����3304�R���{
local Act03Per = 0		--�_�b�V����3306�R���{
local Act04Per = 0		--�_�b�V����3000�R���{
local Act05Per = 0		--�P���ガ
local Act06Per = 0		--�P���A�b�p�[
local Act07Per = 0		--�P������
--local Act08Per = 0		--�i�\���j

	--�{��̖ҍU�@�{���Ă��Ȃ��Ƃ���logic�œ���

	--����Ɖ����Ȃ�
	if targetDist >= 15.0 then
		Act01Per = 85		--�_�b�V������э���
		Act02Per = 10		--�_�b�V����3304�R���{
		Act03Per = 5		--�_�b�V����3306�R���{
		Act04Per = 0		--�_�b�V����3000�R���{
		Act05Per = 0		--�P���ガ
		Act06Per = 0		--�P���A�b�p�[
		Act07Per = 0		--�P������
		
	--��э��݁@�œK�ԍ���
	elseif targetDist >= 9.0 then
		Act01Per = 75		--�_�b�V������э���
		Act02Per = 20		--�_�b�V����3304�R���{
		Act03Per = 5		--�_�b�V����3306�R���{
		Act04Per = 0		--�_�b�V����3000�R���{
		Act05Per = 0		--�P���ガ
		Act06Per = 0		--�P���A�b�p�[
		Act07Per = 0		--�P������
		
	--3304�R���{�@�œK�ԍ���
	elseif targetDist >= 6.2 then
		Act01Per = 0		--�_�b�V������э���
		Act02Per = 80		--�_�b�V����3304�R���{
		Act03Per = 15		--�_�b�V����3306�R���{
		Act04Per = 5		--�_�b�V����3000�R���{
		Act05Per = 0		--�P���ガ
		Act06Per = 0		--�P���A�b�p�[
		Act07Per = 0		--�P������
		
	--3306�R���{�@�œK�ԍ���
	elseif targetDist >= 4.8 then
		Act01Per = 0		--�_�b�V������э���
		Act02Per = 5		--�_�b�V����3304�R���{
		Act03Per = 40		--�_�b�V����3306�R���{
		Act04Per = 5		--�_�b�V����3000�R���{
		Act05Per = 50		--�P���ガ
		Act06Per = 0		--�P���A�b�p�[
		Act07Per = 0		--�P������
		
	--3000�R���{�@�œK�ԍ���
	elseif targetDist >= 2.5 then
		Act01Per = 0		--�_�b�V������э���
		Act02Per = 0		--�_�b�V����3304�R���{
		Act03Per = 10		--�_�b�V����3306�R���{
		Act04Per = 55		--�_�b�V����3000�R���{
		Act05Per = 10		--�P���ガ
		Act06Per = 5		--�P���A�b�p�[
		Act07Per = 20		--�P������
		
	--�P�������@�œK�ԍ���
	else
		Act01Per = 0		--�_�b�V������э���
		Act02Per = 0		--�_�b�V����3304�R���{
		Act03Per = 10		--�_�b�V����3306�R���{
		Act04Per = 25		--�_�b�V����3000�R���{
		Act05Per = 0		--�P���ガ
		Act06Per = 35		--�P���A�b�p�[
		Act07Per = 30		--�P������
		
	end

	--�s��01�@�_�b�V������э���
	if fate2 <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3302_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3302, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��02�@�_�b�V����3304�R���{
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3304_Dist_max, TARGET_ENE_0, false, -1 );
		ArasiSensi602000Battle_Att3304(ai, goal)
		
	--�s��03�@�_�b�V����3306�R���{
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, false, -1 );
		ArasiSensi602000Battle_Att3306(ai, goal)
		
	--�s��04�@�_�b�V����3000�R���{
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, -1 );
		ArasiSensi602000Battle_Att3000(ai, goal)
		
	--�s��05�@�P���ガ
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per) then
		goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��06�@�P���A�b�p�[
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per) then	
		goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��07�@�P������
	else
		goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	end
	ArasiSensi602000Battle_Kougeki_Noato(ai, goal)
	
end

---------------------------------------------------------
--  3304�R���{
---------------------------------------------------------
function ArasiSensi602000Battle_Att3304(ai, goal)

local Att3304_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--60�� 3304-3305-3306
	--30�� 3304-3305
	--10�� 3304-3305-3306-3001
--	if Att3304_fate <= 60 then
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3305, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);
--		
--	elseif Att3304_fate <= 90 then
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3305, TARGET_ENE_0, DIST_Middle, 0);
--		
--	else
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3305, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);	--Attack
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
--	end
	
	
	--60�� 3304
	--40�� 3304-3001
	if Att3304_fate <= 60 then
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	end	
	
	
end


---------------------------------------------------------
--  3306�R���{
---------------------------------------------------------
function ArasiSensi602000Battle_Att3306(ai, goal)

local Att3306_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--30�� 3306-3304-3305-3306
	--60�� 3306-3304-3305
	--10�� 3306-3304-3305-3306-3001
--	if Att3306_fate <= 30 then
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3305, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);
--		
--	elseif Att3306_fate <= 90 then
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3305, TARGET_ENE_0, DIST_Middle, 0);
--		
--	else
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3305, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);	--Attack
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
--	end


	--30�� 3306
	--40�� 3306-3304
	--30�� 3306-3304-3001
	if Att3306_fate <= 30 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3306_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	end	
	
	
end


---------------------------------------------------------
--  3000�R���{
---------------------------------------------------------
function ArasiSensi602000Battle_Att3000(ai, goal)

local Att3000_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--40�� 3000-3304-3305-3306
	--50�� 3000-3304-3305
	--10�� 3000-3304-3305-3306-3001
--	if Att3000_fate <= 40 then
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3305, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);
--		
--	elseif Att3000_fate <= 90 then
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3305, TARGET_ENE_0, DIST_Middle, 0);
--		
--	else
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3305, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
--	end
	
	--35�� 3000
	--15�� 3000-3001
	--35�� 3000-3002
	--15�� 3000-3002-3001
	if Att3000_fate <= 35 then
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3000_fate <= 50 then
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3000_fate <= 85 then
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	end
	
	
end



---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function ArasiSensi602000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

local KNAct01Per	= 70	--�������Ȃ�
local KNAct02Per	= 5		--�E�X�e�b�v
local KNAct03Per	= 5		--���X�e�b�v
local KNAct04Per	= 0		--�����������ړ�
local KNAct05Per	= 15	--�o�b�N�X�e�b�v
local KNAct06Per	= 5		--�O�X�e�b�v

	--�s��01�@�������Ȃ�
	if  KN_fate <= KNAct01Per then
   		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.0,1.0) ,0,0,0,0)
		
	--�s��02�@�E�X�e�b�v
	elseif  KN_fate <= (KNAct01Per + KNAct02Per) then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 703, TARGET_ENE_0, 0);
		
	--�s��03�@���X�e�b�v
	elseif  KN_fate <= (KNAct01Per + KNAct02Per + KNAct03Per) then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 702, TARGET_ENE_0, 0);
		
	--�s��04�@�����������ړ�
	elseif  KN_fate <= (KNAct01Per + KNAct02Per + KNAct03Per + KNAct04Per) then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
		
	--�s��05�@�o�b�N�X�e�b�v
	elseif  KN_fate <= (KNAct01Per + KNAct02Per + KNAct03Per + KNAct04Per + KNAct05Per) then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 701, TARGET_ENE_0, 0);
		
	else	
	--�s��06�@�O�X�e�b�v
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 700, TARGET_ENE_0, 0);
		
	end
end


---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function ArasiSensi602000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function ArasiSensi602000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function ArasiSensi602000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐���	
local fate2 = ai:GetRandam_Int(1,100)
local fate3 = ai:GetRandam_Int(1,100)
local fate4 = ai:GetRandam_Int(1,100)

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 4.8					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3001_Dist_min = 0.0					--3001�Ԃ̓K���ԍ����i�ŏ��j
local Att3001_Dist_max = 4.5					--3001�Ԃ̓K���ԍ����i�ő�j
local Att3002_Dist_min = 0.0					--3002�Ԃ̓K���ԍ����i�ŏ��j
local Att3002_Dist_max = 6.8					--3002�Ԃ̓K���ԍ����i�ő�j
local Att3003_Dist_min = 0.0					--3003�Ԃ̓K���ԍ����i�ŏ��j
local Att3003_Dist_max = 3.7					--3003�Ԃ̓K���ԍ����i�ő�j
local Att3302_Dist_min = 8.5					--3302�Ԃ̓K���ԍ����i�ŏ��j
local Att3302_Dist_max = 15.0					--3302�Ԃ̓K���ԍ����i�ő�j
local Att3304_Dist_min = 3.0					--3304�Ԃ̓K���ԍ����i�ŏ��j
local Att3304_Dist_max = 8.2					--3304�Ԃ̓K���ԍ����i�ő�j
local Att3306_Dist_min = 0.0					--3306�Ԃ̓K���ԍ����i�ŏ��j
local Att3306_Dist_max = 6.2					--3306�Ԃ̓K���ԍ����i�ő�j

	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Č��or����
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist	 = 3.0			--�R���{���ꂷ�鋗��
local combRunPer	 = 60			--�R���{���ꂷ��m��
		if targetDist <= combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				if fate2 <= 25 then
					--�����
					if fate3 <= 60 then
						goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 701, TARGET_ENE_0, 0.0, AI_DIR_TYPE_B, 3);
					elseif fate3 <= 80 then
						goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 702, TARGET_ENE_0, 0.0, AI_DIR_TYPE_L, 3);
					else
						goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 703, TARGET_ENE_0, 0.0, AI_DIR_TYPE_R, 3);
					end
					
				else
					if fate3 <= 30 then
						goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
					else
						ArasiSensi602000Battle_Att3000(ai, goal)
					end
					ArasiSensi602000Battle_Kougeki_Noato(ai, goal)
				end	
					
				return true;
			end
		end
	end	

	--��ѓ���������Ă�����œK�s��
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 60					--��ѓ���g�p���ɍœK�s�������m���i�߂��Ƃ��j
local shootIntPer2 = 60					--��ѓ���g�p���ɍœK�s�������m���i��≓���Ƃ��j
local shootIntPer3 = 80					--��ѓ���g�p���ɍœK�s�������m���i�����Ƃ��j
local Per2_Dist = 2.5					--�u��≓���v�̋���
local Per3_Dist = 8.5					--�u�����v�̋���

		--�߂�
		if targetDist <= Per2_Dist then
			if fate <= shootIntPer then
				goal:ClearSubGoal();
				if fate2 <= 40 then
					goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
				end
				return true
			end
			
		--��≓��
		elseif targetDist <= Per3_Dist then
			if fate <= shootIntPer2 then
				goal:ClearSubGoal();
				if fate2 <= 70 then
					goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, -1 );
					ArasiSensi602000Battle_Att3000(ai, goal)
				else
					goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, false, -1 );
					ArasiSensi602000Battle_Att3306(ai, goal)
				end
				return true
			end
			
		--����
		else
			if fate <= shootIntPer3 then
				goal:ClearSubGoal();
				if fate2 <= 80 then
					goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3302_Dist_max, TARGET_ENE_0, false, -1 );
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3302, TARGET_ENE_0, DIST_Middle, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3304_Dist_max, TARGET_ENE_0, false, -1 );
					ArasiSensi602000Battle_Att3304(ai, goal)
				end
				return true
			end	
		end
	end


	
return false;
end

