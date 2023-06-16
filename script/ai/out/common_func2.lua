-----------------------------------------------------------------------------------------------
--	AI�Ŏg�p���鋤��LUA�֐����L�q���܂��B
--	�T�u�S�[���ɂ���قǂł��Ȃ��֗��֐��Ȃǂ����Ă��������B
--	�L�����ŗL�̂��̂͂����ɂ͊܂߂Ȃ��ł��������B
-----------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------

--[[
--����NPC�p���b�v�֐��Q����
--
--]]

--[[**************************************************************************
	����啐��ɐ؂�ւ��B
****************************************************************************]]
function CommonNPC_ChangeWepL1(ai, goal)
	local wep = ai:GetEquipWeaponIndex( ARM_L);
	if ( WEP_Primary ~= wep ) then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_ChangeWep_L1, TARGET_NONE, DIST_None);
	end
end

--[[**************************************************************************
	�E��啐��ɐ؂�ւ��B
****************************************************************************]]
function CommonNPC_ChangeWepR1(ai, goal)
	local wep = ai:GetEquipWeaponIndex( ARM_R);
	if ( WEP_Primary ~= wep ) then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_ChangeWep_R1, TARGET_NONE, DIST_None);
	end
end

--[[**************************************************************************
	����T�u����ɐ؂�ւ��B
****************************************************************************]]
function CommonNPC_ChangeWepL2(ai, goal)
	local wep = ai:GetEquipWeaponIndex( ARM_L);
	if ( WEP_Secondary ~= wep ) then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_ChangeWep_L2, TARGET_NONE, DIST_None);
	end
end

--[[**************************************************************************
	�E��T�u����ɐ؂�ւ��B
****************************************************************************]]
function CommonNPC_ChangeWepR2(ai, goal)
	local wep = ai:GetEquipWeaponIndex( ARM_R);
	if ( WEP_Secondary ~= wep ) then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_ChangeWep_R2, TARGET_NONE, DIST_None);
	end
end


--[[**************************************************************************
	���헼��������[�h�ɕύX�B
****************************************************************************]]
function CommonNPC_SwitchBothHandMode(ai, goal)
	if ( not( ai:IsBothHandMode(TARGET_SELF) ) ) then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_SwitchWep, TARGET_NONE, DIST_None);
	end
end

--[[**************************************************************************
	����Ў�������[�h�ɕύX�B
****************************************************************************]]
function CommonNPC_SwitchOneHandMode(ai, goal)
	if ( ai:IsBothHandMode(TARGET_SELF) ) then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_SwitchWep, TARGET_NONE, DIST_None);
	end
end




--[[
--������̓I�ȍs���𖾋L����V���[�Y�i����y�ɂЂƂ܂Ƃ߂̍s��������j����
--
--]]

--���_���[�W�󂯂���X�e�b�v���Ĕ����E�m�o�b�p
--�R���{����ȂǂɎg�p���܂�
function Damaged_StepCount_NPCPlayer(ai, goal, combRunDist, combRunPer, combRunCountPer, countAct, bkStepPer, leftStepPer, rightStepPer )

--��������--
--combRunDist			--�R���{���ꂷ�鋗��
--combRunPer			--�R���{���ꂷ��m��
--combRunCountPer		--�R���{����̌�ɔ�������m��
--countAct				--�����̎��ID
--bkStepPer				--�o�b�N�X�e�b�v�m��
--leftStepPer			--���X�e�b�v�m��
--rightStepPer			--�E�X�e�b�v�m��	

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p

	--�������Ń_���[�W�󂯂���X�e�b�v
	--�X�e�b�v��ɔ���
	if ai:IsInterupt( INTERUPT_Damaged ) then
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				if fate2 <= bkStepPer then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
				elseif fate2 <= (bkStepPer + leftStepPer ) then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
				else
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
				end	
				
				if fate3 <= combRunCountPer then
					goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, countAct, TARGET_ENE_0, DIST_Middle, 0);
				end
				return true;
			end
		end
	end	
end


--����苗�����œG���U��������X�e�b�v�E�m�o�b�p
--����������ȂǂɎg�p���܂�
function FindAttack_Step_NPCPlayer(ai, goal, superStepDist, superStepPer, bkStepPer, leftStepPer, rightStepPer )

--��������--
--superStepDist			--�������鋗��
--superStepPer			--��������m��	
--bkStepPer				--�o�b�N�X�e�b�v�m��
--leftStepPer			--���X�e�b�v�m��
--rightStepPer			--�E�X�e�b�v�m��

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p

	--�������œG���U��������X�e�b�v
	if ai:IsInterupt( INTERUPT_FindAttack ) then
		if targetDist <= superStepDist then
			if fate <= superStepPer then
			--�����
				if fate2 <= bkStepPer then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
				elseif fate2 <= (bkStepPer + leftStepPer ) then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
				else
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
				end
				return true;
			end
		end
	end
end


--���_���[�W�󂯂���X�e�b�v���Ĕ����E�G�p
--�R���{����ȂǂɎg�p���܂�
function Damaged_StepCount(ai, goal, combRunDist, combRunPer, combRunCountPer, countAct, bkStepPer, leftStepPer, rightStepPer )

--��������--
--combRunDist			--�R���{���ꂷ�鋗��
--combRunPer			--�R���{���ꂷ��m��
--combRunCountPer		--�R���{����̌�ɔ�������m��
--countAct				--�����̎��ID
--bkStepPer				--�o�b�N�X�e�b�v�m��
--leftStepPer			--���X�e�b�v�m��
--rightStepPer			--�E�X�e�b�v�m��	

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p

	--�������Ń_���[�W�󂯂���X�e�b�v
	--�X�e�b�v��ɔ���
	if ai:IsInterupt( INTERUPT_Damaged ) then
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				if fate2 <= bkStepPer then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 701, TARGET_ENE_0, 0);
				elseif fate2 <= (bkStepPer + leftStepPer ) then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 702, TARGET_ENE_0, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 703, TARGET_ENE_0, 0);
				end	
				
				if fate3 <= combRunCountPer then
					goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, countAct, TARGET_ENE_0, DIST_Middle, 0);
				end
				return true;
			end
		end
	end	
end


--����苗�����œG���U��������X�e�b�v�E�G�p
--����������ȂǂɎg�p���܂�
function FindAttack_Step(ai, goal, superStepDist, superStepPer, bkStepPer, leftStepPer, rightStepPer )

--��������--
--superStepDist			--�������鋗��
--superStepPer			--��������m��	
--bkStepPer				--�o�b�N�X�e�b�v�m��
--leftStepPer			--���X�e�b�v�m��
--rightStepPer			--�E�X�e�b�v�m��

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p

	--�������œG���U��������X�e�b�v
	if ai:IsInterupt( INTERUPT_FindAttack ) then
		if targetDist <= superStepDist then
			if fate <= superStepPer then
				goal:ClearSubGoal();
				--�����
				if fate2 <= bkStepPer then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 701, TARGET_ENE_0, 0);
				elseif fate2 <= (bkStepPer + leftStepPer ) then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 702, TARGET_ENE_0, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 703, TARGET_ENE_0, 0);
				end	
				return true;
			end
		end
	end
end


--����苗�����œG���U��������X�e�b�v�E�G�p�i���S�m�F����Łj
--����������ȂǂɎg�p���܂�
function FindAttack_SafetyStep(ai, goal, superStepDist, superStepPer, bkStepPer, leftStepPer, rightStepPer, safetyDist )

--��������--
--superStepDist			--�������鋗��
--superStepPer			--��������m��	
--bkStepPer				--�o�b�N�X�e�b�v�m��
--leftStepPer			--���X�e�b�v�m��
--rightStepPer			--�E�X�e�b�v�m��
--safetyDist			--���S�m�F����

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p

	--�������œG���U��������X�e�b�v
	if ai:IsInterupt( INTERUPT_FindAttack ) then
		if targetDist <= superStepDist then
			if fate <= superStepPer then
				goal:ClearSubGoal();
				--�����
				if fate2 <= bkStepPer then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 701, TARGET_ENE_0, 0.0, AI_DIR_TYPE_B, safetyDist);
				elseif fate2 <= (bkStepPer + leftStepPer ) then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 702, TARGET_ENE_0, 0.0, AI_DIR_TYPE_L, safetyDist);
				else
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 703, TARGET_ENE_0, 0.0, AI_DIR_TYPE_R, safetyDist);
				end	
				return true;
			end
		end
	end
end



--[[
--������̓I�ȍs���͖��L���Ȃ��V���[�Y�i�s���Ɋւ�炸�ėp�I�Ɏg����j����
--
--]]

-----------------------------------------------------------------------------------------------
--����苗�����Ń_���[�W�󂯂�
--�R���{����ȂǂɎg�p���܂�
function Damaged_Act(ai, goal, combRunDist, combRunPer )

--��������--
--combRunDist			--�R���{���ꂷ�鋗��
--combRunPer			--�R���{���ꂷ��m��

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)					--�m������p

	--�������Ń_���[�W�󂯂���true��Ԃ�
	if ai:IsInterupt( INTERUPT_Damaged ) then
		if targetDist < combRunDist then
			if fate <= combRunPer then
				return true;
			end
		end
	end

return false;
end


--����苗���O�Ń_���[�W�󂯂�
--�������猂����ċ}�ڋ߂���ꍇ�ȂǂɎg�p���܂�
function FarDamaged_Act(ai, goal, farResDist, farResPer )

--��������--
--farResDist		--�������鋗��
--farResPer			--��������m��

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)					--�m������p

	--�������Ń_���[�W�󂯂���true��Ԃ�
	if ai:IsInterupt( INTERUPT_Damaged ) then
		if targetDist >= farResDist then
			if fate <= farResPer then
				return true;
			end
		end
	end

return false;
end



-----------------------------------------------------------------------------------------------
--����苗�����œG����U�肵��
--��U��̌���˂��čU������ꍇ�ȂǂɎg�p���܂�
function MissSwing_Act(ai, goal, missSwingDist, missSwingAttPer )

--��������
--missSwingDist			--��U��ǌ����鋗��
--missSwingAttPer		--��U��ǌ�����m��

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)					--�m������p

	--�������ŋ�U�肵����true��Ԃ�
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist <= missSwingDist then
			if fate <= missSwingAttPer then
				return true;
			end
		end	
	end

return false;
end


-----------------------------------------------------------------------------------------------
--����苗�����œG���U������
--�U�������΂₭�K�[�h����ꍇ�ȂǂɎg�p���܂�
function FindAttack_Act(ai, goal, superStepDist, superStepPer )

--��������
--superStepDist			--�������鋗��
--superStepPer			--��������m��

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)					--�m������p

	--��苗�����œG���U������
	if ai:IsInterupt( INTERUPT_FindAttack ) then
		if targetDist <= superStepDist then
			if fate <= superStepPer then
				return true;
			end
		end
	end

return false;
end	


-----------------------------------------------------------------------------------------------
--����苗�����œG���K�[�h����ɂȂ���
--�K�[�h����ɂȂ����G��ǌ�����ꍇ�ȂǂɎg�p���܂�
function FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer )

--��������
--guardBreakConutDist		--�K�[�h����ōU�����鋗��
--guardBreakConutPer		--�K�[�h����ōU������m��

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)					--�m������p

	--��苗�����œG���K�[�h����ɂȂ���
	if ai:IsInterupt( INTERUPT_GuardBreak ) then
		if targetDist <= guardBreakConutDist then
			if fate <= guardBreakConutPer then
				return true;
			end
		end
	end

return false;
end	

-----------------------------------------------------------------------------------------------
--����苗�����œG���K�[�h���~�߂�
--�K�[�h���~�߂��炷�������U������ꍇ�ȂǂɎg�p���܂�
function FindGuardFinish_Act(ai, goal, guardFinishConutDist, guardFinishConutPer )

--��������
--guardFinishConutDist		--�K�[�h�I���ōU�����鋗��
--guardFinishConutPer		--�K�[�h�I���ōU������m��

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)					--�m������p

	--��苗�����œG���K�[�h����ɂȂ���
	if ai:IsInterupt( INTERUPT_GuardFinish ) then
		if targetDist <= guardFinishConutDist then
			if fate <= guardFinishConutPer then
				return true;
			end
		end
	end

return false;
end	

-----------------------------------------------------------------------------------------------
--���G����ѓ����������
--��ѓ���ɂ�鉓�����U���ւ̑Ώ��Ɏg�p���܂�
function FindShoot_Act(ai, goal, ShootActPer, ShootActPer2, ShootActPer3, ShootActDist, ShootActDist2, ShootActDist3)

--��������
--ShootActPer		--��������m���i�߁j
--ShootActPer2		--��������m���i���j
--ShootActPer3		--��������m���i���j
--ShootActDist		--�������鋗���i�߁j
--ShootActDist2		--�������鋗���i���j
--ShootActDist3		--�������鋗���i���j

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)					--�m������p

	--�^�[�Q�b�g����ѓ����������
	if ai:IsInterupt( INTERUPT_Shoot ) then
		--�ߋ����̒��I�ɓ���������01��Ԃ�
		if targetDist <= ShootActDist and fate <= ShootActPer then
			return 1;
			
		--�������̒��I�ɓ���������02��Ԃ�
		elseif targetDist <= ShootActDist2 and fate <= ShootActPer2 then	
			return 2;
			
		--�������̒��I�ɓ���������03��Ԃ�
		elseif targetDist <= ShootActDist3 and fate <= ShootActPer3 then	 
			return 3;
			
		--�ǂ�ɂ�������Ȃ�������00��Ԃ�
		else
			return 0;
			
		end
	end
	
return 0;
end	






--[[*******************************************************************************************
	@attention 	AI�S��PG�ȊO�͐G��Ȃ��悤�ɁI

	@brief	�E���R�p�퓬�S�[���ǉ��֐��B
	
	@note	GetNumber(2)���O�łȂ��ƁA�퓬�Ɉڍs���Ȃ��B
	
	@param	ai					ai�v�l
	@param	battleGoalId		�퓬�S�[��ID
	@param	goal_wait_id		�ҋ@���S�[���ݒ�Lua�֐��B
*********************************************************************************************]]
function _UROKO_AddBattleGoal2(ai, battleGoalId, funcNonBattelAct)

	if ( ai:IsBattleState()) then
	
		-- �퓬�������B
		ai:AddTopGoal( battleGoalId, -1);
		
	else
	
		--�ړ����Ȃ����A��������Ȃ��B
		funcNonBattelAct();
		
	end
end


--[[*******************************************************************************************
	@attention 	AI�S��PG�ȊO�͐G��Ȃ��悤�ɁI

	@brief	�E���R��퓬�S�[���B
	
	@param	ai						ai�v�l
	@param	goal_wait_id			�ҋ@���S�[��ID
*********************************************************************************************]]
function _UROKO_NonBattleAct(ai, goal_wait_id)

	local life				= -1;
	local search_dist		= -1;
	local isFoundTarget		= false;
	local runNonBattle		= false;


	ai:AddTopGoal( GOAL_COMMON_NonBattleAct, life, search_dist, false, runNonBattle, TARGET_NONE, 0.5, goal_wait_id);
	if ( not(ai:IsLookToTarget( POINT_INIT_POSE, 5)) ) then
		ai:AddTopGoal( GOAL_COMMON_Turn, life, POINT_INIT_POSE);
	end
end


--[[*******************************************************************************************
	@brief	�ȒP�E���R�R�v�ݒ�B
	@note	�퓬�S�[���ɂȂ�܂ŁA�ǂ�ȏ�Ԃł����񂵂Ȃ��ŁA�ҋ@�B

	@param	goal_wait_id			�ҋ@���S�[��ID
	@param	funcCautionAndFind		�x���E������Lua�֐��B�i�������Ȃ��Ăяo���B�j
*********************************************************************************************]]
function _UROKO_EasySetup( ai, goal_wait_id, funcCautionAndFind)

	local maxBackhomeDist 		= ai:GetExcelParam( AI_EXCEL_THINK_PARAM_TYPE__maxBackhomeDist);
	local backhomeDist 			= ai:GetExcelParam( AI_EXCEL_THINK_PARAM_TYPE__backhomeDist);
	local backhomeBattleDist 	= ai:GetExcelParam( AI_EXCEL_THINK_PARAM_TYPE__backhomeBattleDist);
	local nonBattleActLife 		= ai:GetExcelParam( AI_EXCEL_THINK_PARAM_TYPE__nonBattleActLife);
	local battleGoalId			= ai:GetExcelParam( AI_EXCEL_THINK_PARAM_TYPE__battleGoalID);

	--�����ݒ�B
	local bSet = _COMMON_SetBattleActLogic(
						ai, 
						function () _UROKO_AddBattleGoal2( ai, battleGoalId, funcCautionAndFind) end, 
						function (life, search_dist, isFoundTarget) _UROKO_NonBattleAct(ai, goal_wait_id); end,
						maxBackhomeDist, backhomeDist, backhomeBattleDist, nonBattleActLife);

	if bSet == false then
		-- �����S�[�����ݒ肳��Ȃ������̂Ŕ�퓬�s�������Ă���
		ai:AddTopGoal( GOAL_COMMON_NonBattleAct, -1.0, -1.0, true, 0, 0);
	end
end


--[[*******************************************************************************************
	@brief	�ȒP�E���R�R�v�ݒ�B
	@note	�퓬�S�[���ɂȂ�܂ŁA�ǂ�ȏ�Ԃł����񂵂Ȃ��ŁA�ҋ@�B

		@param	goal_wait_id			�ҋ@���S�[��ID
*********************************************************************************************]]
function UROKO_EasySetup( ai, goal_wait_id)

	_UROKO_EasySetup( ai, goal_wait_id, function () 
											_UROKO_NonBattleAct(ai, goal_wait_id); 
										end);

end


--[[*******************************************************************************************
	@brief	�ȒP�E���R�R�v�ݒ�Q�B
	@note	�x���E������Ԃ́A�G�N�Z���̐ݒ�ɏ]���悤�ɁB

	@param	goal_wait_id			�ҋ@���S�[��ID
	@param
	@param	funcCautionAndFind		�x���E������Lua�֐��B�i�������Ȃ��Ăяo���B�j
*********************************************************************************************]]
function UROKO_EasySetup2( ai, goal_wait_id, funcCautionAndFind)

	_UROKO_EasySetup( ai, goal_wait_id, funcCautionAndFind);

end



