-----------------------------------------------------------------------------------------------
--	�����h�����q�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ� 
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Ouji_807000_Battle, "ouji_807000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Ouji_807000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function ouji_807000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾
local NormalR_Dist = 2.0						--�U���̓K���ԍ���

	--������HP��1���ȏ�Ȃ�
	if hprate >= 0.1 then
	
		--�ʏ�s��
		ouji_807000Battle_Kyori(ai, goal)
	
	--������HP��2���ȉ��Ȃ�
	else
	
		--�m���s���i�ҍU���j
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 )
		ouji_807000Battle_Dying_Attack(ai, goal)
		ouji_807000Battle_Kougeki_Noato(ai, goal)
	
	end
	
end

---------------------------------------------------------
--  �s���i�������ʁj
---------------------------------------------------------
function ouji_807000Battle_Kyori(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋������擾
local NormalR_Dist = 2.0						--�U���̓K���ԍ���
local Middle_Dist = 6.0 						--�����ċ߂Â�����

	--�����ċ߂Â������Ȃ�
	if targetDist >= Middle_Dist then
	
		--�s���i�������j
		ouji_807000Battle_Middle_Action(ai, goal)

	--�U�����͂��Ȃ������Ȃ�
	elseif targetDist >= NormalR_Dist then

		--�s���i�ߋ����j
		ouji_807000Battle_Near_Action(ai, goal)

	--�U�����͂������Ȃ�
	else
	
		--�s���i���ߋ����j
		ouji_807000Battle_TooNear_Action(ai, goal)
	
	end
end

---------------------------------------------------------
--  �s���i�������j
---------------------------------------------------------
function ouji_807000Battle_Middle_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local NormalR_Dist = 2.0					--�U���̓K���ԍ���

	--80% �K�[�h���Ȃ�
	if fate <= 80 then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 )
		
	--20% �K�[�h����
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, 4 )
	end
	
end


---------------------------------------------------------
--  �s���i�ߋ����j
---------------------------------------------------------
function ouji_807000Battle_Near_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂R

local NormalR_Dist = 2.0					--�U���̓K���ԍ���

	--70% �����ċ߂Â�
	if fate <= 70 then
		
		--70% �K�[�h���Ȃ�
		if fate2 <= 70 then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 )
		
		--30% �K�[�h����
		else
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, 4 )
		end
		
	--30% �����ċ߂Â�
	else
	
		--40% �K�[�h���Ȃ�
		if fate3 <= 40 then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 )
		
		--70% �K�[�h����
		else
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, 4 )
		end
	end
	
	ouji_807000Battle_Attack(ai, goal)
	ouji_807000Battle_Kougeki_Noato(ai, goal)

end

---------------------------------------------------------
--  �s���i���ߋ����j
---------------------------------------------------------
function ouji_807000Battle_TooNear_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���

	--70% �U��
	if fate <= 70 then
		ouji_807000Battle_Attack(ai, goal)
	end

	ouji_807000Battle_Kougeki_Noato(ai, goal)

end



---------------------------------------------------------
--  �U���p�^�[���E�ʏ펞
---------------------------------------------------------
function ouji_807000Battle_Attack(ai, goal)

	--�E��R���{�E�Ў�
	ouji_807000Battle_NormalR_OneHand_Comb(ai, goal)

end
 
---------------------------------------------------------
--  �U���p�^�[���E�m����
---------------------------------------------------------
function ouji_807000Battle_Dying_Attack(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���


	--80% �Ў�U��
	if fate <= 80 then
		--�E��R���{�E�Ў�
		ouji_807000Battle_NormalR_OneHand_Comb(ai, goal)
		
	--20% ����U��
	else
		--�E��R���{�E����
		ouji_807000Battle_NormalR_BothHand_Comb(ai, goal)
	
	end
end


---------------------------------------------------------
--  �E��R���{�E�Ў�
---------------------------------------------------------
function ouji_807000Battle_NormalR_OneHand_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p

	--�Ў�؂�ւ�
	CommonNPC_SwitchOneHandMode(ai, goal)

	--10% �O�]�U��
	if NR_fate <= 10 then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepF, TARGET_SELF, 0, AI_DIR_TYPE_F, 4.0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Middle, 0);
	
	--70% �U��2��
	elseif NR_fate <= 80 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	
	--20% ���U��1��
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
	
	end
end


---------------------------------------------------------
--  �E��R���{�E����
---------------------------------------------------------
function ouji_807000Battle_NormalR_BothHand_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p
local NR_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local NR_fate3 = ai:GetRandam_Int(1,100)		--�m������p

	--����؂�ւ�
	CommonNPC_SwitchBothHandMode(ai, goal)
	
	--5% �O�]�U��
	if NR_fate <= 5 then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepF, TARGET_SELF, 0, AI_DIR_TYPE_F, 4.0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Middle, 0);
	
	--90% �U��1�񋭍U��1��
	elseif NR_fate <= 95 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		
		--80% �U��2��
		if NR_fate2 <= 80 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		
		--15% ���U��1��
		elseif NR_fate2 <= 95 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
			
		--5% ���U��2��
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		
		end
		
	--5% ���U��1��U��1��
	else	
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		
		--80% �U��1��
		if NR_fate3 <= 80 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
			
		--20% �U��1�񋭍U��1��
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		end
	end

end
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function ouji_807000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local KN_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local KN_fate3 = ai:GetRandam_Int(1,100)		--�m������p

local BackDist = ai:GetRandam_Int(3,6)			--��ނ��鋗��

	--50% �����\���Č�ށE����
	--50% �X�e�b�v�ړ��i�����Ȃ���j

	if KN_fate <= 50 then
	
		if KN_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(3,5), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), ai:GetRandam_Int(0,1), true , 4 );
		else
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(3,5), TARGET_ENE_0, BackDist, TARGET_ENE_0, ai:GetRandam_Int(0,1), 4 );
		end
		
	else
	
		if KN_fate3 <= 40 then
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepB, TARGET_SELF, 0, AI_DIR_TYPE_B, 4.0);
		elseif KN_fate3	<= 70 then
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepL, TARGET_SELF, 0, AI_DIR_TYPE_L, 4.0);
		else
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepR, TARGET_SELF, 0, AI_DIR_TYPE_R, 4.0);
		end			
	end
end




---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function ouji_807000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function ouji_807000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function ouji_807000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���


	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Č��
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--�R���{���ꂷ�鋗��
local combRunPer = 40				--�R���{���ꂷ��m��
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				if fate2 <= 40 then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepB, TARGET_SELF, 0, AI_DIR_TYPE_B, 4.0);
				elseif fate2 <= 70 then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepL, TARGET_SELF, 0, AI_DIR_TYPE_L, 4.0);
				else
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepR, TARGET_SELF, 0, AI_DIR_TYPE_R, 4.0);
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
				if fate2 <= 40 then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepB, TARGET_SELF, 0, AI_DIR_TYPE_B, 4.0);
				elseif fate2 <= 70 then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepL, TARGET_SELF, 0, AI_DIR_TYPE_L, 4.0);
				else
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepR, TARGET_SELF, 0, AI_DIR_TYPE_R, 4.0);
				end		
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
				goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepL, TARGET_SELF, 0, AI_DIR_TYPE_L, 4.0);
			else
				goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepR, TARGET_SELF, 0, AI_DIR_TYPE_R, 4.0);
			end	
			return true
		end
	end
	
	
return false;
end

