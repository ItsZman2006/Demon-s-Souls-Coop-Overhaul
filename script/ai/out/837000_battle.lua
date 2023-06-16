------------------------------------------------------------------------------------------------
--	����O�e�mA�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_TroisM_A837000_Battle, "TroisM_A837000Battle");
-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_TroisM_A837000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function TroisM_A837000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local NormalR_Dist = 2.5					--�E��U���̓K���ԍ���
local FarDist = 25.0

	--�K�[�h�J�n
	ai:StartGuard(4);

	--�����Ȃ�
	if targetDist >= FarDist then
		--��{�퓬�i�����j
		TroisM_A837000Battle_Normal_Far(ai, goal)
	--�߂��Ȃ�
	elseif targetDist >= NormalR_Dist then
		--��{�퓬�i�߂��j
		TroisM_A837000Battle_Normal_Near(ai, goal)
	--�ɒ[�ɋ߂��Ȃ�
	else
		--��{�퓬�i�ɒ[�ɋ߂��j
		TroisM_A837000Battle_Normal_TooNear(ai, goal)

	end	
end


--------------------------------------------------------
--  ��{�퓬�i�ɒ[�ɋ߂��j
---------------------------------------------------------
function TroisM_A837000Battle_Normal_TooNear(ai, goal)

local fate = ai:GetRandam_Int(1,100)	--�m������p
local Attack_fate = 60 					--�U������m��
 
	--60% �K�[�h�U��
	if fate <= Attack_fate then
		TroisM_A837000Battle_NormalR_Comb(ai, goal)
		TroisM_A837000Battle_Kougeki_Noato(ai, goal)
	--40% �K�[�h
	else
		TroisM_A837000Battle_Kougeki_Noato(ai, goal)
	end

end

--------------------------------------------------------
--  ��{�퓬�i�߂��j
---------------------------------------------------------
function TroisM_A837000Battle_Normal_Near(ai, goal)

local NormalR_Dist = 2.5				--�E��U���̓K���ԍ���

local fate = ai:GetRandam_Int(1,100)	--�m������p
local Attack_fate = 90					--�ڋߍU��������m��

	--90% �K�[�h���Ȃ���ڋ�
	if fate <= Attack_fate then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	
	--10% �K�[�h���Ȃ�������A�ڋ�
	else
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,25), true, true, -1 )
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		
	end
end

--------------------------------------------------------
--  ��{�퓬�i�����j
---------------------------------------------------------
function TroisM_A837000Battle_Normal_Far(ai, goal)

local fate = ai:GetRandam_Int(1,100)	--�m������p
local Attack_fate = 70					--�ڋ߂���m��

	--70% �K�[�h���Ȃ���ڋ�
	if fate <= Attack_fate then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
	
	--30% �K�[�h���Ȃ��炻�̏�őҋ@
	else
		goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_ENE_0, 0, 0, 0 );

	end
end
	
---------------------------------------------------------
--  �E��R���{
---------------------------------------------------------
function TroisM_A837000Battle_NormalR_Comb(ai, goal)

local fate = ai:GetRandam_Int(1,100)	--�m������p
local fate2 = ai:GetRandam_Int(1,100)	--�m������p2
local Second_Attack_Per = 30 			--�ǉ��U������m��

	if fate <= 60 then
	
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);

		if fate2 <= Second_Attack_Per then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		end
	
	else
	
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		
	end
	
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function TroisM_A837000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local BackDist = 3.0							--��ނ��鋗��

	--60% �K�[�h���Ȃ��牡�ړ�
	--40% �K�[�h���Ȃ�����
	if KN_fate <= 60 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true , -1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end




---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function TroisM_A837000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function TroisM_A837000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function TroisM_A837000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���
local BackDist = 3.0				--��ނ��鋗��


	--�߂��ŋ�U�肵����U������
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 2.5			--��U��U�����鋗��
local MissSwingAttPer = 50			--��U��U������m��	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				TroisM_A837000Battle_NormalR_Comb(ai, goal)
				return true;
			end
		end	
	end


	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Č��
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 2.0				--�R���{���ꂷ�鋗��
local combRunPer = 45				--�R���{���ꂷ��m��
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				if fate2 <= 60 then
					goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );
				else
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true , -1 );
				end	
				return true;
			end
		end
	end	
	
	--�A�C�e�����g������œK�s��
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 20				--�A�C�e���g�p���ɍœK�s�������m��
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();		
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
			TroisM_A837000Battle_NormalR_Comb(ai, goal)
			TroisM_A837000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	
return false;
end

