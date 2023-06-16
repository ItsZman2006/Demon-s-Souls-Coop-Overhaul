
FIREMAN_1STAGE_HP = 0.90;
FIREMAN_2STAGE_HP = 0.30;

--------------------------------------------------------------------------------------
--イベント初期化■ボス固有のイベントを登録する際に使用してください
--------------------------------------------------------------------------------------
function EventBoss_Initialize_m06_01_00_00(proxy)
	print("EventBoss_Initialize_m06_01_00_00 begin");
	
	--ボスを倒しているなら必要ないはず。
	if proxy:IsCompleteEvent(6272) == false then
		if proxy:IsClient() == false then
			proxy:RequestForceUpdateNetwork( 811 );
			print("IsHost");
		else
			print("IsClient");
		end
		
		--特殊効果が終わっている場合は監視を入れない
		SingleReset(proxy,6274);
		if proxy:IsCompleteEvent(6274) == false then
			proxy:OnCharacterHP(6274,811,"OnEvent_6274",FIREMAN_1STAGE_HP,once);
		end
		SingleReset(proxy,6275);
		--特殊効果が終わっている場合は監視を入れない
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
--ボス用の初期化処理が必要なときに使用：固有情報の作成等
--------------------------------------------------------------------------------------
function BossInit_FireMan(proxy,param)	
end


--------------------------------------------------------------------------------------
--炎怪人のHPがFIREMAN_1STAGE_HPを下回った
--------------------------------------------------------------------------------------
function OnEvent_6274(proxy,param)
	print("OnEvent_6274 begin");
	--2個目設定
	proxy:SetEventSpecialEffect(811,5001);
	--AIにリアクション要求
	proxy:SendEventRequest( 811, 0 , AI_EVENT_REACTION );
	proxy:SetEventFlag(6274,true);
	print("OnEvent_6274 end");
end


--------------------------------------------------------------------------------------
--炎怪人のHPがFIREMAN_2STAGE_HPを下回った
--------------------------------------------------------------------------------------
function OnEvent_6275(proxy,param)
	print("OnEvent_6275 begin");
	--3個目設定
	proxy:SetEventSpecialEffect(811,5002);
	--AIにリアクション要求
	proxy:SendEventRequest( 811, 0 , AI_EVENT_REACTION );
	proxy:SetEventFlag(6275,true);
	print("OnEvent_6275 end");
end

--------------------------------------------------------------------------------------
--炎怪人がリアクションできた時のイベント
--------------------------------------------------------------------------------------
function OnEvent_6276( proxy,param )
	--AI命令初期化
	proxy:SendEventRequest( 811, 0 , AI_EVENT_None );
end


--------------------------------------------------------------------------------------
--炎怪人の後始末
--------------------------------------------------------------------------------------
function FireMan_Dead(proxy,param)
	print("FireMan_Dead begin");
	proxy:EraseEventSpecialEffect( 811 , 5000 );
	proxy:EraseEventSpecialEffect( 811 , 5001 );
	proxy:EraseEventSpecialEffect( 811 , 5002 );
	--AI命令初期化
	proxy:SendEventRequest( 811, 0 , AI_EVENT_None );
	print("FireMan_Dead end");
end
