-----------------------------------------------------------------------------------------------
--	�R�p���p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Gunyou301000_Battle, "gunyou301000Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Gunyou301000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function gunyou301000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾
local targethprate = ai:GetHpRate( TARGET_ENE_0 )		--�G�^�[�Q�b�g��HP�������擾
local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)							--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)							--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)							--�m������Ŏg�p����^���̐����@���̂R
local fate4 = ai:GetRandam_Int(1,100)							--�m������Ŏg�p����^���̐����@���̂S

local role = ai:GetTeamOrder(ORDER_TYPE_Role);					--�����̖������擾
local bRight = ai:GetRandam_Int(0,1);							--���E�ړ��̕���
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- ���������ɍ��E�ړ����Ă��钇�Ԃ̐�

local Att3000_Dist_min = 0.5					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 2.2					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3001_Dist_min = 0.0					--3001�Ԃ̓K���ԍ����i�ŏ��j
local Att3001_Dist_max = 0.5					--3001�Ԃ̓K���ԍ����i�ő�j
local Att3300_Dist_min = 2.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
local Att3300_Dist_max = 4.3					--3300�Ԃ̓K���ԍ����i�ő�j
local Att3301_Dist_min = 2.0					--3301�Ԃ̓K���ԍ����i�ŏ��j
local Att3301_Dist_max = 6.4					--3301�Ԃ̓K���ԍ����i�ő�j
local Att3302_Dist_min = 4.0					--3302�Ԃ̓K���ԍ����i�ŏ��j
local Att3302_Dist_max = 8.4					--3302�Ԃ̓K���ԍ����i�ő�j

local Act01Per = 0		--�_�b�V���ڋ߁��ːi��т�����
local Act02Per = 0		--�_�b�V���ڋ߁���т�����E�W�����v����
local Act03Per = 0		--�_�b�V���ڋ߁���т�����
local Act04Per = 0		--�_�b�V���ڋ߁����݂�	
local Act05Per = 0		--���s�ڋ߁��ːi��т�����
local Act06Per = 0		--���s�ڋ߁���т�����E�W�����v����
local Act07Per = 0		--���s�ڋ߁���т�����
local Act08Per = 0		--���s�ڋ߁����݂�	
local Act09Per = 0		--�_�b�V���ŗ����	


	--�_�b�V�����ːi��т�����@���Ă��ǂ����x�ɉ����Ȃ�	
	if targetDist >= 11.4 then	
		Act01Per = 75		--�_�b�V���ڋ߁��ːi��т�����
		Act02Per = 15		--�_�b�V���ڋ߁���т�����E�W�����v����
		Act03Per = 10		--�_�b�V���ڋ߁���т�����
		Act04Per = 0		--�_�b�V���ڋ߁����݂�	
		Act05Per = 0		--���s�ڋ߁��ːi��т�����
		Act06Per = 0		--���s�ڋ߁���т�����E�W�����v����
		Act07Per = 0		--���s�ڋ߁���т�����
		Act08Per = 0		--���s�ڋ߁����݂�
		Act09Per = 0		--�_�b�V���ŗ����	
		
	--�_�b�V������т�����E�W�����v�����@���Ă��ǂ����x�ɉ����Ȃ�		
	elseif targetDist >= 8.4 then	
		Act01Per = 0		--�_�b�V���ڋ߁��ːi��т�����
		Act02Per = 50		--�_�b�V���ڋ߁���т�����E�W�����v����
		Act03Per = 15		--�_�b�V���ڋ߁���т�����
		Act04Per = 5		--�_�b�V���ڋ߁����݂�	
		Act05Per = 30		--���s�ڋ߁��ːi��т�����
		Act06Per = 0		--���s�ڋ߁���т�����E�W�����v����
		Act07Per = 0		--���s�ڋ߁���т�����
		Act08Per = 0		--���s�ڋ߁����݂�
		Act09Per = 0		--�_�b�V���ŗ����	
		
	--�_�b�V������т�����@���Ă��ǂ����x�ɉ����Ȃ�		
	elseif targetDist >= 6.3 then	
		Act01Per = 0		--�_�b�V���ڋ߁��ːi��т�����
		Act02Per = 0		--�_�b�V���ڋ߁���т�����E�W�����v����
		Act03Per = 35		--�_�b�V���ڋ߁���т�����
		Act04Per = 5		--�_�b�V���ڋ߁����݂�	
		Act05Per = 50		--���s�ڋ߁��ːi��т�����
		Act06Per = 10		--���s�ڋ߁���т�����E�W�����v����
		Act07Per = 0		--���s�ڋ߁���т�����
		Act08Per = 0		--���s�ڋ߁����݂�
		Act09Per = 0		--�_�b�V���ŗ����	
		
	--���s���ːi��т�����@����с@�_�b�V�������݂��@���Ă��ǂ����x�ɉ����Ȃ�		
	elseif targetDist >= 4.0 then	
		Act01Per = 0		--�_�b�V���ڋ߁��ːi��т�����
		Act02Per = 0		--�_�b�V���ڋ߁���т�����E�W�����v����
		Act03Per = 0		--�_�b�V���ڋ߁���т�����
		Act04Per = 20		--�_�b�V���ڋ߁����݂�	
		Act05Per = 50		--���s�ڋ߁��ːi��т�����
		Act06Per = 20		--���s�ڋ߁���т�����E�W�����v����
		Act07Per = 10		--���s�ڋ߁���т�����
		Act08Per = 0		--���s�ڋ߁����݂�
		Act09Per = 0		--�_�b�V���ŗ����	
		
	--���s����т�����E�W�����v�����@���Ă��ǂ����x�ɋ߂��Ȃ�	
	elseif targetDist >= 2.0 then	
		Act01Per = 0		--�_�b�V���ڋ߁��ːi��т�����
		Act02Per = 0		--�_�b�V���ڋ߁���т�����E�W�����v����
		Act03Per = 0		--�_�b�V���ڋ߁���т�����
		Act04Per = 0		--�_�b�V���ڋ߁����݂�	
		Act05Per = 0		--���s�ڋ߁��ːi��т�����
		Act06Per = 50		--���s�ڋ߁���т�����E�W�����v����
		Act07Per = 40		--���s�ڋ߁���т�����
		Act08Per = 10		--���s�ڋ߁����݂�
		Act09Per = 0		--�_�b�V���ŗ����			
		
	--�����Ƌ߂��Ȃ�	
	else
		Act01Per = 0		--�_�b�V���ڋ߁��ːi��т�����
		Act02Per = 0		--�_�b�V���ڋ߁���т�����E�W�����v����
		Act03Per = 0		--�_�b�V���ڋ߁���т�����
		Act04Per = 0		--�_�b�V���ڋ߁����݂�	
		Act05Per = 0		--���s�ڋ߁��ːi��т�����
		Act06Per = 0		--���s�ڋ߁���т�����E�W�����v����
		Act07Per = 0		--���s�ڋ߁���т�����
		Act08Per = 70		--���s�ڋ߁����݂�
		Act09Per = 30		--�_�b�V���ŗ����		
	end

	--�s��01�@�_�b�V���ڋ߁��ːi��т�����	
	if fate2 <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3302_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3302, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_Attack2, 5.0, 3302, TARGET_ENE_0, DIST_Near, 0);
		if fate3 <= 5 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		end
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 12.0, TARGET_SELF, false, -1 );
		
		
	--�s��02�@�_�b�V���ڋ߁���т�����E�W�����v����
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3301_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3301, TARGET_ENE_0, DIST_Near, 0);
		if fate3 <= 5 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		end
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 12.0, TARGET_SELF, false, -1 );
		
	--�s��03�@�_�b�V���ڋ߁���т�����
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then	
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3300_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Near, 0);
		if fate3 <= 5 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		end
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 12.0, TARGET_SELF, false, -1 );
		
	--�s��04�@�_�b�V���ڋ߁����݂�	
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		if fate3 <= 20 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		end
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 12.0, TARGET_SELF, false, -1 );		
		
	--�s��05�@���s�ڋ߁��ːi��т�����
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3302_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3302, TARGET_ENE_0, DIST_Near, 0);
		if fate3 <= 5 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		end
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 12.0, TARGET_SELF, false, -1 );	
		
	--�s��06�@���s�ڋ߁���т�����E�W�����v����
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per) then	
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3301_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3301, TARGET_ENE_0, DIST_Near, 0);
		if fate3 <= 5 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		end
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 12.0, TARGET_SELF, false, -1 );
		
	--�s��07�@���s�ڋ߁���т�����
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per) then	
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3300_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Near, 0);
		if fate3 <= 5 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		end
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 12.0, TARGET_SELF, false, -1 );
		
	--�s��08�@���s�ڋ߁����݂�	
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per + Act08Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		if fate3 <= 20 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		end
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 12.0, TARGET_SELF, false, -1 );	
		
	--�s��09�@�_�b�V���ŗ����
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 12.0, TARGET_SELF, false, -1 );	
		
	end
	
end

	
---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function gunyou301000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function gunyou301000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function gunyou301000Battle_Interupt(ai, goal)

return false;
end



	