
--�ŏ����ʂ̔��������p�����[�^
PoizonCycle_low			= 1.00;	--�ŏ����ʂ̎���(�Œ�)
PoizonCycle_High		= 1.01;	--�ŏ����ʂ̎���(�ŒZ)

IsInPoizonArea			= false;--�ŏ��G���A�ɓ����Ă��邩�H



--[[�y�Z�����z�̏��]]
SELEN_STATE_SEARCH_BROTHER	= 16380;--���T���Ă���
SELEN_STATE_ANGRY			= 16381;--�G��
SELEN_STATE_DEAD			= 16382;--���S
SELEN_STATE_THANKS			= 16383;--����
SELEN_STATE_PURIFY			= 16384;--����
selen_flag_list = {
	SELEN_STATE_SEARCH_BROTHER,
	SELEN_STATE_ANGRY,
	SELEN_STATE_DEAD,
	SELEN_STATE_THANKS,
	SELEN_STATE_PURIFY
};
TOTALDAMAGE_SELEN = 100;--�y�Z�����z�G�Β~�σ_���[�W

--�N���Q�W�F�l���[�^A�֌W�N���QID
KURAGE_GEN_ALIST = {170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192};
--�N���Q�W�F�l���[�^B�֌W�N���QID
KURAGE_GEN_BLIST = {200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218};
--�N���Q�W�F�l���[�^C�֌W�N���QID
KURAGE_GEN_CLIST = {220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244};
--�N���Q�W�F�l���[�^D�֌W�N���QID
KURAGE_GEN_DLIST = {250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268};

RapConditionCount = 0;
--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉����������
--------------------------------------------------------------------------------------
function Initialize_m05_01_00_00(proxy)
	print("Initialize_m05_01_00_00 begin");
-----------------------------------------------------------------------------------------
--�{�X�֘A
-----------------------------------------------------------------------------------------
--��533���{�X�����ɓ��遡
	--���{�X�������Ă���Ƃ������C�x���g�o�^
	if proxy:IsCompleteEvent( 5770 ) == false then
	
		--<�ǉ�>�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B
		SingleReset(proxy, 533);
	
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���)
		proxy:LuaCall( 534, 1, "OnEvent_534_1", everytime );
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCall( 534 , 5 , "OnEvent_533_GO_TO_IN" , everytime );
		--���t���O�Z�b�g(�����p)
		proxy:LuaCall( 534 , 6 , "OnEvent_533_flag_set" , everytime );
		
		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ�
		if proxy:IsCompleteEvent( 533 ) == false then
		
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l����
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--��533�����ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegionAttribute( 533, 2894, "OnEvent_533", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B
			proxy:NotNetMessage_begin();
				--��534�����ɓ��邽�߂̃C�x���g��ǉ���--�n���h���͏�Ɠ���
				proxy:OnPlayerActionInRegion( 534, 2894, "OnEvent_533", HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		end
	else
		InvalidBackRead( proxy, 809 );
	end
	
--��537���{�X�퓬�J�n��
	if proxy:IsCompleteEvent( 5770 ) == false then
		SingleReset( proxy, 537 );
		proxy:OnRegionJustIn( 537 , 10000 , 2886 , "OnEvent_537" , once );
	end
--��5770���{�X�����񂾂�--
	proxy:AddFieldInsFilter( 809 );
	if proxy:IsCompleteEvent( 5770 ) == false then
		proxy:OnCharacterDead(5770,809,"OnEvent_5770",once);
	else
		proxy:InvalidSfx( 1986, false );
		proxy:InvalidSfx( 1990, false );
	end

--���{�X�֘A�̏���������
	if proxy:IsCompleteEvent( 5770 ) ==true then
		
		--���{�X����ł���Ƃ�
		--�{�X���Ȃ��Ȃ�
		InvalidCharactor( proxy , 809 );
		
		--���@�Ǐ�����
		proxy:SetColiEnable( 1998 , false );
		proxy:SetColiEnable( 1994 , false );
	
		proxy:SetDrawEnable( 1998 , false );
		proxy:SetDrawEnable( 1994 , false );
		
		--SFX OFF
		proxy:InvalidSfx( 1986 , false );
		proxy:InvalidSfx( 1990 , false );
		
		--�z�X�g�v���C���[�̂݃A�C�e������C�x���g�Ɏg�p
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--�󎀑�(�\�E��?)�L����
		proxy:SetDrawEnable( 1981 , true );
		proxy:SetColiEnable( 1981 , true );
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--���点��
		--�\�E���Ɏh���������L����
		proxy:SetDrawEnable( 1976 , true );
		proxy:SetColiEnable( 1976 , true );
		--proxy:TreasureDispModeChange2( 1976 , true ,KANAME_SFX);--���点��
		
		--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
		if proxy:IsCompleteEvent( 5773 ) == false then
			--SFX�̗L����
			proxy:ValidSfx( 2360 );--�v�΂̃I�[��
			proxy:ValidSfx( 2361 );--���̗��q
			
			proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--���点��
			proxy:OnDistanceActionAttribute( 5773 , 10000 , 1981 , "OnEvent_5773" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--SFX OFF
			proxy:InvalidSfx( 2360 , false );--�v�΂̃I�[��
			--proxy:InvalidSfx( 2361 , false );--���̗��q
			--���v�΂Ń��[�v�p�̊Ď���ǉ���
			SingleReset(proxy,5774);
			proxy:OnDistanceActionAttribute( 5774 , 10000 , 1981 , "OnEvent_5774" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
		
	else
		--���{�X�����Ă���Ƃ�
		--���W�b�NOFF
		proxy:EnableLogic( 809, false );
		
		--��(�\�E��?)
		proxy:SetDrawEnable( 1981 , false );
		proxy:SetColiEnable( 1981 , false );
		--�\�E���Ɏh��������������
		proxy:SetDrawEnable( 1976 , false );
		proxy:SetColiEnable( 1976 , false );
		
		--SFX OFF
		proxy:InvalidSfx( 2360 , false );--�v�΂̃I�[��
		proxy:InvalidSfx( 2361 , false );--���̗��q
		
		--���@�ǗL����
		proxy:SetColiEnable( 1998 , true );
		proxy:SetColiEnable( 1994 , true );
		
		proxy:SetDrawEnable( 1998 , true );
		proxy:SetDrawEnable( 1994 , true );
		
		--SFX ON
		proxy:ValidSfx( 1986 );
		proxy:ValidSfx( 1990 );
	end	

-----------------------------------------------------------------------------------------
--�M�~�b�N�֘A
-----------------------------------------------------------------------------------------	
--��512�����ˋ�A��PC��OBJ(1200)�ɑ΂��Ĕ����p�x(30)�A�p�x�I�t�Z�b�g(180)�A����(150)�ŃA�N�V�����{�^��������--
	if proxy:IsCompleteEvent( 512 ) ==false then
		proxy:OnDistanceActionPlus( 512, 10000, 1200, "OnEvent_512", DrawBridgeDist_A, HELPID_START, 180, DrawBridgeAngle_A, -1.3, -1.5, 1.3, once);
	else
		proxy:EndAnimation( 1200, 1 );
	end

--��580����i���N�W�Ǒҋ@��
	if proxy:IsCompleteEvent( 580 ) == false then
		proxy:OnRegionJustIn( 580 , 10000 , 2340 , "OnEvent_580" , once );--�̈�������Ƃ�
		proxy:OnSimpleDamage( 580 , 421 , 10000 , "OnEvent_580" , once );--�U���󂯂��Ƃ�
		proxy:OnSimpleDamage( 580 , 422 , 10000 , "OnEvent_580" , once );--�U���󂯂��Ƃ�
		proxy:OnSimpleDamage( 580 , 423 , 10000 , "OnEvent_580" , once );--�U���󂯂��Ƃ�		
	end
	

--��581����i���N�W�Ǒҋ@��
	if proxy:IsCompleteEvent( 581 ) == false then
		proxy:OnRegionJustIn( 581 , 10000 , 2341 , "OnEvent_581" , once );--�̈�������Ƃ�
		proxy:OnSimpleDamage( 581 , 424 , 10000 , "OnEvent_581" , once );--�U���󂯂��Ƃ�
		proxy:OnSimpleDamage( 581 , 425 , 10000 , "OnEvent_581" , once );--�U���󂯂��Ƃ�
		proxy:OnSimpleDamage( 581 , 426 , 10000 , "OnEvent_581" , once );--�U���󂯂��Ƃ�
	end
	
--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m05_01_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m05_01_00_00", everytime );
	proxy:NotNetMessage_end();

	--����i���N�W�Ǒҋ@�p
	if proxy:IsCompleteEvent( 580 ) == false then
		proxy:SetDisableGravity( 421, true  );--�d��OFF
		proxy:EnableLogic      ( 421, false );--�v�lOFF
		
		proxy:SetDisableGravity( 422, true  );--�d��OFF
		proxy:EnableLogic      ( 422, false );--�v�lOFF
		
		proxy:SetDisableGravity( 423, true  );--�d��OFF
		proxy:EnableLogic      ( 423, false );--�v�lOFF
	end

	
	--����i���N�W�Ǒҋ@�p2
	if proxy:IsCompleteEvent( 581 ) == false then
		proxy:SetDisableGravity( 424, true  );--�d��OFF
		proxy:EnableLogic      ( 424, false );--�v�lOFF
		
		proxy:SetDisableGravity( 425, true  );--�d��OFF
		proxy:EnableLogic      ( 425, false );--�v�lOFF
		
		proxy:SetDisableGravity( 426, true  );--�d��OFF
		proxy:EnableLogic      ( 426, false );--�v�lOFF
	end
	


	--��630�`659��(�L)�i���N�W�W�F�l���[�g��
	GenerateRegist(proxy, 630, 100, 29,  5, "NamekuziGen" );
	
	--��670�`689��(�L)���s�l�W�F�l���[�g��
	GenerateRegist(proxy, 670, 140, 19,  6, "HuhaibitoGen" );
	
	--��699���N���Q�W�F�l���[�g�p�z�M��
	SingleReset( proxy,699 );
	proxy:CustomLuaCall( 699 , "GenPoint" , everytime );
	
	--��700�`709��(�L)�N���Q�W�F�l���[�gA��
	GenerateRegistKURAGE(proxy, 700, 170, 22, 13, "KurageGenA");
	
	--��710�`719��(�L)�N���Q�W�F�l���[�gB��
	GenerateRegistKURAGE(proxy, 710, 200, 18,  9, "KurageGenB");
	
	--��720�`729��(�L)�N���Q�W�F�l���[�gC��
	GenerateRegistKURAGE(proxy, 720, 220, 24, 15, "KurageGenC");
	
	--��730�`739��(�L)�N���Q�W�F�l���[�gD��
	GenerateRegistKURAGE(proxy, 730, 250, 18,  9, "KurageGenD");
	
	--���N���Q�W�F�l���[�^�̗̈���̃v���C���L������p
	proxy:OnNetRegion( 790, 2310 );
	proxy:OnNetRegion( 791, 2311 );
	proxy:OnNetRegion( 792, 2312 );
	proxy:OnNetRegion( 793, 2313 );
	proxy:OnNetRegion( 794, 2314 );
	proxy:OnNetRegion( 795, 2315 );
	proxy:OnNetRegion( 796, 2316 );
	proxy:OnNetRegion( 797, 2317 );
	proxy:OnNetRegion( 798, 2318 );
	proxy:OnNetRegion( 799, 2319 );
	
	proxy:InvalidSfx( 2222, false );
	--��515���i���N�W�R���j�[��
	if proxy:IsCompleteEvent( 515 ) == false then
		proxy:OnRegistFunc(515,"Check_515","OnEvent_515",1,everytime);
		
		proxy:SetColiEnable( 1260, false );
		proxy:SetDrawEnable( 1260, false );
		for index = 1, 15, 1 do
			InvalidCharactor( proxy, 700 + index - 1);
		end
	else
		proxy:SetColiEnable( 1250, false );
		proxy:SetDrawEnable( 1250, false );
		
		--��517�����[�����C�g�\�[�h��
		if proxy:IsCompleteEvent( 517 ) == false then
			--�z�X�g�A�����A�O���C�̂ݒ��ׂ邱�Ƃ��ł���
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:OnDistanceActionAttribute( 517 , 10000 , 1260 , "OnEvent_517_0" , ItemBoxDist_A , 10010140 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
			proxy:LuaCall( 517,1,"OnEvent_517_2",once);
			proxy:LuaCall( 517,2,"OnEvent_517_4",once);
			proxy:TreasureDispModeChange2( 1260, true ,KEN_SFX);
		else
			proxy:SetDrawEnable( 1260 , false );--�ЂƂ܂��`�悾��OFF
			proxy:SetColiEnable( 1260 , false );
		end
	end	
	--proxy:SetRarity( 1260, 10430 );
	
	--��520���ŏ���
	--�z�X�g�����ɓ����Ă����Ԃŏ��������ƁA
	--�t���O��On�̈גǉ��ł��Ȃ��ꍇ������̂Ńt���O�����낷�B
	proxy:SetEventFlag( 520, false );
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc( 520, "PoizonFloorDam", "dummy", 2, everytime );
	proxy:NotNetMessage_end();
	
	
	
--[[
	--���p�j�f�[�����p (�t���O�͉��A�w�肪����Ες���)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m05_01_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m05_01_00_00);
	end
]]
		
	--��535�����̕ǁ�
	if proxy:IsCompleteEvent( 535 ) == false then
		proxy:OnDistanceActionAttribute( 535, 10000, 1300, "OnEvent_535", 1.5, 10010403, 180.0, 90.0, ATTR_HOST + ATTR_LIVE + ATTR_GREY, everytime );
		proxy:LuaCall( 535, 2, "OnEvent_535_delete", once );
	else
		proxy:SetDrawEnable( 1300, false );
		proxy:SetColiEnable( 1300, false );
		proxy:InvalidSfx( 2200, false );
	end
	
	--��536�����̕ǁ�
	if proxy:IsCompleteEvent( 536 ) == false then
		proxy:OnDistanceActionAttribute( 536, 10000, 1301, "OnEvent_536", 1.5, 10010403, 180.0, 90.0, ATTR_HOST + ATTR_LIVE + ATTR_GREY, everytime );
		proxy:LuaCall( 536, 2, "OnEvent_536_delete", once );
	else
		proxy:SetDrawEnable( 1301, false );
		proxy:SetColiEnable( 1301, false );
		proxy:InvalidSfx( 2201, false );
	end
	
--��538���{�X��J�����Ή���
	--�{�X�������Ă���Ȃ�o�^
	if proxy:IsCompleteEvent(5770) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 538 , 10000 , 2886 ,"OnEvent_538" , everytime );
		proxy:NotNetMessage_end();
	end

--�F�蕅�s�l�̃_�~�[
--[[
	proxy:OnPlayerDistanceInTarget( 820, 10000, 140, "testINORI", 5.0, once );
	proxy:OnPlayerDistanceInTarget( 821, 10000, 141, "testINORI", 5.0, once );
	proxy:OnPlayerDistanceInTarget( 822, 10000, 142, "testINORI", 5.0, once );
	proxy:OnPlayerDistanceInTarget( 823, 10000, 143, "testINORI", 5.0, once );
	proxy:OnPlayerDistanceInTarget( 824, 10000, 144, "testINORI", 5.0, once );
	proxy:OnPlayerDistanceInTarget( 825, 10000, 145, "testINORI", 5.0, once );
]]

--��536���s��֗����t���O�𗧂Ă遡
	proxy:SetEventFlag( 8087, true );

-----------------------------------------------------------------------------------------
--NPC�֘A
-----------------------------------------------------------------------------------------
--------------------------------������QWC�C�x���g�֘A������--------------------------------
--��827��QWC�z�΂̐���o����
	if proxy:IsCompleteEvent(828) == true or	--�܂��z�΂̐��삪���S���ĂȂ��@��
	   proxy:IsSuccessQWC(50110) == false then	--QWC���������Ă��Ȃ����
		print("QWC�z�΂̐���@������");
		--�z�΂̐���𖳌���
		InvalidBackRead(proxy, 434);
		
		proxy:SetEventFlag(827, true);
	else
		print("QWC�z�΂̐���@����");
	end

--��828��QWC�z�΂̐��쎀�S�Ď���
	if proxy:IsCompleteEvent(828) == false then	--�܂��z�΂̐��삪���S���ĂȂ��Ȃ�
	   --�z�΂̐���̎��S�Ď��ǉ�
		proxy:OnCharacterDead( 828, 434, "OnEvent_828", once );
		if proxy:IsClient() == false and proxy:IsCompleteEvent(8020) == false then
			proxy:NotNetMessage_begin();
				proxy:AddCorpseEvent( 8020 , 434 );
				proxy:LuaCall( 8020 , 0 , "OnEvent_8020",once);
			proxy:NotNetMessage_end();
		end
	end
	
--��800��QWC�Z�����o����
	if proxy:IsSuccessQWC(50130) == false then	--QWC���������Ă��Ȃ����
		print("QWC�Z�����@������");
		--�Z�����𖳌���
		InvalidBackRead(proxy, 652);		
		proxy:SetEventFlag(800, true);
	else
		print("QWC�Z�����@����");
	end

--��15600���Z�����̎��̂𒲂ׂ���
	if proxy:IsCompleteEvent( 15600 ) == false then
		proxy:AddCorpseEvent( 15600 , 435 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15600 ,0 , "OnEvent_15600",once );
 		proxy:NotNetMessage_end();
	end

--��820��QWC�Z�����E�u���b�N�S�[�X�g���S�Ď���
	if proxy:IsCompleteEvent(820) == false then	--�܂��Z���������S���ĂȂ��Ȃ�
	   --�Z�����E���b�N�S�[�X�g�̎��S�Ď��ǉ�
		proxy:OnCharacterDead( 820, 435, "OnEvent_820", once );
	end
--��821��QWC�Z�����E�u���b�N�S�[�X�g�o����
	if proxy:IsCompleteEvent(820) == true or	--�܂��Z�����E�u���b�N�S�[�X�g�����S���ĂȂ��@�� 
	   proxy:IsSuccessQWC(50120) == false then	--QWC���������Ă��Ȃ����
	   
	   if 	proxy:IsCompleteEvent( 820 ) == true and
			proxy:IsCompleteEvent( 15600 ) == false then
			--���̂��Č�����
			proxy:OpeningDeadPlus( 435 , true ,false ,false );
		else
			print("QWC�Z�����E�u���b�N�S�[�X�g�@������");
			--�Z�����𖳌���
			InvalidBackRead(proxy, 435);			
		end
		--proxy:SetEventFlag(821, true);
	else
		print("QWC�Z�����E�u���b�N�S�[�X�g�@����");
	end

--�y�Z�����z
	SetFirstNpcStateFlag(proxy, param, selen_flag_list, SELEN_STATE_SEARCH_BROTHER);
	if proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork( 652);		
	end
	
--��15633���Z�����̎��̂𒲂ׂ���
	if proxy:IsCompleteEvent( 15633 ) == false then
		proxy:AddCorpseEvent( 15633 , 652 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15633 ,0 , "OnEvent_15633",once );
 		proxy:NotNetMessage_end();
	end
	
	if	proxy:IsCompleteEvent( SELEN_STATE_DEAD )	== false and
		proxy:IsCompleteEvent( SELEN_STATE_ANGRY )	== false then
		if	proxy:IsCompleteEvent( SELEN_STATE_ANGRY ) == false then
			proxy:OnCharacterTotalDamage( 803, 652, 10000, TOTALDAMAGE_SELEN, "OnEvent_803", once );
		end
		--�S�[���h������͍폜
		proxy:LuaCall( 801, 0, "OnEvent_801",once );
		--�M��������V
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 808, 0, "OnEvent_808",once );
		proxy:NotNetMessage_end();
		--�M���Ⴂ��V
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 809, 0, "OnEvent_809",once );
		proxy:NotNetMessage_end();		
	end
	--���S�Ď��ǉ�
	if proxy:IsCompleteEvent( 804 ) == false then
		proxy:OnCharacterDead( 804, 652, "OnEvent_804", once );
	end

	if proxy:IsCompleteEvent( SELEN_STATE_ANGRY )	== true then --�G�΂��Ă���Ȃ��
			proxy:EnableLogic( 652, true );
			proxy:SetTeamType( 652, TEAM_TYPE_AngryFriend );
			--SetNpcStateFlag( proxy, param, selen_flag_list, SELEN_STATE_ANGRY );
	end
	
	if	proxy:IsClient() == false then 
		if	proxy:IsCompleteEvent( SELEN_STATE_THANKS ) == true then
			if proxy:IsRegionIn(10000,2240) == true then
				proxy:NotNetMessage_begin();
					proxy:OnRegionJustOut( 802, LOCAL_PLAYER, 2240, "OnEvent_802", once );
				proxy:NotNetMessage_end();
				print("�܂��Z�����ɋ߂����ɂ���");
			else
				SetNpcStateFlag( proxy, param, selen_flag_list, SELEN_STATE_PURIFY );
				print("�����Z�����Ɨ���Ă���")
			end
		end
	end
	
	--�������Ă����疳����
	if	proxy:IsCompleteEvent( SELEN_STATE_PURIFY ) == true or
		proxy:IsCompleteEvent( SELEN_STATE_DEAD ) == true then		
		if 	proxy:IsCompleteEvent( 804 ) == true and		--�Z����������ł���
			proxy:IsCompleteEvent( 15633 ) == false then	--�������Ă��Ȃ�
			--�󎀑̂��Č�
			proxy:OpeningDeadPlus( 652 , true ,false ,false );			
		else
			InvalidBackRead( proxy, 652 );
		end
	end

--��822��QWC�\�E�������X�^�[��
	if proxy:IsSuccessQWC(50100) == false then--�������Ă��Ȃ��Ȃ��
		print("�u���b�N�S�[�X�g������");
		--431�𖳌���
		InvalidBackRead(proxy, 436);
		--432�𖳌���
		InvalidBackRead(proxy, 437);
		--433�𖳌���
		InvalidBackRead(proxy, 438);
		
		proxy:SetEventFlag(822, true);
	end
--------------------------------������QWC�C�x���g�֘A������--------------------------------
	
--��842��������u���b�N���S�Ď���
	if proxy:IsCompleteEvent( 842 ) == false then
		proxy:OnCharacterDead( 842 , 470,"OnEvent_842",once);
	else
		--������
		InvalidCharactor(proxy,470 );
	end
	
--��15500�������A�C�e���擾�Ď����n���h���̓O���[�o���ɒ�`
	if proxy:IsCompleteEvent( 15500 ) == false then
--~ 		proxy:AddCorpseEvent( 15500 , 435 );--�P�R�m�E�u���b�N
		proxy:AddCorpseEvent( 15500 , 470 );--�ʏ�E�u���b�N
	end

--��770���i���N�W���S�Ď���
	if proxy:IsCompleteEvent( 770 ) == false then
		proxy:OnCharacterDead( 770 , 440 , "OnEvent_770",once );
	end
--��15626���i���N�W���̒��ׂ����H��
	if proxy:IsCompleteEvent( 15626 ) == false then
		proxy:AddCorpseEvent( 15626 , 440 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15626 ,0 , "OnEvent_15626",once );
 		proxy:NotNetMessage_end();
	end
	
--��771���i���N�W�̎��S�Č���
	if proxy:IsCompleteEvent( 770 ) == true then
		if proxy:IsCompleteEvent( 15626 ) == false then
			--���̂��Č�����
			proxy:OpeningDeadPlus( 440 , true ,false ,false );
		else
			--������
			InvalidCharactor( proxy, 440 );
		end
	end

--��775����p�t���S�Ď���
	if proxy:IsCompleteEvent( 775 ) == false then
		proxy:OnCharacterDead( 775 , 439 , "OnEvent_775",once );
	end
	
--��15623����p�t�̎��̂𒲂ׂ����H��
	if proxy:IsCompleteEvent( 15623 ) == false then
		proxy:AddCorpseEvent( 15623 , 439 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15623 , 0 ,"OnEvent_15623",once);
		proxy:NotNetMessage_end();
	end
	
--��776����p�t�̎��S�Č���
	if proxy:IsCompleteEvent( 775 ) == true then
		if proxy:IsCompleteEvent( 15623 ) == false then
			--���̂��Č�����
			proxy:OpeningDeadPlus( 439 , true ,false ,false );
		else
			InvalidCharactor( proxy,439 );
		end
	end


	--��999999���t���[���x��̏����������C�x���g�𔭍s��
	proxy:NotNetMessage_begin();
		--��0�b�づ--
		proxy:OnKeyTime2( 999992, "Second_Initialize_m05_01_00_00", 0.2, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	proxy:OnKeyTime2( 999993, "Third_Initialize_m05_01_00_00", 1.0, 1, 2, once );
	
	print("Initialize_m05_01_00_00 end");
end

--------------------------------------------------------------------------------------
--Initialize����Ă΂��A1�t���[���x��̏�����������999999
--------------------------------------------------------------------------------------
--��999999���ꕔ�AInit�ł͏����ł��Ȃ��̂ŁA�c���Ă���
function Second_Initialize_m05_01_00_00(proxy, param)
	print("Second_Initialize_m05_01_00_00 begin");
--------------------------------������QWC�C�x���g�֘A������--------------------------------
--------------------------------������QWC�C�x���g�֘A������--------------------------------

	proxy:NotNetMessage_begin();
		--��840���SFX�\���̈�ɓ�������
		proxy:OnRegionJustIn( 840 , 10000 , 2260, "OnEvent_840",everytime);
		--��841���SFX�\���̈悩��o����
		proxy:OnRegionJustOut( 841 , 10000 , 2260, "OnEvent_841",everytime);
	proxy:NotNetMessage_end();
	print("Second_Initialize_m05_01_00_00 end");
end


function Third_Initialize_m05_01_00_00(proxy,param)
--�F�蕅�s�l�̃_�~�[
--[[
	proxy:SetEventCommand( 140, 200 );
	proxy:SetEventCommand( 141, 200 );
	proxy:SetEventCommand( 142, 200 );
	proxy:SetEventCommand( 143, 200 );
	proxy:SetEventCommand( 144, 200 );
	proxy:SetEventCommand( 145, 200 );
]]
end

function testINORI(proxy,param)
--�F�蕅�s�l�̃_�~�[
--[[
	proxy:SetEventCommand( param:GetParam2(), 201 );
]]
end

--------------------------------------------------------------------------------------
--���ˋ�A��512
--------------------------------------------------------------------------------------
--��512�����ˋ���
function OnEvent_512(proxy, param)
	print("OnEvent_512 begin");
	
	if proxy:IsCompleteEvent(512) == true then
		print("ID 512 IsCompleteEvent true"); 
		print("OnEvent_512 end");
		return;
	end
	
	proxy:PlayAnimation(1200,1);--���ˋ��̍쓮�A�j���[�V����
	proxy:SetEventFlag( 512, 1 );--���ˋ��͍쓮�ς�
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_KICK ) == true then
		print("OnEvent_512 end");
		return;
	end
	
	proxy:WarpDmy( 10000 , 1200 , 191 ); 
	
	print("OnEvent_512 end");
end

--------------------------------------------------------------------------------------
--��5774���Β��Ƀ��[�v��
--------------------------------------------------------------------------------------
function OnEvent_5774(proxy,param)	
	print("OnEvent_5774 begin");
	
	if proxy:IsCompleteEvent( 5774 ) == true then
		return;
	end
	
	proxy:RepeatMessage_begin();
		--��_1���I�����j���[�̊Ď���
		proxy:OnSelectMenu(5774, "OnEvent_5774_1", 10010710, 0, 2, 1981, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_5774 end");
end

--��5774_1���I�����j���[�̊Ď���
function OnEvent_5774_1(proxy,param)	
	print("OnEvent_5774_1 begin");
	
	if proxy:IsSession() == false then
	
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1981 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			proxy:OnChrAnimEnd( 5774 , 10000 , 8283 , "OnEvent_5774_2",once);
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(5774,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_5774_1 end");
end

--��5774_2���I�����j���[�̊Ď���
function OnEvent_5774_2(proxy,param)	
	print("OnEvent_5774_2 begin");
	
	proxy:SetEventFlag(5774,false);
			
	proxy:PlayAnimation(10000,8284);
	
	proxy:SetEventFlag(5774,true);
	
	OnEvent_5774_3(proxy, param);
	
	print("OnEvent_5774_2 end");
end

--��5774_3���Β��Ƀ��[�v��
function OnEvent_5774_3(proxy,param)	
	print("OnEvent_5774_3 begin");
	
	--�Β��֖߂��Ă�������̃t���O�𗧂Ă�
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag(5774,false);
	--���S�񕜗v��
	proxy:RequestFullRecover();
	--�Íԗv�΂ɖ߂�
	proxy:WarpNextStage( 1, 0, 0, 0, 1009);	
	print("OnEvent_5774_3 end");
end

--------------------------------------------------------------------------------------
--��580����i���N�W�Ǒҋ@��
--------------------------------------------------------------------------------------
--��580����i���N�W�Ǒҋ@��
function OnEvent_580(proxy,param)	
	print("OnEvent_580 begin");
	
	proxy:SetDisableGravity( 421 , false ); --�d��ON
	proxy:EnableLogic( 421 , true ); --���W�b�NON
	proxy:SetSpStayAndDamageAnimId( 421, -1, -1 );--����ҋ@�A�j���̖�����
	
	proxy:SetDisableGravity( 422 , false ); --�d��ON
	proxy:EnableLogic( 422 , true ); --���W�b�NON
	proxy:SetSpStayAndDamageAnimId( 422, -1, -1 );--����ҋ@�A�j���̖�����
	
	proxy:SetDisableGravity( 423 , false ); --�d��ON
	proxy:EnableLogic( 423 , true ); --���W�b�NON
	proxy:SetSpStayAndDamageAnimId( 423, -1, -1 );--����ҋ@�A�j���̖�����
	
	proxy:SetEventFlag( 580 , true );
	proxy:DeleteEvent( 580 );--�Ď���2��ނ���̂ŕЕ��������������
	
	print("OnEvent_580 end");
end



--------------------------------------------------------------------------------------
--��581����i���N�W�Ǒҋ@��
--------------------------------------------------------------------------------------
--��581����i���N�W�Ǒҋ@��
function OnEvent_581(proxy,param)	
	print("OnEvent_581 begin");

	proxy:SetDisableGravity( 424 , false ); --�d��ON
	proxy:EnableLogic( 424 , true ); --���W�b�NON
	proxy:SetSpStayAndDamageAnimId( 424, -1, -1 );--����ҋ@�A�j���̖�����
	
	proxy:SetDisableGravity( 425 , false ); --�d��ON
	proxy:EnableLogic( 425 , true ); --���W�b�NON
	proxy:SetSpStayAndDamageAnimId( 425, -1, -1 );--����ҋ@�A�j���̖�����
	
	proxy:SetDisableGravity( 426 , false ); --�d��ON
	proxy:EnableLogic( 426 , true ); --���W�b�NON
	proxy:SetSpStayAndDamageAnimId( 426, -1, -1 );--����ҋ@�A�j���̖�����
	
	proxy:SetEventFlag( 581 , true );
	proxy:DeleteEvent( 581 );--�Ď���2��ނ���̂ŕЕ��������������
	
	print("OnEvent_581 end");
end




--------------------------------------------------------------------------------------
--��630�`659��(�L)�i���N�W�W�F�l���[�g��
--------------------------------------------------------------------------------------
--��630�`659��(�L)�i���N�W�W�F�l���[�g��
function NamekuziGen(proxy,param)
	print("NamekuziGen begin");
	
	if proxy:IsCompleteEvent( 515 ) == true then
		--�R���j�[�������̂Ŕ����ł��Ȃ��B
		return;
	end
	
	local count = 0;
	proxy:SetEventFlag( param:GetParam1(), true );
	for index = 0, 29, 1 do
		local ACID 		= 630 + index;
		local targetId 	= 100 + index;
		if proxy:IsCompleteEvent( ACID ) == false then
			count = count + 1;
			--�������̃J�E���g��5�ȏ�̎��́A�܂��o�����Ă��Ȃ��i���N�W�ɂȂ�̂Ŏˏo
			if count >= 5 then
				local region_list = {2302, 2305, 2306};
				local warp_point = GetWarpPoint(proxy, region_list, index );
				
				proxy:Warp(targetId, warp_point);
				proxy:RepeatMessage_begin();
					proxy:OnCharacterDead( ACID, targetId, "NamekuziGen", once );
				proxy:RepeatMessage_end();
				ValidCharactor( proxy, targetId );
				
				proxy:SetDisableGravity( targetId, false );	--�d��ON
				proxy:DisableMapHit( targetId, true );		--�}�b�v������OFF
				proxy:SetDeadMode(targetId, true);			--���GON
				
				proxy:NotNetMessage_begin();
					--1�b���targetId�̃L�����������ON
					--proxy:OnKeyTime2( ACID, "TimerCollisionOn", 1.0, 0, targetId, once );

					--�i���N�W�������������e��
					proxy:OnRegionJustIn( ACID, targetId, 2221, "NamekuziGen_1", once );
				proxy:NotNetMessage_begin();
				
				return;
			end
		end
	end
	print("NamekuziGen end");
end

function NamekuziGen_1(proxy,param)
	print("NamekuziGen_1 begin");
	proxy:NotNetMessage_begin();
		proxy:DisableMapHit( param:GetParam2(), false );
		--2�b���targetId�̖��G��OFF
		proxy:OnKeyTime2( param:GetParam1(), "TimerMutekiOff", 1.0, 0, param:GetParam2()+2000, once );
	proxy:NotNetMessage_end();
	print("NamekuziGen_1 end");
end


--------------------------------------------------------------------------------------
--��670�`689��(�L)���s�l�W�F�l���[�g��
--------------------------------------------------------------------------------------
--��670�`689��(�L)���s�l�W�F�l���[�g��
function HuhaibitoGen(proxy,param)
	print("HuhaibitoGen begin");
	local count = 0;
	proxy:SetEventFlag( param:GetParam1(), true );
	for index = 0, 19, 1 do
		local ACID 		= 670 + index;
		local targetId 	= 140 + index;
		if proxy:IsCompleteEvent( ACID ) == false then
			count = count + 1;
			--�������̃J�E���g��4�ȏ�̎��́A�܂��o�����Ă��Ȃ����s�l�ɂȂ�̂Ŏˏo
			if count >= 4 then
				--print("HuhaibitoGen index = ",index, ", count = ", count, ", Dead = ", param:GetParam2(), ", nextTarget = ", targetId );
				if index <= 5 then
					--print("index check return end");
					return;
				end
				local region_list = {2301};
				local warp_point = GetWarpPoint(proxy, region_list, index );
				
				proxy:Warp(targetId, warp_point);
				proxy:OnCharacterDead( ACID, targetId, "HuhaibitoGen", once );
				ValidCharactor( proxy, targetId );
				proxy:SetDisableGravity( targetId, false );	--�d��ON
				return;
			end
		end
	end
	print("HuhaibitoGen end");
end


--------------------------------------------------------------------------------------
--��700�`709��(�L)�N���Q�W�F�l���[�gA��
--------------------------------------------------------------------------------------
--��700�`709��(�L)�N���Q�W�F�l���[�gA��
function KurageGenA(proxy,param)
	print("KurageGenA begin");
	
	proxy:SetEventFlag( param:GetParam1(), true );
	KurageLap( proxy, "KurageGenA", "WarpReSearchA_1", 22, 700, 170, 1, 13, 1 ,KURAGE_GEN_ALIST);
	print("KurageGenA end");
end

function WarpReSearchA_1(proxy,param)
	print("WarpReSearchA_1 begin");
	
	KurageLap( proxy, "KurageGenA", "WarpReSearchA_2", 22, 700, 170, 1, 13, 2 ,KURAGE_GEN_ALIST);
	print("WarpReSearchA_1 end");
end

function WarpReSearchA_2(proxy,param)
	print("WarpReSearchA_2 begin");
	
	KurageLap( proxy, "KurageGenA", "WarpReSearchA_1", 22, 700, 170, 1, 13, 1 ,KURAGE_GEN_ALIST)
	print("WarpReSearchA_2 end");
end




--------------------------------------------------------------------------------------
--��710�`719��(�L)�N���Q�W�F�l���[�gB��
--------------------------------------------------------------------------------------
--��710�`719��(�L)�N���Q�W�F�l���[�gB��
function KurageGenB(proxy,param)
	print("KurageGenB begin");
	
	proxy:SetEventFlag( param:GetParam1(), true );
	KurageLap( proxy, "KurageGenB", "WarpReSearchB_1", 18, 710, 200, 2, 9, 1 ,KURAGE_GEN_BLIST);
	print("KurageGenB end");
end
function WarpReSearchB_1(proxy,param)
	print("WarpReSearchB_1 begin");
	
	KurageLap( proxy, "KurageGenB", "WarpReSearchB_2", 18, 710, 200, 2, 9, 2 ,KURAGE_GEN_BLIST);
	print("WarpReSearchB_1 end");
end

function WarpReSearchB_2(proxy,param)
	print("WarpReSearchB_2 begin");
	
	KurageLap( proxy, "KurageGenB", "WarpReSearchB_1", 18, 710, 200, 2, 9, 1 ,KURAGE_GEN_BLIST)
	print("WarpReSearchB_2 end");
end



--------------------------------------------------------------------------------------
--��720�`729��(�L)�N���Q�W�F�l���[�gC��
--------------------------------------------------------------------------------------
--��720�`729��(�L)�N���Q�W�F�l���[�gC��
function KurageGenC(proxy,param)
	print("KurageGenC begin");
	
	KurageLap( proxy, "KurageGenC", "WarpReSearchC_1", 24, 720, 220, 3, 15, 1 ,KURAGE_GEN_CLIST);
	proxy:SetEventFlag( param:GetParam1(), true );
	print("KurageGenC end");
end
function WarpReSearchC_1(proxy,param)
	print("WarpReSearchC_1 begin");
	
	KurageLap( proxy, "KurageGenC", "WarpReSearchC_2", 24, 720, 220, 3, 15, 2 ,KURAGE_GEN_CLIST);
	print("WarpReSearchC_1 end");
end

function WarpReSearchC_2(proxy,param)
	print("WarpReSearchC_2 begin");
	
	KurageLap( proxy, "KurageGenC", "WarpReSearchC_1", 24, 720, 220, 3, 15, 1 ,KURAGE_GEN_CLIST)
	print("WarpReSearchC_2 end");
end


--------------------------------------------------------------------------------------
--��730�`739��(�L)�N���Q�W�F�l���[�gD��
--------------------------------------------------------------------------------------
--��730�`739��(�L)�N���Q�W�F�l���[�gD��
function KurageGenD(proxy,param)
	print("KurageGenD begin");
	
	KurageLap( proxy, "KurageGenD", "WarpReSearchD_1", 18, 730, 250, 4, 9, 1 ,KURAGE_GEN_DLIST);
	proxy:SetEventFlag( param:GetParam1(), true );
	print("KurageGenC end");
end
function WarpReSearchD_1(proxy,param)
	print("WarpReSearchD_1 begin");
	
	KurageLap( proxy, "KurageGenD", "WarpReSearchD_2", 18, 730, 250, 4, 9, 2 ,KURAGE_GEN_DLIST);
	print("WarpReSearchD_1 end");
end

function WarpReSearchD_2(proxy,param)
	print("WarpReSearchD_2 begin");
	
	KurageLap( proxy, "KurageGenD", "WarpReSearchD_1", 18, 730, 250, 4, 9, 1 ,KURAGE_GEN_DLIST)
	print("WarpReSearchD_2 end");
end



--[[
--���N���Q�W�F�l���[�^�̏����܂Ƃߊ֐�����KurageLap
	proxy					�c�C�x���g�v���L�V
	func_ok					�c�J���Ă���X�y�[�X�����݂��Ă������ɒǉ����鎀�S�Ď��̃n���h����
	func_ng					�c�J���Ă���X�y�[�X�����݂������������ɒǉ�����b��̃n���h����
	max_index				�c�ő�̐�-1(�����z�u�̑̐����܂߂��S���̐�-1)
	ACID_start				�c�A�N�V����ID�̓�
	TCID_start				�c�^�[�Q�b�g�̃C�x���gID�̓�
	list_index				�c�o�^����Ă���|�C���g����2�����z��C���f�b�N�X
	staticChrNum			�c�����z�u�̐�
	conditionParam			�c�b��̊J�n�Ŏw�肷��p�����[�^(���[�v������̂ɓ����n���h�����g���Ȃ�����)
	checklist				�c�o���|�C���g�ɐ�q�����Ȃ����̃`�F�b�N�p���X�g
]]
function KurageLap( proxy, func_ok, func_ng, max_index, ACID_start, TCID_start, list_index, staticChrNum, conditionParam ,checklist)
	--print("KurageLap begin");
	local count = 0;
	for index = 0, max_index, 1 do
		local ACID 		= ACID_start + index;
		local targetId 	= TCID_start + index;
		if proxy:IsCompleteEvent( ACID ) == false then
			count = count + 1;
			
			if count >= staticChrNum then
				local warp_point = GetWarpPointCheck(proxy, index, list_index );
				
				--�|�C���g�������ꂽ���H
				if warp_point ~= -1 then
					--�W�F�l���[�^�[�ɑ�����L�������|�C���g�ɋ��邩�H
					local chrnum = table.getn( checklist );
					local chridx = 1;
					local isOut = false;--���ɒN������
					for chridx=1 , chrnum , 1 do
						local chrId = checklist[chridx];
						if proxy:IsAlive( chrId ) == true and proxy:IsRegionIn( chrIdx , warp_point ) == true then
							isOut = true;							
						end
					end
					if isOut == false then
						if proxy:IsClient() == false then
							if proxy:IsAlive(tarrgetId) == true then
								proxy:NotNetMessage_begin();
								proxy:RepeatMessage_begin();
									proxy:OnCharacterDead( ACID, targetId, func_ok, once );
								proxy:RepeatMessage_end();
								proxy:NotNetMessage_end();
							else
								print("dead chrEvent");
							end
						end
						--�R�R��z�M�ł���悤�ɉ���
						proxy:CustomLuaCallStartPlus( 699 , targetId,warp_point );
						--proxy:Warp(targetId, warp_point);						
						--ValidCharactor( proxy, targetId );
						--proxy:SetDisableGravity( targetId, false );	--�d��ON						
					else
						proxy:NotNetMessage_begin();
							proxy:OnKeyTime2( ACID, func_ng, 1.0, 0, RapConditionCount, once );
							RapConditionCount = RapConditionCount +1;
						proxy:NotNetMessage_end();
					end
				else
					proxy:NotNetMessage_begin();
						proxy:OnKeyTime2( ACID, func_ng, 1.0, 0, RapConditionCount, once );
						RapConditionCount = RapConditionCount+1;
					proxy:NotNetMessage_end();
				end
				--print("KurageLap return end");
				return;
			end
		end
	end
	--print("KurageLap end");
end

function GenPoint(proxy,param)	
	local target = param:GetParam2();
	local point = param:GetParam3();
	if proxy:IsAlive( target ) == true then
		proxy:Warp( target , point );						
		ValidCharactor( proxy, target );
		proxy:SetDisableGravity( target, false );	--�d��ON
		print("GenPoint target:",target,"  point:",point);
	end
end

--[[
--���N���Q�W�F�l���[�^�p�̃��[�v�|�C���g�擾����GetWarpPoint
	proxy					�c�C�x���g�v���L�V
	region_list				�c�̈��ID���o�^����Ă��郊�X�g
	rand					�c�����v�f(�����̒l��%�̈�̐��ŏo���ӏ��̏��������ʒu�����߂�)
]]
function GetWarpPoint(proxy, region_list, rand )
	local region_num = table.getn( region_list );
	local index = 0;
	for index = 0, region_num - 1, 1 do
		local rest = proxy:DivideRest( rand + index, region_num );
		return region_list[rest+1];
	end
	return -1;
end

--[[
--���N���Q�W�F�l���[�^�p�̃��[�v�|�C���g�擾����GetWarpPointCheck
	proxy					�c�C�x���g�v���L�V
	rand					�c�����v�f(�����̒l��%�̈�̐��ŏo���ӏ��̏��������ʒu�����߂�)
	list_index				�c�o�^����Ă���|�C���g����2�����z��C���f�b�N�X
]]
function GetWarpPointCheck( proxy, rand, list_index)
	local reg_listA = {2310, 2311, 2312};
	local reg_listB = {2313, 2314, 2315};
	local reg_listC = {2316, 2317};
	local reg_listD = {2318, 2319};
	local region_listlist = {reg_listA, reg_listB, reg_listC, reg_listD};
	
	local act_listA = { 790,  791,  792};
	local act_listB = { 793,  794,  795};
	local act_listC = { 796,  797};
	local act_listD = { 798,  799};
	local action_listlist = {act_listA, act_listB, act_listC, act_listD};

	--�v�f�����擾
	local region_num = table.getn( region_listlist[list_index] );
	local index = 0;
	--print("rand ", rand);
	--print("list_index ", list_index);
	--print("region_num ", region_num);
	for index = 0, region_num - 1, 1 do
		--�������]����擾
		local rest = proxy:DivideRest( rand + index, region_num );
		--print("index ",index);
		--print("rest ",rest);
		--print("region_num = ",region_num,", rest = ",rest,", rand = ",rand, ", last = ", region_listlist[list_index][rest+1]);
		
		--���ɒN�����Ȃ�
		if proxy:IsCompleteEvent(action_listlist[list_index][rest+1]) == false then
			--print("GetWarpPointCheck return WarpPoint to ",region_listlist[list_index][rest+1]);
			return region_listlist[list_index][rest+1];
		end
	end
	print("GetWarpPointCheck Failed");
	return -1;
end


--[[
--���W�F�l���[�^�̓o�^�܂Ƃߊ֐�����GenerateRegist
	proxy					�c�C�x���g�v���L�V
	ACID_start				�c�A�N�V����ID�̓�
	TCID_start				�c�^�[�Q�b�g�̃C�x���gID�̓�
	max_index				�c�ő�̐�-1(�����z�u�̑̐����܂߂��S���̐�-1)
	staticChrNum			�c�����z�u�̐�
	func					�c�ǉ����鎀�S�Ď��̃n���h����
]]
function GenerateRegist(proxy, ACID_start, TCID_start, max_index, staticChrNum, func)
	local count = 0;
	for index = 0, max_index, 1 do
		local ACID 		= ACID_start + index;
		local targetId 	= TCID_start + index;
		if proxy:IsCompleteEvent( ACID ) == false then
			count = count + 1;
			if count <= staticChrNum then
				proxy:OnCharacterDead( ACID, targetId, func, once );
			else
				proxy:SetDisableGravity( targetId, true );
				InvalidCharactor( proxy, targetId );
			end
		else
			proxy:SetDisableGravity( targetId, true );
			InvalidCharactor( proxy, targetId );
		end
	end
end

function GenerateRegistKURAGE(proxy, ACID_start, TCID_start, max_index, staticChrNum, func)
	local count = 0;
	for index = 0, max_index, 1 do
		local ACID 		= ACID_start + index;
		local targetId 	= TCID_start + index;
		if proxy:IsCompleteEvent( ACID ) == false then
			count = count + 1;
			if count <= staticChrNum then
				if proxy:IsClient() == false then					
					proxy:NotNetMessage_begin();
					proxy:RepeatMessage_begin();
						proxy:OnCharacterDead( ACID, targetId, func, once );
					proxy:RepeatMessage_end();
					proxy:NotNetMessage_end();
				end
			else
				proxy:SetDisableGravity( targetId, true );
				InvalidCharactor( proxy, targetId );
			end
		else
			proxy:SetDisableGravity( targetId, true );
			InvalidCharactor( proxy, targetId );
		end
	end
end

--[[
--��OnKeyTime�p�֐�����TimerCollisionOn
--��莞�Ԃœ������On�ɂ���B�ہAOnKeyTime��Param�ɓ�����𑀍삵�����L�����̃C�x���gID���w�肷��
]]
function TimerCollisionOn(proxy,param)
	print("TimerCollisionOn target = ", param:GetParam3() );
	proxy:DisableMapHit( param:GetParam3(), false );
	--proxy:SetColiEnable( param:GetParam3(), true );
end
--[[
--��OnKeyTime�p�֐�����TimerMutekiOff
--��莞�ԂŖ��G��Off�ɂ���B�ہAOnKeyTime��Param�ɓ�����𑀍삵�����L�����̃C�x���gID���w�肷��
]]
function TimerMutekiOff(proxy,param)
	print("TimerMutekiOff target = ", param:GetParam3() );
	proxy:SetDeadMode( param:GetParam3()-2000, false);--���GOFF
end

--------------------------------------------------------------------------------------
--��515���i���N�W�R���j�[��
--------------------------------------------------------------------------------------
--��515���i���N�W�R���j�[��
Namekuzi_HitCount = 0;
function Check_515(proxy,param)
	--�R�R�͖��t���[���Ď������̂�print������̂͂����߂��܂���B�e�X�g�̎������ɂ��Ă��������B
	if proxy:CheckChrHit_Obj(10000,1250) == true then
		if proxy:IsRegionIn( 10000, 2220 ) == true then
			--���������������u�ԂȂ̂ŁA�R�R�ɂ�print�����Ă������Ƃ������߂��܂�
			print("Check_515 true");
			return true
		end
	end
	return false;
end

function OnEvent_515(proxy,param)	
	if Namekuzi_HitCount > 5 then		
		--�R���j�[������A�j���Đ�
		proxy:ForcePlayAnimation( 1250, 2 );

		proxy:NotNetMessage_begin();
			proxy:OnCharacterAnimEnd( 524, 1250, 2, "NamekuziFallAnimEnd", once );
		proxy:NotNetMessage_end();
		
		--�R���j�[�̓�����OFF
		proxy:SetColiEnable( 1250, false );
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 517, "OnEvent_517", 1.7, 0, 2, once );
		proxy:NotNetMessage_end();
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 517, "OnEvent_517_3", 1.6, 0, 3, once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 515, true );
		proxy:SetEventFlag( 516, true );--�֋X�㗧�ĂĂ���
		proxy:DeleteEvent( 515 );
	else		
		Namekuzi_HitCount = Namekuzi_HitCount + 1;
		print("Namekuzi_HitCount = ", Namekuzi_HitCount );
		if proxy:IsEventAnim( 1250 , 0 ) == true then
			proxy:PlayAnimation( 1250, 1 );
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				proxy:OnCharacterAnimEnd( 515, 1250, 1, "NamekuziDamageAnimEnd", once );
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();
		end
	end	
end

function NamekuziDamageAnimEnd(proxy,param)
	if proxy:IsEventAnim( 1250 , 2 ) == false then
		print("NamekuziDamageAnimEnd begin");
		proxy:PlayAnimation( 1250, 0 );
		print("NamekuziDamageAnimEnd end");
	end
end

function NamekuziFallAnimEnd(proxy,param)
	print("NamekuziFallAnimEnd begin");
	for index = 1, 15, 1 do
		ValidCharactor( proxy, 700 + index - 1);
	end
	proxy:SetColiEnable( 1250, false );
	proxy:SetDrawEnable( 1250, false );
	print("NamekuziFallAnimEnd end");
end


--------------------------------------------------------------------------------------
--��517�����[�����C�g��
--------------------------------------------------------------------------------------
function OnEvent_517(proxy,param)

	--���[�����C�g�̓�����E�\��ON
	proxy:SetColiEnable( 1260, true );
	proxy:SetDrawEnable( 1260, true );
	proxy:TreasureDispModeChange2( 1260, true ,KEN_SFX);
	
	if proxy:IsCompleteEvent( 517 ) == false then
		--�z�X�g�A�����A�O���C�̂ݒ��ׂ邱�Ƃ��ł���
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		
		proxy:OnDistanceActionAttribute( 517 , 10000 , 1260 , "OnEvent_517_0" , ItemBoxDist_A , 10010140 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
		proxy:LuaCall( 517,1,"OnEvent_517_2",once);
		proxy:LuaCall( 517,2,"OnEvent_517_4",once);
		
	else
		proxy:SetDrawEnable( 1260 , false );--�ЂƂ܂��`�悾��OFF
		proxy:SetColiEnable( 1260 , false );
	end
	
end


--���[�����C�g�擾����
function OnEvent_517_0(proxy,param)
	if param:IsNetMessage() == false then
	print("OnEvent_517_0 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:PlayAnimation( 10000 , 8290);		
		proxy:PlayAnimation( 1260 , 1);	
		proxy:OnKeyTime2( 517 , "OnEvent_517_wait",0.01,0,100,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_517_0 end");
	end
end

function OnEvent_517_wait(proxy,param)
	print("OnEvent_517_wait begin");
	if proxy:IsEventAnim( 10000 , 8290 ) == true then
		proxy:LuaCallStart( 517 , 2 );
	else
		proxy:ForcePlayAnimation( 1260 , 0);	
	end
	print("OnEvent_517_wait end");
end

function OnEvent_517_1(proxy,param)
	print("OnEvent_517_1 begin");
	
	--�A�C�e���擾�֐�--�p�����[�^10430�Q��
	proxy:GetRateItem(10430);	
		
	--OBJ���������߂̃C�x���g�z�M
	proxy:LuaCallStart( 517, 1);

	print("OnEvent_517_1 end");
end

function OnEvent_517_2(proxy,param)
	print("OnEvent_517_2 begin");
	--�I�u�W�F��������
	proxy:SetDrawEnable( 1260 , false );--�ЂƂ܂��`�悾��OFF
	proxy:SetColiEnable( 1260 , false );--������͂���͕̂s��(����ł͂Ȃ��悤�Ȃ̂ŏ����Ȃ�)
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 517, true );
	proxy:DeleteEvent( 517 );
	
	print("OnEvent_517_2 end");
end

function OnEvent_517_3(proxy,param)
	print("OnEvent_517_3 begin");
	proxy:ValidSfx( 2222 );
	print("OnEvent_517_3 end");
end

--�A�j�������E�Ď�
function OnEvent_517_4(proxy,param)
	print("OnEvent_517_4 begin");	
	proxy:TreasureDispModeChange2( 1260, false ,KEN_SFX);
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8290 ) == true then--�V�����A�j�� 
		proxy:PlayAnimation( 1260 , 1);	
		print("OnEvent_517 end");
		return true;
	end

	--���Ƀ��[�v
	proxy:WarpDmy( 10000 , 1260 , 191 );	
	
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 517 , 10000 , 8290 , "OnEvent_517_1", once);
	proxy:NotNetMessage_end();
	print("OnEvent_517_4 end");
end



--------------------------------------------------------------------------------------
--��520���ŏ���
--------------------------------------------------------------------------------------
--��520���ŏ���
function PoizonFloorDam(proxy,param)
	--���_���[�W�p�|�C���g�̊e�C�x���gID
	--2210
	local floorTbl = {2210};
	local tblnum = table.getn( floorTbl );	
	local ACID = 520;
	
	--�Ƃ肠��������O�ɓ|���Ă���
	IsInPoizonArea = false;
	
	--�̈�̒��ł��Ń_���[�W���󂯂Ȃ��̈�
	local floorTbl_out = {2215, 2216};
	local tblnum_out = table.getn( floorTbl_out );
	
	for index = 1, tblnum, 1 do
		if proxy:IsRegionIn( 10000, floorTbl[index] ) == true then
			IsInPoizonArea = true;
		end
	end
	
	if IsInPoizonArea == true then
		for index = 1, tblnum_out, 1 do
			if proxy:IsRegionIn( 10000, floorTbl_out[index] ) == true then
				IsInPoizonArea = false;
			end
		end
	end
	
--~ 	--�����Ă���Ԃ͂���������(�őϐ��œł�������Ȃ��Ȃ���΍�)
--~ 	if	IsInPoizonArea == true then
--~ 	end
	
	--�������u��
	if proxy:IsCompleteEvent( ACID ) == false and
		IsInPoizonArea == true then
		print("PoizonFloorDam JustIn", tblnum);
		proxy:SetEventSpecialEffect(10000, 10080);
		
		proxy:SetEventFlag( ACID, IsInPoizonArea );
		
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 521, "OnEvent_521", 0.0, 0, 1, once );
		proxy:NotNetMessage_end();
	end
	
	--�����o���u��
	if  proxy:IsCompleteEvent( ACID ) == true and
		IsInPoizonArea == false then
		print("PoizonFloorDam JustOut", tblnum);
		proxy:EraseEventSpecialEffect(10000, 10080);
		
		proxy:SetEventFlag( ACID, IsInPoizonArea );
		proxy:DeleteEvent( 521 );
	end

	
	--��΂Ɍ��ʂ𐬗������Ȃ���
	return false;
end

function dummy(proxy,param)
end

function OnEvent_521(proxy,param)
	--print("OnEvent_521 begin");
	local set_param = proxy:DivideRest( param:GetParam3() + 1, 2 );
	local reload = Lua_GetReloadTime(proxy,PoizonCycle_low,PoizonCycle_High);
	
	--print("reload ",reload)
	
	--�p���I�ɓ����Ă��鎞�̂ݎ��̊Ď���ǉ��ł���
	if IsInPoizonArea == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 521, "OnEvent_521", reload, 0, set_param, once );
		proxy:NotNetMessage_end();
	else
		--�O�̈׏d����������
		proxy:EraseEventSpecialEffect(10000, 10080);
	end
	
	proxy:SetEventSpecialEffect( LOCAL_PLAYER, 10280);
	--print("OnEvent_521 end");
end

--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m05_01_00_00(proxy, param)
	print("PlayerDeath_m05_01_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m05_01_00_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerDeath_m05_01_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m05_01_00_00(proxy,param)
	print("PlayerRevive_m05_01_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m05_01_00_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerRevive_m05_01_00_00");
end

--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ��遡533
--------------------------------------------------------------------------------------

--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫

--��533�����{�X�����ւ̔����J����
function OnEvent_533(proxy,param)
	print("OnEvent_533 begin");

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_533 end");
		return;
	end	
	
	--�N���C�A���g�ցA�{�X�����j�~���s��ʒm
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 534 , 1 );--����A�j���̓����Đ�
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE , true );--���d�����h�~�p�t���OON
	--���d�N���V�X�e��ID���^�C���A�E�g��ݒ肵��ON�ɂ���
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_533 end");
end


--����A�j���̓����Đ�(ID����)
function OnEvent_534_1(proxy,param)
	print("OnEvent_534_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ����s���A���̏I������OnEvent_534_2�𔭍s����
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2890 );
		else
			proxy:LockSession();--���[�������b�N���܂��I
			--����A�j���Đ����s���A���̏I������OnEvent_534_2�𔭍s����
			proxy:OnTurnCharactorEnd( 534, 10000, 2890, "OnEvent_534_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_534_1 end");
end

--����A�j���̓����Đ��I����
function OnEvent_534_2(proxy,param)
	print("OnEvent_534_2 begin");
	
	--�����p�����A�j���Đ�
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 534, 10000, ANIMEID_WALK, "OnEvent_534_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();

	print("OnEvent_534_2 end");
end

--�����A�j���̓����Đ��I����
function OnEvent_534_3(proxy,param)
	print("OnEvent_534_3 begin");

	--�ŏ��̐l���{�X�����̒��ɓ���I����Ă�����A���ɔz�M����Ă���͂��Ȃ̂ŁA����������Ȃ��n���h��
	if proxy:IsCompleteEvent( 533 ) == false then
		proxy:LuaCallStart( 534 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCallStart( 4045 , 1 );	--�N���C�A���g�ցA�{�X�����ɓ����悤�ɂȂ������Ƃ�ʒm
		proxy:LuaCallStart( 534 , 6 );--�t���O�Z�b�g(�����p)
		Lua_MultiDoping(proxy,809);--�}���`�v���C�h�[�s���O
	end

	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );

	print("OnEvent_534_3 end");
end


--��533 2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
function OnEvent_533_GO_TO_IN(proxy, param)
	print("OnEvent_533_GO_TO_IN begin");
		
	proxy:NotNetMessage_begin();
		--��534�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���--�n���h���� OnEvent_533
		proxy:OnPlayerActionInRegion( 534, 2894, "OnEvent_533", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	
	print("OnEvent_533_GO_TO_IN end");
end


--��533 �t���O�Z�b�g(�����p)
function OnEvent_533_flag_set(proxy, param)
	print("OnEvent_533_flag_set begin");
		
	proxy:SetEventFlag( 533 , 1 );
	proxy:DeleteEvent( 533 );

	print("OnEvent_533_flag_set end");
end


--------------------------------------------------------------------------------------
--��537���{�X�퓬�J�n��
--------------------------------------------------------------------------------------
--��537���{�X�퓬�J�n��
function OnEvent_537(proxy,param)
	print("OnEvent_537 begin");
	proxy:PlayPointSE( 2250, SOUND_TYPE_M, 50100000, 1 );
	proxy:ResetThink( 809 );
	proxy:EnableLogic( 809, true );

	--1�x�{�X��|�����˂čĐ킷�鎞�A�t���O���������܂܂��Ə������ł��܂���B
	--proxy:SetEventFlag(537, true);
	
	--�{�X�Q�[�W�\��
	proxy:SetBossGauge(809, 0, 5080);
	proxy:SetEventFlag( 537 , true );
	
	print("OnEvent_537 end");
end


--------------------------------------------------------------------------------------
--��5770���{�X���S��
--------------------------------------------------------------------------------------
--��5770���{�X���S��
function OnEvent_5770(proxy,param)
	print("OnEvent_5770 begin");
	
	proxy:NotNetMessage_begin();
		--1�b��ɃA�C�e���擾�C�x���g�𔭍s--
		proxy:OnKeyTime2(5770,"OnEvent_5770_1", 1.0,0,0,once);
		--2�b��ɕ����ǔ����C�x���g�𔭍s--
		proxy:OnKeyTime2(5772,"OnEvent_5772", 2.0,0,0,once);
		--�}���`���U�Ď�
		proxy:OnRegistFunc( 5770,"Check_5770_PT","OnEvent_5770_PT",0,once);
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( 5770, true );--�t���O�𗧂Ă�B

	--�u���b�N�N���A������
	proxy:CustomLuaCallStart( 4050, 809 );
	--�g�J�Q���Z�b�g
	ResetTokage(proxy);
	
	print("OnEvent_5770 end");
end

--��5770_1��1�b�っ
function OnEvent_5770_1(proxy, param)
	print("OnEvent_5770_1 begin");
	
	--�{�X��|���������X�V(���ɂ���ăt���O�𗧂Ă�)
	GetBossFlagCount( proxy, param );
	
	--���g���t�B�[�擾���聥
	Lua_RequestUnlockTrophy(proxy, 35);--�g���t�B�̏󋵂𔻒肵�A�擾
		
	--�z�X�g�v���C���[�̂݃A�C�e������C�x���g�Ɏg�p
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	
	--�󎀑�(�\�E��?)�L����
	proxy:SetDrawEnable( 1981 , true );
	proxy:SetColiEnable( 1981 , true );
	--�\�E���Ɏh���������L����
	proxy:SetDrawEnable( 1976 , true );
	proxy:SetColiEnable( 1976 , true );
	
	--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
	if proxy:IsCompleteEvent( 5773 ) == false then
		--SFX�̗L����
		proxy:ValidSfx( 2360 );--�v�΂̃I�[��
		proxy:ValidSfx( 2361 );--���̗��q
		--�\�E���Ǝh�����Ă��錕���P������
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--���点��
		--proxy:TreasureDispModeChange2( 1976 , true ,KANAME_SFX);--���点��
		proxy:OnDistanceActionAttribute( 5773 , 10000 , 1981 , "OnEvent_5773" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end
	
	print("OnEvent_5770_1 end");
end

--��5770_2��2�b�っ
function OnEvent_5772(proxy, param)
	print("OnEvent_5772 begin");
	
	--�{�X��p��BGM��~
	--proxy:StopPointSE( 0 );
	proxy:StopPointSE( 1 );	

	print("OnEvent_5772 end");
end

--�}���`���U�Ď�
function Check_5770_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--�}���`����Ȃ�
function OnEvent_5770_PT(proxy,param)
	print("OnEvent_5770_PT begin");
	--���{�X�����̑O��̖��@�ǂ�������(�S�v���C���[)
	proxy:SetColiEnable( 1998 , false );
	proxy:SetColiEnable( 1994 , false );
	
	proxy:SetDrawEnable( 1998 , false );
	proxy:SetDrawEnable( 1994 , false );	

	--���̕�Sfx������
	proxy:InvalidSfx( 1986, true );
	proxy:InvalidSfx( 1990, true );	
	
	--���{�X�����O�̈ړ������C�x���g���폜
	proxy:DeleteEvent( 533 );--��l�ڂ�����Ƃ��p
	proxy:DeleteEvent( 534 );--��l�ڈȍ~������Ƃ��p
	print("OnEvent_5770_PT end");
end

--------------------------------------------------------------------------------------
--��5773���\�E�����聡
--------------------------------------------------------------------------------------
function OnEvent_5773(proxy, param)
	print("OnEvent_5773 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--�V�����A�j�� 
		print("OnEvent_5773 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 5773, "OnEvent_5773_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_5773 end");
end


--��5773_1���A�C�e���擾��
function OnEvent_5773_1(proxy, param)
	print("OnEvent_5773_1 begin");

	--�A�C�e���擾�֐�
	proxy:GetRateItem(10451);--�p�����[�^10451�Q��
	proxy:GetRateItem(10474);--�p�����[�^10474�Q��
	proxy:GetRateItem(10475);--�p�����[�^10475�Q��
	proxy:GetRateItem(10476);--�p�����[�^10476�Q��
	proxy:GetRateItem(10477);--�p�����[�^10477�Q��
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 5773, 1 );
	
	--��V�F�[�_�[OFF
	--proxy:TreasureDispModeChange( 1981 , false );

	--SFX��������
	proxy:InvalidSfx( 2360 , true );--�v�΂̃I�[��
	--proxy:InvalidSfx( 2361 , true );--���̗��q
	
	--���v�΂Ń��[�v�p�̊Ď���ǉ���
	proxy:OnDistanceActionAttribute( 5774 , 10000 , 1981 , "OnEvent_5774" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_5773_1 end");
end

--------------------------------------------------------------------------------------
--��535�����̕ǁ�
--------------------------------------------------------------------------------------
--��535�����̕ǁ�
function OnEvent_535(proxy,param)
	print("OnEvent_535 begin");
	
	if proxy:IsCompleteEvent(535) == true then
		return;
	end
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 535 , true );
		return;
	end
	--�_�~�|���փ��[�v
	proxy:WarpDmy( 10000, 1300, 191 );
	
	proxy:NotNetMessage_begin();
		--��535_1�������A�j���I����
		--proxy:OnChrAnimEnd( 535, 10000, ANIMEID_WALK, "OnEvent_535_1" , once );
		proxy:LuaCallStart( 535, 2 );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 535 , true );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_535 end");
end

function OnEvent_535_1(proxy,param)
	print("OnEvent_535_1 begin");
	
	proxy:LuaCallStart( 535, 2 );
	
	print("OnEvent_535_1 end");
end

function OnEvent_535_delete(proxy,param)
	print("OnEvent_535_delete begin");
	
	proxy:DeleteEvent( 535 );
	proxy:SetDrawEnable( 1300, false );--�`��OFF
	proxy:SetColiEnable( 1300, false );--������OFF
	proxy:InvalidSfx( 2200, true );
	proxy:SetObjDeactivate( 1300 , true );--�f�A�N�e�B�u
	
	print("OnEvent_535_delete end");
end



--------------------------------------------------------------------------------------
--��536�����̕ǁ�
--------------------------------------------------------------------------------------
--��536�����̕ǁ�
function OnEvent_536(proxy,param)
	print("OnEvent_536 begin");
	
	if proxy:IsCompleteEvent(536) == true then
		return;
	end
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 536 , true );
		return;
	end
	--�_�~�|���փ��[�v
	proxy:WarpDmy( 10000, 1301, 191 );
	
	proxy:NotNetMessage_begin();
		--��536_1�������A�j���I����
		--proxy:OnChrAnimEnd( 536, 10000, ANIMEID_WALK, "OnEvent_536_1" , once );
		proxy:LuaCallStart( 536, 2 );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 536 , true );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_536 end");
end

function OnEvent_536_1(proxy,param)
	print("OnEvent_536_1 begin");
	
	proxy:LuaCallStart( 536, 2 );
	
	print("OnEvent_536_1 end");
end

function OnEvent_536_delete(proxy,param)
	print("OnEvent_536_delete begin");
	
	proxy:DeleteEvent( 536 );
	proxy:SetDrawEnable( 1301, false );--�`��OFF
	proxy:SetColiEnable( 1301, false );--������OFF
	proxy:SetObjDeactivate( 1301 , true );--�f�A�N�e�B�u
	proxy:InvalidSfx( 2201, true );
	
	print("OnEvent_536_delete end");
end

--------------------------------------------------------------------------------------
--��538���{�X�J�����؂�ւ��C�x���g��
--------------------------------------------------------------------------------------
function OnEvent_538(proxy,param)
	--print("OnEvent_538 begin");
	--�{�X������ł��Ȃ��@���@�{�X�Ƃ̐퓬���J�n���Ă���
	if proxy:IsCompleteEvent( 5770 ) == false and proxy:IsCompleteEvent( 537 ) == true then
		--�{�X��@�񃍃b�N�J����
		proxy:SetCamModeParamTargetId(5021);
		--�{�X��@���b�N�J����
		proxy:SetCamModeParamTargetIdForBossLock(5020);
	end
	--print("OnEvent_538 end");
end

--------------------------------------------------------------------------------------
--���Z�����֘A��
--------------------------------------------------------------------------------------
-----------------------------------------------------------------------------
--801���S�[���h�����̖�͏��n
-----------------------------------------------------------------------------
function OnEvent_801(proxy,param)
	print("OnEvent_801 begin");
	
	if	proxy:RemoveInventoryEquip( TYPE_GOODS, 37 ) == true then
		print("OnEvent_801 �A�C�e���폜����");
	end
	SetNpcStateFlag( proxy, param, selen_flag_list, SELEN_STATE_THANKS );
	
	proxy:SetEventFlag( 801, true );
	proxy:NotNetMessage_begin();
	proxy:OnRegionJustOut( 802, LOCAL_PLAYER, 2240, "OnEvent_802", once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_801 end");
end

function OnEvent_802(proxy,param)
	print("OnEvent_802 begin");
	
	proxy:SetEventFlag( 802, true );
	SetNpcStateFlag( proxy, param, selen_flag_list, SELEN_STATE_PURIFY );
	InvalidCharactor( proxy, 652 );
	
	print("OnEvent_802 end");
end

-----------------------------------------------------------------------------
--803���Z�����G��
-----------------------------------------------------------------------------
function OnEvent_803(proxy,param)
	print("OnEvent_803 begin");
	proxy:SetEventFlag( 803, true );
	
	proxy:EnableLogic( 652, true );
	proxy:SetTeamType( 652, TEAM_TYPE_AngryFriend );
	SetNpcStateFlag( proxy, param, selen_flag_list, SELEN_STATE_ANGRY );

	print("OnEvent_803 end");
end

-----------------------------------------------------------------------------
--804���Z�������S
-----------------------------------------------------------------------------
function OnEvent_804(proxy,param)
	print("OnEvent_804 begin");
	
	proxy:SetEventFlag( 804, true );
	SetNpcStateFlag( proxy, param, selen_flag_list, SELEN_STATE_DEAD );
	
	print("OnEvent_804 end");
end

--�Z�����̎��̂𒲂ׂ�
function OnEvent_15633(proxy,param)
	print("OnEvent_15633 begin");
	proxy:SetEventFlag( 15633 , true );
	print("OnEvent_15633 end");
end

-----------------------------------------------------------------------------
--808���M���������̕�V�i�w�ցj
-----------------------------------------------------------------------------
function OnEvent_808(proxy,param)
	print("OnEvent_808 begin");
	--�A�C�e������肷��
	proxy:GetRateItem(10750);--�w��
	
	proxy:SetEventFlag( 808,true);
	
	print("OnEvent_808 end");
end

-----------------------------------------------------------------------------
--809���M���Ⴂ���̕�V�i�Ì����j
-----------------------------------------------------------------------------
function OnEvent_809(proxy,param)
	print("OnEvent_809 begin");
	--�A�C�e������肷��
	proxy:GetRateItem(10751);--�Ì���

	proxy:SetEventFlag( 809,true);
	
	print("OnEvent_809 end");
end

-----------------------------------------------------------------------------
--�Z�����E�u���b�N�S�[�X�g�����S�������ǂ����̃t���O�Z�b�g
-----------------------------------------------------------------------------
function OnEvent_820(proxy, param)
	print("OnEvent_820 begin");
	--���S�����t���O�𗧂Ă�
	proxy:SetEventFlag( 820, true );
		
	print("OnEvent_820 end");
end

-----------------------------------------------------------------------------
--��15600���Z�����E�u���b�N�S�[�X�g�̎��̂𒲂ׂ����H
-----------------------------------------------------------------------------
function OnEvent_15600(proxy,param)
	print("OnEvent_15600 begin");
	proxy:SetEventFlag( 15600 , true );
	print("OnEvent_15600 end");
end

--------------------------------------------------------------------------------------
--��H(��)�Ɉ��_���[�W��810
--------------------------------------------------------------------------------------
function OnEvent_810(proxy,param)
	print("OnEvent_810 begin");

	--���W�b�NOn
	proxy:EnableLogic( 677, true );
	
	--��H(��)�̏�Ԃ�G��(�s��3)�ɂ���
	SetNpcStateFlag(proxy, param, Kojiki_Shop_Flag_list, KOJIKI_FEMALE_SHOP_HOSTILE02);
	--��H(��)�̃`�[���^�C�v��ύX����
	proxy:SetTeamType( 677, TEAM_TYPE_AngryFriend );

	--�t���O�𗧂Ă�
	proxy:SetEventFlag( 810, true );
	
	print("OnEvent_810 end");
end


--------------------------------------------------------------------------------------
--��H(��)���S��811
--------------------------------------------------------------------------------------
function OnEvent_811(proxy,param)
	print("OnEvent_811 begin");

	--��H(��)�̏�Ԃ��u���S�v�ɕς���
	SetNpcStateFlag( proxy, param, Kojiki_Shop_Flag_list, KOJIKI_FEMALE_SHOP_DEAD );
	
	--�G�ɍ���ēG�΂�ʂ�z���Ď��S�����肦��̂ŁA�����ł��폜
	--���񂾂�G�΂ɂ͂Ȃ�Ȃ��̂ō폜
	proxy:DeleteEvent( 270 );
	proxy:DeleteEvent( 810 );

	--�t���O�𗧂Ă�
	proxy:SetEventFlag( 811, true );
	
	print("OnEvent_811 end");
end


------------------------------
--�z�΂̐��쎀�S�Ď�--
------------------------------
function OnEvent_828(proxy, param)
	print("OnEvent_828 begin");
	--���S�����t���O�𗧂Ă�
	proxy:SetEventFlag( 828, true );
		
	print("OnEvent_828 end");
end


--------------------------------------------------------------------------------------
--��8020���z�΂̐��삩��A�C�e���擾��
--------------------------------------------------------------------------------------
function OnEvent_8020(proxy,param)
	print("OnEvent_8020 begin");
	proxy:SetEventFlag( 8020 , true );
	print("OnEvent_8020 end");
end


--------------------------------------------------------------------------------------
--��842��������u���b�N���S�Ď���
--------------------------------------------------------------------------------------
function OnEvent_842(proxy,param)
	print("OnEvent_842 begin");
	proxy:SetEventFlag( 842 , true );
	print("OnEvent_842 end");
end


--------------------------------------------------------------------------------------
--��840���SFX�\���̈�ɓ�������
--------------------------------------------------------------------------------------
function OnEvent_840(proxy,param)
	print("OnEvent_840 begin");
	proxy:CreateCamSfx(95202,0);
	print("OnEvent_840 end");
end


--------------------------------------------------------------------------------------
--��841���SFX�\���̈悩��o����
--------------------------------------------------------------------------------------
function OnEvent_841(proxy,param)
	print("OnEvent_841 begin");
	proxy:DeleteCamSfx( 0 );
	print("OnEvent_841 end");
end


--------------------------------------------------------------------------------------
--��770���i���N�W���S������
--------------------------------------------------------------------------------------
function OnEvent_770(proxy,param)
	print("OnEvent_770 begin");	
	proxy:SetEventFlag( 770 , true );
	print("OnEvent_770 end");
end

--------------------------------------------------------------------------------------
--��15626���i���N�W���̒��ׂ���
--------------------------------------------------------------------------------------
function OnEvent_15626(proxy,param)
	print("OnEvent_15626 begin");
	proxy:SetEventFlag( 15626 , true );
	print("OnEvent_15626 end");
end

--------------------------------------------------------------------------------------
--��775����p�t���S������
--------------------------------------------------------------------------------------
function OnEvent_775(proxy,param)
	print("OnEvent_775 begin");	
	proxy:SetEventFlag( 775 , true );
	print("OnEvent_775 end");
end

--------------------------------------------------------------------------------------
--��15623����p�t���̒��ׂ���
--------------------------------------------------------------------------------------
function OnEvent_15623(proxy,param)
	print("OnEvent_15623 begin");
	proxy:SetEventFlag( 15623 , true );
	print("OnEvent_15623 end");
end
