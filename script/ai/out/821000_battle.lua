-----------------------------------------------------------------------------------------------
--	�����p�퓬
--	�����F 
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Majo_821000_Battle, "majo_821000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Majo_821000_Battle, 1 );

---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function majo_821000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q

local NormalR_Dist = 4.0					--�E��U���̓K���ԍ���


	--�ɒ[�ɋ߂��Ȃ��Ȃ�
	if targetDist >= NormalR_Dist then
		--30���@�����ċ߂Â�
		--70���@���񂵂čU��
		if fate <= 30 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0,  true, -1 );
		else
			goal:AddSubGoal( GOAL_COMMON_SidewayMove, 4.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
			majo_821000Battle_Magic_Comb(ai, goal)
			majo_821000Battle_Kougeki_Noato(ai, goal)
		end
	--�ɒ[�ɋ߂��Ȃ�
	else
		--60���@���
		--40���@����U��
		if fate2 <= 60 then
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, 2.0, TARGET_ENE_0, true, -1 );
		else
			goal:AddSubGoal( GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
			majo_821000Battle_Magic_Comb2(ai, goal)
		end
	end

end



---------------------------------------------------------
--  ���@�R���{
---------------------------------------------------------
function majo_821000Battle_Magic_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p
local NR_fate2 = ai:GetRandam_Int(1,100)			--�m������p2

	--���������@�ɐ؂�ւ���
	ai:ChangeEquipMagic(1);
	
	--���@�ōU��
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_MagicR, TARGET_ENE_0, DIST_Far, 0);

end
	

---------------------------------------------------------
--  ���@�R���{�Q
---------------------------------------------------------
function majo_821000Battle_Magic_Comb2(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p
local NR_fate2 = ai:GetRandam_Int(1,100)			--�m������p2

	--�ߋ������@�ɐ؂�ւ���
	ai:ChangeEquipMagic(0);
	
	--���@�ōU��
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_MagicR, TARGET_ENE_0, DIST_Far, 0);

end
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function majo_821000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local KN_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local BackDist = 2.5							--��ނ��鋗��

	--50���@�����҂�
	--25���@���Ɉړ�
	--15���@���Ɉړ�
	--10���@�X�e�b�v�Ō��
	if KN_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_NONE, 0, 0, 0 );
	elseif KN_fate <= 75 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end




---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function majo_821000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function majo_821000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function majo_821000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local BackDist = 5.0				--��ނ��鋗��
local NormalR_Dist = 4.0			--�E��U���̓K���ԍ���

	--��U�肵������
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 4.0			--��U���ނ��鋗��
local MissSwingAttPer = 50			--��U���ނ���m��	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );	
				return true;
			end
		end	
	end

	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Č��
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--�R���{���ꂷ�鋗��
local combRunPer = 40				--�R���{���ꂷ��m��
local combRunCountPer = 5			--�R���{����̌�ɍU������m��	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				if fate2 <= 60 then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
					goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, 2.0, TARGET_ENE_0, true, -1 );
				else
					majo_821000Battle_Magic_Comb2(ai, goal)
					majo_821000Battle_Kougeki_Noato(ai, goal)
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
	
	--�A�C�e�����g������œK�s��
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 30				--�A�C�e���g�p���ɍœK�s�������m��
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();		
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
			majo_821000Battle_Magic_Comb(ai, goal)
			majo_821000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	
return false;
end

