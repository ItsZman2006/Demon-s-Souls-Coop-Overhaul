
FIREDAM_WAIT = 2.0;

--���h�����̏�Ԉꗗ
DORAN_STATE_GUARD 		= 16280;--��_�����
DORAN_STATE_ALLOWED		= 16281;--�����Ă��ꂽ
DORAN_STATE_NOT_ALLOWED	= 16282;--���������Ȃ�
DORAN_STATE_DEAD		= 16283;--���S

doran_flag_list = {
	DORAN_STATE_GUARD 		,
	DORAN_STATE_ALLOWED 	,
	DORAN_STATE_NOT_ALLOWED ,
	DORAN_STATE_DEAD 
};

--�z�ꕺ�m�V���b�v�̏�Ԉꗗ
DOREISOL_SHOP_SELL01	= 16083;	--�ړ�������(����1)
DOREISOL_SHOP_HOSTILE01 = 16084;	--�G��(����1)
DOREISOL_SHOP_DEAD		= 16082;	--���S
DOREISOL_SHOP_SELL02	= 16080;	--�ړ�������(����2)
DOREISOL_SHOP_HOSTILE02 = 16081;	--�G��(����2)
DOREISOL_SHOP_SELL03	= 16085;	--�ړ�������(����3)
DOREISOL_SHOP_HOSTILE03 = 16086;	--�G��(����3)

DOREISOL_SHOP_Flag_list = {
	DOREISOL_SHOP_SELL01,
	DOREISOL_SHOP_HOSTILE01,
	DOREISOL_SHOP_DEAD,
	DOREISOL_SHOP_SELL02,
	DOREISOL_SHOP_HOSTILE02,
	DOREISOL_SHOP_SELL03,
	DOREISOL_SHOP_HOSTILE03
}

--�z�ꕺ�m�̃V���b�v���G�΂��邽�߂̃_���[�W�l
DoreiShop_TotalDamage = 100;


--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉����������
--------------------------------------------------------------------------------------
function Initialize_m02_00_00_00(proxy)
	print("Initialize_m02_00_00_00 begin");
	
	proxy:LuaCall( 99999 , 0 , "OnEvent_4000_Hp_1",everytime);
--��0�����J�����o�[��--PC���C�x���g�G���A(1000)�̒��ɋ���(1.5m)�L���p(30�x��)�ŃA�N�V�����{�^����������
		
	--�{�X�������Ă���Ƃ������Ď��ǉ�
	if proxy:IsCompleteEvent( 4096 ) == false then	
		if proxy:IsCompleteEvent( 0 ) ==false then
			proxy:OnDistanceAction( 0, LOCAL_PLAYER, 1000, "OnEvent_0", LeverDist_A, HELPID_PULL_LEVER, 0, LeverAngle_A, once);
			proxy:LuaCall(0,1,"OnEvent_0_4",once);
			proxy:NotNetMessage_begin();
				proxy:LuaCall(0,REMO_START,"OnEvent_0_RemoStart",once);
				proxy:LuaCall(0,REMO_FINISH,"OnEvent_0_RemoFinish",once);
			proxy:NotNetMessage_end();
			proxy:SetDrawEnable( 1008 , false );
			proxy:SetColiEnable( 1008 , false );
		else
			proxy:EndAnimation( 1000, 1 );--���o�[�A�j�����I��
			proxy:EndAnimation( 1001, 1 );--���傪�J���A�j�����I��
			proxy:EndAnimation( 1140, 1 );--�M�A�������A�j�����I��
		end
	else
		proxy:EndAnimation( 1000, 1 );--���o�[�A�j�����I��
		proxy:EndAnimation( 1001, 1 );--���傪�J���A�j�����I��
		proxy:EndAnimation( 1140, 1 );--�M�A�������A�j�����I��
	end
	
--��4096��������ւ̔��J�������{�X���S��--
	proxy:AddFieldInsFilter( 800 );
	if proxy:IsCompleteEvent( 4096 ) ==false then		
		proxy:OnCharacterDead(4096, 800, "OnEvent_4096", once);
	else
		proxy:EndAnimation( 1002, 1 );
	end
	

--��10�����o�[����ŏ�哃�E�̔��J����--PC���C�x���g�G���A(1005)�̒��ɋ���(1.5m)�L���p(30�x��)�ŃA�N�V�����{�^����������
	if proxy:IsCompleteEvent( 10 ) ==false then
		--���J���z�M�p
		--�A�N�V�����Ď��ǉ�
		proxy:OnDistanceAction( 10, LOCAL_PLAYER, 1005, "OnEvent_10", LeverDist_A, HELPID_PULL_LEVER, 0, LeverAngle_A, once);
		
	else
		proxy:EndAnimation( 1003, 1 );--���A�j�����I��
		proxy:EndAnimation( 1005, 1 );--���o�[�A�j�����I��
	end

--��110���{�X�����ɓ��遡
	
	--���{�X�������Ă���Ƃ������C�x���g�o�^
	if proxy:IsCompleteEvent( 4096 ) == false then
	
		--�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B
		SingleReset(proxy, 110);
	
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���)
		proxy:LuaCall( 111, 1, "OnEvent_111_1", everytime );
		
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCall( 111 , 5 , "OnEvent_110_GO_TO_IN" , everytime );
		
		--���t���O�Z�b�g(�����p)
		proxy:LuaCall( 111 , 6 , "OnEvent_110_flag_set" , everytime );
		
		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ�
		if proxy:IsCompleteEvent( 110 ) == false then
		
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l����
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--��110�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegionAttribute( 110, 2895, "OnEvent_110", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
		
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B
		
			proxy:NotNetMessage_begin();
				--��111�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegion( 111, 2895, "OnEvent_110", HELPID_GO_TO_IN, everytime );--�n���h���͏�Ɠ���
			proxy:NotNetMessage_end();
		
		end

		--��荇�����t�@�����N�X�����̂ݑΉ�
		--�{�X�p�A�^���؂�ւ�
		print("�{�X�����A�^���{�X�p");
		proxy:SetColiEnableArray(3010,false);--�ʏ햳��		
		proxy:SetColiEnableArray(3002,true);--�{�X�p�L��
		proxy:SetColiEnableArray(3001,true);--�{�X�p�L��		
		
	else
		--��荇�����t�@�����N�X�����̂ݑΉ�
		--�{�X�p�A�^���؂�ւ�
		print("�{�X�����A�^���ʏ�");
		proxy:SetColiEnableArray(3010,true);--�ʏ�L��		
		proxy:SetColiEnableArray(3002,false);--�{�X�p����
		proxy:SetColiEnableArray(3001,false);--�{�X�p����
	end

	
--��114���{�X�퓬�J�n��	
	if proxy:IsCompleteEvent( 4096 ) == false then
		proxy:OnRegionJustIn( 114 , LOCAL_PLAYER , 2887 , "OnEvent_114" , once );
		proxy:LuaCall( 114 , 10 , "OnEvent_114_1",everytime);
	end	
	
	--[[
	proxy:NotNetMessage_begin();
		proxy:OnRegionJustIn( 450, LOCAL_PLAYER , 2887 , "OnEvent_450_In",everytime );
		proxy:OnRegionJustOut( 450 , LOCAL_PLAYER , 2887 , "OnEvent_450_Out",everytime );
	proxy:NotNetMessage_end();
	]]
	
--��50�����o�[�Ή����i���j��PC���C�x���g�G���A(1006)����(1.5m)�����p(180�x��)�ŃA�N�V�����{�^����������
	if proxy:IsCompleteEvent( 50 ) ==false then
		--�A�N�V�����Ď��ǉ�
		proxy:OnDistanceAction( 50, LOCAL_PLAYER, 1006, "OnEvent_50", LeverDist_A, HELPID_PULL_LEVER, 0, LeverAngle_A ,once);
	else
		proxy:EndAnimation( 1004, 1 );--���A�j�����I��
		proxy:EndAnimation( 1006, 1 );--���o�[�A�j�����I��
	end

--��70���Β��Ƀ��[�v��
	SingleReset(proxy,70);
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	proxy:OnDistanceAction( 70 , LOCAL_PLAYER , 1983 , "OnEvent_70" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180, everytime );


--�J���X�C�x���g�����s�[�g�����邽�߂�SingleReset()
	local actionId_list = { 350 , 351 ,353 , 354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375};	
	local num = table.getn( actionId_list );
	for IndexID = 1, num , 1 do
		SingleReset(proxy, actionId_list[ IndexID ]);
	end

--�J���X���o�b���߂Â��Ɣ�ї���
	for KarasuID = 1, num, 1 do
		if proxy:IsCompleteEvent( actionId_list[ KarasuID ] ) == false then
			proxy:OnPlayerDistanceInTarget( actionId_list[ KarasuID ], LOCAL_PLAYER, 740 + actionId_list[KarasuID], "OnEvent_"..actionId_list[KarasuID], 5, once );
		else
			proxy:SetDrawEnable(740 + actionId_list[KarasuID], false);
			proxy:SetColiEnable(740 + actionId_list[KarasuID], false);		
		end
	end

--��90�����ǂ��󂵂ēG����яo���Ă��遡
	
	--[[2008.06.28/toyohide �Ƃ肠����
	if proxy:IsCompleteEvent( 90 ) == false then
		proxy:OnRegionJustIn( 90, LOCAL_PLAYER, 2040, "OnEvent_90" , once );
	else
		proxy:EndAnimation( 1120 , 1 );
	end
	]]
	proxy:EndAnimation( 1120 , 1 );
	
--��91�����ǂ��󂵂ēG����яo���Ă���2��
	if proxy:IsCompleteEvent( 91 ) == false then
		proxy:SetSuperArmor( 215 , true );
		proxy:SetSuperArmor( 216 , true );
		proxy:OnRegionJustIn( 91, LOCAL_PLAYER, 2041, "OnEvent_91" , once );
	else
		proxy:EndAnimation( 1121 , 1 );
		proxy:EndAnimation( 1122 , 1 );
	end


	
--��180����ʕ��m���~��Ă��遡
	if proxy:IsCompleteEvent( 180 ) == false then
		proxy:SetSuperArmor( 211 , true );
		proxy:SetSuperArmor( 206 , true );
		proxy:OnRegionJustIn( 180 , LOCAL_PLAYER , 2100 , "OnEvent_180" , once );--�̈�p
		proxy:OnSimpleDamage( 182 , 211 , LOCAL_PLAYER , "OnEvent_180_00" , once );--�U���󂯂��p(ID:211) ��ID
		proxy:OnSimpleDamage( 183 , 206 , LOCAL_PLAYER , "OnEvent_180_01" , once );--�U���󂯂��p(ID:206) ��ID
	else

	end
	
	
--��200�����Y��ւ̔���
	SingleReset(proxy,200);
	if proxy:IsClient() == false then
		if	proxy:IsSuccessQWC(20600) == true or 
			proxy:IsSuccessQWC(20300) == true or 
			proxy:IsCompleteEvent(201) == true then
			proxy:SetEventFlag( 200, true );	
		end
	end
	
	if proxy:IsCompleteEvent( 200 ) == false then
		--[[
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 200, LOCAL_PLAYER, 1040, "OnEvent_200", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, everytime ); 
		proxy:NotNetMessage_end();	
		proxy:LuaCall( 200, 1, "OnEvent_200_1", once );--�A�j���[�V���������p
		]]
	else
		proxy:EndAnimation( 1040, 1 );
	end
	
--��201�����Y��̔��𒴂�����
	if proxy:IsCompleteEvent( 201 ) == false then
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionIn( 201 , 10000 , 2020 , "OnEvent_201",once);
			proxy:NotNetMessage_end();
		end
	else
	
	end
	
--��210����_�ւ̔���
	--[[
	if proxy:IsCompleteEvent( 210 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 210, LOCAL_PLAYER, 1045, "OnEvent_210", DoorDist_A, HELPID_OPEN, 0, DoorAngle_A, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 210, 1, "OnEvent_210_1", once );--�A�j���[�V���������p
	else
		proxy:EndAnimation( 1045, 1 );
	end
	]]

--��211����_�ւ̔�2��
	if proxy:IsCompleteEvent( 211 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 211, LOCAL_PLAYER, 1047, "OnEvent_211", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 211, 1, "OnEvent_211_1", once );--�A�j���[�V���������p
	else
		proxy:EndAnimation( 1047, 1 );
	end

--��5����_�̍Ւd��
	if proxy:IsCompleteEvent( 5 ) == false then
		--�h���������ɋ����Ă���
		if proxy:IsCompleteEvent( 330 ) == true then
	
			--���ׂ�C�x���g���͓̂������܂��A���ׂ��l�̓z�X�gor�V���O���v���C���[�ł�
			--proxy:NotNetMessage_begin();
				--�z�X�g�A�����A�O���C�̂ݒ��ׂ邱�Ƃ��ł���
				local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
				--HELPID���f�����u�����h��p�ɂȂ���
				proxy:OnDistanceActionAttribute( 5 , LOCAL_PLAYER , 1192 , "OnEvent_5" , ItemBoxDist_A , 10010130 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
				proxy:LuaCall( 5,1,"OnEvent_5_2",once);
				proxy:LuaCall( 5,2,"OnEvent_5_3",once);
				proxy:TreasureDispModeChange2( 1192, true ,KEN_SFX);
				--proxy:SetRarity( 1192, 10104 );
			--proxy:NotNetMessage_end();
		end
	else
		proxy:SetDrawEnable( 1192 , false );--�ЂƂ܂��`�悾��OFF
		proxy:SetColiEnable( 1192 , false );
		
		proxy:InvalidSfx( 1192, false );
	end	
	--proxy:TreasureDispModeChange( 1192, true );
	--proxy:SetRarity( 1192, 10104 );
	
--��35��QWC�ɂ��򗳂̖�����
	SingleReset(proxy,35);
	if	proxy:IsSuccessQWC(20400 ) == true then
		proxy:SetEventFlag( 35, true );
	end
	if	proxy:IsCompleteEvent( 35 ) == false then
		--��232���̈�Ď����w��̈�Ƀv���C���[���ЂƂ�ł�����ꍇ�t���OON/�N�����Ȃ��ꍇ�t���OOFF
			proxy:OnNetRegion( 222, 2039 );
			proxy:OnNetRegion( 223, 2131 );
			proxy:OnNetRegion( 224, 2132 );
			proxy:OnNetRegion( 225, 2133 );
	else
		--�򗳖�����
		--InvalidCharactor(proxy, 300);
		--InvalidCharactor(proxy, 301);
	end
	
	
	
	--���������������������򗳂̃l�b�g���[�N�ʒu�񓯊��ݒ聙������������������
	proxy:SetNoNetSync(300,true);
	proxy:SetNoNetSync(501,true);
	proxy:SetNoNetSync(301,true);
	proxy:SetNoNetSync(110,true);
	--������������������������������������������������������������������������	
--��236���򗳂��ő��̕\���ؑ�
	--proxy:OnRegionJustIn( 236, LOCAL_PLAYER, 2190, "HiryuKenzokuCheck", everytime );
	--proxy:OnRegionJustIn( 236, LOCAL_PLAYER, 2191, "HiryuKenzokuCheck", everytime );
	--[[
	�A�T�[�g����ׁ̈A����o�^�Ƀ_�~�[�o�^
	]]
	proxy:LuaCall( 199, 1, "dummy", everytime );
	proxy:LuaCall( 221, 1, "dummy", everytime );
	proxy:LuaCall( 221, 2, "dummy", everytime );
	proxy:LuaCall( 190, 1, "dummy", everytime );
	proxy:LuaCall( 190, 2, "dummy", everytime );
	proxy:LuaCall( 191, 1, "dummy", everytime );
	proxy:LuaCall( 191, 2, "dummy", everytime );
	proxy:LuaCall( 230, 1, "dummy", everytime );
	proxy:LuaCall( 230, 2, "dummy", everytime );
	proxy:LuaCall( 231, 1, "dummy", everytime );
	proxy:LuaCall( 231, 2, "dummy", everytime );
	proxy:LuaCall( 232, 1, "dummy", everytime );
	proxy:LuaCall( 232, 2, "dummy", everytime );
	proxy:LuaCall( 800 , 1 , "dummy"   , everytime );--�ҋ@
	proxy:LuaCall( 800 , 2 , "dummy" , everytime );--�ҋ@2
	proxy:LuaCall( 800 , 3 , "dummy" , everytime );--���S�ҋ@
	proxy:LuaCall( 801 , 1 , "dummy" , everytime );--�u���XA
	proxy:LuaCall( 802 , 1 , "dummy" , everytime );--�u���XB
	proxy:LuaCall( 803 , 1 , "dummy" , everytime );--�u���XC
	proxy:LuaCall( 804 , 1 , "dummy" , everytime );--�w���w��
	proxy:LuaCall( 806 , 1 , "dummy" , everytime );--���S		
--��807���򗳂��ő��̕\���ؑ�
	--proxy:OnRegionJustIn( 807, LOCAL_PLAYER, 2390, "HiryuKenzokuCheck", everytime );
	--proxy:OnRegionJustIn( 807, LOCAL_PLAYER, 2391, "HiryuKenzokuCheck", everytime );
	proxy:NotNetMessage_begin();
	--	proxy:LuaCall( 236, 2, "HiryuKenzokuCheck", once );
	proxy:CustomLuaCall( 4060, "HiryuKenzokuCheck", everytime );
	proxy:NotNetMessage_end();
	--��悸�A����P����Ƃ����ݒ�ɂ��Ă���
	--���R�Ƃ��Ă͉���P����Ȃ�`�F�b�N�|�C���g���o�R�����ɔ򗳂ɉ���Ƃ��N����ɂ����ׂł��B
	--�����ȑΉ��́A�u���b�N�ړ��������ɌĂяo���n���h����p�ӂ��āA
	--�`�F�b�N�|�C���g�𖳎������ȈՃo�b�N���[�h�I�ȍ�肪�ǂ��Ǝv���܂��B
	--�u���b�N���Ƃɓǂݍ��݂�؂�ւ���̂́A
	--�򗳂���Ƀo�b�N���[�h�������X�V�ׁ̈A�֌W�Ȃ��ꏊ�ŃC�x���g�������̂�h���̂���ȗ��R�ł��B
	--proxy:LuaCallStartPlus( 236, 2, 2190 );

--��258���z�ꕺ�m�������h�����q��_���̂���߂�
	--(��Ԕ��蕔���ŊĎ��ǉ�)
	

--��391�`409���M����(��)��
--��421�`430���M����(��)��
	TaruRegist( proxy,param);
--��6�����m���Ή��r�𓊂��遡
	ThrowFirePotRegist_b1(proxy);
	
--��251�`256���z�ꕺ�m�̎��S�Ď�(�����h�����q����)
	DoreiRegist_block1(proxy);
	
	

--��280���݂邳�ꂽ����1���������遡
	if proxy:IsCompleteEvent( 280 ) == false then
		proxy:OnObjectDestroy( 280 , 1172 , "OnEvent_280" , once );--�݂邵�Ă���R�̔j��Ď�
	else
		proxy:EndAnimation( 10240 , 1000 );--���̂̂ق��̃A�j�����I��
	end

	
--��281���݂邳�ꂽ����2���������遡
	if proxy:IsCompleteEvent( 281 ) == false then
		proxy:OnObjectDestroy( 281 , 1174 , "OnEvent_281" , once );--�݂邵�Ă���R�̔j��Ď�
	else
		proxy:EndAnimation( 10241 , 1000 );--���̂̂ق��̃A�j�����I��
	end

	
--
--��285���C�e�S���S����
	SingleReset( proxy, 285 );
	if proxy:IsCompleteEvent( 285 ) == false then
		proxy:OnObjectDestroy( 285 , 1190 , "OnEvent_285" , once );--���̔j��Ď�	
	else
		proxy:EndAnimation( 1191 , 1 );--�S���S���A�j���Đ��I��
	end
	
--��310�`319���\�E�������X�^�[�o����
	RegistSoulMonster_block1(proxy);
	

--��320���͂���1�~��遡
	proxy:OnActionEventRegion(320, 2026, "OnEvent_320", LadderAngle_A, HELPID_DOWN, everytime);
		
--��321���͂���1���遡
	proxy:OnActionEventRegion(321, 2027, "OnEvent_321", LadderAngle_A, HELPID_UP,   everytime);
	
	
--��2���򗳂����ł���|�������Đ����遡
	if proxy:IsCompleteEvent( 2 ) == false then
	
		--proxy:OnRegionJustIn( 2 , LOCAL_PLAYER , 2000 , "OnEvent_2" , once );
	
		proxy:NotNetMessage_begin();
			--�|�����J�n�t�F�[�h��ɌĂ΂��n���h��
			proxy:LuaCall(2,REMO_START,"OnEvent_2_RemoStart",once);
			--�|�����I����ɌĂ΂��n���h��
			proxy:LuaCall(2,REMO_FINISH,"OnEvent_2_RemoFinish",once);
		proxy:NotNetMessage_end();
		OnEvent_2(proxy,param);
	end

--��30���ŏ��̗v�΂̌��������遡
		proxy:OnSessionJustIn( 30 , "OnEvent_30" , everytime );
		
--��31���ŏ��̗v�΂̌����������遡
		proxy:OnSessionJustOut( 31 , "OnEvent_31" , everytime );


	
--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m02_00_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m02_00_00_00", everytime );
	proxy:NotNetMessage_end();
	
	

--�`�F�b�N�|�C���g�p�̊Ď�
	local check_point_list	= {2190, 2191, 2390, 2590, 2790, 2791};
	local check_point_num	= table.getn(check_point_list);
	for index = 1, check_point_num, 1 do
		proxy:OnRegionJustIn( SYSTEM_CHECK_POINT, LOCAL_PLAYER, check_point_list[index], "CheckPointIn_AttrCheck", everytime );
	end
	--�ŏ���1��`�F�b�N���Ă���
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "InitializeNpc", 0.0, 0, 2, once );
		proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "HiryuOsaCheck",0.0, 0, 3, once );
	proxy:NotNetMessage_end();

	--�`�F�b�N�|�C���g�z�M�p
	proxy:LuaCall( SYSTEM_CHECK_POINT, 2, "CheckPointIn", everytime );
	
	if proxy:IsClient() == false then
		if proxy:IsCompleteEvent( 85 ) == false then
			proxy:NotNetMessage_begin();
			proxy:OnRegionJustIn( 85 , LOCAL_PLAYER , 2002 , "OnEvent_85" , once );
			proxy:NotNetMessage_end();
		end
	end
	
	--�����h�����q�̍X�V�����̓z�X�g���Ǘ�
	if	proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork( 620 );
		proxy:RequestForceUpdateNetwork( 621 );
		proxy:RequestForceUpdateNetwork( 624 );
		proxy:RequestForceUpdateNetwork( 626 );
	end

	
	--��0�����J�����o�[����������Ă���Ƃ�
	if proxy:IsCompleteEvent( 0 ) == true then

		proxy:DeleteEvent( 230 );--�򗳔��ł���C�x���g�Ď��폜
		
		--���@�ǌ����Ă���
		proxy:SetColiEnable( 1999 , true );
		proxy:SetColiEnable( 1995 , true );
	
		proxy:SetDrawEnable( 1999 , true );
		proxy:SetDrawEnable( 1995 , true );
		
		--���@�ǂ�SFX ON
		proxy:ValidSfx( 1987 );
		proxy:ValidSfx( 1991 );
	else
	
		--���@�Ǐ����Ă���
		proxy:SetColiEnable( 1999 , false );
		proxy:SetColiEnable( 1995 , false );
	
		proxy:SetDrawEnable( 1999 , false );
		proxy:SetDrawEnable( 1995 , false );
		
		--���@�ǂ�SFX OFF
		proxy:InvalidSfx( 1987 , false );
		proxy:InvalidSfx( 1991 , false );
	end
	
	
--���{�X�֘A�̏���������
	if proxy:IsCompleteEvent( 4096 ) ==true then
		
		--���{�X����ł���Ƃ�
		--�t�@�����N�X���S
		--m02_00_00_00_eventboss ��Init�ɂċL�q
		
		--���@�Ǐ�����
		proxy:SetColiEnable( 1999 , false );
		proxy:SetColiEnable( 1995 , false );
	
		proxy:SetDrawEnable( 1999 , false );
		proxy:SetDrawEnable( 1995 , false );
		
		--���@�ǂ�SFX OFF
		proxy:InvalidSfx( 1987 , false );
		proxy:InvalidSfx( 1991 , false );
		

	else
		--���{�X�����Ă���Ƃ�	
		
			--�t�@�����N�X�p�̏���������
			--m02_00_00_00_eventboss ��Init�ɂċL�q
		
		--[[���̕ǂ�\�����Ȃ���΂Ȃ�Ȃ����A��0�����J�����o�[���ł���Ă���]]
	end		
	
	
	--��4103,4105���\�E������A�v�΂Ń��[�v��
	if proxy:IsCompleteEvent( 4096 ) ==true then--�{�X������ł���Ƃ�
		
		proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);--���点��
		--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
		if proxy:IsCompleteEvent( 4103 ) == false then
			--SFX�L����
			proxy:ValidSfx( 1080 );--���̗��q
			proxy:ValidSfx( 1081 );--�v�΂̃I�[��			
			proxy:OnDistanceActionAttribute( 4103 , LOCAL_PLAYER , 1982 , "OnEvent_4103" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );

			--�\�E���L����
			proxy:SetDrawEnable( 1982 , true );
			proxy:SetColiEnable( 1982 , true );
			--�\�E��2�L����
			proxy:SetDrawEnable( 1975 , true );
			proxy:SetColiEnable( 1975 , true );

		else
			--SFX OFF
			proxy:InvalidSfx( 1080, false );--���̗��q
			--proxy:InvalidSfx( 1081, false );--�v�΂̃I�[��
			--���v�΂Ń��[�v�p�̊Ď���ǉ���
			SingleReset(proxy,4105);
			proxy:OnDistanceActionAttribute( 4105 , LOCAL_PLAYER , 1982 , "OnEvent_4105" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end

	else
		--�{�X�������Ă���
		--�\�E��������
		proxy:SetDrawEnable( 1982 , false );
		proxy:SetColiEnable( 1982 , false );
		--�\�E��2������
		proxy:SetDrawEnable( 1975 , false );
		proxy:SetColiEnable( 1975 , false );
		
		--SFX OFF
		proxy:InvalidSfx( 1080, false );--���̗��q
		proxy:InvalidSfx( 1081, false );--�v�΂̃I�[��
	end

--[[--�폜�Ƃ̎��Ȃ̂ŁA�R�����g�A�E�g
--��90�����ǂ��󂵂ēG����яo���Ă��遡�L��������
	
	if proxy:IsCompleteEvent( 90 ) == false then
		proxy:EnableLogic( 202 , 0 );--���W�b�N�����Ă邯�ǁA�G���U�����Ă���?
		proxy:SetDrawEnable( 202 , false );
		proxy:SetColiEnable( 202 , false );
	else
		proxy:EnableLogic( 202 , 1 );
		proxy:SetDrawEnable( 202 , true );
		proxy:SetColiEnable( 202 , true );
	end]]
	
	--��91�����ǂ��󂵂ēG����яo���Ă���2���L��������
	if proxy:IsCompleteEvent( 91 ) == false then
		proxy:EnableLogic( 215 , 0 );
		proxy:SetDrawEnable( 215 , false );
		proxy:SetColiEnable( 215 , false );
		
		proxy:EnableLogic( 216 , 0 );
		proxy:SetDrawEnable( 216 , false );
		proxy:SetColiEnable( 216 , false );
	else
		proxy:EnableLogic( 215 , 1 );
		proxy:SetDrawEnable( 215 , true );
		proxy:SetColiEnable( 215 , true );
		
		proxy:EnableLogic( 216 , 1 );
		proxy:SetDrawEnable( 216 , true );
		proxy:SetColiEnable( 216 , true );
	end
	
	
	--��160���z�ꕺ�m�������Ă��遡���W�b�N����
	if proxy:IsCompleteEvent( 160 ) == false then
		proxy:EnableLogic( 220 , false );
		proxy:SetDrawEnable( 220 , false );
		proxy:SetColiEnable( 220 , false );--�ꏊ���ς���Ă����̂ŁA��������������B
	--	proxy:Warp( 220 , 2110 );--��(?)�̂ق��Ƀ��[�v
	else
		proxy:EnableLogic( 220 , 1 );
	end
	
	
	--��180����ʕ��m���~��Ă��遡���W�b�N����	
	if proxy:IsCompleteEvent( 180 ) == false then
		
		proxy:Warp( 211 , 2170 );
		proxy:Warp( 206 , 2171 );
		
		proxy:ForceUpdateNextFrame( 211 );
		proxy:ForceUpdateNextFrame( 206 );
		
		proxy:EnableLogic( 211 , 0 );
		proxy:EnableLogic( 206 , 0 );
	else
		proxy:EnableLogic( 211 , 1 );
		proxy:EnableLogic( 206 , 1 );
	end
	
--[[	
	--��181����ʕ��m���~��Ă���2�����W�b�N����
	if proxy:IsCompleteEvent( 181 ) == false then
		proxy:EnableLogic( 221 , 0 );
	else
		proxy:EnableLogic( 221 , 1 );
	end
]]	


	--�����{�X���S�Ŕ����J��(����ł�����A�`��Ɠ����������)
	if proxy:IsCompleteEvent( 4096 ) == true then
		proxy:SetColiEnable( 1999 , false );
		proxy:SetColiEnable( 1995 , false );
	
		proxy:SetDrawEnable( 1999 , false );
		proxy:SetDrawEnable( 1995 , false );	
	end
	

--[[
	--���p�j�f�[�����p (�t���O�͉��A�w�肪����Ες���)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m02_00_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m02_00_00_00);
	end
]]

--[[
	--��220����(��)���Q�Ă��遡
	proxy:EnableLogic( 300 , false );--��(��)���W�b�NOFF
	proxy:PlayLoopAnimation( 300 , 7000 );--�x�����Ă���A�j�����[�v�Đ�
	
	if proxy:IsCompleteEvent( 220 ) == true then

		--�̈�Ď���ǉ����Ȃ���
		proxy:SetEventFlag( 220 , 0 );
		proxy:OnRegionIn( 220 , LOCAL_PLAYER , 2130 , "OnEvent_220" , everytime );
		proxy:SetEventFlag( 220 , 1 );
	
	else
		proxy:PlayLoopAnimation( 300 , 7000 );--�Q�Ă���A�j�����[�v�Đ�
	end
]]
	
	
	--���̖���ʉ߂ł���L�����^�C�v(���̃^�C�v�̐l�����A�N�V�����{�^������������)
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	
	--��240���z�X�gPC�݂̂��ʂ����̖���
	if proxy:IsCompleteEvent( 240 ) == true then--�z�X�g���ʉߍς�
		proxy:SetDrawEnable( 1055 , false );
		proxy:SetColiEnable( 1055 , false );
		proxy:InvalidSfx(2075, false);
	else
		--��240�����@�Ǎ폜�����p��
		proxy:LuaCall( 240 , 1 , "OnEvent_240_delete_wall" , once );
		--��240���ǂ̒��ɓ���C�x���g�����p��
		proxy:OnDistanceActionAttribute( 240 , LOCAL_PLAYER , 1055 , "OnEvent_240" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
	
	
	--��241���z�X�gPC�݂̂��ʂ����̖���
	if proxy:IsCompleteEvent( 241 ) == true then--�z�X�g���ʉߍς�
		proxy:SetDrawEnable( 1056 , false );
		proxy:SetColiEnable( 1056 , false );
		proxy:InvalidSfx(2076, false);
	else
		--��241�����@�Ǎ폜�����p��
		proxy:LuaCall( 241 , 1 , "OnEvent_241_delete_wall" , once );
		
		--��241���ǂ̒��ɓ���C�x���g�����p��
		proxy:OnDistanceActionAttribute( 241 , LOCAL_PLAYER , 1056 , "OnEvent_241" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
	
	
	--��242���z�X�gPC�݂̂��ʂ����̖���
	if proxy:IsCompleteEvent( 242 ) == true then--�z�X�g���ʉߍς�
		proxy:SetDrawEnable( 1057 , false );
		proxy:SetColiEnable( 1057 , false );
		proxy:InvalidSfx(2077, false);
	else		
		--��242�����@�Ǎ폜�����p��
		proxy:LuaCall( 242 , 1 , "OnEvent_242_delete_wall" , once );
		
		--��242���ǂ̒��ɓ���C�x���g�����p��
		proxy:OnDistanceActionAttribute( 242 , LOCAL_PLAYER , 1057 , "OnEvent_242" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end

	


	
	--��285���C�e�S���S����
	if proxy:IsCompleteEvent( 285 ) == true then
		proxy:ReconstructBreak( 1190 , 1 );--���I�u�W�F�̔j��Č�
	end
	
	
	
	

--����(��)�C�x���g�֘A������

	--������
	proxy:SetDisableGravity( 300 , true );--�d��OFF
	proxy:EnableLogic( 300 , false );--�v�lOFF
	proxy:SetSuperArmor( 300 , true );--�_���[�W���[�V���������Ȃ�
	proxy:SetDeadMode(300, true);--�򗳂͎��ȂȂ��ݒ�(���ɂ����ɂȂ�����P�ނ���)
	
	
	--������Ԃ��Z�b�g(��Ԃ����ݒ�̏ꍇ�A�w�肵����Ԃ��Z�b�g����)
	SetFirstNpcStateFlag( proxy , param , tyo_flag_list , TYO_STATE_WARNING_AISLE );
	
	--���݂̏�Ԏ擾
	local now_tyo_state = GetNpcStateFlag( proxy , param , tyo_flag_list );
	
	--�򗳂̒����A���̊�(����4)���炱������ދ�����
	if now_tyo_state == TYO_STATE_WARNING_KING_ROOM or 
	   now_tyo_state == TYO_STATE_WARNING_GATE      then
	   
		--��(��)�̏�Ԃ��u�x��(�ʘH)�v�ɃZ�b�g
		SetNpcStateFlag( proxy , param , tyo_flag_list , TYO_STATE_WARNING_AISLE );
	end
	
	--���݂̏�Ԏ擾(��Ԃ��ς�����\��������̂�)
	local now_tyo_state = GetNpcStateFlag( proxy , param , tyo_flag_list );
	
	--�x��(�ʘH)
	if now_tyo_state == TYO_STATE_WARNING_AISLE then
		
		proxy:EnableLogic( 300 , false );
		proxy:PlayLoopAnimation( 300 , 7000 );
		
	--���S
	elseif now_tyo_state == TYO_STATE_DEAD then
		InvalidCharactor( proxy , 300 );--���Ȃ����Ƃɥ��
		
		--��(��)�֘A�C�x���g�폜
		proxy:DeleteEvent( 220 );--���ŐQ�Ă���
	end

	if	proxy:IsCompleteEvent( KENZOKU_2_STATE_DEAD ) == true or
	    proxy:IsCompleteEvent( KENZOKU_STATE_DEAD ) == true then
		proxy:OpeningDead( 301, false );
	end
	
--[[	
	--���݂̏�Ԏ擾
	local now_kenzoku_state = GetNpcStateFlag( proxy , param , kenzoku_flag_list );
	
	--��Ԃ��ƂɕK�v�ȏ�����������Ȃ祥�
	
	if now_kenzoku_state == KENZOKU_STATE_WARNING or 
       now_kenzoku_state == KENZOKU_STATE_WARNING_AND_LEVER then
		
		--���ɂ���
		proxy:EnableLogic( 301 , false );
		proxy:PlayLoopAnimation( 301 , 0 );
		
	elseif now_kenzoku_state == KENZOKU_STATE_PROTECT_CASTLE then
	
		--��ǌ���Ă�
		--�v���C���[�����Ȃ��Ȃ�����A����ɑ��A��̂ł��̂܂܂ŗǂ��Ǝv����B
		
	elseif now_kenzoku_state == KENZOKU_STATE_DEAD    or 
		   now_kenzoku_state == KENZOKU_2_STATE_DEAD then
		   
		InvalidCharactor( proxy , 301 );--���Ȃ����Ƃɥ��
		
		--��(�ő�)�֘A�C�x���g�폜
		proxy:DeleteEvent( 221 );--���Ōx�����Ă���
		proxy:DeleteEvent( 230 );--��ǂɔ��ł���
		
	end
]]
	
--��15610���h�����̎��̂𒲂ׂ���
	if proxy:IsCompleteEvent( 15610 ) == false then
		proxy:AddCorpseEvent( 15610 , 697 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15610 ,0 , "OnEvent_15610",once );
 		proxy:NotNetMessage_end();
	end
--���yNPC:�h�����z�C�x���g�֘A������
	SetFirstNpcStateFlag( proxy , param , doran_flag_list , DORAN_STATE_GUARD );
	--�h�����������Ă��邩
	if proxy:IsCompleteEvent( DORAN_STATE_DEAD ) == false then
		--�h�������퓬�Ԑ�������Ă���
		if proxy:IsCompleteEvent(DORAN_STATE_GUARD) == true then
			proxy:OnCharacterHP( 330, 697, "OnEvent_330", 0.8, once );	--�h�����̂g�o��80������������
			proxy:OnCharacterHP( 331, 697, "OnEvent_331", 0.6, once );	--�h�����̂g�o��60������������
			if proxy:IsCompleteEvent( 329 ) == false then
				proxy:EnableLogic( 697, false );			
				proxy:OnSimpleDamage( 329 , 697 , 10000 , "OnEvent_329" , once );
				proxy:LuaCall( 329 , 0 , "OnEvent_329",once );
			end
			--���q���Ō�܂ŏ�����
			if proxy:IsCompleteEvent( 11790 ) == true then
				print("�h���������");
				proxy:SendEventRequest( 697 ,0, 1);
				proxy:SetEventSpecialEffect_2( 697 , 5042 );
			end
			
		--�h������PC�������Ă���
		elseif proxy:IsCompleteEvent(DORAN_STATE_ALLOWED) == true then
			proxy:SetTeamType( 697, TEAM_TYPE_Friend );
			proxy:OnCharacterHP( 331, 697, "OnEvent_331", 0.6, once );
		elseif proxy:IsCompleteEvent(DORAN_STATE_NOT_ALLOWED) == true then
		end
		proxy:OnCharacterDead( 332, 697, "OnEvent_332", once );
	--�h����������ł�����
	else
		if proxy:IsCompleteEvent( 15610 ) == true then
			InvalidBackRead( proxy, 697 );
		else
			--���̂��Č�����
			proxy:OpeningDeadPlus( 697 , true ,false ,false );
		end
	end



	--��280���݂邳��Ă���󎀑́�
	if proxy:IsCompleteEvent( 280 ) == true then
		proxy:ReconstructBreak( 1172 , 1 );--�R�̔j��Č�(�^�C�~���O�̖��ɂ�襥�)
	else
		--���̂̑ҋ@�A�j��(�݂邳��Ă�����)
		proxy:PlayAnimation( 10240 , 1001 );

		--��V�X�e��������
		proxy:EnableObjTreasure( 10240 , false );
	end
	
	--��281���݂邳��Ă���󎀑́�
	if proxy:IsCompleteEvent( 281 ) == true then
		proxy:ReconstructBreak( 1174 , 1 );--�R�̔j��Č�
	else
		--���̂̑ҋ@�A�j��(�݂邳��Ă�����)
		proxy:PlayAnimation( 10241 , 1001 );

		--��V�X�e��������
		proxy:EnableObjTreasure( 10241 , false );
	end	
	
--��61���~�����_�����S���Ă���ꍇ�̏�����������
	SingleReset( proxy, 61 );
	if proxy:IsCompleteEvent( 60 ) == true or
		proxy:IsSuccessQWC(20500) == false then
		proxy:SetEventFlag( 61 , true );
	end
	
--��15605���~�����_���̒��ׂ���
	if proxy:IsCompleteEvent( 15605 ) == false then 
		proxy:AddCorpseEvent( 15605 , 628 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15605 , 0 , "OnEvent_15605",once);
		proxy:NotNetMessage_end();
	end
	
	if proxy:IsCompleteEvent( 61 ) == true then
		if proxy:IsCompleteEvent( 60 ) == true and proxy:IsCompleteEvent( 15605 ) == false then
			proxy:OpeningDeadPlus( 628 , true ,false ,false );			
		else
			InvalidBackRead( proxy, 628 );
			print("�~�����_��InvalidBackRead���������܂���");
		end
	else
		--��86���̈�ɓ�������t���OON��
		if proxy:IsCompleteEvent( 86 ) == false then
			proxy:OnRegionJustIn( 86 , 10000 , 2003 , "OnEvent_86",once);
		end
	end
	
	--[[
	--�z�X�g�͕K���o�^����ׁA�ӂ炮����
	if	proxy:IsClient() == false then
		SingleReset( proxy, 62 );
	end
	]]
	
--��15635���~�����_�E�u���b�N�̎��̂𒲂ׂ���
	if proxy:IsCompleteEvent( 15635 ) == false then
		proxy:AddCorpseEvent( 15635 , 231 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15635 ,0 , "OnEvent_15635",once );
 		proxy:NotNetMessage_end();
	end	
	
	--���~�����_�E�u���b�N�̏o�����聡
	if	proxy:IsCompleteEvent(62) == true or
		proxy:IsSuccessQWC(20300) == false then
		
		if 	proxy:IsCompleteEvent( 62 ) == true and
			proxy:IsCompleteEvent( 15635 ) == false then
			--���̂��Č�����
			proxy:OpeningDeadPlus( 231 , true ,false ,false );
		else
			InvalidBackRead( proxy, 231 );
		end
	else
		proxy:OnCharacterDead( 62, 231, "OnEvent_62", once );
		proxy:SetTeamType( 698, TEAM_TYPE_AngryFriend );
	end
	
	
--��60���~�����_�����S��
	if proxy:IsCompleteEvent( 60 ) == false then
		proxy:OnCharacterDead( 60, 628, "OnEvent_60", once );
	end
	
--��86���̈�ɓ�������t���OON��
	if proxy:IsCompleteEvent( 86 ) == false then
		proxy:OnRegionJustIn( 86 , 10000 , 2003 , "OnEvent_86",once);
	end

--��8084���݂邳��Ă���󎀑́�
	proxy:SetEventFlag(8084, true)
--[[	
	--�z�ꕺ�m�̃V���b�vNPC
	if proxy:IsClient() == false then
		--�N���C�A���g���o�^���Ȃ��C�x���g�Ȃ̂ŁA�z�M����ƃN���C�A���g���ŃA�T�[�g���o��ׁA��z�M�ݒ�ɕύX
		proxy:NotNetMessage_begin();
	--��340���z�ꕺ�m�̃V���b�vNPC�`�F�b�N�|�C���g(���O)��
		proxy:OnRegionJustIn(343 , LOCAL_PLAYER , 2120 ,"OnEvent_343" , everytime);
	--��340���z�ꕺ�m�̃V���b�vNPC�`�F�b�N�|�C���g(���O)��
		proxy:OnRegionJustIn(344 , LOCAL_PLAYER , 2191 ,"OnEvent_344" , everytime);
	--��340���z�ꕺ�m�̃V���b�vNPC�`�F�b�N�|�C���g(���O)��
		proxy:OnRegionJustIn(345 , LOCAL_PLAYER , 2390 ,"OnEvent_345" , everytime);
	--��340���z�ꕺ�m�̃V���b�vNPC�`�F�b�N�|�C���g(���O)��
		proxy:OnRegionJustIn(780 , LOCAL_PLAYER , 2790 ,"OnEvent_780" , everytime);
		proxy:NotNetMessage_end();
	end
	
	--��635���`�F�b�N�|�C���g�̊Ď���
	proxy:LuaCall( 781 , 1 , "OnEvent_781",everytime);

	--�z�ꕺ�m�̏������p
	OnEvent_781(proxy, param);
]]	
	
--��7���G���C�e���낲�끡
	RegistEvent_7(proxy);
	

--[[--�폜�Ƃ̎��Ȃ̂ŁA�R�����g�A�E�g
--��10700,10701���݂邳��Ă���l���b�������Ă��遡
	if proxy:IsCompleteEvent( 10700 ) == false then
		proxy:OnRegionIn( 10700 , LOCAL_PLAYER , 2051 , "OnEvent_10700" , everytime );
		--���̂����b(������)
		proxy:RegistSimpleTalk( 10700 , 10241 , 16000, TALK_ATTR_ALL );
		
		--���̂����b(����)
		proxy:RegistSimpleTalk( 10701, 10241, 16010, TALK_ATTR_ALL );
	end]]
	

--��15500�������A�C�e���擾�Ď����n���h���̓O���[�o���ɒ�`
--~     if proxy:IsCompleteEvent( 15500 ) == false then
--~         proxy:AddCorpseEvent( 15500 , 231 );--�~�����_�E�u���b�N		
--~     end
	
	
--��100��������΃_���[�W��
	local objIdlist = {1180,1181,1182,1183,1185,1186};
	local num = table.getn( objIdlist );
	local sec = FIREDAM_WAIT;
	for index=1 , num ,1 do
		proxy:NotNetMessage_begin();	
			proxy:OnObjectDamageHit_NoCallPlus( 100, objIdlist[index],1,10300,EV_HIT_CHR,0.5,-1,2.0,everytime);
			--proxy:OnKeyTime2( 100, "OnEvent_100_"..objIdlist[index],sec,0,objIdlist[index],once);		
		proxy:NotNetMessage_end();
		--proxy:OnDistanceJustIn(100,10000,objIdlist[index],"OnEvent_100_"..objIdlist[index],0.5,everytime);		
		sec = sec + 0.1;
	end
	
	
	--��8����ʕ��m���Ή��r�����遡
	SingleReset( proxy, 8 );
	if proxy:IsCompleteEvent( 8 ) == false then
		proxy:OnRegionJustIn( 8, 10000 , 2007 , "OnEvent_8" , once);
		proxy:OnSimpleDamage( 8, 247 , 10000 , "OnEvent_8" , once);
		
		proxy:OnRegionJustIn( 9, 10000 , 2008 , "OnEvent_9" , once);
		
		proxy:EnableLogic( 247, false );
	end
	
	
	--�����g�J�Q���S�C�x���g
	RegistTokage(proxy,120,250,0);	
	
	--��999999���t���[���x��̏����������C�x���g�𔭍s��
	proxy:NotNetMessage_begin();
		--��0�b�づ--
		proxy:OnKeyTime2( 999990, "Second_Initialize_m02_00_00_00", 0.3, 0, 0, once );	
	proxy:NotNetMessage_end();
	
	proxy:LuaCall(4081, 2, "hiryuu_test_1", everytime );
	proxy:LuaCall(4081, 3, "hiryuu_test_2", everytime );
	
	if proxy:IsDbgReLoad() == true then
		proxy:OnKeyTime2( 4021,"OnEvent_DbgReLoad",1.0,0,0,once);
	end
	print("Initialize_m02_00_00_00 end");
end

--�����[�h�f�o�b�O
function OnEvent_DbgReLoad(proxy,param)
	--�Β��̉���v�΂�
	--���S�񕜗v��
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1006 );	
end


function hiryuu_test_1(proxy,param)
	print("hiryuu_test_1 begin");
	proxy:PlayAnimation( 300, 7018 );
	print("hiryuu_test_1 end");
end

function hiryuu_test_2(proxy,param)
	print("hiryuu_test_2 begin");
	proxy:PlayAnimation( 301, 7011 );
	print("hiryuu_test_2 end");
end


--------------------------------------------------------------------------------------
--�}���`�ɂȂ������Ƀz�X�g���ᖳ�������灡����
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end

function OnEvent_4000_Hp_1(proxy,param)
	print("OnEvent_4000_Hp_1 begin");
	proxy:SetDeadMode2(800 , true );
	proxy:SetDeadMode2(801 , true );
	proxy:SetDeadMode2(802 , true );
	proxy:SetDeadMode2(821 , true );	
	print("OnEvent_4000_Hp_1 end");
end

--------------------------------------------------------------------------------------
--Initialize����Ă΂��A1�t���[���x��̏�����������999999
--------------------------------------------------------------------------------------
--��999999���ꕔ�AInit�ł͏����ł��Ȃ��̂ŁA�c���Ă���
function Second_Initialize_m02_00_00_00(proxy, param)
	print("Second_Initialize_m02_00_00_00 begin");

	--��280���݂邳��Ă���󎀑́�
	if proxy:IsCompleteEvent( 280 ) == true then
		proxy:ReconstructBreak( 1172 , 1 );--�R�̔j��Č�(�^�C�~���O�̖��ɂ�襥�)
	else
		--���̂̑ҋ@�A�j��(�݂邳��Ă�����)
		proxy:PlayAnimation( 10240 , 1001 );

		--��V�X�e��������
		proxy:EnableObjTreasure( 10240 , false );
	end
	
	--��281���݂邳��Ă���󎀑́�
	if proxy:IsCompleteEvent( 281 ) == true then
		proxy:ReconstructBreak( 1174 , 1 );--�R�̔j��Č�
	else
		--���̂̑ҋ@�A�j��(�݂邳��Ă�����)
		proxy:PlayAnimation( 10241 , 1001 );

		--��V�X�e��������
		proxy:EnableObjTreasure( 10241 , false );
	end
--------------------------------������QWC�C�x���g�֘A������--------------------------------
--------------------------------������QWC�C�x���g�֘A������--------------------------------
	
	print("Second_Initialize_m02_00_00_00 end");
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--��391�`409���M����(��)��
--��421�`430���M����(��)��
-----------------------------------------------------------------------------------------------------------------------------------------------
function TaruRegist(proxy,param)
	print("TaruRegist begin");
	local Owner = 235;
	--�e�ۃI�[�i�[���p
	CreateBulletOwner(proxy,Owner);	
	
	local small_acId_list	= {  391,  392,  393,  394,  395,  396,  397,  398,  399,  400,  401,  402,  403,  404,  405,  406,  407,  408,  409};
	local small_objId_list	= { 1141, 1142, 1143, 1144, 1145, 1146, 1147, 1148, 1149, 1150, 1151, 1152, 1153, 1154, 1155, 1156, 1157, 1158, 1159};
	local small_event_num = table.getn( small_acId_list );
	for index = 1, small_event_num, 1 do
		local acid = small_acId_list[index];
		local evid = small_objId_list[index];
		SingleReset(proxy,acid);
		if	proxy:IsCompleteEvent( acid ) == false then
			--proxy:OnFireDamage( acid, evid, -1, "OnEvent_"..acid, once );
			proxy:OnFireDamage( acid, evid, -1, "OnEvent_"..acid, once );
		else
			proxy:ReconstructBreak( evid, 1 );
		end
	end
	
	
	
	local big_acId_list		= {  421,  422,  423,  424,  425,  426,  427,  428,  429,  430};
	local big_objId_list	= { 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030};
	local big_event_num = table.getn( big_acId_list );
	for index = 1, big_event_num, 1 do
		local acid = big_acId_list[index];
		local evid = big_objId_list[index];
		SingleReset(proxy,acid);
		if	proxy:IsCompleteEvent( acid ) == false then
			proxy:OnFireDamage( acid, evid, -1, "OnEvent_"..acid, once );
		else
			proxy:ReconstructBreak( evid, 1 );
		end
	end
	print("TaruRegist end");
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--��391�`409���M����(��)��
-----------------------------------------------------------------------------------------------------------------------------------------------
function OnEvent_391(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_392(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_393(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_394(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_395(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_396(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_397(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_398(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_399(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_400(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_401(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_402(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_403(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_404(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_405(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_406(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_407(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_408(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_409(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end

-----------------------------------------------------------------------------------------------------------------------------------------------
--��421�`430���M����(��)��
-----------------------------------------------------------------------------------------------------------------------------------------------
function OnEvent_421(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_422(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_423(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_424(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_425(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_426(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_427(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_428(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_429(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_430(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end

--�M�����܂Ƃ�
function TaruFunc(proxy,param,acId,Owner,objId,behaviorId,angX,angY,angZ)
	print("OnEvent_"..acId.." begin");
	proxy:CastPointSpell( Owner, objId, behaviorId, angX, angY, angZ );
	proxy:SetEventFlag( acId, true );
	print("OnEvent_"..acId.." end");
end




--------------------------------------------------------------------------------------
--���J�����o�[��0
--------------------------------------------------------------------------------------
--��0�����J�����o�[��
function OnEvent_0(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_0 begin");

	proxy:NotNetMessage_begin();
		--��***�����ǉ�***0�b�づ
		proxy:OnKeyTime2( 0, "OnEvent_0_3", 0.0, 0, 1, once);
	proxy:NotNetMessage_end();
	

	print("OnEvent_0 end");
end

--��0_3��PC�����o�[�C�x���g���N�����Ă���0�b�っ
function OnEvent_0_3(proxy, param)
	print("OnEvent_0_3 begin");
	
	proxy:LuaCallStart(0,1);
	
	--�t���O�𗧂Ă�(�w�����ɍ��킹�邽��)
	proxy:SetEventFlag( 1 , 1 );
	
	print("OnEvent_0_3 end");
end

function OnEvent_0_4(proxy,param)
	print("OnEvent_0_4 begin");
	
	if param:IsNetMessage() == true then
		--�����ҏo���|����
		proxy:RequestRemoPlus(20001,REMO_FLAG,0,1, param:GetPlayID()+10001);
	else
		--�|�����Đ�
		proxy:RequestRemoPlus(20001,REMO_FLAG,0,1,LOCAL_PLAYER);--���傪�J���|����
	end
	
	proxy:SetEventFlag( 0 , 1 );
	
	print("OnEvent_0_4 end");
end

--�|�����t�F�[�h�A�E�g��
function OnEvent_0_RemoStart(proxy,param)
	print("OnEvent_0_RemoStart begin");
	--��
	print("OnEvent_0_RemoStart end");
end

--�|�����Đ���
function OnEvent_0_RemoFinish(proxy,param)
	print("OnEvent_0_RemoFinish begin");
	
	--���@�ǂ��\�������
	proxy:SetColiEnable( 1999 , true );
	proxy:SetColiEnable( 1995 , true );

	proxy:SetDrawEnable( 1999 , true );
	proxy:SetDrawEnable( 1995 , true );
	
	--���@�ǂ�SFX ON
	proxy:ValidSfx( 1987 );
	proxy:ValidSfx( 1991 );
	
	--�򗳊֘A�����ł���(�A��)�C�x���g�Ď��폜
	--proxy:DeleteEvent( 230 );--���ł���
	
	proxy:EndAnimation( 1000, 1 );--���o�[�A�j�����Đ�
	proxy:EndAnimation( 1001, 1 );--����J���A�j�����Đ�
	proxy:EndAnimation( 1140, 1 );--�M�A�������A�j���Đ�
	
	--��OBJ��L����
	proxy:SetDrawEnable( 1008 , true );
	proxy:SetColiEnable( 1008 , true );
	
	print("OnEvent_0_RemoFinish end");
end

--------------------------------------------------------------------------------------
--��������J��4096
--------------------------------------------------------------------------------------
--��4096�����{�X���S����
function OnEvent_4096(proxy, param)
	print("OnEvent_4096 begin");
	
	--�t�@�����N�X�p���S����
	PhalanxDead(proxy,param);
	
	proxy:NotNetMessage_begin();
		--��4100���N���C�A���gPC���[�v���o��
		proxy:OnKeyTime2( 4100, "OnEvent_4100", 0, 0, 0, once);
		--��4096_1��1�b�o�߁�
		proxy:OnKeyTime2( 4096, "OnEvent_4096_1", 1, 0, 1, once);
		--��4102��2�b�o�߁�
		proxy:OnKeyTime2( 4102, "OnEvent_4102", 2, 0, 2, once);
		
		--�}���`����PT�G���A�ړ����
		proxy:OnRegistFunc( 4096 , "Check_4096_PT","OnEvent_4096_PT",0,once);
	proxy:NotNetMessage_end();

	
	proxy:SetEventFlag( 4096, 1 );
	
	--�����h�����q���T�����������苗���ȏ㗣�ꂽ���_�Ŏ��̏�ԂɑJ��
	if	proxy:IsClient() == false then
		if	proxy:IsCompleteEvent( RENDOL_STATE_SEARCH_1 ) == true then
			if	proxy:IsDistance( LOCAL_PLAYER, 624, 20 ) == false then
				proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "OnEvent_301", 0.0, 0, 2, once );
			else
				proxy:OnPlayerDistanceOut( 301, LOCAL_PLAYER, 624, "OnEvent_301", 20, once );
			end
		end
	end
	
	--�V�u���b�N�N���A������
	proxy:CustomLuaCallStart( 4050, 800);
	--�����g�J�Q�C�x���g���Z�b�g
	ResetTokage(proxy);
	
	--[[
	if proxy:IsClient() == false then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4096 , "OnEvent_4096_2",5.0,0,0,once);
		proxy:NotNetMessage_end();
	end
	]]
	print("OnEvent_4096 end");
end

--��4096_1����������J��:���{�X���S��1�b��
function OnEvent_4096_1(proxy, param)
	print("OnEvent_4096_1 begin");
	
	--�{�X��|���������X�V(���ɂ���ăt���O�𗧂Ă�)
	GetBossFlagCount( proxy, param );
	
	--���g���t�B�[�擾���聥
	Lua_RequestUnlockTrophy(proxy, 27);
	
	--�z�ꕺ�m�̏�ԑJ�ڃ`�F�b�N
	OnEvent_781(proxy,param)
	
	--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
	if proxy:IsCompleteEvent( 4103 ) == false then
	
		--�\�E���L����
		proxy:SetDrawEnable( 1982 , true );
		proxy:SetColiEnable( 1982 , true );
		--�\�E��2�L����
		proxy:SetDrawEnable( 1975 , true );
		proxy:SetColiEnable( 1975 , true );
	
		--SFX�L����
		proxy:ValidSfx( 1080 );--���̗��q
		proxy:ValidSfx( 1081 );--�v�΂̃I�[��
		
		proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);--���点��
		proxy:OnDistanceActionAttribute( 4103 , LOCAL_PLAYER , 1982 , "OnEvent_4103" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );
	else
		--�\�E��������(������������̂ť��)
		proxy:SetDrawEnable( 1982 , false );
		proxy:SetColiEnable( 1982 , false );
	end

	--��荇�����t�@�����N�X�����̂ݑΉ�
	print("�{�X�����A�^���ʏ�");
	--�ꎞ�I�ɑSOFF
	proxy:SetColiEnableArray(3010,true);--�ʏ�L��		
	proxy:SetColiEnableArray(3002,false);--�{�X�p����
	proxy:SetColiEnableArray(3001,false);--�{�X�p����
		
	print("OnEvent_4096_1 end");
end

--[[
--�G���A����̕\��
function OnEvent_4096_2(proxy,param)
	print("OnEvent_4096_2 begin");
	--�C���t�H�\��
	--�V�X�e�����b�Z�[�W
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationBuffer( 10010740 );
	proxy:PlayTypeSE( LOCAL_PLAYER ,SOUND_TYPE_M ,777777777 );
	print("OnEvent_4096_2 end");
end
]]

--------------------------------------------------------------------------------------
--��4100���N���C�A���gPC���[�v���o��
--------------------------------------------------------------------------------------

--��4100���N���C�A���gPC���[�v���o��
function OnEvent_4100(proxy, param)
	print("OnEvent_4100 begin");

	if proxy:IsClient() == true then
		proxy:PlayAnimation( LOCAL_PLAYER , 8284 );--���[�v�A�j�����Đ�
	end

	proxy:SetEventFlag( 4100 , 1 );
	
	print("OnEvent_4100 end");
end


--------------------------------------------------------------------------------------
--��4102���V���O���F���̕ǁABGM������
--------------------------------------------------------------------------------------

--��4102���V���O���F���̕ǁABGM������
function OnEvent_4102(proxy, param)
	print("OnEvent_4102 begin");
		
	--�{�X��p��BGM��~
	proxy:StopPointSE( 0 );
		
	proxy:SetEventFlag( 4102 , 1 );
	
	print("OnEvent_4102 end");
end

--PT��g��ł��邩�̊Ď�
function Check_4096_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--PT����Ȃ��Ȃ�
function OnEvent_4096_PT(proxy,param)
	print("OnEvent_4096_PT begin");
	--���{�X�����̑O��̖��@�ǂ�������(�S�v���C���[)
	proxy:SetColiEnable( 1999 , false );
	proxy:SetColiEnable( 1995 , false );
	--proxy:SetObjDeactivate( 1999 , true );--�f�A�N�e�B�u
	--proxy:SetObjDeactivate( 1995 , true );--�f�A�N�e�B�u
	
	proxy:SetDrawEnable( 1999 , false );
	proxy:SetDrawEnable( 1995 , false );
	
	--���{�X�������@�ǂ�SFX�폜
	proxy:InvalidSfx( 1987 , true );
	proxy:InvalidSfx( 1991 , true );
	
	--���{�X�����O�̈ړ������C�x���g���폜
	proxy:DeleteEvent( 110 );--��l�ڂ�����Ƃ��p
	proxy:DeleteEvent( 111 );--��l�ڈȍ~������Ƃ��p
	proxy:DeleteEvent( 114 );--�{�X�퓬�J�n�p
	print("OnEvent_4096_PT end");
end


--------------------------------------------------------------------------------------
--��哃�E�̔��J����10
--------------------------------------------------------------------------------------
--��10�����o�[�Ή����i�E�j�̊J����ActionButton����
function OnEvent_10(proxy, param)
	print("OnEvent_10 begin");
	
	proxy:PlayAnimation(1005, 1);--���o�[�A�j���Đ�
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PULL_LEVER );

	proxy:NotNetMessage_begin();
		--��10_2��***�����ǉ�***���o�[�A�j���I����
		proxy:OnObjAnimEnd( 10, 1005, 1, "OnEvent_10_2", once);
	proxy:NotNetMessage_end();
	
	if	param:IsNetMessage() == false then
		proxy:WarpDmy( LOCAL_PLAYER , 1005 , 191 );
	end
	
	proxy:SetEventFlag( 10 , true );

	print("OnEvent_10 end");
end


--��10_2�����o�[�A�j���̏I����
function OnEvent_10_2(proxy, param)
	print("OnEvent_10_2 begin");
	
	proxy:NotNetMessage_begin();
		--��10_3��***�����ǉ�***1�b�o�߁�
		proxy:OnKeyTime2( 10, "OnEvent_10_3", 1.0, 0, 1, once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_10_2 end");
end

--��10_3�����o�[�A�j���I������1�b�o�߁�
function OnEvent_10_3(proxy, param)
	print("OnEvent_10_3 begin");
	
	proxy:PlayAnimation(1003, 1);--���A�j���Đ�
	
	--�t���O�𗧂Ă�(�w�����ɍ��킹�邽��)
	proxy:SetEventFlag( 11, true );
	print("OnEvent_10_3 end");
end
	


--------------------------------------------------------------------------------------
--���o�[�Ή���(��)��50
--------------------------------------------------------------------------------------
--��50�����o�[�Ή����i���j��
function OnEvent_50(proxy, param)
	print("OnEvent_50 begin");
	
	proxy:PlayAnimation(1006, 1);--���o�[�A�j���Đ�
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PULL_LEVER );

	proxy:NotNetMessage_begin();
		--��50_2��***�����ǉ�***���o�[�A�j���I����
		proxy:OnObjAnimEnd( 50, 1006, 1, "OnEvent_50_2", once );
	proxy:NotNetMessage_end();
	
--	proxy:Warp(LOCAL_PLAYER, 2016);		--�v���C���[������ʒu�Ƀ��[�v
	--�����҂̂݃��[�v
	if	param:IsNetMessage() == false then
		proxy:WarpDmy( LOCAL_PLAYER , 1006 , 191 );
	end
	proxy:SetEventFlag( 50 , true );
--	proxy:DisableMove(LOCAL_PLAYER, true); --�v���C���[�𑀍�s�\��

	print("OnEvent_50 end");
end


--��50_2�����o�[�A�j���I����
function OnEvent_50_2(proxy, param)
	print("OnEvent_50_2 begin");
	
	proxy:NotNetMessage_begin();
		--��50_3��***�����ǉ�***1�b�o�߁�
		proxy:OnKeyTime2( 50, "OnEvent_50_3", 1.0, 0, 1, once);
	proxy:NotNetMessage_end();

	print("OnEvent_50_2 end");
end


--��50_3�����o�[�A�j���I������1�b�っ
function OnEvent_50_3(proxy, param)
	print("OnEvent_50_3 begin");
	
	proxy:PlayAnimation( 1004, 1 );--���A�j���Đ�
	
	--�t���O�𗧂Ă�(�w�����ɍ��킹�邽��)
	proxy:SetEventFlag( 51 , true );
	
	print("OnEvent_50_3 end");
end


--�O���[�o���ɂ����H
--------------------------------------------------------------------------------------
--�����p�̊֐���  m04 �̂Ƃ͂�����Ƃ������B������������B�iplayer_anime_id)
--------------------------------------------------------------------------------------

--��������Ăԁ�
function EventNormalDoor(proxy, param, event_id, door_id, door_anime_id, player_anime_id)
	print("OnEvent_"..event_id.." begin");
	
	proxy:PlayAnimation( door_id , door_anime_id );--���̃A�j���[�V����

	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, player_anime_id ) == true then
		proxy:SetEventFlag( event_id , 1 );--�J��A(��O����J����)�ւ̑���𖳌��ɂ���B
		return;
	end

--	proxy:DisableMove(LOCAL_PLAYER,1);	 --�L�����N�^���ړ��A����s�\��
	proxy:SetEventFlag( event_id , 1 );--�J��A(��O����J����)�ւ̑���𖳌��ɂ���B

	print("OnEvent_"..event_id.." end");
end



--------------------------------------------------------------------------------------
--�Β��Ƀ��[�v��70
--------------------------------------------------------------------------------------
--��70���Β��Ƀ��[�v��
function OnEvent_70(proxy,param)	

	if proxy:IsCompleteEvent( 70 ) == true then
		return;
	end
	
	if param:IsNetMessage() == true then
		return;
	end
	
	
	print("OnEvent_70 begin");
	
	--�Z�b�V�������Ȃ�΁A�v�΂̃��[�v����
	if proxy:IsSession() == false then--�Z�b�V�������ł͂Ȃ�
		proxy:RepeatMessage_begin();
		--��70_1���I�����j���[�̊Ď���
			proxy:OnSelectMenu(70, "OnEvent_70_0", 10010710, 0, 2, 1983, 2, once);			
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

	print("OnEvent_70 end");
end

--��70_0���I�����j���[�̊Ď���
function OnEvent_70_0(proxy, param)
	print("OnEvent_70_0 begin");	
	
	if proxy:IsSession() == false then
		proxy:PlayAnimation( LOCAL_PLAYER , 8283 );--�v�΂ɐG���A�j�����Đ�
		proxy:NoAnimeTurnCharactor( 10000 , 1983 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--���v�΂ɐG���A�j���Đ��I����
			proxy:OnChrAnimEnd( 70 , LOCAL_PLAYER , 8283 , "OnEvent_70_1" , once );
		proxy:NotNetMessage_end();

		proxy:SetEventFlag( 70 , true );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_70_0 end");
end

--��70_1���v�΂ɐG���A�j���Đ��I����
function OnEvent_70_1(proxy, param)
	print("OnEvent_70_1 begin");
	
	proxy:SetEventFlag( 70 , false );
	
	proxy:PlayAnimation( LOCAL_PLAYER , 8284 );--�����E�ɋA��A�j�����Đ�
	
	--[[
	proxy:NotNetMessage_begin();
		--�������E�ɋA��A�j���Đ��I����
		proxy:OnChrAnimEnd( 70 , LOCAL_PLAYER , 8284 , "OnEvent_70_2" , once );
	proxy:NotNetMessage_end();
	]]

	proxy:SetEventFlag( 70 , true );
	OnEvent_70_2(proxy,param);
	
	print("OnEvent_70_0 end");
end

--�������E�ɋA��A�j���Đ��I����
function OnEvent_70_2(proxy,param)	
	print("OnEvent_70_2 begin");

	--�Β��֖߂��Ă�������̃t���O�𗧂Ă�
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag( 70 , false );
	
	--���S�񕜗v��
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1006 );
	
	print("OnEvent_70_2 end");
end


--------------------------------------------------------------------------------------
--�Β��Ƀ��[�v(�{�X�|������p)��4105
--------------------------------------------------------------------------------------
--��4105���Β��Ƀ��[�v��
function OnEvent_4105(proxy,param)	

	if proxy:IsCompleteEvent( 4105 ) == true then
		return;
	end	

	print("OnEvent_4105 begin");
	
	proxy:RepeatMessage_begin();
		--��4105_1���I�����j���[�̊Ď���
		proxy:OnSelectMenu(4105, "OnEvent_4105_0", 10010710, 0, 2, 1982, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_4105 end");
end

--��4105_0���I�����j���[�̊Ď���
function OnEvent_4105_0(proxy, param)
	print("OnEvent_4105_0 begin");	
	
	if proxy:IsSession() == false then
		proxy:PlayAnimation( LOCAL_PLAYER , 8283 );--�v�΂ɐG���A�j�����Đ�
		proxy:NoAnimeTurnCharactor( 10000 , 1982 ,TURNSKIP_ANGLE);
		
		
		proxy:NotNetMessage_begin();
			--���v�΂ɐG���A�j���Đ��I����
			proxy:OnChrAnimEnd( 4105 , LOCAL_PLAYER , 8283 , "OnEvent_4105_1" , once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 4105 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_4105_0 end");
end

--��4105_1�������E�ɋA��A�j���Đ��I����
function OnEvent_4105_1(proxy,param)	
	print("OnEvent_4105_1 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ�
	--�Β��֖߂��Ă�������̃t���O�𗧂Ă�
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag( 4105 , 0 );	
	--���S�񕜗v��
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1006 );
	
	print("OnEvent_4105_1 end");
end


--------------------------------------------------------------------------------------
--��350���o�b���߂Â��ƃJ���X����ї���
--------------------------------------------------------------------------------------
function FryAwayKarasu(proxy,param, KarasuEventID, karasuID, KarasuAnimID)	
	print("FryAwayKarasu_"..karasuID.." begin");
	
	proxy:PlayAnimation( karasuID , KarasuAnimID );
	
	proxy:NotNetMessage_begin();
		--���J���X�A�j���Đ��I����
		proxy:OnObjAnimEnd( KarasuEventID , karasuID , KarasuAnimID , "OnEvent_"..KarasuEventID.."_1" , once );	
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( KarasuEventID , true );

	print("FryAwayKarasu_"..karasuID.." end");
end

-----------------------------------------
--�J���X�A�j���Đ��I�������̂ŏ����Ă���
-----------------------------------------
function OnEvent_350_1(proxy,param)	proxy:SetDrawEnable( 1090 , false ); print("KarasuFryAway ID=1090"); end
function OnEvent_351_1(proxy,param)	proxy:SetDrawEnable( 1091 , false ); print("KarasuFryAway ID=1091"); end
--function OnEvent_352_1(proxy,param)	proxy:SetDrawEnable( 1092 , false ); print("KarasuFryAway ID=1092"); end
function OnEvent_353_1(proxy,param)	proxy:SetDrawEnable( 1093 , false ); print("KarasuFryAway ID=1093"); end
function OnEvent_354_1(proxy,param)	proxy:SetDrawEnable( 1094 , false ); print("KarasuFryAway ID=1094"); end
function OnEvent_355_1(proxy,param)	proxy:SetDrawEnable( 1095 , false ); print("KarasuFryAway ID=1095"); end
function OnEvent_356_1(proxy,param)	proxy:SetDrawEnable( 1096 , false ); print("KarasuFryAway ID=1096"); end
function OnEvent_357_1(proxy,param)	proxy:SetDrawEnable( 1097 , false ); print("KarasuFryAway ID=1097"); end
function OnEvent_358_1(proxy,param)	proxy:SetDrawEnable( 1098 , false ); print("KarasuFryAway ID=1098"); end
function OnEvent_359_1(proxy,param)	proxy:SetDrawEnable( 1099 , false ); print("KarasuFryAway ID=1099"); end
function OnEvent_360_1(proxy,param)	proxy:SetDrawEnable( 1100 , false ); print("KarasuFryAway ID=1100"); end
function OnEvent_361_1(proxy,param)	proxy:SetDrawEnable( 1101 , false ); print("KarasuFryAway ID=1101"); end
function OnEvent_362_1(proxy,param)	proxy:SetDrawEnable( 1102 , false ); print("KarasuFryAway ID=1102"); end
function OnEvent_363_1(proxy,param)	proxy:SetDrawEnable( 1103 , false ); print("KarasuFryAway ID=1103"); end
function OnEvent_364_1(proxy,param)	proxy:SetDrawEnable( 1104 , false ); print("KarasuFryAway ID=1104"); end
function OnEvent_365_1(proxy,param)	proxy:SetDrawEnable( 1105 , false ); print("KarasuFryAway ID=1105"); end
function OnEvent_366_1(proxy,param)	proxy:SetDrawEnable( 1106 , false ); print("KarasuFryAway ID=1106"); end
function OnEvent_367_1(proxy,param)	proxy:SetDrawEnable( 1107 , false ); print("KarasuFryAway ID=1107"); end
function OnEvent_368_1(proxy,param)	proxy:SetDrawEnable( 1108 , false ); print("KarasuFryAway ID=1108"); end
function OnEvent_369_1(proxy,param)	proxy:SetDrawEnable( 1109 , false ); print("KarasuFryAway ID=1109"); end
function OnEvent_370_1(proxy,param)	proxy:SetDrawEnable( 1110 , false ); print("KarasuFryAway ID=1110"); end
function OnEvent_371_1(proxy,param)	proxy:SetDrawEnable( 1111 , false ); print("KarasuFryAway ID=1111"); end
function OnEvent_372_1(proxy,param)	proxy:SetDrawEnable( 1112 , false ); print("KarasuFryAway ID=1112"); end
function OnEvent_373_1(proxy,param)	proxy:SetDrawEnable( 1113 , false ); print("KarasuFryAway ID=1113"); end
function OnEvent_374_1(proxy,param)	proxy:SetDrawEnable( 1114 , false ); print("KarasuFryAway ID=1114"); end
function OnEvent_375_1(proxy,param)	proxy:SetDrawEnable( 1115 , false ); print("KarasuFryAway ID=1115"); end
	
---------------------------------
--�J���X����ї��֐����Ăяo��
---------------------------------
function OnEvent_350(proxy, param) FryAwayKarasu(proxy, param, 350, 1090, 11); end
function OnEvent_351(proxy, param) FryAwayKarasu(proxy, param, 351, 1091, 10); end
--function OnEvent_352(proxy, param) FryAwayKarasu(proxy, param, 352, 1092, 12); end
function OnEvent_353(proxy, param) FryAwayKarasu(proxy, param, 353, 1093, 12); end
function OnEvent_354(proxy, param) FryAwayKarasu(proxy, param, 354, 1094, 12); end
function OnEvent_355(proxy, param) FryAwayKarasu(proxy, param, 355, 1095, 12); end
function OnEvent_356(proxy, param) FryAwayKarasu(proxy, param, 356, 1096, 12); end
function OnEvent_357(proxy, param) FryAwayKarasu(proxy, param, 357, 1097, 12); end
function OnEvent_358(proxy, param) FryAwayKarasu(proxy, param, 358, 1098, 12); end
function OnEvent_359(proxy, param) FryAwayKarasu(proxy, param, 359, 1099, 12); end
function OnEvent_360(proxy, param) FryAwayKarasu(proxy, param, 360, 1100, 12); end
function OnEvent_361(proxy, param) FryAwayKarasu(proxy, param, 361, 1101, 12); end
function OnEvent_362(proxy, param) FryAwayKarasu(proxy, param, 362, 1102, 12); end
function OnEvent_363(proxy, param) FryAwayKarasu(proxy, param, 363, 1103, 12); end
function OnEvent_364(proxy, param) FryAwayKarasu(proxy, param, 364, 1104, 12); end
function OnEvent_365(proxy, param) FryAwayKarasu(proxy, param, 365, 1105, 12); end
function OnEvent_366(proxy, param) FryAwayKarasu(proxy, param, 366, 1106, 12); end
function OnEvent_367(proxy, param) FryAwayKarasu(proxy, param, 367, 1107, 12); end
function OnEvent_368(proxy, param) FryAwayKarasu(proxy, param, 368, 1108, 12); end
function OnEvent_369(proxy, param) FryAwayKarasu(proxy, param, 369, 1109, 12); end
function OnEvent_370(proxy, param) FryAwayKarasu(proxy, param, 370, 1110, 12); end
function OnEvent_371(proxy, param) FryAwayKarasu(proxy, param, 371, 1111, 12); end
function OnEvent_372(proxy, param) FryAwayKarasu(proxy, param, 372, 1112, 12); end
function OnEvent_373(proxy, param) FryAwayKarasu(proxy, param, 373, 1113, 12); end
function OnEvent_374(proxy, param) FryAwayKarasu(proxy, param, 374, 1114, 12); end
function OnEvent_375(proxy, param) FryAwayKarasu(proxy, param, 375, 1115, 12); end

--[[
--------------------------------------------------------------------------------------
--���ǂ��󂵂ēG����яo���Ă��遡90
--------------------------------------------------------------------------------------
--��90�����ǂ��󂵂ēG����яo���Ă��遡
function OnEvent_90(proxy,param)	
	print("OnEvent_90 begin");
	
	proxy:SetDrawEnable( 202 , true );	
	proxy:SetColiEnable( 202 , true );

	proxy:PlayAnimation( 1120 , 1 );--���A�j���Đ�
	
	proxy:NotNetMessage_begin();
		--��90_1���U���A�j���̍Đ����Ԃ𒲐���
		proxy:OnKeyTime2( 90 , "OnEvent_90_1" , ( 72.0 / 30.0 ) , 0 , 3 , once );
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( 90 , 1 );
	
	print("OnEvent_90 end");
end


--��90_1���U���A�j���̍Đ����Ԃ𒲐���
function OnEvent_90_1(proxy,param)	
	print("OnEvent_90_1 begin");	
	
	proxy:PlayAnimation( 202 , 7010 );--�U���A�j���Đ�

	proxy:SetEventFlag( 90 , 0 );
	
	proxy:NotNetMessage_begin();
		--��90_2���U���A�j���I���づ
		proxy:OnChrAnimEnd( 90 , 202, 7010, "OnEvent_90_2" , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 90 , 1 );
	
	print("OnEvent_90_1 end");
end


--��90_2���U���A�j���I���っ
function OnEvent_90_2(proxy,param)	
	print("OnEvent_90_2 begin");	
	
	proxy:PlayLoopAnimation( 202 , 500 );--����A�j���Đ�
	
	proxy:SetEventFlag( 90 , 0 );
	
	proxy:NotNetMessage_begin();
		--��90_3������A�j���𐔕b�ԍĐ��づ
		proxy:OnKeyTime2( 90 , "OnEvent_90_3" , 1.0 , 0, 1, once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 90 , 1 );
	
	print("OnEvent_90_2 end");
end

--��90_3������A�j���I���っ
function OnEvent_90_3(proxy,param)	
	print("OnEvent_90_3 begin");	
	
	proxy:StopLoopAnimation( 202 );
	proxy:EnableLogic( 202 , true );
	
	print("OnEvent_90_3 end");
end
]]

--------------------------------------------------------------------------------------
--���ǂ��󂵂ēG����яo���Ă���2��91
--------------------------------------------------------------------------------------
--��91�����ǂ��󂵂ēG����яo���Ă���2��
function OnEvent_91(proxy,param)	
	print("OnEvent_91 begin");
	
	proxy:SetDrawEnable( 215 , true );
	proxy:SetDrawEnable( 216 , true );
	
	proxy:SetColiEnable( 216 , true );
	proxy:SetColiEnable( 215 , true );
	
	proxy:PlayAnimation( 1121 , 1 );--���A�j���Đ�
	proxy:PlayAnimation( 1122 , 1 );--���A�j���Đ�
	
	proxy:NotNetMessage_begin();
		--��91_1���U���A�j���̍Đ����Ԃ𒲐���
		proxy:OnKeyTime2( 91 , "OnEvent_91_1_215" , ( 72.0 / 30.0 ) , 0 , 3 , once );
		proxy:OnKeyTime2( 91 , "OnEvent_91_1_216" , ( 72.0 / 30.0 ) , 0 , 4 , once );
	proxy:NotNetMessage_end();

	print("OnEvent_91 end");
end

--��91_1_215���U���A�j���̍Đ����Ԃ𒲐���
function OnEvent_91_1_215(proxy,param)	
	print("OnEvent_91_1_215 begin");		
	proxy:PlayAnimation( 215 , 7010 );
	proxy:SetEventFlag( 91 , 0 );
	proxy:NotNetMessage_begin();
		--��91_2���U���A�j���I���づ
		proxy:OnChrAnimEnd( 91 , 215, 7010, "OnEvent_91_2_215" , once );
		--proxy:OnKeyTime2(91,"OnEvent_91_2_215",2.0,0,0,once);
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 91 , 1 );
	print("OnEvent_91_1_215 end");
end

--��91_1_216���U���A�j���̍Đ����Ԃ𒲐���
function OnEvent_91_1_216(proxy,param)	
	print("OnEvent_91_1_216 begin");		
	proxy:PlayAnimation( 216 , 7010 );	
	proxy:SetEventFlag( 91 , 0 );	
	proxy:NotNetMessage_begin();
		--��91_2���U���A�j���I���づ
		proxy:OnChrAnimEnd( 91 , 216, 7010, "OnEvent_91_2_216" , once );		
	proxy:NotNetMessage_end();	
	proxy:SetEventFlag( 91 , 1 );	
	print("OnEvent_91_1_216 end");
end

--��91_2_215���U���A�j���I���っ
function OnEvent_91_2_215(proxy,param)	
	print("OnEvent_91_2_215 begin");		
	proxy:PlayLoopAnimation( 215 , 500 );--����A�j���Đ�	
	proxy:SetEventFlag( 91 , 0 );	
	proxy:NotNetMessage_begin();
		--��91_3������A�j���𐔕b�ԍĐ��づ
		proxy:OnKeyTime2( 91 , "OnEvent_91_3_215" , 1.0 , 0, 1, once );
	proxy:NotNetMessage_end();	
	proxy:SetEventFlag( 91 , 1 );	
	print("OnEvent_91_2_215 end");
end

--��91_2_216���U���A�j���I���っ
function OnEvent_91_2_216(proxy,param)	
	print("OnEvent_91_2_216 begin");			
	proxy:PlayLoopAnimation( 216 , 500 );	
	proxy:SetEventFlag( 91 , 0 );	
	proxy:NotNetMessage_begin();
		--��91_3������A�j���𐔕b�ԍĐ��づ
		proxy:OnKeyTime2( 91 , "OnEvent_91_3_216" , 1.0 , 0, 10, once );
	proxy:NotNetMessage_end();	
	proxy:SetEventFlag( 91 , 1 );	
	print("OnEvent_91_2_216 end");
end

--��91_3_215������A�j���I���っ
function OnEvent_91_3_215(proxy,param)	
	print("OnEvent_91_3_215 begin");	
	
	proxy:StopLoopAnimation( 215 );	
	proxy:SetSuperArmor( 215 , false );	
	proxy:EnableLogic( 215 , true );	
	
	print("OnEvent_91_3_215 end");
end

--��91_3_216������A�j���I���っ
function OnEvent_91_3_216(proxy,param)	
	print("OnEvent_91_3_216 begin");	
	
	proxy:StopLoopAnimation( 216 );	
	proxy:SetSuperArmor( 216 , false );	
	proxy:EnableLogic( 216 , true );	
	
	print("OnEvent_91_3_216 end");
end


--------------------------------------------------------------------------------------
--��ʕ��m�������Ă��遡180
--------------------------------------------------------------------------------------
--��180_00���U�����󂯂��Ƃ��̃m�b�N�o�b�N���������p(ID:211)��
function OnEvent_180_00(proxy,param)
	print("OnEvent_180_00 begin");
	
	proxy:PlayAnimation( 211 , 500 ) --�ړ��A�j���Đ�
	
	proxy:NotNetMessage_begin();
		--��180���ړ��A�j���̍Đ��I�����G�������Ă���ց�
		proxy:OnChrAnimEnd( 180 , 211 , 500 , "OnEvent_180" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_180_00 end");
end


--��180_01���U�����󂯂��Ƃ��̃m�b�N�o�b�N���������p(ID:206)��
function OnEvent_180_01(proxy,param)
	print("OnEvent_180_01 begin");
	
	proxy:PlayAnimation( 206 , 500 ) --�ړ��A�j���Đ�
	
	proxy:NotNetMessage_begin();
		--��180���ړ��A�j���̍Đ��I�����G�������Ă���ց�
		proxy:OnChrAnimEnd( 180 , 206 , 500 , "OnEvent_180" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_180_01 end");
end




--��180����ʕ��m�������Ă��遡
function OnEvent_180(proxy,param)
	print("OnEvent_180 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 180 ) == true then
		print("OnEvent_180 end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--����l�ڂ������Ă��遥
		proxy:OnKeyTime2( 180 , "OnEvent_180_211" , 0.0 , 0 , 1 , once );
		--����l�ڂ������Ă��遥
		proxy:OnKeyTime2( 180 , "OnEvent_180_206" , 1.0 , 0 , 2 , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 180 , 1 );
	
	print("OnEvent_180 end");
end




--��180_211����ʕ��m�������Ă���(��l��)��ID211
function OnEvent_180_211(proxy,param)
	print("OnEvent_180_211 begin");

	proxy:SetColiEnable( 211 , false );
	proxy:DisableMapHit( 211, true );
	proxy:SetDisableGravity( 211 , true );
	
	proxy:PlayAnimation( 211 , 7000 );

	proxy:SetEventFlag( 180 , 0 );
	proxy:NotNetMessage_begin();
		--��180_1����э~��A�j���Đ��I����
		proxy:OnKeyTime2( 180 , "OnEvent_180_211_1" , ( 23.0 / 30.0 ) , 0 , 3 , once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 180 , 1 );
	
	print("OnEvent_180_211 end");
end

--��180_211_1����э~��A�j���Đ��I��(��l��)��ID211
function OnEvent_180_211_1(proxy,param)
	print("OnEvent_180_211_1 begin");
	
	proxy:DisableMapHit( 211, false );	
	proxy:SetDisableGravity( 211 , false );
	
	proxy:EnableLogic( 211 , true );
	proxy:SetColiEnable( 211 , true );	
	
	proxy:SetSuperArmor( 211 , false );
	
	proxy:DeleteEvent( 182 );--�_���[�W�Ď�����
	
	print("OnEvent_180_211_1 end");
end




--��180_206����ʕ��m�������Ă���(��l��)��ID206
function OnEvent_180_206(proxy,param)
	print("OnEvent_180_206 begin");

	proxy:SetColiEnable( 206 , false );
	proxy:DisableMapHit( 206, true );
	proxy:SetDisableGravity( 206 , true );
	
	proxy:PlayAnimation( 206 , 7000 );

	proxy:SetEventFlag( 180 , 0 );
	proxy:NotNetMessage_begin();
		--��180_1����э~��A�j���Đ��I����
		proxy:OnKeyTime2( 180 , "OnEvent_180_206_1" , ( 23.0 / 30.0 ) , 0 , 4 , once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 180 , 1 );
	
	--�t���O�𗧂Ă�(�w�����ɍ��킹�邽��)
	proxy:SetEventFlag( 181 , 1 );
	
	print("OnEvent_180_206 end");
end

--��180_206_1����э~��A�j���Đ��I��(��l��)��ID206
function OnEvent_180_206_1(proxy,param)
	print("OnEvent_180_206_1 begin");
	
	proxy:DisableMapHit( 206, false );	
	proxy:SetDisableGravity( 206 , false );
	
	proxy:EnableLogic( 206 , true );
	proxy:SetColiEnable( 206 , true );	
	proxy:SetSuperArmor( 206 , false );
	
	proxy:DeleteEvent( 183 );--�_���[�W�Ď�����
	proxy:DeleteEvent( 180 );--�̈�Ď�������
	
	print("OnEvent_180_206_1 end");
end


--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m02_00_00_00(proxy, param)
	print("PlayerDeath_m02_00_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m02_00_00_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerDeath_m02_00_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m02_00_00_00(proxy,param)
	print("PlayerRevive_m02_00_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m02_00_00_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerRevive_m02_00_00_00");
end






--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ��遡110
--------------------------------------------------------------------------------------

--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫

--��110�����{�X�����ւ̔����J����
function OnEvent_110(proxy,param)
	print("OnEvent_110 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_110 end");
		return;
	end
	--�N���C�A���g�ցA�{�X�����j�~���s��ʒm
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	--�������g���t�@�����N�X������
	if param:IsNetMessage() == false then
		PhalanxStandBy(proxy,param);
	end
	
	proxy:LuaCallStart( 111, 1 );--����A�j���̓����Đ�
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--���d�N���V�X�e��ID���^�C���A�E�g��ݒ肵��ON�ɂ���
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_110 end");
end


--����A�j���̓����Đ�(ID����)
function OnEvent_111_1(proxy,param)
	print("OnEvent_111_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ����s���A���̏I������OnEvent_111_2�𔭍s����
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2891 );
		else
			proxy:LockSession();--���[�������b�N���܂��I
			--����A�j���Đ����s���A���̏I������OnEvent_111_2�𔭍s����
			proxy:OnTurnCharactorEnd( 111, LOCAL_PLAYER, 2891, "OnEvent_111_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_111_1 end");
end

--����A�j���̓����Đ��I����
function OnEvent_111_2(proxy,param)
	print("OnEvent_111_2 begin");

	--�����p�����A�j���Đ�
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 111, LOCAL_PLAYER, ANIMEID_WALK, "OnEvent_111_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_111_2 end");
end

--�����A�j���̓����Đ��I����
function OnEvent_111_3(proxy,param)
	print("OnEvent_111_3 begin");

	--�ŏ��̐l���{�X�����̒��ɓ���I����Ă�����A���ɔz�M����Ă���͂��Ȃ̂ŁA����������Ȃ��n���h��
	if proxy:IsCompleteEvent( 110 ) == false then
		proxy:LuaCallStart( 111 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCallStart( 4045 , 1 );	--�N���C�A���g�ցA�{�X�����ɓ����悤�ɂȂ������Ƃ�ʒm
		proxy:LuaCallStart( 111 , 6 );--�t���O�Z�b�g(�����p)
		local eneidlist = {800,
		860,861,862,863,864,865,866,867,868,869,
		870,871,872,873,874,875,876,877,878,879,
		880,881,882,883,884,885,886,887,888,889,
		890,891,892,893,894,895,896,897};
		
		local num = table.getn(eneidlist);
		for index = 1, num , 1 do
			Lua_MultiDoping(proxy,eneidlist[index]);--�}���`�v���C�h�[�s���O
		end		
	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�)
	if proxy:IsClient() == false then
		proxy:ResetThink( 800 );
	end	
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );

	print("OnEvent_111_3 end");
end


--��110 2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
function OnEvent_110_GO_TO_IN(proxy, param)
	print("OnEvent_110_GO_TO_IN begin");

	proxy:NotNetMessage_begin();
		--��111�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���--�n���h���� OnEvent_110
		proxy:OnPlayerActionInRegion( 111, 2895, "OnEvent_110", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	

	print("OnEvent_110_GO_TO_IN end");
end


--��110 �t���O�Z�b�g(�����p)
function OnEvent_110_flag_set(proxy, param)
	print("OnEvent_110_flag_set begin");
		
	proxy:SetEventFlag( 110 , 1 );
	proxy:DeleteEvent( 110 ); 

	print("OnEvent_110_flag_set end");
end



--------------------------------------------------------------------------------------
--�{�X�������o��(�퓬�J�n)��114
--------------------------------------------------------------------------------------

function OnEvent_114(proxy, param)
	print("OnEvent_114 begin");
	
	--�{�X��pBGM�Đ��J�n
	proxy:PlayPointSE( 2160, SOUND_TYPE_M, 20000000, 0 );
	
	--�t�@�����N�X�̓���J�n
	PhalanxEventStart(proxy,param); 
	
	--�ǂݍ��݃^�C�~���O�̂Ƃ�����ǉ�����Ăق����̂Ńt���O���ĂȂ�
	
	--�{�X�Q�[�W���Z�b�g
	proxy:SetBossGauge(800,0,5001);	
	
	--�����X�V��z�M
	proxy:LuaCallStart( 114 , 10 );
	print("OnEvent_114 end");
end

--�{�X�����ɓ�����PC�ׂ̈ɋ����X�V��z�M
function OnEvent_114_1(proxy,param)
	print("OnEvent_114_1 begin");
	if param:IsNetMessage() == true then
		--LuaFunc_ForceOmission(proxy,10001+param:GetPlayID());
		proxy:SetAlwaysDrawForEvent(10001+param:GetPlayID(),true);
	else
		--LuaFunc_ForceOmission(proxy,10000);
	end
	print("OnEvent_114_1 end");
end


--------------------------------------------------------------------------------------
--��200�����Y��ւ̔���
--------------------------------------------------------------------------------------
--[[
--��200_1�����Y��ւ̔���LuaCall��`
function OnEvent_200_1(proxy, param)
	print("OnEvent_200_1 begin");

	proxy:PlayAnimation( 1040, 1 );--�����J���A�j���[�V����
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 200, 1 );
		proxy:DeleteEvent( 200 );--�p�[�e�B�[�v���C���[�̊Ď��폜
		print("OnEvent_200_1 end");
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1040 , 191 );
	proxy:SetEventFlag( 200, 1 );
	proxy:DeleteEvent( 200 );--�����̊Ď��폜

	print("OnEvent_200_1 end");
end


--��200�����Y��ւ̔���
function OnEvent_200(proxy, param)
	print("OnEvent_200 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 200 ) == true then
		print("OnEvent_200 end");
		return;
	end
	
	--QWC�����͖������Ă��邩�H
	if	proxy:IsCompleteEvent( 201 ) == true then
		proxy:LuaCallStart( 200 , 1 );--�A�j���[�V�����̓����Đ�(�S�̂ɔz�M)	

	--�K�v�A�C�e�����������Ă��Ȃ�
	else
		--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\��
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1040, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_200 end");
end
]]


--------------------------------------------------------------------------------------
--��210����_�ւ̔���
--------------------------------------------------------------------------------------

--��210_1����_�ւ̔���LuaCall��`
function OnEvent_210_1(proxy, param)
	print("OnEvent_210_1 begin");

	proxy:PlayAnimation( 1045, 1 );--�����J���A�j���[�V����
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 210 , 1 );
		proxy:DeleteEvent( 210 );
		print("OnEvent_210_1 end");
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1045 , 191 );
	proxy:SetEventFlag( 210, 1 );

	print("OnEvent_210_1 end");
end


--��210����_�ւ̔���
function OnEvent_210(proxy, param)
	print("OnEvent_210 begin");
	
	--���d�����h�~
	if proxy:IsCompleteEvent( 210 ) == true then
		print("OnEvent_210 end");
		return;
	end
	
	--�K�v�A�C�e���̎w��
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 35;--��_�̌�
	
	--�K�v�A�C�e�����������Ă���(�C���x���g���[�ɃA�C�e���Ƃ��ď������Ă���)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--��210_3���I�����j���[�̊Ď���
			--proxy:OnSelectMenu(210, "OnEvent_210_3", 10010829, 0, 1, 1045, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010829, 0, 6, 1045, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_210_3(proxy,param);

	--�K�v�A�C�e�����������Ă��Ȃ�
	else
		--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\��
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1045, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_210 end");
end


--��210_3���I�����j���[�̊Ď���(YES��I�������Ƃ�)
function OnEvent_210_3(proxy,param)
	print("OnEvent_210_3 begin");
	proxy:LuaCallStart( 210 , 1 );--�A�j���[�V�����̓����Đ�(�S�̂ɔz�M)	
	proxy:DeleteEvent( 210 );	
	print("OnEvent_210_3 end");
end
	

--------------------------------------------------------------------------------------
--��211����_�ւ̔���
--------------------------------------------------------------------------------------

--��211_1����_�ւ̔���LuaCall��`
function OnEvent_211_1(proxy, param)
	print("OnEvent_211_1 begin");

	proxy:PlayAnimation( 1047, 1 );--�����J���A�j���[�V����
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 211, 1 );		
		proxy:DeleteEvent( 211 );
		print("OnEvent_211_1 end");
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1047 , 191 );
	proxy:SetEventFlag( 211, 1 );

	print("OnEvent_211_1 end");
end


--��211����_�ւ̔�2��
function OnEvent_211(proxy, param)
	print("OnEvent_211 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 211 ) == true then
		print("OnEvent_211 end");
		return;
	end
	
	--�K�v�A�C�e���̎w��
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 35;--��_�̌�
	
	--�K�v�A�C�e�����������Ă���(�C���x���g���[�ɃA�C�e���Ƃ��ď������Ă���)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--��211_3���I�����j���[�̊Ď���
			--proxy:OnSelectMenu(211, "OnEvent_211_3", 10010829, 0, 2, 1047, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010829, 0, 6, 1047, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_211_3(proxy,param);

	--�K�v�A�C�e�����������Ă��Ȃ�
	else
		--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\��
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1047, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_211 end");
end


--��211_3���I�����j���[�̊Ď���(YES��I�������Ƃ�)
function OnEvent_211_3(proxy,param)
	print("OnEvent_211_3 begin");
	proxy:LuaCallStart( 211 , 1 );--�A�j���[�V�����̓����Đ�(�S�̂ɔz�M)	
	proxy:DeleteEvent( 211 );
	print("OnEvent_211_3 end");
end


--------------------------------------------------------------------------------------
--��5����_�̍Ւd��
--------------------------------------------------------------------------------------

function OnEvent_5(proxy, param)
	if param:IsNetMessage() == false then
	print("OnEvent_5 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:PlayAnimation( 10000 , 8290);		
		proxy:PlayAnimation( 1192 , 1);	
		proxy:OnKeyTime2( 5 , "OnEvent_5_0",0.01,0,0,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();	
	print("OnEvent_5 end");
	end
end

function OnEvent_5_0(proxy,param)
	print("OnEvent_5_0 begin");
	--if proxy:IsPlayerStay(10000) == true then
	if proxy:IsEventAnim( 10000 , 8290 ) == true then
		proxy:LuaCallStart( 5 , 2 );
	else
		proxy:ForcePlayAnimation( 1192 , 0);	
	end
	print("OnEvent_5_0 end");
end

--��5_1���A�C�e���擾��
function OnEvent_5_1(proxy, param)
	print("OnEvent_5_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10104�Q��
	proxy:GetRateItem(10104);	
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 5, 1 );
	
	--OBJ���������߂̃C�x���g�z�M
	proxy:LuaCallStart( 5, 1);
	
	print("OnEvent_5_1 end");
end

--��5_2����OBJ��\���p��
function OnEvent_5_2(proxy,param)
	print("OnEvent_5_2 begin");
	--�I�u�W�F��������
	proxy:SetDrawEnable( 1192 , false );--�ЂƂ܂��`�悾��OFF
	proxy:SetColiEnable( 1192 , false );--������͂���͕̂s��(����ł͂Ȃ��悤�Ȃ̂ŏ����Ȃ�)	
	
	--�C�x���g������
	proxy:DeleteEvent( 5 );
	print("OnEvent_5_2 end");
end

--�A�j���Đ��̓������Ď�
function OnEvent_5_3(proxy,param)
	print("OnEvent_5_3 begin");
	
	proxy:TreasureDispModeChange2( 1192, false ,KEN_SFX);
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8290 ) == true then--�V�����A�j�� 
		proxy:PlayAnimation( 1192 , 1);	
		print("OnEvent_5 end");
		return true;
	end
	
	--���Ƀ��[�v
	proxy:WarpDmy( LOCAL_PLAYER , 1192 , 191 );		
	
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 5 , LOCAL_PLAYER , 8290 , "OnEvent_5_1", once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_5_3 end");
end



--------------------------------------------------------------------------------------
--��220����(��)���Q�Ă��遡
--------------------------------------------------------------------------------------

TYOU_STATE_WAIT = 0;
TYOU_STATE_ATACK = 1;
TYOU_STATE_ATACK_DILAY = 2;

tyou_state_in_home = TYOU_STATE_WAIT;

function OnEvent_220(proxy, param)
--	print("OnEvent_220 begin");

	--�ҋ@���(�U���\)
	if tyou_state_in_home == TYOU_STATE_WAIT then
			
		tyou_state_in_home = TYOU_STATE_ATACK;--�U����Ԃ�
		
		proxy:StopLoopAnimation( 300 );--�ҋ@�A�j���Ƃ߂�
		proxy:PlayAnimation( 300 , 3001 );--�U���A�j���Đ��J�n
		proxy:SetEventFlag( 220 , 0 );
		proxy:NotNetMessage_begin();
			--��220���U���A�j���̏I����
			proxy:OnChrAnimEnd( 220 , 300 , 3001 , "OnEvent_220_atack_end" , once );
		proxy:NotNetMessage_end();
		proxy:SetEventFlag( 220 , 1 );
	
	--�U����
	elseif tyou_state_in_home == TYOU_STATE_ATACK then
			
	--�čU���҂�
	elseif tyou_state_in_home == TYOU_STATE_ATACK_DILAY then
	
	end
	
--	print("OnEvent_220 end");
end

--��220���U���A�j���̏I����
function OnEvent_220_atack_end(proxy ,param)
	print("OnEvent_220_atack_end begin");
	
	--�U���I������̂ŁA�čU���҂���Ԃ�
	tyou_state_in_home = TYOU_STATE_ATACK_DILAY;
	
	proxy:SetEventFlag( 220 , 0 );
	proxy:NotNetMessage_begin();
		--��220_dilay_end���čU���ҋ@��
		local dilay_time = 3.0;--3�b
		proxy:OnKeyTime2( 220 , "OnEvent_220_atack_dilay_end" , dilay_time , 0 , 1 , once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 220 , 1 );
	
	proxy:PlayLoopAnimation( 300, 7000 );--�ҋ@�A�j�����[�v�Đ�
	
	print("OnEvent_220_atack_end end");
end


--��220���U���A�j���̏I����
function OnEvent_220_atack_dilay_end(proxy ,param)
	print("OnEvent_220_atack_dilay_end begin");
	
	--�U���܂���Ԃ�������̂ŁA�čU���\���ҋ@��Ԃ�
	tyou_state_in_home = TYOU_STATE_WAIT;
		
	print("OnEvent_220_atack_dilay_end end");
end



--------------------------------------------------------------------------------------
--��221����(�ő�)���x�����Ă��遡
--------------------------------------------------------------------------------------

KENZOKU_STATE_WAIT = 0;--�ҋ@���
KENZOKU_STATE_ATACK = 1;--�U�����(�͈͓��ɂ���Ƃ�)
KENZOKU_STATE_ATACK_DILAY = 2;--�U���̂��Ƃ̑ҋ@�� �U���҂����

kenzoku_state_in_home = KENZOKU_STATE_WAIT;--�ŏ��͂Ƃ肠�����ҋ@
--�������������Ƃ�����A�t���O3�����ď��������ɍČ�?

--�ҋ@���U���ɂȂ�Ƃ��ɁA3�b���ƁA�A�j���̓r������Đ��ɂȂ�̂ŁA1�񕪌�
--�Ƃ��̂ق����ǂ���������Ȃ�?
kenzoku_play_anime_id = 0;
function OnEvent_199(proxy,param)
	print("OnEvent_199 begin");

	--���ɂ����Ԏ��ɒ��߂ɐ؂�ւ�
	if	proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true and
		proxy:IsCompleteEvent( 0 ) == true then
		SetNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_WARNING_AND_LEVER );
	end
	
	--�����x�����@or�@�����x����(���o�[�j�~�������)�@�̏ꍇ�œP�ރt���OON
	if	   (proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true   or
			proxy:IsCompleteEvent( KENZOKU_STATE_WARNING_AND_LEVER ) == true ) and
			proxy:IsCompleteEvent( 234 ) == true then
		print("OnEvent_199 -> OnEvent_234_1");
		--��OnEvent_234_1
		proxy:LuaCallStart( 234, 2 );
	
	--��230���C�x���g����
	elseif	proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true and
			proxy:IsCompleteEvent( 222 ) == true then
		print("OnEvent_199 -> OnEvent_230_1");
		--��OnEvent_230_1
		proxy:LuaCallStart( 230, 1 );
	--��221���C�x���g����
	elseif	(proxy:IsCompleteEvent( KENZOKU_STATE_WARNING_AND_LEVER ) == true or
		 proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true ) and
		proxy:IsCompleteEvent( 222 ) == false and
		proxy:IsCompleteEvent( 223 ) == true then
		print("OnEvent_199 -> OnEvent_221_1");
		--��OnEvent_221_1
		proxy:LuaCallStart( 221, 1 );
		
	--��190���C�x���g����
	elseif (proxy:IsCompleteEvent( KENZOKU_STATE_WARNING_AND_LEVER ) == true or
			proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true ) and
			proxy:IsCompleteEvent( 222 ) == false and
			proxy:IsCompleteEvent( 223 ) == false and
			proxy:IsCompleteEvent( 224 ) == true then
		print("OnEvent_199 -> OnEvent_190_1");
		--��OnEvent_190_1
		proxy:LuaCallStart( 190, 1 );
		
	--��191���C�x���g����
	elseif (proxy:IsCompleteEvent( KENZOKU_STATE_WARNING_AND_LEVER ) == true or
			proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true ) and
			proxy:IsCompleteEvent( 222 ) == false and
			proxy:IsCompleteEvent( 223 ) == false and
			proxy:IsCompleteEvent( 224 ) == false and
			proxy:IsCompleteEvent( 225 ) == true then
		print("OnEvent_199 -> OnEvent_191_1");
		--��OnEvent_191_1
		proxy:LuaCallStart( 191, 1 );
		
		
	--�������ǂ֔��ł��闬��
	--��231���C�x���g����
	elseif	proxy:IsCompleteEvent( KENZOKU_STATE_PROTECT_CASTLE ) == true and
			proxy:IsCompleteEvent( 222 ) == true and
			proxy:IsCompleteEvent( 0 )   == false and
			proxy:IsCompleteEvent( 234 ) == false then
		if	kenzoku_play_anime_id == 7001 or
			kenzoku_play_anime_id == 7002 or
			kenzoku_play_anime_id == 7005 then
			print("OnEvent_199 -> OnEvent_231_1");
			--��OnEvent_231_1
			proxy:LuaCallStart( 231, 1 );
		elseif	kenzoku_play_anime_id == 7004 then
			print("OnEvent_199 -> OnEvent_231_2");
			--��OnEvent_231_2
			proxy:LuaCallStart( 231, 2 );
		else
			print("OnEvent_199 -> 231 Failed");
			print("animId = ", kenzoku_play_anime_id);
		end
		
	--�u���X���[�v����P�ނւ̗���
	--��232���C�x���g����
	--��233���C�x���g����
	--�̈�ɒN�����Ȃ� or ���o�[�������ꂽ or ���������ɂ���
	elseif	(proxy:IsCompleteEvent( KENZOKU_STATE_PROTECT_CASTLE ) == true and
			 proxy:IsCompleteEvent( 222 ) == false ) or
			(proxy:IsCompleteEvent( KENZOKU_STATE_PROTECT_CASTLE ) == true and
			proxy:IsCompleteEvent( 0 ) == true ) or
			(proxy:IsCompleteEvent( KENZOKU_STATE_PROTECT_CASTLE ) == true and
			proxy:IsCompleteEvent( 234 ) == true ) then
			
		--�ʏ�̑��ɖ߂邩
		if	proxy:IsCompleteEvent( 0 ) == true then
			SetNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_WARNING_AND_LEVER );
		else
			SetNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_WARNING );
		end
		
		if	kenzoku_play_anime_id == 7002 or
			kenzoku_play_anime_id == 7004 or
			kenzoku_play_anime_id == 7005 then
			print("OnEvent_199 -> OnEvent_232_1");
			--��OnEvent_232_1
			proxy:LuaCallStart( 232, 1 );
		elseif	kenzoku_play_anime_id == 7003 then
			print("OnEvent_199 -> OnEvent_232_2");
			--��OnEvent_232_2
			proxy:LuaCallStart( 232, 2 );
		else
			print("OnEvent_199 -> 232 Failed");
			print("animId = ", kenzoku_play_anime_id);
		end
		
	--��199���f�t�H���g�ҋ@�A�j�����[�v
	else
			print("OnEvent_199 -> OnEvent_199_default");
		--��OnEvent_199_default
		proxy:LuaCallStart( 199, 1 );
	end
	print("OnEvent_199 end");
end


--�򗳃A�j���I���̐߂ɕK���ʂ�C�x���g
function OnEvent_199_anim_end(proxy,param)
	print("OnEvent_199_anim_end begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 199, "OnEvent_199", 0.0, 0, 2, once );
	proxy:NotNetMessage_end();
	print("OnEvent_199_anim_end end");
end


function OnEvent_199_default(proxy,param)
	print("OnEvent_199_default begin");
	
	kenzoku_play_anime_id = 0;
	proxy:ForcePlayAnimation( 301, 0 );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_199_default return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 199, 301, 0, "OnEvent_199_anim_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_199_default end");
end


--------------------------------------------------------------------------------------
--��221����(�ő�)���\���P���҂��P�`�R�b��
--------------------------------------------------------------------------------------
function OnEvent_221_1(proxy, param)
	print("OnEvent_221_1 begin");

	kenzoku_play_anime_id = 3001;
	proxy:ForcePlayAnimationStayCancel( 301, 3001 );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_221_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		--��221���U���A�j���̏I����
		proxy:OnChrAnimEnd( 221 , 301 , 3001 , "OnEvent_221_1_1" , once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_221_1 end");
end

function OnEvent_221_1_1(proxy,param)
	--��OnEvent_221_2
	proxy:LuaCallStart( 221, 2 );
end


--��221���U���A�j���̏I����
function OnEvent_221_2(proxy ,param)
	print("OnEvent_221_2 begin");
	
	kenzoku_play_anime_id = 0;
	proxy:ForcePlayLoopAnimation( 301, 0 );--�ҋ@�A�j�����[�v�Đ�
	
	if	param:IsNetMessage() == true then
		print("OnEvent_221_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--��221_dilay_end���čU���ҋ@��
		local dilay_time = proxy:GetRandom( 10, 30 ) / 10;--1�b�`3�b
		proxy:OnKeyTime2( 221 , "OnEvent_199_anim_end" , dilay_time , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_221_2 end");
end

--------------------------------------------------------------------------------------
--��190����(�ő�)���\���Q���҂��P�`�R�b��
--------------------------------------------------------------------------------------
function OnEvent_190_1(proxy,param)
	print("OnEvent_190_1 begin");
	kenzoku_play_anime_id = 3003;
	proxy:ForcePlayAnimation( 301, 3003 );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_190_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		--��221���U���A�j���̏I����
		proxy:OnChrAnimEnd( 221 , 301 , 3003 , "OnEvent_190_1_1" , once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_190_1 end");
end

function OnEvent_190_1_1(proxy,param)
	print("OnEvent_190_1_1 begin");
	--��OnEvent_190_2
	proxy:LuaCallStart( 190, 2 );
	print("OnEvent_190_1_1 end");
end


function OnEvent_190_2(proxy,param)
	print("OnEvent_190_2 begin");
	
	kenzoku_play_anime_id = 0;
	proxy:ForcePlayLoopAnimation( 301, 0 );--�ҋ@�A�j�����[�v�Đ�
	
	if	param:IsNetMessage() == true then
		print("OnEvent_190_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		local dilay_time = proxy:GetRandom( 10, 30 ) / 10;--1�b�`3�b
		proxy:OnKeyTime2( 190 , "OnEvent_199_anim_end" , dilay_time , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_190_2 end")
end



--------------------------------------------------------------------------------------
--��191����(�ő�)���\���R���҂��P�`�R�b��
--------------------------------------------------------------------------------------
function OnEvent_191_1(proxy,param)
	print("OnEvent_191_1 begin");
	kenzoku_play_anime_id = 3002;
	proxy:ForcePlayAnimation( 301, 3002 );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_191_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		--��221���U���A�j���̏I����
		proxy:OnChrAnimEnd( 221 , 301 , 3002 , "OnEvent_191_1_1" , once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_191_1 end");
end

function OnEvent_191_1_1(proxy,param)
	print("OnEvent_191_1_1 begin");
	--��OnEvent_191_2
	proxy:LuaCallStart( 191, 2 );
	print("OnEvent_191_1_1 end");
end

function OnEvent_191_2(proxy,param)
	print("OnEvent_191_2 begin");
	
	kenzoku_play_anime_id = 0;
	proxy:ForcePlayLoopAnimation( 301, 0 );--�ҋ@�A�j�����[�v�Đ�
	
	if	param:IsNetMessage() == true then
		print("OnEvent_191_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		local dilay_time = proxy:GetRandom( 10, 30 ) / 10;--1�b�`3�b
		proxy:OnKeyTime2( 191 , "OnEvent_199_anim_end" , dilay_time , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_191_2 end")
end


--------------------------------------------------------------------------------------
--��230����(�ő�)�����ł��遨�u���X�f����
--------------------------------------------------------------------------------------

function OnEvent_230_1(proxy, param)
	print("OnEvent_230_1 begin");

	--�ʒu�E�p�x�����킹�邽�߂Ƀ��[�v
	proxy:Warp(301,2030);

	--��(�ő�)���򗧂A�j��
	kenzoku_play_anime_id = 7000;
	proxy:ForcePlayAnimationStayCancel( 301 , 7000 );
	
	--��(�ő�)�̏�Ԃ���ǌ��ɃZ�b�g
	SetNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_PROTECT_CASTLE );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_230_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		--��230_1����(�ő�)���򗧂A�j���Đ��I����
		proxy:OnChrAnimEnd( 230 , 301, 7000, "OnEvent_230_1_1" , once);
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_230_1 end");
end

function OnEvent_230_1_1(proxy,param)
	print("OnEvent_230_1_1 begin");
	--��OnEvent_230_2
	proxy:LuaCallStart( 230, 2 );
	print("OnEvent_230_1_1 end");
end


--��230_2����(�ő�)���򗧂A�j���Đ��I����
function OnEvent_230_2(proxy , param )
	print("OnEvent_230_2 begin");
	
	--�ʒu�E�p�x�����킹�邽�߂Ƀ��[�v
	proxy:Warp(301,2031);
	
    --��(�ő�)�����ł���A�j��
	kenzoku_play_anime_id = 7002;
	proxy:ForcePlayAnimationStayCancel( 301 , 7002 );

	if	param:IsNetMessage() == true then
		print("OnEvent_230_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--��231����(�ő�)�����ł���A�j���Đ��I����
		proxy:OnChrAnimEnd( 230 , 301 , 7002 , "OnEvent_199_anim_end" , once );
	proxy:NotNetMessage_end();
	

	print("OnEvent_230_2 end");
end


--------------------------------------------------------------------------------------
--��231����(�ő�)���u���X�f��1���u���X�f��2���[�v��
--------------------------------------------------------------------------------------
--��231����(�ő�)�����ł���A�j���Đ��I����
function OnEvent_231_1(proxy , param )
	print("OnEvent_231_1 begin");
	
	--�ʒu�E�p�x�����킹�邽�߂Ƀ��[�v
	proxy:Warp(301,2032);

	--��тȂ���u���X�U���A�j��1
	kenzoku_play_anime_id = 7004;
	proxy:ForcePlayAnimationStayCancel( 301 , 7004 );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_231_1 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--��231_1����тȂ���u���X�U���A�j��1�I����
		proxy:OnChrAnimEnd( 231 , 301 , 7004 , "OnEvent_231_1_1" , once );
	proxy:NotNetMessage_end();


	print("OnEvent_231_1 end");
end


function OnEvent_231_1_1(proxy,param)
	print("OnEvent_231_1_1 begin");
	--��OnEvent_231_2
	proxy:LuaCallStart( 231, 2 );
	print("OnEvent_231_1_1 end");
end


--��231_1����тȂ���u���X�U���A�j��1�I����
function OnEvent_231_2(proxy , param )
	print("OnEvent_231_2 begin");

	--�ʒu�E�p�x�����킹�邽�߂Ƀ��[�v
	proxy:Warp(301,2032);
	
	--��тȂ���u���X�U���A�j��2
	kenzoku_play_anime_id = 7005;
	proxy:ForcePlayAnimationStayCancel( 301 , 7005 );

	
	if	param:IsNetMessage() == true then
		print("OnEvent_231_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--��231_2����тȂ���u���X�U���A�j��2�I����
		proxy:OnChrAnimEnd( 231 , 301 , 7005 , "OnEvent_199_anim_end" , once );
	proxy:NotNetMessage_end();

	print("OnEvent_231_2 end");
end



--------------------------------------------------------------------------------------
--��232����(�ő�)���A���Ă�����
--------------------------------------------------------------------------------------

function OnEvent_232_1(proxy, param)
	print("OnEvent_232_1 begin");

	--�ʒu�E�p�x�����킹�邽�߂Ƀ��[�v
	proxy:Warp(301,2034);
	
	--��тȂ���u���X�U���A�j��2
	kenzoku_play_anime_id = 7003;
	proxy:ForcePlayAnimationStayCancel( 301 , 7003 );

	if	param:IsNetMessage() == true then
		print("OnEvent_232_1 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--��232_1����(�ő�)�������Ă����A�j���I����
		proxy:OnChrAnimEnd( 232 , 301 , 7003 , "OnEvent_232_1_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_232_1 end");
end

function OnEvent_232_1_1(proxy,param)
	print("OnEvent_232_1_1 begin");
	--��OnEvent_232_2
	proxy:LuaCallStart( 232, 2 );
	print("OnEvent_232_1_1 end");
end

--��232_1����(�ő�)�������Ă����A�j���I����
function OnEvent_232_2(proxy, param)
	print("OnEvent_232_2 begin");

	--�ʒu�E�p�x�����킹�邽�߂Ƀ��[�v
	proxy:Warp(301,2035);
	
	--��тȂ���u���X�U���A�j��2
	kenzoku_play_anime_id = 7001;
	proxy:ForcePlayAnimation( 301 , 7001 );

	if	param:IsNetMessage() == true then
		print("OnEvent_232_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--��232_2����(�ő�)���Q���ɖ߂�A�j���I����
		proxy:OnChrAnimEnd( 232 , 301 , 7001 , "OnEvent_232_3" , once );
		--proxy:OnChrAnimEnd( 232 , 301 , 7001 , "OnEvent_199_anim_end" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_232_2 end");
end

function OnEvent_232_3(proxy,param)
	print("OnEvent_232_3 begin");
	
	--�ʒu�E�p�x�����킹�邽�߂Ƀ��[�v
	proxy:Warp( 301,2036);
	OnEvent_199_anim_end(proxy,param);
	
	print("OnEvent_232_3 end");
end

--------------------------------------------------------------------------------------
--��234����(�ő�)�̎��S�Ď���
--------------------------------------------------------------------------------------

function OnEvent_234(proxy , param)
	print( "OnEvent_234 begin" );
	
	--�P�ނ����t���O�𗧂Ă�
	proxy:SetEventFlag( 234, true );
	
--[[	
	--��(�ő�)�̏�Ԃ����S�ɂ���
	--SetNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_DEAD );
	
	--��(�ő�)�֘A�C�x���g�폜
	proxy:DeleteEvent( 221 );--���Ōx�����Ă���
	proxy:DeleteEvent( 230 );--��ǂɔ��ł���
	
	proxy:OnKeyTime2( 234, "OnEvent_234_1", 0.0, 0, 2, once );

	--�z�X�g�̂݃A�C�e������
	if	proxy:IsClient() == false then
		proxy:GetRateItem( 10118 );--�A�C�e������
	end
]]	
	print( "OnEvent_234 end" );
end

--LuaCallParam(234,2)
function OnEvent_234_1(proxy,param)
	print("OnEvent_234_1 begin");
	
	--�ʒu�E�p�x�����킹�邽�߂Ƀ��[�v
	proxy:Warp(301,2030);
	
	--��тȂ���u���X�U���A�j��2
	kenzoku_play_anime_id = 7011;
	proxy:ForcePlayAnimation( 301 , 7011 );

	--�����͑S���o�^����
	proxy:NotNetMessage_begin();
		--��232_1����(�ő�)�������Ă����A�j���I����
		proxy:OnChrAnimEnd( 199 , 301 , 7011 , "OnEvent_234_1_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_234_1 end");
end

--�P�ރA�j���I���Ŗ�����
function OnEvent_234_1_1(proxy,param)
	print("OnEvent_234_1_1 begin");
	SetNpcStateFlag(proxy, param, kenzoku_flag_list, KENZOKU_STATE_ESCAPE );
	InvalidCharactor( proxy, 301 );
	print("OnEvent_234_1_1 end");
end



--[[
function OnEvent_234_1(proxy,param)
	print("OnEvent_234_1 begin");
	
	--proxy:OnRegistFunc(234, "Condition_234_anim_wait", "OnEvent_234_2", 2, once);
	--�L�����Ȃ̂ŁA�����ł̃A�j��ID�ɈӖ��͖����A�����ڂ����ׂɎg�p
	if	proxy:IsEventAnim( 301, 10 ) == true then
		proxy:OnChrAnimEnd( 234, 301, 10, "OnEvent_234_2", once );
	else
		OnEvent_234_2(proxy,param);
	end
	
	print("OnEvent_234_1 end");
end


function Condition_234_anim_wait(proxy,param)
	if	proxy:IsEventAnim(301, 7011) == false then
		return false;
	end
	return true;
end


function OnEvent_234_2(proxy,param)
	print("OnEvent_234_2 begin");
	proxy:ForcePlayAnimation( 301, 7011 );
	proxy:Warp(301, 2030);
	
	proxy:OnChrAnimEnd( 234, 301, 7011, "OnEvent_234_3", once );
	proxy:SetEventFlag( 234 , 1 );
	print("OnEvent_234_2 end");
end

--�򗳂��ő��@�P�ރA�j���I����A������
function OnEvent_234_3(proxy,param)
	print("OnEvent_234_3 begin");
	InvalidCharactor(proxy, 301);
	print("OnEvent_234_3 end");
end
]]
--------------------------------------------------------------------------------------
--��235����(��)�̎��S�Ď���
--------------------------------------------------------------------------------------

function OnEvent_235(proxy , param)
	print( "OnEvent_235 begin" );

	--�򗳂̒��͓P�ނ��邾���ŁA���񂾂킯�ł͂Ȃ�
	--SetNpcStateFlag( proxy , param , tyo_flag_list , TYO_STATE_DEAD );
	
	--��(��)�֘A�C�x���g�폜
	proxy:DeleteEvent( 220 );--���ŐQ�Ă���
	
	proxy:OnKeyTime2( 235, "OnEvent_235_1", 0.0, 0, 2, once );

	print( "OnEvent_235 end" );
end

function OnEvent_235_1(proxy,param)
	print( "OnEvent_235_1 begin" );
	
	--proxy:OnRegistFunc(235, "Condition_235_anim_wait", "OnEvent_235_2", 2, once);
	--�L�����Ȃ̂ŁA�����ł̃A�j��ID�ɈӖ��͖����A�����ڂ����ׂɎg�p
	if	proxy:IsEventAnim( 300, 10 ) == true then
		proxy:OnChrAnimEnd( 235, 300, 10, "OnEvent_235_2", once );
	else
		OnEvent_235_2(proxy,param);
	end
	
	print( "OnEvent_235_1 end" );
end

function Condition_235_anim_wait(proxy,param)
	if	proxy:IsEventAnim(300, 7018) == false then
		return false;
	end
	return true;
end


function OnEvent_235_2(proxy,param)
	print("OnEvent_235_2 begin");
	proxy:ForcePlayAnimation( 300, 7018 );
	proxy:NotNetMessage_begin();
		--�򗳂̒��A�P�ރA�j��(7018)�Đ�
		proxy:OnChrAnimEnd(235, 300, 7018, "OnEvent_235_3", once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_235_2 end");
end

--�P�ރA�j���I����
function OnEvent_235_3(proxy,param)
	print("OnEvent_235_3 begin");
	SetNpcStateFlag(proxy, param, tyo1_flag_list, TYO_STATE_ESCAPE );
	InvalidCharactor(proxy, 300 );	
	print("OnEvent_235_3 end");
end



--------------------------------------------------------------------------------------
--��240���z�X�gPC�݂̂��ʂ����̖���
--------------------------------------------------------------------------------------

--��240_delete_wall�����@�Ǎ폜�����p��
function OnEvent_240_delete_wall(proxy , param)
	print("OnEvent_240_delete_wall begin");
	
	proxy:SetDrawEnable( 1055 , false );--���@�Ǖ`��OFF
	proxy:SetColiEnable( 1055 , false );--���@�Ǔ�����OFF
	proxy:SetObjDeactivate( 1055 , true );--�f�A�N�e�B�u
	proxy:InvalidSfx( 2075 , true );--SFX OFF
	proxy:DeleteEvent( 240 );--�S�v���C���[���̊Ď�������͂��B
	
	print("OnEvent_240_delete_wall end");
end


--��240���C�x���g�����p��
function OnEvent_240(proxy , param)
	print("OnEvent_240 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 240 ) == true then
		print("OnEvent_240 end");
		return;
	end
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 240 , 1 );
		print("OnEvent_240 end");
		return;
	end
	
	--�_�~�|���փ��[�v
	proxy:WarpDmy( LOCAL_PLAYER , 1055 , 191 );
	
	proxy:NotNetMessage_begin();
		--��240_1�������A�j���I����
		--proxy:OnChrAnimEnd( 240 , LOCAL_PLAYER , ANIMEID_WALK , "OnEvent_240_1" , once );
		proxy:LuaCallStart( 240 , 1 );--���̖��폜����
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 240 , 1 );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_240 end");
end


--��240_1�������A�j���I����
function OnEvent_240_1(proxy , param)
	print("OnEvent_240_1 begin");
	
	--proxy:LuaCallStart( 240 , 1 );--���̖��폜����
	
	print("OnEvent_240_1 end");
end





--------------------------------------------------------------------------------------
--��241���z�X�gPC�݂̂��ʂ����̖���
--------------------------------------------------------------------------------------

--��241_delete_wall�����@�Ǎ폜�����p��
function OnEvent_241_delete_wall(proxy , param)
	print("OnEvent_241_delete_wall begin");
	
	proxy:SetDrawEnable( 1056 , false );--�`��OFF
	proxy:SetColiEnable( 1056 , false );--������OFF
	proxy:SetObjDeactivate( 1056 , true );--�f�A�N�e�B�u
	proxy:DeleteEvent( 241 );
	proxy:InvalidSfx( 2076 , true );--SFX OFF
	
	print("OnEvent_241_delete_wall end");
end


--��241���C�x���g�����p��
function OnEvent_241(proxy , param)
	print("OnEvent_241 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 241 ) == true then
		print("OnEvent_241 end");
		return;
	end	
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 241 , 1 );
		print("OnEvent_241 end");
		return;
	end
	
	--�_�~�|���փ��[�v
	proxy:WarpDmy( LOCAL_PLAYER , 1056 , 191 );
	
	proxy:NotNetMessage_begin();
		--��241_1�������A�j���I����
		--proxy:OnChrAnimEnd( 241 , LOCAL_PLAYER , ANIMEID_WALK , "OnEvent_241_1" , once );
		proxy:LuaCallStart( 241 , 1 );--���̖��폜����
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 241 , 1 );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	print("OnEvent_241 end");
end


--��241_1�������A�j���I����
function OnEvent_241_1(proxy , param)
	print("OnEvent_241_1 begin");
	
	proxy:LuaCallStart( 241 , 1 );--���̖��폜����
	
	print("OnEvent_241_1 end");
end


--------------------------------------------------------------------------------------
--��242���z�X�gPC�݂̂��ʂ����̖���
--------------------------------------------------------------------------------------

--��242_delete_wall�����@�Ǎ폜�����p��
function OnEvent_242_delete_wall(proxy , param)
	print("OnEvent_242_delete_wall begin");
	
	proxy:SetDrawEnable( 1057 , false );--�`��OFF
	proxy:SetColiEnable( 1057 , false );--������OFF
	proxy:SetObjDeactivate( 1057 , true );--�f�A�N�e�B�u
	proxy:DeleteEvent( 242 );
	proxy:InvalidSfx( 2077 , true );--SFX OFF
	
	print("OnEvent_242_delete_wall end");
end


--��242���C�x���g�����p��
function OnEvent_242(proxy , param)
	print("OnEvent_242 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 242 ) == true then
		print("OnEvent_242 end");
		return;
	end	
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 242 , 1 );
		print("OnEvent_242 end");
		return;
	end
	
	--�_�~�|���փ��[�v
	proxy:WarpDmy( LOCAL_PLAYER , 1057 , 191 );
	
	proxy:NotNetMessage_begin();
		--��242_1�������A�j���I����
		--proxy:OnChrAnimEnd( 242 , LOCAL_PLAYER , ANIMEID_WALK , "OnEvent_242_1" , once );
		proxy:LuaCallStart( 242 , 1 );--���̖��폜����
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 242 , 1 );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_242 end");
end


--��242_1�������A�j���I����
function OnEvent_242_1(proxy , param)
	print("OnEvent_242_1 begin");
	
	proxy:LuaCallStart( 242 , 1 );--���̖��폜����
	
	print("OnEvent_242_1 end");
end


--[[

--------------------------------------------------------------------------------------
--��251���z�ꕺ�m�̎��S�Ď���
--------------------------------------------------------------------------------------

function OnEvent_251(proxy , param)
	print("OnEvent_251 begin");
	
	proxy:SetEventFlag( 251 , 1 );
	
	print("OnEvent_251 end");
end

--------------------------------------------------------------------------------------
--��252���z�ꕺ�m�̎��S�Ď���
--------------------------------------------------------------------------------------

function OnEvent_252(proxy , param)
	print("OnEvent_252 begin");
	
	proxy:SetEventFlag( 252 , 1 );
	
	print("OnEvent_252 end");
end

--------------------------------------------------------------------------------------
--��253���z�ꕺ�m�̎��S�Ď���
--------------------------------------------------------------------------------------

function OnEvent_253(proxy , param)
	print("OnEvent_253 begin");
	
	proxy:SetEventFlag( 253 , 1 );
	
	print("OnEvent_253 end");
end


--------------------------------------------------------------------------------------
--��254���z�ꕺ�m�̎��S�Ď���
--------------------------------------------------------------------------------------

function OnEvent_254(proxy , param)
	print("OnEvent_254 begin");
	
	proxy:SetEventFlag( 254 , 1 );
	
	print("OnEvent_254 end");
end


--------------------------------------------------------------------------------------
--��255���z�ꕺ�m�̎��S�Ď���
--------------------------------------------------------------------------------------

function OnEvent_255(proxy , param)
	print("OnEvent_255 begin");
	
	proxy:SetEventFlag( 255 , 1 );
	
	print("OnEvent_255 end");
end


--------------------------------------------------------------------------------------
--��256���z�ꕺ�m�̎��S�Ď���
--------------------------------------------------------------------------------------

function OnEvent_256(proxy , param)
	print("OnEvent_256 begin");
	
	proxy:SetEventFlag( 256 , 1 );
	
	print("OnEvent_256 end");
end
]]
--------------------------------------------------------------------------------------
--��295�������h�����q���G�ɂȂ遡
--------------------------------------------------------------------------------------
function OnEvent_295(proxy,param)
	--�G�΂ɏ�ԑJ��
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HOSTILE_1 );
	proxy:EnableLogic( 624 , true );
	proxy:SetTeamType( 624, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( 624 , 5062 );
	proxy:SetEventFlag( 295 , true );
end


--------------------------------------------------------------------------------------
--��300�������h�����q�̎��S�Ď���
--------------------------------------------------------------------------------------

function OnEvent_300(proxy , param)
	print("OnEvent_300 begin");
	
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_DEAD );
	RendolCheck(proxy,param);
	--���S��RendolCheck����ꍇ�A���̏u�Ԃɏ����Ă��܂��̂ŁA
	--���������čēx�L���ɂ��邩���߂�
	if	proxy:IsDistance( LOCAL_PLAYER, 624, 20 ) == true then
		ValidCharactor( proxy, 624 );
	end
	
	proxy:SetEventFlag( 300 , 1 );
	
	print("OnEvent_300 end");
end


--------------------------------------------------------------------------------------
--��260�����q�̊Ď���
--------------------------------------------------------------------------------------
function DoreiRegist_block1(proxy)
	local acid_list = { 251, 252, 253, 254, 255, 256};
	local evid_list = { 310, 311, 312, 313, 314, 315};
	local event_num = table.getn(acid_list);
	for index = 1, event_num, 1 do
		local acid = acid_list[index];
		local evid = evid_list[index];
		if	proxy:IsCompleteEvent( acid ) == false then
			proxy:OnCharacterDead( acid , evid , "OnEvent_260" , once );
		else
			proxy:OpeningDead( evid, false );
		end
	end
end



function OnEvent_260(proxy,param)
	print("OnEvent_260 begin");

	proxy:SetEventFlag( param:GetParam1(), true );
	
	if 	proxy:IsCompleteEvent(251) == false or
		proxy:IsCompleteEvent(252) == false or
		proxy:IsCompleteEvent(253) == false or
		proxy:IsCompleteEvent(254) == false or
		proxy:IsCompleteEvent(255) == false or
		proxy:IsCompleteEvent(256) == false then
		print("OnEvent_260 is No Success");
		print("OnEvent_260 end");
		return;
	end

	--����1�Ŋ��ӂ� ��ԑJ�ڂ����݂�
	if proxy:IsCompleteEvent(RENDOL_STATE_HELP_FOR_DOREI_HEISI) == true then	--��Ԃ��u�z�ꕺ�m���珕���āv �Ȃ��
		SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_THANKS_1 );
		RendolCheck(proxy,param);
	else--�����ĈȊO�Ȃ�΁i�G�΂Ǝ��S�H�j
		print("���q�͎���ł��邩�A�{���Ă��܂�");
	end
--[[
		proxy:EnableLogic(624,true);--���q���W�b�NON
		proxy:ChangeInitPosAng( 624 , 2150 );--���q�̋A�ҏꏊ��ύX
		
		proxy:NotNetMessage_begin();
			--���A�C�e���擾�p�̊Ď���ǉ���
			proxy:LuaCall(10501,0,"OnEvent_10501",once);
		proxy:NotNetMessage_end();
]]
	proxy:SetEventFlag( 260 , 1 );
	
	print("OnEvent_260 end");	
end


--------------------------------------------------------------------------------------
--��10501�����q���犴�ӂ̃A�C�e����
--------------------------------------------------------------------------------------
function OnEvent_10501(proxy,param)
	print("OnEvent_10501 begin");	
	proxy:NotNetMessage_begin();
	
		--�A�j���Đ����g���K�[�ɂȂ邩���H���̏ꍇ�Ď���ǉ����ăR�[��
		--����͂�����Lua�֐��ŌĂ�
		OnEvent_10501_1(proxy,param);
--[[
		--�ړ��^�C�v�������ɕύX
		proxy:SetEventMovePointType( 624, POINT_MOVE_TYPE_RoundTrip );
	
		--�ړ��|�C���g��ݒ�
		proxy:AddCustomRoutePoint(624, 2010);
		proxy:AddCustomRoutePoint(624, 2011);
		proxy:AddCustomRoutePoint(624, 2012);
		proxy:AddCustomRoutePoint(624, 2013);
		proxy:AddCustomRoutePoint(624, 2012);
		proxy:AddCustomRoutePoint(624, 2011);
		proxy:AddCustomRoutePoint(624, 2014);
		proxy:AddCustomRoutePoint(624, 2015);
]]	
	proxy:NotNetMessage_end();
	print("OnEvent_10501 end");
end

--
function OnEvent_10501_1(proxy,param)
	
	print("OnEvent_10501_1 begin");
	OnEvent_260_1(proxy,param);
	
	if param:IsNetMessage() == false then
		--�A�C�e���擾�֐�--�p�����[�^10101�Q��
		proxy:GetRateItem(10193);
	end	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 10501, 1 );
	
	--����1�ŒT���� ��ԑJ�ڂ����݂�	
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_SEARCH_1 );
	RendolCheck(proxy,param);
--[[	
		proxy:EnableLogic( 624 , true );--�����h�����q�A�T����Ԃŕ����o��
		proxy:ResetThink( 624 );
		
		proxy:NotNetMessage_begin();
			--�������h�����q�����̃u���b�N�ֈړ��p�̋����Ď���
		--proxy:OnRegistFunc( 301 , "Check_OnEvent_301" , "OnEvent_301" , 1 , once );
		proxy:NotNetMessage_end();
]]	
	print("OnEvent_10501_1 end")
end

--[[
--------------------------------------------------------------------------------------
--��301�������h�����q�����̃u���b�N�Ɉړ���
--------------------------------------------------------------------------------------

function Check_OnEvent_301( proxy , param )

	--�����v���C���[(�O���C)�̂ݔ���
	if proxy:IsLivePlayer() == false and
	   proxy:IsGreyGhost()  == false then
		return false;
	end
	
	--�{�X(�t�@�����N�X)�����Ă��画�肵�Ȃ�
	if proxy:IsCompleteEvent( 4096 ) == false then
		return false;
	end
	
	--��������
	if proxy:IsDistance( LOCAL_PLAYER , 624 , 20 ) == true then
		return false;
	else
		print("�����h�����q�A���u���b�N�ֈړ�");
		return true;
	end
	
	return false;
end
]]

function OnEvent_301( proxy , param )
	print("OnEvent_301 begin");
	
	--����2�Łu�B��Ă���̂ŏ����āv�� ��ԑJ��
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HELP_HIDING_ME );
	RendolCheck(proxy,param);
	
	proxy:SetEventFlag( 301 , 1 );--�C�x���g�I��
	
	print("OnEvent_301 end");
end




--------------------------------------------------------------------------------------
--��280���݂邳�ꂽ����1���������遡
--------------------------------------------------------------------------------------

function OnEvent_280( proxy , param )
	print("OnEvent_280 begin");

	--�I�u�W�F�j��𓯊�������(�z�M�Ŏ󂯎�����l�́A�I�u�W�F�j����Č�����)
	if param:IsNetMessage() == true then	
		proxy:ReconstructBreak( 1172 , 1 );
	end
	
	proxy:PlayAnimation( 10240 , 1000 );--���̂̃A�j�����I��
	
	proxy:NotNetMessage_begin();
		--��280_1���j��A�j���Đ��I����
		proxy:OnObjAnimEnd( 280 , 10240 , 1000 , "OnEvent_280_1" , once );
	proxy:NotNetMessage_end();
	
	--�I�u�W�F�j��͌l�ł��ꂼ�ꔻ�肳���̂�LuaCall�ɂ��Ȃ��Ă����v(����)
	proxy:SetEventFlag( 280 , true );
	
	print("OnEvent_280 end");
end

--��280_1���j��A�j���Đ��I����
function OnEvent_280_1( proxy , param )
	print("OnEvent_280_1 begin");
	
	if proxy:IsClient() == false then
		--��V�X�e���L����
		proxy:EnableObjTreasure( 10240 , true );
	end
	
	print("OnEvent_280_1 end");
end


--------------------------------------------------------------------------------------
--��281���݂邳�ꂽ����2���������遡
--------------------------------------------------------------------------------------

function OnEvent_281( proxy , param )
	print("OnEvent_281 begin");

	--�I�u�W�F�j��𓯊�������(�z�M�Ŏ󂯎�����l�́A�I�u�W�F�j����Č�����)
	if param:IsNetMessage() == true then	
		proxy:ReconstructBreak( 1174 , 1 );
	end
	
	proxy:PlayAnimation( 10241 , 1000 );--���̂̃A�j�����I��
	
	proxy:NotNetMessage_begin();
		--��281_1���j��A�j���Đ��I����
		proxy:OnObjAnimEnd( 281 , 10241 , 1000 , "OnEvent_281_1" , once );
	proxy:NotNetMessage_end();
	
	--�I�u�W�F�j��͌l�ł��ꂼ�ꔻ�肳���̂�LuaCall�ɂ��Ȃ��Ă����v(����)
	proxy:SetEventFlag( 281 , true );
	
	print("OnEvent_281 end");
end

--��281_1���j��A�j���Đ��I����
function OnEvent_281_1( proxy , param )
	print("OnEvent_281_1 begin");

	--��V�X�e���L����
	proxy:EnableObjTreasure( 10241 , true );
	
	print("OnEvent_281_1 end");
end


--------------------------------------------------------------------------------------
--��285���C�e�S���S����
--------------------------------------------------------------------------------------

function OnEvent_285( proxy , param )
	print("OnEvent_285 begin");

	--�I�u�W�F�j��𓯊�������(�z�M�Ŏ󂯎�����l�́A�I�u�W�F�j����Č�����)
	if param:IsNetMessage() == true then	
		proxy:ReconstructBreak( 1190 , 1 );
	end
	
	--�C�e�S���S���A�j���Đ�
	proxy:PlayAnimation( 1191 , 1 );
	
	--�C�e����_���[�W��
	local paramid = 10000; --�������_���[�W
	local rad    = 0.5;--���a(���ƂŁA�����Ȓl�ɂȂ�͂�������͓K��)
	--local time   = 20; --�ЂƂ܂��A�j���Đ��I���Ń_���[�W�������̂ŁA�A�j����蒷�����Ԃ��w�肵�Ă���
	local time   = 120; --�ЂƂ܂��A�j���Đ��I���Ń_���[�W�������̂ŁA�A�j����蒷�����Ԃ��w�肵�Ă���
	local requestTime = 1.0;--�_���[�W���č쐬�Ԋu
	
	--��285_hit���C�e1�����������Ƃ���
	proxy:OnObjectDamageHit_NoCallPlus( 285, 1191, 1, paramid, EV_HIT_CHR ,  rad, time, requestTime, everytime );
	--��285_hit���C�e2�����������Ƃ���
	proxy:OnObjectDamageHit_NoCallPlus( 285, 1191, 2, paramid, EV_HIT_CHR ,  rad, time, requestTime,  everytime );
	--��285_hit���C�e3�����������Ƃ���
	proxy:OnObjectDamageHit_NoCallPlus( 285, 1191, 3, paramid, EV_HIT_CHR ,  rad, time, requestTime,  everytime );	
	--��285_hit���C�e4�����������Ƃ���
	proxy:OnObjectDamageHit_NoCallPlus( 285, 1191, 4, paramid, EV_HIT_CHR ,  rad, time, requestTime,  everytime );
	--��285_hit���C�e5�����������Ƃ���
	proxy:OnObjectDamageHit_NoCallPlus( 285, 1191, 5, paramid, EV_HIT_CHR ,  rad, time, requestTime,  everytime );
	proxy:SetObjEventCollisionFill( 1191, true );

	--�A�j���Đ����I�������A�_���[�W�������Ȃǂ���?
	proxy:NotNetMessage_begin();
		--��285_anime_end���C�e�S���S���A�j���I����
		proxy:OnObjAnimEnd( 285 , 1191 , 1 , "OnEvent_285_anime_end" , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 285 , true );

	print("OnEvent_285 end");
end
	

--��285_anime_end���C�e�S���S���A�j���I����
function OnEvent_285_anime_end( proxy , param )
	print("OnEvent_285_anime_end begin");

	proxy:DeleteEvent( 285 );--�_���[�W���ȂǍ폜

	print("OnEvent_285_anime_end end");
end
	

--------------------------------------------------------------------------------------
--��310�`319���\�E�������X�^�[�o����
--------------------------------------------------------------------------------------
--�\�E�������X�^�[�C�x���g�o�^
function RegistSoulMonster_block1(proxy)
	local acid_list = {   310,   311,   312,   313,   314,   315,   316,   317,   318,   319};
	local evid_list = {   320,   321,   322,   323,   324,   325,   326,   327,   328,   329};
	local qwc_list  = { 20100, 20100,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1};
	local event_num = table.getn(acid_list);
	for index = 1, event_num, 1 do
		acid = acid_list[index];
		evid = evid_list[index];
		qwc_id = qwc_list[index];
		SingleReset( proxy,acid );
		if	(qwc_id ~= -1 and proxy:IsSuccessQWC(qwc_id) == true) or (qwc_id == -1) then
			if	proxy:IsCompleteEvent( acid ) == false then
				proxy:OnPlayerDistanceInTarget( acid, LOCAL_PLAYER, evid, "OnEvent_"..acid, 10.0, once );
				InvalidCharactor( proxy, evid );
			else
				proxy:EnableLogic( evid, true );
			end
		else
			InvalidCharactor( proxy, evid );
		end
	end
	
	SingleReset( proxy , 310);
	if proxy:IsCompleteEvent( 310 ) == false then
		if proxy:IsSuccessQWC(20100) == true then--QWC������������
			proxy:OnPlayerDistanceInTarget( 310 , LOCAL_PLAYER , 320 , "OnEvent_310" , 10.0 , once );
		end
	else 
		proxy:EnableLogic( 320 , true );--���W�b�NON
	end
	
end


function OnEvent_310(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_311(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_312(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_313(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_314(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_315(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_316(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_317(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_318(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_319(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end

function SoulMonsterFunc_block1(proxy,param,acid,evid)
	print("OnEvent_"..acid.." begin")
	if	proxy:IsAlive(evid) == false then
		print("OnEvent_"..acid.." return end")
	end
	
	ValidCharactor( proxy , evid );--�L�����N�^�L����
	proxy:PlayAnimation( evid , 6100 );--�\�E���̏o���A�j���Đ�(���͑ҋ@�A�j���ɂȂ��Ă���)
	proxy:SetEventFlag( acid , true );
	
	print("OnEvent_"..acid.." end")
end







--------------------------------------------------------------------------------------
--�n�V�S1�~�聡320
--------------------------------------------------------------------------------------
--��320���n�V�S1�~��X�^�[�g��
function OnEvent_320(proxy, param)
	print("OnEvent_320 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_320 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����--
	proxy:BeginAction(LOCAL_PLAYER,2,2,2);				--�z�o�[�ړ����[�h�Ɉڍs
	--proxy:HoverMoveVal(LOCAL_PLAYER,2002,LadderTime_A);--�ړ��ʒu(2002)��0.5�b�Ńz�o�[�ړ�
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1060,192,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(LOCAL_PLAYER,1);				--�C�x���g�R�}���hID(1)"�n�V�S�ォ���"�ނ𑗂�
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );--nCommandID �� �����̂Ƃ�0 �΂߂̂Ƃ�4
	proxy:DisableMove(LOCAL_PLAYER,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(320,"OnEvent_320_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���)
		proxy:OnKeyTime2(320,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_320 end");
end

--��320_1���n�V�SA�~��X�^�[�g:�z�o�[�ړ��I����
function OnEvent_320_1(proxy, param)
	print("OnEvent_320_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_320_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,50,49);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_320_1 end");
end


--------------------------------------------------------------------------------------
--�n�V�S1���聡321
--------------------------------------------------------------------------------------
--��321���n�V�S1����X�^�[�g��
function OnEvent_321(proxy, param)
	print("OnEvent_321 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_321 end");
		return;
	end
	
	--�͂�������ɕK�v�ȑO����--
	proxy:BeginAction(LOCAL_PLAYER,2,-1,1);			--�z�o�[�ړ����[�h�Ɉڍs
	--proxy:HoverMoveVal(LOCAL_PLAYER,2003,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1060,191,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(LOCAL_PLAYER,0);				--�C�x���g�R�}���hID(0)"�n�V�S�������"�ނ𑗂�
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );--nCommandID �� �����̂Ƃ�0 �΂߂̂Ƃ�4
	proxy:DisableMove(LOCAL_PLAYER,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂�������X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(321,"OnEvent_321_1",LadderTime_A,0,0,once);
		--�͂�������p�̊֐���1�b�Ԕ��s(�C�x���g���j���[�̒��f����?)
		proxy:OnKeyTime2(321,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_321 end");
end

--��321_1���n�V�S1����X�^�[�g:�z�o�[�ړ��I����
function OnEvent_321_1(proxy, param)
	print("OnEvent_321_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_321_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,-1,49);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_321_1 end");
end


--------------------------------------------------------------------------------------
--��2���򗳂����ł���|�������Đ����遡
--------------------------------------------------------------------------------------

function OnEvent_2(proxy , param)
	print("OnEvent_2 begin");

	--���򗳂����ł���|�����Đ�
	proxy:RequestRemo(20000,REMO_FLAG,2,1);
	proxy:SetEventFlag( 2, true );

	print("OnEvent_2 end");
end


--���|�����Đ��J�n(�t�F�[�h�I��)
function OnEvent_2_RemoStart(proxy,param)
	print("OnEvent_2_RemoStart begin");
	
	--SE���c��炵���̂�-1�Đ�
	--proxy:ForcePlayAnimation( 1110 ,-1);
	--proxy:ForcePlayAnimation( 1111 ,-1);
	--proxy:ForcePlayAnimation( 1112 ,-1);
	--�J���X���c���Ă��܂��悤�Ȃ̂ŏ����B
	--proxy:SetDrawEnable( 1110 , false );
	--proxy:SetDrawEnable( 1111 , false );
	--proxy:SetDrawEnable( 1112 , false );
	
	print("OnEvent_2_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��)
function OnEvent_2_RemoFinish(proxy , param)
	print("OnEvent_2_RemoFinish begin");
	print("OnEvent_2_RemoFinish end");
end

--------------------------------------------------------------------------------------
--��258���z�ꕺ�m�������h�����q��_���̂���߂�Ď��ǉ�(���W�b�N�؂�ւ�)��
--------------------------------------------------------------------------------------

--���̈�������Ƃ�(�z�ꕺ�m �ʏ탍�W�b�N�ɂ���)
function OnEvent_258(proxy,param)
	print("OnEvent_258 begin");

	--�����h�����q�̏�Ԏ擾
	local now_state = GetRendolState( proxy, param );
	
	--��Ԃ��u�z�ꕺ�m���珕���āv����Ȃ��@
	--��Ԃ��u����P�G�΁v����Ȃ�
	--��Ԃ��u����P���S�v����Ȃ��Ƃ��� �������Ȃ�(�Ď��폜)
	if 	now_state ~= RENDOL_STATE_HELP_FOR_DOREI_HEISI and
		now_state ~= RENDOL_STATE_HOSTILE_1 and
		now_state ~= RENDOL_STATE_DEAD then
		proxy:DeleteEvent( 258 );--���W�b�N�؂�ւ��Ď��폜
		proxy:DeleteEvent( 245 );--�z�ꕺ�m�̃_���[�W�Ď��폜
		print("OnEvent_258 end");
		return;
	end
		
	--�z�ꕺ�m�ʏ탍�W�b�N�ɐ؂�ւ�(�����h�����q���ɂݍ����̂���߂�)
	local dorei_heisi_id_list = {310,311,312,313,314,315};
	local dorei_heisi_num = table.getn( dorei_heisi_id_list );
	
	for i=1 , dorei_heisi_num , 1 do
		proxy:ForceUpdateNextFrame( dorei_heisi_id_list[i] );--���̃t���[���͋����X�V
		proxy:SendEventRequest    ( dorei_heisi_id_list[i] , 0 , AI_EVENT_None);
		--proxy:SetEventTarget   ( dorei_heisi_id_list[i] , -1);--�����^�[�Q�b�g�N���A
	end
	
	proxy:DeleteEvent( 245 );--�z�ꕺ�m�̃_���[�W�Ď�����U�폜
	
	proxy:SetEventFlag( 258 , 1 );--���q��_���̂���߂�

	print("OnEvent_258 end");
end

--���̈���o���Ƃ�(�z�ꕺ�m �Њd���W�b�N�ɂ���)
function OnEvent_258_out(proxy,param)
	print("OnEvent_258_out begin");

	--�̈�ɓ������t���O��OFF�������珈�����Ȃ�(���炭�Ȃ��Ǝv���邯��ǥ��)
	if proxy:IsCompleteEvent( 258 ) == false then
		print("OnEvent_258_out end");
		return;
	end
	
	--�����h�����q�̏�Ԏ擾
	local now_state = GetRendolState( proxy, param );
	
	--��Ԃ��u�z�ꕺ�m���珕���āv����Ȃ��Ƃ��� �������Ȃ�(�Ď��폜)
	if now_state ~= RENDOL_STATE_HELP_FOR_DOREI_HEISI then
		proxy:DeleteEvent( 258 );--���W�b�N�؂�ւ��Ď��폜
		proxy:DeleteEvent( 245 );--�z�ꕺ�m�̃_���[�W�Ď��폜
		print("OnEvent_258_out end");
		return;
	end
	
	--�z�ꕺ�m�Њd���W�b�N�ɐ؂�ւ�(�����h�����q���ɂݍ���)
	local dorei_heisi_id_list = {310,311,312,313,314,315};
	local dorei_heisi_num = table.getn( dorei_heisi_id_list );
	local rendol_id = 624;
		
	for i=1, dorei_heisi_num, 1 do		
		proxy:SendEventRequest( dorei_heisi_id_list[i] , 0 , AI_EVENT_DOREI_IKAKU);
		proxy:SetEventTarget( dorei_heisi_id_list[i] , rendol_id);--�����^�[�Q�b�g�ݒ�
		
		--���z�ꕺ�m�����̃_���[�W�Ď���
		proxy:OnSimpleDamage( 245 , dorei_heisi_id_list[i], LOCAL_PLAYER, "OnEvent_258", once );--�_���[�W�Ď�
	end
	
	proxy:SetEventFlag( 258 , 0 );--���q��_���̂��ĊJ
	
	print("OnEvent_258_out end");
end

--��259�������h�����q���̈�N���Ŏd���Ȃ��키��
function OnEvent_259(proxy,param)
	print("OnEvent_259 begin");
	proxy:EnableLogic( 624, true );
	print("OnEvent_259 end");
end


--------------------------------------------------------------------------------------
--��4103���\�E�����聡
--------------------------------------------------------------------------------------

function OnEvent_4103(proxy, param)
	print("OnEvent_4103 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--�V�����A�j�� 
		print("OnEvent_4103 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 4103, "OnEvent_4103_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4103 end");
end


--��4103_1���A�C�e���擾��
function OnEvent_4103_1(proxy, param)
	print("OnEvent_4103_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10101�Q��
	proxy:GetRateItem(10110);
	proxy:GetRateItem(10170);
	proxy:GetRateItem(10171);
	proxy:GetRateItem(10172);
	proxy:GetRateItem(10173);
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 4103, 1 );
	
	--�󔠃V�F�[�_�[�͏����܂���
	--proxy:TreasureDispModeChange( 1982 , false );

	--SFX��������
	proxy:InvalidSfx( 1080 , true );--���̗��q
	--proxy:InvalidSfx( 1081 , true );--�v�΂̃I�[��
	
	--���v�΂Ń��[�v�p�̊Ď���ǉ���
	proxy:OnDistanceActionAttribute( 4105 , LOCAL_PLAYER , 1982 , "OnEvent_4105" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_4103_1 end");
end

--------------------------------------------------------------------------------------
--��30���ŏ��̗v�΂̌��������遡
--------------------------------------------------------------------------------------

function OnEvent_30(proxy, param)
	print("OnEvent_30 begin");
	
	proxy:TreasureDispModeChange2( 1983 , false ,KANAME_SFX);
	
	print("OnEvent_30 end");
end


--------------------------------------------------------------------------------------
--��31���ŏ��̗v�΂̌����������遡
--------------------------------------------------------------------------------------

function OnEvent_31(proxy, param)
	print("OnEvent_31 begin");
	
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	
	print("OnEvent_31 end");
end

--�y�h�����z�퓬�J�n
function OnEvent_329(proxy,param)
	proxy:EnableLogic( 697 , true );
	proxy:SetEventFlag( 329 , true );
end

--�y�h�����z�����Ă��ꂽ
function OnEvent_330(proxy,param)
	print("OnEvent_330 begin");
	if proxy:IsAlive( 697 ) == true then
		proxy:SetTeamType( 697, TEAM_TYPE_Friend );
		SetNpcStateFlag( proxy , param , doran_flag_list , DORAN_STATE_ALLOWED );
		proxy:ResetThink(697);
	
		proxy:ClearTarget(nWho);
	end
	
	--�z�X�g�A�����A�O���C�̂ݒ��ׂ邱�Ƃ��ł���
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	--HELPID���f�����u�����h��p�ɂȂ���
	proxy:OnDistanceActionAttribute( 5 , LOCAL_PLAYER , 1192 , "OnEvent_5" , ItemBoxDist_A , 10010130 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
	proxy:LuaCall( 5,1,"OnEvent_5_2",once);	
	proxy:LuaCall( 5,2,"OnEvent_5_3",once);
	proxy:TreasureDispModeChange2( 1192, true ,KEN_SFX);
	--proxy:SetRarity( 1192, 10104 );
				
	proxy:SetEventFlag( 330, true );
	print("OnEvent_330 end");
end

--�y�h�����z�����Ȃ�
function OnEvent_331(proxy,param)
	if proxy:IsAlive( 697 ) == true then
		print("OnEvent_331 begin");
		proxy:SetTeamTypeDefault( 697 );
		SetNpcStateFlag( proxy , param , doran_flag_list , DORAN_STATE_NOT_ALLOWED );
		print("�h�����������߂�");
		proxy:SendEventRequest( 697 ,0, -1);
		proxy:EraseEventSpecialEffect_2( 697 , 5042 );
		proxy:SetEventFlag( 331, true );
		print("OnEvent_331 end");
	end
end

--�y�h�����z���S
function OnEvent_332(proxy,param)
	print("OnEvent_332 begin");
	SetNpcStateFlag( proxy , param , doran_flag_list , DORAN_STATE_DEAD );
	proxy:SetEventFlag( 332, true );

	--���g���t�B�[�擾���聥
	Lua_RequestUnlockTrophy(proxy, 11);

	print("OnEvent_332 end");
end

--�y�h�����z���̂𒲂ׂ�
function OnEvent_15610(proxy,param)
	print("OnEvent_15610 begin");
	proxy:SetEventFlag( 15610 , true );
	print("OnEvent_15610 end");
end



function CheckPointIn_AttrCheck(proxy,param)
	print("CheckPointIn_AttrCheck begin");
	--�z�X�g�̂݃`�F�b�N�|�C���g������s��
	if	proxy:IsClient() == false then
		--��CheckPointIn
		--�p�����[�^�Ƃ��ė̈�̃C�x���gID��n���Ă���
		proxy:LuaCallStartPlus( SYSTEM_CHECK_POINT, 2, param:GetParam2() );
	end
	print("CheckPointIn_AttrCheck end");
end

--�`�F�b�N�|�C���g�ʉ�
function CheckPointIn(proxy,param)
	print("CheckPointIn begin");
	RendolCheck(proxy,param);
	BiyoCheck(proxy,param);
	--HiryuOsaCheck(proxy,param);
	OnEvent_781(proxy,param);--�z�ꕺ�m�V���b�v
	print("CheckPointIn end");
end

function InitializeNpc(proxy,param)
	RendolCheck2(proxy,param,false);
	BiyoCheck2(proxy,param,false);
	--HiryuOsaCheck(proxy,param);
	OnEvent_781(proxy,param);--�z�ꕺ�m�V���b�v
end

--[[�폜�Ƃ̎��Ȃ̂ŁA�R�����g�A�E�g
--------------------------------------------------------------------------------------
--��10700���݂邳��Ă���l���b�������Ă��遡
--------------------------------------------------------------------------------------
function OnEvent_10700(proxy,param)
--	print("OnEvent_10700 begin");

	--���̂𗎂Ƃ��C�x���g���I����Ă���
	if proxy:IsCompleteEvent( 281 ) == true then
		
		if proxy:IsCompleteEvent( 10701 ) == false then
			--�f����(����)
			proxy:CloseTalk(10700);
			proxy:TalkNextPage( 10701 );
			proxy:SetEventFlag( 10701 , 1 );
		else
			proxy:DeleteEvent( 10700 );
			return;
		end
		
	--�܂��݂邳��Ă���
	else
		if proxy:IsCompleteEvent( 10700 ) == false then
			--�b�������Ă���
			proxy:TalkNextPage( 10700 );	
			proxy:SetEventFlag( 10700 , 1 );
		end
	end

--	print("OnEvent_10700 end");
end]]


--[[-----------------------------------------------------------------------------------------------------------------------------------------
	�����h�����q�֘A�@��������
-----------------------------------------------------------------------------------------------------------------------------------------]]
function RendolCheck(proxy,param)
	RendolCheck2(proxy,param,true);
end

function RendolCheck2(proxy,param,flag)
	print("RendolCheck begin");
	local rendol_id_1 = 624;--����P�̃����h�����q
	local rendol_id_2 = 620;--����Q�̃����h�����q
	local rendol_id_3 = 621;--����R�̃����h�����q
	local rendol_id_4 = 626;--����S�̃����h�����q
	
	local rendol_block1_acid_list = {   245,   258,   259,   301,   260,   300,   295, 10501};
	local rendol_block2_acid_list = { 10800,   723,   724,   643};
	local rendol_block3_acid_list = {  1310,  1311,  1312,  1313,  1314,  1315,  1316,  1316,  1317,  1318,  1349, 1350,  1351,  1352,  1360,  1361,  1362, 11501};
	local rendol_block4_acid_list = { 11790,  1700,  1702};
	
	--��U�S�������Ă���
	InvalidCharactor(proxy,rendol_id_1);
	InvalidCharactor(proxy,rendol_id_2);
	InvalidCharactor(proxy,rendol_id_3);
	InvalidCharactor(proxy,rendol_id_4);
	--InvalidCharactor(proxy, 102);
	--InvalidCharactor(proxy, 103);
	

	
	--�Ď�����U�S�폜
	DeleteConditionList(proxy,rendol_block1_acid_list);
	DeleteConditionList(proxy,rendol_block2_acid_list);
	DeleteConditionList(proxy,rendol_block3_acid_list);
	DeleteConditionList(proxy,rendol_block4_acid_list);
	
	SetFirstNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HELP_FOR_DOREI_HEISI );
	
	----------------------------------------------------------------------------------------------------------------
	--���q���z�ꕺ�m���珕���ď��--16000
	if	proxy:IsCompleteEvent(RENDOL_STATE_HELP_FOR_DOREI_HEISI) == true then
		print("rendol state RENDOL_STATE_HELP_FOR_DOREI_HEISI");
		SetRendolState_01(proxy, param, rendol_id_1 );
		RendolRegistCondition_block1(proxy,param,rendol_id_1);
		
	----------------------------------------------------------------------------------------------------------------
	--���q�����Ӂi����P�j���--16001
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_THANKS_1) == true then
		print("rendol state RENDOL_STATE_THANKS_1");
		if flag == true then
			SetRendolState_02(proxy, param, rendol_id_1 );
		else
			SetRendolState_02Init(proxy, param, rendol_id_1 );
		end
		RendolRegistCondition_block1(proxy,param,rendol_id_1);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���T���i����P�j���--16002
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_SEARCH_1) == true then
		print("rendol state RENDOL_STATE_SEARCH_1");
		if flag == true then
			SetRendolState_03(proxy, param, rendol_id_1 );
		else
			SetRendolState_03Init(proxy, param, rendol_id_1 );
		end
		RendolRegistCondition_block1(proxy,param,rendol_id_1);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���G�΁i����P�j���--16003
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_1) == true then
		print("rendol state RENDOL_STATE_HOSTILE_1");
		if flag == true then
			SetRendolState_04(proxy, param, rendol_id_1 );
		else
			SetRendolState_04Init(proxy, param, rendol_id_1 );
		end
		RendolRegistCondition_block1(proxy,param,rendol_id_1);
		
	----------------------------------------------------------------------------------------------------------------
	--���q������ł�����--16004
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_DEAD) == true then
		print("rendol state RENDOL_STATE_DEAD");
		--�����ł͒ǉ����ݒ�����Ȃ�
		
	----------------------------------------------------------------------------------------------------------------
	--���q���B��Ă���̂ŏ����ď��--16005
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HELP_HIDING_ME) == true then
		print("rendol state RENDOL_STATE_HELP_HIDING_ME");
		SetRendolState_05(proxy, param, rendol_id_2 );
		RendolRegistCondition_block2(proxy,param,rendol_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--���q�����Ӂi����Q�j���--16006
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_THANKS_2) == true then
		print("rendol state RENDOL_STATE_THANKS_2");
		SetRendolState_06(proxy, param, rendol_id_2 );
		RendolRegistCondition_block2(proxy,param,rendol_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���T���i����Q�j���--16007
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_SEARCH_2) == true then
		print("rendol state RENDOL_STATE_SEARCH_2");
		SetRendolState_07(proxy, param, rendol_id_2 );
		RendolRegistCondition_block2(proxy,param,rendol_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���G�΁i����Q�j���--16008
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_2) == true then
		print("rendol state RENDOL_STATE_HOSTILE_2");
		SetRendolState_08(proxy, param, rendol_id_2 );
		RendolRegistCondition_block2(proxy,param,rendol_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--���q�������Ȃ��ꏊ�ɂ���������--16009
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_LOCATION_INVISIBLE) == true then
		print("rendol state RENDOL_STATE_LOCATION_INVISIBLE");
		SetRendolState_09(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--���q������J���ė~�������--16010
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_WANT_TO_OPEN_THE_GATE) == true then
		print("rendol state RENDOL_STATE_WANT_TO_OPEN_THE_GATE");
		SetRendolState_10(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���܏��H�ŋ������--16011
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_SCARED) == true then
		print("rendol state RENDOL_STATE_SCARED");
		SetRendolState_11(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--���q�����Ӂi����R�j���--16012
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_THANKS_3) == true then
		print("rendol state RENDOL_STATE_THANKS_3");
		SetRendolState_12(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���T���i����R�j���--16013
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_SEARCH_3) == true then
		print("rendol state RENDOL_STATE_SEARCH_3");
		SetRendolState_13(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���G�΁i����R�j���̑O���--16014
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_3_FRONT_GATE) == true then
		print("rendol state RENDOL_STATE_HOSTILE_3_FRONT_GATE");
		SetRendolState_14(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���G�΁i����R�j���̌����--16015
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_3_BACK_GATE) == true then
		print("rendol state RENDOL_STATE_HOSTILE_3_BACK_GATE");
		SetRendolState_15(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���G���x�[�^�O���--16016
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_LIFT_FRONT) == true then
		print("rendol state RENDOL_STATE_LIFT_FRONT");
		SetRendolState_16(proxy, param, rendol_id_4 );
		RendolRegistCondition_block4(proxy,param,rendol_id_4);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���G�΁i����S�j���--16017
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_4_LIFT_FRONT) == true then
		print("rendol state RENDOL_STATE_HOSTILE_4_LIFT_FRONT");
		SetRendolState_17(proxy, param, rendol_id_4 );
		RendolRegistCondition_block4(proxy,param,rendol_id_4);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���G�΁i�Β��j���--16018
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_STONE_PILLAR) == true then
		print("rendol state RENDOL_STATE_HOSTILE_STONE_PILLAR");
		SetRendolState_18(proxy, param, rendol_id_4 );
		RendolRegistCondition_block4(proxy,param,rendol_id_4);
	end
	print("RendolCheck end");
end


--[[11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
---------------------------------------����������P�����h�����q������------------------------------
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111]]
function RendolRegistCondition_block1(proxy,param,chrId)
	print("RendolRegistCondition_block1 begin");
	
	if	proxy:IsCompleteEvent(RENDOL_STATE_DEAD) == false then
		if	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_1) == false then
			--��295�������h�����q���G�ɂȂ遡
			if proxy:IsCompleteEvent( 295 ) == false then
				--�����h�����q(624)��PC(LOCAL_PLAYER)����100�_���[�W���󂯂�
				--proxy:OnCharacterTotalDamage( 295, chrId, LOCAL_PLAYER, 100, "OnEvent_295", once );
				proxy:OnCharacterTotalRateDamage( 295, chrId, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_295", once );
			end
		end
		--��300�������h�����q�̎��S��
		if proxy:IsCompleteEvent( 300 ) == false then
			proxy:OnCharacterDead( 300 , chrId , "OnEvent_300" , once );
		end
		
		
		--��260�������h�����q���͂�ł���z�ꕺ�m��S���|������
		if proxy:IsCompleteEvent( 260 ) == true then
			proxy:DeleteEvent( 258 );--���q����z�ꕺ�m������C�x���g�폜
		end
	end

	
	print("RendolRegistCondition_block1 end");
end


-------------------------------------------------------------------------------------------------
--���q���z�ꕺ�m���珕���ď��--16000
function SetRendolState_01(proxy,param,chrId)
	print("SetRendolState_01 begin");
	local enemy_list = {310, 311, 312, 313, 314, 315};
	local enemy_num = table.getn( enemy_list );
	for index = 1, enemy_num, 1 do
		--�z�ꂪ�����Ă�����Њd�ɂ��āA�����h�����q���^�[�Q�b�g�ɐݒ�
		if	proxy:IsAlive(enemy_list[index]) == true then
			--proxy:ChangeThink( enemy_list[index], AI_EVENT_DOREI_IKAKU);
			proxy:SendEventRequest( enemy_list[index], 0, AI_EVENT_DOREI_IKAKU );
			proxy:SetEventTarget( enemy_list[index] , chrId );--�����^�[�Q�b�g�ݒ�
			--���z�ꕺ�m�����̃_���[�W�Ď���
			proxy:OnSimpleDamage( 245 , enemy_list[index] , LOCAL_PLAYER , "OnEvent_258" , once );--�_���[�W�Ď�			
		end
	end
	--�������h�����q���̈�N���Ŏd���Ȃ��키��
	proxy:OnRegionJustIn( 259, chrId, 2151, "OnEvent_259", once );
	
	proxy:EnableLogic( chrId , false );--�����h�����q���W�b�NOFF
	--���q�L����
	ValidCharactor( proxy, chrId );
	
	--���z�ꕺ�m�������h�����q��_���̂���߂�Ď��ǉ�(���W�b�N�؂�ւ�)��	
	proxy:SetEventFlag( 258 , 0 );--����ǉ�����Ăق����̂ť���B
	proxy:OnRegionJustIn ( 258 , LOCAL_PLAYER , 2151 , "OnEvent_258"     , everytime );--�̈�������Ƃ��ʏ��		
	proxy:OnRegionJustIn ( 258 , chrId , 2151 , "OnEvent_258"     , everytime );--�����h���̈�������Ƃ��ʏ��		
	proxy:OnRegionJustOut( 258 , LOCAL_PLAYER , 2151 , "OnEvent_258_out" , everytime );--�̈�ł��Ƃ��Њd��
	
	print("SetRendolState_01 end");
end


-------------------------------------------------------------------------------------------------
--���q�����Ӂi����P�j���--16001
function SetRendolState_02(proxy,param,chrId)
	print("SetRendolState_02 begin");
	
	--���q�L����
	ValidCharactor( proxy, chrId );
	
	proxy:EnableLogic(chrId,true);--���q���W�b�NON
	proxy:ChangeInitPosAng( chrId , 2150 );--���q�̋A�ҏꏊ��ύX
	proxy:ResetThink( chrId );
	proxy:ForceUpdateNextFrame( chrId );
	proxy:SendEventRequest( chrId, 0, 10 );
	
	--��10501���A�C�e���擾(��b�ŌĂяo��)��
	--proxy:NotNetMessage_begin();
		proxy:LuaCall(10501,0,"OnEvent_10501",once);--�A�C�e���擾�p�n���h���ǉ�
	--proxy:NotNetMessage_end();
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 10502, "OnEvent_260_1", 5, 0, 2, once );
	proxy:NotNetMessage_end();
	
	
	print("SetRendolState_02 end");
end

function SetRendolState_02Init(proxy, param, chrId )
	print("SetRendolState_02Init begin");
	--���q�L����
	ValidCharactor( proxy, chrId );
	
	proxy:EnableLogic(chrId,true);--���q���W�b�NON
	proxy:ChangeInitPosAng( chrId , 2150 );--���q�̋A�ҏꏊ��ύX
	proxy:Warp( chrId , 2150 );
	proxy:ResetThink( chrId );
	proxy:ForceUpdateNextFrame( chrId );
	--proxy:SendEventRequest( chrId, 0, 10 );	
	--��10501���A�C�e���擾(��b�ŌĂяo��)��
	--proxy:NotNetMessage_begin();
		proxy:LuaCall(10501,0,"OnEvent_10501",once);--�A�C�e���擾�p�n���h���ǉ�
	--proxy:NotNetMessage_end();
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 10502, "OnEvent_260_1", 2, 0, 2, once );
	proxy:NotNetMessage_end();
	print("SetRendolState_02Init end");
end

function OnEvent_260_1(proxy,param)
	print("OnEvent_260_1 begin");
	proxy:SendEventRequest( 624, 0, AI_EVENT_None );
	print("OnEvent_260_1 end");
end

-------------------------------------------------------------------------------------------------
--���q���T���i����P�j���--16002
function SetRendolState_03(proxy,param,chrId)
	print("SetRendolState_03 begin");
	
	--���q�L����
	ValidCharactor( proxy, chrId );
	proxy:ChangeInitPosAng( chrId , 2150 );--���q�̋A�ҏꏊ��ύX
	
	--�ړ��^�C�v�������ɕύX
	
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	proxy:ForceUpdateNextFrame( chrId );
	proxy:ClearTarget(chrId);
	proxy:ResetThink( chrId );
	
	--�ړ��|�C���g��ύX
	local point_list = {2010, 2011, 2012, 2013, 2012, 2011, 2014, 2015};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--�ړ��|�C���g��ݒ�
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	--�����h�����q���T�����������苗���ȏ㗣�ꂽ���_�Ŏ��̏�ԂɑJ��
	if	proxy:IsClient() == false then
		if	proxy:IsCompleteEvent( 4096 ) == true then
			if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
				--�t���[�������炵�Ĉ��S���̊m��
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2( 301, "OnEvent_301", 0.0, 0, 2, once );
				proxy:NotNetMessage_end();
			else
				proxy:NotNetMessage_begin();
					proxy:OnPlayerDistanceOut( 301, LOCAL_PLAYER, chrId "OnEvent_301", 20, once );
				proxy:NotNetMessage_end();
			end
		end
	end

	print("SetRendolState_03 end");
end

function SetRendolState_03Init(proxy, param, chrId )
	print("SetRendolState_03Init begin");
	--���q�L����
	ValidCharactor( proxy, chrId );
	proxy:Warp( chrId, 2150);
	proxy:ChangeInitPosAng( chrId , 2150 );--���q�̋A�ҏꏊ��ύX
	
	--�ړ��^�C�v�������ɕύX
	
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	proxy:ForceUpdateNextFrame( chrId );
	proxy:ClearTarget(chrId);
	proxy:ResetThink( chrId );
	
	--�ړ��|�C���g��ύX
	local point_list = {2010, 2011, 2012, 2013, 2012, 2011, 2014, 2015};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--�ړ��|�C���g��ݒ�
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	--�����h�����q���T�����������苗���ȏ㗣�ꂽ���_�Ŏ��̏�ԂɑJ��
	if	proxy:IsClient() == false then
		if	proxy:IsCompleteEvent( 4096 ) == true then
			if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
				--�t���[�������炵�Ĉ��S���̊m��
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2( 301, "OnEvent_301", 0.0, 0, 2, once );
				proxy:NotNetMessage_end();
			else
				proxy:NotNetMessage_begin();
					proxy:OnPlayerDistanceOut( 301, LOCAL_PLAYER, chrId "OnEvent_301", 20, once );
				proxy:NotNetMessage_end();
			end
		end
	end
	print("SetRendolState_03Init end");
end

-------------------------------------------------------------------------------------------------
--���q���G�΁i����P�j���--16003
function SetRendolState_04(proxy,param,chrId)
	print("SetRendolState_04 begin");
	
	proxy:SendEventRequest( 624, 0, AI_EVENT_None );
	--�ړ��^�C�v�������ɕύX
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	proxy:ChangeInitPosAng( chrId , 2150 );--���q�̋A�ҏꏊ��ύX
	
	--�ړ��|�C���g��ύX
	local point_list = {2010, 2011, 2012, 2013, 2012, 2011, 2014, 2015};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--�ړ��|�C���g��ݒ�
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( chrId , 5062 );
	--���q�L����
	ValidCharactor( proxy, chrId );
	
	print("SetRendolState_04 end");
end

function SetRendolState_04Init(proxy,param,chrId)
	print("SetRendolState_04Init begin");
	--�ړ��^�C�v�������ɕύX
	proxy:SendEventRequest( 624, 0, AI_EVENT_None );
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	proxy:ChangeInitPosAng( chrId , 2150 );--���q�̋A�ҏꏊ��ύX
	proxy:Warp( chrId,2150);
	
	--�ړ��|�C���g��ύX
	local point_list = {2010, 2011, 2012, 2013, 2012, 2011, 2014, 2015};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--�ړ��|�C���g��ݒ�
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( chrId , 5062 );
	--���q�L����
	ValidCharactor( proxy, chrId );
	print("SetRendolState_04Init end");
end


--[[11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
---------------------------------------����������P�����h�����q������------------------------------
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111]]




--[[22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
---------------------------------------����������Q�����h�����q������------------------------------
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222]]
function RendolRegistCondition_block2(proxy,param,chrId)
	print("RendolRegistCondition_block2 begin");
	if	proxy:IsCompleteEvent(RENDOL_STATE_DEAD) == false then
		if	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_2) == false then
		--��723�����q���G�΂��遡
			if proxy:IsCompleteEvent( 723 ) == false then
				--proxy:OnCharacterTotalDamage( 723, 620, LOCAL_PLAYER, 100, "OnEvent_723", once );
				proxy:OnCharacterTotalRateDamage( 723, 620, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_723", once );
			end
		end
	--��720�������h�������ӂ��遡
		--(�������̃^�C�~���O�ŁA�Ď���ǉ�)

	--��10800�����q���T�����J�n���遡(��b�V�X�e������Ăяo��)
		--(���q�����ӏ�ԂɂȂ����Ƃ��ɁA�Ď���ǉ�)



	--��724�����q�����ʁ�
		if proxy:IsCompleteEvent( 724 ) == false then
			proxy:OnCharacterDead( 724 , 620 , "OnEvent_724" , once );
		end	
	end
	print("RendolRegistCondition_block2 end");
end

-------------------------------------------------------------------------------------------------
--���q���B��Ă���̂ŏ����ď��--16005
function SetRendolState_05(proxy,param,chrId)
	print("SetRendolState_05 begin");
	--proxy:EnableLogic( chrId , false );--�����h�����q���W�b�NOFF(�A�C�e���n���҂�?)
	--proxy:SetEventCommand( chrId , 40 );--EzState�ɐ���ԍ�(������)��n���B
	
--��643�������h�����q�Ăт����͈͎擾��	
	--proxy:SetEventFlag( 643 , 0 );--����ǉ�����Ăق����̂ť��
	SingleReset(proxy,643);
	proxy:NotNetMessage_begin();
		if proxy:IsClient() == false then
			proxy:OnRegionJustIn( 643 , LOCAL_PLAYER , 2340 , "OnEvent_643" , everytime );
			proxy:OnRegionJustOut( 643, LOCAL_PLAYER , 2340 , "OnEvent_643_out" , everytime );
		end
	proxy:NotNetMessage_end();
	
	--���q�L����
	ValidCharactor( proxy, chrId );	
	
	--��652�������h���ǂ��������mA�̗L������
	if proxy:IsCompleteEvent( 652 ) == false then		
		ValidCharactor( proxy,102);
	end
	
	--��654�������h���ǂ��������mB�̗L������
	if proxy:IsCompleteEvent( 654 ) == false then
		ValidCharactor( proxy,103);
	end

	--��655�������h���ǂ��������mC�̗L������
	if proxy:IsCompleteEvent( 655 ) == false then
		ValidCharactor( proxy,104);
	end

	--��656�������h���ǂ��������mD�̗L������
	if proxy:IsCompleteEvent( 656 ) == false then		
		ValidCharactor( proxy,105);		
	end

	--��657�������h���ǂ��������mE�̗L������
	if proxy:IsCompleteEvent( 657 ) == false then
		ValidCharactor( proxy,106);
	end

	--��658�������h���ǂ��������mF�̗L������
	if proxy:IsCompleteEvent( 658 ) == false then
		ValidCharactor( proxy,107);
	end
	--[[
	ValidCharactor( proxy, 102 );
	ValidCharactor( proxy, 103 );
	]]
	print("SetRendolState_05 end");
end

-------------------------------------------------------------------------------------------------
--���q�����Ӂi����Q�j���--16006
function SetRendolState_06(proxy,param,chrId)
	print("SetRendolState_06 begin");
	--proxy:EnableLogic( chrId , false );--�����h�����q���W�b�NOFF(�A�C�e���n���҂�?)
	proxy:SetSpStayAndDamageAnimId( chrId,-1,-1);
	
	if proxy:IsCompleteEvent( 10800 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 10800 , 0 , "OnEvent_10800" , once );--��b�V�X�e������Ăԏꍇ�ɂ�param=0
		proxy:NotNetMessage_end();
	end
	
	--���q�L����
	ValidCharactor( proxy, chrId );
	
	--[[
	--���̏�ŏ������Ȃ��l�ɋ����Ń`�F�b�N�������Ă���
	if	proxy:IsDistance(LOCAL_PLAYER, 102, 20) == true then
		ValidCharactor( proxy, 102 );
	end
	if	proxy:IsDistance(LOCAL_PLAYER, 103, 20) == true then
		ValidCharactor( proxy, 103 );
	end
	]]
	print("SetRendolState_06 end");
end
-------------------------------------------------------------------------------------------------
--���q���T���i����Q�j���--16007
function SetRendolState_07(proxy,param,chrId)
	print("SetRendolState_07 begin");
	-----------------�����h�����q��ԃX�L�b�v�`�F�b�N-----------------------
	--���̏�������ł�
	if	proxy:IsCompleteEvent(4224) == true then
		--���ɉ��̏�������ł����̂ŉ���R�̏�Ԃ�
		if	proxy:IsCompleteEvent( 1041 ) == false then
			print("SetRendolState_07 �����h�����q�@���̏�������ł����̂ŁA����R�̏�Ԃֈڍs");
			SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_LOCATION_INVISIBLE );
			proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "RendolCheck", 0.0, 0, 2, once );
			
		--���ɉ���R�̃��o�[�����J���Ă����̂ŉ���S�̏�Ԃ�
		else
			print("SetRendolState_07 �����h�����q�@����R���o�[�����J���Ă���̂ŁA����S�̏�Ԃֈڍs");
			SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_LIFT_FRONT );
			proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "RendolCheck", 0.0, 0, 2, once );
		end
	end
	
	--���q�L����
	ValidCharactor( proxy, chrId );
	proxy:SetSpStayAndDamageAnimId( chrId,-1,-1);
	--�ړ��^�C�v�������ɕύX
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	
	--�ړ��|�C���g��ύX
	local point_list = {2220, 2221, 2222, 2223};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--�ړ��|�C���g��ݒ�
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	--[[
	--���̏�ŏ������Ȃ��l�ɋ����Ń`�F�b�N�������Ă���
	if	proxy:IsDistance(LOCAL_PLAYER, 102, 20) == true then
		ValidCharactor( proxy, 102 );
	end
	if	proxy:IsDistance(LOCAL_PLAYER, 103, 20) == true then
		ValidCharactor( proxy, 103 );
	end
	]]
	print("SetRendolState_07 end");
end

-------------------------------------------------------------------------------------------------
--���q���G�΁i����Q�j���--16008
function SetRendolState_08(proxy,param,chrId)
	print("SetRendolState_08 begin");
	
	print("�����h�����q���G�ɂȂ�܂���");
	proxy:EnableLogic( chrId , true );--[[�����h�����q���W�b�NON(���W�b�N�؂�ւ�?)]]
	--proxy:SetEventCommand( chrId , 41 );--EzState�ɐ���ԍ�(�����I��)��n���B
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( chrId , 5062 );
	--���q�L����
	ValidCharactor( proxy, chrId );
	--[[
	--���̏�ŏ������Ȃ��l�ɋ����Ń`�F�b�N�������Ă���
	if	proxy:IsDistance(LOCAL_PLAYER, 102, 40) == true then
		ValidCharactor( proxy, 102 );
	end
	if	proxy:IsDistance(LOCAL_PLAYER, 103, 40) == true then
		ValidCharactor( proxy, 103 );
	end
	]]
	print("SetRendolState_08 end");
end


--[[22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
---------------------------------------����������Q�����h�����q������------------------------------
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222]]


--[[33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
---------------------------------------����������R�����h�����q������------------------------------
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333]]
function RendolRegistCondition_block3(proxy,param,chrId)
	print("RendolRegistCondition_block3 begin");
	if	proxy:IsCompleteEvent(RENDOL_STATE_DEAD) == false then
		if	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_3_FRONT_GATE) == false and
			proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_3_BACK_GATE) == false then
		--��1316�����q���G�΂���(���O)��
			if proxy:IsCompleteEvent( 1316 ) == false then
				--proxy:OnCharacterTotalDamage( 1316 , 621 , LOCAL_PLAYER , 100 , "OnEvent_1316" , once );
				proxy:OnCharacterTotalRateDamage( 1316, 621, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1316", once );
			end
		
		--��1317�����q���G�΂���(�����)��
			if proxy:IsCompleteEvent( 1317 ) == false then
				--proxy:OnCharacterTotalDamage( 1317 , 621 , LOCAL_PLAYER , 100 , "OnEvent_1317" , once );
				proxy:OnCharacterTotalRateDamage( 1317, 621, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1317", once );
			end
		end


	--��11501�����q���T�����J�n���遡(��b�V�X�e������Ăяo��)
		if proxy:IsCompleteEvent( 11501 ) == false then
			proxy:NotNetMessage_begin();
				proxy:LuaCall( 11501 , 0 , "OnEvent_11501" , once );
			proxy:NotNetMessage_end();
		end

		
	--��1318�����q�����S���遡
		if proxy:IsCompleteEvent( 1318 ) == false then
			proxy:OnCharacterDead( 1318, 621, "OnEvent_1318", once );
		end
		
	--��1338�����q��b�p�̈攻�聡
		SingleReset( proxy,1338 );
		if proxy:IsCompleteEvent( 1338 ) == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionJustIn( 1338, 621 , 2416 , "OnEvent_1338_in",everytime);
				proxy:OnRegionJustOut( 1338 , 621 , 2416 , "OnEvent_1338_out",everytime);
			proxy:NotNetMessage_end();
		end
		
	end
	print("RendolRegistCondition_block3 end");
end


-------------------------------------------------------------------------------------------------
--���q�������Ȃ��ꏊ�ɂ���������--16009
function SetRendolState_09(proxy,param,chrId)
	print("SetRendolState_09 begin");
--��1310�����q����̑O�Ɉړ����遡
	--�K���ǉ�����
	proxy:SetEventFlag( 1310, false );
	proxy:OnRegionJustIn( 1310 , LOCAL_PLAYER , 2550 , "OnEvent_1310" , once );
--��1312�����q���܏��H�ɓ����������Ƃɋ��������遡
	if proxy:IsCompleteEvent( 1312 ) == false then
		proxy:OnRegionJustIn( 1312 , chrId , 2553 , "OnEvent_1312" , once );
	end
--��1349�����q����̑O�܂œ����������ǁA��͕܂��Ă���
	if	proxy:IsCompleteEvent( 1349 ) == false then
		proxy:OnRegionJustIn( 1349, chrId, 2415, "OnEvent_1349", once );
	end
	--���q�L����
	ValidCharactor( proxy, chrId );
	print("SetRendolState_09 end");
end

-------------------------------------------------------------------------------------------------
--���q������J���ė~�������--16010
function SetRendolState_10(proxy,param,chrId)
	print("SetRendolState_10 begin");
	--proxy:DisableInterupt( chrId, true );--���荞�݂��Ւf(�G�ɍU������Ă��퓬���W�b�N�ɂ��Ȃ�����)

	proxy:ChangeInitPosAng( chrId , 2552 );--�����̑O�̗̈�ɂ���
	proxy:EnableLogic( chrId , true );--���W�b�NON
	proxy:SendEventRequest( chrId, 0, AI_EVENT_None );
	proxy:ResetThink( chrId );
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
		proxy:Warp( chrId , 2552 );--�����ʒu�Ƀ��[�v
	end
	proxy:NotNetMessage_begin();
		----�����q��ǂ��G���o������1��
		--proxy:OnKeyTime2( 1350 , "OnEvent_1350" , 2.0 , 0 , 1 , once );
		
		--��1312�����q���܏��H�ɓ����������Ƃɋ��������遡
		if proxy:IsCompleteEvent( 1312 ) == false then
			proxy:OnRegionJustIn( 1312 , 621 , 2553 , "OnEvent_1312" , once );
		end
	proxy:NotNetMessage_end();
	
	--���q�L����
	ValidCharactor( proxy, chrId );
	print("SetRendolState_10 end");
end

-------------------------------------------------------------------------------------------------
--���q���܏��H�ŋ������--16011
function SetRendolState_11(proxy,param,chrId)
	print("SetRendolState_11 begin");
	proxy:ChangeInitPosAng( chrId , 2553 );--����܏��H�̗̈�ɂ���
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
		proxy:ForceUpdateNextFrame( chrId );
		proxy:Warp( chrId , 2553 );--�����ʒu�Ƀ��[�v
		print("�����h�����[�v�@2553");
	end
	--proxy:EnableLogic( chrId , false );--���W�b�NOFF
	--proxy:SetEventCommand( chrId, 40 );--������
	proxy:SetSpStayAndDamageAnimId(chrId,7600,9600);
	
	proxy:NotNetMessage_begin();
		proxy:NotNetMessage_begin();
			--�����q��ǂ��G�̑���ς���1��
			proxy:OnKeyTime2( 1360 , "OnEvent_1360" ,  5.0 , 0 , 1 , once );		
			--�����q��ǂ��G�̑���ς���2��
			proxy:OnKeyTime2( 1361 , "OnEvent_1361" ,  8.0 , 0 , 1 , once );		
			--�����q��ǂ��G�̑���ς���3��
			proxy:OnKeyTime2( 1362 , "OnEvent_1362" , 11.0 , 0 , 1 , once );
		proxy:NotNetMessage_end();
		--��1312�����q���܏��H�ɓ����������Ƃɋ��������遡
		if proxy:IsCompleteEvent( 1312 ) == false then
			proxy:OnRegionJustIn( 1312 , chrId , 2553 , "OnEvent_1312" , once );
		end
	proxy:NotNetMessage_end();
	
	--���q�L����
	ValidCharactor( proxy, chrId );
	print("SetRendolState_11 end");
end

-------------------------------------------------------------------------------------------------
--���q�����Ӂi����R�j���--16012
function SetRendolState_12(proxy,param,chrId)
	print("SetRendolState_12 begin");
	proxy:ChangeInitPosAng( chrId , 2555 );--����܏��H�̗̈�ɂ���
	
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
		proxy:Warp( chrId , 2555 );--�����ʒu�Ƀ��[�v
	end
	--proxy:EnableLogic( chrId, false );--���W�b�NOFF
	
	proxy:DisableInterupt( chrId, false );--���荞�݂�L��
	--proxy:SetEventCommand( chrId , 41 );--EzState�ɐ���ԍ��𑗂�(�����I��)
	proxy:SetSpStayAndDamageAnimId(chrId,-1,-1);
	
	--���q�L����
	ValidCharactor( proxy, chrId );
	print("SetRendolState_12 end");
end

-------------------------------------------------------------------------------------------------
--���q���T���i����R�j���--16013
function SetRendolState_13(proxy,param,chrId)
	print("SetRendolState_13 begin");
	
	--���q�L����
	ValidCharactor( proxy, chrId );
	
	proxy:EnableLogic( chrId , true );--�����h�����q�A�T����Ԃŕ����o��
	proxy:ResetThink( chrId );
	proxy:ChangeInitPosAng( chrId , 2555 );--����܏��H�̗̈�ɂ���
	proxy:ForceUpdateNextFrame( chrId );
	proxy:ClearTarget(chrId);
	proxy:SendEventRequest( chrId, 0, AI_EVENT_None );
	proxy:SetSpStayAndDamageAnimId(chrId,-1,-1);
	
	
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
		proxy:Warp( chrId , 2555 );--�����ʒu�Ƀ��[�v
	end
	
	--�ړ��^�C�v�������ɕύX
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	
	--�ړ��|�C���g��ύX
	local point_list = {2410, 2411, 2412, 2413, 2414};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--�ړ��|�C���g��ݒ�
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	
	print("SetRendolState_13 end");
end

-------------------------------------------------------------------------------------------------
--���q���G�΁i����R�j���̑O���--16014
function SetRendolState_14(proxy,param,chrId)
	print("SetRendolState_14 begin");
	proxy:ChangeInitPosAng( chrId , 2552 );--����܏��H�̗̈�ɂ���
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 60 ) == false then
		proxy:Warp( chrId , 2552 );--�����ʒu�Ƀ��[�v
	end
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( chrId , 5063 );
	proxy:EnableLogic( chrId , true );--���W�b�NON
	proxy:SendEventRequest( chrId , 0 , AI_EVENT_None );--���W�b�N��؂�ւ��Ă��̂���߂�B
	proxy:SetSpStayAndDamageAnimId(chrId,-1,-1);
	proxy:ResetThink( chrId );
	
	--���q�L����
	ValidCharactor( proxy, chrId );
	print("SetRendolState_14 end");
end

-------------------------------------------------------------------------------------------------
--���q���G�΁i����R�j���̌����--16015
function SetRendolState_15(proxy,param,chrId)
	print("SetRendolState_15 begin");
	proxy:ChangeInitPosAng( chrId , 2555 );--����܏��H�̗̈�ɂ���
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 60 ) == false then
		proxy:Warp( chrId , 2555 );--�����ʒu�Ƀ��[�v
	end
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( chrId , 5063 );
	proxy:SetSpStayAndDamageAnimId(621,-1,-1);
	proxy:EnableLogic( chrId , true );--���W�b�NON
	proxy:SendEventRequest( chrId , 0 , AI_EVENT_None );--���W�b�N��؂�ւ��Ă��̂���߂�B
	proxy:ResetThink( chrId );
	
	--���q�L����
	ValidCharactor( proxy, chrId );
	print("SetRendolState_15 end");
end

--[[33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
---------------------------------------����������R�����h�����q������------------------------------
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333]]



--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------����������S�����h�����q������------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]
function RendolRegistCondition_block4(proxy,param,chrId)
	print("RendolRegistCondition_block4 begin");
	
	if	proxy:IsCompleteEvent(RENDOL_STATE_DEAD) == false then
	--����S�ł̃����h�����q�̓G�ΊĎ��͂Ȃ��Ȃ�܂����B
--~ 		if	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_4_LIFT_FRONT) == false then
--~ 			--�����h�����q�G�ΊĎ�
--~ 			--proxy:OnCharacterTotalDamage( 1702, 626, LOCAL_PLAYER, 100, "OnEvent_1702", once );
--~ 			--proxy:OnCharacterTotalRateDamage( 1702, 626, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1702", once );
--~ 		end
		proxy:OnCharacterDead( 1700, 626, "OnEvent_1700", once );
		
		--��b�Ăяo���n���h��
		if	proxy:IsCompleteEvent(11790) == false then			
			proxy:LuaCall( 11790, 0, "OnEvent_11790", everytime );
		end
	end
	print("RendolRegistCondition_block4 end");
end

-------------------------------------------------------------------------------------------------
--���q���G���x�[�^�O���--16016
function SetRendolState_16(proxy,param,chrId)
	print("SetRendolState_16 begin");
	proxy:SetHp( chrId, 0.001);
	
	--���q�L����
	ValidCharactor( proxy, chrId );
	print("SetRendolState_16 end");
end
-------------------------------------------------------------------------------------------------
--���q���G�΁i����S�j���--16017
function SetRendolState_17(proxy,param,chrId)
	print("SetRendolState_17 begin");
	
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	
	--���q�L����
	ValidCharactor( proxy, chrId );
	print("SetRendolState_17 end");
end
-------------------------------------------------------------------------------------------------
--���q���G�΁i�Β��j���--16018
function SetRendolState_18(proxy,param,chrId)
	print("SetRendolState_16 begin");
	print("SetRendolState_18 end");
end

--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------����������S�����h�����q������------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]


--[[-----------------------------------------------------------------------------------------------------------------------------------------
	�����h�����q�֘A�@�����܂�
-----------------------------------------------------------------------------------------------------------------------------------------]]





--[[-----------------------------------------------------------------------------------------------------------------------------------------
	�r�������O�����֘A�@��������
-----------------------------------------------------------------------------------------------------------------------------------------]]
function BiyoCheck(proxy,param)
	BiyoCheck2(proxy,param,true);
end

function BiyoCheck2(proxy,param,flag)
	print("BiyoCheck begin");
	
	local biyo_id_2 = 622;--����Q�̃r�������O����
	local biyo_id_3 = 627;--����R�̃r�������O����
	local biyo_id_4 = 698;--����S�̃r�������O����
	
	local biyo_block2_acid_list = { 525, 526, 521, 522, 527 , 530};
	local biyo_block3_acid_list = { 1432, 1433, 1460};
	local biyo_block4_acid_list = { 1711, 1712, 1717};
	
	--����2�̃r���̃f�t�H���g�𖡕��ɕύX
	proxy:SetTeamType( biyo_id_2 , TEAM_TYPE_Friend );	
	
	--��U�S�������Ă���
	InvalidCharactor(proxy,biyo_id_2);
	InvalidCharactor(proxy,biyo_id_3);
	InvalidCharactor(proxy,biyo_id_4);
	
	--�Ď�����U�S�폜
	DeleteConditionList(proxy,biyo_block2_acid_list);
	DeleteConditionList(proxy,biyo_block3_acid_list);
	DeleteConditionList(proxy,biyo_block4_acid_list);
	
	
	
	SetFirstNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_CAPTIVE );
	
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������S���Ɏ������--16060
	if	proxy:IsCompleteEvent(BIYO_STATE_CAPTIVE) == true then
		print("biyo state BIYO_STATE_CAPTIVE");
		SetBiyoState_01(proxy, param, biyo_id_2 );
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O������������Ă���Ċ��ӏ��--16061
	elseif	proxy:IsCompleteEvent(BIYO_STATE_THANKS) == true then
		print("biyo state BIYO_STATE_THANKS");
		SetBiyoState_02(proxy, param, biyo_id_2 );
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������S���ŐQ�Ă�����--16062
	elseif	proxy:IsCompleteEvent(BIYO_STATE_SLEEPING_IN_PRISON) == true then
		print("biyo state BIYO_STATE_SLEEPING_IN_PRISON");
		if flag == true then 
			SetBiyoState_03(proxy, param, biyo_id_2 );
		else
			SetBiyoState_03Init(proxy , param , biyo_id_2 );
		end
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);		
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������G��(�S��)���--16063
	elseif	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_PRISON) == true then
		print("biyo state BIYO_STATE_HOSTILE_IN_PRISON");
		SetBiyoState_04(proxy, param, biyo_id_2 );
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O����������ł�����--16064
	elseif	proxy:IsCompleteEvent(BIYO_STATE_DEAD) == true then
		print("biyo state BIYO_STATE_DEAD");
		--�����ł͒ǉ����ݒ�����Ȃ�
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O������������|���������--16065
	elseif	proxy:IsCompleteEvent(BIYO_STATE_TARGET_ENEMY) == true then
		print("biyo state BIYO_STATE_TARGET_ENEMY");
		SetBiyoState_05(proxy, param, biyo_id_2 );
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������t�P���I����Ė������ĐQ����--16066
	elseif	proxy:IsCompleteEvent(BIYO_STATE_END_OF_STRIKES_BACK) == true then
		print("biyo state BIYO_STATE_END_OF_STRIKES_BACK");
		if flag == true then
			SetBiyoState_06(proxy, param, biyo_id_2 );
		else
			SetBiyoState_06Init(proxy, param, biyo_id_2 );		
		end
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������G��(���)���--16067
	elseif	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_RAMPART) == true then
		print("biyo state BIYO_STATE_HOSTILE_IN_RAMPART");
		SetBiyoState_07(proxy, param, biyo_id_2 );
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O����������3��T�����--16068
	elseif	proxy:IsCompleteEvent(BIYO_STATE_SEARCH_3) == true then
		print("biyo state BIYO_STATE_SEARCH_3");
		SetBiyoState_08(proxy, param, biyo_id_3 );
		BiyoRegistCondition_block3(proxy,param,biyo_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O���������̌���|���Ė������--16069
	elseif	proxy:IsCompleteEvent(BIYO_STATE_KING_OF_SWORD_KILL) == true then
		print("biyo state BIYO_STATE_KING_OF_SWORD_KILL");
		if flag == true then
			SetBiyoState_09(proxy, param, biyo_id_3 );
		else
			SetBiyoState_09Init(proxy, param, biyo_id_3 );
		end
		BiyoRegistCondition_block3(proxy,param,biyo_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������G��(���̌��̕���)���--16070
	elseif	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_KING_ROOM) == true then
		print("biyo state BIYO_STATE_HOSTILE_IN_KING_ROOM");
		SetBiyoState_10(proxy, param, biyo_id_3 );
		BiyoRegistCondition_block3(proxy,param,biyo_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O���������̌��̕����ŐQ����--16071
	elseif	proxy:IsCompleteEvent(BIYO_STATE_KING_ROOM_DOWN) == true then
		print("biyo state BIYO_STATE_KING_ROOM_DOWN");
		SetBiyoState_11(proxy, param, biyo_id_3 );
		BiyoRegistCondition_block3(proxy,param,biyo_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������򗳂̒��Ɛ키���--16072
	elseif	proxy:IsCompleteEvent(BIYO_STATE_BATTLE_FLY_DRAGON) == true then
		print("biyo state BIYO_STATE_BATTLE_FLY_DRAGON");
		SetBiyoState_12(proxy, param, biyo_id_4 );
		BiyoRegistCondition_block4(proxy,param,biyo_id_4);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������Β��ɖ߂肽�����--16073
	elseif	proxy:IsCompleteEvent(BIYO_STATE_RETURN_TO_STONE_PILLAR) == true then
		print("biyo state BIYO_STATE_RETURN_TO_STONE_PILLAR");
		SetBiyoState_13(proxy, param, biyo_id_4 );
		BiyoRegistCondition_block4(proxy,param,biyo_id_4);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������Β��ɂ�����--16074
	elseif	proxy:IsCompleteEvent(BIYO_STATE_WAIT_M1) == true then
		print("biyo state BIYO_STATE_WAIT_M1");
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������G��(�Β�)���--16075
	elseif	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_STONE_PILLAR) == true then
		print("biyo state BIYO_STATE_HOSTILE_IN_STONE_PILLAR");
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������G��(�Q�[�g�O)���--16076
	elseif	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_GATE_FRONT) == true then
		print("biyo state BIYO_STATE_HOSTILE_IN_GATE_FRONT");
		SetBiyoState_16(proxy, param, biyo_id_4 );
		BiyoRegistCondition_block4(proxy,param,biyo_id_4);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������������Ȃ����--16077
	elseif	proxy:IsCompleteEvent(BIYO_STATE_EXIT) == true then
		print("biyo state BIYO_STATE_EXIT");
	end
	
	print("BiyoCheck end");
end

--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------����������Q�r�������O����������------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]

function BiyoRegistCondition_block2(proxy,param,chrId)
	print("BiyoRegistCondition_block2 begin");
	if	proxy:IsCompleteEvent( BIYO_STATE_DEAD ) == false then
		if	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_PRISON ) == false and
			proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_RAMPART) == false then
			
			--��525���r�����S���œG�ɂȂ遡
			if proxy:IsCompleteEvent( 525 ) == false then
				--proxy:OnCharacterTotalDamage( 525 , 622 , LOCAL_PLAYER , 100 , "OnEvent_525" , once );
				proxy:OnCharacterTotalRateDamage( 525, 622, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_525", once );
			end
			
			--��526���r������ǂœG�ɂȂ遡
			if proxy:IsCompleteEvent( 526 ) == false then
				--proxy:OnCharacterTotalDamage( 526 , 622 , LOCAL_PLAYER , 100 , "OnEvent_526" , once );
				proxy:OnCharacterTotalRateDamage( 526, 622, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_526", once );
			end
		end

		--��521���r����������|���ɍs����(��b�V�X�e������Ăяo��)
		if proxy:IsCompleteEvent( 521 ) == false then
				proxy:LuaCall( 521 , 0 , "OnEvent_521" , once );--��b�V�X�e������Ăяo���ꍇ��param=0���w��
		end
		--��522���r�����S�����ŐQ�遡(��b�V�X�e������Ăяo��)
		if proxy:IsCompleteEvent( 522 ) == false then
				proxy:LuaCall( 522 , 0 , "OnEvent_522" , once );--��b�V�X�e������Ăяo���ꍇ��param=0���w��
		end

		--��527���r�����S��
		if proxy:IsCompleteEvent( 527 ) == false then
			proxy:OnCharacterDead(527,622,"OnEvent_527",once);
		end
		
		--��530���r�����t�P�ɖ������ĐQ�遡(��b�V�X�e������Ăяo��)
		proxy:LuaCall( 530, 0, "OnEvent_530", everytime );--��b�V�X�e������Ăяo���ꍇ��param=0���w��
	end
	print("BiyoRegistCondition_block2 end");
end


----------------------------------------------------------------------------------------------------------------
--�r�������O�������S���Ɏ������--16060
function SetBiyoState_01(proxy,param,chrId)
	print("SetBiyoState_01 begin");
	ValidCharactor( proxy, chrId );
	print("SetBiyoState_01 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O������������Ă���Ċ��ӏ��--16061
function SetBiyoState_02(proxy,param,chrId)
	print("SetBiyoState_02 begin");
	ValidCharactor( proxy, chrId );
	proxy:SetTeamType( chrId , TEAM_TYPE_BattleFriend );
	print("SetBiyoState_02 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O�������S���ŐQ�Ă�����--16062
function SetBiyoState_03(proxy,param,chrId)
	print("SetBiyoState_03 begin");
	--���̌������Ɏ���ł���
	if	proxy:IsCompleteEvent(4360) == true then
		print("SetBiyoState_03 ���̌�������ł���̂Ŕ�ы�");
		--�򗳂̒��̏�Ԃ�����ł���Ƃ�
		if	proxy:IsCompleteEvent(TYO_STATE_DEAD) == true then
			print("SetBiyoState_03 �򗳂̒�������ł���̂ŁA�������Ȃ���Ԃ�");
			SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_EXIT );
			proxy:SetEventFlag( 529, true);
		else
			print("SetBiyoState_03 �򗳂̒��������Ă���̂ŁA�򗳂̒��Ɛ키��Ԃ�");
			SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_BATTLE_FLY_DRAGON );
		end
	else
		--�r���̏�Ԃ��u����3��T���v�ɂ���
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_SEARCH_3 );
		--��Ԃ�ς����̂ōă`�F�b�N
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "BiyoCheck", 0.0, 0, 2, once );
		proxy:NotNetMessage_begin();
	end
	print("SetBiyoState_03 end");
end

-------------------------------------------------------------------------------------------------
--�r�������O�������S���ŐQ�Ă����ԏ������`�F�b�N--16062
function SetBiyoState_03Init(proxy,param,chrId)
	print("SetBiyoState_03Init begin");
	ValidCharactor( proxy, chrId );--�L����
	print("SetBiyoState_03Init end");
end

-------------------------------------------------------------------------------------------------
--�r�������O�������G��(�S��)���--16063
function SetBiyoState_04(proxy,param,chrId)
	print("SetBiyoState_04 begin");
	ValidCharactor( proxy, chrId );
	proxy:EraseEventSpecialEffect_2(chrId,5064);
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	print("SetBiyoState_04 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O������������|���������--16065
function SetBiyoState_05(proxy,param,chrId)
	print("SetBiyoState_05 begin");
	ValidCharactor( proxy, chrId );
	proxy:SetTeamType( chrIs , TEAM_TYPE_BattleFriend );	
	print("SetBiyoState_05 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O�������t�P���I����Ė������ĐQ����--16066
function SetBiyoState_06(proxy,param,chrId)
	print("SetBiyoState_06 begin");
	--���̌������Ɏ���ł���
	if	proxy:IsCompleteEvent(4360) == true then
		print("SetBiyoState_06 ���̌�������ł���̂Ŕ�ы�");
		--�򗳂̒��̏�Ԃ�����ł���Ƃ�
		if	proxy:IsCompleteEvent(TYO_STATE_DEAD) == true then
			print("SetBiyoState_06 �򗳂̒�������ł���̂ŁA�������Ȃ���Ԃ�");
			SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_EXIT );
			proxy:SetEventFlag( 529, true);
		else
			print("SetBiyoState_06 �򗳂̒��������Ă���̂ŁA�򗳂̒��Ɛ키��Ԃ�");
			SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_BATTLE_FLY_DRAGON );
		end
	else
		--�r���̏�Ԃ��u����3��T���v�ɂ���
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_SEARCH_3 );
		--��Ԃ�ς����̂ōă`�F�b�N
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "BiyoCheck", 0.0, 0, 2, once );
		proxy:NotNetMessage_begin();
	end
	print("SetBiyoState_06 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O�������t�P���I����Ė������ĐQ���ԗp�̏�����--16066
function SetBiyoState_06Init(proxy,param,chrId)
	print("SetBiyoState_06Init beign");
	ValidCharactor( proxy, chrId );--�L����
	print("SetBiyoState_06Init end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O�������G��(���)���--16067
function SetBiyoState_07(proxy,param,chrId)
	print("SetBiyoState_07 begin");
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2(chrId,5064);
	ValidCharactor( proxy, chrId );
	print("SetBiyoState_07 end");
end



--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------����������Q�r�������O����������------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]


--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------����������R�r�������O����������------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]
function BiyoRegistCondition_block3(proxy,param,chrId)
	print("BiyoRegistCondition_block3 begin");
	if	proxy:IsCompleteEvent( BIYO_STATE_DEAD ) == false then
		proxy:OnCharacterDead( 1433, 627, "OnEvent_1433", once );
		if proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_KING_ROOM) == false then
			--proxy:OnCharacterTotalDamage( 1432, 627, LOCAL_PLAYER, 100, "OnEvent_1432", once );
			proxy:OnCharacterTotalRateDamage( 1432, 627, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1432", once );
			if proxy:IsCompleteEvent(1470) == false then
				proxy:OnRegionJustIn( 1470 , LOCAL_PLAYER , 2581 , "OnEvent_1470",once );
			end
		end
		--��1460���r����������|���ɍs����(��b�V�X�e������Ăяo��)
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 1460 , 0 , "OnEvent_1460" , everytime );--��b�V�X�e������Ăяo���ꍇ��param=0���w��
		proxy:NotNetMessage_end();
	end
	print("BiyoRegistCondition_block3 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O����������3��T�����--16068
function SetBiyoState_08(proxy,param,chrId)
	print("SetBiyoState_08 begin");
	proxy:EnableLogic( chrId,false );	
	ValidCharactor( proxy, chrId );	
	print("SetBiyoState_08 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O���������̌���|���Ė������--16069
function SetBiyoState_09(proxy,param,chrId)
	print("SetBiyoState_09 begin");
	ValidCharactor( proxy, chrId );
	--ValidCharactor( proxy, 627 );	
--~ 	if	proxy:IsDistance( chrId, LOCAL_PLAYER, 20 ) == false then
--~ 		proxy:Warp( chrId, 2580 );
--~ 	end
	
	print("SetBiyoState_09 Param3 = ",param:GetParam3() );
	--�|�C���g���Ⴄ�ꍇ�͓��ɉ������Ȃ�
	if	param:GetParam3() == 2590 then
		print("SetBiyoState_09 Param return end");
		return;
	end

	--�򗳂̒�������ł��邩�H
	if	proxy:IsCompleteEvent(TYO_STATE_DEAD) == true then
		print("SetBiyoState_09 �򗳂̒�������ł���̂ŁA�������Ȃ���Ԃ�");
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_EXIT );
		proxy:SetEventFlag( 1462, true );
		proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "BiyoCheck", 0.0, 0, 2, once );
	else
		print("SetBiyoState_09 �򗳂̒��������Ă���̂ŁA�򗳂̒��Ɛ키��Ԃ�");
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_BATTLE_FLY_DRAGON );
		proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "BiyoCheck", 0.0, 0, 2, once );
	end
	
	print("SetBiyoState_09 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O���������̌���|���Ė�����ԗp�̏�����--16069
function SetBiyoState_09Init(proxy,param,chrId)
	print("SetBiyoState_09Init begin");
	ValidCharactor( proxy, chrId );
	print("SetBiyoState_09Init end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O�������G��(���̌��̕���)���--16070
function SetBiyoState_10(proxy,param,chrId)
	print("SetBiyoState_10 begin");
	ValidCharactor( proxy, chrId );
	--proxy:Warp( chrId, 2580 );
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2(chrId,5064);
	print("SetBiyoState_10 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O���������̌��̕����ŐQ����--16071
function SetBiyoState_11(proxy,param,chrId)
	print("SetBiyoState_11 begin");
	print("SetBiyoState_11 end");
end

--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------����������R�r�������O����������------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]


--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------����������S�r�������O����������------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]
function BiyoRegistCondition_block4(proxy,param,chrId)
	print("BiyoRegistCondition_block4 begin");
	if	proxy:IsCompleteEvent( BIYO_STATE_HOSTILE_IN_GATE_FRONT) == false then
		--proxy:OnCharacterTotalDamage( 1711, chrId, LOCAL_PLAYER, 100, "OnEvent_1711", once );
		proxy:OnCharacterTotalRateDamage( 1711, chrId, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1711", once );
	end
	
	--��1717���r�����Q�遡(��b�V�X�e������Ăяo��)
	proxy:LuaCall( 1717, 0, "OnEvent_1717", everytime );--��b�V�X�e������Ăяo���ꍇ��param=0���w��
	
	--��1790���򗳂̏����r�������O�����ɋ�����
	proxy:OnRegistFunc( 1790, "Condition_1790", "dummy", 2, once );

	proxy:OnCharacterDead( 1712, chrId, "OnEvent_1712", once );

	print("BiyoRegistCondition_block4 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O�������򗳂̒��Ɛ키���--16072
function SetBiyoState_12(proxy,param,chrId)
	print("SetBiyoState_12 begin");
	if	proxy:IsCompleteEvent( TYO_STATE_DEAD ) == true then
		SetNpcStateFlag(proxy, param, biyo_flag_list, BIYO_STATE_EXIT);
		proxy:SetEventFlag( 1716, true );
		proxy:OnKeyTime2(SYSTEM_CHECK_POINT, "BiyoCheck", 0.0, 0, 2, once);
	end
	ValidCharactor( proxy, chrId );
	print("SetBiyoState_12 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O�������Β��ɖ߂肽�����--16073
function SetBiyoState_13(proxy,param,chrId)
	print("SetBiyoState_13 begin");
	ValidCharactor( proxy, chrId );
	print("SetBiyoState_13 end");
end


----------------------------------------------------------------------------------------------------------------
--�r�������O�������G��(�Q�[�g�O)���--16076
function SetBiyoState_16(proxy,param,chrId)
	print("SetBiyoState_16 begin");
	ValidCharactor( proxy, chrId );
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2(chrId,5064);
	print("SetBiyoState_16 end");
end
--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------����������S�r�������O����������------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]


--[[-----------------------------------------------------------------------------------------------
---------------------------------------�������Β��r�������O����������------------------------------
-----------------------------------------------------------------------------------------------]]

----------------------------------------------------------------------------------------------------------------
--�r�������O�������Β��ɂ�����--16074
function SetBiyoState_14(proxy,param,chrId)
	print("SetBiyoState_14 begin");
	print("SetBiyoState_14 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O�������G��(�Β�)���--16075
function SetBiyoState_15(proxy,param,chrId)
	print("SetBiyoState_15 begin");
	print("SetBiyoState_15 end");
end

--[[-----------------------------------------------------------------------------------------------
---------------------------------------�������Β��r�������O����������------------------------------
-----------------------------------------------------------------------------------------------]]


--[[-----------------------------------------------------------------------------------------------------------------------------------------
	�r�������O�����֘A�@�����܂�
-----------------------------------------------------------------------------------------------------------------------------------------]]


--[[-----------------------------------------------------------------------------------------------------------------------------------------
	�򗳂��ő��֘A�@��������
-----------------------------------------------------------------------------------------------------------------------------------------]]

--��236���򗳂��ő��̕\���ؑ�
--��807���򗳂��ő��̕\���ؑ�
function HiryuKenzokuCheck(proxy,param)
	print("HiryuKenzokuCheck begin");
--����(�ő�)�C�x���g�֘A������

	--������Ԃ��Z�b�g(��Ԃ����ݒ�̏ꍇ�A�w�肵����Ԃ��Z�b�g����)
	SetFirstNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_WARNING );
	
	--local regionId	   = param:GetParam3();--�̈�̃C�x���gID
	local block_id		= param:GetParam2();
	local kenzoku_id_1 = 301;--����P�̔򗬂��ő�
	local kenzoku_id_2 = 110;--����Q�̔򗬂��ő�
	
	local kenzoku_block1_acid_list = { 190, 191, 199, 221, 230, 231, 232, 233, 234};
	local kenzoku_block2_acid_list = { 805, 800, 801, 802, 803, 804, 806};
	
	proxy:AddFieldInsFilter(kenzoku_id_1);
	proxy:AddFieldInsFilter(kenzoku_id_2);
	
	--��U�S�������Ă���
	InvalidCharactor(proxy,kenzoku_id_1);
	InvalidCharactor(proxy,kenzoku_id_2);
	
	--�Ď�����U�S�폜
	DeleteConditionList(proxy,kenzoku_block1_acid_list);
	DeleteConditionList(proxy,kenzoku_block2_acid_list);
	
	--�펞�o�b�N���[�hOFF
	proxy:SetAlwayEnableBackread_forEvent( kenzoku_id_1, false );
	proxy:SetAlwayEnableBackread_forEvent( kenzoku_id_2, false );
	
	--�����X�V����
	LuaFunc_NormalOmission( proxy, kenzoku_id_1 );
	LuaFunc_NormalOmission( proxy, kenzoku_id_2 );
	
	--�򗳂��ő��������Ă���
	if	proxy:IsCompleteEvent(KENZOKU_2_STATE_DEAD) 			== false and
		proxy:IsCompleteEvent(KENZOKU_STATE_DEAD) 				== false then
		
		--����P�p�̃`�F�b�N�|�C���g���H
		if	block_id == 0 then
			
			--��35��QWC�ɂ��򗳂̖�����
			if	proxy:IsCompleteEvent(35) == false then
				--�P�ނł͖���
				if proxy:IsCompleteEvent( KENZOKU_STATE_ESCAPE ) == false then
					--������
					proxy:SetDisableGravity( kenzoku_id_1 , true );--�d��OFF
					proxy:EnableLogic( kenzoku_id_1 , false );--�v�lOFF
					proxy:SetSuperArmor( kenzoku_id_1 , true );--�_���[�W���[�V���������Ȃ�
					proxy:SetDeadMode( kenzoku_id_1, true);--�򗳂͎��ȂȂ��ݒ�(���ɂ����ɂȂ�����P�ނ���)
					proxy:SetAlwayEnableBackread_forEvent( kenzoku_id_1, true );
					LuaFunc_ForceOmission(proxy, kenzoku_id_1 );
					proxy:ForcePlayLoopAnimation( kenzoku_id_1 , 0 );--�x�����Ă���A�j�����[�v�Đ�
					if proxy:IsClient() == false then
						proxy:RequestForceUpdateNetwork(kenzoku_id_1);
					end
					ValidCharactor( proxy, kenzoku_id_1 );
					
					--����P�򗳊Ǘ��p�A�N�V����ID:199(�C�x���g�Ŏ��R�Ɏg����A�N�V����ID)
					SingleReset( proxy, 199 );
					if	proxy:IsClient() == false then
						--���o�[���䂩��Ă�����j�~���߁A�����łȂ���Βʏ�̑��ɂ����Ԃ�
						if	proxy:IsCompleteEvent( 0 ) == true then
							SetNpcStateFlag( proxy, param, kenzoku_flag_list, KENZOKU_STATE_WARNING_AND_LEVER );
						else
							SetNpcStateFlag( proxy, param, kenzoku_flag_list, KENZOKU_STATE_WARNING );
						end
						
					end
					
					--��234����(�ő�)�̓P�ފĎ�(25%�ȉ��œP��)��
					SingleReset( proxy, 234 );
					proxy:NotNetMessage_begin();
						proxy:OnCharacterHP( 234 , kenzoku_id_1 , "OnEvent_234" , 0.25 , once );
						proxy:LuaCall( 234, 2, "OnEvent_234_1", everytime );
					proxy:NotNetMessage_end();
					
					if	proxy:IsCompleteEvent( 234 ) == false then					
						if	proxy:IsClient() == false then
							proxy:NotNetMessage_begin();
							proxy:OnKeyTime2( 199, "OnEvent_199", 0.0, 0, 2, once );
							proxy:NotNetMessage_end();
						end
						
						proxy:LuaCall( 199, 1, "OnEvent_199_default", everytime );
						proxy:LuaCall( 221, 1, "OnEvent_221_1", everytime );
						proxy:LuaCall( 221, 2, "OnEvent_221_2", everytime );
						proxy:LuaCall( 190, 1, "OnEvent_190_1", everytime );
						proxy:LuaCall( 190, 2, "OnEvent_190_2", everytime );
						proxy:LuaCall( 191, 1, "OnEvent_191_1", everytime );
						proxy:LuaCall( 191, 2, "OnEvent_191_2", everytime );
						proxy:LuaCall( 230, 1, "OnEvent_230_1", everytime );
						proxy:LuaCall( 230, 2, "OnEvent_230_2", everytime );
						proxy:LuaCall( 231, 1, "OnEvent_231_1", everytime );
						proxy:LuaCall( 231, 2, "OnEvent_231_2", everytime );
						proxy:LuaCall( 232, 1, "OnEvent_232_1", everytime );
						proxy:LuaCall( 232, 2, "OnEvent_232_2", everytime );
					end
				end
			end
		--����Q�p�̃`�F�b�N�|�C���g���H
		elseif	block_id == 1 then
		--elseif	regionId == 2390 or regionId == 2391 then
			proxy:SetAlwayEnableBackread_forEvent( kenzoku_id_2, true );
			LuaFunc_ForceOmission(proxy, kenzoku_id_2 );
			--�򗳂̃A�j���Đ��̃g���K�[(�ŏ����炸���ƂƂ�ł���)
			if proxy:IsClient() == false then
				--�z�X�g�̔򗳃A�j�����[�v�J�n
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2( 800 , "OnEvent_800" , 0.0 , 0 , 1 , once );
				proxy:NotNetMessage_end();
				--�X�V�����̓z�X�g���Ǘ�
				--�����ł̓z�X�g�����������ƁA�l�b�g���[�N�̍��W�����̖��ŃN���C�A���g���ł̌����ڂ������Ȃ�ׁA
				--�������Œ肵�܂���B
				--proxy:RequestForceUpdateNetwork(kenzoku_id_2);
			end
			
			--��800���򗳂��ő��Q�����C�ɔ�щ�遡	
			--��801���򗳂��ő��Q���̈�A���u���X�U����	
			--��802���򗳂��ő��Q���̈�B���u���X�U����
			--��803���򗳂��ő��Q���̈�C���u���X�U����	
			--��804���򗳂��ő��Q���w���w���ɂȂ�Ȃ����щ�遡
			--��805���򗳂��ő��Q���w���w���ɂȂ遡
			--��806���򗳂��ő��Q�����ʁ�(���ۂɂ͎��ɑ҂����)
			
			--���򗳃A�j���̓����Đ��p��
			proxy:LuaCall( 800 , 1 , "OnEvent_800_syncro_anime"   , everytime );--�ҋ@
			proxy:LuaCall( 800 , 2 , "OnEvent_800_2_syncro_anime" , everytime );--�ҋ@2
			proxy:LuaCall( 800 , 3 , "OnEvent_800_3_syncro_anime" , everytime );--���S�ҋ@
			proxy:LuaCall( 801 , 1 , "OnEvent_801_syncro_anime" , everytime );--�u���XA
			proxy:LuaCall( 802 , 1 , "OnEvent_802_syncro_anime" , everytime );--�u���XB
			proxy:LuaCall( 803 , 1 , "OnEvent_803_syncro_anime" , everytime );--�u���XC
			proxy:LuaCall( 804 , 1 , "OnEvent_804_syncro_anime" , everytime );--�w���w��
			proxy:LuaCall( 806 , 1 , "OnEvent_806_syncro_anime" , everytime );--���S		
			--[[
			if proxy:IsCompleteEvent( 805 ) == false then
				proxy:OnCharacterHP( 805 , kenzoku_id_2 , "OnEvent_805" , 0.5 , once );
			end
			]]
			if proxy:IsCompleteEvent( 806 ) == false then
				proxy:OnCharacterHP( 806 , kenzoku_id_2 , "OnEvent_806" , 0.01 , once );
			end

			
			proxy:EnableLogic( kenzoku_id_2, false );
			ValidCharactor( proxy, kenzoku_id_2 );
		end
	end
	
	print("HiryuKenzokuCheck end");
	
	--����P�̒��̕`��𐧌����܂�
	print("HiryuOsa DrawCheck�@begin");
	if block_id == 0 then
		if	proxy:IsCompleteEvent(35) == false then
			if 	proxy:IsCompleteEvent( TYO_STATE_DEAD ) == false and	--����łȂ�
				proxy:IsCompleteEvent( TYO_STATE_ESCAPE ) == false then		--�P�ނ��ĂȂ�
				--�L��
				ValidCharactor(proxy,300);
				print("�L�꒷�L�����ł�");
			else
				print("�L�꒷�@���S�Ȃ̂Ŗ������ł�");
				InvalidCharactor(proxy,300);
			end
		else
			print("�L�꒷�@QWC�Ŗ������ł�");
			InvalidCharactor(proxy,300);
		end
	else
		--����
		InvalidCharactor(proxy,300);
		print("�L�꒷�u���b�N�O�������ł�")
	end
	print("HiryuOsa DrawCheck�@end");
end




--[[-----------------------------------------------------------------------------------------------------------------------------------------
	�򗳂��ő��֘A�@�����܂�
-----------------------------------------------------------------------------------------------------------------------------------------]]


--[[-----------------------------------------------------------------------------------------------------------------------------------------
	�򗳂̒��֘A�@��������
-----------------------------------------------------------------------------------------------------------------------------------------]]


function HiryuOsaCheck(proxy,param)
	print("HiryuOsaCheck begin");
	
	--������Ԃ��Z�b�g(��Ԃ����ݒ�̏ꍇ�A�w�肵����Ԃ��Z�b�g����)
	SetFirstNpcStateFlag( proxy , param , tyo_flag_list , TYO_STATE_WARNING_AISLE );
	SetFirstNpcStateFlag( proxy , param , tyo1_flag_list , TYO_STATE_SLEEPING );
	
	proxy:DeleteEvent(220);
	proxy:DeleteEvent(235);
	proxy:DeleteEvent(1770);

	--InvalidCharactor(proxy,300);
	InvalidCharactor(proxy,501);
	if	proxy:IsCompleteEvent(TYO_STATE_DEAD)	== true then
		print("HiryuOsaCheck state check end");
		return;
	end
	
	--�펞�o�b�N���[�hOFF
	proxy:SetAlwayEnableBackread_forEvent( 300, false );
	proxy:SetAlwayEnableBackread_forEvent( 501, false );
	
	--�����X�V����
	LuaFunc_NormalOmission( proxy, 300 );
	LuaFunc_NormalOmission( proxy, 501 );
	
		
	--����P�̔򗳂̒�
	--QWC����`�F�b�N
	if	proxy:IsCompleteEvent(35) == false then
		if proxy:IsCompleteEvent(TYO_STATE_ESCAPE) == false then--�P�ނ��ĂȂ�
			if 	proxy:IsCompleteEvent( TYO_STATE_DEAD ) == false then
				--ValidCharactor(proxy, 300 );
				proxy:SetAlwayEnableBackread_forEvent( 300, true );
				LuaFunc_ForceOmission(proxy, 300 );
				--����P�̔򗳂̒�
				proxy:PlayLoopAnimation(300,7000);
				proxy:EnableLogic(300, false);
				proxy:Warp( 300, 2055 );
				--��220����(��)���Q�Ă��遡
				SingleReset(proxy, 220);
				proxy:OnRegionIn( 220 , LOCAL_PLAYER , 2130 , "OnEvent_220" , everytime );
						
				--��235����(��)�̎��S�Ď���
				proxy:NotNetMessage_begin();
					--proxy:OnCharacterDead( 235 , 300 , "OnEvent_235" , once );
					proxy:OnCharacterHP( 235 , 300 , "OnEvent_235" , 0.01 , once );
				proxy:NotNetMessage_end();
			end
		end
	end
	

	--����S�̔򗳂̒�
	if 	proxy:IsCompleteEvent( 4480 ) ==false and --�{�X�������Ă���Ƃ�
		proxy:IsCompleteEvent( TYO_STATE_DEAD ) == false then --��������łȂ���
		ValidCharactor(proxy, 501 );
		
		--DeleteEvent�ŏ�����Ă��܂��̂őދ�
		if proxy:IsCompleteEvent( 1560 ) == false then--�o��|�������Ă��Ȃ�������
		
			InvalidCharactor( proxy , 501 );--�򗳂��Ȃ�
			
			--���o�p(?)��OBJ�𖳌���(�`�楓�����OFF)���Ă���
			proxy:SetDrawEnable( 1720 , false );
			proxy:SetColiEnable( 1720 , false );
			
			proxy:SetDrawEnable( 1721 , false );
			proxy:SetColiEnable( 1721 , false );
			
			proxy:SetDrawEnable( 1710 , false );
			proxy:SetColiEnable( 1710 , false );
			
			proxy:SetDrawEnable( 1711 , false );
			proxy:SetColiEnable( 1711 , false );
		else
		
			--���򗳂��Đ�����A�j���̔���p�g���K�[(����or�O���C�̂�)��
			if proxy:IsClient() == false then
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2( 1590 , "OnEvent_1590" , 0.0 , 0 , 1 , once );
				proxy:NotNetMessage_end();
			end
			
			--���o�p(?)��OBJ��L����/����������
			proxy:SetDrawEnable( 1720 , true );
			proxy:SetColiEnable( 1720 , true );
			
			proxy:SetDrawEnable( 1721 , true );
			proxy:SetColiEnable( 1721 , true );
			
			proxy:SetDrawEnable( 1700 , false );
			proxy:SetColiEnable( 1700 , false );
			
			proxy:SetDrawEnable( 1701 , false );
			proxy:SetColiEnable( 1701 , false );
		end
		--������
		proxy:SetDisableGravity( 501 , true );--�d��OFF
		proxy:EnableLogic( 501 , false );--�v�lOFF
		proxy:SetSuperArmor( 501 , true );--�_���[�W���[�V���������Ȃ�
		proxy:SetDeadMode(501, true);--�򗳂͎��ȂȂ��ݒ�(���ɂ����ɂȂ�����P�ނ���)
		proxy:SetAlwayEnableBackread_forEvent( 501, true );
		LuaFunc_ForceOmission(proxy, 501 );
		
		--��1770���򗳂̒���������ԁ�
		if	proxy:IsCompleteEvent( 1770 ) == false then
			proxy:OnCharacterHP( 1770 , 501 , "OnEvent_1770" , 0.01 , once );
		end
		
	end
	print("HiryuOsaCheck end");
end

--[[-----------------------------------------------------------------------------------------------------------------------------------------
	�򗳂̒��֘A�@�����܂�
-----------------------------------------------------------------------------------------------------------------------------------------]]




--��60���~�����_���S������
function OnEvent_60(proxy, param)
	print("OnEvent_60 begin");
	print("�~�����_�͎��S���܂����B");
	proxy:SetEventFlag( 60, true );
	print("OnEvent_60 end");
end

--��62���u���b�N�~�����_���S��
function OnEvent_62(proxy,param)
	print("OnEvent_62 begin");
	proxy:SetEventFlag(62, true);
	print("OnEvent_62 end");
end

--��15635���~�����_���̎��̂�����ׂ���
function OnEvent_15635(proxy,param)
	print("OnEvent_15635 begin");
	proxy:SetEventFlag( 15635 , true );
	print("OnEvent_15635 end");
end

--��86���~�����_��b�p�t���OON��
function OnEvent_86(proxy,param)
	print("OnEvent_86 begin");
	proxy:SetEventFlag( 86,true );
	print("OnEvent_86 end");
end

--��15605���~�����_�̎��̒��ׂ���
function OnEvent_15605(proxy,param)
	print("OnEvent_15605 begin");
	proxy:SetEventFlag( 15605 , true );
	print("OnEvent_15605 end");
end

------------------------------
--�z�ꕺ�m�V���b�v�̏�ԕω�--
------------------------------
--���z�ꕺ�m������1�œG�΂��遥--
function OnEvent_341(proxy, param)
	print("OnEvent_341 begin");

	--���W�b�NOn
	proxy:EnableLogic( 691, true );
	
	--�z�ꕺ�m�̏�Ԃ�G��(����1)�ɂ���
	SetNpcStateFlag(proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_HOSTILE01);
	--�z�ꕺ�m�̃`�[���^�C�v��ύX����
	proxy:SetTeamType( 691, TEAM_TYPE_AngryFriend );

	--�t���O�𗧂Ă�
	proxy:SetEventFlag( 341, true );
	
	print("OnEvent_341 end");
end
--��-------------------------��--


--���z�ꕺ�m�����S����(����1)��--
function OnEvent_342(proxy, param)
	print("OnEvent_342 begin");

	--�z�ꕺ�m�̏�Ԃ��u���S�v�ɕς���
	SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_DEAD );
	
	--�t���O�𗧂Ă�
	proxy:SetEventFlag( 342, true );
	
	--�G�ɍ���ēG�΂�ʂ�z���Ď��S�����肦��̂ŁA�����ł��폜
	--���񂾂�G�΂ɂ͂Ȃ�Ȃ��̂ō폜
	proxy:DeleteEvent( 341 );
	proxy:DeleteEvent( 760 );
	proxy:DeleteEvent( 1441 );

	print("OnEvent_342 end");
end

--��-------------------------��--


--[[���z�ꕺ�m�����S����(����3)��--
function OnEvent_1441(proxy, param)
	print("OnEvent_1441 begin");

	--�z�ꕺ�m�̏�Ԃ��u���S�v�ɕς���
	SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_DEAD );
	
	--�t���O�𗧂Ă�
	proxy:SetEventFlag( 1441, true );
	
	--�G�ɍ���ēG�΂�ʂ�z���Ď��S�����肦��̂ŁA�����ł��폜
	--���񂾂�G�΂ɂ͂Ȃ�Ȃ��̂ō폜
	proxy:DeleteEvent( 341 );
	proxy:DeleteEvent( 760 );
	proxy:DeleteEvent( 1441 );

	print("OnEvent_1441 end");
end

--��-------------------------��--]]

--[[
function OnEvent_343(proxy, param) proxy:LuaCallStart(781, 1); end
function OnEvent_344(proxy, param) proxy:LuaCallStart(781, 1); end
function OnEvent_345(proxy, param) proxy:LuaCallStart(781, 1); end
function OnEvent_780(proxy, param) proxy:LuaCallStart(781, 1); end
]]


function OnEvent_781(proxy, param)
	print("OnEvent_781 begin");
	print("JustInCheckPoint");
	
	local DoreiShop01_id = 691;
	local DoreiShop02_id = 623;
	local DoreiShop03_id = 679;
	
	local DoreiShopBlock1_acid_list = {340,341,342};
	local DoreiShopBlock2_acid_list = {760,761,762};
	local DoreiShopBlock3_acid_list = {1440,1441};
	
	--��U3�̂Ƃ�������
	InvalidCharactor(proxy,DoreiShop01_id);
	InvalidCharactor(proxy,DoreiShop02_id);
	InvalidCharactor(proxy,DoreiShop03_id);
	
	if proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork( DoreiShop01_id);
		proxy:RequestForceUpdateNetwork( DoreiShop02_id);
		proxy:RequestForceUpdateNetwork( DoreiShop03_id);
	end
	
	--�u���b�N�̊Ď����폜
	DeleteConditionList(proxy,DoreiShopBlock1_acid_list);
	DeleteConditionList(proxy,DoreiShopBlock2_acid_list);
	DeleteConditionList(proxy,DoreiShopBlock3_acid_list);
	
	
	--��肠����������Ԃ�ݒ�
	SetFirstNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_SELL01 );
	
	
	--�z�ꕺ�m������2�Ɉړ�����
	if proxy:IsCompleteEvent( DOREISOL_SHOP_SELL01 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_SELL01");
		SetDoreiShopState01(proxy, param);
		RegistConditionBlock01(proxy,param);

	--�z�ꕺ�m������1�œG��
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE01 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_HOSTILE01");
		SetDoreiShopState02(proxy, param);
		RegistConditionBlock01(proxy,param);

	--�z�ꕺ�m�����S����
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_DEAD ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_DEAD");
		SetDoreiShopState03(proxy, param);
		RegistConditionBlock01(proxy,param);

	--�z�ꕺ�m������3�Ɉړ�����
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_SELL02 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_SELL02");
		SetDoreiShopState04(proxy, param);
		RegistConditionBlock02(proxy,param);

	--�z�ꕺ�m������2�œG�΂��Ă���
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE02 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_HOSTILE02");
		SetDoreiShopState05(proxy, param);
		RegistConditionBlock02(proxy,param);

	--�z�ꕺ�m���̔����Ă���
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_SELL03 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_SELL03");
		SetDoreiShopState06(proxy, param);
		RegistConditionBlock03(proxy,param);

	--�z�ꕺ�m������3�œG�΂��Ă���
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE03 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_HOSTILE03");
		SetDoreiShopState07(proxy, param);
		RegistConditionBlock03(proxy,param);
	end

	print("OnEvent_781 end");
end

--���z�ꕺ�m���̔����Ă���(����1)��-----------------------------------------
function SetDoreiShopState01( proxy, param )
	--�t�@�����N�X�������Ă���
	if proxy:IsCompleteEvent( 4096 ) == false then
		ValidCharactor(proxy,691);--����1�ɂ���z�ꕺ�m��L����
	
	--�t�@�����N�X������ł���
	else
		print("DoreiShop NowState DOREISOL_SHOP_SELL01 > Chenge to DOREISOL_SHOP_SELL02");
		InvalidBackRead(proxy,691);--����1�ɂ���z�ꕺ�m�𖳌���
		ValidCharactor(proxy,623);--����2�ɂ���z�ꕺ�m��L����
		
		--���W�b�NOFF�ɂ���
		proxy:EnableLogic( 623, false );
		
		--�z�ꕺ�m�̏�Ԃ��u�̔�(����2)�v�ɕς���
		SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_SELL02 );
	end
end
--��-----------------------------��-----------------------------------------


--���z�ꕺ�m���G�΂��Ă���(����1)��-------------------------
function SetDoreiShopState02( proxy, param )
	ValidCharactor(proxy,691);--����1�ɂ���z�ꕺ�m��L����
	--�z�ꕺ�m�̃`�[���^�C�v��ύX����
	proxy:SetTeamType( 691, TEAM_TYPE_AngryFriend );
end
--��-----------------------------��-------------------------


--���z�ꕺ�m�����S����(����1)��-------------------------------------
function SetDoreiShopState03( proxy, param )
	InvalidBackRead(proxy,691);--����1�ɂ���z�ꕺ�m�𖳌���
	InvalidBackRead(proxy,623);--����2�ɂ���z�ꕺ�m�𖳌���
	InvalidBackRead(proxy,679);--����3�ɂ���z�ꕺ�m�𖳌���
end
--��-------------------------��-------------------------------------


--���z�ꕺ�m���̔����Ă���(����2)��-----------------------------------------
function SetDoreiShopState04( proxy, param )
	--���̏��������Ă��� or �G���A�{�X�����j���Ă��Ă��Ȃ� or ���s�̖傪�J���Ė���
	if 	proxy:IsCompleteEvent( 4224 ) == false or
		proxy:IsCompleteEvent( 8035 ) == false or
		proxy:IsCompleteEvent( 571) == false then
		ValidCharactor(proxy,623);--����2�ɂ���z�ꕺ�m��L����
		InvalidBackRead(proxy,691);--����1�ɂ���z�ꕺ�m�𖳌���
	else
		print("DoreiShop NowState DOREISOL_SHOP_SELL02 > Chenge to DOREISOL_SHOP_SELL03");
		InvalidBackRead(proxy,691);--����1�ɂ���z�ꕺ�m�𖳌���
		InvalidBackRead(proxy,623);--����2�ɂ���z�ꕺ�m�𖳌���
		ValidCharactor(proxy,679);--����3�ɂ���z�ꕺ�m��L����
		
		--���W�b�NOFF�ɂ���
		proxy:EnableLogic( 679, false );
		
		--�z�ꕺ�m�̏�Ԃ��u�̔�(����3)�v�ɕς���
		SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_SELL03 );
	end
end
--��-----------------------------��-----------------------------------------


--���z�ꕺ�m���G�΂��Ă���(����2)��-------------------------
function SetDoreiShopState05( proxy, param )
	ValidCharactor(proxy,623);--����2�ɂ���z�ꕺ�m��L����
	InvalidBackRead(proxy,691);--����1�ɂ���z�ꕺ�m�𖳌���
	--�z�ꕺ�m�̃`�[���^�C�v��ύX����
	proxy:SetTeamType( 623, TEAM_TYPE_AngryFriend );
end
--��-----------------------------��-------------------------


--���z�ꕺ�m���̔����Ă���(����3)��-------------------------
function SetDoreiShopState06( proxy, param )
	ValidCharactor(proxy,679);--����3�ɂ���z�ꕺ�m��L����
	InvalidBackRead(proxy,691);--����1�ɂ���z�ꕺ�m�𖳌���
	InvalidBackRead(proxy,623);--����2�ɂ���z�ꕺ�m�𖳌���
end
--��-----------------------------��-------------------------


--���z�ꕺ�m���G�΂��Ă���(����3)��-------------------------
function SetDoreiShopState07( proxy, param )
	ValidCharactor(proxy,679);--����3�ɂ���z�ꕺ�m��L����
	InvalidBackRead(proxy,691);--����1�ɂ���z�ꕺ�m�𖳌���
	InvalidBackRead(proxy,623);--����2�ɂ���z�ꕺ�m�𖳌���
	--�z�ꕺ�m�̃`�[���^�C�v��ύX����
	proxy:SetTeamType( 679, TEAM_TYPE_AngryFriend );
end
--��-----------------------------��-------------------------


--���z�ꕺ�m�̏�ԑJ��(����1)��--------------------------------------------------------------------------------------
function RegistConditionBlock01(proxy, param)
	--�z�ꕺ�m������ł��Ȃ�
	if proxy:IsCompleteEvent( DOREISOL_SHOP_DEAD ) == false then
		--�z�ꕺ�m������1,2,3�̂�����ł��G�΂��Ă��Ȃ��ꍇ
		if proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE01 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE02 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE03 ) == false then
			--�z�X�g����̃_���[�W�Ď�
			--m02_00
			--proxy:OnCharacterTotalDamage( 341, 691, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_341", once );
			proxy:OnCharacterTotalRateDamage( 341, 691, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_341", once );
			--m02_01
			--proxy:OnCharacterTotalDamage( 760, 623, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_760", once );
			proxy:OnCharacterTotalRateDamage( 760, 623, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_760", once );
			--m02_02
			--proxy:OnCharacterTotalDamage( 1440, 679, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_1440", once );
			proxy:OnCharacterTotalRateDamage( 1440, 679, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1440", once );
		end
		proxy:OnCharacterDead( 342, 691, "OnEvent_342", once );
	end
end
--��------------------��--------------------------------------------------------------------------------------


--���z�ꕺ�m�̏�ԑJ��(����2)��-------------------------------------------------------------------------------
function RegistConditionBlock02(proxy, param)
	--�z�ꕺ�m������ł��Ȃ�
	if proxy:IsCompleteEvent( DOREISOL_SHOP_DEAD ) == false then
		--�z�ꕺ�m������1,2,3�̂�����ł��G�΂��Ă��Ȃ��ꍇ
		if proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE01 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE02 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE03 ) == false then
			--�z�X�g����̃_���[�W�Ď�
			--m02_00
			--proxy:OnCharacterTotalDamage( 341, 691, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_341", once );
			proxy:OnCharacterTotalRateDamage( 341, 691, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_341", once );
			--m02_01
			--proxy:OnCharacterTotalDamage( 760, 623, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_760", once );
			proxy:OnCharacterTotalRateDamage( 760, 623, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_760", once );
			--m02_02
			--proxy:OnCharacterTotalDamage( 1440, 679, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_1440", once );
			proxy:OnCharacterTotalRateDamage( 1440, 679, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1440", once );
		end
		proxy:OnCharacterDead( 761, 623, "OnEvent_761", once );
	end
end
--��------------------��--------------------------------------------------------------------------------------


--���z�ꕺ�m�̏�ԑJ��(����3)��-------------------------------------------------------------------------------
function RegistConditionBlock03(proxy, param)
	--�z�ꕺ�m������ł��Ȃ�
	if proxy:IsCompleteEvent( DOREISOL_SHOP_DEAD ) == false then
		--�z�ꕺ�m������1,2,3�̂�����ł��G�΂��Ă��Ȃ��ꍇ
		if proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE01 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE02 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE03 ) == false then
			--�z�X�g����̃_���[�W�Ď�
			--m02_00
			--proxy:OnCharacterTotalDamage( 341, 691, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_341", once );
			proxy:OnCharacterTotalRateDamage( 341, 679, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_341", once );
			--m02_01
			--proxy:OnCharacterTotalDamage( 760, 623, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_760", once );
			proxy:OnCharacterTotalRateDamage( 760, 623, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_760", once );
			--m02_02
			--proxy:OnCharacterTotalDamage( 1440, 679, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_1440", once );
			proxy:OnCharacterTotalRateDamage( 1440, 679, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1440", once );
		end
		proxy:OnCharacterDead( 1441, 679, "OnEvent_1441", once );
	end
end
--��------------------��--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--��85�����q��b�p�t���O���䁡
--------------------------------------------------------------------------------------
function OnEvent_85(proxy,param)
	print("OnEvent_85 begin");
	proxy:SetEventFlag( 85 ,true );
	print("OnEvent_85 end");
end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--��7���G���C�e���낲�끡
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegistEvent_7(proxy)
	--SingleReset( proxy, 7 );
	if	proxy:IsCompleteEvent( 7 ) == false then
		proxy:OnRegionJustIn( 7, LOCAL_PLAYER, 2006, "OnEvent_7", once );
		proxy:OnSimpleDamage( 7, 246, LOCAL_PLAYER, "OnEvent_7", once );
		proxy:EnableLogic( 246, false );
	else
		proxy:EndAnimation( 1010, 1 );
		proxy:ReconstructBreak( 1011 , 1 );
		proxy:ReconstructBreak( 1012 , 1 );
	end
end

function OnEvent_7(proxy,param)
	print("OnEvent_7 begin");
	proxy:DeleteEvent( 7 );
	proxy:PlayAnimation( 1010, 1 );
	proxy:SetObjEventCollisionFill( 1010, true );
	
	proxy:PlayAnimation( 470 , 3002 );--���m���R��
	proxy:EnableLogic( 246, true );
	
	proxy:SetEventFlag( 7, true );
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 7, "OnEvent_7_1", 0.5, 0, 2, once );
	proxy:NotNetMessage_end();
	print("OnEvent_7 end");
end

function OnEvent_7_1(proxy,param)
	print("OnEvent_7_1 begin");
	proxy:OnObjectDamageHit_NoCallPlus( 7, 1010, 1, 10210, EV_HIT_CHR, 1.0, 5.0,1.0, everytime );
	
	print("OnEvent_7_1 end");
end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--��6�����m���Ή��r�𓊂��遡
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ThrowFirePotRegist_b1(proxy)
	SingleReset(proxy, 6 );
	if	proxy:IsCompleteEvent( 6 ) == false then
		proxy:OnRegionJustIn( 6, LOCAL_PLAYER, 2005, "OnEvent_6", once );
		proxy:OnRegionJustIn( 6, LOCAL_PLAYER, 2004, "OnEvent_6", once );
		proxy:OnSimpleDamage( 6, 245, LOCAL_PLAYER, "OnEvent_6", once );
		proxy:EnableLogic( 245, false );
	end
end

function OnEvent_6(proxy,param)
	print("OnEvent_6 begin");
	proxy:DeleteEvent( 6 );
	proxy:SetEventFlag( 6, true );
	proxy:PlayAnimation( 245, 6060 );
	if param:GetParam2() == 245 then
		--��2�p�������m�̎��͉����Ă܂�
		proxy:EnableLogic( 245, true );
	else
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 6,"OnEvent_6_1",4,0,0,once);
		proxy:NotNetMessage_end();
	end
	print("OnEvent_6 end");
end

function OnEvent_6_1(proxy,param)
	print("OnEvent_6_1 begin");
	proxy:EnableLogic( 245 , true );
	print("OnEvent_6_1 end");
end

--[[
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--��100��⾉΂ɓ˂����񂾁�
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ObjDamage(proxy,objid)
	--print(objid);
	if proxy:IsReady_Obj(objid) == true then
		proxy:OnObjectDamageHit_NoCall( 100, objid,1,10300,EV_HIT_CHR,0.5,FIREDAM_WAIT,everytime);
	end
	proxy:NotNetMessage_begin();	
		proxy:OnKeyTime2( 100 , "OnEvent_100_"..objid.."_1",FIREDAM_WAIT,0,objid+10000,once);	
	proxy:NotNetMessage_end();
end

function ObjDamage_1(proxy,objid)
	if proxy:IsReady_Obj(objid) == true then
		proxy:OnObjectDamageHit_NoCall( 100, objid,1,10300,EV_HIT_CHR,0.5,FIREDAM_WAIT,everytime);
	end
	proxy:NotNetMessage_begin();	
		proxy:OnKeyTime2( 100 , "OnEvent_100_"..objid,FIREDAM_WAIT,0,objid,once);	
	proxy:NotNetMessage_end();
end

function OnEvent_100_1180(proxy,param) ObjDamage(proxy,1180); end
function OnEvent_100_1180_1(proxy,param) ObjDamage_1(proxy,1180); end
function OnEvent_100_1181(proxy,param) ObjDamage(proxy,1181); end
function OnEvent_100_1181_1(proxy,param) ObjDamage_1(proxy,1181); end
function OnEvent_100_1182(proxy,param) ObjDamage(proxy,1182); end
function OnEvent_100_1182_1(proxy,param) ObjDamage_1(proxy,1182); end
function OnEvent_100_1183(proxy,param) ObjDamage(proxy,1183); end
function OnEvent_100_1183_1(proxy,param) ObjDamage_1(proxy,1183); end
function OnEvent_100_1185(proxy,param) ObjDamage(proxy,1185); end
function OnEvent_100_1185_1(proxy,param) ObjDamage_1(proxy,1185); end
function OnEvent_100_1186(proxy,param) ObjDamage(proxy,1186); end
function OnEvent_100_1186_1(proxy,param) ObjDamage_1(proxy,1186); end
]]

-----------------------------------------------------------------------------
--���������g�J�Q�C�x���g
-----------------------------------------------------------------------------
--�{�X���j���̃g�J�Q���Z�b�g�p
function ResetTokage(proxy)
	print("ResetTokage");
	--proxy:SetEventFlag(120,false);
	--proxy:SetEventFlag(590,false);
	--proxy:SetEventFlag(592,false);
	--proxy:SetEventFlag(1090,false);
	--proxy:SetEventFlag(1680,false);	
	--proxy:SetEventFlag(1682,false);	
	--proxy:SetEventFlag(1684,false);
	AddEventCounter(proxy,0);
	AddEventCounter(proxy,1);
	AddEventCounter(proxy,2);
	AddEventCounter(proxy,3);
	AddEventCounter(proxy,4);
	AddEventCounter(proxy,5);
	AddEventCounter(proxy,6);
end

-----------------------------------------------------------------------------
--��120�������g�J�Q�C�x���g1
-----------------------------------------------------------------------------
function OnEvent_120(proxy,param)
	print("OnEvent_120 begin");
	proxy:SetEventFlag( 120, true);
	proxy:DeleteEvent( 120 );
	print("OnEvent_120 end");
end


-----------------------------------------------------------------------------
--��201�����Y��̔��𒴂���
-----------------------------------------------------------------------------
function OnEvent_201(proxy,param)
	print("OnEvent_201 begin");
	proxy:SetEventFlag(201,true);
	print("OnEvent_201 end");
end


function OnEvent_450_In(proxy,param)
	print("OnEvent_450_In begin");
	proxy:SetDrawEnable( 300,false );
	proxy:SetDrawEnable( 301,false );
	print("OnEvent_450_In end");
end

function OnEvent_450_Out(proxy,param)
	print("OnEvent_450_Out begin");
	proxy:SetDrawEnable( 300,true );
	proxy:SetDrawEnable( 301,true );
	print("OnEvent_450_Out end");
end


-----------------------------------------------------------------------------
--��8����ʕ��m�Ή��r������
-----------------------------------------------------------------------------
function OnEvent_8(proxy,param)
	if proxy:IsCompleteEvent( 8 ) == false then
		print("OnEvent_8 begin");
		proxy:SetEventFlag( 8 , true );
		proxy:EnableLogic( 247 , true );
		proxy:PlayAnimation( 247 , 6060 );
		print("OnEvent_8 end");
	end	
end

--��납��PC������
function OnEvent_9(proxy,param)
	proxy:DeleteEvent( 8 );
	proxy:EnableLogic( 247 , true );
	proxy:ResetThink( 247 );
end
