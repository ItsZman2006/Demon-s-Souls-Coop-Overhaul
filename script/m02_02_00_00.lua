
--火藁蹴り落としのダメージ球半径
DAMAGE_RADIUS = 1.3;

--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■
--------------------------------------------------------------------------------------
function Initialize_m02_02_00_00(proxy)
	print("Initialize_m02_02_00_00 begin");
	

--■1040■レバーで城門を開放する■
	if proxy:IsCompleteEvent( 1040 ) ==false then
		
		--proxy:LuaCall( 1041, 1, "OnEvent_1041", everytime );
		--proxy:NotNetMessage_begin();
			--ポリ劇開始フェード後に呼ばれるハンドラ
			--proxy:LuaCall(1041,REMO_START,"OnEvent_1041_RemoStart",once);
			--ポリ劇終了後に呼ばれるハンドラ
			--proxy:LuaCall(1041,REMO_FINISH,"OnEvent_1041_RemoFinish",once);
		--proxy:NotNetMessage_end();
		
		proxy:OnDistanceAction( 1040, 10000, 1450, "OnEvent_1040", LeverDist_A, HELPID_PULL_LEVER, 0, LeverAngle_A, once);
	else
		proxy:EndAnimation( 1450, 1 );--レバーアニメを終了
		proxy:EndAnimation( 1440, 1 );--正門が開くアニメを終了
	end
	
	
	
--■1051■敵が落ちてくる2■
	if proxy:IsCompleteEvent( 1051 ) ==false then
		proxy:OnRegionJustIn( 1051 , 10000 , 2451 , "OnEvent_1051" , once );
		proxy:OnSimpleDamage( 1051 , 423 , 10000 , "OnEvent_1051_0_1" , once );--ID423 ひとりなのでID同じ
	end
	

--■1070■荷馬車がガタガタ1■
	--(Second_Initializeでハンドラを呼ぶ)
	
--■1071■荷馬車がガタガタ2■
	--(Second_Initializeでハンドラを呼ぶ)
	
	

--■1079■荷馬車が落ちてくる■
	if proxy:IsCompleteEvent( 1079 ) == false then
		proxy:OnRegionJustIn( 1079 , 10000 , 2470 , "OnEvent_1079" , once );
	else
		proxy:EndAnimation( 1490 , 1 );--荷馬車のアニメ終了
		proxy:SetColiEnable( 1490 , false );--荷馬車のアタリOFF
		proxy:EndAnimation( 1495 , 1 );--藁のアニメ終了
	end


	
--■1082■扉が閉まるポリ劇再生■
	if proxy:IsCompleteEvent( 1082 ) == false then
		proxy:OnRegionJustIn( 1082 , 10000 , 2472 , "OnEvent_1082" , once );
	
		proxy:NotNetMessage_begin();
			--ポリ劇終了後に呼ばれるハンドラ
			proxy:LuaCall(1082,REMO_FINISH,"OnEvent_1082_RemoFinish",once);
			--ポリ劇開始時に呼ばれるハンドラ
			proxy:LuaCall(1082,REMO_START,"OnEvent_1082_RemoStart",once);
		proxy:NotNetMessage_end();
		
		--扉閉まるポリ劇前に攻撃したら 強制ポリ劇再生用のダメージ監視
		proxy:OnSimpleDamage( 1082 , 452 , 10000 , "OnEvent_1082" , once );--獄吏
		--proxy:OnSimpleDamage( 1082 , 405 , 10000 , "OnEvent_1082" , once );--兵士
		proxy:OnSimpleDamage( 1082 , 406 , 10000 , "OnEvent_1082" , once );
		proxy:OnSimpleDamage( 1082 , 407 , 10000 , "OnEvent_1082" , once );
		proxy:OnSimpleDamage( 1082 , 408 , 10000 , "OnEvent_1082" , once );
		InvalidCharactor( proxy, 405 );
	else
		proxy:EndAnimation( 1440 , 2 );--正門が閉じるアニメ再生
		InvalidCharactor( proxy, 405 );
	end

	--[[
--■1065■獄吏Aの巣を変える(扉の奥のほうへ走らせる)■
	if proxy:IsCompleteEvent( 1065 ) == false then
		proxy:OnRegionJustIn( 1065 , 10000 , 2515 , "OnEvent_1065" , once );
	end
	]]	

--■1115■チェックポイント1(扉を開けるイベントのためのもの)■
	if proxy:IsCompleteEvent( 1115 ) == false then
		proxy:OnRegionJustIn( 1115 , 10000 , 2473 , "OnEvent_1115" , once );
	end

	

--■1085■細い路地の扉が急に開く■
	if proxy:IsCompleteEvent( 1085 ) == false then
		proxy:OnRegionIn( 1085 , 10000 , 2474 , "OnEvent_1085_check_1" , everytime );--チェックポイント通過したとき用
		proxy:OnRegionIn( 1085 , 10000 , 2475 , "OnEvent_1085_check_2" , everytime );--ポリ劇見た後用
		proxy:OnObjectDestroy( 1085 , 1530 , "OnEvent_1085" , once );--オブジェが破壊された時用
	end

	
--■1086■細い路地から敵が飛び出してくる■
	if proxy:IsCompleteEvent( 1086 ) == false then
		proxy:OnRegistFunc( 1086 , "Check_OnEvent_1086" , "OnEvent_1086" , 1 , once );
	end

	
--■1088■獄吏の指示で弓兵が弓を撃ってくる■
	if proxy:IsCompleteEvent( 1088 ) == false then
		proxy:OnRegionJustIn( 1088 , 10000 , 2476 , "OnEvent_1088" , everytime );
		proxy:OnSimpleDamage( 1088 , 451 , 10000 , "OnEvent_1088" , once );--獄吏(2匹目)
		proxy:OnSimpleDamage( 1088 , 410 , 10000 , "OnEvent_1088" , once );--弓兵
		proxy:OnSimpleDamage( 1088 , 411 , 10000 , "OnEvent_1088" , once );
		proxy:OnSimpleDamage( 1088 , 412 , 10000 , "OnEvent_1088" , once );
		proxy:OnSimpleDamage( 1088 , 413 , 10000 , "OnEvent_1088" , once );
		proxy:OnSimpleDamage( 1088 , 414 , 10000 , "OnEvent_1088" , once );
	end

	
--■1270■獄吏の指示で弓兵が弓を撃ってくる2■
	if proxy:IsCompleteEvent( 1271 ) == false then
		SingleReset( proxy, 1270 );
	end
	
	if proxy:IsCompleteEvent( 1270 ) == false then
		proxy:OnRegionJustIn( 1270 , 10000 , 2440 , "OnEvent_1270" , everytime );
		proxy:OnSimpleDamage( 1270 , 453 , 10000 , "OnEvent_1270" , once );--獄吏(3匹目)
		proxy:OnSimpleDamage( 1270 , 480 , 10000 , "OnEvent_1270" , once );--弓兵
		proxy:OnSimpleDamage( 1270 , 481 , 10000 , "OnEvent_1270" , once );
		proxy:OnSimpleDamage( 1270 , 482 , 10000 , "OnEvent_1270" , once );
		
		--▼獄吏(453)が逃げるポリ劇▼
		proxy:NotNetMessage_begin();
			--ポリ劇終了後に呼ばれるハンドラ
			proxy:LuaCall(1271,REMO_FINISH,"OnEvent_1271_RemoFinish",once);
			--ポリ劇開始時に呼ばれるハンドラ
			proxy:LuaCall(1271,REMO_START,"OnEvent_1271_RemoStart",once);
		proxy:NotNetMessage_end();	
	end
	
	

--■1280■獄吏1 死亡チェック■	
	if proxy:IsCompleteEvent( 1280 ) == false then
		proxy:OnCharacterDead( 1280 , 451 , "OnEvent_1280" , once );
	end
	
--■15621■獄吏1の死体を調べた■
	if proxy:IsCompleteEvent( 15621 ) == false then
		proxy:AddCorpseEvent( 15621 , 451 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15621 ,0 , "OnEvent_15621",once );
 		proxy:NotNetMessage_end();
	end
	
--■1281■獄吏2 死亡チェック■	
	if proxy:IsCompleteEvent( 1281 ) == false then
		proxy:OnCharacterDead( 1281 , 452 , "OnEvent_1281" , once );
	end
	
--■15620■獄吏2の死体を調べた■
	if proxy:IsCompleteEvent( 15620 ) == false then
		proxy:AddCorpseEvent( 15620 , 452 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15620 ,0 , "OnEvent_15620",once );
 		proxy:NotNetMessage_end();
	end
	
--■1282■獄吏3 死亡チェック■	
	if proxy:IsCompleteEvent( 1282 ) == false then
		proxy:OnCharacterDead( 1282 , 453 , "OnEvent_1282" , once );
	end


--■1200■サブイベント扉■
	if proxy:IsCompleteEvent( 1200 ) == false then--まだ扉は開いていない　かつ
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 1200, 10000, 1460, "OnEvent_1200", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 1200, 1, "OnEvent_1200_1", once );--アニメーション同期用		
	else
		proxy:EndAnimation( 1460, 1 );
	end

	
--■1201■サブイベント扉■
	if proxy:IsCompleteEvent( 1201 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 1201, 10000, 1461, "OnEvent_1201", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 1201, 1, "OnEvent_1201_1", once );--アニメーション同期用		
	else
		proxy:EndAnimation( 1461, 1 );
	end


--■1034■ボス部屋に入る■
	
	--中ボスが生きているときだけイベント登録
	if proxy:IsCompleteEvent( 4360 ) == false then
	
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。
		SingleReset(proxy, 1034);
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き)
		proxy:LuaCall( 1035, 1, "OnEvent_1035_1", everytime );
		--▽2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCall( 1035 , 5 , "OnEvent_1034_GO_TO_IN" , everytime );
		--▽フラグセット(同期用)
		proxy:LuaCall( 1035 , 6 , "OnEvent_1034_flag_set" , everytime );

		--誰かがボス前扉をまだ通過していない
		if proxy:IsCompleteEvent( 1034 ) == false then
		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--▼1034▼中に入るためのイベントを追加▼
				proxy:OnPlayerActionInRegionAttribute( 1034, 2893, "OnEvent_1034", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --グレイゴーストできたときようにいると思われる。
		
			proxy:NotNetMessage_begin();
				--▼1035▼中に入るためのイベントを追加▼--ハンドラは上と同じ
				proxy:OnPlayerActionInRegion( 1035, 2893, "OnEvent_1034", HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		
		end
		proxy:SetColiEnableArray(3007,false);--通常無効
		proxy:SetColiEnableArray(3008,false);--通常無効
		proxy:SetColiEnableArray(3009,true);--ボス用有効
		proxy:SetColiEnableArray(3011,true);--ボス用有効
	else
		proxy:SetColiEnableArray(3007,true);--通常有効
		proxy:SetColiEnableArray(3008,true);--通常有効
		proxy:SetColiEnableArray(3009,false);--ボス用無効
		proxy:SetColiEnableArray(3011,false);--ボス用無効
	end
	

--■1036■ボスのポリ劇再生■

	if proxy:IsCompleteEvent( 1036 ) == false then 
	
		--▼ボス前のポリ劇再生用監視追加
		proxy:OnRegionJustIn( 1036 , 10000 , 2897 , "OnEvent_1036" , once );
		
		proxy:NotNetMessage_begin();
			--ポリ劇開始に呼ばれるハンドラ
			proxy:LuaCall(1036, REMO_START, "OnEvent_1036_RemoStart", once);
			--ポリ劇終了後に呼ばれるハンドラ(トリガー起こした人用)
			proxy:LuaCall(1036, REMO_FINISH, "OnEvent_1036_RemoFinish", once);
		proxy:NotNetMessage_end();
	
	end
			

--■1037■ボス戦闘開始■	
	if proxy:IsCompleteEvent( 4360 ) == false then
		SingleReset( proxy , 1430 );
		proxy:OnRegionJustIn( 1037 , 10000 , 2885 , "OnEvent_1037" , once );
	end

	
--■4360■中ボス死亡で扉が開く■(中ボスの死亡監視)
	proxy:AddFieldInsFilter( 802 );
	if proxy:IsCompleteEvent( 4360 ) ==false then
		proxy:NotNetMessage_begin();
			proxy:OnCharacterDead(4360, 802, "OnEvent_4360", once);
		proxy:NotNetMessage_end();
	end


--■??■徘徊デーモンの登場■ハンドラ登録
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。
		proxy:LuaCall( 4000, 100, "PlayerDeath_m02_02_00_00", everytime );
		--プレイヤーが復活した時にキックされます。
		proxy:LuaCall( 4032, 100, "PlayerRevive_m02_02_00_00", everytime );
	proxy:NotNetMessage_end();
	

--■1210■ハシゴ1降り■PCがイベントエリア(2530)の中に居て、アクションボタンを押したとき--
	proxy:OnActionEventRegion(1210, 2530, "OnEvent_1210", LadderAngle_A, HELPID_DOWN, everytime);
--■1211■ハシゴ1昇り■PCがイベントエリア(2531)の中に居て、アクションボタンを押したとき--
	proxy:OnActionEventRegion(1211, 2531, "OnEvent_1211", LadderAngle_A, HELPID_UP,   everytime);


--■1212■ハシゴ2降り■PCがイベントエリア(2532)の中に居て、アクションボタンを押したとき--
	proxy:OnActionEventRegion(1212, 2532, "OnEvent_1212", LadderAngle_A, HELPID_DOWN, everytime);
--■1213■ハシゴ2昇り■PCがイベントエリア(2533)の中に居て、アクションボタンを押したとき--
	proxy:OnActionEventRegion(1213, 2533, "OnEvent_1213", LadderAngle_A, HELPID_UP,   everytime);

--■1214■ハシゴC降り■PCがイベントエリア(2534)の中に居て、アクションボタンを押したとき--
	proxy:OnActionEventRegion(1214, 2534, "OnEvent_1214", LadderAngle_A, HELPID_DOWN, everytime);
--■1215■ハシゴC昇り■PCがイベントエリア(2535)の中に居て、アクションボタンを押したとき--
	proxy:OnActionEventRegion(1215, 2535, "OnEvent_1215", LadderAngle_A, HELPID_UP,   everytime);

	
	if proxy:IsCompleteEvent( BIYO_STATE_KING_OF_SWORD_KILL ) == true then
		proxy:EnableLogic( 627, false );--ビヨロジックOFF
		proxy:SetEventCommand( 627, 60 );--EzStateに制御番号(寝る)を渡す
	end	

-- ▼獄吏塔関連のイベント▼ -------------------------------------------

--■1300■幽閉する敵の初期化処理■
--(Second_Initializeに書く)

--■1222■幽閉する敵の死亡チェック■
	SingleReset( proxy, 1222 );
	if proxy:IsCompleteEvent( 1222 ) == false then
		proxy:NotNetMessage_begin();
			proxy:OnCharacterDead( 1222 ,454 , "OnEvent_1222" , once );
		proxy:NotNetMessage_end();
	end
	
--■1220■幽閉する敵が怒る■
	SingleReset( proxy, 1220 );
	--怒ってない＆死んでない
	if proxy:IsCompleteEvent( 1220 ) == false and proxy:IsCompleteEvent( 1222 ) == false then
		
		proxy:NotNetMessage_begin();
			if proxy:IsClient() == false then
				proxy:OnRegionIn( 1220 , 10000 , 2540 , "OnEvent_1220" , everytime );--領域監視
			end
		proxy:NotNetMessage_end();
		
		if proxy:IsCompleteEvent(1225) == true then
			proxy:NotNetMessage_begin();
				proxy:OnSimpleDamage( 1220 , 454 , 10000 , "OnEvent_1220_Damage" , once );--ダメージ監視
			proxy:NotNetMessage_end();			
		end
				
		proxy:LuaCall( 1220 , 1 , "OnEvent_1220_hostile" , once );--幽閉する敵が怒る用
	end
		
--■1225■偽装に成功すると、階段を降ろしてくれる■(領域の監視は1220で行っている)
	if proxy:IsCompleteEvent( 1225 ) == false then
		proxy:LuaCall( 1225 , 1 , "OnEvent_1225" , once );
	else
		proxy:EndAnimation( 1462 , 1 );--レバーアニメ
		proxy:EndAnimation( 1550 , 1 );--階段が降りるアニメ		
	end

	
--■1380■魔女が感謝する■	
--(幽閉する敵の死亡監視:OnEvent_1222 に記述)

--■11500■魔女がアイテムを渡し休憩する■(会話システムから呼び出し)
	if proxy:IsCompleteEvent( 11500 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 11500 , 0 , "OnEvent_11500" , once );
		proxy:NotNetMessage_end();
	end

--■1381■魔女が敵対する■
	if proxy:IsCompleteEvent( 1381 ) == false then
		--proxy:OnCharacterTotalDamage( 1381, 625, 10000, 100, "OnEvent_1381", once );
		proxy:OnCharacterTotalRateDamage( 1381, 625, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1381", once );
	end

--■1382■魔女が死亡する■
	if proxy:IsCompleteEvent( 1382 ) == false then
		proxy:OnCharacterDead( 1382, 625, "OnEvent_1382" , once );  
	end

	--■魔女関連初期化

	--初期状態をセット(状態が未設定の場合、指定した状態をセットする)
	SetFirstNpcStateFlag( proxy , param , majo_flag_list , MAJO_STATE_LIBERATE );
	
	--現在の状態取得
	local now_state = GetNpcStateFlag( proxy , param , majo_flag_list );
	
	--解放してほしい
	if now_state == MAJO_STATE_LIBERATE then
		--proxy:EnableLogic( 625 , false );
	
		--(予約)
	
	--感謝
	elseif now_state == MAJO_STATE_THANKS then
		--proxy:EnableLogic( 625 , false );
	
		--(予約)
	
	--塔で休憩
	elseif now_state == MAJO_STATE_BREAK  then
		--proxy:EnableLogic( 625 , false );

		--(予約)
	
	--敵対
	elseif now_state == MAJO_STATE_HOSTILE then
		--魔女の状態を「敵対」にする。(予約)
		proxy:EnableLogic( 625 , true );		
		proxy:SetTeamType( 625, TEAM_TYPE_AngryFriend );
		
	--死亡
	elseif now_state == MAJO_STATE_DEAD then
		InvalidBackRead( proxy, 625 );--魔女無効化
		
	else
		InvalidBackRead( proxy, 625 );--魔女無効化
		print("魔女は石柱にいるよぉ");
	end
	
-- ▲獄吏塔関連のイベント▲ ---------------------------------------------





-- ▼レンドル王子関連のイベント▼ ----------------------------------------

	
--■1350■レンドル王子を追う敵が出現する1■
	--(1310から連動)
	
--■1351■レンドル王子を追う敵が出現する2■
	--(1350から連動)
	
--■1352■レンドル王子を追う敵が出現する3■
	--(1351から連動)
	
--■1311■王子が袋小路に移動する■

--■1360■レンドル王子を追う敵の巣を変える1■
	--(1311から連動)

--■1361■レンドル王子を追う敵の巣を変える1■
	--(1360から連動)

--■1362■レンドル王子を追う敵の巣を変える1■
	--(1361から連動)

--■1312■王子が袋小路に到着したあとに怯えさせる■

--■1313■王子が感謝する■
	--敵の死亡イベントで追加されまする。参照：(OnEvent_1410_1411_1412)

--■11501■王子が探索を開始する■(会話システムから呼び出し)


--■1315■王子が次のブロックに移動する■
	
--■1410■一般兵士の死亡監視■
	if proxy:IsCompleteEvent( 1410 ) == false then
		proxy:OnCharacterDead( 1410 , 460 , "OnEvent_1410_1411_1412" , once );
	end

--■1411■一般兵士の死亡監視■
	if proxy:IsCompleteEvent( 1411 ) == false then
		proxy:OnCharacterDead( 1411 , 461 , "OnEvent_1410_1411_1412" , once );
	end

--■1412■一般兵士の死亡監視■
	if proxy:IsCompleteEvent( 1412 ) == false then
		proxy:OnCharacterDead( 1412 , 462 , "OnEvent_1410_1411_1412" , once );
	end	
	--proxy:ForceSetOmissionLevel( 621, true, 0 );


-- ▲レンドル王子関連のイベント▲ ----------------------------------------


	
--■1250■燃える藁が転がり落ちてくる1■	
	if proxy:IsCompleteEvent( 1250 ) == false then
		proxy:OnRegionJustIn( 1250 , 10000 , 2400 , "OnEvent_1250" , once );
		proxy:OnSimpleDamage( 1250 , 470 , 10000 , "OnEvent_1250" , once );
	end
	
--■1251■燃える藁が転がり落ちてくる2■	
	if proxy:IsCompleteEvent( 1251 ) == false then
		proxy:OnRegionJustIn( 1251 , 10000 , 2401 , "OnEvent_1251" , once );
		proxy:OnSimpleDamage( 1251 , 471 , 10000 , "OnEvent_1251" , once );
	end	
	
	
	--光の霧を通過できるキャラタイプ(このタイプの人だけアクションボタンが反応する)
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

--■1260■ホストPCのみが通れる光の霧■
	if proxy:IsCompleteEvent( 1260 ) == true then--ホストが通過済み
		proxy:SetDrawEnable( 1560 , false );
		proxy:SetColiEnable( 1560 , false );
		proxy:InvalidSfx( 2425, false );
	else
		--▼1260▼魔法壁削除同期用▼
		proxy:LuaCall( 1260 , 1 , "OnEvent_1260_delete_wall" , once );
		
		--▼1260▼壁の中に入るイベント発動用▼
		proxy:OnDistanceActionAttribute( 1260 , 10000 , 1560 , "OnEvent_1260" , DoorDist_A , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end	

	--座標系の再現(Warpなど)はシングルのときだけ行う
	
	--■1082、1040■正門の開閉■1082 扉が閉まるポリ劇 　1040 扉を開けるレバー
	if proxy:IsCompleteEvent( 1082 ) == false or proxy:IsCompleteEvent( 1040 ) == true then
		proxy:EndAnimation( 1440 , 1 );--正門は開いている
	else
		proxy:EndAnimation( 1440 , 2 );--正門は閉まっている
	end
	
	
--[[■1450,1451,1452■奴隷兵士(ショップNPC)の状態初期化■
	--奴隷兵士が敵対している
	if proxy:IsCompleteEvent( 1440 ) == true and proxy:IsCompleteEvent( 1441 ) == false then
		proxy:EnableLogic( 679 , true );
		SetNpcStateFlag(proxy,param,DOREI_SHOP_Flag_list,DOREI_SHOP_HOSTILE);
		proxy:SetTeamType( 679, TEAM_TYPE_AngryFriend );
		proxy:SetEventFlag( 1451, 1 );
	end
	--奴隷兵士が死亡している
	if proxy:IsCompleteEvent( 1441 ) == true then
		SetNpcStateFlag(proxy,param,DOREI_SHOP_Flag_list,DOREI_SHOP_DEAD);
		proxy:ForceUpdateNextFrame(679);
		InvalidCharactor(proxy, 679 );
		proxy:SetEventFlag( 1452, 1 );
	end
	--奴隷兵士が販売している
	if proxy:IsCompleteEvent( 1440 ) == false and proxy:IsCompleteEvent( 1441 ) == false then
		proxy:EnableLogic( 679 , false );
		SetNpcStateFlag(proxy,param,DOREI_SHOP_Flag_list,DOREI_SHOP_NORMAL);
		proxy:SetEventFlag( 1450, 1 );
	end

--■1440■奴隷兵士(ショップNPC)の状態初期化■
	if proxy:IsCompleteEvent(1440) == false then
		proxy:OnCharacterTotalDamage( 1440, 679, 10000, DOREI_SHOP_TOTALDAMAGE, "OnEvent_1440", once );	
	end
	
--■1441■奴隷兵士(ショップNPC)死亡■
	if proxy:IsCompleteEvent( 1441 ) == false then
		proxy:OnCharacterDead( 1441 , 679 , "OnEvent_1441" , once );
	end
		

]]	

	--■1082 扉が閉まるポリ劇が終わっている
	if proxy:IsCompleteEvent( 1082 ) == true then	
		--ポリ劇を再生したので獄吏ワープ		
		proxy:SetDrawEnable( 452 , true );--ポリ劇中、表示OFFにしていたので戻す
		proxy:ChangeInitPosAng( 452 , 2512 );--巣をワープ先の領域に更新
		proxy:EnableLogic( 452 , true );
		proxy:Warp( 452 , 2512 );--次のポイントへワープ
		
		--兵士405が扉に潰される
		--proxy:Warp( 405 , 2506 );--扉の下にワープ
		--proxy:EnableLogic( 405 , false );--思考OFF
		--proxy:SetColiEnable( 405 , false );--当たりOFF
		--proxy:SetDrawEnable( 405 , true );--ポリ劇中、表示OFFにしていたので戻す
		--proxy:PlayLoopAnimation( 405 , 7020 );--倒れたまま
		--proxy:EnableHide( 405 , true );--探索されない
		--proxy:DisableMapHit( 405, true );--マップ当たり無効(扉の当たりで位置がずれる?ので?)
		--proxy:SetDisableGravity( 405 , true );--重力無効
		--proxy:ForceUpdateNextFrame(405);--次のフレームは強制更新(潰される兵士)		
		
		--他の兵士は無効化
		InvalidCharactor( proxy , 406 );
		InvalidCharactor( proxy , 407 );
		InvalidCharactor( proxy , 408 );
		
		proxy:SetDrawEnable( 1520 , true );--血ダマリ表示

	else--扉閉まるポリ劇が終わっていない
	
		proxy:SetDrawEnable( 1520 , false );--血ダマリ非表示
	
		proxy:EnableLogic( 452 , false ); --獄吏のロジックOFF
		--proxy:EnableLogic( 405 , false ); --兵士のロジックOFF
		proxy:EnableLogic( 406 , false );
		proxy:EnableLogic( 407 , false );
		proxy:EnableLogic( 408 , false );

		proxy:SetDeadMode( 452,true );		
		--proxy:EnableInvincible( 405 , true );--兵士完全無敵
		proxy:EnableInvincible( 406 , true );
		proxy:EnableInvincible( 407 , true );
		proxy:EnableInvincible( 408 , true );
		InvalidCharactor( proxy, 405 );
	end


	--■1051■敵が落ちてくる2■
	
	if proxy:IsCompleteEvent( 1051 ) == false then
		proxy:Warp( 423 , 2455 );--段差の上で
		proxy:EnableLogic( 423 , false );--ロジックOFFで待機
	end
	

	--■1070■荷馬車がガタガタ1■
	
	proxy:Warp( 440 , 2432 );--荷馬車の中にワープ
	proxy:Warp( 441 , 2433 );
	
	proxy:EnableLogic( 440 , false );--ロジックOFF
	proxy:EnableLogic( 441 , false );
	
	proxy:SetIgnoreHit( 440 , true );--全当たり無効
	proxy:SetIgnoreHit( 441 , true );

	proxy:SetDisableGravity( 440 , true );--重力無効
	proxy:SetDisableGravity( 441 , true );

	OnEvent_1070_inu  (proxy, param);--(犬、　発動)
	OnEvent_1070_basya(proxy, param);--(馬車、発動)
	

	--■1071■荷馬車がガタガタ2■
		
	proxy:Warp( 443 , 2435 );--荷馬車の中にワープ
	proxy:Warp( 444 , 2436 );
	
	proxy:EnableLogic( 443 , false );--ロジックOFF
	proxy:EnableLogic( 444 , false );
	
	proxy:SetIgnoreHit( 443 , true );--全当たり無効
	proxy:SetIgnoreHit( 444 , true );
	
	proxy:SetDisableGravity( 443 , true );--重力無効
	proxy:SetDisableGravity( 444 , true );
		
	OnEvent_1071_inu  (proxy, param);--(犬、　発動)
	OnEvent_1071_basya(proxy, param);--(馬車、発動)
	
	
	--■1079■荷馬車が落ちてくる■
	if proxy:IsCompleteEvent( 1079 ) == false then
		--獄吏と兵士のロジックをOFF
		proxy:EnableLogic( 452 , false ); --獄吏
		InvalidCharactor( proxy, 405 );
		--proxy:EnableLogic( 405 , false ); --兵士
		proxy:EnableLogic( 406 , false );
		proxy:EnableLogic( 407 , false );
		proxy:EnableLogic( 408 , false );
	else
		--火のSFXはついたまま。
		proxy:SetObjSfx( 1495 , 1 , 1400 , true );
		proxy:SetObjSfx( 1495 , 2 , 1400 , true );
		proxy:SetObjSfx( 1495 , 3 , 1400 , true );
		
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			--proxy:OnKeyTime2( 1170 , "OnEvent_1170_1400",1.0,0,1400,once);			
			--proxy:OnKeyTime2( 1170 , "OnEvent_1170_1401",1.5,0,1401,once);			
			--proxy:OnKeyTime2( 1170 , "OnEvent_1170_1402",1.7,0,1402,once);
			proxy:OnObjectDamageHit_NoCallPlus( 1170, 1495,1,10310,EV_HIT_CHR,1.2,-1,2.0,everytime);
			proxy:OnObjectDamageHit_NoCallPlus( 1170, 1495,2,10310,EV_HIT_CHR,1.2,-1,2.0,everytime);
			proxy:OnObjectDamageHit_NoCallPlus( 1170, 1495,3,10310,EV_HIT_CHR,1.2,-1,2.0,everytime);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();		
	end
	
	--[[
	--■1065■獄吏Aの巣を変える(扉の奥のほうへ走らせる)■
	if proxy:IsCompleteEvent( 1065 ) == true then
		proxy:EnableLogic( 452 , true );--[[追加]]
		proxy:Warp( 452 , 2513 );--目的地にワープ
		proxy:ChangeInitPosAng( 452 , 2513 );--巣を目的地に更新
		proxy:ForceUpdateNextFrame( 452 );--次のフレームは強制更新
	end
	]]
	
	
	--■1085■細い路地の扉が急に開く■	
	if proxy:IsCompleteEvent( 1085 ) == false then
		proxy:EnableLogic( 400 , false );--兵士AロジックOFF
		proxy:EnableLogic( 401 , false );--兵士BロジックOFF
		proxy:EnableLogic( 402 , false );--兵士CロジックOFF
	else
		proxy:EndAnimation( 1499 , 1 );--扉は開いている		
		proxy:ReconstructBreak( 1530 , 1 );
	end
	
	
	--■1086■細い路地から敵が飛び出してくる■
	if proxy:IsCompleteEvent( 1086 ) == true then
		--兵士たちが、目的地まで走り終わったことにする
		proxy:Warp( 400 , 2484 );
		proxy:Warp( 401 , 2485 );
		proxy:Warp( 402 , 2486 );
	end
	
	
	--■1088■獄吏の指示で弓兵が弓を撃ってくる■
	if proxy:IsCompleteEvent( 1088 ) == false then
		proxy:EnableLogic( 451 , false );--獄吏(2匹目)
		proxy:EnableLogic( 410 , false );--弓兵ロジックOFF
		proxy:EnableLogic( 411 , false );
		proxy:EnableLogic( 412 , false );
		proxy:EnableLogic( 413 , false );
		proxy:EnableLogic( 414 , false );
	end
	
	
	--■1270■獄吏の指示で弓兵が弓を撃ってくる2■
	
	proxy:SetDeadMode( 453 , true );--3匹目の獄吏は通常では殺せない(王の剣に殺される)
	
	if proxy:IsCompleteEvent( 1270 ) == false then
		proxy:EnableLogic( 453 , false );--獄吏(3匹目)
		proxy:EnableLogic( 480 , false );--弓兵ロジックOFF
		proxy:EnableLogic( 481 , false );
		proxy:EnableLogic( 482 , false );
	end
	
	if proxy:IsCompleteEvent( 1271 ) == true then
		print("獄吏移動のポリ劇を見た");		
		--453の獄吏ワープ ボス部屋の中で待機している
		proxy:Warp( 453 , 2507 );
		proxy:EnableLogic( 453 , false );
	end

	
	
	--■1280■獄吏1 死亡チェック■
	if proxy:IsCompleteEvent( 1280 ) == true then
		if proxy:IsCompleteEvent( 15621 ) == false then
			--宝死体を再現
			proxy:OpeningDeadPlus( 451 , true ,false ,false );
		else
			InvalidCharactor( proxy, 451 );
		end
	end
	
	--■1281■獄吏2 死亡チェック■
	if proxy:IsCompleteEvent( 1281 ) == true then
		if proxy:IsCompleteEvent( 15620 ) == false then
			--宝死体を再現
			proxy:OpeningDeadPlus( 452 , true ,false ,false );			
		else
			InvalidCharactor( proxy, 452 );
		end
	end
	
	--■1282■獄吏3 死亡チェック■
	if proxy:IsCompleteEvent( 1282 ) == true then
		InvalidCharactor( proxy, 453 );
	end
	
	
		
	--■1036■中ボスポリ劇再生■ 
	if proxy:IsCompleteEvent( 1036 ) == true then--再生終了している
		print("王の剣のポリ劇を見ている初期化");

		--王の剣扉の中に来た
		proxy:SetDrawEnable( 802 , true );
	
		--獄吏(453)が中ボス部屋の中で死んでいる
		proxy:StopLoopAnimation( 453 );
		proxy:PlayLoopAnimation( 453 , 2210 );--死亡待機
		proxy:SetColiEnable( 453 , false );--当たりOFF
		proxy:SetDrawEnable( 453 , true );--描画ON
		proxy:EnableLogic( 453 , false );
		proxy:Warp( 453 , 2505 );--死んでいる位置の領域
		proxy:EnableHide( 453 , true );--探索されない
		proxy:EnableInvincible( 453 , true );--完全無敵(投げ対策)
	else
		proxy:SetDrawEnable( 802 , false );--王の剣、表示OFF(扉の奥の奥にいる想定)
	end
	

	--■王の剣の死亡再現
	if proxy:IsCompleteEvent( 4360 ) ==true then
		--ボスが死んでいる場合ボスを削除
		InvalidBackRead( proxy , 802 );
	else
		--ボスが生きている場合はロジックOFFで待機		
		proxy:EnableLogic( 802 , false );
		print( "王の剣(id:802) logic off" );		
	end
	
	



	--■中ボス死亡で扉が開く(死んでいたら、描画と当たりを消す)
	if proxy:IsCompleteEvent( 4360 ) == true then
		proxy:SetColiEnable( 1997 , false );
		proxy:SetColiEnable( 1993 , false );
	
		proxy:SetDrawEnable( 1997 , false );
		proxy:SetDrawEnable( 1993 , false );
		
		--SFX OFF
		proxy:InvalidSfx( 1985 , false );
		proxy:InvalidSfx( 1989 , false );
	end
	
	
	
	--■4372,4374■ソウル入手、要石でワープ■
	if proxy:IsCompleteEvent( 4360 ) ==true then--ボスが死んでいるとき
		proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--光らせる
		--▼(ソウル)アイテム取得用イベント監視追加▼
		if proxy:IsCompleteEvent( 4372 ) == false then
			proxy:ValidSfx( 1420 );--SFX 有効化
			proxy:ValidSfx( 1421 );--光の粒子
			proxy:OnDistanceActionAttribute( 4372 , 10000 , 1980 , "OnEvent_4372" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );

			--ソウル有効化
			proxy:SetDrawEnable( 1980 , true );
			proxy:SetColiEnable( 1980 , true );
			--ソウル2有効化
			proxy:SetDrawEnable( 1977 , true );
			proxy:SetColiEnable( 1977 , true );

		else
			--▼要石でワープ用の監視を追加▼
			proxy:InvalidSfx( 1420, false );--SFX 無効化
			SingleReset( proxy , 4374 );
			proxy:OnDistanceActionAttribute( 4374 , 10000 , 1980 , "OnEvent_4374" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end

	else
		--ソウル無効化
		proxy:SetDrawEnable( 1980 , false );
		proxy:SetColiEnable( 1980 , false );
		--ソウル2無効化
		proxy:SetDrawEnable( 1977 , false );
		proxy:SetColiEnable( 1977 , false );
		--SFX 無効化
		proxy:InvalidSfx( 1420 , false );
		proxy:InvalidSfx( 1421 , false );
	end

	--■1300■幽閉する敵の初期化処理■	
	--ひとまずソロ用
	SingleReset( proxy , 1220 );
	if proxy:IsCompleteEvent( 1220 ) == false then
		proxy:EnableLogic( 454 , 0 );
	end
	
	
	--■1222■幽閉する敵の死亡チェック■
	if proxy:IsCompleteEvent( 1222 ) == true then
		InvalidCharactor( proxy, 454 );
	end
	


	--■1250■燃える藁が転がり落ちてくる1■
	proxy:SetObjSfx( 1496 , 1 , 1400 , true );--火のSFXを付ける
	if proxy:IsCompleteEvent( 1250 ) == true then
		
		proxy:EndAnimation( 1496 , 1 );--藁は転がり終わった
		proxy:EnableLogic( 470 , true );--兵士はうろうろしてるはず		
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			--proxy:OnKeyTime2( 1171 , "OnEvent_1171_1403",1.8,0,1403,once);			
			proxy:OnObjectDamageHit_NoCallPlus( 1171, 1403,1,10310,EV_HIT_CHR,1.2,-1,2.0,everytime);			
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();	
	
	else
		proxy:EnableLogic( 470 , false );--ロジックOFFで待機
	end

	
	--■1251■燃える藁が転がり落ちてくる2■	
	proxy:SetObjSfx( 1497 , 1 , 1400 , true );--火のSFXを付ける
	if proxy:IsCompleteEvent( 1251 ) == true then
		
		proxy:EndAnimation( 1497 , 1 );--藁は転がり終わった
		proxy:EnableLogic( 471 , true );--兵士はうろうろしてるはず		
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			--proxy:OnKeyTime2( 1172 , "OnEvent_1172_1404",1.9,0,1404,once);			
			proxy:OnObjectDamageHit_NoCallPlus( 1172, 1404,1,10310,EV_HIT_CHR,1.2,-1,2.0,everytime);			
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();	
		
	else
		proxy:EnableLogic( 471 , false );--ロジックOFFで待機
	end	
	
	
--■レンドル王子イベント関連初期化
	
	--レンドル王子の現在の状態を取得
	local now_rendol_state = GetRendolState(proxy, param);
	
	--見えない場所にこっそり
	if now_rendol_state == RENDOL_STATE_LOCATION_INVISIBLE then
	
		proxy:EnableLogic( 621 , false );--レンドル王子ロジックOFF

	--門を開けてほしい
	elseif now_rendol_state == RENDOL_STATE_WANT_TO_OPEN_THE_GATE then
	
		proxy:ChangeInitPosAng( 621 , 2552 );--巣を門の前の領域にする
		if proxy:IsClient() == false then
			proxy:Warp( 621 , 2552 );--門の前の領域に到着済み(ワープ)
		end
		
		proxy:SendEventRequest( 621 , 0 , 10 );--「問答無用で巣まで走る(ID:10)」のロジックに切り替え
	
	--袋小路怯え
	elseif now_rendol_state == RENDOL_STATE_SCARED then
	
		proxy:ChangeInitPosAng( 621 , 2553 );--巣を袋小路の領域にする
		if proxy:IsClient() == false then
			proxy:Warp( 621 , 2553 );--袋小路の領域に到着済み(ワープ)
		end
		
		--proxy:EnableLogic( 621 , 0 );--ロジックOFF
		--proxy:SetEventCommand( 621 , 40 );--EzStateに制御番号を渡す(怯える)
	
	--感謝(王城3)
	elseif now_rendol_state == RENDOL_STATE_THANKS_3 then
	
		proxy:ChangeInitPosAng( 621 , 2555 );--巣を対応する領域にする
		if proxy:IsClient() == false then
			proxy:Warp( 621 , 2555 );--対応する領域に到着済み(ワープ)
		end
		
		--proxy:EnableLogic( 621 , 0 );--ロジックOFF
		
	--探索(王城3)
	elseif now_rendol_state == RENDOL_STATE_SEARCH_3 then
	
		proxy:ChangeInitPosAng( 621 , 2555 );--巣を対応する領域にする
		if proxy:IsClient() == false then
			proxy:Warp( 621 , 2555 );--対応する領域に到着済み(ワープ)
		end
	
	--敵対(王城3 城門前)
	elseif now_rendol_state == RENDOL_STATE_HOSTILE_3_FRONT_GATE then
	
		proxy:ChangeInitPosAng( 621 , 2552 );--巣を門の前の領域にする
		if proxy:IsClient() == false then
			proxy:Warp( 621 , 2552 );--門の前の領域に到着済み(ワープ)
		end
		--[[恐らく、ロジックを切り替えるなどする?]]
		
	--敵対(王城3 城門後ろ)
	elseif now_rendol_state == RENDOL_STATE_HOSTILE_3_BACK_GATE then

		proxy:ChangeInitPosAng( 621 , 2555 );--巣を門の後ろの領域にする
		if proxy:IsClient() == false then
			proxy:Warp( 621 , 2555 );--門の後ろの領域に到着済み(ワープ)
		end
		--[[恐らく、ロジックを切り替えるなどする?]]
	
	--死んでいる
	elseif now_rendol_state == RENDOL_STATE_DEAD then
	
		InvalidCharactor( proxy , 621 );--レンドル王子無効化
	end
	
	
	
	
	
	
	
	--■1350■レンドル王子を追う敵が出現する1■
	if proxy:IsCompleteEvent( 1310 ) == false then	
		InvalidCharactor( proxy, 460 );	
		InvalidCharactor( proxy, 461 );	
		InvalidCharactor( proxy, 462 );
	end		
	
	
	--■1410■一般兵士の死亡監視■
	if proxy:IsCompleteEvent( 1410 ) == true then
		InvalidCharactor( proxy, 460 );
	end

	--■1411■一般兵士の死亡監視■
	if proxy:IsCompleteEvent( 1411 ) == true then
		InvalidCharactor( proxy, 461 );
	end

	--■1412■一般兵士の死亡監視■
	if proxy:IsCompleteEvent( 1412 ) == true then
		InvalidCharactor( proxy, 462 );
	end
		
--■8084■王城へ来たフラグを立てる■
	proxy:SetEventFlag(8084, true);


--カラスイベントをリピートさせるためにSingleReset()
	for IndexID = 1121, 1150, 1 do
		SingleReset(proxy, IndexID);
	end

--カラスがＰＣが近づくと飛び立つ
	for KarasuID = 1121, 1150, 1 do
		if proxy:IsCompleteEvent( KarasuID ) == false then
			proxy:OnPlayerDistanceInTarget( KarasuID, 10000, 444 + KarasuID, "OnEvent_"..KarasuID, 5, once );
		else
			proxy:SetDrawEnable(444 + KarasuID, false);
		end
	end

	--鉱石の精霊の死亡監視	
	if proxy:IsCompleteEvent(1160) == false then
		proxy:OnCharacterDead( 1160 , 185,"OnEvent_1160",once);	
		
		if proxy:IsClient() == false and proxy:IsCompleteEvent(8020) == false then
			proxy:NotNetMessage_begin();
				proxy:AddCorpseEvent( 8020 , 185 );
				proxy:LuaCall( 8020 , 0 , "OnEvent_8020",once);
			proxy:NotNetMessage_end();
		end
	end
	--------------------------------▽▽▽QWCイベント関連▽▽▽--------------------------------
	
	SingleReset(proxy,1161);
	if proxy:IsClient() == false then
		if proxy:IsSuccessQWC(20200) == false then
			proxy:SetEventFlag( 1161 , true );
		end
	end
	
	--QWC値で鉱石の精霊の出現制御
	if proxy:IsCompleteEvent(1160) == true or proxy:IsCompleteEvent(1161) == true then
		--殺した　or　非成立なら消える
		InvalidBackRead( proxy,185);	
	end
	
--■1110■QWCソウルモンスター出現１■
	if	proxy:IsClient() == false then
		SingleReset(proxy, 1110);
	end
	--後から入ってくる人が既に表示がOnになっているかチェックする
	if	proxy:IsCompleteEvent(1110) == false then
		InvalidCharactor( proxy, 180 );
		InvalidCharactor( proxy, 181 );
	end
	if	proxy:IsSuccessQWC(20100) == true then
		print("QWCソウルモンスター出現m02_02　成立");
		proxy:OnRegionJustIn( 1110, LOCAL_PLAYER, 2420, "OnEvent_1110", once );
	else
		print("QWCソウルモンスター出現m02_02　未成立");
	end
	
	--結晶トカゲ逃亡イベント
	RegistTokage(proxy,1090,256,3);
	
--------------------------------△△△QWCイベント関連△△△--------------------------------

	--■999999■フレーム遅れの初期化処理イベントを発行■
	proxy:NotNetMessage_begin();
		--▼0秒後▼--
		proxy:OnKeyTime2( 999992, "Second_Initialize_m02_02_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m02_02_00_00 end");
end

--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく
function Second_Initialize_m02_02_00_00(proxy, param)
	print("Second_Initialize_m02_02_00_00 begin");

--------------------------------▽▽▽QWCイベント関連▽▽▽--------------------------------
--------------------------------△△△QWCイベント関連△△△--------------------------------

	--■1082 扉が閉まるポリ劇が終わって無い
	if proxy:IsCompleteEvent( 1082 ) == false then
		--宝システム無効化
		proxy:EnableObjTreasure( 11502 , false );
		proxy:SetDrawEnable( 11502,false);
	end
	print("Second_Initialize_m02_02_00_00 end");
end






--------------------------------------------------------------------------------------
--城門開放レバー■1040
--------------------------------------------------------------------------------------
--■1040■城門開放レバー■
function OnEvent_1040(proxy, param)
	print("OnEvent_1040 begin");
		
	proxy:PlayAnimation(1450, 1);--城門開放レバーアニメ再生	
	
	proxy:NotNetMessage_begin();
		--▼1040_2▼***条件追加***レバーアニメ終了▼
		proxy:OnObjAnimEnd( 1040, 1450, 1, "OnEvent_1040_2", once);
	proxy:NotNetMessage_end();
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PULL_LEVER ) == true then
		--パーティープレイヤーがアニメーションした場合はここで処理終了
		print("OnEvent_1040 end");
		return;
	end
	
	proxy:WarpDmy( 10000 , 1450 , 191 );
	
	print("OnEvent_1040 end");
end

--▲1040_2▲レバーアニメ終了▲
function OnEvent_1040_2(proxy, param)
	print("OnEvent_1040_2 begin");

	proxy:SetEventFlag( 1040, true );
	
	if	proxy:IsCompleteEvent( RENDOL_STATE_WANT_TO_OPEN_THE_GATE ) == true then
		OnEvent_1311(proxy,param);
	end
	
	--[[
	--ホストのみ実行
	if	proxy:IsClient() == false then
		--▼1041▼***条件追加***0秒後▼--(アクションIDが分けてあるのは、エクセルのフラグ分けに合わせる為です)
		--proxy:OnKeyTime2( 1041, "OnEvent_1041", 0.0, 0, 1, once );
		--→OnEvent_1041
		proxy:LuaCallStart( 1041, 1 );
	end
	]]
	
	proxy:PlayAnimation( 1440, 1 );--正門開放アニメを再生	
	proxy:SetEventFlag( 1041 , true );
	print("OnEvent_1040_2 end");
end

--[[
function OnEvent_1041(proxy,param)
	print("OnEvent_1041 begin");
	
	proxy:PlayAnimation( 1440, 1 );--正門開放アニメを再生
	--proxy:RequestRemo(20203,REMO_FLAG,1041,1);--正門が開くポリ劇再生
	proxy:SetEventFlag( 1041 , true );
	
	print("OnEvent_1041 end");
end


--------------------------------------------------------------------------------------
--城門開放レバーイベント終了後■1041
--------------------------------------------------------------------------------------

--ポリ劇フェード完了後に呼ばれるハンドラ
function OnEvent_1041_RemoStart(proxy,param)
	print("OnEvent_1041_RemoStart begin");
	
	--proxy:SetDrawEnable( 405 , false );--ポリ劇中は表示OFF
	
	print("OnEvent_1041_RemoStart end");
end


--ポリ劇終了後に呼ばれるハンドラ
function OnEvent_1041_RemoFinish(proxy , param)
	print("OnEvent_1041_RemoFinish begin");
	
	--proxy:SetDrawEnable( 405 , true );--ポリ劇終わったので、表示ON
	--proxy:EndAnimation( 1440, 1 );--正門開放アニメを再生

	print("OnEvent_1041_RemoFinish end");
end
]]

--------------------------------------------------------------------------------------
--■1051■敵が落ちてくる2■
--------------------------------------------------------------------------------------

--■1051_0_1■敵が落ちてくる(攻撃を受けた場合の処理)■ID423
function OnEvent_1051_0_1(proxy,param)	
	print("OnEvent_1051_0_1 begin");
	
	proxy:NotNetMessage_begin();
		--▼1051▼0秒後→敵が落ちてくるへ▼
		proxy:OnKeyTime2( 1051 , "OnEvent_1051" , 0.0 , 0 , 1 , once );
	proxy:NotNetMessage_end();	

	print("OnEvent_1051_0_1 end");
end


--■1051■敵が落ちてくる■一匹になった
function OnEvent_1051(proxy,param)	
	print("OnEvent_1051 begin");
	
	proxy:DisableMapHit( 423, true );
	proxy:SetDisableGravity( 423 , true );
	
	proxy:SetColiEnable( 423 , false );
	proxy:PlayAnimation( 423 , 7000 );
	
	proxy:NotNetMessage_begin();
		--▼1051_1▼敵が落ちてくるアニメ再生終了▼
		proxy:OnKeyTime2( 1051 , "OnEvent_1051_1" , (13/30) , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1051 , 1 );
	
	print("OnEvent_1051 end");
end


--▲1051_1▲敵が落ちてくるアニメ再生終了▲
function OnEvent_1051_1(proxy,param)	
	print("OnEvent_1051_1 begin");
	
	proxy:DisableMapHit( 423, false );
	proxy:SetDisableGravity( 423 , false );	
	
	proxy:SetColiEnable( 423 , true );
	proxy:EnableLogic( 423 , true );
	
	proxy:DeleteEvent( 1051 );
	
	print("OnEvent_1051_1 end");
end





--------------------------------------------------------------------------------------
--■1070■荷馬車がガタガタ1■
--------------------------------------------------------------------------------------

--■犬------------------------------------------------

function OnEvent_1070_inu(proxy, param)

	OnEvent_1070_440_anime1_start(proxy, param);--犬Aのアニメ1再生開始
	OnEvent_1070_441_anime1_start(proxy, param);--犬Bのアニメ1再生開始

end

-- 犬A -----------------------------------------------

--▲犬Aのアニメ1再生開始▲
function OnEvent_1070_440_anime1_start(proxy, param)
	
	proxy:ForcePlayAnimation( 440 , 7000 );--犬A アニメ1
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_440_anime1_wait" , 0.1 , 0 , 50 , once);
	proxy:NotNetMessage_end();		
end

function OnEvent_1070_440_anime1_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--▼犬Aのアニメ1再生終了▼
		proxy:OnChrAnimEnd( 1070 , 440 , 7000 , "OnEvent_1070_440_anime1_end" , once );
	proxy:NotNetMessage_end();
end

--▲犬Aのアニメ1再生終了▲
function OnEvent_1070_440_anime1_end(proxy, param)

	proxy:ForcePlayAnimation( 440 , 7010 );--犬A アニメ2
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_440_anime2_wait" , 0.1 ,0,51, once );
	proxy:NotNetMessage_end();
end

function OnEvent_1070_440_anime2_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--▼犬Aのアニメ2再生終了▼
		proxy:OnChrAnimEnd( 1070 , 440 , 7010 , "OnEvent_1070_440_anime2_end" , once );
	proxy:NotNetMessage_end();
end

--▲犬Aのアニメ2再生終了▲
function OnEvent_1070_440_anime2_end(proxy, param)
	proxy:ForcePlayAnimation( 440 , 7010 );--犬A アニメ3
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_440_anime3_wait" , 0.1 , 0 , 52 , once );
	proxy:NotNetMessage_end();
end

function OnEvent_1070_440_anime3_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--▼犬Aのアニメ2再生終了▼
		proxy:OnChrAnimEnd( 1070 , 440 , 7010 , "OnEvent_1070_440_anime3_end" , once );
	proxy:NotNetMessage_end();
end

function OnEvent_1070_440_anime3_end(proxy,param)
	proxy:NotNetMessage_begin();
		--▼犬Aのアニメ2再生終了▼
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_440_anime1_start" , 0.0 , 0 , 53 , once );
	proxy:NotNetMessage_end();
end

-- 犬B -------------------------------------------

--▲犬Bのアニメ1再生開始▲
function OnEvent_1070_441_anime1_start(proxy, param)
	
	proxy:PlayAnimation( 441 , 7010 );--犬B アニメ1

	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 441 , "OnEvent_1070_441_anime1_wait",0.1,0,54,once);
	proxy:NotNetMessage_end();
	
end

function OnEvent_1070_441_anime1_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--▼犬Bのアニメ1再生終了▼
		proxy:OnChrAnimEnd( 1070 , 441 , 7010 , "OnEvent_1070_441_anime1_end" , once );
	proxy:NotNetMessage_end();
end

--▲犬Bのアニメ1再生終了▲
function OnEvent_1070_441_anime1_end(proxy, param)

	proxy:PlayAnimation( 441 , 7000 );--犬B アニメ2
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_441_anime2_wait" , 0.1 , 0 , 55 , once );
	proxy:NotNetMessage_end();
	
end

function OnEvent_1070_441_anime2_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--▼犬Bのアニメ2再生終了▼
		proxy:OnChrAnimEnd( 1070 , 441 , 7000 , "OnEvent_1070_441_anime2_end" , once );
	proxy:NotNetMessage_end();
end

--▲犬Bのアニメ2再生終了▲
function OnEvent_1070_441_anime2_end(proxy, param)
	
	proxy:PlayAnimation( 441 , 7000 );--犬B アニメ2
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_441_anime3_wait" , 0.1 , 0 , 56, once );
	proxy:NotNetMessage_end();
	
end

function OnEvent_1070_441_anime3_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--▼犬Bのアニメ2再生終了▼
		proxy:OnChrAnimEnd( 1070 , 441 , 7000 , "OnEvent_1070_441_anime3_end" , once );
	proxy:NotNetMessage_end();
end


--▲犬Bのアニメ2再生終了▲
function OnEvent_1070_441_anime3_end(proxy, param)
	
	proxy:NotNetMessage_begin();
		--▼犬Bのアニメ2再生終了▼
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_441_anime1_start" , 0.0 , 0 , 57 , once );
	proxy:NotNetMessage_end();
	
end

--■馬車---------------------------------------------

--馬車のアニメランダム風再生(順番に･･･)
--2 → 3 → 3 
function OnEvent_1070_basya(proxy , param)
	--print("OnEvent_1070_basya");
	proxy:PlayAnimation( 1470 , 2 );
	
	proxy:NotNetMessage_begin();
		--▼1070_basya_1▼馬車アニメ1終わり▼
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_basya_wait",1.0,0,1,once);
	proxy:NotNetMessage_end();
	
end

function OnEvent_1070_basya_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--▼1070_basya_1▼馬車アニメ1終わり▼
		proxy:OnCharacterAnimEndPlus( 1070 , 1470 , 2 , "OnEvent_1070_basya_1" , once );
	proxy:NotNetMessage_end();
end

--▲1070_basya_1▲馬車アニメ2終わり▲
function OnEvent_1070_basya_1(proxy , param)
	--print("OnEvent_1070_basya_1")
	proxy:PlayAnimation( 1470 , 3 );
	
	proxy:NotNetMessage_begin();
		--▼1071_basya_2▼馬車アニメ2終わり▼
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_basya_1_wait",1.0,0,2,once);
	proxy:NotNetMessage_end();
	
end

function OnEvent_1070_basya_1_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--▼1071_basya_2▼馬車アニメ2終わり▼
		proxy:OnCharacterAnimEndPlus( 1070 , 1470 , 3 , "OnEvent_1070_basya_2" , once );
	proxy:NotNetMessage_end();
end


--▲1070_basya_2▲馬車アニメ2終わり▲
function OnEvent_1070_basya_2(proxy , param)
	--print("OnEvent_1070_basya_2")
	proxy:PlayAnimation( 1470 , 3 );
	
	proxy:NotNetMessage_begin();
		--▼1070_basya_3▼馬車アニメ3終わり→最初のへ▼
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_basya_2_wait",1.0,0,3,once);
	proxy:NotNetMessage_end();
	
end

function OnEvent_1070_basya_2_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--▼1070_basya_3▼馬車アニメ3終わり→最初のへ▼
		proxy:OnCharacterAnimEndPlus( 1070 , 1470 , 3 , "OnEvent_1070_basya_3" , once );--[[【別ID 1072】]] 
	proxy:NotNetMessage_end();
end

--▲1070_basya_3▲馬車アニメ3終わり▲
function OnEvent_1070_basya_3(proxy , param)
	--print("OnEvent_1070_basya_3")
	proxy:NotNetMessage_begin();
		--▼1070_basya▼馬車アニメ3終わり→最初のへ▼
		proxy:OnKeyTime2( 1070 , "OnEvent_1070_basya" , 0.0 , 0 , 3 , once );
	proxy:NotNetMessage_end();
	
end


--------------------------------------------------------------------------------------
--■1071■荷馬車がガタガタ2■
--------------------------------------------------------------------------------------

--■犬------------------------------------------------

function OnEvent_1071_inu(proxy, param)

	OnEvent_1071_443_anime1_start(proxy, param);--犬Aのアニメ1再生開始
	OnEvent_1071_444_anime1_start(proxy, param);--犬Bのアニメ1再生開始

end

-- 犬A -----------------------------------------------

--▲犬Aのアニメ1再生開始▲
function OnEvent_1071_443_anime1_start(proxy, param)
	
	proxy:PlayAnimation( 443 , 7010 );--犬A アニメ1

	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 443 , "OnEvent_1071_443_anime1_wait" , 0.1 , 0 , 58 , once );
	proxy:NotNetMessage_end();
	
end

function OnEvent_1071_443_anime1_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--▼犬Aのアニメ1再生終了▼
		proxy:OnChrAnimEnd( 1071 , 443 , 7010 , "OnEvent_1071_443_anime1_end" , once );
	proxy:NotNetMessage_end();
end

--▲犬Aのアニメ1再生終了▲
function OnEvent_1071_443_anime1_end(proxy, param)

	proxy:PlayAnimation( 443 , 7000 );--犬A アニメ2
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1071 , "OnEvent_1071_443_anime2_wait" , 0.1 , 0, 59 ,once );
	proxy:NotNetMessage_end();
	
end

function OnEvent_1071_443_anime2_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--▼犬Aのアニメ2再生終了▼
		proxy:OnChrAnimEnd( 1071 , 443 , 7000 , "OnEvent_1071_443_anime2_end" , once );
	proxy:NotNetMessage_end();
end


--▲犬Aのアニメ2再生終了▲
function OnEvent_1071_443_anime2_end(proxy, param)
	
	proxy:PlayAnimation( 443 , 7010 );--犬A アニメ2
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1071 ,"OnEvent_1071_443_anime3_wait" , 0.1 , 0 , 60 , once );
	proxy:NotNetMessage_end();
	
end

function OnEvent_1071_443_anime3_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--▼犬Aのアニメ2再生終了▼
		proxy:OnChrAnimEnd( 1071 , 443 , 7010 , "OnEvent_1071_443_anime3_end" , once );
	proxy:NotNetMessage_end();
end

--▲犬Aのアニメ2再生終了▲
function OnEvent_1071_443_anime3_end(proxy, param)
	
	proxy:NotNetMessage_begin();
		--▼犬Aのアニメ2再生終了▼
		proxy:OnKeyTime2( 1071 , "OnEvent_1071_443_anime1_start" , 0.0 , 0 , 61 , once );
	proxy:NotNetMessage_end();
	
end

-- 犬B -------------------------------------------

--▲犬Bのアニメ1再生開始▲
function OnEvent_1071_444_anime1_start(proxy, param)
	
	proxy:PlayAnimation( 444 , 7000 );--犬B アニメ1

	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1071, "OnEvent_1071_444_anime1_wait" , 0.1 , 0 , 62 , once );
	proxy:NotNetMessage_end();	
end

function OnEvent_1071_444_anime1_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--▼犬Bのアニメ1再生終了▼
		proxy:OnChrAnimEnd( 1071 , 444 , 7000 , "OnEvent_1071_444_anime1_end" , once );
	proxy:NotNetMessage_end();
end

--▲犬Bのアニメ1再生終了▲
function OnEvent_1071_444_anime1_end(proxy, param)

	proxy:PlayAnimation( 444 , 7010 );--犬B アニメ2
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1071 , "OnEvent_1071_444_anime2_wait" , 0.1 , 0 , 63 , once );
	proxy:NotNetMessage_end();

end

function OnEvent_1071_444_anime2_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--▼犬Bのアニメ2再生終了▼
		proxy:OnChrAnimEnd( 1071 , 444 , 7010 , "OnEvent_1071_444_anime2_end" , once );
	proxy:NotNetMessage_end();
end

--▲犬Bのアニメ2再生終了▲
function OnEvent_1071_444_anime2_end(proxy, param)
	proxy:PlayAnimation( 444 , 7000 );--犬B アニメ2
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1071 , "OnEvent_1071_444_anime3_wait" , 0.1 , 0 , 64 , once );
	proxy:NotNetMessage_end();	
end

function OnEvent_1071_444_anime3_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--▼犬Bのアニメ2再生終了▼
		proxy:OnChrAnimEnd( 1071 , 444 , 7000 , "OnEvent_1071_444_anime3_end" , once );
	proxy:NotNetMessage_end();	
end

--▲犬Bのアニメ2再生終了▲
function OnEvent_1071_444_anime3_end(proxy, param)
	
	proxy:NotNetMessage_begin();
		--▼犬Bのアニメ2再生終了▼
		proxy:OnKeyTime2( 1071 , "OnEvent_1071_444_anime1_start" , 0.0 , 0 , 65 , once );
	proxy:NotNetMessage_end();
	
end


--■馬車---------------------------------------------

--馬車のアニメランダム風再生(順番に･･･)
--3 → 2 → 3 
function OnEvent_1071_basya(proxy , param)
	--print("OnEvent_1071_basya");
	proxy:PlayAnimation( 1471 , 3 );
	
	proxy:NotNetMessage_begin();
		--▼1071_basya_1▼馬車アニメ1終わり▼
		proxy:OnKeyTime2( 1071 , "OnEvent_1071_basya_wait",1.0,0,1,once);
	proxy:NotNetMessage_end();
	
end

function OnEvent_1071_basya_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--▼1071_basya_1▼馬車アニメ1終わり▼
		proxy:OnCharacterAnimEndPlus( 1071 , 1471 , 3 , "OnEvent_1071_basya_1" , once );
	proxy:NotNetMessage_end();
end

--▲1071_basya_1▲馬車アニメ2終わり▲
function OnEvent_1071_basya_1(proxy , param)
	--print("OnEvent_1071_basya_1")
	proxy:PlayAnimation( 1471 , 2 );
	
	proxy:NotNetMessage_begin();
		--▼1071_basya_2▼馬車アニメ2終わり▼
		proxy:OnKeyTime2( 1071 , "OnEvent_1071_basya_1_wait",1.0,0,2,once);
	proxy:NotNetMessage_end();
	
end

function OnEvent_1071_basya_1_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--▼1071_basya_2▼馬車アニメ2終わり▼
		proxy:OnCharacterAnimEndPlus( 1071 , 1471 , 2 , "OnEvent_1071_basya_2" , once );
	proxy:NotNetMessage_end();
end


--▲1071_basya_2▲馬車アニメ2終わり▲
function OnEvent_1071_basya_2(proxy , param)
	--print("OnEvent_1071_basya_2");
	proxy:PlayAnimation( 1471 , 3 );
	
	proxy:NotNetMessage_begin();
		--▼1071_basya_3▼馬車アニメ3終わり→最初のへ▼
		proxy:OnKeyTime2( 1071 ,"OnEvent_1071_basya_2_wait",1.0,0,3,once);
	proxy:NotNetMessage_end();
	
end

function OnEvent_1071_basya_2_wait(proxy,param)
	proxy:NotNetMessage_begin();
		--▼1071_basya_3▼馬車アニメ3終わり→最初のへ▼
		proxy:OnCharacterAnimEndPlus( 1071 , 1471 , 3 , "OnEvent_1071_basya_3" , once );
	proxy:NotNetMessage_end();
end

--▲1071_basya_3▲馬車アニメ3終わり▲
function OnEvent_1071_basya_3(proxy , param)
	--print("OnEvent_1071_basya_3");
	proxy:NotNetMessage_begin();
		--▼1071_basya▼馬車アニメ3終わり→最初のへ▼
		proxy:OnKeyTime2( 1071 , "OnEvent_1071_basya" , 0.0 , 0 , 3 , once );
	proxy:NotNetMessage_end();
	
end



--------------------------------------------------------------------------------------
--■1079■荷馬車が落ちてくる■
--------------------------------------------------------------------------------------

--■1079■荷馬車が落ちてくる■
function OnEvent_1079(proxy,param)	
	if proxy:IsCompleteEvent( 1082 ) == false then
		print("OnEvent_1079 begin");
		LuaFunc_ForceOmission( proxy,452 );
		proxy:PlayAnimation( 452 , 7000 );--獄吏が合図

		proxy:NotNetMessage_begin();
			--▼1080▼獄吏の合図終了▼
			proxy:OnChrAnimEnd( 1080 , 452 , 7000 , "OnEvent_1080" , once );
		proxy:NotNetMessage_end();
	
		print("OnEvent_1079 end");
	end
end


--▲1080▲獄吏の合図終了▲
function OnEvent_1080(proxy, param)
	print("OnEvent_1080 begin");
	LuaFunc_NormalOmission(proxy,452);
	proxy:SetEventFlag( 1079 , 1 );
	proxy:PlayAnimation( 1490 , 1 );--荷馬車転がる
	proxy:PlayAnimation( 1495 , 1 );--藁転がる

	proxy:NotNetMessage_begin();
		--▼1080_anime_end▼荷馬車が転がるアニメ終了▼
		proxy:OnCharacterAnimEnd( 1080 , 1490 , 1 , "OnEvent_1080_anime_end" , once );
	proxy:NotNetMessage_end();

	--藁の塊に火のSFXを付ける
	proxy:SetObjSfx( 1495 , 1 , 1400 , true );
	proxy:SetObjSfx( 1495 , 2 , 1400 , true );
	proxy:SetObjSfx( 1495 , 3 , 1400 , true );
	
	--藁の塊からダメージ
	local paramid = 10010;
	local rad     = 1.0;
	local time    = 20;
	
	proxy:NotNetMessage_begin();
		--▼火の玉1 あたったとき▼
		proxy:OnObjectDamageHit_NoCall( 1080, 1495, 1, paramid, EV_HIT_CHR , rad, time, everytime );
		--▼火の玉2 あたったとき▼
		proxy:OnObjectDamageHit_NoCall( 1080, 1495, 2, paramid, EV_HIT_CHR , rad, time, everytime );	
		--▼火の玉3 あたったとき▼
		proxy:OnObjectDamageHit_NoCall( 1080, 1495, 3, paramid, EV_HIT_CHR , rad, time, everytime );
		proxy:SetObjEventCollisionFill( 1495, true );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1080 end");
end


--▲1080_anime_end▲荷馬車が転がるアニメ終了▲
function OnEvent_1080_anime_end(proxy, param)
	print("OnEvent_1080_anime_end begin");
	
	proxy:DeleteEvent( 1080 );--ダメージ球の監視を消す
	
	--荷馬車からアタリを抜く
	proxy:SetColiEnable( 1490 , false );
	--炎ダメージ追加
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		--proxy:OnKeyTime2( 1170 , "OnEvent_1170_1400",1.0,0,1400,once);
		--proxy:OnKeyTime2( 1170 , "OnEvent_1170_1401",1.5,0,1401,once);
		--proxy:OnKeyTime2( 1170 , "OnEvent_1170_1402",1.7,0,1402,once);
		proxy:OnObjectDamageHit_NoCallPlus( 1170, 1495,1,10310,EV_HIT_CHR,1.2,-1,2.0,everytime);
		proxy:OnObjectDamageHit_NoCallPlus( 1170, 1495,2,10310,EV_HIT_CHR,1.2,-1,2.0,everytime);
		proxy:OnObjectDamageHit_NoCallPlus( 1170, 1495,3,10310,EV_HIT_CHR,1.2,-1,2.0,everytime);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	--再現用小細工フラグ・・・
	proxy:SetEventFlag( 1080 , 1 );
	
	print("OnEvent_1080_anime_end end");
end


--------------------------------------------------------------------------------------
--■1082■扉が閉まるポリ劇再生■
--------------------------------------------------------------------------------------

--■1082■扉が閉まるポリ劇再生■
function OnEvent_1082(proxy,param)	
	print("OnEvent_1082 begin");
	
	--扉が閉まるポリ劇再生
	proxy:RequestRemo(20202,REMO_FLAG,1082,1);
	proxy:SetEventFlag( 1082 , 1 );--フラグON	
	
	print("OnEvent_1082 end");
end

--ポリ劇開始（フェード完了) 
function OnEvent_1082_RemoStart(proxy,param)
	print("OnEvent_1082_RemoStart begin");

	--獄吏は表示OFF
	proxy:SetDrawEnable( 452 , false );
	
	--(恐らく)潰される兵士も表示OFF
	--proxy:SetDrawEnable( 405 , false );
	InvalidCharactor( proxy, 405 );
	
	--他の兵士は無効化
	InvalidCharactor( proxy , 406 );
	InvalidCharactor( proxy , 407 );
	InvalidCharactor( proxy , 408 );

	print("OnEvent_1082_RemoStart end");
end

--ポリ劇終了
function OnEvent_1082_RemoFinish(proxy,param)
	print("OnEvent_1082_RemoFinish begin");
	
	proxy:EndAnimation( 1440 , 2 );--扉が閉まるアニメーションを終わらせる
	
	--ポリ劇を再生したので獄吏ワープ
	proxy:Warp( 452 , 2512 );--次のポイントへワープ
	proxy:SetDrawEnable( 452 , true );--ポリ劇中、表示OFFにしていたので戻す
	proxy:ChangeInitPosAng( 452 , 2512 );--巣をワープ先の領域に更新
	proxy:SetDeadMode( 452 , false );--獄吏完全無敵解除
	LuaFunc_NormalOmission(proxy,452);
	--兵士405が扉に潰される
	--proxy:Warp( 405 , 2506 );--扉の下にワープ
	--proxy:EnableLogic( 405 , false );--思考OFF
	--proxy:SetColiEnable( 405 , false );--当たりOFF
	--proxy:SetDrawEnable( 405 , true );--ポリ劇中、表示OFFにしていたので戻す
	--proxy:PlayLoopAnimation( 405 , 7020 );--倒れたまま
	--proxy:EnableHide( 405 , true );--探索されない
	--proxy:DisableMapHit( 405, true );--マップ当たり無効(扉の当たりで位置がずれる?ので?)
	--proxy:SetDisableGravity( 405 , true );--重力無効
	--proxy:ForceUpdateNextFrame(405);--次のフレームは強制更新(潰される兵士)
	InvalidCharactor( proxy, 405 );		
	--宝システム有効化
	proxy:EnableObjTreasure( 11502 , true );
	proxy:SetDrawEnable( 11502,true);
	
	proxy:SetDrawEnable( 1520 , true );--血ダマリ表示

	--荷馬車のイベント削除(終わってなくても削除）
	proxy:DeleteEvent( 1080 );
	--初期化時に作っている扉しまるポリ劇イベントの領域監視削除
	proxy:DeleteEvent( 1082 );
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(1079,"OnEvent_1079_Wait",0.2,0,0,once);
	proxy:NotNetMessage_end();
	print("OnEvent_1082_RemoFinish end");
end

function OnEvent_1079_Wait(proxy,param)
	print("OnEvent_1079_Wait begin");
	proxy:EnableLogic( 452 , true );
	proxy:ClearTarget( 452 );
	proxy:ResetThink( 452 );
	
	--獄吏の合図が終わっていて、荷馬車アニメが終わってないなら
	if proxy:IsCompleteEvent( 1079 ) == true then
		if proxy:IsCompleteEvent( 1080 ) == false then
			OnEvent_1080_anime_end(proxy,param);
		end
	end
	print("OnEvent_1079_Wait end");
end

--[[
--------------------------------------------------------------------------------------
--■1065■獄吏Aの巣を変える(扉の奥のほうへ走らせる)■
--------------------------------------------------------------------------------------
--■1065■獄吏Aの巣を変える(扉の奥のほうへ走らせる)■
function OnEvent_1065(proxy,param)	
	print("OnEvent_1065 begin");

	proxy:EnableLogic( 452 , true );--[[追加]]
	proxy:ChangeInitPosAng( 452 , 2513 );--巣を扉の奥の領域に更新(走りだすはず･･･)	
	proxy:ForceUpdateNextFrame( 452 );--次のフレームは強制更新
	
	proxy:SetEventFlag( 1065 , 1 );

	print("OnEvent_1065 end");
end
]]



--------------------------------------------------------------------------------------
--■1115■チェックポイント1(扉を開けるイベントのためのもの)■
--------------------------------------------------------------------------------------

--■1115■チェックポイント1(扉を開けるイベントのためのもの)■
function OnEvent_1115(proxy,param)	
	print("OnEvent_1115 begin");

	proxy:SetEventFlag( 1115 , 1 );
	
	print("OnEvent_1115 end");
end



--------------------------------------------------------------------------------------
--■1085■細い路地の扉が急に開く■
--------------------------------------------------------------------------------------

--▽チェックポイント通過したかのチェック
function OnEvent_1085_check_1(proxy, param)
	
	--扉が開くイベントが終わっていたら、チェック用のイベントを削除して終了
	if proxy:IsCompleteEvent( 1085 ) == true then
		proxy:DeleteEvent( 1085 );
		return;
	end
	
	--チェックポイントを通過していたら、
	if proxy:IsCompleteEvent( 1115 ) == true then
		--▼細い路地の扉が急に開くのイベントを発動▼
		OnEvent_1085(proxy, param);
	end
end


--▽ポリ劇再生済みかのチェック
function OnEvent_1085_check_2(proxy, param)
	
	--扉が開くイベントが終わっていたら、チェック用のイベントを削除して終了
	if proxy:IsCompleteEvent( 1085 ) == true then
		proxy:DeleteEvent( 1085 );
		return;
	end
	
	--扉が閉まるポリ劇の再生が終わっていたら、
	if proxy:IsCompleteEvent( 1082 ) == true then
		--▼細い路地の扉が急に開くのイベントを発動▼
		OnEvent_1085(proxy, param);
	end
end


--▲1085▲細い路地の扉が急に開く▲
function OnEvent_1085(proxy,param)	
	print("OnEvent_1085 begin");
	
	--このイベント終わっていたら、反応しない
	if proxy:IsCompleteEvent( 1085 ) == true then
		print( "OnEvent_1085 end" );
		return;
	end
	
	proxy:PlayAnimation( 400 , 3002 );--兵士Aが攻撃
	proxy:PlayAnimation( 1499 , 1 );--扉が開くアニメ再生
	
	--扉からダメージ球
	proxy:OnObjectDamageHit_NoCall( 1085, 1499, 1, 10070, EV_HIT_HIT , 1.0, 10.0, once );
			
	proxy:SetEventFlag( 1085 , 1 );

	print("OnEvent_1085 end");
end



--------------------------------------------------------------------------------------
--■1086■細い路地から敵が飛び出してくる■
--------------------------------------------------------------------------------------

--■発動条件を満たしているかチェック
function Check_OnEvent_1086(proxy, param)

	--「細い路地の扉が急に開く」のイベントが終了している場合イベント発動
	return ( proxy:IsCompleteEvent( 1085 ) );
end


--■1086■細い路地から敵が飛び出してくる■
function OnEvent_1086(proxy, param)
	print("OnEvent_1086 begin");
	
	--強制更新ON
	LuaFunc_ForceOmission(proxy,400);
	LuaFunc_ForceOmission(proxy,401);
	LuaFunc_ForceOmission(proxy,402);	
	
	--兵士たちロジックON
	proxy:EnableLogic( 400 , true );
	proxy:EnableLogic( 401 , true );
	proxy:EnableLogic( 402 , true );

	--▼兵士たち移動開始▼
	OnEvent_1086_move_start(proxy, param);
	
	proxy:SetEventFlag( 1086 , 1 );

	print("OnEvent_1086 end");
end

--▲兵士たち移動開始▲
function OnEvent_1086_move_start(proxy, param)
	print("OnEvent_1086_move_start begin");

	proxy:SetEventFlag( 1086 , 0 );
	
	proxy:ResetThink( 400 );
	--AIのパス移動で移動(ロジックはONである必要がある)
	MoveRegion( proxy , 400 , 2486 , -1 , 0.0 , false );--兵士A
	--▼一つ目の領域に移動終了(ID:400)▼
	proxy:OnRegionIn( 1086 , 400 , 2486 , "OnEvent_1086_400_move1_end" , once );
	
	proxy:ResetThink( 401 );
	--AIのパス移動で移動(ロジックはONである必要がある)
	MoveRegion( proxy , 401 , 2486 , -1 , 0.0 , false );--兵士B 
	--▼一つ目の領域に移動終了(ID:401)▼
	proxy:OnRegionIn( 1086 , 401 , 2486 , "OnEvent_1086_401_move1_end" , once );	
	
	proxy:ResetThink( 402 );
	--AIのパス移動で移動(ロジックはONである必要がある)
	MoveRegion( proxy , 402 , 2486 , -1 , 0.0 , false );--兵士C
	--▼一つ目の領域に移動終了(ID:402)▼
	proxy:OnRegionIn( 1086 , 402 , 2486 , "OnEvent_1086_402_move1_end" , once );	
	
	proxy:SetEventFlag( 1086 , 1 );
	
	print("OnEvent_1086_move_start end");
end


-- 兵士A ---------------------------------------------

--▲一つ目の領域に移動終了(ID:400)▲
function OnEvent_1086_400_move1_end(proxy, param)
	print("OnEvent_1086_400_move1_end begin");

	proxy:SetEventFlag( 1086 , 0 );
	
	proxy:ResetThink( 400 );
	--AIのパス移動で移動(ロジックはONである必要がある)
	MoveRegion( proxy , 400 , 2485 , -1 , 0.0 , false );--兵士A
	--▼二つ目の領域に移動終了(ID:400)▼
	proxy:OnRegionIn( 1086 , 400 , 2485 , "OnEvent_1086_400_move2_end" , once );
	
	proxy:SetEventFlag( 1086 , 1 );
	
	print("OnEvent_1086_400_move1_end end");
end

--▲二つ目の領域に移動終了(ID:400)▲
function OnEvent_1086_400_move2_end(proxy, param)
	print("OnEvent_1086_400_move2_end begin");

	proxy:SetEventFlag( 1086 , 0 );
	
	proxy:ResetThink( 400 );
	--AIのパス移動で移動(ロジックはONである必要がある)
	MoveRegion( proxy , 400 , 2484 , -1 , 0.0 , false );--兵士A
	--▼三つ目の領域に移動終了(ID:400)▼
	proxy:OnRegionIn( 1086 , 400 , 2484 , "OnEvent_1086_400_move3_end" , once );
	
	proxy:SetEventFlag( 1086 , 1 );
	
	print("OnEvent_1086_400_move2_end end");
end

--▲三つ目の領域に移動終了(ID:400)▲
function OnEvent_1086_400_move3_end(proxy, param)
	print("OnEvent_1086_400_move3_end begin");

	proxy:ResetThink( 400 );
	proxy:EnableLogic( 400 , true );
	
	print("OnEvent_1086_400_move3_end end");
end


-- 兵士B ---------------------------------------------

--▲一つ目の領域に移動終了(ID:401)▲
function OnEvent_1086_401_move1_end(proxy, param)
	print("OnEvent_1086_401_move1_end begin");

	proxy:SetEventFlag( 1086 , 0 );
	
	proxy:ResetThink( 401 );
	--AIのパス移動で移動(ロジックはONである必要がある)
	MoveRegion( proxy , 401 , 2485 , -1 , 0.0 , false );--兵士B
	--▼二つ目の領域に移動終了(ID:401)▼
	proxy:OnRegionIn( 1086 , 401 , 2485 , "OnEvent_1086_401_move2_end" , once );
	
	proxy:SetEventFlag( 1086 , 1 );
	
	print("OnEvent_1086_401_move1_end end");
end

--▲二つ目の領域に移動終了(ID:401)▲
function OnEvent_1086_401_move2_end(proxy, param)
	print("OnEvent_1086_401_move2_end begin");

	proxy:ResetThink( 401 );
	proxy:EnableLogic( 401 , true );
	
	print("OnEvent_1086_401_move2_end end");
end


-- 兵士C ---------------------------------------------

--▲一つ目の領域に移動終了(ID:402)▲
function OnEvent_1086_402_move1_end(proxy, param)
	print("OnEvent_1086_402_move1_end begin");

	proxy:ResetThink( 402 );
	proxy:EnableLogic( 402 , true );
	
	print("OnEvent_1086_402_move1_end end");
end



--------------------------------------------------------------------------------------
--■1088■獄吏の指示で弓兵が弓を撃ってくる■
--------------------------------------------------------------------------------------

--■1088■獄吏の指示で弓兵が弓を撃ってくる■(2匹目)
function OnEvent_1088(proxy,param)	
	print("OnEvent_1088 begin");

	if proxy:IsCompleteEvent( 1088 ) == true then--多重発動防止
		print("OnEvent_1088 end");
		return;
	end
	
	--強制更新ON
	LuaFunc_ForceOmission(proxy,451);
	
	proxy:PlayAnimation( 451 , 7000 );--獄吏の合図
	
	proxy:NotNetMessage_begin();
		--▼1088_1▼獄吏の合図終了▼
		proxy:OnChrAnimEnd( 1088 , 451 , 7000 , "OnEvent_1088_1" , once );
	proxy:NotNetMessage_end();
	
	--弓兵ロジックON
	local first_id = 410;
	local now_id   = first_id;
	local id_num   = 5;
	
	for i=1, id_num, 1 do
		proxy:EnableLogic( now_id , true );
		now_id = now_id + 1;
	end
	
	proxy:SetEventFlag( 1088 , 1 );
	
	print("OnEvent_1088 end");
end


--▲1088_1▲獄吏の合図終了▲
function OnEvent_1088_1(proxy,param)	
	print("OnEvent_1088_1 begin");

	proxy:EnableLogic( 451 , true );--ロジックON
	
	LuaFunc_NormalOmission(proxy,451);--強制更新OFF
	proxy:DeleteEvent( 1088 );--ダメージ監視を消す

	print("OnEvent_1088_1 end");
end


--------------------------------------------------------------------------------------
--■1270■獄吏の指示で弓兵が弓を撃ってくる2■
--------------------------------------------------------------------------------------

--■1270■獄吏の指示で弓兵が弓を撃ってくる2■
function OnEvent_1270(proxy,param)	
	print("OnEvent_1270 begin");

	if proxy:IsCompleteEvent( 1270 ) == true then--多重発動防止
		print("OnEvent_1270 end");	
		return;
	end
	
	--強制更新ON
	--LuaFunc_ForceOmission(proxy,453);
	
	--proxy:PlayAnimation( 453 , 7000 );--獄吏の合図
	--proxy:EnableLogic( 453 , true );--AIの領域移動で、移動させるためロジックをONにしておく	
	
	proxy:NotNetMessage_begin();
		--▼1270_1▼獄吏の合図終了▼
		--proxy:OnChrAnimEnd( 1270 , 453 , 7000 , "OnEvent_1270_1" , once );
		proxy:OnKeyTime2(1270,"OnEvent_1270_1",0.0,0,100,once);
	proxy:NotNetMessage_end();
	
	--弓兵ロジックON
	local first_id = 480;
	local now_id   = first_id;
	local id_num   = 3;
	
	for i=1, id_num, 1 do
		proxy:EnableLogic( now_id , true );
		now_id = now_id + 1;
	end
	
	proxy:SetEventFlag( 1270 , 1 );
	
	print("OnEvent_1270 end");
end


--▲1270_1▲獄吏の合図終了▲
function OnEvent_1270_1(proxy,param)	
	print("OnEvent_1270_1 begin");
	
	--獄吏(453)逃げる
	
	--proxy:ResetThink( 453 );
	--AIのパス移動で移動(ロジックはONである必要がある)
	--MoveRegion( proxy , 453 , 2445 , -1 , 0.0 , false );--走り

	--LuaFunc_NormalOmission(proxy,453);--強制更新OFF
	proxy:DeleteEvent( 1270 );--ダメージ監視を消す

	proxy:NotNetMessage_begin();
		--▼獄吏が逃げるポリ劇再生▼
		proxy:OnKeyTime2( 1271 , "OnEvent_1271" , 0.0 , 0 , 1 , once );
	proxy:NotNetMessage_end();
		
	print("OnEvent_1270_1 end");
end


--▲1271▲獄吏が逃げるポリ劇再生▲
function OnEvent_1271(proxy,param)	
	print("OnEvent_1271 begin");

	--獄吏が逃げるポリ劇再生
	proxy:RequestRemo(20204,REMO_FLAG,1271,1);
	proxy:SetEventFlag( 1271 , 1 );

	print("OnEvent_1271 end");
end


--ポリ劇開始フェード完了後に呼ばれるハンドラ
function OnEvent_1271_RemoStart(proxy,param)
	print("OnEvent_1271_RemoStart begin");
	proxy:SetDrawEnable( 453 , false );--表示OFF
	print("OnEvent_1271_RemoStart end");
end


--ポリ劇終了後に呼ばれるハンドラ
function OnEvent_1271_RemoFinish(proxy , param)
	print("OnEvent_1271_RemoFinish begin");

	proxy:SetDrawEnable( 453 , true );--表示ON
	
	--453の獄吏ワープ ボス部屋の中で待機している
	proxy:Warp( 453 , 2507 );
	proxy:EnableLogic( 453 , false );
		
	print("OnEvent_1271_RemoFinish end");
end



--------------------------------------------------------------------------------------
--■1280■獄吏1の死亡チェック■
--------------------------------------------------------------------------------------

--■1280■獄吏1の死亡チェック■
function OnEvent_1280(proxy,param)	
	print("OnEvent_1280 begin");
	
	proxy:SetEventFlag( 1280 , 1 );
	
	print("OnEvent_1280 end");
end

--■15621■獄吏1の死体を調べたか？■
function OnEvent_15621(proxy,param)
	print("OnEvent_15621 begin");
	proxy:SetEventFlag( 15621 ,true );
	print("OnEvent_15621 end");
end

--------------------------------------------------------------------------------------
--■1281■獄吏2の死亡チェック■
--------------------------------------------------------------------------------------

--■1281■獄吏2の死亡チェック■
function OnEvent_1281(proxy,param)	
	print("OnEvent_1281 begin");
	
	proxy:SetEventFlag( 1281 , 1 );
	
	print("OnEvent_1281 end");
end

--■15620■獄吏２の死体を調べた■
function OnEvent_15620(proxy,param)
	print("OnEvent_15620 begin");
	proxy:SetEventFlag( 15620 , true );
	print("OnEvent_15620 edn");
end

--------------------------------------------------------------------------------------
--■1282■獄吏3の死亡チェック■
--------------------------------------------------------------------------------------

--■1282■獄吏3の死亡チェック■
function OnEvent_1282(proxy,param)	
	print("OnEvent_1282 begin");
	
	proxy:SetEventFlag( 1282 , 1 );
	
	print("OnEvent_1282 end");
end




--------------------------------------------------------------------------------------
--■1200■サブイベント扉■
--------------------------------------------------------------------------------------
--■1200_1■サブイベント扉■LuaCall定義
function OnEvent_1200_1(proxy, param)
	print("OnEvent_1200_1 begin");

	proxy:PlayAnimation( 1460, 1 );--扉が開くアニメーション
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 1200, 1 );
		proxy:DeleteEvent( 1200 );
		print("OnEvent_1200_1 end");
		return;
	end

	proxy:WarpDmy( 10000 , 1460 , 191 );
	proxy:SetEventFlag( 1200, 1 );

	print("OnEvent_1200_1 end");
end


--■1200■サブイベント扉■
function OnEvent_1200(proxy, param)
	print("OnEvent_1200 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 1200 ) == true then
		print("OnEvent_1200 end");
		return;
	end	
	
	--必要アイテムの指定
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 36;--血の付いた鉄の鍵
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼1200_3▼選択メニューの監視▼
			--proxy:OnSelectMenu(1200, "OnEvent_1200_3", 10010830, 0, 2, 1460, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010830, 0, 6, 1460, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_1200_3(proxy,param);

	--必要アイテムを所持していない
	else
		--扉が開かない場合のメッセージを表示
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1460, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_1200 end");
end


--▲1200_3▲選択メニューの監視▲(YESを選択したとき)
function OnEvent_1200_3(proxy,param)
	print("OnEvent_1200_3 begin");
	proxy:LuaCallStart( 1200 , 1 );--アニメーションの同期再生(全体に配信)
	proxy:DeleteEvent( 1200 );
	print("OnEvent_1200_3 end");
end



--------------------------------------------------------------------------------------
--■1201■サブイベント扉■
--------------------------------------------------------------------------------------
--■1201_1■サブイベント扉■LuaCall定義
function OnEvent_1201_1(proxy, param)
	print("OnEvent_1201_1 begin");

	proxy:PlayAnimation( 1461, 1 );--扉が開くアニメーション
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 1201, 1 );
		proxy:DeleteEvent( 1201 );
		print("OnEvent_1201_1 end");
		return;
	end

	proxy:WarpDmy( 10000 , 1461 , 191 );
	proxy:SetEventFlag( 1201, 1 );

	print("OnEvent_1201_1 end");
end


--■1201■サブイベント扉■
function OnEvent_1201(proxy, param)
	print("OnEvent_1201 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 1201 ) == true then
		print("OnEvent_1201 end");
		return;
	end	
	
	--必要アイテムの指定
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 36;--血の付いた鉄の鍵
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼1201_3▼選択メニューの監視▼
			--proxy:OnSelectMenu(1201, "OnEvent_1201_3", 10010830, 0, 2, 1461, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010830, 0, 6, 1461, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_1201_3(proxy,param);

	--必要アイテムを所持していない
	else
		--扉が開かない場合のメッセージを表示
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1461, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_1201 end");
end


--▲1201_3▲選択メニューの監視▲(YESを選択したとき)
function OnEvent_1201_3(proxy,param)
	print("OnEvent_1201_3 begin");
	proxy:LuaCallStart( 1201 , 1 );--アニメーションの同期再生(全体に配信)
	proxy:DeleteEvent( 1201 );
	print("OnEvent_1201_3 end");
end


--------------------------------------------------------------------------------------
--■4360■中ボス死亡で扉が開く■
--------------------------------------------------------------------------------------
--■4360■中ボス死亡で扉が開く■
function OnEvent_4360(proxy, param)
	print("OnEvent_4360 begin");
		
	proxy:NotNetMessage_begin();
		--▼4370▼クライアントPCワープ演出▼
		proxy:OnKeyTime2( 4370, "OnEvent_4370", 0, 0, 0, once);
		--▼4360_1▼1秒経過▼
		proxy:OnKeyTime2( 4360, "OnEvent_4360_1", 1, 0, 1, once);
		--▼4371▼2秒経過▼
		proxy:OnKeyTime2( 4371, "OnEvent_4371", 2, 0, 2, once);
		
		--マルチ解散監視
		proxy:OnRegistFunc( 4360 , "Check_4360_PT","OnEvent_4360_PT",0,once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 4360, 1 );
	
	if proxy:IsCompleteEvent( BIYO_STATE_SEARCH_3 ) == true then
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_KING_OF_SWORD_KILL );
		proxy:SetEventFlag( 1431, true );
	end
	
	--レンドル王子の状態を「エレベーター前で待つ」に
	if proxy:IsClient() == false then--生存プレイヤー(グレイ)のみ判定
		if proxy:IsCompleteEvent( RENDOL_STATE_SEARCH_3 ) == true then--王子の状態が「王城３探索」ならば
			proxy:NotNetMessage_begin();
				if	proxy:IsDistance( LOCAL_PLAYER , 621 , 20 ) == true then
					proxy:OnPlayerDistanceOut( 1315, LOCAL_PLAYER, 621, "OnEvent_1315", 20, once );
				else
					proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "OnEvent_1315", 0.0, 0, 2, once );
				end
			proxy:NotNetMessage_end();
		end
	end	
	
	proxy:SetColiEnableArray(3007,true);--通常有効
	proxy:SetColiEnableArray(3008,true);--通常有効
	proxy:SetColiEnableArray(3009,false);--ボス用無効
	proxy:SetColiEnableArray(3011,false);--ボス用無効
	
	--ブロッククリア処理へ
	proxy:CustomLuaCallStart( 4050, 802 );	
	--結晶トカゲイベントリセット
	ResetTokage(proxy);
		
	--距離判定
	if proxy:IsDistance( 10000 , 621 , 20 ) == true then
		return false;
	else
		print("レンドル王子、次ブロックへ移動");
		return true;
	end	

	print("OnEvent_4360 end");
end

--▲4360_1▲中ボス死亡後1秒▲
function OnEvent_4360_1(proxy, param)
	print("OnEvent_4360_1 begin");
	
	--ボスを倒した数を更新(数によってフラグを立てる)
	GetBossFlagCount( proxy, param );
	
	--▼トロフィー取得判定▼
	Lua_RequestUnlockTrophy(proxy, 29);
	
	--▼(ソウル)アイテム取得用イベント監視追加▼
	if proxy:IsCompleteEvent( 4372 ) == false then
	
		--ソウル有効化
		proxy:SetDrawEnable( 1980 , true );
		proxy:SetColiEnable( 1980 , true );
		--ソウル2有効化
		proxy:SetDrawEnable( 1977 , true );
		proxy:SetColiEnable( 1977 , true );
		
		proxy:ValidSfx( 1420 );--SFX 有効化
		proxy:ValidSfx( 1421 );--SFX 有効化
		proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--光らせる
		proxy:OnDistanceActionAttribute( 4372 , 10000 , 1980 , "OnEvent_4372" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );
	else
		--ソウル無効化(取ったら消えるので･･･)
		proxy:SetDrawEnable( 1980 , false );
		proxy:SetColiEnable( 1980 , false );
	end

	print("OnEvent_4360_1 end");
end


--------------------------------------------------------------------------------------
--■4370■クライアントPCワープ演出■
--------------------------------------------------------------------------------------

--■4370■クライアントPCワープ演出■
function OnEvent_4370(proxy, param)
	print("OnEvent_4370 begin");

	if proxy:IsClient() == true then
		proxy:PlayAnimation( 10000 , 8284 );--ワープアニメを再生
	end

	proxy:SetEventFlag( 4370 , 1 );
	
	print("OnEvent_4370 end");
end


--------------------------------------------------------------------------------------
--■4371■シングル：光の壁、BGM消去■
--------------------------------------------------------------------------------------

--■4371■シングル：光の壁、BGM消去■
function OnEvent_4371(proxy, param)
	print("OnEvent_4371 begin");
	
	--ボス戦用のBGM停止
	proxy:StopPointSE( 2 );

	proxy:SetEventFlag( 4371 , 1 );
	
	print("OnEvent_4371 end");
end

--マルチ解散監視
function Check_4360_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--マルチじゃない
function OnEvent_4360_PT(proxy,param)
	print("OnEvent_4360_PT beign");
	--中ボス部屋の前後の魔法壁が消える(全プレイヤー)
	proxy:SetColiEnable( 1997 , false );
	proxy:SetColiEnable( 1993 , false );
	--proxy:SetObjDeactivate( 1997 , true );--デアクティブ
	--proxy:SetObjDeactivate( 1993 , true );--デアクティブ
	
	proxy:SetDrawEnable( 1997 , false );
	proxy:SetDrawEnable( 1993 , false );	
	
	--中ボス部屋魔法壁のSFX削除
	proxy:InvalidSfx( 1985 , true );
	proxy:InvalidSfx( 1989 , true );

	--中ボス部屋前の移動処理イベントを削除
	proxy:DeleteEvent( 1034 );--一人目が入るとき用
	proxy:DeleteEvent( 1035 );--二人目以降が入るとき用
	proxy:DeleteEvent( 1036 );--ポリ劇再生用
	proxy:DeleteEvent( 1037 );--ボス戦闘開始用	
	print("OnEvent_4360_PT end");
end


--------------------------------------------------------------------------------------
--■4372■ソウル入手■
--------------------------------------------------------------------------------------

function OnEvent_4372(proxy, param)
	print("OnEvent_4372 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ 
		print("OnEvent_4372 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行
		proxy:OnKeyTime2( 4372, "OnEvent_4372_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4372 end");
end


--■4372_1■アイテム取得■
function OnEvent_4372_1(proxy, param)
	print("OnEvent_4372_1 begin");

	--アイテム取得関数
	proxy:GetRateItem(10112);--パラメータ10112参照
	proxy:GetRateItem(10178);--パラメータ10178参照
	proxy:GetRateItem(10179);--パラメータ10179参照
	proxy:GetRateItem(10180);--パラメータ10180参照
	proxy:GetRateItem(10181);--パラメータ10181参照
	
	--アイテムを取得済み
	proxy:SetEventFlag( 4372, 1 );
	
	--宝箱シェーダーは消えません
	--proxy:TreasureDispModeChange( 1980 , false );

	--SFXが消える
	proxy:InvalidSfx( 1420, true );--要石オーラ
	--proxy:InvalidSfx( 1421, true );--光の粒子
		
	--▼要石でワープ用の監視を追加▼
	proxy:OnDistanceActionAttribute( 4374 , 10000 , 1980 , "OnEvent_4374" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_4372_1 end");
end

--------------------------------------------------------------------------------------
--石柱にワープ(ボス倒した後用)■4374
--------------------------------------------------------------------------------------
--■4374■石柱にワープ■
function OnEvent_4374(proxy,param)	

	if proxy:IsCompleteEvent( 4374 ) == true then
		return;
	end	

	print("OnEvent_4374 begin");
	
	proxy:RepeatMessage_begin();
		--▼4374_1▼選択メニューの監視▼
		proxy:OnSelectMenu(4374, "OnEvent_4374_0", 10010710, 0, 2, 1980, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_4374 end");
end

--▲4374_0▲選択メニューの監視▲
function OnEvent_4374_0(proxy, param)
	print("OnEvent_4374_0 begin");	
	
	if proxy:IsSession() == false then
		proxy:PlayAnimation( 10000 , 8283 );--要石に触れるアニメを再生
		proxy:NoAnimeTurnCharactor( 10000 , 1980 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--▼要石に触れるアニメ再生終了▼
			proxy:OnChrAnimEnd( 4374 , 10000 , 8283 , "OnEvent_4374_1" , once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 4374 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_4374_0 end");
end

--▲4374_1▲自世界に帰るアニメ再生終了▲
function OnEvent_4374_1(proxy,param)	
	print("OnEvent_4374_1 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生
	--石柱へ戻ってきた判定のフラグを立てる
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag( 4374 , 0 );	
	--完全回復要求
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1006 );
	
	print("OnEvent_4374_1 end");
end


--------------------------------------------------------------------------------------
--徘徊デーモンの登場■??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ)
function PlayerDeath_m02_02_00_00(proxy, param)
	print("PlayerDeath_m02_02_00_00");
	print("PlayerDeath_m02_02_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ)
function PlayerRevive_m02_02_00_00(proxy,param)
	print("PlayerRevive_m02_02_00_00");	
	print("PlayerRevive_m02_02_00_00");
end


--------------------------------------------------------------------------------------
--ボス部屋の中に入る■1034
--------------------------------------------------------------------------------------

--■イベントがループなので、全部リピートにする↓

--■1034■中ボス部屋への扉が開く■
function OnEvent_1034(proxy,param)
	print("OnEvent_1034 begin");

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_1034 end");
		return;
	end
	
	--クライアントへ、ボス部屋阻止失敗を通知
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 1035 , 1 );--旋回アニメの同期再生
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--多重起動システムIDをタイムアウトを設定してONにする
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1034 end");
end


--旋回アニメの同期再生(IDが別)
function OnEvent_1035_1(proxy,param)
	print("OnEvent_1035_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を行い、その終了時にOnEvent_1035_2を発行する
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2889 );
		else
			proxy:LockSession();--ルームをロックします！
			--旋回アニメ再生を行い、その終了時にOnEvent_1035_2を発行する
			proxy:OnTurnCharactorEnd( 1035, 10000, 2889, "OnEvent_1035_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1035_1 end");
end

--旋回アニメの同期再生終了後
function OnEvent_1035_2(proxy,param)
	print("OnEvent_1035_2 begin");
	
	--同期用歩きアニメ再生
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1035, 10000, ANIMEID_WALK, "OnEvent_1035_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1035_2 end");
end

--歩きアニメの同期再生終了後
function OnEvent_1035_3(proxy,param)
	print("OnEvent_1035_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ
	if proxy:IsCompleteEvent( 1034 ) == false then
		proxy:LuaCallStart( 1035 , 5 );--2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知
		proxy:LuaCallStart( 1035 , 6 );--フラグセット(同期用)
		Lua_MultiDoping(proxy,802);--マルチプレイドーピング
	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない)
	if proxy:IsClient() == false	then
		proxy:ResetThink( 802 );
	end
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );
	
	print("OnEvent_1035_3 end");
end


--■1034 2回目以降にボス部屋に入るためのイベント配信用
function OnEvent_1034_GO_TO_IN(proxy, param)
	print("OnEvent_1034_GO_TO_IN begin");

	proxy:NotNetMessage_begin();
		--▼1035▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_1034
		proxy:OnPlayerActionInRegion( 1035, 2893, "OnEvent_1034", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	
	print("OnEvent_1034_GO_TO_IN end");
end


--■1034 フラグセット(同期用)
function OnEvent_1034_flag_set(proxy, param)
	print("OnEvent_1034_flag_set begin");
		
	proxy:SetEventFlag( 1034 , 1 );
	proxy:DeleteEvent( 1034 );

	print("OnEvent_1034_flag_set end");
end


--------------------------------------------------------------------------------------
--中ボスポリ劇再生■1036
--------------------------------------------------------------------------------------

function OnEvent_1036(proxy, param)
	print("OnEvent_1036 begin");

	--ポリ劇再生開始
	proxy:RequestRemo(20201,REMO_FLAG,1036,1);
	proxy:SetEventFlag( 1036 , 1 );--ポリ劇再生終了
	
	print("OnEvent_1036 end");
end


--■1036_RemoStart■ポリ劇開始 フェードアウト完了■
function OnEvent_1036_RemoStart(proxy,param)
	print( "OnEvent_1036_RemoStart begin" );
	
	print("ポリ劇再生開始");
	proxy:SetDrawEnable( 802 , false );--王の剣 表示OFF
	proxy:SetDrawEnable( 453 , false );--獄吏(453)が中にいるようになったので消す
	
	print( "OnEvent_1036_RemoStart end" );
end


--■1036_RemoFinish■ポリ劇再生終了後■
function OnEvent_1036_RemoFinish(proxy , param)
	print( "OnEvent_1036_RemoFinish begin" );

	print("ポリ劇終了");
	proxy:SetDrawEnable( 802 , true );--王の剣 表示ON

	--獄吏(453)が中ボス部屋の中で死んでいる	
	proxy:StopLoopAnimation( 453 );
	proxy:PlayLoopAnimation( 453 , 2210 );--死亡待機
	proxy:SetColiEnable( 453 , false );--当たりOFF
	proxy:SetDrawEnable( 453 , true );--描画ON
	proxy:EnableLogic( 453 , false );
	proxy:Warp( 453 , 2505 );--死んでいる位置の領域
	proxy:EnableHide( 453 , true );--探索されない
	proxy:EnableInvincible( 453 , true );--完全無敵(投げ対策)
	
	print( "OnEvent_1036_RemoFinish end" );
end


--------------------------------------------------------------------------------------
--ボスが動き出す(戦闘開始)■1037
--------------------------------------------------------------------------------------

function OnEvent_1037(proxy, param)
	print("OnEvent_1037 begin");
	
	--ボス戦用BGM再生開始
	proxy:PlayPointSE( 2520, SOUND_TYPE_M, 20200000, 2 );
	
	--ボスロジックON
	proxy:EnableLogic( 802 , true );	
	if proxy:IsCompleteEvent( BIYO_STATE_SEARCH_3 ) == true then
		ValidCharactor( proxy, 627 );
		proxy:EnableLogic( 627,true );
		--[[
		proxy:TurnCharactor( 627, 2580 );
		if proxy:IsClient() == false then
			proxy:OnChrAnimEnd( 1430, 627, -1, "OnEvent_1430", once );
		end
		]]
	end
	
	--ボスゲージ表示
	proxy:SetBossGauge( 802 , 0 ,5020 );
	
	print("OnEvent_1037 end");
end


--------------------------------------------------------------------------------------
--ハシゴ1降り■1210
--------------------------------------------------------------------------------------
--■1210■ハシゴ1降りスタート■
function OnEvent_1210(proxy, param)
	print("OnEvent_1210 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1210 end");
		return;
	end

	--はしご降りに必要な前処理--
	proxy:BeginAction(10000,2,2,2);				--ホバー移動モードに移行
	--proxy:HoverMoveVal(10000,2002,LadderTime_A);--移動位置(2002)に0.5秒でホバー移動
	proxy:HoverMoveValDmy(10000,1540,192,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動
	proxy:SetEventCommand(10000,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行
		proxy:OnKeyTime2(1210,"OnEvent_1210_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理)
		proxy:OnKeyTime2(1210,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_1210 end");
end

--■1210_1■ハシゴA降りスタート:ホバー移動終了■
function OnEvent_1210_1(proxy, param)
	print("OnEvent_1210_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1210_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	proxy:BeginAction(10000,1,3,2);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1210_1 end");
end


--------------------------------------------------------------------------------------
--ハシゴ1昇り■1211
--------------------------------------------------------------------------------------
--■1211■ハシゴ1昇りスタート■
function OnEvent_1211(proxy, param)
	print("OnEvent_1211 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1211 end");
		return;
	end
	
	--はしご昇りに必要な前処理--
	proxy:BeginAction(10000,2,-1,1);			--ホバー移動モードに移行
	--proxy:HoverMoveVal(10000,2003,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動
	proxy:HoverMoveValDmy(10000,1540,191,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動
	proxy:SetEventCommand(10000,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご昇りスタートイベントを発行
		proxy:OnKeyTime2(1,"OnEvent_1211_1",LadderTime_A,0,0,once);
		--はしご昇り用の関数を1秒間発行(イベントメニューの中断処理?)
		proxy:OnKeyTime2(1,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1211 end");
end

--■1211_1■ハシゴ1昇りスタート:ホバー移動終了■
function OnEvent_1211_1(proxy, param)
	print("OnEvent_1211_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1211_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	proxy:BeginAction(10000,1,-1,2);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1211_1 end");
end

--------------------------------------------------------------------------------------
--ハシゴ2降り■1212
--------------------------------------------------------------------------------------
--■1212■ハシゴ1降りスタート■
function OnEvent_1212(proxy, param)
	print("OnEvent_1212 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1212 end");
		return;
	end

	--はしご降りに必要な前処理--
	proxy:BeginAction(10000,2,2,2);				--ホバー移動モードに移行
	--proxy:HoverMoveVal(10000,2002,LadderTime_A);--移動位置(2002)に0.5秒でホバー移動
	proxy:HoverMoveValDmy(10000,1541,192,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動
	proxy:SetEventCommand(10000,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行
		proxy:OnKeyTime2(1212,"OnEvent_1212_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理)
		proxy:OnKeyTime2(1212,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_1212 end");
end

--■1212_1■ハシゴA降りスタート:ホバー移動終了■
function OnEvent_1212_1(proxy, param)
	print("OnEvent_1212_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1212_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	proxy:BeginAction(10000,1,3,2);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1212_1 end");
end


--------------------------------------------------------------------------------------
--ハシゴ2昇り■1213
--------------------------------------------------------------------------------------
--■1213■ハシゴ1昇りスタート■
function OnEvent_1213(proxy, param)
	print("OnEvent_1213 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1213 end");
		return;
	end
	
	--はしご昇りに必要な前処理--
	proxy:BeginAction(10000,2,-1,1);			--ホバー移動モードに移行
	--proxy:HoverMoveVal(10000,2003,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動
	proxy:HoverMoveValDmy(10000,1541,191,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動
	proxy:SetEventCommand(10000,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご昇りスタートイベントを発行
		proxy:OnKeyTime2(1,"OnEvent_1213_1",LadderTime_A,0,0,once);
		--はしご昇り用の関数を1秒間発行(イベントメニューの中断処理?)
		proxy:OnKeyTime2(1,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1213 end");
end

--■1213_1■ハシゴ1昇りスタート:ホバー移動終了■
function OnEvent_1213_1(proxy, param)
	print("OnEvent_1213_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1213_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	proxy:BeginAction(10000,1,-1,2);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1213_1 end");
end

--------------------------------------------------------------------------------------
--ハシゴ3降り■1214
--------------------------------------------------------------------------------------
--■1214■ハシゴ3降りスタート■
function OnEvent_1214(proxy, param)
	print("OnEvent_1214 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1214 end");
		return;
	end

	--はしご降りに必要な前処理--
	proxy:BeginAction(10000,2,2,2);				--ホバー移動モードに移行
	--proxy:HoverMoveVal(10000,2002,LadderTime_A);--移動位置(2002)に0.5秒でホバー移動
	proxy:HoverMoveValDmy(10000,1542,192,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動
	proxy:SetEventCommand(10000,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行
		proxy:OnKeyTime2(1214,"OnEvent_1214_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理)
		proxy:OnKeyTime2(1214,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_1214 end");
end

--■1214_1■ハシゴA降りスタート:ホバー移動終了■
function OnEvent_1214_1(proxy, param)
	print("OnEvent_1214_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1214_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	proxy:BeginAction(10000,1,3,2);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1214_1 end");
end


--------------------------------------------------------------------------------------
--ハシゴ3昇り■1215
--------------------------------------------------------------------------------------
--■1215■ハシゴ3昇りスタート■
function OnEvent_1215(proxy, param)
	print("OnEvent_1215 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1215 end");
		return;
	end
	
	--はしご昇りに必要な前処理--
	proxy:BeginAction(10000,2,-1,1);			--ホバー移動モードに移行
	--proxy:HoverMoveVal(10000,2003,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動
	proxy:HoverMoveValDmy(10000,1542,191,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動
	proxy:SetEventCommand(10000,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご昇りスタートイベントを発行
		proxy:OnKeyTime2(1,"OnEvent_1215_1",LadderTime_A,0,0,once);
		--はしご昇り用の関数を1秒間発行(イベントメニューの中断処理?)
		proxy:OnKeyTime2(1,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1215 end");
end

--■1215_1■ハシゴ1昇りスタート:ホバー移動終了■
function OnEvent_1215_1(proxy, param)
	print("OnEvent_1215_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1215_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	proxy:BeginAction(10000,1,-1,2);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1215_1 end");
end




--------------------------------------------------------------------------------------
--■1220■幽閉する敵が怒る■
--------------------------------------------------------------------------------------
--■領域監視
function OnEvent_1220(proxy , param)

	--幽閉する敵が怒り済みだったら、監視削除
	if proxy:IsCompleteEvent( 1220 ) == true then
		proxy:DeleteEvent( 1220 );
		print("OnEvent_1220 end");
		return;
	end
	
	--獄吏帽子を装備しているかを見る
	if proxy:IsEquip(TYPE_PROTECTER,101800) == false then--装備していない
		if proxy:IsCompleteEvent( 1225 ) == true then
			proxy:LuaCallStart( 1220, 1 );--獄吏怒るイベント発動			
		end
		print("bousi")
	else
		if proxy:IsCompleteEvent( 1225 ) == false then
			proxy:LuaCallStart( 1225, 1 );--獄吏、階段おろしてくれるイベント発動
		end		
	end	
end

--■獄吏が怒る用
function OnEvent_1220_hostile(proxy , param)
	print("OnEvent_1220_hostile begin");
	
	proxy:EnableLogic( 454 , true );--ロジックON
	
	proxy:DeleteEvent( 1220 );--怒ったので監視削除
	proxy:DeleteEvent( 1225 );--階段おろしてくれる用の監視削除
	
	proxy:SetEventFlag( 1220 , 1 );
	
	print("OnEvent_1220_hostile end");
end

--獄吏を攻撃して怒らせる用
function OnEvent_1220_Damage(proxy,param)
	print("OnEvent_1220_Damage begin");
	proxy:LuaCallStart( 1220, 1 );--獄吏怒るイベント発動
	print("OnEvent_1220_Damage end");
end


--------------------------------------------------------------------------------------
--■1225■偽装に成功すると、階段を降ろしてくれる■
--------------------------------------------------------------------------------------

--↓1220の領域監視から呼ばれる

--■1225■偽装に成功すると、階段を降ろしてくれる■
function OnEvent_1225(proxy , param)
	print("OnEvent_1225 begin");
	
	--幽閉する敵が死んでいたら、監視削除
	if proxy:IsCompleteEvent( 1222 ) == true then
		proxy:DeleteEvent( 1220 );
		print("OnEvent_1225 end");
		return;
	end
	
	--幽閉する敵が怒り済みだったら、監視削除
	if proxy:IsCompleteEvent( 1220 ) == true then
		proxy:DeleteEvent( 1220 );
		print("OnEvent_1225 end");
		return;
	end

	proxy:PlayAnimation( 454 , 7001 );--獄吏がレバーを引くアニメ
	proxy:PlayAnimation( 1462 , 1 );--レバーが動くアニメ
	
	proxy:NotNetMessage_begin();
		--▼レバーが動くアニメ終了▼
		proxy:OnCharacterAnimEnd( 1225 , 1462 , 1 , "OnEvent_1225_lever_end" , once );				
	proxy:NotNetMessage_end();
	
	print("OnEvent_1225 end");
end

--▲レバーが動くアニメ終了▲
function OnEvent_1225_lever_end(proxy , param)
	print("OnEvent_1225_lever_end begin");
	proxy:NotNetMessage_begin();
		proxy:OnSimpleDamage( 1220 , 454 , 10000 , "OnEvent_1220_Damage" , once );--ダメージ監視
	proxy:NotNetMessage_end();
	proxy:PlayAnimation( 1550 , 1 );--階段が降りる
	proxy:SetEventFlag( 1225 , 1 );
	print("OnEvent_1225_lever_end end");
end



--------------------------------------------------------------------------------------
--■1222■幽閉する敵の死亡チェック■
--------------------------------------------------------------------------------------

--■1222■幽閉する敵の死亡チェック■
function OnEvent_1222(proxy , param)
	print("OnEvent_1222 begin");
	
	proxy:SetEventFlag( 1222 , 1 );--幽閉する敵、死亡。
	
	--魔女イベント用の判定をここに･･･。
	
	--魔女の状態を取得
	local now_state = GetNpcStateFlag( proxy, param, majo_flag_list );
	
	--「解放してほしい」でない場合、何もしない
	if now_state ~= MAJO_STATE_LIBERATE then
		print("OnEvent_1222 end");
		return;
	end
	
	--幽閉する敵に偽装成功してなかったら何もしない
	if proxy:IsCompleteEvent( 1225 ) == false then
		print("OnEvent_1222 end");
		return;
	end

	--魔女の状態を「感謝」にする。
	SetNpcStateFlag( proxy , param , majo_flag_list , MAJO_STATE_THANKS );
	proxy:SetEventFlag( 1380 , 1 );--対応するアクションフラグをたてておく。
	
	print("OnEvent_1222 end");
end


--------------------------------------------------------------------------------------
--■11500■魔女がアイテムを渡し休憩する■(会話システムから呼び出し)
--------------------------------------------------------------------------------------

--■11500■魔女がアイテムを渡し休憩する■
function OnEvent_11500(proxy , param)
	print("OnEvent_11500 begin");
	
	--魔女の状態を取得
	local now_state = GetNpcStateFlag( proxy, param, majo_flag_list );
	
	--状態が「感謝」でなかったら処理抜け。
	if now_state ~= MAJO_STATE_THANKS then
		print("OnEvent_11500 end");
		return;
	end
	
	--アイテム取得関数
	--proxy:GetRateItem(10101);
	
	--魔女の状態を「塔で休憩」にする。
	SetNpcStateFlag( proxy , param , majo_flag_list , MAJO_STATE_BREAK );
	
	proxy:SetEventFlag( 11500, 1 );
	
	print("OnEvent_11500 end");
end


--------------------------------------------------------------------------------------
--■1381■魔女が敵対する■
--------------------------------------------------------------------------------------

--■1381■魔女が敵対する■
function OnEvent_1381(proxy , param)
	print("OnEvent_1381 begin");
	
	--魔女の状態を取得
	local now_state = GetNpcStateFlag( proxy, param, majo_flag_list );
	
	--状態が「解放してほしい」でも、「感謝」でも、「塔で休憩」でもない場合処理抜け。
	if now_state ~= MAJO_STATE_LIBERATE and
	   now_state ~= MAJO_STATE_THANKS   and
	   now_state ~= MAJO_STATE_BREAK    then
		print("OnEvent_1381 end");
		return;
	end
	
	--魔女の状態を「敵対」にする。
	proxy:EnableLogic( 625 , true );
	SetNpcStateFlag( proxy , param , majo_flag_list , MAJO_STATE_HOSTILE );
	proxy:SetTeamType( 625, TEAM_TYPE_AngryFriend );
	proxy:SetEventFlag( 1381, 1 );

	print("OnEvent_1381 end");
end


--------------------------------------------------------------------------------------
--■1382■魔女が死亡する■
--------------------------------------------------------------------------------------

--■1382■魔女が死亡する■
function OnEvent_1382(proxy , param)
	print("OnEvent_1382 begin");
	
	--魔女の状態を「死亡」にする。
	SetNpcStateFlag( proxy , param , majo_flag_list , MAJO_STATE_DEAD );
	proxy:SetEventFlag( 1382, 1 );	

	print("OnEvent_1382 end");
end





--------------------------------------------------------------------------------------
--■1310■レンドル王子が門の前に移動する■
--------------------------------------------------------------------------------------
function OnEvent_1310(proxy,param)
	print("OnEvent_1310 begin");	

	--王城3で「門を開けてほしい」に 状態遷移を試みる
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_WANT_TO_OPEN_THE_GATE );
	
		--proxy:DisableInterupt( 621, true );--割り込みを遮断(敵に攻撃されても戦闘ロジックにしないため)
		proxy:Warp( 621 , 2551 );--初期位置にワープ
		proxy:ChangeInitPosAng( 621 , 2552 );--巣を門の前の領域にする
		proxy:EnableLogic( 621 , true );--ロジックON
		proxy:SendEventRequest( 621 , 0 , 10 );--「問答無用で巣まで走る(ID:10)」のロジックに切り替え
		proxy:ResetThink( 621 );
	
	proxy:SetEventFlag( 1310 , 1 );--レンドル王子が門の前に移動するイベントの終了
	
	--しばらくすると、追ってくる敵が出現する
	
	proxy:NotNetMessage_begin();
		--▼王子を追う敵が出現する1▼
		proxy:OnKeyTime2( 1350 , "OnEvent_1350" , 3.0 , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	proxy:NotNetMessage_begin();
		--▼王子を追う敵が出現する2▼
		proxy:OnKeyTime2( 1351 , "OnEvent_1351" , 5.0 , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	proxy:NotNetMessage_begin();
		--▼王子を追う敵が出現する3▼
		proxy:OnKeyTime2( 1352 , "OnEvent_1352" , 7.0 , 0 , 1 , once );
	proxy:NotNetMessage_end();
	proxy:DeleteEvent( 1310 );

	print("OnEvent_1310 end")
end



--------------------------------------------------------------------------------------
--■1350■王子を追う敵が出現する1■
--------------------------------------------------------------------------------------
function OnEvent_1350(proxy,param)
	print("OnEvent_1350 begin");	

	ValidCharactor( proxy, 460 );--対応する敵を有効化
	proxy:ChangeTarget( 460 , 621 );--敵のターゲットを王子に設定
	proxy:SetEventFlag( 1350 , 1 );
	proxy:Warp( 460, 2560 );
	proxy:SetAlwayEnableBackread_forEvent( 460 , true );
	LuaFunc_ForceOmission( proxy,460);	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1350 ,"OnEvent_1350_1",5.0,0,10,once);
	proxy:NotNetMessage_end();

	print("OnEvent_1350 end")
end

function OnEvent_1350_1(proxy,param)
	print("OnEvent_1350_1 begin");
	LuaFunc_NormalOmission(proxy,460);
	proxy:SetAlwayEnableBackread_forEvent( 460 , false );
	print("OnEvent_1350_1 end")
end

--------------------------------------------------------------------------------------
--■1351■王子を追う敵が出現する2■
--------------------------------------------------------------------------------------
function OnEvent_1351(proxy,param)
	print("OnEvent_1351 begin");	

	ValidCharactor( proxy, 461 );--対応する敵を有効化
	proxy:ChangeTarget( 461 , 621 );--敵のターゲットを王子に設定
	proxy:SetEventFlag( 1351 , 1 );
	proxy:Warp( 461, 2561 );
	proxy:SetAlwayEnableBackread_forEvent( 461 , true );
	LuaFunc_ForceOmission( proxy,461);	
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1351 ,"OnEvent_1351_1",5,0,10,once);
	proxy:NotNetMessage_end();

	print("OnEvent_1351 end")
end

function OnEvent_1351_1(proxy,param)
	print("OnEvent_1351_1 begin");
	LuaFunc_NormalOmission(proxy,461);
	proxy:SetAlwayEnableBackread_forEvent( 461 , false );
	print("OnEvent_1351_1 end");
end

--------------------------------------------------------------------------------------
--■1352■王子を追う敵が出現する3■
--------------------------------------------------------------------------------------
function OnEvent_1352(proxy,param)
	print("OnEvent_1352 begin");	

	ValidCharactor( proxy, 462 );--対応する敵を有効化
	proxy:ChangeTarget( 462 , 621 );--敵のターゲットを王子に設定
	proxy:SetEventFlag( 1352 , 1 );
	proxy:Warp( 462, 2562 );
	proxy:SetAlwayEnableBackread_forEvent( 462 , true );
	LuaFunc_ForceOmission( proxy,462);
	--proxy:ForceChangeTarget( 460 , 622 );	
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1352 ,"OnEvent_1352_1",5,0,10,once);
	proxy:NotNetMessage_end();

	print("OnEvent_1352 end")
end


function OnEvent_1352_1(proxy,param)
	print("OnEvent_1352_1 begin");
	LuaFunc_NormalOmission(proxy,462);
	proxy:SetAlwayEnableBackread_forEvent( 462 , false );
	print("OnEvent_1352_1 end");
end


--------------------------------------------------------------------------------------
--■1311■王子が袋小路に移動する■
--------------------------------------------------------------------------------------
--[[
--■発動条件のチェック
function Check_OnEvent_1311(proxy,param)

	--レンドル王子の状態取得
	local now_state = GetRendolState(proxy, param);
	
	--「門を開けてほしい」でない場合、未成立
	if now_state ~= RENDOL_STATE_WANT_TO_OPEN_THE_GATE then
		return false;
	end	
	
	--城門開放レバーを引いてなかったら、未成立
	if proxy:IsCompleteEvent( 1040 ) == false then
		return false;
	end
	
	--条件成立
	return true;
end
]]

--■1311■王子が袋小路に移動する■
function OnEvent_1311(proxy,param)
	print("OnEvent_1311 begin");	
	
	
	--王城3で「袋小路怯え」に 状態遷移を試みる
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_SCARED );
		
	proxy:SendEventRequest( 621 , 0 , 10 );--「問答無用で巣まで走る(ID:10)」のロジックに切り替え	
	proxy:ChangeInitPosAng( 621 , 2553 );--巣を袋小路の領域にする
	proxy:ClearTarget( 621 );
	proxy:ResetThink( 621 );
	proxy:SetEventFlag( 1311 , 1 );--王子が袋小路に移動するイベントの終了
	
	--王子を追ってくる敵が門の先まで追ってくるように巣を変える
	
	proxy:NotNetMessage_begin();
		--▼王子を追う敵の巣を変える1▼
		proxy:OnKeyTime2( 1360 , "OnEvent_1360" ,  5.0 , 0 , 1 , once );
	proxy:NotNetMessage_end();
	proxy:NotNetMessage_begin();
		--▼王子を追う敵の巣を変える2▼
		proxy:OnKeyTime2( 1361 , "OnEvent_1361" ,  8.0 , 0 , 1 , once );
	proxy:NotNetMessage_end();
	proxy:NotNetMessage_begin();
		--▼王子を追う敵の巣を変える3▼
		proxy:OnKeyTime2( 1362 , "OnEvent_1362" , 11.0 , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1311 end")
end



--------------------------------------------------------------------------------------
--■1360■王子を追う敵の巣を変える1■
--------------------------------------------------------------------------------------
function OnEvent_1360(proxy,param)
	print("OnEvent_1360 begin");	

	if proxy:IsAlive(460) == true then
		proxy:ChangeInitPosAng( 460 , 2570 );--門の先の領域に巣を変える
		LuaFunc_ForceOmission(proxy,460);
	end
	proxy:SetEventFlag( 1360 , 1 );

	print("OnEvent_1360 end")
end


--------------------------------------------------------------------------------------
--■1361■王子を追う敵の巣を変える2■
--------------------------------------------------------------------------------------
function OnEvent_1361(proxy,param)
	print("OnEvent_1361 begin");	
	
	if proxy:IsAlive( 461 ) == true then
		proxy:ChangeInitPosAng( 461 , 2571 );--門の先の領域に巣を変える
		LuaFunc_ForceOmission(proxy,461);
	end
	proxy:SetEventFlag( 1361 , 1 );

	print("OnEvent_1361 end")
end


--------------------------------------------------------------------------------------
--■1362■王子を追う敵の巣を変える3■
--------------------------------------------------------------------------------------
function OnEvent_1362(proxy,param)
	print("OnEvent_1362 begin");	
	
	if proxy:IsAlive( 462 ) == true then
		proxy:ChangeInitPosAng( 462 , 2572 );--門の先の領域に巣を変える
		LuaFunc_ForceOmission( proxy, 462 );
	end
	proxy:SetEventFlag( 1362 , 1 );

	print("OnEvent_1362 end")
end



--------------------------------------------------------------------------------------
--■1312■王子が袋小路に到着したら怯えさせる■
--------------------------------------------------------------------------------------

--■1312■王子が袋小路に到着したら怯えさせる■
function OnEvent_1312(proxy,param)
	print("OnEvent_1312 begin");	
	
	if	proxy:IsCompleteEvent(1313) == false then
		proxy:SendEventRequest( 621 , 0 , AI_EVENT_None );--ロジックを切り替えてたのをやめる。
		proxy:ResetThink( 621 );
		
		--proxy:EnableLogic( 621 , false );--ロジックOFF
		proxy:SetSpStayAndDamageAnimId(621,7600,9600);
		--proxy:NotNetMessage_begin();
			--proxy:OnKeyTime2( 1312, "OnEvent_1312_1", 1.0, 1, 2, once );
		--proxy:NotNetMessage_end();
	else
		SetNpcStateFlag(proxy, param, rendol_flag_list, RENDOL_STATE_THANKS_3);
		proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "RendolCheck", 0.0, 0, 2, once );
	end
	
	proxy:SetEventFlag( 1312 , 1 );
	
	print("OnEvent_1312 end")
end

--[[
function OnEvent_1312_1(proxy,param)
	proxy:SetEventCommand( 621 , 40 );--EzStateに制御番号を送る(怯える)
end
]]

--[[
--------------------------------------------------------------------------------------
--■1313■王子が感謝する■
--------------------------------------------------------------------------------------

--■発動条件のチェック
function Check_OnEvent_1313(proxy,param)

	--レンドル王子の状態取得
	local now_state = GetRendolState(proxy, param);
	
	--「袋小路怯え」でなかったら、未成立
	if now_state ~= RENDOL_STATE_SCARED then
		return false;
	end
	
	--[[兵士の死亡監視がない。のでひとまず以前のIDで判定]]
	if proxy:IsCompleteEvent( 1410 ) == true and
	   proxy:IsCompleteEvent( 1411 ) == true and
	   proxy:IsCompleteEvent( 1412 ) == true then
		print("追ってきている兵士を全て倒しました");
		return true;
	end
	
	return false;
end
]]

--■1313■王子が感謝する■
function OnEvent_1313(proxy,param)
	print("OnEvent_1313 begin");

	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1313, "OnEvent_1313_1", 1.0, 1, 2, once );
	proxy:NotNetMessage_end();
	
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_THANKS_3 );
	--RendolCheck(proxy,param);
	
	proxy:SetEventFlag( 1313 , 1 );
	
	print("OnEvent_1313 end")
end

function OnEvent_1313_1(proxy,param)
	--proxy:SetEventCommand( 621 , 41 );--EzStateに制御番号を送る(怯え終了)
	proxy:SetSpStayAndDamageAnimId(621,-1,-1);
end

--------------------------------------------------------------------------------------
--■11501■王子が探索を開始する■(会話システムから呼び出し)
--------------------------------------------------------------------------------------

function OnEvent_11501(proxy,param)
	print("OnEvent_11501 begin");
	
	--アイテム取得関数
	proxy:GetRateItem(10191);
	
	proxy:SetEventFlag( 11501, 1 );
	--ワープされるのでRendolCheckは無し
	--王城3で探索に 状態遷移
	SetNpcStateFlag(proxy, param, rendol_flag_list, RENDOL_STATE_SEARCH_3);
	RendolCheck(proxy,param);


	print("OnEvent_11501 end")
end

--[[
--------------------------------------------------------------------------------------
--■1315■王子が次のブロックに移動する■
--------------------------------------------------------------------------------------

function Check_OnEvent_1315( proxy , param )

	--生存プレイヤー(グレイ)のみ判定
	if proxy:IsLivePlayer() == false and
	   proxy:IsGreyGhost()  == false then
		return false;
	end
	
	--ボス(王の剣)生きてたら判定しない
	if proxy:IsCompleteEvent( 4360 ) == false then
		return false;
	end
	
	--距離判定
	if proxy:IsDistance( 10000 , 621 , 20 ) == true then
		return false;
	else
		print("レンドル王子、次ブロックへ移動");
		return true;
	end
	
	return false;
end
]]

function OnEvent_1315( proxy , param )
	print("OnEvent_1315 begin");
	
	--王城4エレベータ前に 状態遷移
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_LIFT_FRONT);
	RendolCheck(proxy,param);
	
	proxy:SetEventFlag( 1315 , 1 );--イベント終了
	
	print("OnEvent_1315 end");
end


--------------------------------------------------------------------------------------
--■1316■レンドル王子が敵対する(城門前)■
--------------------------------------------------------------------------------------

function OnEvent_1316(proxy,param)
	print("OnEvent_1316 begin");
	if	proxy:IsCompleteEvent( RENDOL_STATE_WANT_TO_OPEN_THE_GATE ) == true then
	--敵対(王城3 城門前)に 状態遷移を試みる
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HOSTILE_3_FRONT_GATE);
	RendolCheck(proxy,param);

	proxy:SetEventFlag( 1316 , 1 );
	end
	
	print("OnEvent_1316 end");
end


--------------------------------------------------------------------------------------
--■1317■レンドル王子が敵対する(城門後ろ)■
--------------------------------------------------------------------------------------

function OnEvent_1317(proxy,param)
	print("OnEvent_1317 begin");
	
	if	proxy:IsCompleteEvent( RENDOL_STATE_SCARED )	== true or
		proxy:IsCompleteEvent( RENDOL_STATE_THANKS_3 )	== true or
		proxy:IsCompleteEvent( RENDOL_STATE_SEARCH_3 )	== true then
	--敵対(王城3 城門後ろ)に 状態遷移を試みる
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HOSTILE_3_BACK_GATE);
	RendolCheck(proxy,param);

	proxy:SetEventFlag( 1317 , 1 );
	end
	
	print("OnEvent_1317 end");
end


--------------------------------------------------------------------------------------
--■1338■レンドル王子が行き止まり用領域に入った■
--------------------------------------------------------------------------------------
function OnEvent_1338_in(proxy,param)
	print("OnEvent_1338_in begin");
	proxy:SetEventFlag( 1338 , true );
	print("OnEvent_1338_in end");
end

--領域から出た
function OnEvent_1338_out(proxy,param)
	print("OnEvent_1338_out begin");
	proxy:SetEventFlag( 1338 , false );
	print("OnEvent_1338_out end");
end




--------------------------------------------------------------------------------------
--■1318■レンドル王子が死亡する■
--------------------------------------------------------------------------------------

function OnEvent_1318(proxy,param)
	print("OnEvent_1318 begin");

	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_DEAD );
	RendolCheck(proxy,param);
	--死亡でRendolCheckする場合、その瞬間に消えてしまうので、
	--距離を見て再度有効にするか決める
	if	proxy:IsDistance( LOCAL_PLAYER, 621, 20 ) == true then
		ValidCharactor( proxy, 621 );
	end

	proxy:SetEventFlag( 1318 , 1 );
	
	print("OnEvent_1318 end");
end

--------------------------------------------------------------------------------------
--■1349■レンドル王子が門の前に到着したけど、門が閉まっている■
--------------------------------------------------------------------------------------
function OnEvent_1349(proxy,param)
	print("OnEvent_1349 begin");
	--門が開いていなければ、「問答無用で巣まで移動」を切って適当に戦わせる
	if	proxy:IsCompleteEvent( 1041 ) == false then
		proxy:SendEventRequest( 621 , 0 , AI_EVENT_None );--ロジックを切り替えてたのをやめる。
	end
	print("OnEvent_1349 end");
end

--------------------------------------------------------------------------------------
--■1410,1411,1412■一般兵士ABCの死亡監視■
--------------------------------------------------------------------------------------
function OnEvent_1410_1411_1412(proxy,param)
	print("OnEvent_1410_1411_1412 begin");
	
	proxy:SetEventFlag( param:GetParam1(), true );
	
	local flag_list = {1410, 1411, 1412};
	local flag_num  = table.getn( flag_list );
	
	--1つでも成立していない場合はreturnする
	for index = 1, flag_num, 1 do
		if	proxy:IsCompleteEvent( flag_list[index] ) == false then
			return;
		end
	end
	
	LuaFunc_NormalOmission(proxy,460);
	LuaFunc_NormalOmission(proxy,461);
	LuaFunc_NormalOmission(proxy,462);
	
	--レンドル王子の状態取得
	local now_state = GetRendolState(proxy, param);
	
	--「袋小路怯え」でなかったら、未成立
	if now_state ~= RENDOL_STATE_SCARED then
		--ｺｺではじかれてしまったらチェックポイントでおｋ
		--とりあえず成立でOK
		proxy:SetEventFlag( 1313 , true );
		return false;
	end
	
	OnEvent_1313(proxy,param);
	
	print("OnEvent_1410_1411_1412 end");
end


--------------------------------------------------------------------------------------
--■1250■燃える藁が転がり落ちてくる1■
--------------------------------------------------------------------------------------

function OnEvent_1250(proxy , param)
	print("OnEvent_1250 begin");

	if proxy:IsCompleteEvent( 1250 ) == true then
		print("OnEvent_1250 end");
		return;
	end
	
	proxy:PlayAnimation( 470 , 3002 );--兵士が蹴る
	
	proxy:NotNetMessage_begin();
		--▼1250_1▼兵士蹴りアニメ後▼
		proxy:OnKeyTime2( 1250 , "OnEvent_1250_1" , (16/30) , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1250 , 1 );
	
	print("OnEvent_1250 end");
end


--▲1250_1▲兵士蹴りアニメ後▲
function OnEvent_1250_1(proxy , param)
	print("OnEvent_1250_1 begin");

	proxy:PlayAnimation( 1496 , 1 );--火の藁転がる	
	
	proxy:SetEventFlag( 1250 , 0 );
	
	proxy:NotNetMessage_begin();
		--▼1250_2▼ダメージ球がでるのを遅らせる(蹴った本人に当たらないように)▼
		proxy:OnKeyTime2( 1250 , "OnEvent_1250_2" , 0.5 , 0 , 2 , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1250 , 1 );
	
	print("OnEvent_1250_1 end");
end


--▲1250_2▲ダメージ球がでるのを遅らせる(蹴った本人に当たらないように)▲
function OnEvent_1250_2(proxy , param)
	print("OnEvent_1250_2 begin");
	proxy:EnableLogic( 470 , true );--ロジックON(ひとまずここに･･･)
	--火の藁からダメージ球
	local paramid = 10010; --火属性ダメージ
	local rad     = DAMAGE_RADIUS;--半径
	local time    = 20; --ひとまずアニメ再生終了でダメージ球消すので、アニメより長い時間を指定しておく
	
	proxy:SetEventFlag( 1250 , 0 );

	proxy:OnObjectDamageHit_NoCall( 1250, 1496, 1, paramid, EV_HIT_CHR , rad, time, everytime );	
	proxy:SetObjEventCollisionFill( 1496, true );
	
	proxy:NotNetMessage_begin();
		--▼1250_anime_end▼火の藁転がり終わった▼
		proxy:OnCharacterAnimEnd( 1250 , 1496 , 1 , "OnEvent_1250_anime_end" , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1250 , 1 );	
	
	print("OnEvent_1250_2 end");
end


--▲1250_anime_end▲火の藁転がり終わった▲
function OnEvent_1250_anime_end( proxy , param )
	print("OnEvent_1250_anime_end begin");

	proxy:DeleteEvent( 1250 );--ダメージ球など削除
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		--proxy:OnKeyTime2( 1171 , "OnEvent_1171_1403",1.8,0,1403,once);			
		proxy:OnObjectDamageHit_NoCallPlus( 1171, 1403,1,10310,EV_HIT_CHR,1.2,-1,2.0,everytime);			
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();	

	print("OnEvent_1250_anime_end end");
end



--------------------------------------------------------------------------------------
--■1251■燃える藁が転がり落ちてくる2■
--------------------------------------------------------------------------------------

function OnEvent_1251(proxy , param)
	print("OnEvent_1251 begin");

	if proxy:IsCompleteEvent( 1251 ) == true then
		print("OnEvent_1251 end");
		return;
	end
	
	proxy:PlayAnimation( 471 , 3002 );--兵士が蹴る
	
	proxy:NotNetMessage_begin();
		--▼1251_1▼兵士蹴りアニメ後▼
		proxy:OnKeyTime2( 1251 , "OnEvent_1251_1" , (16/30) , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1251 , 1 );
	
	print("OnEvent_1251 end");
end


--▲1251_1▲兵士蹴りアニメ後▲
function OnEvent_1251_1(proxy , param)
	print("OnEvent_1251_1 begin");

	proxy:PlayAnimation( 1497 , 1 );--火の藁転がる	
	
	proxy:SetEventFlag( 1251 , 0 );
	
	proxy:NotNetMessage_begin();
		--▼1251_2▼ダメージ球がでるのを遅らせる(蹴った本人に当たらないように)▼
		proxy:OnKeyTime2( 1251 , "OnEvent_1251_2" , 0.5 , 0 , 2 , once );
		proxy:OnKeyTime2( 1251 , "OnEvent_1251_3" , 1.5 , 0 , 5 , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1251 , 1 );
	
	print("OnEvent_1251_1 end");
end


--▲1251_2▲ダメージ球がでるのを遅らせる(蹴った本人に当たらないように)▲
function OnEvent_1251_2(proxy , param)
	print("OnEvent_1251_2 begin");
	
	--火の藁からダメージ球
	local paramid = 10010; --火属性ダメージ
	local rad     = DAMAGE_RADIUS;--半径
	local time    = 20; --ひとまずアニメ再生終了でダメージ球消すので、アニメより長い時間を指定しておく
	
	proxy:SetEventFlag( 1251 , 0 );
	
	proxy:OnObjectDamageHit_NoCall( 1251, 1497, 1, paramid, EV_HIT_CHR , rad, time, everytime );	
	proxy:SetObjEventCollisionFill( 1497, true );
	
	proxy:NotNetMessage_begin();
		--▼1251_anime_end▼火の藁転がり終わった▼
		proxy:OnCharacterAnimEnd( 1251 , 1497 , 1 , "OnEvent_1251_anime_end" , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1251 , 1 );	
	
	print("OnEvent_1251_2 end");
end

--本人が動くのを遅らせる
function OnEvent_1251_3(proxy,param)
	print("OnEvent_1251_3 begin");
	proxy:EnableLogic( 471 , true );--ロジックON(ひとまずここに･･･)
	print("OnEvent_1251_3 end");
end

--▲1251_anime_end▲火の藁転がり終わった▲
function OnEvent_1251_anime_end( proxy , param )
	print("OnEvent_1251_anime_end begin");

	proxy:DeleteEvent( 1251 );--ダメージ球など削除

	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		--proxy:OnKeyTime2( 1172 , "OnEvent_1172_1404",1.9,0,1404,once);			
		proxy:OnObjectDamageHit_NoCallPlus( 1172, 1404,1,10310,EV_HIT_CHR,1.2,-1,2.0,everytime);			
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();	
	print("OnEvent_1251_anime_end end");
end



--------------------------------------------------------------------------------------
--■1260■ホストPCのみが通れる光の霧■
--------------------------------------------------------------------------------------

--■1260_delete_wall■魔法壁削除同期用■
function OnEvent_1260_delete_wall(proxy , param)
	print("OnEvent_1260_delete_wall begin");
	
	proxy:SetDrawEnable( 1560 , false );--描画OFF
	proxy:SetColiEnable( 1560 , false );--当たりOFF	
	proxy:SetObjDeactivate( 1560 , true );--デアクティブ
	proxy:InvalidSfx( 2425 , true );--SFX OFF
	proxy:DeleteEvent( 1260 );
	
	print("OnEvent_1260_delete_wall end");
end


--■1260■イベント発動用■
function OnEvent_1260(proxy , param)
	print("OnEvent_1260 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 1260 ) == true then
		print("OnEvent_1260 end");
		return;
	end
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 1260 , 1 );
		print("OnEvent_1260 end");
		return;
	end
	
	--ダミポリへワープ
	proxy:WarpDmy( 10000 , 1560 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼1260_1▼歩きアニメ終了▼
		--proxy:OnChrAnimEnd( 1260 , 10000 , ANIMEID_WALK , "OnEvent_1260_1" , once );
		proxy:LuaCallStart( 1260 , 1 );--光の霧削除同期
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1260 , 1 );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1260 end");
end


--▲1260_1▲歩きアニメ終了▲
function OnEvent_1260_1(proxy , param)
	print("OnEvent_1260_1 begin");
	
	proxy:LuaCallStart( 1260 , 1 );--光の霧削除同期
	
	print("OnEvent_1260_1 end");
end

--[[
--■1430■ビヨルングルム　王の剣の部屋にやってくる■
function OnEvent_1430(proxy,param)
	print("OnEvent_1430 begin");
	proxy:PlayAnimation( 627, ANIMEID_WALK );
	proxy:SetEventFlag( 1430, true );
	proxy:SetTeamType( 627 , TEAM_TYPE_BattleFriend );
	print("OnEvent_1430 end");
end
]]

--■1432■ビヨルングルム　敵対する■
function OnEvent_1432(proxy,param)
	print("OnEvent_1432 begin");
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_HOSTILE_IN_KING_ROOM );
	proxy:SetEventCommand( 627 , 51 );--EzStateに制御番号(立ち上がる)を渡す
	proxy:SetTeamType( 627, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2(627,5064);
	proxy:EnableLogic( 627, true );--ビヨロジックON
	proxy:SetEventFlag( 1432, true );
	print("OnEvent_1432 end");
end


--■1433■ビヨルングルム　死亡■
function OnEvent_1433(proxy,param)
	print("OnEvent_1433 begin");
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_DEAD );
	proxy:SetEventFlag( 1433, true );
	print("OnEvent_1433 end");
end

--■1460■ビヨルングルム　王の剣を倒して満足して寝る■
function OnEvent_1460(proxy,param)
	print("OnEvent_1460 begin");
	if	proxy:IsCompleteEvent( BIYO_STATE_KING_OF_SWORD_KILL ) == true then
		proxy:EnableLogic( 627, false );--ビヨロジックOFF
		proxy:SetEventCommand( 627, 60 );--EzStateに制御番号(寝る)を渡す
	end
	proxy:SetEventFlag( 1460, true );
	print("OnEvent_1460 end");
end

--■1470■ビヨルングルム　会話用監視■
function OnEvent_1470( proxy,param )
	print("OnEvent_1470 begin");
	proxy:SetEventFlag( 1470 , true );
	print("OnEvent_1470 end");
end

--------------------------------------------------------------------------------------
--奴隷兵士に一定ダメージ■1167
--------------------------------------------------------------------------------------
function OnEvent_1440(proxy,param)
	print("OnEvent_1440 begin");

	--ロジックOn
	proxy:EnableLogic( 679, true );
	
	--奴隷兵士の状態を敵対(王城3)にする
	SetNpcStateFlag(proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_HOSTILE03);
	--奴隷兵士のチームタイプを変更する
	proxy:SetTeamType( 679, TEAM_TYPE_AngryFriend );

	--フラグを立てる
	proxy:SetEventFlag( 1440, true );
	
	print("OnEvent_1440 end");
end


--------------------------------------------------------------------------------------
--奴隷兵士死亡■1168
--------------------------------------------------------------------------------------
function OnEvent_1441(proxy,param)
	print("OnEvent_1441 begin");

	--奴隷兵士の状態を「死亡」に変える
	SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_DEAD );
	
	--敵に削られて敵対を通り越して死亡もありえるので、ここでも削除
	--死んだら敵対にはならないので削除
	proxy:DeleteEvent( 341 );
	proxy:DeleteEvent( 760 );
	proxy:DeleteEvent( 1441 );

	--フラグを立てる
	proxy:SetEventFlag( 1441, true );
	
	print("OnEvent_1441 end");
end


-----------------------------------------------------------------------------
--■1110■QWCソウルモンスター出現１■
-----------------------------------------------------------------------------
function OnEvent_1110(proxy,param)
	print("OnEvent_1110 begin");
	
	--ソウルモンスター出現
	ValidCharactor( proxy, 180 );
	ValidCharactor( proxy, 181 );

	--ソウルモンスター出現アニメの再生
	proxy:PlayAnimation( 180, 6100 );
	proxy:PlayAnimation( 181, 6100 );
	
	--フラグON
	proxy:SetEventFlag( 1110, true );
	print("OnEvent_1110 end");
end


--------------------------------------------------------------------------------------
--カラスが飛び立つ
--------------------------------------------------------------------------------------
function FryAwayKarasu(proxy,param, KarasuEventID, karasuID, FryAnimeID)	
	print("FryAwayKarasu_"..karasuID.." begin");

	proxy:PlayAnimation( karasuID, FryAnimeID );

	proxy:NotNetMessage_begin();
		--▼カラスアニメ再生終了▼
		proxy:OnCharacterAnimEnd( KarasuEventID , karasuID , FryAnimeID , "OnEvent_"..KarasuEventID.."_1" , once );	
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( KarasuEventID , 1 );

	print("FryAwayKarasu_"..karasuID.." end");
end

-----------------------------------------
--カラスアニメ再生終了したので消していく
-----------------------------------------
function OnEvent_1121_1(proxy,param)	proxy:SetDrawEnable( 1565 , false ); print("KarasuFryAway ID=1565"); end
function OnEvent_1122_1(proxy,param)	proxy:SetDrawEnable( 1566 , false ); print("KarasuFryAway ID=1566"); end
function OnEvent_1123_1(proxy,param)	proxy:SetDrawEnable( 1567 , false ); print("KarasuFryAway ID=1567"); end
function OnEvent_1124_1(proxy,param)	proxy:SetDrawEnable( 1568 , false ); print("KarasuFryAway ID=1568"); end
function OnEvent_1125_1(proxy,param)	proxy:SetDrawEnable( 1569 , false ); print("KarasuFryAway ID=1569"); end
function OnEvent_1126_1(proxy,param)	proxy:SetDrawEnable( 1570 , false ); print("KarasuFryAway ID=1570"); end
function OnEvent_1127_1(proxy,param)	proxy:SetDrawEnable( 1571 , false ); print("KarasuFryAway ID=1571"); end
function OnEvent_1128_1(proxy,param)	proxy:SetDrawEnable( 1572 , false ); print("KarasuFryAway ID=1572"); end
function OnEvent_1129_1(proxy,param)	proxy:SetDrawEnable( 1573 , false ); print("KarasuFryAway ID=1573"); end
function OnEvent_1130_1(proxy,param)	proxy:SetDrawEnable( 1574 , false ); print("KarasuFryAway ID=1574"); end
function OnEvent_1131_1(proxy,param)	proxy:SetDrawEnable( 1575 , false ); print("KarasuFryAway ID=1575"); end
function OnEvent_1132_1(proxy,param)	proxy:SetDrawEnable( 1576 , false ); print("KarasuFryAway ID=1576"); end
function OnEvent_1133_1(proxy,param)	proxy:SetDrawEnable( 1577 , false ); print("KarasuFryAway ID=1577"); end
function OnEvent_1134_1(proxy,param)	proxy:SetDrawEnable( 1578 , false ); print("KarasuFryAway ID=1578"); end
function OnEvent_1135_1(proxy,param)	proxy:SetDrawEnable( 1579 , false ); print("KarasuFryAway ID=1579"); end
function OnEvent_1136_1(proxy,param)	proxy:SetDrawEnable( 1580 , false ); print("KarasuFryAway ID=1580"); end
function OnEvent_1137_1(proxy,param)	proxy:SetDrawEnable( 1581 , false ); print("KarasuFryAway ID=1581"); end
function OnEvent_1138_1(proxy,param)	proxy:SetDrawEnable( 1582 , false ); print("KarasuFryAway ID=1582"); end
function OnEvent_1139_1(proxy,param)	proxy:SetDrawEnable( 1583 , false ); print("KarasuFryAway ID=1583"); end
function OnEvent_1140_1(proxy,param)	proxy:SetDrawEnable( 1584 , false ); print("KarasuFryAway ID=1584"); end
function OnEvent_1141_1(proxy,param)	proxy:SetDrawEnable( 1585 , false ); print("KarasuFryAway ID=1585"); end
function OnEvent_1142_1(proxy,param)	proxy:SetDrawEnable( 1586 , false ); print("KarasuFryAway ID=1586"); end
function OnEvent_1143_1(proxy,param)	proxy:SetDrawEnable( 1587 , false ); print("KarasuFryAway ID=1587"); end
function OnEvent_1144_1(proxy,param)	proxy:SetDrawEnable( 1588 , false ); print("KarasuFryAway ID=1588"); end
function OnEvent_1145_1(proxy,param)	proxy:SetDrawEnable( 1589 , false ); print("KarasuFryAway ID=1589"); end
function OnEvent_1146_1(proxy,param)	proxy:SetDrawEnable( 1590 , false ); print("KarasuFryAway ID=1590"); end
function OnEvent_1147_1(proxy,param)	proxy:SetDrawEnable( 1591 , false ); print("KarasuFryAway ID=1591"); end
function OnEvent_1148_1(proxy,param)	proxy:SetDrawEnable( 1592 , false ); print("KarasuFryAway ID=1592"); end
function OnEvent_1149_1(proxy,param)	proxy:SetDrawEnable( 1593 , false ); print("KarasuFryAway ID=1593"); end
function OnEvent_1150_1(proxy,param)	proxy:SetDrawEnable( 1594 , false ); print("KarasuFryAway ID=1594"); end

---------------------------------
--カラスが飛び立つ関数を呼び出す
---------------------------------
function OnEvent_1121(proxy, param) FryAwayKarasu(proxy, param, 1121, 1565, 10); end
function OnEvent_1122(proxy, param) FryAwayKarasu(proxy, param, 1122, 1566, 11); end
function OnEvent_1123(proxy, param) FryAwayKarasu(proxy, param, 1123, 1567, 10); end
function OnEvent_1124(proxy, param) FryAwayKarasu(proxy, param, 1124, 1568, 11); end
function OnEvent_1125(proxy, param) FryAwayKarasu(proxy, param, 1125, 1569, 11); end
function OnEvent_1126(proxy, param) FryAwayKarasu(proxy, param, 1126, 1570, 11); end
function OnEvent_1127(proxy, param) FryAwayKarasu(proxy, param, 1127, 1571, 10); end
function OnEvent_1128(proxy, param) FryAwayKarasu(proxy, param, 1128, 1572, 11); end
function OnEvent_1129(proxy, param) FryAwayKarasu(proxy, param, 1129, 1573, 10); end
function OnEvent_1130(proxy, param) FryAwayKarasu(proxy, param, 1130, 1574, 11); end
function OnEvent_1131(proxy, param) FryAwayKarasu(proxy, param, 1131, 1575, 10); end
function OnEvent_1132(proxy, param) FryAwayKarasu(proxy, param, 1132, 1576, 11); end
function OnEvent_1133(proxy, param) FryAwayKarasu(proxy, param, 1133, 1577, 10); end
function OnEvent_1134(proxy, param) FryAwayKarasu(proxy, param, 1134, 1578, 11); end
function OnEvent_1135(proxy, param) FryAwayKarasu(proxy, param, 1135, 1579, 10); end
function OnEvent_1136(proxy, param) FryAwayKarasu(proxy, param, 1136, 1580, 11); end
function OnEvent_1137(proxy, param) FryAwayKarasu(proxy, param, 1137, 1581, 10); end
function OnEvent_1138(proxy, param) FryAwayKarasu(proxy, param, 1138, 1582, 11); end
function OnEvent_1139(proxy, param) FryAwayKarasu(proxy, param, 1139, 1583, 10); end
function OnEvent_1140(proxy, param) FryAwayKarasu(proxy, param, 1140, 1584, 12); end
function OnEvent_1141(proxy, param) FryAwayKarasu(proxy, param, 1141, 1585, 12); end
function OnEvent_1142(proxy, param) FryAwayKarasu(proxy, param, 1142, 1586, 12); end
function OnEvent_1143(proxy, param) FryAwayKarasu(proxy, param, 1143, 1587, 12); end
function OnEvent_1144(proxy, param) FryAwayKarasu(proxy, param, 1144, 1588, 12); end
function OnEvent_1145(proxy, param) FryAwayKarasu(proxy, param, 1145, 1589, 12); end
function OnEvent_1146(proxy, param) FryAwayKarasu(proxy, param, 1146, 1590, 12); end
function OnEvent_1147(proxy, param) FryAwayKarasu(proxy, param, 1147, 1591, 12); end
function OnEvent_1148(proxy, param) FryAwayKarasu(proxy, param, 1148, 1592, 12); end
function OnEvent_1149(proxy, param) FryAwayKarasu(proxy, param, 1149, 1593, 12); end
function OnEvent_1150(proxy, param) FryAwayKarasu(proxy, param, 1150, 1594, 12); end


--------------------------------------------------------------------------------------
--■1160■鉱石の精霊の死亡管理■
--------------------------------------------------------------------------------------
function OnEvent_1160(proxy,param)
	print("OnEvent_1160 begin");
	proxy:SetEventFlag(1160,true);
	print("OnEvent_1160 end");
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
--■1170■火藁ダメージ■
--------------------------------------------------------------------------------------
--[[
function ObjDamage2(proxy,eventid,objid)
	if proxy:IsReady_Obj(objid) == true then
		proxy:OnObjectDamageHit_NoCall( eventid, objid,1,10310,EV_HIT_CHR,1.2,FIREDAM_WAIT,everytime);
	end
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnKeyTime2( eventid , "OnEvent_"..eventid.."_"..objid.."_1",FIREDAM_WAIT,0,objid+10000,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
end

function ObjDamage2_1(proxy,eventid,objid)
	if proxy:IsReady_Obj(objid) == true then
		proxy:OnObjectDamageHit_NoCall( eventid, objid,1,10310,EV_HIT_CHR,1.2,FIREDAM_WAIT,everytime);
	end
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnKeyTime2( eventid , "OnEvent_"..eventid.."_"..objid,FIREDAM_WAIT,0,objid,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
end

function OnEvent_1170_1400(proxy,param) ObjDamage2(proxy,1170,1400); end
function OnEvent_1170_1400_1(proxy,param) ObjDamage2_1(proxy,1170,1400); end
function OnEvent_1170_1401(proxy,param) ObjDamage2(proxy,1170,1401); end
function OnEvent_1170_1401_1(proxy,param) ObjDamage2_1(proxy,1170,1401); end
function OnEvent_1170_1402(proxy,param) ObjDamage2(proxy,1170,1402); end
function OnEvent_1170_1402_1(proxy,param) ObjDamage2_1(proxy,1170,1402); end

function OnEvent_1171_1403(proxy,param) ObjDamage2(proxy,1171,1403); end
function OnEvent_1171_1403_1(proxy,param) ObjDamage2_1(proxy,1171,1403); end
function OnEvent_1172_1404(proxy,param) ObjDamage2(proxy,1172,1404); end
function OnEvent_1172_1404_1(proxy,param) ObjDamage2_1(proxy,1172,1404); end
]]

-----------------------------------------------------------------------------
--■1090■結晶トカゲイベント4
-----------------------------------------------------------------------------
function OnEvent_1090(proxy,param)
	print("OnEvent_1090 begin");
	proxy:SetEventFlag( 1090, true);
	proxy:DeleteEvent( 1090 );
	print("OnEvent_1090 end");
end
