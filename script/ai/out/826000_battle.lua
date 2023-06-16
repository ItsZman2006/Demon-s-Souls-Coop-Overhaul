-----------------------------------------------------------------------------------------------
--	�_�̐M�k�R�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Sinto3_826000_Battle, "sinto3_826000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Sinto3_826000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function sinto3_826000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )		--������HP�̊������擾

	--HP��3���ȏ�Ȃ�
	if hprate >= 0.3 then
		
		--�ʏ�s��
		sinto3_826000Battle_Nomal(ai, goal)
	
	--HP��3���ȉ��Ȃ�	
	else
		
		--�m���s��
		sinto3_826000Battle_Dying(ai, goal)

	end
end

---------------------------------------------------------
--  �ʏ�s��
---------------------------------------------------------
function sinto3_826000Battle_Nomal(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q

local NormalR_Dist = 0.5					--�E��U���̓K���ԍ���

	--����������Ă��Ȃ���Ύ����ւ���
	CommonNPC_ChangeWepR2(ai, goal)

	--30%�@���񂵂ėl�q��
	if fate <= 30 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,25), true, true , -1 );

	--20%�@���������
	elseif fate <= 50 then 
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, ai:GetRandam_Int(3,5), TARGET_ENE_0, true, -1 );
	
	--50%�@�ڋ߂��čU��
	else
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1);
		sinto3_826000Battle_Attack(ai, goal)
		sinto3_826000Battle_Kougeki_Noato(ai, goal)
	end
end

---------------------------------------------------------
--  �m���s��
---------------------------------------------------------
function sinto3_826000Battle_Dying(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋������擾
local farDist = 8.0								--�����Ɣ��f���鋗��

local selfmp = ai:GetMp(TARGET_SELF)			--�����̎c��MP���擾

	--MP��30��葽�����
	if selfmp >= 30 then
	
		--�G���狗�����Ƃ�
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 4.0, TARGET_ENE_0, 5.0, TARGET_ENE_0, false, -1 );
		
		--�^���X�}���������Ă��Ȃ���΃^���X�}���ɐ؂�ւ�
		CommonNPC_ChangeWepR1(ai, goal)
		
		--��Ղ��g����HP��
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_MagicR, TARGET_SELF, DIST_None, 0 );
		sinto3_826000Battle_Kougeki_Noato(ai, goal)
		
	--MP��30��菭�Ȃ����
	else

		--100% �ʏ�U��
		sinto3_826000Battle_Nomal(ai, goal)
		sinto3_826000Battle_Kougeki_Noato(ai, goal)
		
	end

end


---------------------------------------------------------
--  �U���s��
---------------------------------------------------------
function sinto3_826000Battle_Attack(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������p

	if fate <= 40 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		
	elseif fate <= 80 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	end
end
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function sinto3_826000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local KN_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local BackDist = 3.0							--��ނ��鋗��

	--10���@�����҂�
	--40���@���Ɉړ�
	--30���@���Ɉړ�
	--20���@�X�e�b�v�Ō��
	if KN_fate <= 20 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_NONE, 0, 0, 0 );
	elseif KN_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true , -1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(1,3), TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,50), true, true , -1 );
	end
end


---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function sinto3_826000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function sinto3_826000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function sinto3_826000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local NormalR_Dist = 0.5			--�E��U���̓K���ԍ���


	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Č��
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--�R���{���ꂷ�鋗��
local combRunPer = 65				--�R���{���ꂷ��m��
local combRunCountPer = 35			--�R���{����̌�ɍU������m��	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				if fate2 <= 60 then
					goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(3,5), TARGET_ENE_0, ai:GetRandam_Int(2,7), TARGET_ENE_0, false, -1 );
				else
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(1,3), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), ai:GetRandam_Int(0,1), true ,-1 );
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
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			end
			return true
		end
	end
	
	
return false;
end


