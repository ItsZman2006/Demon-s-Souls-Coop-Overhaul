
--��H(��)�̏�ԕω��t���O
KOJIKI_FEMALE_SHOP_SELL01  	 = 16230;--�̔���(�s��1)
KOJIKI_FEMALE_SHOP_HOSTILE01 = 16231;--�G��(�s��1)
KOJIKI_FEMALE_SHOP_DEAD	   	 = 16232;--���S
KOJIKI_FEMALE_SHOP_SELL02  	 = 16233;--�̔���(�s��2)
KOJIKI_FEMALE_SHOP_HOSTILE02 = 16234;--�G��(�s��2)

--��H(��)�̏�ԕω��t���O���X�g
Kojiki_Shop_Flag_list = {
	KOJIKI_FEMALE_SHOP_SELL01,
	KOJIKI_FEMALE_SHOP_HOSTILE01,
	KOJIKI_FEMALE_SHOP_DEAD,
	KOJIKI_FEMALE_SHOP_SELL02,
	KOJIKI_FEMALE_SHOP_HOSTILE02,
}

--�G�΂��邽�߂̃_���[�W��
KojikiShop_TotalDamage = 50;

--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉����������
--------------------------------------------------------------------------------------
function Initialize_m05_00_00_00(proxy)
	print("Initialize_m05_00_00_00 begin");
	
	proxy:LuaCall( 99999 , 0 , "OnEvent_4000_Hp_1",everytime);
-----------------------------------------------------------------------------------------
--�{�X�֘A
-----------------------------------------------------------------------------------------
--��160���{�X�����ɓ��遡
	
	--���{�X�������Ă���Ƃ������C�x���g�o�^
	if proxy:IsCompleteEvent( 5650 ) == false then
	
		--�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B
		SingleReset(proxy, 160);
	
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���)
		proxy:LuaCall( 161, 1, "OnEvent_161_1", everytime );
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCall( 161 , 5 , "OnEvent_160_GO_TO_IN" , everytime );
		--���t���O�Z�b�g(�����p)
		proxy:LuaCall( 161 , 6 , "OnEvent_160_flag_set" , everytime );
		
		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ�
		if proxy:IsCompleteEvent( 160 ) == false then
		
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l����
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--��160�����ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegionAttribute( 160, 2895, "OnEvent_160", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B
			proxy:NotNetMessage_begin();
				--��161�����ɓ��邽�߂̃C�x���g��ǉ���--�n���h���͏�Ɠ���
				proxy:OnPlayerActionInRegion( 161, 2895, "OnEvent_160", HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		end
	end


--��162�����{�X�|�������o��	
	--�{�X�����Ă���
	if proxy:IsCompleteEvent( 5650 ) == false then
		if proxy:IsCompleteEvent( 162 ) ==false then
			proxy:OnRegionJustIn( 162, LOCAL_PLAYER, 2899, "OnEvent_162", once );
			proxy:NotNetMessage_begin();
				--�|�����J�n�ɌĂ΂��n���h��
				proxy:LuaCall(162, REMO_START, "OnEvent_162_RemoStart", once);
				--�|�����I����ɌĂ΂��n���h��(�g���K�[�N�������l�p)
				proxy:LuaCall(162, REMO_FINISH, "OnEvent_162_RemoFinish", once);
			proxy:NotNetMessage_end();
		end
	end


--��163���{�X�퓬�J�n��
	if proxy:IsCompleteEvent( 5650 ) == false then
		--���[�J���v���C���̓{�X������ł��Ȃ����薈��o�^
		if	proxy:IsClient() == false then
			proxy:SetEventFlag( 163, false );
		end
		if proxy:IsCompleteEvent( 163 ) == false then
			proxy:OnRegionJustIn( 163 , LOCAL_PLAYER , 2887 , "OnEvent_163" , once );
		else
			proxy:PlayPointSE( 2120, SOUND_TYPE_M, 50000000, 0 );--�̈��ID�̂ݖ���
		end	
	end

--��5650���{�X�����񂾂灡
	proxy:AddFieldInsFilter( 808 );
	if proxy:IsCompleteEvent( 5650 ) ==false then
		proxy:OnCharacterDead(5650,808,"OnEvent_5650",once);
	else
		proxy:InvalidSfx( 1987, false );
		proxy:InvalidSfx( 1991, false );
	end

	--���{�X�֘A�̏���������
	if proxy:IsCompleteEvent( 5650 ) ==true then
		
		--���{�X����ł���Ƃ�
		--�{�X���Ȃ��Ȃ�
		InvalidBackRead( proxy , 808 );
		
		--���@�Ǐ�����
		proxy:SetColiEnable( 1999 , false );
		proxy:SetColiEnable( 1995 , false );
	
		proxy:SetDrawEnable( 1999 , false );
		proxy:SetDrawEnable( 1995 , false );	

		--�{�X��Sfx
		proxy:InvalidSfx( 1987, false );
		proxy:InvalidSfx( 1991, false );
		
		--�����ǂ̔j��Č�(���̃u���b�N�ւ̓����Ђ炭)
		proxy:ReconstructBreak( 2060 , 1 );
		
		--�z�X�g�v���C���[�̂݃A�C�e������C�x���g�Ɏg�p
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--�󎀑�(�\�E��?)�L����
		proxy:SetDrawEnable( 1982, true );
		proxy:SetColiEnable( 1982, true );
		proxy:TreasureDispModeChange2( 1982, true ,KANAME_SFX);--���点��
		--�\�E���ɂ���������
		proxy:SetDrawEnable( 1975, true );
		proxy:SetColiEnable( 1975, true );
		--proxy:TreasureDispModeChange2( 1975, true ,KANAME_SFX);--���点��
		
		--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
		if proxy:IsCompleteEvent( 5653 ) == false then
			--SFX�L����
			proxy:ValidSfx( 2150 );--�v�΂̃I�[��
			proxy:ValidSfx( 2151 );--���̗��q
			
			proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);--���点��
			proxy:OnDistanceActionAttribute( 5653 , LOCAL_PLAYER , 1982 , "OnEvent_5653" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--SFX������
			proxy:InvalidSfx( 2150, false );--�v�΂̃I�[��
			--proxy:InvalidSfx( 2151, false );--���̗��q
			
			--���v�΂Ń��[�v�p�̊Ď���ǉ���
			SingleReset(proxy,5654);
			proxy:OnDistanceActionAttribute( 5654 , LOCAL_PLAYER , 1982 , "OnEvent_5654" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
		
	else
		--���{�X�����Ă���Ƃ�
		
		--�{�X�|������������
		if proxy:IsCompleteEvent(162) == false then
			--InvalidCharactor( proxy , 808 );
			--ValidCharactor( proxy , 808 );
			proxy:SetDrawEnable( 808, false );
			proxy:EnableLogic( 808, false );
		end
		
		--PT�g��łȂ����͏��������܂�
		if proxy:IsClient() == false  then
			
			SingleReset(proxy,6274);
			SingleReset(proxy,6275);
		end
		
		proxy:EnableLogic( 808 , false );--���W�b�NOFF�őҋ@
		
		--�������ʂ͕K���t�^
		proxy:SetEventSpecialEffect( 811,5000);	
		--2�i�K�ڕt�^
		if proxy:IsCompleteEvent(6274) == true then
			proxy:SetEventSpecialEffect( 811, 5001);
		end
		--3�i�K�ڕt�^
		if proxy:IsCompleteEvent(6274) == true then
			proxy:SetEventSpecialEffect( 811, 5002);
		end
		
		--��(�\�E��)������
		proxy:SetDrawEnable( 1982 , false );
		proxy:SetColiEnable( 1982 , false );
		--�\�E���Ɏh��������������
		proxy:SetDrawEnable( 1975 , false );
		proxy:SetColiEnable( 1975 , false );
		
		--SFX������
		proxy:InvalidSfx( 2150 , false );--�v�΂̃I�[��
		proxy:InvalidSfx( 2151 , false );--���̗��q
		
		--���@��ON
		proxy:SetColiEnable( 1999 , true );
		proxy:SetColiEnable( 1995 , true );
		
		proxy:SetDrawEnable( 1999 , true );
		proxy:SetDrawEnable( 1995 , true );
		
		--���̕�Sfx��L����
		proxy:ValidSfx( 1987 );
		proxy:ValidSfx( 1991 );
	end	

-----------------------------------------------------------------------------------------
--�M�~�b�N�֘A
-----------------------------------------------------------------------------------------
--��0���n�V�SA�~�聡PC���C�x���g�G���A(2000)�̒��ɋ��āA�A�N�V�����{�^�����������Ƃ�--
	proxy:OnActionEventRegion(0, 2000, "OnEvent_0", LadderAngle_A, HELPID_DOWN, everytime);
--��1���n�V�SA���聡PC���C�x���g�G���A(2001)�̒��ɋ��āA�A�N�V�����{�^�����������Ƃ�--
	proxy:OnActionEventRegion(1, 2001, "OnEvent_1", LadderAngle_A, HELPID_UP,   everytime);

--��10���n�V�SB�~�聡PC���C�x���g�G���A(2004)�̒��ɋ��āA�A�N�V�����{�^�����������Ƃ�--
	proxy:OnActionEventRegion(10, 2004, "OnEvent_10", LadderAngle_A, HELPID_DOWN, everytime);
--��11���n�V�SB���聡PC���C�x���g�G���A(2005)�̒��ɋ��āA�A�N�V�����{�^�����������Ƃ�--
	proxy:OnActionEventRegion(11, 2005, "OnEvent_11", LadderAngle_A, HELPID_UP,   everytime);

--��20���n�V�SC�~�聡PC���C�x���g�G���A(2030)�̒��ɋ��āA�A�N�V�����{�^�����������Ƃ�--
	proxy:OnActionEventRegion(20, 2030, "OnEvent_20", LadderAngle_A, HELPID_DOWN, everytime);
--��21���n�V�SC���聡PC���C�x���g�G���A(2031)�̒��ɋ��āA�A�N�V�����{�^�����������Ƃ�--
	proxy:OnActionEventRegion(21, 2031, "OnEvent_21", LadderAngle_A, HELPID_UP,   everytime);

--��23���C�X�^������
	if proxy:IsCompleteEvent( 23 ) == false then
		--�z�X�g�A�����A�O���C�̂ݒ��ׂ邱�Ƃ��ł���
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		
		proxy:OnDistanceActionAttribute( 23 , LOCAL_PLAYER , 1002 , "OnEvent_23" , ItemBoxDist_A , 10010145 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
		proxy:LuaCall( 23,1,"OnEvent_23_2",once);
		proxy:LuaCall( 23,2,"OnEvent_23_3",once);
		proxy:TreasureDispModeChange2( 1002, true ,KEN_SFX);
	else
		proxy:SetDrawEnable( 1002 , false );--�ЂƂ܂��`�悾��OFF
		proxy:SetColiEnable( 1002 , false );
	end	
	--proxy:SetRarity( 1002, 10419 );
	
	

--��30�����ˋ�A��PC��OBJ(1000)�ɑ΂��Ĕ����p�x(30)�A�p�x�I�t�Z�b�g(180)�A����(150)�ŃA�N�V�����{�^��������--
	if proxy:IsCompleteEvent( 30 ) ==false then
		proxy:OnDistanceActionPlus( 30, LOCAL_PLAYER, 1000, "OnEvent_30", DrawBridgeDist_A, HELPID_START, 180, DrawBridgeAngle_A, -1.5, -1.0, 1.4, once);
	else
		proxy:EndAnimation( 1000, 1 );
	end
	
--��40�����ˋ�B��PC��OBJ(1001)�ɑ΂��Ĕ����p�x(30)�A�p�x�I�t�Z�b�g(180)�A����(150)�ŃA�N�V�����{�^��������--
	if proxy:IsCompleteEvent( 40 ) ==false then
		proxy:OnDistanceActionPlus( 40, LOCAL_PLAYER, 1001, "OnEvent_40", DrawBridgeDist_A, HELPID_START, 180, DrawBridgeAngle_A, 0.3, -2.5, 1.9, once);
	else
		proxy:EndAnimation( 1001, 1 );
	end
	
--��50��������A��PC���C�x���g�G���A(1020)�ɓ�������--
	if proxy:IsCompleteEvent( 50 ) ==false then
		proxy:OnRegionJustIn(50,LOCAL_PLAYER,1020, "OnEvent_50",once);
	else
		proxy:ReconstructBreak( 1020 , 1 );
	end
	
--��60��������B��PC���C�x���g�G���A(1021)�ɓ�������--
	if proxy:IsCompleteEvent( 60 ) ==false then
		proxy:OnRegionJustIn(60,LOCAL_PLAYER,1021, "OnEvent_60",once);
	else
		proxy:ReconstructBreak( 1021 , 1 );
	end



	
--��70���h���苴A��PC���C�x���g�G���A(2050)�ɓ�������
	proxy:OnRegionIn(70,LOCAL_PLAYER,2050,"OnEvent_70",everytime);	
	
--��80���h���苴B��PC���C�x���g�G���A(2051)�ɓ�������
	proxy:OnRegionIn(80,LOCAL_PLAYER,2051,"OnEvent_80",everytime);	

--��90���h���苴C��PC���C�x���g�G���A(2052)�ɓ�������
	proxy:OnRegionIn(90,LOCAL_PLAYER,2052,"OnEvent_90",everytime);	

--��100���h���苴D��PC���C�x���g�G���A(2053)�ɓ�������
	proxy:OnRegionIn(100,LOCAL_PLAYER,2053,"OnEvent_100",everytime);


--��130-131���ӂ�ӂ푫�ꁡ
	proxy:RepeatMessage_begin();
		proxy:OnRegionIn( 130,LOCAL_PLAYER,2040,"OnEvent_130_1", once );
	proxy:RepeatMessage_end();
--��131���ӂ�ӂ푫��(�̈���ړ�)��PC���C�x���g�G���A(2041)�ɓ�������
	proxy:OnRegionIn(131,LOCAL_PLAYER,2041,"OnEvent_131",everytime);
--��132���ӂ�ӂ푫��(�̈���ړ�)��PC���C�x���g�G���A(2042)�ɓ�������
	proxy:OnRegionIn(132,LOCAL_PLAYER,2042,"OnEvent_132",everytime);
--��133���ӂ�ӂ푫��(�̈���ړ�)��PC���C�x���g�G���A(2043)�ɓ�������
	proxy:OnRegionIn(133,LOCAL_PLAYER,2043,"OnEvent_133",everytime);

	

--��110���J���X����ї���
	if proxy:IsCompleteEvent( 110 ) == false then
		proxy:OnRegistFunc(110,"Check_110","OnEvent_110",1,once);
	end
	--OnRegistFunc�̏ꍇ�ŏ��̃n���h���Ɏ��R�ɏ������`���Ă�����true��Ԃ������Ɍ��ʂ̃n���h�����Ă΂�܂��BeginAction
	--�n���h���̂��Ƃ�1�͎��ʎq�ł��B������ω����鎖�œ��C�x���gID�ł��قȂ�Ď��Ƃ��ēo�^�ł��܂��B

--��280���Β��Ƀ��[�v��
	SingleReset(proxy,280);
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	proxy:OnDistanceAction( 280, LOCAL_PLAYER, 1983, "OnEvent_280", WarpGimmickDist_A, HELPID_GO_TO_SEKITYUU, 0, 180, everytime );
	
--��281���ŏ��̗v�΂̌��������遡
	proxy:OnSessionJustIn( 281 , "OnEvent_281" , everytime );
	
--��282���ŏ��̗v�΂̌����������遡
	proxy:OnSessionJustOut( 282 , "OnEvent_282" , everytime );
	
	
--��140�����񂾂ӂ蕅�s�l��
	if proxy:IsCompleteEvent( 140 ) == false then
		--proxy:OnPlayerDistanceInTarget( 140, LOCAL_PLAYER, 13056, "OnEvent_140", 1.5, once );
		proxy:OnRegionJustIn( 140, LOCAL_PLAYER, 2109, "OnEvent_140", once );
	end
		
--��141�����񂾂ӂ蕅�s�l��
	if proxy:IsCompleteEvent( 141 ) == false then
		--proxy:OnPlayerDistanceInTarget( 141, LOCAL_PLAYER, 13057, "OnEvent_141", 1.5, once );--��
		proxy:OnRegionJustIn( 141, LOCAL_PLAYER, 2110, "OnEvent_141", once );--�苴	 
		proxy:OnRegionJustIn( 141, LOCAL_PLAYER, 2100, "OnEvent_141", once );--�苴	 
	end
	
--��142�����񂾂ӂ蕅�s�l��
	if proxy:IsCompleteEvent( 142 ) == false then
		--proxy:OnPlayerDistanceInTarget( 142, LOCAL_PLAYER, 13058, "OnEvent_142", 1.5, once );--��
		proxy:OnRegionJustIn( 142, LOCAL_PLAYER, 2111, "OnEvent_142", once );--�苴	 
	end
	
--��143�����񂾂ӂ蕅�s�l��
	if proxy:IsCompleteEvent( 143 ) == false then
		--proxy:OnPlayerDistanceInTarget( 143, LOCAL_PLAYER, 13059, "OnEvent_143", 1.5, once );--��
		proxy:OnRegionJustIn( 143, LOCAL_PLAYER, 2112, "OnEvent_143", once );--�苴	 
		proxy:OnRegionJustIn( 143, LOCAL_PLAYER, 2104, "OnEvent_143", once );--���ˋ�
	end
	
--��144�����񂾂ӂ蕅�s�l��
	if proxy:IsCompleteEvent( 144 ) == false then
		proxy:OnRegionJustIn( 144, LOCAL_PLAYER, 2101, "OnEvent_144", once );--�苴
	end
	
--��145�����񂾂ӂ蕅�s�l��
	if proxy:IsCompleteEvent( 145 ) == false then
		proxy:OnRegionJustIn( 145, LOCAL_PLAYER, 2102, "OnEvent_145", once );--�苴
		proxy:OnRegionJustIn( 145, LOCAL_PLAYER, 2103, "OnEvent_145", once );--�苴
	end
	
--��146�����񂾂ӂ蕅�s�l��
	if proxy:IsCompleteEvent( 146 ) == false then
		proxy:OnRegionJustIn( 146, LOCAL_PLAYER, 2040, "OnEvent_146", once );--�ӂ�ӂ푫��
	end
	
--��147�����񂾂ӂ蕅�s�l��
	if proxy:IsCompleteEvent( 147 ) == false then
		proxy:OnRegionJustIn( 147, LOCAL_PLAYER, 2105, "OnEvent_147", once );--�̈�
		proxy:OnRegionJustIn( 147, LOCAL_PLAYER, 2106, "OnEvent_147", once );--�̈�
	end
	
--��148�����񂾂ӂ蕅�s�l��
	if proxy:IsCompleteEvent( 148 ) == false then
		proxy:OnRegionJustIn( 148, LOCAL_PLAYER, 2107, "OnEvent_148", once );--�̈�
	end
	
--��149�����񂾂ӂ蕅�s�l��
	if proxy:IsCompleteEvent( 149 ) == false then
		proxy:OnRegionJustIn( 149, LOCAL_PLAYER, 2108, "OnEvent_149", once );--�̈�
	end
	
	
--��150�����΂��U���Ă��遡
	if proxy:IsCompleteEvent( 150 ) == false then
		proxy:OnRegionJustIn( 150, LOCAL_PLAYER, 2080, "OnEvent_150", once );
	end	
--��151�����΂��U���Ă��遡
	if proxy:IsCompleteEvent( 151 ) == false then
		proxy:OnRegionJustIn( 151, LOCAL_PLAYER, 2081, "OnEvent_151", once );
	end	

--��200�`256�����s�l�]������
	local fall_chrId_list = {300, 301, 302, 303, 304, 305, 306, 307, 308, 309,
							 310, 311, 312, 313, 314, 315, 316, 317, 318, 319,
							 320, 321, 322, 323, 324, 325, 326, 327, 328, 329,
							 330, 333, 334, 335, 336, 338,
							 500, 501, 502, 503, 504, 505, 506, 507, 508, 509,
							 510, 511, 512, 513, 514, 515, 516};
	local fall_chrNum = table.getn(fall_chrId_list);
	for index = 1, fall_chrNum, 1 do
		proxy:OnRegionJustIn( 200 + index - 1, fall_chrId_list[index], 2141, "fall_countup", once );
		proxy:OnRegionJustIn( 200 + index - 1, fall_chrId_list[index], 2142, "fall_countup", once );
		--proxy:OnRegistFunc( 200 + index - 1, "fall_Condition", "fall_result",fall_chrId_list[index], once );
	end


--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m05_00_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m05_00_00_00", everytime );
	proxy:NotNetMessage_end();	

--��22���͂����o����QWC�C�x���g
	SingleReset(proxy,22);	
	if 	proxy:IsSuccessQWC(50150) == false and
		proxy:IsCompleteEvent(24) == false then
		proxy:SetEventFlag( 22, true );--QWC������		
	end
	
	if proxy:IsCompleteEvent(24) == false then
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionJustIn( 24 , 10000 , 2170 , "OnEvent_24",once);
			proxy:NotNetMessage_end();
		end
	end
	
	if proxy:IsCompleteEvent( 22 ) == false then
		print("[����]QWC�͂���");
	else
		print("[������]QWC�͂���");
		--�͂�����艺��C�x���g���폜���A�͂����̓�����E�`�������
		proxy:DeleteEvent(20);
		proxy:DeleteEvent(21);
		proxy:SetColiEnable( 1062, false );
		proxy:SetDrawEnable( 1062, false );
	end

--[[
--���������̃I�u�W�F�̔j�󓯊�
	
	--������A
	if proxy:IsCompleteEvent( 50 ) ==true then
		proxy:ReconstructBreak( 1020 , 1 );
	end
	
	--������B
	if proxy:IsCompleteEvent( 60 ) ==true then
		proxy:ReconstructBreak( 1021 , 1 );
	end
]]
	
	
--��140�����񂾂ӂ蕅�s�l��
	if proxy:IsCompleteEvent(140) == false then
		--�t���O�������ĂȂ��ꍇ�͂ЂƂ܂����񂾃t��
		proxy:EnableLogic( 500, false );
		proxy:SetColiEnable( 500, false );
		proxy:EnableHide( 500, true );
	else
		--����ҋ@����
		proxy:SetSpStayAndDamageAnimId( 500 ,-1,-1);
	end
	
--��141�����񂾂ӂ蕅�s�l��
	if proxy:IsCompleteEvent(141) == false then
		--�t���O�������ĂȂ��ꍇ�͂ЂƂ܂����񂾃t��
		proxy:EnableLogic( 501, false );
		proxy:EnableLogic( 502, false );
		proxy:SetColiEnable( 501, false );
		proxy:SetColiEnable( 502, false );
		proxy:EnableHide( 501, true );
		proxy:EnableHide( 502, true );
	else
		--����ҋ@����
		proxy:SetSpStayAndDamageAnimId( 501 ,-1,-1);		
		proxy:SetSpStayAndDamageAnimId( 502 ,-1,-1);
	end

--��142�����񂾂ӂ蕅�s�l��
	if proxy:IsCompleteEvent(142) == false then
		--�t���O�������ĂȂ��ꍇ�͂ЂƂ܂����񂾃t��
		proxy:EnableLogic( 503, false );
		proxy:SetColiEnable( 503, false );
		proxy:EnableHide( 503, true );
	else
		--����ҋ@����
		proxy:SetSpStayAndDamageAnimId( 503 ,-1,-1);
	end
	
--��143�����񂾂ӂ蕅�s�l��
	if proxy:IsCompleteEvent(143) == false then
		--�t���O�������ĂȂ��ꍇ�͂ЂƂ܂����񂾃t��
		proxy:EnableLogic( 504, false );
		proxy:EnableLogic( 505, false );
		proxy:SetColiEnable( 504, false );
		proxy:SetColiEnable( 505, false );
		proxy:EnableHide( 504, true );
		proxy:EnableHide( 505, true );
	else
		proxy:SetSpStayAndDamageAnimId( 504 ,-1,-1);
		proxy:SetSpStayAndDamageAnimId( 505 ,-1,-1);
	end

--��144�����񂾂ӂ蕅�s�l��
	if proxy:IsCompleteEvent(144) == false then
		--�t���O�������ĂȂ��ꍇ�͂ЂƂ܂����񂾃t��
		proxy:EnableLogic( 506, false );
		proxy:SetColiEnable( 506, false );
		proxy:EnableHide( 506, true );
	else
		proxy:SetSpStayAndDamageAnimId( 506 ,-1,-1);
	end
	
--��145�����񂾂ӂ蕅�s�l��
	if proxy:IsCompleteEvent(145) == false then
		--�t���O�������ĂȂ��ꍇ�͂ЂƂ܂����񂾃t��
		proxy:EnableLogic( 507, false );
		proxy:EnableLogic( 508, false );
		proxy:SetColiEnable( 507, false );
		proxy:SetColiEnable( 508, false );
		proxy:EnableHide( 507, true );
		proxy:EnableHide( 508, true );
	else
		proxy:SetSpStayAndDamageAnimId( 507 ,-1,-1);
		proxy:SetSpStayAndDamageAnimId( 508 ,-1,-1);
	end
	
--��146�����񂾂ӂ蕅�s�l��
	if proxy:IsCompleteEvent(146) == false then
		--�t���O�������ĂȂ��ꍇ�͂ЂƂ܂����񂾃t��
		proxy:EnableLogic( 509, false );
		proxy:EnableLogic( 510, false );
		proxy:SetColiEnable( 509, false );
		proxy:SetColiEnable( 510, false );
		proxy:EnableHide( 509, true );
		proxy:EnableHide( 510, true );
	else
		proxy:SetSpStayAndDamageAnimId( 509 ,-1,-1);
		proxy:SetSpStayAndDamageAnimId( 510 ,-1,-1);
	end
	
--��147�����񂾂ӂ蕅�s�l��
	if proxy:IsCompleteEvent(147) == false then
		--�t���O�������ĂȂ��ꍇ�͂ЂƂ܂����񂾃t��
		proxy:EnableLogic( 511, false );
		proxy:EnableLogic( 512, false );
		proxy:SetColiEnable( 511, false );
		proxy:SetColiEnable( 512, false );
		proxy:EnableHide( 511, true );
		proxy:EnableHide( 512, true );
	else
		proxy:SetSpStayAndDamageAnimId( 511 ,-1,-1);
		proxy:SetSpStayAndDamageAnimId( 512 ,-1,-1);
	end
	
--��148�����񂾂ӂ蕅�s�l��
	if proxy:IsCompleteEvent(148) == false then
		--�t���O�������ĂȂ��ꍇ�͂ЂƂ܂����񂾃t��
		proxy:EnableLogic( 513, false );
		proxy:EnableLogic( 514, false );
		proxy:EnableLogic( 515, false );
		proxy:SetColiEnable( 513, false );
		proxy:SetColiEnable( 514, false );
		proxy:SetColiEnable( 515, false );
		proxy:EnableHide( 513, true );
		proxy:EnableHide( 514, true );
		proxy:EnableHide( 515, true );
	else
		proxy:SetSpStayAndDamageAnimId( 513 ,-1,-1);
		proxy:SetSpStayAndDamageAnimId( 514 ,-1,-1);
		proxy:SetSpStayAndDamageAnimId( 515 ,-1,-1);
	end

--��149�����񂾂ӂ蕅�s�l��
	if proxy:IsCompleteEvent(149) == false then
		--�t���O�������ĂȂ��ꍇ�͂ЂƂ܂����񂾃t��
		proxy:EnableLogic( 516, false );
		proxy:SetColiEnable( 516, false );
		proxy:EnableHide( 516, true );
	else
		proxy:SetSpStayAndDamageAnimId( 516 ,-1,-1);
	end	
	
	

--��150�����΂��U���Ă��遡
	if proxy:IsCompleteEvent(150) == true then
		proxy:ReconstructBreak( 1070 , 1 );
		proxy:ReconstructBreak( 1071 , 1 );
		proxy:ReconstructBreak( 1072 , 1 );
		proxy:ReconstructBreak( 1073 , 1 );
		proxy:ReconstructBreak( 1074 , 1 );
		proxy:ReconstructBreak( 1075 , 1 );
	end
	
	
--[[
	--���p�j�f�[�����p (�t���O�͉��A�w�肪����Ες���)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m05_00_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m05_00_00_00);
	end
	proxy:SetEventSimpleTalk( 100, LOCAL_PLAYER, 500, 2.0, 10010200, 0.0, 45.0, 0.0, 0.0, 0.0, ATTR_ALL, true, everytime );
	proxy:AddEventSimpleTalk( 100, 16000 );
	proxy:AddEventSimpleTalkTimer( 100, 16001, 1.5 );
	proxy:AddEventSimpleTalkTimer( 100, 16002, 3.0 );
	proxy:AddEventSimpleTalk( 100, 16003 );
	proxy:AddEventSimpleTalk( 100, 16010 );
]]	
	
	--��180�����̕ǁ�
	if proxy:IsCompleteEvent( 180 ) == false then
		proxy:OnDistanceActionAttribute( 180, LOCAL_PLAYER, 1080, "OnEvent_180", 1.5, 10010403, 180.0, 90.0, ATTR_HOST + ATTR_LIVE + ATTR_GREY, everytime );
		--proxy:SetObjSfx( 1080, 200, 85990, true );
	end
	
	--��181�����̕ǁ�
	if proxy:IsCompleteEvent( 181 ) == false then
		proxy:OnDistanceActionAttribute( 181, LOCAL_PLAYER, 1081, "OnEvent_181", 1.5, 10010403, 180.0, 90.0, ATTR_HOST + ATTR_LIVE + ATTR_GREY, everytime );
		--proxy:SetObjSfx( 1081, 200, 85991, true );
	end
	
	--��180,181�����̕ǍČ���
	if proxy:IsCompleteEvent( 180 ) == false or
	   proxy:IsCompleteEvent( 181 ) == false then
		proxy:LuaCall( 180, 1, "OnEvent_180_181_delete", once );
	else
		proxy:SetDrawEnable( 1080, false );--�`��OFF
		proxy:SetColiEnable( 1080, false );--������OFF
		
		proxy:SetDrawEnable( 1081, false );--�`��OFF
		proxy:SetColiEnable( 1081, false );--������OFF
		
		--�����̍Č��Ȃ̂Ŏ��R�ȕ\���̕K�v�������ׁARootErase�w��ł͂Ȃ�
		proxy:InvalidSfx( 2125, false );
		proxy:InvalidSfx( 2126, false );
	end

	--��190��������
	if proxy:IsCompleteEvent( 190 ) == false then
		proxy:OnRegionJustIn( 190, LOCAL_PLAYER, 2085, "OnEvent_190", once );
	else
		proxy:ReconstructBreak( 2085, 1 );
	end

--��167���{�X��J�����Ή���
	--�{�X�������Ă���Ȃ�o�^
	if proxy:IsCompleteEvent(5650) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 167 , LOCAL_PLAYER , 2887 ,"OnEvent_167" , everytime );
		proxy:NotNetMessage_end();
	end
	
--��8087���s��ɗ����t���O�𗧂Ă遡
	proxy:SetEventFlag( 8087, true );
	
--[[---------------------------------------------------------------------------------------
--NPC�֘A
-----------------------------------------------------------------------------------------	
	--�t���O������NPC��Ԃ�������
	SetFirstNpcStateFlag( proxy, param, kojiki_m50_flag_list, KOJIKI_M50_STATE_SEELING );
	
	--���S���Ă��Ȃ��Ƃ�
	if proxy:IsCompleteEvent(KOJIKI_M50_STATE_DEAD) == false then
		--��270����H(�j)�G�΁�
		if proxy:IsCompleteEvent( 270 ) == false then
			proxy:OnCharacterTotalDamage( 270, 650, LOCAL_PLAYER, TOTALDAMAGE_KOJIKI_M50, "OnEvent_270", once );
		end
		--��271����H(�j)���S��
		if proxy:IsCompleteEvent( 271 ) == false then
			proxy:OnCharacterDead( 271, 650, "OnEvent_271", once );
		end
	else
		print("��H(�j)���S");
		--����ł���̂Ŗ�����
		proxy:ForceUpdateNextFrame(650);
		InvalidCharactor( proxy, 650 );
	end
]]

	--��H(��)�̃V���b�vNPC
	if proxy:IsClient() == false then
	--��340����H(��)�̃V���b�vNPC�`�F�b�N�|�C���g(�v��)��
		proxy:OnRegionJustIn(272 , LOCAL_PLAYER , 2160 ,"OnEvent_272" , everytime);
	--��340����H(��)�̃V���b�vNPC�`�F�b�N�|�C���g(�g�f�[����)��
		proxy:OnRegionJustIn(273 , LOCAL_PLAYER , 2161 ,"OnEvent_273" , everytime);
	--��340����H(��)�̃V���b�vNPC�`�F�b�N�|�C���g(���f�[����)��
		proxy:OnRegionJustIn(275 , LOCAL_PLAYER , 2370 ,"OnEvent_275" , everytime);
	end
	
	--��635���`�F�b�N�|�C���g�̊Ď���
	proxy:LuaCall( 812 , 1 , "OnEvent_812",everytime);

	--��H(��)�̏������p
	OnEvent_812(proxy, param);

--------------------------------������QWC�C�x���g�֘A������--------------------------------

--��292��QWC�\�E�������X�^�[��
	if proxy:IsSuccessQWC(50100) == false then--�������Ă��Ȃ��Ȃ��
		print("�u���b�N�S�[�X�g������");
		--431�𖳌���
		InvalidBackRead(proxy, 431);
		--432�𖳌���
		InvalidBackRead(proxy, 432);
		--433�𖳌���
		InvalidBackRead(proxy, 433);
		
		proxy:SetEventFlag(292, true);
	end
	
--�g�J�Q���S�C�x���g
	RegistTokage(proxy,310,461,15);
	RegistTokage(proxy,830,462,16);
	RegistTokage(proxy,1140,463,17);
	
	--[[
00      520     9000    9600�@�@320 
0000    521     9000    9600�@�@321 
01      523     9000    9600�@�@322 
02      524     9000    9600�@�@323 
03      525     9000    9600�@�@324 
04      526     9000    9600�@�@325 
	]]
	
	local actidlist = {320,321,322,323,324,325};
	local daniidlist= {520,521,522,523,524,525};
	local num = table.getn( actidlist );

	for index = 1 ,num , 1 do
		--��actidlist�����_�j�_���[�W��
		SingleReset(proxy,actidlist[index]);
		if proxy:IsCompleteEvent( actidlist[index] ) == false then
			--proxy:EnableLogic( daniidlist[index], false );
			proxy:OnSimpleDamage( actidlist[index] , daniidlist[index] , 10000 , "OnEvent_"..actidlist[index],once);
		else
			--proxy:SetSpStayAndDamageAnimId( daniidlist[index] ,-1,-1);
		end
	end
	
	
	
--------------------------------������QWC�C�x���g�֘A������--------------------------------
	
	--��999999���t���[���x��̏����������C�x���g�𔭍s��
	proxy:NotNetMessage_begin();
		--��0�b�づ--
		proxy:OnKeyTime2( 999991, "Second_Initialize_m05_00_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	--��1�t���[���x��̏����������C�x���g�𔭍s��
--~ 	proxy:NotNetMessage_begin();
--~ 		--��1�b�ԁ�--�����ʒu���኱�����Ă���ꍇ�A������Ԃ��ҋ@���[�V�����ɂȂ�Ȃ��\�������邽�߁A1�b�ԑ��葱����
--~ 		proxy:OnKeyTime2( 999990, "Third_Initialize_m05_00_00_00", 1.0, 1, 1, once );
--~ 	proxy:NotNetMessage_end();
	
	if proxy:IsDbgReLoad() == true then
		proxy:OnKeyTime2( 4021,"OnEvent_DbgReLoad",1.0,0,0,once);
	end	
	print("Initialize_m05_00_00_00 end");
end

--�����[�h�f�o�b�O
function OnEvent_DbgReLoad(proxy,param)
	--���S�񕜗v��
	proxy:RequestFullRecover();
	--�Β��̕s��v�΂�
	proxy:WarpNextStage( 1, 0, 0, 0, 1009 );
end

function OnEvent_4000_Hp_1(proxy,param)
	print("OnEvent_4000_Hp_1 begin");
	proxy:SetDeadMode2(808 , true );
	proxy:SetDeadMode2(809 , true );
	proxy:SetDeadMode2(824 , true );
	print("OnEvent_4000_Hp_1 end");
end


--------------------------------------------------------------------------------------
--Initialize����Ă΂��A1�t���[���x��̏�����������999999
--------------------------------------------------------------------------------------
--��999999���ꕔ�AInit�ł͏����ł��Ȃ��̂ŁA�c���Ă���
function Second_Initialize_m05_00_00_00(proxy, param)
	print("Second_Initialize_m05_00_00_00 begin");
	
--------------------------------������QWC�C�x���g�֘A������--------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--------------------------------������QWC�C�x���g�֘A������--------------------------------

--��198,199�����s�l���̗L������
	local fall_chrId_list = {300, 301, 302, 303, 304, 305, 306, 307, 308, 309,
							 310, 311, 312, 313, 314, 315, 316, 317, 318, 319,
							 320, 321, 322, 323, 324, 325, 326, 327, 328, 329,
							 330, 331, 332, 333, 334, 335, 336, 337, 338, 339,
							 500, 501, 502, 503, 504, 505, 506, 507, 508, 509,
							 510, 511, 512, 513, 514, 515, 516};
	local fall_chrNum = table.getn(fall_chrId_list);
	
	proxy:SetEventFlag( 198, false );
	proxy:SetEventFlag( 199, false );
	proxy:OnNetRegion( 198, 2140 );
	--proxy:OnRegistFunc( 199, "corpse_Condition", "corpse_Result", fall_chrNum, everytime );
	--proxy:OnRegionJustIn( 199, LOCAL_PLAYER, 2140, "corpse_ReginIn", everytime );
	
	proxy:OnRegionJustIn( 199, LOCAL_PLAYER, 2140, "corpseCheck", everytime );
	proxy:LuaCall( 199, 2, "corpseUpdate", everytime );
	local fall_count = 0;
	for index = 1, fall_chrNum, 1 do
		if proxy:IsCompleteEvent( 200 + index - 1 ) == true then
			fall_count = fall_count + 1;
		end
	end
	for index = 1, 10, 1 do
		if fall_count >= index then
			proxy:SetDrawEnable( 10270 + index - 1, true );
			proxy:SetColiEnable( 10270 + index - 1, true );
			proxy:EnableObjTreasure( 10270 + index - 1, true );
		else
			print("�󎀑̖�����",10270 + index - 1);
			proxy:SetDrawEnable( 10270 + index - 1, false );
			proxy:SetColiEnable( 10270 + index - 1, false );
			proxy:EnableObjTreasure( 10270 + index - 1, false );
		end
	end
	
	

	print("Second_Initialize_m05_00_00_00 end");
end


--��1�t���[���x��̏�����������
function Third_Initialize_m05_00_00_00(proxy, param)
	print("Third_Initialize_m05_00_00_00 begin");
	--���񂾂ӂ蕅�s�l�ɃR�}���h�𑗂�
	if proxy:IsCompleteEvent(140) == false then
		--proxy:SetEventCommand( 500, 200);
	end
	if proxy:IsCompleteEvent(141) == false then
		--proxy:SetEventCommand( 501, 200);
		--proxy:SetEventCommand( 502, 200);
	end
	if proxy:IsCompleteEvent(142) == false then
		--proxy:SetEventCommand( 503, 200);
	end
	if proxy:IsCompleteEvent(143) == false then
		--proxy:SetEventCommand( 504, 200);
		--proxy:SetEventCommand( 505, 200);
	end
	if proxy:IsCompleteEvent(144) == false then
		--proxy:SetEventCommand( 506, 200);
	end
	if proxy:IsCompleteEvent(145) == false then
		--proxy:SetEventCommand( 507, 200);
		--proxy:SetEventCommand( 508, 200);
	end
	if proxy:IsCompleteEvent(146) == false then
		--proxy:SetEventCommand( 509, 200);
		--proxy:SetEventCommand( 510, 200);
	end
	if proxy:IsCompleteEvent(147) == false then
		--proxy:SetEventCommand( 511, 200);
		--proxy:SetEventCommand( 512, 200);
	end
	if proxy:IsCompleteEvent(148) == false then
		--proxy:SetEventCommand( 513, 200);
		--proxy:SetEventCommand( 514, 200);
		--proxy:SetEventCommand( 515, 200);
	end
	if proxy:IsCompleteEvent(149) == false then
		--proxy:SetEventCommand( 516, 200);
	end
	

--���������݂̂Ȃ̂�ID���������_�j������
--~ 	proxy:SetEventCommand( 520, 350);
--~ 	proxy:SetEventCommand( 521, 350);
--~ 	proxy:SetEventCommand( 522, 350);
--~ 	proxy:SetEventCommand( 523, 350);
--~ 	proxy:SetEventCommand( 524, 350);
--~ 	proxy:SetEventCommand( 525, 350);
--~ 	proxy:SetEventCommand( 526, 350);

	
	print("Third_Initialize_m05_00_00_00 end");
end


--------------------------------------------------------------------------------------
--�n�V�SA�~�聡0
--------------------------------------------------------------------------------------
--��0���n�V�SA�~��X�^�[�g��
function OnEvent_0(proxy, param)
	print("OnEvent_0 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_0 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����--
	proxy:BeginAction(LOCAL_PLAYER,2,2,2);				--�z�o�[�ړ����[�h�Ɉڍs
	--proxy:HoverMoveVal(LOCAL_PLAYER,2002,LadderTime_A);--�ړ��ʒu(2002)��0.5�b�Ńz�o�[�ړ�
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1060,192,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(LOCAL_PLAYER,1);				--�C�x���g�R�}���hID(1)"�n�V�S�ォ���"�ނ𑗂�
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );
	proxy:DisableMove(LOCAL_PLAYER,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(0,"OnEvent_0_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���)
		proxy:OnKeyTime2(0,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_0 end");
end

--��0_1���n�V�SA�~��X�^�[�g:�z�o�[�ړ��I����
function OnEvent_0_1(proxy, param)
	print("OnEvent_0_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_0_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,5,4);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_0_1 end");
end


--------------------------------------------------------------------------------------
--�n�V�SA���聡1
--------------------------------------------------------------------------------------
--��1���n�V�SA����X�^�[�g��
function OnEvent_1(proxy, param)
	print("OnEvent_1 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1 end");
		return;
	end
	
	--�͂�������ɕK�v�ȑO����--
	proxy:BeginAction(LOCAL_PLAYER,2,-1,1);			--�z�o�[�ړ����[�h�Ɉڍs
	--proxy:HoverMoveVal(LOCAL_PLAYER,2003,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1060,191,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(LOCAL_PLAYER,0);				--�C�x���g�R�}���hID(0)"�n�V�S�������"�ނ𑗂�
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );
	proxy:DisableMove(LOCAL_PLAYER,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂�������X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(1,"OnEvent_1_1",LadderTime_A,0,0,once);
		--�͂�������p�̊֐���1�b�Ԕ��s(�C�x���g���j���[�̒��f����?)
		proxy:OnKeyTime2(1,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1 end");
end

--��1_1���n�V�SA����X�^�[�g:�z�o�[�ړ��I����
function OnEvent_1_1(proxy, param)
	print("OnEvent_1_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,-1,4);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_1_1 end");
end


--------------------------------------------------------------------------------------
--�n�V�SB�~�聡10
--------------------------------------------------------------------------------------
--��10���n�V�SB�~��X�^�[�g��
function OnEvent_10(proxy, param)
	print("OnEvent_10 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_10 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����--
	proxy:BeginAction(LOCAL_PLAYER,2,2,2);				--�z�o�[�ړ����[�h�Ɉڍs
	--proxy:HoverMoveVal(LOCAL_PLAYER,2006,LadderTime_A);--�ړ��ʒu(2006)��0.5�b�Ńz�o�[�ړ�
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1061,192,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	--proxy:HoverMoveVal(LOCAL_PLAYER,1060,192,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(LOCAL_PLAYER,1);				--�C�x���g�R�}���hID(1)"�n�V�S�ォ���"�ނ𑗂�
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );--�����F0�A�@�΂߁F4
	proxy:DisableMove(LOCAL_PLAYER,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(10,"OnEvent_10_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���)
		proxy:OnKeyTime2(10,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_10 end");
end

--��10_1���n�V�SB�~��X�^�[�g:�z�o�[�ړ��I����
function OnEvent_10_1(proxy, param)
	print("OnEvent_10_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_10_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,11,10);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_10_1 end");
end


--------------------------------------------------------------------------------------
--�n�V�SB���聡11
--------------------------------------------------------------------------------------
--��11���n�V�SB����X�^�[�g��
function OnEvent_11(proxy, param)
	print("OnEvent_11 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_11 end");
		return;
	end
	
	--�͂�������ɕK�v�ȑO����--
	proxy:BeginAction(LOCAL_PLAYER,2,-1,1);			--�z�o�[�ړ����[�h�Ɉڍs
	--proxy:HoverMoveVal(LOCAL_PLAYER,2007,LadderTime_A);--�ړ��ʒu(2007)��0.5�b�Ńz�o�[�ړ�
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1061,191,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(LOCAL_PLAYER,0);				--�C�x���g�R�}���hID(0)"�n�V�S�������"�ނ𑗂�
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );
	proxy:DisableMove(LOCAL_PLAYER,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂�������X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(11,"OnEvent_11_1",LadderTime_A,0,0,once);
		--�͂�������p�̊֐���1�b�Ԕ��s(�C�x���g���j���[�̒��f����?)
		proxy:OnKeyTime2(11,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_11 end");
end

--��11_1���n�V�SA����X�^�[�g:�z�o�[�ړ��I����
function OnEvent_11_1(proxy, param)
	print("OnEvent_11_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_11_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,-1,10);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_11_1 end");
end


--------------------------------------------------------------------------------------
--�n�V�SC�~�聡20
--------------------------------------------------------------------------------------
--��20���n�V�SC�~��X�^�[�g��
function OnEvent_20(proxy, param)
	print("OnEvent_20 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_20 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����--
	proxy:BeginAction(LOCAL_PLAYER,2,2,2);				--�z�o�[�ړ����[�h�Ɉڍs
	--proxy:HoverMoveVal(LOCAL_PLAYER,2032,LadderTime_A);--�ړ��ʒu(2032)��0.5�b�Ńz�o�[�ړ�
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1062,192,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(LOCAL_PLAYER,1);				--�C�x���g�R�}���hID(1)"�n�V�S�ォ���"�ނ𑗂�
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );
	proxy:DisableMove(LOCAL_PLAYER,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(20,"OnEvent_20_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���)
		proxy:OnKeyTime2(20,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_20 end");
end

--��20_1���n�V�SB�~��X�^�[�g:�z�o�[�ړ��I����
function OnEvent_20_1(proxy, param)
	print("OnEvent_20_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_20_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,11,10);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_20_1 end");
end


--------------------------------------------------------------------------------------
--�n�V�SC���聡21
--------------------------------------------------------------------------------------
--��21���n�V�SC����X�^�[�g��
function OnEvent_21(proxy, param)
	print("OnEvent_21 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_21 end");
		return;
	end
	
	--�͂�������ɕK�v�ȑO����--
	proxy:BeginAction(LOCAL_PLAYER,2,-1,1);			--�z�o�[�ړ����[�h�Ɉڍs
	--proxy:HoverMoveVal(LOCAL_PLAYER,2033,LadderTime_A);--�ړ��ʒu(2033)��0.5�b�Ńz�o�[�ړ�
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1062,191,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(LOCAL_PLAYER,0);				--�C�x���g�R�}���hID(0)"�n�V�S�������"�ނ𑗂�
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );
	proxy:DisableMove(LOCAL_PLAYER,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂�������X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(21,"OnEvent_21_1",LadderTime_A,0,0,once);
		--�͂�������p�̊֐���1�b�Ԕ��s(�C�x���g���j���[�̒��f����?)
		proxy:OnKeyTime2(21,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_21 end");
end

--��21_1���n�V�SC����X�^�[�g:�z�o�[�ړ��I����
function OnEvent_21_1(proxy, param)
	print("OnEvent_21_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_21_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,-1,10);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_21_1 end");
end


--------------------------------------------------------------------------------------
--�C�X�^������23
--------------------------------------------------------------------------------------
function OnEvent_23(proxy,param)
	if param:IsNetMessage() == false then	
	print("OnEvent_23 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		--�A�j��
		proxy:PlayAnimation( 10000 , 8290);
		proxy:PlayAnimation( 1002 , 1);	
		proxy:OnKeyTime2( 23 , "OnEvent_23_0",0.01,0,0,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	print("OnEvent_23 end");
	end
end

function OnEvent_23_0(proxy,param)
	print("OnEvent_23_0 begin");
	--if proxy:IsPlayerStay(10000) == true then
	if proxy:IsEventAnim( 10000 , 8290 ) == true then		
		proxy:LuaCallStart( 23, 2);			
	else
		proxy:ForcePlayAnimation( 1002 , 0);	
	end
	print("OnEvent_23_0 end");
end

--��23_1���A�C�e���擾��
function OnEvent_23_1(proxy,param)
	print("OnEvent_23_1 begin");
	--�A�C�e���擾�֐�--�p�����[�^10419�Q��
	proxy:GetRateItem(10419);	
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 23, true );
	
	--OBJ���������߂̃C�x���g�z�M
	proxy:LuaCallStart( 23, 1);

	print("OnEvent_23_1 end");
end

--��23_2����OBJ��\���p��
function OnEvent_23_2(proxy,param)
	print("OnEvent_23_2 begin");
	--�I�u�W�F��������
	proxy:SetDrawEnable( 1002 , false );--�ЂƂ܂��`�悾��OFF
	proxy:SetColiEnable( 1002 , false );--������͂���͕̂s��(����ł͂Ȃ��悤�Ȃ̂ŏ����Ȃ�)
	
	proxy:DeleteEvent( 23 );
	print("OnEvent_23_2 end");
end

--�A�j���̓����Ď�
function OnEvent_23_3(proxy,param)
	print("OnEvent_23_3 begin");
	proxy:TreasureDispModeChange2( 1002, false ,KEN_SFX);
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8290 ) == true then--�V�����A�j�� 
		proxy:PlayAnimation( 1002 , 1);	
		print("OnEvent_23_3 end");
		return true;
	end		
	
	--���Ƀ��[�v
	proxy:WarpDmy( LOCAL_PLAYER , 1002 , 191 );
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 23 , LOCAL_PLAYER , 8290 , "OnEvent_23_1", once);
	proxy:NotNetMessage_end();	
	print("OnEvent_23_3 end");	
end

--------------------------------------------------------------------------------------
--���ˋ�A��30
--------------------------------------------------------------------------------------
--��30�����ˋ���
function OnEvent_30(proxy, param)
	print("OnEvent_30 begin");
	
	if proxy:IsCompleteEvent(30) == true then
		print("ID 30 IsCompleteEvent true"); 
		print("OnEvent_30 end");
		return;
	end

	proxy:PlayAnimation(1000,1);--���ˋ��̍쓮�A�j���[�V����
	proxy:SetEventFlag( 30, 1 );--���ˋ��͍쓮�ς�
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_KICK ) == true then
		print("OnEvent_30_1 end");
		return;
	end
	
	proxy:WarpDmy( LOCAL_PLAYER , 1000 , 191 );
	
	print("OnEvent_30 end");
end


--------------------------------------------------------------------------------------
--���ˋ�B��40
--------------------------------------------------------------------------------------
--��40�����ˋ���
function OnEvent_40(proxy, param)
	print("OnEvent_40 begin");
		
	if proxy:IsCompleteEvent(40) == true then
		print("ID 40 IsCompleteEvent true"); 
		print("OnEvent_40 end");
		return;
	end

	proxy:PlayAnimation(1001,1);--���ˋ��̍쓮�A�j���[�V����
	proxy:SetEventFlag( 40, 1 );--���ˋ��͍쓮�ς�
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_KICK ) == true then
		print("OnEvent_40 end");
		return;
	end
	
	proxy:WarpDmy( LOCAL_PLAYER , 1001 , 191 );
	
	print("OnEvent_40 end");
end


--------------------------------------------------------------------------------------
--������A��50
--------------------------------------------------------------------------------------
--��50��������A:�o�^��
function OnEvent_50(proxy, param)
	print("OnEvent_50 begin");
	
	if proxy:IsDestroyed(1020) == true then
		print("ID 1020 IsDestroyed true");
		print("OnEvent_50 end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--���ʉ��Đ�
		proxy:PlayObjectSE(1020,500000);
		--0.5�b��ɏ����������C�x���g�𔭍s
		proxy:OnKeyTime2(50,"OnEvent_50_1", 0.5,0,0,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_50 end");
end

--��50_1��������A:������
function OnEvent_50_1(proxy, param)
	print("OnEvent_50_1 begin");
	
	proxy:ChangeModel(1020, 1);		--���f�������ւ�
	proxy:SetBrokenPiece(1020);
	
	proxy:PlayObjectSE(1020,500100);--���ʉ��Đ�
	proxy:SetEventFlag( 50, 1 );	--�����������ς�
	
	print("OnEvent_50_1 end");
end

--------------------------------------------------------------------------------------
--������B��60
--------------------------------------------------------------------------------------
--��60��������B:�o�^��
function OnEvent_60(proxy, param)
	print("OnEvent_60 begin");
	
	if proxy:IsDestroyed(1021) == true then
		print("ID 1021 IsDestroyed true");
		print("OnEvent_60 end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--���ʉ��Đ�
		proxy:PlayObjectSE(1021,500000);
		--0.5�b��ɏ����������C�x���g�𔭍s
		proxy:OnKeyTime2(60,"OnEvent_60_1", 0.5,0,0,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_60 end");
end

--��60_1��������B:������
function OnEvent_60_1(proxy, param)
	print("OnEvent_60_1 begin");
	
	proxy:ChangeModel(1021, 1);		--���f�������ւ�
	proxy:SetBrokenPiece(1021);
	
	proxy:PlayObjectSE(1021,500100);--���ʉ��Đ�
	proxy:SetEventFlag( 60, 1 );	--�����������ς�
	
	print("OnEvent_60_1 end");
end


--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ��遡160
--------------------------------------------------------------------------------------

--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫

--��160�����{�X�����ւ̔����J����
function OnEvent_160(proxy,param)
	print("OnEvent_160 begin");

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_160 end");
		return;
	end
	
	--�N���C�A���g�ցA�{�X�����j�~���s��ʒm
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 161 , 1 );--����A�j���̓����Đ�
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE , true );--���d�����h�~�p�t���OON
	--���d�N���V�X�e��ID���^�C���A�E�g��ݒ肵��ON�ɂ���
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_160 end");
end


--����A�j���̓����Đ�(ID����)
function OnEvent_161_1(proxy,param)
	print("OnEvent_161_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ����s���A���̏I������OnEvent_161_2�𔭍s����
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2891 );
		else
			proxy:LockSession();--���[�������b�N���܂��I
			--����A�j���Đ����s���A���̏I������OnEvent_161_2�𔭍s����
			proxy:OnTurnCharactorEnd( 161, LOCAL_PLAYER, 2891, "OnEvent_161_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_161_1 end");
end

--����A�j���̓����Đ��I����
function OnEvent_161_2(proxy,param)
	print("OnEvent_161_2 begin");
	
	--�����p�����A�j���Đ�
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 161, LOCAL_PLAYER, ANIMEID_WALK, "OnEvent_161_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();

	print("OnEvent_161_2 end");
end

--�����A�j���̓����Đ��I����
function OnEvent_161_3(proxy,param)
	print("OnEvent_161_3 begin");

	--�ŏ��̐l���{�X�����̒��ɓ���I����Ă�����A���ɔz�M����Ă���͂��Ȃ̂ŁA����������Ȃ��n���h��
	if proxy:IsCompleteEvent( 160 ) == false then
		proxy:LuaCallStart( 161 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCallStart( 4045 , 1 );	--�N���C�A���g�ցA�{�X�����ɓ����悤�ɂȂ������Ƃ�ʒm
		proxy:LuaCallStart( 161 , 6 );--�t���O�Z�b�g(�����p)
		Lua_MultiDoping(proxy,808);--�}���`�v���C�h�[�s���O
	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�)
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:ResetThink( 808 );
	end	
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );

	print("OnEvent_161_3 end");
end


--��160 2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
function OnEvent_160_GO_TO_IN(proxy, param)
	print("OnEvent_160_GO_TO_IN begin");
		
	proxy:NotNetMessage_begin();
		--��161�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���--�n���h���� OnEvent_160
		proxy:OnPlayerActionInRegion( 161, 2895, "OnEvent_160", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	
	print("OnEvent_160_GO_TO_IN end");
end


--��160 �t���O�Z�b�g(�����p)
function OnEvent_160_flag_set(proxy, param)
	print("OnEvent_160_flag_set begin");
		
	proxy:SetEventFlag( 160 , 1 );
	proxy:DeleteEvent( 160 );

	print("OnEvent_160_flag_set end");
end


--------------------------------------------------------------------------------------
--���{�X�|�����Đ���162
--------------------------------------------------------------------------------------
--��162�����{�X�咣���o��
function OnEvent_162(proxy, param)
	print("OnEvent_162 begin");
	--���{�X�o��|����
	proxy:RequestRemo(50000,REMO_FLAG,162,1);
	proxy:SetEventFlag( 162 , 1 );	
	print("OnEvent_162 end");
end

function OnEvent_162_RemoStart(proxy,param)
	print("OnEvent_162_RemoStart begin");
	--���ɖ���
	print("OnEvent_162_RemoStart end");
end

function OnEvent_162_RemoFinish(proxy,param)
	print("OnEvent_162_RemoFinish begin");
	--���ɖ���
	print("OnEvent_162_RemoFinish end");
end


--------------------------------------------------------------------------------------
--�{�X�������o��(�퓬�J�n)��163
--------------------------------------------------------------------------------------

function OnEvent_163(proxy, param)
	print("OnEvent_163 begin");
	
	--�{�X��pBGM�Đ��J�n
	proxy:PlayPointSE( 2120, SOUND_TYPE_M, 50000000, 0 );--�̈��ID�̂ݖ���
	
	proxy:SetDrawEnable( 808, true );
	
	--�{�X���W�b�NON
	proxy:EnableLogic( 808 , true );
	
	proxy:SetEventFlag( 163, true );
	
	--�ǂݍ��݃^�C�~���O�̂Ƃ�����ǉ�����Ăق����̂Ńt���O���ĂȂ�
	
	--�{�X�Q�[�W�\��
	proxy:SetBossGauge(808 , 0, 5090);
	
	print("OnEvent_163 end");
end


--------------------------------------------------------------------------------------
--��5650���{�X���S��
--------------------------------------------------------------------------------------
--��5650���{�X���S��
function OnEvent_5650(proxy,param)
	print("OnEvent_5650 begin");
	
	proxy:NotNetMessage_begin();
		--1�b��ɃA�C�e���擾�C�x���g�𔭍s--
		proxy:OnKeyTime2(5650,"OnEvent_5650_1", 1.0,0,0,once);
		--2�b��ɕ����ǔ����C�x���g�𔭍s--
		proxy:OnKeyTime2(5652,"OnEvent_5652", 2.0,0,0,once);
		
		--�}���`���U�Ď�
		proxy:OnRegistFunc( 5650,"Check_5650_PT","OnEvent_5650_PT",0,once);
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( 5650, true );--�t���O�𗧂Ă�B
	
	--�g���̃_���[�W���Ď��폜
	proxy:DeleteEvent(5730);
	
	--���ɕg���ɓ����Ă���l�͂����ŉ���
	proxy:EraseEventSpecialEffect(LOCAL_PLAYER, 10060);
	
	--�u���b�N�N���A������
	proxy:CustomLuaCallStart( 4050, 808 );
	--�g�J�Q���Z�b�g
	ResetTokage(proxy);
	
	print("OnEvent_5650 end");
end

--��5650_1��1�b�っ
function OnEvent_5650_1(proxy, param)
	print("OnEvent_5650_1 begin");
	
	--�{�X��|���������X�V(���ɂ���ăt���O�𗧂Ă�)
	GetBossFlagCount( proxy, param );
		
	--���g���t�B�[�擾���聥
	Lua_RequestUnlockTrophy(proxy, 34);
		
	--��H(��)�̏������p
	OnEvent_812(proxy, param);

	--�z�X�g�v���C���[�̂݃A�C�e������C�x���g�Ɏg�p
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	
	--�󎀑�(�\�E��?)�L����
	proxy:SetDrawEnable( 1982 , true );
	proxy:SetColiEnable( 1982 , true );
	--�\�E���Ɏh���������L����
	proxy:SetDrawEnable( 1975 , true );
	proxy:SetColiEnable( 1975 , true );
		
	--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
	if proxy:IsCompleteEvent( 5653 ) == false then
		--SFX �L����
		proxy:ValidSfx( 2150 );--�v�΂̃I�[��
		proxy:ValidSfx( 2151 );--���̗��q
		proxy:TreasureDispModeChange2( 1982, true ,KANAME_SFX);--���点��
		--proxy:TreasureDispModeChange2( 1975, true ,KANAME_SFX);--���点��
		proxy:OnDistanceActionAttribute( 5653 , LOCAL_PLAYER , 1982 , "OnEvent_5653" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end		
		
	print("OnEvent_5650_1 end");
end

--��5652��2�b�っ
function OnEvent_5652(proxy, param)
	print("OnEvent_5652 begin");
	
	--�{�X��p��BGM��~
	proxy:StopPointSE( 0 );

	proxy:SetEventFlag( 5652, true );

	print("OnEvent_5652 end");
end

--�}���`���U�Ď�
function Check_5650_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;	
end

function OnEvent_5650_PT(proxy,param)
	print("OnEvent_5650_PT begin");
	--���{�X�����̑O��̖��@�ǂ�������(�S�v���C���[)
	proxy:SetColiEnable( 1999 , false );
	proxy:SetColiEnable( 1995 , false );
	
	proxy:SetDrawEnable( 1999 , false );
	proxy:SetDrawEnable( 1995 , false );	

	--���̕�Sfx������
	proxy:InvalidSfx( 1987, true );
	proxy:InvalidSfx( 1991, true );

	
	--���{�X�����O�̈ړ������C�x���g���폜
	proxy:DeleteEvent( 160 );--��l�ڂ�����Ƃ��p
	proxy:DeleteEvent( 161 );--��l�ڈȍ~������Ƃ��p
	print("OnEvent_5650_PT end");
end
--------------------------------------------------------------------------------------
--��5653���\�E�����聡
--------------------------------------------------------------------------------------
function OnEvent_5653(proxy, param)
	print("OnEvent_5653 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--�V�����A�j�� 
		print("OnEvent_5653 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 5653, "OnEvent_5653_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_5653 end");
end


--��5653_1���A�C�e���擾��
function OnEvent_5653_1(proxy, param)
	print("OnEvent_5653_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10232�Q��
	proxy:GetRateItem(10450);
	proxy:GetRateItem(10470);
	proxy:GetRateItem(10471);
	proxy:GetRateItem(10472);
	proxy:GetRateItem(10473);
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 5653, 1 );

	--�󔠃V�F�[�_�[OFF
	--proxy:TreasureDispModeChange( 1982 , false );

	--SFX��������
	proxy:InvalidSfx( 2150 , true );--�v�΂̃I�[��
	--proxy:InvalidSfx( 2151 , true );--���̗��q
		
	--���v�΂Ń��[�v�p�̊Ď���ǉ���
	proxy:OnDistanceActionAttribute( 5654 , LOCAL_PLAYER , 1982 , "OnEvent_5654" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_5653_1 end");
end

--------------------------------------------------------------------------------------
--�h���苴A��70
--------------------------------------------------------------------------------------
--��70���苴A�h�ꔭ����
function OnEvent_70(proxy,param)	
	if proxy:IsPlayerStay(LOCAL_PLAYER) == false then		
--		print("Player Is Move");		
		--�苴���h���A�j���[�V�����Đ�
		proxy:PlayAnimation(1034,1);				
	end
end


--------------------------------------------------------------------------------------
--�h���苴B��80
--------------------------------------------------------------------------------------
--��80���苴B�h�ꔭ����
function OnEvent_80(proxy,param)	
	if proxy:IsPlayerStay(LOCAL_PLAYER) == false then			
--		print("Player Is Move");		
		--�苴���h���A�j���[�V�����Đ�
		proxy:PlayAnimation(1035,1);		
	end	
end


--------------------------------------------------------------------------------------
--�h���苴C��90
--------------------------------------------------------------------------------------
--��90���苴C�h�ꔭ����
function OnEvent_90(proxy,param)	
	if proxy:IsPlayerStay(LOCAL_PLAYER) == false then	
--		print("Player Is Move");	
		--�苴���h���A�j���[�V�����Đ�
		proxy:PlayAnimation(1036,1);			
	end	
end


--------------------------------------------------------------------------------------
--�h���苴D��100
--------------------------------------------------------------------------------------
--��100���苴D�h�ꔭ����
function OnEvent_100(proxy,param)	
	if proxy:IsPlayerStay(LOCAL_PLAYER) == false then		
--		print("Player Is Move");		
		--�苴���h���A�j���[�V�����Đ�
		proxy:PlayAnimation(1037,1);			
	end
end

--------------------------------------------------------------------------------------
--�ӂ�ӂ푫�ꁡ130
--------------------------------------------------------------------------------------

--��130����̗̈�N����
function OnEvent_130_1(proxy,param)	
	print("OnEvent_130_1 begin");
	
	--�����̗̈�i���C�x���g�𔭍s
	proxy:RepeatMessage_begin();
		proxy:OnRegionIn( 131,LOCAL_PLAYER,2041,"OnEvent_130_2", once );
	proxy:RepeatMessage_end();

	print("OnEvent_130_1 end");
end

--��130�����̗̈�N����
function OnEvent_130_2(proxy,param)	
	print("OnEvent_130_2 begin");
	
	--�㑤�̗̈�i���C�x���g�𔭍s
	proxy:RepeatMessage_begin();
		proxy:OnRegionIn( 130,LOCAL_PLAYER,2040,"OnEvent_130_1", once );
	proxy:RepeatMessage_end();
	
	proxy:PlayAnimation( 1040 , 1 );--�ӂ�ӂ�A�j���Đ�
	
	print("OnEvent_130_2 end");
end

--��131���ӂ�ӂ�A�j��(�̈���ړ�)��
function OnEvent_131(proxy,param)
	if proxy:IsPlayerStay(LOCAL_PLAYER) == false then	
		--�ӂ�ӂ�A�j���Đ�
		proxy:PlayAnimation(1040,1);			
	end	
end

--��132���ӂ�ӂ�A�j��(�̈���ړ�)��
function OnEvent_132(proxy,param)
	if proxy:IsPlayerStay(LOCAL_PLAYER) == false then	
		--�ӂ�ӂ�A�j���Đ�
		proxy:PlayAnimation(1050,1);			
	end	
end
--��133���ӂ�ӂ�A�j��(�̈���ړ�)��
function OnEvent_133(proxy,param)
	if proxy:IsPlayerStay(LOCAL_PLAYER) == false then	
		--�ӂ�ӂ�A�j���Đ�
		proxy:PlayAnimation(1051,1);			
	end	
end

--------------------------------------------------------------------------------------
--���炷��ї���110
--------------------------------------------------------------------------------------
function Check_110(proxy)	
	--�R�R�͖��t���[���Ď������̂�print������̂͂����߂��܂���B�e�X�g�̎������ɂ��Ă��������B
	if proxy:CheckChrHit_Obj(LOCAL_PLAYER,1039) == true then
		--���������������u�ԂȂ̂ŁA�R�R�ɂ�print�����Ă������Ƃ������߂��܂�
		print("Check_110 true");
		return true
	end
	return false;
end

function OnEvent_110(proxy,param)
	print("OnEvent_110 begin");
	local animId = {10,10,10,11,11,11,12,12,12};
	local objId = {1041,1042,1043,1044,1045,1046,1047,1048,1049};
	for index = 1, 9, 1 do
		proxy:PlayAnimation( objId[index], animId[index] );
	end
	
	proxy:SetEventFlag( 110 , 1 );
	
	print("OnEvent_110 end");
end


--------------------------------------------------------------------------------------
--��280���Β��Ƀ��[�v��
--------------------------------------------------------------------------------------

--��280���Β��Ƀ��[�v��
function OnEvent_280(proxy,param)	

	if proxy:IsCompleteEvent( 280 ) == true then
		return;
	end
	
	if param:IsNetMessage() == true then
		return;
	end
	
	
	print("OnEvent_280 begin");
	
	--�Z�b�V�������Ȃ�΁A�v�΂̃��[�v����
	if proxy:IsSession() == false then--�Z�b�V�������ł͂Ȃ�
		proxy:RepeatMessage_begin();
			--��659_1���I�����j���[�̊Ď���
			proxy:OnSelectMenu(280, "OnEvent_280_0", 10010710, 0, 2, 1983, 2, once);			
		proxy:RepeatMessage_end();
	else--�Z�b�V������
		--�G���[�\���u�Z�b�V�������͞��̐_�a�ɂ͖߂�܂���v
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010720, 1);
		--proxy:ShowGenDialog(10010720,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end

	print("OnEvent_280 end");
end

--��280_0���I�����j���[�̊Ď���
function OnEvent_280_0(proxy, param)
	print("OnEvent_280_0 begin");
	
	if proxy:IsSession() == false then
		
		proxy:PlayAnimation( LOCAL_PLAYER , 8283 );--�v�΂ɐG���A�j�����Đ�
		proxy:NoAnimeTurnCharactor( 10000 , 1983 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--���v�΂ɐG���A�j���Đ��I����
			proxy:OnChrAnimEnd( 280 , LOCAL_PLAYER , 8283 , "OnEvent_280_1" , once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 280 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_280_0 end");
end

--��280_1���I�����j���[�̊Ď���
function OnEvent_280_1(proxy, param)
	print("OnEvent_280_1 begin");
	
	proxy:SetEventFlag( 280 , 0 );
	
	proxy:PlayAnimation( LOCAL_PLAYER , 8284 );--�����E�ɋA��A�j�����Đ�

	proxy:SetEventFlag( 280 , 1 );
	
	OnEvent_280_2(proxy,param);
	
	print("OnEvent_280_1 end");
end

--���v�΂ɐG���A�j���Đ��I����
function OnEvent_280_2(proxy,param)	
	print("OnEvent_280_2 begin");
	
	--�Β��֖߂��Ă�������̃t���O�𗧂Ă�
	proxy:SetEventFlag(8083, true);

	proxy:SetEventFlag( 280 , 0 );
	--���S�񕜗v��
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1009 );
	
	print("OnEvent_280_2 end");
end


--------------------------------------------------------------------------------------
--��5654���Β��Ƀ��[�v��
--------------------------------------------------------------------------------------
function OnEvent_5654(proxy,param)	
	print("OnEvent_5654 begin");
	
	if proxy:IsCompleteEvent( 5654 ) == true then
		return;
	end
	
	proxy:RepeatMessage_begin();
		--��_1���I�����j���[�̊Ď���
		proxy:OnSelectMenu(5654, "OnEvent_5654_1", 10010710, 0, 2, 1982, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_5654 end");
end

--��5654_1���I�����j���[�̊Ď���
function OnEvent_5654_1(proxy,param)	
	print("OnEvent_5654_1 begin");

	if proxy:IsSession() == false then
		
		proxy:PlayAnimation(LOCAL_PLAYER,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1982 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--���v�΂ɐG���A�j���Đ��I�������灣
			proxy:OnChrAnimEnd( 5654 , LOCAL_PLAYER , 8283 , "OnEvent_5654_2",once);
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(5654,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_5654_1 end");
end

--��5654_2���v�΂ɐG���A�j���Đ��I����
function OnEvent_5654_2(proxy,param)	
	print("OnEvent_5654_2 begin");
	
	proxy:SetEventFlag(5654,false);
	
	proxy:PlayAnimation(LOCAL_PLAYER,8284);
	
	proxy:SetEventFlag(5654,true);
	--���[�v�����J�n
	OnEvent_5654_3(proxy,param);
	
	print("OnEvent_5654_2 end");
end

--�������E�ɋA��A�j���Đ��I����
function OnEvent_5654_3(proxy,param)	
	print("OnEvent_5654_3 begin");
	
	--�Β��֖߂��Ă�������̃t���O�𗧂Ă�
	proxy:SetEventFlag(8083, true);

	proxy:SetEventFlag(5654,false);
	--���S�񕜗v��
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1009 );
	
	print("OnEvent_5654_3 end");
end

--------------------------------------------------------------------------------------
--���񂾃t�����s�l��140
--------------------------------------------------------------------------------------
--��140�����񂾃t�����s�l��
function OnEvent_140(proxy,param)
	print("OnEvent_140 begin");
	
	if proxy:IsAlive( 500 ) == true then
	
		--�N���オ��A�j���Đ�
		--proxy:SetEventCommand( 500, 201 );
		proxy:PlayAnimation( 500 , 9920);		
		proxy:SetSpStayAndDamageAnimId( 500 ,-1,-1);
		--�������L���ɐݒ�
		proxy:SetColiEnable(500, true);	
		--���W�b�N���ĊJ
		proxy:EnableLogic( 500, true );
		--���G��On�i���b�N�\�ɂ���j
		proxy:EnableHide( 500, false );
		
	end
	
	--�t���O���Z�b�g
	proxy:SetEventFlag( 140, 1 );

	print("OnEvent_140 end");
end

--------------------------------------------------------------------------------------
--���񂾃t�����s�l��141
--------------------------------------------------------------------------------------
--��141�����񂾃t�����s�l��
function OnEvent_141(proxy,param)
	print("OnEvent_141 begin");
	
	if proxy:IsAlive( 501 ) == true then
		--�����ɂ��X�V�^�C�~���O�̖��ŁAEzState�ɖ��߂��͂��Ȃ��ꍇ������̂�1�t���[�������X�V
		proxy:ForceUpdateNextFrame( 501 );
		--�N���オ��A�j���Đ�
		--proxy:SetEventCommand( 501, 201 );
		proxy:PlayAnimation( 501,9920 );
		proxy:SetSpStayAndDamageAnimId( 501 ,-1,-1);
		--�������L���ɐݒ�
		proxy:SetColiEnable(501, true);
		--���W�b�N���ĊJ
		proxy:EnableLogic( 501, true );
		--���G��On�i���b�N�\�ɂ���j
		proxy:EnableHide( 501, false );
		
		
	end
	
	if proxy:IsAlive( 502 ) == true then
	
		--�����ɂ��X�V�^�C�~���O�̖��ŁAEzState�ɖ��߂��͂��Ȃ��ꍇ������̂�1�t���[�������X�V
		proxy:ForceUpdateNextFrame( 502 );
		--�N���オ��A�j���Đ�
		--proxy:SetEventCommand( 502, 202 );--9800
		proxy:PlayAnimation( 502 , 9800 );
		proxy:SetSpStayAndDamageAnimId( 502 ,-1,-1);
		--�������L���ɐݒ�
		proxy:SetColiEnable(502, true);
		--���W�b�N���ĊJ
		proxy:EnableLogic( 502, true );
		--���G��On�i���b�N�\�ɂ���j
		proxy:EnableHide( 502, false );		
	end
	
	--�t���O���Z�b�g
	proxy:SetEventFlag( 141, 1 );

	--���̃C�x���g�ւ̔����̈悪2����A(�o�^ID�͓���)
	--�Е�����������ƁA�����Е��͔������Ȃ��悤�ɂ���B
	--�p�[�e�B�[�v���C���[�̊Ď����܂� �����ō폜�B
	proxy:DeleteEvent( 141 );
	
	print("OnEvent_141 end");
end

--------------------------------------------------------------------------------------
--���񂾃t�����s�l��142
--------------------------------------------------------------------------------------
--��142�����񂾃t�����s�l��
function OnEvent_142(proxy,param)	
	print("OnEvent_142 begin");
	
	if proxy:IsAlive( 503 ) == true then
	
		--�����ɂ��X�V�^�C�~���O�̖��ŁAEzState�ɖ��߂��͂��Ȃ��ꍇ������̂�1�t���[�������X�V
		proxy:ForceUpdateNextFrame( 503 );
		--�N���オ��A�j���Đ�
		--proxy:SetEventCommand( 503, 201 );
		proxy:PlayAnimation( 503 ,9920 );
		proxy:SetSpStayAndDamageAnimId( 503 ,-1,-1);
		--�������L���ɐݒ�
		proxy:SetColiEnable(503, true);	
		--���W�b�N���ĊJ
		proxy:EnableLogic( 503, true );
		--���G��On�i���b�N�\�ɂ���j
		proxy:EnableHide( 503, false );
	end
	
	--�t���O���Z�b�g
	proxy:SetEventFlag( 142, 1 );
	
	print("OnEvent_142 end");
end

--------------------------------------------------------------------------------------
--���񂾃t�����s�l��143
--------------------------------------------------------------------------------------
--��143�����񂾃t�����s�l��
function OnEvent_143(proxy,param)
	print("OnEvent_143 begin");
	
	if proxy:IsAlive( 504 ) == true then
	
		--�����ɂ��X�V�^�C�~���O�̖��ŁAEzState�ɖ��߂��͂��Ȃ��ꍇ������̂�1�t���[�������X�V
		proxy:ForceUpdateNextFrame( 504 );
		--�N���オ��A�j���Đ�
		--proxy:SetEventCommand( 504, 201 );
		proxy:PlayAnimation( 504 , 9920 );
		proxy:SetSpStayAndDamageAnimId( 504 ,-1,-1);	
		--�������L���ɐݒ�
		proxy:SetColiEnable(504, true);
		--���W�b�N���ĊJ
		proxy:EnableLogic( 504, true );
		--���G��On�i���b�N�\�ɂ���j
		proxy:EnableHide( 504, false );		
	end
	
	if proxy:IsAlive( 505 ) == true then
		
		--�����ɂ��X�V�^�C�~���O�̖��ŁAEzState�ɖ��߂��͂��Ȃ��ꍇ������̂�1�t���[�������X�V
		proxy:ForceUpdateNextFrame( 505 );
		--�N���オ��A�j���Đ�
		--proxy:SetEventCommand( 505, 202 );--9800
		proxy:PlayAnimation( 505 , 9800 );
		proxy:SetSpStayAndDamageAnimId( 505 ,-1,-1);
		--�������L���ɐݒ�
		proxy:SetColiEnable(505, true);
		--���W�b�N���ĊJ
		proxy:EnableLogic( 505, true );
		--���G��On�i���b�N�\�ɂ���j
		proxy:EnableHide( 505, false );
	end
	
	--�t���O���Z�b�g
	proxy:SetEventFlag( 143, 1 );
	
	--���̃C�x���g�ւ̔����̈悪2����A(�o�^ID�͓���)
	--�Е�����������ƁA�����Е��͔������Ȃ��悤�ɂ���B
	--�p�[�e�B�[�v���C���[�̊Ď����܂� �����ō폜�B
	proxy:DeleteEvent( 143 );
	
	print("OnEvent_143 end");
end


--------------------------------------------------------------------------------------
--���񂾃t�����s�l��144
--------------------------------------------------------------------------------------
--��144�����񂾃t�����s�l��
function OnEvent_144(proxy,param)
	print("OnEvent_144 begin");
	
	if proxy:IsAlive( 506 ) == true then
	
		--�����ɂ��X�V�^�C�~���O�̖��ŁAEzState�ɖ��߂��͂��Ȃ��ꍇ������̂�1�t���[�������X�V
		proxy:ForceUpdateNextFrame( 506 );
		--�N���オ��A�j���Đ�
		--proxy:SetEventCommand( 506, 201 );
		proxy:PlayAnimation( 506 , 9920 );
		proxy:SetSpStayAndDamageAnimId( 506 ,-1,-1);
		--�������L���ɐݒ�
		proxy:SetColiEnable(506, true);
		--���W�b�N���ĊJ
		proxy:EnableLogic( 506, true );
		--���G��On�i���b�N�\�ɂ���j
		proxy:EnableHide( 506, false );
	end
	
	--�t���O���Z�b�g
	proxy:SetEventFlag( 144, 1 );

	print("OnEvent_144 end");
end


--------------------------------------------------------------------------------------
--���񂾃t�����s�l��145
--------------------------------------------------------------------------------------
--��145�����񂾃t�����s�l��
function OnEvent_145(proxy,param)
	print("OnEvent_145 begin");
	
	if proxy:IsAlive( 507 ) == true then
	
		--�����ɂ��X�V�^�C�~���O�̖��ŁAEzState�ɖ��߂��͂��Ȃ��ꍇ������̂�1�t���[�������X�V
		proxy:ForceUpdateNextFrame( 507 );
		--�N���オ��A�j���Đ�
		--proxy:SetEventCommand( 507, 201 );
		proxy:PlayAnimation( 507 , 9920 );
		proxy:SetSpStayAndDamageAnimId( 507 ,-1,-1);		
		--�������L���ɐݒ�
		proxy:SetColiEnable(507, true);
		--���W�b�N���ĊJ
		proxy:EnableLogic( 507, true );
		--���G��On�i���b�N�\�ɂ���j
		proxy:EnableHide( 507, false );
	end
	
	if proxy:IsAlive( 508 ) == true then
		
		--�����ɂ��X�V�^�C�~���O�̖��ŁAEzState�ɖ��߂��͂��Ȃ��ꍇ������̂�1�t���[�������X�V
		proxy:ForceUpdateNextFrame( 508 );
		--�N���オ��A�j���Đ�
		--proxy:SetEventCommand( 508, 202 );--9800
		proxy:PlayAnimation( 508 , 9800 );
		proxy:SetSpStayAndDamageAnimId( 508 ,-1,-1);
		--�������L���ɐݒ�
		proxy:SetColiEnable(508, true);
		--���W�b�N���ĊJ
		proxy:EnableLogic( 508, true );
		--���G��On�i���b�N�\�ɂ���j
		proxy:EnableHide( 508, false );
	end
	
	--�t���O���Z�b�g
	proxy:SetEventFlag( 145, 1 );
	
	--���̃C�x���g�ւ̔����̈悪2����A(�o�^ID�͓���)
	--�Е�����������ƁA�����Е��͔������Ȃ��悤�ɂ���B
	--�p�[�e�B�[�v���C���[�̊Ď����܂� �����ō폜�B
	proxy:DeleteEvent( 145 );

	print("OnEvent_145 end");
end


--------------------------------------------------------------------------------------
--���񂾃t�����s�l��146
--------------------------------------------------------------------------------------
--��146�����񂾃t�����s�l��
function OnEvent_146(proxy,param)
	print("OnEvent_146 begin");
	
	if proxy:IsAlive( 509 ) == true then	
		--�����ɂ��X�V�^�C�~���O�̖��ŁAEzState�ɖ��߂��͂��Ȃ��ꍇ������̂�1�t���[�������X�V
		proxy:ForceUpdateNextFrame( 509 );
		--�N���オ��A�j���Đ�
		--proxy:SetEventCommand( 509, 203 );--7000
		proxy:PlayAnimation( 509 , 7000 );
		proxy:SetSpStayAndDamageAnimId( 509 ,-1,-1);
		--�������L���ɐݒ�
		proxy:SetColiEnable(509, true);
		--���W�b�N���ĊJ
		proxy:EnableLogic( 509, true );
		--���G��On�i���b�N�\�ɂ���j
		proxy:EnableHide( 509, false );
	end
	
	if proxy:IsAlive( 510 ) == true then
		
		--�����ɂ��X�V�^�C�~���O�̖��ŁAEzState�ɖ��߂��͂��Ȃ��ꍇ������̂�1�t���[�������X�V
		proxy:ForceUpdateNextFrame( 510 );
		--�N���オ��A�j���Đ�
		--proxy:SetEventCommand( 510, 203 );--7000
		proxy:PlayAnimation( 510 , 7000 );
		proxy:SetSpStayAndDamageAnimId( 510 ,-1,-1);
		--�������L���ɐݒ�
		proxy:SetColiEnable(510, true);
		--���W�b�N���ĊJ
		proxy:EnableLogic( 510, true );
		--���G��On�i���b�N�\�ɂ���j
		proxy:EnableHide( 510, false );
	end
	
	--�t���O���Z�b�g
	proxy:SetEventFlag( 146, 1 );

	print("OnEvent_146 end");
end


--------------------------------------------------------------------------------------
--���񂾃t�����s�l��147
--------------------------------------------------------------------------------------
--��147�����񂾃t�����s�l��
function OnEvent_147(proxy,param)
	print("OnEvent_147 begin");
	
	if proxy:IsAlive( 511 ) == true then
	
		--�����ɂ��X�V�^�C�~���O�̖��ŁAEzState�ɖ��߂��͂��Ȃ��ꍇ������̂�1�t���[�������X�V
		proxy:ForceUpdateNextFrame( 511 );
		--�N���オ��A�j���Đ�
		--proxy:SetEventCommand( 511, 201 );
		proxy:PlayAnimation( 511 , 9920 );
		proxy:SetSpStayAndDamageAnimId( 511 ,-1,-1);
		--�������L���ɐݒ�
		proxy:SetColiEnable(511, true);
		--���W�b�N���ĊJ
		proxy:EnableLogic( 511, true );
		--���G��On�i���b�N�\�ɂ���j
		proxy:EnableHide( 511, false );
	end
	
	if proxy:IsAlive( 512 ) == true then
		
		--�����ɂ��X�V�^�C�~���O�̖��ŁAEzState�ɖ��߂��͂��Ȃ��ꍇ������̂�1�t���[�������X�V
		proxy:ForceUpdateNextFrame( 512 );
		--�N���オ��A�j���Đ�
		--proxy:SetEventCommand( 512, 202 );--9800
		proxy:PlayAnimation( 512 , 9800 );
		proxy:SetSpStayAndDamageAnimId( 512 ,-1,-1);
		--�������L���ɐݒ�
		proxy:SetColiEnable(512, true);
		--���W�b�N���ĊJ
		proxy:EnableLogic( 512, true );
		--���G��On�i���b�N�\�ɂ���j
		proxy:EnableHide( 512, false );
	end
	
	--�t���O���Z�b�g
	proxy:SetEventFlag( 147, 1 );
	
	--���̃C�x���g�ւ̔����̈悪2����A(�o�^ID�͓���)
	--�Е�����������ƁA�����Е��͔������Ȃ��悤�ɂ���B
	--�p�[�e�B�[�v���C���[�̊Ď����܂� �����ō폜�B
	proxy:DeleteEvent( 147 );

	print("OnEvent_147 end");
end


--------------------------------------------------------------------------------------
--���񂾃t�����s�l��148
--------------------------------------------------------------------------------------
--��148�����񂾃t�����s�l��
function OnEvent_148(proxy,param)
	print("OnEvent_148 begin");
	
	if proxy:IsAlive( 513 ) == true then
	
		--�����ɂ��X�V�^�C�~���O�̖��ŁAEzState�ɖ��߂��͂��Ȃ��ꍇ������̂�1�t���[�������X�V
		proxy:ForceUpdateNextFrame( 513 );
		--�N���オ��A�j���Đ�
		--proxy:SetEventCommand( 513, 203 );--7000
		proxy:PlayAnimation( 513 , 7000 );
		proxy:SetSpStayAndDamageAnimId( 513 ,-1,-1);		
		--�������L���ɐݒ�
		proxy:SetColiEnable(513, true);
		--���W�b�N���ĊJ
		proxy:EnableLogic( 513, true );
		--���G��On�i���b�N�\�ɂ���j
		proxy:EnableHide( 513, false );
	
	end
	
	if proxy:IsAlive( 514 ) == true then
		
		--�����ɂ��X�V�^�C�~���O�̖��ŁAEzState�ɖ��߂��͂��Ȃ��ꍇ������̂�1�t���[�������X�V
		proxy:ForceUpdateNextFrame( 514 );
		--�N���オ��A�j���Đ�
		--proxy:SetEventCommand( 514, 202 );--9800
		proxy:PlayAnimation( 514 , 9800 );
		proxy:SetSpStayAndDamageAnimId( 514 ,-1,-1);
		--�������L���ɐݒ�
		proxy:SetColiEnable(514, true);
		--���W�b�N���ĊJ
		proxy:EnableLogic( 514, true );
		--���G��On�i���b�N�\�ɂ���j
		proxy:EnableHide( 514, false );
		
	end
	
	if proxy:IsAlive( 515 ) == true then
		
		--�����ɂ��X�V�^�C�~���O�̖��ŁAEzState�ɖ��߂��͂��Ȃ��ꍇ������̂�1�t���[�������X�V
		proxy:ForceUpdateNextFrame( 515 );
		--�N���オ��A�j���Đ�
		--proxy:SetEventCommand( 515, 201 );
		proxy:PlayAnimation( 515 , 9920 );
		proxy:SetSpStayAndDamageAnimId( 515 ,-1,-1);
		--�������L���ɐݒ�
		proxy:SetColiEnable(515, true);
		--���W�b�N���ĊJ
		proxy:EnableLogic( 515, true );
		--���G��On�i���b�N�\�ɂ���j
		proxy:EnableHide( 515, false );
		
	end
	
	--�t���O���Z�b�g
	proxy:SetEventFlag( 148, 1 );

	print("OnEvent_148 end");
end


--------------------------------------------------------------------------------------
--���񂾃t�����s�l��149
--------------------------------------------------------------------------------------
--��149�����񂾃t�����s�l��
function OnEvent_149(proxy,param)
	print("OnEvent_149 begin");
	
	if proxy:IsAlive( 516 ) == true then
	
		--�����ɂ��X�V�^�C�~���O�̖��ŁAEzState�ɖ��߂��͂��Ȃ��ꍇ������̂�1�t���[�������X�V
		proxy:ForceUpdateNextFrame( 516 );
		--�N���オ��A�j���Đ�
		--proxy:SetEventCommand( 516, 202 );--9800
		proxy:PlayAnimation( 516 , 9800 );
		proxy:SetSpStayAndDamageAnimId( 516 ,-1,-1);
		--�������L���ɐݒ�
		proxy:SetColiEnable(516, true);
		--���W�b�N���ĊJ
		proxy:EnableLogic( 516, true );
		--���G��On�i���b�N�\�ɂ���j
		proxy:EnableHide( 516, false );
	
	end
	
	--�t���O���Z�b�g
	proxy:SetEventFlag( 149, 1 );

	print("OnEvent_149 end");
end


--------------------------------------------------------------------------------------
--���΂��U���Ă��遡150
--------------------------------------------------------------------------------------
--��150�����΂��U���Ă��遡
function OnEvent_150(proxy,param)
	print("OnEvent_150 begin");
	--���f���������ւ��ė��Ƃ�
	proxy:ChangeModel(1070,1);
	proxy:ChangeModel(1071,1);
	proxy:ChangeModel(1072,1);
	proxy:ChangeModel(1073,1);
	proxy:ChangeModel(1074,1);
	proxy:ChangeModel(1075,1);
	
	proxy:PlayTypeSE( 1070, SOUND_TYPE_O, 513005140 );
	
	--1�b��ł��炵�āA�J�n����ɕt�߂̃}�b�v�p�[�c�ɓ�����̂�h��
	proxy:OnKeyTime2( 150, "OnEvent_150_1", 1.0, 0, 1, once );

	print("OnEvent_150 end");
end

function OnEvent_150_1(proxy,param)
	print("OnEvent_150_1 begin");
	
	--������_���[�W��
	local paramid = 10040; --������_���[�W
	local rad    = 0.5;--���a(���ƂŁA�����Ȓl�ɂȂ�͂�������͓K��)
	local time   = 5; --�ЂƂ܂��A�j���Đ��I���Ń_���[�W�������̂ŁA�A�j����蒷�����Ԃ��w�肵�Ă���
	--��150_hit����1�����������Ƃ���
	--proxy:OnObjectDamageHit_NoCall( 150, 1070, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	proxy:OnObjectDamageHit( 150, 1070, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_150_1070hit", once );
	--��150_hit����2�����������Ƃ���
	--proxy:OnObjectDamageHit_NoCall( 150, 1071, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	proxy:OnObjectDamageHit( 150, 1071, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_150_1071hit", once );
	--��150_hit����3�����������Ƃ���
	--proxy:OnObjectDamageHit_NoCall( 150, 1072, 1, paramid, EV_HIT_ALL ,  rad, time,  once );	
	proxy:OnObjectDamageHit( 150, 1072, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_150_1072hit", once );
	--��150_hit����4�����������Ƃ���
	proxy:OnObjectDamageHit_NoCall( 150, 1073, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	--��150_hit����5�����������Ƃ���
	proxy:OnObjectDamageHit_NoCall( 150, 1074, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	--��150_hit����6�����������Ƃ���
	proxy:OnObjectDamageHit_NoCall( 150, 1075, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	
	proxy:OnKeyTime2( 150, "OnEvent_150_bloken", time, 0, 2, once );
	
	print("OnEvent_150_1 end");
end

function OnEvent_150_1070hit(proxy,param)
	print("OnEvent_150_1070hit begin");

	--�}�g���N�X�ړ��A���f�������ւ�<2>�A�����x�A�����C���X�^���X����
	SecondStageBreak(proxy, 1070, 2 );
	
	print("OnEvent_150_1070hit end");
end


function OnEvent_150_1071hit(proxy,param)
	print("OnEvent_150_1071hit begin");
	
	--�}�g���N�X�ړ��A���f�������ւ�<2>�A�����x�A�����C���X�^���X����
	SecondStageBreak(proxy, 1071, 2 );
	
	print("OnEvent_150_1071hit end");
end


function OnEvent_150_1072hit(proxy,param)
	print("OnEvent_150_1072hit begin");
	
	--�}�g���N�X�ړ��A���f�������ւ�<2>�A�����x�A�����C���X�^���X����
	SecondStageBreak(proxy, 1072, 2 );
	
	print("OnEvent_150_1072hit end");
end

function OnEvent_150_bloken(proxy,param)
	print("OnEvent_150_bloken begin");
	
	proxy:SetBrokenPiece(1070);
	proxy:SetBrokenPiece(1071);
	proxy:SetBrokenPiece(1072);
	proxy:SetBrokenPiece(1073);
	proxy:SetBrokenPiece(1074);
	proxy:SetBrokenPiece(1075);
	
	--�t���O���Z�b�g
	proxy:SetEventFlag( 150, true );
	
	print("OnEvent_150_bloken end");
end

--------------------------------------------------------------------------------------
--���΂��U���Ă��遡151
--------------------------------------------------------------------------------------
--��151�����΂��U���Ă��遡
function OnEvent_151(proxy,param)
	print("OnEvent_151 begin");
	--���f���������ւ��ė��Ƃ�
	proxy:ChangeModel(1064,1);
	proxy:ChangeModel(1065,1);
	proxy:ChangeModel(1066,1);
	proxy:ChangeModel(1067,1);
	proxy:ChangeModel(1068,1);
	proxy:ChangeModel(1069,1);
	
	proxy:PlayTypeSE( 1064, SOUND_TYPE_O, 513005140 );
	
	--1�b��ł��炵�āA�J�n����ɕt�߂̃}�b�v�p�[�c�ɓ�����̂�h��
	proxy:OnKeyTime2( 151, "OnEvent_151_1", 1.0, 0, 1, once );
	print("OnEvent_151 end");
end

function OnEvent_151_1(proxy,param)
	print("OnEvent_151_1 begin");
	
	--������_���[�W��
	local paramid = 10040; --������_���[�W
	local rad    = 0.5;--���a(���ƂŁA�����Ȓl�ɂȂ�͂�������͓K��)
	local time   = 5; --�ЂƂ܂��A�j���Đ��I���Ń_���[�W�������̂ŁA�A�j����蒷�����Ԃ��w�肵�Ă���
	--��151_hit����1�����������Ƃ���
	proxy:OnObjectDamageHit( 151, 1064, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_151_1064hit", once );
	--��151_hit����2�����������Ƃ���
	proxy:OnObjectDamageHit( 151, 1065, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_151_1065hit", once );
	--��151_hit����3�����������Ƃ���
	proxy:OnObjectDamageHit( 151, 1066, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_151_1066hit", once );
	--��151_hit����4�����������Ƃ���
	proxy:OnObjectDamageHit_NoCall( 151, 1067, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	--��151_hit����5�����������Ƃ���
	proxy:OnObjectDamageHit_NoCall( 151, 1068, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	--��151_hit����6�����������Ƃ���
	proxy:OnObjectDamageHit_NoCall( 151, 1069, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	
	proxy:OnKeyTime2( 151, "OnEvent_151_bloken", time, 0, 2, once );
	
	print("OnEvent_151_1 end");
end

function OnEvent_151_1064hit(proxy,param)
	print("OnEvent_151_1064hit begin");
	
	--�}�g���N�X�ړ��A���f�������ւ�<2>�A�����x�A�����C���X�^���X����
	SecondStageBreak(proxy, 1064, 2 );
	
	print("OnEvent_151_1064hit end");
end

function OnEvent_151_1065hit(proxy,param)
	print("OnEvent_151_1065hit begin");
	
	--�}�g���N�X�ړ��A���f�������ւ�<2>�A�����x�A�����C���X�^���X����
	SecondStageBreak(proxy, 1065, 2 );
	
	print("OnEvent_151_1065hit end");
end

function OnEvent_151_1066hit(proxy,param)
	print("OnEvent_151_1066hit begin");
	
	--�}�g���N�X�ړ��A���f�������ւ�<2>�A�����x�A�����C���X�^���X����
	SecondStageBreak(proxy, 1066, 2 );
	
	print("OnEvent_151_1066hit end");
end

function OnEvent_151_bloken(proxy,param)
	print("OnEvent_151_bloken begin");
	
	proxy:SetBrokenPiece(1064);
	proxy:SetBrokenPiece(1065);
	proxy:SetBrokenPiece(1066);
	proxy:SetBrokenPiece(1067);
	proxy:SetBrokenPiece(1068);
	proxy:SetBrokenPiece(1069);
	
	--�t���O���Z�b�g
	proxy:SetEventFlag( 151, true );
	
	print("OnEvent_151_bloken end");
end

--------------------------------------------------------------------------------------
--���̕ǁ�180
--------------------------------------------------------------------------------------
--��180�����̕ǁ�
function OnEvent_180(proxy,param)
	print("OnEvent_180 begin");
	

	--���d�����h�~
	if proxy:IsCompleteEvent( 180 ) == true then
		print("OnEvent_180 end");
		return;
	end
	
	--�Q�̌��̕ǂ��������Ȃ���΂����Ȃ��̂łQ�Ƃ�����	
	--proxy:DeleteObjSfxDmyPlyID( 1081, 200 );--Sfx������
	--proxy:DeleteObjSfxDmyPlyID( 1080, 200 );--Sfx������	
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 180 , 1 );
		proxy:SetEventFlag( 181 , 1 );
		print("OnEvent_180 end");
		return;
	end
	
	--�_�~�|���փ��[�v
	proxy:WarpDmy( LOCAL_PLAYER, 1080, 191 );
	
	proxy:NotNetMessage_begin();
		--��180_1�������A�j���I����
		--proxy:OnChrAnimEnd( 180, LOCAL_PLAYER, ANIMEID_WALK, "OnEvent_180_1" , once );
		proxy:LuaCallStart( 180, 1 );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 180, 1 );
	proxy:SetEventFlag( 181, 1 );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_180 end");
end

function OnEvent_180_1(proxy,param)
	print("OnEvent_180_1 begin");
	
	proxy:LuaCallStart( 180, 1 );
	
	print("OnEvent_180_1 end");
end

--�z�M�p�A�^��,�`��OFF
function OnEvent_180_181_delete(proxy,param)
	print("OnEvent_180_delete begin");
	
	proxy:DeleteEvent( 180 );
	proxy:DeleteEvent( 181 );
	
	proxy:InvalidSfx( 2125, true );
	proxy:InvalidSfx( 2126, true );
	
	proxy:SetDrawEnable( 1080, false );--�`��OFF
	proxy:SetColiEnable( 1080, false );--������OFF
	proxy:SetObjDeactivate( 1080 , true );--�f�A�N�e�B�u
	
	proxy:SetDrawEnable( 1081, false );--�`��OFF
	proxy:SetColiEnable( 1081, false );--������OFF
	proxy:SetObjDeactivate( 1081 , true );--�f�A�N�e�B�u
	
	
	print("OnEvent_180_delete end");
end

--------------------------------------------------------------------------------------
--���̕ǁ�181
--------------------------------------------------------------------------------------
--��181�����̕ǁ�
function OnEvent_181(proxy,param)
	print("OnEvent_181 begin");
	

	--���d�����h�~
	if proxy:IsCompleteEvent( 181 ) == true then
		print("OnEvent_181 end");
		return;
	end
	
	--�Q�̌��̕ǂ��������Ȃ���΂����Ȃ��̂łQ�Ƃ�����	
	--proxy:DeleteObjSfxDmyPlyID( 1081, 200 );--Sfx������
	--proxy:DeleteObjSfxDmyPlyID( 1080, 200 );--Sfx������
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 180 , 1 );
		proxy:SetEventFlag( 181 , 1 );
		print("OnEvent_181 end");
		return;
	end
	
	--�_�~�|���փ��[�v
	proxy:WarpDmy( LOCAL_PLAYER, 1081, 191 );	
	
	proxy:NotNetMessage_begin();
		--��180_1�������A�j���I����
		--proxy:OnChrAnimEnd( 180, LOCAL_PLAYER, ANIMEID_WALK, "OnEvent_181_1" , once );
		proxy:LuaCallStart( 180, 1 );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 180, 1 );
	proxy:SetEventFlag( 181, 1 );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_181 end");
end

function OnEvent_181_1(proxy,param)
	print("OnEvent_181_1 begin");
	
	proxy:LuaCallStart( 180, 1 );
	
	print("OnEvent_181_1 end");
end


--------------------------------------------------------------------------------------
--������190
--------------------------------------------------------------------------------------
--��190��������
function OnEvent_190(proxy,param)
	print("OnEvent_190 begin");
	
	proxy:ChangeModel( 1090, 1 );
	proxy:SetBrokenPiece(1090);

	--���ʉ��Đ�
	proxy:PlayTypeSE( 1090, SOUND_TYPE_O, 512000000);
	
	proxy:SetEventFlag( 190, true );
	
	
	print("OnEvent_190 end");
end


--------------------------------------------------------------------------------------
--��198,199�����s�l���̗L������
--------------------------------------------------------------------------------------
--��198,199�����s�l���̗L������
--[[
function corpse_Condition(proxy,param)
	local IsIn 		= proxy:IsCompleteEvent( 198 );
	local IsInOld 	= proxy:IsCompleteEvent( 199 );
	
	--�O�̃t���[���ƍ��̃t���[���ňႢ������ꍇ�A���̃t���[����ݒ�
	if IsIn ~= IsInOld then
		proxy:SetEventFlag( 199, IsIn );
	end
	
	--�O�̃t���[���ŒN�����Ȃ��āA���t���[���ŒN���������Ă��鎞
	if	IsIn == true and IsInOld == false then
		return true;
	end
	
	return false;
end

function corpse_Result(proxy,param)
	local count = 0;
	for index = 1, param:GetParam2(), 1 do
		if proxy:IsCompleteEvent( 200 + index - 1 ) == true then
			count = count + 1;
		end
	end
	
	for index = 1, count, 1 do
		proxy:SetDrawEnable( 10270 + index - 1, true );
		proxy:SetColiEnable( 10270 + index - 1, true );
		proxy:EnableObjTreasure( 10270 + index - 1, true );
	end
end
function corpse_ReginIn(proxy,param)
	local region_list = {2141, 2142};
	local region_num = table.getn(region_list);
	local fall_chrId_list = {300, 301, 302, 303, 304, 305, 306, 307, 308, 309,
							 310, 311, 312, 313, 314, 315, 316, 317, 318, 319,
							 320, 321, 322, 323, 324, 325, 326, 327, 328, 329,
							 330, 331, 332, 333, 334, 335, 336, 337, 338, 339,
							 340, 500, 501, 502, 503, 504, 505, 506, 507, 508,
							 509, 510, 511, 512, 513, 514, 515, 516};
	local fall_chrNum = table.getn(fall_chrId_list);
	local count = 0;
	print("corpse_ReginIn begin");
	for chr_index = 1, fall_chrNum, 1 do
		for region_index = 1, region_num, 1 do
			if	proxy:IsRegionIn( fall_chrNum[chr_index], region_list[region_index] ) == true then
				count = count + 1;
			end
		end
	end
	
	for index = 1, count, 1 do
		if	index > 10 then
			return;
		end
		proxy:SetDrawEnable( 10270 + index - 1, true );
		proxy:SetColiEnable( 10270 + index - 1, true );
		proxy:EnableObjTreasure( 10270 + index - 1, true );
	end
end
]]

function corpseCheck(proxy,param)
	print("corpseCheck begin");
	--�z�X�g�݂̂��L�b�N����
	if proxy:IsClient() == true then
		print("corpseCheck return end");
		return;
	end
	proxy:LuaCallStart( 199, 2 );
	print("corpseCheck end");
end

function corpseUpdate(proxy,param)
	print("corpseUpdate begin");
	local fall_counter = 0;
	
	for actId = 200, 256, 1 do
		if	proxy:IsCompleteEvent( actId ) == true then
			fall_counter = fall_counter + 1;
		end
	end
	for index = 1, 10, 1 do
		if fall_counter > index + 1 then
			print("�󎀑̗L����",10270 + index - 1);
			proxy:SetDrawEnable( 10270 + index - 1, true );
			proxy:SetColiEnable( 10270 + index - 1, true );
			proxy:EnableObjTreasure( 10270 + index - 1, true );
		end
	end
	print("corpseUpdate end");
end
--------------------------------------------------------------------------------------
--��200�`256�����s�l�]������
--------------------------------------------------------------------------------------
--��200�`256�����s�l�]������
--[[
function fall_Condition(proxy,param)
	local region_list = {2141, 2142};
	local region_num = table.getn(region_list);
	for index = 1, region_num, 1 do
		if proxy:IsRegionIn( param:GetParam2(), region_list[index] ) == true then
			--�̈�̒��ɓ����Ă���̂Ő���
			return true;
		end
	end
	return false;
end

function fall_result(proxy,param)
	--�t���O�𗧂ĂĂ���
	proxy:SetEventFlag( param:GetParam1(), true );
end
]]
function fall_countup(proxy,param)
	--���A�N�V����ID�A�ʗ̈�ő΂ɓo�^����Ă���̂ŁA�����Е����폜
	proxy:DeleteEvent(param:GetParam1());
	--�t���O�𗧂ĂĂ���
	proxy:SetEventFlag( param:GetParam1(), true );
end

--[[
function OnEvent_270(proxy,param)
	print("OnEvent_270 begin");
	SetNpcStateFlag( proxy, param, kojiki_m50_flag_list, KOJIKI_M50_STATE_ANGRY );
	proxy:SetEventFlag( 270, true );
	print("OnEvent_270 end");
end

function OnEvent_271(proxy,param)
	print("OnEvent_271 begin");
	SetNpcStateFlag( proxy, param, kojiki_m50_flag_list, KOJIKI_M50_STATE_DEAD );
	proxy:SetEventFlag( 271, true );
	
	--���S�����̂œG�ΊĎ�������
	proxy:DeleteEvent( 270 );
	print("OnEvent_271 end");
end
]]

--------------------------------------------------------------------------------------
--��167���{�X�J�����؂�ւ��C�x���g��
--------------------------------------------------------------------------------------
function OnEvent_167(proxy,param)
	--print("OnEvent_167 begin");
	--�{�X������ł��Ȃ��@���@�{�X�Ƃ̐퓬���J�n���Ă���
	if proxy:IsCompleteEvent( 808 ) == false and proxy:IsCompleteEvent( 163 ) == true then
		--�{�X��@�񃍃b�N�J����
		proxy:SetCamModeParamTargetId(5011);
		--�{�X��@���b�N�J����
		proxy:SetCamModeParamTargetIdForBossLock(5010);
	end
	--print("OnEvent_167 end");
end

--------------------------------------------------------------------------------------
--��281���ŏ��̗v�΂̌��������遡
--------------------------------------------------------------------------------------

function OnEvent_281(proxy, param)
	print("OnEvent_281 begin");
	
	proxy:TreasureDispModeChange2( 1983 , false ,KANAME_SFX);
	
	print("OnEvent_281 end");
end


--------------------------------------------------------------------------------------
--��282���ŏ��̗v�΂̌����������遡
--------------------------------------------------------------------------------------

function OnEvent_282(proxy, param)
	print("OnEvent_282 begin");
	
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	
	print("OnEvent_282 end");
end

--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m05_00_00_00(proxy, param)
	print("PlayerDeath_m05_00_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m05_00_00_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerDeath_m05_00_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m05_00_00_00(proxy,param)
	print("PlayerRevive_m05_00_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m05_00_00_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerRevive_m05_00_00_00");
end

------------------------------
--��H(��)�V���b�v�̏�ԕω�--
------------------------------
--����H(��)���s��1�œG�΂��遥--
function OnEvent_270(proxy, param)
	print("OnEvent_270 begin");

	--���W�b�NOn
	proxy:EnableLogic( 650, true );
	
	--��H(��)�̏�Ԃ�G��(�s��1)�ɂ���
	SetNpcStateFlag(proxy, param, Kojiki_Shop_Flag_list, KOJIKI_FEMALE_SHOP_HOSTILE01 );
	--��H(��)�̃`�[���^�C�v��ύX����
	proxy:SetTeamType( 650, TEAM_TYPE_AngryFriend );

	--�t���O�𗧂Ă�
	proxy:SetEventFlag( 270, true );
	
	print("OnEvent_270 end");
end
--��-------------------------��--


--����H(��)�����S����(�s��1)��--
function OnEvent_271(proxy, param)
	print("OnEvent_271 begin");

	--��H(��)�̏�Ԃ��u���S�v�ɕς���
	SetNpcStateFlag( proxy, param, Kojiki_Shop_Flag_list, KOJIKI_FEMALE_SHOP_DEAD );
	
	--�t���O�𗧂Ă�
	proxy:SetEventFlag( 271, true );
	
	--�G�ɍ���ēG�΂�ʂ�z���Ď��S�����肦��̂ŁA�����ł��폜
	--���񂾂�G�΂ɂ͂Ȃ�Ȃ��̂ō폜
	proxy:DeleteEvent( 270 );
	proxy:DeleteEvent( 810 );

	print("OnEvent_271 end");
end
--��-------------------------��--


function OnEvent_272(proxy, param) proxy:LuaCallStart(812, 1); end
function OnEvent_273(proxy, param) proxy:LuaCallStart(812, 1); end
function OnEvent_275(proxy, param) proxy:LuaCallStart(812, 1); end

function OnEvent_812(proxy, param)
	print("OnEvent_812 begin");
	print("JustInCheckPoint");
	
	local KojikiShop01_id = 650;
	local KojikiShop02_id = 677;
	
	local KojikiShopBlock1_acid_list = {274,270,271};
	local KojikiShopBlock2_acid_list = {810,811};
	
	--��U2�̂Ƃ�������
	InvalidCharactor(proxy,KojikiShop01_id);
	InvalidCharactor(proxy,KojikiShop02_id);
	
	if proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork( KojikiShop01_id);
		proxy:RequestForceUpdateNetwork( KojikiShop02_id);
	end
	
	--�u���b�N�̊Ď����폜
	DeleteConditionList(proxy,KojikiShopBlock1_acid_list);
	DeleteConditionList(proxy,KojikiShopBlock2_acid_list);
	
	
	--��肠����������Ԃ�ݒ�
	SetFirstNpcStateFlag( proxy, param, Kojiki_Shop_Flag_list, KOJIKI_FEMALE_SHOP_SELL01 );
	
	
	--��H(��)���s��2�Ɉړ�����
	if proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_SELL01 ) == true then
		print("KojikiShop NowState KOJIKI_FEMALE_SHOP_SELL01");
		SetKojikiShopState01(proxy, param);
		KojikiRegistConditionBlock01(proxy,param);

	--��H(��)���s��1�œG��
	elseif proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_HOSTILE01 ) == true then
		print("KojikiShop NowState KOJIKI_FEMALE_SHOP_HOSTILE01");
		SetKojikiShopState02(proxy, param);
		KojikiRegistConditionBlock01(proxy,param);

	--��H(��)�����S����
	elseif proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_DEAD ) == true then
		print("KojikiShop NowState KOJIKI_FEMALE_SHOP_DEAD");
		SetKojikiShopState03(proxy, param);
		KojikiRegistConditionBlock01(proxy,param);

	--��H(��)���s��2�Ŕ̔���
	elseif proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_SELL02 ) == true then
		print("KojikiShop NowState KOJIKI_FEMALE_SHOP_SELL02");
		SetKojikiShopState04(proxy, param);
		KojikiRegistConditionBlock02(proxy,param);

	--��H(��)���s��2�œG�΂��Ă���
	elseif proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_HOSTILE02 ) == true then
		print("KojikiShop NowState KOJIKI_FEMALE_HOSTILE02");
		SetKojikiShopState05(proxy, param);
		KojikiRegistConditionBlock02(proxy,param);

	end

	print("OnEvent_812 end");
end


--����H(��)���̔����Ă���(�s��1)��-----------------------------------------
function SetKojikiShopState01( proxy, param )
	--�g�f�[�����������Ă���
	if proxy:IsCompleteEvent( 5650 ) == false then
		ValidCharactor(proxy,650);--�s��1�ɂ����H(��)��L����
	
	--�g�f�[����������ł���
	else
		print("KojikiShop NowState KOJIKI_FEMALE_SHOP_SELL01 > Chenge to KOJIKI_FEMALE_SHOP_SELL02");
		InvalidBackRead(proxy,650);--�s��1�ɂ����H(��)�𖳌���
		ValidCharactor(proxy,677);--�s��2�ɂ����H(��)��L����
		
		--���W�b�NOFF�ɂ���
		--proxy:EnableLogic( 677, false );
		
		--��H(��)�̏�Ԃ��u�̔�(�s��2)�v�ɕς���
		SetNpcStateFlag( proxy, param, Kojiki_Shop_Flag_list, KOJIKI_FEMALE_SHOP_SELL02 );
	end
end
--��-----------------------------��-----------------------------------------


--����H(��)���G�΂��Ă���(�s��1)��-------------------------
function SetKojikiShopState02( proxy, param )
	ValidCharactor(proxy,650);--�s��1�ɂ����H(��)��L����
	InvalidBackRead(proxy,677);--�s��2�ɂ����H(��)�𖳌���
	--��H(��)�̃`�[���^�C�v��ύX����
	proxy:SetTeamType( 650, TEAM_TYPE_AngryFriend );
end
--��-----------------------------��-------------------------


--����H(��)�����S����(�s��1)��-------------------------------------
function SetKojikiShopState03( proxy, param )
	InvalidBackRead(proxy,650);--�s��1�ɂ����H(��)�𖳌���
	InvalidBackRead(proxy,677);--�s��2�ɂ����H(��)�𖳌���
end
--��-------------------------��-------------------------------------


--����H(��)���̔����Ă���(�s��2)��-----------------------------------------
function SetKojikiShopState04( proxy, param )
	InvalidBackRead(proxy,650);--�s��1�ɂ����H(��)�𖳌���
	ValidCharactor(proxy,677);--�s��2�ɂ����H(��)��L����
end
--��-------------------------��-------------------------------------


--����H(��)���G�΂��Ă���(�s��2)��-------------------------
function SetKojikiShopState05( proxy, param )
	InvalidBackRead(proxy,650);--�s��1�ɂ����H(��)�𖳌���
	ValidCharactor(proxy,677);--�s��2�ɂ����H(��)��L����
	--��H(��)�̃`�[���^�C�v��ύX����
	proxy:SetTeamType( 677, TEAM_TYPE_AngryFriend );
end
--��-----------------------------��-------------------------


--����H(��)�̏�ԑJ��(�s��1)��--------------------------------------------------------------------------------------
function KojikiRegistConditionBlock01(proxy, param)
	--��H(��)������ł��Ȃ�
	if proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_DEAD ) == false then
		--��H(��)���s��1,2�̂�����ł��G�΂��Ă��Ȃ��ꍇ
		if proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_HOSTILE01 ) == false
		   and proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_HOSTILE02 ) == false then
			--�z�X�g����̃_���[�W�Ď�
			--m05_00
			--proxy:OnCharacterTotalDamage( 270, 650, LOCAL_PLAYER, KojikiShop_TotalDamage, "OnEvent_270", once );
			proxy:OnCharacterTotalRateDamage( 270, 650, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_270", once );
			--m05_01
			--proxy:OnCharacterTotalDamage( 810, 677, LOCAL_PLAYER, KojikiShop_TotalDamage, "OnEvent_810", once );
			proxy:OnCharacterTotalRateDamage( 810, 677, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_810", once );
		end
		proxy:OnCharacterDead( 271, 650, "OnEvent_271", once );
	end
end
--��------------------��--------------------------------------------------------------------------------------


--����H(��)�̏�ԑJ��(�s��2)��-------------------------------------------------------------------------------
function KojikiRegistConditionBlock02(proxy, param)
	--��H(��)������ł��Ȃ�
	if proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_DEAD ) == false then
		--��H(��)���s��1,2�̂�����ł��G�΂��Ă��Ȃ��ꍇ
		if proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_HOSTILE01 ) == false
		   and proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_HOSTILE02 ) == false then
			--�z�X�g����̃_���[�W�Ď�
			--m05_00
			--proxy:OnCharacterTotalDamage( 270, 650, LOCAL_PLAYER, KojikiShop_TotalDamage, "OnEvent_270", once );
			proxy:OnCharacterTotalRateDamage( 270, 650, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_270", once );
			--m05_01
			--proxy:OnCharacterTotalDamage( 810, 677, LOCAL_PLAYER, KojikiShop_TotalDamage, "OnEvent_810", once );
			proxy:OnCharacterTotalRateDamage( 810, 677, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_810", once );
		end
		proxy:OnCharacterDead( 811, 677, "OnEvent_811", once );
	end
end
--��------------------��--------------------------------------------------------------------------------------


-----------------------------------------------------------------------------
--���������g�J�Q�C�x���g
-----------------------------------------------------------------------------
--�{�X���j���̃g�J�Q���Z�b�g�p
function ResetTokage(proxy)
	print("ResetTokage");
	--proxy:SetEventFlag(310,false);
	--proxy:SetEventFlag(830,false);
	--proxy:SetEventFlag(1140,false);			
	AddEventCounter(proxy,15);
	AddEventCounter(proxy,16);
	AddEventCounter(proxy,17);
end

-----------------------------------------------------------------------------
--��310�������g�J�Q�C�x���g1
-----------------------------------------------------------------------------
function OnEvent_310(proxy,param)
	print("OnEvent_310 begin");
	proxy:SetEventFlag( 310, true);
	proxy:DeleteEvent( 310 );
	print("OnEvent_310 end");
end

-----------------------------------------------------------------------------
--��830�������g�J�Q�C�x���g2
-----------------------------------------------------------------------------
function OnEvent_830(proxy,param)
	print("OnEvent_830 begin");
	proxy:SetEventFlag( 830, true);
	proxy:DeleteEvent( 830 );
	print("OnEvent_830 end");
end

-----------------------------------------------------------------------------
--��1140�������g�J�Q�C�x���g3
-----------------------------------------------------------------------------
function OnEvent_1140(proxy,param)
	print("OnEvent_1140 begin");
	proxy:SetEventFlag( 1140, true);
	proxy:DeleteEvent( 1140 );
	print("OnEvent_1140 end");
end


-----------------------------------------------------------------------------
--��24��QWC�n�V�S�̐�ɐi��
-----------------------------------------------------------------------------
function OnEvent_24(proxy,param)
	print("OnEvent_24 begin");
	proxy:SetEventFlag( 24,true );
	print("OnEvent_24 end");
end


--���_�j�_���[�W
function OnEvent_320(proxy,param)
	print("OnEvent_320 begin");
	proxy:EnableLogic( 520, true );
	proxy:SetEventFlag( 320 , true );
	print("OnEvent_320 end");
end

--���_�j�_���[�W
function OnEvent_321(proxy,param)
	print("OnEvent_321 begin");
	proxy:EnableLogic( 521, true );
	proxy:SetEventFlag( 321 , true );
	print("OnEvent_321 end");
end

--���_�j�_���[�W
function OnEvent_322(proxy,param)
	print("OnEvent_322 begin");
	proxy:EnableLogic( 522, true );
	proxy:SetEventFlag( 322 , true );
	print("OnEvent_322 end");
end

--���_�j�_���[�W
function OnEvent_323(proxy,param)
	print("OnEvent_323 begin");
	proxy:EnableLogic( 523, true );
	proxy:SetEventFlag( 323 , true );
	print("OnEvent_323 end");
end

--���_�j�_���[�W
function OnEvent_324(proxy,param)
	print("OnEvent_324 begin");
	proxy:EnableLogic( 524, true );
	proxy:SetEventFlag( 324 , true );
	print("OnEvent_324 end");
end

--���_�j�_���[�W
function OnEvent_325(proxy,param)
	print("OnEvent_325 begin");
	proxy:EnableLogic( 525, true );
	proxy:SetEventFlag( 325 , true );
	print("OnEvent_325 end");
end

