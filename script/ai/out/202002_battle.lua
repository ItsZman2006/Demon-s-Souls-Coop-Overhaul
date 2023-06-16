-----------------------------------------------------------------------------------------------
--	�R�m�p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Kisi202002_Battle, "kisi202002Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Kisi202002_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function kisi202002Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾

local fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂R
local fate4 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂S
local fate5 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂T

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 2.3					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3300_Dist_min = 0.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
local Att3300_Dist_max = 3.2					--3300�Ԃ̓K���ԍ����i�ő�j
local Att3301_Dist_min = 2.3					--3301�Ԃ̓K���ԍ����i�ŏ��j
local Att3301_Dist_max = 6.7					--3301�Ԃ̓K���ԍ����i�ő�j
local Att9800_Dist_min = 0.0					--9800�Ԃ̓K���ԍ����i�ŏ��j
local Att9800_Dist_max = 1.3					--9800�Ԃ̓K���ԍ����i�ő�j

local Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
local Act02Per = 0		--���s�ڋ߁��K�[�h����
local Act03Per = 0		--�_�b�V���ڋ߁��ˌ�	
local Act04Per = 0		--�_�b�V���ڋ߁��ߐڍU��
local Act05Per = 0		--���s�ڋ߁��ˌ�
local Act06Per = 0		--���s�ڋ߁����U��
local Act07Per = 0		--���s�ڋ߁��ߐڍU��
local Act08Per = 0		--�񕜂��g��

	--�g�o�������Ă�����A���m���ŉ񕜖���g��
	if hprate <= 0.4 and fate <= 50 then
		Act08Per = 100		--�񕜂��g��
		
	--�����Ȃ�
	elseif targetDist >= 8.0 then
		--PC���w�������Ă�����
		if ai:IsInsideTargetEx( TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_B, 30.0, 100) then
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 95		--�_�b�V���ڋ߁��ˌ�	
			Act04Per = 5		--�_�b�V���ڋ߁��ߐڍU��
			Act05Per = 0		--���s�ڋ߁��ˌ�
			Act06Per = 0		--���s�ڋ߁����U��
			Act07Per = 0		--���s�ڋ߁��ߐڍU��
			Act08Per = 0		--�񕜂��g��
			
		--PC���K�[�h���Ă�����	
		elseif ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 40		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 5		--���s�ڋ߁��K�[�h����
			Act03Per = 50		--�_�b�V���ڋ߁��ˌ�	
			Act04Per = 5		--�_�b�V���ڋ߁��ߐڍU��
			Act05Per = 0		--���s�ڋ߁��ˌ�
			Act06Per = 0		--���s�ڋ߁����U��
			Act07Per = 0		--���s�ڋ߁��ߐڍU��
			Act08Per = 0		--�񕜂��g��
			
		--�ǂ���ł��Ȃ�������	
		else
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 95		--�_�b�V���ڋ߁��ˌ�	
			Act04Per = 5		--�_�b�V���ڋ߁��ߐڍU��
			Act05Per = 0		--���s�ڋ߁��ˌ�
			Act06Per = 0		--���s�ڋ߁����U��
			Act07Per = 0		--���s�ڋ߁��ߐڍU��
			Act08Per = 0		--�񕜂��g��
			
		end	
		
	--�_�b�V�����Ă��ǂ����x�ɉ����Ȃ�	
	elseif targetDist >= 4.0 then	
		--PC���K�[�h���Ă�����
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 40		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 5		--���s�ڋ߁��K�[�h����
			Act03Per = 50		--�_�b�V���ڋ߁��ˌ�	
			Act04Per = 5		--�_�b�V���ڋ߁��ߐڍU��
			Act05Per = 0		--���s�ڋ߁��ˌ�
			Act06Per = 0		--���s�ڋ߁����U��
			Act07Per = 0		--���s�ڋ߁��ߐڍU��
			Act08Per = 0		--�񕜂��g��
			
		else
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 0		--�_�b�V���ڋ߁��ˌ�	
			Act04Per = 25		--�_�b�V���ڋ߁��ߐڍU��
			Act05Per = 50		--���s�ڋ߁��ˌ�
			Act06Per = 10		--���s�ڋ߁����U��
			Act07Per = 15		--���s�ڋ߁��ߐڍU��
			Act08Per = 0		--�񕜂��g��
			
		end
		
	--�ːi�˂����Ă��ǂ����x�ɉ����Ȃ�
	elseif targetDist >= 2.5 then	
		--PC���K�[�h���Ă�����80���̊m����	
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 40		--���s�ڋ߁��K�[�h����
			Act03Per = 0		--�_�b�V���ڋ߁��ˌ�	
			Act04Per = 0		--�_�b�V���ڋ߁��ߐڍU��
			Act05Per = 50		--���s�ڋ߁��ˌ�
			Act06Per = 5		--���s�ڋ߁����U��
			Act07Per = 5		--���s�ڋ߁��ߐڍU��
			Act08Per = 0		--�񕜂��g��
			
		else
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 0		--�_�b�V���ڋ߁��ˌ�	
			Act04Per = 0		--�_�b�V���ڋ߁��ߐڍU��
			Act05Per = 65		--���s�ڋ߁��ˌ�
			Act06Per = 10		--���s�ڋ߁����U��
			Act07Per = 25		--���s�ڋ߁��ߐڍU��
			Act08Per = 0		--�񕜂��g��
			
		end
		
	else	
		--PC���K�[�h���Ă�����80���̊m����	
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 60		--���s�ڋ߁��K�[�h����
			Act03Per = 0		--�_�b�V���ڋ߁��ˌ�	
			Act04Per = 0		--�_�b�V���ڋ߁��ߐڍU��
			Act05Per = 0		--���s�ڋ߁��ˌ�
			Act06Per = 15		--���s�ڋ߁����U��
			Act07Per = 25		--���s�ڋ߁��ߐڍU��
			Act08Per = 0		--�񕜂��g��
			
		else
			Act01Per = 0		--�_�b�V���ڋ߁��K�[�h����
			Act02Per = 0		--���s�ڋ߁��K�[�h����
			Act03Per = 0		--�_�b�V���ڋ߁��ˌ�	
			Act04Per = 0		--�_�b�V���ڋ߁��ߐڍU��
			Act05Per = 0		--���s�ڋ߁��ˌ�
			Act06Per = 25		--���s�ڋ߁����U��
			Act07Per = 75		--���s�ڋ߁��ߐڍU��
			Act08Per = 0		--�񕜂��g��
			
		end
	end

	--�s��01�@�_�b�V���ڋ߁��K�[�h����
	if fate2 <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att9800_Dist_max, TARGET_ENE_0, false, 9910 );
		goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 5.0, 9800, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��02�@���s�ڋ߁��K�[�h����
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att9800_Dist_max, TARGET_ENE_0, true, 9910 );
		goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 5.0, 9800, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��03�@�_�b�V���ڋ߁��ˌ�
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3301_Dist_max, TARGET_ENE_0, false, 9910 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��04�@�_�b�V���ڋ߁��ߐڍU��
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, 9910 );
		kisi202002Battle_Kougeki(ai, goal)
		
	--�s��05�@���s�ڋ߁��ˌ�
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3301_Dist_max, TARGET_ENE_0, true, 9910 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��06�@���s�ڋ߁����U��
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3300_Dist_max, TARGET_ENE_0, true, 9910 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��07�@���s�ڋ߁��ߐڍU��
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, 9910 );
		kisi202002Battle_Kougeki(ai, goal)
		
	--�s��08�@�񕜖���g��
	else
		goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 3.0, TARGET_ENE_0, true, 9910 );				
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6200, TARGET_ENE_0, DIST_Far, 0);	
		
	end
	kisi202002Battle_Kougeki_Noato(ai, goal)
	
end

---------------------------------------------------------
--  �U��
---------------------------------------------------------
function kisi202002Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--20���@3000-3001
	--70���@3000-3001-3002
	--10���@3000-3001-3300
	if K_fate <= 20 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 90 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function kisi202002Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐���
local KN_fate2 = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐����@���̂Q

local SideTime = 4.0							--���ɓ�������
local BackDist = 2.5							--��ނ��鋗��
local BackTime = 4.0							--��ނ��鎞��

	--55���@�������Ȃ�
	--30���@�K���ɉ��Ɉړ�
	--15���@�����������Ă��牡�Ɉړ�
	if KN_fate <= 55 then
		
	elseif KN_fate <= 85 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,9910 );
		
	else
		goal:AddSubGoal(GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, 9910 );
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,9910 );
	end
end




---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function kisi202002Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function kisi202002Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function kisi202002Battle_Interupt(ai, goal)

local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾
local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐����@���̂Q

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 2.3					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3300_Dist_min = 0.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
local Att3300_Dist_max = 3.2					--3300�Ԃ̓K���ԍ����i�ő�j
local Att3301_Dist_min = 2.3					--3301�Ԃ̓K���ԍ����i�ŏ��j
local Att3301_Dist_max = 6.7					--3301�Ԃ̓K���ԍ����i�ő�j
local Att9800_Dist_min = 0.0					--9800�Ԃ̓K���ԍ����i�ŏ��j
local Att9800_Dist_max = 1.3					--9800�Ԃ̓K���ԍ����i�ő�j


	--��U��ǂ������@�����ʊ֐�
local missSwingDist		= 6.7		--��U��ǌ����鋗��
local missSwingAttPer	= 20		--��U��ǌ�����m��
	if MissSwing_Act(ai, goal, missSwingDist, missSwingAttPer ) then
		goal:ClearSubGoal();
		--�����ʂɑΉ�
		if targetDist >= 3.2 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
			
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
		end
		kisi202002Battle_Kougeki_Noato(ai, goal)
		return true;
	end

	
	--�K�[�h���낵�ǂ������@�����ʊ֐�
local guardFinishConutDist	= 6.7		--�K�[�h�I���ōU�����鋗��
local guardFinishConutPer	= 10		--�K�[�h�I���ōU������m��
	if FindGuardFinish_Act(ai, goal, guardFinishConutDist, guardFinishConutPer ) then
		goal:ClearSubGoal();
		--�����ʂɑΉ�
		if targetDist >= 3.2 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
			
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
		end
		kisi202002Battle_Kougeki_Noato(ai, goal)
		return true;
	end

	-- �R���{����@�����ʊ֐�
local combRunDist		= 1.5		--�R���{���ꂷ�鋗��
local combRunPer		= 30		--�R���{���ꂷ��m��
	if Damaged_Act(ai, goal, combRunDist, combRunPer ) then
		goal:ClearSubGoal();
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 4.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,9910 );
		--���m���Ŕ���
		if fate2 <= 30 then
			goal:AddSubGoal(GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, Att3301_Dist_min, Att3301_Dist_max, TARGET_ENE_0, true, 9910 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
			kisi202002Battle_Kougeki_Noato(ai, goal)
		end
		return true;
	end	
	
	--�������K�[�h
	--�߂��ōU�����Ă���l��������
	if ai:IsInterupt( INTERUPT_FindAttack ) then
		if targetDist <= 2.0 then
			-- ���g�̂g�o������80���ȏ�Ȃ�
			if hprate >= 0.8 then
				--25���@�K�[�h�Ō��
				if fate <= 25 then
					goal:ClearSubGoal();
					goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 4.0, TARGET_ENE_0, 2.5, TARGET_ENE_0, true, 9910 );
					return true;
				end
				
			-- ���g�̂g�o������80���ȏ�łȂ��Ȃ�
			else
				--50���@�K�[�h�Ō��
				if fate <= 50 then
					goal:ClearSubGoal();
					goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 4.0, TARGET_ENE_0, 2.5, TARGET_ENE_0, true, 9910 );
					return true;
				end
			end
		end
	end


	--�K�[�h���󂵂���U���@�����ʊ֐�
local guardBreakConutDist = 6.7			--�K�[�h����ōU�����鋗��
local guardBreakConutPer = 65			--�K�[�h����ōU������m��
	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
		goal:ClearSubGoal();
		--�����ʂɑΉ�
		if targetDist >= 3.2 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
			
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
		end
		kisi202002Battle_Kougeki_Noato(ai, goal)
		return true;
	end	
	
	--��ѓ���ǂ�����
	--�^�[�Q�b�g����ѓ���𔭎˂�����A�������Ή��s��
	if ai:IsInterupt( INTERUPT_Shoot ) then
		if kisi202002Battle_Enkyori(ai, goal ) == true then
		return true
		end
	end
	
	--�A�C�e���g�p�ǂ�����
	--�^�[�Q�b�g���A�C�e�����g��������A�������Ή��s��
	if ai:IsInterupt( INTERUPT_UseItem ) then
		if kisi202002Battle_Enkyori(ai, goal ) == true then
		return true
		end
	end
	
	
return false;
end


---------------------------------------------------------
--  �������Ή�
---------------------------------------------------------
function kisi202002Battle_Enkyori(ai, goal )

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐���

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 2.3					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3300_Dist_min = 0.0					--3300�Ԃ̓K���ԍ����i�ŏ��j
local Att3300_Dist_max = 3.2					--3300�Ԃ̓K���ԍ����i�ő�j
local Att3301_Dist_min = 2.3					--3301�Ԃ̓K���ԍ����i�ŏ��j
local Att3301_Dist_max = 6.7					--3301�Ԃ̓K���ԍ����i�ő�j
local Att9800_Dist_min = 0.0					--9800�Ԃ̓K���ԍ����i�ŏ��j
local Att9800_Dist_max = 1.3					--9800�Ԃ̓K���ԍ����i�ő�j

	--���U���̊ԍ����ȓ��Ȃ�
	if targetDist <= Att3300_Dist_max then
		--90���@���U��
		if fate <= 90 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			kisi202002Battle_Kougeki_Noato(ai, goal)
			return true;
		end
		
	--�ˌ��̊ԍ����ȓ��Ȃ�	
	elseif targetDist <= Att3301_Dist_max then
		--90���@�ˌ�
		if fate <= 90 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
			kisi202002Battle_Kougeki_Noato(ai, goal)
			return true;
		end		
		
	--�������߂����Ȃ��Ȃ�	
	elseif targetDist <= 12.0 then
		--70���@�ˌ�
		if fate <= 70 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3301_Dist_max, TARGET_ENE_0, false, 9910 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
			kisi202002Battle_Kougeki_Noato(ai, goal)
			return true;
		end
		
	--�����Ȃ�
	else
		--45���@�ːi�˂�
		if fate <= 45 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3301_Dist_max, TARGET_ENE_0, false, 9910 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
			kisi202002Battle_Kougeki_Noato(ai, goal)
			return true;
		end
		
	end
	
return false
end


