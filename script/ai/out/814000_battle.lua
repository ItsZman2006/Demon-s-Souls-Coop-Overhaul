-----------------------------------------------------------------------------------------------
--	�E���x�C���p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Urubein_814000_Battle, "urubein_814000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Urubein_814000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function urubein_814000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾

	--������HP�c�肪30%�ȏ�Ȃ�
	if hprate >= 0.3 then

		--�ʏ�s��
		urubein_814000Battle_Normal_Attack(ai, goal)			

	--������HP�c�肪30%�ȉ��Ȃ�
	else

		--�m���s��		
		urubein_814000Battle_Dying_Attack(ai, goal)

	end
	
end

---------------------------------------------------------
--  �ʏ�s��
---------------------------------------------------------
function urubein_814000Battle_Normal_Attack(ai, goal)	

local fate = ai:GetRandam_Int(1,100)			--�m������p
local selfmp = ai:GetMp(TARGET_SELF)			--�����̎c��MP���擾

	--MP��100��葽�����
	if selfmp >= 100 then

		if fate <= 20 then
	
			--���@�ōU��
			urubein_814000Battle_Magic(ai, goal)
			urubein_814000Battle_Kougeki_Noato(ai, goal)
		else
		
			urubein_814000Battle_Normal(ai, goal)
			urubein_814000Battle_Kougeki_Noato(ai, goal)
		end
		
	--MP��25��菭�Ȃ����
	else
	
		--100% �ʏ�U��
		urubein_814000Battle_Normal(ai, goal)
		urubein_814000Battle_Kougeki_Noato(ai, goal)
	
	end
		
end


---------------------------------------------------------
--  �m���s��
---------------------------------------------------------
function urubein_814000Battle_Dying_Attack(ai, goal)	

local fate = ai:GetRandam_Int(1,100)			--�m������p
local selfmp = ai:GetMp(TARGET_SELF)			--�����̎c��MP���擾

	--MP��60��葽�����
	if selfmp >= 60 then

		--�G���狗�����Ƃ�
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 4.0, TARGET_ENE_0, 5.0, TARGET_ENE_0, false, -1 );

		--��񕜂ɐ؂�ւ���HP��
		ai:ChangeEquipMagic(1);
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_SELF, DIST_None, 0 );
		urubein_814000Battle_Kougeki_Noato(ai, goal)
		
	--MP��60��菭�Ȃ����
	else

		--100% �ʏ�U��
		urubein_814000Battle_Normal(ai, goal)
		urubein_814000Battle_Kougeki_Noato(ai, goal)
		
	end
		
end

	
---------------------------------------------------------
--  �ʏ�s���F����
---------------------------------------------------------
function urubein_814000Battle_Normal(ai, goal)

local fate = ai:GetRandam_Int(1,100)			--�m������p

	--40% ���񂷂�
	if fate <= 40 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,50), false, true , -1 );

	--60% ���������
	else 
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(2,4), TARGET_ENE_0, false, -1 );
	end
	
end

---------------------------------------------------------
--  �U���F���@
---------------------------------------------------------
function urubein_814000Battle_Magic(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋������擾
local NormalR_Dist = 3.5						--�E��U���̓K���ԍ���	

	--���Ȓ��S�����ɐ؂�ւ���
	ai:ChangeEquipMagic(0);

	--4M�ȏ㗣��Ă����瑖���ċ߂Â��Ė��@
	if targetDist >= 4.0 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 )
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_None, 0);
		urubein_814000Battle_Kougeki_Noato(ai, goal)

	--4M�ȓ��ɂ���΂��̏�Ŗ��@
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_None, 0);
		urubein_814000Battle_Kougeki_Noato(ai, goal)
		
	end
	
end


---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function urubein_814000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local BackDist = 2.5							--��ނ��鋗��

	--30% �������Ȃ�
	--40% ���Ɉړ�
	--30% ���Ɉړ����Ă��牡�ړ�
	
	if KN_fate <= 60 then
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true , -1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(1,3), TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,50), true, true , -1 );
	end
end



---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function urubein_814000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function urubein_814000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function urubein_814000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

	--��U�肵������
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 4.0			--��U���ނ��鋗��
local MissSwingAttPer = 50			--��U���ނ���m��	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );	
				return true;
			end
		end	
	end

	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Č��
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--�R���{���ꂷ�鋗��
local combRunPer = 40				--�R���{���ꂷ��m��
local combRunCountPer = 5			--�R���{����̌�ɍU������m��	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
					goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, 2.0, TARGET_ENE_0, true, -1 );
				return true;
			end
		end
	end	

	

	return false;
end

