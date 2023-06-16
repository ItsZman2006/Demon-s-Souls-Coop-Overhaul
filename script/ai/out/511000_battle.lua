-----------------------------------------------------------------------------------------------
--	�z�΂̐���p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_seirei511000_Battle, "seirei511000Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_seirei511000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function seirei511000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------
local targetDist = ai:GetDist(TARGET_ENE_0);	--�^�[�Q�b�g�Ƃ̋������擾
local Normal_ATK_Dist = 0.7						--�U���̓͂�����
local TAEGET_DIR = 40							--�U���̓͂��p�x

	if targetDist >= Normal_ATK_Dist then
	
		goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_NONE, 0, 0, 0 );
	
	else
	
		if ( ai:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, TAEGET_DIR) ) then
		
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		
		else
		
			goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_NONE, 0, 0, 0 );
			
		end
	end
end

	
---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function seirei511000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function seirei511000Battle_Terminate(ai, goal)
end

---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function seirei511000Battle_Interupt(ai, goal)

return false;
end




			


