-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
--	Huhai210002��p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Huhai210002_Battle, "Huhai210002Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Huhai210002_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function Huhai210002Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋���
local fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂R
local sekkin = ai:GetRandam_Float(2, 3.5)		--�ڋ߂��鋗��
local maai = ai:GetRandam_Float(2, 3.5)			--�ԍ����������鋗��

local farDist = 10.0		--�����Ɣ��f���鋗��
local nearDist = 7.0		--�߂��Ɣ��f���鋗��
local maaiDist = 3.2		--�U���̂��߂ɋ߂Â�����
local pushDist = 1.0		--�˂����Ƃ�����

	-- �ŏ��ɂ�����Ƃ����҂�
	if ai:IsFinishTimer(0) == true then
		local firstTime = ai:GetRandam_Float(0.0, 0.1)			--�ŏ��̓����o���܂ł̎���
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
		ai:SetTimer( 0, 9999.0 );
	end

	--�����Ȃ�
	if targetDist >= nearDist then
		--10���@�����ڋ�
		--35���@�������瑖��ڋ�
		--55���@����ڋ�
		if fate < 10 then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
		elseif fate < 45 then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, (targetDist - 3.0), TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );			
		else
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
		end
		
	--�߂��Ȃ�
	elseif targetDist >= maaiDist then
		--60���@�����ڋ߁���荞�݁��Đڋ߁@40���@�}�ڋ߁�50%���˂�50%�˂� 
		if fate < 60 then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			if fate2 < 50 then
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 1.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
				goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			end
		else
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
--~ 			goal:AddSubGoal(GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, maaiDist, nearDist, TARGET_ENE_0, false, -1 );
			if fate2 < 50 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3002, TARGET_ENE_0, DIST_Near, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
			end
		end
		
	--���߂Ȃ�
	elseif targetDist <= pushDist then
		--40% �˂����Ƃ��U�����Č��ɉ�����@60% �@�����Č��ɉ�����@�i���������瑊��ɐ���j
		if fate < 40 then
			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3003, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, true, -1 );
--~ 			goal:AddSubGoal(GOAL_COMMON_Turn, 3.0, TARGET_ENE_0 );
		else
			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3001, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, 4.0, TARGET_E, true, -1 );
--~ 			goal:AddSubGoal(GOAL_COMMON_Turn, 3.0, TARGET_ENE_0 );
		end
		
	else
	--�ԍ����ȓ��Ȃ�
		--�U������
		--�U����s��
		Huhai210002Battle_Kougeki(ai, goal)
		Huhai210002Battle_Kougeki_Noato(ai, goal)
	end
end

---------------------------------------------------------
--  �U��
---------------------------------------------------------
function Huhai210002Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--45% 3000�@�˂�
	--10% 3000-3001�@�˂����@������
	--40% 3002�@2��˂�
	--05% 3003�@�˂����Ƃ�
	if K_fate < 25 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
	elseif K_fate < 75 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Near, 0);
	elseif K_fate < 95 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Near, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Near, 0);
	end
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function Huhai210002Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local SideTime = 0.1							--���ɓ�������
local BackDist = ai:GetRandam_Float(3.0, 4.5)	--��ނ��鋗��
local BackTime = 1.5							--��ނ��鎞��


local bRight = ai:GetRandam_Int(0,1);							--���E�ړ��̕���
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- ���������ɍ��E�ړ����Ă��钇�Ԃ̐�



--���ɉ���������ɂƂ��ǂ����ړ�������Ɨǂ�����
--���܂�ɋ߂����鉡�ړ������A�������������Ă��牡�ړ�������Ɨǂ�����

	--10% �Ȃɂ����Ȃ��i������Ƃ������ړ��j
	--20% �K���ɉ��Ɉړ�
	--70% ���Ɉړ�
	if KN_fate < 10  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 1.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 10, true, true ,-1 );
	elseif KN_fate < 30  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
	else
		goal:AddSubGoal(GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );
--~ 		goal:AddSubGoal(GOAL_COMMON_Turn, 3.0, TARGET_ENE_0 );
	end
end



---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function Huhai210002Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function Huhai210002Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function Huhai210002Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐���
local maaiDist = 1.0										--�U���̂��߂ɋ߂Â������@���ėp���ׁ̈A�U�����Ƃɕ�������

	--��U��ǂ�����
	--25���@�߂��̃^�[�Q�b�g����U�肵����U��
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < maaiDist then
			if fate <= 25 then
				goal:ClearSubGoal();
				Huhai210002Battle_Kougeki(ai, goal)
				Huhai210002Battle_Kougeki_Noato(ai, goal)
				return true;
			end	
		end
	end

return false;

end

