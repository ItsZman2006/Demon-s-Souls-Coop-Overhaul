-----------------------------------------------------------------------------------------------
--	Daihuhai210100��p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Daihuhai210100_Battle, "Daihuhai210100Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Daihuhai210100_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function Daihuhai210100Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋���
local fate = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐����@���̂R
local sekkin = ai:GetRandam_Float(0.75, 1.5)			--�ڋ߂��鋗��
local maai = ai:GetRandam_Float(0.75, 1.5)				--�ԍ����������鋗��
local rate = ai:GetHpRate( TARGET_SELF )				--������HP

local farDist = 10.0		--�����Ɣ��f���鋗��
local nearDist = 5.0		--�߂��Ɣ��f���鋗��
local maaiDist = 3.0		--�U���̂��߂ɋ߂Â������@���ėp���ׁ̈A�U�����Ƃɕ�������

	-- �ŏ��ɂ�����Ƃ����҂�
	if ai:IsFinishTimer(0) == true then
		local firstTime = ai:GetRandam_Float(0.0, 2.0)			--�ŏ��̓����o���܂ł̎���
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
		ai:SetTimer( 0, 9999.0 );
	end

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
		--50�� �����ڋ߁���荞�݁��Đڋ�
		--20�� �����ۂ�
		--30�� �ҋ@
		if fate < 50 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );

			if fate2 < 20 then
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(10,20), true, true ,-1 );
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			end
			
		elseif fate < 70 then
			goal:AddSubGoal( GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, maaiDist, nearDist, TARGET_ENE_0, false, -1 );
			
		else
			goal:AddSubGoal( GOAL_COMMON_Wait, 2.4, TARGET_ENE_0);
		
		end
		
	else
	--�ԍ����ȓ��Ȃ�
		--�U������
		--�U����s��
		Daihuhai210100Battle_Kougeki(ai, goal)
		Daihuhai210100Battle_Kougeki_Noato(ai, goal)
	end
end

---------------------------------------------------------
--  �U��
---------------------------------------------------------
function Daihuhai210100Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���


	--50% 3000�@�Ȃ�����
	--50% 3001�@�U�艺�낵
	if K_fate < 50 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Near, 0);
	end
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function Daihuhai210100Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local SideTime = 3.5							--���ɓ�������
local BackDist = ai:GetRandam_Float(1.0, 2.0)	--��ނ��鋗��
local BackTime = 3.5							--��ނ��鎞��


local bRight = ai:GetRandam_Int(0,1);							--���E�ړ��̕���
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- ���������ɍ��E�ړ����Ă��钇�Ԃ̐�



--���ɉ���������ɂƂ��ǂ����ړ�������Ɨǂ�����
--���܂�ɋ߂����鉡�ړ������A�������������Ă��牡�ړ�������Ɨǂ�����

	--25% �K���ɉ��Ɉړ�
	--50% �K���ɉ��Ɉړ�
	--25% ���Ɉړ�
	if KN_fate < 25  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.6, TARGET_ENE_0, ai:GetRandam_Int(0,1), 10, true, true ,-1 );
	elseif KN_fate < 75  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end



---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function Daihuhai210100Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function Daihuhai210100Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function Daihuhai210100Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐���
local maaiDist = 1.0										--�U���̂��߂ɋ߂Â������@���ėp���ׁ̈A�U�����Ƃɕ�������

	--��U��ǂ�����
	--25���@�߂��̃^�[�Q�b�g����U�肵����U��
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < maaiDist then
			if fate <= 25 then
				goal:ClearSubGoal();
				Daihuhai210100Battle_Kougeki(ai, goal)
				Daihuhai210100Battle_Kougeki_Noato(ai, goal)
				return true;
			end	
		end
	end

return false;

end

