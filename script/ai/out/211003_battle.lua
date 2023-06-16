--[[********************************************************************************************
	�y�E���R�z�v�i�ϋɍU���^�j�z�p�퓬
	�����F
		�匕�E�������ʐ퓬�S�[���B
	
	��ȏC�������F
	�E08/7/25   kitat
	�@�@211008����R�s�[
	�E08/7/31	hasem
		�`�[���T�O��ǉ��B

	�p�����[�^0  �Ȃ�
	�p�����[�^1  �Ȃ�
	�p�����[�^2  �Ȃ�
	�p�����[�^3�@�Ȃ�
**********************************************************************************************]]
REGISTER_GOAL(GOAL_urokoLS211003_Battle, "uroko211003Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_urokoLS211003_Battle, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_urokoLS211003_Battle, true);


--[[*****************************************************
	�N���B
*******************************************************]]
function uroko211003Battle_Activate(ai, goal)

--[[����撲�����ځ�]]
	
	--�Ⓤ���T�|�[�g���Ƃ��ĔF������Ⓤ���z�v�܂ł̋����B
	local RANGE_IWANAGE_SUPPORT_TEAMMATE = 30;
	
--[[����撲�����ځ�]]

	local targetDist 	= ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
	local role 			= ai:GetTeamOrder(ORDER_TYPE_Role);			--�����̖������擾

	-- �ŏ��ɂ�����Ƃ����҂�
	if ai:IsFinishTimer(0) == true then
		local firstTime = ai:GetRandam_Float(0.0, 1.0)			--�ŏ��̓����o���܂ł̎���
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
	end
	
	--�Ⓤ���T�|�[�g���H
	local NowIwanage = 0<ai:GetTeamRecordCount(COORDINATE_TYPE_UROKOIwaSupport, TARGET_NONE, RANGE_IWANAGE_SUPPORT_TEAMMATE);
	
	--
--~ 	if ( NowIwanage) then
--~ 		--�Ⓤ���ɂ��x���U�����Ȃ̂ŁA�ˌ����͑҂��Ă����B
--~ 		uroko211003Battle_Wait(ai, goal);
	if ( role==ROLE_TYPE_Attack ) then 
		--�U�����B
		uroko211003Battle_AttackRole(ai, goal);
	else
		--���̖����B
		uroko211003Battle_OtherRole(ai, goal);
	end
	
end

---------------------------------------------------------
--  �����ʁF�x���U�����Ȃ̂ŁA�҂��Ă����B
---------------------------------------------------------
function uroko211003Battle_Wait(ai, goal)
	
	--�҂��Ă͂��邯�ǁA�^�[�Q�b�g�ɂ͐��񂵂āA�ӎ����Ă��鎖��`����B
	goal:AddSubGoal(GOAL_COMMON_Wait, 0.1, TARGET_ENE_0);
	
end

---------------------------------------------------------
--  �����ʁF�U�����ȊO�̖��B
---------------------------------------------------------
function uroko211003Battle_OtherRole(ai, goal)
	
--[[����撲�����ځ�]]

	local kd_TIME	= 2;
	local kd_NEAR	= 3;
	local kd_FAR	= 4;
	
	local ta_TIME	= 2;
	local ta_ANGLE	= 30;
	
--[[����撲�����ځ�]]
	
	--������ۂB
	goal:AddSubGoal(GOAL_COMMON_KeepDist, kd_TIME, TARGET_ENE_0, kd_NEAR, kd_FAR, TARGET_ENE_0, true, -1);
	--��荞�݁B
	goal:AddSubGoal(GOAL_COMMON_TurnAround, sw_TIME, TARGET_ENE_0, AI_DIR_TYPE_B, ta_ANGLE, true, true, -1);
	
end

---------------------------------------------------------
--  �����ʁF�U�����B
---------------------------------------------------------
function uroko211003Battle_AttackRole(ai, goal)

	local targetDist 	= ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
	
	local Att3000Per = 0		--�������U���̊m��
	local Att3001Per = 0		--�������U���̊m��
	local AttNormalPer = 100	--�ߋ����U���̊m��	
	local idParam = ai:GetNpcThinkParamID();	--�����i211002�j�Ƒ匕�i211003�j���ʗp
	

	if 		(idParam==211002) then		

		--�����ʂɊm�������߂�
		if targetDist >= 9.0 then
			Att3000Per = 0	
			Att3001Per = 0	
			AttNormalPer = 100
		
		elseif targetDist >= 7.0 then
			Att3000Per = 10
			Att3001Per = 70
			AttNormalPer = 20
		
		elseif targetDist >= 5.0 then
			Att3000Per = 70
			Att3001Per = 25
			AttNormalPer = 5
		
		else
			Att3000Per = 0
			Att3001Per = 0
			AttNormalPer = 100
		
		end

	elseif 	(idParam==211003) then
	
		--�����ʂɊm�������߂�
		if targetDist >= 9.0 then
			Att3000Per = 0	
			Att3001Per = 0	
			AttNormalPer = 100
		
		elseif targetDist >= 7.0 then
			Att3000Per = 20
			Att3001Per = 60
			AttNormalPer = 20
		
		elseif targetDist >= 5.0 then
			Att3000Per = 60
			Att3001Per = 35
			AttNormalPer = 5
		
		else
			Att3000Per = 0
			Att3001Per = 0
			AttNormalPer = 100
		
		end
		
	end

	
	--�ړ�
	uroko211003Battle_Approach( ai, goal, 2);
	
	
	--�ːi�U���ɍœK�Ȋԍ����̏ꍇ�B�B�B
	local rangeJumpAttack_begin = 2;
	local rangeJumpAttack_end 	= 4;
	
	if ( (rangeJumpAttack_begin<targetDist) and (targetDist<rangeJumpAttack_end) ) then
		--��̑O���ɂ�����ːi�U���B
		if ( ai:IsInsideTargetEx(TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 45, 20) ) then
			goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 3);
		end
	else
		uroko211003Battle_Attack(ai, goal)
	end
	
	--�U����n���B
	uroko211003Battle_AfterAttack(ai, goal)
	
end

---------------------------------------------------------
--  �U��
---------------------------------------------------------
function uroko211003Battle_Attack(ai, goal)

	local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
	local idParam = ai:GetNpcThinkParamID();		--�����i211002�j�Ƒ匕�i211003�j���ʗp

	
	if 		(idParam==211002) then		

		if K_fate <= 80 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	elseif 	(idParam==211003) then

		if K_fate <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		end
	end
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function uroko211003Battle_AfterAttack(ai, goal)

	local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
	local SideTime = 0.7							--���ɓ�������
	local BackDist = 1.0							--��ނ��鋗��
	local BackTime = 0.7							--��ނ��鎞��
	local bRight = ai:GetRandam_Int(0,1);			--�E������
	-- ���������ɍ��E�ړ����Ă��钇�Ԃ̐�
	local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);

	--85% ��ċz	--10% �K���ɉ��ɃK�[�h�ړ�	--5% ���ɃK�[�h�ړ�
	if KN_fate <= 85 then
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.2,0.6) ,0,0,0,0)
	elseif KN_fate <= 95 and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, bRight, ai:GetRandam_Int(30,45), true, true ,9910 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, 9910 );				
	end
end

---------------------------------------------------------
--  �ڋ߁B
---------------------------------------------------------
function uroko211003Battle_Approach(ai, goal, dist)
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, dist, TARGET_ENE_0, false, -1 );
end

	
	
--[[*****************************************************
	�S�[���̍X�V�E�I���͂Ȃ��B
*******************************************************]]
function uroko211003Battle_Update(ai, goal)	return GOAL_RESULT_Continue;end
function uroko211003Battle_Terminate(ai, goal)end


--[[*****************************************************
  ���荞��
*******************************************************]]
function uroko211003Battle_Interupt(ai, goal)
	return false;
end


	