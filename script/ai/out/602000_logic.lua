--[[*******************************************************************************************
	ArasiSensi602000�̎v�l���W�b�N
	�����F
	
	��ai:SetNumber()�g�p��
		�O�F
		�P�F
		�Q�F
		�R�FBattle���H	
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_ArasiSensi602000, "ArasiSensi602000_Logic", "ArasiSensi602000_Interupt");

--[[************************************************************************
	ArasiSensi602000�p�̎v�l���W�b�N
**************************************************************************]]
function	ArasiSensi602000_Logic(ai)

	if( ai:IsBattleState() ) then
	
		--��퓬������퓬���ɍŏ��Ɉڍs����Ƃ��B
		if ( 0==ai:GetNumber(3)) then
			ArasiSensi602000_OnShiftBattleMode(ai);
		end
		
		--�퓬���t���O�𗧂ĂĂ����B
		ai:SetNumber(3, 1);
	
		--�퓬�B
		ai:AddTopGoal( GOAL_ArasiSensi602000_Battle, -1);
	else
	
		--��퓬�s���B
		ai:SetNumber(3, 0);
		ai:AddTopGoal( GOAL_ArasiSensi602000_NonBattle, -1);
	end

end

--[[************************************************************************
	���W�b�N���荞��
**************************************************************************]]
function	ArasiSensi602000_Interupt(ai, goal)
end

--[[************************************************************************
	�퓬��Ԃֈڍs���鎞�B
**************************************************************************]]
function	ArasiSensi602000_OnShiftBattleMode(ai)

	local rand_val		= ai:GetRandam_Int(0, 100);
	local idAction		= 3300;
	
	if ( rand_val<50 ) then
		idAction		= 3300;
	else
		idAction		= 3301;
	end
	
	ai:AddTopGoal(GOAL_COMMON_NonspinningAttack, 100, idAction, TARGET_ENE_0, DIST_None);
end



--[[************************************************************************************************]]
--[[************************************** ��퓬�S�[�� ********************************************]]
--[[************************************************************************************************]]

--[[*******************************************************************************************
	ArasiSensi602000�̎v�l���W�b�N
	�����F
*********************************************************************************************]]

REGISTER_GOAL(GOAL_ArasiSensi602000_NonBattle, "ArasiSensi602000NonBattle");
REGISTER_GOAL_NO_UPDATE( GOAL_ArasiSensi602000_NonBattle, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_ArasiSensi602000_NonBattle, true);

--[[************************************************************************
	�N���B
**************************************************************************]]
function ArasiSensi602000NonBattle_Activate(ai, goal)

--[[����撲�����ځ�]]
	
	local idThreatAction1	= 3000;
	local idThreatAction2	= 3004;
	local idThreatAction3	= 3005;
	
	local rate1	= 10;
	local rate2	= 50;
	local rate3	= 50;

	--�|�C���g�ړ�����[sec]�B
	local POINT_MOVE_TIME_LENGTH	= 7;
	
--[[����撲�����ځ�]]

	--�|�C���g�ړ��B
	goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, POINT_MOVE_TIME_LENGTH, POINT_MOVE_POINT, AI_DIR_TYPE_CENTER, 3, TARGET_SELF, true);	

	--�Њd�U��
local fate = ai:GetRandam_Float(0, 100);
	if fate <= 20 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 100, 3004, TARGET_NONE, DIST_None);
		
	elseif fate <=50 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 100, 3004, TARGET_NONE, DIST_None);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 100, 3005, TARGET_NONE, DIST_None);	
		
	elseif fate <=70 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 100, 3005, TARGET_NONE, DIST_None);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 100, 3005, TARGET_NONE, DIST_None);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 100, 3004, TARGET_NONE, DIST_None);
	end

end

--[[************************************************************************
	�X�V�E�I���E���荞�݂Ȃ��B
**************************************************************************]]
function ArasiSensi602000NonBattle_Update(ai, goal) return GOAL_RESULT_Continue; end
function ArasiSensi602000NonBattle_Terminate(ai, goal)end
function ArasiSensi602000NonBattle_Interupt(ai, goal) return false; end





