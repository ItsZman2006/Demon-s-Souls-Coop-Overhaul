-----------------------------------------------------------------------------------------------
--	�[�����m�i���E�񓁗��j�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_honeNITOU402005_Battle, "honeNITOU402005Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_honeNITOU402005_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function honeNITOU402005Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐����@���̂R

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 2.9					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3001_Dist_min = 0.0					--3001�Ԃ̓K���ԍ����i�ŏ��j
local Att3001_Dist_max = 2.9					--3001�Ԃ̓K���ԍ����i�ő�j
local Att3002_Dist_min = 0.0					--3002�Ԃ̓K���ԍ����i�ŏ��j
local Att3002_Dist_max = 2.7					--3002�Ԃ̓K���ԍ����i�ő�j
local Att3003_Dist_min = 0.0					--3003�Ԃ̓K���ԍ����i�ŏ��j
local Att3003_Dist_max = 2.2					--3003�Ԃ̓K���ԍ����i�ő�j
local Att3300_Dist_min = 3.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
local Att3300_Dist_max = 4.2					--3300�Ԃ̓K���ԍ����i�ő�j
local Att3301_Dist_min = 0.0					--3301�Ԃ̓K���ԍ����i�ŏ��j
local Att3301_Dist_max = 2.6					--3301�Ԃ̓K���ԍ����i�ő�j
local Att3302_Dist_min = 0.0					--3302�Ԃ̓K���ԍ����i�ŏ��j
local Att3302_Dist_max = 3.0					--3302�Ԃ̓K���ԍ����i�ő�j
local Att3303_Dist_min = 4.0					--3303�Ԃ̓K���ԍ����i�ŏ��j
local Att3303_Dist_max = 5.4					--3303�Ԃ̓K���ԍ����i�ő�j
local Att3304_Dist_min = 0.0					--3304�Ԃ̓K���ԍ����i�ŏ��j
local Att3304_Dist_max = 2.9					--3304�Ԃ̓K���ԍ����i�ő�j

local Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
local Act02Per = 0		--���s�ڋ߁��K�[�h����
local Act03Per = 0		--�_�b�V���ڋ߁�3000or3002�R���{	
local Act04Per = 0		--�_�b�V���ڋ߁�������3300�R���{
local Act05Per = 0		--�_�b�V���ڋ߁��˂�3301�R���{
local Act06Per = 0		--���s�ڋ߁�3000or3002�R���{
local Act07Per = 0		--���s�ڋ߁�������3300�R���{
local Act08Per = 0		--���s�ڋ߁��˂�3301�R���{
local Act09Per = 0		--�_�b�V���ڋ߁���ъ|��3303�R���{
local Act10Per = 0		--���s�ڋ߁���ъ|��3303�R���{

	--�_�b�V�����Ĕ�ъ|���Ă��ǂ����x�ɗ���Ă��鎞
	if targetDist >= 9.0 then
		Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
		Act02Per = 0		--���s�ڋ߁��K�[�h����
		Act03Per = 0		--�_�b�V���ڋ߁�3000or3002�R���{	
		Act04Per = 5		--�_�b�V���ڋ߁�������3300�R���{
		Act05Per = 5		--�_�b�V���ڋ߁��˂�3301�R���{
		Act06Per = 0		--���s�ڋ߁�3000or3002�R���{
		Act07Per = 0		--���s�ڋ߁�������3300�R���{
		Act08Per = 0		--���s�ڋ߁��˂�3301�R���{		
		Act09Per = 90		--�_�b�V���ڋ߁���ъ|��3303�R���{
		Act10Per = 0		--���s�ڋ߁���ъ|��3303�R���{
		
	--�_�b�V������3300�U�����Ă��ǂ����x�ɗ���Ă���Ƃ�
	elseif targetDist >= 6.0 then
--		--�K�[�h���Ă���Ƃ�
--		if ai:IsTargetGuard( TARGET_ENE_0 ) then
--			Act01Per = 55		--�_�b�V���ڋ߁��K�[�h����
--			Act02Per = 5		--���s�ڋ߁��K�[�h����
--			Act03Per = 5		--�_�b�V���ڋ߁�3000or3002�R���{	
--			Act04Per = 5		--�_�b�V���ڋ߁�������3300�R���{
--			Act05Per = 5		--�_�b�V���ڋ߁��˂�3301�R���{
--			Act06Per = 0		--���s�ڋ߁�3000or3002�R���{
--			Act07Per = 5		--���s�ڋ߁�������3300�R���{
--			Act08Per = 0		--���s�ڋ߁��˂�3301�R���{
--			Act09Per = 0		--�_�b�V���ڋ߁���ъ|��3303�R���{
--			Act10Per = 20		--���s�ڋ߁���ъ|��3303�R���{
--			
--		--�K�[�h���Ă��Ȃ��Ƃ�
--		else
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 0		--�_�b�V���ڋ߁�3000or3002�R���{	
			Act04Per = 10		--�_�b�V���ڋ߁�������3300�R���{
			Act05Per = 5		--�_�b�V���ڋ߁��˂�3301�R���{
			Act06Per = 0		--���s�ڋ߁�3000or3002�R���{
			Act07Per = 5		--���s�ڋ߁�������3300�R���{
			Act08Per = 0		--���s�ڋ߁��˂�3301�R���{
			Act09Per = 0		--�_�b�V���ڋ߁���ъ|��3303�R���{
			Act10Per = 80		--���s�ڋ߁���ъ|��3303�R���{
--		end
		
	--3300�U�����Ă��ǂ��i��3303��ъ|�肵�Ă��ǂ��j���x�ɗ���Ă���Ƃ�
	elseif targetDist >= 4.2 then
--		--�K�[�h���Ă���Ƃ�
--		if ai:IsTargetGuard( TARGET_ENE_0 ) then
--			Act01Per = 55		--�_�b�V���ڋ߁��K�[�h����
--			Act02Per = 5		--���s�ڋ߁��K�[�h����
--			Act03Per = 10		--�_�b�V���ڋ߁�3000or3002�R���{	
--			Act04Per = 0		--�_�b�V���ڋ߁�������3300�R���{
--			Act05Per = 5		--�_�b�V���ڋ߁��˂�3301�R���{
--			Act06Per = 0		--���s�ڋ߁�3000or3002�R���{
--			Act07Per = 5		--���s�ڋ߁�������3300�R���{
--			Act08Per = 0		--���s�ڋ߁��˂�3301�R���{
--			Act09Per = 0		--�_�b�V���ڋ߁���ъ|��3303�R���{
--			Act10Per = 20		--���s�ڋ߁���ъ|��3303�R���{
--			
--		--�K�[�h���Ă��Ȃ��Ƃ�
--		else
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 5		--�_�b�V���ڋ߁�3000or3002�R���{	
			Act04Per = 0		--�_�b�V���ڋ߁�������3300�R���{
			Act05Per = 5		--�_�b�V���ڋ߁��˂�3301�R���{
			Act06Per = 0		--���s�ڋ߁�3000or3002�R���{
			Act07Per = 10		--���s�ڋ߁�������3300�R���{
			Act08Per = 0		--���s�ڋ߁��˂�3301�R���{
			Act09Per = 0		--�_�b�V���ڋ߁���ъ|��3303�R���{
			Act10Per = 80		--���s�ڋ߁���ъ|��3303�R���{
--		end
		
	--�����Ƌ߂��Ƃ�
	else
--		--�K�[�h���Ă���Ƃ�
--		if ai:IsTargetGuard( TARGET_ENE_0 ) then
--			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
--			Act02Per = 60		--���s�ڋ߁��K�[�h����
--			Act03Per = 0		--�_�b�V���ڋ߁�3000or3002�R���{	
--			Act04Per = 0		--�_�b�V���ڋ߁�������3300�R���{
--			Act05Per = 0		--�_�b�V���ڋ߁��˂�3301�R���{
--			Act06Per = 30		--���s�ڋ߁�3000or3002�R���{
--			Act07Per = 0		--���s�ڋ߁�������3300�R���{
--			Act08Per = 10		--���s�ڋ߁��˂�3301�R���{
--			Act09Per = 0		--�_�b�V���ڋ߁���ъ|��3303�R���{
--			Act10Per = 0		--���s�ڋ߁���ъ|��3303�R���{
--			
--		--�K�[�h���Ă��Ȃ��Ƃ�
--		else
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 15		--���s�ڋ߁��K�[�h����
			Act03Per = 0		--�_�b�V���ڋ߁�3000or3002�R���{	
			Act04Per = 0		--�_�b�V���ڋ߁�������3300�R���{
			Act05Per = 0		--�_�b�V���ڋ߁��˂�3301�R���{
			Act06Per = 70		--���s�ڋ߁�3000or3002�R���{
			Act07Per = 0		--���s�ڋ߁�������3300�R���{
			Act08Per = 15		--���s�ڋ߁��˂�3301�R���{
			Act09Per = 0		--�_�b�V���ڋ߁���ъ|��3303�R���{
			Act10Per = 0		--���s�ڋ߁���ъ|��3303�R���{
--		end		
	end
	
	--�s��01�@�_�b�V���ڋ߁��K�[�h����
	if fate2 <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3302_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 10.0, 3302, TARGET_ENE_0, DIST_Middle, 0);	
		if fate3 <= 75 then
			honeNITOU402005Battle_Att3301(ai, goal)
		else
			honeNITOU402005Battle_Att3000(ai, goal)
		end
		
	--�s��02�@���s�ڋ߁��K�[�h����
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3302_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 10.0, 3302, TARGET_ENE_0, DIST_Middle, 0);	
		if fate3 <= 75 then
			honeNITOU402005Battle_Att3301(ai, goal)
		else
			honeNITOU402005Battle_Att3000(ai, goal)
		end
		
	--�s��03�@�_�b�V���ڋ߁�3000or3002�R���{
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, false, -1 );
		honeNITOU402005Battle_Att3000(ai, goal)
		
	--�s��04�@�_�b�V���ڋ߁�������3300�R���{
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, -1 );
		honeNITOU402005Battle_Att3000(ai, goal)
		
	--�s��05�@�_�b�V���ڋ߁��˂�3301�R���{
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3301_Dist_max, TARGET_ENE_0, false, -1 );
		honeNITOU402005Battle_Att3301(ai, goal)	
		
	--�s��06�@���s�ڋ߁�3000or3002�R���{
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, true, -1 );
		honeNITOU402005Battle_Att3000(ai, goal)
		
	--�s��07�@���s�ڋ߁�������3300�R���{
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, -1 );
		honeNITOU402005Battle_Att3000(ai, goal)
		
	--�s��08�@���s�ڋ߁��˂�3301�R���{
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per + Act08Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3301_Dist_max, TARGET_ENE_0, true, -1 );
		honeNITOU402005Battle_Att3301(ai, goal)	
		
	--�s��09�@�_�b�V���ڋ߁���ъ|��3303�R���{
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per + Act08Per + Act09Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3303_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��10�@���s�ڋ߁���ъ|��3303�R���{	
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3303_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
		
	end
	honeNITOU402005Battle_Kougeki_Noato(ai, goal)

end



---------------------------------------------------------
--  3000or3002�R���{
---------------------------------------------------------
function honeNITOU402005Battle_Att3000(ai, goal)

local Att3000_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--20% 3001-3304
	--20% 3000-3002-3000-3001-3304
	--20% 3000-3001-3000-3002-3302
	--20% 3002-3000-3001-3304
	--20% 3002-3003-3002-3302
	
	if Att3000_fate <= 20 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3000_fate <= 40 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3000_fate <= 60 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3302, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3000_fate <= 80 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3302, TARGET_ENE_0, DIST_Middle, 0);
		
	end
end

---------------------------------------------------------
--  ������3300�R���{
---------------------------------------------------------
function honeNITOU402005Battle_Att3300(ai, goal)

local Att3300_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--20% 3300
	--50% 3300-3304
	--30% 3300-3000-3001-3302
	if Att3300_fate <= 20 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3300_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3302, TARGET_ENE_0, DIST_Middle, 0);
		
	end
end



---------------------------------------------------------
--  �˂�3301�R���{
---------------------------------------------------------
function honeNITOU402005Battle_Att3301(ai, goal)

local Att3301_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--100% 3301
	if Att3301_fate <= 100 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
		
	end
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function honeNITOU402005Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

local KNAct01Per	= 40	--�������Ȃ�
local KNAct02Per	= 0		--�E�X�e�b�v
local KNAct03Per	= 0		--���X�e�b�v
local KNAct04Per	= 0		--�S���S���ގU
local KNAct05Per	= 30	--�����������ړ�
local KNAct06Per	= 30	--�o�b�N�X�e�b�v�i�Z�[�t�e�B�j

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
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
		
	--�s��06�@�o�b�N�X�e�b�v
	else
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 4.0);
		
	end
end


	
	
---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function honeNITOU402005Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function honeNITOU402005Battle_Terminate(ai, goal)
end

---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function honeNITOU402005Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 2.9					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3001_Dist_min = 0.0					--3001�Ԃ̓K���ԍ����i�ŏ��j
local Att3001_Dist_max = 2.9					--3001�Ԃ̓K���ԍ����i�ő�j
local Att3002_Dist_min = 0.0					--3002�Ԃ̓K���ԍ����i�ŏ��j
local Att3002_Dist_max = 2.7					--3002�Ԃ̓K���ԍ����i�ő�j
local Att3003_Dist_min = 0.0					--3003�Ԃ̓K���ԍ����i�ŏ��j
local Att3003_Dist_max = 2.2					--3003�Ԃ̓K���ԍ����i�ő�j
local Att3300_Dist_min = 3.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
local Att3300_Dist_max = 4.2					--3300�Ԃ̓K���ԍ����i�ő�j
local Att3301_Dist_min = 0.0					--3301�Ԃ̓K���ԍ����i�ŏ��j
local Att3301_Dist_max = 2.6					--3301�Ԃ̓K���ԍ����i�ő�j
local Att3302_Dist_min = 0.0					--3301�Ԃ̓K���ԍ����i�ŏ��j
local Att3302_Dist_max = 3.0					--3301�Ԃ̓K���ԍ����i�ő�j
local Att3303_Dist_min = 4.0					--3303�Ԃ̓K���ԍ����i�ŏ��j
local Att3303_Dist_max = 5.4					--3303�Ԃ̓K���ԍ����i�ő�j
local Att3304_Dist_min = 0.0					--3304�Ԃ̓K���ԍ����i�ŏ��j
local Att3304_Dist_max = 2.9					--3304�Ԃ̓K���ԍ����i�ő�j

	--�R���{����@�����ʊ֐�
local combRunDist = 2.0				--�R���{���ꂷ�鋗��
local combRunPer = 25				--�R���{���ꂷ��m��
	if Damaged_Act(ai, goal, combRunDist, combRunPer ) then
		goal:ClearSubGoal();
		--���艟��
		if fate <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3302, TARGET_ENE_0, DIST_Middle, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
		end
		
		if fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 4.0);
		end
		return true;
	end	

	--�K�[�h���󂵂���U���@�����ʊ֐�
local guardBreakConutDist = 4.2			--�K�[�h����ōU�����鋗��
local guardBreakConutPer = 65			--�K�[�h����ōU������m��
	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
		goal:ClearSubGoal();
		--�����ʂɑΉ�
		--������
		if targetDist >= Att3300_Dist_min then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
			
		end
		return true;
	end	
	
	--��ѓ���������Ă�����œK�s��
local ShootActPer	= 75	--��������m���i�߁j
local ShootActPer2	= 75	--��������m���i���j
local ShootActPer3	= 50	--��������m���i���j
local ShootActDist	= 2.6	--�������鋗���i�߁j
local ShootActDist2	= 4.2	--�������鋗���i���j
local ShootActDist3	= 30	--�������鋗���i���j

local ShootRessID =	FindShoot_Act(ai, goal, ShootActPer, ShootActPer2, ShootActPer3, ShootActDist, ShootActDist2, ShootActDist3)
	--�ߋ����Ŕ������錈�ӂ�����
	if ShootRessID == 1 then
		goal:ClearSubGoal();
		honeNITOU402005Battle_Att3301(ai, goal)	
		honeNITOU402005Battle_Kougeki_Noato(ai, goal)
		return true;
		
	--�������Ŕ������錈�ӂ�����
	elseif ShootRessID == 2 then
		goal:ClearSubGoal();
		honeNITOU402005Battle_Att3300(ai, goal)	
		honeNITOU402005Battle_Kougeki_Noato(ai, goal)
		return true;
		
	--�������Ŕ������錈�ӂ�����
	elseif ShootRessID == 3 then
		goal:ClearSubGoal();
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3303_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
		honeNITOU402005Battle_Kougeki_Noato(ai, goal)
		return true;
	end

	return false;
end


