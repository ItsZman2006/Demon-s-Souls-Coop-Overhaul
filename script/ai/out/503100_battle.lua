--[[*******************************************************************************************
	�q�G�C�p�퓬
	�����F�ÍԂR�{�X�̏��ɏo�Ă���q�G�C�B

	�p�����[�^0  �Ȃ�
	�p�����[�^1  �Ȃ�
	�p�����[�^2  �Ȃ�
	�p�����[�^3�@�Ȃ�
*********************************************************************************************]]
REGISTER_GOAL(GOAL_koei_503100_Battle, "koei_503100Battle");

REGISTER_GOAL_NO_UPDATE( GOAL_koei_503100_Battle, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_koei_503100_Battle, true);

--[[*****************************************************
	�S�[���N��
*******************************************************]]
function koei_503100Battle_Activate(ai, goal)

--[[���������ځ�]]

	--XZ���ʏ�ŁA����ȏ�߂��ꍇ�͍U�����Ȃ��B
	local NEAR_DMZ	= 5;

	--�^�[�Q�b�g���E�O����ˌ����Ă����m���B
	local UNVISIBLE_SHOOT_RATE	= 10;

--[[���������ځ�]]


	local hprate 		= ai:GetHpRate( TARGET_SELF )		--������HP�������擾
	local targetDist 	= ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
	local fate 			= ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
	local fate2 		= ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂Q
	local fate3 		= ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂R
	local role 			= ai:GetTeamOrder(ORDER_TYPE_Role);	--�����̖������擾

	--�^�[�Q�b�g�ɂƂ��āA���ʁH
	local isFrontForTarget	= ai:IsInsideTargetEx( TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, 1000);
	
	--�^�[�Q�b�g�Ƌ߂����H
	local tooNear = ai:GetDistXZ(TARGET_ENE_0) < NEAR_DMZ;
	
	--�^�[�Q�b�g�ɂƂ��Đ��ʂ���Ȃ����ǁA���m���ŁA�����Ă����B
	local isEnableUnvisibleShoot	= not(isFrontForTarget) and (ai:GetRandam_Int(1,100) < UNVISIBLE_SHOOT_RATE);
	
	
	if ( not(tooNear) ) then
		if ( isFrontForTarget or isEnableUnvisibleShoot) then
			koei_503100Battle_Kougeki(ai, goal)
		end
	end

		
--[[
	--�U�����Ȃ�U���B
	if ( role == ROLE_TYPE_Attack ) then
		koei_503100Battle_Kougeki(ai, goal)
	end
]]
	
	--���̃|�C���g�Ɉړ�
	koei_503100Battle_MoveToNextPoint(goal);
	if (fate <= 10) then koei_503100Battle_MoveToNextPoint(goal); end
	if (fate2<= 10) then koei_503100Battle_MoveToNextPoint(goal); end
	if (fate3<= 10) then koei_503100Battle_MoveToNextPoint(goal); end
end

---------------------------------------------------------
--  ���̃|�C���g�ֈړ��B
---------------------------------------------------------
function koei_503100Battle_MoveToNextPoint(goal)
	goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, POINT_MOVE_POINT, AI_DIR_TYPE_CENTER, 10.0, TARGET_SELF, true);
end

---------------------------------------------------------
--  �U��
---------------------------------------------------------
function koei_503100Battle_Kougeki(ai, goal)
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 20.0, TARGET_ENE_0, 20, AI_DIR_TYPE_ToB , true, -1 );
	goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3010, TARGET_ENE_0, DIST_None, 0);
end
	
--[[*****************************************************
	�X�V
*******************************************************]]
function koei_503100Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end

--[[*****************************************************
	�I���B
*******************************************************]]
function koei_503100Battle_Terminate(ai, goal)

	--���s���悤�������悤���A�����I�ɕʂ̃|�C���g�ցB
	ai:StepNextMovePoint();
	
end

--[[*****************************************************
	���荞�݁B
*******************************************************]]
function koei_503100Battle_Interupt(ai, goal)
	return false;
end


	