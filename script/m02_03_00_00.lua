
--�򗳂̒��̍U���҂�����(0�ɐݒ肷���0�Ŋ��������܂����鏈�������������Ȃ��Đ��l������̂ŁA�K��0.01�ȏ��top�ɓ���Ă���Ă��������B)
HiryuOsa_AttackDelay_under	= 0.00;--�򗳂̒��̍U���̑҂����Ԃ̉���
HiryuOsa_AttackDelay_top	= 0.01;--�򗳂̒��̍U���̑҂����Ԃ̏��

HiryuOsa_b4_evid			= 501;--����4�̔򗳂̒��̃C�x���gID

ElevatorTimer = 10.0;
--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉����������
--------------------------------------------------------------------------------------
function Initialize_m02_03_00_00(proxy)
	print("Initialize_m02_03_00_00 begin");
	
--��1560���򗳂̒��A�o����
	if proxy:IsCompleteEvent( 1560 ) == false then
		proxy:OnRegionJustIn( 1560 , LOCAL_PLAYER , 2600 , "OnEvent_1560" , everytime );
		
		proxy:NotNetMessage_begin();
			--�|�����J�n�t�F�[�h��ɌĂ΂��n���h��
			proxy:LuaCall(1560,REMO_START,"OnEvent_1560_RemoStart",once);
			--�|�����I����ɌĂ΂��n���h��
			proxy:LuaCall(1560,REMO_FINISH,"OnEvent_1560_RemoFinish",once);
			proxy:Warp(  HiryuOsa_b4_evid , 2700 );
		proxy:NotNetMessage_end();
	else
		--���o�p(?)��OBJ��L����/����������
		proxy:SetDrawEnable( 1720 , true );
		proxy:SetColiEnable( 1720 , true );		
		proxy:SetDrawEnable( 1721 , true );
		proxy:SetColiEnable( 1721 , true );		
		proxy:SetDrawEnable( 1710 , false );
		proxy:SetColiEnable( 1710 , false );		
		proxy:SetDrawEnable( 1711 , false );
		proxy:SetColiEnable( 1711 , false );		
		proxy:SetDrawEnable( 1700 , false );
		proxy:SetColiEnable( 1700 , false );		
		proxy:SetDrawEnable( 1701 , false );
		proxy:SetColiEnable( 1701 , false );
	end


--��1570���{�X�����ɓ��遡			
	--BossRoomIn( proxy, 4480, 1570, 1571, 2892 );--[[�O���[�o���̂��R�����g�A�E�g����Ă���]]

	--���{�X�������Ă���Ƃ������C�x���g�o�^
	if proxy:IsCompleteEvent( 4480 ) == false then
	
		--�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B
		SingleReset(proxy, 1570);		
	
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���)
		proxy:LuaCall( 1571, 1, "OnEvent_1571_1", everytime );
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCall( 1571 , 5 , "OnEvent_1570_GO_TO_IN" , everytime );
		--���t���O�Z�b�g(�����p)
		proxy:LuaCall( 1571 , 6 , "OnEvent_1570_flag_set" , everytime );
		
		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ�
		if proxy:IsCompleteEvent( 1570 ) == false then
		
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l����
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--��1570�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegionAttribute( 1570, 2892, "OnEvent_1570", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
		
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B
		
			proxy:NotNetMessage_begin();
				--��1571�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegion( 1571, 2892, "OnEvent_1570", HELPID_GO_TO_IN, everytime );--�n���h���͏�Ɠ���
			proxy:NotNetMessage_end();
		
		end
	end
	

--��1540���{�X�̃|�����Đ���

	if proxy:IsCompleteEvent( 1540 ) == false and proxy:IsCompleteEvent( 1545 ) == false then 
	
		--���{�X�O�̃|�����Đ��p�Ď��ǉ�
		proxy:OnRegionJustIn( 1540 , LOCAL_PLAYER , 2896 , "OnEvent_1540" , once );
		
		proxy:NotNetMessage_begin();
--[[
		--���򗳂̒��������Ă����ꍇ��
			--�|�����J�n�ɌĂ΂��n���h��
			proxy:LuaCall(1540, REMO_START, "OnEvent_1540_RemoStart", once);
			--�|�����I����ɌĂ΂��n���h��(�g���K�[�N�������l�p)
			proxy:LuaCall(1540, REMO_FINISH, "OnEvent_1540_RemoFinish", once);
]]

		--���򗳂̒�������ł����ꍇ��
			--�|�����J�n�ɌĂ΂��n���h��
			proxy:LuaCall(1545, REMO_START, "OnEvent_1545_RemoStart", once);
			--�|�����I����ɌĂ΂��n���h��(�g���K�[�N�������l�p)
			proxy:LuaCall(1545, REMO_FINISH, "OnEvent_1545_RemoFinish", once);
		proxy:NotNetMessage_end();
	else
		proxy:SetEventFlag( 4490 , true );
	end


--��1572���{�X������������	
	if proxy:IsCompleteEvent( 4480 ) == false then
		proxy:OnRegionJustIn( 1572 , LOCAL_PLAYER , 2884 , "OnEvent_1572" , everytime );
	end
	

--��4480���{�X���S��	
	proxy:AddFieldInsFilter( 821 );
	if proxy:IsCompleteEvent( 4480 ) ==false then
		proxy:NotNetMessage_begin();
			proxy:OnCharacterDead(4480, 821, "OnEvent_4480", once);
		proxy:NotNetMessage_end();
	end

------------- ���򗳌n�� -----------------------------------------------

--��1620���̈�Ď���
	proxy:OnNetRegion(1620 , 2610);	
--��1621���̈�Ď���
	proxy:OnNetRegion(1621 , 2620);	
--��1622���̈�Ď���
	proxy:OnNetRegion(1622 , 2630);	
--��1623���̈�Ď���
	proxy:OnNetRegion(1623 , 2640);
--��1624���̈�Ď���
	proxy:OnNetRegion(1624 , 2641);
--��1625���̈�Ď���
	proxy:OnNetRegion(1625 , 2642);
--��1626���̈�Ď���
	proxy:OnNetRegion(1626 , 2643);
--��1651���̈�Ď���
	proxy:OnNetRegion(1651 , 2710);
	
--��1590���򗳂̒����x�����Ă��遡
	--Second_Initialize�Œǉ�(��ԃt���O���Z�b�g������)
	
--��1591���򗳂̒����̈�A���u���X�U�������遡
--��1592���򗳂̒����̈�B���u���X�U�������遡
--��1593���򗳂̒����̈�C���u���X�U�������遡
--��1594���򗳂̒����L��ɑ΂��ău���X�U�������遡
--��1599���򗳂̒����Q�[�g�O�Ōx�����Ă��遡


--��1597���򗳂̒����Q�[�g�O�ɔ��ł�����
--��1598���򗳂̒����ʘH�O�ɔ��ł�����

--��1600���򗳂̒������̊Ԃɔ��ł����i�ʘH�O����j��
--��1601���򗳂̒������̊Ԃɔ��ł����i�Q�[�g�O����j��
--��1602���򗳂̒������̊Ԃ��x�����Ă��遡
--��1603���򗳂̒������̊ԂɃu���X�U�������遡
--��1604���򗳂̒����A���̊Ԃ���P�ނ��遡
	
	if	proxy:IsCompleteEvent( TYO_STATE_DEAD ) == false then
	--��1670���򗳂̒���Hp��75���ȉ���
		SingleReset( proxy, 1670 );
		if	proxy:IsCompleteEvent( 1670 ) == false then
			proxy:OnCharacterHP( 1670, HiryuOsa_b4_evid, "OnEvent_1670", 0.75, once );
		end
		
	--��1671���򗳂̒���Hp��50���ȉ���
		SingleReset( proxy, 1671 );
		if	proxy:IsCompleteEvent( 1671 ) == false then
			proxy:OnCharacterHP( 1671, HiryuOsa_b4_evid, "OnEvent_1671", 0.50, once );
		end
			
		--���򗳃A�j���̓����Đ��p��
		proxy:LuaCall( 1590 , 1 , "OnEvent_1590"   				, everytime );--�A�j���Ǘ�
		proxy:LuaCall( 1590 , 2 , "OnEvent_1590_syncroInvalid"	, everytime );--����������
		
		proxy:LuaCall( 1590 , 3 , "OnEvent_1590_3"				, everytime );--�ʘH�ҋ@
		
		proxy:LuaCall( 1590 ,10 , "Osa_ForceSynchroAnime" 			, everytime );--�����A�j���p
		
		proxy:LuaCall( 1591 , 1 , "OnEvent_1591_1"				, everytime );--�u���XA
		proxy:LuaCall( 1591 , 2 , "OnEvent_1591_2"				, everytime );--�u���XA
		proxy:LuaCall( 1592 , 1 , "OnEvent_1592_1"				, everytime );--�u���XB
		proxy:LuaCall( 1592 , 2 , "OnEvent_1592_2"				, everytime );--�u���XB
		proxy:LuaCall( 1593 , 1 , "OnEvent_1593_1"				, everytime );--�u���XC
		proxy:LuaCall( 1593 , 2 , "OnEvent_1593_2"				, everytime );--�u���XC
		
		proxy:LuaCall( 1594 , 1 , "OnEvent_1594_1"				, everytime );--�L��u���XA
		proxy:LuaCall( 1594 , 2 , "OnEvent_1594_2"				, everytime );--�L��u���XA
		proxy:LuaCall( 1660 , 1 , "OnEvent_1660_1"				, everytime );--�L��u���XB
		proxy:LuaCall( 1660 , 2 , "OnEvent_1660_2"				, everytime );--�L��u���XB
		proxy:LuaCall( 1661 , 1 , "OnEvent_1661_1"				, everytime );--�L��u���XC
		proxy:LuaCall( 1661 , 2 , "OnEvent_1661_2"				, everytime );--�L��u���XC
		
		proxy:LuaCall( 1662 , 1 , "OnEvent_1662_1"				, everytime );--�L��ҋ@
		
		proxy:LuaCall( 1596 , 1 , "OnEvent_1596_1"				, everytime );--�Q�[�g���S
		proxy:LuaCall( 1597 , 1 , "OnEvent_1597_1"				, everytime );--�Q�[�g�ֈړ�
		proxy:LuaCall( 1598 , 1 , "OnEvent_1598_1"				, everytime );--�ʘH�ֈړ�
		
		proxy:LuaCall( 1595 , 1 , "OnEvent_1595_1"				, everytime );--�ʘH�Ŏ��S
	end
	
	
	

----------- ���򗳌n�� ---------------------------------------------------------


--��1635���G���x�[�^�����遡
--��1636���G���x�[�^���~��遡
--(Second_Initialize�ŊĎ��ǉ�)



--��4500���N���C�A���gPC���[�v���o��
	--(�{�X���S:OnEvent_4480 ����A��)

--��4502���V���O���F���̕ǁABGM������
	--(�{�X���S:OnEvent_4480 ����A��)

--��4503���\�E�����聡
	--(�{�X���S:OnEvent_4480 ����A��)

--��4504���{�X�A�C�e�����菈����
	--(�{�X���S:OnEvent_4480 ����A��)

--��4505���Β��Ƀ��[�v��
	--(�\�E������:OnEvent_4503 ����A��)



--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m02_03_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m02_03_00_00", everytime );
	proxy:NotNetMessage_end();
	


--��1635,1636���G���x�[�^�֘A��������
--�G���x�[�^�M�~�b�N�F�A�N�V����ID����
--1630		�G���x�[�^�̏㉺��ԊǗ�(false:��	true:��)
--1631		�G���x�[�^�̃A�j��������p
--1635		�G���x�[�^�̔����̈�Ď�
--1636		�G���x�[�^����ɂ���Ƃ��ɒN���G���x�[�^���ɂ��Ȃ��Ȃ������A���ɍ~�낷����p
	proxy:SetIsAnimPauseOnRemoPlayForEvent(1620,true);
	proxy:OnNetRegion( 1636, 2651 );
	--�z�X�g�̏ꍇ�͕K��������Ԃ�����(�����A�{�X��Ŕs��ď�ɂ���܂܂��Ɛi�s�s�\�Ȉ�)
	if	proxy:IsClient() == false then
		proxy:SetEventFlag( 1630, false );
		proxy:SetEventFlag( 1631, false );
		proxy:PlayLoopAnimation( 1620 , 0 );
	--�N���C�A���g�̏ꍇ�͏㉺�̏�Ԃ����č��킹��
	else
		--�G���x�[�^�㉺�̏�Ԃ��z�X�g�̐��E�ɂ��킹��
		if	proxy:IsCompleteEvent( 1630 ) == true then
			proxy:EndAnimation( 1620, 1 );
		else
			proxy:EndAnimation( 1620, 0 );
		end
	end
	
	proxy:OnPlayerActionInRegion( 1635 , 2650 , "OnEvent_1635" , HELPID_START , everytime );--����p
	--[[
	proxy:NotNetMessage_begin();
		proxy:OnRegionJustOut( 1635, LOCAL_PLAYER, 2651, "OnEvent_1635_Out", everytime );
	proxy:NotNetMessage_end();
	]]
	proxy:LuaCall(1635, 2, "OnEvent_1635_flag", everytime);--�㉺�t���O����
	proxy:LuaCall(1635, 3, "OnEvent_1635", everytime );--���쓯��
	proxy:LuaCall(1635, 4, "OnEvent_1635_animeflag",everytime);--�A�j��������
	
	proxy:LuaCall(1635, 5, "OnEvent_1635_UpAnime",everytime);
	proxy:LuaCall(1635, 6, "OnEvent_1635_DownAnime",everytime);
	


	--proxy:SetEventFlag( 1630 , true ); --�G���x�[�^�����ɂ���t���OON
	--proxy:SetEventFlag( 1631 , false );--�G���x�[�^����ɂ���t���OOFF

	--proxy:OnDistanceActionPlus( 1635 , LOCAL_PLAYER, 1620, "OnEvent_1635" , 1, HELPID_START , 0, 100, 0.0, 0.0, 0.0, everytime );--����p
--	proxy:OnPlayerActionInRegion( 1636 , 2651 , "OnEvent_1636" , HELPID_START , everytime );--�~���p

	
--��1780���G�������Ă��遡
	if	proxy:IsCompleteEvent( 1780 ) == false then
		proxy:OnRegionJustIn( 1780, LOCAL_PLAYER, 2656, "OnEvent_1780", once );
		proxy:OnSimpleDamage( 1780, 512, -1, "OnEvent_1780", once );
		proxy:EnableLogic( 512, false );
		proxy:Warp( 512, 2655 );
	end
	
--���{�X�֘A�̏���������
	if proxy:IsCompleteEvent( 4480 ) ==true then
		
		--���{�X����ł���Ƃ�
		--�{�X���Ȃ��Ȃ�
		InvalidBackRead( proxy , 821 );
		
		--���@�Ǐ�����(���̃}�b�v�͖��@�ǈ��)
		proxy:SetColiEnable( 1996 , false );
		proxy:SetDrawEnable( 1996 , false );	

		--���@�ǂ�SFX OFF
		proxy:InvalidSfx( 1988 , true );
		
	else
	    --���{�X�����Ă���Ƃ�		
		proxy:EnableLogic( 821 , false );--���W�b�NOFF�őҋ@		
	end		

	--�����h�����̎��񂾌�A�v�΂Ń{�C�X�Đ�
	proxy:RegistSimpleTalk( 4510 , 1979 , 28000, TALK_ATTR_ALL );

--��4503,4505���\�E������A�v�΂Ń��[�v��
	if proxy:IsCompleteEvent( 4480 ) ==true then--�{�X������ł���Ƃ�
		
		proxy:TreasureDispModeChange2( 1979 , true ,KANAME_SFX);--���点��
		--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
		if proxy:IsCompleteEvent( 4503 ) == false then
			proxy:ValidSfx( 1640 );--SFX �L����
			proxy:ValidSfx( 1641 );--���̗��q			
			proxy:OnDistanceActionAttribute( 4503 , LOCAL_PLAYER , 1979 , "OnEvent_4503" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );

			--�\�E���L����
			proxy:SetDrawEnable( 1979 , true );
			proxy:SetColiEnable( 1979 , true );
			--�\�E��2�L����
			proxy:SetDrawEnable( 1978 , true );
			proxy:SetColiEnable( 1978 , true );

		else
			--���v�΂Ń��[�v�p�̊Ď���ǉ���
			proxy:InvalidSfx( 1640, false );--SFX ������
			--proxy:InvalidSfx( 1641, false );--���̗��q
			SingleReset( proxy , 4505);
			proxy:OnDistanceActionAttribute( 4505 , LOCAL_PLAYER , 1979 , "OnEvent_4505" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end

	else
		--�\�E��������
		proxy:SetDrawEnable( 1979 , false );
		proxy:SetColiEnable( 1979 , false );
		--�\�E��2������
		proxy:SetDrawEnable( 1978 , false );
		proxy:SetColiEnable( 1978 , false );
		--SFX ������
		proxy:InvalidSfx( 1640 , false );
		proxy:InvalidSfx( 1641 , false );
	end
	
	


--����(��)�C�x���g�֘A������
	if	proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork(HiryuOsa_b4_evid);
	end
	

--��8084������ɗ����t���O�𗧂Ă遡
	proxy:SetEventFlag(8084, true);
	
	--��1706�����̈�i���ŉ��q�����ʁ�
	RegistEvent_1706(proxy);
	
	--��1640�������h�����q�E�u���b�N���S��
	RegistEvent_1640(proxy);
	
	--�����g�J�Q�C�x���g
	RegistTokage(proxy,1680,257,4);
	RegistTokage(proxy,1682,258,5);
	RegistTokage(proxy,1684,259,6);	
	
--��1690���O�e�m1�����񂾁�
	if proxy:IsCompleteEvent( 1690 ) == false then
		proxy:OnCharacterDead( 1690 , 530 , "OnEvent_1690",once);
	else
		InvalidBackRead( proxy,530 );
	end
--��1691���O�e�m2�����񂾁�
	if proxy:IsCompleteEvent( 1691 ) == false then
		proxy:OnCharacterDead( 1691 , 531 , "OnEvent_1691",once);
	else
		InvalidBackRead( proxy, 531 );
	end
--��1692���O�e�m3�����񂾁�
	if proxy:IsCompleteEvent( 1692 ) == false then
		proxy:OnCharacterDead( 1692 , 532 , "OnEvent_1692",once);
	else
		InvalidBackRead( proxy, 532 );
	end


--------------------------------������QWC�C�x���g�֘A������--------------------------------
--------------------------------������QWC�C�x���g�֘A������--------------------------------
	--��999999���t���[���x��̏����������C�x���g�𔭍s��
	proxy:NotNetMessage_begin();
		--��0�b�づ--
		proxy:OnKeyTime2( 999993, "Second_Initialize_m02_03_00_00", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();	


	--��15500�������A�C�e���擾�Ď����n���h���̓O���[�o���ɒ�`
	--if proxy:IsCompleteEvent( 15500 ) == false then
	--	proxy:AddCorpseEvent( 15500 , 530 );--�O�e�mA
	--	proxy:AddCorpseEvent( 15500 , 531 );--�O�e�mB
	--	proxy:AddCorpseEvent( 15500 , 532 );--�O�e�mC
	--end
	
	print("Initialize_m02_03_00_00 end");
end

function Second_Initialize_m02_03_00_00(proxy,param)
	print("Second_Initialize_m02_03_00_00 begin");
--------------------------------������QWC�C�x���g�֘A������--------------------------------
--------------------------------������QWC�C�x���g�֘A������--------------------------------
	print("Second_Initialize_m02_03_00_00 end");
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
function PlayerDeath_m02_03_00_00(proxy, param)
	print("PlayerDeath_m02_03_00_00");
	print("PlayerDeath_m02_03_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m02_03_00_00(proxy,param)
	print("PlayerRevive_m02_03_00_00");
	print("PlayerRevive_m02_03_00_00");
end




--------------------------------------------------------------------------------------
--��1560���򗳂̒��A�o����
--------------------------------------------------------------------------------------

function OnEvent_1560(proxy , param)
	print("OnEvent_1560 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 1560 ) == true then
		print("OnEvent_1560 end");
		return;
	end
	
	--���݂̏�Ԏ擾
	local now_state = GetNpcStateFlag(proxy ,param, tyo_flag_list);
	
	--�򗳂̏�Ԃ��x��(�ʘH)�̂Ƃ�
	if now_state == TYO_STATE_WARNING_AISLE then 
		
		--�|�����Đ�
		proxy:RequestRemo(20300,REMO_FLAG,1560,1);
		proxy:SetEventFlag( 1560 , 1 );--�t���O�Z�b�g
	end
	
	print("OnEvent_1560 end");
end


--���|�����Đ��J�n(�t�F�[�h�I��)
function OnEvent_1560_RemoStart(proxy,param)
	print("OnEvent_1560_RemoStart begin");
	
	--���̃^�C�~���O�ŗL��������I�u�W�F
	proxy:SetDrawEnable( 1710 , true );
	proxy:SetColiEnable( 1710 , true );
	
	proxy:SetDrawEnable( 1711 , true );
	proxy:SetColiEnable( 1711 , true );
	ValidCharactor( proxy , HiryuOsa_b4_evid );--�򗳗L����
	
	print("OnEvent_1560_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��)
function OnEvent_1560_RemoFinish(proxy , param)
	print("OnEvent_1560_RemoFinish begin");
	
	proxy:DeleteEvent( 1560 );--everytime�Ȃ̂ŏ���
	
	proxy:Warp(  HiryuOsa_b4_evid , 2700 );	
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, 7001 );

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
	
	proxy:SetDrawEnable( 1710 , false );
	proxy:SetColiEnable( 1710 , false );
	
	proxy:SetDrawEnable( 1711 , false );
	proxy:SetColiEnable( 1711 , false );
	
	proxy:SetDrawEnable( 1700 , false );
	proxy:SetColiEnable( 1700 , false );
	
	proxy:SetDrawEnable( 1701 , false );
	proxy:SetColiEnable( 1701 , false );	

	print("OnEvent_1560_RemoFinish end");
end




--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ��遡1570
--------------------------------------------------------------------------------------

--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫

--��1570�����{�X�����ւ̔����J����
function OnEvent_1570(proxy,param)
	print("OnEvent_1570 begin");
	
	--�G���x�[�^�A�j���Đ����͓���Ȃ��悤�ɂ͂���
	if proxy:IsCompleteEvent( 1631 ) == true then
		print("OnEvent_1570 return end");
		return;
	end

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_1570 end");
		return;
	end
	
	--�N���C�A���g�ցA�{�X�����j�~���s��ʒm
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 1571 , 1 );--����A�j���̓����Đ�
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE , 1 );--���d�����h�~�p
	--���d�N���V�X�e��ID���^�C���A�E�g��ݒ肵��ON�ɂ���
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1570 end");
end


--����A�j���̓����Đ�(ID����)
function OnEvent_1571_1(proxy,param)
	print("OnEvent_1571_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ����s���A���̏I������OnEvent_1571_2�𔭍s����
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2888 );
		else
			proxy:LockSession();--���[�������b�N���܂��I
			--����A�j���Đ����s���A���̏I������OnEvent_1571_2�𔭍s����
			proxy:OnTurnCharactorEnd( 1571, LOCAL_PLAYER, 2888, "OnEvent_1571_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1571_1 end");
end

--����A�j���̓����Đ��I����
function OnEvent_1571_2(proxy,param)
	print("OnEvent_1571_2 begin");
	
	--�����p�����A�j���Đ�
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1571, LOCAL_PLAYER, ANIMEID_WALK, "OnEvent_1571_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
		
	print("OnEvent_1571_2 end");
end

--�����A�j���̓����Đ��I����
function OnEvent_1571_3(proxy,param)
	print("OnEvent_1571_3 begin");

	--�ŏ��̐l���{�X�����̒��ɓ���I����Ă�����A���ɔz�M����Ă���͂��Ȃ̂ŁA����������Ȃ��n���h��
	if proxy:IsCompleteEvent( 1570 ) == false then
		proxy:LuaCallStart( 1571 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCallStart( 4045 , 1 );	--�N���C�A���g�ցA�{�X�����ɓ����悤�ɂȂ������Ƃ�ʒm
		proxy:LuaCallStart( 1571 , 6 );--�t���O�Z�b�g(�����p)
		Lua_MultiDoping(proxy,821);--�}���`�v���C�h�[�s���O
	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�)
	if proxy:IsClient() == false then
		proxy:ResetThink( 821 );
	end
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE , 0 );--���d�����h�~�p	
	
	print("OnEvent_1571_3 end");
end


--��1570 2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
function OnEvent_1570_GO_TO_IN(proxy, param)
	print("OnEvent_1570_GO_TO_IN begin");
		
	proxy:NotNetMessage_begin();
		--��1571�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���--�n���h���� OnEvent_1570
		proxy:OnPlayerActionInRegion( 1571, 2892, "OnEvent_1570", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	
	print("OnEvent_1570_GO_TO_IN end");
end


--��1570 �t���O�Z�b�g(�����p)
function OnEvent_1570_flag_set(proxy, param)
	print("OnEvent_1570_flag_set begin");
		
	proxy:SetEventFlag( 1570 , 1 );
	proxy:DeleteEvent( 1570 );

	print("OnEvent_1570_flag_set end");
end



--------------------------------------------------------------------------------------
--���{�X�|�����Đ���1540
--------------------------------------------------------------------------------------

function OnEvent_1540(proxy, param)
	print("OnEvent_1540 begin");
--[[	

	--���݂̏�Ԏ擾
	local now_tyo_state = GetNpcStateFlag( proxy , param , tyo_flag_list );
	if now_tyo_state == TYO_STATE_DEAD then
		--�|�����Đ��J�n
		proxy:RequestRemo(20302,REMO_FLAG,1545,1);
	else
		--�|�����Đ��J�n
		proxy:RequestRemo(20301,REMO_FLAG,1540,1);
	end
]]
	proxy:RequestRemo(20302,REMO_FLAG,1545,1);
	proxy:SetEventFlag( 1545 , 1 );--�|�����Đ��I��
	print("OnEvent_1540 end");
end

--[[
--��1540_RemoStart���|�����J�n �t�F�[�h�A�E�g������
function OnEvent_1540_RemoStart(proxy,param)
	print( "OnEvent_1540_RemoStart begin" );
	
	proxy:SetDrawEnable( 821 , false );
	
	print( "OnEvent_1540_RemoStart end" );
end


--��1540_RemoFinish���|�����Đ��I���ち
function OnEvent_1540_RemoFinish(proxy , param)
	print( "OnEvent_1540_RemoFinish begin" );

	proxy:SetDrawEnable( 821 , true );
	proxy:SetEventFlag( 1540 , 1 );--�|�����Đ��I��

	print( "OnEvent_1540_RemoFinish end" );
end
]]

--��1545_RemoStart���|�����J�n �t�F�[�h�A�E�g������
function OnEvent_1545_RemoStart(proxy,param)
	print( "OnEvent_1545_RemoStart begin" );
	
	proxy:SetDrawEnable( 821 , false );
	
	print( "OnEvent_1545_RemoStart end" );
end


--��1545_RemoFinish���|�����Đ��I���ち
function OnEvent_1545_RemoFinish(proxy , param)
	print( "OnEvent_1545_RemoFinish begin" );

	proxy:SetDrawEnable( 821 , true );
	proxy:SetEventFlag( 4490 , true );

	print( "OnEvent_1545_RemoFinish end" );
end

--[[
--------------------------------------------------------------------------------------
--���{�X�|����2�Đ���1545
--------------------------------------------------------------------------------------

function OnEvent_1545(proxy, param)
	print("OnEvent_1545 begin");

	--�|�����Đ��J�n
	proxy:RequestRemo(20302,REMO_FLAG,1545,1);
	
	print("OnEvent_1545 end");
end


--��1540_RemoStart���|�����J�n �t�F�[�h�A�E�g������
function OnEvent_1545_RemoStart(proxy,param)
	print( "OnEvent_1545_RemoStart begin" );
	
	proxy:SetDrawEnable( 821 , false );
	
	print( "OnEvent_1545_RemoStart end" );
end


--��1540_RemoFinish���|�����Đ��I���ち
function OnEvent_1545_RemoFinish(proxy , param)
	print( "OnEvent_1545_RemoFinish begin" );

	proxy:SetDrawEnable( 821 , true );
	proxy:SetEventFlag( 1545 , 1 );--�|�����Đ��I��

	print( "OnEvent_1545_RemoFinish end" );
end
]]


--------------------------------------------------------------------------------------
--�{�X�������o��(�퓬�J�n)��1572
--------------------------------------------------------------------------------------

function OnEvent_1572(proxy, param)
	if proxy:IsCompleteEvent( 4490 ) == false then
		return;
	end
	print("OnEvent_1572 begin");
	
	--�{�X��pBGM�Đ��J�n
	proxy:PlayPointSE( 2660, SOUND_TYPE_M, 20300000, 3 );
	
	--�{�X���W�b�NON
	proxy:EnableLogic( 821 , true );
	
	--�ǂݍ��݃^�C�~���O�̂Ƃ�����ǉ�����Ăق����̂Ńt���O���ĂȂ�
	
	--�{�X�Q�[�W�\��
	proxy:SetBossGauge( 821 , 0 ,6010 );
	
	--�Ď��폜
	proxy:DeleteEvent( 1572 );
	
	print("OnEvent_1572 end");
end




--------------------------------------------------------------------------------------
--��4480�����{�X���S��
--------------------------------------------------------------------------------------

--��4480�����{�X���S��
function OnEvent_4480(proxy, param)
	print("OnEvent_4480 begin");

	proxy:NotNetMessage_begin();
		--��4500���N���C�A���gPC���[�v���o��
		proxy:OnKeyTime2( 4500, "OnEvent_4500", 0, 0, 0, once);	
		--��4481��1�b�o�߁�
		proxy:OnKeyTime2( 4481, "OnEvent_4481", 1, 0, 1, once);
		--��4502��2�b�o�߁�
		proxy:OnKeyTime2( 4502, "OnEvent_4502", 2, 0, 2, once);	
		--�}���`���U�Ď�
		proxy:OnRegistFunc( 4480 , "Check_4480_PT","OnEvent_4480_PT",0,once);
	proxy:NotNetMessage_end();
	
	--PC�ɕt����������ʂ𖳌���
	if proxy:EraseEventSpecialEffect_2(LOCAL_PLAYER, 5007) == true then
		print("����5030�̃G�t�F�N�g����������");
	else
		print("5030�̃G�t�F�N�g���������s");
	end
	if proxy:EraseEventSpecialEffect_2(LOCAL_PLAYER, 5008) == true then
		print("����5031�̃G�t�F�N�g����������");
	else	
		print("5031�̃G�t�F�N�g���������s");
	end
	if proxy:EraseEventSpecialEffect_2(LOCAL_PLAYER, 5009) == true then
		print("����5032�̃G�t�F�N�g����������");
	else	
		print("5032�̃G�t�F�N�g���������s");
	end
	
	--proxy:EraseEventSpecialEffect(LOCAL_PLAYER, 5030);
	--proxy:EraseEventSpecialEffect(LOCAL_PLAYER, 5031);
	--proxy:EraseEventSpecialEffect(LOCAL_PLAYER, 5032);
	
	--�u���b�N�N���A������
	proxy:CustomLuaCallStart( 4050, 821 );	
	--�����g�J�Q���Z�b�g
	ResetTokage(proxy);
	
	proxy:SetEventFlag( 4480, 1 );--�{�X���S�t���OON
	
	--�����h�����S�ɘA�����ă����h�����q���������Ȃ���Ԃ�
	--[[
	if	proxy:IsCompleteEvent( RENDOL_STATE_LIFT_FRONT ) == true then
		SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_ERASE );
			InvalidCharactor( proxy, 626 );
	end
	]]

	--�r�������O����(�����h������|�������ɁA�򗳂̒��Ɛ���Ă�����������Ȃ���Ԃ�)
	if proxy:IsCompleteEvent( BIYO_STATE_BATTLE_FLY_DRAGON ) == true then
		SetNpcStateFlag( proxy , param , biyo_flag_list , BIYO_STATE_EXIT );
		proxy:SetEventFlag( 1710, true );
	end	
	
	print("OnEvent_4480 end");
end

--��4481�����{�X���S��1�b��
function OnEvent_4481(proxy, param)
	print("OnEvent_4481 begin");
	
	--�{�X��|���������X�V(���ɂ���ăt���O�𗧂Ă�)
	GetBossFlagCount( proxy, param );
	
	--���g���t�B�[�擾���聥
	Lua_RequestUnlockTrophy(proxy, 6);
	
	--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
	if proxy:IsCompleteEvent( 4503 ) == false then
	
		--�\�E���L����
		proxy:SetDrawEnable( 1979 , true );
		proxy:SetColiEnable( 1979 , true );
		--�\�E��2�L����
		proxy:SetDrawEnable( 1978 , true );
		proxy:SetColiEnable( 1978 , true );

		proxy:ValidSfx( 1640 );--SFX �L����
		proxy:ValidSfx( 1641 );--SFX �L����
		proxy:TreasureDispModeChange2( 1979 , true ,KANAME_SFX);--���点��
		proxy:OnDistanceActionAttribute( 4503 , LOCAL_PLAYER , 1979 , "OnEvent_4503" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );
	else
		--�\�E��������(������������̂ť��)
		proxy:SetDrawEnable( 1979 , false );
		proxy:SetColiEnable( 1979 , false );
	end

	--����N���A�t���OON
	if proxy:IsClient() == false then
		proxy:SetEventFlag( 8010 , 1 );
	end

	print("OnEvent_4481 end");
end



--------------------------------------------------------------------------------------
--��4500���N���C�A���gPC���[�v���o��
--------------------------------------------------------------------------------------

--��4500���N���C�A���gPC���[�v���o��
function OnEvent_4500(proxy, param)
	print("OnEvent_4500 begin");

	if proxy:IsClient() == true then
		proxy:PlayAnimation( LOCAL_PLAYER , 8284 );--���[�v�A�j�����Đ�
	end

	proxy:SetEventFlag( 4500 , 1 );
	
	print("OnEvent_4500 end");
end



--------------------------------------------------------------------------------------
--��4502���V���O���F���̕ǁABGM������
--------------------------------------------------------------------------------------

--��4502���V���O���F���̕ǁABGM������
function OnEvent_4502(proxy, param)
	print("OnEvent_4502 begin");
	
	--�{�X��p��BGM��~
	proxy:StopPointSE( 3 );	

	proxy:SetEventFlag( 4502 , 1 );
	
	print("OnEvent_4502 end");
end

--�}���`���U�Ď�
function Check_4480_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--�}���`����Ȃ�
function OnEvent_4480_PT(proxy,param)
	print("OnEvent_4480_PT beign");
	--���{�X�����̑O��̖��@�ǂ�������(�S�v���C���[�A���̃}�b�v�͖��@�ǂ����)
	proxy:SetColiEnable( 1996 , false );	
	proxy:SetDrawEnable( 1996 , false );
	
	--proxy:SetObjDeactivate( 1996 , true );--�f�A�N�e�B�u
	
	--���{�X�������@�ǂ�SFX�폜(�{�X����ID�Ƃ͕�)
	proxy:InvalidSfx( 1988 , true );
	
	--���{�X�����O�̈ړ������C�x���g���폜
	proxy:DeleteEvent( 1570 );--��l�ڂ�����Ƃ��p
	proxy:DeleteEvent( 1571 );--��l�ڈȍ~������Ƃ��p
	proxy:DeleteEvent( 1540 );--�|�����Đ��p
	proxy:DeleteEvent( 1572 );--�{�X�퓬�J�n�p	
	print("OnEvent_4480_PT end");
end


--------------------------------------------------------------------------------------
--��1590���򗳂̒����x�����Ă��遡
--------------------------------------------------------------------------------------

--��(��)���Đ�����A�j��ID
tyo_play_anime_id = -1;--�ŏ��̓A�j�����Đ����Ă��Ȃ��̂�-1

--��1590���򗳂̒����x�����Ă��遡
function OnEvent_1590(proxy, param)
	print("OnEvent_1590 begin");
	
	
	--[[���݂̏�Ԏ擾]]
	local now_state = GetNpcStateFlag( proxy, param, tyo_flag_list );
	
	--[[����S�ɒN�����Ȃ�]]
	if	proxy:IsCompleteEvent( 1651 )	==	false and	--2710
		proxy:IsCompleteEvent( 1670 )	==	false then	--HP75%�ȏ�
		SetNpcStateFlag(proxy, param, tyo_flag_list, TYO_STATE_WARNING_AISLE );
		--��OnEvent_1590_3
		proxy:LuaCallStart( 1590 , 3 );
	--[[��Ԃ��A�u�ʘH���x���v]]
	elseif	proxy:IsCompleteEvent( TYO_STATE_WARNING_AISLE ) == true then
			
		--[[�ʘH�O�Ŏ��S]] --[[���S�D��]]
		if proxy:IsCompleteEvent( 1770 ) == true then--���S�p��HP�Ď��t���O��ON
		   
			--��OnEvent_1595_1
			proxy:LuaCallStart( 1595 , 1 );--�ʘH�Ŏ��S�A�j���̓����Đ�

		--[[�Q�[�g�O�Ɉړ�]]
		elseif
		   proxy:IsCompleteEvent( 1623 ) == true or		--2640
		   proxy:IsCompleteEvent( 1671 ) == true then	--Hp50���ȉ�
			
			print("��(��)�A�Q�[�g�O�Ɉړ��J�n");
			--��OnEvent_1597_1
			proxy:LuaCallStart( 1597 , 1 );
			
		--[[�ҋ@(�ʘH)]]
		elseif
		   proxy:IsCompleteEvent( 1620 ) == false and	--2610
		   proxy:IsCompleteEvent( 1621 ) == false and	--2620
		   proxy:IsCompleteEvent( 1622 ) == false and	--2630
		   proxy:IsCompleteEvent( 1623 ) == false then	--2640
		   
			print("�ҋ@(�ʘH)");
			--��OnEvent_1590_3
			proxy:LuaCallStart( 1590 , 3 );
		
		--[[�̈�A�u���X]]
		elseif
		   proxy:IsCompleteEvent( 1620 ) == true  and  --2610
		   proxy:IsCompleteEvent( 1621 ) == false and  --2620
		   proxy:IsCompleteEvent( 1622 ) == false and  --2630
		   proxy:IsCompleteEvent( 1623 ) == false then --2640
			
			
			--[[�U���̑O�ɒʘH�őҋ@������]]
			--��OnEvent_1591_1
			proxy:LuaCallStart( 1591 , 1 );
		
		--[[�̈�B�u���X]]
		elseif
		   proxy:IsCompleteEvent( 1621 ) == true  and  --2620
		   proxy:IsCompleteEvent( 1622 ) == false and  --2630
		   proxy:IsCompleteEvent( 1623 ) == false then --2640
			
			print("�̈�B�u���X");
			--[[�U���̑O�ɒʘH�őҋ@������]]
			--��OnEvent_1592_1
			proxy:LuaCallStart( 1592 , 1 );

		--[[�̈�C�u���X]]
		elseif
		   proxy:IsCompleteEvent( 1622 ) == true  and  --2630
		   proxy:IsCompleteEvent( 1623 ) == false then --2640
			
			print("�̈�C�u���X");
			--[[�U���̑O�ɒʘH�őҋ@������]]
			--��OnEvent_1593_1
			proxy:LuaCallStart( 1593 , 1 );
		
		end
	--[[��Ԃ��A�u�Q�[�g���x���v]]
	elseif	proxy:IsCompleteEvent( TYO_STATE_WARNING_GATE ) == true then
			
		--[[�Q�[�g�O�Ŏ��S]] --[[���S�D��]]
		if proxy:IsCompleteEvent( 1770 ) == true then--���S�p��HP�Ď��t���O��ON

			--��OnEvent_1596_1
			proxy:LuaCallStart( 1596 , 1  );
		   
		--[[�L��A�u���X]]
		elseif 
		  (proxy:IsCompleteEvent( 1624 ) == true	and		--2641
		   proxy:IsCompleteEvent( 1625 ) == false	and		--2642
		   proxy:IsCompleteEvent( 1626 ) == false	) or	--2643
		  (proxy:IsCompleteEvent( TYO_STATE_WARNING_GATE ) 			== true	 and 	--�򗳂̒����u�Q�[�g�O���x���v
		   proxy:IsCompleteEvent( BIYO_STATE_BATTLE_FLY_DRAGON )	== true) then	--�r�����u�򗳂Ɛ키�v
			print("�L��A�u���X");
			--��OnEvent_1594_1
			proxy:LuaCallStart( 1594 , 1 );
			
		--[[�L��B�u���X]]
		elseif 
		   proxy:IsCompleteEvent( 1625 ) == true	and		--2642
		   proxy:IsCompleteEvent( 1626 ) == false	and		--2643
		   proxy:IsCompleteEvent( BIYO_STATE_BATTLE_FLY_DRAGON ) == false	then	--�r�����u�򗳂Ɛ키�v�ł͂Ȃ�
		   
			print("�L��B�u���X");
			--��OnEvent_1660_1
			proxy:LuaCallStart( 1660 , 1 );
		--[[�L��C�u���X]]
		elseif 
		   proxy:IsCompleteEvent( 1626 ) == true	and		--2643
		   proxy:IsCompleteEvent( BIYO_STATE_BATTLE_FLY_DRAGON ) == false	then	--�r�����u�򗳂Ɛ키�v�ł͂Ȃ�
		   
			print("�L��C�u���X");
			--��OnEvent_1661_1
			proxy:LuaCallStart( 1661 , 1 );
		--[[�ʘH�O�ɔ��ł���]]
		elseif
		    proxy:IsCompleteEvent( 1623 )	==	false	and		--2640
		  ( proxy:IsCompleteEvent( 1620 )	==	true	or		--2610
		    proxy:IsCompleteEvent( 1621 )	==	true	or		--2620
		    proxy:IsCompleteEvent( 1622 )	==	true )	and		--2630
			proxy:IsCompleteEvent( 1670 )	==	false 	then	--Hp75%�ȏ�

			print("��(��)�A�ʘH�O�Ɉړ��J�n");
			--��OnEvent_1598_1
			proxy:LuaCallStart( 1598 , 1 );
		
		--[[�ҋ@(�Q�[�g)]]
		elseif
		   proxy:IsCompleteEvent( 1624 ) == false and		--2641
		   proxy:IsCompleteEvent( 1625 ) == false and		--2642
		   proxy:IsCompleteEvent( 1626 ) == false then		--2643

			print("�ҋ@(�Q�[�g)");
			--��OnEvent_1662_1
			proxy:LuaCallStart( 1662 , 1 );
			
		end

	--[[��Ԃ��A�u���S�v]]
	elseif	proxy:IsCompleteEvent( TYO_STATE_DEAD ) == true then
		print("OnEvent_1590 Dead end")
	
		--(�Ď��폜?)
	end
	
	print("OnEvent_1590 end");
end

--��1590_anime_end���A�j���̏I���̂ӂ��ɕK���ʂ遣
function OnEvent_1590_anime_end(proxy, param)
	print("OnEvent_1590_anime_end begin");
	
	proxy:NotNetMessage_begin();
		--���򗳂̒����x�����Ă��遥
		proxy:OnKeyTime2( 1590 , "OnEvent_1590" , 0.0 , 0 , 1 , once );
	proxy:NotNetMessage_end();

	print("OnEvent_1590_anime_end end");
end


--LuaCallParam(1662,1)
function OnEvent_1662_1(proxy,param)
	print("OnEvent_1662_1 begin");
	tyo_play_anime_id = 7007;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--�ʘH���̗̈�Ƀ��[�v
	--proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1662_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1661, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1662_1 end");
end

--�b���ŏI���������A�A�j���̎ڂŏI���������̔�����������蕪���邽�߁A�t���O�Ōォ�痈�����͏R��悤�ɂ���
Osa_WaitAnim_EndFlag_A = 0;
Osa_IsWaitAnimCondition_A = 0;
--LuaCallParam(1590,3)
function OnEvent_1590_3(proxy,param)
	print("OnEvent_1590_3 begin");
	
	proxy:Warp( HiryuOsa_b4_evid , 2700 );
	
	--���ɑҋ@�A�j����������㏑�����Ȃ�
	print("tyo_play_anime_id = ", tyo_play_anime_id);
	
	if	tyo_play_anime_id ~= 7001 then
		tyo_play_anime_id = 7001;
		proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	end
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1590_3 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1661, "OnEvnet_1590_4", 1.0, 0, 2, once );
		if	Osa_IsWaitAnimCondition_A ~= 1 then
			proxy:OnChrAnimEnd( 1661, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvnet_1590_5", once );
			Osa_IsWaitAnimCondition_A = 1;
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	Osa_WaitAnim_EndFlag_A = 0;
	
	print("OnEvent_1590_3 end");
end


--�b���o�߂Ŕ���𔲂��鎞
function OnEvnet_1590_4(proxy,param)
	print("OnEvnet_1590_4 begin");
	if	Osa_WaitAnim_EndFlag_A == 0 then
		Osa_WaitAnim_EndFlag_A = 1;
		OnEvent_1590_anime_end(proxy,param);
	end
	print("OnEvnet_1590_4 end");
end

--�A�j���I���Ŕ���𔲂��鎞
function OnEvnet_1590_5(proxy,param)
	print("OnEvnet_1590_5 begin");
	if	Osa_WaitAnim_EndFlag_A == 0 then
		Osa_WaitAnim_EndFlag_A = 2;
		proxy:LuaCallStartPlus( 1590, 10, tyo_play_anime_id );
		OnEvent_1590_anime_end(proxy,param);
	end
	Osa_IsWaitAnimCondition_A = 0;
	print("OnEvnet_1590_5 end");
end




------------------------------------------------------------------------------------------------------
--��1591���̈�A���u���X
------------------------------------------------------------------------------------------------------
--LuaCallParam(1591,1)
function OnEvent_1591_1(proxy,param)
	print("OnEvent_1591_1 begin");
	tyo_play_anime_id = 7001;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--�ʘH���̗̈�Ƀ��[�v
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1591 return end");
		return;
	end
--[[	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1591, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1591_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
]]	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1591, "OnEvent_1591_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_1591_1 end");
end


function OnEvent_1591_1_1(proxy,param)
	print("OnEvent_1591_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1591, "OnEvent_1591_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1591_1_1 end");
end

function OnEvent_1591_1_2(proxy,param)
	print("OnEvent_1591_1_2 begin");
	
	--OnEvent_1591_2
	proxy:LuaCallStart(1591,2);
	
	print("OnEvent_1591_1_2 end");
end


--LuaCallParam(1591,1)
function OnEvent_1591_2(proxy,param)
	print("OnEvent_1591_2 begin");
	tyo_play_anime_id = 7002;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--�ʘH���̗̈�Ƀ��[�v
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1591_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1591, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1591_2 end");
end




------------------------------------------------------------------------------------------------------
--��1592���̈�B���u���X
------------------------------------------------------------------------------------------------------
--LuaCallParam(1592,1)
function OnEvent_1592_1(proxy,param)
	print("OnEvent_1592_1 begin");
	tyo_play_anime_id = 7001;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--�ʘH���̗̈�Ƀ��[�v
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1592 return end");
		return;
	end
--[[	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1592, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1592_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
]]	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1592, "OnEvent_1592_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_1592_1 end");
end


function OnEvent_1592_1_1(proxy,param)
	print("OnEvent_1592_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1592, "OnEvent_1592_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1592_1_1 end");
end

function OnEvent_1592_1_2(proxy,param)
	print("OnEvent_1592_1_2 begin");
	
	--OnEvent_1592_2
	proxy:LuaCallStart(1592,2);
	
	print("OnEvent_1592_1_2 end");
end


--LuaCallParam(1592,1)
function OnEvent_1592_2(proxy,param)
	print("OnEvent_1592_2 begin");
	tyo_play_anime_id = 7003;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--�ʘH���̗̈�Ƀ��[�v
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1592_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1592, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1592_2 end");
end





------------------------------------------------------------------------------------------------------
--��1593���̈�C���u���X
------------------------------------------------------------------------------------------------------
--LuaCallParam(1593,1)
function OnEvent_1593_1(proxy,param)
	print("OnEvent_1593_1 begin");
	tyo_play_anime_id = 7001;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--�ʘH���̗̈�Ƀ��[�v
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1593 return end");
		return;
	end
	--[[
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1593, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1593_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	]]
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1593, "OnEvent_1593_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1593_1 end");
end


function OnEvent_1593_1_1(proxy,param)
	print("OnEvent_1593_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1593, "OnEvent_1593_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1593_1_1 end");
end

function OnEvent_1593_1_2(proxy,param)
	print("OnEvent_1593_1_2 begin");
	
	--OnEvent_1593_2
	proxy:LuaCallStart(1593,2);
	
	print("OnEvent_1593_1_2 end");
end


--LuaCallParam(1593,1)
function OnEvent_1593_2(proxy,param)
	print("OnEvent_1593_2 begin");
	tyo_play_anime_id = 7004;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--�ʘH���̗̈�Ƀ��[�v
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1593_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1593, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1593_2 end");
end



------------------------------------------------------------------------------------------------------
--��1594���L��A�Ƀu���X
------------------------------------------------------------------------------------------------------
--LuaCallParam(1594,1)
function OnEvent_1594_1(proxy,param)
	print("OnEvent_1594_1 begin");
	tyo_play_anime_id = 7007;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--�ʘH���̗̈�Ƀ��[�v
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1594 return end");
		return;
	end
--[[	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1594, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1594_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
]]	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1594, "OnEvent_1594_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_1594_1 end");
end


function OnEvent_1594_1_1(proxy,param)
	print("OnEvent_1594_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1594, "OnEvent_1594_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1594_1_1 end");
end

function OnEvent_1594_1_2(proxy,param)
	print("OnEvent_1594_1_2 begin");
	
	--OnEvent_1594_2
	proxy:LuaCallStart(1594,2);
	
	print("OnEvent_1594_1_2 end");
end


--LuaCallParam(1594,2)
function OnEvent_1594_2(proxy,param)
	print("OnEvent_1594_2 begin");
	tyo_play_anime_id = 7005;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--�ʘH���̗̈�Ƀ��[�v
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1594_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1594, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1594_2 end");
end



------------------------------------------------------------------------------------------------------
--��1660���L��B�Ƀu���X
------------------------------------------------------------------------------------------------------
--LuaCallParam(1660,1)
function OnEvent_1660_1(proxy,param)
	print("OnEvent_1660_1 begin");
	tyo_play_anime_id = 7007;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--�ʘH���̗̈�Ƀ��[�v
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1660 return end");
		return;
	end
--[[	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1660, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1660_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
]]	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1660, "OnEvent_1660_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_1660_1 end");
end


function OnEvent_1660_1_1(proxy,param)
	print("OnEvent_1660_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1660, "OnEvent_1660_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1660_1_1 end");
end

function OnEvent_1660_1_2(proxy,param)
	print("OnEvent_1660_1_2 begin");
	
	--OnEvent_1660_2
	proxy:LuaCallStart(1660,2);
	
	print("OnEvent_1660_1_2 end");
end


--LuaCallParam(1660,2)
function OnEvent_1660_2(proxy,param)
	print("OnEvent_1660_2 begin");
	tyo_play_anime_id = 7017;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--�ʘH���̗̈�Ƀ��[�v
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1660_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1660, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1660_2 end");
end





------------------------------------------------------------------------------------------------------
--��1661���L��C�Ƀu���X
------------------------------------------------------------------------------------------------------
--LuaCallParam(1661,1)
function OnEvent_1661_1(proxy,param)
	print("OnEvent_1661_1 begin");
	tyo_play_anime_id = 7007;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--�ʘH���̗̈�Ƀ��[�v
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1661 return end");
		return;
	end
--[[	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1661, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1661_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
]]	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1661, "OnEvent_1661_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1661_1 end");
end


function OnEvent_1661_1_1(proxy,param)
	print("OnEvent_1661_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1661, "OnEvent_1661_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1661_1_1 end");
end

function OnEvent_1661_1_2(proxy,param)
	print("OnEvent_1661_1_2 begin");
	
	--OnEvent_1661_2
	proxy:LuaCallStart(1661,2);
	
	print("OnEvent_1661_1_2 end");
end


--LuaCallParam(1661,2)
function OnEvent_1661_2(proxy,param)
	print("OnEvent_1661_2 begin");
	tyo_play_anime_id = 7019;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--�ʘH���̗̈�Ƀ��[�v
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1661_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1661, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1661_2 end");
end




------------------------------------------------------------------------------------------------------
--��1662���L��x�����[�v
------------------------------------------------------------------------------------------------------
Osa_WaitAnim_EndFlag_B = 0;
Osa_IsWaitAnimCondition_B = 0;
--LuaCallParam(1662,1)
function OnEvent_1662_1(proxy,param)
	print("OnEvent_1662_1 begin");
	--proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--�ʘH���̗̈�Ƀ��[�v
	if	tyo_play_anime_id ~= 7007 then
		tyo_play_anime_id = 7007;
		proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	end
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1662_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1661, "OnEvent_1662_2", 1.0, 0, 2, once );
		if	Osa_IsWaitAnimCondition_B ~= 1 then
			proxy:OnChrAnimEnd( 1661, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1662_3", once );
			Osa_IsWaitAnimCondition_B = 1;
		end
		Osa_WaitAnim_EndFlag_B = 0;
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1662_1 end");
end

--�b���o�߂Ŕ���𔲂��鎞
function OnEvent_1662_2(proxy,param)
	print("OnEvent_1662_2 begin");
	if	Osa_WaitAnim_EndFlag_B == 0 then
		Osa_WaitAnim_EndFlag_B = 1;
		OnEvent_1590_anime_end(proxy,param);
	end
	print("OnEvent_1662_2 end");
end

--�A�j���I���Ŕ���𔲂��鎞
function OnEvent_1662_3(proxy,param)
	print("OnEvent_1662_3 begin");
	if	Osa_WaitAnim_EndFlag_B == 0 then
		Osa_WaitAnim_EndFlag_B = 2;
		proxy:LuaCallStartPlus( 1590, 10, tyo_play_anime_id );
		OnEvent_1590_anime_end(proxy,param);
	end
	Osa_IsWaitAnimCondition_B = 0;
	print("OnEvent_1662_3 end");
end










------------------------------------------------------------------------------------------------------
--��1595���򗳂̒�������(�ʘH��)
------------------------------------------------------------------------------------------------------
--LuaCallParam(1595,1)
function OnEvent_1595_1(proxy,param)
	print("OnEvent_1595_1 begin");
	tyo_play_anime_id = 7006;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--�ʘH���̗̈�Ƀ��[�v
	proxy:ForcePlayAnimation( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1595_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1595, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1595_2", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	
	print("OnEvent_1595_1 end");
end


function OnEvent_1595_2(proxy,param)
	print("OnEvent_1595_2 begin");
	
	SetNpcStateFlag(proxy, param, tyo_flag_list, TYO_STATE_DEAD );
	
	--�򗳂̒��������Ǝ���ł�����A�g���t�B�[�A�����b�N
	if	proxy:IsCompleteEvent( 1770 ) == true then
		HiryuOsaDead(proxy,param);
	end
	
	--OnEvent_1590_syncroInvalid
	proxy:LuaCallStartPlus( 1590, 2, HiryuOsa_b4_evid );
	
	print("OnEvent_1595_2 end");
end



------------------------------------------------------------------------------------------------------
--��1596���򗳂̒�������(�Q�[�g�O��)
------------------------------------------------------------------------------------------------------
--LuaCallParam(1596,1)
function OnEvent_1596_1(proxy,param)
	print("OnEvent_1596_1 begin");
	tyo_play_anime_id = 7010;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--�ʘH���̗̈�Ƀ��[�v
	proxy:ForcePlayAnimation( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1596, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1596_2", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1596_1 end");
end


function OnEvent_1596_2(proxy,param)
	print("OnEvent_1596_2 begin");
	
	--�򗳂̒��������Ǝ���ł�����A�g���t�B�[�A�����b�N
	if	proxy:IsCompleteEvent( 1770 ) == true then
		HiryuOsaDead(proxy,param);
	end
	
	--OnEvent_1590_syncroInvalid
	proxy:LuaCallStartPlus( 1590, 2, HiryuOsa_b4_evid );
	
	print("OnEvent_1596_2 end");
end











------------------------------------------------------------------------------------------------------
--��1597���򗳂̒����ړ�(�ʘH���Q�[�g�O)
------------------------------------------------------------------------------------------------------
--LuaCallParam(1597,1)
function OnEvent_1597_1(proxy,param)
	print("OnEvent_1597_1 begin");
	tyo_play_anime_id = 7008;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--�ʘH���̗̈�Ƀ��[�v
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	SetNpcStateFlag(proxy, param, tyo_flag_list, TYO_STATE_WARNING_GATE );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1597_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1597, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1597_1 end");
end


------------------------------------------------------------------------------------------------------
--��1598���򗳂̒����ړ�(�Q�[�g�O���ʘH)
------------------------------------------------------------------------------------------------------
--LuaCallParam(1598,1)
function OnEvent_1598_1(proxy,param)
	print("OnEvent_1598_1 begin");
	tyo_play_anime_id = 7009;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--�ʘH���̗̈�Ƀ��[�v
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	SetNpcStateFlag(proxy, param, tyo_flag_list, TYO_STATE_WARNING_AISLE );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1598_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1598, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1598_1 end");
end



--LuaCallParam(1590,2)
function OnEvent_1590_syncroInvalid(proxy,param)
	print("OnEvent_1590_syncroInvalid begin");
	
	local evid = param:GetParam3()
	InvalidCharactor( proxy, evid );
	
	print("OnEvent_1590_syncroInvalid end");
end



function Osa_ForceSynchroAnime(proxy,param)
	print("Osa_ForceSynchroAnime begin");
	local animId = param:GetParam3();
	tyo_play_anime_id = animId;
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	print("Osa_ForceSynchroAnime end");
end


--------------------------------------------------------------------------------------
--��1770���򗳂̒������ʁ�
--------------------------------------------------------------------------------------

--��1770���򗳂̒������ʁ�(HP�Ď�)
function OnEvent_1770(proxy, param)
	print("OnEvent_1770 begin");

	proxy:SetEventFlag( 1770 , 1 );--HP�Ď��t���OON
	
	print("OnEvent_1770 end");
end



--------------------------------------------------------------------------------------
--��1635���G���x�[�^�����遡
--------------------------------------------------------------------------------------

--��1635���G���x�[�^�����遡
function OnEvent_1635(proxy, param)
	print("OnEvent_1635 begin");

	--�A�j���Đ����͔������Ȃ�
	if	proxy:IsCompleteEvent( 1631 ) == true then
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
		print("OnEvent_1635 return end");
		return;
	end	
	
	ElevatorEvent(proxy,param);	
	
	print("OnEvent_1635 end");
end

function OnEvent_1633(proxy,param)
	print("OnEvent_1633")
	--�A�j���Đ����͔������Ȃ�
	if	proxy:IsCompleteEvent( 1631 ) == true then
--~ 		--�����҂����C���t�H
--~ 		if param:IsNetMessage() == false then
--~ 			--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\��
--~ 			--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010170, 1);
--~ 			--proxy:ShowGenDialog(10010170,1,1,true);
--~ 			proxy:RepeatMessage_begin();
--~ 			proxy:NotNetMessage_begin();
--~ 				proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010170, 0, 6, -1, GEN_DIALOG_DIST, once );
--~ 			proxy:NotNetMessage_end();
--~ 			proxy:RepeatMessage_end();
--~ 		end		
		print("OnEvent_1633 return end");
		return;
	end	
	
	ElevatorEvent(proxy,param);
	print("OnEvent_1633 end")
end

function ElevatorEvent(proxy,param)
	proxy:DeleteEvent( 1633 );
	--��ɂ����ԂȂ�~��A���ɂ����ԂȂ珸��A�j���Đ�
	if proxy:IsClient() == false then
		if	proxy:IsCompleteEvent( 1630 ) == false then
			proxy:LuaCallStart( 1635 , 5 );
			--proxy:ForcePlayAnimation( 1620 , 1 );--�G���x�[�^������A�j���Đ�
		else
			proxy:LuaCallStart( 1635 , 6 );
			--proxy:ForcePlayAnimation( 1620 , 2 );--�G���x�[�^���~���A�j���Đ�
			proxy:DeleteEvent(1632);
		end
	end
	
	--�v���C���̃A�j���͖���
	
	local evId_list   = {1650,1651,1652,1653,1654,1655,1660,1661,1662};
	local animId_list = {	2,	 2,	  2,   2,   2,   2,   0,   0,   0};
	local obj_num = table.getn(evId_list);
	for index = 1, obj_num, 1 do
		proxy:PlayAnimation( evId_list[index], animId_list[index] );
	end

	--�����҂������A�j���I�����Ď�(�K���N���C�A���g�̐��E�ŃG���x�[�^�I�u�W�F�N�g���ǂݍ��܂�Ă���킯�ł͂Ȃ��̂�)
	if	proxy:IsClient() == false then
		proxy:NotNetMessage_begin();
			proxy:RepeatMessage_begin();
				if	proxy:IsCompleteEvent( 1630 ) == false then
					--��1635���G���x�[�^������A�j���I����
					proxy:OnCharacterAnimEnd( 1635 , 1620 , 1 , "OnEvent_1635_anime_end" , once );
					proxy:LuaCallStart( 1635, 2 );--���̎��_�ŏ㉺�͊m��
				else
					--��1635���G���x�[�^���~���A�j���I����
					proxy:OnCharacterAnimEnd( 1635 , 1620 , 2 , "OnEvent_1635_anime_end" , once );
					proxy:LuaCallStart( 1635, 2 );--���̎��_�ŏ㉺�͊m��
				end
			proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
end

--��1635_anime_end���G���x�[�^������A�j���I����
function OnEvent_1635_anime_end(proxy, param)
	print("OnEvent_1635_anime_end begin");
	
	--���G���x�[�^���~���Ď��ǉ���
	--proxy:OnPlayerActionInRegion( 1636 , 2651 , "OnEvent_1636" , HELPID_START , everytime );
	--proxy:OnDistanceActionPlus( 1636 , LOCAL_PLAYER, 1620, "OnEvent_1635" , 1, HELPID_START , 0, 100, 0.0, 0.0, 0.0, everytime );--����p
	
	
	--�t���O�������A�[�R�[��()--�A�j���I���t���O����
	proxy:LuaCallStart( 1635, 4 );
	
	if proxy:IsCompleteEvent( 1630 ) == true then
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnKeyTime2( 1632 , "OnEvent_1632",0.5,0,1,once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	
	print("OnEvent_1635_anime_end end");
end

function OnEvent_1635_flag(proxy,param)
	print("OnEvent_1635_flag begin");
	
	if	proxy:IsCompleteEvent( 1630 ) == true then
		proxy:SetEventFlag( 1630, false );
	else
		proxy:SetEventFlag( 1630, true );
	end	
	print("OnEvent_1635_flag end");
end

function OnEvent_1635_animeflag(proxy,param)
	print("OnEvent_1635_animeflag begin");
	--�A�j�����t���OOFF
	proxy:SetEventFlag( 1631 , false );
	print("OnEvent_1635_animeflag end");
end
 
--[[
function OnEvent_1635_Out(proxy,param)
	print("OnEvent_1635_Out begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1635, "OnEvent_1635_Out_1", 0.0, 0, 2, once );
	proxy:NotNetMessage_end();
	print("OnEvent_1635_Out end");
end

--���̏u�Ԃ���OnNetRegion�̃t���O�ݒ肪�L���ɂȂ�Ȃ��̂ŁA1�t���[���x�点��
function OnEvent_1635_Out_1(proxy,param)
	print("OnEvent_1635_Out_1 begin");
	--�S�����G���x�[�^�̈悩�炢�Ȃ��Ȃ��Ă�����G���x�[�^�𓮂���
	if	proxy:IsCompleteEvent( 1636 ) == false then
		--�G���x�[�^����ɂ����Ԃ���Ȃ��Ɣ��������Ȃ�(�K�v�Ȃ�����)
		if	proxy:IsCompleteEvent( 1630 ) == true then
			--��OnEvent_1635
			proxy:LuaCallStart( 1635, 3 );
		end
	end
	print("OnEvent_1635_Out_1 end");
end
]]


--��ɏオ�肫�������̊Ď�
function OnEvent_1632( proxy,param)
	print("OnEvent_1632 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnRegistFunc( 1632 , "Check_1632_1","OnEvent_1632_1",1,once);
		
		--�̈�ɂ����Ƌ��Ă���莞�Ԃō~���悤��
		proxy:OnKeyTime2( 1633 , "OnEvent_1633",ElevatorTimer,0,100,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_1632 end");
end

--�̈�ɒN�����Ȃ����H
function Check_1632_1(proxy,param)
	if proxy:IsCompleteEvent( 1636 ) == true then
		return false;
	end
	return true;
end

--�̈�ɒN�����Ȃ��̂ŃG���x�[�^�[�����낷
function OnEvent_1632_1(proxy,param)
	print("OnEvent_1632_1 begin");
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 1635, 3 );
	end
	print("OnEvent_1632_1 end");
end

function OnEvent_1635_UpAnime(proxy,param)
	if proxy:IsCompleteEvent( 1631 ) == false then
		proxy:ForcePlayAnimation( 1620 , 1 );--�G���x�[�^������A�j���Đ�
		--�A�j�����t���OON
		proxy:SetEventFlag( 1631 , true );
	end
end

function OnEvent_1635_DownAnime(proxy,param)
	if proxy:IsCompleteEvent( 1631 ) == false then
		proxy:ForcePlayAnimation( 1620 , 2 );--�G���x�[�^���~���A�j���Đ�
		--�A�j�����t���OON
		proxy:SetEventFlag( 1631 , true );
	end
end

--[[
--------------------------------------------------------------------------------------
--��1636���G���x�[�^���~��遡
--------------------------------------------------------------------------------------

--��1636���G���x�[�^���~��遡
function OnEvent_1636(proxy, param)
	print("OnEvent_1636 begin");
		
	--�G���x�[�^����ɂ���Ƃ���������
	if proxy:IsCompleteEvent( 1631 ) == true then
	
		proxy:PlayAnimation( 1620 , 2 );--�G���x�[�^���~���A�j���Đ�
	
		local evId_list   = {1650,1651,1652,1653,1654,1655,1660,1661,1662};
		local animId_list = {	2,	 2,	  2,   2,   2,   2,   0,   0,   0};
		local obj_num = table.getn(evId_list);
		for index = 1, obj_num, 1 do
			proxy:PlayAnimation( evId_list[index], animId_list[index] );
		end
		
		proxy:NotNetMessage_begin();
			--��1636���G���x�[�^���~���A�j���I����
			proxy:OnCharacterAnimEnd( 1636 , 1620 , 2 , "OnEvent_1636_anime_end" , once );
		proxy:NotNetMessage_end();
		
		--�G���x�[�^����ɂ����ԂɃt���O�����킹��
		proxy:SetEventFlag( 1630 , true ); --���ɂ���
		proxy:SetEventFlag( 1631 , false );--��ɂȂ�
	end		

	print("OnEvent_1636 end");
end

--��1636_anime_end���G���x�[�^���~���A�j���I����
function OnEvent_1636_anime_end(proxy, param)
	print("OnEvent_1636_anime_end begin");

	proxy:DeleteEvent( 1636 );--�G���x�[�^���~���̊Ď��폜
	--���G���x�[�^������Ď��ǉ���
	proxy:OnPlayerActionInRegion( 1635 , 2650 , "OnEvent_1635" , HELPID_START , everytime );
	--proxy:OnDistanceActionPlus( 1635 , LOCAL_PLAYER, 1620, "OnEvent_1635" , 1, HELPID_START , 0, 100, 0.0, 0.0, 0.0, everytime );--����p
	
	print("OnEvent_1636_anime_end end");
end

]]

--------------------------------------------------------------------------------------
--��4503���\�E�����聡
--------------------------------------------------------------------------------------

function OnEvent_4503(proxy, param)
	print("OnEvent_4503 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--�V�����A�j�� 
		print("OnEvent_4503 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 4503, "OnEvent_4503_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4103 end");
end


--��4503_1���A�C�e���擾��
function OnEvent_4503_1(proxy, param)
	print("OnEvent_4503_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10101�Q��
	proxy:GetRateItem(10101);	
	proxy:GetRateItem(10182);
	proxy:GetRateItem(10183);
	proxy:GetRateItem(10184);
	proxy:GetRateItem(10185);
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 4503, 1 );
	
	--�󔠃V�F�[�_�[�͏����܂���
	--proxy:TreasureDispModeChange( 1979 , false );

	--SFX��������
	proxy:InvalidSfx( 1640, true );--SFX ������
	--proxy:InvalidSfx( 1641, true );--���̗��q
		
	if proxy:IsCompleteEvent( 4510 ) == false then
		proxy:NotNetMessage_begin();
			--�u�Ԃŕ\������ƃ��j���[����ɏo��̂ő҂�
			proxy:OnKeyTime2( 4510 , "OnEvent_4510_wait",0.5 , 0 , 1, once);			
		proxy:NotNetMessage_end();
	else
		--���v�΂Ń��[�v�p�̊Ď���ǉ���
		proxy:OnDistanceActionAttribute( 4505 , LOCAL_PLAYER , 1979 , "OnEvent_4505" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	end		

	print("OnEvent_4503_1 end");
end


--�A�C�e���擾��̃E�F�C�g
function OnEvent_4510_wait(proxy,param)
	print("OnEvent_4510_wait begin");
	proxy:NotNetMessage_begin();
		--�C���t�H���j���[��������̂�҂�����
		proxy:OnRegistFunc( 4510 , "Check_4510" , "OnEvent_4510" , 1 , ocne);
	proxy:NotNetMessage_end();
	print("OnEvent_4510_wait end");
end	
--�C���t�H�҂�
function Check_4510(proxy)
	if proxy:IsShowMenu_InfoMenu() == true then
		return false;
	end
	return true;
end

--��b�����\��
function OnEvent_4510(proxy,param)
	print("OnEvent_4510 begin");
	proxy:NotNetMessage_begin();
		--��b����
		proxy:CloseMenu();
		proxy:TalkNextPage( 4510 );
		proxy:SetEventFlag( 4510 , true );
	proxy:NotNetMessage_end();
	--���v�΂Ń��[�v�p�̊Ď���ǉ���	
	proxy:OnDistanceActionAttribute( 4505 , LOCAL_PLAYER , 1979 , "OnEvent_4505" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	print("OnEvent_4510 end");
end

--------------------------------------------------------------------------------------
--�Β��Ƀ��[�v(�{�X�|������p)��4505
--------------------------------------------------------------------------------------

--��4505���Β��Ƀ��[�v��
function OnEvent_4505(proxy,param)	

	if proxy:IsCompleteEvent( 4505 ) == true then
		return;
	end	

	print("OnEvent_4505 begin");
	
	proxy:RepeatMessage_begin();
		--��4505_1���I�����j���[�̊Ď���
		proxy:OnSelectMenu(4505, "OnEvent_4505_0", 10010710, 0, 2, 1979, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_4505 end");
end

--��4505_0���I�����j���[�̊Ď���
function OnEvent_4505_0(proxy, param)
	print("OnEvent_4505_0 begin");	
	
	if proxy:IsSession() == false then
		proxy:PlayAnimation( LOCAL_PLAYER , 8283 );--�v�΂ɐG���A�j�����Đ�
		proxy:NoAnimeTurnCharactor( 10000 , 1979 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--���v�΂ɐG���A�j���Đ��I����
			proxy:OnChrAnimEnd( 4505 , LOCAL_PLAYER , 8283 , "OnEvent_4505_1" , once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 4505 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_4505_0 end");
end

--��4505_1�������E�ɋA��A�j�����Đ��I����
function OnEvent_4505_1(proxy,param)	
	print("OnEvent_4505_1 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ�
	--�Β��֖߂��Ă�������̃t���O�𗧂Ă�
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag( 4505 , 0 );	
	--���S�񕜗v��
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1006 );
	
	print("OnEvent_4505_1 end");
end

--------------------------------------------------------------------------------------
--�r�������O�������G�΁�1712
--------------------------------------------------------------------------------------
--��1712���r�������O�������G��
function OnEvent_1711(proxy,param)
	print("OnEvent_1711 begin");
	
	if proxy:IsCompleteEvent(BIYO_STATE_BATTLE_FLY_DRAGON) == true then
		SetNpcStateFlag( proxy , param , biyo_flag_list , BIYO_STATE_HOSTILE_IN_GATE_FRONT );
		proxy:SetEventCommand( 698 , 51 );--EzState�ɐ���ԍ�(�����オ��)��n��
		proxy:EnableLogic( 698, true );--�r�����W�b�NON
		proxy:SetTeamType( 698, TEAM_TYPE_AngryFriend );
		proxy:EraseEventSpecialEffect_2(698,5064);
		proxy:SetEventFlag( 1711, true );
	end
	
	print("OnEvent_1711 end");
end

--��1712���r�������O�������S
function OnEvent_1712(proxy,param)
	print("OnEvent_1712 begin");
	
	SetNpcStateFlag( proxy , param , biyo_flag_list , BIYO_STATE_DEAD );
	proxy:SetEventFlag( 1712, true );
	
	print("OnEvent_1712 end");
end


--��1717���r�������O�������Q��
function OnEvent_1717(proxy,param)
	print("OnEvent_1717 begin");
	
	proxy:EnableLogic( 698, false );--�r�����W�b�NOFF
	proxy:SetTeamType( 698 , TEAM_TYPE_Friend );
	proxy:SetEventCommand( 698, 60 );--EzState�ɐ���ԍ�(�Q��)��n��
	
	proxy:SetEventFlag( 1717, true );
	print("OnEvent_1717 end");
end


--��1700�������h�����q�@���S����
function OnEvent_1700(proxy,param)
	print("OnEvent_1700 begin");
	
	--�������Ȃ���Ԃ̂Ƃ��Ɏ���ł��A��Ԃ͐؂�ւ��Ȃ�
	if	proxy:IsCompleteEvent( RENDOL_STATE_ERASE ) == true then
		return;
	end
	
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_DEAD );
	RendolCheck(proxy,param);
	--���S��RendolCheck����ꍇ�A���̏u�Ԃɏ����Ă��܂��̂ŁA
	--���������čēx�L���ɂ��邩���߂�
	if	proxy:IsDistance( LOCAL_PLAYER, 626, 20 ) == true then
		ValidCharactor( proxy, 626 );
	end
	proxy:SetEventFlag( 1700, true );

	print("OnEvent_1700 end");
end

--��1702�������h�����q�@�G�΂���
function OnEvent_1702(proxy,param)
	print("OnEvent_1702 begin");
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HOSTILE_4_LIFT_FRONT );
		proxy:SetTeamType( 626, TEAM_TYPE_AngryFriend );
	
	proxy:SetEventFlag( 1702, true );
	
	print("OnEvent_1702 end");
end



--��11790�������h�����q�@��b����A�C�e���擾
function OnEvent_11790(proxy,param)
	print("OnEvent_11790 begin");
	if proxy:IsCompleteEvent( 11790 ) == true then
		return;
	end
	
	if proxy:IsClient() == false then
		proxy:GetRateItem(10190);
	end
	proxy:SetHp( 626, 0.0 );
	proxy:SetEventFlag( 11790, true );
	
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_ERASE );
	RendolCheck(proxy,param);
	--���S��RendolCheck����ꍇ�A���̏u�Ԃɏ����Ă��܂��̂ŁA
	--���������čēx�L���ɂ��邩���߂�
	if	proxy:IsDistance( LOCAL_PLAYER, 626, 20 ) == true then
		ValidCharactor( proxy, 626 );
	end
	
	print("�h���������");
	proxy:SendEventRequest( 697 ,0, 1);
	proxy:SetEventSpecialEffect_2( 697 , 5042 );
	
	print("OnEvent_11790 end");
end


-----------------------------------------------------------------------------
--��1760��QWC�\�E�������X�^�[�o���P��
-----------------------------------------------------------------------------
function OnEvent_1760(proxy,param)
	print("OnEvent_1760 begin");
	ValidCharactor( proxy, 510 );
	proxy:PlayAnimation( 510, 6100 );
	proxy:SetEventFlag( 1760, true );
	print("OnEvent_1760 end");
end


--�򗳂̒����S
function HiryuOsaDead(proxy,param)
	print("HiryuOsaDead begin");
	
	SetNpcStateFlag(proxy, param, tyo_flag_list, TYO_STATE_DEAD );
	
	--�z�X�g�̂ݓ���
	if	proxy:IsClient() == false then
		--���g���t�B�[�擾���聥
		Lua_RequestUnlockTrophy(proxy, 12);
		proxy:GetRateItem(10117);--�A�C�e������
	end
	
	--����P�̒�������
	InvalidCharactor(proxy,300);
	proxy:DeleteEvent(220);
	proxy:DeleteEvent(235);
	print("HiryuOsaDead end");
end

------------------------------------------------------------------------------------
--��1706�����̈�i���ŉ��q�����ʁ�
------------------------------------------------------------------------------------
--�����������̃C�x���g�o�^��--------------------------------------------------------
function RegistEvent_1706(proxy)
	if	proxy:IsCompleteEvent( 1706 ) == false then
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionIn( 1706, LOCAL_PLAYER, 2720, "OnEvent_1706", once );
			proxy:NotNetMessage_end();
		end
		proxy:LuaCall( 1706 , 0 , "OnEvent_1706_1",once);
	end	
end

function OnEvent_1706(proxy,param)
	print("OnEvent_1706 begin");
	--proxy:SetEventFlag( 15492, true );
	--proxy:SetEventFlag( 15493, true );
	--proxy:SetEventFlag( 15494, true );
	
	--���S�ł͖����Ȃ�
	if proxy:IsCompleteEvent( RENDOL_STATE_DEAD ) == false then		
		--�������Ȃ���Ԃ̂Ƃ��ɎE���Ă��A���񂾔���̕��Ŏ��S�Ɉڍs���Ȃ��悤�ɂȂ��Ă���̂�
		--�����Ŏ���ł��炢�܂��B
		--proxy:SetHp( 626, 0.0 );
		--Lua_EventForceDead( proxy , 626 );
		--�G���x�[�^�[�O�̏�Ԃ̎��̂ݎE��
		if 	proxy:IsCompleteEvent( RENDOL_STATE_LIFT_FRONT ) == true or
			proxy:IsCompleteEvent( RENDOL_STATE_HOSTILE_4_LIFT_FRONT ) == true then
			SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_ERASE );
			proxy:ForceDead( 626 );
		else
			SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_ERASE );
		end
	end
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1706 , "OnEvent_1706_wait",3.0,0,0,once);
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 1706 , true );
	print("OnEvent_1706 end");
end

--�҂�����
function OnEvent_1706_wait(proxy,param)
	print("OnEvent_1706_wait begin");
	proxy:LuaCallStart( 1706 , 0 );
	print("OnEvent_1706_wait end");
end

--�����h���u���b�N�o��
function OnEvent_1706_1(proxy,param)
	--�����h���E�u���b�N������łȂ�
	if proxy:IsCompleteEvent( 1640 ) == false then
		print("OnEvent_1706_1 begin");	
		ValidCharactor( proxy, 502 );
		proxy:PlayAnimation( 502 , 6100);
		print("OnEvent_1706_1 end");
	end
end



------------------------------------------------------------------------------------
--��1640�������h�����q�E�u���b�N���S��
------------------------------------------------------------------------------------
--�����������̃C�x���g�o�^��--------------------------------------------------------
function RegistEvent_1640(proxy)
	if	proxy:IsCompleteEvent( 1640 ) == false then
		proxy:OnCharacterDead( 1640, 502, "OnEvent_1640", once );
		if proxy:IsCompleteEvent( 1706 ) == false then
			InvalidCharactor( proxy, 502 );
		end
	else
		InvalidCharactor( proxy, 502 );
	end
end

function OnEvent_1640(proxy,param)
	print("OnEvent_1640 begin");
	proxy:SetEventFlag( 1640, true );
	print("OnEvent_1640 end");
end


--------------------------------------------------------------------------------------
--���򗳂̒��̍U���҂����Ԃ��擾���܂��B
--------------------------------------------------------------------------------------
function GetDelay_HiryuOsa(proxy)
	--�u���XA�`C�Ŏg���U���f�B���C�p�̎���
	local Delay_under	= HiryuOsa_AttackDelay_under * 100;
	local Delay_top		= HiryuOsa_AttackDelay_top * 100;
	local scale_dilay 	= proxy:GetRandom( Delay_under , Delay_top );--2�`4�b
	local atack_dilay_time = scale_dilay / 100;--2�`4�b
	return atack_dilay_time;
end


function OnEvent_1780(proxy,param)
	print("OnEvent_1780 begin");
	proxy:PlayAnimation( 512, 7000 );
	proxy:EnableLogic( 512, true );
	print("OnEvent_1780 end");
end


--��1670���򗳂̒���HP��75%�ȉ���
function OnEvent_1670(proxy,param)
	print("OnEvent_1670 begin");
	proxy:SetEventFlag( 1670, true );
	print("OnEvent_1670 end");
end

--��1671���򗳂̒���HP��50%�ȉ���
function OnEvent_1671(proxy,param)
	print("OnEvent_1671 begin");
	proxy:SetEventFlag( 1671, true );
	print("OnEvent_1671 end");
end




--��1790���򗳂̏����r�������O�����ɋ�����
function Condition_1790(proxy,param)
	if	proxy:IsCompleteEvent( TYO_STATE_WARNING_AISLE )		== true then
		proxy:SendEventRequest( 698, 0, AI_EVENT_HIRYU_GATE );
	else
		proxy:SendEventRequest( 698, 0, AI_EVENT_None );
	end
end



-----------------------------------------------------------------------------
--��1680�������g�J�Q�C�x���g5
-----------------------------------------------------------------------------
function OnEvent_1680(proxy,param)
	print("OnEvent_1680 begin");
	proxy:SetEventFlag( 1680, true);
	proxy:DeleteEvent( 1680 );
	print("OnEvent_1680 end");
end

-----------------------------------------------------------------------------
--��1682�������g�J�Q�C�x���g6
-----------------------------------------------------------------------------
function OnEvent_1682(proxy,param)
	print("OnEvent_1682 begin");
	proxy:SetEventFlag( 1682, true);
	proxy:DeleteEvent( 1682 );
	print("OnEvent_1682 end");
end

-----------------------------------------------------------------------------
--��1684�������g�J�Q�C�x���g7
-----------------------------------------------------------------------------
function OnEvent_1684(proxy,param)
	print("OnEvent_1684 begin");
	proxy:SetEventFlag( 1684, true);
	proxy:DeleteEvent( 1684 );
	print("OnEvent_1684 end");
end


-----------------------------------------------------------------------------
--��1690���O�e�m�P����
-----------------------------------------------------------------------------
function OnEvent_1690(proxy,param)
	print("OnEvent_1690 begin");
	proxy:SetEventFlag( 1690 , true );
	print("OnEvent_1690 end");
end

-----------------------------------------------------------------------------
--��1691���O�e�m2����
-----------------------------------------------------------------------------
function OnEvent_1691(proxy,param)
	print("OnEvent_1691 begin");
	proxy:SetEventFlag( 1691 , true );
	print("OnEvent_1691 end");
end

-----------------------------------------------------------------------------
--��1692���O�e�m3����
-----------------------------------------------------------------------------
function OnEvent_1692(proxy,param)
	print("OnEvent_1692 begin");
	proxy:SetEventFlag( 1692 , true );
	print("OnEvent_1692 end");
end
