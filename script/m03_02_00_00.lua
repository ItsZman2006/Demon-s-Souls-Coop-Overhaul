
--���p�j�f�[�����p��ID

demon_id_list_m03_02_00_00 = { 832 };


--�e�l�s�i�҂�
START_MARCH_WAIT = 0.0;

--------------------------
--�}�X�^�[�T�c�L�p��QWC�l
--------------------------
--�}�X�^�[�T�c�L�o���pQWC
MasterQWC_01 = 0;
MasterQWC_02 = 0;
MasterQWC_03 = 0;
--���o���pQWC
MasterSwordQWC_01 = 0;
MasterSwordQWC_02 = 0;
MasterSwordQWC_03 = 0;
---------------------------------
--�}�X�^�[�T�c�L�̏�ԕω��t���O
---------------------------------
--m_03_01_00_00�ɋL��

--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉����������
--------------------------------------------------------------------------------------
function Initialize_m03_02_00_00(proxy)
	print("Initialize_m03_02_00_00 begin");
-----------------------------------------------------------------------------------------
--�{�X�֘A
-----------------------------------------------------------------------------------------
--��1108���{�X�̃|�����Đ���
	if proxy:IsCompleteEvent( 4895 ) == false then	
		SingleReset( proxy,1108 );
		SingleReset( proxy,4880 );
	end
	if proxy:IsCompleteEvent( 1108 ) == false then 	
		--���{�X�O�̃|�����Đ��p�Ď��ǉ�
		proxy:NotNetMessage_begin();
			proxy:OnRegionJustIn( 1108 , 10000 , 2897 , "OnEvent_1108" , once );
		proxy:NotNetMessage_end();
		proxy:LuaCall( 1108 , 1 ,"OnEvent_1108_1",once);
		
		proxy:NotNetMessage_begin();
			--�|�����J�n�ɌĂ΂��n���h��
			proxy:LuaCall(1108, REMO_START, "OnEvent_1108_RemoStart", once);
			--�|�����I����ɌĂ΂��n���h��(�g���K�[�N�������l�p)
			proxy:LuaCall(1108, REMO_FINISH, "OnEvent_1108_RemoFinish", once);
		proxy:NotNetMessage_end();	
	end
	
--��1108���{�X�̃|�����Đ���
	if proxy:IsCompleteEvent( 1108 ) == true then--�|�����I���ς�	
		proxy:EndAnimation( 1408 , 1 );--�����J���A�j���I��
		proxy:EndAnimation( 1407 , 1 );--�����ւ��ރA�j���I��
	else
		--�|������̊��I�̕\���Ɠ�����������Ă���
		proxy:SetDrawEnable( 1421, false );
		proxy:SetColiEnable( 1421, false );--���I�ɓ����肪���邩�͕s���c
		--�G��\�������Ȃ�
		InvalidCharactor( proxy, 805 );
	end	

--��1190���{�X�����ɓ��遡	
	--���{�X�������Ă���Ƃ������C�x���g�o�^
	if proxy:IsCompleteEvent( 4895 ) == false then	
		--�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B
		SingleReset(proxy, 1190);
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���)
		proxy:LuaCall( 1191, 1, "OnEvent_1190_1", everytime );		
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCall( 1191 , 5 , "OnEvent_1190_GO_TO_IN" , everytime );		
		--���t���O�Z�b�g(�����p)
		proxy:LuaCall( 1191 , 6 , "OnEvent_1190_flag_set" , everytime );		
		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ�
		if proxy:IsCompleteEvent( 1190 ) == false then		
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l����
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;			
			proxy:NotNetMessage_begin();
				--��1190�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegionAttribute( 1190, 2893, "OnEvent_1190", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
		
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B		
			proxy:NotNetMessage_begin();			
				--��1191�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegion( 1191, 2893, "OnEvent_1190", HELPID_GO_TO_IN, everytime );--�n���h���͏�Ɠ���
			proxy:NotNetMessage_end();		
		end
	end	

--��4895�����{�X���S����
	proxy:AddFieldInsFilter( 805 );
	if proxy:IsCompleteEvent( 4895 ) ==false then
		proxy:OnCharacterDead(4895, 805, "OnEvent_4895", once);
	else
		proxy:EndAnimation( 1002, 1 );
	end

--��4897���{�X����BGM�Đ�&���W�b�NON��
	if proxy:IsCompleteEvent(4895) == false then
		SingleReset( proxy, 4897 );
		proxy:OnRegionIn( 4897,10000,2885,"OnEvent_4897",everytime);
	end

	
--��1122���|�����J�n��
	if proxy:IsCompleteEvent( 1122 ) == false then
		--���{�X�O�̃|�����Đ��p�Ď��ǉ�
		proxy:OnRegionJustIn( 1122 , 10000 , 2423 , "OnEvent_1122" , once );		
		
		--�e�l������
		InvalidCharactor(proxy, 200);
		InvalidCharactor(proxy, 201);
		InvalidCharactor(proxy, 202);
		InvalidCharactor(proxy, 203);
		
		--�|�����z�M�p�n���h��
		proxy:LuaCall( 1122, 1, "OnEvent_1122_3", once );
		proxy:NotNetMessage_begin();			
			--�|�����J�n�ɌĂ΂��n���h��
			proxy:LuaCall(1122, REMO_START, "OnEvent_1122_RemoStart", once);
			--�|�����I����ɌĂ΂��n���h��(�g���K�[�N�������l�p)
			proxy:LuaCall(1122, REMO_FINISH, "OnEvent_1122_RemoFinish", once);
		proxy:NotNetMessage_end();
	else	
		--�X�C�b�`���������񂾏�Ԃɂ��Ă���
		proxy:EndAnimation( 1400, 1 );
		--�����J������Ԃɂ��Ă���
		proxy:EndAnimation( 1401, 1 );
		
		--���������Ă����e�l�L����
		ValidCharactor(proxy, 200);
		ValidCharactor(proxy, 201);
		ValidCharactor(proxy, 202);
		ValidCharactor(proxy, 203);
	end	

--��1195���{�X�����̃{�X�ǁE�Δ�������
	if proxy:IsCompleteEvent( 1195 ) == false then
		proxy:InvalidSfx( 1985 , false );
	end

--���{�X�֘A�̏���������
	if proxy:IsCompleteEvent( 4895 ) ==true then
		
		--���{�X����ł���Ƃ�
		--�{�X�͂�������Ȃ�
		InvalidBackRead( proxy , 805 );
		--�������Ń{�X�����������̃t���O�𗧂Ă�
		proxy:SetEventFlag( 4896, true );
		
		--�z�X�g�v���C���[�̂݃A�C�e������C�x���g�Ɏg�p
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		
		--���@�Ǐ�����
		proxy:SetColiEnable( 1993 , false );			
		proxy:SetDrawEnable( 1993 , false );
		
		proxy:SetColiEnable( 1997 , false );			
		proxy:SetDrawEnable( 1997 , false );
		
		--SFX����
		proxy:InvalidSfx(1985,false);
		proxy:InvalidSfx(1989,false);
		
		--�v��OBJ�L����
		proxy:SetDrawEnable( 1980 , true );--�`��
		proxy:SetColiEnable( 1980 , true );--�A�^��
		--�v��OBJ2�L����
		proxy:SetDrawEnable( 1977 , true );--�`��
		proxy:SetColiEnable( 1977 , true );--�A�^��
		
		proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--���点��
		--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
		if proxy:IsCompleteEvent( 4874 ) == false then
			proxy:ValidSfx( 2532 );--SFX �L����
			proxy:ValidSfx( 2533 );--SFX �L����			
			proxy:OnDistanceActionAttribute( 4874 , 10000 , 1980 , "OnEvent_4874" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--���v�΂Ń��[�v�p�̊Ď���ǉ���
			SingleReset(proxy,4875);
			--SFX����
			proxy:InvalidSfx(2532,false);--���̗��q
			proxy:OnDistanceActionAttribute( 4875 , 10000 , 1980 , "OnEvent_4875" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end

	else
		--���{�X�����Ă���Ƃ�
		proxy:EnableLogic( 805 , false );--���W�b�NOFF�őҋ@
		
		--�|�����Đ��ł܂��\������ĂȂ��̂ŁA������
		if proxy:IsCompleteEvent( 1108 )== false then
			InvalidCharactor(proxy, 805);
			--proxy:SetDrawEnable( 1420, true );
			proxy:SetDrawEnable( 1421, false );
		end

		--�v��OBJ�̖�����
		proxy:SetColiEnable( 1980 , false );--�A�^��
		proxy:SetDrawEnable( 1980 , false );--�`��
		--�v��OBJ2�̖�����
		proxy:SetColiEnable( 1977 , false );--�A�^��
		proxy:SetDrawEnable( 1977 , false );--�`��
		
		--SFX��OFF
		proxy:InvalidSfx(2532,false);
		proxy:InvalidSfx(2533,false);
		
	end

--��1220���{�X��J�����Ή���
	--�{�X�������Ă���Ȃ�o�^
	if proxy:IsCompleteEvent(4895) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 1220 , 10000 , 2885 ,"OnEvent_1220" , everytime );
		proxy:NotNetMessage_end();
	end

-----------------------------------------------------------------------------------------
--�M�~�b�N�֘A
-----------------------------------------------------------------------------------------
--���̖���ʉ߂ł���L�����^�C�v(���̃^�C�v�̐l�����A�N�V�����{�^������������)
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

--��1094���Β��Ƀ��[�v��
	--�{���v�΃��[�v�Ȃ̂ŕs�K�v
	--proxy:OnDistanceActionAttribute( 1094, 10000, 1982, "OnEvent_1094", WarpGimmickDist_A, HELPID_GO_TO_SEKITYUU, 0, 180, ATTR_NOSESSION, everytime );

--��1160�������J���|�����Đ���
	if proxy:IsCompleteEvent( 1160 ) == false then
		proxy:OnRegionJustIn( 1160 , 10000 , 2528 , "OnEvent_1160" , once );
		
		proxy:NotNetMessage_begin();
			--�|�����J�n�t�F�[�h��ɌĂ΂��n���h��
			proxy:LuaCall(1160,REMO_START,"OnEvent_1160_RemoStart",once);
			--�|�����I����ɌĂ΂��n���h��
			proxy:LuaCall(1160,REMO_FINISH,"OnEvent_1160_RemoFinish",once);
		proxy:NotNetMessage_end();
	else
	end
	
--��1111���z�X�gPC�݂̂��ʂ����̖���
	if proxy:IsCompleteEvent( 1111 ) == true then--�z�X�g���ʉߍς�
		proxy:SetDrawEnable( 1499 , false );
		proxy:SetColiEnable( 1499 , false );
		proxy:InvalidSfx(2501,false);
	else
		--��1111�����@�Ǎ폜�����p��
		proxy:LuaCall( 1111 , 1 , "OnEvent_1111_delete_wall" , once );
		--��1111���ǂ̒��ɓ���C�x���g�����p��
		proxy:OnDistanceActionAttribute( 1111 , 10000 , 1499 , "OnEvent_1111" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
	
--��1112���z�X�gPC�݂̂��ʂ����̖���
	if proxy:IsCompleteEvent( 1112 ) == true then--�z�X�g���ʉߍς�
		proxy:SetDrawEnable( 1500 , false );
		proxy:SetColiEnable( 1500 , false );
		proxy:InvalidSfx(2502,false);
	else
		--��1112�����@�Ǎ폜�����p��
		proxy:LuaCall( 1112 , 1 , "OnEvent_1112_delete_wall" , once );
		--��1112���ǂ̒��ɓ���C�x���g�����p��
		proxy:OnDistanceActionAttribute( 1112 , 10000 , 1500 , "OnEvent_1112" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
	
--[[
--��1113���z�X�gPC�݂̂��ʂ����̖���
	if proxy:IsCompleteEvent( 1113 ) == true then--�z�X�g���ʉߍς�
		proxy:SetDrawEnable( 1501 , false );
		proxy:SetColiEnable( 1501 , false );
		proxy:InvalidSfx(2503,false);
	else
		--��1113�����@�Ǎ폜�����p��
		proxy:LuaCall( 1113 , 1 , "OnEvent_1113_delete_wall" , once );
		--��1113���ǂ̒��ɓ���C�x���g�����p��
		proxy:OnDistanceActionAttribute( 1113 , 10000 , 1501 , "OnEvent_1113" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
]]

--[[
--��1119����̍U����
	proxy:OnRegistFunc(1119, "Check_1119", "OnEvent_1119", 1, everytime );
	proxy:OnCharacterDead( 1119, 346, "OnEvent_1119_1", once );

--��1120����̍U����
	proxy:OnRegistFunc(1120, "Check_1120", "OnEvent_1120", 1, everytime );
	proxy:OnCharacterDead( 1120, 347, "OnEvent_1120_1", once );
]]

--��1054���p�b�`�ɓ˂����Ƃ������̊J����
	if proxy:IsCompleteEvent(1054) == false then
		print("���Ƃ����J��");
		proxy:EndAnimation(1410,1);
		proxy:SetEventFlag(1054, true);
	else
		print("���łɗ��Ƃ����͊J���ς�");
		proxy:EndAnimation(1410,1);
	end
	
--��1143���S�[�X�g���W�b�NON��
	--�p�b�`�ɓ˂����Ƃ����|���������Ă邩������̈�ɓ�������
	if proxy:IsCompleteEvent(1143) == true or proxy:IsCompleteEvent(1165) == true then
		proxy:EnableLogic(355, true);

	else
		proxy:EnableLogic(355,false);
		proxy:OnRegionIn(1143,10000,2513,"OnEvent_1143",once);		
		--proxy:OnRegionIn(1143,10000,2553,"OnEvent_1143",once);
		
	end
	
--��1064����̔p�����̔���
	if proxy:IsCompleteEvent( 1064 ) == false then
		proxy:OnDistanceActionPlus( 1064, 10000, 1412, "OnEvent_1064", DoorDist_A, HELPID_OPEN , 180 , DoorAngle_A, 1.2 , -1.2 , -0.1 , once );
	else
		proxy:EndAnimation( 1412, 1 );
	end


--��1074����̔p�����̗��J����(���X�C�b�`C)��
	if proxy:IsCompleteEvent( 1074 ) ==false then
	--��PC��OBJ(1413)�ɑ΂��ċ���(150)���ɂ��鎞��--
		proxy:OnPlayerDistanceInTarget( 1074, 10000, 1413, "OnEvent_1074", FloorSwitchDist_A, once );
	else
		proxy:EndAnimation( 1413, 1 );--���A�j��
		proxy:EndAnimation( 1406, 1 );--���A�j��
	end

	
--��1160�������J���|�����Đ�
	if proxy:IsCompleteEvent( 1160 ) == true then
		proxy:EndAnimation( 1409 , 1 );--�Ή���������J���A�j���I��
		--���A�j��
		proxy:EndAnimation( 1405, 1 );
	end

------------------------------------------------------------------------------------------------
--���[�����m�N����
------------------------------------------------------------------------------------------------
--��1390�`1395���[�����m_�N����
	--����Ȃ��������Ƀ��Z�b�g
	for ActionID_02 = 1390, 1398, 1 do
		SingleReset(proxy, ActionID_02);
	end
	
	local actidlist = { 1390 ,1391 ,1392 ,1393 ,1394 ,1395 ,1396 ,1397 ,1398 };
	local eneidlist = { 290 ,291 ,292 ,293 ,294 ,295 ,434 ,435 ,436 };
	local num = table.getn( actidlist );

	--�N�����鋗���Ď��̒ǉ��Ə�����
	for index = 1 ,num , 1 do
		local SkeletonID = eneidlist[index];	
		local ActionID = actidlist[index];
		if proxy:IsCompleteEvent(ActionID) == false then
			proxy:OnPlayerDistanceInTarget(ActionID, 10000, SkeletonID, "OnEvent_"..ActionID, 30.0, once);--�����m�Ƃ̋��������l(25)�ȉ�
			--�����m������
			proxy:PlayLoopAnimation(SkeletonID, 7000);--�ׂ�Ă�A�j��
			proxy:SetColiEnable(SkeletonID, false);--�A�^��OFF
		else
			if proxy:IsAlive(SkeletonID) == true then--�����Ă���Ȃ��
				proxy:StopLoopAnimation(SkeletonID);--�ׂ�Ă���A�j���̃��[�v�I��
				proxy:SetSpStayAndDamageAnimId(SkeletonID,-1,-1);--����ҋ@�A�j���̖�����
				proxy:EndAnimation(SkeletonID, 7001);--�N���オ��A�j���Đ�
				proxy:SetColiEnable(SkeletonID, true);--�A�^��ON
				proxy:EnableLogic( SkeletonID, true );--���W�b�NON
				print("��"..SkeletonID.."�́A���łɋN���ς�");
			else--���S���Ă�����
				proxy:ForceDead(SkeletonID);--�����I�Ɏ��S������
				--InvalidCharactor(proxy, SkeletonID);
				print("��"..SkeletonID.."�́A���łɎ���ł���");
			end
		end
	end

------------------------------------------------------------------------------------------------
--���E�B���I�E�B�X�v������
------------------------------------------------------------------------------------------------
--��1370�`1375���E�B���I�E�B�X�v������
	--InvalidCharactor(proxy, 340);
	--�N�����鋗���Ď��̒ǉ��Ə�����
	CreateBulletOwner(proxy,340);
	for WillOTheWispID = 1480, 1485, 1 do	--�E�B���I�E�B�X�vID
		local ActionID = WillOTheWispID - 110;
		
		--����Ȃ��������Ƀ��Z�b�g
		SingleReset(proxy, ActionID);
		
		if proxy:IsCompleteEvent(ActionID) == false then--�܂��������Ă��Ȃ�
			proxy:OnPlayerDistanceInTarget(ActionID, 10000, WillOTheWispID, "OnEvent_"..ActionID, 2.0, once);--�����Ď��i2���j�ǉ�
			proxy:SetObjSfx(WillOTheWispID, 1 , 93000 , true );	--�I�u�W�F�ɂr�e�w���Z�b�g
		else--���łɔ������Ă���
			--InvalidCharactor(proxy, WillOTheWispID);--���łɔ������Ă���̂ŏ���
			print("���E�B���I�E�B�X�v�i"..WillOTheWispID..")�́A���łɔ������Ă���");
		end
	end

-----------------------------------------------------------------------------
--��1380�`1381�����ˏo�g���b�v
-----------------------------------------------------------------------------
--[[OnEvent_1380, OnEvent_1381
	for index = 1, 2, 1 do
		local acId		= 1380 + index - 1;
		local regionId	= 2450 + index - 1;
		local objId_1	= 1430 + index - 1;
		local objId_2	= 1440 + index - 1;
		local ownerId	= 343  + index - 1;
		
		--�V���O���Ȃ烊�Z�b�g
		SingleReset(proxy, acId);
		
		--�G�𖳌��ɂ���
		InvalidCharactor(proxy, ownerId);
		
		proxy:SetBallista( objId_2, ownerId );
		if	proxy:IsCompleteEvent( acId ) == false then
			proxy:OnRegionJustIn( acId, LOCAL_PLAYER, regionId, "OnEvent_"..acId, once );
		else
			proxy:EndAnimation( objId_1, 1 );
			proxy:EndAnimation( objId_2, 1 );
		end
	end]]
	--�P�������ɂȂ����̂ŁA���ʂȃG���[���o���Ȃ��悤�ɕʋL
	local acId		= 1381;
	local regionId	= 2451;
	local objId_1	= 1431;
	local objId_2	= 1441;
	local ownerId	= 344;
	local SfxId	= 93005;--SFX��ID
	
	--�V���O���Ȃ烊�Z�b�g
	SingleReset(proxy, 1381);
	
	proxy:SetBallista( 1441, 344 );

	--�G�𖳌��ɂ���
	InvalidCharactor(proxy, ownerId);
	
	if	proxy:IsCompleteEvent( acId ) == false then
		proxy:OnRegionJustIn( acId, LOCAL_PLAYER, regionId, "OnEvent_"..acId, once );
		proxy:SetObjSfx(objId_1, 1, SfxId, false);		
	else
		proxy:EndAnimation( objId_1, 1 );
		proxy:EndAnimation( objId_2, 1 );
	end
	
--��1084���p�j�f�[�����̓o�ꁡ�n���h���o�^
	--�K�v���H
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m03_02_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m03_02_00_00", everytime );
	proxy:NotNetMessage_end();

--���p�j�f�[�����p
	if proxy:IsCompleteEvent( 1084 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m03_02_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m03_02_00_00);
	end

--------------------------------������QWC�C�x���g�֘A������--------------------------------
--���z�΂̐��쁡
	--��610���z�΂̐��삪���Ȃ���
	if proxy:IsCompleteEvent( 1234 ) == true
	   or proxy:IsSuccessQWC( 30110 ) == false then
		InvalidCharactor( proxy, 433 );
		print("QWC�������A�������͎���ł���̂ōz�΂̐���𖳌������܂�");
	end
	--��611���z�΂̐���̎��S�Ď���
	if proxy:IsCompleteEvent( 1234 ) == false then
		proxy:OnCharacterDead( 1234, 433, "OnEvent_1234", once );
		
		if proxy:IsClient() == false and proxy:IsCompleteEvent(8020) == false then
			proxy:NotNetMessage_begin();
				proxy:AddCorpseEvent( 8020 , 433 );
				proxy:LuaCall( 8020 , 0 , "OnEvent_8020",once);
			proxy:NotNetMessage_end();
		end
	end
--------------------------------������QWC�C�x���g�֘A������--------------------------------

---------------------------------------------------------------------------
--�����@�g�����e�l�֘A�C�x���g��
---------------------------------------------------------------------------
--��1310�����@�g�����S��
	SingleReset(proxy, 1310);
	if proxy:IsCompleteEvent(1310) == false then
		--[[�W�F�l���[�^�[
		proxy:EnableGeneratorSystem(1450, true);
		proxy:EnableGeneratorSystem(1451, true);
		proxy:EnableGeneratorSystem(1452, true);
		proxy:EnableGeneratorSystem(1453, true);
		proxy:EnableGeneratorSystem(1454, true);
		proxy:EnableGeneratorSystem(1455, true);
		print("�W�F�l���[�^�[�L����");]]
		
		proxy:OnCharacterDead(1310, 100, "OnEvent_1310", once);
	end
	
--��1320�����@�g�����S��
	SingleReset(proxy, 1320);
	if proxy:IsCompleteEvent(1320) == false then
		--[[�W�F�l���[�^�[
		proxy:EnableGeneratorSystem(1460, true);
		proxy:EnableGeneratorSystem(1461, true);
		proxy:EnableGeneratorSystem(1462, true);
		proxy:EnableGeneratorSystem(1463, true);
		print("�W�F�l���[�^�[�L����");]]
		
		proxy:OnCharacterDead(1320, 101, "OnEvent_1320", once);
	end
	
--��1330�����@�g�����S��
	SingleReset(proxy, 1330);
	if proxy:IsCompleteEvent(1330) == false then
		--[[�W�F�l���[�^�[
		proxy:EnableGeneratorSystem(1470, true);
		print("�W�F�l���[�^�[�L����");]]
		
		proxy:OnCharacterDead(1330, 102, "OnEvent_1330", once);
	end

--[[	
--��1151�`1156�����@�g���ړ��C�x���g��
	if proxy:IsAlive(356) == true then
	
		if proxy:IsCompleteEvent(1151) == false then
			--�����ʒu���瓮���Ė���
			proxy:OnRegionIn(1151,10000,2515,"OnEvent_1151",once);
			
		elseif proxy:IsCompleteEvent(1152) == false then
			--�̈�2522�܂ł��ǂ蒅���Ă�
			proxy:ChangeInitPosAng(356,2522);
			if proxy:IsClient() == false then
				proxy:Warp(356,2522);
			end
			proxy:OnRegionIn(1152,10000,2516,"OnEvent_1152",once);
			
		elseif proxy:IsCompleteEvent(1153) == false then
			--�̈�2523�܂ł��ǂ蒅���Ă�
			proxy:ChangeInitPosAng(356,2523);
			if proxy:IsClient() == false then
				proxy:Warp(356,2523);
			end
			proxy:OnRegionIn(1153,10000,2517,"OnEvent_1153",once);
			
		elseif proxy:IsCompleteEvent(1154) == false then
			--�̈�2524�܂ł��ǂ蒅���Ă�
			proxy:ChangeInitPosAng(356,2524);
			if proxy:IsClient() == false then
				proxy:Warp(356,2524);
			end
			proxy:OnRegionIn(1154,10000,2518,"OnEvent_1154",once);
			
		elseif proxy:IsCompleteEvent(1155) == false then
			--�̈�2525�܂ł��ǂ蒅���Ă�
			proxy:ChangeInitPosAng(356,2525);
			if proxy:IsClient() == false then
				proxy:Warp(356,2525);
			end
			proxy:OnRegionIn(1155,10000,2519,"OnEvent_1155",once);
			
		elseif proxy:IsCompleteEvent(1156) == false then
			--�̈�2526�܂ł��ǂ蒅���Ă�
			proxy:ChangeInitPosAng(356,2526);
			if proxy:IsClient() == false then
				proxy:Warp(356,2526);
			end
			proxy:OnRegionIn(1156,10000,2520,"OnEvent_1156",once);
			
		else
			--�̈�2527�܂ł��ǂ蒅���Ă���
			proxy:ChangeInitPosAng(356,2527);
			if proxy:IsClient() == false then
				proxy:Warp(356,2527);
			end
			
		end
		--���̒n�_�֌������ׂ̃n���h��
		proxy:LuaCall(1151,1,"OnEvent_1151_ToMove",once);
		proxy:LuaCall(1152,1,"OnEvent_1152_ToMove",once);
		proxy:LuaCall(1153,1,"OnEvent_1153_ToMove",once);
		proxy:LuaCall(1154,1,"OnEvent_1154_ToMove",once);
		proxy:LuaCall(1155,1,"OnEvent_1155_ToMove",once);
		proxy:LuaCall(1156,1,"OnEvent_1156_ToMove",once);
		--�t���O�����p�̃n���h��
		proxy:LuaCall(1151,2,"OnEvent_1151_flag",once);
		proxy:LuaCall(1152,2,"OnEvent_1152_flag",once);
		proxy:LuaCall(1153,2,"OnEvent_1153_flag",once);
		proxy:LuaCall(1154,2,"OnEvent_1154_flag",once);
		proxy:LuaCall(1155,2,"OnEvent_1155_flag",once);
		proxy:LuaCall(1156,2,"OnEvent_1156_flag",once);
	end

--��1173�����@�g�����S��
	SingleReset(proxy,1173);
	if proxy:IsCompleteEvent(1173) == false then
		proxy:OnCharacterDead(1173,357,"OnEvent_1173",once);
	end
	
--��1174�����@�g�����S��
	SingleReset(proxy,1174);
	if proxy:IsCompleteEvent(1174) == false then
		proxy:OnCharacterDead(1174,356,"OnEvent_1174",once);
	end
	
--��1175�����@�g�����S��
	SingleReset(proxy,1175);
	if proxy:IsCompleteEvent(1175) == false then
		proxy:OnCharacterDead(1175,358,"OnEvent_1175",once);
	end
	
--��1176�����@�g�����S��
	SingleReset(proxy,1176);
	if proxy:IsCompleteEvent(1176) == false then
		proxy:OnCharacterDead(1176,359,"OnEvent_1176",once);
	end


--��1123���e�l�s�i��
	--�V���O���Ȃ�t���OOFF
	SingleReset(proxy,1123);	

	--�s�i�I����ĂȂ��ā@�i�����؂�ĂȂ��Ȃ�
	if proxy:IsCompleteEvent(1123) == false and proxy:IsCompleteEvent(1132) == false then		
		proxy:OnRegionIn(1123,10000,2512,"OnEvent_1123",once);		
		--�e�lA�o�^
		proxy:LuaCall(1125,0,"OnEvent_1125",once);
		proxy:LuaCall(1126,0,"OnEvent_1126",once);			
		--�e�lB�o�^
		proxy:LuaCall(1127,0,"OnEvent_1127",once);
		proxy:LuaCall(1128,0,"OnEvent_1128",once);
		--�e�lC�o�^
		proxy:LuaCall(1129,0,"OnEvent_1129",once);
		proxy:LuaCall(1130,0,"OnEvent_1130",once);
		proxy:LuaCall(1131,0,"OnEvent_1131",once);		
		--�e�lD�o�^
		proxy:LuaCall(1132,0,"OnEvent_1132",once);
		proxy:LuaCall(1133,0,"OnEvent_1133",once);
		proxy:LuaCall(1134,0,"OnEvent_1134",once);		
		--�e�lE�o�^
		proxy:LuaCall(1135,0,"OnEvent_1135",once);
		proxy:LuaCall(1136,0,"OnEvent_1136",once);
		proxy:LuaCall(1137,0,"OnEvent_1137",once);
		--�e�lF�o�^
		proxy:LuaCall(1138,0,"OnEvent_1138",once);
		proxy:LuaCall(1139,0,"OnEvent_1139",once);
		proxy:LuaCall(1140,0,"OnEvent_1140",once);
	end
	
	--�V���O�����Z�b�g
	SingleReset(proxy,1132);	
	
	if proxy:IsCompleteEvent(1123) == false and proxy:IsCompleteEvent(1132) == false then
		proxy:OnRegionIn(1132,10000,2424,"OnEvent_1132",once);
	end

--��1177�������e�l���S�Ď��F�W�F�l���[�^�N����
	SingleReset(proxy,1177);
	if proxy:IsCompleteEvent(1177) == false then
		proxy:OnCharacterDead(1177,360,"OnEvent_1177_360",once);
		proxy:OnCharacterDead(1177,361,"OnEvent_1177_361",once);
		proxy:OnCharacterDead(1177,362,"OnEvent_1177_362",once);
		proxy:OnCharacterDead(1177,363,"OnEvent_1177_363",once);
		proxy:OnCharacterDead(1177,364,"OnEvent_1177_364",once);
	else
		if proxy:IsCompleteEvent(1173) == false then
			--�W�F�l���[�^�N��
			proxy:EnableGeneratorSystem(2532,true);
			proxy:OnRegistFunc( 1181,"Check_1181","OnEvent_1181",1,once);
		end
	end

--��1178���̈�Ď�:�W�F�l���[�^�N����
	SingleReset(proxy,1178);
	if proxy:IsCompleteEvent(1178) == false then
		proxy:OnRegionIn(1178,10000,2542,"OnEvent_1178",once);
	else
		--���ɔ������Ă������~���Ă���̂��𒲂ׂĂ���N��������
		if proxy:IsCompleteEvent(1174) == false then
			--�W�F�l���[�^�N��
			if proxy:IsCompleteEvent(1151) == false then
				proxy:EnableGeneratorSystem(2533,true);
			elseif proxy:IsCompleteEvent(1152) == false then
				proxy:EnableGeneratorSystem(2534,true);
			elseif proxy:IsCompleteEvent(1153) == false then
				proxy:EnableGeneratorSystem(2535,true);
			elseif proxy:IsCompleteEvent(1154) == false then
				proxy:EnableGeneratorSystem(2536,true);
			elseif proxy:IsCompleteEvent(1155) == false then
				proxy:EnableGeneratorSystem(2537,true);
			elseif proxy:IsCompleteEvent(1156) == false then
				proxy:EnableGeneratorSystem(2538,true);
			else
				proxy:EnableGeneratorSystem(2539,true);
			end
			proxy:OnRegistFunc( 1182,"Check_1182","OnEvent_1182",0,once);
		end
	end
	
--��1179���̈�Ď�:�W�F�l���[�^�N����
	SingleReset(proxy,1179);
	if proxy:IsCompleteEvent(1179) == false then
		proxy:OnRegionIn(1179,10000,2543,"OnEvent_1179",once);
	else
		if proxy:IsCompleteEvent(1175) == false then
			--�W�F�l���[�^�N��
			proxy:EnableGeneratorSystem(2540,true);
			proxy:OnRegistFunc(1183,"Check_1183","OnEvent_1183",1,once);
		end
	end
	
--��1180���̈�Ď�:�W�F�l���[�^�N����
	SingleReset(proxy,1180);
	if proxy:IsCompleteEvent(1180) == false then
		proxy:OnRegionIn(1180,10000,2544,"OnEvent_1180",once);
	else
		if proxy:IsCompleteEvent(1176) == false then
			--�W�F�l���[�^�N��
			proxy:EnableGeneratorSystem(2541,true);
			proxy:OnRegistFunc(1184,"Check_1184","OnEvent_1184",1,once);
		end
	end
]]

--��8085���ÍԂɗ����t���O�𗧂Ă遡
	proxy:SetEventFlag(8085, true);

-----------------------------------------------------------------------------------------
--NPC�֘A
-----------------------------------------------------------------------------------------
	--�t���O�����ăX�L����NPC��Ԃ�������
	SetFirstNpcStateFlag( proxy, param, urubain_flag_list, URUBAIN_STATE_HELP );
	
	if proxy:IsCompleteEvent( URUBAIN_STATE_HELP ) == true then
		proxy:SetEventFlag( 1161, true );
	end


	--���S���Ă��Ȃ��Ƃ�
	if proxy:IsCompleteEvent( URUBAIN_STATE_DEAD ) == false then
		--�G�΂��Ă��Ȃ��Ƃ�
		if proxy:IsCompleteEvent( URUBAIN_STATE_ANGRY ) == false then			
			
			--��1250���X�L����NPC�������ĂȂ�
			if proxy:IsCompleteEvent(1250) == false then
				--���S�[�X�g�̊Ď�
				proxy:OnCharacterDead(1250,355,"OnEvent_1250",once);
			else--�����Ă�
				InvalidBackRead(proxy,355);
			end
			
			--�E���x�C������
			if proxy:IsCompleteEvent( 1157 ) == false then
				proxy:LuaCall( 1157 , 0 , "OnEvent_1157",once);
			end
			
			--��1158���y�X�L����NPC�zNPC���G�ɂȂ��ĂȂ���
			if proxy:IsCompleteEvent( 1158 ) == false then
				--proxy:OnCharacterTotalDamage( 1158, 635, 10000,TOTALDAMAGE_SKILLSHOP, "OnEvent_1158", once );
				proxy:OnCharacterTotalRateDamage( 1158, 635, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1158", once );
			end				
			
		else--�G�΂��Ă�����
			proxy:EnableLogic( 635, true );
			SetNpcStateFlag(proxy,param,urubain_flag_list,URUBAIN_STATE_ANGRY);
			
			proxy:SetTeamType( 635, TEAM_TYPE_AngryFriend );
			
			proxy:SetEventFlag( 1162, true );
		end
		--��1159���y�X�L����NPC�zNPC�����񂾁�
		if proxy:IsCompleteEvent( 1159 ) == false then
			proxy:OnCharacterDead( 1159, 635, "OnEvent_1159", once );		
		end
	else
		print("�X�L����NPC���S");		
		--����ł���̂Ŗ�����		
		proxy:ForceUpdateNextFrame(635);
		InvalidBackRead(proxy, 635 );		
		proxy:SetEventFlag( 1163, true );
	end
	
	--�X�L�������ӂŐΒ��Ɉړ��ɂȂ�̂ŁE�E�E�L����������
	if proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR ) == true then
		InvalidBackRead(proxy,635);
	end

------------------------------------
--�t���O�����ăo�b�`NPC��Ԃ�������
------------------------------------
	SetFirstNpcStateFlag( proxy, param, batti_flag_list, BATTI_NOT_STAY );--��Ԃ��ݒ肳��Ă��Ȃ���΁A�ǂ��ɂ����Ȃ���
	
	--�p�b�`�̍X�V�����̓z�X�g���Ǘ�
	if proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork(636);
	end
	
--��1193���p�b�`���A�C�e���������(��b����̌Ăяo��)
	proxy:NotNetMessage_begin();
		proxy:LuaCall(1193, 0, "OnEvent_1193", once);
	proxy:NotNetMessage_end();
	
--��1192���p�b�`�C�x���g�Ď�(���߂ČÍԂɗ����ꍇ)
	--���Ƃ��|�������I����ĂȂ��Ȃ�
	if proxy:IsCompleteEvent( 1165 ) == false then
		--�o�b�`���ǂ��ɂ����Ȃ����o���������Ȃ��
		if	proxy:IsCompleteEvent( BATTI_NOT_STAY ) 	== true or
			proxy:IsCompleteEvent( BATTI_RESERVE_M1 )	== true	then
			proxy:OnRegionJustIn( 1192, 10000, 2540, "OnEvent_1192", once);--�̈�ւ̐N���Ď��ǉ�
		end
	end

--��1165��
	if proxy:IsCompleteEvent( 1165 ) == false then--�̈�Ď����ǉ�����Ă��Ȃ�������(�Ȃ��ŏ�Ԕ���)
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionJustIn(1165,10000,2530,"OnEvent_1165",everytime);--�˂����Ƃ��A�N�V�����Ď��ǉ�
			proxy:NotNetMessage_end();
		end
		
		proxy:LuaCall(1165, 1, "OnEvent_1165_0", once);
		
		proxy:NotNetMessage_begin();
			--�|�����J�n�ɌĂ΂��n���h��
			proxy:LuaCall(1165, REMO_START, "OnEvent_1165_RemoStart", once);
			--�|�����I����ɌĂ΂��n���h��(�g���K�[�N�������l�p)
			proxy:LuaCall(1165, REMO_FINISH, "OnEvent_1165_RemoFinish", once);
		proxy:NotNetMessage_end();
	end

--��1166���˂����Ƃ��ēG��
	if proxy:IsCompleteEvent( 1166 ) == false then--�̈�Ď����ǉ�����Ă��Ȃ�������(�Ȃ��ŏ�Ԕ���)
		proxy:OnRegionJustIn(1165,636,2410,"OnEvent_1166",everytime);
		
	end
	--�p�b�`�̎��S�Ď��ƓG�ΊĎ�
	if	proxy:IsCompleteEvent( BATTI_ANGRY ) == false then--�G�΂ł͂Ȃ�
		--proxy:OnCharacterTotalDamage( 1167, 636, 10000,TOTALDAMAGE_BATTI, "OnEvent_1167", once );--�_���[�W�Ď��ǉ�
		proxy:OnCharacterTotalRateDamage( 1167, 636, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1167", once );
	end
	--��L�̏�Ԃ̎��ɁA���S�Ď��ǉ�
	proxy:OnCharacterDead( 1168, 636, "OnEvent_1168", once );
	
	--�˂����Ƃ���(�Í�)�������Ȃ��
	if	proxy:IsCompleteEvent( BATTI_PUSHING )		== true or
		proxy:IsCompleteEvent( BATTI_SATISFIED )	== true then
			
		proxy:SetEventFlag( 1169, true );
		
	--�G�΂��Ă���Ȃ��
	elseif	proxy:IsCompleteEvent( BATTI_ANGRY )		== true then
		proxy:EnableLogic( 636 , true );--���W�b�N�n�m
		--SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_ANGRY);--�G�΂ɂ���
		proxy:SetTeamType( 636, TEAM_TYPE_AngryFriend );--�`�[���^�C�v��ύX
		proxy:SetEventFlag( 1171, 1 );
	--�u�ǂ��ɂ����Ȃ��v�������́u�o���������v�̎��͗̈�ɓ��������ɗL���ɂ���̂ŁA��悸������
	elseif	proxy:IsCompleteEvent( BATTI_RESERVE_M1 )	== true or
			proxy:IsCompleteEvent( BATTI_NOT_STAY )		== true then
		InvalidCharactor( proxy, 636 );--��悸������(�̈�ɓ��������ɗL���ɂ���)
	
	--��L�̂ǂ�ɂ����Ă͂܂�Ȃ����(�u�ǂ��ɂ����Ȃ��v�������́u�o���������v�łȂ��̂͐�Ώ���)
	elseif	proxy:IsCompleteEvent( BATTI_NOT_STAY )		== false and
			proxy:IsCompleteEvent( BATTI_RESERVE_M1 )	== false then 
		InvalidBackRead(proxy, 636);--������
		proxy:SetEventFlag( 1170, false );
	
	end
--------------------------------������QWC�C�x���g�֘A������--------------------------------
--���u���b�N�S�[�X�g��
	--��1233���u���b�N�S�[�X�g�����Ȃ���
	--QWC����(30100)���������Ă��Ȃ��Ƃ���
	if proxy:IsSuccessQWC( 30100 ) == false then
		--�u���b�N�S�[�X�g�����Ȃ�����
		InvalidCharactor( proxy, 434 );
		InvalidCharactor( proxy, 435 );
		InvalidCharactor( proxy, 436 );
		print("ValidCharactor BlackGhost Failed!!");
	end
--------------------------------������QWC�C�x���g�֘A������--------------------------------
--[[2008.06.10 toyohide ��Ԕ�����@m03_01�Ɉړ�
	--���@�҂��G�΂��Ă���
	if proxy:IsCompleteEvent( 1185 ) == true and proxy:IsCompleteEvent( 1186 ) == false then
		proxy:EnableLogic( 678 , true );
		SetNpcStateFlag(proxy,param,STEAL_SHOP_Flag_list,STEAL_SHOP_HOSTILE);
		proxy:SetTeamType( 678, TEAM_TYPE_AngryFriend );
		proxy:SetEventFlag( 1187, true );
	end

	--���@�҂����S���Ă���̂ŏ�����
	if proxy:IsCompleteEvent( 1186 ) == true then
		proxy:EnableLogic( 678 , false );
		SetNpcStateFlag(proxy,param,STEAL_SHOP_Flag_list,STEAL_SHOP_DEAD);
		InvalidBackRead( proxy , 678 );
		proxy:SetEventFlag( 1188, true );
	end

--��160�����@��NPC���G�ɂȂ遡
	if proxy:IsCompleteEvent(1185) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 1185 , 0 , "OnEvent_1185" , everytime );
		proxy:NotNetMessage_end();
		proxy:OnCharacterTotalDamage( 1185, 678, 10000, STEAL_SHOP_TOTALDAMAGE, "OnEvent_1185_1", once );	
	end

--��161�����@��NPC���S��
	if proxy:IsCompleteEvent( 1186 ) == false then
		proxy:OnCharacterDead( 1186 , 678 , "OnEvent_1186" , once );
	end
]]

--�����g�J�Q�����C�x���g
	RegistTokage(proxy,1040,253,9);	
	
--��15500�������A�C�e���擾�Ď����n���h���̓O���[�o���ɒ�`
	if proxy:IsCompleteEvent( 15500 ) == false then
		proxy:AddCorpseEvent( 15500 , 355 );--������NPC		
	end
	
--��1400�����@�̕ǔj��3��
	SingleReset(proxy,1400);
	if proxy:IsCompleteEvent( 1400 ) == false then
		--���A
		proxy:RestorePiece( 1520 );
		proxy:OnObjectDestroy( 1400 , 1520 ,"OnEvent_1400",once);
	else
		proxy:ReconstructBreak( 1520,1);
	end

--��999999���t���[���x��̏����������C�x���g�𔭍s��
	proxy:NotNetMessage_begin();
		--��0�b�づ--
		proxy:OnKeyTime2( 999992, "Second_Initialize_m03_02_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
--------------------------------------------------------------------------------------
--�������ς݁@���������@��Initialize_m03_02_00_00
--------------------------------------------------------------------------------------
	print("Initialize_m03_02_00_00 end");
end


--------------------------------------------------------------------------------------
--Initialize����Ă΂��A1�t���[���x��̏�����������999999
--------------------------------------------------------------------------------------
--��999999���ꕔ�AInit�ł͏����ł��Ȃ��̂ŁA�c���Ă���
function Second_Initialize_m03_02_00_00(proxy, param)
	print("Second_Initialize_m03_02_00_00 begin");

--------------------------------������QWC�C�x���g�֘A������--------------------------------
--��1200��QWC�C�x���g�Łu���v���聡
	if	proxy:IsSuccessQWC(30140) == true then--QWC�����𖞂������ꍇ
		print("QWC�u�����v�� �L��");
		--�n�ʂɗ����ĂȂ����́u���v
		proxy:SetDrawEnable( 1511 , false );
		proxy:EnableObjTreasure( 1511, false );
		--�n�ʂɗ����Ă�����́u���v
		proxy:SetDrawEnable( 11280, true );
		proxy:EnableObjTreasure( 11280, true );
		
		proxy:SetEventFlag(1200, true);
		
	else--QWC��������������Ă��Ȃ��ꍇ
		print("QWC�u�s�����v�� ����");
		--�n�ʂɗ����ĂȂ��ق��́u���v
		proxy:SetDrawEnable( 1511, true );
		proxy:EnableObjTreasure( 1511, true );
		--�n�ʂɗ����Ă���ق��́u���v
		proxy:SetDrawEnable( 11280 , false );
		proxy:EnableObjTreasure( 11280 , false );
		
		proxy:SetEventFlag(1200, false);
		
	end
--------------------------------������QWC�C�x���g�֘A������--------------------------------

	print("Second_Initialize_m03_02_00_00 end");
end

--------------------------------------------------------------------------------------
--��1111���z�X�gPC�݂̂��ʂ����̖���
--------------------------------------------------------------------------------------
--��1111_delete_wall�����@�Ǎ폜�����p��
function OnEvent_1111_delete_wall(proxy , param)
	print("OnEvent_1111_delete_wall begin");
	
	proxy:SetDrawEnable( 1499 , false );--���@�Ǖ`��OFF
	proxy:SetColiEnable( 1499 , false );--���@�Ǔ�����OFF
	proxy:SetObjDeactivate( 1499 , true );--�f�A�N�e�B�u
	proxy:InvalidSfx( 2501 , true );--SFX OFF
	proxy:DeleteEvent( 1111 );--�S�v���C���[���̊Ď�������͂��B
	
	print("OnEvent_1111_delete_wall end");
end

--��1111���C�x���g�����p��
function OnEvent_1111(proxy , param)
	print("OnEvent_1111 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 1111 ) == true then
		print("OnEvent_1111 end");
		return;
	end
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 1111 , 1 );
		print("OnEvent_1111 end");
		return;
	end
	
	--�_�~�|���փ��[�v
	proxy:WarpDmy( 10000 , 1499 , 191 );
	
	proxy:NotNetMessage_begin();
		--��1111_1�������A�j���I����
		--proxy:OnChrAnimEnd( 1111 , 10000 , ANIMEID_WALK , "OnEvent_1111_1" , once );
		proxy:LuaCallStart( 1111 , 1 );--���̖��폜����
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1111 , 1 );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1111 end");
end

--��1111_1�������A�j���I����
function OnEvent_1111_1(proxy , param)
	print("OnEvent_1111_1 begin");
	
	proxy:LuaCallStart( 1111 , 1 );--���̖��폜����
	
	print("OnEvent_1111_1 end");
end


--------------------------------------------------------------------------------------
--��1112���z�X�gPC�݂̂��ʂ����̖���
--------------------------------------------------------------------------------------
--��1112_delete_wall�����@�Ǎ폜�����p��
function OnEvent_1112_delete_wall(proxy , param)
	print("OnEvent_1112_delete_wall begin");
	
	proxy:SetDrawEnable( 1500 , false );--���@�Ǖ`��OFF
	proxy:SetColiEnable( 1500 , false );--���@�Ǔ�����OFF
	proxy:SetObjDeactivate( 1500 , true );--�f�A�N�e�B�u
	proxy:InvalidSfx( 2502 , true );--SFX OFF
	proxy:DeleteEvent( 1112 );--�S�v���C���[���̊Ď�������͂��B
	
	print("OnEvent_1112_delete_wall end");
end

--��1112���C�x���g�����p��
function OnEvent_1112(proxy , param)
	print("OnEvent_1112 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 1112 ) == true then
		print("OnEvent_1112 end");
		return;
	end
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 1112 , 1 );
		print("OnEvent_1112 end");
		return;
	end
	
	--�_�~�|���փ��[�v
	proxy:WarpDmy( 10000 , 1500 , 191 );
	
	proxy:NotNetMessage_begin();
		--��1111_1�������A�j���I����
		--proxy:OnChrAnimEnd( 1112 , 10000 , ANIMEID_WALK , "OnEvent_1112_1" , once );
		proxy:LuaCallStart( 1112 , 1 );--���̖��폜����
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1112 , 1 );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1112 end");
end

--��1112_1�������A�j���I����
function OnEvent_1112_1(proxy , param)
	print("OnEvent_1112_1 begin");
	
	proxy:LuaCallStart( 1112 , 1 );--���̖��폜����
	
	print("OnEvent_1112_1 end");
end

--[[
--------------------------------------------------------------------------------------
--��1113���z�X�gPC�݂̂��ʂ����̖���
--------------------------------------------------------------------------------------
--��1113_delete_wall�����@�Ǎ폜�����p��
function OnEvent_1113_delete_wall(proxy , param)
	print("OnEvent_1113_delete_wall begin");
	
	proxy:SetDrawEnable( 1501 , false );--���@�Ǖ`��OFF
	proxy:SetColiEnable( 1501 , false );--���@�Ǔ�����OFF
	proxy:DeleteEvent( 1113 );--�S�v���C���[���̊Ď�������͂��B
	
	print("OnEvent_1113_delete_wall end");
end

--��1113���C�x���g�����p��
function OnEvent_1113(proxy , param)
	print("OnEvent_1113 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 1113 ) == true then
		print("OnEvent_1113 end");
		return;
	end
	
	proxy:InvalidSfx( 2503 , true );--SFX OFF
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 1113 , 1 );
		print("OnEvent_1113 end");
		return;
	end
	
	--�_�~�|���փ��[�v
	proxy:WarpDmy( 10000 , 1501 , 191 );
	
	proxy:NotNetMessage_begin();
		--��1111_1�������A�j���I����
		proxy:OnChrAnimEnd( 1113 , 10000 , ANIMEID_WALK , "OnEvent_1113_1" , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1113 , 1 );
	
	print("OnEvent_1113 end");
end

--��1113_1�������A�j���I����
function OnEvent_1113_1(proxy , param)
	print("OnEvent_1113_1 begin");
	
	proxy:LuaCallStart( 1113 , 1 );--���̖��폜����
	
	print("OnEvent_1113_1 end");
end
]]

--------------------------------------------------------------------------------------
--��4875���Β��Ƀ��[�v�Ď���
--------------------------------------------------------------------------------------
function OnEvent_4875(proxy,param)	
	print("OnEvent_4875 begin");
	
	
	--�Z�b�V�������ł͂Ȃ����H
	if proxy:IsSession() == false then
		proxy:RepeatMessage_begin();
			--��70_1���I�����j���[�̊Ď���
			proxy:OnSelectMenu(4875, "OnEvent_4875_1", 10010710, 0, 2, 1980, 2, once);			
		proxy:RepeatMessage_end();
	else
		--�Z�b�V�������Ȃ�ŕ\��
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010720, 1);
		--proxy:ShowGenDialog(10010720,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1980, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end

	print("OnEvent_4875 end");
end

--��4875_1���I�����j���[�̊Ď���
function OnEvent_4875_1(proxy,param)	
	print("OnEvent_4875_1 begin");	
	
	if proxy:IsSession() == false then
		if param:IsNetMessage() == true then
			proxy:PlayAnimation(10001+param:GetPlayID(),8305);
			print("OnEvent_4875_1 end");
			return;
		end
			
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1980 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd( 4875 , 10000 , 8283 , "OnEvent_4875_2",once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(4875,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_4875_1 end");
end

--��4875_2���Β��Ƀ��[�v��
function OnEvent_4875_2(proxy,param)	
	print("OnEvent_4875_2 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ�
	--�Β��֖߂��Ă�������̃t���O�𗧂Ă�
	proxy:SetEventFlag(8083, true);
	
	--���S�񕜗v��
	proxy:RequestFullRecover();
	--�Íԗv�΂ɖ߂�
	proxy:WarpNextStage( 1, 0, 0, 0, 1007);	
	print("OnEvent_4875_2 end");
end


--------------------------------------------------------------------------------------
--��4874���\�E�����聡
--------------------------------------------------------------------------------------
function OnEvent_4874(proxy, param)
	print("OnEvent_4874 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--�V�����A�j�� 
		print("OnEvent_4874 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 4874, "OnEvent_4874_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4874 end");
end


--��4874_1���A�C�e���擾��
function OnEvent_4874_1(proxy, param)
	print("OnEvent_4874_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10232�Q��
	proxy:GetRateItem(10231);	
	--�A�C�e���擾�֐�--�p�����[�^10274�Q��
	proxy:GetRateItem(10274);	
	--�A�C�e���擾�֐�--�p�����[�^10275�Q��
	proxy:GetRateItem(10275);	
	--�A�C�e���擾�֐�--�p�����[�^10276�Q��
	proxy:GetRateItem(10276);	
	--�A�C�e���擾�֐�--�p�����[�^10277�Q��
	proxy:GetRateItem(10277);	
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 4874, 1 );
	
	--�󔠃V�F�[�_�[�͏����܂���
	--proxy:TreasureDispModeChange( 1980 , false );

	--SFX��������
	proxy:InvalidSfx( 2532 , true );--���̗��q
	--proxy:InvalidSfx( 2533 , true );
		
	--���v�΂Ń��[�v�p�̊Ď���ǉ���
	proxy:OnDistanceActionAttribute( 4875 , 10000 , 1980 , "OnEvent_4875" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_4874_1 end");
end

--------------------------------------------------------------------------------------
--���{�X�|�����Đ���1108
--------------------------------------------------------------------------------------
--�����̈�̒��ɓ�����
function OnEvent_1108(proxy, param)
	--�I����ĂȂ����H�@�����Ă��邩�H
	if proxy:IsCompleteEvent(1108) == false then
		if proxy:IsAlive( 10000 ) == true then
			print("OnEvent_1108 begin");
			--�|�����z�M
			proxy:LuaCallStart( 1108 , 1 );		
			print("OnEvent_1108 end");
		end
	end
end

--�|�����z�M
function OnEvent_1108_1(proxy,param)
	print("OnEvent_1108_1 begin");
	--�|�����Đ��J�n
	proxy:RequestRemo(30201,REMO_FLAG,1108,1);
	proxy:SetEventFlag( 1108 , 1 );--�|�����Đ��I���t���OON	
	--proxy:SetDrawEnable( 1420, false );--�ǂɂ߂肱�ރ{�XOBJ������
	print("OnEvent_1108_1 end");
end

--��1108_RemoStart���|�����J�n �t�F�[�h�A�E�g������
function OnEvent_1108_RemoStart(proxy,param)
	print( "OnEvent_1108_RemoStart begin" );
	print( "OnEvent_1108_RemoStart end" );
end

--��1108_RemoFinish���|�����Đ��I���ち
function OnEvent_1108_RemoFinish(proxy , param)
	print( "OnEvent_1108_RemoFinish begin" );	
	
	proxy:PlayAnimation( 1407 , 1 );--�����ւ��ރA�j�����I��
	ValidCharactor( proxy, 805 );--�{�X��L����
	
	proxy:NotNetMessage_begin();
		--�������J���A�j���Đ��I����
		proxy:OnKeyTime2( 1195, "OnEvent_1195", 0, 0, 0, once );
	proxy:NotNetMessage_end();	
	
	proxy:SetEventFlag( 4880 , true);
	
	print( "OnEvent_1108_RemoFinish end" );
end


--��1195�����J���A�j���Đ��I����
function OnEvent_1195(proxy , param)
	print("OnEvent_1195 begin");
	
	proxy:ValidSfx( 1985 );--�{�X�Ǘp��SFX��L����
	
	--���ɗ����Ă銢�I�̕\��
	proxy:SetDrawEnable( 1421, true );
	proxy:SetColiEnable( 1421, true );
	
	proxy:SetEventFlag(1195, true);
	
	print("OnEvent_1195 end");
end


--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ��遡1190
--------------------------------------------------------------------------------------
--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫
--��1190�����{�X�����ւ̔����J����
function OnEvent_1190(proxy,param)
	print("OnEvent_1190 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_1190 end");
		return;
	end
	
	--�N���C�A���g�ցA�{�X�����j�~���s��ʒm
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 1191 , 1 );--����A�j���̓����Đ�
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--���d�N���V�X�e��ID���^�C���A�E�g��ݒ肵��ON�ɂ���
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1190 end");
end


--����A�j���̓����Đ�(ID����)
function OnEvent_1190_1(proxy,param)
	print("OnEvent_1190_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ��𓯊�
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2889 );
		else
			proxy:LockSession();--���[�������b�N���܂��I
			--����A�j���Đ����s���A���̏I������OnEvent_1190_2�𔭍s����
			proxy:OnTurnCharactorEnd( 1191, 10000, 2889, "OnEvent_1190_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();	
	
	print("OnEvent_1190_1 end");
end

--����A�j���̓����Đ��I����
function OnEvent_1190_2(proxy,param)
	print("OnEvent_1190_2 begin");
	
	--�����p�����A�j���Đ�
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1191, 10000, ANIMEID_WALK, "OnEvent_1190_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
		
	print("OnEvent_1190_2 end");
end

--�����A�j���̓����Đ��I����
function OnEvent_1190_3(proxy,param)
	print("OnEvent_1190_3 begin");

	--�ŏ��̐l���{�X�����̒��ɓ���I����Ă�����A���ɔz�M����Ă���͂��Ȃ̂ŁA����������Ȃ��n���h��
	if proxy:IsCompleteEvent( 1190 ) == false then
		proxy:LuaCallStart( 1191 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCallStart( 4045 , 1 );	--�N���C�A���g�ցA�{�X�����ɓ����悤�ɂȂ������Ƃ�ʒm
		Lua_MultiDoping(proxy,805);--�}���`�v���C�h�[�s���O
		proxy:LuaCallStart( 1191 , 6 );--�t���O�Z�b�g(�����p)
	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�)
	if proxy:IsClient() == false then
		proxy:ResetThink( 805 );
	end
	
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE,false);	
	print("OnEvent_1190_3 end");
end


--��1190 2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
function OnEvent_1190_GO_TO_IN(proxy, param)
	print("OnEvent_1190_GO_TO_IN begin");	
	proxy:NotNetMessage_begin();
		--��593�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���--�n���h���� OnEvent_1190
		proxy:OnPlayerActionInRegion( 1191, 2893, "OnEvent_1190", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	print("OnEvent_1190_GO_TO_IN end");
end


--��1190 �t���O�Z�b�g(�����p)
function OnEvent_1190_flag_set(proxy, param)
	print("OnEvent_1190_flag_set begin");		
	proxy:SetEventFlag( 1190 , 1 );
	proxy:DeleteEvent( 1190 );
	print("OnEvent_1190_flag_set end");
end

--------------------------------------------------------------------------------------
--���{�X���S��4895
--------------------------------------------------------------------------------------
function OnEvent_4895(proxy, param)
	print("OnEvent_4895begin");
	
	proxy:NotNetMessage_begin();
		
		--��4895_1��1�b�o�߁�
		proxy:OnKeyTime2( 4895, "OnEvent_4895_1", 0, 0, 0, once);
		--��4895_2��2�b�o�߁�
		proxy:OnKeyTime2( 4895, "OnEvent_4895_2", 0, 0, 1, once);
		
		--�}���`���U�Ď�
		proxy:OnRegistFunc( 4895 ,"Check_4895_PT","OnEvent_4895_PT",0,once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 4895, 1 );--�{�X�̎��S�L�^�p
	proxy:SetEventFlag( 4870, 1 );--�V�d�l�̃t���O�����Ă�
	
	print("OnEvent_4895 end");
end


----------------------------------------------------------------------------

--��4895_1�����{�X�̎��S:���{�X���S��1�b��
function OnEvent_4895_1(proxy, param)
	print("OnEvent_4895_1 begin");
	
	--�{�X��|���������X�V(���ɂ���ăt���O�𗧂Ă�)
	GetBossFlagCount( proxy, param );
	
--�A�C�e������֘A-------
	
	--�z�X�g�v���C���[�̂݃A�C�e������C�x���g�Ɏg�p
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

	--�v��OBJ�L����
	proxy:SetDrawEnable( 1980 , true );--�`��
	proxy:SetColiEnable( 1980 , true );--�A�^��
	--�v��OBJ2�L����
	proxy:SetDrawEnable( 1977 , true );--�`��
	proxy:SetColiEnable( 1977 , true );--�A�^��
	
	--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
	if proxy:IsCompleteEvent( 4874 ) == false then
		proxy:ValidSfx( 2532 );--SFX �L����
		proxy:ValidSfx( 2533 );--SFX �L����
		proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--���点��
		proxy:OnDistanceActionAttribute( 4874 , 10000 , 1980 , "OnEvent_4874" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end

	--���g���t�B�[�擾���聥
	Lua_RequestUnlockTrophy(proxy, 31);
	
------------------------

	
	--[[���{�X�����O�̈ړ������C�x���g���폜
	proxy:DeleteEvent( 1542 );--��l�ڂ�����Ƃ��p
	proxy:DeleteEvent( 1543 );--��l�ڈȍ~������Ƃ��p
	proxy:DeleteEvent( 4999 );--�{�X�퓬�J�n�p]]
	
	print("OnEvent_4895_1 end");
end


--��4895_2�����{�X�̎��S:���{�X���S��1�b��
function OnEvent_4895_2(proxy, param)
	print("OnEvent_4895_2 begin");

	--�{�X��p��BGM��~	
	proxy:StopPointSE( 2 );		
	
	--�u���b�N�N���A������
	--proxy:LuaCallStart( 4040, 1 );
	--�V�u���b�N�N���A������
	proxy:CustomLuaCallStart( 4050, 805);
	--�����g�J�Q���Z�b�g
	ResetTokage(proxy);
	
	--[[�Z�b�V�������U���̖��@�ǐ؂�ւ������̓O���[�o��?]]
	
	print("OnEvent_4895_2 end");
end

--�}���`���U�Ď�
function Check_4895_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--�}���`����Ȃ�
function OnEvent_4895_PT(proxy,param)
	print("OnEvent_4895_PT begin");
	proxy:PlayAnimation( 1408 , 1 );--���̃A�j���𗬂�
	
	--���{�X�����̑O��̖��@�ǂ�������(�S�v���C���[)
	proxy:SetColiEnable( 1997 , false );
	proxy:SetColiEnable( 1993 , false );
	
	proxy:SetDrawEnable( 1997 , false );
	proxy:SetDrawEnable( 1993 , false );
	
	proxy:InvalidSfx(1989,true);
	proxy:InvalidSfx(1985,true);

	--���{�X�����O�̈ړ������C�x���g���폜
	proxy:DeleteEvent( 1190 );--��l�ڂ�����Ƃ��p
	proxy:DeleteEvent( 1191 );--��l�ڈȍ~������Ƃ��p
	proxy:DeleteEvent( 1108 );--�{�X�O�|�����p
	proxy:DeleteEvent( 1109 );--�{�X�퓬�J�n�p
	print("OnEvent_4895_PT end");
end


--�{�X����BGM�̈�ɓ��荞��
function OnEvent_4897(proxy,param)	
	--�{�X�|�������I����ĂȂ�������
	if proxy:IsCompleteEvent( 4880 ) == false then
		return;
	end
	print("OnEvent_4897 begin");
	--�{�X��pBGM�Đ��J�n	
	proxy:PlayPointSE( 2500, SOUND_TYPE_M, 30200000, 2 );
	proxy:EnableLogic(805,true);
	
	proxy:SetEventFlag(4897, true);
	
	--�{�X�Q�[�W�\��
	proxy:SetBossGauge( 805 , 0 ,6020 );
	
	--�Ď��̍폜
	proxy:DeleteEvent( 4897 );
	
	print("OnEvent_4897 end");	
end

--[[
--------------------------------------------------------------------------------------
--��̍U����1119
--------------------------------------------------------------------------------------
--��1119����̍U����
function Check_1119(proxy,param)
	local region = { 2420 };
	local tblnum = table.getn(region);
	local index =0;
	local isIn = false;
	
	for index = 1, tblnum, 1 do
		if proxy:IsRegionIn(10000,region[index]) == true then
			isIn = true;
			break;
		end
	end
	
	--�̈�ɓ����ĂȂ����̂ݏ���
	if isIn == false then
		proxy:SetInsideBattleArea(346,0);
	end
	
	return isIn;
end

--�̈�ɓ����Ă���
function OnEvent_1119(proxy,param)
	proxy:SetInsideBattleArea(346,1);
end

--�邪����
function OnEvent_1119_1(proxy,param)
	print("OnEvent_1119_1 begin");
	proxy:DeleteEvent( 1119 );
	print("OnEvent_1119_1 end");
end
]]

--[[
--------------------------------------------------------------------------------------
--��̍U����1120
--------------------------------------------------------------------------------------
--��1120����̍U����
function Check_1120(proxy,param)
	local region = { 2421 };
	local tblnum = table.getn(region);
	local index =0;
	local isIn = false;
	
	for index = 1, tblnum, 1 do
		if proxy:IsRegionIn(10000,region[index]) == true then
			isIn = true;
			break;
		end
	end
	
	--�̈�ɓ����ĂȂ����̂ݏ���
	if isIn == false then
		proxy:SetInsideBattleArea(347,0);
	end
	
	return isIn;
end

--�̈�ɓ����Ă���
function OnEvent_1120(proxy,param)
	proxy:SetInsideBattleArea(347,1);
end

--�邪����
function OnEvent_1120_1(proxy,param)
	print("OnEvent_1120_1 begin");
	proxy:DeleteEvent( 1120 );
	print("OnEvent_1120_1 end");
end
]]


--------------------------------------------------------------------------------------
--�e�l�|�����Đ���
--------------------------------------------------------------------------------------
function OnEvent_1122(proxy,param)
	print("OnEvent_1122 begin");
	
	--�X�C�b�`�����ރA�j���𗬂�
	proxy:PlayAnimation( 1400, 1 );
	
	proxy:NotNetMessage_begin();
		--OBJ���ǂݍ��߂Ă��邩�ǂ����H
		if proxy:IsReady_Obj( 1400 ) == true then
			proxy:OnObjAnimEnd( 1122, 1400, 1, "OnEvent_1122_1", once );
		else
			proxy:OnKeyTime2( 1122 , "OnEvent_1122_1",5.0,0,0,once);
		end
	proxy:NotNetMessage_end();	
	print("OnEvent_1122 end");
end

--���Ԍo��orOBJ�̃A�j���҂�
function OnEvent_1122_1(proxy,param)
	print("OnEvent_1122_1 begin");	
	--�����J����A�j���𗬂�
	--proxy:PlayAnimation( 1401, 1 );	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1122, "OnEvent_1122_2", 0.5, 0, 2, once );
	proxy:NotNetMessage_end();	
	print("OnEvent_1122_1 end");
end

--�|�����z�M�p
function OnEvent_1122_2(proxy,param)
	if proxy:IsCompleteEvent(1122) == false then
		print("OnEvent_1122_2 begin");
		proxy:LuaCallStart( 1122 , 1 );
		print("OnEvent_1122_2 end");
	end
end

--�|�����Đ����󂯎����
function OnEvent_1122_3(proxy,param)
	if proxy:IsCompleteEvent(1122) == false then
		print("OnEvent_1122_3 begin");	
		proxy:RequestRemo(30200,REMO_FLAG,1122,1);--�|�����v��	
		proxy:SetEventFlag( 1122 ,true );
		print("OnEvent_1122_3 end");
	end
end

function OnEvent_1122_RemoStart(proxy,param)
	print("OnEvent_1122_RemoStart begin");
	print("OnEvent_1122_RemoStart end");
end

function OnEvent_1122_RemoFinish(proxy,param)
	print("OnEvent_1122_RemoFinish begin");
	
	--�����J���A�j�����I��������
	proxy:EndAnimation( 1401, 1 );
	
	--���������Ă����e�l�L����
	ValidCharactor(proxy, 200);
	ValidCharactor(proxy, 201);
	ValidCharactor(proxy, 202);
	ValidCharactor(proxy, 203);
	print("OnEvent_1122_RemoFinish end");
end


--------------------------------------------------------------------------------------
--�e�l�s�i�J�n��1123
--------------------------------------------------------------------------------------
--�̈�ɓ�����
function OnEvent_1123(proxy,param)
	print("OnEvent_1123 begin");
	
	--�����������̓O���C�̐l�ɂ����ݒ�
	if proxy:IsClient() == false then
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnKeyTime2(1123,"OnEvent_1123_1",START_MARCH_WAIT,0,0,once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	
	print("OnEvent_1123 end");
end

--START_MARCH_WAIT�b��e�l�s�i
function OnEvent_1123_1(proxy,param)
	print("OnEvent_1123_1 begin");
	--�e�lA�X�^�[�g
	proxy:LuaCallStart(1125,0);
	--�e�lB�X�^�[�g
	proxy:LuaCallStart(1127,0);
	--�e�lC�X�^�[�g
	proxy:LuaCallStart(1129,0);
	--�e�lD�X�^�[�g
	proxy:LuaCallStart(1132,0);
	--�e�lE�X�^�[�g
	proxy:LuaCallStart(1135,0);
	--�e�lF�X�^�[�g
	proxy:LuaCallStart(1138,0);
	print("OnEvent_1123_1 end");
end


--------------------------------------------------------------------------------------
--�e�l�ʏ큡1132
--------------------------------------------------------------------------------------
--�̈�ɓ�����
function OnEvent_1132(proxy,param)
	print("OnEvent_1132 begin");
	local eneid = 349;
	for eneid = 349, 354, 1 do
		if proxy:IsAlive(eneid) == true then
			proxy:ResetThink(eneid);
		end
	end
	print("OnEvent_1132 end");
end



--------------------------------------------------------------------------------------
--�e�lA��1125�E1126
--------------------------------------------------------------------------------------
--�|�C���g�P�֌�����
function OnEvent_1125(proxy,param)
	print("OnEvent_1125 begin");
	if proxy:IsAlive(349) == true then
		LuaFunc_ForceOmission(proxy,349);
		proxy:ResetThink( 349 );
		MoveRegion(proxy, 349, 2505, -1,0.0,true);
		proxy:OnRegionIn(1125,349,2505,"OnEvent_1125_1",once);
	end
	print("OnEvent_1125 end");
end

--�|�C���g����
function OnEvent_1125_1(proxy,param)
	print("OnEvent_1125_1 begin");
	proxy:LuaCallStart(1126,0);
	print("OnEvent_1125_1 end");
end

--�|�C���g�Q�֌�����
function OnEvent_1126(proxy,param)
	print("OnEvent_1126 beign");
	if proxy:IsAlive(349) == true then
		LuaFunc_NormalOmission(proxy,349);
		proxy:ResetThink( 349 );
		MoveRegion(proxy, 349, 2506, -1,0.0,true);		
	end
	print("OnEvent_1126 end");
end


--------------------------------------------------------------------------------------
--�e�lB��1127�E1128
--------------------------------------------------------------------------------------
--�|�C���g�P�֌�����
function OnEvent_1127(proxy,param)
	print("OnEvent_1127 begin");
	if proxy:IsAlive(350) == true then
		LuaFunc_ForceOmission(proxy,350);
		proxy:ResetThink( 350 );
		MoveRegion(proxy, 350, 2507, -1,0.0,true);
		proxy:OnRegionIn(1127,350,2507,"OnEvent_1127_1",once);
	end
	print("OnEvent_1127 end");
end

--�|�C���g����
function OnEvent_1127_1(proxy,param)
	print("OnEvent_1127_1 begin");
	proxy:LuaCallStart(1128,0);
	print("OnEvent_1127_1 end");
end

--�|�C���g�Q�֌�����
function OnEvent_1128(proxy,param)
	print("OnEvent_1128 beign");
	if proxy:IsAlive(350) == true then
		LuaFunc_NormalOmission(proxy,350);
		proxy:ResetThink( 350 );
		MoveRegion(proxy, 350, 2508, -1,0.0,true);		
	end
	print("OnEvent_1128 end");
end


--------------------------------------------------------------------------------------
--�e�lC��1129�E1130�E1131
--------------------------------------------------------------------------------------
--�|�C���g�P�֌�����
function OnEvent_1129(proxy,param)
	print("OnEvent_1129 begin");
	if proxy:IsAlive(351) == true then
		LuaFunc_ForceOmission(proxy,351);
		proxy:ResetThink( 351 );
		MoveRegion(proxy, 351, 2509, -1,0.0,true);
		proxy:OnRegionIn(1129,351,2509,"OnEvent_1129_1",once);
	end
	print("OnEvent_1129 end");
end

--�|�C���g�P����
function OnEvent_1129_1(proxy,param)
	print("OnEvent_1129_1 begin");
	proxy:LuaCallStart(1130,0);
	print("OnEvent_1129_1 end");
end

--�|�C���g�Q�֌�����
function OnEvent_1130(proxy,param)
	print("OnEvent_1130 beign");
	if proxy:IsAlive(351) == true then
		LuaFunc_ForceOmission(proxy,351);
		proxy:ResetThink( 351 );
		MoveRegion(proxy, 351, 2505, -1,0.0,true);
		proxy:OnRegionIn(1130,351,2505,"OnEvent_1130_1",once);
	end
	print("OnEvent_1130 end");
end

--�|�C���g�Q����
function OnEvent_1130_1(proxy,param)
	print("OnEvent_1130_1 begin");
	proxy:LuaCallStart(1131,0);
	print("OnEvent_1130_1 end");
end

--�|�C���g�R�֌�����
function OnEvent_1131(proxy,param)
	print("OnEvent_1131 beign");
	if proxy:IsAlive(351) == true then
		LuaFunc_NormalOmission(proxy,351);
		proxy:ResetThink( 351 );
		MoveRegion(proxy, 351, 2506, -1,0.0,true);		
	end
	print("OnEvent_1131 end");
end


--------------------------------------------------------------------------------------
--�e�lD��1132�E1133�E1134
--------------------------------------------------------------------------------------
--�|�C���g�P�֌�����
function OnEvent_1132(proxy,param)
	print("OnEvent_1132 begin");
	if proxy:IsAlive(352) == true then
		LuaFunc_ForceOmission(proxy,352);
		proxy:ResetThink( 352 );
		MoveRegion(proxy, 352, 2509, -1,0.0,true);
		proxy:OnRegionIn(1132,352,2509,"OnEvent_1132_1",once);
	end
	print("OnEvent_1132 end");
end

--�|�C���g�P����
function OnEvent_1132_1(proxy,param)
	print("OnEvent_1132_1 begin");
	proxy:LuaCallStart(1133,0);
	print("OnEvent_1132_1 end");
end

--�|�C���g�Q�֌�����
function OnEvent_1133(proxy,param)
	print("OnEvent_1133 beign");
	if proxy:IsAlive(352) == true then
		LuaFunc_ForceOmission(proxy,352);
		proxy:ResetThink( 352 );
		MoveRegion(proxy, 352, 2507, -1,0.0,true);
		proxy:OnRegionIn(1133,352,2507,"OnEvent_1133_1",once);
	end
	print("OnEvent_1133 end");
end

--�|�C���g�Q����
function OnEvent_1133_1(proxy,param)
	print("OnEvent_1133_1 begin");
	proxy:LuaCallStart(1134,0);
	print("OnEvent_1133_1 end");
end

--�|�C���g�R�֌�����
function OnEvent_1134(proxy,param)
	print("OnEvent_1134 beign");
	if proxy:IsAlive(352) == true then
		LuaFunc_NormalOmission(proxy,352);
		proxy:ResetThink( 352 );
		MoveRegion(proxy, 352, 2508, -1,0.0,true);		
	end
	print("OnEvent_1134 end");
end


--------------------------------------------------------------------------------------
--�e�lE��1135�E1136�E1137
--------------------------------------------------------------------------------------
--�|�C���g�P�֌�����
function OnEvent_1135(proxy,param)
	print("OnEvent_1135 begin");
	if proxy:IsAlive(353) == true then
		LuaFunc_ForceOmission(proxy,353);
		proxy:ResetThink( 353 );
		MoveRegion(proxy, 353, 2509, -1,0.0,true);
		proxy:OnRegionIn(1135,353,2509,"OnEvent_1135_1",once);
	end
	print("OnEvent_1135 end");
end

--�|�C���g�P����
function OnEvent_1135_1(proxy,param)
	print("OnEvent_1135_1 begin");
	proxy:LuaCallStart(1136,0);
	print("OnEvent_1135_1 end");
end

--�|�C���g�Q�֌�����
function OnEvent_1136(proxy,param)
	print("OnEvent_1136 beign");
	if proxy:IsAlive(353) == true then
		LuaFunc_ForceOmission(proxy,353);
		proxy:ResetThink( 353 );
		MoveRegion(proxy, 353, 2505, -1,0.0,true);
		proxy:OnRegionIn(1136,353,2505,"OnEvent_1136_1",once);
	end
	print("OnEvent_1136 end");
end

--�|�C���g�Q����
function OnEvent_1136_1(proxy,param)
	print("OnEvent_1136_1 begin");
	proxy:LuaCallStart(1137,0);
	print("OnEvent_1136_1 end");
end

--�|�C���g�R�֌�����
function OnEvent_1137(proxy,param)
	print("OnEvent_1137 beign");
	if proxy:IsAlive(353) == true then
		LuaFunc_NormalOmission(proxy,353);
		proxy:ResetThink( 353 );
		MoveRegion(proxy, 353, 2506, -1,0.0,true);		
	end
	print("OnEvent_1137 end");
end


--------------------------------------------------------------------------------------
--�e�lF��1138�E1139�E1140
--------------------------------------------------------------------------------------
--�|�C���g�P�֌�����
function OnEvent_1138(proxy,param)
	print("OnEvent_1138 begin");
	if proxy:IsAlive(354) == true then
		LuaFunc_ForceOmission(proxy,354);
		proxy:ResetThink( 354 );
		MoveRegion(proxy, 354, 2509, -1,0.0,true);
		proxy:OnRegionIn(1138,354,2509,"OnEvent_1138_1",once);
	end
	print("OnEvent_1138 end");
end

--�|�C���g�P����
function OnEvent_1138_1(proxy,param)
	print("OnEvent_1138_1 begin");
	proxy:LuaCallStart(1139,0);
	print("OnEvent_1138_1 end");
end

--�|�C���g�Q�֌�����
function OnEvent_1139(proxy,param)
	print("OnEvent_1139 beign");
	if proxy:IsAlive(354) == true then
		LuaFunc_ForceOmission(proxy,354);
		proxy:ResetThink( 354 );
		MoveRegion(proxy, 354, 2507, -1,0.0,true);
		proxy:OnRegionIn(1139,354,2507,"OnEvent_1139_1",once);
	end
	print("OnEvent_1139 end");
end

--�|�C���g�Q����
function OnEvent_1139_1(proxy,param)
	print("OnEvent_1139_1 begin");
	proxy:LuaCallStart(1140,0);
	print("OnEvent_1139_1 end");
end

--�|�C���g�R�֌�����
function OnEvent_1140(proxy,param)
	print("OnEvent_1140 beign");
	if proxy:IsAlive(354) == true then
		LuaFunc_NormalOmission(proxy,354);
		proxy:ResetThink( 354 );
		MoveRegion(proxy, 354, 2508, -1,0.0,true);		
	end
	print("OnEvent_1140 end");
end






--------------------------------------------------------------------------------------
--�S�[�X�g���W�b�NON��1143
--------------------------------------------------------------------------------------
function OnEvent_1143(proxy,param)
	print("OnEvent_1143 begin");
	proxy:EnableLogic(355,true);
	proxy:SetEventFlag(1143, true);
	print("OnEvent_1143 end");
end


--------------------------------------------------------------------------------------
--���@�g���̃|�C���g�ړ�1��1151
--------------------------------------------------------------------------------------
--�v���C���[���͈͓��ɓ�����
function OnEvent_1151(proxy,param)
	print("OnEvent_1151 begin");
	proxy:SetEventFlag( 1182, 1 );
	proxy:LuaCallStart(1151,1);
	print("OnEvent_1151 end");
end

--���@�g����������C�x���g
function OnEvent_1151_ToMove(proxy,param)
	print("OnEvent_1151_ToMove begin");	
	proxy:EnableGeneratorSystem(2533,false);--�W�F�l���[�^OFF		
	
	proxy:ResetThink(356);
	proxy:DisableInterupt(356,true);
	MoveRegion2(proxy, 356, 2522, -1,0.0,false);
	proxy:ChangeInitPosAng(356,2522);
	proxy:OnRegionIn(1151,356,2522,"OnEvent_1151_EndMove",once);
	print("OnEvent_1151_ToMove end");
end

--���@�g���������؂���
function OnEvent_1151_EndMove(proxy,param)
	print("OnEvent_1151_EndMove begin");	
	proxy:LuaCallStart(1151,2);
	print("OnEvent_1151_EndMove end");
end

--���@�g���̋L�������ʒu�ύX�Ǝ��̃G���A�Ď��ǉ��A�t���OON
function OnEvent_1151_flag(proxy,param)
	print("OnEvent_1151_flag begin");
	proxy:DisableInterupt(356,false);
	proxy:SetEventFlag( 1182, 0 );
	proxy:SetEventFlag(1151,true);
	proxy:ChangeInitPosAng(356,2522);
	proxy:OnRegionIn(1152,10000,2516,"OnEvent_1152",once);
	
	--���@�g���������Ă鎖
	if proxy:IsAlive(356) == true then		
		proxy:EnableGeneratorSystem(2534,true);--�W�F�l���[�^ON
		proxy:PlayAnimation(356,3005);
		--�z�M���Ȃ�
		proxy:NotNetMessage_begin();
			--�ēo�^���\�ɂ���
			proxy:RepeatMessage_begin();
				proxy:OnRegistFunc( 1182,"Check_1182","OnEvent_1182",1,once);		
			proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	print("OnEvent_1151_flag end");
end


--------------------------------------------------------------------------------------
--���@�g���̃|�C���g�ړ�2��1152
--------------------------------------------------------------------------------------
--�v���C���[���͈͓��ɓ�����
function OnEvent_1152(proxy,param)
	print("OnEvent_1152 begin");
	proxy:SetEventFlag( 1182, 1 );
	proxy:LuaCallStart(1152,1);
	print("OnEvent_1152 end");
end

--���@�g����������C�x���g
function OnEvent_1152_ToMove(proxy,param)
	print("OnEvent_1152_ToMove begin");		
	proxy:EnableGeneratorSystem(2534,false);--�W�F�l���[�^OFF		
	
	proxy:DisableInterupt(356,true);
	proxy:ResetThink(356);
	MoveRegion2(proxy, 356, 2523, -1,0.0,false);
	proxy:ChangeInitPosAng(356,2523);
	proxy:OnRegionIn(1152,356,2523,"OnEvent_1152_EndMove",once);
	print("OnEvent_1152_ToMove end");
end

--���@�g���������؂���
function OnEvent_1152_EndMove(proxy,param)
	print("OnEvent_1152_EndMove begin");
	proxy:LuaCallStart(1152,2);	
	print("OnEvent_1152_EndMove end");
end

--���@�g���̋L�������ʒu�ύX�Ǝ��̃G���A�Ď��ǉ��A�t���OON
function OnEvent_1152_flag(proxy,param)
	print("OnEvent_1152_flag begin");
	proxy:DisableInterupt(356,false);
	proxy:SetEventFlag( 1182, 0 );
	proxy:SetEventFlag(1152,true);
	proxy:ChangeInitPosAng(356,2523);
	proxy:OnRegionIn(1153,10000,2517,"OnEvent_1153",once);
	
	--���@�g���������Ă鎖
	if proxy:IsAlive(356) == true then		
		proxy:EnableGeneratorSystem(2535,true);--�W�F�l���[�^ON
		proxy:PlayAnimation(356,3005);
		--�z�M���Ȃ�
		proxy:NotNetMessage_begin();
			--�ēo�^���\�ɂ���
			proxy:RepeatMessage_begin();
				proxy:OnRegistFunc( 1182,"Check_1182","OnEvent_1182",1,once);		
			proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	print("OnEvent_1152_flag end");
end


--------------------------------------------------------------------------------------
--���@�g���̃|�C���g�ړ�3��1153
--------------------------------------------------------------------------------------
--�v���C���[���͈͓��ɓ�����
function OnEvent_1153(proxy,param)
	print("OnEvent_1153 begin");
	proxy:SetEventFlag( 1182, 1 );
	proxy:LuaCallStart(1153,1);
	print("OnEvent_1153 end");
end

--���@�g����������C�x���g
function OnEvent_1153_ToMove(proxy,param)
	print("OnEvent_1153_ToMove begin");
	proxy:EnableGeneratorSystem(2535,false);--�W�F�l���[�^OFF
	proxy:DisableInterupt(356,true);
	proxy:ResetThink(356);
	MoveRegion2(proxy, 356, 2524, -1,0.0,false);
	proxy:ChangeInitPosAng(356,2524);
	proxy:OnRegionIn(1153,356,2524,"OnEvent_1153_EndMove",once);
	print("OnEvent_1153_ToMove end");
end

--���@�g���������؂���
function OnEvent_1153_EndMove(proxy,param)
	print("OnEvent_1153_EndMove begin");
	proxy:LuaCallStart(1153,2);	
	print("OnEvent_1153_EndMove end");
end

--���@�g���̋L�������ʒu�ύX�Ǝ��̃G���A�Ď��ǉ��A�t���OON
function OnEvent_1153_flag(proxy,param)
	print("OnEvent_1153_flag begin");
	proxy:DisableInterupt(356,false);
	proxy:SetEventFlag( 1182, 0 );
	proxy:SetEventFlag(1153,true);
	proxy:ChangeInitPosAng(356,2524);
	proxy:OnRegionIn(1154,10000,2518,"OnEvent_1154",once);
	
	--���@�g���������Ă鎖
	if proxy:IsAlive(356) == true then		
		proxy:EnableGeneratorSystem(2536,true);--�W�F�l���[�^ON
		proxy:PlayAnimation(356,3005);
		--�z�M���Ȃ�
		proxy:NotNetMessage_begin();
			--�ēo�^���\�ɂ���
			proxy:RepeatMessage_begin();
				proxy:OnRegistFunc( 1182,"Check_1182","OnEvent_1182",1,once);		
			proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	print("OnEvent_1153_flag end");
end



--------------------------------------------------------------------------------------
--���@�g���̃|�C���g�ړ�4��1154
--------------------------------------------------------------------------------------
--�v���C���[���͈͓��ɓ�����
function OnEvent_1154(proxy,param)
	print("OnEvent_1154 begin");
	proxy:SetEventFlag( 1182, 1 );
	proxy:LuaCallStart(1154,1);
	print("OnEvent_1154 end");
end

--���@�g����������C�x���g
function OnEvent_1154_ToMove(proxy,param)
	print("OnEvent_1154_ToMove begin");	
	proxy:EnableGeneratorSystem(2536,false);--�W�F�l���[�^OFF
	proxy:DisableInterupt(356,true);
	proxy:ResetThink(356);
	MoveRegion2(proxy, 356, 2525, -1,0.0,false);
	proxy:ChangeInitPosAng(356,2525);
	proxy:OnRegionIn(1154,356,2525,"OnEvent_1154_EndMove",once);
	print("OnEvent_1154_ToMove end");
end

--���@�g���������؂���
function OnEvent_1154_EndMove(proxy,param)
	print("OnEvent_1154_EndMove begin");
	proxy:LuaCallStart(1154,2);	
	print("OnEvent_1154_EndMove end");
end

--���@�g���̋L�������ʒu�ύX�Ǝ��̃G���A�Ď��ǉ��A�t���OON
function OnEvent_1154_flag(proxy,param)
	print("OnEvent_1154_flag begin");
	proxy:DisableInterupt(356,false);
	proxy:SetEventFlag( 1182, 0 );
	proxy:SetEventFlag(1154,true);
	proxy:ChangeInitPosAng(356,2525);
	proxy:OnRegionIn(1155,10000,2519,"OnEvent_1155",once);
	
	--���@�g���������Ă鎖
	if proxy:IsAlive(356) == true then		
		proxy:EnableGeneratorSystem(2537,true);--�W�F�l���[�^ON
		proxy:PlayAnimation(356,3005);
		--�z�M���Ȃ�
		proxy:NotNetMessage_begin();
			--�ēo�^���\�ɂ���
			proxy:RepeatMessage_begin();
				proxy:OnRegistFunc( 1182,"Check_1182","OnEvent_1182",1,once);		
			proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	print("OnEvent_1154_flag end");
end


--------------------------------------------------------------------------------------
--���@�g���̃|�C���g�ړ�5��1155
--------------------------------------------------------------------------------------
--�v���C���[���͈͓��ɓ�����
function OnEvent_1155(proxy,param)
	print("OnEvent_1155 begin");
	proxy:SetEventFlag( 1182, 1 );
	proxy:LuaCallStart(1155,1);
	print("OnEvent_1155 end");
end

--���@�g����������C�x���g
function OnEvent_1155_ToMove(proxy,param)
	print("OnEvent_1155_ToMove begin");
	proxy:EnableGeneratorSystem(2537,false);--�W�F�l���[�^OFF
	proxy:DisableInterupt(356,true);
	proxy:ResetThink(356);
	MoveRegion2(proxy, 356, 2526, -1,0.0,false);
	proxy:ChangeInitPosAng(356,2526);
	proxy:OnRegionIn(1155,356,2526,"OnEvent_1155_EndMove",once);
	print("OnEvent_1155_ToMove end");
end

--���@�g���������؂���
function OnEvent_1155_EndMove(proxy,param)
	print("OnEvent_1155_EndMove begin");
	proxy:LuaCallStart(1155,2);	
	print("OnEvent_1155_EndMove end");
end

--���@�g���̋L�������ʒu�ύX�Ǝ��̃G���A�Ď��ǉ��A�t���OON
function OnEvent_1155_flag(proxy,param)
	print("OnEvent_1155_flag begin");
	proxy:DisableInterupt(356,false);
	proxy:SetEventFlag( 1182, 0 );
	proxy:SetEventFlag(1155,true);
	proxy:ChangeInitPosAng(356,2526);
	proxy:OnRegionIn(1156,10000,2520,"OnEvent_1156",once);
	
	--���@�g���������Ă鎖
	if proxy:IsAlive(356) == true then		
		proxy:EnableGeneratorSystem(2538,true);--�W�F�l���[�^ON
		proxy:PlayAnimation(356,3005);
		--�z�M���Ȃ�
		proxy:NotNetMessage_begin();
			--�ēo�^���\�ɂ���
			proxy:RepeatMessage_begin();
				proxy:OnRegistFunc( 1182,"Check_1182","OnEvent_1182",1,once);
			proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	
	print("OnEvent_1155_flag end");
end


--------------------------------------------------------------------------------------
--���@�g���̃|�C���g�ړ�6��1156
--------------------------------------------------------------------------------------
--�v���C���[���͈͓��ɓ�����
function OnEvent_1156(proxy,param)
	print("OnEvent_1156 begin");
	proxy:SetEventFlag( 1182, 1 );
	proxy:LuaCallStart(1156,1);
	print("OnEvent_1156 end");
end

--���@�g����������C�x���g
function OnEvent_1156_ToMove(proxy,param)
	print("OnEvent_1156_ToMove begin");	
	proxy:EnableGeneratorSystem(2538,false);--�W�F�l���[�^OFF
	proxy:DisableInterupt(356,true);
	proxy:ResetThink(356);
	MoveRegion2(proxy, 356, 2527, -1,0.0,false);
	proxy:ChangeInitPosAng(356,2527);
	proxy:OnRegionIn(1156,356,2527,"OnEvent_1156_EndMove",once);
	print("OnEvent_1156_ToMove end");
end

--���@�g���������؂���
function OnEvent_1156_EndMove(proxy,param)
	print("OnEvent_1156_EndMove begin");
	proxy:LuaCallStart(1156,2);	
	print("OnEvent_1156_EndMove end");
end

--���@�g���̋L�������ʒu�ύX�Ǝ��̃G���A�Ď��ǉ��A�t���OON
function OnEvent_1156_flag(proxy,param)
	print("OnEvent_1156_flag begin");
	proxy:DisableInterupt(356,false);
	proxy:SetEventFlag( 1182, 0 );
	proxy:SetEventFlag(1156,true);
	proxy:ChangeInitPosAng(356,2527);
	
	--���@�g���������Ă鎖
	if proxy:IsAlive(356) == true then
		proxy:EnableGeneratorSystem(2539,true);--�W�F�l���[�^ON
		proxy:PlayAnimation(356,3005);
		--�z�M���Ȃ�
		proxy:NotNetMessage_begin();
			--�ēo�^���\�ɂ���
			proxy:RepeatMessage_begin();
				proxy:OnRegistFunc( 1182,"Check_1182","OnEvent_1182",1,once);		
			proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	
	print("OnEvent_1156_flag end");
end


--------------------------------------------------------------------------------------
--�X�L�����������遡1250
--------------------------------------------------------------------------------------
function OnEvent_1250(proxy,param)
	if proxy:IsCompleteEvent( URUBAIN_STATE_ANGRY ) == false then
		print("OnEvent_1250 begin");
		proxy:SetEventFlag(1250,true);
		if 	proxy:IsCompleteEvent( URUBAIN_STATE_HELP ) == true and
			proxy:IsCompleteEvent( 1064 ) == true then
			SetNpcStateFlag(proxy,param,urubain_flag_list,URUBAIN_STATE_THANKS);			
		end		
		print("OnEvent_1250 end");
	else
		print("OnEvent_1250 URUBAIN_STATE_ANGRY");
	end
end


--------------------------------------------------------------------------------------
--�E���x�C�����Ӂ�1157
--------------------------------------------------------------------------------------
function OnEvent_1157(proxy,param)
	print("OnEvent_1157 begin");
	if proxy:IsCompleteEvent( URUBAIN_STATE_HELP ) == true then
		SetNpcStateFlag(proxy,param,urubain_flag_list,URUBAIN_STATE_THANKS);
		proxy:SetEventFlag( 1157 , true );
	end
	print("OnEvent_1157 end");
end


--------------------------------------------------------------------------------------
--�X�L�����Ɉ��_���[�W��1158
--------------------------------------------------------------------------------------
function OnEvent_1158(proxy,param)
	print("OnEvent_1158 begin");
	proxy:SetEventFlag(1158,true);
	
	proxy:EnableLogic( 635, true );
	SetNpcStateFlag(proxy,param,urubain_flag_list,URUBAIN_STATE_ANGRY);
	
	proxy:SetTeamType( 635, TEAM_TYPE_AngryFriend );
	print("OnEvent_1158 end");
end


--------------------------------------------------------------------------------------
--�X�L�����̎��S��1159
--------------------------------------------------------------------------------------
function OnEvent_1159(proxy,param)
	print("OnEvent_1159 begin");
	proxy:SetEventFlag(1159,true);
	SetNpcStateFlag(proxy,param,urubain_flag_list,URUBAIN_STATE_DEAD);
	print("OnEvent_1159 end");
end

--------------------------------------------------------------------------------------
--�o�b�`����������1192
--------------------------------------------------------------------------------------
--��1192���o�b�`����������
function OnEvent_1192(proxy, param)
	print("OnEvent_1192 begin");

	--proxy:EnableLogic( 636 , true );--���W�b�NON
	SetNpcStateFlag( proxy, param, batti_flag_list, BATTI_PUSHING );--��Ԃ��u�˂����Ƃ������v�ɂ�����
	ValidCharactor( proxy, 636 );
	
	proxy:SetEventFlag( 1192, true );

	print("OnEvent_1192 end");
end
--------------------------------------------------------------------------------------
--�o�b�`���A�C�e��������遡1193
--------------------------------------------------------------------------------------
--��1193���p�b�`���A�C�e���������(��b����̌Ăяo��)
function OnEvent_1193(proxy, param)
	print("OnEvent_1193 begin");
	proxy:GetRateItem(16290);
	proxy:SetEventFlag(1193, true);
	print("OnEvent_1193 end");
end

--------------------------------------------------------------------------------------
--�o�b�`���˂����Ƃ���1165
--------------------------------------------------------------------------------------
function OnEvent_1165(proxy,param)
	if	proxy:IsRegionIn( 636, 2531 ) == true then--�̈���ɋ��� �Ȃ��
		if proxy:IsCompleteEvent( BATTI_ANGRY ) == false and--�G�΂��Ă��Ȃ��@����
		   proxy:IsCompleteEvent( BATTI_PUSHING ) == true then--�˂����Ƃ������Ȃ��
			print("OnEvent_1165 begin");
			--�|�������Đ�
			proxy:LuaCallStart(1165, 1);
			
			--[[�|�����Đ��J�n
			if param:IsNetMessage() == true then
				--�����ҏo���|����
				proxy:RequestRemoPlus(30203,REMO_FLAG,1165,1, param:GetPlayID()+10001);
			else
				--�|�����Đ�
				proxy:RequestRemo(30203,REMO_FLAG,1165,1);
			end	]]
			
			print("OnEvent_1165 end");
		else
			print("OnEvent_1165 BATTI_ANGRY");
		end
	else
		print("OnEvent_1165 Region 2531 not In");
	end
end

--�}���`�z�M�p
function OnEvent_1165_0(proxy,param)
	print("OnEvent_1165_0 begin");
	--�|�����Đ��J�n
	if param:IsNetMessage() == true then
		--�����ҏo���|����
		proxy:RequestRemoPlus(30203,REMO_FLAG,1165,1, param:GetPlayID()+10001);
		print("�z�X�g�o���|�����Đ�");
	else
		--�|�����Đ�
		proxy:RequestRemo(30203,REMO_FLAG,1165,1);
		print("�|�����Đ�");
	end

--2009.04.24 toyohide �o�O�Ή��̈׈��z��
--	proxy:SetEventFlag( 4890, true );--��b�p 
--	proxy:SetEventFlag( 1165, true );--�|���������p
	
	print("OnEvent_1165_0 end");
end

--��1541_RemoStart���|�����J�n �t�F�[�h�A�E�g������
function OnEvent_1165_RemoStart(proxy,param)
	print( "OnEvent_1165_RemoStart begin" );
	if proxy:IsClient() == false then--�z�X�g�Ȃ��
		proxy:Warp( LOCAL_PLAYER, 2405 );
		proxy:CamReset( LOCAL_PLAYER, true );
		if proxy:IsAlive( 10000 ) == true then
			proxy:PlayerChrResetAnimation_RemoOnly(10000);
			proxy:ChrResetRequest(10000);
		end
	else
		print("�N���C�A���g�Ȃ̂ŁA�����͖���");
	end
	print( "OnEvent_1165_RemoStart end" );
end

--��1541_RemoFinish���|�����Đ��I���ち
function OnEvent_1165_RemoFinish(proxy , param)
	print( "OnEvent_1165_RemoFinish begin" );
	
	proxy:SetEventFlag( 4890, true );--��b�p 
	proxy:SetEventFlag( 1165, true );--�|���������p
	
	SetNpcStateFlag( proxy, param, batti_flag_list, BATTI_SATISFIED );--�p�b�`�̏�Ԃ��u�����v�ɕς���
	OnEvent_1143(proxy,param);
	
	print( "OnEvent_1165_RemoFinish end" );
end

--------------------------------------------------------------------------------------
--���ɗ�������G�΁�1166
--------------------------------------------------------------------------------------
function OnEvent_1166(proxy,param)
	print("OnEvent_1166 begin");
	if	proxy:IsCompleteEvent( BATTI_PUSHING )		== true or
		proxy:IsCompleteEvent( BATTI_SATISFIED )	== true then
		
		proxy:EnableLogic( 636 , true );
		proxy:SetEventFlag(1166,true);
		SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_ANGRY);
		proxy:SetTeamType( 636, TEAM_TYPE_AngryFriend );
		
	end
	
	print("OnEvent_1166 end");
end
--------------------------------------------------------------------------------------
--�o�b�`�Ɉ��_���[�W��1167
--------------------------------------------------------------------------------------
function OnEvent_1167(proxy,param)
	print("OnEvent_1167 begin");
	proxy:EnableLogic( 636 , true );
	SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_ANGRY);
	proxy:SetTeamType( 636, TEAM_TYPE_AngryFriend );
	proxy:SetEventFlag(1167,true);
	print("OnEvent_1167 end");
end


--------------------------------------------------------------------------------------
--�o�b�`���S��1168
--------------------------------------------------------------------------------------
function OnEvent_1168(proxy,param)
	print("OnEvent_1168 begin");
	proxy:SetEventFlag(1168,true);
	SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_DEAD);
	print("OnEvent_1168 end");
end


--------------------------------------------------------------------------------------
--���@�g��A���S��1173
--------------------------------------------------------------------------------------
function OnEvent_1173(proxy,param)
	print("OnEvent_1173 begin");
	proxy:SetEventFlag(1173,true);
	--�W�F�l���[�^����
	proxy:EnableGeneratorSystem(2532,false);
	print("OnEvent_1173 end");
end

--------------------------------------------------------------------------------------
--���@�g��B���S��1174
--------------------------------------------------------------------------------------
function OnEvent_1174(proxy,param)
	print("OnEvent_1174 begin");
	proxy:SetEventFlag(1174,true);
	--�W�F�l���[�^����
	proxy:EnableGeneratorSystem(2533,false);
	proxy:EnableGeneratorSystem(2534,false);
	proxy:EnableGeneratorSystem(2535,false);
	proxy:EnableGeneratorSystem(2536,false);
	proxy:EnableGeneratorSystem(2537,false);
	proxy:EnableGeneratorSystem(2538,false);
	proxy:EnableGeneratorSystem(2539,false);
	print("OnEvent_1174 end");
end

--------------------------------------------------------------------------------------
--���@�g��C���S��1175
--------------------------------------------------------------------------------------
function OnEvent_1175(proxy,param)
	print("OnEvent_1175 begin");
	proxy:SetEventFlag(1175,true);
	--�W�F�l���[�^����
	proxy:EnableGeneratorSystem(2540,false);
	print("OnEvent_1175 end");
end

--------------------------------------------------------------------------------------
--���@�g��D���S��1176
--------------------------------------------------------------------------------------
function OnEvent_1176(proxy,param)
	print("OnEvent_1176 begin");
	proxy:SetEventFlag(1176,true);
	--�W�F�l���[�^����
	proxy:EnableGeneratorSystem(2541,false);
	print("OnEvent_1176 end");
end


--------------------------------------------------------------------------------------
--�e�l360���S��1177
--------------------------------------------------------------------------------------
function OnEvent_1177_360(proxy,param)
	--���ɏI����Ă�ꍇ�͕s�v
	if proxy:IsCompleteEvent(1177) == true or proxy:IsCompleteEvent(1173) == true then
		return;
	end
	print("OnEvent_1177_360 begin");
	local deadCount = 0;
	local id = 360;
	
	for id = 360, 364, 1 do
		if proxy:IsAlive(id) == false then
			deadCount = deadCount+1;
		end
	end
	
	--���S�J�E���^���R�ȏ�Ȃ�
	if deadCount >= 3 then
		--�W�F�l���[�^�N��
		proxy:EnableGeneratorSystem(2532,true);
		proxy:SetEventFlag(1177,true);
		proxy:PlayAnimation(357,3005);
		proxy:OnRegistFunc( 1181,"Check_1181","OnEvent_1181",1,once);
	end	
	print("OnEvent_1177_360 end");
end


--------------------------------------------------------------------------------------
--�e�l361���S��1177
--------------------------------------------------------------------------------------
function OnEvent_1177_361(proxy,param)
	--���ɏI����Ă�ꍇ�͕s�v
	if proxy:IsCompleteEvent(1177) == true or proxy:IsCompleteEvent(1173) == true then
		return;
	end
	print("OnEvent_1177_361 begin");
	local deadCount = 0;
	local id = 360;
	
	for id = 360, 364, 1 do
		if proxy:IsAlive(id) == false then
			deadCount = deadCount+1;
		end
	end
	
	--���S�J�E���^���R�ȏ�Ȃ�
	if deadCount >= 3 then
		--�W�F�l���[�^�N��
		proxy:EnableGeneratorSystem(2532,true);
		proxy:SetEventFlag(1177,true);
		proxy:PlayAnimation(357,3005);
		proxy:OnRegistFunc( 1181,"Check_1181","OnEvent_1181",1,once);
	end	
	print("OnEvent_1177_361 end");
end


--------------------------------------------------------------------------------------
--�e�l362���S��1177
--------------------------------------------------------------------------------------
function OnEvent_1177_362(proxy,param)
	--���ɏI����Ă�ꍇ�͕s�v
	if proxy:IsCompleteEvent(1177) == true or proxy:IsCompleteEvent(1173) == true then
		return;
	end
	print("OnEvent_1177_362 begin");
	local deadCount = 0;
	local id = 360;
	
	for id = 360, 364, 1 do
		if proxy:IsAlive(id) == false then
			deadCount = deadCount+1;
		end
	end
	--���S�J�E���^���R�ȏ�Ȃ�
	if deadCount >= 3 then
		--�W�F�l���[�^�N��
		proxy:EnableGeneratorSystem(2532,true);
		proxy:SetEventFlag(1177,true);
		proxy:PlayAnimation(357,3005);
		proxy:OnRegistFunc( 1181,"Check_1181","OnEvent_1181",1,once);
	end	
	print("OnEvent_1177_362 end");
end


--------------------------------------------------------------------------------------
--�e�l363���S��1177
--------------------------------------------------------------------------------------
function OnEvent_1177_363(proxy,param)
	--���ɏI����Ă�ꍇ�͕s�v or ���ɖ��@�g������ł�
	if proxy:IsCompleteEvent(1177) == true or proxy:IsCompleteEvent(1173) == true then
		return;
	end
	print("OnEvent_1177_363 begin");
	local deadCount = 0;
	local id = 360;
	
	for id = 360, 364, 1 do
		if proxy:IsAlive(id) == false then
			deadCount = deadCount+1;
		end
	end
	
	--���S�J�E���^���R�ȏ�Ȃ�
	if deadCount >= 3 then
		--�W�F�l���[�^�N��
		proxy:EnableGeneratorSystem(2532,true);
		proxy:SetEventFlag(1177,true);
		proxy:PlayAnimation(357,3005);
		proxy:OnRegistFunc( 1181,"Check_1181","OnEvent_1181",1,once);
	end	
	print("OnEvent_1177_363 end");
end


--------------------------------------------------------------------------------------
--�e�l364���S��1177
--------------------------------------------------------------------------------------
function OnEvent_1177_364(proxy,param)
	--���ɏI����Ă�ꍇ�͕s�v
	if proxy:IsCompleteEvent(1177) == true or proxy:IsCompleteEvent(1173) == true then
		return;
	end
	print("OnEvent_1177_364 begin");
	local deadCount = 0;
	local id = 360;
	
	for id = 360, 364, 1 do
		if proxy:IsAlive(id) == false then
			deadCount = deadCount+1;
		end
	end
	
	--���S�J�E���^���R�ȏ�Ȃ�
	if deadCount >= 3 then
		--�W�F�l���[�^�N��
		proxy:EnableGeneratorSystem(2532,true);
		proxy:SetEventFlag(1177,true);
		proxy:PlayAnimation(357,3005);
		proxy:OnRegistFunc( 1181,"Check_1181","OnEvent_1181",1,once);
	end	
	print("OnEvent_1177_364 end");
end


--------------------------------------------------------------------------------------
--�W�F�l���[�^�N����1178
--------------------------------------------------------------------------------------
function OnEvent_1178(proxy,param)
	print("OnEvent_1178 begin");
	if proxy:IsCompleteEvent(1174) == false then
		--���҃A�j��
		proxy:PlayAnimation(356,3005);
		proxy:OnRegistFunc( 1182,"Check_1182","OnEvent_1182",1,once);
		--�W�F�l���[�^�N��
		if proxy:IsCompleteEvent(1151) == false then
			proxy:EnableGeneratorSystem(2533,true);
		elseif proxy:IsCompleteEvent(1152) == false then
			proxy:EnableGeneratorSystem(2534,true);
		elseif proxy:IsCompleteEvent(1153) == false then
			proxy:EnableGeneratorSystem(2535,true);
		elseif proxy:IsCompleteEvent(1154) == false then
			proxy:EnableGeneratorSystem(2536,true);
		elseif proxy:IsCompleteEvent(1155) == false then
			proxy:EnableGeneratorSystem(2537,true);
		elseif proxy:IsCompleteEvent(1156) == false then
			proxy:EnableGeneratorSystem(2538,true);
		else
			proxy:EnableGeneratorSystem(2539,true);
		end
		proxy:SetEventFlag(1178,true);
	end
	print("OnEvent_1178 end");
end


--------------------------------------------------------------------------------------
--�W�F�l���[�^�N����1179
--------------------------------------------------------------------------------------
function OnEvent_1179(proxy,param)
	print("OnEvent_1179 begin");
	if proxy:IsCompleteEvent(1175) == false then
		--�W�F�l���[�^�N��
		proxy:EnableGeneratorSystem(2540,true);
		proxy:PlayAnimation(358,3005);
		proxy:OnRegistFunc(1183,"Check_1183","OnEvent_1183",1,once);
		proxy:SetEventFlag(1179,true);
	end
	print("OnEvent_1179 end");
end


--------------------------------------------------------------------------------------
--�W�F�l���[�^�N����1180
--------------------------------------------------------------------------------------
function OnEvent_1180(proxy,param)
	print("OnEvent_1180 begin");
	if proxy:IsCompleteEvent(1176) == false then
		--�W�F�l���[�^�N��
		proxy:EnableGeneratorSystem(2541,true);
		proxy:SetEventFlag(1180,true);
		proxy:PlayAnimation(359,3005);
		proxy:OnRegistFunc(1184,"Check_1184","OnEvent_1184",1,once);
	end
	print("OnEvent_1180 end");
end







--------------------------------------------------------------------------------------
--�������ς݁@���������@�� function
--------------------------------------------------------------------------------------





--------------------------------------------------------------------------------------
--�}���`�ɂȂ������Ƀz�X�g���ᖳ�������灡����
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end

--------------------------------------------------------------------------------------
--��̔p�����̔�A��1064
--------------------------------------------------------------------------------------

--��1064����̔p�����̔�A��
function OnEvent_1064(proxy, param)
	print("OnEvent_1064 begin");

	proxy:PlayAnimation( 1412 , 1 );--���̃A�j���[�V����
	
	if 	proxy:IsCompleteEvent( URUBAIN_STATE_HELP ) == true and --�����ď�Ԃ�
		proxy:IsCompleteEvent( 1250 ) == true then	--����|���Ă���
		SetNpcStateFlag(proxy,param,urubain_flag_list,URUBAIN_STATE_THANKS);
	end	
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 1064 , 1 );--�J��A(��O����J����)�ւ̑���𖳌��ɂ���B
		return;
	end
--[[	
	proxy:NotNetMessage_begin();
		--��1064_1���v���C���[�A�j���[�V�����̏I���C�x���g��
		proxy:OnChrAnimEnd( 1064, 10000, ANIMEID_OPEN, "OnEvent_1064_1", once );
	proxy:NotNetMessage_end();
]]	
--	proxy:DisableMove(10000,1);	 --�L�����N�^���ړ��A����s�\��
	proxy:WarpDmy( 10000 , 1412 , 191 );
	
	proxy:SetEventFlag( 1064 , 1 );--�J��A(��O����J����)�ւ̑���𖳌��ɂ���B
	
	print("OnEvent_1064 end");
end
--[[
--��1064_1���v���C���[�A�j���[�V�����̏I���C�x���g��
function OnEvent_1064_1(proxy, param)
	print("OnEvent_1064_1 begin");
	
	proxy:DisableMove(10000,0);	--�L�����N�^���ړ��A����\��
	
	print("OnEvent_1064_1 end");
end
]]

--------------------------------------------------------------------------------------
--��̔p����̗��J����(���X�C�b�`C)��1074
--------------------------------------------------------------------------------------
--��1074�����X�C�b�`��
function OnEvent_1074(proxy, param)
	print("OnEvent_1074 begin");

	--���A�j��
	proxy:PlayAnimation( 1413, 1 );
	
	proxy:NotNetMessage_begin();
		--��1074_1��***�����ǉ�***0.5�b�づ
		proxy:OnKeyTime2( 1074, "OnEvent_1074_1", 0.5, 0, 0, once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1074, 1 );
	
	print("OnEvent_1074 end");
end

--��1074_1��0.5�b�っ
function OnEvent_1074_1(proxy, param)
	print("OnEvent_1074_1 begin");
	
	proxy:PlayAnimation( 1406, 1 );	--�����J���A�j��
	
	print("OnEvent_1074_1 end");
end



--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ1084
--------------------------------------------------------------------------------------

--��1084���p�j�f�[�����̓o�ꁡ
function OnEvent_1084(proxy, param)
	print("OnEvent_1084 begin");

	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m03_02_00_00);
	
	print("OnEvent_1084 end");
end

--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ1084
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m03_02_00_00(proxy, param)
	print("PlayerDeath_m03_02_00_00");
	--[[
	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m03_02_00_00);
	proxy:SetEventFlag( 1084 , 1 );
	]]
	print("PlayerDeath_m03_02_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m03_02_00_00(proxy,param)
	print("PlayerRevive_m03_02_00_00");
	--[[
	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m03_02_00_00);
	proxy:SetEventFlag( 1084 , 0 );
	]]
	print("PlayerRevive_m03_02_00_00");
end



--------------------------------------------------------------------------------------
--��1160�������J���|�����Đ���
--------------------------------------------------------------------------------------

function OnEvent_1160(proxy , param)
	print("OnEvent_1160 begin");
	
	if param:IsNetMessage() == true then
		--�����ҏo���|����
		proxy:RequestRemoPlus(30202,REMO_FLAG,1160,1, param:GetPlayID()+10001);
	else
		--�|�����Đ�
		proxy:RequestRemo(30202,REMO_FLAG,1160,1);
	end
	
	proxy:SetEventFlag( 1160 , 1 );--�t���O�Z�b�g
	
	print("OnEvent_1160 end");
end


--���|�����Đ��J�n(�t�F�[�h�I��)
function OnEvent_1160_RemoStart(proxy,param)
	print("OnEvent_1160_RemoStart begin");	
	print("OnEvent_1160_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��)
function OnEvent_1160_RemoFinish(proxy , param)
	print("OnEvent_1160_RemoFinish begin");
	
	proxy:EndAnimation( 1409 , 1 );--�Ή���������J���A�j���Đ��I��
	--���A�j��
	proxy:EndAnimation( 1405, 1 );
	
	print("OnEvent_1160_RemoFinish end");
end


--------------------------------------------------------------------------------------
--�ÍԎ��l�ʏ큡1185
--------------------------------------------------------------------------------------
function OnEvent_1185(proxy,param)
	print("OnEvent_1185 begin");
		
	--�ÍԎ��l�̏�Ԃ��ÍԂQ�ɂ���ɂ���
	SetNpcStateFlag(proxy,param,syuujin_flag_list,SYUUJIN_STATE_STAY);
	proxy:SetEventFlag(1185,true);

	print("OnEvent_1185 end");
end

--------------------------------------------------------------------------------------
--�ÍԎ��l�G�΁�1185
--------------------------------------------------------------------------------------
function OnEvent_1185_1(proxy, param)
	print("OnEvent_1185_1 begin");

	--���W�b�NON
	proxy:EnableLogic( 678 , true );
	
	--�ÍԎ��l�̏�Ԃ��ÍԂQ�G�΂ɂ���
	SetNpcStateFlag(proxy,param,syuujin_flag_list,SYUUJIN_STATE_ANGRY_02);
	proxy:SetTeamType( 678, TEAM_TYPE_AngryFriend );
	proxy:SetEventFlag(1185,true);

	print("OnEvent_1185_1 end");
end


--------------------------------------------------------------------------------------
--�ÍԎ��l���S��1186
--------------------------------------------------------------------------------------
function OnEvent_1186(proxy, param)
	print("OnEvent_1186 begin");

	--�ÍԎ��l�̏�Ԃ����S�ɂ���
	SetNpcStateFlag(proxy, param, syuujin_flag_list, SYUUJIN_STATE_DEAD );
	proxy:SetEventFlag( 1186 , 1 );
	
	print("OnEvent_1186 end");
end



--------------------------------------------------------------------------------------
--���@�g�����A�N�V������1181
--------------------------------------------------------------------------------------
function Check_1181(proxy,param)
	if proxy:IsAlive(357) == true then
		local eneid = 370;
		local maxid = 374;
		for eneid = 370, maxid , 1 do
			if proxy:IsAlive(eneid) == false then
				proxy:PlayAnimation(357,3005);
				return false;
			end
		end
		return false;
	end
	return true;	
end

--����
function OnEvent_1181(proxy,param)
	print("OnEvent_1181 begin");
	print("OnEvent_1181 end");
end


--------------------------------------------------------------------------------------
--���@�g�����A�N�V������1182
--------------------------------------------------------------------------------------
function Check_1182(proxy,param)
	if proxy:IsAlive(356) == true then
		--PC���w�肳�ꂽ�̈�ɐN�����Ă��Ȃ������ꍇ
		if proxy:IsCompleteEvent( 1182 ) == false then
			local eneid;
			local maxid;
			if proxy:IsCompleteEvent(1151) == false then
				eneid = 476;
				maxid = 479;
			elseif proxy:IsCompleteEvent(1152) == false then
				eneid = 480;
				maxid = 483;
			elseif proxy:IsCompleteEvent(1153) == false then
				eneid = 484;
				maxid = 487;
			elseif proxy:IsCompleteEvent(1154) == false then
				eneid = 488;
				maxid = 491;
			elseif proxy:IsCompleteEvent(1155) == false then
				eneid = 492;
				maxid = 497;
			elseif proxy:IsCompleteEvent(1156) == false then
				eneid = 498;
				maxid = 501;
			else
				eneid = 502;
				maxid = 505;
			end
			for IndexID = eneid, maxid , 1 do
				--�e�W�F�l���[�^���̉e�l�������Ă邩�ǂ����̔���
				if proxy:IsAlive(IndexID) == false then
					proxy:PlayAnimation(356,3005);	--�e�l������ł��犙��U�郂�[�V����������
					return false;
				end
			end
			return false;
		end
		return false;
	end
	return true;
end

--����
function OnEvent_1182(proxy,param)
	print("OnEvent_1182 begin");
	print("OnEvent_1182 end");
end


--------------------------------------------------------------------------------------
--���@�g�����A�N�V������1183
--------------------------------------------------------------------------------------
function Check_1183(proxy,param)
	if proxy:IsAlive(358) == true then
		local eneid = 507;
		local maxid = 511;
		for eneid = 507, maxid , 1 do
			if eneid ~= 506 then
				if proxy:IsAlive(eneid) == false then
					proxy:PlayAnimation(358,3005);
					return false;
				end
			end
		end
		return false;
	end
	return true;
end

--����
function OnEvent_1183(proxy,param)
	print("OnEvent_1183 begin");
	print("OnEvent_1183 end");
end


--------------------------------------------------------------------------------------
--���@�g�����A�N�V������1184
--------------------------------------------------------------------------------------
function Check_1184(proxy,param)
	if proxy:IsAlive(359) == true then
		local eneid = 512;
		local maxid = 516;
		for eneid = 512, maxid , 1 do
			if proxy:IsAlive(eneid) == false then
				proxy:PlayAnimation(359,3005);
				return false;
			end
		end
		return false;
	end
	return true;
end

--����
function OnEvent_1184(proxy,param)
	print("OnEvent_1184 begin");
	print("OnEvent_1184 end");
end

--------------------------------------------------------------------------------------
--���[�����m�������o����
--------------------------------------------------------------------------------------
function Move_Skeleton(proxy, param, ActID, SkeletonCharaID)
	proxy:StopLoopAnimation(SkeletonCharaID);
	proxy:PlayAnimation(SkeletonCharaID, 7001);--�N���オ��A�j���Đ�
	proxy:SetSpStayAndDamageAnimId(SkeletonID,-1,-1);--����ҋ@�A�j���̖�����
	proxy:SetColiEnable(SkeletonCharaID, true);--�A�^��ON
	proxy:EnableLogic( SkeletonCharaID, true );--���W�b�NON
	print("�[�����m("..SkeletonCharaID..")�N��");
	proxy:SetEventFlag(ActID, true);
end

---------------------------------
--�[�����m�N���֐�����
---------------------------------
function OnEvent_1390(proxy, param)	Move_Skeleton(proxy, param, 1390, 290);end
function OnEvent_1391(proxy, param)	Move_Skeleton(proxy, param, 1391, 291);end
function OnEvent_1392(proxy, param)	Move_Skeleton(proxy, param, 1392, 292);end
function OnEvent_1393(proxy, param)	Move_Skeleton(proxy, param, 1393, 293);end
function OnEvent_1394(proxy, param)	Move_Skeleton(proxy, param, 1394, 294);end
function OnEvent_1395(proxy, param)	Move_Skeleton(proxy, param, 1395, 295);end
function OnEvent_1396(proxy, param)	Move_Skeleton(proxy, param, 1396, 434);end
function OnEvent_1397(proxy, param)	Move_Skeleton(proxy, param, 1397, 435);end
function OnEvent_1398(proxy, param)	Move_Skeleton(proxy, param, 1398, 436);end


--------------------------------------------------------------------------------------
--���E�B���I�E�B�X�v������
--------------------------------------------------------------------------------------
function WillOTheWisp_Explosion(proxy ,param ,ActID, WillID)
	proxy:DeleteObjSfxEventID(WillID);
	proxy:CastPointSpell_Horming(340, WillID, 10170 , 0,0,0,WillID);
	proxy:SetEventFlag(ActID ,true);
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( ActID,"WispRumble",1.2,0,WillID,once);
	proxy:NotNetMessage_end();
	
	print("�E�B���I�E�B�X�v�i"..WillID.."�j�����I");
end

---------------------------------
--�E�B���I�E�B�X�v�����֐�����
---------------------------------
function OnEvent_1370(proxy, param)	WillOTheWisp_Explosion(proxy, param, 1370, 1480);end
function OnEvent_1371(proxy, param)	WillOTheWisp_Explosion(proxy, param, 1371, 1481);end
function OnEvent_1372(proxy, param)	WillOTheWisp_Explosion(proxy, param, 1372, 1482);end
function OnEvent_1373(proxy, param)	WillOTheWisp_Explosion(proxy, param, 1373, 1483);end
function OnEvent_1374(proxy, param)	WillOTheWisp_Explosion(proxy, param, 1374, 1484);end
function OnEvent_1375(proxy, param)	WillOTheWisp_Explosion(proxy, param, 1375, 1485);end

function WispRumble(proxy,param)
	print("WispRumble begin");
	proxy:AddRumble(121, param:GetParam3(), -1,1.0, 25.0);
	print("WispRumble end");
end

-----------------------------------------------------------------------------
--��1380�`1381�����ˏo�g���b�v
-----------------------------------------------------------------------------
--��1380�����ˏo�g���b�v��----------------------------------------------------
function OnEvent_1380(proxy,param)
	print("OnEvent_1380 begin");
	proxy:PlayAnimation( 1430, 1 );
	proxy:OnCharacterAnimEnd( 1380, 1430, 1, "OnEvent_1380_1", once );
	proxy:SetEventFlag( 1380, true );
	print("OnEvent_1380 end");
end
function OnEvent_1380_1(proxy,param)
	print("OnEvent_1380_1 begin");
	proxy:OnKeyTime2( 1380, "OnEvent_1380_2", 0.0, 0, 2, once );
	print("OnEvent_1380_1 end");
end
function OnEvent_1380_2(proxy,param)
	print("OnEvent_1380_2 begin");
	proxy:PlayAnimation( 1440, 1 );
	print("OnEvent_1380_2 end");
end


--��1381�����ˏo�g���b�v��----------------------------------------------------
function OnEvent_1381(proxy,param)
	print("OnEvent_1381 begin");
	proxy:PlayAnimation( 1431, 1 );
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd( 1381, 1431, 1, "OnEvent_1381_1", once );
	proxy:NotNetMessage_end();
	proxy:CreateSfx_DummyPoly(1431, 1, 93006 );--�V����SFX��ݒ�
	proxy:SetEventFlag( 1381, true );
	print("OnEvent_1381 end");
end
function OnEvent_1381_1(proxy,param)
	print("OnEvent_1381_1 begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1381, "OnEvent_1381_2", 0.0, 0, 2, once );
		proxy:OnKeyTime2( 1381, "OnEvent_1381_2", 0.5, 0, 3, once );
		proxy:OnKeyTime2( 1381, "OnEvent_1381_2", 1.0, 0, 4, once );
	proxy:NotNetMessage_end();
	print("OnEvent_1381_1 end");
end
function OnEvent_1381_2(proxy,param)
	print("OnEvent_1381_2 begin");
	proxy:ForcePlayAnimation( 1441, 1 );
	print("OnEvent_1381_2 end");
end

-------------------------------------------------------------------------------------
--��1220���{�X�J�����ݒ聡
--------------------------------------------------------------------------------------
function OnEvent_1220(proxy,param)
	--print("OnEvent_1220 begin");
	--�{�X������ł��Ȃ��@���@�{�X�Ƃ̐퓬���J�n���Ă���
	if proxy:IsCompleteEvent( 4895 ) == false and proxy:IsCompleteEvent( 4897 ) == true then
		--�{�X��@�񃍃b�N�J����
		proxy:SetCamModeParamTargetId(3021);
		--�{�X��@���b�N�J����
		proxy:SetCamModeParamTargetIdForBossLock(3020);
	end
	--print("OnEvent_1220 end");
end


--------------------------------------------------------------------------------------
--�y�z�΂̐���z���S��1234
--------------------------------------------------------------------------------------
--�y�z�΂̐���z���S��1234
function OnEvent_1234(proxy,param)
	print("OnEvent_1234 begin");
	
	--�t���OON
	proxy:SetEventFlag( 1234, true );
	
	print("OnEvent_1234 end");
end


--------------------------------------------------------------------------------------
--��8020���z�΂̐��삩��A�C�e���擾��
--------------------------------------------------------------------------------------
function OnEvent_8020(proxy,param)
	print("OnEvent_8020 begin");
	proxy:SetEventFlag( 8020 , true );
	print("OnEvent_8020 end");
end

--[[------------------------------------�����@�g�����e�l�֘A��------------------------------------------------]]--
--------------------------------------------------------------------------------------
--���@�g��(100)���S��1310
--------------------------------------------------------------------------------------
function OnEvent_1310(proxy,param)
	print("OnEvent_1310 begin");
	--�W�F�l���[�^����
	proxy:EnableGeneratorSystem(1450,false);
	proxy:EnableGeneratorSystem(1451,false);
	proxy:EnableGeneratorSystem(1452,false);
	proxy:EnableGeneratorSystem(1453,false);
	proxy:EnableGeneratorSystem(1454,false);
	proxy:EnableGeneratorSystem(1455,false);
	print("�e�l�W�F�l���[�^�[����");
	
	--���ݏo�����e�l���S
	proxy:ForceDead(200);
	proxy:ForceDead(201);
	proxy:ForceDead(202);
	proxy:ForceDead(203);
	proxy:ForceDead(204);
	proxy:ForceDead(205);
	proxy:ForceDead(206);
	proxy:ForceDead(207);
	proxy:ForceDead(208);
	proxy:ForceDead(209);
	proxy:ForceDead(210);
	print("���҂��ꂽ�e�l����");
	
	--�t���O�Z�b�g
	proxy:SetEventFlag(1310,true);

	print("OnEvent_1310 end");
end
--------------------------------------------------------------------------------------
--���@�g��(101)���S��1320
--------------------------------------------------------------------------------------
function OnEvent_1320(proxy,param)
	print("OnEvent_1320 begin");
	--�W�F�l���[�^����
	proxy:EnableGeneratorSystem(1460,false);
	proxy:EnableGeneratorSystem(1461,false);
	proxy:EnableGeneratorSystem(1462,false);
	proxy:EnableGeneratorSystem(1463,false);
	print("�e�l�W�F�l���[�^�[����");
	
	--���ݏo�����e�l���S
	proxy:ForceDead(220);
	proxy:ForceDead(221);
	proxy:ForceDead(222);
	proxy:ForceDead(223);
	proxy:ForceDead(224);
	print("���҂��ꂽ�e�l����");
	  
	--�t���O�Z�b�g
	proxy:SetEventFlag(1320,true);

	print("OnEvent_1320 end");
end
--------------------------------------------------------------------------------------
--���@�g��(102)���S��1330
--------------------------------------------------------------------------------------
function OnEvent_1330(proxy,param)
	print("OnEvent_1330 begin");
	--�W�F�l���[�^����
	proxy:EnableGeneratorSystem(1470,false);
	print("�e�l�W�F�l���[�^�[����");

	--���ݏo�����e�l���S
	proxy:ForceDead(230);
	proxy:ForceDead(231);
	print("���҂��ꂽ�e�l����");
	
	--�t���O�Z�b�g	
	proxy:SetEventFlag(1330,true);
	
	print("OnEvent_1330 end");
end

--[[------------------------------------�����@�g�����e�l�֘A��------------------------------------------------]]--


-----------------------------------------------------------------------------
--��1040�������g�J�Q�C�x���g3
-----------------------------------------------------------------------------
function OnEvent_1040(proxy,param)
	print("OnEvent_1040 begin");
	proxy:SetEventFlag( 1040 , true );
	proxy:DeleteEvent( 1040 );
	print("OnEvent_1040 end");
end


-----------------------------------------------------------------------------
--��1400�����@�ǔj��3
-----------------------------------------------------------------------------
function OnEvent_1400(proxy,param)
	print("OnEvent_1400 begin");
	proxy:InvalidSfx( 2470 , true );
	proxy:SetEventFlag( 1400,true );
	print("OnEvent_1400 end");
end
