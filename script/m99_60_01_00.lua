

function Initialize_m99_60_01_00(proxy)
print("Initialize m99_60_01_00 begin");

--��100�����o�[��
--��110�����o�[��
	--��PC���C�x���g�G���A(500)�̒��ɋ���(1.5m)�L���p(30�x��)�ŃA�N�V�����{�^����������
	proxy:RepeatMessage_begin();
	
	
		proxy:OnDistanceAction( 100, 10000, 500, "OnEvent_100", 1.5, HELPID_PULL_LEVER, 0, 30, once);
		proxy:OnDistanceAction( 110, 10000, 512, "OnEvent_110", 1.5, HELPID_PULL_LEVER, 0, 30, once);	
	
	--��120���e�X�g��]�A�j����
	--��PC���n���h��(506)�ɑ΂��Ĕ����p�x(45)�A�p�x�I�t�Z�b�g(-90)�A����(150)�ŃA�N�V�����{�^����������--	
		proxy:OnDistanceAction( 120, 10000, 506, "OnEvent_120", 1.5, HELPID_TURN_HANDLE, -90.0, 45.0, once );	
	--��130���e�X�g��]��OBJ�̃��o�[�A�j����
	--��PC��OBJ(508)�ɑ΂��Ĕ����p�x(90)�A�p�x�I�t�Z�b�g(0)�A���W�I�t�Z�b�g(0, 0, 2.1)����(140)�ŃA�N�V�����{�^����������--
	
		proxy:OnDistanceActionPlus( 130, 10000, 508, "OnEvent_130", 1.4, HELPID_PULL_LEVER, 0, 90.0, 0.0, 0.0, 2.1, once );
	
	--��140���e�X�g�A���A�j����
		proxy:OnDistanceActionPlus( 140, 10000, 503, "OnEvent_140", 1.4, HELPID_PULL_LEVER, 0, 90.0, 0.0, 0.0, 2.1, once );
	
	--��150�����t�g���o�[����
		proxy:OnDistanceAction( 150, 10000, 510, "OnEvent_150", 1.5, HELPID_START, 0, 30, once);
	--��160�����t�g���o�[�ち
		proxy:OnDistanceAction( 165, 10000, 511, "OnEvent_165", 1.5, HELPID_START, 0, 30, once);

	--��2000���V���b�v�e�X�g��
	proxy:RepeatMessage_end();
	
	proxy:OnPlayerActionInRegion( 2000, 60, "OnEvent_2000", HELPID_TALK, everytime );
	

--��220��OBJ�����_���[�W����
	--proxy:OnRegistFunc( 220, "Condition_220", "Result_220", 1, once );
	proxy:NotNetMessage_begin();
		proxy:OnObjectDestroy( 220, 513, "Result_220", once );
	proxy:NotNetMessage_end();
	
	
--��1100����A��
	if proxy:IsCompleteEvent( 1100 ) ==false then
		proxy:OnDistanceAction( 1100, 10000, 1100, "OnEvent_1100", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1100,10000);
		proxy:TreasureDispModeChange( 1100, true );
	end
	
--��1101����A��
	if proxy:IsCompleteEvent( 1101 ) ==false then
		proxy:OnDistanceAction( 1101, 10000, 1101, "OnEvent_1101", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1101,10001);
		proxy:TreasureDispModeChange( 1101, true );
	end
--��1102����A��
	if proxy:IsCompleteEvent( 1102 ) ==false then
		proxy:OnDistanceAction( 1102, 10000, 1102, "OnEvent_1102", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1102,10002);
		proxy:TreasureDispModeChange( 1102, true );
	end
--��1103����A��
	if proxy:IsCompleteEvent( 1103 ) ==false then
		proxy:OnDistanceAction( 1103, 10000, 1103, "OnEvent_1103", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1103,10003);
		proxy:TreasureDispModeChange( 1103, true );
	end
--��1104����A��
	if proxy:IsCompleteEvent( 1104 ) ==false then
		proxy:OnDistanceAction( 1104, 10000, 1104, "OnEvent_1104", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1104,10004);
		proxy:TreasureDispModeChange( 1104, true );
	end
--��1105����A��
	if proxy:IsCompleteEvent( 1105 ) ==false then
		proxy:OnDistanceAction( 1105, 10000, 1105, "OnEvent_1105", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1105,10005);
		proxy:TreasureDispModeChange( 1105, true );
	end	
--��1106����A��
	if proxy:IsCompleteEvent( 1106 ) ==false then
		proxy:OnDistanceAction( 1106, 10000, 1106, "OnEvent_1106", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1106,10006);
		proxy:TreasureDispModeChange( 1106, true );
	end
--��1107����A��
	if proxy:IsCompleteEvent( 1107 ) ==false then
		proxy:OnDistanceAction( 1107, 10000, 1107, "OnEvent_1107", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1107,10007);
		proxy:TreasureDispModeChange( 1107, true );
	end
--��1108����A��
	if proxy:IsCompleteEvent( 1108 ) ==false then
		proxy:OnDistanceAction( 1108, 10000, 1108, "OnEvent_1108", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1108,10100);
		proxy:TreasureDispModeChange( 1108, true );
	end
--��1109����A��
	if proxy:IsCompleteEvent( 1109 ) ==false then
		proxy:OnDistanceAction( 1109, 10000, 1109, "OnEvent_1109", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1109,10101);
		proxy:TreasureDispModeChange( 1109, true );
	end
--��1110����A��
	if proxy:IsCompleteEvent( 1110 ) ==false then
		proxy:OnDistanceAction( 1110, 10000, 1110, "OnEvent_1110", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1110,10102);
		proxy:TreasureDispModeChange( 1110, true );
	end
--��99998���������̃^�C�~���O������
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 99998, "MapInit", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
--��1000����b����A�C�e���擾���������e�X�g��
	proxy:LuaCall( 1000, 0, "Talk_to_ItemInfo_test", once );

--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m99_60_01_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m99_60_01_00", everytime );
	proxy:NotNetMessage_end();
	
	
--�󎀑̂̃C���M�����[�Ή�
--��2010��OBJ�j��
	proxy:OnObjectDestroy(2010,2010,"OnEvent_2010",once);	

--��2012���󎀑́�
	proxy:TreasureDispModeChange(2012,true);
	
	--OBJ��ID600������OBJ�@ID601���{��
	--��600���o���X�^�C�x���g�J�n��
	proxy:RepeatMessage_begin();
		proxy:OnDistanceAction(600,10000,600,"OnEvent_600",2,HELPID_TURN_HANDLE,180,90,everytime);		
	proxy:RepeatMessage_end();
	--���[�v�A�j�������p
	proxy:LuaCall(600,2,"OnEvent_600_2",everytime);
	
	--��601���o���X�^�����p�������p�̃C�x���gID�ƃo���X�^�pOnBallista�̃C�x���gID�͓����Aparam�͕ς��Ȃ���
	proxy:LuaCall(601,0,"OnEvent_601_0",everytime);--0	�cY���p�x����
	proxy:LuaCall(601,1,"OnEvent_601_1",everytime);--1	�cX���p�x����
	proxy:LuaCall(601,2,"OnEvent_601_2",everytime);--2	�c�o���X�^���˓���
	proxy:LuaCall(601,3,"OnEvent_601_3",everytime);--3	�c�o���X�^�I������
	proxy:LuaCall(601,4,"OnEvent_601_4",everytime);--4	�c�o���X�^�_���[�W�I��
	proxy:LuaCall(601,5,"OnEvent_601_5",everytime);--5	�c�t���O�����p
	

proxy:OnRegistFunc(3000,"Check_3000","OnEvent_3000",1,once);


proxy:OnRegionIn( 2100,10000,100,"OnEvent_2100",once);

proxy:OnRegionIn( 1200 , 10000 , 1200 , "OnEvent_1200" , everytime);

print("Initialize m99_60_01_00 end");
end




--��220��OBJ�����_���[�W���@Lua�Ď���
function Condition_220(proxy, param)
	if proxy:CheckChrHit_Obj( 10000, 513 ) ==true then
		print("Condition_220 return true");
		return true;
	end
	return false;
end

--��220��OBJ�����_���[�W���@Lua���ʁ�
function Result_220(proxy, param)
	print("Result_220 running");
	--�����Ƀ_���[�W�𔭐�������ƃv���C���[�ɓ�����ׁA�҂����Ԃ������
	--��220_1��***�����ǉ�***--�P�b�づ
	proxy:OnKeyTime2( 220, "WaitTime_220", 0.0, 0, 1, once );
end

--��220_1���P�b�っ
function WaitTime_220(proxy, param)
	print("WaitTime_220 running");
	--�����Ƀ_���[�W�𔭐�������ƃv���C���[�ɓ�����ׁA�҂����Ԃ������
	------------------------�p�����[�^����--------------------------------
	--	�A�N�V����ID(220),�^�[�Q�b�gOBJ(513),�^�[�Q�b�g�̃_�~�|��ID(1)
	--	�_���[�W��(50),�_���[�W�������蔼�a(1.0),�_���[�W���L������(5.0�b)
	--	�L�����ɓ�����������(HitEvent_220)���s
	----------------------------------------------------------------------
	--��220_2��***�����ǉ�***--�_���[�W���𔭐������_���[�W���ƃ}�b�v�A�L�����̓�������Ď���
	proxy:OnObjectDamageHit( 220, 513, 1, 10000, EV_HIT_ALL, 2.0, 5.0, "HitEvent_220", once );
end

--��220_2���_���[�W��������������
function HitEvent_220(proxy,param)
print("HitEvent_220 is running");
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	--�_�~�|�����g���̂Ń��f�������ւ��Ȃǂ̃^�C�~���O�ɒ���!!
	--�����ւ�����̃��f���Ɏw��ID�̃_�~�|���������ꍇ�ۏ�ł��܂���B)
	proxy:ObjRootMtxMove(513);
	--���f���������ւ���
	proxy:ChangeModel( 513, 2);
	--�����x��ݒ�i��ɂ΂炯������ׁj
	proxy:SetFirstSpeed(513);
	--�I�u�W�F�N�g��j�Ђɂ��Ă����蔻�������
	proxy:SetBrokenPiece(513);
end

--------------------------------------------------------------------------------------
--��������99998
--------------------------------------------------------------------------------------
--��99998���������̃^�C�~���O������
function MapInit(proxy, param)
	print("MapInit_begin");
	proxy:SetColiEnable( 500, false );
	proxy:TreasureDispModeChange( 507, true);
	proxy:PlayLoopAnimation( 509, 2 );
	
	proxy:SetChrType(200,CHR_TYPE_WhiteGhost);
	
--[[
	--���p�j�f�[�����p (�t���O�͉��A�w�肪����Ες���)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m99_60_01_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_60_01_00);
	end
]]
	
	print("MapInit_end");
end

--��****�����݂͎g��Ȃ����A�����ƃp�[�e�B�[���ɃA�T�[�g���o�Ă��܂��̂Ł�
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end

--------------------------------------------------------------------------------------
--���o�[��100
--------------------------------------------------------------------------------------
--��100�����o�[��
function OnEvent_100(proxy, param)
	print("OnEvent_100 begin");
--[[	
	--���o�[�������A�j�����Đ�
	proxy:PlayAnimation(500, 1);
	
	--100�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent(100);
	
	--��100_1��***�����ǉ�***--�v���C���[�̃��o�[�����A�j���I����
	proxy:OnChrAnimEnd( 101, 10000, 8000, "OnEvent_100_1", once);
	
	--��100_2��***�����ǉ�***--���o�[�A�j���I����
	proxy:OnCharacterAnimEnd( 102, 500, 1, "OnEvent_100_2", once);
	
	--����ƈړ����~�߂�
	proxy:DisableMove(10000,1);

	--PC�����o�[�������A�j��(ID 8000)���Đ�
	proxy:PlayAnimation(10000, 8000);
	
	--PC��K�؂Ȉʒu�Ƀ��[�v������
	--proxy:Warp(10000, 2000);
]]	
	--�z�o�[�ړ����[�h�Ɉڍs--
	proxy:BeginAction(10000,2,2,2);

	--�ړ��ʒu(2000)��0.5�b�Ńz�o�[�ړ�--
	proxy:HoverMoveVal(10000,2000,0.1);
	
	--����ƈړ����~�߂�
	proxy:DisableMove(10000,1);
	
	proxy:OnKeyTime2( 100, "OnEvent_100_test", 0.1, 0, 1, once );

	print("OnEvent_100 end");
end
function OnEvent_100_test(proxy,param)
	print("OnEvent_100_test begin");
	--���o�[�������A�j�����Đ�
	proxy:PlayAnimation(500, 1);
	
	--100�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent(100);
	
	--��100_1��***�����ǉ�***--�v���C���[�̃��o�[�����A�j���I����
	proxy:OnChrAnimEnd( 101, 10000, 8000, "OnEvent_100_1", once);
	
	--��100_2��***�����ǉ�***--���o�[�A�j���I����
	proxy:OnCharacterAnimEnd( 102, 500, 1, "OnEvent_100_2", once);
	
	--PC�����o�[�������A�j��(ID 8000)���Đ�
	proxy:PlayAnimation(10000, 8000);
	
	
	print("OnEvent_100_test end");
end

--��100_1���v���C���[�̃��o�[�����A�j���I����
function OnEvent_100_1(proxy, param)
	print("OnEvent_100_1 begin");
	
	--101�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent(101);
	
	--����ƈړ���L���ɂ���
	proxy:DisableMove(10000,0);
	
	--�A�N�V�����I��--
	proxy:ActionEnd(10000);
	
	print("OnEvent_100_1 end");
end

--��100_2�����o�[�A�j���I����
function OnEvent_100_2(proxy, param)
	print("OnEvent_100_2 begin");
	
	--102�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent(102);
	
	
	proxy:SetDefaultAnimation(500);
	
	--��100��***�����ǉ�***--���o�[��
	proxy:RepeatMessage_begin();
		proxy:OnDistanceAction( 100, 10000, 500, "OnEvent_100", 1.5, HELPID_START, 0, 30, once);
	proxy:RepeatMessage_end();
	print("OnEvent_100_2 end");
end

--------------------------------------------------------------------------------------
--���o�[��110
--------------------------------------------------------------------------------------
--��110�����o�[��
function OnEvent_110(proxy, param)
	print("OnEvent_110 begin");
	
	--���o�[�������A�j�����Đ�
	proxy:PlayAnimation(512, 1);
	
	--110�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent(110);
	
	--��110_1��***�����ǉ�***--�v���C���[�̃��o�[�����A�j���I����
	proxy:OnChrAnimEnd( 111, 10000, 8000, "OnEvent_110_1", once);
	
	--��110_2��***�����ǉ�***--���o�[�A�j���I����
	proxy:OnCharacterAnimEnd( 112, 512, 1, "OnEvent_110_2", once);
	
	--����ƈړ����~�߂�
	proxy:DisableMove(10000,1);

	--PC�����o�[�������A�j��(ID 8000)���Đ�--�����E�A�j���̃e�X�g�ɕύX
	proxy:PlayAnimation(10000, 8289);
	
	--PC��K�؂Ȉʒu�Ƀ��[�v������
	--proxy:Warp(10000, 2009);
	print("OnEvent_110 end");
end

--��110_1���v���C���[�̃��o�[�����A�j���I����
function OnEvent_110_1(proxy, param)
	print("OnEvent_110_1 begin");
	
	--111�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent(111);
	
	--����ƈړ���L���ɂ���
	proxy:DisableMove(10000,0);
	
	print("OnEvent_110_1 end");
end
--��110_2�����o�[�A�j���I����
function OnEvent_110_2(proxy, param)
	print("OnEvent_110_2 begin");
	
	--112�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent(112);
	
	
	proxy:SetDefaultAnimation(512);
	
	--��110��***�����ǉ�***--���o�[��
	proxy:RepeatMessage_begin();
		proxy:OnDistanceAction( 110, 10000, 512, "OnEvent_110", 1.5, HELPID_START, 0, 30, once);
	proxy:RepeatMessage_end();
	print("OnEvent_110_2 end");
end



--------------------------------------------------------------------------------------
--�e�X�g��]�A�j����120
--------------------------------------------------------------------------------------
--��120���e�X�g��]�A�j����
function OnEvent_120(proxy, param)
	print("OnEvent_120 begin")
	
	--�n���h�������A�j�����Đ�
	proxy:PlayAnimation( 506, 1 );
	
	--120�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent(120);
	
	--130�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent(130);
	
	--����ƈړ����~�߂�
	proxy:DisableMove(10000,1);
	
	--��120_1��***�����ǉ�***�n���h���A�j���I����
	proxy:OnCharacterAnimEnd( 121, 506, 1, "OnEvent_120_1", once );
	
	--��120_4��***�����ǉ�***�v���C���[�n���h���A�j���I����
	--proxy:OnChrAnimEnd( 124, 10000, 8010, "OnEvent_120_4", once );
	proxy:OnKeyTime2( 124, "OnEvent_120_4", 1.0, 0, 1, once );
	
	--�v���C���[���n���h�����[�v�ʒu��
	proxy:Warp(10000, 2006 );
	
	--�v���C���[�̃n���h�����񂷃A�j�����Đ�
	proxy:PlayAnimation( 10000, 8010 );
	
	print("OnEvent_120 end")
end

--��120_1����]�A�j���I����
function OnEvent_120_1(proxy, param)
	print("OnEvent_120_1 begin")

	--121�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent( 121 );
	
	
	--��120_2��***�����ǉ�***1�b�づ
	proxy:OnKeyTime2( 122, "OnEvent_120_2", 1.0, 0, 0, once );

	print("OnEvent_120_1 end")
end

--��120_2��1�b�っ
function OnEvent_120_2(proxy, param)
	print("OnEvent_120_2 begin")

	--122�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent( 122 );
	
	--OBJ(508)��]�A�j���Đ�
	proxy:PlayAnimation( 508, 2 );
	
	--��120_3��***�����ǉ�***��]�A�j���I����
	proxy:OnCharacterAnimEnd( 123, 508, 2, "OnEvent_120_3", once );
	
	print("OnEvent_120_2 end")
end

--��120_3����]�A�j���I����
function OnEvent_120_3(proxy, param)
	print("OnEvent_120_3 begin")
	
	--123�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent( 123 );
	
	--��120��***�����ǉ�***PC���n���h��(506)�ɑ΂��Ĕ����p�x(45)�A�p�x�I�t�Z�b�g(-90)�A����(150)�ŃA�N�V�����{�^����������
	proxy:RepeatMessage_begin();
		proxy:OnDistanceAction( 120, 10000, 506, "OnEvent_120", 1.5, HELPID_START, -90.0, 45.0, once );
	proxy:RepeatMessage_end();
	
	--��130��***�����ǉ�***PC��OBJ(508)�ɑ΂��Ĕ����p�x(90)�A�p�x�I�t�Z�b�g(0)�A���W�I�t�Z�b�g(0, 0, 2.1)����(140)�ŃA�N�V�����{�^����������
	proxy:RepeatMessage_begin();
		proxy:OnDistanceActionPlus( 130, 10000, 508, "OnEvent_130", 1.4, HELPID_START, 0, 90.0, 0.0, 0.0, 2.1, once );
	proxy:RepeatMessage_end();

	print("OnEvent_120_3 end")
end

--��120_4���v���C���[�n���h���A�j���I����
function OnEvent_120_4(proxy, param)
	print("OnEvent_120_4 begin")
	
	--����ƈړ���L���ɂ���
	proxy:DisableMove(10000,0);
	
	print("OnEvent_120_4 end")
end








--------------------------------------------------------------------------------------
--�e�X�g��]��OBJ�̃��o�[�A�j����130
--------------------------------------------------------------------------------------
--��130���e�X�g��]��OBJ�̃��o�[�A�j����
function OnEvent_130(proxy, param)
	print("OnEvent_130 begin");
	
	--�v���C���[�̃��o�[�������A�j���Đ�
	proxy:PlayAnimation(10000, 8000);
	
	--OBJ(508)�̃��o�[�A�j���Đ�
	proxy:PlayAnimation(508, 1);
	
	--130�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent(130);
	
	--����ƈړ����~�߂�
	proxy:DisableMove(10000,1);
	
	proxy:SetColiEnable( 508, false );
	
	--�v���C���[��OBJ(508)�̃_�~�|��(1)�ʒu�փ��[�v
	proxy:WarpDmy( 10000, 508, 1 );

	--��130_1��***�����ǉ�***�v���C���[�̃��o�[�����A�j���I����
	proxy:OnChrAnimEnd( 131, 10000, 8000, "OnEvent_130_1", once );
	
	--��130_2��***�����ǉ�***���o�[�A�j���I����
	proxy:OnCharacterAnimEnd( 132, 508, 1, "OnEvent_130_2", once );

	print("OnEvent_130 end");
end

--��130_1���v���C���[�̃��o�[�����A�j���I����
function OnEvent_130_1(proxy, param)
	print("OnEvent_130_1 begin");
	
	--131�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent(131);
	
	--����ƈړ���L���ɂ���
	proxy:DisableMove(10000,0);
	
	print("OnEvent_130_1 end");
end

--��130_2�����o�[�A�j���I����
function OnEvent_130_2(proxy, param)
	print("OnEvent_130_2 begin");
	
	--132�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent(132);
	
	proxy:SetColiEnable( 508, true );
	
	--��130��***�����ǉ�***PC��OBJ(508)�ɑ΂��Ĕ����p�x(90)�A�p�x�I�t�Z�b�g(0)�A���W�I�t�Z�b�g(0, 0, 2.1)����(140)�ŃA�N�V�����{�^����������
	proxy:RepeatMessage_begin();
		proxy:OnDistanceActionPlus( 130, 10000, 508, "OnEvent_130", 1.4, HELPID_PULL_LEVER, 0, 90.0, 0.0, 0.0, 2.1, once );
	proxy:RepeatMessage_end();
	
	print("OnEvent_130_2 end");
end














--------------------------------------------------------------------------------------
--�e�X�g�A���A�j����140
--------------------------------------------------------------------------------------
--��140���e�X�g�A���A�j����
function OnEvent_140(proxy, param)
	print("OnEvent_140 begin")
	
	--140�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent( 140 );
	
	--�A�j���P�Đ�
	proxy:PlayAnimation( 503, 1 );
	
	--��140_2��***�����ǉ�***�A�j���P�I����
	proxy:OnCharacterAnimEnd( 142, 503, 1, "OnEvent_140_2", once );
	
	--�v���C���[���|�C���g(2005)�փ��[�v
	proxy:Warp( 10000, 2005);
	
	--����ƈړ����~�߂�
	proxy:DisableMove(10000,1);
	
	--�v���C���[�̃��o�[�A�j���Đ�
	proxy:PlayAnimation( 10000, 8000 );
	
	--��140_1��***�����ǉ�***�v���C���[�̃��o�[�����A�j���I����
	proxy:RepeatMessage_begin();
		proxy:OnChrAnimEnd( 141, 10000, 8000, "OnEvent_140_1", once );
	proxy:RepeatMessage_end();
	
	print("OnEvent_504 end")
end

--��140_1���v���C���[�̃��o�[�����A�j���I����
function OnEvent_140_1(proxy, param)
	print("OnEvent_140_1 end")

	--����ƈړ���L���ɂ���
	proxy:DisableMove(10000,0);
	
	--141�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent(141);
	
	print("OnEvent_140_1 end")
end

--��140_2���A�j���P�I����
function OnEvent_140_2(proxy, param)
	print("OnEvent_140_2 begin")
	
	--142�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent(142);
	
	--��140_3��***�����ǉ�***1�b�づ
	proxy:OnKeyTime2( 143, "OnEvent_140_3", 1.0, 0, 0, once );
	
	print("OnEvent_140_2 end")
end

--��140_3��1�b�っ
function OnEvent_140_3(proxy, param)
	print("OnEvent_140_3 begin")

	--143�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent(143);
	
	--�A�j���Q�Đ�
	proxy:PlayAnimation( 503, 2 );
	
	--��140_4��***�����ǉ�***�A�j���Q�I����
	proxy:OnCharacterAnimEnd( 144, 503, 2, "OnEvent_140_4", once );
	
	print("OnEvent_140_3 end")
end

--��140_4���A�j���Q�I����
function OnEvent_140_4(proxy, param)
	print("OnEvent_140_4 begin");
	
	--144�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent(144);
	
	--��140_5��***�����ǉ�***1�b�づ
	proxy:OnKeyTime2( 145, "OnEvent_140_5", 1.0, 0, 1, once );
	
	print("OnEvent_140_4 end");
end

--��140_5��1�b�っ
function OnEvent_140_5(proxy, param)
	print("OnEvent_140_5 begin");
	
	--145�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent(145);
	
	--�A�j���R�Đ�
	proxy:PlayAnimation( 503, 3 );
	
	--��140_2��***�����ǉ�***�A�j���R�I����
	proxy:OnCharacterAnimEnd( 146, 503, 3, "OnEvent_140_6", once );
	
	print("OnEvent_140_5 end");
end

--��140_6���A�j���R�I����
function OnEvent_140_6(proxy, param)
	print("OnEvent_140_6 begin");
	
	--146�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent(146);
	proxy:RepeatMessage_begin();
		proxy:OnDistanceActionPlus( 140, 10000, 503, "OnEvent_140", 1.4, HELPID_PULL_LEVER, 0, 90.0, 0.0, 0.0, 2.1, once );
	proxy:RepeatMessage_end();
	print("OnEvent_140_6 end");
end




--------------------------------------------------------------------------------------
--���t�g���o�[���@������150
--------------------------------------------------------------------------------------
--��150�����t�g���o�[���@������
function OnEvent_150(proxy, param)
	print("OnEvent_150 begin");
	
	--150�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent( 150 );
	
	--165�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent( 165 );

	--���o�[�����A�j���Đ�
	proxy:PlayAnimation( 510, 1 );
	
	--���o�[�����A�j���Đ�(�_�~�[)
	proxy:PlayAnimation( 511, 1 );

	--�v���C���[�̃��o�[�����A�j���Đ�
	proxy:PlayAnimation( 10000, 8000 );
	
	--��150_1��***�����ǉ�***���o�[�����A�j���I����
	proxy:OnCharacterAnimEnd( 151, 510, 1, "OnEvent_150_1", once );
	
	print("OnEvent_150 end");
end

--��150_1�����o�[�����A�j���I����
function OnEvent_150_1(proxy, param)
	print("OnEvent_150_1 begin");
	
	--151�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent( 151 );

	--���[�v�A�j���؂�ւ�
	proxy:PlayLoopAnimation( 509, 1 );

	--��155��***�����ǉ�***���t�g���o�[������
	proxy:RepeatMessage_begin();
		proxy:OnDistanceAction( 155, 10000, 510, "OnEvent_155", 1.5, HELPID_START, 0, 30, once);
	proxy:RepeatMessage_end();
	
	--��160��***�����ǉ�***���t�g���o�[������
	proxy:RepeatMessage_begin();
		proxy:OnDistanceAction( 160, 10000, 511, "OnEvent_160", 1.5, HELPID_START, 0, 30, once);
	proxy:RepeatMessage_end();
	
	print("OnEvent_150_1 end");
end

--------------------------------------------------------------------------------------
--���t�g���o�[���@������155
--------------------------------------------------------------------------------------
--��155�����t�g���o�[���@������
function OnEvent_155(proxy, param)
	print("OnEvent_155 begin");
	
	--155�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent( 155 );
	
	--160�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent( 160 );
	
	--���o�[�����A�j���Đ�(�_�~�[)
	proxy:PlayAnimation( 510, 1 );
	
	--���o�[�����A�j���Đ�
	proxy:PlayAnimation( 511, 1 );
	
	--�v���C���[�̃��o�[�����A�j���Đ�
	proxy:PlayAnimation( 10000, 8000 );
	
	--��155_1��***�����ǉ�***���o�[�����A�j���I����
	proxy:OnCharacterAnimEnd( 156, 510, 1, "OnEvent_155_1", once );
	
	print("OnEvent_155 end");
end

--��155_1�����o�[�����A�j���I����
function OnEvent_155_1(proxy, param)
	print("OnEvent_155_1 begin");
	
	--153�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent( 156 );

	--���[�v�A�j���؂�ւ�
	proxy:PlayLoopAnimation( 509, 2 );

	--��150��***�����ǉ�***���t�g���o�[������
	proxy:RepeatMessage_begin();
		proxy:OnDistanceAction( 150, 10000, 510, "OnEvent_150", 1.5, HELPID_START, 0, 30, once);	
	--��165��***�����ǉ�***���t�g���o�[������	
		proxy:OnDistanceAction( 165, 10000, 511, "OnEvent_165", 1.5, HELPID_START, 0, 30, once);
	proxy:RepeatMessage_end();	
	
	print("OnEvent_155_1 end");
end

--------------------------------------------------------------------------------------
--���t�g���o�[��@������160
--------------------------------------------------------------------------------------
--��160�����t�g���o�[��@������
function OnEvent_160(proxy, param)
	print("OnEvent_160 begin");
	
	--160�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent( 160 );
	
	--152�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent( 155 );

	--���o�[�����A�j���Đ�
	proxy:PlayAnimation( 511, 1 );
	
	--���o�[�����A�j���Đ�(�_�~�[)
	proxy:PlayAnimation( 510, 1 );

	--�v���C���[�̃��o�[�����A�j���Đ�
	proxy:PlayAnimation( 10000, 8000 );
	
	--��160_1��***�����ǉ�***���o�[�����A�j���I����
	proxy:OnCharacterAnimEnd( 161, 511, 1, "OnEvent_160_1", once );
	
	print("OnEvent_160 end");
end

--��160_1�����o�[�����A�j���I����
function OnEvent_160_1(proxy, param)
	print("OnEvent_160_1 begin");
	
	--161�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent( 161 );

	--���[�v�A�j���؂�ւ�
	proxy:PlayLoopAnimation( 509, 2 );

	--��160��***�����ǉ�***���t�g���o�[������
	proxy:RepeatMessage_begin();
		proxy:OnDistanceAction( 165, 10000, 511, "OnEvent_165", 1.5, HELPID_START, 0, 30, once);
	
	--��150��***�����ǉ�***���t�g���o�[������
		proxy:OnDistanceAction( 150, 10000, 510, "OnEvent_150", 1.5, HELPID_START, 0, 30, once);
	proxy:RepeatMessage_end();
	
	print("OnEvent_160_1 end");
end

--------------------------------------------------------------------------------------
--���t�g���o�[��@������165
--------------------------------------------------------------------------------------
--��165�����t�g���o�[��@������
function OnEvent_165(proxy, param)
	print("OnEvent_165 begin");
	
	--162�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent( 165 );
	
	--150�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent( 150 );
	
	--���o�[�����A�j���Đ�(�_�~�[)
	proxy:PlayAnimation( 511, 1 );
	
	--���o�[�����A�j���Đ�
	proxy:PlayAnimation( 510, 1 );
	
	--�v���C���[�̃��o�[�����A�j���Đ�(�_�~�[)
	proxy:PlayAnimation( 10000, 8000 );
	
	--��165_1��***�����ǉ�***���o�[�����A�j���I����
	proxy:OnCharacterAnimEnd( 166, 511, 1, "OnEvent_165_1", once );
	
	print("OnEvent_165 end");
end

--��165_1�����o�[�����A�j���I����
function OnEvent_165_1(proxy, param)
	print("OnEvent_165_1 begin");
	
	--166�ԃC�x���g�̏����ƃn���h�����폜
	proxy:DeleteEvent( 166 );

	--���[�v�A�j���؂�ւ�
	proxy:PlayLoopAnimation( 509, 1 );

	--��160��***�����ǉ�***���t�g���o�[������
	proxy:RepeatMessage_begin();
		proxy:OnDistanceAction( 160, 10000, 511, "OnEvent_160", 1.5, HELPID_START, 0, 30, once);
	
		--��155��***�����ǉ�***���t�g���o�[������
		proxy:OnDistanceAction( 155, 10000, 510, "OnEvent_155", 1.5, HELPID_START, 0, 30, once);
	proxy:RepeatMessage_end();
	
	print("OnEvent_165_1 end");
end


--��1100����A:���ׂ遡
function OnEvent_1100(proxy, param)
	print("OnEvent_1100 begin");

	--�����A�j���[�V�����p�̃C�x���g
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 1100, "OnEvent_1100_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1100 end");
end

--��1100_1����A�F�A�C�e���\����
function OnEvent_1100_1(proxy, param)
	print("OnEvent_1100_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10000�Q��
	--proxy:GetRateItem(10000);
	-- �ꎞ�I�ɒ��I�����Œ�A�C�e���擾�ɕύX
	--proxy:AddInventoryItem( 160000, TYPE_WEAPON, 50 );
	--proxy:GetItem( 160000, TYPE_WEAPON );
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, 0, MSG_CATEGORY_EVENT, 0, 1);
	proxy:AddInfomationListRateItem( 10000 );
	proxy:AddInfomationListRateItem( 10000 );
	proxy:AddInfomationListRateItem( 10000 );
	proxy:AddInfomationListRateItem( 10000 );
	proxy:AddInfomationListRateItem( 10000 );
	proxy:AddInfomationListRateItem( 10100 );
	proxy:AddInfomationListRateItem( 10100 );
	proxy:AddInfomationListRateItem( 10100 );
	proxy:AddInfomationListRateItem( 10100 );
--[[
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 10000, 70 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 10100, 20 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 10200, 31 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 10300,  9 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 20300, 29 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 20000, 13 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 20100,  2 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 20200,  5 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 20500, 46 );
]]	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 1100, 1 );
	--�󂪌����Ă���̂�����
	proxy:TreasureDispModeChange( 1100, false );
	
	print("OnEvent_1100_1 end");
end

--��1101����A:���ׂ遡
function OnEvent_1101(proxy, param)
	print("OnEvent_1101 begin");

	--�����A�j���[�V�����p�̃C�x���g
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 1101, "OnEvent_1101_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1101 end");
end

--��1101_1����A�F�A�C�e���\����
function OnEvent_1101_1(proxy, param)
	print("OnEvent_1101_1 begin");
	--�A�C�e���擾�֐�--�p�����[�^10001�Q��
	proxy:GetRateItem(10001);
	proxy:GetRateItem(10002);
	proxy:GetRateItem(10003);
	proxy:GetRateItem(10004);
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 1101, 1 );
	--�󂪌����Ă���̂�����
	proxy:TreasureDispModeChange( 1101, false );
	
	print("OnEvent_1101_1 end");
end

--��1102����A:���ׂ遡
function OnEvent_1102(proxy, param)
	print("OnEvent_1102 begin");

	--�����A�j���[�V�����p�̃C�x���g
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 1102, "OnEvent_1102_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1102 end");
end

--��1102_1����A�F�A�C�e���\����
function OnEvent_1102_1(proxy, param)
	print("OnEvent_1102_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10002�Q��
	proxy:GetRateItem(10002);
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 1102, 1 );
	--�󂪌����Ă���̂�����
	proxy:TreasureDispModeChange( 1102, false );
	
	print("OnEvent_1102_1 end");
end

--��1103����A:���ׂ遡
function OnEvent_1103(proxy, param)
	print("OnEvent_1103 begin");

	--�����A�j���[�V�����p�̃C�x���g
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 1103, "OnEvent_1103_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1103 end");
end

--��1103_1����A�F�A�C�e���\����
function OnEvent_1103_1(proxy, param)
	print("OnEvent_1103_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10003�Q��
	proxy:GetRateItem(10003);
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 1103, 1 );
	--�󂪌����Ă���̂�����
	proxy:TreasureDispModeChange( 1103, false );
	
	print("OnEvent_1103_1 end");
end

--��1104����A:���ׂ遡
function OnEvent_1104(proxy, param)
	print("OnEvent_1104 begin");

	--�����A�j���[�V�����p�̃C�x���g
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 1104, "OnEvent_1104_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1104 end");
end

--��1104_1����A�F�A�C�e���\����
function OnEvent_1104_1(proxy, param)
	print("OnEvent_1104_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10004�Q��
	proxy:GetRateItem(10004);
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 1104, 1 );
	--�󂪌����Ă���̂�����
	proxy:TreasureDispModeChange( 1104, false );
	
	print("OnEvent_1104_1 end");
end

--��1105����A:���ׂ遡
function OnEvent_1105(proxy, param)
	print("OnEvent_1105 begin");

	--�����A�j���[�V�����p�̃C�x���g
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 1105, "OnEvent_1105_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1105 end");
end

--��1105_1����A�F�A�C�e���\����
function OnEvent_1105_1(proxy, param)
	print("OnEvent_1105_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10005�Q��
	proxy:GetRateItem(10005);
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 1105, 1 );
	--�󂪌����Ă���̂�����
	proxy:TreasureDispModeChange( 1105, false );
	
	print("OnEvent_1105_1 end");
end

--��1106����A:���ׂ遡
function OnEvent_1106(proxy, param)
	print("OnEvent_1106 begin");

	--�����A�j���[�V�����p�̃C�x���g
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 1106, "OnEvent_1106_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1106 end");
end

--��1106_1����A�F�A�C�e���\����
function OnEvent_1106_1(proxy, param)
	print("OnEvent_1106_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10006�Q��
	proxy:GetRateItem(10006);
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 1106, 1 );
	--�󂪌����Ă���̂�����
	proxy:TreasureDispModeChange( 1106, false );
	
	print("OnEvent_1106_1 end");
end

--��1107����A:���ׂ遡
function OnEvent_1107(proxy, param)
	print("OnEvent_1107 begin");

	--�����A�j���[�V�����p�̃C�x���g
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 1107, "OnEvent_1107_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1107 end");
end

--��1107_1����A�F�A�C�e���\����
function OnEvent_1107_1(proxy, param)
	print("OnEvent_1107_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10007�Q��
	proxy:GetRateItem(10007);
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 1107, 1 );
	--�󂪌����Ă���̂�����
	proxy:TreasureDispModeChange( 1107, false );
	
	print("OnEvent_1107_1 end");
end

--��1108����A:���ׂ遡
function OnEvent_1108(proxy, param)
	print("OnEvent_1108 begin");

	--�����A�j���[�V�����p�̃C�x���g
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 1108, "OnEvent_1108_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1108 end");
end

--��1108_1����A�F�A�C�e���\����
function OnEvent_1108_1(proxy, param)
	print("OnEvent_1108_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10100�Q��
	proxy:GetRateItem(10100);
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 1108, 1 );
	--�󂪌����Ă���̂�����
	proxy:TreasureDispModeChange( 1108, false );
	
	print("OnEvent_1108_1 end");
end

--��1109����A:���ׂ遡
function OnEvent_1109(proxy, param)
	print("OnEvent_1109 begin");

	--�����A�j���[�V�����p�̃C�x���g
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 1109, "OnEvent_1109_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1109 end");
end

--��1109_1����A�F�A�C�e���\����
function OnEvent_1109_1(proxy, param)
	print("OnEvent_1109_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10101�Q��
	proxy:GetRateItem(10101);
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 1109, 1 );
	--�󂪌����Ă���̂�����
	proxy:TreasureDispModeChange( 1109, false );
	
	print("OnEvent_1109_1 end");
end

--��1110����A:���ׂ遡
function OnEvent_1110(proxy, param)
	print("OnEvent_1110 begin");

	--�����A�j���[�V�����p�̃C�x���g
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 1110, "OnEvent_1110_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1110 end");
end

--��1110_1����A�F�A�C�e���\����
function OnEvent_1110_1(proxy, param)
	print("OnEvent_1110_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10102�Q��
	proxy:GetRateItem(10102);
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 1110, 1 );
	--�󂪌����Ă���̂�����
	proxy:TreasureDispModeChange( 1110, false );
	
	print("OnEvent_1110_1 end");
end

--------------------------------------------------------------------------------------
--�V���b�v�e�X�g�F��2000
--------------------------------------------------------------------------------------
--��2000���V���b�v�e�X�g��
function OnEvent_2000(proxy, param)
	print("������OnEvent_2000 begin������");
	proxy:SetTalkMsg( 0, true );
	print("������OnEvent_2000 end������");
end


--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m99_60_01_00(proxy, param)
	print("PlayerDeath_m99_60_01_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m99_60_01_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerDeath_m99_60_01_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m99_60_01_00(proxy,param)
	print("PlayerRevive_m99_60_01_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_60_01_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerRevive_m99_60_01_00");
end



function Talk_to_ItemInfo_test(proxy,param)
print("Talk_to_ItemInfo_test begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, 0, MSG_CATEGORY_EVENT, 0, 1);
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 10000, 70 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 10100, 20 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 10200, 31 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 10300,  9 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 20300, 29 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 20000, 13 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 20100,  2 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 20200,  5 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 20500, 46 );
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 1000, 1 );
print("Talk_to_ItemInfo_test end");
end


--�^���j��
function OnEvent_2010(proxy,param)
	print("OnEvent_2010 begin");
	
	--���o�[�A�j��
	proxy:PlayAnimation(2011,1);
	--��2001���A�j���Ď���
	proxy:OnCharacterAnimEnd(2011,2011,1,"OnEvent_2011",once);
	
	print("OnEvent_2010 end");
end


--���o�[�A�j���Ď�
function OnEvent_2011(proxy,param)
	print("OnEvent_2011 begin;");
	--��2002���󎀑̊Ď���
	proxy:OnDistanceAction(2012,10000,2012,"OnEvent_2012",ItemBoxDist_A,HELPID_CHECK_GLOWING_CORPS,0,ItemBoxAngle_A,once);
	print("OnEvent_2011 end");
end


--�󎀑̊Ď�
function OnEvent_2012(proxy, param)
	print("OnEvent_2012 begin");

	--�����A�j���[�V�����p�̃C�x���g
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s
		proxy:OnKeyTime2( 2012, "OnEvent_2012_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_2012 end");
end

--��2012_1����A�F�A�C�e���\����
function OnEvent_2012_1(proxy, param)
	print("OnEvent_2012_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10100�Q��--�e�X�g
	proxy:GetRateItem(10100);
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 2012, 1 );
	--�󂪌����Ă���̂�����
	proxy:TreasureDispModeChange( 2012, false );
	
	print("OnEvent_2002_1 end");
end


function Check_3000(proxy,param)
	if proxy:IsEquip(TYPE_WEAPON,10000) == true then
		print("IsEquip�@TYPE_WEAPON�@ true");
		return true;
	end
	if proxy:IsEquip(TYPE_PROTECTER,101800) == true then
		print("IsEquip�@TYPE_PROTECTER�@ true");
		return true;
	end
	if proxy:IsInventoryEquip(TYPE_WEAPON,21500) == true then
		print("�����h�����̌������Ă��[");
		return true;
	end
	--print("IsEquip false");
	return false;
end


function OnEvent_3000(proxy,param)
	print("OnEvent_3000");	
end

--------------------------------------------------------------------------------------
--600���o���X�^�J�n�C�x���g
--------------------------------------------------------------------------------------
--�o���X�^�C�x���g�J�n
function OnEvent_600(proxy,param)

	if proxy:IsCompleteEvent(600) == true then
		return;
	end	
	if Luafunc_PlaySynchroAnimation(proxy,param,8100) == true then
		proxy:SetEventFlag(600,true);
		return;
	end
	
	print("OnEvent_600 begin");		
	proxy:EnableLogic(10000,false);
	--�v���C���[��OBJ(600)�̃_�~�|��(191)�ʒu�փ��[�v
	proxy:WarpDmy( 10000, 600, 191 );
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd(600,10000,8100,"OnEvent_600_1",once);
	proxy:NotNetMessage_end();
	proxy:SetEventFlag(600,true);	
	print("OnEvent_600 end");
end

--�v���C���[�A�j���I����
function OnEvent_600_1(proxy,param)
	print("OnEvent_600_1 begin");
	proxy:LuaCallStart(600,2);
	print("OnEvent_600_1 end");
end

--���[�v�A�j���J�n
function OnEvent_600_2(proxy,param)
	print("OnEvent_600_2 begin");	
	--�p�[�e�B�[�̃v���C���[���A�j���[�V����
	if param:IsNetMessage() == true then 
		--�o���X�^�ɃI�[�i�[�o�^
		proxy:SetBallista( 601,param:GetPlayID()+10001 );
		--�����L�����Ƀ��[�v�A�j��
		proxy:PlayLoopAnimation( param:GetPlayID()+10001 , 8110 );
		print("OnEvent_600_2 end");
		return;
	end
	--�o���X�^�ɃI�[�i�[�o�^
	proxy:SetBallista(601,10000);
	--�������A�j���[�V����
	proxy:PlayLoopAnimation( 10000 ,  8110);
	proxy:OnBallista(601,601,HELPID_REMOVE,-20,20,-100,100,5.0,2,2);
	print("OnEvent_600_2 end");
end

--------------------------------------------------------------------------------------
--601���o���X�^������
--------------------------------------------------------------------------------------
--0	�cSE�A�j������
function OnEvent_601_0(proxy,param)	
	--���˃A�j��������Ȃ����
	if proxy:IsEventAnim(601,1) == false then 
		proxy:PlayAnimation(601,2);		
	end
	if param:IsNetMessage() == true then
		if proxy:IsEventAnim(10000,1) == false then 
			proxy:PlayLoopAnimation( param:GetPlayID()+10001 , 8110 );		
			return;
		end
	end
end

--1	�c�p�x����
function OnEvent_601_1(proxy,param)
	--�����҂͂��Ԃ�ŉ�]�����Ă�̂ŁA��M�҂̂ݓ���
	if param:IsNetMessage() == true then
		proxy:ObjRot(601,param:GetPlayID()+10001,param:GetParam3());
	end
end

--2	�c�o���X�^���˓���
function OnEvent_601_2(proxy,param)
	print("OnEvent_601_2 begin");
	print("�o���X�^���˃A�j���Đ�");
	--�����A�j��
	proxy:ForcePlayAnimation(601,1);
	print("OnEvent_601_2 end");
end

--3	�c�o���X�^�I������
function OnEvent_601_3(proxy,param)
	print("OnEvent_601_3 begin");
	print("�o���X�^�I��");	
	if param:IsNetMessage() == true then
		proxy:StopLoopAnimation(param:GetPlayID()+10001);
		proxy:PlayAnimation( param:GetPlayID()+10001 , 8120 );
		print("OnEvent_601_3 end");		
		return;		
	end
	--�v���C���[���E�A�j���H
	proxy:StopLoopAnimation(10000);
	proxy:PlayAnimation(10000,8120);
	proxy:EnableLogic(10000,true);
	
	proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd(601,10000,8120,"OnEvent_601_3_1",once);
		proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_601_3 end");
end
--�A�j���I����̃C�x���g
function OnEvent_601_3_1(proxy,param)
	print("OnEvent_601_3_1 begin");
	print("�����҂݂̂̃C�x���g");
	--�t���O�����p�̃C�x���g�𔭍s
	proxy:LuaCallStart(601,5);	
	print("OnEvent_601_3_1 end");	
end

--4	�c�o���X�^�_���[�W�I������
function OnEvent_601_4(proxy,param)
	print("OnEvent_601_4 begin");
	print("�o���X�^�I��");	
	if param:IsNetMessage() == true then
		proxy:StopLoopAnimation(param:GetPlayID()+10001);		
		print("OnEvent_601_4 end");		
		return;		
	end
	proxy:StopLoopAnimation(10000);	
	proxy:EnableLogic(10000,true);
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(601,"OnEvent_601_4_1",2,0,0,once);
	proxy:NotNetMessage_end();
	print("OnEvent_601_4 end");
end
--���ԑ҂��̃C�x���g
function OnEvent_601_4_1(proxy,param)
	print("OnEvent_601_4_1 begin");
	print("�����҂݂̂̃C�x���g");
	--�t���O�����p�̃C�x���g�𔭍s
	proxy:LuaCallStart(601,5);
	print("OnEvent_601_4_1 end");
end

--5	�c�o���X�^�t���O�����p
function OnEvent_601_5(proxy,param)
	print("OnEvent_601_5 begin");
	--�o���X�^�I�[�i�[����
	proxy:SetBallista( 601,-1 );
	proxy:SetEventFlag(600,false);
	print("OnEvent_601_5 end");	
end


--�A�C�e���폜�e�X�g
function OnEvent_2100(proxy,param)
	print("OnEvent_2100 begin");
	proxy:RemoveInventoryEquip(TYPE_WEAPON,21500);
	print("�����h�����̌��폜���܂�����");
	print("OnEvent_2100 end");
end


--�J�����؂�ւ��e�X�g
function OnEvent_1200(proxy,param)
	--�{�X�������Ă��ā@���@�{�X�Ƃ̐퓬���J�n����Ă���Ȃ�@�J�������{�X�p�ɐ؂�ւ���
	--if proxy:IsCompleteEvent( �{�X�����t���O ) == false and proxy:IsCompleteEvent( �퓬�J�n�t���O ) == true then
	--�{�X��@�񃍃b�N�J����
	proxy:SetCamModeParamTargetId(2021);
	--�{�X��@���b�N�J����
	proxy:SetCamModeParamTargetIdForBossLock(2020);
	--end
end

