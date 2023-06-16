-----------------------------------------------------------------------------------------------
--	Huhai210000��p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Huhai210000_Battle, "Huhai210000Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Huhai210000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function Huhai210000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋���
local fate = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐����@���̂R
local sekkin = ai:GetRandam_Float(0.75, 1.5)			--�ڋ߂��鋗��
local maai = ai:GetRandam_Float(0.75, 1.5)				--�ԍ����������鋗��
local rate = ai:GetHpRate( TARGET_SELF )				--������HP
local idParam = ai:GetNpcThinkParamID();				--NPC��ID���擾

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
		--60���@�����ڋ߁���荞�݁��Đڋ߁@�@40���@�����ۂ�70%�ːi�̓�����30%�U���i���j�
		if fate < 60 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			if fate2 < 20 then
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(10,20), true, true ,-1 );
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			end
		else
			goal:AddSubGoal( GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, 3.0, 5.0, TARGET_ENE_0, false, -1 );
			if fate2 < 70 then
				if 		(idParam==210004) then		
					goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3004, TARGET_ENE_0, DIST_Near, 0);
				end
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
			end
		end
		
	else
	--�ԍ����ȓ��Ȃ�
		--�U������
		--�U����s��
		Huhai210000Battle_Kougeki(ai, goal)
		Huhai210000Battle_Kougeki_Noato(ai, goal)
	end
end

---------------------------------------------------------
--  �U��
---------------------------------------------------------
function Huhai210000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local rate = ai:GetHpRate( TARGET_SELF )
local idParam = ai:GetNpcThinkParamID();				--NPC��ID���擾

	--20% 3000�@�U���i���j�iHP��50%�ȉ��Ȃ�ːi�̓�����j
	--10% 3003�@�˂����Ƃ�
	--15% 3004�@�ːi�̓�����
	--20% 3000-3001�@�U���i���j���U���i���j�
	--15% 3002�@�\���
	--20% 3300�@����U��
	if K_fate < 20 then
		if rate < 0.5 then
			if 		(idParam==210004) then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Near, 0);
			end
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		end
	elseif K_fate < 30 then
		if 		(idParam==210004) then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Near, 0);
		end
	elseif K_fate < 45 then
		if 		(idParam==210004) then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Near, 0);
		end
	elseif K_fate < 65 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Near, 0);
	elseif K_fate < 80 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Near, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Near, 0);
	end
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function Huhai210000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local SideTime = 0.5							--���ɓ�������
local BackDist = ai:GetRandam_Float(0.25, 1.0)	--��ނ��鋗��
local BackTime = 0.5							--��ނ��鎞��


local bRight = ai:GetRandam_Int(0,1);							--���E�ړ��̕���
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- ���������ɍ��E�ړ����Ă��钇�Ԃ̐�



--���ɉ���������ɂƂ��ǂ����ړ�������Ɨǂ�����
--���܂�ɋ߂����鉡�ړ������A�������������Ă��牡�ړ�������Ɨǂ�����

	--25% �Ȃɂ����Ȃ��i������Ƃ������ړ��j
	--50% �K���ɉ��Ɉړ�
	--25% ���Ɉړ�
	if KN_fate < 25  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 0.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 10, true, true ,-1 );
	elseif KN_fate < 75  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end



---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function Huhai210000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function Huhai210000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function Huhai210000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐���
local maaiDist = 1.0										--�U���̂��߂ɋ߂Â������@���ėp���ׁ̈A�U�����Ƃɕ�������

	--��U��ǂ�����
	--25���@�߂��̃^�[�Q�b�g����U�肵����U��
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < maaiDist then
			if fate <= 25 then
				goal:ClearSubGoal();
				Huhai210000Battle_Kougeki(ai, goal)
				Huhai210000Battle_Kougeki_Noato(ai, goal)
				return true;
			end	
		end
	end

return false;

end










--[[************************************************************************************************************]]
--[[**************************************** ���s�l�T�u�S�[�� **************************************************]]
--[[************************************************************************************************************]]



--[[*******************************************************************************************
	���s�l�p�҂��S�[���B
	�����F
		���s�l�p�̑ҋ@���ɍs���A�N�V�����������B
		�҂����̃����_�����͂����ŁB
		
	�p�����[�^0  �Ȃ��B
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Huhai_COMMON_Wait, "HUHAIWait");
REGISTER_GOAL_NO_UPDATE( GOAL_Huhai_COMMON_Wait, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_Huhai_COMMON_Wait, true);

--[[*****************************************************
	�S�[���N��
*******************************************************]]
function HUHAIWait_Activate(ai, goal)

	--�p�����[�^ID�ŁA�ω���������;
	local idParam 	= ai:GetNpcThinkParamID();
	local ezStateNo	= 0;

	
	if 		(idParam==211000) then		ezStateNo	= 3300; --�s�b�P��
	elseif 	(idParam==211001) then		ezStateNo	= 3301;	--��
	elseif 	(idParam==211002) then		ezStateNo	= 3302;	--����
	elseif 	(idParam==211003) then		ezStateNo	= 3302;	--�匕
	elseif 	(idParam==211004) then		ezStateNo	= 0;	--�S�N���艺
	end


	--�A�N�V�����O�A�ԁB
	local wait_time = ai:GetRandam_Float( 0.5, 2.5);
	goal:AddSubGoal( GOAL_COMMON_Wait, wait_time, TARGET_NONE);
	
	--�܂��A�N�V�����B
	if ( 0<ezStateNo) then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 100, ezStateNo, TARGET_NONE, DIST_None);
	end
	
end

--[[*****************************************************
	�S�[���X�V�E�I���E���荞�݂��s��Ȃ��B
*******************************************************]]
function HUHAIWait_Update(ai, goal) return GOAL_RESULT_Continue; end
function HUHAIWait_Terminate(ai, goal) end
function HUHAIWait_Interupt(ai, goal) return false; end





			


