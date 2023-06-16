------------------------------------------------------------------------------------------------
--	�s��Q�p�j�u���b�N�S�[�X�g�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Fujo2BG_839000_Battle, "Fujo2BG_839000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Fujo2BG_839000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function Fujo2BG_839000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���

local FarDist = 30.0						--�ǌ�����߂鋗��
local NormalR_Dist = 1.5					--�E��U���̓K���ԍ���


	--�ǌ�����߂鋗���Ȃ�
	if targetDist >= FarDist then
		goal:ClearSubGoal();
		--100% �������Ȃ�
		goal:AddSubGoal( GOAL_COMMON_Wait, 5.0, TARGET_ENE_0, 0, 0, 0 );

	--�ǌ��\�ȋ����Ȃ�
	else	
		--100% �����ċ߂Â��čU��
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		Fujo2BG_839000Battle_NormalR_Comb(ai, goal)

		--50% �U����̍s��
		if fate <= 50 then
			Fujo2BG_839000Battle_Kougeki_Noato(ai, goal)
		end
	end
end

---------------------------------------------------------
--  �E��R���{
---------------------------------------------------------
function Fujo2BG_839000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p
local NR_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local NR_fate3 = ai:GetRandam_Int(1,100)		--�m������p
local NR_fate4 = ai:GetRandam_Int(1,100)		--�m������p

	--80% ���U��
	--15% �O�]���U��
	-- 5% ���莝���R���{
	if NR_fate2 <= 15 then
		CommonNPC_SwitchOneHandMode(ai, goal)
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepF, TARGET_ENE_0, DIST_None, 0 )
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Middle, 0);

	elseif NR_fate2 <= 40 then
		CommonNPC_SwitchOneHandMode(ai, goal)
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);

	elseif NR_fate2 <= 75 then
		CommonNPC_SwitchBothHandMode(ai, goal)
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);		
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);	
	
	elseif NR_fate2 <= 90 then
		CommonNPC_SwitchBothHandMode(ai, goal)
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepF, TARGET_ENE_0, DIST_None, 0 )
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Middle, 0);	

	else
		CommonNPC_SwitchBothHandMode(ai, goal)
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		
	end
	
	

end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function Fujo2BG_839000Battle_Kougeki_Noato(ai, goal)

	goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,5), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(35,55), false, true ,-1 );

end




---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function Fujo2BG_839000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function Fujo2BG_839000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function Fujo2BG_839000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���


	--��U�肵����U��
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 4.0			--��U��ǌ����鋗��
local MissSwingAttPer = 40			--��U��ǌ�����m��	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
				Fujo2BG_839000Battle_NormalR_Comb(ai, goal)
				return true;
			end
		end	
	end

	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Ĕ����E���
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--�R���{���ꂷ�鋗��
local combRunPer = 60				--�R���{���ꂷ��m��
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
			if fate2 <= 30 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			elseif fate2 <= 60 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
			end
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
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			end
			return true
		end
	end
	
	
	--�A�C�e�����g������œK�s��
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 100				--�A�C�e���g�p���ɍœK�s�������m��
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();		
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			Fujo2BG_839000Battle_NormalR_Comb(ai, goal)
			return true
		end
	end
	
return false;
end

