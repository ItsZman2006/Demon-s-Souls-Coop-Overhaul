-----------------------------------------------------------------------------------------------
--	�E���R�z�v�i�� �E���j�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_urokoF211001_Battle, "urokoF211001_Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_urokoF211001_Battle, true);


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function urokoF211001_Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾
local targethprate = ai:GetHpRate( TARGET_ENE_0 )	--�G�^�[�Q�b�g��HP�������擾
local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q

local farDist = 15.0		--����Ɖ����Ɣ��f���鋗��
local nearDist = 4.0		--�߂��Ɣ��f���鋗��
local maaiDist = 1.5		--�U���̂��߂ɋ߂Â������@���ėp���ׁ̈A�U�����Ƃɕ�������

local role = ai:GetTeamOrder(ORDER_TYPE_Role);					--�����̖������擾


		--�����Ȃ�
		if targetDist >= farDist then
			
			--�ҋ@
			
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 1, TARGET_ENE_0, true, -1 );
			
						
		--�������Ȃ����߂����Ȃ��Ȃ�
		elseif targetDist >= nearDist then
			--�ҋ@
			
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 1, TARGET_ENE_0, true, -1 );
			
		--�߂��Ȃ�	
		elseif targetDist >= maaiDist then
			--�ҋ@
			
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 1, TARGET_ENE_0, true, -1 );
			
		--�ԍ����ȓ��Ȃ�
		else
		    goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 1, TARGET_ENE_0, true, -1 );
			--�U������
			urokoF211001_Battle_Kougeki(ai, goal)
			
			--�U����s��
			urokoF211001_Battle_Kougeki_Noato(ai, goal)
			
		end
	end

---------------------------------------------------------
--  �U��
---------------------------------------------------------
function urokoF211001_Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local myThinkId = ai:GetNpcThinkParamID()		--�v�lID���擾

	--90% 3000
	--10% 3001
	if K_fate < 90 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, AI_DIST_TYPE_Middle, 0);
	else
		if myThinkId == 211001 or myThinkId == 211007 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, AI_DIST_TYPE_Middle, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, AI_DIST_TYPE_Middle, 0);
		end
	end
end

	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function urokoF211001_Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local SideDist = 1.5							--���ɓ�������
local SideTime = 1.0							--���ɓ�������
local BackDist = 1.0							--��ނ��鋗��
local BackTime = 1.0							--��ނ��鎞��
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
function urokoF211001_Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function urokoF211001_Battle_Terminate(ai, goal)
end

---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function urokoF211001_Battle_Interupt(ai, goal)

return false;
end


--[[***********************************************************************************]]
--[[******************************* �T�u�S�[�� ****************************************]]
--[[***********************************************************************************]]

--[[*********************************************************************
	�Ⓤ���B
***********************************************************************]]
REGISTER_GOAL(GOAL_uroko_ThrowRock, "uroko_ThrowRock");
REGISTER_GOAL_NO_UPDATE( GOAL_uroko_ThrowRock, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_uroko_ThrowRock, true);

function uroko_ThrowRock_Activate(ai, goal)

--[[����悳�񒲐����ځ�]]

	local WaitTime_Long				= 3;	--���������_�����B
	local WaitTime_Short			= 1;	--�Z�������_�����B
	local WaitTime_SelectLongRate	= 20;	--���������_������I�����銄���B
	local idParam = ai:GetNpcThinkParamID();
	local fate = ai:GetRandam_Int(1,100)	--�m������Ŏg�p����^���̐���
	
--[[����悳�񒲐����ځ�]]

	--�Ⓤ��(���̏�i53003�A53006�A53011�A53012�j������i53004�A53005�A53013�A53014�j�i���ވقȂ�j�������_���ɓ�����)
	if 		(idParam==211009) then
		if fate < 25 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3004, TARGET_ENE_0, DIST_None);
		elseif fate < 50 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3005, TARGET_ENE_0, DIST_None);
		elseif fate < 75 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3013, TARGET_ENE_0, DIST_None);
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3014, TARGET_ENE_0, DIST_None);
		end
			
	elseif  (idParam==211011) then
		if fate < 25 then
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3004, TARGET_ENE_0, DIST_None);
		elseif fate < 50 then
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3005, TARGET_ENE_0, DIST_None);
		elseif fate < 75 then
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3013, TARGET_ENE_0, DIST_None);
		else
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3014, TARGET_ENE_0, DIST_None);
		end
	
	elseif 	(idParam==211010) then
		goal:AddSubGoal( GOAL_COMMON_Wait, ai:GetRandam_Int(1,3), TARGET_ENE_0);
		if fate < 25 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3003, TARGET_ENE_0, DIST_None);
		elseif fate < 50 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3006, TARGET_ENE_0, DIST_None);
		elseif fate < 75 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3011, TARGET_ENE_0, DIST_None);
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3012, TARGET_ENE_0, DIST_None);
		end
		
	elseif 	(idParam==211012) then
		if fate < 25 then
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3003, TARGET_ENE_0, DIST_None);
		elseif fate < 50 then
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3006, TARGET_ENE_0, DIST_None);
		elseif fate < 75 then
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3011, TARGET_ENE_0, DIST_None);
		else
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3012, TARGET_ENE_0, DIST_None);
		end
		
	end

--~ 	goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3003, TARGET_ENE_0, DIST_None);
	
	
	--������A�҂����ԁB
	
	local wait_time_range	= WaitTime_Short;
	local random_val		= ai:GetRandam_Int( 0, 100);
	if ( random_val < WaitTime_SelectLongRate ) then
		wait_time_range = WaitTime_Long;		--�����҂��B
	else
		wait_time_range = WaitTime_Short;		--�Z���҂��B
	end
	
	--���ۂ̃����_�����ԁB
	local wait_time = ai:GetRandam_Float( wait_time_range*0.5, wait_time_range*1.5);
	
	--
	goal:AddSubGoal( GOAL_COMMON_Wait, wait_time, TARGET_NONE);
	
	--�`�[���ɊⓊ������ʒm�B
	goal:AddGoalScopedTeamRecord(COORDINATE_TYPE_UROKOIwaSupport, TARGET_NONE, 0);
	
end

function uroko_ThrowRock_Update(ai, goal)return GOAL_RESULT_Continue;end
function uroko_ThrowRock_Terminate(ai, goal)end
function uroko_ThrowRock_Interupt(ai, goal)return false;end










