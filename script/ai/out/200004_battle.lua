-----------------------------------------------------------------------------------------------
--	�y�z�ꕺ�m�i�`���[�g���A���E���h���j�z�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_DoreiTANKEN_B200004_Battle, "doreiTANKEN_B200004Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_DoreiTANKEN_B200004_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function doreiTANKEN_B200004Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���


	--�ǂ����ݍs��
		--100�������Đڋ�
		--50����������
		--25�����E�ɃE���E��
		if targetDist >= NormalR_Dist then
--			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,9910 );
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );		
--			if fate <= 80 then
--				goal:AddSubGoal( GOAL_COMMON_KeepDist, 5.0, TARGET_ENE_0, ai:GetRandam_Float(1.0,1.9), ai:GetRandam_Float(2.0,3.0), TARGET_ENE_0, true, -1 );
--			end
		else
			if fate <= 50 then
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
			else
				goal:AddSubGoal(GOAL_COMMON_Wait, 2.0, TARGET_ENE_0, 0, 0, 0 )
			end
		end	
end

---------------------------------------------------------
--  �U��
---------------------------------------------------------
function doreiTANKEN_B200004Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--15% 3000	--40% 3000-3001�@--30% 3002�@--15% 3000-3001-3002
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
function doreiTANKEN_B200004Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local SideDist = 2.5							--���ɓ�������
local SideTime = 5.0							--���ɓ�������
local BackDist = 2.5							--��ނ��鋗��
local BackTime = 5.0							--��ނ��鎞��
local bRight = ai:GetRandam_Int(0,1);			--�E������
-- ���������ɍ��E�ړ����Ă��钇�Ԃ̐�
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);

	--20% �Ȃɂ����Ȃ��i������Ƃ������ړ��j	--50% �K���ɉ��ɃK�[�h�ړ�	--30% ���ɃK�[�h�ړ�
	if KN_fate < 20 and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, bRight, 15, true, true ,-1 );
	elseif KN_fate < 70 and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, bRight, ai:GetRandam_Int(30,45), true, true ,9910 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, 9910 );				
	end
end

	
	
---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function doreiTANKEN_B200004Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function doreiTANKEN_B200004Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function doreiTANKEN_B200004Battle_Interupt(ai, goal)
return false;
end


	