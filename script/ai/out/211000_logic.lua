--[[*********************************************************************************************************
	�E���R�z�v�i�s�b�N���E���j�p�̎v�l���W�b�N
	�����F

	���ύX�����B
	- 08/7/16 hasem
		�E���z�v�d�l�ɁB
	
	��
	ai:SetNumber()�̗p�r�B
		�O�F�����g�p��
		�P�F�����g�p��
		�Q�F�����g�p��
		�R�F����̂��߂̃��v�����j���O���ǂ����B
	
	
	ai:AddObserveArea()�@�Ď��G���A�̃X���b�g�B
		�O�F�^�[�Q�b�g�̔w��ɓ��������ǂ����̔���p�B	
	
***********************************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_urokoP211000, "urokoP211000_Logic", "urokoP211000_Interupt");



--[[*******************************************************************************************
--	�E���R�z�v�i�s�b�N���E���j�p�̎v�l���W�b�N
--	���̒��Ō��݂̏󋵂𔻕ʂ��A�g�p����g�b�v�S�[�����ЂƂ��肵�܂��B
*********************************************************************************************]]
function	urokoP211000_Logic(ai)

	--���Ԃ��U������āA�^�[�Q�b�g���ǉ�����鎖�ɂ�郊�v�����j���O�̏ꍇ�A
	--�����_���Ȏ��Ԃł�����Ƒ҂��Ă���A�o�g���S�[���ցB
	if ( 0~=ai:GetNumber(3)) then
		--�C�Â��܂ł�����Ƒ҂B
		local time_rag = ai:GetRandam_Float( 3, 5);
		ai:AddTopGoal( GOAL_COMMON_Stay, time_rag, 0, TARGET_NONE);
		--���샊�v�����j���O�t���O��������B
		ai:SetNumber( 3, 0);
	end
	
	if (false == ai:IsBattleState()) then
		--�Ď��̈�ɁA�^�[�Q�b�g�̔w���ݒ�B
		ai:AddObserveArea( 0, TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_B, 90, 4);
	end

	-- ���ʊ֐��Ń��W�b�N�𔻕�
	-- ���̒��Ő퓬�A��퓬�𔻕ʂ��Đݒ���s���Ă���B
	UROKO_EasySetup( ai, GOAL_uroko_COMMON_Wait);

end


--[[*******************************************************************************************
--	�E���R�z�v�i�s�b�N���E���j�p�̊��荞�݃��W�b�N
--	���݂̏�Ԃł�肱�߂�̂ł����true���A
--	���̂܂ܖ�������̂ł����false��Ԃ��Ă��������B
*********************************************************************************************]]
function	urokoP211000_Interupt(ai, goal)

	--�~���v���󂯎��B
	if ( ai:IsInterupt(INTERUPT_FriendRequestSupport)) then
		--�P�O���ȓ��ɋ~���v�����o���Ă��閡�������邩�H
		if ( 0 < ai:GetTeamRecordCount( COORDINATE_TYPE_Support, TARGET_NONE, 10) ) then
			--���łɒN���Ɛ퓬��Ԃ��H
			if ( false==ai:IsBattleState() ) then 
				--�������U�������^�[�Q�b�g��ǉ��B
				ai:AddFriendAttackedTarget();
				--���샊�v�����j���O�̏ꍇ�̃t���O�𗧂Ă�B
				ai:SetNumber( 3, 1);
			end
		end
		
	elseif (ai:IsInterupt(INTERUPT_Inside_ObserveArea)) then
	
		--�O�Ԃ������������Ă��邩�H
		if ( ai:IsInsideObserveArea( 0)) then
			--�U�����J�n���Ă������B
			ai:ShiftCurrTargetBattleState();
			--���v�����j���O�B
			ai:Replaning();
			--�G���A�Ď����폜�B
			ai:DeleteObserveArea(0);
		end

	end

end


