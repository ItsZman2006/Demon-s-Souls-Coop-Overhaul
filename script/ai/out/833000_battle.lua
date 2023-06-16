-----------------------------------------------------------------------------------------------
--	�����҃u���b�N��p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_OKINA_833000_Battle, "OKINA_833000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_OKINA_833000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function OKINA_833000Battle_Activate(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q

local farDist = 15.0						--�����Ɣ��f���鋗��
local nearDist = 4.0						--�߂��Ɣ��f���鋗��
local NormalR_Dist = 0.5			--�E��U���̓K���ԍ���
local DashR_Dist = 3.0				--�_�b�V���U���̔�������

	--����ɕ���������Ă��Ȃ���Ύ����ւ���
	CommonNPC_ChangeWepL1(ai, goal)

	--�������Ȃ����A�߂����Ȃ��Ȃ�
	if targetDist >= nearDist then

		if fate <= 20 then
			OKINA_833000Battle_Magic_Comb(ai, goal)
		elseif fate <= 40 then
			goal:AddSubGoal( GOAL_COMMON_DashAttack, 10.0, TARGET_ENE_0, DashR_Dist, NPC_ATK_NormalR, -1);
			OKINA_833000Battle_NormalR_Comb(ai, goal)
			OKINA_833000Battle_Kougeki_Noato(ai, goal)
		else
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			OKINA_833000Battle_NormalR_Comb(ai, goal)
			OKINA_833000Battle_Kougeki_Noato(ai, goal)
		end
		
	--�߂��Ȃ�
	elseif targetDist >= NormalR_Dist then
		--100���@�����ċ߂Â��Ă���	
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			OKINA_833000Battle_NormalR_Comb(ai, goal)
			OKINA_833000Battle_Kougeki_Noato(ai, goal)
		
	--�ɒ[�ɋ߂��Ȃ�
	else
		--65���@�U��
		--35���@�X�e�b�v�Ō��
		if fate <= 75 then
			OKINA_833000Battle_NormalR_Comb(ai, goal)
			OKINA_833000Battle_Kougeki_Noato(ai, goal)
		else
			if fate2 <= 50 then
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, ai:GetRandam_Int(3,5), TARGET_ENE_0, false, -1 );
			else
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, ai:GetRandam_Int(2,4), TARGET_ENE_0, false, -1 );
				goal:AddSubGoal( GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,55), false, true ,-1 );
			end
		end
	end
end

---------------------------------------------------------
--  �E��R���{
---------------------------------------------------------
function OKINA_833000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p
local NR_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local NR_fate3 = ai:GetRandam_Int(1,100)		--�m������p
local NR_fate4 = ai:GetRandam_Int(1,100)		--�m������p

	
	--15���@�E���E���E
	if NR_fate <= 15 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		
		--40���@�ǉ��@��
		if NR_fate2 <= 40 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		end
	
	--15���@���E��
	elseif NR_fate <= 30 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		
		--35���@�ǉ��@��
		if NR_fate2 <= 35 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		end
	
	--15���@���E�E�E
	elseif NR_fate <= 45 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);

	--15���@��
	elseif NR_fate <= 60 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);	
	
	--40���@�O�]�E
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepF, TARGET_ENE_0, DIST_None, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Middle, 0);
		
		--30���@�ǉ��@�E�E
		if NR_fate2 <= 30 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		end
		
		--30���@�ǉ��@��
		if NR_fate3 <= 30 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		end
	end	
end
	

---------------------------------------------------------
--  ���@�U��
---------------------------------------------------------
function OKINA_833000Battle_Magic_Comb(ai, goal)

local selfmp = ai:GetMp(TARGET_SELF)			--�����̎c��MP���擾
local NormalR_Dist = 0.5						--����U���̊ԍ���

	--���@���g����Ȃ�
	if selfmp >= 15 then
	
		--�G�}�Ɏ����ւ���
		CommonNPC_ChangeWepL2(ai, goal)

		--���@�ōU��
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_None, 0);
		OKINA_833000Battle_Kougeki_Noato(ai, goal)
	
	--���@���g���Ȃ��Ȃ�
	else

		--�����ċ߂Â��čU��
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		OKINA_833000Battle_NormalR_Comb(ai, goal)
		OKINA_833000Battle_Kougeki_Noato(ai, goal)
	
	end
end	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function OKINA_833000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local BackDist = ai:GetRandam_Int(3,5)			--��ނ��鋗��


	if KN_fate <= 70 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );	
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), false, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );				
		
	end
end




---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function OKINA_833000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function OKINA_833000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function OKINA_833000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local NormalR_Dist = 0.5			--�E��U���̓K���ԍ�

	--��U�肵����U��
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 3.0			--��U��ǌ����鋗��
local MissSwingAttPer = 80			--��U��ǌ�����m��	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				OKINA_833000Battle_NormalR_Comb(ai, goal)
				OKINA_833000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end	
	end

	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Ĕ����E���
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 2.0				--�R���{���ꂷ�鋗��
local combRunPer = 40				--�R���{���ꂷ��m��
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
				OKINA_833000Battle_NormalR_Comb(ai, goal)
				OKINA_833000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end
	end	
	
	--���ߋ����ōU�����ꂻ���ɂȂ����璴�����p���B
	if ai:IsInterupt( INTERUPT_FindAttack ) then
local superStepDist = 2.0			--���������鋗��
local superStepPer = 80				--����������m��	
		if targetDist <= superStepDist then
			if fate <= superStepPer then
			--�p���B
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Parry, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
			return true;
			end
		end
	end
	
	
	--��ѓ���������Ă�����œK�s��
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 70					--��ѓ���g�p���ɍœK�s�������m��
		if fate <= shootIntPer then
			goal:ClearSubGoal();
			if fate2 <= 50 then
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			end
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			OKINA_833000Battle_NormalR_Comb(ai, goal)
			OKINA_833000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	
	
	--�A�C�e�����g������œK�s��
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 100				--�A�C�e���g�p���ɍœK�s�������m��
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			OKINA_833000Battle_NormalR_Comb(ai, goal)
			OKINA_833000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	 
	--�G���K�[�h�J�n������v�b�V�����s��
	if ai:IsInterupt( INTERUPT_GuardBegin ) then
local GuardBeginMovePer = 100			--�K�[�h�J�n���Ƀv�b�V������m��
		if fate <= GuardBeginMovePer then
			goal:ClearSubGoal();
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_PushR, TARGET_ENE_0, DIST_Near, 0);
			return true
		end
	end	
	
	
	--�G�̃K�[�h�ŕ��킪�͂����ꂽ��
	if ai:IsInterupt( INTERUPT_ReboundByOpponentGuard ) then
local GuardReboundMovePer = 100			--�͂����ꂽ����~������m��
		if fate <= GuardReboundMovePer then
			goal:ClearSubGoal();
			if fate2 <= 50 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			end
			ai:Replaning();
			return true;
		end
	end
	
	--�K�[�h���󂵂���U��
	if ai:IsInterupt( INTERUPT_GuardBreak ) then
local guardBreakConutDist = 1.0			--�K�[�h����ōU�����鋗��
local guardBreakConutPer = 100			--�K�[�h����ōU������m��
		if targetDist <= guardBreakConutDist then
			if fate <= guardBreakConutPer then
				goal:ClearSubGoal();
				OKINA_833000Battle_NormalR_Comb(ai, goal)
				doran_822000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end
	end	
	
	
return false;
end

