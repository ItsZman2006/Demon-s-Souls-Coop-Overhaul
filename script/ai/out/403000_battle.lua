--[[*******************************************************************************************
	Tako403000��p�퓬
	�����F

	����ȏC�������F
		�����@08/8/6 hasem
	
	���p�����[�^
		�p�����[�^0  �Ȃ�
		�p�����[�^1  �Ȃ�
		�p�����[�^2  �Ȃ�
		�p�����[�^3�@�Ȃ�
		
	��ai:AddObserveArea()�̎g�p�󋵁B
		�O�F�������ɓ����Ă��������n���h�����O�B
		�P�F
		�Q�F
		�R�F
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Tako403000_Battle, "Tako403000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Tako403000_Battle, true);
--~ REGISTER_GOAL_NO_INTERUPT( GOAL_Tako403000_Battle, true);


--[[*****************************************************
	�S�[���N��
*******************************************************]]
function Tako403000Battle_Activate(ai, goal)

	local targetDist 	= ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋���
	local NEAR_RANGE	= ai:GetDistParam(DIST_Near);		--�G�N�Z���p�����[�^�i�ߋ����j
	local MIDDLE_RANGE	= ai:GetDistParam(DIST_Middle);		--�G�N�Z���p�����[�^�i�������j
	local FAR_RANGE		= ai:GetDistParam(DIST_Far);		--�G�N�Z���p�����[�^�i�������j
	local OUT_OF_RANGE	= ai:GetDistParam(DIST_Out);		--�G�N�Z���p�����[�^�i�͈͊O�j
	
	--�������ȉ��ň����|���Ă������Ď��̈���폜�B
	ai:DeleteObserveArea(0);
	
	--�s���I���B
	if 		( targetDist < NEAR_RANGE ) 	then	Tako403000Battle_Attack_Near(ai, goal);
	elseif	( targetDist < MIDDLE_RANGE ) 	then	Tako403000Battle_Attack_Middle(ai, goal);
	elseif	( targetDist < FAR_RANGE ) 		then	Tako403000Battle_Attack_Far(ai, goal);
	else											Tako403000Battle_Attack_OutOfRange(ai, goal);
	end
end

---------------------------------------------------------
--  �U���i�ߋ����j
---------------------------------------------------------
function Tako403000Battle_Attack_Near(ai, goal)

	--100% �������S�����B
	goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3001, TARGET_ENE_0, DIST_None, 0);
end

---------------------------------------------------------
--  �U���i�������j
---------------------------------------------------------
function Tako403000Battle_Attack_Middle(ai, goal)
	--�U������
	--�U����s��
	Tako403000Battle_Throw(ai, goal)
	Tako403000Battle_Throw_Noato(ai, goal)
end

---------------------------------------------------------
--  �U���i�������j
---------------------------------------------------------
function Tako403000Battle_Attack_Far(ai, goal)
	local fate 			= ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐���
	--60���@���������@ �ҋ@�@�@40���@�����L�[�v
	if fate < 60 then
		Tako403000Battle_MagicArrow(ai, goal);
	else
		goal:AddSubGoal(GOAL_COMMON_KeepDist, 2.0, TARGET_ENE_0, 4.0, 10.0, TARGET_ENE_0, true, -1 );
	end
	
	--���ԋ����N���Ď��B
	Tako403000Battle_ObserveMiddleRange(ai);
end

---------------------------------------------------------
--  �U���i�͈͊O�j
---------------------------------------------------------
function Tako403000Battle_Attack_OutOfRange(ai, goal)

	local fate 			= ai:GetRandam_Int(1,100);
	local fate2			= ai:GetRandam_Int(1,100);
	local MIDDLE_RANGE	= ai:GetDistParam(DIST_Middle);		--�G�N�Z���p�����[�^�i�������j
	
	--70���@���������@���ҋ@
	--20���@�����L�[�v��70���@���������@���ҋ@
	--10���@����ڋ�
	if (fate < 70) then
	
		Tako403000Battle_MagicArrow(ai, goal);
		
	elseif (fate < 90) then
	
		goal:AddSubGoal( GOAL_COMMON_KeepDist, 2.0, TARGET_ENE_0, 8.0, 12.0, TARGET_ENE_0, false, -1 );
		
		if (fate2 < 70) then
			Tako403000Battle_MagicArrow(ai, goal);
		end
		
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, MIDDLE_RANGE, TARGET_ENE_0, false, -1 );
	end
	
	--���ԋ����N���Ď��B
	Tako403000Battle_ObserveMiddleRange(ai);
end

---------------------------------------------------------
--  �}�W�b�N�A���[�U���B
---------------------------------------------------------
function Tako403000Battle_MagicArrow(ai, goal)
	goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3003, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_ENE_0);
end

---------------------------------------------------------
--  ������˓����R���{
---------------------------------------------------------
function Tako403000Battle_Throw(ai, goal)

--[[���������ځ�]]

	--�����ԍ���[m]
	local THROW_RANGE	= 0.5;
	
	--�O�X�e�b�v���S����
	local STEP_F_SAFTYRANGE	= 1;

--[[���������ځ�]]

	--������˓����R���{
	goal:AddSubGoal(GOAL_COMMON_Attack, 		5.0, 3000, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal(GOAL_Tako403000_ThrowComboApproach, 	8.0, THROW_RANGE);
	goal:AddSubGoal(GOAL_Tako403000_Throw, 		5.0);
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function Tako403000Battle_Throw_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local BackDist = ai:GetRandam_Float(2.0, 3.0)	--��ނ��鋗��
local BackTime = 6.0							--��ނ��鎞��
local SideTime = 6.0							--���ɓ�������

	--60% ���Ɉړ�
	--20% �Ȃɂ����Ȃ��i������Ƃ������ړ��j
	--20% �K���ɉ��Ɉړ�
	if KN_fate < 60 then
		goal:AddSubGoal(GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	elseif KN_fate < 80 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 6.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 10, true, true ,-1 );
	else
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
	end
end


---------------------------------------------------------
--  ���ԋ����Ď�
---------------------------------------------------------
function Tako403000Battle_ObserveMiddleRange(ai)
	local MIDDLE_RANGE	= ai:GetDistParam(DIST_Middle);		--�G�N�Z���p�����[�^�i�������j
	
	--���ԋ����ɓ����������Ď����āA���荞�܂���B
	ai:AddObserveArea( 0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 360, MIDDLE_RANGE);
end


--[[*****************************************************
	�X�V�E�I���Ȃ��B
*******************************************************]]
function Tako403000Battle_Update(ai, goal) return GOAL_RESULT_Continue; end
function Tako403000Battle_Terminate(ai, goal) end


--[[*****************************************************
	���荞��
*******************************************************]]
function Tako403000Battle_Interupt(ai, goal)

--[[���������ځ�]]

	--�^�[�Q�b�g��U�莞�U�����銄���B
	local ATTACK_RATE	= 25;

--[[���������ځ�]]

	local targetDist 	= ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
	local MIDDLE_RANGE	= ai:GetDistParam(DIST_Middle);		--�G�N�Z���p�����[�^�i�������j
	local fate 			= ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--��U��ǂ�����
	--25���@�߂��̃^�[�Q�b�g����U�肵����U��
	if (ai:IsInterupt( INTERUPT_MissSwing)) then
		if (targetDist < MIDDLE_RANGE) then
			if (fate <= ATTACK_RATE) then
				goal:ClearSubGoal();
				Tako403000Battle_Attack_Middle(ai, goal);
				return true;
			end	
		end
	end

	--�������ɓ����Ă����Ƃ��B
	if ( ai:IsInterupt(INTERUPT_Inside_ObserveArea) ) then
		if ( ai:IsInsideObserveArea(0) ) then
			--�Ď��̈���폜�B
			ai:DeleteObserveArea(0);
			--�������U�����o���B
			goal:ClearSubGoal();
			Tako403000Battle_Attack_Middle(ai, goal);
			return true;
		end
	end
	
	return false;

end





--[[****************************************************************************************************************]]
--[[************************************************ �T�u�S�[�� ****************************************************]]
--[[****************************************************************************************************************]]


--[[*******************************************************************************************
	Ⴢ�R���{���ڋ�
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Tako403000_ThrowComboApproach, "Tako403000TCA");
REGISTER_GOAL_NO_UPDATE( GOAL_Tako403000_ThrowComboApproach, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_Tako403000_ThrowComboApproach, true);

function Tako403000TCA_Activate(ai, goal)
	local THROW_RANGE	= goal:GetParam(0);
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 8.0, TARGET_ENE_0, THROW_RANGE, TARGET_ENE_0, false, -1 );
	
	--�A�j���؂�ւ��B
	ai:ChangeMoveAnimParam(1);
end

function Tako403000TCA_Terminate(ai, goal) 
	--�A�j���؂�ւ��B
	ai:ChangeMoveAnimParam(0);
end

function Tako403000TCA_Update(ai, goal) return GOAL_RESULT_Continue; end
function Tako403000TCA_Interupt(ai, goal) return false; end


--[[*******************************************************************************************
	Ⴢ�R���{������
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Tako403000_Throw, "Tako403000Throw");
REGISTER_GOAL_NO_UPDATE(GOAL_Tako403000_Throw, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_Tako403000_Throw, true);

function Tako403000Throw_Activate(ai, goal)

	--���т�Ă�����A����
	--���т�Ă��Ȃ���΁A���v�����j���O�B
	if ( ai:HasParalysis(TARGET_ENE_0) ) then
		goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3002, TARGET_ENE_0, DIST_None, 0);
	else
		ai:Replaning();
	end

end

function Tako403000Throw_Terminate(ai, goal) end
function Tako403000Throw_Update(ai, goal) return GOAL_RESULT_Continue; end
function Tako403000Throw_Interupt(ai, goal) return false; end






