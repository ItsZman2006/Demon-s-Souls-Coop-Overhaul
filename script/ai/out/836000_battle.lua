-----------------------------------------------------------------------------------------------
--	�S��P����O�u���b�N�S�[�X�g�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_RouBG_836000_Battle, "RouBG_836000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_RouBG_836000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function RouBG_836000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local nearDist = 6.0						--�{�E�K���ōU�����鋗��


	--�{�E�K���ōU�����鋗���Ȃ�
	if targetDist >= nearDist then

		--�������U��
		RouBG_836000Battle_Normal_FarAttack(ai, goal)
			
	--�_�K�[�ōU�����鋗���Ȃ�
	else
		
		--�ߋ����U��
		RouBG_836000Battle_Normal_NearAttack(ai, goal)
	end
end


---------------------------------------------------------
--  �������U���p�^�[��
---------------------------------------------------------
function RouBG_836000Battle_Normal_FarAttack(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���

	--�{�E�K���Ɏ����ւ���
	CommonNPC_ChangeWepL1(ai, goal)

	--45% ���̏�Ŕ���
	if fate <= 45 then
		RouBG_836000Battle_NormalL_Comb(ai, goal)
		RouBG_836000Battle_Kougeki_Noato(ai, goal)

	--55% ���ړ����Ă��甭��
	else
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(1,3), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(20,35), true, true ,-1 );
		RouBG_836000Battle_NormalL_Comb(ai, goal)
		RouBG_836000Battle_Kougeki_Noato(ai, goal)
	end

end

---------------------------------------------------------
--  �ߋ����U���p�^�[��
---------------------------------------------------------
function RouBG_836000Battle_Normal_NearAttack(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local NormalR_Dist = 1.0					--�E��U���̓K���ԍ���

	--�o�b�N���[�Ɏ����ւ���
	CommonNPC_ChangeWepL2(ai, goal)

	--40% �����ċ߂Â��čU��
	if fate <= 40 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		RouBG_836000Battle_NormalR_Comb(ai, goal)
		RouBG_836000Battle_Kougeki_Noato(ai, goal)

	--25% �����ċ߂Â��ăK�[�h���Ȃ����荞��ōU��
	elseif fate <= 65 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(90,120), false, true , 4 );
		RouBG_836000Battle_NormalR_Comb(ai, goal)
		RouBG_836000Battle_Kougeki_Noato(ai, goal)
	--35% ���������
	else 
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(5,6), TARGET_ENE_0, ai:GetRandam_Int(6,8), TARGET_ENE_0, false, 4 );
	end
end

---------------------------------------------------------
--  �E��R���{�i�ߋ����j
---------------------------------------------------------
function RouBG_836000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p
local NR_fate2 = ai:GetRandam_Int(1,100)		--�m������p

	--100% �E��U��2��
	--60% �E��U��4��
	--10% ���U��
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);

	if NR_fate <= 60 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	end
	
	if NR_fate2 <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	end
end
	
---------------------------------------------------------
--  ����U���i�������j
---------------------------------------------------------
function RouBG_836000Battle_NormalL_Comb(ai, goal)

	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Far, 0);

end


	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function RouBG_836000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local BackDist = 2.5							--��ނ��鋗��


	--50���@���Ɉړ�
	--50���@���Ɉړ�
	if KN_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, BackDist, TARGET_ENE_0, false, 4 );				
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(3,5), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(45,65), false, true , 4 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(4,6), TARGET_ENE_0, BackDist, TARGET_ENE_0, true, 4 );				

	end
end




---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function RouBG_836000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function RouBG_836000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function RouBG_836000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local NormalR_Dist = 1.0			--�E��U���̓K���ԍ���
local BackDist = 5.0				--��ނ��鋗��

	--��U�肵����U��
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 2.0			--��U��ǌ����鋗��
local MissSwingAttPer = 40			--��U��ǌ�����m��	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
				RouBG_836000Battle_NormalR_Comb(ai, goal)
				RouBG_836000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end	
	end

	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Č�ށE����i�����j
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 2.0				--�R���{���ꂷ�鋗��
local combRunPer = 40				--�R���{���ꂷ��m��
local combRunCountPer = 100			--�R���{����̌�ɍU������m��	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				if fate2 <= 60 then
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(90,120), false, true , 4 );
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
				else
					goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, BackDist, TARGET_ENE_0, false, 4 );				
				end	
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
				RouBG_836000Battle_NormalR_Comb(ai, goal)
				RouBG_836000Battle_Kougeki_Noato(ai, goal)
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
			return true
		end
	end
	

return false;
end

