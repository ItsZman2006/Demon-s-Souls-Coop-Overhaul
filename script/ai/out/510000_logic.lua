--[[*******************************************************************************************
	��w偗p�̎v�l���W�b�N
	�����F 
	
	��ȍX�V�����F
		�_���[�W��H��������莞�ԂŁA����s�������B08/8/3 hasem
	
	
	��ai:SetTimer()�̎g�p�󋵁B
		�O�F
		�P�F
		�Q�F
		�R�F�Ή����˃A�N�V�����i3040�j�����܂ł̃^�C�}�B
	
	��ai:SetNumber()�̎g�p�󋵁B
		�O�F
		�P�F���G�p�U���񐔁B
		�Q�F���G�p�U���K�[�h�񐔁B
		�R�F�Ή����˃A�N�V�����i3040�j�����^�C�}���ݒ�ς݂��H�i�O�ȊO�ŁA�ݒ�ς݁B�j
	
	��ai:AddObserveRegion()�̎g�p�󋵁B
		�O�F�Ή��A�N�V�����g���K�[�B
		�P�F
		�Q�F
		�R�F
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_kumo510000, "kumo510000_Logic", "kumo510000_Interupt");

--[[************************************************************
	�ėp���Ăяo�������B
**************************************************************]]
function kumo510000_Logic(ai)

--[[����撲�����ځ�]]
	
	--�N�������𕢂��T�C�Y�̃C�x���g�̈�B
	local KUMO_ROOM_REGION_ID		= 2070;
	
	--���G�p�U���̃K�[�h���e�񐔁B����𒴂���Ƒ�U���B
	local FEELER_GUARD_THRESHOLD	= ai:GetRandam_Int(1,3) ;
	
	--���G�p�U���̋��e�񐔁B����𒴂���Ƒ�U���B
	local FEELER_ATTACK_THRESHOLD	= ai:GetRandam_Int(1,3) ;

--[[����撲�����ځ�]]

	--�Ή��A�N�V�����g���K�[��ݒ�B
	ai:AddObserveRegion(0, TARGET_ENE_0, KUMO_ROOM_REGION_ID);

	if ( 	FEELER_GUARD_THRESHOLD	<= ai:GetNumber(2) 
		or 	FEELER_ATTACK_THRESHOLD <= ai:GetNumber(1) ) then
		
		--��U�����s�B
		kumo510000_LOGIC_PowerAttack( ai);
	
	elseif ( not(0==ai:GetNumber(3)) and (ai:GetTimer(3)<=0) ) then
		--�Ή��^�C�}�؂�Ȃ�A�Ή��U���B
	
		--�U����ݒ�B
		ai:AddTopGoal(GOAL_kumo510000_Blaze, 100);

	else
		--�ʏ퓮��B
		COMMON_EasySetup3(ai);
	end
end

--[[************************************************************
	���荞�݁B
**************************************************************]]
function	kumo510000_Interupt(ai, goal)

--[[����撲�����ځ�]]

	--�̈�ɓ����Ă���A�Ή����˂���܂ł̎���[sec]�B
	local FIRE_COUNTDOWN	= 28;

--[[����撲�����ځ�]]


	--�̈�ɓ����āA�܂������J�E���^�����͂���Ă��Ȃ���΁A
	--�^�C�}�[�ŃJ�E���g�J�n�B
	if (ai:IsInterupt( INTERUPT_Inside_ObserveArea )) then
	
		if ( ai:IsInsideObserveRegion(0) ) then
		--�ݒ�ς݂łȂ���ΐݒ�B
			if ( 0==ai:GetNumber(3) ) then
				ai:SetTimer( 3, FIRE_COUNTDOWN);
				ai:SetNumber( 3, 1);
			end
		end
	
	end
end


--[[************************************************************
	�N���A����̃K�[�h�ɑς����˂ċ��U���B
**************************************************************]]
function	kumo510000_LOGIC_PowerAttack(ai)

	--���ʕ����H
	if ( ai:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 40) ) then

		ai:AddTopGoal(GOAL_COMMON_Attack2, 100, 3090, TARGET_ENE_0, DIST_None, 0);
	
	--�E���H
	elseif ( ai:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) ) then
		
		ai:AddTopGoal(GOAL_COMMON_Attack2, 100, 3070, TARGET_ENE_0, DIST_None, 0);
		
	--�����H
	elseif ( ai:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_L, 180) ) then
		
		ai:AddTopGoal(GOAL_COMMON_Attack2, 100, 3080, TARGET_ENE_0, DIST_None, 0);
		
	end
	
	--�J�E���^�N���A�B
	ai:SetNumber( 2, 0);
	ai:SetNumber( 1, 0);
	
end

--[[******************************************************************************************************************]]
--[[**************************************************** �T�u�S�[�� **************************************************]]
--[[******************************************************************************************************************]]


--[[************************************************************
	�Ή����˃S�[���B
**************************************************************]]
REGISTER_GOAL(GOAL_kumo510000_Blaze, "kumo510000Blaze");
REGISTER_GOAL_NO_UPDATE( GOAL_kumo510000_Blaze, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_kumo510000_Blaze, true);

function kumo510000Blaze_Activate(ai, goal)
	--�U����ݒ�B
	goal:AddSubGoal(GOAL_COMMON_Attack, 100, 3040, TARGET_ENE_0, DIST_None);
end

function kumo510000Blaze_Terminate(ai, goal)
	--�J�E���^�����Z�b�g�B
	--	���̃^�C�~���O�܂ŁA�J�E���^�̍ăX�^�[�g��������Ȃ��悤�ɂ���B
	ai:SetTimer(3,0);
	ai:SetNumber(3,0);
end

function kumo510000Blaze_Update(ai, goal) return GOAL_RESULT_Continue; end
function kumo510000Blaze_Interupt(ai, goal) return false; end


--[[************************************************************
	���G�p�U���B
**************************************************************]]
REGISTER_GOAL(GOAL_kumo510000_FeelerAttack, "kumo510000FeelerAttack");
REGISTER_GOAL_NO_UPDATE( GOAL_kumo510000_FeelerAttack, true);

function kumo510000FeelerAttack_Activate(ai, goal)
	--�U����ݒ�B
	goal:AddSubGoal(GOAL_COMMON_Attack2, 100, 3050, TARGET_ENE_0, DIST_None, 0);
local count_A = ai:GetNumber(1);
	count_A = count_A +1;
	ai:SetNumber( 1, count_A);
end

function kumo510000FeelerAttack_Terminate(ai, goal)
end

function kumo510000FeelerAttack_Update(ai, goal) return GOAL_RESULT_Continue; end
function kumo510000FeelerAttack_Interupt(ai, goal) 
	
	if ( ai:IsInterupt(INTERUPT_TargetIsGuard) ) then
		--�G���K�[�h�����J�E���^���C���N�������g�B
		local count = ai:GetNumber(2);
		count = count +1;
		ai:SetNumber( 2, count);
	end

	return false; 
end








