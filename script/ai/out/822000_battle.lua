-----------------------------------------------------------------------------------------------
--	�h�����p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Doran_822000_Battle, "doran_822000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Doran_822000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function doran_822000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

	--�C�x���g���N�G�X�g��-1
	--��_�̌���D������ԂȂ�
	if (-1==ai:GetEventRequest()) then
		
		--�s���E������Ȃ�
		doran_822000Battle_Normal(ai, goal)
	
	--�C�x���g���N�G�X�g��-1�ȊO
	--��_�̌���������ԂȂ�
	else
		
		--�s���E���������
		doran_822000Battle_Allowance(ai, goal)
		
	end

end

---------------------------------------------------------
--  �s���E���������
---------------------------------------------------------
function doran_822000Battle_Allowance(ai, goal)

local hprate = ai:GetHpRate( TARGET_SELF )		--������HP�������擾

	--������HP���c��8���ȏ�
	--�h���������𖾂��n���܂�
	if hprate >= 0.8 then

		--�s���E�����
		doran_822000Battle_Allowance_Action(ai, goal)
		
	else
	
		--�s���E�m����
		doran_822000Battle_Dying_Action(ai, goal)	
	
	end

end

---------------------------------------------------------
--  �s���E�����
---------------------------------------------------------
function doran_822000Battle_Allowance_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)	--�m������p

	--20% �����ċ߂Â��čU��
	if fate <= 20 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		doran_822000Battle_Kougeki_Noato(ai, goal)

	--80% ���񂵂ėl�q��
	else
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(1,3), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true ,-1 );
	end
	
end

---------------------------------------------------------
--  �s���E������Ȃ�
---------------------------------------------------------
function doran_822000Battle_Normal(ai, goal)

local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾

	--������HP���c��8���ȏ�
	if hprate >= 0.8 then
	
		--�s���E��m����
		doran_822000Battle_Normal_Action(ai, goal)
		
	--�����̎c��HP��8���ȉ�
	else
		
		--�s���E�m����
		doran_822000Battle_Dying_Action(ai, goal)
	
	end	
end


---------------------------------------------------------
--  �s���E��m����
---------------------------------------------------------
function doran_822000Battle_Normal_Action(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋������擾
local farDist = 15.0							--�����Ɣ��f���鋗��
local nearDist = 4.0							--�߂��Ɣ��f���鋗��
local NormalR_Dist = 2.5						--�E��U���̓K���ԍ���


	--�����Ȃ�
	if targetDist >= farDist then

		doran_822000Battle_Far_Dist_Action(ai, goal)
	
	--�������Ȃ����A�߂����Ȃ��Ȃ�
	elseif targetDist >= nearDist then
		
		doran_822000Battle_Near_Dist_Action(ai, goal)
	
	--�߂��Ȃ�
	elseif targetDist >= NormalR_Dist then
	
		doran_822000Battle_NormalR_Dist_Action(ai, goal)

	--�ɒ[�ɋ߂��Ȃ�
	else
	
		doran_822000Battle_TooNear_Dist_Action(ai, goal)
	
	end
end

---------------------------------------------------------
--  �s���E�m����
---------------------------------------------------------
function doran_822000Battle_Dying_Action(ai, goal)

local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���

	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
	doran_822000Battle_NormalR_Comb2(ai, goal)
	doran_822000Battle_Kougeki_Noato2(ai, goal)

end


---------------------------------------------------------
--  �s���E��m�����E������
---------------------------------------------------------
function doran_822000Battle_Far_Dist_Action(ai, goal)

local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���

	--100���@�����ċ߂Â�
	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
	doran_822000Battle_NormalR_Comb(ai, goal)
	doran_822000Battle_Kougeki_Noato(ai, goal)

end


---------------------------------------------------------
--  �s���E��m�����E������
---------------------------------------------------------
function doran_822000Battle_Near_Dist_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���


	--60���@�����ċ߂Â��čU��
	--40���@���ړ��ŗl�q��
	if fate <= 60 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		doran_822000Battle_NormalR_Comb(ai, goal)
		doran_822000Battle_Kougeki_Noato(ai, goal)
	else
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(1,3), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true ,-1 );
	end

end

---------------------------------------------------------
--  �s���E��m�����E�ߋ���
---------------------------------------------------------
function doran_822000Battle_NormalR_Dist_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���


	--40���@�����ċ߂Â��čU��	
	--60���@���񂵗l�q���M��
	if fate <= 40 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		doran_822000Battle_NormalR_Comb(ai, goal)
		doran_822000Battle_Kougeki_Noato(ai, goal)
	else
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(1,3), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,55), true, true ,-1 );
	end

end

---------------------------------------------------------
--  �s���E��m�����E���ߋ���
---------------------------------------------------------
function doran_822000Battle_TooNear_Dist_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q

	--30���@�U��
	--70���@�ړ�
	if fate <= 30 then
		doran_822000Battle_NormalR_Comb(ai, goal)
		doran_822000Battle_Kougeki_Noato(ai, goal)
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
function doran_822000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p
local NR_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local NR_fate3 = ai:GetRandam_Int(1,100)		--�m������p
local NR_fate4 = ai:GetRandam_Int(1,100)		--�m������p

	--�E��U���Q��
	--10% �p���`����̘A�g
	--5% �O�]�U��
	--85% �E��U��
	if NR_fate <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	elseif NR_fate <= 15 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepF, TARGET_ENE_0, DIST_None, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Near, 0);
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	end
	
	--10% �ǉ��U�� �E��ʏ�
	if NR_fate2 <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	end
	
	--10% �ǉ��U�� �E�苭
	if NR_fate3 <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	end	

end
	
---------------------------------------------------------
--  �E��R���{2�E�ҍU��
---------------------------------------------------------
function doran_822000Battle_NormalR_Comb2(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p
local NR_fate2 = ai:GetRandam_Int(1,100)		--�m������p

	--����U���Q��
	--20% �O�]�U�����狭�U���R���{
	--40% ��㋭�R���{
	--20% �㋭��R���{
	--20% ���㋭�R���{

	--���莝���ɐ؂�ւ���
	CommonNPC_SwitchBothHandMode(ai, goal)
	
	if NR_fate <= 20 then
		
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepF, TARGET_ENE_0, DIST_None, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
		
	elseif NR_fate <= 60 then
		
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	
	elseif NR_fate <= 80 then
		
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);

	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	end
		
end


	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function doran_822000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local KN_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local BackDist = 2.5							--��ނ��鋗��

	--70���@�������Ȃ�
	--30���@���Ɉړ�
	--15���@���Ɉړ�
	--40���@�X�e�b�v�Ō��
	if KN_fate <= 40 then
		goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_NONE, 0, 0, 0 );	
	elseif KN_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 10.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true ,-1 );
	elseif KN_fate <= 85 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	else
		if KN_fate2 <= 90 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_None, 0);
		end			
	end
end

---------------------------------------------------------
--  �U����̍s���E�m����
---------------------------------------------------------
function doran_822000Battle_Kougeki_Noato2(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local KN_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local BackDist = 2.5							--��ނ��鋗��

	--70���@�K�[�h���Ȃ�����
	--30���@���Ɉړ�
	--15���@���Ɉړ�
	--40���@�X�e�b�v�Ō��
	if KN_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, 4 );	
	elseif KN_fate <= 60 then
		goal:AddSubGoal(GOAL_COMMON_Guard, 10.0, 4, TARGET_ENE_0, false, 0);
	elseif KN_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 10.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), false, true ,4 );
	elseif KN_fate <= 85 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );				
	else
		if KN_fate2 <= 90 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_None, 0);
		end			
	end
end


---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function doran_822000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function doran_822000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function doran_822000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���
local hprate = ai:GetHpRate( TARGET_SELF )	--������HP�̊������擾


	--��U�肵����U��
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 2.0			--��U��ǌ����鋗��
local MissSwingAttPer = 40			--��U��ǌ�����m��	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				doran_822000Battle_NormalR_Comb(ai, goal)
				doran_822000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end	
	end

	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Č��or�K�[�h�E����
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 2.0				--�R���{���ꂷ�鋗��
local combRunPer = 60				--�R���{���ꂷ��m��
local combRunCountPer = 30			--�R���{����̌�ɍU������m��
local combGuardPer = 60				--�R���{���K�[�h����m��	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
					if hprate <= 0.8 then
						if fate2 <= combGuardPer then
							goal:AddSubGoal(GOAL_COMMON_Guard, 10.0, 4, TARGET_ENE_0, false, 0);
						else
							goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
						end
					else
						goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
					end
				return true;
			end
		end
	end	
	
	--���ߋ����ōU�����ꂻ���ɂȂ����璴�����X�e�b�vor�K�[�h
	if ai:IsInterupt( INTERUPT_FindAttack ) then
local superStepDist = 2.0			--���������鋗��
local superStepPer = 40				--����������m��
local superGuardPer = 50			--�X�e�b�v�̑���ɃK�[�h����m��
		if targetDist <= superStepDist then
			if fate <= superStepPer then
				goal:ClearSubGoal();
				if hprate <= 0.8 then
					if fate2 <= superGuardPer then
						goal:AddSubGoal(GOAL_COMMON_Guard, 10.0, 4, TARGET_ENE_0, false, 0);
					else
						goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
					end
				else
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
				end
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
				doran_822000Battle_Kougeki_Noato(ai, goal)
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
			return true;
		end
	end
	
	--�A�C�e�����g������œK�s��
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 100				--�A�C�e���g�p���ɍœK�s�������m��
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();

			--������HP��6���ȏゾ������
			if hprate >= 0.6 then
			 	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
				doran_822000Battle_Kougeki_Noato(ai, goal)

			--������HP��6���ȉ���������
			else

				--��񂾂��A�C�e�����g��
				if ( 0 == ai:GetNumber(0) ) then
					goal:AddSubGoal( GOAL_COMMON_UseItem, 10.0, 0 );
					ai:SetNumber(0,1) 

				--���I����Ă����
				else
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
					doran_822000Battle_Kougeki_Noato(ai, goal)
				end
			end
		return true;
		end
	end
	
	
	--�G���K�[�h�J�n�������ށE���������
	if ai:IsInterupt( INTERUPT_GuardBegin ) then
local GuardBeginMovePer = 70			--�K�[�h�J�n���Ɉړ�������m��
		if fate <= GuardBeginMovePer then
			goal:ClearSubGoal();
			if fate2 <= 20 then
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, 5.0, TARGET_ENE_0, true, -1 );
			else
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 1.5, TARGET_ENE_0, 2.5, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,55), true, true ,-1 );
			end
			return true;
		end
	end
	
	--�G�̃K�[�h�ŕ��킪�͂����ꂽ�獶�E�X�e�b�v������i�E�D��j
	if ai:IsInterupt( INTERUPT_ReboundByOpponentGuard ) then
local GuardReboundMovePer = 50			--�͂����ꂽ���Ɉړ�������m��
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



