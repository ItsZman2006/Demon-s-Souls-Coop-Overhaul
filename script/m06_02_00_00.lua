
--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉����������
--------------------------------------------------------------------------------------
function Initialize_m06_02_00_00(proxy)
	print("Initialize_m06_02_00_00 begin");
-----------------------------------------------------------------------------------------
--�{�X�֘A
-----------------------------------------------------------------------------------------
--��1050���{�X�����ɓ��遡
	
	--���{�X�������Ă���Ƃ������C�x���g�o�^
	if proxy:IsCompleteEvent( 6400 ) == false then
	
		--�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B
		SingleReset(proxy, 1050);
		
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���)
		proxy:LuaCall( 1051, 1, "OnEvent_1051_1", everytime );
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCall( 1051 , 5 , "OnEvent_1050_GO_TO_IN" , everytime );
		--���t���O�Z�b�g(�����p)
		proxy:LuaCall( 1051 , 6 , "OnEvent_1050_flag_set" , everytime );

		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ�
		if proxy:IsCompleteEvent( 1050 ) == false then
		
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l����
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--��1050�����ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegionAttribute( 1050, 2893, "OnEvent_1050", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B
		
			proxy:NotNetMessage_begin();
				--��1051�����ɓ��邽�߂̃C�x���g��ǉ���--�n���h���͏�Ɠ���
				proxy:OnPlayerActionInRegion( 1051, 2893, "OnEvent_1050", HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		
		end
	end
	

--��1052���{�X�퓬�J�n��
	if proxy:IsCompleteEvent( 6400 ) == false then
		proxy:OnRegionJustIn( 1052 , 10000 , 2885 , "OnEvent_1052" , once );		
		proxy:OnRegionJustIn( 1053 , 10000 , 2883 , "OnEvent_1053" , once );
	end
	

--��6400���G���A�{�X���S��
	proxy:AddFieldInsFilter( 825 );
	if proxy:IsCompleteEvent( 6400 ) ==false then
		proxy:OnCharacterDead(6400, 825, "OnEvent_6400", once);
	end

	--���{�X�֘A�̏���������
	if proxy:IsCompleteEvent( 6400 ) ==true then
		
		--���{�X����ł���Ƃ�
		--�{�X���Ȃ��Ȃ�
		InvalidBackRead( proxy , 825 );
		
		--���@�Ǐ�����(���̃}�b�v�͖��@�ǈ��)
		proxy:SetColiEnable( 1993 , false );
		proxy:SetDrawEnable( 1993 , false );	

		--���@�ǂ�SFX OFF
		proxy:InvalidSfx( 1985 , true );
		
	else
	    --���{�X�����Ă���Ƃ�
		if proxy:IsClient() == false  then
			proxy:EnableLogic( 825 , false );--���W�b�NOFF�őҋ@
		end		
	end	
	
	
	--��6403,6404���\�E������A�v�΂Ń��[�v��
	if proxy:IsCompleteEvent( 6400 ) ==true then--�{�X������ł���Ƃ�
		
		--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
		if proxy:IsCompleteEvent( 6403 ) == false then
			--SFX ON
			proxy:ValidSfx( 2400 );--���̗��q
			proxy:ValidSfx( 2401 );--�v�΂̃I�[��
			proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--���点��
			proxy:OnDistanceActionAttribute( 6403 , 10000 , 1980 , "OnEvent_6403" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );

			--�\�E���L����
			proxy:SetDrawEnable( 1980 , true );
			proxy:SetColiEnable( 1980 , true );
			--�\�E��2�L����
			proxy:SetDrawEnable( 1977 , true );
			proxy:SetColiEnable( 1977 , true );

		else
			--SFX��������
			SingleReset(proxy,6404);
			proxy:InvalidSfx( 2400 , false );--���̗��q
			--proxy:InvalidSfx( 2401 , false );--�v�΂̃I�[��
			proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--���点��
			--���v�΂Ń��[�v�p�̊Ď���ǉ���
			proxy:OnDistanceActionAttribute( 6404 , 10000 , 1980 , "OnEvent_6404" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end

	else
		--�\�E��������
		proxy:SetDrawEnable( 1980 , false );
		proxy:SetColiEnable( 1980 , false );
		--�\�E��2������
		proxy:SetDrawEnable( 1977 , false );
		proxy:SetColiEnable( 1977 , false );
		--SFX��������
		proxy:InvalidSfx( 2400 , false );--���̗��q
		proxy:InvalidSfx( 2401 , false );--�v�΂̃I�[��
	end

	--�{�X�����̏�ŗ����Ă����悤�ɁA�d��Off
	proxy:SetDisableGravity( 825, true );

-----------------------------------------------------------------------------------------
--�M�~�b�N�֘A
-----------------------------------------------------------------------------------------
	--�D���t�������Ƃ肠�����폜
	proxy:SetDrawEnable(1400 ,false);
	proxy:SetColiEnable(1400 ,false);
	proxy:SetDrawEnable(1401 ,false);
	proxy:SetColiEnable(1401 ,false);
	proxy:SetDrawEnable(1402 ,false);
	proxy:SetColiEnable(1402 ,false);
	

--��1060�����̌����ˋ@�@�N����
	if proxy:IsCompleteEvent( 6400 ) == false then
		SingleReset(proxy,1060);
		SingleReset(proxy,1062);
	end
	if proxy:IsCompleteEvent( 1060 ) == false then
		--proxy:LuaCall(1060, 1, "OnEvent_1060", once);
		proxy:OnPlayerActionInRegionAngle( 1060 , 2410 , "OnEvent_1060", 90 , HELPID_START , once);
		proxy:OnPlayerActionInRegionAngle( 1062 , 2412 , "OnEvent_1062", 90 , HELPID_START , once); 
	end
	
--��6410���{�X�Е��D�����|������
	if proxy:IsCompleteEvent( 6400 ) == false then
		SingleReset(proxy,6410);
	end
	if proxy:IsCompleteEvent( 6410 ) == false then--�|�������܂��Đ�����Ă��Ȃ����
		--�|�����z�M�p
		proxy:LuaCall(6410, 20 ,"OnEvent_6410_1",once);
		proxy:NotNetMessage_begin();
			--�|�����J�n�ɌĂ΂��n���h��
			proxy:LuaCall(6410, REMO_START, "OnEvent_6410_RemoStart", once);
			--�|�����I����ɌĂ΂��n���h��(�g���K�[�N�������l�p)
			proxy:LuaCall(6410, REMO_FINISH, "OnEvent_6410_RemoFinish", once);
		proxy:NotNetMessage_end();
		
		--�j������̍폜
		proxy:SetDrawEnable(1440 ,false);
		proxy:SetColiEnable(1440 ,false);
		
	else--���łɃ|�������I�����Ă�����
		OnEvent_6412(proxy, param);--���̌����ˋ@���f�������ւ�
		OnEvent_6413(proxy, param);--�ǃ��f�������ւ�
		--�o���X�^SFX�폜
		proxy:InvalidSfx(2470, false);
	end

--��1061�����̌����ˋ@�A�N����
	if proxy:IsCompleteEvent( 6400 ) == false then
		SingleReset( proxy,1061 );
		SingleReset( proxy,1063 );
	end
	if proxy:IsCompleteEvent( 1061 ) == false then
		--proxy:LuaCall(1061, 1, "OnEvent_1061", once);
		proxy:OnPlayerActionInRegionAngle( 1061 , 2411 , "OnEvent_1061" , 90, HELPID_START , once );
		proxy:OnPlayerActionInRegionAngle( 1063 , 2413 , "OnEvent_1063" , 90, HELPID_START , once );
	end

--��6411���{�X�������t���|������
	if proxy:IsCompleteEvent( 6400 ) == false then
		SingleReset( proxy,6411 );
	end
	if proxy:IsCompleteEvent( 6411 ) == false then--�|����������Ă��Ȃ��Ȃ��
		proxy:LuaCall(6411,20,"OnEvent_6411_1",once);
		proxy:NotNetMessage_begin();
			--�|�����J�n�ɌĂ΂��n���h��
			proxy:LuaCall(6411, REMO_START, "OnEvent_6411_RemoStart", once);
			--�|�����I����ɌĂ΂��n���h��(�g���K�[�N�������l�p)
			proxy:LuaCall(6411, REMO_FINISH, "OnEvent_6411_RemoFinish", once);
		proxy:NotNetMessage_end();
		--OBJ1432����
		proxy:SetDrawEnable( 1432 ,false);
		proxy:SetColiEnable( 1432 ,false);	
	else--�|�������Ȃ���Ă�����
		--OBJ1432�L���i�͂��߂���L���j
		--OBJ1431����
		--�o���X�^SFX�폜
		proxy:InvalidSfx(2471, false);
		proxy:SetDrawEnable( 1431 ,false);
		proxy:SetColiEnable( 1431 ,false);	

		--�D�������L����
		proxy:SetDrawEnable(1401 ,true);
		proxy:SetColiEnable(1401 ,true);
		proxy:SetDrawEnable(1402 ,true);
		proxy:SetColiEnable(1402 ,true);
	end

--��6412�����̌����ˋ@���f�������ւ���
	--(OnEvent_6410 ����A��)

--��6413���ǃ��f�������ւ���
	--(OnEvent_6410 ����A��)

--��8088���B���ɗ����t���O�𗧂Ă遡
	proxy:SetEventFlag( 8088, true );

--------------------------------������QWC�C�x���g�֘A������--------------------------------
	
--��1110���O������\�������遡
	SingleReset(proxy,1110);
	if 	proxy:IsSuccessQWC( 60140 ) == false and
		proxy:IsCompleteEvent(1114) == false then	
		proxy:SetEventFlag( 1110, true );
	end
	
	--QWC�����ɒʉ߂��������Ă���̂Ŕ�\��
	if proxy:IsCompleteEvent( 1110 ) == false then
		proxy:SetDrawEnable( 1433, false );
		proxy:SetColiEnable( 1433, false );
	end

--��1114���O�����ɋ߂Â�����
	if proxy:IsCompleteEvent(1114) == false then
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionJustIn( 1114 , 10000 , 2480 , "OnEvent_1114",once);
			proxy:NotNetMessage_end();
		end
	end
		
--��1111���o�b���O����������������
	if proxy:IsCompleteEvent( 1111 ) == false then
		--�z�X�g�A�����A�O���C�̂ݒ��ׂ邱�Ƃ��ł���
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		
		proxy:OnDistanceActionAttribute( 1111 , 10000 , 1434 , "OnEvent_1111" , ItemBoxDist_A , 10010125 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
		proxy:LuaCall( 1111,1,"OnEvent_1111_2",once);
		proxy:LuaCall( 1111,2,"OnEvent_1111_3",once);
		proxy:TreasureDispModeChange2( 1434, true ,KEN_SFX);
	else
		proxy:SetDrawEnable( 1434 , false );--�ЂƂ܂��`�悾��OFF
		proxy:SetColiEnable( 1434 , false );
	end
	
	--proxy:SetRarity( 1434, 10626 );

--------------------------------������QWC�C�x���g�֘A������--------------------------------
--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m06_02_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m06_02_00_00", everytime );
	proxy:NotNetMessage_end();
	
	--��1120���E�B���I�E�B�X�v��
	SingleReset( proxy , 1120 );
	if proxy:IsCompleteEvent( 1120 ) == false then
		proxy:OnPlayerDistanceInTarget( 1120 , 10000 , 1441 , "OnEvent_1120",2.0,once);
		proxy:SetObjSfx( 1441 , 1 , 96001 , true );
	end
	
	--��1121���E�B���I�E�B�X�v��
	SingleReset( proxy , 1121 );
	if proxy:IsCompleteEvent( 1121 ) == false then
		proxy:OnPlayerDistanceInTarget( 1121 , 10000 , 1442 , "OnEvent_1121",2.0, once);
		proxy:SetObjSfx( 1442 ,1 , 96001 , true );
	end
	
	
	--��999999���t���[���x��̏����������C�x���g�𔭍s��
	proxy:NotNetMessage_begin();
		--��0�b�づ--
		proxy:OnKeyTime2( 999992, "Second_Initialize_m06_02_00_00", 0.3, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m06_02_00_00 end");
end

--------------------------------------------------------------------------------------
--Initialize����Ă΂��A1�t���[���x��̏�����������999999
--------------------------------------------------------------------------------------
--��999999���ꕔ�AInit�ł͏����ł��Ȃ��̂ŁA�c���Ă���
function Second_Initialize_m06_02_00_00(proxy, param)
	print("Second_Initialize_m06_02_00_00 begin");

--------------------------------������QWC�C�x���g�֘A������--------------------------------
--------------------------------������QWC�C�x���g�֘A������-------------------------------

	print("Second_Initialize_m06_02_00_00 end");
end

--------------------------------------------------------------------------------------
--�}���`�ɂȂ������Ƀz�X�g���ᖳ�������灡����
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end




--------------------------------------------------------------------------------------
--��6400���G���A�{�X���S��
--------------------------------------------------------------------------------------
--��6400���G���A�{�X���S��
function OnEvent_6400(proxy, param)
	print("OnEvent_6400 begin");
		
	proxy:NotNetMessage_begin();
		--��6401���N���C�A���gPC���[�v���o��
		proxy:OnKeyTime2( 6401, "OnEvent_6401", 0, 0, 0, once);
		--��6400_1��1�b�o�߁�
		proxy:OnKeyTime2( 6400, "OnEvent_6400_1", 1, 0, 1, once);
		--��6402��2�b�o�߁�
		proxy:OnKeyTime2( 6402, "OnEvent_6402", 2, 0, 2, once);
		--�}���`���U�Ď�
		proxy:OnRegistFunc( 6400 ,"Check_6400_PT","OnEvent_6400_PT",0,once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 6400, 1 );
	
	--�u���b�N�N���A������
	proxy:CustomLuaCallStart( 4050, 825 );	
	--�g�J�Q���Z�b�g
	ResetTokage(proxy);
	
	--[[
	--����3�J���C���t�H���[�V����
	if proxy:IsClient() == false then
		if proxy:IsCompleteEvent( 8050 ) == false then
			proxy:NotNetMessage_begin();
				print("Call to OnEent_8050");
				proxy:OnKeyTime2( 8050 , "OnEvent_8050",5.0,0,0,once);
				proxy:SetEventFlag( 8050 , true );
			proxy:NotNetMessage_end();		
		end	
	end
	]]
		
	print("OnEvent_6400 end");
end

--��6400_1�����{�X���S��1�b��
function OnEvent_6400_1(proxy, param)
	print("OnEvent_6400_1 begin");
	
	--�{�X��|���������X�V(���ɂ���ăt���O�𗧂Ă�)
	GetBossFlagCount( proxy, param );
	
	--���g���t�B�[�擾���聥
	Lua_RequestUnlockTrophy(proxy, 10);--�g���t�B�󋵂𔻒肵�A�g���t�B�擾
	
	--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
	if proxy:IsCompleteEvent( 6403 ) == false then
	
		--�\�E���L����
		proxy:SetDrawEnable( 1980 , true );
		proxy:SetColiEnable( 1980 , true );
		--�\�E��2�L����
		proxy:SetDrawEnable( 1977 , true );
		proxy:SetColiEnable( 1977 , true );
		
		--SFX ON
		proxy:ValidSfx( 2400 );--���̗��q
		proxy:ValidSfx( 2401 );--�v�΂̃I�[��
		
		proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--���点��
		proxy:OnDistanceActionAttribute( 6403 , 10000 , 1980 , "OnEvent_6403" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );
	else
		--�\�E��������(������������̂ť��)
		proxy:SetDrawEnable( 1980 , false );
		proxy:SetColiEnable( 1980 , false );
	end

	--�B���N���A�t���OON
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:SetEventFlag( 8014 , 1 );
	end	
	
	print("OnEvent_6400_1 end");
end


--����R����̕\��
function OnEvent_8050(proxy,param)
	print("OnEvent_8050 begin");
	--�C���t�H�\��
	--�V�X�e�����b�Z�[�W
	--[[
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationBuffer( 10010750 );
	]]
	proxy:RequestOpenBriefingMsgPlus(10010750,true);
	proxy:PlayTypeSE( 10000 ,SOUND_TYPE_M ,777777777 );
	print("OnEvent_8050 end");
end


--------------------------------------------------------------------------------------
--��6401���N���C�A���gPC���[�v���o��
--------------------------------------------------------------------------------------

--��6401���N���C�A���gPC���[�v���o��
function OnEvent_6401(proxy, param)
	print("OnEvent_6401 begin");

	if proxy:IsClient() == true then
		proxy:PlayAnimation( 10000 , 8284 );--���[�v�A�j�����Đ�
	end

	proxy:SetEventFlag( 6401 , 1 );
	
	print("OnEvent_6401 end");
end


--------------------------------------------------------------------------------------
--��6402���V���O���F���̕ǁABGM������
--------------------------------------------------------------------------------------

--��6402���V���O���F���̕ǁABGM������
function OnEvent_6402(proxy, param)
	print("OnEvent_6402 begin");

	--�{�X��p��BGM��~
	proxy:StopPointSE( 2 );

	proxy:SetEventFlag( 6402 , 1 );
	
	print("OnEvent_6402 end");
end

--�}���`���U�Ď�
function Check_6400_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--�}���`����Ȃ�
function OnEvent_6400_PT(proxy,param)
	print("OnEvent_6400_PT begin");
	--���{�X�����̑O��̖��@�ǂ�������(�S�v���C���[)
	proxy:SetColiEnable( 1993 , false );
	proxy:SetDrawEnable( 1993 , false );	
	
	--���{�X�������@�ǂ�SFX�폜
	proxy:InvalidSfx( 1985 , true );

	--���{�X�����O�̈ړ������C�x���g���폜
	proxy:DeleteEvent( 1050 );--��l�ڂ�����Ƃ��p
	proxy:DeleteEvent( 1051 );--��l�ڈȍ~������Ƃ��p
	proxy:DeleteEvent( 1030 );--�|�����Đ��p
	proxy:DeleteEvent( 1052 );--�{�X�퓬�J�n�p	
	print("OnEvent_6400_PT end");
end




--------------------------------------------------------------------------------------
--��6403���\�E�����聡
--------------------------------------------------------------------------------------

function OnEvent_6403(proxy, param)
	print("OnEvent_6403 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--�V�����A�j�� 
		print("OnEvent_6403 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 6403, "OnEvent_6403_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_6403 end");
end


--��6403_1���A�C�e���擾��
function OnEvent_6403_1(proxy, param)
	print("OnEvent_6403_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10632�Q��
	proxy:GetRateItem(10632);	
	--�A�C�e���擾�֐�--�p�����[�^10678�Q��
	proxy:GetRateItem(10678);	
	--�A�C�e���擾�֐�--�p�����[�^10679�Q��
	proxy:GetRateItem(10679);	
	--�A�C�e���擾�֐�--�p�����[�^10680�Q��
	proxy:GetRateItem(10680);	
	--�A�C�e���擾�֐�--�p�����[�^10681�Q��
	proxy:GetRateItem(10681);	
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 6403, 1 );
	
	--SFX��������
	proxy:InvalidSfx( 2400 , true );--���̗��q
	--proxy:InvalidSfx( 2401 , true );--�v�΂̃I�[��
	
	if proxy:IsCompleteEvent( 8035 ) == false then
		proxy:NotNetMessage_begin();
			--�u�Ԃŕ\������ƃ��j���[����ɏo��̂ő҂�
			proxy:OnKeyTime2( 8035 , "OnEvent_8035_wait",0.5 , 0 , 1, once);			
		proxy:NotNetMessage_end();
	else
		--���v�΂Ń��[�v�p�̊Ď���ǉ���
		proxy:OnDistanceActionAttribute( 6404 , 10000 , 1980 , "OnEvent_6404" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	end	

	print("OnEvent_6403_1 end");
end


--[[
	]]
--�A�C�e���擾��̃E�F�C�g
function OnEvent_8035_wait(proxy,param)
	print("OnEvent_8035_wait begin");
	proxy:NotNetMessage_begin();
		--�C���t�H���j���[��������̂�҂�����
		proxy:OnRegistFunc( 8035 , "Check_8035" , "OnEvent_8035" , 1 , ocne);
	proxy:NotNetMessage_end();
	print("OnEvent_8035_wait end");
end	
--�C���t�H�҂�
function Check_8035(proxy)
	if proxy:IsShowMenu_InfoMenu() == true then
		return false;
	end
	return true;
end

--�J���C���t�H�\��
function OnEvent_8035(proxy,param)
	print("OnEvent_8035 begin");
	proxy:NotNetMessage_begin();		
		OnEvent_8050(proxy,param);
		proxy:SetEventFlag( 8035 , true );
	proxy:NotNetMessage_end();
	--���v�΂Ń��[�v�p�̊Ď���ǉ���	
	proxy:OnDistanceActionAttribute( 6404 , 10000 , 1980 , "OnEvent_6404" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	print("OnEvent_8035 end");
end



--------------------------------------------------------------------------------------
--�Β��Ƀ��[�v(�{�X�|������p)��6404
--------------------------------------------------------------------------------------
--��6404���Β��Ƀ��[�v��
function OnEvent_6404(proxy,param)	

	if proxy:IsCompleteEvent( 6404 ) == true then
		return;
	end	

	print("OnEvent_6404 begin");
	
	proxy:RepeatMessage_begin();
		--��6404_1���I�����j���[�̊Ď���
		proxy:OnSelectMenu(6404, "OnEvent_6404_0", 10010710, 0, 2, 1980, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_6404 end");
end

--��6404_0���I�����j���[�̊Ď���
function OnEvent_6404_0(proxy, param)
	print("OnEvent_6404_0 begin");
	
	if proxy:IsSession() == false then
		
		proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ�
		proxy:NoAnimeTurnCharactor( 10000 , 1980 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--���v�΂ɐG���A�j���Đ��I����
			proxy:OnChrAnimEnd( 6404 , 10000 , 8283 , "OnEvent_6404_1" , once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 6404 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_6404_0 end");
end

--��6404_1���I�����j���[�̊Ď���
function OnEvent_6404_1(proxy, param)
	print("OnEvent_6404_1 begin");
	
	proxy:SetEventFlag( 6404 , 0 );
	
	proxy:PlayAnimation( 10000 , 8284 );--�v�΂ɐG���A�j�����Đ�
	
	proxy:SetEventFlag( 6404 , 1 );
	
	OnEvent_6404_2(proxy,param);
	
	print("OnEvent_6404_1 end");
end

--��6404_2���v�΂ɐG���A�j���Đ��I����
function OnEvent_6404_2(proxy,param)	
	print("OnEvent_6404_2 begin");
	
	--�Β��֖߂��Ă�������̃t���O�𗧂Ă�
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag( 6404 , 0 );	
	--���S�񕜗v��
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1010 );
	
	print("OnEvent_6404_2 end");
end



--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m06_02_00_00(proxy, param)
	print("PlayerDeath_m06_02_00_00");
	print("PlayerDeath_m06_02_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m06_02_00_00(proxy,param)
	print("PlayerRevive_m06_02_00_00");
	print("PlayerRevive_m06_02_00_00");
end



--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ��遡1050
--------------------------------------------------------------------------------------

--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫

--��1050�����{�X�����ւ̔����J����
function OnEvent_1050(proxy,param)
	print("OnEvent_1050 begin");

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_1050 end");
		return;
	end
	
	--�N���C�A���g�ցA�{�X�����j�~���s��ʒm
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 1051 , 1 );--����A�j���̓����Đ�
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--���d�N���V�X�e��ID���^�C���A�E�g��ݒ肵��ON�ɂ���
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1050 end");
end


--����A�j���̓����Đ�(ID����)
function OnEvent_1051_1(proxy,param)
	print("OnEvent_1051_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ����s���A���̏I������OnEvent_1051_2�𔭍s����
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2889 );
		else
			proxy:LockSession();--���[�������b�N���܂��I
			--����A�j���Đ����s���A���̏I������OnEvent_1051_2�𔭍s����
			proxy:OnTurnCharactorEnd( 1051, 10000, 2889, "OnEvent_1051_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1051_1 end");
end

--����A�j���̓����Đ��I����
function OnEvent_1051_2(proxy,param)
	print("OnEvent_1051_2 begin");
	
	--�����p�����A�j���Đ�
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1051, 10000, ANIMEID_WALK, "OnEvent_1051_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1051_2 end");
end

--�����A�j���̓����Đ��I����
function OnEvent_1051_3(proxy,param)
	print("OnEvent_1051_3 begin");

	--�ŏ��̐l���{�X�����̒��ɓ���I����Ă�����A���ɔz�M����Ă���͂��Ȃ̂ŁA����������Ȃ��n���h��
	if proxy:IsCompleteEvent( 1050 ) == false then
		proxy:LuaCallStart( 1051 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCallStart( 4045 , 1 );	--�N���C�A���g�ցA�{�X�����ɓ����悤�ɂȂ������Ƃ�ʒm
		proxy:LuaCallStart( 1051 , 6 );--�t���O�Z�b�g(�����p)
		Lua_MultiDoping(proxy,825);--�}���`�v���C�h�[�s���O
	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�)
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:ResetThink( 825 );
	end
		
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );
	
	print("OnEvent_1051_3 end");
end


--��1050 2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
function OnEvent_1050_GO_TO_IN(proxy, param)
	print("OnEvent_1050_GO_TO_IN begin");

	proxy:NotNetMessage_begin();
		--��1051�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���--�n���h���� OnEvent_1050
		proxy:OnPlayerActionInRegion( 1051, 2893, "OnEvent_1050", HELPID_GO_TO_IN, everytime );--
		
		proxy:OnKeyTime2( 1051 , "StandBy_DragonDemon",0.5,0,0,once);
	proxy:NotNetMessage_end();	
	
	print("OnEvent_1050_GO_TO_IN end");
end


--��1050 �t���O�Z�b�g(�����p)
function OnEvent_1050_flag_set(proxy, param)
	print("OnEvent_1050_flag_set begin");
		
	proxy:SetEventFlag( 1050 , 1 );
	proxy:DeleteEvent( 1050 );

	print("OnEvent_1050_flag_set end");
end



--------------------------------------------------------------------------------------
--�{�X�������o��(�퓬�J�n)��1052
--------------------------------------------------------------------------------------
function OnEvent_1052(proxy, param)
	print("OnEvent_1052 begin");	
	
	--�{�X���W�b�NON
	proxy:EnableLogic( 825 , true );
	
	--�ǂݍ��݃^�C�~���O�̂Ƃ�����ǉ�����Ăق����̂Ńt���O���ĂȂ�

	--�{�X�֘A�̃C�x���g�o�^
	BossInit_DragonDemon(proxy, param);	
	
	print("OnEvent_1052 end");
end

--HP�Q�[�W�ABGM�Ή�
function OnEvent_1053(proxy,param)
	print("OnEvent_1053 begin");
	--�{�X��pBGM�Đ��J�n
	proxy:PlayPointSE( 2402, SOUND_TYPE_M, 60200000, 2 );
	--�{�X�Q�[�W�\��
	proxy:SetBossGauge(825, 0, 6050);	
	print("OnEvent_1053 begin");
end


--------------------------------------------------------------------------------------
--��1060�����̌����ˋ@�@�N����
--------------------------------------------------------------------------------------
--��1060�����̌����ˋ@�@�N����
function OnEvent_1060(proxy, param)
	print("OnEvent_1060 begin");
	
	proxy:SetEventFlag( 1060 , true );
	proxy:SetEventFlag( 1062 , true );
	proxy:DeleteEvent( 1060 );
	proxy:DeleteEvent( 1062 );
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8130 ) == true then
		print("OnEvent_1060 end");		
		return;
	end

	proxy:NotNetMessage_begin();
		--��6410���{�X�Е��D�����|�����ց�
		proxy:OnChrAnimEnd( 6410 , 10000 , 8130 , "OnEvent_6410" , once );
	proxy:NotNetMessage_end();
	
	proxy:WarpDmy( 10000 ,1430 , 191 );	

	print("OnEvent_1060 end");
end


--------------------------------------------------------------------------------------
--��1062�����̌����ˋ@�@�N����
--------------------------------------------------------------------------------------
--��1062�����̌����ˋ@�@�N����
function OnEvent_1062(proxy, param)
	print("OnEvent_1062 begin");
	
	proxy:SetEventFlag( 1060 , true );
	proxy:SetEventFlag( 1062 , true );
	proxy:DeleteEvent( 1060 );
	proxy:DeleteEvent( 1062 );
	
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8130 ) == true then
		print("OnEvent_1062 end");		
		return;
	end

	proxy:NotNetMessage_begin();
		--��6410���{�X�Е��D�����|�����ց�
		proxy:OnChrAnimEnd( 6410 , 10000 , 8130 , "OnEvent_6410" , once );
	proxy:NotNetMessage_end();	

	proxy:WarpDmy( 10000 ,1430 , 192 );	

	print("OnEvent_1062 end");
end


--------------------------------------------------------------------------------------
--��6410���{�X�Е��D�����|������
--------------------------------------------------------------------------------------

--��6410���{�X�Е��D�����|������
function OnEvent_6410(proxy, param)
	print("OnEvent_6410 begin");	
	--�|�����z�M
	proxy:LuaCallStart(6410,20);	
	print("OnEvent_6410 end");
end

--�|�����Đ�
function OnEvent_6410_1(proxy,param)
	print("OnEvent_6410_1 begin");
	proxy:StopPointSE( 2 );
	proxy:RequestRemo(60200,REMO_FLAG,6410,1);
	proxy:SetEventFlag(6410,true);
	print("OnEvent_6410_1 end");
end

--�|�����J�n�t�F�[�h
function OnEvent_6410_RemoStart(proxy,param)
	print("OnEvent_6410_RemoStart begin");
	--�o���X�^SFX�폜	
	proxy:InvalidSfx(2470, false);
	print("OnEvent_6410_RemoStart end");
end

--�|�����I���t�F�[�h
function OnEvent_6410_RemoFinish(proxy,param)
	print("OnEvent_6410_RemoFinish begin");
	--�{�X��pBGM�Đ��J�n
	proxy:PlayPointSE( 2402, SOUND_TYPE_M, 60299999, 2 );

	OnEvent_6412(proxy, param);--���̌����ˋ@���f�������ւ�
	OnEvent_6413(proxy, param);--�ǃ��f�������ւ�
	
	--�D�������L����
	proxy:SetDrawEnable(1400 ,true);
	proxy:SetColiEnable(1400 ,true);
	
	--�ҋ@�؂�ւ�
	ChangeWait_1(proxy,param);
	proxy:SetHp( 825 , 0.55);
	
	
	print("OnEvent_6410_RemoFinish end");
end


--------------------------------------------------------------------------------------
--��1061�����̌����ˋ@�A�N����
--------------------------------------------------------------------------------------
--��1061�����̌����ˋ@�A�N����
function OnEvent_1061(proxy, param)
	print("OnEvent_1061 begin");
	
	proxy:SetEventFlag( 1061 , true );
	proxy:SetEventFlag( 1063 , true );
	
	proxy:DeleteEvent( 1061 );
	proxy:DeleteEvent( 1063 );
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8130 ) == true then
		print("OnEvent_1061 end");		
		return;
	end

	proxy:NotNetMessage_begin();
		--��6411���{�X�����D�����|�����ց�
		proxy:OnChrAnimEnd( 6411 , 10000 , 8130 , "OnEvent_6411" , once );
	proxy:NotNetMessage_end();
	
	proxy:WarpDmy( 10000 , 1431 , 191 );
	
	print("OnEvent_1061 end");
end


--��1063�����̌����ˋ@�A�N����
function OnEvent_1063(proxy, param)
	print("OnEvent_1063 begin");
	
	proxy:SetEventFlag( 1061 , true );
	proxy:SetEventFlag( 1063 , true );
	
	proxy:DeleteEvent( 1061 );
	proxy:DeleteEvent( 1063 );
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8130 ) == true then
		print("OnEvent_1063 end");		
		return;
	end

	proxy:NotNetMessage_begin();
		--��6411���{�X�����D�����|�����ց�
		proxy:OnChrAnimEnd( 6411 , 10000 , 8130 , "OnEvent_6411" , once );
	proxy:NotNetMessage_end();
	
	proxy:WarpDmy( 10000 , 1431 , 192 );
	
	print("OnEvent_1063 end");
end


--------------------------------------------------------------------------------------
--��6411���{�X�������t���|������
--------------------------------------------------------------------------------------

--��6411���{�X�������t���|������
function OnEvent_6411(proxy, param)
	print("OnEvent_6411 begin");
	--�|�����̔z�M
	proxy:LuaCallStart(6411,20);
	print("OnEvent_6411 end");
end

--�|�����Đ�
function OnEvent_6411_1(proxy,param)
	print("OnEvent_6411_1 begin");
	proxy:StopPointSE( 2 );
	proxy:RequestRemo(60201,REMO_FLAG,6411,1);
	proxy:SetEventFlag(6411,true);
	print("OnEvent_6411_1 end");
end

--�|�����J�n�̃t�F�[�h��
function OnEvent_6411_RemoStart(proxy,param)
	print("OnEvent_6411_RemoStart begin");	
	--�o���X�^SFX�폜
	proxy:InvalidSfx(2471, false);
	
	--�Ў�D���t����������
	proxy:SetDrawEnable(1400 ,false);
	proxy:SetColiEnable(1400 ,false);
	print("OnEvent_6411_RemoStart end");
end

--�|�����I���̃t�F�[�h��
function OnEvent_6411_RemoFinish(proxy,param)
	print("OnEvent_6411_RemoFinish begin");
	--�{�X��pBGM�Đ��J�n
	proxy:PlayPointSE( 2402, SOUND_TYPE_M, 60299999, 2 );
	--OBJ1432�L��
	proxy:SetDrawEnable( 1432 ,true);
	proxy:SetColiEnable( 1432 ,true);
	
	--OBJ1431����
	proxy:SetDrawEnable( 1431 ,false);
	proxy:SetColiEnable( 1431 ,false);	
	
	--�D�������L����
	proxy:SetDrawEnable(1401 ,true);
	proxy:SetColiEnable(1401 ,true);
	proxy:SetDrawEnable(1402 ,true);
	proxy:SetColiEnable(1402 ,true);
	
	proxy:SetHp( 825 , 0.1);
	--�ҋ@�؂�ւ�
	ChangeWait_2(proxy,param);
	print("OnEvent_6411_RemoFinish end");
end



--------------------------------------------------------------------------------------
--��6412�����̌����ˋ@���f�������ւ���
--------------------------------------------------------------------------------------

--��6412�����̌����ˋ@���f�������ւ���
function OnEvent_6412(proxy, param)
	print("OnEvent_6412 begin");
	
	proxy:SetDrawEnable( 1430 , false );
	proxy:SetColiEnable( 1430 , false );
	
	proxy:SetDrawEnable( 1440 , true );
	proxy:SetColiEnable( 1440 , true );
	
	proxy:SetEventFlag( 6412 , 1 );

	print("OnEvent_6412 end");
end



--------------------------------------------------------------------------------------
--��6413���ǃ��f�������ւ���
--------------------------------------------------------------------------------------

--��6413���ǃ��f�������ւ���
function OnEvent_6413(proxy, param)
	print("OnEvent_6413 begin");
	
	proxy:SetDrawEnable( 1445 , false );
	proxy:SetColiEnable( 1445 , false );
	
	proxy:SetEventFlag( 6413 , 1 );

	print("OnEvent_6413 end");
end


--------------------------------------------------------------------------------------
--��1111���o�b�������ӂ�����聡
--------------------------------------------------------------------------------------
function OnEvent_1111(proxy, param)
	if param:IsNetMessage() == false then
	print("OnEvent_1111 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:PlayAnimation( 10000,8290);
		proxy:PlayAnimation( 1434 , 1);		
		proxy:OnKeyTime2( 1111 , "OnEvent_1111_0",0.01,0,0,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();	
	print("OnEvent_1111 end");
	end
end

function OnEvent_1111_0(proxy,param)
	print("OnEvent_1111_0 begin");
	if proxy:IsEventAnim( 10000 , 8290 ) == true then
		proxy:LuaCallStart( 1111 , 2 );
	else
		proxy:ForcePlayAnimation( 1434 , 0);	
	end
	print("OnEvent_1111_0 end");
end

function OnEvent_1111_1(proxy, param)
	print("OnEvent_1111_1 begin");
	--�A�C�e���擾�֐�--�p�����[�^10104�Q��
	proxy:GetRateItem(10626);	
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 1111, true );
	
	--OBJ���������߂̃C�x���g�z�M
	proxy:LuaCallStart( 1111, 1);

	print("OnEvent_1111_1 end");
end

--��1111_2����OBJ��\���p��
function OnEvent_1111_2(proxy,param)
	print("OnEvent_1111_2 begin");
	--�I�u�W�F��������
	proxy:SetDrawEnable( 1434, false );--�ЂƂ܂��`�悾��OFF
	proxy:SetColiEnable( 1434, false );--������͂���͕̂s��(����ł͂Ȃ��悤�Ȃ̂ŏ����Ȃ�)
		
	proxy:DeleteEvent( 1111 );
	print("OnEvent_1111_2 end");
end

--�A�j���Ď�����
function OnEvent_1111_3(proxy,param)
	print("OnEvent_1111_3 begin");
	
	proxy:TreasureDispModeChange2( 1434, false ,KEN_SFX);
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8290 ) == true then--�V�����A�j�� 
		proxy:PlayAnimation( 1434 , 1);	
		print("OnEvent_5 end");
		return true;
	end
	
	proxy:WarpDmy( 10000 , 1434 , 191 );--�_�~�[�ʒu�փ��|�v	
	--�A�j�����I�������Ď��ǉ�
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1111 , 10000 , 8290 , "OnEvent_1111_1", once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1111_3 end");
end


--------------------------------------------------------------------------------------
--��1120���E�B���I�E�B�X�v������
--------------------------------------------------------------------------------------
function OnEvent_1120( proxy , param )
	print("OnEvent_1120 begin");
	proxy:DeleteObjSfxEventID( 1441 );
	proxy:CastPointSpell_Horming( 400,1441, 10160 , 0,0,0,1441);
	proxy:SetEventFlag( 1120 ,true);
	print("OnEvent_1120 end");
end


--------------------------------------------------------------------------------------
--��1121���E�B���I�E�B�X�v������
--------------------------------------------------------------------------------------
function OnEvent_1121( proxy ,param)
	print("OnEvent_1121 beign");
	proxy:DeleteObjSfxEventID( 1442 );
	proxy:CastPointSpell_Horming( 400,1442, 10160 , 0,0,0,1442);
	proxy:SetEventFlag(1121,true);
	print("OnEvent_1121 end");
end


--------------------------------------------------------------------------------------
--��1114���O�����ɋ߂Â�����
--------------------------------------------------------------------------------------
function OnEvent_1114(proxy,param)
	print("OnEvent_1114 begin");
	proxy:SetEventFlag( 1114 , true );
	print("OnEvent_1114 end");
end
