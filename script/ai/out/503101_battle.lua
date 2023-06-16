--[[*******************************************************************************************
	�q�G�C�p�퓬
	�����F
		�P�ƍs���p�B
	
	�����F
	�E�쐬	08/7/28	hasem

	�p�����[�^0  �Ȃ�
	�p�����[�^1  �Ȃ�
	�p�����[�^2  �Ȃ�
	�p�����[�^3�@�Ȃ�
*********************************************************************************************]]
REGISTER_GOAL(GOAL_koei_503101_Battle, "koei_503101Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_koei_503101_Battle, 1 );


--[[*****************************************************
	�S�[���N��
*******************************************************]]
function koei_503101Battle_Activate(ai, goal)
	
	local hprate 	= ai:GetHpRate( TARGET_SELF )		--������HP�������擾
	local fate 		= ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
	local fate2 	= ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂Q
	local fate3 	= ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂R
	local role 		= ai:GetTeamOrder(ORDER_TYPE_Role);	--�����̖������擾

	--�U�����Ȃ�U���B
	if ( koei_503101Battle_IsEnableAttack(ai)) then
		if ( role == ROLE_TYPE_Attack ) then
			if (ai:IsLookToTarget()) then
				koei_503101Battle_Kougeki(ai, goal)
			end
		end
	end
	
	--���̃|�C���g�Ɉړ�
	koei_503101Battle_MoveToNext(goal);
	if (fate  <= 10) then	koei_503101Battle_MoveToNext(goal);	end
	if (fate2 <= 10) then	koei_503101Battle_MoveToNext(goal);	end
	if (fate3 <= 10) then	koei_503101Battle_MoveToNext(goal);	end

end

---------------------------------------------------------
--  �U�����Ă����ʒu�ɂ��邩�H
---------------------------------------------------------
function koei_503101Battle_IsEnableAttack(ai)
	local idParam 	= ai:GetNpcThinkParamID();
	local idRegion	= -1;
	if 		(idParam==503101) then	idRegion = 2430;
	elseif	(idParam==503102) then	idRegion = 2431;
	elseif	(idParam==503103) then	idRegion = 2432;
	elseif	(idParam==503104) then	idRegion = 2433;
	end
	
	return ai:IsInsideTargetRegion(TARGET_ENE_0, idRegion);
end

---------------------------------------------------------
--  �U��
---------------------------------------------------------
function koei_503101Battle_Kougeki(ai, goal)

	koei_503101Battle_OneAttack(goal);

end

---------------------------------------------------------
--  ���̍U���B
---------------------------------------------------------
function koei_503101Battle_OneAttack(goal)
--~ 	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 20.0, TARGET_ENE_0, 20, AI_DIR_TYPE_ToB , true, -1 );
--~ 	goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0, 3010, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3010, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal(GOAL_COMMON_SpecialTurn, 10.0, 3020, POINT_MOVE_POINT, 90);
--	goal:AddSubGoal( GOAL_COMMON_Turn,	10.0, POINT_MOVE_POINT, 0, 0, 0 );		--�����߂���

end

---------------------------------------------------------
--  ���̈ʒu�ցB
---------------------------------------------------------
function koei_503101Battle_MoveToNext(goal)
	goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, POINT_MOVE_POINT, AI_DIR_TYPE_CENTER, 10.0, TARGET_SELF, true);
end

	
--[[*****************************************************
	�S�[���X�V�͂Ȃ��B
*******************************************************]]
function koei_503101Battle_Update(ai, goal)	return GOAL_RESULT_Continue; end

--[[*****************************************************
	�S�[���I���B
*******************************************************]]
function koei_503101Battle_Terminate(ai, goal)
end

--[[*****************************************************
	���荞��
*******************************************************]]
function koei_503101Battle_Interupt(ai, goal)
	-- �퓬�̈旣�E���荞��
	if (ai:IsInterupt( INTERUPT_LeaveBattleArea )) then
		-- �U�����悤�Ƃ��Ă��邾���Ď��s
		if (not(goal:GetNumber(0) == 0)) then
			goal:ClearSubGoal();
			koei_503101Battle_MoveToNext(goal);
			return true;
		end
	end

	return false;
end







	