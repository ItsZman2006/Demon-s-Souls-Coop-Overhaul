
--������鏰�p

FloorBreak_KeyTime = 0.5;


--���v���i���A�s�i�p

--�������p
PURANARI_REGION_FIRST_ID = 2411;
PURANARI_REGION_END_ID   = 2508;--���[�g1�`6�܂�

PURANARI_DEAD_REGION_ID_1 = 2490;--���鏰�̉�
PURANARI_DEAD_REGION_ID_2 = 2491;--�Ō�̊R�̉�

PURANARI_REGION_FIRST_ID_ROOT_7 = 2470;
PURANARI_REGION_END_ID_ROOT_7   = 2474;--�P�ƃ��[�g�p

PURANARI_NUM = 40;--�s�������Ă���v���i���A�̐�

--�W�F�l���[�^�̃x�[�XID
GENERATER_POINT_BASE_ID = 2400;

--�W�F�l���[�^�̗̈�ID
GENERATER_POINT_A = 2410;
GENERATER_POINT_B = 2420;
GENERATER_POINT_C = 2430;
GENERATER_POINT_D = 2440;
GENERATER_POINT_E = 2450;
GENERATER_POINT_F = 2460;
GENERATER_POINT_G = 2470;

--�W�F�l���[�^�ɂ����Ƃ��Ɏ��ɖڎw���̈�ID
GENERATER_POINT_A_NEXT_REGION = 2411;
GENERATER_POINT_B_NEXT_REGION = 2421;
GENERATER_POINT_C_NEXT_REGION = 2431;
GENERATER_POINT_D_NEXT_REGION = 2441;
GENERATER_POINT_E_NEXT_REGION = 2451;
GENERATER_POINT_F_NEXT_REGION = 2461;
GENERATER_POINT_G_NEXT_REGION = 2471;

--�W�F�l���[�^�̐�(�v���i���A�p)
PRANARIA_GENERATER_NUM = 7;

--�v���i���A�����ɖڎw���̈�̎w��p
puranaria_region_id_list = {};

--�v���i���A���ڎw���ŏ��̗̈�(�f�t�H���g�l)
for i=101, 120, 1 do puranaria_region_id_list[i] = 2501; end
for i=121, 125, 1 do puranaria_region_id_list[i] = 2421; end
for i=126, 130, 1 do puranaria_region_id_list[i] = 2431; end
for i=131, 135, 1 do puranaria_region_id_list[i] = 2441; end
for i=136, 140, 1 do puranaria_region_id_list[i] = 2502; end

--���񂾃v���i���A�����܂��Ă����Ƃ���(�W�F�l���[�^���Ƃɗp��)
dead_pranaria_list_A = {};
dead_pranaria_list_B = {};
dead_pranaria_list_C = {};
dead_pranaria_list_D = {};
dead_pranaria_list_E = {};
dead_pranaria_list_F = {};
dead_pranaria_list_G = {};

--�v���i���A���Ƃɂǂ̃W�F�l���[�^�ŕ������邩�̕ۑ��p
puranaria_generater_id_list = {};

--�v���i���A����������W�F�l���[�^
for i=101, 120, 1 do puranaria_generater_id_list[i] = GENERATER_POINT_A; end
for i=121, 125, 1 do puranaria_generater_id_list[i] = GENERATER_POINT_B; end
for i=126, 130, 1 do puranaria_generater_id_list[i] = GENERATER_POINT_C; end
for i=131, 140, 1 do puranaria_generater_id_list[i] = GENERATER_POINT_D; end

--��������W�F�l���[�^�����[���ɏ]���Đ؂�ւ��邽�߂Ɏg���l
--(�K�������Ȃ��̂Œ��w��)
puranaria_generater_id_offset_list = {1,2,1,2,3,1,3,2,3,1,3,2,1,2,3,1,2,3,2,1,1,1,2,2,3,1,3,2,1,3,2,1,1,3,2,1,3,3,2,3};


--�������p
ONCE_PURANARIA_USE_ID  = 7;--��C�̃v���i���A�Ɋ��蓖�Ă�t���O�̐�(0�`127)
PURANARIA_USE_ID_START = 2048;--�����p�Ɏg�p����t���O�́A�\���p�t���O�̊J�n����g�p����

--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉����������
--------------------------------------------------------------------------------------
function Initialize_m07_00_00_00(proxy)
	print("Initialize_m07_00_00_00 begin");

	
--��512���Β��Ƀ��[�v��
	proxy:OnDistanceAction( 512, 10000, 1983, "OnEvent_512", WarpGimmickDist_A, HELPID_GO_TO_SEKITYUU, 0, 180, everytime );

--[[ �}�b�v�X�^�W�I�̃f�[�^������܂ŃR�����g�A�E�g	
	
--��522�����{�X�����ւ̔����J����
	if proxy:IsCompleteEvent( 522 ) == false then
		proxy:OnDistanceActionPlus( 522, 10000, 1120, "OnEvent_522", DoorDist_A, HELPID_OPEN, 90, DoorAngle_A, -0.3, 0.0, 2.0, once );
	else
		proxy:EndAnimation( 1120, 1 );--�����J���A�j�����I��
	end
	
	
	
--��6287�����{�X���S�Ŕ����J����
	if proxy:IsCompleteEvent( 6287 ) == false then
		proxy:OnCharacterDead( 6287 , 813 , "OnEvent_6287" , once );
	else
		--�����J���A�j�����I��(ID�͌��܂��Ă��Ȃ�)
	end

]]	
	
	--��999999���t���[���x��̏����������C�x���g�𔭍s��
	proxy:NotNetMessage_begin();
		--��0�b�づ--
		proxy:OnKeyTime2( 999990, "Second_Initialize_m07_00_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();
--[[	
	--��532���v���i���A�e�X�g��
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 532, "OnEvent_532_01",   20.0, 0,  1, once );
		proxy:OnKeyTime2( 532, "OnEvent_532_02",   40.0, 0,  2, once );
		proxy:OnKeyTime2( 532, "OnEvent_532_03",   60.0, 0,  3, once );
		proxy:OnKeyTime2( 532, "OnEvent_532_04",   80.0, 0,  4, once );
		proxy:OnKeyTime2( 532, "OnEvent_532_05",  100.0, 0,  5, once );
		
		proxy:OnKeyTime2( 532, "OnEvent_532_06",  120.0, 0,  6, once );
		proxy:OnKeyTime2( 532, "OnEvent_532_07",  140.0, 0,  7, once );
		proxy:OnKeyTime2( 532, "OnEvent_532_08",  160.0, 0,  8, once );
		proxy:OnKeyTime2( 532, "OnEvent_532_09",  180.0, 0,  9, once );
		proxy:OnKeyTime2( 532, "OnEvent_532_10",  200.0, 0, 10, once );
		
		proxy:OnKeyTime2( 532, "OnEvent_532_11",  220.0, 0, 11, once );
		proxy:OnKeyTime2( 532, "OnEvent_532_12",  240.0, 0, 12, once );
		proxy:OnKeyTime2( 532, "OnEvent_532_13",  260.0, 0, 13, once );
		proxy:OnKeyTime2( 532, "OnEvent_532_14",  280.0, 0, 14, once );
		proxy:OnKeyTime2( 532, "OnEvent_532_15",  300.0, 0, 15, once );
		
		proxy:OnKeyTime2( 532, "OnEvent_532_16",  320.0, 0, 16, once );
		proxy:OnKeyTime2( 532, "OnEvent_532_17",  340.0, 0, 17, once );
		proxy:OnKeyTime2( 532, "OnEvent_532_18",  360.0, 0, 18, once );
		proxy:OnKeyTime2( 532, "OnEvent_532_19",  380.0, 0, 19, once );
		proxy:OnKeyTime2( 532, "OnEvent_532_20",  400.0, 0, 20, once );
	proxy:NotNetMessage_end();	
]]

	--��560��PC�����Ɖ��ė������鏰1��
	if proxy:IsCompleteEvent(560) == false then
		proxy:OnRegionIn(560,10000,2270,"OnEvent_560",once);
	else
		--OBJ�j��Č�
		proxy:ReconstructBreak(1290,1);
	end
	
	--��561��PC�����Ɖ��ė������鏰2��
	if proxy:IsCompleteEvent(561) == false then
		proxy:OnRegionIn(561,10000,2275,"OnEvent_561",once);
	else
		--OBJ�j��Č�
		proxy:ReconstructBreak(1295,1);
	end
	
	--��562��PC�����Ɖ��ė������鏰3��
	if proxy:IsCompleteEvent(562) == false then
		proxy:OnRegionIn(562,10000,2280,"OnEvent_562",once);
	else
		--OBJ�j��Č�
		proxy:ReconstructBreak(1300,1);
	end
	
	--��563��PC�����Ɖ��ė������鏰4��
	if proxy:IsCompleteEvent(563) == false then
		proxy:OnRegionIn(563,10000,2285,"OnEvent_563",once);
	else
		--OBJ�j��Č�
		proxy:ReconstructBreak(1305,1);
	end
	
	--��564��PC�����Ɖ��ė������鏰5��
	if proxy:IsCompleteEvent(564) == false then
		proxy:OnRegionIn(564,10000,2290,"OnEvent_564",once);
	else
		--OBJ�j��Č�
		proxy:ReconstructBreak(1310,1);
	end
	
	--��565��PC�����Ɖ��ė������鏰6��
	if proxy:IsCompleteEvent(565) == false then
		proxy:OnRegionIn(565,10000,2295,"OnEvent_565",once);
	else
		--OBJ�j��Č�
		proxy:ReconstructBreak(1315,1);
	end
	
	--��566��PC�����Ɖ��ė������鏰7��
	if proxy:IsCompleteEvent(566) == false then
		proxy:OnRegionIn(566,10000,2300,"OnEvent_566",once);
	else
		--OBJ�j��Č�
		proxy:ReconstructBreak(1320,1);
	end
	
	--��567��PC�����Ɖ��ė������鏰8��
	if proxy:IsCompleteEvent(567) == false then
		proxy:OnRegionIn(567,10000,2305,"OnEvent_567",once);
	else
		--OBJ�j��Č�
		proxy:ReconstructBreak(1325,1);
	end
	
	--��568��PC�����Ɖ��ė������鏰9��
	if proxy:IsCompleteEvent(568) == false then
		proxy:OnRegionIn(568,10000,2310,"OnEvent_568",once);
	else
		--OBJ�j��Č�
		proxy:ReconstructBreak(1330,1);
	end

	--��569��PC�����Ɖ��ė������鏰10��
	if proxy:IsCompleteEvent(569) == false then
		proxy:OnRegionIn(569,10000,2315,"OnEvent_569",once);
	else
		--OBJ�j��Č�
		proxy:ReconstructBreak(1335,1);
	end
	
	--��570��PC�����Ɖ��ė������鏰11��
	if proxy:IsCompleteEvent(570) == false then
		proxy:OnRegionIn(570,10000,2320,"OnEvent_570",once);
	else
		--OBJ�j��Č�
		proxy:ReconstructBreak(1340,1);
	end
	
	--��571��PC�����Ɖ��ė������鏰12��
	if proxy:IsCompleteEvent(571) == false then
		proxy:OnRegionIn(571,10000,2325,"OnEvent_571",once);
	else
		--OBJ�j��Č�
		proxy:ReconstructBreak(1345,1);
	end
	
	--��540���C�G�e�B�o�ꁡ		
	if proxy:IsCompleteEvent( 540 ) == false then
		proxy:OnPlayerDistanceAngleInTarget( 540, 10000, 200, "OnEvent_540", 10.0, 180.0, once );
	end
		
	--���v���i���A�s�i�� OnEvent_701_start
	
	local first_event_id         = 701;--���Ԃ�A�ԂƎv����
	local first_event_id_of_dead = 801;
	local first_pranaria_id      = 101;
--	local pranaria_num           = 20; -- ����6�C ���߂���20�C --���₵����A�n���h���������B(�萔�ɒu��������)
	
	local now_event_id         = first_event_id;
	local now_event_id_of_dead = first_event_id_of_dead;
	local now_pranaria_id      = first_pranaria_id;
	
	for i=1 , PURANARI_NUM , 1 do
	
		print( "add pranaria_id = " .. now_pranaria_id );
		
		if proxy:IsCompleteEvent( now_event_id ) == false then
			
			proxy:RepeatMessage_begin();
				proxy:OnKeyTime2( now_event_id , "OnEvent_"..now_event_id.."_start" , 0.0 , 0 , 1 , once );--�C�x���g�J�n�p(�̈�i���Ď�)
			--	proxy:OnSimpleDamage( now_event_id , now_pranaria_id , 10000 , "OnEvent_"..now_event_id.."_damage", once );--�_���[�W���󂯂��Ƃ�				

				proxy:OnRegionJustIn( now_event_id , now_pranaria_id , PURANARI_DEAD_REGION_ID_1 , "OnEvent_"..now_event_id.."_force_dead" , once );--���̉�������
				proxy:OnRegionJustIn( now_event_id , now_pranaria_id , PURANARI_DEAD_REGION_ID_2 , "OnEvent_"..now_event_id.."_force_dead" , once );--�R�̉�������
			
			--	proxy:NotNetMessage_begin();				
				proxy:OnCharacterDead( now_event_id_of_dead , now_pranaria_id , "OnEvent_"..now_event_id_of_dead.."_dead" , once );--���S�Ď�
			--	proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();
			
		end
		
		now_event_id         = now_event_id + 1;
		now_event_id_of_dead = now_event_id_of_dead + 1;
		now_pranaria_id      = now_pranaria_id + 1;
	end
	
	--�����p�̃C�x���g(�z�X�g����) --ID�K��
	if proxy:IsInParty() == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegistFunc( 1000 , "Pranaria_Dead_Check_A" , "Pranaria_Alive_A" , 1 , everytime );
			proxy:OnRegistFunc( 1001 , "Pranaria_Dead_Check_B" , "Pranaria_Alive_B" , 1 , everytime );
			proxy:OnRegistFunc( 1002 , "Pranaria_Dead_Check_C" , "Pranaria_Alive_C" , 1 , everytime );
			proxy:OnRegistFunc( 1003 , "Pranaria_Dead_Check_D" , "Pranaria_Alive_D" , 1 , everytime );
			proxy:OnRegistFunc( 1004 , "Pranaria_Dead_Check_E" , "Pranaria_Alive_E" , 1 , everytime );
			proxy:OnRegistFunc( 1005 , "Pranaria_Dead_Check_F" , "Pranaria_Alive_F" , 1 , everytime );
			proxy:OnRegistFunc( 1006 , "Pranaria_Dead_Check_G" , "Pranaria_Alive_G" , 1 , everytime );
		proxy:NotNetMessage_end();
	end
	
	--test�@�s�񂵂Ă�v���i���A�S�����S�p
	--proxy:LuaCall( 1111 , 1 , "ALL_PRANARIA_DEAD" , everytime );	

	
	--1100 �\���̂Ƃ��ɓ����p�̃��X�g�𑽏d�ɏ��������Ȃ��悤�ɂ��邽�߂Ɏg�p
	
	--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m07_00_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m07_00_00_00", everytime );
	proxy:NotNetMessage_end();	
	
	
	print("Initialize_m07_00_00_00 end");
end


--[[
--test �s�񂵂Ă�v���i���A�S�����S
function ALL_PRANARIA_DEAD(proxy ,param)

	for i=1, PURANARI_NUM, 1 do
		proxy:ForceDead( 100 + i );
	end

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
function Second_Initialize_m07_00_00_00(proxy, param)
	print("Second_Initialize_m07_00_00_00 begin");

	--���v���i���A�s�i�p�̏�������

	
--[[	
	--��C�ȊO�Ƃ߂Ă���
	for i=102, 140 , 1 do
	
		proxy:EnableLogic( i , false );
		
	end
]]	
	

	
	

	--�z�X�g�����s��������
	if proxy:IsInParty() == false then
	
		--�W�F�l���[�^�̎��̏�񏉊���(�Ȃɂ��Ȃ����)
	
		for i=1, PURANARI_NUM, 1 do
			dead_pranaria_list_A[i] = 0;
			dead_pranaria_list_B[i] = 0;
			dead_pranaria_list_C[i] = 0;
			dead_pranaria_list_D[i] = 0;
			dead_pranaria_list_E[i] = 0;
			dead_pranaria_list_F[i] = 0;
			dead_pranaria_list_G[i] = 0;
		end

--[[
		--�v���i���A���ڎw���ŏ��̗̈�(�f�t�H���g�l)���w��
		--�V���O���v���C�̂Ƃ��ɐ������S�[�X�g�ɂȂ�ƁA
		--�X�N���v�g�ǂݒ����ă��X�g������������Ă��܂�����
		--���̏�������1�x�����s��Ȃ��悤�ɂ���K�v������B
		
		if proxy:IsCompleteEvent( 1100 ) == false then

			for i=101, 120, 1 do puranaria_region_id_list[i] = 2501; end
			for i=121, 125, 1 do puranaria_region_id_list[i] = 2421; end
			for i=126, 130, 1 do puranaria_region_id_list[i] = 2431; end
			for i=131, 135, 1 do puranaria_region_id_list[i] = 2441; end
			for i=136, 140, 1 do puranaria_region_id_list[i] = 2502; end
			
			proxy:SetEventFlag( 1100 , 1 );
		end
]]

		--�����p�̃t���O�Z�b�g(�ڕW�Ƃ���̈�̔ԍ����t���O�ɕϊ�)	
		for i=1, PURANARI_NUM, 1 do
		
			local pranaria_id = 100 + i;
			local target_region_id = puranaria_region_id_list[ pranaria_id ];
			
			local offset = target_region_id - PURANARI_REGION_FIRST_ID;
		
			--�t���O�ɕϊ�
			local index = pranaria_id - 100 - 1;--(ID��101�̃v���i���A��index=0 �ŏ��̃v���i���A)
			local first_event_id  = PURANARIA_USE_ID_START + index * ONCE_PURANARIA_USE_ID;

			local set_flag_list = {};
			set_flag_list = DesimalToBinary_7bit( proxy,param,offset );
			
			local now_event_id = first_event_id;
			
		--	print( "pranaria_id = " .. pranaria_id );
		--	print_list_7bit( proxy , param , set_flag_list );
			for i=1, ONCE_PURANARIA_USE_ID, 1 do
				proxy:SetEventFlag( now_event_id , set_flag_list[i] );
				now_event_id = now_event_id + 1;
			end
			
		end
		
	end



	--���C�G�e�B
	if proxy:IsCompleteEvent( 540 ) == false then
		InvalidCharactor( proxy , 200 );
	else
		ValidCharactor( proxy , 200 );
	end
	
	
--[[
	--�v���i���A����
	for evID = 101, 120, 1 do
		local_chr_set_func(proxy,evID,false);
	end
]]

--[[
	--���p�j�f�[�����p (�t���O�͉��A�w�肪����Ες���)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m07_00_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m07_00_00_00);
	end
]]


	print("Second_Initialize_m07_00_00_00 end");
end


--------------------------------------------------------------------------------------
--��512���Β��Ƀ��[�v��
--------------------------------------------------------------------------------------
--��512���Β��Ƀ��[�v��
function OnEvent_512(proxy,param)	
	print("OnEvent_512 begin");
	
	proxy:WarpNextStage( 1, 0, 0, 0, 1011 );
	
	print("OnEvent_512 end");
end


--------------------------------------------------------------------------------------
--��522�����{�X�����ւ̔����J����
--------------------------------------------------------------------------------------
--��522�����{�X�����ւ̔����J����
function OnEvent_522(proxy, param)
	print("OnEvent_522 begin")
	
	proxy:PlayAnimation( 1120, 1 );
	
	proxy:NotNetMessage_begin();
		--��522_2��***�����ǉ�***���A�j���I����
		proxy:OnCharacterAnimEnd( 522, 1120, 1, "OnEvent_522_2", once );
	proxy:NotNetMessage_end();
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then 
		return;
	end
--[[	
	proxy:NotNetMessage_begin();
		--��522_1��***�����ǉ�***�v���C���[�A�j���I����
		proxy:OnChrAnimEnd( 522, 10000, ANIMEID_OPEN, "OnEvent_522_1", once );
	proxy:NotNetMessage_end();
]]		
--	proxy:Warp( 10000 , 2013 );		--�v���C���[������ʒu�Ƀ��[�v
--	proxy:DisableMove( 10000, 1 );	--�v���C���[�𑀍�s�\��
	
	print("OnEvent_522 end")
end

--[[
--��522_1���v���C���[�A�j���I����
function OnEvent_522_1(proxy, param)
	print("OnEvent_522_1 begin")
		
	proxy:DisableMove( 10000, 0 );	--�v���C���[�𑀍�\��
	
	print("OnEvent_522_1 end")
end
]]

--��522_2�����A�j���I����
function OnEvent_522_2(proxy, param)
	print("OnEvent_522_2 begin")
	
	--�����ŁA�|�����Đ��\��
	
	proxy:SetEventFlag( 522 , 1 );
	
	print("OnEvent_522_2 end")
end


--------------------------------------------------------------------------------------
--��6287�����{�X���S�Ŕ����J����
--------------------------------------------------------------------------------------
--��6287�����{�X���S�Ŕ����J����
function OnEvent_6287(proxy,param)	
	print("OnEvent_6287 begin");

	proxy:NotNetMessage_begin();
		--��6287_1��1�b�づ
		proxy:OnKeyTime2( 6287 , "OnEvent_6287_1" , 1.0 , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 6287 , 1 );
	
	print("OnEvent_6287 end");
end

--��6287_1��1�b�っ
function OnEvent_6287_1(proxy,param)
	print("OnEvent_6287_1 begin");

	--���̃u���b�N�ւ̔����J���A�j�����Đ�
	
	print("OnEvent_6287_1 end");
end





--------------------------------------------------------------------------------------
--�v���i���A�e�X�g��532
--------------------------------------------------------------------------------------
function local_chr_set_func(proxy,event_id, enable )
	proxy:EnableLogic( event_id, enable );
	proxy:SetDrawEnable( event_id, enable );
	proxy:SetColiEnable( event_id, enable );
end
--��532���v���i���A�e�X�g��
function OnEvent_532_01(proxy,param)	
	print("OnEvent_532_01 begin");
	local_chr_set_func(proxy,101, true);
	print("OnEvent_532_01 end");
end
function OnEvent_532_02(proxy,param)	
	print("OnEvent_532_02 begin");
	local_chr_set_func(proxy,102, true);
	print("OnEvent_532_02 end");
end
function OnEvent_532_03(proxy,param)	
	print("OnEvent_532_03 begin");
	local_chr_set_func(proxy,103, true);
	print("OnEvent_532_03 end");
end
function OnEvent_532_04(proxy,param)	
	print("OnEvent_532_04 begin");
	local_chr_set_func(proxy,104, true);
	print("OnEvent_532_04 end");
end
function OnEvent_532_05(proxy,param)	
	print("OnEvent_532_05 begin");
	local_chr_set_func(proxy,105, true);
	print("OnEvent_532_05 end");
end

function OnEvent_532_06(proxy,param)	
	print("OnEvent_532_06 begin");
	local_chr_set_func(proxy,106, true);
	print("OnEvent_532_06 end");
end
function OnEvent_532_07(proxy,param)	
	print("OnEvent_532_07 begin");
	local_chr_set_func(proxy,107, true);
	print("OnEvent_532_07 end");
end
function OnEvent_532_08(proxy,param)	
	print("OnEvent_532_08 begin");
	local_chr_set_func(proxy,108, true);
	print("OnEvent_532_08 end");
end
function OnEvent_532_09(proxy,param)	
	print("OnEvent_532_09 begin");
	local_chr_set_func(proxy,109, true);
	print("OnEvent_532_09 end");
end
function OnEvent_532_10(proxy,param)	
	print("OnEvent_532_10 begin");
	local_chr_set_func(proxy,110, true);
	print("OnEvent_532_10 end");
end


function OnEvent_532_11(proxy,param)	
	print("OnEvent_532_11 begin");
	local_chr_set_func(proxy,111, true);
	print("OnEvent_532_11 end");
end
function OnEvent_532_12(proxy,param)	
	print("OnEvent_532_12 begin");
	local_chr_set_func(proxy,112, true);
	print("OnEvent_532_12 end");
end
function OnEvent_532_13(proxy,param)	
	print("OnEvent_532_13 begin");
	local_chr_set_func(proxy,113, true);
	print("OnEvent_532_13 end");
end
function OnEvent_532_14(proxy,param)	
	print("OnEvent_532_14 begin");
	local_chr_set_func(proxy,114, true);
	print("OnEvent_532_14 end");
end
function OnEvent_532_15(proxy,param)	
	print("OnEvent_532_15 begin");
	local_chr_set_func(proxy,115, true);
	print("OnEvent_532_15 end");
end


function OnEvent_532_16(proxy,param)	
	print("OnEvent_532_16 begin");
	local_chr_set_func(proxy,116, true);
	print("OnEvent_532_16 end");
end
function OnEvent_532_17(proxy,param)	
	print("OnEvent_532_17 begin");
	local_chr_set_func(proxy,117, true);
	print("OnEvent_532_17 end");
end
function OnEvent_532_18(proxy,param)	
	print("OnEvent_532_18 begin");
	local_chr_set_func(proxy,118, true);
	print("OnEvent_532_18 end");
end
function OnEvent_532_19(proxy,param)	
	print("OnEvent_532_19 begin");
	local_chr_set_func(proxy,119, true);
	print("OnEvent_532_19 end");
end
function OnEvent_532_20(proxy,param)	
	print("OnEvent_532_20 begin");
	local_chr_set_func(proxy,120, true);
	print("OnEvent_532_20 end");
end

--[[----------------------------------------------------------------------------------
--���j��p�̔ėp�֐�����FloorBreak		�c��������Ėڈ��̕�������ƌ����Ŏ����ɔ�ׂ邩��֗���
--proxy		�c�v���L�V
--param		�c�l�b�g�f�[�^�p�����[�^
--eventid	�c�ėp�֐��ɓ�����C�x���gID
--objid		�c�j��OBJ��ID
------------------------------------------------------------------------------------]]
function FloorBreak( proxy, param, eventid, objid )
	
	print("OnEvent_"..eventid.." begin");	
	--�j��`�F�b�N
	if proxy:IsDestroyed( objid ) == true then
		print("ID "..objid.." IsDestroyed true");
		print("OnEvent_"..eventid.." end");
		return;
	end
	--OBJ�j����s
	proxy:ChangeModel(objid,1);
	--�j��OBJ�ł��鎖��ʒm
	proxy:SetBrokenPiece(objid);
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( eventid , "OnEvent_"..eventid.."_1",FloorBreak_KeyTime,0,0,once);
	proxy:NotNetMessage_end();
	print("OnEvent_"..eventid.." end");
end

--------------------------------------------------------------------------------------
--PC�����Ɖ��ė������鏰1��560
--------------------------------------------------------------------------------------
function OnEvent_560(proxy,param)
	--�ėp�j��֐�
	FloorBreak(proxy,param,560,1290);
end

--��560_1��
function OnEvent_560_1(proxy,param)
	--�C�x���g�t���O�ݒ�
	proxy:SetEventFlag(560,true);
	--���f���`�������
	proxy:SetDrawEnable(1290,false);
end


--------------------------------------------------------------------------------------
--PC�����Ɖ��ė������鏰2��561
--------------------------------------------------------------------------------------
function OnEvent_561(proxy,param)
	--�ėp�j��֐�
	FloorBreak(proxy,param,561,1295);
end

--��561_1��
function OnEvent_561_1(proxy,param)
	--�C�x���g�t���O�ݒ�
	proxy:SetEventFlag(561,true);
	--���f���`�������
	proxy:SetDrawEnable(1295,false);
end


--------------------------------------------------------------------------------------
--PC�����Ɖ��ė������鏰3��562
--------------------------------------------------------------------------------------
function OnEvent_562(proxy,param)	
	--�ėp�j��֐�
	FloorBreak(proxy,param,562,1300);
end

--��562_1��
function OnEvent_562_1(proxy,param)
	--�C�x���g�t���O�ݒ�
	proxy:SetEventFlag(562,true);
	--���f���`�������
	proxy:SetDrawEnable(1300,false);
end


--------------------------------------------------------------------------------------
--PC�����Ɖ��ė������鏰4��563
--------------------------------------------------------------------------------------
function OnEvent_563(proxy,param)
	--�ėp�j��֐�
	FloorBreak(proxy,param,563,1305);
end

--��563_1��
function OnEvent_563_1(proxy,param)
	--�C�x���g�t���O�ݒ�
	proxy:SetEventFlag(563,true);
	--���f���`�������
	proxy:SetDrawEnable(1305,false);
end


--------------------------------------------------------------------------------------
--PC�����Ɖ��ė������鏰5��564
--------------------------------------------------------------------------------------
function OnEvent_564(proxy,param)
	--�ėp�j��֐�
	FloorBreak(proxy,param,564,1310);
end

--��564_1��
function OnEvent_564_1(proxy,param)
	--�C�x���g�t���O�ݒ�
	proxy:SetEventFlag(564,true);	
	--���f���`�������
	proxy:SetDrawEnable(1310,false);
end


--------------------------------------------------------------------------------------
--PC�����Ɖ��ė������鏰6��565
--------------------------------------------------------------------------------------
function OnEvent_565(proxy,param)
	--�ėp�j��֐�
	FloorBreak(proxy,param,565,1315);
end

--��565_1��
function OnEvent_565_1(proxy,param)
	--�C�x���g�t���O�ݒ�
	proxy:SetEventFlag(565,true);
	--���f���`�������
	proxy:SetDrawEnable(1315,false);
end


--------------------------------------------------------------------------------------
--PC�����Ɖ��ė������鏰7��566
--------------------------------------------------------------------------------------
function OnEvent_566(proxy,param)
	--�ėp�j��֐�
	FloorBreak(proxy,param,566,1320);
end

--��566_1��
function OnEvent_566_1(proxy,param)
	--�C�x���g�t���O�ݒ�
	proxy:SetEventFlag(566,true);
	--���f���`�������
	proxy:SetDrawEnable(1320,false);
end


--------------------------------------------------------------------------------------
--PC�����Ɖ��ė������鏰8��567
--------------------------------------------------------------------------------------
function OnEvent_567(proxy,param)
	--�ėp�j��֐�
	FloorBreak(proxy,param,567,1325);
end

--��567_1��
function OnEvent_567_1(proxy,param)
	--�C�x���g�t���O�ݒ�
	proxy:SetEventFlag(567,true);
	--���f���`�������
	proxy:SetDrawEnable(1325,false);
end


--------------------------------------------------------------------------------------
--PC�����Ɖ��ė������鏰9��568
--------------------------------------------------------------------------------------
function OnEvent_568(proxy,param)
	--�ėp�j��֐�
	FloorBreak(proxy,param,568,1330);
end

--��568_1��
function OnEvent_568_1(proxy,param)
	--�C�x���g�t���O�ݒ�
	proxy:SetEventFlag(568,true);
	--���f���`�������
	proxy:SetDrawEnable(1330,false);
end


--------------------------------------------------------------------------------------
--PC�����Ɖ��ė������鏰10��569
--------------------------------------------------------------------------------------
function OnEvent_569(proxy,param)
	--�ėp�j��֐�
	FloorBreak(proxy,param,569,1335);
end

--��569_1��
function OnEvent_569_1(proxy,param)
	--�C�x���g�t���O�ݒ�
	proxy:SetEventFlag(569,true);
	--���f���`�������
	proxy:SetDrawEnable(1335,false);
end


--------------------------------------------------------------------------------------
--PC�����Ɖ��ė������鏰11��570
--------------------------------------------------------------------------------------
function OnEvent_570(proxy,param)
	--�ėp�j��֐�
	FloorBreak(proxy,param,570,1340);
end

--��570_1��
function OnEvent_570_1(proxy,param)
	--�C�x���g�t���O�ݒ�
	proxy:SetEventFlag(570,true);
	--���f���`�������
	proxy:SetDrawEnable(1340,false);
end

--------------------------------------------------------------------------------------
--PC�����Ɖ��ė������鏰12��571
--------------------------------------------------------------------------------------
function OnEvent_571(proxy,param)
	--�ėp�j��֐�
	FloorBreak(proxy,param,571,1345);
end

--��571_1��
function OnEvent_571_1(proxy,param)
	--�C�x���g�t���O�ݒ�
	proxy:SetEventFlag(571,true);
	--���f���`�������
	proxy:SetDrawEnable(1345,false);
end




--------------------------------------------------------------------------------------
--�v���i���A�s�i��
--------------------------------------------------------------------------------------

--���ėp�֐�(�̈�i���p)

function Pranaria_Region_Just_In(proxy, param, event_id, pranaria_id)

--proxy:PlayLoopAnimation( pranaria_id  , 210 );


--[[
	if param:IsNetMessage() == true then
		return;
	end
]]	
	
	--�t���O����Ƃ��Ă���B
	local index = pranaria_id - 100 - 1;
	local first_event_id  = PURANARIA_USE_ID_START + index * ONCE_PURANARIA_USE_ID;
			
	local end_event_id    = first_event_id + ONCE_PURANARIA_USE_ID - 1;
	local now_event_id    = first_event_id;
	
	local offset = 0;		
	local binary_list = {};

	for i=1, ONCE_PURANARIA_USE_ID, 1 do
		if proxy:IsCompleteEvent( now_event_id ) == true then
			binary_list[i] = 1;
		elseif proxy:IsCompleteEvent( now_event_id ) == false then
			binary_list[i] = 0;
		end
		now_event_id = now_event_id + 1;
	end
	
--	print_list_7bit( proxy , param , binary_list );
	
	local desimal_number = 0;
	desimal_number = BinaryToDesimal_7bit( proxy , param , binary_list );--proxy,param�����Ă���
	offset = desimal_number;


	local target_region_id = PURANARI_REGION_FIRST_ID + offset;
	print( "pranaria_id = " .. pranaria_id .. " target_region_id = " .. target_region_id);
	puranaria_region_id_list[ pranaria_id ] = target_region_id;

	
	
	local region_id = puranaria_region_id_list[ pranaria_id ];
	
	proxy:ResetThink( pranaria_id );
	--AI�̃p�X�ړ��ňړ�(���W�b�N��ON�ł���K�v������)
	MoveRegion( proxy , pranaria_id , region_id , -1 , 0.0 , true );
	
--	proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnRegionJustIn( event_id , pranaria_id , region_id , "OnEvent_"..event_id.."_arrived" , once );
		proxy:RepeatMessage_end();
--	proxy:NotNetMessage_end();

end



function Pranaria_Region_Just_In_End(proxy, param, event_id, pranaria_id)
	
		
	--�ړI�n�����ɐi�߂�
	local region_id = puranaria_region_id_list[ pranaria_id ];
	local next_region_id = region_id;--�ЂƂ܂��R�s�[�B
	
	
	
--�v���i���A���Ō�̃��[�g�ɂ������Ƃ�

--[[
	if next_region_id == PURANARI_REGION_END_ID then 
		proxy:EnableLogic( pranaria_id , true );
		proxy:DeleteEvent( event_id );
		proxy:ForceDead( pranaria_id );--�̈�̍Ō�܂ł�������A�ЂƂ܂��������S
		return;
	end	
]]	

--[[	
	--���鏰�̉��̗̈�������玀��
	if next_region_id == PURANARI_DEAD_REGION_ID_1 then
		proxy:EnableLogic( pranaria_id , true );
		proxy:DeleteEvent( event_id );
		proxy:ForceDead( pranaria_id );
		return;
	end
	

	--�Ō�̊R�̉��̗̈�������玀��
	if next_region_id == PURANARI_DEAD_REGION_ID_2 then
		proxy:EnableLogic( pranaria_id , true );
		proxy:DeleteEvent( event_id );
		proxy:ForceDead( pranaria_id );
		return;
	end
]]	
	
	
	
	
--�e�X�g�p
--[[
--	���[�g�P�`�U�͍Ō�܂ł����Ə���ɂ����Ď��ʂ���ǁA���͂��ȂȂ��Ȃ��Ă���̂ŁA�E���Ă����B
	--�ړI�n�ɓ��B�����Ƃ��̏���
	if next_region_id == PURANARI_REGION_END_ID then 
		proxy:EnableLogic( pranaria_id , true );
		proxy:DeleteEvent( event_id );
		proxy:ForceDead( pranaria_id );--�̈�̍Ō�܂ł�������A�ЂƂ܂��������S
		return;
	end	
	

--���[�g�V�͕��n�ɂȂ��Ă��邩��ǂ�����̂��s���B�ړI�|�C���g���Ȃ��Ȃ�Ƃ܂����̂�
--�ЂƂ܂����S�����Ă���

	if next_region_id == PURANARI_REGION_END_ID_ROOT_7 then
		proxy:EnableLogic( pranaria_id , true );
		proxy:DeleteEvent( event_id );
		proxy:ForceDead( pranaria_id );--�̈�̍Ō�܂ł�������A�ЂƂ܂��������S
		return;
	end


--���鏰�̉��ɂ������Ղ�Ȃ肠�����ʂ͂������ǂ��ȂȂ��̂ŁA���B������E���Ă���
	if next_region_id == 2503 then 
		proxy:EnableLogic( pranaria_id , true );
		proxy:DeleteEvent( event_id );
		proxy:ForceDead( pranaria_id );--�̈�̍Ō�܂ł�������A�ЂƂ܂��������S
		return;
	end
]]	

	
	--�W���n�_�̃|�C���g���Ȃ�
	if     region_id == 2411 then next_region_id = 2501; --���[�g1
	elseif region_id == 2421 then next_region_id = 2501; --���[�g2
	elseif region_id == 2431 then next_region_id = 2501; --���[�g3
	elseif region_id == 2441 then next_region_id = 2502; --���[�g4
	elseif region_id == 2451 then next_region_id = 2505; --���[�g5
	elseif region_id == 2461 then next_region_id = 2506; --���[�g6
		
	--����鏰�̎�O�̕���(�������Ă���Ƃ��i�s������ς���)
	elseif region_id == 2502 then
		if proxy:IsCompleteEvent( 560 ) == true then--����鏰�̃C�x���g�I��
			next_region_id = 2520;
		else
			next_region_id = region_id + 1;
		end
		
	--������Ă�Ƃ��Ɍ���������������ʏ탋�[�g�ւ̂Ȃ�
	elseif region_id == 2521 then next_region_id = 2504;
	
	--����ȊO�͘A��
	else next_region_id = region_id + 1; end

	
	puranaria_region_id_list[ pranaria_id ] = next_region_id;
	

--[[�ЂƂ܂��R�����g�A�E�g

	--�ړI�n�ɓ��B�����Ƃ��̏���
	if next_region_id > PURANARI_REGION_END_ID then 
		proxy:EnableLogic( pranaria_id , true );
		proxy:DeleteEvent( event_id );
		proxy:ForceDead( pranaria_id );--�̈�̍Ō�܂ł�������A�ЂƂ܂��������S
		return;
	end
]]	
	
	--�����p�̃t���O���X�V
	local index = pranaria_id - 100 - 1;--(ID��101�̃v���i���A��index=0 �ŏ��̃v���i���A)
	local first_event_id  = PURANARIA_USE_ID_START + index * ONCE_PURANARIA_USE_ID;

	local set_region_id_offset = next_region_id - PURANARI_REGION_FIRST_ID;
	local set_flag_list = {};
	set_flag_list = DesimalToBinary_7bit( proxy,param,set_region_id_offset );
	
	local now_event_id = first_event_id;
	
--	print( "pranaria_id = " .. pranaria_id );
--	print_list_7bit( proxy , param , set_flag_list );
	for i=1, ONCE_PURANARIA_USE_ID, 1 do
		proxy:SetEventFlag( now_event_id , set_flag_list[i] );
		now_event_id = now_event_id + 1;
	end

	
	proxy:ResetThink( pranaria_id );
	--AI�̃p�X�ړ��ňړ�(���W�b�N��ON�ł���K�v������)
	MoveRegion( proxy , pranaria_id , next_region_id , -1 , 0.0 , true );
	
--	proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnRegionJustIn( event_id , pranaria_id , next_region_id , "OnEvent_"..event_id.."_arrived" , once );
		proxy:RepeatMessage_end();
--	proxy:NotNetMessage_end();

end


--[[
--���ėp�֐�(�_���[�W���󂯂��Ƃ� �U�����ꂽ�瑦������)

function Pranaria_Damage(proxy, param, event_id, pranaria_id)
--[[
	if param:IsNetMessage() == true then
		return;
	end
]]
	--�U�����󂯂����Ƃ������Ă�����A�������S�B
	if proxy:IsAlive( pranaria_id ) == true then
		proxy:ForceDead( pranaria_id );--�������S(�A�j�����Đ������)
	end
	
end
]]


--���ėp�֐�(���S�������p)

--PRANARIA_ALIVE_INTERVAL_TIME = 10.0;--���S���Ă��畜������܂ł̎���
--GO_TO_GENERATER_TIME = 5.0;

function Pranaria_Dead(proxy, param, event_id, event_id_of_dead, pranaria_id)
--[[
	if param:IsNetMessage() == true then
		return;
	end
]]	
	proxy:DeleteEvent( event_id ); --���݂̃v���i���A�ɑ΂��鎀�S�Ď��ȊO�̃C�x���g������
	
	
	--�W�F�l���[�^�Ǘ��̓z�X�g�̂ݍs��
	
	if proxy:IsInParty() == false or proxy:IsHost() == true then

		--��������������W�F�l���[�^�ɔ���(�ŏ��ɖڎw���̈���w�肵�Ă��܂�?)

		local generater_id = puranaria_generater_id_list[ pranaria_id ];

		--�W�F�l���[�^A
		if generater_id == GENERATER_POINT_A then
			
			--���̒u����ꏊ���邩�T��(�O�̂���)
			local find_index = -1;
			for i=1, PURANARI_NUM, 1 do
				if dead_pranaria_list_A[i] == 0 then
					find_index = i;
					break;
				end
			end
			
			if find_index ~= -1 then
				proxy:Warp( pranaria_id , generater_id );--���񂾂瑦���̒u��������B
				dead_pranaria_list_A[ find_index ] = pranaria_id;
				print("set dead_pranaria_list_A at " .. find_index .. " id " .. pranaria_id );
			
				--�W�F�l���[�^�ŕ����������Ƃɍŏ��ɖڎw���̈���w��
				puranaria_region_id_list[ pranaria_id ] = GENERATER_POINT_A_NEXT_REGION;
			else
				print( "not empty" );
			end
		
		--�W�F�l���[�^B
		elseif generater_id == GENERATER_POINT_B then
		
			--���̒u����ꏊ���邩�T��(�O�̂���)
			local find_index = -1;
			for i=1, PURANARI_NUM, 1 do
				if dead_pranaria_list_B[i] == 0 then
					find_index = i;
					break;
				end
			end
			
			if find_index ~= -1 then
				proxy:Warp( pranaria_id , generater_id );--���񂾂瑦���̒u��������B
				dead_pranaria_list_B[ find_index ] = pranaria_id;
				print("set dead_pranaria_list_B at " .. find_index .. " id " .. pranaria_id );
			
				--�W�F�l���[�^�ŕ����������Ƃɍŏ��ɖڎw���̈���w��
				puranaria_region_id_list[ pranaria_id ] = GENERATER_POINT_B_NEXT_REGION;
			else
				print( "not empty" );
			end
	
		--�W�F�l���[�^C
		elseif generater_id == GENERATER_POINT_C then
		
			--���̒u����ꏊ���邩�T��(�O�̂���)
			local find_index = -1;
			for i=1, PURANARI_NUM, 1 do
				if dead_pranaria_list_C[i] == 0 then
					find_index = i;
					break;
				end
			end
			
			if find_index ~= -1 then
				proxy:Warp( pranaria_id , generater_id );--���񂾂瑦���̒u��������B
				dead_pranaria_list_C[ find_index ] = pranaria_id;
				print("set dead_pranaria_list_C at " .. find_index .. " id " .. pranaria_id );
			
				--�W�F�l���[�^�ŕ����������Ƃɍŏ��ɖڎw���̈���w��
				puranaria_region_id_list[ pranaria_id ] = GENERATER_POINT_C_NEXT_REGION;
			else
				print( "not empty" );
			end
	
		--�W�F�l���[�^D
		elseif generater_id == GENERATER_POINT_D then
		
			--���̒u����ꏊ���邩�T��(�O�̂���)
			local find_index = -1;
			for i=1, PURANARI_NUM, 1 do
				if dead_pranaria_list_D[i] == 0 then
					find_index = i;
					break;
				end
			end
			
			if find_index ~= -1 then
				proxy:Warp( pranaria_id , generater_id );--���񂾂瑦���̒u��������B
				dead_pranaria_list_D[ find_index ] = pranaria_id;
				print("set dead_pranaria_list_D at " .. find_index .. " id " .. pranaria_id );
			
				--�W�F�l���[�^�ŕ����������Ƃɍŏ��ɖڎw���̈���w��
				puranaria_region_id_list[ pranaria_id ] = GENERATER_POINT_D_NEXT_REGION;
			else
				print( "not empty" );
			end
	
		--�W�F�l���[�^E
		elseif generater_id == GENERATER_POINT_E then
		
			--���̒u����ꏊ���邩�T��(�O�̂���)
			local find_index = -1;
			for i=1, PURANARI_NUM, 1 do
				if dead_pranaria_list_E[i] == 0 then
					find_index = i;
					break;
				end
			end
			
			if find_index ~= -1 then
				proxy:Warp( pranaria_id , generater_id );--���񂾂瑦���̒u��������B
				dead_pranaria_list_E[ find_index ] = pranaria_id;
				print("set dead_pranaria_list_E at " .. find_index .. " id " .. pranaria_id );
			
				--�W�F�l���[�^�ŕ����������Ƃɍŏ��ɖڎw���̈���w��
				puranaria_region_id_list[ pranaria_id ] = GENERATER_POINT_E_NEXT_REGION;
			else
				print( "not empty" );
			end
	
		--�W�F�l���[�^F
		elseif generater_id == GENERATER_POINT_F then
		
			--���̒u����ꏊ���邩�T��(�O�̂���)
			local find_index = -1;
			for i=1, PURANARI_NUM, 1 do
				if dead_pranaria_list_F[i] == 0 then
					find_index = i;
					break;
				end
			end
			
			if find_index ~= -1 then
				proxy:Warp( pranaria_id , generater_id );--���񂾂瑦���̒u��������B
				dead_pranaria_list_F[ find_index ] = pranaria_id;
				print("set dead_pranaria_list_F at " .. find_index .. " id " .. pranaria_id );
			
				--�W�F�l���[�^�ŕ����������Ƃɍŏ��ɖڎw���̈���w��
				puranaria_region_id_list[ pranaria_id ] = GENERATER_POINT_F_NEXT_REGION;
			else
				print( "not empty" );
			end
	
		--�W�F�l���[�^G
		elseif generater_id == GENERATER_POINT_G then
		
			--���̒u����ꏊ���邩�T��(�O�̂���)
			local find_index = -1;
			for i=1, PURANARI_NUM, 1 do
				if dead_pranaria_list_G[i] == 0 then
					find_index = i;
					break;
				end
			end
			
			if find_index ~= -1 then
				proxy:Warp( pranaria_id , generater_id );--���񂾂瑦���̒u��������B
				dead_pranaria_list_G[ find_index ] = pranaria_id;
				print("set dead_pranaria_list_G at " .. find_index .. " id " .. pranaria_id );
			
				--�W�F�l���[�^�ŕ����������Ƃɍŏ��ɖڎw���̈���w��
				puranaria_region_id_list[ pranaria_id ] = GENERATER_POINT_G_NEXT_REGION;
			else
				print( "not empty" );
			end
	
		end

	end

end



function Pranaria_Alive(proxy, param, event_id, event_id_of_dead, pranaria_id)


	print( "pranaria id = " .. pranaria_id .. " is alive");

	proxy:SetEventFlag( event_id_of_dead , false );--�t���O��߂��āA�������Ƃ���
	
	--�����̃W�F�l���[�^�ŕ���
	
	local generater_id = puranaria_generater_id_list[ pranaria_id ];
	
	
	--��������(�ύX�������ȋC������)
	proxy:SetAlive( pranaria_id, 1.0 );
	proxy:WarpRestart( pranaria_id, generater_id );
	
	
	--���ɖڎw���̈�i���񂾎��_�Ŏw�肳��Ă���̂��擾)

	local next_region_id = puranaria_region_id_list[ pranaria_id ];
	
	--�t���O���X�V
	local index = pranaria_id - 100 - 1;--(ID��101�̃v���i���A��index=0 �ŏ��̃v���i���A)
	local first_event_id  = PURANARIA_USE_ID_START + index * ONCE_PURANARIA_USE_ID;

	local set_region_id_offset = next_region_id - PURANARI_REGION_FIRST_ID;
	local set_flag_list = {};
	set_flag_list = DesimalToBinary_7bit( proxy,param,set_region_id_offset );
	
	local now_event_id = first_event_id;
	
--	print( "pranaria_id = " .. pranaria_id );
--	print_list_7bit( proxy , param , set_flag_list );
	for i=1, ONCE_PURANARIA_USE_ID, 1 do
		proxy:SetEventFlag( now_event_id , set_flag_list[i] );
		now_event_id = now_event_id + 1;
	end

	
	proxy:RepeatMessage_begin();
		proxy:OnKeyTime2( event_id , "OnEvent_"..event_id.."_start" , 0.0 , 0 , 1 , once );--�̈�i���p
	--	proxy:OnSimpleDamage( event_id , pranaria_id , 10000 , "OnEvent_"..event_id.."_damage" , once );--�_���[�W�Ď�

		proxy:OnRegionJustIn( event_id , pranaria_id , PURANARI_DEAD_REGION_ID_1 , "OnEvent_"..event_id.."_force_dead" , once );--���̉�������
		proxy:OnRegionJustIn( event_id , pranaria_id , PURANARI_DEAD_REGION_ID_2 , "OnEvent_"..event_id.."_force_dead" , once );--�R�̉�������

	--	proxy:NotNetMessage_begin();
		proxy:OnCharacterDead( event_id_of_dead , pranaria_id , "OnEvent_"..event_id_of_dead.."_dead" , once );--���S�Ď�
	--	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	
	--��������W�F�l���[�^���z������
	--(�v���i���A���ƂɃ��[������p�̔ԍ�������̂ł�����g��)

	local now_generater_id = puranaria_generater_id_list[ pranaria_id ];
	
	local offset = now_generater_id - GENERATER_POINT_BASE_ID;--( 10�`(PRANARIA_GENERATER_NUM*10) )
	offset = offset / 10;--( 1�`GENERATER_NUM )
	
	--�z�p�̒l
	local circulation_value = puranaria_generater_id_offset_list[ (pranaria_id-100) ];--index��1����
	offset = offset + circulation_value;
	
	if offset > PRANARIA_GENERATER_NUM then
		offset = offset - PRANARIA_GENERATER_NUM;
	end
	
	
	--��������|�C���g��1�`4�܂�?
	if offset > 4 then offset = offset - 4; end
	
	
	
	local add_value = offset * 10;--( 10�`(GENERATER_NUM*10) )
	
	local generater_id = GENERATER_POINT_BASE_ID + add_value;
	
	--�Q�Ɨp�̒l�X�V
	puranaria_generater_id_list[ pranaria_id ] = generater_id;
	
	print( "circulation_value = " .. circulation_value );
	print( "generater_id = " .. generater_id );
	
end



--���C�x���g�J�n�p(�̈�i���Ď�)

function OnEvent_701_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 701, 101 ); end
function OnEvent_701_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 701, 101 ); end

function OnEvent_702_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 702, 102 ); end
function OnEvent_702_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 702, 102 ); end

function OnEvent_703_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 703, 103 ); end
function OnEvent_703_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 703, 103 ); end

function OnEvent_704_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 704, 104 ); end
function OnEvent_704_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 704, 104 ); end

function OnEvent_705_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 705, 105 ); end
function OnEvent_705_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 705, 105 ); end

function OnEvent_706_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 706, 106 ); end
function OnEvent_706_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 706, 106 ); end

function OnEvent_707_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 707, 107 ); end
function OnEvent_707_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 707, 107 ); end

function OnEvent_708_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 708, 108 ); end
function OnEvent_708_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 708, 108 ); end

function OnEvent_709_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 709, 109 ); end
function OnEvent_709_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 709, 109 ); end

function OnEvent_710_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 710, 110 ); end
function OnEvent_710_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 710, 110 ); end

function OnEvent_711_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 711, 111 ); end
function OnEvent_711_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 711, 111 ); end

function OnEvent_712_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 712, 112 ); end
function OnEvent_712_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 712, 112 ); end

function OnEvent_713_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 713, 113 ); end
function OnEvent_713_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 713, 113 ); end

function OnEvent_714_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 714, 114 ); end
function OnEvent_714_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 714, 114 ); end

function OnEvent_715_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 715, 115 ); end
function OnEvent_715_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 715, 115 ); end

function OnEvent_716_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 716, 116 ); end
function OnEvent_716_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 716, 116 ); end

function OnEvent_717_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 717, 117 ); end
function OnEvent_717_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 717, 117 ); end

function OnEvent_718_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 718, 118 ); end
function OnEvent_718_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 718, 118 ); end

function OnEvent_719_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 719, 119 ); end
function OnEvent_719_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 719, 119 ); end

function OnEvent_720_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 720, 120 ); end
function OnEvent_720_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 720, 120 ); end

function OnEvent_721_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 721, 121 ); end
function OnEvent_721_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 721, 121 ); end

function OnEvent_722_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 722, 122 ); end
function OnEvent_722_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 722, 122 ); end

function OnEvent_723_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 723, 123 ); end
function OnEvent_723_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 723, 123 ); end

function OnEvent_724_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 724, 124 ); end
function OnEvent_724_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 724, 124 ); end

function OnEvent_725_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 725, 125 ); end
function OnEvent_725_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 725, 125 ); end

function OnEvent_726_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 726, 126 ); end
function OnEvent_726_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 726, 126 ); end

function OnEvent_727_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 727, 127 ); end
function OnEvent_727_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 727, 127 ); end

function OnEvent_728_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 728, 128 ); end
function OnEvent_728_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 728, 128 ); end

function OnEvent_729_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 729, 129 ); end
function OnEvent_729_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 729, 129 ); end

function OnEvent_730_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 730, 130 ); end
function OnEvent_730_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 730, 130 ); end

function OnEvent_731_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 731, 131 ); end
function OnEvent_731_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 731, 131 ); end

function OnEvent_732_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 732, 132 ); end
function OnEvent_732_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 732, 132 ); end

function OnEvent_733_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 733, 133 ); end
function OnEvent_733_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 733, 133 ); end

function OnEvent_734_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 734, 134 ); end
function OnEvent_734_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 734, 134 ); end

function OnEvent_735_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 735, 135 ); end
function OnEvent_735_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 735, 135 ); end

function OnEvent_736_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 736, 136 ); end
function OnEvent_736_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 736, 136 ); end

function OnEvent_737_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 737, 137 ); end
function OnEvent_737_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 737, 137 ); end

function OnEvent_738_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 738, 138 ); end
function OnEvent_738_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 738, 138 ); end

function OnEvent_739_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 739, 139 ); end
function OnEvent_739_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 739, 139 ); end

function OnEvent_740_start  (proxy, param) Pranaria_Region_Just_In    ( proxy, param, 740, 140 ); end
function OnEvent_740_arrived(proxy, param) Pranaria_Region_Just_In_End( proxy, param, 740, 140 ); end

--[[
--���_���[�W�Ď�(HP�P�ɂȂ��Ă����̂ŁA�����Ă��܂��Ă�����������Ȃ�)

function OnEvent_701_damage (proxy,param) Pranaria_Damage ( proxy, param, 701, 101 ); end
function OnEvent_702_damage (proxy,param) Pranaria_Damage ( proxy, param, 702, 102 ); end
function OnEvent_703_damage (proxy,param) Pranaria_Damage ( proxy, param, 703, 103 ); end
function OnEvent_704_damage (proxy,param) Pranaria_Damage ( proxy, param, 704, 104 ); end
function OnEvent_705_damage (proxy,param) Pranaria_Damage ( proxy, param, 705, 105 ); end
function OnEvent_706_damage (proxy,param) Pranaria_Damage ( proxy, param, 706, 106 ); end
function OnEvent_707_damage (proxy,param) Pranaria_Damage ( proxy, param, 707, 107 ); end
function OnEvent_708_damage (proxy,param) Pranaria_Damage ( proxy, param, 708, 108 ); end
function OnEvent_709_damage (proxy,param) Pranaria_Damage ( proxy, param, 709, 109 ); end
function OnEvent_710_damage (proxy,param) Pranaria_Damage ( proxy, param, 710, 110 ); end
function OnEvent_711_damage (proxy,param) Pranaria_Damage ( proxy, param, 711, 111 ); end
function OnEvent_712_damage (proxy,param) Pranaria_Damage ( proxy, param, 712, 112 ); end
function OnEvent_713_damage (proxy,param) Pranaria_Damage ( proxy, param, 713, 113 ); end
function OnEvent_714_damage (proxy,param) Pranaria_Damage ( proxy, param, 714, 114 ); end
function OnEvent_715_damage (proxy,param) Pranaria_Damage ( proxy, param, 715, 115 ); end
function OnEvent_716_damage (proxy,param) Pranaria_Damage ( proxy, param, 716, 116 ); end
function OnEvent_717_damage (proxy,param) Pranaria_Damage ( proxy, param, 717, 117 ); end
function OnEvent_718_damage (proxy,param) Pranaria_Damage ( proxy, param, 718, 118 ); end
function OnEvent_719_damage (proxy,param) Pranaria_Damage ( proxy, param, 719, 119 ); end
function OnEvent_720_damage (proxy,param) Pranaria_Damage ( proxy, param, 720, 120 ); end
]]


--���������S
--����鏰�ɗ����Ď��ʉ\��������̂́A�ŏ���20�C(?)

function OnEvent_701_force_dead (proxy,param) proxy:ForceDead( 101 ); end
function OnEvent_702_force_dead (proxy,param) proxy:ForceDead( 102 ); end
function OnEvent_703_force_dead (proxy,param) proxy:ForceDead( 103 ); end
function OnEvent_704_force_dead (proxy,param) proxy:ForceDead( 104 ); end
function OnEvent_705_force_dead (proxy,param) proxy:ForceDead( 105 ); end
function OnEvent_706_force_dead (proxy,param) proxy:ForceDead( 106 ); end
function OnEvent_707_force_dead (proxy,param) proxy:ForceDead( 107 ); end
function OnEvent_708_force_dead (proxy,param) proxy:ForceDead( 108 ); end
function OnEvent_709_force_dead (proxy,param) proxy:ForceDead( 109 ); end
function OnEvent_710_force_dead (proxy,param) proxy:ForceDead( 110 ); end
function OnEvent_711_force_dead (proxy,param) proxy:ForceDead( 111 ); end
function OnEvent_712_force_dead (proxy,param) proxy:ForceDead( 112 ); end
function OnEvent_713_force_dead (proxy,param) proxy:ForceDead( 113 ); end
function OnEvent_714_force_dead (proxy,param) proxy:ForceDead( 114 ); end
function OnEvent_715_force_dead (proxy,param) proxy:ForceDead( 115 ); end
function OnEvent_716_force_dead (proxy,param) proxy:ForceDead( 116 ); end
function OnEvent_717_force_dead (proxy,param) proxy:ForceDead( 117 ); end
function OnEvent_718_force_dead (proxy,param) proxy:ForceDead( 118 ); end
function OnEvent_719_force_dead (proxy,param) proxy:ForceDead( 119 ); end
function OnEvent_720_force_dead (proxy,param) proxy:ForceDead( 120 ); end
function OnEvent_721_force_dead (proxy,param) proxy:ForceDead( 121 ); end
function OnEvent_722_force_dead (proxy,param) proxy:ForceDead( 122 ); end
function OnEvent_723_force_dead (proxy,param) proxy:ForceDead( 123 ); end
function OnEvent_724_force_dead (proxy,param) proxy:ForceDead( 124 ); end
function OnEvent_725_force_dead (proxy,param) proxy:ForceDead( 125 ); end
function OnEvent_726_force_dead (proxy,param) proxy:ForceDead( 126 ); end
function OnEvent_727_force_dead (proxy,param) proxy:ForceDead( 127 ); end
function OnEvent_728_force_dead (proxy,param) proxy:ForceDead( 128 ); end
function OnEvent_729_force_dead (proxy,param) proxy:ForceDead( 129 ); end
function OnEvent_730_force_dead (proxy,param) proxy:ForceDead( 130 ); end
function OnEvent_731_force_dead (proxy,param) proxy:ForceDead( 131 ); end
function OnEvent_732_force_dead (proxy,param) proxy:ForceDead( 132 ); end
function OnEvent_733_force_dead (proxy,param) proxy:ForceDead( 133 ); end
function OnEvent_734_force_dead (proxy,param) proxy:ForceDead( 134 ); end
function OnEvent_735_force_dead (proxy,param) proxy:ForceDead( 135 ); end
function OnEvent_736_force_dead (proxy,param) proxy:ForceDead( 136 ); end
function OnEvent_737_force_dead (proxy,param) proxy:ForceDead( 137 ); end
function OnEvent_738_force_dead (proxy,param) proxy:ForceDead( 138 ); end
function OnEvent_739_force_dead (proxy,param) proxy:ForceDead( 139 ); end
function OnEvent_740_force_dead (proxy,param) proxy:ForceDead( 140 ); end



--�����S�Ď�

function OnEvent_801_dead (proxy,param) Pranaria_Dead ( proxy, param, 701, 801, 101 ); end
function OnEvent_801_alive(proxy,param) Pranaria_Alive( proxy, param, 701, 801, 101 ); end

function OnEvent_802_dead (proxy,param) Pranaria_Dead ( proxy, param, 702, 802, 102 ); end
function OnEvent_802_alive(proxy,param) Pranaria_Alive( proxy, param, 702, 802, 102 ); end

function OnEvent_803_dead (proxy,param) Pranaria_Dead ( proxy, param, 703, 803, 103 ); end
function OnEvent_803_alive(proxy,param) Pranaria_Alive( proxy, param, 703, 803, 103 ); end

function OnEvent_804_dead (proxy,param) Pranaria_Dead ( proxy, param, 704, 804, 104 ); end
function OnEvent_804_alive(proxy,param) Pranaria_Alive( proxy, param, 704, 804, 104 ); end

function OnEvent_805_dead (proxy,param) Pranaria_Dead ( proxy, param, 705, 805, 105 ); end
function OnEvent_805_alive(proxy,param) Pranaria_Alive( proxy, param, 705, 805, 105 ); end

function OnEvent_806_dead (proxy,param) Pranaria_Dead ( proxy, param, 706, 806, 106 ); end
function OnEvent_806_alive(proxy,param) Pranaria_Alive( proxy, param, 706, 806, 106 ); end

function OnEvent_807_dead (proxy,param) Pranaria_Dead ( proxy, param, 707, 807, 107 ); end
function OnEvent_807_alive(proxy,param) Pranaria_Alive( proxy, param, 707, 807, 107 ); end

function OnEvent_808_dead (proxy,param) Pranaria_Dead ( proxy, param, 708, 808, 108 ); end
function OnEvent_808_alive(proxy,param) Pranaria_Alive( proxy, param, 708, 808, 108 ); end

function OnEvent_809_dead (proxy,param) Pranaria_Dead ( proxy, param, 709, 809, 109 ); end
function OnEvent_809_alive(proxy,param) Pranaria_Alive( proxy, param, 709, 809, 109 ); end

function OnEvent_810_dead (proxy,param) Pranaria_Dead ( proxy, param, 710, 810, 110 ); end
function OnEvent_810_alive(proxy,param) Pranaria_Alive( proxy, param, 710, 810, 110 ); end

function OnEvent_811_dead (proxy,param) Pranaria_Dead ( proxy, param, 711, 811, 111 ); end
function OnEvent_811_alive(proxy,param) Pranaria_Alive( proxy, param, 711, 811, 111 ); end

function OnEvent_812_dead (proxy,param) Pranaria_Dead ( proxy, param, 712, 812, 112 ); end
function OnEvent_812_alive(proxy,param) Pranaria_Alive( proxy, param, 712, 812, 112 ); end

function OnEvent_813_dead (proxy,param) Pranaria_Dead ( proxy, param, 713, 813, 113 ); end
function OnEvent_813_alive(proxy,param) Pranaria_Alive( proxy, param, 713, 813, 113 ); end

function OnEvent_814_dead (proxy,param) Pranaria_Dead ( proxy, param, 714, 814, 114 ); end
function OnEvent_814_alive(proxy,param) Pranaria_Alive( proxy, param, 714, 814, 114 ); end

function OnEvent_815_dead (proxy,param) Pranaria_Dead ( proxy, param, 715, 815, 115 ); end
function OnEvent_815_alive(proxy,param) Pranaria_Alive( proxy, param, 715, 815, 115 ); end

function OnEvent_816_dead (proxy,param) Pranaria_Dead ( proxy, param, 716, 816, 116 ); end
function OnEvent_816_alive(proxy,param) Pranaria_Alive( proxy, param, 716, 816, 116 ); end

function OnEvent_817_dead (proxy,param) Pranaria_Dead ( proxy, param, 717, 817, 117 ); end
function OnEvent_817_alive(proxy,param) Pranaria_Alive( proxy, param, 717, 817, 117 ); end

function OnEvent_818_dead (proxy,param) Pranaria_Dead ( proxy, param, 718, 818, 118 ); end
function OnEvent_818_alive(proxy,param) Pranaria_Alive( proxy, param, 718, 818, 118 ); end

function OnEvent_819_dead (proxy,param) Pranaria_Dead ( proxy, param, 719, 819, 119 ); end
function OnEvent_819_alive(proxy,param) Pranaria_Alive( proxy, param, 719, 819, 119 ); end

function OnEvent_820_dead (proxy,param) Pranaria_Dead ( proxy, param, 720, 820, 120 ); end
function OnEvent_820_alive(proxy,param) Pranaria_Alive( proxy, param, 720, 820, 120 ); end

function OnEvent_821_dead (proxy,param) Pranaria_Dead ( proxy, param, 721, 821, 121 ); end
function OnEvent_821_alive(proxy,param) Pranaria_Alive( proxy, param, 721, 821, 121 ); end

function OnEvent_822_dead (proxy,param) Pranaria_Dead ( proxy, param, 722, 822, 122 ); end
function OnEvent_822_alive(proxy,param) Pranaria_Alive( proxy, param, 722, 822, 122 ); end

function OnEvent_823_dead (proxy,param) Pranaria_Dead ( proxy, param, 723, 823, 123 ); end
function OnEvent_823_alive(proxy,param) Pranaria_Alive( proxy, param, 723, 823, 123 ); end

function OnEvent_824_dead (proxy,param) Pranaria_Dead ( proxy, param, 724, 824, 124 ); end
function OnEvent_824_alive(proxy,param) Pranaria_Alive( proxy, param, 724, 824, 124 ); end

function OnEvent_825_dead (proxy,param) Pranaria_Dead ( proxy, param, 725, 825, 125 ); end
function OnEvent_825_alive(proxy,param) Pranaria_Alive( proxy, param, 725, 825, 125 ); end

function OnEvent_826_dead (proxy,param) Pranaria_Dead ( proxy, param, 726, 826, 126 ); end
function OnEvent_826_alive(proxy,param) Pranaria_Alive( proxy, param, 726, 826, 126 ); end

function OnEvent_827_dead (proxy,param) Pranaria_Dead ( proxy, param, 727, 827, 127 ); end
function OnEvent_827_alive(proxy,param) Pranaria_Alive( proxy, param, 727, 827, 127 ); end

function OnEvent_828_dead (proxy,param) Pranaria_Dead ( proxy, param, 728, 828, 128 ); end
function OnEvent_828_alive(proxy,param) Pranaria_Alive( proxy, param, 728, 828, 128 ); end

function OnEvent_829_dead (proxy,param) Pranaria_Dead ( proxy, param, 729, 829, 129 ); end
function OnEvent_829_alive(proxy,param) Pranaria_Alive( proxy, param, 729, 829, 129 ); end

function OnEvent_830_dead (proxy,param) Pranaria_Dead ( proxy, param, 730, 830, 130 ); end
function OnEvent_830_alive(proxy,param) Pranaria_Alive( proxy, param, 730, 830, 130 ); end

function OnEvent_831_dead (proxy,param) Pranaria_Dead ( proxy, param, 731, 831, 131 ); end
function OnEvent_831_alive(proxy,param) Pranaria_Alive( proxy, param, 731, 831, 131 ); end

function OnEvent_832_dead (proxy,param) Pranaria_Dead ( proxy, param, 732, 832, 132 ); end
function OnEvent_832_alive(proxy,param) Pranaria_Alive( proxy, param, 732, 832, 132 ); end

function OnEvent_833_dead (proxy,param) Pranaria_Dead ( proxy, param, 733, 833, 133 ); end
function OnEvent_833_alive(proxy,param) Pranaria_Alive( proxy, param, 733, 833, 133 ); end

function OnEvent_834_dead (proxy,param) Pranaria_Dead ( proxy, param, 734, 834, 134 ); end
function OnEvent_834_alive(proxy,param) Pranaria_Alive( proxy, param, 734, 834, 134 ); end

function OnEvent_835_dead (proxy,param) Pranaria_Dead ( proxy, param, 735, 835, 135 ); end
function OnEvent_835_alive(proxy,param) Pranaria_Alive( proxy, param, 735, 835, 135 ); end

function OnEvent_836_dead (proxy,param) Pranaria_Dead ( proxy, param, 736, 836, 136 ); end
function OnEvent_836_alive(proxy,param) Pranaria_Alive( proxy, param, 736, 836, 136 ); end

function OnEvent_837_dead (proxy,param) Pranaria_Dead ( proxy, param, 737, 837, 137 ); end
function OnEvent_837_alive(proxy,param) Pranaria_Alive( proxy, param, 737, 837, 137 ); end

function OnEvent_838_dead (proxy,param) Pranaria_Dead ( proxy, param, 738, 838, 138 ); end
function OnEvent_838_alive(proxy,param) Pranaria_Alive( proxy, param, 738, 838, 138 ); end

function OnEvent_839_dead (proxy,param) Pranaria_Dead ( proxy, param, 739, 839, 139 ); end
function OnEvent_839_alive(proxy,param) Pranaria_Alive( proxy, param, 739, 839, 139 ); end

function OnEvent_840_dead (proxy,param) Pranaria_Dead ( proxy, param, 740, 840, 140 ); end
function OnEvent_840_alive(proxy,param) Pranaria_Alive( proxy, param, 740, 840, 140 ); end




--�W�F�l���[�^�̊Ď�

--�����҂���Ԃ̎���
ALIVE_FRAME_INTERVAL = 300;

--�W�F�l���[�^�̏�Ԉꗗ
GENERATER_STATE_WAITING        = 1;--�����҂����
GENERATER_STATE_POSSIBLE_ALIVE = 2;--�����\���

--���݂̃W�F�l���[�^�̏��
now_generater_state_A = GENERATER_STATE_WAITING;
now_generater_state_B = GENERATER_STATE_WAITING;
now_generater_state_C = GENERATER_STATE_WAITING;
now_generater_state_D = GENERATER_STATE_WAITING;
now_generater_state_E = GENERATER_STATE_WAITING;
now_generater_state_F = GENERATER_STATE_WAITING;
now_generater_state_G = GENERATER_STATE_WAITING;

--�����҂���Ԃ̂Ƃ��̕b���J�E���g�p�J�E���^�[
frame_counter_A = 0;
frame_counter_B = 0;
frame_counter_C = 0;
frame_counter_D = 0;
frame_counter_E = 0;
frame_counter_F = 0;
frame_counter_G = 0;

--���W�F�l���[�^A

function Pranaria_Dead_Check_A( proxy, param )

--	print ( frame_counter_A );
--	print ( "A state : " .. now_generater_state_A );

	--�����҂����
	if now_generater_state_A == GENERATER_STATE_WAITING then
		
		frame_counter_A = frame_counter_A + 1;
		
		if frame_counter_A >= ALIVE_FRAME_INTERVAL then
			now_generater_state_A = GENERATER_STATE_POSSIBLE_ALIVE;
		end
		
		return false;
		
	--�����\���
	elseif now_generater_state_A == GENERATER_STATE_POSSIBLE_ALIVE then
	
		--�W�F�l���[�^�Ɏ��̂����邩�T��
		local pranaria_id = -1;
	
		for i=1, PURANARI_NUM, 1 do
	
			if dead_pranaria_list_A[i] ~= 0 then
				pranaria_id = dead_pranaria_list_A[i];
				dead_pranaria_list_A[i] = 0;--id�Ƃ����̂ł��̏ꏊ�󂯂�B
				break;
			end
		end
		
		--���̂��Ȃ������牽�����Ȃ�
		if pranaria_id == -1 then
	--		print( "���̂Ȃ�" );
			return false;
		
		--���̂��������畜��������
		else
			local event_id_of_dead = pranaria_id + 700;--���S�Ď��p��ID(�v���i���AID��101�̂Ƃ�801)
		
	--		proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( event_id_of_dead , "OnEvent_"..event_id_of_dead.."_alive" , 0.5 , 0 , 1 , once );
	--		proxy:NotNetMessage_end();
			
			proxy:SetEventFlag( event_id_of_dead , true );--�t���O�𗧂ĂāA���S���Ƃ���(����Ȃ���������Ȃ�)
		
			frame_counter_A       = 0;--�b���J�E���g�p�J�E���^�[������
			now_generater_state_A = GENERATER_STATE_WAITING;--��Ԃ𕜊��҂��ɃZ�b�g
			
			return true;
		end
	
	end

end


function Pranaria_Alive_A( proxy, param )
--	print( "call Pranaria_Alive_A" );
end



--���W�F�l���[�^B

function Pranaria_Dead_Check_B( proxy, param )

--	print ( "B state : " .. now_generater_state_B );

	--�����҂����
	if now_generater_state_B == GENERATER_STATE_WAITING then
		
		frame_counter_B = frame_counter_B + 1;
		
		if frame_counter_B >= ALIVE_FRAME_INTERVAL then
			now_generater_state_B = GENERATER_STATE_POSSIBLE_ALIVE;
		end
		
		return false;
		
	--�����\���
	elseif now_generater_state_B == GENERATER_STATE_POSSIBLE_ALIVE then
	
		--�W�F�l���[�^�Ɏ��̂����邩�T��
		local pranaria_id = -1;
	
		for i=1, PURANARI_NUM, 1 do
	
			if dead_pranaria_list_B[i] ~= 0 then
				pranaria_id = dead_pranaria_list_B[i];
				dead_pranaria_list_B[i] = 0;--id�Ƃ����̂ł��̏ꏊ�󂯂�B
				break;
			end
		end
		
		--���̂��Ȃ������牽�����Ȃ�
		if pranaria_id == -1 then
	--		print( "���̂Ȃ�" );
			return false;
		
		--���̂��������畜��������
		else 
			local event_id_of_dead = pranaria_id + 700;--���S�Ď��p��ID(�v���i���AID��101�̂Ƃ�801)
		
	--		proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( event_id_of_dead , "OnEvent_"..event_id_of_dead.."_alive" , 0.5 , 0 , 1 , once );
	--		proxy:NotNetMessage_end();
			
			proxy:SetEventFlag( event_id_of_dead , true );--�t���O�𗧂ĂāA���S���Ƃ���(����Ȃ���������Ȃ�)
		
			frame_counter_B       = 0;--�b���J�E���g�p�J�E���^�[������
			now_generater_state_B = GENERATER_STATE_WAITING;--��Ԃ𕜊��҂��ɃZ�b�g
			
			return true;
		end
	
	end

end


function Pranaria_Alive_B( proxy, param )
--	print( "call Pranaria_Alive_B" );
end



--���W�F�l���[�^C

function Pranaria_Dead_Check_C( proxy, param )

--	print ( "C state : " .. now_generater_state_C );

	--�����҂����
	if now_generater_state_C == GENERATER_STATE_WAITING then
		
		frame_counter_C = frame_counter_C + 1;
		
		if frame_counter_C >= ALIVE_FRAME_INTERVAL then
			now_generater_state_C = GENERATER_STATE_POSSIBLE_ALIVE;
		end
		
		return false;
		
	--�����\���
	elseif now_generater_state_C == GENERATER_STATE_POSSIBLE_ALIVE then
	
		--�W�F�l���[�^�Ɏ��̂����邩�T��
		local pranaria_id = -1;
	
		for i=1, PURANARI_NUM, 1 do
	
			if dead_pranaria_list_C[i] ~= 0 then
				pranaria_id = dead_pranaria_list_C[i];
				dead_pranaria_list_C[i] = 0;--id�Ƃ����̂ł��̏ꏊ�󂯂�B
				break;
			end
		end
		
		--���̂��Ȃ������牽�����Ȃ�
		if pranaria_id == -1 then
	--		print( "���̂Ȃ�" );
			return false;
		
		--���̂��������畜��������
		else 
			local event_id_of_dead = pranaria_id + 700;--���S�Ď��p��ID(�v���i���AID��101�̂Ƃ�801)
		
	--		proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( event_id_of_dead , "OnEvent_"..event_id_of_dead.."_alive" , 0.5 , 0 , 1 , once );
	--		proxy:NotNetMessage_end();
			
			proxy:SetEventFlag( event_id_of_dead , true );--�t���O�𗧂ĂāA���S���Ƃ���(����Ȃ���������Ȃ�)
		
			frame_counter_C       = 0;--�b���J�E���g�p�J�E���^�[������
			now_generater_state_C = GENERATER_STATE_WAITING;--��Ԃ𕜊��҂��ɃZ�b�g
			
			return true;
		end
	
	end

end


function Pranaria_Alive_C( proxy, param )
--	print( "call Pranaria_Alive_C" );
end


--���W�F�l���[�^D

function Pranaria_Dead_Check_D( proxy, param )

--	print ( "D state : " .. now_generater_state_D );

	--�����҂����
	if now_generater_state_D == GENERATER_STATE_WAITING then
		
		frame_counter_D = frame_counter_D + 1;
		
		if frame_counter_D >= ALIVE_FRAME_INTERVAL then
			now_generater_state_D = GENERATER_STATE_POSSIBLE_ALIVE;
		end
		
		return false;
		
	--�����\���
	elseif now_generater_state_D == GENERATER_STATE_POSSIBLE_ALIVE then
	
		--�W�F�l���[�^�Ɏ��̂����邩�T��
		local pranaria_id = -1;
	
		for i=1, PURANARI_NUM, 1 do
	
			if dead_pranaria_list_D[i] ~= 0 then
				pranaria_id = dead_pranaria_list_D[i];
				dead_pranaria_list_D[i] = 0;--id�Ƃ����̂ł��̏ꏊ�󂯂�B
				break;
			end
		end
		
		--���̂��Ȃ������牽�����Ȃ�
		if pranaria_id == -1 then
	--		print( "���̂Ȃ�" );
			return false;
		
		--���̂��������畜��������
		else 
			local event_id_of_dead = pranaria_id + 700;--���S�Ď��p��ID(�v���i���AID��101�̂Ƃ�801)
		
	--		proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( event_id_of_dead , "OnEvent_"..event_id_of_dead.."_alive" , 0.5 , 0 , 1 , once );
	--		proxy:NotNetMessage_end();
			
			proxy:SetEventFlag( event_id_of_dead , true );--�t���O�𗧂ĂāA���S���Ƃ���(����Ȃ���������Ȃ�)
		
			frame_counter_D       = 0;--�b���J�E���g�p�J�E���^�[������
			now_generater_state_D = GENERATER_STATE_WAITING;--��Ԃ𕜊��҂��ɃZ�b�g
			
			return true;
		end
	
	end

end


function Pranaria_Alive_D( proxy, param )
--	print( "call Pranaria_Alive_D" );
end


--���W�F�l���[�^E

function Pranaria_Dead_Check_E( proxy, param )

--	print ( "E state : " .. now_generater_state_E );

	--�����҂����
	if now_generater_state_E == GENERATER_STATE_WAITING then
		
		frame_counter_E = frame_counter_E + 1;
		
		if frame_counter_E >= ALIVE_FRAME_INTERVAL then
			now_generater_state_E = GENERATER_STATE_POSSIBLE_ALIVE;
		end
		
		return false;
		
	--�����\���
	elseif now_generater_state_E == GENERATER_STATE_POSSIBLE_ALIVE then
	
		--�W�F�l���[�^�Ɏ��̂����邩�T��
		local pranaria_id = -1;
	
		for i=1, PURANARI_NUM, 1 do
	
			if dead_pranaria_list_E[i] ~= 0 then
				pranaria_id = dead_pranaria_list_E[i];
				dead_pranaria_list_E[i] = 0;--id�Ƃ����̂ł��̏ꏊ�󂯂�B
				break;
			end
		end
		
		--���̂��Ȃ������牽�����Ȃ�
		if pranaria_id == -1 then
	--		print( "���̂Ȃ�" );
			return false;
		
		--���̂��������畜��������
		else 
			local event_id_of_dead = pranaria_id + 700;--���S�Ď��p��ID(�v���i���AID��101�̂Ƃ�801)
		
	--		proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( event_id_of_dead , "OnEvent_"..event_id_of_dead.."_alive" , 0.5 , 0 , 1 , once );
	--		proxy:NotNetMessage_end();
			
			proxy:SetEventFlag( event_id_of_dead , true );--�t���O�𗧂ĂāA���S���Ƃ���(����Ȃ���������Ȃ�)
		
			frame_counter_E       = 0;--�b���J�E���g�p�J�E���^�[������
			now_generater_state_E = GENERATER_STATE_WAITING;--��Ԃ𕜊��҂��ɃZ�b�g
			
			return true;
		end
	
	end

end


function Pranaria_Alive_E( proxy, param )
--	print( "call Pranaria_Alive_E" );
end


--���W�F�l���[�^F

function Pranaria_Dead_Check_F( proxy, param )

--	print ( "F state : " .. now_generater_state_F );

	--�����҂����
	if now_generater_state_F == GENERATER_STATE_WAITING then
		
		frame_counter_F = frame_counter_F + 1;
		
		if frame_counter_F >= ALIVE_FRAME_INTERVAL then
			now_generater_state_F = GENERATER_STATE_POSSIBLE_ALIVE;
		end
		
		return false;
		
	--�����\���
	elseif now_generater_state_F == GENERATER_STATE_POSSIBLE_ALIVE then
	
		--�W�F�l���[�^�Ɏ��̂����邩�T��
		local pranaria_id = -1;
	
		for i=1, PURANARI_NUM, 1 do
	
			if dead_pranaria_list_F[i] ~= 0 then
				pranaria_id = dead_pranaria_list_F[i];
				dead_pranaria_list_F[i] = 0;--id�Ƃ����̂ł��̏ꏊ�󂯂�B
				break;
			end
		end
		
		--���̂��Ȃ������牽�����Ȃ�
		if pranaria_id == -1 then
	--		print( "���̂Ȃ�" );
			return false;
		
		--���̂��������畜��������
		else 
			local event_id_of_dead = pranaria_id + 700;--���S�Ď��p��ID(�v���i���AID��101�̂Ƃ�801)
		
	--		proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( event_id_of_dead , "OnEvent_"..event_id_of_dead.."_alive" , 0.5 , 0 , 1 , once );
	--		proxy:NotNetMessage_end();
			
			proxy:SetEventFlag( event_id_of_dead , true );--�t���O�𗧂ĂāA���S���Ƃ���(����Ȃ���������Ȃ�)
		
			frame_counter_F       = 0;--�b���J�E���g�p�J�E���^�[������
			now_generater_state_F = GENERATER_STATE_WAITING;--��Ԃ𕜊��҂��ɃZ�b�g
			
			return true;
		end
	
	end

end


function Pranaria_Alive_F( proxy, param )
--	print( "call Pranaria_Alive_F" );
end


--���W�F�l���[�^G

function Pranaria_Dead_Check_G( proxy, param )

--	print ( "G state : " .. now_generater_state_G );

	--�����҂����
	if now_generater_state_G == GENERATER_STATE_WAITING then
		
		frame_counter_G = frame_counter_G + 1;
		
		if frame_counter_G >= ALIVE_FRAME_INTERVAL then
			now_generater_state_G = GENERATER_STATE_POSSIBLE_ALIVE;
		end
		
		return false;
		
	--�����\���
	elseif now_generater_state_G == GENERATER_STATE_POSSIBLE_ALIVE then
	
		--�W�F�l���[�^�Ɏ��̂����邩�T��
		local pranaria_id = -1;
	
		for i=1, PURANARI_NUM, 1 do
	
			if dead_pranaria_list_G[i] ~= 0 then
				pranaria_id = dead_pranaria_list_G[i];
				dead_pranaria_list_G[i] = 0;--id�Ƃ����̂ł��̏ꏊ�󂯂�B
				break;
			end
		end
		
		--���̂��Ȃ������牽�����Ȃ�
		if pranaria_id == -1 then
	--		print( "���̂Ȃ�" );
			return false;
		
		--���̂��������畜��������
		else 
			local event_id_of_dead = pranaria_id + 700;--���S�Ď��p��ID(�v���i���AID��101�̂Ƃ�801)
		
	--		proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( event_id_of_dead , "OnEvent_"..event_id_of_dead.."_alive" , 0.5 , 0 , 1 , once );
	--		proxy:NotNetMessage_end();
			
			proxy:SetEventFlag( event_id_of_dead , true );--�t���O�𗧂ĂāA���S���Ƃ���(����Ȃ���������Ȃ�)
		
			frame_counter_G       = 0;--�b���J�E���g�p�J�E���^�[������
			now_generater_state_G = GENERATER_STATE_WAITING;--��Ԃ𕜊��҂��ɃZ�b�g
			
			return true;
		end
	
	end

end


function Pranaria_Alive_G( proxy, param )
--	print( "call Pranaria_Alive_G" );
end







--2�i����10�i���ϊ�(7bit�Œ�)
function BinaryToDesimal_7bit(proxy,param,number_list)

	local number_num = table.getn( number_list );
	
	if number_num ~= 7 then
		print("7bit�p�ł��B return -1");
		return -1;
	end
	
	local temp = 0; --�ݏ�l
	local desimal_value = 0;
	
	for i=7, 1 , -1 do--�l�����Ƃ��ɒ����I�ɂ킩��悤�ɋt���Ɍ���B { 0,0,0,0,1,0,1 } �Ȃ� 5

		if number_list[i] == 1 then
			desimal_value = desimal_value + ( 2 ^ temp );
		end

		temp = temp + 1;
	end

--	print_list_7bit( proxy, param , number_list );
--	print( desimal_value );
	return desimal_value;
end




--10�i����2�i���ϊ�(7bit�Œ�)
function DesimalToBinary_7bit( proxy, param, number )

	if number < 0 or number > 127 then
		print( "�͈͊O�ł�(0�`127�܂�) number = " .. number );
		return;
	end

	local index = 7; --�����I�ɂ݂���悤�ɉE����߂�
	local now_number = number;
	local binary_list = {0,0,0,0,0,0,0};

	if number == 0 then
--		print ( "number = 0 " );
		return binary_list;
	end
	
	if number == 1 then
--		print ( "number = 1 " );
		binary_list[7] = 1;
		return binary_list;
	end
	
	for i=1, 7 , 1 do
	
		local set_number = math.mod( now_number , 2 );
		local div_number = math.floor( now_number / 2 );--�����_�ȉ��؎̂�
		
		binary_list[index] = set_number;
		index = index - 1;
		if div_number == 1 then
			binary_list[index] = div_number;
			
		--	print( number );
		--	print_list_7bit( proxy , param , binary_list );
			return binary_list;
		end
		
		now_number = div_number;
	end

end



function print_list_7bit(proxy,param, number_list )
	
	local num = table.getn( number_list );
	
	if num == 7 then
		print( number_list[1] .."".. number_list[2] .."".. number_list[3] .."".. number_list[4] .."".. number_list[5] .."".. number_list[6] .."".. number_list[7] );
	else
		print( "7bit�p�ł�" );
	end
end


--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m07_00_00_00(proxy, param)
	print("PlayerDeath_m07_00_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m07_00_00_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerDeath_m07_00_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m07_00_00_00(proxy,param)
	print("PlayerRevive_m07_00_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m07_00_00_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerRevive_m07_00_00_00");
end


--------------------------------------------------------------------------------------
--�C�G�e�B�o�ꁡ540
--------------------------------------------------------------------------------------
--��540���C�G�e�B�o�ꁡ
function OnEvent_540(proxy,param)
	print( "OnEvent_540 begin" );
	
	proxy:PlayAnimation( 200, 7000 );--�o��A�j���Đ�
	
	proxy:SetDrawEnable( 200 , true );--�`��ON
	proxy:SetColiEnable( 200 , true );--������ON
	
	proxy:SetDisableGravity( 200, true );--�d��OFF
	proxy:DisableMapHit( 200, true );--�}�b�v������OFF

	proxy:NotNetMessage_begin();
		--��540_1���o��A�j���I����
		proxy:OnChrAnimEnd( 540, 200, 7000, "OnEvent_540_1", once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 540 , 1 );

	print( "OnEvent_540 end" );
end


--��540_1���o��A�j���I����
function OnEvent_540_1(proxy,param)
	print( "OnEvent_540_1 begin" );

	proxy:EnableLogic( 200 , true );--�v�lON
	
	proxy:SetDisableGravity( 200, false );--�d��ON
	proxy:DisableMapHit( 200, false	);--�}�b�v������ON
	
	print( "OnEvent_540_1 end" );	
end



