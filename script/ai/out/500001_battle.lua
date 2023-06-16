-----------------------------------------------------------------------------------------------
--	FaranCIBI_B500001��p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_FaranCIBI_B500001_Battle, "FaranCIBI_B500001Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_FaranCIBI_B500001_Battle, 1 );



---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function FaranCIBI_B500001Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋���
local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p

	--�����Ȃ�ˌ�
	if targetDist >= 3.0 then
		goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3010, TARGET_ENE_0, DIST_None, 0);
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(0.5, 1.5), TARGET_NONE, 0, 0, 0 );
		
	--�����炢�̋����Ȃ�ˌ�or�ڋ�
--	elseif targetDist >= 4.0 then
--		if fate <= 60 then
--			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3010, TARGET_ENE_0, DIST_None, 0);
--			goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(0.5, 1.5), TARGET_NONE, 0, 0, 0 );	
--		else
--			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 3.0, TARGET_ENE_0, false, -1 );
--		end
		
	--�߂��Ȃ�ߐڍU��	
	else
--		goal:AddSubGoal( GOAL_COMMON_KeepDist, 5.0, TARGET_ENE_0, 0.5, 3.0, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3030, TARGET_ENE_0, DIST_None, 0);
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(0.0, 1.0), TARGET_NONE, 0, 0, 0 );
	end
end



---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function FaranCIBI_B500001Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function FaranCIBI_B500001Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function FaranCIBI_B500001Battle_Interupt(ai, goal)
return false;

end
