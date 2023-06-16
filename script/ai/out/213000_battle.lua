--[[*******************************************************************************************
	�e���p�퓬
	�����F

	�p�����[�^0  �Ȃ�
	�p�����[�^1  �Ȃ�
	�p�����[�^2  �Ȃ�
	�p�����[�^3�@�Ȃ�

	��ai:SetNumber()�̎g�p�󋵁B
		�O�F
		�P�F
		�Q�F
		�R�F�R�b�\���ړ��I���������H�@�O�ȊO�ŏI���Ƃ���B
*********************************************************************************************]]
REGISTER_GOAL(GOAL_kageonna213000_Battle, "kageonna213000_Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_kageonna213000_Battle, true);

--[[*****************************************************
	�S�[���N��
*******************************************************]]
function kageonna213000_Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

--[[���������ځ�]]

	local BACKPOS__ANGLE_RANGE	= 10;		--���荞�݂��|����p�x
	local BACKPOS__DIST_RANGE	= 5;		--���荞�݂��|���鋗��

--[[���������ځ�]]

	--����̔w��ɉ�肱�񂾂��`�F�b�N�B
	ai:AddObserveArea( 0, TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_B, BACKPOS__ANGLE_RANGE, BACKPOS__DIST_RANGE);

-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐����@���̂R
 
local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 1.1					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3001_Dist_min = 0.0					--3001�Ԃ̓K���ԍ����i�ŏ��j
local Att3001_Dist_max = 0.9					--3001�Ԃ̓K���ԍ����i�ő�j
local Att3002_Dist_min = 0.0					--3002�Ԃ̓K���ԍ����i�ŏ��j
local Att3002_Dist_max = 1.1					--3002�Ԃ̓K���ԍ����i�ő�j
local Att3004_Dist_min = 0.0					--3004�Ԃ̓K���ԍ����i�ŏ��j
local Att3004_Dist_max = 3.0					--3004�Ԃ̓K���ԍ����i�ő�j

local Act01Per = 0		--���������ߐڃR���{
local Act02Per = 0		--���s��荞�݁��w�ʎh��
local Act03Per = 0		--�X�e�b�v�{���s��荞�݁��w�ʎh��	
local Act04Per = 0		--���s�ڋ߁��ߐڃR���{
 
	--�ƂĂ������Ȃ�
	if targetDist >= 10.0 then
		Act01Per = 100		--���������ߐڃR���{
		Act02Per = 0		--���s��荞�݁��w�ʎh��
		Act03Per = 0		--�X�e�b�v�{���s��荞�݁��w�ʎh��	
		Act04Per = 0		--���s�ڋ߁��ߐڃR���{
		
	--�w�ʂ�_���������Ȃ����炢�ɉ����Ȃ�
	elseif targetDist >= 6.0 then
		Act01Per = 25		--���������ߐڃR���{
		Act02Per = 0		--���s��荞�݁��w�ʎh��
		Act03Per = 0		--�X�e�b�v�{���s��荞�݁��w�ʎh��	
		Act04Per = 75		--���s�ڋ߁��ߐڃR���{
		
	--������x�߂��āA�ƂĂ��オ��ꂻ���Ȃ�
	elseif targetDist >= 3.0 then
		if ai:IsInsideTargetEx( TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_B, 45.0, 6) then
			Act01Per = 0		--���������ߐڃR���{
			Act02Per = 100		--���s��荞�݁��w�ʎh��
			Act03Per = 0		--�X�e�b�v�{���s��荞�݁��w�ʎh��	
			Act04Per = 0		--���s�ڋ߁��ߐڃR���{
		end
		
	--������x�߂��āA���オ��ꂻ���Ȃ�
	elseif targetDist >= 3.0 then
		if ai:IsInsideTargetEx( TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_B, 90.0, 6) then 
			Act01Per = 0		--���������ߐڃR���{
			Act02Per = 0		--���s��荞�݁��w�ʎh��
			Act03Per = 100		--�X�e�b�v�{���s��荞�݁��w�ʎh��	
			Act04Per = 0		--���s�ڋ߁��ߐڃR���{
		end
		
	--����Ƌ߂��āA�ƂĂ��オ��ꂻ���Ȃ�	
	elseif ai:IsInsideTargetEx( TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_B, 30.0, 3) then
		Act01Per = 0		--���������ߐڃR���{
		Act02Per = 100		--���s��荞�݁��w�ʎh��
		Act03Per = 0		--�X�e�b�v�{���s��荞�݁��w�ʎh��	
		Act04Per = 0		--���s�ڋ߁��ߐڃR���{		
		
	--����ȊO�i���߂߂����ǌ�͑_���ɂ����j
	else
		Act01Per = 0		--���������ߐڃR���{
		Act02Per = 0		--���s��荞�݁��w�ʎh��
		Act03Per = 0		--�X�e�b�v�{���s��荞�݁��w�ʎh��	
		Act04Per = 100		--���s�ڋ߁��ߐڃR���{
		
	end

	
	--�s��01�@���������ߐڃR���{
	if fate2 <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, -1 );
		kageonna213000_Battle_Kougeki(ai, goal)
		
	--�s��02�@���s��荞�݁��w�ʎh��
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_TurnAround, 5.0, TARGET_ENE_0, AI_DIR_TYPE_B, 30, true, false, -1);	
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3004_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3004, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��03�@�X�e�b�v�{���s��荞�݁��w�ʎh��
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
		--�����ɂ���ΉE�X�e�b�v
		if ai:IsInsideTargetEx( TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_L, 180, 100) then
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 703, TARGET_ENE_0, -1, AI_DIR_TYPE_R, 4.0);
		--�t�Ȃ獶�X�e�b�v	
		else
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 702, TARGET_ENE_0, -1, AI_DIR_TYPE_L, 4.0);
		end
		goal:AddSubGoal(GOAL_COMMON_TurnAround, 5.0, TARGET_ENE_0, AI_DIR_TYPE_B, 30, true, false, -1);	
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3004_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3004, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��04�@���s�ڋ߁��ߐڃR���{
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, -1 );
		kageonna213000_Battle_Kougeki(ai, goal)
		
	end
	kageonna213000_Battle_Kougeki_Noato(ai, goal)
	
end	
	

---------------------------------------------------------
--  �U��
---------------------------------------------------------
function kageonna213000_Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--10% 3000
	--50% 3000-3001
	--40% 3000-3001-3002
	
	if K_fate <= 10 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif K_fate <= 60 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
	end
end

	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function kageonna213000_Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

local KNAct01Per	= 20	--�������Ȃ�
local KNAct02Per	= 20	--�E�X�e�b�v�i�Z�[�t�e�B�j
local KNAct03Per	= 20	--���X�e�b�v�i�Z�[�t�e�B�j
local KNAct04Per	= 30	--���ړ�
local KNAct05Per	= 10	--�o�b�N�X�e�b�v�i�Z�[�t�e�B�j

	--�s��01�@�������Ȃ�
	if  KN_fate <= KNAct01Per then
   		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.5,1.0) ,0,0,0,0)
		
	--�s��02�@�E�X�e�b�v
	elseif  KN_fate <= (KNAct01Per + KNAct02Per) then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 703, TARGET_ENE_0, 0, AI_DIR_TYPE_R, 4.0);
		
	--�s��03�@���X�e�b�v
	elseif  KN_fate <= (KNAct01Per + KNAct02Per + KNAct03Per) then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 702, TARGET_ENE_0, 0, AI_DIR_TYPE_L, 4.0);
		
	--�s��04�@�������ړ�
	elseif  KN_fate <= (KNAct01Per + KNAct02Per + KNAct03Per + KNAct04Per) then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
		
	--�s��05�@�o�b�N�X�e�b�v
	else
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 4.0);
		
	end
end


--[[*****************************************************
	�X�V�E�I���Ȃ��B
*******************************************************]]
function kageonna213000_Battle_Update(ai, goal) return GOAL_RESULT_Continue; end
function kageonna213000_Battle_Terminate(ai, goal)end

--[[*****************************************************
	���荞�݁B
*******************************************************]]
function kageonna213000_Battle_Interupt(ai, goal)

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 1.1					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3001_Dist_min = 0.0					--3001�Ԃ̓K���ԍ����i�ŏ��j
local Att3001_Dist_max = 0.9					--3001�Ԃ̓K���ԍ����i�ő�j
local Att3002_Dist_min = 0.0					--3002�Ԃ̓K���ԍ����i�ŏ��j
local Att3002_Dist_max = 1.1					--3002�Ԃ̓K���ԍ����i�ő�j
local Att3004_Dist_min = 0.0					--3004�Ԃ̓K���ԍ����i�ŏ��j
local Att3004_Dist_max = 3.0					--3004�Ԃ̓K���ԍ����i�ő�j

--	local FRONT_CHECK__ANGLE_RANGE	= 10;		

	--�Ď��̈�ɐN�������Ȃ�
	if ( ai:IsInterupt(INTERUPT_Inside_ObserveArea) ) then
		--�Ď��̈�O�ԂȂ�
		if ( ai:IsInsideObserveArea(0) ) then
--			--����������̕����������Ă�����
			--�w���h���U��
--			if (ai:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, FRONT_CHECK__ANGLE_RANGE)) then
				goal:ClearSubGoal();
				goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3004_Dist_max, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3004, TARGET_ENE_0, DIST_Middle, 0);
				
				return true;
--			end
		end
	end

	return false;
end





--[[*******************************************************************************************
	�e���p��������w��U���퓬
	�����F

	�p�����[�^0  �Ȃ�
	�p�����[�^1  �Ȃ�
	�p�����[�^2  �Ȃ�
	�p�����[�^3�@�Ȃ�
*********************************************************************************************]]
REGISTER_GOAL(GOAL_kageonna213000_SneakAttack, "kageonna213000_SneakAttack");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_kageonna213000_SneakAttack, true);

--[[*****************************************************
	�S�[���N��
*******************************************************]]
function kageonna213000_SneakAttack_Activate(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐����@���̂R
 
local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 1.1					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3001_Dist_min = 0.0					--3001�Ԃ̓K���ԍ����i�ŏ��j
local Att3001_Dist_max = 0.9					--3001�Ԃ̓K���ԍ����i�ő�j
local Att3002_Dist_min = 0.0					--3002�Ԃ̓K���ԍ����i�ŏ��j
local Att3002_Dist_max = 1.1					--3002�Ԃ̓K���ԍ����i�ő�j
local Att3004_Dist_min = 0.0					--3004�Ԃ̓K���ԍ����i�ŏ��j
local Att3004_Dist_max = 3.0					--3004�Ԃ̓K���ԍ����i�ő�j

	--�W�O�U�O�ڋ߂��Ĕw�ʎh��
	goal:AddSubGoal(GOAL_COMMON_TurnAround, 2.0, TARGET_ENE_0, AI_DIR_TYPE_B, 30, true, true, 9910);	
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 10.0, TARGET_ENE_0, true, 9910 );
	goal:AddSubGoal(GOAL_COMMON_TurnAround, 2.0, TARGET_ENE_0, AI_DIR_TYPE_B, 30, true, true, 9910);	
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 8.0, TARGET_ENE_0, true, 9910 );
	goal:AddSubGoal(GOAL_COMMON_TurnAround, 2.0, TARGET_ENE_0, AI_DIR_TYPE_B, 30, true, true, 9910);	
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 6.0, TARGET_ENE_0, true, 9910 );
	goal:AddSubGoal(GOAL_COMMON_TurnAround, 2.0, TARGET_ENE_0, AI_DIR_TYPE_B, 30, true, true, 9910);	
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, true, 9910 );
	goal:AddSubGoal(GOAL_COMMON_TurnAround, 2.0, TARGET_ENE_0, AI_DIR_TYPE_B, 30, true, true, 9910);	
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 2.0, TARGET_ENE_0, true, -1 );
	goal:AddSubGoal(GOAL_kageonna213000_SA_Attack, 5.0, 3004, TARGET_ENE_0, DIST_Middle, 0);

end

--[[*****************************************************
	�S�[���X�V�E�I���B
*******************************************************]]
function kageonna213000_SneakAttack_Update(ai, goal) return GOAL_RESULT_Continue; end
function kageonna213000_SneakAttack_Terminate(ai, goal) end

--[[*****************************************************
	�S�[�����荞�݁B
*******************************************************]]
function kageonna213000_SneakAttack_Interupt(ai, goal)
	return false;
end








--[[*******************************************************************************************
	�e���p��퓬
	�����F

	�p�����[�^0  �Ȃ�
	�p�����[�^1  �Ȃ�
	�p�����[�^2  �Ȃ�
	�p�����[�^3�@�Ȃ�
*********************************************************************************************]]
REGISTER_GOAL(GOAL_kageonna213000_NonBattle, "kageonna213000_NonBattle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE(GOAL_kageonna213000_NonBattle, true);

--[[*****************************************************
	�S�[���N��
*******************************************************]]
function kageonna213000_NonBattle_Activate(ai, goal)

	local distToInitPos = ai:GetDist(POINT_INITIAL);

	if ( distToInitPos<2 ) then
		--�����ʒu�ߕӂɋ���̂ŁA������B
		goal:AddSubGoal(GOAL_COMMON_Guard, 10, 9910, TARGET_ENE_0, true);
	else
		--�����ʒu�Ɉړ��B
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 10, POINT_INITIAL, AI_DIR_TYPE_CENTER, 0.5, TARGET_SELF, 9910);
	end

	
	--��퓬��ԂɁB
	ai:SetNumber(3, 0);

end

--[[*****************************************************
	�S�[���X�V�E�I���B
*******************************************************]]
function kageonna213000_NonBattle_Update(ai, goal) return GOAL_RESULT_Continue; end
function kageonna213000_NonBattle_Terminate(ai, goal) end

--[[*****************************************************
	�S�[�����荞�݁B
*******************************************************]]
function kageonna213000_NonBattle_Interupt(ai, goal)
	return false;
end



	



--[[*******************************************************************************************
	�e���p��������퓬���U���T�u�S�[��
	�����F
		�P�ɁA��������U���S�[���̏I�[���U����terminate���Ă΂ꂽ�^�C�~���O�ɂ����������B
*********************************************************************************************]]
REGISTER_GOAL(GOAL_kageonna213000_SA_Attack, "kageonna213000_SA_Attack");
REGISTER_GOAL_NO_UPDATE(GOAL_kageonna213000_SA_Attack, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_kageonna213000_SA_Attack, true);

--[[*****************************************************
	�S�[���N��
*******************************************************]]
function kageonna213000_SA_Attack_Activate(ai, goal)

	local life			= goal:GetLife();
	local ezStateNo		= goal:GetParam(0);
	local target		= goal:GetParam(1);
	local distType		= goal:GetParam(2);

	goal:AddSubGoal(GOAL_COMMON_ComboAttack, life, ezStateNo, target, distType);
end

--[[*****************************************************
	�S�[���X�V�B
*******************************************************]]
function kageonna213000_SA_Attack_Update(ai, goal) return GOAL_RESULT_Continue; end

--[[*****************************************************
	�S�[���I���B
*******************************************************]]
function kageonna213000_SA_Attack_Terminate(ai, goal) 
	--�R�b�\���s���I���B
	ai:SetNumber(3, 1);
end

--[[*****************************************************
	�S�[�����荞�݂Ȃ��B
*******************************************************]]
function kageonna213000_SA_Attack_Interupt(ai, goal)
	return false;
end



	