-----------------------------------------------------------------------------------------------
--	Mukade507000��p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Mukade507000_Battle, "Mukade507000Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Mukade507000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function Mukade507000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋���
local fate = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐����@���̂Q
local maai = ai:GetRandam_Float(0.75, 1.5)				--�ԍ����������鋗��

local farDist = 10.0		--�����Ɣ��f���鋗��
local nearDist = 6.0		--�߂��Ɣ��f���鋗��
local maaiDist = 1.5		--�U���̂��߂ɋ߂Â������@���ėp���ׁ̈A�U�����Ƃɕ�������

	-- �ŏ��ɂ�����Ƃ����҂�
	if ai:IsFinishTimer(0) == true then
		local firstTime = ai:GetRandam_Float(0.0, 1.0)			--�ŏ��̓����o���܂ł̎���
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
		ai:SetTimer( 0, 9999.0 );
	end

	--�߂��Ȃ��Ȃ�
	if targetDist >= nearDist then
		--75���@����ڋ�
		--25���@�ҋ@
		if fate < 75 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
		else
			goal:AddSubGoal(GOAL_COMMON_Wait,2.0,TARGET_ENE_0, 0, 0, 0 );
		end
		
	--�߂��Ȃ�
	elseif targetDist >= maaiDist then
		--60���@����ڋ߁��Đڋ߁@�@40���@����ɐڋ߁��U���
		if fate < 60 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
			if fate2 < 50 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
			end
		else
			goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, maaiDist, nearDist, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3001, TARGET_ENE_0, DIST_Near, 0);
		end
		
	else
	--�ԍ����ȓ��Ȃ�
		--�U������
		--�U����s��
		Mukade507000Battle_Kougeki(ai, goal)
		Mukade507000Battle_Kougeki_Noato(ai, goal)
	end
end

---------------------------------------------------------
--  �U��
---------------------------------------------------------
function Mukade507000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--100% 3000�@�U��
	if (K_fate < 80) and not((AI_EVENT_MUKADE_TALE_CUT==ai:GetEventRequest(0)) )  then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Near, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
	end
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function Mukade507000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local SideTime = 0.0							--���ɓ�������
local BackDist = ai:GetRandam_Float(0.5, 1.0)	--��ނ��鋗��
local BackTime = 1.0							--��ނ��鎞��


local bRight = ai:GetRandam_Int(0,1);							--���E�ړ��̕���
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- ���������ɍ��E�ړ����Ă��钇�Ԃ̐�


	--50% �Ȃɂ����Ȃ��i������Ƃ������ړ��j
	--50% �ԍ����܂Őڋ�
	--0% ���Ɉړ�
	if KN_fate < 50  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
	elseif KN_fate < 100  and friendNum < 1 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end



---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function Mukade507000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function Mukade507000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function Mukade507000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);				--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐���
local maaiDist = 1.0										--�U���̂��߂ɋ߂Â������@���ėp���ׁ̈A�U�����Ƃɕ�������

	--��U��ǂ�����
	--25���@�߂��̃^�[�Q�b�g����U�肵����U��
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < maaiDist then
			if fate <= 25 then
				goal:ClearSubGoal();
				Mukade507000Battle_Kougeki(ai, goal)
				Mukade507000Battle_Kougeki_Noato(ai, goal)
				return true;
			end	
		end
	end

return false;

end
