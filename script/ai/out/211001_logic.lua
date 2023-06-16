--[[*******************************************************************************************
	�E���R�z�v�̎v�l���W�b�N
	�����F
		���z�v�ƈႢ�A���ԁE�������U�������܂ł́A
		�����I�ɐ퓬��Ԃɂ͓���܂���B
	
	ai:SetNumber()�̗p�r�B
		�O�F
		�P�F
		�Q�F
		�R�F����̂��߂̃��v�����j���O���ǂ����B
	
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_urokoF211001, "urokoF211001_Logic", "urokoF211001_Interupt");

--[[*******************************************************
	�E���R�z�v�p�̎v�l���W�b�N
*********************************************************]]
function	urokoF211001_Logic(ai)

	--���Ԃ��U������āA�^�[�Q�b�g���ǉ�����鎖�ɂ�郊�v�����j���O�̏ꍇ�A
	--�����_���Ȏ��Ԃł�����Ƒ҂��Ă���A�o�g���S�[���ցB
	if ( 0~=ai:GetNumber(3)) then
		--�C�Â��܂ł�����Ƒ҂B
		local time_rag = ai:GetRandam_Float( 3, 5);
		ai:AddTopGoal( GOAL_COMMON_Stay, time_rag, 0, TARGET_NONE);
		--���샊�v�����j���O�t���O��������B
		ai:SetNumber( 3, 0);
	end
	
	
	-- ���ʊ֐��Ń��W�b�N�𔻕�
	-- ���̒��Ő퓬�A��퓬�𔻕ʂ��Đݒ���s���Ă���B
	UROKO_EasySetup( ai, GOAL_uroko_COMMON_Wait);
end


--[[*******************************************************
	�E���R�z�v�p�̊��荞�݃��W�b�N
*********************************************************]]
function	urokoF211001_Interupt(ai, goal)
	--�~���v���󂯎��B
	if ( ai:IsInterupt(INTERUPT_FriendRequestSupport)) then
		--�P�O���ȓ��ɋ~���v�����o���Ă��閡�������邩�H
		if ( 0 < ai:GetTeamRecordCount( COORDINATE_TYPE_Support, TARGET_NONE, 16) ) then
			--���łɒN���Ɛ퓬��Ԃ��H
			if ( false==ai:IsBattleState() ) then 
				--�������U�������^�[�Q�b�g��ǉ��B
				ai:AddFriendAttackedTarget();
				--���샊�v�����j���O�̏ꍇ�̃t���O�𗧂Ă�B
				ai:SetNumber( 3, 1);
			end
		end
	end
end





