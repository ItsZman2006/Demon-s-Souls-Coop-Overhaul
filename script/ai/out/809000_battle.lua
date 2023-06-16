-----------------------------------------------------------------------------------------------
--	�p�b�`�i�B���j�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_pachi809000_Battle, "pachi809000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_pachi809000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function pachi809000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local NormalR_Dist = 2.5								--�E��U���̓K���ԍ���

	--�K�[�h�J�n
	ai:StartGuard(4);

	--�߂��Ȃ�
	if targetDist >= NormalR_Dist then
		--��{�퓬�i�߂��j
		pachi809000Battle_Normal_Near(ai, goal)
	--�ɒ[�ɋ߂��Ȃ�
	else
		--��{�퓬�i�ɒ[�ɋ߂��j
		pachi809000Battle_Normal_TooNear(ai, goal)
	
	end	
end


--------------------------------------------------------
--  ��{�퓬�i�ɒ[�ɋ߂��j
---------------------------------------------------------
function pachi809000Battle_Normal_TooNear(ai, goal)

local fate = ai:GetRandam_Int(1,100)	--�m������p
local Attack_fate = 50 					--�U������m��
 
	--50% �K�[�h�U��
	if fate <= Attack_fate then
		pachi809000Battle_NormalR_Comb(ai, goal)
		pachi809000Battle_Kougeki_Noato(ai, goal)
	--50% �K�[�h
	else
		pachi809000Battle_Kougeki_Noato(ai, goal)
	end

end

--------------------------------------------------------
--  ��{�퓬�i�߂��j
---------------------------------------------------------
function pachi809000Battle_Normal_Near(ai, goal)

local NormalR_Dist = 2.5				--�E��U���̓K���ԍ���

local fate = ai:GetRandam_Int(1,100)	--�m������p
local Attack_fate = 30					--�ڋߍU��������m��

	--50% �K�[�h���Ȃ���ڋ�
	if fate <= Attack_fate then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	
	--50% �K�[�h���Ȃ������
	else
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), false, true, -1 )

	end
end
	
---------------------------------------------------------
--  �E��R���{
---------------------------------------------------------
function pachi809000Battle_NormalR_Comb(ai, goal)

local fate = ai:GetRandam_Int(1,100)	--�m������p
local Second_Attack_Per = 15 			--�ǉ��U������m��

	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);

	if fate <= Second_Attack_Per then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	end
	
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function pachi809000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local KN_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local BackDist = 3.0							--��ނ��鋗��

	--30% �K�[�h
	--30% �K�[�h���Ȃ��牡�ړ�
	--40% �K�[�h���Ȃ�����
	if KN_fate <= 30 then
		goal:AddSubGoal( GOAL_COMMON_Guard, 3.0, 4, TARGET_ENE_0, false, 0 );
	elseif KN_fate <= 60 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, false, true , -1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );				
	end
end




---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function pachi809000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function pachi809000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function pachi809000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���


	--��U�肵����U��
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 4.0			--��U��ǌ����鋗��
local MissSwingAttPer = 20			--��U��ǌ�����m��	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				pachi809000Battle_NormalR_Comb(ai, goal)
				pachi809000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end	
	end

	
	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Ĕ����E���
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--�R���{���ꂷ�鋗��
local combRunPer = 40				--�R���{���ꂷ��m��
local combRunCountPer = 15			--�R���{����̌�ɍU������m��	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				pachi809000Battle_Kougeki_Noato(ai, goal)

				--�R���{�����̍U��
				if fate3 <= combRunCountPer then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
				end
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
			--�����
				pachi809000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end
	end
	
	--�K�[�h���󂵂���U��
	if ai:IsInterupt( INTERUPT_GuardBreak ) then
local guardBreakConutDist = 2.0			--�K�[�h����ōU�����鋗��
local guardBreakConutPer = 50			--�K�[�h����ōU������m��
		if targetDist <= guardBreakConutDist then
			if fate <= guardBreakConutPer then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
				pachi809000Battle_Kougeki_Noato(ai, goal)
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
local itemUseIntPer = 50				--�A�C�e���g�p���ɍœK�s�������m��
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();		
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			pachi809000Battle_NormalR_Comb(ai, goal)
			pachi809000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	
return false;
end




--[[****************************************************************************************]]
--[[************************************** �T�u�S�[�� **************************************]]
--[[****************************************************************************************]]

--[[**********************************************************************
	�󔠂̈ʒu�܂ňړ��B
************************************************************************]]
REGISTER_GOAL(GOAL_pachi809000_MoveToTreasure, "pachi809000MTT");
REGISTER_GOAL_NO_UPDATE(GOAL_pachi809000_MoveToTreasure, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_pachi809000_MoveToTreasure, true);

function pachi809000MTT_Activate(ai, goal)

	goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, -1, POINT_EVENT, AI_DIR_TYPE_CENTER, 0, TARGET_SELF, false);

end

function pachi809000MTT_Update(ai, goal) return GOAL_RESULT_Continue; end
function pachi809000MTT_Terminate(ai, goal)end
function pachi809000MTT_Interupt(ai, goal) return false; end
