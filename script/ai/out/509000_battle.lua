-----------------------------------------------------------------------------------------------
--	Hiru509000��p�퓬
--	�����F�F�X�����Ⴎ���Ⴞ���ǁA�Ƃ肠�����U���Ή��͂��Ă���
--�@�@�@�@�������U���̑Ή��Ƃ�
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Hiru509000_Battle, "Hiru509000Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Hiru509000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function Hiru509000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------
local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋���
local fate = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐����@���̂Q
local fate3 = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐����@���̂R
local sekkin = ai:GetRandam_Float(0.75, 1.5)			--�ڋ߂��鋗��
local maai = ai:GetRandam_Float(0.75, 1.5)				--�ԍ����������鋗��
local hprate = ai:GetHpRate( TARGET_SELF )			--������HP�̎c�ʂ��擾

local farDist = 20.0		--�����Ɣ��f���鋗��
local nearDist = 14.0		--�߂��Ɣ��f���鋗��
local maaiDist = 5.0		--�U���̂��߂ɋ߂Â������@���ėp���ׁ̈A�U�����Ƃɕ�������

	-- �ŏ��ɂ�����Ƃ����҂�
	if ai:IsFinishTimer(0) == true then
		local firstTime = ai:GetRandam_Float(0.0, 3.0)			--�ŏ��̓����o���܂ł̎���
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
		ai:SetTimer( 0, 9999.0 );
	end

--[[����̈�ɋ���Ƃ��ɋ����I�Ƀq������������]]

local		Wait_time	=	2.0				--�񕜂̑҂�����

	if	ai:IsInsideTargetRegion( TARGET_ENE_0, 2020 ) 
		or ai:IsInsideTargetRegion( TARGET_ENE_0, 2021 ) 
		or ai:IsInsideTargetRegion( TARGET_ENE_0, 2022 )
		or ai:IsInsideTargetRegion( TARGET_ENE_0, 2023 ) then
		goal:AddSubGoal( GOAL_COMMON_Wait, Wait_time, TARGET_ENE_0);
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);
	else

	--�߂��Ȃ��Ȃ�
	if targetDist >= nearDist then
--~ 		--100% �ҋ@
--~ 		goal:AddSubGoal( GOAL_COMMON_Wait, 0.1, TARGET_ENE_0);
		
		if hprate < 0.95 then
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);
			
		else
			if fate2 < 90 then
				goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_ENE_0);
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3020, TARGET_ENE_0, DIST_None, 0);
				
			end
		end
		
--~ 		--75���@�����ڋ߁�10���@��荞�݁��Đڋ�
--~ 		--25���@�����ڋ߁��\��遨�U����s��
--~ 		if fate < 75 then
--~ 			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
--~ 			if fate2 < 10 then
--~ 				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
--~ 				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
--~ 			end
--~ 			
--~ 		else
--~ 			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 1.50, TARGET_ENE_0, true, -1 );
--~ 			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3020, TARGET_ENE_0, DIST_Near, 0);
--~ 			Hiru509000Battle_Kougeki_Noato(ai, goal)
--~ 		end
		
	--�߂��Ȃ�
	elseif targetDist >= maaiDist then
		--30% �ҋ@
		--70% �������i�g�ʁj�U��
		
		if fate < 30 then
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
		
		else
			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3040, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.0, TARGET_ENE_0);
		
		end
		
--~ 		--60���@�����ڋ߁���荞�݁��Đڋ߁@�@40���@����ɐڋ߁�50%�\���50%�E�r�ŉ���
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
--~ 		end
		
	else
	--�ԍ����ȓ��Ȃ�
		--�U������
		--�U����s��
		Hiru509000Battle_Kougeki(ai, goal)
		Hiru509000Battle_Kougeki_Noato(ai, goal)
	end
	end
end

---------------------------------------------------------
--  �U��
---------------------------------------------------------
function Hiru509000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--20% 3000�@�r���^
	--10% 3030�@�g�܂݂�U��
	--30% 3000-3010�@�r���^���r��U��񂷁
	--30% 3020�@�������\���
	--10% 3040�@�g��

		--�C�x���g����������E���Ă��āA�q������
	if (ai:GetEventRequest( 0 ) == AI_EVENT_LEECH_REGENERATE) then

		--�q������
		Hiru509000Battle_Hukkatsu(ai, goal)
		Hiru509000Battle_Kougeki_Pettern(ai, goal)
--		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);

	else
	
		--�ʏ�U��
		Hiru509000Battle_Kougeki_Pettern(ai, goal)
	
--		if K_fate < 20 then
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);

--		elseif K_fate < 30 then
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Near, 0);
			
--		elseif K_fate < 60 then
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Near, 0);
			
--		elseif K_fate < 90 then
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
			
--		else
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_None, 0);
			
--		end
		
	end
end

---------------------------------------------------------
--  �ʏ�U��
---------------------------------------------------------
function Hiru509000Battle_Kougeki_Pettern(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	if K_fate < 20 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);

	elseif K_fate < 30 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Near, 0);
			
	elseif K_fate < 60 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Near, 0);
			
	elseif K_fate < 90 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_None, 0);
	
	end

end


---------------------------------------------------------
--  �q������
---------------------------------------------------------
function Hiru509000Battle_Hukkatsu(ai, goal)

local hprate = ai:GetHpRate( TARGET_SELF )	--������HP�������擾
local fate = ai:GetRandam_Int(1,100)		--�m������p
local fate2 = ai:GetRandam_Int(1,100)		--�m������p2
local fate3 = ai:GetRandam_Int(1,100)		--�m������p3
local fate4 = ai:GetRandam_Int(1,100)		--�m������p4


--[[HP�̎c�芄�������ăq�������̕p�x��ς���]]

local		HPLevel1 = 0.85					--HP�̎c�ʃ��x���P�@85%�ȏ�
local		HPLevel2 = 0.60					--HP�̎c�ʃ��x���Q	60%�ȏ�		
local		HPLevel3 = 0.35					--HP�̎c�ʃ��x���R	35%�ȏ�
local		HPLevel4 = 0.0					--HP�̎c�ʃ��x���S	0%�ȏ�

local		RecoveryPer1 = 25				--HP�c�ʃ��x���P�̂Ƃ��̃q�������m��
local		RecoveryPer2 = 40				--HP�c�ʃ��x���Q�̂Ƃ��̃q�������m��
local		RecoveryPer3 = 55				--HP�c�ʃ��x���R�̂Ƃ��̃q�������m��
local		RecoveryPer4 = 80				--HP�c�ʃ��x���S�̂Ƃ��̃q�������m��


	if hprate >= HPLevel1 then
		
		if (fate <= RecoveryPer1) then
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);
		else
			Hiru509000Battle_Kougeki_Pettern(ai, goal)
		end
	
	elseif hprate >= HPLevel2 then
	
		if (fate2 <= RecoveryPer2) then
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);
		else
			Hiru509000Battle_Kougeki_Pettern(ai, goal)
		end
	
	elseif hprate >= HPLevel3 then
	
		if (fate3 <= RecoveryPer3) then
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);
		else
			Hiru509000Battle_Kougeki_Pettern(ai, goal)
		end	
	
	else
		
		if (fate4 <= RecoveryPer4) then
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);
		else
			Hiru509000Battle_Kougeki_Pettern(ai, goal)
		end

	end

end
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function Hiru509000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local SideTime = 0.5							--���ɓ�������
local BackDist = ai:GetRandam_Float(0.75, 1.5)	--��ނ��鋗��
local BackTime = 0.5							--��ނ��鎞��


local bRight = ai:GetRandam_Int(0,1);							--���E�ړ��̕���
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- ���������ɍ��E�ړ����Ă��钇�Ԃ̐�



--���ɉ���������ɂƂ��ǂ����ړ�������Ɨǂ�����
--���܂�ɋ߂����鉡�ړ������A�������������Ă��牡�ړ�������Ɨǂ�����

	--100% �Ȃɂ����Ȃ�
	--0% �K���ɉ��Ɉړ�
	--0% ���Ɉړ�
	if KN_fate < 100  and friendNum < 1 then
		goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
--~ 		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 10, true, true ,-1 );
	elseif KN_fate < 100  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end



---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function Hiru509000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function Hiru509000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function Hiru509000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)						--�m������Ŏg�p����^���̐���
local maaiDist = 1.0										--�U���̂��߂ɋ߂Â������@���ėp���ׁ̈A�U�����Ƃɕ�������

	--��U��ǂ�����
	--25���@�߂��̃^�[�Q�b�g����U�肵����U��
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < maaiDist then
			if fate <= 25 then
				goal:ClearSubGoal();
				Hiru509000Battle_Kougeki(ai, goal)
				Hiru509000Battle_Kougeki_Noato(ai, goal)
				return true;
			end	
		end
	end
	
	
--~ 	--��ѓ���������Ă�����œK�s��
--~ 	if ai:IsInterupt( INTERUPT_Shoot ) then
--~ local shootIntPer = 100						--��ѓ���g�p���ɍœK�s�������m��
--~ local hprate = ai:GetHpRate( TARGET_SELF )	--������HP�̎c�ʂ��擾
--~ 		if fate <= shootIntPer then
--~ 			if targetDist >= 14.0 then
--~ 				if hprate <= 0.95 then
--~ 				goal:ClearSubGoal();
--~ 				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);
--~ 				end
--~ 			end
--~ 			return true;
--~ 		end
--~ 	end

return false;

end
