--����ȃC�x���g�E�E�E�R���ƌ����Ă�o�[�j�B�B�B�B!


--���������������́A������Q�Ƃ��ăt�@���l����������
ForceSummonBlack_PlayerNo				= -1;

ForceSummonTimeOut						= 100;
--ForceSummonTimeOut						= 10;


--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉����������
--------------------------------------------------------------------------------------
function Initialize_m04_02_00_00(proxy)
	print("Initialize_m04_02_00_00 begin");	

--��1065���u���b�NNPC�����o���p��LuaCall�o�^
	proxy:LuaCall( 1065, 2, "SynchroValid_1065", everytime );
	proxy:LuaCall( 1065, 3, "SynchroValid_NoAnim_1065", everytime );
	proxy:LuaCall( 1065, 4, "SynchroInvalid_1065", everytime );
	proxy:LuaCall( 1065, 5, "SynchroInvalid_1065_ForBlack",everytime );--�������������ꂽ���̔O�̈�
	proxy:LuaCall( 1065, 4271, "SynchroWarp_1065", everytime );
	proxy:LuaCall( 1065, 2420, "SynchroWarp_1065", everytime );
	proxy:LuaCall( 1065, 2421, "SynchroWarp_1065", everytime );
	proxy:LuaCall( 1065, 2422, "SynchroWarp_1065", everytime );
	
	--���������u���b�N�S�[�X�g�������������ꂽ
	proxy:LuaCall( 4041, 4, "Check_Summon",			everytime );

	proxy:LuaCall( 4041, 1, "Check_AfterSummon",		everytime );
	proxy:LuaCall( 4041, 2, "Check_AfterSummon",		everytime );
	proxy:LuaCall( 4041, 3, "Check_AfterSummon",		everytime );

--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m04_02_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m04_02_00_00", everytime );
	proxy:NotNetMessage_end();
	
	proxy:AddFieldInsFilter( 828 );
	if proxy:IsCompleteEvent( 5380 ) ==false then
		proxy:OnCharacterDead(5380,828,"OnEvent_5380",once);
		--proxy:NotNetMessage_begin();
			--proxy:OnCharacterHP(5383,10000,"OnEvent_5383",0.0,once);
			--proxy:OnCharacterHP(5383,828,"OnEvent_5383_Npc",0.0,once);
		--proxy:NotNetMessage_end();
		proxy:LuaCall( 5380, 2, "OnEvent_5380", once );
		proxy:LuaCall( 5380, 3, "OnEvent_5380_Sfx",once);
	else
		proxy:InvalidSfx( 1989, false );
	end
	
	proxy:OnRegistFunc( 1080, "Condition_1080", "dummy", 2, everytime );
	
	
--[[
	--���p�j�f�[�����p (�t���O�͉��A�w�肪����Ες���)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m04_02_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m04_02_00_00);
	end
]]
--���{�X�֘A�̏���������
	if proxy:IsCompleteEvent( 5380 ) ==true then
		--���@�Ǐ�����
		proxy:SetColiEnable( 1997 , false );
		proxy:SetDrawEnable( 1997 , false );
		--���@�ǂ�SFX OFF
		proxy:InvalidSfx( 1989 , false );
		
------�A�C�e������֘A------------------
	
		--�z�X�g�v���C���[�̂݃A�C�e������C�x���g�Ɏg�p
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--���F���{�X�Ǐ���
		proxy:InvalidSfx( 2440, false );
		
		--�󎀑�(�\�E��?)�L����
		proxy:SetDrawEnable( 1980 , true );
		proxy:SetColiEnable( 1980 , true );
		--�󎀑�(�\�E��?)�L����
		proxy:SetDrawEnable( 1977 , true );
		proxy:SetColiEnable( 1977 , true );
		
		--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
		if proxy:IsCompleteEvent( 5381 ) == false then
			proxy:ValidSfx( 2400 );--SFX �L����
			proxy:ValidSfx( 2401 );--SFX �L����
			proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--���点��
			proxy:OnDistanceActionAttribute( 5381 , 10000 , 1980 , "OnEvent_5381" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--���v�΂Ń��[�v�p�̊Ď���ǉ���
			SingleReset(proxy,5382);
			--SFX ������
			proxy:InvalidSfx( 2400 , false );--�\�E���p
			--proxy:InvalidSfx( 2401 , false );--�{�X�A�C�e���p
			proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--���点��
			proxy:OnDistanceActionAttribute( 5382 , 10000 , 1980 , "OnEvent_5382" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
		
--------------------------------------
		InvalidBackRead( proxy, 828 );
		--InvalidCharactor( proxy, 829 );

	else
		if	proxy:IsClient() == false then
			proxy:SetEventFlag( 1030, false );
			proxy:SetEventFlag( 1033, false );--�{�XBGM�AHP�A�t�@���l��
			proxy:SetEventFlag( 1090, false );
			proxy:SetEventFlag( 1100, false );
			
			proxy:SetEventFlag( 1081, false );
			proxy:RequestForceUpdateNetwork(828);
			proxy:OnRegionJustIn( 5456, LOCAL_PLAYER, 2430, "OnEvent_5456", once );
		end
		
		--�ϐg�|�����O
		if proxy:IsCompleteEvent( 1030 ) == false then
			--�����{�X�Ǐ���
			proxy:InvalidSfx( 1989, false );
		else
		--�ϐg�|������
			--���F���{�X�Ǐ���
			proxy:InvalidSfx( 2440, false );
		end
		
		if	proxy:IsCompleteEvent( 1081 ) == false then
			InvalidCharactor( proxy, 828 );
		end
		
------�A�C�e������֘A------------------
		--�󎀑�(�\�E��?)
		proxy:SetDrawEnable( 1980 , false );
		proxy:SetColiEnable( 1980 , false );
		--�󎀑�(�\�E��?)2
		proxy:SetDrawEnable( 1977 , false );
		proxy:SetColiEnable( 1977 , false );
	
		--SFX ������
		proxy:InvalidSfx( 2400 , false );--�\�E���p
		proxy:InvalidSfx( 2401 , false );--�{�X�A�C�e���p
----------------------------------------
	end
	
	--��5454���{�X�����C�x���g�o�^�z�M�p
	proxy:LuaCall( 5454, 2, "DoorRegist", everytime );
	
	--��5455�����������A�y�ъ֘A�n���h���o�^
	proxy:LuaCall( 5455, 2, "ForceSummonStart", everytime );
	--���������u���b�N�S�[�X�g���L�b�N�E�ޏo�E���S�ȊO�ł��Ȃ��Ȃ���
	proxy:LuaCall( 4043, 4, "Check_LeavePlayer",	everytime );
	--���ӔC�ɑޏo
	proxy:LuaCall( 4043, 5, "Check_LeavePlayer2", 	everytime );
	
	--���������u���b�N�S�[�X�g���ޏo����
	proxy:LuaCall( 4046, 3, "Check_Leave", 			everytime );
	
	--��5457�������������ꂽ�L�������A�{�X��r������Q�������L�����ɑ΂��Ď������{�X���Ƌ�����
	proxy:LuaCall( 5457, 3, "ForceSummonInfo", everytime );
	
	--��5458�����V����\�E���̖�A�������˗p(�z�X�g���L�b�N���ĊǗ����܂�)
	proxy:CustomLuaCall( 5458, "FloatingSoulArrow", everytime );
		
	--��5459���z�X�g����SoulLv�����ē�����ʂ�t���܂���
	proxy:CustomLuaCall( 5459,"ForceSummon_Balance", everytime );
	
	proxy:NotNetMessage_begin();
		proxy:LuaCall( 5500,0,"ForceSummon_IsIn",everytime );
	proxy:NotNetMessage_end();
	
--��1030�����ϐg�|������	
	SingleReset( proxy, 1031 );
	proxy:EnableInvincible( 823, true );--��̂�͐�΂Ɏ��ȂȂ��悤�ɂ��Ă���
	if proxy:IsCompleteEvent( 1030 ) == false then
		--proxy:OnRegistFunc( 1030, "Condition_1030", "OnEvent_1030", 2, once);
		proxy:LuaCall( 1030, 2, "OnEvent_1030", everytime );
		--�|�����J�n�t�F�[�h��ɌĂ΂��n���h��
		proxy:LuaCall( 1030, REMO_START, "OnEvent_1030_RemoStart",once);
		--�|�����I����ɌĂ΂��n���h��
		proxy:LuaCall( 1030, REMO_FINISH, "OnEvent_1030_RemoFinish",once);
		
		InvalidCharactor( proxy, 828 );
		--InvalidCharactor( proxy, 829 );
	else
		if	proxy:IsCompleteEvent( 5380 ) == false then			
			DoorRegist(proxy,param);
		end
		InvalidCharactor( proxy, 823 );
	end

--��1033���{�XBGM��
	if proxy:IsCompleteEvent( 5380 ) == false then
		if proxy:IsCompleteEvent( 1033 ) == false then
			if proxy:IsClient() == false then
				proxy:NotNetMessage_begin();
					proxy:OnRegionJustIn( 1033 , 10000 , 2410 , "OnEvent_1033",onve);
				proxy:NotNetMessage_end();
			end
			--�z�X�g���������҃v���C���[�Ɍ����ē�����ʂ�z�M
			proxy:CustomLuaCall( 1033 , "OnEvent_1033_0",once );
			proxy:LuaCall( 1033 , 100 ,"OnEvent_1033_2",once );
			proxy:LuaCall( 1033 , 0 , "OnEvent_1033_1",once);
		end
	end
	
--��1051���|�����o��L������������
	InvalidCharactor( proxy, 320 );
	proxy:SetEventFlag( 1051 , true );	
	
	
--��8086���S��ɗ����t���O�𗧂Ă遡
	proxy:SetEventFlag( 8086, true );
	
	--��999999���t���[���x��̏����������C�x���g�𔭍s��
	proxy:NotNetMessage_begin();
		--��0�b�づ--
		proxy:OnKeyTime2( 999992, "Second_Initialize_m04_02_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m04_02_00_00 end");
end


--------------------------------------------------------------------------------------
--Initialize����Ă΂��A1�t���[���x��̏�����������999999
--------------------------------------------------------------------------------------
--��999999���ꕔ�AInit�ł͏����ł��Ȃ��̂ŁA�c���Ă���
function Second_Initialize_m04_02_00_00(proxy, param)
	print("Second_Initialize_m04_02_00_00 begin");

--------------------------------������QWC�C�x���g�֘A������--------------------------------
--------------------------------������QWC�C�x���g�֘A������--------------------------------

	print("Second_Initialize_m04_02_00_00 end");
end



--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m04_02_00_00(proxy, param)
	print("PlayerDeath_m04_02_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m04_02_00_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerDeath_m04_02_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m04_02_00_00(proxy,param)
	print("PlayerRevive_m04_02_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m04_02_00_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerRevive_m04_02_00_00");
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
		--�h�[�s���O����
		proxy:LuaCallStart( 1032 , 7 );					
		proxy:LuaCallStart( 1032 , 6 );--�t���O�Z�b�g(�����p)
		--���NPC�ɂ͊��ɐݒ肵�Ă���
		Lua_MultiDoping(proxy,828);--�}���`�v���C�h�[�s���O
	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�)
	if proxy:IsClient() == false then
		proxy:ResetThink( 800 );
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

--��1031���������җp�h�[�s���O������
function OnEvent_1031_Doping(proxy,param)
	print("OnEvent_1031_Doping begin");
	if proxy:GetLocalPlayerId() == ForceSummonBlack_PlayerNo then		
		Lua_MultiDopingm04_02(proxy,10001 + ForceSummonBlack_PlayerNo);		
	end
	print("OnEvent_1031_Doping end");
end

--�����A�j���Đ��ゾ�ƁA���ɑ����������Ƀv���C�̈�ID���ς��Ȃ���Ԃ�
--�����������Ă��܂��A�������������u���b�N���{�X�����ȊO��
--�~�j�u���b�N�̓�����o�Ă��邱�ƂɂȂ�̂ŁA�^�C�~���O�����炵�܂��B
function OnEvent_1032_4(proxy,param)
	print("OnEvent_1032_4 begin");
	proxy:SummonBlackRequest(4271);
	print("OnEvent_1032_4 end");
end



function ForceSummon_IsIn(proxy,param)
	print("ForceSummon_IsIn begin");
	proxy:EraseEventSpecialEffect_2( 10000 , 4006 );
	proxy:SetEventSpecialEffect_2( 10000 , 4006 );
	proxy:LuaCallStartPlus( 1065, 5, 828 );--SynchroInvalid_1065_ForBlack	
	print("ForceSummon_IsIn end");
end

----------------------------------------------------------------------------------------------------------------
--���{�X�|����
----------------------------------------------------------------------------------------------------------------
function OnEvent_1030(proxy,param)	
	if proxy:IsCompleteEvent( 1030 ) == true then
		return;
	end
	print("OnEvent_1030 begin");
	
	proxy:RequestRemo(40201, REMO_FLAG, 1030, 1 );
	proxy:SetEventFlag( 1030, true );
	
	print("OnEvent_1030 end");
end


--���|�����Đ��J�n(�t�F�[�h�I��)
function OnEvent_1030_RemoStart(proxy,param)
	print("OnEvent_1030_RemoStart begin");
	proxy:InvalidSfx( 2441, false );--�|�����Ɏז���Sfx������
	proxy:InvalidSfx( 2440, false );--���F�ǂ�����
	print("OnEvent_1030_RemoStart end");
end

--���|�����Đ��I��(�t�F�[�h�I��)
function OnEvent_1030_RemoFinish(proxy,param)
	print("OnEvent_1030_RemoFinish begin");
	proxy:ValidSfx( 2441 );--�|�����ɓs�����������������Ȃ̂�Sfx��߂�
	proxy:ValidSfx( 1989 );--���ǂ�L���ɂ���
	
--[[
	InvalidCharactor( proxy, 823 );
	ValidCharactor( proxy, 828 );
	proxy:Warp( 828, 2420 );
	ValidCharactor( proxy, 829 );
]]
	--�{�X�����C�x���g�ǉ�
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 5454, 2 );
	end
	
	--if proxy:GetLocalPlayerId() == ForceSummonBlack_PlayerNo then
	if	proxy:GetTempSummonParam() > 0 then
		print("���������u���b�N�v���C���[�ł�");
		proxy:EraseEventSpecialEffect_2( 10000 , 4006 );
		proxy:SetEventSpecialEffect_2( 10000 , 4006 );
		proxy:LuaCallStartPlus( 1065, 5, 828 );--SynchroInvalid_1065_ForBlack
	end
	
	--proxy:PlayPointSE( 2410, SOUND_TYPE_M, 40200000, 2 );
	proxy:LuaCallStartPlus( 1065, 4, 823 );--SynchroInvalid_1065
	--proxy:LuaCallStartPlus( 1065, 3, 828 );--SynchroValid_NoAnim_1065
	--proxy:LuaCallStartPlus( 1065, 2420, 828 );--SynchroWarp_1065
	--proxy:LuaCallStartPlus( 1065, 3, 829 );--SynchroValid_NoAnim_1065
	
	print("OnEvent_1030_RemoFinish end");
end





function OnEvent_5383(proxy,param)
	if proxy:GetLocalPlayerId() == ForceSummonBlack_PlayerNo then
		print("OnEvent_5383 begin");
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 5383 , "OnEvent_5383_wait",1.0,0,0,once);
		proxy:NotNetMessage_end();		
		print("OnEvent_5383 end");
	end
end

function OnEvent_5383_Npc(proxy,param)
	print("OnEvent_5383_Npc begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 5383 , "OnEvent_5383_wait",0.5,0,0,once);
	proxy:NotNetMessage_end();
	print("OnEvent_5383_Npc begin");
end

function OnEvent_5383_wait(proxy,param)
	print("OnEvent_5383_wait begin");
	--proxy:LuaCallStart( 5380, 3 );
	print("OnEvent_5383_wait end");
end

--[[------------------------------------------------------------------------------------
--��5380���{�X���S��
--------------------------------------------------------------------------------------]]
--��5380���{�X���S��
function OnEvent_5380(proxy,param)
	print("OnEvent_5380 begin");
		
	if proxy:IsClient() == false and proxy:IsCompleteEvent(5383) == false then
		proxy:LuaCallStart( 5380, 3 );
	end

	proxy:NotNetMessage_begin();
		--1�b��ɕ����ǔ����C�x���g�𔭍s--
		proxy:OnKeyTime2(5380,"OnEvent_5380_1", 1,0,0,once);
		--�}���`���U�Ď�
		proxy:OnRegistFunc( 5380 , "Check_5380_PT","OnEvent_5380_PT",0,once);
	proxy:NotNetMessage_end();

	--�t�@���l���I��
	proxy:DeleteEvent( 5458 );
	
	proxy:SetEventFlag( 5380, true );
	
	--�{�X��p��BGM��~
	proxy:StopPointSE( 2 );
	--�u���b�N�N���A������
	proxy:CustomLuaCallStart( 4050, 828 );
	
	--�g�J�Q�C�x���g���Z�b�g
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
	if proxy:IsClient() == false then	
		proxy:SetEventFlag(	8012, 1 );--�N���A�t���OON
	end
	
	print("OnEvent_5380 end");
end

--PC���E�QSFX
function OnEvent_5380_Sfx(proxy,param)
	print("OnEvent_5380_Sfx begin");
	local BossId = -1;
	if	ForceSummonBlack_PlayerNo == -1 then
		BossId = 828;
	else
		BossId = 10001 + ForceSummonBlack_PlayerNo;
	end	
	print("BossId :",BossId);
	--proxy:CreateSfx_DummyPoly( BossId, 50 , 16034 );
	proxy:CreateSfx_DummyPoly( BossId, 91 , 16034 );
	proxy:SetEventFlag( 5383 , true );
	print("OnEvent_5380_Sfx end");
end

function OnEvent_5380_1(proxy,param)
	print("OnEvent_5380_1 begin");

	--�{�X��|���������X�V(���ɂ���ăt���O�𗧂Ă�)
	GetBossFlagCount( proxy, param );

--�A�C�e������֘A-------
	
	--�z�X�g�v���C���[�̂݃A�C�e������C�x���g�Ɏg�p
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

	--�󎀑�(�\�E��?)�L����
	proxy:SetDrawEnable( 1980 , true );
	proxy:SetColiEnable( 1980 , true );
	--�󎀑�(�\�E��?)2�L����
	proxy:SetDrawEnable( 1977 , true );
	proxy:SetColiEnable( 1977 , true );
	
	--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
	if proxy:IsCompleteEvent( 5381 ) == false then
		proxy:ValidSfx( 2400 );--SFX �L����
		proxy:ValidSfx( 2401 );--SFX �L����
		proxy:TreasureDispModeChange2( 1980, true ,KANAME_SFX);--���点��
		proxy:OnDistanceActionAttribute( 5381 , 10000 , 1980, "OnEvent_5381" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end
------------------------]]
	
	--���g���t�B�[�擾���聥
	Lua_RequestUnlockTrophy(proxy, 8);	
	
	print("OnEvent_5380_1 end");
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


--�}���`���U�Ď�
function Check_5380_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--�}���`����Ȃ�
function OnEvent_5380_PT(proxy,param)
	print("OnEvent_5380_PT begin");
	
	proxy:InvalidSfx( 1989, true );
	
	--���{�X�����̖��@�ǂ�������(�S�v���C���[)	
	proxy:SetColiEnable( 1997 , false );	
	proxy:SetDrawEnable( 1997 , false );
	
	--���{�X�����O�̈ړ������C�x���g���폜
	proxy:DeleteEvent( 1031 );--��l�ڂ�����Ƃ��p
	proxy:DeleteEvent( 1032 );--��l�ڈȍ~������Ƃ��p
	print("OnEvent_5380_PT end");
end

--------------------------------------------------------------------------------------
--��5381���\�E�����聡
--------------------------------------------------------------------------------------
--��5381���\�E�����聡
function OnEvent_5381(proxy,param)
	print("OnEvent_5381 begin");
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--�V�����A�j�� 
		print("OnEvent_5381 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 5381, "OnEvent_5381_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	print("OnEvent_5381 end");
end



--��5381_1���A�C�e���擾��
function OnEvent_5381_1(proxy, param)
	print("OnEvent_5381_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10552�Q��
	proxy:GetRateItem(10552);
	--�A�C�e���擾�֐�--�p�����[�^10578�Q��
	proxy:GetRateItem(10578);
	--�A�C�e���擾�֐�--�p�����[�^10579�Q��
	proxy:GetRateItem(10579);
	--�A�C�e���擾�֐�--�p�����[�^10580�Q��
	proxy:GetRateItem(10580);
	--�A�C�e���擾�֐�--�p�����[�^10581�Q��
	proxy:GetRateItem(10581);
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 5381, 1 );
	
	--SFX��������
	proxy:InvalidSfx( 2400 , true );

	if proxy:IsCompleteEvent( 8035 ) == false then
		proxy:NotNetMessage_begin();
			--�u�Ԃŕ\������ƃ��j���[����ɏo��̂ő҂�
			proxy:OnKeyTime2( 8035 , "OnEvent_8035_wait",0.5 , 0 , 1, once);			
		proxy:NotNetMessage_end();
	else
		--���v�΂Ń��[�v�p�̊Ď���ǉ���
		proxy:OnDistanceActionAttribute( 5382 , 10000 , 1980 , "OnEvent_5382" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	end	
	
	print("OnEvent_5381_1 end");
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
		OnEvent_8050(proxy,param)
		proxy:SetEventFlag( 8035 , true );
	proxy:NotNetMessage_end();
	--���v�΂Ń��[�v�p�̊Ď���ǉ���	
	proxy:OnDistanceActionAttribute( 5382 , 10000 , 1980 , "OnEvent_5382" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	print("OnEvent_8035 end");
end


--------------------------------------------------------------------------------------
--��5382���Β��Ƀ��[�v��
--------------------------------------------------------------------------------------
function OnEvent_5382(proxy,param)
	print("OnEvent_5382 begin");
	
	proxy:RepeatMessage_begin();
		--��70_1���I�����j���[�̊Ď���
		proxy:OnSelectMenu(5382, "OnEvent_5382_1", 10010710, 0, 2, 1980, 2, once);
	proxy:RepeatMessage_end();
	
	print("OnEvent_5382 end");
end

--��5382_1���I�����j���[�̊Ď���
function OnEvent_5382_1(proxy,param)	
	print("OnEvent_5382_1 begin");
	
	if proxy:IsSession() == false then
		
		if param:IsNetMessage() == true then
			proxy:PlayAnimation(10001+param:GetPlayID(),8283);
			print("OnEvent_5382_1 end");
			return;
		end
			
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1980 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd( 5382 , 10000 , 8283 , "OnEvent_5382_2",once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(5382,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_5382_1 end");
end

--��5382_2���Β��Ƀ��[�v��
function OnEvent_5382_2(proxy,param)	
	print("OnEvent_5382_2 begin");

	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ�
	
	--�Β��֖߂��Ă�������̃t���O�𗧂Ă�
	proxy:SetEventFlag(8083, true);
	
	--���S�񕜗v��
	proxy:RequestFullRecover();
	--�Íԗv�΂ɖ߂�
	proxy:WarpNextStage( 1, 0, 0, 0, 1008);	
	print("OnEvent_5382_2 end");
end

------------------------------------------------------------------------------

function Condition_1080(proxy,param)
	if	proxy:GetBlockId() == 2 then
		if	proxy:GetPartyRestrictNum() ~= 3 then
			proxy:SetPartyRestrictNum(3);
			print("Condition_1080 set RestrictNum 3");
		end
	else
		if	proxy:GetPartyRestrictNum() ~= 4 then
			proxy:SetPartyRestrictNum(4);
			print("Condition_1080 set RestrictNum 4");
		end
	end
	return false;
end


function OnEvent_1090(proxy,param)
	print("OnEvent_1090 begin");
	proxy:NotNetMessage_begin();
		if	proxy:IsOnline() == true then
			proxy:LuaCallStartPlus( 1065, 4271, 828 );
		else
			proxy:LuaCallStartPlus( 1065, 4271, 828 );
		end
		proxy:LuaCallStartPlus( 1065, 2, 828 );--SynchroValid_1065
		proxy:SetEventFlag( 1081, true );--NPC���������ꂽ�`�F�b�N
		proxy:SetEventFlag( 1090, true );
		
		--�^�C���A�E�g�����̂ŁA�|�����̗����
		--�|�����Đ�
		proxy:LuaCallStart( 1030, 2 );
	proxy:NotNetMessage_end();
	print("OnEvent_1090 end");
end

function OnEvent_1081(proxy,param)
	print("OnEvent_1081 begin");
	proxy:SetEventFlag( 1100, true );
	print("OnEvent_1081 end");
end


--�{�X�����ɓ����Ă���A�z�X�g�ŋ��������̓x�ɌĂ΂��
function Check_Summon(proxy,param)
	print("Check_Summon begin");

	--�����������ꂽ�v���C����ID���o���Ă���
	ForceSummonBlack_PlayerNo = param:GetPlayID();
	
	--�z�M�������������u���b�N�Ȃ̂ŁA�����Ńz�X�g�Ƌ敪��
	if	proxy:IsClient() == false then
		if	proxy:IsCompleteEvent( 1090 ) == false then
			proxy:DeleteEvent( 1090 );
			proxy:SetEventFlag( 1090, true );			
			--�|�����Đ�
			--proxy:LuaCallStart( 1030, 2 );
		end
	end
	
	if proxy:GetLocalPlayerId() == ForceSummonBlack_PlayerNo then
		print("���������u���b�N�v���C���[�ł�");
		IsForceSummon = true;
		--proxy:EraseEventSpecialEffect_2( 10000 , 4005 );
		--proxy:SetEventSpecialEffect_2( 10000 , 4006 );
		--proxy:LuaCallStartPlus( 1065, 5, 828 );--SynchroInvalid_1065_ForBlack
	else		
		if proxy:IsClient() == false then
			print("���̓z�X�g�v���C���[�ł� SoulLv:",proxy:GetLocalPlayerSoulLv());
			proxy:CustomLuaCallStart( 5459 , proxy:GetLocalPlayerSoulLv() );
			--�l�b�g���[�N�̃��b�N
			--proxy:LockSession();
		end
	end
	
	--�{�X�Q�[�W�\��
	--proxy:SetBossGauge( 10001 + param:GetPlayID() , 0 ,6030 );
	
	print("Check_Summon end");
end

--�z�X�g����\�E��Lv��������ē�����ʂ�t����
function ForceSummon_Balance(proxy,param)
	--��������̂͋������҃S�[�X�g������OK�Ȕ��Ȃ̂ŁE�E�E
	if proxy:GetLocalPlayerId() == ForceSummonBlack_PlayerNo then
		print("ForceSummon_Balance begin");
		local hostSoulLv = param:GetParam2();
		local forceSoulLv = proxy:GetLocalPlayerSoulLv();
		--�ǂ�����\�E��Lv��0����Ȃ��Ȃ�
		if hostSoulLv > 0 or forceSoulLv > 0 then
			print("hostSoulLv :",hostSoulLv,"forceSoulLv :",forceSoulLv);
			local LvRate = forceSoulLv - hostSoulLv;
			if LvRate <= 5 and LvRate >= 1 then
				print("Lv�� +5�`+1");
				proxy:SetEventSpecialEffect_2( 10000 , 5045 );
			elseif LvRate <= 0 and LvRate >= -5 then
			--���x���{0�`�|5�@�@�@�@�@5046
				print("Lv�� +0�`-5");
				proxy:SetEventSpecialEffect_2( 10000 , 5046 );
			elseif LvRate <= -6 and LvRate >= -10 then
			--���x���|6�`�|10�@�@�@�@5047
				print("Lv�� -6�`-10");
				proxy:SetEventSpecialEffect_2( 10000 , 5047 );
			elseif LvRate <= -11 then
			--���x���|11�`�@�@�@�@�@�@ 5048
				print("Lv�� -11�`");
				proxy:SetEventSpecialEffect_2( 10000 , 5048 );
			else
				proxy:WARN("Lv�}�b�`���O������ł͂Ȃ��\��������܂��I");
			end
		end		
		print("ForceSummon_Balance end");
	end
end


--�{�X�����ɓ����Ă���A�z�X�g�Ńu���b�N�S�[�X�g���S�̓x�ɌĂ΂��
function Check_BlackDead(proxy,param)
	print("Check_BlackDead begin");
	--�{�X���S�C�x���g���s
	proxy:LuaCallStart( 5380, 2 );	
	print("Check_BlackDead end");
end

--�{�X�����ɓ����Ă���A�z�X�g�Ńu���b�N�S�[�X�g��������̓x�ɌĂ΂��
function Check_LeavePlayer(proxy,param)
	print("Check_LeavePlayer begin");
	--���������u���b�N�����ɂ��Ȃ����
	if	ForceSummonBlack_PlayerNo < 0 then
		print("Check_LeavePlayer return end")
		return;
	end
	if proxy:IsBlackGhost() == true then
		print("Check_LeavePlayer return end")
		return;
	end
	--�ޏo�����l�Ƌ������҃u���b�N��PlayerNo����v����
	if param:GetParam3() == ForceSummonBlack_PlayerNo then
		print("switch_npc Success!");
		switch_npc(proxy,param);
	else
		print("switch_npc Failed!");
	end
	print("Check_LeavePlayer end");
end

--�{�X�����ɓ����Ă��疳�ӔC�ޏo�����l�����邽�тɌĂ΂��
function Check_LeavePlayer2(proxy,param)
	print("Check_LeavePlayer2 begin");
	--���������u���b�N�����ɂ��Ȃ����
	if	ForceSummonBlack_PlayerNo < 0 then
		print("Check_LeavePlayer2 return end")
		return;
	end
	
	if proxy:IsBlackGhost() == true then
		print("Check_LeavePlayer return end")
		return;
	end
	
	--�ޏo�����l�Ƌ������҃u���b�N��PlayerNo����v����
	if param:GetParam3() == ForceSummonBlack_PlayerNo then
		print("switch_npc Success!");
		switch_npc(proxy,param);
	else
		print("switch_npc Failed!");
	end
	print("Check_LeavePlayer2 end");
end

--�{�X�����ɓ����Ă���A�z�X�g�Ńu���b�N�S�[�X�g�ޏo�̓x�ɌĂ΂��
function Check_Leave(proxy,param)
	print("Check_Leave begin");
	--���������u���b�N�����ɂ��Ȃ����
	if	ForceSummonBlack_PlayerNo < 0 then
		print("Check_Leave return end")
		return;
	end
	
	if proxy:IsBlackGhost() == true then
		print("Check_LeavePlayer return end")
		return;
	end
	
	switch_npc(proxy,param);
	print("Check_Leave end");
end

--PC�������Ă��������ɁA�����NPC���o�������鏈��
function switch_npc(proxy,param)
	--�܂��{�X��|���ĂȂ��̂ŁI
	if proxy:IsCompleteEvent( 5380 ) ==false then
	
		local npc_dead_list	 = {1100};--�ǉ�����NPC�u���b�N�̎��S�Ď��A�N�V����ID���X�g
		local npc_black_list = {1081};--�o�����Ă���NPC�u���b�N�̃`�F�b�N���X�g
		local npc_evid_list  = { 828};--�o������NPC�̃C�x���gID���X�g
	
		proxy:LuaCallStartPlus( 1065, 2420, 828 );
		proxy:LuaCallStartPlus( 1065, 2, 828 );--SynchroValid_1065
	
		--���������u���b�N�����Ȃ��Ȃ�̂ŏ�����
		ForceSummonBlack_PlayerNo = -1;
		
		proxy:SetBossGauge( 828 , 0 ,6030 );
		
		--�l�b�g���[�N�̃��b�N
		--proxy:LockSession();
	
		print("switch_npc index = ", index);
	end
end





function SynchroValid_1065( proxy,param)
	print("SynchroValid_1065 begin");
	local chrId = param:GetParam3();
	print( "Valid to ", chrId );
	
	--(2008.08.17 17:13 hk-itoyuta)
	--���ʂȓo�^�𑝂₵�����Ȃ������̂ň�悸�����Ő؂�ւ�
	--���������������Ȃ�1��LuaCall��؂��āA�����ł܂Ƃ߂�
	--if	chrId == 828 then
		--�{�X�Q�[�W�������Ă���
		--proxy:ClearBossGauge();
		
		--�{�X�Q�[�W�\��
		--proxy:SetBossGauge( chrId , 0 ,6030 );
	--end
	if proxy:IsBlackGhost() == false then
		ValidCharactor( proxy , chrId );--�L�����N�^�L����	
		proxy:PlayAnimation( chrId, 6100 );
	end
	print("SynchroValid_1065 end");
end

function SynchroValid_NoAnim_1065( proxy,param)
	print("SynchroValid_NoAnim_1065 begin");
	print( "Valid to ",param:GetParam3() );
	if proxy:IsBlackGhost() == false then
		ValidCharactor( proxy , param:GetParam3() );--�L�����N�^�L����	
	end
	print("SynchroValid_NoAnim_1065 end");
end

function SynchroInvalid_1065( proxy,param)
	print("SynchroInvalid_1065 begin");
	print( "Invalid to ",param:GetParam3() );
	InvalidCharactor( proxy , param:GetParam3() );--�L�����N�^������	
	print("SynchroInvalid_1065 end");
end

function SynchroInvalid_1065_ForBlack( proxy,param )
	print("SynchroInvalid_1065_ForBlack begin");
	print( "Invalid to ",param:GetParam3() );
	InvalidCharactor( proxy , param:GetParam3() );--�L�����N�^������
	--�����������ꂽ�v���C����ID���o���Ă���
	ForceSummonBlack_PlayerNo = param:GetPlayID();
	print("SynchroInvalid_1065_ForBlack end");
end

function SynchroWarp_1065(proxy,param)
	print("SynchroWarp_1065  Chr is <",param:GetParam3(),">   Warp to <", param:GetParam2(),">");
	proxy:Warp( param:GetParam3(), param:GetParam2() );
end

--�{�X�����C�x���g�o�^
--Call(5454, 2)
function DoorRegist(proxy,param)
	print("DoorRegist begin");
		--�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B
		SingleReset(proxy, 1031);
	
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���)
		proxy:LuaCall( 1032, 1, "OnEvent_1032_1", everytime );
		
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCall( 1032 , 5 , "OnEvent_1031_GO_TO_IN" , everytime );
		
		--���t���O�Z�b�g(�����p)
		proxy:LuaCall( 1032 , 6 , "OnEvent_1031_flag_set" , everytime );
		
		--���������҃h�[�s���O�p
		proxy:LuaCall( 1032 , 7 , "OnEvent_1031_Doping" , everytime );
		
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
	print("DoorRegist end");
end


--���������A�y�ъ֘A�n���h���o�^
--Call(5455, 2)
function ForceSummonStart(proxy,param)
	print("ForceSummonStart begin");
		if	proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				--�r������I�����C���ɂȂ������Ƃ��l���āA�n���h�������͓o�^���Ă���
				--���������u���b�N�S�[�X�g������
				proxy:LuaCall( 4042, 5, "Check_BlackDead",		everytime );		
				
				
				if	proxy:IsOnline() == true then
					proxy:OnKeyTime2( 1032, "OnEvent_1032_4", 2.0, 0, 4, once );
					proxy:OnKeyTime2( 1090, "OnEvent_1090", ForceSummonTimeOut, 0, 2, once );
				else
					proxy:OnKeyTime2( 1090, "OnEvent_1090",   0.0, 0, 2, once );
					--�|�����Đ�
					proxy:LuaCallStart( 1030, 2 );
				end
			proxy:NotNetMessage_end();
		end
	print("ForceSummonStart end");
end


function OnEvent_5456(proxy,param)
	print("OnEvent_5456 begin");
	--���̎��_�ŃN���C�A���g�Ȃ�@�V���O��
	if	proxy:IsClient() == false then
		--�L�����^�C�v������or�O���C�Ȃ狭�����҂��X�^�[�g
		if proxy:IsGreyGhost() == true or proxy:IsLivePlayer() == true then
			proxy:LuaCallStart( 5455, 2 );
		end
	end
	print("OnEvent_5456 end");
end

------------------------------------------------------------------------------------------------------------------
--��5457�������������ꂽ�L�������A�{�X��r������Q�������L�����ɑ΂��Ď������{�X���Ƌ�����
------------------------------------------------------------------------------------------------------------------
--LuaCallParam(5457,3,�ʒm����Ώۂ�playerNo)
function ForceSummonInfo(proxy,param)
	print("ForceSummonInfo begin");
	--�������̃��b�Z�[�W���H
	if	param:GetParam3() == proxy:GetLocalPlayerId() then
		--�{�X�Q�[�W�\��
		--proxy:SetBossGauge( 10001 + param:GetPlayID() , 0 ,6030 );
	end
	print("ForceSummonInfo end");
end


--LuaCallParam(4041,1or2or3)
function Check_AfterSummon(proxy,param)
	print("Check_AfterSummon begin");
	--�����������ꂽ�u���b�N���H
	if	proxy:GetTempSummonParam() > 0 then
		proxy:LuaCallStartPlus( 5457, 3, param:GetPlayID() );
	end
	print("Check_AfterSummon end");
end


function startFloatSoulArrow(proxy,param)
	print("startFloatSoulArrow begin");
	
	local set_param = proxy:DivideRest( param:GetParam3() + 1, 2 );
	proxy:NotNetMessage_begin();
		--��5458�����V����\�E���̖�˂��L�b�N���遡
		proxy:OnKeyTime2( 5458, "startFloatSoulArrow", GetReloadTime(proxy), 0, set_param, once );
	proxy:NotNetMessage_end();
	
	--���V����\�E���̖��
	--local cast_target = proxy:GetHostPlayerNo();
	--local cast_target = proxy:GetPlayerId_Random();
	
	--�{�X�𒲂ׂ�
	local BossId = -1;
	if	ForceSummonBlack_PlayerNo == -1 then
		BossId = 828;
	else
		BossId = 10001 + ForceSummonBlack_PlayerNo;
	end	

	--���������v���C���̏�񂪂����	
	local cast_target = proxy:GetEnemyPlayerId_Random(CHR_TYPE_BlackGhost);
	print("targetPlayerNo = ",cast_target);	
	proxy:CustomLuaCallStartPlus( 5458, BossId, 10001+cast_target );
	
	print("startFloatSoulArrow end");
end


--LuaCallparam(5458,Owner,target)
function FloatingSoulArrow(proxy,param)
	print("FloatingSoulArrow begin");
	local Owner		= param:GetParam2();
	local target	= param:GetParam3();
	local cast_magicId = -1;
	local hpRate = proxy:GetHpRate(Owner);
	print("HpRate = ",hpRate);
	if hpRate <= 0.75 then cast_magicId = 5203; end
	if hpRate <= 0.60 then cast_magicId = 5202; end
	if hpRate <= 0.45 then cast_magicId = 5201; end
	if hpRate <= 0.30 then cast_magicId = 5200; end
	if hpRate > 0.0 and cast_magicId ~= -1 then
		--proxy:CastTargetSpellPlus( Owner, Owner, -1, target, cast_magicId,1011 );
		proxy:CastTargetSpellPlus( Owner, Owner, 38, target, cast_magicId,1011 );
	end
	print("FloatingSoulArrow end");
end


FloatingSoulArrow_Reload_Low	=  7.0;
FloatingSoulArrow_Reload_High	= 11.0;
--[[------------------------------------------------------------------------------------
--�������[�h���Ԏ擾�n���h����
--�萔�Ŏw�肵�Ă���ő�l�E�ŏ��l�ԂŃ����_���̏������v�Z���Ԃ��B
--------------------------------------------------------------------------------------]]
--�������[�h���Ԏ擾�n���h��
function GetReloadTime(proxy)
	--�����_���̏������擾����ׁA1000�ł������芄�����肵�Ă܂��B
	local Low  = FloatingSoulArrow_Reload_Low * 1000;
	local High = FloatingSoulArrow_Reload_High * 1000;
	local rand = proxy:GetRandom( Low, High ) / 1000;
	print("Reload", rand);
	return rand;
end


------------------------------------------------------------------------------------------------------------------
--��1033���{�XBGM�Đ�
------------------------------------------------------------------------------------------------------------------
function OnEvent_1033(proxy,param)
	print("OnEvent_1033 begin");
	if proxy:IsClient() == false then
		proxy:CustomLuaCallStart( 1033 , ForceSummonBlack_PlayerNo ); 
	end	
	print("OnEvent_1033 end");
end

function OnEvent_1033_0(proxy,param)
	print("OnEvent_1033_0 begin");	
	if proxy:IsBlackGhost() == true then
		proxy:LuaCallStart( 1033 , 100 );
		proxy:EraseEventSpecialEffect_2( 10000 , 4006 );
		proxy:SetEventSpecialEffect_2( 10000 , 4006 );		
	end
	proxy:LuaCallStart( 1033 , 0);
	print("OnEvent_1033_0 end");
end

function OnEvent_1033_2(proxy,param)
	print("OnEvent_1033_2 begin");
	local player = param:GetPlayID();
	print("player = ",player);	
	--�܂��o����ĂȂ��āA-1�ȊO�̒l��������L��
	ForceSummonBlack_PlayerNo = player;	
	if ForceSummonBlack_PlayerNo ~= -1 then
		print("������ʂ�ݒ�!�@ForceSummonBlack_PlayerNo = ",ForceSummonBlack_PlayerNo);
		--������ʂ�ݒ�		
		--proxy:EraseEventSpecialEffect_2( 10000 , 4005 );
		--proxy:SetEventSpecialEffect_2( ForceSummonBlack_PlayerNo+10001 , 4006 );	
	end	
	print("OnEvent_1033_2 end");
end

function OnEvent_1033_1(proxy,param)
	if proxy:IsCompleteEvent( 1033 ) == false then	
		print("OnEvent_1033_1 begin");
		--BGM�Đ�
		proxy:PlayPointSE( 2410, SOUND_TYPE_M, 40200000, 2 );
		--��5458�����V����\�E���̖�˂��L�b�N���遡
		if	proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 5458, "startFloatSoulArrow", 2.0, 0, 2, once );
			proxy:NotNetMessage_end();
		end
		
		if	ForceSummonBlack_PlayerNo == -1 then		
			--�{�X�Q�[�W�\��
			proxy:SetBossGauge( 828 , 0 ,6030 );			
		else
			proxy:SetBossGauge( 10001 + ForceSummonBlack_PlayerNo , 0 ,6030 );
		end
		
		print("OnEvent_1033_1 end");
	end
end
