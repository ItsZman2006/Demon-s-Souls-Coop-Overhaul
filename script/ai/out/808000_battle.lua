-----------------------------------------------------------------------------------------------
--	�r���p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Biyo_808000_Battle, "biyo_808000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Biyo_808000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function biyo_808000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local targetDistY = ai:GetDistYSigned(TARGET_ENE_0);				--�G�^�[�Q�b�g�Ƃ̍��፷���擾

local Dragon_Dist = 40.0					--�򗳂Ƃ̓K������
local NormalR_Dist = 2.0					--�E��U���̓K���ԍ���

	--�򗳂Ɛ키�����Ȃ�
	if targetDistY >= 10.0 then
		--�򗳐�p�U��
		biyo_808000Battle_Dragon_Attack(ai, goal)
		
	--�U������ɂ͉�������Ȃ�
	elseif targetDist >= 15.0 then
		--�����ċ߂Â��ėl�q������
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, 8.0, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0, 0, 0, 0 );
		
	--�{�E�K���ōU�����鋗���Ȃ�
	elseif targetDist >= 6.0 then
		--�������U��
		biyo_808000Battle_Normal_FarAttack(ai, goal)
			
	--���ōU�����鋗���Ȃ�
	else
		--�ߋ����U��
		biyo_808000Battle_Normal_NearAttack(ai, goal)
	end
end

---------------------------------------------------------
--  �򗳍U���p�^�[��
---------------------------------------------------------
function biyo_808000Battle_Dragon_Attack(ai, goal)

local fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local NormalL_Dist = ai:GetRandam_Int(50,60)	--�Δ򗳐�̓K���ԍ���

	--30% �߂Â��Ĕ���
	if fate <= 30 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalL_Dist, TARGET_ENE_0, false, -1 );
		biyo_808000Battle_NormalL_Comb(ai, goal)
		biyo_808000Battle_Kougeki_Noato2(ai, goal)

	--70% ���ړ����Ă��甭��
	else
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(1,3), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(35,50), false, true ,-1 );
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalL_Dist, TARGET_ENE_0, false, -1 );
		biyo_808000Battle_NormalL_Comb(ai, goal)
		biyo_808000Battle_Kougeki_Noato2(ai, goal)
	end

end

---------------------------------------------------------
--  �������U���p�^�[��
---------------------------------------------------------
function biyo_808000Battle_Normal_FarAttack(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local NormalR_Dist = 2.0					--�E��U���̓K���ԍ���

	--30% ���̏�Ŕ���
	if fate <= 30 then
		biyo_808000Battle_NormalL_Comb(ai, goal)
		biyo_808000Battle_Kougeki_Noato(ai, goal)

	--50% ���ړ����Ă��甭��
	elseif fate <= 80 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), false, true ,-1 );
		biyo_808000Battle_NormalL_Comb(ai, goal)
		biyo_808000Battle_Kougeki_Noato(ai, goal)
		
	--20% �����ċ߂Â��čU��
	else
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		biyo_808000Battle_NormalR_Comb(ai, goal)
		biyo_808000Battle_Kougeki_Noato(ai, goal)
	
	end
end

---------------------------------------------------------
--  �ߋ����U���p�^�[��
---------------------------------------------------------
function biyo_808000Battle_Normal_NearAttack(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local NormalR_Dist = 2.0					--�E��U���̓K���ԍ���

	--40% �����ċ߂Â��čU��
	if fate <= 40 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		biyo_808000Battle_NormalR_Comb(ai, goal)
		biyo_808000Battle_Kougeki_Noato(ai, goal)

	--40% �����ċ߂Â��ăK�[�h���Ȃ����荞��ōU��
	elseif fate <= 80 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(35,55), false, true , -1 );
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		biyo_808000Battle_NormalR_Comb(ai, goal)
		biyo_808000Battle_Kougeki_Noato(ai, goal)
	--20% ���������
	else 
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, ai:GetRandam_Int(6,8), TARGET_ENE_0, false, -1 );
	end
end

---------------------------------------------------------
--  �E��R���{�i�ߋ����j
---------------------------------------------------------
function biyo_808000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p

	--30% �E��U��2��
	--70% ���U��2��

	if NR_fate <= 30 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
---------------------------------------------------------
--  ����U���i�������j
---------------------------------------------------------
function biyo_808000Battle_NormalL_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p

	--100% ����U��
	-- 30% ����U���Q

	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_None, 0);

	if NR_fate <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_None, 0);
	end	

end

	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function biyo_808000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local BackDist = 3.5							--��ނ��鋗��


	--50���@���Ɉړ�
	--50���@���Ɉړ�
	if KN_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );				
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(3,5), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(45,60), false, true , -1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(4,6), TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				

	end
end


---------------------------------------------------------
--  �U����̍s��2
---------------------------------------------------------
function biyo_808000Battle_Kougeki_Noato2(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local KN_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local BackDist = 5.0

	if KN_fate <= 70 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );				
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(3,5), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(45,60), false, true , -1 );

	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end


---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function biyo_808000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function biyo_808000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function biyo_808000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local BackDist = 3.5				--��ނ��鋗��
local NormalR_Dist = 2.0			--�E��U���̓K���ԍ���

	--��U�肵����U��
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 4.0			--��U��ǌ����鋗��
local MissSwingAttPer = 40			--��U��ǌ�����m��	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
				biyo_808000Battle_NormalR_Comb(ai, goal)
				biyo_808000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end	
	end

	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Č�ށE����i�����j
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 2.0				--�R���{���ꂷ�鋗��
local combRunPer = 40				--�R���{���ꂷ��m��
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				if fate2 <= 60 then
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), false, true , -1 );
				else
					goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );
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
				biyo_808000Battle_NormalR_Comb(ai, goal)
				biyo_808000Battle_Kougeki_Noato(ai, goal)
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

