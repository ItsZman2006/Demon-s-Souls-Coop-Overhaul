-----------------------------------------------------------------------------------------------
--	��w偗p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_kumo510000_Battle, "kumo510000Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_kumo510000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function kumo510000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------
local fate0     = ai:GetRandam_Int(1,100)               --�m������Ŏg�p����^���̐���
local fate1     = ai:GetRandam_Int(1,100)               --�m������Ŏg�p����^���̐���
local fate2     = ai:GetRandam_Int(1,100)               --�m������Ŏg�p����^���̐���

--~ -- �ҋ@��Ԃ̍X�V
--~ --�v���C���[���g���l���ɂ���(slot0)
--~ if( ai:GetEventRequest( 0 ) == AI_EVENT_STAY_TUNNEL ) then
--~     -- �����ݑҋ@
--~     ai:ChangeMoveAnimParam(1);

--~ --�v���C���[�������ɓ����Ă��Ă�(slot0)
--~ elseif( ai:GetEventRequest( 0 ) == AI_EVENT_STAY_ROOM ) then
--~     -- �ʏ�̗����ҋ@
--~     ai:ChangeMoveAnimParam(0);
--~ end

--�t�@�C���[�{�[���P�@�ᑬ
--�t�@�C���[�{�[���Q�@�ߋ���3WAY
--�w偂̎��P�@����
--�w偂̎��Q�@�ߋ���2WAY


-- �U��
--�v���C���[���g���l���̒����E���ɂ���(slot1)
--~ elseif( ai:GetEventRequest( 1 ) == AI_EVENT_TUNNEL_CENTER ) then
if ai:IsInsideTargetRegion( TARGET_ENE_0, 2090) then
    if( fate0 <= 40 ) then
		--�t�@�C���[�{�[���P
		if fate1 <= 20 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6020, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.0, TARGET_ENE_0);
		--�t�@�C���[�{�[���Q�@�R�A�˂��ċx�e
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6021, TARGET_ENE_0, DIST_None, 0);			
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6021, TARGET_ENE_0, DIST_None, 0);			
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6021, TARGET_ENE_0, DIST_None, 0);			
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
		end
    else
		--�w偂̎��P���t�@�C���[�{�[���P
		if fate1 <= 20 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6050, TARGET_ENE_0, DIST_None, 0);     
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6020, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		--�w偂̎��Q���t�@�C���[�{�[���P
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6051, TARGET_ENE_0, DIST_None, 0);     
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6020, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		end
	end
	
--�v���C���[���g���l���̒����E��O�ɂ���(slot1)
--~ if( ai:GetEventRequest( 1 ) == AI_EVENT_TUNNEL_RIGHT ) then
elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2091) then
    if( fate0 <= 60) then
		--�t�@�C���[�{�[���P
		if fate1 <= 80 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6020, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.0, TARGET_ENE_0);
		--�t�@�C���[�{�[���Q�@�R�A�˂��ċx�e
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6021, TARGET_ENE_0, DIST_None, 0);			
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6021, TARGET_ENE_0, DIST_None, 0);			
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6021, TARGET_ENE_0, DIST_None, 0);			
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
		end
    else
		--�w偂̎��P���t�@�C���[�{�[���P
		if fate1 <= 80 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6050, TARGET_ENE_0, DIST_None, 0);     
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6020, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		--�w偂̎��Q���t�@�C���[�{�[���P
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6051, TARGET_ENE_0, DIST_None, 0);     
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6020, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		end
	end


--�v���C���[���g���l���̉E�[�E���ɂ���(slot1)
--~ if( ai:GetEventRequest( 1 ) == AI_EVENT_TUNNEL_RIGHT ) then
elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2080) then
    if( fate0 <= 40) then
		--�t�@�C���[�{�[���P
		if fate1 <= 20 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6000, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.0, TARGET_ENE_0);
		--�t�@�C���[�{�[���Q�@�R�A�˂��ċx�e
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6001, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6001, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6001, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
		end
    else
		--�w偂̎��P���t�@�C���[�{�[���P
		if fate1 <= 20 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6030, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6000, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		--�w偂̎��Q���t�@�C���[�{�[���P
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6031, TARGET_ENE_0, DIST_None, 0);			
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6000, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		end
	end
	
	
--�v���C���[���g���l���̉E�[�E��O�ɂ���(slot1)
--~ if( ai:GetEventRequest( 1 ) == AI_EVENT_TUNNEL_RIGHT ) then
elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2081) then
    if( fate0 <= 60) then
		--�t�@�C���[�{�[���P
		if fate1 <= 80 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6000, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.0, TARGET_ENE_0);
		--�t�@�C���[�{�[���Q�@�R�A�˂��ċx�e
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6001, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6001, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6001, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
		end
    else
		--�w偂̎��P���t�@�C���[�{�[���P
		if fate1 <= 80 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6030, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6000, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		--�w偂̎��Q���t�@�C���[�{�[���P
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6031, TARGET_ENE_0, DIST_None, 0);			
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6000, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		end
	end

--�v���C���[���g���l���̍��[�E���ɂ���(slot1)
--~ elseif( ai:GetEventRequest( 1 ) == AI_EVENT_TUNNEL_LEFT ) then
elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2100) then
    if( fate0 <= 40) then
		--�t�@�C���[�{�[���P
		if fate1 <= 20 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6010, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.0, TARGET_ENE_0);
		--�t�@�C���[�{�[���Q�@�R�A�˂��ċx�e
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6011, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6011, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6011, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
		end
	else
		--�w偂̎��P���t�@�C���[�{�[���P
		if fate1 <= 20 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6040, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6010, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		--�w偂̎��Q���t�@�C���[�{�[���P
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6041, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6010, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		end
	end

--�v���C���[���g���l���̍��[�E��O�ɂ���(slot1)
--~ elseif( ai:GetEventRequest( 1 ) == AI_EVENT_TUNNEL_LEFT ) then
elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2101) then
    if( fate0 <= 50) then
		--�t�@�C���[�{�[���P
		if fate1 <= 80 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6010, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.0, TARGET_ENE_0);
		--�t�@�C���[�{�[���Q�@�R�A�˂��ċx�e
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6011, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6011, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6011, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
		end
	else
		--�w偂̎��P���t�@�C���[�{�[���P
		if fate1 <= 80 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6040, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6010, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		--�w偂̎��Q���t�@�C���[�{�[���P
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6041, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6010, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		end
	end
	
	
--�v���C���[�����������̒����ɂ���(slot1)
--~ elseif( ai:GetEventRequest( 1 ) == AI_EVENT_ROOM_CENTER ) then
elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2120) then

	--60% �ߋ�������
	--0% �ߋ�����
	if fate2 <= 100 then
		goal:AddSubGoal( GOAL_kumo510000_FeelerAttack, 5);
		goal:AddSubGoal( GOAL_COMMON_Wait, ai:GetRandam_Float (0.3,0.6) ,0,0,0,0)
	else
		goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 5.0, 3060, TARGET_ENE_0, DIST_None, 0);
		goal:AddSubGoal( GOAL_COMMON_Wait, ai:GetRandam_Float (2.2,4.5) ,0,0,0,0)
	end
		
--�v���C���[�����������̉E���ɂ���(slot1)
--~ elseif( ai:GetEventRequest( 1 ) == AI_EVENT_ROOM_RIGHT ) then
elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2110) then
    goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);

--�v���C���[�����������̍����ɂ���(slot1)
--~ elseif( ai:GetEventRequest( 1 ) == AI_EVENT_ROOM_LEFT ) then
elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2130) then
    goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 5.0, 3010, TARGET_ENE_0, DIST_None, 0);

-- ��L�S�Ăɓ��Ă͂܂�Ȃ��ꍇ
else
--~ 	goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 5.0, 3020, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Wait, 0.1, TARGET_ENE_0);
	end
end	

---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function kumo510000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function kumo510000Battle_Terminate(ai, goal)
end

---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function kumo510000Battle_Interupt(ai, goal)

return false;
end





			


