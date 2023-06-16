-----------------------------------------------------------------------------------------------
--	�`���[�g���A���E��ʕ��m�i�Ή��j �퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_IppanLONG_B200012_Battle, "ippanLONG_B200012Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_IppanLONG_B200012_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function ippanLONG_B200012Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local role = ai:GetTeamOrder(ORDER_TYPE_Role);			--�����̖������擾
local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾

local targetDist = ai:GetDist(TARGET_ENE_0);						--�G�^�[�Q�b�g�Ƃ̋������擾
local targetDistY = ai:GetDistYSigned(TARGET_ENE_0);				--�G�^�[�Q�b�g�Ƃ̍��፷���擾

local fate = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐����@���̂R

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 1.5					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3003_Dist_min = 4.0					--3003�Ԃ̓K���ԍ����i�ŏ��j
local Att3003_Dist_max = 5.5					--3003�Ԃ̓K���ԍ����i�ő�j
local Att3300_Dist_min = 0.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
local Att3300_Dist_max = 1.5					--3300�Ԃ̓K���ԍ����i�ő�j

local Att3002_Dist_min = 0.0					--3002�Ԃ̓K���ԍ����i�ŏ��j
local Att3002_Dist_max = 0.7					--3002�Ԃ̓K���ԍ����i�ő�j
local Att6060_Dist_min = 2.0					--6060�Ԃ̓K���ԍ����i�ŏ��j
local Att6060_Dist_max = 5.0					--6060�Ԃ̓K���ԍ����i�ő�j

local Act01Per = 0		--�������Ȃ�
local Act02Per = 0		--�i�\���j
local Act03Per = 0		--�i�\���j
local Act04Per = 0		--�i�\���j	
local Act05Per = 0		--���s�ԍ����������Ή��r
local Act06Per = 0		--���s�ڋ߁��ߐڍU��
local Act07Per = 0		--�R��
local Act08Per = 0		--�񕜂��g��

local absDistY = math.abs(targetDistY);		--��Βl���Ƃ�
local myBlockId = ai:GetMyBlockID();		--�����̂���u���b�N

	--�u���b�N�ɂ��K�[�h���ݒ�i�K�[�h���Ȃ����j
local Guard			   = 9910							--�K�[�h�ԍ���錾
local fateG = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐����@�ԊO��
	if myBlockId == 0 and fateG <= 60 then
		Guard			 = 0
	elseif myBlockId == 1 and fateG <= 40 then
		Guard			 = 0
	elseif myBlockId == 2 and fateG <= 20 then
		Guard			 = 0
	elseif myBlockId == 3 and fateG <= 10 then
		Guard			 = 0
	else
		Guard			 = 0
	end	


	--�g�o�������Ă�����A���m���ŉ񕜖���g��
	if (hprate <= 0.4) and (fate <= 50) and (myBlockId == 1 or myBlockId == 2 or myBlockId == 3) then
		Act08Per = 100		--�񕜂��g��
		
	--�������A�����������œ͂������Ȃ�
	elseif targetDist >= 5.0 and targetDistY < 0.0 and targetDist <= (5.0 + math.sqrt(absDistY) + (absDistY / 4) ) then
		Act01Per = 0		--�������Ȃ�
		Act02Per = 100		--���̏�œ�����
		Act03Per = 0		--�i�\���j
		Act04Per = 0		--�i�\���j	
		Act05Per = 0		--���s�ԍ����������Ή��r
		Act06Per = 0		--���s�ڋ߁��ߐڍU��
		Act07Per = 0		--�R��
		Act08Per = 0		--�񕜂��g��
		
	--������Ɖ����āA�͂��������Ȃ��Ȃ�
	elseif targetDist >= 5.0 then
		Act01Per = 100		--�������Ȃ�
		Act02Per = 0		--���̏�œ�����
		Act03Per = 0		--�i�\���j
		Act04Per = 0		--�i�\���j	
		Act05Per = 0		--���s�ԍ����������Ή��r
		Act06Per = 0		--���s�ڋ߁��ߐڍU��
		Act07Per = 0		--�R��
		Act08Per = 0		--�񕜂��g��
		
	--�Ή��r�𓊂��Ă��ς���Ȃ����x�ɉ����Ȃ�
	elseif targetDist >= 2.0 then
		Act01Per = 0		--�������Ȃ�
		Act02Per = 0		--���̏�œ�����
		Act03Per = 0		--�i�\���j
		Act04Per = 0		--�i�\���j	
		Act05Per = 100		--���s�ԍ����������Ή��r
		Act06Per = 0		--���s�ڋ߁��ߐڍU��
		Act07Per = 0		--�R��
		Act08Per = 0		--�񕜂��g��
		
	--�R��ɂ͉������A�Ή��r�ɂ͉������x�Ȃ�
	elseif targetDist >= 0.7 then
		Act01Per = 0		--�������Ȃ�
		Act02Per = 0		--���̏�œ�����
		Act03Per = 0		--�i�\���j
		Act04Per = 0		--�i�\���j	
		Act05Per = 30		--���s�ԍ����������Ή��r
		Act06Per = 70		--���s�ڋ߁��ߐڍU��
		Act07Per = 0		--�R��
		Act08Per = 0		--�񕜂��g��
		
	--�����Ƌ߂��Ȃ�
	else
		Act01Per = 0		--�������Ȃ�
		Act02Per = 0		--���̏�œ�����
		Act03Per = 0		--�i�\���j
		Act04Per = 0		--�i�\���j	
		Act05Per = 40		--���s�ԍ����������Ή��r
		Act06Per = 60		--���s�ڋ߁��ߐڍU��
		Act07Per = 0		--�R��
		Act08Per = 0		--�񕜂��g��
		
	end

	--�퓬�p�̃A�j���Z�b�g�ɐ؂�ւ��܂�
	ai:ChangeMoveAnimParam(2)

	--�U�����A���̑����Ȃ�
	if role == ROLE_TYPE_Attack or role == ROLE_TYPE_None then
		
		--�s��01�@�������Ȃ�
		if fate2 <= Act01Per then
			goal:AddSubGoal(GOAL_COMMON_Wait, 1.0, TARGET_ENE_0, 0, 0, 0 );
			
		--�s��02�@���̏�œ�����
		elseif fate2 <= (Act01Per + Act02Per) then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6060, TARGET_ENE_0, DIST_Far, 0);
			goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(1.0,3.0), TARGET_ENE_0, 0, 0, 0 );
			
		--�s��03�@�i�\���j
		elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
			goal:AddSubGoal(GOAL_COMMON_Wait, 1.0, TARGET_ENE_0, 0, 0, 0 );
			
		--�s��04�@�i�\���j	
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
			goal:AddSubGoal(GOAL_COMMON_Wait, 1.0, TARGET_ENE_0, 0, 0, 0 );
			
		--�s��05�@���s�ԍ����������Ή��r
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per) then
			goal:AddSubGoal(GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, Att6060_Dist_min, Att6060_Dist_max, TARGET_ENE_0, true, Guard );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6060, TARGET_ENE_0, DIST_Far, 0);
			goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(1.0,3.0), TARGET_ENE_0, 0, 0, 0 );
			
		--�s��06�@���s�ڋ߁��ߐڍU��
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per) then	
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, Guard );
			ippanLONG_B200012Battle_Kougeki(ai, goal)	
			ippanLONG_B200012Battle_Kougeki_Noato(ai, goal, Guard)	
			
		--�s��07�@�R��
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per) then	
			--�u���b�N3or4�Ȃ�R��
			if (myBlockId == 2 or myBlockId == 3) then
				goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, true, Guard );
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Near, 0);
				
			--�u���b�N1or2�Ȃ�ʏ�U��
			else
				goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, Guard );
				ippanLONG_B200012Battle_Kougeki(ai, goal)	
				ippanLONG_B200012Battle_Kougeki_Noato(ai, goal, Guard)	
			end
			
		--�s��08�@�񕜂��g��
		else
			goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 3.0, TARGET_ENE_0, true, Guard );				
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6200, TARGET_ENE_0, DIST_Far, 0);
			ippanLONG_B200012Battle_Kougeki_Noato(ai, goal, Guard)	
		end
		
	--��芪�����Ȃ�
	elseif role == ROLE_TYPE_Torimaki then
		--������΁A�����ċ߂Â��Ă���
		if targetDist >= 20.0 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 9.5, TARGET_ENE_0, false, -1 );
		--�߂���΁A�����ċ߂Â��Ă���
		elseif targetDist >= 11.0 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 9.5, TARGET_ENE_0, true, -1 );
		--�K�x�ȋ����Ȃ�΁A���ɓ���
		elseif targetDist >= 8.0 then
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,Guard );
		--�߂�����΁A�����
		else
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 9.0, TARGET_ENE_0, true, Guard );
		end
		--�U������ۂ��E���E��
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,Guard );
		
		
	--�ϏO���Ȃ�
	else
		--������΁A�����ċ߂Â��Ă���
		if targetDist >= 20.0 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 11.5, TARGET_ENE_0, false, -1 );
		--�߂���΁A�����ċ߂Â��Ă���
		elseif targetDist >= 13.0 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 11.5, TARGET_ENE_0, true, -1 );
		--�K�x�ȋ����Ȃ�΁A���ɓ���
		elseif targetDist >= 9.0 then
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,Guard );
		--�߂�����΁A�����
		else
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 11.0, TARGET_ENE_0, true, Guard );
		end
		--�U������ۂ��E���E��
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,Guard );
		
	end
	
end


---------------------------------------------------------
--  �U��
---------------------------------------------------------
function ippanLONG_B200012Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local K_fate2 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--15% 3000
	--40% 3000-3001
	--15% 3300
	--30% 3000-3001-3300
	if K_fate <= 15 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 55 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function ippanLONG_B200012Battle_Kougeki_Noato(ai, goal, Guard)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local SideTime = 3.0							--���ɓ�������
local BackDist = 2.5							--��ނ��鋗��
local BackTime = 3.0							--��ނ��鎞��

local bRight = ai:GetRandam_Int(0,1);			--���E�ړ��̕���
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- ���������ɍ��E�ړ����Ă��钇�Ԃ̐�


	--60% �Ȃɂ����Ȃ�
	--20% �K���ɉ��ɃK�[�h�ړ�
	--20% ���ɃK�[�h�ړ�
	if KN_fate <= 60  and friendNum < 1 then
		
	elseif KN_fate <= 80  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, bRight, ai:GetRandam_Int(30,45), true, true ,Guard );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, Guard );				
	end
end



---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function ippanLONG_B200012Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function ippanLONG_B200012Battle_Terminate(ai, goal)
	--��퓬���̃A�j���Z�b�g�ɐ؂�ւ��܂�
	ai:ChangeMoveAnimParam(0)
end

---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function ippanLONG_B200012Battle_Interupt(ai, goal)

local role = ai:GetTeamOrder(ORDER_TYPE_Role);			--�����̖������擾
local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾

local targetDist = ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐����@���̂R

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 1.5					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3003_Dist_min = 4.0					--3003�Ԃ̓K���ԍ����i�ŏ��j
local Att3003_Dist_max = 5.5					--3003�Ԃ̓K���ԍ����i�ő�j
local Att3300_Dist_min = 0.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
local Att3300_Dist_max = 1.5					--3300�Ԃ̓K���ԍ����i�ő�j

local Att3002_Dist_min = 0.0					--3002�Ԃ̓K���ԍ����i�ŏ��j
local Att3002_Dist_max = 0.7					--3002�Ԃ̓K���ԍ����i�ő�j
local Att6060_Dist_min = 2.0					--6060�Ԃ̓K���ԍ����i�ŏ��j
local Att6060_Dist_max = 5.0					--6060�Ԃ̓K���ԍ����i�ő�j

local myThinkId = ai:GetNpcThinkParamID()		--�v�lID���擾
local myBlockId = ai:GetMyBlockID();			--�����̂���u���b�N

	--�u���b�N�ɂ��K�[�h���ݒ�i�K�[�h���Ȃ����j
local fateG = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐����@�ԊO��
	if myBlockId == 0 and fateG <= 60 then
		Guard			 = 0
	elseif myBlockId == 1 and fateG <= 40 then
		Guard			 = 0
	elseif myBlockId == 2 and fateG <= 20 then
		Guard			 = 0
	elseif myBlockId == 3 and fateG <= 10 then
		Guard			 = 0
	else
		Guard			 = 0
	end	

	-- �R���{����@�����ʊ֐�
local combRunDist		= 1.5		--�R���{���ꂷ�鋗��
local combRunPer		= 30		--�R���{���ꂷ��m��
	if Damaged_Act(ai, goal, combRunDist, combRunPer ) then
		goal:ClearSubGoal();
		--�K�[�h
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,9910 );
		return true;
	end	

	-- �R���{����i�񋤒ʁj
	if ai:IsInterupt( INTERUPT_Damaged ) then
		if targetDist >= 5.0 and fate <= 90 then
			goal:ClearSubGoal();
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 5.0, TARGET_ENE_0, false, 9910 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6060, TARGET_ENE_0, DIST_Far, 0);
			ippanLONG_B200012Battle_Kougeki_Noato(ai, goal, Guard)	
			return true;		
			
		elseif targetDist <= 5.0 and fate <= 30 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,9910 );
			return true;		
		end
	end	


	--�K�[�h���󂵂���U���@�����ʊ֐�
local guardBreakConutDist = Att6060_Dist_max	--�K�[�h����ōU�����鋗��
local guardBreakConutPer = 65					--�K�[�h����ōU������m��
	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
		goal:ClearSubGoal();
		--�����ʂɑΉ�
		if targetDist >= Att6060_Dist_min then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 6060, TARGET_ENE_0, DIST_Far, 0);
			
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
		end
		ippanLONG_B200012Battle_Kougeki_Noato(ai, goal, Guard)
		return true;
	end		

	
	--��U��ǂ������@�����ʊ֐�
local missSwingDist		= 5.0		--��U��ǌ����鋗��
local missSwingAttPer	= 10		--��U��ǌ�����m��
	if MissSwing_Act(ai, goal, missSwingDist, missSwingAttPer ) then
		goal:ClearSubGoal();
		--�����ʂɑΉ�
		if targetDist >= Att6060_Dist_min then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 6060, TARGET_ENE_0, DIST_Far, 0);
			
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
		end
		ippanLONG_B200012Battle_Kougeki_Noato(ai, goal, Guard)
		return true;
	end	
	
	
return false;
end