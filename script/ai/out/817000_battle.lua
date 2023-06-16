-----------------------------------------------------------------------------------------------
--	���K�[���p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Rogan_817000_Battle, "rogan_817000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Rogan_817000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function rogan_817000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���

	--30% ����ōU��
	if fate <= 30 then
		
		--����U��
		rogan_817000Battle_Weapon_Attack(ai, goal)
	
	--70% ���@�ōU��
	else
		
		--���@�U��
		rogan_817000Battle_Magic_Attack(ai, goal)

	end
	
end

---------------------------------------------------------
--  ����U��
---------------------------------------------------------
function rogan_817000Battle_Weapon_Attack(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q

local NormalR_Dist = 1.5					--�E��U���̓K���ԍ���

	--�ɒ[�ɋ߂��Ȃ��Ȃ�
	if targetDist >= NormalR_Dist then
		--60���@�����ċ߂Â�
		--40���@�����ċ߂Â��Đ��񂵂čU��
		if fate <= 60 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1);
		else
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1);
			goal:AddSubGoal( GOAL_COMMON_SidewayMove, 4.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
			rogan_817000Battle_NormalR_Comb(ai, goal)
			rogan_817000Battle_Kougeki_Noato(ai, goal)
		end
	--�ɒ[�ɋ߂��Ȃ�
	else
		--40���@���
		--60���@����U��
		if fate2 <= 40 then
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, 2.0, TARGET_ENE_0, true, -1 );
		else
			goal:AddSubGoal( GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
			rogan_817000Battle_NormalR_Comb(ai, goal)
		end
	end
end

---------------------------------------------------------
--  ���@�U��
---------------------------------------------------------
function rogan_817000Battle_Magic_Attack(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q

local NormalR_Dist = 4.0					--�E��U���̓K���ԍ���

local selfmp = ai:GetMp(TARGET_SELF)		--�����̎c��MP���擾

	--�����̎c��MP��50��葽����Ζ��@�U��
	if selfmp >= 50 then		

		--�ɒ[�ɋ߂��Ȃ��Ȃ�
		if targetDist >= NormalR_Dist then
			--30���@�����ċ߂Â�
			--70���@���񂵂čU��
			if fate <= 10 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1);
			elseif fate <= 40 then
				goal:AddSubGoal( GOAL_COMMON_SidewayMove, 4.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
				rogan_817000Battle_Magic_Comb(ai, goal)
				rogan_817000Battle_Kougeki_Noato(ai, goal)
			else
				rogan_817000Battle_Magic_Comb(ai, goal)
				rogan_817000Battle_Kougeki_Noato(ai, goal)
			end
		--�ɒ[�ɋ߂��Ȃ�
		else
			--60���@���
			--40���@����U��
			if fate2 <= 60 then
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, 2.0, TARGET_ENE_0, true, -1 );
			else
				goal:AddSubGoal( GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
				rogan_817000Battle_Magic_Comb(ai, goal)
			end
		end
		
	--�����̎c��MP��50��菭�Ȃ���΃A�C�e�����g�p����MP��
	else
		goal:AddSubGoal( GOAL_COMMON_UseItem, 10.0, 0 );
	end
end

---------------------------------------------------------
--  ���@�R���{
---------------------------------------------------------
function rogan_817000Battle_Magic_Comb(ai, goal)

	--�G�}�������Ă��Ȃ���ΐG�}�Ɏ����ւ���
	CommonNPC_ChangeWepR1(ai, goal)

	--���@�������_���ɐ؂�ւ���
	ai:ChangeEquipMagic(ai:GetRandam_Int(0,3));
	
	--���@�ōU��
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_MagicR, TARGET_ENE_0, DIST_Middle, 0);

end
	
	
	
---------------------------------------------------------
--  �E��R���{
---------------------------------------------------------
function rogan_817000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p

	--����������Ă��Ȃ���Ύ����ւ���
	CommonNPC_ChangeWepR2(ai, goal)

	--70% ���E�A�g�U��
	--30% ���E�A�g���U��
	if NR_fate <= 20 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);

	elseif NR_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);

	elseif NR_fate <= 80 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function rogan_817000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local KN_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local BackDist = 4.0							--��ނ��鋗��

	--20���@�����҂�
	--55���@���Ɉړ�
	--25���@���Ɉړ�
	if KN_fate <= 20 then
		goal:AddSubGoal( GOAL_COMMON_Wait, 1.0, TARGET_NONE, 0, 0, 0 );
	elseif KN_fate <= 75 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end




---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function rogan_817000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function rogan_817000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function rogan_817000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local NormalR_Dist = 4.0			--�E��U���̓K���ԍ���


	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Č��
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--�R���{���ꂷ�鋗��
local combRunPer = 40				--�R���{���ꂷ��m��
local combRunCountPer = 5			--�R���{����̌�ɍU������m��	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, 2.0, TARGET_ENE_0, false, -1 );
				return true;
			end
		end
	end	
	
	
	--�A�C�e�����g������œK�s��
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 50				--�A�C�e���g�p���ɍœK�s�������m��
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();		
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
			rogan_817000Battle_Magic_Attack(ai, goal)
			rogan_817000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	
return false;
end

