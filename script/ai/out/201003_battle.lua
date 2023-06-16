-----------------------------------------------------------------------------------------------
--	��ʕ��m�i�{�E�K���j�@�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_IppanBOU201003_Battle, "ippanBOU201003Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_IppanBOU201003_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function ippanBOU201003Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);				--�G�^�[�Q�b�g�Ƃ̋������擾
local hprate = ai:GetHpRate( TARGET_SELF )					--������HP�������擾

local fate = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐����@���̂R
local fate4 = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐����@���̂S

local myThinkId = ai:GetNpcThinkParamID()		--�v�lID���擾
local myBlockId = ai:GetMyBlockID();			--�����̂���u���b�N

	--�ŏ�����������Ƒ҂�
	if ai:IsFinishTimer(0) == true then
		local firstTime = ai:GetRandam_Float(0.0,2.0)					--�ŏ��̓����o���܂ł̎���
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
		ai:SetTimer( 0, 9999.0 );
	end
	
	--�G�^�[�Q�b�g���R���ȓ��̂Ƃ��A�����Ă����ڎU�ɓ�����
	if targetDist <= 3.0 then
		if myThinkId == 201012 then
			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
		else
			if fate <= 60 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3001, TARGET_ENE_0, DIST_None, 0);
			end
		end
		
		if myThinkId == 602 or myThinkId == 200011 or myThinkId == 201003 then		
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 10.0, TARGET_SELF, false, -1 );
		else
			goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (1.0,2.0) ,0,0,0,0)		
			
		end
		
	--�G�^�[�Q�b�g���P�Q���ȓ��̂Ƃ��A�����Ă��班��������
	elseif targetDist <= 12.0 then
		if myThinkId == 201012 then
			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
		else
			if fate <= 60 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3001, TARGET_ENE_0, DIST_None, 0);
			end
		end
		
		if myThinkId == 602 or myThinkId == 200011 or myThinkId == 201003 then
			goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (2.0,4.0) ,0,0,0,0)		
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, 20.0, TARGET_ENE_0, true, -1 );
		else
			goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (2.0,4.0) ,0,0,0,0)		
			
		end
		
	--�����Ɨ���Ă���Ƃ�
	else
		if myThinkId == 201012 then
			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
			if fate2 <= 20 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
			end
			
		else
			if fate <= 60 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
				if fate2 <= 20 then
					goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
				end
				
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3001, TARGET_ENE_0, DIST_None, 0);
			end
		end
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (3.0,6.0) ,0,0,0,0)
		
	end

	--�g�o�������Ă�����A���m���ŉ񕜖���g��
	if (hprate <= 0.4) and (fate <= 50) and (myBlockId == 1 or myBlockId == 2 or myBlockId == 3) then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6200, TARGET_ENE_0, DIST_Far, 0);
	end	
	
end
	



---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function ippanBOU201003Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function ippanBOU201003Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function ippanBOU201003Battle_Interupt(ai, goal)

	return false;
end
