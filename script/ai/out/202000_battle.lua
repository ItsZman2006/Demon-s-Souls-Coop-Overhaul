-----------------------------------------------------------------------------------------------
--	�R�m�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Kisi202000_Battle, "kisi202000Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Kisi202000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function kisi202000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local hprate = ai:GetHpRate( TARGET_SELF )						--������HP�������擾

local fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂R
local fate4 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂S
local fate5 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂T

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 1.6					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3003_Dist_min = 2.5					--3003�Ԃ̓K���ԍ����i�ŏ��j
local Att3003_Dist_max = 4.3					--3003�Ԃ̓K���ԍ����i�ő�j
local Att3300_Dist_min = 0.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
local Att3300_Dist_max = 1.9					--3300�Ԃ̓K���ԍ����i�ő�j
local Att9800_Dist_min = 0.0					--9800�Ԃ̓K���ԍ����i�ŏ��j
local Att9800_Dist_max = 1.3					--9800�Ԃ̓K���ԍ����i�ő�j

local Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
local Act02Per = 0		--���s�ڋ߁��K�[�h����
local Act03Per = 0		--�_�b�V���ڋ߁��ːi�˂�	
local Act04Per = 0		--�_�b�V���ڋ߁��ߐڍU��
local Act05Per = 0		--���s�ڋ߁��ːi�˂�
local Act06Per = 0		--���s�ڋ߁����ߎa��
local Act07Per = 0		--���s�ڋ߁��ߐڍU��
local Act08Per = 0		--�񕜂��g��

	--�g�o�������Ă�����A���m���ŉ񕜖���g��
	if hprate <= 0.4 and fate <= 50 then
		Act08Per = 100		--�񕜂��g��
		
	--�����Ȃ�
	elseif targetDist >= 8.0 then
		--PC���w�������Ă�����
		if ai:IsInsideTargetEx( TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_B, 30.0, 100) then
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 95		--�_�b�V���ڋ߁��ːi�˂�	
			Act04Per = 5		--�_�b�V���ڋ߁��ߐڍU��
			Act05Per = 0		--���s�ڋ߁��ːi�˂�
			Act06Per = 0		--���s�ڋ߁����ߎa��
			Act07Per = 0		--���s�ڋ߁��ߐڍU��
			Act08Per = 0		--�񕜂��g��
			
		--PC���K�[�h���Ă�����	
		elseif ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 80		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 5		--���s�ڋ߁��K�[�h����
			Act03Per = 10		--�_�b�V���ڋ߁��ːi�˂�	
			Act04Per = 5		--�_�b�V���ڋ߁��ߐڍU��
			Act05Per = 0		--���s�ڋ߁��ːi�˂�
			Act06Per = 0		--���s�ڋ߁����ߎa��
			Act07Per = 0		--���s�ڋ߁��ߐڍU��
			Act08Per = 0		--�񕜂��g��
			
		--�ǂ���ł��Ȃ�������	
		else
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 50		--�_�b�V���ڋ߁��ːi�˂�	
			Act04Per = 20		--�_�b�V���ڋ߁��ߐڍU��
			Act05Per = 10		--���s�ڋ߁��ːi�˂�
			Act06Per = 5		--���s�ڋ߁����ߎa��
			Act07Per = 15		--���s�ڋ߁��ߐڍU��
			Act08Per = 0		--�񕜂��g��
			
		end	
		
	--�_�b�V�����Ă��ǂ����x�ɉ����Ȃ�	
	elseif targetDist >= 4.0 then	
		--PC���K�[�h���Ă�����
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 80		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 5		--���s�ڋ߁��K�[�h����
			Act03Per = 10		--�_�b�V���ڋ߁��ːi�˂�	
			Act04Per = 5		--�_�b�V���ڋ߁��ߐڍU��
			Act05Per = 0		--���s�ڋ߁��ːi�˂�
			Act06Per = 0		--���s�ڋ߁����ߎa��
			Act07Per = 0		--���s�ڋ߁��ߐڍU��
			Act08Per = 0		--�񕜂��g��
			
		else
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 0		--�_�b�V���ڋ߁��ːi�˂�	
			Act04Per = 25		--�_�b�V���ڋ߁��ߐڍU��
			Act05Per = 50		--���s�ڋ߁��ːi�˂�
			Act06Per = 10		--���s�ڋ߁����ߎa��
			Act07Per = 15		--���s�ڋ߁��ߐڍU��
			Act08Per = 0		--�񕜂��g��
			
		end
		
	--�ːi�˂����Ă��ǂ����x�ɉ����Ȃ�
	elseif targetDist >= 2.5 then	
		--PC���K�[�h���Ă�����80���̊m����	
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 80		--���s�ڋ߁��K�[�h����
			Act03Per = 0		--�_�b�V���ڋ߁��ːi�˂�	
			Act04Per = 0		--�_�b�V���ڋ߁��ߐڍU��
			Act05Per = 10		--���s�ڋ߁��ːi�˂�
			Act06Per = 5		--���s�ڋ߁����ߎa��
			Act07Per = 5		--���s�ڋ߁��ߐڍU��
			Act08Per = 0		--�񕜂��g��
			
		else
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 0		--�_�b�V���ڋ߁��ːi�˂�	
			Act04Per = 0		--�_�b�V���ڋ߁��ߐڍU��
			Act05Per = 45		--���s�ڋ߁��ːi�˂�
			Act06Per = 10		--���s�ڋ߁����ߎa��
			Act07Per = 45		--���s�ڋ߁��ߐڍU��
			Act08Per = 0		--�񕜂��g��
			
		end
		
	else	
		--PC���K�[�h���Ă�����80���̊m����	
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 80		--���s�ڋ߁��K�[�h����
			Act03Per = 0		--�_�b�V���ڋ߁��ːi�˂�	
			Act04Per = 0		--�_�b�V���ڋ߁��ߐڍU��
			Act05Per = 0		--���s�ڋ߁��ːi�˂�
			Act06Per = 5		--���s�ڋ߁����ߎa��
			Act07Per = 15		--���s�ڋ߁��ߐڍU��
			Act08Per = 0		--�񕜂��g��
			
		else
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 0		--�_�b�V���ڋ߁��ːi�˂�	
			Act04Per = 0		--�_�b�V���ڋ߁��ߐڍU��
			Act05Per = 0		--���s�ڋ߁��ːi�˂�
			Act06Per = 25		--���s�ڋ߁����ߎa��
			Act07Per = 75		--���s�ڋ߁��ߐڍU��
			Act08Per = 0		--�񕜂��g��
			
		end
	end

	--�s��01�@�_�b�V���ڋ߁��K�[�h����
	if fate2 <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att9800_Dist_max, TARGET_ENE_0, false, 9910 );
		goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 5.0, 9800, TARGET_ENE_0, DIST_Middle, 0);
		if fate3 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		end	
		
	--�s��02�@���s�ڋ߁��K�[�h����
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att9800_Dist_max, TARGET_ENE_0, true, 9910 );
		goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 5.0, 9800, TARGET_ENE_0, DIST_Middle, 0);
		if fate3 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		end	
		
	--�s��03�@�_�b�V���ڋ߁��ːi�˂�
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, false, 9910 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��04�@�_�b�V���ڋ߁��ߐڍU��
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, 9910 );
		kisi202000Battle_Kougeki(ai, goal)
		
	--�s��05�@���s�ڋ߁��ːi�˂�
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, true, 9910 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��06�@���s�ڋ߁����ߎa��
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3300_Dist_max, TARGET_ENE_0, true, 9910 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��07�@���s�ڋ߁��ߐڍU��
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, 9910 );
		kisi202000Battle_Kougeki(ai, goal)
		
	--�s��08�@�񕜖���g��
	else
		goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 3.0, TARGET_ENE_0, true, 9910 );				
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6200, TARGET_ENE_0, DIST_Far, 0);	
		
	end
	kisi202000Battle_Kougeki_Noato(ai, goal)
	
end

---------------------------------------------------------
--  �U��
---------------------------------------------------------
function kisi202000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--15���@3000-3001
	--70���@3000-3001-3002
	--10���@3000-3001-3300
	--5���@3002
	if K_fate <= 15 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 85 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 95 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function kisi202000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐���
local KN_fate2 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂Q

local SideTime = 4.0							--���ɓ�������
local BackDist = 2.5							--��ނ��鋗��
local BackTime = 4.0							--��ނ��鎞��

--���ɉ���������ɂƂ��ǂ����ړ�������Ɨǂ�����
--���܂�ɋ߂����鉡�ړ������A�������������Ă��牡�ړ�������Ɨǂ�����

	--55���@�������Ȃ�
	--30���@�K���ɉ��Ɉړ�
	--15���@�����������Ă��牡�Ɉړ�
	if KN_fate <= 55 then
		
	elseif KN_fate <= 85 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,9910 );
		
	else
		goal:AddSubGoal(GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, 9910 );
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,9910 );
	end
end




---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function kisi202000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function kisi202000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function kisi202000Battle_Interupt(ai, goal)

local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾
local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐����@���̂Q

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 1.6					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3003_Dist_min = 2.5					--3003�Ԃ̓K���ԍ����i�ŏ��j
local Att3003_Dist_max = 4.3					--3003�Ԃ̓K���ԍ����i�ő�j
local Att3300_Dist_min = 0.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
local Att3300_Dist_max = 1.9					--3300�Ԃ̓K���ԍ����i�ő�j
local Att9800_Dist_min = 0.0					--9800�Ԃ̓K���ԍ����i�ŏ��j
local Att9800_Dist_max = 1.3					--9800�Ԃ̓K���ԍ����i�ő�j


	--��U��ǂ������@�����ʊ֐�
local missSwingDist		= 4.3		--��U��ǌ����鋗��
local missSwingAttPer	= 10		--��U��ǌ�����m��
	if MissSwing_Act(ai, goal, missSwingDist, missSwingAttPer ) then
		goal:ClearSubGoal();
		--�����ʂɑΉ�
		if targetDist >= Att3003_Dist_min then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
			
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
		end
		kisi202000Battle_Kougeki_Noato(ai, goal)
		return true;
	end

	
	--�K�[�h���낵�ǂ������@�����ʊ֐�
local guardFinishConutDist	= 4.3		--�K�[�h�I���ōU�����鋗��
local guardFinishConutPer	= 10		--�K�[�h�I���ōU������m��
	if FindGuardFinish_Act(ai, goal, guardFinishConutDist, guardFinishConutPer ) then
		goal:ClearSubGoal();
		--�����ʂɑΉ�
		if targetDist >= Att3003_Dist_min then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
			
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
		end
		kisi202000Battle_Kougeki_Noato(ai, goal)
		return true;
	end

	-- �R���{����@�����ʊ֐�
local combRunDist		= 1.5		--�R���{���ꂷ�鋗��
local combRunPer		= 30		--�R���{���ꂷ��m��
	if Damaged_Act(ai, goal, combRunDist, combRunPer ) then
		goal:ClearSubGoal();
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 4.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,9910 );
		--���m���Ŕ���
		if fate2 <= 30 then
			goal:AddSubGoal(GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, Att3003_Dist_min, Att3003_Dist_max, TARGET_ENE_0, true, 9910 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
			kisi202000Battle_Kougeki_Noato(ai, goal)
		end
		return true;
	end	
	
	--�������K�[�h
	--�߂��ōU�����Ă���l��������
	if ai:IsInterupt( INTERUPT_FindAttack ) then
		if targetDist <= 2.0 then
			-- ���g�̂g�o������80���ȏ�Ȃ�
			if hprate >= 0.8 then
				--25���@�K�[�h�Ō��
				if fate <= 25 then
					goal:ClearSubGoal();
					goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 4.0, TARGET_ENE_0, 2.5, TARGET_ENE_0, true, 9910 );
					return true;
				end
				
			-- ���g�̂g�o������80���ȏ�łȂ��Ȃ�
			else
				--50���@�K�[�h�Ō��
				if fate <= 50 then
					goal:ClearSubGoal();
					goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 4.0, TARGET_ENE_0, 2.5, TARGET_ENE_0, true, 9910 );
					return true;
				end
			end
		end
	end


	--�K�[�h���󂵂���U���@�����ʊ֐�
local guardBreakConutDist = 4.3			--�K�[�h����ōU�����鋗��
local guardBreakConutPer = 65			--�K�[�h����ōU������m��
	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
		goal:ClearSubGoal();
		--�����ʂɑΉ�
		if targetDist >= Att3003_Dist_min then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
			
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
		end
		kisi202000Battle_Kougeki_Noato(ai, goal)
		return true;
	end	
	
	--��ѓ���ǂ�����
	--�^�[�Q�b�g����ѓ���𔭎˂�����A�������Ή��s��
	if ai:IsInterupt( INTERUPT_Shoot ) then
		if kisi202000Battle_Enkyori(ai, goal ) == true then
		return true
		end
	end
	
	--�A�C�e���g�p�ǂ�����
	--�^�[�Q�b�g���A�C�e�����g��������A�������Ή��s��
	if ai:IsInterupt( INTERUPT_UseItem ) then
		if kisi202000Battle_Enkyori(ai, goal ) == true then
		return true
		end
	end
	
	
return false;
end


---------------------------------------------------------
--  �������Ή�
---------------------------------------------------------
function kisi202000Battle_Enkyori(ai, goal )

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐���

local Att3003_Dist_max = 4.3					--3003�Ԃ̓K���ԍ����i�ő�j
local Att3300_Dist_max = 1.9					--3300�Ԃ̓K���ԍ����i�ő�j

	--���ߐ؂�̊ԍ����ȓ��Ȃ�
	if targetDist <= Att3300_Dist_max then
		--90���@���ߐ؂�
		if fate <= 90 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			kisi202000Battle_Kougeki_Noato(ai, goal)
			return true;
		end
		
	--�ːi�˂��̊ԍ����ȓ��Ȃ�	
	elseif targetDist <= Att3003_Dist_max then
		--90���@�ːi�˂�
		if fate <= 90 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
			kisi202000Battle_Kougeki_Noato(ai, goal)
			return true;
		end		
		
	--�������߂����Ȃ��Ȃ�	
	elseif targetDist <= 12.0 then
		--70���@�ːi�˂�
		if fate <= 70 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, false, 9910 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
			kisi202000Battle_Kougeki_Noato(ai, goal)
			return true;
		end
		
	--�����Ȃ�
	else
		--45���@�ːi�˂�
		if fate <= 45 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, false, 9910 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
			kisi202000Battle_Kougeki_Noato(ai, goal)
			return true;
		end
		
	end
	
return false
end


