
--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■
--------------------------------------------------------------------------------------
function Initialize_m99_60_00_00(proxy)
	print("Initialize m99_60_00_00 begin");

--垂直ハシゴ

--■6000■ハシゴA降り■PCがイベントエリア(2002)の中に居て、アクションボタンを押したとき--
	proxy:OnActionEventRegion(6000, 2002, "OnEvent_6000", LadderAngle_A, HELPID_DOWN, everytime);
--■6001■ハシゴA昇り■PCがイベントエリア(2001)の中に居て、アクションボタンを押したとき--
	proxy:OnActionEventRegion(6001, 2001, "OnEvent_6001", LadderAngle_A, HELPID_UP, everytime);
	
	

--斜め10度ハシゴ

--■6002■ハシゴB降り■PCがイベントエリア(2011)の中に居て、アクションボタンを押したとき--
	proxy:OnActionEventRegion(6002, 2011, "OnEvent_6002", LadderAngle_A, HELPID_DOWN, everytime);
--■6003■ハシゴB昇り■PCがイベントエリア(2010)の中に居て、アクションボタンを押したとき--
	proxy:OnActionEventRegion(6003, 2010, "OnEvent_6003", LadderAngle_A, HELPID_UP, everytime);


	proxy:OnPlayerActionInRegion(128,30,"OnEvent_128",HELPID_GO_TO_IN,once);

--■500■城門開放レバー■
	if proxy:IsCompleteEvent( 500 ) ==false then
	--▼PCがイベントエリア(500)の中に距離(1.5m)有効角(30度幅)でアクションボタンを押した
		proxy:OnDistanceAction( 500, 10000, 500, "OnEvent_500", LeverDist_A, HELPID_PULL_LEVER, 0, LeverAngle_A, once);
	else
	   proxy:EndAnimation( 500, 1 );--レバーが動くアニメ
	   proxy:EndAnimation( 501, 1 );--扉が開くアニメ
	end
	
	proxy:OnFireDamage( 500 , 500 , -1 ,"OnEvent_500_fire",everytime);
	
--■502■ハンドルを回して歯車を動かす■
	if proxy:IsCompleteEvent( 502 ) ==false then
	--▼PCがハンドル(506)に対して反応角度(45)、角度オフセット(-90)、距離(150)でアクションボタンを押す▼--
		proxy:OnDistanceAction( 502, 10000, 506, "OnEvent_502", HandleDist_A, HELPID_TURN_HANDLE, -90.0, HandleAngle_A, once );
	else
		proxy:EndAnimation( 506, 1 );--ハンドルアニメ
	end
	

--■508■宝死体■
	--▼PCが宝(507)に対して反応角度(90)、角度オフセット(0)、距離(180)でアクションボタンを押す▼--
	if proxy:IsCompleteEvent( 508 ) ==false then
		proxy:OnDistanceAction( 508, 10000, 507, "OnEvent_508", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:TreasureDispModeChange( 507, true );--宝を光らせる
	end
	

--■510～513■開閉扉■

	proxy:RepeatMessage_begin();
	
	--扉が閉まっていたら、両側から開けられる
	if proxy:IsCompleteEvent( 510 ) == false and proxy:IsCompleteEvent( 512 ) == false then
		
		proxy:OnDistanceActionPlus( 510, 10000, 502, "OnEvent_510", DoorDist_A, HELPID_OPEN , -90,DoorAngle_A,  0.0,-1.5, 0.7, once);
		proxy:OnDistanceActionPlus( 512, 10000, 502, "OnEvent_512", DoorDist_A, HELPID_OPEN ,  90,DoorAngle_A,  0.0,-1.5, 0.7, once);
	
	--扉が手前から開かれていたら奥側から閉められる
	elseif proxy:IsCompleteEvent( 510 ) == true then
		proxy:OnDistanceActionPlus( 513, 10000, 502, "OnEvent_513", DoorDist_A, HELPID_CLOSE,  180,DoorAngle_A, -1.0,-1.5, 0.0, once);
	
	--扉が奥側から開かれていたら手前から閉められる
	elseif proxy:IsCompleteEvent( 512 ) == true then
		proxy:OnDistanceActionPlus( 511, 10000, 502, "OnEvent_511", DoorDist_A, HELPID_CLOSE, -90,DoorAngle_A,  1.0,-1.5, 0.0, once);
	end
	
	proxy:RepeatMessage_end();
	

--■514■監獄扉(大)■

	if proxy:IsCompleteEvent( 514 ) == false then
		proxy:OnDistanceActionPlus( 514, 10000, 504, "OnEvent_514", DoorDist_A, HELPID_OPEN  , 0 , DoorAngle_A, 0.0, -0.5, -0.2, once);
	else
		proxy:EndAnimation( 504 , 1 );
	end


--■514～517■監獄扉(小)■

	if proxy:IsCompleteEvent( 518 ) == false then
		proxy:OnDistanceActionPlus( 518, 10000, 505, "OnEvent_518", DoorDist_A, HELPID_OPEN  , 180 , DoorAngle_A,  0.4, -1.8, 0.2, once);
	else
		proxy:EndAnimation( 505 , 1 );
	end
		
	
--■2000■ショップテスト■
	proxy:OnPlayerActionInRegion( 2000, 60, "OnEvent_2000", HELPID_TALK, everytime );
	
--■2020■ポイント魔法テスト■
	proxy:OnRegionJustIn(2020,10000,2020,"OnEvent_2020",everytime);
	
--■2021■ポイント魔法テスト■
	--proxy:OnRegionJustIn(2030,2021,2020,"OnEvent_2030",everytime);
	
	
	
--■??■徘徊デーモンの登場■ハンドラ登録
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。
		proxy:LuaCall( 4000, 100, "PlayerDeath_m99_60_00_00", everytime );
		--プレイヤーが復活した時にキックされます。
		proxy:LuaCall( 4032, 100, "PlayerRevive_m99_60_00_00", everytime );		
	proxy:NotNetMessage_end();
	
	proxy:RepeatMessage_begin();
		--proxy:OnCharacterHpRate(2041,2021,"OnEvent_2041",0.1,once);	
	proxy:RepeatMessage_end();
	
--■996000■フレーム遅れの初期化処理イベントを発行■
	proxy:NotNetMessage_begin();
		--▼0秒後▼--
		proxy:OnKeyTime2( 996000, "Second_Initialize_m99_60_00_00", 0.1, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	
	proxy:OnDistanceAction(600,10000,600,"OnEvent_600",1,HELPID_PULL_LEVER,0,180,everytime);
	
	proxy:OnRegistFunc(3000,"Check_3000","OnEvent_3000",1,once);
	
	--■33■領域監視■
	proxy:OnNetRegionPlus(50,33,"OnEvent_33");
	--■34■領域監視：ホワイトのみ■
	proxy:OnNetRegionAttr(51,34,ATTR_WHITE);
	--■35■領域監視：ブラックのみ■
	proxy:OnNetRegionAttr(52,35,ATTR_BLACK);
	--■36■領域監視：グレイのみ■
	proxy:OnNetRegionAttr(53,36,ATTR_GREY);	
	--■37■領域監視：生存のみ■
	proxy:OnNetRegionAttr(54,37,ATTR_LIVE);
	--■37■領域監視:ホストのみ(生存orグレイ)■
	proxy:OnNetRegionAttr(55,38,ATTR_LIVE+ATTR_GREY);	
	
	proxy:OnPlayerActionInRegion(56,39,"OnEvent_56",HELPID_PULL_LEVER,once);
	
	--アイテムドロップイベント
	proxy:OnRegionIn(57,10000,40,"OnEvent_57",everytime);	
	--拾った時のイベント
	proxy:LuaCall(12000,0,"OnEvent_12000",everytime);
	
	
	--proxy:OnWanderFade(2000,10000,2.0,2.0,10.0,10.0,everytime);
	proxy:LuaCall( 100 , 0 , "OnEvent_100",once);
	--クリアテスト
	--proxy:OnCharacterDead(60,2021,"OnEvent_60",once);
	print("Initialize m99_60_00_00 end");
end

--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999
--------------------------------------------------------------------------------------
--■996000■初期化■
function Second_Initialize_m99_60_00_00(proxy, param)
	print("Second_Initialize_m99_60_00_00 begin");
	
--[[
	--■徘徊デーモン用 (フラグは仮、指定があれば変える)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m99_60_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_60_00_00);
	end
]]
	
	--proxy:SetDeadMode(2021,true);
	--proxy:EnableInvincible(2021,true);
	--proxy:DisableDamage(2021,true);
	--[[
	proxy:SendEventRequest(2021,0,10);
	proxy:SendEventRequest(2021,1,11);
	proxy:SendEventRequest(2021,2,12);
	proxy:SendEventRequest(2021,3,13);
	
	if proxy:CreateEventBody( 2040, 2021,"OnEvent_2040",20,0.5,everytime) == true then		
		proxy:AddEventParts(2040,2021,"Ragdoll_R Toe01");
		proxy:AddEventParts(2040,2021,"Ragdoll_R Foot01");		
		proxy:AddEventParts(2040,2021,"Ragdoll_L Toe01");
		proxy:AddEventParts(2040,2021,"Ragdoll_L Foot01");
		
		proxy:AddEventParts(2040,2021,"Ragdoll_Pelvis01");
		proxy:AddEventParts(2040,2021,"Ragdoll_L Thigh01");
		proxy:AddEventParts(2040,2021,"Ragdoll_R Thigh01");
		proxy:AddEventParts(2040,2021,"Ragdoll_Spine01");
		proxy:AddEventParts(2040,2021,"Ragdoll_R Calf01");
		proxy:AddEventParts(2040,2021,"Ragdoll_L Calf01");
		proxy:AddEventParts(2040,2021,"Ragdoll_L UpperArm01");
		proxy:AddEventParts(2040,2021,"Ragdoll_R UpperArm01");
		proxy:AddEventParts(2040,2021,"Ragdoll_L Forearm01");
		proxy:AddEventParts(2040,2021,"Ragdoll_R Forearm01");
	end
	]]
	print("Second_Initialize_m99_60_00_00 end");
end

function OnEvent_2040(proxy,param)
	print("OnEvent_2040 begin");
	proxy:CheckEventBody(2040);
	print("OnEvent_2040 end");	
end


--------------------------------------------------------------------------------------
--ハシゴA降り■6000
--------------------------------------------------------------------------------------
--■6000■ハシゴA降りスタート■
function OnEvent_6000(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_6000 begin");

	--ホバー移動モードに移行--
	proxy:BeginAction(10000,2,2,2);

	--移動位置(2004)に0.5秒でホバー移動--
	proxy:HoverMoveValDmy(10000,1100,192,LadderTime_A);--移動位置(192)に0.5秒でホバー移動
	--proxy:ChangeInitPosAng(2021,2004);

	--イベントコマンドID(1)"ハシゴ上から掴"むを送る--
	proxy:SetEventCommand(10000,1);
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );

	--配信しないイベントを登録--
	proxy:NotNetMessage_begin();
	
		--0.5秒後に発動するイベントを登録--
		proxy:OnKeyTime2(6000,"OnEvent_6000_1",0.5,0,0,once);
		--3秒間発動するイベントを登録--
		proxy:OnKeyTime2(6000,"LadderUp",3,1,0,once);
	
	proxy:NotNetMessage_end();

	--キャラクタを移動、旋回不能に--
	proxy:DisableMove(10000,1);
	print("OnEvent_6000 end");
end

--■6000_1■ハシゴA降りスタート:ホバー移動終了■
function OnEvent_6000_1(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	if proxy:GetEventMode(10000) == 0 then
		return;
	end
	print("OnEvent_6000_1 begin");

	--ハシゴアクションモードに移行--
	proxy:BeginAction(10000,1,7,6);

	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(10000,0);
	print("OnEvent_6000_1 end");
end


--------------------------------------------------------------------------------------
--ハシゴA昇り■6001
--------------------------------------------------------------------------------------
--■6001■ハシゴA昇りスタート■
function OnEvent_6001(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_6001 begin");
	--ホバー移動モードに移行--
	proxy:BeginAction(10000,2,-1,1);

	--移動位置(2003)に0.5秒でホバー移動--
	proxy:HoverMoveValDmy(10000,1100,191,LadderTime_A);--移動位置(191)に0.5秒でホバー移動

	--イベントコマンドID(0)"ハシゴ下から掴"むを送る--
	proxy:SetEventCommand(10000,0);
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );

	--配信しないイベント追加--
	proxy:NotNetMessage_begin();
	
		--0.5秒後に発動するイベントを登録--
		proxy:OnKeyTime2(6001,"OnEvent_6001_1",0.5,0,0,once);
		--1秒間発動するイベントを登録--
		proxy:OnKeyTime2(6001,"EventMenuBrake",1,1,0,once);

	proxy:NotNetMessage_end();

	--キャラクタを移動、旋回不能に--
	proxy:DisableMove(10000,1);
	print("OnEvent_6001 end");
end

--■6001_1■ハシゴA昇りスタート:ホバー移動終了■
function OnEvent_6001_1(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	if proxy:GetEventMode(10000) == 0 then
		return;
	end
	print("OnEvent_6001_1 begin");
	--ハシゴアクションモードに移行--
	proxy:BeginAction(10000,1,-1,6);
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_6001_1 end");
end

--------------------------------------------------------------------------------------
--ハシゴB降り■6002
--------------------------------------------------------------------------------------
--■6002■ハシゴB降りスタート■
function OnEvent_6002(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_6002 begin");

	--ホバー移動モードに移行--
	proxy:BeginAction(10000,2,2,2);

	--移動位置(2013)に0.5秒でホバー移動--
	proxy:HoverMoveValDmy(10000,1110,192,LadderTime_A);--移動位置(192)に0.5秒でホバー移動

	--イベントコマンドID(1)"ハシゴ上から掴"むを送る--
	proxy:SetEventCommand(10000,1);
	proxy:SetKeepCommandIndex(10000, 4, 1, 3.0 );

	--配信しないイベントを登録--
	proxy:NotNetMessage_begin();
	
		--0.5秒後に発動するイベントを登録--
		proxy:OnKeyTime2(6002,"OnEvent_6002_1",0.5,0,0,once);
		--3秒間発動するイベントを登録--
		proxy:OnKeyTime2(6002,"LadderDown",3,1,0,once);
	
	proxy:NotNetMessage_end();

	--キャラクタを移動、旋回不能に--
	proxy:DisableMove(10000,1);
	print("OnEvent_6000 end");
end

--■6002_1■ハシゴB降りスタート:ホバー移動終了■
function OnEvent_6002_1(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	if proxy:GetEventMode(10000) == 0 then
		return;
	end
	print("OnEvent_6002_1 begin");

	--ハシゴアクションモードに移行--
	proxy:BeginAction(10000,1,6,5);

	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(10000,0);
	print("OnEvent_6002_1 end");
end


--------------------------------------------------------------------------------------
--ハシゴB昇り■6003
--------------------------------------------------------------------------------------
--■6003■ハシゴB昇りスタート■
function OnEvent_6003(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_6003 begin");
	--ホバー移動モードに移行--
	proxy:BeginAction(10000,2,-1,1);

	--移動位置(2012)に0.5秒でホバー移動--
	proxy:HoverMoveValDmy(10000,1110,191,LadderTime_A);--移動位置(191)に0.5秒でホバー移動

	--イベントコマンドID(0)"ハシゴ下から掴"むを送る--
	proxy:SetEventCommand(10000,0);
	proxy:SetKeepCommandIndex(10000, 4, 1, 3.0 );

	--配信しないイベント追加--
	proxy:NotNetMessage_begin();
	
		--0.5秒後に発動するイベントを登録--
		proxy:OnKeyTime2(6003,"OnEvent_6003_1",0.5,0,0,once);
		--1秒間発動するイベントを登録--
		proxy:OnKeyTime2(6003,"EventMenuBrake",1,1,0,once);

	proxy:NotNetMessage_end();

	--キャラクタを移動、旋回不能に--
	proxy:DisableMove(10000,1);
	print("OnEvent_6001 end");
end

--■6003_1■ハシゴB昇りスタート:ホバー移動終了■
function OnEvent_6003_1(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	if proxy:GetEventMode(10000) == 0 then
		return;
	end
	print("OnEvent_6003_1 begin");
	--ハシゴアクションモードに移行--
	proxy:BeginAction(10000,1,-1,5);
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_6003_1 end");
end





--------------------------------------------------------------------------------------
--城門開放レバー■500
--------------------------------------------------------------------------------------
--■500■城門開放レバー■
function OnEvent_500(proxy, param)
	print("OnEvent_500 begin");
	
	proxy:PlayAnimation(500, 1);--城門開放レバーアニメ再生
	
	proxy:NotNetMessage_begin();
		--▼500_2▼***条件追加***レバーアニメ終了▼
		proxy:OnCharacterAnimEnd( 500, 500, 1, "OnEvent_500_2", once);
	proxy:NotNetMessage_end();
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PULL_LEVER ) == true then
		--パーティープレイヤーがアニメーションした場合はここで処理終了
		print("OnEvent_500 end");
		return;
	end
		
	proxy:Warp(10000, 2000);		--プレイヤーを所定位置にワープ

	print("OnEvent_500 end");
end

--▲500_2▲レバーアニメ終了▲
function OnEvent_500_2(proxy, param)
	print("OnEvent_500_2 begin");
	
	proxy:NotNetMessage_begin();
		--▼500_3▼***条件追加***1秒後▼
		proxy:OnKeyTime2( 500, "OnEvent_500_3", 1.0, 0, 1, once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_500_2 end");
end

--▲500_3▲レバーアニメ終了から1秒後▲
function OnEvent_500_3(proxy, param)
	print("OnEvent_500_3 begin");
	
	proxy:SetEventFlag( 500, 1 );
	proxy:PlayAnimation( 501, 1 );--正門開放アニメを再生
	
	print("OnEvent_500_3 end");
end







--------------------------------------------------------------------------------------
--ハンドルを回して歯車を動かす■502
--------------------------------------------------------------------------------------
--■502■ハンドルAを回して歯車を動かす■
function OnEvent_502(proxy, param)
	print("OnEvent_502 begin")
	
	proxy:PlayAnimation( 506, 1 );--ハンドルアニメ再生
	
	proxy:NotNetMessage_begin();
		--▼502_2▼***条件追加***ハンドルアニメ終了▼
		proxy:OnCharacterAnimEnd( 502, 506, 1, "OnEvent_502_2", once );
	proxy:NotNetMessage_end();
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_TURN_HANDLE ) == true then 
		return;
	end

--	proxy:Warp( 10000 , 2006 );		--プレイヤーを所定位置にワープ
	proxy:WarpDmy( 10000 , 506 , 192 );
	
	print("OnEvent_10 end")
end


--▲502_2▲ハンドルアニメ終了▲
function OnEvent_502_2(proxy, param)
	print("OnEvent_502_2 begin")
	
	proxy:NotNetMessage_begin();
		--▼502_3▼***条件追加***0.5秒後▼
		proxy:OnKeyTime2( 502, "OnEvent_502_3", 0.5, 0, 2, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_502_2 end")
end

--▲502_3▲0.5秒後▲
function OnEvent_502_3(proxy, param)
	print("OnEvent_502_3 begin")

	proxy:SetEventFlag( 502, 1 );	--フラグを立てる
	
	print("OnEvent_502_3 end")
end



--------------------------------------------------------------------------------------
--宝死体A■508
--------------------------------------------------------------------------------------
--■508■宝箱A:調べる■
function OnEvent_508(proxy, param)
	print("OnEvent_508 begin");
	proxy:NotNetMessage_begin();
		--同期アニメーション用のイベント
		proxy:LuaCallStart( 4010 , 1 );
		--proxy:OnSelectMenu(508,"OnEvent_508_1",10010100,0,2,507,1.5,once);		
		proxy:NoAnimeTurnCharactor( 10000 , 507 );
--[[
	const dl_int32		nEventID,
	const dl_char*		func,
	const dl_int32		nMsgID,
	const dl_int32		nBtnType,
	const dl_int32		nBtnNum,	
	const dl_int32 		TargetID,
	const dl_float32 	Length,
	const dl_bool		bOnce
	]]
	proxy:NotNetMessage_end();	
	print("OnEvent_508 end");
end

--選択待ち
function OnEvent_508_1(proxy,param)
	print("OnEvent_508_1 begin");
	--同期アニメーション用のイベント
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行
		proxy:OnKeyTime2( 508, "OnEvent_508_2", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();	
	print("OnEvent_508_1 end");
end


--■508_1■宝箱A：アイテム表現■
function OnEvent_508_2(proxy, param)
	print("OnEvent_508_2 begin");

	--アイテム取得の表示処理
	proxy:GetRateItem(0);
	
	--アイテムを取得済み
	proxy:SetEventFlag( 508, 1 );
	--宝が光っているのを消す
	proxy:TreasureDispModeChange( 507, false );
	
	print("OnEvent_508_2 end");
end




--------------------------------------------------------------------------------------
--開閉扉：手前から開ける■510
--------------------------------------------------------------------------------------
function OnEvent_510(proxy, param) 
	EventNormalDoor(proxy, param, 510, 502, 2, ANIMEID_OPEN, 9 , false); 
	
	proxy:DeleteEvent( 512 );
	proxy:SetEventFlag( 513 , 0 );
	
	proxy:RepeatMessage_begin();
		proxy:OnDistanceActionPlus( 513, 10000, 502, "OnEvent_513", DoorDist_A, HELPID_CLOSE,90,DoorAngle_A, -1.0,-1.5, 0.0, once);
	proxy:RepeatMessage_end();
end

--------------------------------------------------------------------------------------
--開閉扉：手前から閉める■511
--------------------------------------------------------------------------------------
function OnEvent_511(proxy, param) 
	EventNormalDoor(proxy, param, 511, 502, 3, ANIMEID_CLOSE, 9 , false);
	
	proxy:SetEventFlag( 510 , 0 );
	proxy:SetEventFlag( 512 , 0 );
	
	proxy:RepeatMessage_begin();
		proxy:OnDistanceActionPlus( 510, 10000, 502, "OnEvent_510", DoorDist_A, HELPID_OPEN , -90,DoorAngle_A,  0.0,-1.5, 0.7, once);
		proxy:OnDistanceActionPlus( 512, 10000, 502, "OnEvent_512", DoorDist_A, HELPID_OPEN ,  90,DoorAngle_A,  0.0,-1.5, 0.7, once);
	proxy:RepeatMessage_end();
end

--------------------------------------------------------------------------------------
--開閉扉：奥から開ける  ■512
--------------------------------------------------------------------------------------
function OnEvent_512(proxy, param) 
	EventNormalDoor(proxy, param, 512, 502, 4, ANIMEID_OPEN, 9 , false); 
	
	proxy:DeleteEvent( 510 );
	proxy:SetEventFlag( 511 , 0 );
	
	proxy:RepeatMessage_begin();
		proxy:OnDistanceActionPlus( 511, 10000, 502, "OnEvent_511", DoorDist_A, HELPID_CLOSE, -90,DoorAngle_A,  1.0,-1.5, 0.0, once);
	proxy:RepeatMessage_end();
end

--------------------------------------------------------------------------------------
--開閉扉：奥から閉める  ■513
--------------------------------------------------------------------------------------
function OnEvent_513(proxy, param) 
	EventNormalDoor(proxy, param, 513, 502, 5, ANIMEID_CLOSE, 9 , false);
	
	proxy:SetEventFlag( 510 , 0 );
	proxy:SetEventFlag( 512 , 0 );
	
	proxy:RepeatMessage_begin();
		proxy:OnDistanceActionPlus( 510, 10000, 502, "OnEvent_510", DoorDist_A, HELPID_OPEN , -90,DoorAngle_A,  0.0,-1.5, 0.7, once);
		proxy:OnDistanceActionPlus( 512, 10000, 502, "OnEvent_512", DoorDist_A, HELPID_OPEN ,  90,DoorAngle_A,  0.0,-1.5, 0.7, once);
	proxy:RepeatMessage_end();
end




--------------------------------------------------------------------------------------
--□扉用の関数□  m04 のとはちょっとちがう。引数が一個多い。（player_anime_id)
--------------------------------------------------------------------------------------

--▽これを呼ぶ▽
function EventNormalDoor(proxy, param, event_id, door_id, door_anime_id, player_anime_id ,dmy_id ,flag)
	
	print("OnEvent_"..event_id.." begin");
	
	proxy:PlayAnimation( door_id , door_anime_id );--扉のアニメーション

	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, player_anime_id ) == true then
		proxy:SetEventFlag( event_id , 1 );--開閉扉A(手前から開ける)への操作を無効にする。
		return;
	end
	
	--ダミポリID（９）にワープ
	if flag == true then
		proxy:WarpDmy( 10000, door_id , dmy_id );
	end
	
	proxy:SetEventFlag( event_id , 1 );--開閉扉A(手前から開ける)への操作を無効にする。

	print("OnEvent_"..event_id.." end");
end

--------------------------------------------------------------------------------------
--■514■牢城扉(大)514■
--------------------------------------------------------------------------------------
function OnEvent_514(proxy, param) EventNormalDoor(proxy, param, 514, 504, 1, ANIMEID_OPEN, 191 , true); end

--------------------------------------------------------------------------------------
--■518■牢城扉(小)518■
--------------------------------------------------------------------------------------
function OnEvent_518(proxy, param) EventNormalDoor(proxy, param, 518, 505, 1, ANIMEID_OPEN, 191 , true); end




--------------------------------------------------------------------------------------
--ショップテスト：■2000
--------------------------------------------------------------------------------------
--■2000■ショップテスト■
function OnEvent_2000(proxy, param)
	print("▼▼▼OnEvent_2000 begin▼▼▼");
	proxy:SetTalkMsg( 0, true );
	print("▲▲▲OnEvent_2000 end▲▲▲");
end

--------------------------------------------------------------------------------------
--ポイント魔法テスト：■2020
--------------------------------------------------------------------------------------
function OnEvent_2020(proxy,param)
	print("OnEvent_2020 begin");
	--オーナーID2021、発動ポイントID2020、発動魔法ID1
	--発動角270,0,0
	--proxy:CastPointSpell(2021,2020,1,270,0,0);
	--SFX作成 
	--発生場所　ポイントID	：2020
	--発生SFX	SFXID		：701
	proxy:CreateSfx(2020,701);	
	print("OnEvent_2020 end");
end

--------------------------------------------------------------------------------------
--ポイント魔法テスト：■2030
--------------------------------------------------------------------------------------
function OnEvent_2030(proxy,param)
	print("OnEvent_2030 begin");	
	--SFX作成 
	--発生場所　ポイントID	：2020
	--発生SFX	SFXID		：701
	proxy:CreateSfx(2020,701);
	print("OnEvent_2030 end");
end


--------------------------------------------------------------------------------------
--徘徊デーモンの登場■??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ)
function PlayerDeath_m99_60_00_00(proxy, param)
	print("PlayerDeath_m99_60_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m99_60_00_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。
	
	print("PlayerDeath_m99_60_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ)
function PlayerRevive_m99_60_00_00(proxy,param)
	print("PlayerRevive_m99_60_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_60_00_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。
	
	print("PlayerRevive_m99_60_00_00");
end





function OnEvent_128(proxy,param)
	print("OnEvent_128 反応した");
	proxy:OnPlayerActionInRegion(129,31,"OnEvent_129",HELPID_GO_TO_IN,once);
end

function OnEvent_129(proxy,param)
	print("OnEvent_129 反応した");
	proxy:OnPlayerActionInRegion(130,32,"OnEvent_130",HELPID_GO_TO_IN,once);
end






function Check_3000(proxy,param)
	if proxy:IsEquip(TYPE_WEAPON,10000) == true then
		print("IsEquip　TYPE_WEAPON　 true");
		return true;
	end
	if proxy:IsEquip(TYPE_PROTECTER,101800) == true then
		print("IsEquip　TYPE_PROTECTER　 true");
		return true;
	end
	if proxy:IsInventoryEquip(TYPE_WEAPON,21500) == true then
		print("レンドル王の剣持ってるよー");
		return true;
	end
	--print("IsEquip false");
	return false;
end


function OnEvent_3000(proxy,param)
	print("OnEvent_3000");	
end

--HPの割合監視のハンドラ
function OnEvent_2041(proxy,param)
	print("監視が登録されてから最大の1割HPが減った");
end

function OnEvent_600(proxy,param)
	print("OnEvent_600 begin");
	print("OnEvent_600 end");
end


function OnEvent_33(proxy,param)
	print("OnEvent_33 begin");
	if param:IsNetMessage() == true then
		print("配信された");
	else
		print("配信した");
	end
	
	if proxy:IsCompleteEvent(50) == true then
		print("領域に入っている");
	else
		print("領域に誰もいない");
	end
	print("OnEvent_33 end");
end

function OnEvent_56(proxy,param)
	print("OnEvent_56 begin");
	print("OnEvent_56 end");
end

function OnEvent_57(proxy,param)
	if proxy:IsCompleteEvent(12001) == false then
		if proxy:IsRegionDrop(12000,10000,40) == true then
			print("Drop!!");
			proxy:SetEventFlag(12000,true);
		end
	else
		print("Event Complete!");
		proxy:SetEventFlag(12000,false);
		proxy:DeleteEvent(57);
	end
end

function OnEvent_12000(proxy,param)
	print("OnEvent_12000 begin");
	proxy:SetEventFlag(12000,false);
	print("OnEvent_12000 end");
end



--クリアイベントテスト
function OnEvent_60(proxy,param)
	print("OnEvent_60 begin");
	--新ブロッククリアを呼び出す
	proxy:LuaCallStart(4050,1);
	print("OnEvent_60 end");
end

function OnEvent_100(proxy,param)
	print("OnEvent_100 begin");	
	proxy:ForceDead( 10000 );
	proxy:OnKeyTime2( 100 , "OnEvent_100_1",0.125,0,0,once);
	print("OnEvent_100 end");
end

function OnEvent_100_1(proxy,param)
	print("OnEvent_100_1 begin");
	proxy:ForceDead( 100 );
	print("OnEvent_100_1 end");
end

function OnEvent_500_fire(proxy,param)
	print("OnEvent_500_fire begin");
	print("OnEvent_500_fire end");
end


