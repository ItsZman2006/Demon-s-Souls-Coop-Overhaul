
--�Θm�R�藎�Ƃ��̃_���[�W�����a
DAMAGE_RADIUS = 1.3;

--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉����������
--------------------------------------------------------------------------------------
function Initialize_m02_02_00_00(proxy)
	print("Initialize_m02_02_00_00 begin");
	

--��1040�����o�[�ŏ����J�����遡
	if proxy:IsCompleteEvent( 1040 ) ==false then
		
		--proxy:LuaCall( 1041, 1, "OnEvent_1041", everytime );
		--proxy:NotNetMessage_begin();
			--�|�����J�n�t�F�[�h��ɌĂ΂��n���h��
			--proxy:LuaCall(1041,REMO_START,"OnEvent_1041_RemoStart",once);
			--�|�����I����ɌĂ΂��n���h��
			--proxy:LuaCall(1041,REMO_FINISH,"OnEvent_1041_RemoFinish",once);
		--proxy:NotNetMessage_end();
		
		proxy:OnDistanceAction( 1040, 10000, 1450, "OnEvent_1040", LeverDist_A, HELPID_PULL_LEVER, 0, LeverAngle_A, once);
	else
		proxy:EndAnimation( 1450, 1 );--���o�[�A�j�����I��
		proxy:EndAnimation( 1440, 1 );--���傪�J���A�j�����I��
	end
	
	
	
--��1051���G�������Ă���2��
	if proxy:IsCompleteEvent( 1051 ) ==false then
		proxy:OnRegionJustIn( 1051 , 10000 , 2451 , "OnEvent_1051" , once );
		proxy:OnSimpleDamage( 1051 , 423 , 10000 , "OnEvent_1051_0_1" , once );--ID423 �ЂƂ�Ȃ̂�ID����
	end
	

--��1070���הn�Ԃ��K�^�K�^1��
	--(Second_Initialize�Ńn���h�����Ă�)
	
--��1071���הn�Ԃ��K�^�K�^2��
	--(Second_Initialize�Ńn���h�����Ă�)
	
	

--��1079���הn�Ԃ������Ă��遡
	if proxy:IsCompleteEvent( 1079 ) == false then
		proxy:OnRegionJustIn( 1079 , 10000 , 2470 , "OnEvent_1079" , once );
	else
		proxy:EndAnimation( 1490 , 1 );--�הn�Ԃ̃A�j���I��
		proxy:SetColiEnable( 1490 , false );--�הn�Ԃ̃A�^��OFF
		proxy:EndAnimation( 1495 , 1 );--�m�̃A�j���I��
	end


	
--��1082�������܂�|�����Đ���
	if proxy:IsCompleteEvent( 1082 ) == false then
		proxy:OnRegionJustIn( 1082 , 10000 , 2472 , "OnEvent_1082" , once );
	
		proxy:NotNetMessage_begin();
			--�|�����I����ɌĂ΂��n���h��
			proxy:LuaCall(1082,REMO_FINISH,"OnEvent_1082_RemoFinish",once);
			--�|�����J�n���ɌĂ΂��n���h��
			proxy:LuaCall(1082,REMO_START,"OnEvent_1082_RemoStart",once);
		proxy:NotNetMessage_end();
		
		--���܂�|�����O�ɍU�������� �����|�����Đ��p�̃_���[�W�Ď�
		proxy:OnSimpleDamage( 1082 , 452 , 10000 , "OnEvent_1082" , once );--����
		--proxy:OnSimpleDamage( 1082 , 405 , 10000 , "OnEvent_1082" , once );--���m
		proxy:OnSimpleDamage( 1082 , 406 , 10000 , "OnEvent_1082" , once );
		proxy:OnSimpleDamage( 1082 , 407 , 10000 , "OnEvent_1082" , once );
		proxy:OnSimpleDamage( 1082 , 408 , 10000 , "OnEvent_1082" , once );
		InvalidCharactor( proxy, 405 );
	else
		proxy:EndAnimation( 1440 , 2 );--���傪����A�j���Đ�
		InvalidCharactor( proxy, 405 );
	end

	--[[
--��1065������A�̑���ς���(���̉��̂ق��֑��点��)��
	if proxy:IsCompleteEvent( 1065 ) == false then
		proxy:OnRegionJustIn( 1065 , 10000 , 2515 , "OnEvent_1065" , once );
	end
	]]	

--��1115���`�F�b�N�|�C���g1(�����J����C�x���g�̂��߂̂���)��
	if proxy:IsCompleteEvent( 1115 ) == false then
		proxy:OnRegionJustIn( 1115 , 10000 , 2473 , "OnEvent_1115" , once );
	end

	

--��1085���ׂ��H�n�̔����}�ɊJ����
	if proxy:IsCompleteEvent( 1085 ) == false then
		proxy:OnRegionIn( 1085 , 10000 , 2474 , "OnEvent_1085_check_1" , everytime );--�`�F�b�N�|�C���g�ʉ߂����Ƃ��p
		proxy:OnRegionIn( 1085 , 10000 , 2475 , "OnEvent_1085_check_2" , everytime );--�|����������p
		proxy:OnObjectDestroy( 1085 , 1530 , "OnEvent_1085" , once );--�I�u�W�F���j�󂳂ꂽ���p
	end

	
--��1086���ׂ��H�n����G����яo���Ă��遡
	if proxy:IsCompleteEvent( 1086 ) == false then
		proxy:OnRegistFunc( 1086 , "Check_OnEvent_1086" , "OnEvent_1086" , 1 , once );
	end

	
--��1088�������̎w���ŋ|�����|�������Ă��遡
	if proxy:IsCompleteEvent( 1088 ) == false then
		proxy:OnRegionJustIn( 1088 , 10000 , 2476 , "OnEvent_1088" , everytime );
		proxy:OnSimpleDamage( 1088 , 451 , 10000 , "OnEvent_1088" , once );--����(2�C��)
		proxy:OnSimpleDamage( 1088 , 410 , 10000 , "OnEvent_1088" , once );--�|��
		proxy:OnSimpleDamage( 1088 , 411 , 10000 , "OnEvent_1088" , once );
		proxy:OnSimpleDamage( 1088 , 412 , 10000 , "OnEvent_1088" , once );
		proxy:OnSimpleDamage( 1088 , 413 , 10000 , "OnEvent_1088" , once );
		proxy:OnSimpleDamage( 1088 , 414 , 10000 , "OnEvent_1088" , once );
	end

	
--��1270�������̎w���ŋ|�����|�������Ă���2��
	if proxy:IsCompleteEvent( 1271 ) == false then
		SingleReset( proxy, 1270 );
	end
	
	if proxy:IsCompleteEvent( 1270 ) == false then
		proxy:OnRegionJustIn( 1270 , 10000 , 2440 , "OnEvent_1270" , everytime );
		proxy:OnSimpleDamage( 1270 , 453 , 10000 , "OnEvent_1270" , once );--����(3�C��)
		proxy:OnSimpleDamage( 1270 , 480 , 10000 , "OnEvent_1270" , once );--�|��
		proxy:OnSimpleDamage( 1270 , 481 , 10000 , "OnEvent_1270" , once );
		proxy:OnSimpleDamage( 1270 , 482 , 10000 , "OnEvent_1270" , once );
		
		--������(453)��������|������
		proxy:NotNetMessage_begin();
			--�|�����I����ɌĂ΂��n���h��
			proxy:LuaCall(1271,REMO_FINISH,"OnEvent_1271_RemoFinish",once);
			--�|�����J�n���ɌĂ΂��n���h��
			proxy:LuaCall(1271,REMO_START,"OnEvent_1271_RemoStart",once);
		proxy:NotNetMessage_end();	
	end
	
	

--��1280������1 ���S�`�F�b�N��	
	if proxy:IsCompleteEvent( 1280 ) == false then
		proxy:OnCharacterDead( 1280 , 451 , "OnEvent_1280" , once );
	end
	
--��15621������1�̎��̂𒲂ׂ���
	if proxy:IsCompleteEvent( 15621 ) == false then
		proxy:AddCorpseEvent( 15621 , 451 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15621 ,0 , "OnEvent_15621",once );
 		proxy:NotNetMessage_end();
	end
	
--��1281������2 ���S�`�F�b�N��	
	if proxy:IsCompleteEvent( 1281 ) == false then
		proxy:OnCharacterDead( 1281 , 452 , "OnEvent_1281" , once );
	end
	
--��15620������2�̎��̂𒲂ׂ���
	if proxy:IsCompleteEvent( 15620 ) == false then
		proxy:AddCorpseEvent( 15620 , 452 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15620 ,0 , "OnEvent_15620",once );
 		proxy:NotNetMessage_end();
	end
	
--��1282������3 ���S�`�F�b�N��	
	if proxy:IsCompleteEvent( 1282 ) == false then
		proxy:OnCharacterDead( 1282 , 453 , "OnEvent_1282" , once );
	end


--��1200���T�u�C�x���g����
	if proxy:IsCompleteEvent( 1200 ) == false then--�܂����͊J���Ă��Ȃ��@����
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 1200, 10000, 1460, "OnEvent_1200", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 1200, 1, "OnEvent_1200_1", once );--�A�j���[�V���������p		
	else
		proxy:EndAnimation( 1460, 1 );
	end

	
--��1201���T�u�C�x���g����
	if proxy:IsCompleteEvent( 1201 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 1201, 10000, 1461, "OnEvent_1201", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 1201, 1, "OnEvent_1201_1", once );--�A�j���[�V���������p		
	else
		proxy:EndAnimation( 1461, 1 );
	end


--��1034���{�X�����ɓ��遡
	
	--���{�X�������Ă���Ƃ������C�x���g�o�^
	if proxy:IsCompleteEvent( 4360 ) == false then
	
		--�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B
		SingleReset(proxy, 1034);
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���)
		proxy:LuaCall( 1035, 1, "OnEvent_1035_1", everytime );
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCall( 1035 , 5 , "OnEvent_1034_GO_TO_IN" , everytime );
		--���t���O�Z�b�g(�����p)
		proxy:LuaCall( 1035 , 6 , "OnEvent_1034_flag_set" , everytime );

		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ�
		if proxy:IsCompleteEvent( 1034 ) == false then
		
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l����
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--��1034�����ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegionAttribute( 1034, 2893, "OnEvent_1034", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B
		
			proxy:NotNetMessage_begin();
				--��1035�����ɓ��邽�߂̃C�x���g��ǉ���--�n���h���͏�Ɠ���
				proxy:OnPlayerActionInRegion( 1035, 2893, "OnEvent_1034", HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		
		end
		proxy:SetColiEnableArray(3007,false);--�ʏ햳��
		proxy:SetColiEnableArray(3008,false);--�ʏ햳��
		proxy:SetColiEnableArray(3009,true);--�{�X�p�L��
		proxy:SetColiEnableArray(3011,true);--�{�X�p�L��
	else
		proxy:SetColiEnableArray(3007,true);--�ʏ�L��
		proxy:SetColiEnableArray(3008,true);--�ʏ�L��
		proxy:SetColiEnableArray(3009,false);--�{�X�p����
		proxy:SetColiEnableArray(3011,false);--�{�X�p����
	end
	

--��1036���{�X�̃|�����Đ���

	if proxy:IsCompleteEvent( 1036 ) == false then 
	
		--���{�X�O�̃|�����Đ��p�Ď��ǉ�
		proxy:OnRegionJustIn( 1036 , 10000 , 2897 , "OnEvent_1036" , once );
		
		proxy:NotNetMessage_begin();
			--�|�����J�n�ɌĂ΂��n���h��
			proxy:LuaCall(1036, REMO_START, "OnEvent_1036_RemoStart", once);
			--�|�����I����ɌĂ΂��n���h��(�g���K�[�N�������l�p)
			proxy:LuaCall(1036, REMO_FINISH, "OnEvent_1036_RemoFinish", once);
		proxy:NotNetMessage_end();
	
	end
			

--��1037���{�X�퓬�J�n��	
	if proxy:IsCompleteEvent( 4360 ) == false then
		SingleReset( proxy , 1430 );
		proxy:OnRegionJustIn( 1037 , 10000 , 2885 , "OnEvent_1037" , once );
	end

	
--��4360�����{�X���S�Ŕ����J����(���{�X�̎��S�Ď�)
	proxy:AddFieldInsFilter( 802 );
	if proxy:IsCompleteEvent( 4360 ) ==false then
		proxy:NotNetMessage_begin();
			proxy:OnCharacterDead(4360, 802, "OnEvent_4360", once);
		proxy:NotNetMessage_end();
	end


--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m02_02_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m02_02_00_00", everytime );
	proxy:NotNetMessage_end();
	

--��1210���n�V�S1�~�聡PC���C�x���g�G���A(2530)�̒��ɋ��āA�A�N�V�����{�^�����������Ƃ�--
	proxy:OnActionEventRegion(1210, 2530, "OnEvent_1210", LadderAngle_A, HELPID_DOWN, everytime);
--��1211���n�V�S1���聡PC���C�x���g�G���A(2531)�̒��ɋ��āA�A�N�V�����{�^�����������Ƃ�--
	proxy:OnActionEventRegion(1211, 2531, "OnEvent_1211", LadderAngle_A, HELPID_UP,   everytime);


--��1212���n�V�S2�~�聡PC���C�x���g�G���A(2532)�̒��ɋ��āA�A�N�V�����{�^�����������Ƃ�--
	proxy:OnActionEventRegion(1212, 2532, "OnEvent_1212", LadderAngle_A, HELPID_DOWN, everytime);
--��1213���n�V�S2���聡PC���C�x���g�G���A(2533)�̒��ɋ��āA�A�N�V�����{�^�����������Ƃ�--
	proxy:OnActionEventRegion(1213, 2533, "OnEvent_1213", LadderAngle_A, HELPID_UP,   everytime);

--��1214���n�V�SC�~�聡PC���C�x���g�G���A(2534)�̒��ɋ��āA�A�N�V�����{�^�����������Ƃ�--
	proxy:OnActionEventRegion(1214, 2534, "OnEvent_1214", LadderAngle_A, HELPID_DOWN, everytime);
--��1215���n�V�SC���聡PC���C�x���g�G���A(2535)�̒��ɋ��āA�A�N�V�����{�^�����������Ƃ�--
	proxy:OnActionEventRegion(1215, 2535, "OnEvent_1215", LadderAngle_A, HELPID_UP,   everytime);

	
	if proxy:IsCompleteEvent( BIYO_STATE_KING_OF_SWORD_KILL ) == true then
		proxy:EnableLogic( 627, false );--�r�����W�b�NOFF
		proxy:SetEventCommand( 627, 60 );--EzState�ɐ���ԍ�(�Q��)��n��
	end	

-- ���������֘A�̃C�x���g�� -------------------------------------------

--��1300���H����G�̏�����������
--(Second_Initialize�ɏ���)

--��1222���H����G�̎��S�`�F�b�N��
	SingleReset( proxy, 1222 );
	if proxy:IsCompleteEvent( 1222 ) == false then
		proxy:NotNetMessage_begin();
			proxy:OnCharacterDead( 1222 ,454 , "OnEvent_1222" , once );
		proxy:NotNetMessage_end();
	end
	
--��1220���H����G���{�遡
	SingleReset( proxy, 1220 );
	--�{���ĂȂ�������łȂ�
	if proxy:IsCompleteEvent( 1220 ) == false and proxy:IsCompleteEvent( 1222 ) == false then
		
		proxy:NotNetMessage_begin();
			if proxy:IsClient() == false then
				proxy:OnRegionIn( 1220 , 10000 , 2540 , "OnEvent_1220" , everytime );--�̈�Ď�
			end
		proxy:NotNetMessage_end();
		
		if proxy:IsCompleteEvent(1225) == true then
			proxy:NotNetMessage_begin();
				proxy:OnSimpleDamage( 1220 , 454 , 10000 , "OnEvent_1220_Damage" , once );--�_���[�W�Ď�
			proxy:NotNetMessage_end();			
		end
				
		proxy:LuaCall( 1220 , 1 , "OnEvent_1220_hostile" , once );--�H����G���{��p
	end
		
--��1225���U���ɐ�������ƁA�K�i���~�낵�Ă���遡(�̈�̊Ď���1220�ōs���Ă���)
	if proxy:IsCompleteEvent( 1225 ) == false then
		proxy:LuaCall( 1225 , 1 , "OnEvent_1225" , once );
	else
		proxy:EndAnimation( 1462 , 1 );--���o�[�A�j��
		proxy:EndAnimation( 1550 , 1 );--�K�i���~���A�j��		
	end

	
--��1380�����������ӂ��遡	
--(�H����G�̎��S�Ď�:OnEvent_1222 �ɋL�q)

--��11500���������A�C�e����n���x�e���遡(��b�V�X�e������Ăяo��)
	if proxy:IsCompleteEvent( 11500 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 11500 , 0 , "OnEvent_11500" , once );
		proxy:NotNetMessage_end();
	end

--��1381���������G�΂��遡
	if proxy:IsCompleteEvent( 1381 ) == false then
		--proxy:OnCharacterTotalDamage( 1381, 625, 10000, 100, "OnEvent_1381", once );
		proxy:OnCharacterTotalRateDamage( 1381, 625, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1381", once );
	end

--��1382�����������S���遡
	if proxy:IsCompleteEvent( 1382 ) == false then
		proxy:OnCharacterDead( 1382, 625, "OnEvent_1382" , once );  
	end

	--�������֘A������

	--������Ԃ��Z�b�g(��Ԃ����ݒ�̏ꍇ�A�w�肵����Ԃ��Z�b�g����)
	SetFirstNpcStateFlag( proxy , param , majo_flag_list , MAJO_STATE_LIBERATE );
	
	--���݂̏�Ԏ擾
	local now_state = GetNpcStateFlag( proxy , param , majo_flag_list );
	
	--������Ăق���
	if now_state == MAJO_STATE_LIBERATE then
		--proxy:EnableLogic( 625 , false );
	
		--(�\��)
	
	--����
	elseif now_state == MAJO_STATE_THANKS then
		--proxy:EnableLogic( 625 , false );
	
		--(�\��)
	
	--���ŋx�e
	elseif now_state == MAJO_STATE_BREAK  then
		--proxy:EnableLogic( 625 , false );

		--(�\��)
	
	--�G��
	elseif now_state == MAJO_STATE_HOSTILE then
		--�����̏�Ԃ��u�G�΁v�ɂ���B(�\��)
		proxy:EnableLogic( 625 , true );		
		proxy:SetTeamType( 625, TEAM_TYPE_AngryFriend );
		
	--���S
	elseif now_state == MAJO_STATE_DEAD then
		InvalidBackRead( proxy, 625 );--����������
		
	else
		InvalidBackRead( proxy, 625 );--����������
		print("�����͐Β��ɂ���悧");
	end
	
-- ���������֘A�̃C�x���g�� ---------------------------------------------





-- �������h�����q�֘A�̃C�x���g�� ----------------------------------------

	
--��1350�������h�����q��ǂ��G���o������1��
	--(1310����A��)
	
--��1351�������h�����q��ǂ��G���o������2��
	--(1350����A��)
	
--��1352�������h�����q��ǂ��G���o������3��
	--(1351����A��)
	
--��1311�����q���܏��H�Ɉړ����遡

--��1360�������h�����q��ǂ��G�̑���ς���1��
	--(1311����A��)

--��1361�������h�����q��ǂ��G�̑���ς���1��
	--(1360����A��)

--��1362�������h�����q��ǂ��G�̑���ς���1��
	--(1361����A��)

--��1312�����q���܏��H�ɓ����������Ƃɋ��������遡

--��1313�����q�����ӂ��遡
	--�G�̎��S�C�x���g�Œǉ�����܂���B�Q�ƁF(OnEvent_1410_1411_1412)

--��11501�����q���T�����J�n���遡(��b�V�X�e������Ăяo��)


--��1315�����q�����̃u���b�N�Ɉړ����遡
	
--��1410����ʕ��m�̎��S�Ď���
	if proxy:IsCompleteEvent( 1410 ) == false then
		proxy:OnCharacterDead( 1410 , 460 , "OnEvent_1410_1411_1412" , once );
	end

--��1411����ʕ��m�̎��S�Ď���
	if proxy:IsCompleteEvent( 1411 ) == false then
		proxy:OnCharacterDead( 1411 , 461 , "OnEvent_1410_1411_1412" , once );
	end

--��1412����ʕ��m�̎��S�Ď���
	if proxy:IsCompleteEvent( 1412 ) == false then
		proxy:OnCharacterDead( 1412 , 462 , "OnEvent_1410_1411_1412" , once );
	end	
	--proxy:ForceSetOmissionLevel( 621, true, 0 );


-- �������h�����q�֘A�̃C�x���g�� ----------------------------------------


	
--��1250���R����m���]���藎���Ă���1��	
	if proxy:IsCompleteEvent( 1250 ) == false then
		proxy:OnRegionJustIn( 1250 , 10000 , 2400 , "OnEvent_1250" , once );
		proxy:OnSimpleDamage( 1250 , 470 , 10000 , "OnEvent_1250" , once );
	end
	
--��1251���R����m���]���藎���Ă���2��	
	if proxy:IsCompleteEvent( 1251 ) == false then
		proxy:OnRegionJustIn( 1251 , 10000 , 2401 , "OnEvent_1251" , once );
		proxy:OnSimpleDamage( 1251 , 471 , 10000 , "OnEvent_1251" , once );
	end	
	
	
	--���̖���ʉ߂ł���L�����^�C�v(���̃^�C�v�̐l�����A�N�V�����{�^������������)
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

--��1260���z�X�gPC�݂̂��ʂ����̖���
	if proxy:IsCompleteEvent( 1260 ) == true then--�z�X�g���ʉߍς�
		proxy:SetDrawEnable( 1560 , false );
		proxy:SetColiEnable( 1560 , false );
		proxy:InvalidSfx( 2425, false );
	else
		--��1260�����@�Ǎ폜�����p��
		proxy:LuaCall( 1260 , 1 , "OnEvent_1260_delete_wall" , once );
		
		--��1260���ǂ̒��ɓ���C�x���g�����p��
		proxy:OnDistanceActionAttribute( 1260 , 10000 , 1560 , "OnEvent_1260" , DoorDist_A , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end	

	--���W�n�̍Č�(Warp�Ȃ�)�̓V���O���̂Ƃ������s��
	
	--��1082�A1040������̊J��1082 �����܂�|���� �@1040 �����J���郌�o�[
	if proxy:IsCompleteEvent( 1082 ) == false or proxy:IsCompleteEvent( 1040 ) == true then
		proxy:EndAnimation( 1440 , 1 );--����͊J���Ă���
	else
		proxy:EndAnimation( 1440 , 2 );--����͕܂��Ă���
	end
	
	
--[[��1450,1451,1452���z�ꕺ�m(�V���b�vNPC)�̏�ԏ�������
	--�z�ꕺ�m���G�΂��Ă���
	if proxy:IsCompleteEvent( 1440 ) == true and proxy:IsCompleteEvent( 1441 ) == false then
		proxy:EnableLogic( 679 , true );
		SetNpcStateFlag(proxy,param,DOREI_SHOP_Flag_list,DOREI_SHOP_HOSTILE);
		proxy:SetTeamType( 679, TEAM_TYPE_AngryFriend );
		proxy:SetEventFlag( 1451, 1 );
	end
	--�z�ꕺ�m�����S���Ă���
	if proxy:IsCompleteEvent( 1441 ) == true then
		SetNpcStateFlag(proxy,param,DOREI_SHOP_Flag_list,DOREI_SHOP_DEAD);
		proxy:ForceUpdateNextFrame(679);
		InvalidCharactor(proxy, 679 );
		proxy:SetEventFlag( 1452, 1 );
	end
	--�z�ꕺ�m���̔����Ă���
	if proxy:IsCompleteEvent( 1440 ) == false and proxy:IsCompleteEvent( 1441 ) == false then
		proxy:EnableLogic( 679 , false );
		SetNpcStateFlag(proxy,param,DOREI_SHOP_Flag_list,DOREI_SHOP_NORMAL);
		proxy:SetEventFlag( 1450, 1 );
	end

--��1440���z�ꕺ�m(�V���b�vNPC)�̏�ԏ�������
	if proxy:IsCompleteEvent(1440) == false then
		proxy:OnCharacterTotalDamage( 1440, 679, 10000, DOREI_SHOP_TOTALDAMAGE, "OnEvent_1440", once );	
	end
	
--��1441���z�ꕺ�m(�V���b�vNPC)���S��
	if proxy:IsCompleteEvent( 1441 ) == false then
		proxy:OnCharacterDead( 1441 , 679 , "OnEvent_1441" , once );
	end
		

]]	

	--��1082 �����܂�|�������I����Ă���
	if proxy:IsCompleteEvent( 1082 ) == true then	
		--�|�������Đ������̂ō������[�v		
		proxy:SetDrawEnable( 452 , true );--�|�������A�\��OFF�ɂ��Ă����̂Ŗ߂�
		proxy:ChangeInitPosAng( 452 , 2512 );--�������[�v��̗̈�ɍX�V
		proxy:EnableLogic( 452 , true );
		proxy:Warp( 452 , 2512 );--���̃|�C���g�փ��[�v
		
		--���m405�����ɒׂ����
		--proxy:Warp( 405 , 2506 );--���̉��Ƀ��[�v
		--proxy:EnableLogic( 405 , false );--�v�lOFF
		--proxy:SetColiEnable( 405 , false );--������OFF
		--proxy:SetDrawEnable( 405 , true );--�|�������A�\��OFF�ɂ��Ă����̂Ŗ߂�
		--proxy:PlayLoopAnimation( 405 , 7020 );--�|�ꂽ�܂�
		--proxy:EnableHide( 405 , true );--�T������Ȃ�
		--proxy:DisableMapHit( 405, true );--�}�b�v�����薳��(���̓�����ňʒu�������?�̂�?)
		--proxy:SetDisableGravity( 405 , true );--�d�͖���
		--proxy:ForceUpdateNextFrame(405);--���̃t���[���͋����X�V(�ׂ���镺�m)		
		
		--���̕��m�͖�����
		InvalidCharactor( proxy , 406 );
		InvalidCharactor( proxy , 407 );
		InvalidCharactor( proxy , 408 );
		
		proxy:SetDrawEnable( 1520 , true );--���_�}���\��

	else--���܂�|�������I����Ă��Ȃ�
	
		proxy:SetDrawEnable( 1520 , false );--���_�}����\��
	
		proxy:EnableLogic( 452 , false ); --�����̃��W�b�NOFF
		--proxy:EnableLogic( 405 , false ); --���m�̃��W�b�NOFF
		proxy:EnableLogic( 406 , false );
		proxy:EnableLogic( 407 , false );
		proxy:EnableLogic( 408 , false );

		proxy:SetDeadMode( 452,true );		
		--proxy:EnableInvincible( 405 , true );--���m���S���G
		proxy:EnableInvincible( 406 , true );
		proxy:EnableInvincible( 407 , true );
		proxy:EnableInvincible( 408 , true );
		InvalidCharactor( proxy, 405 );
	end


	--��1051���G�������Ă���2��
	
	if proxy:IsCompleteEvent( 1051 ) == false then
		proxy:Warp( 423 , 2455 );--�i���̏��
		proxy:EnableLogic( 423 , false );--���W�b�NOFF�őҋ@
	end
	

	--��1070���הn�Ԃ��K�^�K�^1��
	
	proxy:Warp( 440 , 2432 );--�הn�Ԃ̒��Ƀ��[�v
	proxy:Warp( 441 , 2433 );
	
	proxy:EnableLogic( 440 , false );--���W�b�NOFF
	proxy:EnableLogic( 441 , false );
	
	proxy:SetIgnoreHit( 440 , true );--�S�����薳��
	proxy:SetIgnoreHit( 441 , true );

	proxy:SetDisableGravity( 440 , true );--�d�͖���
	proxy:SetDisableGravity( 441 , true );

	OnEvent_1070_inu  (proxy, param);--(���A�@����)
	OnEvent_1070_basya(proxy, param);--(�n�ԁA����)
	

	--��1071���הn�Ԃ��K�^�K�^2��
		
	proxy:Warp( 443 , 2435 );--�הn�Ԃ̒��Ƀ��[�v
	proxy:Warp( 444 , 2436 );
	
	proxy:EnableLogic( 443 , false );--���W�b�NOFF
	proxy:EnableLogic( 444 , false );
	
	proxy:SetIgnoreHit( 443 , true );--�S�����薳��
	proxy:SetIgnoreHit( 444 , true );
	
	proxy:SetDisableGravity( 443 , true );--�d�͖���
	proxy:SetDisableGravity( 444 , true );
		
	OnEvent_1071_inu  (proxy, param);--(���A�@����)
	OnEvent_1071_basya(proxy, param);--(�n�ԁA����)
	
	
	--��1079���הn�Ԃ������Ă��遡
	if proxy:IsCompleteEvent( 1079 ) == false then
		--�����ƕ��m�̃��W�b�N��OFF
		proxy:EnableLogic( 452 , false ); --����
		InvalidCharactor( proxy, 405 );
		--proxy:EnableLogic( 405 , false ); --���m
		proxy:EnableLogic( 406 , false );
		proxy:EnableLogic( 407 , false );
		proxy:EnableLogic( 408 , false );
	else
		--�΂�SFX�͂����܂܁B
		proxy:SetObjSfx( 1495 , 1 , 1400 , true );
		proxy:SetObjSfx( 1495 , 2 , 1400 , true );
		proxy:SetObjSfx( 1495 , 3 , 1400 , true );
		
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			--proxy:OnKeyTime2( 1170 , "OnEvent_1170_1400",1.0,0,1400,once);			
			--proxy:OnKeyTime2( 1170 , "OnEvent_1170_1401",1.5,0,1401,once);			
			--proxy:OnKeyTime2( 1170 , "OnEvent_1170_1402",1.7,0,1402,once);
			proxy:OnObjectDamageHit_NoCallPlus( 1170, 1495,1,10310,EV_HIT_CHR,1.2,-1,2.0,everytime);
			proxy:OnObjectDamageHit_NoCallPlus( 1170, 1495,2,10310,EV_HIT_CHR,1.2,-1,2.0,everytime);
			proxy:OnObjectDamageHit_NoCallPlus( 1170, 1495,3,10310,EV_HIT_CHR,1.2,-1,2.0,everytime);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();		
	end
	
	--[[
	--��1065������A�̑���ς���(���̉��̂ق��֑��点��)��
	if proxy:IsCompleteEvent( 1065 ) == true then
		proxy:EnableLogic( 452 , true );--[[�ǉ�]]
		proxy:Warp( 452 , 2513 );--�ړI�n�Ƀ��[�v
		proxy:ChangeInitPosAng( 452 , 2513 );--����ړI�n�ɍX�V
		proxy:ForceUpdateNextFrame( 452 );--���̃t���[���͋����X�V
	end
	]]
	
	
	--��1085���ׂ��H�n�̔����}�ɊJ����	
	if proxy:IsCompleteEvent( 1085 ) == false then
		proxy:EnableLogic( 400 , false );--���mA���W�b�NOFF
		proxy:EnableLogic( 401 , false );--���mB���W�b�NOFF
		proxy:EnableLogic( 402 , false );--���mC���W�b�NOFF
	else
		proxy:EndAnimation( 1499 , 1 );--���͊J���Ă���		
		proxy:ReconstructBreak( 1530 , 1 );
	end
	
	
	--��1086���ׂ��H�n����G����яo���Ă��遡
	if proxy:IsCompleteEvent( 1086 ) == true then
		--���m�������A�ړI�n�܂ő���I��������Ƃɂ���
		proxy:Warp( 400 , 2484 );
		proxy:Warp( 401 , 2485 );
		proxy:Warp( 402 , 2486 );
	end
	
	
	--��1088�������̎w���ŋ|�����|�������Ă��遡
	if proxy:IsCompleteEvent( 1088 ) == false then
		proxy:EnableLogic( 451 , false );--����(2�C��)
		proxy:EnableLogic( 410 , false );--�|�����W�b�NOFF
		proxy:EnableLogic( 411 , false );
		proxy:EnableLogic( 412 , false );
		proxy:EnableLogic( 413 , false );
		proxy:EnableLogic( 414 , false );
	end
	
	
	--��1270�������̎w���ŋ|�����|�������Ă���2��
	
	proxy:SetDeadMode( 453 , true );--3�C�ڂ̍����͒ʏ�ł͎E���Ȃ�(���̌��ɎE�����)
	
	if proxy:IsCompleteEvent( 1270 ) == false then
		proxy:EnableLogic( 453 , false );--����(3�C��)
		proxy:EnableLogic( 480 , false );--�|�����W�b�NOFF
		proxy:EnableLogic( 481 , false );
		proxy:EnableLogic( 482 , false );
	end
	
	if proxy:IsCompleteEvent( 1271 ) == true then
		print("�����ړ��̃|����������");		
		--453�̍������[�v �{�X�����̒��őҋ@���Ă���
		proxy:Warp( 453 , 2507 );
		proxy:EnableLogic( 453 , false );
	end

	
	
	--��1280������1 ���S�`�F�b�N��
	if proxy:IsCompleteEvent( 1280 ) == true then
		if proxy:IsCompleteEvent( 15621 ) == false then
			--�󎀑̂��Č�
			proxy:OpeningDeadPlus( 451 , true ,false ,false );
		else
			InvalidCharactor( proxy, 451 );
		end
	end
	
	--��1281������2 ���S�`�F�b�N��
	if proxy:IsCompleteEvent( 1281 ) == true then
		if proxy:IsCompleteEvent( 15620 ) == false then
			--�󎀑̂��Č�
			proxy:OpeningDeadPlus( 452 , true ,false ,false );			
		else
			InvalidCharactor( proxy, 452 );
		end
	end
	
	--��1282������3 ���S�`�F�b�N��
	if proxy:IsCompleteEvent( 1282 ) == true then
		InvalidCharactor( proxy, 453 );
	end
	
	
		
	--��1036�����{�X�|�����Đ��� 
	if proxy:IsCompleteEvent( 1036 ) == true then--�Đ��I�����Ă���
		print("���̌��̃|���������Ă��鏉����");

		--���̌����̒��ɗ���
		proxy:SetDrawEnable( 802 , true );
	
		--����(453)�����{�X�����̒��Ŏ���ł���
		proxy:StopLoopAnimation( 453 );
		proxy:PlayLoopAnimation( 453 , 2210 );--���S�ҋ@
		proxy:SetColiEnable( 453 , false );--������OFF
		proxy:SetDrawEnable( 453 , true );--�`��ON
		proxy:EnableLogic( 453 , false );
		proxy:Warp( 453 , 2505 );--����ł���ʒu�̗̈�
		proxy:EnableHide( 453 , true );--�T������Ȃ�
		proxy:EnableInvincible( 453 , true );--���S���G(�����΍�)
	else
		proxy:SetDrawEnable( 802 , false );--���̌��A�\��OFF(���̉��̉��ɂ���z��)
	end
	

	--�����̌��̎��S�Č�
	if proxy:IsCompleteEvent( 4360 ) ==true then
		--�{�X������ł���ꍇ�{�X���폜
		InvalidBackRead( proxy , 802 );
	else
		--�{�X�������Ă���ꍇ�̓��W�b�NOFF�őҋ@		
		proxy:EnableLogic( 802 , false );
		print( "���̌�(id:802) logic off" );		
	end
	
	



	--�����{�X���S�Ŕ����J��(����ł�����A�`��Ɠ����������)
	if proxy:IsCompleteEvent( 4360 ) == true then
		proxy:SetColiEnable( 1997 , false );
		proxy:SetColiEnable( 1993 , false );
	
		proxy:SetDrawEnable( 1997 , false );
		proxy:SetDrawEnable( 1993 , false );
		
		--SFX OFF
		proxy:InvalidSfx( 1985 , false );
		proxy:InvalidSfx( 1989 , false );
	end
	
	
	
	--��4372,4374���\�E������A�v�΂Ń��[�v��
	if proxy:IsCompleteEvent( 4360 ) ==true then--�{�X������ł���Ƃ�
		proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--���点��
		--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
		if proxy:IsCompleteEvent( 4372 ) == false then
			proxy:ValidSfx( 1420 );--SFX �L����
			proxy:ValidSfx( 1421 );--���̗��q
			proxy:OnDistanceActionAttribute( 4372 , 10000 , 1980 , "OnEvent_4372" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );

			--�\�E���L����
			proxy:SetDrawEnable( 1980 , true );
			proxy:SetColiEnable( 1980 , true );
			--�\�E��2�L����
			proxy:SetDrawEnable( 1977 , true );
			proxy:SetColiEnable( 1977 , true );

		else
			--���v�΂Ń��[�v�p�̊Ď���ǉ���
			proxy:InvalidSfx( 1420, false );--SFX ������
			SingleReset( proxy , 4374 );
			proxy:OnDistanceActionAttribute( 4374 , 10000 , 1980 , "OnEvent_4374" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end

	else
		--�\�E��������
		proxy:SetDrawEnable( 1980 , false );
		proxy:SetColiEnable( 1980 , false );
		--�\�E��2������
		proxy:SetDrawEnable( 1977 , false );
		proxy:SetColiEnable( 1977 , false );
		--SFX ������
		proxy:InvalidSfx( 1420 , false );
		proxy:InvalidSfx( 1421 , false );
	end

	--��1300���H����G�̏�����������	
	--�ЂƂ܂��\���p
	SingleReset( proxy , 1220 );
	if proxy:IsCompleteEvent( 1220 ) == false then
		proxy:EnableLogic( 454 , 0 );
	end
	
	
	--��1222���H����G�̎��S�`�F�b�N��
	if proxy:IsCompleteEvent( 1222 ) == true then
		InvalidCharactor( proxy, 454 );
	end
	


	--��1250���R����m���]���藎���Ă���1��
	proxy:SetObjSfx( 1496 , 1 , 1400 , true );--�΂�SFX��t����
	if proxy:IsCompleteEvent( 1250 ) == true then
		
		proxy:EndAnimation( 1496 , 1 );--�m�͓]����I�����
		proxy:EnableLogic( 470 , true );--���m�͂��낤�낵�Ă�͂�		
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			--proxy:OnKeyTime2( 1171 , "OnEvent_1171_1403",1.8,0,1403,once);			
			proxy:OnObjectDamageHit_NoCallPlus( 1171, 1403,1,10310,EV_HIT_CHR,1.2,-1,2.0,everytime);			
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();	
	
	else
		proxy:EnableLogic( 470 , false );--���W�b�NOFF�őҋ@
	end

	
	--��1251���R����m���]���藎���Ă���2��	
	proxy:SetObjSfx( 1497 , 1 , 1400 , true );--�΂�SFX��t����
	if proxy:IsCompleteEvent( 1251 ) == true then
		
		proxy:EndAnimation( 1497 , 1 );--�m�͓]����I�����
		proxy:EnableLogic( 471 , true );--���m�͂��낤�낵�Ă�͂�		
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			--proxy:OnKeyTime2( 1172 , "OnEvent_1172_1404",1.9,0,1404,once);			
			proxy:OnObjectDamageHit_NoCallPlus( 1172, 1404,1,10310,EV_HIT_CHR,1.2,-1,2.0,everytime);			
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();	
		
	else
		proxy:EnableLogic( 471 , false );--���W�b�NOFF�őҋ@
	end	
	
	
--�������h�����q�C�x���g�֘A������
	
	--�����h�����q�̌��݂̏�Ԃ��擾
	local now_rendol_state = GetRendolState(proxy, param);
	
	--�����Ȃ��ꏊ�ɂ�������
	if now_rendol_state == RENDOL_STATE_LOCATION_INVISIBLE then
	
		proxy:EnableLogic( 621 , false );--�����h�����q���W�b�NOFF

	--����J���Ăق���
	elseif now_rendol_state == RENDOL_STATE_WANT_TO_OPEN_THE_GATE then
	
		proxy:ChangeInitPosAng( 621 , 2552 );--�����̑O�̗̈�ɂ���
		if proxy:IsClient() == false then
			proxy:Warp( 621 , 2552 );--��̑O�̗̈�ɓ����ς�(���[�v)
		end
		
		proxy:SendEventRequest( 621 , 0 , 10 );--�u�ⓚ���p�ő��܂ő���(ID:10)�v�̃��W�b�N�ɐ؂�ւ�
	
	--�܏��H����
	elseif now_rendol_state == RENDOL_STATE_SCARED then
	
		proxy:ChangeInitPosAng( 621 , 2553 );--����܏��H�̗̈�ɂ���
		if proxy:IsClient() == false then
			proxy:Warp( 621 , 2553 );--�܏��H�̗̈�ɓ����ς�(���[�v)
		end
		
		--proxy:EnableLogic( 621 , 0 );--���W�b�NOFF
		--proxy:SetEventCommand( 621 , 40 );--EzState�ɐ���ԍ���n��(������)
	
	--����(����3)
	elseif now_rendol_state == RENDOL_STATE_THANKS_3 then
	
		proxy:ChangeInitPosAng( 621 , 2555 );--����Ή�����̈�ɂ���
		if proxy:IsClient() == false then
			proxy:Warp( 621 , 2555 );--�Ή�����̈�ɓ����ς�(���[�v)
		end
		
		--proxy:EnableLogic( 621 , 0 );--���W�b�NOFF
		
	--�T��(����3)
	elseif now_rendol_state == RENDOL_STATE_SEARCH_3 then
	
		proxy:ChangeInitPosAng( 621 , 2555 );--����Ή�����̈�ɂ���
		if proxy:IsClient() == false then
			proxy:Warp( 621 , 2555 );--�Ή�����̈�ɓ����ς�(���[�v)
		end
	
	--�G��(����3 ���O)
	elseif now_rendol_state == RENDOL_STATE_HOSTILE_3_FRONT_GATE then
	
		proxy:ChangeInitPosAng( 621 , 2552 );--�����̑O�̗̈�ɂ���
		if proxy:IsClient() == false then
			proxy:Warp( 621 , 2552 );--��̑O�̗̈�ɓ����ς�(���[�v)
		end
		--[[���炭�A���W�b�N��؂�ւ���Ȃǂ���?]]
		
	--�G��(����3 �����)
	elseif now_rendol_state == RENDOL_STATE_HOSTILE_3_BACK_GATE then

		proxy:ChangeInitPosAng( 621 , 2555 );--�����̌��̗̈�ɂ���
		if proxy:IsClient() == false then
			proxy:Warp( 621 , 2555 );--��̌��̗̈�ɓ����ς�(���[�v)
		end
		--[[���炭�A���W�b�N��؂�ւ���Ȃǂ���?]]
	
	--����ł���
	elseif now_rendol_state == RENDOL_STATE_DEAD then
	
		InvalidCharactor( proxy , 621 );--�����h�����q������
	end
	
	
	
	
	
	
	
	--��1350�������h�����q��ǂ��G���o������1��
	if proxy:IsCompleteEvent( 1310 ) == false then	
		InvalidCharactor( proxy, 460 );	
		InvalidCharactor( proxy, 461 );	
		InvalidCharactor( proxy, 462 );
	end		
	
	
	--��1410����ʕ��m�̎��S�Ď���
	if proxy:IsCompleteEvent( 1410 ) == true then
		InvalidCharactor( proxy, 460 );
	end

	--��1411����ʕ��m�̎��S�Ď���
	if proxy:IsCompleteEvent( 1411 ) == true then
		InvalidCharactor( proxy, 461 );
	end

	--��1412����ʕ��m�̎��S�Ď���
	if proxy:IsCompleteEvent( 1412 ) == true then
		InvalidCharactor( proxy, 462 );
	end
		
--��8084������֗����t���O�𗧂Ă遡
	proxy:SetEventFlag(8084, true);


--�J���X�C�x���g�����s�[�g�����邽�߂�SingleReset()
	for IndexID = 1121, 1150, 1 do
		SingleReset(proxy, IndexID);
	end

--�J���X���o�b���߂Â��Ɣ�ї���
	for KarasuID = 1121, 1150, 1 do
		if proxy:IsCompleteEvent( KarasuID ) == false then
			proxy:OnPlayerDistanceInTarget( KarasuID, 10000, 444 + KarasuID, "OnEvent_"..KarasuID, 5, once );
		else
			proxy:SetDrawEnable(444 + KarasuID, false);
		end
	end

	--�z�΂̐���̎��S�Ď�	
	if proxy:IsCompleteEvent(1160) == false then
		proxy:OnCharacterDead( 1160 , 185,"OnEvent_1160",once);	
		
		if proxy:IsClient() == false and proxy:IsCompleteEvent(8020) == false then
			proxy:NotNetMessage_begin();
				proxy:AddCorpseEvent( 8020 , 185 );
				proxy:LuaCall( 8020 , 0 , "OnEvent_8020",once);
			proxy:NotNetMessage_end();
		end
	end
	--------------------------------������QWC�C�x���g�֘A������--------------------------------
	
	SingleReset(proxy,1161);
	if proxy:IsClient() == false then
		if proxy:IsSuccessQWC(20200) == false then
			proxy:SetEventFlag( 1161 , true );
		end
	end
	
	--QWC�l�ōz�΂̐���̏o������
	if proxy:IsCompleteEvent(1160) == true or proxy:IsCompleteEvent(1161) == true then
		--�E�����@or�@�񐬗��Ȃ������
		InvalidBackRead( proxy,185);	
	end
	
--��1110��QWC�\�E�������X�^�[�o���P��
	if	proxy:IsClient() == false then
		SingleReset(proxy, 1110);
	end
	--�ォ������Ă���l�����ɕ\����On�ɂȂ��Ă��邩�`�F�b�N����
	if	proxy:IsCompleteEvent(1110) == false then
		InvalidCharactor( proxy, 180 );
		InvalidCharactor( proxy, 181 );
	end
	if	proxy:IsSuccessQWC(20100) == true then
		print("QWC�\�E�������X�^�[�o��m02_02�@����");
		proxy:OnRegionJustIn( 1110, LOCAL_PLAYER, 2420, "OnEvent_1110", once );
	else
		print("QWC�\�E�������X�^�[�o��m02_02�@������");
	end
	
	--�����g�J�Q���S�C�x���g
	RegistTokage(proxy,1090,256,3);
	
--------------------------------������QWC�C�x���g�֘A������--------------------------------

	--��999999���t���[���x��̏����������C�x���g�𔭍s��
	proxy:NotNetMessage_begin();
		--��0�b�づ--
		proxy:OnKeyTime2( 999992, "Second_Initialize_m02_02_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m02_02_00_00 end");
end

--------------------------------------------------------------------------------------
--Initialize����Ă΂��A1�t���[���x��̏�����������999999
--------------------------------------------------------------------------------------
--��999999���ꕔ�AInit�ł͏����ł��Ȃ��̂ŁA�c���Ă���
function Second_Initialize_m02_02_00_00(proxy, param)
	print("Second_Initialize_m02_02_00_00 begin");

--------------------------------������QWC�C�x���g�֘A������--------------------------------
--------------------------------������QWC�C�x���g�֘A������--------------------------------

	--��1082 �����܂�|�������I����Ė���
	if proxy:IsCompleteEvent( 1082 ) == false then
		--��V�X�e��������
		proxy:EnableObjTreasure( 11502 , false );
		proxy:SetDrawEnable( 11502,false);
	end
	print("Second_Initialize_m02_02_00_00 end");
end






--------------------------------------------------------------------------------------
--���J�����o�[��1040
--------------------------------------------------------------------------------------
--��1040�����J�����o�[��
function OnEvent_1040(proxy, param)
	print("OnEvent_1040 begin");
		
	proxy:PlayAnimation(1450, 1);--���J�����o�[�A�j���Đ�	
	
	proxy:NotNetMessage_begin();
		--��1040_2��***�����ǉ�***���o�[�A�j���I����
		proxy:OnObjAnimEnd( 1040, 1450, 1, "OnEvent_1040_2", once);
	proxy:NotNetMessage_end();
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PULL_LEVER ) == true then
		--�p�[�e�B�[�v���C���[���A�j���[�V���������ꍇ�͂����ŏ����I��
		print("OnEvent_1040 end");
		return;
	end
	
	proxy:WarpDmy( 10000 , 1450 , 191 );
	
	print("OnEvent_1040 end");
end

--��1040_2�����o�[�A�j���I����
function OnEvent_1040_2(proxy, param)
	print("OnEvent_1040_2 begin");

	proxy:SetEventFlag( 1040, true );
	
	if	proxy:IsCompleteEvent( RENDOL_STATE_WANT_TO_OPEN_THE_GATE ) == true then
		OnEvent_1311(proxy,param);
	end
	
	--[[
	--�z�X�g�̂ݎ��s
	if	proxy:IsClient() == false then
		--��1041��***�����ǉ�***0�b�づ--(�A�N�V����ID�������Ă���̂́A�G�N�Z���̃t���O�����ɍ��킹��ׂł�)
		--proxy:OnKeyTime2( 1041, "OnEvent_1041", 0.0, 0, 1, once );
		--��OnEvent_1041
		proxy:LuaCallStart( 1041, 1 );
	end
	]]
	
	proxy:PlayAnimation( 1440, 1 );--����J���A�j�����Đ�	
	proxy:SetEventFlag( 1041 , true );
	print("OnEvent_1040_2 end");
end

--[[
function OnEvent_1041(proxy,param)
	print("OnEvent_1041 begin");
	
	proxy:PlayAnimation( 1440, 1 );--����J���A�j�����Đ�
	--proxy:RequestRemo(20203,REMO_FLAG,1041,1);--���傪�J���|�����Đ�
	proxy:SetEventFlag( 1041 , true );
	
	print("OnEvent_1041 end");
end


--------------------------------------------------------------------------------------
--���J�����o�[�C�x���g�I���ち1041
--------------------------------------------------------------------------------------

--�|�����t�F�[�h������ɌĂ΂��n���h��
function OnEvent_1041_RemoStart(proxy,param)
	print("OnEvent_1041_RemoStart begin");
	
	--proxy:SetDrawEnable( 405 , false );--�|�������͕\��OFF
	
	print("OnEvent_1041_RemoStart end");
end


--�|�����I����ɌĂ΂��n���h��
function OnEvent_1041_RemoFinish(proxy , param)
	print("OnEvent_1041_RemoFinish begin");
	
	--proxy:SetDrawEnable( 405 , true );--�|�����I������̂ŁA�\��ON
	--proxy:EndAnimation( 1440, 1 );--����J���A�j�����Đ�

	print("OnEvent_1041_RemoFinish end");
end
]]

--------------------------------------------------------------------------------------
--��1051���G�������Ă���2��
--------------------------------------------------------------------------------------

--��1051_0_1���G�������Ă���(�U�����󂯂��ꍇ�̏���)��ID423
function OnEvent_1051_0_1(proxy,param)	
	print("OnEvent_1051_0_1 begin");
	
	proxy:NotNetMessage_begin();
		--��1051��0�b�と�G�������Ă���ց�
		proxy:OnKeyTime2( 1051 , "OnEvent_1051" , 0.0 , 0 , 1 , once );
	proxy:NotNetMessage_end();	

	print("OnEvent_1051_0_1 end");
end


--��1051���G�������Ă��遡��C�ɂȂ���
function OnEvent_1051(proxy,param)	
	print("OnEvent_1051 begin");
	
	proxy:DisableMapHit( 423, true );
	proxy:SetDisableGravity( 423 , true );
	
	proxy:SetColiEnable( 423 , false );
	proxy:PlayAnimation( 423 , 7000 );
	
	proxy:NotNetMessage_begin();
		--��1051_1���G�������Ă���A�j���Đ��I����
		proxy:OnKeyTime2( 1051 , "OnEvent_1051_1" , (13/30) , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1051 , 1 );
	
	print("OnEvent_1051 end");
end


--��1051_1���G�������Ă���A�j���Đ��I����
function OnEvent_1051_1(proxy,param)	
	print("OnEvent_1051_1 begin");
	
	proxy:DisableMapHit( 423, false );
	proxy:SetDisableGravity( 423 , false );	
	
	proxy:SetColiEnable( 423 , true );
	proxy:EnableLogic( 423 , true );
	
	proxy:DeleteEvent( 1051 );
	
	print("OnEvent_1051_1 end");
end





--------------------------------------------------------------------------------------
--��1070���הn�Ԃ��K�^�K�^1��
--------------------------------------------------------------------------------------

--����------------------------------------------------

function OnEvent_1070_inu(proxy, param)

	OnEvent_1070_440_anime1_start(proxy, param);--��A�̃A�j��1�Đ��J�n
	OnEvent_1070_441_anime1_start(proxy, param);--��B�̃A�j��1�Đ��J�n

end

-- ��A -----------------------------------------------

--����A�̃A�j��1�Đ��J�n��
function OnEvent_1070_440_anime1_start(proxy, param)
	
	proxy:ForcePlayAnimation( 440 , 7000 );--��A �A�j��1
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_440_anime1_wait" , 0.1 , 0 , 50 , once);
	proxy:NotNetMessage_end();		
end

function OnEvent_1070_440_anime1_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--����A�̃A�j��1�Đ��I����
		proxy:OnChrAnimEnd( 1070 , 440 , 7000 , "OnEvent_1070_440_anime1_end" , once );
	proxy:NotNetMessage_end();
end

--����A�̃A�j��1�Đ��I����
function OnEvent_1070_440_anime1_end(proxy, param)

	proxy:ForcePlayAnimation( 440 , 7010 );--��A �A�j��2
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_440_anime2_wait" , 0.1 ,0,51, once );
	proxy:NotNetMessage_end();
end

function OnEvent_1070_440_anime2_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--����A�̃A�j��2�Đ��I����
		proxy:OnChrAnimEnd( 1070 , 440 , 7010 , "OnEvent_1070_440_anime2_end" , once );
	proxy:NotNetMessage_end();
end

--����A�̃A�j��2�Đ��I����
function OnEvent_1070_440_anime2_end(proxy, param)
	proxy:ForcePlayAnimation( 440 , 7010 );--��A �A�j��3
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_440_anime3_wait" , 0.1 , 0 , 52 , once );
	proxy:NotNetMessage_end();
end

function OnEvent_1070_440_anime3_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--����A�̃A�j��2�Đ��I����
		proxy:OnChrAnimEnd( 1070 , 440 , 7010 , "OnEvent_1070_440_anime3_end" , once );
	proxy:NotNetMessage_end();
end

function OnEvent_1070_440_anime3_end(proxy,param)
	proxy:NotNetMessage_begin();
		--����A�̃A�j��2�Đ��I����
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_440_anime1_start" , 0.0 , 0 , 53 , once );
	proxy:NotNetMessage_end();
end

-- ��B -------------------------------------------

--����B�̃A�j��1�Đ��J�n��
function OnEvent_1070_441_anime1_start(proxy, param)
	
	proxy:PlayAnimation( 441 , 7010 );--��B �A�j��1

	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 441 , "OnEvent_1070_441_anime1_wait",0.1,0,54,once);
	proxy:NotNetMessage_end();
	
end

function OnEvent_1070_441_anime1_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--����B�̃A�j��1�Đ��I����
		proxy:OnChrAnimEnd( 1070 , 441 , 7010 , "OnEvent_1070_441_anime1_end" , once );
	proxy:NotNetMessage_end();
end

--����B�̃A�j��1�Đ��I����
function OnEvent_1070_441_anime1_end(proxy, param)

	proxy:PlayAnimation( 441 , 7000 );--��B �A�j��2
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_441_anime2_wait" , 0.1 , 0 , 55 , once );
	proxy:NotNetMessage_end();
	
end

function OnEvent_1070_441_anime2_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--����B�̃A�j��2�Đ��I����
		proxy:OnChrAnimEnd( 1070 , 441 , 7000 , "OnEvent_1070_441_anime2_end" , once );
	proxy:NotNetMessage_end();
end

--����B�̃A�j��2�Đ��I����
function OnEvent_1070_441_anime2_end(proxy, param)
	
	proxy:PlayAnimation( 441 , 7000 );--��B �A�j��2
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_441_anime3_wait" , 0.1 , 0 , 56, once );
	proxy:NotNetMessage_end();
	
end

function OnEvent_1070_441_anime3_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--����B�̃A�j��2�Đ��I����
		proxy:OnChrAnimEnd( 1070 , 441 , 7000 , "OnEvent_1070_441_anime3_end" , once );
	proxy:NotNetMessage_end();
end


--����B�̃A�j��2�Đ��I����
function OnEvent_1070_441_anime3_end(proxy, param)
	
	proxy:NotNetMessage_begin();
		--����B�̃A�j��2�Đ��I����
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_441_anime1_start" , 0.0 , 0 , 57 , once );
	proxy:NotNetMessage_end();
	
end

--���n��---------------------------------------------

--�n�Ԃ̃A�j�������_�����Đ�(���Ԃɥ��)
--2 �� 3 �� 3 
function OnEvent_1070_basya(proxy , param)
	--print("OnEvent_1070_basya");
	proxy:PlayAnimation( 1470 , 2 );
	
	proxy:NotNetMessage_begin();
		--��1070_basya_1���n�ԃA�j��1�I��聥
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_basya_wait",1.0,0,1,once);
	proxy:NotNetMessage_end();
	
end

function OnEvent_1070_basya_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--��1070_basya_1���n�ԃA�j��1�I��聥
		proxy:OnCharacterAnimEndPlus( 1070 , 1470 , 2 , "OnEvent_1070_basya_1" , once );
	proxy:NotNetMessage_end();
end

--��1070_basya_1���n�ԃA�j��2�I��聣
function OnEvent_1070_basya_1(proxy , param)
	--print("OnEvent_1070_basya_1")
	proxy:PlayAnimation( 1470 , 3 );
	
	proxy:NotNetMessage_begin();
		--��1071_basya_2���n�ԃA�j��2�I��聥
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_basya_1_wait",1.0,0,2,once);
	proxy:NotNetMessage_end();
	
end

function OnEvent_1070_basya_1_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--��1071_basya_2���n�ԃA�j��2�I��聥
		proxy:OnCharacterAnimEndPlus( 1070 , 1470 , 3 , "OnEvent_1070_basya_2" , once );
	proxy:NotNetMessage_end();
end


--��1070_basya_2���n�ԃA�j��2�I��聣
function OnEvent_1070_basya_2(proxy , param)
	--print("OnEvent_1070_basya_2")
	proxy:PlayAnimation( 1470 , 3 );
	
	proxy:NotNetMessage_begin();
		--��1070_basya_3���n�ԃA�j��3�I��聨�ŏ��̂ց�
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_basya_2_wait",1.0,0,3,once);
	proxy:NotNetMessage_end();
	
end

function OnEvent_1070_basya_2_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--��1070_basya_3���n�ԃA�j��3�I��聨�ŏ��̂ց�
		proxy:OnCharacterAnimEndPlus( 1070 , 1470 , 3 , "OnEvent_1070_basya_3" , once );--[[�y��ID 1072�z]] 
	proxy:NotNetMessage_end();
end

--��1070_basya_3���n�ԃA�j��3�I��聣
function OnEvent_1070_basya_3(proxy , param)
	--print("OnEvent_1070_basya_3")
	proxy:NotNetMessage_begin();
		--��1070_basya���n�ԃA�j��3�I��聨�ŏ��̂ց�
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_basya" , 0.0 , 0 , 3 , once );
	proxy:NotNetMessage_end();
	
end


--------------------------------------------------------------------------------------
--��1071���הn�Ԃ��K�^�K�^2��
--------------------------------------------------------------------------------------

--����------------------------------------------------

function OnEvent_1071_inu(proxy, param)

	OnEvent_1071_443_anime1_start(proxy, param);--��A�̃A�j��1�Đ��J�n
	OnEvent_1071_444_anime1_start(proxy, param);--��B�̃A�j��1�Đ��J�n

end

-- ��A -----------------------------------------------

--����A�̃A�j��1�Đ��J�n��
function OnEvent_1071_443_anime1_start(proxy, param)
	
	proxy:PlayAnimation( 443 , 7010 );--��A �A�j��1

	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 443 , "OnEvent_1071_443_anime1_wait" , 0.1 , 0 , 58 , once );
	proxy:NotNetMessage_end();
	
end

function OnEvent_1071_443_anime1_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--����A�̃A�j��1�Đ��I����
		proxy:OnChrAnimEnd( 1071 , 443 , 7010 , "OnEvent_1071_443_anime1_end" , once );
	proxy:NotNetMessage_end();
end

--����A�̃A�j��1�Đ��I����
function OnEvent_1071_443_anime1_end(proxy, param)

	proxy:PlayAnimation( 443 , 7000 );--��A �A�j��2
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1071 , "OnEvent_1071_443_anime2_wait" , 0.1 , 0, 59 ,once );
	proxy:NotNetMessage_end();
	
end

function OnEvent_1071_443_anime2_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--����A�̃A�j��2�Đ��I����
		proxy:OnChrAnimEnd( 1071 , 443 , 7000 , "OnEvent_1071_443_anime2_end" , once );
	proxy:NotNetMessage_end();
end


--����A�̃A�j��2�Đ��I����
function OnEvent_1071_443_anime2_end(proxy, param)
	
	proxy:PlayAnimation( 443 , 7010 );--��A �A�j��2
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1071 ,"OnEvent_1071_443_anime3_wait" , 0.1 , 0 , 60 , once );
	proxy:NotNetMessage_end();
	
end

function OnEvent_1071_443_anime3_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--����A�̃A�j��2�Đ��I����
		proxy:OnChrAnimEnd( 1071 , 443 , 7010 , "OnEvent_1071_443_anime3_end" , once );
	proxy:NotNetMessage_end();
end

--����A�̃A�j��2�Đ��I����
function OnEvent_1071_443_anime3_end(proxy, param)
	
	proxy:NotNetMessage_begin();
		--����A�̃A�j��2�Đ��I����
		proxy:OnKeyTime2( 1071 , "OnEvent_1071_443_anime1_start" , 0.0 , 0 , 61 , once );
	proxy:NotNetMessage_end();
	
end

-- ��B -------------------------------------------

--����B�̃A�j��1�Đ��J�n��
function OnEvent_1071_444_anime1_start(proxy, param)
	
	proxy:PlayAnimation( 444 , 7000 );--��B �A�j��1

	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1071, "OnEvent_1071_444_anime1_wait" , 0.1 , 0 , 62 , once );
	proxy:NotNetMessage_end();	
end

function OnEvent_1071_444_anime1_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--����B�̃A�j��1�Đ��I����
		proxy:OnChrAnimEnd( 1071 , 444 , 7000 , "OnEvent_1071_444_anime1_end" , once );
	proxy:NotNetMessage_end();
end

--����B�̃A�j��1�Đ��I����
function OnEvent_1071_444_anime1_end(proxy, param)

	proxy:PlayAnimation( 444 , 7010 );--��B �A�j��2
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1071 , "OnEvent_1071_444_anime2_wait" , 0.1 , 0 , 63 , once );
	proxy:NotNetMessage_end();

end

function OnEvent_1071_444_anime2_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--����B�̃A�j��2�Đ��I����
		proxy:OnChrAnimEnd( 1071 , 444 , 7010 , "OnEvent_1071_444_anime2_end" , once );
	proxy:NotNetMessage_end();
end

--����B�̃A�j��2�Đ��I����
function OnEvent_1071_444_anime2_end(proxy, param)
	proxy:PlayAnimation( 444 , 7000 );--��B �A�j��2
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1071 , "OnEvent_1071_444_anime3_wait" , 0.1 , 0 , 64 , once );
	proxy:NotNetMessage_end();	
end

function OnEvent_1071_444_anime3_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--����B�̃A�j��2�Đ��I����
		proxy:OnChrAnimEnd( 1071 , 444 , 7000 , "OnEvent_1071_444_anime3_end" , once );
	proxy:NotNetMessage_end();	
end

--����B�̃A�j��2�Đ��I����
function OnEvent_1071_444_anime3_end(proxy, param)
	
	proxy:NotNetMessage_begin();
		--����B�̃A�j��2�Đ��I����
		proxy:OnKeyTime2( 1071 , "OnEvent_1071_444_anime1_start" , 0.0 , 0 , 65 , once );
	proxy:NotNetMessage_end();
	
end


--���n��---------------------------------------------

--�n�Ԃ̃A�j�������_�����Đ�(���Ԃɥ��)
--3 �� 2 �� 3 
function OnEvent_1071_basya(proxy , param)
	--print("OnEvent_1071_basya");
	proxy:PlayAnimation( 1471 , 3 );
	
	proxy:NotNetMessage_begin();
		--��1071_basya_1���n�ԃA�j��1�I��聥
		proxy:OnKeyTime2( 1071 , "OnEvent_1071_basya_wait",1.0,0,1,once);
	proxy:NotNetMessage_end();
	
end

function OnEvent_1071_basya_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--��1071_basya_1���n�ԃA�j��1�I��聥
		proxy:OnCharacterAnimEndPlus( 1071 , 1471 , 3 , "OnEvent_1071_basya_1" , once );
	proxy:NotNetMessage_end();
end

--��1071_basya_1���n�ԃA�j��2�I��聣
function OnEvent_1071_basya_1(proxy , param)
	--print("OnEvent_1071_basya_1")
	proxy:PlayAnimation( 1471 , 2 );
	
	proxy:NotNetMessage_begin();
		--��1071_basya_2���n�ԃA�j��2�I��聥
		proxy:OnKeyTime2( 1071 , "OnEvent_1071_basya_1_wait",1.0,0,2,once);
	proxy:NotNetMessage_end();
	
end

function OnEvent_1071_basya_1_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--��1071_basya_2���n�ԃA�j��2�I��聥
		proxy:OnCharacterAnimEndPlus( 1071 , 1471 , 2 , "OnEvent_1071_basya_2" , once );
	proxy:NotNetMessage_end();
end


--��1071_basya_2���n�ԃA�j��2�I��聣
function OnEvent_1071_basya_2(proxy , param)
	--print("OnEvent_1071_basya_2");
	proxy:PlayAnimation( 1471 , 3 );
	
	proxy:NotNetMessage_begin();
		--��1071_basya_3���n�ԃA�j��3�I��聨�ŏ��̂ց�
		proxy:OnKeyTime2( 1071 ,"OnEvent_1071_basya_2_wait",1.0,0,3,once);
	proxy:NotNetMessage_end();
	
end

function OnEvent_1071_basya_2_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--��1071_basya_3���n�ԃA�j��3�I��聨�ŏ��̂ց�
		proxy:OnCharacterAnimEndPlus( 1071 , 1471 , 3 , "OnEvent_1071_basya_3" , once );
	proxy:NotNetMessage_end();
end

--��1071_basya_3���n�ԃA�j��3�I��聣
function OnEvent_1071_basya_3(proxy , param)
	--print("OnEvent_1071_basya_3");
	proxy:NotNetMessage_begin();
		--��1071_basya���n�ԃA�j��3�I��聨�ŏ��̂ց�
		proxy:OnKeyTime2( 1071 , "OnEvent_1071_basya" , 0.0 , 0 , 3 , once );
	proxy:NotNetMessage_end();
	
end



--------------------------------------------------------------------------------------
--��1079���הn�Ԃ������Ă��遡
--------------------------------------------------------------------------------------

--��1079���הn�Ԃ������Ă��遡
function OnEvent_1079(proxy,param)	
	if proxy:IsCompleteEvent( 1082 ) == false then
		print("OnEvent_1079 begin");
		LuaFunc_ForceOmission( proxy,452 );
		proxy:PlayAnimation( 452 , 7000 );--���������}

		proxy:NotNetMessage_begin();
			--��1080�������̍��}�I����
			proxy:OnChrAnimEnd( 1080 , 452 , 7000 , "OnEvent_1080" , once );
		proxy:NotNetMessage_end();
	
		print("OnEvent_1079 end");
	end
end


--��1080�������̍��}�I����
function OnEvent_1080(proxy, param)
	print("OnEvent_1080 begin");
	LuaFunc_NormalOmission(proxy,452);
	proxy:SetEventFlag( 1079 , 1 );
	proxy:PlayAnimation( 1490 , 1 );--�הn�ԓ]����
	proxy:PlayAnimation( 1495 , 1 );--�m�]����

	proxy:NotNetMessage_begin();
		--��1080_anime_end���הn�Ԃ��]����A�j���I����
		proxy:OnCharacterAnimEnd( 1080 , 1490 , 1 , "OnEvent_1080_anime_end" , once );
	proxy:NotNetMessage_end();

	--�m�̉�ɉ΂�SFX��t����
	proxy:SetObjSfx( 1495 , 1 , 1400 , true );
	proxy:SetObjSfx( 1495 , 2 , 1400 , true );
	proxy:SetObjSfx( 1495 , 3 , 1400 , true );
	
	--�m�̉򂩂�_���[�W
	local paramid = 10010;
	local rad     = 1.0;
	local time    = 20;
	
	proxy:NotNetMessage_begin();
		--���΂̋�1 ���������Ƃ���
		proxy:OnObjectDamageHit_NoCall( 1080, 1495, 1, paramid, EV_HIT_CHR , rad, time, everytime );
		--���΂̋�2 ���������Ƃ���
		proxy:OnObjectDamageHit_NoCall( 1080, 1495, 2, paramid, EV_HIT_CHR , rad, time, everytime );	
		--���΂̋�3 ���������Ƃ���
		proxy:OnObjectDamageHit_NoCall( 1080, 1495, 3, paramid, EV_HIT_CHR , rad, time, everytime );
		proxy:SetObjEventCollisionFill( 1495, true );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1080 end");
end


--��1080_anime_end���הn�Ԃ��]����A�j���I����
function OnEvent_1080_anime_end(proxy, param)
	print("OnEvent_1080_anime_end begin");
	
	proxy:DeleteEvent( 1080 );--�_���[�W���̊Ď�������
	
	--�הn�Ԃ���A�^���𔲂�
	proxy:SetColiEnable( 1490 , false );
	--���_���[�W�ǉ�
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		--proxy:OnKeyTime2( 1170 , "OnEvent_1170_1400",1.0,0,1400,once);
		--proxy:OnKeyTime2( 1170 , "OnEvent_1170_1401",1.5,0,1401,once);
		--proxy:OnKeyTime2( 1170 , "OnEvent_1170_1402",1.7,0,1402,once);
		proxy:OnObjectDamageHit_NoCallPlus( 1170, 1495,1,10310,EV_HIT_CHR,1.2,-1,2.0,everytime);
		proxy:OnObjectDamageHit_NoCallPlus( 1170, 1495,2,10310,EV_HIT_CHR,1.2,-1,2.0,everytime);
		proxy:OnObjectDamageHit_NoCallPlus( 1170, 1495,3,10310,EV_HIT_CHR,1.2,-1,2.0,everytime);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	--�Č��p���׍H�t���O�E�E�E
	proxy:SetEventFlag( 1080 , 1 );
	
	print("OnEvent_1080_anime_end end");
end


--------------------------------------------------------------------------------------
--��1082�������܂�|�����Đ���
--------------------------------------------------------------------------------------

--��1082�������܂�|�����Đ���
function OnEvent_1082(proxy,param)	
	print("OnEvent_1082 begin");
	
	--�����܂�|�����Đ�
	proxy:RequestRemo(20202,REMO_FLAG,1082,1);
	proxy:SetEventFlag( 1082 , 1 );--�t���OON	
	
	print("OnEvent_1082 end");
end

--�|�����J�n�i�t�F�[�h����) 
function OnEvent_1082_RemoStart(proxy,param)
	print("OnEvent_1082_RemoStart begin");

	--�����͕\��OFF
	proxy:SetDrawEnable( 452 , false );
	
	--(���炭)�ׂ���镺�m���\��OFF
	--proxy:SetDrawEnable( 405 , false );
	InvalidCharactor( proxy, 405 );
	
	--���̕��m�͖�����
	InvalidCharactor( proxy , 406 );
	InvalidCharactor( proxy , 407 );
	InvalidCharactor( proxy , 408 );

	print("OnEvent_1082_RemoStart end");
end

--�|�����I��
function OnEvent_1082_RemoFinish(proxy,param)
	print("OnEvent_1082_RemoFinish begin");
	
	proxy:EndAnimation( 1440 , 2 );--�����܂�A�j���[�V�������I��点��
	
	--�|�������Đ������̂ō������[�v
	proxy:Warp( 452 , 2512 );--���̃|�C���g�փ��[�v
	proxy:SetDrawEnable( 452 , true );--�|�������A�\��OFF�ɂ��Ă����̂Ŗ߂�
	proxy:ChangeInitPosAng( 452 , 2512 );--�������[�v��̗̈�ɍX�V
	proxy:SetDeadMode( 452 , false );--�������S���G����
	LuaFunc_NormalOmission(proxy,452);
	--���m405�����ɒׂ����
	--proxy:Warp( 405 , 2506 );--���̉��Ƀ��[�v
	--proxy:EnableLogic( 405 , false );--�v�lOFF
	--proxy:SetColiEnable( 405 , false );--������OFF
	--proxy:SetDrawEnable( 405 , true );--�|�������A�\��OFF�ɂ��Ă����̂Ŗ߂�
	--proxy:PlayLoopAnimation( 405 , 7020 );--�|�ꂽ�܂�
	--proxy:EnableHide( 405 , true );--�T������Ȃ�
	--proxy:DisableMapHit( 405, true );--�}�b�v�����薳��(���̓�����ňʒu�������?�̂�?)
	--proxy:SetDisableGravity( 405 , true );--�d�͖���
	--proxy:ForceUpdateNextFrame(405);--���̃t���[���͋����X�V(�ׂ���镺�m)
	InvalidCharactor( proxy, 405 );		
	--��V�X�e���L����
	proxy:EnableObjTreasure( 11502 , true );
	proxy:SetDrawEnable( 11502,true);
	
	proxy:SetDrawEnable( 1520 , true );--���_�}���\��

	--�הn�Ԃ̃C�x���g�폜(�I����ĂȂ��Ă��폜�j
	proxy:DeleteEvent( 1080 );
	--���������ɍ���Ă�������܂�|�����C�x���g�̗̈�Ď��폜
	proxy:DeleteEvent( 1082 );
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(1079,"OnEvent_1079_Wait",0.2,0,0,once);
	proxy:NotNetMessage_end();
	print("OnEvent_1082_RemoFinish end");
end

function OnEvent_1079_Wait(proxy,param)
	print("OnEvent_1079_Wait begin");
	proxy:EnableLogic( 452 , true );
	proxy:ClearTarget( 452 );
	proxy:ResetThink( 452 );
	
	--�����̍��}���I����Ă��āA�הn�ԃA�j�����I����ĂȂ��Ȃ�
	if proxy:IsCompleteEvent( 1079 ) == true then
		if proxy:IsCompleteEvent( 1080 ) == false then
			OnEvent_1080_anime_end(proxy,param);
		end
	end
	print("OnEvent_1079_Wait end");
end

--[[
--------------------------------------------------------------------------------------
--��1065������A�̑���ς���(���̉��̂ق��֑��点��)��
--------------------------------------------------------------------------------------
--��1065������A�̑���ς���(���̉��̂ق��֑��点��)��
function OnEvent_1065(proxy,param)	
	print("OnEvent_1065 begin");

	proxy:EnableLogic( 452 , true );--[[�ǉ�]]
	proxy:ChangeInitPosAng( 452 , 2513 );--������̉��̗̈�ɍX�V(���肾���͂����)	
	proxy:ForceUpdateNextFrame( 452 );--���̃t���[���͋����X�V
	
	proxy:SetEventFlag( 1065 , 1 );

	print("OnEvent_1065 end");
end
]]



--------------------------------------------------------------------------------------
--��1115���`�F�b�N�|�C���g1(�����J����C�x���g�̂��߂̂���)��
--------------------------------------------------------------------------------------

--��1115���`�F�b�N�|�C���g1(�����J����C�x���g�̂��߂̂���)��
function OnEvent_1115(proxy,param)	
	print("OnEvent_1115 begin");

	proxy:SetEventFlag( 1115 , 1 );
	
	print("OnEvent_1115 end");
end



--------------------------------------------------------------------------------------
--��1085���ׂ��H�n�̔����}�ɊJ����
--------------------------------------------------------------------------------------

--���`�F�b�N�|�C���g�ʉ߂������̃`�F�b�N
function OnEvent_1085_check_1(proxy, param)
	
	--�����J���C�x���g���I����Ă�����A�`�F�b�N�p�̃C�x���g���폜���ďI��
	if proxy:IsCompleteEvent( 1085 ) == true then
		proxy:DeleteEvent( 1085 );
		return;
	end
	
	--�`�F�b�N�|�C���g��ʉ߂��Ă�����A
	if proxy:IsCompleteEvent( 1115 ) == true then
		--���ׂ��H�n�̔����}�ɊJ���̃C�x���g�𔭓���
		OnEvent_1085(proxy, param);
	end
end


--���|�����Đ��ς݂��̃`�F�b�N
function OnEvent_1085_check_2(proxy, param)
	
	--�����J���C�x���g���I����Ă�����A�`�F�b�N�p�̃C�x���g���폜���ďI��
	if proxy:IsCompleteEvent( 1085 ) == true then
		proxy:DeleteEvent( 1085 );
		return;
	end
	
	--�����܂�|�����̍Đ����I����Ă�����A
	if proxy:IsCompleteEvent( 1082 ) == true then
		--���ׂ��H�n�̔����}�ɊJ���̃C�x���g�𔭓���
		OnEvent_1085(proxy, param);
	end
end


--��1085���ׂ��H�n�̔����}�ɊJ����
function OnEvent_1085(proxy,param)	
	print("OnEvent_1085 begin");
	
	--���̃C�x���g�I����Ă�����A�������Ȃ�
	if proxy:IsCompleteEvent( 1085 ) == true then
		print( "OnEvent_1085 end" );
		return;
	end
	
	proxy:PlayAnimation( 400 , 3002 );--���mA���U��
	proxy:PlayAnimation( 1499 , 1 );--�����J���A�j���Đ�
	
	--������_���[�W��
	proxy:OnObjectDamageHit_NoCall( 1085, 1499, 1, 10070, EV_HIT_HIT , 1.0, 10.0, once );
			
	proxy:SetEventFlag( 1085 , 1 );

	print("OnEvent_1085 end");
end



--------------------------------------------------------------------------------------
--��1086���ׂ��H�n����G����яo���Ă��遡
--------------------------------------------------------------------------------------

--�����������𖞂����Ă��邩�`�F�b�N
function Check_OnEvent_1086(proxy, param)

	--�u�ׂ��H�n�̔����}�ɊJ���v�̃C�x���g���I�����Ă���ꍇ�C�x���g����
	return ( proxy:IsCompleteEvent( 1085 ) );
end


--��1086���ׂ��H�n����G����яo���Ă��遡
function OnEvent_1086(proxy, param)
	print("OnEvent_1086 begin");
	
	--�����X�VON
	LuaFunc_ForceOmission(proxy,400);
	LuaFunc_ForceOmission(proxy,401);
	LuaFunc_ForceOmission(proxy,402);	
	
	--���m�������W�b�NON
	proxy:EnableLogic( 400 , true );
	proxy:EnableLogic( 401 , true );
	proxy:EnableLogic( 402 , true );

	--�����m�����ړ��J�n��
	OnEvent_1086_move_start(proxy, param);
	
	proxy:SetEventFlag( 1086 , 1 );

	print("OnEvent_1086 end");
end

--�����m�����ړ��J�n��
function OnEvent_1086_move_start(proxy, param)
	print("OnEvent_1086_move_start begin");

	proxy:SetEventFlag( 1086 , 0 );
	
	proxy:ResetThink( 400 );
	--AI�̃p�X�ړ��ňړ�(���W�b�N��ON�ł���K�v������)
	MoveRegion( proxy , 400 , 2486 , -1 , 0.0 , false );--���mA
	--����ڂ̗̈�Ɉړ��I��(ID:400)��
	proxy:OnRegionIn( 1086 , 400 , 2486 , "OnEvent_1086_400_move1_end" , once );
	
	proxy:ResetThink( 401 );
	--AI�̃p�X�ړ��ňړ�(���W�b�N��ON�ł���K�v������)
	MoveRegion( proxy , 401 , 2486 , -1 , 0.0 , false );--���mB 
	--����ڂ̗̈�Ɉړ��I��(ID:401)��
	proxy:OnRegionIn( 1086 , 401 , 2486 , "OnEvent_1086_401_move1_end" , once );	
	
	proxy:ResetThink( 402 );
	--AI�̃p�X�ړ��ňړ�(���W�b�N��ON�ł���K�v������)
	MoveRegion( proxy , 402 , 2486 , -1 , 0.0 , false );--���mC
	--����ڂ̗̈�Ɉړ��I��(ID:402)��
	proxy:OnRegionIn( 1086 , 402 , 2486 , "OnEvent_1086_402_move1_end" , once );	
	
	proxy:SetEventFlag( 1086 , 1 );
	
	print("OnEvent_1086_move_start end");
end


-- ���mA ---------------------------------------------

--����ڂ̗̈�Ɉړ��I��(ID:400)��
function OnEvent_1086_400_move1_end(proxy, param)
	print("OnEvent_1086_400_move1_end begin");

	proxy:SetEventFlag( 1086 , 0 );
	
	proxy:ResetThink( 400 );
	--AI�̃p�X�ړ��ňړ�(���W�b�N��ON�ł���K�v������)
	MoveRegion( proxy , 400 , 2485 , -1 , 0.0 , false );--���mA
	--����ڂ̗̈�Ɉړ��I��(ID:400)��
	proxy:OnRegionIn( 1086 , 400 , 2485 , "OnEvent_1086_400_move2_end" , once );
	
	proxy:SetEventFlag( 1086 , 1 );
	
	print("OnEvent_1086_400_move1_end end");
end

--����ڂ̗̈�Ɉړ��I��(ID:400)��
function OnEvent_1086_400_move2_end(proxy, param)
	print("OnEvent_1086_400_move2_end begin");

	proxy:SetEventFlag( 1086 , 0 );
	
	proxy:ResetThink( 400 );
	--AI�̃p�X�ړ��ňړ�(���W�b�N��ON�ł���K�v������)
	MoveRegion( proxy , 400 , 2484 , -1 , 0.0 , false );--���mA
	--���O�ڂ̗̈�Ɉړ��I��(ID:400)��
	proxy:OnRegionIn( 1086 , 400 , 2484 , "OnEvent_1086_400_move3_end" , once );
	
	proxy:SetEventFlag( 1086 , 1 );
	
	print("OnEvent_1086_400_move2_end end");
end

--���O�ڂ̗̈�Ɉړ��I��(ID:400)��
function OnEvent_1086_400_move3_end(proxy, param)
	print("OnEvent_1086_400_move3_end begin");

	proxy:ResetThink( 400 );
	proxy:EnableLogic( 400 , true );
	
	print("OnEvent_1086_400_move3_end end");
end


-- ���mB ---------------------------------------------

--����ڂ̗̈�Ɉړ��I��(ID:401)��
function OnEvent_1086_401_move1_end(proxy, param)
	print("OnEvent_1086_401_move1_end begin");

	proxy:SetEventFlag( 1086 , 0 );
	
	proxy:ResetThink( 401 );
	--AI�̃p�X�ړ��ňړ�(���W�b�N��ON�ł���K�v������)
	MoveRegion( proxy , 401 , 2485 , -1 , 0.0 , false );--���mB
	--����ڂ̗̈�Ɉړ��I��(ID:401)��
	proxy:OnRegionIn( 1086 , 401 , 2485 , "OnEvent_1086_401_move2_end" , once );
	
	proxy:SetEventFlag( 1086 , 1 );
	
	print("OnEvent_1086_401_move1_end end");
end

--����ڂ̗̈�Ɉړ��I��(ID:401)��
function OnEvent_1086_401_move2_end(proxy, param)
	print("OnEvent_1086_401_move2_end begin");

	proxy:ResetThink( 401 );
	proxy:EnableLogic( 401 , true );
	
	print("OnEvent_1086_401_move2_end end");
end


-- ���mC ---------------------------------------------

--����ڂ̗̈�Ɉړ��I��(ID:402)��
function OnEvent_1086_402_move1_end(proxy, param)
	print("OnEvent_1086_402_move1_end begin");

	proxy:ResetThink( 402 );
	proxy:EnableLogic( 402 , true );
	
	print("OnEvent_1086_402_move1_end end");
end



--------------------------------------------------------------------------------------
--��1088�������̎w���ŋ|�����|�������Ă��遡
--------------------------------------------------------------------------------------

--��1088�������̎w���ŋ|�����|�������Ă��遡(2�C��)
function OnEvent_1088(proxy,param)	
	print("OnEvent_1088 begin");

	if proxy:IsCompleteEvent( 1088 ) == true then--���d�����h�~
		print("OnEvent_1088 end");
		return;
	end
	
	--�����X�VON
	LuaFunc_ForceOmission(proxy,451);
	
	proxy:PlayAnimation( 451 , 7000 );--�����̍��}
	
	proxy:NotNetMessage_begin();
		--��1088_1�������̍��}�I����
		proxy:OnChrAnimEnd( 1088 , 451 , 7000 , "OnEvent_1088_1" , once );
	proxy:NotNetMessage_end();
	
	--�|�����W�b�NON
	local first_id = 410;
	local now_id   = first_id;
	local id_num   = 5;
	
	for i=1, id_num, 1 do
		proxy:EnableLogic( now_id , true );
		now_id = now_id + 1;
	end
	
	proxy:SetEventFlag( 1088 , 1 );
	
	print("OnEvent_1088 end");
end


--��1088_1�������̍��}�I����
function OnEvent_1088_1(proxy,param)	
	print("OnEvent_1088_1 begin");

	proxy:EnableLogic( 451 , true );--���W�b�NON
	
	LuaFunc_NormalOmission(proxy,451);--�����X�VOFF
	proxy:DeleteEvent( 1088 );--�_���[�W�Ď�������

	print("OnEvent_1088_1 end");
end


--------------------------------------------------------------------------------------
--��1270�������̎w���ŋ|�����|�������Ă���2��
--------------------------------------------------------------------------------------

--��1270�������̎w���ŋ|�����|�������Ă���2��
function OnEvent_1270(proxy,param)	
	print("OnEvent_1270 begin");

	if proxy:IsCompleteEvent( 1270 ) == true then--���d�����h�~
		print("OnEvent_1270 end");	
		return;
	end
	
	--�����X�VON
	--LuaFunc_ForceOmission(proxy,453);
	
	--proxy:PlayAnimation( 453 , 7000 );--�����̍��}
	--proxy:EnableLogic( 453 , true );--AI�̗̈�ړ��ŁA�ړ������邽�߃��W�b�N��ON�ɂ��Ă���	
	
	proxy:NotNetMessage_begin();
		--��1270_1�������̍��}�I����
		--proxy:OnChrAnimEnd( 1270 , 453 , 7000 , "OnEvent_1270_1" , once );
		proxy:OnKeyTime2(1270,"OnEvent_1270_1",0.0,0,100,once);
	proxy:NotNetMessage_end();
	
	--�|�����W�b�NON
	local first_id = 480;
	local now_id   = first_id;
	local id_num   = 3;
	
	for i=1, id_num, 1 do
		proxy:EnableLogic( now_id , true );
		now_id = now_id + 1;
	end
	
	proxy:SetEventFlag( 1270 , 1 );
	
	print("OnEvent_1270 end");
end


--��1270_1�������̍��}�I����
function OnEvent_1270_1(proxy,param)	
	print("OnEvent_1270_1 begin");
	
	--����(453)������
	
	--proxy:ResetThink( 453 );
	--AI�̃p�X�ړ��ňړ�(���W�b�N��ON�ł���K�v������)
	--MoveRegion( proxy , 453 , 2445 , -1 , 0.0 , false );--����

	--LuaFunc_NormalOmission(proxy,453);--�����X�VOFF
	proxy:DeleteEvent( 1270 );--�_���[�W�Ď�������

	proxy:NotNetMessage_begin();
		--��������������|�����Đ���
		proxy:OnKeyTime2( 1271 , "OnEvent_1271" , 0.0 , 0 , 1 , once );
	proxy:NotNetMessage_end();
		
	print("OnEvent_1270_1 end");
end


--��1271��������������|�����Đ���
function OnEvent_1271(proxy,param)	
	print("OnEvent_1271 begin");

	--������������|�����Đ�
	proxy:RequestRemo(20204,REMO_FLAG,1271,1);
	proxy:SetEventFlag( 1271 , 1 );

	print("OnEvent_1271 end");
end


--�|�����J�n�t�F�[�h������ɌĂ΂��n���h��
function OnEvent_1271_RemoStart(proxy,param)
	print("OnEvent_1271_RemoStart begin");
	proxy:SetDrawEnable( 453 , false );--�\��OFF
	print("OnEvent_1271_RemoStart end");
end


--�|�����I����ɌĂ΂��n���h��
function OnEvent_1271_RemoFinish(proxy , param)
	print("OnEvent_1271_RemoFinish begin");

	proxy:SetDrawEnable( 453 , true );--�\��ON
	
	--453�̍������[�v �{�X�����̒��őҋ@���Ă���
	proxy:Warp( 453 , 2507 );
	proxy:EnableLogic( 453 , false );
		
	print("OnEvent_1271_RemoFinish end");
end



--------------------------------------------------------------------------------------
--��1280������1�̎��S�`�F�b�N��
--------------------------------------------------------------------------------------

--��1280������1�̎��S�`�F�b�N��
function OnEvent_1280(proxy,param)	
	print("OnEvent_1280 begin");
	
	proxy:SetEventFlag( 1280 , 1 );
	
	print("OnEvent_1280 end");
end

--��15621������1�̎��̂𒲂ׂ����H��
function OnEvent_15621(proxy,param)
	print("OnEvent_15621 begin");
	proxy:SetEventFlag( 15621 ,true );
	print("OnEvent_15621 end");
end

--------------------------------------------------------------------------------------
--��1281������2�̎��S�`�F�b�N��
--------------------------------------------------------------------------------------

--��1281������2�̎��S�`�F�b�N��
function OnEvent_1281(proxy,param)	
	print("OnEvent_1281 begin");
	
	proxy:SetEventFlag( 1281 , 1 );
	
	print("OnEvent_1281 end");
end

--��15620�������Q�̎��̂𒲂ׂ���
function OnEvent_15620(proxy,param)
	print("OnEvent_15620 begin");
	proxy:SetEventFlag( 15620 , true );
	print("OnEvent_15620 edn");
end

--------------------------------------------------------------------------------------
--��1282������3�̎��S�`�F�b�N��
--------------------------------------------------------------------------------------

--��1282������3�̎��S�`�F�b�N��
function OnEvent_1282(proxy,param)	
	print("OnEvent_1282 begin");
	
	proxy:SetEventFlag( 1282 , 1 );
	
	print("OnEvent_1282 end");
end




--------------------------------------------------------------------------------------
--��1200���T�u�C�x���g����
--------------------------------------------------------------------------------------
--��1200_1���T�u�C�x���g����LuaCall��`
function OnEvent_1200_1(proxy, param)
	print("OnEvent_1200_1 begin");

	proxy:PlayAnimation( 1460, 1 );--�����J���A�j���[�V����
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 1200, 1 );
		proxy:DeleteEvent( 1200 );
		print("OnEvent_1200_1 end");
		return;
	end

	proxy:WarpDmy( 10000 , 1460 , 191 );
	proxy:SetEventFlag( 1200, 1 );

	print("OnEvent_1200_1 end");
end


--��1200���T�u�C�x���g����
function OnEvent_1200(proxy, param)
	print("OnEvent_1200 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 1200 ) == true then
		print("OnEvent_1200 end");
		return;
	end	
	
	--�K�v�A�C�e���̎w��
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 36;--���̕t�����S�̌�
	
	--�K�v�A�C�e�����������Ă���(�C���x���g���[�ɃA�C�e���Ƃ��ď������Ă���)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--��1200_3���I�����j���[�̊Ď���
			--proxy:OnSelectMenu(1200, "OnEvent_1200_3", 10010830, 0, 2, 1460, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010830, 0, 6, 1460, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_1200_3(proxy,param);

	--�K�v�A�C�e�����������Ă��Ȃ�
	else
		--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\��
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1460, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_1200 end");
end


--��1200_3���I�����j���[�̊Ď���(YES��I�������Ƃ�)
function OnEvent_1200_3(proxy,param)
	print("OnEvent_1200_3 begin");
	proxy:LuaCallStart( 1200 , 1 );--�A�j���[�V�����̓����Đ�(�S�̂ɔz�M)
	proxy:DeleteEvent( 1200 );
	print("OnEvent_1200_3 end");
end



--------------------------------------------------------------------------------------
--��1201���T�u�C�x���g����
--------------------------------------------------------------------------------------
--��1201_1���T�u�C�x���g����LuaCall��`
function OnEvent_1201_1(proxy, param)
	print("OnEvent_1201_1 begin");

	proxy:PlayAnimation( 1461, 1 );--�����J���A�j���[�V����
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 1201, 1 );
		proxy:DeleteEvent( 1201 );
		print("OnEvent_1201_1 end");
		return;
	end

	proxy:WarpDmy( 10000 , 1461 , 191 );
	proxy:SetEventFlag( 1201, 1 );

	print("OnEvent_1201_1 end");
end


--��1201���T�u�C�x���g����
function OnEvent_1201(proxy, param)
	print("OnEvent_1201 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 1201 ) == true then
		print("OnEvent_1201 end");
		return;
	end	
	
	--�K�v�A�C�e���̎w��
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 36;--���̕t�����S�̌�
	
	--�K�v�A�C�e�����������Ă���(�C���x���g���[�ɃA�C�e���Ƃ��ď������Ă���)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--��1201_3���I�����j���[�̊Ď���
			--proxy:OnSelectMenu(1201, "OnEvent_1201_3", 10010830, 0, 2, 1461, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010830, 0, 6, 1461, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_1201_3(proxy,param);

	--�K�v�A�C�e�����������Ă��Ȃ�
	else
		--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\��
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1461, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_1201 end");
end


--��1201_3���I�����j���[�̊Ď���(YES��I�������Ƃ�)
function OnEvent_1201_3(proxy,param)
	print("OnEvent_1201_3 begin");
	proxy:LuaCallStart( 1201 , 1 );--�A�j���[�V�����̓����Đ�(�S�̂ɔz�M)
	proxy:DeleteEvent( 1201 );
	print("OnEvent_1201_3 end");
end


--------------------------------------------------------------------------------------
--��4360�����{�X���S�Ŕ����J����
--------------------------------------------------------------------------------------
--��4360�����{�X���S�Ŕ����J����
function OnEvent_4360(proxy, param)
	print("OnEvent_4360 begin");
		
	proxy:NotNetMessage_begin();
		--��4370���N���C�A���gPC���[�v���o��
		proxy:OnKeyTime2( 4370, "OnEvent_4370", 0, 0, 0, once);
		--��4360_1��1�b�o�߁�
		proxy:OnKeyTime2( 4360, "OnEvent_4360_1", 1, 0, 1, once);
		--��4371��2�b�o�߁�
		proxy:OnKeyTime2( 4371, "OnEvent_4371", 2, 0, 2, once);
		
		--�}���`���U�Ď�
		proxy:OnRegistFunc( 4360 , "Check_4360_PT","OnEvent_4360_PT",0,once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 4360, 1 );
	
	if proxy:IsCompleteEvent( BIYO_STATE_SEARCH_3 ) == true then
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_KING_OF_SWORD_KILL );
		proxy:SetEventFlag( 1431, true );
	end
	
	--�����h�����q�̏�Ԃ��u�G���x�[�^�[�O�ő҂v��
	if proxy:IsClient() == false then--�����v���C���[(�O���C)�̂ݔ���
		if proxy:IsCompleteEvent( RENDOL_STATE_SEARCH_3 ) == true then--���q�̏�Ԃ��u����R�T���v�Ȃ��
			proxy:NotNetMessage_begin();
				if	proxy:IsDistance( LOCAL_PLAYER , 621 , 20 ) == true then
					proxy:OnPlayerDistanceOut( 1315, LOCAL_PLAYER, 621, "OnEvent_1315", 20, once );
				else
					proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "OnEvent_1315", 0.0, 0, 2, once );
				end
			proxy:NotNetMessage_end();
		end
	end	
	
	proxy:SetColiEnableArray(3007,true);--�ʏ�L��
	proxy:SetColiEnableArray(3008,true);--�ʏ�L��
	proxy:SetColiEnableArray(3009,false);--�{�X�p����
	proxy:SetColiEnableArray(3011,false);--�{�X�p����
	
	--�u���b�N�N���A������
	proxy:CustomLuaCallStart( 4050, 802 );	
	--�����g�J�Q�C�x���g���Z�b�g
	ResetTokage(proxy);
		
	--��������
	if proxy:IsDistance( 10000 , 621 , 20 ) == true then
		return false;
	else
		print("�����h�����q�A���u���b�N�ֈړ�");
		return true;
	end	

	print("OnEvent_4360 end");
end

--��4360_1�����{�X���S��1�b��
function OnEvent_4360_1(proxy, param)
	print("OnEvent_4360_1 begin");
	
	--�{�X��|���������X�V(���ɂ���ăt���O�𗧂Ă�)
	GetBossFlagCount( proxy, param );
	
	--���g���t�B�[�擾���聥
	Lua_RequestUnlockTrophy(proxy, 29);
	
	--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
	if proxy:IsCompleteEvent( 4372 ) == false then
	
		--�\�E���L����
		proxy:SetDrawEnable( 1980 , true );
		proxy:SetColiEnable( 1980 , true );
		--�\�E��2�L����
		proxy:SetDrawEnable( 1977 , true );
		proxy:SetColiEnable( 1977 , true );
		
		proxy:ValidSfx( 1420 );--SFX �L����
		proxy:ValidSfx( 1421 );--SFX �L����
		proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--���点��
		proxy:OnDistanceActionAttribute( 4372 , 10000 , 1980 , "OnEvent_4372" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );
	else
		--�\�E��������(������������̂ť��)
		proxy:SetDrawEnable( 1980 , false );
		proxy:SetColiEnable( 1980 , false );
	end

	print("OnEvent_4360_1 end");
end


--------------------------------------------------------------------------------------
--��4370���N���C�A���gPC���[�v���o��
--------------------------------------------------------------------------------------

--��4370���N���C�A���gPC���[�v���o��
function OnEvent_4370(proxy, param)
	print("OnEvent_4370 begin");

	if proxy:IsClient() == true then
		proxy:PlayAnimation( 10000 , 8284 );--���[�v�A�j�����Đ�
	end

	proxy:SetEventFlag( 4370 , 1 );
	
	print("OnEvent_4370 end");
end


--------------------------------------------------------------------------------------
--��4371���V���O���F���̕ǁABGM������
--------------------------------------------------------------------------------------

--��4371���V���O���F���̕ǁABGM������
function OnEvent_4371(proxy, param)
	print("OnEvent_4371 begin");
	
	--�{�X��p��BGM��~
	proxy:StopPointSE( 2 );

	proxy:SetEventFlag( 4371 , 1 );
	
	print("OnEvent_4371 end");
end

--�}���`���U�Ď�
function Check_4360_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--�}���`����Ȃ�
function OnEvent_4360_PT(proxy,param)
	print("OnEvent_4360_PT beign");
	--���{�X�����̑O��̖��@�ǂ�������(�S�v���C���[)
	proxy:SetColiEnable( 1997 , false );
	proxy:SetColiEnable( 1993 , false );
	--proxy:SetObjDeactivate( 1997 , true );--�f�A�N�e�B�u
	--proxy:SetObjDeactivate( 1993 , true );--�f�A�N�e�B�u
	
	proxy:SetDrawEnable( 1997 , false );
	proxy:SetDrawEnable( 1993 , false );	
	
	--���{�X�������@�ǂ�SFX�폜
	proxy:InvalidSfx( 1985 , true );
	proxy:InvalidSfx( 1989 , true );

	--���{�X�����O�̈ړ������C�x���g���폜
	proxy:DeleteEvent( 1034 );--��l�ڂ�����Ƃ��p
	proxy:DeleteEvent( 1035 );--��l�ڈȍ~������Ƃ��p
	proxy:DeleteEvent( 1036 );--�|�����Đ��p
	proxy:DeleteEvent( 1037 );--�{�X�퓬�J�n�p	
	print("OnEvent_4360_PT end");
end


--------------------------------------------------------------------------------------
--��4372���\�E�����聡
--------------------------------------------------------------------------------------

function OnEvent_4372(proxy, param)
	print("OnEvent_4372 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--�V�����A�j�� 
		print("OnEvent_4372 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 4372, "OnEvent_4372_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4372 end");
end


--��4372_1���A�C�e���擾��
function OnEvent_4372_1(proxy, param)
	print("OnEvent_4372_1 begin");

	--�A�C�e���擾�֐�
	proxy:GetRateItem(10112);--�p�����[�^10112�Q��
	proxy:GetRateItem(10178);--�p�����[�^10178�Q��
	proxy:GetRateItem(10179);--�p�����[�^10179�Q��
	proxy:GetRateItem(10180);--�p�����[�^10180�Q��
	proxy:GetRateItem(10181);--�p�����[�^10181�Q��
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 4372, 1 );
	
	--�󔠃V�F�[�_�[�͏����܂���
	--proxy:TreasureDispModeChange( 1980 , false );

	--SFX��������
	proxy:InvalidSfx( 1420, true );--�v�΃I�[��
	--proxy:InvalidSfx( 1421, true );--���̗��q
		
	--���v�΂Ń��[�v�p�̊Ď���ǉ���
	proxy:OnDistanceActionAttribute( 4374 , 10000 , 1980 , "OnEvent_4374" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_4372_1 end");
end

--------------------------------------------------------------------------------------
--�Β��Ƀ��[�v(�{�X�|������p)��4374
--------------------------------------------------------------------------------------
--��4374���Β��Ƀ��[�v��
function OnEvent_4374(proxy,param)	

	if proxy:IsCompleteEvent( 4374 ) == true then
		return;
	end	

	print("OnEvent_4374 begin");
	
	proxy:RepeatMessage_begin();
		--��4374_1���I�����j���[�̊Ď���
		proxy:OnSelectMenu(4374, "OnEvent_4374_0", 10010710, 0, 2, 1980, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_4374 end");
end

--��4374_0���I�����j���[�̊Ď���
function OnEvent_4374_0(proxy, param)
	print("OnEvent_4374_0 begin");	
	
	if proxy:IsSession() == false then
		proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ�
		proxy:NoAnimeTurnCharactor( 10000 , 1980 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--���v�΂ɐG���A�j���Đ��I����
			proxy:OnChrAnimEnd( 4374 , 10000 , 8283 , "OnEvent_4374_1" , once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 4374 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_4374_0 end");
end

--��4374_1�������E�ɋA��A�j���Đ��I����
function OnEvent_4374_1(proxy,param)	
	print("OnEvent_4374_1 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ�
	--�Β��֖߂��Ă�������̃t���O�𗧂Ă�
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag( 4374 , 0 );	
	--���S�񕜗v��
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1006 );
	
	print("OnEvent_4374_1 end");
end


--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m02_02_00_00(proxy, param)
	print("PlayerDeath_m02_02_00_00");
	print("PlayerDeath_m02_02_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m02_02_00_00(proxy,param)
	print("PlayerRevive_m02_02_00_00");	
	print("PlayerRevive_m02_02_00_00");
end


--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ��遡1034
--------------------------------------------------------------------------------------

--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫

--��1034�����{�X�����ւ̔����J����
function OnEvent_1034(proxy,param)
	print("OnEvent_1034 begin");

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_1034 end");
		return;
	end
	
	--�N���C�A���g�ցA�{�X�����j�~���s��ʒm
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 1035 , 1 );--����A�j���̓����Đ�
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--���d�N���V�X�e��ID���^�C���A�E�g��ݒ肵��ON�ɂ���
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1034 end");
end


--����A�j���̓����Đ�(ID����)
function OnEvent_1035_1(proxy,param)
	print("OnEvent_1035_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ����s���A���̏I������OnEvent_1035_2�𔭍s����
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2889 );
		else
			proxy:LockSession();--���[�������b�N���܂��I
			--����A�j���Đ����s���A���̏I������OnEvent_1035_2�𔭍s����
			proxy:OnTurnCharactorEnd( 1035, 10000, 2889, "OnEvent_1035_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1035_1 end");
end

--����A�j���̓����Đ��I����
function OnEvent_1035_2(proxy,param)
	print("OnEvent_1035_2 begin");
	
	--�����p�����A�j���Đ�
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1035, 10000, ANIMEID_WALK, "OnEvent_1035_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1035_2 end");
end

--�����A�j���̓����Đ��I����
function OnEvent_1035_3(proxy,param)
	print("OnEvent_1035_3 begin");

	--�ŏ��̐l���{�X�����̒��ɓ���I����Ă�����A���ɔz�M����Ă���͂��Ȃ̂ŁA����������Ȃ��n���h��
	if proxy:IsCompleteEvent( 1034 ) == false then
		proxy:LuaCallStart( 1035 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCallStart( 4045 , 1 );	--�N���C�A���g�ցA�{�X�����ɓ����悤�ɂȂ������Ƃ�ʒm
		proxy:LuaCallStart( 1035 , 6 );--�t���O�Z�b�g(�����p)
		Lua_MultiDoping(proxy,802);--�}���`�v���C�h�[�s���O
	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�)
	if proxy:IsClient() == false	then
		proxy:ResetThink( 802 );
	end
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );
	
	print("OnEvent_1035_3 end");
end


--��1034 2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
function OnEvent_1034_GO_TO_IN(proxy, param)
	print("OnEvent_1034_GO_TO_IN begin");

	proxy:NotNetMessage_begin();
		--��1035�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���--�n���h���� OnEvent_1034
		proxy:OnPlayerActionInRegion( 1035, 2893, "OnEvent_1034", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	
	print("OnEvent_1034_GO_TO_IN end");
end


--��1034 �t���O�Z�b�g(�����p)
function OnEvent_1034_flag_set(proxy, param)
	print("OnEvent_1034_flag_set begin");
		
	proxy:SetEventFlag( 1034 , 1 );
	proxy:DeleteEvent( 1034 );

	print("OnEvent_1034_flag_set end");
end


--------------------------------------------------------------------------------------
--���{�X�|�����Đ���1036
--------------------------------------------------------------------------------------

function OnEvent_1036(proxy, param)
	print("OnEvent_1036 begin");

	--�|�����Đ��J�n
	proxy:RequestRemo(20201,REMO_FLAG,1036,1);
	proxy:SetEventFlag( 1036 , 1 );--�|�����Đ��I��
	
	print("OnEvent_1036 end");
end


--��1036_RemoStart���|�����J�n �t�F�[�h�A�E�g������
function OnEvent_1036_RemoStart(proxy,param)
	print( "OnEvent_1036_RemoStart begin" );
	
	print("�|�����Đ��J�n");
	proxy:SetDrawEnable( 802 , false );--���̌� �\��OFF
	proxy:SetDrawEnable( 453 , false );--����(453)�����ɂ���悤�ɂȂ����̂ŏ���
	
	print( "OnEvent_1036_RemoStart end" );
end


--��1036_RemoFinish���|�����Đ��I���ち
function OnEvent_1036_RemoFinish(proxy , param)
	print( "OnEvent_1036_RemoFinish begin" );

	print("�|�����I��");
	proxy:SetDrawEnable( 802 , true );--���̌� �\��ON

	--����(453)�����{�X�����̒��Ŏ���ł���	
	proxy:StopLoopAnimation( 453 );
	proxy:PlayLoopAnimation( 453 , 2210 );--���S�ҋ@
	proxy:SetColiEnable( 453 , false );--������OFF
	proxy:SetDrawEnable( 453 , true );--�`��ON
	proxy:EnableLogic( 453 , false );
	proxy:Warp( 453 , 2505 );--����ł���ʒu�̗̈�
	proxy:EnableHide( 453 , true );--�T������Ȃ�
	proxy:EnableInvincible( 453 , true );--���S���G(�����΍�)
	
	print( "OnEvent_1036_RemoFinish end" );
end


--------------------------------------------------------------------------------------
--�{�X�������o��(�퓬�J�n)��1037
--------------------------------------------------------------------------------------

function OnEvent_1037(proxy, param)
	print("OnEvent_1037 begin");
	
	--�{�X��pBGM�Đ��J�n
	proxy:PlayPointSE( 2520, SOUND_TYPE_M, 20200000, 2 );
	
	--�{�X���W�b�NON
	proxy:EnableLogic( 802 , true );	
	if proxy:IsCompleteEvent( BIYO_STATE_SEARCH_3 ) == true then
		ValidCharactor( proxy, 627 );
		proxy:EnableLogic( 627,true );
		--[[
		proxy:TurnCharactor( 627, 2580 );
		if proxy:IsClient() == false then
			proxy:OnChrAnimEnd( 1430, 627, -1, "OnEvent_1430", once );
		end
		]]
	end
	
	--�{�X�Q�[�W�\��
	proxy:SetBossGauge( 802 , 0 ,5020 );
	
	print("OnEvent_1037 end");
end


--------------------------------------------------------------------------------------
--�n�V�S1�~�聡1210
--------------------------------------------------------------------------------------
--��1210���n�V�S1�~��X�^�[�g��
function OnEvent_1210(proxy, param)
	print("OnEvent_1210 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1210 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,2,2);				--�z�o�[�ړ����[�h�Ɉڍs
	--proxy:HoverMoveVal(10000,2002,LadderTime_A);--�ړ��ʒu(2002)��0.5�b�Ńz�o�[�ړ�
	proxy:HoverMoveValDmy(10000,1540,192,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,1);				--�C�x���g�R�}���hID(1)"�n�V�S�ォ���"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(1210,"OnEvent_1210_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���)
		proxy:OnKeyTime2(1210,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_1210 end");
end

--��1210_1���n�V�SA�~��X�^�[�g:�z�o�[�ړ��I����
function OnEvent_1210_1(proxy, param)
	print("OnEvent_1210_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1210_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,3,2);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1210_1 end");
end


--------------------------------------------------------------------------------------
--�n�V�S1���聡1211
--------------------------------------------------------------------------------------
--��1211���n�V�S1����X�^�[�g��
function OnEvent_1211(proxy, param)
	print("OnEvent_1211 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1211 end");
		return;
	end
	
	--�͂�������ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,-1,1);			--�z�o�[�ړ����[�h�Ɉڍs
	--proxy:HoverMoveVal(10000,2003,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:HoverMoveValDmy(10000,1540,191,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,0);				--�C�x���g�R�}���hID(0)"�n�V�S�������"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂�������X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(1,"OnEvent_1211_1",LadderTime_A,0,0,once);
		--�͂�������p�̊֐���1�b�Ԕ��s(�C�x���g���j���[�̒��f����?)
		proxy:OnKeyTime2(1,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1211 end");
end

--��1211_1���n�V�S1����X�^�[�g:�z�o�[�ړ��I����
function OnEvent_1211_1(proxy, param)
	print("OnEvent_1211_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1211_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,-1,2);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1211_1 end");
end

--------------------------------------------------------------------------------------
--�n�V�S2�~�聡1212
--------------------------------------------------------------------------------------
--��1212���n�V�S1�~��X�^�[�g��
function OnEvent_1212(proxy, param)
	print("OnEvent_1212 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1212 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,2,2);				--�z�o�[�ړ����[�h�Ɉڍs
	--proxy:HoverMoveVal(10000,2002,LadderTime_A);--�ړ��ʒu(2002)��0.5�b�Ńz�o�[�ړ�
	proxy:HoverMoveValDmy(10000,1541,192,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,1);				--�C�x���g�R�}���hID(1)"�n�V�S�ォ���"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(1212,"OnEvent_1212_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���)
		proxy:OnKeyTime2(1212,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_1212 end");
end

--��1212_1���n�V�SA�~��X�^�[�g:�z�o�[�ړ��I����
function OnEvent_1212_1(proxy, param)
	print("OnEvent_1212_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1212_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,3,2);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1212_1 end");
end


--------------------------------------------------------------------------------------
--�n�V�S2���聡1213
--------------------------------------------------------------------------------------
--��1213���n�V�S1����X�^�[�g��
function OnEvent_1213(proxy, param)
	print("OnEvent_1213 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1213 end");
		return;
	end
	
	--�͂�������ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,-1,1);			--�z�o�[�ړ����[�h�Ɉڍs
	--proxy:HoverMoveVal(10000,2003,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:HoverMoveValDmy(10000,1541,191,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,0);				--�C�x���g�R�}���hID(0)"�n�V�S�������"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂�������X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(1,"OnEvent_1213_1",LadderTime_A,0,0,once);
		--�͂�������p�̊֐���1�b�Ԕ��s(�C�x���g���j���[�̒��f����?)
		proxy:OnKeyTime2(1,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1213 end");
end

--��1213_1���n�V�S1����X�^�[�g:�z�o�[�ړ��I����
function OnEvent_1213_1(proxy, param)
	print("OnEvent_1213_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1213_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,-1,2);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1213_1 end");
end

--------------------------------------------------------------------------------------
--�n�V�S3�~�聡1214
--------------------------------------------------------------------------------------
--��1214���n�V�S3�~��X�^�[�g��
function OnEvent_1214(proxy, param)
	print("OnEvent_1214 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1214 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,2,2);				--�z�o�[�ړ����[�h�Ɉڍs
	--proxy:HoverMoveVal(10000,2002,LadderTime_A);--�ړ��ʒu(2002)��0.5�b�Ńz�o�[�ړ�
	proxy:HoverMoveValDmy(10000,1542,192,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,1);				--�C�x���g�R�}���hID(1)"�n�V�S�ォ���"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(1214,"OnEvent_1214_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���)
		proxy:OnKeyTime2(1214,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_1214 end");
end

--��1214_1���n�V�SA�~��X�^�[�g:�z�o�[�ړ��I����
function OnEvent_1214_1(proxy, param)
	print("OnEvent_1214_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1214_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,3,2);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1214_1 end");
end


--------------------------------------------------------------------------------------
--�n�V�S3���聡1215
--------------------------------------------------------------------------------------
--��1215���n�V�S3����X�^�[�g��
function OnEvent_1215(proxy, param)
	print("OnEvent_1215 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1215 end");
		return;
	end
	
	--�͂�������ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,-1,1);			--�z�o�[�ړ����[�h�Ɉڍs
	--proxy:HoverMoveVal(10000,2003,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:HoverMoveValDmy(10000,1542,191,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,0);				--�C�x���g�R�}���hID(0)"�n�V�S�������"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂�������X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(1,"OnEvent_1215_1",LadderTime_A,0,0,once);
		--�͂�������p�̊֐���1�b�Ԕ��s(�C�x���g���j���[�̒��f����?)
		proxy:OnKeyTime2(1,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1215 end");
end

--��1215_1���n�V�S1����X�^�[�g:�z�o�[�ړ��I����
function OnEvent_1215_1(proxy, param)
	print("OnEvent_1215_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1215_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,-1,2);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1215_1 end");
end




--------------------------------------------------------------------------------------
--��1220���H����G���{�遡
--------------------------------------------------------------------------------------
--���̈�Ď�
function OnEvent_1220(proxy , param)

	--�H����G���{��ς݂�������A�Ď��폜
	if proxy:IsCompleteEvent( 1220 ) == true then
		proxy:DeleteEvent( 1220 );
		print("OnEvent_1220 end");
		return;
	end
	
	--�����X�q�𑕔����Ă��邩������
	if proxy:IsEquip(TYPE_PROTECTER,101800) == false then--�������Ă��Ȃ�
		if proxy:IsCompleteEvent( 1225 ) == true then
			proxy:LuaCallStart( 1220, 1 );--�����{��C�x���g����			
		end
		print("bousi")
	else
		if proxy:IsCompleteEvent( 1225 ) == false then
			proxy:LuaCallStart( 1225, 1 );--�����A�K�i���낵�Ă����C�x���g����
		end		
	end	
end

--���������{��p
function OnEvent_1220_hostile(proxy , param)
	print("OnEvent_1220_hostile begin");
	
	proxy:EnableLogic( 454 , true );--���W�b�NON
	
	proxy:DeleteEvent( 1220 );--�{�����̂ŊĎ��폜
	proxy:DeleteEvent( 1225 );--�K�i���낵�Ă����p�̊Ď��폜
	
	proxy:SetEventFlag( 1220 , 1 );
	
	print("OnEvent_1220_hostile end");
end

--�������U�����ē{�点��p
function OnEvent_1220_Damage(proxy,param)
	print("OnEvent_1220_Damage begin");
	proxy:LuaCallStart( 1220, 1 );--�����{��C�x���g����
	print("OnEvent_1220_Damage end");
end


--------------------------------------------------------------------------------------
--��1225���U���ɐ�������ƁA�K�i���~�낵�Ă���遡
--------------------------------------------------------------------------------------

--��1220�̗̈�Ď�����Ă΂��

--��1225���U���ɐ�������ƁA�K�i���~�낵�Ă���遡
function OnEvent_1225(proxy , param)
	print("OnEvent_1225 begin");
	
	--�H����G������ł�����A�Ď��폜
	if proxy:IsCompleteEvent( 1222 ) == true then
		proxy:DeleteEvent( 1220 );
		print("OnEvent_1225 end");
		return;
	end
	
	--�H����G���{��ς݂�������A�Ď��폜
	if proxy:IsCompleteEvent( 1220 ) == true then
		proxy:DeleteEvent( 1220 );
		print("OnEvent_1225 end");
		return;
	end

	proxy:PlayAnimation( 454 , 7001 );--���������o�[�������A�j��
	proxy:PlayAnimation( 1462 , 1 );--���o�[�������A�j��
	
	proxy:NotNetMessage_begin();
		--�����o�[�������A�j���I����
		proxy:OnCharacterAnimEnd( 1225 , 1462 , 1 , "OnEvent_1225_lever_end" , once );				
	proxy:NotNetMessage_end();
	
	print("OnEvent_1225 end");
end

--�����o�[�������A�j���I����
function OnEvent_1225_lever_end(proxy , param)
	print("OnEvent_1225_lever_end begin");
	proxy:NotNetMessage_begin();
		proxy:OnSimpleDamage( 1220 , 454 , 10000 , "OnEvent_1220_Damage" , once );--�_���[�W�Ď�
	proxy:NotNetMessage_end();
	proxy:PlayAnimation( 1550 , 1 );--�K�i���~���
	proxy:SetEventFlag( 1225 , 1 );
	print("OnEvent_1225_lever_end end");
end



--------------------------------------------------------------------------------------
--��1222���H����G�̎��S�`�F�b�N��
--------------------------------------------------------------------------------------

--��1222���H����G�̎��S�`�F�b�N��
function OnEvent_1222(proxy , param)
	print("OnEvent_1222 begin");
	
	proxy:SetEventFlag( 1222 , 1 );--�H����G�A���S�B
	
	--�����C�x���g�p�̔���������ɥ���B
	
	--�����̏�Ԃ��擾
	local now_state = GetNpcStateFlag( proxy, param, majo_flag_list );
	
	--�u������Ăق����v�łȂ��ꍇ�A�������Ȃ�
	if now_state ~= MAJO_STATE_LIBERATE then
		print("OnEvent_1222 end");
		return;
	end
	
	--�H����G�ɋU���������ĂȂ������牽�����Ȃ�
	if proxy:IsCompleteEvent( 1225 ) == false then
		print("OnEvent_1222 end");
		return;
	end

	--�����̏�Ԃ��u���Ӂv�ɂ���B
	SetNpcStateFlag( proxy , param , majo_flag_list , MAJO_STATE_THANKS );
	proxy:SetEventFlag( 1380 , 1 );--�Ή�����A�N�V�����t���O�����ĂĂ����B
	
	print("OnEvent_1222 end");
end


--------------------------------------------------------------------------------------
--��11500���������A�C�e����n���x�e���遡(��b�V�X�e������Ăяo��)
--------------------------------------------------------------------------------------

--��11500���������A�C�e����n���x�e���遡
function OnEvent_11500(proxy , param)
	print("OnEvent_11500 begin");
	
	--�����̏�Ԃ��擾
	local now_state = GetNpcStateFlag( proxy, param, majo_flag_list );
	
	--��Ԃ��u���Ӂv�łȂ������珈�������B
	if now_state ~= MAJO_STATE_THANKS then
		print("OnEvent_11500 end");
		return;
	end
	
	--�A�C�e���擾�֐�
	--proxy:GetRateItem(10101);
	
	--�����̏�Ԃ��u���ŋx�e�v�ɂ���B
	SetNpcStateFlag( proxy , param , majo_flag_list , MAJO_STATE_BREAK );
	
	proxy:SetEventFlag( 11500, 1 );
	
	print("OnEvent_11500 end");
end


--------------------------------------------------------------------------------------
--��1381���������G�΂��遡
--------------------------------------------------------------------------------------

--��1381���������G�΂��遡
function OnEvent_1381(proxy , param)
	print("OnEvent_1381 begin");
	
	--�����̏�Ԃ��擾
	local now_state = GetNpcStateFlag( proxy, param, majo_flag_list );
	
	--��Ԃ��u������Ăق����v�ł��A�u���Ӂv�ł��A�u���ŋx�e�v�ł��Ȃ��ꍇ���������B
	if now_state ~= MAJO_STATE_LIBERATE and
	   now_state ~= MAJO_STATE_THANKS   and
	   now_state ~= MAJO_STATE_BREAK    then
		print("OnEvent_1381 end");
		return;
	end
	
	--�����̏�Ԃ��u�G�΁v�ɂ���B
	proxy:EnableLogic( 625 , true );
	SetNpcStateFlag( proxy , param , majo_flag_list , MAJO_STATE_HOSTILE );
	proxy:SetTeamType( 625, TEAM_TYPE_AngryFriend );
	proxy:SetEventFlag( 1381, 1 );

	print("OnEvent_1381 end");
end


--------------------------------------------------------------------------------------
--��1382�����������S���遡
--------------------------------------------------------------------------------------

--��1382�����������S���遡
function OnEvent_1382(proxy , param)
	print("OnEvent_1382 begin");
	
	--�����̏�Ԃ��u���S�v�ɂ���B
	SetNpcStateFlag( proxy , param , majo_flag_list , MAJO_STATE_DEAD );
	proxy:SetEventFlag( 1382, 1 );	

	print("OnEvent_1382 end");
end





--------------------------------------------------------------------------------------
--��1310�������h�����q����̑O�Ɉړ����遡
--------------------------------------------------------------------------------------
function OnEvent_1310(proxy,param)
	print("OnEvent_1310 begin");	

	--����3�Łu����J���Ăق����v�� ��ԑJ�ڂ����݂�
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_WANT_TO_OPEN_THE_GATE );
	
		--proxy:DisableInterupt( 621, true );--���荞�݂��Ւf(�G�ɍU������Ă��퓬���W�b�N�ɂ��Ȃ�����)
		proxy:Warp( 621 , 2551 );--�����ʒu�Ƀ��[�v
		proxy:ChangeInitPosAng( 621 , 2552 );--�����̑O�̗̈�ɂ���
		proxy:EnableLogic( 621 , true );--���W�b�NON
		proxy:SendEventRequest( 621 , 0 , 10 );--�u�ⓚ���p�ő��܂ő���(ID:10)�v�̃��W�b�N�ɐ؂�ւ�
		proxy:ResetThink( 621 );
	
	proxy:SetEventFlag( 1310 , 1 );--�����h�����q����̑O�Ɉړ�����C�x���g�̏I��
	
	--���΂炭����ƁA�ǂ��Ă���G���o������
	
	proxy:NotNetMessage_begin();
		--�����q��ǂ��G���o������1��
		proxy:OnKeyTime2( 1350 , "OnEvent_1350" , 3.0 , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	proxy:NotNetMessage_begin();
		--�����q��ǂ��G���o������2��
		proxy:OnKeyTime2( 1351 , "OnEvent_1351" , 5.0 , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	proxy:NotNetMessage_begin();
		--�����q��ǂ��G���o������3��
		proxy:OnKeyTime2( 1352 , "OnEvent_1352" , 7.0 , 0 , 1 , once );
	proxy:NotNetMessage_end();
	proxy:DeleteEvent( 1310 );

	print("OnEvent_1310 end")
end



--------------------------------------------------------------------------------------
--��1350�����q��ǂ��G���o������1��
--------------------------------------------------------------------------------------
function OnEvent_1350(proxy,param)
	print("OnEvent_1350 begin");	

	ValidCharactor( proxy, 460 );--�Ή�����G��L����
	proxy:ChangeTarget( 460 , 621 );--�G�̃^�[�Q�b�g�����q�ɐݒ�
	proxy:SetEventFlag( 1350 , 1 );
	proxy:Warp( 460, 2560 );
	proxy:SetAlwayEnableBackread_forEvent( 460 , true );
	LuaFunc_ForceOmission( proxy,460);	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1350 ,"OnEvent_1350_1",5.0,0,10,once);
	proxy:NotNetMessage_end();

	print("OnEvent_1350 end")
end

function OnEvent_1350_1(proxy,param)
	print("OnEvent_1350_1 begin");
	LuaFunc_NormalOmission(proxy,460);
	proxy:SetAlwayEnableBackread_forEvent( 460 , false );
	print("OnEvent_1350_1 end")
end

--------------------------------------------------------------------------------------
--��1351�����q��ǂ��G���o������2��
--------------------------------------------------------------------------------------
function OnEvent_1351(proxy,param)
	print("OnEvent_1351 begin");	

	ValidCharactor( proxy, 461 );--�Ή�����G��L����
	proxy:ChangeTarget( 461 , 621 );--�G�̃^�[�Q�b�g�����q�ɐݒ�
	proxy:SetEventFlag( 1351 , 1 );
	proxy:Warp( 461, 2561 );
	proxy:SetAlwayEnableBackread_forEvent( 461 , true );
	LuaFunc_ForceOmission( proxy,461);	
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1351 ,"OnEvent_1351_1",5,0,10,once);
	proxy:NotNetMessage_end();

	print("OnEvent_1351 end")
end

function OnEvent_1351_1(proxy,param)
	print("OnEvent_1351_1 begin");
	LuaFunc_NormalOmission(proxy,461);
	proxy:SetAlwayEnableBackread_forEvent( 461 , false );
	print("OnEvent_1351_1 end");
end

--------------------------------------------------------------------------------------
--��1352�����q��ǂ��G���o������3��
--------------------------------------------------------------------------------------
function OnEvent_1352(proxy,param)
	print("OnEvent_1352 begin");	

	ValidCharactor( proxy, 462 );--�Ή�����G��L����
	proxy:ChangeTarget( 462 , 621 );--�G�̃^�[�Q�b�g�����q�ɐݒ�
	proxy:SetEventFlag( 1352 , 1 );
	proxy:Warp( 462, 2562 );
	proxy:SetAlwayEnableBackread_forEvent( 462 , true );
	LuaFunc_ForceOmission( proxy,462);
	--proxy:ForceChangeTarget( 460 , 622 );	
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1352 ,"OnEvent_1352_1",5,0,10,once);
	proxy:NotNetMessage_end();

	print("OnEvent_1352 end")
end


function OnEvent_1352_1(proxy,param)
	print("OnEvent_1352_1 begin");
	LuaFunc_NormalOmission(proxy,462);
	proxy:SetAlwayEnableBackread_forEvent( 462 , false );
	print("OnEvent_1352_1 end");
end


--------------------------------------------------------------------------------------
--��1311�����q���܏��H�Ɉړ����遡
--------------------------------------------------------------------------------------
--[[
--�����������̃`�F�b�N
function Check_OnEvent_1311(proxy,param)

	--�����h�����q�̏�Ԏ擾
	local now_state = GetRendolState(proxy, param);
	
	--�u����J���Ăق����v�łȂ��ꍇ�A������
	if now_state ~= RENDOL_STATE_WANT_TO_OPEN_THE_GATE then
		return false;
	end	
	
	--���J�����o�[�������ĂȂ�������A������
	if proxy:IsCompleteEvent( 1040 ) == false then
		return false;
	end
	
	--��������
	return true;
end
]]

--��1311�����q���܏��H�Ɉړ����遡
function OnEvent_1311(proxy,param)
	print("OnEvent_1311 begin");	
	
	
	--����3�Łu�܏��H�����v�� ��ԑJ�ڂ����݂�
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_SCARED );
		
	proxy:SendEventRequest( 621 , 0 , 10 );--�u�ⓚ���p�ő��܂ő���(ID:10)�v�̃��W�b�N�ɐ؂�ւ�	
	proxy:ChangeInitPosAng( 621 , 2553 );--����܏��H�̗̈�ɂ���
	proxy:ClearTarget( 621 );
	proxy:ResetThink( 621 );
	proxy:SetEventFlag( 1311 , 1 );--���q���܏��H�Ɉړ�����C�x���g�̏I��
	
	--���q��ǂ��Ă���G����̐�܂Œǂ��Ă���悤�ɑ���ς���
	
	proxy:NotNetMessage_begin();
		--�����q��ǂ��G�̑���ς���1��
		proxy:OnKeyTime2( 1360 , "OnEvent_1360" ,  5.0 , 0 , 1 , once );
	proxy:NotNetMessage_end();
	proxy:NotNetMessage_begin();
		--�����q��ǂ��G�̑���ς���2��
		proxy:OnKeyTime2( 1361 , "OnEvent_1361" ,  8.0 , 0 , 1 , once );
	proxy:NotNetMessage_end();
	proxy:NotNetMessage_begin();
		--�����q��ǂ��G�̑���ς���3��
		proxy:OnKeyTime2( 1362 , "OnEvent_1362" , 11.0 , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1311 end")
end



--------------------------------------------------------------------------------------
--��1360�����q��ǂ��G�̑���ς���1��
--------------------------------------------------------------------------------------
function OnEvent_1360(proxy,param)
	print("OnEvent_1360 begin");	

	if proxy:IsAlive(460) == true then
		proxy:ChangeInitPosAng( 460 , 2570 );--��̐�̗̈�ɑ���ς���
		LuaFunc_ForceOmission(proxy,460);
	end
	proxy:SetEventFlag( 1360 , 1 );

	print("OnEvent_1360 end")
end


--------------------------------------------------------------------------------------
--��1361�����q��ǂ��G�̑���ς���2��
--------------------------------------------------------------------------------------
function OnEvent_1361(proxy,param)
	print("OnEvent_1361 begin");	
	
	if proxy:IsAlive( 461 ) == true then
		proxy:ChangeInitPosAng( 461 , 2571 );--��̐�̗̈�ɑ���ς���
		LuaFunc_ForceOmission(proxy,461);
	end
	proxy:SetEventFlag( 1361 , 1 );

	print("OnEvent_1361 end")
end


--------------------------------------------------------------------------------------
--��1362�����q��ǂ��G�̑���ς���3��
--------------------------------------------------------------------------------------
function OnEvent_1362(proxy,param)
	print("OnEvent_1362 begin");	
	
	if proxy:IsAlive( 462 ) == true then
		proxy:ChangeInitPosAng( 462 , 2572 );--��̐�̗̈�ɑ���ς���
		LuaFunc_ForceOmission( proxy, 462 );
	end
	proxy:SetEventFlag( 1362 , 1 );

	print("OnEvent_1362 end")
end



--------------------------------------------------------------------------------------
--��1312�����q���܏��H�ɓ��������狯�������遡
--------------------------------------------------------------------------------------

--��1312�����q���܏��H�ɓ��������狯�������遡
function OnEvent_1312(proxy,param)
	print("OnEvent_1312 begin");	
	
	if	proxy:IsCompleteEvent(1313) == false then
		proxy:SendEventRequest( 621 , 0 , AI_EVENT_None );--���W�b�N��؂�ւ��Ă��̂���߂�B
		proxy:ResetThink( 621 );
		
		--proxy:EnableLogic( 621 , false );--���W�b�NOFF
		proxy:SetSpStayAndDamageAnimId(621,7600,9600);
		--proxy:NotNetMessage_begin();
			--proxy:OnKeyTime2( 1312, "OnEvent_1312_1", 1.0, 1, 2, once );
		--proxy:NotNetMessage_end();
	else
		SetNpcStateFlag(proxy, param, rendol_flag_list, RENDOL_STATE_THANKS_3);
		proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "RendolCheck", 0.0, 0, 2, once );
	end
	
	proxy:SetEventFlag( 1312 , 1 );
	
	print("OnEvent_1312 end")
end

--[[
function OnEvent_1312_1(proxy,param)
	proxy:SetEventCommand( 621 , 40 );--EzState�ɐ���ԍ��𑗂�(������)
end
]]

--[[
--------------------------------------------------------------------------------------
--��1313�����q�����ӂ��遡
--------------------------------------------------------------------------------------

--�����������̃`�F�b�N
function Check_OnEvent_1313(proxy,param)

	--�����h�����q�̏�Ԏ擾
	local now_state = GetRendolState(proxy, param);
	
	--�u�܏��H�����v�łȂ�������A������
	if now_state ~= RENDOL_STATE_SCARED then
		return false;
	end
	
	--[[���m�̎��S�Ď����Ȃ��B�̂łЂƂ܂��ȑO��ID�Ŕ���]]
	if proxy:IsCompleteEvent( 1410 ) == true and
	   proxy:IsCompleteEvent( 1411 ) == true and
	   proxy:IsCompleteEvent( 1412 ) == true then
		print("�ǂ��Ă��Ă��镺�m��S�ē|���܂���");
		return true;
	end
	
	return false;
end
]]

--��1313�����q�����ӂ��遡
function OnEvent_1313(proxy,param)
	print("OnEvent_1313 begin");

	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1313, "OnEvent_1313_1", 1.0, 1, 2, once );
	proxy:NotNetMessage_end();
	
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_THANKS_3 );
	--RendolCheck(proxy,param);
	
	proxy:SetEventFlag( 1313 , 1 );
	
	print("OnEvent_1313 end")
end

function OnEvent_1313_1(proxy,param)
	--proxy:SetEventCommand( 621 , 41 );--EzState�ɐ���ԍ��𑗂�(�����I��)
	proxy:SetSpStayAndDamageAnimId(621,-1,-1);
end

--------------------------------------------------------------------------------------
--��11501�����q���T�����J�n���遡(��b�V�X�e������Ăяo��)
--------------------------------------------------------------------------------------

function OnEvent_11501(proxy,param)
	print("OnEvent_11501 begin");
	
	--�A�C�e���擾�֐�
	proxy:GetRateItem(10191);
	
	proxy:SetEventFlag( 11501, 1 );
	--���[�v�����̂�RendolCheck�͖���
	--����3�ŒT���� ��ԑJ��
	SetNpcStateFlag(proxy, param, rendol_flag_list, RENDOL_STATE_SEARCH_3);
	RendolCheck(proxy,param);


	print("OnEvent_11501 end")
end

--[[
--------------------------------------------------------------------------------------
--��1315�����q�����̃u���b�N�Ɉړ����遡
--------------------------------------------------------------------------------------

function Check_OnEvent_1315( proxy , param )

	--�����v���C���[(�O���C)�̂ݔ���
	if proxy:IsLivePlayer() == false and
	   proxy:IsGreyGhost()  == false then
		return false;
	end
	
	--�{�X(���̌�)�����Ă��画�肵�Ȃ�
	if proxy:IsCompleteEvent( 4360 ) == false then
		return false;
	end
	
	--��������
	if proxy:IsDistance( 10000 , 621 , 20 ) == true then
		return false;
	else
		print("�����h�����q�A���u���b�N�ֈړ�");
		return true;
	end
	
	return false;
end
]]

function OnEvent_1315( proxy , param )
	print("OnEvent_1315 begin");
	
	--����4�G���x�[�^�O�� ��ԑJ��
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_LIFT_FRONT);
	RendolCheck(proxy,param);
	
	proxy:SetEventFlag( 1315 , 1 );--�C�x���g�I��
	
	print("OnEvent_1315 end");
end


--------------------------------------------------------------------------------------
--��1316�������h�����q���G�΂���(���O)��
--------------------------------------------------------------------------------------

function OnEvent_1316(proxy,param)
	print("OnEvent_1316 begin");
	if	proxy:IsCompleteEvent( RENDOL_STATE_WANT_TO_OPEN_THE_GATE ) == true then
	--�G��(����3 ���O)�� ��ԑJ�ڂ����݂�
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HOSTILE_3_FRONT_GATE);
	RendolCheck(proxy,param);

	proxy:SetEventFlag( 1316 , 1 );
	end
	
	print("OnEvent_1316 end");
end


--------------------------------------------------------------------------------------
--��1317�������h�����q���G�΂���(�����)��
--------------------------------------------------------------------------------------

function OnEvent_1317(proxy,param)
	print("OnEvent_1317 begin");
	
	if	proxy:IsCompleteEvent( RENDOL_STATE_SCARED )	== true or
		proxy:IsCompleteEvent( RENDOL_STATE_THANKS_3 )	== true or
		proxy:IsCompleteEvent( RENDOL_STATE_SEARCH_3 )	== true then
	--�G��(����3 �����)�� ��ԑJ�ڂ����݂�
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HOSTILE_3_BACK_GATE);
	RendolCheck(proxy,param);

	proxy:SetEventFlag( 1317 , 1 );
	end
	
	print("OnEvent_1317 end");
end


--------------------------------------------------------------------------------------
--��1338�������h�����q���s���~�܂�p�̈�ɓ�������
--------------------------------------------------------------------------------------
function OnEvent_1338_in(proxy,param)
	print("OnEvent_1338_in begin");
	proxy:SetEventFlag( 1338 , true );
	print("OnEvent_1338_in end");
end

--�̈悩��o��
function OnEvent_1338_out(proxy,param)
	print("OnEvent_1338_out begin");
	proxy:SetEventFlag( 1338 , false );
	print("OnEvent_1338_out end");
end




--------------------------------------------------------------------------------------
--��1318�������h�����q�����S���遡
--------------------------------------------------------------------------------------

function OnEvent_1318(proxy,param)
	print("OnEvent_1318 begin");

	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_DEAD );
	RendolCheck(proxy,param);
	--���S��RendolCheck����ꍇ�A���̏u�Ԃɏ����Ă��܂��̂ŁA
	--���������čēx�L���ɂ��邩���߂�
	if	proxy:IsDistance( LOCAL_PLAYER, 621, 20 ) == true then
		ValidCharactor( proxy, 621 );
	end

	proxy:SetEventFlag( 1318 , 1 );
	
	print("OnEvent_1318 end");
end

--------------------------------------------------------------------------------------
--��1349�������h�����q����̑O�ɓ����������ǁA�傪�܂��Ă��遡
--------------------------------------------------------------------------------------
function OnEvent_1349(proxy,param)
	print("OnEvent_1349 begin");
	--�傪�J���Ă��Ȃ���΁A�u�ⓚ���p�ő��܂ňړ��v��؂��ēK���ɐ�킹��
	if	proxy:IsCompleteEvent( 1041 ) == false then
		proxy:SendEventRequest( 621 , 0 , AI_EVENT_None );--���W�b�N��؂�ւ��Ă��̂���߂�B
	end
	print("OnEvent_1349 end");
end

--------------------------------------------------------------------------------------
--��1410,1411,1412����ʕ��mABC�̎��S�Ď���
--------------------------------------------------------------------------------------
function OnEvent_1410_1411_1412(proxy,param)
	print("OnEvent_1410_1411_1412 begin");
	
	proxy:SetEventFlag( param:GetParam1(), true );
	
	local flag_list = {1410, 1411, 1412};
	local flag_num  = table.getn( flag_list );
	
	--1�ł��������Ă��Ȃ��ꍇ��return����
	for index = 1, flag_num, 1 do
		if	proxy:IsCompleteEvent( flag_list[index] ) == false then
			return;
		end
	end
	
	LuaFunc_NormalOmission(proxy,460);
	LuaFunc_NormalOmission(proxy,461);
	LuaFunc_NormalOmission(proxy,462);
	
	--�����h�����q�̏�Ԏ擾
	local now_state = GetRendolState(proxy, param);
	
	--�u�܏��H�����v�łȂ�������A������
	if now_state ~= RENDOL_STATE_SCARED then
		--���ł͂�����Ă��܂�����`�F�b�N�|�C���g�ł���
		--�Ƃ肠����������OK
		proxy:SetEventFlag( 1313 , true );
		return false;
	end
	
	OnEvent_1313(proxy,param);
	
	print("OnEvent_1410_1411_1412 end");
end


--------------------------------------------------------------------------------------
--��1250���R����m���]���藎���Ă���1��
--------------------------------------------------------------------------------------

function OnEvent_1250(proxy , param)
	print("OnEvent_1250 begin");

	if proxy:IsCompleteEvent( 1250 ) == true then
		print("OnEvent_1250 end");
		return;
	end
	
	proxy:PlayAnimation( 470 , 3002 );--���m���R��
	
	proxy:NotNetMessage_begin();
		--��1250_1�����m�R��A�j���づ
		proxy:OnKeyTime2( 1250 , "OnEvent_1250_1" , (16/30) , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1250 , 1 );
	
	print("OnEvent_1250 end");
end


--��1250_1�����m�R��A�j���っ
function OnEvent_1250_1(proxy , param)
	print("OnEvent_1250_1 begin");

	proxy:PlayAnimation( 1496 , 1 );--�΂̘m�]����	
	
	proxy:SetEventFlag( 1250 , 0 );
	
	proxy:NotNetMessage_begin();
		--��1250_2���_���[�W�����ł�̂�x�点��(�R�����{�l�ɓ�����Ȃ��悤��)��
		proxy:OnKeyTime2( 1250 , "OnEvent_1250_2" , 0.5 , 0 , 2 , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1250 , 1 );
	
	print("OnEvent_1250_1 end");
end


--��1250_2���_���[�W�����ł�̂�x�点��(�R�����{�l�ɓ�����Ȃ��悤��)��
function OnEvent_1250_2(proxy , param)
	print("OnEvent_1250_2 begin");
	proxy:EnableLogic( 470 , true );--���W�b�NON(�ЂƂ܂������ɥ��)
	--�΂̘m����_���[�W��
	local paramid = 10010; --�Α����_���[�W
	local rad     = DAMAGE_RADIUS;--���a
	local time    = 20; --�ЂƂ܂��A�j���Đ��I���Ń_���[�W�������̂ŁA�A�j����蒷�����Ԃ��w�肵�Ă���
	
	proxy:SetEventFlag( 1250 , 0 );

	proxy:OnObjectDamageHit_NoCall( 1250, 1496, 1, paramid, EV_HIT_CHR , rad, time, everytime );	
	proxy:SetObjEventCollisionFill( 1496, true );
	
	proxy:NotNetMessage_begin();
		--��1250_anime_end���΂̘m�]����I�������
		proxy:OnCharacterAnimEnd( 1250 , 1496 , 1 , "OnEvent_1250_anime_end" , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1250 , 1 );	
	
	print("OnEvent_1250_2 end");
end


--��1250_anime_end���΂̘m�]����I�������
function OnEvent_1250_anime_end( proxy , param )
	print("OnEvent_1250_anime_end begin");

	proxy:DeleteEvent( 1250 );--�_���[�W���ȂǍ폜
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		--proxy:OnKeyTime2( 1171 , "OnEvent_1171_1403",1.8,0,1403,once);			
		proxy:OnObjectDamageHit_NoCallPlus( 1171, 1403,1,10310,EV_HIT_CHR,1.2,-1,2.0,everytime);			
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();	

	print("OnEvent_1250_anime_end end");
end



--------------------------------------------------------------------------------------
--��1251���R����m���]���藎���Ă���2��
--------------------------------------------------------------------------------------

function OnEvent_1251(proxy , param)
	print("OnEvent_1251 begin");

	if proxy:IsCompleteEvent( 1251 ) == true then
		print("OnEvent_1251 end");
		return;
	end
	
	proxy:PlayAnimation( 471 , 3002 );--���m���R��
	
	proxy:NotNetMessage_begin();
		--��1251_1�����m�R��A�j���づ
		proxy:OnKeyTime2( 1251 , "OnEvent_1251_1" , (16/30) , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1251 , 1 );
	
	print("OnEvent_1251 end");
end


--��1251_1�����m�R��A�j���っ
function OnEvent_1251_1(proxy , param)
	print("OnEvent_1251_1 begin");

	proxy:PlayAnimation( 1497 , 1 );--�΂̘m�]����	
	
	proxy:SetEventFlag( 1251 , 0 );
	
	proxy:NotNetMessage_begin();
		--��1251_2���_���[�W�����ł�̂�x�点��(�R�����{�l�ɓ�����Ȃ��悤��)��
		proxy:OnKeyTime2( 1251 , "OnEvent_1251_2" , 0.5 , 0 , 2 , once );
		proxy:OnKeyTime2( 1251 , "OnEvent_1251_3" , 1.5 , 0 , 5 , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1251 , 1 );
	
	print("OnEvent_1251_1 end");
end


--��1251_2���_���[�W�����ł�̂�x�点��(�R�����{�l�ɓ�����Ȃ��悤��)��
function OnEvent_1251_2(proxy , param)
	print("OnEvent_1251_2 begin");
	
	--�΂̘m����_���[�W��
	local paramid = 10010; --�Α����_���[�W
	local rad     = DAMAGE_RADIUS;--���a
	local time    = 20; --�ЂƂ܂��A�j���Đ��I���Ń_���[�W�������̂ŁA�A�j����蒷�����Ԃ��w�肵�Ă���
	
	proxy:SetEventFlag( 1251 , 0 );
	
	proxy:OnObjectDamageHit_NoCall( 1251, 1497, 1, paramid, EV_HIT_CHR , rad, time, everytime );	
	proxy:SetObjEventCollisionFill( 1497, true );
	
	proxy:NotNetMessage_begin();
		--��1251_anime_end���΂̘m�]����I�������
		proxy:OnCharacterAnimEnd( 1251 , 1497 , 1 , "OnEvent_1251_anime_end" , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1251 , 1 );	
	
	print("OnEvent_1251_2 end");
end

--�{�l�������̂�x�点��
function OnEvent_1251_3(proxy,param)
	print("OnEvent_1251_3 begin");
	proxy:EnableLogic( 471 , true );--���W�b�NON(�ЂƂ܂������ɥ��)
	print("OnEvent_1251_3 end");
end

--��1251_anime_end���΂̘m�]����I�������
function OnEvent_1251_anime_end( proxy , param )
	print("OnEvent_1251_anime_end begin");

	proxy:DeleteEvent( 1251 );--�_���[�W���ȂǍ폜

	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		--proxy:OnKeyTime2( 1172 , "OnEvent_1172_1404",1.9,0,1404,once);			
		proxy:OnObjectDamageHit_NoCallPlus( 1172, 1404,1,10310,EV_HIT_CHR,1.2,-1,2.0,everytime);			
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();	
	print("OnEvent_1251_anime_end end");
end



--------------------------------------------------------------------------------------
--��1260���z�X�gPC�݂̂��ʂ����̖���
--------------------------------------------------------------------------------------

--��1260_delete_wall�����@�Ǎ폜�����p��
function OnEvent_1260_delete_wall(proxy , param)
	print("OnEvent_1260_delete_wall begin");
	
	proxy:SetDrawEnable( 1560 , false );--�`��OFF
	proxy:SetColiEnable( 1560 , false );--������OFF	
	proxy:SetObjDeactivate( 1560 , true );--�f�A�N�e�B�u
	proxy:InvalidSfx( 2425 , true );--SFX OFF
	proxy:DeleteEvent( 1260 );
	
	print("OnEvent_1260_delete_wall end");
end


--��1260���C�x���g�����p��
function OnEvent_1260(proxy , param)
	print("OnEvent_1260 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 1260 ) == true then
		print("OnEvent_1260 end");
		return;
	end
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 1260 , 1 );
		print("OnEvent_1260 end");
		return;
	end
	
	--�_�~�|���փ��[�v
	proxy:WarpDmy( 10000 , 1560 , 191 );
	
	proxy:NotNetMessage_begin();
		--��1260_1�������A�j���I����
		--proxy:OnChrAnimEnd( 1260 , 10000 , ANIMEID_WALK , "OnEvent_1260_1" , once );
		proxy:LuaCallStart( 1260 , 1 );--���̖��폜����
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1260 , 1 );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1260 end");
end


--��1260_1�������A�j���I����
function OnEvent_1260_1(proxy , param)
	print("OnEvent_1260_1 begin");
	
	proxy:LuaCallStart( 1260 , 1 );--���̖��폜����
	
	print("OnEvent_1260_1 end");
end

--[[
--��1430���r�������O�����@���̌��̕����ɂ���Ă��遡
function OnEvent_1430(proxy,param)
	print("OnEvent_1430 begin");
	proxy:PlayAnimation( 627, ANIMEID_WALK );
	proxy:SetEventFlag( 1430, true );
	proxy:SetTeamType( 627 , TEAM_TYPE_BattleFriend );
	print("OnEvent_1430 end");
end
]]

--��1432���r�������O�����@�G�΂��遡
function OnEvent_1432(proxy,param)
	print("OnEvent_1432 begin");
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_HOSTILE_IN_KING_ROOM );
	proxy:SetEventCommand( 627 , 51 );--EzState�ɐ���ԍ�(�����オ��)��n��
	proxy:SetTeamType( 627, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2(627,5064);
	proxy:EnableLogic( 627, true );--�r�����W�b�NON
	proxy:SetEventFlag( 1432, true );
	print("OnEvent_1432 end");
end


--��1433���r�������O�����@���S��
function OnEvent_1433(proxy,param)
	print("OnEvent_1433 begin");
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_DEAD );
	proxy:SetEventFlag( 1433, true );
	print("OnEvent_1433 end");
end

--��1460���r�������O�����@���̌���|���Ė������ĐQ�遡
function OnEvent_1460(proxy,param)
	print("OnEvent_1460 begin");
	if	proxy:IsCompleteEvent( BIYO_STATE_KING_OF_SWORD_KILL ) == true then
		proxy:EnableLogic( 627, false );--�r�����W�b�NOFF
		proxy:SetEventCommand( 627, 60 );--EzState�ɐ���ԍ�(�Q��)��n��
	end
	proxy:SetEventFlag( 1460, true );
	print("OnEvent_1460 end");
end

--��1470���r�������O�����@��b�p�Ď���
function OnEvent_1470( proxy,param )
	print("OnEvent_1470 begin");
	proxy:SetEventFlag( 1470 , true );
	print("OnEvent_1470 end");
end

--------------------------------------------------------------------------------------
--�z�ꕺ�m�Ɉ��_���[�W��1167
--------------------------------------------------------------------------------------
function OnEvent_1440(proxy,param)
	print("OnEvent_1440 begin");

	--���W�b�NOn
	proxy:EnableLogic( 679, true );
	
	--�z�ꕺ�m�̏�Ԃ�G��(����3)�ɂ���
	SetNpcStateFlag(proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_HOSTILE03);
	--�z�ꕺ�m�̃`�[���^�C�v��ύX����
	proxy:SetTeamType( 679, TEAM_TYPE_AngryFriend );

	--�t���O�𗧂Ă�
	proxy:SetEventFlag( 1440, true );
	
	print("OnEvent_1440 end");
end


--------------------------------------------------------------------------------------
--�z�ꕺ�m���S��1168
--------------------------------------------------------------------------------------
function OnEvent_1441(proxy,param)
	print("OnEvent_1441 begin");

	--�z�ꕺ�m�̏�Ԃ��u���S�v�ɕς���
	SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_DEAD );
	
	--�G�ɍ���ēG�΂�ʂ�z���Ď��S�����肦��̂ŁA�����ł��폜
	--���񂾂�G�΂ɂ͂Ȃ�Ȃ��̂ō폜
	proxy:DeleteEvent( 341 );
	proxy:DeleteEvent( 760 );
	proxy:DeleteEvent( 1441 );

	--�t���O�𗧂Ă�
	proxy:SetEventFlag( 1441, true );
	
	print("OnEvent_1441 end");
end


-----------------------------------------------------------------------------
--��1110��QWC�\�E�������X�^�[�o���P��
-----------------------------------------------------------------------------
function OnEvent_1110(proxy,param)
	print("OnEvent_1110 begin");
	
	--�\�E�������X�^�[�o��
	ValidCharactor( proxy, 180 );
	ValidCharactor( proxy, 181 );

	--�\�E�������X�^�[�o���A�j���̍Đ�
	proxy:PlayAnimation( 180, 6100 );
	proxy:PlayAnimation( 181, 6100 );
	
	--�t���OON
	proxy:SetEventFlag( 1110, true );
	print("OnEvent_1110 end");
end


--------------------------------------------------------------------------------------
--�J���X����ї���
--------------------------------------------------------------------------------------
function FryAwayKarasu(proxy,param, KarasuEventID, karasuID, FryAnimeID)	
	print("FryAwayKarasu_"..karasuID.." begin");

	proxy:PlayAnimation( karasuID, FryAnimeID );

	proxy:NotNetMessage_begin();
		--���J���X�A�j���Đ��I����
		proxy:OnCharacterAnimEnd( KarasuEventID , karasuID , FryAnimeID , "OnEvent_"..KarasuEventID.."_1" , once );	
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( KarasuEventID , 1 );

	print("FryAwayKarasu_"..karasuID.." end");
end

-----------------------------------------
--�J���X�A�j���Đ��I�������̂ŏ����Ă���
-----------------------------------------
function OnEvent_1121_1(proxy,param)	proxy:SetDrawEnable( 1565 , false ); print("KarasuFryAway ID=1565"); end
function OnEvent_1122_1(proxy,param)	proxy:SetDrawEnable( 1566 , false ); print("KarasuFryAway ID=1566"); end
function OnEvent_1123_1(proxy,param)	proxy:SetDrawEnable( 1567 , false ); print("KarasuFryAway ID=1567"); end
function OnEvent_1124_1(proxy,param)	proxy:SetDrawEnable( 1568 , false ); print("KarasuFryAway ID=1568"); end
function OnEvent_1125_1(proxy,param)	proxy:SetDrawEnable( 1569 , false ); print("KarasuFryAway ID=1569"); end
function OnEvent_1126_1(proxy,param)	proxy:SetDrawEnable( 1570 , false ); print("KarasuFryAway ID=1570"); end
function OnEvent_1127_1(proxy,param)	proxy:SetDrawEnable( 1571 , false ); print("KarasuFryAway ID=1571"); end
function OnEvent_1128_1(proxy,param)	proxy:SetDrawEnable( 1572 , false ); print("KarasuFryAway ID=1572"); end
function OnEvent_1129_1(proxy,param)	proxy:SetDrawEnable( 1573 , false ); print("KarasuFryAway ID=1573"); end
function OnEvent_1130_1(proxy,param)	proxy:SetDrawEnable( 1574 , false ); print("KarasuFryAway ID=1574"); end
function OnEvent_1131_1(proxy,param)	proxy:SetDrawEnable( 1575 , false ); print("KarasuFryAway ID=1575"); end
function OnEvent_1132_1(proxy,param)	proxy:SetDrawEnable( 1576 , false ); print("KarasuFryAway ID=1576"); end
function OnEvent_1133_1(proxy,param)	proxy:SetDrawEnable( 1577 , false ); print("KarasuFryAway ID=1577"); end
function OnEvent_1134_1(proxy,param)	proxy:SetDrawEnable( 1578 , false ); print("KarasuFryAway ID=1578"); end
function OnEvent_1135_1(proxy,param)	proxy:SetDrawEnable( 1579 , false ); print("KarasuFryAway ID=1579"); end
function OnEvent_1136_1(proxy,param)	proxy:SetDrawEnable( 1580 , false ); print("KarasuFryAway ID=1580"); end
function OnEvent_1137_1(proxy,param)	proxy:SetDrawEnable( 1581 , false ); print("KarasuFryAway ID=1581"); end
function OnEvent_1138_1(proxy,param)	proxy:SetDrawEnable( 1582 , false ); print("KarasuFryAway ID=1582"); end
function OnEvent_1139_1(proxy,param)	proxy:SetDrawEnable( 1583 , false ); print("KarasuFryAway ID=1583"); end
function OnEvent_1140_1(proxy,param)	proxy:SetDrawEnable( 1584 , false ); print("KarasuFryAway ID=1584"); end
function OnEvent_1141_1(proxy,param)	proxy:SetDrawEnable( 1585 , false ); print("KarasuFryAway ID=1585"); end
function OnEvent_1142_1(proxy,param)	proxy:SetDrawEnable( 1586 , false ); print("KarasuFryAway ID=1586"); end
function OnEvent_1143_1(proxy,param)	proxy:SetDrawEnable( 1587 , false ); print("KarasuFryAway ID=1587"); end
function OnEvent_1144_1(proxy,param)	proxy:SetDrawEnable( 1588 , false ); print("KarasuFryAway ID=1588"); end
function OnEvent_1145_1(proxy,param)	proxy:SetDrawEnable( 1589 , false ); print("KarasuFryAway ID=1589"); end
function OnEvent_1146_1(proxy,param)	proxy:SetDrawEnable( 1590 , false ); print("KarasuFryAway ID=1590"); end
function OnEvent_1147_1(proxy,param)	proxy:SetDrawEnable( 1591 , false ); print("KarasuFryAway ID=1591"); end
function OnEvent_1148_1(proxy,param)	proxy:SetDrawEnable( 1592 , false ); print("KarasuFryAway ID=1592"); end
function OnEvent_1149_1(proxy,param)	proxy:SetDrawEnable( 1593 , false ); print("KarasuFryAway ID=1593"); end
function OnEvent_1150_1(proxy,param)	proxy:SetDrawEnable( 1594 , false ); print("KarasuFryAway ID=1594"); end

---------------------------------
--�J���X����ї��֐����Ăяo��
---------------------------------
function OnEvent_1121(proxy, param) FryAwayKarasu(proxy, param, 1121, 1565, 10); end
function OnEvent_1122(proxy, param) FryAwayKarasu(proxy, param, 1122, 1566, 11); end
function OnEvent_1123(proxy, param) FryAwayKarasu(proxy, param, 1123, 1567, 10); end
function OnEvent_1124(proxy, param) FryAwayKarasu(proxy, param, 1124, 1568, 11); end
function OnEvent_1125(proxy, param) FryAwayKarasu(proxy, param, 1125, 1569, 11); end
function OnEvent_1126(proxy, param) FryAwayKarasu(proxy, param, 1126, 1570, 11); end
function OnEvent_1127(proxy, param) FryAwayKarasu(proxy, param, 1127, 1571, 10); end
function OnEvent_1128(proxy, param) FryAwayKarasu(proxy, param, 1128, 1572, 11); end
function OnEvent_1129(proxy, param) FryAwayKarasu(proxy, param, 1129, 1573, 10); end
function OnEvent_1130(proxy, param) FryAwayKarasu(proxy, param, 1130, 1574, 11); end
function OnEvent_1131(proxy, param) FryAwayKarasu(proxy, param, 1131, 1575, 10); end
function OnEvent_1132(proxy, param) FryAwayKarasu(proxy, param, 1132, 1576, 11); end
function OnEvent_1133(proxy, param) FryAwayKarasu(proxy, param, 1133, 1577, 10); end
function OnEvent_1134(proxy, param) FryAwayKarasu(proxy, param, 1134, 1578, 11); end
function OnEvent_1135(proxy, param) FryAwayKarasu(proxy, param, 1135, 1579, 10); end
function OnEvent_1136(proxy, param) FryAwayKarasu(proxy, param, 1136, 1580, 11); end
function OnEvent_1137(proxy, param) FryAwayKarasu(proxy, param, 1137, 1581, 10); end
function OnEvent_1138(proxy, param) FryAwayKarasu(proxy, param, 1138, 1582, 11); end
function OnEvent_1139(proxy, param) FryAwayKarasu(proxy, param, 1139, 1583, 10); end
function OnEvent_1140(proxy, param) FryAwayKarasu(proxy, param, 1140, 1584, 12); end
function OnEvent_1141(proxy, param) FryAwayKarasu(proxy, param, 1141, 1585, 12); end
function OnEvent_1142(proxy, param) FryAwayKarasu(proxy, param, 1142, 1586, 12); end
function OnEvent_1143(proxy, param) FryAwayKarasu(proxy, param, 1143, 1587, 12); end
function OnEvent_1144(proxy, param) FryAwayKarasu(proxy, param, 1144, 1588, 12); end
function OnEvent_1145(proxy, param) FryAwayKarasu(proxy, param, 1145, 1589, 12); end
function OnEvent_1146(proxy, param) FryAwayKarasu(proxy, param, 1146, 1590, 12); end
function OnEvent_1147(proxy, param) FryAwayKarasu(proxy, param, 1147, 1591, 12); end
function OnEvent_1148(proxy, param) FryAwayKarasu(proxy, param, 1148, 1592, 12); end
function OnEvent_1149(proxy, param) FryAwayKarasu(proxy, param, 1149, 1593, 12); end
function OnEvent_1150(proxy, param) FryAwayKarasu(proxy, param, 1150, 1594, 12); end


--------------------------------------------------------------------------------------
--��1160���z�΂̐���̎��S�Ǘ���
--------------------------------------------------------------------------------------
function OnEvent_1160(proxy,param)
	print("OnEvent_1160 begin");
	proxy:SetEventFlag(1160,true);
	print("OnEvent_1160 end");
end

--------------------------------------------------------------------------------------
--��8020���z�΂̐��삩��A�C�e���擾��
--------------------------------------------------------------------------------------
function OnEvent_8020(proxy,param)
	print("OnEvent_8020 begin");
	proxy:SetEventFlag( 8020 , true );
	print("OnEvent_8020 end");
end


--------------------------------------------------------------------------------------
--��1170���Θm�_���[�W��
--------------------------------------------------------------------------------------
--[[
function ObjDamage2(proxy,eventid,objid)
	if proxy:IsReady_Obj(objid) == true then
		proxy:OnObjectDamageHit_NoCall( eventid, objid,1,10310,EV_HIT_CHR,1.2,FIREDAM_WAIT,everytime);
	end
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnKeyTime2( eventid , "OnEvent_"..eventid.."_"..objid.."_1",FIREDAM_WAIT,0,objid+10000,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
end

function ObjDamage2_1(proxy,eventid,objid)
	if proxy:IsReady_Obj(objid) == true then
		proxy:OnObjectDamageHit_NoCall( eventid, objid,1,10310,EV_HIT_CHR,1.2,FIREDAM_WAIT,everytime);
	end
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnKeyTime2( eventid , "OnEvent_"..eventid.."_"..objid,FIREDAM_WAIT,0,objid,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
end

function OnEvent_1170_1400(proxy,param) ObjDamage2(proxy,1170,1400); end
function OnEvent_1170_1400_1(proxy,param) ObjDamage2_1(proxy,1170,1400); end
function OnEvent_1170_1401(proxy,param) ObjDamage2(proxy,1170,1401); end
function OnEvent_1170_1401_1(proxy,param) ObjDamage2_1(proxy,1170,1401); end
function OnEvent_1170_1402(proxy,param) ObjDamage2(proxy,1170,1402); end
function OnEvent_1170_1402_1(proxy,param) ObjDamage2_1(proxy,1170,1402); end

function OnEvent_1171_1403(proxy,param) ObjDamage2(proxy,1171,1403); end
function OnEvent_1171_1403_1(proxy,param) ObjDamage2_1(proxy,1171,1403); end
function OnEvent_1172_1404(proxy,param) ObjDamage2(proxy,1172,1404); end
function OnEvent_1172_1404_1(proxy,param) ObjDamage2_1(proxy,1172,1404); end
]]

-----------------------------------------------------------------------------
--��1090�������g�J�Q�C�x���g4
-----------------------------------------------------------------------------
function OnEvent_1090(proxy,param)
	print("OnEvent_1090 begin");
	proxy:SetEventFlag( 1090, true);
	proxy:DeleteEvent( 1090 );
	print("OnEvent_1090 end");
end
