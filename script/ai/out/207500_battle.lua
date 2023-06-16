--[[*******************************************************************************************
	�����ʐ퓬
	�����F	�ڋ߂��čU���B������̍B���͈͂͋ɂ߂ď������B
			��퓬���̓���̓f�t�H���g�̋@�\���g�p�B�G�N�Z���Œ����B
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Ryosyudama207500_Battle, "Ryosyudama207500Battle");
REGISTER_GOAL_NO_UPDATE(GOAL_Ryosyudama207500_Battle, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_Ryosyudama207500_Battle, true);

--[[*****************************************************
    �S�[���N��
*******************************************************]]
function Ryosyudama207500Battle_Activate(ai, goal)

	local idParam = ai:GetNpcThinkParamID();

	if 		(idParam==207500) then	CheckRegionID = 2005;
	else 	CheckRegionID = 2205;
	end

	--�U�������Ȃ�A�ߐڍU��
		if ai:IsInsideTargetRegion( TARGET_ENE_0, CheckRegionID) then
			Ryosyudama207500Battle_Attack(ai, goal);
		-- �U�������ɂ��Ȃ��Ȃ�ҋ@�̉������U��
		else
			Ryosyudama207500Battle_Approach(ai, goal);
		end
		
end

---------------------------------------------------------
--  �ڋ�
---------------------------------------------------------
function Ryosyudama207500Battle_Approach(ai, goal)
	local ATTACK_RANGE		= ai:GetDistParam(DIST_Near);	--�U������
	local AT_fate 			= ai:GetRandam_Int(1,100);		--�m������p

	--50%�@�������U��
	--50%�@�ړ��i�U���j
	if AT_fate <= 50 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_None , 0);
	else
		goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_NONE, 0, 0, 0 );
--~ 		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, ATTACK_RANGE-1, TARGET_ENE_0, true, -1 );
	end
end

---------------------------------------------------------
--  �U��
---------------------------------------------------------
function Ryosyudama207500Battle_Attack(ai, goal)

	local targetDist 	= ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
	local ATTACK_RANGE	= ai:GetDistParam(DIST_Near);	--�U������
	
	if 	( targetDist > ATTACK_RANGE ) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, ATTACK_RANGE-1, TARGET_ENE_0, true, -1 );
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near);
	end
end

	
--[[*****************************************************
	�X�V�E�I���E���荞��
*******************************************************]]
function Ryosyudama207500Battle_Update(ai, goal) return GOAL_RESULT_Continue; end
function Ryosyudama207500Battle_Terminate(ai, goal)end
function Ryosyudama207500Battle_Interupt(ai, goal)return false;end
