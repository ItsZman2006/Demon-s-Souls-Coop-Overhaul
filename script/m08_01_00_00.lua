once = 1;
everytime = 0;


--�E�ƃe�X�g�p
test_flag_solder    = 15000;
test_flag_magi_kure = 15001;
test_flag_hanta     = 15002;

name_list = {"��ʕ��m","�}�W�V����","�n���^","�N�����b�N"};

now_job_type_SOL  = 1;
now_job_type_MAJI = 2;
now_job_type_HAN  = 3;
now_job_type_KURE = 4;


--------------------------------------------------------------------------------------
--������
--------------------------------------------------------------------------------------
function Initialize_m08_01_00_00(proxy)
	print("Initialize m08_01_00_00 begin");

--��14209���`���[�g���A�����S��
	proxy:SetEventFlag(14209,true);--�ԗp���S����t���OON	
	
--��14210���n�V�SA(�΂�10�x)�~�聡
	--proxy:OnActionEventRegion(14210, 2200, "OnEvent_14210", LadderAngle_A, HELPID_DOWN, everytime);

--��14215���n�V�SA(�΂�10�x)���聡
	--proxy:OnActionEventRegion(14215, 2201, "OnEvent_14215", LadderAngle_A, HELPID_UP,   everytime);

--��14225���ԓV�������
	--proxy:OnRegionJustIn( 14225, 10000, 2300, "OnEvent_14225", once);
	
	--�|�����J�n�̃n���h��
	--proxy:LuaCall( 14225, REMO_START , "OnEvent_14225_RemoStart",once);
	--proxy:LuaCall( 14225, REMO_FINISH , "OnEvent_14225_RemoFinish",once);
	

--��14320���������ŕ�����
--(���񂾂Ƃ��ɒǉ�)

--��14200���C���t�H�\���F���U����
	proxy:OnRegionJustIn( 14200 , 10000 , 2240 , "OnEvent_14200" , once );
		
--��14212���C���t�H�\���F�p���B��
	proxy:OnRegionJustIn( 14212 , 10000 , 2235 , "OnEvent_14212" , once );
	
--��14213���C���t�H�\���F���莝���ւ���
	proxy:OnRegionJustIn( 14213 , 10000 , 2236 , "OnEvent_14213" , once );
	
--��14005�����鎀�́�
	proxy:OnRegionJustIn( 14005 , 10000 , 2310 , "OnEvent_14005" , once );
	
--��14006���A�C�e���g�p��
	proxy:OnRegionJustIn( 14006 , 10000 , 2311 , "OnEvent_14006" , once );
	
--��14214���C���t�H�\���F�r�n�r�T�C���̏�������
	--proxy:OnRegionJustIn( 14214 , 10000 , 2237 , "OnEvent_14214" , everytime );--[[everytime]]
	
--��14221���C���t�H�\���F���l��SOS��
	--proxy:OnRegionJustIn( 14221 , 10000 , 2239 , "OnEvent_14221" , everytime );--[[everytime]]
	
--��14241�����[�v���遡
	SingleReset( proxy, 14241 );--�ƂĂ��Ȃ��O�̂��߁c	
	
--��14201���C���t�H�\���F����`�F���W�i�\���W���[�j��
	proxy:OnRegionJustIn( 14201 , 10000 , 2241 , "OnEvent_14201" , once );
	
--��14325���C���t�H�\���F����U����
	proxy:OnRegionJustIn( 14325 , 10000 , 2238 , "OnEvent_14325" , once );
	
	
	
--��14202���C���t�H�\���F����`�F���W�i�}�W�V����or�N�����b�N�j��
	proxy:OnRegionJustIn( 14202 , 10000 , 2242 , "OnEvent_14202" , once );
	
--��14203���C���t�H�\���F���@��
	proxy:OnRegionJustIn( 14203 , 10000 , 2243 , "OnEvent_14203" , once );
	
--��14208���C���t�H�\���F���@�I����
	proxy:OnRegionJustIn( 14208 , 10000 , 2249 , "OnEvent_14208" , once );
	
	
--��14204���C���t�H�\���F����`�F���W�i�n���^�[�j��
	proxy:OnRegionJustIn( 14204 , 10000 , 2244 , "OnEvent_14204" , once );
	
--��14205���C���t�H�\���F���莝���ւ�������
	proxy:OnRegionJustIn( 14205 , 10000 , 2245 , "OnEvent_14205" , once );
	
--��14206���C���t�H�\���F�|�ˌ���
	proxy:OnRegionJustIn( 14206 , 10000 , 2246 , "OnEvent_14206" , once );
	
--��14207���C���t�H�\���F�����ˌ����[�h��
	proxy:OnRegionJustIn( 14207 , 10000 , 2247 , "OnEvent_14207" , once );
	
--��14211���C���t�H�\���F�����ˌ����[�h������
--(14207����A��)


--��14350���C���t�H�\���F��Ձ�
	proxy:OnRegionJustIn( 14350 , 10000 , 2250 , "OnEvent_14350" , once);
	
--��14351���C���t�H�\���F��ՑI����
	proxy:OnRegionJustIn( 14351 , 10000 , 2251 , "OnEvent_14351" , once);

	
	
--��14305���C���t�H�\���F���@����
	proxy:OnRegionJustIn( 14305 , 10000 , 2248 , "OnEvent_14305" , once );

--��14306���C���t�H�\���F���̔���
	proxy:OnRegionJustIn( 14306 , 10000 , 2312 , "OnEvent_14306" , once );
	
--��14291�����̕ǁ�
	if proxy:IsCompleteEvent( 14291 ) == false then
		proxy:OnDistanceAction( 14291 , 10000 , 1271 , "OnEvent_14291" , 1.5, 10010403 , 0 , 90 , once );
	else
		proxy:SetDrawEnable( 1271 , false );--���@�Ǖ`��OFF
		proxy:SetColiEnable( 1271 , false );--���@�Ǔ�����OFF		
		proxy:InvalidSfx( 2275 , false );--SFX OFF
	end

--��14231���{�X�����ɓ��遡
	if proxy:IsCompleteEvent( 14233 ) == false then
		SingleReset(proxy , 14232 );
		SingleReset(proxy , 14231 );
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���)
		proxy:LuaCall( 14232, 1, "OnEvent_14232_1", everytime );
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCall( 14232 , 5 , "OnEvent_14231_GO_TO_IN" , everytime );
		--���t���O�Z�b�g(�����p)
		proxy:LuaCall( 14232 , 6 , "OnEvent_14231_flag_set" , everytime );
		
		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ�
		if proxy:IsCompleteEvent( 14231 ) == false then	
			
			--<�ǉ�>�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B
			--SingleReset(proxy, 14231);			
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l����
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--��14231�����ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegionAttribute( 14231, 2290, "OnEvent_14231", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B
		
			proxy:NotNetMessage_begin();
				--��14232�����ɓ��邽�߂̃C�x���g��ǉ���--�n���h���͏�Ɠ���
				proxy:OnPlayerActionInRegion( 14232, 2290, "OnEvent_14231", HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();		
		end
	end

--��14234���{�X�������o����
--��14232���{�XBGM�Đ���
	if proxy:IsCompleteEvent( 14233 ) == false then
		SingleReset( proxy, 14234 );
		--SingleReset( proxy, 14232 );
		proxy:OnRegionJustIn( 14234 , 10000 , 2291 , "OnEvent_14234" , once );
	end


--��14233���{�X���S������
	proxy:AddFieldInsFilter( 300 );
	if proxy:IsCompleteEvent( 14233 ) == false then
		proxy:OnCharacterDead( 14233 , 300 , "OnEvent_14233" , once );
		--���{�X�֘A�̏���������
		if proxy:IsCompleteEvent( 14301 ) ==false then	
			--��(�\�E��?)
			proxy:SetDrawEnable( 1310 , false );
			proxy:SetColiEnable( 1310 , false );			
			--���\��OFF
			proxy:SetDrawEnable( 1311 , false );
			proxy:SetColiEnable( 1311 , false );			
			--SFX ������
			proxy:InvalidSfx( 1290 , false );--�\�E���p
			proxy:InvalidSfx( 1291 , false );--�{�X�A�C�e���p		
		end
	else
		InvalidCharactor( proxy , 300 );
		--���{�X�����̖��@�ǂ�������
		proxy:SetColiEnable( 1272 , false );
		proxy:SetDrawEnable( 1272 , false );
		proxy:InvalidSfx( 2274, true );
		--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
		if proxy:IsCompleteEvent( 14301 ) == false then
			proxy:ValidSfx( 1290 );--���̗��q
			proxy:ValidSfx( 1291 );--SFX �L����
			--proxy:TreasureDispModeChange2( 1310 , true ,KANAME_SFX);--���点��		
			proxy:TreasureDispModeChange2( 1311 , true ,KANAME_SFX);--���点��
			proxy:OnDistanceActionAttribute( 14301 , 10000 , 1310 , "OnEvent_14301" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_NOSESSION, once );
		else
			proxy:InvalidSfx( 1290 ,false);--���̗��q
			--proxy:InvalidSfx( 1291 ,false);--SFX �L����
			proxy:OnDistanceAction( 14242 , 10000 , 1311 , "OnEvent_14242" , WarpGimmickDist_A , 10010180 , 0 , 180, everytime );
		end
	end	
	
--��14230���{�X�J�����؂�ւ���
	proxy:OnRegionIn( 14230 , 10000, 2292 , "OnEvent_14230" , everytime );
	

--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m08_01_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m08_01_00_00", everytime );
	proxy:NotNetMessage_end();
	
	--	proxy:PlayerRecover();--�v���C���[�S�� �S�񕜂��Ȃ����
	proxy:SetHp( 10000 , 1.0 );
	proxy:SetDeadMode( 10000 , true );--�v���C���[�͎��ȂȂ�
	proxy:EnableLogic( 300 , false );--���{�X���W�b�NOFF
	
	--[[
	--�O���C�S�[�X�g�ɂȂ����Ƃ�(��V������Ŏ���œǂݍ��݂�ʂ����Ƃ�)
	if proxy:IsCompleteEvent( 14226 ) == true then

		--���`���[�g���A���p�̎����̌������폜�֐�
		proxy:InvalidMyBloodMarkInfo_Tutorial();
	
		--��(����)�����������̃C�x���g�o�^��
		proxy:OnKeyTime2( 14227 , "OnEvent_14227" , 0.0 , 0 , 1 , once );
	
	--������Ԃ̂Ƃ�
	else
		proxy:InvalidSfx( 2218 , false );--�����̌�������\��OFF
	end
	]]
	
	
	--���C�x���g�Č�(���K�̃O���C�S�[�X�g�ɂȂ邽�߂ɓǂݍ��݂�ʂ�����)
	--[[
	--��V�����
	if proxy:IsCompleteEvent( 14225 ) == true then

		proxy:ReconstructBreak( 1300 , 1 );--�������^�C�~���O��x�点�����ꂽ
	end
	]]
	
	--��14410���p�j�S�[�X�g�n����
	proxy:SetDrawEnable( 401 , false );
	proxy:SetDrawEnable( 402 , false );
	proxy:SetDrawEnable( 403 , false );
	proxy:SetDrawEnable( 404 , false );
	proxy:OnRegionJustIn( 14410 , 10000 , 2291 , "OnEvent_14410" , once);


	
	
	--�E�ƕʃC�x���g�e�X�g�p
	
	--�f�t�H���g�̓\���W���[
	--now_job = test_flag_solder;
	
	now_job_type = JobCheck(proxy, now_job);
	
	now_job_name = name_list[now_job_type];
	
	print("���̐E�Ƃ�"..now_job_name.."�ł�");	
	
	proxy:OnKeyTime2(999991,"Second_Initialize_m08_01_00_00",0.1,0,0,once);
	
	print("Initialize_m08_01_00_00 end");
end

--�P�t���[����̏�����
function Second_Initialize_m08_01_00_00(proxy,param)
	print("Second_Initialize_m08_01_00_00 begin");
	--�E�Ɨp�q���g����������
	now_job_type = JobCheck(proxy, now_job);
	if now_job_type == now_job_type_SOL then
		--��m�Ȃ�
		print("��m�ȊO�̌���������");
		proxy:InvalidHintMsgId(9200);
		proxy:InvalidHintMsgId(9300);
		proxy:InvalidHintMsgId(9400);
		proxy:InvalidHintMsgId(9500);
	elseif now_job_type == now_job_type_MAJI then
		--���@�Ȃ�		
		print("���@�ȊO�̌���������");
		proxy:InvalidHintMsgId(9300);
		proxy:InvalidHintMsgId(9400);
		proxy:InvalidHintMsgId(9500);
	elseif now_job_type == now_job_type_HAN then
		--�n���^�[�Ȃ�
		print("�n���^�[�ȊO�̌���������");
		proxy:InvalidHintMsgId(9200);
		proxy:InvalidHintMsgId(9300);		
	else
		--����ȊO�Ȃ�
		print("�_�E�ȊO�̌���������");
		proxy:InvalidHintMsgId(9200);		
		proxy:InvalidHintMsgId(9400);
		proxy:InvalidHintMsgId(9500);
	end
	print("Second_Initialize_m08_01_00_00 end");
end

--------------------------------------------------------------------------------------
--�}���`�ɂȂ������Ƀz�X�g���ᖳ�������灡����
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end

---------------------------------
--PC�̃W���u�������𔻒肷��֐�
---------------------------------
function JobCheck(proxy, now_job_style)
	--PC�̃W���u�̃^�C�v����m�n�������ꍇ
	local job = now_job_type_SOL;
	
	if proxy:IsJobType( JOB_MERCENARY ) == true then
		--print("�b��");
		job = now_job_type_SOL;
	end
	if proxy:IsJobType( JOB_LOW_SOLDIER ) == true then
		--print("�������m");
		job = now_job_type_SOL;
	end
	if proxy:IsJobType( JOB_LOW_KNIGHT ) == true then
		--print("�����R�m");
		job = now_job_type_SOL;
	end
	if proxy:IsJobType( JOB_NEET ) == true then
		--print("�j�[�g��");
		job = now_job_type_SOL;
	end
	   
	--PC�̃W���u�̃^�C�v���n���^�[�n�������ꍇ	
	if proxy:IsJobType( JOB_HUNTER ) == true then	
		--print("��l");
		job = now_job_type_HAN;
	end	
	if proxy:IsJobType( JOB_THIEF ) == true then
		--print("����");
		job = now_job_type_HAN;
	end	
		
	--PC�̃W���u�̃^�C�v�����p�t	
	if proxy:IsJobType( JOB_SHAMAN ) == true then
		--print("���p�t");
		job = now_job_type_MAJI;
	end
	if proxy:IsJobType( JOB_NOBLEMAN ) == true then
		--print("�M��");
		job = now_job_type_MAJI;
	end
	
	--PC�̃W���u�̃^�C�v���m���n�������ꍇ
	if proxy:IsJobType( JOB_TEMPLE_KNIGHT ) == true then
		--print("�_�a�R�m");
		job = now_job_type_KURE;
	end
	if proxy:IsJobType( JOB_CLERIC ) == true then
		--print("���E��");
		job = now_job_type_KURE;
	end
	
	return job;
end

--[[
--------------------------------------------------------------------------------------
--�ԓV�������14225
--------------------------------------------------------------------------------------

--��14225���ԓV�����
function OnEvent_14225(proxy, param)
	print("OnEvent_14225 begin");
	
	--��I�u�W�F��j�Ђɐ؂�ւ�
	--proxy:ChangeModel(1300, 1);
	--proxy:SetBrokenPiece(1300);
	--�j��SE�Đ�
	--proxy:PlayObjectSE(1300,22400000);

	--�v���C���[�s������
	--proxy:EnableLogic( 10000 , false );
	proxy:StopPlayer();
	
	--proxy:SetSuperArmor( 10000 , true );
	
	--��14226�����b�づ
	--proxy:OnKeyTime2( 14226 , "OnEvent_14226" , 2.0 , 0 , 1 , once );
	proxy:RequestRemo( 80100 , REMO_FLAG,14225,1);

	--�t���OON
	proxy:SetEventFlag( 14225, 1 );
	
	print("OnEvent_14225 end");
end

function OnEvent_14225_RemoStart(proxy,param)
	print("OnEvent_14225_RemoStart begin");
	InvalidCharactor( proxy, 10000);
	print("OnEvent_14225_RemoStart end");
end

function OnEvent_14225_RemoFinish(proxy,param)
	print("OnEvent_14225_RemoFinish begin");
	--��14226�����b�づ
	--proxy:OnKeyTime2( 14226 , "OnEvent_14226_1" , 2.0 , 0 , 1 , once );
	OnEvent_14226_2(proxy,param);
	print("OnEvent_14225_RemoFinish end");
end

--[[
--��14226�����b�っ
function OnEvent_14226(proxy, param)
	print("OnEvent_14226 begin");

	proxy:PlayAnimation( 10000 , 6000 );--�v���C���[���S�A�j��(�������O���C)
	
	--��14226_1���v���C���[���S�A�j���I����
	proxy:OnChrAnimEnd( 14226 , 10000 , 6000 , "OnEvent_14226_1" , once );
	
	print("OnEvent_14226 end");
end
]]

--��14226_1���v���C���[���S�A�j���I����
function OnEvent_14226_1(proxy, param)
	print("OnEvent_14226_1 begin");

	--proxy:PlayLoopAnimation( 10000 , 6050 );--�v���C���[���S�ҋ@�A�j��
	
	--�����������j���[�I����
	--proxy:OnBloodMenuClose(14226, "OnEvent_14226_2",300.0, once);
	--OnEvent_14226_2(proxy,param);
	
	print("OnEvent_14226_1 end");
end

--��14226_2�����������j���[�I����
function OnEvent_14226_2(proxy, param)
	print("OnEvent_14226_2 begin");

	--�i����j�������ESOS SFX�\���ؑ�
	
	proxy:ValidSfx( 2218 );
	proxy:InvalidSfx( 2216 , false );
	
	--�v���C���[�ɐ����������Ă����̂�����
	
	proxy:StopLoopAnimation( 10000 );--���S�ҋ@�A�j������߂�
	proxy:EnableLogic( 10000 , true );--�s����������	
	proxy:SetSuperArmor( 10000 , false );
	
	--�O���C�S�[�X�g�ɂȂ�(�ǂݍ��݂�ʂ��K�v������)
	
	--���݂̃}�b�v�Ɠ���ID�����}�b�vID�Ƃ��Đݒ�
	proxy:SetDefaultMapUid(-1);
	--���[�v���s��
	proxy:WarpNextStageKick();
	--�O���C�S�[�X�g��
	proxy:SetChrTypeDataGrey();
	proxy:SetHp( 10000 , 1.0 );--HP�S��?(���J�o�[�őS���ɂȂ�Ȃ������̂ť��)
	
--[[--�ǂݍ��݃^�C�~���O�ŌĂ΂��悤�ɕύX
	--��14227�����b�づ
	proxy:OnKeyTime2( 14227 , "OnEvent_14227" , 2.0 , 0 , 1 , once );
]]	
	proxy:SetEventFlag( 14226 , 1 );
	
	print("OnEvent_14226_2 end");
end
]]

--[[
--��14227�����b�っ
function OnEvent_14227(proxy, param)
	print("OnEvent_14227 begin")

	--�C���t�H���[�V�������b�Z�[�W�̕\��
	Display_InfomationMenu_2(proxy, 0, -1, 30, 81001400, 1, -1, 30, 81001401, 7);
	--Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14227 , 1 );
	
	--��(����)�����������C�x���g�Ď��ǉ���
	proxy:OnPlayerActionInRegion( 14320 , 2217 , "OnEvent_14320" , 50000200 , everytime );--[[everytime]]
	
	print("OnEvent_14227 end");
end
]]

--[[
--------------------------------------------------------------------------------------
--������������14320
--------------------------------------------------------------------------------------

--��14320������������
function OnEvent_14320(proxy, param)
	print("OnEvent_14320 begin");
	
	--��V�����(14227)���Ō�܂ŏI����Ă���(=�O���C�S�[�X�g�̂Ƃ�)
	if proxy:IsCompleteEvent( 14227 ) == true then
	
		--�V�X�e�����b�Z�[�W(�������������܂���)
		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
		proxy:AddInfomationBuffer(20000020);
		
		--��������̂Ńy�i���e�B�Ō��������p�����[�^�����ɖ߂�(�ő�l�̂�)
		proxy:EraseEventSpecialEffect( 10000, 101 );
		proxy:PlayerParamRecover();
		proxy:ResetEventQwcSpEffect(LOCAL_PLAYER);
	
		--��14321�����b��ɕ�����
		proxy:OnKeyTime2( 14321 , "OnEvent_14321" , 3.0 , 0 , 1 , once );
		
		proxy:SetEventFlag( 14320, 1 );--�t���OON
		proxy:DeleteEvent( 14320 );--everytime�Ȃ̂ŏ���
	end

	print("OnEvent_14320 end");
end


--��14321�����b��ɕ�����
function OnEvent_14321(proxy ,param)
	print("OnEvent_14321 begin");

	--��������̂Ńy�i���e�B�Ō��������p�����[�^�����ɖ߂�(�ő�l�̂�)
	proxy:PlayerParamRecover();

	--�L�����N�^�̃^�C�v�𐶑��ɕύX(�ēǂݍ��݂�ʂ��Ȃ��ׁA����ŉ��Ή�)���K�̓v���C���[��p�̐����^�C�v�ݒ胁�\�b�h�őΉ�
	proxy:SetChrType( 10000, 0 );
		
	--�����̌�������\��(&SOS���@��������)
	proxy:InvalidMyBloodMarkInfo();
	
	--(����)�������SOS SFX�\���ؑ�
	proxy:InvalidSfx( 2218 , false );
	proxy:ValidSfx( 2216 );
	
	proxy:SetEventFlag( 14321 , 1 );

	print("OnEvent_14321 end");
end
]]

--[[
--------------------------------------------------------------------------------------
--�n�V�SB�~�聡14210
--------------------------------------------------------------------------------------
--��14210���n�V�SB�~��X�^�[�g��
function OnEvent_14210(proxy, param)
	print("OnEvent_14210 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_14210 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,2,2);				--�z�o�[�ړ����[�h�Ɉڍs
	proxy:HoverMoveValDmy(10000,1204,192,LadderTime_A);--�ړ��ʒu(192)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,1);				--�C�x���g�R�}���hID(1)"�n�V�S�ォ���"�ނ𑗂�
--	proxy:SetKeepCommandIndex(10000, 4, 1, 3.0 );
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(14210,"OnEvent_14210_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���)
		proxy:OnKeyTime2(14210,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_14210 end");
end

--��14210_1���n�V�SB�~��X�^�[�g:�z�o�[�ړ��I����
function OnEvent_14210_1(proxy, param)
	print("OnEvent_14210_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_14210_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,7,6);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_14210_1 end");
end
]]

--[[
--------------------------------------------------------------------------------------
--�n�V�SB���聡14215
--------------------------------------------------------------------------------------
--��14215���n�V�SB����X�^�[�g��
function OnEvent_14215(proxy, param)
	print("OnEvent_14215 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_14215 end");
		return;
	end
	
	--�͂�������ɕK�v�ȑO����--
	proxy:BeginAction(10000,2,-1,1);			--�z�o�[�ړ����[�h�Ɉڍs
	proxy:HoverMoveValDmy(10000,1204,191,LadderTime_A);--�ړ��ʒu(191)��0.5�b�Ńz�o�[�ړ�
	proxy:SetEventCommand(10000,0);				--�C�x���g�R�}���hID(0)"�n�V�S�������"�ނ𑗂�
--	proxy:SetKeepCommandIndex(10000, 4, 1, 3.0 );
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\��
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂�������X�^�[�g�C�x���g�𔭍s
		proxy:OnKeyTime2(14215,"OnEvent_14215_1",LadderTime_A,0,0,once);
		--�͂�������p�̊֐���1�b�Ԕ��s(�C�x���g���j���[�̒��f����?)
		proxy:OnKeyTime2(14215,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_14215 end");
end

--��14215_1���n�V�SA����X�^�[�g:�z�o�[�ړ��I����
function OnEvent_14215_1(proxy, param)
	print("OnEvent_14215_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_14215_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1)
	proxy:BeginAction(10000,1,-1,6);
	
	--�L�����N�^���ړ��A����\��--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_14215_1 end");
end
]]


--------------------------------------------------------------------------------------
--�}�b�v�ړ��i���n��L��j��14241
--------------------------------------------------------------------------------------

--��14241���}�b�v�ړ��i���n��L��j
function OnEvent_14241(proxy, param)
	print("OnEvent_14241 begin");

--�E���ǂ蒅�����o�b�̂݁A�Ԃ���n��L��im08_02_00_00�j�̎w��ʒu�Ɉړ�
--�E�ړ���im08_02_00_00�j�̑Ή��L�����C�x���gID
--�@�o�b�i0�j���L�����i30�j
--�@�o�b�i1�j���L�����i31�j
--�@�o�b�i2�j���L�����i32�j
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ�
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage( 8,02,00,00, 30); end
	if playerId ==1 then proxy:WarpNextStage( 8,02,00,00, 31); end
	if playerId ==2 then proxy:WarpNextStage( 8,02,00,00, 32); end
	if playerId ==3 then proxy:WarpNextStage( 8,02,00,00, 33); end

	--���ړ�����L�����N�^�[�́A�ړ����Ƀp�b�Ə����Ă��܂��܂�
	
	proxy:SetEventFlag( 14241, true );
	
	print("OnEvent_14241 end");
end


--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m08_01_00_00(proxy, param)
	print("PlayerDeath_m08_01_00_00");
	print("PlayerDeath_m08_01_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m08_01_00_00(proxy,param)
	print("PlayerRevive_m08_01_00_00");	
	print("PlayerRevive_m08_01_00_00");
end



--------------------------------------------------------------------------------------
--�C���t�H�\���F���U����14200
--------------------------------------------------------------------------------------

--��14200���C���t�H�\���F���U����
function OnEvent_14200(proxy , param)
	print("OnEvent_14200 begin");
	
	--�C���t�H���[�V�������b�Z�[�W�̕\��
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80000400, 1, -1, 30, 80000401, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14200 , 1 );	
	
	print("OnEvent_14200 end");
end



--------------------------------------------------------------------------------------
--�C���t�H�\���F�p���B��14212
--------------------------------------------------------------------------------------

--��14212���C���t�H�\���F�p���B��
function OnEvent_14212(proxy , param)
	print("OnEvent_14212 begin");
	
	--�C���t�H���[�V�������b�Z�[�W�̕\��
	Display_InfomationMenu_2(proxy, 0, -1, 30, 81000000, 1, -1, 30, 81000001, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14212 , 1 );
	
	print("OnEvent_14212 end");
end


--------------------------------------------------------------------------------------
--�C���t�H�\���F���莝���ւ���14213
--------------------------------------------------------------------------------------

--��14213���C���t�H�\���F���莝���ւ���
function OnEvent_14213(proxy , param)
	print("OnEvent_14213 begin");
	
	--�C���t�H���[�V�������b�Z�[�W�̕\��
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80000900, 1, -1, 30, 80000901, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14213 , 1 );
	
	print("OnEvent_14213 end");
end


--------------------------------------------------------------------------------------
--�C���t�H�\���F���鎀�́�14005
--------------------------------------------------------------------------------------
function OnEvent_14005(proxy,param)
	print("OnEvent_14005 begin");
	
	--�C���t�H���[�V�������b�Z�[�W�̕\��
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80000500, 1, -1, 30, 80000501, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14005 , 1 );
	
	print("OnEvent_14005 end");
end


--------------------------------------------------------------------------------------
--�C���t�H�\���F�A�C�e���g�p��14006
--------------------------------------------------------------------------------------
function OnEvent_14006(proxy,param)
	print("OnEvent_14006 begin");
	
	--�C���t�H���[�V�������b�Z�[�W�̕\��
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80000600, 1, -1, 30, 80000601, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14006 , 1 );
	
	print("OnEvent_14006 end");
end


--[[
--------------------------------------------------------------------------------------
--�C���t�H�\���F�r�n�r�T�C���̏�������14214
--------------------------------------------------------------------------------------

--��14214���C���t�H�\���F�r�n�r�T�C���̏�������
function OnEvent_14214(proxy , param)
	print("OnEvent_14214 begin");
	
	--��V�����(14227)���I����Ă���
	if proxy:IsCompleteEvent( 14227 ) == true then
	
		--�C���t�H���[�V�������b�Z�[�W�̕\��
		Display_InfomationMenu_2(proxy, 0, -1, 30, 83000000, 1, -1, 30, 83000001, 7);
		--Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14214 , 1 );
		proxy:DeleteEvent( 14214 );--everytime�Ȃ̂ŏ���
	end
	
	print("OnEvent_14214 end");
end
]]

--[[
--------------------------------------------------------------------------------------
--�C���t�H�\���F���l��SOS��14221
--------------------------------------------------------------------------------------

--��14221���C���t�H�\���F���l��SOS��
function OnEvent_14221(proxy , param)
	print("OnEvent_14221 begin");
	
	--��V�����(14227)���I����Ă��Ȃ� or �������ŕ���(14320)���I����Ă���
	if proxy:IsCompleteEvent( 14227 ) == false or
	   proxy:IsCompleteEvent( 14320 ) == true  then

		--�C���t�H���[�V�������b�Z�[�W�̕\��
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81001300, 1, -1, 30, 81001301, 7);
		--Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14221 , 1 );
		proxy:DeleteEvent( 14221 );--everytime�Ȃ̂ŏ���
	end
	
	print("OnEvent_14221 end");
end
]]



--------------------------------------------------------------------------------------
--�C���t�H�\���F����`�F���W�i�\���W���[�j��14201
--------------------------------------------------------------------------------------

--��14201���C���t�H�\���F����`�F���W�i�\���W���[�j��
function OnEvent_14201(proxy , param)
	print("OnEvent_14201 begin");
	
	now_job_type = JobCheck(proxy, now_job);
	
	--�\���W���[�̂Ƃ������\��(�f�o�b�N�p�̔���ǉ�)
	if now_job_type == now_job_type_SOL then
	
		--�C���t�H���[�V�������b�Z�[�W�̕\��
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81000100, 1, -1, 30, 81000101, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14201 , 1 );
		
		--��14325���C���t�H�\���F����U����
		--if proxy:IsCompleteEvent( 14325 ) == false then
		--	proxy:OnKeyTime2( 14325 , "OnEvent_14325" , 10.0 , 0 , 1 , once );
		--end
	end
	
	print("OnEvent_14201 end");
end


--------------------------------------------------------------------------------------
--�C���t�H�\���F����U����14325
--------------------------------------------------------------------------------------

--��14325���C���t�H�\���F����U����
function OnEvent_14325(proxy , param)
	print("OnEvent_14325 begin");
	
	now_job_type = JobCheck(proxy, now_job);
	
	--�\���W���[�̂Ƃ������\��(�f�o�b�N�p�̔���ǉ�)
	if now_job_type == now_job_type_SOL then
	
		--���d�����h�~
		if proxy:IsCompleteEvent( 14325 ) == true then
			print("OnEvent_14325 end");
			return ;
		end
		
		--�C���t�H���[�V�������b�Z�[�W�̕\��
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81001200, 1, -1, 30, 81001201, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14325 , 1 );	
	end
	
	print("OnEvent_14325 end");
end



--------------------------------------------------------------------------------------
--�C���t�H�\���F����`�F���W�i�}�W�V����or�N�����b�N�j��14202
--------------------------------------------------------------------------------------

--��14202���C���t�H�\���F����`�F���W�i�}�W�V����or�N�����b�N�j��
function OnEvent_14202(proxy , param)
	print("OnEvent_14202 begin");
	
	now_job_type = JobCheck(proxy, now_job);
	
	--�E�B�U�[�hor�N�����b�N�̂Ƃ������\��
	if now_job_type == now_job_type_MAJI or now_job_type == now_job_type_KURE then
	
		--�C���t�H���[�V�������b�Z�[�W�̕\��
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81000200, 1, -1, 30, 81000201, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14202 , 1 );
		
		--���C���t�H�\���F���@��
		--if proxy:IsCompleteEvent( 14203 ) == false then
		--	proxy:OnKeyTime2( 14203 , "OnEvent_14203" , 10.0 , 0 , 1 , once );
		--end
	end
	
	print("OnEvent_14202 end");
end


--------------------------------------------------------------------------------------
--�C���t�H�\���F���@��14203
--------------------------------------------------------------------------------------

--��14203���C���t�H�\���F���@��
function OnEvent_14203(proxy , param)
	print("OnEvent_14203 begin");
	
	now_job_type = JobCheck(proxy, now_job);
	
	--�E�B�U�[�hor�N�����b�N�̂Ƃ������\��
	if now_job_type == now_job_type_MAJI then
	
		--���d�����h�~
		if proxy:IsCompleteEvent( 14203 ) == true then
			print("OnEvent_14203 end");
			return;
		end
		
		--�C���t�H���[�V�������b�Z�[�W�̕\��
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81000300, 1, -1, 30, 81000301, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14203 , 1 );	
		
		--���C���t�H�\���F���@�I����
		--if proxy:IsCompleteEvent( 14208 ) == false then
		--	proxy:OnKeyTime2( 14208 , "OnEvent_14208" , 10.0 , 0 , 1 , once );
		--end
	end
	
	print("OnEvent_14203 end");
end



--------------------------------------------------------------------------------------
--�C���t�H�\���F���@�I����14208
--------------------------------------------------------------------------------------

--��14208���C���t�H�\���F���@�I����
function OnEvent_14208(proxy , param)
	print("OnEvent_14208 begin");
	
	now_job_type = JobCheck(proxy, now_job);
	
	--�E�B�U�[�hor�N�����b�N�̂Ƃ������\��
	if now_job_type == now_job_type_MAJI then
	
		--���d�����h�~
		if proxy:IsCompleteEvent( 14208 ) == true then
			print("OnEvent_14208 end");
			return;
		end
		
		--�C���t�H���[�V�������b�Z�[�W�̕\��
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81000400, 1, -1, 30, 81000401, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14208 , 1 );	
	end
	
	print("OnEvent_14208 end");
end



--------------------------------------------------------------------------------------
--�C���t�H�\���F����`�F���W�i�n���^�[�j��14204
--------------------------------------------------------------------------------------

--��14204���C���t�H�\���F����`�F���W�i�n���^�[�j��
function OnEvent_14204(proxy , param)
	print("OnEvent_14204 begin");
	
	now_job_type = JobCheck(proxy, now_job);
	
	--�n���^�[�̂Ƃ������\��
	if now_job_type == now_job_type_HAN then
	
		--�C���t�H���[�V�������b�Z�[�W�̕\��
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81000500, 1, -1, 30, 81000501, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14204 , 1 );
		
		--���C���t�H�\���F���莝���ւ�������
		--if proxy:IsCompleteEvent( 14205 ) == false then
		--	proxy:OnKeyTime2( 14205 , "OnEvent_14205" , 10.0 , 0 , 1 , once );
		--end
	end
	
	print("OnEvent_14204 end");
end


--------------------------------------------------------------------------------------
--�C���t�H�\���F���莝���ւ�������14205
--------------------------------------------------------------------------------------

--��14205���C���t�H�\���F���莝���ւ�������
function OnEvent_14205(proxy , param)
	print("OnEvent_14205 begin");
	
	now_job_type = JobCheck(proxy, now_job);
	
	--�n���^�[�̂Ƃ������\��
	if now_job_type == now_job_type_HAN then
	
		--���d�����h�~
		if proxy:IsCompleteEvent( 14205 ) == true then
			print("OnEvent_14205 end");
			return;
		end
		
		--�C���t�H���[�V�������b�Z�[�W�̕\��
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81000600, 1, -1, 30, 81000601, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14205 , 1 );
		
		--���C���t�H�\���F���莝���ւ�������
		--if proxy:IsCompleteEvent( 14206 ) == false then
		--	proxy:OnKeyTime2( 14206 , "OnEvent_14206" , 10.0 , 0 , 1 , once );
		--end
	end	
	
	print("OnEvent_14205 end");
end



--------------------------------------------------------------------------------------
--�C���t�H�\���F�|�ˌ���14206
--------------------------------------------------------------------------------------

--��14206���C���t�H�\���F�|�ˌ���
function OnEvent_14206(proxy , param)
	print("OnEvent_14206 begin");

	now_job_type = JobCheck(proxy, now_job);
	
	--�n���^�[�̂Ƃ������\��
	if now_job_type == now_job_type_HAN then
	
		--���d�����h�~
		if proxy:IsCompleteEvent( 14206 ) == true then
			print("OnEvent_14206 end");
			return;
		end
		
		--�C���t�H���[�V�������b�Z�[�W�̕\��
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81000700, 1, -1, 30, 81000701, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14206 , 1 );
		
		--���C���t�H�\���F�����ˌ����[�h��
		--if proxy:IsCompleteEvent( 14207 ) == false then
		--	proxy:OnKeyTime2( 14207 , "OnEvent_14207" , 10.0 , 0 , 1 , once );
		--end
	end	
	
	print("OnEvent_14206 end");
end


--------------------------------------------------------------------------------------
--�C���t�H�\���F�����ˌ����[�h��14207
--------------------------------------------------------------------------------------

--��14207���C���t�H�\���F�����ˌ����[�h��
function OnEvent_14207(proxy , param)
	print("OnEvent_14207 begin");

	now_job_type = JobCheck(proxy, now_job);
	
	--�n���^�[�̂Ƃ������\��
	if now_job_type == now_job_type_HAN then
	
		--���d�����h�~
		if proxy:IsCompleteEvent( 14207 ) == true then
			print("OnEvent_14207 end");
			return;
		end
		
		--�C���t�H���[�V�������b�Z�[�W�̕\��
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81000800, 1, -1, 30, 81000801, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14207 , 1 );
		
		--���C���t�H�\���F�����ˌ����[�h������
		--if proxy:IsCompleteEvent( 14211 ) == false then
		--	proxy:OnKeyTime2( 14211 , "OnEvent_14211_1" , 0.2 , 0 , 1 , once );
		--end
	end
		
	print("OnEvent_14207 end");
end

--[[
function OnEvent_14211_1(proxy,param)
	proxy:OnRegistFunc( 14211 , "Check_14211_2","OnEvent_14211_2",0,once);
end

function Check_14211_2(proxy)
	if proxy:IsShowMenu() == true then
		return false;
	end
	return true;
end

function OnEvent_14211_2(proxy,param)
	proxy:OnKeyTime2( 14211 , "OnEvent_14211" , 0.0 , 0 , 1 , once );
end

--���C���t�H�\���F�����ˌ����[�h������
function OnEvent_14211(proxy , param)
	print("OnEvent_14211 begin");

	now_job_type = JobCheck(proxy, now_job);
	
	--�n���^�[�̂Ƃ������\��
	if now_job_type == now_job_type_HAN then
	
		--�C���t�H���[�V�������b�Z�[�W�̕\��
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81000900, 1, -1, 30, 81000901, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14211 , 1 );	
	end
	
	print("OnEvent_14211 end");
end
]]

function OnEvent_14350(proxy,param)
	print("OnEvent_14350 begin");
	now_job_type = JobCheck(proxy, now_job);
	
	--�N�����b�N�̂Ƃ������\��
	if now_job_type == now_job_type_KURE then
	
		--�C���t�H���[�V�������b�Z�[�W�̕\��
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81001500, 1, -1, 30, 81001501, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14211 , 1 );	
	end
	print("OnEvent_14350 end");
end

function OnEvent_14351(proxy,param)
	print("OnEvent_14351 begin");
	now_job_type = JobCheck(proxy, now_job);
	
	--�N�����b�N�̂Ƃ������\��
	if now_job_type == now_job_type_KURE then
	
		--�C���t�H���[�V�������b�Z�[�W�̕\��
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81001600, 1, -1, 30, 81001601, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14211 , 1 );	
	end
	print("OnEvent_14351 end");
end


--------------------------------------------------------------------------------------
--�C���t�H�\���F���@����14305
--------------------------------------------------------------------------------------

--��14305���C���t�H�\���F���@����
function OnEvent_14305(proxy , param)
	print("OnEvent_14305 begin");
	
	--�C���t�H���[�V�������b�Z�[�W�̕\��
	Display_InfomationMenu_2(proxy, 0, -1, 30, 81001000, 1, -1, 30, 81001001, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14305 , 1 );	
	
	print("OnEvent_14305 end");
end




--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ��遡14231
--------------------------------------------------------------------------------------

--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫

--��14231�����{�X�����ւ̔����J����
function OnEvent_14231(proxy,param)
	print("OnEvent_14231 begin");
	
	--�N���C�A���g�ցA�{�X�����j�~���s��ʒm
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end

	proxy:LuaCallStart( 14232, 1 );--����A�j���̓����Đ�
	
	print("OnEvent_14231 end");
end


--����A�j���̓����Đ�(ID����)
function OnEvent_14232_1(proxy,param)
	print("OnEvent_14232_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ����s���A���̏I������OnEvent_14232_2�𔭍s����
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2280 );
		else
			--����A�j���Đ����s���A���̏I������OnEvent_14232_2�𔭍s����
			proxy:OnTurnCharactorEnd( 14232, 10000, 2280, "OnEvent_14232_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_14232_1 end");
end

--����A�j���̓����Đ��I����
function OnEvent_14232_2(proxy,param)
	print("OnEvent_14232_2 begin");

	--�����p�����A�j���Đ�
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 14232, 10000, ANIMEID_WALK, "OnEvent_14232_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_14232_2 end");
end

--�����A�j���̓����Đ��I����
function OnEvent_14232_3(proxy,param)
	print("OnEvent_14232_3 begin");

	--�ŏ��̐l���{�X�����̒��ɓ���I����Ă�����A���ɔz�M����Ă���͂��Ȃ̂ŁA����������Ȃ��n���h��
	if proxy:IsCompleteEvent( 14231 ) == false then
		proxy:LuaCallStart( 14232 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCallStart( 4045 , 1 );	--�N���C�A���g�ցA�{�X�����ɓ����悤�ɂȂ������Ƃ�ʒm
		proxy:LuaCallStart( 14232 , 6 );--�t���O�Z�b�g(�����p)
	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�)
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:ResetThink( 300 );
	end	

	print("OnEvent_14232_3 end");
end


--��14231 2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
function OnEvent_14231_GO_TO_IN(proxy, param)
	print("OnEvent_14231_GO_TO_IN begin");
		
	proxy:NotNetMessage_begin();
		--��14232�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���--�n���h���� OnEvent_14231
		proxy:OnPlayerActionInRegion( 14232, 2290, "OnEvent_14231", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	

	print("OnEvent_14231_GO_TO_IN end");
end


--��14231 �t���O�Z�b�g(�����p)
function OnEvent_14231_flag_set(proxy, param)
	print("OnEvent_14231_flag_set begin");
		
	proxy:SetEventFlag( 14231 , 1 );
	proxy:DeleteEvent( 14231 );
	proxy:SetDeadMode( 10000 , false );--���G����

	print("OnEvent_14231_flag_set end");
end



--------------------------------------------------------------------------------------
--�{�X�������o��(�퓬�J�n)��14234��14232
--------------------------------------------------------------------------------------

function OnEvent_14234(proxy, param)
	print("OnEvent_14234 begin");
	
	--��14232���{�X��pBGM�Đ��J�n
	proxy:PlayPointSE( 2292, SOUND_TYPE_M, 80100000, 1 );
	
	--�{�X���W�b�NON
	proxy:EnableLogic( 300 , true );
	
	--�t���OON
	--proxy:SetEventFlag( 14232 , true );--BGM
	proxy:SetEventFlag( 14234 , true );
	
	--�{�X�Q�[�W�\��
	proxy:SetBossGauge(300, 0, 1030);
	
	print("OnEvent_14234 end");
end


--------------------------------------------------------------------------------------
--��14301���\�E�����聡
--------------------------------------------------------------------------------------
function OnEvent_14301(proxy, param)
	print("OnEvent_14301 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--�V�����A�j�� 
		print("OnEvent_14301 end");
		return true;
	end
	
	--�A�C�e���擾�֐�
	proxy:GetRateItem(10800);--�p�����[�^10800�Q��
	proxy:GetRateItem(10870);--�p�����[�^10870�Q��
	proxy:GetRateItem(10871);--�p�����[�^10871�Q��
	proxy:GetRateItem(10872);--�p�����[�^10872�Q��
	proxy:GetRateItem(10873);--�p�����[�^10873�Q��
	Lua_PauseTutorial(proxy);
	--�A�C�e�����擾�ς�
	proxy:SetEventFlag( 14301, 1 );

	--SFX��������
	proxy:InvalidSfx( 1290 , true );
	
	proxy:OnKeyTime2( 14242,"OnEvent_14242_wait",1.0,0,0,once);
	
	print("OnEvent_14301 end");
end

function OnEvent_14242_wait(proxy,param)
	print("OnEvent_14242_wait begin");
	proxy:OnRegistFunc( 14242 , "Check_14242_regist","OnEvent_14242_regist",0,once);
	print("OnEvent_14242_wait end")
end

function Check_14242_regist(proxy)
	if proxy:IsShowMenu() == true then
		return false;
	end
	return true;	
end

function OnEvent_14242_regist(proxy,param)
	print("OnEvent_14242_regist begin");
	proxy:RepeatMessage_begin();		
		proxy:OnDistanceAction( 14242 , 10000 , 1311 , "OnEvent_14242" , WarpGimmickDist_A , 10010180 , 0 , 180, everytime );
	proxy:RepeatMessage_end();
	print("OnEvent_14242_regist begin");
end

function OnEvent_14242(proxy,param)
	
	if proxy:IsCompleteEvent( 14242 ) == true then
		return;
	end	
	if param:IsNetMessage() == true then
		return;
	end	
	
	print("OnEvent_14242 begin");
	
	--�Z�b�V�������Ȃ�΁A�v�΂̃��[�v����
	if proxy:IsSession() == false then--�Z�b�V�������ł͂Ȃ�
		proxy:RepeatMessage_begin();
		--��70_1���I�����j���[�̊Ď���
			proxy:OnSelectMenu(14242, "OnEvent_14242_1", 84000000, 0, 2, 1311, 2, once);			
		proxy:RepeatMessage_end();
	else--�Z�b�V������
		--�G���[�\���u�Z�b�V�������͞��̐_�a�ɂ͖߂�܂���v
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010720, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1311, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	print("OnEvent_14242 end");
end

function OnEvent_14242_1(proxy,param)
	print("OnEvent_14242_1 beign");

	proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ�	
	proxy:NoAnimeTurnCharactor( 10000 , 1311 ,TURNSKIP_ANGLE);
	proxy:NotNetMessage_begin();
		--���v�΂ɐG���A�j���Đ��I����
		proxy:OnChrAnimEnd( 14241 , 10000 , 8283 , "OnEvent_14241" , once );
	proxy:NotNetMessage_end();	
	proxy:SetEventFlag( 14242, true );
	print("OnEvent_14242_1 end");
	
end

--------------------------------------------------------------------------------------
--���{�X���S������14233
--------------------------------------------------------------------------------------
--��14233�����{�X���S������
function OnEvent_14233(proxy, param)
	print("OnEvent_14233 begin");

	proxy:NotNetMessage_begin();
		--��14233_1�����{�X���S������
		proxy:OnKeyTime2(14233,"OnEvent_14233_1", 1,0,0,once);	
	proxy:NotNetMessage_end();
	
	proxy:CustomLuaCallStart( 4050 , 300 );
	--BlockClear2(proxy,param);
	proxy:SetEventFlag( 14233, 1 );--�{�X���S
	
	print("OnEvent_14233 end");
end

--��14233_1�����{�X���S������
function OnEvent_14233_1(proxy, param)
	print("OnEvent_14233_1 begin");
	
--�A�C�e������֘A--------------------------------------------------
	--�󎀑�(�\�E��?)�L����
	proxy:SetDrawEnable( 1310 , true );
	proxy:SetColiEnable( 1310 , true );
	
	proxy:SetDrawEnable( 1311 , true );
	proxy:SetColiEnable( 1311 , true );
	
	--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ���
	if proxy:IsCompleteEvent( 14301 ) == false then
		proxy:ValidSfx( 1290 );--���̗��q
		proxy:ValidSfx( 1291 );--SFX �L����
		--proxy:TreasureDispModeChange2( 1310 , true ,KANAME_SFX);--���点��		
		proxy:TreasureDispModeChange2( 1311 , true ,KANAME_SFX);--���点��
		proxy:OnDistanceActionAttribute( 14301 , 10000 , 1310 , "OnEvent_14301" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_NOSESSION, once );
	end
--------------------------------------------------------------------
 
 --�{�X���S�Ŏ��̃G���A�֓����J��
	--proxy:PlayAnimation( 1311 , 1 );
	
	--�{�X��p��BGM��~
	proxy:StopPointSE( 1 );

	--���{�X�����̖��@�ǂ�������
	proxy:SetColiEnable( 1272 , false );
	proxy:SetDrawEnable( 1272 , false );

	--���{�X�����O�̃C�x���g���폜
	proxy:DeleteEvent( 14231 );--���ɓ���p
	proxy:DeleteEvent( 14232 );--���ɓ���p
	proxy:DeleteEvent( 14234 );--�퓬�J�n�p

	proxy:InvalidSfx( 2274, true );
	
	--���C���t�H���[�V�������b�Z�[�W�\����
	proxy:SetEventFlag( 14233 , 0 );
	--proxy:OnChrAnimEnd( 14233 , 1311 , 1 , "OnEvent_14233_2" , once );
	--proxy:OnKeyTime2( 14233 , "OnEvent_14233_2", 0.0 , 0 , 10 , once );
	proxy:SetEventFlag( 14233 , 1 );
	
	print("OnEvent_14233_1 end");
end

--[[
--��14233_2���C���t�H���[�V�������b�Z�[�W�\����
function OnEvent_14233_2(proxy, param)
	print("OnEvent_14233_2 begin");
	
	--�C���t�H���[�V�������b�Z�[�W�̕\��
	--Display_InfomationMenu_2(proxy, 0, -1, 30, 81001100, 1, -1, 30, 81001101, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14233 , 1 );	
	
	print("OnEvent_14233_2 end");
end
]]

--------------------------------------------------------------------------------------
--�Ԃł̎��S������
--------------------------------------------------------------------------------------
function m08_01Death(proxy,param)
	print("m08_01Death begin");
--[[	
	--proxy:SetMapUid( 8, 1, 0, 0, -1 );			
	proxy:SetHp( 10000, 1 );
	--���҈ʒu�ɍďo��		
	proxy:SetEventFlag(14300,true);]]	
	proxy:SetEventFlag(4000,true);	
	proxy:OnKeyTime2(143000,"OnEvent_14300",1.5,0,10,once);
	print("m08_01Death end");
end

--[[
--�����ʒu�ւ̃��[�v
function m08_01Death_Load(proxy,param)
	print("m08_01Death_Load begin");
	--���[�v���s��
	--proxy:WarpNextStageKick();
	proxy:WarpRestart(10000,-1);
	proxy:OnKeyTime2(4000,"OnEvent_14300",1.0,0,0,once);
	print("m08_01Death_Load end");
end
]]

--------------------------------------------------------------------------------------
--�Ԃł̎��S��̃V�X�e�����j���[��14300
--------------------------------------------------------------------------------------
function OnEvent_14300(proxy,param)
	print("OnEvent_14300 begin");
	--Display_InfomationMenu_2(proxy, 0, -1, 30, 89999999, 1, -1, 30, 88999900, 6);
	--Lua_PauseTutorial(proxy);
	--proxy:SetEventFlag(14300,false);
	
	proxy:OnKeyTime2( 14300 , "OnEvent_14300_1",1.5,0,0,once);
	print("OnEvent_14300 end");
end

function OnEvent_14300_1(proxy,param)
	print("OnEvent_14300_1 begin");
	proxy:OnRegistFunc( 14300 , "Check_14300","OnEvent_14300_2",1,once);
	print("OnEvent_14300_1 end");
end

function Check_14300(proxy)
	if proxy:IsShowMenu() == true then
		return false;
	end
	return true;
end

function OnEvent_14300_2(proxy,param)
	print("OnEvent_14300_2 begin");
	proxy:OnKeyTime2( 14300 , "OnEvent_14300_3",1.0,0,0,once);
	print("OnEvent_14300_2 end");
end


--�Β��ւ̃��[�v
function OnEvent_14300_3(proxy,param)
	print("OnEvent_14300_3 begin");
	proxy:SetEventFlag( 4000 , 0 );--�v���C���[���S�t���OOFF	
	proxy:RevivePlayer();	
	proxy:Tutorial_end();
	
	--�`���[�g���A���}�b�v3�ł̓}�b�v�J�n������K���O���C�S�[�X�g�ɂȂ�K�v������B
	--���̃^�C�~���O�ŃO���C�S�[�X�g�ɕς���Ă����΁A�K�v�ȏ������O���[�o���̏�����
	--�s���Ă����B(=���K�̃O���C�S�[�X�g�ɂȂ��)
	proxy:ChangeGreyGhost();
	
	--���S�񕜗v��
	proxy:RequestFullRecover();
	--�Β��̓�����Ƀ��[�v
	proxy:WarpNextStage( 1,0,0,0,-1);
	print("OnEvent_14300_3 end");
end


--------------------------------------------------------------------------------------
--�{�X�퓬�J�����؂�ւ��C�x���g��14230
--------------------------------------------------------------------------------------
function OnEvent_14230(proxy,param)
	--print("OnEvent_14230 begin");
	--�{�X�������Ă���@���@�{�X�Ƃ̐퓬���J�n����Ă���
	if proxy:IsCompleteEvent( 14233 ) == false and proxy:IsCompleteEvent( 14234 ) == true then
		--�{�X��@�񃍃b�N�J����
		proxy:SetCamModeParamTargetId(8011);
		--�{�X��@���b�N�J����
		proxy:SetCamModeParamTargetIdForBossLock(8010);
	end	
	--print("OnEvent_14230 end");
end


--------------------------------------------------------------------------------------
--�C���t�H�\���F���̕ǁ�14306
--------------------------------------------------------------------------------------
--��14306���C���t�H�\���F���̕ǁ�
function OnEvent_14306(proxy , param)
	print("OnEvent_14306 begin");
	
	--�C���t�H���[�V�������b�Z�[�W�̕\��
	Display_InfomationMenu_2(proxy, 0, -1, 30, 81001050, 1, -1, 30, 81001051, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14306 , 1 );	
	
	print("OnEvent_14306 end");
end



--------------------------------------------------------------------------------------
--�C���t�H�\���F���̕ǁ�14291
--------------------------------------------------------------------------------------
--��14291���C�x���g�����p��
function OnEvent_14291(proxy , param)
	print("OnEvent_14291 begin");

	--���d�����h�~
	if proxy:IsCompleteEvent( 14291 ) == true then
		print("OnEvent_14291 end");
		return;
	end
	
	proxy:InvalidSfx( 2275 , true );--SFX OFF
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 14291 , 1 );
		print("OnEvent_14291 end");
		return;
	end
	
	--�_�~�|���փ��[�v
	proxy:WarpDmy( 10000 , 1271 , 191 );
	
	proxy:NotNetMessage_begin();
		--��240_1�������A�j���I����
		--proxy:OnChrAnimEnd( 14291 , 10000 , ANIMEID_WALK , "OnEvent_14291_1" , once );
		OnEvent_14291_1(proxy , param);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 14291 , 1 );
	
	print("OnEvent_14291 end");
end


--��14291_1�������A�j���I����
function OnEvent_14291_1(proxy , param)
	print("OnEvent_14291_1 begin");
	
	proxy:SetDrawEnable( 1271 , false );--���@�Ǖ`��OFF
	proxy:SetColiEnable( 1271 , false );--���@�Ǔ�����OFF
	proxy:SetObjDeactivate( 1271 , true );--�f�A�N�e�B�u
	proxy:DeleteEvent( 14291 );--�S�v���C���[���̊Ď�������͂��B
	
	print("OnEvent_14291_1 end");
end


--------------------------------------------------------------------------------------
--�p�j�S�[�X�g�ڌ��C�x���g��14410
--------------------------------------------------------------------------------------
function OnEvent_14410(proxy,param)
    proxy:RepeatMessage_begin();    
    proxy:ForceChangeTarget( 401 ,403 ); 
    proxy:ForceChangeTarget( 402 ,404 ); 
    proxy:ForceChangeTarget( 403 ,401 ); 
    proxy:ForceChangeTarget( 404 ,402 ); 
    proxy:SetColiEnable( 401 ,false );
    proxy:SetColiEnable( 402 ,false );
	proxy:SetColiEnable( 403 ,false );
	proxy:SetColiEnable( 404 ,false );
    --401�̖ڌ��C�x���g
    proxy:OnKeyTime2( 14411 , "OnEvent_14411_401",0.7 , 0 , 0,once);
    --402�̖ڌ��C�x���g
    proxy:OnKeyTime2( 14411 , "OnEvent_14411_402",4.6 , 0 , 1,once);
    proxy:RepeatMessage_end();
end


function OnEvent_14411_401(proxy,param)
	proxy:SetDrawEnable( 401 , true );
	proxy:OnWanderFade( 14411 , 401 ,2.0,2.0,10.0,12.5,once);
	--proxy:ChrFadeIn( 401 , 2.0 , 0.0 );
	proxy:RepeatMessage_begin();
		proxy:OnKeyTime2( 14411 , "OnEvent_14411_401_end",10.0,0,2,once);
	proxy:RepeatMessage_end();
end

--[[
function OnEvent_14411_401_fadeout(proxy,param)
	proxy:ChrFadeOut( 401 , 2.0 , 1.0 );
	proxy:RepeatMessage_begin();
		proxy:OnKeyTime2( 14411 , "OnEvent_14411_401_end", 2.0, 0, 3, once);
	proxy:RepeatMessage_end();
end
]]

function OnEvent_14411_401_end(proxy,param)
	if proxy:IsCompleteEvent( 14233 ) == false then
		proxy:RepeatMessage_begin();
			proxy:OnKeyTime2( 14411 , "OnEvent_14411_401", 12.5 , 0, 4, once);
		proxy:RepeatMessage_end();
	else
		print("�p�j�C�x���gEnd�@401");
	end
end

function OnEvent_14411_402(proxy,param)	
	proxy:SetDrawEnable( 402 , true );
	--proxy:ChrFadeIn( 402 , 2.0 , 0.0 );
	proxy:OnWanderFade( 14411 , 402 ,2.0,2.0,10.0,10.0,once);
	proxy:RepeatMessage_begin();
		proxy:OnKeyTime2( 14411 , "OnEvent_14411_402_end",10,0,5,once);
	proxy:RepeatMessage_end();
end

--[[
function OnEvent_14411_402_fadeout(proxy,param)
	proxy:ChrFadeOut( 402 , 2.0 , 1.0 );
	proxy:RepeatMessage_begin();
		proxy:OnKeyTime2( 14411 , "OnEvent_14411_402_end", 2.0, 0, 6, once);
	proxy:RepeatMessage_end();
end
]]

function OnEvent_14411_402_end(proxy,param)
	if proxy:IsCompleteEvent( 14233 ) == false then
		proxy:RepeatMessage_begin();
			proxy:OnKeyTime2( 14411 , "OnEvent_14411_402", 10.0 , 0, 7, once);
		proxy:RepeatMessage_end();
	else
		print("�p�j�C�x���gEnd�@402");
	end
end
