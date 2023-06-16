-----------------------------------------------------------------------------------------------
--	�����g�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Yuruto_818000_Battle, "yuruto_818000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Yuruto_818000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function yuruto_818000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾

	--������HP���c��2���ȏ�
	if hprate >= 0.2 then
	
		--�s���E��m����
		yuruto_818000Battle_Normal_Action(ai, goal)
		
	--�����̎c��HP��2���ȉ�
	else
		
		--�s���E�m����
		yuruto_818000Battle_Dying_Action(ai, goal)
	
	end	
end


---------------------------------------------------------
--  �s���E��m����
---------------------------------------------------------
function yuruto_818000Battle_Normal_Action(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋������擾
local farDist = 15.0							--�����Ɣ��f���鋗��
local nearDist = 4.0							--�߂��Ɣ��f���鋗��
local NormalR_Dist = 2.0						--�E��U���̓K���ԍ���

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���

	--�����Ȃ�
	if targetDist >= farDist then

		yuruto_818000Battle_Far_Dist_Action(ai, goal)
	
	--�������Ȃ����A�߂����Ȃ��Ȃ�
	elseif targetDist >= nearDist then
		
		yuruto_818000Battle_Near_Dist_Action(ai, goal)
	
	--�߂��Ȃ�
	elseif targetDist >= NormalR_Dist then
	
		yuruto_818000Battle_NormalR_Dist_Action(ai, goal)

	--�ɒ[�ɋ߂��Ȃ�
	else
	
		if fate <= 70 then
			yuruto_818000Battle_TooNear_Dist_Action(ai, goal)
		
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			yuruto_818000Battle_Kougeki_Noato(ai, goal)
		end
	end
end

---------------------------------------------------------
--  �s���E�m����
---------------------------------------------------------
function yuruto_818000Battle_Dying_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local NormalR_Dist = 2.0			--�E��U���̓K���ԍ���


	if fate <= 30 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		yuruto_818000Battle_NormalR_Comb2(ai, goal)
		yuruto_818000Battle_Kougeki_Noato(ai, goal)
	else
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepF, TARGET_SELF, 0, AI_DIR_TYPE_F, 4.5);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Near, 0);
		yuruto_818000Battle_Kougeki_Noato(ai, goal)
	end

end


---------------------------------------------------------
--  �s���E��m�����E������
---------------------------------------------------------
function yuruto_818000Battle_Far_Dist_Action(ai, goal)

local NormalR_Dist = 2.0			--�E��U���̓K���ԍ���

	--100���@�����ċ߂Â�
	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
	yuruto_818000Battle_NormalR_Comb(ai, goal)
	yuruto_818000Battle_Kougeki_Noato(ai, goal)

end


---------------------------------------------------------
--  �s���E��m�����E������
---------------------------------------------------------
function yuruto_818000Battle_Near_Dist_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local NormalR_Dist = 2.0			--�E��U���̓K���ԍ���


	--60���@�����ċ߂Â��čU��
	--30���@���ړ��ŗl�q��
	--10���@��э��ݐ؂�
	if fate <= 60 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		yuruto_818000Battle_NormalR_Comb(ai, goal)
		yuruto_818000Battle_Kougeki_Noato(ai, goal)
	elseif fate <= 90 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(1,3), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true ,-1 );
	else
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepF, TARGET_SELF, 0, AI_DIR_TYPE_F, 4.5);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Near, 0);
	end

end

---------------------------------------------------------
--  �s���E��m�����E�ߋ���
---------------------------------------------------------
function yuruto_818000Battle_NormalR_Dist_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local NormalR_Dist = 2.0			--�E��U���̓K���ԍ���


	--50���@�����ċ߂Â��čU��	
	--50���@���񂵗l�q���M��
	if fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		yuruto_818000Battle_NormalR_Comb(ai, goal)
		yuruto_818000Battle_Kougeki_Noato(ai, goal)
	else
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(1,3), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,55), true, true ,-1 );
	end

end

---------------------------------------------------------
--  �s���E��m�����E���ߋ���
---------------------------------------------------------
function yuruto_818000Battle_TooNear_Dist_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q

	--30���@�U��
	--70���@�ړ�
	if fate <= 30 then
		yuruto_818000Battle_NormalR_Comb(ai, goal)
		yuruto_818000Battle_Kougeki_Noato(ai, goal)
	else
		if fate2 <= 50 then
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(1,3), TARGET_ENE_0, ai:GetRandam_Int(2,4), TARGET_ENE_0, true, -1 );
		else
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, ai:GetRandam_Int(2,4), TARGET_ENE_0, true, -1 );
			goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,55), true, true ,-1 );
		end
	end
end


---------------------------------------------------------
--  �E��R���{
---------------------------------------------------------
function yuruto_818000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p
local NR_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local NR_fate3 = ai:GetRandam_Int(1,100)		--�m������p
local NR_fate4 = ai:GetRandam_Int(1,100)		--�m������p

	--�E��U���Q��
	--75% �E��U��
	--50% �E��U��
	--25% �E��U��
	--50% �E���U��
	if NR_fate <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	elseif NR_fate <= 20 then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepF, TARGET_SELF, 0, AI_DIR_TYPE_F, 4.5);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Near, 0);
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Near, 0);
	end
	
	if NR_fate2 <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	end
	
	if NR_fate3 <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	end	

end
	
---------------------------------------------------------
--  �E��R���{2�E�ҍU��
---------------------------------------------------------
function yuruto_818000Battle_NormalR_Comb2(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p
local NR_fate2 = ai:GetRandam_Int(1,100)		--�m������p

	--����Ɏ����ւ���
	CommonNPC_SwitchBothHandMode(ai, goal)

	--����U���Q��
	--100% �E���U���P
	-- 90% �E���U���Q

	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);

	if NR_fate2 <= 40 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	end
end



---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function yuruto_818000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local KN_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local BackDist = 2.0							--��ނ��鋗��

	--70���@�Ȃɂ����Ȃ�
	--30���@���Ɉړ�
	--15���@���Ɉړ�
	--40���@�X�e�b�v�Ō��
	if KN_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true ,-1 );
	elseif KN_fate <= 85 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	else
		if KN_fate2 <= 90 then
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepB, TARGET_SELF, 0, AI_DIR_TYPE_B, 4.5);
		else
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepB, TARGET_SELF, 0, AI_DIR_TYPE_B, 4.5);
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_None, 0);
		end			
	end
end


---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function yuruto_818000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function yuruto_818000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function yuruto_818000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local NormalR_Dist = 2.0			--�E��U���̓K���ԍ���

	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Ĕ����E���
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--�R���{���ꂷ�鋗��
local combRunPer = 40				--�R���{���ꂷ��m��
local combRunCountPer = 15			--�R���{����̌�ɍU������m��	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepB, TARGET_SELF, 0, AI_DIR_TYPE_B, 4.5);
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
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepB, TARGET_SELF, 0, AI_DIR_TYPE_B, 4.5);
			return true;
			end
		end
	end
	
	
	--��ѓ���������Ă�����œK�s��
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 30					--��ѓ���g�p���ɍœK�s�������m��
		if fate <= shootIntPer then
			goal:ClearSubGoal();
			if fate2 <= 50 then
				goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepL, TARGET_SELF, 0, AI_DIR_TYPE_L, 4.5);
			else
				goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepR, TARGET_SELF, 0, AI_DIR_TYPE_R, 4.5);
			end
			return true;
		end
	end
	
	--�A�C�e�����g������œK�s��
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 40				--�A�C�e���g�p���ɍœK�s�������m��
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();
				if fate2 <= 80 then
				 	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
					yuruto_818000Battle_Kougeki_Noato(ai, goal)
				else
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
					yuruto_818000Battle_Kougeki_Noato(ai, goal)
				end
			return true
		end
	end
	
	
	--�G�̃K�[�h�ŕ��킪�͂����ꂽ�獶�E�X�e�b�v������i�E�D��j
	if ai:IsInterupt( INTERUPT_ReboundByOpponentGuard ) then
local GuardReboundMovePer = 50			--�͂����ꂽ���Ɉړ�������m��
		if fate <= GuardReboundMovePer then
			goal:ClearSubGoal();
			if fate2 <= 80 then
				goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepR, TARGET_SELF, 0, AI_DIR_TYPE_R, 4.5);
			else
				goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepL, TARGET_SELF, 0, AI_DIR_TYPE_L, 4.5);
			end
			return true;
		end
	end
	
return false;
end

