
EVENT_TIME01 = 13.0;

SMITH_WORKING = 16090;--�d�����i�ʏ�j
SMITH_ANGRY   = 16091;--�G��
SMITH_DEAD    = 16092;--���S

SMITH_Flag_list ={
	SMITH_WORKING,
	SMITH_ANGRY,
	SMITH_DEAD,	
}

TOTALDAMAGE_SMITH = 30;--���v�_���[�W

SHOP_NORMAL_1  = 16410;--�B���P�Ŕ̔���
SHOP_HOSTILE_1 = 16411;--�B���P�œG��
SHOP_DEAD	 = 16412;--���S
SHOP_NORMAL_2 = 16413;--�B���Q�Ŕ̔���
SHOP_HOSTILE_2 = 16411;--�B���Q�œG��

SHOP_Flag_list = {
	SHOP_NORMAL_1,
	SHOP_HOSTILE_1,
	SHOP_DEAD,
	SHOP_NORMAL_2,
	SHOP_HOSTILE_2,
}

SHOP_TOTALDAMAGE = 50;

FIREDOM_COUNT = 0;

FIREDOM_TIME = 0.1;
IS_FIREAREA = false;

OFFSET = -2;

--��������Ŏg����G�B
DISTENELIST = {210,211,212,213,217,219,351,352};
IWAKOUFU_DIST = 1.4;



--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉����������
--------------------------------------------------------------------------------------
function Initialize_m06_00_00_00(proxy)
	print("Initialize_m06_00_00_00 begin");
	
	proxy:LuaCall( 99999 , 0 , "OnEvent_4000_Hp_1",everytime);
	
-----------------------------------------------------------------------------------------
--�{�X�֘A
-----------------------------------------------------------------------------------------
--��111���{�X�����ɓ��遡
	
	--���{�X�������Ă���Ƃ������C�x���g�o�^
	if proxy:IsCompleteEvent( 6174 ) == false then	
	
		--�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B
		SingleReset(proxy, 111);
		SingleReset(proxy, 113);
		
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���)
		proxy:LuaCall( 112, 1, "OnEvent_112_1", everytime );
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCall( 112 , 5 , "OnEvent_111_GO_TO_IN" , everytime );
		--���t���O�Z�b�g(�����p)
		proxy:LuaCall( 112 , 6 , "OnEvent_111_flag_set" , everytime );		
		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ�
		if proxy:IsCompleteEvent( 111 ) == false then		
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l����
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;			
			proxy:NotNetMessage_begin();
				--��111�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegionAttribute( 111, 2895, "OnEvent_111", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();		
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B		
			proxy:NotNetMessage_begin();
				--��112�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegion( 112, 2895, "OnEvent_111", HELPID_GO_TO_IN, everytime );--�n���h���͏�Ɠ���
			proxy:NotNetMessage_end();		
		end
		proxy:SetColiEnableArray(3001,false);--�ʏ햳��
		proxy:SetColiEnableArray(3002,false);--�ʏ햳��
		proxy:SetColiEnableArray(3005,false);--�ʏ햳��
		proxy:SetColiEnableArray(3006,false);--�ʏ햳��
		proxy:SetColiEnableArray(3009,false);--�ʏ햳��
		proxy:SetColiEnableArray(3010,false);--�ʏ햳��		
		proxy:SetColiEnableArray(3003,true);--�{�X�p�L��
		proxy:SetColiEnableArray(3004,true);--�{�X�p�L��
		proxy:SetColiEnableArray(3007,true);--�{�X�p�L��
		proxy:SetColiEnableArray(3008,true);--�{�X�p�L��
		proxy:SetColiEnableArray(3011,true);--�{�X�p�L��
		proxy:SetColiEnableArray(3012,true);--�{�X�p�L��
	else
		proxy:SetColiEnableArray(3001,true);--�ʏ�L��
		proxy:SetColiEnableArray(3002,true);--�ʏ�L��
		proxy:SetColiEnableArray(3005,true);--�ʏ�L��
		proxy:SetColiEnableArray(3006,true);--�ʏ�L��
		proxy:SetColiEnableArray(3009,true);--�ʏ�L��
		proxy:SetColiEnableArray(3010,true);--�ʏ�L��		
		proxy:SetColiEnableArray(3003,false);--�{�X�p����
		proxy:SetColiEnableArray(3004,false);--�{�X�p����
		proxy:SetColiEnableArray(3007,false);--�{�X�p����
		proxy:SetColiEnableArray(3008,false);--�{�X�p����
		proxy:SetColiEnableArray(3011,false);--�{�X�p����
		proxy:SetColiEnableArray(3012,false);--�{�X�p����		
	end

	
--��113���{�X�퓬�J�n��	
	if proxy:IsCompleteEvent( 6174 ) == false then
		--�V���O�����[�h��������
		SingleReset( proxy , 113 );
		proxy:OnRegionJustIn( 113 , 10000 , 2887 , "OnEvent_113" , once );
	end

--��6174�����{�X���S��
	proxy:AddFieldInsFilter( 810 );
	if proxy:IsCompleteEvent( 6174 ) == false then
		proxy:OnCharacterDead( 6174 , 810 , "OnEvent_6174" , once );	
	end

--���{�X�֘A�̏���������
	if proxy:IsCompleteEvent( 6174 ) ==true then
		
		--���{�X����ł���Ƃ�
		--�{�X���Ȃ��Ȃ�
		InvalidBackRead( proxy , 810 );
		
		proxy:SetEventFlag( 6175, 1 );
		
		--���@�Ǐ�����
		proxy:SetColiEnable( 1999 , false );
		proxy:SetColiEnable( 1995 , false );
	
		proxy:SetDrawEnable( 1999 , false );
		proxy:SetDrawEnable( 1995 , false );

		--���@�ǂ� SFX OFF
		proxy:InvalidSfx( 1987 , false );
		proxy:InvalidSfx( 1991 , false );

		--�z�X�g�v���C���[�̂݃A�C�e������C�x���g�Ɏg�p
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--�󎀑�(�\�E��?)�L����
		proxy:SetDrawEnable( 1982 , true );
		proxy:SetColiEnable( 1982 , true );
		--�󎀑�(�\�E��?)2�L����
		proxy:SetDrawEnable( 1975 , true );
		proxy:SetColiEnable( 1975 , true );
		
		proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);--���点��
		--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
		if proxy:IsCompleteEvent( 6193 ) == false then
			--SFXON
			proxy:ValidSfx( 2131 );--���̗��q
			proxy:ValidSfx( 2132 );--�v�΂̃I�[��
			proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);--���点��
			proxy:OnDistanceActionAttribute( 6193 , 10000 , 1982 , "OnEvent_6193" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--SFX��������
			proxy:InvalidSfx( 2131 , false );--���̗��q
			--proxy:InvalidSfx( 2132 , false );--�v�΂̃I�[��
			--���v�΂Ń��[�v�p�̊Ď���ǉ���
			SingleReset(proxy,6194);
			proxy:OnDistanceActionAttribute( 6194 , 10000 , 1982 , "OnEvent_6194" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
		
	else
		--���{�X�����Ă���Ƃ�
		
		proxy:EnableLogic( 810 , false );--���W�b�NOFF�őҋ@
		
		--��(�\�E��?)
		proxy:SetDrawEnable( 1982 , false );
		proxy:SetColiEnable( 1982 , false );
		--��(�\�E��?)2
		proxy:SetDrawEnable( 1975 , false );
		proxy:SetColiEnable( 1975 , false );
		
		--SFX��������
		proxy:InvalidSfx( 2131 , false );--���̗��q
		proxy:InvalidSfx( 2132 , false );--�v�΂̃I�[��
	end	

-----------------------------------------------------------------------------------------
--�M�~�b�N�֘A
-----------------------------------------------------------------------------------------
--��0�����o�[�Ŕ����J�����遡
	if proxy:IsCompleteEvent(0) ==false then
	
		--���J���z�M�p
		proxy:LuaCall(0,1,"OnEvent_0_3_Net",once);				
		--�|�����z�M�p
		proxy:LuaCall(0,2,"OnEvent_0_4_Net",once);

		proxy:NotNetMessage_begin();
			--�|�����J�n�t�F�[�h��ɌĂ΂��n���h��
			proxy:LuaCall(0,REMO_START,"OnEvent_0_RemoStart",once);
			--�|�����I����ɌĂ΂��n���h��
			proxy:LuaCall(0,REMO_FINISH,"OnEvent_0_RemoFinish",once);
		proxy:NotNetMessage_end();

		proxy:OnDistanceActionPlus( 0, 10000, 1000, "OnEvent_0", LeverDist_A, HELPID_PULL_LEVER, -90.0, LeverAngle_A, 1.8, 0.0, -0.6, once );
	else
		proxy:EndAnimation( 1000, 1);--���o�[�A�j��
		proxy:EndAnimation( 1001, 1);--���A�j��
		proxy:PlayAnimation( 1010 , 1 );--���Ԃ������A�j���Đ�
		proxy:PlayPointSE( 2014, SOUND_TYPE_O, 606150, 7 );--�g���b�RSE�Đ�
	end
	
--��10���n���h��A���񂵂Ď��Ԃ𓮂�����
	proxy:SetIsAnimPauseOnRemoPlayForEvent(1003,true);
	if proxy:IsCompleteEvent(10) == false 		--�܂��n���h�����񂵂Ă��Ȃ��@����
	and proxy:IsCompleteEvent(13) == false then	--�����Е��̃n���h���ŃS���h��������Ă��Ȃ��@�Ȃ��
		--��PC��OBJ(1002)�ɑ΂��Ĕ����p�x(30)�A�p�x�I�t�Z�b�g(-90)�A����(150)�ŃA�N�V�����{�^����������--
		proxy:OnDistanceAction( 10, 10000, 1002, "OnEvent_10", HandleDist_A, HELPID_TURN_HANDLE, -90.0, HandleAngle_A, once );
	else
		proxy:EndAnimation( 1002, 1);--�n���h���A�j��
	end
--��12���n���h��A_2���񂵂Ď��Ԃ𓮂�����
	if proxy:IsCompleteEvent(12) == false 		--�܂��n���h�����񂵂Ă��Ȃ��@����
	and proxy:IsCompleteEvent(11) == false then	--�����Е��̃n���h���ŃS���h��������Ă��Ȃ��@�Ȃ��
		--��PC��OBJ(1026)�ɑ΂��Ĕ����p�x(30)�A�p�x�I�t�Z�b�g(-90)�A����(150)�ŃA�N�V�����{�^����������--
		proxy:OnDistanceAction( 12, 10000, 1026, "OnEvent_12", HandleDist_A, HELPID_TURN_HANDLE, -90.0, HandleAngle_A, once );
	else
		proxy:EndAnimation( 1026, 1);--�n���h���A�j��
	end
--��11,13���n���h�����������̏�������
	if proxy:IsCompleteEvent(11) == true 		--A�̂����ŃS���h��������Ă���@��
	or proxy:IsCompleteEvent(13) == true then	--A_2�̂����ŃS���h��������Ă���@�Ȃ��
		--���łɃS���h���������Ă���̂ŁA������
		print("���łɃS���h���͍쓮�ς݁I");
		proxy:PlayAnimation( 1003, 1 );	--���ԃA�j���Đ�
		--proxy:EndAnimation( 1003, 1);--���ԃA�j��
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnObjAnimEndPlus(24 , 1003 , 1 , "OnEvent_24",once );
			proxy:NotNetMessage_end();
		end
		proxy:PlayPointSE( 2011, SOUND_TYPE_O, 606130, 4 );--�S���h��SE�Đ�
	end
	--�����̃A�j���z�M
	proxy:LuaCall( 24 , 0 , "OnEvent_24_call",everytime);	
	
		
--��20���n���h��B���񂵂Ď��Ԃ𓮂�����
	if proxy:IsCompleteEvent(20) ==false then
		
		--�|�����z�M�p
		proxy:LuaCall(22,0,"OnEvent_22",once);
		proxy:NotNetMessage_begin();
			--�|�����J�n�t�F�[�h��ɌĂ΂��n���h��
			proxy:LuaCall(20,REMO_START,"OnEvent_20_RemoStart",once);
			--�|�����I����ɌĂ΂��n���h��
			proxy:LuaCall(20,REMO_FINISH,"OnEvent_20_RemoFinish",once);	
		proxy:NotNetMessage_end();
		proxy:OnDistanceAction( 20, 10000, 1004, "OnEvent_20", HandleDist_B, HELPID_TURN_HANDLE, -90.0, HandleAngle_B, once );
		proxy:OnRegionJustIn(128,10000,2026,"OnEvent_128",everytime);
		proxy:OnRegionJustOut(133,10000,2026,"OnEvent_133",everytime);

		local enemylist = {	200,201,202,203,204,205,206,207,208,209,
							210,211,212,213,214,215,216,217,218,219,
							220,221,222,
							350,351,352,
							396};
		local num = table.getn( enemylist );
		for index = 1 , num , 1 do
			proxy:OnRegionJustIn(50,enemylist[index],2026,"OnEvent_50",everytime);--param2�ŃL�����𔻒�
			proxy:OnRegionJustOut(51,enemylist[index],2026,"OnEvent_51",everytime);--param2�ŃL�����𔻒�
		end
		--proxy:PlayAnimation( 1005, 0 );--���ԃA�j�������[�v�Đ�
		proxy:PlayLoopAnimation( 1009, 2 );--����(?)�A�j�������[�v�Đ�	
	else
		proxy:EndAnimation( 1005 , 1 );--���ԃA�j���Đ�
		proxy:EndAnimation( 1004, 1);--�n���h���A�j���I��
		proxy:SetDrawEnable( 1030, false );
		proxy:SetColiEnable( 1008, false );--�����I�u�W�F�̓����������		
	end

	--OBJ�����ւ������p
	if proxy:IsCompleteEvent(146) == false then
		--��p�⏰OFF
		proxy:SetColiEnable(1032,false);
		proxy:SetDrawEnable(1032,false);		
	else
		--�}�O�}��OFF
		proxy:SetColiEnable(1031,false);
		proxy:SetDrawEnable(1031,false);
		proxy:SetColiEnableArray( 1033 , false );
		proxy:InvalidSfx( 2015 , false );
		proxy:InvalidSfx( 2046 ,false );
	end
	
	--SFX�؂�ւ�
	if proxy:IsCompleteEvent(147) == false then
		proxy:InvalidSfx(2043,false);		
	end
	
	--SFX�؂�ւ�
	if proxy:IsCompleteEvent(148) == false then
		proxy:InvalidSfx(2044,false);
	end
	
	--SE�Đ�
	if proxy:IsCompleteEvent(149) == false then
		proxy:PlayPointSE( 2045, SOUND_TYPE_A, 601000, 5 );
	else
		proxy:StopPointSE( 5 );
	end
	
--��60���n�V�SA�~�聡PC���C�x���g�G���A(2005)�̒��ɋ��āA�A�N�V�����{�^�����������Ƃ�--
	--proxy:OnActionEventRegion(60, 2005, "OnEvent_60", LadderAngle_A, HELPID_DOWN, everytime);
--��61���n�V�SA���聡PC���C�x���g�G���A(2004)�̒��ɋ��āA�A�N�V�����{�^�����������Ƃ�--
	--proxy:OnActionEventRegion(61, 2004, "OnEvent_61", LadderAngle_A, HELPID_UP  , everytime);

--[[�g�p���Ȃ��Ȃ����̂ŃR�����g�A�E�g(�������邩������Ȃ�)

--��70�����o�[�ŉ��̃n���h�����񂹂�悤�ɂ��遡 (����̓��o�[�̂�?)
	if proxy:IsCompleteEvent( 70 ) ==false then
	--��PC���C�x���g�G���A(1015)�̒��ɋ���(1.5m)�L���p(30�x��)�ŃA�N�V�����{�^����������
		proxy:OnDistanceAction( 70, 10000, 1015, "OnEvent_70", LeverDist_A, HELPID_PULL_LEVER, 0, LeverAngle_A, once);
	else
	   proxy:EndAnimation( 1015, 1 );--���o�[�������A�j��
	end
]]

--��6176�����u���b�N�ւ̈ړ��|����(�C�x���g70����A��)��
	--�C�x���g70���Ŕ��s�����
	
--��80���n���h���Ŏ��Ԃ��񂵂ċ[���G���x�[�^�[�ɂ��遡
	proxy:SetIsAnimPauseOnRemoPlayForEvent(1019,true);
	if proxy:IsCompleteEvent(80) ==false then
	--��PC��OBJ(1016)�ɑ΂��Ĕ����p�x(30)�A�p�x�I�t�Z�b�g(-90)�A����(150)�ŃA�N�V�����{�^����������--
		proxy:OnDistanceAction( 80, 10000, 1016, "OnEvent_80", HandleDist_A, HELPID_TURN_HANDLE, -90.0, HandleAngle_A, once );
		proxy:LuaCall( 80 , 1 , "OnEvent_80_2",once);
	else
		proxy:EndAnimation( 1016, 1);--�n���h���A�j��
		--proxy:EndAnimation( 1019, 1);--���ԃA�j��
		proxy:PlayAnimation( 1019, 1 );	--���ԃA�j���Đ�
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnObjAnimEndPlus(14 , 1019 , 1 , "OnEvent_14",once );
			proxy:NotNetMessage_end();
		end		
		proxy:PlayPointSE( 2012, SOUND_TYPE_O, 606130, 6 );
	end	
	--�����̃A�j���z�M	
	proxy:LuaCall( 14, 0 , "OnEvent_14_call",everytime);
	
--[[�g�p���Ȃ��Ȃ����̂ŃR�����g�A�E�g(�������邩������Ȃ�)

--��90���b�艮��̔�(���o�[�Ŕ����J������)��
	if proxy:IsCompleteEvent(90) ==false then
	--��PC��OBJ(1000)�ɑ΂��Ĕ����p�x(30)�A�p�x�I�t�Z�b�g(-90)�A����(150)�ŃA�N�V�����{�^����������--
		proxy:OnDistanceActionPlus( 90, 10000, 1022, "OnEvent_90", LeverDist_A, HELPID_PULL_LEVER, 0.0, LeverAngle_A, 0.0, 0.0, 0.0, once );
	else
		proxy:EndAnimation( 1022, 1);--���o�[�A�j��
		proxy:EndAnimation( 1021, 1);--���A�j��
	end	
]]
	
--��150���Β��Ƀ��[�v��
	SingleReset(proxy,150);
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	proxy:OnDistanceAction( 150, 10000, 1983, "OnEvent_150", WarpGimmickDist_A, HELPID_GO_TO_SEKITYUU, 0, 180, everytime );
	
--��151���ŏ��̗v�΂̌��������遡
		proxy:OnSessionJustIn( 151 , "OnEvent_151" , everytime );
		
--��152���ŏ��̗v�΂̌����������遡
		proxy:OnSessionJustOut( 152 , "OnEvent_152" , everytime );
	
--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m06_00_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m06_00_00_00", everytime );
	proxy:NotNetMessage_end();
	
	
--��70���n���h���񂵂ăt���A�ړ����遡
	proxy:SetIsAnimPauseOnRemoPlayForEvent(1023,true);
	proxy:OnPlayerActionInRegionAngle(70,2025,"OnEvent_70",30,HELPID_TURN_HANDLE,everytime);
	--�t���O�����p
	proxy:LuaCall(70,1,"OnEvent_70_flag",everytime);
	--72��ON���G���x�[�^�[�͉�
	--PT��130,132�Ɋւ��Ă͂Ƃ肠���������ɂ܂�����
	if proxy:IsCompleteEvent(72) == true then
		proxy:EndAnimation(1023,1);
		if proxy:IsClient() == false then		
			proxy:SetEventFlag(130,false);
			proxy:SetEventFlag(132,true);		
		end
	else
		if proxy:IsClient() == false then
			proxy:SetEventFlag(130,true);
			proxy:SetEventFlag(132,false);		
		end
	end
	
--��129���G���x�[�^�[���Ăԃn���h����
	proxy:OnDistanceAction(129,10000,1024,"OnEvent_129",1.5,HELPID_TURN_HANDLE,270,30,everytime);
--��131���G���x�[�^�[���Ăԃn���h����
	proxy:OnDistanceAction(131,10000,1025,"OnEvent_131",1.5,HELPID_TURN_HANDLE,270,30,everytime);
	
--[[Second_Initialize�͔p�~���ꂽ�̂ŃR�����g�A�E�g
	--���������^�C�~���O��
	proxy:NotNetMessage_begin();
		--��0�b�づ--
		proxy:OnKeyTime2( 999990, "Second_Initialize_m06_00_00_00", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("Initialize_m06_00_00_00 end");
end
--Second_Initialize�́A�p�~
--function Second_Initialize_m06_00_00_00(proxy, param )]]

--��124���p�j�S�[�X�g�ڌ���
	--���o�[�C�x���g�I����ĂȂ�	
	if proxy:IsCompleteEvent(127) == false then
		proxy:NotNetMessage_begin();
			--�񓯊��ȃC�x���g�ׁ̈A�t���O�͊e��OFF�ɂ��Ă��炤
			proxy:SetEventFlag(124,false);
			--InvalidCharactor(proxy,664);						
			proxy:OnRegionIn(124,10000,2022,"OnEvent_124",everytime);
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2(124,"OnEvent_124_Init",2,0,20,once);
			proxy:NotNetMessage_end();
		proxy:NotNetMessage_end();
	else
		InvalidCharactor(proxy,664);
		proxy:SetIgnoreHit(664,true);
		proxy:SetDisableGravity(664,true);
	end

--��121�����̖��P��
	if proxy:IsCompleteEvent( 121 ) == false then
		proxy:OnDistanceActionAttribute( 121, 10000, 1111, "OnEvent_121", 1.5 , HELPID_GO_TO_IN , 180.0, 90.0 , ATTR_HOST + ATTR_LIVE + ATTR_GREY,everytime);				
		proxy:LuaCall(121,1,"OnEvent_121_delete_wall",once);
	else
		proxy:SetDrawEnable( 1111, false );--�`��OFF
		proxy:SetColiEnable( 1111, false );--������OFF
		--�����̍Č��Ȃ̂Ŏ��R�ȕ\���̕K�v�������ׁARootErase�w��ł͂Ȃ�
		proxy:InvalidSfx( 2040, false );		
	end
	
--��122�����̖��Q��
	if proxy:IsCompleteEvent( 122 ) == false then
		proxy:OnDistanceActionAttribute( 122, 10000, 1112, "OnEvent_122", 1.5 , HELPID_GO_TO_IN , 180.0, 90.0 , ATTR_HOST + ATTR_LIVE + ATTR_GREY,everytime);				
		proxy:LuaCall(122,1,"OnEvent_122_delete_wall",once);
	else
		proxy:SetDrawEnable( 1112, false );--�`��OFF
		proxy:SetColiEnable( 1112, false );--������OFF
		--�����̍Č��Ȃ̂Ŏ��R�ȕ\���̕K�v�������ׁARootErase�w��ł͂Ȃ�
		proxy:InvalidSfx( 2041, false );
	end

--��123�����̖��R��
	if proxy:IsCompleteEvent( 123 ) == false then
		proxy:OnDistanceActionAttribute( 123, 10000, 1113, "OnEvent_123", 1.5 , HELPID_GO_TO_IN , 180.0, 90.0 , ATTR_HOST + ATTR_LIVE + ATTR_GREY,everytime);				
		proxy:LuaCall(123,1,"OnEvent_123_delete_wall",once);
	else
		proxy:SetDrawEnable( 1113, false );--�`��OFF
		proxy:SetColiEnable( 1113, false );--������OFF
		--�����̍Č��Ȃ̂Ŏ��R�ȕ\���̕K�v�������ׁARootErase�w��ł͂Ȃ�
		proxy:InvalidSfx( 2042, false );
	end
	
--��114���{�X��J�����Ή���
	--�{�X�������Ă���Ȃ�o�^
	if proxy:IsCompleteEvent(6174) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 114 , 10000 , 2887 ,"OnEvent_114" , everytime );
		proxy:NotNetMessage_end();
	end
	
	--����e�X�g
--~ 	COUNT=0;
--~ 	proxy:OnKeyTime2( 8000 , "test",0.1,0,COUNT,once);
	
--��8088���B���֗����t���O�𗧂Ă遡
	proxy:SetEventFlag( 8088, true );

-----------------------------------------------------------------------------------------
--NPC�֘A
-----------------------------------------------------------------------------------------
--[[
	proxy:NotNetMessage_begin();
--��30��NPC(�q���g)�Ɖ�b���s����--��ValueBuffer�@20086�g�p
	--��PC���L�����N�^()�Ɖ�b
		OnTalk(proxy,30,600,TalkDist_N,TalkAngle_N,20086,HELPID_TALK,"OnEvent_30","OnEvent_30_1","OnEvent_30_2",everytime);
	--���L�����N�^(600)��HP��(0)�p�[�Z���g�ȉ��ɂȂ�������--
		proxy:OnCharacterHP( 30, 600, "OnEvent_30_4", 0.0, once );
	--���L�����N�^(600)�����ɁA���S�A�j���[�V�������Đ����I���������--
		proxy:OnCharacterDead( 30, 600, "OnEvent_30_5", once );
	
--��40��NPC(���b��)�Ɖ�b���s����--��ValueBuffer	20087�g�p
	--��PC���L�����N�^(651)	�Ɖ�b
		OnTalk(proxy,40,651,TalkDist_N,TalkAngle_N,20087,HELPID_TALK_SWO,"OnEvent_40","OnEvent_40_1","OnEvent_40_2",everytime);
	--���L�����N�^(651)��HP��(0)�p�[�Z���g�ȉ��ɂȂ�������--
		proxy:OnCharacterHP( 40, 651, "OnEvent_40_4", 0.0, once );
	--���L�����N�^(651)�����ɁA���S�A�j���[�V�������Đ����I���������--
		proxy:OnCharacterDead( 40, 651, "OnEvent_40_5", once );
	proxy:NotNetMessage_end();
	
	--NPC(�q���g)�̏������I����Ă�����
	if proxy:IsCompleteEvent( 30 ) ==true then
		proxy:PlayAnimation( 600, 2210 );	--���[�v�A�j���[�V�����Đ�
		proxy:EnableLogic(600,false);			--(���s�l�ő�p���Ă邽��?)���W�b�NOFF
		proxy:SetColiEnable( 600, false );		--�������������
		proxy:LoadChrPos( 600, 0 );				--���W��ς���B
	end
	--NPC(���b��)�̏������I����Ă�����
	if proxy:IsCompleteEvent( 40 ) ==true then
		proxy:PlayAnimation( 651, 2210 );	--���[�v�A�j���[�V�����Đ�
		proxy:EnableLogic(651,false);			--(���s�l�ő�p���Ă邽��?)���W�b�NOFF
		proxy:SetColiEnable( 651, false );		--�������������
		proxy:LoadChrPos( 651, 1 );				--���W��ς���B
	end
	
	--(���s�l�ő�p���Ă邽��?)�ǂݍ��񂾎��_�Ń��W�b�NOFF
	--proxy:EnableLogic(600,false);	--NPC(�q���g)�������͂���Ȃ�(?)
	proxy:EnableLogic(651,false);	--NPC(���b��)			
]]
	
--���b�艮NPC�֘A�̏�������
	--�t���O������NPC��Ԃ�������
	SetFirstNpcStateFlag( proxy, param, SMITH_Flag_list, SMITH_WORKING )

	--���S���Ă��Ȃ��Ƃ�
	if proxy:IsCompleteEvent( SMITH_DEAD ) == false then
		proxy:NotNetMessage_begin();
			--�ԔM�̃f�����Y�\�E����n���C�x���g�o�^
			proxy:LuaCall(180,0,"OnEvent_180",once);
		proxy:NotNetMessage_end();
		
		if proxy:IsCompleteEvent( SMITH_ANGRY ) == false then--�G�΂��Ă��Ȃ��Ƃ�
			--��142���y�b�艮NPC�zNPC���G�ɂȂ��ĂȂ���
			if proxy:IsCompleteEvent( 142 ) == false then
				proxy:OnCharacterTotalRateDamage( 142, 660, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_142", once );--�G�ΊĎ��ǉ�
			end			
		else--�G�΂��Ă���
			proxy:EnableLogic(660, true);
			proxy:SetTeamType( 660, TEAM_TYPE_AngryFriend );
			--SetNpcStateFlag(proxy,param,SMITH_Flag_list,SMITH_ANGRY);
		end
		--��143���y�b�艮NPC�zNPC�����񂾁�
		if proxy:IsCompleteEvent( 143 ) == false then
			proxy:OnCharacterDead( 143, 660, "OnEvent_143", once );		
		end
	else
		print("�b�艮NPC���S");
		--����ł���̂Ŗ�����		
		proxy:ForceUpdateNextFrame(660);
		InvalidBackRead(proxy, 660 );		
	end		

--[[��163����HNPC���S��Ԃ̏�������
	if proxy:IsCompleteEvent( 163 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 163 , 0 , "OnEvent_163" , once );
		proxy:NotNetMessage_end();
	end
]]	


--����HNPC�֘A�̏�������
	--��H���G�΂��Ă���
	if proxy:IsCompleteEvent( 160 ) == true and proxy:IsCompleteEvent( 161 ) == false then
		proxy:EnableLogic( 663 , true );
		SetNpcStateFlag(proxy,param,SHOP_Flag_list,SHOP_HOSTILE_1);
		proxy:SetTeamType( 663, TEAM_TYPE_AngryFriend );
		proxy:SetEventFlag( 162, true );
	end

	--��H�����S���Ă���̂ŏ�����
	if proxy:IsCompleteEvent( 161 ) == true then
		proxy:EnableLogic( 663 , false );
		InvalidBackRead(proxy, 663);
		SetNpcStateFlag(proxy,param,SHOP_Flag_list,SHOP_DEAD);
		proxy:SetEventFlag( 163, true );
	end
	
	--�z�X�gor�V���O��
	if proxy:IsClient() == false then
		proxy:NotNetMessage_begin();
			--��162���X�^�[�g�n�_�̃`�F�b�N�|�C���g��
			proxy:OnRegionJustIn( 162 , 10000 , 2140 , "OnEvent_162",everytime);
			--��163����w偂̕����̃`�F�b�N�|�C���g��
			proxy:OnRegionJustIn( 163 , 10000 , 2141 , "OnEvent_163",everytime);
			--��165���h���S���f�[�����̕����̃`�F�b�N�|�C���g��
			proxy:OnRegionJustIn( 165 , 10000 , 2270 , "OnEvent_165",everytime);
		proxy:NotNetMessage_end();
	end
	--��164���`�F�b�N�|�C���g�z�M�p��
	proxy:LuaCall( 164 , 1 , "OnEvent_164" , everytime);


	--�ÍԎ��l��ԕω��l�ߍ��킹
	OnEvent_164(proxy,param);
	
--------------------------------������QWC�C�x���g�֘A������--------------------------------
--��170��QWC�z�΂̐���o����
	if proxy:IsCompleteEvent(171) == true or	--�܂��z�΂̐��삪���S���Ă���@��
	   proxy:IsSuccessQWC(60110) == false then	--QWC���������Ă��Ȃ����
		print("QWC�z�΂̐���@������");
		--�z�΂̐���𖳌���
		InvalidBackRead(proxy, 346);
		
		proxy:SetEventFlag(170, true);
	else
		print("QWC�z�΂̐���@����");
	end

--��171��QWC�z�΂̐��쎀�S�Ď���
	if proxy:IsCompleteEvent(171) == false then	--�܂��z�΂̐��삪���S���ĂȂ��Ȃ�
	   --�z�΂̐���̎��S�Ď��ǉ�
		proxy:OnCharacterDead( 171, 346, "OnEvent_171", once );
		if proxy:IsClient() == false and proxy:IsCompleteEvent(8020) == false then
			proxy:NotNetMessage_begin();
				proxy:AddCorpseEvent( 8020 , 346 );
				proxy:LuaCall( 8020 , 0 , "OnEvent_8020",once);
			proxy:NotNetMessage_end();
		end
	end


--��176��QWC�\�E�������X�^�[��
	if proxy:IsSuccessQWC(60100) == false then--�������Ă��Ȃ��Ȃ��
		print("�u���b�N�S�[�X�g������");
		--350�𖳌���
		InvalidCharactor(proxy, 350);
		--351�𖳌���
		InvalidCharactor(proxy, 351);
		--352�𖳌���
		InvalidCharactor(proxy, 352);
		--353�𖳌���
		InvalidCharactor(proxy, 353);
		
		proxy:SetEventFlag(176, true);
	end
--------------------------------������QWC�C�x���g�֘A������--------------------------------	

--��190�`�H�H�H���}�O�}�����������C�x���g��
	local yamori_Idlist = {370,373,374,375,376,380,381,382,383,384,385};
	local region_Idlist = {2150,2151,2151,2151,2151,2152,2152,2152,2152,2153,2153};
	local action_Idlist = {190,193,194,195,196,200,201,202,203,204,205};
	local num = table.getn( yamori_Idlist );
	
	for index=1 , num , 1 do
		--�\�����̓��s�[�g
		SingleReset( proxy, action_Idlist[index] );
		if proxy:IsCompleteEvent( action_Idlist[index] ) == false then
			print("Regist YamoriEvent id:",yamori_Idlist[index] );
			--[[
			OnEvent_190�AOnEvent_191�AOnEvent_192			
			]]
			proxy:OnRegionIn( action_Idlist[index],10000,region_Idlist[index],"OnEvent_"..action_Idlist[index],once);
			proxy:OnSimpleDamage( action_Idlist[index],yamori_Idlist[index],10000,"OnEvent_"..action_Idlist[index].."_Dam",once);
		else
			print("Complete YamoriEvent id:",yamori_Idlist[index] );
			proxy:SetSpStayAndDamageAnimId( yamori_Idlist[index] , -1,-1);
		end
	end
	
	--��210���E���R�z�v�̊◎�Ƃ���
	SingleReset( proxy,210 );
	if proxy:IsCompleteEvent( 210 ) == false then
		--�̈�Ď�
		proxy:OnRegionIn( 210 , 10000 , 2155 , "OnEvent_210" , once );		
	else
		--���΃C�x���g�I����ԂōČ�
		proxy:ReconstructBreak( 1125 , 1);
		proxy:ReconstructBreak( 1126 , 1);
		--proxy:ReconstructBreak( 1127 , 1);
	end
	
	--��185,186��������яo���Ă��遡
	if proxy:IsCompleteEvent(185) == false then
		proxy:OnRegionIn( 185 , 10000 , 2154 , "OnEvent_185",once);	
		proxy:OnObjectDestroy( 186 , 1120 , "OnEvent_186",once);
		proxy:EnableLogic( 390 , false );
		proxy:EnableLogic( 392 , false );
		proxy:EnableLogic( 393 , false );
	else
		--OBJ�����ɉ󂵂���Ԃɂ���
		proxy:ReconstructBreak( 1120 ,1);
	end	
	
	--��187������鋴��
	if proxy:IsCompleteEvent( 187 ) == false then
		proxy:OnRegionIn( 187,10000,2156,"OnEvent_187",once);		
	else
		proxy:ReconstructBreak( 1121 , 1);
	end
	
	--��189������鋴�Q��
	SingleReset( proxy, 189 );
	if proxy:IsCompleteEvent( 189 ) == false then
		proxy:OnRegionIn( 189,10000,2169,"OnEvent_189",once);
	else
		proxy:EndAnimation( 1123 , 1);
	end
	
	
	--[[
	--��188���݂邳�ꂽ���́�
	if proxy:IsCompleteEvent( 188 ) == false then
		proxy:OnObjectDestroy( 188 , 1122 , "OnEvent_188",once);
		--�󖳌�����SecondInit
	end
	]]
	
	--��220�`225���^�����e��
	local action_Idlist = 	{220	,221	,222	,223	,224	,225	,226	,227	,228	,229	,233	,234	,235	,236	,237	,238	,239	,240	,
							 241	,242	,243	,244	,245	,246	,247	,248	,250	,251	,252	,253};
	local taru_Idlist = 	{1130	,1131	,1132	,1133	,1134	,1135	,1136	,1137	,1138	,1139	,1140	,1141	,1142	,1143	,1144	,1145	,1146	,1147	,
							 1148	,1149	,1150	,1151	,1152	,1153	,1154	,1155	,1156	,1157	,1158	,1159};
	local num = table.getn( action_Idlist );
	
	--InvalidCharactor( proxy , 400 );
	--���d�́A������Ȃ��A�`�悳��Ȃ��A��ɓǂݍ��ށA��ɍX�V����
	CreateBulletOwner( proxy ,400 );
	CreateBulletOwner( proxy ,410 );
	
	for index =1 , num , 1 do		
		SingleReset( proxy, action_Idlist[index] );		
		if proxy:IsCompleteEvent( action_Idlist[index] ) == false then
			proxy:OnFireDamage( action_Idlist[index] , taru_Idlist[index]  , -1 , "OnEvent_"..action_Idlist[index] , once);
			--proxy:OnObjectDestroy( action_Idlist[index] , taru_Idlist[index] , "OnEvent_"..action_Idlist[index] , once );
		else
			proxy:ReconstructBreak( taru_Idlist[index] , 1);
		end
	end
	
	--��230�����낱�z�v�U����
	SingleReset( proxy , 230 );
	if proxy:IsCompleteEvent( 230 ) == false then
		proxy:EnableLogic( 394 , false );
		proxy:OnRegionIn( 230 , 10000 , 2157 , "OnEvent_230",once);
	end
	
	--��231�����낱�z�v�U����
	SingleReset( proxy , 231 );
	if proxy:IsCompleteEvent( 231 ) == false then
		proxy:EnableLogic( 395 , false );
		proxy:OnRegionIn( 231 , 10000 , 2158 , "OnEvent_231",once);
	end
	
	--��232�����낱�z�v�U����
	SingleReset( proxy , 232 );
	if proxy:IsCompleteEvent( 232 ) == false then
		proxy:EnableLogic( 396 , false );
		proxy:OnRegionIn( 232 , 10000 , 2159 , "OnEvent_232",once);
	end
	
	--��249�����������@�������Ă��遡
	SingleReset( proxy, 249 );
	if proxy:IsCompleteEvent( 249 ) == false then
		proxy:OnRegionIn( 249 , 10000 , 2170, "OnEvent_249",once );
	end
	
	RegistTokage(proxy,260,240,18);
	RegistTokage(proxy,262,241,19);
	RegistTokage(proxy,750,242,20);
	RegistTokage(proxy,752,243,21);
	RegistTokage(proxy,754,244,22);
	RegistTokage(proxy,756,245,23);
	RegistTokage(proxy,758,246,24);
	RegistTokage(proxy,760,247,25);
	RegistTokage(proxy,762,248,26);
	RegistTokage(proxy,764,249,27);
	RegistTokage(proxy,766,250,28);
	RegistTokage(proxy,768,251,29);
	RegistTokage(proxy,770,252,30);
	RegistTokage(proxy,772,253,31);
	RegistTokage(proxy,774,254,32);
	RegistTokage(proxy,776,255,33);
	RegistTokage(proxy,778,256,34);
	RegistTokage(proxy,780,257,35);
	RegistTokage(proxy,782,321,36);
	RegistTokage(proxy,784,322,37);
	RegistTokage(proxy,786,416,38);
	RegistTokage(proxy,788,417,39);
	RegistTokage(proxy,1200,258,40);
	RegistTokage(proxy,1202,259,41);
	
	
	local eneIdlist 	= {201	,431	,432	,433	,434	,204	,436	,437	};
	local deadIdlist 	= {280	,282	,284	,286	,288	,290	,292	,294	};
	local initidlist	= {281	,283	,285	,287	,289	,291	,293	,295	};
	local corpseIdlist	= {15700,15701	,15702	,15703	,15704	,15705	,15706	,15707	};
	local num = table.getn(eneIdlist);
	for index=1,num, 1 do
		Regist_FukuroKoufu(proxy,eneIdlist[ index ],deadIdlist[ index ],corpseIdlist[ index ],initidlist[ index ]);
	end
	
	
	--DISTENELIST = {210,211,212,213,217,219,351,352};�O���[�o����`
	--IWAKOUFU_DIST = 1.4;							;�O���[�o����`
	local actlist = {300,301,302,303,304,305,306,307};
	local num = table.getn( DISTENELIST );
	proxy:NotNetMessage_begin();
	for index = 1, num , 1 do
		proxy:OnPlayerDistanceOut( actlist[index] , 216 , DISTENELIST[index] , "OnEvent_"..actlist[index].."_Out" , IWAKOUFU_DIST , everytime );
		proxy:OnDistanceJustIn( actlist[index] , 216 , DISTENELIST[index] , "OnEvent_"..actlist[index].."_In", IWAKOUFU_DIST , everytime );		
		proxy:OnCharacterDead( actlist[index] , DISTENELIST[index] , "OnEvent_"..actlist[index].."_Dead" , once );
	end
	proxy:NotNetMessage_end();
	
	--DISTENELIST = {210,211,212,213,217,219,351,352};�O���[�o����`
	--IWAKOUFU_DIST = 1.4;							;�O���[�o����`
	local actlist = {308,309,310,311,312,313,314,315};
	local num = table.getn( DISTENELIST );
	proxy:NotNetMessage_begin();
	for index = 1, num , 1 do
		proxy:OnPlayerDistanceOut( actlist[index] , 218 , DISTENELIST[index] , "OnEvent_"..actlist[index].."_Out" , IWAKOUFU_DIST , everytime );
		proxy:OnDistanceJustIn( actlist[index] , 218 , DISTENELIST[index] , "OnEvent_"..actlist[index].."_In", IWAKOUFU_DIST , everytime );		
		proxy:OnCharacterDead( actlist[index] , DISTENELIST[index] , "OnEvent_"..actlist[index].."_Dead" , once );
	end
	proxy:NotNetMessage_end();
	
	
	--��999999���t���[���x��̏����������C�x���g�𔭍s��
	proxy:NotNetMessage_begin();
		--��0�b�づ--
		proxy:OnKeyTime2( 999990, "Second_Initialize_m06_00_00_00", 0.2, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	if proxy:IsDbgReLoad() == true then
		proxy:OnKeyTime2( 4021,"OnEvent_DbgReLoad",1.0,0,0,once);
	end
	print("Initialize_m06_00_00_00 end");
end

--�����[�h�f�o�b�O
function OnEvent_DbgReLoad(proxy,param)
	--���S�񕜗v��
	proxy:RequestFullRecover();
	--�Β��̍B���v�΂�
	proxy:WarpNextStage( 1, 0, 0, 0, 1010 );
end

function OnEvent_4000_Hp_1(proxy,param)
	print("OnEvent_4000_Hp_1 begin");
	proxy:SetDeadMode2(810 , true );
	proxy:SetDeadMode2(811 , true );
	proxy:SetDeadMode2(825 , true );
	print("OnEvent_4000_Hp_1 end");
end

--------------------------------------------------------------------------------------
--Initialize����Ă΂��A1�t���[���x��̏�����������999999
--------------------------------------------------------------------------------------
--��999999���ꕔ�AInit�ł͏����ł��Ȃ��̂ŁA�c���Ă���
function Second_Initialize_m06_00_00_00(proxy, param)
	print("Second_Initialize_m06_00_00_00 begin");	
--------------------------------������QWC�C�x���g�֘A������--------------------------------
--------------------------------������QWC�C�x���g�֘A������--------------------------------
	
	proxy:NotNetMessage_begin();
		--�z�X�g�N���C�A���g�֌W�Ȃ��o�^�����K�v�Ɣ��肳���K�v�������
		proxy:SetEventFlag( 270 , false );
		
		--��270������̈�ɓ�������
		proxy:OnRegionJustIn( 270 , 10000 , 2300 , "OnEvent_270" , everytime);
		proxy:OnRegionJustIn( 270 , 10000 , 2301 , "OnEvent_270" , everytime);
		proxy:OnRegionJustIn( 270 , 10000 , 2302 , "OnEvent_270" , everytime);
		--��271������̈悩��ł���
		proxy:OnRegionJustOut( 271 , 10000 , 2300 , "OnEvent_271" , everytime );
		proxy:OnRegionJustOut( 271 , 10000 , 2301 , "OnEvent_271" , everytime );
		proxy:OnRegionJustOut( 271 , 10000 , 2302 , "OnEvent_271" , everytime );
		
	proxy:NotNetMessage_end();
	print("Second_Initialize_m06_00_00_00 end");
end

--------------------------------------------------------------------------------------
--�}���`�ɂȂ������Ƀz�X�g���ᖳ��������(�A�T�[�g�΍�A��{�����ɏ����͏����Ȃ�)��
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end


--------------------------------------------------------------------------------------
--���o�[�Ŕ����J�����遡0
--------------------------------------------------------------------------------------
--��0�����o�[�Ŕ����J�����遡
function OnEvent_0(proxy, param)
	print("OnEvent_0 begin")
	
	proxy:PlayAnimation( 1000, 1 );	--���o�[�A�j���Đ�
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PULL_LEVER ) == true then 
		proxy:SetEventFlag( 0 , 1 );
		--�p�j�C�x���g��~�p
		proxy:SetEventFlag( 127,true);
		return;
	end
	
	proxy:NotNetMessage_begin();
		--��0_2��***�����ǉ�***���o�[�A�j���I����
		proxy:OnCharacterAnimEnd( 0, 1000, 1, "OnEvent_0_2", once );
	proxy:NotNetMessage_end();

	proxy:WarpDmy( 10000 , 1000 , 191 );
	proxy:SetEventFlag( 0 , 1 );
	--�p�j�C�x���g��~�p
	proxy:SetEventFlag( 127,true);
		
	print("OnEvent_0 end")
end

--��0_2�����o�[�A�j���I����
function OnEvent_0_2(proxy, param)
	print("OnEvent_0_2 begin")
	
	proxy:SetEventFlag( 0 , 0 );
	
	proxy:NotNetMessage_begin();
		--��0_4�������J���|�����Đ���
		proxy:OnKeyTime2( 0, "OnEvent_0_4", 0.0, 0, 3, once );--[[0�b��ɕύX���܂���]]
		--��0_3��***�����ǉ�***0.5�b��ɔ����J����
		proxy:OnKeyTime2( 0, "OnEvent_0_3", 0.5, 0, 2, once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 0 , 1 );
	
	print("OnEvent_0_2 end")
end

--��0_3��0.5�b��ɔ����J����
function OnEvent_0_3(proxy, param)
	print("OnEvent_0_3 begin");
	proxy:LuaCallStart(0,1);	
	print("OnEvent_0_3 end");
end

--�l�b�g�z�M�p
function OnEvent_0_3_Net(proxy,param)
	print("OnEvent_0_3_Net begin");
	--�g���b�RSE�Đ�
	proxy:PlayPointSE( 2014, SOUND_TYPE_O, 606150, 7 );	
	proxy:PlayAnimation( 1010, 1 ); --���Ԃ������A�j���Đ�
	print("OnEvent_0_3_Net end");
end

--��0_4�������J���|�����Đ���
function OnEvent_0_4(proxy, param)
	print("OnEvent_0_4 begin");
	proxy:LuaCallStart(0,2);	
	print("OnEvent_0_4 end");
end

--�l�b�g�z�M�p
function OnEvent_0_4_Net(proxy,param)
	print("OnEvent_0_4_Net begin");
	--�������J���|�����Đ�
	if param:IsNetMessage() == true then
		--�z�M�҂�ID�Ń|�����Đ�
		proxy:RequestRemoPlus(60000,REMO_FLAG,0,1,param:GetPlayID() + 10001);
	else
		--�������g�Ń|�����Đ�
		proxy:RequestRemo(60000,REMO_FLAG,0,1);
	end
	
	--proxy:SetEventFlag( 0 , 1 );
	proxy:SetEventFlag( 2, 1 );
	print("OnEvent_0_4_Net end");
end


--���|�����Đ��J�n(�t�F�[�h�I��)
function OnEvent_0_RemoStart(proxy,param)
	print("OnEvent_0_RemoStart begin");
	print("OnEvent_0_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��)
function OnEvent_0_RemoFinish(proxy , param)
	print("OnEvent_0_RemoFinish begin");
	
	proxy:EndAnimation( 1001, 1 );	--�����J���A�j���Đ��I��
	
	proxy:SetEventFlag( 1, 1 );
	
	print("OnEvent_0_RemoFinish end");
end


--------------------------------------------------------------------------------------
--�n���h��A���񂵂Ď��Ԃ𓮂�����10
--------------------------------------------------------------------------------------
--��10���n���h��A���񂵂Ď��Ԃ𓮂�����
function OnEvent_10(proxy, param)
	print("OnEvent_10 begin") 
	
	proxy:PlayAnimation( 1002, 1 );--�n���h���A�j���Đ�
	
	proxy:NotNetMessage_begin();
		--��10_2��***�����ǉ�***�n���h���A�j���I����
		proxy:OnCharacterAnimEnd( 10, 1002, 1, "OnEvent_10_2", once );
	proxy:NotNetMessage_end();
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_TURN_HANDLE ) == true then 
		return;
	end
--[[	
	proxy:NotNetMessage_begin();
		--��10_1��***�����ǉ�***�v���C���[�A�j���I����
		proxy:OnChrAnimEnd( 10, 10000, ANIMEID_TURN_HANDLE, "OnEvent_10_1", once );
	proxy:NotNetMessage_end();
]]	
--	proxy:Warp( 10000 , 2001 );		--�v���C���[������ʒu�Ƀ��[�v
	proxy:WarpDmy( 10000 , 1002 , 191 );
	
--	proxy:DisableMove( 10000, 1 );	--�v���C���[�𑀍�s�\��
	
	print("OnEvent_10 end")
end
--[[
--��10_1���v���C���A�j���I����
function OnEvent_10_1(proxy, param)
	print("OnEvent_10_1 begin")
	
	proxy:DisableMove( 10000, 0 );	--�v���C���[�𑀍�\��
	
	print("OnEvent_10_1 end")
end
]]
--��10_2���n���h���A�j���I����
function OnEvent_10_2(proxy, param)
	print("OnEvent_10_2 begin")
	
	proxy:SetEventFlag( 10, 1 );	--�t���O�𗧂Ă�
	
	--�����Е��̃n���h���C�x���g�𔭓������Ȃ�
	proxy:DeleteEvent( 12 );--�����ЂƂ̃n���h�����񂷃C�x���g�̍폜

	proxy:NotNetMessage_begin();
		--��10_3��***�����ǉ�***0.5�b�づ
		proxy:OnKeyTime2( 11, "OnEvent_11", 0.5, 0, 2, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_10_2 end")
end

--��10_3��0.5�b�っ
function OnEvent_11(proxy, param)
	print("OnEvent_11 begin")

	--proxy:PlayAnimation( 1003, 1 );	--���ԃA�j���Đ�
	if proxy:IsClient() == false then
		OnEvent_24(proxy,param);
	end
	proxy:SetEventFlag( 11, 1 );	--�t���O�𗧂Ă�
	
	proxy:PlayPointSE( 2011, SOUND_TYPE_O, 606130, 4 );
	--proxy:StopPointSE( 0 );
	print("OnEvent_11 end")
end

--------------------------------------------------------------------------------------
--�n���h��A_2���񂵂Ď��Ԃ𓮂�����12
--------------------------------------------------------------------------------------
--��12���n���h��A���񂵂Ď��Ԃ𓮂�����
function OnEvent_12(proxy, param)
	print("OnEvent_12 begin") 
	
	proxy:PlayAnimation( 1026, 1 );--�n���h���A�j���Đ�
	
	proxy:NotNetMessage_begin();
		--��10_2��***�����ǉ�***�n���h���A�j���I����
		proxy:OnCharacterAnimEnd( 12, 1026, 1, "OnEvent_12_2", once );
	proxy:NotNetMessage_end();
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_TURN_HANDLE ) == true then 
		return;
	end

	proxy:WarpDmy( 10000 , 1026 , 191 );
	
	print("OnEvent_12 end")
end

--��12_2���n���h���A�j���I����
function OnEvent_12_2(proxy, param)
	print("OnEvent_12_2 begin")
	
	proxy:SetEventFlag( 12, 1 );	--�t���O�𗧂Ă�
	
	--�����Е��̃n���h���C�x���g�𔭓������Ȃ�
	proxy:DeleteEvent( 10 );--�����ЂƂ̃n���h�����񂷃C�x���g�̍폜

	proxy:NotNetMessage_begin();
		--��10_3��***�����ǉ�***0.5�b�づ
		proxy:OnKeyTime2( 13, "OnEvent_13", 0.5, 0, 2, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_12_2 end")
end

--��13��0.5�b�っ
function OnEvent_13(proxy, param)
	print("OnEvent_13 begin")

	--proxy:PlayAnimation( 1003, 1 );	--���ԃA�j���Đ�
	if proxy:IsClient() == false then
		OnEvent_24(proxy,param);
	end
	proxy:SetEventFlag( 13, 1 );	--�t���O�𗧂Ă�
	
	proxy:PlayPointSE( 2011, SOUND_TYPE_O, 606130, 4 );
	print("OnEvent_13 end")
end

--�z�X�g�݂̂̃A�j���Ď�
function OnEvent_24(proxy,param)
	proxy:LuaCallStart( 24 ,0 );
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 24 , "OnEvent_24_wait",1.0 ,0 ,0 , once);
	proxy:NotNetMessage_end();
end

--���ԍ�
function OnEvent_24_wait(proxy,param)
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEndPlus(24 , 1003 , 1 , "OnEvent_24",once );
	proxy:NotNetMessage_end();
end

--�A�j���z�M
function OnEvent_24_call(proxy,param)
	proxy:ForcePlayAnimation( 1003, 1 );	--���ԃA�j���Đ�
end

--------------------------------------------------------------------------------------
--�n���h��B���񂵂Ď��Ԃ𓮂�����20
--------------------------------------------------------------------------------------
--��20���n���h��B���񂵂Ď��Ԃ𓮂�����
function OnEvent_20(proxy, param)
	print("OnEvent_20 begin")
	
	proxy:PlayAnimation( 1004, 1 );--�n���h���A�j���Đ�
	--proxy:PlayPointSE( 2012, SOUND_TYPE_O, 606130, 0 );
	proxy:SetEventFlag( 20 , 1 );
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_TURN_HANDLE ) == true then 
		return;
	end
	
	proxy:NotNetMessage_begin();
		--��20_2��***�����ǉ�***�n���h���A�j���I����
		proxy:OnCharacterAnimEnd( 21, 1004, 1, "OnEvent_21", once );
	proxy:NotNetMessage_end();

	proxy:WarpDmy( 10000 , 1004 , 191 );
	
	print("OnEvent_20 end")
end


--��21���n���h���A�j���I����
function OnEvent_21(proxy, param)
	print("OnEvent_21 begin")
	proxy:SetEventFlag( 21 , 1 );
	
	proxy:NotNetMessage_begin();
		--��21_1��***�����ǉ�***�n���h���A�j���I������0.5�b�づ
		proxy:OnKeyTime2( 21, "OnEvent_21_1", 0.0, 0, 2, once );--[[0�b��ɕύX���܂���]]
	proxy:NotNetMessage_end();
	
	print("OnEvent_21 end")
end

--��21_1���n���h���A�j���I������0.5�b�っ
function OnEvent_21_1(proxy,param)
	print("OnEvent_21_1 begin");
	proxy:LuaCallStart( 22 , 0);
	print("OnEvent_21_1 end");
end


--��22����
function OnEvent_22(proxy, param)
	print("OnEvent_22 begin");
	
	proxy:PlayAnimation( 1005 , 1 );--���ԃA�j���Đ�
	proxy:SetEventFlag(146,true);--OBJ�����ւ�
	proxy:SetEventFlag(147,true);--SFX�؂�ւ�
	proxy:SetEventFlag(148,true);--SFX�؂�ւ�
	proxy:SetEventFlag(149,true);--SE��~

	--�����ʂ�������|�����Đ�
	proxy:RequestRemo(60001,REMO_FLAG,20,1);
	
--[[	
	proxy:PlayAnimation( 1005, 1 );	--���ԃA�j���Đ�
	proxy:PlayAnimation( 1009, 1 ); --����(?)�A�j���Đ�
	
	
	proxy:NotNetMessage_begin();
		--��20_4��***�����ǉ�***���ԁE���ԃA�j���Đ�����1�b�づ
		proxy:OnKeyTime2( 20, "OnEvent_20_4", 1.0, 0, 3, once );
		--��20_5��***�����ǉ�***���ԃA�j���Đ��I����
		proxy:OnCharacterAnimEnd( 20, 1005, 1, "OnEvent_20_5", once );
		--��20_6��***�����ǉ�***����(?)�A�j���Đ��I����
		proxy:OnCharacterAnimEnd( 20, 1009, 1, "OnEvent_20_6", once );
	proxy:NotNetMessage_end();
	
]]
	
	print("OnEvent_22 end");
end


--���|�����Đ��J�n(�t�F�[�h�I��)
function OnEvent_20_RemoStart(proxy,param)
	print("OnEvent_20_RemoStart begin");
	
	proxy:SetDrawEnable( 1030, false );--���ʃI�u�W�F�`�����
	proxy:StopLoopAnimation( 1009 );
	proxy:PlayAnimation( 1009 , 0 );--���Ԃ��~�܂��Ă�A�j���Đ�
	proxy:DeleteEvent(128);--�_���[�W��ON�C�x���g�폜
	proxy:DeleteEvent(133);--�_���[�W��OFF�C�x���g�폜
	proxy:DeleteEvent(50);--�G�_���[�W��ON�C�x���g�폜
	proxy:DeleteEvent(51);--�G�_���[�W��OFF�C�x���g�폜
	--proxy:EraseEventSpecialEffect(10000,10050);	
	proxy:DeleteEvent( 4069 );
	IS_FIREAREA = false;	
	proxy:InvalidSfx( 2015 , false );
	
	print("OnEvent_20_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��)
function OnEvent_20_RemoFinish(proxy , param)
	print("OnEvent_20_RemoFinish begin");
	
	--function OnEvent_23(proxy, param)
	proxy:SetColiEnable( 1008, false );	--�����I�u�W�F�̓����������(���ʂ�)
	
	proxy:SetEventFlag(23, true);--�����ɏ����Ă���̂ŁA�d�l�ɂ��킹��ׂɃt���O�Z�b�g
	--end
	proxy:SetColiEnable(1031,false);
	proxy:SetDrawEnable(1031,false);
	proxy:SetColiEnable(1032,true);
	proxy:SetDrawEnable(1032,true);	
	proxy:StopPointSE( 5 );--SE��~
	
	proxy:ValidSfx(2043);
	proxy:ValidSfx(2044);
	
	--�}�O�}���oSFX�p�~
	proxy:InvalidSfx( 2046 ,true );
	
	--�}�O�}�q�b�g�G�t�F�N�g�p
	proxy:SetColiEnableArray( 1033 , false );	

	proxy:SetEventFlag( 22 , 1 );

	print("OnEvent_20_RemoFinish end");
end


--[[
--��20_4�����ԁE���ԃA�j���Đ�����1�b�っ
function OnEvent_20_4(proxy, param)
	print("OnEvent_20_4 begin");
	
	print("�n���h��B���񂵂Ď��Ԃ𓮂���");
	print("���ʂ������� �|�����Đ�");
	
--	proxy:MoveMapParts(1030,0,-5,0);	--���ʉ�����
	proxy:SetDrawEnable( 1030, false );
	
	proxy:NotNetMessage_begin();
		--��20_7��***�����ǉ�***���ʂ��������Ă���0�b�づ
		proxy:OnKeyTime2( 20, "OnEvent_20_7", 0.0, 0, 4, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_20_4 end");
end

--��20_5�����ԃA�j���Đ��I����
function OnEvent_20_5(proxy, param)
	print("OnEvent_20_5 begin");
	
	proxy:PlayAnimation( 1005 , 2 );--�ȍ~�A2�Ԃ̃A�j�������[�v�Đ�(����)
	
	print("OnEvent_20_5 end");
end

--��20_6������(?)�A�j���Đ��I����
function OnEvent_20_6(proxy, param)
	print("OnEvent_20_6 begin");

	proxy:PlayAnimation( 1009 , 2 );--�ȍ~�A2�Ԃ̃A�j�������[�v�Đ�(����)
	
	print("OnEvent_20_6 end");
end

--��20_7�����ʂ��������Ă���0�b�っ
function OnEvent_20_7(proxy, param)
	print("OnEvent_20_7 begin");

	proxy:SetColiEnable( 1008, false );	--�����I�u�W�F�̓����������
	proxy:SetEventFlag( 20, true );		--�t���O�𗧂Ă�
	
	print("OnEvent_20_7 end");
end
]]


--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ��遡111
--------------------------------------------------------------------------------------

--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫

--��111�����{�X�����ւ̔����J����
function OnEvent_111(proxy,param)
	print("OnEvent_111 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_111 end");
		return;
	end
	
	--�N���C�A���g�ցA�{�X�����j�~���s��ʒm
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	proxy:LuaCallStart( 112, 1 );--����A�j���̓����Đ�
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--���d�N���V�X�e��ID���^�C���A�E�g��ݒ肵��ON�ɂ���
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
			
	print("OnEvent_111 end");
end


--����A�j���̓����Đ�(ID����)
function OnEvent_112_1(proxy,param)
	print("OnEvent_112_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ����s���A���̏I������OnEvent_112_2�𔭍s����
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2891 );
		else
			proxy:LockSession();--���[�������b�N���܂��I
			--����A�j���Đ����s���A���̏I������OnEvent_112_2�𔭍s����
			proxy:OnTurnCharactorEnd( 112, 10000, 2891, "OnEvent_112_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_112_1 end");
end

--����A�j���̓����Đ��I����
function OnEvent_112_2(proxy,param)
	print("OnEvent_112_2 begin");

	--�����p�����A�j���Đ�
	proxy:LuaCallStart( 4012, 1 );

	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 112, 10000, ANIMEID_WALK, "OnEvent_112_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_112_2 end");
end

--�����A�j���̓����Đ��I����
function OnEvent_112_3(proxy,param)
	print("OnEvent_112_3 begin");
	
	--�ŏ��̐l���{�X�����̒��ɓ���I����Ă�����A���ɔz�M����Ă���͂��Ȃ̂ŁA����������Ȃ��n���h��
	if proxy:IsCompleteEvent( 111 ) == false then
		proxy:LuaCallStart( 112 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCallStart( 4045 , 1 );	--�N���C�A���g�ցA�{�X�����ɓ����悤�ɂȂ������Ƃ�ʒm
		proxy:LuaCallStart( 112 , 6 );--�t���O�Z�b�g(�����p)
		Lua_MultiDoping(proxy,810);--�}���`�v���C�h�[�s���O
	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�)
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:ResetThink( 810 );
	end	
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );
	
	print("OnEvent_112_3 end");
end


--��111 2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
function OnEvent_111_GO_TO_IN(proxy, param)
	print("OnEvent_111_GO_TO_IN begin");
	
	proxy:NotNetMessage_begin();
		--��112�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���--�n���h���� OnEvent_111
		proxy:OnPlayerActionInRegion( 112, 2895, "OnEvent_111", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	

	print("OnEvent_111_GO_TO_IN end");
end


--��111 �t���O�Z�b�g(�����p)
function OnEvent_111_flag_set(proxy, param)
	print("OnEvent_111_flag_set begin");
		
	proxy:SetEventFlag( 111 , 1 );
	proxy:DeleteEvent( 111 );

	print("OnEvent_111_flag_set end");
end



--------------------------------------------------------------------------------------
--�{�X�������o��(�퓬�J�n)��113
--------------------------------------------------------------------------------------

function OnEvent_113(proxy, param)
	print("OnEvent_113 begin");
	
	--�{�X��pBGM�Đ��J�n
	--[[ID����]]
	proxy:PlayPointSE( 2050, SOUND_TYPE_M, 60000000, 0 );
	
	--�{�X���W�b�NON
	proxy:EnableLogic( 810 , true );
	
	--�{�X�C�x���g�X�^�[�g
	BossEventStart_Spider(proxy,param);

	--�t���OON
	proxy:SetEventFlag( 113 ,true );
	
	--�{�X�Q�[�W�\��
	proxy:SetBossGauge(810, 0, 5100);
		
	print("OnEvent_113 end");
end



--[[
--------------------------------------------------------------------------------------
--�n�V�SA�~�聡60
--------------------------------------------------------------------------------------
--��60���n�V�SA�~��X�^�[�g��
function OnEvent_60(proxy, param)
	print("OnEvent_60 begin");

	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_60 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,2,2);				--�z�o�[�ړ����[�h�Ɉڍs
	proxy:HoverMoveVal(10000,2007,LadderTime_A);--�ړ��ʒu(2007)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,1);				--�C�x���g�R�}���hID(1)"�n�V�S�ォ���"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(60,"OnEvent_60_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���)
		proxy:OnKeyTime2(60,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_60 end");
end

--��60_1���n�V�SA�~��X�^�[�g:�z�o�[�ړ��I����
function OnEvent_60_1(proxy, param)
	print("OnEvent_60_1 begin");

	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_60_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,19,18);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);

	print("OnEvent_60_1 end");
end


--------------------------------------------------------------------------------------
--�n�V�SA���聡61
--------------------------------------------------------------------------------------
--��61���n�V�SA����X�^�[�g��
function OnEvent_61(proxy, param)
	print("OnEvent_61 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_61 end");
		return;
	end
	
	--�͂�������ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,-1,1);			--�z�o�[�ړ����[�h�Ɉڍs
	proxy:HoverMoveVal(10000,2006,LadderTime_A);--�ړ��ʒu(2006)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,0);				--�C�x���g�R�}���hID(0)"�n�V�S�������"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂�������X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(61,"OnEvent_61_1",LadderTime_A,0,0,once);
		--�͂�������p�̊֐���1�b�Ԕ��s(�C�x���g���j���[�̒��f����?)
		proxy:OnKeyTime2(61,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_61 end");
end

--��61_1���n�V�SA����X�^�[�g:�z�o�[�ړ��I����
function OnEvent_61_1(proxy, param)
	print("OnEvent_61_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_61_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,-1,18);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_61_1 end");
end
]]
--------------------------------------------------------------------------------------
--���u���b�N�ւ̈ړ��|����(�C�x���g70���甭�s�����)��6176
--------------------------------------------------------------------------------------
--��6176�����u���b�N�ւ̈ړ��|������
--��ID�ŕ����Ă���̂́A�|�����̃C�x���g�݂̂����X�{�X���Z�b�g�ɂ��邽��(?)
function OnEvent_6176(proxy, param)
	print("OnEvent_6176 begin");

	--�|�����Đ�
	--���u���b�N�ւ�����悤�ɂȂ�
	
	proxy:SetEventFlag( 6176 , 1 );
	
	print("OnEvent_6176 end");
end


--------------------------------------------------------------------------------------
--�n���h���Ŏ��Ԃ��񂵂ċ[���G���x�[�^�[�ɂ��遡80
--------------------------------------------------------------------------------------
--��80���n���h���Ŏ��Ԃ��񂵂ċ[���G���x�[�^�[�ɂ��遡
function OnEvent_80(proxy, param)
	print("OnEvent_80 begin")
	
	proxy:PlayAnimation( 1016, 1 );--�n���h���A�j���Đ�
	
	--OBJ�Ď��͑S�����I��������
	proxy:NotNetMessage_begin();
		--��80_2��***�����ǉ�***�n���h���A�j���I����
		proxy:OnObjAnimEnd( 80, 1016, 1, "OnEvent_80_1", once );
	proxy:NotNetMessage_end();
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_TURN_HANDLE ) == true then 
		return;
	end
	
	proxy:WarpDmy( 10000 , 1016 , 191 );	
	print("OnEvent_80 end")
end

--��80_2���n���h���A�j���I����
function OnEvent_80_1(proxy, param)
	if proxy:IsCompleteEvent( 80 ) == false then
		print("OnEvent_80_1 begin")	
		proxy:LuaCallStart(80,1);	
		print("OnEvent_80_1 end")
	end
end

--��80_2���n���h���A�j���I���̓�����
function OnEvent_80_2(proxy, param)
	print("OnEvent_80_2 begin")
	
	proxy:SetEventFlag( 80, 1 );	--�t���O�𗧂Ă�

	proxy:NotNetMessage_begin();
		--��80_3��***�����ǉ�***0.0�b�づ
		proxy:OnKeyTime2( 81, "OnEvent_81", 0.0, 0, 2, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_80_2 end")
end

--��81��0.5�b�っ
function OnEvent_81(proxy, param)
	print("OnEvent_81 begin")

	--proxy:PlayAnimation( 1019, 1 );	--���ԃA�j���Đ�
	proxy:SetEventFlag( 81, 1 );	--�t���O�𗧂Ă�
	--�N���C�A���g�̂݃C�x���g���Ď�����
	if proxy:IsClient() == false then
		OnEvent_14(proxy,param);
	end
	proxy:PlayPointSE( 2012, SOUND_TYPE_O, 606130, 6 );
	--proxy:StopPointSE( 1 );
	print("OnEvent_81 end")
end

--�z�X�g�̎��ԃA�j���Ď�
function OnEvent_14(proxy,param)
	--���ԃA�j���̍Đ�
	proxy:LuaCallStart( 14 , 0 );
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 14, "OnEvent_14_wait",1.0,0,0,once);
	proxy:NotNetMessage_end();
end

--�z�X�g�̃A�j���Ď��b���҂�
function OnEvent_14_wait(proxy,param)
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEndPlus(14 , 1019 , 1 , "OnEvent_14",once );
	proxy:NotNetMessage_end();
end

--�����p�n���h��
function OnEvent_14_call(proxy,param)
	--print("OnEvent_14_call");
	proxy:ForcePlayAnimation( 1019 , 1 );
end


--[[
--------------------------------------------------------------------------------------
--�b�艮��̔�(���o�[�Ŕ����J������)��90
--------------------------------------------------------------------------------------
--��90�����o�[�Ŕ����J�����遡
function OnEvent_90(proxy, param)
	print("OnEvent_90 begin")
	
	proxy:PlayAnimation( 1022, 1 );	--���o�[�A�j���Đ�
	
	proxy:NotNetMessage_begin();
		--��90_2��***�����ǉ�***���o�[�A�j���I����
		proxy:OnCharacterAnimEnd( 90, 1022, 1, "OnEvent_90_2", once );
	proxy:NotNetMessage_end();
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PULL_LEVER ) == true then 
		return;
	end
--[[	
	proxy:NotNetMessage_begin();
		--��90_1��***�����ǉ�***�v���C���[�A�j���I����
		proxy:OnChrAnimEnd( 90, 10000, ANIMEID_PULL_LEVER, "OnEvent_90_1", once );
	proxy:NotNetMessage_end();
]]		
--	proxy:Warp( 10000 , 2013 );		--�v���C���[������ʒu�Ƀ��[�v
	proxy:WarpDmy( 10000 , 1022 , 191 );
	
--	proxy:DisableMove( 10000, 1 );	--�v���C���[�𑀍�s�\��
		
	print("OnEvent_90 end")
end
--[[
--��90_1���v���C���[�A�j���I����
function OnEvent_90_1(proxy, param)
	print("OnEvent_90_1 begin")
		
	proxy:DisableMove( 10000, 0 );	--�v���C���[�𑀍�\��
	
	print("OnEvent_90_1 end")
end
]]
--��90_2�����o�[�A�j���I����
function OnEvent_90_2(proxy, param)
	print("OnEvent_90_2 begin")
	
	proxy:SetEventFlag( 90, 1 );	--�t���O�𗧂Ă�

	proxy:NotNetMessage_begin();
		--��90_3��***�����ǉ�***0.5�b��ɔ����J����
		proxy:OnKeyTime2( 91, "OnEvent_91", 0.5, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_90_2 end")
end

--��91��0.5�b��ɔ����J����
function OnEvent_91(proxy, param)
	print("OnEvent_91 begin");
	
	proxy:PlayAnimation( 1021, 1 );	--�����J���A�j���Đ�
	proxy:SetEventFlag( 91, 1 );	--�t���O�𗧂Ă�
	
	print("OnEvent_91 end");
end
]]


--------------------------------------------------------------------------------------
--�Β��Ƀ��[�v��150
--------------------------------------------------------------------------------------

--��150���Β��Ƀ��[�v��
function OnEvent_150(proxy,param)	

	if proxy:IsCompleteEvent( 150 ) == true then
		return;
	end
	
	if param:IsNetMessage() == true then
		return;
	end
	
	
	print("OnEvent_150 begin");
	
	--�Z�b�V�������Ȃ�΁A�v�΂̃��[�v����
	if proxy:IsSession() == false then--�Z�b�V�������ł͂Ȃ�
		proxy:RepeatMessage_begin();
			--��150_1���I�����j���[�̊Ď���
			proxy:OnSelectMenu(150, "OnEvent_150_0", 10010710, 0, 2, 1983, 2, once);			
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

	print("OnEvent_150 end");
end

--��150_0���I�����j���[�̊Ď���
function OnEvent_150_0(proxy, param)
	print("OnEvent_150_0 begin");	
	
	if proxy:IsSession() == false then
		proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ�
		proxy:NoAnimeTurnCharactor( 10000 , 1983 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--���v�΂ɐG���A�j���Đ��I����
			proxy:OnChrAnimEnd( 150 , 10000 , 8283 , "OnEvent_150_1" , once );
		proxy:NotNetMessage_end();

		proxy:SetEventFlag( 150 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_150_0 end");
end

--��150_1���I�����j���[�̊Ď���
function OnEvent_150_1(proxy, param)
	print("OnEvent_150_1 begin");
	
	proxy:SetEventFlag( 150 , 0 );
	
	proxy:PlayAnimation( 10000 , 8284 );--�v�΂ɐG���A�j�����Đ�

	proxy:SetEventFlag( 150 , 1 );
	
	OnEvent_150_2(proxy, param);
	
	print("OnEvent_150_1 end");
end

--��150_2���v�΂ɐG���A�j���Đ��I����
function OnEvent_150_2(proxy,param)	
	print("OnEvent_150_2 begin");
	
	--�Β��֖߂��Ă�������̃t���O�𗧂Ă�
	proxy:SetEventFlag(8083, true);

	proxy:SetEventFlag( 150 , 0 );
	--���S�񕜗v��
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1010 );
	
	print("OnEvent_150_2 end");
end


--------------------------------------------------------------------------------------
--��151���ŏ��̗v�΂̌��������遡
--------------------------------------------------------------------------------------

function OnEvent_151(proxy, param)
	print("OnEvent_151 begin");
	
	proxy:TreasureDispModeChange2( 1983 , false ,KANAME_SFX);
	
	print("OnEvent_151 end");
end


--------------------------------------------------------------------------------------
--��152���ŏ��̗v�΂̌����������遡
--------------------------------------------------------------------------------------

function OnEvent_152(proxy, param)
	print("OnEvent_152 begin");
	
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	
	print("OnEvent_152 end");
end



--------------------------------------------------------------------------------------
--���{�X���S��6174
--------------------------------------------------------------------------------------
--��6174�����{�X���S��
function OnEvent_6174(proxy,param)
	print("OnEvent_6174 begin");

	proxy:NotNetMessage_begin();
		--��6174_1��0�b�づ
		proxy:OnKeyTime2( 6174 , "OnEvent_6174_1" , 0 , 0 , 1 , once );
		--�}���`���U�Ď�
		proxy:OnRegistFunc( 6174,"Check_6174_PT","OnEvent_6174_PT",0,once);
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( 6174, 1 );
	
	--�{�X�����S�Œw偂̑��C�x���g�������������
	--proxy:DeleteEvent( 211 );
	--proxy:DeleteEvent( 212 );
	--proxy:DeleteEvent( 213 );
	--�����܂�
	
	print("OnEvent_6174 end");
end

function OnEvent_6174_1(proxy,param)
	print("OnEvent_6174_1 begin");

	--�{�X��|���������X�V(���ɂ���ăt���O�𗧂Ă�)
	GetBossFlagCount( proxy, param );
	
	--���g���t�B�[�擾���聥
	Lua_RequestUnlockTrophy(proxy, 36);--�g���t�B�̎擾�󋵂𔻒肵�A�擾����
	
--�A�C�e������֘A-------
	
	--�z�X�g�v���C���[�̂݃A�C�e������C�x���g�Ɏg�p
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

	--�󎀑�(�\�E��?)�L����
	proxy:SetDrawEnable( 1982 , true );
	proxy:SetColiEnable( 1982 , true );
	--�󎀑�(�\�E��?)�L����
	proxy:SetDrawEnable( 1975 , true );
	proxy:SetColiEnable( 1975 , true );
	
	--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
	if proxy:IsCompleteEvent( 6193 ) == false then
		--SFXON
		proxy:ValidSfx( 2131 );--���̗��q
		proxy:ValidSfx( 2132 );--�v�΂̃I�[��
		proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);--���点��
		proxy:OnDistanceActionAttribute( 6193 , 10000 , 1982 , "OnEvent_6193" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end
	
	--�{�X��p��BGM��~
	--[[�Đ������Ă��Ȃ��̂ť��]]
	proxy:StopPointSE( 0 );
	
------------------------	
	--���{�X�������@�ǂ�SFX�폜
	--���̕�Sfx������
	--proxy:DeleteObjSfxEventID( 1999 );
	--proxy:DeleteObjSfxEventID( 1995 );	
	
	--�V�u���b�N�N���A������
	proxy:CustomLuaCallStart( 4050, 810);
	--�g�J�Q���Z�b�g
	ResetTokage(proxy);
	
	print("OnEvent_6174_1 end");
end

--�}���`���U�Ď�
function Check_6174_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--�}���`����Ȃ�
function OnEvent_6174_PT(proxy,param)
	print("OnEvent_6174_PT begin");
	
	proxy:SetDrawEnable(1995,false);
	proxy:SetColiEnable(1995,false);
	
	proxy:SetDrawEnable(1999,false);
	proxy:SetColiEnable(1999,false);	
	
	proxy:InvalidSfx( 1987, true );
	proxy:InvalidSfx( 1991, true );
	
	--���{�X�����O�̈ړ������C�x���g���폜
	proxy:DeleteEvent( 111 );--��l�ڂ�����Ƃ��p
	proxy:DeleteEvent( 112 );--��l�ڈȍ~������Ƃ��p
	proxy:DeleteEvent( 113 );--�{�X�퓬�J�n�p
	
	--�{�X�����p�̃A�^���������Ή�
	proxy:SetColiEnableArray(3001,true);--�ʏ�L��
	proxy:SetColiEnableArray(3002,true);--�ʏ�L��
	proxy:SetColiEnableArray(3005,true);--�ʏ�L��
	proxy:SetColiEnableArray(3006,true);--�ʏ�L��
	proxy:SetColiEnableArray(3009,true);--�ʏ�L��
	proxy:SetColiEnableArray(3010,true);--�ʏ�L��		
	proxy:SetColiEnableArray(3003,false);--�{�X�p����
	proxy:SetColiEnableArray(3004,false);--�{�X�p����
	proxy:SetColiEnableArray(3007,false);--�{�X�p����
	proxy:SetColiEnableArray(3008,false);--�{�X�p����
	proxy:SetColiEnableArray(3011,false);--�{�X�p����
	proxy:SetColiEnableArray(3012,false);--�{�X�p����
	
	print("OnEvent_6174_PT end");
end

--------------------------------------------------------------------------------------
--��6194���Β��Ƀ��[�v��
--------------------------------------------------------------------------------------
function OnEvent_6194(proxy,param)	
	print("OnEvent_6194 begin");
	
	if proxy:IsCompleteEvent( 6194 ) == true then
		return;
	end
	
	proxy:RepeatMessage_begin();
		--��70_1���I�����j���[�̊Ď���
		proxy:OnSelectMenu(6194, "OnEvent_6194_1", 10010710, 0, 2, 1982, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_6194 end");
end

--��6194_1���I�����j���[�̊Ď���
function OnEvent_6194_1(proxy,param)	
	print("OnEvent_6194_1 begin");	
	
	if proxy:IsSession() == false then
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1982 ,TURNSKIP_ANGLE);

		proxy:NotNetMessage_begin();
			proxy:OnChrAnimEnd( 6194 , 10000 , 8283 , "OnEvent_6194_2",once);
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(6194,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_6194_1 end");
end

--��6194_2���I�����j���[�̊Ď���
function OnEvent_6194_2(proxy,param)	
	print("OnEvent_6194_2 begin");
	
	proxy:SetEventFlag(6194,false);
	
	proxy:PlayAnimation(10000,8284);

	proxy:SetEventFlag(6194,true);

	OnEvent_6194_3(proxy, param);
	
	print("OnEvent_6194_2 end");
end

--��6194_3���Β��Ƀ��[�v��
function OnEvent_6194_3(proxy,param)	
	print("OnEvent_6194_3 begin");

	--�Β��֖߂��Ă�������̃t���O�𗧂Ă�
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag(6194,false);
	--���S�񕜗v��
	proxy:RequestFullRecover();
	--�Íԗv�΂ɖ߂�
	proxy:WarpNextStage( 1, 0, 0, 0, 1010);	
	print("OnEvent_6194_3 end");
end

--------------------------------------------------------------------------------------
--��6193���\�E�����聡
--------------------------------------------------------------------------------------
function OnEvent_6193(proxy, param)
	print("OnEvent_6193 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--�V�����A�j�� 
		print("OnEvent_6193 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 6193, "OnEvent_6193_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_6193 end");
end


--��6193_1���A�C�e���擾��
function OnEvent_6193_1(proxy, param)
	print("OnEvent_6193_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10630�Q��
	proxy:GetRateItem(10630);
	--�A�C�e���擾�֐�--�p�����[�^10670�Q��
	proxy:GetRateItem(10670);
	--�A�C�e���擾�֐�--�p�����[�^10671�Q��
	proxy:GetRateItem(10671);
	--�A�C�e���擾�֐�--�p�����[�^10672�Q��
	proxy:GetRateItem(10672);
	--�A�C�e���擾�֐�--�p�����[�^10673�Q��
	proxy:GetRateItem(10673);
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 6193, 1 );
	
	--��V�F�[�_�[OFF
	--proxy:TreasureDispModeChange( 1982 , false );

	--SFX��������
	proxy:InvalidSfx( 2131 , true );--���̗��q
	--proxy:InvalidSfx( 2132 , true );--�v�΂̃I�[��
	
	--���v�΂Ń��[�v�p�̊Ď���ǉ���
	proxy:OnDistanceActionAttribute( 6194 , 10000 , 1982 , "OnEvent_6194" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_6193_1 end");
end

--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m06_00_00_00(proxy, param)
	print("PlayerDeath_m06_00_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m06_00_00_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerDeath_m06_00_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m06_00_00_00(proxy,param)
	print("PlayerRevive_m06_00_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m06_00_00_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerRevive_m06_00_00_00");
end




--------------------------------------------------------------------------------------
--�p�j�S�[�X�g�ڌ��C�x���g��124
--------------------------------------------------------------------------------------
--������
function OnEvent_124_Init(proxy,param)
	print("OnEvent_124_Init begin");
	proxy:SetIgnoreHit(664,true);
	proxy:SetDisableGravity(664,true);
	proxy:EnableLogic( 664, false );
	proxy:SetDrawEnable( 664, false );
	--proxy:EnableInvincible( 664 , true );
	--proxy:EnableHide( 664, true );--���G����Ȃ�
	print("OnEvent_124_Init end");
end

--�̈�ɓ����Ă���Ԃ̃C�x���g
function OnEvent_124(proxy,param)
	--�ڌ��C�x���g�̃t���O,���o�[�C�x���g�̃t���O�̗�����OFF�Ȃ甭��
	if proxy:IsCompleteEvent(124) == false and proxy:IsCompleteEvent(127) == false then
		--print("OnEvent_124 begin");						
		proxy:NotNetMessage_begin();
			proxy:SetDrawEnable( 664, true );
			proxy:OnWanderFade(124,664,2.0,2.0,8.0,10.0,once);
			--���񔭐��p�̃E�F�C�g+�����_������H
			proxy:OnKeyTime2(125,"OnEvent_124_NextWait",EVENT_TIME01,0,1,once);
			--�Ƃ肠�������A�j���͖��C�Ȃ��̂ŁE�E�E�኱�x�点�Ă݂�
			proxy:OnKeyTime2(125,"OnEvent_124_1",2,0,2,once);
			--�`�悾��ON			
			--proxy:SetDrawEnable( 664, true );			
			--�A���������Ȃ��悤�Ƀt���OON			
			proxy:SetEventFlag(124,true);
		proxy:NotNetMessage_end();
		--print("OnEvent_124 end");
	end
end

--���b�o�߂̃C�x���g
function OnEvent_124_1(proxy,param)
	--print("OnEvent_124_1 begin");
	
	proxy:WarpDmy( 664 , 1000 , 191 );
	--���o�[�A�j���Đ�
	proxy:PlayAnimation(664,8000);
	proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd(125,664,8000,"OnEvent_125",once);
		proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	--print("OnEvent_124_1 end");
end

--�A�j���I���̃C�x���g
function OnEvent_125(proxy,param)
	--print("OnEvent_125 begin");
	--proxy:SetDrawEnable( 664, false);			
	--print("OnEvent_125 end");
end

--�E�F�C�g�b���o�߂̃C�x���g
function OnEvent_124_NextWait(proxy,param)
	--print("OnEvent_124_NextWait begin");
	--�`�F�b�N�p�̃C�x���g��OFF�ɂ���
	proxy:DeleteEvent(125);
	proxy:SetEventFlag(124,false);
	--print("OnEvent_124_NextWait end");
end


--------------------------------------------------------------------------------------
--��121���z�X�gPC�݂̂��ʂ����̖���
--------------------------------------------------------------------------------------
--��121_delete_wall�����@�Ǎ폜�����p��
function OnEvent_121_delete_wall(proxy , param)
	print("OnEvent_121_delete_wall begin");
	
	proxy:SetDrawEnable( 1111 , false );--���@�Ǖ`��OFF
	proxy:SetColiEnable( 1111 , false );--���@�Ǔ�����OFF	
	proxy:SetObjDeactivate( 1111 , true );--�f�A�N�e�B�u
	proxy:DeleteEvent( 121 );--�S�v���C���[���̊Ď�������͂��B
	proxy:InvalidSfx( 2040, true );
	
	print("OnEvent_121_delete_wall end");
end

--��121���C�x���g�����p��
function OnEvent_121(proxy , param)
	print("OnEvent_121 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 121 ) == true then
		print("OnEvent_121 end");
		return;
	end
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 121 , 1 );
		print("OnEvent_121 end");
		return;
	end
	
	--�_�~�|���փ��[�v
	proxy:WarpDmy( 10000 , 1111 , 191 );
	
	proxy:NotNetMessage_begin();
		--��240_1�������A�j���I����
		--proxy:OnChrAnimEnd( 121 , 10000 , ANIMEID_WALK , "OnEvent_121_1" , once );
		proxy:LuaCallStart( 121 , 1 );--���̖��폜����
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 121 , 1 );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_121 end");
end

--��121_1�������A�j���I����
function OnEvent_121_1(proxy , param)
	print("OnEvent_121_1 begin");
	
	proxy:LuaCallStart( 121 , 1 );--���̖��폜����
	
	print("OnEvent_121_1 end");
end


--------------------------------------------------------------------------------------
--��122���z�X�gPC�݂̂��ʂ����̖���
--------------------------------------------------------------------------------------
--��122_delete_wall�����@�Ǎ폜�����p��
function OnEvent_122_delete_wall(proxy , param)
	print("OnEvent_122_delete_wall begin");
	
	proxy:SetDrawEnable( 1112 , false );--���@�Ǖ`��OFF
	proxy:SetColiEnable( 1112 , false );--���@�Ǔ�����OFF	
	proxy:SetObjDeactivate( 1112 , true );--�f�A�N�e�B�u
	proxy:DeleteEvent( 122 );--�S�v���C���[���̊Ď�������͂��B
	proxy:InvalidSfx( 2041, true );
	
	print("OnEvent_122_delete_wall end");
end

--��122���C�x���g�����p��
function OnEvent_122(proxy , param)
	print("OnEvent_122 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 122 ) == true then
		print("OnEvent_122 end");
		return;
	end
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 122 , 1 );
		print("OnEvent_122 end");
		return;
	end
	
	--�_�~�|���փ��[�v
	proxy:WarpDmy( 10000 , 1112 , 191 );
	
	proxy:NotNetMessage_begin();
		--��240_1�������A�j���I����
		--proxy:OnChrAnimEnd( 122 , 10000 , ANIMEID_WALK , "OnEvent_122_1" , once );
		proxy:LuaCallStart( 122 , 1 );--���̖��폜����
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 122 , 1 );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_122 end");
end

--��122_1�������A�j���I����
function OnEvent_122_1(proxy , param)
	print("OnEvent_122_1 begin");
	
	proxy:LuaCallStart( 122 , 1 );--���̖��폜����
	
	print("OnEvent_122_1 end");
end


--------------------------------------------------------------------------------------
--��123���z�X�gPC�݂̂��ʂ����̖���
--------------------------------------------------------------------------------------
--��123_delete_wall�����@�Ǎ폜�����p��
function OnEvent_123_delete_wall(proxy , param)
	print("OnEvent_123_delete_wall begin");
	
	proxy:SetDrawEnable( 1113 , false );--���@�Ǖ`��OFF
	proxy:SetColiEnable( 1113 , false );--���@�Ǔ�����OFF	
	proxy:SetObjDeactivate( 1113 , true );--�f�A�N�e�B�u
	proxy:DeleteEvent( 123 );--�S�v���C���[���̊Ď�������͂��B
	proxy:InvalidSfx( 2042, true );
	
	print("OnEvent_123_delete_wall end");
end

--��123���C�x���g�����p��
function OnEvent_123(proxy , param)
	print("OnEvent_123 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 123 ) == true then
		print("OnEvent_123 end");
		return;
	end
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 123 , 1 );
		print("OnEvent_123 end");
		return;
	end
	
	--�_�~�|���փ��[�v
	proxy:WarpDmy( 10000 , 1113 , 191 );
	
	proxy:NotNetMessage_begin();
		--��240_1�������A�j���I����
		--proxy:OnChrAnimEnd( 123 , 10000 , ANIMEID_WALK , "OnEvent_123_1" , once );
		proxy:LuaCallStart( 123 , 1 );--���̖��폜����
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 123 , 1 );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_123 end");
end

--��123_1�������A�j���I����
function OnEvent_123_1(proxy , param)
	print("OnEvent_123_1 begin");
	
	proxy:LuaCallStart( 123 , 1 );--���̖��폜����
	
	print("OnEvent_123_1 end");
end


--------------------------------------------------------------------------------------
--��70���n���h���񂵂ăt���A�ړ���
--------------------------------------------------------------------------------------
function OnEvent_70(proxy,param)
	--����ON�Ȃ�A�j����	
	if proxy:IsCompleteEvent(130) == true and proxy:IsCompleteEvent(132) == true then
		--�����҂����C���t�H
		if param:IsNetMessage() == false then
			--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\��
			--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010170, 1);
			--proxy:ShowGenDialog(10010170,1,1,true);
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010170, 0, 6, -1, GEN_DIALOG_DIST, once );
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();
		end		
		return;
	end
	
	print("OnEvent_70 begin");
	if proxy:IsCompleteEvent(72) == false then
		proxy:PlayAnimation(1023,1);		
	else
		proxy:PlayAnimation(1023,2);		
	end
	--����ON���A�j����
	proxy:SetEventFlag(130,true);
	proxy:SetEventFlag(132,true);
	
	proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			if proxy:IsCompleteEvent(72) == false then				
				proxy:OnObjAnimEnd(70,1023,1,"OnEvent_70_1",once);
				proxy:SetEventFlag( 72 , true );
			else			
				proxy:OnObjAnimEnd(70,1023,2,"OnEvent_70_1",once);
				proxy:SetEventFlag( 72 , false );
			end
		proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	if Luafunc_PlaySynchroAnimation(proxy,param,ANIMEID_TURN_HANDLE) == true then		
		return;
	end
	proxy:WarpDmy(10000,1023,191);	
	print("OnEvent_70 end");
	
end

--�㉺�A�j�����ʏI��
function OnEvent_70_1(proxy,param)
	--�t���O�z�M�̓z�X�g�̂ݍs��
	if proxy:IsClient() == false then
		print("OnEvent_70_1 begin");
		proxy:LuaCallStart(70,1);
		print("OnEvent_70_1 end");
	end
end

--�t���O����
function OnEvent_70_flag(proxy,param)
	print("OnEvent_70_flag begin");
	if proxy:IsCompleteEvent(72) == false then
		--proxy:SetEventFlag(72,false);	--��ɂ���
		proxy:SetEventFlag(132,false);	--�����o�[�L��
	else
		--proxy:SetEventFlag(72,true);	--���ɂ���
		proxy:SetEventFlag(130,false);	--�ヌ�o�[�L��
	end
	print("OnEvent_70_flag end");
end


--------------------------------------------------------------------------------------
--��129����ɃG���x�[�^�[�Ăі߂���
--------------------------------------------------------------------------------------
function OnEvent_129(proxy,param)
	print("OnEvent_129 begin");
	--���ɏ�or�A�j����
	if proxy:IsCompleteEvent(130) == true then
		--�����҂����C���t�H
		if param:IsNetMessage() == false then
			--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\��
			--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010170, 1);
			--proxy:ShowGenDialog(10010170,1,1,true);
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010170, 0, 6, 1024, GEN_DIALOG_DIST, once );
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();
		end		
		print("flag 130 On");
		print("OnEvent_129 end");
		return;
	end	
	
	proxy:PlayAnimation(1024,1);
	if proxy:IsCompleteEvent(72) == false then
		proxy:PlayAnimation(1023,1);
	else
		proxy:PlayAnimation(1023,2);
	end
	--����ON���A�j����
	proxy:SetEventFlag(130,true);
	proxy:SetEventFlag(132,true);
	
	proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			if proxy:IsCompleteEvent(72) == false then
				proxy:OnObjAnimEnd(70,1023,1,"OnEvent_70_1",once);
				proxy:SetEventFlag( 72, true );
			else
				proxy:OnObjAnimEnd(70,1023,2,"OnEvent_70_1",once);
				proxy:SetEventFlag( 72, false );
			end
		proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	if Luafunc_PlaySynchroAnimation(proxy,param,ANIMEID_TURN_HANDLE) == true then		
		return;
	end	
	proxy:WarpDmy(10000,1024,191);		
	print("OnEvent_129 end");
end


--------------------------------------------------------------------------------------
--��131�����ɃG���x�[�^�[�Ăі߂���
--------------------------------------------------------------------------------------
function OnEvent_131(proxy,param)
	print("OnEvent_131 begin");
	--���ɉ�
	if proxy:IsCompleteEvent(132) == true then
		--�����҂����C���t�H
		if param:IsNetMessage() == false then
			--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\��
			--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010170, 1);
			--proxy:ShowGenDialog(10010170,1,1,true);
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010170, 0, 6, 1025, GEN_DIALOG_DIST, once );
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();
		end		
		print("flag 130 On");
		print("OnEvent_131 end");
		return;
	end
	
	proxy:PlayAnimation(1025,1);
	if proxy:IsCompleteEvent(72) == false then
		proxy:PlayAnimation(1023,1);
	else
		proxy:PlayAnimation(1023,2);
	end
	--����ON���A�j����
	proxy:SetEventFlag(130,true);
	proxy:SetEventFlag(132,true);	
	
	proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			if proxy:IsCompleteEvent(72) == false then
				proxy:OnObjAnimEnd(70,1023,1,"OnEvent_70_1",once);
				proxy:SetEventFlag( 72 , true );
			else
				proxy:OnObjAnimEnd(70,1023,2,"OnEvent_70_1",once);
				proxy:SetEventFlag( 72 , false );
			end
		proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	if Luafunc_PlaySynchroAnimation(proxy,param,ANIMEID_TURN_HANDLE) == true then		
		return;
	end	
	
	proxy:WarpDmy(10000,1025,191);		
	
	print("OnEvent_131 end");
end


--------------------------------------------------------------------------------------
--��128�����_���[�WON��
--------------------------------------------------------------------------------------
function OnEvent_128(proxy,param)	
	print("OnEvent_128 begin");
	if param:IsNetMessage() == true then
		return;
	end
	--proxy:SetEventSpecialEffect(10000,10050);
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4069 , "OnEvent_FireDamage1",0.0,0,FIREDOM_COUNT,once);
		FIREDOM_COUNT = FIREDOM_COUNT +1;
		if FIREDOM_COUNT > 10000 then
			FIREDOM_COUNT = 0;
		end
	proxy:NotNetMessage_end();
	IS_FIREAREA = true;
	print("OnEvent_128 end");
end

--------------------------------------------------------------------------------------
--��50���G���_���[�WON��
--------------------------------------------------------------------------------------
function OnEvent_50(proxy,param)	
	print("RegionIn Enemy :",param:GetParam2() );
	proxy:SetEventSpecialEffect(param:GetParam2(),10050);	
end

--------------------------------------------------------------------------------------
--��133�����_���[�WOFF��
--------------------------------------------------------------------------------------
function OnEvent_133(proxy,param)
	print("OnEvent_133 begin");
	if param:IsNetMessage() == true then
		return;
	end
	--proxy:EraseEventSpecialEffect(10000,10050);
	IS_FIREAREA = false;
	proxy:DeleteEvent( 4069 );
	print("OnEvent_133 end");
end

function OnEvent_FireDamage1(proxy,param)
	if IS_FIREAREA == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4069 , "OnEvent_FireDamage2",FIREDOM_TIME,0,FIREDOM_COUNT,once);
		proxy:NotNetMessage_end();
		proxy:CreateDamage_NoCollision(10320,400,10000,0,OFFSET,0);
		FIREDOM_COUNT = FIREDOM_COUNT +1;
		if FIREDOM_COUNT > 10000 then
			FIREDOM_COUNT = 0;
		end
	end
end

function OnEvent_FireDamage2(proxy,param)
	if IS_FIREAREA == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4069 , "OnEvent_FireDamage1",FIREDOM_TIME,0,FIREDOM_COUNT,once);
		proxy:NotNetMessage_end();
		proxy:CreateDamage_NoCollision(10320,400,10000,0,OFFSET,0);
		FIREDOM_COUNT = FIREDOM_COUNT +1;
		if FIREDOM_COUNT > 10000 then
			FIREDOM_COUNT = 0;
		end
	end
end

--------------------------------------------------------------------------------------
--��51���G���_���[�WOFF��
--------------------------------------------------------------------------------------
function OnEvent_51(proxy,param)	
	print("RegionOut Enemy :",param:GetParam2() );
	proxy:EraseEventSpecialEffect(param:GetParam2(),10050);	
end

--------------------------------------------------------------------------------------
--��142���b�艮�G�΁�
--------------------------------------------------------------------------------------
function OnEvent_142(proxy,param)
	print("OnEvent_142 begin");
	proxy:SetEventFlag(142,true);
	--�G�Ώ���
	proxy:EnableLogic(660, true);
	SetNpcStateFlag(proxy,param,SMITH_Flag_list,SMITH_ANGRY);
	proxy:SetTeamType( 660, TEAM_TYPE_AngryFriend );
	print("OnEvent_142 end");
end


--------------------------------------------------------------------------------------
--��143���b�艮���S��
--------------------------------------------------------------------------------------
function OnEvent_143(proxy,param)
	print("OnEvent_143 begin");
	proxy:SetEventFlag(143,true);
	SetNpcStateFlag(proxy,param,SMITH_Flag_list,SMITH_DEAD);
	print("OnEvent_143 end");
end

--------------------------------------------------------------------------------------
--��114���{�X�J�����؂�ւ��C�x���g��
--------------------------------------------------------------------------------------
function OnEvent_114(proxy,param)
	--print("OnEvent_114 begin");
	--�{�X������ł��Ȃ��@���@�{�X�Ƃ̐퓬���J�n���Ă���
	if proxy:IsCompleteEvent( 6174 ) == false and proxy:IsCompleteEvent( 113 ) == true then
		--�{�X��@�񃍃b�N�J����
		proxy:SetCamModeParamTargetId(6011);
		--�{�X��@���b�N�J����
		proxy:SetCamModeParamTargetIdForBossLock(6010);
	end
	--print("OnEvent_114 end");
end

------------------------------
--�z�΂̐��쎀�S�Ď�--
------------------------------
function OnEvent_171(proxy, param)
	print("OnEvent_171 begin");
	--���S�����t���O�𗧂Ă�
	proxy:SetEventFlag( 171, true );
		
	print("OnEvent_171 end");
end

--------------------------------------------------------------------------------------
--��H��ԊǗ���160
--------------------------------------------------------------------------------------
function OnEvent_160(proxy,param)
	print("OnEvent_160 begin");
		
	SetNpcStateFlag(proxy,param,SHOP_Flag_list,SHOP_NORMAL_1);
	proxy:SetEventFlag(160,true);

	print("OnEvent_160 end");
end

function OnEvent_160_1(proxy, param)
	print("OnEvent_160_1 begin");

	proxy:EnableLogic( 663 , true );
	proxy:EnableLogic( 676 , true );
	
	SetNpcStateFlag(proxy,param,SHOP_Flag_list,SHOP_HOSTILE_1);
	proxy:SetTeamType( 663, TEAM_TYPE_AngryFriend );
	proxy:SetTeamType( 676, TEAM_TYPE_AngryFriend );
	proxy:SetEventFlag(160,true);
	proxy:SetEventFlag(650,true);
	
	print("OnEvent_160_1 end");
end

--------------------------------------------------------------------------------------
--��H��ԊǗ���161
--------------------------------------------------------------------------------------

--��161����H���S��
function OnEvent_161(proxy, param)
	print("OnEvent_161 begin");

	--��H�̏�ԃt���O���u���S�v�ɂ���
	SetNpcStateFlag(proxy, param, SHOP_Flag_list, SHOP_DEAD );
	proxy:SetEventFlag( 161 , 1 );
	proxy:SetEventFlag( 651 , 1 );
	
	print("OnEvent_161 end");
end

--�`�F�b�N�|�C���g�ɓ������Ƃ��ɌĂ΂��n���h��

--��162���X�^�[�g�n�_�̃`�F�b�N�|�C���g��
function OnEvent_162(proxy,param)
	proxy:LuaCallStart( 164 , 1 ); 
end
--��163����w偂̕����̃`�F�b�N�|�C���g��
function OnEvent_163(proxy,param)
	proxy:LuaCallStart( 164 , 1 );
end
--��165���h���S���f�[�����̕����̃`�F�b�N�|�C���g��
function OnEvent_165(proxy,param)
	proxy:LuaCallStart( 164 , 1 );
end

--�z�M�p
function OnEvent_164(proxy,param)
print("OnEvent_164 begin");
	print("JustInCheckPoint");
	
	local SHOP_1_ID = 663;--�B���P��NPC��ID
	local SHOP_2_ID = 676;--�B���Q��NPC��ID
	
	local SHOPBlock1_acid_list = {160,161};--160���G�΁@--161�����S
	local SHOPBlock2_acid_list = {650,651};--650���G�΁@--651�����S
	
	--��U2�̂Ƃ�������
	InvalidCharactor(proxy,SHOP_1_ID);
	InvalidCharactor(proxy,SHOP_2_ID);
	
	--�u���b�N�̊Ď����폜
	DeleteConditionList(proxy,SHOPBlock1_acid_list);	
	DeleteConditionList(proxy,SHOPBlock2_acid_list);
	
	--��肠����������Ԃ�ݒ�
	SetFirstNpcStateFlag( proxy, param, SHOP_Flag_list, SHOP_NORMAL_1 );

	--�B���P�Ŕ̔���
	if proxy:IsCompleteEvent( SHOP_NORMAL_1 ) == true then
		print("SHOP NowState SHOP_NORMAL_1");
		SetSHOPState1(proxy,param);
		RegistConditionBlock1(proxy,param);
		
	--�B���P�œG��
	elseif proxy:IsCompleteEvent( SHOP_HOSTILE_1 ) == true then
		print("SHOP NowState SHOP_HOSTILE_1");
		SetSHOPState2(proxy,param);
		RegistConditionBlock1(proxy,param);
		
	--�B��(1��2)�Ŏ��S
	elseif proxy:IsCompleteEvent( SHOP_DEAD ) == true then
		print("SHOP NowState SHOP_DEAD");
		SetSHOPState3(proxy,param);
		
	--�B���Q�Ŕ̔���	
	elseif proxy:IsCompleteEvent( SHOP_NORMAL_2 ) == true then
		print("SHOP NowState SHOP_NORMAL_2");
		SetSHOPState4(proxy,param);
		RegistConditionBlock2(proxy,param);
		
	--�B���Q�œG��
	elseif proxy:IsCompleteEvent( SHOP_HOSTILE_2 ) == true then
		print("SHOP NowState SHOP_HOSTILE_2");
		SetSHOPState5(proxy,param);
		RegistConditionBlock2(proxy,param);
		
	else--��L�ȊO�̓�̏��
		print("SHOP NowState UnKnown");	
	end
	print("OnEvent_164 end");
end

--------------------------------------------------------------------------------------
--�B���P�Ŕ̔�����16410
--------------------------------------------------------------------------------------
function SetSHOPState1(proxy,param)

	--��w偂�����ł��Ȃ�
	if proxy:IsCompleteEvent( 6174 ) == false then
		ValidCharactor(proxy,663);--�B���P�ɂ����H�V���b�v��L����
		ValidCharactor(proxy,676);--�B��2�ɂ����H�V���b�v��L����		
	--��w偂�����ł���
	else
		print("SHOP NowState SHOP_NORMAL_1 > Chenge to SHOP_NORMAL_2");
		ValidCharactor(proxy,663);--�B���P�ɂ����H�V���b�v�𖳌���
		ValidCharactor(proxy,676);--�B��2�ɂ����H�V���b�v��L����
		--��Ԃ��ÍԂQ�ɂ���ɕύX
		SetNpcStateFlag( proxy, param, SHOP_Flag_list, SHOP_NORMAL_2 );
		
		--��Ԃ��ړ��������ׁA������x�X�V
		proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "OnEvent_164", 0.0, 0, 2, once );
	end
end

--------------------------------------------------------------------------------------
--�B���P�œG�΁�16411
--------------------------------------------------------------------------------------
function SetSHOPState2(proxy,param)
	ValidCharactor(proxy,663);--�B���P�ɂ����H�V���b�v��L����
	ValidCharactor(proxy,676);--�B��2�ɂ����H�V���b�v��L����

	proxy:SetTeamType( 663, TEAM_TYPE_AngryFriend );--�`�[���^�C�v�ύX
	proxy:SetTeamType( 676, TEAM_TYPE_AngryFriend );--�`�[���^�C�v�ύX
end

--------------------------------------------------------------------------------------
--�B��(1��2)�Ŏ��S��16412
--------------------------------------------------------------------------------------
function SetSHOPState3(proxy,param)
	InvalidBackRead(proxy,663);--�B���P�ɂ����H�V���b�v�𖳌���
	InvalidBackRead(proxy,676);--�B��2�ɂ����H�V���b�v�𖳌���
end

--------------------------------------------------------------------------------------
--�B���Q�Ŕ̔�����16413
--------------------------------------------------------------------------------------
function SetSHOPState4(proxy,param)	
	ValidCharactor(proxy,663);--�B���P�ɂ����H�V���b�v��L����
	ValidCharactor(proxy,676);--�B��2�ɂ����H�V���b�v��L����
end

--------------------------------------------------------------------------------------
--�B���Q�œG�΁�16414
--------------------------------------------------------------------------------------
function SetSHOPState5(proxy,param)
	ValidCharactor(proxy,663);--�B���P�ɂ����H�V���b�v��L����
	ValidCharactor(proxy,676);--�B��2�ɂ����H�V���b�v��L����

	proxy:SetTeamType( 676, TEAM_TYPE_AngryFriend );--�`�[���^�C�v�ύX
	proxy:SetTeamType( 663, TEAM_TYPE_AngryFriend );--�`�[���^�C�v�ύX
end


--------------------------------------------------------------------------------------
--���l�Í�1�Ď���
--------------------------------------------------------------------------------------
function RegistConditionBlock1(proxy,param)	
	--���l������ł��Ȃ�
	if proxy:IsCompleteEvent( SHOP_DEAD ) == false then
		--�ÍԂP�A�Q�œG�΂ɂȂ��Ă��Ȃ�
		if proxy:IsCompleteEvent( SHOP_HOSTILE_1 ) == false 
		and proxy:IsCompleteEvent( SHOP_HOSTILE_2 ) == false then			
			--�z�X�g����̃_���[�W�Ď�
			--��160����HNPC���G�ɂȂ遡
			--proxy:OnCharacterTotalDamage( 160, 663, 10000, SHOP_TOTALDAMAGE, "OnEvent_160_1", once );	
			proxy:OnCharacterTotalRateDamage( 160, 663, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_160_1", once );
			--��650����HNPC���G�ɂȂ遡
			--proxy:OnCharacterTotalDamage( 650, 676, 10000, SHOP_TOTALDAMAGE, "OnEvent_650_1", once );
			proxy:OnCharacterTotalRateDamage( 160, 676, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_650_1", once );			
		end
		--��161����HNPC���S��
		proxy:OnCharacterDead( 161 , 663 , "OnEvent_161" , once );			
		proxy:OnCharacterDead( 161 , 676 , "OnEvent_651" , once );			
	end
end

--------------------------------------------------------------------------------------
--���l�Í�2�Ď���
--------------------------------------------------------------------------------------
function RegistConditionBlock2(proxy,param)
	--���l������ł��Ȃ�
	if proxy:IsCompleteEvent( SHOP_DEAD ) == false then
		--�ÍԂP�A�Q�œG�΂ɂȂ��Ă��Ȃ�
		if proxy:IsCompleteEvent( SHOP_HOSTILE_1 ) == false
		and proxy:IsCompleteEvent( SHOP_HOSTILE_2 ) == false then
			--�z�X�g����̃_���[�W�Ď�
			--��160����HNPC���G�ɂȂ遡
			--proxy:OnCharacterTotalDamage( 160, 663, 10000, SHOP_TOTALDAMAGE, "OnEvent_160_1", once );		
			proxy:OnCharacterTotalRateDamage( 650, 663, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_160_1", once );
			--��650����HNPC���G�ɂȂ遡
			--proxy:OnCharacterTotalDamage( 650, 676, 10000, SHOP_TOTALDAMAGE, "OnEvent_650_1", once );
			proxy:OnCharacterTotalRateDamage( 650, 676, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_650_1", once );
		end
			--��651����HNPC���S��
			proxy:OnCharacterDead( 161 , 663 , "OnEvent_161" , once );			
			proxy:OnCharacterDead( 651 , 676 , "OnEvent_651" , once );		
	end
end


--------------------------------------------------------------------------------------
--�B���b�艮�ɃA�C�e����n����
--------------------------------------------------------------------------------------
function OnEvent_180(proxy,param)
	print("OnEvent_180 begin");
	
	if	proxy:IsCompleteEvent(180) == true then
		print("OnEvent_354 ���ɉ�b�C�x���g���I�����Ă��܂��B");
	end
	if proxy:RemoveInventoryEquip(TYPE_GOODS, 28) == true then
		print("OnEvent_354 RemoveInventoryEquip Succsess");
	else
		print("OnEvent_354 RemoveInventoryEquip Failed");
	end
	--proxy:GetRateItem( 10700 );
	proxy:SetEventFlag( 180, true );
	
	print("OnEvent_180 end");
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
--��190�`���}�O�}�����������C�x���g��
--------------------------------------------------------------------------------------
function YAMORI_FALL_DOWN( proxy, actionId, targetId,aniId)
	if proxy:IsCompleteEvent( actionId ) == false then
		print("OnEvent_",actionId," begin");
		proxy:PlayAnimation( targetId , aniId );
		proxy:SetSpStayAndDamageAnimId( targetId ,-1,-1);
		proxy:SetEventFlag( actionId,true );	
		print("OnEvent_",actionId," end");
	end
end

function YAMORI_WAIT(proxy , acrionId ,wait)
	if proxy:IsCompleteEvent( actionId ) == false then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2(acrionId,"OnEvent_"..acrionId.."_1",wait,0,0,once);
		proxy:NotNetMessage_end();
	end
end

function OnEvent_190(proxy,param) YAMORI_FALL_DOWN( proxy, 190, 370, 7010) end
function OnEvent_190_Dam(proxy,param) proxy:SetEventFlag( 190 , true ); end

--function OnEvent_191(proxy,param) YAMORI_WAIT(proxy,191,0.6) end
function OnEvent_191(proxy,param) YAMORI_FALL_DOWN( proxy, 191, 371, 7010) end
function OnEvent_191_Dam(proxy,param) proxy:SetEventFlag( 191 , true ); end

--function OnEvent_192(proxy,param) YAMORI_WAIT(proxy,192,0.4) end
function OnEvent_192(proxy,param) YAMORI_FALL_DOWN( proxy, 192, 372, 7010) end
function OnEvent_192_Dam(proxy,param) proxy:SetEventFlag( 192 , true ); end

--function OnEvent_193(proxy,param) YAMORI_WAIT(proxy,193,0.5) end
function OnEvent_193(proxy,param) YAMORI_FALL_DOWN( proxy, 193, 373, 2013) end
function OnEvent_193_Dam(proxy,param) proxy:SetEventFlag( 193 , true ); end

function OnEvent_194(proxy,param) YAMORI_FALL_DOWN( proxy, 194, 374, 2013) end
function OnEvent_194_Dam(proxy,param) proxy:SetEventFlag( 194 , true ); end

--function OnEvent_195(proxy,param) YAMORI_WAIT(proxy,195,0.5) end
function OnEvent_195(proxy,param) YAMORI_FALL_DOWN( proxy, 195, 375, 2013) end
function OnEvent_195_Dam(proxy,param) proxy:SetEventFlag( 195 , true ); end

--function OnEvent_196(proxy,param) YAMORI_WAIT(proxy,196,0.4) end
function OnEvent_196(proxy,param) YAMORI_FALL_DOWN( proxy, 196, 376, 2013) end
function OnEvent_196_Dam(proxy,param) proxy:SetEventFlag( 196 , true ); end

function OnEvent_200(proxy,param) YAMORI_FALL_DOWN( proxy, 200, 380, 2013) end
function OnEvent_200_Dam(proxy,param) proxy:SetEventFlag( 200 , true ); end

--function OnEvent_201(proxy,param) YAMORI_WAIT(proxy,201,0.5) end
function OnEvent_201(proxy,param) YAMORI_FALL_DOWN( proxy, 201, 381, 2013) end
function OnEvent_201_Dam(proxy,param) proxy:SetEventFlag( 201 , true ); end

--function OnEvent_202(proxy,param) YAMORI_WAIT(proxy,202,0.7) end
function OnEvent_202(proxy,param) YAMORI_FALL_DOWN( proxy, 202, 382, 2013) end
function OnEvent_202_Dam(proxy,param) proxy:SetEventFlag( 202 , true ); end

--function OnEvent_203(proxy,param) YAMORI_WAIT(proxy,203,0.4) end
function OnEvent_203(proxy,param) YAMORI_FALL_DOWN( proxy, 203, 383, 2013) end
function OnEvent_203_Dam(proxy,param) proxy:SetEventFlag( 203 , true ); end

function OnEvent_204(proxy,param) YAMORI_FALL_DOWN( proxy, 204, 384, 2013) end
function OnEvent_204_Dam(proxy,param) proxy:SetEventFlag( 204 , true ); end

--function OnEvent_205(proxy,param) YAMORI_WAIT(proxy,205,0.7) end
function OnEvent_205(proxy,param) YAMORI_FALL_DOWN( proxy, 205, 385, 2013) end
function OnEvent_205_Dam(proxy,param) proxy:SetEventFlag( 205 , true ); end


--------------------------------------------------------------------------------------
--��210���E���R�z�v���΁�
--------------------------------------------------------------------------------------
function OnEvent_210(proxy,param)
	if proxy:IsAlive( 391 ) == true then
		print("OnEvent_210 begin");
		--�E���R�z�v�̊◎�Ƃ��A�j��
		proxy:PlayAnimation( 391 , 7000 );		
		--MoveRegion(proxy, 391, 2171, 2 ,-1,false);
		proxy:Warp( 391 , 2171 );
		
		--���j�󃂃f���ɍ����ւ�
		proxy:ChangeModel( 1125 , 1 );
		--proxy:ChangeModel( 1126 , 1 );
		--proxy:ChangeModel( 1127 , 1 );
		
		proxy:PlayTypeSE( 1125, SOUND_TYPE_O, 513005140 );
		--proxy:PlayTypeSE( 1126, SOUND_TYPE_O, 513005140 );
		--proxy:PlayTypeSE( 1127, SOUND_TYPE_O, 513005140 );
		
		--1�b��ł��炵�āA�J�n����ɕt�߂̃}�b�v�p�[�c�ɓ�����̂�h��
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 210, "OnEvent_210_1", 3.0, 0, 1, once );	
		proxy:NotNetMessage_end();
		
		print("OnEvent_210 end");
	end		
end

function OnEvent_210_1(proxy,param)
	print("OnEvent_210_1 begin");
	--������_���[�W��
	local paramid = 10120; --������_���[�W
	local rad    = 1.7;--���a(���ƂŁA�����Ȓl�ɂȂ�͂�������͓K��)
	local time   = 2; --�ЂƂ܂��A�j���Đ��I���Ń_���[�W�������̂ŁA�A�j����蒷�����Ԃ��w�肵�Ă���
	--��1125_hit����1�����������Ƃ���	
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 210, 1125, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_210_1125hit", once );
		--��1126_hit����1�����������Ƃ���	
		--proxy:OnObjectDamageHit( 210, 1126, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_210_1126hit", once );
	
		proxy:OnKeyTime2( 210, "OnEvent_210_bloken", time, 0, 2, once );
		
		proxy:OnKeyTime2( 210, "OnEvent_210_Run", 4.0 ,1,0,once );
	proxy:NotNetMessage_end();	
	print("OnEvent_210_1 end");
end

--��1125�������ɓ�������
function OnEvent_210_1125hit(proxy,param)
	print("OnEvent_210_1125hit begin");	
	--�}�g���N�X�ړ��A���f�������ւ�<2>�A�����x�A�����C���X�^���X����
	SecondStageBreak(proxy, 1125, 2 );	
	proxy:PlayTypeSE( 1125 , SOUND_TYPE_O , 619000000 );
	print("OnEvent_210_1125hit end");
end

function OnEvent_210_Run(proxy,param)
	proxy:PlayAnimation( 391 , 500 );
end
--[[
--��1126�������ɓ�������
function OnEvent_210_1126hit(proxy,param)
	print("OnEvent_210_1126hit begin");	
	--�}�g���N�X�ړ��A���f�������ւ�<2>�A�����x�A�����C���X�^���X����
	SecondStageBreak(proxy, 1126, 2 );	
	print("OnEvent_210_1126hit end");
end
]]

--[[
--��1127�������ɓ�������
function OnEvent_210_1127hit(proxy,param)
	print("OnEvent_210_1127hit begin");	
	--�}�g���N�X�ړ��A���f�������ւ�<2>�A�����x�A�����C���X�^���X����
	SecondStageBreak(proxy, 1127, 2 );	
	print("OnEvent_210_1127hit end");
end
]]

--��莞�Ԃ��������̂Ń��W�b�h�𔲂�
function OnEvent_210_bloken(proxy,param)
	print("OnEvent_210_bloken begin");	
	proxy:SetBrokenPiece(1125);
	--proxy:SetBrokenPiece(1126);
	--proxy:SetBrokenPiece(1127);		
	--�t���O���Z�b�g
	proxy:SetEventFlag( 210 , true );	
	print("OnEvent_210_bloken end");
end


--------------------------------------------------------------------------------------
--��185������яo���C�x���g��
--------------------------------------------------------------------------------------
--�C�x���g�̈�ɓ�����
function OnEvent_185(proxy,param)
	if proxy:IsCompleteEvent( 185 ) == false then
		print("OnEvent_185 begin");
		--OBJ���C�x���g�j��
		proxy:ChangeModel( 1120 ,1 );
		proxy:SetFirstSpeedPlus( 1120 , 2, 3.5  ,6 , 1);
		proxy:SetBrokenPiece( 1120 );
		proxy:PlayTypeSE( 1120 , SOUND_TYPE_O , 624400000 );
		
		--��яo���A�j��
		proxy:PlayAnimation( 390 , 3302 );
		proxy:EnableLogic( 390 , true );
		proxy:EnableLogic( 392 , true );
		proxy:EnableLogic( 393 , true );
		proxy:SetEventFlag( 185 ,true );
		print("OnEvent_185 end");
	end
end

--�C�x���g�����O��OBJ���j�󂳂ꂽ
function OnEvent_186(proxy,param)
	if proxy:IsCompleteEvent( 185 ) == false then
		print("OnEvent_186 begin");
		proxy:EnableLogic( 390 , true );
		proxy:EnableLogic( 392 , true );
		proxy:EnableLogic( 393 , true );
		proxy:SetEventFlag( 185 ,true );		
		print("OnEvent_186 end");
	end
end


--------------------------------------------------------------------------------------
--��187����������遡
--------------------------------------------------------------------------------------
function OnEvent_187(proxy,param)
	if proxy:IsDestroyed( 1121 ) == false then
		print("OnEvent_187 begin");		
		proxy:ChangeModel( 1121 , 1 );
		proxy:SetBrokenPiece( 1121 );
		proxy:PlayTypeSE( 1121 , SOUND_TYPE_O , 618000000 );
		print("OnEvent_187 end");		
	end
	proxy:SetEventFlag( 187 , true );
end

--------------------------------------------------------------------------------------
--��189�����������2��
--------------------------------------------------------------------------------------
function OnEvent_189(proxy,param)
	print("OnEvent_189 begin");
	proxy:SetEventFlag( 189 , true );
	proxy:PlayAnimation( 1123, 1);	
	--proxy:PlayTypeSE( 1123 , SOUND_TYPE_O , 618000000 );
	print("OnEvent_189 end");
end

--[[
--------------------------------------------------------------------------------------
--��188���݂邳�ꂽ�󎀑́�
--------------------------------------------------------------------------------------
function OnEvent_188(proxy,param)
	print("OnEvent_188 begin");
	
	if param:IsNetMessage() == true then
		--��M�҂͒ނ��Ă���OBJ��j�󂵂Ă���
		proxy:ChangeModel( 1122 , 1);
	end
	
	proxy:PlayAnimation( 10286 , 30 );--���̗̂����A�j�����I��
	
	proxy:NotNetMessage_begin();
		proxy:OnCharacterAnimEnd( 1122 , 10286 , 30 , "OnEvent_188_1",once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 188 , true );
	
	print("OnEvent_188 end");
end

--���̂̃A�j���I��
function OnEvent_188_1(proxy,param)
	print("OnEvent_188_1 begin");
	
	proxy:EnableObjTreasure( 10286 , true );
	
	print("OnEvent_188_1 end");
end
]]

--------------------------------------------------------------------------------------
--��220�`225�������^����
--------------------------------------------------------------------------------------
function TaruBakuhatu(proxy, actionId, ObjId)
	print("OnEvent_",actionId," begin");
	proxy:CastPointSpell( 400 , ObjId , 10130 , 0,0,0);
	proxy:SetEventFlag( actionId, true );
	print("OnEvent_",actionId," end");
end

function OnEvent_220( proxy,param) TaruBakuhatu(proxy,220,1130) end
function OnEvent_221( proxy,param) TaruBakuhatu(proxy,221,1131) end
function OnEvent_222( proxy,param) TaruBakuhatu(proxy,222,1132) end
function OnEvent_223( proxy,param) TaruBakuhatu(proxy,223,1133) end
function OnEvent_224( proxy,param) TaruBakuhatu(proxy,224,1134) end
function OnEvent_225( proxy,param) TaruBakuhatu(proxy,225,1135) end
function OnEvent_226( proxy,param) TaruBakuhatu(proxy,226,1136) end
function OnEvent_227( proxy,param) TaruBakuhatu(proxy,227,1137) end
function OnEvent_228( proxy,param) TaruBakuhatu(proxy,228,1138) end
function OnEvent_229( proxy,param) TaruBakuhatu(proxy,229,1139) end

function OnEvent_233( proxy,param) TaruBakuhatu(proxy,233,1140) end
function OnEvent_234( proxy,param) TaruBakuhatu(proxy,234,1141) end
function OnEvent_235( proxy,param) TaruBakuhatu(proxy,235,1142) end
function OnEvent_236( proxy,param) TaruBakuhatu(proxy,236,1143) end
function OnEvent_237( proxy,param) TaruBakuhatu(proxy,237,1144) end
function OnEvent_238( proxy,param) TaruBakuhatu(proxy,238,1145) end
function OnEvent_239( proxy,param) TaruBakuhatu(proxy,239,1146) end
function OnEvent_240( proxy,param) TaruBakuhatu(proxy,240,1147) end
function OnEvent_241( proxy,param) TaruBakuhatu(proxy,241,1148) end
function OnEvent_242( proxy,param) TaruBakuhatu(proxy,242,1149) end
function OnEvent_243( proxy,param) TaruBakuhatu(proxy,243,1150) end
function OnEvent_244( proxy,param) TaruBakuhatu(proxy,244,1151) end
function OnEvent_245( proxy,param) TaruBakuhatu(proxy,245,1152) end
function OnEvent_246( proxy,param) TaruBakuhatu(proxy,246,1153) end
function OnEvent_247( proxy,param) TaruBakuhatu(proxy,247,1154) end
function OnEvent_248( proxy,param) TaruBakuhatu(proxy,248,1155) end

function OnEvent_250( proxy,param) TaruBakuhatu(proxy,250,1156) end
function OnEvent_251( proxy,param) TaruBakuhatu(proxy,251,1157) end
function OnEvent_252( proxy,param) TaruBakuhatu(proxy,252,1158) end
function OnEvent_253( proxy,param) TaruBakuhatu(proxy,253,1159) end


--------------------------------------------------------------------------------------
--��230�����낱�z�v�U��1��
--------------------------------------------------------------------------------------
function OnEvent_230(proxy,param)
	print("OnEvent_230 begin");	
	proxy:PlayAnimation( 394 , 3000 );
	proxy:EnableLogic( 394 , true );
	proxy:SetEventFlag( 230 , true );
	print("OnEvent_230 end");
end

--------------------------------------------------------------------------------------
--��231�����낱�z�v�U��2��
--------------------------------------------------------------------------------------
function OnEvent_231(proxy,param)
	print("OnEvent_231 begin");
	proxy:PlayAnimation( 395 , 3000 );
	proxy:EnableLogic( 395 , true );
	proxy:SetEventFlag( 231 , true );
	print("OnEvent_231 end");
end

--------------------------------------------------------------------------------------
--��232�����낱�z�v�U��3��
--------------------------------------------------------------------------------------
function OnEvent_232(proxy,param)
	print("OnEvent_232 begin");
	proxy:PlayAnimation( 396 , 3000 );
	proxy:EnableLogic( 396 , true );
	proxy:SetEventFlag( 232 , true );
	print("OnEvent_232 end");
end


--------------------------------------------------------------------------------------
--��249�����������@������
--------------------------------------------------------------------------------------
function OnEvent_249(proxy,param)
	print("OnEvent_249 begin");
	proxy:PlayAnimation(397,3304);
	proxy:SetEventFlag(249,true);
	print("OnEvent_249 end");
end



-----------------------------------------------------------------------------
--���������g�J�Q�C�x���g
-----------------------------------------------------------------------------
--�{�X���j���̃g�J�Q���Z�b�g�p
function ResetTokage(proxy)
	print("ResetTokage");
--~ 	proxy:SetEventFlag(260,false);	
--~ 	proxy:SetEventFlag(262,false);
--~ 	proxy:SetEventFlag(750,false);
--~ 	proxy:SetEventFlag(752,false);
--~ 	proxy:SetEventFlag(754,false);
--~ 	proxy:SetEventFlag(756,false);
--~ 	proxy:SetEventFlag(758,false);
--~ 	proxy:SetEventFlag(760,false);
--~ 	proxy:SetEventFlag(762,false);
--~ 	proxy:SetEventFlag(764,false);
--~ 	proxy:SetEventFlag(766,false);	
--~ 	proxy:SetEventFlag(768,false);
--~ 	proxy:SetEventFlag(770,false);
--~ 	proxy:SetEventFlag(772,false);	
--~ 	proxy:SetEventFlag(774,false);
--~ 	proxy:SetEventFlag(776,false);
--~ 	proxy:SetEventFlag(778,false);
--~ 	proxy:SetEventFlag(780,false);
--~ 	proxy:SetEventFlag(782,false);
--~ 	proxy:SetEventFlag(784,false);
--~ 	proxy:SetEventFlag(786,false);
--~ 	proxy:SetEventFlag(788,false);
--~ 	proxy:SetEventFlag(1200,false);
--~ 	proxy:SetEventFlag(1202,false);	
	AddEventCounter(proxy,18);
	AddEventCounter(proxy,19);
	AddEventCounter(proxy,20);
	AddEventCounter(proxy,21);
	AddEventCounter(proxy,22);
	AddEventCounter(proxy,23);
	AddEventCounter(proxy,24);
	AddEventCounter(proxy,25);
	AddEventCounter(proxy,26);
	AddEventCounter(proxy,27);
	AddEventCounter(proxy,28);
	AddEventCounter(proxy,29);
	AddEventCounter(proxy,30);
	AddEventCounter(proxy,31);
	AddEventCounter(proxy,32);
	AddEventCounter(proxy,33);
	AddEventCounter(proxy,34);
	AddEventCounter(proxy,35);
	AddEventCounter(proxy,36);
	AddEventCounter(proxy,37);
	AddEventCounter(proxy,38);
	AddEventCounter(proxy,39);
	AddEventCounter(proxy,40);
	AddEventCounter(proxy,41);
end

function TokageEvent(proxy,eventId)
	print("OnEvent_",eventId," begin");
	proxy:SetEventFlag( eventId, true);
	proxy:DeleteEvent( eventId );
	print("OnEvent_",eventId," end");
end

-----------------------------------------------------------------------------
--��260�������g�J�Q�C�x���g1
-----------------------------------------------------------------------------
function OnEvent_260(proxy,param) TokageEvent(proxy,260); end
function OnEvent_262(proxy,param) TokageEvent(proxy,262); end
function OnEvent_750(proxy,param) TokageEvent(proxy,750); end
function OnEvent_752(proxy,param) TokageEvent(proxy,752); end
function OnEvent_754(proxy,param) TokageEvent(proxy,754); end
function OnEvent_756(proxy,param) TokageEvent(proxy,756); end
function OnEvent_758(proxy,param) TokageEvent(proxy,758); end
function OnEvent_760(proxy,param) TokageEvent(proxy,760); end
function OnEvent_762(proxy,param) TokageEvent(proxy,762); end
function OnEvent_764(proxy,param) TokageEvent(proxy,764); end
function OnEvent_766(proxy,param) TokageEvent(proxy,766); end
function OnEvent_768(proxy,param) TokageEvent(proxy,768); end
function OnEvent_770(proxy,param) TokageEvent(proxy,770); end
function OnEvent_772(proxy,param) TokageEvent(proxy,772); end
function OnEvent_774(proxy,param) TokageEvent(proxy,774); end
function OnEvent_776(proxy,param) TokageEvent(proxy,776); end
function OnEvent_778(proxy,param) TokageEvent(proxy,778); end
function OnEvent_780(proxy,param) TokageEvent(proxy,780); end
function OnEvent_782(proxy,param) TokageEvent(proxy,782); end
function OnEvent_784(proxy,param) TokageEvent(proxy,784); end
function OnEvent_786(proxy,param)
	--���̃g�J�Q���������������������Ď��˂Ȃ���������̂�
	proxy:SetAlwayEnableBackread_forEvent( 416 , false );	
	LuaFunc_NormalOmission(proxy,416);
	TokageEvent(proxy,786); 
end
function OnEvent_788(proxy,param) TokageEvent(proxy,788); end
function OnEvent_1200(proxy,param) TokageEvent(proxy,1200); end
function OnEvent_1202(proxy,param) TokageEvent(proxy,1202); end



-----------------------------------------------------------------------------
--��270������SFX�̈�ɓ�����
-----------------------------------------------------------------------------
function OnEvent_270(proxy,param)
	if proxy:IsCompleteEvent( 270 ) == false then	
		print("OnEvent_270 begin");
		proxy:CreateCamSfx( 96000 , 0 );
		proxy:SetEventFlag( 270 , true );
		print("OnEvent_270 end");
	end
end


-----------------------------------------------------------------------------
--��271������SFX�̈悩��o��
-----------------------------------------------------------------------------
function OnEvent_271(proxy,param)
	--2300,2301,2302�ǂ��ɂ������Ă��Ȃ�
	if 	proxy:IsRegionIn( 10000, 2300 ) == false and
		proxy:IsRegionIn( 10000, 2301 ) == false and
		proxy:IsRegionIn( 10000, 2302 ) == false then	
		print("OnEvent_271 begin");
		proxy:SetEventFlag( 270, false );
		proxy:DeleteCamSfx( 0 );
		print("OnEvent_271 end");
	end
end


--�܃E���R�z�v�֘A�̊Ď��o�^�ƍČ�
function Regist_FukuroKoufu(proxy,eneId,deadId,corpseId,initId)
--��corpseId�����̂𒲂ׂĂȂ���
	if proxy:IsCompleteEvent( corpseId ) == false then
		proxy:AddCorpseEvent( corpseId , eneId );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( corpseId , 0 , "OnEvent_Corpse",once);
		proxy:NotNetMessage_end();
	end
	
--��deadId�����S�Ď���
	if proxy:IsCompleteEvent(deadId) == false then	--���S���ĂȂ��Ȃ�
	   --���S�Ď��ǉ�
		proxy:OnCharacterDead( deadId, eneId, "OnEvent_KoufuDead", once );
	end
--���Č���
	if proxy:IsCompleteEvent(deadId) == true then	--����ł���				
		if	proxy:IsCompleteEvent( corpseId ) == false then--�A�C�e���E���ĂȂ�
			--�󎀑̂��Č�
			proxy:OpeningDeadPlus( eneId , true ,false ,false );			
		else
			--������
			InvalidBackRead(proxy, eneId);
		end
		proxy:SetEventFlag( initId , true );
	end
end

--�܃E���R�z�v�𒲂ׂ����̃C�x���g
function OnEvent_Corpse(proxy,param)
	local eventId = param:GetParam1();
	print("OnEvent_Corpse ",eventId," begin");
	proxy:SetEventFlag( eventId , true );
	print("OnEvent_Corpse ",eventId," end");
end

--�܃E���R�z�v�����񂾎��̃C�x���g
function OnEvent_KoufuDead(proxy,param)
	local eventId = param:GetParam1();
	print("OnEvent_KoufuDead ",eventId," begin");
	proxy:SetEventFlag( eventId , true );
	print("OnEvent_KoufuDead ",eventId," end");
end


--�GA�ɑ΂���enelist�̃L�������������ɓ����Ă��邩�̃`�F�b�N
function LuaFuncDistCheck(proxy,eneId)
	local ret = false;
	local num = table.getn( DISTENELIST );
	if proxy:IsAlive( eneId ) == true then
		for index = 1, num , 1 do				
			if proxy:IsAlive( DISTENELIST[index] ) == true  and proxy:IsDistance( eneId , DISTENELIST[index] , IWAKOUFU_DIST ) == true then
				ret = true;
				break;
			end
		end
	end
	
	--�N�������Ă���z�������Ă���Ζ���ID10�𑗂�
	if ret == true then
		proxy:SendEventRequest( eneId , 0 , 10 );
	else
		proxy:SendEventRequest( eneId , 0 , -1 );
	end
end

--local actlist = {300,301,302,303,304,305,306,307};
--local actlist = {308,309,310,311,312,313,314,315};
--DISTENELIST--�O���[�o����`

function OnEvent_300_In(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_300_Out(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_300_Dead(proxy,param) LuaFuncDistCheck(proxy,216); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_301_In(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_301_Out(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_301_Dead(proxy,param) LuaFuncDistCheck(proxy,216); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_302_In(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_302_Out(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_302_Dead(proxy,param) LuaFuncDistCheck(proxy,216); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_303_In(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_303_Out(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_303_Dead(proxy,param) LuaFuncDistCheck(proxy,216); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_304_In(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_304_Out(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_304_Dead(proxy,param) LuaFuncDistCheck(proxy,216); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_305_In(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_305_Out(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_305_Dead(proxy,param) LuaFuncDistCheck(proxy,216); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_306_In(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_306_Out(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_306_Dead(proxy,param) LuaFuncDistCheck(proxy,216); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_307_In(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_307_Out(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_307_Dead(proxy,param) LuaFuncDistCheck(proxy,216); proxy:DeleteEvent( param:GetParam1() ); end



function OnEvent_308_In(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_308_Out(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_308_Dead(proxy,param) LuaFuncDistCheck(proxy,218); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_309_In(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_309_Out(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_309_Dead(proxy,param) LuaFuncDistCheck(proxy,218); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_310_In(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_310_Out(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_310_Dead(proxy,param) LuaFuncDistCheck(proxy,218); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_311_In(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_311_Out(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_311_Dead(proxy,param) LuaFuncDistCheck(proxy,218); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_312_In(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_312_Out(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_312_Dead(proxy,param) LuaFuncDistCheck(proxy,218); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_313_In(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_313_Out(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_313_Dead(proxy,param) LuaFuncDistCheck(proxy,218); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_314_In(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_314_Out(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_314_Dead(proxy,param) LuaFuncDistCheck(proxy,218); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_315_In(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_315_Out(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_315_Dead(proxy,param) LuaFuncDistCheck(proxy,218); proxy:DeleteEvent( param:GetParam1() ); end


--~ function test(proxy,param)
--~ 	proxy:OnKeyTime2( 8000 , "test2",0.5,0,COUNT,once);
--~ 	COUNT = COUNT +1;
--~ 	proxy:CreateDamage_NoCollision(10320,400,10000,0,-0.5,0);
--~ end

--~ function test2(proxy,param)
--~ 	proxy:OnKeyTime2( 8000 , "test",0.5,0,COUNT,once);
--~ 	COUNT = COUNT +1;
--~ 	proxy:CreateDamage_NoCollision(10320,400,10000,0,-0.5,0);
--~ end
