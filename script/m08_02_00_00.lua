once = 1;
everytime = 0;

--------------------------------------------------------------------------------------
--������
--------------------------------------------------------------------------------------
function Initialize_m08_02_00_00(proxy)
print("Initialize m08_02_00_00 begin");


--��14337���`���[�g���A�����S��
	proxy:SetEventFlag(14337,true);--�n��p���S����t���OON

--��20���h���f�[�����ɎE�����@��������
	--proxy:OnRegionJustIn( 14345 , 10000 , 2410 , "OnEvent_14345" , everytime );--everytime
	
--��14350���h���f�[�����ɎE�����A���E����遡
	proxy:OnRegionJustIn( 14350 , 10000 , 2412 , "OnEvent_14350" , once );
	
	--�|�����J�n�t�F�[�h��ɌĂ΂��n���h��
	proxy:LuaCall(14350,REMO_START,"OnEvent_14350_RemoStart",once);
	--�|�����I����ɌĂ΂��n���h��
	proxy:LuaCall(14350,REMO_FINISH,"OnEvent_14350_RemoFinish",once);
		

--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m08_02_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m08_02_00_00", everytime );
	proxy:NotNetMessage_end();
	
	
--��999912���t���[���x��̏����������C�x���g�𔭍s��
	proxy:NotNetMessage_begin();
		--��0�b�づ--
		proxy:OnKeyTime2( 999912, "Second_Initialize_m08_02_00_00", 0.1, 0, 0, once );	
	proxy:NotNetMessage_end();

	proxy:SetEventFlag(4000,false);


--proxy:LuaCall( 1111 , 1 , "test" , everytime );

	
print("Initialize m08_02_00_00 end");
end

--[[
function test(proxy, param)
print("force dead");
	proxy:SetDeadMode( 10000 , false );
	proxy:ForceDead( 10000 );
end
]]



--------------------------------------------------------------------------------------
--�}���`�ɂȂ������Ƀz�X�g���ᖳ�������灡����
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end



--------------------------------------------------------------------------------------
--Initialize����Ă΂��A1�t���[���x��̏�����������999999
--------------------------------------------------------------------------------------
--��999912����������
function Second_Initialize_m08_02_00_00(proxy, param)
	print("Second_Initialize_m08_02_00_00 begin");

--	proxy:PlayerRecover();--�v���C���[�S��
--	proxy:SetHp( 10000 , 1.0 );
--	proxy:SetDeadMode( 10000 , true );--�v���C���[���ȂȂ�
	
	print("Second_Initialize_m08_02_00_00 end");
end



--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m08_02_00_00(proxy, param)
	print("PlayerDeath_m08_02_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m08_02_00_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerDeath_m08_02_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m08_02_00_00(proxy,param)
	print("PlayerRevive_m08_02_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m08_02_00_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerRevive_m08_02_00_00");
end




--[[
--------------------------------------------------------------------------------------
--�h���f�[�����ɎE�����@(����)��20
--------------------------------------------------------------------------------------
function OnEvent_14345(proxy,param)
	print("OnEvent_14345 begin");	
	proxy:PlayLoopAnimation( 599 , 990021 );--�ҋ@�A�j�����[�v�Đ�
	proxy:SetEventFlag(14345,true);
	print("OnEvent_14345 end");
end
]]

--------------------------------------------------------------------------------------
--�h���f�[�����ɎE�����A(�E�����)��14350 �����̂Ƃ��悤
--------------------------------------------------------------------------------------
function OnEvent_14350(proxy,param)
	print("OnEvent_14350 begin");
	
	proxy:RequestRemo( 80200 , REMO_FLAG, 14350 , 1);

	print("OnEvent_14350 end");
end

	
	

--���U���A�j���@�̏I����
function OnEvent_14350_RemoStart(proxy,param)
	print("OnEvent_14350_RemoStart begin");
	print("OnEvent_14350_RemoStart end");
end



--[[
--���U���A�j���A�̏I����
function OnEvent_14350_2(proxy,param)	
	proxy:PlayAnimation( 599 , 990024 );--�U���A�j���B�̍Đ�	
end
]]

--�����b�Z�[�W�������܂ł̎��Ԃ��󂯂遣
function OnEvent_14350_RemoFinish(proxy,param)	
	print("OnEvent_14350_RemoFinish begin");	
	--�C���t�H���[�V�������b�Z�[�W�̕\��
	--Display_InfomationMenu_2(proxy, 0, -1, 30, 89999999, 1, -1, 30, 88999901, 6);
	--Lua_PauseTutorial(proxy);
	proxy:SetTextEffect(TEXT_TYPE_Dead);
	InvalidCharactor( proxy,10000);
	
	--���`���[�g���A���I���܂ł̎��Ԃ��󂯂遥
	proxy:OnKeyTime2( 14381 , "OnEvent_14381_1" , 3.0 , 0 , 2 , once );	
	print("OnEvent_14350_RemoFinish end");
end


--���`���[�g���A���I���܂ł̎��Ԃ��󂯂遣
function OnEvent_14381_1(proxy,param)	
	print("OnEvent_14381_1 begin");	
	proxy:OnRegistFunc( 14381 , "Check_14381","OnEvent_14381_2",1,once);	
	print("OnEvent_14381_1 end");
end

function Check_14381(proxy)
	if proxy:IsShowMenu() == true then
		return false;
	end
	return true;
end

function OnEvent_14381_2(proxy,param)
	print("OnEvent_14381_2 begin");
	proxy:OnKeyTime2( 14381 , "OnEvent_14381_3",1.0,0,0,once);
	print("OnEvent_14381_2 end");
end


--�Β��ւ̃��[�v
function OnEvent_14381_3(proxy,param)
	print("OnEvent_14381_3 begin");
	proxy:SetEventFlag( 14381 , 1 );--���̃C�x���g�̃t���OON
	proxy:SetEventFlag( 14337 , 0 );--�`���[�g���A�����S�t���OOFF
	proxy:SetEventFlag( 4000 , 0 );--�v���C���[���S�t���OOFF
	
	proxy:RevivePlayer();
	
	--�`���[�g���A���}�b�v3�ł̓}�b�v�J�n������K���O���C�S�[�X�g�ɂȂ�K�v������B
	--���̃^�C�~���O�ŃO���C�S�[�X�g�ɕς���Ă����΁A�K�v�ȏ������O���[�o���̏�����
	--�s���Ă����B(=���K�̃O���C�S�[�X�g�ɂȂ��)
	proxy:ChangeGreyGhost();
	
	proxy:Tutorial_end();
	--�Β��̓�����Ƀ��[�v
	--���S�񕜗v��
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1,0,0,0,-1);
	print("OnEvent_14381_3 end");
end



--����Z�b�V�����̊J�n�@�i���j
--SOS���@�������������Ƃ��āA1��ڂ������玗��Z�b�V�����J�n
--�`���[�g���A���̏ꍇ��m08_02��SOS�������Ζ���Ă΂��
function OnEvent_Catch_SOS(proxy,param)	

--[[�������Ȃ��Ȃ����̂ł����܂���]]

end


--��3�b�っ
function OnEvent_Catch_SOS_2(proxy,param)	
	
	--���҈ʒu�Ƀ��[�v�t���O��ON
	proxy:SetSummonedPos();
	--�`���[�g���A�����҈ʒu���L������悤�ɐݒ�
	proxy:SetTutorialSummonedPos();
	--������������SOS�Y�p
	proxy:InvalidMyBloodMarkInfo();
	
	--���[�f�B���O
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage( 8,02,00,00, 30); end
	if playerId ==1 then proxy:WarpNextStage( 8,02,00,00, 31); end
	if playerId ==2 then proxy:WarpNextStage( 8,02,00,00, 32); end
	if playerId ==3 then proxy:WarpNextStage( 8,02,00,00, 33); end
end


--��3�b��>�������̈�i1420�j�ɓ�������
function OnEvent_BlackGhost(proxy,param)
	print("OnEvent_BlackGhost begin");
	proxy:OnKeyTime2(14390,"OnEvent_BlackGhost_1",1,0,0,once);
	proxy:EnableLogic(500,false);
	print("OnEvent_BlackGhost end");
end

--1�b��
function OnEvent_BlackGhost_1(proxy,param)
	proxy:SetChrType( 501 , CHR_TYPE_BlackGhost ); --�u���b�N�S�[�X�g�ɂȂ��Ă���(ID501)
	--(�����͂Ȃ�Ȃ���������Ȃ�)
	proxy:EnableLogic(500,true);
	ValidCharactor(proxy, 501);--�u���b�N�S�[�X�g���̐l�o��
	--proxy:ForceChangeTarget(501,500);
	proxy:ResetThink(501);
	print( "draw npc id 501 " );
	
	--�C���t�H���[�V�������j���[
	proxy:InfomationMenu(0,-1,30,89200020,1);
	proxy:AddInfomationList(-1,30,86002000);
	proxy:AddInfomationList(-1,30,86002001);
	proxy:AddInfomationList(-1,30,86002002);
	proxy:AddInfomationList(-1,30,86002003);
	proxy:AddInfomationList(-1,30,86002004);
	proxy:AddInfomationList(-1,30,86002005);
	proxy:AddInfomationList(-1,30,86002006);	
	--�u���b�N�S�[�X�g���҂���܂���
end



--------------------------------------------------------------------------------------
--����Z�b�V�����̂Ƃ��̐����v���C���[���̐l�̎��S�Ď���
--------------------------------------------------------------------------------------
function OnEvent_NPC500_Dead( proxy,param )

	print( "npc 500 is dead" );
	
	--�����ŉ��U�����̃C���t�H���j���[
	proxy:OnKeyTime2(4000,"m08_02Death_2",4,0,0,once);
	--[[
	--���U�̏���
	
	--NPC������(����Z�b�V������1�񂵂��ł��Ȃ����Ƃ��O��)
	InvalidCharactor(proxy, 500);--�����v���C���[��
	InvalidCharactor(proxy, 501);--�u���b�N�S�[�X�g��
	
	
	--�e�X�g�p
	proxy:SetChrType( 10000 , CHR_TYPE_GreyGhost );
	proxy:WarpRestart( 10000 , 75 );--������̋߂��ɂ���̈�ɂƂ�
	proxy:SetHp( 10000 , 1.0 );
	proxy:DisableMove( 10000 , false );
	]]
end


--------------------------------------------------------------------------------------
--SOS������14355 
--------------------------------------------------------------------------------------
function OnEvent_14355(proxy,param)
	print("OnEvent_14355 begin");
	--�C���t�H���[�V�������j���[�\��
	proxy:InfomationMenu(0,-1,30,89200000,1);
	proxy:AddInfomationList(-1,30,86000000);
	proxy:AddInfomationList(-1,30,86000001);
	proxy:AddInfomationList(-1,30,86000002);
	proxy:AddInfomationList(-1,30,86000003);
	proxy:AddInfomationList(-1,30,86000004);
	proxy:AddInfomationList(-1,30,86000005);
	proxy:AddInfomationList(-1,30,86000006);
	print("OnEvent_14355 end");
end


--------------------------------------------------------------------------------------
--PC��������������14360 
--------------------------------------------------------------------------------------
function OnEvent_14360(proxy,param)
	print("OnEvent_14360 begin");
	--�C���t�H���[�V�������j���[�\��
	proxy:InfomationMenu(0,-1,30,89200010,1);
	proxy:AddInfomationList(-1,30,86001000);
	proxy:AddInfomationList(-1,30,86001001);
	proxy:AddInfomationList(-1,30,86001002);
	proxy:AddInfomationList(-1,30,86001003);
	proxy:AddInfomationList(-1,30,86001004);
	proxy:AddInfomationList(-1,30,86001005);
	proxy:AddInfomationList(-1,30,86001006);
	proxy:AddInfomationList(-1,30,86001007);
	proxy:AddInfomationList(-1,30,86001008);
	proxy:AddInfomationList(-1,30,86001009);
	proxy:AddInfomationList(-1,30,86001010);
	proxy:AddInfomationList(-1,30,86001011);
	proxy:AddInfomationList(-1,30,86001012);
	proxy:AddInfomationList(-1,30,86001013);
	
	print("OnEvent_14360 end");
end

--------------------------------------------------------------------------------------
--�}���`���U������14370 
--------------------------------------------------------------------------------------
function OnEvent_14370(proxy,param)
	print("OnEvent_14370 begin");
	--�C���t�H���[�V�������j���[�\��
	proxy:InfomationMenu(0,-1,30,89200030,1);
	proxy:AddInfomationList(-1,30,86003000);
	proxy:AddInfomationList(-1,30,86003001);
	proxy:AddInfomationList(-1,30,86003002);
	proxy:AddInfomationList(-1,30,86003003);
	proxy:AddInfomationList(-1,30,86003004);
	proxy:AddInfomationList(-1,30,86003005);
	proxy:AddInfomationList(-1,30,86003006);
	print("OnEvent_14370 end");
end


--------------------------------------------------------------------------------------
--SOS�����̈�Ď���
--------------------------------------------------------------------------------------
function OnEvent_14410(proxy,param)
	print("OnEvent_14410 begin");
	--SOS�����p�t���OON
	proxy:SetEventFlag(14410,true);
	print("OnEvent_14410 end");	
end


--------------------------------------------------------------------------------------
--�`���[�g���A�����S�����̗��ꁡ�O���[�o�����番�򂵂Ă��܂�
--------------------------------------------------------------------------------------
function m08_02Death(proxy,param)
	print("m08_02Death begin");
	
--[[	
	
	--�P��ڐ������O���C�ւ̎��S
	if proxy:GetLocalPlayerChrType() == CHR_TYPE_LivePlayer then
		--�h���ҋ@�t���OOFF
		proxy:SetEventFlag(14345,false);
		proxy:OnKeyTime2(4000,"m08_02Death_1",1.5,0,0,once);
	end	
	
	--�Q��ڃz���C�g���O���C�ւ̎��S
	if proxy:GetLocalPlayerChrType() == CHR_TYPE_WhiteGhost then
		proxy:OnKeyTime2(4000,"m08_02Death_2",1.5,0,0,once);		
	end
]]	
--[[
	proxy:NotNetMessage_begin();
	--�R��ڃO���C���g�D���[�f�X�ւ̎��S
	if proxy:GetLocalPlayerChrType() == CHR_TYPE_GreyGhost then
		proxy:OnKeyTime2(4000,"m08_02Death_3",1.5,0,0,once);				
	end
	
	proxy:NotNetMessage_end();
]]
	proxy:SetEventFlag(4000,true);	

	print("m08_02Death end");
end

--1��ڂ̎��S
function m08_02Death_1(proxy,param)
	print("m08_02Death_1 begin");
	proxy:OnBloodMenuClose(4000,"m08_02Death_1_1",300.0, once);
	print("m08_02Death_1 end");
end

--1��ڂ̎��S�F���������͑҂�
function m08_02Death_1_1(proxy,param)
	print("m08_02Death_1_1 begin");
	proxy:SetMapUid( 8, 2, 0, 0, -1 );		
	--�O���C�S�[�X�g��
	proxy:ChangeGreyGhost();
	proxy:SetHp( 10000, 1 );
	--���S�󋵔���p
	proxy:SetEventFlag(14351,true);	
	proxy:OnKeyTime2(4000,"m08_02Death_Load",0.1,0,10,once);	
	print("m08_02Death_1_1 end");
end


--�Q��ڂ̎��S
function m08_02Death_2(proxy,param)
	print("m08_02Death_2 begin");
	proxy:SetMapUid( 8, 2, 0, 0, -1 );		
	--�O���C�S�[�X�g��
	proxy:ChangeGreyGhost();
	proxy:SetHp( 10000, 1 );
	--���҈ʒu�ɍďo��
	proxy:SetSummonedPos();
	proxy:OnKeyTime2(4000,"m08_02Death_Load",0.1,0,10,once);
	--�z���C�g�S�[�X�g�Ŏ��񂾃t���OON
	proxy:SetEventFlag(14380,true);
	
	print("m08_02Death_2 end");
end

--�R��ڂ̎��S
function m08_02Death_3(proxy,param)
	print("m08_02Death_3 begin");
	--�v���C���[����
	proxy:RevivePlayer();
	proxy:ReturnMapSelect();	
	print("m08_02Death_3 end");
end

--���S��̃��[�f�B���O
function m08_02Death_Load(proxy,param)
	print("m08_02Death_Load begin");
	--���[�f�B���O
	--���[�v���s��
	proxy:WarpNextStageKick();
	print("m08_02Death_Load end");
end
