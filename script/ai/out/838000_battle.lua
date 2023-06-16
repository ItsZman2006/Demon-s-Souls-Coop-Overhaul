------------------------------------------------------------------------------------------------
--	����O�e�mB��p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_TroisM_B838000_Battle, "TroisM_B838000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_TroisM_B838000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function TroisM_B838000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q

local NormalR_Dist = 2.0			--�E��U���̓K���ԍ���

	--������HP�c�肪1���ȏ�
	if hprate >= 0.1 then

		--�߂��Ȃ�
		if targetDist >= NormalR_Dist then

			--70���@�����ċ߂Â��U��
			if fate <= 70 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
				TroisM_B838000Battle_NormalR_Comb(ai, goal)
				TroisM_B838000Battle_Kougeki_Noato(ai, goal)
				
			--30% �����Đ��񂵂ėl�q��
			else
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,55), false, true ,-1 );
			end
			
		--�ɒ[�ɋ߂��Ȃ�
		else
			--65���@�U��
			if fate2 <= 65 then
				TroisM_B838000Battle_NormalR_Comb(ai, goal)
				
			--35���@�X�e�b�v�Ō��
			else
				TroisM_B838000Battle_Kougeki_Noato(ai, goal)
			end
		end
	
	--������HP�c�肪1���ȉ�
	else
	
		--50% �߂Â��ē˂��܂���
		if fate <= 50 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		
		--50% �߂Â��Đ��񂵂ē˂��܂���
		else
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,55), false, true ,-1 );
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		end
	end
end

---------------------------------------------------------
--  �E��R���{�i�ʏ�j
---------------------------------------------------------
function TroisM_B838000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p
local NR_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local NR_fate3 = ai:GetRandam_Int(1,100)		--�m������p

local NormalATKPer	= 70		--�ʏ�U���̊���

	if NR_fate <= NormalATKPer then

		--30% �O�]�U��
		if NR_fate2 <= 30 then
			CommonNPC_SwitchOneHandMode(ai, goal)
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepF, TARGET_ENE_0, DIST_None, 0 )
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Middle, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);

		--30% �E��U��2��
		elseif NR_fate2 <= 60 then
			CommonNPC_SwitchOneHandMode(ai, goal)
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);

		--40% ���莝���R���{
		else
			CommonNPC_SwitchBothHandMode(ai, goal)
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);		
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);		
		end
	
	else
		CommonNPC_SwitchOneHandMode(ai, goal)
		--�E�苭�U���P��
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);

		--30% �E�苭�U���Q��
		if NR_fate3 <= 30 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		end
	end
end	



---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function TroisM_B838000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local KN_fate2 = ai:GetRandam_Int(1,100)			--�m������p

	--50% �o�b�N�X�e�b�v
	if KN_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);

	--25% ���T�C�h�X�e�b�v
	elseif KN_fate <= 25	then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);

	--25% �E�T�C�h�X�e�b�v
	else
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
	end

	--50% �X�e�b�v�����
	if KN_fate2 <= 50 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,55), false, true ,-1 );
	end
end




---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function TroisM_B838000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function TroisM_B838000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function TroisM_B838000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local NormalR_Dist = 2.0			--�E��U���̓K���ԍ���


	--��U�肵����U��
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 2.0			--��U��ǌ����鋗��
local MissSwingAttPer = 20			--��U��ǌ�����m��	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				TroisM_B838000Battle_NormalR_Comb(ai, goal)
				TroisM_B838000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end	
	end

	
	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Ĕ����E���
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--�R���{���ꂷ�鋗��
local combRunPer = 40				--�R���{���ꂷ��m��
local combRunCountPer = 20			--�R���{����̌�ɍU������m��	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				TroisM_B838000Battle_Kougeki_Noato(ai, goal)

				--�R���{�����̍U��
				if fate3 <= combRunCountPer then
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
				end
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
				TroisM_B838000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end
	end
	
	--�K�[�h���󂵂���U��
	if ai:IsInterupt( INTERUPT_GuardBreak ) then
local guardBreakConutDist = 3.0			--�K�[�h����ōU�����鋗��
local guardBreakConutPer = 70			--�K�[�h����ōU������m��
		if targetDist <= guardBreakConutDist then
			if fate <= guardBreakConutPer then
				goal:ClearSubGoal();
				CommonNPC_SwitchOneHandMode(ai, goal)
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
				TroisM_B838000Battle_Kougeki_Noato(ai, goal)
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
			TroisM_B838000Battle_NormalR_Comb(ai, goal)
			TroisM_B838000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	
return false;
end

