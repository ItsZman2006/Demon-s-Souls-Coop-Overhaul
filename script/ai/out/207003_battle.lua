-----------------------------------------------------------------------------------------------
--	�����퓬
--	�����F
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Ryosyu207003_Battle, "Ryosyu207003Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Ryosyu207003_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function Ryosyu207003Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

	local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋���
	local fate = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐���
	local fate2 = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐����@���̂Q
	local fate3 = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐����@���̂R
	local sekkin = ai:GetRandam_Float(0.75, 1.5)			--�ڋ߂��鋗��
	local maai = ai:GetRandam_Float(0.75, 1.5)				--�ԍ����������鋗��
	local rate = ai:GetHpRate( TARGET_SELF )				--������HP

	local farDist = 10.0		--�����Ɣ��f���鋗��
	local nearDist = 7.5		--�߂��Ɣ��f���鋗��
	local maaiDist = 5.5		--�U���̂��߂ɋ߂Â������@���ėp���ׁ̈A�U�����Ƃɕ�������


	
	--�����Ȃ�
	if targetDist >= nearDist then
		--10���@�����ڋ�
		--35���@�������瑖��ڋ�
		--55���@����ڋ�
		if fate < 10 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
		elseif fate < 45 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, (targetDist - 3.0), TARGET_ENE_0, true, -1 );
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );			
		else
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
		end
		
	--�߂��Ȃ�
	elseif targetDist >= maaiDist then
		--60���@�����ڋ߁���荞�݁��Đڋ߁@�@40���@�����ۂ�70%�ːi�̓�����30%�U���i���j�E
		if fate < 60 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			if fate2 < 20 then
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(10,20), true, true ,-1 );
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			end
		else

			goal:AddSubGoal( GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, maaiDist, nearDist, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3002, TARGET_ENE_0, DIST_Near, 0);

		end
		
	else
	--�ԍ����ȓ��Ȃ�
		--�U������
		--�U����s��
		Ryosyu207003Battle_Attack(ai, goal)
		Ryosyu207003Battle_AfterAttack(ai, goal)
	end
end

	
	
---------------------------------------------------------
--  �U��
---------------------------------------------------------
function Ryosyu207003Battle_Attack(ai, goal)

	local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	
	if K_fate <= 100 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
	end

end

	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function Ryosyu207003Battle_AfterAttack(ai, goal)

	local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
	local SideTime = 0.7							--���ɓ�������
	local BackDist = 1.0							--��ނ��鋗��
	local BackTime = 0.7							--��ނ��鎞��
	local bRight = ai:GetRandam_Int(0,1);			--�E������
	-- ���������ɍ��E�ړ����Ă��钇�Ԃ̐�
	local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);

	--85% ��ċz	--5% �K���ɉ��ɃK�[�h�ړ�	--10% ���ɃK�[�h�ړ�
	if KN_fate <= 85 then
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.2,0.6) ,0,0,0,0)
	elseif KN_fate <= 90 and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, bRight, ai:GetRandam_Int(30,45), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end


---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function Ryosyu207003Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function Ryosyu207003Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function Ryosyu207003Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐���
local maaiDist = 1.0										--�U���̂��߂ɋ߂Â������@���ėp���ׁ̈A�U�����Ƃɕ�������

	--��U��ǂ�����
	--25���@�߂��̃^�[�Q�b�g����U�肵����U��
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < maaiDist then
			if fate <= 25 then
				goal:ClearSubGoal();
				Ryosyu207003Battle_Attack(ai, goal)
				Ryosyu207003Battle_AfterAttack(ai, goal)
				return true;
			end	
		end
	end

return false;

end

