-----------------------------------------------------------------------------------------------
--	�S�܂ꂽ��m�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Kokoro_805000_Battle, "kokoro_805000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Kokoro_805000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function kokoro_805000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

	kokoro_805000Battle_Normal_Action(ai, goal)

end


---------------------------------------------------------
--  �s���E��m����
---------------------------------------------------------
function kokoro_805000Battle_Normal_Action(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋������擾
local farDist = 12.0							--�����Ɣ��f���鋗��
local nearDist = 4.0							--�߂��Ɣ��f���鋗��
local NormalR_Dist = 2.5						--�E��U���̓K���ԍ���


	--�����Ȃ�
	if targetDist >= farDist then

		kokoro_805000Battle_Far_Dist_Action(ai, goal)
	
	--�������Ȃ����A�߂����Ȃ��Ȃ�
	elseif targetDist >= nearDist then
		
		kokoro_805000Battle_Near_Dist_Action(ai, goal)
	
	--�߂��Ȃ�
	elseif targetDist >= NormalR_Dist then
	
		kokoro_805000Battle_NormalR_Dist_Action(ai, goal)

	--�ɒ[�ɋ߂��Ȃ�
	else
	
		kokoro_805000Battle_TooNear_Dist_Action(ai, goal)
	
	end
end


---------------------------------------------------------
--  �s���E��m�����E������
---------------------------------------------------------
function kokoro_805000Battle_Far_Dist_Action(ai, goal)

	--100���@�ҋ@
	goal:AddSubGoal( GOAL_COMMON_Wait, 5.0, TARGET_NONE, 0, 0, 0 );

end


---------------------------------------------------------
--  �s���E��m�����E������
---------------------------------------------------------
function kokoro_805000Battle_Near_Dist_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���


	--20���@�����ċ߂Â��čU��
	--80���@���ړ��ŗl�q��
	if fate <= 20 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, 4 );
		kokoro_805000Battle_NormalR_Comb(ai, goal)
		kokoro_805000Battle_Kougeki_Noato(ai, goal)
	else
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true ,4 );
	end

end

---------------------------------------------------------
--  �s���E��m�����E�ߋ���
---------------------------------------------------------
function kokoro_805000Battle_NormalR_Dist_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���


	--30���@�����ċ߂Â��čU��	
	--70���@���񂵗l�q���M��
	if fate <= 30 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, 4 );
		kokoro_805000Battle_NormalR_Comb(ai, goal)
		kokoro_805000Battle_Kougeki_Noato(ai, goal)
	else
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,55), true, true ,4 );
	end

end

---------------------------------------------------------
--  �s���E��m�����E���ߋ���
---------------------------------------------------------
function kokoro_805000Battle_TooNear_Dist_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q

	--30���@�U��
	--70���@�ړ�
	if fate <= 30 then
		kokoro_805000Battle_NormalR_Comb(ai, goal)
		kokoro_805000Battle_Kougeki_Noato(ai, goal)
	else
		if fate2 <= 50 then
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(1,3), TARGET_ENE_0, ai:GetRandam_Int(2,4), TARGET_ENE_0, true, 4 );
		else
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, ai:GetRandam_Int(2,4), TARGET_ENE_0, true, 4 );
			goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,55), true, true ,4 );
		end
	end
end


---------------------------------------------------------
--  �E��R���{
---------------------------------------------------------
function kokoro_805000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p
local NR_fate2 = ai:GetRandam_Int(1,100)		--�m������p

	--�E��U���Q��
	--100% �E����
		--10% �E��U��
		--10% �E�苭�U��
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	
	if NR_fate <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	end
	
	if NR_fate2 <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	end	

end
	

---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function kokoro_805000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local BackDist = 3.0							--��ނ��鋗��

	--60���@���Ɉړ�
	--40���@���Ɉړ�
	if KN_fate <= 60 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true ,4 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, BackDist, TARGET_ENE_0, true, 4 );				
	end
end


---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function kokoro_805000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function kokoro_805000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function kokoro_805000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���

	--��U�肵����U��
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 1.0			--��U��ǌ����鋗��
local MissSwingAttPer = 10			--��U��ǌ�����m��	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				kokoro_805000Battle_NormalR_Comb(ai, goal)
				kokoro_805000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end	
	end

	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Ĕ����E���
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--�R���{���ꂷ�鋗��
local combRunPer = 40				--�R���{���ꂷ��m��
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
				goal:ClearSubGoal();
				--�����
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
				return true;
			end
		end
	end
	
	
	--��ѓ���������Ă�����œK�s��
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 10					--��ѓ���g�p���ɍœK�s�������m��
		if fate <= shootIntPer then
			goal:ClearSubGoal();
			if fate2 <= 50 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			end
			return true;
		end
	end
		
return false;
end

