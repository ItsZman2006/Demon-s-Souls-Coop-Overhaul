once = 1;
everytime = 0;



function Initialize_m99_99_11_01(proxy)
print("Initialize m99_99_11_01 begin");


--	�N�������@�v���C�A����
--	EventID, Who(����), RegionID, handler, bOnce	


--��101�������J���遡
--�o�b���A�C�x���g�G���A(1)�̒��ɋ��āA
--����̊p�x�������Ă��āA
--�A�N�V�����{�^�����������Ƃ�
	proxy:OnPlayerActionInRegionAngle( 101, 1, "OnEvent_101", 30,1, once);

--��131�������J���遡
--�o�b���A�C�x���g�G���A(1)�̒��ɋ��āA
--����̊p�x�������Ă��āA
--�A�N�V�����{�^�����������Ƃ�

	proxy:OnPlayerActionInRegionAngle( 131, 1, "OnEvent_131", 30,1, once);


--��102������钌1
--�E�o�b���̓w�r���m�ic0000/102�j���A�C�x���g�G���A�i2�j�ɓ��B�����Ƃ�
	proxy:OnRegionJustIn( 102, 10000, 2, "OnEvent_102", once);


--��103������钌1
--�E�o�b���A�C�x���g�G���A�i3�j�ɓ��B�����Ƃ�
	proxy:OnRegionJustIn( 103, 10000, 3, "OnEvent_103", once);


--��104������钌2
--�E�o�b�܂��̓w�r���m�ic0000/103�j���A�C�x���g�G���A�i4�j�ɓ��B�����Ƃ�
	proxy:OnRegionJustIn( 104, 10000, 4, "OnEvent_104", once);


--��110���������Đ�1
--�E�o�b���C�x���g�G���A(10)���ŃA�N�V�����{�^������������
	proxy:OnPlayerActionInRegion( 110, 10, "OnEvent_110",1, everytime);


--��123���f�u�f�[�����������J��
--�E�f�u�f�[����(120)���S���o�C�x���g�i�C�x���gID122�j���A�I�������Ƃ�
	proxy:OnCharacterDead( 123, 120, "OnEvent_123", once);


--��155���}�b�v�ړ��i���Ԑ��H1�e�j
--�E�o�b���A�C�x���g�G���A�i55�j�ɓ��B�����Ƃ�
	proxy:OnRegionJustIn( 155, 10000, 55, "OnEvent_155", everytime);


--��165���}�b�v�ړ��i���Ԑ��H2�e�j
--�E�o�b���A�C�x���g�G���A�i65�j�ɓ��B�����Ƃ�
	proxy:OnRegionJustIn( 165, 10000, 65, "OnEvent_165", everytime);


--��175���}�b�v�ړ��i���n��L��j
--�E�o�b���A�C�x���g�G���A�i75�j�ɓ��B�����Ƃ�
	proxy:OnRegionJustIn( 175, 10000, 75, "OnEvent_175", everytime);


print("Initialize m99_99_11_01 end");
end







--��101�������J����
function OnEvent_101(proxy, param)
print("OnEvent_101 begin");
	if param:IsNetMessage()==TRUE  then
		return;         
	end


--�E�C�x���g�t���O�𗧂Ă�
	proxy:SetEventFlag( 101, true );
--�EPC���C�x���g�G���A(100)�Ɉړ�
	proxy:Warp(10000, 100);
--�EPC�̃��o�[����A�j���[�V����(ID 4000)�Đ�
	proxy:PlayAnimation(10000, 4000);

print("OnEvent_101 end");
end
--��131�������J����
function OnEvent_131(proxy, param)
print("OnEvent_131 begin");

--�E�C�x���g�t���O�𗧂Ă�
	proxy:SetEventFlag( 131, true );
--�E�X�C�b�`�n�a�i�io0210/1�j���쓮����A�j���[�V�����iID 1�j���Đ�
--�@�i����΁j�쓮�r�d�iID****�j��炷
	proxy:PlayAnimation(1, 1)

--�E�����ɔ��n�a�i�io0211/2�j���J���A�j���[�V�����iID 1�j���Đ�
--�@�i����΁j�����J���r�d�iID****�j��炷
--�E���̓�����𓮂����A�ړ��ł���悤�ɂ���
	proxy:PlayAnimation(2, 1)

print("OnEvent_101 end");
end






--��102������钌1
function OnEvent_102(proxy, param)
print("OnEvent_102 begin");

--�E�C�x���g�t���O�𗧂Ă�
	proxy:SetEventFlag( 102, true );
--�E�V��n�a�i�io0224/20�j��
--�@�n�{�b�N�n�a�i�io0224_1/20�j�ɍ����ւ��āA����������
	proxy:ChangeModel(20, 1);
	proxy:SetBrokenPiece(20);

--�E�n�{�b�N�n�a�i�ɍU��������𔭐�������
--�E�n�{�b�N�n�a�i���L�����N�^�[�̃J�v�Z��������ɓ��������ꍇ�A
--�@�_���[�W���[�V�������Đ�����
--�E�n�{�b�N�n�a�i�̍U��������́A���A�ǂ�����ɂ����������_�ŏ���
--�E�i����΁j�����Ԃ���r�d�iID****�j��炷

print("OnEvent_102 end");
end






--��103���w�r���m�N��
function OnEvent_103(proxy, param)
print("OnEvent_103 begin");

--�E�w�r���m�ic1000/103�j�̃��W�b�N��ʏ�ɐ؂�ւ���
	proxy:EnableLogic(103, true);

print("OnEvent_103 end");
end






--��104������钌2
function OnEvent_104(proxy, param)
print("OnEvent_104 begin");

--�E�C�x���g�t���O�𗧂Ă�
	proxy:SetEventFlag( 104, true );
--�E���n�a�i�io0225/41�j��
--�@�n�{�b�N�n�a�i�io0225_1/41�j�ɍ����ւ��āA����������

	proxy:ChangeModel(41, 1);
	proxy:SetBrokenPiece(41);

--�E�n�{�b�N�n�a�i�ɍU��������𔭐�������
--�E�n�{�b�N�n�a�i���L�����N�^�[�̃J�v�Z��������ɓ��������ꍇ�A
--�@�_���[�W���[�V�������Đ�����
--�E�n�{�b�N�n�a�i�̍U��������́A���A�ǂ�����ɂ����������_�ŏ���
--�E�i����΁j�����Ԃ���r�d�iID****�j��炷

print("OnEvent_104 end");
end






--��110���������Đ�1
--�E�o�b���C�x���g�G���A(10)���ŃA�N�V�����{�^������������
function OnEvent_110(proxy, param)
print("OnEvent_110 begin");
--�E���v���C�S�[�X�g�i****/110�j�o�����o
--�E���v���C�S�[�X�g�̃A�j���[�V�����iID****�j���Đ�
--���S�[�X�g�̃��[�g�͂R�c����Ƒ��k
--
--���������́A���o�s�v�i�r�e�w�A�T�E���h�Ƃ��Ɂj

	proxy:BeginReplayGhost(0);


print("OnEvent_110 end");
end






--��123���f�u�f�[�����������J��
function OnEvent_123(proxy, param)
print("OnEvent_123 begin");

--�E�C�x���g�t���O�𗧂Ă�
	proxy:SetEventFlag( 123, true );

--�E�f�u�f�[���������̔��io0212/123)�̊J���A�j���[�V�����iID 1)���Đ�
--�E�i����΁j�����J��SE��炷
--�E���̓�����𓮂����A�o�b���ʂ��悤�ɂ���B
	proxy:PlayAnimation(123, 1)


print("OnEvent_123 end");
end






--��155���}�b�v�ړ��i���Ԑ��H1�e�j
function OnEvent_155(proxy, param)
print("OnEvent_155 begin");
	if param:IsNetMessage()==TRUE  then
		return;         
	end
--�}���`�v���C�̎��̃G���A�ړ����~�߂�
	if proxy:IsInParty() == true then
		return;
	end 

--�E���ǂ蒅�����o�b�̂݁A�Ԃ���Ԑ��H�im99_99_10_00�j�̎w��ʒu�Ɉړ�����
--�E�ړ���im99_99_10_00�j�̑Ή��L�����C�x���gID
--�@�o�b�i0�j���L�����i10�j
--�@�o�b�i1�j���L�����i11�j
--�@�o�b�i2�j���L�����i12�j
--�@�o�b�i3�j���L�����i13�j
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage(99,99,10,00, 10); end
	if playerId ==1 then proxy:WarpNextStage(99,99,10,00, 11); end
	if playerId ==2 then proxy:WarpNextStage(99,99,10,00, 12); end
	if playerId ==3 then proxy:WarpNextStage(99,99,10,00, 13); end

--���ړ�����L�����N�^�[�́A�ړ����Ƀp�b�Ə����Ă��܂��܂�

print("OnEvent_155 end");
end






--��165���}�b�v�ړ��i���Ԑ��H2�e�j
function OnEvent_165(proxy, param)
print("OnEvent_165 begin");
	if param:IsNetMessage()==TRUE  then
		return;         
	end
--�}���`�v���C�̎��̃G���A�ړ����~�߂�
	if proxy:IsInParty() == true then
		return;
	end 

--�E���ǂ蒅�����o�b�̂݁A�Ԃ���Ԑ��H�im99_99_10_00�j�̎w��ʒu�Ɉړ�����
--�E�ړ���im99_99_10_00�j�̑Ή��L�����C�x���gID
--�@�o�b�i0�j���L�����i20�j
--�@�o�b�i1�j���L�����i21�j
--�@�o�b�i2�j���L�����i22�j
--�@�o�b�i3�j���L�����i23�j
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage(99,99,10,00, 20); end
	if playerId ==1 then proxy:WarpNextStage(99,99,10,00, 21); end
	if playerId ==2 then proxy:WarpNextStage(99,99,10,00, 22); end
	if playerId ==3 then proxy:WarpNextStage(99,99,10,00, 23); end

--���ړ�����L�����N�^�[�́A�ړ����Ƀp�b�Ə����Ă��܂��܂�

print("OnEvent_165 end");
end






--��175���}�b�v�ړ��i���n��L��j
function OnEvent_175(proxy, param)
print("OnEvent_175 begin");
	if param:IsNetMessage()==TRUE  then
		return;         
	end
--�}���`�v���C�̎��̃G���A�ړ����~�߂�
	if proxy:IsInParty() == true then
		return;
	end 

--�E���ǂ蒅�����o�b�̂݁A�Ԃ���n��L��im99_99_12_00�j�̎w��ʒu�Ɉړ�
--�E�ړ���im99_99_12_00�j�̑Ή��L�����C�x���gID
--�@�o�b�i0�j���L�����i30�j
--�@�o�b�i1�j���L�����i31�j
--�@�o�b�i2�j���L�����i32�j
--�@�o�b�i3�j���L�����i33�j
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage(99,99,12,00, 30); end
	if playerId ==1 then proxy:WarpNextStage(99,99,12,00, 31); end
	if playerId ==2 then proxy:WarpNextStage(99,99,12,00, 32); end
	if playerId ==3 then proxy:WarpNextStage(99,99,12,00, 33); end

--���ړ�����L�����N�^�[�́A�ړ����Ƀp�b�Ə����Ă��܂��܂�

print("OnEvent_175 end");
end



















