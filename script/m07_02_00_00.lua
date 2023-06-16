
--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■
--------------------------------------------------------------------------------------
function Initialize_m07_02_00_00(proxy)
	print("Initialize_m07_02_00_00 begin");
	
	
--[[マップスタジオのデータが入るまでコメントアウト
	
--■6912■エリアボス死亡■
	if proxy:IsCompleteEvent( 6912 ) ==false then
		proxy:OnCharacterDead(6912, 826, "OnEvent_6912", once);
	else
		proxy:SetEventFlag( 7301 , 1 ); --石柱のアクションIDをON
	end


--■1024■石柱にワープ■
	proxy:OnPlayerActionInRegionAngle(1024, 1410, "OnEvent_1024", 180, HELPID_GO_TO_SEKITYUU, everytime);
--オブジェに切り替わったらこっちを使う。
--	proxy:OnDistanceAction( 1024, 10000, 1410, "OnEvent_1024", WarpGimmickDist_A, HELPID_GO_TO_SEKITYUU, 180, WarpGimmickAngle_A, everytime );

]]


--■??■徘徊デーモンの登場■ハンドラ登録
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。
		proxy:LuaCall( 4000, 100, "PlayerDeath_m07_02_00_00", everytime );
		--プレイヤーが復活した時にキックされます。
		proxy:LuaCall( 4032, 100, "PlayerRevive_m07_02_00_00", everytime );
	proxy:NotNetMessage_end();	

	
	--■999999■フレーム遅れの初期化処理イベントを発行■
	proxy:NotNetMessage_begin();
		--▼0秒後▼--
		proxy:OnKeyTime2( 999992, "Second_Initialize_m07_02_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	
	print("Initialize_m07_02_00_00 end");
end




--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999
--------------------------------------------------------------------------------------
function Second_Initialize_m07_02_00_00(proxy, param)
	print("Second_Initialize_m07_02_00_00 begin");
	
--[[
	--■徘徊デーモン用 (フラグは仮、指定があれば変える)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m07_02_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m07_02_00_00);
	end
]]	

	print("Second_Initialize_m07_02_00_00 end");
end




--------------------------------------------------------------------------------------
--マルチになった時にホストじゃ無かったら■無し
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end



--------------------------------------------------------------------------------------
--■6912■エリアボス死亡■
--------------------------------------------------------------------------------------
--■6912■エリアボス死亡■
function OnEvent_6912(proxy, param)
	print("OnEvent_6912 begin");

	proxy:SetEventFlag( 6912, 1 );
	
	proxy:SetEventFlag( 7301, 1 );--石柱のアクションフラグON
	
	print("OnEvent_6912 end");
end


--------------------------------------------------------------------------------------
--■1024■石柱にワープ■
--------------------------------------------------------------------------------------
--■1024■石柱にワープ■
function OnEvent_1024(proxy,param)	
	print("OnEvent_1024 begin");
	
	proxy:WarpNextStage( 1, 0, 0, 0, -1 );
	
	print("OnEvent_1024 end");
end


--------------------------------------------------------------------------------------
--徘徊デーモンの登場■??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ)
function PlayerDeath_m07_02_00_00(proxy, param)
	print("PlayerDeath_m07_02_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m07_02_00_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。
	
	print("PlayerDeath_m07_02_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ)
function PlayerRevive_m07_02_00_00(proxy,param)
	print("PlayerRevive_m07_02_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m07_02_00_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。
	
	print("PlayerRevive_m07_02_00_00");
end






