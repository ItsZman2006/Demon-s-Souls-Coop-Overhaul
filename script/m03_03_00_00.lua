
--�G�C�̓ˌ��C�x���g�����̎cHP����
StormOfBeast_HpRate = 0.5;

--�q�G�C�̎��񂾐�
BeastChildDeadCount = 12;

--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉����������
--------------------------------------------------------------------------------------
function Initialize_m03_03_00_00(proxy)
	print("Initialize_m03_03_00_00 begin");

--��1541���G���A�{�X�̃|�����Đ���
	--�{�X�������Ă��鎞�����C�x���g�o�^
	if proxy:IsCompleteEvent( 4992 ) == false then
		--���S���ɂ�������x�Đ��������ׁB
		SingleReset( proxy,1541);
		SingleReset( proxy,5085);
		if proxy:IsCompleteEvent( 1541 ) == false then 	
			--���{�X�O�̃|�����Đ��p�Ď��ǉ�
			proxy:OnRegionJustIn( 1541 , 10000 , 2896 , "OnEvent_1541" , once );		
			proxy:NotNetMessage_begin();
				--�|�����J�n�ɌĂ΂��n���h��
				proxy:LuaCall(1541, REMO_START, "OnEvent_1541_RemoStart", once);
				--�|�����I����ɌĂ΂��n���h��(�g���K�[�N�������l�p)
				proxy:LuaCall(1541, REMO_FINISH, "OnEvent_1541_RemoFinish", once);
			proxy:NotNetMessage_end();	
		else
			--�I����Ă����Ԃœ����Ă����l�ɂ͂�����x
			BossInit_StormOfBeast(proxy,param);
		end
	end


--��1542���{�X�����ɓ��遡	
	--���{�X�������Ă���Ƃ������C�x���g�o�^
	if proxy:IsCompleteEvent( 4992 ) == false then
	
		--�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B
		SingleReset(proxy, 1542);
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���)
		proxy:LuaCall( 1543, 1, "OnEvent_1542_1", everytime );		
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCall( 1543 , 5 , "OnEvent_1542_GO_TO_IN" , everytime );		
		--���t���O�Z�b�g(�����p)
		proxy:LuaCall( 1543 , 6 , "OnEvent_1542_flag_set" , everytime );		
		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ�
		if proxy:IsCompleteEvent( 1542 ) == false then		
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l����
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			proxy:NotNetMessage_begin();
				--��1542�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegionAttribute( 1542, 2892, "OnEvent_1542", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B
			proxy:NotNetMessage_begin();
				--��1543�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegion( 1543, 2892, "OnEvent_1542", HELPID_GO_TO_IN, everytime );--�n���h���͏�Ɠ���
			proxy:NotNetMessage_end();
		end
	end
	
--��4999���{�X�퓬�J�n��	
	if proxy:IsCompleteEvent( 4992 ) == false then
		proxy:OnRegionIn( 4999 , 10000 , 2884 , "OnEvent_4999" , everytime );
	end	
	
--��4992���G���A�{�X���S��
	proxy:AddFieldInsFilter( 822 );
	if proxy:IsCompleteEvent( 4992 ) == false then
		proxy:OnCharacterDead(4992,822,"OnEvent_4992",once);
	end
		
--[[
--��5000�E5001���{�X�̓�����|������
	--�{�X��|���ĂȂ� and �w��|�������݂Ă��Ȃ�
	SingleReset( proxy,5001 );	
	if proxy:IsCompleteEvent( 4992 ) == false and proxy:IsCompleteEvent( 5001 ) == false then
		local eneID = 400;
		local num = 12;
		
		for eneID = 400 , 411 , 1 do
			--�q�G�C�̎��S�Ď�
			print("add ",eneID);
			proxy:OnCharacterDead( 5000, eneID ,"OnEvent_5000_"..eneID,once);
		end
		--�G�C��Hp�Ď�		
		proxy:OnCharacterHP( 5000, 822, "OnEvent_5000_HP",StormOfBeast_HpRate,once );
		
		--�|�����N���p
		proxy:NotNetMessage_begin();
			--�L�b�N
			proxy:LuaCall(5001,1,"OnEvent_5001",once);
			--�t�F�[�h�A�E�g��
			proxy:LuaCall(5001,REMO_START,"OnEvent_5001_RemoStart",once);
			--�t�F�[�h�C����
			proxy:LuaCall(5001,REMO_FINISH,"OnEvent_5001_RemoFinish",once);
		proxy:NotNetMessage_end();
	end
	]]
--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m03_03_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m03_03_00_00", everytime );
	proxy:NotNetMessage_end();

	
	--���{�X�֘A�̏���������
	if proxy:IsCompleteEvent( 4992 ) ==true then
		
		--���{�X����ł���Ƃ�
		--�{�X���Ȃ��Ȃ�
		InvalidBackRead( proxy , 822 );
		--�������ŏ������t���O�𗧂Ă�
		proxy:SetEventFlag( 4991, true );
		
		--�q�G�C���\�����Ȃ�
		--[[
		local eneID = 400;		
		for eneID=400,411,1 do		
			InvalidCharactor( proxy, eneID);
		end
		]]
		--�W�F�l���[�^�~�߂�
		proxy:EnableGeneratorSystem( 2605 , false );
		
		--���@�Ǐ�����
		proxy:SetColiEnable( 1996 , false );			
		proxy:SetDrawEnable( 1996 , false );
		
		--SFX����
		proxy:InvalidSfx(1988,false);	

		--�z�X�g�v���C���[�̂݃A�C�e������C�x���g�Ɏg�p
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--�󎀑�(�\�E��?)�L����
		proxy:SetDrawEnable( 1979 , true );
		proxy:SetColiEnable( 1979 , true );
		--�󎀑�(�\�E��?)2�L����
		proxy:SetDrawEnable( 1978 , true );
		proxy:SetColiEnable( 1978 , true );
		
		proxy:TreasureDispModeChange2( 1979 , true ,KANAME_SFX);--���点��
		--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
		if proxy:IsCompleteEvent( 4996 ) == false then
			proxy:ValidSfx( 2601 );--SFX �L����
			proxy:ValidSfx( 2600 );--SFX �L����			
			proxy:OnDistanceActionAttribute( 4996 , 10000 , 1979 , "OnEvent_4996" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--���v�΂Ń��[�v�p�̊Ď���ǉ���
			SingleReset(proxy,4998);
			--proxy:InvalidSfx( 2601, false );--SFX �L����
			proxy:InvalidSfx( 2600, false );--SFX �L����
			proxy:OnDistanceActionAttribute( 4998 , 10000 , 1979 , "OnEvent_4998" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
	else
		--���{�X�����Ă���Ƃ�
		
		--�G���A�{�X�|���������Ă��Ȃ��Ƃ�
		if proxy:IsCompleteEvent(1541) == false then
			
			InvalidCharactor( proxy,822 );			
			--���ɂ�������Ȃ�
			--proxy:SetIgnoreHit( 822, true);
			--proxy:DisableMapHit( 822 , true);
	
			--�q�G�C��\�����Ȃ�
			local eneID;
			for eneID = 400, 411, 1 do
				proxy:SetDrawEnable( eneID, false );
				proxy:SetColiEnable( eneID, false );
			end
		end
		
		proxy:EnableLogic( 822 , false );--���W�b�NOFF�őҋ@
		
		
		--�q�G�C���W�b�NOFF
		local eneID = 400;
		for eneID=400 , 411 , 1 do
			proxy:EnableLogic(eneID,false);
		end
		
		--��(�\�E��?)
		proxy:SetDrawEnable( 1979 , false );
		proxy:SetColiEnable( 1979 , false );
		--��(�\�E��?)2
		proxy:SetDrawEnable( 1978 , false );
		proxy:SetColiEnable( 1978 , false );

		--SFX ������
		proxy:InvalidSfx( 2600 , false );--�\�E���p
		proxy:InvalidSfx( 2601 , false );--�{�X�A�C�e���p			

	end
	
--��1544���{�X��J�����Ή���
	--�{�X�������Ă���Ȃ�o�^
	if proxy:IsCompleteEvent(4992) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 1544 , 10000 , 2884 ,"OnEvent_1544" , everytime );
		proxy:NotNetMessage_end();
	end

--��1590���X�g�[���u�����K�[������
	--�{�X�������Ă���Ȃ�o�^
	--if proxy:IsCompleteEvent(4992) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 1590, 10000, 2610 , "OnEvent_1590",everytime ); 
			proxy:OnRegionJustOut( 1590 , 10000 , 2610 , "OnEvent_1590_out",everytime );
		proxy:NotNetMessage_end();
	--end
	
--��1570���ԂP�E�Q�̎q�G�C�̖�������
	SingleReset( proxy , 1570 );
	
	--if proxy:IsCompleteEvent( 4992 ) == false then
		proxy:NotNetMessage_begin();
			if proxy:IsClient() == false then
				proxy:OnRegionJustIn( 1570 ,10000 , 2680 , "OnEvent_1570" , everytime );
			end
			if proxy:IsCompleteEvent( 1570 ) == true then
				for eneid = 388 , 399 , 1 do
					InvalidCharactor( proxy , eneid );
				end
			end
		proxy:NotNetMessage_end();
		proxy:LuaCall( 1570 , 0 , "OnEvent_1570_1",everytime );
	--end
	
--��1571���ԂP�E�Q�̎q�G�C�̗L������
	--if proxy:IsCompleteEvent( 4992 ) == false then
		proxy:NotNetMessage_begin();
			if proxy:IsClient() == false then
				proxy:OnRegionJustIn( 1571 ,10000 , 2681, "OnEvent_1571" , everytime );
			end
		proxy:NotNetMessage_end();
		proxy:LuaCall( 1571 , 0 , "OnEvent_1571_1",everytime );
	--end

--��8085���ÍԂɗ����t���O�𗧂Ă遡	
	proxy:SetEventFlag(8085, true);
	
	--�����g�J�Q���S�C�x���g
	RegistTokage(proxy,1580,256,10);
	RegistTokage(proxy,1582,257,11);
	


--��1591���X�g�[���u�����K�[��
	if proxy:IsCompleteEvent( 1591 ) == false then
		--�z�X�g�A�����A�O���C�̂ݒ��ׂ邱�Ƃ��ł���
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		
		proxy:OnDistanceActionAttribute( 1591 , LOCAL_PLAYER , 1610 , "OnEvent_1591" , ItemBoxDist_A , 10010158 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
		proxy:LuaCall( 1591,1,"OnEvent_1591_2",once);
		proxy:LuaCall( 1591,2,"OnEvent_1591_3",once);
		proxy:TreasureDispModeChange2( 1610, true ,KEN_SFX);
	else
		proxy:SetDrawEnable( 1610 , false );--�ЂƂ܂��`�悾��OFF
		proxy:SetColiEnable( 1610 , false );
	end	
	

	--��999999���t���[���x��̏����������C�x���g�𔭍s��
	proxy:NotNetMessage_begin();
		--��0�b�づ--
		proxy:OnKeyTime2( 999993, "Second_Initialize_m03_03_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m03_03_00_00 end");
end


--------------------------------------------------------------------------------------
--Initialize����Ă΂��A1�t���[���x��̏�����������999999
--------------------------------------------------------------------------------------
--��999999���ꕔ�AInit�ł͏����ł��Ȃ��̂ŁA�c���Ă���
function Second_Initialize_m03_03_00_00(proxy, param)
	print("Second_Initialize_m03_03_00_00 begin");

--------------------------------������QWC�C�x���g�֘A������--------------------------------
--------------------------------������QWC�C�x���g�֘A������--------------------------------

	print("Second_Initialize_m03_03_00_00 end");
end



	


--------------------------------------------------------------------------------------
--�G���A�{�X�|�����Đ���1541
--------------------------------------------------------------------------------------
--�����̈�̒��ɓ�����
function OnEvent_1541(proxy, param)
	print("OnEvent_1541 begin");
	
	--�|�����Đ��J�n
	proxy:RequestRemo(30300,REMO_FLAG,1541,1);
	proxy:SetEventFlag( 1541 , 1 );--�|�����Đ��I���t���OON	
	print("OnEvent_1541 end");
end

--��1541_RemoStart���|�����J�n �t�F�[�h�A�E�g������
function OnEvent_1541_RemoStart(proxy,param)
	print( "OnEvent_1541_RemoStart begin" );
	print( "OnEvent_1541_RemoStart end" );
end

--��1541_RemoFinish���|�����Đ��I���ち
function OnEvent_1541_RemoFinish(proxy , param)
	print( "OnEvent_1541_RemoFinish begin" );
	
	--�{�X�퓬�J�n�p�̏������Ăяo��
	BossInit_StormOfBeast(proxy,param);

	--�{�X�|�����I����̃{�X�̕\��
	--proxy:SetDrawEnable( 822, true );
	--proxy:SetColiEnable( 822, true );
	ValidCharactor( proxy, 822);
	
	--�{�X�|�����I����̎q�G�C�̕\��
	local eneID;
	for eneID = 400, 411, 1 do
		proxy:SetDrawEnable( eneID, true );
		proxy:SetColiEnable( eneID, true );
	end
	
	--�|�����Đ��I���̃t���O
	proxy:SetEventFlag( 5085 ,true );
	
	print( "OnEvent_1541_RemoFinish end" );
end



--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ��遡1542
--------------------------------------------------------------------------------------
--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫
--��1542�����{�X�����ւ̔����J����
function OnEvent_1542(proxy,param)
	print("OnEvent_1542 begin");

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_1542 end");
		return;
	end	
	
	--�N���C�A���g�ցA�{�X�����j�~���s��ʒm
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 1543 , 1 );--����A�j���̓����Đ�
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--���d�N���V�X�e��ID���^�C���A�E�g��ݒ肵��ON�ɂ���
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1542 end");
end


--����A�j���̓����Đ�(ID����)
function OnEvent_1542_1(proxy,param)
	print("OnEvent_1542_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ��𓯊�
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2888 );
		else
			proxy:LockSession();--���[�������b�N���܂��I
			--����A�j���Đ����s���A���̏I������OnEvent_1542_2�𔭍s����
			proxy:OnTurnCharactorEnd( 1543, 10000, 2888, "OnEvent_1542_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1542_1 end");
end

--����A�j���̓����Đ��I����
function OnEvent_1542_2(proxy,param)
	print("OnEvent_1542_2 begin");

	--�����p�����A�j���Đ�
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1543, 10000, ANIMEID_WALK, "OnEvent_1542_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1542_2 end");
end

--�����A�j���̓����Đ��I����
function OnEvent_1542_3(proxy,param)
	print("OnEvent_1542_3 begin");

	--�ŏ��̐l���{�X�����̒��ɓ���I����Ă�����A���ɔz�M����Ă���͂��Ȃ̂ŁA����������Ȃ��n���h��
	if proxy:IsCompleteEvent( 1542 ) == false then
		proxy:LuaCallStart( 1543 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCallStart( 4045 , 1 );	--�N���C�A���g�ցA�{�X�����ɓ����悤�ɂȂ������Ƃ�ʒm
		proxy:LuaCallStart( 1543 , 6 );--�t���O�Z�b�g(�����p)		
		--���̏b�Ǝq�G�C�Ή�
		local eneidlist = {822,400,401,402,403,404,405,406,407,408,409,410,411};
		local num = table.getn( eneidlist );
		for index = 1 , num , 1 do
			Lua_MultiDoping(proxy,eneidlist[index]);--�}���`�v���C�h�[�s���O
		end
	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�)
	if proxy:IsClient() == false then
		proxy:ResetThink( 822 );
	end	
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );
	print("OnEvent_1542_3 end");
end


--��1542 2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
function OnEvent_1542_GO_TO_IN(proxy, param)
	print("OnEvent_1542_GO_TO_IN begin");	
	proxy:NotNetMessage_begin();
		--��1542�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���--�n���h���� OnEvent_1542
		proxy:OnPlayerActionInRegion( 1543, 2892, "OnEvent_1542", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	print("OnEvent_1542_GO_TO_IN end");
end


--��1542 �t���O�Z�b�g(�����p)
function OnEvent_1542_flag_set(proxy, param)
	print("OnEvent_1542_flag_set begin");		
	proxy:SetEventFlag( 1542 , 1 );
	proxy:DeleteEvent( 1542 );
	print("OnEvent_1542_flag_set end");
end


--------------------------------------------------------------------------------------
--�{�X�������o��(�퓬�J�n)��4999
--------------------------------------------------------------------------------------
function OnEvent_4999(proxy, param)
	if proxy:IsCompleteEvent( 5085 ) == false then
		return;
	end
	
	print("OnEvent_4999 begin");
	
	--�{�X��pBGM�Đ��J�n
	proxy:PlayPointSE( 2602, SOUND_TYPE_M, 30300000, 3 );
	--���W�b�NON
	proxy:EnableLogic( 822 , true );
	--���̏b�͂��̒i�K�ł̓��W�b�NOFF
	
	--�{�X�퓬�J�n�p�̏������Ăяo��
	--BossInit_StormOfBeast(proxy,param);
	--�ǂݍ��݃^�C�~���O�̂Ƃ�����ǉ�����Ăق����̂Ńt���O���ĂȂ�
	--�{�X�Q�[�W�\��
	proxy:SetBossGauge( 822 , 0 ,5030 );
	
	--�Ď��폜
	proxy:DeleteEvent( 4999 );
	
	print("OnEvent_4999 end");
end


--------------------------------------------------------------------------------------
--�G���A�{�X�̎��S��4992
--------------------------------------------------------------------------------------
function OnEvent_4992(proxy, param)
	print("OnEvent_4992begin");
	
	proxy:NotNetMessage_begin();
		--��4992_1��1�b�o�߁�
		proxy:OnKeyTime2( 4992, "OnEvent_4992_1", 1, 0, 0, once);
		--��4992_2��2�b�o�߁�
		proxy:OnKeyTime2( 4992, "OnEvent_4992_2", 2, 0, 1, once);
		--�}���`���U�Ď�
		proxy:OnRegistFunc( 4992 , "Check_4992_PT","OnEvent_4992_PT",0,once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 4992, 1 );--�{�X�L�^�p�@�V�d�l���p
	--�Q�b��ɂ́ABGM�ƌ��̕ǂ������Ă���͂�
	proxy:SetEventFlag(4995 , true);

	--�z�X�g���L�����@or�@�V���O��		
	proxy:SetEventFlag(	8011, 1 );--�N���A�t���OON	

	--�G�C�ʏ�X�V���J�n
	--LuaFunc_NormalOmission(proxy,822);
	
	--�q�G�C��n��--�e�ƐS��
	local eneID = 400;
	for eneID=400 , 411 , 1 do
		if proxy:IsAlive(eneID) == true then
			proxy:ForceDead(eneID);
		end
	end	
	
	--�u���b�N�N���A������
	--proxy:LuaCallStart( 4040, 1 );
	--�V�u���b�N�N���A������
	proxy:CustomLuaCallStart( 4050, 822);
	
	--�����g�J�Q���Z�b�g
	ResetTokage(proxy);
		
	print("OnEvent_4992 end");
end

--��4992_1����������J��:���{�X���S��1�b��
function OnEvent_4992_1(proxy, param)
	print("OnEvent_4992_1 begin");
	
	--�{�X��|���������X�V(���ɂ���ăt���O�𗧂Ă�)
	GetBossFlagCount( proxy, param );
	
--�A�C�e������֘A-------
	
	--�z�X�g�v���C���[�̂݃A�C�e������C�x���g�Ɏg�p
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

	--�󎀑�(�\�E��?)�L����
	proxy:SetDrawEnable( 1979 , true );
	proxy:SetColiEnable( 1979 , true );
	--�󎀑�(�\�E��?)2�L����
	proxy:SetDrawEnable( 1978 , true );
	proxy:SetColiEnable( 1978 , true );
	
	--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
	if proxy:IsCompleteEvent( 4996 ) == false then
		proxy:ValidSfx( 2600 );--SFX �L����
		proxy:ValidSfx( 2601 );--SFX �L����
		proxy:TreasureDispModeChange2( 1979 , true ,KANAME_SFX);--���点��
		proxy:OnDistanceActionAttribute( 4996 , 10000 , 1979 , "OnEvent_4996" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end
------------------------

	--���g���t�B�[�擾���聥
	Lua_RequestUnlockTrophy(proxy, 7);
end

--�}���`���U�Ď�
function Check_4992_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--�}���`����Ȃ�
function OnEvent_4992_PT(proxy,param)
	print("OnEvent_4992_PT begin");
	--���{�X�����̑O��̖��@�ǂ�������(�S�v���C���[)	
	proxy:SetColiEnable( 1996 , false );	
	proxy:SetDrawEnable( 1996 , false );
	
	--���{�X�������@�ǂ�SFX�폜
	proxy:InvalidSfx( 1988 , true );	
	
	--���{�X�����O�̈ړ������C�x���g���폜
	proxy:DeleteEvent( 1542 );--��l�ڂ�����Ƃ��p
	proxy:DeleteEvent( 1543 );--��l�ڈȍ~������Ƃ��p
	proxy:DeleteEvent( 4999 );--�{�X�퓬�J�n�p	
	print("OnEvent_4992_PT end");	
end


--��4992_2����������J��:���{�X���S��1�b��
function OnEvent_4992_2(proxy, param)
	print("OnEvent_4992_2 begin");
		
	--�{�X��p��BGM��~
	proxy:StopPointSE( 3 );
		
	--[[�Z�b�V�������U���̖��@�ǐ؂�ւ������̓O���[�o��?]]
	
	print("OnEvent_4992_2 end");
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
--��4998���Β��Ƀ��[�v��
--------------------------------------------------------------------------------------
function OnEvent_4998(proxy,param)	
	print("OnEvent_4998 begin");
		
	--�Z�b�V�������ł͂Ȃ����H
	if proxy:IsSession() == false then
		proxy:RepeatMessage_begin();
			--��70_1���I�����j���[�̊Ď���
			proxy:OnSelectMenu(4998, "OnEvent_4998_1", 10010710, 0, 2, 1979, 2, once);			
		proxy:RepeatMessage_end();
	else
		--�Z�b�V�������Ȃ�ŕ\��
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010720, 1);
		--proxy:ShowGenDialog(10010720,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1979, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end

	print("OnEvent_4998 end");
end

--��4998_1���I�����j���[�̊Ď���
function OnEvent_4998_1(proxy,param)	
	print("OnEvent_4998_1 begin");	
	
	if proxy:IsSession() == false then
		if param:IsNetMessage() == true then
			proxy:PlayAnimation(10001+param:GetPlayID(),8283);
			print("OnEvent_4998_1 end");
			return;
		end
			
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1979 ,TURNSKIP_ANGLE);
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd( 4998 , 10000 , 8283 , "OnEvent_4998_2",once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(4998,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_4998_1 end");
end

--��4998_2���Β��Ƀ��[�v��
function OnEvent_4998_2(proxy,param)	
	print("OnEvent_4998_2 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ�
	--�Β��֖߂��Ă�������̃t���O�𗧂Ă�
	proxy:SetEventFlag(8083, true);
	
	--���S�񕜗v��
	proxy:RequestFullRecover();
	--�Íԗv�΂ɖ߂�
	proxy:WarpNextStage( 1, 0, 0, 0, 1007);	
	print("OnEvent_4998_2 end");
end



--------------------------------------------------------------------------------------
--��4996���\�E�����聡
--------------------------------------------------------------------------------------
function OnEvent_4996(proxy, param)
	print("OnEvent_4996 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--�V�����A�j�� 
		print("OnEvent_4996 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 4996, "OnEvent_4996_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4996 end");
end


--��4996_1���A�C�e���擾��
function OnEvent_4996_1(proxy, param)
	print("OnEvent_4996_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10232�Q��
	proxy:GetRateItem(10232);	
	--�A�C�e���擾�֐�--�p�����[�^10278�Q��
	proxy:GetRateItem(10278);	
	--�A�C�e���擾�֐�--�p�����[�^10279�Q��
	proxy:GetRateItem(10279);	
	--�A�C�e���擾�֐�--�p�����[�^10280�Q��
	proxy:GetRateItem(10280);	
	--�A�C�e���擾�֐�--�p�����[�^10281�Q��
	proxy:GetRateItem(10281);	
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 4996, 1 );
	
	--�󔠃V�F�[�_�[�͏����܂���B
	--proxy:TreasureDispModeChange( 1979 , false );

	--SFX��������
	proxy:InvalidSfx( 2600 , true );
	--proxy:InvalidSfx( 2601 , true );
	
	if proxy:IsCompleteEvent( 8035 ) == false then
		proxy:NotNetMessage_begin();
			--�u�Ԃŕ\������ƃ��j���[����ɏo��̂ő҂�
			proxy:OnKeyTime2( 8035 , "OnEvent_8035_wait",0.5 , 0 , 1, once);			
		proxy:NotNetMessage_end();
	else
		--���v�΂Ń��[�v�p�̊Ď���ǉ���
		proxy:OnDistanceActionAttribute( 4998 , 10000 , 1979 , "OnEvent_4998" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	end	

	print("OnEvent_4996_1 end");
end	

--[[
	if proxy:IsCompleteEvent( 8035 ) == false then
		proxy:NotNetMessage_begin();
			--�u�Ԃŕ\������ƃ��j���[����ɏo��̂ő҂�
			proxy:OnKeyTime2( 8035 , "OnEvent_8035_wait",0.5 , 0 , 1, once);			
		proxy:NotNetMessage_end();
	else
		--���v�΂Ń��[�v�p�̊Ď���ǉ���
		proxy:OnDistanceActionAttribute( 4998 , 10000 , 1979 , "OnEvent_4998" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	end	
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
	proxy:OnDistanceActionAttribute( 4998 , 10000 , 1979 , "OnEvent_4998" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	print("OnEvent_8035 end");
end


--[[
--------------------------------------------------------------------------------------
--��5000���{�XHP�E�q�G�C���S�Ď���
--------------------------------------------------------------------------------------
--���S�Ď��̓���
function CheckDeadCount(proxy,eneID)
	print("OnEvent_5000_",eneID," begin");	
	local deadCount = 0;
	local ID = 400;	
		
	for ID = 400, 411, 1 do
		if proxy:IsAlive(ID) == false then
			deadCount = deadCount + 1;
		end
	end
		
	if deadCount >= BeastChildDeadCount then
		proxy:LuaCallStart(5001,1);
	end	
	print("OnEvent_5000_",eneID," end");	
end
]]

--[[
--�q�G�C�̎��S�Ď�
function OnEvent_5000_400(proxy,param) CheckDeadCount(proxy,400); end--ID400
function OnEvent_5000_401(proxy,param) CheckDeadCount(proxy,401); end--ID401
function OnEvent_5000_402(proxy,param) CheckDeadCount(proxy,402); end--ID402
function OnEvent_5000_403(proxy,param) CheckDeadCount(proxy,403); end--ID403
function OnEvent_5000_404(proxy,param) CheckDeadCount(proxy,404); end--ID404
function OnEvent_5000_405(proxy,param) CheckDeadCount(proxy,405); end--ID405
function OnEvent_5000_406(proxy,param) CheckDeadCount(proxy,406); end--ID406
function OnEvent_5000_407(proxy,param) CheckDeadCount(proxy,407); end--ID407
function OnEvent_5000_408(proxy,param) CheckDeadCount(proxy,408); end--ID408
function OnEvent_5000_409(proxy,param) CheckDeadCount(proxy,409); end--ID409
function OnEvent_5000_410(proxy,param) CheckDeadCount(proxy,410); end--ID410
function OnEvent_5000_411(proxy,param) CheckDeadCount(proxy,411); end--ID411

--�G�C��HP�̊����Ď�
function OnEvent_5000_HP(proxy,param)
	print("OnEvent_5000_HP begin");
	proxy:LuaCallStart(5001,1);
	print("OnEvent_5000_HP end");
end
]]

--[[
--------------------------------------------------------------------------------------
--��5001���{�X�ˌ��|������
--------------------------------------------------------------------------------------
--�|�����̋N��
function OnEvent_5001(proxy,param)
	print("OnEvent_5001 begin");
	proxy:DeleteEvent(5000);
	proxy:RequestRemo(30301,REMO_FLAG,5001,1);
	proxy:SetEventFlag(5001,true);
	print("OnEvent_5001 end");
end

--�|�����̃t�F�[�h�A�E�g
function OnEvent_5001_RemoStart(proxy,param)
	print("OnEvent_5001_RemoStart begin");
	--��s�֘A�A�j���Ď��폜
	proxy:DeleteEvent(5030);
	print("OnEvent_5001_RemoStart end");
end

--�|�����̃t�F�[�h�C��
function OnEvent_5001_RemoFinish(proxy,param)
	print("OnEvent_5001_RemoFinish begin");
	--�{�X�؂�ւ�������
	BossInit_StormOfBeast2(proxy,param);
	print("OnEvent_5001_RemoFinish end");
end
]]






--------------------------------------------------------------------------------------
--���������@�������ς� function 
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--��1544���{�X�J�����ݒ聡
--------------------------------------------------------------------------------------
function OnEvent_1544(proxy,param)
	--print("OnEvent_1544 begin");
	--�{�X������ł��Ȃ��@���@�{�X�Ƃ̐퓬���J�n���Ă���
	if proxy:IsCompleteEvent( 4992 ) == false and proxy:IsCompleteEvent( 4999 ) == true then
		--�{�X��@�񃍃b�N�J����
		proxy:SetCamModeParamTargetId(3031);
		--�{�X��@���b�N�J����
		proxy:SetCamModeParamTargetIdForBossLock(3030);
	end
	--print("OnEvent_1544 end");
end


--------------------------------------------------------------------------------------
--��1590�������X�g�[���u�����K�[�ݒ聡
--------------------------------------------------------------------------------------
function OnEvent_1590(proxy,param)
	--�{�X������ł��Ȃ��@���@�{�X�Ƃ̐퓬���J�n���Ă���
	--if proxy:IsCompleteEvent( 4992 ) == false and proxy:IsCompleteEvent( 4999 ) == true then
		local isHasWepon = false;		
		if proxy:GetRightCurrentWeponId() == 21100 then isHasWepon = true end;		
		--print("HadWepId",proxy:GetRightCurrentWeponId());		
		--print("isHasWepon ",isHasWepon);
		--���肵�����ʂ����̂܂ܐݒ�
		proxy:SetIsUseLongLongSword( isHasWepon );		
	--end
end

--�X�g�[���u�����K�[�I��
function OnEvent_1590_out(proxy,param)
	print("OnEvent_1590_out begin");
	proxy:SetIsUseLongLongSword( false );		
	print("OnEvent_1590_out end");
end



--------------------------------------------------------------------------------------
--�}���`�ɂȂ������Ƀz�X�g���ᖳ�������灡����
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end




--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m03_03_00_00(proxy, param)
	print("PlayerDeath_m03_03_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m03_03_00_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerDeath_m03_03_00_00");
end
	
--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m03_03_00_00(proxy,param)
	print("PlayerRevive_m03_03_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m03_03_00_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerRevive_m03_03_00_00");
end


--------------------------------------------------------------------------------------
--1570���ԂP�E�Q�̎q�G�C�̖�����
--------------------------------------------------------------------------------------
function OnEvent_1570(proxy,param)
	--if proxy:IsClient() == false then
	print("OnEvent_1570 begin");
	proxy:LuaCallStart( 1570 , 0 );
	print("OnEvent_1570 end");
	--end
end

function OnEvent_1570_1(proxy,param)
	print("OnEvent_1570_1 begin");
	for eneid = 388 , 399 , 1 do
		InvalidCharactor( proxy , eneid );
	end
	proxy:SetEventFlag( 1570 ,true );
	print("OnEvent_1570_1 end");
end

--------------------------------------------------------------------------------------
--1571���ԂP�E�Q�̎q�G�C�̗L����
--------------------------------------------------------------------------------------
function OnEvent_1571(proxy,param)
	--if proxy:IsClient() == false then
	print("OnEvent_1571 begin");
	proxy:LuaCallStart( 1571 , 0 );
	print("OnEvent_1571 end");
	--end
end

function OnEvent_1571_1(proxy,param)
	print("OnEvent_1571_1 begin");
	for eneid = 388 , 399 , 1 do
		ValidCharactor( proxy , eneid );
	end
	proxy:SetEventFlag( 1570 ,false );
	print("OnEvent_1571_1 end");
end


-----------------------------------------------------------------------------
--��1580�������g�J�Q�C�x���g4
-----------------------------------------------------------------------------
function OnEvent_1580(proxy,param)
	print("OnEvent_1580 begin");
	proxy:SetEventFlag( 1580 , true );
	proxy:DeleteEvent( 1580 );
	print("OnEvent_1580 end");
end

-----------------------------------------------------------------------------
--��1582�������g�J�Q�C�x���g5
-----------------------------------------------------------------------------
function OnEvent_1582(proxy,param)
	print("OnEvent_1582 begin");
	proxy:SetEventFlag( 1582 , true );
	proxy:DeleteEvent( 1582 );
	print("OnEvent_1582 end");
end




--------------------------------------------------------------------------------------
--�X�g�[���u�����K�[��1591
--------------------------------------------------------------------------------------
function OnEvent_1591(proxy,param)
	if param:IsNetMessage() == false then	
	print("OnEvent_1591 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		--�A�j��
		proxy:PlayAnimation( 10000 , 8290);
		proxy:PlayAnimation( 1610 , 1);	
		proxy:OnKeyTime2( 1591 , "OnEvent_1591_0",0.01,0,0,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	print("OnEvent_1591 end");
	end
end

function OnEvent_1591_0(proxy,param)
	print("OnEvent_1591_0 begin");
	--if proxy:IsPlayerStay(10000) == true then
	if proxy:IsEventAnim( 10000 , 8290 ) == true then		
		proxy:LuaCallStart( 1591, 2);			
	else
		proxy:ForcePlayAnimation( 1610 , 0);	
	end
	print("OnEvent_1591_0 end");
end

--��1591_1���A�C�e���擾��
function OnEvent_1591_1(proxy,param)
	print("OnEvent_1591_1 begin");
	--�A�C�e���擾�֐�--�p�����[�^10419�Q��
	proxy:GetRateItem(10217);	
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 1591, true );
	
	--OBJ���������߂̃C�x���g�z�M
	proxy:LuaCallStart( 1591, 1);

	print("OnEvent_1591_1 end");
end

--��1591_2����OBJ��\���p��
function OnEvent_1591_2(proxy,param)
	print("OnEvent_1591_2 begin");
	--�I�u�W�F��������
	proxy:SetDrawEnable( 1610 , false );--�ЂƂ܂��`�悾��OFF
	proxy:SetColiEnable( 1610 , false );--������͂���͕̂s��(����ł͂Ȃ��悤�Ȃ̂ŏ����Ȃ�)
	
	proxy:DeleteEvent( 1591 );
	print("OnEvent_1591_2 end");
end

--�A�j���̓����Ď�
function OnEvent_1591_3(proxy,param)
	print("OnEvent_1591_3 begin");
	proxy:TreasureDispModeChange2( 1610, false ,KEN_SFX);
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8290 ) == true then--�V�����A�j�� 
		proxy:PlayAnimation( 1610 , 1);	
		print("OnEvent_1591_3 end");
		return true;
	end		
	
	--���Ƀ��[�v
	proxy:WarpDmy( LOCAL_PLAYER , 1610 , 191 );
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1591 , LOCAL_PLAYER , 8290 , "OnEvent_1591_1", once);
	proxy:NotNetMessage_end();	
	print("OnEvent_1591_3 end");	
end
