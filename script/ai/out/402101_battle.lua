-----------------------------------------------------------------------------------------------
--	���K�C�R�c�Q�|�@�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_honeBOU402101_Battle, "honeBOU402101Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_honeBOU402101_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function honeBOU402101Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐����@���̂R

local myThinkId = ai:GetNpcThinkParamID()		--�v�lID���擾
	
	--�߂���΁A�����Ă��瓦����
	if targetDist <= 4.0 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
		if fate <= 35 then
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, ai:GetRandam_Int(702,703), TARGET_NONE, 0, 0);
		end
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (1.0,2.0) ,0,0,0,0)
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 10.0, TARGET_SELF, false, -1 );
		
	--���߂���΁A�����Ă��班����ނ���
	elseif targetDist <= 8.0 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
		if fate <= 20 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
		end
		
		if fate2 <= 75 and myThinkId == 402101 then
			goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (2.0,4.0) ,0,0,0,0)
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, 12.0, TARGET_ENE_0, true, -1 );
		else
			goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (2.0,4.0) ,0,0,0,0)
		end
		
	--�K�x�ȋ����Ȃ�΁A����
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
		if fate <= 20 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
		end
		
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (3.0,6.0) ,0,0,0,0)
		
	end
	
end
	



---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function honeBOU402101Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function honeBOU402101Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function honeBOU402101Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p

	--�R���{����@�����ʊ֐�
local combRunDist = 1.5				--�R���{���ꂷ�鋗��
local combRunPer = 30				--�R���{���ꂷ��m��
	if Damaged_Act(ai, goal, combRunDist, combRunPer ) then
		goal:ClearSubGoal();
		
		--���E�ɃX�e�b�v
		if fate <= 50 then
			goal:AddSubGoal( GOAL_COMMON_Step, 10.0, 702, 0, 0, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_Step, 10.0, 703, 0, 0, 0);
		end
		return true;
	end	


	return false;
end
