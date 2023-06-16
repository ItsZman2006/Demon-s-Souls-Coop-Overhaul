
FIREMAN_1STAGE_HP = 0.90;
FIREMAN_2STAGE_HP = 0.30;

--------------------------------------------------------------------------------------
--�C�x���g���������{�X�ŗL�̃C�x���g��o�^����ۂɎg�p���Ă�������
--------------------------------------------------------------------------------------
function EventBoss_Initialize_m06_01_00_00(proxy)
	print("EventBoss_Initialize_m06_01_00_00 begin");
	
	--�{�X��|���Ă���Ȃ�K�v�Ȃ��͂��B
	if proxy:IsCompleteEvent(6272) == false then
		if proxy:IsClient() == false then
			proxy:RequestForceUpdateNetwork( 811 );
			print("IsHost");
		else
			print("IsClient");
		end
		
		--������ʂ��I����Ă���ꍇ�͊Ď������Ȃ�
		SingleReset(proxy,6274);
		if proxy:IsCompleteEvent(6274) == false then
			proxy:OnCharacterHP(6274,811,"OnEvent_6274",FIREMAN_1STAGE_HP,once);
		end
		SingleReset(proxy,6275);
		--������ʂ��I����Ă���ꍇ�͊Ď������Ȃ�
		if proxy:IsCompleteEvent(6275) == false then
			proxy:OnCharacterHP(6275,811,"OnEvent_6275",FIREMAN_2STAGE_HP,once);
		end
		SingleReset(proxy,6276);
		if proxy:IsCompleteEvent( 6276 ) == false then
			proxy:OnCheckEzStateMessage( 6276 , 811 , "OnEvent_6276", 201);
		end
	end
	
	print("EventBoss_Initialize_m06_01_00_00 end");
end

--------------------------------------------------------------------------------------
--�{�X�p�̏������������K�v�ȂƂ��Ɏg�p�F�ŗL���̍쐬��
--------------------------------------------------------------------------------------
function BossInit_FireMan(proxy,param)	
end


--------------------------------------------------------------------------------------
--�����l��HP��FIREMAN_1STAGE_HP���������
--------------------------------------------------------------------------------------
function OnEvent_6274(proxy,param)
	print("OnEvent_6274 begin");
	--2�ڐݒ�
	proxy:SetEventSpecialEffect(811,5001);
	--AI�Ƀ��A�N�V�����v��
	proxy:SendEventRequest( 811, 0 , AI_EVENT_REACTION );
	proxy:SetEventFlag(6274,true);
	print("OnEvent_6274 end");
end


--------------------------------------------------------------------------------------
--�����l��HP��FIREMAN_2STAGE_HP���������
--------------------------------------------------------------------------------------
function OnEvent_6275(proxy,param)
	print("OnEvent_6275 begin");
	--3�ڐݒ�
	proxy:SetEventSpecialEffect(811,5002);
	--AI�Ƀ��A�N�V�����v��
	proxy:SendEventRequest( 811, 0 , AI_EVENT_REACTION );
	proxy:SetEventFlag(6275,true);
	print("OnEvent_6275 end");
end

--------------------------------------------------------------------------------------
--�����l�����A�N�V�����ł������̃C�x���g
--------------------------------------------------------------------------------------
function OnEvent_6276( proxy,param )
	--AI���ߏ�����
	proxy:SendEventRequest( 811, 0 , AI_EVENT_None );
end


--------------------------------------------------------------------------------------
--�����l�̌�n��
--------------------------------------------------------------------------------------
function FireMan_Dead(proxy,param)
	print("FireMan_Dead begin");
	proxy:EraseEventSpecialEffect( 811 , 5000 );
	proxy:EraseEventSpecialEffect( 811 , 5001 );
	proxy:EraseEventSpecialEffect( 811 , 5002 );
	--AI���ߏ�����
	proxy:SendEventRequest( 811, 0 , AI_EVENT_None );
	print("FireMan_Dead end");
end
