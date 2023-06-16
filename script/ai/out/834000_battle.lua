-----------------------------------------------------------------------------------------------
--	�B���Q�u���b�N�S�[�X�g�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_KoudouBG_834000_Battle, "KoudouBG_834000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_KoudouBG_834000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function KoudouBG_834000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100);		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100);		--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100);		--�m������Ŏg�p����^���̐����@����3
local fate4 = ai:GetRandam_Int(1,100);		--�m������Ŏg�p����^���̐����@����4

local farDist = 15.0						--�����Ɣ��f���鋗��
local nearDist = 4.0						--�߂��Ɣ��f���鋗��
local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���

	--�����Ȃ�
	if targetDist >= farDist then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal( GOAL_COMMON_ContinueAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0 );
		
	--�������Ȃ����A�߂����Ȃ��Ȃ�
	elseif targetDist >= nearDist then
		--20���@�����ċ߂Â��čU��
		--75���@���ړ��ŗl�q��
		--5���@��э��ݐ؂�
		if fate <= 20 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, ai:GetRandam_Int(0,1), -1 );
			KoudouBG_834000Battle_NormalR_Comb(ai, goal);
			KoudouBG_834000Battle_Kougeki_Noato(ai, goal);
		elseif fate <= 95 then
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,55), true, true ,4 );
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepF, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Near, 0);
		end
	
	--�߂��Ȃ�
	elseif targetDist >= NormalR_Dist then
		--30���@�����ċ߂Â��čU��	
		--80���@���񂵗l�q���M��
		if fate2 <= 30 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
			KoudouBG_834000Battle_NormalR_Comb(ai, goal);
			KoudouBG_834000Battle_Kougeki_Noato(ai, goal);
		else
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,55), true, true , 4 );
		end
	--�ɒ[�ɋ߂��Ȃ�
	else
		--20���@�U��
		--80���@�ړ�
		if fate3 <= 20 then
			KoudouBG_834000Battle_NormalR_Comb(ai, goal);
			KoudouBG_834000Battle_Kougeki_Noato(ai, goal);
		else
			if fate4 <= 50 then
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(1,2.5), TARGET_ENE_0, ai:GetRandam_Int(2,5), TARGET_ENE_0, true, -1 );
			else
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, ai:GetRandam_Int(1,3), TARGET_ENE_0, true, 4 );
				goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(20,45), true, true , 4 );
			end
		end
	end
		
end

---------------------------------------------------------
--  �E��R���{
---------------------------------------------------------
function KoudouBG_834000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p
local NR_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local NR_fate3 = ai:GetRandam_Int(1,100)		--�m������p
local NR_fate4 = ai:GetRandam_Int(1,100)		--�m������p

	--�E��U���Q��
	--75% �E��U��
	--50% �E��U��
	--25% �E��U��
	--50% �E���U��
	
	if NR_fate <= 10 then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_SwitchWep, TARGET_ENE_0, DIST_Near, 0 );
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);

		if NR_fate2 <= 10 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
		end

	elseif NR_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);

	elseif NR_fate <= 80 then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);

	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepF, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Middle, 0);
	end
end
	

	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function KoudouBG_834000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100);			--�m������p

	if KN_fate <= 40 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,55), true, true , 4 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(2,5), TARGET_ENE_0, true, 4 );				
	end
end




---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function KoudouBG_834000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function KoudouBG_834000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function KoudouBG_834000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���

	
	--��ѓ���������Ă�����œK�s��
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 10					--��ѓ���g�p���ɍœK�s�������m��
		if fate <= shootIntPer then
			goal:ClearSubGoal();
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, ai:GetRandam_Int(2,5), TARGET_ENE_0, true, 4 );
			return true;
		end
	end
	
	--�A�C�e�����g������œK�s��
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 10				--�A�C�e���g�p���ɍœK�s�������m��
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();
				if fate2 <= 80 then
				 	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
					KoudouBG_834000Battle_Kougeki_Noato(ai, goal);
				else
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
					KoudouBG_834000Battle_Kougeki_Noato(ai, goal);
				end
			return true
		end
	end


return false;
end

