-----------------------------------------------------------------------------------------------
--	�E���R�z�v�i�����艺�A�܁j�p�퓬
--	�����F���E�ɓ����č����ւ̐ڋ߂�W�Q
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_uroko211004_Battle, "uroko211004_Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_uroko211004_Battle, 1 );
-- ���荞�܂Ȃ��B
REGISTER_GOAL_NO_INTERUPT( GOAL_uroko211004_Battle, true);

---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function uroko211004_Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾
local targethprate = ai:GetHpRate( TARGET_ENE_0 )	--�G�^�[�Q�b�g��HP�������擾
local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q

local farDist = 15.0		--����Ɖ����Ɣ��f���鋗��
local nearDist = 4.0		--�߂��Ɣ��f���鋗��
local maaiDist = 1.5		--�U���̂��߂ɋ߂Â������@���ėp���ׁ̈A�U�����Ƃɕ�������
local bRight = ai:GetRandam_Int(0,1);			--�E������
local SideDist = 2.5							--���ɓ�������
local SideTime = 5.0							--���ɓ�������

        
		-- ���߂����Ă���ꍇ�͈ړ��^�C�v��ς���
		if ai:GetTeamRecordCount(COORDINATE_TYPE_AttackOrder, TARGET_ENE_0, 100.0) >= 1 then
		else
		end
		
		-- ���߂����Ă��Ȃ���Αҋ@
		if ai:GetTeamRecordCount(COORDINATE_TYPE_AttackOrder, TARGET_ENE_0, 100.0) <= 0 then
			-- ���߂��Ȃ��̂ō̌@
			ai:ChangeMoveAnimParam(0)
			-- ���̏�ō��
			goal:AddSubGoal( GOAL_COMMON_Wait, 5.0, TARGET_ENE_NONE, 0, 0, 0 );
		else
			-- ���߂����Ă����̂Œʏ�퓬

			-- ���߂����Ă���̂Œʏ�ړ��A�j���ɐ؂�ւ�
			ai:ChangeMoveAnimParam(1)
			
			--�����Ȃ�
			if targetDist >= farDist then
				
				--�����ċ߂Â�
						
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, nearDist, TARGET_ENE_0, true, -1 );
				
							
			--�������Ȃ����߂����Ȃ��Ȃ�
			elseif targetDist >= nearDist then
			
				--�E�ɓ����Ă�������ċ߂Â�
				if fate < 40 then
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, true, 20.0, true, true, -1);
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );

				--���ɓ����Ă�������ċ߂Â�
				elseif fate < 80 then 
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, false, 10.0, true, true, -1);
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
				--�����ċ߂Â�
				else
				    goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 2.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			end
				
			--�߂��Ȃ�	
			elseif targetDist >= maaiDist then
			
				--�E�ɓ����Ă�������ċ߂Â�
				if fate2 < 40 then
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, true, 10.0, true, true, -1);
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
				
				--���ɓ����Ă�������ċ߂Â�
				elseif fate2 < 80 then 
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, false, 20.0, true, true, -1);
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
				
				--�����ċ߂Â�
				else
				    goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 2.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			end
			
			--�ԍ����ȓ��Ȃ�
			else
				--�U������
				uroko211004_Battle_Kougeki(ai, goal)
				
				--�U����s��
				uroko211004_Battle_Kougeki_Noato(ai, goal)
				
			end
		end
	end

---------------------------------------------------------
--  �U��
---------------------------------------------------------
function uroko211004_Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--80% 3000
	--20% 3000-3001
	if K_fate < 50 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, AI_DIST_TYPE_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, AI_DIST_TYPE_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, AI_DIST_TYPE_Middle, 0);
	
	end
end

	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function uroko211004_Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local SideDist = 2.5							--���ɓ�������
local SideTime = 5.0							--���ɓ�������
local BackDist = 1.0							--��ނ��鋗��
local BackTime = 5.0							--��ނ��鎞��
local bRight = ai:GetRandam_Int(0,1);			--�E������
-- ���������ɍ��E�ړ����Ă��钇�Ԃ̐�
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);

	
	--50% �K���ɉ��Ɉړ�(�K�[�h����)
	--50% ���Ɉړ�(�K�[�h�Ȃ�)
	if  KN_fate < 70 and friendNum < 1 then
	    goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, bRight, ai:GetRandam_Int(30,45), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end

	
	
---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function uroko211004_Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function uroko211004_Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function uroko211004_Battle_Interupt(ai, goal)
	return false;
end

			


	