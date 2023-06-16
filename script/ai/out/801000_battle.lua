-----------------------------------------------------------------------------------------------
--	NPC�R�mA�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_NpcKISI_A801000_Battle, "npcKISI_A801000Battle");

--local c801000_NormalR_Dist = 2.5			--�E��U���̓K���ԍ���
--local c801000_farDist = 15.0				--�����Ɣ��f���鋗��
--local c801000_nearDist = 4.0				--�߂��Ɣ��f���鋗��

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_NpcKISI_A801000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function npcKISI_A801000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

--local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾
--local targethprate = ai:GetHpRate( TARGET_ENE_0 )		--�G�^�[�Q�b�g��HP�������擾

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q

local farDist = 15.0						--�����Ɣ��f���鋗��
local nearDist = 4.0						--�߂��Ɣ��f���鋗��
local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���

	--�����Ȃ�
	if targetDist >= farDist then
		--100���@�����ċ߂Â�
--		if fate <= 50 then
--			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, (targetDist - 3.0), TARGET_ENE_0, true, -1 );
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			npcKISI_A801000Battle_NormalR_Comb(ai, goal)
			npcKISI_A801000Battle_Kougeki_Noato(ai, goal)
--		else
--		end
		
	--�������Ȃ����A�߂����Ȃ��Ȃ�
	elseif targetDist >= nearDist then
		--0���@�����ċ߂Â��Ă���
		--100���@�����ċ߂Â�
		if fate <= 0 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		else
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		end
		npcKISI_A801000Battle_NormalR_Comb(ai, goal)
		npcKISI_A801000Battle_Kougeki_Noato(ai, goal)
		
	--�߂��Ȃ�
	elseif targetDist >= NormalR_Dist then
		--100���@�����ċ߂Â��Ă���	
--			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			npcKISI_A801000Battle_NormalR_Comb(ai, goal)
			npcKISI_A801000Battle_Kougeki_Noato(ai, goal)
		
	--�ɒ[�ɋ߂��Ȃ�
	else
		--65���@�U��
		--35���@�X�e�b�v�Ō��
		if fate <= 65 then
			npcKISI_A801000Battle_NormalR_Comb(ai, goal)
			npcKISI_A801000Battle_Kougeki_Noato(ai, goal)
		else
			if fate2 <= 60 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
			elseif fate2 <= 80 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			end
		end
	end
end

---------------------------------------------------------
--  �E��R���{
---------------------------------------------------------
function npcKISI_A801000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p
local NR_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local NR_fate3 = ai:GetRandam_Int(1,100)		--�m������p
local NR_fate4 = ai:GetRandam_Int(1,100)		--�m������p

	--�E��U���Q��
	--75% �E��U��
	--50% �E��U��
	--25% �E��U��
	--50% �E���U��
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);

--	if NR_fate <= 75 then
--		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
--	end
	
--	if NR_fate2 <= 50 then
--		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
--	end
	
--	if NR_fate3 <= 25 then
--		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
--	end	

	if NR_fate4 <= 50 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function npcKISI_A801000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local KN_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local BackDist = 2.5							--��ނ��鋗��



--���ɉ���������ɂƂ��ǂ����ړ�������Ɨǂ�����
--���܂�ɋ߂����鉡�ړ������A�������������Ă��牡�ړ�������Ɨǂ�����

	--15���@�Ȃɂ����Ȃ�
	--30���@���Ɉړ�
	--15���@���Ɉړ�
	--40���@�X�e�b�v�Ō��
	if KN_fate <= 50 then
		
	elseif KN_fate <= 100 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
	elseif KN_fate <= 100 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	else
		if KN_fate2 <= 60 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
		elseif KN_fate2 <= 80 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
		end			
	end
end




---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function npcKISI_A801000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function npcKISI_A801000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function npcKISI_A801000Battle_Interupt(ai, goal)

--	local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾
--	local targethprate = ai:GetHpRate( TARGET_ENE_0 )		--�G�^�[�Q�b�g��HP�������擾
local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���



	--��U��ǌ��@�����ʊ֐�	
local missSwingDist 	=4.0				--��U��ǌ����鋗��
local missSwingAttPer	=30					--��U��ǌ�����m��
	if MissSwing_Act(ai, goal, missSwingDist, missSwingAttPer ) then
		goal:ClearSubGoal();
		npcKISI_B802000Battle_NormalR_Comb(ai, goal)
		npcKISI_B802000Battle_Kougeki_Noato(ai, goal)
		return true;
	end


	--���ߋ����Ń_���[�W�󂯂���X�e�b�v���Ĕ����@�����ʊ֐�
local combRunDist		=1.0				--�R���{���ꂷ�鋗��
local combRunPer		=65					--�R���{���ꂷ��m��
local combRunCountPer	=35					--�R���{����̌�ɔ�������m��
local countAct			=NPC_ATK_NormalR	--�����̎��ID
local bkStepPer			=60					--�o�b�N�X�e�b�v�m��
local leftStepPer		=20					--���X�e�b�v�m��
local rightStepPer		=20					--�E�X�e�b�v�m��
Damaged_StepCount_NPCPlayer(ai, goal, combRunDist, combRunPer, combRunCountPer, countAct, bkStepPer, leftStepPer, rightStepPer )
	
	
	--���ߋ����ōU�����ꂻ���ɂȂ�����X�e�b�v�@�����ʊ֐�
local superStepDist		=2.0				--�������鋗��
local superStepPer		=20					--��������m��	
local bkStepPer			=60					--�o�b�N�X�e�b�v�m��
local leftStepPer		=20					--���X�e�b�v�m��
local rightStepPer		=20					--�E�X�e�b�v�m��
FindAttack_Step_NPCPlayer(ai, goal, superStepDist, superStepPer, bkStepPer, leftStepPer, rightStepPer )


	--�K�[�h���󂵂���U���@�����ʊ֐�
local guardBreakConutDist = 4.0			--�K�[�h����ōU�����鋗��
local guardBreakConutPer = 65			--�K�[�h����ōU������m��
	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
		goal:ClearSubGoal();
		npcKISI_A801000Battle_NormalR_Comb(ai, goal)
		npcKISI_A801000Battle_Kougeki_Noato(ai, goal)
		return true;
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
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			npcKISI_A801000Battle_NormalR_Comb(ai, goal)
			npcKISI_A801000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	
	
	--�A�C�e�����g������œK�s��
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 50				--�A�C�e���g�p���ɍœK�s�������m��
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();		
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			npcKISI_A801000Battle_NormalR_Comb(ai, goal)
			npcKISI_A801000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	
return false;
end

