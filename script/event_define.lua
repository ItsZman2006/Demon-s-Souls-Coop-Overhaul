--���߂��

-------------------------------------------------------------------------------------------------------------------
--�����܂育��
--[[�E�����̒P�ʂ̓��[�g��]]
--�E���Ԃ̒P�ʂ͕b
--�E�p�x�͒��S�Ƃ��鎲���獶�E���ꂼ��̐��l�B
--�@����60�Ɛݒ肷��ƁA�O��120�����L���Ȋp�x�ƂȂ�B
-------------------------------------------------------------------------------------------------------------------

--���ʏ��b
TalkAngle_N	= 180.0;
TalkDist_N	= 3.0;

--����(�󎀑�)
ItemBoxAngle_A = 180.0;
ItemBoxDist_A  = 1.5;

--���͂���
LadderAngle_A = 90.0;
LadderTime_A  = 0.2;

--�����o�[
LeverAngle_A = 30;
LeverDist_A  = 1.5;

--�����[�v�M�~�b�N
WarpGimmickAngle_A = 90.0;  --�Β�     �� �e�}�b�v �̃^�C�v(���ʂ��炾��)
WarpGimmickDist_A  = 1.5;
WarpGimmickAngle_B = 180.0; --�e�}�b�v �� �Β�     �̃^�C�v(���͂ǂ��ł�)

--����
DoorAngle_A = 90;  --�Б����p(�X�N���v�g���ʃp�����[�^���)
DoorDist_A  = 1.0;

--[[�����ʃp�����[�^�Ɋ��q�Ȃ��̂���]]

--���n���h��
HandleAngle_A = 60.0;
HandleDist_A  = 1.5;

HandleAngle_B = 40.0; --�n���h��B���񂵂Ď��Ԃ𓮂���(���ʂ��ς��C�x���g�p)
HandleDist_B  = 1.8;  --�n���h��B���񂵂Ď��Ԃ𓮂���(���ʂ��ς��C�x���g�p)

--�����ˋ�
DrawBridgeAngle_A = 30.0;
DrawBridgeDist_A  = 1.5;

--�����ג���t��
WallAngle_A = 90.0;
WallTime_A = 0.5;

--�����X�C�b�`
FloorSwitchDist_A = 1.5;

--���i���N�W
NamekujiAngle_A = 180.0;
NamekujiDist_A = 5.0;

--���{�X���S���玟�u���b�N�|�����Đ��܂ł̑҂�����
BlockClear_RemoWait = 3.0;

--���g�f�[����(�q���f�[����)�̃R�A�p�[�c��Hp
LeechDemon_Core_Hp	= 1800;

--��墂�����f�[����(�͂�������f�[����)�萔
FlyCrowdDemon_Core_Hp			= 2700;		--�R�A�p�[�c��Hp
FlyCrowdDemon_SpellReload_Low	= 15.0;		--墖��@�̔��ˊԊu(�ŒZ)
FlyCrowdDemon_SpellReload_High	= 20.0;		--墖��@�̔��ˊԊu(�Œ�)

--���s��R�̎��̗����Ԋu�̒����萔
M52_Corpse_FallWait_Low		= 10.0;		--�����Ԋu�̒����萔(�ŒZ)
M52_Corpse_FallWait_High	= 20.0;		--�����Ԋu�̒����萔(�Œ�)

--�����S�y�i���e�B�̒����萔
DeathPenalty_SoulAdjust			= 0;--1.0;	--���S���̃\�E�������v�Z�����l
DeathPenalty_SoulMAX			= 0;--500;	--���S���̌����\�E���ő�l

--��PK�y�i���e�B�̒����萔
PK_Soul_Penalty_Adjust		= 1.0;	--���S���̃\�E�������v�Z�����l
PK_Soul_Penalty_MAX			= -1;	--���S���̌����\�E���ő�l(-1�ŏ���Ȃ�)
PK_Soul_Penalty_BASE		= 25;	--��{�l(�p�����[�^�̍����Ŕ{�ɂȂ�l)
PK_Soul_Penalty_FIX			= 100;	--�Œ茸���l(�p�����[�^���������l�Ɋ֌W�Ȃ��A��΂Ɍ��炷��)

--��NPC���{��_���[�W����
NPC_ANGRY_Rate	= 0.2;

--���ėp�_�C�A���O��������������
GEN_DIALOG_DIST	= 2.0;

-------------------------------------------------------------------------------------------------------------------
--�y�V�X�e���萔�z
-------------------------------------------------------------------------------------------------------------------
once 			= 1;
everytime 		= 0;
LOCAL_PLAYER	= 10000;
SYNCHROANIM		= 4013;
TURNTIME		= 0.05;
TURNSKIP_ANGLE	= 10;

-------------------------------------------------------------------------------------------------------------------
--�yItemType�萔�z
-------------------------------------------------------------------------------------------------------------------
TYPE_WEAPON		= 0;
TYPE_PROTECTER	= 268435456;
TYPE_ACCESSORY	= 536870912;
TYPE_GOODS		= 1073741824;
TYPE_MASK		= 4026531840;


-------------------------------------------------------------------------------------------------------------------
--�y�C�x���g�w���vID�萔�z
-------------------------------------------------------------------------------------------------------------------

--�����ׂ�n(100��)

HELPID_CHECK 				= 10010100;--�ėp(?)
HELPID_CHECK_GLOWING_CORPS	= 10010101;--��������̂𒲂ׂ�(���A)
HELPID_CHECK_CORPS			= 10010102;--���̂𒲂ׂ�(�ʏ�)
HELPID_PICK_ITEM            = 10010103;--�A�C�e�����E��(�{�X�A�C�e���p?)

--���b���n(200��)

HELPID_TALK 				= 10010200;--�ėp(?)
HELPID_TALK_WAR				= 10010201;--��m�Ƙb��
HELPID_TALK_HUN				= 10010202;--��l�Ƙb��
HELPID_TALK_CLE				= 10010203;--�m���Ƙb��
HELPID_TALK_MAG				= 10010204;--���p�t�Ƙb��
HELPID_TALK_SWO				= 10010205;--���b��Ƙb��

--�����~�n(300��)�@Map�A�N�V�����n

HELPID_UP					= 10010300;--�o��
HELPID_DOWN					= 10010301;--�~���

HELPID_WALL					= 10010303;--�H�ǒ���t���悤�̃w���v


--�����n(400��)

HELPID_OPEN					= 10010400;--�J��
HELPID_CLOSE				= 10010401;--�߂�
HELPID_REMOVE				= 10010402;--�O��

--���M�~�b�N�쓮�n(500��)

HELPID_START				= 10010500;--�쓮������
HELPID_PULL_LEVER			= 10010501;--���o�[������
HELPID_PUSH_LEVER			= 10010502;--���o�[������
HELPID_TURN_HANDLE			= 10010503;--�n���h������

--�����[�v�p(600��)(�V)
HELPID_CHECK_OUJOU			= 10010650;--����v�Β��ׂ�	
HELPID_CHECK_HURUTORIDE		= 10010651;--�Íԗv�Β��ׂ�
HELPID_CHECK_ROUJOU			= 10010652;--�S��v�Β��ׂ�
HELPID_CHECK_HUJOU			= 10010653;--�s��v�Β��ׂ�
HELPID_CHECK_KOUDOU			= 10010654;--�B���v�Β��ׂ�
HELPID_CHECK_HOKUGEN		= 10010655;--�k���v�Β��ׂ�

--�����[�v�p(600��)(��)
--[[
HELPID_GO_TO_OUJOU			= 10010600;--����1�֍s��
HELPID_GO_TO_OUJOU_2		= 10010608;--����2�֍s��
HELPID_GO_TO_OUJOU_3		= 10010614;--����3�֍s��
HELPID_GO_TO_OUJOU_4		= 10010620;--����4�֍s��

HELPID_GO_TO_HURUTORIDE		= 10010601;--�Í�1�֍s��
HELPID_GO_TO_HURUTORIDE_2	= 10010609;--�Í�2�֍s��
HELPID_GO_TO_HURUTORIDE_3	= 10010615;--�Í�3�֍s��

HELPID_GO_TO_ROUJOU			= 10010602;--�S��1�֍s��
HELPID_GO_TO_ROUJOU_2		= 10010610;--�S��2�֍s��
HELPID_GO_TO_ROUJOU_3		= 10010616;--�S��3�֍s��

HELPID_GO_TO_HUJOU			= 10010603;--�s��1�֍s��
HELPID_GO_TO_HUJOU_2		= 10010611;--�s��2�֍s��
HELPID_GO_TO_HUJOU_3		= 10010617;--�s��3�֍s��

HELPID_GO_TO_KOUDOU			= 10010604;--�B��1�֍s��
HELPID_GO_TO_KOUDOU_2		= 10010612;--�B��2�֍s��
HELPID_GO_TO_KOUDOU_3		= 10010618;--�B��3�֍s��

HELPID_GO_TO_HOKUGEN		= 10010605;--�k��1�֍s��
HELPID_GO_TO_HOKUGEN_2		= 10010613;--�k��2�֍s��
HELPID_GO_TO_HOKUGEN_3		= 10010619;--�k��3�֍s��
]]
HELPID_GO_TO_SEKITYUU       = 10010606;--�Β��֍s��
HELPID_GO_TO_IN				= 10010403;--���ɓ���
HELPID_GO_TO_OUT			= 10010404;--�O�ɏo��

--���\�E���T�C��

HELPID_TOUCH_SOUL_SIGN			= 50000000;--�\�E���T�C���ɐG���
HELPID_SOUL_SIGN_ACTIVATED		= 50000001;--�\�E���T�C��������
HELPID_TOUCH_BLOOD_MESSAGE		= 50000100;--�������ɐG���
HELPID_BLOOD_MESSAGE_ACTIVATED	= 50000101;--������������

HELPID_OPENCAMPMENU 			= 10010150;--�L�����v���j���[�\��
-------------------------------------------------------------------------------------------------------------------
--�y�v���C���[�A�j���[�V����ID�萔�z(�悭�g���̂���)
-------------------------------------------------------------------------------------------------------------------

--���A�j���[�V����ID��
ANIMEID_WALK		= 7410;	--����(���̖��ʉߗp)

ANIMEID_PICK 		= 7520;	--�E��
ANIMEID_KICK		= 7400;	--�R��

ANIMEID_OPEN		= 7401;	--�J����
ANIMEID_CLOSE		= 7402;	--�߂�

ANIMEID_PULL_LEVER	= 8000;	--���o�[������
ANIMEID_PUSH_LEVER	= 8000;	--���o�[�������@	--���o�[���������p
ANIMEID_TURN_HANDLE	= 8010;	--�n���h������

ANIMEID_BARISTA_GRASP      = 8100;--�o���X�^�͂�
ANIMEID_BARISTA_GRASP_KEEP = 8110;--�o���X�^�͂ݑҋ@
ANIMEID_BARISTA_AWAY       = 8120;--�o���X�^����


--���A�j���[�V�����I���܂łɂ����鎞�ԁ�(�Đ��t���[��/FPS)
_GAME_FPS = 30;

ANIMEID_PICK_TIME	= (75.0 / _GAME_FPS); --�����ő�p
ANIMEID_KICK_TIME	= (50.0 / _GAME_FPS);

ANIMEID_OPEN_TIME	= (80.0 / _GAME_FPS);
ANIMEID_CLOSE_TIME	= (60.0 / _GAME_FPS);

ANIMEID_PULL_LEVER_TIME  = (80.0 / _GAME_FPS);
ANIMEID_PUSH_LEVER_TIME  = (80.0 / _GAME_FPS); --���o�[�������ő�p
ANIMEID_TURN_HANDLE_TIME = (60.0 / _GAME_FPS);

-------------------------------------------------------------------------------------------------------------------
--�y�T�E���h�o���NID�z
-------------------------------------------------------------------------------------------------------------------
SOUND_TYPE_A		=  0; --a:����
SOUND_TYPE_C		=  1; --c:�L�������[�V����
SOUND_TYPE_F		=  2; --f:���j���[SE
SOUND_TYPE_O		=  3; --o:�I�u�W�F�N�g
SOUND_TYPE_P		=  4; --p:�|������pSE
SOUND_TYPE_S		=  5; --s:SFX
SOUND_TYPE_M		=  6; --m:BGM
SOUND_TYPE_V		=  7; --v:����
SOUND_TYPE_X		=  8; --x:���ގ��ˑ�
SOUND_TYPE_B		=  9; --b:�Z�ގ��ˑ�
SOUND_TYPE_G		= 10; --g:�S�[�X�g

-------------------------------------------------------------------------------------------------------------------
--�y�v���C���[�̏�Ԓ萔�z
-------------------------------------------------------------------------------------------------------------------

CHR_TYPE_LivePlayer	= 0; --�����v���C���[
CHR_TYPE_GreyGhost  = 8; --�O���C�S�[�X�g(�ʏ�S�[�X�g)
CHR_TYPE_WhiteGhost = 1; --�z���C�g�S�[�X�g(�F�D�S�[�X�g)
CHR_TYPE_BlackGhost = 2; --�u���b�N�S�[�X�g(�G�΃S�[�X�g)


-------------------------------------------------------------------------------------------------------------------
--�y�`�[���^�C�v�萔�z
-------------------------------------------------------------------------------------------------------------------
TEAM_TYPE_None 			= 0;--����
TEAM_TYPE_Live			= 1;--�����v���C���[
TEAM_TYPE_WhiteGhost	= 2;--�z���C�g�S�[�X�g
TEAM_TYPE_BlackGhost	= 3;--�u���b�N�S�[�X�g
TEAM_TYPE_GlayGhost		= 4;--�O���C�S�[�X�g
TEAM_TYPE_WanderGhost	= 5;--�p�j�S�[�X�g
TEAM_TYPE_Enemy			= 6;--�G
TEAM_TYPE_Boss			= 7;--���G
TEAM_TYPE_Friend		= 8;--����
TEAM_TYPE_AngryFriend	= 9;--�����i�{�j
TEAM_TYPE_DecoyEnemy	= 10;--���Ƃ�G�i���s�l�j
TEAM_TYPE_BloodChild	= 11;--�Ԏq
TEAM_TYPE_BattleFriend	= 12;--�키����

-------------------------------------------------------------------------------------------------------------------
--�y���b�Z�[�W�J�e�S��ID�z--�G�N�Z���t�@�C���̎��ʂɎg����
-------------------------------------------------------------------------------------------------------------------
MSG_CATEGORY_SAMPLE		=  0;--�T���v��
MSG_CATEGORY_TALK		=  1;--��b
MSG_CATEGORY_BLOOD		=  2;--������
MSG_CATEGORY_ITEM		= 10;--�A�C�e��
MSG_CATEGORY_WEP		= 11;--����
MSG_CATEGORY_PRO		= 12;--�h��
MSG_CATEGORY_ACC		= 13;--�A�N�Z�T���[
MSG_CATEGORY_ITEM_EXP	= 20;--�A�C�e������
MSG_CATEGORY_WEP_EXP	= 21;--�������
MSG_CATEGORY_PRO_EXP	= 22;--�h�����
MSG_CATEGORY_ACC_EXP	= 23;--�A�N�Z�T���[����
MSG_CATEGORY_EVENT		= 30;--�C�x���g�e�L�X�g
MSG_CATEGORY_DIALOG		= 78;--�_�C�A���O


-------------------------------------------------------------------------------------------------------------------
--�y�V�X�e���Ŏg�p����A�N�V����ID�z--
-------------------------------------------------------------------------------------------------------------------
SYSTEM_ID_IGNORE		= 4048;
IGNORE_TIME				= 3.0;
SYSTEM_WARP				= 4052;--���[�v�A�j���̌q���pID
SYSTEM_CHECK_POINT		= 4054;--�`�F�b�N�|�C���g�ʉ�
SYSTEM_GENDIALOG		= 4061;--�ėp�_�C�A���O��������p

-------------------------------------------------------------------------------------------------------------------
--�y�C���t�H���[�V�������j���[�̕\���^�C�v�z
-------------------------------------------------------------------------------------------------------------------
INFOMENU_TYPE_LIST		= 0;--�s��ǉ��ł���ʏ�^�C�v�B
INFOMENU_TYPE_SIMPLE	= 1;--�^�C�g���ƃV�X�e�����݂̂̊ȈՃ^�C�v


-------------------------------------------------------------------------------------------------------------------
--�yOnObjectDamageHit �q�b�g�Ώێ��ʗp�萔�z
-------------------------------------------------------------------------------------------------------------------
EV_HIT_CHR = 1;--�L�������Ώ�
EV_HIT_HIT = 2;--�}�b�v���Ώ�
EV_HIT_ALL = 3;--�L�����ƃ}�b�v���Ώ�

-------------------------------------------------------------------------------------------------------------------
--�y�E�Ɨp�萔�z
-------------------------------------------------------------------------------------------------------------------

JOB_LOW_SOLDIER		= 0;--�������m	���܂�^��m�`���[�g���A��
JOB_LOW_KNIGHT		= 1;--�����R�m	���܂�^��m�`���[�g���A��
JOB_HUNTER			= 2;--��l		���܂�^��l�`���[�g���A��
JOB_CLERIC			= 3;--�_�E		���܂�^�m���`���[�g���A��
JOB_SHAMAN			= 4;--��t		���܂�^���p�t�`���[�g���A��
JOB_NEET			= 5;--���Q��	���܂�^��m�`���[�g���A��
JOB_MERCENARY		= 6;--�ؑ�		���܂�^��m�`���[�g���A��
JOB_THIEF			= 7;--����		���܂�^��l�`���[�g���A��
JOB_TEMPLE_KNIGHT	= 8;--�_�a�R�m	���܂�^�m���`���[�g���A��
JOB_NOBLEMAN		= 9;--�M��		���܂�^���p�t�`���[�g���A��





-------------------------------------------------------------------------------------------------------------------
--�yOnObjectDamageHit �����_���[�W�w��p�z
-------------------------------------------------------------------------------------------------------------------
DAMAGE_TYPE_NONE = -1;--������
DAMAGE_TYPE_FIRE = 10;--������

-------------------------------------------------------------------------------------------------------------------
--�y���������z --�������v���C���̏�Ԃɂ���Đ����ł���
-------------------------------------------------------------------------------------------------------------------
ATTR_SESSION 	=   1;
ATTR_NOSESSION	=   2;
ATTR_HOST		=   4;
ATTR_CLIENT		=   8;
ATTR_LIVE		=  16;
ATTR_GREY		=  32;
ATTR_WHITE		=  64;
ATTR_BLACK		= 128;
ATTR_ALL		= 255;

-------------------------------------------------------------------------------------------------------------------
--�y�C�x���g��b�̐ݒ�t���O�z --��b�̐ݒ�t���O�֘A
-------------------------------------------------------------------------------------------------------------------
TALK_ATTR_REPEAT 	=   1;
TALK_ATTR_PAD		=   2;
TALK_ATTR_DRAW		=   4;
TALK_ATTR_VOICE		=   8;
TALK_ATTR_ALL		= 255;

-------------------------------------------------------------------------------------------------------------------
--�y�^�O�C���f�b�N�X�z --���b�Z�[�W�Ƀv���C��������ꍞ�ލۂɁA�^�O�̑������w�肷��K�v������
-------------------------------------------------------------------------------------------------------------------
TAG_IDX_liveChara 		= 0;
TAG_IDX_joinChara 		= 1;
TAG_IDX_deadChara 		= 2;
TAG_IDX_leaveChara 		= 3;

-------------------------------------------------------------------------------------------------------------------
--�y�|�����R�[���o�b�N�n���h���萔�z
--RequestRemo(scnId,nflag,cbArgA,cbArgB) 
--cbArgA�Ɏw�肵�����l���n���h���̃C�x���gID�ŗ��p�����B
--cbArgB��1�ȏ���w�肵���ꍇ�K���n���h�����R�[������܂��B
--�R�[�������n���h���̃p�����ݒ�͈ȉ����Q��
-------------------------------------------------------------------------------------------------------------------
REMO_START		=10;		--�|�����J�n(�t�F�[�h�I����
REMO_FINISH		=100;			--�|�����I��

-------------------------------------------------------------------------------------------------------------------
--�y�|�����t���O�萔�z
--�}���`���ɃX�L�b�v�s�A�V���O�����ɂ͒ʏ�ɂȂ�܂�
-------------------------------------------------------------------------------------------------------------------
REMO_FLAG		=0;

-------------------------------------------------------------------------------------------------------------------
--�y���[�r�[�w��萔�z
-------------------------------------------------------------------------------------------------------------------
MOVIE_ADVERTISE 	= 0;	--�A�h�o�^�C�Y���[�r�[
MOVIE_TITLE			= 1;	--�^�C�g�����[�r�[
MOVIE_OPENING		= 2;	--�I�[�v�j���O���[�r�[
MOVIE_STAFFROLL		= 3;	--�X�^�b�t���[�����[�r�[
MOVIE_ENDING_BAD	= 4;	--�o�b�h�G���f�B���O���[�r�[
MOVIE_ENDING_GOOD	= 5;	--�O�b�h�G���f�B���O���[�r�[
MOVIE_OLDTALE		= 6;	--�̘b���[�r�[


-------------------------------------------------------------------------------------------------------------------
--�y�N���A�萔�z
-------------------------------------------------------------------------------------------------------------------
CLEAR_STATE_BADEND = 2;		--BadEnding
CLEAR_STATE_GOODEND = 1;	--GoodEnding

-------------------------------------------------------------------------------------------------------------------
--�y10�������ߗp�����萔�z
-------------------------------------------------------------------------------------------------------------------
NPCTIMER		=120;--�P��(�b)
TEXT_TIMER      =0;--�P��(�b)


-------------------------------------------------------------------------------------------------------------------
--�y�e�L�X�g���o�萔�z
-------------------------------------------------------------------------------------------------------------------
TEXT_TYPE_KillDemon		= 1;--�f�[�������j
TEXT_TYPE_Dead			= 2;--���S
TEXT_TYPE_Revival		= 3;--����
TEXT_TYPE_SoulGet		= 4;--�\�E���擾
TEXT_TYPE_TargetClear	= 5;--�ڕW���j
TEXT_TYPE_GhostDead		= 6;--�S�[�X�g���S
TEXT_TYPE_BlackClear	= 7;--�u���b�N�S�[�X�g���j

-------------------------------------------------------------------------------------------------------------------
--�y�t�@�����N�X�֘A�萔�z
-------------------------------------------------------------------------------------------------------------------
--EzState���ߒ萔
PHALANX_Core_ToGattai	= 100;		--���̏�Ԃֈڍs
PHALANX_Core_ToBousui	= 101;		--�a����Ԃֈڍs
PHALANX_Core_ToBunsan	= 102;		--���U��Ԃֈڍs
PHALANX_Core_ToHitWall	= 103;		--�ǂɓ�������
PHALANX_Core_ToClimb	= 104;		--�΂ߕǂɏ����
PHALANX_Core_ToTotugeki = 105;		--�ˌ�����
PHALANX_Core_ToHitObj	= 106;		--OBJ�����ɓ�������

PHALANX_Jr_Wait			= 150;		--Jr�ҋ@
PHALANX_Jr_MaruWait		= 151;		--Jr�܂邪���ҋ@
PHALANX_Jr_Nezumi 		= 152;		--Jr�n���l�Y�~�J�n
PHALANX_Jr_AllYarinage	= 153;		--Jr�S������
PHALANX_Jr_TankiYari	= 154;		--Jr�P�R���U��
PHALANX_Jr_TankiYarinage= 155;		--Jr�P�R������
PHALANX_Jr_NormalBunsan = 156;		--Jr�ʏ핪�U
PHALANX_Jr_KokeBunsan	= 157;		--Jr�]�|���U
PHALANX_Jr_KabeYari		= 158;		--Jr�ǂ��瑄�̉J
PHALANX_Jr_Totugeki		= 159;		--Jr�ˌ�
PHALANX_Jr_MaruEnd		= 160;		--Jr�܂邪���ҋ@�I��

--EzState�߂�l�萔
RES_PHALANX_Nezumi_Start		=100;		--�n���l�Y�~�U���J�n
RES_PHALANX_Nezumi_End			=101;		--�n���l�Y�~�U���I��
RES_PHALANX_AllYarinageStart	=102;		--�S���ˏo�U���J�n
RES_PHALANX_AllYarinageEnd		=103;		--�S���ˏo�U���I��
RES_PHALANX_TankiYariStart		=104;		--�P�R���U���J�n
RES_PHALANX_TankiYariEnd		=105;		--�P�R���U���I��
RES_PHALANX_TankiYarinageStart	=106;		--�P�R���ˏo�J�n
RES_PHALANX_TankiYarinageEnd	=107;		--�P�R���ˏo�I��
RES_PHALANX_KabeYariStart		=108;		--�ǂ��瑄�̉J�J�n
RES_PHALANX_KabeYariEnd			=109;		--�ǂ��瑄�̉J�I��
RES_PHALANX_GattaiComp			=110;		--���̈ڍs����
RES_PHALANX_BousuiComp			=111;		--�a���ڍs����
RES_PHALANX_BunsanComp			=112;		--���U�ڍs����
RES_PHALANX_TotugekiStart		=113;		--�ːi�J�n
RES_PHALANX_TotugekiEnd			=114;		--�ˌ��I��
RES_PHALANX_TotugekiStop		=115;		--�ːi��~�I��

--EzState�߂�l�萔
RES_PHALANX_JR_Wait				= 150;		--�ʏ�ҋ@�J�n
RES_PHALANX_JR_MaruWait			= 151;		--�܂邪���ҋ@�J�n



JR_STATE_Normal			=0;--�ʏ�
JR_STATE_ToCore			=1;--�R�A��ڎw�����ړ�
JR_STATE_HoverMove		=2;--�R�A���B���_�~�|���ւ̈ړ�
JR_STATE_DmyHover		=3;--�_�~�|���ւ̈ړ����z�o�[�z��
JR_STATE_DmyAttach		=4;--�_�~�|���ڒ�
--JR_STATE_DmyDettach--�_�~�|���؂藣��
JR_STATE_HavokFly		=5;--Havok������
JR_STATE_Single			=6;--��l�g�X�V
JR_STATE_Dead			=7;--Jr���S

JR_BaseDmyPolyMoveWait	= 8;--�_�~�|���Ԉړ��̊�{�l
PHALANX_MaxReturnCount	= 3;--�߂��Ԃ̍ő�l
 


--PT���U�܂ł̎���
CLEAR_TIMEOUT = 10.0;

-------------------------------------------------------------------------------------------------------------------
--�y�C�x���g�Ď������l�z--�����ɏ����Ă����ƁA�\�[�X���J���Ȃ��Ă������l�̈Ӗ����m�F���o����׋L�q�B���ۂɃX�N���v�g�Ŏg�����Ƃ͂���܂���B
-------------------------------------------------------------------------------------------------------------------
--EVENT_OBSERVE_DIST_PLAYER	=  0;		//!<	����	
--EVENT_REGION_ACTION		=  2;		//!<	�̈���œ���
--EVENT_REGION_IN			=  3;		//!<	�̈�ɓ����Ă���
--EVENT_REGION_JUSTIN		=  4;		//!<	�̈�ɓ������u��
--EVENT_REGION_JUSTOUT		=  5;		//!<	�̈���o���u��
--EVENT_DIST_ACTION			=  6;		//!<	�������Ŋp�x���ł̓���
--EVENT_DIST_IN				=  7;		//!<	�͈͓�
--EVENT_DIST_OUT			=  8;		//!<	�͈͂���O���
--EVENT_DIST_ANGLE			=  9;		//!<	�������Ŋp�x��
--EVENT_KEYFRAME_ONCE		= 10;		//!<	�L�[�t���[����
--EVENT_KEYFRAME_EVERYTIME	= 11;		//!<	�L�[�t���[���܂�
--EVENT_CALL				= 12;		//!<	�C�x���g�R�[��
--EVENT_HP					= 13;		//!<	HP
--EVENT_DEAD				= 14;		//!<	���S���S(���S�A�j���̏I���܂ŊĎ�)
--EVENT_KEYTIME_ONCE		= 15;		//!<	�b��
--EVENT_KEYTIME_EVERYTIME	= 16;		//!<	�b��
--EVENT_ANIME_END			= 17;		//!<	�A�j���[�V�����I��
--EVENT_OBJECT_DESTROYED	= 18;		//!<	OBJ�j��
--TALKEVENT_DIST_ACTION		= 19;		//!<	���������p�x���ł̓���(��b�p)
--TALKEVENT_DIST_IN			= 20;		//!<	������(��b�p)
--TALKEVENT_DIST_OUT		= 21;		//!<	����������ł�(��b�p)
--TALKEVENT_DIST_ANGLEOUT	= 22;		//!<	�������Ŋp�x���O�ꂽ(��b�p)
--TALKEVENT_ANGLE			= 23;		//!<	�������A�p�x��
--EVENT_SIMPLEDAMAGE		= 24;		//!<	�_���[�W�C�x���g	
--EVENT_TURN				= 25;		//!<	����
--EVENT_REGIST_FUNC			= 26;		//!<	���A�[�֐��Ď�
--EVENT_OBJ_DAMAGE			= 27;		//!<	�I�u�W�F�N�g�̃_���[�W���Ď�
--EVENT_KEEPACTIONID		= 28;		//!<	EzState�ɖ��߂𑗂葱����p
--EVENT_EZSTATEMESSAGE		= 29;		//!<	EzState�̖��ߊĎ�
--EVENT_KEYCHECK			= 30;		//!<	�L�[���͂̊Ď�
--EVENT_ITEM				= 31;		//!<	�A�C�e���擾
--EVENT_PK					= 32;		//!<	PK�̊Ď�
--EVENT_SELF_BLOODMARK		= 33;		//!<	�����̌�����
--EVENT_SESSION_JUSTIN		= 34;		//!<	�Z�b�V�����q�����u��
--EVENT_SESSION_IN			= 35;		//!<	�Z�b�V������
--EVENT_SESSION_JUSTOUT		= 36;		//!<	�Z�b�V�����؂ꂽ�u��
--EVENT_SESSION_OUT			= 37;		//!<	�Z�b�V��������
--EVENT_BLOODMENU			= 38;		//!<	�������쐬���j���[�̊Ď�
--EVENT_SOSMENU				= 39;		//!<	SOS�쐬���j���[�̊Ď�
--EVENT_ASSESSMENU			= 40;		//!<	�]�����j���[�̊Ď�
--EVENT_WAPRMENU			= 41;		//!<	���[�v���j���[�̊Ď�
--EVENT_BODYDAM				= 42;		//!<	���ʃ_���[�W�̊Ď�


-------------------------------------------------------------------------------------------------------------------
--��NPC��Ԓ萔
-------------------------------------------------------------------------------------------------------------------

--[[�y���K�[���z�̏��(�S��E�Β����p)]]
ROGARN_STATE_PRISONER		= 16190;--�����
ROGARN_STATE_WAIT			= 16191;--�Β��ő҂�
ROGARN_STATE_ANGRY_M4		= 16192;--�G��(�S��)
ROGARN_STATE_ANGRY_M1		= 16193;--�G��(�Β�)
ROGARN_STATE_DEAD			= 16194;--���S
ROGARN_STATE_GO_M1			= 16195;--�Β��ɍs������
ROGARN_STATE_LAST_WARD		= 16196;--�Ō�̌��t��`������(�Β�)
rogarn_flag_list = {
	ROGARN_STATE_PRISONER,
	ROGARN_STATE_WAIT,
	ROGARN_STATE_ANGRY_M4,
	ROGARN_STATE_ANGRY_M1,
	ROGARN_STATE_DEAD,
	ROGARN_STATE_GO_M1,
	ROGARN_STATE_LAST_WARD
};
TOTALDAMAGE_ROGARN_M40 = 50;--�y���K�[���z�G�Β~�σ_���[�W




--[[�y���M���w�l�z�̏��]]
NOBLE_WOMAN_STATE_BUSINESS	= 16210;--������
NOBLE_WOMAN_STATE_ANGRY		= 16211;--�G��
NOBLE_WOMAN_STATE_DEAD		= 16212;--���S
noble_woman_flag_list = {
	NOBLE_WOMAN_STATE_BUSINESS,
	NOBLE_WOMAN_STATE_ANGRY,
	NOBLE_WOMAN_STATE_DEAD,
};
TOTALDAMAGE_NOBLE_WOMAN = 50;--�y���M���w�l�z�G�Β~�σ_���[�W





--[[�y�����g�z�̏��(�S��A�Β����p)]]
YURUTO_STATE_LIFT			= 16220;--�G���x�[�^�ɂ���
YURUTO_STATE_WAIT_M1		= 16221;--�Β��ɂ���
YURUTO_STATE_ANGRY_M4		= 16222;--�G��(�S��)
YURUTO_STATE_ANGRY_M1		= 16223;--�G��(�Β�)
YURUTO_STATE_DEAD			= 16224;--���S
YURUTO_STANDBY_M1			= 16225;--�Β��ɍs���O
yuruto_flag_list = {
	YURUTO_STATE_LIFT,
	YURUTO_STATE_WAIT_M1,
	YURUTO_STATE_ANGRY_M4,
	YURUTO_STATE_ANGRY_M1,
	YURUTO_STATE_DEAD,
	YURUTO_STANDBY_M1,
};
TOTALDAMAGE_YURUTO_M40 = 50;--�y�����g�z�G�Β~�σ_���[�W

--[[�y�r�������O�����z��Ԉꗗ]]
BIYO_STATE_CAPTIVE					= 16060;--�S���Ɏ����
BIYO_STATE_THANKS					= 16061;--������Ă���Ċ���
BIYO_STATE_SLEEPING_IN_PRISON		= 16062;--�S���ŐQ�Ă���
BIYO_STATE_HOSTILE_IN_PRISON		= 16063;--�G��(�S��)
BIYO_STATE_DEAD						= 16064;--���S(�r������)
BIYO_STATE_TARGET_ENEMY				= 16065;--������|������
BIYO_STATE_END_OF_STRIKES_BACK		= 16066;--�t�P���I����Ė������ĐQ��
BIYO_STATE_HOSTILE_IN_RAMPART		= 16067;--�G��(���)
BIYO_STATE_SEARCH_3					= 16068;--����3��T��
BIYO_STATE_KING_OF_SWORD_KILL		= 16069;--���̌���|���Ė���
BIYO_STATE_HOSTILE_IN_KING_ROOM		= 16070;--�G��(���̌��̕���)
--BIYO_STATE_KING_ROOM_DOWN			= 16071;--���̌��̕����ŐQ��
BIYO_STATE_BATTLE_FLY_DRAGON		= 16072;--�򗳂̒��Ɛ키
--BIYO_STATE_RETURN_TO_STONE_PILLAR	= 16073;--�Β��ɖ߂肽��
--BIYO_STATE_WAIT_M1					= 16074;--�Β��ɂ���
BIYO_STATE_HOSTILE_IN_STONE_PILLAR	= 16075;--�G��(�Β�)
BIYO_STATE_HOSTILE_IN_GATE_FRONT	= 16076;--�G��(�Q�[�g�O)
BIYO_STATE_EXIT						= 16077;--�������Ȃ�
biyo_flag_list = {
	BIYO_STATE_CAPTIVE					,
	BIYO_STATE_THANKS					,
	BIYO_STATE_SLEEPING_IN_PRISON		,
	BIYO_STATE_HOSTILE_IN_PRISON		,
	BIYO_STATE_DEAD						,
	BIYO_STATE_TARGET_ENEMY				,
	BIYO_STATE_END_OF_STRIKES_BACK		,
	BIYO_STATE_HOSTILE_IN_RAMPART		,
	BIYO_STATE_SEARCH_3					,
	BIYO_STATE_KING_OF_SWORD_KILL		,
	BIYO_STATE_HOSTILE_IN_KING_ROOM		,
--	BIYO_STATE_KING_ROOM_DOWN			,
	BIYO_STATE_BATTLE_FLY_DRAGON		,
--	BIYO_STATE_RETURN_TO_STONE_PILLAR	,
--	BIYO_STATE_WAIT_M1					,
	BIYO_STATE_HOSTILE_IN_STONE_PILLAR	,
	BIYO_STATE_HOSTILE_IN_GATE_FRONT	,
	BIYO_STATE_EXIT
};

--[[�y�����z��Ԉꗗ]]
MAJO_STATE_LIBERATE = 16110;--������Ăق���
MAJO_STATE_BREAK    = 16111;--���ŋx�e
MAJO_STATE_HOSTILE  = 16112;--�G��
MAJO_STATE_DEAD     = 16113;--���S
MAJO_STATE_THANKS   = 16114;--����
MAJO_STATE_WAIT_M1	= 16115;--�Β��ɂ���
MAJO_STATE_ANGRY_M1	= 16116;--�G��(�Β�)

majo_flag_list = {
	MAJO_STATE_LIBERATE	,
	MAJO_STATE_BREAK	,
	MAJO_STATE_HOSTILE	,
	MAJO_STATE_DEAD		,
	MAJO_STATE_THANKS	,
	MAJO_STATE_WAIT_M1	,
	MAJO_STATE_ANGRY_M1
};


--[[�E���x�C����Ԉꗗ]]
URUBAIN_STATE_HELP					= 16120;	--�����ė~�������
URUBAIN_STATE_THANKS				= 16121;	--���ӂ��Ă�����
URUBAIN_STATE_ANGRY					= 16122;	--�{���Ă���
URUBAIN_STATE_DEAD					= 16123;	--����ł���
URUBAIN_STATE_STONE_PILLAR			= 16124;	--�Β��ɂ���
URUBAIN_STATE_STONE_PILLAR_ANGRY	= 16125;	--�G��(�Β�)
urubain_flag_list = {
	URUBAIN_STATE_HELP				,
	URUBAIN_STATE_THANKS			,
	URUBAIN_STATE_ANGRY				,
	URUBAIN_STATE_DEAD				,
	URUBAIN_STATE_STONE_PILLAR		,
	URUBAIN_STATE_STONE_PILLAR_ANGRY
};

--�E���x�C���~�σ_���[�W
TOTALDAMAGE_URUBAIN = 50;

--[[�o�b�`��Ԉꗗ]]
BATTI_NOT_STAY		= 16240;--�܂��ǂ��ɂ����Ȃ�
BATTI_COME 			= 16241;--���ė~����(�Í�)
BATTI_PUSHING 		= 16242;--�˂����Ƃ�����(�Í�)
BATTI_SATISFIED 	= 16243;--����(�Í�)
BATTI_ANGRY 		= 16244;--�{���Ă���(�Í�)
BATTI_DEAD 			= 16245;--����ł���
BATTI_TRAP_M6		= 16246;--㩂ɂ͂߂���(�B��)
BATTI_TREASURE_M6	= 16247;--��͒�����(�B��)
BATTI_VEXING_M6		= 16248;--�c�O(�B��)
BATTI_ANGRY_M6		= 16249;--�G��(�B��)
BATTI_DESTORYKUMA	= 16250;--�N�}���V���j(�B��)
BATTI_PRESENT		= 16251;--�A�C�e����������(�B��)
BATTI_SATISFIED_M4	= 16252;--����(�S��)
BATTI_VEXING_M4		= 16253;--�c�O(�S��)
BATTI_ANGRY_M4 		= 16254;--�G��(�S��)
BATTI_RESERVE_M1	= 16255;--�o��������(�Β�)
BATTI_ANGRY_M1		= 16256;--�G��(�Β�)
batti_flag_list = {
	BATTI_NOT_STAY		,
	BATTI_COME			,
	BATTI_PUSHING		,
	BATTI_SATISFIED		,
	BATTI_ANGRY			,
	BATTI_DEAD			,
	BATTI_TRAP_M6		,
	BATTI_TREASURE_M6	,
	BATTI_VEXING_M6		,
	BATTI_ANGRY_M6		,
	BATTI_DESTORYKUMA	,
	BATTI_PRESENT		,
	BATTI_SATISFIED_M4	,
	BATTI_VEXING_M4		,
	BATTI_ANGRY_M4		,
	BATTI_RESERVE_M1	,
	BATTI_ANGRY_M1		
};

--�E�B�X�~�σ_���[�W
TOTALDAMAGE_BATTI = 50;



-------------------------------------------------------------------------------------------------------------------
--������C�x���g�Ŏg�p����萔
-------------------------------------------------------------------------------------------------------------------

--�������h�����q�̏�Ԉꗗ

--������S��
RENDOL_STATE_DEAD                  = 16004;--����ł���

--������1�Œ�
RENDOL_STATE_HELP_FOR_DOREI_HEISI  = 16000;--�z�ꕺ�m���珕����(��ԍŏ��ɉ���1�ɓ������Ƃ��͂��̏�ԂɂȂ�)
RENDOL_STATE_THANKS_1			   = 16001;--����(����1)
RENDOL_STATE_SEARCH_1			   = 16002;--�T��(����1)
RENDOL_STATE_HOSTILE_1             = 16003;--�G��(����1)

--������2�Œ�
RENDOL_STATE_HELP_HIDING_ME        = 16005;--�B��Ă���̂ŏ�����
RENDOL_STATE_THANKS_2			   = 16006;--����(����2)
RENDOL_STATE_SEARCH_2			   = 16007;--�T��(����2)
RENDOL_STATE_HOSTILE_2             = 16008;--�G��(����2)

--������3�Œ�
RENDOL_STATE_LOCATION_INVISIBLE		= 16009;--�����Ȃ��ꏊ�ɂ�������
RENDOL_STATE_WANT_TO_OPEN_THE_GATE	= 16010;--����J���Ăق���
RENDOL_STATE_SCARED					= 16011;--�܏��H�ł��т�
RENDOL_STATE_THANKS_3				= 16012;--����(����3)
RENDOL_STATE_SEARCH_3				= 16013;--�T��(����3)
RENDOL_STATE_HOSTILE_3_FRONT_GATE	= 16014;--�G��(����3 ���̑O)
RENDOL_STATE_HOSTILE_3_BACK_GATE	= 16015;--�G��(����3 ���̌��)

--������4�Œ�
RENDOL_STATE_LIFT_FRONT				= 16016;--����4 �G���x�[�^�O
RENDOL_STATE_HOSTILE_4_LIFT_FRONT	= 16017;--�G��(����4 �G���x�[�^�O)
RENDOL_STATE_HOSTILE_STONE_PILLAR	= 16018;--�G��(�Β�)
RENDOL_STATE_ERASE					= 16019;--�������Ȃ�

rendol_flag_list = {
	RENDOL_STATE_HELP_FOR_DOREI_HEISI,
	RENDOL_STATE_THANKS_1,
	RENDOL_STATE_SEARCH_1,
	RENDOL_STATE_HOSTILE_1,
	RENDOL_STATE_DEAD,
	RENDOL_STATE_HELP_HIDING_ME,
	RENDOL_STATE_THANKS_2,
	RENDOL_STATE_SEARCH_2,
	RENDOL_STATE_HOSTILE_2,
	RENDOL_STATE_LOCATION_INVISIBLE,
	RENDOL_STATE_WANT_TO_OPEN_THE_GATE,
	RENDOL_STATE_SCARED,
	RENDOL_STATE_THANKS_3,
	RENDOL_STATE_SEARCH_3,
	RENDOL_STATE_HOSTILE_3_FRONT_GATE,
	RENDOL_STATE_HOSTILE_3_BACK_GATE,
	RENDOL_STATE_LIFT_FRONT,
	RENDOL_STATE_HOSTILE_4_LIFT_FRONT,
	RENDOL_STATE_HOSTILE_STONE_PILLAR,
	RENDOL_STATE_ERASE,
};

--���J�ڂ���\���̂����Ԉꗗ�̃��X�g(�}�b�v���Ƃɗp��)

--������1
possible_transration_list_m02_00_00_00 = {

	RENDOL_STATE_HELP_FOR_DOREI_HEISI , 
	RENDOL_STATE_THANKS_1 , 
	RENDOL_STATE_SEARCH_1 , 
	RENDOL_STATE_HOSTILE_1 , 
	RENDOL_STATE_DEAD 
};

--������2
possible_transration_list_m02_01_00_00 = {

	RENDOL_STATE_HELP_HIDING_ME , 
	RENDOL_STATE_THANKS_2 , 
	RENDOL_STATE_SEARCH_2 , 
	RENDOL_STATE_HOSTILE_2 , 
	RENDOL_STATE_DEAD 
};

--������3
possible_transration_list_m02_02_00_00 = {

	RENDOL_STATE_LOCATION_INVISIBLE ,
	RENDOL_STATE_WANT_TO_OPEN_THE_GATE , 
	RENDOL_STATE_SCARED ,
	RENDOL_STATE_THANKS_3 , 
	RENDOL_STATE_SEARCH_3 , 
	RENDOL_STATE_HOSTILE_3_FRONT_GATE , 
	RENDOL_STATE_HOSTILE_3_BACK_GATE ,
	RENDOL_STATE_DEAD 
};

--������4
possible_transration_list_m02_03_00_00 = {

	RENDOL_STATE_LIFT_FRONT				,
	RENDOL_STATE_HOSTILE_4_LIFT_FRONT	,
	RENDOL_STATE_HOSTILE_STONE_PILLAR	,
	RENDOL_STATE_DEAD 
};


--����(��)�̏�Ԉꗗ

TYO_STATE_SLEEPING          = 16040;--���ŐQ�Ă���
TYO_STATE_DEAD              = 16041;--����ł���(��)
TYO_STATE_WARNING_AISLE     = 16042;--�x��(�ʘH)
TYO_STATE_WARNING_GATE      = 16043;--�x��(�Q�[�g)
TYO_STATE_WARNING_KING_ROOM = 16044;--�x��(���̊�) 
TYO_STATE_ESCAPE			= 16045;--�P��
tyo_flag_list = {	
	TYO_STATE_DEAD	   ,
	TYO_STATE_WARNING_AISLE ,
	TYO_STATE_WARNING_GATE ,
	TYO_STATE_WARNING_KING_ROOM
};

tyo1_flag_list = {
	TYO_STATE_SLEEPING ,
	TYO_STATE_ESCAPE
};

--����(�ő�1)�̏�Ԉꗗ

KENZOKU_STATE_WARNING           = 16030;--���ɂ���
KENZOKU_STATE_ABSENCE           = 16031;--�s��
KENZOKU_STATE_PROTECT_CASTLE    = 16032;--��ǌ��
KENZOKU_STATE_DEAD              = 16033;--���S
KENZOKU_STATE_WARNING_AND_LEVER = 16034;--���ɂ���(���o�[�j�~����)
KENZOKU_STATE_ABSENCE_AND_LEVER = 16035;--�s��(���o�[�j�~����)
KENZOKU_STATE_ESCAPE			= 16036;--�P��
KENZOKU_2_STATE_DEAD            = 16102;--���S(����2)

kenzoku_flag_list = { 
	KENZOKU_STATE_WARNING           ,
	KENZOKU_STATE_ABSENCE           ,
	KENZOKU_STATE_PROTECT_CASTLE    ,
	KENZOKU_STATE_DEAD              ,
	KENZOKU_STATE_WARNING_AND_LEVER ,
	KENZOKU_STATE_ABSENCE_AND_LEVER ,
	KENZOKU_STATE_ESCAPE			,
	KENZOKU_2_STATE_DEAD            , --����2�Ŏ��S(�ő�) ����1�Ŏ��S�ƕ������Ă���炵�����
};



--����(�ő�2)��Ԉꗗ

KENZOKU_2_STATE_WARNING  = 16100;--�x��
KENZOKU_2_STATE_HEROHERO = 16101;--�w���w��
KENZOKU_2_STATE_DEAD     = 16102;--���S(�ő�2=����2)
KENZOKU_STATE_DEAD       = 16033;--���S(�ő�1=����1) �Ȃ������S��2�ɕ�����Ă���B

kenzoku_2_flag_list = {

	KENZOKU_2_STATE_WARNING  ,
	KENZOKU_2_STATE_HEROHERO ,
	KENZOKU_2_STATE_DEAD ,
    KENZOKU_STATE_DEAD    
};



--��nSFXID
KANAME_SFX = 99100;
KAGI_SFX = 94110;
KEN_SFX = 99050;
ITEM_SFX = 93010;

USER_IDX_Unknow 			= -1;	--�s��
USER_ID_Network_Error		= 0;	--�l�b�g���[�N�Q�G���[�n
USER_ID_Network_Notice		= 1;	--�l�b�g���[�N�Q�ʒm�n
USER_ID_Network_MultiPlay	= 2;	--�l�b�g���[�N�Q�}���`�v���C
USER_ID_Network_Login		= 3;	--�l�b�g���[�N�Q���O�C��
USER_ID_Event_SosLost_White	= 4;	--�C�x���g�QSOS����_White
USER_ID_Event_SosLost_Red	= 5;	--�C�x���g�QSOS����_Red
USER_ID_Event_SosLost_Black	= 6;	--�C�x���g�QSOS����_Black
USER_ID_Event_GetItem		= 7;	--�C�x���g�Q�A�C�e���擾�n


