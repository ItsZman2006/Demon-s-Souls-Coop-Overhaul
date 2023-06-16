-----------------------------------------------------------------------------------------------
--	�_���܃f�[�����퓬
--	�����F
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Kamisama506000_Battle, "kamisama506000Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Kamisama506000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function kamisama506000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------
	
	local targetDist = ai:GetDist( TARGET_ENE_0 );
	
	-- ���@�w�𔭓������Ă��Ȃ��ꍇ
	if( ai:GetNumber( 0 ) <= 0.0 ) then
		goal:AddSubGoal( GOAL_COMMON_Attack, 50.0, 3300, TARGET_ENE_0, DIST_None, 0);	
		ai:SetNumber( 0, 1.0 );
	end
	
	-- �t�@�C���[�{�[��
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, 3000, TARGET_ENE_0, DIST_Far, 0);	
end

---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function kamisama506000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function kamisama506000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function kamisama506000Battle_Interupt(ai, goal)

	-- �U�����ꂽ
	if( ai:IsInterupt( INTERUPT_Damaged ) ) then
		goal:ClearSubGoal();
		
		-- �u�Ԉړ�
		goal:AddSubGoal( GOAL_COMMON_Step, 10.0, 9010, 0, 0, 0 )
		
		-- �����w�z�u�t���O�̃��Z�b�g
		ai:SetNumber( 0, -1.0 );
		return true;
	end

	return false;
end




	

	