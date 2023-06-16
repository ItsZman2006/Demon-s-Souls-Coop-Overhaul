-----------------------------------------------------------------------------------------------
--	�U�_���܃f�[�����퓬
--	�����F
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Nisekamisama506001_Battle, "nisekamisama506001Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Nisekamisama506001_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function nisekamisama506001Battle_Activate(ai, goal)
-------------------------------------------------------------------------------
	
	local targetDist = ai:GetDist( TARGET_ENE_0 );
	
	-- �t�@�C���[�{�[��
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, 3010, TARGET_ENE_0, DIST_Far, 0);	
end

---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function nisekamisama506001Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function nisekamisama506001Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function nisekamisama506001Battle_Interupt(ai, goal)

	-- �U�����ꂽ
	if( ai:IsInterupt( INTERUPT_Damaged ) ) then
		goal:ClearSubGoal();
		
		-- ����
		goal:AddSubGoal( GOAL_COMMON_Step, 50, 9600, 0, 0, 0 )
		return true;

	end

	return false;
end




	

	