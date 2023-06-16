--[[********************************************************************************************
	�y�E���R�z�v�i�ϋɍU���^�j�z�p�퓬
	�����F
	
	
	��ȏC�������F
	�E08/7/24	hasem
		����P�z�ꕺ�m200000����������ɂ��āA�쐬�B
	�E08/7/25   kitat
	�@�@�U������̒���
	

	�p�����[�^0  �Ȃ�
	�p�����[�^1  �Ȃ�
	�p�����[�^2  �Ȃ�
	�p�����[�^3�@�Ȃ�
**********************************************************************************************]]
REGISTER_GOAL(GOAL_uroko211008_Battle, "uroko211008Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_uroko211008_Battle, true);


--[[*****************************************************
	�N���B
*******************************************************]]
function uroko211008Battle_Activate(ai, goal)

	local targetDist 	= ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾

	
	local Att3300Per = 0		--���W�����v�U���̊m��
	local Att3003Per = 0		--���W�����v�U���̊m��
	local Att3004Per = 0		--�߃W�����v�U���̊m��
	local AttNormalPer = 100	--�ߋ����U���@�@�̊m��	
	
	--�����ʂɊm�������߂�
	if targetDist >= 9.0 then
		Att3300Per = 75	
		Att3003Per = 10	
		Att3004Per = 10
		AttNormalPer = 5
		
	elseif targetDist >= 7.0 then
		Att3300Per = 0
		Att3003Per = 70
		Att3004Per = 20	
		AttNormalPer = 10
		
	elseif targetDist >= 2.0 then
		Att3300Per = 0
		Att3003Per = 0
		Att3004Per = 25
		AttNormalPer = 75	
		
	else
		Att3300Per = 0
		Att3003Per = 0
		Att3004Per = 0
		AttNormalPer = 100	
		
	end
	
	--�ړ�
	uroko211008Battle_Approach( ai, goal, 2);
	
	
	--�W�����v�U���ɍœK�Ȋԍ����̏ꍇ�B�B�B
	local rangeJumpAttack_begin = 4;
	local rangeJumpAttack_end 	= 6;
	
	if ( (rangeJumpAttack_begin<targetDist) and (targetDist<rangeJumpAttack_end) ) then
		--��̑O���ɂ�����W�����v�U���B
		if ( ai:IsInsideTargetEx(TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 45, 20) ) then
			goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 3);
		end
	else
		uroko211008Battle_Attack(ai, goal)
	end
	
	--�U����n���B
	uroko211008Battle_AfterAttack(ai, goal)

end

---------------------------------------------------------
--  �U��
---------------------------------------------------------
function uroko211008Battle_Attack(ai, goal)

	local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--50% 3000	
	--25% 3001
	--25% 3002
	
	if K_fate <= 50 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 65 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function uroko211008Battle_AfterAttack(ai, goal)

	local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
	local SideTime = 1.0							--���ɓ�������
	local BackDist = 1.0							--��ނ��鋗��
	local BackTime = 1.0							--��ނ��鎞��
	local bRight = ai:GetRandam_Int(0,1);			--�E������
	-- ���������ɍ��E�ړ����Ă��钇�Ԃ̐�
	local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);

	--85% ��ċz	--10% �K���ɉ��ɃK�[�h�ړ�	--5% ���ɃK�[�h�ړ�
	if KN_fate <= 85 then
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.5,1.0) ,0,0,0,0)
	elseif KN_fate <= 95 and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, bRight, ai:GetRandam_Int(30,45), true, true ,9910 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, 9910 );				
	end
end

---------------------------------------------------------
--  �ڋ߁B
---------------------------------------------------------
function uroko211008Battle_Approach(ai, goal, dist)
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, dist, TARGET_ENE_0, false, -1 );
end

	
	
--[[*****************************************************
	�S�[���̍X�V�E�I���͂Ȃ��B
*******************************************************]]
function uroko211008Battle_Update(ai, goal)	return GOAL_RESULT_Continue;end
function uroko211008Battle_Terminate(ai, goal)end


--[[*****************************************************
  ���荞��
*******************************************************]]
function uroko211008Battle_Interupt(ai, goal)
	return false;
end


	