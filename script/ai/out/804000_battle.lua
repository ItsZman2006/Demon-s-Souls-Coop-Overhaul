-----------------------------------------------------------------------------------------------
--	�E���l������NPC�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_UruBlockNPC_804000_Battle, "UruBlockNPC_804000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_UruBlockNPC_804000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function UruBlockNPC_804000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------
local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q

local farDist = 15.0						--�����Ɣ��f���鋗��
local nearDist = 4.0						--�߂��Ɣ��f���鋗��
local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���

	--�����Ȃ�
	if targetDist >= farDist then
	
		--100���@�ҋ@
		goal:AddSubGoal( GOAL_COMMON_Wait, 10.0, TARGET_NONE, 0, 0, 0 );
		
	--�������Ȃ����A�߂����Ȃ��Ȃ�
	elseif targetDist >= nearDist then
	
		--50���@�����ċ߂Â��Ă���
		--50���@�����ċ߂Â�
		if fate <= 50 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		else
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		end
		UruBlockNPC_804000Battle_NormalR_Comb(ai, goal)
		UruBlockNPC_804000Battle_Kougeki_Noato(ai, goal)
		
	--�߂��Ȃ�
	elseif targetDist >= NormalR_Dist then
	
		--100���@�����ċ߂Â��Ă���	
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		UruBlockNPC_804000Battle_NormalR_Comb(ai, goal)
		UruBlockNPC_804000Battle_Kougeki_Noato(ai, goal)
		
	--�ɒ[�ɋ߂��Ȃ�
	else
	
		--35���@�U��
		--65���@�X�e�b�v�Ō��
		if fate <= 35 then
			UruBlockNPC_804000Battle_NormalR_Comb(ai, goal)
			UruBlockNPC_804000Battle_Kougeki_Noato(ai, goal)
		else
			if fate2 <= 50 then
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(1,3), TARGET_ENE_0, ai:GetRandam_Int(2,4), TARGET_ENE_0, true, -1 );
			else
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, ai:GetRandam_Int(2,4), TARGET_ENE_0, true, -1 );
				goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,55), true, true ,-1 );
			end
		end
	end
end

---------------------------------------------------------
--  �E��R���{
---------------------------------------------------------
function UruBlockNPC_804000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p

	--85% ���E�A�g2
	--5%  ���E�A�g3
	--5%  ���E�A�g4
	--5%�@���E�A�g���
	if NR_fate <= 85 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
	
	elseif NR_fate <= 90 then

		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);

	elseif NR_fate <= 95 then
		
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);

	end
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function UruBlockNPC_804000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local BackDist = 2.5							--��ނ��鋗��

	--70���@���E�ړ�
	--30���@���
	if KN_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end


---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function UruBlockNPC_804000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function UruBlockNPC_804000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function UruBlockNPC_804000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���

	--��U�肵����U��
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 1.0			--��U��ǌ����鋗��
local MissSwingAttPer = 20			--��U��ǌ�����m��	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				UruBlockNPC_804000Battle_NormalR_Comb(ai, goal)
				UruBlockNPC_804000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end	
	end

	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Ĕ����E���
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--�R���{���ꂷ�鋗��
local combRunPer = 30				--�R���{���ꂷ��m��
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
				return true;
			end
		end
	end	
	
	--���ߋ����ōU�����ꂻ���ɂȂ����璴�����X�e�b�v
	if ai:IsInterupt( INTERUPT_FindAttack ) then
local superStepDist = 2.0			--���������鋗��
local superStepPer = 10				--����������m��	
		if targetDist <= superStepDist then
			if fate <= superStepPer then
			--�����
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
			return true;
			end
		end
	end
	
	--�K�[�h���󂵂���U��
	if ai:IsInterupt( INTERUPT_GuardBreak ) then
local guardBreakConutDist = 4.0			--�K�[�h����ōU�����鋗��
local guardBreakConutPer = 50			--�K�[�h����ōU������m��
		if targetDist <= guardBreakConutDist then
			if fate <= guardBreakConutPer then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
				UruBlockNPC_804000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end
	end		

	
	--��ѓ���������Ă�����œK�s��
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 50					--��ѓ���g�p���ɍœK�s�������m��
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
local itemUseIntPer = 40				--�A�C�e���g�p���ɍœK�s�������m��
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();		
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			UruBlockNPC_804000Battle_NormalR_Comb(ai, goal)
			UruBlockNPC_804000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	
return false;
end

