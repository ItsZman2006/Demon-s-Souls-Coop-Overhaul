once = 1;
everytime = 0;


--���`���[�g���A���p
TO_NEXT_MESSAGE_TIME          = 0.0;--���b�Z�[�W���A������Ƃ��́A���̃��b�Z�[�W��\������܂ł̎���
GET_ITEM_TO_NEXT_MESSAGE_TIME = 3.0;--�A�C�e���擾�����b�Z�[�W�\���̂Ƃ��͂�����Ǝ��Ԃ��󂯂�

DISPLAY_MESSAGE_TIME          = 4.5;



function Initialize_m99_99_10_00(proxy)
	print("Initialize m99_99_10_00 begin");

--��050�������z�u��
--�E�Q�[���J�n��
--�E�o�b�L�����N�^�[���w��̈ʒu�ɔz�u����
--�@�o�b�i0�j���L�����i0�j
--�@�o�b�i1�j���L�����i1�j
--�@�o�b�i2�j���L�����i2�j
--�@�o�b�i3�j���L�����i3�j
--	proxy:OnRegionJustIn( 0, 0, 1, "OnEvent_050", once);



--���ύX���Ȃ�����

--��055���}�b�v�ړ��i����1F)��
--�E�o�b���A�C�x���g�G���A�i55�j�ɓ��B�����Ƃ�
	proxy:OnRegionJustIn( 55, 10000, 55, "OnEvent_055", everytime);


--��065���}�b�v�ړ��i����2F)��
--�E�o�b���A�C�x���g�G���A�i65�j�ɓ��B�����Ƃ�
	proxy:OnRegionJustIn( 65, 10000, 65, "OnEvent_065", everytime);


--��ID�����X�{�X���Z�b�g�ɂ����̂ŁA�t���O���d�����Ȃ��悤�ɒ���(m99_99_10_00 ���� m99_99_12_00��)
	
	
--���`���[�g���A���p�ɒǉ���������

--�`���[�g���A���p�̃w���v���b�Z�[�W�A�󎀑̂̓G���A���Z�b�g���Ȃ��悤��
--���X�{�X���Z�b�g�̂ق��̃t���O�ɂȂ��Ă��܂��B
	
--��5020���`���[�g���A��01�������ړ��֘A����(�J��������������_�b�V���X�e�b�v����)
	if proxy:IsCompleteEvent( 5020 ) == false then
		proxy:OnKeyTime2(5020,"OnEvent_5020",1,0,0,once);
	end
	
--��5022���`���[�g���A��03���悶�o�����
	if proxy:IsCompleteEvent( 5022) == false then
		proxy:OnRegionJustIn(5022,10000,2000,"OnEvent_5022",once);
	end

--��5023���`���[�g���A��04�����z������
	if proxy:IsCompleteEvent( 5023 ) == false then
		proxy:OnRegionJustIn(5023,10000,2001,"OnEvent_5023",once);
	end
	
--��5024���`���[�g���A��05���ߐڍU���֘A����(���襉E��U�������ߍU�������襕Ў�U��)
	if proxy:IsCompleteEvent( 5024 ) == false then
		proxy:OnRegionJustIn(5024,10000,2002,"OnEvent_5024",once);
	end
	
--��5027���`���[�g���A��08�����u�U���֘A����(���@�U�����|�U��)
	if proxy:IsCompleteEvent( 5027 ) == false then
		proxy:OnRegionJustIn(5027,10000,2003,"OnEvent_5027",once);
	end
	
--��5031���`���[�g���A��11�����̒��ׂ�ƃA�C�e���擾�ł��܂��惁�b�Z�[�W
	if proxy:IsCompleteEvent( 5031 ) == false then
		proxy:OnRegionJustIn(5031,10000,2004,"OnEvent_5031",once);
	end

--��1100���ҋ@�̂܂܂̕��s�l��
	if proxy:IsCompleteEvent( 1100 ) == false then
		proxy:OnKeyTime2(1100, "OnEvent_1100" , 1 , 0 , 1 , once );
	end

--��5000���󎀑�A��������擾������̓���ւ����b�Z�[�W�\��
	if proxy:IsCompleteEvent( 5000 ) ==false then
		proxy:OnDistanceAction( 5000, 10000, 1040, "OnEvent_5000", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:TreasureDispModeChange( 1040, true );
	end

--��5010���󎀑�B�����|�[�V�����擾���A�C�e�������̃��b�Z�[�W�\��
	if proxy:IsCompleteEvent( 5010 ) ==false then
		proxy:OnDistanceAction( 5010, 10000, 1041, "OnEvent_5010", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:TreasureDispModeChange( 1041, true );
	end

	
--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m99_99_10_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m99_99_10_00", everytime );
	proxy:NotNetMessage_end();
	
	
--��999910���t���[���x��̏����������C�x���g�𔭍s��
	proxy:NotNetMessage_begin();
		--��0�b�づ--
		proxy:OnKeyTime2( 999910, "Second_Initialize_m99_99_10_00", 0.1, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	
	print("Initialize m99_99_10_00 end");
end


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
--��999910����������
function Second_Initialize_m99_99_10_00(proxy, param)
	print("Second_Initialize_m99_99_10_00 begin");
	
--[[
	--���p�j�f�[�����p (�t���O�͉��A�w�肪����Ες���)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m99_99_10_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_10_00);
	end
]]
	
	print("Second_Initialize_m99_99_10_00 end");
end



--��055���}�b�v�ړ��i����1F)��
function OnEvent_055(proxy, param)
print("OnEvent_055 begin");
	if param:IsNetMessage()==true  then
		return;         
	end

--�}���`�v���C�̎��̃G���A�ړ����~�߂�
	if proxy:IsInParty() == true then
		return;
	end 

--�E���ǂ蒅�����o�b�̂݁A�Ԑ��H����ԁim99_99_11_00�j�̎w��ʒu�Ɉړ�����
--�E�ړ���im99_99_11_00�j�̑Ή��L�����C�x���gID
--�@�o�b�i0�j���L�����i10�j
--�@�o�b�i1�j���L�����i11�j
--�@�o�b�i2�j���L�����i12�j
--�@�o�b�i3�j���L�����i13�j
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage(99,99,11,00, 10); end
	if playerId ==1 then proxy:WarpNextStage(99,99,11,00, 11); end
	if playerId ==2 then proxy:WarpNextStage(99,99,11,00, 12); end
	if playerId ==3 then proxy:WarpNextStage(99,99,11,00, 13); end

--���ړ�����L�����N�^�[�́A�ړ����Ƀp�b�Ə����Ă��܂��܂�

print("OnEvent_055 end");
end







--��065���}�b�v�ړ��i����2F)��
function OnEvent_065(proxy, param)
print("OnEvent_065 begin");

	if param:IsNetMessage()==true  then
		return;         
	end
--�}���`�v���C�̎��̃G���A�ړ����~�߂�
	if proxy:IsInParty() == true then
		return;
	end 

--�E���ǂ蒅�����o�b�̂݁A�Ԑ��H����ԁim99_99_11_00�j�̎w��ʒu�Ɉړ�����
--�E�ړ���im99_99_11_00�j�̑Ή��L�����C�x���gID
--�@�o�b�i0�j���L�����i20�j
--�@�o�b�i1�j���L�����i21�j
--�@�o�b�i2�j���L�����i22�j
--�@�o�b�i3�j���L�����i23�j
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage(99,99,11,00, 20); end
	if playerId ==1 then proxy:WarpNextStage(99,99,11,00, 21); end
	if playerId ==2 then proxy:WarpNextStage(99,99,11,00, 22); end
	if playerId ==3 then proxy:WarpNextStage(99,99,11,00, 23); end

--���ړ�����L�����N�^�[�́A�ړ����Ƀp�b�Ə����܂�

print("OnEvent_065 end");
end


--------------------------------------------------------------------------------------
--���`���[�g���A��01���ړ��A�J�����������
--------------------------------------------------------------------------------------
function OnEvent_5020(proxy,param)
	print("OnEvent_5020 begin");
	--���b�Z�[�W�\��ID�F80000000
	proxy:OnKeyTime2(5021,"OnEvent_5021",TO_NEXT_MESSAGE_TIME,0,0,once);
	
	proxy:SetEventFlag( 5020 , 1 );
	print("OnEvent_5020 end");
end

--------------------------------------------------------------------------------------
--���`���[�g���A��02�E03��������E�X�e�b�v�A�X�^�~�i����
--------------------------------------------------------------------------------------
function OnEvent_5021(proxy,param)
	print("OnEvent_5021 begin");
	
	proxy:SetEventFlag( 5021 , 1 );
	print("OnEvent_5021 end");
end

--------------------------------------------------------------------------------------
--���`���[�g���A��04���悶�o�����
--------------------------------------------------------------------------------------
function OnEvent_5022(proxy,param)
	print("OnEvent_5022 begin");
	
	proxy:SetEventFlag( 5022 , 1 );
	print("OnEvent_5022 end");
end

--------------------------------------------------------------------------------------
--���`���[�g���A��05�����z������
--------------------------------------------------------------------------------------
function OnEvent_5023(proxy,param)
	print("OnEvent_5023 begin");
	
	proxy:SetEventFlag( 5023 , 1 );
	print("OnEvent_5023 end");
end

--------------------------------------------------------------------------------------
--���`���[�g���A��05������U���E�E��U�����@����
--------------------------------------------------------------------------------------
function OnEvent_5024(proxy,param)
	print("OnEvent_5024 begin");
	proxy:OnKeyTime2(5025,"OnEvent_5025",TO_NEXT_MESSAGE_TIME,0,0,once);		
	
	proxy:SetEventFlag( 5024 , 1 );
	print("Onevent_5024 end");
end

--------------------------------------------------------------------------------------
--���`���[�g���A��06�����ߍU�����@����
--------------------------------------------------------------------------------------
function OnEvent_5025(proxy,param)
	print("OnEvent_5025 begin");
	proxy:OnKeyTime2(5026,"OnEvent_5026",TO_NEXT_MESSAGE_TIME,0,0,once);	
	
	proxy:SetEventFlag( 5025 , 1 );
	print("OnEvent_5025 end");
end

--------------------------------------------------------------------------------------
--���`���[�g���A��07������E�Ў�U�����@����
--------------------------------------------------------------------------------------
function OnEvent_5026(proxy,param)
	print("OnEvent_5026 begin");
	
	proxy:SetEventFlag( 5026 , 1 );
	print("OnEvent_5026 end");
end

--------------------------------------------------------------------------------------
--���`���[�g���A��08�����@�U�����@����
--------------------------------------------------------------------------------------
function OnEvent_5027(proxy,param)
	print("OnEvent_5027 begin");
	
	proxy:SetEventFlag( 5027 , 1 );
	print("Onevent_5027 end");
end

--------------------------------------------------------------------------------------
--���`���[�g���A��09���|��U�����@����
--------------------------------------------------------------------------------------
function OnEvent_5028(proxy,param)
	print("OnEvent_5028 begin");
	proxy:OnKeyTime2(5029,"OnEvent_5029",TO_NEXT_MESSAGE_TIME,0,0,once);

	proxy:SetEventFlag( 5028 , 1 );
	print("Onevent_5028 end");
end

--------------------------------------------------------------------------------------
--���`���[�g���A��10������̓���ւ����@����
--------------------------------------------------------------------------------------
function OnEvent_5029(proxy,param)
	print("OnEvent_5029 begin");
	
	proxy:SetEventFlag( 5029 , 1 );
	print("Onevent_5029 end");
end

--------------------------------------------------------------------------------------
--���`���[�g���A��11���A�C�e������
--------------------------------------------------------------------------------------
function OnEvent_5030(proxy,param)
	print("OnEvent_5030 begin");
	
	proxy:SetEventFlag( 5030 , 1 );
	print("Onevent_5030 end");
end

--------------------------------------------------------------------------------------
--���`���[�g���A��12�����͎��̒��ׂ�ƃA�C�e���擾�ł����ł���B
--------------------------------------------------------------------------------------
function OnEvent_5031(proxy,param)
	print("OnEvent_5031 begin");
	
	proxy:SetEventFlag( 5031 , 1 );
	print("Onevent_5031 end");
end



--------------------------------------------------------------------------------------
--���ҋ@�̂܂܂̕��s�l��
--------------------------------------------------------------------------------------
function OnEvent_1100(proxy,param)
	print("OnEvent_1100 begin");

	proxy:PlayLoopAnimation( 100 , 0 );--�ҋ@�A�j���̍Đ�
	
	print("Onevent_1100 end");
end



--------------------------------------------------------------------------------------
--���󎀑�A��
--------------------------------------------------------------------------------------
--��5000���󎀑�A��
function OnEvent_5000(proxy,param)
	print("OnEvent_5000 begin");

	proxy:PlayAnimation( 10000 , ANIMEID_PICK );
	
	proxy:NotNetMessage_begin();
		--��5000_1��0�b�づ
		proxy:OnKeyTime2( 5000, "OnEvent_5000_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("Onevent_5000 end");
end


--��5000_1��0�b�� �A�C�e���̎擾��
function OnEvent_5000_1(proxy, param)
	print("OnEvent_5000_1 begin");
	
	proxy:SetEventFlag( 5000 , 1 );

--[[ 2��ޓ����擾�͖������?

	--�V���[�g�{�E
	proxy:GetItem(130000,TYPE_WEAPON);			 --�A�C�e���擾�̕\������
	proxy:AddInventoryItem(130000,TYPE_WEAPON,1);--���ۂ̃A�C�e���擾(���ʂ�ω�������)
]]
	--��
	proxy:GetItem(160000,TYPE_WEAPON);
	proxy:AddInventoryItem(160000,TYPE_WEAPON,99);
	proxy:TreasureDispModeChange( 1040, false ); --�A�C�e�����擾�����̂ŁA�󂪌����Ă���̂�����
	
	--�|��U���̃��b�Z�[�W�\��
	proxy:OnKeyTime2(5028,"OnEvent_5028",GET_ITEM_TO_NEXT_MESSAGE_TIME,0,0,once);	

	print("OnEvent_5000_1 end");
end


--------------------------------------------------------------------------------------
--���󎀑�B��
--------------------------------------------------------------------------------------
--��5010���󎀑�B��
function OnEvent_5010(proxy,param)
	print("OnEvent_5010 begin");
	
	proxy:PlayAnimation( 10000 , ANIMEID_PICK );
	
	proxy:NotNetMessage_begin();
		--��5010_1��0�b�づ
		proxy:OnKeyTime2( 5010, "OnEvent_5010_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("Onevent_5010 end");
end


--��5010_1��0�b�� �A�C�e���̎擾��
function OnEvent_5010_1(proxy, param)
	print("OnEvent_5010_1 begin");
	
	proxy:SetEventFlag( 5010 , 1 );
	
	--�|�[�V����10��
	proxy:GetItem(1,TYPE_GOODS);				--�A�C�e���擾�̕\������
	proxy:AddInventoryItem(1,TYPE_GOODS,10);	--���ۂ̃A�C�e���擾(���ʂ�ω�������)
	proxy:TreasureDispModeChange( 1041, false );--�A�C�e�����擾�����̂ŁA�󂪌����Ă���̂�����
	
	--�A�C�e�������̃��b�Z�[�W�\��
	proxy:OnKeyTime2(5030,"OnEvent_5030",GET_ITEM_TO_NEXT_MESSAGE_TIME,0,0,once);
	
	print("OnEvent_5010_1 end");
end



--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m99_99_10_00(proxy, param)
	print("PlayerDeath_m99_99_10_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_10_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerDeath_m99_99_10_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m99_99_10_00(proxy,param)
	print("PlayerRevive_m99_99_10_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_10_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerRevive_m99_99_10_00");
end

