------------------------------------------------------------------------------------------------
--	����O�e�mC��p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_NpcKISI_C803000_Battle, "npcKISI_C803000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_NpcKISI_C803000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function npcKISI_C803000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾
local selfmp = ai:GetMp(TARGET_SELF)					--�����̎c��MP���擾

	--������HP�c�肪20%�ȏ�Ȃ�
	if hprate >= 0.2 then

		--��{�퓬
		npcKISI_C803000Battle_Normal_Attack(ai, goal)			

	else

		--MP���ő�l�ł����
		if selfmp >= 100 then 		
		
			--���@�U��
			npcKISI_C803000Battle_Magic(ai, goal)

		--MP���ő�l�łȂ����
		else
		
			--��{�U��
			npcKISI_C803000Battle_Normal_Attack(ai, goal)	
		end
	end
	
end

---------------------------------------------------------
--  ��{�퓬
---------------------------------------------------------
function npcKISI_C803000Battle_Normal_Attack(ai, goal)	

local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋������擾
local nearDist = 4.0							--�|�ōU�����鋗��
	
	
	--�|�ōU�����鋗���Ȃ�
	if targetDist >= nearDist then
		--�|�ōU��
		npcKISI_C803000Battle_Bow(ai, goal)

	--���ōU�����鋗���Ȃ�
	else
		--���ōU��
		npcKISI_C803000Battle_Sword(ai, goal)
	end	
end
	
---------------------------------------------------------
--  �U���F�|
---------------------------------------------------------
function npcKISI_C803000Battle_Bow(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)	--�m������p
local fate2 = ai:GetRandam_Int(1,100)	--�m������p
local fate3 = ai:GetRandam_Int(1,100)	--�m������p


	--�|�������Ă��Ȃ���΋|�Ɏ����ւ���
	CommonNPC_ChangeWepR1(ai, goal)

	--�G�^�[�Q�b�g��7M�ȓ��̂Ƃ�
	if targetDist <= 7.0 then
	
		--50% ���̏�Ŏˌ���A�����Č��
		if fate <= 50 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Far, 0);
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 10.0, TARGET_ENE_0, false, -1 );
		
		--50% ���̏�Ŏˌ���A�����Đ���
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Far, 0);
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(20,45), false, true , -1 );
		end
		
	--�G�^�[�Q�b�g��12M�ȓ��̂Ƃ�
	elseif targetDist <= 12.0 then

		--50% ���̏�Ŏˌ���A�����Č��
		if fate2 <= 50 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Far, 0);
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 5.0, TARGET_ENE_0, true, -1 );
		
		--50% ���̏�Ŏˌ���A�����Đ���
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Far, 0);
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(20,45), true, true , -1 );
		end
		
	--�G�^�[�Q�b�g��20M�ȓ��̂Ƃ�
	else		
		--50% ���̏�Ŏˌ�
		if fate3 <= 50 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Far, 0);
		
		--50% ���񂵂Ďˌ�
		else
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(20,45), false, true , -1 );
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Far, 0);
		end
	end
end

---------------------------------------------------------
--  �U���F��
---------------------------------------------------------
function npcKISI_C803000Battle_Sword(ai, goal)

local fate = ai:GetRandam_Int(1,100)			--�m������p
local NormalR_Dist = 2.5						--�E��U���̓K���ԍ���	

	--�L���W�Ə��������Ă��Ȃ���Ύ����ւ���
	CommonNPC_ChangeWepR2(ai, goal)
	CommonNPC_ChangeWepL1(ai, goal)

	--40% �����ċ߂Â��čU��
	if fate <= 40 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		npcKISI_C803000Battle_NormalR_Comb(ai, goal)

	--30% �����ċ߂Â��ăK�[�h���Ȃ����荞��ōU��
	elseif fate <= 70 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(90,120), false, true , 4 );
		npcKISI_C803000Battle_NormalR_Comb(ai, goal)

	--30% ���������
	else 
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 4.0, TARGET_ENE_0, 5.0, TARGET_ENE_0, false, 4 );
	end
	
end


---------------------------------------------------------
--  �U���F���@
---------------------------------------------------------
function npcKISI_C803000Battle_Magic(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋������擾
local NormalR_Dist = 2.5						--�E��U���̓K���ԍ���	

	--�G�}�Ɏ����ւ���
	CommonNPC_ChangeWepL2(ai, goal)			

	--4M�ȏ㗣��Ă����瑖���ċ߂Â��Ė��@
	if targetDist >= 4.0 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 )
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_None, 0);
		npcKISI_C803000Battle_Kougeki_Noato(ai, goal)

	--4M�ȓ��ɂ���΂��̏�Ŗ��@
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_None, 0);
		npcKISI_C803000Battle_Kougeki_Noato(ai, goal)
		
	end

end	


---------------------------------------------------------
--  �E��R���{�i�ߋ����j
---------------------------------------------------------
function npcKISI_C803000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p
local NR_fate2 = ai:GetRandam_Int(1,100)		--�m������p

	--100% �E��U��2��
	--60% �E��U��4��
	--10% ���U��
	
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);

	if NR_fate <= 60 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	end
	
	if NR_fate2 <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	end
end
	

---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function npcKISI_C803000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local BackDist = 2.5							--��ނ��鋗��

	--���������Ă��Ȃ���Ύ����ւ���
	CommonNPC_ChangeWepL1(ai, goal)

	--50���@���Ɉړ�
	--50���@���Ɉړ�
	if KN_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, BackDist, TARGET_ENE_0, false, 4 );				
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(3,5), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(45,65), false, true , 4 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(4,6), TARGET_ENE_0, BackDist, TARGET_ENE_0, true, 4 );				

	end
end



---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function npcKISI_C803000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function npcKISI_C803000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function npcKISI_C803000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

	--�߂��ŋ�U�肵�����ڎU�ɓ�����
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 1.0			--��U�蓦�����鋗��
local MissSwingAttPer = 50			--��U�蓦������m��	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 10.0, TARGET_ENE_0, false, -1 );
				return true;
			end
		end	
	end


	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Č��
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 2.0				--�R���{���ꂷ�鋗��
local combRunPer = 40				--�R���{���ꂷ��m��
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				if fate2 <= 60 then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
				elseif fate2 <= 80 then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
				else
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
				end	
				return true;
			end
		end
	end	

	--��ѓ���������Ă�����œK�s��
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 50					--��ѓ���g�p���ɍœK�s�������m��
		if fate <= shootIntPer then
			goal:ClearSubGoal();
			if fate2 <= 50 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			end
			return true
		end
	end	
	

	return false;
end

