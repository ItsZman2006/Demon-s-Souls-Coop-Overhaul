
function Initialize_m02_01_00_00(proxy)
	print("Initialize_m02_01_00_00 begin");

--[[
--OBJ��ID512������OBJ�@ID513���{��
--��512���o���X�^�C�x���g�J�n��
	proxy:RepeatMessage_begin();
		proxy:OnDistanceActionPlus(512, 10000, 1200, "OnEvent_512", 1.5, HELPID_START, 180, 45, 0,0,1,everytime);
	proxy:RepeatMessage_end();
	--���[�v�A�j�������p
	proxy:LuaCall(512,2,"OnEvent_512_2",everytime);
	
--��513���o���X�^�����p�������p�̃C�x���gID�ƃo���X�^�pOnBallista�̃C�x���gID�͓����Aparam�͕ς��Ȃ���
	proxy:LuaCall(513,0,"OnEvent_513_0",everytime);--0	�cY���p�x����
	proxy:LuaCall(513,1,"OnEvent_513_1",everytime);--1	�cX���p�x����
	proxy:LuaCall(513,2,"OnEvent_513_2",everytime);--2	�c�o���X�^���˓���
	proxy:LuaCall(513,3,"OnEvent_513_3",everytime);--3	�c�o���X�^�I������
	proxy:LuaCall(513,4,"OnEvent_513_4",everytime);--4	�c�o���X�^�_���[�W�I��
	proxy:LuaCall(513,5,"OnEvent_513_5",everytime);--5	�c�t���O�����p
]]
	

--��582���{�X�����ɓ��遡
	
	--���{�X�������Ă���Ƃ������C�x���g�o�^
	if proxy:IsCompleteEvent( 4224 ) == false then
	
		--�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B
		SingleReset(proxy, 582);

		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���)
		proxy:LuaCall( 583, 1, "OnEvent_583_1", everytime );
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCall( 583 , 5 , "OnEvent_582_GO_TO_IN" , everytime );
		--���t���O�Z�b�g(�����p)
		proxy:LuaCall( 583 , 6 , "OnEvent_582_flag_set" , everytime );
		
		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ�
		if proxy:IsCompleteEvent( 582 ) == false then
		
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l����
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--��582�����ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegionAttribute( 582, 2894, "OnEvent_582", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B
		
			proxy:NotNetMessage_begin();
				--��583�����ɓ��邽�߂̃C�x���g��ǉ���--�n���h���͏�Ɠ���
				proxy:OnPlayerActionInRegion( 583, 2894, "OnEvent_582", HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();		
		end
		proxy:SetColiEnableArray(3003,false);--�ʏ햳��
		proxy:SetColiEnableArray(3004,false);--�ʏ햳��
		proxy:SetColiEnableArray(3005,true);--�{�X�p�L��
		proxy:SetColiEnableArray(3006,true);--�{�X�p�L��	
	else
		proxy:SetColiEnableArray(3003,true);--�ʏ�L��
		proxy:SetColiEnableArray(3004,true);--�ʏ�L��
		proxy:SetColiEnableArray(3005,false);--�{�X�p����
		proxy:SetColiEnableArray(3006,false);--�{�X�p����
	end

	
--��584���{�X�̃|�����Đ���

	if proxy:IsCompleteEvent( 584 ) == false then 
	
		--���{�X�O�̃|�����Đ��p�Ď��ǉ�
		proxy:OnRegionJustIn( 584 , 10000 , 2898 , "OnEvent_584" , once );
		
		proxy:NotNetMessage_begin();
			--�|�����J�n�ɌĂ΂��n���h��
			proxy:LuaCall(584, REMO_START, "OnEvent_584_RemoStart", once);
			--�|�����I����ɌĂ΂��n���h��(�g���K�[�N�������l�p)
			proxy:LuaCall(584, REMO_FINISH, "OnEvent_584_RemoFinish", once);
		proxy:NotNetMessage_end();
	
	end


--��585���{�X�퓬�J�n��
	if proxy:IsCompleteEvent( 4224 ) == false then
		--�V���O�����[�h��������
		SingleReset( proxy , 585 );
		proxy:OnRegionJustIn( 585 , 10000 , 2886 , "OnEvent_585" , once );
	end


	
--��4224�����{�X���S�ŉ������N���遡
	proxy:AddFieldInsFilter( 801 );
	if proxy:IsCompleteEvent( 4224 ) == false then		
		proxy:OnCharacterDead( 4224, 801, "OnEvent_4224", once );
	end
	

--��680���������ŊJ����(�T�u�C�x���g)��
	if proxy:IsCompleteEvent( 680 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceActionPlus( 680, 10000, 1202, "OnEvent_680", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, 0.7, -1.0, 0.0, everytime );
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 680, 1, "OnEvent_680_1", once );--�A�j���[�V���������p
	else
		proxy:EndAnimation( 1202, 1 );
	end
	

--��682���������ŊJ����(�T�u�C�x���g)��
	if proxy:IsCompleteEvent( 682 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceActionPlus( 682, 10000, 1205, "OnEvent_682", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, 1.0, -1.0, 0.0, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 682, 1, "OnEvent_682_1", once );--�A�j���[�V���������p
	else
		proxy:EndAnimation( 1205, 1 );
	end


--��684���������ŊJ����(�T�u�C�x���g)��
	if proxy:IsCompleteEvent( 684 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceActionPlus( 684, 10000, 1206, "OnEvent_684", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, 1.0, -1.0, 0.0, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 684, 1, "OnEvent_684_1", once );--�A�j���[�V���������p
	else
		proxy:EndAnimation( 1206, 1 );
	end

--��686���������ŊJ����(�T�u�C�x���g)��
	if proxy:IsCompleteEvent( 686 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceActionPlus( 686, 10000, 1203, "OnEvent_686", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, 1.0, -1.0, 0.0, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 686, 1, "OnEvent_686_1", once );--�A�j���[�V���������p
	else
		proxy:EndAnimation( 1203, 1 );
	end

--��688���������ŊJ����(�T�u�C�x���g)��
	if proxy:IsCompleteEvent( 688 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceActionPlus( 688, 10000, 1204, "OnEvent_688", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, 1.0, -1.0, 0.0, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 688, 1, "OnEvent_688_1", once );--�A�j���[�V���������p
	else
		proxy:EndAnimation( 1204, 1 );
	end

	
--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m02_01_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m02_01_00_00", everytime );
	proxy:NotNetMessage_end();

--��15622�������̎��̂𒲂ׂ����H��
	if proxy:IsCompleteEvent( 15622 ) == false then
		proxy:AddCorpseEvent( 15622 , 115 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15622 ,0 , "OnEvent_15622",once );
 		proxy:NotNetMessage_end();
	end
	
--��560�������̎��S��	
	if proxy:IsCompleteEvent( 560 ) == false then
		proxy:OnCharacterDead( 560 , 115 , "OnEvent_560" , once );
	end
	
	
	

----- ���r�������O������ ----------------------------------------		

--��520���r�������ӂ��遡
	--(�Ή���������J�����Ƃ��� ��ԕύX) 
--[[
	
--��521���r����������|���ɍs����(��b�V�X�e������Ăяo��)
	if proxy:IsCompleteEvent( 521 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 521 , 0 , "OnEvent_521" , once );--��b�V�X�e������Ăяo���ꍇ��param=0���w��
		proxy:NotNetMessage_end();
	end
	
--��522���r�����S�����ŐQ�遡(��b�V�X�e������Ăяo��)
	if proxy:IsCompleteEvent( 522 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 522 , 0 , "OnEvent_522" , once );--��b�V�X�e������Ăяo���ꍇ��param=0���w��
		proxy:NotNetMessage_end();
	end

--��523���r������ǂŐQ�遡
	--(���������񂾂Ƃ��ɁA����)

--��524���r�������̃u���b�N�ֈړ����遡
	--(���������񂾂Ƃ��ɁA�Ď��ǉ�)

--��525���r�����S���œG�ɂȂ遡
	if proxy:IsCompleteEvent( 525 ) == false then
		proxy:OnCharacterTotalDamage( 525 , 622 , 10000 , 100 , "OnEvent_525" , once );
	end
	
--��526���r������ǂœG�ɂȂ遡
	if proxy:IsCompleteEvent( 526 ) == false then
		proxy:OnCharacterTotalDamage( 526 , 622 , 10000 , 100 , "OnEvent_526" , once );
	end
	
--��527���r�������ʁ�
	if proxy:IsCompleteEvent( 527 ) == false then
		proxy:OnCharacterDead(527,622,"OnEvent_527",once);
	end
]]	
------- ���r�������O������ --------------------------------------	


--��652�������h���ǂ��������mA�̎��S��
	if proxy:IsCompleteEvent( 652 ) == false then
		--proxy:OnCharacterDead(652,102,"OnEvent_652",once);
		proxy:OnCharacterDead(652,102,"OnEvent_720",once);
	end
	
--��654�������h���ǂ��������mB�̎��S��
	if proxy:IsCompleteEvent( 654 ) == false then
		--proxy:OnCharacterDead(654,103,"OnEvent_654",once);
		proxy:OnCharacterDead(654,103,"OnEvent_720",once);
	end
	
--��655�������h���ǂ��������mC�̎��S��
	if proxy:IsCompleteEvent( 655 ) == false then
		proxy:OnCharacterDead(655,104,"OnEvent_720",once);
	end
	
--��656�������h���ǂ��������mD�̎��S��
	if proxy:IsCompleteEvent( 656 ) == false then
		proxy:OnCharacterDead(656,105,"OnEvent_720",once);
	end

--��657�������h���ǂ��������mE�̎��S��
	if proxy:IsCompleteEvent( 657 ) == false then
		proxy:OnCharacterDead(657,106,"OnEvent_720",once);
	end
	
--��658�������h���ǂ��������mD�̎��S��
	if proxy:IsCompleteEvent( 658 ) == false then
		proxy:OnCharacterDead(658,107,"OnEvent_720",once);
	end





--[[-- ����H�V���b�v�� -------------------------------------------------------

--��760����H�̓G�Ή���
	if proxy:IsCompleteEvent( 760 ) == false then
		proxy:OnCharacterTotalDamage( 760, 623, 10000, 100, "OnEvent_760", once );
	end

--��761����H�̎��S��
	if proxy:IsCompleteEvent( 761 ) == false then
		proxy:OnCharacterDead( 761 , 623 , "OnEvent_761" , once );
	end		

----- ����H�V���b�v�� --------------------------------------------------------
]]


----- ����(�ő�)�� ----------------------------------------------------------	

--��830���̈�Ď���
	proxy:OnNetRegion(830 , 2320);	
--��831���̈�Ď���
	proxy:OnNetRegion(831 , 2321);	
--��832���̈�Ď���
	proxy:OnNetRegion(832 , 2322);	

----- ����(�ő�)�� ----------------------------------------	

--�����{�X�����S���Ă�����
	--���̏����S�Č�
	if proxy:IsCompleteEvent( 4224 ) ==false then
		--���̏��̏�����		
		proxy:EnableLogic( 801 , false );		
	else
		--���̏��폜(������)
		InvalidBackRead( proxy , 801 );
		
		--��ɂ����ʕ��m�폜(������)
		local enemy_list = {120,121,122,123,124,125,126,127};
		local enemy_num  = table.getn( enemy_list );
		
		for i=1, enemy_num, 1 do
			InvalidBackRead( proxy, enemy_list[i] );
		end
	end
	
	--��ɂ����ʕ��m���Z�[�u���[�h�̑Ώۂ���O��
	local enemy_list = {120,121,122,123,124,125,126,127};
	local enemy_num  = table.getn( enemy_list );
	
	for i=1, enemy_num, 1 do
		proxy:AddFieldInsFilter(enemy_list[i] );
	end	
	
	
	--�����{�X���S�Ŕ����J��(����ł�����A�`��Ɠ����������)
	if proxy:IsCompleteEvent( 4224 ) == true then
		proxy:SetColiEnable( 1998 , false );
		proxy:SetColiEnable( 1994 , false );
	
		proxy:SetDrawEnable( 1998 , false );
		proxy:SetDrawEnable( 1994 , false );

		--SFX OFF
		proxy:InvalidSfx( 1986 , false );
		proxy:InvalidSfx( 1990 , false );
	end
	
	
	
	--��4252,4254���\�E������A�v�΂Ń��[�v��
	if proxy:IsCompleteEvent( 4224 ) ==true then--�{�X������ł���Ƃ�
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--���点��
		--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
		if proxy:IsCompleteEvent( 4252 ) == false then
			proxy:ValidSfx( 1220 );--SFX �L����
			proxy:ValidSfx( 1221 );--SFX �L����
			proxy:OnDistanceActionAttribute( 4252 , 10000 , 1981 , "OnEvent_4252" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );

			--�\�E���L����
			proxy:SetDrawEnable( 1981 , true );
			proxy:SetColiEnable( 1981 , true );
			--�\�E��2�L����
			proxy:SetDrawEnable( 1976 , true );
			proxy:SetColiEnable( 1976 , true );
		else
			--���v�΂Ń��[�v�p�̊Ď���ǉ���
			proxy:InvalidSfx( 1220, false );--���̗��q
			SingleReset(proxy,4254);
			proxy:OnDistanceActionAttribute( 4254 , 10000 , 1981 , "OnEvent_4254" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end

	else
		--�\�E��������
		proxy:SetDrawEnable( 1981 , false );
		proxy:SetColiEnable( 1981 , false );
		--�\�E��2������
		proxy:SetDrawEnable( 1976 , false );
		proxy:SetColiEnable( 1976 , false );
		--SFX ������
		proxy:InvalidSfx( 1221 , false );
		proxy:InvalidSfx( 1220 , false );
	end
	
	--���{�X�|���Ă���
	if proxy:IsCompleteEvent( 4224 ) == true then
		--����|�������I����ĂȂ����
		if proxy:IsCompleteEvent( 571 ) == false then
			local attr = ATTR_NOSESSION + ATTR_LIVE + ATTR_GREY;
			proxy:NotNetMessage_begin();
			--proxy:OnDistanceActionAttribute( 570 , 10000 , 1270 , "OnEvent_570" , DoorDist_A,HELPID_OPEN,180,DoorAngle_A,attr,everytime);
			
			proxy:OnRegionJustIn( 570 , 10000 , 2250 , "OnEvent_570" , everytime );
			
			proxy:LuaCall( 571 , REMO_START ,"OnEvent_571_RemoStart",once);
			proxy:LuaCall( 571 , REMO_FINISH,"OnEvent_571_RemoFinish",once);
			proxy:NotNetMessage_end();
		else
			--�����J���Ă���
			proxy:EndAnimation( 1270 , 2);
			proxy:InvalidSfx( 2210 , false);
		end
	end
	
	--[[
	--��652�������h���ǂ��������mA�̎��S��
	if proxy:IsCompleteEvent( 652 ) == true then		
		InvalidCharactor( proxy,102);
	end
		
	--��654�������h���ǂ��������mB�̎��S��
	if proxy:IsCompleteEvent( 654 ) == true then
		InvalidCharactor( proxy,103);
	end
	
	--��655�������h���ǂ��������mC�̎��S��
	if proxy:IsCompleteEvent( 655 ) == true then
		InvalidCharactor( proxy,104);
	end

	--��656�������h���ǂ��������mD�̎��S��
	if proxy:IsCompleteEvent( 656 ) == true then		
		InvalidCharactor( proxy,105);		
	end
	
	--��657�������h���ǂ��������mE�̎��S��
	if proxy:IsCompleteEvent( 657 ) == true then
		InvalidCharactor( proxy,106);
	end
	
	--��658�������h���ǂ��������mF�̎��S��
	if proxy:IsCompleteEvent( 658 ) == true then
		InvalidCharactor( proxy,107);
	end
	]]
	--���������h���ǂ��������mA�̖�������
	InvalidCharactor( proxy,102);		
	--���������h���ǂ��������mB�̖�������
	InvalidCharactor( proxy,103);
	--���������h���ǂ��������mC�̖�������
	InvalidCharactor( proxy,104);
	--���������h���ǂ��������mD�̖�������
	InvalidCharactor( proxy,105);		
	--���������h���ǂ��������mE�̖�������	
	InvalidCharactor( proxy,106);	
	--���������h���ǂ��������mF�̖�������	
	InvalidCharactor( proxy,107);
	
	if	proxy:IsCompleteEvent(RENDOL_STATE_HELP_HIDING_ME) == true then
		--��652�������h���ǂ��������mA�̗L������
		if proxy:IsCompleteEvent( 652 ) == false then		
			ValidCharactor( proxy,102);
		end
		
		--��654�������h���ǂ��������mB�̗L������
		if proxy:IsCompleteEvent( 654 ) == false then
			ValidCharactor( proxy,103);
		end
	
		--��655�������h���ǂ��������mC�̗L������
		if proxy:IsCompleteEvent( 655 ) == false then
			ValidCharactor( proxy,104);
		end

		--��656�������h���ǂ��������mD�̗L������
		if proxy:IsCompleteEvent( 656 ) == false then		
			ValidCharactor( proxy,105);		
		end
	
		--��657�������h���ǂ��������mE�̗L������
		if proxy:IsCompleteEvent( 657 ) == false then
			ValidCharactor( proxy,106);
		end
	
		--��658�������h���ǂ��������mF�̗L������
		if proxy:IsCompleteEvent( 658 ) == false then
			ValidCharactor( proxy,107);
		end
	end
	
	--��560�������̎��S��
	if proxy:IsCompleteEvent( 560 ) == true then
		if proxy:IsCompleteEvent( 15622 ) == false then
			--��ɂȂ�鎀�̍Č�
			proxy:OpeningDeadPlus( 115, true ,false ,false );
		else			
			--������
			InvalidCharactor( proxy,115);
		end
	end
	
	
	
	--���̖���ʉ߂ł���L�����^�C�v(���̃^�C�v�̐l�����A�N�V�����{�^������������)
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	
	--��670���z�X�gPC�݂̂��ʂ����̖���
	if proxy:IsCompleteEvent( 670 ) == true then--�z�X�g���ʉߍς�
		proxy:SetDrawEnable( 1260 , false );
		proxy:SetColiEnable( 1260 , false );
		proxy:InvalidSfx( 2230 , false );
	else
		--��670�����@�Ǎ폜�����p��
		proxy:LuaCall( 670 , 1 , "OnEvent_670_delete_wall" , once );
		
		--��670���ǂ̒��ɓ���C�x���g�����p��
		proxy:OnDistanceActionAttribute( 670 , 10000 , 1260 , "OnEvent_670" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end	

	
	
--���򗳃C�x���g�֘A������

	--������
	proxy:SetDisableGravity( 110 , true );--�d��OFF
	proxy:EnableLogic( 110 , false );--�v�lOFF
	proxy:SetSuperArmor( 110 , true );--�_���[�W���[�V���������Ȃ�
	proxy:SetDeadMode(110, true);--�򗳂͎��ȂȂ��ݒ�(���ɂ����ɂȂ�����P�ނ���)
	
	--�����ʒu�Ƀ��[�v
	proxy:Warp( 110 , 2330 );

	--������Ԃ��Z�b�g
	SetFirstNpcStateFlag( proxy , param , kenzoku_2_flag_list , KENZOKU_2_STATE_WARNING );
	
	--���݂̏�Ԏ擾
	local now_state = GetNpcStateFlag(proxy, param, kenzoku_2_flag_list);
	
	--�x��
	if now_state == KENZOKU_2_STATE_WARNING then
	
	--�w���w��
	elseif now_state == KENZOKU_2_STATE_HEROHERO then
	
	--���S(����1or����2)
	elseif now_state == KENZOKU_2_STATE_DEAD or
	       now_state == KENZOKU_STATE_DEAD   then
		proxy:OpeningDead( 110, false );
		InvalidCharactor( proxy , 110 );--��(�ő�)������
		
	--���̑�
	else
		InvalidCharactor( proxy , 110 );--��(�ő�)������
	end
	
	
	
--���r�������O�����C�x���g�֘A������	
	
	--������Ԃ�ݒ�
	SetFirstNpcStateFlag(proxy, param, biyo_flag_list, BIYO_STATE_CAPTIVE);
 
	--���݂̏�Ԃ��擾
	local now_state = GetNpcStateFlag( proxy, param, biyo_flag_list );
	
	--�S���Ɏ����
	if now_state == BIYO_STATE_CAPTIVE then
	
		proxy:EnableLogic( 622 , false );--���W�b�NOFF
		proxy:SetEventCommand( 622 , 50 );--EzState�ɐ���ԍ�(���点��)��n��
	
	--������Ă���Ċ���
	elseif now_state == BIYO_STATE_THANKS then
	
		proxy:EnableLogic( 622 , false );
		proxy:SetEventCommand( 622 , 50 );--EzState�ɐ���ԍ�(���点��)��n��
	
	--�S���ŐQ�Ă���
	elseif now_state == BIYO_STATE_SLEEPING_IN_PRISON then
	
		proxy:EnableLogic( 622 , false );
		proxy:SetEventCommand( 622 , 60 );--EzState�ɐ���ԍ�(�Q��)��n��
		
	--�G��(�S��)
	elseif now_state == BIYO_STATE_HOSTILE_IN_PRISON then
	
		--(�\��)
		--���W�b�N�؂�ւ���Ȃǥ��?

	--������|������
	elseif now_state == BIYO_STATE_TARGET_ENEMY then
	
		proxy:Warp( 622 , 2240 );--�w��|�C���g�Ƀ��[�v
	
	--�t�P�ɖ������ĐQ��
	elseif now_state == BIYO_STATE_END_OF_STRIKES_BACK then
	
		proxy:Warp( 622 , 2240 );
		proxy:EnableLogic( 622 , false );
		proxy:SetEventCommand( 622 , 60 );--EzState�ɐ���ԍ�(�Q��)��n��
	
	--�G��(���)
	elseif BIYO_STATE_HOSTILE_IN_RAMPART then
	
		proxy:Warp( 622 , 2240 );
		--���W�b�N�؂�ւ���Ȃǥ��?
	
	--���S
	elseif BIYO_STATE_DEAD then
		InvalidCharactor( proxy , 622 );--������
	
	--����ȊO
	else
		InvalidCharactor( proxy , 622 );--������
	end	
	
	
	
--[[����H�C�x���g�֘A������

	--������Ԃ�ݒ�
	SetFirstNpcStateFlag(proxy, param, kojiki_flag_list, KOJIKI_STATE_SEELING);
 
	--���݂̏�Ԃ��擾
	local now_state = GetNpcStateFlag( proxy, param, kojiki_flag_list );
	
	--�̔���
	if now_state == KOJIKI_STATE_SEELING then
	
		proxy:EnableLogic( 623 , false );--���W�b�NOFF
	
	--�G��(����2)
	elseif now_state == KOJIKI_STATE_HOSTILE_2 then
	
		--(�\��)
	
	--���S
	elseif now_state == KOJIKI_STATE_DEAD then
	
		InvalidCharactor( proxy , 623 );--��H�V���b�v������

	else
		--(���炭���̃}�b�v�ɂ͂��Ȃ�)
	end
]]
	
--��8084������ɗ����t���O�𗧂Ă遡
	proxy:SetEventFlag(8084, true);


--��550���{�X��J�����Ή���
	--�{�X�������Ă���Ȃ�o�^
	if proxy:IsCompleteEvent(4224) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 550 , 10000 , 2886 ,"OnEvent_550" , everytime );
		proxy:NotNetMessage_end();
	end
	
------------------������QWC�֘A������-------------------
--��610��QWC:�\�E�������X�^�[�o���P��
	--�z�X�g�݂̂́A�K���t���O��0�ɂ��āA�G����U����������
	if	proxy:IsClient() == false then
		SingleReset(proxy, 610);
	end
	--�ォ������Ă���l�����ɕ\����On�ɂȂ��Ă��邩�`�F�b�N����
	if	proxy:IsCompleteEvent(610) == false then
		InvalidCharactor( proxy, 150 );
		InvalidCharactor( proxy, 151 );
	end
	if	proxy:IsSuccessQWC(20100) == true then
		print("m02_01 QWC�\�E�������X�^�[�o���@����");
		proxy:OnRegionJustIn( 610, LOCAL_PLAYER, 2200, "OnEvent_610", once );
	else
		print("m02_01 QWC�\�E�������X�^�[�o���@������");
	end
------------------������QWC�֘A������-------------------

--���J���X�C�x���g��SingleReset()���遡
	for IndexID = 850, 870, 1 do
		SingleReset(proxy, IndexID);
	end
	
--���J���X�Ď��ǉ���������
	--�J���X���o�b���߂Â��Ɣ�ї���
	for KarasuID = 850, 870, 1 do
		if proxy:IsCompleteEvent( KarasuID ) == false then
			proxy:OnPlayerDistanceInTarget( KarasuID, 10000, 380 + KarasuID, "OnEvent_"..KarasuID, 5, once );
		else
			proxy:SetDrawEnable(380 + KarasuID, false);
			proxy:SetColiEnable(380 + KarasuID, false);
		end
	end
	
	--�����g�J�Q�C�x���g
	RegistTokage(proxy,590,252,1);
	RegistTokage(proxy,592,253,2);
	
	--��999999���t���[���x��̏����������C�x���g�𔭍s��
	proxy:NotNetMessage_begin();
		--��0�b�づ--
		proxy:OnKeyTime2( 999991, "Second_Initialize_m02_01_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m02_01_00_00 end");
end


--------------------------------------------------------------------------------------
--Initialize����Ă΂��A1�t���[���x��̏�����������999999
--------------------------------------------------------------------------------------
--��999999���ꕔ�AInit�ł͏����ł��Ȃ��̂ŁA�c���Ă���
function Second_Initialize_m02_01_00_00(proxy, param)
	print("Second_Initialize_m02_01_00_00 begin");

------------------������QWC�֘A������-------------------
------------------������QWC�֘A������-------------------
		
	print("Second_Initialize_m02_01_00_00 end");
end

--------------------------------------------------------------------------------------
--4224�����{�X���S�ŉ������N����
--------------------------------------------------------------------------------------
--��4224�����{�X���S�ŉ������N���遡
function OnEvent_4224(proxy,param)
	print("OnEvent_4224 begin");

	proxy:NotNetMessage_begin();
		--��4250���N���C�A���gPC���[�v���o��
		proxy:OnKeyTime2( 4250, "OnEvent_4250", 0, 0, 0, once);
		--��4224_1��1�b�づ
		proxy:OnKeyTime2( 4224, "OnEvent_4224_1", 1.0, 0, 1, once );
		--��4251��2�b�o�߁�
		proxy:OnKeyTime2( 4251, "OnEvent_4251", 2, 0, 2, once);
		
		--�}���`���U�Ď��p
		proxy:OnRegistFunc( 4224 , "Check_4224_PT","OnEvent_4224_PT",0,once);
	proxy:NotNetMessage_end();

	--�����h�����q���T�����Ȃ�A���̃}�b�v�̏�ԂɈڍs
	if	proxy:IsCompleteEvent(RENDOL_STATE_SEARCH_2) == true then
		InvalidCharactor( proxy, 620 );
		RendolCheck(proxy,param);--�֐��̒��ŁA����R������S���A�ǂ���ɏo�����邩����
		--SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_LOCATION_INVISIBLE );
	end

	--�{�X���S�t���O�Z�b�g
	proxy:SetEventFlag( 4224 , 1 );	
	
	proxy:SetColiEnableArray(3003,true);--�ʏ�L��
	proxy:SetColiEnableArray(3004,true);--�ʏ�L��
	proxy:SetColiEnableArray(3005,false);--�{�X�p����
	proxy:SetColiEnableArray(3006,false);--�{�X�p����
		
	--�V�u���b�N�N���A������
	proxy:CustomLuaCallStart( 4050, 801 );
	--�����g�J�Q���Z�b�g
	ResetTokage(proxy);
	
	--�G���A�J���C���t�H���[�V����
	--[[
	if proxy:IsClient() == false then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4224 , "OnEvent_4224_2",5.0,0,0,once);
		proxy:NotNetMessage_end();
	end
	]]
	print("OnEvent_4224 end");
end

--��4224_1��1�b�っ
function OnEvent_4224_1(proxy,param)
	print("OnEvent_4224_1 begin");
	
	--�{�X��|���������X�V(���ɂ���ăt���O�𗧂Ă�)
	GetBossFlagCount( proxy, param );
	
	--���g���t�B�[�擾���聥
	Lua_RequestUnlockTrophy(proxy, 28);
	
	--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
	if proxy:IsCompleteEvent( 4252 ) == false then
	
		--�\�E���L����
		proxy:SetDrawEnable( 1981 , true );
		proxy:SetColiEnable( 1981 , true );
		--�\�E��2�L����
		proxy:SetDrawEnable( 1976 , true );
		proxy:SetColiEnable( 1976 , true );
		
		proxy:ValidSfx( 1220 );--SFX �L����
		proxy:ValidSfx( 1221 );--SFX �L����
		
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--���点��
		proxy:OnDistanceActionAttribute( 4252 , 10000 , 1981 , "OnEvent_4252" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );
	else
		--�\�E��������(������������̂ť��)
		proxy:SetDrawEnable( 1981 , false );
		proxy:SetColiEnable( 1981 , false );
	end	

	print("OnEvent_4224_1 end");
end

--[[
--�G���A����̕\��
function OnEvent_4224_2(proxy,param)
	print("OnEvent_4224_2 begin");
	--�C���t�H�\��
	--�V�X�e�����b�Z�[�W
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationBuffer( 10010740 );
	proxy:PlayTypeSE( 10000 ,SOUND_TYPE_M ,777777777 );
	print("OnEvent_4224_2 end");
end
]]

--------------------------------------------------------------------------------------
--��4250���N���C�A���gPC���[�v���o��
--------------------------------------------------------------------------------------

--��4250���N���C�A���gPC���[�v���o��
function OnEvent_4250(proxy, param)
	print("OnEvent_4250 begin");

	if proxy:IsClient() == true then
		proxy:PlayAnimation( 10000 , 8284 );--���[�v�A�j�����Đ�
	end

	proxy:SetEventFlag( 4250 , 1 );
	
	print("OnEvent_4250 end");
end


--------------------------------------------------------------------------------------
--��4251���V���O���F���̕ǁABGM������
--------------------------------------------------------------------------------------

--��4251���V���O���F���̕ǁABGM������
function OnEvent_4251(proxy, param)
	print("OnEvent_4251 begin");
		
	--�{�X��p��BGM��~
	proxy:StopPointSE( 1 );	
	
--[[	
	--�������h�����q�����̃u���b�N�Ɉړ�����C�x���g�̊Ď��ǉ���
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:NotNetMessage_begin();
			proxy:OnRegistFunc( 722 , "Check_OnEvent_722" , "OnEvent_722" , 1 , once );
		proxy:NotNetMessage_end();
	end
]]	
	--��ɂ����ʕ��m�폜(�������S)
	local enemy_list = {120,121,122,123,124,125,126,127};
	local enemy_num  = table.getn( enemy_list );
	
	for i=1, enemy_num, 1 do
		proxy:ForceDead( enemy_list[i] );
	end
	
	proxy:SetEventFlag( 4251 , 1 );
	
	print("OnEvent_4251 end");
end

--�}���`���U�Ď�
function Check_4224_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--�}���`����Ȃ��Ȃ�
function OnEvent_4224_PT(proxy,param)
	print("OnEvent_4224_PT begin");
	--���{�X�����̑O��̖��@�ǂ�������(�S�v���C���[)
	proxy:SetColiEnable( 1998 , false );
	proxy:SetColiEnable( 1994 , false );
	--proxy:SetObjDeactivate( 1998 , true );--�f�A�N�e�B�u
	--proxy:SetObjDeactivate( 1994 , true );--�f�A�N�e�B�u
	
	proxy:SetDrawEnable( 1998 , false );
	proxy:SetDrawEnable( 1994 , false );
	
	--���{�X�������@�ǂ�SFX�폜
	proxy:InvalidSfx( 1986 , true );
	proxy:InvalidSfx( 1990 , true );
	
	--���{�X�����O�̈ړ������C�x���g���폜
	proxy:DeleteEvent( 582 );--��l�ڂ�����Ƃ��p
	proxy:DeleteEvent( 583 );--��l�ڈȍ~������Ƃ��p
	proxy:DeleteEvent( 584 );--�|�����Đ��p
	proxy:DeleteEvent( 585 );--�{�X�퓬�J�n�p
	print("OnEvent_4224_PT end");
end

--------------------------------------------------------------------------------------
--�Β��Ƀ��[�v(�{�X�|������p)��4254
--------------------------------------------------------------------------------------
--��4254���Β��Ƀ��[�v��
function OnEvent_4254(proxy,param)	
	
	if proxy:IsCompleteEvent( 4254 ) == true then
		return;
	end

	print("OnEvent_4254 begin");	
	
	proxy:RepeatMessage_begin();
		--��4254_1���I�����j���[�̊Ď���
		proxy:OnSelectMenu(4254, "OnEvent_4254_0", 10010710, 0, 2, 1981, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_4254 end");
end

--��4254_0���I�����j���[�̊Ď���
function OnEvent_4254_0(proxy, param)
	print("OnEvent_4254_0 begin");	
	
	if proxy:IsSession() == false then		
		proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ�
		proxy:NoAnimeTurnCharactor( 10000 , 1981 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--���v�΂ɐG���A�j���Đ��I����
			proxy:OnChrAnimEnd( 4254 , 10000 , 8283 , "OnEvent_4254_1" , once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 4254 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_4254_0 end");
end

--��4254_1�������E�ɋA��A�j���Đ��I����
function OnEvent_4254_1(proxy,param)	
	print("OnEvent_4254_1 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ�
	
	--�Β��֖߂��Ă�������̃t���O�𗧂Ă�
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag( 4254 , 0 );
	--���S�񕜗v��
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1006 );
	
	print("OnEvent_4254_1 end");
end


--------------------------------------------------------------------------------------
--��4252���\�E�����聡
--------------------------------------------------------------------------------------

function OnEvent_4252(proxy, param)
	print("OnEvent_4252 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--�V�����A�j�� 
		print("OnEvent_4252 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 4252, "OnEvent_4252_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4252 end");
end


--��4252_1���A�C�e���擾��
function OnEvent_4252_1(proxy, param)
	print("OnEvent_4252_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10101�Q��
	proxy:GetRateItem(10111);
	proxy:GetRateItem(10174);	
	proxy:GetRateItem(10175);
	proxy:GetRateItem(10176);
	proxy:GetRateItem(10177);
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 4252, 1 );
	
	--�󔠃V�F�[�_�[�͏����܂���
	--proxy:TreasureDispModeChange( 1981 , false );

	--SFX��������
	--proxy:InvalidSfx( 1221 , true );--�v�΂̃I�[��
	proxy:InvalidSfx( 1220 , true );--���̗��q
		
	--���v�΂Ń��[�v�p�̊Ď���ǉ���
	proxy:OnDistanceActionAttribute( 4254 , 10000 , 1981 , "OnEvent_4254" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

		if proxy:IsClient() == false then
		local attr = ATTR_NOSESSION + ATTR_LIVE + ATTR_GREY;
		proxy:NotNetMessage_begin();
		--proxy:OnDistanceActionAttribute( 570 , 10000 , 1270 , "OnEvent_570" , DoorDist_A,HELPID_OPEN,180,DoorAngle_A,attr,everytime);
		proxy:OnRegionJustIn( 570 , 10000 , 2250 , "OnEvent_570" , everytime );
			
		proxy:LuaCall( 571 , REMO_START ,"OnEvent_571_RemoStart",once);
		proxy:LuaCall( 571 , REMO_FINISH,"OnEvent_571_RemoFinish",once);
		proxy:NotNetMessage_end();
	end
	
	print("OnEvent_4252_1 end");
end

--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m02_01_00_00(proxy, param)
	print("PlayerDeath_m02_01_00_00");	
	print("PlayerDeath_m02_01_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m02_01_00_00(proxy,param)
	print("PlayerRevive_m02_01_00_00");
	print("PlayerRevive_m02_01_00_00");
end



--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ��遡582
--------------------------------------------------------------------------------------

--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫

--��582�����{�X�����ւ̔����J����
function OnEvent_582(proxy,param)
	print("OnEvent_582 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_582 end");
		return;
	end
	
	--�N���C�A���g�ցA�{�X�����j�~���s��ʒm
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 583 , 1 );--����A�j���̓����Đ�
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--���d�N���V�X�e��ID���^�C���A�E�g��ݒ肵��ON�ɂ���
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_582 end");
end


--����A�j���̓����Đ�(ID����)
function OnEvent_583_1(proxy,param)
	print("OnEvent_583_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ����s���A���̏I������OnEvent_583_2�𔭍s����
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2890 );
		else
			proxy:LockSession();--���[�������b�N���܂��I
			--����A�j���Đ����s���A���̏I������OnEvent_583_2�𔭍s����
			proxy:OnTurnCharactorEnd( 583, 10000, 2890, "OnEvent_583_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_583_1 end");
end

--����A�j���̓����Đ��I����
function OnEvent_583_2(proxy,param)
	print("OnEvent_583_2 begin");
	
	--�����p�����A�j���Đ�
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 583, 10000, ANIMEID_WALK, "OnEvent_583_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_583_2 end");
end

--�����A�j���̓����Đ��I����
function OnEvent_583_3(proxy,param)
	print("OnEvent_583_3 begin");
	
	--�ŏ��̐l���{�X�����̒��ɓ���I����Ă�����A���ɔz�M����Ă���͂��Ȃ̂ŁA����������Ȃ��n���h��
	if proxy:IsCompleteEvent( 582 ) == false then		
		Lua_MultiDoping(proxy,801);--�}���`�v���C�h�[�s���O		
		Lua_MultiDoping(proxy,120);--�}���`�v���C�h�[�s���O
		Lua_MultiDoping(proxy,121);--�}���`�v���C�h�[�s���O
		Lua_MultiDoping(proxy,122);--�}���`�v���C�h�[�s���O
		Lua_MultiDoping(proxy,123);--�}���`�v���C�h�[�s���O
		Lua_MultiDoping(proxy,124);--�}���`�v���C�h�[�s���O
		Lua_MultiDoping(proxy,125);--�}���`�v���C�h�[�s���O
		Lua_MultiDoping(proxy,126);--�}���`�v���C�h�[�s���O
		Lua_MultiDoping(proxy,127);--�}���`�v���C�h�[�s���O
		proxy:LuaCallStart( 583 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCallStart( 4045 , 1 );	--�N���C�A���g�ցA�{�X�����ɓ����悤�ɂȂ������Ƃ�ʒm
		proxy:LuaCallStart( 583 , 6 );--�t���O�Z�b�g(�����p)

	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�)
	if proxy:IsClient() == false then
		proxy:ResetThink( 801 );
	end
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );

	print("OnEvent_583_3 end");
end


--��582 2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
function OnEvent_582_GO_TO_IN(proxy, param)
	print("OnEvent_582_GO_TO_IN begin");	
		
	proxy:NotNetMessage_begin();
		--��583�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���--�n���h���� OnEvent_582
		proxy:OnPlayerActionInRegion( 583, 2894, "OnEvent_582", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();
	--���̏��퓬����	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 583 , "StandBy_KingOfShield",0.5,0,0,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_582_GO_TO_IN end");
end


--��582 �t���O�Z�b�g(�����p)
function OnEvent_582_flag_set(proxy, param)
	print("OnEvent_582_flag_set begin");

	proxy:SetEventFlag( 582 , 1 );
	proxy:DeleteEvent( 582 );

	print("OnEvent_582_flag_set end");
end



--------------------------------------------------------------------------------------
--���{�X�|�����Đ���584
--------------------------------------------------------------------------------------

function OnEvent_584(proxy, param)
	print("OnEvent_584 begin");

	--�|�����Đ��J�n
	proxy:RequestRemo(20100,REMO_FLAG,584,1);
	proxy:SetEventFlag( 584 , 1 );--�|�����Đ��I��
	
	print("OnEvent_584 end");
end


--��584_RemoStart���|�����J�n �t�F�[�h�A�E�g������
function OnEvent_584_RemoStart(proxy,param)
	print( "OnEvent_584_RemoStart begin" );
	
	print("�|�����Đ��J�n");
	proxy:SetDrawEnable( 801 , false );--���̏� �\��OFF
	
	print( "OnEvent_584_RemoStart end" );
end


--��584_RemoFinish���|�����Đ��I���ち
function OnEvent_584_RemoFinish(proxy , param)
	print( "OnEvent_584_RemoFinish begin" );

	print("�|�����I��");
	proxy:SetDrawEnable( 801 , true );--���̏� �\��ON	

	print( "OnEvent_584_RemoFinish end" );
end


--------------------------------------------------------------------------------------
--�{�X�������o��(�퓬�J�n)��585
--------------------------------------------------------------------------------------

function OnEvent_585(proxy, param)
	print("OnEvent_585 begin");	
	
	--�{�X��pBGM�Đ��J�n
	proxy:PlayPointSE( 2310, SOUND_TYPE_M, 20100000, 1 );
	
	--�{�X���W�b�NON
	proxy:EnableLogic( 801 , true );

	--�t���OON
	proxy:SetEventFlag( 585 ,true );
	
	--�{�X�Q�[�W�\��
	proxy:SetBossGauge( 801 , 0 ,5010 );
	
	print("OnEvent_585 end");
end



--------------------------------------------------------------------------------------
--��680���T�u�C�x���g����
--------------------------------------------------------------------------------------

--��680_1���T�u�C�x���g����LuaCall��`
function OnEvent_680_1(proxy, param)
	print("OnEvent_680_1 begin");

	proxy:PlayAnimation( 1202, 1 );--�����J���A�j���[�V����
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 680, 1 );
		proxy:DeleteEvent( 680 );
		print("OnEvent_680_1 end");
		return;
	end

	proxy:WarpDmy( 10000 , 1202 , 191 );
	proxy:SetEventFlag( 680, 1 );

	print("OnEvent_680_1 end");
end


--��680���T�u�C�x���g����
function OnEvent_680(proxy, param)

	--���d�����h�~
	if proxy:IsCompleteEvent( 680 ) == true then
		return;
	end
	
	print("OnEvent_680 begin");
	
	--�K�v�A�C�e���̎w��
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 8;--�S���̌�
	
	--�K�v�A�C�e�����������Ă���(�C���x���g���[�ɃA�C�e���Ƃ��ď������Ă���)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--��680_3���I�����j���[�̊Ď���
			--proxy:OnSelectMenu(680, "OnEvent_680_3", 10010802, 0, 2, 1202, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010802, 0, 6, 1202, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_680_3(proxy,param);

	--�K�v�A�C�e�����������Ă��Ȃ�
	else
		--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\��
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1202, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_680 end");
end


--��680_3���I�����j���[�̊Ď���(YES��I�������Ƃ�)
function OnEvent_680_3(proxy,param)
	print("OnEvent_680_3 begin");
	proxy:LuaCallStart( 680 , 1 );--�A�j���[�V�����̓����Đ�(�S�̂ɔz�M)
	proxy:DeleteEvent( 680 );
	print("OnEvent_680_3 end");
end



--------------------------------------------------------------------------------------
--��682���T�u�C�x���g����
--------------------------------------------------------------------------------------

--��682_1���T�u�C�x���g����LuaCall��`
function OnEvent_682_1(proxy, param)
	print("OnEvent_682_1 begin");	
	
	proxy:PlayAnimation( 1205, 1 );--�����J���A�j���[�V����
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 682, 1 );
		proxy:DeleteEvent( 682 );
		print("OnEvent_682_1 end");
		return;
	end

	proxy:WarpDmy( 10000 , 1205 , 191 );
	proxy:SetEventFlag( 682, 1 );

	print("OnEvent_682_1 end");
end



--��682���T�u�C�x���g����
function OnEvent_682(proxy, param)
	print("OnEvent_682 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 682 ) == true then
		print("OnEvent_682 end");
		return;
	end
	
	--�K�v�A�C�e���̎w��
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 8;--�S���̌�
	
	--�K�v�A�C�e�����������Ă���(�C���x���g���[�ɃA�C�e���Ƃ��ď������Ă���)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--��682_3���I�����j���[�̊Ď���
			--proxy:OnSelectMenu(682, "OnEvent_682_3", 10010802, 0, 2, 1205, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010802, 0, 6, 1205, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_682_3(proxy,param);

	--�K�v�A�C�e�����������Ă��Ȃ�
	else
		--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\��
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1205, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_682 end");
end


--��682_3���I�����j���[�̊Ď���(YES��I�������Ƃ�)
function OnEvent_682_3(proxy,param)
	print("OnEvent_682_3 begin");
	proxy:LuaCallStart( 682 , 1 );--�A�j���[�V�����̓����Đ�(�S�̂ɔz�M)	
	proxy:DeleteEvent( 682 );
	
	print("OnEvent_682_3 end");
end




--------------------------------------------------------------------------------------
--��684���T�u�C�x���g����
--------------------------------------------------------------------------------------

--��684_1���T�u�C�x���g����LuaCall��`
function OnEvent_684_1(proxy, param)
	print("OnEvent_684_1 begin");
	
	--�r�������O�����������Ă���S���̔����J�����̂ť��
	--�r���̏�Ԃ��u������Ă���Ċ��Ӂv�ɂ���
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_THANKS );
	proxy:SetEventFlag( 520 , 1 );--�A�N�V�����t���O�����ĂĂ�������B

	proxy:PlayAnimation( 1206, 1 );--�����J���A�j���[�V����
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 684, 1 );
		proxy:DeleteEvent( 684 );
		print("OnEvent_684_1 end");
		return;
	end

	proxy:WarpDmy( 10000 , 1206 , 191 );
	proxy:SetEventFlag( 684, 1 );

	print("OnEvent_684_1 end");
end



--��684���T�u�C�x���g����
function OnEvent_684(proxy, param)
	print("OnEvent_684 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 684 ) == true then
		print("OnEvent_684 end");
		return;
	end
	
	--�K�v�A�C�e���̎w��
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 8;--�S���̌�
	
	--�K�v�A�C�e�����������Ă���(�C���x���g���[�ɃA�C�e���Ƃ��ď������Ă���)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--��684_3���I�����j���[�̊Ď���
			--proxy:OnSelectMenu(684, "OnEvent_684_3", 10010802, 0, 2, 1206, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010802, 0, 6, 1206, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_684_3(proxy,param);

	--�K�v�A�C�e�����������Ă��Ȃ�
	else
		--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\��
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1206, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_684 end");
end


--��684_3���I�����j���[�̊Ď���(YES��I�������Ƃ�)
function OnEvent_684_3(proxy,param)
	print("OnEvent_684_3 begin");
	proxy:LuaCallStart( 684 , 1 );--�A�j���[�V�����̓����Đ�(�S�̂ɔz�M)	
	proxy:DeleteEvent( 684 );
	print("OnEvent_684_3 end");
end






--------------------------------------------------------------------------------------
--��686���T�u�C�x���g����
--------------------------------------------------------------------------------------
--��686_1���T�u�C�x���g����LuaCall��`
function OnEvent_686_1(proxy, param)
	print("OnEvent_686_1 begin");

	proxy:PlayAnimation( 1203, 1 );--�����J���A�j���[�V����
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 686, 1 );
		proxy:DeleteEvent( 686 );
		print("OnEvent_686_1 end");
		return;
	end

	proxy:WarpDmy( 10000 , 1203 , 191 );
	proxy:SetEventFlag( 686, 1 );

	print("OnEvent_686_1 end");
end

--��686���T�u�C�x���g����
function OnEvent_686(proxy, param)
	print("OnEvent_686 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 686 ) == true then
		print("OnEvent_686 end");
		return;
	end
	
	--�K�v�A�C�e���̎w��
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 8;--�S���̌�
	
	--�K�v�A�C�e�����������Ă���(�C���x���g���[�ɃA�C�e���Ƃ��ď������Ă���)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--��686_3���I�����j���[�̊Ď���
			--proxy:OnSelectMenu(686, "OnEvent_686_3", 10010802, 0, 2, 1206, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010802, 0, 6, 1203, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_686_3(proxy,param);

	--�K�v�A�C�e�����������Ă��Ȃ�
	else
		--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\��
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1203, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_686 end");
end


--��686_3���I�����j���[�̊Ď���(YES��I�������Ƃ�)
function OnEvent_686_3(proxy,param)
	print("OnEvent_686_3 begin");
	proxy:LuaCallStart( 686 , 1 );--�A�j���[�V�����̓����Đ�(�S�̂ɔz�M)	
	proxy:DeleteEvent( 686 );
	print("OnEvent_686_3 end");
end

--------------------------------------------------------------------------------------
--��688���T�u�C�x���g����
--------------------------------------------------------------------------------------
--��688_1���T�u�C�x���g����LuaCall��`
function OnEvent_688_1(proxy, param)
	print("OnEvent_688_1 begin");

	proxy:PlayAnimation( 1204, 1 );--�����J���A�j���[�V����
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 688, 1 );
		proxy:DeleteEvent( 688 );
		print("OnEvent_688_1 end");
		return;
	end

	proxy:WarpDmy( 10000 , 1204 , 191 );
	proxy:SetEventFlag( 688, 1 );

	print("OnEvent_688_1 end");
end

--��688���T�u�C�x���g����
function OnEvent_688(proxy, param)
	print("OnEvent_688 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 688 ) == true then
		print("OnEvent_688 end");
		return;
	end
	
	--�K�v�A�C�e���̎w��
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 8;--�S���̌�
	
	--�K�v�A�C�e�����������Ă���(�C���x���g���[�ɃA�C�e���Ƃ��ď������Ă���)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--��688_3���I�����j���[�̊Ď���
			--proxy:OnSelectMenu(688, "OnEvent_688_3", 10010802, 0, 2, 1206, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010802, 0, 6, 1204, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_688_3(proxy,param);

	--�K�v�A�C�e�����������Ă��Ȃ�
	else
		--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\��
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1204, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_688 end");
end


--��688_3���I�����j���[�̊Ď���(YES��I�������Ƃ�)
function OnEvent_688_3(proxy,param)
	print("OnEvent_688_3 begin");
	proxy:LuaCallStart( 688 , 1 );--�A�j���[�V�����̓����Đ�(�S�̂ɔz�M)	
	proxy:DeleteEvent( 688 );
	print("OnEvent_688_3 end");
end



--------------------------------------------------------------------------------------
--��560�������̎��S�Ď���
--------------------------------------------------------------------------------------
function OnEvent_560(proxy,param)
	print("OnEvent_560 beign");
	
	proxy:SetEventFlag(560,true);--�������S�t���OON(�C�x���g)
	
	--�r�������C�x���g�̔���������ɥ���B
	
	--���݂̏�Ԃ��擾
	local now_state = GetNpcStateFlag( proxy, param, biyo_flag_list );
		--�r���̏�Ԃ��u�t�P�ɖ������ĐQ��v�ɂ���
	if	proxy:IsCompleteEvent(BIYO_STATE_TARGET_ENEMY) == true then
	
		--proxy:SetEventCommand( 622 , 60 );--EzState�ɐ���ԍ�(�Q��)��n��
		
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_END_OF_STRIKES_BACK );
		
		--�A�N�V�����t���O�����ĂĂ������
		proxy:SetEventFlag( 523 , 1 );
	end
	
	
	print("OnEvent_560 end");
end


--------------------------------------------------------------------------------------
--��560�������̎��̂𒲂ׂ���
--------------------------------------------------------------------------------------
function OnEvent_15622(proxy,param)
	print("OnEvent_15622 begin");
	proxy:SetEventFlag( 15622 , true );
	print("OnEvent_15622 end");
end

--------------------------------------------------------------------------------------
--��527���r�������O�����̎��S�Ď���
--------------------------------------------------------------------------------------
function OnEvent_527(proxy,param)
	print("OnEvent_527 beign");
	
	proxy:SetEventFlag(527,true);
		
	--�r���̏�Ԃ��u���S�v�ɂ���
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_DEAD );

	print("OnEvent_527 end");
end


--------------------------------------------------------------------------------------
--��643�������h�����q�Ăт����͈͎擾��
--------------------------------------------------------------------------------------
function OnEvent_643(proxy,param)
	print("OnEvent_643 beign");
	
	proxy:SetEventFlag( 643 , true );--�t���O���Ă�̂�(��b���Ŏg��?)

	print("OnEvent_643 end");
end

--�Ăт����͈͂���o��
function OnEvent_643_out(proxy,param)
	print("OnEvent_643_out begin");
	proxy:SetEventFlag( 643 , false );
	print("OnEvent_643_out end");
end
--[[
--------------------------------------------------------------------------------------
--��652�������h���ǂ��������mA�̎��S�Ď���
--------------------------------------------------------------------------------------
function OnEvent_652(proxy,param)
	print("OnEvent_652 beign");
	proxy:SetEventFlag(652,true);
	print("OnEvent_652 end");
end


--------------------------------------------------------------------------------------
--��654�������h���ǂ��������mB�̎��S�Ď���
--------------------------------------------------------------------------------------
function OnEvent_654(proxy,param)
	print("OnEvent_654 beign");
	proxy:SetEventFlag(654,true);
	print("OnEvent_654 end");
end

]]


--[[------------------------------------------------------------------------------------
--��660����H�V���b�vNPC�̎��S�Ď���
--------------------------------------------------------------------------------------
function OnEvent_660(proxy,param)
	print("OnEvent_660 beign");
	proxy:SetEventFlag(660,true);
	print("OnEvent_660 end");
end
]]


--------------------------------------------------------------------------------------
--��670���z�X�gPC�݂̂��ʂ����̖���
--------------------------------------------------------------------------------------

--��670_delete_wall�����@�Ǎ폜�����p��
function OnEvent_670_delete_wall(proxy , param)
	print("OnEvent_670_delete_wall begin");
	
	proxy:SetDrawEnable( 1260 , false );--�`��OFF
	proxy:SetColiEnable( 1260 , false );--������OFF
	proxy:SetObjDeactivate( 1260 , true );--�f�A�N�e�B�u
	proxy:DeleteEvent( 670 );
	proxy:InvalidSfx( 2230 , true );
	
	print("OnEvent_670_delete_wall end");
end


--��670���C�x���g�����p��
function OnEvent_670(proxy , param)
	print("OnEvent_670 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 670 ) == true then
		print("OnEvent_670 end");
		return;
	end
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 670 , 1 );
		print("OnEvent_670 end");
		return;
	end
	
	--�_�~�|���փ��[�v
	proxy:WarpDmy( 10000 , 1260 , 191 );
	
	proxy:NotNetMessage_begin();
		--��670_1�������A�j���I����
		--proxy:OnChrAnimEnd( 670 , 10000 , ANIMEID_WALK , "OnEvent_670_1" , once );
		proxy:LuaCallStart( 670 , 1 );--���̖��폜����
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 670 , 1 );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_670 end");
end


--��670_1�������A�j���I����
function OnEvent_670_1(proxy , param)
	print("OnEvent_670_1 begin");
	
	proxy:LuaCallStart( 670 , 1 );--���̖��폜����
	
	print("OnEvent_670_1 end");
end

--[[
--------------------------------------------------------------------------------------
--512���o���X�^�J�n�C�x���g
--------------------------------------------------------------------------------------
--�o���X�^�C�x���g�J�n
function OnEvent_512(proxy,param)

	if proxy:IsCompleteEvent(512) == true then
		return;
	end	
	if Luafunc_PlaySynchroAnimation(proxy,param,ANIMEID_BARISTA_GRASP) == true then
		proxy:SetEventFlag(512,true);
		return;
	end
	
	print("OnEvent_512 begin");		
	proxy:EnableLogic(10000,false);
	--�v���C���[��OBJ(1200)�̃_�~�|��(191)�ʒu�փ��[�v
	proxy:WarpDmy( 10000, 1200, 191 );--�o���X�^����I�u�W�F
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd(512,10000,ANIMEID_BARISTA_GRASP,"OnEvent_512_1",once);
	proxy:NotNetMessage_end();
	proxy:SetEventFlag(512,true);	
	print("OnEvent_512 end");
end

--�v���C���[�A�j���I����
function OnEvent_512_1(proxy,param)
	print("OnEvent_512_1 begin");
	proxy:LuaCallStart(512,2);
	print("OnEvent_512_1 end");
end

--���[�v�A�j���J�n
function OnEvent_512_2(proxy,param)
	print("OnEvent_512_2 begin");
	--�p�[�e�B�[�̃v���C���[���A�j���[�V����
	if param:IsNetMessage() == true then 
		--�o���X�^�ɃI�[�i�[�o�^
		proxy:SetBallista(1207,param:GetPlayID()+10001);
		proxy:PlayLoopAnimation( param:GetPlayID()+10001 , ANIMEID_BARISTA_GRASP_KEEP );
		print("OnEvent_512_2 end");
		return;
	end
	--�o���X�^�ɃI�[�i�[�o�^
	proxy:SetBallista(1207,10000);
	--�������A�j���[�V����
	proxy:PlayLoopAnimation( 10000 ,  ANIMEID_BARISTA_GRASP_KEEP );
	proxy:OnBallista(513,1207,HELPID_REMOVE,-20,20,-200,30,3, 1.0, 1.0);--�o���X�^�{�̃I�u�W�F
--	proxy:OnBallista(513,1207,HELPID_REMOVE,-20,20,-200,30,3);--�o���X�^�{�̃I�u�W�F
	print("OnEvent_512_2 end");
end

--------------------------------------------------------------------------------------
--513���o���X�^������
--------------------------------------------------------------------------------------
--0	�cSE�A�j������
function OnEvent_513_0(proxy,param)	
	--���˃A�j��������Ȃ����
	if proxy:IsEventAnim(1207,1) == false then 
		proxy:PlayAnimation(1207,2);		
	end
	if param:IsNetMessage() == true then
		if proxy:IsEventAnim(10000,1) == false then 
			proxy:PlayLoopAnimation( param:GetPlayID()+10001 , ANIMEID_BARISTA_GRASP_KEEP );		
			return;
		end
	end
end

--1	�c�p�x����
function OnEvent_513_1(proxy,param)
	--�����҂͂��Ԃ�ŉ�]�����Ă�̂ŁA��M�҂̂ݓ���
	if param:IsNetMessage() == true then
		proxy:ObjRot(1207,param:GetPlayID()+10001,param:GetParam3());
	end
end

--2	�c�o���X�^���˓���
function OnEvent_513_2(proxy,param)
	print("OnEvent_513_2 begin");
	print("�o���X�^���˃A�j���Đ�");
	--�����A�j��
	proxy:ForcePlayAnimation(1207,1);
	print("OnEvent_513_2 end");
end

--3	�c�o���X�^�I������
function OnEvent_513_3(proxy,param)
	print("OnEvent_513_3 begin");
	print("�o���X�^�I��");	
	if param:IsNetMessage() == true then
		proxy:StopLoopAnimation(param:GetPlayID()+10001);
		proxy:PlayAnimation( param:GetPlayID()+10001 , ANIMEID_BARISTA_AWAY );
		print("OnEvent_513_3 end");		
		return;		
	end
	--�v���C���[���E�A�j���H
	proxy:StopLoopAnimation(10000);
	proxy:PlayAnimation(10000,ANIMEID_BARISTA_AWAY);
	proxy:EnableLogic(10000,true);
	
	proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd(513,10000,ANIMEID_BARISTA_AWAY,"OnEvent_513_3_1",once);
		proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_513_3 end");
end

--�A�j���I����̃C�x���g
function OnEvent_513_3_1(proxy,param)
	print("OnEvent_513_3_1 begin");
	print("�����҂݂̂̃C�x���g");
	--�t���O�����p�̃C�x���g�𔭍s
	proxy:LuaCallStart(513,5);	
	print("OnEvent_513_3_1 end");	
end

--4	�c�o���X�^�_���[�W�I������
function OnEvent_513_4(proxy,param)
	print("OnEvent_513_4 begin");
	print("�o���X�^�I��");	
	if param:IsNetMessage() == true then
		proxy:StopLoopAnimation(param:GetPlayID()+10001);		
		print("OnEvent_513_4 end");		
		return;		
	end
	proxy:StopLoopAnimation(10000);	
	proxy:EnableLogic(10000,true);
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(513,"OnEvent_513_4_1",2,0,0,once);
	proxy:NotNetMessage_end();
	print("OnEvent_513_4 end");
end

--���ԑ҂��̃C�x���g
function OnEvent_513_4_1(proxy,param)
	print("OnEvent_513_4_1 begin");
	print("�����҂݂̂̃C�x���g");
	--�t���O�����p�̃C�x���g�𔭍s
	proxy:LuaCallStart(513,5);
	print("OnEvent_513_4_1 end");
end

--5	�c�o���X�^�t���O�����p
function OnEvent_513_5(proxy,param)
	print("OnEvent_513_5 begin");
	--�o���X�^�I�[�i�[����
	proxy:SetBallista(1207,-1);
	proxy:SetEventFlag(512,false);
	print("OnEvent_513_5 end");	
end


]]



--------------------------------------------------------------------------------------
--��800���򗳂��ő��Q�����C�ɔ�щ�遡
--------------------------------------------------------------------------------------

--��(�ő�2)���Đ�����A�j��ID
kenzoku_2_play_anime_id = 7006;--�f�t�H���g�ł́A�ҋ@1

--��800���򗳂��ő��Q�����C�ɔ�щ�遡
function OnEvent_800(proxy, param)
	print("OnEvent_800 begin");

	--[[�򗳂�HP�Ď��Ɉ����������Ă�����A���S������]]
	if proxy:IsCompleteEvent( 806 ) == true then
		if	kenzoku_2_play_anime_id ~= 7030 then
			--��806����(�ő�2)�����ʁ�		
			kenzoku_2_play_anime_id = 7030;
			--��OnEvent_806_syncro_anime
			proxy:LuaCallStart( 806 , 1 );--���S�A�j���̓����Đ�
			
			--�򗳊֘A�̃C�x���g�Ď��폜
			--proxy:DeleteEvent( 800 );--�ҋ@
			return;
		else
			--��OnEvent_800_3_syncro_anime
			proxy:LuaCallStart( 800 , 3 );--���S�A�j���̓����Đ�
			return;
		end
	end
	
	--[[���݂̏�Ԏ擾]]
	local now_state = GetNpcStateFlag( proxy, param, kenzoku_2_flag_list );
	
	--[[��Ԃ��A�u�x���v]]
	if now_state == KENZOKU_2_STATE_WARNING then
			
		--[[�ҋ@(�ʘH)]]
		if proxy:IsCompleteEvent( 830 ) == false and  --2320
		   proxy:IsCompleteEvent( 831 ) == false and  --2321
		   proxy:IsCompleteEvent( 832 ) == false then --2322
		   
			local rand = proxy:GetRandom( 1 , 3 );--1�`2
			
			if rand == 1 then
				print("�ҋ@1");
				kenzoku_2_play_anime_id = 7006;--�ҋ@1�̃A�j��ID(���̃A�j������p�ɕێ�)
				--��OnEvent_800_syncro_anime
				proxy:LuaCallStart( 800 , 1 );--�ҋ@1�A�j���̓����Đ�
			elseif rand == 2 then
				print("�ҋ@2");
				kenzoku_2_play_anime_id = 7010;--�ҋ@2�̃A�j��ID(���̃A�j������p�ɕێ�)
				--��OnEvent_800_2_syncro_anime
				proxy:LuaCallStart( 800 , 2 );--�ҋ@2�A�j���̓����Đ�
			end
		
		--[[�̈�A�u���X]]
		elseif
		   proxy:IsCompleteEvent( 830 ) == true and   --2320
		   proxy:IsCompleteEvent( 831 ) == false and  --2321
		   proxy:IsCompleteEvent( 832 ) == false then --2322
			
			print("�̈�A�u���X");
			kenzoku_2_play_anime_id = 7007;--[[�u���XA�̃A�j��ID]]
			--��OnEvent_801_syncro_anime
			proxy:LuaCallStart( 801 , 1 );--�u���XA�A�j���̓����Đ�
		
		--[[�̈�B�u���X]]
		elseif
		   proxy:IsCompleteEvent( 831 ) == true and   --2321
		   proxy:IsCompleteEvent( 832 ) == false then --2322
			
			print("�̈�B�u���X");
		    kenzoku_2_play_anime_id = 7008;--[[�u���XB�̃A�j��ID]]
			--��OnEvent_802_syncro_anime
			proxy:LuaCallStart( 802 , 1 );--�u���XB�A�j���̓����Đ�

		--[[�̈�C�u���X]]
		elseif
		   proxy:IsCompleteEvent( 832 ) == true then --2322
		
			print("�̈�C�u���X");
			kenzoku_2_play_anime_id = 7009;--[[�u���XC�̃A�j��ID]]
			--��OnEvent_803_syncro_anime
			proxy:LuaCallStart( 803 , 1 );--�u���XC�A�j���̓����Đ�
		end
		
	--[[��Ԃ��A�u�w���w���v]]
	elseif now_state == KENZOKU_2_STATE_HEROHERO then
		
		print("�ւ�ւ�")
		kenzoku_2_play_anime_id = 7020;
			--��OnEvent_804_syncro_anime
		proxy:LuaCallStart( 804 , 1 );
	end	
	
	print("OnEvent_800 end");
end



--��800_anime_end����ԂɑΉ�����A�j�����Đ��I����
function OnEvent_800_anime_end(proxy, param)
	print("OnEvent_800_anime_end begin");
	
	--���̂܂܃��[�v����A�j��
	
	if kenzoku_2_play_anime_id == 7006 or   --�ҋ@1
	   kenzoku_2_play_anime_id == 7010 or   --�ҋ@2
	   kenzoku_2_play_anime_id == 7007 or   --�u���XA
	   kenzoku_2_play_anime_id == 7008 or   --�u���XB
	   kenzoku_2_play_anime_id == 7009 or   --�u���XC
	   kenzoku_2_play_anime_id == 7020 or	--�w���w��
	   kenzoku_2_play_anime_id == 7030 then --���S
	   
		proxy:NotNetMessage_begin();
			--���򗳂��ő��Q�����C�ɔ�щ�遥
			proxy:OnKeyTime2( 800 , "OnEvent_800" , 0.0 , 0 , 1 , once );
		proxy:NotNetMessage_end();
	
	--�I����Ȃɂ����Ȃ��A�j��
	
	--elseif kenzoku_2_play_anime_id == 7030 then --���S

	end
	
	print("OnEvent_800_anime_end end");
end





--------------------------------------------------------------------------------------
--��800�`804,806���򗳂̓����A�j���Đ���
--------------------------------------------------------------------------------------

--���ҋ@1
--LuaCallParam(800,1)
function OnEvent_800_syncro_anime(proxy, param)
	print("OnEvent_800_syncro_anime begin");
	
	proxy:Warp( 110 , 2330 );--�ʒu�����킹�邽�߂̗̈�Ƀ��[�v
	proxy:ForcePlayAnimationStayCancel( 110 , 7006 );--�ҋ@�A�j���Đ�
	
	--������(���z�X�g)�̂݃A�j���I�����Ď�
	if	param:IsNetMessage() == false then
	
		proxy:NotNetMessage_begin();
			--��800����ԂɑΉ�����A�j�����Đ��I����
			proxy:OnChrAnimEnd( 800 , 110 , 7006 , "OnEvent_800_anime_end" , once );
		proxy:NotNetMessage_end();	
	end
		
	print("OnEvent_800_syncro_anime end");
end


--���ҋ@2
--LuaCallParam(800,2)
function OnEvent_800_2_syncro_anime(proxy, param)
	print("OnEvent_800_2_syncro_anime begin");
	
	proxy:Warp( 110 , 2330 );--�ʒu�����킹�邽�߂̗̈�Ƀ��[�v
	proxy:ForcePlayAnimationStayCancel( 110 , 7010 );--�ҋ@�A�j���Đ�
	
	--������(���z�X�g)�̂݃A�j���I�����Ď�
	if	param:IsNetMessage() == false then
	
		proxy:NotNetMessage_begin();
			--��800����ԂɑΉ�����A�j�����Đ��I����
			proxy:OnChrAnimEnd( 800 , 110 , 7010 , "OnEvent_800_anime_end" , once );
		proxy:NotNetMessage_end();	
	end
		
	print("OnEvent_800_2_syncro_anime end");
end

--�����S�ҋ@
function OnEvent_800_3_syncro_anime(proxy,param)
	print("OnEvent_800_3_syncro_anime begin");
	
	proxy:DeleteEvent( 801 );--�u���XA
	proxy:DeleteEvent( 802 );--�u���XB
	proxy:DeleteEvent( 803 );--�u���XC
	proxy:DeleteEvent( 804 );--�w���w��
	proxy:DeleteEvent( 805 );--�w���w���ڍs
	
	proxy:SetDeadMode( 110 , false );--���S�L��
	proxy:SetHp( 110, 0.0 );
	--�z�X�g�̂݃A�C�e������
	if	proxy:IsClient() == false then
		proxy:GetRateItem(10118);--�A�C�e������
	end
	
	print("��(�ő�2)���S");		
	--��(�ő�2)�̏�ԃt���O���u���S�v�ɂ���
	
	SetNpcStateFlag(proxy, param, kenzoku_2_flag_list, KENZOKU_2_STATE_DEAD );
	SetNpcStateFlag( proxy, param, kenzoku_flag_list, KENZOKU_STATE_DEAD );
	
	--��������x�点��
	InvalidCharactor( proxy, 110 );
	
	print("OnEvent_800_3_syncro_anime end");
end



--���u���XA
--LuaCallParam(801,1)
function OnEvent_801_syncro_anime(proxy, param)
	print("OnEvent_801_syncro_anime begin");
	
	proxy:Warp( 110 , 2330 );--�ʒu�����킹�邽�߂̗̈�Ƀ��[�v
	proxy:ForcePlayAnimationStayCancel( 110 , 7007 );--�u���XA�A�j���Đ�
	
	--������(���z�X�g)�̂݃A�j���I�����Ď�
	if	param:IsNetMessage() == false then
	
		proxy:NotNetMessage_begin();
			--��800����ԂɑΉ�����A�j�����Đ��I����
			proxy:OnChrAnimEnd( 800 , 110 , 7007 , "OnEvent_800_anime_end" , once );
		proxy:NotNetMessage_end();	
	end
		
	print("OnEvent_801_syncro_anime end");
end



--���u���XB
--LuaCallParam(802,1)
function OnEvent_802_syncro_anime(proxy, param)
	print("OnEvent_802_syncro_anime begin");
	
	proxy:Warp( 110 , 2330 );--�ʒu�����킹�邽�߂̗̈�Ƀ��[�v
	proxy:ForcePlayAnimationStayCancel( 110 , 7008 );--�u���XB�A�j���Đ�
	
	--������(���z�X�g)�̂݃A�j���I�����Ď�
	if	param:IsNetMessage() == false then
	
		proxy:NotNetMessage_begin();
			--��800����ԂɑΉ�����A�j�����Đ��I����
			proxy:OnChrAnimEnd( 800 , 110 , 7008 , "OnEvent_800_anime_end" , once );
		proxy:NotNetMessage_end();	
	end
		
	print("OnEvent_800_syncro_anime end");
end




--���u���XC
--LuaCallParam(803,1)
function OnEvent_803_syncro_anime(proxy, param)
	print("OnEvent_803_syncro_anime begin");
	
	proxy:Warp( 110 , 2330 );--�ʒu�����킹�邽�߂̗̈�Ƀ��[�v
	proxy:ForcePlayAnimationStayCancel( 110 , 7009 );--�u���XC�A�j���Đ�
	
	--������(���z�X�g)�̂݃A�j���I�����Ď�
	if	param:IsNetMessage() == false then
	
		proxy:NotNetMessage_begin();
			--��800����ԂɑΉ�����A�j�����Đ��I����
			proxy:OnChrAnimEnd( 800 , 110 , 7009 , "OnEvent_800_anime_end" , once );
		proxy:NotNetMessage_end();	
	end
		
	print("OnEvent_803_syncro_anime end");
end



--���w���w��
--LuaCallParam(804,1)
function OnEvent_804_syncro_anime(proxy, param)
	print("OnEvent_804_syncro_anime begin");
	
	proxy:Warp( 110 , 2330 );--�ʒu�����킹�邽�߂̗̈�Ƀ��[�v
	proxy:ForcePlayAnimationStayCancel( 110 , 7020 );--�w���w���A�j���Đ�
	
	--������(���z�X�g)�̂݃A�j���I�����Ď�
	if	param:IsNetMessage() == false then
	
		proxy:NotNetMessage_begin();
			--��800����ԂɑΉ�����A�j�����Đ��I����
			proxy:OnChrAnimEnd( 800 , 110 , 7020 , "OnEvent_800_anime_end" , once );
		proxy:NotNetMessage_end();	
	end
		
	print("OnEvent_804_syncro_anime end");
end



--�����S
--LuaCallParam(806,1)
function OnEvent_806_syncro_anime(proxy, param)
	print("OnEvent_806_syncro_anime begin");
	
	
	proxy:Warp( 110 , 2330 );--�ʒu�����킹�邽�߂̗̈�Ƀ��[�v
	proxy:ForcePlayAnimation( 110 , 7030 );--���S�A�j���Đ�
	
	
	--��(�ő�2)�̏�ԃt���O���u���S�v�ɂ���
	SetNpcStateFlag(proxy, param, kenzoku_2_flag_list, KENZOKU_2_STATE_DEAD );
	SetNpcStateFlag( proxy, param, kenzoku_flag_list, KENZOKU_STATE_DEAD );
	
	--������(���z�X�g)�̂݃A�j���I�����Ď�
	if	param:IsNetMessage() == false then
	
		proxy:NotNetMessage_begin();
			--��800����ԂɑΉ�����A�j�����Đ��I����
			proxy:OnChrAnimEnd( 800 , 110 , 7030 , "OnEvent_800_anime_end" , once );
		proxy:NotNetMessage_end();	
	end
	
	print("OnEvent_806_syncro_anime end");
end


--[[
--------------------------------------------------------------------------------------
--��805���򗳂��ő��Q���w���w���ɂȂ遡
--------------------------------------------------------------------------------------

--��805���򗳂��ő��Q���w���w���ɂȂ遡
function OnEvent_805(proxy, param)
	print("OnEvent_805 begin");

	--��(�ő�2)�̏�Ԃ��w���w���ɂ���
	SetNpcStateFlag(proxy, param, kenzoku_2_flag_list , KENZOKU_2_STATE_HEROHERO);
	
	--���s�[�g�Ȃ̂ŁA�t���O���ĂȂ�
	
	print("OnEvent_805 end");
end
]]

--------------------------------------------------------------------------------------
--��806���򗳂��ő��Q�����ʁ�
--------------------------------------------------------------------------------------

--��806���򗳂��ő��Q�����ʁ�
function OnEvent_806(proxy, param)
	print("OnEvent_806 begin");

	proxy:SetEventFlag( 806 , 1 );--HP�Ď��t���OON
	
	print("OnEvent_806 end");
end



--------------------------------------------------------------------------------------
--��521���r����������|���ɍs����(��b�V�X�e������Ăяo��)
--------------------------------------------------------------------------------------

--��521���r����������|���ɍs����(��b�V�X�e������Ăяo��)
function OnEvent_521(proxy, param)
	print("OnEvent_521 begin");
	
	--����������ł����珈������
	if proxy:IsCompleteEvent( 560 ) == true then
		print("OnEvent_521 end");
		return;
	end
	
	proxy:EnableLogic( 622 , true );--�r�����W�b�NON
	proxy:SetEventCommand( 622 , 51 );--EzState�ɐ���ԍ�(�����オ��)��n��
	proxy:SetTeamType( 622 , TEAM_TYPE_BattleFriend );	
		
	proxy:ForceChangeTarget( 622 , 115 );--�r���̃^�[�Q�b�g�������Ɏw��
	
	--�r���̏�Ԃ��u������|�������v�ɂ���
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_TARGET_ENEMY );
	
	proxy:SetEventFlag( 521 , 1 );
	
	print("OnEvent_521 end");
end




--------------------------------------------------------------------------------------
--��522���r�����S���ŐQ�遡(��b�V�X�e������Ăяo��)
--------------------------------------------------------------------------------------

--��522���r�����S���ŐQ�遡(��b�V�X�e������Ăяo��)
function OnEvent_522(proxy, param)
	print("OnEvent_522 begin");
	
	--�����������Ă����珈������
	if proxy:IsCompleteEvent( 560 ) == false then
		print("OnEvent_522 end");
		return;
	end
	
	proxy:EnableLogic( 622 , false );--�r�����W�b�NOFF
	proxy:SetEventCommand( 622 , 60 );--EzState�ɐ���ԍ�(�Q��)��n��
	proxy:SetTeamType( 622 , TEAM_TYPE_Friend );	
		
	--�r���̏�Ԃ��u�S���ŐQ�Ă���v�ɂ���
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_SLEEPING_IN_PRISON );
	
	proxy:SetEventFlag( 522 , 1 );
	
	print("OnEvent_522 end");
end


--[[
--------------------------------------------------------------------------------------
--��524���r�������̃u���b�N�ֈړ���
--------------------------------------------------------------------------------------

function Check_OnEvent_524(proxy, param)

	--�����v���C���[(�O���C)�̂ݔ���
	if proxy:IsLivePlayer() == false and
	   proxy:IsGreyGhost()  == false then
		return false;
	end
	
	--���݂̏�Ԏ擾
	local now_state = GetNpcStateFlag( proxy, param, biyo_flag_list );
	
	--�u�S���ŐQ�Ă���v�ł��A�u�t�P�ɖ������ĐQ��v�ł��Ȃ��Ƃ��A��������
	if now_state ~= BIYO_STATE_SLEEPING_IN_PRISON and
	   now_state ~= BIYO_STATE_END_OF_STRIKES_BACK then
		return false;
	end
	
	--�����������Ă����珈������
	if proxy:IsCompleteEvent( 560 ) == false then
		return false;
	end
	
	--��������
	if proxy:IsDistance( 10000 , 622 , 20 ) == true then
		return false;
	else
		print("�r�������O�����A���u���b�N�ֈړ�");
		return true;
	end
	
	return false;
end


--��524���r�������̃u���b�N�ֈړ���
function OnEvent_524(proxy, param)
	print("OnEvent_524 begin");
	
	InvalidCharactor( proxy , 622 );--�r��������

	--�r���̏�Ԃ��u����3��T���v�ɂ���
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_SEARCH_3 );

	proxy:SetEventFlag( 524 , 1 );
	
	print("OnEvent_524 end");
end
]]


--------------------------------------------------------------------------------------
--��525���r�����S���œG�ɂȂ遡
--------------------------------------------------------------------------------------

--��525���r�����S���œG�ɂȂ遡
function OnEvent_525(proxy, param)
	print("OnEvent_525 begin");
	
	if	proxy:IsCompleteEvent( BIYO_STATE_CAPTIVE ) == true or
		proxy:IsCompleteEvent( BIYO_STATE_THANKS ) == true or
		proxy:IsCompleteEvent( BIYO_STATE_SLEEPING_IN_PRISON ) == true then
		
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_HOSTILE_IN_PRISON );
		
		proxy:SetEventCommand( 622 , 51 );--EzState�ɐ���ԍ�(�����オ��)��n��
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 525 , "OnEvent_525_1",1.0,1,100 , once );
		proxy:NotNetMessage_end();
		proxy:EnableLogic( 622 , true );--[[�r�����W�b�NON( ���W�b�N�؂�ւ��H )]]	
		proxy:SetEventFlag( 525 , 1 );
		proxy:EraseEventSpecialEffect_2(622,5064);
		proxy:SetTeamType(622, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
	end
	
	print("OnEvent_525 end");
end

function OnEvent_525_1(proxy,param)
	proxy:SetEventCommand( 622 , 51 );--EzState�ɐ���ԍ�(�����オ��)��n��
end

--------------------------------------------------------------------------------------
--��526���r������ǂœG�ɂȂ遡
--------------------------------------------------------------------------------------

--��526���r�����S���œG�ɂȂ遡
function OnEvent_526(proxy, param)
	print("OnEvent_526 begin");
	
	--�u������|�������v�ł��u�t�P�ɖ������ĐQ��v�ł��Ȃ��Ƃ��A��������
	if	proxy:IsCompleteEvent( BIYO_STATE_TARGET_ENEMY ) 		== true or
		proxy:IsCompleteEvent( BIYO_STATE_END_OF_STRIKES_BACK ) == true then
		
		proxy:EnableLogic( 622 , true );--[[�r�����W�b�NON( ���W�b�N�؂�ւ��H )]]
		proxy:SetEventCommand( 622 , 51 );--EzState�ɐ���ԍ�(�����オ��)��n��
		
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 525 , "OnEvent_525_1",1.0,1,100 , once );
		proxy:NotNetMessage_end();
		--�r���̏�Ԃ��u�G��(���)�v�ɂ���
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_HOSTILE_IN_RAMPART );
		
		proxy:EraseEventSpecialEffect_2(622,5064);
		proxy:SetTeamType(622, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
		proxy:SetEventFlag( 526 , true );
	end
	
	print("OnEvent_526 end");
end

--------------------------------------------------------------------------------------
--��530���r�����t�P�ɖ������ĐQ�遡
--------------------------------------------------------------------------------------
--��530���r�����t�P�ɖ������ĐQ�遡
function OnEvent_530(proxy,param)
	print("OnEvent_530 begin");
	proxy:DisableInterupt( 622 , true );
	MoveRegion(proxy, 622, 2240, -1 ,0.0,true);
	proxy:NotNetMessage_begin();
		proxy:OnRegionIn( 530 , 622 , 2240 , "OnEvent_530_1",once); 	
	proxy:NotNetMessage_end();
	print("OnEvent_530 end");
end

function OnEvent_530_1(proxy,param)
	print("OnEvent_530_1 begin");
	proxy:DisableInterupt( 622 , false );
	proxy:EnableLogic( 622, false );--�r�����W�b�NOFF
	proxy:SetEventCommand( 622 , 60 );--EzState�ɐ���ԍ�(�Q��)��n��
	proxy:SetTeamType( 622 , TEAM_TYPE_Friend );
	proxy:SetEventFlag( 530, true );	
	proxy:SetEventFlag( 531, true );
	print("OnEvent_530_1 end");
end

--------------------------------------------------------------------------------------
--��720�����q�����ӂ��遡
--------------------------------------------------------------------------------------
--[[
function Check_OnEvent_720(proxy, param)

	--���݂̏�Ԃ��擾
	local now_state = GetRendolState(proxy, param);

	--��Ԃ��u�B��Ă���̂ŏ����āv�łȂ��ꍇ�͏�������
	if now_state ~= RENDOL_STATE_HELP_HIDING_ME then
		return false;
	end
	
	--�����h�����q�ǂ��������m��S���|�����犴�ӂ�
	if proxy:IsCompleteEvent( 652 ) == true and
	   proxy:IsCompleteEvent( 654 ) == true then
	   print("�����h�����q�ǂ��������m��S�ē|���܂���");
	   return true;
	end
	
	return false;
end
]]

--��720�����q�����ӂ��遡
function OnEvent_720(proxy, param)
	print("OnEvent_720 begin");
	
	proxy:SetEventFlag( param:GetParam1(), true );
	
	--�����Ă���ΏI��
	if	proxy:IsCompleteEvent( 652 ) == false or
		proxy:IsCompleteEvent( 654 ) == false or
		proxy:IsCompleteEvent( 655 ) == false or
		proxy:IsCompleteEvent( 656 ) == false or
		proxy:IsCompleteEvent( 657 ) == false or
		proxy:IsCompleteEvent( 658 ) == false then
		print("OnEvent_720 is No Success");
		print("OnEvent_720 end");
		return;
	end
	
	
	--���q�̏�Ԃ��u����(����2)�v�ɕύX�����݂�
	if proxy:IsCompleteEvent( RENDOL_STATE_HELP_HIDING_ME ) == true then
		SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_THANKS_2 );
		RendolCheck(proxy,param);--����P�X�N���v�g�Q��
	
		--proxy:SetEventCommand( 620 , 41 );--EzState�ɐ���ԍ�(�����I��)��n���B
		proxy:SetSpStayAndDamageAnimId( 620, -1,-1);		
	end
--[[	
		--��10800�����q���T�����J�n����C�x���g�p�Ď���ǉ���
		if proxy:IsCompleteEvent( 10800 ) == false then
			proxy:NotNetMessage_begin();
				proxy:LuaCall( 10800 , 0 , "OnEvent_10800" , once );--��b�V�X�e������Ăԏꍇ�ɂ�param=0
			proxy:NotNetMessage_end();
	end
]]	
	proxy:DeleteEvent( 720 );--�Ď��폜
	proxy:SetEventFlag( 720 , 1 );
	
	print("OnEvent_720 end");
end


--------------------------------------------------------------------------------------
--��10800�����q���T�����J�n���遡(��b�V�X�e������Ăяo��)
--------------------------------------------------------------------------------------

--��10800�����q���T�����J�n���遡
function OnEvent_10800(proxy, param)
	print("OnEvent_10800 begin");
	if	proxy:IsCompleteEvent( 10800 ) == true then
		return;
	end
	
	--�A�C�e���擾�֐�
	proxy:GetRateItem(10192);
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 10800, 1 );
	
	--����2�ŒT���� ��ԑJ�ڂ����݂�

	--�ڂ̑O�ŏ�����̂��������ׁARendolCheck�����Ȃ�
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_SEARCH_2 );	
	--	proxy:EnableLogic( 620 , true );--�����h�����q�A�T����Ԃŕ����o��
	--
	
	--�ړ��^�C�v�������ɕύX
	proxy:SetEventMovePointType( 620, POINT_MOVE_TYPE_RoundTrip );
	
	--�ړ��|�C���g��ύX
	local point_list = {2220, 2221, 2222, 2223};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--�ړ��|�C���g��ݒ�
		proxy:AddCustomRoutePoint(620, point_list[index]);
	end
	
	proxy:ResetThink( 620 );
	
	print("OnEvent_10800 end");
end




--------------------------------------------------------------------------------------
--��722�����q�����̃u���b�N�Ɉړ����遡
--------------------------------------------------------------------------------------
--[[
function Check_OnEvent_722(proxy, param)

	--���݂̏�Ԃ��擾
	local now_state = GetRendolState(proxy, param);

	--��Ԃ��u����2��T���v�łȂ��ꍇ�͏�������
	if now_state ~= RENDOL_STATE_SEARCH_2 then
		return false;
	end
	
	--��������
	if proxy:IsDistance( 10000 , 620 , 20 ) == true then
		return false;
	else
		print("�����h�����q�A���u���b�N�ֈړ�");
		return true;
	end
	
	return false;
end


--��722�����q�����̃u���b�N�Ɉړ����遡
function OnEvent_722(proxy, param)
	print("OnEvent_722 begin");
	
	--����3�Łu�����Ȃ��ꏊ�ɂ�������v�� ��ԑJ�ڂ����݂�
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_LOCATION_INVISIBLE );

	InvalidCharactor( proxy , 620 );--�����h�����q������
	
	proxy:SetEventFlag( 722 , 1 );
	proxy:DeleteEvent( 722 );--�Ď��폜
	
	print("OnEvent_722 end");
end

]]

--------------------------------------------------------------------------------------
--��723�����q���G�΂��遡
--------------------------------------------------------------------------------------

--��723�����q���G�΂��遡
function OnEvent_723(proxy, param)
	print("OnEvent_723 begin");
	
	--����2�œG�΂ɏ�ԑJ�ڂ����݂�
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HOSTILE_2 );
	RendolCheck(proxy,param);
	
	proxy:SetEventFlag( 723 , true );
	
	print("OnEvent_723 end");
end


--------------------------------------------------------------------------------------
--��724�����q�����ʁ�
--------------------------------------------------------------------------------------

--��724�����q�����ʁ�
function OnEvent_724(proxy, param)
	print("OnEvent_724 begin");

	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_DEAD );
	RendolCheck(proxy,param);
	--���S��RendolCheck����ꍇ�A���̏u�Ԃɏ����Ă��܂��̂ŁA
	--���������čēx�L���ɂ��邩���߂�
	if	proxy:IsDistance( LOCAL_PLAYER, 620, 20 ) == true then
		ValidCharactor( proxy, 620 );
	end
		print("�����h�����q�����S���܂����B");

	proxy:SetEventFlag( 724 , 1 );
	
	print("OnEvent_724 end");
end

--------------------------------------------------------------------------------------
--��760���z�ꕺ�m�̓G�Ή���
--------------------------------------------------------------------------------------

--��760���z�ꕺ�m�̓G�Ή���
function OnEvent_760(proxy, param)
	print("OnEvent_760 begin");
	
	--���݂̏�Ԃ��擾
	local now_state = GetNpcStateFlag(proxy, param, DOREISOL_SHOP_Flag_list);

	--��Ԃ��u�̔����v�łȂ������珈������
	if now_state ~= DOREISOL_SHOP_SELL02 then
		return;
	end
	
	--�z�ꕺ�m�̏�Ԃ��u�G��(����2)�v�ɂ���
	SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_HOSTILE02 );
	--�z�ꕺ�m�̃`�[���^�C�v��ύX����
	proxy:SetTeamType( 623, TEAM_TYPE_AngryFriend );
	
	proxy:EnableLogic( 623 , true );--[[���W�b�NON(���W�b�N�؂�ւ�?)]]
	print("�z�ꕺ�m���G�ɂȂ�܂���");--�����s���Ă�����Ȃ�Ȃ�����ǥ���B
	
	proxy:SetEventFlag( 760 , 1 );
	
	print("OnEvent_760 end");
end


--------------------------------------------------------------------------------------
--��761���z�ꕺ�m�̎��S��
--------------------------------------------------------------------------------------

--��761���z�ꕺ�m�̎��S��
function OnEvent_761(proxy, param)
	print("OnEvent_761 begin");

	--�z�ꕺ�m�̏�Ԃ��u���S�v�ɂ���
	SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_DEAD );
	print("�z�ꕺ�m�����ɂ܂���");--�����s���Ă�����Ȃ�Ȃ�����ǥ���B	

	--�G�ɍ���ēG�΂�ʂ�z���Ď��S�����肦��̂ŁA�����ł��폜
	--���񂾂�G�΂ɂ͂Ȃ�Ȃ��̂ō폜
	proxy:DeleteEvent( 760 );

	proxy:SetEventFlag( 761 , 1 );
	
	print("OnEvent_761 end");
end




--------------------------------------------------------------------------------------
--��550���{�X�J�����؂�ւ��C�x���g��
--------------------------------------------------------------------------------------
function OnEvent_550(proxy,param)
	--print("OnEvent_550 begin");
	--�{�X������ł��Ȃ��@���@�{�X�Ƃ̐퓬���J�n���Ă���
	if proxy:IsCompleteEvent( 4224 ) == false and proxy:IsCompleteEvent( 585 ) == true then
		--�{�X��@�񃍃b�N�J����
		proxy:SetCamModeParamTargetId(2021);
		--�{�X��@���b�N�J����
		proxy:SetCamModeParamTargetIdForBossLock(2020);
	end
	--print("OnEvent_550 end");
end


--------------------------------------------------------------------------------------
--�J���X����ї���
--------------------------------------------------------------------------------------
function FryAwayKarasu(proxy,param, KarasuEventID, karasuID, KarasuAnimID)	
	print("FryAwayKarasu_"..karasuID.." begin");

	proxy:PlayAnimation( karasuID, KarasuAnimID );

	proxy:NotNetMessage_begin();
		--���J���X�A�j���Đ��I����
		proxy:OnObjAnimEnd( KarasuEventID , karasuID , KarasuAnimID , "OnEvent_"..KarasuEventID.."_1" , once );	
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( KarasuEventID , 1 );

	print("FryAwayKarasu_"..karasuID.." end");
end

-----------------------------------------
--�J���X�A�j���Đ��I�������̂ŏ����Ă���
-----------------------------------------
function OnEvent_850_1(proxy,param)	proxy:SetDrawEnable( 1230 , false ); print("KarasuFryAway ID=1230"); end
function OnEvent_851_1(proxy,param)	proxy:SetDrawEnable( 1231 , false ); print("KarasuFryAway ID=1231"); end
function OnEvent_852_1(proxy,param)	proxy:SetDrawEnable( 1232 , false ); print("KarasuFryAway ID=1232"); end
function OnEvent_853_1(proxy,param)	proxy:SetDrawEnable( 1233 , false ); print("KarasuFryAway ID=1233"); end
function OnEvent_854_1(proxy,param)	proxy:SetDrawEnable( 1234 , false ); print("KarasuFryAway ID=1234"); end
function OnEvent_855_1(proxy,param)	proxy:SetDrawEnable( 1235 , false ); print("KarasuFryAway ID=1235"); end
function OnEvent_856_1(proxy,param)	proxy:SetDrawEnable( 1236 , false ); print("KarasuFryAway ID=1236"); end
function OnEvent_857_1(proxy,param)	proxy:SetDrawEnable( 1237 , false ); print("KarasuFryAway ID=1237"); end
function OnEvent_858_1(proxy,param)	proxy:SetDrawEnable( 1238 , false ); print("KarasuFryAway ID=1238"); end
function OnEvent_859_1(proxy,param)	proxy:SetDrawEnable( 1239 , false ); print("KarasuFryAway ID=1239"); end
function OnEvent_860_1(proxy,param)	proxy:SetDrawEnable( 1240 , false ); print("KarasuFryAway ID=1240"); end
function OnEvent_861_1(proxy,param)	proxy:SetDrawEnable( 1241 , false ); print("KarasuFryAway ID=1241"); end
function OnEvent_862_1(proxy,param)	proxy:SetDrawEnable( 1242 , false ); print("KarasuFryAway ID=1242"); end
function OnEvent_863_1(proxy,param)	proxy:SetDrawEnable( 1243 , false ); print("KarasuFryAway ID=1243"); end
function OnEvent_864_1(proxy,param)	proxy:SetDrawEnable( 1244 , false ); print("KarasuFryAway ID=1244"); end
function OnEvent_865_1(proxy,param)	proxy:SetDrawEnable( 1245 , false ); print("KarasuFryAway ID=1245"); end
function OnEvent_866_1(proxy,param)	proxy:SetDrawEnable( 1246 , false ); print("KarasuFryAway ID=1246"); end
function OnEvent_867_1(proxy,param)	proxy:SetDrawEnable( 1247 , false ); print("KarasuFryAway ID=1247"); end
function OnEvent_868_1(proxy,param)	proxy:SetDrawEnable( 1248 , false ); print("KarasuFryAway ID=1248"); end
function OnEvent_869_1(proxy,param)	proxy:SetDrawEnable( 1249 , false ); print("KarasuFryAway ID=1249"); end
function OnEvent_870_1(proxy,param)	proxy:SetDrawEnable( 1250 , false ); print("KarasuFryAway ID=1250"); end

---------------------------------
--�J���X����ї��֐����Ăяo��
---------------------------------
function OnEvent_850(proxy, param) FryAwayKarasu(proxy, param, 850, 1230, 12); end
function OnEvent_851(proxy, param) FryAwayKarasu(proxy, param, 851, 1231, 12); end
function OnEvent_852(proxy, param) FryAwayKarasu(proxy, param, 852, 1232, 12); end
function OnEvent_853(proxy, param) FryAwayKarasu(proxy, param, 853, 1233, 12); end
function OnEvent_854(proxy, param) FryAwayKarasu(proxy, param, 854, 1234, 12); end
function OnEvent_855(proxy, param) FryAwayKarasu(proxy, param, 855, 1235, 12); end
function OnEvent_856(proxy, param) FryAwayKarasu(proxy, param, 856, 1236, 12); end
function OnEvent_857(proxy, param) FryAwayKarasu(proxy, param, 857, 1237, 12); end
function OnEvent_858(proxy, param) FryAwayKarasu(proxy, param, 858, 1238, 12); end
function OnEvent_859(proxy, param) FryAwayKarasu(proxy, param, 859, 1239, 12); end
function OnEvent_860(proxy, param) FryAwayKarasu(proxy, param, 860, 1240, 12); end
function OnEvent_861(proxy, param) FryAwayKarasu(proxy, param, 861, 1241, 12); end
function OnEvent_862(proxy, param) FryAwayKarasu(proxy, param, 862, 1242, 12); end
function OnEvent_863(proxy, param) FryAwayKarasu(proxy, param, 863, 1243, 12); end
function OnEvent_864(proxy, param) FryAwayKarasu(proxy, param, 864, 1244, 12); end
function OnEvent_865(proxy, param) FryAwayKarasu(proxy, param, 865, 1245, 11); end
function OnEvent_866(proxy, param) FryAwayKarasu(proxy, param, 866, 1246, 10); end
function OnEvent_867(proxy, param) FryAwayKarasu(proxy, param, 867, 1247, 11); end
function OnEvent_868(proxy, param) FryAwayKarasu(proxy, param, 868, 1248, 10); end
function OnEvent_869(proxy, param) FryAwayKarasu(proxy, param, 869, 1249, 11); end
function OnEvent_870(proxy, param) FryAwayKarasu(proxy, param, 870, 1250, 10); end


--------------------------------------------------------------------------------------
--��610��QWC:�\�E�������X�^�[�o���P��
--------------------------------------------------------------------------------------
function OnEvent_610(proxy,param)
	print("OnEvent_610 begin");
	
	--�\�E�������X�^�[��\��������
	ValidCharactor( proxy, 150 );
	ValidCharactor( proxy, 151 );
	
	--�\�E�������X�^�[�̏o���A�j���̍Đ�
	proxy:PlayAnimation( 150, 6100 );
	proxy:PlayAnimation( 151, 6100 );
	
	--�t���OON
	proxy:SetEventFlag( 610, true )

	print("OnEvent_610 end");
end



--------------------------------------------------------------------------------------
--��570��������J���H��
--------------------------------------------------------------------------------------
function OnEvent_570(proxy,param)
	print("OnEvent_570 begin");
	if proxy:IsCompleteEvent( 8035 ) == false then
		--�\���u���͂ȃ\�E���̗͂ŕ��󂳂ꂢ��v
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010195, 1);
		--proxy:ShowGenDialog(10010195,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:RequestOpenBriefingMsg(10010195,true);
			proxy:OnRegionJustOut( 570 , 10000 , 2251, "OnEvent_570_out",once);
			--proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010195, 0, 6, 1270, 10, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	else
		--���s�̖�J���|����
		proxy:RequestRemo( 20101 ,REMO_FLAG , 571 ,1);
		proxy:SetEventFlag( 571,true );
	end
	print("OnEvent_570 end");
end

--�̈悩��o��
function OnEvent_570_out(proxy,param)
	print("OnEvent_570_out begin");
	proxy:CroseBriefingMsg();
	print("OnEvent_570_out end");
end

--�|�����J�n�t�H�[�h�A�E�g��
function OnEvent_571_RemoStart(proxy,param)
	print("OnEvent_571_RemoStart begin");
	proxy:DeleteEvent( 570 );
	proxy:InvalidSfx( 2210 , true);
	print("OnEvent_571_RemoStart end");
end

--�|�����I���t�F�[�h�C���O
function OnEvent_571_RemoFinish(proxy,param)
	print("OnEvent_571_RemoFinish begin");
	OnEvent_781(proxy,param);
	proxy:EndAnimation(1270,2);
	print("OnEvent_571_RemoFinish end");
end


-----------------------------------------------------------------------------
--��590�������g�J�Q�C�x���g2
-----------------------------------------------------------------------------
function OnEvent_590(proxy,param)
	print("OnEvent_590 begin");
	proxy:SetEventFlag( 590, true);
	proxy:DeleteEvent( 590 );
	print("OnEvent_590 end");
end

-----------------------------------------------------------------------------
--��592�������g�J�Q�C�x���g3
-----------------------------------------------------------------------------
function OnEvent_592(proxy,param)
	print("OnEvent_592 begin");
	proxy:SetEventFlag( 592, true);
	proxy:DeleteEvent( 592 );
	print("OnEvent_592 end");
end
