-----------------------------------------------------------------------------------------------
--	�C�x���g��AI�ł��Ƃ���s���Ƃ��̒萔�ꗗ
--	�L�������Ƃɓ��e���ς��Ǝv���̂ŁA
--	�����ɒ萔���L�q���āA�C�x���g�AAI�̗����̃X�N���v�g��
--	�g�p����悤�ɂ��Ă�������
-----------------------------------------------------------------------------------------------


AI_EVENT_None = -1;		-- �Ƃ��ɂȂ�

-- �t�@�����N�X�p
-- AI_EVENT_Phalanx_Gattai = 0;	-- ���̒�	-- ����Ȃ��񂶂Œ萔�����߂Ă��������B
--�ǂ�ȏ�Ԃ�����ɍו������Ď�肽���Ȃ邩������Ȃ��̂łƂ肠����10��؂�ɐݒ�
AI_EVENT_Phalanx_Gattai = 10;			--���̒�


AI_EVENT_Phalanx_Bousui = 20;			--�a����
AI_EVENT_Phalanx_Bousui_Attack=21;		--�a�����ːi
AI_EVENT_Phalanx_Bousui_WallAttack=22;	--�a�����Ǐ���ːi


AI_EVENT_Phalanx_Bunsan = 30;			--���U��


-- ���̏��p



-- ���̉��l�p
--AI_EVENT_None =-1;					--�ʏ�(slot0)
AI_EVENT_FlameMan_Angry = 10;			--�{���Ă�Ƃ�(slot0)
AI_EVENT_FlameMan_Weaker= 20;			--����Ă�Ƃ�(slot0)

--AI_EVENT_None = -1;					--�܂��Ⴆ�ĂȂ���(slot1) 
AI_EVENT_FlameMan_Roar = 1;				--���K�����Ƃ�(slot1)

--�z�ꕺ�m�C�x���g�p
--AI_EVENT_None = -1;					--�ʏ�
AI_EVENT_DOREI_IKAKU = 10;				--�Њd(slot0)


--�R���җl
AI_EVENT_AREA01 = 10;					--1F�ɋ���Ƃ�(slot0)
AI_EVENT_AREA02 = 20;					--2F�ɋ���Ƃ�(slot0)
AI_EVENT_AREA03 = 30;					--3F�ɋ���Ƃ�(slot0)
AI_EVENT_AREA04 = 40;					--2-3�K�@�x���(slot0)
AI_EVENT_AREA05 = 50;					--1-2�K�@�x���(slot0)
AI_EVENT_AREA06 = 60;					--�����G���A(slot0)

--�w偁H
AI_EVENT_STAY_TUNNEL = 10;				--�v���C���[���g���l���ɂ���(slot0)
AI_EVENT_STAY_ROOM = 20;				--�v���C���[�������ɓ����Ă��Ă�(slot0)

AI_EVENT_TUNNEL_RIGHT = 10;				--�v���C���[���g���l���̉E�[�ɂ���(slot1)
AI_EVENT_TUNNEL_CENTER = 20;			--�v���C���[���g���l���̒����ɂ���(slot1)
AI_EVENT_TUNNEL_LEFT = 30;				--�v���C���[���g���l���̍��[�ɂ���(slot1)
AI_EVENT_ROOM_RIGHT = 40;				--�v���C���[�����������̉E���ɂ���(slot1)
AI_EVENT_ROOM_CENTER = 50;				--�v���C���[�����������̒����ɂ���(slot1)
AI_EVENT_ROOM_LEFT = 60;				--�v���C���[�����������̍����ɂ���(slot1)


--�q���C���p
AI_EVENT_GRACE = 10;					--�q���C���F��v�l(slot0)


--���̏b�`�V�삯�鋐��G�C
AI_EVENT_FOR_RIGHT = 10;				--�����E�G���A(slot0)
AI_EVENT_FOR_CENTER = 20;				--�������ʃG���A(slot0)
AI_EVENT_FOR_LEFT = 30;					--�������G���A(slot0)
AI_EVENT_NEAR = 40;						--�ߋ������ʃG���A(slot0)

--�h���S���f�[�����`�E�h�̑��
AI_EVENT_PUNCH1 = 10;					--�p���`1(slot0)
AI_EVENT_PUNCH2 = 20;					--�p���`2(slot0)
AI_EVENT_PUNCH3 = 30;					--�p���`3(slot0)
AI_EVENT_PUNCH4 = 40;					--�p���`4(slot0)

AI_EVENT_BREATH1 = 50;					--�u���X1(slot0)
AI_EVENT_BREATH2 = 60;					--�u���X2(slot0)
AI_EVENT_BREATH3 = 70;					--�u���X3(slot0)
AI_EVENT_BREATH4 = 80;					--�u���X4(slot0)

AI_EVENT_BITEATTACK = 90;				--���ݕt���U��(slot0)

--���̉��l
AI_EVENT_REACTION = 10;					--���̉��l���A�N�V����(slot0)

--�L����
AI_EVENT_KIMERA_TALE_CUT = 10;			--�����ېؒf(slot0)

--�g�f�[����
AI_EVENT_LEECH_REGENERATE = 10;			--OBJ�Đ��\(slot0)

--�r�������O����
AI_EVENT_HIRYU_GATE	= 10;				--�򗳂��Q�[�g�O�ɂ���(slot0)

--���J�f
AI_EVENT_MUKADE_TALE_CUT = 1;			--�����ېؒf(slot0)
