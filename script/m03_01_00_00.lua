
--�ÍԂ̎��l�p�̏��
SYUUJIN_STATE_ESCAPE   	= 16050;--�S����o����
SYUUJIN_STATE_THANKS 	= 16051;--������Ă���Ċ���
SYUUJIN_STATE_INTERVAL	= 16052;--���S�ŋx�e
SYUUJIN_STATE_ANGRY_01	= 16053;--�G��(���S)
SYUUJIN_STATE_DEAD 		= 16054;--���S
SYUUJIN_STATE_STAY		= 16055;--�ÍԂQ�ɂ���
SYUUJIN_STATE_ANGRY_02	= 16056;--�G��(�Í�2)


syuujin_flag_list = { 
	SYUUJIN_STATE_ESCAPE,
	SYUUJIN_STATE_THANKS,
	SYUUJIN_STATE_INTERVAL, 
	SYUUJIN_STATE_ANGRY_01, 
	SYUUJIN_STATE_DEAD,
	SYUUJIN_STATE_STAY,
	SYUUJIN_STATE_ANGRY_02,
};

--�ÍԎ��l�g�[�^���_���[�W
SYUUJIN_TOTAL_DAMAGE = 50;

---------------------------------
--�}�X�^�[�T�c�L�̏�ԕω��t���O
---------------------------------
MasterSATSUKI_NORMAL  = 16360;--�u����T���Ă���v
MasterSATSUKI_HOSTILE = 16361;--�u�G�΁v
MasterSATSUKI_DEAD    = 16362;--�u���S�v
MasterSATSUKI_HOSTILE_Makoto = 16363;--�u�G��(������)�v

MasterParamFlag_list = {
	MasterSATSUKI_NORMAL,
	MasterSATSUKI_HOSTILE,
	MasterSATSUKI_DEAD,
	MasterSATSUKI_HOSTILE_Makoto
}

--PC�̍U���ɂ���ă}�X�^�[���G�΂��邽�߂̃_���[�W�l
MasterSATSUKI_TotalDamage = 100;

---------------------------------
--�h�̖�
---------------------------------
--�A�C�e�������C�x���g�p--�K���v�f�̐��͍��킹�Ă�������
--�g����萔
--TYPE_WEAPON
--TYPE_PROTECTER
--TYPE_ACCESSORY
--TYPE_GOODS
itemevent_typelist		=	{TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,
							 TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_PROTECTER	,TYPE_PROTECTER	,TYPE_PROTECTER	,TYPE_WEAPON	,TYPE_WEAPON	,TYPE_WEAPON	};
							 
itemevent_idlist		=	{1014			,1022			,1018			,38				,2027			,2028			,2029			,2039			,2040			,2041			,
							 2045			,2046			,2047			,100100			,100000			,301700			,21600			,80300			,90400			};

itemevent_paramlist		=	{20000			,20001			,20002			,20003			,20004			,20005			,20006			,20007			,20008			,20009			,
							 20010			,20011			,20012			,20013			,20014			,20015			,20016			,20017			,20018			};

itemevent_eventidlist	=	{12621			,12622			,12623			,12624			,12625			,12626			,12627			,12628			,12629			,12630			,
							 12631			,12632			,12633			,12634			,12635			,12636			,12637			,12638			,12639			};

itemevent_endidlist		=	{12641			,12642			,12643			,12644			,12645			,12646			,12647			,12648			,12649			,12650			,
							 12651			,12652			,12653			,12654			,12655			,12656			,12657			,12658			,12659			};

--�A�C�e�������C�x���g�p���z
ITEM_LOT_A = 10;--0�`A
ITEM_LOT_B = 20;--A�`B
ITEM_LOT_C = 30;--B�`C
ITEM_LOT_D = 40;--C�`D
ITEM_LOT_E = 50;--D�`E
ITEM_LOT_F = 60;--E�`F
ITEM_LOT_G = 70;--F�`G
ITEM_LOT_H = 80;--G�`H
ITEM_LOT_I = 90;--H�`I
--J				--I�`100

ITEM_SHOWMENU = false;
PREV_ITEM_SHOWMENU = false;
--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉����������
--------------------------------------------------------------------------------------
function Initialize_m03_01_00_00(proxy)
	print("Initialize_m03_01_00_00 begin");
	
	proxy:LuaCall( 99999 , 0 , "OnEvent_4000_Hp_1",everytime);
-----------------------------------------------------------------------------------------
--�{�X�֘A
-----------------------------------------------------------------------------------------
--��594���{�X�����ɓ��遡	
	--���{�X�������Ă���Ƃ������C�x���g�o�^
	if proxy:IsCompleteEvent( 4756 ) == false then	
		--�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B
		SingleReset(proxy, 594);
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���)
		proxy:LuaCall( 593, 1, "OnEvent_594_1", everytime );		
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCall( 593 , 5 , "OnEvent_594_GO_TO_IN" , everytime );		
		--���t���O�Z�b�g(�����p)
		proxy:LuaCall( 593 , 6 , "OnEvent_594_flag_set" , everytime );		
		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ�
		if proxy:IsCompleteEvent( 594 ) == false then		
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l����
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;			
			proxy:NotNetMessage_begin();
				--��594�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegionAttribute( 594, 2894, "OnEvent_594", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B		
			proxy:NotNetMessage_begin();			
				--��593�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegion( 593, 2894, "OnEvent_594", HELPID_GO_TO_IN, everytime );--�n���h���͏�Ɠ���
			proxy:NotNetMessage_end();		
		end
	end	

	--��595���{�X�o�ꉉ�o��
	if proxy:IsCompleteEvent( 595 ) == false then
		proxy:LuaCall( 595, 0, "OnEvent_595", once );
	end
	
	--��641���{�X�퓬�J�n��
	if proxy:IsCompleteEvent( 4756 ) == false then
		proxy:OnRegionJustIn( 641 , 10000 , 2886 , "OnEvent_641" , once );
	end	
	
	--��4756�����{�X���S�Ŕ����J����
	proxy:AddFieldInsFilter( 804 );	
	if proxy:IsCompleteEvent( 4756 ) ==false then
		--��OBJ(804)�����ɁA���S�A�j���[�V�������Đ����I���������--
		proxy:OnCharacterDead(4756, 804, "OnEvent_4756", once);
		proxy:OnCharacterDead(642,804,"OnEvent_642",once);
	else
		proxy:EndAnimation( 1206, 1);
	end
	
--��4766-4787�����{�X�����@���j��

	local first_block_id  = 1208;
	local block_num = 21;  -- �S���̏ꍇ��22�A����2�e�̂Ƃ��������ɂȂ��Ă���̂�13��
	local now_block_id    = first_block_id;
	
	local first_event_id  = 4766;
	local end_event_id    = first_event_id + block_num;
	
	for i=first_event_id, end_event_id, 1 do
		
		print( "add block id is " .. now_block_id );
		if proxy:IsCompleteEvent( 4756 ) == false then
			SingleReset( proxy, i );
		end
		if proxy:IsCompleteEvent( i ) == false then
			--���������ɉ��ĂȂ����ɂ���
			proxy:RestorePiece( now_block_id );
			proxy:OnObjectDestroy( i, now_block_id, "OnEvent_"..i , once );
		else
			proxy:ReconstructBreak( now_block_id , 2 );
		end
		
		now_block_id = now_block_id + 1;
	end

	local actIdlist2 = { 4788, 4789, 4790, 4791, 4792 };
	local objIdlist2 = { 1230, 1231, 1232, 1233, 1234 };
	local num = table.getn( actIdlist2 );
	for index = 1 , num , 1 do
		local actionid = actIdlist2[index];
		local objid = objIdlist2[index];
		--�{�X�������Ă�����
		if proxy:IsCompleteEvent( 4756 ) == false then
			SingleReset( proxy, actionid );
		end
		if proxy:IsCompleteEvent( actionid ) == false then
			proxy:NotNetMessage_begin();
				--��ɏC��
				proxy:RestorePiece( objid );
				proxy:OnObjectDestroy( actionid , objid , "OnEvent_"..actionid , once);
			proxy:NotNetMessage_end();
		else
			proxy:ReconstructBreak( objid , 1 );
		end	
	end
	
	--����AReconstructBreak��Initialize�̃^�C�~���O�ŌĂ�ł�
	--ReconstructBreak�̒��̏������܂��r���Ȃ��߁A
	--�j��̍Č��͍s��ꂸ�A�I�u�W�F���\������Ȃ���ԂɂȂ�B
	--���g���ł����炱�̃^�C�~���O�ŌĂ�ł��j��Č����Ă����͂�(���Ԃ�)
	--���̏�ԂŁA�j��Č��������ꍇ��Second_Initialize�̒��ɏ����悤�ɂ���B

	--���{�X�֘A�̏���������
	if proxy:IsCompleteEvent( 4756 ) ==true then
		
		--���{�X����ł���Ƃ�
		--�{�X���Ȃ��Ȃ�
		InvalidBackRead( proxy , 804 );

		--���@�Ǐ�����
		proxy:SetDrawEnable( 1994 , false );
		proxy:SetColiEnable( 1994 , false );

		proxy:SetDrawEnable( 1998 , false );
		proxy:SetColiEnable( 1998 , false );

		--���@�ǂ� SFX OFF		
		proxy:InvalidSfx( 1990 , false );
		proxy:InvalidSfx( 1986 , false );

		--�z�X�g�v���C���[�̂݃A�C�e������C�x���g�Ɏg�p
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--�󎀑�(�\�E��?)�L����
		proxy:SetDrawEnable( 1981 , true );
		proxy:SetColiEnable( 1981 , true );
		--�󎀑�(�\�E��?)�L����
		proxy:SetDrawEnable( 1976 , true );
		proxy:SetColiEnable( 1976 , true );
		
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--���点��
		--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
		if proxy:IsCompleteEvent( 4804 ) == false then
			proxy:ValidSfx( 2286 );--SFX �L����
			proxy:ValidSfx( 2287 );--SFX �L����			
			proxy:OnDistanceActionAttribute( 4804 , 10000 , 1981 , "OnEvent_4804" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--���v�΂Ń��[�v�p�̊Ď���ǉ���
			SingleReset(proxy,4805);			
			proxy:InvalidSfx( 2286, false );--SFX ������
			proxy:OnDistanceActionAttribute( 4805 , 10000 , 1981 , "OnEvent_4805" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
		
	else
		--���{�X�����Ă���Ƃ�		
		proxy:EnableLogic( 804 , false );--���W�b�NOFF�őҋ@
		
		--��(�\�E��?)
		proxy:SetDrawEnable( 1981 , false );
		proxy:SetColiEnable( 1981 , false );
		--��(�\�E��?)2
		proxy:SetDrawEnable( 1976 , false );
		proxy:SetColiEnable( 1976 , false );
		
		--SFX ������
		proxy:InvalidSfx( 2287 , false );--�\�E���p
		proxy:InvalidSfx( 2286 , false );--�{�X�A�C�e���p		
	end	
	
-----------------------------------------------------------------------------------------
--�M�~�b�N�֘A
-----------------------------------------------------------------------------------------
	--��636����̍U����
	--proxy:OnRegistFunc(636, "Check_636", "OnEvent_636", 1, everytime );
	--proxy:OnCharacterDead( 636, 325, "OnEvent_636_1", once );
	--��637����̍U����
	--proxy:OnRegistFunc(637, "Check_637", "OnEvent_637", 1, everytime );
	--proxy:OnCharacterDead( 637, 326, "OnEvent_637_1", once );
	
	--��638����̍U����	
	--proxy:OnRegistFunc(638, "Check_638", "OnEvent_638", 1, everytime );
	--proxy:OnCharacterDead( 638, 327, "OnEvent_638_1", once );	
	
	--��542���͂���A�~�聡
	--��PC���C�x���g�G���A(2200)�̒��ɋ��āA�����p�x(LadderAngle_A)�ŃA�N�V�����{�^�����������Ƃ���--
	proxy:OnActionEventRegion( 542, 2200, "OnEvent_542", LadderAngle_A, HELPID_DOWN, everytime );
	--��543���͂���A���聡
	--��PC���C�x���g�G���A(2201)�̒��ɋ��āA�����p�x(90)�ŃA�N�V�����{�^�����������Ƃ���--
	proxy:OnActionEventRegion( 543, 2201, "OnEvent_543", LadderAngle_A, HELPID_UP, everytime );	

	--��583���Β��Ƀ��[�v��
	SingleReset(proxy,583);
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	--2008.06.05/toyohide �����ύX�ɂ��A�C��
	--proxy:OnDistanceActionAttribute( 583, 10000, 1983, "OnEvent_583", WarpGimmickDist_A, HELPID_GO_TO_SEKITYUU, 0, 180, ATTR_NOSESSION, everytime );
	proxy:OnDistanceAction( 583, 10000, 1983, "OnEvent_583", WarpGimmickDist_A,HELPID_GO_TO_SEKITYUU, 0, 180 , everytime);

	
--��660���ŏ��̗v�΂̌��������遡
	proxy:OnSessionJustIn( 660 , "OnEvent_660" , everytime );
		
--��661���ŏ��̗v�΂̌����������遡
	proxy:OnSessionJustOut( 661 , "OnEvent_661" , everytime );

--��8085���Ԃɗ����t���O�𗧂Ă遡
	proxy:SetEventFlag(8085, true);

	
--���̖���ʉ߂ł���L�����^�C�v(���̃^�C�v�̐l�����A�N�V�����{�^������������)
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	
	--��644���z�X�gPC�݂̂��ʂ����̖���
	if proxy:IsCompleteEvent( 644 ) == true then--�z�X�g���ʉߍς�
		proxy:SetDrawEnable( 1332 , false );
		proxy:SetColiEnable( 1332 , false );
		proxy:InvalidSfx( 2231, false );
	else
		--��644�����@�Ǎ폜�����p��
		proxy:LuaCall( 644 , 1 , "OnEvent_644_delete_wall" , once );
	
		--��644���ǂ̒��ɓ���C�x���g�����p��
		proxy:OnDistanceActionAttribute( 644 , 10000 , 1332 , "OnEvent_644" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
	
	--��645���z�X�gPC�݂̂��ʂ����̖�2��
	if proxy:IsCompleteEvent( 645 ) == true then--�z�X�g���ʉߍς�
		proxy:SetDrawEnable( 1333 , false );
		proxy:SetColiEnable( 1333 , false );
		proxy:InvalidSfx( 2232, false );
	else
	
		--��645�����@�Ǎ폜�����p��
		proxy:LuaCall( 645 , 1 , "OnEvent_645_delete_wall" , once );
		
		--��645���ǂ̒��ɓ���C�x���g�����p��
		proxy:OnDistanceActionAttribute( 645 , 10000 , 1333 , "OnEvent_645" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
	
		
	--��646���z�X�gPC�݂̂��ʂ����̖�3��
	if proxy:IsCompleteEvent( 646 ) == true then--�z�X�g���ʉߍς�
		proxy:SetDrawEnable( 1334 , false );
		proxy:SetColiEnable( 1334 , false );
		proxy:InvalidSfx( 2233, false );
	else
		
		--��646�����@�Ǎ폜�����p��
		proxy:LuaCall( 646 , 1 , "OnEvent_646_delete_wall" , once );
		
		--��646���ǂ̒��ɓ���C�x���g�����p��
		proxy:OnDistanceActionAttribute( 646 , 10000 , 1334 , "OnEvent_646" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
	
--��639���S�̔���
	if proxy:IsCompleteEvent( 639 ) == false then
		proxy:NotNetMessage_begin();
			proxy:OnDistanceActionPlus( 639, 10000, 1331, "OnEvent_639", DoorDist_A, HELPID_OPEN, 0.0, DoorAngle_A, 0.0, 0.0, 0.0, everytime );
		proxy:NotNetMessage_end();
		proxy:LuaCall( 639, 1, "OnEvent_639_2", once );
	else
		proxy:EndAnimation( 1331, 1 );
	end
	
	--�����A�C�e�������n�C�x���g��
	--����or�O���C�S�[�X�g�̂�
	if proxy:IsClient() == false and proxy:IsCompleteEvent(659) == false then

		--�A�C�e�����̂ĂĂ������������
		if proxy:IsCompleteEvent(12613) == true then
			proxy:SetEventFlag(12614,true);
			--proxy:SetEventFlag(12613,false);
			SingleReset(proxy, 12613);
		end
		
		print("live or grey");
	--��654���V�̐���
		--��b�̓o�^
		--�����\�A�C�e�����̂Ă����̉�b
		proxy:RegistSimpleTalk( 12613, 2284, 25040, TALK_ATTR_ALL - TALK_ATTR_REPEAT );
		--�����\�A�C�e�����̂Ă������Ɍ����ς݂̉�b
		proxy:RegistSimpleTalk( 663, 2284, 25060, TALK_ATTR_ALL - TALK_ATTR_REPEAT );
		--�����ł����`��b
		proxy:RegistSimpleTalk( 654, 2284, 25000, TALK_ATTR_ALL - TALK_ATTR_REPEAT );
		--�܂������ł����`��b
		proxy:RegistSimpleTalk( 655, 2284, 25010, TALK_ATTR_ALL - TALK_ATTR_REPEAT );
		--�������߂ہ[
		proxy:RegistSimpleTalk( 659, 2284, 25070, TALK_ATTR_ALL - TALK_ATTR_REPEAT );		
		
		--�����ΏۊO�̃A�C�e�����h���b�v
		proxy:RegistSimpleTalk( 662, 2284, 25050, TALK_ATTR_ALL - TALK_ATTR_REPEAT );
		
		
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnRegionIn(654,10000,2284,"OnEvent_654",once);				
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();		
		
	--��12613���A�C�e���h���b�v�̊Ď���	
		proxy:NotNetMessage_begin();
			--��ɒ��ׂ܂�
			proxy:OnRegionIn(12613,10000,2284,"OnEvent_12613",everytime);
			--�E�������̊Ď�
			--proxy:LuaCall(12613,0,"OnEvent_12613_1",everytime);
			local num = table.getn(itemevent_eventidlist);
			for index=1 ,num ,1 do
				proxy:LuaCall( itemevent_eventidlist[index],0,"OnEvent_"..itemevent_eventidlist[index].."_1",everytime);
			end
		proxy:NotNetMessage_end();
	
	--��658���A�C�e��������
		if proxy:IsCompleteEvent(12614) == true then
			print("Item event treu");
			proxy:NotNetMessage_begin();
			proxy:RepeatMessage_begin();
				proxy:OnDistanceAction(658,10000,1335,"OnEvent_658",ItemBoxDist_A,HELPID_CHECK,0,60,once);
				proxy:TreasureDispModeChange2(1335,true,ITEM_SFX);
				--proxy:SetRarity(1335,10217);
			proxy:RepeatMessage_end();
			proxy:NotNetMessage_end();
		else
			print("Item event false");			
			--�\���������Ă���
			proxy:SetDrawEnable(1335,false);
		end
	else
		print("dead");
		proxy:SetDrawEnable(1335,false);
	end

------------------------------------------------------------------------------------------------
--���[�����m�N����
------------------------------------------------------------------------------------------------
--��730�`753���[�����m_�N����
	--����Ȃ��������Ƀ��Z�b�g
	for ActionID = 730, 759, 1 do
		SingleReset(proxy, ActionID);
	end
	
	local actIdlist = { 730, 731, 732, 733, 734, 735, 736, 737, 738, 739, 
						740, 741, 742, 743, 744, 745, 746, 747, 748, 749,
						750, 751, 752, 753, 754, 755, 756, 757, 758, 759,
						};
	local eneIdlist = { 360, 361, 362, 363, 364, 365, 366, 367, 368, 369,
						370, 371, 372, 373, 374, 375, 376, 377, 378, 379,
						380, 381, 382, 383, 384, 428, 429, 430, 431, 432,
						};
						
	local num = table.getn( actIdlist );
	--�N�����鋗���Ď��̒ǉ��Ə�����
	for index=1 , num , 1 do 	
		local SkeletonID = eneIdlist[ index ];
		local ActionID = actIdlist[ index ];		
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
			end
		end
	end

-----------------------------------------------------------------------------
--��780�`784�����ˏo�g���b�v
-----------------------------------------------------------------------------
--OnEvent_780, OnEvent_781, OnEvent_782, OnEvent_783, OnEvent_784

--���ˏo�g���b�v�����n���h��
	proxy:NotNetMessage_begin();
		proxy:LuaCall(780, 0, "SpearTrapMove_780", everytime);
		proxy:LuaCall(782, 0, "SpearTrapMove_782", everytime);
		proxy:LuaCall(783, 0, "SpearTrapMove_783", everytime);
		proxy:LuaCall(784, 0, "SpearTrapMove_784", everytime);
	proxy:NotNetMessage_end();
	
--�e�g���b�v������
	for index = 1, 5, 1 do
		local acId		= 780  + index - 1;
		local regionId	= 2250 + index - 1;
		local objId_1	= 1240 + index - 1;--�X�C�b�`
		local objId_2	= 1250 + index - 1;--�A�˗p
		local objId_3	= 1260 + index - 1;--�|�˗p
		local ownerId	= 330;
		local SfxId	= 93005;--SFX��ID
		
		--�V���O���Ȃ烊�Z�b�g
		SingleReset(proxy, acId);
		--�G�𖳌�������͂�����
		CreateBulletOwner(proxy, ownerId);	
		
		proxy:SetBallista( objId_2, ownerId );
		proxy:SetBallista( objId_3, ownerId );
		if	proxy:IsCompleteEvent( acId ) == false then
			--OBJ�̃_�~�|����SFX��ݒ�
			proxy:SetObjSfx(objId_1, 1, SfxId, false);
			proxy:OnRegionJustIn( acId, LOCAL_PLAYER, regionId, "OnEvent_"..acId, once );
		else
			proxy:EndAnimation( objId_1, 1 );
			proxy:EndAnimation( objId_2, 1 );
		end
	end

--��785���J���X������������
	--OnEvent_784��1�b��ɔ���

--[[
	--��572���₪���ł��遡QWC�C�x���g
	
	if proxy:IsCompleteEvent(572) ==true then
		print("[����]QWC�����");
		proxy:SetDrawEnable(1207, false );
		proxy:SetColiEnable(1207, false );
	else
		print("[������]QWC�����");
	end]]
--[[�C�x���g���폜���ꂽ�ׁA�R�����g�A�E�g
	--��532-534���x(����ʂ�)��A��
	if proxy:IsCompleteEvent( 532 ) == false then		
		proxy:OnDistanceActionPlus( 532, 10000, 1204, "OnEvent_532", DoorDist_A, HELPID_OPEN, 180.0, 30.0, 0.0, -1.2, 0.0, once );	
	else
		proxy:EndAnimation( 1204, 1 );--�x�����J����
	end
	
	--��651���[���C�x���g��		
	if proxy:IsCompleteEvent(651) == false then
		proxy:OnRegionJustIn( 651,10000,2050,"OnEvent_651",once);
		proxy:PlayLoopAnimation(328,7000);--�ׂ�Ă�A�j��
		proxy:SetColiEnable(328,false);--�A�^��OFF
	end
	
	--��652���[���C�x���g��
	if proxy:IsCompleteEvent(652) == false then
		proxy:OnRegionJustIn( 652,10000,2060,"OnEvent_652",once);
		
		local eneid = 1;
		for eneid = 329, 334, 1 do
			proxy:PlayLoopAnimation(eneid,7000);--�ׂ�Ă�A�j��
			proxy:SetColiEnable(eneid,false);--�A�^��OFF
		end		
	end
	
	--��653���[���C�x���g��
	if proxy:IsCompleteEvent(653) == false then
		proxy:OnRegionJustIn( 653,10000,2070,"OnEvent_653",once);
		local eneid = 1;
		for eneid = 336, 339, 1 do
			proxy:PlayLoopAnimation(eneid,7000);--�ׂ�Ă�A�j��
			proxy:SetColiEnable(eneid,false);--�A�^��OFF
		end				
	end]]

-----------------------------------------------------------------------------------------
--NPC�֘A
-----------------------------------------------------------------------------------------
	if proxy:IsClient() == false	then
	--��631���ÍԎ��lNPC�`�F�b�N�|�C���g(�X�^�[�g�n�_)��
		proxy:OnRegionJustIn( 631 , 10000 , 2300 ,"OnEvent_631" , everytime);
	
	--��632���ÍԎ��lNPC�`�F�b�N�|�C���g(�R���҂̕���)��
		proxy:OnRegionJustIn( 632 , 10000 , 2301 , "OnEvent_632" , everytime);
	
	--��634���ÍԎ��lNPC�`�F�b�N�|�C���g(���̐�m�̕���)��
		proxy:OnRegionJustIn( 633 , 10000 , 2550 , "OnEvent_633" , everytime);
	end
	
	--��635���`�F�b�N�|�C���g�̊Ď���
	proxy:LuaCall( 634 , 1 , "OnEvent_634",everytime);

--------------------------------������QWC�C�x���g�֘A������--------------------------------
----------------------------------------------------------------
--�}�X�^�[�T�c�L(638)
----------------------------------------------------------------
	--�}�X�^�[�T�c�L�̏�����Ԃ��u����T���Ă���v�ɃZ�b�g����
	SetFirstNpcStateFlag( proxy, param, MasterParamFlag_list, MasterSATSUKI_NORMAL );

	if proxy:IsCompleteEvent(MasterSATSUKI_NORMAL) == false or	--�u����T���Ă���v�łȂ��@��
	   proxy:IsSuccessQWC(30120) == true or--QWC���������Ă���@��
	   proxy:IsSuccessQWC(30130) == true then--QWC���������Ă���@�Ȃ��
		--��703���T�c�L(638)��������
		InvalidBackRead(proxy, 638);--�T�c�L(638)������
		
		print("�T�c�L(638)�o�������𖞂����Ă��Ȃ�");
		proxy:SetEventFlag(702, false);
		proxy:SetEventFlag(703, true);
	else--�u����T���Ă���v����QWC�����𖞂����Ă���Ȃ��
		--��702���T�c�L(638)�L������
		proxy:SetDeadMode(638, true);--HP��1�ȉ��ɂȂ�Ȃ�
		
		--��700���T�c�L�����遡
		SingleReset( proxy,700 );
		if proxy:IsCompleteEvent(700) == false then
			proxy:OnCharacterTotalDamage(700, 638, -1, 1, "OnEvent_700", once);--�_���[�W�Ď��ǉ��i�_���[�W�ʂP�j
		end
		
		--��701���T�c�L�������遡
		SingleReset( proxy,701 );
		if proxy:IsCompleteEvent(701) == false then
			proxy:OnRegionJustIn(701,638,2241,"OnEvent_701",once);--�̈�Ď��ǉ�
		end
		
		print("�T�c�L(638)�o��");
		proxy:SetEventFlag(703, false);
		proxy:SetEventFlag(702, true);
	end
----------------------------------------------------------------
--�}�X�^�[�T�c�L(637)
----------------------------------------------------------------
	--�}�X�^�[�T�c�L�̏�ԕω��̏���
	if proxy:IsCompleteEvent( MasterSATSUKI_DEAD ) == false then--����ł��Ȃ��Ȃ��
		if proxy:IsCompleteEvent( MasterSATSUKI_HOSTILE ) == false and		   --�G�΂��Ă��Ȃ��@����
           proxy:IsCompleteEvent( MasterSATSUKI_HOSTILE_Makoto ) == false then --�G�΁i���j���Ă��Ȃ��@�Ȃ��
			--��704���T�c�L�G�Ή���
			proxy:OnCharacterTotalRateDamage( 704, 637, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_704", once );
			--��705���T�c�L�G�Ή�(������)��
			proxy:LuaCall( 705, 0, "OnEvent_705", once );--�T�c�L�Ɂu���v��n���Ă̓G�Ώ���
			proxy:LuaCall( 713, 0, "OnEvent_713", once );--�T�c�L�Ɂu��+1�v��n���Ă̓G�Ώ���
			proxy:LuaCall( 714, 0, "OnEvent_714", once );--�T�c�L�Ɂu��+2�v��n���Ă̓G�Ώ���
			proxy:LuaCall( 715, 0, "OnEvent_715", once );--�T�c�L�Ɂu��+3�v��n���Ă̓G�Ώ���
			proxy:LuaCall( 716, 0, "OnEvent_716", once );--�T�c�L�Ɂu��+4�v��n���Ă̓G�Ώ���
			proxy:LuaCall( 717, 0, "OnEvent_717", once );--�T�c�L�Ɂu��+5�v��n���Ă̓G�Ώ���
			
			
			--��706���T�c�L�G�Ή�(��������)��
			proxy:LuaCall( 706, 0, "OnEvent_706", once );--�T�c�L�Ɂu���v��n���Ȃ��ł̓G�Ώ���
		end
		--��707���T�c�L���S��
		proxy:OnCharacterDead( 707, 637, "OnEvent_707", once );--���S�Ď��ǉ�
	end

	--�}�X�^�[�T�c�L�̏���������
	if proxy:IsSuccessQWC(30130) == true then--QWC�����𖞂����Ă���@�Ȃ��
		if proxy:IsCompleteEvent( MasterSATSUKI_HOSTILE ) == true then--�}�X�^�[�T�c�L���G�΂��Ă������̏���������
			--��708���T�c�L�G�Ώ�������
			proxy:EnableLogic(637, true);--���W�b�NON
			proxy:SetTeamType(637, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
			--SetNpcStateFlag(proxy, param, MasterParamFlag_list, MasterSATSUKI_HOSTILE);--��ԕω�
			proxy:SetEventFlag(708, true);
			print("�T�c�L(637)��ԁ@�G��");
			
		elseif proxy:IsCompleteEvent(MasterSATSUKI_HOSTILE_Makoto) == true then--�}�X�^�[�T�c�L���G��(������)���Ă������̏���������
			--��709���T�c�L�G��(��)��������
			
			--TargetChangeWepR2(proxy, 637);--�T�u����i���j�ɐ؂�ւ�������
			
			proxy:EnableLogic(637, true);--���W�b�NON
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 705,"OnEvent_705_1",0.0,0,0,once);
			proxy:NotNetMessage_end();
			proxy:SetTeamType(637, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
			--SetNpcStateFlag(proxy, param, MasterParamFlag_list, MasterSATSUKI_HOSTILE_Makoto);--��ԕω�
			proxy:SetEventFlag(709, true);
			print("�T�c�L(637)��ԁ@�G�΁i���j");
			
		elseif proxy:IsCompleteEvent( MasterSATSUKI_DEAD ) == true then--�}�X�^�[�T�c�L�����S���Ă������̏���������
			--��710���T�c�L���S��������
			InvalidBackRead(proxy, 637);--������
			proxy:SetEventFlag(710, true);
			print("�T�c�L(637)��ԁ@���S");
			
		end
	else--QWC�����𖞂����Ă��Ȃ��@�Ȃ��
		--��710���T�c�L������������
		InvalidBackRead(proxy, 637);--������
		proxy:SetEventFlag(710, true);
		print("�T�c�L(637)��ԁ@�o�������𖞂����Ă��Ȃ�");
	
	end
----------------------------------------------------------------
--�}�X�^�[�T�c�L�E�u���b�N(420)
----------------------------------------------------------------


--��15634���T�c�L�E�u���b�N�̎��̂𒲂ׂ���
	if proxy:IsCompleteEvent( 15634 ) == false then
		proxy:AddCorpseEvent( 15634 , 420 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15634 ,0 , "OnEvent_15634",once );
 		proxy:NotNetMessage_end();
	end
	
	if	proxy:IsCompleteEvent(711) == false and --���S���Ă��Ȃ��@����
		proxy:IsSuccessQWC(30120) == true then --QWC�����𖞂����Ă���@�Ȃ��
		--��711���T�c�L�E�u���b�N���S�Ď���
		proxy:OnCharacterDead( 711, 420, "OnEvent_711", once );--���S�Ď��ǉ�
--		proxy:SetTeamType( 420, TEAM_TYPE_AngryFriend );--�`�[���^�C�v�ύX�@�G��		
		
		proxy:SetEventFlag(712, false);
		
		print("�T�c�L�E�u���b�N�i420�j�o��");
	else--���S���Ă��邩QWC���݂����Ă��Ȃ��Ȃ��
		--��712���T�c�L�E�u���b�N���S��������
		if 	proxy:IsCompleteEvent( 711 ) == true and
			proxy:IsCompleteEvent( 15634 ) == false then
			--���̂��Č�����
			proxy:OpeningDeadPlus( 420 , true ,false ,false );
		else
			InvalidBackRead(proxy, 420);
		end
		proxy:SetEventFlag(712, true);
		print("�T�c�L�E�u���b�N�i420�j��ԁ@����");
	end

----------------------------------------------------------------
--QWC�\�E�������X�^�[
----------------------------------------------------------------

--��690��QWC�\�E�������X�^�[�o���P��
	if	proxy:IsSuccessQWC(30100) == true then
		print("m03_01 QWC�\�E�������X�^�[�o���@����");
		ValidCharactor( proxy, 428 );
		ValidCharactor( proxy, 429 );
		ValidCharactor( proxy, 430 );
		ValidCharactor( proxy, 431 );
		ValidCharactor( proxy, 432 );
	else
		print("m03_01 QWC�\�E�������X�^�[�o���@������");
		InvalidCharactor( proxy, 428 );
		InvalidCharactor( proxy, 429 );
		InvalidCharactor( proxy, 430 );
		InvalidCharactor( proxy, 431 );
		InvalidCharactor( proxy, 432 );
	end
	
	RegistTokage( proxy, 620 , 250,7);
	RegistTokage( proxy, 622 , 251,8);
--------------------------------������QWC�C�x���g�֘A������--------------------------------

--------------------------------------------------------------------------------------
--�����ς݁��@����������Initialize_m03_01_00_00
--------------------------------------------------------------------------------------
--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m03_01_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m03_01_00_00", everytime );
	proxy:NotNetMessage_end();

	
--��682���{�X��J�����Ή���
	--�{�X�������Ă���Ȃ�o�^
	if proxy:IsCompleteEvent(4756) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 682 , 10000 , 2886 ,"OnEvent_682" , everytime );
		proxy:NotNetMessage_end();
	end

--[[
	--�t���O������NPC��Ԃ�������
	SetFirstNpcStateFlag( proxy, param, syuujin_flag_list, SYUUJIN_STATE_ESCAPE )

	--���S���Ă��Ȃ��Ƃ�
	if proxy:IsCompleteEvent( SYUUJIN_STATE_DEAD ) == false then
		--�G�΂��Ă��Ȃ��Ƃ�
		if proxy:IsCompleteEvent( SYUUJIN_STATE_ANGRY_01 ) == false then
			--EzState�ɃR�}���h���M:���Ԃ��ҋ@�ɂȂ�
			proxy:SetEventCommand(633,30);
			--��627���y���SNPC�zNPC�����ӏ�Ԃ���Ȃ���
			if proxy:IsCompleteEvent( 627 ) == false then
				proxy:OnRegistFunc( 627, "Condition_627", "OnEvent_627", 1, once );				
			end	
			--��628���y���SNPC�zNPC����A�C�e����������ĂȂ���
			if proxy:IsCompleteEvent( 628 ) == false then
				proxy:NotNetMessage_begin();
					proxy:LuaCall( 628, 0, "OnEvent_628", once );
				proxy:NotNetMessage_end();
			end
			--��629���y���SNPC�zNPC���G�ɂȂ��ĂȂ���
			if proxy:IsCompleteEvent( 629 ) == false then
				proxy:OnCharacterTotalDamage( 629, 633, 10000, 50, "OnEvent_629", once );
			end
			
		--����ȊO�̏�����
		else
			print("�Ӗ��̖�����");
			proxy:EnableLogic( 633, false );
		end
		--��630���y���SNPC�zNPC�����񂾁�
		if proxy:IsCompleteEvent( 630 ) == false then
			proxy:OnCharacterDead( 630, 633, "OnEvent_630", once );		
		end
	else
		print("���SNPC���S");		
		--����ł���̂Ŗ�����		
		proxy:ForceUpdateNextFrame(633);
		InvalidBackRead(proxy, 633 );		
	end	
	]]
	--�ÍԎ��l��ԕω��l�ߍ��킹
	OnEvent_634(proxy,param);
	--�Ȃ񂾂���Invalid�E�E�E
	--InvalidCharactor(proxy,326);
	
--��550���f�u�f�[�������S�Ď���
	if proxy:IsCompleteEvent( 550 ) == false then
		proxy:OnCharacterDead( 550 , 421 , "OnEvent_550",once);
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 552 , 10000, 2269 , "OnEvent_552",everytime);
		proxy:NotNetMessage_end();
	else
		InvalidCharactor( proxy , 421 );
	end
	
--��790�����@�̕ǔj��P��
	SingleReset(proxy,790);
	if proxy:IsCompleteEvent( 790 ) == false then
		--���A
		proxy:RestorePiece( 1270 );
		proxy:OnObjectDestroy( 790 , 1270 ,"OnEvent_790",once);
	else
		proxy:ReconstructBreak( 1270,1);
	end
	
--��791�����@�̕ǔj��Q��
	SingleReset(proxy,791);
	if proxy:IsCompleteEvent( 791 ) == false then
		--���A
		proxy:RestorePiece( 1271 );
		proxy:OnObjectDestroy( 791 , 1271 ,"OnEvent_791",once);
	else
		proxy:ReconstructBreak( 1271,1);
	end


--��15500�������A�C�e���擾�Ď����n���h���̓O���[�o���ɒ�`
--~ 	if proxy:IsCompleteEvent( 15500 ) == false then		
--~ 		proxy:AddCorpseEvent( 15500 , 420 );--�}�X�^�[�T�c�L�E�u���b�N
--~ 	end
	
	-----------------------------------------------------------------------------
	--��999999���t���[���x��̏����������C�x���g�𔭍s��
	proxy:NotNetMessage_begin();
		--��0�b�づ--
		proxy:OnKeyTime2( 999991, "Second_Initialize_m03_01_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	if proxy:IsDbgReLoad() == true then
		proxy:OnKeyTime2( 4021,"OnEvent_DbgReLoad",1.0,0,0,once);
	end
	print("Initialize_m03_01_00_00 end");
end

--�����[�h�f�o�b�O
function OnEvent_DbgReLoad(proxy,param)
	--�Íԗv�΂ɖ߂�
	--���S�񕜗v��
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1007);	
end


--------------------------------------------------------------------------------------
--Initialize����Ă΂��A1�t���[���x��̏�����������999999
--------------------------------------------------------------------------------------
--��999999���ꕔ�AInit�ł͏����ł��Ȃ��̂ŁA�c���Ă���
function Second_Initialize_m03_01_00_00(proxy, param)
	print("Second_Initialize_m03_01_00_00 begin");

--------------------------------������QWC�C�x���g�֘A������--------------------------------
--------------------------------������QWC�C�x���g�֘A������--------------------------------

	print("Second_Initialize_m03_01_00_00 end");
end


--------------------------------------------------------------------------------------
--�}���`�ɂȂ������Ƀz�X�g���ᖳ�������灡����
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end

function OnEvent_4000_Hp_1(proxy,param)
	print("OnEvent_4000_Hp_1 begin");
	proxy:SetDeadMode2(804 , true );
	proxy:SetDeadMode2(805 , true );
	proxy:SetDeadMode2(822 , true );
	print("OnEvent_4000_Hp_1 end");
end

--[[
--���������ɂ��n�{�b�N�������e�X�g�p
function test_destroy(proxy, param )
	local ObjID =0;
    for ObjID = 1208,1214,1 do
	--  proxy:ChangeModel(ObjID, 1);
	--	proxy:SetBrokenPiece(ObjID);
		proxy:ReconstructBreak( ObjID , 1 );
    end
	OnEvent_4766_1(proxy,param);
	OnEvent_4767_1(proxy,param);
	OnEvent_4768_1(proxy,param);
	OnEvent_4769_1(proxy,param);
	OnEvent_4770_1(proxy,param);
	
	OnEvent_4771_1(proxy,param);
	OnEvent_4772_1(proxy,param);
end
]]







--------------------------------------------------------------------------------------
--��644���z�X�gPC�݂̂��ʂ����̖�1��
--------------------------------------------------------------------------------------
--��644_delete_wall�����@�Ǎ폜�����p��
function OnEvent_644_delete_wall(proxy , param)
	print("OnEvent_644_delete_wall begin");
	
	proxy:SetDrawEnable( 1332 , false );--�`��OFF
	proxy:SetColiEnable( 1332 , false );--������OFF
	proxy:SetObjDeactivate( 1332 , true );--�f�A�N�e�B�u
	proxy:InvalidSfx( 2231 , true );--SFX OFF
	proxy:DeleteEvent( 644 );
	
	print("OnEvent_644_delete_wall end");
end

--��644���C�x���g�����p��
function OnEvent_644(proxy , param)
	print("OnEvent_644 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 644 ) == true then
		print("OnEvent_644 end");
		return;
	end

	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 644 , true );
		print("OnEvent_644 end");
		return;
	end
	
	--�_�~�|���փ��[�v
	proxy:WarpDmy( 10000 , 1332 , 191 );
	
	proxy:NotNetMessage_begin();
		--��644_1�������A�j���I����
		--proxy:OnChrAnimEnd( 644 , 10000 , ANIMEID_WALK , "OnEvent_644_1" , once );
		proxy:LuaCallStart( 644 , 1 );--���̖��폜����
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 644 , true );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_644 end");
end

--��644_1�������A�j���I����
function OnEvent_644_1(proxy , param)
	print("OnEvent_644_1 begin");
	
	proxy:LuaCallStart( 644 , 1 );--���̖��폜����
	
	print("OnEvent_644_1 end");
end


--------------------------------------------------------------------------------------
--��645���z�X�gPC�݂̂��ʂ����̖�2��
--------------------------------------------------------------------------------------
--��645_delete_wall�����@�Ǎ폜�����p��
function OnEvent_645_delete_wall(proxy , param)
	print("OnEvent_645_delete_wall begin");
	
	proxy:SetDrawEnable( 1333 , false );--�`��OFF
	proxy:SetColiEnable( 1333 , false );--������OFF
	proxy:SetObjDeactivate( 1333 , true );--�f�A�N�e�B�u
	proxy:DeleteEvent( 645 );
	proxy:InvalidSfx( 2232 , true );--SFX OFF
	
	print("OnEvent_645_delete_wall end");
end

--��645���C�x���g�����p��
function OnEvent_645(proxy , param)
	print("OnEvent_645 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 645 ) == true then
		print("OnEvent_645 end");
		return;
	end

	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 645 , true );
		print("OnEvent_645 end");
		return;
	end
	
	--�_�~�|���փ��[�v
	proxy:WarpDmy( 10000 , 1333 , 191 );
	
	proxy:NotNetMessage_begin();
		--��645_1�������A�j���I����
		--proxy:OnChrAnimEnd( 645 , 10000 , ANIMEID_WALK , "OnEvent_645_1" , once );
		proxy:LuaCallStart( 645 , 1 );--���̖��폜����
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 645 , true );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_645 end");
end

--��645_1�������A�j���I����
function OnEvent_645_1(proxy , param)
	print("OnEvent_645_1 begin");
	
	proxy:LuaCallStart( 645 , 1 );--���̖��폜����
	
	print("OnEvent_645_1 end");
end


--------------------------------------------------------------------------------------
--��646���z�X�gPC�݂̂��ʂ����̖�3��
--------------------------------------------------------------------------------------
--��646_delete_wall�����@�Ǎ폜�����p��
function OnEvent_646_delete_wall(proxy , param)
	print("OnEvent_646_delete_wall begin");
	
	proxy:SetDrawEnable( 1334 , false );--�`��OFF
	proxy:SetColiEnable( 1334 , false );--������OFF
	proxy:InvalidSfx( 2233 , true );--SFX OFF
	proxy:SetObjDeactivate( 1334 , true );--�f�A�N�e�B�u
	proxy:DeleteEvent( 646 );
	
	print("OnEvent_646_delete_wall end");
end

--��646���C�x���g�����p��
function OnEvent_646(proxy , param)
	print("OnEvent_646 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 646 ) == true then
		print("OnEvent_646 end");
		return;
	end

	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 646 , true );
		print("OnEvent_646 end");
		return;
	end
	
	--�_�~�|���փ��[�v
	proxy:WarpDmy( 10000 , 1334 , 191 );
	
	proxy:NotNetMessage_begin();
		--��646_1�������A�j���I����
		--proxy:OnChrAnimEnd( 646 , 10000 , ANIMEID_WALK , "OnEvent_646_1" , once );
		proxy:LuaCallStart( 646 , 1 );--���̖��폜����
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 646 , true );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_646 end");
end

--��646_1�������A�j���I����
function OnEvent_646_1(proxy , param)
	print("OnEvent_646_1 begin");
	
	proxy:LuaCallStart( 646 , 1 );--���̖��폜����
	
	print("OnEvent_646_1 end");
end


--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ��遡594
--------------------------------------------------------------------------------------
--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫
--��594�����{�X�����ւ̔����J����
function OnEvent_594(proxy,param)
	print("OnEvent_594 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_594 end");
		return;
	end
	
	--�N���C�A���g�ցA�{�X�����j�~���s��ʒm
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 593 , 1 );--����A�j���̓����Đ�
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--���d�N���V�X�e��ID���^�C���A�E�g��ݒ肵��ON�ɂ���
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--�v���t�@�C���Z�[�u�v��
	proxy:SaveRequest_Profile();
	
	print("OnEvent_594 end");
end


--����A�j���̓����Đ�(ID����)
function OnEvent_594_1(proxy,param)
	print("OnEvent_594_1 begin");

	--proxy:SetEventFlag( 593 , 0 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ��𓯊�
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2890 );
		else
			proxy:LockSession();--���[�������b�N���܂��I
			--����A�j���Đ����s���A���̏I������OnEvent_593_2�𔭍s����
			proxy:OnTurnCharactorEnd( 593, 10000, 2890, "OnEvent_594_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	--proxy:SetEventFlag( 593 , 1 );
	
	print("OnEvent_594_1 end");
end

--����A�j���̓����Đ��I����
function OnEvent_594_2(proxy,param)
	print("OnEvent_594_2 begin");

	--proxy:SetEventFlag( 593 , 0 );
	
	--�����p�����A�j���Đ�
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 593, 10000, ANIMEID_WALK, "OnEvent_594_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	--proxy:SetEventFlag( 593 , 1 );
	
	print("OnEvent_594_2 end");
end

--�����A�j���̓����Đ��I����
function OnEvent_594_3(proxy,param)
	print("OnEvent_594_3 begin");

	--�ŏ��̐l���{�X�����̒��ɓ���I����Ă�����A���ɔz�M����Ă���͂��Ȃ̂ŁA����������Ȃ��n���h��
	if proxy:IsCompleteEvent( 594 ) == false then
		proxy:LuaCallStart( 593 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCallStart( 4045 , 1 );	--�N���C�A���g�ցA�{�X�����ɓ����悤�ɂȂ������Ƃ�ʒm
		proxy:LuaCallStart( 593 , 6 );--�t���O�Z�b�g(�����p)
		Lua_MultiDoping(proxy,804);--�}���`�v���C�h�[�s���O
	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�)
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:ResetThink( 804 );
	end
	
	
	--proxy:SetEventFlag( 593 , 0 );--���d�����h�~�p�t���OOFF
	proxy:SetEventFlag( SYSTEM_ID_IGNORE,false);
	
	print("OnEvent_594_3 end");
end


--��594 2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
function OnEvent_594_GO_TO_IN(proxy, param)
	print("OnEvent_594_GO_TO_IN begin");
	
	--proxy:SetEventFlag( 593 , 0 );
	
	proxy:NotNetMessage_begin();
		--��593�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���--�n���h���� OnEvent_111
		proxy:OnPlayerActionInRegion( 593, 2894, "OnEvent_594", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 593, "StandBy_Sinpansya",0.5,0,0,once);	
	proxy:NotNetMessage_end();

	--proxy:SetEventFlag( 593 , 1 );
	
	print("OnEvent_594_GO_TO_IN end");
end


--��594 �t���O�Z�b�g(�����p)
function OnEvent_594_flag_set(proxy, param)
	print("OnEvent_594_flag_set begin");
		
	proxy:SetEventFlag( 594 , true );
	proxy:DeleteEvent( 594 );

	print("OnEvent_594_flag_set end");
end

--[[�C�x���g�폜���ꂽ�̂ŃR�����g�A�E�g
--------------------------------------------------------------------------------------
--�x(����ʂ�)��A��532
--------------------------------------------------------------------------------------
function OnEvent_532(proxy, param)
	print("OnEvent_532 begin");
	
	--�x���A�j���Đ�(�����J��)
	proxy:PlayAnimation( 1204, 1 );

	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_KICK ) == true then
		print("OnEvent_532 end");
		proxy:SetEventFlag( 532, true );
		return;
	end

	proxy:WarpDmy( 10000 , 1204 , 191 );
	proxy:SetEventFlag( 532, true );
	
	print("OnEvent_532 end");
end]]


--[[
--------------------------------------------------------------------------------------
--��̍U����636
--------------------------------------------------------------------------------------
--��636����̍U����
function Check_636(proxy,param)
	local region = { 2278 };
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
		proxy:SetInsideBattleArea(325,0);
	end
	
	return isIn;
end

--�̈�ɓ����Ă���
function OnEvent_636(proxy,param)
	proxy:SetInsideBattleArea(325,1);
end

--�邪����
function OnEvent_636_1(proxy,param)
	print("OnEvent_636_1 begin");
	proxy:DeleteEvent( 636 );
	print("OnEvent_636_1 end");
end
]]
--[[
--------------------------------------------------------------------------------------
--��̍U����637
--------------------------------------------------------------------------------------
--��637����̍U����
function Check_637(proxy,param)
	local region = { 2279 };
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
		proxy:SetInsideBattleArea(326,0);
	end
	
	return isIn;
end

--�̈�ɓ����Ă���
function OnEvent_637(proxy,param)
	proxy:SetInsideBattleArea(326,1);
end

--�邪����
function OnEvent_637_1(proxy,param)
	print("OnEvent_637_1 begin");
	proxy:DeleteEvent( 637 );
	print("OnEvent_637_1 end");
end
]]
--[[
--------------------------------------------------------------------------------------
--��̍U����638
--------------------------------------------------------------------------------------
--��638����̍U����
function Check_638(proxy,param)
	local region = { 2280 };
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
		proxy:SetInsideBattleArea(327,0);
	end
	
	return isIn;
end

--�̈�ɓ����Ă���
function OnEvent_638(proxy,param)
	proxy:SetInsideBattleArea(327,1);
end

--�邪����
function OnEvent_638_1(proxy,param)
	print("OnEvent_638_1 begin");
	proxy:DeleteEvent( 638 );
	print("OnEvent_638_1 end");
end
]]

--------------------------------------------------------------------------------------
--�{�XBGM��~��642
--------------------------------------------------------------------------------------
--��642���{�X�����񂾏u�ԁ�
function OnEvent_642(proxy,param)
	print("OnEvent_642 begin");	
	proxy:NotNetMessage_begin();
		--��4756��***�����ǉ�***1�b��ɔ����J����
		proxy:OnKeyTime2( 642, "OnEvent_642_1", 0, 0, 0, once );
	proxy:NotNetMessage_end();
	print("OnEvent_642 end");
end

--��642_1������ł���1�b�ち
function OnEvent_642_1(proxy,param)
	print("OnEvent_642_1 begin");
	proxy:StopPointSE( 1 );--�{�X��pBGM��~
	proxy:SetEventFlag( 642 ,true );
--	BlockClear(proxy,param);
	print("OnEvent_642_1 end");
end


--------------------------------------------------------------------------------------
--���{�X���S�Ŕ����J����4756
--------------------------------------------------------------------------------------
--��4756�����{�X���S�Ŕ����J����
function OnEvent_4756(proxy, param)
	print("OnEvent_4756 begin");
	
	proxy:NotNetMessage_begin();
		--��4756_1��***�����ǉ�***0�b��ɔ����J����
		proxy:OnKeyTime2( 4756, "OnEvent_4756_1", 0, 0, 0, once );
		--��4756_2��2�b�o�߁�
		proxy:OnKeyTime2( 4992, "OnEvent_4756_2", 0, 0, 1, once);
	proxy:NotNetMessage_end();
	
	proxy:CustomLuaCallStart( 4050 , 804 );--�u���b�N�N���A����
	--�g�J�Q���Z�b�g
	ResetTokage(proxy);
	
	--�}���`�v���C���ɂ������̃G���A�ɂ����Ă��܂������
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc( 4756 , "Check_4756_PT","OnEvent_4756_PT",0,once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 4756, true );--�{�X�̎��S�L�^�p
	proxy:SetEventFlag( 4800, true );--�V�d�l�̃t���O�����Ă�

	print("OnEvent_4756 end");
end

--��4756_1��0�b��ɔ����J����
function OnEvent_4756_1(proxy, param)
	print("OnEvent_4756_1 begin");	
	
	--�{�X��|���������X�V(���ɂ���ăt���O�𗧂Ă�)
	GetBossFlagCount( proxy, param );
--�A�C�e������֘A-------
	
	--�z�X�g�v���C���[�̂݃A�C�e������C�x���g�Ɏg�p
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

	--�󎀑�(�\�E��?)�L����
	proxy:SetDrawEnable( 1981 , true );
	proxy:SetColiEnable( 1981 , true );
	--�󎀑�(�\�E��?)2�L����
	proxy:SetDrawEnable( 1976 , true );
	proxy:SetColiEnable( 1976 , true );
	
	--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
	if proxy:IsCompleteEvent( 4804 ) == false then
		proxy:ValidSfx( 2287 );--���̗��q
		proxy:ValidSfx( 2286 );--SFX �L����
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--���点��
		proxy:OnDistanceActionAttribute( 4804 , 10000 , 1981 , "OnEvent_4804" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end
------------------------
	
	--���g���t�B�[�̎擾��
	Lua_RequestUnlockTrophy( proxy, 30 );
	
	--�ÍԎ��l�̏�ԑJ�ڃ`�F�b�N
	OnEvent_634(proxy,param)
	
	print("OnEvent_4756_1 end");
end

--��4756_2����������J��:���{�X���S��0�b��
function OnEvent_4756_2(proxy, param)
	print("OnEvent_4756_2 begin");
		
	--�{�X��p��BGM��~
	proxy:StopPointSE( 1 );	
	
	print("OnEvent_4756_2 end");
end

--PT��g��ł��邩�̃`�F�b�N
function Check_4756_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--PT���U���I������C�x���g
function OnEvent_4756_PT(proxy,param)
	print("OnEvent_4756_PT begin");
	
	proxy:PlayAnimation( 1206, 1 );	--���A�j���Đ�
	
	--���{�X�����̑O��̖��@�ǂ�������(�S�v���C���[)	
	proxy:SetColiEnable( 1998 , false );	
	proxy:SetDrawEnable( 1998 , false );
	--proxy:SetObjDeactivate( 1998 , true );--�f�A�N�e�B�u
	
	proxy:SetColiEnable( 1994 , false );	
	proxy:SetDrawEnable( 1994 , false );
	--proxy:SetObjDeactivate( 1994 , true );--�f�A�N�e�B�u
	
	--���{�X�������@�ǂ�SFX�폜
	proxy:InvalidSfx( 1990 , true );
	proxy:InvalidSfx( 1986 , true );
	
	--���{�X�����O�̈ړ������C�x���g���폜
	proxy:DeleteEvent( 594 );--��l�ڂ�����Ƃ��p
	proxy:DeleteEvent( 593 );--��l�ڈȍ~������Ƃ��p
	proxy:DeleteEvent( 641 );--�{�X�퓬�J�n�p	
	print("OnEvent_4756_PT end");
end


--------------------------------------------------------------------------------------
--��4805���Β��Ƀ��[�v��
--------------------------------------------------------------------------------------
function OnEvent_4805(proxy,param)	
	print("OnEvent_4805 begin");
	
	proxy:RepeatMessage_begin();
		--��70_1���I�����j���[�̊Ď���
		proxy:OnSelectMenu(4805, "OnEvent_4805_1", 10010710, 0, 2, 1981, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_4805 end");
end

--��4805_1���I�����j���[�̊Ď���
function OnEvent_4805_1(proxy,param)	
	print("OnEvent_4805_1 begin");
	
	if proxy:IsSession() == false then
		if param:IsNetMessage() == true then
			proxy:PlayAnimation(10001+param:GetPlayID(),8305);
			print("OnEvent_4805_1 end");
			return;
		end
			
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1981 ,TURNSKIP_ANGLE);
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd( 4805 , 10000 , 8283 , "OnEvent_4805_2",once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
			
		proxy:SetEventFlag(4805,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	print("OnEvent_4805_1 end");
end

--��4805_2���Β��Ƀ��[�v��
function OnEvent_4805_2(proxy,param)	
	print("OnEvent_4805_2 begin");	
	
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ�
	--�Β��֖߂��Ă�������̃t���O�𗧂Ă�
	proxy:SetEventFlag(8083, true);
	
	--�Íԗv�΂ɖ߂�
	--���S�񕜗v��
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1007);	
	print("OnEvent_4805_2 end");
end

--------------------------------------------------------------------------------------
--��4804���\�E�����聡
--------------------------------------------------------------------------------------
function OnEvent_4804(proxy, param)
	print("OnEvent_4804 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--�V�����A�j�� 
		print("OnEvent_4804 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 4804, "OnEvent_4804_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4804 end");
end


--��4804_1���A�C�e���擾��
function OnEvent_4804_1(proxy, param)
	print("OnEvent_4804_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10230�Q��
	proxy:GetRateItem(10230);	
	--�A�C�e���擾�֐�--�p�����[�^10270�Q��
	proxy:GetRateItem(10270);	
	--�A�C�e���擾�֐�--�p�����[�^10271�Q��
	proxy:GetRateItem(10271);	
	--�A�C�e���擾�֐�--�p�����[�^10272�Q��
	proxy:GetRateItem(10272);	
	--�A�C�e���擾�֐�--�p�����[�^10273�Q��
	proxy:GetRateItem(10273);	
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 4804, true	);
	--�󔠃V�F�[�_�[�͏����Ȃ�
	--proxy:TreasureDispModeChange( 1981 , false );

	--SFX��������
	proxy:InvalidSfx( 2286 , true );
	--proxy:InvalidSfx( 2287 , true );--���̗��q
		
	--���v�΂Ń��[�v�p�̊Ď���ǉ���
	proxy:OnDistanceActionAttribute( 4805 , 10000 , 1981 , "OnEvent_4805" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_4804_1 end");
end

--------------------------------------------------------------------------------------
--�͂���A�ち542
--------------------------------------------------------------------------------------
--��542���͂���A�ち
function OnEvent_542(proxy, param)
	print("OnEvent_542 begin");

	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_542 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,2,2);				--�z�o�[�ړ����[�h�Ɉڍs
	proxy:HoverMoveValDmy(10000,1330,192,LadderTime_A);--�ړ��ʒu(192)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,1);				--�C�x���g�R�}���hID(1)"�n�V�S�ォ���"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(542,"OnEvent_542_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���)
		proxy:OnKeyTime2(542,"LadderDown",3.0,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_542 end");
end

function OnEvent_542_1(proxy, param)
	print("OnEvent_542_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_542_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,7,6);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_542_1 end");
end


--------------------------------------------------------------------------------------
--�͂���A����543
--------------------------------------------------------------------------------------
--��543���͂���A����
function OnEvent_543(proxy, param)
	print("OnEvent_543 begin");

	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_543 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,-1,1);			--�z�o�[�ړ����[�h�Ɉڍs
	proxy:HoverMoveValDmy(10000,1330,191,LadderTime_A);--�ړ��ʒu(191)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,0);				--�C�x���g�R�}���hID(0)"�n�V�S�������"�ނ𑗂�
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(543,"OnEvent_543_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���)
		proxy:OnKeyTime2(543,"LadderDown",3.0,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_543 end");
end

function OnEvent_543_1(proxy, param)
	print("OnEvent_543_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_543_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,-1,6);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_543_1 end");
end


--------------------------------------------------------------------------------------
--�{�X�������o��(�퓬�J�n)��641
--------------------------------------------------------------------------------------
--��641��PC���퓬�̈�ɓ�������
function OnEvent_641(proxy, param)
	print("OnEvent_641 begin");	
	--�{�X��pBGM�Đ��J�n
	proxy:PlayPointSE( 2000, SOUND_TYPE_M, 30100000, 1 );	
	--�{�X���W�b�NON
	proxy:EnableLogic( 804 , true );	
	--�ǂݍ��݃^�C�~���O�̂Ƃ�����ǉ�����Ăق����̂Ńt���O���ĂȂ�
	
	--�R���҃C�x���g�X�^�[�g
	BossEventStart_Sinpansya(proxy,param);
	
	proxy:OnKeyTime2( 595, "OnEvent_595", 1.5, 0, 0, once );
	
	--�{�X�Q�[�W�\��
	proxy:SetBossGauge( 804 , 0 ,5040 );
	
	print("OnEvent_641 end");
end

---------------------
--�{�X�o�ꉉ�o��595
---------------------
--��595���{�X�o�ꉉ�o��
function OnEvent_595(proxy, param)
	print("OnEvent_595 begin");

	proxy:PlayAnimation( 804, 7100 );
	
	proxy:SetEventFlag( 595, true );

	print("OnEvent_595 end");
end


--------------------------------------------------------------------------------------
--�Β��Ƀ��[�v��583
--------------------------------------------------------------------------------------

--��583���Β��Ƀ��[�v��
function OnEvent_583(proxy,param)	

	if proxy:IsCompleteEvent( 583 ) == true then
		return;
	end
	
	if param:IsNetMessage() == true then
		return;
	end
	
	
	print("OnEvent_583 begin");
	
	--�Z�b�V�������ł͂Ȃ����H
	if proxy:IsSession() == false then
		proxy:RepeatMessage_begin();
			--��583_1���I�����j���[�̊Ď���
			proxy:OnSelectMenu(583, "OnEvent_583_0", 10010710, 0, 2, 1983, 2, once);			
		proxy:RepeatMessage_end();
	else
		--�Z�b�V�������Ȃ�ŕ\��
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010720, 1);
		--proxy:ShowGenDialog(10010720,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end

	print("OnEvent_583 end");
end

--��583_0���I�����j���[�̊Ď���
function OnEvent_583_0(proxy, param)
	print("OnEvent_583_0 begin");
	if proxy:IsSession() == false then
		proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ�
		proxy:NoAnimeTurnCharactor( 10000 , 1983 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--���v�΂ɐG���A�j���Đ��I����
			proxy:OnChrAnimEnd( 583 , 10000 , 8283 , "OnEvent_583_1" , once );
		proxy:NotNetMessage_end();

		proxy:SetEventFlag( 583 , true );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	print("OnEvent_583_0 end");
end

--��583_1���I�����j���[�̊Ď���
function OnEvent_583_1(proxy, param)
	print("OnEvent_583_1 begin");
	
	proxy:SetEventFlag( 583 , 0 );
	
	proxy:PlayAnimation( 10000 , 8284 );--�v�΂ɐG���A�j�����Đ�
	
	--[[
	proxy:NotNetMessage_begin();
		--���v�΂ɐG���A�j���Đ��I����
		proxy:OnChrAnimEnd( 583 , 10000 , 8284 , "OnEvent_583_2" , once );
	proxy:NotNetMessage_end();
	]]
	OnEvent_583_2(proxy,param);
	--proxy:SetEventFlag( 583 , true );
	
	print("OnEvent_583_1 end");
end

--���v�΂ɐG���A�j���Đ��I����
function OnEvent_583_2(proxy,param)	
	print("OnEvent_583_2 begin");
	
	--�Β��֖߂��Ă�������̃t���O�𗧂Ă�
	proxy:SetEventFlag(8083, true);

	proxy:SetEventFlag( 583 , 0 );
	--���S�񕜗v��
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1007 );
	
	print("OnEvent_583_2 end");
end


--------------------------------------------------------------------------------------
--�S�̔���639
--------------------------------------------------------------------------------------
--��639���S�̔���
function OnEvent_639(proxy,param)
	--�K�v�A�C�e���̎w��
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 9;--���S�̌�
	
	--�K�v�A�C�e�����������Ă���(�C���x���g���[�ɃA�C�e���Ƃ��ď������Ă���)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010803, 0, 6, 1331, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_639_1(proxy,param);

	--�K�v�A�C�e�����������Ă��Ȃ�
	else
		--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\��
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1331, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end
end

--�I�����j���[��YES��I��
function OnEvent_639_1(proxy,param)
	print("OnEvent_639_1 begin");
	--�C�x���g������z�M����ׁALuaCall�����܂���
	proxy:LuaCallStart( 639, 1 );
	print("OnEvent_639_1 end");
end

--���ʂ�z�M
function OnEvent_639_2(proxy,param)
	print("OnEvent_639_2 begin");
	proxy:PlayAnimation( 1331, 1 );--�����J���A�j���[�V����
	
	proxy:SetEventFlag( 639, true );	
	proxy:DeleteEvent( 639 );	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		return;
	end
	proxy:WarpDmy( 10000 , 1331 , 191 );
	print("OnEvent_639_2 end");
end


--------------------------------------------------------------------------------------
--���{�X�����@���j��4766
--------------------------------------------------------------------------------------
--��4766�����{�X�����@���j��
function OnEvent_4766(proxy, param)
	print("OnEvent_4766 begin");
	
	--�����Ƀ_���[�W�𔭐�������ƃv���C���[�ɓ�����ׁA�҂����Ԃ������
	--��4766_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4766, "OnEvent_4766_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4766 end");
end

--��4766_1���P�b�っ
function OnEvent_4766_1(proxy, param)
	print("OnEvent_4766_1 begin");
	
	------------------------�p�����[�^����--------------------------------
	--	�A�N�V����ID(4766),�^�[�Q�b�gOBJ(1208),�^�[�Q�b�g�̃_�~�|��ID(1)
	--	�_���[�W��(50),�_���[�W�������蔼�a(2.0),�_���[�W���L������(5.0�b)
	--	�_���[�W���̏Փˎ���(OnEvent_4766_2)���s
	----------------------------------------------------------------------
	--��4766_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4766, 1208, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4766_2", once );
	proxy:NotNetMessage_end();
	
	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4766, true );
	
	print("OnEvent_4766_1 end");
end

--��4766_2���_���[�W��������������
function OnEvent_4766_2(proxy, param)
	print("OnEvent_4766_2 begin");
	
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	--�_�~�|�����g���̂Ń��f�������ւ��Ȃǂ̃^�C�~���O�ɒ���!!
	--�����ւ�����̃��f���Ɏw��ID�̃_�~�|���������ꍇ�ۏ�ł��܂���B)	
	SecondStageBreak(proxy,1208,2);	
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1208,1,93100);
	
	print("OnEvent_4766_2 end");
end

--------------------------------------------------------------------------------------
--���{�X�����@���j��4767
--------------------------------------------------------------------------------------
--��4767�����{�X�����@���j��
function OnEvent_4767(proxy, param)
	print("OnEvent_4767 begin");
	
	--��4767_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4767, "OnEvent_4767_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4767 end");
end

--��4767_1���P�b�っ
function OnEvent_4767_1(proxy, param)
	print("OnEvent_4767_1 begin");
	
	--��4767_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4767, 1209, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4767_2", once );
	proxy:NotNetMessage_end();
	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4767, true );
	
	print("OnEvent_4767_1 end");
end

--��4767_2���_���[�W��������������
function OnEvent_4767_2(proxy, param)
	print("OnEvent_4767_2 begin");
	
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	SecondStageBreak(proxy,1209,2);	
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1209,1,93100);
	
	print("OnEvent_4767_2 end");
end

--------------------------------------------------------------------------------------
--���{�X�����@���j��4768
--------------------------------------------------------------------------------------
--��4768�����{�X�����@���j��
function OnEvent_4768(proxy, param)
	print("OnEvent_4768 begin");
	
	--��4768_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4768, "OnEvent_4768_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4768 end");
end

--��4768_1���P�b�っ
function OnEvent_4768_1(proxy, param)
	print("OnEvent_4768_1 begin");
	
	--��4768_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4768, 1210, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4768_2", once );
	proxy:NotNetMessage_end();

	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4768, true );
	
	print("OnEvent_4768_1 end");
end

--��4768_2���_���[�W��������������
function OnEvent_4768_2(proxy, param)
	print("OnEvent_4768_2 begin");
	
	SecondStageBreak(proxy,1210,2);	
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1210,1,93100);
	
	print("OnEvent_4768_2 end");
end

--------------------------------------------------------------------------------------
--���{�X�����@���j��4769
--------------------------------------------------------------------------------------
--��4769�����{�X�����@���j��
function OnEvent_4769(proxy, param)
	print("OnEvent_4769 begin");
	
	--��4769_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4769, "OnEvent_4769_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	print("OnEvent_4769 end");
end

--��4769_1���P�b�っ
function OnEvent_4769_1(proxy, param)
	print("OnEvent_4769_1 begin");
	
	--��4769_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4769, 1211, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4769_2", once );
	proxy:NotNetMessage_end();

	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4769, true );
	
	print("OnEvent_4769_1 end");
end

--��4769_2���_���[�W��������������
function OnEvent_4769_2(proxy, param)
	print("OnEvent_4769_2 begin");
	
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	SecondStageBreak(proxy,1211,2);
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1211,1,93100);	
	
	print("OnEvent_4769_2 end");
end

--------------------------------------------------------------------------------------
--���{�X�����@���j��4770
--------------------------------------------------------------------------------------
--��4770�����{�X�����@���j��
function OnEvent_4770(proxy, param)
	print("OnEvent_4770 begin");
	
	--��4770_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4770, "OnEvent_4770_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4770 end");
end

--��4770_1���P�b�っ
function OnEvent_4770_1(proxy, param)
	print("OnEvent_4770_1 begin");
	
	--��4770_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4770, 1212, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4770_2", once );
	proxy:NotNetMessage_end();

	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4770, true );
	
	print("OnEvent_4770_1 end");
end

--��4770_2���_���[�W��������������
function OnEvent_4770_2(proxy, param)
	print("OnEvent_4770_2 begin");
	
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	SecondStageBreak(proxy,1212,2);	
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1212,1,93100);
	
	print("OnEvent_4770_2 end");
end

--------------------------------------------------------------------------------------
--���{�X�����@���j��4771
--------------------------------------------------------------------------------------
--��4771�����{�X�����@���j��
function OnEvent_4771(proxy, param)
	print("OnEvent_4771 begin");
	
	--��4771_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4771, "OnEvent_4771_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4771 end");
end

--��4771_1���P�b�っ
function OnEvent_4771_1(proxy, param)
	print("OnEvent_4771_1 begin");
	
	--��4771_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4771, 1213, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4771_2", once );
	proxy:NotNetMessage_end();

	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4771, true );
	
	print("OnEvent_4771_1 end");
end

--��4771_2���_���[�W��������������
function OnEvent_4771_2(proxy, param)
	print("OnEvent_4771_2 begin");
	
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	SecondStageBreak(proxy,1213,2);	
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1213,1,93100);
	
	print("OnEvent_4771_2 end");
end

--------------------------------------------------------------------------------------
--���{�X�����@���j��4772
--------------------------------------------------------------------------------------
--��4772�����{�X�����@���j��
function OnEvent_4772(proxy, param)
	print("OnEvent_4772 begin");
	
	--��4772_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4772, "OnEvent_4772_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4772 end");
end

--��4772_1���P�b�っ
function OnEvent_4772_1(proxy, param)
	print("OnEvent_4772_1 begin");
	
	--��4772_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4772, 1214, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4772_2", once );
	proxy:NotNetMessage_end();
	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4772, true );
	
	print("OnEvent_4772_1 end");
end

--��4772_2���_���[�W��������������
function OnEvent_4772_2(proxy, param)
	print("OnEvent_4772_2 begin");
	
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	SecondStageBreak(proxy,1214,2);	
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1214,1,93100);
	
	print("OnEvent_4772_2 end");
end

--------------------------------------------------------------------------------------
--���{�X�����@���j��4773
--------------------------------------------------------------------------------------
--��4773�����{�X�����@���j��
function OnEvent_4773(proxy, param)
	print("OnEvent_4773 begin");
	
	--��4773_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4773, "OnEvent_4773_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4773 end");
end

--��4773_1���P�b�っ
function OnEvent_4773_1(proxy, param)
	print("OnEvent_4773_1 begin");
	
	--��4773_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4773, 1215, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4773_2", once );
	proxy:NotNetMessage_end();

	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4773, true );
	
	print("OnEvent_4773_1 end");
end

--��4773_2���_���[�W��������������
function OnEvent_4773_2(proxy, param)
	print("OnEvent_4773_2 begin");
	
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	SecondStageBreak(proxy,1215,2);	
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1215,1,93100);
	
	print("OnEvent_4773_2 end");
end

--------------------------------------------------------------------------------------
--���{�X�����@���j��4774
--------------------------------------------------------------------------------------
--��4774�����{�X�����@���j��
function OnEvent_4774(proxy, param)
	print("OnEvent_4774 begin");
	
	--��4774_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4774, "OnEvent_4774_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4774 end");
end

--��4774_1���P�b�っ
function OnEvent_4774_1(proxy, param)
	print("OnEvent_4774_1 begin");
	
	--��4774_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4774, 1216, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4774_2", once );
	proxy:NotNetMessage_end();

	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4774, true );
	
	print("OnEvent_4774_1 end");
end

--��4774_2���_���[�W��������������
function OnEvent_4774_2(proxy, param)
	print("OnEvent_4774_2 begin");
	
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	SecondStageBreak(proxy,1216,2);	
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1216,1,93100);
	
	print("OnEvent_4774_2 end");
end



--------------------------------------------------------------------------------------
--���{�X�����@���j��4775
--------------------------------------------------------------------------------------
--��4775�����{�X�����@���j��
function OnEvent_4775(proxy, param)
	print("OnEvent_4775 begin");
	
	--��4775_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4775, "OnEvent_4775_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4775 end");
end

--��4775_1���P�b�っ
function OnEvent_4775_1(proxy, param)
	print("OnEvent_4775_1 begin");
	
	--��4775_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4775, 1217, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4775_2", once );
	proxy:NotNetMessage_end();

	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4775, true);
	
	print("OnEvent_4775_1 end");
end

--��4775_2���_���[�W��������������
function OnEvent_4775_2(proxy, param)
	print("OnEvent_4775_2 begin");
	
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	SecondStageBreak(proxy,1217,2);	
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1217,1,93100);
	
	print("OnEvent_4775_2 end");
end

--------------------------------------------------------------------------------------
--���{�X�����@���j��4776
--------------------------------------------------------------------------------------
--��4776�����{�X�����@���j��
function OnEvent_4776(proxy, param)
	print("OnEvent_4776 begin");
	
	--��4776_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4776, "OnEvent_4776_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4776 end");
end

--��4776_1���P�b�っ
function OnEvent_4776_1(proxy, param)
	print("OnEvent_4776_1 begin");
	
	--��4776_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4776, 1218, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4776_2", once );
	proxy:NotNetMessage_end();

	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4776, true );
	
	print("OnEvent_4776_1 end");
end

--��4776_2���_���[�W��������������
function OnEvent_4776_2(proxy, param)
	print("OnEvent_4776_2 begin");
	
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	SecondStageBreak(proxy,1218,2);	
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1218,1,93100);

	print("OnEvent_4776_2 end");
end

--------------------------------------------------------------------------------------
--���{�X�����@���j��4777
--------------------------------------------------------------------------------------
--��4777�����{�X�����@���j��
function OnEvent_4777(proxy, param)
	print("OnEvent_4777 begin");
	
	--��4777_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4777, "OnEvent_4777_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4777 end");
end

--��4777_1���P�b�っ
function OnEvent_4777_1(proxy, param)
	print("OnEvent_4777_1 begin");
	
	--��4777_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4777, 1219, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4777_2", once );
	proxy:NotNetMessage_end();

	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4777, true );
	
	print("OnEvent_4777_1 end");
end

--��4777_2���_���[�W��������������
function OnEvent_4777_2(proxy, param)
	print("OnEvent_4777_2 begin");
	
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	SecondStageBreak(proxy,1219,2);	
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1219,1,93100);
	
	print("OnEvent_4777_2 end");
end

--------------------------------------------------------------------------------------
--���{�X�����@���j��4778
--------------------------------------------------------------------------------------
--��4778�����{�X�����@���j��
function OnEvent_4778(proxy, param)
	print("OnEvent_4778 begin");
	
	--��4778_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4778, "OnEvent_4778_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4778 end");
end

--��4778_1���P�b�っ
function OnEvent_4778_1(proxy, param)
	print("OnEvent_4778_1 begin");
	
	--��4778_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4778, 1220, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4778_2", once );
	proxy:NotNetMessage_end();

	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4778, true);
	
	print("OnEvent_4778_1 end");
end

--��4778_2���_���[�W��������������
function OnEvent_4778_2(proxy, param)
	print("OnEvent_4778_2 begin");
	
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	SecondStageBreak(proxy,1220,2);	
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1220,1,93100);
	
	print("OnEvent_4778_2 end");
end

--------------------------------------------------------------------------------------
--���{�X�����@���j��4779
--------------------------------------------------------------------------------------
--��4779�����{�X�����@���j��
function OnEvent_4779(proxy, param)
	print("OnEvent_4779 begin");
	
	--��4779_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4779, "OnEvent_4779_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4779 end");
end

--��4779_1���P�b�っ
function OnEvent_4779_1(proxy, param)
	print("OnEvent_4779_1 begin");
	
	--��4779_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4779, 1221, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4779_2", once );
	proxy:NotNetMessage_end();

	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4779, true );
	
	print("OnEvent_4779_1 end");
end

--��4779_2���_���[�W��������������
function OnEvent_4779_2(proxy, param)
	print("OnEvent_4779_2 begin");
	
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	SecondStageBreak(proxy,1221,2);	
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1221,1,93100);
	
	print("OnEvent_4779_2 end");
end

--------------------------------------------------------------------------------------
--���{�X�����@���j��4780
--------------------------------------------------------------------------------------
--��4780�����{�X�����@���j��
function OnEvent_4780(proxy, param)
	print("OnEvent_4780 begin");
	
	--��4780_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4780, "OnEvent_4780_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4780 end");
end

--��4780_1���P�b�っ
function OnEvent_4780_1(proxy, param)
	print("OnEvent_4780_1 begin");
	
	--��4780_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4780, 1222, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4780_2", once );
	proxy:NotNetMessage_end();

	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4780, true );
	
	print("OnEvent_4780_1 end");
end

--��4780_2���_���[�W��������������
function OnEvent_4780_2(proxy, param)
	print("OnEvent_4780_2 begin");
	
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	SecondStageBreak(proxy,1222,2);	
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1222,1,93100);
	
	print("OnEvent_4780_2 end");
end

--------------------------------------------------------------------------------------
--���{�X�����@���j��4781
--------------------------------------------------------------------------------------
--��4781�����{�X�����@���j��
function OnEvent_4781(proxy, param)
	print("OnEvent_4781 begin");
	
	--��4781_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4781, "OnEvent_4781_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4781 end");
end

--��4781_1���P�b�っ
function OnEvent_4781_1(proxy, param)
	print("OnEvent_4781_1 begin");
	
	--��4781_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4781, 1223, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4781_2", once );
	proxy:NotNetMessage_end();

	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4781, true );
	
	print("OnEvent_4781_1 end");
end

--��4781_2���_���[�W��������������
function OnEvent_4781_2(proxy, param)
	print("OnEvent_4781_2 begin");
	
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	SecondStageBreak(proxy,1223,2);	
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1223,1,93100);
	
	print("OnEvent_4781_2 end");
end

--------------------------------------------------------------------------------------
--���{�X�����@���j��4782
--------------------------------------------------------------------------------------
--��4782�����{�X�����@���j��
function OnEvent_4782(proxy, param)
	print("OnEvent_4782 begin");
	
	--��4782_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4782, "OnEvent_4782_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4782 end");
end

--��4782_1���P�b�っ
function OnEvent_4782_1(proxy, param)
	print("OnEvent_4782_1 begin");
	
	--��4782_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4782, 1224, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4782_2", once );
	proxy:NotNetMessage_end();

	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4782, true );
	
	print("OnEvent_4782_1 end");
end

--��4782_2���_���[�W��������������
function OnEvent_4782_2(proxy, param)
	print("OnEvent_4782_2 begin");
	
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	SecondStageBreak(proxy,1224,2);	
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1224,1,93100);
	
	print("OnEvent_4782_2 end");
end

--------------------------------------------------------------------------------------
--���{�X�����@���j��4783
--------------------------------------------------------------------------------------
--��4783�����{�X�����@���j��
function OnEvent_4783(proxy, param)
	print("OnEvent_4783 begin");
	
	--��4783_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4783, "OnEvent_4783_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4783 end");
end

--��4783_1���P�b�っ
function OnEvent_4783_1(proxy, param)
	print("OnEvent_4783_1 begin");
	
	--��4783_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4783, 1225, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4783_2", once );
	proxy:NotNetMessage_end();

	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4783, true );
	
	print("OnEvent_4783_1 end");
end

--��4783_2���_���[�W��������������
function OnEvent_4783_2(proxy, param)
	print("OnEvent_4783_2 begin");
	
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	SecondStageBreak(proxy,1225,2);	
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1225,1,93100);
	
	print("OnEvent_4783_2 end");
end

--------------------------------------------------------------------------------------
--���{�X�����@���j��4784
--------------------------------------------------------------------------------------
--��4784�����{�X�����@���j��
function OnEvent_4784(proxy, param)
	print("OnEvent_4784 begin");
	
	--��4784_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4784, "OnEvent_4784_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4784 end");
end

--��4784_1���P�b�っ
function OnEvent_4784_1(proxy, param)
	print("OnEvent_4784_1 begin");
	
	--��4784_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();	
		proxy:OnObjectDamageHit( 4784, 1226, 1, 10030,EV_HIT_ALL, 2.0, 5.0, "OnEvent_4784_2", once );
	proxy:NotNetMessage_end();

	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4784, true );
	
	print("OnEvent_4784_1 end");
end

--��4784_2���_���[�W��������������
function OnEvent_4784_2(proxy, param)
	print("OnEvent_4784_2 begin");
	
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	SecondStageBreak(proxy,1226,2);	
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1226,1,93100);
	
	print("OnEvent_4784_2 end");
end

--------------------------------------------------------------------------------------
--���{�X�����@���j��4785
--------------------------------------------------------------------------------------
--��4785�����{�X�����@���j��
function OnEvent_4785(proxy, param)
	print("OnEvent_4785 begin");
	
	--��4785_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4785, "OnEvent_4785_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4785 end");
end

--��4785_1���P�b�っ
function OnEvent_4785_1(proxy, param)
	print("OnEvent_4785_1 begin");
	
	--��4785_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4785, 1227, 1, 10030,EV_HIT_ALL, 2.0, 5.0, "OnEvent_4785_2", once );
	proxy:NotNetMessage_end();

	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4785, true );
	
	print("OnEvent_4785_1 end");
end

--��4785_2���_���[�W��������������
function OnEvent_4785_2(proxy, param)
	print("OnEvent_4785_2 begin");
	
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	SecondStageBreak(proxy,1227,2);	
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1227,1,93100);
	
	print("OnEvent_4785_2 end");
end

--------------------------------------------------------------------------------------
--���{�X�����@���j��4786
--------------------------------------------------------------------------------------
--��4786�����{�X�����@���j��
function OnEvent_4786(proxy, param)
	print("OnEvent_4786 begin");
	
	--��4786_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4786, "OnEvent_4786_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4786 end");
end

--��4786_1���P�b�っ
function OnEvent_4786_1(proxy, param)
	print("OnEvent_4786_1 begin");
	
	--��4786_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4786, 1228, 1, 10030,EV_HIT_ALL, 2.0, 5.0, "OnEvent_4786_2", once );
	proxy:NotNetMessage_end();

	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4786, true );
	
	print("OnEvent_4786_1 end");
end

--��4786_2���_���[�W��������������
function OnEvent_4786_2(proxy, param)
	print("OnEvent_4786_2 begin");
	
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	SecondStageBreak(proxy,1228,2);	
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1228,1,93100);
	
	print("OnEvent_4786_2 end");
end

--------------------------------------------------------------------------------------
--���{�X�����@���j��4787
--------------------------------------------------------------------------------------
--��4787�����{�X�����@���j��
function OnEvent_4787(proxy, param)
	print("OnEvent_4787 begin");
	
	--��4787_1��***�����ǉ�***--�P�b�づ
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4787, "OnEvent_4787_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4787 end");
end

--��4787_1���P�b�っ
function OnEvent_4787_1(proxy, param)
	print("OnEvent_4787_1 begin");
	
	--��4786_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4787, 1229, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4787_2", once );
	proxy:NotNetMessage_end();

	-- �t���O���Z�b�g
	proxy:SetEventFlag( 4787, true );
	
	print("OnEvent_4787_1 end");
end

--��4787_2���_���[�W��������������
function OnEvent_4787_2(proxy, param)
	print("OnEvent_4787_2 begin");
	
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	SecondStageBreak(proxy,1229,2);	
	--�j���SFX����
	proxy:CreateSfx_DummyPoly(1229,1,93100);
	
	print("OnEvent_4787_2 end");
end


--[[
--------------------------------------------------------------------------------------
--�[���N���オ�聡651
--------------------------------------------------------------------------------------
function OnEvent_651(proxy,param)
	print("OnEvent_651 begin");
	proxy:StopLoopAnimation(328);
	proxy:PlayAnimation(328,7001);
	proxy:SetColiEnable(328,true);
	proxy:SetEventFlag(651,true);
	print("OnEvent_651 end");
end


--------------------------------------------------------------------------------------
--�[���N���オ�聡652
--------------------------------------------------------------------------------------
function OnEvent_652(proxy,param)
	print("OnEvent_652 begin");
	for eneid = 329, 334, 1 do
		proxy:StopLoopAnimation(eneid);
		proxy:PlayAnimation(eneid,7001);
		proxy:SetColiEnable(eneid,true);
	end		
	proxy:SetEventFlag(652,true);
	print("OnEvent_652 end");
end


--------------------------------------------------------------------------------------
--�[���N���オ�聡653
--------------------------------------------------------------------------------------
function OnEvent_653(proxy,param)
	print("OnEvent_653 begin");
	for eneid = 336, 339, 1 do
		proxy:StopLoopAnimation(eneid);
		proxy:PlayAnimation(eneid,7001);
		proxy:SetColiEnable(eneid,true);
	end		
	proxy:SetEventFlag(653,true);
	print("OnEvent_653 end");
end]]


--------------------------------------------------------------------------------------
--�V�̐���654
--------------------------------------------------------------------------------------
function OnEvent_654(proxy,param)
	print("OnEvent_654 begin");
	--�A�C�e���C�x���g�҂�����Ȃ�������
	if proxy:IsCompleteEvent( 12614 ) == false then		
		if proxy:IsCompleteEvent( 12613 ) == false then
			--�A�C�e��������]��b
			proxy:CloseMenu();
			proxy:TalkNextPage(654);
		end
	end
	
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			--proxy:OnPlayerActionInRegion(656,2285,"OnEvent_656",0,once);
			proxy:OnRegionJustOut(657,10000,2285,"OnEvent_657",once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	
	print("OnEvent_654 end");
end

--���y�[�W�ɑ���Ə�����H
function OnEvent_656(proxy,param)
	print("OnEvent_656 begin");	
	--proxy:CloseMenu();
	--proxy:TalkNextPage(654);	
	print("OnEvent_656 end");
end

--�G���A����o��Ə�����?
function OnEvent_657(proxy,param)
	print("OnEvent_657 begin");
	--�A�C�e��������]�p�̉�b
	proxy:CloseTalk(654);
	proxy:SetValidTalk(654,true);
	--�A�C�e���X�Ɋ�]�̉�b
	proxy:CloseTalk(655);
	proxy:SetValidTalk(655,true);
	--��]�A�C�e���ƈႤ��b
	proxy:CloseTalk(662);
	proxy:SetValidTalk(662,true);
	
	proxy:DeleteEvent(656);	
	
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnRegionIn(654,10000,2284,"OnEvent_654",once);				
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	print("OnEvent_657 end");
end




--------------------------------------------------------------------------------------
--�A�C�e���h���b�v�̊Ď���12613
--------------------------------------------------------------------------------------
--�A�C�e�����̂Ă�
function OnEvent_12613(proxy,param)
	--print("OnEvent_12613 begin");
	
	if proxy:IsCompleteEvent(12614) == false and proxy:IsCompleteEvent(12613) == false then				
		local num = table.getn(itemevent_typelist);
		local idx = 0;
		local isDrop = false;
		
		--�����̂Ă����ڍ׊֌W��������
		if proxy:IsDropCheck_Only( 10000 , -1 , -1 , 2284 ) == true then
			for idx=1 ,num , 1 do
				if CheckItemDrop(proxy,param,idx) == true then
				--if proxy:IsRegionDrop(12613,10000, itemevent_typelist[idx], itemevent_idlist[idx] ,2284) == true then
					print("Drop!!");
					--proxy:SetEventFlag(12613,true);					
					--�Y���A�C�e�����������̂łƂ肠���������ŏI��
					return;
				end
			end
			
			--�����̂Ă����Ǐ�̌��ɖ����E�E�E�Y���A�C�e���ȊO���̂Ă��I
			--�s�K�v�Ȃ��̂��̂Ă���b
			proxy:CloseMenu();--���j���[���܂��B
			proxy:SetValidTalk(662,true);
			proxy:TalkNextPage(662)
		end
		
	--[[else
		print("Event Complete!");
		proxy:SetEventFlag(12000,false);
		proxy:DeleteEvent(57);
		]]
	end	
	--print("OnEvent_12613 end");
end

--[[
function OnEvent_12613_1(proxy,param)
	print("OnEvent_12613_1 begin");
	print("PickUpItem");
	proxy:SetEventFlag(12613,false);
	print("OnEvent_12613_1 end");
end]]


function OnEvent_12621_1(proxy,param) PickUpItem(proxy,param,12621) end
function OnEvent_12622_1(proxy,param) PickUpItem(proxy,param,12622) end
function OnEvent_12623_1(proxy,param) PickUpItem(proxy,param,12623) end
function OnEvent_12624_1(proxy,param) PickUpItem(proxy,param,12624) end
function OnEvent_12625_1(proxy,param) PickUpItem(proxy,param,12625) end
function OnEvent_12626_1(proxy,param) PickUpItem(proxy,param,12626) end
function OnEvent_12627_1(proxy,param) PickUpItem(proxy,param,12627) end
function OnEvent_12628_1(proxy,param) PickUpItem(proxy,param,12628) end
function OnEvent_12629_1(proxy,param) PickUpItem(proxy,param,12629) end
function OnEvent_12630_1(proxy,param) PickUpItem(proxy,param,12630) end
function OnEvent_12631_1(proxy,param) PickUpItem(proxy,param,12631) end
function OnEvent_12632_1(proxy,param) PickUpItem(proxy,param,12632) end
function OnEvent_12633_1(proxy,param) PickUpItem(proxy,param,12633) end
function OnEvent_12634_1(proxy,param) PickUpItem(proxy,param,12634) end
function OnEvent_12635_1(proxy,param) PickUpItem(proxy,param,12635) end
function OnEvent_12636_1(proxy,param) PickUpItem(proxy,param,12636) end
function OnEvent_12637_1(proxy,param) PickUpItem(proxy,param,12637) end
function OnEvent_12638_1(proxy,param) PickUpItem(proxy,param,12638) end
function OnEvent_12639_1(proxy,param) PickUpItem(proxy,param,12639) end


--�Y���A�C�e�����E����
function PickUpItem(proxy,param,id)
	print("OnEvent_",id,"_1 begin");
	print("PickUpItem");
	proxy:SetEventFlag(12613,false);
	proxy:SetEventFlag(id,false);
	print("OnEvent_",id,"_1 end");
end

--------------------------------------------------------------------------------------
--�A�C�e���擾�̊Ď���658
--------------------------------------------------------------------------------------
function OnEvent_658(proxy,param)
	print("OnEvent_658 begin");
	
	local idx = 0;
	local num = table.getn( itemevent_endidlist );
	local count = 0;
	for idx = 1, num, 1 do
		ItemChangeCheck(proxy,param,idx);
		if proxy:IsCompleteEvent( itemevent_endidlist[idx] ) == true then
			count = count+1;
		end
	end
	
	print("count = ",count," num = ",num);
	if count == num then
		--���ׂĎ�����I
		proxy:SetEventFlag( 659,true );
	end		
		
	proxy:TreasureDispModeChange2(1335,false,ITEM_SFX);
	proxy:SetDrawEnable( 1335,false);
	
	proxy:LuaCallStart(4010,1);--�A�C�e���擾����
	
	--�A�C�e���C�x���g�t���OOFF
	proxy:SetEventFlag(12613,false);
	proxy:SetEventFlag(12614,false);
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc( 655 ,"Check_655","OnEvent_655",1,once);
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_658 end");
end

--���j���[�\���̔���
function Check_655(proxy,param)

	ITEM_SHOWMENU = proxy:IsShowMenu();
	
	if ITEM_SHOWMENU == false and PREV_ITEM_SHOWMENU == true then
		return true;
	end
	PREV_ITEM_SHOWMENU = ITEM_SHOWMENU;
	return false;
end

--������b
function OnEvent_655(proxy,param)
	print("OnEvent_655 begin");
	if proxy:IsCompleteEvent( 659 ) == false then
		proxy:CloseMenu();
		proxy:SetValidTalk(655,true);
		proxy:TalkNextPage(655);
	else
		proxy:CloseMenu();
		proxy:SetValidTalk(659,true);
		proxy:TalkNextPage(659);
		--[[
		�֘A�C�x���g�f���[�g
		654
658
12613
		]]
		proxy:DeleteEvent( 654 );
		proxy:DeleteEvent( 657 );
		proxy:DeleteEvent( 658 );
		proxy:DeleteEvent( 12613 );
	end	
	print("OnEvent_655 end");
end




--[[
��̖��̌����C�x���g
�A�C�e���̂Ă��H

]]

function CheckItemDrop(proxy,param,setNo)	
	--itemevent_typelist		=	{TYPE_WEAPON,TYPE_WEAPON,TYPE_WEAPON,TYPE_GOODS	,	};
	--itemevent_idlist		=	{10000		,10100		,10200		,1017		,	};	
	--itemevent_eventidlist	=	{12621		,12622		,12623		,12624		,	};
	--itemevent_endidlist		=	{12631		,12632		,12633		,12634		,	};
	if proxy:IsDropCheck_Only(10000,itemevent_typelist[setNo],itemevent_idlist[setNo],2284) == true then
		--�܂��������I����Ă��Ȃ�
		if proxy:IsCompleteEvent(itemevent_endidlist[setNo]) == false then
			if proxy:IsRegionDrop( itemevent_eventidlist[setNo] , 10000,itemevent_typelist[setNo],itemevent_idlist[setNo],2284) == true then			
				proxy:CloseMenu();--���j���[���܂��B
				proxy:SetValidTalk( 12613 ,true);
				proxy:TalkNextPage( 12613 );
				proxy:SetEventFlag( itemevent_eventidlist[setNo],true);
				proxy:SetEventFlag( 12613 , true);
			end
			--�Y���A�C�e�����̂Ă��t���O��ON
			return true;
		else
			proxy:CloseMenu();--���j���[���܂��B
			--�����������I����Ă���
			proxy:SetValidTalk( 663 ,true);
			proxy:TalkNextPage( 663 );		
			return true;
		end
	end
	--���������̂ĂĖ���
	return false;
end

--�A�C�e�������`�F�b�N
function ItemChangeCheck(proxy,param,setNo)
	--���A�C�e�����̂ĂĂ���,��A�C�e�����܂�����ĂȂ�
	if proxy:IsCompleteEvent( itemevent_eventidlist[setNo] ) == true and proxy:IsCompleteEvent( itemevent_endidlist[setNo] ) == false then
		proxy:GetRateItem( itemevent_paramlist[setNo] );
		proxy:SetEventFlag( itemevent_eventidlist[setNo] ,false);
		proxy:SetEventFlag( itemevent_endidlist[setNo] ,true);
	end
end

--------------------------------------------------------------------------------------
--�����ς݁��@����������function
--------------------------------------------------------------------------------------

















--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m03_01_00_00(proxy, param)
	print("PlayerDeath_m03_01_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m03_01_00_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerDeath_m03_01_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m03_01_00_00(proxy,param)
	print("PlayerRevive_m03_01_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m03_01_00_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerRevive_m03_01_00_00");
end



--------------------------------------------------------------------------------------
--�y���SNPC�zNPC�����ӏ�ԂɂȂ遡627
--------------------------------------------------------------------------------------
--��627���y���SNPC�zNPC�����ӏ�ԂɂȂ遡
function Condition_627(proxy,param)
	if proxy:IsCompleteEvent(639)== true then	
		print("Condition_627 Success");
		return true;
	end
	return false;
end

function OnEvent_627(proxy,param)
	print("OnEvent_627 begin");
	--proxy:SetEventCommand(633,31);	
	--���l�̏�Ԃ�������Ă���Ċ��ӂɐݒ�
	SetNpcStateFlag( proxy, param, syuujin_flag_list, SYUUJIN_STATE_THANKS );	
	--�t���O�𗧂Ă�
	proxy:SetEventFlag( 627, true );
	
	print("OnEvent_627 end");
end

--------------------------------------------------------------------------------------
--�y���SNPC�z�ÍԎ��l���Ӂ��x�e��628
--------------------------------------------------------------------------------------
--��628���ÍԎ��l���Ӂ��x�e��
function OnEvent_628(proxy,param)
	print("OnEvent_628 begin");
	
	--��b����Ă΂�Ă���̂œ��������邽�߂�LuaCallStart�Ŕ���
	proxy:LuaCallStart(628, 1);
	
	print("OnEvent_628 end");
end

--�ÍԎ��l���Ӂ��x�e
function OnEvent_628_1(proxy,param)
	print("OnEvent_628_1 begin");	
	--���l�̏�Ԃ𐅘S�ŋx�e�ɐݒ�
	SetNpcStateFlag( proxy, param, syuujin_flag_list, SYUUJIN_STATE_INTERVAL );		
	--�t���O�𗧂Ă�
	proxy:SetEventFlag( 628, true );
	
	print("OnEvent_628_1 end");
end

--------------------------------------------------------------------------------------
--�y���SNPC�zNPC���G�ɂȂ遡629
--------------------------------------------------------------------------------------
--��629���y���SNPC�zNPC���G�ɂȂ遡
function OnEvent_629(proxy,param)
	print("OnEvent_629 begin");
	
	--���W�b�NOn
	proxy:EnableLogic( 633, true );

	--���l�̏�Ԃ�G�΂ɐݒ�
	SetNpcStateFlag( proxy, param, syuujin_flag_list, SYUUJIN_STATE_ANGRY_01 );
	proxy:SetTeamType( 633, TEAM_TYPE_AngryFriend );

	--�G�΂����犴�ӁA�x�e�ɂ͂Ȃ�Ȃ��̂ō폜
	proxy:DeleteEvent( 627 );
	proxy:DeleteEvent( 628 );	
	
	--�t���O�𗧂Ă�
	proxy:SetEventFlag( 629, true );
	
	print("OnEvent_629 end");
end

--------------------------------------------------------------------------------------
--�y�y���SNPC�zNPC�����񂾁�630
--------------------------------------------------------------------------------------
--��630���y���SNPC�zNPC�����񂾁�
function OnEvent_630(proxy,param)
	print("OnEvent_630 begin");
	
	--���l�̏�Ԃ�G�΂ɐݒ�
	SetNpcStateFlag( proxy, param, syuujin_flag_list, SYUUJIN_STATE_DEAD );
	
	--�t���O�𗧂Ă�
	proxy:SetEventFlag( 630, true );
	
	--�G�ɍ���ēG�΂�ʂ�z���Ď��S�����肦��̂ŁA�����ł��폜
	--���񂾂犴�ӁA�x�e�A�G�΂ɂ͂Ȃ�Ȃ��̂ō폜
	proxy:DeleteEvent( 627 );
	proxy:DeleteEvent( 628 );
	proxy:DeleteEvent( 629 );
	
	print("OnEvent_630 end");
end




--------------------------------------------------------------------------------------
--��660���ŏ��̗v�΂̌��������遡
--------------------------------------------------------------------------------------

function OnEvent_660(proxy, param)
	print("OnEvent_660 begin");
	
	proxy:TreasureDispModeChange2( 1983 , false ,KANAME_SFX);
	
	print("OnEvent_660 end");
end


--------------------------------------------------------------------------------------
--��661���ŏ��̗v�΂̌����������遡
--------------------------------------------------------------------------------------

function OnEvent_661(proxy, param)
	print("OnEvent_661 begin");
	
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	
	print("OnEvent_661 end");
end


--------------------------------------------------------------------------------------
--��682���{�X�J�����ݒ聡
--------------------------------------------------------------------------------------
function OnEvent_682(proxy,param)
	--print("OnEvent_682 begin");
	--�{�X������ł��Ȃ��@���@�{�X�Ƃ̐퓬���J�n���Ă���
	if proxy:IsCompleteEvent( 4756 ) == false and proxy:IsCompleteEvent( 641 ) == true then
		--�{�X��@�񃍃b�N�J����
		proxy:SetCamModeParamTargetId(3011);
		--�{�X��@���b�N�J����
		proxy:SetCamModeParamTargetIdForBossLock(3010);
	end
	--print("OnEvent_682 end");
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
function OnEvent_730(proxy, param)	Move_Skeleton(proxy, param, 730, 360);end
function OnEvent_731(proxy, param)	Move_Skeleton(proxy, param, 731, 361);end
function OnEvent_732(proxy, param)	Move_Skeleton(proxy, param, 732, 362);end
function OnEvent_733(proxy, param)	Move_Skeleton(proxy, param, 733, 363);end
function OnEvent_734(proxy, param)	Move_Skeleton(proxy, param, 734, 364);end
function OnEvent_735(proxy, param)	Move_Skeleton(proxy, param, 735, 365);end
function OnEvent_736(proxy, param)	Move_Skeleton(proxy, param, 736, 366);end
function OnEvent_737(proxy, param)	Move_Skeleton(proxy, param, 737, 367);end
function OnEvent_738(proxy, param)	Move_Skeleton(proxy, param, 738, 368);end
function OnEvent_739(proxy, param)	Move_Skeleton(proxy, param, 739, 369);end
function OnEvent_740(proxy, param) 	Move_Skeleton(proxy, param, 740, 370);end
function OnEvent_741(proxy, param) 	Move_Skeleton(proxy, param, 741, 371);end
function OnEvent_742(proxy, param) 	Move_Skeleton(proxy, param, 742, 372);end
function OnEvent_743(proxy, param)	Move_Skeleton(proxy, param, 743, 373);end
function OnEvent_744(proxy, param) 	Move_Skeleton(proxy, param, 744, 374);end
function OnEvent_745(proxy, param)	Move_Skeleton(proxy, param, 745, 375);end
function OnEvent_746(proxy, param) 	Move_Skeleton(proxy, param, 746, 376);end
function OnEvent_747(proxy, param)	Move_Skeleton(proxy, param, 747, 377);end
function OnEvent_748(proxy, param)	Move_Skeleton(proxy, param, 748, 378);end
function OnEvent_749(proxy, param) 	Move_Skeleton(proxy, param, 749, 379);end
function OnEvent_750(proxy, param)	Move_Skeleton(proxy, param, 750, 380);end
function OnEvent_751(proxy, param)	Move_Skeleton(proxy, param, 751, 381);end
function OnEvent_752(proxy, param)	Move_Skeleton(proxy, param, 752, 382);end
function OnEvent_753(proxy, param)	Move_Skeleton(proxy, param, 753, 383);end
function OnEvent_754(proxy, param)	Move_Skeleton(proxy, param, 754, 384);end
function OnEvent_755(proxy, param)	Move_Skeleton(proxy, param, 755, 428);end
function OnEvent_756(proxy, param)	Move_Skeleton(proxy, param, 756, 429);end
function OnEvent_757(proxy, param)	Move_Skeleton(proxy, param, 757, 430);end
function OnEvent_758(proxy, param)	Move_Skeleton(proxy, param, 758, 431);end
function OnEvent_759(proxy, param)	Move_Skeleton(proxy, param, 759, 432);end

--[[�}�X�^�[�T�c�L�֘A]]-----------------------------------------------------------------------------------------------------
----------------------------------------------------------------
--��700���T�c�L�����遡
----------------------------------------------------------------
function OnEvent_700(proxy, param)
	proxy:DisableInterupt(638,true);--���荞�݋֎~
	MoveRegion(proxy,638, 2240, -1, 0.0, true);--�|�C���g�ړ�
	proxy:SetEventFlag(700, true);
end
----------------------------------------------------------------
--��701���T�c�L�������遡
----------------------------------------------------------------
function OnEvent_701(proxy, param)
	print("OnEvent_701 begin");
	InvalidBackRead(proxy, 638);--������������	
	proxy:SetEventFlag(701, true);
	print("OnEvent_701 end");
end
--------------------------------------------------------------------------------------
--��704���T�c�L�G�Ή���
--------------------------------------------------------------------------------------
function OnEvent_704(proxy, param)
	if proxy:IsCompleteEvent( 704 ) == false then
		print("OnEvent_704 begin");
		proxy:EnableLogic(637, true);--���W�b�NON
		if proxy:IsCompleteEvent( MasterSATSUKI_HOSTILE_Makoto ) == false then
			SetNpcStateFlag(proxy, param, MasterParamFlag_list, MasterSATSUKI_HOSTILE);--��ԕω�
		end
		proxy:SetTeamType(637, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
		
		proxy:SetEventFlag( 704, true );
		print("OnEvent_704 end");
	end
end

function MakotoAngry(proxy,param,eventid,wepoid)
	print("OnEvent_",eventid," begin");
	--����PC�̃A�C�e��������폜
	if	proxy:RemoveInventoryEquip( TYPE_WEAPON, wepoid ) == true then--�����폜�ł����@�Ȃ��
		print("OnEvent_",eventid," �A�C�e��(��)�폜����");
	end
	
	proxy:EnableLogic(637, true);--���W�b�NON
	SetNpcStateFlag(proxy, param, MasterParamFlag_list, MasterSATSUKI_HOSTILE_Makoto);--��ԕω�
	proxy:SetTeamType(637, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 705,"OnEvent_705_1",0.0,0,0,once);
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( eventid, true );
	print("OnEvent_",eventid," end");
end

--------------------------------------------------------------------------------------
--��705���T�c�L�G�Ή�(������)��
--------------------------------------------------------------------------------------
function OnEvent_705(proxy, param) MakotoAngry(proxy,param,705,40700); end
function OnEvent_713(proxy, param) MakotoAngry(proxy,param,713,40701); end
function OnEvent_714(proxy, param) MakotoAngry(proxy,param,714,40702); end
function OnEvent_715(proxy, param) MakotoAngry(proxy,param,715,40703); end
function OnEvent_716(proxy, param) MakotoAngry(proxy,param,716,40704); end
function OnEvent_717(proxy, param) MakotoAngry(proxy,param,717,40705); end

function OnEvent_705_1(proxy,param)
	print("OnEvent_705_1 begin");
	--proxy:ResetThink( 637 );
	proxy:SendEventRequest( 637 , 0 , 10 );	
	--if TargetChangeWepR2(proxy, 637) == false then
		--print("��������������؂�ւ����s�I�I����������");
	--end--�T�u����i���j�ɐ؂�ւ�������
	print("OnEvent_705_1 end");
end

--------------------------------------------------------------------------------------
--��706���T�c�L�G�Ή�(��������)��
--------------------------------------------------------------------------------------
function OnEvent_706(proxy, param)
	print("OnEvent_706 begin");
	proxy:EnableLogic(637, true);--���W�b�NON
	SetNpcStateFlag(proxy, param, MasterParamFlag_list, MasterSATSUKI_HOSTILE);--��ԕω�
	proxy:SetTeamType(637, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX

	proxy:SetEventFlag( 706, true );
	print("OnEvent_706 end");
end
--------------------------------------------------------------------------------------
--��707���T�c�L���S��
--------------------------------------------------------------------------------------
function OnEvent_707(proxy, param)
	print("OnEvent_707 begin");
	SetNpcStateFlag( proxy, param, MasterParamFlag_list, MasterSATSUKI_DEAD );
	
	proxy:SetEventFlag( 707, true );
	print("OnEvent_707 end");
end
------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--��711���T�c�L�u���b�N���S��
--------------------------------------------------------------------------------------
function OnEvent_711(proxy, param)
	print("OnEvent_711 begin");
	proxy:SetEventFlag( 711, true );
	print("OnEvent_711 end");
end

--�T�c�L�E�u���b�N�̎��̂𒲂ׂĂȂ�
function OnEvent_15634(proxy,param)
	print("OnEvent_15634 begin");
	proxy:SetEventFlag( 15634 , true );
	print("OnEvent_15634 end");
end


------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
--�ÍԎ��l�Ǘ��|�C���g��631�`633
--------------------------------------------------------------------------------------
function OnEvent_631(proxy,param) proxy:LuaCallStart(634,1); end
function OnEvent_632(proxy,param) proxy:LuaCallStart(634,1); end
function OnEvent_633(proxy,param) proxy:LuaCallStart(634,1); end


--------------------------------------------------------------------------------------
--�ÍԎ��l��ԕω���634
--------------------------------------------------------------------------------------
function OnEvent_634(proxy,param)
	print("OnEvent_634 begin");
	print("JustInCheckPoint");
	
	local SyuujinId_1 = 633;--�ÍԂP�̃C�x���gID
	local SyuujinId_2 = 678;--�ÍԂQ�̃C�x���gID
	
	local SyuujinBlock1_acid_list = {627,628,629,630};
	local SyuujinBlock2_acid_list = {1185,1186};
	
	--��U2�̂Ƃ�������
	InvalidCharactor(proxy,SyuujinId_1);
	InvalidCharactor(proxy,SyuujinId_2);
	
	if proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork( SyuujinId_1);
		proxy:RequestForceUpdateNetwork( SyuujinId_2);		
	end
	
	--�u���b�N�̊Ď����폜
	DeleteConditionList(proxy,SyuujinBlock1_acid_list);	
	DeleteConditionList(proxy,SyuujinBlock2_acid_list);
	
	--��肠����������Ԃ�ݒ�
	SetFirstNpcStateFlag( proxy, param, syuujin_flag_list, SYUUJIN_STATE_ESCAPE );
	
	--���l�S����o����
	if proxy:IsCompleteEvent( SYUUJIN_STATE_ESCAPE ) == true then
		print("Syuujin NowState SYUUJIN_STATE_ESCAPE");
		SetSyuujinState1(proxy,param);
		RegistConditionBlock1(proxy,param);
	
	--���l�S����o���Ă���Ċ���
	elseif proxy:IsCompleteEvent( SYUUJIN_STATE_THANKS ) == true then
		print("Syuujin NowState SYUUJIN_STATE_THANKS");
		SetSyuujinState2(proxy,param);
		RegistConditionBlock1(proxy,param);
	
	--���l�S���ŋx�e
	elseif proxy:IsCompleteEvent( SYUUJIN_STATE_INTERVAL ) == true then
		print("Syuujin NowState SYUUJIN_STATE_INTERVAL");
		SetSyuujinState3(proxy,param);
		RegistConditionBlock2(proxy,param);
	
	--���l�ÍԂP�œG��	
	elseif proxy:IsCompleteEvent( SYUUJIN_STATE_ANGRY_01 ) == true then
		print("Syuujin NowState SYUUJIN_STATE_ANGRY_01");
		SetSyuujinState4(proxy,param);
		RegistConditionBlock1(proxy,param);
	
	--���l���S
	elseif proxy:IsCompleteEvent( SYUUJIN_STATE_DEAD ) == true then
		print("Syuujin NowState SYUUJIN_STATE_DEAD");
		SetSyuujinState5(proxy,param);
	
	--���l�ÍԂQ�ɂ���
	elseif proxy:IsCompleteEvent( SYUUJIN_STATE_STAY ) == true then
		print("Syuujin NowState SYUUJIN_STATE_STAY");
		SetSyuujinState6(proxy,param);
		RegistConditionBlock2(proxy,param);
	
	--���l�ÍԂQ�œG��
	elseif proxy:IsCompleteEvent( SYUUJIN_STATE_ANGRY_02 ) == true then
		print("Syuujin NowState SYUUJIN_STATE_ANGRY_02");
		SetSyuujinState7(proxy,param);
		RegistConditionBlock2(proxy,param);
	
	--��ԑJ�ڂȂ��ˁ[�H
	else
		print("Syuujin NowState UnKnown");	
	end
	print("OnEvent_634 end");
end

--------------------------------------------------------------------------------------
--���l�S����o������16050
--------------------------------------------------------------------------------------
function SetSyuujinState1(proxy,param)	
	ValidCharactor(proxy,633);--�ÍԂP�ɂ�����l��L����
	--proxy:SetEventCommand(633,30);
	--��627���y���SNPC�zNPC�����ӏ�Ԃ���Ȃ���
	if proxy:IsCompleteEvent( 627 ) == false then
		proxy:OnRegistFunc( 627, "Condition_627", "OnEvent_627", 1, once );				
	end	
	
	--��628���y���SNPC�zNPC����A�C�e����������ĂȂ���
	if proxy:IsCompleteEvent( 628 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 628, 0, "OnEvent_628", once );
		proxy:NotNetMessage_end();
		--�����p�̃n���h��
		proxy:LuaCall(628, 1, "OnEvent_628_1", once);
	end
end

--------------------------------------------------------------------------------------
--���l�S����o���Ă���Ċ��Ӂ�16051
--------------------------------------------------------------------------------------
function SetSyuujinState2(proxy,param)	
	ValidCharactor(proxy,633);--�ÍԂP�ɂ�����l��L����
	--��628���y���SNPC�zNPC����A�C�e����������ĂȂ���
	if proxy:IsCompleteEvent( 628 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 628, 0, "OnEvent_628", once );
		proxy:NotNetMessage_end();
		--�����p�̃n���h��
		proxy:LuaCall(628, 1, "OnEvent_628_1", once);
		
	end
end

--------------------------------------------------------------------------------------
--���l�S���ŋx�e��16052
--------------------------------------------------------------------------------------
function SetSyuujinState3(proxy,param)
	--�R���҂�����ł��Ȃ�
	if proxy:IsCompleteEvent( 4756 ) == false then
		ValidCharactor(proxy,633);--�ÍԂP�ɂ�����l��L����		
		
	--�R���҂�����ł���
	else
		print("Syuujin NowState SYUUJIN_STATE_INTERVAL > Chenge to SYUUJIN_STATE_STAY");
		InvalidBackRead(proxy,633);--�ÍԂP�ɂ�����l�𖳌���
		ValidCharactor(proxy,678);--�ÍԂQ�ɂ�����l��L����
		--��Ԃ��ÍԂQ�ɂ���ɕύX
		SetNpcStateFlag( proxy, param, syuujin_flag_list, SYUUJIN_STATE_STAY );	
	end
end

--------------------------------------------------------------------------------------
--���l�ÍԂP�œG�΁�16053
--------------------------------------------------------------------------------------
function SetSyuujinState4(proxy,param)
	ValidCharactor(proxy,633);--�ÍԂP�ɂ�����l��L����
	proxy:SetTeamType( 633, TEAM_TYPE_AngryFriend );
end

--------------------------------------------------------------------------------------
--���l���S��16054
--------------------------------------------------------------------------------------
function SetSyuujinState5(proxy,param)
	InvalidBackRead(proxy,633);--�ÍԂP�ɂ�����l�𖳌���
	InvalidBackRead(proxy,678);--�ÍԂQ�ɂ�����l�𖳌���
end

--------------------------------------------------------------------------------------
--���l�ÍԂQ�ɂ��遡16055
--------------------------------------------------------------------------------------
function SetSyuujinState6(proxy,param)
	InvalidBackRead(proxy,633);--�ÍԂP�ɂ�����l�𖳌���
	ValidCharactor(proxy,678);--�ÍԂQ�ɂ�����l��L����
end

--------------------------------------------------------------------------------------
--���l�ÍԂQ�œG�΁�16056
--------------------------------------------------------------------------------------
function SetSyuujinState7(proxy,param)
	InvalidBackRead(proxy,633);--�ÍԂP�ɂ�����l�𖳌���
	ValidCharactor(proxy,678);--�ÍԂQ�ɂ�����l��L����
	proxy:SetTeamType( 678, TEAM_TYPE_AngryFriend );
end


--------------------------------------------------------------------------------------
--���l�Í�1�Ď���
--------------------------------------------------------------------------------------
function RegistConditionBlock1(proxy,param)	
	--���l������ł��Ȃ�
	if proxy:IsCompleteEvent( SYUUJIN_STATE_DEAD ) == false then
		--�ÍԂP�A�Q�œG�΂ɂȂ��Ă��Ȃ�
		if proxy:IsCompleteEvent( SYUUJIN_STATE_ANGRY_01 ) == false 
		and proxy:IsCompleteEvent( SYUUJIN_STATE_ANGRY_02 ) == false then			
			--�z�X�g����̃_���[�W�Ď�
			--m03_01
			--proxy:OnCharacterTotalDamage( 629, 633, 10000, SYUUJIN_TOTAL_DAMAGE, "OnEvent_629", once );	
			proxy:OnCharacterTotalRateDamage( 629, 633, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_629", once );
			--m03_02
			--proxy:OnCharacterTotalDamage( 1185, 678, 10000, SYUUJIN_TOTAL_DAMAGE, "OnEvent_1185_1", once );				
			proxy:OnCharacterTotalRateDamage( 1185, 678, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1185_1", once );
		end
		--���l�̎��S�Ď�
		proxy:OnCharacterDead( 630, 633, "OnEvent_630", once );				
	end
end

--------------------------------------------------------------------------------------
--���l�Í�2�Ď���
--------------------------------------------------------------------------------------
function RegistConditionBlock2(proxy,param)
	--���l������ł��Ȃ�
	if proxy:IsCompleteEvent( SYUUJIN_STATE_DEAD ) == false then
		--�ÍԂP�A�Q�œG�΂ɂȂ��Ă��Ȃ�
		if proxy:IsCompleteEvent( SYUUJIN_STATE_ANGRY_01 ) == false
		and proxy:IsCompleteEvent( SYUUJIN_STATE_ANGRY_02 ) == false then
			--�z�X�g����̃_���[�W�Ď�
			--m03_01
			--proxy:OnCharacterTotalDamage( 629, 633, 10000, SYUUJIN_TOTAL_DAMAGE, "OnEvent_629", once );			
			proxy:OnCharacterTotalRateDamage( 629, 633, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_629", once );
			--m03_02
			--proxy:OnCharacterTotalDamage( 1185, 678, 10000, SYUUJIN_TOTAL_DAMAGE, "OnEvent_1185_1", once );
			proxy:OnCharacterTotalRateDamage( 1185, 678, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1185_1", once );
		end
			--���l�̎��S�Ď�
			proxy:OnCharacterDead( 1186 , 678 , "OnEvent_1186" , once );
		
	end
end


-----------------------------------------------------------------------------
--��780�`784�����ˏo�g���b�v
-----------------------------------------------------------------------------
--��780�`784���g���b�v�����I���ˏo
function SpearTrapMove_780(proxy, param)
	proxy:ForcePlayAnimation(1250, 1);--�����I�ɃA�j�����Đ��i�Đ�����Ă����ꍇ�A�����I���j
end
function SpearTrapMove_782(proxy, param)
	proxy:ForcePlayAnimation(1252, 1);--�����I�ɃA�j�����Đ��i�Đ�����Ă����ꍇ�A�����I���j
end
function SpearTrapMove_783(proxy, param)
	proxy:ForcePlayAnimation(1253, 1);--�����I�ɃA�j�����Đ��i�Đ�����Ă����ꍇ�A�����I���j
end
function SpearTrapMove_784(proxy, param)
	proxy:ForcePlayAnimation(1254, 1);--�����I�ɃA�j�����Đ��i�Đ�����Ă����ꍇ�A�����I���j
end

--��780�����ˏo�g���b�v�i�A�ˁj��----------------------------------------------------
function OnEvent_780(proxy,param)
	print("OnEvent_780 begin");
	proxy:PlayAnimation( 1240, 1 );
	
	proxy:DeleteObjSfxDmyPlyID(1240, 1);--SFX������
	proxy:CreateSfx_DummyPoly(1240, 1, 93006 );--�V����SFX��ݒ�
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd( 780, 1240, 1, "SpearTrapCount_780", once );
	proxy:NotNetMessage_end();
	print("OnEvent_780 end");
end
function SpearTrapCount_780(proxy,param)--����
	--�l�b�g�z�M����Ă�����
	if param:IsNetMessage() == true then
		return;--������
	end
	
	print("Count_780 begin");
		--�����҂̂ݕb���J�E���g
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 780, "OnEvent_780_1", 1.0, 0, 0, once );--�P����(1.0�b��)
			proxy:OnKeyTime2( 780, "OnEvent_780_2", 1.5, 0, 1, once );--�Q����(1.5�b��)����0.5�b��
			proxy:OnKeyTime2( 780, "OnEvent_780_3", 2.0, 0, 2, once );--�R����(2.0�b��)����0.5�b��
		proxy:NotNetMessage_end();
	print("Count_780 end");
end
function OnEvent_780_1(proxy,param)--1����
	print("OnEvent_780_1 begin");
	proxy:LuaCallStart(780, 0);
	print("OnEvent_780_1 end");
end
function OnEvent_780_2(proxy,param)--2����
	print("OnEvent_780_2 begin");
	proxy:LuaCallStart(780, 0);
	print("OnEvent_780_2 end");
end
function OnEvent_780_3(proxy,param)--3����
	print("OnEvent_780_3 begin");
	proxy:LuaCallStart(780, 0);
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd(780, 1250, 1, "OnEvent_780_End", once);--�A�j�����I��������t���O�𗧂Ă�
	proxy:NotNetMessage_end();
	print("OnEvent_780_3 end");
end
function OnEvent_780_End(proxy, param)
	proxy:SetEventFlag( 780, true );
end

--��781�����ˏo�g���b�v�i�U�e�j��----------------------------------------------------
function OnEvent_781(proxy,param)
	print("OnEvent_781 begin");
	proxy:PlayAnimation( 1241, 1 );
	
	proxy:DeleteObjSfxDmyPlyID(1241, 1);--SFX������
	proxy:CreateSfx_DummyPoly(1241, 1, 93006 );--�V����SFX��ݒ�
	
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd( 781, 1241, 1, "OnEvent_781_1", once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 781, true );
	print("OnEvent_781 end");
end
function OnEvent_781_1(proxy,param)
	print("OnEvent_781_1 begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 781, "OnEvent_781_2", 1.0, 0, 0, once );
	proxy:NotNetMessage_end();
	print("OnEvent_781_1 end");
end
function OnEvent_781_2(proxy,param)--��Ĕ���
	print("OnEvent_781_2 begin");
	proxy:PlayAnimation(1251, 1);
	proxy:PlayAnimation(1260, 1);
	proxy:PlayAnimation(1261, 1);
	proxy:PlayAnimation(1262, 1);
	proxy:PlayAnimation(1263, 1);
	proxy:PlayAnimation(1264, 1);
	print("OnEvent_781_2 end");
end


--��782�����ˏo�g���b�v�i�A�ˁj��----------------------------------------------------
function OnEvent_782(proxy,param)
	print("OnEvent_782 begin");
	proxy:PlayAnimation( 1242, 1 );
	
	proxy:DeleteObjSfxDmyPlyID(1242, 1);--SFX������
	proxy:CreateSfx_DummyPoly(1242, 1, 93006 );--�V����SFX��ݒ�
	
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd( 782, 1242, 1, "SpearTrapCount_782", once );
	proxy:NotNetMessage_end();
	print("OnEvent_782 end");
end
function SpearTrapCount_782(proxy,param)
	--�l�b�g�z�M����Ă�����
	if param:IsNetMessage() == true then
		return;--������
	end
	
	print("Count_782 begin");
		--�����҂̂ݕb���J�E���g
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 782, "OnEvent_782_1", 1.0, 0, 0, once );--�P����(1.0�b��)
			proxy:OnKeyTime2( 782, "OnEvent_782_2", 1.5, 0, 1, once );--�Q����(1.5�b��)����0.5�b��
			proxy:OnKeyTime2( 782, "OnEvent_782_3", 2.0, 0, 2, once );--�R����(2.0�b��)����0.5�b��
		proxy:NotNetMessage_end();
	print("Count_782 end");
end
function OnEvent_782_1(proxy,param)--1����
	print("OnEvent_782_1 begin");
	proxy:LuaCallStart(782, 0);
	print("OnEvent_782_1 end");
end
function OnEvent_782_2(proxy,param)--2����
	print("OnEvent_782_2 begin");
	proxy:LuaCallStart(782, 0);
	print("OnEvent_782_2 end");
end
function OnEvent_782_3(proxy,param)--3����
	print("OnEvent_782_3 begin");
	proxy:LuaCallStart(782, 0);
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd(782, 1252, 1, "OnEvent_782_End", once);--�A�j�����I��������t���O�𗧂Ă�
	proxy:NotNetMessage_end();
	print("OnEvent_782_3 end");
end
function OnEvent_782_End(proxy, param)
	proxy:SetEventFlag( 782, true );
end

--��783�����ˏo�g���b�v�i�A�ˁj��----------------------------------------------------
function OnEvent_783(proxy,param)
	print("OnEvent_783 begin");
	proxy:PlayAnimation( 1243, 1 );
	
	proxy:DeleteObjSfxDmyPlyID(1243, 1);--SFX������
	proxy:CreateSfx_DummyPoly(1243, 1, 93006 );--�V����SFX��ݒ�
	
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd( 783, 1243, 1, "SpearTrapCount_783", once );
	proxy:NotNetMessage_end();
	print("OnEvent_783 end");
end
function SpearTrapCount_783(proxy,param)--����
	--�l�b�g�z�M����Ă�����
	if param:IsNetMessage() == true then
		return;--������
	end
	
	print("Count_783 begin");
		--�����҂̂ݕb���J�E���g
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 783, "OnEvent_783_1", 1.0, 0, 0, once );--�P����(1.0�b��)
			proxy:OnKeyTime2( 783, "OnEvent_783_2", 1.5, 0, 1, once );--�Q����(1.5�b��)����0.5�b��
			proxy:OnKeyTime2( 783, "OnEvent_783_3", 2.0, 0, 2, once );--�R����(2.0�b��)����0.5�b��
		proxy:NotNetMessage_end();
	print("Count_783 end");
end
function OnEvent_783_1(proxy,param)--1����
	print("OnEvent_783_1 begin");
	proxy:LuaCallStart(783, 0);
	print("OnEvent_783_1 end");
end
function OnEvent_783_2(proxy,param)--2����
	print("OnEvent_783_2 begin");
	proxy:LuaCallStart(783, 0);
	print("OnEvent_783_2 end");
end
function OnEvent_783_3(proxy,param)--3����
	print("OnEvent_783_3 begin");
	proxy:LuaCallStart(783, 0);

	--��785���J���X�̖���������
	SingleReset(proxy, 785);--���s�[�g�Ȃ̂ŁA���Z�b�g
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 785, "OnEvent_785", 2.0, 0, 0, once );--2�b��ɁA�{�X�������Ă�����J���X�̖�����炷
		proxy:OnObjAnimEnd(783, 1253, 1, "OnEvent_783_End", once);--�A�j�����I��������t���O�𗧂Ă�
	proxy:NotNetMessage_end();	
	print("OnEvent_783_3 end");
end
function OnEvent_783_End(proxy, param)
	proxy:SetEventFlag( 783, true );
end

--��784�����ˏo�g���b�v�i�A�ˁj��----------------------------------------------------
function OnEvent_784(proxy,param)
	print("OnEvent_784 begin");
	proxy:PlayAnimation( 1244, 1 );
	
	proxy:DeleteObjSfxDmyPlyID(1244, 1);--SFX������
	proxy:CreateSfx_DummyPoly(1244, 1, 93006 );--�V����SFX��ݒ�
	
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd( 784, 1244, 1, "SpearTrapCount_784", once );
	proxy:NotNetMessage_end();
	print("OnEvent_784 end");
end
function SpearTrapCount_784(proxy,param)--����
	--�l�b�g�z�M����Ă�����
	if param:IsNetMessage() == true then
		return;--������
	end
	
	print("Count_784 begin");
		--�����҂̂ݕb���J�E���g
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 784, "OnEvent_784_1", 1.0, 0, 0, once );--�P����(0.0�b��)
			proxy:OnKeyTime2( 784, "OnEvent_784_2", 1.5, 0, 1, once );--�Q����(0.5�b��)
			proxy:OnKeyTime2( 784, "OnEvent_784_3", 2.0, 0, 2, once );--�R����(1.0�b��)
		proxy:NotNetMessage_end();
	print("Count_784 end");
end
function OnEvent_784_1(proxy,param)--1����
	print("OnEvent_784_1 begin");
	proxy:LuaCallStart(784, 0);
	print("OnEvent_784_1 end");
end
function OnEvent_784_2(proxy,param)--2����
	print("OnEvent_784_2 begin");
	proxy:LuaCallStart(784, 0);
	print("OnEvent_784_2 end");
end
function OnEvent_784_3(proxy,param)--3����
	print("OnEvent_784_3 begin");
	proxy:LuaCallStart(784, 0);
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd(784, 1254, 1, "OnEvent_784_End", once);--�A�j�����I��������t���O�𗧂Ă�
	proxy:NotNetMessage_end();
	print("OnEvent_784_3 end");
end
function OnEvent_784_End(proxy, param)
	proxy:SetEventFlag( 784, true );
end

--��785���J���X������������----------------------------------------------------
function OnEvent_785(proxy,param)
	print("OnEvent_785 begin");
	if proxy:IsCompleteEvent(4756) == false then--�{�X�������Ă�����
		proxy:PlayTypeSE(804, SOUND_TYPE_C, 504077777);
	end
	proxy:SetEventFlag( 785, true );
	print("OnEvent_785 end");
end


-----------------------------------------------------------------------------
--��4788�`4792�����j��C�x���g�Ď�
-----------------------------------------------------------------------------
function OnEvent_4788(proxy,param) 
	print("OnEvent_4788 begin");
	proxy:SetEventFlag( 4788 , true );
	print("OnEvent_4788 end");
end

function OnEvent_4789(proxy,param) 
	print("OnEvent_4789 begin");
	proxy:SetEventFlag( 4789 , true );
	print("OnEvent_4789 end");
end

function OnEvent_4790(proxy,param) 
	print("OnEvent_4790 begin");
	proxy:SetEventFlag( 4790 , true );
	print("OnEvent_4790 end");
end

function OnEvent_4791(proxy,param) 
	print("OnEvent_4791 begin");
	proxy:SetEventFlag( 4791 , true );
	print("OnEvent_4791 end");
end

function OnEvent_4792(proxy,param) 
	print("OnEvent_4792 begin");
	proxy:SetEventFlag( 4792 , true );
	print("OnEvent_4792 end");
end


-----------------------------------------------------------------------------
--��550���f�u�f�[�����Ď�
-----------------------------------------------------------------------------
function OnEvent_550(proxy,param)
	print("OnEvent_550 begin");
	proxy:SetEventFlag( 550 , true );
	proxy:SetEventFlag( 551 , true );	
	proxy:DeleteEvent( 552 );
	print("OnEvent_550 end");
end

function OnEvent_552(proxy,param)
	--if proxy:GetTargetChrID( 10000 ) == 421 then
		proxy:SetCamModeParamTargetIdForBossLock(3110);
--		print("true");
--	else
--		print("false");
--	end
--����ς�AI����̃^�[�Q�b�gID���Ⴭ�b�N�͎��Ȃ�����
end

-----------------------------------------------------------------------------
--���������g�J�Q�C�x���g
-----------------------------------------------------------------------------
--�{�X���j���̃g�J�Q���Z�b�g�p
function ResetTokage(proxy)
	print("ResetTokage");
	--proxy:SetEventFlag(620,false);
	--proxy:SetEventFlag(622,false);
	--proxy:SetEventFlag(1040,false);
	--proxy:SetEventFlag(1580,false);
	--proxy:SetEventFlag(1582,false);	
	AddEventCounter(proxy,7);
	AddEventCounter(proxy,8);
	AddEventCounter(proxy,9);
	AddEventCounter(proxy,10);
	AddEventCounter(proxy,11);
	
end


-----------------------------------------------------------------------------
--��620�������g�J�Q�C�x���g1
-----------------------------------------------------------------------------
function OnEvent_620(proxy,param)
	print("OnEvent_620 begin");
	proxy:SetEventFlag( 620, true);
	proxy:DeleteEvent( 620 );
	print("OnEvent_620 end");
end

-----------------------------------------------------------------------------
--��622�������g�J�Q�C�x���g2
-----------------------------------------------------------------------------
function OnEvent_622(proxy,param)
	print("OnEvent_622 begin");
	proxy:SetEventFlag( 622 , true );
	proxy:DeleteEvent( 622 );
	print("OnEvent_622 end");
end

-----------------------------------------------------------------------------
--��790�����@�ǔj��1
-----------------------------------------------------------------------------
function OnEvent_790(proxy,param)
	print("OnEvent_790 begin");
	proxy:InvalidSfx( 2320 , true );
	proxy:SetEventFlag( 790,true );
	print("OnEvent_790 end");
end

-----------------------------------------------------------------------------
--��791�����@�ǔj��2
-----------------------------------------------------------------------------
function OnEvent_791(proxy,param)
	print("OnEvent_791 begin");
	proxy:InvalidSfx( 2321 , true );
	proxy:SetEventFlag( 791,true );
	print("OnEvent_791 end");
end
