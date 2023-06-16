-----------------------------------------------------------------------------------------------
--	�ÎE�җp�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Ansatu203000_Battle, "ansatu203000Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Ansatu203000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function ansatu203000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂R

local farDist = 15.0				--����Ɖ����Ɣ��f���鋗��
local nearDist = 6.0				--�߂��Ɣ��f���鋗��
local maaiDist = 1.0				--�U���̂��߂ɋ߂Â������@���ėp���ׁ̈A�U�����Ƃɕ�������
local AttHanyouDist = 1.5			--�ėp�U���֐������s���鋗��
local Att3004Dist = 6.0				--�U��3004�����s���鋗��

local role = ai:GetTeamOrder(ORDER_TYPE_Role);					--�����̖������擾

	--�U�����A���̑����Ȃ�
	if role == ROLE_TYPE_Attack or role == ROLE_TYPE_None then
		--�����Ȃ�
		if targetDist >= farDist then
			--60���@�K�؂Ȋԍ����Ńi�C�t����������
			if fate2 < 60 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3004Dist, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3004, TARGET_ENE_0, DIST_Far, 0);
				if fate3 < 50 then
					goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3004, TARGET_ENE_0, DIST_Far, 0);
				end
				
			--40���@�K�؂Ȋԍ����Ŕėp�U�������A�U����s��������
			else
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, AttHanyouDist, TARGET_ENE_0, false, -1 );
				ansatu203000Battle_Kougeki(ai, goal)
				ansatu203000Battle_Kougeki_Noato(ai, goal)
				
			end
			
		--�������Ȃ����߂����Ȃ��Ȃ�
		elseif targetDist >= nearDist then
			--���m���Ńi�C�t�𓊂��Ă���A�����ċ߂Â�
			if fate2 < 75 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3004, TARGET_ENE_0, DIST_Far, 0);
				if fate3 < 50 then
					goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3004, TARGET_ENE_0, DIST_Far, 0);
				end
			end
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
			
		--�߂��Ȃ�	
		elseif targetDist >= maaiDist then
			--100���@�����ĕ����ċ߂Â�
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
			
		--�ԍ����ȓ��Ȃ�
		else
			--�U������
			ansatu203000Battle_Kougeki(ai, goal)
			
			--�U����s��
			ansatu203000Battle_Kougeki_Noato(ai, goal)
			
		end
		
	--��芪�����Ȃ�
	elseif role == ROLE_TYPE_Torimaki then
		--�T���܂ő����ċ߂Â�
		--�����������ړ�
		--50���@�S���܂ŉ�������
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 5.0, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 15, true, true ,-1 );
		if fate < 50 then
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, true, -1 );				
		end		
		
	--�ϏO���Ȃ�
	else
		--�X���܂ő����ċ߂Â�
		--�����������ړ�
		--50���@�W���܂ŉ�������
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 9.0, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 15, true, true ,-1 );
		if fate < 50 then
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 8.0, TARGET_ENE_0, true, -1 );				
		end
	end	

end


---------------------------------------------------------
--  �U��
---------------------------------------------------------
function ansatu203000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)							--�m������Ŏg�p����^���̐���
local K_fate2 = ai:GetRandam_Int(1,100)							--�m������Ŏg�p����^���̐����@���̂Q

	--�P�T���@3000-3001-3002
	--�P�T���@3000-3001-3300-(3002)	
	--�P�O���@3000-3300-3001-(3002)	
	--�Q�O���@3001-3002-(3300)	
	--�Q�O���@3002-3001-3000-(3001)	
	--�Q�O���@3300-3001-(3002)	
	if K_fate < 15 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif K_fate < 30 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		if K_fate2 < 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	elseif K_fate < 40 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		if K_fate2 < 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	elseif K_fate < 60 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		if K_fate2 < 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	elseif K_fate < 80 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		if K_fate2 < 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		if K_fate2 < 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		end
	end
	
end


---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function ansatu203000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local KN_fate2 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q
local KN_fate3 = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂R
local SideDist = 2.5							--���ɓ�������
local SideTime = 5.0							--���ɓ�������
local BackDist = 2.5							--��ނ��鋗��
local BackTime = 5.0							--��ނ��鎞��


local bRight = ai:GetRandam_Int(0,1);			--���E�ړ��̕���
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- ���������ɍ��E�ړ����Ă��钇�Ԃ̐�



--���ɉ���������ɂƂ��ǂ����ړ�������Ɨǂ�����
--���܂�ɋ߂����鉡�ړ������A�������������Ă��牡�ړ�������Ɨǂ�����

	--20% �Ȃɂ����Ȃ��i������Ƃ������ړ��j
	--40% �o�b�N�X�e�b�v�P��or�Q��
	--40% �o�b�N�X�e�b�v�O��or�P��̂��ƃT�C�h�X�e�b�v
	if KN_fate < 20  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
		
	elseif KN_fate < 60 then
		goal:AddSubGoal(GOAL_COMMON_Step, 5.0, 701, 0, 0, 0);
		if KN_fate2 < 50 then
			goal:AddSubGoal(GOAL_COMMON_Step, 5.0, 701, 0, 0, 0);
		end
		
	else
		if KN_fate2 < 50 then
			goal:AddSubGoal(GOAL_COMMON_Step, 5.0, 701, 0, 0, 0);
		end	
		goal:AddSubGoal(GOAL_COMMON_Step, 5.0, ai:GetRandam_Int(702,703), 0, 0, 0);		
		
	end
end

	
	
---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function ansatu203000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function ansatu203000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function ansatu203000Battle_Interupt(ai, goal)

return false;
end



	