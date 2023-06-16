-----------------------------------------------------------------------------------------------
--	AI�Ŏg�p���鋤��LUA�֐����L�q���܂��B
--	�T�u�S�[���ɂ���قǂł��Ȃ��֗��֐��Ȃǂ����Ă��������B
--	�L�����ŗL�̂��̂͂����ɂ͊܂߂Ȃ��ł��������B
-----------------------------------------------------------------------------------------------

--[[*******************************************************************************************
	@attention 	AI�S��PG�ȊO�͐G��Ȃ��悤�ɁI
	@brief		�v���O�����������S�[���o�^�B
*********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_Wait, 			"Wait");
REGISTER_GOAL(GOAL_COMMON_Stay, 			"Stay");
REGISTER_GOAL(GOAL_COMMON_MoveToSomewhere, 	"MoveToSomewhere");
REGISTER_GOAL(GOAL_COMMON_Guard, 			"Guard");
REGISTER_GOAL(GOAL_COMMON_Attack, 			"Attack");
REGISTER_GOAL(GOAL_COMMON_ComboAttack, 		"ComboAttack");
REGISTER_GOAL(GOAL_COMMON_SidewayMove, 		"SidewayMove");
REGISTER_GOAL(GOAL_COMMON_KeepDist, 		"KeepDist");
REGISTER_GOAL(GOAL_COMMON_BackToHome, 		"BackToHome");
REGISTER_GOAL(GOAL_COMMON_GuardBreakAttack, "GuardBreakAttack");
REGISTER_GOAL(GOAL_COMMON_SpinStep, 		"SpinStep");
REGISTER_GOAL(GOAL_COMMON_LeaveTarget, 		"LeaveTarget");
REGISTER_GOAL(GOAL_COMMON_ApproachStep,		"ApproachStep");
REGISTER_GOAL(GOAL_COMMON_Parry,			"Parry");


--[[*******************************************************************************************
	@attention 	AI�S��PG�ȊO�͐G��Ȃ��悤�ɁI

	@brief	��퓬���g�b�v�S�[���ݒ�F�^�[�Q�b�g�֌���
	@param	ai						ai�v�l
*********************************************************************************************]]
function _COMMON_SetNBGoal_TurnToTarget(ai, life_time)
	ai:AddTopGoal( GOAL_COMMON_Stay, life_time, 0, TARGET_ENE_0);
end


--[[*******************************************************************************************
	@attention 	AI�S��PG�ȊO�͐G��Ȃ��悤�ɁI

	@brief	��퓬���g�b�v�S�[���ݒ�F�^�[�Q�b�g�֕���
	@param	ai						ai�v�l
*********************************************************************************************]]
function _COMMON_SetNBGoal_WalkToTarget(ai, life_time)
	
	local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
	if( targetDist > 2.0 ) then
		ai:AddTopGoal( GOAL_COMMON_MoveToSomewhere, life_time, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 1.5, TARGET_ENE_0, true);
	else
		-- �߂Â����̂Ō��邾��
		ai:AddTopGoal( GOAL_COMMON_Stay, life_time, 0, TARGET_ENE_0);
	end
end


--[[*******************************************************************************************
	@attention 	AI�S��PG�ȊO�͐G��Ȃ��悤�ɁI

	@brief	��퓬���g�b�v�S�[���ݒ�F�^�[�Q�b�g�֑���B
	@param	ai						ai�v�l
*********************************************************************************************]]
function _COMMON_SetNBGoal_RunToTarget(ai, life_time)
	local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
	if( targetDist > 2.0 ) then
		ai:AddTopGoal( GOAL_COMMON_MoveToSomewhere, life_time, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 1.5, TARGET_ENE_0, false);
	else
		-- �߂Â����̂Ō��邾��
		ai:AddTopGoal( GOAL_COMMON_Stay, life_time, 0, TARGET_ENE_0);
	end
end


--[[*******************************************************************************************
	@attention 	AI�S��PG�ȊO�͐G��Ȃ��悤�ɁI

	@brief	��퓬���g�b�v�S�[���ݒ�F�w��S�[���ݒ�B
	@param	ai						ai�v�l
*********************************************************************************************]]
function _COMMON_SetNBGoal_SetUserGoal(ai, life_time)
	
	local idGoal = ai:GetReplanningGoalID();
	ai:AddTopGoal( idGoal, life_time);
end


--[[*******************************************************************************************
	@attention 	AI�S��PG�ȊO�͐G��Ȃ��悤�ɁI

	@brief	��퓬���g�b�v�S�[���ݒ�@ver2
	@param	ai						ai�v�l
	@param	life_time				�S�[�����ԁB
*********************************************************************************************]]
function _COMMON_AddCautionAndFindGoal(ai, life_time)

	local idAction = ai:GetReplanningGoalAction();
	
	if    (idAction==NPC_THINK_GOAL_ACTION__TURN_TO_TGT) then
		_COMMON_SetNBGoal_TurnToTarget(ai, life_time);
	elseif(idAction==NPC_THINK_GOAL_ACTION__WALK_TO_TGT) then
		_COMMON_SetNBGoal_WalkToTarget(ai, life_time);
	elseif(idAction==NPC_THINK_GOAL_ACTION__RUN_TO_TGT) then
		_COMMON_SetNBGoal_RunToTarget(ai, life_time);
	elseif(idAction==NPC_THINK_GOAL_ACTION__SET_GOAL) then
		_COMMON_SetNBGoal_SetUserGoal(ai, life_time);
	else
		-- NPC_THINK_GOAL_ACTION__NONE�A���̑��̃P�[�X�B
		--�������Ȃ��B
		if( ai:HasTopSubgoal() ~= true ) then
			-- �T�u�S�[�����Ȃɂ��Ȃ������̂Ŕ�퓬�s�������Ă���
			_COMMON_AddNonBattleGoal(ai, -1.0, -1.0, true, false, 0.0);
		end
	end

end


--[[*******************************************************************************************
	@attention 	AI�S��PG�ȊO�͐G��Ȃ��悤�ɁI

	@brief	��퓬�S�[����ݒ�B
	
	@param	ai						ai�v�l
	@param	life					����
	@param	search_dist				�G�ɔ������鋗���B
	@param	isFoundTarget			�G��F�����Ă��邩�H
	@param	runNonBattle			��퓬�����邩�H
*********************************************************************************************]]
function _COMMON_AddNonBattleGoal(ai, life, search_dist, isFoundTarget, runNonBattle, nonBattleBackhomeDist)

	ai:AddTopGoal( GOAL_COMMON_NonBattleAct, life, search_dist, false, runNonBattle, POINT_INIT_POSE, nonBattleBackhomeDist);
end


--[[*******************************************************************************************
	@attention 	AI�S��PG�ȊO�͐G��Ȃ��悤�ɁI

	@brief	�퓬�S�[����ǉ����܂��Bver3
	
	@param	ai					ai�v�l
	@param	battleGoalId		�퓬�S�[��ID
*********************************************************************************************]]
function _COMMON_AddBattleGoal3(ai, battleGoalId)
	if ( ai:IsBattleState()) then
	
		-- �퓬�������B
		ai:AddTopGoal( battleGoalId, -1);
		
	else
	
		-- �x���E������ԁB
		_COMMON_AddCautionAndFindGoal(ai, -1);
		
	end
end


--[[*******************************************************************************************
	@attention 	AI�S��PG�ȊO�͐G��Ȃ��悤�ɁI

	�퓬���邩�ǂ����������ɂ���Ĕ��ʂ���
	���W�b�N����Ă΂�邱�Ƃ�z�肵�Ă��܂��B
	ai					ai�v�l
	funcBattle			�퓬�S�[���ǉ�lua�֐��B
	funcNonBattle		��퓬�S�[���ǉ�lua�֐��B
 	maxBackhomeDist		���������Ă��A��鋗��
 	backhomeDist		�퓬���A��鋗��
 	backhomeBattleDist	�G���߂Â��Ă�����퓬���鋗��
	nonBattleActLife	�G���ӎ����Ă���Ƃ��̔�퓬�s������

	return				�Ȃ�炩�̃S�[����ݒ肵����
*********************************************************************************************]]
function _COMMON_SetBattleActLogic(ai, funcBattle, funcNonBattle, maxBackhomeDist, backhomeDist, backhomeBattleDist, nonBattleActLife)

	-- �|�C���g����̉e���͈�
	local pointDist = ai:GetMovePointEffectRange();
	-- �^�[�Q�b�g�����邩
	local isFindTarget = ai:IsSearchTarget(TARGET_ENE_0);

	if isFindTarget == false then
		-- �^�[�Q�b�g�Ȃ��@
		-- ��퓬�s���@�G�݂����炷���ɏI��
		funcNonBattle( -1, -1, true);
		return true;
	else
		-- �^�[�Q�b�g�܂ł̋���
		local targetDist = ai:GetDist(TARGET_ENE_0);

		-- �^�[�Q�b�g����
		-- ���������Ă��A��鋗�����O������
		if  pointDist > maxBackhomeDist then
			
			-- �ⓚ���p�ŏ���
			funcNonBattle( nonBattleActLife, -1, false);
			return true;
			
		-- �퓬���A��鋗�����O������
		elseif pointDist > backhomeDist then
	
			-- �G�����Ȃ���΋A���
			if (targetDist < backhomeBattleDist) then
				-- �G�����ɂ���ΐ퓬
				funcBattle();
				return true;
			else
				-- �G���C�ɂ��Ȃ���A��
				funcNonBattle( nonBattleActLife, backhomeBattleDist, false);
				return true;
			end
			
		-- �퓬���A��鋗������������	
		else
			-- �G���Œ�A��͈͓��ɂ���ΐ키
			if (targetDist < backhomeDist) then
				-- �G�����ɂ���ΐ퓬
				funcBattle();
				return true;
			else
				-- �ҋ@
				funcNonBattle( nonBattleActLife, backhomeDist, false);
				return true;
			end
			
		end;
	end
	
	return false;
end

--[[*******************************************************************************************
	@brief	�ȒP�ݒ�ver3
	
	@param	ai					ai�v�l
	@return	�Ȃ�
	
	@param	[����]
			XXXX_logic.lua��XXXX_Logic()�ŌĂяo���܂��B
			�]����COMMON_SetBattleActLogic()�̊e��p�����[�^���G�N�Z���̒l������悤�ɂ��A
			logic.lua���g���܂킵�₷���`�ɂ���Ƃ����R���Z�v�g�Ɋ�Â��Ă��܂��B
			
	@param	[ver3]
			�^�[�Q�b�g��Ԃ��ύX�����Ƃ��̃S�[���̋������G�N�Z���ɐݒ肵�Ă�����̂�K�p����B
			
	@param	[�T���v��]
			function XXXX_Logic( ai )
				COMMON_EasySetup3( ai);
			end
			
*********************************************************************************************]]
function COMMON_EasySetup3( ai)
	_COMMON_EasySetup3(ai, false, 0);
end
function COMMON_EasySetup3_SetRunNonBattle( ai, isRunNonBattle)
	_COMMON_EasySetup3(ai, isRunNonBattle, 0);
end
function HEROINE_EasySetup3( ai)
	_COMMON_EasySetup3(ai, false, 999);
end
function _COMMON_EasySetup3( ai, isRunNonBattle, nonBattleBackhomeDist)

	local maxBackhomeDist 		= ai:GetExcelParam( AI_EXCEL_THINK_PARAM_TYPE__maxBackhomeDist);
	local backhomeDist 			= ai:GetExcelParam( AI_EXCEL_THINK_PARAM_TYPE__backhomeDist);
	local backhomeBattleDist 	= ai:GetExcelParam( AI_EXCEL_THINK_PARAM_TYPE__backhomeBattleDist);
	local nonBattleActLife 		= ai:GetExcelParam( AI_EXCEL_THINK_PARAM_TYPE__nonBattleActLife);
	local battleGoalId			= ai:GetExcelParam( AI_EXCEL_THINK_PARAM_TYPE__battleGoalID);

	--�����ݒ�B
	local bSet = _COMMON_SetBattleActLogic(
						ai, 
						function () _COMMON_AddBattleGoal3( ai, battleGoalId) end, 
						function (life, search_dist, isFoundTarget) _COMMON_AddNonBattleGoal(ai, life, search_dist, isFoundTarget, isRunNonBattle, nonBattleBackhomeDist) end,
						maxBackhomeDist, backhomeDist, backhomeBattleDist, nonBattleActLife);

	if bSet == false then
		-- �����S�[�����ݒ肳��Ȃ������̂Ŕ�퓬�s�������Ă���
		ai:AddTopGoal( GOAL_COMMON_NonBattleAct, -1.0, -1.0, true, 0, 0);
	end
end

