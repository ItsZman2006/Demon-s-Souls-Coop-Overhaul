
LEFTBRAKE_COUNT = 0;
RIGHTBRAKE_COUNT = 0;

--��\���}�X�N�̗p��
DISPMASK_RIGHT1 = 1;
DISPMASK_RIGHT2 = 2;
DISPMASK_LEFT1 = 4;
DISPMASK_LEFT2 = 8;

--���݂̕\���}�X�N�̊Ǘ��p
DISP_ALL = 15;
DISPMASK_NOW = 15;

--���̃_���[�W�{��
FOOTDAMAGE_RATE = 0.33;
--����HP
--FOOTHP_01 = 30;--1�i�K�ڂ܂�>�\�E���\����
FOOTHP_01 = 28.6;--1�i�K�ڂ܂�>�\�E���\����
--FOOTHP_02 = 30;--2�i�K�ڂ܂�>�\�E���\����&1�i�K�j��
FOOTHP_02 = 28.6;--2�i�K�ڂ܂�>�\�E���\����&1�i�K�j��
--FOOTHP_03 = 30;--3�i�K�ڂ܂�>�\�E���\����&2�i�K�j��
FOOTHP_03 = 28.6;--3�i�K�ڂ܂�>�\�E���\����&2�i�K�j��

--����]�|�́@FOOTHP_01+FOOTHP_02+FOOTHP_03�@�ł�
--FOOTHP_04 = 75;--����]�|������A����HP�񕜗�
FOOTHP_04 = 71.5;--����]�|������A����HP�񕜗�

STAND_UP_TIME = 12;	--�_�E�����Ă���N���オ��܂ł̎��ԁisec)

--���̃_���[�W�{��
HEADDMAGE_RATE = 2.5;--�ʏ�U���p�̔{���ł�
--���ɑ΂���e�ۃ_���[�W��R
HEADBULLETREGIST_RATE = 0.4;

--------------------------------------------------------------------------------------
--�C�x���g���������{�X�ŗL�̃C�x���g��o�^����ۂɎg�p���Ă�������
--------------------------------------------------------------------------------------
function EventBoss_Initialize_m02_01_00_00(proxy)
	print("EventBoss_Initialize_m02_01_00_00 begin");
	
	--�����{�X�������Ă�����
	if proxy:IsCompleteEvent( 4224 ) ==false then
		--�N���C�A���g�Ŗ����Ȃ�@�V���O���@or�@�z�X�g
		if	proxy:IsClient() == false then
			proxy:RequestForceUpdateNetwork( 801 );
		end
		--���̏��̏�����
		BossInit_KingOfShield(proxy,param);
		print("�����̏� ��������");
	end
	
	print("EventBoss_Initialize_m02_01_00_00 end");
end

--------------------------------------------------------------------------------------
--�{�X�p�̏������������K�v�ȂƂ��Ɏg�p�F�ŗL���̍쐬��
--------------------------------------------------------------------------------------
function BossInit_KingOfShield(proxy,param)
	print("BossInit_KingOfShield begin");
	--4260�`4280�Ƃ肠�������̏��p�A�N�V����ID
	--���̏��A���Ƀ_���[�W���s���Ȃ��悤�ɕ��ʃ_���[�W�ŊǗ�����
	--���m�ɂ̓_���[�W������Ȃ��̂Ńn���h����p�ӂ���K�v�͖������A�O�̂��ߗp��	
	if proxy:CreateEventBody(4260,801,"OnEvent_4260_EVENTDAMAGE",1000000,0.0,once) == true then
		proxy:AddEventParts_Ignore(4260,801,"Ragdoll_L_weapon02");
		proxy:AddEventParts_Ignore(4260,801,"Ragdoll_R_weapon01");
	end
	
	--�����p�C�x���g�_���[�W
	SingleReset( proxy , 4261 );
	if proxy:CreateEventBody(4261,801,"OnEvent_4261",FOOTHP_01,FOOTDAMAGE_RATE,everytime) == true then
		proxy:AddEventParts( 4261,801,"Ragdoll_L_Foot01");
		proxy:AddEventParts( 4261,801,"Ragdoll_L_Calf01");
		proxy:AddEventParts( 4261,801,"Ragdoll_L_Toe01");
		proxy:AddEventParts( 4261,801,"Ragdoll_L_Thigh01");		
	end
	
	--�E���p�C�x���g�_���[�W
	SingleReset( proxy , 4262 );
	if proxy:CreateEventBody(4262,801,"OnEvent_4262",FOOTHP_01,FOOTDAMAGE_RATE,everytime) == true then
		proxy:AddEventParts( 4262,801,"Ragdoll_R_Foot01");
		proxy:AddEventParts( 4262,801,"Ragdoll_R_Calf01");
		proxy:AddEventParts( 4262,801,"Ragdoll_R_Toe01");
		proxy:AddEventParts( 4262,801,"Ragdoll_R_Thigh01");		
	end
	
	--���p�C�x���g�_���[�W
	SingleReset( proxy, 4263 );
	if proxy:CreateEventBody(4263,801,"OnEvent_4263",10000000,HEADDMAGE_RATE,once) == true then
		proxy:SetEventBodyBulletCorrect( 4263 , HEADBULLETREGIST_RATE );
		proxy:AddEventParts( 4263,801,"Ragdoll_Head01");
		proxy:AddEventParts( 4263,801,"Ragdoll_Neck01");
		proxy:AddEventParts( 4263,801,"Ragdoll_R_Clavicle01");
		proxy:AddEventParts( 4263,801,"Ragdoll_L_Clavicle01");		
	end
	
	--���b�S�\��
	proxy:SetDispMask( 801 , DISP_ALL );
	--proxy:SetDispMask( 801 , 12 );--�����̂�
	--proxy:SetDispMask( 801 , 3 );--�E���̂�
	
	--���ʔj��SFX�p�n���h���p�� �����p
	proxy:LuaCall( 4264 , 0 , "OnEvent_4264",everytime);
	--���ʔj��SFX�p�n���h���p�� �E���p
	proxy:LuaCall( 4265 , 0 , "OnEvent_4265",everytime);
	
	
	--SingleReset( proxy ,4741);
	SingleReset( proxy ,4266);
	--EzState���ߗp�b���C�x���g�폜
	--proxy:LuaCall(4741,0,"OnEvent_4741",everytime);
	--proxy:LuaCall(4741,1,"OnEvent_4741_1",everytime);
	proxy:LuaCall(4266,0,"OnEvent_4266",everytime);
	proxy:LuaCall(4266,1,"OnEvent_4266_1",everytime);
	
	--SingleReset( proxy ,4742);
	SingleReset( proxy ,4267);
	--EzState���ߔz�M�p
	--proxy:LuaCall(4742,1,"OnEvent_4742_1",everytime);
	--proxy:LuaCall(4742,2,"OnEvent_4742_2",everytime);
	proxy:LuaCall(4267,1,"OnEvent_4267_1",everytime);
	proxy:LuaCall(4267,2,"OnEvent_4267_2",everytime);
	
	--SingleReset( proxy ,4743);
	--SingleReset( proxy ,4744);
	SingleReset( proxy ,4268);
	SingleReset( proxy ,4269);
	--EzState�̊Ď�
	--proxy:OnCheckEzStateMessage(4743,804,"OnEvent_4743",250);
	--proxy:OnCheckEzStateMessage(4744,804,"OnEvent_4744",260);
	proxy:OnCheckEzStateMessage(4268,801,"OnEvent_4268",1101);
	proxy:OnCheckEzStateMessage(4269,801,"OnEvent_4269",1100);
	
	--[[
���̑��@�i���������j
Ragdoll_Pelvis01
Ragdoll_Spine01
Ragdoll_Spine02
Ragdoll_L_Clavicle01
Ragdoll_L_UpperArm01
Ragdoll_L_Forearm01
Ragdoll_L_Hand01
Ragdoll_R_Clavicle01
Ragdoll_R_UpperArm01
Ragdoll_R_Forearm01
Ragdoll_R_Hand01
	]]	
	print("BossInit_KingOfShield end");
end

--���̏��퓬�J�n
function StandBy_KingOfShield(proxy,param)
	print("StandBy_KingOfShield begin");
	--�Ƃ肠�����R�R��Max�ݒ�&��
	proxy:SetEventBodyMaxHp(4261,FOOTHP_01);	
	--�Ƃ肠�����R�R��Max�ݒ�&��
	proxy:SetEventBodyMaxHp(4262,FOOTHP_01);
	print("StandBy_KingOfShield end");
end

--���̏��̖��G���ʊĎ��̃n���h���E�E�E�Ă΂ꂽ��ǂ������������B
function OnEvent_4260_EVENTDAMAGE(proxy,param)
	print("OnEvent_4260_EVENTDAMAGE begin");
	print("ERROR! �������Ă͂����Ȃ��C�x���g���������Ă��܂��I");
	print("OnEvent_4260_EVENTDAMAGE end");
end


--------------------------------------------------------------------------------------
--�������ʂ�HP��0�ɂȂ������̃C�x���g
--------------------------------------------------------------------------------------
function OnEvent_4261(proxy,param)
	if 	proxy:IsCompleteEvent( 4261 ) == true or
		proxy:IsCompleteEvent( 4262 ) == true then
		return false;
	end	
	
	if proxy:IsClient() == false then
		print("OnEvent_4261 begin");
		proxy:LuaCallStart( 4264 , 0);
		print("OnEvent_4261 end");
		--���E�����󂵂Ă�
		if 	LEFTBRAKE_COUNT == 3 and
			RIGHTBRAKE_COUNT == 3 then
			--���ʔj��C�x���g�d���֎~�p
			proxy:SetEventFlag( 4261 , true );
			--�_�E���ł���悤�ɖ��ߔz�M
			proxy:NotNetMessage_begin();				
				proxy:OnKeyTime2(4270,"OnEvent_4270_1",5,1,0,once);
			proxy:NotNetMessage_end();
		end
	end
	
	--[[
	--�Ƃ肠�����R�R�ŉ�
	--proxy:CheckEventBody(4261);
	]]
end

--------------------------------------------------------------------------------------
--�E�����ʂ�HP��0�ɂȂ������̃C�x���g
--------------------------------------------------------------------------------------
function OnEvent_4262(proxy,param)
	if 	proxy:IsCompleteEvent( 4261 ) == true or
		proxy:IsCompleteEvent( 4262 ) == true then
		return false;
	end	
	
	if proxy:IsClient() == false then
		print("OnEvent_4262 begin");
		proxy:LuaCallStart( 4265 , 0 );
		print("OnEvent_4262 end");
		--���E�����󂵂Ă�
		if 	LEFTBRAKE_COUNT == 3 and
			RIGHTBRAKE_COUNT == 3 then
			--���ʔj��C�x���g�d���֎~�p
			proxy:SetEventFlag( 4262 , true );
			--�_�E���ł���悤�ɖ��ߔz�M
			proxy:NotNetMessage_begin();				
				proxy:OnKeyTime2(4270,"OnEvent_4270_1",5,1,0,once);
			proxy:NotNetMessage_end();			
		end
	end	
	--�Ƃ肠�����R�R�ŉ�
	--proxy:CheckEventBody(4262);
end


--------------------------------------------------------------------------------------
--�����̔j��C�x���g�z�M�p
--------------------------------------------------------------------------------------
function OnEvent_4264(proxy,param)
	print("OnEvent_4264 begin");
	--�j��񐔂̒i�K�ɂ����SFX�\�����s��
	if LEFTBRAKE_COUNT == 0 then
		proxy:SetEventSpecialEffect_2(801,5067);
		--�Ƃ肠�����R�R��Max�ݒ�&��
		proxy:SetEventBodyMaxHp(4261,FOOTHP_02);
		proxy:CheckEventBody(4261);
		proxy:SetEventFlag( 4261 , false );
	elseif LEFTBRAKE_COUNT == 1 then
		proxy:EraseEventSpecialEffect_2(801,5067);
		proxy:SetEventSpecialEffect_2(801,5068);
		--proxy:CreateSfx_DummyPoly( 801 , 225 , 14990 );
		--DISPMASK_NOW = DISPMASK_NOW - DISPMASK_LEFT1
		--proxy:SetDispMask(801, DISPMASK_NOW);--�h���\��
		--print("DISPMASK_NOW ",DISPMASK_NOW);
		--�Ƃ肠�����R�R��Max�ݒ�&��
		proxy:SetEventBodyMaxHp(4261,FOOTHP_03);
		proxy:CheckEventBody(4261);
		proxy:SetEventFlag( 4261 , false );
	elseif LEFTBRAKE_COUNT == 2 then		
		 DISPMASK_NOW = DISPMASK_NOW - DISPMASK_LEFT1 - DISPMASK_LEFT2;
		proxy:SetDispMask(801, DISPMASK_NOW);--�h���\��
		print("DISPMASK_NOW ",DISPMASK_NOW);
		proxy:CreateSfx_DummyPoly( 801 , 225 , 14990 );
		--���b�N�_�~�|������
		proxy:SetLockActPntInvalidateMask( 801 , 225 ,true );
	elseif LEFTBRAKE_COUNT == 3 then
		proxy:EraseEventSpecialEffect_2(801,5068);
		proxy:SetEventSpecialEffect_2(801,5069);
		--���b�N�_�~�|������
		proxy:SetLockActPntInvalidateMask( 801 , 225 ,true );	
	end	
	if LEFTBRAKE_COUNT < 3 then 
		LEFTBRAKE_COUNT = LEFTBRAKE_COUNT + 1;
	else
		LEFTBRAKE_COUNT = 3;
	end	
	print("OnEvent_4264 end");
end

--------------------------------------------------------------------------------------
--�E���̔j��C�x���g�z�M�p
--------------------------------------------------------------------------------------
function OnEvent_4265(proxy,param)
	print("OnEvent_4265 begin");	
	--�j��񐔂ɂ����SFX�\����ς���
	if RIGHTBRAKE_COUNT == 0 then		
		proxy:SetEventSpecialEffect_2(801,5070);
		--�Ƃ肠�����R�R��Max�ݒ�&��
		proxy:SetEventBodyMaxHp(4262,FOOTHP_02);
		proxy:CheckEventBody(4262);
		proxy:SetEventFlag( 4262 , false );
	elseif RIGHTBRAKE_COUNT == 1 then
		proxy:EraseEventSpecialEffect_2(801,5070);
		proxy:SetEventSpecialEffect_2(801,5071);
		--DISPMASK_NOW = DISPMASK_NOW - DISPMASK_RIGHT1;
		--print("DISPMASK_NOW ",DISPMASK_NOW);
		--proxy:SetDispMask(801, DISPMASK_NOW);--�h���\��
		--proxy:CreateSfx_DummyPoly( 801 , 226 , 14990 );
		--�Ƃ肠�����R�R��Max�ݒ�&��
		proxy:SetEventBodyMaxHp(4262,FOOTHP_03);
		proxy:CheckEventBody(4262);
		proxy:SetEventFlag( 4262 , false );
	elseif RIGHTBRAKE_COUNT == 2 then
		proxy:EraseEventSpecialEffect_2(801,5071);
		proxy:SetEventSpecialEffect_2(801,5072);
		DISPMASK_NOW = DISPMASK_NOW - DISPMASK_RIGHT1 - DISPMASK_RIGHT2;
		print("DISPMASK_NOW ",DISPMASK_NOW);
		proxy:SetDispMask(801, DISPMASK_NOW);--�h���\��		
		proxy:CreateSfx_DummyPoly( 801 , 226 , 14990 );
		--���b�N�_�~�|������
		proxy:SetLockActPntInvalidateMask( 801 , 226 ,true );
	elseif RIGHTBRAKE_COUNT == 3 then
		proxy:EraseEventSpecialEffect_2(801,5071);
		proxy:SetEventSpecialEffect_2(801,5072);
		--���b�N�_�~�|������
		proxy:SetLockActPntInvalidateMask( 801 , 226 ,true );
	end
	if RIGHTBRAKE_COUNT < 3 then
		RIGHTBRAKE_COUNT = RIGHTBRAKE_COUNT + 1;
	else
		RIGHTBRAKE_COUNT = 3;
	end
	print("OnEvent_4265 end");
end



--------------------------------------------------------------------------------------
--4270�����̏�EzState�ւ̖��ߗp
--------------------------------------------------------------------------------------
function OnEvent_4270_1(proxy,param)
	--print("OnEvent_4270_1 begin");
	--�_�E�����߂𑗐M��������
	proxy:LuaCallStart(4267,1);
	--print("OnEvent_4270_1 end");
end

function OnEvent_4270_2(proxy,param)
	--print("OnEvent_4270_2 begin");
	--�N���オ�薽�߂𑗐M��������
	proxy:LuaCallStart(4267,2);
	--print("OnEvent_4270_2 end");
end


--------------------------------------------------------------------------------------
--4266�����̏�EzState�ւ̖��ߍ폜(�b���Ď�
--------------------------------------------------------------------------------------
function OnEvent_4266(proxy,param)
	print("OnEvent_4266 begin");
	proxy:DeleteEvent(4270);
	print("OnEvent_4266 end");
end

--------------------------------------------------------------------------------------
--4266�����̏�EzState�ւ̖��ߍ폜(�b���Ď�
--------------------------------------------------------------------------------------
function OnEvent_4266_1(proxy,param)
	print("OnEvent_4266_1 begin");
	proxy:DeleteEvent(4270);	
	--�Ƃ肠�����R�R��Max�ݒ�&��
	proxy:SetEventBodyMaxHp(4261,FOOTHP_04);
	proxy:CheckEventBody(4261);
	--�Ƃ肠�����R�R��Max�ݒ�&��
	proxy:SetEventBodyMaxHp(4262,FOOTHP_04);
	proxy:CheckEventBody(4262);
	
	proxy:EraseEventSpecialEffect_2(801,5069);
	proxy:SetEventSpecialEffect_2(801,5068);
	proxy:EraseEventSpecialEffect_2(801,5072);
	proxy:SetEventSpecialEffect_2(801,5071);		
		
	--���b�N�_�~�|������
	proxy:SetLockActPntInvalidateMask( 801 , 225 ,false );		
	proxy:SetLockActPntInvalidateMask( 801 , 226 ,false );

	--�_�E���C�x���g�\
	proxy:SetEventFlag(4261,false);
	proxy:SetEventFlag(4262,false);
	print("OnEvent_4266_1 end");
end

--------------------------------------------------------------------------------------
--4267�����̏�EzState�ւ̖��ߔz�M�p
--------------------------------------------------------------------------------------
function OnEvent_4267_1(proxy,param)
	--�_�E�����ߑ��M
	proxy:SetEventCommand(801, 850);	
end

function OnEvent_4267_2(proxy,param)
	--�N���オ�薽�ߑ��M
	proxy:SetEventCommand(801, 851);
end

--------------------------------------------------------------------------------------
--4268��EzState����"�_�E���n�߂�"���󂯎����
--------------------------------------------------------------------------------------
function OnEvent_4268(proxy,param)
	print("OnEvent_4268 begin");
	print("���̏��_�E�����n�߂�");
	proxy:LuaCallStart(4266,0);
	
	proxy:NotNetMessage_begin();
		--n�b��ɋN���オ��C�x���g
		proxy:OnKeyTime2(4268,"OnEvent_4268_1",STAND_UP_TIME,0,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_4743 end");
end

function OnEvent_4268_1(proxy,param)
	print("OnEvent_4268_1 begin");
	--�N���n�߂�܂Ŗ��߂𑗂�
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(4270,"OnEvent_4270_2",5,1,20,once);
	proxy:NotNetMessage_end();
	print("OnEvent_4268_1 end");
end

--------------------------------------------------------------------------------------
--4269��EzState����"�N���オ��n�߂�"���󂯎����
--------------------------------------------------------------------------------------
function OnEvent_4269(proxy,param)
	print("OnEvent_4269 begin");
	print("���̏��N���オ��n�߂�");
	proxy:LuaCallStart(4266,1);	
	print("OnEvent_4269 end");
end
