
--�o�b�h�G���f�B���O���̃E�F�C�g
BAD_END_WAIT = false;

--���p�j�f�[�����p��ID

demon_id_list_m01_00_00_00 = { 830 , 831 , 832};

hiroin_cancelAnimId = -1;

------------------------------------------------------------------------------------------
--���q���C���̏�Ԉꗗ--------------------------------------------------------------------
--���q���C���̏�Ԉꗗ--------------------------------------------------------------------
HEROINE_STATE_WAIT_FOR_PLAYER = 16140;--�v���C���[��҂�
HEROINE_STATE_WANT_TO_SETTLE  = 16141;--������������
HEROINE_STATE_WITH_A_FUTURE   = 16142;--�t���Ă����܂�
HEROINE_STATE_DOOR_FRONT		= 16143;--���̑O
HEROINE_STATE_DOOR_LEAVE		= 16144;--�����狎�낤���ȁH
HEROINE_STATE_PRAYER			= 16145;--�F���Ă���
HEROINE_STATE_ISNOT				= 16146;--�܂����Ȃ�
heroine_flag_list = {
	HEROINE_STATE_WAIT_FOR_PLAYER ,
	HEROINE_STATE_WANT_TO_SETTLE  ,
	HEROINE_STATE_WITH_A_FUTURE		,
	HEROINE_STATE_DOOR_FRONT		,
	HEROINE_STATE_DOOR_LEAVE		,
	HEROINE_STATE_PRAYER,
	HEROINE_STATE_ISNOT
};


--���[�v�Ď�
GO_TO_WARP_OUJOU 		= 16710;--����փ��[�v
GO_TO_WARP_FURUTORIDE 	= 16711;--�ÍԂփ��[�v
GO_TO_WARP_ROUJOU		= 16712;--�S��փ��[�v
GO_TO_WARP_FUJOU		= 16713;--�s��փ��[�v
GO_TO_WARP_KOUDOU		= 16714;--�B���փ��[�v
GO_TO_WARP_HOKUGEN		= 16715;--�k���փ��[�v

warp_list ={
	GO_TO_WARP_OUJOU		,
	GO_TO_WARP_FURUTORIDE	,
	GO_TO_WARP_ROUJOU		,
	GO_TO_WARP_FUJOU		,
	GO_TO_WARP_KOUDOU		,
	GO_TO_WARP_HOKUGEN		,
}

------------------------------------------------------------------------------------------
--���{�[�h�E�B���̏�Ԉꗗ----------------------------------------------------------------
--�A�N�V����ID				
BALDWIN_STATE_WORK     = 16440--�d����			
BALDWIN_STATE_HOSTILE  = 16441--�G��			
BALDWIN_STATE_DEAD     = 16442--���S
BALDWIN_STATE_ISNOT    = 16443--�܂����Ȃ�

baldwin_flag_list = {
	BALDWIN_STATE_WORK   ,--�d����			
	BALDWIN_STATE_HOSTILE,--�G��			
	BALDWIN_STATE_DEAD   ,--���S
	BALDWIN_STATE_ISNOT	  --�܂����Ȃ�
};



------------------------------------------------------------------------------------------
--���v�l�̏�Ԉꗗ----------------------------------------------------------------
--�A�N�V����ID				
YOJIN_STATE_WAIT_FOR_PLAYER = 16270--�v���C���[��҂�			
YOJIN_STATE_LASTWORD        = 16271--�Ō�̌��t��`���悤			
YOJIN_STATE_DEAD            = 16272--���S			

yojin_flag_list = {
	YOJIN_STATE_WAIT_FOR_PLAYER   ,--�v���C���[��҂�			
	YOJIN_STATE_LASTWORD          ,--�Ō�̌��t��`���悤			
	YOJIN_STATE_DEAD               --���S
};





--���y���p�̓k�z��Ԉꗗ--------------------------------------------------------------------
MAGIC_STUDENT_STATE_ROGARN_HELP		= 16290;
MAGIC_STUDENT_STATE_ROGARN_TOGETHER	= 16291;
MAGIC_STUDENT_STATE_FALL			= 16292;
MAGIC_STUDENT_STATE_ANGRY			= 16293;
MAGIC_STUDENT_STATE_DEAD			= 16294;
MAGIC_STUDENT_STATE_ISNOT			= 16295;
magic_student_flag_list = {
	MAGIC_STUDENT_STATE_ROGARN_HELP 	,
	MAGIC_STUDENT_STATE_ROGARN_TOGETHER ,
	MAGIC_STUDENT_STATE_FALL			,
	MAGIC_STUDENT_STATE_ANGRY			,
	MAGIC_STUDENT_STATE_DEAD			,
	MAGIC_STUDENT_STATE_ISNOT
};


------------------------------------------------------------------------------------------
--���y�_�̐M�k1�z��Ԉꗗ--------------------------------------------------------------------
GOD_BELIEVER_1_STATE_STONE_PILLAR	= 16300;--�Β��ɂ���			
GOD_BELIEVER_1_STATE_URU			= 16301;--�E�����܂ƈꏏ			
GOD_BELIEVER_1_STATE_FALL			= 16302;--���_
GOD_BELIEVER_1_STATE_ANGRY			= 16303;--�G��			
GOD_BELIEVER_1_STATE_DEAD			= 16304;--���S	
GOD_BELIEVER_1_STATE_ISNOT			= 16305;--�܂����Ȃ�

god_beliver1_flag_list = {
	GOD_BELIEVER_1_STATE_STONE_PILLAR 	,
	GOD_BELIEVER_1_STATE_URU  			,
	GOD_BELIEVER_1_STATE_FALL			,
	GOD_BELIEVER_1_STATE_ANGRY			,
	GOD_BELIEVER_1_STATE_DEAD			,
	GOD_BELIEVER_1_STATE_ISNOT
};


------------------------------------------------------------------------------------------
--���y�_�̐M�k2�z��Ԉꗗ--------------------------------------------------------------------
GOD_BELIEVER_2_STATE_STONE_PILLAR	= 16310;--�Β��ɂ���			
--GOD_BELIEVER_2_STATE_URU			= 16311;--�E�����܂ƈꏏ			
GOD_BELIEVER_2_STATE_FALL			= 16312;--���_
GOD_BELIEVER_2_STATE_ANGRY			= 16313;--�G��			
GOD_BELIEVER_2_STATE_DEAD			= 16314;--���S	
GOD_BELIEVER_2_STATE_ISNOT			= 16315;--�܂����Ȃ�
GOD_BELIEVER_2_STATE_ISNOTALREADY	= 16316;--���łɋ��Ȃ�
god_beliver2_flag_list = {
	GOD_BELIEVER_2_STATE_STONE_PILLAR 	,
	--GOD_BELIEVER_2_STATE_URU  		,
	GOD_BELIEVER_2_STATE_FALL			,
	GOD_BELIEVER_2_STATE_ANGRY			,
	GOD_BELIEVER_2_STATE_DEAD			,
	GOD_BELIEVER_2_STATE_ISNOT			,
	GOD_BELIEVER_2_STATE_ISNOTALREADY
};

------------------------------------------------------------------------------------------
--���y�_�̐M�k3�z��Ԉꗗ--------------------------------------------------------------------
GOD_BELIEVER_3_STATE_STONE_PILLAR	= 16320;--�Β��ɂ���			
GOD_BELIEVER_3_STATE_URU			= 16321;--�E�����܂ƈꏏ			
GOD_BELIEVER_3_STATE_FALL			= 16322;--���_
GOD_BELIEVER_3_STATE_ANGRY			= 16323;--�G��			
GOD_BELIEVER_3_STATE_DEAD			= 16324;--���S			
god_beliver3_flag_list = {
	GOD_BELIEVER_3_STATE_STONE_PILLAR 	,
	GOD_BELIEVER_3_STATE_URU  			,
	GOD_BELIEVER_3_STATE_FALL			,
	GOD_BELIEVER_3_STATE_ANGRY			,
	GOD_BELIEVER_3_STATE_DEAD
};

------------------------------------------------------------------------------------------
--���y���t�B�X�g�z��Ԉꗗ--------------------------------------------------------------------
MEFIST_STATE_NO_STAY					= 16390;--�܂����Ȃ�
MEFIST_STATE_STONE_PILLAR				= 16391;--�Β��ɂ���
MEFIST_STATE_ANGRY						= 16392;--�G��
MEFIST_STATE_DEAD						= 16393;--���S			
MEFIST_STATE_KILL_WAIT_RENDOL			= 16394;--���q�E�Q�҂�			
MEFIST_STATE_KILL_WAIT_BIYO				= 16395;--�r���E�Q�҂�
MEFIST_STATE_KILL_WAIT_ROGARN			= 16396;--���K�[���E�Q�҂�			
MEFIST_STATE_KILL_WAIT_MAJO				= 16397;--�����E�Q�҂�
MEFIST_STATE_KILL_WAIT_URU				= 16398;--�E���x�C���E�Q�҂�
MEFIST_STATE_KILL_WAIT_TOMASU			= 16399;--�g�}�X�E�Q�҂�
MEFIST_STATE_KILL_WAIT_BATTI			= 16400;--�o�b�`�E�Q�҂�
mefist_flag_list = {
	MEFIST_STATE_NO_STAY 			,
	MEFIST_STATE_STONE_PILLAR  		,
	MEFIST_STATE_ANGRY  			,
	MEFIST_STATE_DEAD  				,
	MEFIST_STATE_KILL_WAIT_RENDOL  	,
	MEFIST_STATE_KILL_WAIT_BIYO  	,
	MEFIST_STATE_KILL_WAIT_ROGARN  	,
	MEFIST_STATE_KILL_WAIT_MAJO		,
	MEFIST_STATE_KILL_WAIT_URU		,
	MEFIST_STATE_KILL_WAIT_TOMASU	,
	MEFIST_STATE_KILL_WAIT_BATTI
};

------------------------------------------------------------------------------------------
--���y��܂̃g�}�X�z��Ԉꗗ--------------------------------------------------------------------
TOMASU_STATE_WAIT					= 16350;--�ו���
TOMASU_STATE_ANGRY					= 16351;--�G��
TOMASU_STATE_DEAD					= 16352;--���S
TOMASU_STATE_ISNOT					= 16353;--�܂����Ȃ�
tomasu_flag_list = {
	TOMASU_STATE_WAIT			,
	TOMASU_STATE_ANGRY			,
	TOMASU_STATE_DEAD			,
	TOMASU_STATE_ISNOT
};

------------------------------------------------------------------------------------------
--���y�S�܂ꂽ��m�z��Ԉꗗ--------------------------------------------------------------------
HEART_BREAK_FIGHTER_STATE_STONE_PILLAR	= 16420;--�Β��ɂ���
HEART_BREAK_FIGHTER_STATE_ANGRY			= 16421;--�G��
HEART_BREAK_FIGHTER_STATE_DEAD			= 16422;--���S
HEART_BREAK_FIGHTER_STATE_MAYBE_DELETE	= 16423;--��������
HEART_BREAK_FIGHTER_STATE_DELETE		= 16424;--�����܂�
heartbreak_fighter_flag_list = {
	HEART_BREAK_FIGHTER_STATE_STONE_PILLAR 	,
	HEART_BREAK_FIGHTER_STATE_ANGRY  		,
	HEART_BREAK_FIGHTER_STATE_DEAD			,
	HEART_BREAK_FIGHTER_STATE_MAYBE_DELETE	,
	HEART_BREAK_FIGHTER_STATE_DELETE
};





--�����A�[���ϐ��@�������̃^�C�~���O�ŃN���A�u���b�N���Ȃǂ��i�[���āA�g���܂킷
ClearBlockCount = 0;				--�N���A���Ă���u���b�N�̐�
IsLast = false;						--�Β��̉��ɐi�߂�����𖞂����Ă��邩�H

--[[�폜�Ƃ̂��ƂȂ̂ŁA�R�����g�A�E�g
--���n�[�t�n���h�̏�Ԉꗗ

HALF_STATE_WAIT_KOUDOU     = 16160;--�B���ő҂�
HALF_STATE_WAIT_SEKITYU    = 16161;--�Β��ő҂�
HALF_STATE_HOSTILE_KOUDOU  = 16162;--�G��(�B��)
HALF_STATE_HOSTILE_SEKITYU = 16163;--�G��(�Β�)
HALF_STATE_DEAD            = 16164;--���S
HALF_STATE_GO_TO_SEKITYU   = 16165;--�Β��֍s������

half_flag_list = {

	HALF_STATE_WAIT_KOUDOU     ,
	HALF_STATE_WAIT_SEKITYU    ,
	HALF_STATE_HOSTILE_KOUDOU  ,
	HALF_STATE_HOSTILE_SEKITYU ,
	HALF_STATE_DEAD            ,
	HALF_STATE_GO_TO_SEKITYU
};

------------------------------------------------------------------------------------------
--��������̏�Ԉꗗ--------------------------------------------------------------------
--�A�N�V����ID				
MONOSHIRI_STATE_ISNOT    = 16340--�܂����Ȃ�			
MONOSHIRI_STATE_BUSINESS = 16341--��񔄂��			
MONOSHIRI_STATE_HOSTILE  = 16342--�G��			
MONOSHIRI_STATE_DEAD     = 16343--���S			

monoshiri_flag_list = {
	MONOSHIRI_STATE_ISNOT   ,--�܂����Ȃ�			
	MONOSHIRI_STATE_BUSINESS,--��񔄂��			
	MONOSHIRI_STATE_HOSTILE ,--�G��			
	MONOSHIRI_STATE_DEAD     --���S
};

]]
--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉����������
--------------------------------------------------------------------------------------
function Initialize_m01_00_00_00(proxy)
	print("Initialize_m01_00_00_00 begin");
	
	--QWC�̍X�V�v��
	proxy:RecvGlobalQwc();
	
	--�Β��Ɍ���A���̍Č��͂���܂���i�m�o�b�͌��Ǐ�����̂ōČ��������Ȃ��j
	proxy:AddFieldInsFilter(611);-- �S�܂ꂽ��m
	proxy:AddFieldInsFilter(613);-- �v�l
	proxy:AddFieldInsFilter(615);-- �q���C��
	proxy:AddFieldInsFilter(617);-- ���҃��K�[��
	proxy:AddFieldInsFilter(619);-- ���ق̒��A�����g
	proxy:AddFieldInsFilter(680);-- ���t�B�X�g�t�F���X
	proxy:AddFieldInsFilter(681);-- ���p�̓k
	proxy:AddFieldInsFilter(682);-- �_�̐M�k����1
	proxy:AddFieldInsFilter(683);-- �_�̐M�k����2
	proxy:AddFieldInsFilter(684);--�_�̐M�k����3
	proxy:AddFieldInsFilter(687);-- ��܂̃g�}�X
	proxy:AddFieldInsFilter(688);-- �����h�����q
	proxy:AddFieldInsFilter(689);-- ����
	proxy:AddFieldInsFilter(690);-- �E���x�C��
	proxy:AddFieldInsFilter(693);-- �p�b�`
	proxy:AddFieldInsFilter(694);-- �b�艮�{�[���h�E�B��
	proxy:AddFieldInsFilter(695);-- �r�������O����
	proxy:AddFieldInsFilter(821);-- �f�����Y�\�E����������
	
	
	--�N���A�󋵂�GOOD�ŃG���A��ʂ���
	if proxy:IsCompleteEvent( 510 ) == false then 
		if proxy:GetClearState() == CLEAR_STATE_GOODEND then
			proxy:OnKeyTime2( 510 , "OnEvent_510" , 1.0,0,0,once);			
		end
	end

	--�N���A���Ă���G���A�̐����擾
	local areaclear_actionId_list = {8010, 8011, 8012, 8013, 8014};
	local areaclear_actIdNum = table.getn(areaclear_actionId_list);
	for index = 1, areaclear_actIdNum, 1 do
		if proxy:IsCompleteEvent( areaclear_actionId_list[index] ) == true then
			ClearBlockCount = ClearBlockCount + 1;
		end
	end
	
	--�S�G���A���N���A���Ă��邩�H
	if areaclear_actIdNum == ClearBlockCount then
		IsLast = true;
	end
	
	--�N���A�����P�ȏ�Ȃ牤���̊J���t���O��ON
	if proxy:GetClearCount() > 0 then
		print("�����J������OK");
		proxy:SetEventFlag(8035,true);
		if proxy:IsInventoryEquip(TYPE_GOODS,9995) == true then
			print("�������̐΂������Ă���");
			proxy:SetEventFlag( 15500 , true );
		else
			print("�������̐΂͎����Ă��Ȃ�");
		end
	end

	--�e�{�X�̓|���������擾(�e�}�b�v�ł�����Ă͂��邪�A�O�̂��߂ɂ�����x����)
	GetBossFlagCount( proxy, param );
	
	--2008.05.16/toyohide
	--��荇������񉮒ǉ�
	if boss_flagCount >= 1 then
		print("Add InfoId 16");
		proxy:SetEnableInfoStateForEvent(16,true);
		print("Add InfoId 17");
		proxy:SetEnableInfoStateForEvent(17,true);
	end

--------------------------------------------------------------------------------
--�e�G���A���[�v�֘A
--------------------------------------------------------------------------------
	SingleReset(proxy,0);
--��0���e�G���A�փ��[�v(����)��
	proxy:OnDistanceAction(    0, 10000, 1000, "OnEvent_0"   , WarpGimmickDist_A, HELPID_CHECK_OUJOU,        180, WarpGimmickAngle_A, everytime );

	SingleReset(proxy,1);
--��1���e�G���A�փ��[�v(�Í�)��
	proxy:OnDistanceAction(    1, 10000, 1001, "OnEvent_1"   , WarpGimmickDist_A, HELPID_CHECK_HURUTORIDE  , 180, WarpGimmickAngle_A, everytime );
	
	SingleReset(proxy,2);
--��2���e�G���A�փ��[�v(�S��)��
	proxy:OnDistanceAction(    2, 10000, 1002, "OnEvent_2"   , WarpGimmickDist_A, HELPID_CHECK_ROUJOU,       180, WarpGimmickAngle_A, everytime );	

	SingleReset(proxy,3);
--��3���e�G���A�փ��[�v(�s��)��
	proxy:OnDistanceAction(    3, 10000, 1003, "OnEvent_3"   , WarpGimmickDist_A, HELPID_CHECK_HUJOU,        180, WarpGimmickAngle_A, everytime );

	SingleReset(proxy,4);
--��4���e�G���A�փ��[�v(�B��)��
	proxy:OnDistanceAction(    4, 10000, 1004, "OnEvent_4"   , WarpGimmickDist_A, HELPID_CHECK_KOUDOU,       180, WarpGimmickAngle_A, everytime );

--��5���e�G���A�փ��[�v(�k��)��
	--proxy:OnDistanceAction(    5, 10000, 1005, "OnEvent_5"   , WarpGimmickDist_A, HELPID_CHECK_HOKUGEN,      180, WarpGimmickAngle_A, everytime );

--��8083�����[�v���Ė߂��Ă�����
	--�e�}�b�v�̗v�΂ł̃��[�v���ɁA�t���O�𗧂Ă�B
	--�߂��Ă�������̃t���O�𗧂Ă�
	--proxy:SetEventFlag(8083, true);

--��8084������ɍs�����������遡
	--����ł�Init�ɂāA�t���O�𗧂Ă�B
--��8085���ÍԂɍs�����������遡
	--�ÍԂł�Init�ɂāA�t���O�𗧂Ă�B
--��8086���S��ɍs�����������遡
	--�S��ł�Init�ɂāA�t���O�𗧂Ă�B
--��8087���s��ɍs�����������遡
	--�s��ł�Init�ɂāA�t���O�𗧂Ă�B
--��8088���B���ɍs�����������遡
	--�B���ł�Init�ɂāA�t���O�𗧂Ă�B
	
--------------------------------------------------------------------------------
--���X�{�X�֘A
--------------------------------------------------------------------------------
--��40�����X�{�X�����ɍs���܂ł̔�э~��A�|������(��b�V�X�e������Ăяo��)
--test
--proxy:LuaCall(40,2000,"OnEvent_40_RemoStart",everytime);
--proxy:LuaCall(40,2001,"OnEvent_40_RemoFinish",once);
	if proxy:IsCompleteEvent( 40 ) == false then
		
		proxy:LuaCall( 40 , 0 , "OnEvent_40" , everytime );
		
		proxy:NotNetMessage_begin();
			--�|�����J�n�t�F�[�h��ɌĂ΂��n���h��
			proxy:LuaCall(40,REMO_START,"OnEvent_40_RemoStart",once);
			--�|�����I����ɌĂ΂��n���h��
			proxy:LuaCall(40,REMO_FINISH,"OnEvent_40_RemoFinish",once);
		proxy:NotNetMessage_end();
		
		--�v�Ό����Ȃ�
		proxy:SetColiEnable(1140,false);
		proxy:SetDrawEnable(1140,false);
		
		proxy:SetColiEnable(1141,false);
		proxy:SetDrawEnable(1141,false);
		
	else--���X�{�X�|�����I�����Ă�����
		--proxy:TreasureDispModeChange2( 1140 , true ,KANAME_SFX);
		proxy:TreasureDispModeChange2( 1141 , true ,KANAME_SFX);
		
		--proxy:TreasureDispModeChange2( 1145 , true ,KANAME_SFX);
		proxy:TreasureDispModeChange2( 1146 , true ,KANAME_SFX);
		SingleReset(proxy,42);
		SingleReset(proxy,43);
		if proxy:IsCompleteEvent( 70 ) == false then
			proxy:OnDistanceAction( 42,10000,1140,"OnEvent_42",WarpGimmickDist_A,HELPID_GO_TO_SEKITYUU,0,WarpGimmickAngle_B,everytime);
		end
		proxy:OnDistanceAction( 43,10000,1145,"OnEvent_43",WarpGimmickDist_A,HELPID_GO_TO_SEKITYUU,0,WarpGimmickAngle_B,everytime);		
	end
	
	--[[
--��60���g�U�̃��m�����ݍ��ރ|������
	if proxy:IsCompleteEvent( 60 ) == false then
		proxy:OnRegionJustIn( 60 , 10000 , 2040 , "OnEvent_60" , once );
		
		proxy:NotNetMessage_begin();
			--�|�����J�n�t�F�[�h��ɌĂ΂��n���h��
			proxy:LuaCall(60,REMO_START,"OnEvent_60_RemoStart",once);
			--�|�����I����ɌĂ΂��n���h��
			proxy:LuaCall(60,REMO_FINISH,"OnEvent_60_RemoFinish",once);
		proxy:NotNetMessage_end();
	end
	]]
	
--��70�����X�{�X��|������A�\�E�����聡	
	if proxy:IsCompleteEvent( 70 ) == false then
		proxy:OnCharacterDead( 70 , 821 , "OnEvent_70" , once );
		proxy:CustomLuaCall( 450 , "OnEvent_450" , once );
	else
		proxy:SetEventFlag( 450 , true );
		InvalidBackRead( proxy, 821 );
		--�q���C�����ړ�������
		LuaFunc_ForceOmission(proxy,615);	
		proxy:SetAlwayEnableBackread_forEvent( 615 , true );
		proxy:SetDisableGravity( 615,true );
	end

--��71�����X�{�X��|������A�|�������Đ���
	if proxy:IsCompleteEvent( 71 ) == false then
		proxy:OnRegionIn( 71 , 10000 , 2082 , "OnEvent_71" , everytime );
		--proxy:LuaCall(71, 0, "OnEvent_71", once);--�|�����Đ��v���n���h���o�^		
		proxy:NotNetMessage_begin();
			--�|�����J�n�t�F�[�h��ɌĂ΂��n���h��
			proxy:LuaCall(71,REMO_START,"OnEvent_71_RemoStart",once);
			--�|�����I����ɌĂ΂��n���h��
			proxy:LuaCall(71,REMO_FINISH,"OnEvent_71_RemoFinish",once);
		proxy:NotNetMessage_end();
	else
		--���q���C���ւ̃_���[�W�Ď�(�G���f�B���O1�p)��Bad End
		--proxy:OnSimpleDamage( 80 , 615 , 10000 , "OnEvent_80" , once );
		proxy:OnCharacterDead( 80 , 615 , "OnEvent_80",once);
	
		proxy:NotNetMessage_begin();
			--�|�����J�n�t�F�[�h��ɌĂ΂��n���h��
			proxy:LuaCall(80,REMO_START,"OnEvent_80_RemoStart",once);
			--�|�����I����ɌĂ΂��n���h��
			proxy:LuaCall(80,REMO_FINISH,"OnEvent_80_RemoFinish",once);
		proxy:NotNetMessage_end();
	
		--���̈�Ď���ǉ�(�G���f�B���O2�p)��Good End
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		proxy:OnPlayerActionInRegionAttribute( 81, 2010, "OnEvent_81", 10010405, possible_chr_type, once );
	
		proxy:NotNetMessage_begin();
			--�|�����J�n�t�F�[�h��ɌĂ΂��n���h��
			proxy:LuaCall(81,REMO_START,"OnEvent_81_RemoStart",once);
			--�|�����I����ɌĂ΂��n���h��
			proxy:LuaCall(81,REMO_FINISH,"OnEvent_81_RemoFinish",once);
		proxy:NotNetMessage_end();	
	end
	
--��75�����X�{�X���̂𒲂ׂ���	
	proxy:AddCorpseEvent( 75 , 821 );
	proxy:LuaCall( 75 , 0 , "OnEvent_75",once);

--��61���{�X�����ɓ��遡	
	--���{�X�������Ă���Ƃ������C�x���g�o�^
	if proxy:IsCompleteEvent( 70 ) == false then	

		--�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B
		SingleReset(proxy, 61);

		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���)
		proxy:LuaCall( 61, 1, "OnEvent_61_1", everytime );		

		--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l����
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;			

		proxy:NotNetMessage_begin();
			--��61�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���
			proxy:OnPlayerActionInRegionAttribute( 61, 2895, "OnEvent_61", HELPID_GO_TO_IN, possible_chr_type, once );
		proxy:NotNetMessage_end();
		
		--�\�E���u�����h��\��
		proxy:SetDrawEnable( 1130 , false );--�ЂƂ܂��`�悾��OFF
		proxy:SetColiEnable( 1130 , false );
		proxy:InvalidSfx( 1131 ,false );

	end	

--��62���{�X�����񂾂Ƃ��̏�������
	if proxy:IsCompleteEvent( 70 ) == true then
		InvalidCharactor( proxy, 821 );
		proxy:SetEventFlag( 62, true );
		proxy:OnDistanceAction( 44,10000,1140,"OnEvent_44",WarpGimmickDist_A,HELPID_GO_TO_SEKITYUU,0,WarpGimmickAngle_B,everytime);
		
		--�\�E���u�����h�����ĂȂ�
		if proxy:IsCompleteEvent( 141 ) == false then			
			--���ׂ�C�x���g���͓̂������܂��A���ׂ��l�̓z�X�gor�V���O���v���C���[�ł�
			--proxy:NotNetMessage_begin();
				--�z�X�g�A�����A�O���C�̂ݒ��ׂ邱�Ƃ��ł���
				local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;				
				proxy:OnDistanceActionAttribute( 141 , LOCAL_PLAYER , 1130 , "OnEvent_141" , ItemBoxDist_A , 10010135 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
				proxy:LuaCall( 141,1,"OnEvent_141_2",once);
				proxy:LuaCall( 141,2,"OnEvent_141_3",once);
				proxy:TreasureDispModeChange2( 1130, true ,KEN_SFX);
				--proxy:SetRarity( 1130, 10104 );
			--proxy:NotNetMessage_end();
		else
			proxy:SetDrawEnable( 1130 , false );--�ЂƂ܂��`�悾��OFF
			proxy:SetColiEnable( 1130 , false );	
			proxy:InvalidSfx( 1131 , false );			
		end
	end
	
--�������w�����̃|������
	if proxy:IsCompleteEvent( 39 ) == true then
		proxy:SetDrawEnable( 1190 , false );--��OBJ�\��OFF
		proxy:SetColiEnable( 1190 , false );--��OBJ�A�^��OFF
		
		proxy:SetDrawEnable( 1200 , false );--�����w1OBJ�\��OFF
		proxy:SetColiEnable( 1200 , false );--�����w1OBJ�A�^��OFF
		proxy:SetDrawEnable( 1201 , false );--�����w2OBJ�\��OFF
		proxy:SetColiEnable( 1201 , false );--�����w2OBJ�A�^��OFF
		proxy:SetDrawEnable( 1202 , false );--�����w3OBJ�\��OFF
		proxy:SetColiEnable( 1202 , false );--�����w3OBJ�A�^��OFF
		proxy:SetDrawEnable( 1203 , false );--�����w4OBJ�\��OFF
		proxy:SetColiEnable( 1203 , false );--�����w4OBJ�A�^��OFF	
		proxy:SetEventResponsedNavimeshFlag_Disable();
	end
	
--���g�U�̃��m�����ݍ��ރ|������

	if proxy:IsCompleteEvent( 40 ) == false then
		
		--�}�b�v�p�[�c�𖳌�������
		proxy:SetDrawEnableArray( 1020 , false );--�\��OFF
		proxy:SetColiEnableArray( 1020 , false );--������OFF
		
		proxy:SetDrawEnableArray( 1121 , false );--�\��OFF
		proxy:SetColiEnableArray( 1121 , false );--������OFF
		
		--�؂̃I�u�W�F�𖳌�������
		local first_id = 1030;
		local last_id  = 1058;
		local now_id   = first_id;
		local num      = last_id - first_id + 1;
		
		for i=1 , num , 1 do
			proxy:SetDrawEnable( now_id , false );--�\��OFF
			proxy:SetColiEnable( now_id , false );--������OFF
			now_id = now_id + 1;
		end	
		
		--�Ή�����G�𖳌�������
		--�폜
		
		--�{�X�𖳌���
		InvalidCharactor( proxy , 821 );
		
		--SFX�𖳌���
		proxy:InvalidSfx( 1110 , false );--RootErase���Ȃ�
		
	else	
		--OBJ�𖳌���
		proxy:SetDrawEnable( 1100 , false );
		proxy:SetColiEnable( 1100 , false );
		
		proxy:SetDrawEnableArray( 1120 , false );--�\��OFF
		proxy:SetColiEnableArray( 1120 , false );--������OFF
		
		--SFX�𖳌���
		--proxy:InvalidSfx( 1110 , false );
	end
--��72�����X�{�X�̐��P��
	if proxy:IsCompleteEvent( 70 ) == false then
		SingleReset( proxy ,72 );
		--proxy:SetEventFlag( 61 , true );--�{�X�����C�x���g���ꎞ�I�ɖ�����
		proxy:OnRegionJustIn( 72 , 10000 , 2080 , "OnEvent_72",once);
		proxy:RegistSimpleTalk( 72 , 821 , 28500 , TALK_ATTR_ALL-TALK_ATTR_REPEAT);
	end
	
--��73�����X�{�X�̐��Q��
	if proxy:IsCompleteEvent( 70 ) == false then
		SingleReset( proxy ,73 );
		proxy:OnRegionJustIn( 73 , 10000 , 2081 , "OnEvent_73",once);
	end
--[[�����̏��ԏイ�܂������Ȃ��B �����B
--��70�����X�{�X��|������A�|�������Đ���
	if proxy:IsCompleteEvent( 70 ) == true then
		proxy:ForceDead( 821 );
		OnEvent_70_RemoFinish(proxy, param);--�Ή�����|�����I�����ɌĂ΂��n���h�����ĂԁB
	end
]]

--------------------------------------------------------------------------------
--�M�~�b�N�֘A
--------------------------------------------------------------------------------
--��20���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m01_00_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m01_00_00_00", everytime );
	proxy:NotNetMessage_end();

	--���p�j�f�[�����p
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m01_00_00_00);
		proxy:SetEventFlag(20,false);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m01_00_00_00);
	end
--BGM�Đ��֘A--------------------------------------------------------------------------------
	--�|�������������������
	if proxy:IsCompleteEvent( 30 ) == true		--�}�b�v�Љ�|�������Đ��ς݁@����
	and proxy:IsCompleteEvent( 31 ) == true then--�����|�������Đ��ς݁@�Ȃ��
		--�Ō�Ł@�Ō�ւ̃|�������I����ĂȂ��ꍇ�͉͂������Ȃ�
		if IsLast == true and  proxy:IsCompleteEvent( 39 ) == false then
			--�������Ȃ�
		else
			--�}�b�v�̃N���A���ɂ���āA�Đ�����BGM�𒆂ŕύX���čĐ�
			proxy:OnKeyTime2( 30 , "PlayBGM_SEKITYUU" , 0.1,0,0,once);
			--PlayBGM_SEKITYUU(proxy, param);
			print("���Β�BGM�Đ�");
		end		
	end
--��422��BGM�Đ�3(���X�{�X��)��
	if proxy:IsCompleteEvent( 70 ) == false then
		SingleReset(proxy, 422);
		proxy:EnableLogic( 821, false );
		proxy:RepeatMessage_begin();
			proxy:OnRegionIn(422,10000,2061,"OnEvent_422",everytime);--�̈�ւ̊Ď��o�^
		proxy:RepeatMessage_end();
	end

	--proxy:CreateSpreadBeast( 1100, 1101 );
---------------------------------------------------------------------------------------------
	
--��30���}�b�v�Љ�|�����Đ���
	if proxy:IsCompleteEvent( 30 ) == false then		
		proxy:NotNetMessage_begin();
			--�|�����J�n�t�F�[�h��ɌĂ΂��n���h��
			proxy:LuaCall(30,REMO_START,"OnEvent_30_RemoStart",once);
			--�|�����I����ɌĂ΂��n���h��
			proxy:LuaCall(30,REMO_FINISH,"OnEvent_30_RemoFinish",once);
		proxy:NotNetMessage_end();
		
		OnEvent_30(proxy,param);
		--proxy:OnKeyTime2( 30 , "OnEvent_30" , 0.0 , 0 , 1 , once );
	else
		if proxy:IsCompleteEvent( 37 ) == false then
			if proxy:GetClearCount() == 0 then		
				proxy:OnKeyTime2( 32 , "OnEvent_32",0.1,0,0,once);
			end
		end
		
		--��31�������|������
		if proxy:IsCompleteEvent( 31 ) == false then
			--�t�@�����N�X���j�ς�
			if proxy:IsCompleteEvent( 4096 ) == true then
				proxy:NotNetMessage_begin();
					--�|�����J�n�t�F�[�h��ɌĂ΂��n���h��
					proxy:LuaCall(31,REMO_START,"OnEvent_31_RemoStart",once);
					--�|�����I����ɌĂ΂��n���h��
					proxy:LuaCall(31,REMO_FINISH,"OnEvent_31_RemoFinish",once);
				proxy:NotNetMessage_end();
				OnEvent_31(proxy,param);
			else
				--�t�@�����N�X��|�����ɐΒ��֖߂��Ă����̂ŁABGM�Đ�
				proxy:OnKeyTime2( 31 , "PlayBGM_SEKITYUU" ,0.1 , 0 , 1 ,once);
				--PlayBGM_SEKITYUU(proxy, param);
				print("���Β�BGM�Đ�");
			end
		else
			--�Ō�ւ̉���|���������Ă��Ȃ�
			if proxy:IsCompleteEvent( 39 ) == false and IsLast == true then
				proxy:NotNetMessage_begin();
					--�|�����J�n�t�F�[�h��ɌĂ΂��n���h��
					proxy:LuaCall( 39 , REMO_START,"OnEvent_39_RemoStart",once);
					--�|�����I�����ɌĂ΂��n���h��
					proxy:LuaCall( 39 , REMO_FINISH, "OnEvent_39_RemoFinish",once);
				proxy:NotNetMessage_end();
				OnEvent_39(proxy,param);				
			end
		end
	end
	


--��303���v�l����̘̐b��
	proxy:NotNetMessage_begin();
		proxy:LuaCall( 303,0,"OnEvent_303",once);--���[�r�[�Đ��p�̉�b�Ăяo���n���h��
	proxy:NotNetMessage_end();
	
--��34���v�΂̕���̊J����
	proxy:NotNetMessage_begin();
		proxy:LuaCall(34, 0, "OnEvent_34", once);--�v�l���[�r�[��̉�b�Ăяo�������n���h��
	proxy:NotNetMessage_end();
	
--��304���q���C������A�C�e����Ⴄ��
	proxy:NotNetMessage_begin();
		proxy:LuaCall(304,0,"OnEvent_304",once);
	proxy:NotNetMessage_end();
--��305���v�l����A�C�e����Ⴄ��
	proxy:NotNetMessage_begin();
		proxy:LuaCall(305,0,"OnEvent_305",once);
	proxy:NotNetMessage_end();
	
--��80���G���f�B���O�|����1��
	--(OnEvent_71�̏I����ɒǉ�)
	
--��81���G���f�B���O�|����2��
	--(OnEvent_71�̏I����ɒǉ�)

--��140�����̂Ɏh�����Ă��錕��
	--if proxy:IsCompleteEvent( 140 ) == false then
		---�z�X�g�A�����A�O���C�̂ݒ��ׂ邱�Ƃ��ł���
		--local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		
		--proxy:OnDistanceActionAttribute( 140 , 10000 , 1130 , "OnEvent_140" , ItemBoxDist_A , 10010135 , 0 , ItemBoxAngle_A ,possible_chr_type, once ); 
		--proxy:LuaCall( 140,1,"OnEvent_140_2",once);
	--else
		--proxy:SetDrawEnable( 1130 , false );--�ЂƂ܂��`�悾��OFF	
		--proxy:InvalidSfx(1130, false);
	--end
	
	--proxy:TreasureDispModeChange( 1130, true );
	--proxy:SetRarity( 1130, 10730 );
	
--���v�l�ւ̔����J���Ă���
	if	boss_flagCount >= 1 then
		--proxy:PlayAnimation( 1111, 1 );
		proxy:SetColiEnable( 1111, false );
		proxy:SetDrawEnable( 1111, false );
		proxy:InvalidSfx(2071, false);
	end
	
--------------------------------------------------------------------------------
--NPC�֘A
--------------------------------------------------------------------------------
--[[���q���C���֘A��]]--------------------------------------------------------------

--��100���q���C�����Ō�̐킢�����ӂ��遡
	--(Second_Initialize�Ŕ����A�ǉ�)
	

--��90,91���o�b���q���C���̑O���삭��(��b�V�X�e������Ăяo��)
	proxy:LuaCall( 90 , 0 , "OnEvent_90" , everytime );
	proxy:LuaCall( 91 , 0 , "OnEvent_91" , everytime );
	
--��b����Ă΂��n���h��
	proxy:LuaCall( 110, 0, "OnEvent_110", everytime );
--��113���q���C���𗧂��オ�点�遡(��b�V�X�e������Ăяo��)
	proxy:LuaCall( 113, 0, "OnEvent_113", everytime );

--��111���q���C�����S�Ď���	
	proxy:RepeatMessage_begin();
		proxy:SetEventFlag( 115 , false );	
		proxy:OnCharacterDead(111, 615, "OnEvent_111", once);
		--proxy:OnCharacterHP( 111 , 615 , "OnEvent_111",0.0,once);
	proxy:RepeatMessage_end();
	
	--������Ԃ��Z�b�g(��Ԃ����ݒ�̏ꍇ�A�w�肵����Ԃ��Z�b�g����)
	SetFirstNpcStateFlag( proxy , param , heroine_flag_list , HEROINE_STATE_ISNOT );

	--�q���C�����܂����Ȃ�
	if proxy:IsCompleteEvent( HEROINE_STATE_ISNOT ) == true then
		if boss_flagCount >= 1 then--1�̈ȏ�|���Ă�����
			SetNpcStateFlag(proxy,param, heroine_flag_list , HEROINE_STATE_WAIT_FOR_PLAYER );
		else
			--�q���C����������
			InvalidBackRead( proxy , 615 );
		end
	end
	
--~ 	--�q���C�������̑O�Ɉړ����Ă���
--~ 	if proxy:IsCompleteEvent( HEROINE_STATE_WAIT_FOR_PLAYER ) == true then
--~ 		if boss_flagCount >= 1 then--�P�̈ȏ�|���Ă�����
--~ 			--��b���I�点�Ă��Ȃ��ꍇ�͉��x��
--~ 			if	proxy:IsCompleteEvent(110) == false then
--~ 				SetNpcStateFlag(proxy, param, heroine_flag_list, HEROINE_STATE_DOOR_FRONT );
--~ 				proxy:SetAlwayEnableBackread_forEvent( 615 , true );
--~ 				--�q���C���̋����o�b�N���[�h�𖳌���
--~ 				--proxy:OnKeyTime2( 40,"OnEvent_40_1",0,0,2,once);
--~ 			end
--~ 		end
--~ 	end
	
	--�q���C�������̑O���狎��
	if	IsLast == true then
		if	proxy:IsCompleteEvent(HEROINE_STATE_WAIT_FOR_PLAYER) 	== true then--or
--~ 			proxy:IsCompleteEvent(HEROINE_STATE_DOOR_FRONT) 		== true or
--~ 			proxy:IsCompleteEvent(HEROINE_STATE_DOOR_LEAVE) 		== true then
			SetNpcStateFlag(proxy, param, heroine_flag_list, HEROINE_STATE_WANT_TO_SETTLE );
			proxy:SetAlwayEnableBackread_forEvent( 615 , true );
			--�q���C���̋����o�b�N���[�h�𖳌���
			--proxy:OnKeyTime2( 40,"OnEvent_40_1",0,0,3,once);
		end
--~ 	else
--~ 		if	proxy:IsCompleteEvent(HEROINE_STATE_DOOR_LEAVE) == true then
--~ 			SetNpcStateFlag(proxy, param, heroine_flag_list, HEROINE_STATE_WAIT_FOR_PLAYER );
--~ 			proxy:SetAlwayEnableBackread_forEvent( 615 , true );
--~ 			--�q���C���̋����o�b�N���[�h�𖳌���
--~ 			--proxy:OnKeyTime2( 40,"OnEvent_40_1",0,0,4,once);
--~ 		end
	end


	if proxy:IsCompleteEvent(HEROINE_STATE_WANT_TO_SETTLE) == true then
		--�\��
		--�ʒu���킹
		proxy:Warp( 615 , 2205 );
	elseif proxy:IsCompleteEvent(HEROINE_STATE_WAIT_FOR_PLAYER) == true then		
		if proxy:IsCompleteEvent( 4096 ) == true then
			--�A�C�e�����炤��b�I����Ă���
			if proxy:IsCompleteEvent( 304 ) == false then
				--�q���C�����W���킹
				proxy:Warp( 615 , 2206 );
				proxy:SetSpStayAndDamageAnimId( 615 , -1 , -1 );
			else
				--�ʒu���킹
				Lua_SetHeroinPos(proxy,param);
			end
		else
			--�ʒu���킹
			Lua_SetHeroinPos(proxy,param);
		end
	elseif proxy:IsCompleteEvent(HEROINE_STATE_WITH_A_FUTURE) == true then
		proxy:Warp( 615, 2001 );
		proxy:ChangeThink( 615, 10 );
		proxy:ResetThink( 615 );
		proxy:ChangeInitPosAng( 615, 2001 );
		--�q���C���̃��W�b�N�؂�ւ� ���u�F��H�v
		proxy:SendEventRequest( 615 , 0 , AI_EVENT_GRACE);
		proxy:SetAlwayEnableBackread_forEvent( 615 , true );
		--�q���C���̋����o�b�N���[�h�𖳌���
		--proxy:OnKeyTime2( 40,"OnEvent_40_1",0,0,5,once);
	elseif proxy:IsCompleteEvent(HEROINE_STATE_DOOR_FRONT) == true then
		--�ʒu���킹
		--Lua_SetHeroinPos(proxy,param);
		--proxy:Warp( 615, 2003 );
		--proxy:ChangeInitPosAng( 615, 2003 );
	elseif proxy:IsCompleteEvent(HEROINE_STATE_PRAYER) == true then--�F��
		--��153���F���ԏ�������
		--�q���C�����ړ�������
		LuaFunc_ForceOmission(proxy,615);
		proxy:Warp( 615 , 2002 );--�q���C��������̈ʒu�Ƀ��[�v
		proxy:SetHp( 615 , 1.0 );--�q���C��HP�S��
		proxy:EnableLogic( 615 , false );--���W�b�NOFF
		
		proxy:SetEventCommand( 615 , 70 );--EzState�ɐ���ԍ�(�F��)�𑗂�
		proxy:SetAlwayEnableBackread_forEvent( 615 , true );
		--�q���C���̋����o�b�N���[�h�𖳌���
		--proxy:OnKeyTime2( 40,"OnEvent_40_1",0,0,6,once);
	end
	
	
--���q���C���֘A��-----------------------------

--[[�����K�[���֘A��]]-----------------------------
	SetFirstNpcStateFlag( proxy , param , rogarn_flag_list , ROGARN_STATE_PRISONER );--��Ԃ�������Ύ��l�ɂ���
	
	if	proxy:IsCompleteEvent( ROGARN_STATE_WAIT ) == true and
		IsLast == true then
		SetNpcStateFlag( proxy, param, rogarn_flag_list, ROGARN_STATE_LAST_WARD );
	end
	if	proxy:IsCompleteEvent( ROGARN_STATE_GO_M1 ) == true then
		SetNpcStateFlag( proxy, param, rogarn_flag_list, ROGARN_STATE_WAIT );
	end
	
	if	proxy:IsCompleteEvent( ROGARN_STATE_WAIT ) == true or--�҂��̎��@��
		proxy:IsCompleteEvent( ROGARN_STATE_ANGRY_M1 ) == true or--�G�΂̎��@��
		proxy:IsCompleteEvent( ROGARN_STATE_LAST_WARD ) == true then--�Ō�̌��t�̎���
		
		if	proxy:IsCompleteEvent( ROGARN_STATE_ANGRY_M1 ) == false then--�G�΂ł͂Ȃ���
			--proxy:OnCharacterTotalDamage( 221, 617, 10000, 100, "OnEvent_221", once );--�_���[�W�Ď��ǉ�
			proxy:OnCharacterTotalRateDamage( 221, 617, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_221", once );
			
		end
		--��L�̏�Ԃ̎��ɁA���S�Ď��ǉ�
		proxy:OnCharacterDead( 222, 617, "OnEvent_222", once );
		
		proxy:SetEventFlag( 224, false );
	end

	if	proxy:IsCompleteEvent( ROGARN_STATE_WAIT ) 		== false and
		proxy:IsCompleteEvent( ROGARN_STATE_ANGRY_M1 )	== false and
		proxy:IsCompleteEvent( ROGARN_STATE_LAST_WARD ) == false then
		InvalidBackRead( proxy, 617 );
		proxy:SetEventFlag( 224, true );
	elseif proxy:IsCompleteEvent( ROGARN_STATE_ANGRY_M1 ) == true then
		proxy:EnableLogic(617,true);--���W�b�N�n�m
		proxy:SetTeamType(617, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
		--����ҋ@����		
		--SetNpcStateFlag(proxy,param,rogarn_flag_list,ROGARN_STATE_ANGRY_M1);--�G�Ώ�Ԃ�
	end
--�����K�[���֘A��-----------------------------


--[[�����p�̓k�֘A��]]-----------------------------

	SetFirstNpcStateFlag(proxy, param, magic_student_flag_list, MAGIC_STUDENT_STATE_ISNOT);--��Ԃ��ݒ肳��Ă��Ȃ���΁A�܂����Ȃ�

	--�܂����Ȃ�
	if proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ISNOT ) == true then
		if boss_flagCount >= 1 then 
			SetNpcStateFlag( proxy, param ,magic_student_flag_list, MAGIC_STUDENT_STATE_ROGARN_HELP );--�����ď�Ԃ�
		else
			InvalidBackRead( proxy , 681 );
		end
	end
	
	if proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_DEAD ) == false then--���S���Ă��Ȃ��@����
		if proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ANGRY ) == false then--�G�΂��Ă��Ȃ�
		
			if proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_TOGETHER ) == true --���K�[���ƈꏏ�Ȃ��
			and	proxy:IsCompleteEvent( ROGARN_STATE_ANGRY_M1 ) == true then--���K�[�����G�΂Ȃ��
				SetNpcStateFlag( proxy, param, magic_student_flag_list, MAGIC_STUDENT_STATE_ANGRY );--�G�Ώ�Ԃ�
			end
			
			--��312�����K�[�����Β��֗������ԕύX��--
			if proxy:IsCompleteEvent( ROGARN_STATE_GO_M1 ) == true --���K�[�����Β��֗������@��
			or proxy:IsCompleteEvent( ROGARN_STATE_WAIT ) == true then--���K�[�����Β��ɂ���Ȃ��
				SetNpcStateFlag( proxy, param, magic_student_flag_list, MAGIC_STUDENT_STATE_ROGARN_TOGETHER );--���K�[���ƈꏏ��
			end			
			
			--proxy:OnCharacterTotalDamage( 310, 681, 10000, 100, "OnEvent_310", once );--�_���[�W�Ď��ǉ�
			proxy:OnCharacterTotalRateDamage( 310, 681, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_310", once );
			
		end
		proxy:OnCharacterDead( 311, 681, "OnEvent_311", once );
	end

	if 	proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_HELP 		) == true or 
		proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_TOGETHER 	) == true or
		proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_FALL 			) == true or
		proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ANGRY 			) == true then
			proxy:SetEventFlag( 313, false );
			
	elseif proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_HELP 		) == false and
		   proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_TOGETHER 	) == false and
		   proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_FALL 			) == false and
		   proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ANGRY 			) == false then
			InvalidBackRead( proxy, 681 );
			proxy:SetEventFlag( 313, true );
	end
	
	if proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ANGRY ) == true then
		proxy:EnableLogic(681,true);--���W�b�N�n�m
		proxy:SetTeamType(681, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
		--����ҋ@����		
		--SetNpcStateFlag( proxy, param, magic_student_flag_list, MAGIC_STUDENT_STATE_ANGRY );--�G�Ώ�Ԃ�
	end
--�����p�̓k�֘A��-----------------------------


--[[�������h�����q�֘A��]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, rendol_flag_list, RENDOL_STATE_HELP_FOR_DOREI_HEISI);--�����h�����q�̏�Ԃ�����������
	proxy:SetTeamTypePlus(688, TEAM_TYPE_Friend,false);--�`�[���^�C�v�ύX	
	local now_rendol_state = GetRendolState(proxy,param);
	
	if	now_rendol_state == RENDOL_STATE_SEARCH_1 or				--����P��T���@��
		now_rendol_state == RENDOL_STATE_SEARCH_2 or				--����Q��T���@��
		now_rendol_state == RENDOL_STATE_SEARCH_3 or				--����R��T���@��
		now_rendol_state == RENDOL_STATE_LOCATION_INVISIBLE or		--�����Ȃ��ꏊ�ɂ���@��
		now_rendol_state == RENDOL_STATE_HOSTILE_STONE_PILLAR then	--�Β��œG�΂Ȃ��
		
		if	proxy:IsCompleteEvent( RENDOL_STATE_HOSTILE_STONE_PILLAR ) == false then--�G�΂ł͂Ȃ�
			--proxy:OnCharacterTotalDamage( 230, 688, 10000, 100, "OnEvent_230", once );--�_���[�W�Ď��ǉ�
			proxy:OnCharacterTotalRateDamage( 230, 688, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_230", once );
		end
		--��L�����̎��ɁA���S�Ď��ǉ�
		proxy:OnCharacterDead( 231, 688, "OnEvent_231", once );
		proxy:SetEventFlag( 232, false );
	end
	
	local now_rendol_state = GetRendolState(proxy,param);
	
	if	now_rendol_state ~= RENDOL_STATE_SEARCH_1 and
		now_rendol_state ~= RENDOL_STATE_SEARCH_2 and
		now_rendol_state ~= RENDOL_STATE_SEARCH_3 and
		now_rendol_state ~= RENDOL_STATE_LOCATION_INVISIBLE and
		now_rendol_state ~= RENDOL_STATE_HOSTILE_STONE_PILLAR then
		InvalidBackRead( proxy, 688 );
		proxy:SetEventFlag( 232, true );
	elseif now_rendol_state == RENDOL_STATE_HOSTILE_STONE_PILLAR then
		proxy:EnableLogic(688,true);--���W�b�N�n�m
		proxy:SetTeamType(688, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX	TEAM_TYPE_Friend
		proxy:EraseEventSpecialEffect_2(688,5063);		
		--SetNpcStateFlag(proxy,param,possible_transration_list_m02_03_00_00,RENDOL_STATE_HOSTILE_STONE_PILLAR);--�G�Ώ�Ԃ�
	end
--�������h�����q�֘A��-----------------------------

--[[���r�������O�����֘A��]]-----------------------------
	SetFirstNpcStateFlag( proxy , param , biyo_flag_list , BIYO_STATE_CAPTIVE );--��Ԃ��ݒ肳��ĂȂ���΁A����R��T����
	proxy:SetTeamTypePlus(695, TEAM_TYPE_Friend,false);--�`�[���^�C�v�ύX	
	--���̌���|���Ă���
	if	proxy:IsCompleteEvent(BIYO_STATE_KING_OF_SWORD_KILL) == true then 
		--�򗳂̒�������ł����ꍇ�͂������Ȃ���Ԃ�
		if proxy:IsCompleteEvent(TYO_STATE_DEAD) == true then 
			SetNpcStateFlag(proxy,param, biyo_flag_list, BIYO_STATE_EXIT );
			
		--�򗳂̒�������ł��Ȃ��ꍇ�͒��Ɛ���Ă����ԂɑJ��
		elseif proxy:IsCompleteEvent(TYO_STATE_DEAD) == false then
			SetNpcStateFlag(proxy,param, biyo_flag_list, BIYO_STATE_BATTLE_FLY_DRAGON );
		end
	end
	
	if	proxy:IsCompleteEvent(BIYO_STATE_SEARCH_3) == true or					--�Β��őҋ@�@��
		proxy:IsCompleteEvent(BIYO_STATE_BATTLE_FLY_DRAGON) == true or			--�򗳂̒��Ɛ���Ă���@��
		proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_STONE_PILLAR ) == true then	--�Β��œG�΂Ȃ��
		
		if	proxy:IsCompleteEvent( BIYO_STATE_HOSTILE_IN_STONE_PILLAR ) == false then--�G�΂ł͂Ȃ�
			--proxy:OnCharacterTotalDamage( 240, 695, 10000, 100, "OnEvent_240", once );--�_���[�W�Ď��ǉ�
			proxy:OnCharacterTotalRateDamage( 240, 695, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_240", once );
		end
		proxy:OnCharacterDead( 241, 695, "OnEvent_241", once );
		proxy:SetEventFlag( 244, false );
	end
	
	print("test1");
	if	proxy:IsCompleteEvent(BIYO_STATE_SEARCH_3) == false and
		proxy:IsCompleteEvent(BIYO_STATE_BATTLE_FLY_DRAGON) == false and
		proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_STONE_PILLAR ) == false then
		print("test2");
		InvalidBackRead( proxy, 695 );
		proxy:SetEventFlag( 244, true );
	elseif proxy:IsCompleteEvent( BIYO_STATE_HOSTILE_IN_STONE_PILLAR ) == true then
		proxy:EnableLogic(695,true);--���W�b�N�n�m
		proxy:SetTeamType(695, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
		proxy:EraseEventSpecialEffect_2(695,5064);
		--SetNpcStateFlag(proxy,param,biyo_flag_list,BIYO_STATE_HOSTILE_IN_STONE_PILLAR);--�G�Ώ�Ԃ�
		print("test3");
	end
--���r�������O�����֘A��-----------------------------


--[[�������֘A��]]-----------------------------

	SetFirstNpcStateFlag(proxy, param, majo_flag_list, MAJO_STATE_LIBERATE);--��Ԃ��ݒ肳��Ă��Ȃ���΁A�J�����Ăق�����
	
	--�x�e���@��
	if proxy:IsCompleteEvent( MAJO_STATE_BREAK ) == true then
		SetNpcStateFlag(proxy, param, majo_flag_list, MAJO_STATE_WAIT_M1);
	end
	
	if	proxy:IsCompleteEvent( MAJO_STATE_WAIT_M1 )		== true or		--�Β��őҋ@�@��		
		proxy:IsCompleteEvent( MAJO_STATE_ANGRY_M1 )	== true then	--�Β��œG�΂Ȃ��		
		if	proxy:IsCompleteEvent( MAJO_STATE_ANGRY_M1 ) == false then	--�G�΂ł͂Ȃ�
			--proxy:OnCharacterTotalDamage( 260, 689, 10000, 100, "OnEvent_260", once );--�_���[�W�Ď��ǉ�
			proxy:OnCharacterTotalRateDamage( 260, 689, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_260", once );			
		end
		--��L�̏�Ԃ̎��ɁA���S�Ď��ǉ�
		proxy:OnCharacterDead( 261, 689, "OnEvent_261", once );
		proxy:SetEventFlag( 263, false );
	end
	
	
	if	proxy:IsCompleteEvent( MAJO_STATE_WAIT_M1 )		== false and
		proxy:IsCompleteEvent( MAJO_STATE_ANGRY_M1 )	== false then
		InvalidBackRead( proxy, 689 );
		proxy:SetEventFlag( 263, true );
	elseif proxy:IsCompleteEvent( MAJO_STATE_ANGRY_M1 )	== true then
		proxy:EnableLogic(689,true);--���W�b�N�n�m
		proxy:SetTeamType(689, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		
		--SetNpcStateFlag( proxy, param, majo_flag_list, MAJO_STATE_ANGRY_M1 );--�G�Ώ�Ԃ�	
	end
--�������֘A��-----------------------------


--[[���E���x�C���֘A��]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, urubain_flag_list, URUBAIN_STATE_HELP);--��Ԃ��ݒ肳��Ă��Ȃ���΁A�����Ăق�����

	if	proxy:IsCompleteEvent( URUBAIN_STATE_THANKS ) == true then--���ӂ��Ă���Ȃ��
		SetNpcStateFlag( proxy, param, urubain_flag_list, URUBAIN_STATE_STONE_PILLAR );--�Β��ɂ����
	end
	
	if	proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR ) == true or			--�Β��ɂ���@��
		proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) == true then	--�Β��œG�΂Ȃ��
		
		if proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) == false then--�G�΂ł͂Ȃ�
			--proxy:OnCharacterTotalDamage( 270, 690, 10000, TOTALDAMAGE_URUBAIN, "OnEvent_270", once );--�_���[�W�Ď��ǉ�
			proxy:OnCharacterTotalRateDamage( 270, 690, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_270", once );
			
		end
		--��L�̏�Ԃ̎��ɁA���S�Ď��ǉ�
		proxy:OnCharacterDead( 271, 690, "OnEvent_271", once );
		proxy:SetEventFlag( 273, false );
	end
	
	if	proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR ) 		== false and
		proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) 	== false then
		InvalidBackRead( proxy , 690 );--�E���l������
		proxy:SetEventFlag( 273, true );
		
	elseif proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) == true then
		proxy:EnableLogic(690,true);--���W�b�N�n�m
		proxy:SetTeamType(690, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		
		--SetNpcStateFlag( proxy, param, urubain_flag_list, URUBAIN_STATE_STONE_PILLAR_ANGRY );--�G�Ώ�Ԃ�
	end
--���E���x�C���֘A��-----------------------------


--[[�������g�֘A��]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, yuruto_flag_list, YURUTO_STATE_LIFT);--��Ԃ��ݒ肳��ĂȂ�������A�G���x�[�^�[�ő҂ɂ���

	--�Β��ɍs���O��ԂȂ�
	if proxy:IsCompleteEvent( YURUTO_STANDBY_M1 ) == true then
		--�L���{�X���j����茻�݂̌��j���̕�������
		if proxy:GetBossCount() < boss_flagCount then
			SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STATE_WAIT_M1 );
			--�Ăу{�X�J�E���g���L��
			proxy:SetBossCount( boss_flagCount );
		end
	end

--��280�������g�G�΁��i��b�V�X�e������Ăяo���j
	--��b����Ă΂��n���h��
	proxy:LuaCall( 280, 0, "OnEvent_280", everytime );
	
--��15630�������g�̎��̂𒲂ׂ���
	if proxy:IsCompleteEvent( 15630 ) == false then
		proxy:AddCorpseEvent( 15630 , 619 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15630 ,0 , "OnEvent_15630",once );
 		proxy:NotNetMessage_end();
	end	
	
	if	proxy:IsCompleteEvent( YURUTO_STATE_ANGRY_M1 ) == true or	--�Β��œG�΁@��
		proxy:IsCompleteEvent( YURUTO_STATE_WAIT_M1  ) == true then	--�Β��ő҂Ȃ��
		
		--[[
		if proxy:IsCompleteEvent( 500 ) == false then
			proxy:SetEventFlag( 500 , true );
			proxy:SetBossCount( boss_flagCount );
		end
		]]
		--��L�̏�Ԃ̎��ɁA���S�Ď��ǉ�
		proxy:OnCharacterDead( 281, 619, "OnEvent_281", once );
		proxy:SetEventFlag( 282, false );
	end

	if	proxy:IsCompleteEvent( YURUTO_STATE_ANGRY_M1 ) == false and		--�G�΂ł͂Ȃ��@����
		proxy:IsCompleteEvent( YURUTO_STATE_WAIT_M1  ) == false then	--�Β��ő҂Ȃ��
		if 	proxy:IsCompleteEvent( 281 ) == true and	--����ł���
			proxy:IsCompleteEvent( 15630 ) == false then	--���̂𒲂ׂĂȂ�
			--���̂��Č�����
			proxy:OpeningDeadPlus( 619 , true ,false ,false );
		else
			InvalidBackRead( proxy, 619 );
		end
		proxy:SetEventFlag( 282, true );
	elseif	proxy:IsCompleteEvent( YURUTO_STATE_ANGRY_M1 ) == true then--�G�΂Ȃ��
		proxy:EnableLogic(619,true);--���W�b�N�n�m
		proxy:SetTeamType(619, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		
		--SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STATE_ANGRY_M1 );--�G�Ώ�Ԃ�
	end
--�������g�֘A��-----------------------------

--[[���o�b�`�֘A��]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, batti_flag_list, BATTI_NOT_STAY);--��Ԃ��ݒ肳��Ă��Ȃ���΁A�ǂ��ɂ����Ȃ���
	
	if	proxy:IsCompleteEvent(BATTI_SATISFIED) 		== true or		--�ÍԂ̖����@��
		proxy:IsCompleteEvent(BATTI_PRESENT) 		== true or		--�B���̕�͂������@��
		proxy:IsCompleteEvent(BATTI_VEXING_M6) 		== true or		--�B���̎c�O�@��
		proxy:IsCompleteEvent(BATTI_DESTORYKUMA)	== true then	--�B���ŃN�}���V�|�����Ȃ��
		SetNpcStateFlag( proxy, param, batti_flag_list, BATTI_RESERVE_M1 );--�Β��ő҂�
	end
	
	if	proxy:IsCompleteEvent( BATTI_RESERVE_M1 ) == true or	--�Β��ő҂@��
		proxy:IsCompleteEvent( BATTI_ANGRY_M1 ) == true then	--�Β��œG�΂Ȃ��
		
		if	proxy:IsCompleteEvent( BATTI_ANGRY_M1 ) == false then--�G�΂ł͂Ȃ�
			--proxy:OnCharacterTotalDamage( 290, 693, 10000, TOTALDAMAGE_BATTI, "OnEvent_290", once );--�_���[�W�Ď��ǉ�
			proxy:OnCharacterTotalRateDamage( 290, 693, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_290", once );
			
		end
		--��L�̏�Ԃ̎��ɁA���S�Ď��ǉ�
		proxy:OnCharacterDead( 291, 693, "OnEvent_291", once );
		proxy:SetEventFlag( 293, false );
	end
	
	if	proxy:IsCompleteEvent( BATTI_RESERVE_M1 )	== false and
		proxy:IsCompleteEvent( BATTI_ANGRY_M1  ) 	== false then
		InvalidBackRead( proxy, 693 );
		proxy:SetEventFlag( 293, true );
	elseif proxy:IsCompleteEvent( BATTI_ANGRY_M1  )	== true then
		proxy:EnableLogic(693,true);--���W�b�N�n�m
		proxy:SetTeamType(693, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		
		--SetNpcStateFlag( proxy, param, batti_flag_list, BATTI_ANGRY_M1 );--�G�Ώ�Ԃ�
	end
--���o�b�`�֘A��-----------------------------


--[[���v�l�֘A��]]-----------------------------
	--������Ԃ�ݒ�
	SetFirstNpcStateFlag(proxy, param, yojin_flag_list, YOJIN_STATE_WAIT_FOR_PLAYER);

	--Init�ɋL��
	--proxy:LuaCall( 303,0,"OnEvent_303",once);--�|�����Đ��p�̉�b�Ăяo���n���h��
	--�v�l�������Ă���
	proxy:SetDeadMode( 613, true );--�m�[�_���[�W
	proxy:DisableHpGauge( 613 , true );--�Q�[�W�\������
	if proxy:IsCompleteEvent(YOJIN_STATE_DEAD ) == false then
		--��b����Ă΂��n���h��
		
		--��300���v�l���S��
		if proxy:IsCompleteEvent( 300 ) == false then
			proxy:OnCharacterDead( 300 , 613 , "OnEvent_300" , once );
		end
		
		--�v�l���Ō�̌��t��`���悤�ɂȂ�
		if	IsLast == true then--���ׂẴX�e�[�W���I�������
			if	proxy:IsCompleteEvent( YOJIN_STATE_WAIT_FOR_PLAYER ) 	== true then--��l����҂Ȃ��
				SetNpcStateFlag(proxy, param, yojin_flag_list, YOJIN_STATE_LASTWORD );
			end
		end
	end

	--�v�l�������ĂȂ�
	if proxy:IsCompleteEvent(YOJIN_STATE_DEAD ) == true then
		InvalidBackRead( proxy , 613 );--�v�l������
	end
--���v�l�֘A��-----------------------------

--[[���_�̐M�k1�֘A��]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, god_beliver1_flag_list, GOD_BELIEVER_1_STATE_ISNOT);--��Ԃ��ݒ肳��Ă��Ȃ�������A�܂����Ȃ�
	
	if proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_ISNOT ) == true then
		if boss_flagCount >= 1 then
			SetNpcStateFlag( proxy, param, god_beliver1_flag_list, GOD_BELIEVER_1_STATE_STONE_PILLAR );
		else
			InvalidBackRead( proxy ,682 );
		end
	end
	
--------��ԏ���������-----------
	--��322�����K�[�����ÍԂ���߂��Ă������ɁA�u�E���l�ƈꏏ�v�ɂ��遡
	if	proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_STONE_PILLAR ) == true and	--�Β��ɋ��� ����
		proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR ) == true or			--�E���l�Β��ɋ��� ��
		proxy:IsCompleteEvent( URUBAIN_STATE_THANKS ) == true then				--�E���l�����ӂ��Ă��� �Ȃ��
		
		SetNpcStateFlag( proxy, param, god_beliver1_flag_list, GOD_BELIEVER_1_STATE_URU );--�E���l�ƈꏏ��
	end
	
	if proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) == true and	--�E���l���G�΁@����
	   proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_ANGRY ) == false then	--�G�΂��Ă��Ȃ��Ȃ��
		if proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_DEAD ) == false then
			SetNpcStateFlag( proxy, param, god_beliver1_flag_list, GOD_BELIEVER_1_STATE_ANGRY );--�G�Ώ�Ԃ�
		end
	end
	
	if proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_DEAD ) == true then
		--��323���M�k�P���S������
		InvalidBackRead( proxy, 682 );
		--proxy:SetEventFlag( 323, true );
	elseif proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_ANGRY ) == true then
		--��324���M�k�P�G�Ώ�����
		proxy:EnableLogic(682,true);--���W�b�N�n�m
		proxy:SetTeamType(682, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		
		--SetNpcStateFlag( proxy, param, god_beliver1_flag_list, GOD_BELIEVER_1_STATE_ANGRY );--�G�Ώ�Ԃ�
	end
--------�e�Ď��ǉ�-----------	
	--�E���l�G�Ύ��ɌĂ΂��n���h���o�^
	proxy:LuaCall(320, 1, "OnEvent_320", once);
	
	if proxy:IsCompleteEvent(GOD_BELIEVER_1_STATE_DEAD ) == false then--���S���Ă��Ȃ��Ȃ��
		if proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_ANGRY ) == false then--�G�΂��Ă��Ȃ�
			--��320���M�k�P�G�ΊĎ���
			proxy:OnCharacterTotalRateDamage( 320, 682, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_320", once );--�G�ΊĎ��ǉ�
			
		end
		--��321���M�k�P���S�Ď���
		proxy:OnCharacterDead( 321, 682, "OnEvent_321", once );--��L�̏�Ԃ��������ɁA���S�Ď��ǉ�
	end
--���_�̐M�k1�֘A��-----------------------------


--[[���_�̐M�k2�֘A��]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_ISNOT);--��Ԃ��ݒ肳��Ă��Ȃ�������A�܂����Ȃ�
	
	if proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ISNOT ) == true then
		if boss_flagCount >= 1 then
			proxy:SetEventFlag( 333, false );
			SetNpcStateFlag( proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_STONE_PILLAR );
		else
			proxy:SetEventFlag( 333, true );
			InvalidBackRead( proxy ,683 );
		end
	end
--��335���E���l��T���ɍs���A�s���s����
	if proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_STONE_PILLAR ) == true	--�Β��ɋ���@����
	and proxy:IsCompleteEvent( 9164 ) == true	--��b�u�E���l�������ɍs������v�i9164�j�𕷂��Ă���@����
	and proxy:IsCompleteEvent( 4756 ) == true then --�ÍԂP���N���A���Ă���@�Ȃ��
		proxy:SetEventFlag( 335, true );
		SetNpcStateFlag( proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_ISNOTALREADY );--���łɋ��Ȃ���
		
	elseif proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR ) == true then	--�E���l���Β��ɂ�����
		proxy:SetEventFlag( 335, true );
		SetNpcStateFlag( proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_ISNOTALREADY );--���łɋ��Ȃ���
	end
	--[[�����A���łɋ��Ȃ��t���O�́A�����Ȃ��B�i�������邩������Ȃ��̂ŁA�c���Ă����j]]
	if proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ISNOTALREADY ) == true then
		print("�E���l��T���ɍs���āc�s���s��");
		SetNpcStateFlag( proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_DEAD );--�T���ɍs���ċA��ʐl�ɁE�E�E
	end
	
--------��ԏ���������-----------	
	if proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_DEAD ) == true 				--���S�@��
	or proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ISNOTALREADY ) == true then	--���łɋ��Ȃ��Ȃ��
		--��333���M�k�Q���S������
		InvalidBackRead( proxy, 683 );
		proxy:SetEventFlag( 333, true );
	elseif proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ANGRY ) == true then
		--��334���M�k�Q�G�Ώ�����
		proxy:EnableLogic(683,true);--���W�b�N�n�m
		proxy:SetTeamType(683, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		
		--SetNpcStateFlag( proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_ANGRY );--�G�Ώ�Ԃ�
	end

	if proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) == true and	--�E���l���G�� ����
	   proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ANGRY ) == false then	--�G�΂��Ă��Ȃ��Ȃ��
	   --����ł��Ȃ����H
		if proxy:IsCompleteEvent(GOD_BELIEVER_2_STATE_DEAD) == false then
			SetNpcStateFlag( proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_ANGRY );--�G�Ώ�Ԃ�
		end
	end
	
	--���I�폜�I���E���x�C�����ÍԂ���߂��Ă������ɁA�u�E���l�ƈꏏ�v�ɂ��遡
--------�e�Ď��ǉ�-----------
	--�E���l�G�Ύ��ɌĂ΂��n���h���o�^
	proxy:LuaCall(330, 1, "OnEvent_330", once);

	if proxy:IsCompleteEvent(GOD_BELIEVER_2_STATE_DEAD ) == false then--���S���Ă��Ȃ��Ȃ��
		if proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ANGRY ) == false then--�G�΂��Ă��Ȃ�
			--��330���M�k�Q�G�ΊĎ���
			proxy:OnCharacterTotalRateDamage( 330, 683, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_330", once );--�G�ΊĎ��ǉ�
			
		end
		--��331���M�k�Q���S�Ď���
		proxy:OnCharacterDead( 331, 683, "OnEvent_331", once );--��L�̏�Ԃ��������ɁA���S�Ď��ǉ�
	end
--���_�̐M�k2�֘A��-----------------------------

--[[���_�̐M�k3�֘A��]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, god_beliver3_flag_list, GOD_BELIEVER_3_STATE_STONE_PILLAR);--��Ԃ��ݒ肳��Ă��Ȃ�������A�Β��ɂ����
--------��ԏ���������-----------
	--��432�����K�[�����ÍԂ���߂��Ă������ɁA�u�E���l�ƈꏏ�v�ɂ��遡
	if	proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_STONE_PILLAR ) == true and	--�Β��ɋ��� ����
		proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR ) == true or			--�E���l�Β��ɋ��� ��
		proxy:IsCompleteEvent( URUBAIN_STATE_THANKS ) == true then				--�E���l�����ӂ��Ă��� �Ȃ��
		
		SetNpcStateFlag( proxy, param, god_beliver3_flag_list, GOD_BELIEVER_3_STATE_URU );--�E���l�ƈꏏ��
	end
	
	if proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) == true and	--�E���l���G�� ����
	   proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_ANGRY ) == false then	--�G�΂��Ă��Ȃ��Ȃ��
	   --����Ŗ���
	   if proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_DEAD ) == false then
			SetNpcStateFlag( proxy, param, god_beliver3_flag_list, GOD_BELIEVER_3_STATE_ANGRY );--�G�Ώ�Ԃ�
		end
	end
	
	if proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_DEAD ) == true then
		--��433���M�k�R���S������
		InvalidBackRead( proxy, 684 );
		proxy:SetEventFlag( 323, true );
	elseif proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_ANGRY ) == true then
		--��434���M�k�R�G�Ώ�����
		proxy:EnableLogic(684,true);--���W�b�N�n�m
		proxy:SetTeamType(684, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		
		--SetNpcStateFlag( proxy, param, god_beliver3_flag_list, GOD_BELIEVER_3_STATE_ANGRY );--�G�Ώ�Ԃ�
	end
--------�e�Ď��ǉ�-----------
	--�E���l�G�Ύ��ɌĂ΂��n���h���o�^
	proxy:LuaCall(430, 1, "OnEvent_430", once);
	--��435���M�k�R���A�C�e��������遡(��b�Ăяo��)
	proxy:LuaCall(435, 0, "OnEvent_435", once);
	
	if proxy:IsCompleteEvent(GOD_BELIEVER_3_STATE_DEAD ) == false then--���S���Ă��Ȃ��Ȃ��
		if proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_ANGRY ) == false then--�G�΂��Ă��Ȃ�
			--��430���M�k�R�G�ΊĎ���
			proxy:OnCharacterTotalRateDamage( 430, 684, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_430", once );--�G�ΊĎ��ǉ�
			
		end
		--��431���M�k�R���S�Ď���
		proxy:OnCharacterDead( 431, 684, "OnEvent_431", once );--��L�̏�Ԃ��������ɁA���S�Ď��ǉ�
	end
--���_�̐M�k3�֘A��-----------------------------

--[[����܂̃g�}�X�֘A��]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, tomasu_flag_list, TOMASU_STATE_ISNOT);--��Ԃ��ݒ肳��Ă��Ȃ���΁A�܂����Ȃ���
	
	--�g�}�X���܂����Ȃ���Ԃ�������
	if proxy:IsCompleteEvent( TOMASU_STATE_ISNOT ) == true then--�܂����Ȃ��Ȃ��
		if boss_flagCount >= 0 then--�{�X��1�̈ȏ�|������
			SetNpcStateFlag(proxy, param, tomasu_flag_list, TOMASU_STATE_WAIT );--�a������
		end
	end
	
	--�g�}�X�ɖ��̔������n������
	proxy:LuaCall( 354, 0, "OnEvent_354", everytime );
	
	if	proxy:IsCompleteEvent( TOMASU_STATE_DEAD ) == false then--����ł��Ȃ��Ȃ��
		if	proxy:IsCompleteEvent( TOMASU_STATE_ANGRY ) == false then--�G�΂ł͂Ȃ�
			--proxy:OnCharacterTotalDamage( 350, 687, 10000, 100, "OnEvent_350", once );--�_���[�W�Ď��ǉ�
			proxy:OnCharacterTotalRateDamage( 350, 687, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_350", once );
			
		end
		--��L�̏�Ԃ��������ɁA���S�Ď��ǉ�
		proxy:OnCharacterDead( 351, 687, "OnEvent_351", once );
	end
	
	if proxy:IsCompleteEvent( TOMASU_STATE_WAIT ) == true or 
	   proxy:IsCompleteEvent( TOMASU_STATE_ANGRY ) == true then
		proxy:SetEventFlag( 352, false );
	end

	
	if	proxy:IsCompleteEvent( TOMASU_STATE_DEAD ) == true or proxy:IsCompleteEvent( TOMASU_STATE_ISNOT ) == true then
		InvalidBackRead( proxy, 687 );
		proxy:SetEventFlag( 352, true );
	elseif proxy:IsCompleteEvent( TOMASU_STATE_ANGRY ) == true then
		proxy:EnableLogic(687,true);--���W�b�N�n�m
		proxy:SetTeamType(687, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		
		--SetNpcStateFlag( proxy, param, tomasu_flag_list, TOMASU_STATE_ANGRY );--�G�Ώ�Ԃ�
	end
--����܂̃g�}�X�֘A��-----------------------------

--[[�����t�B�X�g�֘A��]]-----------------------------

--���t�B�X�g�p�t���O��������
--[[�g�}�X�́A�g�p�̕ύX�ň˗�����Ȃ��ׁA�R�����g�A�E�g�B�i�ė��p�����肤��̂ŏ����Ȃ��j]]
	if proxy:IsCompleteEvent( RENDOL_STATE_DEAD ) == true then--�����h�����q������ł���
		if proxy:IsCompleteEvent( BIYO_STATE_DEAD ) == true then--�u��������ł���
			if proxy:IsCompleteEvent( ROGARN_STATE_DEAD ) == true and proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_DEAD ) == true then--���K�[���Ɩ��p�̓k������ł���
				if proxy:IsCompleteEvent( MAJO_STATE_DEAD ) == true then--����������ł���
					if proxy:IsCompleteEvent( URUBAIN_STATE_DEAD ) == true and proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_DEAD ) == true and proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_DEAD ) == true then--�E���l�Ƃ��̂Ƃ�܂�������ł���
						--if proxy:IsCompleteEvent( TOMASU_STATE_DEAD ) == true then--�g�}�X������ł���
						if proxy:IsCompleteEvent( BATTI_DEAD ) == true then--�o�b�`������ł���
							--�S���E�������ɂȂ�̂ŁA�C�������t���O�𗧂Ă�
							proxy:SetEventFlag( 8097, true );
						else--�p�b�`�������Ă���
							--�t���O����
							proxy:SetEventFlag( 8096, true );--�o�b�`�E�Q�҂�
						end
						--else--�g�}�X�������Ă���
						--	--�t���O����
						--	proxy:SetEventFlag( 8095, true );--�g�}�X�E�Q�҂�
						--end
					elseif proxy:IsCompleteEvent( URUBAIN_STATE_DEAD ) == false and proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_DEAD ) == false and proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_DEAD ) == false then--�E���l�Ƃ��̂Ƃ�܂��������Ă���
						--�t���O����
						proxy:SetEventFlag( 8094, true );--�E���l�Ƃ��̂Ƃ�܂��E�Q�҂�
					end
				else--�����������Ă���
					--�t���O����
					proxy:SetEventFlag( 8093, true );--�����E�Q�҂�
				end
			elseif proxy:IsCompleteEvent( ROGARN_STATE_DEAD ) == false or proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_DEAD ) == false then--���K�[�������p�̓k�������Ă���
				--�t���O����
				proxy:SetEventFlag( 8092, true );--���K�[���B�E�Q�҂�
			end
		else--�r���������Ă�����
			--�t���O����
			proxy:SetEventFlag( 8091, true );--�r���E�Q�҂�
		end
	else--�����h�����q�������Ă�����
		--�t���O����
		proxy:SetEventFlag( 8090, true );--�����h�����q�E�Q�҂�
	end


	SetFirstNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_NO_STAY);--��Ԃ��ݒ肳��Ă��Ȃ���΁A�܂����Ȃ���
	
	if	proxy:IsCompleteEvent( MEFIST_STATE_NO_STAY ) == true 	--�܂����Ȃ��@����
	and	proxy:IsCompleteEvent( YURUTO_STATE_DEAD ) == true --�����g�����S ����
	and proxy:IsSuccessQWC( 10600 ) == true then--QWC�����Ȃ��
		SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_STONE_PILLAR );--�Β��ɂ����
	end
	
	if	proxy:IsCompleteEvent( MEFIST_STATE_NO_STAY ) == false		--���������ɋ���@����
	and	proxy:IsCompleteEvent( MEFIST_STATE_DEAD 	) == false then	--���S���Ă��Ȃ��Ȃ��
		
		if	proxy:IsCompleteEvent( MEFIST_STATE_ANGRY ) == false then--�G�΂��Ă��Ȃ�
			--proxy:OnCharacterTotalDamage( 360, 680, 10000, 100, "OnEvent_360", once );--�_���[�W�Ď��ǉ�
			proxy:OnCharacterTotalRateDamage( 360, 680, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_360", once );
			
		end
		
		--�eNPC�E�Q�҂�--
		proxy:LuaCall( 362, 0, "OnEvent_362", everytime );--�����h�����q
		proxy:LuaCall( 363, 0, "OnEvent_363", everytime );--�r�������O����
		proxy:LuaCall( 364, 0, "OnEvent_364", everytime );--���K�[��
		proxy:LuaCall( 365, 0, "OnEvent_365", everytime );--����
		proxy:LuaCall( 366, 0, "OnEvent_366", everytime );--�E���l
		proxy:LuaCall( 367, 0, "OnEvent_367", everytime );--�g�}�X
		proxy:LuaCall( 368, 0, "OnEvent_368", everytime );--�o�b�`
		
		--���t�B�X�g�̐��z��--
		proxy:LuaCall( 369, 0, "OnEvent_369", everytime );
		
		--�eNPC�E�Q����--
		proxy:LuaCall( 400, 0, "OnEvent_400", everytime );--�����h�����q
		proxy:LuaCall( 401, 0, "OnEvent_401", everytime );--�r�������O����
		proxy:LuaCall( 402, 0, "OnEvent_402", everytime );--���K�[��
		proxy:LuaCall( 403, 0, "OnEvent_403", everytime );--����
		proxy:LuaCall( 404, 0, "OnEvent_404", everytime );--�E���l
		proxy:LuaCall( 405, 0, "OnEvent_405", everytime );--�g�}�X
		proxy:LuaCall( 406, 0, "OnEvent_406", everytime );--�o�b�`
		
		--��L�̏�Ԃ̎��ɁA���S�Ď��ǉ�
		proxy:OnCharacterDead( 361, 680, "OnEvent_361", once );
	end
	
	if	proxy:IsCompleteEvent( MEFIST_STATE_NO_STAY )	== true or
		proxy:IsCompleteEvent( MEFIST_STATE_DEAD ) 		== true then
		InvalidBackRead( proxy, 680 );
	elseif proxy:IsCompleteEvent( MEFIST_STATE_ANGRY ) == true then
		proxy:EnableLogic(680,true);--���W�b�N�n�m
		proxy:SetTeamType(680, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		
		--SetNpcStateFlag( proxy, param, mefist_flag_list, MEFIST_STATE_ANGRY );--�G�Ώ�Ԃ�
	end

--�����t�B�X�g�֘A��-----------------------------

--[[���S�܂ꂽ��m�֘A��]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_STONE_PILLAR);--��Ԃ��ݒ肳��Ă��Ȃ����A�Β��ɂ����
	
	if proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_DELETE ) == true then--�����܂��Ȃ��
		SetNpcStateFlag( proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_DEAD );--���S��
		proxy:OpeningDead( 611, true );
	end
	
	if proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_DEAD ) == false then--���S���Ă��Ȃ����
		if proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_ANGRY ) == false then--�G�΂ł͂Ȃ�
		--��384�����̏���|���ƁA���������ɂȂ遡
			if proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_STONE_PILLAR ) == true 	--�Β��ɂ���@����
			and proxy:IsCompleteEvent( 4224 ) == true then								--���̏����E���Ă���@�Ȃ��
				SetNpcStateFlag( proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_MAYBE_DELETE );--����������
				proxy:SetEventFlag( 384, true );
			end
			--proxy:OnCharacterTotalDamage( 380, 611, 10000, 100, "OnEvent_380", once );--�_���[�W�Ď��ǉ�
			proxy:OnCharacterTotalRateDamage( 380, 611, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_380", once );
			
			proxy:LuaCall( 382, 0, "OnEvent_382", everytime );
			
		--��388���S�܂ꂽ��m�ɘb����������
			if proxy:IsCompleteEvent( 388 ) == false then
				proxy:LuaCall( 388, 0, "OnEvent_388", once );
				proxy:LuaCall( 388, REMO_START , "OnEvent_388_RemoStart",once);
				proxy:LuaCall( 388, REMO_FINISH, "OnEvent_388_RemoFinish",once);
			end
		end
		--��L�̎��ɁA���S�Ď��ǉ�
		proxy:OnCharacterDead( 381, 611, "OnEvent_381", once );
	end

	if	proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_STONE_PILLAR ) == false and
		proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_ANGRY ) 		== false and
		proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_MAYBE_DELETE ) == false and
		proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_DELETE )		== false then
		InvalidBackRead( proxy, 611 );
	elseif proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_ANGRY ) == true then
		proxy:EnableLogic(611,true);--���W�b�N�n�m
		proxy:SetTeamType(611, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		
		--SetNpcStateFlag( proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_ANGRY );--�G�Ώ�Ԃ�
	end
--���S�܂ꂽ��m�֘A��-----------------------------


--[[���{�[���h�E�B���֘A��]]-----------------------------
	--������Ԃ�ݒ�
	SetFirstNpcStateFlag(proxy, param, baldwin_flag_list, BALDWIN_STATE_ISNOT);--��Ԃ��ݒ肳��Ă��Ȃ���΁A�܂����Ȃ���

	--�{�[���h�E�B�����܂����Ȃ���Ԃ�������
	if proxy:IsCompleteEvent( BALDWIN_STATE_ISNOT ) == true then--�܂����Ȃ��Ȃ��
		--if boss_flagCount >= 2 then--�{�X��2�̈ȏ�|������
		SetNpcStateFlag(proxy, param, baldwin_flag_list, BALDWIN_STATE_WORK );--�d������
		--end
	end
	
	
	if	proxy:IsCompleteEvent( BALDWIN_STATE_WORK ) 	== true or			--�d�����@��
		proxy:IsCompleteEvent( BALDWIN_STATE_HOSTILE ) 	== true then		--�Β��œG�΂Ȃ��
		
		if	proxy:IsCompleteEvent( BALDWIN_STATE_HOSTILE ) == false then--�G�΂ł͖���
			--proxy:OnCharacterTotalDamage( 390, 694, 10000, 100, "OnEvent_390", once );--�_���[�W�Ď��ǉ�
			proxy:OnCharacterTotalRateDamage( 390, 694, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_390", once );
			
		end
		
		--��L�̏�Ԃ̎��ɁA���S�Ď��ǉ�
		proxy:OnCharacterDead( 391 , 694 , "OnEvent_391" , once );
	end

	--���݂̏�Ԃ��擾
	local now_state = GetNpcStateFlag( proxy , param , baldwin_flag_list );

	if now_state == BALDWIN_STATE_HOSTILE then--�G��(�Β�)
		proxy:EnableLogic(694,true);--���W�b�N�n�m
		proxy:SetTeamType(694, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		
		--SetNpcStateFlag( proxy, param, baldwin_flag_list, BALDWIN_STATE_HOSTILE );--�G��
	elseif now_state == BALDWIN_STATE_DEAD or now_state == BALDWIN_STATE_ISNOT then--���S
		InvalidBackRead( proxy , 694 );--�{�[���h�E�B��������
		proxy:SetEventFlag( 392, true );
	end
--���{�[���h�E�B���֘A��-----------------------------

--[[�����D��֘A��]-----------------------------
	--������Ԃ�ݒ�
	SetFirstNpcStateFlag(proxy, param, monoshiri_flag_list, MONOSHIRI_STATE_ISNOT);--��Ԃ��ݒ肳��Ă��Ȃ���΁A�܂����Ȃ���
	
	--���D�肪�܂����Ȃ���Ԃ�������
	if proxy:IsCompleteEvent( MONOSHIRI_STATE_ISNOT ) == true then--�܂����Ȃ��Ȃ��
		if boss_flagCount >= 1 then--�{�X���P�̈ȏ�|������
			SetNpcStateFlag(proxy, param, monoshiri_flag_list, MONOSHIRI_STATE_BUSINESS );--��񔄂���
		end
	end

	if proxy:IsCompleteEvent(MONOSHIRI_STATE_DEAD ) == false then--���S���Ă��Ȃ��Ȃ��
		if proxy:IsCompleteEvent( MONOSHIRI_STATE_HOSTILE ) == false then--�G�΂��Ă��Ȃ�
			--proxy:OnCharacterTotalDamage( 340, 686, 10000, 100, "OnEvent_340", once );--�_���[�W�Ď��ǉ�
			proxy:OnCharacterTotalRateDamage( 340, 686, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_340", once );
			
		end
		--��L�̏�Ԃ��������ɁA���S�Ď��ǉ�
		proxy:OnCharacterDead( 341 , 686 , "OnEvent_341" , once );
	end

	--���݂̏�Ԃ��擾
	local now_state = GetNpcStateFlag( proxy , param , monoshiri_flag_list );
	
	if now_state == MONOSHIRI_STATE_BUSINESS or now_state == MONOSHIRI_STATE_HOSTILE then
		proxy:SetEventFlag( 343, false );
	end

	if now_state == MONOSHIRI_STATE_HOSTILE then--�G��(�Β�)
		proxy:EnableLogic(686,true);--���W�b�N�n�m
		proxy:SetTeamType(686, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		
		--SetNpcStateFlag( proxy, param, monoshiri_flag_list, MONOSHIRI_STATE_HOSTILE );--�G�Ώ�Ԃ�
		
	elseif now_state == MONOSHIRI_STATE_ISNOT or now_state == MONOSHIRI_STATE_DEAD  then--�܂����Ȃ�
		InvalidBackRead( proxy , 686 );--���D�薳����
		proxy:SetEventFlag( 343, true );
		
	end
	
--�����D��֘A��-----------------------------]]

--------------------------------------------------------------------------------
--[[NPC�t��OBJ�֘A]]
--------------------------------------------------------------------------------
--��180���_�̐M�k3��OBJ��
	if proxy:IsCompleteEvent( 323 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ���
		proxy:SetDrawEnable( 1160, false );
		proxy:SetColiEnable( 1160, false );
		--SFX������
		proxy:InvalidSfx( 2160, false );
		--�|�C���g���C�g������
		proxy:InvalidPointLight( 2140 );
		--�t���O���Z�b�g����
		proxy:SetEventFlag( 180, true );
	end
--��181���_�̐M�k2��OBJ��
	if proxy:IsCompleteEvent( 333 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ���
		proxy:SetDrawEnable( 1161, false );
		proxy:SetColiEnable( 1161, false );
		--SFX������
		proxy:InvalidSfx( 2161, false );
		--�|�C���g���C�g������
		proxy:InvalidPointLight( 2141 );
		--�t���O���Z�b�g����
		proxy:SetEventFlag( 181, true );
	end
--��182�����K�[����OBJ��
	if proxy:IsCompleteEvent( 224 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ���
		proxy:SetDrawEnable( 1162, false );
		proxy:SetColiEnable( 1162, false );
		--SFX������
		proxy:InvalidSfx( 2162, false );
		--�|�C���g���C�g������
		proxy:InvalidPointLight( 2142 );
		--�t���O���Z�b�g����
		proxy:SetEventFlag( 182, true );
	else
		proxy:SetEventFlag( 182, false );
	end
--��183�����p�̓k��OBJ��
	if proxy:IsCompleteEvent( 313 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ���
		proxy:SetDrawEnable( 1163, false );
		proxy:SetColiEnable( 1163, false );
		--SFX������
		proxy:InvalidSfx( 2163, false );
		--�|�C���g���C�g������
		proxy:InvalidPointLight( 2143 );
		--�t���O���Z�b�g����
		proxy:SetEventFlag( 183, true );
	end
--��184��������OBJ��
	if proxy:IsCompleteEvent( 263 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ���
		proxy:SetDrawEnable( 1164, false );
		proxy:SetColiEnable( 1164, false );
		--SFX������
		proxy:InvalidSfx( 2164, false );
		--�|�C���g���C�g������
		proxy:InvalidPointLight( 2144 );
		--�t���O���Z�b�g����
		proxy:SetEventFlag( 184, true );
	else
		proxy:SetEventFlag( 184, false );
	end
--��185���E���x�C����OBJ��
	if proxy:IsCompleteEvent( 273 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ���
		proxy:SetDrawEnable( 1165, false );
		proxy:SetColiEnable( 1165, false );
		--SFX������
		proxy:InvalidSfx( 2165, false );
		proxy:InvalidSfx( 2190, false );
		proxy:InvalidSfx( 2191, false );
		proxy:InvalidSfx( 2192, false );
		--�|�C���g���C�g������
		proxy:InvalidPointLight( 2145 );
		--�t���O���Z�b�g����
		proxy:SetEventFlag( 185, true );
	else
		proxy:SetEventFlag( 185, false );
	end
--��186���{�[���h�E�B����OBJ��
	if proxy:IsCompleteEvent( 392 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ���
		proxy:SetDrawEnable( 1166, false );
		proxy:SetColiEnable( 1166, false );
		proxy:SetDrawEnable( 1180, false );
		proxy:SetColiEnable( 1180, false );
		proxy:SetDrawEnable( 1181, false );
		proxy:SetColiEnable( 1181, false );
		proxy:SetDrawEnable( 1182, false );
		proxy:SetColiEnable( 1182, false );
		
		--SFX������
		proxy:InvalidSfx( 2166, false );
		--�|�C���g���C�g������
		proxy:InvalidPointLight( 2146 );
		--�t���O���Z�b�g����
		proxy:SetEventFlag( 186, true );
		--�}�b�v�q�b�g�̖�����
		proxy:SetDrawEnableArray( 1080,false);
		proxy:SetColiEnableArray( 1080,false);
		
	end
--��187����܂̃g�}�X��OBJ��
	if proxy:IsCompleteEvent( 352 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ���
		proxy:SetDrawEnable( 1167, false );
		proxy:SetColiEnable( 1167, false );
		
		proxy:SetDrawEnable( 1185, false );
		proxy:SetColiEnable( 1185, false );
		proxy:SetDrawEnable( 1186, false );
		proxy:SetColiEnable( 1186, false );
		proxy:SetDrawEnable( 1187, false );
		proxy:SetColiEnable( 1187, false );
		
		--SFX������
		proxy:InvalidSfx( 2167, false );
		--�|�C���g���C�g������
		proxy:InvalidPointLight( 2147 );
		--�t���O���Z�b�g����
		proxy:SetEventFlag( 187, true );
		--�}�b�v�q�b�g�̖�����
		proxy:SetDrawEnableArray( 1081,false);
		proxy:SetColiEnableArray( 1081,false);
	else
		proxy:SetEventFlag( 187, false );
	end
--��188���������OBJ��
	--�폜

--��189���r����OBJ��
	if proxy:IsCompleteEvent( 244 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ���
		proxy:SetDrawEnable( 1169, false );
		proxy:SetColiEnable( 1169, false );
		--�t���O���Z�b�g����
		proxy:SetEventFlag( 189, true );
	else
		proxy:SetEventFlag( 189, false );
	end
--��190�������h�����q��OBJ��
	if proxy:IsCompleteEvent( 232 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ���
		proxy:SetDrawEnable( 1170, false );
		proxy:SetColiEnable( 1170, false );
		--�t���O���Z�b�g����
		proxy:SetEventFlag( 190, true );
	else
		proxy:SetEventFlag( 190, false );
	end
--��191���p�b�`��OBJ��
	if proxy:IsCompleteEvent( 293 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ���
		proxy:SetDrawEnable( 1171, false );
		proxy:SetColiEnable( 1171, false );
		--�t���O���Z�b�g����
		proxy:SetEventFlag( 191, true );
	else
		proxy:SetEventFlag( 191, false );
	end
--��192�������g��OBJ��
	if proxy:IsCompleteEvent( 282 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ���
		proxy:SetDrawEnable( 1172, false );
		proxy:SetColiEnable( 1172, false );
		--�t���O���Z�b�g����
		proxy:SetEventFlag( 192, true );
	else
		proxy:SetEventFlag( 192, false );
	end
	
--[[��188���������OBJ��
	if proxy:IsCompleteEvent( 343 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ���
		proxy:SetDrawEnable( 1168, false );
		proxy:SetColiEnable( 1168, false );
		--SFX������
		proxy:InvalidSfx( 2168, false );
		--�|�C���g���C�g������
		proxy:InvalidPointLight( 2148 );
		--�t���O���Z�b�g����
		proxy:SetEventFlag( 188, true );
	else
		proxy:SetEventFlag( 188, false );
	end]]

--------------------------------------------------------------------------------
--QWC�̒l�ɂ��NPC�̉�b�ω�����p�̃t���O
--------------------------------------------------------------------------------
	--��QWC����b�p�t���O�P
	if proxy:IsSuccessQWC( 10100 ) == true then
		proxy:SetEventFlag(8040,true);--��������
	else
		proxy:SetEventFlag(8040,false);--����������
	end
	
	--��QWC����b�p�t���O�Q
	if proxy:IsSuccessQWC( 10200 ) == true then
		proxy:SetEventFlag(8041,true);--��������
	else
		proxy:SetEventFlag(8041,false);--����������
	end
	
	--��QWC����b�p�t���O3
	if proxy:IsSuccessQWC( 10300 ) == true then
		proxy:SetEventFlag(8042,true);--��������
	else
		proxy:SetEventFlag(8042,false);--����������
	end
	
	--��QWC����b�p�t���O4
	if proxy:IsSuccessQWC( 10400 ) == true then
		proxy:SetEventFlag(8043,true);--��������
	else
		proxy:SetEventFlag(8043,false);--����������
	end
	
	--��QWC����b�p�t���O5
	if proxy:IsSuccessQWC( 10500 ) == true then
		proxy:SetEventFlag(8044,true);--��������
	else
		proxy:SetEventFlag(8044,false);--����������
	end
	
--���򗳂̓P�މ�����
	if proxy:IsCompleteEvent(TYO_STATE_ESCAPE) == true then
		SetNpcStateFlag( proxy, param, tyo1_flag_list, TYO_STATE_SLEEPING );
	end
	if proxy:IsCompleteEvent(KENZOKU_STATE_ESCAPE) == true then
		SetNpcStateFlag( proxy, param, kenzoku_flag_list, KENZOKU_STATE_WARNING );
	end
	
	
	--HpMpSpMax
	--proxy:PlayerParamRecover();
	--proxy:PlayerRecover();

	--������	
	--proxy:OnKeyTime2( 9999990,"OnEvent_9999990",0.5,0,0,once);
	
	--proxy:LuaCall( 99999,0,"OnEvent_9999990",everytime);
	if proxy:IsDbgReLoad() == true then
		proxy:OnKeyTime2( 4021,"OnEvent_DbgReLoad",1.0,0,0,once);
	end
	print("Initialize_m01_00_00_00 end");
end

--[[
--�g�D���[�f�X����
function OnEvent_9999990(proxy,param)
	print("OnEvent_9999990 begin");
	--proxy:DropItemExceedWeightLimit();
		--HpMpSpMax
	--proxy:PlayerParamRecover();
	proxy:PlayerRecover();
	print("OnEvent_9999990 end");
end
]]

--�����[�h�f�o�b�O�@�����_���Ŋe�}�b�v��
function OnEvent_DbgReLoad(proxy,param)
	local rand = proxy:GetRandom( 2,6 );
	--2�`6��3�ȊO�̓u���b�N0��
	if rand ~= 3 then
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( rand, 0, 0, 0, 999 );
	elseif rand == 3 then--3�̓u���b�N1�ɔ��
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( rand, 1, 0, 0, 999 );
	end
end


--------------------------------------------------------------------------------------
--���e�G���A�փ��[�v(����)��
--------------------------------------------------------------------------------------
--��0���e�G���A�փ��[�v(����1)��
--�V�������[�v���@
function OnEvent_0(proxy, param)
	print("OnEvent_0 begin");
	
	if proxy:IsCompleteEvent( 0 ) == true then
		print("OnEvent_0 end");
		return;
	end	
	proxy:SetEventFlag( 0, true );--���[�v���j���[�I���̑��d������h�~ON
	
	local areaNum = 2;
	local blockNum = 1;
		
	--�����Ői�s�t���O�𔻒肵�ĕ\���u���b�N����ݒ肷�邱��
	if proxy:IsCompleteEvent(4103) == true then
		blockNum = 2;--����2�J��
	end
	
	if proxy:IsCompleteEvent(4252) == true then
		blockNum = 3;--����3�J��		
	end
	
	if proxy:IsCompleteEvent(4372) == true then
		blockNum = 4;--����4�J��
	end
	
	if proxy:IsCompleteEvent(4503) == true then
		blockNum = 5;--����5�J��
	end	
	
	proxy:RepeatMessage_begin();
		proxy:OnWarpMenuClose(0,"OnEvent_0_0",areaNum,blockNum,once);	
	proxy:RepeatMessage_end();
		
	print("OnEvent_0 end");
end


function OnEvent_0_0(proxy, param)
	print("OnEvent_0_0 begin");

	--���[�v���j���|�̑I�����擾
	local retval = proxy:GetWarpMenuResult();
	
	--���[�v���L�����Z�����ꂽ�ꍇ�́A�A�j�����Đ����Ȃ�
	if retval == -1 then
		OnEvent_0_2(proxy, param);
		return;
	end
	
	proxy:WarpDmy( 10000 , 1000 , 191 );
	proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ�
	
	proxy:NotNetMessage_begin();
		--���v�΂ɐG���A�j���Đ��I����
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8283 , "OnEvent_0_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_0_0 end");
end

--��0_1���v�΂ɐG���A�j���Đ��I����
function OnEvent_0_1(proxy,param)
	print("OnEvent_0_1 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ�
	
	--�ҋ@�A�j���҂��������Ȃ����̂Œ��ڌĂяo��
	OnEvent_0_2(proxy,param);
	--[[
	proxy:NotNetMessage_begin();
		--�������E�ɋA��A�j���Đ��I����
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8284 , "OnEvent_0_2" , once );
	proxy:NotNetMessage_end();
	]]
	print("OnEvent_0_1 end");
end


function OnEvent_0_2(proxy,param)
	print("OnEvent_0_2 begin");
	
	proxy:SetEventFlag( 0, false );--���[�v���j���[�I���̑��d������h�~OFF

	--���[�v���j���|�̑I�����擾
	local retval = proxy:GetWarpMenuResult();
	if retval == -1 then
		print("Warp Cancel");
		print("OnEvent_0_2 end");
		return;
	elseif retval == 0 then
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 2, 0, 0, 0, 999 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_OUJOU );
		print("Warp Block1");
		print("OnEvent_0_2 end");
		return;
	elseif retval == 1 then
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 2, 0, 0, 0, 998 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_OUJOU );
		print("Warp Block2");
		print("OnEvent_0_2 end");
		return;
	elseif retval == 2 then
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 2, 1, 0, 0, 997 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_OUJOU );
		print("Warp Block3");
		print("OnEvent_0_2 end");
		return;
	elseif retval == 3 then
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 2, 2, 0, 0, 996 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_OUJOU );
		print("Warp Block4");
		print("OnEvent_0_2 end");
		return;		
	elseif retval == 4 then
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 2, 3, 0, 0, 995 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_OUJOU );
		print("Warp Block5");
		print("OnEvent_0_2 end");
		return;
	end
	print("retval Error");
	print("OnEvent_0_2 end");
end


--------------------------------------------------------------------------------------
--���e�G���A�փ��[�v(�Í�)��
--------------------------------------------------------------------------------------
--��1���e�G���A�փ��[�v(�Í�2)��
--�V�������[�v���@
function OnEvent_1(proxy,param)
	print("OnEvent_1 begin");

	if proxy:IsCompleteEvent( 1 ) == true then
		print("OnEvent_1 end");
		return;
	end
	
	if proxy:IsCompleteEvent( 8030 ) == false then
		--����C���t�H���[�V����		
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010190, 1);
		--proxy:ShowGenDialog(10010190,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010190, 0, 6, 1001, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		print("OnEvent_1 end");
		return;
	end
	
	proxy:SetEventFlag( 1, true );--���[�v���j���[�I���̑��d������h�~ON	
	
	local areaNum = 3;
	local blockNum = 1;
		
	--�����Ői�s�t���O�𔻒肵�ĕ\���u���b�N����ݒ肷�邱��
	if proxy:IsCompleteEvent(4804) == true then
		blockNum = 2;--�Í�2�J��
	end
	
	if proxy:IsCompleteEvent(4874) == true then
		blockNum = 3;--�Í�3�J��		
	end
	
	if proxy:IsCompleteEvent(4996) == true then
		blockNum = 4;--�Í�4�J��		
	end	
	
	proxy:RepeatMessage_begin();
		proxy:OnWarpMenuClose(1,"OnEvent_1_0",areaNum,blockNum,once);	
	proxy:RepeatMessage_end();
	
	print("OnEvent_1 end");
end


function OnEvent_1_0(proxy, param)
	print("OnEvent_1_0 begin");

	--���[�v���j���|�̑I�����擾
	local retval = proxy:GetWarpMenuResult();
	
	--���[�v���L�����Z�����ꂽ�ꍇ�́A�A�j�����Đ����Ȃ�	
	if retval == -1 then
		OnEvent_1_2(proxy, param);
		return;
	end
	
	proxy:WarpDmy( 10000 , 1001 , 191 );
	proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ�
	
	proxy:NotNetMessage_begin();
		--���v�΂ɐG���A�j���Đ��I����
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8283 , "OnEvent_1_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1_0 end");
end

--��1_1���v�΂ɐG���A�j���Đ��I����
function OnEvent_1_1(proxy, param)
	print("OnEvent_1_1 begin");
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ�
	
	--�ҋ@�A�j���҂��������Ȃ����̂Œ��ڌĂяo��
	OnEvent_1_2(proxy,param);
	--[[
	proxy:NotNetMessage_begin();
		--�������E�ɋA��A�j���Đ��I����
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8284 , "OnEvent_1_2" , once );
	proxy:NotNetMessage_end();
]]
	print("OnEvent_1_1 end");
end
	

function OnEvent_1_2(proxy, param)
	print("OnEvent_1_2 begin");
	
	proxy:SetEventFlag( 1, false );--���[�v���j���[�I���̑��d������h�~OFF
	
	--2008.05.06 toyohide �ÍԂ̃A�C�e�������C�x���g�p�̃A�N�V����ID�`�F�b�N
	if proxy:IsCompleteEvent(12613) == true then
		proxy:SetEventFlag(12614,true);
	end
	
	--���[�v���j���|�̑I�����擾
	local retval = proxy:GetWarpMenuResult();
	if retval == -1 then
		print("Warp Cancel");
		print("OnEvent_1_2 end");
		return;
	elseif retval == 0 then
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 3, 1, 0, 0, 999 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FURUTORIDE );
		print("Warp Block1");
		print("OnEvent_1_2 end");
		return;
	elseif retval == 1 then
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 3, 1, 0, 0, 997 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FURUTORIDE );
		print("Warp Block2");
		print("OnEvent_1_2 end");
		return;
	elseif retval == 2 then
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 3, 2, 0, 0, 996 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FURUTORIDE );
		print("Warp Block3");
		print("OnEvent_1_2 end");
		return;	
	elseif retval == 3 then
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 3, 3, 0, 0, 995 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FURUTORIDE );
		print("Warp Block4");
		print("OnEvent_1_2 end");
		return;	
	end
	print("retval Error");	
	print("OnEvent_1_2 end");
end

--------------------------------------------------------------------------------------
--���e�G���A�փ��[�v(�S��)��
--------------------------------------------------------------------------------------
--�V�������[�v
function OnEvent_2(proxy,param)
	print("OnEvent_2 begin");

	if proxy:IsCompleteEvent( 2 ) == true then
		print("OnEvent_2 end");
		return;
	end
	
	if proxy:IsCompleteEvent( 8030 ) == false then
		--����C���t�H���[�V����		
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010190, 1);
		--proxy:ShowGenDialog(10010190,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010190, 0, 6, 1002, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		print("OnEvent_2 end");
		return;
	end
	proxy:SetEventFlag( 2, true );--���[�v���j���[�I���̑��d������h�~ON	
	
	local areaNum = 4;
	local blockNum = 1;
		
	--�����Ői�s�t���O�𔻒肵�ĕ\���u���b�N����ݒ肷�邱��
	if proxy:IsCompleteEvent(5121) == true then
		blockNum = 2;--�S��2�J��
	end
	
	if proxy:IsCompleteEvent(5261) == true then
		blockNum = 3;--�S��3�J��		
	end
	
	if proxy:IsCompleteEvent(5381) == true then
		blockNum = 4;--�S��4�J��	
	end
	
	proxy:RepeatMessage_begin();
		proxy:OnWarpMenuClose(2,"OnEvent_2_0",areaNum,blockNum,once);	
	proxy:RepeatMessage_end();
	
	print("OnEvent_2 begin");
end


function OnEvent_2_0(proxy, param)
	print("OnEvent_2_0 begin");

	--���[�v���j���|�̑I�����擾
	local retval = proxy:GetWarpMenuResult();
	
	--���[�v���L�����Z�����ꂽ�ꍇ�́A�A�j�����Đ����Ȃ�	
	if retval == -1 then
		OnEvent_2_2(proxy, param);
		return;
	end
	
	proxy:WarpDmy( 10000 , 1002 , 191 );
	proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ�
	
	proxy:NotNetMessage_begin();
		--���v�΂ɐG���A�j���Đ��I����
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8283 , "OnEvent_2_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_2_0 end");
end

--��2_1���v�΂ɐG���A�j���Đ��I����
function OnEvent_2_1(proxy, param)
	print("OnEvent_2_1 begin");	

	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ�
	
	--�ҋ@�A�j���҂��������Ȃ����̂Œ��ڌĂяo��
	OnEvent_2_2(proxy,param);
	--[[
	proxy:NotNetMessage_begin();
		--�������E�ɋA��A�j���Đ��I����
		proxy:OnChrAnimEnd( SYSTEM_WARP, 10000 , 8284 , "OnEvent_2_2" , once );
	proxy:NotNetMessage_end();
	]]
	print("OnEvent_2_1 end");
end

--��2���e�G���A�փ��[�v(�S��1)��
function OnEvent_2_2(proxy, param)
	print("OnEvent_2_2 begin");		
	
	proxy:SetEventFlag( 2, false );--���[�v���j���[�I���̑��d������h�~OFF	
	
	--���[�v���j���|�̑I�����擾
	local retval = proxy:GetWarpMenuResult();
	if retval == -1 then
		print("Warp Cancel");
		print("OnEvent_2_2 end");
		return;
	elseif retval == 0 then
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 4, 0, 0, 0, 999 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_ROUJOU );
		print("Warp Block1");
		print("OnEvent_2_2 end");
		return;
	elseif retval == 1 then
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 4, 1, 0, 0, 998 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_ROUJOU );
		print("Warp Block2");
		print("OnEvent_2_2 end");
		return;
	elseif retval == 2 then
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 4, 1, 0, 0, 997 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_ROUJOU );
		print("Warp Block3");
		print("OnEvent_2_2 end");
		return;	
	elseif retval == 3 then
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 4, 2, 0, 0, 996 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_ROUJOU );
		print("Warp Block4");
		print("OnEvent_2_2 end");
		return;	
	end
	print("retval Error");		
	print("OnEvent_2_2 end");
end



--------------------------------------------------------------------------------------
--���e�G���A�փ��[�v(�s��)��
--------------------------------------------------------------------------------------
--�V�������[�v
function OnEvent_3(proxy,param)
	print("OnEvent_3 begin");

	if proxy:IsCompleteEvent( 3 ) == true then
		print("OnEvent_3 end");
		return;
	end
	
	if proxy:IsCompleteEvent( 8030 ) == false then
		--����C���t�H���[�V����		
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010190, 1);
		--proxy:ShowGenDialog(10010190,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010190, 0, 6, 1003, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		print("OnEvent_3 end");
		return;
	end
	
	proxy:SetEventFlag( 3, true );--���[�v���j���[�I���̑��d������h�~ON	
	
	local areaNum = 5;
	local blockNum = 1;
		
	--�����Ői�s�t���O�𔻒肵�ĕ\���u���b�N����ݒ肷�邱��
	if proxy:IsCompleteEvent(5653) == true then
		blockNum = 2;--�s��2�J��
	end
	
	if proxy:IsCompleteEvent(5773) == true then
		blockNum = 3;--�s��3�J��		
	end
	
	if proxy:IsCompleteEvent(5893) == true then
		blockNum = 4;--�s��4�J��		
	end	
	
	proxy:RepeatMessage_begin();
		proxy:OnWarpMenuClose(3,"OnEvent_3_0",areaNum,blockNum,once);	
	proxy:RepeatMessage_end();	
	
	print("OnEvent_3 end");
end


function OnEvent_3_0(proxy, param)
	print("OnEvent_3_0 begin");

	--���[�v���j���|�̑I�����擾
	local retval = proxy:GetWarpMenuResult();
	
	--���[�v���L�����Z�����ꂽ�ꍇ�́A�A�j�����Đ����Ȃ�	
	if retval == -1 then
		OnEvent_3_2(proxy, param);
		return;
	end
	
	proxy:WarpDmy( 10000 , 1003 , 191 );
	proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ�
	
	proxy:NotNetMessage_begin();
		--���v�΂ɐG���A�j���Đ��I����
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8283 , "OnEvent_3_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_3_0 end");
end

--��3_1���v�΂ɐG���A�j���Đ��I����
function OnEvent_3_1(proxy, param)
	print("OnEvent_3_1 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ�
	
	--�ҋ@�A�j���҂��������Ȃ����̂Œ��ڌĂяo��
	OnEvent_3_2(proxy,param);
	--[[
	proxy:NotNetMessage_begin();
		--�������E�ɋA��A�j���Đ��I����
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8284 , "OnEvent_3_2" , once );
	proxy:NotNetMessage_end();
	]]
	print("OnEvent_3_1 end");
end

--��3���e�G���A�փ��[�v(�s��)��
function OnEvent_3_2(proxy, param)
	print("OnEvent_3_2 begin");		

	proxy:SetEventFlag( 3, false );--���[�v���j���[�I���̑��d������h�~OFF

	--���[�v���j���|�̑I�����擾
	local retval = proxy:GetWarpMenuResult();
	if retval == -1 then
		print("Warp Cancel");
		print("OnEvent_3_2 end");
		return;
	elseif retval == 0 then
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 5, 0, 0, 0, 999 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FUJOU );
		print("Warp Block1");
		print("OnEvent_3_2 end");
		return;
	elseif retval == 1 then		
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 5, 0, 0, 0, 998 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FUJOU );
		print("Warp Block2");
		print("OnEvent_3_2 end");
		return;
	elseif retval == 2 then
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 5, 1, 0, 0, 997 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FUJOU );
		print("Warp Block3");
		print("OnEvent_3_2 end");
		return;	
	elseif retval == 3 then
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 5, 2, 0, 0, 996 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FUJOU );
		print("Warp Block4");
		print("OnEvent_3_2 end");
		return;	
	end
	print("retval Error");			
	print("OnEvent_3_2 end");
end


--------------------------------------------------------------------------------------
--���e�G���A�փ��[�v(�B��)��
--------------------------------------------------------------------------------------
function OnEvent_4(proxy,param)
	print("OnEvent_4 begin");

	if proxy:IsCompleteEvent( 4 ) == true then
		print("OnEvent_4 end");
		return;
	end
	
	if proxy:IsCompleteEvent( 8030 ) == false then
		--����C���t�H���[�V����		
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010190, 1);
		--proxy:ShowGenDialog(10010190,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010190, 0, 6, 1004, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		print("OnEvent_4 end");
		return;
	end	
	
	proxy:SetEventFlag( 4, true );--���[�v���j���[�I���̑��d������h�~ON		
	
	local areaNum = 6;
	local blockNum = 1;
	
	--�����Ői�s�t���O�𔻒肵�ĕ\���u���b�N����ݒ肷�邱��
	if proxy:IsCompleteEvent(6193) == true then
		blockNum = 2;--�B��2�J��
	end
	
	if proxy:IsCompleteEvent(6283) == true then
		blockNum = 3;--�B��3�J��		
	end
	
	if proxy:IsCompleteEvent(6403) == true then
		blockNum = 4;--�B��4�J��		
	end	
	
	proxy:RepeatMessage_begin();
		proxy:OnWarpMenuClose(4,"OnEvent_4_0",areaNum,blockNum,once);	
	proxy:RepeatMessage_end();	
	
	print("OnEvent_4 end");
end


function OnEvent_4_0(proxy, param)
	print("OnEvent_4_0 begin");

	--���[�v���j���|�̑I�����擾
	local retval = proxy:GetWarpMenuResult();
	
	--���[�v���L�����Z�����ꂽ�ꍇ�́A�A�j�����Đ����Ȃ�	
	if retval == -1 then
		OnEvent_4_2(proxy, param);
		return;
	end
	
	proxy:WarpDmy( 10000 , 1004 , 191 );
	proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ�
	
	proxy:NotNetMessage_begin();
		--���v�΂ɐG���A�j���Đ��I����
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8283 , "OnEvent_4_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4_0 end");
end


--��4_1���v�΂ɐG���A�j���Đ��I����
function OnEvent_4_1(proxy, param)
	print("OnEvent_4_1 begin");		

	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ�
	
	--�ҋ@�A�j���҂��������Ȃ����̂Œ��ڌĂяo��
	OnEvent_4_2(proxy,param);
	--[[
	proxy:NotNetMessage_begin();
		--�������E�ɋA��A�j���Đ��I����
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8284 , "OnEvent_4_2" , once );
	proxy:NotNetMessage_end();
	]]
	print("OnEvent_4_1 end");
end


--��4���e�G���A�փ��[�v(�B��1)��
function OnEvent_4_2(proxy, param)
	print("OnEvent_4_2 begin");		

	proxy:SetEventFlag( 4, false );--���[�v���j���[�I���̑��d������h�~OFF

	--���[�v���j���|�̑I�����擾
	local retval = proxy:GetWarpMenuResult();
	if retval == -1 then
		print("Warp Cancel");
		print("OnEvent_4_2 end");
		return;
	elseif retval == 0 then
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 6, 0, 0, 0, 999 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_KOUDOU );
		print("Warp Block1");
		print("OnEvent_4_2 end");
		return;
	elseif retval == 1 then
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 6, 0, 0, 0, 998 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_KOUDOU );
		print("Warp Block2");
		print("OnEvent_4_2 end");
		return;
	elseif retval == 2 then
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 6, 1, 0, 0, 997 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_KOUDOU );
		print("Warp Block3");
		print("OnEvent_4_2 end");
		return;	
	elseif retval == 3 then
		--���S�񕜗v��
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 6, 2, 0, 0, 996 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_KOUDOU );
		print("Warp Block4");
		print("OnEvent_4_2 end");
		return;
	end
	print("retval Error");	
	print("OnEvent_4_2 end");
end


--
--------------------------------------------------------------------------------------
--���e�G���A�փ��[�v(�k��)��
--------------------------------------------------------------------------------------
function OnEvent_5(proxy,param)
	print("OnEvent_5 begin");

	if proxy:IsCompleteEvent( 5 ) == true then
		print("OnEvent_5 end");
		return;
	end
	
	local bflag = false;
	if bflag == false then
		--����C���t�H���[�V����		
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010190, 1);
		--proxy:ShowGenDialog(10010190,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010190, 0, 6, 1005, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		print("OnEvent_5 end");
		--�k���͕��󂪉����܂���
		return;
	end
	proxy:SetEventFlag( 5, true );--���[�v���j���[�I���̑��d������h�~ON		
	
	local areaNum = 7;
	local blockNum = 1;
	
	--�����Ői�s�t���O�𔻒肵�ĕ\���u���b�N����ݒ肷�邱��
	--[[
	if proxy:IsCompleteEvent(6193) == true then
		blockNum = 2;--�B��2�J��
	end
	
	if proxy:IsCompleteEvent(6283) == true then
		blockNum = 3;--�B��3�J��		
	end
	
	if proxy:IsCompleteEvent(6403) == true then
		blockNum = 4;--�B��4�J��		
	end	
	]]
	proxy:RepeatMessage_begin();
		proxy:OnWarpMenuClose(5,"OnEvent_5_0",areaNum,blockNum,once);	
	proxy:RepeatMessage_end();	
	
	print("OnEvent_5 end");
end


function OnEvent_5_0(proxy, param)
	print("OnEvent_5_0 begin");

	--���[�v���j���|�̑I�����擾
	local retval = proxy:GetWarpMenuResult();
	
	--���[�v���L�����Z�����ꂽ�ꍇ�́A�A�j�����Đ����Ȃ�	
	if retval == -1 then
		OnEvent_5_2(proxy, param);
		return;
	end
	
	--proxy:WarpDmy( 10000 , 1004 , 191 );
	proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ�
	
	proxy:NotNetMessage_begin();
		--���v�΂ɐG���A�j���Đ��I����
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8283 , "OnEvent_5_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_5_0 end");
end


--��5_1���v�΂ɐG���A�j���Đ��I����
function OnEvent_5_1(proxy, param)
	print("OnEvent_5_1 begin");		

	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ�
	
	--�ҋ@�A�j���҂��������Ȃ����̂Œ��ڌĂяo��
	OnEvent_5_2(proxy,param);
	--[[
	proxy:NotNetMessage_begin();
		--�������E�ɋA��A�j���Đ��I����
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8284 , "OnEvent_4_2" , once );
	proxy:NotNetMessage_end();
	]]
	print("OnEvent_5_1 end");
end


--��4���e�G���A�փ��[�v(�k��)��
function OnEvent_5_2(proxy, param)
	print("OnEvent_5_2 begin");		

	proxy:SetEventFlag( 5, false );--���[�v���j���[�I���̑��d������h�~OFF

	--���[�v���j���|�̑I�����擾
	local retval = proxy:GetWarpMenuResult();
	if retval == -1 then
		print("Warp Cancel");
		print("OnEvent_5_2 end");
		return;
	elseif retval == 0 then
		--���S�񕜗v��
		--proxy:RequestFullRecover();
		--proxy:WarpNextStage( 6, 0, 0, 0, 999 );
		--SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_HOKUGEN );
		print("Warp Block1");
		print("OnEvent_5_2 end");
		return;
	elseif retval == 1 then
		--���S�񕜗v��
		--proxy:RequestFullRecover();
		--proxy:WarpNextStage( 6, 0, 0, 0, 998 );
		--SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_HOKUGEN );
		print("Warp Block2");
		print("OnEvent_5_2 end");
		return;
	elseif retval == 2 then
		--���S�񕜗v��
		--proxy:RequestFullRecover();
		--proxy:WarpNextStage( 6, 0, 0, 0, 997 );
		--SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_HOKUGEN );
		print("Warp Block3");
		print("OnEvent_5_2 end");
		return;	
	elseif retval == 3 then
		--���S�񕜗v��
		--proxy:RequestFullRecover();
		--proxy:WarpNextStage( 6, 0, 0, 0, 996 );
		--SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_HOKUGEN );
		print("Warp Block4");
		print("OnEvent_5_2 end");
		return;
	end
	print("retval Error");	
	print("OnEvent_5_2 end");
end
--

--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ20
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m01_00_00_00(proxy, param)
	print("PlayerDeath_m01_00_00_00");
	
	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m01_00_00_00);
	proxy:SetEventFlag( 20 , 1 );
	
	print("PlayerDeath_m01_00_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m01_00_00_00(proxy,param)
	print("PlayerRevive_m01_00_00_00");
	
	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m01_00_00_00);
	proxy:SetEventFlag( 20 , 0 );
	
	print("PlayerRevive_m01_00_00_00");
end



--------------------------------------------------------------------------------------
--��30���}�b�v�Љ�|�����Đ���
--------------------------------------------------------------------------------------

function OnEvent_30(proxy , param)
	print("OnEvent_30 begin");

	--���}�b�v�Љ�|�����Đ�
	proxy:RequestRemo(00010,REMO_FLAG,30,1);
	proxy:SetEventFlag( 30, true );

	print("OnEvent_30 end");
end


--���|�����Đ��J�n(�t�F�[�h�I��)
function OnEvent_30_RemoStart(proxy,param)
	print("OnEvent_30_RemoStart begin");
	--Map�������ꎞ�I�ɖ�����
	proxy:InvalidSfx( 2110 , false );
	print("OnEvent_30_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��)
function OnEvent_30_RemoFinish(proxy , param)
	print("OnEvent_30_RemoFinish begin");
	--�Β�BGM���Đ�
	PlayBGM_SEKITYUU(proxy, param);
	print("�Β�BGM�Đ�");
	
	--PC�̏����ʒu���ŏ������ύX
	proxy:Warp( 10000 , 1205 );
	proxy:CamReset( 10000 , true );--�J�������Z�b�g
	
	if proxy:GetClearCount() == 0 then		
		proxy:OnKeyTime2( 32 , "OnEvent_32",0.1,0,0,once);
	else
		--2���ڈȍ~�A�N���A�A�C�e���t���OON
		if proxy:IsClearItem() == true then
			if proxy:GetClearState() == CLEAR_STATE_GOODEND then
				proxy:OnKeyTime2( 32,"OnEvent_GoodSoul",0.0,0,10,once);
			elseif proxy:GetClearState() == CLEAR_STATE_BADEND then
				proxy:OnKeyTime2( 32,"OnEvent_BadSoul",0.0,0,20,once);
			end		
		end
	end
	
	--�������SFX�Đ�
	proxy:ValidSfx( 2110 );
	print("OnEvent_30_RemoFinish end");
end


--------------------------------------------------------------------------------------
--��31�������|�����Đ���
--------------------------------------------------------------------------------------
function OnEvent_31(proxy , param)
	print("OnEvent_31 begin");

	--���}�b�v�Љ�|�����Đ�
	proxy:RequestRemo(000015,REMO_FLAG,31,1);
	proxy:SetEventFlag( 31, true );

	print("OnEvent_31 end");
end


--���|�����Đ��J�n(�t�F�[�h�I��)
function OnEvent_31_RemoStart(proxy,param)
	print("OnEvent_31_RemoStart begin");	
	print("OnEvent_31_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��)
function OnEvent_31_RemoFinish(proxy , param)
	print("OnEvent_31_RemoFinish begin");
	--�Β�BGM���Đ�
	PlayBGM_SEKITYUU(proxy, param);
	print("�Β�BGM�Đ�");
	
	--�q���C�����W���킹
	proxy:Warp( 615 , 2206 );
	proxy:SetSpStayAndDamageAnimId( 615 , -1 , -1 );

	print("OnEvent_31_RemoFinish end");
end


--------------------------------------------------------------------------------------
--��39�������w�J���|������
--------------------------------------------------------------------------------------
function OnEvent_39(proxy,param)
	--�������w�J���|����
	proxy:RequestRemo(000006,REMO_FLAG,39,1);
	proxy:SetEventFlag( 39, true );
end

--���|�����Đ��J�n(�t�F�[�h�I��)
function OnEvent_39_RemoStart(proxy,param)
	print("OnEvent_39_RemoStart begin");	
	print("OnEvent_39_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��)
function OnEvent_39_RemoFinish(proxy , param)
	print("OnEvent_39_RemoFinish begin");
	--�Β�BGM���Đ�
	PlayBGM_SEKITYUU(proxy, param);
	print("�Β�BGM�Đ�");
		
	proxy:SetDrawEnable( 1190 , false );--��OBJ�\��OFF
	proxy:SetColiEnable( 1190 , false );--��OBJ�A�^��OFF
		
	proxy:SetDrawEnable( 1200 , false );--�����w1OBJ�\��OFF
	proxy:SetColiEnable( 1200 , false );--�����w1OBJ�A�^��OFF
	proxy:SetDrawEnable( 1201 , false );--�����w2OBJ�\��OFF
	proxy:SetColiEnable( 1201 , false );--�����w2OBJ�A�^��OFF
	proxy:SetDrawEnable( 1202 , false );--�����w3OBJ�\��OFF
	proxy:SetColiEnable( 1202 , false );--�����w3OBJ�A�^��OFF
	proxy:SetDrawEnable( 1203 , false );--�����w4OBJ�\��OFF
	proxy:SetColiEnable( 1203 , false );--�����w4OBJ�A�^��OFF	
	
	proxy:SetEventResponsedNavimeshFlag_Disable();

	print("OnEvent_39_RemoFinish end");
end


--------------------------------------------------------------------------------------
--�C���t�H�\��:���S��1��32
--------------------------------------------------------------------------------------
function OnEvent_32(proxy,param)
	print("OnEvent_32 begin");
	--Display_InfomationMenu_2(proxy, 0, -1, 30, 84000100, 1, -1, 30, 84000101, 7);
	proxy:RequestOpenBriefingMsgPlus( 84000101 , true );
	--Lua_PauseTutorial(proxy);	
	proxy:OnKeyTime2( 32 , "OnEvent_32_1",0.1,0,1,once);	
	print("OnEvent_32 end");
end

--�C���t�H���j���[�̕\�������҂�
function OnEvent_32_1(proxy,param)
	print("OnEvent_32_1 begin");
	proxy:OnRegistFunc( 32 , "Check_32_2","OnEvent_32_2",1,once);
	--proxy:SetEventFlag( 32 , true );	
	print("OnEvent_32_1 end");
end

--�`�F�b�N
function Check_32_2(proxy)
	if proxy:IsShowMenu_BriefingMsg() == true then
		return false;
	end
	return true;
end

--�C���t�H���j���[���������玟�̃C���t�H���o��
function OnEvent_32_2(proxy,param)
	print("OnEvent_32_2 begin");
	proxy:OnKeyTime2( 33 , "OnEvent_33",0.1,0,0,once);
	print("OnEvent_32_2 end");
end

--���S��Q�@
function OnEvent_33(proxy,param)
	print("OnEvent_33 begin");
	--Display_InfomationMenu_2(proxy, 0, -1, 30, 84000110, 1, -1, 30, 84000111, 6);
	proxy:RequestOpenBriefingMsgPlus( 84000111 , true );
	proxy:OnKeyTime2( 33 , "OnEvent_33_1", 0.1 , 0 , 20, once);
	--Lua_PauseTutorial(proxy);	
	--proxy:SetEventFlag( 33 , true );
	print("OnEvent_33 end");
end

--�҂�
function OnEvent_33_1(proxy,param)
	print("OnEvent_33_1 begin");
	proxy:OnRegistFunc( 37 , "Check_37","OnEvent_37",0,once);
	print("OnEvent_33_1 end");
end

--���j���[������̑҂�
function Check_37(proxy)
	if proxy:IsShowMenu_BriefingMsg() == true then
		return false;
	end
	return true;
end

--�C���t�H���j���[���������烏�[�v�A�C�e������
function OnEvent_37(proxy,param)
	print("OnEvent_37 begin");
	proxy:GetRateItem( 10860 );
	proxy:SetEventFlag( 37 , true );
	print("OnEvent_37 end");
end

--GOOD�N���A�\�E���擾
function OnEvent_GoodSoul(proxy,param)
	print("OnEvent_GoodSoul begin");
	proxy:SetClearItem(false);
	proxy:GetRateItem( 10900 );	
	print("OnEvent_GoodSoul end");
end

--BAD�N���A�\�E���擾
function OnEvent_BadSoul(proxy,param)
	print("OnEvent_BadSoul begin");
	proxy:SetClearItem(false);
	proxy:GetRateItem( 10901 );	
	if proxy:IsInventoryEquip(TYPE_GOODS,9996) == false then	
		proxy:GetRateItem( 10902 );	
	end
	print("OnEvent_BadSoul end");
end

--------------------------------------------------------------------------------------
--��40�����X�{�X�����ɍs���܂ł̔�э~��A�|������
--------------------------------------------------------------------------------------

function OnEvent_40(proxy , param)
	print("OnEvent_40 begin");

	if proxy:IsCompleteEvent( 40 ) == true then
		print("OnEvent_40 end");
		return;
	end
	
	--���݂̏�Ԃ��擾
	local now_state = GetNpcStateFlag( proxy , param , heroine_flag_list );
	
	--��Ԃ��u�������������v�łȂ��ꍇ�A���������B
	if now_state ~= HEROINE_STATE_WANT_TO_SETTLE then
		print("OnEvent_40 end");
		return;
	end
	
	if proxy:IsLand( 10000 ) == false then
		return;
	end
	
	--�|�����O�ɐΒ���BGM�̒�~
	proxy:StopPointSE( 0 );--0�̃X���b�g��BGM���ݒ肳��Ă����
	print("--�Β�BGM��~--");
	
	--�����X�{�X�����ɍs���܂ł̔�э~��A�|����
	proxy:RequestRemo(00001,REMO_FLAG,40,10	);
	print("OnEvent_40 end");
end


--���|�����Đ��J�n(�t�F�[�h�I��)
function OnEvent_40_RemoStart(proxy,param)
	print("OnEvent_40_RemoStart begin");
	proxy:Warp( 10000 , 2000 );--PC������̈ʒu�փ��[�v
	--proxy:SetHitInfo( 10000 , 1050 );
	proxy:CamReset( 10000 , true );--�J�������Z�b�g
	if proxy:IsAlive( 10000 ) == true then
		proxy:PlayerChrResetAnimation_RemoOnly(10000);
		proxy:ChrResetRequest(10000);
	end
	print("OnEvent_40_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��)
function OnEvent_40_RemoFinish(proxy , param)
	print("OnEvent_40_RemoFinish begin");	
	
	--proxy:Warp( 10000 , 2000 );--PC������̈ʒu�փ��[�v
	proxy:SetHitInfo( 10000 , 1050 );
	--proxy:CamReset( 10000 , true );--�J�������Z�b�g	
	
	LuaFunc_ForceOmission(proxy,615);
	proxy:SetAlwayEnableBackread_forEvent( 615 , true );
	proxy:SetSpStayAndDamageAnimId( 615 ,-1,-1);
	--�q���C���̋����o�b�N���[�h�𖳌���
	proxy:OnKeyTime2( 40,"OnEvent_40_1",0.1,0,1,once);
	proxy:Warp( 615 , 2001 );--�q���C��������̈ʒu�փ��[�v
	proxy:ChangeInitPosAng( 615 , 2001 );--�A�ҏꏊ���X�V
	
	--�q���C���̏�ԃt���O���u���čs���܂��v�ɂ���
	SetNpcStateFlag(proxy, param, heroine_flag_list, HEROINE_STATE_WITH_A_FUTURE );

	--�q���C���̃��W�b�N�؂�ւ� ���u�F��H�v
	proxy:SendEventRequest( 615 , 0 , AI_EVENT_GRACE);
	proxy:ResetThink( 615 );	
	
	proxy:DeleteEvent( 40 );--everytime�Ȃ̂ŏ���
	
	proxy:SetEventFlag( 40,true);
	
	--�v�Ό�����
	proxy:SetColiEnable(1140,true);
	proxy:SetDrawEnable(1140,true);	
	proxy:SetColiEnable(1141,true);
	proxy:SetDrawEnable(1141,true);	

	--proxy:TreasureDispModeChange2( 1140 , true ,KANAME_SFX);
	proxy:TreasureDispModeChange2( 1141 , true ,KANAME_SFX);	
	--proxy:TreasureDispModeChange2( 1145 , true ,KANAME_SFX);
	proxy:TreasureDispModeChange2( 1146 , true ,KANAME_SFX);
	
	SingleReset(proxy,42);
	SingleReset(proxy,43);
	proxy:OnDistanceAction( 42,10000,1140,"OnEvent_42",WarpGimmickDist_A,HELPID_GO_TO_SEKITYUU,0,WarpGimmickAngle_B,everytime);
	proxy:OnDistanceAction( 43,10000,1145,"OnEvent_43",WarpGimmickDist_A,HELPID_GO_TO_SEKITYUU,0,WarpGimmickAngle_B,everytime);		
	
	OnEvent_60_RemoFinish(proxy,param);
	--proxy:SetEventFlag( 60 , true );
	
	print("OnEvent_40_RemoFinish end");
end

function OnEvent_40_1(proxy,param)
	print("OnEvent_40_1 begin");
	LuaFunc_NormalOmission(proxy,615);
	proxy:SetAlwayEnableBackread_forEvent( 615 , false );
	print("OnEvent_40_1 end");
end

--------------------------------------------------------------------------------------
--��60���g�U�̃��m�����ݍ��ރ|������
--------------------------------------------------------------------------------------

function OnEvent_60(proxy , param)
	print("OnEvent_60 begin");

	--���g�U�̃��m�����ݍ��ރ|����
	proxy:RequestRemo(2,REMO_FLAG,60,1);
	proxy:SetEventFlag( 60, true );

	print("OnEvent_60 end");
end


--���|�����Đ��J�n(�t�F�[�h�I��)
function OnEvent_60_RemoStart(proxy,param)
	print("OnEvent_60_RemoStart begin");
	print("OnEvent_60_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��)
function OnEvent_60_RemoFinish(proxy , param)
	print("OnEvent_60_RemoFinish begin");
	
	--�}�b�v�p�[�c��L����
	proxy:SetDrawEnableArray( 1020 , true );
	proxy:SetColiEnableArray( 1020 , true );
	
	proxy:SetDrawEnableArray( 1121 , true );
	proxy:SetColiEnableArray( 1121 , true );
	
	--�}�b�v�p�[�c�𖳌�������
	proxy:SetDrawEnableArray( 1120 , false );
	proxy:SetColiEnableArray( 1120 , false );
	
	--�؂̃I�u�W�F��L��������
	local first_id = 1030;
	local last_id  = 1058;
	local now_id   = first_id;
	local num      = last_id - first_id + 1;
	
	for i=1 , num , 1 do
		proxy:SetDrawEnable( now_id , true );--�\��ON
		proxy:SetColiEnable( now_id , true );--������ON
		now_id = now_id + 1;
	end
	
	--proxy:SetDrawEnable( 1190 , false );--�ǉ�OBJ�\��OFF
	--proxy:SetColiEnable( 1190 , false );--�ǉ�OBJ�A�^��OFF
		
	--�Ή�����G��L����
	--�폜
	
	--�{�X��L����
	ValidCharactor( proxy , 821 );
	
	--OBJ�𖳌���
	proxy:SetDrawEnable( 1100 , false );
	proxy:SetColiEnable( 1100 , false );
	
	--OBJ�𖳌���
	--proxy:SetDrawEnable( 1101 , false );
	--proxy:SetColiEnable( 1101 , false );
	
	--SFX��L����
	proxy:ValidSfx( 1110 );
	
	print("OnEvent_60_RemoFinish end");
end




--------------------------------------------------------------------------------------
--��70�����X�{�X��|������A�|�������Đ���
--------------------------------------------------------------------------------------

function OnEvent_70(proxy , param)
	print("OnEvent_70 begin");
	--�A�C�e������(���IID10900)	
	--�b��DS�p�~
	--proxy:GetRateItem( 10900 );
	--�\�E���u�����h�p�~
	--proxy:GetRateItem(10730);--�A�C�e��	
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc( 451 , "Check_451","OnEvent_451", 1 , once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 70, true );
	
	--�\�E���u�����h�����ĂȂ�
	if proxy:IsCompleteEvent( 141 ) == false then			
		--���ׂ�C�x���g���͓̂������܂��A���ׂ��l�̓z�X�gor�V���O���v���C���[�ł�
		--proxy:NotNetMessage_begin();		
			
			proxy:OnKeyTime2( 141 , "OnEvent_141_WAIT",9.5,0,0,once);
			
			proxy:ValidSfx( 1131 );			
			--proxy:SetRarity( 1130, 10104 );
		--proxy:NotNetMessage_end();
	else
		proxy:SetDrawEnable( 1130 , false );--�ЂƂ܂��`�悾��OFF
		proxy:SetColiEnable( 1130 , false );			
		proxy:InvalidSfx( 1131 ,true );
	end

	print("OnEvent_70 end");
end



--------------------------------------------------------------------------------------
--��450�����o�I���҂���
--------------------------------------------------------------------------------------
--��b�̏I���҂�
function Check_451(proxy)
	if proxy:IsCompleteEvent( 9054 ) == false then
		return false;
	end
	return true;
end

--�e�L�X�g���o�Ăяo��
function OnEvent_451(proxy,param)
	proxy:CustomLuaCallStart( 450 , 821 );
end

----------------------------------------------------------------------------------------------------------------
--��450���Β��p�u���b�N�N���A��
----------------------------------------------------------------------------------------------------------------
function OnEvent_450(proxy,param)	
	--�����̂�
	if param:IsNetMessage() == true then
		return;
	end	
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	print("OnEvent_450 begin");	
	SekiClearBossId = -1;
	SekiClearBossId = param:GetParam2();
	
	--SOS�T�C������x�N���A
	proxy:ClearSosSign();	
	--�Z�b�V���������L��
	proxy:SetClearSesiionCount();	
	--�{�X�Q�[�W���N���A
	proxy:ClearBossGauge();	
	--�N���A�{�[�i�X���v�Z
	proxy:SetClearBonus(SekiClearBossId);
	
	--������
	if proxy:IsLivePlayer() == true then		
		proxy:SetTextEffect(TEXT_TYPE_KillDemon);
		proxy:NotNetMessage_begin();
			proxy:OnTextEffectEnd( 450 , TEXT_TYPE_KillDemon ,"OnEvent_450_effectEnd");
		proxy:NotNetMessage_end();
	--�O���C��
	elseif proxy:IsGreyGhost() == true then		
		proxy:SetTextEffect(TEXT_TYPE_KillDemon);
		proxy:SetTextEffect(TEXT_TYPE_Revival);
		proxy:OnTextEffectEnd( 450 , TEXT_TYPE_Revival ,"OnEvent_450_effectEnd");
		proxy:SetReviveWait( true );--�����҂���ԃt���O�����Ă���(�O���C�Ŕ������Ă��܂������̈�)
	end	
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 450, "OnEvent_450_1", 5.0, 0, 2, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_450 end");
end

function OnEvent_450_1(proxy,param)
	print("OnEvent_450_1 begin");
	
	if proxy:IsInParty() == true then
		print("ERROR! PT��g��ł���");
	else
		if proxy:IsLivePlayer() == true then
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 450, "Clear_450", 3.0, 0, 6, once );
			proxy:NotNetMessage_end();			
		--�O���C��
		elseif proxy:IsGreyGhost() == true then
			--�߂ł�������
			proxy:RevivePlayer();
			proxy:SetReviveWait( false );--�����҂���ԃt���O�����낵�Ă���
			--��������̂Ńy�i���e�B�Ō��������p�����[�^�����ɖ߂�(�ő�l�̂�)
			proxy:EraseEventSpecialEffect( 10000, 101 );
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 450, "Clear_450", 6.0, 0, 6, once );
			proxy:NotNetMessage_end();
		end		
	end
	print("OnEvent_450_1 end");
end

function Clear_450(proxy,param)
	print("Clear_450 begin");
	proxy:GetSoloClearBonus(SekiClearBossId);
	print("Clear_450 end");
end

function OnEvent_450_effectEnd(proxy,param)
	print("OnEvent_450_effectEnd begin");
	proxy:SetEventFlag( 450 , true );
	print("OnEvent_450_effectEnd end");
end

--------------------------------------------------------------------------------------
--��71�����X�{�X��|������A�|�������Đ���
--------------------------------------------------------------------------------------
function OnEvent_71(proxy , param)
	--��b�t���O�������ĂȂ������疳��
	if proxy:IsCompleteEvent( 9054 ) == false then
		return;
	end
	
	--�|�����Đ��������Ă����疳��
	if proxy:IsCompleteEvent( 71 ) == true then
		return;
	end
	
	--���o�I�����ĂȂ���Ζ���
	if proxy:IsCompleteEvent( 450 ) == false then
		return;
	end
	print("OnEvent_71 begin");
	
	--proxy:InvalidSfx( 1991, true );
	
	--�{�X��BGM�̍Đ����Ƃ߂�
	proxy:StopPointSE( 1 );

	--���q���C�����F��|����
	proxy:RequestRemo(3,REMO_FLAG,71,1);
	proxy:SetEventFlag( 71, true );

	print("OnEvent_71 end");
end


--���|�����Đ��J�n(�t�F�[�h�I��)
function OnEvent_71_RemoStart(proxy,param)
	print("OnEvent_71_RemoStart begin");
	
	proxy:InvalidSfx( 1991, false );
	
	--�{�X(821)�𖳌�������
	--InvalidCharactor( proxy, 821 );

	print("OnEvent_71_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��)
function OnEvent_71_RemoFinish(proxy , param)
	print("OnEvent_71_RemoFinish begin");
	
	--�����h�����̉�b���{�^���A�ł��܂������ꍇ�̉��}���u�I�ȁH
	if proxy:IsCompleteEvent( 70 ) == false then
		OnEvent_70(proxy, param);	--OnEvent_70���Ăяo��
	end
	
	--�Ώۂ�SFX��\��������
	proxy:ValidSfx( 1991 );
	
	--�q���C�����ړ�������
	LuaFunc_ForceOmission(proxy,615);	
	proxy:SetAlwayEnableBackread_forEvent( 615 , true );	
	proxy:SetDisableGravity( 615,false );
	--�q���C���̋����o�b�N���[�h�𖳌���
	proxy:OnKeyTime2( 40,"OnEvent_40_1",0.2,0,1,once);
	
	--proxy:Warp( 615 , 2002 );--�q���C��������̈ʒu�Ƀ��[�v
	--proxy:RecoveryHeroin();
	proxy:SetAlive( 615 ,1.0);
	proxy:SetHp( 615 , 1.0 );--�q���C��HP�S��
	proxy:WarpRestart( 615, 2002 );
	proxy:PlayerChrResetAnimation_RemoOnly( 615 );--�֒f�̕�Ԑ؂�	
	proxy:EnableLogic( 615 , false );--���W�b�NOFF
	
	proxy:SetEventCommand( 615 , 70 );--EzState�ɐ���ԍ�(�F��)�𑗂�
	
	SetNpcStateFlag(proxy, param, heroine_flag_list, HEROINE_STATE_PRAYER );--�q���C����Ԃ��u�F��v��
	
	--�Ή�����G���폜(���S������)
	--�폜
	
	proxy:OnDistanceAction( 44,10000,1140,"OnEvent_44",WarpGimmickDist_A,HELPID_GO_TO_SEKITYUU,0,WarpGimmickAngle_B,everytime);

	--�G���f�B���O�p�̊Ď���ǉ�
	
	--���q���C���ւ̃_���[�W�Ď�(�G���f�B���O1�p)��Bad End
	--proxy:OnSimpleDamage( 80 , 615 , 10000 , "OnEvent_80" , once );
	proxy:OnKeyTime2( 80 , "OnEvent_71_wait",0.1,0,0,once);	
	
	proxy:NotNetMessage_begin();
		--�|�����J�n�t�F�[�h��ɌĂ΂��n���h��
		proxy:LuaCall(80,REMO_START,"OnEvent_80_RemoStart",once);
		--�|�����I����ɌĂ΂��n���h��
		proxy:LuaCall(80,REMO_FINISH,"OnEvent_80_RemoFinish",once);
	proxy:NotNetMessage_end();
	
	--���̈�Ď���ǉ�(�G���f�B���O2�p)��Good End
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	proxy:OnPlayerActionInRegionAttribute( 81, 2010, "OnEvent_81", 10010405, possible_chr_type, once );
	
	proxy:NotNetMessage_begin();
		--�|�����J�n�t�F�[�h��ɌĂ΂��n���h��
		proxy:LuaCall(81,REMO_START,"OnEvent_81_RemoStart",once);
		--�|�����I����ɌĂ΂��n���h��
		proxy:LuaCall(81,REMO_FINISH,"OnEvent_81_RemoFinish",once);
	proxy:NotNetMessage_end();
	
	proxy:Warp( 10000 , 2083);	
	proxy:CamReset( 10000 , true );--�J�������Z�b�g
	
	if proxy:IsAlive( 10000 ) == true then
		proxy:PlayerChrResetAnimation_RemoOnly(10000);
		proxy:ChrResetRequest(10000);
	end	
	--�v��Ȃ��Ȃ����̂ō폜
	proxy:DeleteEvent( 71 );
	
	print("OnEvent_71_RemoFinish end");
end

function OnEvent_71_wait(proxy,param)
	print("OnEvent_71_wait begin");
	proxy:OnCharacterDead( 80 , 615 , "OnEvent_80",once);
	proxy:SetEventFlag( 75 , true );
	print("OnEvent_71_wait end");
end



--------------------------------------------------------------------------------------
--��80���G���f�B���O�|����1��Bad End
--------------------------------------------------------------------------------------

function OnEvent_80(proxy , param)
	print("OnEvent_80 begin");

	proxy:InvalidSfx( 1991, true );
	
	--�N���C�A���g�ł͂Ȃ��������@or�@�O���C=�@�z�X�gor�\��
	if proxy:IsClient() == false then
		--�N���A��Ԑݒ�A�N���A������Z
		proxy:SetClearState( CLEAR_STATE_BADEND );
		proxy:AddClearCount();
		--�R�R�ŃN���A�p�̏������������Ăяo�����H
		LastRemoveEquip(proxy);
		proxy:OnEndFlow( 80,"OnEvent_80_1");
		proxy:OnKeyTime2( 80 , "OnEvent_80_wait", 3.0 , 0 , 1 , once );
	end
	--�����C�x���g�폜
	proxy:DeleteEvent( 111 );
	proxy:DeleteEvent( 81 );
	print("OnEvent_80 end");
end

function OnEvent_80_wait(proxy,param)
	--�A�j���҂��̑���̕b���o��
	BAD_END_WAIT = true;
end

--�I����������
function OnEvent_80_1(proxy,param)
	print("OnEvent_80_1 begin");
	proxy:OnRegistFunc( 80 , "Check_80_2","OnEvent_80_2",1,once);
	--�����t���O�������ς݂Ȃ̂Ńt���O��ON�ɂ��Ȃ�
	print("OnEvent_80_1 begin");
end

--�t���O�҂�
function Check_80_2(proxy)
	if BAD_END_WAIT == true then
		return true;
	end
	return false;
end

--�|��������
function OnEvent_80_2(proxy,param)
	--���G���f�B���O�|����1
	proxy:RequestRemo(4,REMO_FLAG,80,1);
end

--���|�����Đ��J�n(�t�F�[�h�I��)
function OnEvent_80_RemoStart(proxy,param)
	print("OnEvent_80_RemoStart begin");
	print("OnEvent_80_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��)
function OnEvent_80_RemoFinish(proxy , param)
	print("OnEvent_80_RemoFinish begin");
	
	--[[�Q�[���N���A����]]
	print("Bad Ending");	
	
	--���[�r�[�Đ��v��
	--proxy:RequestPlayMoviePlus(MOVIE_ENDING_BAD,true);
	--���[�r�[�Đ��̊Ď�
	--proxy:OnRegistFunc(80,"Check_80","OnEvent_80_2",1,once);
	proxy:RequestEnding();--�G���f�B���O�v��
	
	print("OnEvent_80_RemoFinish end");
end
	
--[[
--���[�r�[�Đ����̊Ď������̂��H
function Check_80(proxy,param)
	if proxy:IsPlayMovie() == true then
		return false;
	end	
	return true;
end
	
--Bad���[���I����
function OnEvent_80_2(proxy,param)
	print("OnEvent_80_2 begin");
	--�Β��ɓ��蒼��
	proxy:WarpNextStage( 1, 0, 0, 0, -1 );
	print("OnEvent_80_2 end");
end
]]


--------------------------------------------------------------------------------------
--��81���G���f�B���O�|����2��GoodEnd
--------------------------------------------------------------------------------------

function OnEvent_81(proxy, param)
	print("OnEvent_81 begin");
		
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ��𓯊�
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2011 );
		else
			--����A�j���Đ����s���A���̏I������OnEvent_81_1�𔭍s����
			proxy:OnTurnCharactorEnd( 81, 10000, 2011, "OnEvent_81_1_1", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();	
	
	print("OnEvent_81 end");
end

function OnEvent_81_1_1(proxy, param)
	print("OnEvent_81_1_1 begin");
		
	--�����p�����A�j���Đ�
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 81, 10000, ANIMEID_WALK, "OnEvent_81_1_2", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();

	print("OnEvent_81_1_1 end");
end

function OnEvent_81_1_2(proxy, param)
	print("OnEvent_81_1_2 begin");
	
	proxy:OnKeyTime2( 81, "OnEvent_81_2", 3, 0, 0, once );

	print("OnEvent_81_1_2 end");
end

function OnEvent_81_2(proxy , param)
	print("OnEvent_81_2 begin");
	
	proxy:InvalidSfx( 1991, true );
	
	--�N���C�A���g�ł͂Ȃ��������@or�@�O���C=�@�z�X�gor�\��
	if proxy:IsClient() == false then
		--�N���A��Ԑݒ�A�N���A������Z
		proxy:SetClearState( CLEAR_STATE_GOODEND );
		proxy:AddClearCount();
		
		--���g���t�B�[�擾���聥
		--Lua_RequestUnlockTrophy(proxy, 1);--�g���t�B�̏󋵂𔻒肵�A�擾����
		LastRemoveEquip(proxy);
		--�R�R�ŃN���A�p�̏������������Ăяo�����H
		proxy:OnEndFlow(81,"OnEvent_81_3");
		
	end
	proxy:DeleteEvent(80);

	print("OnEvent_81_2 end");
end

--�I����������
function OnEvent_81_3(proxy,param)
	print("OnEvent_81_3 begin");
	--���G���f�B���O�|����2
	proxy:RequestRemo(5,REMO_FLAG,81,1);
	--�����t���O�������ς݂Ȃ̂Ńt���O��ON�ɂ��Ȃ�
	print("OnEvent_81_3 end");
end

--���|�����Đ��J�n(�t�F�[�h�I��)
function OnEvent_81_RemoStart(proxy,param)
	print("OnEvent_81_RemoStart begin");
	print("OnEvent_81_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��)
function OnEvent_81_RemoFinish(proxy , param)
	print("OnEvent_81_RemoFinish begin");
	
	--[[�Q�[���N���A����]]
	print("Good Ending");	
	--���[�r�[�Đ��v��
	--proxy:RequestPlayMoviePlus(MOVIE_ENDING_GOOD,true);
	--���[�r�[�Đ��̊Ď�
	--proxy:OnRegistFunc(81,"Check_81","OnEvent_81_4",1,once);
	proxy:RequestEnding();--�G���f�B���O�v��
	print("OnEvent_81_RemoFinish end");
end

--[[
--���[�r�[�Đ����̊Ď������̂��H
function Check_81(proxy,param)
	if proxy:IsPlayMovie() == true then
		return false;
	end	
	return true;
end
	
--Good���[���I����
function OnEvent_81_4(proxy,param)
	print("OnEvent_81_4 begin");
	--�Β������[�h
	proxy:WarpNextStage( 1, 0, 0, 0, -1 );
	print("OnEvent_81_4 end");
end
]]

--[[
--------------------------------------------------------------------------------------
--��140�����̂ɂ������Ă��錕����聡
--------------------------------------------------------------------------------------
function OnEvent_140(proxy, param)
	print("OnEvent_140 begin");
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8300 ) == true then--�V�����A�j�� 
		proxy:PlayAnimation( 1130 , 1);	
		print("OnEvent_140 end");
		return true;
	end

	proxy:WarpDmy( 10000 , 1130 , 191 );--�_�~�[�ʒu�փ��|�v
	proxy:PlayAnimation( 1130 , 1);
	--�A�j�����I�������Ď��ǉ�
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 140 , 10000 , 8300 , "OnEvent_140_1", once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_140 end");
end

function OnEvent_140_1(proxy, param)
	print("OnEvent_140_1 begin");
	--�A�C�e���擾�֐�--�p�����[�^10104�Q��
	proxy:GetRateItem(10730);--�A�C�e��	
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 140, true );
	
	--OBJ���������߂̃C�x���g�z�M
	proxy:LuaCallStart( 140, 1);
	
	print("OnEvent_140_1 end");
end

--��140_2����OBJ��\���p��
function OnEvent_140_2(proxy,param)
	print("OnEvent_140_2 begin");
	--�I�u�W�F��������
	proxy:SetDrawEnable( 1130 , false );--�ЂƂ܂��`�悾��OFF
	proxy:SetColiEnable( 1130 , false );--������͂���͕̂s��(����ł͂Ȃ��悤�Ȃ̂ŏ����Ȃ�)
	print("OnEvent_140_2 end");
end
]]
	
--------------------------------------------------------------------------------------
--��100���q���C�����Ō�̐킢�����ӂ��遡
--------------------------------------------------------------------------------------

--��100���q���C�����Ō�̐킢�����ӂ��遡
function OnEvent_100(proxy , param)
	print("OnEvent_100 begin");

	--�q���C���̏�ԃt���O���u�������������v�ɂ���
	SetNpcStateFlag(proxy, param, heroine_flag_list, HEROINE_STATE_WANT_TO_SETTLE );
	proxy:SetEventFlag( 100 , 1 );
	
	print("OnEvent_100 end");
end



--------------------------------------------------------------------------------------
--��90,91���o�b���q���C���̑O���삭��(��b�V�X�e������Ăяo��)
--------------------------------------------------------------------------------------

--��90���o�b���q���C���̑O���삭_1��
function OnEvent_90(proxy , param)
	print("OnEvent_90 begin");
	proxy:SetEventFlag(90,false);
	proxy:TurnCharactor( 10000 , 615 );--PC���q���C���̂ق��Ɍ����킹��
	proxy:EnableLogic( 10000 , false );--PC�𑀍�s�\
	proxy:ResetCamAngle();
	
	proxy:RepeatMessage_begin();
		--������A�j���̏I����
		proxy:OnTurnCharactorEnd( 90 , 10000 , 615 , "OnEvent_90_trun_end" , once );
	proxy:RepeatMessage_end();
	
	print("OnEvent_90 end");
end


--������A�j���̏I����
function OnEvent_90_trun_end(proxy , param)
	print("OnEvent_90_trun_end begin");

	if proxy:IsCompleteEvent(90) == false then
	--[[	--�����A�j��
		proxy:ForcePlayAnimation( 10000 , 8280 );
	
	proxy:RepeatMessage_begin();
		--���ŏ��̃A�j���I����
		proxy:OnChrAnimEnd( 90 , 10000 , 8280 , "OnEvent_90_anime_end" , once );
		proxy:RepeatMessage_end();]]
		--�삭���߂𑗐M
		proxy:SetEventCommand( 10000 , 80 );
	end
	
	print("OnEvent_90_trun_end end");
end


--���ŏ��̃A�j���̏I����
function OnEvent_90_anime_end(proxy , param)
	print("OnEvent_90_anime_end begin");
	--[[
	if proxy:IsCompleteEvent(90) == false then
	proxy:PlayLoopAnimation( 10000 , 8281 );
	end	
	]]
	print("OnEvent_90_anime_end end");
end


--��91���o�b���q���C���̑O���삭_2��
function OnEvent_91(proxy , param)
	print("OnEvent_91 begin");
--�����A�j��
	--proxy:ForcePlayAnimation( 10000 , 8282 );
	proxy:SetEventCommand( 10000 , 81);
	proxy:EnableLogic( 10000 , true );--PC�𑀍�s�\
	proxy:ResetCamAngle();
	proxy:SetEventFlag(90,true);
	
	print("OnEvent_91 end");
end

--[[
--------------------------------------------------------------------------------------
--�n�[�t�n���h�G�΁�200
--------------------------------------------------------------------------------------

--��200���n�[�t�n���h�G�΁�
function OnEvent_200(proxy, param)
	print("OnEvent_200 begin");

	proxy:EnableLogic( 618 , true );--[[���W�b�NON ���W�b�N�؂�ւ�?]]
	
	--�n�[�t�n���h�̏�ԃt���O���u�G��(�Β�)�v�ɂ���
	SetNpcStateFlag(proxy, param, half_flag_list, HALF_STATE_HOSTILE_SEKITYU );
	proxy:SetEventFlag( 200 , 1 );
	
	print("OnEvent_200 end");
end


--------------------------------------------------------------------------------------
--�n�[�t�n���h���S��201
--------------------------------------------------------------------------------------

--��201���n�[�t�n���h���S��
function OnEvent_201(proxy, param)
	print("OnEvent_201 begin");

	--�n�[�t�n���h�̏�ԃt���O���u���S�v�ɂ���
	SetNpcStateFlag(proxy, param, half_flag_list, HALF_STATE_DEAD );
	proxy:SetEventFlag( 201 , 1 );
	
	print("OnEvent_201 end");
end
]]





--------------------------------------------------------------------------------------
--��100�`153��NPC��ԑJ�ځ@�q���C����
--------------------------------------------------------------------------------------
--��100�`153��NPC��ԑJ�ځ@�q���C����

function OnEvent_110(proxy,param)
	print("OnEvent_110 begin");
	if	proxy:IsCompleteEvent(110) == true then
		print("OnEvent_110 ���ɉ�b�C�x���g���I�����Ă��܂��B");
		return;
	end
	if	proxy:IsCompleteEvent( HEROINE_STATE_DOOR_FRONT ) == true then
		SetNpcStateFlag(proxy, param, heroine_flag_list, HEROINE_STATE_DOOR_LEAVE );
	end
	proxy:SetEventFlag( 110, true );
	proxy:SetEventFlag(120,true);
	print("OnEvent_110 end");
end

--��111���q���C�����S�Ď���	
function OnEvent_111(proxy, param)
	print("OnEvent_111 begin");
	proxy:OnKeyTime2(111, "OnEvent_111_1", 10.0, 0, 0, once);
	--proxy:SendEventRequest(615, 0, -1);
	print("OnEvent_111 end");
end

function OnEvent_111_1(proxy, param)
	print("OnEvent_111_1 begin");
	proxy:SetEventFlag( 115 , true );	
	proxy:RecoveryHeroin();
	--�������߂𑗂�
	proxy:SetEventCommand( 615 , 700);
	--�Q��ڈȍ~�̊Ď�
	proxy:RepeatMessage_begin();
		proxy:OnCharacterDead(111, 615, "OnEvent_111", once);
		--proxy:OnCharacterHP( 111 , 615 , "OnEvent_111",0.0,once);
	proxy:RepeatMessage_end();
	--proxy:SetEventFlag(111, true);
	print("OnEvent_111_1 end");
end

-------------------------------------------------------
--�Đ����Ă���A�j��ID�ɂ���āA�Đ�����A�j����ς���
-------------------------------------------------------
function OnEvent_113(proxy, param)
	print("OnEvent_113�@begin");
		--proxy:ForcePlayAnimation(615, 7022);--�A�j���̕��ł��炵���B
		proxy:SetSpStayAndDamageAnimIdPlus(615, -1, -1,hiroin_cancelAnimId);--�ʏ�ҋ@�֖߂�

		--proxy:
	print("OnEvent_113�@end");
end

--------------------------------------------------------------------------------------
--�g�}�X�ɖ��̔������n����354��
--------------------------------------------------------------------------------------
function OnEvent_354(proxy,param)
	print("OnEvent_354 begin");
	if	proxy:IsCompleteEvent(354) == true then
		print("OnEvent_354 ���ɉ�b�C�x���g���I�����Ă��܂��B");
	end
	if proxy:RemoveInventoryEquip(TYPE_GOODS, 38) == true then
		print("OnEvent_354 RemoveInventoryEquip Succsess");
	else
		print("OnEvent_354 RemoveInventoryEquip Failed");
	end
	proxy:GetRateItem( 10700 );
	proxy:SetEventFlag( 354, true );
	print("OnEvent_354 end");
end

--------------------------------------------------------------------------------------
--�{�[�h�E�B���G�΁�390
--------------------------------------------------------------------------------------
--��390���{�[�h�E�B���G�΁�
function OnEvent_390(proxy, param)
	print("OnEvent_390 begin");
	proxy:EnableLogic(694,true);--���W�b�N�n�m
	proxy:SetTeamType(694, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
	SetNpcStateFlag( proxy, param, baldwin_flag_list, BALDWIN_STATE_HOSTILE );--�G��

	proxy:SetEventFlag( 390 , 1 );
	
	print("OnEvent_390 end");
end
--------------------------------------------------------------------------------------
--�{�[�h�E�B�����S��391
-------------------------------------------------------------------------------------
--��391���{�[�h�E�B�����S��
function OnEvent_391(proxy, param)
	print("OnEvent_391 begin");

	--�{�[�h�E�B���̏�ԃt���O���u���S�v�ɂ���
	SetNpcStateFlag(proxy, param, baldwin_flag_list, BALDWIN_STATE_DEAD );
	proxy:SetEventFlag( 391 , 1 );
	
	print("OnEvent_391 end");
end


--------------------------------------------------------------------------------------
--��303���v�l����̘̐b��
--------------------------------------------------------------------------------------
function OnEvent_303(proxy,param)
	print("OnEvent_303 begin");
	if proxy:IsCompleteEvent( 303 ) == true then
		return;
	end
	
	local movieflag = true;
	--[[
	if proxy:GetClearCount() >= 1 then 
		movieflag = true;
	end
	]]
	--BGM��~
	proxy:StopPointSE(0);
	
	proxy:RequestPlayMoviePlus(MOVIE_OLDTALE,movieflag);
	proxy:OnRegistFunc( 303,"Check_303","OnEvent_303_1",1,once);
	print("OnEvent_303 end");
end

--���[�r�[�I������
function Check_303(proxy,param)
	if proxy:IsPlayMovie() == false then
		return true;
	end
	return false;	
end

--���[�r�[�I��
function OnEvent_303_1(proxy,param)
	print("OnEvent_303_1 begin");
	--���[�r�[�Đ��I�������̂ŁABGM���Đ�
	PlayBGM_SEKITYUU(proxy, param);
	print("�Β�BGM�Đ�");
	
	OnEvent_34(proxy, param);--�v�΂̊J����������
	
	proxy:SetEventFlag(303,true);
	print("OnEvent_303_1 end");
end

------------------------------------------------------------------------------------
--34���v�΂̕���̊J��
------------------------------------------------------------------------------------
--�v�ΊJ��
function OnEvent_34(proxy,param)
	print("OnEvent_34 begin");

	proxy:RequestOpenBriefingMsgPlus(10010760,true);
	proxy:PlayTypeSE( 10000 ,SOUND_TYPE_M ,777777777 );
	
	--2���ڈȍ~�͂����܂�
	if proxy:GetClearCount() == 0 then--�܂��S�N���A���Ă��Ȃ����
		proxy:OnKeyTime2( 34 , "OnEvent_34_1",0.1,0,0,once);--���ԊĎ��̒ǉ�
	else--�S�N���A�������Ƃ�����
		--��b�p�Ƀt���O�𗧂Ă�
		OnEvent_36(proxy, param);--36�t���O�n�m
	end
	proxy:SetEventFlag( 8802 , true );
	proxy:SetEventFlag( 8030 , true );
	print("OnEvent_34 end");
end

function OnEvent_34_1(proxy,param)
	print("OnEvent_34_1 beign");
	proxy:OnRegistFunc( 36 , "Check_36","OnEvent_36",1,ocne);
	print("OnEvent_34_1 end");
end

function Check_36(proxy,param)
	if proxy:IsShowMenu() == true then
		return false;
	end
	return true;
end


--�J���C���t�H�\��OFF�҂�
function OnEvent_36(proxy,param)
	print("OnEvent_36 begin");
	
	proxy:SetEventFlag( 34 ,true);
	proxy:SetEventFlag( 36 , true );
	
	print("OnEvent_36 end");
end

--------------------------------------------------------------------------------------
--�v�l���S��300
-------------------------------------------------------------------------------------
--��300���v�l���S��
function OnEvent_300(proxy, param)
	print("OnEvent_300 begin");

	--�v�l�̏�ԃt���O���u���S�v�ɂ���
	SetNpcStateFlag(proxy, param, yojin_flag_list, YOJIN_STATE_DEAD );
	proxy:SetEventFlag( 300 , 1 );
	
	print("OnEvent_300 end");
end


--------------------------------------------------------------------------------------
--�S�܂ꂽ��m���S��380�`386
-------------------------------------------------------------------------------------
function OnEvent_380(proxy,param)
	print("OnEvent_380 begin");
	if	proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_STONE_PILLAR ) == true or	--�Β��ɋ���@��
		proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_MAYBE_DELETE ) == true or	--����������@��
		proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_DELETE ) == true then		--�����܂��Ȃ��
		
		--proxy:SetEventCommand( 611 , 86);
		--proxy:DisableMapHit( 611 , false );
		--proxy:SetDisableGravity( 611 , false );
		proxy:EnableLogic(611,true);--���W�b�N�n�m
		proxy:SetTeamType(611, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		
		SetNpcStateFlag( proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_ANGRY );--�G�Ώ�Ԃ�
	end
	
	proxy:SetEventFlag( 380, true );
	print("OnEvent_380 end");
end

function OnEvent_381(proxy,param)
	print("OnEvent_381 begin");
	SetNpcStateFlag(proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_DEAD );
	proxy:SetEventFlag( 381, true );
	print("OnEvent_381 end");
end

function OnEvent_382(proxy,param)
	print("OnEvent_382 begin");
	--SetNpcStateFlag(proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_DEAD );--�����܂��ɂ���͂��Ȃ̂ŁA�R�����g�A�E�g 
	SetNpcStateFlag(proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_DELETE );--�����܂���
	proxy:SetEventFlag( 382, true );
	print("OnEvent_382 end");
end


--��388����
function OnEvent_388(proxy,param)
	print("OnEvent_388 begin");
	proxy:RequestRemo(000025,REMO_FLAG,388,1);
	print("OnEvent_388 end");
end

--�|�����J�n�t�F�[�h�I����
function OnEvent_388_RemoStart(proxy,param)
	print("OnEvent_388_RemoStart begin");
	proxy:Warp( 611 , 2120 );
	print("OnEvent_388_RemoStart end");
end

--�|�����I���t�F�[�h�J�n�O
function OnEvent_388_RemoFinish(proxy,param)
	print("OnEvent_388_RemoFinish begin");
	proxy:SetSpStayAndDamageAnimId(611,7625,-1);
	print("OnEvent_388_RemoFinish end");
end



--------------------------------------------------------------------------------------
--�_�̐M�k1��320�`324
-------------------------------------------------------------------------------------
function OnEvent_320(proxy,param)
	print("OnEvent_320 begin");
	if proxy:IsCompleteEvent(GOD_BELIEVER_1_STATE_DEAD) == true then--���S���Ă���Ȃ��
		print("OnEvent_320 end");
		return;--���������ɏI��
	end
	proxy:EnableLogic(682,true);--���W�b�N�n�m
	proxy:SetTeamType(682, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
	SetNpcStateFlag( proxy, param, god_beliver1_flag_list, GOD_BELIEVER_1_STATE_ANGRY );--�G�Ώ�Ԃ�
	
	proxy:SetEventFlag( 320, true );
	print("OnEvent_320 end");
end

function OnEvent_321(proxy,param)
	print("OnEvent_321 begin");
	SetNpcStateFlag(proxy, param, god_beliver1_flag_list, GOD_BELIEVER_1_STATE_DEAD );
	proxy:SetEventFlag( 321, true );
	print("OnEvent_321 end");
end

--------------------------------------------------------------------------------------
--�_�̐M�k2��330�`334
-------------------------------------------------------------------------------------
function OnEvent_330(proxy,param)
	print("OnEvent_330 begin");
	if proxy:IsCompleteEvent(GOD_BELIEVER_2_STATE_DEAD) == true					--���S���Ă���@��
	or proxy:IsCompleteEvent(GOD_BELIEVER_2_STATE_ISNOTALREADY) == true then	--���łɂ��Ȃ��Ȃ��
		print("OnEvent_330 end");
		return;--���������ɏI��
	end
	proxy:EnableLogic(683,true);--���W�b�N�n�m
	proxy:SetTeamType(683, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
	SetNpcStateFlag( proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_ANGRY );--�G�Ώ�Ԃ�
	
	proxy:SetEventFlag( 330, true );
	print("OnEvent_330 end");
end

function OnEvent_331(proxy,param)
	print("OnEvent_331 begin");
	SetNpcStateFlag(proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_DEAD );
	proxy:SetEventFlag( 331, true );
	print("OnEvent_331 end");
end

--------------------------------------------------------------------------------------
--�_�̐M�k3��430�`434
-------------------------------------------------------------------------------------
function OnEvent_430(proxy,param)
	print("OnEvent_430 begin");
	if proxy:IsCompleteEvent(GOD_BELIEVER_3_STATE_DEAD) == true then--���S���Ă���Ȃ��
		print("OnEvent_430 end");
		return;--���������ɏI��		
	end
	proxy:EnableLogic(684,true);--���W�b�N�n�m
	proxy:SetTeamType(684, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
	SetNpcStateFlag( proxy, param, god_beliver3_flag_list, GOD_BELIEVER_3_STATE_ANGRY );--�G�Ώ�Ԃ�
	
	proxy:SetEventFlag( 430, true );
	print("OnEvent_430 end");
end

function OnEvent_431(proxy,param)
	print("OnEvent_431 begin");
	SetNpcStateFlag(proxy, param, god_beliver3_flag_list, GOD_BELIEVER_3_STATE_DEAD );
	proxy:SetEventFlag( 431, true );
	print("OnEvent_431 end");
end

--��435���M�k�R���A�C�e��������遡(��b�Ăяo��)
function OnEvent_435(proxy, param)
	print("OnEvent_435 begin");
	proxy:GetRateItem(10760);--�A�C�e������
	proxy:GetRateItem(10761);--�A�C�e������
	proxy:SetEventFlag(435, true);
	print("OnEvent_435 end");
end


--------------------------------------------------------------------------------------
--���p�̓k��310�`314
-------------------------------------------------------------------------------------
function OnEvent_310(proxy,param)
	print("OnEvent_310 begin");
	
	if	proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_HELP ) == true		--���K�[���������ā@��
	or	proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_TOGETHER ) == true	--���K�[���ƈꏏ�@��
	or	proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_FALL ) == true then			--���_�Ȃ��
		
		proxy:EnableLogic(681,true);--���W�b�N�n�m
		proxy:SetTeamType(681, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
		SetNpcStateFlag( proxy, param, magic_student_flag_list, MAGIC_STUDENT_STATE_ANGRY );--�G�Ώ�Ԃ�
	end
	
	proxy:SetEventFlag( 310, true );
	
	print("OnEvent_310 begin");
end

function OnEvent_311(proxy,param)
	print("OnEvent_311 begin");
	SetNpcStateFlag( proxy, param, magic_student_flag_list, MAGIC_STUDENT_STATE_DEAD );
	proxy:SetEventFlag( 311, true );
	print("OnEvent_311 begin");
end



--------------------------------------------------------------------------------------
--�E���x�C����270�`274
-------------------------------------------------------------------------------------
--�E���x�C���G��
function OnEvent_270(proxy,param)
	print("OnEvent_270 begin");
	proxy:EnableLogic(690,true);--���W�b�N�n�m
	proxy:SetTeamType(690, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
	SetNpcStateFlag( proxy, param, urubain_flag_list, URUBAIN_STATE_STONE_PILLAR_ANGRY );--�G�Ώ�Ԃ�
	
	--�E���l�����{��ɂȂ�ꂽ�̂ŁA�M�k�B���{��
	proxy:LuaCallStart(320, 1);--�M�k�P�G�Ή��n���h������
	proxy:LuaCallStart(330, 1);--�M�k�Q�G�Ή��n���h������
	proxy:LuaCallStart(430, 1);--�M�k�R�G�Ή��n���h������
	
	proxy:SetEventFlag( 270, true );
	print("OnEvent_270 end");
end

--�E���x�C�����S
function OnEvent_271(proxy,param)
	print("OnEvent_271 begin");
	SetNpcStateFlag( proxy, param, urubain_flag_list, URUBAIN_STATE_DEAD );
	proxy:SetEventFlag( 271, true );
	print("OnEvent_271 end");
end



--------------------------------------------------------------------------------------
--�����g��280�`283
-------------------------------------------------------------------------------------
--�����g�G��
function OnEvent_280(proxy,param)
	print("OnEvent_280 begin");
	proxy:EnableLogic(619,true);--���W�b�N�n�m
	proxy:SetTeamType(619, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
	SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STATE_ANGRY_M1 );--�G�Ώ�Ԃ�	
	proxy:SetEventFlag( 280, true );
	print("OnEvent_280 end");
end

--�����g���S
function OnEvent_281(proxy,param)
	print("OnEvent_281 begin");
	SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STATE_DEAD );
	proxy:SetEventFlag( 281, true );
	print("OnEvent_281 end");
end

--�����g�̎��̒��ׂ�
function OnEvent_15630(proxy,param)
	print("OnEvent_15630 begin");
	proxy:SetEventFlag( 15630 , true );
	print("OnEvent_15630 end");
end


--------------------------------------------------------------------------------------
--�o�b�`��290�`294
-------------------------------------------------------------------------------------
--�o�b�`�G��
function OnEvent_290(proxy,param)
	print("OnEvent_290 begin");
	proxy:EnableLogic(693,true);--���W�b�N�n�m
	proxy:SetTeamType(693, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
	SetNpcStateFlag( proxy, param, batti_flag_list, BATTI_ANGRY_M1 );--�G�Ώ�Ԃ�
	
	proxy:SetEventFlag( 290, true );
	print("OnEvent_290 end");
end

--�o�b�`���S
function OnEvent_291(proxy,param)
	print("OnEvent_291 begin");
	SetNpcStateFlag( proxy, param, batti_flag_list, BATTI_DEAD );
	proxy:SetEventFlag( 291, true );
	print("OnEvent_291 end");
end


--------------------------------------------------------------------------------------
--������260�`264
-------------------------------------------------------------------------------------
--�����G��
function OnEvent_260(proxy,param)
	print("OnEvent_260 begin");
	proxy:EnableLogic(689,true);--���W�b�N�n�m
	proxy:SetTeamType(689, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
	SetNpcStateFlag( proxy, param, majo_flag_list, MAJO_STATE_ANGRY_M1 );--�G�Ώ��

	proxy:SetEventFlag( 260, true );
	print("OnEvent_260 end");
end

--�������S
function OnEvent_261(proxy,param)
	print("OnEvent_261 begin");
	SetNpcStateFlag( proxy, param, majo_flag_list, MAJO_STATE_DEAD );
	proxy:SetEventFlag( 261, true );
	print("OnEvent_261 end");
end


--------------------------------------------------------------------------------------
--�r�������O������240�`245
-------------------------------------------------------------------------------------
--�r�������O�����G��
function OnEvent_240(proxy,param)
	print("OnEvent_240 begin");
	proxy:EnableLogic(695,true);--���W�b�N�n�m
	proxy:SetTeamType(695, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
	SetNpcStateFlag(proxy,param,biyo_flag_list,BIYO_STATE_HOSTILE_IN_STONE_PILLAR);--�G�Ώ�Ԃ�
	proxy:EraseEventSpecialEffect_2(695,5064);
	proxy:SetEventFlag( 240, true );
	print("OnEvent_240 end");
end

--�r�������O�������S
function OnEvent_241(proxy,param)
	print("OnEvent_241 begin");
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_DEAD );
	proxy:SetEventFlag( 241, true );
	print("OnEvent_241 end");
end




--------------------------------------------------------------------------------------
--���K�[����220�`225
-------------------------------------------------------------------------------------
--���K�[���G��
function OnEvent_221(proxy,param)
	print("OnEvent_221 begin");
	SetNpcStateFlag( proxy, param, rogarn_flag_list, ROGARN_STATE_ANGRY_M1 );--��Ԃ�G�΂�
	proxy:SetTeamType(617, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
	proxy:SetEventFlag( 240, true );
	
	--���p�̓k�G��
	if	proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_HELP ) == true		--���K�[���������ā@��
	or	proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_TOGETHER ) == true	--���K�[���ƈꏏ�@��
	or	proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_FALL ) == true then			--���_�Ȃ��
		
		proxy:EnableLogic(681,true);--���W�b�N�n�m
		proxy:SetTeamType(681, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
		SetNpcStateFlag( proxy, param, magic_student_flag_list, MAGIC_STUDENT_STATE_ANGRY );--�G�Ώ�Ԃ�
	end
	
	print("OnEvent_221 end");
end

--���K�[�����S
function OnEvent_222(proxy,param)
	print("OnEvent_222 begin");
	SetNpcStateFlag( proxy, param, rogarn_flag_list, ROGARN_STATE_DEAD );
	proxy:SetEventFlag( 240, true );
	print("OnEvent_222 end");
end

--------------------------------------------------------------------------------------
--�g�}�X��350�`354
-------------------------------------------------------------------------------------
--�g�}�X�G��
function OnEvent_350(proxy,param)
	print("OnEvent_350 end");
	proxy:EnableLogic(687,true);--���W�b�N�n�m
	proxy:SetTeamType(687, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
	SetNpcStateFlag( proxy, param, tomasu_flag_list, TOMASU_STATE_ANGRY );--�G�Ώ�Ԃ�	
	proxy:SetEventFlag( 350, true );
	print("OnEvent_350 end");
end

--�g�}�X���S
function OnEvent_351(proxy,param)
	print("OnEvent_351 end");
	SetNpcStateFlag( proxy, param, tomasu_flag_list, TOMASU_STATE_DEAD );
	proxy:SetEventFlag( 351, true );
	print("OnEvent_351 end");
end


--------------------------------------------------------------------------------------
--�����h�����q��230�`233
-------------------------------------------------------------------------------------
function OnEvent_230(proxy,param)
	print("OnEvent_230 begin");
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HOSTILE_STONE_PILLAR );
	proxy:EnableLogic(688,true);--���W�b�N�n�m
	proxy:SetTeamType(688, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
	proxy:EraseEventSpecialEffect_2(688,5063);
	proxy:SetEventFlag( 230, true );
	print("OnEvent_230 end");
end

function OnEvent_231(proxy,param)
	print("OnEvent_231 begin");
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_DEAD );
	proxy:SetEventFlag( 231, true );
	print("OnEvent_231 end");
end




--------------------------------------------------------------------------------------
--���t�B�X�g��360�`372
-------------------------------------------------------------------------------------
--���t�B�X�g�G��
function OnEvent_360(proxy,param)
	print("OnEvent_360 end");
			proxy:EnableLogic(680,true);--���W�b�N�n�m
			proxy:SetTeamType(680, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
			SetNpcStateFlag( proxy, param, mefist_flag_list, MEFIST_STATE_ANGRY );--�G�Ώ�Ԃ�
	proxy:SetEventFlag( 360, true );
	print("OnEvent_360 end");
end

--���t�B�X�g���S
function OnEvent_361(proxy,param)
	print("OnEvent_361 end");
	SetNpcStateFlag( proxy, param, mefist_flag_list, MEFIST_STATE_DEAD );
	proxy:SetEventFlag( 361, true );
	print("OnEvent_361 end");
end


--���t�B�X�g �@�y�����h�����q�z�E�Q�񍐑҂�
function OnEvent_362(proxy,param)
	print("OnEvent_362 end");
	SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_KILL_WAIT_RENDOL );
	proxy:SetEventFlag( 362, true );
	print("OnEvent_362 end");
end

--���t�B�X�g �@�y�r�������O�����z�E�Q�񍐑҂�
function OnEvent_363(proxy,param)
	print("OnEvent_363 end");
	SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_KILL_WAIT_BIYO );
	proxy:SetEventFlag( 363, true );
	print("OnEvent_363 end");
end

--���t�B�X�g �@�y���K�[���z�E�Q�񍐑҂�
function OnEvent_364(proxy,param)
	print("OnEvent_364 end");
	SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_KILL_WAIT_ROGARN );
	proxy:SetEventFlag( 364, true );
	print("OnEvent_364 end");
end

--���t�B�X�g �@�y�����z�E�Q�񍐑҂�
function OnEvent_365(proxy,param)
	print("OnEvent_365 end");
	SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_KILL_WAIT_MAJO );
	proxy:SetEventFlag( 365, true );
	print("OnEvent_365 end");
end

--���t�B�X�g �@�y�E���x�C���z�E�Q�񍐑҂�
function OnEvent_366(proxy,param)
	print("OnEvent_366 end");
	SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_KILL_WAIT_URU );
	proxy:SetEventFlag( 366, true );
	print("OnEvent_366 end");
end

--���t�B�X�g �@�y�g�}�X�z�E�Q�񍐑҂�
function OnEvent_367(proxy,param)
	print("OnEvent_367 end");
	SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_KILL_WAIT_TOMASU );
	proxy:SetEventFlag( 367, true );
	print("OnEvent_367 end");
end

--���t�B�X�g �@�y�o�b�`�z�E�Q�񍐑҂�
function OnEvent_368(proxy,param)
	print("OnEvent_368 end");
	SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_KILL_WAIT_BATTI );
	proxy:SetEventFlag( 368, true );
	print("OnEvent_368 end");
end

--���t�B�X�g �@���z���G��
function OnEvent_369(proxy,param)
	print("OnEvent_369 end");
	proxy:EnableLogic(680,true);--���W�b�N�n�m
	proxy:SetTeamType(680, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
	SetNpcStateFlag( proxy, param, mefist_flag_list, MEFIST_STATE_ANGRY );--�G�Ώ�Ԃ�
	
	proxy:SetEventFlag( 369, true );
	print("OnEvent_369 end");
end

--�y���q�z�E�Q�̂���
function OnEvent_400(proxy,param)
	print("OnEvent_400 end");
	
	proxy:GetRateItem( 10710 );
	proxy:SetEventFlag( 400, true );
	
	print("OnEvent_400 end");
end

--�y�r�������O�����z�E�Q�̂���
function OnEvent_401(proxy,param)
	print("OnEvent_401 end");
	
	proxy:GetRateItem( 10711 );
	proxy:SetEventFlag( 401, true );
	
	print("OnEvent_401 end");
end

--�y���K�[���z�E�Q�̂���
function OnEvent_402(proxy,param)
	print("OnEvent_402 end");
	
	proxy:GetRateItem( 10712 );
	proxy:SetEventFlag( 402, true );
	
	print("OnEvent_402 end");
end

--�y�����z�E�Q�̂���
function OnEvent_403(proxy,param)
	print("OnEvent_403 end");
	
	proxy:GetRateItem( 10713 );
	proxy:SetEventFlag( 403, true );
	
	print("OnEvent_403 end");
end

--�y�E���x�C���z�E�Q�̂���
function OnEvent_404(proxy,param)
	print("OnEvent_404 end");
	
	proxy:GetRateItem( 10714 );
	proxy:SetEventFlag( 404, true );
	
	print("OnEvent_404 end");
end

--�y�g�}�X�z�E�Q�̂���
function OnEvent_405(proxy,param)
	print("OnEvent_405 end");
	
	proxy:GetRateItem( 10715 );
	proxy:SetEventFlag( 405, true );
	
	print("OnEvent_405 end");
end

--�y�o�b�`�z�E�Q�̂���
function OnEvent_406(proxy,param)
	print("OnEvent_406 end");
	
	proxy:GetRateItem( 10716 );
	proxy:SetEventFlag( 406, true );
	
	print("OnEvent_406 end");
end

------------------------------------------------------------------------------------
--BGM�֘AOnEvent
------------------------------------------------------------------------------------
--�X�e�[�W�N���A���ɂ���čĐ�����BGM��ύX����
function PlayBGM_SEKITYUU(proxy, param)
	if ClearBlockCount ~= 5 then
		if ClearBlockCount >= 3 then--�X�e�[�W�N���A��3�ȏ�
			print("--��421��BGM�Đ�2��");
			proxy:RepeatMessage_begin();
				--proxy:LuaCall(421, 0, "OnEvent_421", everytime);--BGM�𗬂�OnEvent�𔭓�������
				proxy:PlayPointSE( 2050, SOUND_TYPE_M, 010100000, 0 );
				print("010100000�Đ�");
				proxy:SetEventFlag( 421, true );
				--proxy:DeleteEvent( 421 );--442�̂悤��everytime�ł͂Ȃ��̂�
			proxy:RepeatMessage_end();	
			
		elseif ClearBlockCount <= 2 then--�X�e�[�W�N���A��2�ȉ�
			print("--��420��BGM�Đ�1��");
			proxy:RepeatMessage_begin();
				--proxy:LuaCall( 420 , 0 , "OnEvent_420", once );--BGM�𗬂�OnEvent�𔭓�������
				proxy:PlayPointSE( 2050, SOUND_TYPE_M, 010000000, 0 );
				print("010000000�Đ�");
				proxy:SetEventFlag( 420, true );
				--proxy:DeleteEvent( 420 );--442�̂悤��everytime�ł͂Ȃ��̂�
			proxy:RepeatMessage_end();
			
		end
	else
		print("--��440��BGM�Đ�3��");
		proxy:RepeatMessage_begin();
			--proxy:LuaCall( 440 , 0 , "OnEvent_420", once );--BGM�𗬂�OnEvent�𔭓�������
			proxy:PlayPointSE( 2020, SOUND_TYPE_C, 600004000, 0 );
			print("600004000�Đ�");
			proxy:SetEventFlag( 440, true );
			--proxy:DeleteEvent( 420 );--442�̂悤��everytime�ł͂Ȃ��̂�
		proxy:RepeatMessage_end();
	end
end

--���X�{�X��BGM
function OnEvent_422(proxy,param)
	print("OnEvent_422 begin");
		proxy:EnableLogic( 821, true );
		proxy:PlayPointSE( 2060, SOUND_TYPE_M, 010200000, 1 );
		--�{�X�Q�[�W�\��
		proxy:SetBossGauge(821, 0, 4000);
		proxy:SetEventFlag( 422, true );
		proxy:DeleteEvent( 422 );
	print("OnEvent_422 end");
end


------------------------------------------------------------------------------------
--304���q���C������A�C�e����Ⴄ
------------------------------------------------------------------------------------
function OnEvent_304(proxy,param)
	print("OnEvent_304 begin");
	
	proxy:SetEventFlag( 304, true );	
	
	--if proxy:GetClearCount() == 0 then	
	if proxy:IsInventoryEquip(TYPE_GOODS,9997) == false then	
		proxy:GetRateItem( 10740 );
		proxy:GetRateItem( 10850 );
		--Lua_PauseTutorial(proxy);
		proxy:OnKeyTime2( 304 , "OnEvent_304_1",0.1,0,0,once);
	end
	
	print("OnEvent_304 end");
end

--�A�C�e������\��OFF�҂�
function OnEvent_304_1(proxy,param)
	print("OnEvent_304_1 begin");
	proxy:OnRegistFunc( 112 , "Check_112","OnEvent_112",1,once);
	print("OnEvent_304_1 end");
end

--�`�F�b�N
function Check_112(proxy)
	if proxy:IsShowMenu() == true then
		return false;
	end
	return true;
end

--�����̐ΐ���
function OnEvent_112(proxy,param)
	print("OnEvent_112 begin");
	proxy:SetEventFlag(112, true);
	--Display_InfomationMenu_2(proxy, 0, -1, 30, 84001000, 1, -1, 30, 84001001, 6);
	proxy:RequestOpenBriefingMsgPlus(84001001,true);
	--Lua_PauseTutorial(proxy);	
	
	proxy:OnKeyTime2( 112 , "OnEvent_112_1", 0.1 , 0 , 1 ,once );
	print("OnEvent_112 end");
end

function OnEvent_112_1(proxy,param)
	proxy:OnRegistFunc( 114 , "Check_114","OnEvent_114",1,once);
end

--�`�F�b�N
function Check_114(proxy)
	if proxy:IsShowMenu() == true then
		return false;
	end
	return true;
end

--�q���C������
function OnEvent_114(proxy,param)
	print("OnEvent_114 begin");
	--Display_InfomationMenu_2(proxy, 0, -1, 30, 84001100, 1, -1, 30, 84001101, 6);	
	--Lua_PauseTutorial(proxy);
	proxy:OnKeyTime2( 114 , "OnEvent_114_wait",0.1,0,20,once);	
	print("OnEvent_114 end");
end

function OnEvent_114_wait(proxy,param)
	print("OnEvent_114_wait begin");	
	proxy:RequestOpenBriefingMsgPlus(84001101,true);
	proxy:OnRegistFunc( 114 , "Check_114_1","OnEvent_114_1",5,once);
	print("OnEvent_114_wait end");
end

--�`�F�b�N
function Check_114_1(proxy)
	if proxy:IsShowMenu() == true then
		return false;
	end
	return true;
end

--���j���[��������t���O�𗧂Ă�
function OnEvent_114_1(proxy,param)
	print("OnEvent_114_1 begin");
	proxy:SetEventFlag(114, true);
	print("OnEvent_114_1 end");
end


------------------------------------------------------------------------------------
--304���q���C������A�C�e����Ⴄ
------------------------------------------------------------------------------------
function OnEvent_305(proxy,param)
	print("OnEvent_305 begin");	
	proxy:SetEventFlag( 304, true );
	proxy:GetRateItem( 10741 );	
	print("OnEvent_305 end");
end

------------------------------------------------------------------------------------
--42���Β����ւ̃��[�f�B���O
------------------------------------------------------------------------------------
function OnEvent_42(proxy,param)
	print("OnEvent_42 begin");
	proxy:RepeatMessage_begin();
	--��42_0���I�����j���[�̊Ď���
		proxy:OnSelectMenu(42, "OnEvent_42_0", 10010730, 0, 2, 1140, 2, once);			
	proxy:RepeatMessage_end();
	print("OnEvent_42 end");
end

--��42_0���I�����j���[�̊Ď���
function OnEvent_42_0(proxy, param)
	print("OnEvent_42_0 begin");	
	proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ�	
	proxy:NoAnimeTurnCharactor( 10000 , 1140 ,TURNSKIP_ANGLE);
	proxy:NotNetMessage_begin();
		--���v�΂ɐG���A�j���Đ��I����
		proxy:OnChrAnimEnd( 42 , 10000 , 8283 , "OnEvent_42_1" , once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 42 , 1 );
	
	print("OnEvent_42_0 end");
end

--��42_1���v�΂ɐG���A�j���Đ��I����
function OnEvent_42_1(proxy, param)
	print("OnEvent_42_1 begin");	
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ�		
	OnEvent_42_2(proxy,param);
	
	print("OnEvent_42_1 end");
end

--�������E�ɋA��A�j���Đ��I����
function OnEvent_42_2(proxy,param)	
	print("OnEvent_42_2 begin");	
	--���S�񕜗v��
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 2101 );	
	print("OnEvent_42_2 end");
end


------------------------------------------------------------------------------------
--44���Β����ւ̃��[�f�B���O2
------------------------------------------------------------------------------------
function OnEvent_44(proxy,param)
	print("OnEvent_44 begin");
	proxy:RepeatMessage_begin();
	--��42_0���I�����j���[�̊Ď���
		proxy:OnSelectMenu(42, "OnEvent_44_0", 10010730, 0, 2, 1140, 2, once);			
	proxy:RepeatMessage_end();
	print("OnEvent_44 end");
end

--��42_0���I�����j���[�̊Ď���
function OnEvent_44_0(proxy, param)
	print("OnEvent_44_0 begin");	
	proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ�	
	proxy:NoAnimeTurnCharactor( 10000 , 1140 ,TURNSKIP_ANGLE);
	proxy:NotNetMessage_begin();
		--���v�΂ɐG���A�j���Đ��I����
		proxy:OnChrAnimEnd( 42 , 10000 , 8283 , "OnEvent_44_1" , once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 42 , 1 );
	
	print("OnEvent_44_0 end");
end

--��42_1���v�΂ɐG���A�j���Đ��I����
function OnEvent_44_1(proxy, param)
	print("OnEvent_44_1 begin");	
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ�		
	OnEvent_44_2(proxy,param);
	
	print("OnEvent_44_1 end");
end

--�������E�ɋA��A�j���Đ��I����
function OnEvent_44_2(proxy,param)	
	print("OnEvent_44_2 begin");	
	--���S�񕜗v��
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 2102 );	
	print("OnEvent_44_2 end");
end


------------------------------------------------------------------------------------
--43���Β���ւ̃��[�f�B���O
------------------------------------------------------------------------------------
function OnEvent_43(proxy,param)
	print("OnEvent_43 begin");
	proxy:RepeatMessage_begin();
	--��43_0���I�����j���[�̊Ď���
		proxy:OnSelectMenu(43, "OnEvent_43_0", 10010710, 0, 2, 1145, 2, once);			
	proxy:RepeatMessage_end();
	print("OnEvent_43 end");
end

--��43_0���I�����j���[�̊Ď���
function OnEvent_43_0(proxy, param)
	print("OnEvent_43_0 begin");	
	proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ�	
	proxy:NoAnimeTurnCharactor( 10000 , 1145 ,TURNSKIP_ANGLE);
	proxy:NotNetMessage_begin();
		--���v�΂ɐG���A�j���Đ��I����
		proxy:OnChrAnimEnd( 43 , 10000 , 8283 , "OnEvent_43_1" , once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 43 , 1 );
	
	print("OnEvent_43_0 end");
end

--��43_1���v�΂ɐG���A�j���Đ��I����
function OnEvent_43_1(proxy, param)
	print("OnEvent_43_1 begin");	
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ�		
	OnEvent_43_2(proxy,param);
	
	print("OnEvent_43_1 end");
end

--�������E�ɋA��A�j���Đ��I����
function OnEvent_43_2(proxy,param)	
	print("OnEvent_43_2 begin");	
	--���S�񕜗v��
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 2100 );	
	print("OnEvent_43_2 end");
end

--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ��遡61
--------------------------------------------------------------------------------------
--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫
--��61�����{�X�����ւ̔����J����
function OnEvent_61(proxy,param)	
	print("OnEvent_61 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_61 end");
		return;
	end
	
	proxy:LuaCallStart( 61 , 1 );--����A�j���̓����Đ�
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	proxy:SetEventFlag( 61, true );
	
	--�v���t�@�C���̃Z�[�u
	proxy:SaveRequest_Profile()
	print("OnEvent_61 end");
end


--����A�j���̓����Đ�(ID����)
function OnEvent_61_1(proxy,param)
	print("OnEvent_61_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ��𓯊�
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2891 );
		else
			--����A�j���Đ����s���A���̏I������OnEvent_61_2�𔭍s����
			proxy:OnTurnCharactorEnd( 61, 10000, 2891, "OnEvent_61_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();	
	
	print("OnEvent_61_1 end");
end

--����A�j���̓����Đ��I����
function OnEvent_61_2(proxy,param)
	print("OnEvent_61_2 begin");
	
	--�����p�����A�j���Đ�
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 61, 10000, ANIMEID_WALK, "OnEvent_61_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
		
	print("OnEvent_61_2 end");
end

--�����A�j���̓����Đ��I����
function OnEvent_61_3(proxy,param)
	print("OnEvent_61_3 begin");

	--�ŏ��̐l���{�X�����̒��ɓ���I����Ă�����A���ɔz�M����Ă���͂��Ȃ̂ŁA����������Ȃ��n���h��
	if proxy:IsCompleteEvent( 61 ) == false then
		proxy:LuaCallStart( 61 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�)
	if proxy:IsClient() == false then
		proxy:ResetThink( 821 );
	end
	
	proxy:LuaCallStart( 61 , 6 );--�t���O�Z�b�g(�����p)
	proxy:SetEventFlag( SYSTEM_ID_IGNORE,false);	
	print("OnEvent_61_3 end");
end

--[[�폜�Ƃ̎��Ȃ̂ŁA�R�����g�A�E�g
--------------------------------------------------------------------------------------
--������G�΁�340
--------------------------------------------------------------------------------------
--��341��������G�΁�
function OnEvent_340(proxy, param)
	print("OnEvent_340 begin");
	proxy:EnableLogic(686,true);--���W�b�N�n�m
	proxy:SetTeamType(686, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX
	SetNpcStateFlag( proxy, param, monoshiri_flag_list, MONOSHIRI_STATE_HOSTILE );--�G�Ώ�Ԃ�

	proxy:SetEventFlag( 340 , 1 );
	print("OnEvent_340 end");
end
--------------------------------------------------------------------------------------
--�����莀�S��341
--------------------------------------------------------------------------------------
--��340�������莀�S��
function OnEvent_341(proxy, param)
	print("OnEvent_341 begin");

	--������̏�ԃt���O���u���S�v�ɂ���
	SetNpcStateFlag(proxy, param, monoshiri_flag_list, MONOSHIRI_STATE_DEAD );
	proxy:SetEventFlag( 341 , 1 );
	
	print("OnEvent_341 end");
end
]]



--PC���Β��ɖ߂��Ă������Ƀq���C���̈ʒu�����肷��֐�
function Lua_SetHeroinPos(proxy,param)
	
	--�����X�e�[�^�X��ݒ�
	SetFirstNpcStateFlag( proxy , param , warp_list , GO_TO_WARP_OUJOU );	
	
	--�A�j��ID�̒萔�p��
	local a0000 = -1;
	local a7003 = 7003;--����
	local a7004 = 7004;--����
	local a7005 = 7005;--����
	local a7006 = 7006;--����	
	local a7007 = 7003;--����
	local a7008 = 7008;--����
	local a7009 = 7005;--����
	
	local d0000 = -1;
	local d7003 = 9600;
	local d7004 = 9600;
	local d7005 = -1;
	local d7006 = 9600;
	local d7007 = 9600;
	local d7008 = 9600;
	local d7009 = -1;
	
	local c0000 = -1;
	local c7003 = 7024;	
	local c7004 = 7022;
	local c7005 = -1;
	local c7006 = 7025;
	local c7007 = 7024;
	local c7008 = 7023;
	local c7009 = -1;
	
	--����ɍs���Ă���
	if proxy:IsCompleteEvent( GO_TO_WARP_OUJOU ) == true then
		print("����ɍs���Ă���");
		local Oujou_Apos 	={2200	,2200	,2200	,2200	};
		local Oujou_Aanim 	={a7003	,a7006	,a7007	,a0000	};
		local Oujou_Adam	={d7003	,d7006	,d7007	,d0000	};
		local Oujou_Acan	={c7003	,c7006	,c7007	,c0000	};
		local Oujou_Bpos	={2206	,2210	};
		local Oujou_Banim	={a0000	,a0000	};
		local Oujou_Bdam	={d0000	,d0000	};
		local Oujou_Bcan	={c0000	,c0000	};
		local Oujou_Cpos 	={2205	,2205	,2205	,2207	,2207	,2207	,2208	,2208	,2208	};
		local Oujou_Canim	={a7004	,a7008	,a7009	,a7004	,a7008	,a7009	,a7004	,a7008	,a7009	};
		local Oujou_Cdam	={d7004	,d7008	,d7009	,d7004	,d7008	,d7009	,d7004	,d7008	,d7009	};
		local Oujou_Ccan	={c7004	,c7008	,c7009	,c7004	,c7008	,c7009	,c7004	,c7008	,c7009	};
		local Oujou_Dpos 	={2205	,2209	};
		local Oujou_Danim	={a7005	,a7005	};
		local Oujou_Ddam	={d7005	,d7005	};
		local Oujou_Dcan	={c7005	,c7005	};
		Lua_SetPos(proxy,
		Oujou_Apos,
		Oujou_Aanim,
		Oujou_Adam,
		Oujou_Acan,
		Oujou_Bpos,
		Oujou_Banim,
		Oujou_Bdam,
		Oujou_Bcan,
		Oujou_Cpos,
		Oujou_Canim,
		Oujou_Cdam,
		Oujou_Ccan,
		Oujou_Dpos,
		Oujou_Danim,
		Oujou_Ddam,
		Oujou_Dcan
		);
	end
	
	--�ÍԂɍs���Ă���
	if proxy:IsCompleteEvent( GO_TO_WARP_FURUTORIDE ) == true then
		print("�ÍԂɍs���Ă���");
		local Furutoride_Apos 	={2203	,2203	,2203	,2203	};
		local Furutoride_Aanim 	={a7003	,a7006	,a7007	,a0000	};
		local Furutoride_Adam 	={d7003	,d7006	,d7007	,d0000	};
		local Furutoride_Acan 	={c7003	,c7006	,c7007	,c0000	};
		local Furutoride_Bpos	={2206	,2210	};
		local Furutoride_Banim	={a0000	,a0000	};
		local Furutoride_Bdam	={d0000	,d0000	};
		local Furutoride_Bcan	={c0000	,c0000	};
		local Furutoride_Cpos 	={2205	,2205	,2205	,2207	,2207	,2207	,2208	,2208	,2208	};
		local Furutoride_Canim	={a7004	,a7008	,a7009	,a7004	,a7008	,a7009	,a7004	,a7008	,a7009	};
		local Furutoride_Cdam	={d7004	,d7008	,d7009	,d7004	,d7008	,d7009	,d7004	,d7008	,d7009	};
		local Furutoride_Ccan	={c7004	,c7008	,c7009	,c7004	,c7008	,c7009	,c7004	,c7008	,c7009	};
		local Furutoride_Dpos 	={2205	,2209	};
		local Furutoride_Danim	={a7005	,a7005	};
		local Furutoride_Ddam	={d7005	,d7005	};
		local Furutoride_Dcan	={c7005	,c7005	};
		Lua_SetPos(proxy,
			Furutoride_Apos,
			Furutoride_Aanim,
			Furutoride_Adam,
			Furutoride_Acan,
			Furutoride_Bpos,
			Furutoride_Banim,
			Furutoride_Bdam,
			Furutoride_Bcan,
			Furutoride_Cpos,
			Furutoride_Canim,
			Furutoride_Cdam,
			Furutoride_Ccan,
			Furutoride_Dpos,
			Furutoride_Danim,
			Furutoride_Ddam,
			Furutoride_Dcan
			);
	end
	
	--�S��ɍs���Ă���
	if proxy:IsCompleteEvent( GO_TO_WARP_ROUJOU ) == true then
		print("�S��ɍs���Ă���");
		local Roujou_Apos 	={2202	,2202	,2202	,2202	};
		local Roujou_Aanim 	={a0000	,a7004	,a7008	,a7009	};
		local Roujou_Adam 	={d0000	,d7004	,d7008	,d7009	};
		local Roujou_Acan 	={c0000	,c7004	,c7008	,c7009	};
		local Roujou_Bpos	={2206	,2210	};
		local Roujou_Banim	={a0000	,a0000	};
		local Roujou_Bdam	={d0000	,d0000	};
		local Roujou_Bcan	={c0000	,c0000	};
		local Roujou_Cpos 	={2205	,2205	,2205	,2207	,2207	,2207	,2208	,2208	,2208	};
		local Roujou_Canim	={a7004	,a7008	,a7009	,a7004	,a7008	,a7009	,a7004	,a7008	,a7009	};
		local Roujou_Cdam	={d7004	,d7008	,d7009	,d7004	,d7008	,d7009	,d7004	,d7008	,d7009	};
		local Roujou_Ccan	={c7004	,c7008	,c7009	,c7004	,c7008	,c7009	,c7004	,c7008	,c7009	};
		local Roujou_Dpos 	={2205	,2209	};
		local Roujou_Danim	={a7005	,a7005	};
		local Roujou_Ddam	={d7005	,d7005	};
		local Roujou_Dcan	={c7005	,c7005	};
		Lua_SetPos(proxy,
			Roujou_Apos,
			Roujou_Aanim,
			Roujou_Adam,
			Roujou_Acan,
			Roujou_Bpos,
			Roujou_Banim,
			Roujou_Bdam,
			Roujou_Bcan,
			Roujou_Cpos,
			Roujou_Canim,
			Roujou_Cdam,
			Roujou_Ccan,
			Roujou_Dpos,
			Roujou_Danim,
			Roujou_Ddam,
			Roujou_Dcan);
	end
	
	--�s��ɍs���Ă���
	if proxy:IsCompleteEvent( GO_TO_WARP_FUJOU ) == true then
		print("�s��ɍs���Ă���");
		local Fujou_Apos 	={2204	,2204	,2204	,2204	};
		local Fujou_Aanim 	={a7003	,a7006	,a7007	,a0000	};
		local Fujou_Adam 	={d7003	,d7006	,d7007	,d0000	};
		local Fujou_Acan 	={c7003	,c7006	,c7007	,c0000	};
		local Fujou_Bpos	={2206	,2210	};
		local Fujou_Banim	={a0000	,a0000	};
		local Fujou_Bdam	={d0000	,d0000	};
		local Fujou_Bcan	={c0000	,c0000	};
		local Fujou_Cpos 	={2205	,2205	,2205	,2207	,2207	,2207	,2208	,2208	,2208	};
		local Fujou_Canim	={a7004	,a7008	,a7009	,a7004	,a7008	,a7009	,a7004	,a7008	,a7009	};
		local Fujou_Cdam	={d7004	,d7008	,d7009	,d7004	,d7008	,d7009	,d7004	,d7008	,d7009	};
		local Fujou_Ccan	={c7004	,c7008	,c7009	,c7004	,c7008	,c7009	,c7004	,c7008	,c7009	};
		local Fujou_Dpos 	={2205	,2209	};
		local Fujou_Danim	={a7005	,a7005	};
		local Fujou_Ddam	={d7005	,d7005	};
		local Fujou_Dcan	={c7005	,c7005	};
		Lua_SetPos(proxy,
			Fujou_Apos,
			Fujou_Aanim,
			Fujou_Adam,
			Fujou_Acan,
			Fujou_Bpos,
			Fujou_Banim,
			Fujou_Bdam,
			Fujou_Bcan,
			Fujou_Cpos,
			Fujou_Canim,
			Fujou_Cdam,
			Fujou_Ccan,
			Fujou_Dpos,
			Fujou_Danim,
			Fujou_Ddam,
			Fujou_Dcan);
	end
	
	--�B���ɍs���Ă���
	if proxy:IsCompleteEvent( GO_TO_WARP_KOUDOU ) == true then
		print("�B���ɍs���Ă���");
		local Koudou_Apos 	={2201	,2201	,2201	,2201	};
		local Koudou_Aanim 	={a7003	,a7006	,a7007	,a0000	};
		local Koudou_Adam 	={d7003	,d7006	,d7007	,d0000	};
		local Koudou_Acan 	={c7003	,c7006	,c7007	,c0000	};
		local Koudou_Bpos	={2206	,2210	};
		local Koudou_Banim	={a0000	,a0000	};
		local Koudou_Bdam	={d0000	,d0000	};
		local Koudou_Bcan	={c0000	,c0000	};
		local Koudou_Cpos 	={2205	,2205	,2205	,2207	,2207	,2207	,2208	,2208	,2208	};
		local Koudou_Canim	={a7004	,a7008	,a7009	,a7004	,a7008	,a7009	,a7004	,a7008	,a7009	};
		local Koudou_Cdam	={d7004	,d7008	,d7009	,d7004	,d7008	,d7009	,d7004	,d7008	,d7009	};
		local Koudou_Ccan	={c7004	,c7008	,c7009	,c7004	,c7008	,c7009	,c7004	,c7008	,c7009	};
		local Koudou_Dpos 	={2205	,2209	};
		local Koudou_Danim	={a7005	,a7005	};
		local Koudou_Ddam	={d7005	,d7005	};
		local Koudou_Dcan	={c7005	,c7005	};
		Lua_SetPos(proxy,
			Koudou_Apos,
			Koudou_Aanim,
			Koudou_Adam,
			Koudou_Acan,
			Koudou_Bpos,
			Koudou_Banim,
			Koudou_Bdam,
			Koudou_Bcan,
			Koudou_Cpos,
			Koudou_Canim,
			Koudou_Cdam,
			Koudou_Ccan,
			Koudou_Dpos,
			Koudou_Danim,
			Koudou_Ddam,
			Koudou_Dcan);
	end
	
	--�k���ɍs���Ă���
	if proxy:IsCompleteEvent( GO_TO_WARP_HOKUGEN ) == true then
		print("�k���ɍs���Ă���");
		local Hokugen_Apos 	={2200	,2200	,2200	,2200	};
		local Hokugen_Aanim ={a7003	,a7006	,a7007	,a0000	};
		local Hokugen_Adam	={d7003	,d7006	,d7007	,d0000	};
		local Hokugen_Acan	={c7003	,c7006	,c7007	,c0000	};
		local Hokugen_Bpos	={2206	,2210	};
		local Hokugen_Banim	={a0000	,a0000	};
		local Hokugen_Bdam	={d0000	,d0000	};
		local Hokugen_Bcan	={c0000	,c0000	};
		local Hokugen_Cpos 	={2205	,2205	,2205	,2207	,2207	,2207	,2208	,2208	,2208	};
		local Hokugen_Canim	={a7004	,a7008	,a7009	,a7004	,a7008	,a7009	,a7004	,a7008	,a7009	};
		local Hokugen_Cdam	={d7004	,d7008	,d7009	,d7004	,d7008	,d7009	,d7004	,d7008	,d7009	};
		local Hokugen_Ccan	={c7004	,c7008	,c7009	,c7004	,c7008	,c7009	,c7004	,c7008	,c7009	};
		local Hokugen_Dpos 	={2205	,2209	};
		local Hokugen_Danim	={a7005	,a7005	};
		local Hokugen_Ddam	={d7005	,d7005	};
		local Hokugen_Dcan	={c7005	,c7005	};
		Lua_SetPos(proxy,
			Hokugen_Apos,
			Hokugen_Aanim,
			Hokugen_Adam,
			Hokugen_Acan,
			Hokugen_Bpos,
			Hokugen_Banim,
			Hokugen_Bdam,
			Hokugen_Bcan,
			Hokugen_Cpos,
			Hokugen_Canim,
			Hokugen_Cdam,
			Hokugen_Ccan,
			Hokugen_Dpos,
			Hokugen_Danim,
			Hokugen_Ddam,
			Hokugen_Dcan);
	end
end


function Lua_SetPos(
proxy,
list_Apos,
list_Aanim,
list_Adam,
list_Acan,
list_Bpos,
list_Banim,
list_Bdam,
list_Bcan,
list_Cpos,
list_Canim,
list_Cdam,
list_Ccan,
list_Dpos,
list_Danim,
list_Ddam,
list_Dcan
)
	
	local heroine = 615;
	--�����擾
	local randA = proxy:GetRandom(0,100);
	local dbgrandA = proxy:GetDbgRandomA();
	--�f�o�b�O����������΂��������g��(���i�ł͕K��-1���A��܂��v��Ȃ��Ȃ�����R�����g�A�E�g����)
	if dbgrandA ~= -1 then
		randA = dbgrandA;
	end	
	print("�q���C���o�҂�����A",randA);	
	
	--�����擾
	local randB = proxy:GetRandom(0,100);
	local dbgrandB = proxy:GetDbgRandomB();	
	if dbgrandB ~= -1 then
		randB = dbgrandB;
	end	
	print("�q���C���o�҂�����B",randB);	
		
	if randA <= 40 then
		local Aindex = 1;
		if randB <= 25 then
			Aindex = 1;
		elseif randB <= 50 then
			Aindex = 2;
		elseif randB <= 75 then
			Aindex = 3;
		else
			Aindex = 4;
		end
		proxy:Warp( heroine , list_Apos[Aindex] );
		proxy:ChangeInitPosAng(heroine,  list_Apos[Aindex] );
		proxy:SetSpStayAndDamageAnimIdPlus( heroine , list_Aanim[Aindex] ,list_Adam[Aindex] , list_Acan[Aindex]);
		hiroin_cancelAnimId = list_Acan[Aindex];
		print("�q���C�� pos:",list_Apos[Aindex]," anim:",list_Aanim[Aindex]);
	elseif randA <= 70 then
		local Bindex = 1;
		if randB <= 50 then
			Bindex = 1;
		else
			Bindex = 2;
		end
		proxy:Warp( heroine , list_Bpos[Bindex] );
		proxy:ChangeInitPosAng(heroine,  list_Apos[Aindex] );
		proxy:SetSpStayAndDamageAnimIdPlus( heroine , list_Banim[Bindex] ,list_Bdam[Bindex] , list_Bcan[Bindex] );
		hiroin_cancelAnimId = list_Bcan[Bindex];
		print("�q���C�� pos:",list_Bpos[Bindex]," anim:",list_Banim[Bindex]);
	elseif randA <= 90 then
		local Cindex = 1;
		--[[
		if randB <= 20 then			
			Cindex = 1;
		elseif randB <= 30 then
			Cindex = 2;
			]]
		if randB <= 20 then
			Cindex = 3;
		elseif randB <= 40 then
			Cindex = 4;
		elseif randB <= 60 then
			Cindex = 5;
		elseif randB <= 70 then
			Cindex = 6;
		elseif randB <= 80 then
			Cindex = 7;
		elseif randB <= 90 then
			Cindex = 8;
		else
			Cindex = 9;
		end
		proxy:Warp( heroine , list_Cpos[Cindex] );
		proxy:ChangeInitPosAng(heroine,  list_Apos[Aindex] );
		proxy:SetSpStayAndDamageAnimIdPlus( heroine , list_Canim[Cindex] ,list_Cdam[Cindex] ,list_Ccan[Cindex]);
		hiroin_cancelAnimId = list_Ccan[Cindex];
		print("�q���C�� pos:",list_Cpos[Cindex]," anim:",list_Canim[Cindex]);
	else
		local Dindex = 1;
		if randB <= 50 then
			Dindex = 1;
		else
			Dindex = 2;
		end
		proxy:Warp( heroine , list_Dpos[Dindex] );
		proxy:ChangeInitPosAng(heroine,  list_Apos[Aindex] );
		proxy:SetSpStayAndDamageAnimIdPlus( heroine , list_Danim[Dindex] ,list_Ddam[Dindex] ,list_Dcan[Dindex] );
		hiroin_cancelAnimId = list_Dcan[Dindex];
		print("�q���C�� pos:",list_Dpos[Dindex]," anim:",list_Danim[Dindex]);
	end	
end


--------------------------------------------------------------------------------------
--���̕ǂ̑O��b��72
--------------------------------------------------------------------------------------
function OnEvent_72(proxy,param)
	print("OnEvent_72 beign");
	proxy:SetEventFlag( 72, true );
	proxy:CloseMenu();
	proxy:TalkNextPage( 72 );
	--proxy:SetEventFlag( 61 , false );
	print("OnEvent_72 end");
end


--------------------------------------------------------------------------------------
--���̕ǂ��z�������̉�b�p��73
--------------------------------------------------------------------------------------
function OnEvent_73(proxy,param)
	print("OnEvent_73 begin");
	proxy:SetEventFlag( 73, true );
	print("OnEvent_73 end");
end


--------------------------------------------------------------------------------------
--�g���t�B�[�J����510
--------------------------------------------------------------------------------------
function OnEvent_510(proxy,param)
	print("������������������������OnEvent_510������������������������");
	Lua_RequestUnlockTrophy(proxy, 1);--�g���t�B�̏󋵂𔻒肵�A�擾����
	proxy:SetEventFlag( 510 , true );
end


function LastRemoveEquip(proxy)
	--RemoveInventoryEquip(const dl_int32 nType,const dl_int32 nId)
	print("LastRemoveEquip begin");
	proxy:RemoveInventoryEquip(TYPE_GOODS,8);	
	proxy:RemoveInventoryEquip(TYPE_GOODS,9);
	proxy:RemoveInventoryEquip(TYPE_GOODS,10);
	proxy:RemoveInventoryEquip(TYPE_GOODS,11);
	proxy:RemoveInventoryEquip(TYPE_GOODS,12);
	proxy:RemoveInventoryEquip(TYPE_GOODS,13);
	proxy:RemoveInventoryEquip(TYPE_GOODS,14);
	proxy:RemoveInventoryEquip(TYPE_GOODS,35);
	proxy:RemoveInventoryEquip(TYPE_GOODS,36);
	proxy:RemoveInventoryEquip(TYPE_GOODS,39);
	proxy:RemoveInventoryEquip(TYPE_GOODS,40);
	proxy:RemoveInventoryEquip(TYPE_GOODS,41);
	proxy:RemoveInventoryEquip(TYPE_GOODS,42);
	proxy:RemoveInventoryEquip(TYPE_GOODS,43);
	proxy:RemoveInventoryEquip(TYPE_GOODS,44);	
	print("LastRemoveEquip end");	
end

--��75�����X�{�X�̎��̒��ׂ���
function OnEvent_75(proxy,param)
	print("OnEvent_75 begin");
	proxy:SetDispMask(821, 1);--�g���������Ă���̂��H
	print("OnEvent_75 end");
end


--�\�E���u�����h�𒲂ׂ�
function OnEvent_141(proxy, param)
	if param:IsNetMessage() == false then
	print("OnEvent_141 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:PlayAnimation( 10000 , 8290);		
		proxy:PlayAnimation( 1130 , 1);	
		proxy:OnKeyTime2( 141 , "OnEvent_141_0",0.01,0,0,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();	
	print("OnEvent_141 end");
	end
end

function OnEvent_141_0(proxy,param)
	print("OnEvent_141_0 begin");
	--if proxy:IsPlayerStay(10000) == true then
	if proxy:IsEventAnim( 10000 , 8290 ) == true then
		proxy:LuaCallStart( 141 , 2 );
	else
		proxy:ForcePlayAnimation( 1130 , 0);	
	end
	print("OnEvent_141_0 end");
end

--��141_1���A�C�e���擾��
function OnEvent_141_1(proxy, param)
	print("OnEvent_141_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10104�Q��
	proxy:GetRateItem(10730);	
	
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 141, 1 );
	
	--OBJ���������߂̃C�x���g�z�M
	proxy:LuaCallStart( 141, 1);
	
	print("OnEvent_141_1 end");
end

--��141_2����OBJ��\���p��
function OnEvent_141_2(proxy,param)
	print("OnEvent_141_2 begin");
	--�I�u�W�F��������
	proxy:SetDrawEnable( 1130 , false );--�ЂƂ܂��`�悾��OFF
	proxy:SetColiEnable( 1130 , false );--������͂���͕̂s��(����ł͂Ȃ��悤�Ȃ̂ŏ����Ȃ�)	
	--�C�x���g������
	proxy:DeleteEvent( 141 );
	print("OnEvent_141_2 end");
end

--�A�j���Đ��̓������Ď�
function OnEvent_141_3(proxy,param)
	print("OnEvent_141_3 begin");
	
	proxy:TreasureDispModeChange2( 1130, false ,KEN_SFX);
	proxy:InvalidSfx( 1131 , true );
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8290 ) == true then--�V�����A�j�� 
		proxy:PlayAnimation( 1130 , 1);	
		print("OnEvent_141_3 end");
		return true;
	end
	
	--���Ƀ��[�v
	proxy:WarpDmy( LOCAL_PLAYER , 1130 , 191 );		
	
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 141 , LOCAL_PLAYER , 8290 , "OnEvent_141_1", once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_141_3 end");
end

function OnEvent_141_WAIT(proxy,param)
	print("OnEvent_141_WAIT begin");
	--�z�X�g�A�����A�O���C�̂ݒ��ׂ邱�Ƃ��ł���
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;				
	proxy:OnDistanceActionAttribute( 141 , LOCAL_PLAYER , 1130 , "OnEvent_141" , ItemBoxDist_A , 10010135 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
	proxy:LuaCall( 141,1,"OnEvent_141_2",once);
	proxy:LuaCall( 141,2,"OnEvent_141_3",once);
	proxy:SetDrawEnable( 1130 , true );
	proxy:SetColiEnable( 1130 , true );
	proxy:TreasureDispModeChange2( 1130, true ,KEN_SFX);
	print("OnEvent_141_WAIT end")
end
