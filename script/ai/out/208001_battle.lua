-----------------------------------------------------------------------------------------------
--	�y�����z�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Gokuri208001_Battle, "gokuri208001Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_gokuri208001_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function gokuri208001Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾
local targethprate = ai:GetHpRate( TARGET_ENE_0 )	--�G�^�[�Q�b�g��HP�������擾
local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q

local farDist = 15.0		--����Ɖ����Ɣ��f���鋗��
local nonPassDist = 10.0	--�p�X�ړ��ŋ߂Â������i���x�Ɏ��M�Ȃ��j�@���b��[�u���@���������폜����
local nearDist = 3.0		--�߂��Ɣ��f���鋗��
local maaiDist = 2.0		--�U���̂��߂ɋ߂Â������@���ėp���ׁ̈A�U�����Ƃɕ�������

	--�����Ȃ�
	if targetDist >= farDist then
		--30���@�����ċ߂Â�
		--0���@�R���قǕ����Ă��瑖���ċ߂Â�
		--70���@�����ċ߂Â�
		if fate < 30 then
--			goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 10.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, nonPassDist, TARGET_ENE_0, true );
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 16.0, TARGET_ENE_0, true, -1 );
				--���A����̖��@�U��
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
		elseif fate < 0 then
--			goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 10.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, (targetDist - 3.0), TARGET_ENE_0, true );
--			goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 10.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, nonPassDist, TARGET_ENE_0, false );
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, (targetDist - 3.0), TARGET_ENE_0, true, -1 );
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
		else
--			goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 10.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, nonPassDist, TARGET_ENE_0, false );
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 16.0, TARGET_ENE_0, false, -1 );
				--���A����̖��@�U��
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
		end
		
	--�������Ȃ����߂����Ȃ��Ȃ�
	elseif targetDist >= nearDist then
		--70���@�����ċ߂Â�
		--30���@�����ċ߂Â�
		if fate < 70 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
		else
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
		end
		
	--�߂��Ȃ�	
	elseif targetDist >= maaiDist then
		--100���@�����ċ߂Â�
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
		
	--�ԍ����ȓ��Ȃ�
	else
		--�U������
		gokuri208001Battle_Kougeki(ai, goal)
		
		--�U����s��
		gokuri208001Battle_Kougeki_Noato(ai, goal)
		
	end
end


---------------------------------------------------------
--  �U��
---------------------------------------------------------
function gokuri208001Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--15% 3000
	--40% 3000-3001
	--30% 3002
	--15% 3000-3001-3002
	if K_fate < 15 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate < 55 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate < 85 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function gokuri208001Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local SideDist = 2.5							--���ɓ�������
local SideTime = 5.0							--���ɓ�������
local BackDist = 2.5							--��ނ��鋗��
local BackTime = 5.0							--��ނ��鎞��

	--70% �Ȃɂ����Ȃ��i������Ƃ����҂j
	--0% �K���ɉ��Ɉړ�
	--30% ���Ɉړ�
	if KN_fate < 70 then
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.0,0.5) ,0,0,0,0)
	elseif KN_fate < 0 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true, 9910);
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end

	
	
---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function gokuri208001Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function gokuri208001Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function gokuri208001Battle_Interupt(ai, goal)

local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾
local targethprate = ai:GetHpRate( TARGET_ENE_0 )	--�G�^�[�Q�b�g��HP�������擾
local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂Q
	
local maaiDist = 2.0		--�U���̂��߂ɋ߂Â������@���ėp���ׁ̈A�U�����Ƃɕ�������

	-- �R���{����p
	-- �^�[�Q�b�g���߂����Ƀ_���[�W���󂯂��Ȃ�
	if ai:IsInterupt( INTERUPT_Damaged ) then
		if targetDist < 2.0 then
			local combPer = 0			--�R���{��������s����m��
			local CountPer = 20			--�R���{����̌�ɍU������m��
			if fate <= combPer then
				--�K�[�h���ĉ�����
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 3.0, TARGET_ENE_0, true, -1 );				
				if fate2 <= CountPer then
					--�K�[�h���ċ߂Â�
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
					--�U������
					gokuri208001Battle_Kougeki(ai, goal)
					--�U����s��
					gokuri208001Battle_Kougeki_Noato(ai, goal)
				end
				return true;
			end
		end
	end
	
	-- �^�[�Q�b�g���߂����ɁA�^�[�Q�b�g���K�[�h�������ԂɂȂ�����
	if ai:IsInterupt( INTERUPT_GuardBreak ) then
		if targetDist < 2.0 then
			local oiutiPer = 40			--�K�[�h����ǂ����������s����m��
			if fate <= oiutiPer then		
				goal:ClearSubGoal();
					--�U������
					gokuri208001Battle_Kougeki(ai, goal)
					--�U����s��
					gokuri208001Battle_Kougeki_Noato(ai, goal)
			end
			return true;
		end
	end
	
return false;
end


	