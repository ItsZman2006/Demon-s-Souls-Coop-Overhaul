--[[*******************************************************************************************
--	��ԏ�ɂȂ�S�[��
--	�����F�v���O�������璼�ڂ�т�����܂��B
--		  ���̃S�[�����͓̂��ɂȂɂ����܂���B
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
*********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_TopGoal, "TopGoal");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_COMMON_TopGoal, 1 );
--�����݂����B
function TopGoal_Activate(ai, goal)end
function TopGoal_Update(ai, goal) return GOAL_RESULT_Continue; end
function TopGoal_Terminate(ai, goal)end


--[[*****************************************************
--  ���荞��
*******************************************************]]
function TopGoal_Interupt(ai, goal)
	if ( ai:IsInterupt( INTERUPT_CANNOT_MOVE)) then

		--�A�N�V�����B
		local idAction = ai:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__CannotMoveAction);

		--�j��\�ȃI�u�W�F�N�g�ɐڐG���ē����Ȃ��Ȃ��Ă���ꍇ�A
		--�j�󂵂Đ�ɐi�ށB
		if ( ai:IsTouchBreakableObject() and (0<=idAction) ) then
		
			--������������OBJ�����ʂɂ���΁B�B�B
			if ( ai:IsLookToTarget(POINT_CurrRequestPosition, 90) ) then
				--�G�N�Z���ɐݒ肵�Ă���A�N�V������ǉ��B
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, -1, idAction, TARGET_NONE, DIST_None);
				return true;
			end
		end
	end
	
	-- ���荞�ݖ������ɂ̂݌Ă΂���Q�����o
	-- �o�O�΍�
	if ( ai:IsInterupt( INTERUPT_CANNOT_MOVE_DisableInterupt)) then

		--�A�N�V�����B
		local idAction = ai:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__CannotMoveAction);

		--�j��\�ȃI�u�W�F�N�g�ɐڐG���ē����Ȃ��Ȃ��Ă���ꍇ�A
		--�j�󂵂Đ�ɐi�ށB
		if ( ai:IsTouchBreakableObject() and (0<=idAction) ) then
		
			--������������OBJ�����ʂɂ���΁B�B�B
			if ( ai:IsLookToTarget(POINT_CurrRequestPosition, 90) ) then
				--�G�N�Z���ɐݒ肵�Ă���A�N�V������ǉ��B
				--goal:ClearSubGoal();
				--goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, -1, idAction, TARGET_NONE, DIST_None);
				-- �擪�S�[���Ɋ��荞�ݒǉ����邱�ƂŁA���܂Ŏ��s���Ă������̂�ێ�����B
				goal:AddSubGoal_Front( GOAL_COMMON_NonspinningAttack, -1, idAction, TARGET_NONE, DIST_None);
				return true;
			end
		end
	end
	
	
	--�G�ǂɐڐG���Ă���B
	if ( ai:IsInterupt(INTERUPT_HitEnemyWall) ) then
	
		local backhome_life	= ai:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__BackHomeLife_OnHitEnemyWall);
		if ( 0 < backhome_life ) then
			--�ⓚ���p�ň�莞�ԁA����ɋA��܂��B
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_BackToHome, backhome_life, 0);
			return true;
		end
	end
	
	return false;
end
