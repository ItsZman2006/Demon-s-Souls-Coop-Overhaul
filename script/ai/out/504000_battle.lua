-----------------------------------------------------------------------------------------------
--	�R���Ґ�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Sinpansya504000_Battle, "Sinpansya504000Battle");


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function Sinpansya504000Battle_Activate(ai, goal)
	
local targetDist = ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
local targetDistY = ai:GetDistY( TARGET_ENE_0 );	--�G�^�[�Q�b�g�Ƃ̋������擾(Y)

local fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂R

	
	--�RF�ɂ�����
	if ai:IsInsideTargetRegion( TARGET_ENE_0, 2260) then
		if fate <= 80 then
			goal:AddSubGoal( GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, 7.9, 9.2, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3050, TARGET_ENE_0, DIST_None, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, 8.2, 10.1, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3060, TARGET_ENE_0, DIST_None, 0);
		end	
		
	--�Q.�TF�ɂ�����
	elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2261) then
		goal:AddSubGoal( GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, 6.5, 10.1, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3060, TARGET_ENE_0, DIST_None, 0);
		
	--�QF�ɂ�����
	elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2262) then
		if fate <= 50 then
			goal:AddSubGoal( GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, 4.2, 7.3, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3010, TARGET_ENE_0, DIST_None, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, 3.1, 5.1, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3030, TARGET_ENE_0, DIST_None, 0);
		end	
		
	--�P.�TF�ɂ�����
	elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2263) then
		goal:AddSubGoal( GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, 4.2, 7.3, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3010, TARGET_ENE_0, DIST_None, 0);
		
	--�PF�ɂ�����
	elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2264) then
		if targetDist <= 3.0 then
			if fate <= 90 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3000, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3010, TARGET_ENE_0, DIST_None, 0);
			end
		else
			if fate <= 20 then
				goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, 6.7, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3000, TARGET_ENE_0, DIST_None, 0);
			elseif fate <= 40 then
				goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, 6.9, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3010, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, 3.0, 6.3, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3040, TARGET_ENE_0, DIST_None, 0);
			end	
		end
		
	--�����̒��ɂ�������Ȃ���΁A���ɖ߂�
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 3.0, POINT_INITIAL, 1.0, TARGET_SELF, true, -1 );
		goal:AddSubGoal( GOAL_COMMON_Wait, 5.0, TARGET_NONE, 0, 0, 0 );
	end
	
	--�����܂�ɑ��ɖ߂�
	if fate2 <= 5 then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 3.0, POINT_INITIAL, 1.0, TARGET_ENE_0, true, -1 );
	end

end

---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function Sinpansya504000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function Sinpansya504000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function Sinpansya504000Battle_Interupt(ai, goal)
	
	return false;
end
