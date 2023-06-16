-----------------------------------------------------------------------------------------------
--	NpcPlayerTest��p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_NpcPlayerTest_Battle, "NpcPlayerTestBattle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_NpcPlayerTest_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function NpcPlayerTestBattle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐���

	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 2.0, TARGET_ENE_0, true, NPC_ATK_GuardL );
	
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_None, 0);
	--goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_PushR, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_GuardL, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Parry, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Item, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepF, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);


end



---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function NpcPlayerTestBattle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function NpcPlayerTestBattle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function NpcPlayerTestBattle_Interupt(ai, goal)

	return false;
end
