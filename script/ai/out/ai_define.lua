-----------------------------------------------------------------------------------------------
--	AI�Ŏg�p����萔�̈ꗗ
--�@��{�I�ɂ����ŋL�q���Ă���ID�͂��ׂăv���O�������ƑΉ�������K�v������܂��̂ŁA
--	�ύX���Ȃ��悤�ɂ��Ă��������B
-----------------------------------------------------------------------------------------------


-- �S�[���̎��s����
GOAL_RESULT_Failed = -1;	-- ���s
GOAL_RESULT_Continue = 0;	-- �p��
GOAL_RESULT_Success = 1;	-- ����


-- �^�[�Q�b�g�ʒu�̎w��Ɏg�p�������
-- ��ƂȂ�ʒu�ɂ���Č��ʂ͂��ƂȂ�܂�
-- �u�����v�́u�O���v�ł���΁A�v���C���[�̌����Ă�������ƈ�v���܂��B
AI_DIR_TYPE_CENTER = 0;	-- ���S
AI_DIR_TYPE_F = 1;		-- ����̑O��
AI_DIR_TYPE_B = 2;		-- ����̌��	
AI_DIR_TYPE_L = 3;		-- ����̍�
AI_DIR_TYPE_R = 4;		-- ����̉E
AI_DIR_TYPE_ToF = 5;	-- �i�������瑊��̕����Ɂj�������đO
AI_DIR_TYPE_ToB = 6;	-- �������Č�
AI_DIR_TYPE_ToL = 7;	-- �������č�
AI_DIR_TYPE_ToR = 8;	-- �������ĉE


-- �����^�C�v
-- �߁A���A�����L�����̃p�����[�^����擾���܂��B
-- ������Excel�ōs���܂��B
DIST_Near = 0;	-- �ߋ���
DIST_Middle = 1;	-- ������
DIST_Far = 2;	-- ������
DIST_Out = 3;	-- �͈͊O
DIST_None = 4;	-- ����


-- �^�[�Q�b�g���w�肷��^�C�v
-- ���G���ꂽ�^�[�Q�b�g�ꗗ�̒�����Y��������̂�I�����܂��B
-- �w�肵���^�C�v�����Ȃ��ꍇ������܂��B
TARGET_NONE = -2;		-- �^�[�Q�b�g�Ȃ��i���񂵂����Ȃ��ꍇ�ȂǂɎg�p�j
TARGET_SELF = -1;		-- ����
TARGET_ENE_0 = 0;		-- ��ԗD��x�̍����U���^�[�Q�b�g
TARGET_ENE_1 = 1;
TARGET_ENE_2 = 2;
TARGET_ENE_3 = 3;
TARGET_ENE_4 = 4;
TARGET_ENE_5 = 5;
TARGET_ENE_6 = 6;
TARGET_ENE_7 = 7;
TARGET_ENE_8 = 8;
TARGET_ENE_9 = 9;
TARGET_FRI_0 = 10;		-- ��ԗD��x�̍��������^�[�Q�b�g
TARGET_FRI_1 = 11;
TARGET_FRI_2 = 12;
TARGET_FRI_3 = 13;
TARGET_FRI_4 = 14;
TARGET_FRI_5 = 15;
TARGET_FRI_6 = 16;
TARGET_FRI_7 = 17;
TARGET_FRI_8 = 18;
TARGET_FRI_9 = 19;
TARGET_EVENT = 20;			-- �C�x���g�Ŏw�肳�ꂽ�^�[�Q�b�g
TARGET_LOCALPLAYER = 21;	-- ���[�J���v���C���[


-- �|�C���g���w�肷��^�C�v
POINT_INITIAL 				= 100;	-- �����ʒu
POINT_SNIPE 				= 101;	-- �_���ʒu
POINT_EVENT 				= 102;	-- �C�x���g�w��ʒu
POINT_MOVE_POINT 			= 103;	-- �|�C���g�ړ�
POINT_NEAR_NAVIMESH			= 104;	-- �߂��i�r���b�V���̃|���S��
POINT_FAR_NAVIGATE			= 105;	-- �^�[�Q�b�g�̏���Ă���p�[�c�̒��ň�ԉ����Q�[�g
POINT_NEAR_NAVIGATE			= 106;	-- �^�[�Q�b�g�̏���Ă���p�[�c�̒��ň�ԋ߂��Q�[�g
POINT_AI_FIXED_POS			= 107;	-- AI�X�N���v�g�ŁASetAIFixedMoveTarget()�Őݒ肳�ꂽ�ʒu�Ɍ������B
POINT_FAR_LANDING			= 108;	-- �^�[�Q�b�g�̏���Ă���p�[�c�̒��ŁA�^�[�Q�b�g���牓�����n�_�B
POINT_NEAR_LANDING			= 109;	-- �^�[�Q�b�g�̏���Ă���p�[�c�̒��ŁA�^�[�Q�b�g����߂����n�_�B
POINT_2ndNEAR_LANDING		= 110;	-- �^�[�Q�b�g�̏���Ă���p�[�c�̒��ŁA�^�[�Q�b�g����Q�Ԗڂɋ߂����n�_�B
POINT_INIT_POSE				= 111;	-- �����ʒu�̎p���i����^�[�Q�b�g�ɂ���ƁA���̎p���ɂȂ�B�j
POINT_HitObstacle			= 112;	-- �Ō�ɐڐG������Q���B
--POINT_LastRequestPosition	= 113;	-- ���I���g���ׂ��炸���I���Ō�̖ڕW�ʒu�B
POINT_CurrRequestPosition	= 114;	-- ���݂̖ڕW�ʒu�B


-- ���荞�݃^�C�v
INTERUPT_FindEnemy 				= 0;	-- �����Ă��Ȃ������G��������
INTERUPT_FindAttack 			= 1;	-- ��Ԑg�߂ȃ^�[�Q�b�g���U���J�n
INTERUPT_Damaged 				= 2;	-- �U�����ꂽ
INTERUPT_Damaged_Stranger 		= 3;	-- ���G���Ă��Ȃ��G����U�����ꂽ
INTERUPT_FindMissile 			= 4;	-- ��ѓ���𔭌������i�������j
INTERUPT_SuccessGuard 			= 5;	-- �K�[�h����
INTERUPT_MissSwing 				= 6;	-- �G����U��
INTERUPT_GuardBegin 			= 7;	-- �G���K�[�h�J�n
INTERUPT_GuardFinish 			= 8;	-- �G���K�[�h�I��
INTERUPT_GuardBreak 			= 9;	-- �K�[�h�͂���
INTERUPT_Shoot 					= 10;	-- �G����ѓ����������
INTERUPT_ShootReady 			= 11;	-- �G����ѓ�����\�����i�������j
INTERUPT_UseItem 				= 12;	-- �G���A�C�e�����g����
INTERUPT_EnterBattleArea 		= 13;	-- �퓬�̈�ɓ�����
INTERUPT_LeaveBattleArea 		= 14;	-- �퓬�̈�𗣒E����
INTERUPT_CANNOT_MOVE			= 15;	-- ��莞�Ԉړ��ł��Ȃ�
INTERUPT_Inside_ObserveArea		= 16;	-- �Ď��G���A�̒��Ƀ^�[�Q�b�g���������B
INTERUPT_ReboundByOpponentGuard	= 17;	-- ����̃K�[�h�ɂ���čU�����e���ꂽ�B
INTERUPT_ForgetTarget			= 18;	-- �^�[�Q�b�g��Y�ꂽ�B
INTERUPT_FriendRequestSupport	= 19;	-- �������~���v�����o���Ă���B
INTERUPT_TargetIsGuard			= 20;	-- �^�[�Q�b�g���U�����K�[�h�����B
INTERUPT_HitEnemyWall			= 21;	-- �G�ǂɐڐG�����B
INTERUPT_SuccessParry			= 22;	-- �p���B�����������B
INTERUPT_CANNOT_MOVE_DisableInterupt = 23;	-- ��莞�Ԉړ��ł��Ȃ��i���荞�ݖ������̂݌Ă΂��j


-- �����^�C�v
COORDINATE_TYPE_None = -1;	-- �Ȃ�

-- �U���\�񂷂�
-- �U���\��l�������ȏ�̂Ƃ��ɍU�����Ȃ��悤�ɂ��邱�Ƃ��ł���
-- �ǉ��A���l�擾����Ƃ��̃^�[�Q�b�g�F�U������^�[�Q�b�g

COORDINATE_TYPE_Attack 				= 0;	-- �U���\��
COORDINATE_TYPE_SideWalk_L 			= 1;	-- �����։��ړ�
COORDINATE_TYPE_SideWalk_R 			= 2;	-- �E���։��ړ�
COORDINATE_TYPE_AttackOrder 		= 3;	-- �U������
COORDINATE_TYPE_Support				= 4;	-- �~���B
COORDINATE_TYPE_KIMERAbite			= 100;	-- �L�������ݕt���B
COORDINATE_TYPE_UROKOIwaSupport		= 110;	-- �E���R�Ⓤ���x���U�����B



-- �`�[�����߃^�C�v
-- �`�[������̎w�߂��擾���܂��B
ORDER_TYPE_Role = 0;	-- �����擾


-- �`�[�����炭��������S�ł�
-- �����䂳��@���O�͕�����₷�����̂ɕς��Ă�������
ROLE_TYPE_None = -1;	-- �����Ȃ�
ROLE_TYPE_Attack = 0;	-- �U����
ROLE_TYPE_Torimaki = 1;	-- �Ƃ�܂�
ROLE_TYPE_Kankyaku = 2;	-- �ϋq


-- NPC�v���C���[�p�̍U���ԍ�
-- ������Attack�S�[����EzState�ԍ��ɓ����B
-- NPC�v���C���[�ł̂ݗL��
NPC_ATK_NormalR 		= 0;				-- �E��ʏ�
NPC_ATK_LargeR 			= 1;				-- �E���U��
NPC_ATK_PushR 			= 2;				-- �E�艟���o���U��
NPC_ATK_NormalL 		= 3;				-- ����ʏ�
NPC_ATK_GuardL 			= 4;				-- ����K�[�h
NPC_ATK_Parry 			= 5;				-- ����p���B
NPC_ATK_Magic 			= 6;				-- ���@�i���j
NPC_ATK_MagicL			= NPC_ATK_Magic;	-- ���@�i���j
NPC_ATK_Item 			= 7;				-- �A�C�e��
NPC_ATK_SwitchWep 		= 8;				-- �Ў藼��؂�ւ�
NPC_ATK_StepF 			= 9;				-- �X�e�b�v�ړ��O
NPC_ATK_StepB 			= 10;				-- �X�e�b�v�ړ���
NPC_ATK_StepL 			= 11;				-- �X�e�b�v�ړ���
NPC_ATK_StepR 			= 12;				-- �X�e�b�v�ړ��E
NPC_ATK_ChangeWep_R1	= 13;				-- �E�r�啐��ɐ؂�ւ�
NPC_ATK_ChangeWep_R2	= 14;				-- �E�r������ɐ؂�ւ�
NPC_ATK_ChangeWep_L1	= 15;				-- ���r�啐��ɐ؂�ւ�
NPC_ATK_ChangeWep_L2	= 16;				-- ���r������ɐ؂�ւ�
NPC_ATK_BackstepF		= 17;				-- �o�b�N�X�e�b�v�O
NPC_ATK_BackstepB		= 18;				-- �o�b�N�X�e�b�v��
NPC_ATK_BackstepL		= 19;				-- �o�b�N�X�e�b�v��
NPC_ATK_BackstepR		= 20;				-- �o�b�N�X�e�b�v�E
NPC_ATK_MagicR			= 21;				-- ���@�i�E�j



-- �G�N�Z���p�����[�^�^�C�v
AI_EXCEL_THINK_PARAM_TYPE__NONE						= 0;	-- ����
AI_EXCEL_THINK_PARAM_TYPE__maxBackhomeDist			= 1;	-- 
AI_EXCEL_THINK_PARAM_TYPE__backhomeDist				= 2;	-- 
AI_EXCEL_THINK_PARAM_TYPE__backhomeBattleDist		= 3;	-- 
AI_EXCEL_THINK_PARAM_TYPE__nonBattleActLife			= 4;	-- 
AI_EXCEL_THINK_PARAM_TYPE__BattleStartDist			= 5;	-- �퓬�J�n�����B
AI_EXCEL_THINK_PARAM_TYPE__bMoveOnHearSound			= 6;	-- 
AI_EXCEL_THINK_PARAM_TYPE__CannotMoveAction			= 7;	-- �ړ��ł��Ȃ��Ȃ��Ă��鎞��EzState�ԍ��B
AI_EXCEL_THINK_PARAM_TYPE__battleGoalID				= 8;	-- �퓬�S�[��ID
AI_EXCEL_THINK_PARAM_TYPE__BackHome_LookTargetTime	= 9;	
AI_EXCEL_THINK_PARAM_TYPE__BackHome_LookTargetDist	= 10;
AI_EXCEL_THINK_PARAM_TYPE__BackHomeLife_OnHitEnemyWall	= 11;

--�|�C���g�ړ��^�C�v�B
POINT_MOVE_TYPE_Patrol 					= 0;	-- ����
POINT_MOVE_TYPE_RoundTrip				= 1;	-- ����
POINT_MOVE_TYPE_Randum					= 2;	-- �����_��
POINT_MOVE_TYPE_Gargoyle_Air_Patrol		= 3;	-- �K�[�S�C���󒆏���
POINT_MOVE_TYPE_Gargoyle_Landing		= 4;	-- �K�[�S�C�����n�B


--�rID(ChrAsm::WEP_SET_POS�ɑΉ�)
ARM_L	= 0;
ARM_R	= 1;

--���푕���iChrAsm::WEP_SLOT_OFFSET�ɑΉ��j
WEP_Primary 	= 0;
WEP_Secondary 	= 1;


-- ���v�����j���O���̃S�[���A�N�V�����B
NPC_THINK_GOAL_ACTION__NONE				= 0;			--/< �������Ȃ�
NPC_THINK_GOAL_ACTION__TURN_TO_TGT		= 1;			--/< �^�[�Q�b�g�̕����Ɍ���
NPC_THINK_GOAL_ACTION__WALK_TO_TGT		= 2;			--/< �^�[�Q�b�g�֕���
NPC_THINK_GOAL_ACTION__RUN_TO_TGT		= 3;			--/< �^�[�Q�b�g�֑���
NPC_THINK_GOAL_ACTION__SET_GOAL			= 4;			--/< �C�ӂ̃S�[����ݒ�



--������ʂ̏�Ԉُ�^�C�v�B
SP_EFFECT_TYPE_NONE=0;			-- �Ȃ�
SP_EFFECT_TYPE_FIRE=1;			-- ��
SP_EFFECT_TYPE_POIZON=2;			-- ��
SP_EFFECT_TYPE_LEECH=3;			-- �q��
SP_EFFECT_TYPE_SPOIL=4;			-- ���H
SP_EFFECT_TYPE_ILLNESS=5;			-- �u�a
SP_EFFECT_TYPE_BLOOD=6;			-- �o��
SP_EFFECT_TYPE_CAMOUFLAGE=7;			-- �S�[�X�g�J���t���[�W��
SP_EFFECT_TYPE_HIDDEN=8;			-- �p�B��
SP_EFFECT_TYPE_MASOCHIST=9;			-- �}�]�q�X�g
SP_EFFECT_TYPE_RECOVER_POZON=10;			-- ��Ԉُ�񕜁y�Łz
SP_EFFECT_TYPE_RECOVER_ILLNESS=11;			-- ��Ԉُ�񕜁y�u�a�z
SP_EFFECT_TYPE_RECOVER_BLOOD=12;			-- ��Ԉُ�񕜁y�o���z
SP_EFFECT_TYPE_RECOVER_ALL=13;			-- ��Ԉُ�񕜁y���\�z
SP_EFFECT_TYPE_SOUL_STEAL=14;			-- �\�E���X�e�B�[��
SP_EFFECT_TYPE_ZOOM=15;			-- �Y�[��
SP_EFFECT_TYPE_WARP=16;			-- ���[�v
SP_EFFECT_TYPE_DEMONS_SOUL=17;			-- �f�����Y�\�E��
SP_EFFECT_TYPE_BLACK_DISPERSE=18;			-- ���S�[�X�g�ގU
SP_EFFECT_TYPE_TOUGH_GHOST=19;			-- ���S�[�X�g
SP_EFFECT_TYPE_WHITE_REQUEST=20;			-- �z���C�g��]
SP_EFFECT_TYPE_BLACK_REQUEST=21;			-- �u���b�N��]
SP_EFFECT_TYPE_CHANGE_BLACK=22;			-- ���S�[�X�g��
SP_EFFECT_TYPE_REVIVE=23;			-- �h��
SP_EFFECT_TYPE_FORBID_USEMAGIC=24;			-- ���@�g�p�֎~
SP_EFFECT_TYPE_MIRACLE_DIRAY=25;			-- ��Ճ��[�V��������
SP_EFFECT_TYPE_WHETSTONE=26;			-- �u��
SP_EFFECT_TYPE_SUSPENDED_REVIVE=27;			-- �����h��
SP_EFFECT_TYPE_ENCHANT_WEAPON=28;			-- ���틭��
SP_EFFECT_TYPE_ENCHANT_ARMOR=29;			-- �h��V�[���h
SP_EFFECT_TYPE_WIRE_WRAPED=30;			-- ���܂݂�
SP_EFFECT_TYPE_GHOST_PARAM_CHANGE=31;			-- ����t���O�^�z���C�g�A�u���b�N�A�O���C�S�[�X�g���ɃV�X�e���Ƃ��āA�����I�ɑ��������������ʁi�����ɂȂ�����O���j
SP_EFFECT_TYPE_PARALYSIS=32;			-- �����蒆�́A�ړ��A�U���A�A�C�e���g�p���ł��Ȃ��Ȃ�^���ʎ��Ԃ�ݒ肷��.EzState�ɂ��Ή����s��.
SP_EFFECT_TYPE_FLY_CROWD=33;			-- 墂�����
SP_EFFECT_TYPE_FIREMAN_STAGE_1=34;			-- �����l_��P�i�K
SP_EFFECT_TYPE_FIREMAN_STAGE_2=35;			-- �����l_��Q�i�K
SP_EFFECT_TYPE_FIREMAN_STAGE_3=36;			-- �����l_��R�i�K
SP_EFFECT_TYPE_FIREMAN_STAGE_4=37;			-- �����l_��S�i�K
SP_EFFECT_TYPE_HALLUCINATION=38;			-- ����
SP_EFFECT_TYPE_SOULCOIN=39;			-- �\�E���R�C��
SP_EFFECT_TYPE_TOUGH_SHIELD=40;			-- ���h��V�[���h
SP_EFFECT_TYPE_ANTIFIRE_SHIELD=41;			-- �Αϐ��V�[���h
SP_EFFECT_TYPE_HP_RECOVERY=42;			-- HP�񕜏��
SP_EFFECT_TYPE_FORCE_GHOST_STAGE1=43;			-- �����S�[�X�g���@��1�i�K
SP_EFFECT_TYPE_FORCE_GHOST_STAGE2=44;			-- �����S�[�X�g���@��2�i�K
SP_EFFECT_TYPE_FORCE_GHOST_STAGE3=45;			-- �����S�[�X�g���@��3�i�K
SP_EFFECT_TYPE_PHEROMONE=46;			-- �t�F������
SP_EFFECT_TYPE_CAT_LANDING=47;			-- �L���n
SP_EFFECT_TYPE_PINCH_ATTACKPOWER_UP=48;			-- �s���`�U���̓A�b�v
SP_EFFECT_TYPE_PINCH_DEFENSIBILITY_UP=49;			-- �s���`�h��̓A�b�v
SP_EFFECT_TYPE_REGENERATE=50;			-- ���W�F�l���C�g
SP_EFFECT_TYPE_TORCH=51;			-- �����܂�
SP_EFFECT_TYPE_WEAK_REGENERATE=52;			-- �ナ�W�F�l���C�g
SP_EFFECT_TYPE_WEAK_CAMOUFLAGE=53;			-- ��S�[�X�g�J���t���[�W��
SP_EFFECT_TYPE_WEAK_HIDDEN=54;			-- ��p�B��
SP_EFFECT_TYPE_HINT_BLOOD_SIGN=55;			-- �q���g������
SP_EFFECT_TYPE_LEECH_FOOT=56;			-- �q����
SP_EFFECT_TYPE_YELLOW_CLOAK=57;			-- ����
SP_EFFECT_TYPE_POINT_LIGHT=58;			-- �_����
SP_EFFECT_TYPE_BLOOD_SIGN_ESTIMATION=59;			-- �������]��
SP_EFFECT_TYPE_ENCHANT_WEAPON_REGULAR=60;			-- ���̕���i���@�j
SP_EFFECT_TYPE_ENCHANT_WEAPON_LARGE=61;			-- �􂢂̕���i���@�j
SP_EFFECT_TYPE_ENCHANT_WEAPON_FIRE=62;			-- �����i�A�C�e���j
SP_EFFECT_TYPE_ENCHANT_WEAPON_FIRE_LARGE=63;			-- �������i�A�C�e���j
SP_EFFECT_TYPE_ENCHANT_WEAPON_MAGIC=64;			-- �f�[�����̏b���i�A�C�e���j
SP_EFFECT_TYPE_CHIMERA_POWER_UP=65;			-- �L���������i�S��Q�L�����p�j
SP_EFFECT_TYPE_ITEM_DROP_RATE=66;			-- �A�C�e���𑕔�����ƁA�u�G��|�����Ƃ��ɃA�C�e���ɂȂ�m���v���A�b�v�����܂�


