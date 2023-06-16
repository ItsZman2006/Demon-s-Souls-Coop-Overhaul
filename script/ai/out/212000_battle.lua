-----------------------------------------------------------------------------------------------
--	�e�l�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_kagebito212000_Battle, "kagebito212000_Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( kagebito212000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function kagebito212000_Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂R

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 1.8					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3002_Dist_min = 0.0					--3002�Ԃ̓K���ԍ����i�ŏ��j
local Att3002_Dist_max = 2.0					--3002�Ԃ̓K���ԍ����i�ő�j
local Att3003_Dist_min = 0.0					--3003�Ԃ̓K���ԍ����i�ŏ��j
local Att3003_Dist_max = 3.2					--3003�Ԃ̓K���ԍ����i�ő�j

local Act01Per = 70		--���s�ڋ߁��A���U��
local Act02Per = 10		--���s�ڋ߁�����ōU��
local Act03Per = 20		--���s�ڋ߁��ガ����	

	--�����Ȃǂɂ���čs����ς��Ȃ�
	
	--�s��01�@���s�ڋ߁��A���U��
	if fate2 <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, -1 );
		kagebito212000_Battle_Kougeki(ai, goal)
		kagebito212000_Battle_Kougeki_Noato(ai, goal)
		
	--�s��02�@���s�ڋ߁�����ōU��
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		kagebito212000_Battle_Kougeki_Noato(ai, goal)
		
	--�s��03�@���s�ڋ߁��ガ����
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		kagebito212000_Battle_Kougeki_Noato(ai, goal)
	end
	
end


---------------------------------------------------------
--  �U��
---------------------------------------------------------
function kagebito212000_Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--5% 3000
	--60% 3000-3001
	--35% 3000-3001-3002
	if K_fate <= 5 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif K_fate <= 65 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0); 
		
	end
end

	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function kagebito212000_Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

local SideTime = 3.0							--���ɓ�������
local BackDist = 2.0							--��ނ��鋗��
local BackTime = 3.0							--��ނ��鎞��

	
	--90���@��ċz
	--5���@�����������Ɉړ�
	--5���@��������������
	if KN_fate <= 90 then
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(1.0,3.0), TARGET_ENE_0, 0, 0, 0 );
		
	elseif KN_fate <= 95 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
		
	else
		goal:AddSubGoal(GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );
	end
end

	
	
---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function kagebito212000_Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function kagebito212000_Battle_Terminate(ai, goal)
end

---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function kagebito212000_Battle_Interupt(ai, goal)

	--�K�[�h���󂵂���U���@�����ʊ֐�
local guardBreakConutDist = 3.2			--�K�[�h����ōU�����鋗��
local guardBreakConutPer = 65			--�K�[�h����ōU������m��
	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
		goal:ClearSubGoal();
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		kagebito212000_Battle_Kougeki_Noato(ai, goal)
		return true;
	end	

	--��ѓ���ǂ�����
	--�^�[�Q�b�g����ѓ���𔭎˂�����A�܂�ɑ����ċ߂Â�
local farResDist	=5.0	--�������鋗��
local farResPer		=20		--��������m��
	if FarDamaged_Act(ai, goal, farResDist, farResPer ) then
		goal:ClearSubGoal();
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		return true;
	end	


return false;
end





			


	