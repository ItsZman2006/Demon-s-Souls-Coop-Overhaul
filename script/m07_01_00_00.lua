
--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉����������
--------------------------------------------------------------------------------------
function Initialize_m07_01_00_00(proxy)
print("Initialize_m07_01_00_00 begin");

--��1�������яオ�鑫��A��
	if proxy:IsCompleteEvent(1) ==false then
	--��OBJ(1000)���j�󂳂ꂽ����--
		proxy:OnObjectDestroy( 1, 1000, "OnEvent_1", once );
	else
		proxy:ReconstructBreak( 1000 , 1 );
	end
	
		
--��11�������яオ�鑫��B��
	if proxy:IsCompleteEvent(11) ==false then
	--��OBJ(1001)���j�󂳂ꂽ����--
		proxy:OnObjectDestroy( 11, 1001, "OnEvent_11", once );
		--proxy:OnPlayerDistanceInTarget( 11, 10000, 1006, "OnEvent_11", 3.0, once );
	else
		proxy:ReconstructBreak( 1001 , 1 );
	end


--��12�������яオ�鑫��C��
	if proxy:IsCompleteEvent(12) ==false then
	--�����A�[�R�[����--
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 12, 1, "OnEvent_12", once );
		proxy:NotNetMessage_end();
	end
	
--[[ �I�u�W�F(��)���܂��Ȃ��̂ŁA�R�����g�A�E�g

--��120�����{�X�����ւ̔����J����
	if proxy:IsCompleteEvent( 120 ) == false then
		proxy:OnDistanceActionPlus( 120, 10000, 1120, "OnEvent_120", DoorDist_A, HELPID_OPEN, 90, DoorAngle_A, -0.3, 0.0, 2.0, once );
	else
		proxy:EndAnimation( 1120, 1 );--�����J���A�j�����I��
	end
]]	
	

--��6656�����{�X���S�ŉ������N���遡
	--��OBJ(812)�����ɁA���S�A�j���[�V�������Đ����I���������--
	if proxy:IsCompleteEvent(6656) ==false then
		proxy:OnCharacterDead( 6656, 812, "OnEvent_6656", once );
	else
		proxy:EndAnimation( 1004, 1 );--�_�~�[���o�[�A�j��
	end

	
--�󎀑̂̓C�x���g�������ɔz�M���Ȃ��B�A�j���̂ݕʂœ���������B
proxy:NotNetMessage_begin();

--��13568���󎀑�A��
	--��PC���|�C���g(1005)�ɑ΂��Ĕ����p�x(ItemBoxAngle_A)�A����(ItemBoxDist_A)�ŃA�N�V�����{�^����������--
	if proxy:IsCompleteEvent(13568) ==false then
		proxy:OnDistanceAction( 13568, 10000, 1005, "OnEvent_13568", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );		
		proxy:TreasureDispModeChange( 1005, true );
	end
	
--��13569���󎀑�B��
	--��PC���|�C���g(1006)�ɑ΂��Ĕ����p�x(ItemBoxAngle_A)�A����(ItemBoxDist_A)�ŃA�N�V�����{�^����������--
	if proxy:IsCompleteEvent(13569) ==false then
		proxy:OnDistanceAction( 13569, 10000, 1006, "OnEvent_13569", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );		
		proxy:TreasureDispModeChange( 1006, true );
	end

proxy:NotNetMessage_end();
	
--��20-32���m�[�}������j��ňꕔ�̓G��������悤�ɂȂ遡
	
	first_action_id = 20;
	first_event_id  = 1007;
	dai_num         = 13;
	
	now_action_id   = first_action_id;
	now_event_id    = first_event_id;
	
	for i=1, dai_num, 1 do
		print( "add action_id " .. now_action_id );
		if proxy:IsCompleteEvent( now_action_id ) ==false then
			proxy:OnObjectDestroy( now_action_id, now_event_id, "OnEvent_"..now_action_id, once );
		else
			proxy:ReconstructBreak( now_event_id , 1 );
		end
		now_action_id = now_action_id + 1;
		now_event_id  = now_event_id  + 1;
	end
	
--��40-104���G���I�̎��S�Ď���

	enemy_num_of_dai        = 3;
	enemy_num_offset_of_dai = 2; 	--�\��
	dai_num                 = 13;
	enemy_num               = enemy_num_of_dai * dai_num;
	
	first_event_id          = 40;
	first_enemy_id          = 720;
	now_event_id            = first_event_id;
	now_enemy_id            = first_enemy_id;
	
	for i=1, dai_num, 1 do --冑�̐������J��Ԃ�
		for j=1, enemy_num_of_dai, 1 do --冑��ɑΉ�����G�̐������J��Ԃ�
			print("add enemy_id is " .. now_enemy_id );
			
			--�G��C���̎��S�Ď��C�x���g
			if proxy:IsCompleteEvent( now_event_id ) ==false then 
				proxy:OnCharacterDead( now_event_id, now_enemy_id, "OnEvent_"..now_event_id, once ); 
			end
			now_event_id = now_event_id + 1;
			now_enemy_id = now_enemy_id + 1;
		end
		now_event_id = now_event_id + enemy_num_offset_of_dai;
		now_enemy_id = now_enemy_id + enemy_num_offset_of_dai;
	end
	
	
--��110���Β��Ƀ��[�v��
	proxy:OnDistanceAction( 110, 10000, 1982, "OnEvent_110", WarpGimmickDist_A, HELPID_GO_TO_SEKITYUU, 0, 180, everytime );
	
	
--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m07_01_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m07_01_00_00", everytime );
	proxy:NotNetMessage_end();		

	
--���������^�C�~���O��
	proxy:NotNetMessage_begin();
		--��0�b�づ--
		proxy:OnKeyTime2( 999991, "Second_Initialize_m07_01_00_00", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
print("Initialize_m07_01_00_00 end");
end


--------------------------------------------------------------------------------------
--�}���`�ɂȂ������Ƀz�X�g���ᖳ�������灡����
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end

--�`��Ɠ�����𓯎��ɐ؂�ւ��p
function SetColiAndDraw( proxy, event_id, enable )
	print("SetColiAndDraw");
	proxy:SetColiEnable( event_id, enable );
	proxy:SetDrawEnable( event_id, enable );
end


--���������^�C�~���O��
function Second_Initialize_m07_01_00_00(proxy, param)
	print( "Second_Initialize_m07_01_00_00 begin" );
	
	--��冑�j��ŕ����яオ�鑫��A
	if proxy:IsCompleteEvent( 1 ) == false then
		SetColiAndDraw( proxy, 1002, false ); --����A��\��
	else
		SetColiAndDraw( proxy, 1002, true  ); --����A�\��
	--	proxy:ReconstructBreak( 1000 , 1 );
	end
	
	--��冑�j��ŕ����яオ�鑫��B
	if proxy:IsCompleteEvent( 11 ) == false then
		SetColiAndDraw( proxy, 1003, false ); --����B��\��
	else
		SetColiAndDraw( proxy, 1003, true  ); --����B�\��
	--	proxy:ReconstructBreak( 1001 , 1 );	
	end
	
	--��冑�A��冑�B��j��ŕ����яオ�鑫��C
	if proxy:IsCompleteEvent( 12 ) == false then
		SetColiAndDraw( proxy, 1033, false ); --����C��\��
	else
		SetColiAndDraw( proxy, 1033, true  ); --����C�\��
	end
	
	
	--���m�[�}��冑�j��ňꕔ�̓G��������悤�ɂȂ�A�`M
	local first_id_enemy  = 720;
	local first_id_shadow = first_id_enemy + 2300;
	local draw_num 		  = 3;
	local draw_num_offset = 2;--�\�����̗\��
	local end_id_enemy    = first_id_enemy  + draw_num;
	local end_id_shadow   = first_id_shadow + draw_num;
	
	local first_id_dai    = 1007;
	local now_id_dai      = first_id_dai;
	local first_event_id  = 20;
	local dai_num         = 13;
--	local end_id_dai      = first_id_dai + dai_num;
	local end_event_id    = first_event_id + dai_num;
	
	--�G�Ɖe�̕\����������
	for k=first_event_id, end_event_id, 1 do		
	
		if proxy:IsCompleteEvent( k ) == false then
			for i=first_id_enemy , end_id_enemy -1, 1 do proxy:SetDrawEnable( i, false ); end --�G���\��
			for j=first_id_shadow, end_id_shadow-1, 1 do proxy:SetDrawEnable( j, true  ); end --�e��\��
		else 
			for i=first_id_enemy , end_id_enemy -1, 1 do proxy:SetDrawEnable( i, true  ); end --�G��\��
			for j=first_id_shadow, end_id_shadow-1, 1 do proxy:SetDrawEnable( j, false ); end --�e���\��
			
		--	proxy:ReconstructBreak( now_id_dai , 1 );
		end
		
		first_id_enemy  = first_id_enemy  + draw_num + draw_num_offset;
		first_id_shadow = first_id_shadow + draw_num + draw_num_offset;
		end_id_enemy    = first_id_enemy  + draw_num;
		end_id_shadow   = first_id_shadow + draw_num;
		
		now_id_dai = now_id_dai + 1;
	end

	--冑�̉e�̓���
	
	local first_event_id = 40;
	local end_event_id   = ( draw_num + draw_num_offset ) * dai_num + first_event_id;
		
	local first_id_shadow = 3020;
	local now_id_shadow   = first_id_shadow;
	
	for i=first_event_id, end_event_id-1, 1 do
		
		--�Ή�����G�����񂾂�e�������B
		if proxy:IsCompleteEvent( i ) == true then
			proxy:SetDrawEnable( now_id_shadow , false );
		end
		
		now_id_shadow = now_id_shadow + 1;
	end
	
	
--[[
	--���p�j�f�[�����p (�t���O�͉��A�w�肪����Ες���)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m07_01_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m07_01_00_00);
	end
]]	
	
	
	print( "Second_Initialize_m07_01_00_00 end" );
end


--------------------------------------------------------------------------------------
--�����яオ�鑫��A��1
--------------------------------------------------------------------------------------
--��1�������яオ�鑫��A��
function OnEvent_1(proxy, param)
print("OnEvent_1 begin");

	SetColiAndDraw( proxy, 1002, true );

	--�����Е���冑䂪���Ă�����A������ꂽ�̂ő���C�C�x���g����
	if proxy:IsCompleteEvent(11) ==true then
		proxy:LuaCallStart( 12, 1 );
	end
	
	proxy:SetEventFlag( 1, 1 );
	
	if param:IsNetMessage()==true  then
		--�����̉�ʂŔj�󂳂�Ă��Ă��A�K�����̃v���C���[�̉�ʂŉ��Ă���Ƃ͌���Ȃ��ׁA�����ŉ��߂Ĕj�󂷂�
		proxy:ChangeModel( 1000, 1 );
		proxy:SetBrokenPiece(1000);
	end
	
print("OnEvent_1 end");
end


--------------------------------------------------------------------------------------
--�����яオ�鑫��B��11
--------------------------------------------------------------------------------------
--��11�������яオ�鑫��B��
function OnEvent_11(proxy, param)
	print("OnEvent_11 begin");

	SetColiAndDraw( proxy, 1003, true );
	
	--�����Е���冑䂪���Ă�����A������ꂽ�̂ő���C�C�x���g����
	if proxy:IsCompleteEvent(1) ==true then
		proxy:LuaCallStart( 12, 1 );
	end
	
	proxy:SetEventFlag( 11, 1 );
	
	if param:IsNetMessage()==true  then
		--�����̉�ʂŔj�󂳂�Ă��Ă��A�K�����̃v���C���[�̉�ʂŉ��Ă���Ƃ͌���Ȃ��ׁA�����ŉ��߂Ĕj�󂷂�
		--proxy:ObjectDestroy(1001);
		proxy:ChangeModel( 1001, 1 );
		proxy:SetBrokenPiece(1001);
	end
	
	print("OnEvent_11 end");
end


--------------------------------------------------------------------------------------
--�����яオ�鑫��C��12
--------------------------------------------------------------------------------------
--��12�������яオ�鑫��C��
function OnEvent_12(proxy, param)
	print("OnEvent_12 begin");
	
	SetColiAndDraw( proxy, 1033, true );
	proxy:SetEventFlag( 12, 1 );
	
	print("OnEvent_12 end");
end



--------------------------------------------------------------------------------------
--��120�����{�X�����ւ̔����J����
--------------------------------------------------------------------------------------
--��120�����{�X�����ւ̔����J����
function OnEvent_120(proxy, param)
	print("OnEvent_120 begin")
	
	proxy:PlayAnimation( 1120, 1 );
	
	proxy:NotNetMessage_begin();
		--��120_2��***�����ǉ�***���A�j���I����
		proxy:OnCharacterAnimEnd( 120, 1120, 1, "OnEvent_120_2", once );
	proxy:NotNetMessage_end();
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then 
		return;
	end
--[[	
	proxy:NotNetMessage_begin();
		--��120_1��***�����ǉ�***�v���C���[�A�j���I����
		proxy:OnChrAnimEnd( 120, 10000, ANIMEID_OPEN, "OnEvent_120_1", once );
	proxy:NotNetMessage_end();
]]		
--	proxy:Warp( 10000 , 2013 );		--�v���C���[������ʒu�Ƀ��[�v
--	proxy:DisableMove( 10000, 1 );	--�v���C���[�𑀍�s�\��
	
	print("OnEvent_120 end")
end

--[[
--��120_1���v���C���[�A�j���I����
function OnEvent_120_1(proxy, param)
	print("OnEvent_120_1 begin")
		
	proxy:DisableMove( 10000, 0 );	--�v���C���[�𑀍�\��
	
	print("OnEvent_120_1 end")
end
]]

--��120_2�����A�j���I����
function OnEvent_120_2(proxy, param)
	print("OnEvent_120_2 begin")
	
	--�����ŁA�|�����Đ��\��
	
	proxy:SetEventFlag( 120 , 1 );
	
	print("OnEvent_120_2 end")
end


--------------------------------------------------------------------------------------
--���{�X���S�ŉ������N���遡6656
--------------------------------------------------------------------------------------
--��6656�����{�X���S�ŉ������N���遡
function OnEvent_6656(proxy, param)
	print("OnEvent_6656 begin");
	
	proxy:NotNetMessage_begin();
		--��6656_1��***�����ǉ�***1�b�づ
		proxy:OnKeyTime2( 6656, "OnEvent_6656_1", 1.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_6656 end");
end

--��6656_1��1�b�っ
function OnEvent_6656_1(proxy, param)
	print("OnEvent_6656_1 begin");
	
	proxy:SetEventFlag( 6656, 1);
	--�_�~�[�Ń��o�[(ID:1004)�̃A�j��(ID:1)���Đ�
	proxy:PlayAnimation( 1004, 1 );
	
	print("OnEvent_6656_1 end");
end


--------------------------------------------------------------------------------------
--�󎀑�A��13568
--------------------------------------------------------------------------------------
--��13568���󎀑�A��
function OnEvent_13568(proxy, param)
	print("OnEvent_13568 begin");
	
	--�����A�j���[�V�����p�̃C�x���g
	proxy:LuaCallStart( 4010 , 1 );
	
	proxy:NotNetMessage_begin();
		--��13568_1��***�����ǉ�***�󎀑�A�A�C�e���擾��
		proxy:OnKeyTime2( 13568, "OnEvent_13568_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_13568 end");
end

--��13568_1���󎀑�A�A�C�e���擾��
function OnEvent_13568_1(proxy, param)
	print("OnEvent_13568_1 begin");
	
	proxy:GetItem(10000, TYPE_WEAPON);			--�A�C�e������
	proxy:SetEventFlag( 13568, 1 );				--�t���O�𗧂Ă�
	proxy:TreasureDispModeChange( 1005, false );--�����Ă�̂�����
	
	print("OnEvent_13568_1 end");
end


--------------------------------------------------------------------------------------
--�󎀑�B��13569
--------------------------------------------------------------------------------------
--��13569���󎀑�B��
function OnEvent_13569(proxy, param)
	print("OnEvent_13569 begin");
	
	--�����A�j���[�V�����p�̃C�x���g
	proxy:LuaCallStart( 4010 , 1 );
	
	proxy:NotNetMessage_begin();
		--��13569_1��***�����ǉ�***�󎀑�B�A�C�e���擾��
		proxy:OnKeyTime2( 13569, "OnEvent_13569_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_13569 end");
end

--��13569_1���󎀑�B�A�C�e���擾��
function OnEvent_13569_1(proxy, param)
	print("OnEvent_13569_1 begin");
	
	proxy:GetItem(10000, TYPE_WEAPON);			--�A�C�e������
	proxy:SetEventFlag( 13569, 1 );				--�t���O�𗧂Ă�
	proxy:TreasureDispModeChange( 1006, false );--�����Ă�̂�����
	
	print("OnEvent_13569_1 end");
end


--------------------------------------------------------------------------------------
--�m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ�A��20
--------------------------------------------------------------------------------------
--��20���m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ遡
function OnEvent_20(proxy, param)
	print("OnEvent_20 begin");
	
	--���\���̐؂�ւ�
	
	--�G��\��
	proxy:SetDrawEnable( 720 , true );
	proxy:SetDrawEnable( 721 , true );
	proxy:SetDrawEnable( 722 , true );
	
	--�e���\��
	proxy:SetDrawEnable( 3020 , false );
	proxy:SetDrawEnable( 3021 , false );
	proxy:SetDrawEnable( 3022 , false );
	
	--ID�̃��[��������Ȃ̂ŉ��Ή��B���͑��₳�Ȃ��ł��������B
	--proxy:InvalidSfx(5);
	--proxy:InvalidSfx(1007);
	
	if param:IsNetMessage()==true  then
		--�����̉�ʂŔj�󂳂�Ă��Ă��A�K�����̃v���C���[�̉�ʂŉ��Ă���Ƃ͌���Ȃ��ׁA�����ŉ��߂Ĕj�󂷂�
		proxy:ChangeModel( 1007, 1 );
		proxy:SetBrokenPiece(1007);
	end
	
	proxy:SetEventFlag( 20, 1 );
	
	print("OnEvent_20 end");
end


--------------------------------------------------------------------------------------
--�m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ�B��21
--------------------------------------------------------------------------------------
--��21���m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ遡
function OnEvent_21(proxy, param)
	print("OnEvent_21 begin");
	
	--���\���̐؂�ւ�
	
	--�G��\��
	proxy:SetDrawEnable( 725 , true );
	proxy:SetDrawEnable( 726 , true );
	proxy:SetDrawEnable( 727 , true );
	
	--�e���\��
	proxy:SetDrawEnable( 3025 , false );
	proxy:SetDrawEnable( 3026 , false );
	proxy:SetDrawEnable( 3027 , false );
	
	--ID�̃��[��������Ȃ̂ŉ��Ή��B���͑��₳�Ȃ��ł��������B
	--proxy:InvalidSfx(12);
	--proxy:InvalidSfx(1008);
	
	if param:IsNetMessage()==true  then
		--�����̉�ʂŔj�󂳂�Ă��Ă��A�K�����̃v���C���[�̉�ʂŉ��Ă���Ƃ͌���Ȃ��ׁA�����ŉ��߂Ĕj�󂷂�
		proxy:ChangeModel( 1008, 1 );
		proxy:SetBrokenPiece(1008);
	end
	
	proxy:SetEventFlag( 21, 1 );
	
	print("OnEvent_21 end");
end


--------------------------------------------------------------------------------------
--�m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ�C��22
--------------------------------------------------------------------------------------
--��22���m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ遡
function OnEvent_22(proxy, param)
	print("OnEvent_22 begin");
	
	--���\���̐؂�ւ�
	
	--�G��\��
	proxy:SetDrawEnable( 730 , true );
	proxy:SetDrawEnable( 731 , true );
	proxy:SetDrawEnable( 732 , true );
	
	--�e���\��
	proxy:SetDrawEnable( 3030 , false );
	proxy:SetDrawEnable( 3031 , false );
	proxy:SetDrawEnable( 3032 , false );
	
	if param:IsNetMessage()==true  then
		--�����̉�ʂŔj�󂳂�Ă��Ă��A�K�����̃v���C���[�̉�ʂŉ��Ă���Ƃ͌���Ȃ��ׁA�����ŉ��߂Ĕj�󂷂�
		proxy:ChangeModel( 1009, 1 );
		proxy:SetBrokenPiece( 1009 );
	end
	
	proxy:SetEventFlag( 22, 1 );
	
	print("OnEvent_22 end");
end


--------------------------------------------------------------------------------------
--�m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ�D��23
--------------------------------------------------------------------------------------
--��23���m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ遡
function OnEvent_23(proxy, param)
	print("OnEvent_23 begin");
	
	--���\���̐؂�ւ�
	
	--�G��\��
	proxy:SetDrawEnable( 735 , true );
	proxy:SetDrawEnable( 736 , true );
	proxy:SetDrawEnable( 737 , true );
	
	--�e���\��
	proxy:SetDrawEnable( 3035 , false );
	proxy:SetDrawEnable( 3036 , false );
	proxy:SetDrawEnable( 3037 , false );
	
	if param:IsNetMessage()==true  then
		--�����̉�ʂŔj�󂳂�Ă��Ă��A�K�����̃v���C���[�̉�ʂŉ��Ă���Ƃ͌���Ȃ��ׁA�����ŉ��߂Ĕj�󂷂�
		proxy:ChangeModel( 1010, 1 );
		proxy:SetBrokenPiece( 1010 );
	end
	
	proxy:SetEventFlag( 23, 1 );
	
	print("OnEvent_23 end");
end


--------------------------------------------------------------------------------------
--�m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ�E��24
--------------------------------------------------------------------------------------
--��24���m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ遡
function OnEvent_24(proxy, param)
	print("OnEvent_24 begin");
	
	--���\���̐؂�ւ�
	
	--�G��\��
	proxy:SetDrawEnable( 740 , true );
	proxy:SetDrawEnable( 741 , true );
	proxy:SetDrawEnable( 742 , true );
	
	--�e���\��
	proxy:SetDrawEnable( 3040 , false );
	proxy:SetDrawEnable( 3041 , false );
	proxy:SetDrawEnable( 3042 , false );
	
	if param:IsNetMessage()==true  then
		--�����̉�ʂŔj�󂳂�Ă��Ă��A�K�����̃v���C���[�̉�ʂŉ��Ă���Ƃ͌���Ȃ��ׁA�����ŉ��߂Ĕj�󂷂�
		proxy:ChangeModel( 1011, 1 );
		proxy:SetBrokenPiece(1011);
	end
	
	proxy:SetEventFlag( 24, 1 );
	
	print("OnEvent_24 end");
end


--------------------------------------------------------------------------------------
--�m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ�F��25
--------------------------------------------------------------------------------------
--��25���m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ遡
function OnEvent_25(proxy, param)
	print("OnEvent_25 begin");
	
	--���\���̐؂�ւ�
	
	--�G��\��
	proxy:SetDrawEnable( 745 , true );
	proxy:SetDrawEnable( 746 , true );
	proxy:SetDrawEnable( 747 , true );
	
	--�e���\��
	proxy:SetDrawEnable( 3045 , false );
	proxy:SetDrawEnable( 3046 , false );
	proxy:SetDrawEnable( 3047 , false );
	
	if param:IsNetMessage()==true  then
		--�����̉�ʂŔj�󂳂�Ă��Ă��A�K�����̃v���C���[�̉�ʂŉ��Ă���Ƃ͌���Ȃ��ׁA�����ŉ��߂Ĕj�󂷂�
		proxy:ChangeModel( 1012, 1 );
		proxy:SetBrokenPiece(1012);
	end
	
	proxy:SetEventFlag( 25, 1 );
	
	print("OnEvent_25 end");
end


--------------------------------------------------------------------------------------
--�m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ�G��26
--------------------------------------------------------------------------------------
--��26���m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ遡
function OnEvent_26(proxy, param)
	print("OnEvent_26 begin");
	
	--���\���̐؂�ւ�
	
	--�G��\��
	proxy:SetDrawEnable( 750 , true );
	proxy:SetDrawEnable( 751 , true );
	proxy:SetDrawEnable( 752 , true );
	
	--�e���\��
	proxy:SetDrawEnable( 3050 , false );
	proxy:SetDrawEnable( 3051 , false );
	proxy:SetDrawEnable( 3052 , false );
	
	if param:IsNetMessage()==true  then
		--�����̉�ʂŔj�󂳂�Ă��Ă��A�K�����̃v���C���[�̉�ʂŉ��Ă���Ƃ͌���Ȃ��ׁA�����ŉ��߂Ĕj�󂷂�
		proxy:ChangeModel( 1013, 1 );
		proxy:SetBrokenPiece(1013);
	end
	
	proxy:SetEventFlag( 26, 1 );
	
	print("OnEvent_26 end");
end


--------------------------------------------------------------------------------------
--�m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ�H��27
--------------------------------------------------------------------------------------
--��27���m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ遡
function OnEvent_27(proxy, param)
	print("OnEvent_27 begin");
	
	--���\���̐؂�ւ�
	
	--�G��\��
	proxy:SetDrawEnable( 755 , true );
	proxy:SetDrawEnable( 756 , true );
	proxy:SetDrawEnable( 757 , true );
	
	--�e���\��
	proxy:SetDrawEnable( 3055 , false );
	proxy:SetDrawEnable( 3056 , false );
	proxy:SetDrawEnable( 3057 , false );
	
	if param:IsNetMessage()==true  then
		--�����̉�ʂŔj�󂳂�Ă��Ă��A�K�����̃v���C���[�̉�ʂŉ��Ă���Ƃ͌���Ȃ��ׁA�����ŉ��߂Ĕj�󂷂�
		proxy:ChangeModel( 1014, 1 );
		proxy:SetBrokenPiece(1014);
	end
	
	proxy:SetEventFlag( 27, 1 );
	
	print("OnEvent_27 end");
end


--------------------------------------------------------------------------------------
--�m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ�I��28
--------------------------------------------------------------------------------------
--��28���m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ遡
function OnEvent_28(proxy, param)
	print("OnEvent_28 begin");
	
	--���\���̐؂�ւ�
	
	--�G��\��
	proxy:SetDrawEnable( 760 , true );
	proxy:SetDrawEnable( 761 , true );
	proxy:SetDrawEnable( 762 , true );
	
	--�e���\��
	proxy:SetDrawEnable( 3060 , false );
	proxy:SetDrawEnable( 3061 , false );
	proxy:SetDrawEnable( 3062 , false );
	
	if param:IsNetMessage()==true  then
		--�����̉�ʂŔj�󂳂�Ă��Ă��A�K�����̃v���C���[�̉�ʂŉ��Ă���Ƃ͌���Ȃ��ׁA�����ŉ��߂Ĕj�󂷂�
		proxy:ChangeModel( 1015, 1 );
		proxy:SetBrokenPiece(1015);
	end
	
	proxy:SetEventFlag( 28, 1 );
	
	print("OnEvent_28 end");
end


--------------------------------------------------------------------------------------
--�m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ�J��29
--------------------------------------------------------------------------------------
--��29���m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ遡
function OnEvent_29(proxy, param)
	print("OnEvent_29 begin");
	
	--���\���̐؂�ւ�
	
	--�G��\��
	proxy:SetDrawEnable( 765 , true );
	proxy:SetDrawEnable( 766 , true );
	proxy:SetDrawEnable( 767 , true );
	
	--�e���\��
	proxy:SetDrawEnable( 3065 , false );
	proxy:SetDrawEnable( 3066 , false );
	proxy:SetDrawEnable( 3067 , false );
	
	if param:IsNetMessage()==true  then
		--�����̉�ʂŔj�󂳂�Ă��Ă��A�K�����̃v���C���[�̉�ʂŉ��Ă���Ƃ͌���Ȃ��ׁA�����ŉ��߂Ĕj�󂷂�
		proxy:ChangeModel( 1016, 1 );
		proxy:SetBrokenPiece(1016);
	end
	
	proxy:SetEventFlag( 29, 1 );
	
	print("OnEvent_29 end");
end


--------------------------------------------------------------------------------------
--�m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ�K��30
--------------------------------------------------------------------------------------
--��30���m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ遡
function OnEvent_30(proxy, param)
	print("OnEvent_30 begin");
	
	--���\���̐؂�ւ�
	
	--�G��\��
	proxy:SetDrawEnable( 770 , true );
	proxy:SetDrawEnable( 771 , true );
	proxy:SetDrawEnable( 772 , true );
	
	--�e���\��
	proxy:SetDrawEnable( 3070 , false );
	proxy:SetDrawEnable( 3071 , false );
	proxy:SetDrawEnable( 3072 , false );
	
	if param:IsNetMessage()==true  then
		--�����̉�ʂŔj�󂳂�Ă��Ă��A�K�����̃v���C���[�̉�ʂŉ��Ă���Ƃ͌���Ȃ��ׁA�����ŉ��߂Ĕj�󂷂�
		proxy:ChangeModel( 1017, 1 );
		proxy:SetBrokenPiece(1017);
	end
	
	proxy:SetEventFlag( 30, 1 );
	
	print("OnEvent_30 end");
end


--------------------------------------------------------------------------------------
--�m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ�L��31
--------------------------------------------------------------------------------------
--��31���m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ遡
function OnEvent_31(proxy, param)
	print("OnEvent_31 begin");
	
	--���\���̐؂�ւ�
	
	--�G��\��
	proxy:SetDrawEnable( 775 , true );
	proxy:SetDrawEnable( 776 , true );
	proxy:SetDrawEnable( 777 , true );
	
	--�e���\��
	proxy:SetDrawEnable( 3075 , false );
	proxy:SetDrawEnable( 3076 , false );
	proxy:SetDrawEnable( 3077 , false );
	
	if param:IsNetMessage()==true  then
		--�����̉�ʂŔj�󂳂�Ă��Ă��A�K�����̃v���C���[�̉�ʂŉ��Ă���Ƃ͌���Ȃ��ׁA�����ŉ��߂Ĕj�󂷂�
		proxy:ChangeModel( 1018, 1 );
		proxy:SetBrokenPiece(1018);
	end
	
	proxy:SetEventFlag( 31, 1 );
	
	print("OnEvent_31 end");
end


--------------------------------------------------------------------------------------
--�m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ�M��32
--------------------------------------------------------------------------------------
--��32���m�[�}���C��j��ňꕔ�̓G��������悤�ɂȂ遡
function OnEvent_32(proxy, param)
	print("OnEvent_32 begin");
	
	--���\���̐؂�ւ�
	
	--�G��\��
	proxy:SetDrawEnable( 780 , true );
	proxy:SetDrawEnable( 781 , true );
	proxy:SetDrawEnable( 782 , true );
	
	--�e���\��
	proxy:SetDrawEnable( 3080 , false );
	proxy:SetDrawEnable( 3081 , false );
	proxy:SetDrawEnable( 3082 , false );
	
	if param:IsNetMessage()==true  then
		--�����̉�ʂŔj�󂳂�Ă��Ă��A�K�����̃v���C���[�̉�ʂŉ��Ă���Ƃ͌���Ȃ��ׁA�����ŉ��߂Ĕj�󂷂�
		proxy:ChangeModel( 1019, 1 );
		proxy:SetBrokenPiece(1019);
	end
	
	proxy:SetEventFlag( 32, 1 );
	
	print("OnEvent_32 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���40
--------------------------------------------------------------------------------------
--��40���U�R�G�̎��S�Ď���
function OnEvent_40(proxy, param)
	print("OnEvent_40 begin");
	
	proxy:SetDrawEnable( 3020 , false );
	proxy:SetEventFlag( 40, 1 );
	
	print("OnEvent_40 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���41
--------------------------------------------------------------------------------------
--��41���U�R�G�̎��S�Ď���
function OnEvent_41(proxy, param)
	print("OnEvent_41 begin");
	
	proxy:SetDrawEnable( 3021 , false );
	proxy:SetEventFlag( 41, 1 );
	
	print("OnEvent_41 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���42
--------------------------------------------------------------------------------------
--��42���U�R�G�̎��S�Ď���
function OnEvent_42(proxy, param)
	print("OnEvent_42 begin");
	
	proxy:SetDrawEnable( 3022 , false );
	proxy:SetEventFlag( 42, 1 );
	
	print("OnEvent_42 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���43
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���44
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���45
--------------------------------------------------------------------------------------
--��45���U�R�G�̎��S�Ď���
function OnEvent_45(proxy, param)
	print("OnEvent_45 begin");
	
	proxy:SetDrawEnable( 3025 , false );
	proxy:SetEventFlag( 45, 1 );
	
	print("OnEvent_45 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���46
--------------------------------------------------------------------------------------
--��46���U�R�G�̎��S�Ď���
function OnEvent_46(proxy, param)
	print("OnEvent_46 begin");
	
	proxy:SetDrawEnable( 3026 , false );
	proxy:SetEventFlag( 46, 1 );
	
	print("OnEvent_46 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���47
--------------------------------------------------------------------------------------
--��47���U�R�G�̎��S�Ď���
function OnEvent_47(proxy, param)
	print("OnEvent_47 begin");
	
	proxy:SetDrawEnable( 3027 , false );
	proxy:SetEventFlag( 47, 1 );
	
	print("OnEvent_47 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���48
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���49
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���50
--------------------------------------------------------------------------------------
--��50���U�R�G�̎��S�Ď���
function OnEvent_50(proxy, param)
	print("OnEvent_50 begin");
	
	proxy:SetDrawEnable( 3030 , false );
	proxy:SetEventFlag( 50, 1 );
	
	print("OnEvent_50 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���51
--------------------------------------------------------------------------------------
--��51���U�R�G�̎��S�Ď���
function OnEvent_51(proxy, param)
	print("OnEvent_51 begin");
	
	proxy:SetDrawEnable( 3031 , false );
	proxy:SetEventFlag( 51, 1 );
	
	print("OnEvent_51 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���52
--------------------------------------------------------------------------------------
--��52���U�R�G�̎��S�Ď���
function OnEvent_52(proxy, param)
	print("OnEvent_52 begin");
	
	proxy:SetDrawEnable( 3032 , false );
	proxy:SetEventFlag( 52, 1 );
	
	print("OnEvent_52 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���53
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���54
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���55
--------------------------------------------------------------------------------------
--��55���U�R�G�̎��S�Ď���
function OnEvent_55(proxy, param)
	print("OnEvent_55 begin");
	
	proxy:SetDrawEnable( 3035 , false );
	proxy:SetEventFlag( 55, 1 );
	
	print("OnEvent_55 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���56
--------------------------------------------------------------------------------------
--��56���U�R�G�̎��S�Ď���
function OnEvent_56(proxy, param)
	print("OnEvent_56 begin");
	
	proxy:SetDrawEnable( 3036 , false );
	proxy:SetEventFlag( 56, 1 );
	
	print("OnEvent_56 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���57
--------------------------------------------------------------------------------------
--��57���U�R�G�̎��S�Ď���
function OnEvent_57(proxy, param)
	print("OnEvent_57 begin");
	
	proxy:SetDrawEnable( 3037 , false );
	proxy:SetEventFlag( 57, 1 );
	
	print("OnEvent_57 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���58
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���59
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���60
--------------------------------------------------------------------------------------
--��60���U�R�G�̎��S�Ď���
function OnEvent_60(proxy, param)
	print("OnEvent_60 begin");
	
	proxy:SetDrawEnable( 3040 , false );
	proxy:SetEventFlag( 60, 1 );
	
	print("OnEvent_60 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���61
--------------------------------------------------------------------------------------
--��61���U�R�G�̎��S�Ď���
function OnEvent_61(proxy, param)
	print("OnEvent_61 begin");
	
	proxy:SetDrawEnable( 3041 , false );
	proxy:SetEventFlag( 61, 1 );
	
	print("OnEvent_61 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���62
--------------------------------------------------------------------------------------
--��62���U�R�G�̎��S�Ď���
function OnEvent_62(proxy, param)
	print("OnEvent_62 begin");
	
	proxy:SetDrawEnable( 3042 , false );
	proxy:SetEventFlag( 62, 1 );
	
	print("OnEvent_62 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���63
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���64
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���65
--------------------------------------------------------------------------------------
--��65���U�R�G�̎��S�Ď���
function OnEvent_65(proxy, param)
	print("OnEvent_65 begin");
	
	proxy:SetDrawEnable( 3045 , false );
	proxy:SetEventFlag( 65, 1 );
	
	print("OnEvent_65 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���66
--------------------------------------------------------------------------------------
--��66���U�R�G�̎��S�Ď���
function OnEvent_66(proxy, param)
	print("OnEvent_66 begin");
	
	proxy:SetDrawEnable( 3046 , false );
	proxy:SetEventFlag( 66, 1 );
	
	print("OnEvent_66 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���67
--------------------------------------------------------------------------------------
--��67���U�R�G�̎��S�Ď���
function OnEvent_67(proxy, param)
	print("OnEvent_67 begin");
	
	proxy:SetDrawEnable( 3047 , false );
	proxy:SetEventFlag( 67, 1 );
	
	print("OnEvent_67 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���68
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���69
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���70
--------------------------------------------------------------------------------------
--��70���U�R�G�̎��S�Ď���
function OnEvent_70(proxy, param)
	print("OnEvent_70 begin");
	
	proxy:SetDrawEnable( 3050 , false );
	proxy:SetEventFlag( 70, 1 );
	
	print("OnEvent_70 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���71
--------------------------------------------------------------------------------------
--��71���U�R�G�̎��S�Ď���
function OnEvent_71(proxy, param)
	print("OnEvent_71 begin");
	
	proxy:SetDrawEnable( 3051 , false );
	proxy:SetEventFlag( 71, 1 );
	
	print("OnEvent_71 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���72
--------------------------------------------------------------------------------------
--��72���U�R�G�̎��S�Ď���
function OnEvent_72(proxy, param)
	print("OnEvent_72 begin");
	
	proxy:SetDrawEnable( 3052 , false );
	proxy:SetEventFlag( 72, 1 );
	
	print("OnEvent_72 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���73
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���74
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���75
--------------------------------------------------------------------------------------
--��75���U�R�G�̎��S�Ď���
function OnEvent_75(proxy, param)
	print("OnEvent_75 begin");
	
	proxy:SetDrawEnable( 3055 , false );
	proxy:SetEventFlag( 75, 1 );
	
	print("OnEvent_75 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���76
--------------------------------------------------------------------------------------
--��76���U�R�G�̎��S�Ď���
function OnEvent_76(proxy, param)
	print("OnEvent_76 begin");
	
	proxy:SetDrawEnable( 3056 , false );
	proxy:SetEventFlag( 76, 1 );
	
	print("OnEvent_76 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���77
--------------------------------------------------------------------------------------
--��77���U�R�G�̎��S�Ď���
function OnEvent_77(proxy, param)
	print("OnEvent_77 begin");
	
	proxy:SetDrawEnable( 3057 , false );
	proxy:SetEventFlag( 77, 1 );
	
	print("OnEvent_77 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���78
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���79
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���80
--------------------------------------------------------------------------------------
--��80���U�R�G�̎��S�Ď���
function OnEvent_80(proxy, param)
	print("OnEvent_80 begin");
	
	proxy:SetDrawEnable( 3060 , false );
	proxy:SetEventFlag( 80, 1 );
	
	print("OnEvent_80 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���81
--------------------------------------------------------------------------------------
--��81���U�R�G�̎��S�Ď���
function OnEvent_81(proxy, param)
	print("OnEvent_81 begin");
	
	proxy:SetDrawEnable( 3061 , false );
	proxy:SetEventFlag( 81, 1 );
	
	print("OnEvent_81 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���82
--------------------------------------------------------------------------------------
--��82���U�R�G�̎��S�Ď���
function OnEvent_82(proxy, param)
	print("OnEvent_82 begin");
	
	proxy:SetDrawEnable( 3062 , false );
	proxy:SetEventFlag( 82, 1 );
	
	print("OnEvent_82 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���83
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���84
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���85
--------------------------------------------------------------------------------------
--��85���U�R�G�̎��S�Ď���
function OnEvent_85(proxy, param)
	print("OnEvent_85 begin");
	
	proxy:SetDrawEnable( 3065 , false );
	proxy:SetEventFlag( 85, 1 );
	
	print("OnEvent_85 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���86
--------------------------------------------------------------------------------------
--��86���U�R�G�̎��S�Ď���
function OnEvent_86(proxy, param)
	print("OnEvent_86 begin");
	
	proxy:SetDrawEnable( 3066 , false );
	proxy:SetEventFlag( 86, 1 );
	
	print("OnEvent_86 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���87
--------------------------------------------------------------------------------------
--��87���U�R�G�̎��S�Ď���
function OnEvent_87(proxy, param)
	print("OnEvent_87 begin");
	
	proxy:SetDrawEnable( 3067 , false );
	proxy:SetEventFlag( 87, 1 );
	
	print("OnEvent_87 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���88
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���89
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���90
--------------------------------------------------------------------------------------
--��90���U�R�G�̎��S�Ď���
function OnEvent_90(proxy, param)
	print("OnEvent_90 begin");
	
	proxy:SetDrawEnable( 3070 , false );
	proxy:SetEventFlag( 90, 1 );
	
	print("OnEvent_90 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���91
--------------------------------------------------------------------------------------
--��91���U�R�G�̎��S�Ď���
function OnEvent_91(proxy, param)
	print("OnEvent_91 begin");
	
	proxy:SetDrawEnable( 3071 , false );
	proxy:SetEventFlag( 91, 1 );
	
	print("OnEvent_91 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���92
--------------------------------------------------------------------------------------
--��92���U�R�G�̎��S�Ď���
function OnEvent_92(proxy, param)
	print("OnEvent_92 begin");
	
	proxy:SetDrawEnable( 3072 , false );
	proxy:SetEventFlag( 92, 1 );
	
	print("OnEvent_92 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���93
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���94
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���95
--------------------------------------------------------------------------------------
--��95���U�R�G�̎��S�Ď���
function OnEvent_95(proxy, param)
	print("OnEvent_95 begin");
	
	proxy:SetDrawEnable( 3075 , false );
	proxy:SetEventFlag( 95, 1 );
	
	print("OnEvent_95 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���96
--------------------------------------------------------------------------------------
--��96���U�R�G�̎��S�Ď���
function OnEvent_96(proxy, param)
	print("OnEvent_96 begin");
	
	proxy:SetDrawEnable( 3076 , false );
	proxy:SetEventFlag( 96, 1 );
	
	print("OnEvent_96 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���97
--------------------------------------------------------------------------------------
--��97���U�R�G�̎��S�Ď���
function OnEvent_97(proxy, param)
	print("OnEvent_97 begin");
	
	proxy:SetDrawEnable( 3077 , false );
	proxy:SetEventFlag( 97, 1 );
	
	print("OnEvent_97 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���98
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���99
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���100
--------------------------------------------------------------------------------------
--��100���U�R�G�̎��S�Ď���
function OnEvent_100(proxy, param)
	print("OnEvent_100 begin");
	
	proxy:SetDrawEnable( 3080 , false );
	proxy:SetEventFlag( 100, 1 );
	
	print("OnEvent_100 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���101
--------------------------------------------------------------------------------------
--��101���U�R�G�̎��S�Ď���
function OnEvent_101(proxy, param)
	print("OnEvent_101 begin");
	
	proxy:SetDrawEnable( 3081 , false );
	proxy:SetEventFlag( 101, 1 );
	
	print("OnEvent_101 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���102
--------------------------------------------------------------------------------------
--��102���U�R�G�̎��S�Ď���
function OnEvent_102(proxy, param)
	print("OnEvent_102 begin");
	
	proxy:SetDrawEnable( 3082 , false );
	proxy:SetEventFlag( 102, 1 );
	
	print("OnEvent_102 end");
end

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���103
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--�U�R�G�̎��S�Ď���104
--------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------
--�Β��Ƀ��[�v��110
--------------------------------------------------------------------------------------
--��110���Β��Ƀ��[�v��
function OnEvent_110(proxy,param)	
	print("OnEvent_110 begin");
	
	proxy:WarpNextStage( 1, 0, 0, 0, 1011 );
	
	print("OnEvent_110 end");
end



--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m07_01_00_00(proxy, param)
	print("PlayerDeath_m07_01_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m07_01_00_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerDeath_m07_01_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m07_01_00_00(proxy,param)
	print("PlayerRevive_m07_01_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m07_01_00_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerRevive_m07_01_00_00");
end

