
--�������ʂ̔��������p�����[�^
BloodCycle_low		= 1.00;	--�������ʂ̎���(�Œ�)
BloodCycle_High		= 1.01;	--�������ʂ̎���(�ŒZ)

IsInBloodArea		= false;--�����ɓ����Ă��邩�H



--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉����������
--------------------------------------------------------------------------------------
function Initialize_m05_02_00_00(proxy)
	print("Initialize_m05_02_00_00 begin");
-----------------------------------------------------------------------------------------
--�{�X�֘A
-----------------------------------------------------------------------------------------
--��5888���G���A�{�X���S��
	proxy:AddFieldInsFilter( 824 );
	if proxy:IsCompleteEvent( 5888 ) ==false then
		proxy:OnCharacterDead(5888, 824, "OnEvent_5888", once);
	else
		proxy:SetEventFlag( 7299 , 1 ); --�Β��̃A�N�V����ID��ON
	end

--��5889�����{�X���S�Ď���
	if proxy:IsCompleteEvent( 5889 ) == false then
		--��b����̌Ăяo���ł͂Ȃ��Ȃ���
		--proxy:LuaCall(5889, 0, "OnEvent_5889", once);
		proxy:OnCharacterDead(5889, 824, "OnEvent_5889", once);
	end

--��1031���{�X�����ɓ��遡
	
	--���{�X�������Ă���Ƃ������C�x���g�o�^
	if proxy:IsCompleteEvent( 5889 ) == false then
	
		--�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B
		SingleReset(proxy, 1031);
	
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���)
		proxy:LuaCall( 1032, 1, "OnEvent_1032_1", everytime );
		
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCall( 1032 , 5 , "OnEvent_1031_GO_TO_IN" , everytime );
		
		--���t���O�Z�b�g(�����p)
		proxy:LuaCall( 1032 , 6 , "OnEvent_1031_flag_set" , everytime );
		
		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ�
		if proxy:IsCompleteEvent( 1031 ) == false then
		
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l����
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--��1031�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegionAttribute( 1031, 2893, "OnEvent_1031", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
		
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B
		
			proxy:NotNetMessage_begin();
				--��1032�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegion( 1032, 2893, "OnEvent_1031", HELPID_GO_TO_IN, everytime );--�n���h���͏�Ɠ���
			proxy:NotNetMessage_end();
		
		end

	end

	
--��1033���{�X�퓬�J�n��	
	if proxy:IsCompleteEvent( 5889 ) == false then
		proxy:OnRegionJustIn( 1033 , 10000 , 2885 , "OnEvent_1033" , once );
	end	

--��1030���G���A�{�X�|�����Đ���
	if proxy:IsCompleteEvent( 1030 ) == false then
	
		proxy:OnRegionJustIn( 1030 , 10000 , 2897 , "OnEvent_1030" , once );
	
		--�|�����J�n�t�F�[�h��ɌĂ΂��n���h��
		proxy:LuaCall(1030,REMO_START,"OnEvent_1030_RemoStart",once);
		--�|�����I����ɌĂ΂��n���h��
		proxy:LuaCall(1030,REMO_FINISH,"OnEvent_1030_RemoFinish",once);

	end

--���{�X�֘A�̏���������
	if proxy:IsCompleteEvent( 5889 ) ==true then
		--���{�X����ł���Ƃ�
		
		--�{�X���Ȃ��Ȃ�
		InvalidBackRead( proxy , 824 );
		
		--���@�Ǐ�����
		proxy:SetColiEnable( 1997 , false );
		proxy:SetDrawEnable( 1997 , false );
		--���@�ǂ�SFX OFF
		proxy:InvalidSfx( 1989 , false );

		--�z�X�g�v���C���[�̂݃A�C�e������C�x���g�Ɏg�p
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		
		--�󎀑�(�\�E��?)�L����
		proxy:SetDrawEnable( 1980 , true );
		proxy:SetColiEnable( 1980 , true );
		proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--���点��
		--�\�E���Ɏh���������L����
		proxy:SetDrawEnable( 1977 , true );
		proxy:SetColiEnable( 1977 , true );
		--proxy:TreasureDispModeChange2( 1977 , true ,KANAME_SFX);--���点��
		
		--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
		if proxy:IsCompleteEvent( 5893 ) == false then
			--SFX�L����
			proxy:ValidSfx( 2401 );--�v�΂̃I�[��
			proxy:ValidSfx( 2402 );--���̗��q
			
			proxy:OnDistanceActionAttribute( 5893 , 10000 , 1980 , "OnEvent_5893" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--SFX��������
			proxy:InvalidSfx( 2401 , false );--�v�΂̃I�[��
			--proxy:InvalidSfx( 2402 , false );--���̗��q
			--���v�΂Ń��[�v�p�̊Ď���ǉ���
			SingleReset(proxy,5895);
			proxy:OnDistanceActionAttribute( 5895 , 10000 , 1980 , "OnEvent_5895" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
		--------------------------------------
	else
		--���{�X�������Ă���
		proxy:EnableLogic( 824 , false );--���W�b�NOFF�őҋ@
		
		--�󎀑�(�\�E��?)
		proxy:SetDrawEnable( 1980 , false );
		proxy:SetColiEnable( 1980 , false );
		--�\�E���Ɏh��������������
		proxy:SetDrawEnable( 1977 , false );
		proxy:SetColiEnable( 1977 , false );		
		
		--SFX��������
		proxy:InvalidSfx( 2401 , false );--�v�΂̃I�[��
		proxy:InvalidSfx( 2402 , false );--���̗��q
		
		--���̕�Sfx��L����
		proxy:ValidSfx( 1989 );
	end
	
-----------------------------------------------------------------------------------------
--�M�~�b�N�֘A
-----------------------------------------------------------------------------------------
--��1040���͂����P�@�~��遡
	--��PC���C�x���g�G���A(2410)�̒��ɋ��āA�����p�x(LadderAngle_A)�ŃA�N�V�����{�^�����������Ƃ���--
	proxy:OnActionEventRegion( 1040, 2410, "OnEvent_1040", LadderAngle_A, HELPID_DOWN, everytime );
--��1041���͂����P�@���遡
	--��PC���C�x���g�G���A(2411)�̒��ɋ��āA�����p�x(LadderAngle_A)�ŃA�N�V�����{�^�����������Ƃ���--
	proxy:OnActionEventRegion( 1041, 2411, "OnEvent_1041", LadderAngle_A, HELPID_UP, everytime );
	
	
--��1042���͂����Q�@�~��遡
	--��PC���C�x���g�G���A(2412)�̒��ɋ��āA�����p�x(LadderAngle_A)�ŃA�N�V�����{�^�����������Ƃ���--
	proxy:OnActionEventRegion( 1042, 2412, "OnEvent_1042", LadderAngle_A, HELPID_DOWN, everytime );
--��1043���͂����Q�@���遡
	--��PC���C�x���g�G���A(2413)�̒��ɋ��āA�����p�x(LadderAngle_A)�ŃA�N�V�����{�^�����������Ƃ���--
	proxy:OnActionEventRegion( 1043, 2413, "OnEvent_1043", LadderAngle_A, HELPID_UP, everytime );


	
--[[���������s���̂��߃R�����g�A�E�g

--��1050���G���A�{�X���򉻂����|�����Đ���
	if proxy:IsCompleteEvent( 1050 ) == false then
	
	--	proxy:OnRegionJustIn( 1050 , 10000 , 2000 , "OnEvent_1050" , once );
	
		--�|�����J�n�t�F�[�h��ɌĂ΂��n���h��
		proxy:LuaCall(1050,REMO_START,"OnEvent_1050_RemoStart",once);
		--�|�����I����ɌĂ΂��n���h��
		proxy:LuaCall(1050,REMO_FINISH,"OnEvent_1050_RemoFinish",once);

	end
]]


--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m05_02_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m05_02_00_00", everytime );
	proxy:NotNetMessage_end();

	--�������̗̈�Ď��ǉ�
	if proxy:IsCompleteEvent( 1060 ) == false then
		proxy:OnRegionJustIn( 1060, 10000, 2450, "OnEvent_1060", once );
		proxy:ChangeModel( 1440, 1 );
	else
		proxy:SetColiEnable( 1440, false );
		proxy:SetDrawEnable( 1440, false );
	end
	
	if proxy:IsCompleteEvent( 1080 ) == false then
		proxy:OnRegionJustIn( 1080, 10000, 2451, "OnEvent_1080", once );
		proxy:ChangeModel( 1450, 1 );
	else
		proxy:SetColiEnable( 1450, false );
		proxy:SetDrawEnable( 1450, false );
	end
	
	if proxy:IsCompleteEvent( 1081 ) == false then
		proxy:OnRegionJustIn( 1081, 10000, 2451, "OnEvent_1081", once );
		proxy:ChangeModel( 1451, 1 );
	else
		proxy:SetColiEnable( 1451, false );
		proxy:SetDrawEnable( 1451, false );
	end
	
	if proxy:IsCompleteEvent( 1082 ) == false then
		proxy:OnRegionJustIn( 1082, 10000, 2452, "OnEvent_1082", once );
		proxy:ChangeModel( 1452, 1 );
	else
		proxy:SetColiEnable( 1452, false );
		proxy:SetDrawEnable( 1452, false );
	end
	
	if proxy:IsCompleteEvent( 1083 ) == false then
		proxy:OnRegionJustIn( 1083, 10000, 2452, "OnEvent_1083", once );
		proxy:ChangeModel( 1453, 1 );
	else
		proxy:SetColiEnable( 1453, false );
		proxy:SetDrawEnable( 1453, false );
	end
	
	--��1090���ŏ�
	proxy:SetEventFlag( 1090, false );
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc( 1090, "Condition_1090", "dummy", 2, once );
	proxy:NotNetMessage_end();

	proxy:LuaCall( 1069, 2, "OnEvent_1061_1069_call", everytime );


	--�W�F�l���[�^On
	if proxy:IsCompleteEvent( 5889 ) == false then
		proxy:EnableGeneratorSystem(2420,true);
		proxy:EnableGeneratorSystem(2421,true);
		proxy:EnableGeneratorSystem(2422,true);
		proxy:EnableGeneratorSystem(2423,true);
		proxy:EnableGeneratorSystem(2424,true);
		proxy:EnableGeneratorSystem(2425,true);
		proxy:EnableGeneratorSystem(2426,true);
		proxy:EnableGeneratorSystem(2427,true);
		proxy:EnableGeneratorSystem(2428,true);
		proxy:EnableGeneratorSystem(2429,true);
		proxy:EnableGeneratorSystem(2430,true);
		proxy:EnableGeneratorSystem(2431,true);
	end
	
--��1120�`1129�����[�u���̎q���B�̃^�[�Q�b�g�����ύX��
	RegistLibraJr_Target(proxy);
	
	
--��8087���s��֗����t���O�𗧂Ă遡
	proxy:SetEventFlag( 8087, true );

-----------------------------------------------------------------------------------------
--NPC�֘A
-----------------------------------------------------------------------------------------
	----------------------------------------------------------------------
	--���[�u���֘A
	----------------------------------------------------------------------
	--m05_02_00_00_eventboss.lua�ɋL��
	----------------------------------------------------------------------
	--�K���E�S�[���h�����֘A
	----------------------------------------------------------------------
	--m05_02_00_00_eventboss.lua�L��

--~ --��15500�������A�C�e���擾�Ď����n���h���̓O���[�o���ɒ�`
--~ 	if proxy:IsCompleteEvent( 15500 ) == false then
--~ 		proxy:AddCorpseEvent( 15500 , 460 );--�K���S�[���h����
--~ 	end

-----------------------------------------------------------------------------------------	
--��999999���t���[���x��̏����������C�x���g�𔭍s��
-----------------------------------------------------------------------------------------
	proxy:NotNetMessage_begin();
		--��0�b�づ--
		proxy:OnKeyTime2( 999995, "Second_Initialize_m05_02_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m05_02_00_00 end");
end


--------------------------------------------------------------------------------------
--Initialize����Ă΂��A1�t���[���x��̏�����������999999
--------------------------------------------------------------------------------------
--��999999���ꕔ�AInit�ł͏����ł��Ȃ��̂ŁA�c���Ă���
function Second_Initialize_m05_02_00_00(proxy, param)
	print("Second_Initialize_m05_02_00_00 begin");

--------------------------------������QWC�C�x���g�֘A������--------------------------------
--------------------------------������QWC�C�x���g�֘A������--------------------------------

	print("Second_Initialize_m05_02_00_00 end");
end





function OnEvent_1060(proxy,param)
	print("OnEvent_1060 begin");
	--��1061�`1069����������2�`10
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		local IsAdd = false;
		for index = 1, 9, 1 do
			local evid = 1061 + index - 1;
			if proxy:IsCompleteEvent(evid) == false then
				proxy:ChangeModel( 1441 + index - 1, 1 );
				if IsAdd == false then
					local wait = proxy:GetRandom( M52_Corpse_FallWait_Low * 1000, M52_Corpse_FallWait_High * 1000 ) / 1000;
					proxy:OnKeyTime2( evid, "OnEvent_1061_1069", wait, 0, index, once );
					IsAdd = true;
				end
			else
				proxy:SetColiEnable( 1441 + index - 1, false );
				proxy:SetDrawEnable( 1441 + index - 1, false );
			end
		end
	end
	
	proxy:ChangeModel( 1440, 0 );
	proxy:SetEventFlag( param:GetParam1(), true );
	print("OnEvent_1060 end");
end

function OnEvent_1061_1069(proxy,param)
	print("OnEvent_1061_1069 begin");

	proxy:LuaCallStartPlus( 1069, 2, param:GetParam3() );
	
	--�Ō�܂Ŏ��s���ꂽ��
	if param:GetParam1() == 1069 then
		return;
	end
	
	local wait = proxy:GetRandom(M52_Corpse_FallWait_Low * 1000, M52_Corpse_FallWait_High * 1000 ) / 1000;
	proxy:OnKeyTime2( param:GetParam1() + 1, "OnEvent_1061_1069", wait, 0, param:GetParam3() + 1, once );
	
	print("OnEvent_1061_1069 end");
end

function OnEvent_1061_1069_call(proxy,param)
	print("OnEvent_1061_1069_call begin");
	
	--�I�u�W�F���n�{�b�N�ɖ߂��ė���������
	proxy:ChangeModel( 1441 + param:GetParam3() - 1, 0 );
	
	--�I�u�W�F���n�{�b�N�ɖ߂�
	proxy:SetEventFlag( 1061 + param:GetParam3() - 1, true );
	
	print("OnEvent_1061_1069_call end");
end



function OnEvent_1080(proxy,param)
	print("OnEvent_1080 begin");
	proxy:ChangeModel( 1440, 0 );
	proxy:SetEventFlag( param:GetParam1(), true );
	print("OnEvent_1080 end");
end
function OnEvent_1081(proxy,param)
	print("OnEvent_1081 begin");
	proxy:ChangeModel( 1441, 0 );
	proxy:SetEventFlag( param:GetParam1(), true );
	print("OnEvent_1081 end");
end
function OnEvent_1082(proxy,param)
	print("OnEvent_1082 begin");
	proxy:ChangeModel( 1442, 0 );
	proxy:SetEventFlag( param:GetParam1(), true );
	print("OnEvent_1082 end");
end
function OnEvent_1083(proxy,param)
	print("OnEvent_1083 begin");
	proxy:ChangeModel( 1443, 0 );
	proxy:SetEventFlag( param:GetParam1(), true );
	print("OnEvent_1083 end");
end



--------------------------------------------------------------------------------------
--��5888���G���A�{�X���S��
--------------------------------------------------------------------------------------
--��5888���G���A�{�X���S��
function OnEvent_5888(proxy, param)
	print("OnEvent_5888 begin");

	proxy:SetEventFlag( 5888, 1 );
	
	proxy:SetEventFlag( 7299, 1 );--�Β��̃A�N�V�����t���OON
	
	print("OnEvent_5888 end");
end


--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m05_02_00_00(proxy, param)
	print("PlayerDeath_m05_02_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m05_02_00_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerDeath_m05_02_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m05_02_00_00(proxy,param)
	print("PlayerRevive_m05_02_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m05_02_00_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerRevive_m05_02_00_00");
end
--------------------------------------------------------------------------------------
--��1030���G���A�{�X�|�����Đ���
--------------------------------------------------------------------------------------

function OnEvent_1030(proxy , param)
	print("OnEvent_1030 begin");

	--���G���A�{�X�|�����Đ�
	proxy:RequestRemo(50200,REMO_FLAG,1030,1);
	proxy:SetEventFlag( 1030, true );
	
	print("OnEvent_1030 end");
end


--���|�����Đ��J�n(�t�F�[�h�I��)
function OnEvent_1030_RemoStart(proxy,param)
	print("OnEvent_1030_RemoStart begin");
	print("OnEvent_1030_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��)
function OnEvent_1030_RemoFinish(proxy , param)
	print("OnEvent_1030_RemoFinish begin");
	print("OnEvent_1030_RemoFinish end");
end




--------------------------------------------------------------------------------------
--��1050���G���A�{�X���򉻂����|�����Đ���
--------------------------------------------------------------------------------------

function OnEvent_1050(proxy , param)
	print("OnEvent_1050 begin");

	--���G���A�{�X���򉻂����|�����Đ�
	proxy:RequestRemo(50201,REMO_FLAG,1050,1);
	proxy:SetEventFlag( 1050, true );
	
	print("OnEvent_1050 end");
end


--���|�����Đ��J�n(�t�F�[�h�I��)
function OnEvent_1050_RemoStart(proxy,param)
	print("OnEvent_1050_RemoStart begin");	
	print("OnEvent_1050_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��)
function OnEvent_1050_RemoFinish(proxy , param)
	print("OnEvent_1050_RemoFinish begin");
	print("OnEvent_1050_RemoFinish end");
end

--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ��遡1031
--------------------------------------------------------------------------------------

--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫

--��1031�����{�X�����ւ̔����J����
function OnEvent_1031(proxy,param)
	print("OnEvent_1031 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_1031 end");
		return;
	end
	
	--�N���C�A���g�ցA�{�X�����j�~���s��ʒm
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 1032, 1 );--����A�j���̓����Đ�
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--���d�N���V�X�e��ID���^�C���A�E�g��ݒ肵��ON�ɂ���
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1031 end");
end


--����A�j���̓����Đ�(ID����)
function OnEvent_1032_1(proxy,param)
	print("OnEvent_1032_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ����s���A���̏I������OnEvent_1032_2�𔭍s����
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2889 );
		else
			proxy:LockSession();--���[�������b�N���܂��I
			--����A�j���Đ����s���A���̏I������OnEvent_1032_2�𔭍s����
			proxy:OnTurnCharactorEnd( 1032, 10000, 2889, "OnEvent_1032_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1032_1 end");
end

--����A�j���̓����Đ��I����
function OnEvent_1032_2(proxy,param)
	print("OnEvent_1032_2 begin");

	--�����p�����A�j���Đ�
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1032, 10000, ANIMEID_WALK, "OnEvent_1032_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1032_2 end");
end

--�����A�j���̓����Đ��I����
function OnEvent_1032_3(proxy,param)
	print("OnEvent_1032_3 begin");

	--�ŏ��̐l���{�X�����̒��ɓ���I����Ă�����A���ɔz�M����Ă���͂��Ȃ̂ŁA����������Ȃ��n���h��
	if proxy:IsCompleteEvent( 1031 ) == false then
		proxy:LuaCallStart( 1032 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCallStart( 4045 , 1 );	--�N���C�A���g�ցA�{�X�����ɓ����悤�ɂȂ������Ƃ�ʒm
		proxy:LuaCallStart( 1032 , 6 );--�t���O�Z�b�g(�����p)
		local eneidlist = {	824,651,530,531,532,533,534,535,536,537,538,
							545,546,551,552,558,559,563,564,565,572,573,
							574,575,576,581,582,583,584,585,586,587,588,
							589,590,591,592,593,594,595,596,597,598,599};
		local num = table.getn(eneidlist);
		for index = 1, num , 1 do
			Lua_MultiDoping(proxy,eneidlist[index] );--�}���`�v���C�h�[�s���O
		end
	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�)
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:ResetThink( 824 );
	end	
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );

	print("OnEvent_1032_3 end");
end


--��1031 2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
function OnEvent_1031_GO_TO_IN(proxy, param)
	print("OnEvent_1031_GO_TO_IN begin");

	proxy:NotNetMessage_begin();
		--��1032�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���--�n���h���� OnEvent_1031
		proxy:OnPlayerActionInRegion( 1032, 2893, "OnEvent_1031", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	

	print("OnEvent_1031_GO_TO_IN end");
end


--��1031 �t���O�Z�b�g(�����p)
function OnEvent_1031_flag_set(proxy, param)
	print("OnEvent_1031_flag_set begin");
		
	proxy:SetEventFlag( 1031 , 1 );
	proxy:DeleteEvent( 1031 );

	print("OnEvent_1031_flag_set end");
end



--------------------------------------------------------------------------------------
--�{�X�������o��(�퓬�J�n)��1033
--------------------------------------------------------------------------------------

function OnEvent_1033(proxy, param)
	print("OnEvent_1033 begin");
	
	--�{�X��pBGM�Đ��J�n
	proxy:PlayPointSE( 2400, SOUND_TYPE_M, 50200000, 2 );
	
	proxy:EnableLogic( 824, true );
	
	--�ǂݍ��݃^�C�~���O�̂Ƃ�����ǉ�����Ăق����̂Ńt���O���ĂȂ�
	
	--�{�X�Q�[�W�\��
	proxy:SetBossGauge(824, 0, 6040);
	
	LuaFunc_ForceOmission(proxy,460);
	LuaFunc_ForceOmission(proxy,651);
	LuaFunc_ForceOmission(proxy,824);
	print("OnEvent_1033 end");
end

--------------------------------------------------------------------------------------
--��5889�����{�X���S����
--------------------------------------------------------------------------------------
--��5889�����{�X���S����
function OnEvent_5889(proxy, param)
	print("OnEvent_5889 begin");

	--���[�u���̎q���W�F�l���[�^OFF
	proxy:EnableGeneratorSystem(2420,false);
	proxy:EnableGeneratorSystem(2421,false);
	proxy:EnableGeneratorSystem(2422,false);
	proxy:EnableGeneratorSystem(2423,false);
	proxy:EnableGeneratorSystem(2424,false);
	proxy:EnableGeneratorSystem(2425,false);
	proxy:EnableGeneratorSystem(2426,false);
	proxy:EnableGeneratorSystem(2427,false);
	proxy:EnableGeneratorSystem(2428,false);
	proxy:EnableGeneratorSystem(2429,false);
	proxy:EnableGeneratorSystem(2430,false);
	proxy:EnableGeneratorSystem(2431,false);
	--�W�F�l���[�^�֘A�̃t���O(�K�v�Ȃ����ǁA���ĂȂ��ƃo�O�񍐂��ꂿ�Ⴄ�̂�)
	proxy:SetEventFlag( 1050, true );
	proxy:SetEventFlag( 1051, true );
	
	proxy:NotNetMessage_begin();
		--��5889_1��1�b�o�߁�
		proxy:OnKeyTime2( 5889, "OnEvent_5889_1", 1, 0, 0, once);
		--��5892��2�b�o�߁�
		proxy:OnKeyTime2( 5892, "OnEvent_5892", 2.0, 0, 2, once);
		--�}���`���U�Ď�
		proxy:OnRegistFunc( 5889 , "Check_5889_PT","OnEvent_5889_PT",0,once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 5889, 1 );
	
	--�K���̏�Ԃ����ď���
	if proxy:IsCompleteEvent( GAL_STATE_LIVE ) == true then
		--���C�𖳂���
		proxy:ResetThink( 651 );
		proxy:EnableLogic( 651 , false );
		--proxy:SetSpStayAndDamageAnimId( 651,8821,-1);
		proxy:SetEventCommand( 651 , 900 );
		--�ēx�G��
		proxy:NotNetMessage_begin();
			proxy:OnSimpleDamage( 1117 , 651 , 10000 , "OnEvent_1117",once);
		proxy:NotNetMessage_end();
	end	
	
	--�V�u���b�N�N���A������
	proxy:CustomLuaCallStart( 4050, 824);
	--�g�J�Q���Z�b�g
	ResetTokage(proxy);
	
	--[[
	--����3�J���C���t�H���[�V����
	if proxy:IsClient() == false then
		if proxy:IsCompleteEvent( 8050 ) == false then
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 8050 , "OnEvent_8050",5.0,0,0,once);
				proxy:SetEventFlag( 8050 , true );
			proxy:NotNetMessage_end();
		end
	end
	]]
	
	--�z�X�g���L�����@or�@�V���O��
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then	
		proxy:SetEventFlag(	8013, 1 );--�N���A�t���OON
	end
	
	print("OnEvent_5889 end");
end

--��5889_1�����{�X���S��1�b��
function OnEvent_5889_1(proxy, param)
	print("OnEvent_5889_1 begin");
	
	--�{�X��|���������X�V(���ɂ���ăt���O�𗧂Ă�)
	GetBossFlagCount( proxy, param );
	
	--���g���t�B�[�擾���聥
	Lua_RequestUnlockTrophy(proxy, 9);--�g���t�B�̏󋵂𔻒肵�A�擾
	
--�A�C�e������֘A-------
	
	--�z�X�g�v���C���[�̂݃A�C�e������C�x���g�Ɏg�p
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

	--�󎀑�(�\�E��?)�L����
	proxy:SetDrawEnable( 1980 , true );
	proxy:SetColiEnable( 1980 , true );
	--�\�E���Ɏh���������L����
	proxy:SetDrawEnable( 1977 , true );
	proxy:SetColiEnable( 1977 , true );
	
	--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
	if proxy:IsCompleteEvent( 5893 ) == false then
		--SFX�L����
		proxy:ValidSfx( 2401 );--�v�΂̃I�[��
		proxy:ValidSfx( 2402 );--���̗��q
		--�\�E���Ǝh�����Ă��錕���P������
		proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--���点��
		--proxy:TreasureDispModeChange2( 1977 , true ,KANAME_SFX);--���点��
		proxy:OnDistanceActionAttribute( 5893 , 10000 , 1980 , "OnEvent_5893" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end

	--���{�X�����O�̈ړ������C�x���g���폜
	proxy:DeleteEvent( 1031 );--��l�ڂ�����Ƃ��p
	proxy:DeleteEvent( 1032 );--��l�ڈȍ~������Ƃ��p
	proxy:DeleteEvent( 1033 );--�{�X�퓬�J�n�p
		
	print("OnEvent_5889_1 end");
end

--��5892��2�b�o�߁�--------------
function OnEvent_5892(proxy,param)
	print("OnEvent_5892 begin");
	
	--�{�X��p��BGM��~
	proxy:StopPointSE( 2 );
	
	proxy:SetEventFlag( 5892, true );
	print("OnEvent_5892 end");
end

--�}���`���U�Ď�
function Check_5889_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--�}���`����Ȃ�
function OnEvent_5889_PT(proxy,param)
	print("OnEvent_5889_PT begin");
	--���{�X�����̑O��̖��@�ǂ�������(�S�v���C���[)
	proxy:SetColiEnable( 1997 , false );
	proxy:SetDrawEnable( 1997 , false );
	
	--���{�X�������@�ǂ�SFX�폜
	proxy:InvalidSfx( 1989 , true );
	print("OnEvent_5889_PT end");
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
--��5893���\�E���A�C�e�����聡
--------------------------------------------------------------------------------------
function OnEvent_5893(proxy,param)
	print("OnEvent_5893 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--�V�����A�j�� 
		print("OnEvent_5893 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 5893, "OnEvent_5893_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_5893 end");
end

--��5893_1���A�C�e���擾��
function OnEvent_5893_1(proxy, param)
	print("OnEvent_5893_1 begin");

	--�A�C�e���擾�֐�
	proxy:GetRateItem(10452);--�p�����[�^10452�Q��
	proxy:GetRateItem(10478);--�p�����[�^10478�Q��
	proxy:GetRateItem(10479);--�p�����[�^10479�Q��
	proxy:GetRateItem(10480);--�p�����[�^10480�Q��
	proxy:GetRateItem(10481);--�p�����[�^10481�Q��
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 5893, 1 );
	
	--��V�F�[�_�[OFF
	--proxy:TreasureDispModeChange( 1980 , false );--���点��̂���߂�
	
	--SFX��������
	proxy:InvalidSfx( 2401 , true );--�v�΂̃I�[��
	--proxy:InvalidSfx( 2402 , true );--���̗��q	
	
	if proxy:IsCompleteEvent( 8035 ) == false then
		proxy:NotNetMessage_begin();
			--�u�Ԃŕ\������ƃ��j���[����ɏo��̂ő҂�
			proxy:OnKeyTime2( 8035 , "OnEvent_8035_wait",0.5 , 0 , 1, once);			
		proxy:NotNetMessage_end();
	else
		--���v�΂Ń��[�v�p�̊Ď���ǉ���
		proxy:OnDistanceActionAttribute( 5895 , 10000 , 1980 , "OnEvent_5895" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	end	
	print("OnEvent_5893_1 end");
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
	proxy:OnDistanceActionAttribute( 5895 , 10000 , 1980 , "OnEvent_5895" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	print("OnEvent_8035 end");
end



--------------------------------------------------------------------------------------
--�Β��Ƀ��[�v��5895
--------------------------------------------------------------------------------------
--��5895�Β��Ƀ��[�v��
function OnEvent_5895(proxy,param)
	print("OnEvent_5895 begin");
	
	if proxy:IsCompleteEvent( 5895 ) == true then
		return;
	end
	
	proxy:RepeatMessage_begin();
		--��5895_1���I�����j���[�̊Ď���
		proxy:OnSelectMenu(5895, "OnEvent_5895_0", 10010710, 0, 2, 1980, 2, once);
	proxy:RepeatMessage_end();
	
	print("OnEvent_5895 end");
end

--��5895_0���I�����j���[�̊Ď���
function OnEvent_5895_0(proxy,param)	
	print("OnEvent_5895_0 begin");
	
	if proxy:IsSession() == false then
		
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1980 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			proxy:OnChrAnimEnd(5895, 10000, 8283, "OnEvent_5895_1", once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(5895,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_5895_0 end");
end

--��5895_1���I�����j���[�̊Ď���
function OnEvent_5895_1(proxy,param)	
	print("OnEvent_5895_1 begin");
	
	proxy:SetEventFlag(5895,false);
	
	proxy:PlayAnimation( 10000, 8284 );

	proxy:SetEventFlag(5895,true);
	
	OnEvent_5895_2(proxy, param);
	
	print("OnEvent_5895_1 end");
end

--��5895_2���I�����j���[�̊Ď���
function OnEvent_5895_2(proxy,param)
	print("OnEvent_5895_2 begin");
	
	--�Β��֖߂��Ă�������̃t���O�𗧂Ă�
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag(5895,false);
	--���S�񕜗v��
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1009 );
	
	print("OnEvent_5895_2 end");
end





--------------------------------------------------------------------------------------
--�n�V�S
--------------------------------------------------------------------------------------
function OnEvent_1040(proxy,param)
	print("OnEvent_1040 begin");
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1040 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,2,2);				--�z�o�[�ړ����[�h�Ɉڍs
	proxy:HoverMoveValDmy(10000,1430,192,LadderTime_A);--�ړ��ʒu(192)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,1);				--�C�x���g�R�}���hID(1)"�n�V�S�ォ���"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000, true);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(1040,"OnEvent_1040_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���)
		proxy:OnKeyTime2(1040,"LadderDown",3.0,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1040 end");
end

function OnEvent_1040_1(proxy,param)
	print("OnEvent_1040_1 begin");
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1040_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	--nMax   = �i��(14) - �␳�l(3) = 11
	--nStart = nMax(11) + �~���Ƃ�(1) = 12
	proxy:BeginAction(10000,1,7,6);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1040_1 end");
end

function OnEvent_1041(proxy,param)
	print("OnEvent_1041 begin");
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_543 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,-1,1);			--�z�o�[�ړ����[�h�Ɉڍs
	proxy:HoverMoveValDmy(10000,1430,191,LadderTime_A);--�ړ��ʒu(191)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,0);				--�C�x���g�R�}���hID(0)"�n�V�S�������"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(1041,"OnEvent_1041_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���)
		proxy:OnKeyTime2(1041,"LadderDown",3.0,1,1,once);
	proxy:NotNetMessage_end();
	print("OnEvent_1041 end");
end

function OnEvent_1041_1(proxy,param)
	print("OnEvent_1041_1 begin");
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1041_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	--nMax   = �i��(14) - �␳�l(3) = 11
	--nStart = ����Ƃ�(-1) = -1
	proxy:BeginAction(10000,1,-1,6);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1041_1 end");
end




function OnEvent_1042(proxy,param)
	print("OnEvent_1042 begin");
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1042 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,2,2);				--�z�o�[�ړ����[�h�Ɉڍs
	proxy:HoverMoveValDmy(10000,1431,192,LadderTime_A);--�ړ��ʒu(192)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,1);				--�C�x���g�R�}���hID(1)"�n�V�S�ォ���"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000, true);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(1042,"OnEvent_1042_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���)
		proxy:OnKeyTime2(1042,"LadderDown",3.0,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1042 end");
end

function OnEvent_1042_1(proxy,param)
	print("OnEvent_1042_1 begin");
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1042_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	--nMax   = �i��(14) - �␳�l(3) = 11
	--nStart = nMax(11) + �~���Ƃ�(1) = 12
	proxy:BeginAction(10000,1,11,10);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1042_1 end");
end

function OnEvent_1043(proxy,param)
	print("OnEvent_1043 begin");
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1043 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,-1,1);			--�z�o�[�ړ����[�h�Ɉڍs
	proxy:HoverMoveValDmy(10000,1431,191,LadderTime_A);--�ړ��ʒu(191)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,0);				--�C�x���g�R�}���hID(0)"�n�V�S�������"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(1043,"OnEvent_1043_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���)
		proxy:OnKeyTime2(1043,"LadderDown",3.0,1,1,once);
	proxy:NotNetMessage_end();
	print("OnEvent_1043 end");
end

function OnEvent_1043_1(proxy,param)
	print("OnEvent_1043_1 begin");
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1043_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	--nMax   = �i��(14) - �␳�l(3) = 11
	--nStart = ����Ƃ�(-1) = -1
	proxy:BeginAction(10000,1,-1,10);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1043_1 end");
end


--------------------------------------------------------------------------------------
--��1090���ŏ���
--------------------------------------------------------------------------------------
--��1090���ŏ���
function Condition_1090(proxy,param)
	--���_���[�W�p�|�C���g�̊e�C�x���gID
	--2460,2461,2462
	local floorTbl = {2460,2461,2462};
	local tblnum = table.getn( floorTbl );
	IsInBloodArea = false;--�Ƃ肠���������ĂȂ�����
	local ACID = 1090;
	
	
	for index = 1, tblnum, 1 do
		if proxy:IsRegionIn( 10000, floorTbl[index] ) == true then
			IsInBloodArea = true;
		end
	end
	
	
	--�������u��
	if proxy:IsCompleteEvent( ACID ) == false and
		IsInBloodArea == true then
		print("PoizonFloorDam JustIn", tblnum);
		proxy:SetEventSpecialEffect(10000, 10090);
		proxy:SetEventFlag( ACID, IsInBloodArea );
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 1091, "OnEvent_1091", 0.0, 0, 1, once );
		proxy:NotNetMessage_end();
	end
	
	--�����o���u��
	if  proxy:IsCompleteEvent( ACID ) == true and
		IsInBloodArea == false then
		print("PoizonFloorDam JustOut", tblnum);
		proxy:EraseEventSpecialEffect(10000, 10090);
		proxy:SetEventFlag( ACID, IsInBloodArea );
		proxy:DeleteEvent(1091);
	end

	
	--��΂Ɍ��ʂ𐬗������Ȃ���
	return false;
end

function dummy(proxy,param)
end

function OnEvent_1091(proxy,param)
	print("OnEvent_1091 begin");
	local set_param = proxy:DivideRest( param:GetParam3() + 1, 2 );
	local reload = Lua_GetReloadTime(proxy,BloodCycle_low,BloodCycle_High);
	
	--�p���I�ɓ����Ă��鎞�̂ݎ��̌��ʂ�ݒ�ł���
	if IsInBloodArea == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 1091, "OnEvent_1091", reload, 0, set_param, once );
		proxy:NotNetMessage_end();
	else
		--�O�̈׏d����������
		proxy:EraseEventSpecialEffect(10000, 10090);
	end
	
	proxy:SetEventSpecialEffect(10000, 10290);
	print("OnEvent_1091 end");
end



--��1120�����[�u���̎q���B�̃^�[�Q�b�g�����ύX��
--�N���N��_���Ă��������Č�����Ƒ�ςȂ��ƂɂȂ�̂ŁA
--���ꂼ��̐��E�ł�������C�x���g�𔭓������邱�Ƃɂ��܂��B(���R����Ƒ��k�ς�)
function RegistLibraJr_Target(proxy)
	local evid_list = {  360,  361,  362,  363,  372,  373,  374,  375,  377,  391};
	local event_num = table.getn(evid_list);
	for index = 1, event_num, 1 do
		local evid = evid_list[index];
		proxy:NotNetMessage_begin();
			proxy:OnRegionJustIn( 1120, evid, 2470, "OnEvent_1120", once );
		proxy:NotNetMessage_end();
		
		--���s�l�Ƀ��[�u����_�킹��
		proxy:SetEventTarget( evid_list[index], 824 );
	end
end



LibraJr_HideDistance		= 12.0;
function OnEvent_1120(proxy,param) 
	print("OnEvent_1120 begin");
	local evid = param:GetParam2();
	for JrId = 530, 599, 1 do
		if	proxy:IsDistance( JrId, evid, LibraJr_HideDistance ) == true then
			print( JrId.." Target to "..evid );
			proxy:ForceChangeTarget( JrId, evid);
		end
	end
	print("OnEvent_1120 end");
end




