-----------------------------------------------------------------------------------------------
--	�����h�����q�i�����j�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Ouji_807001_Battle, "ouji_807001Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Ouji_807001_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function ouji_807001Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

	--�ʏ�s��
	ouji_807001Battle_Kyori(ai, goal)
	
end

---------------------------------------------------------
--  �s���i�������ʁj
---------------------------------------------------------
function ouji_807001Battle_Kyori(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋������擾
local NormalR_Dist = 2.0						--�U���̓K���ԍ���
local Middle_Dist = 6.0 						--�����ċ߂Â�����

	--�����ċ߂Â������Ȃ�
	if targetDist >= Middle_Dist then
	
		--�s���i�������j
		ouji_807001Battle_Middle_Action(ai, goal)

	--�U�����͂��Ȃ������Ȃ�
	elseif targetDist >= NormalR_Dist then

		--�s���i�ߋ����j
		ouji_807001Battle_Near_Action(ai, goal)

	--�U�����͂������Ȃ�
	else
	
		--�s���i���ߋ����j
		ouji_807001Battle_TooNear_Action(ai, goal)
	
	end
end

---------------------------------------------------------
--  �s���i�������j
---------------------------------------------------------
function ouji_807001Battle_Middle_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local NormalR_Dist = 2.0					--�U���̓K���ԍ���

	--40% �������Ȃ�
	if fate <= 20 then
		goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_NONE, 0, 0, 0 );
	
	--60% ���񂵂ėl�q��
	elseif fate <= 80 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(3,5), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), ai:GetRandam_Int(0,1), true , 4 );
	
	--20% �����Đڋ�
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, 4 )
	end
	
end


---------------------------------------------------------
--  �s���i�ߋ����j
---------------------------------------------------------
function ouji_807001Battle_Near_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂R
local fate4 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@����4

local NormalR_Dist = 2.0					--�U���̓K���ԍ���

	--20% �������Ȃ�
	if fate <= 20 then
		goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_NONE, 0, 0, 0 );

	--60% ���񂵂ėl�q��
	elseif fate <= 80 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(3,5), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), ai:GetRandam_Int(0,1), true , 4 );
	
	--10% �����ċ߂Â�
	elseif fate <= 90 then
	
		--70% �K�[�h���Ȃ�
		if fate2 <= 70 then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 )
		
		--30% �K�[�h����
		else
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, 4 )
		end
		
	--10% �����ċ߂Â�
	else
	
		--40% �K�[�h���Ȃ�
		if fate3 <= 40 then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 )
		
		--70% �K�[�h����
		else
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, 4 )
		end
	end
	
	if fate <= 40 then
		--50% �U��
		ouji_807001Battle_Attack(ai, goal)
		ouji_807001Battle_Kougeki_Noato(ai, goal)
	else
		ouji_807001Battle_Kougeki_Noato(ai, goal)
	end
	
end

---------------------------------------------------------
--  �s���i���ߋ����j
---------------------------------------------------------
function ouji_807001Battle_TooNear_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���

	--20% �U��
	if fate <= 20 then
		ouji_807001Battle_Attack(ai, goal)
		ouji_807001Battle_Kougeki_Noato(ai, goal)
	else
		ouji_807001Battle_Kougeki_Noato(ai, goal)
	end

end



---------------------------------------------------------
--  �U���p�^�[���E�ʏ펞
---------------------------------------------------------
function ouji_807001Battle_Attack(ai, goal)

	ouji_807001Battle_NormalR_OneHand_Comb(ai, goal)

end
 

---------------------------------------------------------
--  �E��R���{�E�Ў�
---------------------------------------------------------
function ouji_807001Battle_NormalR_OneHand_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p

	--80% ��
	if NR_fate <= 80 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	
	--20% ���
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	
	end
end

	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function ouji_807001Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local KN_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local KN_fate3 = ai:GetRandam_Int(1,100)		--�m������p

local BackDist = ai:GetRandam_Int(3,6)			--��ނ��鋗��

	--50% �����\���Č�ށE����
	--50% �X�e�b�v�ړ��i�����Ȃ���j

	if KN_fate <= 50 then
	
		if KN_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(3,5), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), ai:GetRandam_Int(0,1), true , 4 );
		else
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(3,5), TARGET_ENE_0, BackDist, TARGET_ENE_0, ai:GetRandam_Int(0,1), 4 );
		end
		
	else
	
		if KN_fate3 <= 40 then
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepB, TARGET_SELF, 0, AI_DIR_TYPE_B, 4.0);
		elseif KN_fate3	<= 70 then
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepL, TARGET_SELF, 0, AI_DIR_TYPE_L, 4.0);
		else
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepR, TARGET_SELF, 0, AI_DIR_TYPE_R, 4.0);
		end			
	end
end




---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function ouji_807001Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function ouji_807001Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function ouji_807001Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���


	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Č��
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 2.0				--�R���{���ꂷ�鋗��
local combRunPer = 60				--�R���{���ꂷ��m��
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				if fate2 <= 40 then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepB, TARGET_SELF, 0, AI_DIR_TYPE_B, 4.0);
				elseif fate2 <= 70 then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepL, TARGET_SELF, 0, AI_DIR_TYPE_L, 4.0);
				else
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepR, TARGET_SELF, 0, AI_DIR_TYPE_R, 4.0);
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
				goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepL, TARGET_SELF, 0, AI_DIR_TYPE_L, 4.0);
			else
				goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepR, TARGET_SELF, 0, AI_DIR_TYPE_R, 4.0);
			end	
			return true
		end
	end

return false;
end

