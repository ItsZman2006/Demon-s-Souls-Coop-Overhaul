-----------------------------------------------------------------------------------------------
--	���p�̓k�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Majutu_823000_Battle, "majutu_823000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Majutu_823000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function majutu_823000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q

local NormalR_Dist = 2.5					--�E��U���̓K���ԍ���

	--�ɒ[�ɋ߂��Ȃ��Ȃ�
	if targetDist >= NormalR_Dist then
		--90���@�����ċ߂Â�
		--10���@���񂵂čU��
		if fate <= 90 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0,  false, -1);
		else
			goal:AddSubGoal( GOAL_COMMON_SidewayMove, 4.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, false, true,-1 );
			majutu_823000Battle_Magic_Comb(ai, goal)
			majutu_823000Battle_Kougeki_Noato(ai, goal)
		end
	--�ɒ[�ɋ߂��Ȃ�
	else
		--10���@���
		--90���@����U��
		if fate2 <= 10 then
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, 2.0, TARGET_ENE_0, false, -1 );
		else
			goal:AddSubGoal( GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, false, true ,-1 );
			majutu_823000Battle_Magic_Comb(ai, goal)
		end
	end

end



---------------------------------------------------------
--  ���@�U��
---------------------------------------------------------
function majutu_823000Battle_Magic_Comb(ai, goal)

local selfmp = ai:GetMp(TARGET_SELF)	--������MP�̎c�ʂ��擾
local NormalR_Dist = 0.5 
local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q

	--���@���g����Ȃ�
	if selfmp >= 5 then

		--���@�ōU��
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_MagicR, TARGET_ENE_0, DIST_Middle, 0);
	
	--MP���s���Ă����
	else

		if ( 0 == ai:GetNumber(0)) then
			--���@�ōU���̂ӂ�
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_MagicR, TARGET_ENE_0, DIST_Middle, 0);
			ai:SetNumber(0,1);
		else

			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0,  false, -1);
		
			if fate <= 70 then
				--�G�}�����܂��đf��ŉ���
				CommonNPC_ChangeWepR2(ai, goal)
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
				
			else
				--����
				CommonNPC_ChangeWepR2(ai, goal)
				goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepF, TARGET_SELF, 0, AI_DIR_TYPE_F, 4.0);
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Middle, 0);
			
			end
		end
	end
end
	

	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function majutu_823000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local KN_fate2 = ai:GetRandam_Int(1,100)		--�m������p

	--50���@�����҂�
	--25���@���Ɉړ�
	--15���@���Ɉړ�
	--10���@�X�e�b�v�Ō��
	if KN_fate <= 60 then
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 15, true, true ,-1 );
	else
		if fate2 <= 60 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
		elseif fate2 <= 80 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
		end	
	end
end




---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function majutu_823000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function majutu_823000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function majutu_823000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local BackDist = 5.0				--��ނ��鋗��
local NormalR_Dist = 4.0			--�E��U���̓K���ԍ���

	--��U�肵������
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 4.0			--��U���ނ��鋗��
local MissSwingAttPer = 50			--��U���ނ���m��	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );	
				return true;
			end
		end	
	end

	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Č��
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--�R���{���ꂷ�鋗��
local combRunPer = 40				--�R���{���ꂷ��m��
		if targetDist < combRunDist then
			if fate <= combRunPer then
				--�����
				if fate2 <= 60 then
					goal:ClearSubGoal();
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
					goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, 2.0, TARGET_ENE_0, false, -1 );
					return true;
				end
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
	
	--�A�C�e�����g������œK�s��
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 20				--�A�C�e���g�p���ɍœK�s�������m��
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();		
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			majutu_823000Battle_Magic_Comb(ai, goal)
			majutu_823000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	
return false;
end

