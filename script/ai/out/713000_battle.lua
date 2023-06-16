-----------------------------------------------------------------------------------------------
--	�b�艮�i�B���j�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_kajiyaK_713000_Battle, "kajiyaK_713000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_kajiyaK_713000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function kajiyaK_713000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local playerDist = ai:GetDist(TARGET_LOCALPLAYER);		--���[�J���v���C���[�Ƃ̋������擾
local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q

local Kougeki_Dist = 0.8					--�U���̓K���ԍ���

	if fate <= 60 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Kougeki_Dist, TARGET_ENE_0, true, -1 );
		kajiyaK_713000Battle_Kougeki(ai, goal)
		kajiyaK_713000Battle_Kougeki_Noato(ai, goal)	

	else
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Kougeki_Dist, TARGET_ENE_0, false, -1 );
		kajiyaK_713000Battle_Kougeki(ai, goal)
		kajiyaK_713000Battle_Kougeki_Noato(ai, goal)	
	end
	
end


---------------------------------------------------------
--  �U��
---------------------------------------------------------
function kajiyaK_713000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)		--�m������p
local K_fate2 = ai:GetRandam_Int(1,100)		--�m������p

	--100% �����c�[
	
local tsuika_fate	= 60			--�ǉ��U��
local upper_fate	= 40			--�A�b�p�[
local R_straight	= 30			--30% �E�X�g���[�g
local BackhandBrow	= 30			--30% ����
		
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 3005, TARGET_ENE_0, DIST_Middle, 0);

	if K_fate <= tsuika_fate then
	
		if K_fate2 <= upper_fate then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	
		elseif K_fate2 <= (upper_fate + R_straight) then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		end
	end
	
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function kajiyaK_713000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local KN_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local BackDist = 3.0							--��ނ��鋗��


	--50���@�����҂�
	--15���@���Ɉړ�
	--35���@���Ɉړ�
	if KN_fate <= 50 then
		if KN_fate2 <= 40 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, 701, TARGET_ENE_0, DIST_None, 0);
		elseif KN_fate2 <= 70 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, 702, TARGET_ENE_0, DIST_None, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, 703, TARGET_ENE_0, DIST_None, 0);
		end
	elseif KN_fate <= 65 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end




---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function kajiyaK_713000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function kajiyaK_713000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function kajiyaK_713000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local NormalR_Dist = 0.8			--�E��U���̓K���ԍ���

	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Ĕ����E���
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--�R���{���ꂷ�鋗��
local combRunPer = 40				--�R���{���ꂷ��m��
local combRunCountPer = 15			--�R���{����̌�ɍU������m��	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, 701, TARGET_ENE_0, DIST_None, 0);
				return true;
			end
		end
	end	
	
	--���ߋ����ōU�����ꂻ���ɂȂ����璴�����X�e�b�v
	if ai:IsInterupt( INTERUPT_FindAttack ) then
local superStepDist = 2.0			--���������鋗��
local superStepPer = 50				--����������m��	
		if targetDist <= superStepDist then
			if fate <= superStepPer then
			--�����
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, 701, TARGET_ENE_0, DIST_None, 0);
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
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, 702, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, 703, TARGET_ENE_0, DIST_None, 0);
			end
			return true;
		end
	end	
	
	
	
return false;
end
