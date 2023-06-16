-----------------------------------------------------------------------------------------------
--	�`���[�g���A���p�j�S�[�X�g�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_TutorialHG_835000_Battle, "TutorialHG_835000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_TutorialHG_835000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function TutorialHG_835000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q

local farDist = 15.0						--�����Ɣ��f���鋗��
local nearDist = 4.0						--�߂��Ɣ��f���鋗��
local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���

	--�����Ȃ�
	if targetDist >= farDist then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		TutorialHG_835000Battle_NormalR_Comb(ai, goal)
		TutorialHG_835000Battle_Kougeki_Noato(ai, goal)
		
	--�������Ȃ����A�߂����Ȃ��Ȃ�
	elseif targetDist >= nearDist then
		if fate <= 20 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		else
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		end
		TutorialHG_835000Battle_NormalR_Comb(ai, goal)
		TutorialHG_835000Battle_Kougeki_Noato(ai, goal)
		
	--�߂��Ȃ�
	elseif targetDist >= NormalR_Dist then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		TutorialHG_835000Battle_NormalR_Comb(ai, goal)
		TutorialHG_835000Battle_Kougeki_Noato(ai, goal)
		
	--�ɒ[�ɋ߂��Ȃ�
	else
		--65���@�U��
		--35���@�X�e�b�v�Ō��
		if fate <= 65 then
			TutorialHG_835000Battle_NormalR_Comb(ai, goal)
			TutorialHG_835000Battle_Kougeki_Noato(ai, goal)
		else
			if fate2 <= 60 then
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
function TutorialHG_835000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p

	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	
	if NR_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	

---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function TutorialHG_835000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local KN_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local BackDist = 2.5							--��ނ��鋗��

	--15���@�Ȃɂ����Ȃ�
	--30���@���Ɉړ�
	--15���@���Ɉړ�
	--40���@�X�e�b�v�Ō��
	if KN_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_Wait, 5.0, TARGET_NONE, 0, 0, 0 );
	elseif KN_fate <= 100 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
	elseif KN_fate <= 100 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	else
		if KN_fate2 <= 60 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
		end			
	end
end





---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function TutorialHG_835000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function TutorialHG_835000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function TutorialHG_835000Battle_Interupt(ai, goal)


return false;
end

