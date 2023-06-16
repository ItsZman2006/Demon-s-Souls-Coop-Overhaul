--[[*******************************************************************************************
	��퓬�s��
	�����F��퓬�s��

	�p�����[�^0  	�G�ɔ������鋗��[m]
	�p�����[�^1  	�G�������Ă�����I���i�����Ɋ֌W�Ȃ��j
	�p�����[�^2  	����H
	�p�����[�^3		����^�[�Q�b�g�B�f�t�H���g�FTARGET_ENE_0 (0)
	�p�����[�^4		���̓�������[m]
	�p�����[�^5		�ҋ@���S�[���B�O�Ȃ�AStay
*********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_NonBattleAct, "NonBattleAct");

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonBattleAct, 0, "�G�ɔ������鋗���ym�z", 		0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonBattleAct, 1, "�G������I���H", 				0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonBattleAct, 2, "����H", 						0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonBattleAct, 3, "����yTYPE�z", 				0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonBattleAct, 4, "���̓��������ym�z",			0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonBattleAct, 5, "�ҋ@���S�[��",				0);

	
-- �X�V�Ԋu�ݒ�
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_NonBattleAct, 0.1, 0.2);



--[[*****************************************************
	�S�[���N��
*******************************************************]]
function NonBattleAct_Activate(ai, goal)

	local idx 		= ai:GetMovePointNumber();			-- ���݂̈ړ��|�C���g�����邩
	local pointDist = ai:GetMovePointEffectRange();		-- �ړ��|�C���g����̉e���͈�
	local isWalk	= (0==goal:GetParam(2));			-- �����H]
	local turn_tgt	= goal:GetParam(3);					-- ����^�[�Q�b�g�B
	
	if idx >= 0 then
		-- �ړ��|�C���g����
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, goal:GetLife(), POINT_MOVE_POINT, AI_DIR_TYPE_CENTER, 0.0, TARGET_SELF, isWalk);

		-- ���������Ƃ��̍s���������ɗ񋓂���
		-- ������
		--goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_NONE, 0,0,0 );
	else
	
		local arrive_dist = goal:GetParam(4);
		if ( arrive_dist==0 ) then 
			--�O�̏ꍇ�́A���܂łǂ���f�t�H���g�̂T���B
			arrive_dist = 5;
		end
	
		if (pointDist > arrive_dist) then
			-- �ړ��|�C���g�Ȃ� �����ʒu�ɖ߂�
			goal:AddSubGoal( GOAL_COMMON_BackToHome, goal:GetLife(), 0,0,0,0 );
		else
		
			--�ҋ@���A�N�V����ID�������Ă�����AAttack�Ŏ��s�B
			local wait_goalID = goal:GetParam(5);
			if ( 0<wait_goalID) then
				--�A�N�V�������s�B
				goal:AddSubGoal( wait_goalID, goal:GetLife());
			else
				-- ���̏�őҋ@
				goal:AddSubGoal( GOAL_COMMON_Stay, goal:GetLife(), 0, turn_tgt);
			end
			
		end
	end
end

--[[*****************************************************
	�S�[���X�V�́Acpp���Ŏ������Ă���B
	�S�[���I���͉����Ȃ��B
*******************************************************]]
function NonBattleAct_Update(ai, goal)	return GOAL_RESULT_Continue; end
function NonBattleAct_Terminate(ai, goal) end


--[[*****************************************************
	���荞��
	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
*******************************************************]]
function NonBattleAct_Interupt(ai, goal)

	-- ���܂̂Ƃ���t���O���Ȃ��̂Ń^�C�}�[�ő�p
	-- �^�C�}�[��ݒ肵�Ă���̂́AUpdate�Ŏ��s��Ԃ���������
	-- �Ȃ�FAILED��Ԃ������̂��͕s��

	local isDamaged = false;
	isDamaged = isDamaged or ai:IsInterupt( INTERUPT_Damaged_Stranger );	-- �m��Ȃ��l�ɉ���ꂽ��
	isDamaged = isDamaged or ai:IsInterupt( INTERUPT_Damaged );				-- �_���[�W��H�������
	
	if (isDamaged) then
		goal:SetTimer( 1, 99999 );		
		return true;
	end

	return false;
end
