-----------------------------------------------------------------------------------------------
--	�[�����m�i���E�R�j�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_honeTAIKEN402003_Battle, "honeTAIKEN402003Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_honeTAIKEN402003_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function honeTAIKEN402003Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐����@���̂R

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 2.8					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3001_Dist_min = 0.0					--3001�Ԃ̓K���ԍ����i�ŏ��j
local Att3001_Dist_max = 2.8					--3001�Ԃ̓K���ԍ����i�ő�j
local Att3002_Dist_min = 3.0					--3002�Ԃ̓K���ԍ����i�ŏ��j
local Att3002_Dist_max = 5.0					--3002�Ԃ̓K���ԍ����i�ő�j
local Att3003_Dist_min = 0.0					--3003�Ԃ̓K���ԍ����i�ŏ��j
local Att3003_Dist_max = 2.7					--3003�Ԃ̓K���ԍ����i�ő�j
local Att3004_Dist_min = 0.0					--3004�Ԃ̓K���ԍ����i�ŏ��j
local Att3004_Dist_max = 3.2					--3004�Ԃ̓K���ԍ����i�ő�j
local Att3303_Dist_min = 3.0					--3303�Ԃ̓K���ԍ����i�ŏ��j
local Att3303_Dist_max = 5.5					--3303�Ԃ̓K���ԍ����i�ő�j
local Att3300_Dist_min = 1.5					--3300�Ԃ̓K���ԍ����i�ŏ��j
local Att3300_Dist_max = 3.8					--3300�Ԃ̓K���ԍ����i�ő�j
local Att3301_Dist_min = 0.0					--3301�Ԃ̓K���ԍ����i�ŏ��j
local Att3301_Dist_max = 3.2					--3301�Ԃ̓K���ԍ����i�ő�j

local Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
local Act02Per = 0		--���s�ڋ߁��K�[�h����
local Act03Per = 0		--�_�b�V���ڋ߁�����3002�R���{	
local Act04Per = 0		--�_�b�V���ڋ߁��ߐ�3000�R���{
local Act05Per = 0		--�_�b�V���ڋ߁��ߐ�3003�R���{
local Act07Per = 0		--���s�ڋ߁��ߐ�3000�R���{
local Act08Per = 0		--���s�ڋ߁��ߐ�3003�R���{

	--�_�b�V�����ċߐڍU�����Ă��ǂ����x�ɗ���Ă���Ƃ�
	if targetDist >= 8.0 then
		--�K�[�h���Ă���Ƃ�
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 80		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 10		--�_�b�V���ڋ߁�����3002�R���{	
			Act04Per = 5		--�_�b�V���ڋ߁��ߐ�3000�R���{
			Act05Per = 5		--�_�b�V���ڋ߁��ߐ�3003�R���{
			Act07Per = 0		--���s�ڋ߁��ߐ�3000�R���{
			Act08Per = 0		--���s�ڋ߁��ߐ�3003�R���{
			
		--�K�[�h���Ă��Ȃ��Ƃ�
		else
			Act01Per = 5		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 55		--�_�b�V���ڋ߁�����3002�R���{	
			Act04Per = 20		--�_�b�V���ڋ߁��ߐ�3000�R���{
			Act05Per = 20		--�_�b�V���ڋ߁��ߐ�3003�R���{
			Act07Per = 0		--���s�ڋ߁��ߐ�3000�R���{
			Act08Per = 0		--���s�ڋ߁��ߐ�3003�R���{
		end
		
	--3002�U�����Ă��ǂ����x�ɗ���Ă���Ƃ�
	elseif targetDist >= 5.0 then
		--�K�[�h���Ă���Ƃ�
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 50		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 20		--���s�ڋ߁��K�[�h����
			Act03Per = 10		--�_�b�V���ڋ߁�����3002�R���{	
			Act04Per = 5		--�_�b�V���ڋ߁��ߐ�3000�R���{
			Act05Per = 5		--�_�b�V���ڋ߁��ߐ�3003�R���{
			Act07Per = 5		--���s�ڋ߁��ߐ�3000�R���{
			Act08Per = 5		--���s�ڋ߁��ߐ�3003�R���{
			
		--�K�[�h���Ă��Ȃ��Ƃ�
		else
			Act01Per = 5		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 45		--�_�b�V���ڋ߁�����3002�R���{	
			Act04Per = 15		--�_�b�V���ڋ߁��ߐ�3000�R���{
			Act05Per = 15		--�_�b�V���ڋ߁��ߐ�3003�R���{
			Act07Per = 10		--���s�ڋ߁��ߐ�3000�R���{
			Act08Per = 10		--���s�ڋ߁��ߐ�3003�R���{
		end
		
	--�����Ƌ߂��Ƃ�
	else
		--�K�[�h���Ă���Ƃ�
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 70		--���s�ڋ߁��K�[�h����
			Act03Per = 0		--�_�b�V���ڋ߁�����3002�R���{	
			Act04Per = 0		--�_�b�V���ڋ߁��ߐ�3000�R���{
			Act05Per = 0		--�_�b�V���ڋ߁��ߐ�3003�R���{
			Act07Per = 15		--���s�ڋ߁��ߐ�3000�R���{
			Act08Per = 15		--���s�ڋ߁��ߐ�3003�R���{
			
		--�K�[�h���Ă��Ȃ��Ƃ�
		else
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 10		--���s�ڋ߁��K�[�h����
			Act03Per = 0		--�_�b�V���ڋ߁�����3002�R���{	
			Act04Per = 0		--�_�b�V���ڋ߁��ߐ�3000�R���{
			Act05Per = 0		--�_�b�V���ڋ߁��ߐ�3003�R���{
			Act07Per = 45		--���s�ڋ߁��ߐ�3000�R���{
			Act08Per = 45		--���s�ڋ߁��ߐ�3003�R���{
		end		
	end
	
	--�s��01�@�_�b�V���ڋ߁��K�[�h����
	if fate2 <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3300_Dist_max, TARGET_ENE_0, false, 9910 );
		goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);	
		if fate3 <= 50 then
			honeTAIKEN402003Battle_Att3002(ai, goal)
		elseif fate3 <= 75 then
			honeTAIKEN402003Battle_Att3000(ai, goal)
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
			honeTAIKEN402003Battle_Att3003(ai, goal)
		end	
		
	--�s��02�@���s�ڋ߁��K�[�h����
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3300_Dist_max, TARGET_ENE_0, true, 9910 );
		goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);	
		if fate3 <= 50 then
			honeTAIKEN402003Battle_Att3002(ai, goal)
		elseif fate3 <= 75 then
			honeTAIKEN402003Battle_Att3000(ai, goal)
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
			honeTAIKEN402003Battle_Att3003(ai, goal)
		end	
		
	--�s��03�@�_�b�V���ڋ߁�����3002�R���{
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, false, 9910 );
		honeTAIKEN402003Battle_Att3002(ai, goal)
		
	--�s��04�@�_�b�V���ڋ߁��ߐ�3000�R���{
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, 9910 );
		honeTAIKEN402003Battle_Att3000(ai, goal)
		
	--�s��05�@�_�b�V���ڋ߁��ߐ�3003�R���{
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, false, 9910 );
		if fate3 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
		end
		honeTAIKEN402003Battle_Att3003(ai, goal)
		
	--�s��07�@���s�ڋ߁��ߐ�3000�R���{
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act07Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, 9910 );
		honeTAIKEN402003Battle_Att3000(ai, goal)
		
	--�s��08�@���s�ڋ߁��ߐ�3003�R���{
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, true, 9910 );
		if fate3 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
		end
		honeTAIKEN402003Battle_Att3003(ai, goal)
		
	end
	honeTAIKEN402003Battle_Kougeki_Noato(ai, goal)

end



---------------------------------------------------------
--  �ߐ�3000�R���{
---------------------------------------------------------
function honeTAIKEN402003Battle_Att3000(ai, goal)

local Att3000_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--10% 3000-3001
	--40% 3000-3001-3004-3003
	--30% 3000-3001-3000-3001
	--20% 3000-3001-3300
	if Att3000_fate <= 10 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3000_fate <= 50 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3000_fate <= 80 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
	end
end

---------------------------------------------------------
--  �ߐ�3003�R���{
---------------------------------------------------------
function honeTAIKEN402003Battle_Att3003(ai, goal)

local Att3003_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--10% 3003-3004
	--40% 3003-3004-3003-3301
	--35% 3004-3003-3000-3001
	--15% 3004-3003-3300
	if Att3003_fate <= 10 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3003_fate <= 50 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3003_fate <= 85 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
	end
end



---------------------------------------------------------
--  ����3002�R���{
---------------------------------------------------------
function honeTAIKEN402003Battle_Att3002(ai, goal)

local Att3002_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--30% 3002
	--50% 3002-3003-3301
	--20% 3002-3001-3000
	if Att3002_fate <= 30 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3002_fate <= 80 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		
	end
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function honeTAIKEN402003Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local myThinkId = ai:GetNpcThinkParamID()		--�v�lID���擾

local KNAct01Per	= 60	--�������Ȃ�
local KNAct02Per	= 0		--�E�X�e�b�v
local KNAct03Per	= 0		--���X�e�b�v
local KNAct04Per	= 0		--�S���S���ގU
local KNAct05Per	= 20	--�����������ړ�
local KNAct06Per	= 20	--�o�b�N�X�e�b�v�i�Z�[�t�e�B�j

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
function honeTAIKEN402003Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function honeTAIKEN402003Battle_Terminate(ai, goal)
end

---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function honeTAIKEN402003Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 2.8					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3001_Dist_min = 0.0					--3001�Ԃ̓K���ԍ����i�ŏ��j
local Att3001_Dist_max = 2.8					--3001�Ԃ̓K���ԍ����i�ő�j
local Att3002_Dist_min = 3.0					--3002�Ԃ̓K���ԍ����i�ŏ��j
local Att3002_Dist_max = 5.0					--3002�Ԃ̓K���ԍ����i�ő�j
local Att3003_Dist_min = 0.0					--3003�Ԃ̓K���ԍ����i�ŏ��j
local Att3003_Dist_max = 2.7					--3003�Ԃ̓K���ԍ����i�ő�j
local Att3004_Dist_min = 0.0					--3004�Ԃ̓K���ԍ����i�ŏ��j
local Att3004_Dist_max = 3.2					--3004�Ԃ̓K���ԍ����i�ő�j
local Att3303_Dist_min = 3.0					--3303�Ԃ̓K���ԍ����i�ŏ��j
local Att3303_Dist_max = 5.5					--3303�Ԃ̓K���ԍ����i�ő�j
local Att3300_Dist_min = 1.5					--3300�Ԃ̓K���ԍ����i�ŏ��j
local Att3300_Dist_max = 3.8					--3300�Ԃ̓K���ԍ����i�ő�j
local Att3301_Dist_min = 0.0					--3301�Ԃ̓K���ԍ����i�ŏ��j
local Att3301_Dist_max = 3.2					--3301�Ԃ̓K���ԍ����i�ő�j


	--�R���{����@�����ʊ֐�
local combRunDist = 2.0				--�R���{���ꂷ�鋗��
local combRunPer = 25				--�R���{���ꂷ��m��
	if Damaged_Act(ai, goal, combRunDist, combRunPer ) then
		goal:ClearSubGoal();
		--���艟��
		if fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
		end
		honeTAIKEN402003Battle_Att3003(ai, goal)
		honeTAIKEN402003Battle_Kougeki_Noato(ai, goal)
		return true;
	end	

	--�K�[�h���󂵂���U���@�����ʊ֐�
local guardBreakConutDist = 6.0			--�K�[�h����ōU�����鋗��
local guardBreakConutPer = 65			--�K�[�h����ōU������m��
	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
		goal:ClearSubGoal();
		--�����ʂɑΉ�
		--�֒f�̃S���S���U���i�����㓙�j
		if targetDist >= 4.0 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
			
		--�����U�艺�낵	
		elseif targetDist >= 3.0 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
			
		--�U�肩�Ԃ�ガ�U��
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
			
		end
		return true;
	end	
	
	--��ѓ���������Ă�����œK�s��
local ShootActPer	= 75	--��������m���i�߁j
local ShootActPer2	= 75	--��������m���i���j
local ShootActPer3	= 50	--��������m���i���j
local ShootActDist	= 2.7	--�������鋗���i�߁j
local ShootActDist2	= 5.0	--�������鋗���i���j
local ShootActDist3	= 30	--�������鋗���i���j

local ShootRessID =	FindShoot_Act(ai, goal, ShootActPer, ShootActPer2, ShootActPer3, ShootActDist, ShootActDist2, ShootActDist3)
	--�ߋ����Ŕ������錈�ӂ�����
	if ShootRessID == 1 then
		goal:ClearSubGoal();
		honeTAIKEN402003Battle_Att3003(ai, goal)
		honeTAIKEN402003Battle_Kougeki_Noato(ai, goal)
		return true;
		
	--�������Ŕ������錈�ӂ�����
	elseif ShootRessID == 2 then
		goal:ClearSubGoal();
		honeTAIKEN402003Battle_Att3002(ai, goal)
		honeTAIKEN402003Battle_Kougeki_Noato(ai, goal)
		return true;
		
	--�������Ŕ������錈�ӂ�����
	elseif ShootRessID == 3 then
		goal:ClearSubGoal();
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, false, 9910 );
		honeTAIKEN402003Battle_Att3002(ai, goal)
		honeTAIKEN402003Battle_Kougeki_Noato(ai, goal)
		return true;
	end

	return false;
end


