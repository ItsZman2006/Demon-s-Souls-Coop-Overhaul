-----------------------------------------------------------------------------------------------
--	��ʕ��m�i�`���[�g���A���E�ア�^�p���B�p�j�@�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_IppanLONG200010_Battle, "ippanLONG200010Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_IppanLONG200010_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function ippanLONG200010Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local role = ai:GetTeamOrder(ORDER_TYPE_Role);					--�����̖������擾

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐����@���̂R

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 1.5					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3003_Dist_min = 0.0					--3003�Ԃ̓K���ԍ����i�ŏ��j
local Att3003_Dist_max = 1.5					--3003�Ԃ̓K���ԍ����i�ő�j
local Att3300_Dist_min = 0.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
local Att3300_Dist_max = 1.5					--3300�Ԃ̓K���ԍ����i�ő�j
local Guard			   = 9910					--�K�[�h�\�Ȃ�9910�@�s�Ȃ�0

local Att3002_Dist_min = 0.0					--3002�Ԃ̓K���ԍ����i�ŏ��j
local Att3002_Dist_max = 0.7					--3002�Ԃ̓K���ԍ����i�ő�j
local Att6060_Dist_min = 2.0					--6060�Ԃ̓K���ԍ����i�ŏ��j
local Att6060_Dist_max = 5.0					--6060�Ԃ̓K���ԍ����i�ő�j

local myThinkId = ai:GetNpcThinkParamID()		--�v�lID���擾

	--���킲�Ƃ̓K���ԍ�����ݒ�
	--�K�[�h�ł��邩�ǂ�����ݒ�
	if myThinkId == 201000 or myThinkId == 201004 then				--��
		Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
		Att3000_Dist_max = 1.6					--3000�Ԃ̓K���ԍ����i�ő�j
		Att3003_Dist_min = 4.0					--3003�Ԃ̓K���ԍ����i�ŏ��j
		Att3003_Dist_max = 5.5					--3003�Ԃ̓K���ԍ����i�ő�j
		Att3300_Dist_min = 0.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
		Att3300_Dist_max = 1.5					--3300�Ԃ̓K���ԍ����i�ő�j
		Guard			 = 9910					--�K�[�h�\�Ȃ�9910�@�s�Ȃ�0
		
	elseif  myThinkId == 201006 then		--�X�s�A
		Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
		Att3000_Dist_max = 2.8					--3000�Ԃ̓K���ԍ����i�ő�j
		Att3003_Dist_min = 3.5					--3003�Ԃ̓K���ԍ����i�ŏ��j
		Att3003_Dist_max = 4.8					--3003�Ԃ̓K���ԍ����i�ő�j
		Att3300_Dist_min = 0.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
		Att3300_Dist_max = 2.3					--3300�Ԃ̓K���ԍ����i�ő�j
		Guard			 = 9910					--�K�[�h�\�Ȃ�9910�@�s�Ȃ�0
		
	elseif  myThinkId == 201007 then		--�A�N�X
		Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
		Att3000_Dist_max = 1.1					--3000�Ԃ̓K���ԍ����i�ő�j
		Att3003_Dist_min = 3.7					--3003�Ԃ̓K���ԍ����i�ŏ��j
		Att3003_Dist_max = 5.3					--3003�Ԃ̓K���ԍ����i�ő�j
		Att3300_Dist_min = 0.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
		Att3300_Dist_max = 2.0					--3300�Ԃ̓K���ԍ����i�ő�j
		Guard			 = 9910					--�K�[�h�\�Ȃ�9910�@�s�Ȃ�0
		
	elseif  myThinkId == 201008 then		--�n���o�[�h
		Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
		Att3000_Dist_max = 2.3					--3000�Ԃ̓K���ԍ����i�ő�j
		Att3003_Dist_min = 4.0					--3003�Ԃ̓K���ԍ����i�ŏ��j
		Att3003_Dist_max = 6.2					--3003�Ԃ̓K���ԍ����i�ő�j
		Att3300_Dist_min = 0.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
		Att3300_Dist_max = 2.5					--3300�Ԃ̓K���ԍ����i�ő�j
		Guard			 = 0					--�K�[�h�\�Ȃ�9910�@�s�Ȃ�0
		
	else
		--�����ɗ��Ă͂����Ȃ�
	end

local Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
local Act02Per = 0		--���s�ڋ߁��K�[�h����
local Act03Per = 0		--�_�b�V���ڋ߁������U��
local Act04Per = 0		--�_�b�V���ԍ����������Ή��r	
local Act05Per = 0		--�_�b�V���ڋ߁����ߎa��
local Act06Per = 0		--�_�b�V���ڋ߁��ߐڍU��
local Act07Per = 0		--���s�ڋ߁������U��
local Act08Per = 0		--���s�ԍ����������Ή��r	
local Act09Per = 0		--���s�ڋ߁����ߎa��
local Act10Per = 0		--���s�ڋ߁��ߐڍU��
local Act11Per = 0		--�񕜂��g��

	--�����Ȃ�
	if targetDist >= 8.0 then
		--PC���K�[�h���Ă�����	
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 0		--�_�b�V���ڋ߁������U��
			Act04Per = 0		--�_�b�V���ԍ����������Ή��r	
			Act05Per = 0		--�_�b�V���ڋ߁����ߎa��
			Act06Per = 50		--�_�b�V���ڋ߁��ߐڍU��
			Act07Per = 0		--���s�ڋ߁������U��
			Act08Per = 0		--���s�ԍ����������Ή��r	
			Act09Per = 0		--���s�ڋ߁����ߎa��
			Act10Per = 50		--���s�ڋ߁��ߐڍU��
			Act11Per = 0		--�񕜂��g��
			
		--�����łȂ����	
		else
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 5		--�_�b�V���ڋ߁������U��
			Act04Per = 0		--�_�b�V���ԍ����������Ή��r	
			Act05Per = 0		--�_�b�V���ڋ߁����ߎa��
			Act06Per = 50		--�_�b�V���ڋ߁��ߐڍU��
			Act07Per = 5		--���s�ڋ߁������U��
			Act08Per = 0		--���s�ԍ����������Ή��r	
			Act09Per = 0		--���s�ڋ߁����ߎa��
			Act10Per = 40		--���s�ڋ߁��ߐڍU��
			Act11Per = 0		--�񕜂��g��
			
		end	
		
	--�_�b�V�����Ă��ǂ����x�ɉ����Ȃ�	
	elseif targetDist >= 4.0 then	
		--PC���K�[�h���Ă�����	
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 10		--�_�b�V���ڋ߁������U��
			Act04Per = 0		--�_�b�V���ԍ����������Ή��r	
			Act05Per = 0		--�_�b�V���ڋ߁����ߎa��
			Act06Per = 35		--�_�b�V���ڋ߁��ߐڍU��
			Act07Per = 5		--���s�ڋ߁������U��
			Act08Per = 0		--���s�ԍ����������Ή��r	
			Act09Per = 0		--���s�ڋ߁����ߎa��
			Act10Per = 50		--���s�ڋ߁��ߐڍU��
			Act11Per = 0		--�񕜂��g��
			
		else
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 0		--�_�b�V���ڋ߁������U��
			Act04Per = 0		--�_�b�V���ԍ����������Ή��r	
			Act05Per = 0		--�_�b�V���ڋ߁����ߎa��
			Act06Per = 30		--�_�b�V���ڋ߁��ߐڍU��
			Act07Per = 20		--���s�ڋ߁������U��
			Act08Per = 0		--���s�ԍ����������Ή��r	
			Act09Per = 10		--���s�ڋ߁����ߎa��
			Act10Per = 40		--���s�ڋ߁��ߐڍU��
			Act11Per = 0		--�񕜂��g��
			
		end
		
	--�����U�����Ă��ǂ����x�ɉ����Ȃ�
	elseif targetDist >= Att3003_Dist_max then	
		--PC���K�[�h���Ă�����	
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 0		--�_�b�V���ڋ߁������U��
			Act04Per = 0		--�_�b�V���ԍ����������Ή��r	
			Act05Per = 0		--�_�b�V���ڋ߁����ߎa��
			Act06Per = 0		--�_�b�V���ڋ߁��ߐڍU��
			Act07Per = 30		--���s�ڋ߁������U��
			Act08Per = 0		--���s�ԍ����������Ή��r	
			Act09Per = 0		--���s�ڋ߁����ߎa��
			Act10Per = 70		--���s�ڋ߁��ߐڍU��
			Act11Per = 0		--�񕜂��g��
			
		else
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 0		--�_�b�V���ڋ߁������U��
			Act04Per = 0		--�_�b�V���ԍ����������Ή��r	
			Act05Per = 0		--�_�b�V���ڋ߁����ߎa��
			Act06Per = 0		--�_�b�V���ڋ߁��ߐڍU��
			Act07Per = 20		--���s�ڋ߁������U��
			Act08Per = 0		--���s�ԍ����������Ή��r	
			Act09Per = 10		--���s�ڋ߁����ߎa��
			Act10Per = 70		--���s�ڋ߁��ߐڍU��
			Act11Per = 0		--�񕜂��g��
		end
		
	--�߂��Ȃ�	
	else	
		--PC���K�[�h���Ă�����
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 0		--�_�b�V���ڋ߁������U��
			Act04Per = 0		--�_�b�V���ԍ����������Ή��r	
			Act05Per = 0		--�_�b�V���ڋ߁����ߎa��
			Act06Per = 0		--�_�b�V���ڋ߁��ߐڍU��
			Act07Per = 20		--���s�ڋ߁������U��
			Act08Per = 0		--���s�ԍ����������Ή��r	
			Act09Per = 20		--���s�ڋ߁����ߎa��
			Act10Per = 60		--���s�ڋ߁��ߐڍU��
			Act11Per = 0		--�񕜂��g��
			
		else
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 0		--�_�b�V���ڋ߁������U��
			Act04Per = 0		--�_�b�V���ԍ����������Ή��r	
			Act05Per = 0		--�_�b�V���ڋ߁����ߎa��
			Act06Per = 0		--�_�b�V���ڋ߁��ߐڍU��
			Act07Per = 0		--���s�ڋ߁������U��
			Act08Per = 0		--���s�ԍ����������Ή��r	
			Act09Per = 25		--���s�ڋ߁����ߎa��
			Act10Per = 75		--���s�ڋ߁��ߐڍU��
			Act11Per = 0		--�񕜂��g��
			
		end
	end

	-- �ŏ��ɂ�����Ƃ����҂�
	if ai:IsFinishTimer(0) == true then
		local firstTime = ai:GetRandam_Float(0.0, 1.0)			--�ŏ��̓����o���܂ł̎���
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
		ai:SetTimer( 0, 9999.0 );
	end

	--�퓬�p�̃A�j���Z�b�g�ɐ؂�ւ��܂�
	ai:ChangeMoveAnimParam(2)

	--�U�����A���̑����Ȃ�
	if role == ROLE_TYPE_Attack or role == ROLE_TYPE_None then
		
		--�s��01�@�_�b�V���ڋ߁��K�[�h����
		if fate2 <= Act01Per then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
			if fate3 <= 90 then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6060, TARGET_ENE_0, DIST_Far, 0);
			end	
			
		--�s��02�@���s�ڋ߁��K�[�h����
		elseif fate2 <= (Act01Per + Act02Per) then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);		
			if fate3 <= 90 then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6060, TARGET_ENE_0, DIST_Far, 0);
			end	
			
		--�s��03�@�_�b�V���ڋ߁������U��
		elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);		
			
		--�s��04�@�_�b�V���ԍ����������Ή��r	
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
			goal:AddSubGoal(GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, Att6060_Dist_min, Att6060_Dist_max, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6060, TARGET_ENE_0, DIST_Far, 0);			
			
		--�s��05�@�_�b�V���ڋ߁����ߎa��
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per) then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3300_Dist_max, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);	
			
		--�s��06�@�_�b�V���ڋ߁��ߐڍU��
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per) then	
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, -1 );
			ippanLONG200010Battle_Kougeki(ai, goal)	
			
		--�s��07�@���s�ڋ߁������U��
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per) then	
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);	
			
		--�s��08�@���s�ԍ����������Ή��r	
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per + Act08Per) then
			goal:AddSubGoal(GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, Att6060_Dist_min, Att6060_Dist_max, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6060, TARGET_ENE_0, DIST_Far, 0);	
			
		--�s��09�@���s�ڋ߁����ߎa��
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per + Act08Per + Act09Per) then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3300_Dist_max, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);		
			
		--�s��10�@���s�ڋ߁��ߐڍU��
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per + Act08Per + Act09Per + Act10Per) then	
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, -1 );
			ippanLONG200010Battle_Kougeki(ai, goal)			
			
		--�s��11�@�񕜂��g��
		else
			goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 8.0, TARGET_ENE_0, true, -1 );				
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6200, TARGET_ENE_0, DIST_Far, 0);		
		end
		ippanLONG200010Battle_Kougeki_Noato(ai, goal)
		
		
	--��芪�����Ȃ�
	elseif role == ROLE_TYPE_Torimaki then
		--������΁A�����ċ߂Â��Ă���
		if targetDist >= 15.0 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 4.5, TARGET_ENE_0, false, -1 );
		--�߂���΁A�����ċ߂Â��Ă���
		elseif targetDist >= 6.0 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 4.5, TARGET_ENE_0, true, -1 );
		--�K�x�ȋ����Ȃ�΁A���ɓ���
		elseif targetDist >= 3.0 then
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
		--�߂�����΁A�����
		else
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, true, -1 );
		end
		--�U������ۂ��E���E��
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
		
		
	--�ϏO���Ȃ�
	else
		--������΁A�����ċ߂Â��Ă���
		if targetDist >= 15.0 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 6.5, TARGET_ENE_0, false, -1 );
		--�߂���΁A�����ċ߂Â��Ă���
		elseif targetDist >= 8.0 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 6.5, TARGET_ENE_0, true, -1 );
		--�K�x�ȋ����Ȃ�΁A���ɓ���
		elseif targetDist >= 4.0 then
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
		--�߂�����΁A�����
		else
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 6.0, TARGET_ENE_0, true, -1 );
		end
		--�U������ۂ��E���E��
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
		
	end
end


---------------------------------------------------------
--  �U��
---------------------------------------------------------
function ippanLONG200010Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local K_fate2 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--5% 3000
	--70% 3000-3001
	--20% 3000-3001-3300
	--5%  3001
	if K_fate <= 5 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 75 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 95 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	end
end

	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function ippanLONG200010Battle_Kougeki_Noato(ai, goal, Guard)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local SideTime = 3.0							--���ɓ�������
local BackDist = 2.5							--��ނ��鋗��
local BackTime = 3.0							--��ނ��鎞��

local bRight = ai:GetRandam_Int(0,1);			--���E�ړ��̕���
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- ���������ɍ��E�ړ����Ă��钇�Ԃ̐�


	--35% �Ȃɂ����Ȃ��i������Ƃ������ړ��j
	--40% �K���ɉ��ɃK�[�h�ړ�
	--35% ���ɃK�[�h�ړ�
	if KN_fate <= 35  and friendNum < 1 then
		
	elseif KN_fate <= 65  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
	else
		goal:AddSubGoal(GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, Guard );
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
	end
end



---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function ippanLONG200010Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function ippanLONG200010Battle_Terminate(ai, goal)
	--��퓬���̃A�j���Z�b�g�ɐ؂�ւ��܂�
	ai:ChangeMoveAnimParam(0)
end

---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function ippanLONG200010Battle_Interupt(ai, goal)

--local targetDist = ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
--local fate = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐���
--local fate2 = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐����@���̂Q
--local fate3 = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐����@���̂R
	
--local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
--local Att3000_Dist_max = 1.5					--3000�Ԃ̓K���ԍ����i�ő�j
--local Att3003_Dist_min = 0.0					--3003�Ԃ̓K���ԍ����i�ŏ��j
--local Att3003_Dist_max = 1.5					--3003�Ԃ̓K���ԍ����i�ő�j
--local Att3300_Dist_min = 0.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
--local Att3300_Dist_max = 1.5					--3300�Ԃ̓K���ԍ����i�ő�j
--local Guard			   = 9910					--�K�[�h�\�Ȃ�9910�@�s�Ȃ�0

--local Att3002_Dist_min = 0.0					--3002�Ԃ̓K���ԍ����i�ŏ��j
--local Att3002_Dist_max = 0.7					--3002�Ԃ̓K���ԍ����i�ő�j
--local Att6060_Dist_min = 2.0					--6060�Ԃ̓K���ԍ����i�ŏ��j
--local Att6060_Dist_max = 5.0					--6060�Ԃ̓K���ԍ����i�ő�j

--local myThinkId = ai:GetNpcThinkParamID()		--�v�lID���擾

	--���킲�Ƃ̓K���ԍ�����ݒ�
	--�K�[�h�ł��邩�ǂ�����ݒ�
--	if myThinkId == 201000 or myThinkId == 201004 then	--��
--		Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
--		Att3000_Dist_max = 1.6					--3000�Ԃ̓K���ԍ����i�ő�j
--		Att3003_Dist_min = 4.0					--3003�Ԃ̓K���ԍ����i�ŏ��j
--		Att3003_Dist_max = 5.5					--3003�Ԃ̓K���ԍ����i�ő�j
--		Att3300_Dist_min = 0.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
--		Att3300_Dist_max = 1.5					--3300�Ԃ̓K���ԍ����i�ő�j
--		Guard			 = 9910					--�K�[�h�\�Ȃ�9910�@�s�Ȃ�0
		
--	elseif  myThinkId == 201006 then		--�X�s�A
--		Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
--		Att3000_Dist_max = 2.8					--3000�Ԃ̓K���ԍ����i�ő�j
--		Att3003_Dist_min = 3.5					--3003�Ԃ̓K���ԍ����i�ŏ��j
--		Att3003_Dist_max = 4.8					--3003�Ԃ̓K���ԍ����i�ő�j
--		Att3300_Dist_min = 0.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
--		Att3300_Dist_max = 2.3					--3300�Ԃ̓K���ԍ����i�ő�j
--		Guard			 = 9910					--�K�[�h�\�Ȃ�9910�@�s�Ȃ�0
		
--	elseif  myThinkId == 201007 then		--�A�N�X
--		Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
--		Att3000_Dist_max = 1.1					--3000�Ԃ̓K���ԍ����i�ő�j
--		Att3003_Dist_min = 3.7					--3003�Ԃ̓K���ԍ����i�ŏ��j
--		Att3003_Dist_max = 5.3					--3003�Ԃ̓K���ԍ����i�ő�j
--		Att3300_Dist_min = 0.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
--		Att3300_Dist_max = 2.0					--3300�Ԃ̓K���ԍ����i�ő�j
--		Guard			 = 9910					--�K�[�h�\�Ȃ�9910�@�s�Ȃ�0
		
--	elseif  myThinkId == 201008 then		--�n���o�[�h
--		Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
--		Att3000_Dist_max = 2.3					--3000�Ԃ̓K���ԍ����i�ő�j
--		Att3003_Dist_min = 4.0					--3003�Ԃ̓K���ԍ����i�ŏ��j
--		Att3003_Dist_max = 6.2					--3003�Ԃ̓K���ԍ����i�ő�j
--		Att3300_Dist_min = 0.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
--		Att3300_Dist_max = 2.5					--3300�Ԃ̓K���ԍ����i�ő�j
--		Guard			 = 0					--�K�[�h�\�Ȃ�9910�@�s�Ȃ�0
		
--	else
		--�����ɗ��Ă͂����Ȃ�
--	end


	-- �R���{����@�����ʊ֐�
--local combRunDist		= 1.0		--�R���{���ꂷ�鋗��
--local combRunPer		= 50		--�R���{���ꂷ��m��
--	if Damaged_Act(ai, goal, combRunDist, combRunPer ) then
--		goal:ClearSubGoal();
		--�K�[�h�ł���l�̓K�[�h
--		if Guard == 9910 then
--			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,Guard );
--		else
		--�K�[�h�o���Ȃ��l�͍U��
--			ippanLONG200010Battle_Kougeki(ai, goal)
--			ippanLONG200010Battle_Kougeki_Noato(ai, goal, Guard)
--		end
--		return true;
--	end	

	--�K�[�h���󂵂���U���@�����ʊ֐�
--local guardBreakConutDist = Att3003_Dist_max	--�K�[�h����ōU�����鋗��
--local guardBreakConutPer = 65					--�K�[�h����ōU������m��
--	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
--		goal:ClearSubGoal();
		--�����ʂɑΉ�
--		if targetDist >= Att3003_Dist_min then
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
			
--		else
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
--		end
--		ippanLONG200010Battle_Kougeki_Noato(ai, goal, Guard)
--		return true;
--	end		

	--��U��ǂ������@�����ʊ֐�
--local missSwingDist		= 5.0		--��U��ǌ����鋗��
--local missSwingAttPer	= 10		--��U��ǌ�����m��
--	if MissSwing_Act(ai, goal, missSwingDist, missSwingAttPer ) then
--		goal:ClearSubGoal();
		--�����ʂɑΉ�
--		if targetDist >= 2.0 then
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6060, TARGET_ENE_0, DIST_Far, 0);
			
--		else
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
--		end
--		ippanLONG200010Battle_Kougeki_Noato(ai, goal, Guard)
--		return true;
--	end	

	
return false;
end


