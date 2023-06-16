-----------------------------------------------------------------------------------------------
--	�n�[�t�n���h�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_half815000_Battle, "half815000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_half815000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function half815000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------
local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾
local selfmp = ai:GetMp(TARGET_SELF)					--�����̎c��MP���擾

	--HP��2����葽��
	if hprate >= 0.2 then
	
		--�ʏ�s��
		half815000Battle_Normal_Act(ai, goal)

	--HP��2����菭�Ȃ�
	else
		
		--�m���s��
		half815000Battle_Dying_Act(ai, goal)
		
	end
end

---------------------------------------------------------
--  �ʏ�s��
---------------------------------------------------------
function half815000Battle_Normal_Act(ai, goal)

local selfmp = ai:GetMp(TARGET_SELF)			--�����̎c��MP���擾

	--���W�F�l���g����Ȃ�
	if selfmp >= 40 then
		
		--���W�F�l���g���ă^�C�}�[�Z�b�g
		if ( ai:IsFinishTimer(0) ) then
			half815000Battle_Magic_Comb_First(ai, goal)
			ai:SetTimer(0,180);
			
		--���W�F�l���g���Ă����莞�Ԍo�߂��Ă��Ȃ��Ȃ�
		else
			--�U��
			half815000Battle_Normal_Attack(ai, goal)
			half815000Battle_Kougeki_Noato(ai, goal)
			
		end
	
	--���W�F�l���g���Ȃ��Ȃ�
	else
	
		--�U��
		half815000Battle_Normal_Attack(ai, goal)
		half815000Battle_Kougeki_Noato(ai, goal)
	
	end

end	
	
	
---------------------------------------------------------
--  �m���s��
---------------------------------------------------------
function half815000Battle_Dying_Act(ai, goal)

local selfmp = ai:GetMp(TARGET_SELF)			--�����̎c��MP���擾

	--������MP��60��葽�����
	if selfmp >= 60 then
	
		--���@�R���{�i�񕜁j
		half815000Battle_Magic_Comb_Cure(ai, goal)

	--������MP��60�ȉ��Ȃ�
	else
		
		--�U���F��
		half815000Battle_Weapon(ai, goal)
		half815000Battle_Kougeki_Noato(ai, goal)

	end
end	


--[[-------------------------------------------------------
--  �U���i���@���o��������U�����o���������Ŕ��ʁj
---------------------------------------------------------]]
function half815000Battle_Normal_Attack(ai, goal)	

local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋������擾
local magicDist = 4.0							--���@�ōU�����鋗��
	
	--���@�ōU�����鋗���Ȃ�
	if targetDist >= magicDist then
		--���@�ōU��
		half815000Battle_Magic(ai, goal)
		
	--����ōU�����鋗���Ȃ�
	else
		--����ōU��
		half815000Battle_Weapon(ai, goal)
	end	
end
	
	
--[[-------------------------------------------------------
--  �U���F���@�i������MP�̌��ݒl�����Ė��@��؂�ւ���j
---------------------------------------------------------]]
function half815000Battle_Magic(ai, goal)

local selfmp = ai:GetMp(TARGET_SELF)			--�����̎c��MP���擾
	
	--������MP��20��葽�����
	if selfmp >= 20 then
	
		--���@�P�ƂQ�������_���ɐ؂�ւ���
		ai:ChangeEquipMagic(ai:GetRandam_Int(0,1));
		half815000Battle_Magic_Comb(ai, goal)

	--������MP��2��葽�����
	elseif selfmp >= 2 then
		
		--���@�P�ɐ؂�ւ���
		ai:ChangeEquipMagic(0);
		half815000Battle_Magic_Comb(ai, goal)
	
	--������MP��2�ȉ��Ȃ�
	else
		
		half815000Battle_Weapon(ai, goal)
		half815000Battle_Kougeki_Noato(ai, goal)

	end
	
end

---------------------------------------------------------
--  �U���F��
---------------------------------------------------------
function half815000Battle_Weapon(ai, goal)

local fate = ai:GetRandam_Int(1,100)			--�m������p
local NormalR_Dist = 2.5						--�E��U���̓K���ԍ���	

	--30% �����ċ߂Â��čU��
	if fate <= 30 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		half815000Battle_NormalR_Comb(ai, goal)
		half815000Battle_Kougeki_Noato(ai, goal)

	--30% �����ċ߂Â��ăK�[�h���Ȃ����荞��ōU��
	elseif fate <= 60 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), false, true , -1 );
		half815000Battle_NormalR_Comb(ai, goal)
		half815000Battle_Kougeki_Noato(ai, goal)

	--20% �ߐږ��@���g��
	elseif fate <= 80 then
		
		--���@3�ɐ؂�ւ���
		half815000Battle_Magic_Comb_Near(ai, goal)
	
	--20% ���������
	else 
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, ai:GetRandam_Int(6,8), TARGET_ENE_0, false, -1 );
	end
	
end


---------------------------------------------------------
--  ����R���{�i�ߋ����j
---------------------------------------------------------
function half815000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p
local NR_fate2 = ai:GetRandam_Int(1,100)		--�m������p

	--100% �E��U��2��
	--60% �E��U��4��
	--10% ���U��

	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);

	if NR_fate <= 60 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	end
	
	if NR_fate2 <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	end
end
	

---------------------------------------------------------
--  ���@�R���{
---------------------------------------------------------
function half815000Battle_Magic_Comb(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋������擾
local magicDist = 7.0							--���@�K������
local index_magic = ai:GetEquipMagicIndex();	--���ݑ������Ă��閂�@�̎�ނ��擾

	--�������Ă��閂�@���}�V���K���Ȃ�
--	if ( 0 == index_magic ) then
		
		--���@�R���{�i�}�V���K���p�j
--		half815000Battle_Magic_Comb_MACHINEGUN(ai, goal)
		
	--����ȊO�Ȃ�
--	else
	
		--�G�����@�K��������艓���ɂ���
		if targetDist >= magicDist then
		
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, magicDist, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
			half815000Battle_Kougeki_Noato(ai, goal)
			
		else
		
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
			half815000Battle_Kougeki_Noato(ai, goal)
		end
--	end
end


---------------------------------------------------------
--  ���@�R���{�i�}�V���K���p�j
---------------------------------------------------------
function half815000Battle_Magic_Comb_MACHINEGUN(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋������擾
local magicDist = 7.0							--���@�K������
local selfmp = ai:GetMp(TARGET_SELF)			--�����̎c��MP���擾

	--�c��MP��10�ȏ�Ȃ�A��
	if selfmp >= 10 then
	
		--�G�����@�K��������艓���ɂ���
		if targetDist >= magicDist then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, magicDist, TARGET_ENE_0, true, -1 );
		end
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
			half815000Battle_Kougeki_Noato(ai, goal)
	else
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
		half815000Battle_Kougeki_Noato(ai, goal)
	end
end

---------------------------------------------------------
--  ���@�R���{�i�ߐځj
---------------------------------------------------------
function half815000Battle_Magic_Comb_Near(ai, goal)

local selfmp = ai:GetMp(TARGET_SELF)			--�����̎c��MP���擾
local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋������擾
local magicDist = 1.5							--���@�K������

	--���@�R���g����
	if selfmp >= 10 then 
 
		--���@�R�ɐ؂�ւ���
		ai:ChangeEquipMagic(2);	

		--�G�����@�K��������艓���ɂ���
		if targetDist >= magicDist then
		
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, magicDist, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
			half815000Battle_Kougeki_Noato(ai, goal)
			
		else
		
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
			half815000Battle_Kougeki_Noato(ai, goal)
		end

	--���@�R���g���Ȃ�
	else
		
		--����R���{
		half815000Battle_NormalR_Comb(ai, goal)
	end
end

---------------------------------------------------------
--  ���@�R���{�i�񕜁j
---------------------------------------------------------
function half815000Battle_Magic_Comb_Cure(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋������擾
local magicDist = 5.0							--���@�K������

	--���@�S�i��񕜁j�ɐ؂�ւ���
	ai:ChangeEquipMagic(3);

	--�G�����@�K��������艓���ɂ���
	if targetDist >= magicDist then
	
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
		half815000Battle_Kougeki_Noato(ai, goal)

	else
	
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, 6.0, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
		half815000Battle_Kougeki_Noato(ai, goal)
		
	end

end

---------------------------------------------------------
--  ���@�R���{�i�����j
---------------------------------------------------------
function half815000Battle_Magic_Comb_First(ai, goal)

	--���������
	half815000Battle_Kougeki_Noato(ai, goal)
	
	--���@�T�ɐ؂�ւ���
	ai:ChangeEquipMagic(4);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_None, 0);

end

---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function half815000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local BackDist = ai:GetRandam_Int(4,7)							--��ނ��鋗��

	--50���@���Ɉړ�
	--50���@���Ɉړ�
	if KN_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );				
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(3,5), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(45,65), false, true , -1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(4,6), TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );				

	end
end



---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function half815000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function half815000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function half815000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

	--�߂��ŋ�U�肵����U������
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 4.0			--��U�蓦�����鋗��
local MissSwingAttPer = 50			--��U�蓦������m��	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				half815000Battle_Weapon(ai, goal)
				half815000Battle_Kougeki_Noato(ai, goal)
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
				half815000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end
	end	

	--��ѓ���������Ă�����œK�s��
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 50					--��ѓ���g�p���ɍœK�s�������m��
		if fate <= shootIntPer then
			goal:ClearSubGoal();
			half815000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end	
	

	return false;
end

