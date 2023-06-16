
------------------------------------------------
--�����g�J�Q�o��������QWC�l�̍ő�A�ŏ��l�̒萔
------------------------------------------------
--62_300
QWC01_MIN = 200;	--�ŏ��l
QWC01_MAX = 300;	--�ő�l
--62_301
QWC02_MIN = 000;	--�ŏ��l
QWC02_MAX = 100;	--�ő�l
--62_302
QWC03_MIN = 100;	--�ŏ��l
QWC03_MAX = 200;	--�ő�l


------------------------------------------------
--�n�[�t�n���h�o��������QWC�l�̍ő�A�ŏ��l�̒萔
------------------------------------------------
--62_202
HALF_QWC01 = 0;
HALF_QWC02 = 0;

--���n�[�t�n���h�̏�Ԉꗗ

HALF_STATE_WAIT_KOUDOU     = 16160;--�B���ő҂�
HALF_STATE_WAIT_SEKITYU    = 16161;--�Β��ő҂�
HALF_STATE_HOSTILE_KOUDOU  = 16162;--�G��(�B��)
HALF_STATE_HOSTILE_SEKITYU = 16163;--�G��(�Β�)
HALF_STATE_DEAD            = 16164;--���S
HALF_STATE_GO_TO_SEKITYU   = 16165;--�Β��֍s������

half_flag_list = {

	HALF_STATE_WAIT_KOUDOU     ,
	HALF_STATE_WAIT_SEKITYU    ,
	HALF_STATE_HOSTILE_KOUDOU  ,
	HALF_STATE_HOSTILE_SEKITYU ,
	HALF_STATE_DEAD            ,
	HALF_STATE_GO_TO_SEKITYU
};

--�~�σ_���[�W
HALF_TOTALDAMAGE = 50;

--���o�b�`�i�E�B�X�j�̏�Ԉꗗ

--[[

	event_define.lua�ɋL�q

	]]

--��~�~�Y��������
PROTROCKWORM_DIST = 5.0;
ROCKWORM1_DIST = 4.0;
ROCKWORM2_DIST = 4.0;
ROCKWORM3_DIST = 4.0;
ROCKWORM4_DIST = 4.0;
ROCKWORM5_DIST = 4.0;
ROCKWORM6_DIST = 4.0;
ROCKWORM7_DIST = 4.0;

--��~�~�Y�_���[�W�{��
ROCKWORM_DAMAGE_RATE = 9;

--�E�B�X�v��������
WISP1_DIST = 2.0;
WISP2_DIST = 2.0;
WISP3_DIST = 2.0;
WISP4_DIST = 1.5;
WISP5_DIST = 1.0;

--[[�V���b�v��H�Q
SHOP02_NORMAL  = 16450;--�̔���
SHOP02_HOSTILE = 16451;--�G��
SHOP02_DEAD	   = 16452;--���S

SHOP02_Flag_list = {
	SHOP02_NORMAL,
	SHOP02_HOSTILE,
	SHOP02_DEAD
}

SHOP02_TOTALDAMAGE = 50;
]]


FIREDOM_COUNT2 = 0;
FIREDOM_COUNT3 = 0;

FIREDOM_TIME2 = 0.2;
FIREDOM_TIME3 = 0.2;

IS_FIREAREA2 = false;
IS_FIREAREA3 = false;

OFFSET2 = -2;
OFFSET3 = -2;

--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉����������
--------------------------------------------------------------------------------------
function Initialize_m06_01_00_00(proxy)
	print("Initialize m06_01_00_00 begin");
-----------------------------------------------------------------------------------------
--�{�X�֘A
-----------------------------------------------------------------------------------------
--��520���{�X�����ɓ��遡
	--���{�X�������Ă���Ƃ������C�x���g�o�^
	if proxy:IsCompleteEvent( 6272 ) == false then
	
		--�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B
		SingleReset(proxy, 520);
	
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���)
		proxy:LuaCall( 521, 1, "OnEvent_521_1", everytime );
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCall( 521 , 5 , "OnEvent_520_GO_TO_IN" , everytime );
		--���t���O�Z�b�g(�����p)
		proxy:LuaCall( 521 , 6 , "OnEvent_520_flag_set" , everytime );
		
		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ�
		if proxy:IsCompleteEvent( 520 ) == false then
			
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l����
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--��520�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegionAttribute( 520, 2894, "OnEvent_520", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B
			
			proxy:NotNetMessage_begin();
				--��521�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegion( 521, 2894, "OnEvent_520", HELPID_GO_TO_IN, everytime );--�n���h���͏�Ɠ���
			proxy:NotNetMessage_end();
		end
	end


--��522�����{�X�o�����o(��C��)��
	--�{�X�����Ă���
	if proxy:IsCompleteEvent( 6272 ) == false then
		--�|�����I����ĂȂ�
		if proxy:IsCompleteEvent(522) == false then
			proxy:OnRegionIn(522,10000,2898,"OnEvent_522",once);
			proxy:NotNetMessage_begin();
				--�|�����J�n�ɌĂ΂��n���h��
				proxy:LuaCall(522, REMO_START, "OnEvent_522_RemoStart", once);
				--�|�����I����ɌĂ΂��n���h��(�g���K�[�N�������l�p)
				proxy:LuaCall(522, REMO_FINISH, "OnEvent_522_RemoFinish", once);
			proxy:NotNetMessage_end();
			proxy:SetColiEnable( 1281, false );
			proxy:SetDrawEnable( 1281, false );
		else
			proxy:SetColiEnable( 1280, false );
			proxy:SetDrawEnable( 1280, false );
			proxy:SetEventFlag( 524 , true );
		end
	end
	
--��523���{�X�퓬�J�n��	
	if proxy:IsCompleteEvent( 6272 ) == false then
		--�V���O�����[�h��������
		SingleReset( proxy , 523 );
		proxy:OnRegionIn( 523 , 10000 , 2886 , "OnEvent_523" , everytime );
	end
	
--��6272�����{�X���S�Ŕ����J����
	proxy:AddFieldInsFilter( 811 );
	if proxy:IsCompleteEvent( 6272 ) == false then
		proxy:OnCharacterDead( 6272 , 811 , "OnEvent_6272" , once );
	end

--���{�X�֘A�̏���������(��C��)
	if proxy:IsCompleteEvent( 6272 ) ==true then
		
		--���{�X����ł���Ƃ�
		--�{�X���Ȃ��Ȃ�
		InvalidBackRead( proxy , 811 );
		
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
		if proxy:IsCompleteEvent( 6283 ) == false then
			--SFX ON
			proxy:ValidSfx( 2250 );--���̗��q
			proxy:ValidSfx( 2251 );--�v�΂̃I�[��			
			proxy:OnDistanceActionAttribute( 6283 , 10000 , 1981 , "OnEvent_6283" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--SFX��������
			proxy:InvalidSfx( 2250 , false );--���̗��q
			--proxy:InvalidSfx( 2251 , false );--�v�΂̃I�[��
			--���v�΂Ń��[�v�p�̊Ď���ǉ���
			SingleReset(proxy,6284);
			proxy:OnDistanceActionAttribute( 6284 , 10000 , 1981 , "OnEvent_6284" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
		
	else
		--���{�X�����Ă���Ƃ�
	
		
		if proxy:IsCompleteEvent(522) == false then
			--proxy:SetDrawEnable( 811, false );
			InvalidCharactor( proxy,811 );
		end
		
		--���W�b�NOFF�őҋ@
		proxy:EnableLogic( 811 , false );
		
		--PT�g��łȂ����͏��������܂�
		SingleReset(proxy,6274);
		SingleReset(proxy,6275);			
		
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
		
		--��(�\�E��?)
		proxy:SetDrawEnable( 1981 , false );
		proxy:SetColiEnable( 1981 , false );
		--�\�E���Ɏh��������������
		proxy:SetDrawEnable( 1976 , false );
		proxy:SetColiEnable( 1976 , false );
	
		--SFX��������
		proxy:InvalidSfx( 2250 , false );--���̗��q
		proxy:InvalidSfx( 2251 , false );--�v�΂̃I�[��

	end	
	
-----------------------------------------------------------------------------------------
--�M�~�b�N�֘A
-----------------------------------------------------------------------------------------
--��573���n���h���񂵂ăt���A�ړ����遡
	proxy:SetIsAnimPauseOnRemoPlayForEvent(1243,true);
	proxy:OnPlayerActionInRegionAngle(573,2223,"OnEvent_573",60,HELPID_TURN_HANDLE,everytime);
	--�t���O�����p
	proxy:LuaCall(573,1,"OnEvent_573_flag",everytime);
	--574��ON���G���x�[�^�[�͉�
	--PT��576,578�Ɋւ��Ă͂Ƃ肠���������ɂ܂�����
	if proxy:IsCompleteEvent(574) == true then
		proxy:EndAnimation(1243,1);
		if proxy:IsClient() == false then		
			proxy:SetEventFlag(576,false);
			proxy:SetEventFlag(578,true);
		end
	else
		if proxy:IsClient() == false then
			proxy:SetEventFlag(576,true);
			proxy:SetEventFlag(578,false);			
		end
	end

--��575���G���x�[�^�[���Ăԃn���h����
	proxy:OnDistanceAction(575,10000,1244,"OnEvent_575",1.5,HELPID_TURN_HANDLE,270,60,everytime);
--��577���G���x�[�^�[���Ăԃn���h����
	proxy:OnDistanceAction(577,10000,1245,"OnEvent_577",1.5,HELPID_TURN_HANDLE,270,60,everytime);

--��579���_���[�W���ɓ�������	
	proxy:OnRegionJustIn(579,10000,2224,"OnEvent_579",everytime);
	
--��580���_���[�W������o����	
	proxy:OnRegionJustOut(580,10000,2224,"OnEvent_580",everytime);		

-- �{�X�������ɂ�������Ƃ����A�^������������ ��U�R�����g�A�E�g(����m�F�ς݂ł�)
-- �����i2008/10/24 �k��j

--��583���{�X�����_���[�W���ɓ�������	
	proxy:OnRegionJustIn(583,10000,2225,"OnEvent_583",everytime);

--��584���{�X�����_���[�W������o����	
	proxy:OnRegionJustOut(584,10000,2225,"OnEvent_584",everytime);		


--��585���͂���1�~��遡
	proxy:OnActionEventRegion(585, 2226, "OnEvent_585", LadderAngle_A, HELPID_DOWN, everytime);
--��586���͂���1���遡
	proxy:OnActionEventRegion(586, 2227, "OnEvent_586", LadderAngle_A, HELPID_UP,   everytime);

--��587���͂���2�~��遡
	proxy:OnActionEventRegion(587, 2228, "OnEvent_587", LadderAngle_A, HELPID_DOWN, everytime);
--��588���͂���2���遡
	proxy:OnActionEventRegion(588, 2229, "OnEvent_588", LadderAngle_A, HELPID_UP,   everytime);

--��589���͂���3�~��遡
	proxy:OnActionEventRegion(589, 2230, "OnEvent_589", LadderAngle_A, HELPID_DOWN, everytime);
--��590���͂���3���遡
	proxy:OnActionEventRegion(590, 2231, "OnEvent_590", LadderAngle_A, HELPID_UP,   everytime);

--��591���͂���4�~��遡
	proxy:OnActionEventRegion(591, 2232, "OnEvent_591", LadderAngle_A, HELPID_DOWN, everytime);
--��592���͂���4���遡
	proxy:OnActionEventRegion(592, 2233, "OnEvent_592", LadderAngle_A, HELPID_UP,   everytime);


--��570�����̕ǁ�
--[[
	if proxy:IsCompleteEvent( 570 ) == false then
		proxy:OnDistanceActionAttribute( 570, 10000, 1240, "OnEvent_570", 1.5 , HELPID_GO_TO_IN , 180.0, 90.0 , ATTR_HOST + ATTR_LIVE + ATTR_GREY,everytime);				
		proxy:LuaCall(570,1,"OnEvent_570_delete_wall",once);
	else
		proxy:SetDrawEnable( 1240, false );--�`��OFF
		proxy:SetColiEnable( 1240, false );--������OFF
		--�����̍Č��Ȃ̂Ŏ��R�ȕ\���̕K�v�������ׁARootErase�w��ł͂Ȃ�
		proxy:InvalidSfx( 2220, false );		
	end]]
	
--��571�����̕ǁ�
	if proxy:IsCompleteEvent( 571 ) == false then
		proxy:OnDistanceActionAttribute( 571, 10000, 1241, "OnEvent_571", 1.5 , HELPID_GO_TO_IN , 180.0, 90.0 , ATTR_HOST + ATTR_LIVE + ATTR_GREY,everytime);				
		proxy:LuaCall(571,1,"OnEvent_571_delete_wall",once);
	else
		proxy:SetDrawEnable( 1241, false );--�`��OFF
		proxy:SetColiEnable( 1241, false );--������OFF
		--�����̍Č��Ȃ̂Ŏ��R�ȕ\���̕K�v�������ׁARootErase�w��ł͂Ȃ�
		proxy:InvalidSfx( 2221, false );		
	end

--��572�����̕ǁ�
	if proxy:IsCompleteEvent( 572 ) == false then
		proxy:OnDistanceActionAttribute( 572, 10000, 1242, "OnEvent_572", 1.5 , HELPID_GO_TO_IN , 180.0, 90.0 , ATTR_HOST + ATTR_LIVE + ATTR_GREY,everytime);				
		proxy:LuaCall(572,1,"OnEvent_572_delete_wall",once);
	else
		proxy:SetDrawEnable( 1242, false );--�`��OFF
		proxy:SetColiEnable( 1242, false );--������OFF
		--�����̍Č��Ȃ̂Ŏ��R�ȕ\���̕K�v�������ׁARootErase�w��ł͂Ȃ�
		proxy:InvalidSfx( 2222, false );
		
		--571�̌��̕ǂ������ɏ�����(�V���[�g�J�b�g��������)
		proxy:SetDrawEnable( 1241, false );--�`��OFF
		proxy:SetColiEnable( 1241, false );--������OFF
		--�����̍Č��Ȃ̂Ŏ��R�ȕ\���̕K�v�������ׁARootErase�w��ł͂Ȃ�
		proxy:InvalidSfx( 2221, false );
	end

--��565�����̕ǃV���[�g�J�b�g��
	proxy:OnRegionJustIn( 565 , 10000 , 2210 , "OnEvent_565",once);
	
--��566�����̕ǃV���[�g�J�b�g��
	proxy:OnRegionJustIn( 566 , 10000 , 2211 , "OnEvent_566",once);
	
--��594���g�J�Q�C�x���g�ړ���
	SingleReset( proxy , 594 );
	if proxy:IsCompleteEvent( 594 ) == false then
	
		proxy:EnableLogic( 321 , false );--�g�J�QA���W�b�NOFF
		proxy:EnableLogic( 322 , false );--�g�J�QB���W�b�NOFF
		
		--���̈�Ď�(�g�J�Q�C�x���g�ړ��A�����̃g���K�[)��
		proxy:OnRegionJustIn( 594 , 10000 , 2234 , "OnEvent_594" , once );
		
		--���_���[�W�Ď�(�g�J�Q�C�x���g�ړ��A�����̃g���K�[)��		
		proxy:OnSimpleDamage( 595 , 321 , 10000 , "OnEvent_594" , once );--�g�J�QA		
		proxy:OnSimpleDamage( 595 , 322 , 10000 , "OnEvent_594" , once );--�g�J�QB
		
	else		
		--proxy:Warp( 321 , 2237 );--�Ή�����̈�Ƀ��[�v
		--proxy:ChangeInitPosAng( 321 , 2237 );--�����ʒu��ύX
		--proxy:Warp( 322 , 2237 );--�Ή�����̈�Ƀ��[�v
		--proxy:ChangeInitPosAng( 322 , 2237 );--�����ʒu��ύX
		InvalidCharactor( proxy , 321 );--������
		InvalidCharactor( proxy , 322 );--������		
	end	
	

--[[�C�x���gID���U���ĂȂ��̂ŁA���͕��u--(��肩�������疳�łɃR�����g�A�E�g�͂����Ȃ��悤�ɁI)
--��572�������g�J�Q�o����QWC�C�x���g
	if proxy:IsClient() == false then
		--62_300
		if proxy:GetQWC(0) >= QWC01_MIN and proxy:GetQWC(0) <= QWC01_MAX then
			proxy:SetEventFlag( 1234567, 1 );
		--62_301
		elseif proxy:GetQWC(1) >= QWC02_MIN and proxy:GetQWC(1) <= QWC02_MAX then
			proxy:SetEventFlag( 1234568, 1 );
		--62_302
		elseif proxy:GetQWC(2) >= QWC03_MIN and proxy:GetQWC(2) <= QWC02_MAX then
			proxy:SetEventFlag( 1234569, 1 );
		end
	end

	--62_300	
	if proxy:IsCompleteEvent(1234567) == true then
		local eneID;
		for eneID = 331, 335, 1 do
			proxy:SetDrawEnable( eneID, true );
			proxy:SetColiEnable( eneID, true );
			--proxy:EnableLogic( eneID, true );
		end
	--62_301
	elseif proxy:IsCompleteEvent(1234568) == true then
		local eneID;
		for eneID = 336, 337, 1 do
			proxy:SetDrawEnable( eneID, true );
			proxy:SetColiEnable( eneID, true );
			--proxy:EnableLogic( eneID, true );
		end
	--62_302
	elseif proxy:IsCompleteEvent(1234569) == true then
		local eneID;
		for eneID = 338, 342, 1 do
			proxy:SetDrawEnable( eneID, true );
			proxy:SetColiEnable( eneID, true );
			--proxy:EnableLogic( eneID, true );
		end
	end
]]
	
--��646���N�}���V�|������
	if proxy:IsCompleteEvent( 646 ) == false then
		proxy:OnCharacterDead( 646, 323 , "OnEvent_646",once);
	else
		InvalidCharactor(proxy,323);--�N�}���V������
		proxy:SetEventFlag( 607,true);
	end
	
--��607���N�}���V�g���b�v��
	--�N�}���V�܂����łȂ�
	if proxy:IsCompleteEvent(607) == false then
		proxy:EnableLogic(323,false);
		--proxy:SetDeadMode(323,true);
		--proxy:OnRegionJustIn(607,10000,2258,"OnEvent_607",once);--����OnEvent641�Ȃǂ̒��ŊĎ���ǉ����Ă���	
		--�N�}���V����
	else
		--print("���łɃg���b�v�͍쓮�ς�");
		--InvalidCharactor(proxy,323);--�N�}���V������
		proxy:EnableLogic(323,false);		
	end
	


--��525���{�X��J�����Ή���
	--�{�X�������Ă���Ȃ�o�^
	if proxy:IsCompleteEvent(6272) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 525 , 10000 , 2886 ,"OnEvent_525" , everytime );
		proxy:NotNetMessage_end();
	end
	
--��8088���B���ɗ����t���O�𗧂Ă遡
	proxy:SetEventFlag(8088, true);
	
--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m06_01_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m06_01_00_00", everytime );
	proxy:NotNetMessage_end();
	

-----------------------------------------------------------------------------------------
--NPC�֘A
-----------------------------------------------------------------------------------------
--------------------------------������QWC�C�x���g�֘A������--------------------------------
--��680��QWC�\�E�������X�^�[��
	if proxy:IsSuccessQWC(60100) == false then--�������Ă��Ȃ��Ȃ��
		print("�u���b�N�S�[�X�g������");
		--350�𖳌���
		InvalidCharactor(proxy, 360);
		--351�𖳌���
		InvalidCharactor(proxy, 361);
		--352�𖳌���
		InvalidCharactor(proxy, 362);
		
		proxy:SetEventFlag(680, true);
	end

--���n�[�t�n���h�֘A��-----------------------------

--��644��QWC�n�[�t�n���h�o����
	if proxy:IsSuccessQWC(60130) == false then	--QWC���������Ă��Ȃ����
		print("QWC�n�[�t�n���h�@������");
		--�n�[�t�n���h�𖳌���
		InvalidBackRead(proxy, 661);
		
		proxy:SetEventFlag(644, true);
	else
		print("QWC�n�[�t�n���h�@����");
	end
	
--��15632���n�[�t�n���h�̎��̂𒲂ׂ���
	if proxy:IsCompleteEvent( 15632 ) == false then
		proxy:AddCorpseEvent( 15632 , 661 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15632 ,0 , "OnEvent_15632",once );
 		proxy:NotNetMessage_end();
	end


--��15604���n�[�t�n���h���̎��̂𒲂ׂĂȂ���
	if proxy:IsCompleteEvent( 15604 ) == false then
		proxy:AddCorpseEvent( 15604 , 345 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15604 , 0 , "OnEvent_15604",once);
		proxy:NotNetMessage_end();
	end

--��675��QWC�n�[�t�n���h�E�u���b�N�S�[�X�g���S�Ď���
	if proxy:IsCompleteEvent(675) == false then	--�܂��n�[�t�n���h�����S���ĂȂ��Ȃ�
	   --�n�[�t�n���h�E���b�N�S�[�X�g�̎��S�Ď��ǉ�
		proxy:OnCharacterDead( 675, 345, "OnEvent_675", once );
	end
--��876��QWC�n�[�t�n���h�E�u���b�N�S�[�X�g�o����
	if proxy:IsCompleteEvent(675) == true or	--�n�[�t�n���h�E�u���b�N�S�[�X�g�����S���Ă���@�� 
	   proxy:IsSuccessQWC(60120) == false then	--QWC���������Ă��Ȃ����
		print("QWC�n�[�t�n���h�E�u���b�N�S�[�X�g�@������");
		if 	proxy:IsCompleteEvent( 675 ) == true and 
			proxy:IsCompleteEvent( 15604 ) == false then
			--�󎀑̂��Č�
			proxy:OpeningDeadPlus( 345 , true ,false ,false );			
		else
			--�n�[�t�n���h�E�u���b�N�S�[�X�g�𖳌���
			InvalidBackRead(proxy, 345);
		end		
		proxy:SetEventFlag(876, true);
	else
		print("QWC�n�[�t�n���h�E�u���b�N�S�[�X�g�@����");
	end
--------------------------------������QWC�C�x���g�֘A������--------------------------------	


--��603���n�[�t�n���h�G�΁�
	if proxy:IsCompleteEvent( 603 ) == false then
		--proxy:OnCharacterTotalDamage( 603, 661, 10000, HALF_TOTALDAMAGE, "OnEvent_603", once );
		proxy:OnCharacterTotalRateDamage( 603, 661, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_603", once );
	end

--��604���n�[�t�n���h���S��
	if proxy:IsCompleteEvent( 604 ) == false then
		proxy:OnCharacterDead( 604 , 661 , "OnEvent_604" , once );
	end

--��643���n�[�t�n���h����A�C�e���Ⴄ��
	if proxy:IsCompleteEvent( 643 ) == false then
		proxy:NotNetMessage_begin();			
			proxy:LuaCall( 643 , 0,"OnEvent_643",once);
		proxy:NotNetMessage_end();
	end

--���n�[�t�n���h�֘A������
	--PC��QWC�l�����l�Ȃ�΃n�[�t�n���h�̏�����Ԃ��Z�b�g
	--[[if proxy:GetQWC(0) == HALF_QWC01 and proxy:GetQWC(1) == HALF_QWC02 then
		--������Ԃ��Z�b�g(��Ԃ����ݒ�̏ꍇ�A�w�肵����Ԃ��Z�b�g����)		
	end]]
	--������
	SetFirstNpcStateFlag( proxy , param , half_flag_list , HALF_STATE_WAIT_KOUDOU );
	print("�n�[�t�n���h�̏������ɐ����I�I");
		
	local now_state = GetNpcStateFlag( proxy , param , half_flag_list );

	--�B���ő҂�
	if now_state == HALF_STATE_WAIT_KOUDOU then	
		--proxy:EnableLogic( 661 , false );--���W�b�NOFF
	
	--�G��(�B��)
	elseif now_state == HALF_STATE_HOSTILE_KOUDOU then	
		--�G�ΐݒ�
		proxy:SetTeamType( 661, TEAM_TYPE_AngryFriend);
	
	--���S
	elseif now_state == HALF_STATE_DEAD then			
		if 	proxy:IsCompleteEvent( 15632 ) == false then
			--���̂��Č�����
			proxy:OpeningDeadPlus( 661 , true ,false ,false );
		else
			print("�n�[�t�n���h������");
			--�n�[�t�n���h�𖳌���
			InvalidBackRead( proxy , 661 );--�n�[�t�n���h������
		end	
	--���̑�
	else
		InvalidBackRead( proxy , 661 );--�n�[�t�n���h������(���̃}�b�v�ɂ��Ȃ�)
	end	
--���n�[�t�n���h�֘A��-----------------------------


--���o�b�`�֘A��------------------------------------

--��616���o�b�`�G�΁�
	if proxy:IsCompleteEvent(616) == false then
		--proxy:OnCharacterTotalDamage( 616, 662, 10000, TOTALDAMAGE_BATTI,"OnEvent_616",once);
		proxy:OnCharacterTotalRateDamage( 616, 662, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_616", once );		
	end
	
--��617���o�b�`���S��
	if proxy:IsCompleteEvent(617) == false then
		proxy:OnCharacterDead(617,662,"OnEvent_617",once);
	end	

--��660���o�b�`�A�C�e���󂯓n����
	if proxy:IsCompleteEvent(660) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall(660,0,"OnEvent_660",once);
		proxy:NotNetMessage_end();
	end	

--��612���o�b�`��̂Ƃ���ֈړ���
	--�o�b�`����̏��֌������������s���Ă��Ȃ�
	if proxy:IsCompleteEvent(612) == false then
		proxy:EnableLogic(662,false);
	else
		--���łɈړ����Ă��܂������A�o�b�`�̏�Ԃ����S��G�΂ȂǂȂ��
		--print("�����ړ��C�x���g�͖����ł�����");
		InvalidBackRead(proxy,662);
	end

--��615������󔠁�
	if proxy:IsCompleteEvent(615) == false then
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		proxy:OnDistanceActionAttribute( 615 , 10000 , 1250 , "OnEvent_615" , ItemBoxDist_A , HELPID_CHECK_GLOWING_CORPS , 0 , ItemBoxAngle_A , possible_chr_type, once );		
		proxy:LuaCall(615,0,"OnEvent_615_2",once);
		--proxy:SetRarity(1250,10600);
		if proxy:IsClient() == false then
			proxy:TreasureDispModeChange2( 1250 , true ,99010);
		end
	else--���łɔ������Ă�����
		--print("�������łɕ�͖����恚��")
		proxy:LuaCall(615,0,"OnEvent_615_3",once);--�o�b�`�̏�Ԃ��u�c�O�v�ɕύX
	end

--���o�b�`��ԊǗ��ݒ�
	--������Ԃ��Z�b�g(��Ԃ����ݒ�̏ꍇ�A�w�肵����Ԃ��Z�b�g����)
	SetFirstNpcStateFlag( proxy , param , batti_flag_list , BATTI_NOT_STAY );--BATTI_PUSHING--BATTI_NOT_STAY
	
	--���݂̏�Ԃ��擾
	local now_state = GetNpcStateFlag( proxy , param , batti_flag_list );
	
	--�c�O
	if		now_state == BATTI_VEXING_M6 	then
		
	--��͒�����
	elseif	now_state == BATTI_TREASURE_M6 then
		--���n�������ׂ̏�����
		--SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_RESERVE_M1);--�o����������
		--InvalidBackRead(proxy,662);--�o�b�`�͂��łɐΒ��ɍs�����̂ł��Ȃ�
		proxy:Warp( 323 , 2239 );--�N�}���V���n�n�_��
		proxy:Warp( 662 , 2241 );--�p�b�`�����_��
		proxy:EnableLogic(662,true);
		proxy:SetSpStayAndDamageAnimId(662,-1,-1);
	--�A�C�e����n����
	elseif now_state == BATTI_PRESENT then
		proxy:Warp( 323 , 2239 );--�N�}���V���n�n�_��
		proxy:Warp( 662 , 2241 );--�p�b�`�����_��
		proxy:EnableLogic(662,true);
		proxy:SetSpStayAndDamageAnimId(662,-1,-1);
		
	--�N�}���V���j
	elseif now_state == BATTI_DESTORYKUMA then
		--SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_RESERVE_M1);--�o����������
		proxy:EnableLogic(662,true);
		proxy:SetSpStayAndDamageAnimId(662,-1,-1);
		--InvalidBackRead(proxy,662);--�o�b�`�͂��łɐΒ��ɍs�����̂ł��Ȃ�
	--�G��
	elseif	now_state == BATTI_ANGRY_M6  then--�B���ȊO�œG�΂̏ꍇ�A�����ɂ͋��Ȃ��͂��Ȃ̂ŁA����͂P��
		--print("if--��641���i�o�b�`���G��(�ԁA�B���A�Β�)���Ă����ꍇ�j������")
		
		proxy:OnRegionJustIn(641,10000,2260,"OnEvent_641",everytime);--�o�b�`�ړ��͖��������āA�N�}���V�g���b�v�̊Ď���ǉ�
		
		proxy:EnableLogic(662,true);--���W�b�N��ON
		proxy:SetTeamType(662, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
		SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_ANGRY_M6);--�G�Ώ�Ԃ�
		
	--�o������--�܂��ǂ��ɂ����Ȃ�--㩂ɂ͂߂���
	elseif	now_state == BATTI_RESERVE_M1	or
			now_state == BATTI_NOT_STAY		or
			now_state == BATTI_TRAP_M6		then
		if proxy:IsCompleteEvent( 615 ) == false then
			--print("if--��642���i�o�b�`���������̏ꍇ)������")
			proxy:SetEventFlag(642, false);--�O�̂��߂Ƀ��Z�b�g
			--SingleReset( proxy,642);
			--�������������ꍇ�̃N�}���V����
			--SingleReset( proxy, 607 );
			proxy:OnRegionJustIn(642,10000,2260,"OnEvent_642",everytime);--�����𖞂�������u㩂ɛƂ߂����v�ɕύX���ĊĎ��ǉ�
			
			proxy:OnRegionJustOut( 662,662,2257,"OnEvent_616",once);--㩂ɂ͂߂����������G�Βǉ�
			
			if proxy:IsCompleteEvent(645) == false then	
				--�z�X�g�������r�ӂ�̊Ď�
				if proxy:IsClient() == false then
					proxy:NotNetMessage_begin();
						proxy:OnRegionIn( 645,10000,2259 , "OnEvent_645",once);
					proxy:NotNetMessage_end();
				end
				proxy:LuaCall( 645 , 1 , "OnEvent_645_1",once);
			else
				proxy:SetSpStayAndDamageAnimId(662,-1,-1);
			end
		else
			InvalidCharactor( proxy , 662 );
			InvalidCharactor( proxy , 323 );
		end
	--���S
	elseif	now_state == BATTI_DEAD then
		--print("if--��641���o�b�`�����S�������ꍇ������")
		--������
		InvalidBackRead(proxy,662);--�o�b�`�͎���ł���
		--���S���Ă����ꍇ�̃N�}���V����
		proxy:OnRegionJustIn(641,10000,2260,"OnEvent_641",everytime);--�o�b�`�͖��������āA�N�}���V�g���b�v�̊Ď���ǉ�
		
	--�ÍԂ̏��
	elseif	now_state == BATTI_COME		or
			now_state == BATTI_PUSHING	then
		--print("if--��640��(�o�b�`�����Ăق������˂����Ƃ��������A�܂��ǂ��ɂ����Ȃ��ꍇ)������");
		--������
		InvalidBackRead(proxy,662);--�o�b�`
		InvalidCharactor(proxy,323);--�N�}���V������
		--�ÍԂɂ���ꍇ�Ƃ܂����Ȃ��ꍇ�̃N�}���V����
		proxy:OnRegionJustIn(640,10000,2260,"OnEvent_640",everytime);--�g���b�v���ړ��C�x���g������
		
	--����ȊO
	else 
		--print("if--��640���o�b�`����L�ȊO�������ꍇ������")
		--�ǂ�ɂ����Ă͂܂�Ȃ����̏���
		proxy:OnRegionJustIn(640,10000,2260,"OnEvent_640",everytime);--�g���b�v[]�ړ��C�x���g
		InvalidBackRead(proxy,662);--�ǂ�ɂ����Ă͂܂�Ȃ��Ƃ������́A�����ɂ͋��Ȃ���
		InvalidCharactor(proxy,323);--�N�}���V������
	end
--���o�b�`�֘A��------------------------------------------


--����H�V���b�v�֘A��------------------------------------
	--m06_01_00_00�ɂāA�܂Ƃ߂ċL�q
--����H�V���b�v�֘A��------------------------------------------

	--�g���b�R�j��
	SingleReset( proxy,696 );
	if proxy:IsCompleteEvent( 696 ) == false then
		proxy:RestorePiece( 1290 );
		--proxy:OnObjectDestroy( 696 , 1290 , "OnEvent_696", once );
		proxy:OnSimpleDamage( 696, 1290, 400 , "OnEvent_696",once);
	else
		--�j��Č��͕ۗ�
		--proxy:ReconstructBreak( 1290 , 1 );
	end
	
	--�g���b�R�g���b�v	
	SingleReset( proxy,690 );
	SingleReset( proxy,900 );
	--SingleReset( proxy,901 );
	if proxy:IsCompleteEvent( 690 ) == false then
		proxy:OnRegionIn( 690 , 10000 , 2271 , "OnEvent_690" , once);
	else
		if proxy:IsDestroyed( 1290 ) == false then
			--�g���b�R�̃A�j���I���t���[���ɐݒ�
			proxy:EndAnimation( 1290 , 1 );	
		end
	end
	
	--�E�B���I�E�B�X�v����
	SingleReset( proxy,691 );
	if proxy:IsCompleteEvent( 691 ) == false then
		--proxy:OnPlayerDistanceInTarget( 691 , 10000 , 1290 , "OnEvent_691", 3.0 , once);
		proxy:OnNetDistanceIn(691,1290,4.0,"OnEvent_691");
		proxy:SetObjSfx( 1290 , 1 , 96001 , true );
	else
		--�����Č����K�v�Ȃ�
	end	
	
	
	--�g���b�R�j��
	SingleReset( proxy,697 );
	if proxy:IsCompleteEvent( 697 ) == false then
		proxy:RestorePiece( 1291 );
		--proxy:OnObjectDestroy( 697 , 1291 , "OnEvent_697", once );
		proxy:OnSimpleDamage( 697, 1291, 400 , "OnEvent_697",once);
	else
		--�j��Č��͕ۗ�
		--proxy:ReconstructBreak( 1291 , 1 );
	end

	--�g���b�R�g���b�v
	SingleReset( proxy,692 );
	SingleReset( proxy,902 );	
	--SingleReset( proxy,903 );
	if proxy:IsCompleteEvent( 692 ) == false then
		proxy:OnRegionIn( 692 , 10000 , 2272 , "OnEvent_692" , once);
	else
		if proxy:IsDestroyed( 1291 ) == false then
			--�g���b�R�̃A�j���I���t���[���ɐݒ�
			proxy:EndAnimation( 1291 , 1 );		
		end
	end
	
	--�E�B���I�E�B�X�v����
	SingleReset( proxy,693 );
	if proxy:IsCompleteEvent( 693 ) == false then
		--proxy:OnPlayerDistanceInTarget( 693 , 10000 , 1291 , "OnEvent_693", 3.0 , once);
		proxy:OnNetDistanceIn(693,1291,4.0,"OnEvent_693");
		proxy:SetObjSfx( 1291 , 1 , 96001 , true );
	else
		--�����Č����K�v�Ȃ�
	end	
	
	
	--�g���b�R�j��
	SingleReset( proxy,698 );
	if proxy:IsCompleteEvent( 698 ) == false then
		proxy:RestorePiece( 1292 );
		--proxy:OnObjectDestroy( 698 , 1292 , "OnEvent_698", once );
		proxy:OnSimpleDamage( 698, 1292, 400 , "OnEvent_698",once);
	else
		--�j��Č��͕ۗ�
		--proxy:ReconstructBreak( 1292 , 1 );
	end
	
	--�g���b�R�g���b�v
	SingleReset( proxy,694 );
	SingleReset( proxy,904 );
	--SingleReset( proxy,905 );
	if proxy:IsCompleteEvent( 694 ) == false then
		proxy:OnRegionIn( 694 , 10000 , 2273 , "OnEvent_694" , once);
	else
		if proxy:IsDestroyed( 1292 ) == false then
			--�g���b�R�̃A�j���I���t���[���ɐݒ�
			proxy:EndAnimation( 1292 , 1 );
		end
	end
	
	--�E�B���I�E�B�X�v����
	SingleReset( proxy,695 );
	if proxy:IsCompleteEvent( 695 ) == false then
		--proxy:OnPlayerDistanceInTarget( 695 , 10000 , 1292 , "OnEvent_695", 3.0 , once);
		proxy:OnNetDistanceIn(695,1292,4.0,"OnEvent_695");
		proxy:SetObjSfx( 1292 , 1 , 96001 , true );
	else
		--�����Č����K�v�Ȃ�
	end	

	--��710���󎀑̃g���b�v1��
	if proxy:IsCompleteEvent( 700 ) == false then
		proxy:AddTreasureEvent( 700 , 10782 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 700 , 0 , "OnEvent_700",once);
		proxy:NotNetMessage_end();
		--�z�M�p
		proxy:LuaCall( 700 , 10 , "OnEvent_700_1",once);
		if proxy:IsAlive( 330 ) == true then
			proxy:PlayLoopAnimation( 330 , 9000);
			proxy:EnableLogic( 330 , false );
			InvalidCharactor( proxy , 330 );
		end
	else
	end
	
	--��711���󎀑̃g���b�v2��
	if proxy:IsCompleteEvent( 701 ) == false then
		proxy:AddTreasureEvent( 701 , 10786 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 701 , 0 , "OnEvent_701",once);
		proxy:NotNetMessage_end();
		--�z�M�p
		proxy:LuaCall( 701 , 10 , "OnEvent_701_1",once);
		if proxy:IsAlive( 415 ) == true then
			proxy:PlayLoopAnimation( 415 , 9000);
			proxy:EnableLogic( 415 , false );
			InvalidCharactor( proxy , 415 );
		end
	else
	end
	
	--��720���g�J�Q�|�C���g�ړ�2��
	if proxy:IsCompleteEvent( 786 ) == false then
		SingleReset( proxy , 720 );
		SingleReset( proxy , 723 );
		if proxy:IsCompleteEvent( 720 ) == false then
			proxy:EnableLogic( 416 ,false );
			
			--���̈�Ď�(�g�J�Q�C�x���g�ړ��A�����̃g���K�[)��
			proxy:OnRegionJustIn( 720 , 10000 , 2262 , "OnEvent_720" , once );		
			--���_���[�W�Ď�(�g�J�Q�C�x���g�ړ��A�����̃g���K�[)��
			proxy:OnSimpleDamage( 721 , 416 , 10000 , "OnEvent_720" , once );--�g�J�QA
		else
			--proxy:Warp( 416 , 2265 );--�Ή�����̈�Ƀ��[�v
			--proxy:ChangeInitPosAng( 416 , 2265 );--�����ʒu��ύX		
			InvalidCharactor( proxy , 416 );--������
		end
	end
	
	--��725���g�J�Q�|�C���g�ړ�3��
	if proxy:IsCompleteEvent( 788 ) == false then
		SingleReset( proxy, 725 );
		if proxy:IsCompleteEvent( 725 ) == false then
			proxy:EnableLogic(417,false );
			
			--���̈�Ď�(�g�J�Q�C�x���g�ړ��A�����̃g���K�[)��
			proxy:OnRegionJustIn( 725 , 10000 , 2266 , "OnEvent_725" , once );		
			--���_���[�W�Ď�(�g�J�Q�C�x���g�ړ��A�����̃g���K�[)��
			proxy:OnSimpleDamage( 726 , 417 , 10000 , "OnEvent_725" , once );--�g�J�QA
		else
			--proxy:Warp( 417 , 2268 );--�Ή�����̈�Ƀ��[�v
			--proxy:ChangeInitPosAng( 417 , 2268 );--�����ʒu��ύX			
			InvalidCharactor( proxy , 417 );--������
		end
	end
	

	
	--��730�`734���V�R�E�B���I�E�B�X�v������
	
	local WISP_list = {WISP1_DIST,WISP2_DIST,WISP3_DIST,WISP4_DIST,WISP5_DIST};
	
	local index = 0;
	local actionId = 730;
	local num = table.getn(WISP_list);
	local targetId = 1300;
	
	for index=1 , num , 1 do
		SingleReset( proxy,actionId);
		if proxy:IsCompleteEvent( actionId ) == false then
			print("�V�R�E�B���I�E�B�X�v �ǉ�",targetId);
			proxy:OnPlayerDistanceInTarget( actionId, 10000 , targetId,"OnEvent_"..actionId,WISP_list[index],once);
			proxy:SetObjSfx( targetId, 1 ,96001 , true );
		end
		actionId = actionId+1;
		targetId = targetId+1;
	end
	
	--��702���������ǂ��Ă��遡
	SingleReset(proxy,702);
	--[[
	if proxy:IsCompleteEvent( 702 ) == false then
		proxy:OnRegionIn( 702 , 10000 , 2276 , "OnEvent_702",once);
	end	
	]]
	
--��800���ؑ��P��
	if proxy:IsCompleteEvent( 800 ) == false then
		proxy:OnCharacterDead( 800 , 500 , "OnEvent_800",once);
	else
		InvalidCharactor( proxy, 500 );
	end
	
--��802���ؑ��Q��
	if proxy:IsCompleteEvent( 802 ) == false then
		proxy:OnCharacterDead( 802 , 501 , "OnEvent_802",once);
	else
		InvalidCharactor( proxy, 501 );
	end


--��~�~�Y��_���ʓo�^
	local actidlist = {810,811,812,813,814,815,816,817,818,819,820,821,822,823,824};
	local eneidlist = {300,324,325,326,327,328,329,330,331,332,333,334,335,336,415};
	
	local num = table.getn( actidlist );
	for index=1 , num , 1 do
		RegistRockWorm( proxy, actidlist[index] , eneidlist[index] );
	end
	


--��15500�������A�C�e���擾�Ď����n���h���̓O���[�o���ɒ�`
	if proxy:IsCompleteEvent( 15500 ) == false then
--~ 		proxy:AddCorpseEvent( 15500 , 345 );--�n�[�t�n���h�E�u���b�N
		proxy:AddCorpseEvent( 15500 , 500 );--�ʏ�E�u���b�N
		proxy:AddCorpseEvent( 15500 , 501 );--�ʏ�E�u���b�N
	end


	--��999999���t���[���x��̏����������C�x���g�𔭍s��
	proxy:NotNetMessage_begin();
		--��0�b�づ--
		proxy:OnKeyTime2( 999991, "Second_Initialize_m06_01_00_00", 0.1, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m06_01_00_00 end");
end


--------------------------------------------------------------------------------------
--Initialize����Ă΂��A1�t���[���x��̏�����������999999
--------------------------------------------------------------------------------------
--��999999���ꕔ�AInit�ł͏����ł��Ȃ��̂ŁA�c���Ă���
function Second_Initialize_m06_01_00_00(proxy, param)
	print("Second_Initialize_m06_01_00_00 begin");

--------------------------------������QWC�C�x���g�֘A������--------------------------------
--------------------------------������QWC�C�x���g�֘A������--------------------------------

--��540����~�~�Y�o�ꁡ
	SingleReset(proxy,540);
	if proxy:IsCompleteEvent(540) ==false then
		if proxy:IsAlive( 300 ) == true then
			proxy:OnPlayerDistanceAngleInTarget( 540, 10000, 300, "OnEvent_540", PROTROCKWORM_DIST, 180.0, once );		
			proxy:EnableLogic( 300, false );
			proxy:PlayLoopAnimation( 300, 9000 );
			InvalidCharactor(proxy, 300);
		end
	end


	--��620�`626����~�~�Y�o����
	--��������
	local worm_list = {
		ROCKWORM1_DIST,
		ROCKWORM2_DIST,
		ROCKWORM3_DIST,
		ROCKWORM4_DIST,
		ROCKWORM5_DIST,
		ROCKWORM6_DIST
		--[[,
		ROCKWORM7_DIST]]
	};
	local index = 0;
	local num = table.getn(worm_list);
	local eventID = 620;
	local targetID = 324;

	for index=1 , num, 1 do	
		SingleReset(proxy,eventID);
		if proxy:IsCompleteEvent(eventID) == false then
			if proxy:IsAlive( targetID ) == true then
				print("AddWormEvent eve:",eventID," target:",targetID);
				proxy:OnPlayerDistanceInTarget( eventID , 10000, targetID, "OnEvent_"..eventID, worm_list[index] , once);
				proxy:EnableLogic( targetID, false );
				proxy:PlayLoopAnimation( targetID, 9000 );
				InvalidCharactor(proxy, targetID);
			end
		end
		eventID = eventID + 1;
		targetID = targetID +1;		
	end
	
	--��541�`547����΃~�~�Y�o�ꁡ
	
	local index = 0;	
	local eventID = 541;	
	local targetID = 331;
	local num = 6

	for index=1 , num, 1 do	
		SingleReset(proxy,eventID);
		if proxy:IsCompleteEvent(eventID) == false then
			if proxy:IsAlive( targetID ) == true then
				print("AddWormEvent eve:",eventID," target:",targetID);
				proxy:OnPlayerDistanceInTarget( eventID , 10000, targetID, "OnEvent_"..eventID, 5.0 , once);
				proxy:EnableLogic( targetID, false );
				proxy:PlayLoopAnimation( targetID, 9000 );
				InvalidCharactor(proxy, targetID);
			end
		end
		eventID = eventID + 1;
		targetID = targetID +1;		
	end
	print("Second_Initialize_m06_01_00_00 end");
end

--------------------------------------------------------------------------------------
--��6284���Β��Ƀ��[�v��
--------------------------------------------------------------------------------------
function OnEvent_6284(proxy,param)	
	print("OnEvent_6284 begin");
	
	if proxy:IsCompleteEvent( 6284 ) == true then
		return;
	end
	
	proxy:RepeatMessage_begin();
		--��_1���I�����j���[�̊Ď���
		proxy:OnSelectMenu(6284, "OnEvent_6284_1", 10010710, 0, 2, 1981, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_6284 end");
end

--��6284_1���I�����j���[�̊Ď���
function OnEvent_6284_1(proxy,param)	
	print("OnEvent_6284_1 begin");
	
	if proxy:IsSession() == false then
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1981 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			proxy:OnChrAnimEnd( 6284 , 10000 , 8283 , "OnEvent_6284_2",once);
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(6284,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_6284_1 end");
end

--��6284_2���I�����j���[�̊Ď���
function OnEvent_6284_2(proxy,param)	
	print("OnEvent_6284_2 begin");
	
	proxy:SetEventFlag(6284,false);
	
	proxy:PlayAnimation(10000,8284);
	
	proxy:SetEventFlag(6284,true);
	
	OnEvent_512(proxy, param);
	
	print("OnEvent_6284_2 end");
end

--------------------------------------------------------------------------------------
--��512���Β��Ƀ��[�v��
--------------------------------------------------------------------------------------
--��512���Β��Ƀ��[�v��
function OnEvent_512(proxy,param)	
	print("OnEvent_512 begin");
	
	--�Β��֖߂��Ă�������̃t���O�𗧂Ă�
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag(6284,false);
	--���S�񕜗v��
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1010 );
	
	print("OnEvent_512 end");
end

--------------------------------------------------------------------------------------
--��522���{�X�����|������
--------------------------------------------------------------------------------------
--��522���{�X�����|������
function OnEvent_522(proxy, param)
	print("OnEvent_522 begin");
	proxy:RequestRemo(60100,REMO_FLAG,522,1);
	proxy:SetEventFlag(522,true);
	print("OnEvent_522 end");
end

function OnEvent_522_RemoStart(proxy,param)
	print("OnEvent_522_RemoStart begin");	
	print("OnEvent_522_RemoStart end");
end

function OnEvent_522_RemoFinish(proxy,param)
	print("OnEvent_522_RemoFinish begin");	
	ValidCharactor( proxy, 811 );
	
	proxy:SetColiEnable( 1280, false );
	proxy:SetDrawEnable( 1280, false );
	
	proxy:SetColiEnable( 1281, true );
	proxy:SetDrawEnable( 1281, true );
	
	--�|�����I����������ʒm����t���OON
	proxy:SetEventFlag( 524 , true );
	print("OnEvent_522_RemoFinish end");
end


--------------------------------------------------------------------------------------
--��540����~�~�Y��
--------------------------------------------------------------------------------------
function OnEvent_540(proxy,param)
print("OnEvent_540 begin");
	ValidCharactor( proxy, 300 );
	proxy:StopLoopAnimation( 300 );
	proxy:ForcePlayAnimation( 300, 9010 );
	proxy:EnableLogic( 300, true );	
	proxy:SetEventFlag( 540 , true );		
print("OnEvent_540 end");
end


--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ���(��C��)��520
--------------------------------------------------------------------------------------

--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫

--��520�����{�X�����ւ̔����J����
function OnEvent_520(proxy,param)
	print("OnEvent_520 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_520 end");
		return;
	end
	
	--�N���C�A���g�ցA�{�X�����j�~���s��ʒm
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 521, 1 );--����A�j���̓����Đ�
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--���d�N���V�X�e��ID���^�C���A�E�g��ݒ肵��ON�ɂ���
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_520 end");
end


--����A�j���̓����Đ�(ID����)
function OnEvent_521_1(proxy,param)
	print("OnEvent_521_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ����s���A���̏I������OnEvent_521_2�𔭍s����
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2890 );
		else
			proxy:LockSession();--���[�������b�N���܂��I
			--����A�j���Đ����s���A���̏I������OnEvent_521_2�𔭍s����
			proxy:OnTurnCharactorEnd( 521, 10000, 2890, "OnEvent_521_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
		
	print("OnEvent_521_1 end");
end

--����A�j���̓����Đ��I����
function OnEvent_521_2(proxy,param)
	print("OnEvent_521_2 begin");
	
	--�����p�����A�j���Đ�
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 521, 10000, ANIMEID_WALK, "OnEvent_521_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
		
	print("OnEvent_521_2 end");
end

--�����A�j���̓����Đ��I����
function OnEvent_521_3(proxy,param)
	print("OnEvent_521_3 begin");

	--�ŏ��̐l���{�X�����̒��ɓ���I����Ă�����A���ɔz�M����Ă���͂��Ȃ̂ŁA����������Ȃ��n���h��
	if proxy:IsCompleteEvent( 520 ) == false then
		proxy:LuaCallStart( 521 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCallStart( 4045 , 1 );	--�N���C�A���g�ցA�{�X�����ɓ����悤�ɂȂ������Ƃ�ʒm
		proxy:LuaCallStart( 521 , 6 );--�t���O�Z�b�g(�����p)
		Lua_MultiDoping(proxy,811);--�}���`�v���C�h�[�s���O
	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�)
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:ResetThink( 811 );
	end
		
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );
	
	print("OnEvent_521_3 end");
end


--��520 2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
function OnEvent_520_GO_TO_IN(proxy, param)
	print("OnEvent_520_GO_TO_IN begin");
	
	proxy:NotNetMessage_begin();
		--��521�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���--�n���h���� OnEvent_520
		proxy:OnPlayerActionInRegion( 521, 2894, "OnEvent_520", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	
	print("OnEvent_520_GO_TO_IN end");
end


--��520 �t���O�Z�b�g(�����p)
function OnEvent_520_flag_set(proxy, param)
	print("OnEvent_520_flag_set begin");
		
	proxy:SetEventFlag( 520 , 1 );
	proxy:DeleteEvent( 520 );

	print("OnEvent_520_flag_set end");
end



--------------------------------------------------------------------------------------
--�{�X�������o��(�퓬�J�n ��C��)��523
--------------------------------------------------------------------------------------

function OnEvent_523(proxy, param)
	if proxy:IsCompleteEvent( 524 ) == false then
		return;
	end
	print("OnEvent_523 begin");
	
	--�{�X��pBGM�Đ��J�n	
	proxy:PlayPointSE( 2244, SOUND_TYPE_M, 60100000, 1 );
	
	--�{�X���W�b�NON
	proxy:EnableLogic( 811 , true );
	
	--�t���OON
	proxy:SetEventFlag( 523 ,true );
	
	--�{�X�Q�[�W�\��
	proxy:SetBossGauge(811, 0, 4050);	
	
	--�Ď��̍폜
	proxy:DeleteEvent( 523 );
	
	print("OnEvent_523 end");
end


--------------------------------------------------------------------------------------
--��6272�����{�X���S(��C��)��
--------------------------------------------------------------------------------------
--��6272�����{�X���S��
function OnEvent_6272(proxy,param)	
	print("OnEvent_6272 begin");

	proxy:NotNetMessage_begin();
		--��6272_1��1�b�づ
		proxy:OnKeyTime2( 6272 , "OnEvent_6272_1" , 1.0 , 0 , 1 , once );
		--��6272_2��2�b�づ
		proxy:OnKeyTime2( 4992 , "OnEvent_6272_2" , 2.0 , 0 , 1 , once );
		--�}���`���U�Ď�
		proxy:OnRegistFunc( 6272, "Check_6272_PT","OnEvent_6272_PT",0,once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 6272 , 1 );
	
	--�����l��n��
	FireMan_Dead(proxy,param);

	--�V�u���b�N�N���A������
	proxy:CustomLuaCallStart( 4050, 811);
	--�g�J�Q���Z�b�g
	ResetTokage(proxy);
	
	print("OnEvent_6272 end");
end

--��6272_1��1�b�っ
function OnEvent_6272_1(proxy,param)
	print("OnEvent_6272_1 begin");
	
	--�{�X��|���������X�V(���ɂ���ăt���O�𗧂Ă�)
	GetBossFlagCount( proxy, param );
	
	--���g���t�B�[�擾���聥
	Lua_RequestUnlockTrophy(proxy, 37);--�g���t�B�����𔻒肵�A�擾
	
	--�z�X�g�v���C���[�̂݃A�C�e������C�x���g�Ɏg�p
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

	--�󎀑�(�\�E��?)�L����
	proxy:SetDrawEnable( 1981 , true );
	proxy:SetColiEnable( 1981 , true );
	--�\�E���Ɏh���������L����
	proxy:SetDrawEnable( 1976 , true );
	proxy:SetColiEnable( 1976 , true );
	
	--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
	if proxy:IsCompleteEvent( 6283 ) == false then
		--SFX ON
		proxy:ValidSfx( 2250 );--���̗��q
		proxy:ValidSfx( 2251 );--�v�΂̃I�[��
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--���点��
		--proxy:TreasureDispModeChange2( 1976 , true ,KANAME_SFX);--���点��
		proxy:OnDistanceActionAttribute( 6283 , 10000 , 1981 , "OnEvent_6283" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end
	
	--���{�X�����O�̈ړ������C�x���g���폜
	proxy:DeleteEvent( 520 );--��l�ڂ�����Ƃ��p
	proxy:DeleteEvent( 521 );--��l�ڈȍ~������Ƃ��p
	proxy:DeleteEvent( 522 );--�{�X�O�|�����p
	proxy:DeleteEvent( 523 );--�{�X�퓬�J�n�p

	print("OnEvent_6272_1 end");
end

--��6272_2��2�b�っ
function OnEvent_6272_2(proxy,param)
	print("OnEvent_6272_2 begin");
	
	--�{�X��p��BGM��~	
	proxy:StopPointSE( 1 );	

	print("OnEvent_6272_2 end");
end

--�}���`���U�Ď�
function Check_6272_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--�}���`����Ȃ�
function OnEvent_6272_PT(proxy,param)
	print("OnEvent_6272_PT begin");
	
	--���{�X�����̑O��̖��@�ǂ�������(�S�v���C���[)
	proxy:SetColiEnable( 1998 , false );
	proxy:SetColiEnable( 1994 , false );
	
	proxy:SetDrawEnable( 1998 , false );
	proxy:SetDrawEnable( 1994 , false );
	
	--SFX OFF
	proxy:InvalidSfx( 1986 , true );
	proxy:InvalidSfx( 1990 , true );
	
	print("OnEvent_6272_PT end");
end

--------------------------------------------------------------------------------------
--��6283���\�E�����聡
--------------------------------------------------------------------------------------
function OnEvent_6283(proxy, param)
	print("OnEvent_6283 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--�V�����A�j�� 
		print("OnEvent_6283 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 6283, "OnEvent_6283_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_6283 end");
end


--��6283_1���A�C�e���擾��
function OnEvent_6283_1(proxy, param)
	print("OnEvent_6283_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10631�Q��
	proxy:GetRateItem(10631);	
	--�A�C�e���擾�֐�--�p�����[�^10674�Q��
	proxy:GetRateItem(10674);	
	--�A�C�e���擾�֐�--�p�����[�^10675�Q��
	proxy:GetRateItem(10675);	
	--�A�C�e���擾�֐�--�p�����[�^10676�Q��
	proxy:GetRateItem(10676);	
	--�A�C�e���擾�֐�--�p�����[�^10677�Q��
	proxy:GetRateItem(10677);	
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 6283, 1 );
	
	--�󔠃V�F�[�_�[�͏����܂���
	--proxy:TreasureDispModeChange( 1981 , false );

	--SFX��������
	proxy:InvalidSfx( 2250 , true );--���̗��q
	--proxy:InvalidSfx( 2251 , true );--�v�΂̃I�[��
	
	--���v�΂Ń��[�v�p�̊Ď���ǉ���
	proxy:OnDistanceActionAttribute( 6284 , 10000 , 1981 , "OnEvent_6284" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_6283_1 end");
end

--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m06_01_00_00(proxy, param)
	print("PlayerDeath_m06_01_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m06_01_00_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerDeath_m06_01_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m06_01_00_00(proxy,param)
	print("PlayerRevive_m06_01_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m06_01_00_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerRevive_m06_01_00_00");
end



--[[
--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ���(��C��)��111
--------------------------------------------------------------------------------------

--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫

--��111�����{�X�����ւ̔����J����
function OnEvent_111(proxy,param)
	print("OnEvent_111 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_111 end");
		return;
	end
	
	proxy:LuaCallStart( 112, 1 );--����A�j���̓����Đ�
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	
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
		proxy:LuaCallStart( 111 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCallStart( 4045 , 1 );	--�N���C�A���g�ցA�{�X�����ɓ����悤�ɂȂ������Ƃ�ʒm
	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�)
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:ResetThink( 810 );
	end
	
	proxy:LuaCallStart( 111 , 6 );--�t���O�Z�b�g(�����p)
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

	print("OnEvent_111_flag_set end");
end
]]



--------------------------------------------------------------------------------------
--��570���z�X�gPC�݂̂��ʂ����̖���
--------------------------------------------------------------------------------------
--��570_delete_wall�����@�Ǎ폜�����p��
function OnEvent_570_delete_wall(proxy , param)
	print("OnEvent_570_delete_wall begin");
	
	proxy:SetDrawEnable( 1240 , false );--���@�Ǖ`��OFF
	proxy:SetColiEnable( 1240 , false );--���@�Ǔ�����OFF	
	proxy:DeleteEvent( 570 );--�S�v���C���[���̊Ď�������͂��B
	
	print("OnEvent_570_delete_wall end");
end

--��570���C�x���g�����p��
function OnEvent_570(proxy , param)
	print("OnEvent_570 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 570 ) == true then
		print("OnEvent_570 end");
		return;
	end
	
	proxy:InvalidSfx( 2220, true );
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 570 , 1 );
		print("OnEvent_570 end");
		return;
	end
	
	--�_�~�|���փ��[�v
	proxy:WarpDmy( 10000 , 1240 , 191 );
	
	proxy:NotNetMessage_begin();
		--��240_1�������A�j���I����
		proxy:OnChrAnimEnd( 570 , 10000 , ANIMEID_WALK , "OnEvent_570_1" , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 570 , 1 );
	
	print("OnEvent_570 end");
end

--��570_1�������A�j���I����
function OnEvent_570_1(proxy , param)
	print("OnEvent_570_1 begin");
	
	proxy:LuaCallStart( 570 , 1 );--���̖��폜����
	
	print("OnEvent_570_1 end");
end




--------------------------------------------------------------------------------------
--��571���z�X�gPC�݂̂��ʂ����̖���
--------------------------------------------------------------------------------------
--��571_delete_wall�����@�Ǎ폜�����p��
function OnEvent_571_delete_wall(proxy , param)
	print("OnEvent_571_delete_wall begin");
	
	proxy:InvalidSfx( 2221, true );
	proxy:SetDrawEnable( 1241 , false );--���@�Ǖ`��OFF
	proxy:SetColiEnable( 1241 , false );--���@�Ǔ�����OFF	
	proxy:SetObjDeactivate( 1241 , true );--�f�A�N�e�B�u
	proxy:DeleteEvent( 571 );--�S�v���C���[���̊Ď�������͂��B
	
	print("OnEvent_571_delete_wall end");
end

--��571���C�x���g�����p��
function OnEvent_571(proxy , param)
	print("OnEvent_571 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 571 ) == true then
		print("OnEvent_571 end");
		return;
	end
	
	proxy:InvalidSfx( 2221, true );
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 571 , 1 );
		print("OnEvent_571 end");
		return;
	end
		
	--�_�~�|���փ��[�v
	proxy:WarpDmy( 10000 , 1241 , 191 );
	
	proxy:NotNetMessage_begin();
		--��240_1�������A�j���I����
		--proxy:OnChrAnimEnd( 571 , 10000 , ANIMEID_WALK , "OnEvent_571_1" , once );
		proxy:LuaCallStart( 571 , 1 );--���̖��폜����
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 571 , 1 );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_571 end");
end

--��571_1�������A�j���I����
function OnEvent_571_1(proxy , param)
	print("OnEvent_571_1 begin");
	
	proxy:LuaCallStart( 571 , 1 );--���̖��폜����
	
	print("OnEvent_571_1 end");
end


--�V���[�g�J�b�g
function OnEvent_565(proxy,param)
	if proxy:IsClient() == false then
		print("OnEvent_565 begin");
		proxy:SetEventFlag(565,true);
		if proxy:IsCompleteEvent(571) == false then
			proxy:SetEventFlag( 571,true);
			proxy:LuaCallStart( 571 , 1 );--���̖��폜����		
		end
		print("OnEvent_565 end");
	end
end



--------------------------------------------------------------------------------------
--��572���z�X�gPC�݂̂��ʂ����̖���
--------------------------------------------------------------------------------------
--��572_delete_wall�����@�Ǎ폜�����p��
function OnEvent_572_delete_wall(proxy , param)
	print("OnEvent_572_delete_wall begin");
	
	proxy:InvalidSfx( 2222, true );
	proxy:SetDrawEnable( 1242 , false );--���@�Ǖ`��OFF
	proxy:SetColiEnable( 1242 , false );--���@�Ǔ�����OFF	
	proxy:SetObjDeactivate( 1242 , true );--�f�A�N�e�B�u
	proxy:DeleteEvent( 572 );--�S�v���C���[���̊Ď�������͂��B

	print("OnEvent_572_delete_wall end");
end

--��572���C�x���g�����p��
function OnEvent_572(proxy , param)
	print("OnEvent_572 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 572 ) == true then
		print("OnEvent_572 end");
		return;
	end
	
	proxy:InvalidSfx( 2222, true );
	proxy:InvalidSfx( 2221, true );--�V���[�g�J�b�g�������߂��̖��@�ǂ������B
	proxy:InvalidSfx( 2220, true );--�V���[�g�J�b�g�������߂��̖��@�ǂ������B
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 572 , 1 );
		proxy:SetEventFlag( 571 , 1 );
		--proxy:SetEventFlag( 570 , 1 );--�V���[�g�J�b�g�p�ɐU��ꂽID�̃t���O�����ĂĂ����B
		print("OnEvent_572 end");
		return;
	end
	
	--�_�~�|���փ��[�v
	proxy:WarpDmy( 10000 , 1242 , 191 );
	
	proxy:NotNetMessage_begin();
		--��240_1�������A�j���I����
		--proxy:OnChrAnimEnd( 572 , 10000 , ANIMEID_WALK , "OnEvent_572_1" , once );
		proxy:LuaCallStart( 572 , 1 );--���̖��폜����
		proxy:LuaCallStart( 571 , 1 );--�V���[�g�J�b�g�����̂ŁA���̖��@�ǂ�����
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 572 , 1 );
	proxy:SetEventFlag( 571 , 1 );
	--proxy:SetEventFlag( 570 , 1 );--�V���[�g�J�b�g�p�ɐU��ꂽID�̃t���O�����ĂĂ����B
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_572 end");
end

--��572_1�������A�j���I����
function OnEvent_572_1(proxy , param)
	print("OnEvent_572_1 begin");
	
	proxy:LuaCallStart( 572 , 1 );--���̖��폜����
	proxy:LuaCallStart( 571 , 1 );--�V���[�g�J�b�g�����̂ŁA���̖��@�ǂ�����
	--proxy:LuaCallStart( 570 , 1 );--�V���[�g�J�b�g�����̂ŁA���̖��@�ǂ�����
	
	print("OnEvent_572_1 end");
end

--�V���[�g�J�b�g
function OnEvent_566(proxy,param)
	if proxy:IsClient() == false then
		print("OnEvent_566 begin");
		proxy:SetEventFlag(566,true);
		if proxy:IsCompleteEvent(571) == false then
			proxy:SetEventFlag( 571,true);
			proxy:LuaCallStart( 571 , 1 );--���̖��폜����		
		end
		if proxy:IsCompleteEvent(572) == false then
			proxy:SetEventFlag( 572 ,true);
			proxy:LuaCallStart( 572 , 1 );--���̖��폜����
		end
		print("OnEvent_566 end");
	end
end


--------------------------------------------------------------------------------------
--��573���n���h���񂵂ăt���A�ړ���
--------------------------------------------------------------------------------------
function OnEvent_573(proxy,param)
	--����ON�Ȃ�A�j����	
	if proxy:IsCompleteEvent(576) == true and proxy:IsCompleteEvent(578) == true then
		--�����҂����C���t�H
		if param:IsNetMessage() == false then
			--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\��
			--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010170, 1);
			--proxy:ShowGenDialog(10010170,1,1,true);
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				--proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010170, 0, 6, 1244, GEN_DIALOG_DIST, once );
				proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010170, 0, 6, -1, GEN_DIALOG_DIST, once );				
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();
		end
		return;
	end
	
	print("OnEvent_573 begin");
	if proxy:IsCompleteEvent(574) == false then
		proxy:PlayAnimation(1243,1);
	else
		proxy:PlayAnimation(1243,2);
	end
	--����ON���A�j����
	proxy:SetEventFlag(576,true);
	proxy:SetEventFlag(578,true);	
	
	proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			if proxy:IsCompleteEvent(574) == false then
				proxy:OnObjAnimEnd(573,1243,1,"OnEvent_573_1",once);
				proxy:SetEventFlag( 574 , true );
			else
				proxy:OnObjAnimEnd(573,1243,2,"OnEvent_573_1",once);
				proxy:SetEventFlag( 574 , false );
			end
		proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();	
	
	if Luafunc_PlaySynchroAnimation(proxy,param,ANIMEID_TURN_HANDLE) == true then		
		return;
	end
	
	proxy:WarpDmy(10000,1243,191);	
	print("OnEvent_573 end");
	
end

--�㉺�A�j�����ʏI��
function OnEvent_573_1(proxy,param)
	if proxy:IsClient() == false then
		print("OnEvent_573_1 begin");
		proxy:LuaCallStart(573,1);
		print("OnEvent_573_1 end");
	end
end

--�t���O����
function OnEvent_573_flag(proxy,param)
	print("OnEvent_573_flag begin");	
	if proxy:IsCompleteEvent(574) == false then
		--proxy:SetEventFlag(574,false);	--��ɂ���
		proxy:SetEventFlag(578,false);	--�����o�[�L��
	else
		--proxy:SetEventFlag(574,true);	--���ɂ���
		proxy:SetEventFlag(576,false);	--�ヌ�o�[�L��
	end
	print("OnEvent_573_flag end");
end


--------------------------------------------------------------------------------------
--��575����ɃG���x�[�^�[�Ăі߂���
--------------------------------------------------------------------------------------
function OnEvent_575(proxy,param)
	print("OnEvent_575 begin");
	--���ɏ�or�A�j����
	if proxy:IsCompleteEvent(576) == true then
		--�����҂����C���t�H
		if param:IsNetMessage() == false then
			--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\��
			--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010170, 1);
			--proxy:ShowGenDialog(10010170,1,1,true);
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010170, 0, 6, 1244, GEN_DIALOG_DIST, once );
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();
		end		
		print("flag 576 On");
		print("OnEvent_575 end");
		return;
	end	
	
	proxy:PlayAnimation(1244,1);
	if proxy:IsCompleteEvent(574) == false then
		proxy:PlayAnimation(1243,1);
	else
		proxy:PlayAnimation(1243,2);
	end
	--����ON���A�j����
	proxy:SetEventFlag(576,true);
	proxy:SetEventFlag(578,true);
	
	proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			if proxy:IsCompleteEvent(574) == false then
				proxy:OnObjAnimEnd(573,1243,1,"OnEvent_573_1",once);
				proxy:SetEventFlag( 574 , true );
			else
				proxy:OnObjAnimEnd(573,1243,2,"OnEvent_573_1",once);
				proxy:SetEventFlag( 574 , false );
			end
		proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	if Luafunc_PlaySynchroAnimation(proxy,param,ANIMEID_TURN_HANDLE) == true then		
		return;
	end	
	
	proxy:WarpDmy(10000,1244,191);		
	print("OnEvent_575 end");
end


--------------------------------------------------------------------------------------
--��577�����ɃG���x�[�^�[�Ăі߂���
--------------------------------------------------------------------------------------
function OnEvent_577(proxy,param)
	print("OnEvent_577 begin");
	--���ɉ�
	if proxy:IsCompleteEvent(578) == true then
		--�����҂����C���t�H
		if param:IsNetMessage() == false then
			--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\��
			--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010170, 1);
			--proxy:ShowGenDialog(10010170,1,1,true);
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010170, 0, 6, 1245, GEN_DIALOG_DIST, once );
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();
		end		
		print("flag 576 On");
		print("OnEvent_577 end");
		return;
	end
	
	proxy:PlayAnimation(1245,1);
	if proxy:IsCompleteEvent(574) == false then
		proxy:PlayAnimation(1243,1);
	else
		proxy:PlayAnimation(1243,2);
	end
	--����ON���A�j����
	proxy:SetEventFlag(576,true);
	proxy:SetEventFlag(578,true);
	
	proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			if proxy:IsCompleteEvent(574) == false then
				proxy:OnObjAnimEnd(573,1243,1,"OnEvent_573_1",once);
				proxy:SetEventFlag( 574 , true );
			else
				proxy:OnObjAnimEnd(573,1243,2,"OnEvent_573_1",once);
				proxy:SetEventFlag( 574 , false );
			end
		proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	if Luafunc_PlaySynchroAnimation(proxy,param,ANIMEID_TURN_HANDLE) == true then		
		return;
	end	
	
	proxy:WarpDmy(10000,1245,191);		
	
	print("OnEvent_577 end");
end


--------------------------------------------------------------------------------------
--��579�����_���[�WON��
--------------------------------------------------------------------------------------
function OnEvent_579(proxy,param)	
	print("OnEvent_579 begin");
	if param:IsNetMessage() == true then
		return;
	end
	--proxy:SetEventSpecialEffect(10000,10250);
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4069 , "OnEvent_FireDamage2_1",0.0,0,FIREDOM_COUNT2,once);
		FIREDOM_COUNT2 = FIREDOM_COUNT2 +1;
		if FIREDOM_COUNT2 > 10000 then
			FIREDOM_COUNT2 = 0;
		end
	proxy:NotNetMessage_end();
	IS_FIREAREA2 = true;
	print("OnEvent_579 end");
end

--------------------------------------------------------------------------------------
--��580�����_���[�WOFF��
--------------------------------------------------------------------------------------
function OnEvent_580(proxy,param)
	print("OnEvent_580 begin");
	if param:IsNetMessage() == true then
		return;
	end
	--proxy:EraseEventSpecialEffect(10000,10250);
	proxy:DeleteEvent( 4069 );
	IS_FIREAREA2 = false;
	print("OnEvent_580 end");
end

function OnEvent_FireDamage2_1(proxy,param)
	if IS_FIREAREA2 == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4069 , "OnEvent_FireDamage2_2",FIREDOM_TIME2,0,FIREDOM_COUNT2,once);
		proxy:NotNetMessage_end();
		if proxy:GetFloorMaterial( 10000 ) == 27 then
			proxy:CreateDamage_NoCollision(10330,400,10000,0,OFFSET2,0);
		end
		FIREDOM_COUNT2 = FIREDOM_COUNT2 +1;
		if FIREDOM_COUNT2 > 10000 then
			FIREDOM_COUNT2 = 0;
		end
	end
end

function OnEvent_FireDamage2_2(proxy,param)
	if IS_FIREAREA2 == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4069 , "OnEvent_FireDamage2_1",FIREDOM_TIME2,0,FIREDOM_COUNT2,once);
		proxy:NotNetMessage_end();
		if proxy:GetFloorMaterial( 10000 ) == 27 then
			proxy:CreateDamage_NoCollision(10330,400,10000,0,OFFSET2,0);
		end
		FIREDOM_COUNT2 = FIREDOM_COUNT2 +1;
		if FIREDOM_COUNT2 > 10000 then
			FIREDOM_COUNT2 = 0;
		end
	end
end


--------------------------------------------------------------------------------------
--��583���{�X�����̏��_���[�WON��
--------------------------------------------------------------------------------------
function OnEvent_583(proxy,param)	
	print("OnEvent_583 begin");
	if param:IsNetMessage() == true then
		return;
	end
	--proxy:SetEventSpecialEffect(10000,10240);
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4069 , "OnEvent_FireDamage3_1",0.0,0,FIREDOM_COUNT3,once);
		FIREDOM_COUNT3 = FIREDOM_COUNT3 +1;
		if FIREDOM_COUNT3 > 10000 then
			FIREDOM_COUNT3 = 0;
		end
	proxy:NotNetMessage_end();
	IS_FIREAREA3 = true;
	print("OnEvent_583 end");
end


--------------------------------------------------------------------------------------
--��584���{�X�����̏��_���[�WOFF��
--------------------------------------------------------------------------------------
function OnEvent_584(proxy,param)
	print("OnEvent_584 begin");
	if param:IsNetMessage() == true then
		return;
	end
	--proxy:EraseEventSpecialEffect(10000,10240);
	proxy:DeleteEvent( 4069 );
	IS_FIREAREA3 = false;
	print("OnEvent_584 end");
end

function OnEvent_FireDamage3_1(proxy,param)
	if IS_FIREAREA3 == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4069 , "OnEvent_FireDamage3_2",FIREDOM_TIME3,0,FIREDOM_COUNT3,once);
		proxy:NotNetMessage_end();
		if proxy:GetFloorMaterial( 10000 ) == 27 then
			proxy:CreateDamage_NoCollision(10340,400,10000,0,OFFSET3,0);
		end
		FIREDOM_COUNT3 = FIREDOM_COUNT3 +1;
		if FIREDOM_COUNT3 > 10000 then
			FIREDOM_COUNT3 = 0;
		end
	end
end

function OnEvent_FireDamage3_2(proxy,param)
	if IS_FIREAREA3 == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4069 , "OnEvent_FireDamage3_1",FIREDOM_TIME3,0,FIREDOM_COUNT3,once);
		proxy:NotNetMessage_end();
		if proxy:GetFloorMaterial( 10000 ) == 27 then
			proxy:CreateDamage_NoCollision(10340,400,10000,0,OFFSET3,0);
		end
		FIREDOM_COUNT3 = FIREDOM_COUNT3 +1;
		if FIREDOM_COUNT3 > 10000 then
			FIREDOM_COUNT3 = 0;
		end
	end
end


--------------------------------------------------------------------------------------
--�����n�V�S1�~�聡585
--------------------------------------------------------------------------------------
--��585���n�V�S1�~��X�^�[�g��
function OnEvent_585(proxy, param)
	print("OnEvent_585 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_585 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,2,2);				--�z�o�[�ړ����[�h�Ɉڍs
	proxy:HoverMoveValDmy(10000,1246,192,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,1);				--�C�x���g�R�}���hID(1)"�n�V�S�ォ���"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );--nCommandID �� �����̂Ƃ�0 �΂߂̂Ƃ�4
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(585,"OnEvent_585_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���)
		proxy:OnKeyTime2(585,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_585 end");
end

--��585_1���n�V�SA�~��X�^�[�g:�z�o�[�ړ��I����
function OnEvent_585_1(proxy, param)
	print("OnEvent_585_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_585_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,7,6);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_585_1 end");
end


--------------------------------------------------------------------------------------
--�����n�V�S1���聡586
--------------------------------------------------------------------------------------
--��586���n�V�S1����X�^�[�g��
function OnEvent_586(proxy, param)
	print("OnEvent_586 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_586 end");
		return;
	end
	
	--�͂�������ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,-1,1);			--�z�o�[�ړ����[�h�Ɉڍs
	proxy:HoverMoveValDmy(10000,1246,191,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,0);				--�C�x���g�R�}���hID(0)"�n�V�S�������"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );--nCommandID �� �����̂Ƃ�0 �΂߂̂Ƃ�4
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂�������X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(586,"OnEvent_586_1",LadderTime_A,0,0,once);
		--�͂�������p�̊֐���1�b�Ԕ��s(�C�x���g���j���[�̒��f����?)
		proxy:OnKeyTime2(586,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_586 end");
end

--��586_1���n�V�S1����X�^�[�g:�z�o�[�ړ��I����
function OnEvent_586_1(proxy, param)
	print("OnEvent_586_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_586_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,-1,6);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_586_1 end");
end



--------------------------------------------------------------------------------------
--�����n�V�S2�~�聡587
--------------------------------------------------------------------------------------
--��587���n�V�S2�~��X�^�[�g��
function OnEvent_587(proxy, param)
	print("OnEvent_587 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_587 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,2,2);				--�z�o�[�ړ����[�h�Ɉڍs
	proxy:HoverMoveValDmy(10000,1247,192,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,1);				--�C�x���g�R�}���hID(1)"�n�V�S�ォ���"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );--nCommandID �� �����̂Ƃ�0 �΂߂̂Ƃ�4
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(587,"OnEvent_587_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���)
		proxy:OnKeyTime2(587,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_587 end");
end

--��587_1���n�V�SA�~��X�^�[�g:�z�o�[�ړ��I����
function OnEvent_587_1(proxy, param)
	print("OnEvent_587_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_587_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,7,6);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_587_1 end");
end


--------------------------------------------------------------------------------------
--�����n�V�S2���聡588
--------------------------------------------------------------------------------------
--��588���n�V�S2����X�^�[�g��
function OnEvent_588(proxy, param)
	print("OnEvent_588 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_588 end");
		return;
	end
	
	--�͂�������ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,-1,1);			--�z�o�[�ړ����[�h�Ɉڍs
	--proxy:HoverMoveVal(10000,2003,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:HoverMoveValDmy(10000,1247,191,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,0);				--�C�x���g�R�}���hID(0)"�n�V�S�������"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );--nCommandID �� �����̂Ƃ�0 �΂߂̂Ƃ�4
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂�������X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(588,"OnEvent_588_1",LadderTime_A,0,0,once);
		--�͂�������p�̊֐���1�b�Ԕ��s(�C�x���g���j���[�̒��f����?)
		proxy:OnKeyTime2(588,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_588 end");
end

--��588_1���n�V�S2����X�^�[�g:�z�o�[�ړ��I����
function OnEvent_588_1(proxy, param)
	print("OnEvent_588_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_588_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,-1,6);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_588_1 end");
end



--------------------------------------------------------------------------------------
--�����n�V�S3�~�聡589
--------------------------------------------------------------------------------------
--��589���n�V�S3�~��X�^�[�g��
function OnEvent_589(proxy, param)
	print("OnEvent_589 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_589 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,2,2);				--�z�o�[�ړ����[�h�Ɉڍs
	proxy:HoverMoveValDmy(10000,1248,192,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,1);				--�C�x���g�R�}���hID(1)"�n�V�S�ォ���"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );--nCommandID �� �����̂Ƃ�0 �΂߂̂Ƃ�4
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(589,"OnEvent_589_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���)
		proxy:OnKeyTime2(589,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_589 end");
end

--��589_1���n�V�SA�~��X�^�[�g:�z�o�[�ړ��I����
function OnEvent_589_1(proxy, param)
	print("OnEvent_589_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_589_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,7,6);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_589_1 end");
end


--------------------------------------------------------------------------------------
--�����n�V�S3���聡590
--------------------------------------------------------------------------------------
--��590���n�V�S3����X�^�[�g��
function OnEvent_590(proxy, param)
	print("OnEvent_590 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_590 end");
		return;
	end
	
	--�͂�������ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,-1,1);			--�z�o�[�ړ����[�h�Ɉڍs
	--proxy:HoverMoveVal(10000,2003,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:HoverMoveValDmy(10000,1248,191,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,0);				--�C�x���g�R�}���hID(0)"�n�V�S�������"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );--nCommandID �� �����̂Ƃ�0 �΂߂̂Ƃ�4
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂�������X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(590,"OnEvent_590_1",LadderTime_A,0,0,once);
		--�͂�������p�̊֐���1�b�Ԕ��s(�C�x���g���j���[�̒��f����?)
		proxy:OnKeyTime2(590,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_590 end");
end

--��590_1���n�V�S3����X�^�[�g:�z�o�[�ړ��I����
function OnEvent_590_1(proxy, param)
	print("OnEvent_590_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_590_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,-1,6);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_590_1 end");
end



--------------------------------------------------------------------------------------
--�n�V�S4�~�聡591
--------------------------------------------------------------------------------------
--��591���n�V�S4�~��X�^�[�g��
function OnEvent_591(proxy, param)
	print("OnEvent_591 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_591 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,2,2);				--�z�o�[�ړ����[�h�Ɉڍs
	proxy:HoverMoveValDmy(10000,1249,192,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,1);				--�C�x���g�R�}���hID(1)"�n�V�S�ォ���"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );--nCommandID �� �����̂Ƃ�0 �΂߂̂Ƃ�4
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(591,"OnEvent_591_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���)
		proxy:OnKeyTime2(591,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_591 end");
end

--��591_1���n�V�SA�~��X�^�[�g:�z�o�[�ړ��I����
function OnEvent_591_1(proxy, param)
	print("OnEvent_591_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_591_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,17,16);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_591_1 end");
end


--------------------------------------------------------------------------------------
--�n�V�S4���聡592
--------------------------------------------------------------------------------------
--��592���n�V�S4����X�^�[�g��
function OnEvent_592(proxy, param)
	print("OnEvent_592 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_592 end");
		return;
	end
	
	--�͂�������ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,-1,1);			--�z�o�[�ړ����[�h�Ɉڍs
	proxy:HoverMoveValDmy(10000,1249,191,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,0);				--�C�x���g�R�}���hID(0)"�n�V�S�������"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );--nCommandID �� �����̂Ƃ�0 �΂߂̂Ƃ�4
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂�������X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(592,"OnEvent_592_1",LadderTime_A,0,0,once);
		--�͂�������p�̊֐���1�b�Ԕ��s(�C�x���g���j���[�̒��f����?)
		proxy:OnKeyTime2(592,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_592 end");
end

--��592_1���n�V�S4����X�^�[�g:�z�o�[�ړ��I����
function OnEvent_592_1(proxy, param)
	print("OnEvent_592_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_592_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,-1,16);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_592_1 end");
end



--------------------------------------------------------------------------------------
--�g�J�Q�C�x���g�ړ���594
--------------------------------------------------------------------------------------

--��594���g�J�Q�C�x���g�ړ���
function OnEvent_594(proxy, param)
	print("OnEvent_594 begin");

	--AI�̗̈�ړ��������邽�߃��W�b�N��ON�ɂ��Ă���
	
	proxy:EnableLogic( 321 , true );
	proxy:EnableLogic( 322 , true );
	
	proxy:NotNetMessage_begin();
		--��594���g�J�Q�C�x���g�ړ�(�C�x���g�J�n�̃^�C�~���O�����炷)��
		proxy:OnKeyTime2( 594 , "OnEvent_594_1" , 0.0 , 0 , 2 , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_594 end");
end


--��594���g�J�Q�C�x���g�ړ�(�C�x���g�J�n�̃^�C�~���O�����炷)��
function OnEvent_594_1(proxy, param)
	print("OnEvent_594_1 begin");	
	if proxy:IsCompleteEvent( 782 ) == false then
		proxy:ResetThink( 321 );	
		proxy:SendEventRequest( 321 , 0, 0 );
		--��596���g�J�QA : �̈�(2237)�ւ̓����Ď���
		proxy:OnRegionJustIn( 596 , 321 , 2237 , "OnEvent_596" , once );
	end	
	
	if proxy:IsCompleteEvent( 784 ) == false then
		proxy:ResetThink( 322 );
		proxy:SendEventRequest( 322 , 0 , 0);
		--��598���g�J�QB : �̈�(2237)�ւ̓����Ď���
		proxy:OnRegionJustIn( 598 , 322 , 2237 , "OnEvent_598" , once );
	end	
	--�C�x���g�t���O�Z�b�g	
	proxy:SetEventFlag( 594 , 1 );--�̈�p
	proxy:SetEventFlag( 595 , 1 );--�_���[�W�Ď��p

	--�Ď��폜	
	proxy:DeleteEvent( 594 );--�̈�p
	proxy:DeleteEvent( 595 );--�_���[�W�Ď��p
	
	print("OnEvent_594_1 end");
end


-----�g�J�QA---------------------------------------------------------------

--��596���g�J�QA : �̈�(2235)�ւ̓����Ď���
function OnEvent_596(proxy, param)
	print("OnEvent_596 begin");
	
	proxy:SetEventFlag( 600 , 1 );--�̈�(2237)�ɓ����ς�
	proxy:ChangeInitPosAng( 321 , 2237 );--�����ʒu�̗̈��(2237��)�X�V����
	
	proxy:EnableLogic( 321 , true );--���W�b�NON
	proxy:PlayAnimation( 321 , 3301 );--�g�J�Q������A�j��
	proxy:SendEventRequest( 321 , 0, -1 );

	print("OnEvent_596 end");
end

-----�g�J�QB---------------------------------------------------------------

--��598���g�J�QB : �̈�(2235)�ւ̓����Ď���
function OnEvent_598(proxy, param)
	print("OnEvent_598 begin");
	
	proxy:SetEventFlag( 601 , 1 );--�̈�(2237)�ɓ����ς�
	proxy:ChangeInitPosAng( 322 , 2237 );--�����ʒu�̗̈��(2237��)�X�V����
	
	proxy:EnableLogic( 322 , true );--���W�b�NON
	proxy:PlayAnimation( 322 , 3301 );--�g�J�Q������A�j��
	proxy:SendEventRequest( 322 , 0, -1 );

	print("OnEvent_598 end");
end


--[[------------------------------------------------------------------------------------
--�n�[�t�n���h��ԊǗ���602
--------------------------------------------------------------------------------------

--��602���n�[�t�n���h��ԊǗ���
function OnEvent_602(proxy, param)
	print("OnEvent_602 begin");

	--���݂̏�Ԏ擾
	local now_state = GetNpcStateFlag( proxy , param , half_flag_list );
	
	--�u�B���ł܂v�łȂ��ꍇ�͏�������
	if now_state ~= HALF_STATE_WAIT_KOUDOU then
		print("OnEvent_602 end");
		return;
	end
	
	--�n�[�t�n���h�̏�ԃt���O���u�Β��ɍs�������v�ɂ���
	SetNpcStateFlag(proxy, param, half_flag_list, HALF_STATE_GO_TO_SEKITYU );
	proxy:SetEventFlag( 602 , 1 );--���s�[�g�łȂ��w��Ȃ̂Ńt���O�𗧂ĂĂ����B
	
	print("OnEvent_602 end");
end
]]

--------------------------------------------------------------------------------------
--�n�[�t�n���h�G�΁�603
--------------------------------------------------------------------------------------

--��603���n�[�t�n���h�G�΁�
function OnEvent_603(proxy, param)
	print("OnEvent_603 begin");

	proxy:EnableLogic( 661 , true );--[[���W�b�NON ���W�b�N�؂�ւ�?]]
	
	--�n�[�t�n���h�̏�ԃt���O���u�G��(�B��)�v�ɂ���
	SetNpcStateFlag(proxy, param, half_flag_list, HALF_STATE_HOSTILE_KOUDOU );
	--�G�ΐݒ�
	proxy:SetTeamType( 661, TEAM_TYPE_AngryFriend);
	proxy:SetEventFlag( 603 , 1 );
	
	print("OnEvent_603 end");
end


--------------------------------------------------------------------------------------
--�n�[�t�n���h��ԊǗ���604
--------------------------------------------------------------------------------------

--��604���n�[�t�n���h���S��
function OnEvent_604(proxy, param)
	print("OnEvent_604 begin");

	--�n�[�t�n���h�̏�ԃt���O���u���S�v�ɂ���
	SetNpcStateFlag(proxy, param, half_flag_list, HALF_STATE_DEAD );
	proxy:SetEventFlag( 604 , 1 );
	
	print("OnEvent_604 end");
end

--�n�[�t�n���h�E�u���b�N�S�[�X�g�����S�������ǂ����̃t���O�Z�b�g
function OnEvent_675(proxy, param)
	print("OnEvent_675 begin");
	--���S�����t���O�𗧂Ă�
	proxy:SetEventFlag( 675, true );
		
	print("OnEvent_675 end");
end

--�n�[�t�n���h�E�u���b�N�̎��̂𒲂ׂĂȂ�
function OnEvent_15604(proxy,param)
	print("OnEvent_15604 begin");
	proxy:SetEventFlag( 15604 , true );
	print("OnEvent_15604 end");
end

--�n�[�t�n���h�̎��̂𒲂ׂĂȂ�
function OnEvent_15632(proxy,param)
	print("OnEvent_15632 begin");
	proxy:SetEventFlag( 15632 , true );
	print("OnEvent_15632 end");
end

--�n�[�t�n���h����A�C�e���擾
function OnEvent_643(proxy,param)
	print("OnEvent_643 begin");
	
	proxy:SetEventFlag( 643,true );
	
	proxy:GetRateItem( 16640 );--�A�C�e�����I�p�����[�^16640�Q��
	--proxy:GetRateItem( 16641 );--�A�C�e�����I�p�����[�^16641�Q��
	print("OnEvent_643 end");
end

--------------------------------------------------------------------------------------
--�N�}���V�Ƃ���Ձ�607
--------------------------------------------------------------------------------------
function OnEvent_607(proxy,param)
	print("OnEvent_607 begin");
	proxy:LuaCallStart( 607 , 0 );
	print("OnEvent_607 end");
end

function OnEvent_607_0(proxy,param)
	print("OnEvent_607_0 begin");		
	print("I Can Flay!!!!");
	proxy:PlayAnimation( 323,9200);
	
	proxy:NotNetMessage_begin();
		--��э~��A�j�����I�������p�b�`�p�̗̈�Ď��ǉ�
		proxy:OnChrAnimEnd(607, 323, 9200, "OnEvent_607_1", once);
		if proxy:IsCompleteEvent(642) == true then	--�p�b�`���C�x���g���N�������ԂȂ��
			proxy:OnRegionJustIn(609,10000,2258,"OnEvent_609",once);--�p�b�`���ړ������肷��C�x���g�̊Ď��ǉ�	
		end
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( 607 ,true );
	print("OnEvent_607_0 end");
end

function OnEvent_607_1(proxy,param)
	print("OnEvent_607_1 begin");
	
	--�N�}���V�̓���ҋ@�A�j������������
	proxy:SetSpStayAndDamageAnimId(323,-1,-1);--����ҋ@�A�j���̖�����	
	
	print("OnEvent_607_1 end");
end

--�N�}���V�E�Q
function OnEvent_646(proxy,param)
	print("OnEvent_646 begin");
	--㩂ɂ͂߂����������@�N�}���V�|�����Ɉڍs�ł���	
	if 	proxy:IsCompleteEvent( BATTI_TRAP_M6 ) == true then	
		SetNpcStateFlag( proxy, param, batti_flag_list, BATTI_DESTORYKUMA );--�o�b�`�̏�Ԃ��u�N�}���V�E�����v�ɕύX����B
		proxy:SetEventFlag( 646,true );
	end	
	proxy:DeleteEvent( 609 );
	--�̈悩��o��悤�̓G�΃C�x���g���폜
	proxy:DeleteEvent( 662 );
	--proxy:SetEventFlag( 609,true);
	print("OnEvent_646 end");
end

--------------------------------------------------------------------------------------
--��~�~�Y�o�ꁡ620
--------------------------------------------------------------------------------------
function OnEvent_620(proxy,param)
	print("OnEvent_620 begin");
	ValidCharactor( proxy, 324 );
	proxy:StopLoopAnimation( 324 );
	proxy:ForcePlayAnimation( 324, 9010 );
	proxy:EnableLogic( 324, true );	
	proxy:SetEventFlag( 620 , true );
	print("OnEvent_620 end");
end

--------------------------------------------------------------------------------------
--��~�~�Y�o�ꁡ621
--------------------------------------------------------------------------------------
function OnEvent_621(proxy,param)
	print("OnEvent_621 begin");
	ValidCharactor( proxy, 325 );
	proxy:StopLoopAnimation( 325 );
	proxy:ForcePlayAnimation( 325, 9010 );
	proxy:EnableLogic( 325, true );	
	proxy:SetEventFlag( 621 , true );
	print("OnEvent_621 end");
end

--------------------------------------------------------------------------------------
--��~�~�Y�o�ꁡ622
--------------------------------------------------------------------------------------
function OnEvent_622(proxy,param)
	print("OnEvent_622 begin");
	ValidCharactor( proxy, 326 );
	proxy:StopLoopAnimation( 326 );
	proxy:ForcePlayAnimation( 326, 9010 );
	proxy:EnableLogic( 326, true );	
	proxy:SetEventFlag( 622 , true );
	print("OnEvent_622 end");
end

--------------------------------------------------------------------------------------
--��~�~�Y�o�ꁡ623
--------------------------------------------------------------------------------------
function OnEvent_623(proxy,param)
	print("OnEvent_623 begin");
	ValidCharactor( proxy, 327 );
	proxy:StopLoopAnimation( 327 );
	proxy:ForcePlayAnimation( 327, 9010 );
	proxy:EnableLogic( 327, true );	
	proxy:SetEventFlag( 623 , true );
	print("OnEvent_623 end");
end

--------------------------------------------------------------------------------------
--��~�~�Y�o�ꁡ624
--------------------------------------------------------------------------------------
function OnEvent_624(proxy,param)
	print("OnEvent_624 begin");
	ValidCharactor( proxy, 328 );
	proxy:StopLoopAnimation( 328 );
	proxy:ForcePlayAnimation( 328, 9010 );
	proxy:EnableLogic( 328, true );	
	proxy:SetEventFlag( 624 , true );
	print("OnEvent_624 end");
end

--------------------------------------------------------------------------------------
--��~�~�Y�o�ꁡ625
--------------------------------------------------------------------------------------
function OnEvent_625(proxy,param)
	print("OnEvent_625 begin");
	ValidCharactor( proxy, 329 );
	proxy:StopLoopAnimation( 329 );
	proxy:ForcePlayAnimation( 329, 9010 );
	proxy:EnableLogic( 329, true );	
	proxy:SetEventFlag( 625 , true );
	print("OnEvent_625 end");
end

--[[
--------------------------------------------------------------------------------------
--��~�~�Y�o�ꁡ626
--------------------------------------------------------------------------------------
function OnEvent_626(proxy,param)
	print("OnEvent_626 begin");
	ValidCharactor( proxy, 330 );
	proxy:StopLoopAnimation( 330 );
	proxy:ForcePlayAnimation( 330, 9010 );
	proxy:EnableLogic( 330, true );	
	proxy:SetEventFlag( 626 , true );
	print("OnEvent_626 end");
end
]]

--------------------------------------------------------------------------------------
--�o�b�`�ړ��C�x���g1��609
--------------------------------------------------------------------------------------
function OnEvent_609(proxy,param)	
	--㩂ɂ͂߂��������������Ă���
	if proxy:IsCompleteEvent( BATTI_TRAP_M6 ) == true then
		print("OnEvent_609 begin");
		proxy:ResetThink(662);
		--AI�֖��߂𑗂�
		proxy:SendEventRequest(662, 0, 1);
		
		--���荞�݋֎~�Ń|�C���g�ړ�
		proxy:EnableLogic(662,true);
		--proxy:DisableInterupt(662,true);
		MoveRegion(proxy, 662, 2240,-1,0.0,false);
		proxy:LuaCallStart(612,0);

		proxy:SetEventFlag( 609,true);
		print("OnEvent_609 end");
	end	
end

--[[
--------------------------------------------------------------------------------------
--�o�b�`�ړ��C�x���g2��610
--------------------------------------------------------------------------------------
--�o�^&�ړ��p
function OnEvent_610(proxy,param)
	print("OnEvent_610 begin");	
	proxy:OnRegionIn(610,662,2240,"OnEvent_610_1",once);--�o�b�`��2240�ɓ���������
	print("OnEvent_610 end");
end

--����
function OnEvent_610_1(proxy,param)
	print("OnEvent_610_1 begin");
	--���荞�݋֎~�Ń|�C���g�ړ�
	proxy:DisableInterupt(662,true);
	MoveRegion(proxy,662, 2241, -1, 0.0, false);
	proxy:LuaCallStart(611,0);
	print("OnEvent_610_1 end");
end


--------------------------------------------------------------------------------------
--�o�b�`�ړ��C�x���g3��611
--------------------------------------------------------------------------------------
--�o�^&�ړ��p
function OnEvent_611(proxy,param)
	print("OnEvent_611 begin");	
	proxy:OnRegionIn(611,662,2241,"OnEvent_611_1",once);--�o�b�`��2241�ɓ���������
	print("OnEvent_611 end");
end

--����
function OnEvent_611_1(proxy,param)
	print("OnEvent_611_1 begin");
	--���荞�݋֎~�Ń|�C���g�ړ�
	proxy:DisableInterupt(662,true);
	MoveRegion(proxy,662, 2242, -1, 0.0, false);
	proxy:LuaCallStart(612,0);
	print("OnEvent_611_1 end");
end
]]

--------------------------------------------------------------------------------------
--�o�b�`�����Ď���612
--------------------------------------------------------------------------------------
function OnEvent_612(proxy,param)
	print("OnEvent_612 begin");
	--proxy:OnRegionIn(611,662,2242,"OnEvent_612_1",once);--�o�b�`��2242�ɓ���������
	proxy:ResetThink(662);
	proxy:SendEventRequest(662, 0, 1);
	MoveRegion(proxy, 662, 2242,-1,0.0,false);
	proxy:OnRegionIn(611,662,2242,"OnEvent_612_1",once);--�o�b�`��2241�ɓ���������
	--�̈悩��o��悤�̓G�΃C�x���g���폜
	proxy:DeleteEvent( 662 );
	print("OnEvent_612 end");
end

--����
function OnEvent_612_1(proxy,param)
	print("OnEvent_612_1 begin");
	--AI�֖��߂𑗂�
	proxy:SendEventRequest(662, 0, -1);
	proxy:ResetThink(662);
	proxy:ChangeInitPosAng( 662,2242);
	proxy:EnableLogic(662,true);
	--�܂��󂪎c���Ă���Ȃ�
	if proxy:IsCompleteEvent(615) == false then
		
		if proxy:IsCompleteEvent(646) == false then
			--�o�b�`�A�C�e���擾�A�j��
			proxy:PlayAnimation(662,ANIMEID_PICK);
			--�A�C�e���\������
			proxy:LuaCallStart(615,0);
			--�A�C�e���擾�C�x���g�폜
			proxy:DeleteEvent(615);
			proxy:SetEventFlag(615,true);
			SetNpcStateFlag( proxy, param, batti_flag_list, BATTI_TREASURE_M6 );--�o�b�`�̏�Ԃ��u��͂����������v�ɕύX����B
		
			proxy:SetEventFlag(15487,true);--�o�b�`�C�x���g�p�A�C�e���擾�p�����[�^�[ON
		end
	end
	
	print("OnEvent_612_1 end");
end


--PC���A�C�e���Ƃ�����615--------------------------------------------------------------------
function OnEvent_615(proxy,param)
	print("OnEvent_615 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--�V�����A�j�� 
		print("OnEvent_615 end");
		return true;
	end

	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 615, "OnEvent_615_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();	
	
	print("OnEvent_615 end");
end

--��615_1���A�C�e���擾��
function OnEvent_615_1(proxy, param)
	print("OnEvent_615_1 begin");

	--���݂̏�Ԃ��擾
	local now_state = GetNpcStateFlag( proxy , param , batti_flag_list );
	
	--�A�C�e���擾�֐�--�p�����[�^10600�Q��
	proxy:GetRateItem(10600);	
	
	--��\�������Ăяo��
	proxy:LuaCallStart(615,0);
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag(615,true);
	
--�p�b�`��擾���s��614
	--㩂ɂ͂߂���--��͒����� �̎��̂݁A�c�O�ɏ�Ԃ�ω�������
	if now_state == BATTI_TRAP_M6 or now_state == BATTI_TREASURE_M6 then
		--print("�o�b�`�͕�̎擾�Ɏ��s����");
		SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_VEXING_M6);--�o�b�`�̏�Ԃ��u�c�O(�B��)�v�ɕύX
	end
	print("OnEvent_615_1 end");
end
-------------------------------------------------------------------------------------------

--��615_2����OFF��
function OnEvent_615_2(proxy,param)
	print("OnEvent_615_2 begin");
	proxy:TreasureDispModeChange2(1250,false,99010);
	print("OnEvent_615_2 end");
end

--��615_3���o�b�`��ԕω���
function OnEvent_615_3(proxy,param)
	print("OnEvent_615_3 begin");

	--���݂̏�Ԃ��擾
	local now_state = GetNpcStateFlag( proxy , param , batti_flag_list );

	--�����A�o�b�`�̏�Ԃ��u㩂ɂ͂߂����v�Ȃ�΁c
	if now_state == BATTI_TRAP_M6 then
		--print("�o�b�`�̏�Ԃ��u�c�O�v�ɕω�����");
		SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_VEXING_M6);--�o�b�`�̏�Ԃ��u�c�O(�B��)�v�ɕύX
	end
	print("OnEvent_615_3 end");
end

--------------------------------------------------------------------------------------
--�N�}���V�g���b�v�̃o�b�`���OnEvent
--------------------------------------------------------------------------------------
--��640��
function OnEvent_640(proxy, param)
	print("OnEvent_640 begin");
	--�N�}���V�����łȂ��āA�A�C�e��������Ă��Ȃ�
	if proxy:IsCompleteEvent(607) == false and proxy:IsCompleteEvent(615) == false then
		--proxy:SetEventFlag( 640, true );
		
		--[*�o�b�`�֘A*]
		--proxy:SetEventFlag( 612, true );--�A�C�e���֋삯�čs�������𖳌�
		
		--[*�N�}���V�֘A*]
		
		--proxy:SetEventFlag( 607, true );--���łɔ��ł��܂������ɂ��āA�g���b�v�𖳌�������
	end
	print("OnEvent_640 end");
end
--��641��
function OnEvent_641(proxy, param)
	print("OnEvent_641 begin");
	--�N�}���V�����łȂ��āA�A�C�e��������Ă��Ȃ��B
	if proxy:IsCompleteEvent(607) == false and proxy:IsCompleteEvent(615) == false then
		proxy:SetEventFlag( 641, true );
		
		--[*�o�b�`�֘A*]
		--�A�C�e���֋삯�čs�������𖳌�
		proxy:SetEventFlag( 612, true );
		
		--[*�N�}���V�֘A*]
		proxy:Warp( 323, 2261 );--�N�}���V�̈ړ��i���[�v�j
		--�W�����v����̈�ւ̊Ď����J�n
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionJustIn(607,10000,2258,"OnEvent_607",once);
			proxy:NotNetMessage_end();
		end
		proxy:LuaCall( 604 , 0 , "OnEvent_607_0",once);
	end
	
	print("OnEvent_641 end");
end

--��642��
function OnEvent_642(proxy, param)
	print("OnEvent_642 begin");
	if proxy:IsCompleteEvent( 642 ) == false then
		--�N�}���V�����łȂ��āA�A�C�e��������Ă��Ȃ��B
		if proxy:IsCompleteEvent(615) == false then
			proxy:SetEventFlag( 642, true );
			
			--[*�o�b�`�֘A*]
			proxy:EnableLogic( 662 , true );--�o�b�`�̃��W�b�NON
			--��Ԃ��u㩂ɂ͂߂����v�i16246�j�ɂ���
			SetNpcStateFlag(proxy, param, batti_flag_list, BATTI_TRAP_M6 );
			--�ړ��P�o�^
			--�N�}���V���W�����v������*proxy:OnRegionJustIn(609,10000,2258,"OnEvent_609",once);		
			--�ړ��Q�o�^
			proxy:LuaCall(610,0,"OnEvent_610",once);
			--�ړ��R�o�^
			proxy:LuaCall(611,0,"OnEvent_611",once);
			--�����Ď��o�^
			proxy:LuaCall(612,0,"OnEvent_612",once);
			
			if proxy:IsCompleteEvent(607) == false then
				--[*�N�}���V�֘A*]
				proxy:Warp( 323, 2261 );--�N�}���V�̈ړ��i���[�v�j
				--�W�����v����̈�ւ̊Ď����J�n
				proxy:NotNetMessage_begin();
					if proxy:IsClient() == false then
						proxy:OnRegionJustIn(607,10000,2258,"OnEvent_607",once);
					end
				proxy:NotNetMessage_end();
				proxy:LuaCall( 607 , 0 , "OnEvent_607_0",once);
			else
				OnEvent_609(proxy,param);
				proxy:Warp( 323 , 2239 );
			end
		else
			--������(������������������Ȃ��������ɕ\�����Ȃ�����)
			--print("�N�}���V���A�C�e���������łɖ����ł�");
			--InvalidBackRead(proxy,662);--�o�b�`
		end
	end
	print("OnEvent_642 end");
end

--------------------------------------------------------------------------------------
--�o�b�`���G�΂��遡616
--------------------------------------------------------------------------------------
--�G��
function OnEvent_616(proxy,param)
	print("OnEvent_616 begin");	
	proxy:EnableLogic(662,true);
	proxy:SetTeamType(662, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
	SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_ANGRY_M6);--�G�Ώ�Ԃ�
	
	--�A�C�e���ւ����čs���C�x���g�̏���
	proxy:DeleteEvent( 609 );
	
	proxy:SetEventFlag(616,true);
	proxy:SetEventFlag(662,true);
	print("OnEvent_616 end");
end

--------------------------------------------------------------------------------------
--�p�b�`�����S��617
--------------------------------------------------------------------------------------
--���S
function OnEvent_617(proxy,param)
	print("OnEvent_617 begin");
	proxy:SetEventFlag(617,true);
	SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_DEAD);--���S��Ԃ�		
	print("OnEvent_617 end");
end


--------------------------------------------------------------------------------------
--�p�b�`����A�C�e�����炤��660
--------------------------------------------------------------------------------------
function OnEvent_660(proxy,param)
	print("OnEvent_660 begin");
	proxy:GetRateItem(10625);
	proxy:SetEventFlag( 660, true );
	
	proxy:SetEventFlag(15487,false);--�o�b�`�C�x���g�p�A�C�e���擾�p�����[�^�[OFF
	
	SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_PRESENT);--�A�C�e����������Ԃ�
	
	print("OnEvent_660 end");
end


--------------------------------------------------------------------------------------
--�Ď��̈�Ƀz�X�g����������645
--------------------------------------------------------------------------------------
function OnEvent_645(proxy,param)
	print("OnEvent_645 begin");
	proxy:LuaCallStart( 645 , 1 );
	print("OnEvent_645 end");
end


--------------------------------------------------------------------------------------
--�z�M�p��660
--------------------------------------------------------------------------------------
function OnEvent_645_1(proxy,param)
	print("OnEvent_645_1 begin");
	proxy:SetSpStayAndDamageAnimId( 662 , -1,-1);
	proxy:SetEventFlag( 645 , true ); 
	print("OnEvent_645_1 end");
end


--------------------------------------------------------------------------------------
--��H��ԊǗ���650
--------------------------------------------------------------------------------------
function OnEvent_650(proxy,param)
	print("OnEvent_650 begin");
		
	SetNpcStateFlag(proxy,param,SHOP_Flag_list,SHOP_NORMAL_2);
	proxy:SetEventFlag(650,true);

	print("OnEvent_650 end");
end

function OnEvent_650_1(proxy, param)
	print("OnEvent_650_1 begin");
	
	proxy:EnableLogic( 663 , true );
	proxy:EnableLogic( 676 , true );
	
	SetNpcStateFlag(proxy,param,SHOP_Flag_list,SHOP_HOSTILE_2);
	proxy:SetTeamType( 663, TEAM_TYPE_AngryFriend );
	proxy:SetTeamType( 676, TEAM_TYPE_AngryFriend );
	proxy:SetEventFlag(650,true);
	proxy:SetEventFlag(160,true);

	print("OnEvent_650_1 end");
end

--------------------------------------------------------------------------------------
--��H��ԊǗ���651
--------------------------------------------------------------------------------------

--��161����H���S��
function OnEvent_651(proxy, param)
	print("OnEvent_651 begin");

	--��H�̏�ԃt���O���u���S�v�ɂ���
	SetNpcStateFlag(proxy, param, SHOP_Flag_list, SHOP_DEAD );
	proxy:SetEventFlag( 651 , 1 );
	proxy:SetEventFlag( 161 , 1 );
	
	print("OnEvent_651 end");
end

--------------------------------------------------------------------------------------
--��525���{�X�J�����؂�ւ��C�x���g��
--------------------------------------------------------------------------------------
function OnEvent_525(proxy,param)
	--print("OnEvent_525 begin");
	--�{�X������ł��Ȃ��@���@�{�X�Ƃ̐퓬���J�n���Ă���
	if proxy:IsCompleteEvent( 6272 ) == false and proxy:IsCompleteEvent( 523 ) == true then
		--�{�X��@�񃍃b�N�J����
		proxy:SetCamModeParamTargetId(6021);
		--�{�X��@���b�N�J����
		proxy:SetCamModeParamTargetIdForBossLock(6020);
	end
	--print("OnEvent_525 end");
end


--------------------------------------------------------------------------------------
--��690���g���b�R�g���b�v1��
--------------------------------------------------------------------------------------
function OnEvent_690(proxy,param)
	print("OnEvent_690 begin");
	
	proxy:NotNetMessage_begin();
		proxy:PlayAnimation( 1290 , 1);
		proxy:OnCharacterAnimEnd( 690 , 1290 , 1 ,"OnEvent_690_1",once);
	proxy:NotNetMessage_end();	
	--�g���b�R����_���[�W
	local paramid = 10140;
	local rad     = 0.5;
	local time    = 40;	
	proxy:NotNetMessage_begin();		
		proxy:OnObjectDamageHit_NoCall( 690, 1290, 2, paramid, EV_HIT_CHR , rad, time, everytime );
	proxy:NotNetMessage_end();	
	
	proxy:SetEventFlag( 690 , true );	
	print("OnEvent_690 end");
end

--�g���b�R�̃A�j����~
function OnEvent_690_1(proxy,param)
	proxy:DeleteEvent(690);
	proxy:SetEventFlag( 900 , true );
end


--------------------------------------------------------------------------------------
--��691���E�B���I�E�B�X�v����1��
--------------------------------------------------------------------------------------
function OnEvent_691(proxy,param)
	print("OnEvent_691 begin");
	proxy:DeleteObjSfxEventID( 1290 );
	proxy:SetObjSfx( 1290 , 1 , 96002 , false );
	proxy:SetEventFlag( 691 ,true );	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 691 , "OnEvent_691_1",1.2,0,0,once);
	proxy:NotNetMessage_end();	
	print("OnEvent_691 end");
end

function OnEvent_691_1(proxy,param)
	print("OnEvent_691_1 begin");
	proxy:DeleteObjSfxEventID( 1290 );
	--proxy:CastPointSpell_Horming( 400 , 1290 , 10160 , 0,0,0, 1290);
	proxy:CastTargetSpell(400,1290,1,1290,10161);
	proxy:AddRumble(121, 1290, -1,1.0, 25.0);
	print("OnEvent_691_1 end");
end

--------------------------------------------------------------------------------------
--��696���g���b�R�j��P��
--------------------------------------------------------------------------------------
function OnEvent_696(proxy,param)
	print("OnEvent_696 begin");
	proxy:SetEventFlag( 696 , true );
	proxy:ObjRootMtxMoveDmyPoly( 1290 , 1 );	
	proxy:ChangeModel( 1290 , 1 );
	proxy:SetFirstSpeedPlus( 1290 , 2, 3.5  ,6 , 1);
	proxy:SetBrokenPiece( 1290 );
	proxy:PlayTypeSE( 1290 , SOUND_TYPE_O , 620100000 );
	print("OnEvent_696 end");
end
--------------------------------------------------------------------------------------
--��692���g���b�R�g���b�v2��
--------------------------------------------------------------------------------------
function OnEvent_692(proxy,param)
	print("OnEvent_692 begin");
	
	proxy:NotNetMessage_begin();
		proxy:PlayAnimation( 1291 , 1);
		proxy:OnCharacterAnimEnd( 692 , 1291 , 1 ,"OnEvent_692_1",once);
	proxy:NotNetMessage_end();	
	--�g���b�R����_���[�W
	local paramid = 10140;
	local rad     = 0.5;
	local time    = 40;	
	proxy:NotNetMessage_begin();		
		proxy:OnObjectDamageHit_NoCall( 692, 1291, 2, paramid, EV_HIT_CHR , rad, time, everytime );
	proxy:NotNetMessage_end();	
	
	proxy:SetEventFlag( 692 , true );	
	print("OnEvent_692 end");
end

--�g���b�R�̃A�j����~
function OnEvent_692_1(proxy,param)
	proxy:DeleteEvent(692);
	proxy:SetEventFlag( 902 , true );
end


--------------------------------------------------------------------------------------
--��693���E�B���I�E�B�X�v����2��
--------------------------------------------------------------------------------------
function OnEvent_693(proxy,param)
	print("OnEvent_693 begin");
	proxy:DeleteObjSfxEventID( 1291 );	
	proxy:SetObjSfx( 1291 , 1 , 96002 , false );
	
	proxy:SetEventFlag( 693 ,true );	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 693 , "OnEvent_693_1",1.2,0,0,once);
	proxy:NotNetMessage_end();
	print("OnEvent_693 end");
end

function OnEvent_693_1(proxy,param)
	print("OnEvent_693_1 begin");
	proxy:DeleteObjSfxEventID( 1291 );
	--proxy:CastPointSpell_Horming( 400 , 1291 , 10160 , 0,0,0, 1291);
	proxy:CastTargetSpell(400,1291,1,1291,10161);
	proxy:AddRumble(121, 1291, -1,1.0, 25.0);
	print("OnEvent_693_1 end");
end

--------------------------------------------------------------------------------------
--��697���g���b�R�j��Q��
--------------------------------------------------------------------------------------
function OnEvent_697(proxy,param)
	print("OnEvent_697 begin");
	proxy:SetEventFlag( 697 , true );
	proxy:ObjRootMtxMoveDmyPoly( 1291 , 1 );	
	proxy:ChangeModel( 1291 , 1 );
	proxy:SetFirstSpeedPlus( 1291 , 2, 3.5  ,6 , 1);
	proxy:SetBrokenPiece( 1291 );
	proxy:PlayTypeSE( 1291 , SOUND_TYPE_O , 620300000 );
	print("OnEvent_697 end");
end

--------------------------------------------------------------------------------------
--��694���g���b�R�g���b�v3��
--------------------------------------------------------------------------------------
function OnEvent_694(proxy,param)
	print("OnEvent_694 begin");
	
	proxy:NotNetMessage_begin();
		proxy:PlayAnimation( 1292 , 1);
		proxy:OnCharacterAnimEnd( 694 , 1292 , 1 ,"OnEvent_694_1",once);
	proxy:NotNetMessage_end();	
	--�g���b�R����_���[�W
	local paramid = 10140;
	local rad     = 0.5;
	local time    = 40;	
	proxy:NotNetMessage_begin();		
		proxy:OnObjectDamageHit_NoCall( 694, 1292, 2, paramid, EV_HIT_CHR , rad, time, everytime );
	proxy:NotNetMessage_end();
		
	proxy:SetEventFlag( 694 , true );	
	print("OnEvent_694 end");
end

--�g���b�R�̃A�j����~
function OnEvent_694_1(proxy,param)
	proxy:DeleteEvent(694);
	proxy:SetEventFlag( 904 ,true );
end


--------------------------------------------------------------------------------------
--��695���E�B���I�E�B�X�v����3��
--------------------------------------------------------------------------------------
function OnEvent_695(proxy,param)
	print("OnEvent_695 begin");
	proxy:DeleteObjSfxEventID( 1292 );	
	proxy:SetObjSfx( 1292 , 1 , 96002 , false );
	proxy:SetEventFlag( 695 ,true );
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 695 , "OnEvent_695_1",1.2,0,0,once);
	proxy:NotNetMessage_end();	
	print("OnEvent_695 end");
end

function OnEvent_695_1(proxy,param)
	print("OnEvent_695_1 begin");
	proxy:DeleteObjSfxEventID( 1292 );
	--proxy:CastPointSpell_Horming( 400 , 1292 , 10160 , 0,0,0 , 1292);
	proxy:CastTargetSpell(400,1292,1,1292,10161);
	proxy:AddRumble(121, 1292, -1,1.0, 25.0);
	print("OnEvent_695_1 end");
end

--------------------------------------------------------------------------------------
--��698���g���b�R�j��R��
--------------------------------------------------------------------------------------
function OnEvent_698(proxy,param)
	print("OnEvent_698 begin");
	proxy:SetEventFlag( 698 , true );
	proxy:ObjRootMtxMoveDmyPoly( 1292 , 1 );	
	proxy:ChangeModel( 1292 , 1 );
	proxy:SetFirstSpeedPlus( 1292 , 2, 3.5  ,6 , 1);
	proxy:SetBrokenPiece( 1292 );
	proxy:PlayTypeSE( 1292 , SOUND_TYPE_O , 620400000 );
	print("OnEvent_698 end");
end


--------------------------------------------------------------------------------------
--��700���󎀑̃g���b�v1��
--------------------------------------------------------------------------------------
function OnEvent_700(proxy,param)
	if proxy:IsCompleteEvent( 700 ) == false then
		proxy:LuaCallStart( 700 , 10 );		
	end
end

--�z�M�p
function OnEvent_700_1(proxy,param)
	print("OnEvent_700_1 begin");
	
	ValidCharactor( proxy, 330 );
	proxy:PlayAnimation( 330, 9010 );
	proxy:EnableLogic( 330, true );	
	proxy:SetEventFlag( 700 , true );
	
	print("OnEvent_700_1 end");
end


--------------------------------------------------------------------------------------
--��701���󎀑̃g���b�v2��
--------------------------------------------------------------------------------------
function OnEvent_701(proxy,param)
	if proxy:IsCompleteEvent( 701 ) == false then
		proxy:LuaCallStart( 701 , 10 );		
	end
end

--�z�M�p
function OnEvent_701_1(proxy,param)
	print("OnEvent_701_1 begin");
	
	ValidCharactor( proxy, 415 );
	proxy:PlayAnimation( 415, 9010 );
	proxy:EnableLogic( 415, true );	
	proxy:SetEventFlag( 701 , true );
	
	print("OnEvent_701_1 end");
end


--------------------------------------------------------------------------------------
--��720���g�J�Q�ړ��Q��
--------------------------------------------------------------------------------------
function OnEvent_720(proxy,param)
	if proxy:IsCompleteEvent( 720 ) == false then
		print("OnEvent_720 begin");
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 720 , "OnEvent_720_1",0,0,0,once);
		proxy:NotNetMessage_end();
		
		print("OnEvent_720 end");
	end
end

--�z�M�p
function OnEvent_720_1(proxy,param)
	print("OnEvent_720_1 begin");	
	
	proxy:EnableLogic( 416 , true );
	proxy:ResetThink( 416 );
	proxy:SendEventRequest( 416 , 0 , 0);
	LuaFunc_ForceOmission(proxy,416);
	proxy:SetAlwayEnableBackread_forEvent( 416 , true );	
	--��598���g�J�QB : �̈�(2265)�ւ̓����Ď���
	proxy:OnRegionJustIn( 723 , 416 , 2265 , "OnEvent_723" , once );	
	--�C�x���g�t���O�Z�b�g	
	proxy:SetEventFlag( 720 , 1 );--�̈�p
	proxy:SetEventFlag( 721 , 1 );--�_���[�W�Ď��p
	
	proxy:DeleteEvent(720);
	proxy:DeleteEvent(721);	
	print("OnEvent_720_1 end");	
end

--�̈�ɓ���
function OnEvent_723(proxy,param)
	print("OnEvent_723 begin");
	proxy:SetEventFlag( 723 , 1 );--�̈�(2265)�ɓ����ς�
	proxy:ChangeInitPosAng( 416 , 2265 );--�����ʒu�̗̈��(2265��)�X�V����	
	proxy:EnableLogic( 416 , true );--���W�b�NON
	proxy:PlayAnimation( 416 , 3301 );--�g�J�Q������A�j��
	proxy:SendEventRequest( 416 , 0, -1 );
	print("OnEvent_723 end");
end


--------------------------------------------------------------------------------------
--��725���g�J�Q�ړ��R��
--------------------------------------------------------------------------------------
function OnEvent_725(proxy,param)
	if proxy:IsCompleteEvent( 725 ) == false then
		print("OnEvent_725 begin");
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 725 , "OnEvent_725_1",0,0,0,once);
		proxy:NotNetMessage_end();
		
		print("OnEvent_725 end");
	end
end

--�z�M�p
function OnEvent_725_1(proxy,param)
	print("OnEvent_725_1 begin");	
	
	proxy:EnableLogic( 417 , true );
	proxy:ResetThink( 417 );
	proxy:SendEventRequest( 417 , 0 , 0);
	--��727���̈�(2268)�ւ̓����Ď���
	proxy:OnRegionJustIn( 727 , 417 , 2268 , "OnEvent_727" , once );	
	--�C�x���g�t���O�Z�b�g	
	proxy:SetEventFlag( 725 , 1 );--�̈�p
	proxy:SetEventFlag( 726 , 1 );--�_���[�W�Ď��p
	
	proxy:DeleteEvent(725);
	proxy:DeleteEvent(726);	
	print("OnEvent_725_1 end");	
end

--�̈�ɓ���
function OnEvent_727(proxy,param)
	print("OnEvent_727 begin");
	proxy:SetEventFlag( 727 , 1 );--�̈�(2268)�ɓ����ς�
	proxy:ChangeInitPosAng( 417 , 2268 );--�����ʒu�̗̈��(2237��)�X�V����	
	proxy:EnableLogic( 417 , true );--���W�b�NON
	proxy:PlayAnimation( 417 , 3301 );--�g�J�Q������A�j��
	proxy:SendEventRequest( 417 , 0, -1 );
	print("OnEvent_727 end");
end


--------------------------------------------------------------------------------------
--��541�`546����΃~�~�Y��яo����
--------------------------------------------------------------------------------------
function Func_RockWorm(proxy,actionId,targetId)
	print("OnEvent_",actionId," begin");
	ValidCharactor( proxy, targetId );
	proxy:StopLoopAnimation( targetId );
	proxy:ForcePlayAnimation(targetId, 9010 );
	proxy:EnableLogic( targetId, true );	
	proxy:SetEventFlag( actionId , true );	
	
	print("OnEvent_",actionId," end");
end

function OnEvent_541(proxy,param) Func_RockWorm(proxy,541,331); end
function OnEvent_542(proxy,param) Func_RockWorm(proxy,542,332); end
function OnEvent_543(proxy,param) Func_RockWorm(proxy,543,333); end
function OnEvent_544(proxy,param) Func_RockWorm(proxy,544,334); end
function OnEvent_545(proxy,param) Func_RockWorm(proxy,545,335); end
function OnEvent_546(proxy,param) Func_RockWorm(proxy,546,336); end


--------------------------------------------------------------------------------------
--��730�`734���E�B���I�E�B�X�v������
--------------------------------------------------------------------------------------
function Func_WispBomb(proxy,actionId,ownerId,targetId)
	print("OnEvent_",actionId," begin");	
	proxy:DeleteObjSfxEventID( targetId );
	proxy:CastPointSpell_Horming( ownerId,targetId, 10160 , 0,0,0, targetId);
	proxy:SetEventFlag(actionId,true);
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( actionId, "WispRumble",1.2,0,targetId,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_",actionId," end");
end

function OnEvent_730(proxy,param) Func_WispBomb(proxy,730,400,1300); end
function OnEvent_731(proxy,param) Func_WispBomb(proxy,731,400,1301); end
function OnEvent_732(proxy,param) Func_WispBomb(proxy,732,400,1302); end
function OnEvent_733(proxy,param) Func_WispBomb(proxy,733,400,1303); end
function OnEvent_734(proxy,param) Func_WispBomb(proxy,734,400,1304); end

function WispRumble(proxy,param)
	print("WispRumble begin");
	proxy:AddRumble(121, param:GetParam3(), -1,1.0, 25.0);
	print("WispRumble end");
end
--------------------------------------------------------------------------------------
--��702�������ǂ��Ă��遡
--------------------------------------------------------------------------------------
--[[
function OnEvent_702(proxy,param)
	print("OnEvent_702 begin");--�����C�x���g���荞��
	if proxy:IsCompleteEvent(702) == false then
		MoveRegion(proxy, 410, 2276, 20 ,0.0,false);
		proxy:SetEventFlag( 702,true );
	end
	print("OnEvent_702 end");
end
]]

--------------------------------------------------------------------------------------
--��800���ؑ��P��
--------------------------------------------------------------------------------------
function OnEvent_800(proxy,param)
	print("OnEvent_800 begin");
	proxy:SetEventFlag( 800 , true );
	print("OnEvent_800 end");
end

--------------------------------------------------------------------------------------
--��802���ؑ��Q��
--------------------------------------------------------------------------------------
function OnEvent_802(proxy,param)
	print("OnEvent_802 begin");
	proxy:SetEventFlag( 802 , true );
	print("OnEvent_802 end");
end


--------------------------------------------------------------------------------------
--������~�~�Y��_���ʓo�^�p��
--------------------------------------------------------------------------------------
function RegistRockWorm( proxy, eventId , eneId )
	if proxy:CreateEventBody( eventId,eneId,"dummy",1000000,ROCKWORM_DAMAGE_RATE,once) == true then
	print("Create EventBody by RockWorm :",eneId);
		proxy:AddEventParts(eventId,eneId,"Ragdoll_Head01");
		proxy:AddEventParts(eventId,eneId,"Ragdoll_Body09");
	else
		print("Faild EventBody by RockWorm :",eneId);
	end
end

--��~�~�Y��_���ʂ���C�x���g���Ă΂ꂽ�ꍇ
function dummy(proxy,param)
	print("dummy begin");
	proxy:WARN("EventBody�@WARN");
	print("dummy end");
end
