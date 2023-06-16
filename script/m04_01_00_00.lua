
--鎖の虜囚を斬って死亡するまでの間
REMO_WAIT = 3.0;

--[[------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■
--------------------------------------------------------------------------------------]]
function Initialize_m04_01_00_00(proxy)
	print("Initialize_m04_01_00_00 begin");
	
--■523■ボス部屋に入る■
	--中ボスが生きているときだけイベント登録
	if proxy:IsCompleteEvent( 5251 ) == false then
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。
		SingleReset(proxy, 523);
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き)
		proxy:LuaCall( 524, 1, "OnEvent_524_1", everytime );
		--▽2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCall( 524 , 5 , "OnEvent_523_GO_TO_IN" , everytime );
		--▽フラグセット(同期用)
		proxy:LuaCall( 524 , 6 , "OnEvent_523_flag_set" , everytime );
		--誰かがボス前扉をまだ通過していない
		if proxy:IsCompleteEvent( 523 ) == false then		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			proxy:NotNetMessage_begin();
				--▼523▼中に入るためのイベントを追加▼
				proxy:OnPlayerActionInRegionAttribute( 523, 2894, "OnEvent_523", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
		else --グレイゴーストできたときようにいると思われる。
			proxy:NotNetMessage_begin();
				--▼524▼中に入るためのイベントを追加▼--ハンドラは上と同じ
				proxy:OnPlayerActionInRegion( 524, 2894, "OnEvent_523", HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		end
	else
		InvalidCharactor( proxy, 807 );
		InvalidCharactor( proxy, 817 );
	end
	
--■525■ボス戦闘開始■
	if proxy:IsCompleteEvent( 5251 ) == false then
		proxy:OnRegionJustIn( 525 , 10000 , 2886 , "OnEvent_525" , once );
	end
	
--■5251■崩れる壁■ボスが死んだら--
	proxy:AddFieldInsFilter( 807 );
	proxy:AddFieldInsFilter( 817 );
	if	proxy:IsCompleteEvent( 5251 ) == false then
		SingleReset(proxy, 5250 );
		SingleReset(proxy, 5253 );
		if	proxy:IsCompleteEvent( 5250 ) == false or
			proxy:IsCompleteEvent( 5253 ) == false then
			proxy:OnCharacterDead(5250,807,"OnEvent_5251",once);
			--proxy:OnCharacterDead(5251,817,"OnEvent_5251",once);
			proxy:OnCharacterDead(5253,817,"OnEvent_5251",once);
		end
	else
		proxy:InvalidSfx( 1986, false );
		proxy:InvalidSfx( 1990, false );
	end
	
	--[[■512■石柱にワープ■
	proxy:OnDistanceActionAttribute( 512, 10000, 1982, "OnEvent_512", WarpGimmickDist_A, HELPID_GO_TO_SEKITYUU, 0, 180, ATTR_NOSESSION, everytime );
	]]

--■??■徘徊デーモンの登場■ハンドラ登録
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。
		proxy:LuaCall( 4000, 100, "PlayerDeath_m04_01_00_00", everytime );
		--プレイヤーが復活した時にキックされます。
		proxy:LuaCall( 4032, 100, "PlayerRevive_m04_01_00_00", everytime );
	proxy:NotNetMessage_end();


	
--■542■キメラ玉落下、破裂ポリ劇■
	proxy:SetColiEnable( 1201, false );
	proxy:SetDrawEnable( 1201, false );
	if proxy:IsCompleteEvent( 542 ) == false then
--> イベントID　2245
--> 　200～203
--> 
--> イベントID　2246
--> 　210～213
	--■540■キメラ玉の鎖解放１ポリ劇■
		if proxy:IsCompleteEvent( 540 ) == false then
			TurnTarget2( proxy, 200, 2245, -1 );
			TurnTarget2( proxy, 201, 2245, -1 );
			TurnTarget2( proxy, 202, 2245, -1 );
			TurnTarget2( proxy, 203, 2245, -1 );
			proxy:OnRegistFunc( 540, "Condition_540", "OnEvent_540", 2, once );
			
			proxy:LuaCall(540,1,"OnEvent_540_2",once);
			--ポリ劇開始フェード後に呼ばれるハンドラ
			proxy:LuaCall(540,REMO_START,"OnEvent_540_RemoStart",once);
			--ポリ劇終了後に呼ばれるハンドラ
			proxy:LuaCall(540,REMO_FINISH,"OnEvent_540_RemoFinish",once);
		else
			proxy:SetDrawEnable( 1280, false );
			proxy:SetColiEnable( 1280, false );
			proxy:SetDrawEnable( 1281, true );
			proxy:SetColiEnable( 1281, true );
			
			InvalidCharactor( proxy, 200 );
			InvalidCharactor( proxy, 201 );
			InvalidCharactor( proxy, 202 );
			InvalidCharactor( proxy, 203 );			
			
			--緑色の炎Sfx消し
			proxy:InvalidSfx( 1285, false );
			--ポイントライトの無効化
			proxy:InvalidPointLight( 1298 );
		end
		
	--■541■キメラ玉の鎖解放２ポリ劇■
		if proxy:IsCompleteEvent( 541 ) == false then
			TurnTarget2( proxy, 210, 2246, -1 );
			TurnTarget2( proxy, 211, 2246, -1 );
			TurnTarget2( proxy, 212, 2246, -1 );
			TurnTarget2( proxy, 213, 2246, -1 );
			proxy:OnRegistFunc( 541, "Condition_541", "OnEvent_541", 2, once );
			
			proxy:LuaCall(541,1,"OnEvent_541_2",once);
			--ポリ劇開始フェード後に呼ばれるハンドラ
			proxy:LuaCall(541,REMO_START,"OnEvent_541_RemoStart",once);
			--ポリ劇終了後に呼ばれるハンドラ
			proxy:LuaCall(541,REMO_FINISH,"OnEvent_541_RemoFinish",once);
		else
			proxy:SetDrawEnable( 1282, false );
			proxy:SetColiEnable( 1282, false );
			proxy:SetDrawEnable( 1283, true );
			proxy:SetColiEnable( 1283, true );
			
			InvalidCharactor( proxy, 210 );
			InvalidCharactor( proxy, 211 );
			InvalidCharactor( proxy, 212 );
			InvalidCharactor( proxy, 213 );				
			
			--緑色の炎Sfx消し
			proxy:InvalidSfx( 1286, false );
			--ポイントライト削除	
			proxy:InvalidPointLight( 1298 );	
		end
		--proxy:OnRegistFunc( 542, "Condition_542", "OnEvent_542", 2, once );		
		--ポリ劇開始フェード後に呼ばれるハンドラ
		proxy:LuaCall(542,REMO_START,"OnEvent_542_RemoStart",once);
		--ポリ劇終了後に呼ばれるハンドラ
		proxy:LuaCall(542,REMO_FINISH,"OnEvent_542_RemoFinish",once);
		
		--柱オブジェ壊れていない状態(1290:壊れていない、1291:壊れている)
		proxy:SetDrawEnable( 1291 , false );
		proxy:SetColiEnable( 1291 , false );
		
		--柱オブジェ壊れている状態(1292:壊れていない、1293:壊れている)
		proxy:SetDrawEnable( 1293 , false );--マップパーツなので表示だけ消す

		--柱オブジェ壊れている状態(1315:壊れていない、1316:壊れている)
		proxy:SetColiEnable( 1316 , false );--ヒットパーツなので当たりだけ消す
		
		--ムカデ無効化
		InvalidCharactor( proxy, 230 );
		InvalidCharactor( proxy, 231 );
		InvalidCharactor( proxy, 232 );
		InvalidCharactor( proxy, 233 );
		InvalidCharactor( proxy, 234 );
		InvalidCharactor( proxy, 235 );
		InvalidCharactor( proxy, 236 );
		InvalidCharactor( proxy, 237 );
		proxy:PlayPointSE( 2290, SOUND_TYPE_A, 400009, 4 );
	else
		proxy:SetDrawEnable(1200, false);
		proxy:SetColiEnable(1200, false);
		
		--柱オブジェ壊れている状態(1290:壊れていない、1291:壊れている)
		proxy:SetDrawEnable( 1290 , false );
		proxy:SetColiEnable( 1290 , false );
		
		--柱オブジェ壊れている状態(1292:壊れていない、1293:壊れている)
		proxy:SetDrawEnable( 1292 , false );--マップパーツなので表示だけ消す
		
		--柱オブジェ壊れている状態(1315:壊れていない、1316:壊れている)
		proxy:SetColiEnable( 1315 , false );--ヒットパーツなので当たりだけ消す
		--緑色の炎Sfx消し
		proxy:InvalidSfx( 1285, false );
		proxy:InvalidSfx( 1286, false );
		proxy:InvalidSfx( 1287, false );
		
		InvalidCharactor( proxy, 200 );
		InvalidCharactor( proxy, 201 );
		InvalidCharactor( proxy, 202 );
		InvalidCharactor( proxy, 203 );
		
		InvalidCharactor( proxy, 210 );
		InvalidCharactor( proxy, 211 );
		InvalidCharactor( proxy, 212 );
		InvalidCharactor( proxy, 213 );	
			
		--ポイントライト削除
		proxy:InvalidPointLight( 1297 );
		proxy:InvalidPointLight( 1298 );
		proxy:InvalidPointLight( 1299 );
	end
	
--■ユルト関連初期化■
	SetFirstNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STATE_LIFT );
	
--■15630■ユルトの死体を調べた■
	if proxy:IsCompleteEvent( 15630 ) == false then
		proxy:AddCorpseEvent( 15630 , 644 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15630 ,0 , "OnEvent_15630",once );
 		proxy:NotNetMessage_end();
	end	

	--エレベータ内か、牢城敵対状態の時
	if	proxy:IsCompleteEvent( YURUTO_STATE_LIFT ) 		== true or--ユルトがエレベーターに捕まっている　か
		proxy:IsCompleteEvent( YURUTO_STATE_ANGRY_M4 )	== true or--ユルトが敵対している　ならば
		proxy:IsCompleteEvent( YURUTO_STANDBY_M1 ) == true then		--ユルトが石柱に行く前なら
		--■563■ユルト(死亡)
		if proxy:IsCompleteEvent( 563 ) == false then
			proxy:OnCharacterDead( 563, 644, "OnEvent_563", once );--死亡監視追加
		end
		
		if proxy:IsCompleteEvent( YURUTO_STATE_ANGRY_M4 ) == false then--敵対していないならば
			if proxy:IsCompleteEvent( YURUTO_STANDBY_M1 ) == false then
				proxy:EnableLogic( 644, false );
			else
				--初期位置を変更
				proxy:Warp( 644 , 2255 );
			end
			
			--■560■ユルトを助ける(会話から呼び出し)
			if	proxy:IsCompleteEvent(560) == false then
				proxy:LuaCall( 560, 0, "OnEvent_560", everytime );
				--ユルト完全無敵
				proxy:EnableInvincible( 644, true );			
			end
			--[[
			--■561■会話でエレベータ移動
			if proxy:IsCompleteEvent( 561 ) == false then
				proxy:LuaCall( 561, 0, "OnEvent_561",   everytime );
				proxy:LuaCall( 561, 2, "OnEvent_561_call", everytime );
			end]]
			
			--■562■ユルト(敵対：牢城)
			if proxy:IsCompleteEvent( 562 ) == false then
				--proxy:OnCharacterTotalDamage( 562, 644, 10000, TOTALDAMAGE_YURUTO_M40, "OnEvent_562", once );
				proxy:OnCharacterTotalRateDamage( 562, 644, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_562", once );
			end
			
			--ホストが更新権限を管理
			if	proxy:IsClient() == false then
				proxy:RequestForceUpdateNetwork(644);
			end
			proxy:OnRegionJustIn( 568, 644, 1269, "OnEvent_568", everytime );
			proxy:OnRegionJustIn( 568, 644, 1271, "OnEvent_568", everytime );
			proxy:OnRegionJustIn( 569, 644, 1268, "OnEvent_569", everytime );
			proxy:OnRegionJustIn( 569, 644, 1270, "OnEvent_569", everytime );
			
		else--敵対していたら
			proxy:EnableLogic(644, true);
			--SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STATE_ANGRY_M4 );
			proxy:SetTeamType( 644, TEAM_TYPE_AngryFriend );
		end
	else--死んでいるか、ここにいない場合
		if	proxy:IsCompleteEvent( 563 ) == true and
			proxy:IsCompleteEvent( 15630 ) == false then
			proxy:Warp( 644 , 2255 );
			
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 15630 , "OnEvent_15630_OpeningDead",0.1,0,15630,once);
			proxy:NotNetMessage_end();			
		else
			InvalidBackRead( proxy, 644 );
		end
	end
	
	--ユルトとの会話で扉が既に開いている場合の再現
	--[[
	if	proxy:IsCompleteEvent( 560 ) == true then
		proxy:EndAnimation( 1254, 7 );
	end
]]
	proxy:RepeatMessage_begin();
	--■550■篭エレベータ1■
		proxy:SetIsAnimPauseOnRemoPlayForEvent(1250,true);
		proxy:SetIsAnimPauseOnRemoPlayForEvent(1251,true);
		proxy:OnRegionJustIn( 550, 10000, 1260, "OnEvent_550_1", everytime );
		proxy:OnRegionJustIn( 550, 10000, 1263, "OnEvent_550_1", everytime );		
		proxy:OnRegionJustIn( 550, 10000, 1261, "OnEvent_550_2", everytime );
		proxy:OnRegionJustIn( 550, 10000, 1262, "OnEvent_550_2", everytime );
		proxy:CustomLuaCall( 550 ,"OnEvent_550_flags",everytime ); 
		
		proxy:NotNetMessage_begin();
			proxy:OnRegionJustIn( 544 , 10000, 2280 ,"OnEvent_544_In",everytime);
			proxy:OnRegionJustOut( 544, 10000, 2280 ,"OnEvent_544_Out",everytime);
			proxy:OnRegionJustIn( 545 , 10000, 2281 ,"OnEvent_545_In",everytime);
			proxy:OnRegionJustOut( 545, 10000, 2281 ,"OnEvent_545_Out",everytime);
		proxy:NotNetMessage_end();
		
		--アニメ中のフラグはホストに任せる		
		SingleReset( proxy,556 );		
		
		--上下セットのフラグでアニメ再生
		if proxy:IsCompleteEvent( 551 ) == false then
			proxy:EndAnimation( 1250, 2 );
			proxy:EndAnimation( 1251, 1 );
		else
			proxy:EndAnimation( 1250, 1 );
			proxy:EndAnimation( 1251, 2 );
		end		
		
		
	--■552■篭エレベータ2■
		proxy:SetIsAnimPauseOnRemoPlayForEvent(1252,true);
		proxy:SetIsAnimPauseOnRemoPlayForEvent(1253,true);
		proxy:OnRegionJustIn( 552, 10000, 1264, "OnEvent_552_1", everytime );
		proxy:OnRegionJustIn( 552, 10000, 1267, "OnEvent_552_1", everytime );
		proxy:OnRegionJustIn( 552, 10000, 1265, "OnEvent_552_2", everytime );
		proxy:OnRegionJustIn( 552, 10000, 1266, "OnEvent_552_2", everytime );
		proxy:CustomLuaCall( 552,"OnEvent_552_flags",everytime );
		
		proxy:NotNetMessage_begin();
			proxy:OnRegionJustIn(546,10000,2282,"OnEvent_546_In",everytime);
			proxy:OnRegionJustOut(546,10000,2282,"OnEvent_546_Out",everytime);
			proxy:OnRegionJustIn(547,10000,2283,"OnEvent_547_In",everytime);
			proxy:OnRegionJustOut(547,10000,2283,"OnEvent_547_Out",everytime);
		proxy:NotNetMessage_end();
		
		--アニメ中のフラグは同期に任せる
		SingleReset( proxy , 557 );	
		
		if	proxy:IsCompleteEvent( 553 ) == false then
			proxy:EndAnimation( 1252, 2 );
			proxy:EndAnimation( 1253, 1 );
		else
			proxy:EndAnimation( 1252, 1 );
			proxy:EndAnimation( 1253, 2 );
		end		
		
	--■554■篭エレベータ3■
		proxy:SetIsAnimPauseOnRemoPlayForEvent(1254,true);
		proxy:SetIsAnimPauseOnRemoPlayForEvent(1255,true);
		proxy:OnRegionJustIn( 554, 10000, 1268, "OnEvent_554_1", everytime );
		proxy:OnRegionJustIn( 554, 10000, 1271, "OnEvent_554_1", everytime );
		proxy:OnRegionJustIn( 554, 10000, 1269, "OnEvent_554_2", everytime );
		proxy:OnRegionJustIn( 554, 10000, 1270, "OnEvent_554_2", everytime );
		proxy:CustomLuaCall( 554,"OnEvent_554_flags",everytime);
		
		proxy:NotNetMessage_begin();
			proxy:OnRegionJustIn( 548,10000,2284,"OnEvent_548_In",everytime );
			proxy:OnRegionJustOut(548,10000,2284,"OnEvent_548_Out",everytime);
			proxy:OnRegionJustIn( 549,10000,2285,"OnEvent_549_In",everytime );
			proxy:OnRegionJustOut(549,10000,2285,"OnEvent_549_Out",everytime); 
		proxy:NotNetMessage_end();
		--アニメ中のフラグは同期に任せる
		SingleReset( proxy, 558 );
		
		--ユルトのエレベータイベントが終っていない場合はデフォルトの状態とする
		if	proxy:IsCompleteEvent( 560 ) == false then
			proxy:EndAnimation( 1255, 5 );
		else			
			--ヒットパーツを消す
			proxy:SetColiEnable( 1310, false );
			if	proxy:IsCompleteEvent( 555 ) == false then
				proxy:EndAnimation( 1254, 2 );
				proxy:EndAnimation( 1255, 1 );
			else
				proxy:EndAnimation( 1254, 1 );
				proxy:EndAnimation( 1255, 2 );
			end
		end
		
	proxy:RepeatMessage_end();
	
	

--[[
	--■徘徊デーモン用 (フラグは仮、指定があれば変える)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m04_01_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m04_01_00_00);
	end
]]
	
	--■ボス関連の初期化処理
	if proxy:IsCompleteEvent( 5251 ) ==true then
		
		--▽ボス死んでいるとき
		--双子ボスいなくなる
		InvalidBackRead( proxy , 807 );
		InvalidBackRead( proxy , 817 );
		
		--魔法壁消える
		proxy:SetColiEnable( 1998 , false );
		proxy:SetColiEnable( 1994 , false );
	
		proxy:SetDrawEnable( 1998 , false );
		proxy:SetDrawEnable( 1994 , false );

		--魔法壁の SFX OFF
		proxy:InvalidSfx( 1986 , false );
		proxy:InvalidSfx( 1990 , false );

		--ホストプレイヤーのみアイテム入手イベントに使用
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--宝死体(ソウル?)有効化
		proxy:SetDrawEnable( 1981 , true );
		proxy:SetColiEnable( 1981 , true );
		--宝死体(ソウル?)2有効化
		proxy:SetDrawEnable( 1976 , true );
		proxy:SetColiEnable( 1976 , true );
		
		--▼(ソウル)アイテム取得用イベント監視追加▼
		if proxy:IsCompleteEvent( 5261 ) == false then
			proxy:ValidSfx( 2231 );--SFX 有効化
			proxy:ValidSfx( 2230 );--SFX 有効化
			proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--光らせる
			proxy:OnDistanceActionAttribute( 5261 , 10000 , 1981 , "OnEvent_5261" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--▼要石でワープ用の監視を追加▼
			SingleReset(proxy,5262);
			--proxy:InvalidSfx( 2231, false );--SFX 無効化
			proxy:InvalidSfx( 2230, false );--SFX 無効化
			proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--光らせる
			proxy:OnDistanceActionAttribute( 5262 , 10000 , 1981 , "OnEvent_5262" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
		
	else
		--▽ボス生きているとき		
		proxy:EnableLogic( 807 , false );--ロジックOFFで待機
		proxy:EnableLogic( 817 , false );--ロジックOFFで待機		
		
		--宝(ソウル?)
		proxy:SetDrawEnable( 1981 , false );
		proxy:SetColiEnable( 1981 , false );
		--宝(ソウル?)2
		proxy:SetDrawEnable( 1976 , false );
		proxy:SetColiEnable( 1976 , false );

		--SFX 無効化
		proxy:InvalidSfx( 2231 , false );--ソウル用
		proxy:InvalidSfx( 2230 , false );--ボスアイテム用		
	end	
	
	--■535■光の壁■
	if proxy:IsCompleteEvent( 535 ) == false then
		proxy:OnDistanceActionAttribute( 535, 10000, 1300, "OnEvent_535", 1.5, 10010403, 180.0, 90.0, ATTR_HOST + ATTR_LIVE + ATTR_GREY, everytime );
		proxy:LuaCall( 535, 2, "OnEvent_535_delete", once );
	else
		proxy:SetDrawEnable( 1300, false );
		proxy:SetColiEnable( 1300, false );
		proxy:InvalidSfx( 2200, false );
	end
	
	--■536■光の壁■
	if proxy:IsCompleteEvent( 536 ) == false then
		proxy:OnDistanceActionAttribute( 536, 10000, 1301, "OnEvent_536", 1.5, 10010403, 180.0, 90.0, ATTR_HOST + ATTR_LIVE + ATTR_GREY, everytime );
		proxy:LuaCall( 536, 2, "OnEvent_536_delete", once );
	else
		proxy:SetDrawEnable( 1301, false );
		proxy:SetColiEnable( 1301, false );
		proxy:InvalidSfx( 2201, false );
	end
	
	
	
	
--■540■キメラ玉の鎖解放１ポリ劇■
--■541■キメラ玉の鎖解放２ポリ劇■
	local flag540 = proxy:IsCompleteEvent( 540 );
	local flag541 = proxy:IsCompleteEvent( 541 );
	
	--1本も切れていない
	if flag540 == false and flag541 == false then
		local set_flag_list ={1,0,1,0,1};
		chainInitFunc(proxy,set_flag_list);
	end
	
	--1本目だけ切れている
	if flag540 == true and flag541 == false then
		local set_flag_list ={0,1,1,0,1};
		chainInitFunc(proxy,set_flag_list);
	end
	
	--2本目だけ切れている
	if flag540 == false and flag541 == true then
		local set_flag_list ={1,0,0,1,1};
		chainInitFunc(proxy,set_flag_list);
	end
	
	--両方切れている
	if flag540 == true and flag541 == true then
		local set_flag_list ={0,0,0,0,0};
		chainInitFunc(proxy,set_flag_list);
	end
	
--■542■キメラ玉落下、破裂ポリ劇■
	if proxy:IsCompleteEvent( 542 ) == false then
		
		proxy:SetDrawEnable(1201, false);
		proxy:SetColiEnable(1201, false);
		
		--柱オブジェ壊れていない状態(1290:壊れていない、1291:壊れている)
		proxy:SetDrawEnable( 1291 , false );
		proxy:SetColiEnable( 1291 , false );
		
		--柱オブジェ壊れている状態(1292:壊れていない、1293:壊れている)
		proxy:SetDrawEnable( 1293 , false );--マップパーツなので表示だけ消す

	else
		proxy:SetDrawEnable(1200, false);
		proxy:SetColiEnable(1200, false);
		
		--柱オブジェ壊れている状態(1290:壊れていない、1291:壊れている)
		proxy:SetDrawEnable( 1290 , false );
		proxy:SetColiEnable( 1290 , false );
		
		--柱オブジェ壊れている状態(1292:壊れていない、1293:壊れている)
		proxy:SetDrawEnable( 1292 , false );--マップパーツなので表示だけ消す
	end
	
	--■550■篭エレベータ1■
	if proxy:IsCompleteEvent( 551 ) == false then
		--proxy:EndAnimation( 1250, 0 );
	else
		--proxy:EndAnimation( 1251, 0 );
	end
	
	--■600■鉄の板
	SingleReset( proxy, 600 );
	if 	proxy:IsSuccessQWC( 40150 ) == false and
		proxy:IsCompleteEvent(601) == false then
		proxy:SetEventFlag( 600, true );
	end
	
	if proxy:IsCompleteEvent( 600 ) == true then
		print("鉄の板を無効化しました");
		proxy:SetColiEnable( 1210, false );
		proxy:SetDrawEnable( 1210, false );
	end
	
	--■601■鉄の板の先に通過■
	if proxy:IsCompleteEvent( 601 ) == false then
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionJustIn( 601 , 10000 , 2270 ,"OnEvent_601",once);
			proxy:NotNetMessage_end();
		end
	end
	
	
	--■8086■牢城に来たフラグを立てる■
		proxy:SetEventFlag(8086, true);
	
--------------------------------▽▽▽QWCイベント関連▽▽▽--------------------------------
--■620■QWCソウルモンスター出現１■
	if	proxy:IsSuccessQWC(40100) == true then
		print("m04_01 QWCソウルモンスター出現　成立");
		ValidCharactor( proxy, 221 );
		ValidCharactor( proxy, 222 );
		ValidCharactor( proxy, 223 );
	else
		print("m04_01 QWCソウルモンスター出現　未成立");
		InvalidCharactor( proxy, 221 );
		InvalidCharactor( proxy, 222 );
		InvalidCharactor( proxy, 223 );
	end

--■鉱石の精霊■------------------------------------------------------------------
	--■610■鉱石の精霊がいない■
	if proxy:IsCompleteEvent( 611 ) == true
	   or proxy:IsSuccessQWC( 40110 ) == false then
		InvalidCharactor( proxy, 220 );
		print("QWC未成立、もしくは死んでいるので鉱石の精霊を無効化します");
	end
	--■611■鉱石の精霊の死亡監視■
	if proxy:IsCompleteEvent( 611 ) == false then
		proxy:OnCharacterDead( 611, 220, "OnEvent_611", once );
		if proxy:IsClient() == false and proxy:IsCompleteEvent(8020) == false then
			proxy:NotNetMessage_begin();
				proxy:AddCorpseEvent( 8020 , 220 );
				proxy:LuaCall( 8020 , 0 , "OnEvent_8020",once);
			proxy:NotNetMessage_end();
		end
	end
----------------------------------------------------------------------------------
--------------------------------△△△QWCイベント関連△△△--------------------------------

	--ムカデここから
	MukadeRegist(proxy);
	--[[
	if	proxy:IsCompleteEvent( 640 ) == false then
		proxy:OnCharacterTotalRateDamage( 640, 230, -1, 0.5, "OnEvent_640", once );
		proxy:OnCheckEzStateMessage( 640, 230, "OnEvent_640_1", 500 );
		InvalidCharactor( proxy, 240 );
	end
	
	if	proxy:IsCompleteEvent( 640 ) == false then
		proxy:OnCharacterTotalRateDamage( 640, 230, -1, 0.5, "OnEvent_640", once );
		proxy:OnCheckEzStateMessage( 640, 230, "OnEvent_640_1", 500 );
		InvalidCharactor( proxy, 240 );
	end
	
	if	proxy:IsCompleteEvent( 645 ) == false then
		proxy:OnCharacterTotalRateDamage( 640, 235, -1, 0.5, "OnEvent_645", once );
		proxy:OnCheckEzStateMessage( 645, 235, "OnEvent_645_1", 500 );
		InvalidCharactor( proxy, 245 );
	end
	]]
	--ムカデここまで
	
	
	--■580,581,582,583■昇降版制御
	--ホストの制御用監視登録
	SingleReset( proxy, 581 );
	SingleReset( proxy, 583 );
	proxy:SetIsAnimPauseOnRemoPlayForEvent(1330,true);
	if	proxy:IsClient() == false then
		proxy:PlayAnimation( 1330, 1 );
		proxy:OnCharacterAnimEndPlus(580, 1330, 1, "OnEvent_580_1", once );
	--クライアントの状態あわせ
	else
		if	proxy:IsCompleteEvent(581) == false then
			proxy:EndAnimation(1330, 1 );
		else
			proxy:EndAnimation(1330, 2 );
		end
	end
	--アニメ＆フラグ同期用
	proxy:LuaCall( 580, 1, "OnEvent_580_1_call", everytime );
	proxy:LuaCall( 580, 2, "OnEvent_580_2_call", everytime );
	
	
	proxy:SetIsAnimPauseOnRemoPlayForEvent(1331,true);
	if	proxy:IsClient() == false then
		proxy:PlayAnimation( 1331, 1 );
		proxy:OnCharacterAnimEndPlus(582, 1331, 1, "OnEvent_582_1", once );
	--クライアントの状態あわせ
	else
		if	proxy:IsCompleteEvent(583) == false then
			proxy:EndAnimation(1331, 1 );
		else
			proxy:EndAnimation(1331, 2 );
		end
	end
	--アニメ＆フラグ同期用
	proxy:LuaCall( 582, 1, "OnEvent_582_1_call", everytime );
	proxy:LuaCall( 582, 2, "OnEvent_582_2_call", everytime );
	
--■590■ガーゴイル特殊待機1■
	SingleReset(proxy,590);
	if proxy:IsCompleteEvent( 590 ) == false then
		proxy:OnRegionJustIn( 590 , 10000 , 2210 , "OnEvent_590", once);
		--特殊待機なのでダメージの監視は必要ない
	else
		proxy:SetSpStayAndDamageAnimId( 413 ,-1,-1 );
	end
--■591■ガーゴイル特殊待機2■
	SingleReset(proxy,591);
	if proxy:IsCompleteEvent( 591 ) == false then
		proxy:OnRegionJustIn( 591 , 10000 , 2211 , "OnEvent_591", once);
		--特殊待機なのでダメージの監視は必要ない
	else
		proxy:SetSpStayAndDamageAnimId( 411 , -1, -1);
	end
--■592■ガーゴイル特殊待機3■
	SingleReset(proxy,592);
	if proxy:IsCompleteEvent( 592 ) == false then
		proxy:OnRegionJustIn( 592 , 10000 , 2212 , "OnEvent_592", once );
		--特殊待機なのでダメージの監視は必要ない
	else
		proxy:SetSpStayAndDamageAnimId( 412 , -1, -1);
	end
	
	
	
	--
--■700■要石の光が消える■
	proxy:OnSessionJustIn( 700 , "OnEvent_700_1" , everytime );
		
--■700■要石の光が復活する■
	proxy:OnSessionJustOut( 700 , "OnEvent_700_2" , everytime );

--[[
--■597■もやSFX領域に進入■
	proxy:OnRegionJustIn( 597 , 10000 , 2220 , "OnEvent_597",everytime);
	
--■598■もやSFX領域からでた■
	proxy:OnRegionJustOut( 598 , 10000 , 2220 , "OnEvent_598",everytime);
]]
	--■999999■フレーム遅れの初期化処理イベントを発行■
	proxy:NotNetMessage_begin();
		--▼0.2秒後▼--
		proxy:OnKeyTime2( 999991, "Second_Initialize_m04_01_00_00", 0.2, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m04_01_00_00 end");
end


--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく
function Second_Initialize_m04_01_00_00(proxy, param)
	print("Second_Initialize_m04_01_00_00 begin");

--------------------------------▽▽▽QWCイベント関連▽▽▽--------------------------------
--------------------------------△△△QWCイベント関連△△△--------------------------------

--イベントのタイミングを意図的にずらす
	proxy:NotNetMessage_begin();
	--■597■もやSFX領域に進入■
		proxy:OnRegionJustIn( 597 , 10000 , 2220 , "OnEvent_597",everytime);
		
	--■598■もやSFX領域からでた■
		proxy:OnRegionJustOut( 598 , 10000 , 2220 , "OnEvent_598",everytime);	
	proxy:NotNetMessage_end();
	print("Second_Initialize_m04_01_00_00 end");
end


function chainInitFunc(proxy,set_flag_list)
	local evid_list = {1280, 1281, 1282, 1283, 1284};
	local list_num = table.getn(set_flag_list);
	for index = 1, list_num, 1 do
		proxy:SetDrawEnable( evid_list[index], set_flag_list[index] );
		proxy:SetColiEnable( evid_list[index], set_flag_list[index] );
	end
end


--イベントID1982がなくてTeachManでエラーをはきだすのでコメントアウト
--[[------------------------------------------------------------------------------------
--■512■石柱にワープ■
--------------------------------------------------------------------------------------
--■512■石柱にワープ■
function OnEvent_512(proxy,param)	
	print("OnEvent_512 begin");
	
	--完全回復要求
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1008 );
	
	print("OnEvent_512 end");
end
]]

--[[------------------------------------------------------------------------------------
--徘徊デーモンの登場■??
--------------------------------------------------------------------------------------]]

--▼グローバルの死亡監視から呼ばれる(ソロ)
function PlayerDeath_m04_01_00_00(proxy, param)
	print("PlayerDeath_m04_01_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m04_01_00_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。
	
	print("PlayerDeath_m04_01_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ)
function PlayerRevive_m04_01_00_00(proxy,param)
	print("PlayerRevive_m04_01_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m04_01_00_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。
	
	print("PlayerRevive_m04_01_00_00");
end



















--[[------------------------------------------------------------------------------------
--ボス部屋の中に入る■523
--------------------------------------------------------------------------------------]]
--■イベントがループなので、全部リピートにする↓

--■523■中ボス部屋への扉が開く■
function OnEvent_523(proxy,param)
	print("OnEvent_523 begin");

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_523 end");
		return;
	end	
	
	--クライアントへ、ボス部屋阻止失敗を通知
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 524 , 1 );--旋回アニメの同期再生
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE , true );--多重発動防止用フラグON
	--多重起動システムIDをタイムアウトを設定してONにする
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_523 end");
end


--旋回アニメの同期再生(IDが別)
function OnEvent_524_1(proxy,param)
	print("OnEvent_524_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を行い、その終了時にOnEvent_524_2を発行する
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2890 );
		else
			proxy:LockSession();--ルームをロックします！
			--旋回アニメ再生を行い、その終了時にOnEvent_524_2を発行する
			proxy:OnTurnCharactorEnd( 524, 10000, 2890, "OnEvent_524_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_524_1 end");
end

--旋回アニメの同期再生終了後
function OnEvent_524_2(proxy,param)
	print("OnEvent_524_2 begin");
	
	--同期用歩きアニメ再生
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 524, 10000, ANIMEID_WALK, "OnEvent_524_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();

	print("OnEvent_524_2 end");
end

--歩きアニメの同期再生終了後
function OnEvent_524_3(proxy,param)
	print("OnEvent_524_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ
	if proxy:IsCompleteEvent( 523 ) == false then
		proxy:LuaCallStart( 524 , 5 );--2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知
		proxy:LuaCallStart( 524 , 6 );--フラグセット(同期用)
		Lua_MultiDoping(proxy,807);--マルチプレイドーピング
		Lua_MultiDoping(proxy,817);--マルチプレイドーピング
	end
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );

	print("OnEvent_524_3 end");
end


--■523 2回目以降にボス部屋に入るためのイベント配信用
function OnEvent_523_GO_TO_IN(proxy, param)
	print("OnEvent_523_GO_TO_IN begin");
		
	proxy:NotNetMessage_begin();
		--▼524▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_523
		proxy:OnPlayerActionInRegion( 524, 2894, "OnEvent_523", HELPID_GO_TO_IN, everytime );--
		
		proxy:OnKeyTime2( 524,"StandBy_Kimera",0.5,0,0,once);
	proxy:NotNetMessage_end();	
	
	print("OnEvent_523_GO_TO_IN end");
end


--■523 フラグセット(同期用)
function OnEvent_523_flag_set(proxy, param)
	print("OnEvent_523_flag_set begin");
		
	proxy:SetEventFlag( 523 , 1 );
	proxy:DeleteEvent( 523 );

	print("OnEvent_523_flag_set end");
end

--[[------------------------------------------------------------------------------------
--■525■ボス戦闘開始■
--------------------------------------------------------------------------------------]]
--■525■ボス戦闘開始■
function OnEvent_525(proxy,param)
	print("OnEvent_525 begin");
	
	--ボス戦用BGM再生開始
	proxy:PlayPointSE( 2240, SOUND_TYPE_M, 40100000, 1 );
	
	--ボスロジックON
	proxy:EnableLogic( 807 , true );
	proxy:EnableLogic( 817 , true );
	
	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない)
	proxy:ResetThink( 807 );
	proxy:ResetThink( 817 );
	
	m04_01_BossInit(proxy,param);
	
	--ボスゲージセット
	proxy:SetBossGauge(807,0,3040);
	
	print("OnEvent_525 end");
end




--[[------------------------------------------------------------------------------------
--■5251■ボス死亡■
--------------------------------------------------------------------------------------]]
--■5251■ボス死亡■
function OnEvent_5251(proxy,param)
	print("OnEvent_5251 begin");
	
	local acid = param:GetParam1();
	proxy:SetEventFlag( acid, true );
	
	--2体のうち、片方でも生きていればやり直し
	if	proxy:IsCompleteEvent( 5250 ) == false or
		proxy:IsCompleteEvent( 5253 ) == false then
		print("OnEvent_5251 return end");
		return;
	end
	
	
	proxy:NotNetMessage_begin();
		--1秒後に崩れる壁発動イベントを発行--
		proxy:OnKeyTime2(5251,"OnEvent_5251_1", 1,0,0,once);
		--マルチ解散監視
		proxy:OnRegistFunc( 5251 , "Check_5251_PT","OnEvent_5251_PT",0,once);
	proxy:NotNetMessage_end();	

	proxy:StopPointSE( 1 );
	
	--ブロッククリア処理へ
	proxy:CustomLuaCallStart( 4050, 807 );
	--トカゲイベントリセット
	ResetTokage(proxy);
	
	m04_01_BossDead(proxy,param);
	
	print("OnEvent_5251 end");
end


function OnEvent_5251_1(proxy, param)
	print("OnEvent_5251_1 begin");
	
	proxy:SetEventFlag( 5251, true );
	
	--ボスを倒した数を更新(数によってフラグを立てる)
	GetBossFlagCount( proxy, param );
	
	--ボス戦用のBGM停止
	--proxy:StopPointSE( 0 );

--アイテム入手関連-------
	
	--ホストプレイヤーのみアイテム入手イベントに使用
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

	--宝死体(ソウル?)有効化
	proxy:SetDrawEnable( 1981 , true );
	proxy:SetColiEnable( 1981 , true );
	--宝死体(ソウル?)2有効化
	proxy:SetDrawEnable( 1976 , true );
	proxy:SetColiEnable( 1976 , true );
	
	--▼(ソウル)アイテム取得用イベント監視追加▼
	if proxy:IsCompleteEvent( 5261 ) == false then
		proxy:ValidSfx( 2231 );--SFX 有効化
		proxy:ValidSfx( 2230 );--SFX 有効化
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--光らせる
		proxy:OnDistanceActionAttribute( 5261 , 10000 , 1981 , "OnEvent_5261" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end
	
------------------------	
	--▼トロフィー取得判定▼
	Lua_RequestUnlockTrophy(proxy, 33);	

	print("OnEvent_5251_1 end");
end

--マルチ解散監視
function Check_5251_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--マルチじゃない
function OnEvent_5251_PT(proxy,param)
	print("OnEvent_5251_PT beign");
	
	--魔法壁消える
	proxy:SetColiEnable( 1998 , false );
	proxy:SetColiEnable( 1994 , false );

	proxy:SetDrawEnable( 1998 , false );
	proxy:SetDrawEnable( 1994 , false );

	--光の壁Sfxを消す
	proxy:InvalidSfx( 1986, true );
	proxy:InvalidSfx( 1990, true );
	
	--中ボス部屋前の移動処理イベントを削除
	proxy:DeleteEvent( 523 );--一人目が入るとき用
	proxy:DeleteEvent( 524 );--二人目以降が入るとき用
	print("OnEvent_5251_PT end");
end
--------------------------------------------------------------------------------------
--■5262■石柱にワープ■
--------------------------------------------------------------------------------------
function OnEvent_5262(proxy,param)	
	print("OnEvent_5262 begin");
	
	proxy:RepeatMessage_begin();
		--▼70_1▼選択メニューの監視▼
		proxy:OnSelectMenu(5262, "OnEvent_5262_1", 10010710, 0, 2, 1981, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_5262 end");
end

--▲5262_1▲選択メニューの監視▲
function OnEvent_5262_1(proxy,param)	
	print("OnEvent_5262_1 begin");
	
	if proxy:IsSession() == false then
		
		if param:IsNetMessage() == true then
			proxy:PlayAnimation(10001+param:GetPlayID(),8283);
			print("OnEvent_5262_1 end");
			return;
		end
			
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1981 ,TURNSKIP_ANGLE);
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd( 5262 , 10000 , 8283 , "OnEvent_5262_2",once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(5262,true);
		
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_5262_1 end");
end

--■5262_2■石柱にワープ■
function OnEvent_5262_2(proxy,param)	
	print("OnEvent_5262_2 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生
	--石柱へ戻ってきた判定のフラグを立てる
	proxy:SetEventFlag(8083, true);
	
	--完全回復要求
	proxy:RequestFullRecover();
	--古砦要石に戻る
	proxy:WarpNextStage( 1, 0, 0, 0, 1008);	
	
	print("OnEvent_5262_2 end");
end

--------------------------------------------------------------------------------------
--■5261■ソウル入手■
--------------------------------------------------------------------------------------
function OnEvent_5261(proxy, param)
	print("OnEvent_5261 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ 
		print("OnEvent_5261 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行
		proxy:OnKeyTime2( 5261, "OnEvent_5261_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_5261 end");
end


--■5261_1■アイテム取得■
function OnEvent_5261_1(proxy, param)
	print("OnEvent_5261_1 begin");

	--アイテム取得関数--パラメータ10551参照
	proxy:GetRateItem(10551);	
	--アイテム取得関数--パラメータ10574参照
	proxy:GetRateItem(10574);	
	--アイテム取得関数--パラメータ10575参照
	proxy:GetRateItem(10575);	
	--アイテム取得関数--パラメータ10576参照
	proxy:GetRateItem(10576);	
	--アイテム取得関数--パラメータ10577参照
	proxy:GetRateItem(10577);	
	
	--アイテムを取得済み
	proxy:SetEventFlag( 5261, 1 );
	
	--SFXが消える
	--proxy:InvalidSfx( 2231 , true );
	proxy:InvalidSfx( 2230 , true );
		
	--▼要石でワープ用の監視を追加▼
	proxy:OnDistanceActionAttribute( 5262 , 10000 , 1981 , "OnEvent_5262" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_5261_1 end");
end

--[[------------------------------------------------------------------------------------
--■535■光の壁■
--------------------------------------------------------------------------------------]]
--■535■光の壁■
function OnEvent_535(proxy,param)
	print("OnEvent_535 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 535 , true );
		return;
	end
	--ダミポリへワープ
	proxy:WarpDmy( 10000, 1300, 191 );
	
	proxy:NotNetMessage_begin();
		--▼535_1▼歩きアニメ終了▼
		--proxy:OnChrAnimEnd( 535, 10000, ANIMEID_WALK, "OnEvent_535_1" , once );
		proxy:LuaCallStart( 535, 2 );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 535 , true );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_535 end");
end

function OnEvent_535_1(proxy,param)
	print("OnEvent_535_1 begin");
	
	proxy:LuaCallStart( 535, 2 );
	
	print("OnEvent_535_1 end");
end

function OnEvent_535_delete(proxy,param)
	print("OnEvent_535_delete begin");
	
	proxy:SetDrawEnable( 1300, false );--描画OFF
	proxy:SetColiEnable( 1300, false );--当たりOFF	
	proxy:SetObjDeactivate( 1300 , true );--デアクティブ	
	proxy:InvalidSfx( 2200, true );
	proxy:DeleteEvent( 535 );
	
	print("OnEvent_535_delete end");
end



--[[------------------------------------------------------------------------------------
--■536■光の壁■
--------------------------------------------------------------------------------------]]
--■536■光の壁■
function OnEvent_536(proxy,param)
	print("OnEvent_536 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 536 , true );
		return;
	end
	--ダミポリへワープ
	proxy:WarpDmy( 10000, 1301, 191 );
	
	proxy:NotNetMessage_begin();
		--▼536_1▼歩きアニメ終了▼
		--proxy:OnChrAnimEnd( 536, 10000, ANIMEID_WALK, "OnEvent_536_1" , once );
		proxy:LuaCallStart( 536, 2 );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 536 , true );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_536 end");
end

function OnEvent_536_1(proxy,param)
	print("OnEvent_536_1 begin");
	
	proxy:LuaCallStart( 536, 2 );
	
	print("OnEvent_536_1 end");
end

function OnEvent_536_delete(proxy,param)
	print("OnEvent_536_delete begin");
	
	proxy:SetDrawEnable( 1301, false );--描画OFF
	proxy:SetColiEnable( 1301, false );--当たりOFF
	proxy:SetObjDeactivate( 1301 , true );--デアクティブ
	proxy:InvalidSfx( 2201, true );
	proxy:DeleteEvent( 536 );
	
	print("OnEvent_536_delete end");
end




--[[------------------------------------------------------------------------------------
--■540■キメラ玉の鎖解放１ポリ劇■
--------------------------------------------------------------------------------------]]
--■540■キメラ玉の鎖解放１ポリ劇■
function Condition_540(proxy,param)
	local target_list 	= {200, 201, 202, 203};
	local targetNum		= table.getn( target_list );
	local isAlive		= false;
	
	for i = 1, targetNum, 1 do
		if proxy:IsAlive( target_list[i] ) == true then
			isAlive = true;
		end
	end
	
	if isAlive == false then
		return true;
	end
	return false;
end

function OnEvent_540(proxy,param)
	if proxy:IsClient() == false then
		print("OnEvent_540 begin");
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 540 , "OnEvent_540_1",REMO_WAIT,0,0,once);
		proxy:NotNetMessage_end();
		print("OnEvent_540 end");
	end
end

function OnEvent_540_1(proxy,param)
	print("OnEvent_540_1 begin");
	proxy:LuaCallStart( 540,1 );	
	print("OnEvent_540_1 end");
end

function OnEvent_540_2(proxy,param)
	print("OnEvent_540_2 begin");
	if	proxy:IsCompleteEvent( 541 ) == false then
		proxy:RequestRemo(40101, REMO_FLAG, 540, 1 );
	else
		OnEvent_542(proxy,param);
	end	
	proxy:SetEventFlag( 540, true );
	print("OnEvent_540_2 end");
end

--■ポリ劇再生開始(フェード終了)
function OnEvent_540_RemoStart(proxy,param)
print("OnEvent_540_RemoStart begin");
	--緑色の炎Sfx消し
	proxy:InvalidSfx( 1285, false );
print("OnEvent_540_RemoStart end");
end


--■ポリ劇再生終了(フェード終了)
function OnEvent_540_RemoFinish(proxy,param)
print("OnEvent_540_RemoFinish begin");
	proxy:SetDrawEnable( 1280, false );
	proxy:SetColiEnable( 1280, false );
	proxy:SetDrawEnable( 1281, true );
	proxy:SetColiEnable( 1281, true );	
	--ポイントライト削除
	proxy:InvalidPointLight( 1298 );
print("OnEvent_540_RemoFinish end");
end


--[[------------------------------------------------------------------------------------
--■541■キメラ玉の鎖解放２ポリ劇■
--------------------------------------------------------------------------------------]]
--■541■キメラ玉の鎖解放２ポリ劇■
function Condition_541(proxy,param)
	local target_list 	= {210, 211, 212, 213};
	local targetNum		= table.getn( target_list );
	local isAlive		= false;
	
	for i = 1, targetNum, 1 do
		if proxy:IsAlive( target_list[i] ) == true then
			isAlive = true;
		end
	end
	
	if isAlive == false then
		return true;
	end
	return false;
end

function OnEvent_541(proxy,param)
	if proxy:IsClient() == false then
		print("OnEvent_541 begin");
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 541 , "OnEvent_541_1",REMO_WAIT,0,0,once);
		proxy:NotNetMessage_end();
		print("OnEvent_541 end");
	end
end

function OnEvent_541_1(proxy,param)
	print("OnEvent_541_1 begin");
	proxy:LuaCallStart( 541 , 1 );
	print("OnEvent_541_1 end");
end

function OnEvent_541_2(proxy,param)
	print("OnEvent_541_2 begin");
	if	proxy:IsCompleteEvent( 540 ) == false then
		proxy:RequestRemo(40101, REMO_FLAG, 541, 1 );
	else
		OnEvent_542(proxy,param);
	end
	proxy:SetEventFlag( 541, true );
	print("OnEvent_541_2 end");
end

--■ポリ劇再生開始(フェード終了)
function OnEvent_541_RemoStart(proxy,param)
print("OnEvent_541_RemoStart begin");
	--緑色の炎Sfx消し
	proxy:InvalidSfx( 1286, false );
	proxy:InvalidSfx( 1285, false );
print("OnEvent_541_RemoStart end");
end

--■ポリ劇再生終了(フェード終了)
function OnEvent_541_RemoFinish(proxy,param)
print("OnEvent_541_RemoFinish begin");
	proxy:SetDrawEnable( 1282, false );
	proxy:SetColiEnable( 1282, false );
	proxy:SetDrawEnable( 1283, true );
	proxy:SetColiEnable( 1283, true );
	
	--こっちはもう片方の
	proxy:ValidSfx( 1285 );
	
	--ポイントライト削除
	proxy:InvalidPointLight( 1298 );
print("OnEvent_541_RemoFinish end");
end


--[[------------------------------------------------------------------------------------
--■542■キメラ玉落下、破裂ポリ劇■
--------------------------------------------------------------------------------------]]
--■542■キメラ玉落下、破裂ポリ劇■
function OnEvent_542(proxy,param)
	print("OnEvent_542 begin");
	
	proxy:RequestRemo(40100, REMO_FLAG, 542, 1 );
	proxy:SetEventFlag( 542, true );

	--鎖を全て無効化
	local set_flag_list = {0,0,0,0,0};
	chainInitFunc(proxy,set_flag_list);
	
	print("OnEvent_542 end");
end


--■ポリ劇再生開始(フェード終了)
function OnEvent_542_RemoStart(proxy,param)
print("OnEvent_542_RemoStart begin");
	proxy:SetDrawEnable(1201, true);
	proxy:SetColiEnable(1201, true);
	
	--緑色の炎Sfx消し
	proxy:InvalidSfx( 1285, false );
	proxy:InvalidSfx( 1286, false );
	proxy:InvalidSfx( 1287, false );
print("OnEvent_542_RemoStart end");
end

--■ポリ劇再生終了(フェード終了)
function OnEvent_542_RemoFinish(proxy,param)
print("OnEvent_542_RemoFinish begin");
	--落下前のキメラ球を消して、落下後を表示
	proxy:SetDrawEnable(1200, false);
	proxy:SetColiEnable(1200, false);
	
	--柱オブジェを壊れた状態にする
	proxy:SetDrawEnable( 1290 , false );--破壊前を無効化
	proxy:SetColiEnable( 1290 , false );

	proxy:SetDrawEnable( 1291 , true );	--破壊後を有効化
	proxy:SetColiEnable( 1291 , true );
	
	--マップパーツなので表示だけ切り替え
	proxy:SetDrawEnable( 1292 , false );--破壊前を無効化
	proxy:SetDrawEnable( 1293 , true );--破壊後を有効化
	
	--柱オブジェ壊れている状態(1315:壊れていない、1316:壊れている)
	proxy:SetColiEnable( 1315 , false );--破壊前を無効化
	proxy:SetColiEnable( 1316 , true );--破壊後を有効化
	
	
	--ムカデ無効化
	ValidCharactor( proxy, 230 );
	ValidCharactor( proxy, 231 );
	ValidCharactor( proxy, 232 );
	ValidCharactor( proxy, 233 );
	ValidCharactor( proxy, 234 );
	ValidCharactor( proxy, 235 );
	ValidCharactor( proxy, 236 );
	ValidCharactor( proxy, 237 );
	
	proxy:SetColiEnable( 1201, false );
	proxy:SetDrawEnable( 1201, false );
	
	proxy:StopPointSE( 4 );
	
	--ポイントライト削除
	proxy:InvalidPointLight( 1297 );
	proxy:InvalidPointLight( 1298 );
	proxy:InvalidPointLight( 1299 );
print("OnEvent_542_RemoFinish end");
end

--[[------------------------------------------------------------------------------------
--■550■篭エレベータ1■
--------------------------------------------------------------------------------------]]
--■550■篭エレベータ1■
function OnEvent_550_1(proxy,param)
	print("OnEvent_550_1 begin");
	
	--アニメ再生中なら終了
	if proxy:IsCompleteEvent(556) == true then
		return;
	end
	
	--下にあるなら終了？
	if proxy:IsCompleteEvent(551) == true then
		return;
	end
	
	proxy:SetEventFlag( 556, true );
	--上セットか下セットかは最終で決める
	proxy:SetEventFlag( 551, true );
	
	lift_PlayAnimation(proxy, 1250, 1251, 1 );
	
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnObjAnimEnd( 550, 1250, 1, "OnEvent_550_animEnd", once );
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_550_1 end");
end

function OnEvent_550_2(proxy,param)
	print("OnEvent_550_2 begin");
	
	--アニメ再生中なら終了
	if proxy:IsCompleteEvent(556) == true then
		return;
	end
	
	--上にあるなら終了？
	if proxy:IsCompleteEvent(551) == false then
		return;
	end

	proxy:SetEventFlag( 556, true );
	--上セットか下セットかは最終で決める
	proxy:SetEventFlag( 551, false );
	
	lift_PlayAnimation(proxy, 1250, 1251, 2 );
	
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnObjAnimEnd( 550, 1250, 2, "OnEvent_550_animEnd", once );
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_550_2 end");
end

--アニメ終了監視
function OnEvent_550_animEnd(proxy,param)
	if proxy:IsClient() == false then
		print("OnEvent_550_animEnd begin");
		if proxy:IsCompleteEvent( 551 ) == true then
			proxy:CustomLuaCallStart( 550, 1 );
		else
			proxy:CustomLuaCallStart( 550, 0 );
		end
		print("OnEvent_550_animEnd end");
	end
end

--フラグ同期
function OnEvent_550_flags(proxy,param)
	print("OnEvent_550_flags begin");
	proxy:SetEventFlag( 556, false );	
--~ 	if param:GetParam2() == 1 then
--~ 		proxy:SetEventFlag( 551, false );
--~ 	else
--~ 		proxy:SetEventFlag( 551, true );
--~ 	end	
	print("OnEvent_550_flags end");
end

function OnEvent_544_In(proxy,param) proxy:SetColiEnable( 10000 , false ); end
function OnEvent_544_Out(proxy,param) proxy:SetColiEnable( 10000 , true ); end
function OnEvent_545_In(proxy,param) proxy:SetColiEnable( 10000 , false ); end
function OnEvent_545_Out(proxy,param) proxy:SetColiEnable( 10000 , true ); end


--[[------------------------------------------------------------------------------------
--■552■篭エレベータ2■
--------------------------------------------------------------------------------------]]
--■552■篭エレベータ2■
function OnEvent_552_1(proxy,param)
	print("OnEvent_552_1 begin");
	
	--アニメ再生中なら終了
	if proxy:IsCompleteEvent(557) == true then
		return;
	end
	
	--下なら終了
	if proxy:IsCompleteEvent(553) == true then
		return;
	end
	
	proxy:SetEventFlag( 557, true );
	--上セットか下セットかは最終で決める
	proxy:SetEventFlag( 553, true );
	
	lift_PlayAnimation(proxy, 1252, 1253, 1 );
--[[	
	--本人以外はオブジェのアニメ再生のみ
	if param:IsNetMessage() == true then
		return;
	end
]]	
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnObjAnimEnd( 552, 1252, 1, "OnEvent_552_animEnd", once );
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_552_1 end");
end
function OnEvent_552_2(proxy,param)
	print("OnEvent_552_2 begin");
	
	--アニメ再生中なら終了
	if proxy:IsCompleteEvent(557) == true then
		return;
	end
	--上なら終了
	if proxy:IsCompleteEvent(553) == false then
		return;
	end
	
	proxy:SetEventFlag( 557, true );
	--上セットか下セットは最終で決める
	proxy:SetEventFlag( 553, false );
	
	lift_PlayAnimation(proxy, 1252, 1253, 2 );
--[[	
	--本人以外はオブジェのアニメ再生のみ
	if param:IsNetMessage() == true then
		return;
	end
]]
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnObjAnimEnd( 552, 1252, 2, "OnEvent_552_animEnd", once );
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_552_2 end");
end

function OnEvent_552_animEnd(proxy,param)
	if proxy:IsClient() == false then
		print("OnEvent_552_animEnd begin");
		
		if proxy:IsCompleteEvent( 553 ) == true then
			proxy:CustomLuaCallStart( 552, 1 );
		else
			proxy:CustomLuaCallStart( 552, 0 );		
		end

		print("OnEvent_552_animEnd end");
	end
end

--フラグの同期
function OnEvent_552_flags(proxy,param)
	print("OnEvent_552_flags begin");
	proxy:SetEventFlag( 557, false );
	
--~ 	if param:GetParam2() == 1 then
--~ 		proxy:SetEventFlag( 553, false );
--~ 	else
--~ 		proxy:SetEventFlag( 553, true );
--~ 	end
	
	print("OnEvent_552_flags end");
end

function OnEvent_546_In(proxy,param) proxy:SetColiEnable( 10000 , false ); end
function OnEvent_546_Out(proxy,param) proxy:SetColiEnable( 10000 , true ); end
function OnEvent_547_In(proxy,param) proxy:SetColiEnable( 10000 , false ); end
function OnEvent_547_Out(proxy,param) proxy:SetColiEnable( 10000 , true ); end

--[[------------------------------------------------------------------------------------
--■554■篭エレベータ1■
--------------------------------------------------------------------------------------]]
--■554■篭エレベータ1■
function OnEvent_554_1(proxy,param)
	print("OnEvent_554_1 begin");	
	
	--アニメ再生中なら終了
	if proxy:IsCompleteEvent(558) == true then
		return;
	end
	
	if proxy:IsCompleteEvent(555) == true then
		return;
	end
	
	proxy:SetEventFlag( 558, true );
	--上セットか下セットかは後で決める
	proxy:SetEventFlag( 555, true );
	
	lift_PlayAnimation(proxy, 1254, 1255, 1 );
--[[	
	--本人以外はオブジェのアニメ再生のみ
	if param:IsNetMessage() == true then
		return;
	end
]]	
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnObjAnimEnd( 554, 1254, 1, "OnEvent_554_animEnd", once );
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_554_1 end");
end

function OnEvent_554_2(proxy,param)
	print("OnEvent_554_2 begin");
	
	--アニメ再生中なら終了
	if proxy:IsCompleteEvent(558) == true then
		return;
	end
	
	if proxy:IsCompleteEvent(555) == false then
		return;
	end
	
	proxy:SetEventFlag( 558, true );
	--上セットか下セットかは後で決める
	proxy:SetEventFlag( 555, false );
	
	lift_PlayAnimation(proxy, 1254, 1255, 2 );
--[[	
	--本人以外はオブジェのアニメ再生のみ
	if param:IsNetMessage() == true then
		return;
	end
]]	
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnObjAnimEnd( 554, 1254, 2, "OnEvent_554_animEnd", once );
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_554_2 end");
end

function OnEvent_554_animEnd(proxy,param)
	if proxy:IsClient() == false then
		print("OnEvent_554_animEnd begin");		
		
		if proxy:IsCompleteEvent( 555 ) == true then
			proxy:CustomLuaCallStart( 554, 1);
		else
			proxy:CustomLuaCallStart( 554, 0);
		end
		print("OnEvent_554_animEnd end");
	end
end

--フラグ同期
function OnEvent_554_flags(proxy,param)
	print("OnEvent_554_flags begin");
	proxy:SetEventFlag( 558, false );
--~ 	if param:GetParam2() == 1 then
--~ 		proxy:SetEventFlag( 555, false );
--~ 	else
--~ 		proxy:SetEventFlag( 555, true );
--~ 	end
	print("OnEvent_554_flags end");
end


function OnEvent_548_In(proxy,param) proxy:SetColiEnable( 10000 , false ); end
function OnEvent_548_Out(proxy,param) proxy:SetColiEnable( 10000 , true ); end
function OnEvent_549_In(proxy,param) proxy:SetColiEnable( 10000 , false ); end
function OnEvent_549_Out(proxy,param) proxy:SetColiEnable( 10000 , true ); end

--[[------------------------------------------------------------------------------------
--■篭エレベータ用処理まとめ■
--------------------------------------------------------------------------------------]]
--[[------------------------------------------------------------------------------------
--■篭エレベータのアニメをセットで指定■
--------------------------------------------------------------------------------------]]
function lift_PlayAnimation(proxy,obj1, obj2, set_anime )
	--obj1昇り、obj2下り
	if set_anime == 1 then
		proxy:PlayAnimation( obj1, 1 );
		proxy:PlayAnimation( obj2, 2 );
	end
	
	--obj1下り、obj2昇り
	if set_anime == 2 then
		proxy:PlayAnimation( obj1, 2 );
		proxy:PlayAnimation( obj2, 1 );
	end
end





--[[------------------------------------------------------------------------------------
--■560■ユルトを助ける(会話から呼び出し)
--------------------------------------------------------------------------------------]]
--■560■ユルトを助ける(会話から呼び出し)
function OnEvent_560(proxy,param)
	if proxy:IsLand( 10000 ) == true then
		print("OnEvent_560 begin");
		
		--ユルトのロジックをONにする
		proxy:EnableLogic( 644, true );
		
		--エレベータ開くアニメ
		proxy:PlayAnimation( 1254, 7);
		
		--ヒットパーツを消す
		proxy:SetColiEnable( 1310, false );

		--ユルト完全無敵解除
		proxy:EnableInvincible( 644, false );
		
		--フラグをセット
		proxy:SetEventFlag( 560, true );
		
		--ユルトの状態を「石柱に行く前」に設定
		SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STANDBY_M1 );
		
		--ボス撃破数を記憶
		GetBossFlagCount(proxy,param);
		proxy:SetBossCount( boss_flagCount );
		
		--プレイヤが開けるアニメ再生
		if	Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
			return;
		end
		
		proxy:WarpDmy( LOCAL_PLAYER, 1254, 191 );
		
		proxy:SetEventFlag( 602 , true );
		
		print("OnEvent_560 end");
	end
end

--[[------------------------------------------------------------------------------------
--■561■会話でエレベータ移動
--------------------------------------------------------------------------------------]]
--■561■会話でエレベータ移動
function OnEvent_561(proxy,param)
	print("OnEvent_561 begin");
	
	if	proxy:IsCompleteEvent( 561 ) == true or
		proxy:IsCompleteEvent( 562 ) == true then
		return;
	end
	
	--NPCでアニメ開始を全員に配信
	proxy:LuaCallStart( 561, 2 );
	
	--ヒットパーツを消す
	proxy:SetColiEnable( 1310, false );
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 561, "OnEvent_561_1", 12.0, 0, 2, once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 561, true );
	print("OnEvent_561 end");
end

function OnEvent_561_1(proxy,param)
	print("OnEvent_561_1 begin");
	
	SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STANDBY_M1 );
	
	
	InvalidCharactor( proxy, 644 );
	
	--重力OFF
	proxy:SetDisableGravity( 644, true );
	
	print("OnEvent_561_1 end");
end

function OnEvent_561_call(proxy,param)
	print("OnEvent_561_call begin");
	--アニメ再生中なら終了
	if proxy:IsCompleteEvent(558) == true then
		return;
	end
	
	if proxy:IsCompleteEvent(555) == true then
		return;
	end
	
	proxy:SetEventFlag( 558, true );
	proxy:SetEventFlag( 555, true );
	
	proxy:PlayAnimation( 1254, 3 );
	proxy:PlayAnimation( 1255, 4 );
	
	--本人以外はオブジェのアニメ再生のみ
	if param:IsNetMessage() == true then
		return;
	end
	
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnCharacterAnimEnd( 554, 1254, 1, "OnEvent_554_animEnd", once );
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	print("OnEvent_561_call end");
end


--[[------------------------------------------------------------------------------------
--■562■ユルト(敵対：牢城)
--------------------------------------------------------------------------------------]]
--■562■ユルト(敵対：牢城)
function OnEvent_562(proxy,param)
	print("OnEvent_562 begin");
	proxy:EnableLogic(644, true);
	SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STATE_ANGRY_M4 );
	proxy:SetTeamType( 644, TEAM_TYPE_AngryFriend );
	
	proxy:SetEventFlag( 562, true );
	print("OnEvent_562 end");
end

--[[------------------------------------------------------------------------------------
--■563■ユルト(死亡)
--------------------------------------------------------------------------------------]]
--■563■ユルト(死亡)
function OnEvent_563(proxy,param)
	print("OnEvent_563 begin");
	SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STATE_DEAD );
	
	--NPCでアニメ開始を全員に配信
	--proxy:LuaCallStart( 561, 2 );
	--ヒットパーツを消す
	proxy:SetColiEnable( 1310, false );
	
	--proxy:DeleteEvent( 561 );
	--proxy:DeleteEvent( 562 );
	proxy:SetEventFlag( 563, true );
	print("OnEvent_563 end");
end

--ユルトの死体を調べた
function OnEvent_15630(proxy,param)
	print("OnEvent_15630 begin");
	proxy:SetEventFlag( 15630 , true );
	print("OnEvent_15630 end");
end

--ユルト特性死体再現
function OnEvent_15630_OpeningDead(proxy,param)
	print("OnEvent_15630_OpeningDead begin");
		--死体を再現する
		proxy:OpeningDeadPlus( 644 , true ,false ,false );
	print("OnEvent_15630_OpeningDead end");
end

--------------------------------------------------------------------------------------
--【鉱石の精霊】死亡■611
--------------------------------------------------------------------------------------
--【鉱石の精霊】死亡■611
function OnEvent_611(proxy,param)
	print("OnEvent_611 begin");
	
	--フラグON
	proxy:SetEventFlag( 611, true );
	
	print("OnEvent_611 end");
end


--------------------------------------------------------------------------------------
--■8020■鉱石の精霊からアイテム取得■
--------------------------------------------------------------------------------------
function OnEvent_8020(proxy,param)
	print("OnEvent_8020 begin");
	proxy:SetEventFlag( 8020 , true );
	print("OnEvent_8020 end");
end





--------------------------------------------------------------------------------------
--■640～659■ムカデ切断■
--------------------------------------------------------------------------------------
local BIT_1 =   1;
local BIT_2 =   2;
local BIT_3 =   4;
local BIT_4 =   8;
local BIT_5 =  16;
local BIT_6 =  32;
local BIT_7 =  64;
local BIT_8 = 128;

function MukadeRegist(proxy)
	--OnEvent_640,OnEvent_641,OnEvent_642,OnEvent_643,OnEvent_644,OnEvent_645,OnEvent_646,OnEvent_647,OnEvent_648,OnEvent_649,
	--OnEvent_650,OnEvent_651,OnEvent_652,OnEvent_653,OnEvent_654,OnEvent_655,OnEvent_656,OnEvent_657,OnEvent_658,OnEvent_659
	--OnEvent_660,OnEvent_661,OnEvent_662
	local Mukade_acid_list 		= {  640,  641,  642,  643,  644,  645,  646,  647,  648,  649,  650,  651,  652,  653,  654,  655,  656,  657,  658,  659,  660,  661,  662};
	local Mukade_main_evid_list = {  230,  231,  232,  233,  234,  235,  236,  237,  250,  251,  252,  253,  254,  255,  256,  257,  258,  259,  260,  261,  221,  222,  223};
	local Mukade_sub_evid_list 	= {  240,  241,  242,  243,  244,  245,  246,  247,  270,  271,  272,  273,  274,  275,  276,  277,  278,  279,  280,  281,  224,  225,  226};
	local Mukade_event_num = table.getn(Mukade_acid_list);
	for index = 1, Mukade_event_num, 1 do
		local acid		= Mukade_acid_list[index];
		local main_evid = Mukade_main_evid_list[index];
		local sub_evid	= Mukade_sub_evid_list[index];
		SingleReset( proxy, acid );
		if	proxy:IsCompleteEvent( acid ) == false then
			proxy:OnCharacterTotalRateDamage( acid, main_evid,  -1, 0.5, "OnEvent_"..acid, once );
			proxy:OnCheckEzStateMessage( acid, main_evid, "OnEvent_"..acid.."_1", 500 );
			InvalidCharactor( proxy, sub_evid );
		end
	end
end


function OnEvent_640(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 230);		end
function OnEvent_640_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 230, 240);	end
function OnEvent_641(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 231);		end
function OnEvent_641_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 231, 241);	end
function OnEvent_642(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 232);		end
function OnEvent_642_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 232, 242);	end
function OnEvent_643(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 233);		end
function OnEvent_643_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 233, 243);	end
function OnEvent_644(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 234);		end
function OnEvent_644_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 234, 244);	end
function OnEvent_645(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 235);		end
function OnEvent_645_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 235, 245);	end
function OnEvent_646(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 236);		end
function OnEvent_646_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 236, 246);	end
function OnEvent_647(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 237);		end
function OnEvent_647_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 237, 247);	end
function OnEvent_648(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 250);		end
function OnEvent_648_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 250, 270);	end
function OnEvent_649(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 251);		end
function OnEvent_649_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 251, 271);	end


function OnEvent_650(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 252);		end
function OnEvent_650_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 252, 272);	end
function OnEvent_651(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 253);		end
function OnEvent_651_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 253, 273);	end
function OnEvent_652(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 254);		end
function OnEvent_652_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 254, 274);	end
function OnEvent_653(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 255);		end
function OnEvent_653_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 255, 275);	end
function OnEvent_654(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 256);		end
function OnEvent_654_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 256, 276);	end
function OnEvent_655(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 257);		end
function OnEvent_655_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 257, 277);	end
function OnEvent_656(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 258);		end
function OnEvent_656_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 258, 278);	end
function OnEvent_657(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 259);		end
function OnEvent_657_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 259, 279);	end
function OnEvent_658(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 260);		end
function OnEvent_658_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 260, 280);	end
function OnEvent_659(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 261);		end
function OnEvent_659_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 261, 281);	end

function OnEvent_660(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 221);		end
function OnEvent_660_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 221, 224);	end
function OnEvent_661(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 222);		end
function OnEvent_661_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 222, 225);	end
function OnEvent_662(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 223);		end
function OnEvent_662_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 223, 226);	end


function MukadeFunc_CutRequest(proxy,param,acid,main_evid)
	print("OnEvent_"..acid.." begin");
	proxy:SetEventCommand( main_evid, 600 );
	print("OnEvent_"..acid.." end");
end

function MukadeFunc_CutAction(proxy,param,acid,main_evid,sub_evid)
	if	proxy:IsCompleteEvent( acid ) == true then
		return;
	end
	print("OnEvent_"..acid.."_1 begin");
	proxy:SetEventFlag( acid, true );
	proxy:SetDispMask( main_evid, BIT_1 + BIT_3 + BIT_5 + BIT_7 );
	proxy:SetDispMask(  sub_evid, BIT_2 + BIT_4 + BIT_6 + BIT_8 );
	proxy:SetHitMask( main_evid, BIT_2 );
	proxy:SetHitMask(  sub_evid, BIT_1 );
	
	proxy:SendEventRequest( main_evid,0,1);
	ValidCharactor( proxy, sub_evid );
	proxy:CharactorCopyPosAng( main_evid, sub_evid );
	proxy:OpeningDead( sub_evid, false );
	
	print("OnEvent_"..acid.."_1 end");
end






--■700■要石の光が消える■
function OnEvent_700_1(proxy,param)
	print("OnEvent_700_1 begin");
	proxy:TreasureDispModeChange2( 1982 , false ,KANAME_SFX);
	proxy:InvalidSfx( 2231 , true );--要石のオーラ
	print("OnEvent_700_1 end");
end

--■700■要石の光が復活する■
function OnEvent_700_2(proxy,param)
	print("OnEvent_700_2 begin");
	proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);
	proxy:ValidSfx( 2231 );--要石のオーラ
	print("OnEvent_700_2 end");
end



--■580,581,582,583■昇降版制御

function OnEvent_580_1(proxy,param)
	--print("OnEvent_580_1 begin");
	proxy:LuaCallStart( 580, 2 );
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(580,"OnEvent_580_1_time",1.0,0,5,once);
	proxy:NotNetMessage_end();
	--print("OnEvent_580_1 end");
end

--時間差
function OnEvent_580_1_time(proxy,param)
	proxy:NotNetMessage_begin();
		proxy:OnCharacterAnimEndPlus(580, 1330, 2, "OnEvent_580_2", once );
	proxy:NotNetMessage_end();
end

function OnEvent_580_2(proxy,param)
	--print("OnEvent_580_2 begin");
	proxy:LuaCallStart( 580, 1 );
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(580,"OnEvent_580_2_time",1.0,0,5,once);		
	proxy:NotNetMessage_end();
	--print("OnEvent_580_2 end");
end

--時間差
function OnEvent_580_2_time(proxy,param)
	proxy:NotNetMessage_begin();
		proxy:OnCharacterAnimEndPlus(580, 1330, 1, "OnEvent_580_1", once );
	proxy:NotNetMessage_end();
end



function OnEvent_580_1_call(proxy,param)
	--print("OnEvent_580_1_call ");
	proxy:PlayAnimation( 1330, 1 );
	proxy:SetEventFlag( 581, true );
	--print("OnEvent_580_1_call end");
end

function OnEvent_580_2_call(proxy,param)
	--print("OnEvent_580_2_call ");
	proxy:PlayAnimation( 1330, 2 );
	proxy:SetEventFlag( 581, false );
	--print("OnEvent_580_2_call end");
end



function OnEvent_582_1(proxy,param)
	--print("OnEvent_582_1 begin");
	proxy:LuaCallStart( 582, 2 );
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 582 , "OnEvent_582_1_time",1.0,0,2,once );		
	proxy:NotNetMessage_end();
	--print("OnEvent_582_1 end");
end

--時間差
function OnEvent_582_1_time(proxy,param)
	proxy:NotNetMessage_begin();
	proxy:OnCharacterAnimEndPlus(582, 1331, 2, "OnEvent_582_2", once );
	proxy:NotNetMessage_end();
end


function OnEvent_582_2(proxy,param)
	--print("OnEvent_582_2 begin");
	proxy:LuaCallStart( 582, 1 );
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 582 , "OnEvent_582_2_time",1.0,0,6,once );		
	proxy:NotNetMessage_end();
	--print("OnEvent_582_2 end");
end

--時間差
function OnEvent_582_2_time(proxy,param)
	proxy:NotNetMessage_begin();
		proxy:OnCharacterAnimEndPlus(582, 1331, 1, "OnEvent_582_1", once );
	proxy:NotNetMessage_end();
end


function OnEvent_582_1_call(proxy,param)
	--print("OnEvent_582_1_call ");
	proxy:PlayAnimation( 1331, 1 );
	proxy:SetEventFlag( 583, true );
	--print("OnEvent_582_1_call end");
end

function OnEvent_582_2_call(proxy,param)
	--print("OnEvent_582_2_call ");
	proxy:PlayAnimation( 1331, 2 );
	proxy:SetEventFlag( 583, false );
	--print("OnEvent_582_2_call end");
end


function OnEvent_568(proxy,param)
	print("OnEvent_568 begin");
	proxy:ResetThink( 644 );
	--移動タイプを往復に変更
	proxy:SetEventMovePointType( 644, POINT_MOVE_TYPE_Randum );
	--移動ポイントを変更
	local point_list = {2250, 2251, 2252, 2253};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--移動ポイントを設定
		proxy:AddCustomRoutePoint(644, point_list[index]);
	end
	print("OnEvent_568 end");
end

function OnEvent_569(proxy,param)
	print("OnEvent_569 begin");
	proxy:ResetThink( 644 );
	proxy:SetDefaultRoutePoint( 644 );
	print("OnEvent_569 end");
end


--------------------------------------------------------------------------------------
--■590■ガーゴイル1動き出す■
--------------------------------------------------------------------------------------
function OnEvent_590(proxy,param)
	print("OnEvent_590 begin");
	proxy:PlayAnimation( 413, 9010 );
	proxy:SetSpStayAndDamageAnimId( 413 , -1,-1);
	proxy:ResetThink( 413 );
	proxy:SetEventFlag( 590 , true );
	print("OnEvent_590 end");
end


--------------------------------------------------------------------------------------
--■591■ガーゴイル2動き出す■
--------------------------------------------------------------------------------------
function OnEvent_591(proxy,param)
	print("OnEvent_591 begin");
	proxy:PlayAnimation( 411, 9010 );
	proxy:SetSpStayAndDamageAnimId( 411 , -1,-1);
	proxy:ResetThink( 411 );
	proxy:SetEventFlag( 591 , true );
	print("OnEvent_591 end");
end


--------------------------------------------------------------------------------------
--■592■ガーゴイル3動き出す■
--------------------------------------------------------------------------------------
function OnEvent_592(proxy,param)
	print("OnEvent_592 begin");
	proxy:PlayAnimation( 412, 9010 );
	proxy:SetSpStayAndDamageAnimId( 412 , -1,-1);
	proxy:ResetThink( 412 );
	proxy:SetEventFlag( 592 , true );
	print("OnEvent_592 end");
end


--------------------------------------------------------------------------------------
--■601■鉄の板の先に進んだ■
--------------------------------------------------------------------------------------
function OnEvent_601(proxy,param)
	print("OnEvent_601 begin");
	proxy:SetEventFlag( 601 , true );
	print("OnEvent_601 end");
end


--------------------------------------------------------------------------------------
--■597■もやSFX領域に入った■
--------------------------------------------------------------------------------------
function OnEvent_597(proxy,param)
	print("OnEvent_597 begin");
	--カメラSFXを表示
	proxy:CreateCamSfx( 94200 , 0 );
	print("OnEvent_597 end");
end


--------------------------------------------------------------------------------------
--■601■もやSFX領域からでた■
--------------------------------------------------------------------------------------
function OnEvent_598(proxy,param)
	print("OnEvent_598 begin");
	--カメラSFXを削除
	proxy:DeleteCamSfx( 0 );
	print("OnEvent_598 end");
end
