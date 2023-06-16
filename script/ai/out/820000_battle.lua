------------------------------------------------------------------------------------------------
--	�P�R�m�Z������p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Selen_820000_Battle, "Selen_820000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Selen_820000_Battle, 1 );

---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function Selen_820000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾

	--������HP�c�肪30%�ȏ�Ȃ�
	if hprate >= 0.3 then

		--�ʏ�s��
		Selen_820000Battle_Normal_Attack(ai, goal)			

	--������HP�c�肪30%�ȉ��Ȃ�
	else

		--�m���s��		
		Selen_820000Battle_Dying_Attack(ai, goal)

	end
	
end

---------------------------------------------------------
--  �ʏ�s��
---------------------------------------------------------
function Selen_820000Battle_Normal_Attack(ai, goal)	

	--��������Ԉُ�ł���(�o���A�u�a�A�Łj
	if ( 	ai:HasSpecialEffectAttribute(TARGET_SELF, SP_EFFECT_TYPE_BLOOD)
		or	ai:HasSpecialEffectAttribute(TARGET_SELF, SP_EFFECT_TYPE_ILLNESS)
		or	ai:HasSpecialEffectAttribute(TARGET_SELF, SP_EFFECT_TYPE_POIZON)) then
		
		--���@�i��Ԉُ�񕜁j
		Selen_820000Battle_Magic_Cure(ai, goal)
			
	--��������Ԉُ�łȂ�
	else
	
		--�G�����@�������Ă��Ȃ����
		if ( -1 == ai:GetCurrEquipMagicID(TARGET_ENE_0) ) then

			--����ōU��
			Selen_820000Battle_Sword(ai, goal)
			Selen_820000Battle_Kougeki_Noato(ai, goal)
	
		--���肪���@�������Ă����
		else
		
			--�A���`�}�W�b�N���g����1���^�C�}�[�Z�b�g
			if ( ai:IsFinishTimer(0) ) then
				Selen_820000Battle_Magic_AntiMagic(ai, goal)
				ai:SetTimer(0,60);
			
			--�A���`�}�W�b�N���g���Ă���1���o���Ă��Ȃ�
			else
				--����ōU��
				Selen_820000Battle_Sword(ai, goal)
				Selen_820000Battle_Kougeki_Noato(ai, goal)
			
			end
		end
	end
end


---------------------------------------------------------
--  �m���s��
---------------------------------------------------------
function Selen_820000Battle_Dying_Attack(ai, goal)	

local selfmp = ai:GetMp(TARGET_SELF)			--�����̎c��MP���擾

	--���@�P���g����
	if selfmp >= 60 then

		--�G���狗�����Ƃ�
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 4.0, TARGET_ENE_0, 5.0, TARGET_ENE_0, false, -1 );

		--��񕜂ɐ؂�ւ���HP��
		CommonNPC_SwitchOneHandMode(ai, goal)
		ai:ChangeEquipMagic(0);
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_SELF, DIST_None, 0 );
		Selen_820000Battle_Kougeki_Noato(ai, goal)
		
	--���@�P���g���Ȃ�
	else

		--100% �ʏ�U��
		Selen_820000Battle_Sword(ai, goal)
		Selen_820000Battle_Kougeki_Noato(ai, goal)
		
	end
		
end

	
---------------------------------------------------------
--  �U���F����
---------------------------------------------------------
function Selen_820000Battle_Sword(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋������擾
local NormalR_Dist = 1.5						--�E��U���̓K���ԍ���	

local fate = ai:GetRandam_Int(1,100)			--�m������p
local fate2 = ai:GetRandam_Int(1,100)			--�m������p

	--�U���������ɂ��Ȃ��Ȃ�
	if targetDist >= NormalR_Dist then
	
		--60% �����ċ߂Â��čU��
		if fate <= 60 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			Selen_820000Battle_NormalR_Comb(ai, goal)
			Selen_820000Battle_Kougeki_Noato(ai, goal)

		--30% ���񂵂ėl�q�����Ă��瑖���ċ߂Â��čU��
		elseif fate <= 90 then
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,50), false, true , -1 );
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			Selen_820000Battle_NormalR_Comb(ai, goal)
			Selen_820000Battle_Kougeki_Noato(ai, goal)

		--10% ���������
		else 
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(2,4), TARGET_ENE_0, false, -1 );
		end
	
	--�U���������ɂ���Ȃ�
	else

		--40% �U��
		if fate2 <= 40 then
			Selen_820000Battle_NormalR_Comb(ai, goal)
			Selen_820000Battle_Kougeki_Noato(ai, goal)

		--40% ���񂵂čU��
		elseif fate2 <= 80 then
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,50), false, true , -1 );
			Selen_820000Battle_NormalR_Comb(ai, goal)
			Selen_820000Battle_Kougeki_Noato(ai, goal)

		--20% ���������
		else 
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(2,4), TARGET_ENE_0, false, -1 );
		end

	end
end

---------------------------------------------------------
--  �U���F���@�i�A���`�}�W�b�N�j
---------------------------------------------------------
function Selen_820000Battle_Magic_AntiMagic(ai, goal)

local selfmp = ai:GetMp(TARGET_SELF)			--�����̎c��MP���擾 
local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋������擾
local BackDist = 5.0							--��ނ��鋗��

	--���@�Q���g����
	if selfmp >= 10 then

		--���@�Q�ɐ؂�ւ���
		CommonNPC_SwitchOneHandMode(ai, goal)
		ai:ChangeEquipMagic(1);
		
		--5M�ȏ㗣��Ă����炻�̏�Ŗ��@
		if targetDist >= BackDist then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_None, 0);
			Selen_820000Battle_Kougeki_Noato(ai, goal)

		--5M�ȓ��ɂ����瑖���ė���Ė��@
		else
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_None, 0);
			Selen_820000Battle_Kougeki_Noato(ai, goal)
			
		end
	
	--���@�Q���g���Ȃ�
	else
	
		--100% �ʏ�U��
		Selen_820000Battle_Sword(ai, goal)
		Selen_820000Battle_Kougeki_Noato(ai, goal)
		
	end
end

---------------------------------------------------------
--  �U���F���@�i��Ԉُ�񕜁j
---------------------------------------------------------
function Selen_820000Battle_Magic_Cure(ai, goal)

local selfmp = ai:GetMp(TARGET_SELF)			--�����̎c��MP���擾 

	--���@�R���g����
	if selfmp >= 30 then
	
		--���@�R�ɐ؂�ւ���
		CommonNPC_SwitchOneHandMode(ai, goal)
		ai:ChangeEquipMagic(2);
		
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_None, 0);
		Selen_820000Battle_Kougeki_Noato(ai, goal)
	
	--���@�R���g���Ȃ�
	else
		--����ōU��
		Selen_820000Battle_Sword(ai, goal)
		Selen_820000Battle_Kougeki_Noato(ai, goal)
	end	

end

---------------------------------------------------------
--  �E��R���{
---------------------------------------------------------
function Selen_820000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p
local NR_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local NR_fate3 = ai:GetRandam_Int(1,100)		--�m������p


	--50% �Ў�U��2��
		--30% �Ў�U��4��
	--50% ����U��2��
		--10% ����U��4��
	
	
	if NR_fate <= 50 then
		CommonNPC_SwitchOneHandMode(ai, goal)
	
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);

			if NR_fate2 <= 30 then
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
			end
	
	else
		CommonNPC_SwitchBothHandMode(ai, goal)
		
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
			
			if NR_fate3 <= 10 then
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			end	
	end
end
	

---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function Selen_820000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local BackDist = 2.5							--��ނ��鋗��

	--30% �������Ȃ�
	--40% ���Ɉړ�
	--30% ���Ɉړ����Ă��牡�ړ�
	
	if KN_fate <= 30 then
		goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_NONE, 0, 0, 0 );
	elseif KN_fate <= 70 then
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true , -1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(1,3), TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,50), true, true , -1 );
	end
end



---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function Selen_820000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function Selen_820000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function Selen_820000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

	--�߂��ŋ�U�肵����s������
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 2.0			--��U��s�����鋗��
local MissSwingAttPer = 50			--��U��s������m��	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				--50% �����Č��
				if fate2 <= 50 then
					goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, ai:GetRandam_Int(2,4), TARGET_ENE_0, false, -1 );

				--50% �ʏ�s��
				else
					Selen_820000Battle_Normal_Attack(ai, goal)
					Selen_820000Battle_Kougeki_Noato(ai, goal)
				end
				return true;
			end
		end	
	end


	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Č��
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 2.0				--�R���{���ꂷ�鋗��
local combRunPer = 40				--�R���{���ꂷ��m��
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				if fate2 <= 60 then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
				elseif fate2 <= 80 then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
				else
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
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

