-----------------------------------------------------------------------------------------------
--	���t�B�X�g�t�F���X�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Mefist_831000_Battle, "mefist_831000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Mefist_831000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function mefist_831000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF );				--������HP�������擾

	--������HP�c�肪1���ȏ�
	if hprate >= 0.1 then
	
		--�ʏ�s��
		mefist_831000Battle_Normal_Attack(ai, goal)
	
	--������HP�c�肪1���ȉ�
	else
	
		--�m���s��
		mefist_831000Battle_Normal_Attack(ai, goal)
	end
end


---------------------------------------------------------
--  �ʏ�s��
---------------------------------------------------------
function mefist_831000Battle_Normal_Attack(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q

local NormalR_Dist = 2.0			--�E��U���̓K���ԍ���

	--�߂��Ȃ�
	if targetDist >= NormalR_Dist then

		--50���@�����ċ߂Â��U��
		if fate <= 50 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			mefist_831000Battle_NormalR_Comb(ai, goal)
			mefist_831000Battle_Kougeki_Noato(ai, goal)
		
		--30% ���@�ōU��
		elseif fate <= 30 then
			mefist_831000Battle_Magic(ai, goal)
			
		--20% �����Đ��񂵂ėl�q��
		else
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,55), false, true ,-1 );
		end
		
	--�ɒ[�ɋ߂��Ȃ�
	else
		--15���@�U��
		if fate2 <= 15 then
			mefist_831000Battle_NormalR_Comb(ai, goal)
			
		--55���@�X�e�b�v�Ō��
		elseif fate2 <= 70 then
			mefist_831000Battle_Kougeki_Noato(ai, goal)
		
		--30% ���@�U��
		else
			mefist_831000Battle_Magic(ai, goal)
		
		end
	end
end


---------------------------------------------------------
--  �m���s��
---------------------------------------------------------
function mefist_831000Battle_Dying_Attack(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--�m������p
local NormalR_Dist = 2.0					--����̗L���͈�

	--50% �߂Â��ē˂��܂���
	if fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
	
	--50% �߂Â��Đ��񂵂ē˂��܂���
	else
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,55), false, true ,-1 );
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
	end

end

---------------------------------------------------------
--  �E��R���{�i�ʏ�j
---------------------------------------------------------
function mefist_831000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p
local NR_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local NR_fate3 = ai:GetRandam_Int(1,100)		--�m������p


local NormalATKPer	= 80		--�ʏ�U���̊���

	--����������Ă��Ȃ���Ύ����ւ���
	CommonNPC_ChangeWepR1(ai, goal)

	if NR_fate <= NormalATKPer then

		--30% �O�]�U��
		if NR_fate2 <= 30 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepF, TARGET_ENE_0, DIST_None, 0 )
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Middle, 0);

		--40% ���E�E
		elseif NR_fate2 <= 70 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		
		--30% �E��U��3��
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	
		end
	
		if NR_fate3 <= 60 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	else
		--�E�苭�U���P��
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);

	end
end	


---------------------------------------------------------
--  �U���E���@
---------------------------------------------------------
function mefist_831000Battle_Magic(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0)		--�G�^�[�Q�b�g�Ƃ̋������擾
local MagicDist = 0.7								--���@�̍U���͈�
local NormalR_Dist = 2.0							--�����U���̊ԍ���
local selfmp = ai:GetMp(TARGET_SELF)			--�����̎c��MP���擾
local fate = ai:GetRandam_Int(1,100)			--�m������p
local fate2 = ai:GetRandam_Int(1,100)			--�m������p

local		keinsei			= 30			--���񐧍U���̊���
local		mawarikomi 		= 50			--��荞�ފm��

	--������MP��100�ȏ�Ȃ�
	if selfmp >= 100 then
	
		--�����G�}�Ɏ����ւ���
		CommonNPC_ChangeWepR2(ai, goal)
		
		--���@�̓͂������ɂ��Ȃ����
		if targetDist >= MagicDist then
		
			--�����ċ߂Â��Ė��@
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, MagicDist, TARGET_ENE_0, false, -1 );
			
			if fate <= keinsei then
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
			end

			if fate2 <= mawarikomi then
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 4.0 , TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(90,120), false, true ,-1 );
			end
			
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_MagicR, TARGET_ENE_0, DIST_None, 0);
			mefist_831000Battle_Kougeki_Noato(ai, goal)
		
		--���@�̓͂������ɂ����
		else
		
			--��荞��ł��̏�Ŗ��@
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 4.0 , TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(90,120), false, true ,-1 );
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_MagicR, TARGET_ENE_0, DIST_None, 0);
			mefist_831000Battle_Kougeki_Noato(ai, goal)

		end
	
	--������MP��100�ȉ��Ȃ�
	else
	
		--�ʏ�U��
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		mefist_831000Battle_NormalR_Comb(ai, goal)
		mefist_831000Battle_Kougeki_Noato(ai, goal)
	end
	
end

---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function mefist_831000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local KN_fate2 = ai:GetRandam_Int(1,100)			--�m������p

	--50% �o�b�N�X�e�b�v
	if KN_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);

	--25% ���T�C�h�X�e�b�v
	elseif KN_fate <= 25	then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);

	--25% �E�T�C�h�X�e�b�v
	else
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
	end

	--50% �X�e�b�v�����
	if KN_fate2 <= 50 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,55), false, true ,-1 );
	end
end




---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function mefist_831000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function mefist_831000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function mefist_831000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local NormalR_Dist = 2.0			--�E��U���̓K���ԍ���


	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Ĕ����E���
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--�R���{���ꂷ�鋗��
local combRunPer = 40				--�R���{���ꂷ��m��
local combRunCountPer = 15			--�R���{����̌�ɍU������m��	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				mefist_831000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end
	end	
	
	--���ߋ����ōU�����ꂻ���ɂȂ����璴�����X�e�b�v
	if ai:IsInterupt( INTERUPT_FindAttack ) then
local superStepDist = 2.0			--���������鋗��
local superStepPer = 10				--����������m��	
		if targetDist <= superStepDist then
			if fate <= superStepPer then
			goal:ClearSubGoal();
			--�����
			mefist_831000Battle_Kougeki_Noato(ai, goal)
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
	
	--�A�C�e�����g������œK�s��
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 50				--�A�C�e���g�p���ɍœK�s�������m��
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();
			mefist_831000Battle_Magic(ai, goal)
			return true
		end
	end
	
return false;
end

