-----------------------------------------------------------------------------------------------
--	�����퓬
--	�����F�S��2�̗�����p
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Ryosyu207005_Battle, "Ryosyu207005Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Ryosyu207005_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function Ryosyu207005Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

	local hpRate 		= ai:GetHpRate( TARGET_SELF )		--������HP�������擾
	local targetHpRate 	= ai:GetHpRate( TARGET_ENE_0 )	--�G�^�[�Q�b�g��HP�������擾
	local targetDist 	= ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
	local fate 			= ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐���
	local fate2 		= ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐����@���̂Q
	
	if ( targetDist <= ai:GetDistParam( DIST_far ) ) then
		goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_NONE,DIST_None, 0 )
		goal:AddSubGoal( GOAL_COMMON_Wait, 3, TARGET_NONE);
	end
	
	
--~ 	-- �ߋ���
--~ 	if( targetDist <= ai:GetDistParam( DIST_Near ) ) then
--~ 			
--~ 			-- ���܂ɂ��F��
--~ 			if( fate2 <= 30 ) then
--~ 				goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_EVENT,DIST_None, 0 )
--~ 			
--~ 			-- �v���C���[�̍��E�𑖂���
--~ 			elseif( fate2 <= 70) then
--~ 				goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 3.0, TARGET_ENE_0, AI_DIR_TYPE_L, 0.5, TARGET_ENE_0, false );
--~ 				goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 3.0, TARGET_ENE_0, AI_DIR_TYPE_R, 0.5, TARGET_ENE_0, false );
--~ 				
--~ 			else
--~ --				goal:AddSubGoal( GOAL_COMMON_WalkAround, 15, -1, 0, 0, 0 );
--~ 				goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 15, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 1, TARGET_ENE_0, false );
--~ 			end
--~ 			
--~ 			
--~ 			-- ���܂ɍU��
--~ 			if( fate <= 5 ) then
--~ 				goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3000, TARGET_ENE_0, DIST_Near, 0 )
--~ 			end
--~ 			
--~ 	-- ������
--~ 	elseif( targetDist <= ai:GetDistParam( DIST_Middle ) ) then
--~ 		-- ���܂ɂ��F��
--~ 		if( fate2 <= 30 ) then
--~ 			goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_EVENT,DIST_None, 0 )
--~ 		end

--~ 		-- �����Ēǂ�������
--~ 		if( fate <= 99 ) then
--~ --			goal:AddSubGoal( GOAL_COMMON_WalkAround, 15, -1, 0, 0, 0 );
--~ 			goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 15, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 1, TARGET_ENE_0, false );
--~ 		
--~ 		-- �H�Ƀ_�b�V��
--~ 		else
--~ 			goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 5, TARGET_EVENT, AI_DIR_TYPE_CENTER, 1, TARGET_EVENT, false );
--~ 			goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_EVENT,DIST_None, 0 )
--~ 			goal:AddSubGoal(GOAL_COMMON_BackToHome, 60, -1, 0, 0, 0 );
--~ 		end	
--~ 	
--~ 	-- �������ȏ�
--~ 	else
--~ 		-- ���܂ɂ��F��
--~ 		if( fate2 <= 20 ) then
--~ 			goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_EVENT,DIST_None, 0 )
--~ 		end
--~ 	
--~ 		-- �ǂ�������
--~ 		if( fate <= 90 ) then
--~ --			goal:AddSubGoal( GOAL_COMMON_WalkAround, 15, -1, 0, 0, 0 );
--~ 			goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 15, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 1, TARGET_ENE_0, false );
--~ 		
--~ 		-- �H�Ƀ_�b�V��
--~ 		else
--~ 			goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 5, TARGET_EVENT, AI_DIR_TYPE_CENTER, 1, TARGET_EVENT, false );
--~ 			goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_EVENT,DIST_None, 0 )
--~ 			goal:AddSubGoal(GOAL_COMMON_BackToHome, 60, -1, 0, 0, 0 );
--~ 		end	
--~ 	end


end

---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function Ryosyu207005Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function Ryosyu207005Battle_Terminate(ai, goal)
end



--~ ---------------------------------------------------------
--~ --  ���荞��
--~ --	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--~ --	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--~ --	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
--~ ---------------------------------------------------------
--~ function Ryosyu207005Battle_Interupt(ai, goal)

--~ 	

--~ 	if( ai:IsInterupt( INTERUPT_FindAttack ) ) then
--~ 		local targetDist 	= ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
--~ 		if( targetDist <= 2 ) then
--~ 			goal:ClearSubGoal();
--~ 			goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_ENE_0, DIST_Near, 0 )
--~ 		end
--~ 	end

--~ 	-- �U�����ꂽ
--~ 	if( ai:IsInterupt( INTERUPT_Damaged ) ) then
--~ 		goal:ClearSubGoal();
--~ 		local dist = 5.0;
--~ 		-- �G�Ƃ͋t�����ɓ�����
--~ 		goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 8, TARGET_ENE_0, AI_DIR_TYPE_F, dist, TARGET_SELF, false );
--~ 		
--~ 		-- �����ʒu�ɖ߂�
--~ 		goal:AddSubGoal( GOAL_COMMON_PathMovePoint, 5, POINT_INITIAL, AI_DIR_TYPE_CENTER, 1.0, TARGET_SELF, true );

--~ 		-- ���F��
--~ 		goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_EVENT,DIST_None, 0 )
--~ 		
--~ 		return true;
--~ 	elseif( ai:IsInterupt( INTERUPT_Damaged_Stranger ) ) then
--~ 		goal:ClearSubGoal();
--~ 		local dist = 5.0;
--~ 		-- �G�Ƃ͋t�����ɓ�����
--~ 		goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 8, TARGET_ENE_0, AI_DIR_TYPE_F, dist, TARGET_SELF, false );
--~ 		
--~ 		-- �����ʒu�ɖ߂�
--~ 		goal:AddSubGoal( GOAL_COMMON_PathMovePoint, 5, POINT_INITIAL, AI_DIR_TYPE_CENTER, 1.0, TARGET_SELF, true );

--~ 		-- ���F��
--~ 		goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_EVENT,DIST_None, 0 )
--~ 		
--~ 		return true;
--~ 	end
--~ 	

--~ 	return false;
--~ end	

