-----------------------------------------------------------------------------------------------
--	FaranCIBI500000��p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_FaranCIBI500000_Battle, "FaranCIBI500000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_FaranCIBI500000_Battle, 1 );



---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function FaranCIBI500000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------
local role = ai:GetTeamOrder(ORDER_TYPE_Role);			--�����̖������擾	
local eventNo = ai:GetEventRequest();					--�C�x���g����̃��N�G�X�g�ԍ����擾

local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾
local targethprate = ai:GetHpRate( TARGET_ENE_0 )		--�G�^�[�Q�b�g��HP�������擾
local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂R
local fate4 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂S
local fate5 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂T
	
local waitTime = ai:GetRandam_Float(0.5, 2.0)			--�҂�����

	--�^�C�}�[�O�Ԃ��I�����Ă���΁A������Ƃ܂�
	if ai:IsFinishTimer(0) == true then
		--�����Ń^�C�}�[�O�Ԃ��Z�b�g 9999�b
		ai:SetTimer( 0, 9999.0 );
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(0.0, 1.0), TARGET_ENE_0, 0, 0, 0 );
	end

	--���̏��
	if eventNo == AI_EVENT_Phalanx_Gattai then
		--PC���߂��Ȃ�
		if targetDist <= 4.0 then
			--67���@�˂�
			if fate <= 67 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3030, TARGET_ENE_0, DIST_None, 0);
				goal:AddSubGoal(GOAL_COMMON_Wait, waitTime, TARGET_NONE, 0, 0, 0 );
				
			--3���@�ˌ�
			elseif fate <= 70 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3010, TARGET_ENE_0, DIST_None, 0);
				goal:AddSubGoal(GOAL_COMMON_Wait, waitTime, TARGET_NONE, 0, 0, 0 );
				
			--30���@�ҋ@			
			else
				goal:AddSubGoal(GOAL_COMMON_Wait, waitTime, TARGET_NONE, 0, 0, 0 );
			end
			
		--PC���߂��Ȃ��Ȃ�	
		else
			--21���@�˂�
			if fate <= 21 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3030, TARGET_ENE_0, DIST_None, 0);
				goal:AddSubGoal(GOAL_COMMON_Wait, waitTime, TARGET_NONE, 0, 0, 0 );
				
			--4���@�ˌ�
			elseif fate <= 25 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3010, TARGET_ENE_0, DIST_None, 0);
				goal:AddSubGoal(GOAL_COMMON_Wait, waitTime, TARGET_NONE, 0, 0, 0 );
				
			--75%�@�ҋ@
			else
				goal:AddSubGoal(GOAL_COMMON_Wait, waitTime, TARGET_NONE, 0, 0, 0 );
			end
			
		end	
		
	--���U���
	else
		--�U�����A���̑����Ȃ�
		if role == ROLE_TYPE_Attack or role == ROLE_TYPE_None then
			goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, 0.5, 3.0, TARGET_ENE_0, true, -1 );
			FaranCIBI500000Battle_Tukisasi(ai, goal)
			
		--��芪�����Ȃ�
		elseif role == ROLE_TYPE_Torimaki then
			--10���������@75���ڋ߂��ē˂��@15���������Ȃ�
			if fate <= 10 then
				goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, 3.0, 10.0, TARGET_ENE_0, true, -1 );
				FaranCIBI500000Battle_Syasyutu(ai, goal)
			elseif fate <= 85 then
				goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, 0.5, 3.0, TARGET_ENE_0, true, -1 );
				FaranCIBI500000Battle_Tukisasi(ai, goal)
			else
				goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(0.5, 2.0), TARGET_NONE, 0, 0, 0 );
			end
			
		--�ϏO���Ȃ�
		else
			--4���������@16���ڋ߂��ē˂��@80���������Ȃ�
			if fate <= 4 then
				goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, 3.0, 10.0, TARGET_ENE_0, true, -1 );
				FaranCIBI500000Battle_Syasyutu(ai, goal)
			elseif fate <= 20 then
				goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, 0.5, 3.0, TARGET_ENE_0, true, -1 );
				FaranCIBI500000Battle_Tukisasi(ai, goal)
			else
				goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(0.5, 2.0), TARGET_NONE, 0, 0, 0 );
			end
		end
	end
end


-----------------------------------
--���œ˂��h��
-----------------------------------
function FaranCIBI500000Battle_Tukisasi(ai, goal )

local T_fate = ai:GetRandam_Int(1,100)
local SideTime = 3.0							--���ɓ�������
local BackDist = 2.5							--��ނ��鋗��
local BackTime = 3.0							--��ނ��鎞��
local bRight = ai:GetRandam_Int(0,1);			--�E������

	--3030�ōU��
	goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3030, TARGET_ENE_0, DIST_Middle, 0);
	
	--60% �Ȃɂ����Ȃ��i������Ƒ҂j	--30% �K���ɉ��Ɉړ�	--10% ���Ɉړ�
	if T_fate <= 60 then
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(0.5, 2.0), TARGET_NONE, 0, 0, 0 );
	elseif T_fate <= 90  then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, bRight, ai:GetRandam_Int(30,45), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end

end

-------------------------------------------
--���ˏo
-------------------------------------------
function FaranCIBI500000Battle_Syasyutu(ai, goal)

local S_fate = ai:GetRandam_Int(1,100)
local SideTime = 3.0							--���ɓ�������
local BackDist = 2.5							--��ނ��鋗��
local BackTime = 3.0							--��ނ��鎞��
local bRight = ai:GetRandam_Int(0,1);			--�E������

	--3010�ōU�����āA�����x��
	goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3010, TARGET_ENE_0, DIST_Far, 0);
	goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(0.5, 2.0), TARGET_NONE, 0, 0, 0 );
	
	--70% �Ȃɂ����Ȃ��i������Ƒ҂j	--30% �K���ɉ��Ɉړ�	--0% ���Ɉړ�
	if S_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(0.5, 2.0), TARGET_NONE, 0, 0, 0 );
	elseif S_fate <= 100  then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, bRight, ai:GetRandam_Int(30,45), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end



---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function FaranCIBI500000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function FaranCIBI500000Battle_Terminate(ai, goal)
end




-- ���荞�݂Ȃ��錾
-- ���ꂪtrue�̏ꍇ�ɂ͊��荞�݂��Ă΂�Ȃ��̂Œ��ӂ��Ă��������B
REGISTER_GOAL_NO_INTERUPT(GOAL_FaranCIBI500000_Battle, true);
---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function FaranCIBI500000Battle_Interupt(ai, goal)

return false;

end
