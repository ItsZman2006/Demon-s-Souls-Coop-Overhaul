-----------------------------------------------------------------------------------------------
--	FaranHONTAI500100��p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_FaranHONTAI500100_Battle, "FaranHONTAI500100Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_FaranHONTAI500100_Battle, 1 );



---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function FaranHONTAI500100Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋���
local fate = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐��� ���̂Q
local jrGattaiCounts = ai:GetEventRequest(1);		--����t���Ă���`�r�̐l�����C�x���g����擾

	--����t���Ă���`�r���P�T�ȉ��������珉���ʒu������ŃE���E��
--	if jrGattaiCounts <= 15 then
--		goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 7.5, POINT_INITIAL, AI_DIR_TYPE_CENTER, 0.0, TARGET_NONE, true );
--		goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 10.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 15.0, TARGET_NONE, false )
--		goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 7.5, TARGET_SELF, ai:GetRandam_Int(0, 3), ai:GetRandam_Float(5.0, 10.0), TARGET_NONE, true );
--		goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 7.5, TARGET_SELF, ai:GetRandam_Int(0, 3), ai:GetRandam_Float(5.0, 10.0), TARGET_NONE, true );
				
	--����p�s��
	--�^�C�}�[�O�Ԃ��I�����Ă���΁A�ڋ߂��Ă���ːi������
--	if ai:IsFinishTimer(0) == true then
		--�����Ń^�C�}�[�O�Ԃ��Z�b�g 9999�b
--		ai:SetTimer( 0, 9999.0 );
--		goal:AddSubGoal(GOAL_COMMON_Wait, 0.1, TARGET_ENE_0, 0, 0, 0 );
--		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 10.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 15.0, TARGET_NONE, false )
--		goal:AddSubGoal(GOAL_COMMON_ContinueAttack, ai:GetRandam_Float(15.0, 25.0) , 3020, TARGET_ENE_0, 100, false);
		--�����Ń^�C�}�[�P�Ԃ��Z�b�g 60�b
--		ai:SetTimer( 1, 60.0 );		
		
	--�^�C�}�[�O�Ԃ��I�����Ă��Ȃ��Ƃ��͂������ɕ��򂷂�
--	else
		--�^�C�}�[�P�Ԃ��I�����Ă�����A�ːi����
--		if ai:IsFinishTimer(1) == true then
			--�����Ń^�C�}�[�P�Ԃ��Z�b�g 60�b
--			ai:SetTimer( 1, 60.0 );
--			goal:AddSubGoal(GOAL_COMMON_ContinueAttack, ai:GetRandam_Float(15.0, 25.0) , 3020, TARGET_ENE_0, 100, false);
		--�܂��^�C�}�[�P�Ԃ��I�����Ă��Ă��Ȃ����������Ă���
--		else
--		end

		--15�C�ȏ�`�r������t���Ă���΁A�߂Â��Ă���
		if jrGattaiCounts >= 15 then
			if fate <= 90 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 4.5, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal( GOAL_COMMON_Wait, ai:GetRandam_Float(1.0, 4.0), TARGET_NONE, 0, 0, 0 );
			else
				goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, 6.5, 8.5, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal( GOAL_COMMON_Wait, ai:GetRandam_Float(1.0, 4.0), TARGET_NONE, 0, 0, 0 );
			end
			
		--14�C�ȉ��Ȃ�A������ƊԂ��󂯂�		
		else
			if fate <= 10 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 4.5, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal( GOAL_COMMON_Wait, ai:GetRandam_Float(1.0, 4.0), TARGET_NONE, 0, 0, 0 );
			else
				goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, 6.5, 8.5, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal( GOAL_COMMON_Wait, ai:GetRandam_Float(1.0, 4.0), TARGET_NONE, 0, 0, 0 );
			end
		end	
--	end
end


---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function FaranHONTAI500100Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function FaranHONTAI500100Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function FaranHONTAI500100Battle_Interupt(ai, goal)

return false;

end
