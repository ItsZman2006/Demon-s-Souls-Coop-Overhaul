
--------------------------------------------------------------------------------------
--�X�N���v�g��������10�����ߑΉ��p	���Â��͉̂��ɃR�����g�A�E�g���Ă܂�,�����͖{�C�x���g�ɐ؂�ւ��Ƃ��ɏ���
--------------------------------------------------------------------------------------
function Initialize_m03_01_00_99(proxy)
	print("Initialize_m03_01_00_99 begin");

--��0���G�Ɛ���Ă���NPC��PC���C�x���g�G���A(2900)�ɓ�������
	proxy:OnRegionJustIn(0,10000,2900,"OnEvent_0",once);

--��80��NPC���珕�������߂���(�{�C�XSE)��
	proxy:NotNetMessage_begin();
		proxy:OnRegionJustIn(80,10000,2901,"OnEvent_80",once);
	proxy:NotNetMessage_end();

--��100��NPC���珕�������߂��遡
	proxy:NotNetMessage_begin();
		proxy:OnPlayerDistanceInTarget(100,10000,900,"OnEvent_100",4,once);
	proxy:NotNetMessage_end();
	
--��110��NPC��b�C�x���g����ValueBuffer	20080�g�p
	proxy:NotNetMessage_begin();
		OnTalk(proxy,110,900,TalkDist_N,TalkAngle_N,20080,HELPID_TALK_WAR,"OnEvent_110","OnEvent_110_1","OnEvent_110_2",everytime);
--��111��NPC��b�ēo�^�p��
		proxy:LuaCall(111,1,"OnEvent_111_1",everytime);
		proxy:LuaCall(10001,1,"OnEvent_10001_1",everytime);
		
	proxy:NotNetMessage_end();

--��120��PC��NPC���E������
	proxy:NotNetMessage_begin();
		proxy:OnSimpleDamage(120,900,10000,"OnEvent_120",everytime);
	proxy:NotNetMessage_end();

--��120_1���t���O�ݒ�ύX��
	proxy:LuaCall(120,1,"OnEvent_120_1",everytime);

--��121��NPC�ɑ΂��郊�~�b�g�J�E���g�n����PC���C�x���g�G���A(2901)�ɓ�������
	--proxy:OnRegionJustIn(121,10000,2901,"OnEvent_121",once);
	--��121_1��NPC���S�p��
	proxy:NotNetMessage_begin();
		proxy:OnCharacterDead(121,900,"OnEvent_121_2",once);
	proxy:NotNetMessage_end();

--��160���X�e�[�W�N���A:�V�X�e�����b�Z�[�W��
	proxy:LuaCall(160,1,"ClientStageClear",once);	

--��14290��NPC����A�C�e����Ⴄ��


proxy:NotNetMessage_begin();
--��12790���󎀑�A���ׂ遡
	proxy:OnDistanceAction(12790,10000,1900,"OnEvent_12790",ItemBoxDist_A,HELPID_CHECK_GLOWING_CORPS,0,ItemBoxAngle_A,once);
	
--��12791���󎀑�B���ׂ遡
	proxy:OnDistanceAction(12791,10000,1901,"OnEvent_12791",ItemBoxDist_A,HELPID_CHECK_GLOWING_CORPS,0,ItemBoxAngle_A,once);
proxy:NotNetMessage_end();
	
	
--~ --��3492���I��NPC�Ƃ̉�b����ValueBuffer 20081�g�p
--~ 	proxy:NotNetMessage_begin();--��z�M
--~ 		OnTalk(proxy,3492,901,TalkDist_N,TalkAngle_N,20081,10000001,"OnEvent_3492","OnEvent_3492_1","OnEvent_3492_2",everytime);
--~ 	proxy:NotNetMessage_end();

	proxy:NotNetMessage_begin();
--��5113���R�m���S�Ď�
		proxy:OnCharacterDead(5113,920,"OnEvent_5113",everytime);

--��150���m���Ɖ�b���߂�:�R�m�����Ă�:�󖳂�����ValueBuffer 20090�g�p	
		OnTalk(proxy,150,901,TalkDist_N,TalkAngle_N,20090,HELPID_TALK_CLE,"OnEvent_150","OnEvent_150_1","OnEvent_150_2",everytime);
		
--��180���R�m���K�I
		proxy:OnRegionJustIn(180,10000,2902,"OnEvent_180",once);
	proxy:NotNetMessage_end();

--��999999���������^�C�~���O��0�b��
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 999900, "Second_Initialize_m03_01_00_99", 0.3, 0, 0, once );
	proxy:NotNetMessage_end();
	
	--��190�`201���L�����N�^�X�V�Ď���
	proxy:NotNetMessage_begin();
		--��190-191���L�����N�^�X�V�Ď���
		OnUpDate(proxy,190,191,2910,"OnEvent_3500","OnEvent_3501");
		--��192-193���L�����N�^�X�V�Ď���
		OnUpDate(proxy,192,193,2911,"OnEvent_3502","OnEvent_3503");
		--��194-195���L�����N�^�X�V�Ď���
		OnUpDate(proxy,194,195,2912,"OnEvent_3504","OnEvent_3505");
		--��196-197���L�����N�^�X�V�Ď���
		OnUpDate(proxy,196,197,2913,"OnEvent_3506","OnEvent_3507");
		--��198-199���L�����N�^�X�V�Ď���
		OnUpDate(proxy,198,199,2914,"OnEvent_3508","OnEvent_3509");
		--��200-201���L�����N�^�X�V�Ď���
		OnUpDate(proxy,200,201,2915,"OnEvent_3510","OnEvent_3511");
	proxy:NotNetMessage_end();

	proxy:NotNetMessage_begin();
	--��10��NPC�����s�l���Ď���
		proxy:OnPlayerDistanceInTarget(10,902,900,"OnEvent_10_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(10,902,900,"OnEvent_10_2",5.0,everytime);
	
	--��11��NPC�����s�l���Ď���
		proxy:OnPlayerDistanceInTarget(11,903,900,"OnEvent_11_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(11,903,900,"OnEvent_11_2",5.0,everytime);
		
	--��12��NPC�����s�l���Ď���
		proxy:OnPlayerDistanceInTarget(12,904,900,"OnEvent_12_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(12,904,900,"OnEvent_12_2",5.0,everytime);
	
	--��13��NPC�����s�l���Ď���
		proxy:OnPlayerDistanceInTarget(13,905,900,"OnEvent_13_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(13,905,900,"OnEvent_13_2",5.0,everytime);

	--��14��NPC�����s�l���Ď���
		proxy:OnPlayerDistanceInTarget(14,906,900,"OnEvent_14_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(14,906,900,"OnEvent_14_2",5.0,everytime);
		
	--��15��NPC�����s�l���Ď���
		proxy:OnPlayerDistanceInTarget(15,911,900,"OnEvent_15_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(15,911,900,"OnEvent_15_2",5.0,everytime);
		
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
	
--��10�����s�l�����񂾁�
		proxy:OnCharacterDead(10,902,"OnEvent_10", everytime);

--��11�����s�l�����񂾁�	
		proxy:OnCharacterDead(11,903,"OnEvent_11", everytime);
		
--��12�����s�l�����񂾁�
		proxy:OnCharacterDead(12,904,"OnEvent_12", everytime);
		
--��13�����s�l�����񂾁�	
		proxy:OnCharacterDead(13,905,"OnEvent_13", everytime);
		
--��14�����s�l�����񂾁�	
		proxy:OnCharacterDead(14,906,"OnEvent_14", everytime);
		
--��15�����s�l�����񂾁�	
		proxy:OnCharacterDead(15,911,"OnEvent_15", everytime);
		
--��15906�����s�l�����񂾁�
		--proxy:OnCharacterDead(15906,909,"OnEvent_15906", everytime);
	
--��15907�����s�l�����񂾁�
		--proxy:OnCharacterDead(15907,910,"OnEvent_15907", everytime);
		
--��15908�����s�l�����񂾁�	
		--proxy:OnCharacterDead(15908,913,"OnEvent_15908", everytime);

--��15909�����s�l�����񂾁�	
		--proxy:OnCharacterDead(15909,914,"OnEvent_15909", everytime);

--��15910�����s�l�����񂾁�	
		--proxy:OnCharacterDead(15910,915,"OnEvent_15910", everytime);
		
--��15911�����s�l�����񂾁�
		--proxy:OnCharacterDead(15911,916,"OnEvent_15911", everytime);
		
--��15912�����s�l�����񂾁�
		--proxy:OnCharacterDead(15912,917,"OnEvent_15912", everytime);
		
--��15929�����s�l�����񂾁�
		--proxy:OnCharacterDead(15929,911,"OnEvent_15929", everytime);
		
--��15930�����s�l�����񂾁�
		--proxy:OnCharacterDead(15930,912,"OnEvent_15930", everytime);
	proxy:NotNetMessage_end();

	
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc( 12345 , "Check" , "OnEvent_12345" , 1 , everytime );
	proxy:NotNetMessage_end();
	
	
--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m03_01_00_99", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m03_01_00_99", everytime );
	proxy:NotNetMessage_end();
	
	
	print("Initialize_m03_01_00_99 end");
end


--------------------------------------------------------------------------------------
--�}���`�ɂȂ������Ƀz�X�g���ᖳ�������灡����
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	
	--����Ȃ��C�x���g���`�F�b�N���܂�
	--proxy:DeleteEvent(120);
	proxy:DeleteEvent(3412);
	proxy:DeleteEvent(121);	
	proxy:DeleteEvent(110);--��b�C�x���g����U�폜
	
	proxy:DeleteEvent(10);
	proxy:DeleteEvent(11);
	proxy:DeleteEvent(12);
	proxy:DeleteEvent(13);
	proxy:DeleteEvent(14);
	proxy:DeleteEvent(15);	
--[[	
	--�L��������x���������܂�
	proxy:SetAlive(900,1.0);
	proxy:SetAlive(901,1.0);
	proxy:SetAlive(902,1.0);
	proxy:SetAlive(903,1.0);
	proxy:SetAlive(904,1.0);
	proxy:SetAlive(905,1.0);
	proxy:SetAlive(906,1.0);
	proxy:SetAlive(907,1.0);
	proxy:SetAlive(908,1.0);
	proxy:SetAlive(909,1.0);
	proxy:SetAlive(910,1.0);
	proxy:SetAlive(911,1.0);
	proxy:SetAlive(912,1.0);
	proxy:SetAlive(913,1.0);
	proxy:SetAlive(914,1.0);
	proxy:SetAlive(915,1.0);
	proxy:SetAlive(916,1.0);
	proxy:SetAlive(917,1.0);
	proxy:SetAlive(918,1.0);
	proxy:SetAlive(919,1.0);
	proxy:SetAlive(920,1.0);
	proxy:SetAlive(930,1.0);
]]	
	--1�t���[����ɍēx�o�^���Ȃ���
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(111,"OnEvent_111",0.5,0,0,once);
		proxy:OnKeyTime2(10001,"OnEvent_10001",0.0,0,0,once);
	proxy:NotNetMessage_end();
	print("ConnectPartyEvent end");
end


--------------------------------------------------------------------------------------
--�}�b�v�̏�������999999
--------------------------------------------------------------------------------------
function Second_Initialize_m03_01_00_99(proxy, param )
	print("Second_Initialize_m03_01_00_99 begin");
	--���̔���̓S�[�X�g���җp
	if proxy:IsCompleteEvent( 0 ) ==false then
		--NPC�̃��W�b�N��؂�
		proxy:EnableLogic( 900, false );
		--���s�l�̃��W�b�N��؂�
		proxy:EnableLogic( 902, false );
		--���s�l�̃��W�b�N��؂�
		proxy:EnableLogic( 903, false );
		--���s�l�̃��W�b�N��؂�
		proxy:EnableLogic( 904, false );
	end
	
	--�I��NPC�̒�~,�I��NPC�̖��G��
	proxy:EnableLogic(901,false);
	--proxy:SetDeadMode(900,true);
	proxy:SetDeadMode(901,true);
	
	
	--���̏��̒�~
	proxy:EnableLogic(930,false);
	--�L�����N�^�X�V�����Ȃ��ɐݒ�
	for ChrID= 900,930,1 do
		SetDisable(proxy,ChrID,true);
	end
	--�󎀑̂����点��
	if proxy:IsCompleteEvent(12790) ==false then
		proxy:TreasureDispModeChange(1900, true );
	end
	if proxy:IsCompleteEvent(12791) ==false then
		proxy:TreasureDispModeChange(1901, true );
	end
	
	
--[[
	--���p�j�f�[�����p (�t���O�͉��A�w�肪����Ες���)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m03_01_00_99);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m03_01_00_99);
	end
]]
	
	
	print("Second_Initialize_m03_01_00_99 end");
end


--------------------------------------------------------------------------------------
--�G��NPC���킢������0
--------------------------------------------------------------------------------------
function OnEvent_0(proxy,param)
	print("OnEvent_0 begin");
	proxy:SetEventFlag(0,1);
	--NPC���W�b�NON
	proxy:EnableLogic(900,true);	
	--���s�l���W�b�NON
	proxy:EnableLogic(902,true);
	--���s�l���W�b�NON
	proxy:EnableLogic(903,true);
	--���s�l���W�b�NON
	proxy:EnableLogic(904,true);	
	print("OnEvent_0 end");	
end


--------------------------------------------------------------------------------------
--NPC���珕�������߂���(�{�C�XSE)��80
--------------------------------------------------------------------------------------
function OnEvent_80(proxy,param)
	print("OnEvent_80 begin");
	--�{�C�XSE�Đ�
	proxy:PlayTypeSE(900,7,705000003);
	print("OnEvent_80 end");	
end


--------------------------------------------------------------------------------------
--NPC���珕�������߂��遡100	
--------------------------------------------------------------------------------------
function OnEvent_100(proxy,param)
	if proxy:IsCompleteEvent(100) == true then
		return;
	end
	
	print("OnEvent_100 begin");
	proxy:SetEventFlag(100,true);
	print("OnEvent_100 ebd");
end

--------------------------------------------------------------------------------------
--NPC�Ƃ̉�b��110	��ValueBuffer	20080�g�p
--------------------------------------------------------------------------------------
--���A�N�V�����{�^�����聡
function OnEvent_110(proxy,param)
	if proxy:IsCompleteEvent(110) == false then
		return;
	end
	print("OnEvent_110 begin");
	
	local FlagValue =  proxy:IsCompleteEventValue(20080);	
	if proxy:IsCompleteEvent(3407) == false then
		if FlagValue == 0 then
			proxy:SetEventFlag(20080,1);
			proxy:TurnCharactor( 900, 10000 );
		end
		if FlagValue == 1 then proxy:SetEventFlag(20080,2); end		
		if FlagValue == 2 then
			proxy:AddInventoryItem(1,TYPE_GOODS,10);
			proxy:GetItem(1,TYPE_GOODS);
			proxy:SetEventFlag(3407,true);
			proxy:SetEventFlag(20080,0);
		end
	else
		--���[�v��b
		if FlagValue == 0 then
			proxy:SetEventFlag(20080,1);
			proxy:TurnCharactor( 900, 10000 );
		end
		if FlagValue == 1 then proxy:SetEventFlag(20080,2); end
		if FlagValue == 2 then proxy:SetEventFlag(20080,0); end
	end
	
	print("OnEvent_110 end");
end

--�����̈攻�聡
function OnEvent_110_1(proxy,param)
	
	if proxy:IsCompleteEvent(110) == false then
		return;
	end
	
	local FlagValue =  proxy:IsCompleteEventValue(20080);	
	if proxy:IsCompleteEvent(3407) == false then
		Luafunc_Talk(proxy,FlagValue,1,900,90000060,true);
		Luafunc_Talk(proxy,FlagValue,2,900,90000061,false);
	else
		Luafunc_Talk(proxy,FlagValue,1,900,90000062,true);
		Luafunc_Talk(proxy,FlagValue,2,900,90000063,false);
	end	
end

--���͈͊O���聡
function OnEvent_110_2(proxy,param)
	if proxy:IsCompleteEvent(110) == false then
		return;
	end	
	print("OnEvent_110_2 begin");
	local FlagValue = proxy:IsCompleteEventValue(20080);
	if FlagValue >= 1 then
		proxy:SetEventFlag(20080,0);
	end
	print("OnEvent_110_2 end");
end


--------------------------------------------------------------------------------------
--NPC��b�̍ēo�^��111
--------------------------------------------------------------------------------------
--1�t���[���x�点��ׂ̏���
function OnEvent_111(proxy,param)
	if param:IsNetMessage() == true then
		return;
	end
	proxy:LuaCallStart(111,1);
end

--�\�ߓo�^���ꂽ��b�ǉ��֐�
function OnEvent_111_1(proxy,param)
	print("AddEvent begin");
	proxy:NotNetMessage_begin();
	
		--��110��NPC��b�C�x���g����ValueBuffer	20080�g�p
		OnTalk(proxy,110,900,TalkDist_N,TalkAngle_N,20080,HELPID_TALK_WAR,"OnEvent_110","OnEvent_110_1","OnEvent_110_2",everytime);	
		--��120��PC��NPC���E������	
		--proxy:OnSimpleDamage(120,900,10000,"OnEvent_120",everytime);
		--��121_1��NPC���S�p��	
		proxy:OnCharacterDead(121,900,"OnEvent_121_2",once);
		
		
	--��10��NPC�����s�l���Ď���
		proxy:OnPlayerDistanceInTarget(10,902,900,"OnEvent_10_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(10,902,900,"OnEvent_10_2",5.0,everytime);
	
	--��11��NPC�����s�l���Ď���
		proxy:OnPlayerDistanceInTarget(11,903,900,"OnEvent_11_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(11,903,900,"OnEvent_11_2",5.0,everytime);
		
	--��12��NPC�����s�l���Ď���
		proxy:OnPlayerDistanceInTarget(12,904,900,"OnEvent_12_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(12,904,900,"OnEvent_12_2",5.0,everytime);
	
	--��13��NPC�����s�l���Ď���
		proxy:OnPlayerDistanceInTarget(13,905,900,"OnEvent_13_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(13,905,900,"OnEvent_13_2",5.0,everytime);

	--��14��NPC�����s�l���Ď���
		proxy:OnPlayerDistanceInTarget(14,906,900,"OnEvent_14_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(14,906,900,"OnEvent_14_2",5.0,everytime);
		
	--��15��NPC�����s�l���Ď���
		proxy:OnPlayerDistanceInTarget(15,911,900,"OnEvent_15_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(15,911,900,"OnEvent_15_2",5.0,everytime);
		
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
--��10��NPC�����s�l���Ď���
	
	--��10�����s�l�����񂾁�
		proxy:OnCharacterDead(10,902,"OnEvent_10", everytime);

	--��11�����s�l�����񂾁�	
		proxy:OnCharacterDead(11,903,"OnEvent_11", everytime);
		
	--��12�����s�l�����񂾁�
		proxy:OnCharacterDead(12,904,"OnEvent_12", everytime);
		
	--��13�����s�l�����񂾁�	
		proxy:OnCharacterDead(13,905,"OnEvent_13", everytime);
		
	--��14�����s�l�����񂾁�	
		proxy:OnCharacterDead(14,906,"OnEvent_14", everytime);
		
	--��15�����s�l�����񂾁�	
		proxy:OnCharacterDead(15,911,"OnEvent_15", everytime);
		
	--��15906�����s�l�����񂾁�
		--proxy:OnCharacterDead(15906,909,"OnEvent_15906", everytime);
	
	--��15907�����s�l�����񂾁�
		--proxy:OnCharacterDead(15907,910,"OnEvent_15907", everytime);
		
	--��15908�����s�l�����񂾁�	
		--proxy:OnCharacterDead(15908,913,"OnEvent_15908", everytime);

	--��15909�����s�l�����񂾁�	
		--proxy:OnCharacterDead(15909,914,"OnEvent_15909", everytime);

	--��15910�����s�l�����񂾁�	
		--proxy:OnCharacterDead(15910,915,"OnEvent_15910", everytime);
		
	--��15911�����s�l�����񂾁�
		--proxy:OnCharacterDead(15911,916,"OnEvent_15911", everytime);
		
	--��15912�����s�l�����񂾁�
		--proxy:OnCharacterDead(15912,917,"OnEvent_15912", everytime);
		
	--��15929�����s�l�����񂾁�
		--proxy:OnCharacterDead(15929,911,"OnEvent_15929", everytime);
		
	--��15930�����s�l�����񂾁�
		--proxy:OnCharacterDead(15930,912,"OnEvent_15930", everytime);
	
	proxy:NotNetMessage_end();
	print("AddEvent end");	
end

--1�t���[���x�点��ׂ̏���
function OnEvent_10001(proxy,param)
	if param:IsNetMessage() == true then
		return;
	end	
	proxy:LuaCallStart(10001,1);
end

--�\�ߓo�^���ꂽ������
function OnEvent_10001_1(proxy,param)
	print("flag off begin");
	proxy:SetEventFlag(10,false);
	proxy:SetEventFlag(11,false);
	proxy:SetEventFlag(12,false);
	proxy:SetEventFlag(13,false);
	proxy:SetEventFlag(14,false);
	proxy:SetEventFlag(15,false);
	
	proxy:SetEventFlag(10000,false);
	
	proxy:SetEventFlag(5113,false);
	proxy:SetEventFlag(110,false);	
	proxy:SetEventFlag(3407,false);	
	proxy:SetEventFlag(20080,99);
	print("flag off end");
end

--------------------------------------------------------------------------------------
--NPC��PC�ɎE����Ă��܂�����120
--------------------------------------------------------------------------------------
function OnEvent_120(proxy,param)	
	if proxy:IsCompleteEvent(120) == true then
		return;
	end
	print("OnEvent_120 begin");	
	proxy:LuaCallStart(120,1);
	print("OnEvent_120 end");
end


--PT�z�M�p�̃t���O�C�x���g
function OnEvent_120_1(proxy,param)
	print("OnEvent_120_1 begin");
	--NPC������
	if proxy:IsAlive(900) == false then
		--�t���OON
		proxy:SetEventFlag(120,true);
	end
	print("OnEvent_120_1 end");
end


--------------------------------------------------------------------------------------
--NPC���E����Ă��܂�����3412
--------------------------------------------------------------------------------------
function OnEvent_3412(proxy,param)
	print("OnEvent_3412 begin");
	if proxy:IsCompleteEvent(3412) == true then
		return;
	end
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(3412,"OnEvent_3412_1",2,0,0,once);
	proxy:NotNetMessage_end();
	proxy:SetEventFlag(3412,true);
	print("OnEvent_3412 end");
end

function OnEvent_3412_1(proxy,param)
	print("OnEvent_3412_1 begin");
	proxy:SetEventFlag(3412,0);	
	print("OnEvent_3412_1 end");	
end


--------------------------------------------------------------------------------------
--NPC�̃��~�b�^�[���n�����遡121
--------------------------------------------------------------------------------------
function OnEvent_121(proxy,param)
--~ 	print("OnEvent_121 begin");
--~ 	if param:IsNetMessage() == true then
--~ 		return;
--~ 	end	
--~ 	proxy:NotNetMessage_begin();
--~ 		proxy:OnKeyTime2(121,"OnEvent_121_1",NPCTIMER,0,0,once);
--~ 	proxy:NotNetMessage_end();
--~ 	print("OnEvent_121 end");
end

--��121_1���J�E���^�I����̏�����
function OnEvent_121_1(proxy,param)
--~ 	print("OnEvent_121_1 begin");
--~ 	--�\�ߓo�^���Ă��������S�������Ă�
--~ 	proxy:LuaCallStart(121,1);
--~ 	print("OnEvent_121_1 end");
end

--��121_2��NPC���S�A�j���Đ���
function OnEvent_121_2(proxy,param)
	if proxy:IsCompleteEvent(121) == true then
		return;
	end

	print("OnEvent_121_2 begin");
	proxy:SetEventFlag(121,true);
	
	proxy:NotNetMessage_begin();				
			proxy:OnDistanceAction(3412,10000,900,"OnEvent_3412",ItemBoxDist_A,10000007,0,ItemBoxAngle_A,everytime);	
		proxy:DeleteEvent(110);--��b�C�x���g				
		proxy:DeleteEvent(100);--NPC���珕�������߂���
	proxy:NotNetMessage_end();
	print("OnEvent_121_2 end");
end


--------------------------------------------------------------------------------------
--�z�X�gOr�V���O���X�e�[�W�N���A�C�x���g��160
--------------------------------------------------------------------------------------
--��160���N���A�����B����
function HostStageClear(proxy,param)
	print("HostStageClear begin");
	proxy:LuaCallStart(160,1);
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(160,"StageClear",5.0,0,1,once);
	proxy:NotNetMessage_end();
	print("HostStageClear end");
end

--��160_1���V�X�e�����b�Z�[�W��
function HostStageClear_1(proxy,param)
	print("HostStageClear_1 begin");
	print("HostStageClear_1 end");
end

--��160_2���V�X�e�����b�Z�[�W��
function HostStageClear_2(proxy,param)
	print("HostStageClear_2 begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(160,"StageClear",3.0,0,3,once);
	proxy:NotNetMessage_end();
	print("HostStageClear_2 end");
end

--��160_1���^�C�g���ɖ߂遡
function StageClear(proxy,param)
	print("StageClear begin");
	proxy:ReturnMapSelect();
	print("StageClear end");
end


--------------------------------------------------------------------------------------
--�N���C�A���g�X�e�[�W�N���A�C�x���g��160
--------------------------------------------------------------------------------------
--��160���N���A�z�M��
function ClientStageClear(proxy,param)
	if proxy:IsInParty() == false then
		return;
	end
	if proxy:IsHost() == true then
		return;
	end
	
	print("ClientStageClear begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(160,"ClientStageClear_1",2.0,0,4,once);
	proxy:NotNetMessage_end();
	print("ClientStageClear end");	
end

function ClientStageClear_1(proxy,param)
	print("ClientStageClear_1 begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(160,"StageClear",3.0,0,5,once);
	proxy:NotNetMessage_end();
	print("ClientStageClear_1 end");
end

--------------------------------------------------------------------------------------
--�󎀑�A�𒲂ׂ遡12790
--------------------------------------------------------------------------------------
--��12790���͈͓���ACT�{�^������������
function OnEvent_12790(proxy,param)
	print("OnEvent_12790 begin");

	--�����A�j���[�V�����p�̃C�x���g
	proxy:LuaCallStart( 4010 , 1 );
	
	proxy:NotNetMessage_begin();
		--��12790��***�����ǉ�***�󎀑�A�A�C�e���擾��
		proxy:OnKeyTime2( 12790, "OnEvent_12790_1", 0.0, 0, 0, once );		
	proxy:NotNetMessage_end();
	
	print("OnEvent_12790 end");
end

--��12790_1������A�j���I����
function OnEvent_12790_1(proxy,param)
	print("OnEvent_12790_1 begin");
	--����ȃO�b�Y�擾
	proxy:AddInventoryItem(1,TYPE_GOODS,10);
	proxy:GetItem(1,TYPE_GOODS);
	proxy:TreasureDispModeChange(1900, false );
	proxy:SetEventFlag(12790,true);
	print("OnEvent_12790_1 end");
end


--------------------------------------------------------------------------------------
--�󎀑�B�𒲂ׂ遡12791
--------------------------------------------------------------------------------------
--��12791���͈͓���ACT�{�^������������
function OnEvent_12791(proxy,param)
	print("OnEvent_12791 begin");
	
	--�����A�j���[�V�����p�̃C�x���g
	proxy:LuaCallStart( 4010 , 1 );
	
	proxy:NotNetMessage_begin();
		--��12791��***�����ǉ�***�󎀑�A�A�C�e���擾��
		proxy:OnKeyTime2( 12791, "OnEvent_12791_1", 0.0, 0, 0, once );		
	proxy:NotNetMessage_end();

	print("OnEvent_12791 end");
end

--��12791_1������A�j���I����
function OnEvent_12791_1(proxy,param)
	print("OnEvent_12791_1 begin");
--~ 	proxy:AddInventoryItem(1,TYPE_GOODS,10);
--~ 	proxy:GetItem(1,TYPE_GOODS);
	proxy:SetEventFlag(12791,true);
	
	--��b�C�x���g�폜
--~ 	proxy:DeleteEvent(150);
--~ 	proxy:DeleteEvent(14297);
--~ 	proxy:DeleteEvent(14298);
--~ 	proxy:DeleteEvent(14299);
--~ 	proxy:DeleteEvent(14293);	
	
	proxy:TreasureDispModeChange(1901, false );
	print("OnEvent_12791_1 end");
end


--------------------------------------------------------------------------------------
--�L�����N�^�X�V�Ď���3500
--------------------------------------------------------------------------------------
function OnEvent_3500(proxy,param)
	--print("OnEvent_3500 begin");	
	SetDisable(proxy,900,false);	
	SetDisable(proxy,902,false);	
	SetDisable(proxy,903,false);	
	SetDisable(proxy,904,false);	
	SetDisable(proxy,908,false);	
	SetDisable(proxy,909,false);	
	SetDisable(proxy,910,false);
	--print("OnEvent_3500 end");
end

function OnEvent_3501(proxy,param)
	print("OnEvent_3501 begin");
	SetDisable(proxy,900,true);	
	SetDisable(proxy,902,true);	
	SetDisable(proxy,903,true);	
	SetDisable(proxy,904,true);	
	SetDisable(proxy,908,true);	
	SetDisable(proxy,909,true);	
	SetDisable(proxy,910,true);
	--print("OnEvent_3501 end");
end

--------------------------------------------------------------------------------------
--�L�����N�^�X�V�Ď���3502
--------------------------------------------------------------------------------------
function OnEvent_3502(proxy,param)
	--print("OnEvent_3502 begin");
	SetDisable(proxy,908,false);	
	SetDisable(proxy,909,false);	
	SetDisable(proxy,910,false);	
	SetDisable(proxy,911,false);	
	SetDisable(proxy,912,false);	
	SetDisable(proxy,913,false);	
	SetDisable(proxy,914,false);	
	SetDisable(proxy,915,false);	
	SetDisable(proxy,916,false);
	--SetDisable(proxy,917,false);
	SetDisable(proxy,920,false);
	--print("OnEvent_3502 end");
end
function OnEvent_3503(proxy,param)
	print("OnEvent_3503 begin");
	SetDisable(proxy,908,true);	
	SetDisable(proxy,909,true);	
	SetDisable(proxy,910,true);	
	SetDisable(proxy,911,true);	
	SetDisable(proxy,912,true);	
	SetDisable(proxy,913,true);	
	SetDisable(proxy,914,true);	
	SetDisable(proxy,915,true);	
	SetDisable(proxy,916,true);
	--SetDisable(proxy,917,true);
	SetDisable(proxy,920,true);
	--print("OnEvent_3503 end");
end

--------------------------------------------------------------------------------------
--�L�����N�^�X�V�Ď���3504
--------------------------------------------------------------------------------------
function OnEvent_3504(proxy,param)
	--print("OnEvent_3504 begin");
	SetDisable(proxy,905,false);	
	SetDisable(proxy,906,false);	
	SetDisable(proxy,907,false);		
	SetDisable(proxy,911,false);	
	SetDisable(proxy,912,false);	
	SetDisable(proxy,913,false);	
	SetDisable(proxy,914,false);	
	SetDisable(proxy,915,false);	
	SetDisable(proxy,916,false);	
	SetDisable(proxy,917,false);
	SetDisable(proxy,920,false);	
	SetDisable(proxy,930,false);
	--print("OnEvent_3504 end");
end

function OnEvent_3505(proxy,param)
	print("OnEvent_3505 begin");	
	SetDisable(proxy,905,true);	
	SetDisable(proxy,906,true);	
	SetDisable(proxy,907,true);	
	SetDisable(proxy,911,true);	
	SetDisable(proxy,912,true);	
	SetDisable(proxy,913,true);	
	SetDisable(proxy,914,true);	
	SetDisable(proxy,915,true);	
	SetDisable(proxy,916,true);	
	SetDisable(proxy,917,true);	
	SetDisable(proxy,920,true);	
	SetDisable(proxy,930,true);
	--print("OnEvent_3505 end");
end

--------------------------------------------------------------------------------------
--�L�����N�^�X�V�Ď���3506
--------------------------------------------------------------------------------------
function OnEvent_3506(proxy,param)
	--print("OnEvent_3506 begin");
	SetDisable(proxy,911,false);	
	SetDisable(proxy,912,false);	
	SetDisable(proxy,913,false);	
	SetDisable(proxy,914,false);	
	SetDisable(proxy,915,false);	
	SetDisable(proxy,916,false);	
	SetDisable(proxy,905,false);	
	SetDisable(proxy,917,false);	
	SetDisable(proxy,906,false);	
	SetDisable(proxy,907,false);	
	SetDisable(proxy,920,false);	
	SetDisable(proxy,930,false);
	--print("OnEvent_3506 end");
end

function OnEvent_3507(proxy,param)
	print("OnEvent_3507 begin");
	SetDisable(proxy,911,true);	
	SetDisable(proxy,912,true);	
	SetDisable(proxy,913,true);	
	SetDisable(proxy,914,true);	
	SetDisable(proxy,915,true);	
	SetDisable(proxy,916,true);	
	SetDisable(proxy,905,true);	
	SetDisable(proxy,917,true);	
	SetDisable(proxy,906,true);	
	SetDisable(proxy,907,true);	
	SetDisable(proxy,920,true);	
	SetDisable(proxy,930,true);
	--print("OnEvent_3507 end");
end
--------------------------------------------------------------------------------------
--�L�����N�^�X�V�Ď���3508
--------------------------------------------------------------------------------------
function OnEvent_3508(proxy,param)
	--print("OnEvent_3508 begin");
	SetDisable(proxy,900,false);	
	SetDisable(proxy,902,false);	
	SetDisable(proxy,903,false);	
	SetDisable(proxy,904,false);	
	SetDisable(proxy,905,false);	
	SetDisable(proxy,906,false);	
	SetDisable(proxy,907,false);	
	SetDisable(proxy,917,false);
	--print("OnEvent_3508 end");
end

function OnEvent_3509(proxy,param)
	print("OnEvent_3509 begin");
	SetDisable(proxy,900,true);
	SetDisable(proxy,902,true);
	SetDisable(proxy,903,true);
	SetDisable(proxy,904,true);
	SetDisable(proxy,905,true);
	SetDisable(proxy,906,true);
	SetDisable(proxy,907,true);
	SetDisable(proxy,917,true);
	--print("OnEvent_3509 end");
end

--------------------------------------------------------------------------------------
--�L�����N�^�X�V�Ď���3510
--------------------------------------------------------------------------------------
function OnEvent_3510(proxy,param)
	--print("OnEvent_3510 begin");	
	SetDisable(proxy,901,false);
	SetDisable(proxy,920,false);
	SetDisable(proxy,930,false);
	--print("OnEvent_3510 end");
end

function OnEvent_3511(proxy,param)
	print("OnEvent_3511 begin");
	SetDisable(proxy,901,true);
	SetDisable(proxy,920,true);
	SetDisable(proxy,930,true);
	--print("OnEvent_3511 end");
end


--------------------------------------------------------------------------------------
--���s�l�E������10		��ValueBuffer	20082�g�p
--------------------------------------------------------------------------------------
function OnEvent_10(proxy,param)

	if Luafunc_DeadEne(proxy,param,10,20082,0) == false then
		return;
	end	

	--���̕��s�l�̃t���O���`�F�b�N�A����NPC�������Ă���Ȃ�
	if proxy:IsCompleteEvent(10) == true and
	proxy:IsCompleteEvent(11) == true and
	proxy:IsCompleteEvent(12) == true and
	proxy:IsAlive(900) == true then
		proxy:DeleteEvent(100);--NPC���珕�������߂���
		print("NPC Help Me EventDelete");
	end
--[[	
	if proxy:IsAlive( 902 )==false and proxy:IsAlive( 903 )==false and proxy:IsAlive( 904 )==false then
		proxy:SetEventFlag(110,true);--��bON
		proxy:SetEventFlag(20080,0);
		proxy:EnableLogic(900, false);--NPC�v�l��~
	end
]]	
	print("OnEvent_10 end 1");
end


--------------------------------------------------------------------------------------
--���s�l�E������11		��ValueBuffer	20082�g�p
--------------------------------------------------------------------------------------
function OnEvent_11(proxy,param)

	if Luafunc_DeadEne(proxy,param,11,20082,0) == false then
		return;
	end
	
	--���̕��s�l�̃t���O���`�F�b�N�A����NPC�������Ă���Ȃ�
	if proxy:IsCompleteEvent(10) == true and
	proxy:IsCompleteEvent(11) == true and
	proxy:IsCompleteEvent(12) == true and
	proxy:IsAlive(900) == true then
		proxy:DeleteEvent(100);--NPC���珕�������߂���
		print("NPC Help Me EventDelete");
	end	
--[[	
	if proxy:IsAlive( 902 )==false and proxy:IsAlive( 903 )==false and proxy:IsAlive( 904 )==false then
		proxy:SetEventFlag(110,true);--��bON
		proxy:SetEventFlag(20080,0);
		proxy:EnableLogic(900, false);--NPC�v�l��~
	end
]]	
	print("OnEvent_11 end 2");
end


--------------------------------------------------------------------------------------
--���s�l�E������12		��ValueBuffer	20082�g�p
--------------------------------------------------------------------------------------
function OnEvent_12(proxy,param)

	if Luafunc_DeadEne(proxy,param,12,20082,0) == false then
		return;
	end
	
	--���̕��s�l�̃t���O���`�F�b�N�A����NPC�������Ă���Ȃ�
	if proxy:IsCompleteEvent(10) == true and
	proxy:IsCompleteEvent(11) == true and
	proxy:IsCompleteEvent(12) == true and
	proxy:IsAlive(900) == true then
		proxy:DeleteEvent(100);		--NPC���珕�������߂���
		print("NPC Help Me EventDelete");
	end	
--[[	
	if proxy:IsAlive( 902 )==false and proxy:IsAlive( 903 )==false and proxy:IsAlive( 904 )==false then
		proxy:SetEventFlag(110,true);--��bON
		proxy:SetEventFlag(20080,0);
		proxy:EnableLogic(900, false);--NPC�v�l��~
	end
]]	
	print("OnEvent_12 end 3");
end


--------------------------------------------------------------------------------------
--���s�l�E������13		��ValueBuffer	20082�g�p
--------------------------------------------------------------------------------------
function OnEvent_13(proxy,param)
	Luafunc_DeadEne(proxy,param,13,20082,0);
end


--------------------------------------------------------------------------------------
--���s�l�E������14		��ValueBuffer	20082�g�p
--------------------------------------------------------------------------------------
function OnEvent_14(proxy,param)
	Luafunc_DeadEne(proxy,param,14,20082,0);
end


--------------------------------------------------------------------------------------
--���s�l�E������15		��ValueBuffer	20082�g�p
--------------------------------------------------------------------------------------
function OnEvent_15(proxy,param)
	Luafunc_DeadEne(proxy,param,15,20082,0);
end


--------------------------------------------------------------------------------------
--���s�l�E������15906		��ValueBuffer	20082�g�p
--------------------------------------------------------------------------------------
function OnEvent_15906(proxy,param)
	Luafunc_DeadEne(proxy,param,15906,20082,0);
end


--------------------------------------------------------------------------------------
--���s�l�E������15907		��ValueBuffer	20082�g�p
--------------------------------------------------------------------------------------
function OnEvent_15907(proxy,param)
	Luafunc_DeadEne(proxy,param,15907,20082,0);
end


--------------------------------------------------------------------------------------
--���s�l�E������15908		��ValueBuffer	20082�g�p
--------------------------------------------------------------------------------------
function OnEvent_15908(proxy,param)
	Luafunc_DeadEne(proxy,param,15908,20082,0);
end


--------------------------------------------------------------------------------------
--���s�l�E������15909		��ValueBuffer	20082�g�p
--------------------------------------------------------------------------------------
function OnEvent_15909(proxy,param)
	Luafunc_DeadEne(proxy,param,15909,20082,0);
end


--------------------------------------------------------------------------------------
--���s�l�E������15910		��ValueBuffer	20082�g�p
--------------------------------------------------------------------------------------
function OnEvent_15910(proxy,param)
	Luafunc_DeadEne(proxy,param,15910,20082,0);
end


--------------------------------------------------------------------------------------
--���s�l�E������15911		��ValueBuffer	20082�g�p
--------------------------------------------------------------------------------------
function OnEvent_15911(proxy,param)
	Luafunc_DeadEne(proxy,param,15911,20082,0);
end


--------------------------------------------------------------------------------------
--���s�l�E������15912		��ValueBuffer	20082�g�p
--------------------------------------------------------------------------------------
function OnEvent_15912(proxy,param)
	Luafunc_DeadEne(proxy,param,15912,20082,0);
end


--------------------------------------------------------------------------------------
--���s�l�E������15929		��ValueBuffer	20082�g�p
--------------------------------------------------------------------------------------
function OnEvent_15929(proxy,param)
	Luafunc_DeadEne(proxy,param,15929,20082,0);
end


--------------------------------------------------------------------------------------
--���s�l�E������15930		��ValueBuffer	20082�g�p
--------------------------------------------------------------------------------------
function OnEvent_15930(proxy,param)
	Luafunc_DeadEne(proxy,param,15930,20082,0);
end


--------------------------------------------------------------------------------------
--NPC�̕��s�l�ɑ΂���Ď���
--------------------------------------------------------------------------------------
function OnEvent_10_1(proxy,param)
	Luafunc_searchEne_in(proxy,param,10,902);
end

function OnEvent_10_2(proxy,param)
	Luafunc_searchEne_out(proxy,param,10,902);
end

--------------------------------------------------------------------------------------
--NPC�̕��s�l�ɑ΂���Ď���
--------------------------------------------------------------------------------------
function OnEvent_11_1(proxy,param)
	Luafunc_searchEne_in(proxy,param,11,903);
end

function OnEvent_11_2(proxy,param)
	Luafunc_searchEne_out(proxy,param,11,903);
end

--------------------------------------------------------------------------------------
--NPC�̕��s�l�ɑ΂���Ď���
--------------------------------------------------------------------------------------
function OnEvent_12_1(proxy,param)
	Luafunc_searchEne_in(proxy,param,12,904);
end

function OnEvent_12_2(proxy,param)
	Luafunc_searchEne_out(proxy,param,12,904);
end

--------------------------------------------------------------------------------------
--NPC�̕��s�l�ɑ΂���Ď���
--------------------------------------------------------------------------------------
function OnEvent_13_1(proxy,param)
	Luafunc_searchEne_in(proxy,param,13,905);
end

function OnEvent_13_2(proxy,param)
	Luafunc_searchEne_out(proxy,param,13,905);
end

--------------------------------------------------------------------------------------
--NPC�̕��s�l�ɑ΂���Ď���
--------------------------------------------------------------------------------------
function OnEvent_14_1(proxy,param)
	Luafunc_searchEne_in(proxy,param,14,906);
end

function OnEvent_14_2(proxy,param)
	Luafunc_searchEne_out(proxy,param,14,906);
end

--------------------------------------------------------------------------------------
--NPC�̕��s�l�ɑ΂���Ď���
--------------------------------------------------------------------------------------
function OnEvent_15_1(proxy,param)
	Luafunc_searchEne_in(proxy,param,15,911);
end

function OnEvent_15_2(proxy,param)	
	Luafunc_searchEne_out(proxy,param,15,911);
end

--------------------------------------------------------------------------------------
--�R�m�̎��S��5113
--------------------------------------------------------------------------------------
function OnEvent_5113(proxy,param)
	if proxy:IsCompleteEvent(5113) == true then
		return;
	end
	print("OnEvent_5113 begin");	
	--�R�m���񂾃t���OON
	proxy:SetEventFlag(5113,true);	
	--�A�C�e��������Ă���
	if proxy:IsCompleteEvent(12791) == true then
		
	--�A�C�e��������ĂȂ�
	else		
		--��b�����[�v����̂Ńt���O��OFF
		proxy:SetEventFlag(10000,false);
	end
	
	print("OnEvent_5113 end");
end


--------------------------------------------------------------------------------------
--�m���̉�b��OnEvent_150  ��ValueBuffer 20090�g�p
--------------------------------------------------------------------------------------
--���A�N�V�����{�^�����聡
function OnEvent_150(proxy,param)	
	print("OnEvent_150 begin");
	local FlagValue = proxy:IsCompleteEventValue(20090);
	--�m���Ƙb�����t���OON							
	--���ɂ��̉�b�𕷂��ĂȂ�
	if proxy:IsCompleteEvent(14295) == false then
		--�R�m���E���Ė���
		if proxy:IsCompleteEvent(5113) == false then
			--�A�C�e��������ĂȂ�
			if proxy:IsCompleteEvent(12791) == false then
			
				if FlagValue == 0 then proxy:SetEventFlag(20090,1);	end
				if FlagValue == 1 then proxy:SetEventFlag(20090,2);	end
				if FlagValue == 2 then proxy:SetEventFlag(20090,3);	end
				if FlagValue == 3 then 
					proxy:SetEventFlag(20090,0);
					proxy:SetEventFlag(14295,true);				
				end
			--�A�C�e��������Ă���
			else
				if FlagValue == 0 then proxy:SetEventFlag(20090,1);	end
				if FlagValue == 1 then proxy:SetEventFlag(20090,2);	end
				if FlagValue == 2 then proxy:SetEventFlag(20090,3);	end
				if FlagValue == 3 then proxy:SetEventFlag(20090,4);	end
				if FlagValue == 4 then 	
					Luafunc_StageClear(proxy,param,150);					
				end	
			end
		--�R�m���E���Ă�
		else
			--�A�C�e��������ĂȂ�
			if proxy:IsCompleteEvent(12791) == false then
				if proxy:IsCompleteEvent(10000) == false then
					if FlagValue == 0 then proxy:SetEventFlag(20090,1);	end
					if FlagValue == 1 then proxy:SetEventFlag(20090,2);	end
					if FlagValue == 2 then proxy:SetEventFlag(20090,3);	end
					if FlagValue == 3 then
						proxy:SetEventFlag(20090,0);
						proxy:SetEventFlag(10000,true);
						proxy:SetEventFlag(14295,true);				
					end
				else
					if FlagValue == 0 then proxy:SetEventFlag(20090,1);	end
					if FlagValue == 1 then proxy:SetEventFlag(20090,2);	end
					if FlagValue == 2 then
						proxy:SetEventFlag(20090,0);
						proxy:SetEventFlag(14295,true);				
					end
				end
			--�A�C�e��������Ă���
			else
				if FlagValue == 0 then proxy:SetEventFlag(20090,1);	end
				if FlagValue == 1 then proxy:SetEventFlag(20090,2);	end
				if FlagValue == 2 then proxy:SetEventFlag(20090,3);	end
				if FlagValue == 3 then proxy:SetEventFlag(20090,4);	end
				if FlagValue == 4 then					
					Luafunc_StageClear(proxy,param,150);	
					proxy:SetEventFlag(20090,0);
				end
			end
		end
	--��b�𕷂��Ă���
	else
		--�R�m���E���ĂȂ�
		if proxy:IsCompleteEvent(5113) == false then
			--�A�C�e��������ĂȂ�
			if proxy:IsCompleteEvent(12791) == false then
				if FlagValue == 0 then proxy:SetEventFlag(20090,1);	end
				if FlagValue == 1 then proxy:SetEventFlag(20090,2);	end	
				if FlagValue == 2 then proxy:SetEventFlag(20090,0);	end	
			--�A�C�e��������Ă���
			else
				if FlagValue == 0 then proxy:SetEventFlag(20090,1);	end
				if FlagValue == 1 then proxy:SetEventFlag(20090,2);	end
				if FlagValue == 2 then proxy:SetEventFlag(20090,3);	end
				if FlagValue == 3 then proxy:SetEventFlag(20090,4);	end
				if FlagValue == 4 then					
					Luafunc_StageClear(proxy,param,150);
					proxy:SetEventFlag(20090,0);
				end
			end
		--�R�m���E���Ă���
		else
			--�A�C�e��������ĂȂ�
			if proxy:IsCompleteEvent(12791) == false then
				if proxy:IsCompleteEvent(10000) == false then
					if FlagValue == 0 then proxy:SetEventFlag(20090,1);	end
					if FlagValue == 1 then proxy:SetEventFlag(20090,2);	end
					if FlagValue == 2 then proxy:SetEventFlag(20090,3);	end
					if FlagValue == 3 then
						proxy:SetEventFlag(20090,0);
						proxy:SetEventFlag(10000,true);
					end
				else
					if FlagValue == 0 then proxy:SetEventFlag(20090,1);	end
					if FlagValue == 1 then proxy:SetEventFlag(20090,2);	end
					if FlagValue == 2 then proxy:SetEventFlag(20090,0);	end
				end			
			--�A�C�e��������Ă���
			else
				if FlagValue == 0 then proxy:SetEventFlag(20090,1);	end
				if FlagValue == 1 then proxy:SetEventFlag(20090,2);	end
				if FlagValue == 2 then proxy:SetEventFlag(20090,3);	end
				if FlagValue == 3 then proxy:SetEventFlag(20090,4);	end
				if FlagValue == 4 then					
					Luafunc_StageClear(proxy,param,150);
					proxy:SetEventFlag(20090,0);
				end
			end
		end
	end
	print("OnEvent_150 end");
end

--�������聡
function OnEvent_150_1(proxy,param)
	--print("OnEvent_150_1 begin");
	local FlagValue = proxy:IsCompleteEventValue(20090);
	
	--��b�𕷂��Ă��Ȃ�
	if proxy:IsCompleteEvent(14295) == false then
		--�R�m���E���Ė���
		if proxy:IsCompleteEvent(5113) == false then
			--�A�C�e��������ĂȂ�
			if proxy:IsCompleteEvent(12791) == false then
				Luafunc_Talk(proxy,FlagValue,1,901,90000300,true);
				Luafunc_Talk(proxy,FlagValue,2,901,90000301,true);
				Luafunc_Talk(proxy,FlagValue,3,901,90000302,false);
			--�A�C�e��������Ă���
			else
				Luafunc_Talk(proxy,FlagValue,1,901,90000303,true);
				Luafunc_Talk(proxy,FlagValue,2,901,90000307,true);
				Luafunc_Talk(proxy,FlagValue,3,901,90000305,true);
				Luafunc_Talk(proxy,FlagValue,4,901,90000306,false);
			end
		--�R�m���E���Ă�
		else
			--�A�C�e��������ĂȂ�
			if proxy:IsCompleteEvent(12791) == false then
				if proxy:IsCompleteEvent(10000) == false then
					Luafunc_Talk(proxy,FlagValue,1,901,90000308,true);
					Luafunc_Talk(proxy,FlagValue,2,901,90000310,true);
					Luafunc_Talk(proxy,FlagValue,3,901,90000302,false);
				else
					Luafunc_Talk(proxy,FlagValue,1,901,90000310,true);
					Luafunc_Talk(proxy,FlagValue,2,901,90000302,false);
				end
			--�A�C�e��������Ă���
			else
				Luafunc_Talk(proxy,FlagValue,1,901,90000309,true);
				Luafunc_Talk(proxy,FlagValue,2,901,90000307,true);
				Luafunc_Talk(proxy,FlagValue,3,901,90000305,true);
				Luafunc_Talk(proxy,FlagValue,4,901,90000306,false);		
			end
		end
	--��b�𕷂��Ă���
	else
		--�R�m���E���ĂȂ�
		if proxy:IsCompleteEvent(5113) == false then
			--�A�C�e��������ĂȂ�
			if proxy:IsCompleteEvent(12791) == false then
				Luafunc_Talk(proxy,FlagValue,1,901,90000301,true);
				Luafunc_Talk(proxy,FlagValue,2,901,90000302,false);					
			--�A�C�e��������Ă���
			else
				Luafunc_Talk(proxy,FlagValue,1,901,90000303,true);
				Luafunc_Talk(proxy,FlagValue,2,901,90000304,true);
				Luafunc_Talk(proxy,FlagValue,3,901,90000305,true);
				Luafunc_Talk(proxy,FlagValue,4,901,90000306,false);
			end
		--�R�m���E���Ă���
		else
			--�A�C�e��������ĂȂ�
			if proxy:IsCompleteEvent(12791) == false then				
				if proxy:IsCompleteEvent(10000) == false then
					Luafunc_Talk(proxy,FlagValue,1,901,90000308,true);
					Luafunc_Talk(proxy,FlagValue,2,901,90000310,true);
					Luafunc_Talk(proxy,FlagValue,3,901,90000302,false);
				else
					Luafunc_Talk(proxy,FlagValue,1,901,90000310,true);
					Luafunc_Talk(proxy,FlagValue,2,901,90000302,false);
				end;
				
			--�A�C�e��������Ă���
			else
				Luafunc_Talk(proxy,FlagValue,1,901,90000303,true);
				Luafunc_Talk(proxy,FlagValue,2,901,90000304,true);
				Luafunc_Talk(proxy,FlagValue,3,901,90000305,true);
				Luafunc_Talk(proxy,FlagValue,4,901,90000306,false);		
			end
		end
	end
	--print("OnEvent_150_1 end");
end

--�������O���聡
function OnEvent_150_2(proxy,param)
	print("OnEvent_150_2 begin");
	--���ꂽ��y�[�W��߂�
	local FlagValue = proxy:IsCompleteEventValue(20090);
	if FlagValue >= 1 then
		proxy:SetEventFlag(20090,0);
	end
	
	print("OnEvent_150_2 end");
end



--------------------------------------------------------------------------------------
--�R�m���K��
--------------------------------------------------------------------------------------
function OnEvent_180(proxy,param)
	if proxy:IsCompleteEvent(180) == true then
		return;
	end	
	if proxy:IsPlayerStay(920) == false then
		proxy:SetEventFlag(180,true);
		return;
	end
	
	if proxy:IsAlive(920) == false then
		proxy:SetEventFlag(180,true);
		return;
	end
	print("OnEvent_180 begin");
	proxy:PlayAnimation(920,9010);
	print("�R�m���K�I");
	proxy:SetEventFlag(180,true);
	print("OnEvent_180 end");
end


--------------------------------------------------------------------------------------
--�e���v����
--------------------------------------------------------------------------------------
--~ function OnEvent_12790(proxy,param)
--~ 	print("OnEvent_12790 begin");
--~ 	print("OnEvent_12790 end");
--~ end

--��Lua��`�֐����G�̎��S�̊Ď���
function Luafunc_DeadEne(proxy,param,nEventID,ValueBuffer,nTargetID)
	print("OnEvent_" ,nEventID," begin");
	
	--���ɏI�����Ă���C�x���g
	if proxy:IsCompleteEvent(nEventID) == true then
		print("OnEvent_" ,nEventID," end");
		proxy:DeleteEvent( nEventID );
		return false;
	end
	
	--���̃C�x���g���I��
	proxy:SetEventFlag(nEventID,true);
	print("OnEvent_" ,nEventID," end");
	return true;
end

--��Lua��`�֐����G�̊Ď���(�G���͈͓��ɓ������Ƃ�)
function Luafunc_searchEne_in(proxy,param,nEventID,nTargetID)

--[[
	print("OnEvent_" ,nEventID," begin");
	
	--�Ώۂ�����ł����珈�����Ȃ�
	if proxy:IsAlive(nTargetID) == false then
		print("OnEvent_" ,nEventID," end");
		return;
	end
	
	--�ΏۃC�x���g���I�����Ă����珈�����Ȃ�
	if proxy:IsCompleteEvent(nEventID) == true then
		print("OnEvent_" ,nEventID," end");
		return;
	end

	proxy:SetEventFlag(110,false);	--��bOFF
	proxy:SetEventFlag(20080,99);	--��b�p�̒l���Z�b�g
	proxy:EnableLogic(900, true);	--NPC�v�lON
	
	print("OnEvent_" ,nEventID," end");
]]

end

--��Lua��`�֐����G�̊Ď���(�G���͈͓��ɓ��������Ƃł��Ƃ�)
function Luafunc_searchEne_out(proxy,param,nEventID,nTargetID)

--[[
	print("OnEvent_" ,nEventID," begin");
	
	--�Ώۂ̓G3�C������ł����Ƃ���bON & NPC�v�lOFF
	--(���̏����ł͋Ǐ��I������BNPC����݂āA�G���͈͓��ɂ��Ȃ��Ƃ��ɐ؂�ւ���ׂ�)
	--(3�C�̂����ꂩ�������Ă���Ƃ��ɁA�Ⴄ�G����Ă���ƁA)
	--(��u��b��ON�ɂȂ�A�A�N�V���������\������Ă��܂�)
	
	if proxy:IsAlive( 902 )==false and proxy:IsAlive( 903 )==false and proxy:IsAlive( 904 )==false then
		proxy:SetEventFlag(110,true);--��bON
		proxy:SetEventFlag(20080,0);
		proxy:EnableLogic(900, false);--NPC�v�l��~
	end

	print("OnEvent_" ,nEventID," end");
]]

end


--��Lua��`�֐����}�b�v�N���A��
function Luafunc_StageClear(proxy,param,nEventID)
	proxy:DeleteEvent(nEventID);
	--PT��g��ł��邩�H
	if proxy:IsInParty() == true then
		--�z�X�g��������
		if proxy:IsHost() == true then
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2(3000,"HostStageClear",2.0,0,0,once);				
			proxy:NotNetMessage_end();
		else
			return;
		end
	else		
		proxy:OnKeyTime2(3000,"HostStageClear",2.0,0,0,once);
	end	
end


--��Lua��`�֐���10����b�p��
function Luafunc_Talk(proxy,nVal,nVal2,nTargetID,TalkID,bPage)
	if nVal == nVal2 then
		proxy:StartTalk(TalkID,bPage);
		proxy:PlayAnimation(nTargetID,6500);
	end
end





function Check(proxy,param)
	--���W�X�g�͖��t���[���ʂ邩��m�F��ꂽ��R�����g�A�E�g���Ă��Č������Ǝv���񂾂��ǁH
	--print("Check");
	
	check_npc_id = 900;
	
	if proxy:IsCompleteEvent( 121 ) == true then --NPC�̎��S�Ď��C�x���g���I����Ă���
		print("npc(id:900) is dead");
		print("return false and delete event 12345");
		proxy:DeleteEvent( 12345 );
		return false;
	end
	
	check_distance = 5.0;
	
	check_enemy_id_list       = { 902 , 903 , 904 , 905 , 906 , 911 };
	check_enemy_event_id_list = { 10 , 11 , 12 , 13 , 14 , 15 };
	num = table.getn( check_enemy_id_list );
	
	for i=1, num, 1 do
	
		now_check_enemy_id       = check_enemy_id_list[i];
		now_check_enemy_event_id = check_enemy_event_id_list[i];
		
		if proxy:IsCompleteEvent( now_check_enemy_event_id ) == false then
			
			--print( "now check enemy(id:"..now_check_enemy_id..")" );
			
			if proxy:IsDistance( check_npc_id , now_check_enemy_id , check_distance ) == true then

				--print( "found enemy(id:"..now_check_enemy_id..")" );
				--print( "return true" );
				return true;
			
			end
		end
	end


	if proxy:IsCompleteEventValue( 20080 ) == 99 then

		proxy:SendEventRequest( 900 , 0,AI_EVENT_None );--�������Ȃ��悤�ɂ��肢����B
		proxy:EnableLogic( 900 , false );--�l����̂���߂�B
		
		proxy:SetEventFlag(110 , true);--��b��L���ɂ���
		proxy:SetEventFlag(20080,0);--��b�p�̒l���Z�b�g(�e�L�X�g�̕\���p)

	end

	--������
	--print( "return false" );
	return false;
end



function OnEvent_12345(proxy,param)
	--print("OnEvent_12345 begin");

	proxy:EnableLogic( 900 , true );
	proxy:SetEventFlag(110,false);
	proxy:SetEventFlag(20080,99);	--��b�p�̒l���Z�b�g
		
	--print("OnEvent_12345 end");
end



--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m03_01_00_99(proxy, param)
	print("PlayerDeath_m03_01_00_99");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m03_01_00_99);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerDeath_m03_01_00_99");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m03_01_00_99(proxy,param)
	print("PlayerRevive_m03_01_00_99");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m03_01_00_99);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerRevive_m03_01_00_99");
end


