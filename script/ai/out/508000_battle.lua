-----------------------------------------------------------------------------------------------
--	Haetakari508000��p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Haetakari508000_Battle, "Haetakari508000Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Haetakari508000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function Haetakari508000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋���
local fate = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐����@���̂R
local sekkin = ai:GetRandam_Float(0.75, 1.5)			--�ڋ߂��鋗��
local maai = ai:GetRandam_Float(0.75, 1.5)				--�ԍ����������鋗��
local rate = ai:GetHpRate( TARGET_SELF )				--������HP

local farDist = 15.0		--�����Ɣ��f���鋗��
local masiDist = 10.0		--���}�V���K���������
local nearDist = 5.5		--�߂��Ɣ��f���鋗��
local maaiDist = 2.0		--�U���̂��߂ɋ߂Â������@���ėp���ׁ̈A�U�����Ƃɕ�������

local SideTime = 5.0		--���ɓ�������

	-- �ŏ��ɂ�����Ƃ����҂�
	if ai:IsFinishTimer(0) == true then
		local firstTime = ai:GetRandam_Float(0.0, 1.0)			--�ŏ��̓����o���܂ł̎���
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
		ai:SetTimer( 0, 9999.0 );
	end

	if ai:IsInsideTargetRegion( TARGET_SELF, 2235) then
	
		--�߂��Ȃ��Ȃ�
		if targetDist >= nearDist then
			--30���@�����ڋ߁�50���@�E�r�U�艺�낵 80% HP��2���ȉ��Ŏ����ɔ���Z�킹��
			--80���@�����΂��i�������U���j���ڋ�
			if fate < 30 then
				if fate3 < 40 then
					goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 2.0, TARGET_ENE_0, nearDist, TARGET_ENE_0, true, -1 );
				else
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
				end
					if fate2 < 50 then
						goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_None, 0);
					elseif fate2 < 80 then
						if rate < 0.2 then
							goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_None, 0);
						else
							if targetDist < masiDist then
								goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_None, 0);
							else
								goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3060, TARGET_ENE_0, DIST_None, 0);
							end
						end
					end
				
			else
				if targetDist < masiDist then
					goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3030, TARGET_ENE_0, DIST_None, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3060, TARGET_ENE_0, DIST_None, 0);
				end
				if fate3 < 40 then
					goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 2.0, TARGET_ENE_0, nearDist, TARGET_ENE_0, true, -1 );
				else
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
				end
			end
			
			
	--~ 	--�߂��Ȃ�
	--~ 	elseif targetDist >= maaiDist then
	--~ 		--60���@�����ڋ߁���荞�݁��Đڋ�
	--~ 		--40���@����ɐڋ߁�50%�\���50%�E�r�ŉ���
	--~ 		if fate < 60 then
	--~ 			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
	--~ 			if fate2 < 50 then
	--~ 				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
	--~ 				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
	--~ 			end
	--~ 		else
	--~ 			goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, 0.3, 0.8, TARGET_ENE_0, true, -1 );
	--~ 			if fate2 < 50 then
	--~ 				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3020, TARGET_ENE_0, DIST_Near, 0);
	--~ 			else
	--~ 				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
	--~ 			end
	--~ 		end
			

		--���ߋ����Ȃ�
		elseif targetDist < maaiDist then
			--50% ������
			--10% �\���
			--40% �E�r�ŉ���
			if fate < 50 then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Near, 0);
				
			elseif fate < 60 then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
			
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
				
			end

		else
		--�ԍ����ȓ��Ȃ� (maaiDist < x <= nearDist)
			--�U������
			--�U����s��
			Haetakari508000Battle_Kougeki(ai, goal)
			Haetakari508000Battle_Kougeki_Noato(ai, goal)
		end

	else
		--�����������ѓ���A�߂������牣��
 		if targetDist > nearDist then
 			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_None, 0);
 		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_None, 0);
 		end
		--�̈悩��߂�
		goal:AddSubGoal(GOAL_COMMON_BackToHome, 4.0, -1, 0, 0, 0 );
	end
	
end

---------------------------------------------------------
--  �U��
---------------------------------------------------------
function Haetakari508000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local rate = ai:GetHpRate( TARGET_SELF )				--������HP

	--45% 3000�@�E�r�ŉ���
	--20% 3000-3010�@�E�r�ŉ��違�E�r�U�艺�낵�
	--30% 3020�@�\���
	--05% 3040�@�����ɔ���Z�킹��

	if K_fate < 45 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
	elseif K_fate < 65 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Near, 0);
	elseif K_fate < 95 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
	else
		if rate < 0.2 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Near, 0);

		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);

		end
	end
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function Haetakari508000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local SideTime = 0.5							--���ɓ�������
local BackDist = ai:GetRandam_Float(0.75, 1.5)	--��ނ��鋗��
local BackTime = 0.5							--��ނ��鎞��


local bRight = ai:GetRandam_Int(0,1);							--���E�ړ��̕���
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- ���������ɍ��E�ړ����Ă��钇�Ԃ̐�



--���ɉ���������ɂƂ��ǂ����ړ�������Ɨǂ�����
--���܂�ɋ߂����鉡�ړ������A�������������Ă��牡�ړ�������Ɨǂ�����

	--25% �Ȃɂ����Ȃ��i������Ƃ������ړ��j
	--50% �K���ɉ��Ɉړ�
	--25% ���Ɉړ�
	if KN_fate < 25  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 10, true, true ,-1 );
	elseif KN_fate < 75  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end



---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function Haetakari508000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function Haetakari508000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function Haetakari508000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐���
local maaiDist = 1.0										--�U���̂��߂ɋ߂Â������@���ėp���ׁ̈A�U�����Ƃɕ�������

	--��U��ǂ�����
	--25���@�߂��̃^�[�Q�b�g����U�肵����U��
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < maaiDist then
			if fate <= 25 then
				goal:ClearSubGoal();
				Haetakari508000Battle_Kougeki(ai, goal)
				Haetakari508000Battle_Kougeki_Noato(ai, goal)
				return true;
			end	
		end
	end

return false;

end
