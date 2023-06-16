-----------------------------------------------------------------------------------------------
--	���̏��@�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Ounotate501000_Battle, "ounotate501000Battle");


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function ounotate501000Battle_Activate(ai, goal)
-----------------------------------------------------------------
local targetDist = ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
local targetDistY = ai:GetDistY( TARGET_ENE_0 );	--�G�^�[�Q�b�g�Ƃ̋������擾(Y)

local fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂R

--���̂Ƃ���g���Ă��Ȃ�
local Att3000_Dist_min = -2.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 5.0					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3020_Dist_min = 3.5					--3020�Ԃ̓K���ԍ����i�ŏ��j
local Att3020_Dist_max = 8.5					--3020�Ԃ̓K���ԍ����i�ő�j
local Att3040_Dist_min = 4.0					--3040�Ԃ̓K���ԍ����i�ŏ��j
local Att3040_Dist_max = 10.0					--3040�Ԃ̓K���ԍ����i�ő�j

--���܂��Ȃ�
local Att3040Per = 0.0		--�ガ����
local Att3020Per = 0.0		--���˂�
local Att3000Per = 0.0		--�O�����A�^�b�N�@����0.0�`4.5��
local LeavePer = 0.0		--�����
local BackStepPer = 0.0		--�o�b�N�X�e�b�v����
local Att3030Per = 0.0		--���̏��œ���

	--�U���֎~�̈�ɂ�����A���񂷂邾��
	if ( ai:IsInsideTargetRegion(TARGET_ENE_0, 2260) ) then
		goal:AddSubGoal( GOAL_COMMON_Turn,	3.0, TARGET_ENE_0, 0, 0, 0 );
		
	elseif ( ai:IsInsideTargetRegion(TARGET_ENE_0, 2261) ) then
		goal:AddSubGoal( GOAL_COMMON_Turn,	3.0, TARGET_ENE_0, 0, 0, 0 );
		
		
	--���������ȏ�������A����ɂ���̂ő�����
	elseif targetDistY >= 1.5 then
		
		--�U����������Ă���̈�
--		if ( ai:IsInsideTargetRegion(TARGET_ENE_0, 2270) ) or
--			( ai:IsInsideTargetRegion(TARGET_ENE_0, 2271) ) or
--			( ai:IsInsideTargetRegion(TARGET_ENE_0, 2272) ) or
--			( ai:IsInsideTargetRegion(TARGET_ENE_0, 2273) ) then
			
			--�����ʑΉ��@�߂������牺����
			if targetDist <= 14.0 then
				goal:AddSubGoal(GOAL_COMMON_Step, 10.0, 701, 0, 0, 0);
				goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 15.0, TARGET_ENE_0, true, -1 );				
				goal:AddSubGoal( GOAL_COMMON_Attack, 7.0, 3300, TARGET_ENE_0, DIST_Far, 0 );
				if fate <= 50 then
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 30, true, true ,-1 );
				end
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 7.0, 3300, TARGET_ENE_0, DIST_Far, 0 );
				if fate <= 50 then
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 30, true, true ,-1 );
				end
			end
			
--		--�U���֎~�̈�
--		else
--			goal:AddSubGoal( GOAL_COMMON_Turn,	3.0, TARGET_ENE_0, 0, 0, 0 );
--		end
		
	--�������������炢	
	else
		--����Ɖ����Ȃ�߂Â��čU��
		if targetDist >= 10.0 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 8.5, TARGET_ENE_0, true, -1 );
			if fate <= 35 then
				goal:AddSubGoal( GOAL_COMMON_Turn,	3.0, TARGET_ENE_0, 0, 0, 0 );
				goal:AddSubGoal( GOAL_COMMON_Attack, 7.0, 3020, TARGET_ENE_0, DIST_Middle, 0 );
			elseif fate <= 70 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 7.0, 3040, TARGET_ENE_0, DIST_Middle, 0 );
			else
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal( GOAL_COMMON_Attack, 7.0, 3000, TARGET_ENE_0, DIST_Middle, 0 );
			end	
			
			if fate2 <= 10 then
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 30, true, true ,-1 );
			end
			
		--���߂Ȃ�A�K�����U�����邩�A�Ƃ��ǂ��߂Â�	
		elseif targetDist >= 5.0 then
			--�U��
			if fate <= 50 then
				if fate2 <= 50 then
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 8.5, TARGET_ENE_0, true, -1 );
					goal:AddSubGoal( GOAL_COMMON_Attack3, 7.0, 3020, TARGET_ENE_0, DIST_Middle, 3.0, -1, 1);
				else
					goal:AddSubGoal( GOAL_COMMON_Attack3, 7.0, 3040, TARGET_ENE_0, DIST_Middle, 3.0, 30, 1);
				end
				
				if fate3 <= 20 then
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 30, true, true ,-1 );
				end
			--�߂Â�
			else
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal( GOAL_COMMON_Attack, 7.0, 3000, TARGET_ENE_0, DIST_Middle, 0 );
				
				if fate3 <= 20 then
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 30, true, true ,-1 );
				end
			end
			
		--�߂߂Ȃ�A�K�����s�������邩�A�Ƃ��ǂ������
		elseif targetDist >= 1.0 then
			--�����ʂɍœK�U��
			if targetDist >= 4.0 then
				Att3040Per = 25
				Att3020Per = 25
				Att3000Per = 40
				LeavePer = 5
				BackStepPer = 5
				Att3030Per = 0				
				
			elseif targetDist >= 3.0 then
				Att3040Per = 0	
				Att3020Per = 30
				Att3000Per = 50
				LeavePer = 5
				BackStepPer = 5
				Att3030Per = 0				
				
			else
				Att3040Per = 0	
				Att3020Per = 0
				Att3000Per = 50
				LeavePer = 10
				BackStepPer = 10
				Att3030Per = 30				
			end
				
			if fate <= Att3040Per then
				--�^���ɂ����ԂōU�����Ȃ��悤�ɁA���O�ɏ���������������邩��
				goal:AddSubGoal( GOAL_COMMON_Attack3, 7.0, 3040, TARGET_ENE_0, DIST_Middle, 3.0, 30, 1);
				
			elseif fate <= (Att3040Per + Att3020Per) then
				goal:AddSubGoal( GOAL_COMMON_Attack3, 7.0, 3020, TARGET_ENE_0, DIST_Middle, 3.0, -1, 1);
				
			elseif fate <= (Att3040Per + Att3020Per + Att3000Per) then
				goal:AddSubGoal( GOAL_COMMON_Attack, 7.0, 3000, TARGET_ENE_0, DIST_Middle, 0 );
				
			elseif fate <= (Att3040Per + Att3020Per + Att3000Per + LeavePer ) then
				goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 5.5, TARGET_ENE_0, true, -1 );
				
			elseif fate <= (Att3040Per + Att3020Per + Att3000Per + LeavePer + BackStepPer ) then
				goal:AddSubGoal(GOAL_COMMON_Step, 10.0, 701, 0, 0, 0);
				
			else
				goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 7.0, 3030, TARGET_ENE_0, DIST_Near, 0);		
			end
			
		--�����ɓ���ꂽ��A�����ɂ���ēK�����U�������邩�A�X�e�b�v�ŗ����
		else
			--�E��둤�ɂ���ꍇ�A���m���œ��݂�
			if ai:IsInsideTarget( TARGET_ENE_0, AI_DIR_TYPE_R, 180.0 ) and
				   ai:IsInsideTarget( TARGET_ENE_0, AI_DIR_TYPE_B, 180.0 ) then
				if fate <= 40 then
					goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 7.0, 3010, TARGET_ENE_0, DIST_Near, 0);		
				elseif fate <= 65 then
					goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 7.0, 3030, TARGET_ENE_0, DIST_Near, 0);		
				elseif fate <= 85 then
					goal:AddSubGoal(GOAL_COMMON_Attack, 7.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_Step, 10.0, 701, 0, 0, 0);
				end
				
			--���㑤�ɂ���ꍇ�A��⍂�m���Ńo�b�N�X�e�b�v���Ă���O�����ׂ�
			elseif ai:IsInsideTarget( TARGET_ENE_0, AI_DIR_TYPE_B, 180.0 ) then
				if fate <= 40 then
					goal:AddSubGoal(GOAL_COMMON_Step, 10.0, 701, 0, 0, 0);
					goal:AddSubGoal(GOAL_COMMON_Attack, 7.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
				elseif fate <= 95 then
					goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 7.0, 3030, TARGET_ENE_0, DIST_Near, 0);		
				else
					goal:AddSubGoal(GOAL_COMMON_Attack, 7.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
				end
				
			--������ł��Ȃ��ꍇ�A���m���ő������ׂ�
			else
				if fate <= 65 then
					goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 7.0, 3030, TARGET_ENE_0, DIST_Near, 0);		
				elseif fate <= 95 then
					goal:AddSubGoal(GOAL_COMMON_Step, 10.0, 701, 0, 0, 0);
					goal:AddSubGoal(GOAL_COMMON_Attack, 7.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
				else
					goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 7.0, 3010, TARGET_ENE_0, DIST_Near, 0);		
				end	
			end
		end
	end	
end

---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function ounotate501000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function ounotate501000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function ounotate501000Battle_Interupt(ai, goal)

	return false;
end
