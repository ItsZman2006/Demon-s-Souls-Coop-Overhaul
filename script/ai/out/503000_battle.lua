-----------------------------------------------------------------------------------------------
--	���̏b��p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_akemono503000_Battle, "akemono503000Battle");


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function akemono503000Battle_Activate(ai, goal)

	local rate0 = ai:GetRandam_Int( 0, 100 );

	local eventNo = ai:GetEventRequest();

	-- �����E�E�ւ̍U������
	if( eventNo == AI_EVENT_FOR_RIGHT )then
		    
			-- �����E�E�@��
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3000, TARGET_ENE_0, DIST_None, 0);

	-- �����E���ʂ֍U������
	elseif( eventNo == AI_EVENT_FOR_CENTER ) then	
    -- �����E���ʒ@��
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3010, TARGET_ENE_0, DIST_None, 0);
	
    -- �����E���֍U������
	elseif( eventNo == AI_EVENT_FOR_LEFT ) then	
		
	-- �����E���@��
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3020, TARGET_ENE_0, DIST_None, 0);
	
    -- ���ʂ֍U������
	elseif( eventNo == AI_EVENT_NEAR ) then	
		
        -- ���ʕ���
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3030, TARGET_ENE_0, DIST_None, 0);
	
	else
		
		-- �҂�
			goal:AddSubGoal( GOAL_COMMON_Wait, 5.0, TARGET_NONE, 0, 0, 0 );	
	end
	
end

---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function akemono503000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function akemono503000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function akemono503000Battle_Interupt(ai, goal)
	
	-- �G���A�C�e�����g�����ꍇ
	if ai:IsInterupt( INTERUPT_UseItem ) then
		-- �S�[���N���A
		goal:ClearSubGoal();

		akemono503000Battle_Activate( ai, goal );
		return true;
	elseif ai:IsInterupt( INTERUPT_MissSwing ) then
		-- �S�[���N���A
		goal:ClearSubGoal();
		akemono503000Battle_Activate( ai, goal );
		return true;
	end
	
	return false;
end
