--[[---------------------------------------------------------------------------------------------
--	�}�X�^�[�T�c�L�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�

--	Number(0)�@�F�@�񕜖���g���񐔐���p
--�@Number(1)�@�F�@�퓬�J�n��������Ƒ҂���p

-----------------------------------------------------------------------------------------------]]
REGISTER_GOAL(GOAL_satuki830000_Battle, "satuki830000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_satuki830000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function satuki830000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋������擾
local waitDist = 25								--�U����������Ƒ҂���
local waitTime = 3.5							--�ŏ��̓����o���܂ł̎���

--[[------------------------------------------------------
-- �C�x���g���N�G�X�g�����āA����n����Ă����琽�Ɏ����ւ���
---------------------------------------------------------]]

	if ( 10 == ai:GetEventRequest() ) then
	CommonNPC_ChangeWepR2(ai, goal) 
	end

--[[------------------------------------------------------
-- �v���C���[���u���b�N�ɓ����Ă����Ƃ��Ɉ�񂾂�������Ƒ҂�
---------------------------------------------------------]]

	if targetDist >= waitDist then
		if ( 0 == ai:GetNumber(1) ) then
			goal:AddSubGoal( GOAL_COMMON_Wait, waitTime, TARGET_NONE, 0, 0, 0 );
		end
	end
	
	--�����҂��Ȃ�
	ai:SetNumber(1,1);
	satuki830000Battle_Normal_Act(ai, goal)
	
end

---------------------------------------------------------
-- ��{�s��
---------------------------------------------------------
function satuki830000Battle_Normal_Act(ai, goal)

local hprate = ai:GetHpRate( TARGET_SELF )		--������HP�������擾

	--������HP��3���ȉ��Ȃ�
	if hprate <= 0.3 then

		--10��܂ŉ񕜖���g��
		if ( 10 >= ai:GetNumber(0) ) then
		
			--�m���s��
			satuki830000Battle_Dying_Attack(ai, goal)
	local 	count = ai:GetNumber(0);
			count = count + 1;
			ai:SetNumber( 0, count ) ;

		end
	end

	--��{�U��
	satuki830000Battle_Normal_Attack(ai, goal)

end

---------------------------------------------------------
-- ��{�U��
---------------------------------------------------------
function satuki830000Battle_Normal_Attack(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local DashStart_Dist = 10.0			--�_�b�V���U�����J�n���鋗��
local NormalR_Dist = 2.0			--�E��U���̓K���ԍ���
local DashR_Dist = 5.0				--�_�b�V���U���̔�������

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q


	--�_�b�V���U���ł��鋗���Ȃ�
	if targetDist >= DashStart_Dist then
		
		--100% �_�b�V���U����A�ʏ�U��
		goal:AddSubGoal( GOAL_COMMON_DashAttack, 10.0, TARGET_ENE_0, DashR_Dist, NPC_ATK_NormalR, -1);
		satuki830000Battle_NormalR_Comb(ai, goal)
		satuki830000Battle_Kougeki_Noato(ai, goal)

	--�_�b�V���U���ł��Ȃ������Ȃ�
	elseif	targetDist >= NormalR_Dist then

		--100% �����ċ߂Â��čU��
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		satuki830000Battle_NormalR_Comb(ai, goal)
		satuki830000Battle_Kougeki_Noato(ai, goal)

	--�ɒ[�ɋ߂��Ȃ�
	else
		--30% �U��
		--70% �X�e�b�v�Ō��
		if fate <= 30 then
			satuki830000Battle_NormalR_Comb(ai, goal)
			satuki830000Battle_Kougeki_Noato(ai, goal)
		else
			if fate2 <= 20 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
			elseif fate2 <= 60 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			end
		end
	end
end


---------------------------------------------------------
-- �m���s��
---------------------------------------------------------
function satuki830000Battle_Dying_Attack(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local NormalR_Dist = 2.0			--�E��U���̓K���ԍ���
local ItemUesDist = 10.0			--�A�C�e�����g�������f���鋗��
local BackDist = 6.0				--�A�C�e���g�p�O�Ɍ�ނ��鋗��

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����Q

	--�����Ȃ�
	if targetDist >= ItemUesDist then
	
		--���̏�ŃA�C�e���g�p
		goal:AddSubGoal( GOAL_COMMON_UseItem, 10.0, 0 );
		satuki830000Battle_Kougeki_Noato(ai, goal)
		
	--�߂��Ȃ�
	elseif targetDist >= NormalR_Dist then
	
		--��ނ��ăA�C�e���g�p
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal( GOAL_COMMON_UseItem, 10.0, 0 );
		satuki830000Battle_Kougeki_Noato(ai, goal)

	--�ɒ[�ɋ߂��Ȃ�
	else
	
		--�U�����ĈЊd���Ă���X�e�b�v��ނ��ăA�C�e���g�p
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		
		--�X�e�b�v���
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
		
		--�ړ�
		if fate2 <= 50 then
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );
		else
			goal:AddSubGoal( GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 25, false, true ,-1 );
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );		
		end
		
		--�A�C�e���g�p
		goal:AddSubGoal( GOAL_COMMON_UseItem, 10.0, 0 );
		satuki830000Battle_Kougeki_Noato(ai, goal)

	end
end


---------------------------------------------------------
--  �E��R���{�i�ʏ�j
---------------------------------------------------------
function satuki830000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p
local NR_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local NR_fate3 = ai:GetRandam_Int(1,100)		--�m������p

	--70% �Ў�U��
	if NR_fate <= 70 then
	
		--�Ў莝���ɐ؂�ւ���
		CommonNPC_SwitchOneHandMode(ai, goal)
		
		--70% �Ў�U��4��
		if NR_fate2 <= 70 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		
		--30% �Ў�U��3��E������
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
		end
	
	--30% ����U��
	else
	
		--���莝���ɐ؂�ւ���
		CommonNPC_SwitchBothHandMode(ai, goal)
		
		--70% ����U��2��
		if NR_fate3 <= 70 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		
		--30% ����U��3��E������
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
			
		end
	end	
end

---------------------------------------------------------
--  �E��R���{�i�~�߁j
---------------------------------------------------------
function satuki830000Battle_Todome_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p

	--50% �Ў�U��
	--50% ����U��

	if NR_fate <= 50 then
		CommonNPC_SwitchBothHandMode(ai, goal)
		
	else
		CommonNPC_SwitchOneHandMode(ai, goal)
	
	end
	
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);

end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function satuki830000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local KN_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local BackDist = 2.5							--��ނ��鋗��

	--50% ���Ɉړ�
	--15% ���Ɉړ����Ă��牡�ړ�
	--20% �X�e�b�v�Ō��
	if KN_fate <= 65 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,55), false, true ,-1 );

	elseif KN_fate <= 80 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );				
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, false, true ,-1 );

	else
		if KN_fate2 <= 40 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
		elseif KN_fate2 <= 70 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
		end			
	end
end




---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function satuki830000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function satuki830000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function satuki830000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local NormalR_Dist = 2.0			--�E��U���̓K���ԍ���

	--��U�肵����U��
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 4.0			--��U��ǌ����鋗��
local MissSwingAttPer = 50			--��U��ǌ�����m��	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
				satuki830000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end	
	end

	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Č��
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--�R���{���ꂷ�鋗��
local combRunPer = 60				--�R���{���ꂷ��m��
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				if fate2 <= 20 then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
				elseif fate2 <= 60 then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
				else
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
				end	
				return true;
			end
		end
	end	
	
	--���ߋ����ōU�����ꂻ���ɂȂ����璴�����X�e�b�v
	if ai:IsInterupt( INTERUPT_FindAttack ) then
local superStepDist = 2.0			--���������鋗��
local superStepPer = 20				--����������m��	
		if targetDist <= superStepDist then
			if fate <= superStepPer then
			--�����
				if fate2 <= 20 then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
				elseif fate2 <= 60 then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
				else
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
				end
				return true;
			end
		end
	end
	
	--�K�[�h���󂵂���U��
	if ai:IsInterupt( INTERUPT_GuardBreak ) then
local guardBreakConutDist = 4.0			--�K�[�h����ōU�����鋗��
local guardBreakConutPer = 60			--�K�[�h����ōU������m��
		if targetDist <= guardBreakConutDist then
			if fate <= guardBreakConutPer then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
				satuki830000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end
	end
	
	--��ѓ���������Ă�����œK�s��
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 60					--��ѓ���g�p���ɍœK�s�������m��
		if fate <= shootIntPer then
			goal:ClearSubGoal();
			if fate2 <= 50 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			end
			return true
		end
	end
	
	--�A�C�e�����g������œK�s��
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 40			--�A�C�e���g�p���ɍœK�s�������m��
		if fate <= itemUseIntPer then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
				satuki830000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	
	--�G���K�[�h�I��������U��
	if ai:IsInterupt( INTERUPT_GuardFinish ) then
local GuardFinishAttackPer = 30			--�K�[�h�I����ɍU��������m��
		if fate <= GuardFinishAttackPer then
			goal:ClearSubGoal();
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			satuki830000Battle_NormalR_Comb(ai, goal)
			satuki830000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end

	--�G�̃K�[�h�ŕ��킪�͂����ꂽ�獶�E�X�e�b�v������i�E�D��j
	if ai:IsInterupt( INTERUPT_ReboundByOpponentGuard ) then
local GuardReboundMovePer = 30			--�͂����ꂽ���Ɉړ�������m��
		if fate <= GuardReboundMovePer then
			goal:ClearSubGoal();
			if fate2 <= 80 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			end
			return true;
		end
	end
	
return false;
end


