once = 1;
everytime = 0;





function Initialize_m99_99_11_00(proxy)
print("Initialize m99_99_11_00 begin");


--[[���`���[�g���A���p�̃C�x���g]]



--��1000���n�V�SA(�΂�10�x)�~�聡
	proxy:OnActionEventRegion(1000, 2100, "OnEvent_1000", LadderAngle_A, HELPID_DOWN, everytime);
--��1001���n�V�SA(�΂�10�x)���聡
	proxy:OnActionEventRegion(1001, 2101, "OnEvent_1001", LadderAngle_A, HELPID_UP,   everytime);

	


	
--��6000��NPC��b��--�ėp��b�ꋓ�o�^(���͔���A������A�͈͊O����)	��ValueBuffer�@20010�g
	if proxy:IsCompleteEvent( 6000 ) == false then
		OnTalk(proxy,6000,101,TalkDist_N,TalkAngle_N,20010,HELPID_TALK,"OnEvent_6000","OnEvent_6000_1","OnEvent_6000_2",everytime);
		--��1103��NPC��b:PC����U�������ꂽ������--NPC(101)���v���C���[����U�����ꂽ��
		proxy:OnSimpleDamage(1103,101,10000,"OnEvent_1103",everytime);
		--��1101��NPC��b�F���S������--PC���C�x���gID101��HP��0�ɂ����Ƃ�
		proxy:OnCharacterHP(1101,101,"OnEvent_1101",0.0,once);
		--��1102��NPC��b�F���S���S������--�C�x���gID101�����S�Ɏ��񂾂Ƃ�
		proxy:OnCharacterDead(1102,101,"OnEvent_1102",once);
	end
	
		

--�G���A���Z�b�g���Ȃ��悤�Ƀt���O�ς��܂����B

--��6020�������J���遡
--�o�b���A�C�x���g�G���A(1)�̒��ɋ��āA
--����̊p�x�������Ă��āA
--�A�N�V�����{�^�����������Ƃ�
	if proxy:IsCompleteEvent( 6020 ) == false then
		proxy:OnPlayerActionInRegionAngle( 6020, 1, "OnEvent_6020", 30, HELPID_PULL_LEVER, once);
	else
		proxy:EndAnimation( 1, 1 );--���o�[
		proxy:EndAnimation( 2, 1 );--��
	end

		
--�G���A���Z�b�g���Ȃ��悤�Ƀt���O�ς��܂����B

--��6010������钌1
--�E�o�b���̓w�r���m�ic0000/6010�j���A�C�x���g�G���A�i2�j�ɓ��B�����Ƃ�
	if proxy:IsCompleteEvent( 6010 ) == false then
		proxy:OnRegionJustIn( 6010, 10000, 2, "OnEvent_6010", once);
	end

--��6011���֕��m�N��?
--�E�o�b���A�C�x���g�G���A�i3�j�ɓ��B�����Ƃ�
	if proxy:IsCompleteEvent( 6011 ) == false then
		proxy:OnRegionJustIn( 6011, 10000, 3, "OnEvent_6011", once);
	end

--��6012������钌2
--�E�o�b�܂��̓w�r���m�ic0000/6011�j���A�C�x���g�G���A�i4�j�ɓ��B�����Ƃ�
	if proxy:IsCompleteEvent( 6012 ) == false then
		proxy:OnRegionJustIn( 6012, 10000, 4, "OnEvent_6012", once);	
	end		
		

		
		
--�G���A���Z�b�g���Ȃ��悤�Ƀt���O�ς��܂����B

		
--��6030���f�u�f�[�����������J��
--�E�f�u�f�[����(120)���S���o�C�x���g�i�C�x���gID122�j���A�I�������Ƃ�
	if proxy:IsCompleteEvent( 6030 ) == false then
		proxy:OnCharacterDead( 6030, 120, "OnEvent_6030", once);
	else
		proxy:EndAnimation( 123 , 1 );
	end
	
	
		

--[[�����܂ł������C�x���g]]


--	�N�������@�v���C�A����
--	EventID, Who(����), RegionID, handler, bOnce	

--[[�@�ȑO�̂ł��B

--��131�������J���遡
--�o�b���A�C�x���g�G���A(1)�̒��ɋ��āA
--����̊p�x�������Ă��āA
--�A�N�V�����{�^�����������Ƃ�
	proxy:OnPlayerActionInRegionAngle( 131, 1, "OnEvent_131", 30, HELPID_PULL_LEVER, once);

]]


	
--[[ �ȑO�̂ł��B

--��102������钌1
--�E�o�b���̓w�r���m�ic0000/102�j���A�C�x���g�G���A�i2�j�ɓ��B�����Ƃ�
	proxy:OnRegionJustIn( 102, 10000, 2, "OnEvent_102", once);


--��103������钌1
--�E�o�b���A�C�x���g�G���A�i3�j�ɓ��B�����Ƃ�
	proxy:OnRegionJustIn( 103, 10000, 3, "OnEvent_103", once);


--��104������钌2
--�E�o�b�܂��̓w�r���m�ic0000/103�j���A�C�x���g�G���A�i4�j�ɓ��B�����Ƃ�
	proxy:OnRegionJustIn( 104, 10000, 4, "OnEvent_104", once);
]]
	
	
--��110���������Đ�1
--�E�o�b���C�x���g�G���A(10)���ŃA�N�V�����{�^������������
	
	--proxy:OnPlayerActionInRegion( 110, 10, "OnEvent_110",1, everytime);

	
--[[ �ȑO�̂ł��B

--��123���f�u�f�[�����������J��
--�E�f�u�f�[����(120)���S���o�C�x���g�i�C�x���gID122�j���A�I�������Ƃ�
	proxy:OnCharacterDead( 123, 120, "OnEvent_123", once);
	
]]	
	
	
	

--��155���}�b�v�ړ��i���Ԑ��H1�e�j
--�E�o�b���A�C�x���g�G���A�i55�j�ɓ��B�����Ƃ�
	proxy:OnRegionJustIn( 155, 10000, 55, "OnEvent_155", everytime);


--��165���}�b�v�ړ��i���Ԑ��H2�e�j
--�E�o�b���A�C�x���g�G���A�i65�j�ɓ��B�����Ƃ�
	proxy:OnRegionJustIn( 165, 10000, 65, "OnEvent_165", everytime);


--��175���}�b�v�ړ��i���n��L��j
--�E�o�b���A�C�x���g�G���A�i75�j�ɓ��B�����Ƃ�
	proxy:OnRegionJustIn( 175, 10000, 75, "OnEvent_175", everytime);
	
	
--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m99_99_11_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m99_99_11_00", everytime );
	proxy:NotNetMessage_end();
	
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 99998, "MapInit", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();


print("Initialize m99_99_11_00 end");
end

function MapInit(proxy,param )

--[[�܂��ɏ����Ă���������

	if proxy:IsCompleteEvent( 102 ) ==true then
--		proxy:ChangeModel(20, 1);
--		proxy:SetBrokenPiece(20);
		proxy:ReconstructBreak( 20 , 1 );
	end
	if proxy:IsCompleteEvent(131) ==true then
		proxy:EndAnimation(1, 1);
		proxy:EndAnimation(2, 1);
	end
]]


--NPC�̎��S�Č�

	if proxy:IsCompleteEvent( 6000 ) == true then
		proxy:ForceDead( 101 );
	end

--���{�X�̎��S�Č�
	
	if proxy:IsCompleteEvent( 6030 ) == true then
		proxy:ForceDead( 120 );
	end

--���W�b�N����

--��6011���֕��m�N��?
	if proxy:IsCompleteEvent( 6011 ) == true then
		proxy:EnableLogic( 103 , 1 );
	else
		proxy:EnableLogic( 103 , 0 );
	end
	
	
--���̔j��Č�(�G���A����Ȃ������Ƃ��p)
	
--��6010������钌1
	if proxy:IsCompleteEvent( 6010 ) == true then
		proxy:ReconstructBreak( 20 , 1 );
	end

--��6012������钌2
	if proxy:IsCompleteEvent( 6012) == true then
		proxy:ReconstructBreak( 41 , 1 );
	end

--[[
	--���p�j�f�[�����p (�t���O�͉��A�w�肪����Ες���)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m99_99_11_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_11_00);
	end
]]

end

--------------------------------------------------------------------------------------
--�}���`�ɂȂ������Ƀz�X�g���ᖳ�������灡����
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end





--[[ �`���[�g���A���p ]]


--��6020�������J����
function OnEvent_6020(proxy, param)
print("OnEvent_6020 begin");

	if param:IsNetMessage()==true  then
		return;         
	end

--�EPC���C�x���g�G���A(100)�Ɉړ�
	proxy:Warp(10000, 100);
--�EPC�̃��o�[����A�j���[�V����(ID 4000)�Đ�
	proxy:PlayAnimation(10000, 8000);
	
--�E�C�x���g�t���O�𗧂Ă�
	proxy:SetEventFlag( 6020, 1 );
--�E�X�C�b�`�n�a�i�io0210/1�j���쓮����A�j���[�V�����iID 1�j���Đ�
--�@�i����΁j�쓮�r�d�iID****�j��炷
	proxy:PlayAnimation(1, 1)

--�E�����ɔ��n�a�i�io0211/2�j���J���A�j���[�V�����iID 1�j���Đ�
--�@�i����΁j�����J���r�d�iID****�j��炷
--�E���̓�����𓮂����A�ړ��ł���悤�ɂ���
	proxy:PlayAnimation(2, 1)

print("OnEvent_6020 end");
end




--��6010������钌1
function OnEvent_6010(proxy, param)
print("OnEvent_6010 begin");

--�E�C�x���g�t���O�𗧂Ă�
	proxy:SetEventFlag( 6010, 1 );
--�E�V��n�a�i�io0224/20�j��
--�@�n�{�b�N�n�a�i�io0224_1/20�j�ɍ����ւ��āA����������
	proxy:ChangeModel(20, 1);
	proxy:SetBrokenPiece(20);

--�E�n�{�b�N�n�a�i�ɍU��������𔭐�������
--�E�n�{�b�N�n�a�i���L�����N�^�[�̃J�v�Z��������ɓ��������ꍇ�A
--�@�_���[�W���[�V�������Đ�����
--�E�n�{�b�N�n�a�i�̍U��������́A���A�ǂ�����ɂ����������_�ŏ���
--�E�i����΁j�����Ԃ���r�d�iID****�j��炷

print("OnEvent_6010 end");
end



--��6011���w�r���m�N��
function OnEvent_6011(proxy, param)
print("OnEvent_6011 begin");

--�E�w�r���m�ic1000/6011�j�̃��W�b�N��ʏ�ɐ؂�ւ���
	proxy:EnableLogic(103, true);

print("OnEvent_6011 end");
end




--��6012������钌2
function OnEvent_6012(proxy, param)
print("OnEvent_6012 begin");

--�E�C�x���g�t���O�𗧂Ă�
	proxy:SetEventFlag( 6012, 1 );
--�E���n�a�i�io0225/41�j��
--�@�n�{�b�N�n�a�i�io0225_1/41�j�ɍ����ւ��āA����������

	proxy:ChangeModel(41, 1);
	proxy:SetBrokenPiece(41);

--�E�n�{�b�N�n�a�i�ɍU��������𔭐�������
--�E�n�{�b�N�n�a�i���L�����N�^�[�̃J�v�Z��������ɓ��������ꍇ�A
--�@�_���[�W���[�V�������Đ�����
--�E�n�{�b�N�n�a�i�̍U��������́A���A�ǂ�����ɂ����������_�ŏ���
--�E�i����΁j�����Ԃ���r�d�iID****�j��炷

print("OnEvent_6012 end");
end





--��6030���f�u�f�[�����������J��
function OnEvent_6030(proxy, param)
print("OnEvent_6030 begin");

--�E�C�x���g�t���O�𗧂Ă�
	proxy:SetEventFlag( 6030, 1 );

--�E�f�u�f�[���������̔��io0212/6030)�̊J���A�j���[�V�����iID 1)���Đ�
--�E�i����΁j�����J��SE��炷
--�E���̓�����𓮂����A�o�b���ʂ��悤�ɂ���B
	proxy:PlayAnimation(123, 1)


print("OnEvent_6030 end");
end



--------------------------------------------------------------------------------------
--�n�V�SB�~�聡1000
--------------------------------------------------------------------------------------
--��1000���n�V�SB�~��X�^�[�g��
function OnEvent_1000(proxy, param)
	print("OnEvent_1000 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1000 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,2,2);				--�z�o�[�ړ����[�h�Ɉڍs
	proxy:HoverMoveVal(10000,2102,LadderTime_A);--�ړ��ʒu(2102)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,1);				--�C�x���g�R�}���hID(1)"�n�V�S�ォ���"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 4, 1, 3.0 );
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(1000,"OnEvent_1000_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���)
		proxy:OnKeyTime2(1000,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_1000 end");
end

--��1000_1���n�V�SB�~��X�^�[�g:�z�o�[�ړ��I����
function OnEvent_1000_1(proxy, param)
	print("OnEvent_1000_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1000_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,8,7);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1000_1 end");
end


--------------------------------------------------------------------------------------
--�n�V�SB���聡1001
--------------------------------------------------------------------------------------
--��1001���n�V�SB����X�^�[�g��
function OnEvent_1001(proxy, param)
	print("OnEvent_1001 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1001 end");
		return;
	end
	
	--�͂�������ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,-1,1);			--�z�o�[�ړ����[�h�Ɉڍs
	proxy:HoverMoveVal(10000,2103,LadderTime_A);--�ړ��ʒu(2103)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,0);				--�C�x���g�R�}���hID(0)"�n�V�S�������"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 4, 1, 3.0 );
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂�������X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(1001,"OnEvent_1001_1",LadderTime_A,0,0,once);
		--�͂�������p�̊֐���1�b�Ԕ��s(�C�x���g���j���[�̒��f����?)
		proxy:OnKeyTime2(1001,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1001 end");
end

--��1001_1���n�V�SA����X�^�[�g:�z�o�[�ړ��I����
function OnEvent_1001_1(proxy, param)
	print("OnEvent_1001_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1001_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,-1,7);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1001_1 end");
end




--------------------------------------------------------------------------------------
--NPC��b��6000��ValueBuffer 20010�g�p
--------------------------------------------------------------------------------------
--��6000��NPC��b��AnctionButton����
function OnEvent_6000(proxy, param)
	print("OnEvent_6000 begin");
	if param:IsNetMessage()==true  then
		return;
	end
	
	FlagValue = proxy:IsCompleteEventValue(20010);

	if FlagValue ==0 then proxy:SetEventFlag( 20010, 1 ); end
	if FlagValue ==1 then
		proxy:SetEventFlag( 20010, 0 );		
	end
	print("OnEvent_6000 end");
end

--��6000_1��NPC��b�����ݕ\�����郁�b�Z�[�W
function OnEvent_6000_1(proxy, param)
	print("OnEvent_6000_1 begin");
	
	--ValueBuffer20010�̒l���擾����
	FlagValue = proxy:IsCompleteEventValue(20010);
	--�y�[�W�������ĂȂ���Δ�����
	if FlagValue ==0 then return;	 end
	if FlagValue ==1 then proxy:StartTalk(80000130,0);	 end
	
	if FlagValue ==4 then proxy:StartTalk(90000700,0);	 end--����ł�Ƃ��H
	
	print("OnEvent_6000_1 end");
end

--��6000_2��NPC��b��������������o���ꍇ�̏���
function OnEvent_6000_2(proxy, param)
	print("OnEvent_6000_2 begin");

	--ValueBuffer20010�̒l���擾����
	FlagValue = proxy:IsCompleteEventValue(20010);

	if FlagValue >=1 then
		proxy:SetEventFlag( 20010, 0 );		
	end

	print("OnEvent_6000_2 end");
end

--��1101��NPC��b��NPC��HP��0�ɂȂ����u��
function OnEvent_1101(proxy, param)
	print("OnEvent_1101 begin");
	--�E�������̋������͈͓��Ȃ�
	if proxy:IsDistance(10000,101,TalkDist_N) == true then	
		--ValueBuffer20010�̒l��ݒ肷��
		proxy:SetEventFlag(20010,4);
	else
		--�͈͊O�Ȃ�y�[�W�������\�����Ȃ��y�[�W��
		--ValueBuffer20010�̒l��ݒ肷��
		proxy:SetEventFlag(20010,5);
	
	end
		
	print("OnEvent_1101 end");
end

--��1102��NPC��b��NPC����
function OnEvent_1102(proxy, param)
	print("OnEvent_1102 begin");
	--ValueBuffer20010�̒l��ݒ肷��
	proxy:SetEventFlag(20010,0 );
	proxy:SetEventFlag(6000,1);
	--�L�����N�^������ŕK�v�Ȃ��Ȃ�̂ŉ�b�C�x���g���폜����
	proxy:DeleteEvent(6000);
	proxy:DeleteEvent(1103);
	print("OnEvent_1102 end");
end

--��1103��NPC��b:PC����U�����ꂽ������
function OnEvent_1103(proxy, param)
	print("OnEvent_1103 begin");
	if proxy:IsDistance(10000,101,TalkDist_N) == false then
		return ;
	end
	print("OnEvent_1103 end");
end






















--[[�ȑO�̂ł��B]]


--[[

--��131�������J����
function OnEvent_131(proxy, param)
print("OnEvent_131 begin");

	if param:IsNetMessage()==true  then
		return;         
	end

--�EPC���C�x���g�G���A(100)�Ɉړ�
	proxy:Warp(10000, 100);
--�EPC�̃��o�[����A�j���[�V����(ID 4000)�Đ�
	proxy:PlayAnimation(10000, 8000);
	
--�E�C�x���g�t���O�𗧂Ă�
	proxy:SetEventFlag( 131, 1 );
--�E�X�C�b�`�n�a�i�io0210/1�j���쓮����A�j���[�V�����iID 1�j���Đ�
--�@�i����΁j�쓮�r�d�iID****�j��炷
	proxy:PlayAnimation(1, 1)

--�E�����ɔ��n�a�i�io0211/2�j���J���A�j���[�V�����iID 1�j���Đ�
--�@�i����΁j�����J���r�d�iID****�j��炷
--�E���̓�����𓮂����A�ړ��ł���悤�ɂ���
	proxy:PlayAnimation(2, 1)

print("OnEvent_131 end");
end

]]







--[[

--��102������钌1
function OnEvent_102(proxy, param)
print("OnEvent_102 begin");

--�E�C�x���g�t���O�𗧂Ă�
	proxy:SetEventFlag( 102, 1 );
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
	proxy:SetEventFlag( 104, 1 );
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


]]



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



--[[

--��123���f�u�f�[�����������J��
function OnEvent_123(proxy, param)
print("OnEvent_123 begin");

--�E�C�x���g�t���O�𗧂Ă�
	proxy:SetEventFlag( 123, 1 );

--�E�f�u�f�[���������̔��io0212/123)�̊J���A�j���[�V�����iID 1)���Đ�
--�E�i����΁j�����J��SE��炷
--�E���̓�����𓮂����A�o�b���ʂ��悤�ɂ���B
	proxy:PlayAnimation(123, 1)


print("OnEvent_123 end");
end

]]




--��155���}�b�v�ړ��i���Ԑ��H1�e�j
function OnEvent_155(proxy, param)
print("OnEvent_155 begin");
	if param:IsNetMessage()==true  then
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
	if param:IsNetMessage()==true  then
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
	if param:IsNetMessage()==true  then
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




--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m99_99_11_00(proxy, param)
	print("PlayerDeath_m99_99_11_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_11_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerDeath_m99_99_11_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m99_99_11_00(proxy,param)
	print("PlayerRevive_m99_99_11_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_11_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerRevive_m99_99_11_00");
end


