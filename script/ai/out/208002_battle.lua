--[[*******************************************************************************************
	�y�����z�p�퓬
	�����F

	�ύX�����F
	�@�E08/7/24 hasem	�`�[�����߂��o���Ȃ��������Ȃ����A�˖��@���g���B
	�@�E08/7/26 hasem	��/��/�������ōU���𕪂���B
	�@�E
	
	�p�����[�^0  �Ȃ�
	�p�����[�^1  �Ȃ�
	�p�����[�^2  �Ȃ�
	�p�����[�^3�@�Ȃ�
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Gokuri208002_Battle, "Gokuri208002Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Gokuri208002_Battle, true);
--~ REGISTER_GOAL_NO_INTERUPT( GOAL_Gokuri208002_Battle, true);


--[[*****************************************************
	�S�[���N��
*******************************************************]]
function Gokuri208002Battle_Activate(ai, goal)

	--[[����悳�񒲐����ځ�]]
	
		--�e�����̂������l�́A�G�N�Z�����iNPC�v�l�p�����[�^�ɂ���܂��B
	
	--[[����悳�񒲐����ځ�]]

	local targetDist 	= ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾
	local NEAR_DIST		= ai:GetDistParam(DIST_Near);	--�ߋ����������l�B
	local MIDDLE_DIST	= ai:GetDistParam(DIST_Middle);	--�������������l�B
	local FAR_DIST		= ai:GetDistParam(DIST_Far);	--�������������l�B
	local fate			= ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���

	
	if 		( targetDist<NEAR_DIST ) then
		if fate < 30 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true, -1);
		else
			Gokuri208002Battle_NearAttack( ai, goal);
		end
		
	elseif 	( targetDist<MIDDLE_DIST ) then
		if fate < 20 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NEAR_DIST, TARGET_ENE_0, false, -1 );
		elseif fate < 30 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NEAR_DIST, TARGET_ENE_0, true, -1 );		
		elseif fate < 40 then
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true, -1);
		else
			Gokuri208002Battle_MiddleAttack( ai, goal);
		end
	else
		Gokuri208002Battle_FarAttack( ai, goal);
	end
	
end


---------------------------------------------------------
--  �������C���B
---------------------------------------------------------
function Gokuri208002Battle_FarAttack(ai, goal)

	--[[����悳�񒲐����ځ�]]
	
	local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
	local idMotion_Long			= 3304;		--���߂̖��@��������B
	local idMotion_Short		= 3301;		--�Z�߂̖��@��������B
	local RANDOM_LONG_SELECT	= 35;		--���߂̖��@��I�Ԋ����B(100�����ɂ��鎖�B)
	
	local rand_val = ai:GetRandam_Int( 0, 100);
	
	if ( Gokuri208002Battle_IsEnableFarAttack(ai, goal) ) then
	
		if ( rand_val < RANDOM_LONG_SELECT ) then
			Gokuri208002Battle_AddAttackGoal( ai, goal, 10.0, idMotion_Long, TARGET_ENE_0, DIST_None);
		else
			if fate <= 50 then
				goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_ENE_NONE, 0, 0, 0 );
				Gokuri208002Battle_AddAttackGoal( ai, goal, 10.0, idMotion_Short, TARGET_ENE_0, DIST_None);
			else
				Gokuri208002Battle_AddAttackGoal( ai, goal, 10.0, idMotion_Short, TARGET_ENE_0, DIST_None);
			end
		end

	else
		goal:AddSubGoal(GOAL_COMMON_Wait, 0.1, target);
	end
	
end
	
	
---------------------------------------------------------
--  �������C���B
---------------------------------------------------------
function Gokuri208002Battle_MiddleAttack(ai, goal)
	
	--���K�t���C���I���������Z���U���������̂ŁA�c���`�ɕύX
	Gokuri208002Battle_AddGuardbreakGoal( ai, goal, 10.0, 3001, TARGET_ENE_0, DIST_None);
end
	
	
---------------------------------------------------------
--  �߂������U���B
---------------------------------------------------------
function Gokuri208002Battle_NearAttack(ai, goal)

	--[[����悳�񒲐����ځ�]]
	
	local idMotion_YOKO			= 3000;		--�����`�B�K�`�B�
	local idMotion_TATE			= 3303;		--�c���`�B�����Ζ��@�ɕύX
	local idMotion_FIRE			= 3301;		--�t�F�C���g�p�t�@�C���[�{���g�B
	local RANDOM_YOKO_SELECT	= 30;		--�����`��I�Ԋ����B(100�����ɂ��鎖�B)
	local RANDOM_FIRE_SELECT	= (RANDOM_YOKO_SELECT+10);		--���΂�I�Ԋ���(���������ς���)�B
	
	--[[����悳�񒲐����ځ�]]

	local rate = ai:GetRandam_Int(1,100);

	--�ߋ����U���B
	--	�����̊����ŁA�o�������邾���B
	if ( rate<RANDOM_YOKO_SELECT ) then
		Gokuri208002Battle_AddGuardbreakGoal( ai, goal, 10.0, idMotion_YOKO, TARGET_ENE_0, DIST_None);
	elseif ( rate<RANDOM_FIRE_SELECT) then
		Gokuri208002Battle_AddAttackGoal( ai, goal, 10.0, idMotion_FIRE, TARGET_ENE_0, DIST_None);
	else
		Gokuri208002Battle_AddAttackGoal( ai, goal, 10.0, idMotion_TATE, TARGET_ENE_0, DIST_None);
	end

end

---------------------------------------------------------
--  �������C�����Ă������H
---------------------------------------------------------
function Gokuri208002Battle_IsEnableFarAttack(ai, goal)
	local idParam = ai:GetNpcThinkParamID();
	if 		(idParam==208003) then	CheckRegionID = 2165;
	elseif 	(idParam==208004) then	CheckRegionID = 2166;
	elseif 	(idParam==208005) then	CheckRegionID = 2167;
	else	CheckRegionID = -1
	end
	
	if ( false==ai:IsFinishTimer(0))	then return true; end
	if ( CheckRegionID==-1)				then return true; end
	
	return ai:IsInsideTargetRegion( TARGET_ENE_0, CheckRegionID);
end


--[[*****************************************************
	�S�[���X�V�E�I���́A�Ȃ��B
*******************************************************]]
function Gokuri208002Battle_Update(ai, goal)return GOAL_RESULT_Continue;end
function Gokuri208002Battle_Terminate(ai, goal)end


--[[*****************************************************
	���荞�݁B
*******************************************************]]
function Gokuri208002Battle_Interupt(ai, goal)

	--�_���[�W���󂯂���A��莞�ԁA�ˌ������̈�𖳎�����B
	if ( ai:IsInterupt(INTERUPT_Damaged) or ai:IsInterupt(INTERUPT_Damaged_Stranger) ) then
		ai:SetTimer(0, 20);
	end

	return false; 
end


--[[*****************************************************
	�U���S�[���ǉ��B
*******************************************************]]
function Gokuri208002Battle_AddAttackGoal(ai, goal, life, EzStateID, target, typeDist)
	
	if ( ai:IsVisibleTarget(target) ) then
		--�����Ă���Ε��ʂɍU���B
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, life, EzStateID, target, typeDist, 0);
	else
		--�����Ă��Ȃ���΁A������Ƒ҂�����B
		goal:AddSubGoal(GOAL_COMMON_Wait, 0.1, target);
	end
	
end

--[[*****************************************************
	�K�[�h�u���C�N�U���S�[���ǉ��B
*******************************************************]]
function Gokuri208002Battle_AddGuardbreakGoal(ai, goal, life, EzStateID, target, typeDist)

	local fate = ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
	
	if ( ai:IsVisibleTarget(target) ) then
		--�����Ă���Ε��ʂɍU���B
		goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, life, EzStateID, target, typeDist, 0);
        if fate <= 40 then
            goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
        else
            goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
        end 
	else
		--�����Ă��Ȃ���΁A������Ƒ҂�����B
		goal:AddSubGoal(GOAL_COMMON_Wait, 0.1, target);
	end
	
end



	