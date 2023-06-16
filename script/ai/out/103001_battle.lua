--[[*******************************************************************************************
	�f�u�f�[�����p�퓬
	�����F�ÍԂP�̍L��ɋ���f�u�f�[�����p�B

	���ύX����
		�`���[�g���A������R�s�[	08/8/2 hasem
	
	���S�[���p�����[�^
		�p�����[�^0  �Ȃ�
		�p�����[�^1  �Ȃ�
		�p�����[�^2  �Ȃ�
		�p�����[�^3�@�Ȃ�
	
	��ai:SetNumber()�̎g�p�󋵁B
		�O�F
		�P�F
		�Q�F
		�R�F
	
	��ai:AddObserveRegion()�̎g�p�󋵁B
		�O�F�ړ��֎~�̈�ɍ����|�����Ă������ǂ����̃`�F�b�N�B
		�P�F
		�Q�F
		�R�F
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Debu103001_Battle, "debu103001Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Debu103001_Battle, true);

--[[*****************************************************
	�S�[���N��
*******************************************************]]
function debu103001Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

--[[���������ځ�]]

	local APPROACH_DIST	= 6;
	local BACKHOME_DIST	= 3;

--[[���������ځ�]]

	
	
	if ( ai:IsInsideTargetRegion(TARGET_ENE_0, 2270) ) then
		
		--�㔼�����B
		--	�㔼�͂�����ƒǂ������邻�Ԃ��������B
		--	�ړ��֎~�̈�ɓ����Ă��Ȃ���΁B�B�B
		if ( not(ai:IsInsideTargetRegion(TARGET_SELF, 2271)) ) then
			--����܂�ǂ�������ƁA�ǂ�˂�������U�������Ă��܂�����A
			--���ɗ������肷��̂ŁA���X�ɂ͒ǂ������Ȃ��B�B
			goal:AddSubGoal(GOAL_Debu103001_SafeApproach, 3);
		end
		
		debu103001Battle_Attack(ai, goal);
	
	else
		
		--�O�������B
		--	�O���́A�v���C���[��������U���B
		
		--�����ʒu���痣��Ă�����A�߂�B
		local distToInipos = ai:GetDist(POINT_INITIAL);
		if ( BACKHOME_DIST < distToInipos ) then
			goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 3, POINT_INITIAL, AI_DIR_TYPE_CENTER, 1, TARGET_ENE_0, false);
		end
		
		debu103001Battle_Attack(ai, goal);
	
	end
	
end
	
---------------------------------------------------------
--  �U���B
---------------------------------------------------------
function debu103001Battle_Attack(ai, goal)

	--�U�����Ă����̈�ɓ����Ă���΁A�U���B
	if ( debu103001Battle_IsEnableAttack(ai, goal) ) then
	
		if ( not debu103001Battle_SelectAttack(ai, goal) ) then
			--�����I������Ă��Ȃ���΁A������Ƒ҂B
			goal:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_ENE_0);
		end
		
	else
		--������Ƒ҂B
		goal:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_ENE_0);
	end
	
	--�U����
	debu103001Battle_Kougeki_Noato(ai, goal);
end

---------------------------------------------------------
--  �U���̑I���B
--	hasem�@:���̊֐��͊��T�C�h�ōD�����肢�����ėǂ��ł��B
---------------------------------------------------------
function debu103001Battle_SelectAttack(ai, goal)

	--[[�������B
	
		3000	�ʏ�		0		7.5
		3001	�E�Ȃ�		2		10.2
		3002	�E��		2.6		9.5
		3003	����		2.6		9.5		�i3002����R���{�A�P���ŏo���̂͋֎~�B�j
		3300	���ߍU��	1		8
		
		�g�ݍ��킹�́Adebu103001Battle_Attack_1 �` 6
	]]

	
	--�e�U���̊����B
	local rate1	= 0;
	local rate2	= 0;
	local rate3	= 0;
	local rate4	= 0;
	local rate5	= 0;
	local rate6	= 0;
	
	
	local dist = ai:GetDist(TARGET_ENE_0);
	if 		( 10.5<=dist) then
		rate1	= 0;
		rate2	= 0;
		rate3	= 0;
		rate4	= 0;
		rate5	= 0;
		rate6	= 0;
		
	elseif 	( 9.5<=dist) then
		rate1	= 0;
		rate2	= 100;
		rate3	= 0;
		rate4	= 0;
		rate5	= 0;
		rate6	= 0;
		
	elseif 	( 7.5<=dist ) then
		rate1	= 0;
		rate2	= 45;
		rate3	= 10;
		rate4	= 0;
		rate5	= 40;
		rate6	= 5;
		
	elseif 	( 2.5<=dist ) then
		rate1	= 20;
		rate2	= 10;
		rate3	= 10;
		rate4	= 0;
		rate5	= 30;
		rate6	= 30;
		
	elseif 	( 1.5<=dist ) then
		rate1	= 50;
		rate2	= 0;
		rate3	= 0;
		rate4	= 0;
		rate5	= 0;
		rate6	= 50;
		
	else
		rate1	= 15;
		rate2	= 0;
		rate3	= 0;
		rate4	= 80;
		rate5	= 0;
		rate6	= 5;
		
	end
	
	local total_rate 	= rate1 + rate2 + rate3
						+ rate4 + rate5 + rate6;
						
	--�ǂ���I������Ȃ��B
	if (total_rate==0) then
		return false;
	end

	local thr1	= rate1;
	local thr2	= rate1 + rate2;
	local thr3	= rate1 + rate2 + rate3;
	local thr4	= rate1 + rate2 + rate3 + rate4;
	local thr5	= rate1 + rate2 + rate3 + rate4 + rate5;
						
	local rand_val		= ai:GetRandam_Int(0,total_rate);
	if 		( rand_val<=thr1 ) then	debu103001Battle_Attack_1(ai, goal);
	elseif	( rand_val<=thr2 ) then	debu103001Battle_Attack_2(ai, goal);
	elseif	( rand_val<=thr3 ) then	debu103001Battle_Attack_3(ai, goal);
	elseif	( rand_val<=thr4 ) then	debu103001Battle_Attack_4(ai, goal);
	elseif	( rand_val<=thr5 ) then	debu103001Battle_Attack_5(ai, goal);
	else							debu103001Battle_Attack_6(ai, goal);
	end
	
	return true;
end

--[[�U�� 1]]
function debu103001Battle_Attack_1(ai, goal)
	goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_None, 0);
end

--[[�U�� 2]]
function debu103001Battle_Attack_2(ai, goal)
	goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_None, 0);
end

--[[�U�� 3]]
function debu103001Battle_Attack_3(ai, goal)
	goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_None, 0);
end

--[[�U�� 4]]
function debu103001Battle_Attack_4(ai, goal)
	goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_None, 0);
end

--[[�U�� 5]]
function debu103001Battle_Attack_5(ai, goal)
	goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_None, 0);
end

--[[�U�� 6]]
function debu103001Battle_Attack_6(ai, goal)
	goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_None, 0);
end

---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function debu103001Battle_Kougeki_Noato(ai, goal)

--[[���������ځ�]]

	local BACKHOME_DIST = 3;

--[[���������ځ�]]

	--�����ʒu���痣��Ă�����߂�B
	local distToInipos = ai:GetDist(POINT_INITIAL);
	if ( BACKHOME_DIST < distToInipos ) then
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 2, POINT_INITIAL, AI_DIR_TYPE_CENTER, 0, TARGET_ENE_0, true);				
	end
	
	goal:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_ENE_0);
end

---------------------------------------------------------
--  �U�����Ă����ꏊ���H
---------------------------------------------------------
function debu103001Battle_IsEnableAttack(ai, goal)
	
	if ( ai:IsInsideTargetRegion(TARGET_ENE_0, 2275) ) then return true; end
	if ( ai:IsInsideTargetRegion(TARGET_ENE_0, 2276) ) then return true; end
	
	return false;
end



--[[*****************************************************
	�X�V�E�I���Ȃ��B
*******************************************************]]
function debu103001Battle_Update(ai, goal) return GOAL_RESULT_Continue; end
function debu103001Battle_Terminate(ai, goal)end


--[[*****************************************************
	���荞�݁B
*******************************************************]]
function debu103001Battle_Interupt(ai, goal)

--~ 	if ( ai:IsInterupt(INTERUPT_Inside_ObserveArea) ) then
--~ 		if ( ai:IsInsideObserveRegion(0) ) then
--~ 			goal:ClearSubGoal();
--~ 			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_None, 0);
--~ 			return true;
--~ 		end
--~ 	end

	return false;
end



--[[************************************************************************************************************]]
--[[************************************************************************************************************]]
--[[************************************************************************************************************]]


--[[*****************************************************
	���S�ڋ߁B
	�E�ړ��s�\�̈�ɍ����|��������A
	�@���̎��_�Ŋ��荞�݂������āA�S�[���𐬌������A�ړ����Ȃ��悤�ɂ���B
*******************************************************]]
REGISTER_GOAL(GOAL_Debu103001_SafeApproach, "debu103001SafeApproach");
REGISTER_GOAL_NO_UPDATE( GOAL_Debu103001_SafeApproach, true);

function debu103001SafeApproach_Activate(ai, goal)

	--�̈�Ď��J�n�B
	ai:AddObserveRegion( 0, TARGET_SELF, 2271 );
	
	--�^�[�Q�b�g�Ɍ������Ĉړ��B
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 3, TARGET_ENE_0, APPROACH_DIST, AI_DIR_TYPE_CENTER, false, -1);
end

function debu103001SafeApproach_Terminate(ai, goal)end
function debu103001SafeApproach_Update(ai, goal) return GOAL_RESULT_Continue; end

function debu103001SafeApproach_Interupt(ai, goal)
	
	if (ai:IsInterupt(INTERUPT_Inside_ObserveArea)) then
		--�����A�ړ��֎~�̈�ɍ����|�����Ă�����A
		--���݂̈ړ����N���A���āA������Ƃ�wait�����Đ���������B
		if (ai:IsInsideObserveRegion(0)) then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_Wait, 0.1);
			return true;
		end
	end
	
	return false;
end
