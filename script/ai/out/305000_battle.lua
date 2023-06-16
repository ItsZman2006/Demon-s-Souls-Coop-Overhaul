--[[*******************************************************************************************
	Gagoiru305000��p�퓬
	�����F

	�p�����[�^0  �Ȃ�
	�p�����[�^1  �Ȃ�
	�p�����[�^2  �Ȃ�
	�p�����[�^3�@�Ȃ�

	��ai:SetNumber()�̎g�p�󋵁B
		�O�F�N���̈�ɓ��������H	�����Ă���O�ȊO�B
		�P�F�n��ڍs�^�C�}�A�ݒ�ς݂��H�@�O�ȊO�ŁA�ݒ�ς݁B
		�Q�F�n��ڍs���[�h�ɂȂ������H
		�R�F�N�����n��ړ����[�h�ɂȂ������H
		
	��ai:AddObserveRegion()�̎g�p�󋵁B
		�O�F�K�[�S�C���N���̈�
		�P�F
		�Q�F
		�R�F
		
	��ai:SetTimer()�̎g�p�󋵁B
		�O�F�n��ֈڍs�^�C�}�B
		�P�F
		�Q�F
		�R�F
		
*********************************************************************************************]]


function Gagoiru305000_IsSwordType( ai )

	--NPC�v�l�p�����[�^����������A�K���Ή����鎖�I�I�I�I

	local idParam = ai:GetNpcThinkParamID();
	if ( idParam==305001 ) then return false; end
	
	return true;
end



--[[*******************************************************************************************
	�퓬�S�́B
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Gagoiru305000_Battle, "Gagoiru305000Battle");
REGISTER_GOAL_NO_UPDATE(GOAL_Gagoiru305000_Battle, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_Gagoiru305000_Battle, true);

function Gagoiru305000Battle_Activate(ai, goal)
	
	if ( ai:IsLanding() ) then
		goal:AddSubGoal( GOAL_Gagoiru305000_LandBattle, goal:GetLife());
	else
		goal:AddSubGoal( GOAL_Gagoiru305000_AirBattle, goal:GetLife());
	end

end

function Gagoiru305000Battle_Update(ai, goal) return GOAL_RESULT_Continue; end
function Gagoiru305000Battle_Terminate(ai, goal)end
function Gagoiru305000Battle_Interupt(ai, goal)	return false; end




--[[*******************************************************************************************
	�󒆐퓬�B
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Gagoiru305000_AirBattle, "Gagoiru305000AirBattle");
REGISTER_GOAL_NO_UPDATE(GOAL_Gagoiru305000_AirBattle, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_Gagoiru305000_AirBattle, true);

function Gagoiru305000AirBattle_Activate(ai, goal)
	
--[[���������ځ�]]

	local ON_AIR_TIME=0;
	if ( Gagoiru305000_IsSwordType(ai) ) then
	
		--���^�C�v�̏ꍇ�B	
		ON_AIR_TIME = 2;		--�󒆂���n��ֈڍs����܂ł̎���.
	else
	
		--�{�E�K���^�C�v�̏ꍇ�B
		ON_AIR_TIME = 4;		--�󒆂���n��ֈڍs����܂ł̎���.(�󒆂���_���ł���̂Œ��߁B)		
	end


--[[���������ځ�]]

	--�ݒ�ς݂łȂ���΁B
	if ( 0==ai:GetNumber(1) ) then
		--�^�C�}�ݒ�B
		ai:SetTimer(0, ON_AIR_TIME);
		ai:SetNumber(1, 1);
	end
	
	--�^�C�}�ݒ�ς݁A���A���Ԑ؂�̏ꍇ�B
	if ( ai:IsFinishTimer(0) and not(0==ai:GetNumber(1)) ) then
		ai:SetNumber(1, 0);
		ai:SetNumber(2, 1);
	end
	
	if ( not(0==ai:GetNumber(2))) then
		--
		goal:AddSubGoal( GOAL_Gagoiru305000_Battle_Landing, 10);
		
		
		if ( Gagoiru305000_IsSwordType(ai) ) then
			--���̍ۂɃ^�[�Q�b�g�������Ă���ƒ��n�ł��Ȃ��B�̂ŁA��ӍU�����Ďd�؂�Ȃ����B
			goal:AddSubGoal( GOAL_Gagoiru305000_LandingAttack, 10);
		end
		
	else
		--���^�C�v�ŁB�B
		if ( Gagoiru305000_IsSwordType(ai) ) then
			--���x�����ꂷ���Ă�����A������ƍ������x�ɂ��낷�B
			if ( ai:GetDistYSigned(TARGET_ENE_0)<-2 ) then
				goal:AddSubGoal( GOAL_COMMON_Fall, 	10.0, 	TARGET_ENE_0, 9510, 9520, -1);
			end
		end
		--�U���B
		Gagoiru305000AirBattle_Attack(ai, goal);
	end

end

function Gagoiru305000AirBattle_Update(ai, goal) return GOAL_RESULT_Continue; end
function Gagoiru305000AirBattle_Terminate(ai, goal)end
function Gagoiru305000AirBattle_Interupt(ai, goal)	return false; end

function Gagoiru305000AirBattle_Attack(ai, goal)

	local attack_range	= ai:GetDistParam(DIST_Near);
	local leave_range	= ai:GetDistParam(DIST_Far);
		
	if ( Gagoiru305000_IsSwordType(ai) ) then
		--���^�C�v�B

		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 	10.0, 	TARGET_ENE_0, attack_range, TARGET_ENE_0, false, -1 );
		Gagoiru305000LandBattle_Kougeki(ai, goal);
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 		10.0, 	TARGET_ENE_0, leave_range, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal( GOAL_COMMON_Wait, 				2.0, 	TARGET_ENE_0);
	else
		--�{�E�K���^�C�v�B�i�U���Ԋu�����j
		Gagoiru305000LandBattle_Kougeki(ai, goal);
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 		10.0, 	TARGET_ENE_0, leave_range, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal( GOAL_COMMON_Wait, 				5.0, 	TARGET_ENE_0);
	end

end


--[[*******************************************************************************************
	�n��퓬�B
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Gagoiru305000_LandBattle, "Gagoiru305000LandBattle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Gagoiru305000_LandBattle, true);

--������
--�@�󒆂��瑖��ڋ߁A�������͐��񂵂Ă��瑖��ڋ�
--�@�������͕����ڋ�
--�@�{�E�K���͍U�����Ă���ڋ�
--
--������
--�@���񂵂Ă��瑖��ڋ߁A�������͕����ڋ�
--
--�ߋ���
--�@�U��
--
--�U����̍s��
--�@������ނ���
--�@�Ƃ��ǂ���ї����ď��������i�n��j


--[[*****************************************************
--  �S�[���N��
*******************************************************]]
function Gagoiru305000LandBattle_Activate(ai, goal)
------------------------------------------------------------------------------

	--�n��Ɉڍs������������A�t���O��������B
	ai:SetNumber(2, 0);

	--�s���I���B
	if ( Gagoiru305000_IsSwordType(ai) ) then
		--��
		Gagoiru305000LandBattle_BehaviorSelection_SWORD(ai, goal);
	else
		--�{�E�K��
		Gagoiru305000LandBattle_BehaviorSelection_BOWGUN(ai, goal);
	end
end

---------------------------------------------------------
--  �s���I���F���^�C�v�B
---------------------------------------------------------
function Gagoiru305000LandBattle_BehaviorSelection_SWORD(ai, goal)
	--�s���؂�ւ��B
	local targetDist 		= ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋���
	local RANGE_TOO_NEAR	= 1.5;								--���߁B����ȏ�߂��Ɗԍ����G�ɍU�������炢�B
	local RANGE_NEAR		= ai:GetDistParam(DIST_Near);		--�ߋ���
	local RANGE_MIDDLE		= ai:GetDistParam(DIST_Middle);		--������
	local RANGE_FAR			= ai:GetDistParam(DIST_Far);		--������

	
	--�e�����ɂ�����s���I���B
	if 		( targetDist < RANGE_TOO_NEAR ) then	Gagoiru305000LandBattle_Attack_TOO_NEAR(ai, goal);
	elseif 	( targetDist < RANGE_NEAR ) 	then	Gagoiru305000LandBattle_Attack_NEAR(ai, goal);
	elseif	( targetDist < RANGE_MIDDLE ) 	then	Gagoiru305000LandBattle_Attack_MIDDLE(ai, goal);
	else											Gagoiru305000LandBattle_Attack_FAR(ai, goal);
	end
end

---------------------------------------------------------
--  �s���I���F�{�E�K���^�C�v�B
---------------------------------------------------------
function Gagoiru305000LandBattle_BehaviorSelection_BOWGUN(ai, goal)

	--�U���B
	Gagoiru305000LandBattle_Kougeki(ai, goal);
end

---------------------------------------------------------
--  �U���F���ߋ����B
---------------------------------------------------------
function Gagoiru305000LandBattle_Attack_TOO_NEAR(ai, goal)
	--������Ɨ���āB
	Gagoiru305000LandBattle_KeepDist(ai, goal);
	--�ߋ����U���B
	Gagoiru305000LandBattle_Attack_NEAR(ai, goal);
end

---------------------------------------------------------
--  �U���F�ߋ���
---------------------------------------------------------
function Gagoiru305000LandBattle_Attack_NEAR(ai, goal)
	--�U������
	--�U����s��
	Gagoiru305000LandBattle_Kougeki(ai, goal);
	Gagoiru305000LandBattle_Kougeki_Noato(ai, goal);
end

---------------------------------------------------------
--  �U���F������
---------------------------------------------------------
function Gagoiru305000LandBattle_Attack_MIDDLE(ai, goal)
	local RANGE_NEAR	= ai:GetDistParam(DIST_Near);		--�ߋ���
	local target_range	= RANGE_NEAR *0.8;
	local fate 			= ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
	
	--50���@�i���񁨁j����ڋ߁@�@
	--35���@��э��ݍU��
	--15���@�����ڋ�
	if fate < 50 then
--	 	goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 20, false, true ,-1 );
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, target_range, TARGET_ENE_0, false, -1 );
		
	elseif fate < 85 then
		goal:AddSubGoal(GOAL_COMMON_KeepDist, 5.0, TARGET_ENE_0, 2.0, 5.5, TARGET_ENE_0, false, -1 );		--�ǉ��@����
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Near, 0);
		
	else
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, target_range, TARGET_ENE_0, true, -1 );
		
	end
end

---------------------------------------------------------
--  �U���F������
---------------------------------------------------------
function Gagoiru305000LandBattle_Attack_FAR(ai, goal)
	local RANGE_NEAR	= ai:GetDistParam(DIST_Near);		--�ߋ���
	local target_range	= RANGE_NEAR *0.8;
	local fate 			= ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
	local isWalk		= false;
	
	--75���@����ڋ�
	--25���@�����ڋ�
	if fate < 75 then
		isWalk	= false;
	else
		isWalk	= true;
	end
	
	--�ڋ߁B
	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, target_range, TARGET_ENE_0, isWalk, -1 );
end



---------------------------------------------------------
--  �U��
---------------------------------------------------------
function Gagoiru305000LandBattle_Kougeki(ai, goal)

	if ( Gagoiru305000_IsSwordType(ai) ) then
		Gagoiru305000LandBattle_Kougeki_SWORD(ai, goal);
	else
		Gagoiru305000LandBattle_Kougeki_BOWGUN(ai, goal);
	end

end


---------------------------------------------------------
--  �U���F�{�E�K��
---------------------------------------------------------
function Gagoiru305000LandBattle_Kougeki_BOWGUN(ai, goal)

local fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--������ۂB
	goal:AddSubGoal( GOAL_COMMON_KeepDist, 2, TARGET_ENE_0, 15, 16, TARGET_ENE_0, false, -1 );
	--�U���B
	goal:AddSubGoal(GOAL_Gagoiru305000_BowgunAttack, 3.0);
	--������Ƒ҂B�B�i���d�v�j
	if fate < 30 then
		goal:AddSubGoal(GOAL_COMMON_Wait, 3.0);
	else
		Gagoiru305000LandBattle_Kougeki_Noato(ai, goal);
	end

end


---------------------------------------------------------
--  �U���F��
---------------------------------------------------------
function Gagoiru305000LandBattle_Kougeki_SWORD(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--��
	--30% 3001�@�h�ˌ�1
	--30% 3002�@�h�ˌ�1��2
	--20% 3003�@�h�ˌ�1��2��3
	--20% 3300�@���ߎh�ˌ�
	
	--�n��
	--70% 3001(13001)�@�h�ˌ�1
	--30% 3004(13004)�@��э��ݍU��
	if (ai:IsLanding()) then
		if K_fate < 30 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Near, 0);
		elseif K_fate < 60 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Near, 0);
		elseif K_fate < 80 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Near, 0);
		end
	else
		if K_fate < 50 then
			goal:AddSubGoal(GOAL_COMMON_KeepDist, 5.0, TARGET_ENE_0, 0.0, 5.0, TARGET_ENE_0, false, -1 );		--�ǉ��@����
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_KeepDist, 5.0, TARGET_ENE_0, 2.0, 5.5, TARGET_ENE_0, false, -1 );		--�ǉ��@����
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Near, 0);
		end
	end
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function Gagoiru305000LandBattle_Kougeki_Noato(ai, goal)

	Gagoiru305000LandBattle_KeepDist(ai, goal);
end

---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function Gagoiru305000LandBattle_KeepDist(ai, goal)

	local RANGE_NEAR		= ai:GetDistParam(DIST_Near);	--�ߋ���
	local RANGE_NEAR_near	= RANGE_NEAR - 0.5;
	local RANGE_NEAR_far	= RANGE_NEAR + 0.5;
	local BackTime 			= 4.0							--��ނ��鎞��

	goal:AddSubGoal( GOAL_COMMON_KeepDist, BackTime, TARGET_ENE_0, RANGE_NEAR_near, RANGE_NEAR_far, TARGET_ENE_0, false, -1 );				

end


--[[*****************************************************
--  �S�[���X�V
*******************************************************]]
function Gagoiru305000LandBattle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


--[[*****************************************************
--  �S�[���I��
*******************************************************]]
function Gagoiru305000LandBattle_Terminate(ai, goal)
end


--[[*****************************************************
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
*******************************************************]]
function Gagoiru305000LandBattle_Interupt(ai, goal)

--[[���������ځ�]]

	--��U��U�������B
	local MISS_SWING_ATTACK_RATE	= 25;
	
	--�󒆂ɓ����o���_���[�W�ʁB
	local AWAY_DAMAGE				= 100;
	--�����鋗���B
	local AWAY_DISTANCE				= 3;

--[[���������ځ�]]


	local targetDist		= ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
	local RANGE_NEAR		= ai:GetDistParam(DIST_Near);	--�ߋ���
	local RANGE_NEAR_near	= RANGE_NEAR -1;
	local RANGE_NEAR_far	= RANGE_NEAR +1;
	local fate 				= ai:GetRandam_Int(1,100);		--�m������Ŏg�p����^���̐���

	--��U��ǂ�����
	--25���@�߂��̃^�[�Q�b�g����U�肵����U��
	if ( ai:IsInterupt( INTERUPT_MissSwing ) ) then
		if ((RANGE_NEAR_far < targetDist) and (targetDist < RANGE_NEAR_far)) then
			if (fate <= MISS_SWING_ATTACK_RATE) then
			
				--�ߐڍU���B
				goal:ClearSubGoal();
				Gagoiru305000LandBattle_Kougeki(ai, goal)
				Gagoiru305000LandBattle_Kougeki_Noato(ai, goal)
				
				return true;
			end	
		end
	end

	--�_���[�W��H������B
	if (ai:IsInterupt(INTERUPT_Damaged)) then
		--���݂̃_���[�W����
		local lastdamage = ai:GetDamageLastFrame();
		
		--�_���[�W�ʂɉ����āA�󒆂ɓ����邩�H
		if ( AWAY_DAMAGE < lastdamage ) then
			goal:ClearSubGoal();
			
			--�󒆂ɗ��E�������B
			goal:AddSubGoal( GOAL_Gagoiru305000_LiftOff, 	10);
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 		2.0, 	TARGET_ENE_0, AWAY_DISTANCE, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal( GOAL_COMMON_Wait, 				2.0, 	TARGET_ENE_0);
		end
	end
		
	return false;
end



--[[***********************************************************************************]]
--[[**************************** �ȉ��A�K�[�S�C���p�T�u�S�[�� *************************]]
--[[***********************************************************************************]]


--[[*****************************************************
--  ���n�ł���Ƃ���Ɉړ��˒��n�B
*******************************************************]]
REGISTER_GOAL(GOAL_Gagoiru305000_Battle_Landing, "Gagoiru305000Battle_Landing");
REGISTER_GOAL_NO_UPDATE( GOAL_Gagoiru305000_Battle_Landing, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_Gagoiru305000_Battle_Landing, true);

function Gagoiru305000Battle_Landing_Activate(ai, goal)

	--AI�Œ�ڕW��ݒ�B
	ai:SetAIFixedMoveTarget( POINT_2ndNEAR_LANDING, TARGET_SELF, 0);
--~ 	ai:SetAIFixedMoveTarget( POINT_FAR_LANDING, TARGET_SELF, 0);

	--�܂��A�ڕW�ʒu�֌������B
	goal:AddSubGoal( GOAL_Gagoiru305000_Battle_Landing_Move, 10);
	
	if (0<ai:GetDistYSigned(TARGET_ENE_0)) then
		--�ڋ߁B
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, POINT_AI_FIXED_POS, 0.1, TARGET_SELF, false, -1 );
	else
		goal:AddSubGoal( GOAL_Gagoiru305000_Battle_Landing_Landing, 10);
	end
end
function Gagoiru305000Battle_Landing_Update(ai, goal)return GOAL_RESULT_Continue;end
function Gagoiru305000Battle_Landing_Terminate(ai, goal)end
function Gagoiru305000Battle_Landing_Interupt(ai, goal)	return false;end

--[[*****************************************************
--  ���n�ł���Ƃ���Ɉړ�����B
*******************************************************]]
REGISTER_GOAL(GOAL_Gagoiru305000_Battle_Landing_Move, "Gagoiru305000Battle_Landing_Move");
REGISTER_GOAL_UPDATE_TIME( GOAL_Gagoiru305000_Battle_Landing_Move, 0.5, 0.5);
REGISTER_GOAL_NO_INTERUPT( GOAL_Gagoiru305000_Battle_Landing_Move, true);

function Gagoiru305000Battle_Landing_Move_Activate(ai, goal)
	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, POINT_AI_FIXED_POS, 2, TARGET_SELF, false, -1 );
end
function Gagoiru305000Battle_Landing_Move_Update(ai, goal)
	
	local distXZ = ai:GetDistXZ(POINT_AI_FIXED_POS);
	if ( distXZ < 1 ) then
		return GOAL_RESULT_Success;
	end
	
	--�ڕW�ʒu�O�ɁA�s�ӂɒ��n�����������A���s���ă��v�����j���O�B
	if ( ai:IsLanding() ) then
		return GOAL_RESULT_Failed;
	end

	return GOAL_RESULT_Continue;
end
function Gagoiru305000Battle_Landing_Move_Terminate(ai, goal)end
function Gagoiru305000Battle_Landing_Move_Interupt(ai, goal)	return false;end

--[[*****************************************************
--  ���n�B
*******************************************************]]
REGISTER_GOAL(GOAL_Gagoiru305000_Battle_Landing_Landing, "Gagoiru305000Battle_Landing_Landing");
REGISTER_GOAL_UPDATE_TIME( GOAL_Gagoiru305000_Battle_Landing_Landing, 0.5, 0.5);
REGISTER_GOAL_NO_INTERUPT( GOAL_Gagoiru305000_Battle_Landing_Landing, true);

function Gagoiru305000Battle_Landing_Landing_Activate(ai, goal)
	goal:AddSubGoal( GOAL_COMMON_Attack, 1, 9510, TARGET_NONE, DIST_None);
end
function Gagoiru305000Battle_Landing_Landing_Update(ai, goal)
	if ( ai:IsLanding() ) then
	
		--���n����u�ԂɃS�[�����I��点��ƁA�ǂ����A����Ȃ�
		--���n�ł��Ȃ��݂����B
		local cnt = goal:GetNumber(0);
		if ( 10<cnt ) then
			return GOAL_RESULT_Success;
		else
			cnt = cnt +1;
			goal:SetNumber(0,cnt);
		end
	end
	
	--���n�ł���܂ł������B
	local resultSubGoal = goal:GetLastSubGoalResult();
	if ( (resultSubGoal==GOAL_RESULT_Success) or (resultSubGoal==GOAL_RESULT_Failed) ) then
		if ( not(ai:IsLanding()) ) then
			goal:AddSubGoal( GOAL_COMMON_Attack, 1, 9510, TARGET_NONE, DIST_None);
		end
	end

	--�^�[�Q�b�g��荂�������ɂȂ�����B�B�B
	if ( 1<ai:GetDistYSigned(POINT_AI_FIXED_POS)) then
		--���������������̂ŁA��蒼���B
		return GOAL_RESULT_Failed;
	end
	
	return GOAL_RESULT_Continue;
end
function Gagoiru305000Battle_Landing_Landing_Terminate(ai, goal)end
function Gagoiru305000Battle_Landing_Landing_Interupt(ai, goal)	return false;end


--[[*****************************************************
	���n������Ȃ������Ƃ��̃��J�o�[�p�B
	PC�ɍU�������Ȃ����߁A��ɍU�������Ⴄ�B
*******************************************************]]
REGISTER_GOAL(GOAL_Gagoiru305000_LandingAttack, "Gagoiru305000Battle_LandingAttack");
REGISTER_GOAL_NO_UPDATE( GOAL_Gagoiru305000_LandingAttack, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_Gagoiru305000_LandingAttack, true);

function Gagoiru305000Battle_LandingAttack_Activate(ai, goal)
	
	if ( ai:IsLanding() ) then
		goal:AddSubGoal( GOAL_COMMON_Wait, 0.1, TARGET_ENE_0);
	else
		Gagoiru305000AirBattle_Attack(ai, goal);
	end

end

function Gagoiru305000Battle_LandingAttack_Update(ai, goal) return GOAL_RESULT_Continue; end
function Gagoiru305000Battle_LandingAttack_Terminate(ai, goal) end
function Gagoiru305000Battle_LandingAttack_Interupt(ai, goal) return false; end


--[[*****************************************************
	�{�E�K���U���B
*******************************************************]]
REGISTER_GOAL(GOAL_Gagoiru305000_BowgunAttack, "Gagoiru305000Battle_BowgunAttack");
REGISTER_GOAL_NO_UPDATE(GOAL_Gagoiru305000_BowgunAttack, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_Gagoiru305000_BowgunAttack, true);

function Gagoiru305000Battle_BowgunAttack_Activate(ai, goal)

--[[���������ځ�]]
	--���̒l�ȉ��ɋ������Ȃ�����A���Ɋԍ������������Ă��Ȃ��ƌ������ƂŁA��������B
	local LIFT_OFF_DISTANCE	= 10;
--[[���������ځ�]]


	local distXZ = ai:GetDistXZ(TARGET_ENE_0);
	if ( ai:IsLanding() and distXZ<LIFT_OFF_DISTANCE ) then
		--���n���ĂāA�����Ȃ��Ȃ��Ă���ꍇ�́A��������B
		goal:AddSubGoal(GOAL_Gagoiru305000_LiftOff, goal:GetLife(), 9520, TARGET_NONE, DIST_None);
	else
		--���ʂɍU���B
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, goal:GetLife(), 3000, TARGET_ENE_0, DIST_None);
		--������Ƒ҂B�B
--~ 		goal:AddSubGoal(GOAL_COMMON_Wait, 3.0);
	end
end

function Gagoiru305000Battle_BowgunAttack_Update(ai, goal) return GOAL_RESULT_Continue; end
function Gagoiru305000Battle_BowgunAttack_Terminate(ai, goal)end
function Gagoiru305000Battle_BowgunAttack_Interupt(ai, goal) return false; end


--[[*****************************************************
	�����B
*******************************************************]]
REGISTER_GOAL(GOAL_Gagoiru305000_LiftOff, "Gagoiru305000Battle_LiftOff");
--~ REGISTER_GOAL_NO_UPDATE(GOAL_Gagoiru305000_LiftOff, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_Gagoiru305000_LiftOff, true);

function Gagoiru305000Battle_LiftOff_Activate(ai, goal)

	goal:AddSubGoal(GOAL_COMMON_Attack, goal:GetLife(), 9520, TARGET_NONE, DIST_None);
end

function Gagoiru305000Battle_LiftOff_Update(ai, goal)
	--���n�ł���܂ł������B
	local resultSubGoal = goal:GetLastSubGoalResult();
	if ( (resultSubGoal==GOAL_RESULT_Success) or (resultSubGoal==GOAL_RESULT_Failed) ) then
		if ( ai:IsLanding() ) then
			goal:AddSubGoal( GOAL_COMMON_Attack, 1, 9520, TARGET_NONE, DIST_None);
		end
	end
	
	return GOAL_RESULT_Continue;
end

function Gagoiru305000Battle_LiftOff_Terminate(ai, goal)end
function Gagoiru305000Battle_LiftOff_Interupt(ai, goal) return false; end


--[[*****************************************************
	�n�ʂɒ��n�B
*******************************************************]]
REGISTER_GOAL(GOAL_Gagoiru305000_LandingOnGround, "Gagoiru305000LandingOnGround");
REGISTER_GOAL_UPDATE_TIME(GOAL_Gagoiru305000_LandingOnGround, 0.5, 0.5);
REGISTER_GOAL_NO_INTERUPT(GOAL_Gagoiru305000_LandingOnGround, true);

function Gagoiru305000LandingOnGround_Activate(ai, goal)
	goal:AddSubGoal( GOAL_COMMON_Attack, 1, 9510, TARGET_NONE, DIST_None);
end
function Gagoiru305000LandingOnGround_Update(ai, goal)
	if ( ai:IsLanding() ) then
	
		--���n����u�ԂɃS�[�����I��点��ƁA�ǂ����A����Ȃ�
		--���n�ł��Ȃ��݂����B
		local cnt = goal:GetNumber(0);
		if ( 3<cnt ) then
			return GOAL_RESULT_Success;
		else
			cnt = cnt +1;
			goal:SetNumber(0,cnt);
		end
	end
	
	--���n�ł���܂ł������B
	local resultSubGoal = goal:GetLastSubGoalResult();
	if ( (resultSubGoal==GOAL_RESULT_Success) or (resultSubGoal==GOAL_RESULT_Failed) ) then
		if ( not(ai:IsLanding()) ) then
			goal:AddSubGoal( GOAL_COMMON_Attack, 1, 9510, TARGET_NONE, DIST_None);
		end
	end

	return GOAL_RESULT_Continue;
end
function Gagoiru305000LandingOnGround_Terminate(ai, goal)end
function Gagoiru305000LandingOnGround_Interupt(ai, goal)	return false;end






