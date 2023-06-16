-----------------------------------------------------------------------------------------------
--	Test10004��p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Test10004_Battle, "Test10004Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Test10004_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function Test10004Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )
	--������HP�������擾
local targethprate = ai:GetHpRate( TARGET_ENE_0 )
	--�G�^�[�Q�b�g��HP�������擾
local targetDist = ai:GetDist(TARGET_ENE_0);
	--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)
	--�m������Ŏg�p����^���̐���

----------------
--���퓬�s����--
----------------

	if targetDist <= 4.5 then
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 0.5 , TARGET_ENE_0, true );
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3000, TARGET_ENE_0, DIST_Far, 0);
--		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, POINT_INITIAL, AI_DIR_TYPE_CENTER, 0.0, TARGET_ENE_0, true );

		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 0.5 , TARGET_ENE_0, true );
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3001, TARGET_ENE_0, DIST_Far, 0);
--		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, POINT_INITIAL, AI_DIR_TYPE_CENTER, 0.0, TARGET_ENE_0, true );

		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 0.5 , TARGET_ENE_0, true );
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3002, TARGET_ENE_0, DIST_Far, 0);
--		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, POINT_INITIAL, AI_DIR_TYPE_CENTER, 0.0, TARGET_ENE_0, true );
		
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 0.5 , TARGET_ENE_0, true );		
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3300, TARGET_ENE_0, DIST_Far, 0);
--		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, POINT_INITIAL, AI_DIR_TYPE_CENTER, 0.0, TARGET_ENE_0, true );
		
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 0.5 , TARGET_ENE_0, true );
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9800, TARGET_ENE_0, DIST_Far, 0);
--		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, POINT_INITIAL, AI_DIR_TYPE_CENTER, 0.0, TARGET_ENE_0, true );
		
	else
		goal:AddSubGoal(GOAL_COMMON_Wait, 5.0, 0, 0, 0, 0);
	end
	
end



---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function Test10004Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function Test10004Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function Test10004Battle_Interupt(ai, goal)

	return false;
end
