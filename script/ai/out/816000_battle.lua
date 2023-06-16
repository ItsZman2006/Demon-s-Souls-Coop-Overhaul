--[[*******************************************************************************************
	�K���E���B�������h�p�퓬
	�����F

	�p�����[�^0  �Ȃ�
	�p�����[�^1  �Ȃ�
	�p�����[�^2  �Ȃ�
	�p�����[�^3�@�Ȃ�
	
	��ai:SetNumber()�̎g�p�󋵁B
		�O�F0�őO�q�}�����[�h�A1�őދp���[�h�A2�Ń��[�v����q���[�h�B
		�P�F0�Ń��[�u���O�Ɉړ��A1�Ń��[�u���O�ŃK�[�h
		�Q�F�G���U���ł��Ȃ��͈͂ɂ����Ƃ�0�ő��ɋA��A1�ŃC���^���v�g���Ȃ�
		�R�F�G���U���ł���͈͂ɂ����Ƃ�0�Ń��v�����j���O���ċ߂Â��čU���A1�ŃC���^���v�g���Ȃ�
		
	��ai:SetTimer()�̎g�p�󋵁B
	�@�@
*********************************************************************************************]]


--[[===========================================================
	�����C���S�[���B
=============================================================]]
REGISTER_GOAL(GOAL_GalV_816000_Battle_Main , "GalV_816000Battle_Main");
REGISTER_GOAL_NO_UPDATE( GOAL_GalV_816000_Battle_Main, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_GalV_816000_Battle_Main, true);

function GalV_816000Battle_Main_Activate(ai, goal)
	
	local life	= goal:GetLife();
	local mode 	= ai:GetNumber(0);

	if 		(mode==1) then	goal:AddSubGoal( GOAL_GalV_816000_Battle_Retreat, 	life);
	elseif 	(mode==2) then	goal:AddSubGoal( GOAL_GalV_816000_Battle_Guard, 	life);
	else					goal:AddSubGoal( GOAL_GalV_816000_Battle_Forward, 	life);
	end
	
end

function GalV_816000Battle_Main_Update(ai, goal) return GOAL_RESULT_Continue; end
function GalV_816000Battle_Main_Terminate(ai, goal) end
function GalV_816000Battle_Main_Interupt(ai, goal) return false; end









--[[===========================================================
	����퓬�S�[��
=============================================================]]
REGISTER_GOAL(GOAL_GalV_816000_NonBattle, "GalV_816000NonBattle");
REGISTER_GOAL_NO_UPDATE(GOAL_GalV_816000_NonBattle, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_GalV_816000_NonBattle, true);

function GalV_816000NonBattle_Activate(ai, goal)

	local life			= goal:GetLife();
	local distInitPos 	= ai:GetDist(TARGET_SELF);

	if ( distInitPos < 1 ) then
		--�����ʒu�ɋ߂��ꍇ�́A���̏�ő҂B
		goal:AddSubGoal( GOAL_COMMON_Stay, 	life);
	else
		--�����Ŗ����ꍇ�́A�����ʒu�ɖ߂�B
		goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, life, POINT_INITIAL, AI_DIR_TYPE_CENTER, 0.5, TARGET_SELF, -1);
	end
	
end

function GalV_816000NonBattle_Update(ai, goal) return GOAL_RESULT_Continue; end
function GalV_816000NonBattle_Terminate(ai, goal) end
function GalV_816000NonBattle_Interupt(ai, goal) return false; end



--[[===========================================================
	���O�q�}���S�[���B
=============================================================]]
REGISTER_GOAL(GOAL_GalV_816000_Battle_Forward , "GalV_816000Battle_Fwd");
REGISTER_GOAL_NO_UPDATE( GOAL_GalV_816000_Battle_Forward, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_GalV_816000_Battle_Forward, true);

function GalV_816000Battle_Fwd_Activate(ai, goal)
	goal:AddSubGoal( GOAL_GalV_816000_Battle, goal:GetLife(), 0);
end

function GalV_816000Battle_Fwd_Update(ai, goal) return GOAL_RESULT_Continue; end
function GalV_816000Battle_Fwd_Terminate(ai, goal) end
function GalV_816000Battle_Fwd_Interupt(ai, goal)	return false; end



--[[===========================================================
	���ދp�S�[���B
=============================================================]]
REGISTER_GOAL(GOAL_GalV_816000_Battle_Retreat , "GalV_816000Battle_Retreat");
REGISTER_GOAL_NO_UPDATE( GOAL_GalV_816000_Battle_Retreat, true);
--REGISTER_GOAL_NO_INTERUPT( GOAL_GalV_816000_Battle_Retreat, true);


function GalV_816000Battle_Retreat_Activate(ai, goal) 
local Life = goal:GetLife();
local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

	--���[�u���O�̗̈���Ď�
	ai:AddObserveRegion( 0, TARGET_SELF, 2505 );

	--���[�u���O�ɑ����ڂ��Ă��Ȃ���΃��[�g�ړ�
	if (false==ai:IsInsideObserveRegion(0)) then
		if targetDist <= 1.5 then
			if (goal:IsFinishTimer(3)) then
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
				goal:SetTimer(3,6.0);
			end
		end
	goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 10.0, POINT_MOVE_POINT, AI_DIR_TYPE_CENTER, 1, TARGET_ENE_0, false);
	end
end
	
---------------------------------------------------------
--  ���荞�ݍU��
---------------------------------------------------------
function GalV_816000Battle_Retreat_Attack(ai, goal)
local fate = ai:GetRandam_Int(1,100)

	--������΂��K�v������̂ŕЎ菬�U�������C���Ŏg�p
	if fate <= 80 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	end

end

function GalV_816000Battle_Retreat_Update(ai, goal) return GOAL_RESULT_Continue; end
function GalV_816000Battle_Retreat_Terminate(ai, goal) 
	--�����ƖړI�n�ɓ����ł�����A���[�u����q���[�h�ɕύX
	if (ai:IsInsideObserveRegion(0)) then
--	if (GOAL_RESULT_Success==goal:GetLastSubGoalResult()) then
		if ( 1==ai:GetNumber(0) ) then
			ai:SetNumber(0, 2);
		end
	end
end

-----------------------------------------------------------
-- ���荞��
-----------------------------------------------------------
function GalV_816000Battle_Retreat_Interupt(ai, goal) 

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���
local hprate = ai:GetHpRate( TARGET_SELF )	--������HP�̊������擾

	--���ߋ����ōU���s���𔭌�������œK�s��
	if ai:IsInterupt( INTERUPT_FindAttack ) then
local superStepDist = 1.0			--���������鋗��
local superStepPer = 100			--����������m��
		if targetDist <= superStepDist then
			if fate <= superStepPer then
				goal:ClearSubGoal();
				if fate2 <= 80 then
					goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Parry, TARGET_ENE_0, DIST_None, 0);
					goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
				else
					GalV_816000Battle_Retreat_Attack(ai, goal)
				end
				return true;
			end
		end
	end

	--�ړ����ɔ�ѓ������������œK�s��
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 100					--��ѓ���g�p���ɍœK�s�������m��
local shootDist = 1.0					--��ѓ���ɔ������鋗��
	if fate <= shootIntPer then
			goal:ClearSubGoal();
			GalV_816000Battle_Retreat_Attack(ai, goal)
			return true;
		end
	end

	return false;
end


--[[===========================================================
	�����[�u����q�S�[���B
=============================================================]]
REGISTER_GOAL(GOAL_GalV_816000_Battle_Guard, "GalV_816000Battle_Guard");
REGISTER_GOAL_NO_UPDATE( GOAL_GalV_816000_Battle_Guard, true);

function GalV_816000Battle_Guard_Activate(ai, goal) 

	--�̈�Ď��J�n�B
	ai:AddObserveRegion( 1, TARGET_ENE_0, 2504	);
	ai:AddObserveRegion( 2, TARGET_ENE_0, 2506	);

	goal:AddSubGoal( GOAL_GalV_816000_Battle, goal:GetLife(), 1);
end


---------------------------------------------------------
--  �������U���i�ΏہF���[�u���p�j
---------------------------------------------------------
function GalV_816000Battle_Guard_Interupt_Action(ai, goal)

local selfmp = ai:GetMp(TARGET_SELF)			--�����̎c��MP���擾
local fate = ai:GetRandam_Int(1,100)			--�m������p

	ai:StartGuard(4);

	--���������ɖ߂��Ă��瓮���Ă��Ȃ�
	if ( 0 == ai:GetNumber(1) ) then
		--���ɖ߂��ăt���O�𗧂Ă�
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 100.0, POINT_INITIAL, 0.5, TARGET_ENE_0, true, -1 )
		ai:SetNumber(1,1)
	end
	
	--�Ў莝���ɐ؂�ւ�
	CommonNPC_SwitchOneHandMode(ai, goal)
	
	--���ŃK�[�h
	goal:AddSubGoal( GOAL_COMMON_Wait, 9999.0, TARGET_ENE_0, 0, 0, 0 );
	
end

function GalV_816000Battle_Guard_Update(ai, goal) return GOAL_RESULT_Continue; end
function GalV_816000Battle_Guard_Terminate(ai, goal) end
function GalV_816000Battle_Guard_Interupt(ai, goal) 

	if (ai:IsInterupt(INTERUPT_Inside_ObserveArea)) then
		--�����N���s�̈����ɓG��������A
		--���ɋA���ăK�[�h
		if (ai:IsInsideObserveRegion(1)) then
			if ( 0 == ai:GetNumber(2) ) then
				if ( goal:IsFinishTimer(1) ) then
					goal:SetTimer(1,4.0);
					goal:ClearSubGoal();
					GalV_816000Battle_Guard_Interupt_Action(ai, goal)
					ai:SetNumber(2,1);
					ai:SetNumber(3,0);
					return true;
				end
			end
		end
	end

	if (ai:IsInterupt(INTERUPT_Inside_ObserveArea)) then
		--�����U���\�ȏꏊ�ɓG��������A
		--���v�����j���O
		if (ai:IsInsideObserveRegion(2)) then
			if ( 0 == ai:GetNumber(3) ) then
				if ( goal:IsFinishTimer(2) ) then
					goal:SetTimer(2,4.0);
					goal:ClearSubGoal();
					ai:Replaning();
					ai:SetNumber(3,1);
					ai:SetNumber(2,0);
					return true;
				end
			end
		end
	end	

	return false; 
	
end



--[[===========================================================
	���ʏ�퓬�S�[���B
=============================================================]]
REGISTER_GOAL(GOAL_GalV_816000_Battle , "GalV_816000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_GalV_816000_Battle, true);

--[[*****************************************************
	�S�[���N��
*******************************************************]]
function GalV_816000Battle_Activate(ai, goal)

--[[�̈�Ď�]]

	ai:AddObserveRegion( 1, TARGET_ENE_0, 2504	);

--[[�̈���Ƀ^�[�Q�b�g0�����Ȃ���΃t���O�����낷]]

	if (ai:IsInsideObserveRegion(1)) then
		ai:SetNumber(1,1) else
		ai:SetNumber(1,0);
		ai:EndGuard();
		ai:Replaning ();
	end

--[[���݂̎���ʒu�𔻒f���čs����ύX����]]	
	
local hprate = ai:GetHpRate( TARGET_SELF )				--������HP�������擾

	--������HP���c��2���ȏ�
	if hprate >= 0.2 then		

		--���[�u��������Ă���
		if (1==goal:GetParam(0) ) then

			--���[�u���O�s��
			GalV_816000Battle_Back_Attack(ai, goal)
			
		--�O�q�ɂ���
		else

			--�O�q�s��	
			GalV_816000Battle_Front_Attack(ai, goal)
		
		end

	--�����̎c��HP��2���ȉ�
	else

		--���[�u��������Ă���
		if (1==goal:GetParam(0) ) then

			--�m���s���E���[�u���O
			GalV_816000Battle_Dying_Attack(ai, goal)
			
		--�O�q�ɂ���
		else

			--�m���s���E�O�q	
			GalV_816000Battle_Dying_Attack_Front(ai, goal)

		end
	
	end	
	
end

---------------------------------------------------------
--  ���[�u���O�s��
---------------------------------------------------------
function GalV_816000Battle_Back_Attack(ai, goal)

local fate = ai:GetRandam_Int(1,100)
local fate2 = ai:GetRandam_Int(1,100)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local nearDist = 4.0						--�߂��Ɣ��f���鋗��
local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���

local selfmp = ai:GetMp(TARGET_SELF)			--�����̎c��MP���擾

	--MP��100�ȏ�Ȃ�
	if selfmp >= 100 then
		--�^�[�Q�b�g�Ƃ̋�����4M�ȏ゠���
		if targetDist >= nearDist then
			--85% ���[�u���O�s��
			--15% ���@�U��
			if fate <= 85 then
				GalV_816000Battle_Back_NormalATK(ai, goal)
			else
				GalV_816000Battle_Magic(ai, goal)
			end
		else
			GalV_816000Battle_Back_NormalATK(ai, goal)
		end
			
	--MP��100�ȉ��Ȃ�
	else
		--100% �ʏ�U��
		GalV_816000Battle_Back_NormalATK(ai, goal)

	end
end


---------------------------------------------------------
--  �O�q�s��
---------------------------------------------------------
function GalV_816000Battle_Front_Attack(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local nearDist = 3.0						--�߂��Ɣ��f���鋗��
local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���


	--�������Ȃ����A�߂����Ȃ��Ȃ�
	if targetDist >= nearDist then
		--100���@�K�[�h
		GalV_816000Battle_Normal_Guard(ai, goal)

	--�߂��Ȃ�
	elseif targetDist >= NormalR_Dist then
		
		GalV_816000Battle_NearATK(ai, goal)
	
	--�ɒ[�ɋ߂��Ȃ�
	else

		GalV_816000Battle_TooNearATK(ai, goal)
	
	end

end

---------------------------------------------------------
--  �m���s���E���[�u���O
---------------------------------------------------------
function GalV_816000Battle_Dying_Attack(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local selfmp = ai:GetMp(TARGET_SELF)			--�����̎c��MP���擾


	--MP��60��葽�����
	if selfmp >= 60 then

		--PC��6���[�g���ȏ㗣��Ă����
		if targetDist >= 6.0 then
			--���@���񕜂ɐ؂�ւ���
			ai:ChangeEquipMagic(1);
			
			--�Ў莝���ɐ؂�ւ�
			CommonNPC_SwitchOneHandMode(ai, goal)
			
			--�^���X�}���������Ă��Ȃ���ΐ؂�ւ���
			CommonNPC_ChangeWepR2(ai, goal)

			--100% ���
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_MagicR, TARGET_SELF, DIST_None, 0 );
		
		--PC��6���[�g���ȏ㗣��Ă��Ȃ����
		else
		
			--���[�u���O�U��
			GalV_816000Battle_Back_NormalATK(ai, goal)
			
		end
		
	--MP��60��菭�Ȃ����
	else

		--100% ���[�u���O�U��
		GalV_816000Battle_Back_NormalATK(ai, goal)
		
	end

end


---------------------------------------------------------
--  �m���s���E�O�q
---------------------------------------------------------
function GalV_816000Battle_Dying_Attack_Front(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local selfmp = ai:GetMp(TARGET_SELF)			--�����̎c��MP���擾


	--MP��60��葽�����
	if selfmp >= 60 then

		--PC��6���[�g���ȏ㗣��Ă����
		if targetDist >= 6.0 then
			--���@���񕜂ɐ؂�ւ���
			ai:ChangeEquipMagic(1);
			
			--�Ў莝���ɐ؂�ւ�
			CommonNPC_SwitchOneHandMode(ai, goal)
			
			--�^���X�}���������Ă��Ȃ���ΐ؂�ւ���
			CommonNPC_ChangeWepR2(ai, goal)

			--100% ���
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_MagicR, TARGET_SELF, DIST_None, 0 );
		
		--PC��6���[�g���ȏ㗣��Ă��Ȃ����
		else
		
			--�O�q�s��
			GalV_816000Battle_Front_Attack(ai, goal)
			
		end
		
	--MP��60��菭�Ȃ����
	else

		--100% �O�q�s��
		GalV_816000Battle_Front_Attack(ai, goal)
		
	end

end


---------------------------------------------------------
--  �O�q�U���E�߂��Ȃ�
---------------------------------------------------------
function GalV_816000Battle_NearATK(ai, goal)

	GalV_816000Battle_NormalR_Comb(ai, goal)
	GalV_816000Battle_Kougeki_Noato(ai, goal)
end


---------------------------------------------------------
--  �O�q�U���E�ɒ[�ɋ߂��Ȃ�
---------------------------------------------------------
function GalV_816000Battle_TooNearATK(ai, goal)

local fate = ai:GetRandam_Int(1,100)

	--70���@�U��
	--30���@�v�b�V��
	if fate <= 70 then
		GalV_816000Battle_NormalR_Comb(ai, goal)
		GalV_816000Battle_Kougeki_Noato(ai, goal)
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_PushR, TARGET_ENE_0, DIST_None, 0);
		GalV_816000Battle_Kougeki_Noato(ai, goal)
	end

end


---------------------------------------------------------
--  ���[�u���O�U���E�ʏ�
---------------------------------------------------------
function GalV_816000Battle_Back_NormalATK(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local nearDist = 4.0				--�߂��Ɣ��f���鋗��
local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���

local fate = ai:GetRandam_Int(1,100)		--�m������p1
local fate2 = ai:GetRandam_Int(1,100)		--�m������p2
local fate3 = ai:GetRandam_Int(1,100)		--�m������p3


	
	--�������Ȃ����A�߂����Ȃ��Ȃ�
	if targetDist >= nearDist then
		--100���@�����ċ߂Â��čU��
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, 4 );

		if fate <= 50 then
			GalV_816000Battle_NormalR_Comb(ai, goal)
			GalV_816000Battle_Kougeki_Noato2(ai, goal)
		
		else
			GalV_816000Battle_NormalR_Comb2(ai, goal)
			GalV_816000Battle_Kougeki_Noato2(ai, goal)
		end
		
	--�߂��Ȃ�
	elseif targetDist >= NormalR_Dist then
	
		if fate2 <= 40 then
			GalV_816000Battle_NormalR_Comb(ai, goal)
			GalV_816000Battle_Kougeki_Noato2(ai, goal)
		
		else
			GalV_816000Battle_NormalR_Comb2(ai, goal)
			GalV_816000Battle_Kougeki_Noato2(ai, goal)
		
		end
	--�ɒ[�ɋ߂��Ȃ�
	else
		
		if fate3 <= 30 then
			GalV_816000Battle_NormalR_Comb(ai, goal)
			GalV_816000Battle_Kougeki_Noato2(ai, goal)
	
		else
			GalV_816000Battle_NormalR_Comb2(ai, goal)
			GalV_816000Battle_Kougeki_Noato2(ai, goal)
		end
	
	end


end

---------------------------------------------------------
--  �E��R���{
---------------------------------------------------------
function GalV_816000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p

	--����Ɏ����ւ���
	CommonNPC_ChangeWepR1(ai, goal)

	--�Ў莝���ɐ؂�ւ�
	CommonNPC_SwitchOneHandMode(ai, goal)

	--20% �E��U��
	--80% �E�苭�U��
	if NR_fate <= 20 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	end

end
	
---------------------------------------------------------
--  �E��R���{2�E�ҍU��
---------------------------------------------------------
function GalV_816000Battle_NormalR_Comb2(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--�m������p
local NR_fate2 = ai:GetRandam_Int(1,100)			--�m������p

	--����Ɏ����ւ���
	CommonNPC_ChangeWepR1(ai, goal)

	if NR_fate <= 35 then
	
		--�Ў莝���ɐ؂�ւ�
		CommonNPC_SwitchOneHandMode(ai, goal)
		
		--20% �E��U��
		--80% �E�苭�U��
		if NR_fate2 <= 20 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
		end

	else
	
		--���莝���ɐ؂�ւ�
		CommonNPC_SwitchBothHandMode(ai, goal)

		--100% ���莝���U�����
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);

	end
		
end


---------------------------------------------------------
--  �U���E���@
---------------------------------------------------------
function GalV_816000Battle_Magic(ai, goal)

	--�Ў莝���ɐ؂�ւ�
	CommonNPC_SwitchOneHandMode(ai, goal)

	--���@�����Ȓ��S�����ɐ؂�ւ���
	ai:ChangeEquipMagic(0);

	--�^���X�}���𑕔����Ă��Ȃ���ΐ؂�ւ���
	CommonNPC_ChangeWepR2(ai, goal)
	
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_MagicR, TARGET_ENE_0, DIST_None, 0);
	GalV_816000Battle_Kougeki_Noato2(ai, goal)
		
	
end


---------------------------------------------------------
--  �U���E�K�[�h
---------------------------------------------------------
function GalV_816000Battle_Normal_Guard(ai, goal)

	--�Ў莝���ɐ؂�ւ�
	CommonNPC_SwitchOneHandMode(ai, goal)

	--���������Ă��Ȃ���ΐ؂�ւ��ăK�[�h
	goal:AddSubGoal( GOAL_COMMON_Guard, 2.0, 4, TARGET_ENE_0, true, 0 );

end

---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function GalV_816000Battle_Kougeki_Noato(ai, goal)

	--100���@���ɖ߂�
	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, POINT_INITIAL, 0.5, TARGET_ENE_0, true, 4 )

end

---------------------------------------------------------
--  �U����̍s��2
---------------------------------------------------------
function GalV_816000Battle_Kougeki_Noato2(ai, goal)

	goal:AddSubGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true ,4 );
end


---------------------------------------------------------
--  ���荞�݂̍U���p�^�[��
---------------------------------------------------------
function GalV_816000Battle_Interupt_Attack_ptn(ai, goal)

	--����������Ă��Ȃ���Ύ����ւ���
	CommonNPC_ChangeWepR1(ai, goal);

	--�Ў莝����������
	if ( not( ai:IsBothHandMode(TARGET_SELF) ) ) then
		--�p���B
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Parry, TARGET_ENE_0, DIST_None, 0);
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	--���莝����������A���U��
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	end
end


--[[*****************************************************
	�X�V�E�I��
*******************************************************]]
function GalV_816000Battle_Update(ai, goal) return GOAL_RESULT_Continue; end
function GalV_816000Battle_Terminate(ai, goal) end


--[[*****************************************************
	���荞��
		���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
		�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
		���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
*******************************************************]]
function GalV_816000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p

local NormalR_Dist = 2.5			--�E��U���̓K���ԍ���

	
	--���ߋ����ōU�����ꂻ���ɂȂ����璴�����p���B
	if ai:IsInterupt( INTERUPT_FindAttack ) then
local superStepDist = 2.0			--���������鋗��
local superStepPer = 40			--����������m��	
		if targetDist <= superStepDist then
			if fate <= superStepPer then
			goal:ClearSubGoal();
			GalV_816000Battle_Interupt_Attack_ptn(ai, goal)
			return true;
			end
		end
	end
	
	
	--��ѓ���������Ă�����œK�s��
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 100					--��ѓ���g�p���ɍœK�s�������m��
		if fate <= shootIntPer then
			goal:ClearSubGoal();
			if ( 0==goal:GetParam(0) ) then
				GalV_816000Battle_Normal_Guard(ai, goal)
			else
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, 4 );
				GalV_816000Battle_NormalR_Comb(ai, goal)
			end
			return true;
		end
	end
	
	
return false;
end

