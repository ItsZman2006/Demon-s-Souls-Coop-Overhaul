-----------------------------------------------------------------------------------------------
--	�f�u�f�[�����p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Debu103000_Battle, "debu103000Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Debu103000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function debu103000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾
local targethprate = ai:GetHpRate( TARGET_ENE_0 )		--�G�^�[�Q�b�g��HP�������擾
local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂R

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂R

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 7.5					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3001_Dist_min = 2.0					--3001�Ԃ̓K���ԍ����i�ŏ��j
local Att3001_Dist_max = 10.2					--3001�Ԃ̓K���ԍ����i�ő�j
local Att3002_Dist_min = 2.5					--3002�Ԃ̓K���ԍ����i�ŏ��j
local Att3002_Dist_max = 9.5					--3002�Ԃ̓K���ԍ����i�ő�j
local Att3300_Dist_min = 1.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
local Att3300_Dist_max = 8.0					--3300�Ԃ̓K���ԍ����i�ő�j
local Att3301_Dist_min = 0.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
local Att3301_Dist_max = 1.5					--3300�Ԃ̓K���ԍ����i�ő�j

local Act01Per = 0		--�ߐڍU��
local Act02Per = 0		--�Ȃ��͂炢
local Act03Per = 0		--�A���U��	
local Act04Per = 0		--���ߍU��
local Act05Per = 0		--���̏�W�����v�U��

	--����Ɖ����Ȃ�
	if targetDist >= 10.2 then
		Act01Per = 5		--�ߐڍU��
		Act02Per = 50		--�Ȃ��͂炢
		Act03Per = 30		--�A���U��	
		Act04Per = 15		--���ߍU��
		Act05Per = 0		--���̏�W�����v�U��
		
	--���ӂȋ����Ȃ�	
	elseif targetDist >= 3.0 then
		Act01Per = 5		--�ߐڍU��
		Act02Per = 30		--�Ȃ��͂炢
		Act03Per = 40		--�A���U��	
		Act04Per = 25		--���ߍU��
		Act05Per = 0		--���̏�W�����v�U��
		
	--�߂��Ȃ�	
	elseif targetDist >= 1.5 then
		Act01Per = 60		--�ߐڍU��
		Act02Per = 20		--�Ȃ��͂炢
		Act03Per = 10		--�A���U��	
		Act04Per = 10		--���ߍU��
		Act05Per = 0		--���̏�W�����v�U��
		
		
	--����Ƌ߂��Ȃ�	
	else	
		Act01Per = 20		--�ߐڍU��
		Act02Per = 10		--�Ȃ��͂炢
		Act03Per = 5		--�A���U��	
		Act04Per = 5		--���ߍU��
		Act05Per = 60		--���̏�W�����v�U��
	end

	--�s��01�@�ߐڍU��
	if fate <= Act01Per then
		goal:AddSubGoal( GOAL_COMMON_KeepDist, 5.0, TARGET_ENE_0, Att3000_Dist_min, Att3000_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��02�@�Ȃ��͂炢
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal( GOAL_COMMON_KeepDist, 5.0, TARGET_ENE_0, Att3001_Dist_min, Att3001_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��03�@�A���U��
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
		goal:AddSubGoal( GOAL_COMMON_KeepDist, 5.0, TARGET_ENE_0, Att3002_Dist_min, Att3002_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��04�@���ߍU��
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
		goal:AddSubGoal( GOAL_COMMON_KeepDist, 5.0, TARGET_ENE_0, Att3300_Dist_min, Att3300_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��05�@���̏�W�����v�U��
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
	end

	debu103000Battle_Kougeki_Noato(ai, goal)
	
end


	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function debu103000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐���
local KN_fate2 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂Q

local SideTime = 3.0							--���ɓ�������
local BackDist = 2.0							--��ނ��鋗��
local BackTime = 3.0							--��ނ��鎞��

	--80���@�������Ȃ�
	--10���@�K���ɉ��Ɉړ�
	--10���@����������
	if KN_fate <= 80 then
		
	elseif KN_fate <= 90 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(20,30), true, true ,-1 );
		
	else
		goal:AddSubGoal(GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );
	end
end



---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function debu103000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function debu103000Battle_Terminate(ai, goal)
end

---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function debu103000Battle_Interupt(ai, goal)
return false;
end
