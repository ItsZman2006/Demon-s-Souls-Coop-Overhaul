-----------------------------------------------------------------------------------------------
--	�y�z�ꕺ�m�i�Z���j�z�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_DoreiTANKEN200000_Battle, "doreiTANKEN200000Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_DoreiTANKEN200000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function doreiTANKEN200000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------


local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂R
local fate4 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂S
local fate5 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂T

local eventNo = ai:GetEventRequest();					--�C�x���g����̃��N�G�X�g�ԍ����擾
local role = ai:GetTeamOrder(ORDER_TYPE_Role);			--�����̖������擾


	--�����h�����q�ǂ����ݍs���i�C�x���g�p�j
	--�Њd����������
	if eventNo == AI_EVENT_DOREI_IKAKU then
		--100���E�ցA���ցA�Њd
		--25���Њd
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 4.0, TARGET_EVENT, 0, ai:GetRandam_Int(15), true, true ,-1 );
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 4.0, TARGET_EVENT, 1, ai:GetRandam_Int(15), true, true ,-1 );
		goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0, 7000, TARGET_EVENT, DIST_None, 0);
		if fate <= 25 then
			goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0, 7000, TARGET_EVENT, DIST_None, 0);
		end
		
		
	--�Њd���ł͂Ȃ�������
	else
		--�U�����A���̑����Ȃ�
		if role == ROLE_TYPE_Attack or role == ROLE_TYPE_None then
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
			
			--�ړ����U��
			if fate <= Att3300Per then
				goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 6.7, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_None, 0);
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_None, 0);
				
			elseif fate <= (Att3300Per + Att3003Per) then	
				goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 4.7, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_None, 0);
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_None, 0);
				
			elseif fate <= (Att3300Per + Att3003Per + Att3004Per) then		
				goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 2.8, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_None, 0);
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_None, 0);
				
			else
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 1.3, TARGET_ENE_0, true, -1 );
				doreiTANKEN200000Battle_Kougeki(ai, goal)
				
			end
			doreiTANKEN200000Battle_Kougeki_Noato(ai, goal)	
			
		--��芪�����Ȃ�
		elseif role == ROLE_TYPE_Torimaki then
			--������΁A�����ċ߂Â��Ă���
			if targetDist >= 15.0 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 4.5, TARGET_ENE_0, false, -1 );
			--�߂���΁A�����ċ߂Â��Ă���
			elseif targetDist >= 6.0 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 4.5, TARGET_ENE_0, true, -1 );
			--�K�x�ȋ����Ȃ�΁A���ɓ���
			elseif targetDist >= 3.0 then
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,9910 );
			--�߂�����΁A�����
			else
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, true, 9910 );
			end
			--�U������ۂ��E���E��
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,9910 );
			
		--�ϏO���Ȃ�
		else
			--������΁A�����ċ߂Â��Ă���
			if targetDist >= 15.0 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 6.5, TARGET_ENE_0, false, -1 );
			--�߂���΁A�����ċ߂Â��Ă���
			elseif targetDist >= 8.0 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 6.5, TARGET_ENE_0, true, -1 );
			--�K�x�ȋ����Ȃ�΁A���ɓ���
			elseif targetDist >= 4.0 then
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,9910 );
			--�߂�����΁A�����
			else
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 6.0, TARGET_ENE_0, true, 9910 );
			end
			--�U������ۂ��E���E��
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,9910 );
		end
	end
end

---------------------------------------------------------
--  �U��
---------------------------------------------------------
function doreiTANKEN200000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--15% 3002
	--30% 3001-3000
	--15% 3001-3002
	--40% 3000-3006
	if K_fate <= 15 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 45 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 60 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3006, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function doreiTANKEN200000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local SideTime = 5.0							--���ɓ�������
local BackDist = 2.5							--��ނ��鋗��
local BackTime = 5.0							--��ނ��鎞��
local bRight = ai:GetRandam_Int(0,1);			--�E������
-- ���������ɍ��E�ړ����Ă��钇�Ԃ̐�
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);

	--85% ��ċz
	--10% �K���ɉ��ɃK�[�h�ړ�
	--5% ���ɃK�[�h�ړ�
	if KN_fate <= 85 then
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.5,1.0) ,0,0,0,0)
	elseif KN_fate <= 95 and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, bRight, ai:GetRandam_Int(30,45), true, true ,9910 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, 9910 );				
	end
end

	
	
---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function doreiTANKEN200000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function doreiTANKEN200000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function doreiTANKEN200000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂Q

	--�K�[�h���󂵂���U���@�����ʊ֐�
local guardBreakConutDist = 5.0			--�K�[�h����ōU�����鋗��
local guardBreakConutPer = 65			--�K�[�h����ōU������m��
	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
		goal:ClearSubGoal();
		
		--�����ʂɑΉ�
		if targetDist >= 3.0 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_None, 0);
			
		elseif targetDist >= 2.0 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_None, 0);
			
		else
			if fate <= 50 then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3006, TARGET_ENE_0, DIST_Middle, 0);
			end
			
		end
		doreiTANKEN200000Battle_Kougeki_Noato(ai, goal)
		return true;
	end	
	
	
	--�R���{����@�����ʊ֐�
local combRunDist = 1.3				--�R���{���ꂷ�鋗��
local combRunPer = 75				--�R���{���ꂷ��m��
	if Damaged_Act(ai, goal, combRunDist, combRunPer ) then
		goal:ClearSubGoal();
		doreiTANKEN200000Battle_Kougeki(ai, goal)
		doreiTANKEN200000Battle_Kougeki_Noato(ai, goal)
		return true;
	end	

	
return false;
end


	