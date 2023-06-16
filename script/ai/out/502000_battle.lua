-----------------------------------------------------------------------------------------------
--	���̌��@�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Ounoken502000_Battle, "Ounoken502000Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Ounoken502000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function Ounoken502000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);				--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐����@���̂R

local AttRen_Dist_min = 0.0						--�A���U���̓K���ԍ����i�ŏ��j
local AttRen_Dist_max = 3.5						--�A���U���̓K���ԍ����i�ő�j
local Att3070_Dist_min = 3.0					--3070�Ԃ̓K���ԍ����i�ŏ��j
local Att3070_Dist_max = 5.5					--3070�Ԃ̓K���ԍ����i�ő�j


	--����Ɖ����Ȃ�A�����Ĕ���
	if targetDist >= 7.0 then
		if fate <= 60 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 4.5, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3070, TARGET_ENE_0, DIST_Middle, 0);
			Ounoken502000Battle_Kougeki_Noato(ai, goal)
		else
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, AttRen_Dist_max, TARGET_ENE_0, false, -1 );
			Ounoken502000Battle_Renzoku(ai, goal)
			Ounoken502000Battle_Kougeki_Noato(ai, goal)
		end
		
	--��≓���Ȃ�������߂Â��Ă���
	--���΂��΃X�e�b�v�U��
	elseif targetDist >= 3.5 then
		if fate <= 80 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, Att3070_Dist_max, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3070, TARGET_ENE_0, DIST_Middle, 0);
			Ounoken502000Battle_Kougeki_Noato(ai, goal)
		else
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, AttRen_Dist_max, TARGET_ENE_0, true, -1 );
			Ounoken502000Battle_Renzoku(ai, goal)
			Ounoken502000Battle_Kougeki_Noato(ai, goal)
		end
		
	--�߂����Ȃ��Ȃ�A�A���U����_��
	--�������K�[�h����������A�܂��˂���_��
	elseif targetDist >= 0.5 then
		if ai:IsTargetGuard( TARGET_ENE_0 ) and 
		   fate <= 75 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
			Ounoken502000Battle_Renzoku(ai, goal)
			Ounoken502000Battle_Kougeki_Noato(ai, goal)
		else 
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, AttRen_Dist_max, TARGET_ENE_0, true, -1 );
			Ounoken502000Battle_Renzoku(ai, goal)
			Ounoken502000Battle_Kougeki_Noato(ai, goal)
		end
		
	--�߂�����Ȃ�A�A���U����_�����A��C�ɋ����𗣂�	
	else
		if fate <= 75 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, AttRen_Dist_max, TARGET_ENE_0, true, -1 );
			Ounoken502000Battle_Renzoku(ai, goal)
			Ounoken502000Battle_Kougeki_Noato(ai, goal)
		else
			goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 4);
			--�X�e�b�v�̌�ɍU������
			local stepConutPer = 40					--�U�������݂�m��
			if fate2 <= stepConutPer then
				if KN_fate3 <= 50 then
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3060, TARGET_ENE_0, DIST_Middle, 0);
				end
			end
		end
	end
end	



---------------------------------------------------------
--  �A���U��
---------------------------------------------------------
function Ounoken502000Battle_Renzoku(ai, goal)

	local R_fate = ai:GetRandam_Int(1,100)
	local R_fate2 = ai:GetRandam_Int(1,100)

--[[�R�s�y�p
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3060, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3070, TARGET_ENE_0, DIST_Middle, 0);
]]
	
	--15�� 3000-3020-3050or3060				--�����Ȃ�˂��h��
	--5�� 3000-3030or3050					--�����Ȃ荶�ガ�n
	--20�� 3000-3010-3040or3060				--�R�A�ŉE�ガ�n
	--30�� 3000-3010-3020					--�R�A�œ˂��h��
	--10�� 3000-3010-3020-3060-3030or3050	--�R�A�œ˂��h���@�����ĂQ�A�ガ
	--10�� 3000-3010-3020-3050-3040or3060	--�R�A�œ˂��h���@�����ĂQ�A�ガ�i���E�Ⴂ�j
	--5�� 3060-3030or3050					--�����Ȃ�Q�A�ガ
	--5�� 3050-3040or3060					--�����Ȃ�Q�A�ガ�i���E�Ⴂ�j

	if R_fate <= 15 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
		if R_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3060, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	elseif R_fate <= 20 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		if R_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	elseif R_fate <= 40 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		if R_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3060, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	elseif R_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
		
	elseif R_fate <= 80 then	
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3060, TARGET_ENE_0, DIST_Middle, 0);
		if R_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	elseif R_fate <= 90 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
		if R_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3060, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	elseif R_fate <= 95 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3060, TARGET_ENE_0, DIST_Middle, 0);
		if R_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
		if R_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3060, TARGET_ENE_0, DIST_Middle, 0);
		end	
	end
	
end


---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function Ounoken502000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������p
local KN_fate2 = ai:GetRandam_Int(1,100)		--�m������p
local KN_fate3 = ai:GetRandam_Int(1,100)		--�m������p
local KN_fate4 = ai:GetRandam_Int(1,100)		--�m������p

	--65���@�Ȃɂ����Ȃ�
	--10���@�������Ɉړ�
	--5���@��ނŊԂ�������
	--20���@�X�e�b�v�Ō��
	if KN_fate <= 65 then
		
	elseif KN_fate <= 75 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
	elseif KN_fate <= 80 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, true, -1 );				
	else
		if KN_fate2 <= 70 then
			goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 4);
		elseif KN_fate2 <= 85 then
			goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0, AI_DIR_TYPE_L, 4);
		else
			goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0, AI_DIR_TYPE_R, 4);
		end
		
		--�X�e�b�v�̌�ɍU������
		local stepConutPer = 40					--�U�������݂�m��
		if KN_fate3 <= stepConutPer then
			if KN_fate4 <= 50 then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Near, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3060, TARGET_ENE_0, DIST_Near, 0);
			end
		end
	end
end




---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function Ounoken502000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function Ounoken502000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function Ounoken502000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);				--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐����@���̂R
local fate4 = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐����@���̂S
local fate5 = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐����@���̂T

local AttRen_Dist_min = 0.0						--�A���U���̓K���ԍ����i�ŏ��j
local AttRen_Dist_max = 3.5						--�A���U���̓K���ԍ����i�ő�j
local Att3070_Dist_min = 3.0					--3070�Ԃ̓K���ԍ����i�ŏ��j
local Att3070_Dist_max = 5.5					--3070�Ԃ̓K���ԍ����i�ő�j


	--��U�肵����U��
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 3.5			--��U��ǌ����鋗��
local MissSwingAttPer = 30			--��U��ǌ�����m��	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				--65���˂��Ă���A���U���@35���A���U��
				if fate2 <= 65 then
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
					Ounoken502000Battle_Renzoku(ai, goal)
				else
					Ounoken502000Battle_Renzoku(ai, goal)
				end
				Ounoken502000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end	
	end

	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Č��
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.5				--�R���{���ꂷ�鋗��
local combRunPer = 40				--�R���{���ꂷ��m��
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				if fate2 <= 60 then
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 4);
				elseif fate2 <= 80 then
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0, AI_DIR_TYPE_L, 4);
				else
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0, AI_DIR_TYPE_R, 4);
				end
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
				if fate2 <= 60 then
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 4);
				elseif fate2 <= 80 then
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0, AI_DIR_TYPE_L, 4);
				else
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0, AI_DIR_TYPE_R, 4);
				end
				return true;
			end
		end
	end

	--�K�[�h���󂵂���U��
	if ai:IsInterupt( INTERUPT_GuardBreak ) then
local guardBreakConutDist = 3.5			--�K�[�h����ōU�����鋗��
local guardBreakConutPer = 65			--�K�[�h����ōU������m��
		if targetDist <= guardBreakConutDist then
			if fate <= guardBreakConutPer then
				goal:ClearSubGoal();
				--65���˂��Ă���A���U���@35���A���U��
				if fate2 <= 65 then
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
					Ounoken502000Battle_Renzoku(ai, goal)
				else
					Ounoken502000Battle_Renzoku(ai, goal)
				end
				Ounoken502000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end
	end
	

	--��ѓ���������Ă�����œK�s��
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 40					--��ѓ���g�p���ɍœK�s�������m���i�߂��Ƃ��j
local shootIntPer2 = 65					--��ѓ���g�p���ɍœK�s�������m���i��≓���Ƃ��j
local shootIntPer3 = 90					--��ѓ���g�p���ɍœK�s�������m���i�����Ƃ��j
local Per2_Dist = 3.5					--�u��≓���v�̋���
local Per3_Dist = 5.5					--�u�����v�̋���
local shootIntConutPer = 75				--���������݂�m���i�߂��Ƃ��j
local shootIntConutPer2 = 65			--���������݂�m���i��≓���Ƃ��j
local shootIntConutPer3 = 65			--���������݂�m���i�����Ƃ��j

		--�߂�
		if targetDist <= Per2_Dist then
			if fate <= shootIntPer then
				goal:ClearSubGoal();
				if fate2 <= 50 then
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0, AI_DIR_TYPE_L, 4);
				else
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0, AI_DIR_TYPE_R, 4);
				end
				
				--�A���U��
				if fate3 <= shootIntConutPer then
					Ounoken502000Battle_Renzoku(ai, goal)
					Ounoken502000Battle_Kougeki_Noato(ai, goal)
				end
				return true
			end
			
		--��≓��
		elseif targetDist <= Per3_Dist then
			if fate <= shootIntPer2 then
				if fate2 <= 50 then
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0, AI_DIR_TYPE_L, 4);
				else
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0, AI_DIR_TYPE_R, 4);
				end
				
				--�X�e�b�v�U��
				if fate3 <= shootIntConutPer2 then
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3070, TARGET_ENE_0, DIST_Middle, 0);
					Ounoken502000Battle_Kougeki_Noato(ai, goal)
				end
				return true
			end
			
		--����
		else
			if fate <= shootIntPer3 then
				goal:ClearSubGoal();
				if fate2 <= 50 then
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0, AI_DIR_TYPE_L, 4);
				else
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0, AI_DIR_TYPE_R, 4);
				end
				
				if fate3 <= shootIntConutPer3 then
					--�{��̃_�b�V�����X�e�b�v�U��or�A���U��
					if fate4 <= 75 then
						goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3070_Dist_max, TARGET_ENE_0, false, -1 );
						goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3070, TARGET_ENE_0, DIST_Middle, 0);
						Ounoken502000Battle_Kougeki_Noato(ai, goal)
					else	
						goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, AttRen_Dist_max, TARGET_ENE_0, false, -1 );
						Ounoken502000Battle_Renzoku(ai, goal)
						Ounoken502000Battle_Kougeki_Noato(ai, goal)
					end
				end
				
				return true
			end	
		end
	end
	
return false;
end



