--[[*******************************************************************************************
	Kimera304000��p�퓬
	�����F

	�p�����[�^0  �Ȃ�
	�p�����[�^1  �Ȃ�
	�p�����[�^2  �Ȃ�
	�p�����[�^3�@�Ȃ�
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Kimera304000_Battle, "Kimera304000Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Kimera304000_Battle, 1 );


--[[*****************************************************
	�S�[���N��
*******************************************************]]
function Kimera304000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋���
local fate = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐����@���̂Q
local maai = ai:GetRandam_Float(0.75, 1.5)				--�ԍ����������鋗��

local farDist = 12.0		--�����Ɣ��f���鋗��
local nearDist = 6.0		--�߂��Ɣ��f���鋗��
local maaiDist = 3.1		--�U���̂��߂ɋ߂Â������@���ėp���ׁ̈A�U�����Ƃɕ�������
local skyDist = 1.5			--�󒆂���ڋ߂���ׂ̋���


	--�����Ƃ�
	if targetDist >= farDist then
		if ai:IsFlying() == true then
			goal:AddSubGoal( GOAL_Kimera304000_Battle_FlyLeaveAndApproach, 20, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
		end
		
	--�߂��Ȃ��Ȃ�
	elseif targetDist >= nearDist then
		--75���@�ڋ�
		--25���@�ҋ@
		if fate < 50 then
--			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			if ai:IsFlying() == true then
				goal:AddSubGoal( GOAL_Kimera304000_Battle_FlyLeaveAndApproach, 20, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
			end
			
		elseif fate < 75 then

			if ai:IsFlying() == true then
				goal:AddSubGoal( GOAL_Kimera304000_Battle_FlyLeaveAndApproach, 20, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_NONE, 0, 0, 0 );
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 13010, TARGET_ENE_0, DIST_Near, 0 );
			end
	
		else
			goal:AddSubGoal(GOAL_COMMON_Wait,2.0,TARGET_ENE_0, 0, 0, 0 );
			if ai:IsFlying() == true then
				Kimera304000Battle_FlyAttack(ai, goal);
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 13030, TARGET_ENE_0, DIST_Near, 0);
			end
		end

	--�߂��Ȃ�
	elseif targetDist >= maaiDist then
		--60���@����ڋ߁��Đڋ�
		--40���@�ڋ߁��U��
		if fate < 60 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
			if fate2 < 50 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
			end
		else
			goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, maaiDist, nearDist, TARGET_ENE_0, true, -1 );
			if ai:IsFlying() == true then
				Kimera304000Battle_FlyAttack(ai, goal);
			else
				if targetDist < maaiDist then
					goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 13000, TARGET_ENE_0, DIST_Near, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13040, TARGET_ENE_0, DIST_Near, 0);	
				end
			end
		end

	else
	--�ԍ����ȓ��Ȃ�
		--�U������
		--�U����s��
		Kimera304000Battle_Kougeki(ai, goal)
		Kimera304000Battle_Kougeki_Noato(ai, goal)
	end
end

---------------------------------------------------------
--  �󒆍U���B
---------------------------------------------------------
function Kimera304000Battle_FlyAttack(ai, goal)

	local targetDist 	= ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋���
	local NEAR_DIST		= 6.0;		--�߂��Ɣ��f���鋗��
	
	if (targetDist < NEAR_DIST) or (AI_EVENT_KIMERA_TALE_CUT==ai:GetEventRequest(0))  then
		goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3010, TARGET_ENE_0, DIST_None, 0);
	end
end

---------------------------------------------------------
--  �U��
---------------------------------------------------------
function Kimera304000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--��
	--50% 3000�@���K�i��j
	--50% 3010�@�ւ����@�i��j
	--�n��
	--20% 13000�@�E�U�艺�낵�i�n�j
	--20% 13010�@����U�艺�낵�i�n�j
	--00% 13020�@�E����i�n �ؑւ��j
	--15% 304000 �ߖi�n�j
	--25% 13030�@���K�i�n�j
	--30% 13040�@�^�b�N���i�n�j
	if ai:IsFlying() == true then
		if ( (K_fate < 50) or (AI_EVENT_KIMERA_TALE_CUT==ai:GetEventRequest(0)) ) then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Near, 0);
		end
	else
		if K_fate < 40 then
			Kimera304000Battle_Kougeki_Riku_Ude(ai, goal)
		elseif K_fate < 55 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13030, TARGET_ENE_0, DIST_Near, 0);
		elseif K_fate < 70 then
			if(  (ai:GetTeamRecordCount(COORDINATE_TYPE_KIMERAbite, TARGET_NONE, 100) <= 0) 
				and ( AI_EVENT_KIMERA_TALE_CUT ~= ai:GetEventRequest(0)) ) then
				goal:AddSubGoal(GOAL_Kimera304000_Battle_Bite, 10);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13040, TARGET_ENE_0, DIST_Near, 0);
			end
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13040, TARGET_ENE_0, DIST_Near, 0);
		end
	end
end
	
	
---------------------------------------------------------
--  �U���E�r
---------------------------------------------------------
function Kimera304000Battle_Kougeki_Riku_Ude(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋���
local hprate = ai:GetHpRate( TARGET_SELF )		--������HP�������擾
local fate = ai:GetRandam_Int(1,100)			--�m������p
local fate2 = ai:GetRandam_Int(1,100)			--�m������p2
local fate3 = ai:GetRandam_Int(1,100)			--�m������p3
local fate4 = ai:GetRandam_Int(1,100)			--�m������p4

--[[�Иr(��)���r(��)���g�������邽�߁A����ɋ����𔻒�]]
local nearDist = 1.7							--�߂��Ɣ��f���āA���r�ŉ��鋗��

--[[HP�̎c�芄�������Ęr�̋��U���p�x��ς���]]

local		HPLevel1 = 0.75						--HP�̎c�ʃ��x���P�@75%�ȏ�
local		HPLevel2 = 0.50						--HP�̎c�ʃ��x���Q	50%�ȏ�		
local		HPLevel3 = 0.25						--HP�̎c�ʃ��x���R	25%�ȏ�
local		HPLevel4 = 0.0						--HP�̎c�ʃ��x���S	0%�ȏ�

local		LargeAttackPer1 = 10				--HP�c�ʃ��x���P�̂Ƃ��̋��U���̊m��
local		LargeAttackPer2 = 30				--HP�c�ʃ��x���Q�̂Ƃ��̋��U���̊m��
local		LargeAttackPer3 = 70				--HP�c�ʃ��x���R�̂Ƃ��̋��U���̊m��
local		LargeAttackPer4 = 90				--HP�c�ʃ��x���S�̂Ƃ��̋��U���̊m��


	if hprate >= HPLevel1 then
		
		if (fate <= LargeAttackPer1) then
			if targetDist < nearDist then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13010, TARGET_ENE_0, DIST_Near, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13000, TARGET_ENE_0, DIST_Near, 0);	
			end
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13000, TARGET_ENE_0, DIST_Near, 0);	
		end
	
	elseif hprate >= HPLevel2 then
	
		if (fate2 <= LargeAttackPer2) then
			if targetDist < nearDist then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13010, TARGET_ENE_0, DIST_Near, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13000, TARGET_ENE_0, DIST_Near, 0);	
			end
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13000, TARGET_ENE_0, DIST_Near, 0);	
		end	
	
	elseif hprate >= HPLevel3 then
	
		if (fate3 <= LargeAttackPer3) then
			if targetDist < nearDist then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13010, TARGET_ENE_0, DIST_Near, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13000, TARGET_ENE_0, DIST_Near, 0);	
			end
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13000, TARGET_ENE_0, DIST_Near, 0);	
		end	
	
	else
		
		if (fate4 <= LargeAttackPer4) then
			if targetDist < nearDist then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13010, TARGET_ENE_0, DIST_Near, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13000, TARGET_ENE_0, DIST_Near, 0);	
			end
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13000, TARGET_ENE_0, DIST_Near, 0);	
		end

	end
end
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function Kimera304000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local SideTime = 2.0							--���ɓ�������
local BackDist = ai:GetRandam_Float(0.75, 1.5)	--��ނ��鋗��
local BackTime = 1.0							--��ނ��鎞��


local bRight = ai:GetRandam_Int(0,1);							--���E�ړ��̕���
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- ���������ɍ��E�ړ����Ă��钇�Ԃ̐�



--���ɉ���������ɂƂ��ǂ����ړ�������Ɨǂ�����
--���܂�ɋ߂����鉡�ړ������A�������������Ă��牡�ړ�������Ɨǂ�����

	--25% �Ȃɂ����Ȃ��i������Ƃ������ړ��j
	--50% �K���ɉ��Ɉړ�
	--25% ���Ɉړ�
	if KN_fate < 25  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 10, true, true ,-1 );
	elseif KN_fate < 75  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end



---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function Kimera304000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function Kimera304000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function Kimera304000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);				--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐���
local fate3 = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐���
local maaiDist = 1.0	


	-- �_���[�W�H������Ƃ��̑Ή�
	if ai:IsInterupt( INTERUPT_Damaged ) then
		--���ł��Ȃ��āA�������߂��Ȃ���m���ōU��
		if targetDist <= 1.5 and fate <= 30 and ai:IsFlying() == false then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 13040, TARGET_ENE_0, DIST_Near, 0);
			return true;
			
		--���ł��Ȃ��āA�������߂��āA���m���Ȃ牽�����Ȃ�	
		elseif targetDist <= 1.5 and fate > 30 and ai:IsFlying() == false then
			
		--����ȊO�Ȃ�A���܂Œʂ胊�v�����j���O		
		else
			goal:ClearSubGoal();
			Kimera304000Battle_Activate(ai, goal);
			return true;
		end
	end

	--��U��ǂ�����
	--25���@�߂��̃^�[�Q�b�g����U�肵����U��
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < 3.5 then
			if fate <= 25 then
				goal:ClearSubGoal();
				Kimera304000Battle_Kougeki(ai, goal)
				Kimera304000Battle_Kougeki_Noato(ai, goal)
				return true;
			end	
		end
	end
	
	
	--�A�C�e�����g������œK�s��
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 30				--�A�C�e���g�p���ɍœK�s�������m��
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();
			if ai:IsFlying() == true then
				goal:AddSubGoal( GOAL_Kimera304000_Battle_FlyLeaveAndApproach, 20, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 13010, TARGET_ENE_0, DIST_Near, 0 );
			end
			return true
		end
	end	
	
	
	--��ѓ���������Ă�����œK�s��
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer_near = 40					--��ѓ���g�p���ɍœK�s�������m��(�߂�)
local shootIntPer_near_fly = 10				--��ѓ���g�p���ɍœK�s�������m��(�߂������ł���)
local shootIntPer_far = 80					--��ѓ���g�p���ɍœK�s�������m��(����)
local shootIntPer_far_fly = 20				--��ѓ���g�p���ɍœK�s�������m��(���������ł���)
local nearDist = 9.0						--�߂��Ƃ��̋���
local LockOnDist = 15.0						--PC���L���������b�N�I���ł��鋗��

	--�߂��Ƃ��^�b�N��
		if targetDist < nearDist then 
			if fate < shootIntPer_near then
--				goal:ClearSubGoal();
				if ai:IsFlying() == true then
					if fate2 < shootIntPer_near_fly then
						goal:ClearSubGoal();
						if fate3 < 30 then
							goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0 );
						elseif fate < 60 then
							goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Near, 0 );
						else
							goal:AddSubGoal( GOAL_Kimera304000_Battle_FlyLeaveAndApproach, 20, 0);
						end
						return true;
					end
				else
					goal:ClearSubGoal();
					goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.0,1.0) ,0,0,0,0)
					goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 13040, TARGET_ENE_0, DIST_Near, 0 );
					return true;
				end
			end
			
	--�����Ƃ����K
		else
			if fate < shootIntPer_far then
			--	goal:ClearSubGoal();
				if ai:IsFlying() == true then
					if fate2 < shootIntPer_far_fly and targetDist < LockOnDist then
						goal:ClearSubGoal();
						if fate3 < 30 then
							goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0 );
						elseif fate < 60 then
							goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Near, 0 );
						else
							goal:AddSubGoal( GOAL_Kimera304000_Battle_FlyLeaveAndApproach, 20, 0);
						end
						return true;
					end
				else
					if targetDist < 15 then
					goal:ClearSubGoal();
						goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.0,1.0) ,0,0,0,0)	
						if fate2 < 35 then
							goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 13040, TARGET_ENE_0, DIST_Near, 0 );
						else
							goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 13030, TARGET_ENE_0, DIST_Near, 0 );
						end
					end
					return true;
				end
			end
			
		end
	end
	
--~ 		if fate <= shootIntPer then
--~ 			goal:ClearSubGoal();
--~ 			if ai:IsFlying() == true then
--~ 				goal:AddSubGoal( GOAL_Kimera304000_Battle_FlyLeaveAndApproach, 20, 0);
--~ 			else
--~ 				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
--~ 				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 13010, TARGET_ENE_0, DIST_Near, 0 );
--~ 			end
--~ 			return true;
--~ 		end
--~ 	end

return false;

end




--*****************************************************************************************
--********************* �ȉ��L�����p���ݕt���A�N�V�����T�u�S�[�� **************************
--*****************************************************************************************

--[[***************************************************************************
	���ݕt���B
	�E���ݕt��
	�E��莞��or�U�����󂯂�ŁA�����B
	
	�p�����[�^�Ȃ��B
	
	�g�p���@
		goal:AddSubGoal( GOAL_Kimera304000_Battle_Bite, ����);
	
*****************************************************************************]]

REGISTER_GOAL(GOAL_Kimera304000_Battle_Bite, "Kimera304000Battle_Bite");
REGISTER_GOAL_NO_UPDATE( GOAL_Kimera304000_Battle_Bite, true );
REGISTER_GOAL_NO_INTERUPT( GOAL_Kimera304000_Battle_Bite, true );

function Kimera304000Battle_Bite_Activate( ai, goal)

	--���ݕt���B
	goal:AddSubGoal( GOAL_Kimera304000_Battle_BiteAction, goal:GetLife());
	
	--�`�[���Ɋ��ݕt�����Ȃ̂����m�点�B
	goal:AddGoalScopedTeamRecord(COORDINATE_TYPE_KIMERAbite, TARGET_NONE, 0);
end

function Kimera304000Battle_Bite_Update(ai, goal)return GOAL_RESULT_Continue;end
function Kimera304000Battle_Bite_Terminate(ai, goal)end
function Kimera304000Battle_Bite_Interupt(ai, goal)	return false; end

--[[***************************************************************************
	���ݕt���B
*****************************************************************************]]
REGISTER_GOAL(GOAL_Kimera304000_Battle_BiteAction, "Kimera304000Battle_BiteAct");
REGISTER_GOAL_UPDATE_TIME( GOAL_Kimera304000_Battle_BiteAction, 0, 0);

function Kimera304000Battle_BiteAct_Activate( ai, goal)
	goal:SetNumber( 0, 304000);
end

function Kimera304000Battle_BiteAct_Update(ai, goal)

	-- �K�[�h�I�����
	local 	bFinish 	= ai:IsFinishAttack();
	bFinish = bFinish or ai:IsEnableComboAttack();
	if ( bFinish ) then
		return GOAL_RESULT_Success;
	end

	-- �����s�����琬���ɂ���
	if ( goal:GetLife() <= 0) then
		return GOAL_RESULT_Success;
	end
	
	-- �_���[�W���󂯂Ă�����A���I���B
	if ( 0~=goal:GetNumber(1) ) then
		return GOAL_RESULT_Success;
	end
	
	-- �󒆂ɂ����瑦�I��
	if ai:IsFlying() == true then
		return GOAL_RESULT_Success;
	end

	-- ���Ԃ��؂��܂ł��ݑ�����B
	local ActNo = goal:GetNumber(0);
	ai:SetAttackRequest( ActNo);
	
	return GOAL_RESULT_Continue;
end

function Kimera304000Battle_BiteAct_Terminate(ai, goal)end
function Kimera304000Battle_BiteAct_Interupt(ai, goal)	
	if ai:IsInterupt( INTERUPT_Damaged ) then
		ai:SetAttackRequest(-1);
		goal:SetNumber( 0, -1);
		goal:SetNumber( 1, 1);
	end
	return false;
end






--*****************************************************************************************
--********************* �ȉ��L�����p�󒆃|�C���g�ړ��T�u�S�[�� ****************************
--*****************************************************************************************


--[[***************************************************************************
	�󒆏���|�C���g�Ɉړ�
	��	���n�_�Ɉړ�
	
	�p�����[�^�Ȃ��B
	
	�g�p���@
	@code
		goal:AddSubGoal( GOAL_Kimera304000_Battle_FlyLeaveAndApproach, ����);
	@endcode
	
*****************************************************************************]]
REGISTER_GOAL(GOAL_Kimera304000_Battle_FlyLeaveAndApproach, "Kimera304000FlyLeaveAndApproach");
REGISTER_GOAL_NO_UPDATE( GOAL_Kimera304000_Battle_FlyLeaveAndApproach, 1 );
REGISTER_GOAL_NO_INTERUPT( GOAL_Kimera304000_Battle_FlyLeaveAndApproach, true );

function Kimera304000FlyLeaveAndApproach_Activate(ai, goal)

	--��������K���ɐݒ肵�Ă��������B
	
	goal:AddSubGoal( GOAL_Kimera304000_Battle_FlyLeave, 6, 0);
	goal:AddSubGoal( GOAL_Kimera304000_Battle_FlyApproach, 10, 0);
end

function Kimera304000FlyLeaveAndApproach_Update(ai, goal)return GOAL_RESULT_Continue;end
function Kimera304000FlyLeaveAndApproach_Terminate(ai, goal)end
function Kimera304000FlyLeaveAndApproach_Interupt(ai, goal)	return false;end




--[[***************************************************************************
	�󒆏���|�C���g�Ɉړ�
	�p�����[�^�Ȃ��B
*****************************************************************************]]
REGISTER_GOAL(GOAL_Kimera304000_Battle_FlyLeave, "Kimera304000FlyLeave");
REGISTER_GOAL_NO_UPDATE( GOAL_Kimera304000_Battle_FlyLeave, 1 );
REGISTER_GOAL_NO_INTERUPT( GOAL_Kimera304000_Battle_FlyLeave, true );

function Kimera304000FlyLeave_Activate(ai, goal)
	--�ړ��|�C���g�^�C�v��ύX�����̃|�C���g�^�C�v�ł̎��̓_��ݒ�B
	ai:SetMovePointType( POINT_MOVE_TYPE_Gargoyle_Air_Patrol);
	ai:StepNextMovePoint();
	
	--�|�C���g�ړ��B
	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 20, POINT_MOVE_POINT, 0, TARGET_SELF, false, -1);
end

function Kimera304000FlyLeave_Update(ai, goal)	return GOAL_RESULT_Continue;end
function Kimera304000FlyLeave_Terminate(ai, goal)end
function Kimera304000FlyLeave_Interupt(ai, goal) return false;end


--[[***************************************************************************
	�n�㒅�n�_�|�C���g�Ɉړ�
	�p�����[�^�Ȃ��B
*****************************************************************************]]
REGISTER_GOAL(GOAL_Kimera304000_Battle_FlyApproach, "Kimera304000FlyApproach");
REGISTER_GOAL_NO_UPDATE( GOAL_Kimera304000_Battle_FlyApproach, 1 );
REGISTER_GOAL_NO_INTERUPT( GOAL_Kimera304000_Battle_FlyApproach, true );

function Kimera304000FlyApproach_Activate(ai, goal)
	--�ړ��|�C���g�^�C�v��ύX�����̃|�C���g�^�C�v�ł̎��̓_��ݒ�B
	ai:SetMovePointType( POINT_MOVE_TYPE_Gargoyle_Landing);
	ai:StepNextMovePoint();
	
	--�|�C���g�ړ��B
	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 20, POINT_MOVE_POINT, 0, TARGET_SELF, false, -1);
end

function Kimera304000FlyApproach_Update(ai, goal)	return GOAL_RESULT_Continue;end
function Kimera304000FlyApproach_Terminate(ai, goal)end
function Kimera304000FlyApproach_Interupt(ai, goal) return false;end


