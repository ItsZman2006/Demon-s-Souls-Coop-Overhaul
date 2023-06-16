
function Initialize_m02_01_00_00(proxy)
	print("Initialize_m02_01_00_00 begin");

--[[
--OBJのID512＝操作OBJ　ID513＝本体
--■512■バリスタイベント開始■
	proxy:RepeatMessage_begin();
		proxy:OnDistanceActionPlus(512, 10000, 1200, "OnEvent_512", 1.5, HELPID_START, 180, 45, 0,0,1,everytime);
	proxy:RepeatMessage_end();
	--ループアニメ同期用
	proxy:LuaCall(512,2,"OnEvent_512_2",everytime);
	
--■513■バリスタ同期用■同期用のイベントIDとバリスタ用OnBallistaのイベントIDは同じ、paramは変えない事
	proxy:LuaCall(513,0,"OnEvent_513_0",everytime);--0	…Y軸角度同期
	proxy:LuaCall(513,1,"OnEvent_513_1",everytime);--1	…X軸角度同期
	proxy:LuaCall(513,2,"OnEvent_513_2",everytime);--2	…バリスタ発射同期
	proxy:LuaCall(513,3,"OnEvent_513_3",everytime);--3	…バリスタ終了同期
	proxy:LuaCall(513,4,"OnEvent_513_4",everytime);--4	…バリスタダメージ終了
	proxy:LuaCall(513,5,"OnEvent_513_5",everytime);--5	…フラグ同期用
]]
	

--■582■ボス部屋に入る■
	
	--中ボスが生きているときだけイベント登録
	if proxy:IsCompleteEvent( 4224 ) == false then
	
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。
		SingleReset(proxy, 582);

		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き)
		proxy:LuaCall( 583, 1, "OnEvent_583_1", everytime );
		--▽2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCall( 583 , 5 , "OnEvent_582_GO_TO_IN" , everytime );
		--▽フラグセット(同期用)
		proxy:LuaCall( 583 , 6 , "OnEvent_582_flag_set" , everytime );
		
		--誰かがボス前扉をまだ通過していない
		if proxy:IsCompleteEvent( 582 ) == false then
		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--▼582▼中に入るためのイベントを追加▼
				proxy:OnPlayerActionInRegionAttribute( 582, 2894, "OnEvent_582", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --グレイゴーストできたときようにいると思われる。
		
			proxy:NotNetMessage_begin();
				--▼583▼中に入るためのイベントを追加▼--ハンドラは上と同じ
				proxy:OnPlayerActionInRegion( 583, 2894, "OnEvent_582", HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();		
		end
		proxy:SetColiEnableArray(3003,false);--通常無効
		proxy:SetColiEnableArray(3004,false);--通常無効
		proxy:SetColiEnableArray(3005,true);--ボス用有効
		proxy:SetColiEnableArray(3006,true);--ボス用有効	
	else
		proxy:SetColiEnableArray(3003,true);--通常有効
		proxy:SetColiEnableArray(3004,true);--通常有効
		proxy:SetColiEnableArray(3005,false);--ボス用無効
		proxy:SetColiEnableArray(3006,false);--ボス用無効
	end

	
--■584■ボスのポリ劇再生■

	if proxy:IsCompleteEvent( 584 ) == false then 
	
		--▼ボス前のポリ劇再生用監視追加
		proxy:OnRegionJustIn( 584 , 10000 , 2898 , "OnEvent_584" , once );
		
		proxy:NotNetMessage_begin();
			--ポリ劇開始に呼ばれるハンドラ
			proxy:LuaCall(584, REMO_START, "OnEvent_584_RemoStart", once);
			--ポリ劇終了後に呼ばれるハンドラ(トリガー起こした人用)
			proxy:LuaCall(584, REMO_FINISH, "OnEvent_584_RemoFinish", once);
		proxy:NotNetMessage_end();
	
	end


--■585■ボス戦闘開始■
	if proxy:IsCompleteEvent( 4224 ) == false then
		--シングルロード時初期化
		SingleReset( proxy , 585 );
		proxy:OnRegionJustIn( 585 , 10000 , 2886 , "OnEvent_585" , once );
	end


	
--■4224■中ボス死亡で何かが起こる■
	proxy:AddFieldInsFilter( 801 );
	if proxy:IsCompleteEvent( 4224 ) == false then		
		proxy:OnCharacterDead( 4224, 801, "OnEvent_4224", once );
	end
	

--■680■扉を鍵で開ける(サブイベント)■
	if proxy:IsCompleteEvent( 680 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceActionPlus( 680, 10000, 1202, "OnEvent_680", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, 0.7, -1.0, 0.0, everytime );
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 680, 1, "OnEvent_680_1", once );--アニメーション同期用
	else
		proxy:EndAnimation( 1202, 1 );
	end
	

--■682■扉を鍵で開ける(サブイベント)■
	if proxy:IsCompleteEvent( 682 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceActionPlus( 682, 10000, 1205, "OnEvent_682", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, 1.0, -1.0, 0.0, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 682, 1, "OnEvent_682_1", once );--アニメーション同期用
	else
		proxy:EndAnimation( 1205, 1 );
	end


--■684■扉を鍵で開ける(サブイベント)■
	if proxy:IsCompleteEvent( 684 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceActionPlus( 684, 10000, 1206, "OnEvent_684", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, 1.0, -1.0, 0.0, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 684, 1, "OnEvent_684_1", once );--アニメーション同期用
	else
		proxy:EndAnimation( 1206, 1 );
	end

--■686■扉を鍵で開ける(サブイベント)■
	if proxy:IsCompleteEvent( 686 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceActionPlus( 686, 10000, 1203, "OnEvent_686", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, 1.0, -1.0, 0.0, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 686, 1, "OnEvent_686_1", once );--アニメーション同期用
	else
		proxy:EndAnimation( 1203, 1 );
	end

--■688■扉を鍵で開ける(サブイベント)■
	if proxy:IsCompleteEvent( 688 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceActionPlus( 688, 10000, 1204, "OnEvent_688", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, 1.0, -1.0, 0.0, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 688, 1, "OnEvent_688_1", once );--アニメーション同期用
	else
		proxy:EndAnimation( 1204, 1 );
	end

	
--■??■徘徊デーモンの登場■ハンドラ登録
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。
		proxy:LuaCall( 4000, 100, "PlayerDeath_m02_01_00_00", everytime );
		--プレイヤーが復活した時にキックされます。
		proxy:LuaCall( 4032, 100, "PlayerRevive_m02_01_00_00", everytime );
	proxy:NotNetMessage_end();

--■15622■獄吏の死体を調べたか？■
	if proxy:IsCompleteEvent( 15622 ) == false then
		proxy:AddCorpseEvent( 15622 , 115 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15622 ,0 , "OnEvent_15622",once );
 		proxy:NotNetMessage_end();
	end
	
--■560■獄吏の死亡■	
	if proxy:IsCompleteEvent( 560 ) == false then
		proxy:OnCharacterDead( 560 , 115 , "OnEvent_560" , once );
	end
	
	
	

----- ▼ビヨルングルム▼ ----------------------------------------		

--■520■ビヨが感謝する■
	--(対応する扉を開けたときに 状態変更) 
--[[
	
--■521■ビヨが獄吏を倒しに行く■(会話システムから呼び出し)
	if proxy:IsCompleteEvent( 521 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 521 , 0 , "OnEvent_521" , once );--会話システムから呼び出す場合はparam=0を指定
		proxy:NotNetMessage_end();
	end
	
--■522■ビヨが牢屋内で寝る■(会話システムから呼び出し)
	if proxy:IsCompleteEvent( 522 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 522 , 0 , "OnEvent_522" , once );--会話システムから呼び出す場合はparam=0を指定
		proxy:NotNetMessage_end();
	end

--■523■ビヨが城壁で寝る■
	--(獄吏が死んだときに、判定)

--■524■ビヨが次のブロックへ移動する■
	--(獄吏が死んだときに、監視追加)

--■525■ビヨが牢内で敵になる■
	if proxy:IsCompleteEvent( 525 ) == false then
		proxy:OnCharacterTotalDamage( 525 , 622 , 10000 , 100 , "OnEvent_525" , once );
	end
	
--■526■ビヨが城壁で敵になる■
	if proxy:IsCompleteEvent( 526 ) == false then
		proxy:OnCharacterTotalDamage( 526 , 622 , 10000 , 100 , "OnEvent_526" , once );
	end
	
--■527■ビヨが死ぬ■
	if proxy:IsCompleteEvent( 527 ) == false then
		proxy:OnCharacterDead(527,622,"OnEvent_527",once);
	end
]]	
------- ▲ビヨルングルム▲ --------------------------------------	


--■652■レンドル追っかけ兵士Aの死亡■
	if proxy:IsCompleteEvent( 652 ) == false then
		--proxy:OnCharacterDead(652,102,"OnEvent_652",once);
		proxy:OnCharacterDead(652,102,"OnEvent_720",once);
	end
	
--■654■レンドル追っかけ兵士Bの死亡■
	if proxy:IsCompleteEvent( 654 ) == false then
		--proxy:OnCharacterDead(654,103,"OnEvent_654",once);
		proxy:OnCharacterDead(654,103,"OnEvent_720",once);
	end
	
--■655■レンドル追っかけ兵士Cの死亡■
	if proxy:IsCompleteEvent( 655 ) == false then
		proxy:OnCharacterDead(655,104,"OnEvent_720",once);
	end
	
--■656■レンドル追っかけ兵士Dの死亡■
	if proxy:IsCompleteEvent( 656 ) == false then
		proxy:OnCharacterDead(656,105,"OnEvent_720",once);
	end

--■657■レンドル追っかけ兵士Eの死亡■
	if proxy:IsCompleteEvent( 657 ) == false then
		proxy:OnCharacterDead(657,106,"OnEvent_720",once);
	end
	
--■658■レンドル追っかけ兵士Dの死亡■
	if proxy:IsCompleteEvent( 658 ) == false then
		proxy:OnCharacterDead(658,107,"OnEvent_720",once);
	end





--[[-- ▼乞食ショップ▼ -------------------------------------------------------

--■760■乞食の敵対化■
	if proxy:IsCompleteEvent( 760 ) == false then
		proxy:OnCharacterTotalDamage( 760, 623, 10000, 100, "OnEvent_760", once );
	end

--■761■乞食の死亡■
	if proxy:IsCompleteEvent( 761 ) == false then
		proxy:OnCharacterDead( 761 , 623 , "OnEvent_761" , once );
	end		

----- ▲乞食ショップ▲ --------------------------------------------------------
]]


----- ▼飛竜(眷属)▼ ----------------------------------------------------------	

--■830■領域監視■
	proxy:OnNetRegion(830 , 2320);	
--■831■領域監視■
	proxy:OnNetRegion(831 , 2321);	
--■832■領域監視■
	proxy:OnNetRegion(832 , 2322);	

----- ▲飛竜(眷属)▲ ----------------------------------------	

--■中ボスが死亡していたら
	--王の盾死亡再現
	if proxy:IsCompleteEvent( 4224 ) ==false then
		--王の盾の初期化		
		proxy:EnableLogic( 801 , false );		
	else
		--王の盾削除(無効化)
		InvalidBackRead( proxy , 801 );
		
		--上にいる一般兵士削除(無効化)
		local enemy_list = {120,121,122,123,124,125,126,127};
		local enemy_num  = table.getn( enemy_list );
		
		for i=1, enemy_num, 1 do
			InvalidBackRead( proxy, enemy_list[i] );
		end
	end
	
	--上にいる一般兵士をセーブロードの対象から外す
	local enemy_list = {120,121,122,123,124,125,126,127};
	local enemy_num  = table.getn( enemy_list );
	
	for i=1, enemy_num, 1 do
		proxy:AddFieldInsFilter(enemy_list[i] );
	end	
	
	
	--■中ボス死亡で扉が開く(死んでいたら、描画と当たりを消す)
	if proxy:IsCompleteEvent( 4224 ) == true then
		proxy:SetColiEnable( 1998 , false );
		proxy:SetColiEnable( 1994 , false );
	
		proxy:SetDrawEnable( 1998 , false );
		proxy:SetDrawEnable( 1994 , false );

		--SFX OFF
		proxy:InvalidSfx( 1986 , false );
		proxy:InvalidSfx( 1990 , false );
	end
	
	
	
	--■4252,4254■ソウル入手、要石でワープ■
	if proxy:IsCompleteEvent( 4224 ) ==true then--ボスが死んでいるとき
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--光らせる
		--▼(ソウル)アイテム取得用イベント監視追加▼
		if proxy:IsCompleteEvent( 4252 ) == false then
			proxy:ValidSfx( 1220 );--SFX 有効化
			proxy:ValidSfx( 1221 );--SFX 有効化
			proxy:OnDistanceActionAttribute( 4252 , 10000 , 1981 , "OnEvent_4252" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );

			--ソウル有効化
			proxy:SetDrawEnable( 1981 , true );
			proxy:SetColiEnable( 1981 , true );
			--ソウル2有効化
			proxy:SetDrawEnable( 1976 , true );
			proxy:SetColiEnable( 1976 , true );
		else
			--▼要石でワープ用の監視を追加▼
			proxy:InvalidSfx( 1220, false );--光の粒子
			SingleReset(proxy,4254);
			proxy:OnDistanceActionAttribute( 4254 , 10000 , 1981 , "OnEvent_4254" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end

	else
		--ソウル無効化
		proxy:SetDrawEnable( 1981 , false );
		proxy:SetColiEnable( 1981 , false );
		--ソウル2無効化
		proxy:SetDrawEnable( 1976 , false );
		proxy:SetColiEnable( 1976 , false );
		--SFX 無効化
		proxy:InvalidSfx( 1221 , false );
		proxy:InvalidSfx( 1220 , false );
	end
	
	--中ボス倒していて
	if proxy:IsCompleteEvent( 4224 ) == true then
		--解放ポリ劇が終わってなければ
		if proxy:IsCompleteEvent( 571 ) == false then
			local attr = ATTR_NOSESSION + ATTR_LIVE + ATTR_GREY;
			proxy:NotNetMessage_begin();
			--proxy:OnDistanceActionAttribute( 570 , 10000 , 1270 , "OnEvent_570" , DoorDist_A,HELPID_OPEN,180,DoorAngle_A,attr,everytime);
			
			proxy:OnRegionJustIn( 570 , 10000 , 2250 , "OnEvent_570" , everytime );
			
			proxy:LuaCall( 571 , REMO_START ,"OnEvent_571_RemoStart",once);
			proxy:LuaCall( 571 , REMO_FINISH,"OnEvent_571_RemoFinish",once);
			proxy:NotNetMessage_end();
		else
			--扉を開けておく
			proxy:EndAnimation( 1270 , 2);
			proxy:InvalidSfx( 2210 , false);
		end
	end
	
	--[[
	--■652■レンドル追っかけ兵士Aの死亡■
	if proxy:IsCompleteEvent( 652 ) == true then		
		InvalidCharactor( proxy,102);
	end
		
	--■654■レンドル追っかけ兵士Bの死亡■
	if proxy:IsCompleteEvent( 654 ) == true then
		InvalidCharactor( proxy,103);
	end
	
	--■655■レンドル追っかけ兵士Cの死亡■
	if proxy:IsCompleteEvent( 655 ) == true then
		InvalidCharactor( proxy,104);
	end

	--■656■レンドル追っかけ兵士Dの死亡■
	if proxy:IsCompleteEvent( 656 ) == true then		
		InvalidCharactor( proxy,105);		
	end
	
	--■657■レンドル追っかけ兵士Eの死亡■
	if proxy:IsCompleteEvent( 657 ) == true then
		InvalidCharactor( proxy,106);
	end
	
	--■658■レンドル追っかけ兵士Fの死亡■
	if proxy:IsCompleteEvent( 658 ) == true then
		InvalidCharactor( proxy,107);
	end
	]]
	--■■レンドル追っかけ兵士Aの無効化■
	InvalidCharactor( proxy,102);		
	--■■レンドル追っかけ兵士Bの無効化■
	InvalidCharactor( proxy,103);
	--■■レンドル追っかけ兵士Cの無効化■
	InvalidCharactor( proxy,104);
	--■■レンドル追っかけ兵士Dの無効化■
	InvalidCharactor( proxy,105);		
	--■■レンドル追っかけ兵士Eの無効化■	
	InvalidCharactor( proxy,106);	
	--■■レンドル追っかけ兵士Fの無効化■	
	InvalidCharactor( proxy,107);
	
	if	proxy:IsCompleteEvent(RENDOL_STATE_HELP_HIDING_ME) == true then
		--■652■レンドル追っかけ兵士Aの有効化■
		if proxy:IsCompleteEvent( 652 ) == false then		
			ValidCharactor( proxy,102);
		end
		
		--■654■レンドル追っかけ兵士Bの有効化■
		if proxy:IsCompleteEvent( 654 ) == false then
			ValidCharactor( proxy,103);
		end
	
		--■655■レンドル追っかけ兵士Cの有効化■
		if proxy:IsCompleteEvent( 655 ) == false then
			ValidCharactor( proxy,104);
		end

		--■656■レンドル追っかけ兵士Dの有効化■
		if proxy:IsCompleteEvent( 656 ) == false then		
			ValidCharactor( proxy,105);		
		end
	
		--■657■レンドル追っかけ兵士Eの有効化■
		if proxy:IsCompleteEvent( 657 ) == false then
			ValidCharactor( proxy,106);
		end
	
		--■658■レンドル追っかけ兵士Fの有効化■
		if proxy:IsCompleteEvent( 658 ) == false then
			ValidCharactor( proxy,107);
		end
	end
	
	--■560■獄吏の死亡■
	if proxy:IsCompleteEvent( 560 ) == true then
		if proxy:IsCompleteEvent( 15622 ) == false then
			--宝になれる死体再現
			proxy:OpeningDeadPlus( 115, true ,false ,false );
		else			
			--無効化
			InvalidCharactor( proxy,115);
		end
	end
	
	
	
	--光の霧を通過できるキャラタイプ(このタイプの人だけアクションボタンが反応する)
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	
	--■670■ホストPCのみが通れる光の霧■
	if proxy:IsCompleteEvent( 670 ) == true then--ホストが通過済み
		proxy:SetDrawEnable( 1260 , false );
		proxy:SetColiEnable( 1260 , false );
		proxy:InvalidSfx( 2230 , false );
	else
		--▼670▼魔法壁削除同期用▼
		proxy:LuaCall( 670 , 1 , "OnEvent_670_delete_wall" , once );
		
		--▼670▼壁の中に入るイベント発動用▼
		proxy:OnDistanceActionAttribute( 670 , 10000 , 1260 , "OnEvent_670" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end	

	
	
--■飛竜イベント関連初期化

	--初期化
	proxy:SetDisableGravity( 110 , true );--重力OFF
	proxy:EnableLogic( 110 , false );--思考OFF
	proxy:SetSuperArmor( 110 , true );--ダメージモーションさせない
	proxy:SetDeadMode(110, true);--飛竜は死なない設定(死にそうになったら撤退する)
	
	--初期位置にワープ
	proxy:Warp( 110 , 2330 );

	--初期状態をセット
	SetFirstNpcStateFlag( proxy , param , kenzoku_2_flag_list , KENZOKU_2_STATE_WARNING );
	
	--現在の状態取得
	local now_state = GetNpcStateFlag(proxy, param, kenzoku_2_flag_list);
	
	--警戒
	if now_state == KENZOKU_2_STATE_WARNING then
	
	--ヘロヘロ
	elseif now_state == KENZOKU_2_STATE_HEROHERO then
	
	--死亡(王城1or王城2)
	elseif now_state == KENZOKU_2_STATE_DEAD or
	       now_state == KENZOKU_STATE_DEAD   then
		proxy:OpeningDead( 110, false );
		InvalidCharactor( proxy , 110 );--飛竜(眷属)無効化
		
	--その他
	else
		InvalidCharactor( proxy , 110 );--飛竜(眷属)無効化
	end
	
	
	
--■ビヨルングルムイベント関連初期化	
	
	--初期状態を設定
	SetFirstNpcStateFlag(proxy, param, biyo_flag_list, BIYO_STATE_CAPTIVE);
 
	--現在の状態を取得
	local now_state = GetNpcStateFlag( proxy, param, biyo_flag_list );
	
	--牢屋に囚われ
	if now_state == BIYO_STATE_CAPTIVE then
	
		proxy:EnableLogic( 622 , false );--ロジックOFF
		proxy:SetEventCommand( 622 , 50 );--EzStateに制御番号(座らせる)を渡す
	
	--解放してくれて感謝
	elseif now_state == BIYO_STATE_THANKS then
	
		proxy:EnableLogic( 622 , false );
		proxy:SetEventCommand( 622 , 50 );--EzStateに制御番号(座らせる)を渡す
	
	--牢屋で寝ている
	elseif now_state == BIYO_STATE_SLEEPING_IN_PRISON then
	
		proxy:EnableLogic( 622 , false );
		proxy:SetEventCommand( 622 , 60 );--EzStateに制御番号(寝る)を渡す
		
	--敵対(牢内)
	elseif now_state == BIYO_STATE_HOSTILE_IN_PRISON then
	
		--(予約)
		--ロジック切り替えるなど･･･?

	--獄吏を倒したい
	elseif now_state == BIYO_STATE_TARGET_ENEMY then
	
		proxy:Warp( 622 , 2240 );--指定ポイントにワープ
	
	--逆襲に満足して寝る
	elseif now_state == BIYO_STATE_END_OF_STRIKES_BACK then
	
		proxy:Warp( 622 , 2240 );
		proxy:EnableLogic( 622 , false );
		proxy:SetEventCommand( 622 , 60 );--EzStateに制御番号(寝る)を渡す
	
	--敵対(城壁)
	elseif BIYO_STATE_HOSTILE_IN_RAMPART then
	
		proxy:Warp( 622 , 2240 );
		--ロジック切り替えるなど･･･?
	
	--死亡
	elseif BIYO_STATE_DEAD then
		InvalidCharactor( proxy , 622 );--無効化
	
	--それ以外
	else
		InvalidCharactor( proxy , 622 );--無効化
	end	
	
	
	
--[[■乞食イベント関連初期化

	--初期状態を設定
	SetFirstNpcStateFlag(proxy, param, kojiki_flag_list, KOJIKI_STATE_SEELING);
 
	--現在の状態を取得
	local now_state = GetNpcStateFlag( proxy, param, kojiki_flag_list );
	
	--販売中
	if now_state == KOJIKI_STATE_SEELING then
	
		proxy:EnableLogic( 623 , false );--ロジックOFF
	
	--敵対(王城2)
	elseif now_state == KOJIKI_STATE_HOSTILE_2 then
	
		--(予約)
	
	--死亡
	elseif now_state == KOJIKI_STATE_DEAD then
	
		InvalidCharactor( proxy , 623 );--乞食ショップ無効化

	else
		--(恐らく他のマップにはいない)
	end
]]
	
--■8084■王城に来たフラグを立てる■
	proxy:SetEventFlag(8084, true);


--■550■ボス戦カメラ対応■
	--ボスが生きているなら登録
	if proxy:IsCompleteEvent(4224) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 550 , 10000 , 2886 ,"OnEvent_550" , everytime );
		proxy:NotNetMessage_end();
	end
	
------------------▽▽▽QWC関連▽▽▽-------------------
--■610■QWC:ソウルモンスター出現１■
	--ホストのみは、必ずフラグを0にして、敵を一旦無効化する
	if	proxy:IsClient() == false then
		SingleReset(proxy, 610);
	end
	--後から入ってくる人が既に表示がOnになっているかチェックする
	if	proxy:IsCompleteEvent(610) == false then
		InvalidCharactor( proxy, 150 );
		InvalidCharactor( proxy, 151 );
	end
	if	proxy:IsSuccessQWC(20100) == true then
		print("m02_01 QWCソウルモンスター出現　成立");
		proxy:OnRegionJustIn( 610, LOCAL_PLAYER, 2200, "OnEvent_610", once );
	else
		print("m02_01 QWCソウルモンスター出現　未成立");
	end
------------------△△△QWC関連△△△-------------------

--■カラスイベントをSingleReset()する■
	for IndexID = 850, 870, 1 do
		SingleReset(proxy, IndexID);
	end
	
--■カラス監視追加初期化■
	--カラスがＰＣが近づくと飛び立つ
	for KarasuID = 850, 870, 1 do
		if proxy:IsCompleteEvent( KarasuID ) == false then
			proxy:OnPlayerDistanceInTarget( KarasuID, 10000, 380 + KarasuID, "OnEvent_"..KarasuID, 5, once );
		else
			proxy:SetDrawEnable(380 + KarasuID, false);
			proxy:SetColiEnable(380 + KarasuID, false);
		end
	end
	
	--結晶トカゲイベント
	RegistTokage(proxy,590,252,1);
	RegistTokage(proxy,592,253,2);
	
	--■999999■フレーム遅れの初期化処理イベントを発行■
	proxy:NotNetMessage_begin();
		--▼0秒後▼--
		proxy:OnKeyTime2( 999991, "Second_Initialize_m02_01_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m02_01_00_00 end");
end


--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく
function Second_Initialize_m02_01_00_00(proxy, param)
	print("Second_Initialize_m02_01_00_00 begin");

------------------▽▽▽QWC関連▽▽▽-------------------
------------------△△△QWC関連△△△-------------------
		
	print("Second_Initialize_m02_01_00_00 end");
end

--------------------------------------------------------------------------------------
--4224■中ボス死亡で何かが起こる
--------------------------------------------------------------------------------------
--■4224■中ボス死亡で何かが起こる■
function OnEvent_4224(proxy,param)
	print("OnEvent_4224 begin");

	proxy:NotNetMessage_begin();
		--▼4250▼クライアントPCワープ演出▼
		proxy:OnKeyTime2( 4250, "OnEvent_4250", 0, 0, 0, once);
		--▼4224_1▼1秒後▼
		proxy:OnKeyTime2( 4224, "OnEvent_4224_1", 1.0, 0, 1, once );
		--▼4251▼2秒経過▼
		proxy:OnKeyTime2( 4251, "OnEvent_4251", 2, 0, 2, once);
		
		--マルチ解散監視用
		proxy:OnRegistFunc( 4224 , "Check_4224_PT","OnEvent_4224_PT",0,once);
	proxy:NotNetMessage_end();

	--レンドル王子が探索中なら、次のマップの状態に移行
	if	proxy:IsCompleteEvent(RENDOL_STATE_SEARCH_2) == true then
		InvalidCharactor( proxy, 620 );
		RendolCheck(proxy,param);--関数の中で、王城３か王城４か、どちらに出現するか判定
		--SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_LOCATION_INVISIBLE );
	end

	--ボス死亡フラグセット
	proxy:SetEventFlag( 4224 , 1 );	
	
	proxy:SetColiEnableArray(3003,true);--通常有効
	proxy:SetColiEnableArray(3004,true);--通常有効
	proxy:SetColiEnableArray(3005,false);--ボス用無効
	proxy:SetColiEnableArray(3006,false);--ボス用無効
		
	--新ブロッククリア処理へ
	proxy:CustomLuaCallStart( 4050, 801 );
	--結晶トカゲリセット
	ResetTokage(proxy);
	
	--エリア開放インフォメーション
	--[[
	if proxy:IsClient() == false then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4224 , "OnEvent_4224_2",5.0,0,0,once);
		proxy:NotNetMessage_end();
	end
	]]
	print("OnEvent_4224 end");
end

--▲4224_1▲1秒後▲
function OnEvent_4224_1(proxy,param)
	print("OnEvent_4224_1 begin");
	
	--ボスを倒した数を更新(数によってフラグを立てる)
	GetBossFlagCount( proxy, param );
	
	--▼トロフィー取得判定▼
	Lua_RequestUnlockTrophy(proxy, 28);
	
	--▼(ソウル)アイテム取得用イベント監視追加▼
	if proxy:IsCompleteEvent( 4252 ) == false then
	
		--ソウル有効化
		proxy:SetDrawEnable( 1981 , true );
		proxy:SetColiEnable( 1981 , true );
		--ソウル2有効化
		proxy:SetDrawEnable( 1976 , true );
		proxy:SetColiEnable( 1976 , true );
		
		proxy:ValidSfx( 1220 );--SFX 有効化
		proxy:ValidSfx( 1221 );--SFX 有効化
		
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--光らせる
		proxy:OnDistanceActionAttribute( 4252 , 10000 , 1981 , "OnEvent_4252" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );
	else
		--ソウル無効化(取ったら消えるので･･･)
		proxy:SetDrawEnable( 1981 , false );
		proxy:SetColiEnable( 1981 , false );
	end	

	print("OnEvent_4224_1 end");
end

--[[
--エリア解放の表示
function OnEvent_4224_2(proxy,param)
	print("OnEvent_4224_2 begin");
	--インフォ表示
	--システムメッセージ
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationBuffer( 10010740 );
	proxy:PlayTypeSE( 10000 ,SOUND_TYPE_M ,777777777 );
	print("OnEvent_4224_2 end");
end
]]

--------------------------------------------------------------------------------------
--■4250■クライアントPCワープ演出■
--------------------------------------------------------------------------------------

--■4250■クライアントPCワープ演出■
function OnEvent_4250(proxy, param)
	print("OnEvent_4250 begin");

	if proxy:IsClient() == true then
		proxy:PlayAnimation( 10000 , 8284 );--ワープアニメを再生
	end

	proxy:SetEventFlag( 4250 , 1 );
	
	print("OnEvent_4250 end");
end


--------------------------------------------------------------------------------------
--■4251■シングル：光の壁、BGM消去■
--------------------------------------------------------------------------------------

--■4251■シングル：光の壁、BGM消去■
function OnEvent_4251(proxy, param)
	print("OnEvent_4251 begin");
		
	--ボス戦用のBGM停止
	proxy:StopPointSE( 1 );	
	
--[[	
	--▼レンドル王子が次のブロックに移動するイベントの監視追加▼
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:NotNetMessage_begin();
			proxy:OnRegistFunc( 722 , "Check_OnEvent_722" , "OnEvent_722" , 1 , once );
		proxy:NotNetMessage_end();
	end
]]	
	--上にいる一般兵士削除(強制死亡)
	local enemy_list = {120,121,122,123,124,125,126,127};
	local enemy_num  = table.getn( enemy_list );
	
	for i=1, enemy_num, 1 do
		proxy:ForceDead( enemy_list[i] );
	end
	
	proxy:SetEventFlag( 4251 , 1 );
	
	print("OnEvent_4251 end");
end

--マルチ解散監視
function Check_4224_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--マルチじゃなくない
function OnEvent_4224_PT(proxy,param)
	print("OnEvent_4224_PT begin");
	--中ボス部屋の前後の魔法壁が消える(全プレイヤー)
	proxy:SetColiEnable( 1998 , false );
	proxy:SetColiEnable( 1994 , false );
	--proxy:SetObjDeactivate( 1998 , true );--デアクティブ
	--proxy:SetObjDeactivate( 1994 , true );--デアクティブ
	
	proxy:SetDrawEnable( 1998 , false );
	proxy:SetDrawEnable( 1994 , false );
	
	--中ボス部屋魔法壁のSFX削除
	proxy:InvalidSfx( 1986 , true );
	proxy:InvalidSfx( 1990 , true );
	
	--中ボス部屋前の移動処理イベントを削除
	proxy:DeleteEvent( 582 );--一人目が入るとき用
	proxy:DeleteEvent( 583 );--二人目以降が入るとき用
	proxy:DeleteEvent( 584 );--ポリ劇再生用
	proxy:DeleteEvent( 585 );--ボス戦闘開始用
	print("OnEvent_4224_PT end");
end

--------------------------------------------------------------------------------------
--石柱にワープ(ボス倒した後用)■4254
--------------------------------------------------------------------------------------
--■4254■石柱にワープ■
function OnEvent_4254(proxy,param)	
	
	if proxy:IsCompleteEvent( 4254 ) == true then
		return;
	end

	print("OnEvent_4254 begin");	
	
	proxy:RepeatMessage_begin();
		--▼4254_1▼選択メニューの監視▼
		proxy:OnSelectMenu(4254, "OnEvent_4254_0", 10010710, 0, 2, 1981, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_4254 end");
end

--▲4254_0▲選択メニューの監視▲
function OnEvent_4254_0(proxy, param)
	print("OnEvent_4254_0 begin");	
	
	if proxy:IsSession() == false then		
		proxy:PlayAnimation( 10000 , 8283 );--要石に触れるアニメを再生
		proxy:NoAnimeTurnCharactor( 10000 , 1981 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--▼要石に触れるアニメ再生終了▼
			proxy:OnChrAnimEnd( 4254 , 10000 , 8283 , "OnEvent_4254_1" , once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 4254 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_4254_0 end");
end

--▲4254_1▲自世界に帰るアニメ再生終了▲
function OnEvent_4254_1(proxy,param)	
	print("OnEvent_4254_1 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生
	
	--石柱へ戻ってきた判定のフラグを立てる
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag( 4254 , 0 );
	--完全回復要求
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1006 );
	
	print("OnEvent_4254_1 end");
end


--------------------------------------------------------------------------------------
--■4252■ソウル入手■
--------------------------------------------------------------------------------------

function OnEvent_4252(proxy, param)
	print("OnEvent_4252 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ 
		print("OnEvent_4252 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行
		proxy:OnKeyTime2( 4252, "OnEvent_4252_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4252 end");
end


--■4252_1■アイテム取得■
function OnEvent_4252_1(proxy, param)
	print("OnEvent_4252_1 begin");

	--アイテム取得関数--パラメータ10101参照
	proxy:GetRateItem(10111);
	proxy:GetRateItem(10174);	
	proxy:GetRateItem(10175);
	proxy:GetRateItem(10176);
	proxy:GetRateItem(10177);
	
	--アイテムを取得済み
	proxy:SetEventFlag( 4252, 1 );
	
	--宝箱シェーダーは消えません
	--proxy:TreasureDispModeChange( 1981 , false );

	--SFXが消える
	--proxy:InvalidSfx( 1221 , true );--要石のオーラ
	proxy:InvalidSfx( 1220 , true );--光の粒子
		
	--▼要石でワープ用の監視を追加▼
	proxy:OnDistanceActionAttribute( 4254 , 10000 , 1981 , "OnEvent_4254" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

		if proxy:IsClient() == false then
		local attr = ATTR_NOSESSION + ATTR_LIVE + ATTR_GREY;
		proxy:NotNetMessage_begin();
		--proxy:OnDistanceActionAttribute( 570 , 10000 , 1270 , "OnEvent_570" , DoorDist_A,HELPID_OPEN,180,DoorAngle_A,attr,everytime);
		proxy:OnRegionJustIn( 570 , 10000 , 2250 , "OnEvent_570" , everytime );
			
		proxy:LuaCall( 571 , REMO_START ,"OnEvent_571_RemoStart",once);
		proxy:LuaCall( 571 , REMO_FINISH,"OnEvent_571_RemoFinish",once);
		proxy:NotNetMessage_end();
	end
	
	print("OnEvent_4252_1 end");
end

--------------------------------------------------------------------------------------
--徘徊デーモンの登場■??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ)
function PlayerDeath_m02_01_00_00(proxy, param)
	print("PlayerDeath_m02_01_00_00");	
	print("PlayerDeath_m02_01_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ)
function PlayerRevive_m02_01_00_00(proxy,param)
	print("PlayerRevive_m02_01_00_00");
	print("PlayerRevive_m02_01_00_00");
end



--------------------------------------------------------------------------------------
--ボス部屋の中に入る■582
--------------------------------------------------------------------------------------

--■イベントがループなので、全部リピートにする↓

--■582■中ボス部屋への扉が開く■
function OnEvent_582(proxy,param)
	print("OnEvent_582 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_582 end");
		return;
	end
	
	--クライアントへ、ボス部屋阻止失敗を通知
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 583 , 1 );--旋回アニメの同期再生
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--多重起動システムIDをタイムアウトを設定してONにする
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_582 end");
end


--旋回アニメの同期再生(IDが別)
function OnEvent_583_1(proxy,param)
	print("OnEvent_583_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を行い、その終了時にOnEvent_583_2を発行する
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2890 );
		else
			proxy:LockSession();--ルームをロックします！
			--旋回アニメ再生を行い、その終了時にOnEvent_583_2を発行する
			proxy:OnTurnCharactorEnd( 583, 10000, 2890, "OnEvent_583_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_583_1 end");
end

--旋回アニメの同期再生終了後
function OnEvent_583_2(proxy,param)
	print("OnEvent_583_2 begin");
	
	--同期用歩きアニメ再生
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 583, 10000, ANIMEID_WALK, "OnEvent_583_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_583_2 end");
end

--歩きアニメの同期再生終了後
function OnEvent_583_3(proxy,param)
	print("OnEvent_583_3 begin");
	
	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ
	if proxy:IsCompleteEvent( 582 ) == false then		
		Lua_MultiDoping(proxy,801);--マルチプレイドーピング		
		Lua_MultiDoping(proxy,120);--マルチプレイドーピング
		Lua_MultiDoping(proxy,121);--マルチプレイドーピング
		Lua_MultiDoping(proxy,122);--マルチプレイドーピング
		Lua_MultiDoping(proxy,123);--マルチプレイドーピング
		Lua_MultiDoping(proxy,124);--マルチプレイドーピング
		Lua_MultiDoping(proxy,125);--マルチプレイドーピング
		Lua_MultiDoping(proxy,126);--マルチプレイドーピング
		Lua_MultiDoping(proxy,127);--マルチプレイドーピング
		proxy:LuaCallStart( 583 , 5 );--2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知
		proxy:LuaCallStart( 583 , 6 );--フラグセット(同期用)

	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない)
	if proxy:IsClient() == false then
		proxy:ResetThink( 801 );
	end
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );

	print("OnEvent_583_3 end");
end


--■582 2回目以降にボス部屋に入るためのイベント配信用
function OnEvent_582_GO_TO_IN(proxy, param)
	print("OnEvent_582_GO_TO_IN begin");	
		
	proxy:NotNetMessage_begin();
		--▼583▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_582
		proxy:OnPlayerActionInRegion( 583, 2894, "OnEvent_582", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();
	--王の盾戦闘準備	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 583 , "StandBy_KingOfShield",0.5,0,0,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_582_GO_TO_IN end");
end


--■582 フラグセット(同期用)
function OnEvent_582_flag_set(proxy, param)
	print("OnEvent_582_flag_set begin");

	proxy:SetEventFlag( 582 , 1 );
	proxy:DeleteEvent( 582 );

	print("OnEvent_582_flag_set end");
end



--------------------------------------------------------------------------------------
--中ボスポリ劇再生■584
--------------------------------------------------------------------------------------

function OnEvent_584(proxy, param)
	print("OnEvent_584 begin");

	--ポリ劇再生開始
	proxy:RequestRemo(20100,REMO_FLAG,584,1);
	proxy:SetEventFlag( 584 , 1 );--ポリ劇再生終了
	
	print("OnEvent_584 end");
end


--■584_RemoStart■ポリ劇開始 フェードアウト完了■
function OnEvent_584_RemoStart(proxy,param)
	print( "OnEvent_584_RemoStart begin" );
	
	print("ポリ劇再生開始");
	proxy:SetDrawEnable( 801 , false );--王の盾 表示OFF
	
	print( "OnEvent_584_RemoStart end" );
end


--■584_RemoFinish■ポリ劇再生終了後■
function OnEvent_584_RemoFinish(proxy , param)
	print( "OnEvent_584_RemoFinish begin" );

	print("ポリ劇終了");
	proxy:SetDrawEnable( 801 , true );--王の盾 表示ON	

	print( "OnEvent_584_RemoFinish end" );
end


--------------------------------------------------------------------------------------
--ボスが動き出す(戦闘開始)■585
--------------------------------------------------------------------------------------

function OnEvent_585(proxy, param)
	print("OnEvent_585 begin");	
	
	--ボス戦用BGM再生開始
	proxy:PlayPointSE( 2310, SOUND_TYPE_M, 20100000, 1 );
	
	--ボスロジックON
	proxy:EnableLogic( 801 , true );

	--フラグON
	proxy:SetEventFlag( 585 ,true );
	
	--ボスゲージ表示
	proxy:SetBossGauge( 801 , 0 ,5010 );
	
	print("OnEvent_585 end");
end



--------------------------------------------------------------------------------------
--■680■サブイベント扉■
--------------------------------------------------------------------------------------

--■680_1■サブイベント扉■LuaCall定義
function OnEvent_680_1(proxy, param)
	print("OnEvent_680_1 begin");

	proxy:PlayAnimation( 1202, 1 );--扉が開くアニメーション
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 680, 1 );
		proxy:DeleteEvent( 680 );
		print("OnEvent_680_1 end");
		return;
	end

	proxy:WarpDmy( 10000 , 1202 , 191 );
	proxy:SetEventFlag( 680, 1 );

	print("OnEvent_680_1 end");
end


--■680■サブイベント扉■
function OnEvent_680(proxy, param)

	--多重発動防止
	if proxy:IsCompleteEvent( 680 ) == true then
		return;
	end
	
	print("OnEvent_680 begin");
	
	--必要アイテムの指定
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 8;--牢獄の鍵
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼680_3▼選択メニューの監視▼
			--proxy:OnSelectMenu(680, "OnEvent_680_3", 10010802, 0, 2, 1202, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010802, 0, 6, 1202, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_680_3(proxy,param);

	--必要アイテムを所持していない
	else
		--扉が開かない場合のメッセージを表示
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1202, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_680 end");
end


--▲680_3▲選択メニューの監視▲(YESを選択したとき)
function OnEvent_680_3(proxy,param)
	print("OnEvent_680_3 begin");
	proxy:LuaCallStart( 680 , 1 );--アニメーションの同期再生(全体に配信)
	proxy:DeleteEvent( 680 );
	print("OnEvent_680_3 end");
end



--------------------------------------------------------------------------------------
--■682■サブイベント扉■
--------------------------------------------------------------------------------------

--■682_1■サブイベント扉■LuaCall定義
function OnEvent_682_1(proxy, param)
	print("OnEvent_682_1 begin");	
	
	proxy:PlayAnimation( 1205, 1 );--扉が開くアニメーション
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 682, 1 );
		proxy:DeleteEvent( 682 );
		print("OnEvent_682_1 end");
		return;
	end

	proxy:WarpDmy( 10000 , 1205 , 191 );
	proxy:SetEventFlag( 682, 1 );

	print("OnEvent_682_1 end");
end



--■682■サブイベント扉■
function OnEvent_682(proxy, param)
	print("OnEvent_682 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 682 ) == true then
		print("OnEvent_682 end");
		return;
	end
	
	--必要アイテムの指定
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 8;--牢獄の鍵
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼682_3▼選択メニューの監視▼
			--proxy:OnSelectMenu(682, "OnEvent_682_3", 10010802, 0, 2, 1205, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010802, 0, 6, 1205, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_682_3(proxy,param);

	--必要アイテムを所持していない
	else
		--扉が開かない場合のメッセージを表示
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1205, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_682 end");
end


--▲682_3▲選択メニューの監視▲(YESを選択したとき)
function OnEvent_682_3(proxy,param)
	print("OnEvent_682_3 begin");
	proxy:LuaCallStart( 682 , 1 );--アニメーションの同期再生(全体に配信)	
	proxy:DeleteEvent( 682 );
	
	print("OnEvent_682_3 end");
end




--------------------------------------------------------------------------------------
--■684■サブイベント扉■
--------------------------------------------------------------------------------------

--■684_1■サブイベント扉■LuaCall定義
function OnEvent_684_1(proxy, param)
	print("OnEvent_684_1 begin");
	
	--ビヨルングルムが囚われている牢屋の扉を開けたので･･･
	--ビヨの状態を「解放してくれて感謝」にする
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_THANKS );
	proxy:SetEventFlag( 520 , 1 );--アクションフラグも立てておく･･･。

	proxy:PlayAnimation( 1206, 1 );--扉が開くアニメーション
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 684, 1 );
		proxy:DeleteEvent( 684 );
		print("OnEvent_684_1 end");
		return;
	end

	proxy:WarpDmy( 10000 , 1206 , 191 );
	proxy:SetEventFlag( 684, 1 );

	print("OnEvent_684_1 end");
end



--■684■サブイベント扉■
function OnEvent_684(proxy, param)
	print("OnEvent_684 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 684 ) == true then
		print("OnEvent_684 end");
		return;
	end
	
	--必要アイテムの指定
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 8;--牢獄の鍵
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼684_3▼選択メニューの監視▼
			--proxy:OnSelectMenu(684, "OnEvent_684_3", 10010802, 0, 2, 1206, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010802, 0, 6, 1206, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_684_3(proxy,param);

	--必要アイテムを所持していない
	else
		--扉が開かない場合のメッセージを表示
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1206, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_684 end");
end


--▲684_3▲選択メニューの監視▲(YESを選択したとき)
function OnEvent_684_3(proxy,param)
	print("OnEvent_684_3 begin");
	proxy:LuaCallStart( 684 , 1 );--アニメーションの同期再生(全体に配信)	
	proxy:DeleteEvent( 684 );
	print("OnEvent_684_3 end");
end






--------------------------------------------------------------------------------------
--■686■サブイベント扉■
--------------------------------------------------------------------------------------
--■686_1■サブイベント扉■LuaCall定義
function OnEvent_686_1(proxy, param)
	print("OnEvent_686_1 begin");

	proxy:PlayAnimation( 1203, 1 );--扉が開くアニメーション
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 686, 1 );
		proxy:DeleteEvent( 686 );
		print("OnEvent_686_1 end");
		return;
	end

	proxy:WarpDmy( 10000 , 1203 , 191 );
	proxy:SetEventFlag( 686, 1 );

	print("OnEvent_686_1 end");
end

--■686■サブイベント扉■
function OnEvent_686(proxy, param)
	print("OnEvent_686 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 686 ) == true then
		print("OnEvent_686 end");
		return;
	end
	
	--必要アイテムの指定
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 8;--牢獄の鍵
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼686_3▼選択メニューの監視▼
			--proxy:OnSelectMenu(686, "OnEvent_686_3", 10010802, 0, 2, 1206, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010802, 0, 6, 1203, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_686_3(proxy,param);

	--必要アイテムを所持していない
	else
		--扉が開かない場合のメッセージを表示
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1203, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_686 end");
end


--▲686_3▲選択メニューの監視▲(YESを選択したとき)
function OnEvent_686_3(proxy,param)
	print("OnEvent_686_3 begin");
	proxy:LuaCallStart( 686 , 1 );--アニメーションの同期再生(全体に配信)	
	proxy:DeleteEvent( 686 );
	print("OnEvent_686_3 end");
end

--------------------------------------------------------------------------------------
--■688■サブイベント扉■
--------------------------------------------------------------------------------------
--■688_1■サブイベント扉■LuaCall定義
function OnEvent_688_1(proxy, param)
	print("OnEvent_688_1 begin");

	proxy:PlayAnimation( 1204, 1 );--扉が開くアニメーション
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 688, 1 );
		proxy:DeleteEvent( 688 );
		print("OnEvent_688_1 end");
		return;
	end

	proxy:WarpDmy( 10000 , 1204 , 191 );
	proxy:SetEventFlag( 688, 1 );

	print("OnEvent_688_1 end");
end

--■688■サブイベント扉■
function OnEvent_688(proxy, param)
	print("OnEvent_688 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 688 ) == true then
		print("OnEvent_688 end");
		return;
	end
	
	--必要アイテムの指定
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 8;--牢獄の鍵
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼688_3▼選択メニューの監視▼
			--proxy:OnSelectMenu(688, "OnEvent_688_3", 10010802, 0, 2, 1206, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010802, 0, 6, 1204, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_688_3(proxy,param);

	--必要アイテムを所持していない
	else
		--扉が開かない場合のメッセージを表示
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1204, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_688 end");
end


--▲688_3▲選択メニューの監視▲(YESを選択したとき)
function OnEvent_688_3(proxy,param)
	print("OnEvent_688_3 begin");
	proxy:LuaCallStart( 688 , 1 );--アニメーションの同期再生(全体に配信)	
	proxy:DeleteEvent( 688 );
	print("OnEvent_688_3 end");
end



--------------------------------------------------------------------------------------
--■560■獄吏の死亡監視■
--------------------------------------------------------------------------------------
function OnEvent_560(proxy,param)
	print("OnEvent_560 beign");
	
	proxy:SetEventFlag(560,true);--獄吏死亡フラグON(イベント)
	
	--ビヨルンイベントの判定をここに･･･。
	
	--現在の状態を取得
	local now_state = GetNpcStateFlag( proxy, param, biyo_flag_list );
		--ビヨの状態を「逆襲に満足して寝る」にする
	if	proxy:IsCompleteEvent(BIYO_STATE_TARGET_ENEMY) == true then
	
		--proxy:SetEventCommand( 622 , 60 );--EzStateに制御番号(寝る)を渡す
		
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_END_OF_STRIKES_BACK );
		
		--アクションフラグも立てておく･･･
		proxy:SetEventFlag( 523 , 1 );
	end
	
	
	print("OnEvent_560 end");
end


--------------------------------------------------------------------------------------
--■560■獄吏の死体を調べた■
--------------------------------------------------------------------------------------
function OnEvent_15622(proxy,param)
	print("OnEvent_15622 begin");
	proxy:SetEventFlag( 15622 , true );
	print("OnEvent_15622 end");
end

--------------------------------------------------------------------------------------
--■527■ビヨルングルムの死亡監視■
--------------------------------------------------------------------------------------
function OnEvent_527(proxy,param)
	print("OnEvent_527 beign");
	
	proxy:SetEventFlag(527,true);
		
	--ビヨの状態を「死亡」にする
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_DEAD );

	print("OnEvent_527 end");
end


--------------------------------------------------------------------------------------
--■643■レンドル王子呼びかけ範囲取得■
--------------------------------------------------------------------------------------
function OnEvent_643(proxy,param)
	print("OnEvent_643 beign");
	
	proxy:SetEventFlag( 643 , true );--フラグ立てるのみ(会話側で使う?)

	print("OnEvent_643 end");
end

--呼びかけ範囲から出た
function OnEvent_643_out(proxy,param)
	print("OnEvent_643_out begin");
	proxy:SetEventFlag( 643 , false );
	print("OnEvent_643_out end");
end
--[[
--------------------------------------------------------------------------------------
--■652■レンドル追っかけ兵士Aの死亡監視■
--------------------------------------------------------------------------------------
function OnEvent_652(proxy,param)
	print("OnEvent_652 beign");
	proxy:SetEventFlag(652,true);
	print("OnEvent_652 end");
end


--------------------------------------------------------------------------------------
--■654■レンドル追っかけ兵士Bの死亡監視■
--------------------------------------------------------------------------------------
function OnEvent_654(proxy,param)
	print("OnEvent_654 beign");
	proxy:SetEventFlag(654,true);
	print("OnEvent_654 end");
end

]]


--[[------------------------------------------------------------------------------------
--■660■乞食ショップNPCの死亡監視■
--------------------------------------------------------------------------------------
function OnEvent_660(proxy,param)
	print("OnEvent_660 beign");
	proxy:SetEventFlag(660,true);
	print("OnEvent_660 end");
end
]]


--------------------------------------------------------------------------------------
--■670■ホストPCのみが通れる光の霧■
--------------------------------------------------------------------------------------

--■670_delete_wall■魔法壁削除同期用■
function OnEvent_670_delete_wall(proxy , param)
	print("OnEvent_670_delete_wall begin");
	
	proxy:SetDrawEnable( 1260 , false );--描画OFF
	proxy:SetColiEnable( 1260 , false );--当たりOFF
	proxy:SetObjDeactivate( 1260 , true );--デアクティブ
	proxy:DeleteEvent( 670 );
	proxy:InvalidSfx( 2230 , true );
	
	print("OnEvent_670_delete_wall end");
end


--■670■イベント発動用■
function OnEvent_670(proxy , param)
	print("OnEvent_670 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 670 ) == true then
		print("OnEvent_670 end");
		return;
	end
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 670 , 1 );
		print("OnEvent_670 end");
		return;
	end
	
	--ダミポリへワープ
	proxy:WarpDmy( 10000 , 1260 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼670_1▼歩きアニメ終了▼
		--proxy:OnChrAnimEnd( 670 , 10000 , ANIMEID_WALK , "OnEvent_670_1" , once );
		proxy:LuaCallStart( 670 , 1 );--光の霧削除同期
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 670 , 1 );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_670 end");
end


--▲670_1▲歩きアニメ終了▲
function OnEvent_670_1(proxy , param)
	print("OnEvent_670_1 begin");
	
	proxy:LuaCallStart( 670 , 1 );--光の霧削除同期
	
	print("OnEvent_670_1 end");
end

--[[
--------------------------------------------------------------------------------------
--512■バリスタ開始イベント
--------------------------------------------------------------------------------------
--バリスタイベント開始
function OnEvent_512(proxy,param)

	if proxy:IsCompleteEvent(512) == true then
		return;
	end	
	if Luafunc_PlaySynchroAnimation(proxy,param,ANIMEID_BARISTA_GRASP) == true then
		proxy:SetEventFlag(512,true);
		return;
	end
	
	print("OnEvent_512 begin");		
	proxy:EnableLogic(10000,false);
	--プレイヤーをOBJ(1200)のダミポリ(191)位置へワープ
	proxy:WarpDmy( 10000, 1200, 191 );--バリスタ操作オブジェ
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd(512,10000,ANIMEID_BARISTA_GRASP,"OnEvent_512_1",once);
	proxy:NotNetMessage_end();
	proxy:SetEventFlag(512,true);	
	print("OnEvent_512 end");
end

--プレイヤーアニメ終了後
function OnEvent_512_1(proxy,param)
	print("OnEvent_512_1 begin");
	proxy:LuaCallStart(512,2);
	print("OnEvent_512_1 end");
end

--ループアニメ開始
function OnEvent_512_2(proxy,param)
	print("OnEvent_512_2 begin");
	--パーティーのプレイヤーがアニメーション
	if param:IsNetMessage() == true then 
		--バリスタにオーナー登録
		proxy:SetBallista(1207,param:GetPlayID()+10001);
		proxy:PlayLoopAnimation( param:GetPlayID()+10001 , ANIMEID_BARISTA_GRASP_KEEP );
		print("OnEvent_512_2 end");
		return;
	end
	--バリスタにオーナー登録
	proxy:SetBallista(1207,10000);
	--自分がアニメーション
	proxy:PlayLoopAnimation( 10000 ,  ANIMEID_BARISTA_GRASP_KEEP );
	proxy:OnBallista(513,1207,HELPID_REMOVE,-20,20,-200,30,3, 1.0, 1.0);--バリスタ本体オブジェ
--	proxy:OnBallista(513,1207,HELPID_REMOVE,-20,20,-200,30,3);--バリスタ本体オブジェ
	print("OnEvent_512_2 end");
end

--------------------------------------------------------------------------------------
--513■バリスタ同期■
--------------------------------------------------------------------------------------
--0	…SEアニメ同期
function OnEvent_513_0(proxy,param)	
	--発射アニメ中じゃなければ
	if proxy:IsEventAnim(1207,1) == false then 
		proxy:PlayAnimation(1207,2);		
	end
	if param:IsNetMessage() == true then
		if proxy:IsEventAnim(10000,1) == false then 
			proxy:PlayLoopAnimation( param:GetPlayID()+10001 , ANIMEID_BARISTA_GRASP_KEEP );		
			return;
		end
	end
end

--1	…角度同期
function OnEvent_513_1(proxy,param)
	--発動者はじぶんで回転させてるので、受信者のみ同期
	if param:IsNetMessage() == true then
		proxy:ObjRot(1207,param:GetPlayID()+10001,param:GetParam3());
	end
end

--2	…バリスタ発射同期
function OnEvent_513_2(proxy,param)
	print("OnEvent_513_2 begin");
	print("バリスタ発射アニメ再生");
	--強制アニメ
	proxy:ForcePlayAnimation(1207,1);
	print("OnEvent_513_2 end");
end

--3	…バリスタ終了同期
function OnEvent_513_3(proxy,param)
	print("OnEvent_513_3 begin");
	print("バリスタ終了");	
	if param:IsNetMessage() == true then
		proxy:StopLoopAnimation(param:GetPlayID()+10001);
		proxy:PlayAnimation( param:GetPlayID()+10001 , ANIMEID_BARISTA_AWAY );
		print("OnEvent_513_3 end");		
		return;		
	end
	--プレイヤー離脱アニメ？
	proxy:StopLoopAnimation(10000);
	proxy:PlayAnimation(10000,ANIMEID_BARISTA_AWAY);
	proxy:EnableLogic(10000,true);
	
	proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd(513,10000,ANIMEID_BARISTA_AWAY,"OnEvent_513_3_1",once);
		proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_513_3 end");
end

--アニメ終了後のイベント
function OnEvent_513_3_1(proxy,param)
	print("OnEvent_513_3_1 begin");
	print("発動者のみのイベント");
	--フラグ同期用のイベントを発行
	proxy:LuaCallStart(513,5);	
	print("OnEvent_513_3_1 end");	
end

--4	…バリスタダメージ終了同期
function OnEvent_513_4(proxy,param)
	print("OnEvent_513_4 begin");
	print("バリスタ終了");	
	if param:IsNetMessage() == true then
		proxy:StopLoopAnimation(param:GetPlayID()+10001);		
		print("OnEvent_513_4 end");		
		return;		
	end
	proxy:StopLoopAnimation(10000);	
	proxy:EnableLogic(10000,true);
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(513,"OnEvent_513_4_1",2,0,0,once);
	proxy:NotNetMessage_end();
	print("OnEvent_513_4 end");
end

--時間待ちのイベント
function OnEvent_513_4_1(proxy,param)
	print("OnEvent_513_4_1 begin");
	print("発動者のみのイベント");
	--フラグ同期用のイベントを発行
	proxy:LuaCallStart(513,5);
	print("OnEvent_513_4_1 end");
end

--5	…バリスタフラグ同期用
function OnEvent_513_5(proxy,param)
	print("OnEvent_513_5 begin");
	--バリスタオーナー解除
	proxy:SetBallista(1207,-1);
	proxy:SetEventFlag(512,false);
	print("OnEvent_513_5 end");	
end


]]



--------------------------------------------------------------------------------------
--■800■飛竜の眷属２が元気に飛び回る■
--------------------------------------------------------------------------------------

--飛竜(眷属2)が再生するアニメID
kenzoku_2_play_anime_id = 7006;--デフォルトでは、待機1

--■800■飛竜の眷属２が元気に飛び回る■
function OnEvent_800(proxy, param)
	print("OnEvent_800 begin");

	--[[飛竜のHP監視に引っかかっていたら、死亡させる]]
	if proxy:IsCompleteEvent( 806 ) == true then
		if	kenzoku_2_play_anime_id ~= 7030 then
			--▼806▼飛竜(眷属2)が死ぬ▼		
			kenzoku_2_play_anime_id = 7030;
			--→OnEvent_806_syncro_anime
			proxy:LuaCallStart( 806 , 1 );--死亡アニメの同期再生
			
			--飛竜関連のイベント監視削除
			--proxy:DeleteEvent( 800 );--待機
			return;
		else
			--→OnEvent_800_3_syncro_anime
			proxy:LuaCallStart( 800 , 3 );--死亡アニメの同期再生
			return;
		end
	end
	
	--[[現在の状態取得]]
	local now_state = GetNpcStateFlag( proxy, param, kenzoku_2_flag_list );
	
	--[[状態が、「警戒」]]
	if now_state == KENZOKU_2_STATE_WARNING then
			
		--[[待機(通路)]]
		if proxy:IsCompleteEvent( 830 ) == false and  --2320
		   proxy:IsCompleteEvent( 831 ) == false and  --2321
		   proxy:IsCompleteEvent( 832 ) == false then --2322
		   
			local rand = proxy:GetRandom( 1 , 3 );--1～2
			
			if rand == 1 then
				print("待機1");
				kenzoku_2_play_anime_id = 7006;--待機1のアニメID(次のアニメ判定用に保持)
				--→OnEvent_800_syncro_anime
				proxy:LuaCallStart( 800 , 1 );--待機1アニメの同期再生
			elseif rand == 2 then
				print("待機2");
				kenzoku_2_play_anime_id = 7010;--待機2のアニメID(次のアニメ判定用に保持)
				--→OnEvent_800_2_syncro_anime
				proxy:LuaCallStart( 800 , 2 );--待機2アニメの同期再生
			end
		
		--[[領域Aブレス]]
		elseif
		   proxy:IsCompleteEvent( 830 ) == true and   --2320
		   proxy:IsCompleteEvent( 831 ) == false and  --2321
		   proxy:IsCompleteEvent( 832 ) == false then --2322
			
			print("領域Aブレス");
			kenzoku_2_play_anime_id = 7007;--[[ブレスAのアニメID]]
			--→OnEvent_801_syncro_anime
			proxy:LuaCallStart( 801 , 1 );--ブレスAアニメの同期再生
		
		--[[領域Bブレス]]
		elseif
		   proxy:IsCompleteEvent( 831 ) == true and   --2321
		   proxy:IsCompleteEvent( 832 ) == false then --2322
			
			print("領域Bブレス");
		    kenzoku_2_play_anime_id = 7008;--[[ブレスBのアニメID]]
			--→OnEvent_802_syncro_anime
			proxy:LuaCallStart( 802 , 1 );--ブレスBアニメの同期再生

		--[[領域Cブレス]]
		elseif
		   proxy:IsCompleteEvent( 832 ) == true then --2322
		
			print("領域Cブレス");
			kenzoku_2_play_anime_id = 7009;--[[ブレスCのアニメID]]
			--→OnEvent_803_syncro_anime
			proxy:LuaCallStart( 803 , 1 );--ブレスCアニメの同期再生
		end
		
	--[[状態が、「ヘロヘロ」]]
	elseif now_state == KENZOKU_2_STATE_HEROHERO then
		
		print("へろへろ")
		kenzoku_2_play_anime_id = 7020;
			--→OnEvent_804_syncro_anime
		proxy:LuaCallStart( 804 , 1 );
	end	
	
	print("OnEvent_800 end");
end



--▲800_anime_end▲状態に対応するアニメを再生終了▲
function OnEvent_800_anime_end(proxy, param)
	print("OnEvent_800_anime_end begin");
	
	--そのままループするアニメ
	
	if kenzoku_2_play_anime_id == 7006 or   --待機1
	   kenzoku_2_play_anime_id == 7010 or   --待機2
	   kenzoku_2_play_anime_id == 7007 or   --ブレスA
	   kenzoku_2_play_anime_id == 7008 or   --ブレスB
	   kenzoku_2_play_anime_id == 7009 or   --ブレスC
	   kenzoku_2_play_anime_id == 7020 or	--ヘロヘロ
	   kenzoku_2_play_anime_id == 7030 then --死亡
	   
		proxy:NotNetMessage_begin();
			--▼飛竜の眷属２が元気に飛び回る▼
			proxy:OnKeyTime2( 800 , "OnEvent_800" , 0.0 , 0 , 1 , once );
		proxy:NotNetMessage_end();
	
	--終了後なにもしないアニメ
	
	--elseif kenzoku_2_play_anime_id == 7030 then --死亡

	end
	
	print("OnEvent_800_anime_end end");
end





--------------------------------------------------------------------------------------
--■800～804,806■飛竜の同期アニメ再生■
--------------------------------------------------------------------------------------

--■待機1
--LuaCallParam(800,1)
function OnEvent_800_syncro_anime(proxy, param)
	print("OnEvent_800_syncro_anime begin");
	
	proxy:Warp( 110 , 2330 );--位置を合わせるための領域にワープ
	proxy:ForcePlayAnimationStayCancel( 110 , 7006 );--待機アニメ再生
	
	--発動者(＝ホスト)のみアニメ終了を監視
	if	param:IsNetMessage() == false then
	
		proxy:NotNetMessage_begin();
			--▼800▼状態に対応するアニメを再生終了▼
			proxy:OnChrAnimEnd( 800 , 110 , 7006 , "OnEvent_800_anime_end" , once );
		proxy:NotNetMessage_end();	
	end
		
	print("OnEvent_800_syncro_anime end");
end


--■待機2
--LuaCallParam(800,2)
function OnEvent_800_2_syncro_anime(proxy, param)
	print("OnEvent_800_2_syncro_anime begin");
	
	proxy:Warp( 110 , 2330 );--位置を合わせるための領域にワープ
	proxy:ForcePlayAnimationStayCancel( 110 , 7010 );--待機アニメ再生
	
	--発動者(＝ホスト)のみアニメ終了を監視
	if	param:IsNetMessage() == false then
	
		proxy:NotNetMessage_begin();
			--▼800▼状態に対応するアニメを再生終了▼
			proxy:OnChrAnimEnd( 800 , 110 , 7010 , "OnEvent_800_anime_end" , once );
		proxy:NotNetMessage_end();	
	end
		
	print("OnEvent_800_2_syncro_anime end");
end

--■死亡待機
function OnEvent_800_3_syncro_anime(proxy,param)
	print("OnEvent_800_3_syncro_anime begin");
	
	proxy:DeleteEvent( 801 );--ブレスA
	proxy:DeleteEvent( 802 );--ブレスB
	proxy:DeleteEvent( 803 );--ブレスC
	proxy:DeleteEvent( 804 );--ヘロヘロ
	proxy:DeleteEvent( 805 );--ヘロヘロ移行
	
	proxy:SetDeadMode( 110 , false );--死亡有効
	proxy:SetHp( 110, 0.0 );
	--ホストのみアイテム入手
	if	proxy:IsClient() == false then
		proxy:GetRateItem(10118);--アイテム入手
	end
	
	print("飛竜(眷属2)死亡");		
	--飛竜(眷属2)の状態フラグを「死亡」にする
	
	SetNpcStateFlag(proxy, param, kenzoku_2_flag_list, KENZOKU_2_STATE_DEAD );
	SetNpcStateFlag( proxy, param, kenzoku_flag_list, KENZOKU_STATE_DEAD );
	
	--無効化を遅らせる
	InvalidCharactor( proxy, 110 );
	
	print("OnEvent_800_3_syncro_anime end");
end



--■ブレスA
--LuaCallParam(801,1)
function OnEvent_801_syncro_anime(proxy, param)
	print("OnEvent_801_syncro_anime begin");
	
	proxy:Warp( 110 , 2330 );--位置を合わせるための領域にワープ
	proxy:ForcePlayAnimationStayCancel( 110 , 7007 );--ブレスAアニメ再生
	
	--発動者(＝ホスト)のみアニメ終了を監視
	if	param:IsNetMessage() == false then
	
		proxy:NotNetMessage_begin();
			--▼800▼状態に対応するアニメを再生終了▼
			proxy:OnChrAnimEnd( 800 , 110 , 7007 , "OnEvent_800_anime_end" , once );
		proxy:NotNetMessage_end();	
	end
		
	print("OnEvent_801_syncro_anime end");
end



--■ブレスB
--LuaCallParam(802,1)
function OnEvent_802_syncro_anime(proxy, param)
	print("OnEvent_802_syncro_anime begin");
	
	proxy:Warp( 110 , 2330 );--位置を合わせるための領域にワープ
	proxy:ForcePlayAnimationStayCancel( 110 , 7008 );--ブレスBアニメ再生
	
	--発動者(＝ホスト)のみアニメ終了を監視
	if	param:IsNetMessage() == false then
	
		proxy:NotNetMessage_begin();
			--▼800▼状態に対応するアニメを再生終了▼
			proxy:OnChrAnimEnd( 800 , 110 , 7008 , "OnEvent_800_anime_end" , once );
		proxy:NotNetMessage_end();	
	end
		
	print("OnEvent_800_syncro_anime end");
end




--■ブレスC
--LuaCallParam(803,1)
function OnEvent_803_syncro_anime(proxy, param)
	print("OnEvent_803_syncro_anime begin");
	
	proxy:Warp( 110 , 2330 );--位置を合わせるための領域にワープ
	proxy:ForcePlayAnimationStayCancel( 110 , 7009 );--ブレスCアニメ再生
	
	--発動者(＝ホスト)のみアニメ終了を監視
	if	param:IsNetMessage() == false then
	
		proxy:NotNetMessage_begin();
			--▼800▼状態に対応するアニメを再生終了▼
			proxy:OnChrAnimEnd( 800 , 110 , 7009 , "OnEvent_800_anime_end" , once );
		proxy:NotNetMessage_end();	
	end
		
	print("OnEvent_803_syncro_anime end");
end



--■ヘロヘロ
--LuaCallParam(804,1)
function OnEvent_804_syncro_anime(proxy, param)
	print("OnEvent_804_syncro_anime begin");
	
	proxy:Warp( 110 , 2330 );--位置を合わせるための領域にワープ
	proxy:ForcePlayAnimationStayCancel( 110 , 7020 );--ヘロヘロアニメ再生
	
	--発動者(＝ホスト)のみアニメ終了を監視
	if	param:IsNetMessage() == false then
	
		proxy:NotNetMessage_begin();
			--▼800▼状態に対応するアニメを再生終了▼
			proxy:OnChrAnimEnd( 800 , 110 , 7020 , "OnEvent_800_anime_end" , once );
		proxy:NotNetMessage_end();	
	end
		
	print("OnEvent_804_syncro_anime end");
end



--■死亡
--LuaCallParam(806,1)
function OnEvent_806_syncro_anime(proxy, param)
	print("OnEvent_806_syncro_anime begin");
	
	
	proxy:Warp( 110 , 2330 );--位置を合わせるための領域にワープ
	proxy:ForcePlayAnimation( 110 , 7030 );--死亡アニメ再生
	
	
	--飛竜(眷属2)の状態フラグを「死亡」にする
	SetNpcStateFlag(proxy, param, kenzoku_2_flag_list, KENZOKU_2_STATE_DEAD );
	SetNpcStateFlag( proxy, param, kenzoku_flag_list, KENZOKU_STATE_DEAD );
	
	--発動者(＝ホスト)のみアニメ終了を監視
	if	param:IsNetMessage() == false then
	
		proxy:NotNetMessage_begin();
			--▼800▼状態に対応するアニメを再生終了▼
			proxy:OnChrAnimEnd( 800 , 110 , 7030 , "OnEvent_800_anime_end" , once );
		proxy:NotNetMessage_end();	
	end
	
	print("OnEvent_806_syncro_anime end");
end


--[[
--------------------------------------------------------------------------------------
--■805■飛竜の眷属２がヘロヘロになる■
--------------------------------------------------------------------------------------

--■805■飛竜の眷属２がヘロヘロになる■
function OnEvent_805(proxy, param)
	print("OnEvent_805 begin");

	--飛竜(眷属2)の状態をヘロヘロにする
	SetNpcStateFlag(proxy, param, kenzoku_2_flag_list , KENZOKU_2_STATE_HEROHERO);
	
	--リピートなので、フラグ立てない
	
	print("OnEvent_805 end");
end
]]

--------------------------------------------------------------------------------------
--■806■飛竜の眷属２が死ぬ■
--------------------------------------------------------------------------------------

--■806■飛竜の眷属２が死ぬ■
function OnEvent_806(proxy, param)
	print("OnEvent_806 begin");

	proxy:SetEventFlag( 806 , 1 );--HP監視フラグON
	
	print("OnEvent_806 end");
end



--------------------------------------------------------------------------------------
--■521■ビヨが獄吏を倒しに行く■(会話システムから呼び出し)
--------------------------------------------------------------------------------------

--■521■ビヨが獄吏を倒しに行く■(会話システムから呼び出し)
function OnEvent_521(proxy, param)
	print("OnEvent_521 begin");
	
	--獄吏が死んでいたら処理抜け
	if proxy:IsCompleteEvent( 560 ) == true then
		print("OnEvent_521 end");
		return;
	end
	
	proxy:EnableLogic( 622 , true );--ビヨロジックON
	proxy:SetEventCommand( 622 , 51 );--EzStateに制御番号(立ち上がる)を渡す
	proxy:SetTeamType( 622 , TEAM_TYPE_BattleFriend );	
		
	proxy:ForceChangeTarget( 622 , 115 );--ビヨのターゲットを獄吏に指定
	
	--ビヨの状態を「獄吏を倒したい」にする
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_TARGET_ENEMY );
	
	proxy:SetEventFlag( 521 , 1 );
	
	print("OnEvent_521 end");
end




--------------------------------------------------------------------------------------
--■522■ビヨが牢内で寝る■(会話システムから呼び出し)
--------------------------------------------------------------------------------------

--■522■ビヨが牢内で寝る■(会話システムから呼び出し)
function OnEvent_522(proxy, param)
	print("OnEvent_522 begin");
	
	--獄吏が生きていたら処理抜け
	if proxy:IsCompleteEvent( 560 ) == false then
		print("OnEvent_522 end");
		return;
	end
	
	proxy:EnableLogic( 622 , false );--ビヨロジックOFF
	proxy:SetEventCommand( 622 , 60 );--EzStateに制御番号(寝る)を渡す
	proxy:SetTeamType( 622 , TEAM_TYPE_Friend );	
		
	--ビヨの状態を「牢内で寝ている」にする
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_SLEEPING_IN_PRISON );
	
	proxy:SetEventFlag( 522 , 1 );
	
	print("OnEvent_522 end");
end


--[[
--------------------------------------------------------------------------------------
--■524■ビヨが次のブロックへ移動■
--------------------------------------------------------------------------------------

function Check_OnEvent_524(proxy, param)

	--生存プレイヤー(グレイ)のみ判定
	if proxy:IsLivePlayer() == false and
	   proxy:IsGreyGhost()  == false then
		return false;
	end
	
	--現在の状態取得
	local now_state = GetNpcStateFlag( proxy, param, biyo_flag_list );
	
	--「牢屋で寝ている」でも、「逆襲に満足して寝る」でもないとき、処理抜け
	if now_state ~= BIYO_STATE_SLEEPING_IN_PRISON and
	   now_state ~= BIYO_STATE_END_OF_STRIKES_BACK then
		return false;
	end
	
	--獄吏が生きていたら処理抜け
	if proxy:IsCompleteEvent( 560 ) == false then
		return false;
	end
	
	--距離判定
	if proxy:IsDistance( 10000 , 622 , 20 ) == true then
		return false;
	else
		print("ビヨルングルム、次ブロックへ移動");
		return true;
	end
	
	return false;
end


--■524■ビヨが次のブロックへ移動■
function OnEvent_524(proxy, param)
	print("OnEvent_524 begin");
	
	InvalidCharactor( proxy , 622 );--ビヨ無効化

	--ビヨの状態を「王城3を探索」にする
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_SEARCH_3 );

	proxy:SetEventFlag( 524 , 1 );
	
	print("OnEvent_524 end");
end
]]


--------------------------------------------------------------------------------------
--■525■ビヨが牢内で敵になる■
--------------------------------------------------------------------------------------

--■525■ビヨが牢内で敵になる■
function OnEvent_525(proxy, param)
	print("OnEvent_525 begin");
	
	if	proxy:IsCompleteEvent( BIYO_STATE_CAPTIVE ) == true or
		proxy:IsCompleteEvent( BIYO_STATE_THANKS ) == true or
		proxy:IsCompleteEvent( BIYO_STATE_SLEEPING_IN_PRISON ) == true then
		
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_HOSTILE_IN_PRISON );
		
		proxy:SetEventCommand( 622 , 51 );--EzStateに制御番号(立ち上がる)を渡す
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 525 , "OnEvent_525_1",1.0,1,100 , once );
		proxy:NotNetMessage_end();
		proxy:EnableLogic( 622 , true );--[[ビヨロジックON( ロジック切り替え？ )]]	
		proxy:SetEventFlag( 525 , 1 );
		proxy:EraseEventSpecialEffect_2(622,5064);
		proxy:SetTeamType(622, TEAM_TYPE_AngryFriend);--チームタイプ変更
	end
	
	print("OnEvent_525 end");
end

function OnEvent_525_1(proxy,param)
	proxy:SetEventCommand( 622 , 51 );--EzStateに制御番号(立ち上がる)を渡す
end

--------------------------------------------------------------------------------------
--■526■ビヨが城壁で敵になる■
--------------------------------------------------------------------------------------

--■526■ビヨが牢内で敵になる■
function OnEvent_526(proxy, param)
	print("OnEvent_526 begin");
	
	--「獄吏を倒したい」でも「逆襲に満足して寝る」でもないとき、処理抜け
	if	proxy:IsCompleteEvent( BIYO_STATE_TARGET_ENEMY ) 		== true or
		proxy:IsCompleteEvent( BIYO_STATE_END_OF_STRIKES_BACK ) == true then
		
		proxy:EnableLogic( 622 , true );--[[ビヨロジックON( ロジック切り替え？ )]]
		proxy:SetEventCommand( 622 , 51 );--EzStateに制御番号(立ち上がる)を渡す
		
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 525 , "OnEvent_525_1",1.0,1,100 , once );
		proxy:NotNetMessage_end();
		--ビヨの状態を「敵対(城壁)」にする
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_HOSTILE_IN_RAMPART );
		
		proxy:EraseEventSpecialEffect_2(622,5064);
		proxy:SetTeamType(622, TEAM_TYPE_AngryFriend);--チームタイプ変更
		proxy:SetEventFlag( 526 , true );
	end
	
	print("OnEvent_526 end");
end

--------------------------------------------------------------------------------------
--■530■ビヨが逆襲に満足して寝る■
--------------------------------------------------------------------------------------
--■530■ビヨが逆襲に満足して寝る■
function OnEvent_530(proxy,param)
	print("OnEvent_530 begin");
	proxy:DisableInterupt( 622 , true );
	MoveRegion(proxy, 622, 2240, -1 ,0.0,true);
	proxy:NotNetMessage_begin();
		proxy:OnRegionIn( 530 , 622 , 2240 , "OnEvent_530_1",once); 	
	proxy:NotNetMessage_end();
	print("OnEvent_530 end");
end

function OnEvent_530_1(proxy,param)
	print("OnEvent_530_1 begin");
	proxy:DisableInterupt( 622 , false );
	proxy:EnableLogic( 622, false );--ビヨロジックOFF
	proxy:SetEventCommand( 622 , 60 );--EzStateに制御番号(寝る)を渡す
	proxy:SetTeamType( 622 , TEAM_TYPE_Friend );
	proxy:SetEventFlag( 530, true );	
	proxy:SetEventFlag( 531, true );
	print("OnEvent_530_1 end");
end

--------------------------------------------------------------------------------------
--■720■王子が感謝する■
--------------------------------------------------------------------------------------
--[[
function Check_OnEvent_720(proxy, param)

	--現在の状態を取得
	local now_state = GetRendolState(proxy, param);

	--状態が「隠れているので助けて」でない場合は処理抜け
	if now_state ~= RENDOL_STATE_HELP_HIDING_ME then
		return false;
	end
	
	--レンドル王子追っかけ兵士を全部倒したら感謝へ
	if proxy:IsCompleteEvent( 652 ) == true and
	   proxy:IsCompleteEvent( 654 ) == true then
	   print("レンドル王子追っかけ兵士を全て倒しました");
	   return true;
	end
	
	return false;
end
]]

--■720■王子が感謝する■
function OnEvent_720(proxy, param)
	print("OnEvent_720 begin");
	
	proxy:SetEventFlag( param:GetParam1(), true );
	
	--生きていれば終了
	if	proxy:IsCompleteEvent( 652 ) == false or
		proxy:IsCompleteEvent( 654 ) == false or
		proxy:IsCompleteEvent( 655 ) == false or
		proxy:IsCompleteEvent( 656 ) == false or
		proxy:IsCompleteEvent( 657 ) == false or
		proxy:IsCompleteEvent( 658 ) == false then
		print("OnEvent_720 is No Success");
		print("OnEvent_720 end");
		return;
	end
	
	
	--王子の状態を「感謝(王城2)」に変更を試みる
	if proxy:IsCompleteEvent( RENDOL_STATE_HELP_HIDING_ME ) == true then
		SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_THANKS_2 );
		RendolCheck(proxy,param);--王城１スクリプト参照
	
		--proxy:SetEventCommand( 620 , 41 );--EzStateに制御番号(怯え終了)を渡す。
		proxy:SetSpStayAndDamageAnimId( 620, -1,-1);		
	end
--[[	
		--▼10800▼王子が探索を開始するイベント用監視を追加▼
		if proxy:IsCompleteEvent( 10800 ) == false then
			proxy:NotNetMessage_begin();
				proxy:LuaCall( 10800 , 0 , "OnEvent_10800" , once );--会話システムから呼ぶ場合にはparam=0
			proxy:NotNetMessage_end();
	end
]]	
	proxy:DeleteEvent( 720 );--監視削除
	proxy:SetEventFlag( 720 , 1 );
	
	print("OnEvent_720 end");
end


--------------------------------------------------------------------------------------
--■10800■王子が探索を開始する■(会話システムから呼び出し)
--------------------------------------------------------------------------------------

--■10800■王子が探索を開始する■
function OnEvent_10800(proxy, param)
	print("OnEvent_10800 begin");
	if	proxy:IsCompleteEvent( 10800 ) == true then
		return;
	end
	
	--アイテム取得関数
	proxy:GetRateItem(10192);
	
	--アイテムを取得済み
	proxy:SetEventFlag( 10800, 1 );
	
	--王城2で探索に 状態遷移を試みる

	--目の前で消えるのを回避する為、RendolCheckをしない
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_SEARCH_2 );	
	--	proxy:EnableLogic( 620 , true );--レンドル王子、探索状態で歩き出す
	--
	
	--移動タイプを往復に変更
	proxy:SetEventMovePointType( 620, POINT_MOVE_TYPE_RoundTrip );
	
	--移動ポイントを変更
	local point_list = {2220, 2221, 2222, 2223};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--移動ポイントを設定
		proxy:AddCustomRoutePoint(620, point_list[index]);
	end
	
	proxy:ResetThink( 620 );
	
	print("OnEvent_10800 end");
end




--------------------------------------------------------------------------------------
--■722■王子が次のブロックに移動する■
--------------------------------------------------------------------------------------
--[[
function Check_OnEvent_722(proxy, param)

	--現在の状態を取得
	local now_state = GetRendolState(proxy, param);

	--状態が「王城2を探索」でない場合は処理抜け
	if now_state ~= RENDOL_STATE_SEARCH_2 then
		return false;
	end
	
	--距離判定
	if proxy:IsDistance( 10000 , 620 , 20 ) == true then
		return false;
	else
		print("レンドル王子、次ブロックへ移動");
		return true;
	end
	
	return false;
end


--■722■王子が次のブロックに移動する■
function OnEvent_722(proxy, param)
	print("OnEvent_722 begin");
	
	--王城3で「見えない場所にこっそり」に 状態遷移を試みる
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_LOCATION_INVISIBLE );

	InvalidCharactor( proxy , 620 );--レンドル王子無効化
	
	proxy:SetEventFlag( 722 , 1 );
	proxy:DeleteEvent( 722 );--監視削除
	
	print("OnEvent_722 end");
end

]]

--------------------------------------------------------------------------------------
--■723■王子が敵対する■
--------------------------------------------------------------------------------------

--■723■王子が敵対する■
function OnEvent_723(proxy, param)
	print("OnEvent_723 begin");
	
	--王城2で敵対に状態遷移を試みる
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HOSTILE_2 );
	RendolCheck(proxy,param);
	
	proxy:SetEventFlag( 723 , true );
	
	print("OnEvent_723 end");
end


--------------------------------------------------------------------------------------
--■724■王子が死ぬ■
--------------------------------------------------------------------------------------

--■724■王子が死ぬ■
function OnEvent_724(proxy, param)
	print("OnEvent_724 begin");

	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_DEAD );
	RendolCheck(proxy,param);
	--死亡でRendolCheckする場合、その瞬間に消えてしまうので、
	--距離を見て再度有効にするか決める
	if	proxy:IsDistance( LOCAL_PLAYER, 620, 20 ) == true then
		ValidCharactor( proxy, 620 );
	end
		print("レンドル王子が死亡しました。");

	proxy:SetEventFlag( 724 , 1 );
	
	print("OnEvent_724 end");
end

--------------------------------------------------------------------------------------
--■760■奴隷兵士の敵対化■
--------------------------------------------------------------------------------------

--■760■奴隷兵士の敵対化■
function OnEvent_760(proxy, param)
	print("OnEvent_760 begin");
	
	--現在の状態を取得
	local now_state = GetNpcStateFlag(proxy, param, DOREISOL_SHOP_Flag_list);

	--状態が「販売中」でなかったら処理抜け
	if now_state ~= DOREISOL_SHOP_SELL02 then
		return;
	end
	
	--奴隷兵士の状態を「敵対(王城2)」にする
	SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_HOSTILE02 );
	--奴隷兵士のチームタイプを変更する
	proxy:SetTeamType( 623, TEAM_TYPE_AngryFriend );
	
	proxy:EnableLogic( 623 , true );--[[ロジックON(ロジック切り替え?)]]
	print("奴隷兵士が敵になりました");--↑失敗していたらならないけれど･･･。
	
	proxy:SetEventFlag( 760 , 1 );
	
	print("OnEvent_760 end");
end


--------------------------------------------------------------------------------------
--■761■奴隷兵士の死亡■
--------------------------------------------------------------------------------------

--■761■奴隷兵士の死亡■
function OnEvent_761(proxy, param)
	print("OnEvent_761 begin");

	--奴隷兵士の状態を「死亡」にする
	SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_DEAD );
	print("奴隷兵士が死にました");--↑失敗していたらならないけれど･･･。	

	--敵に削られて敵対を通り越して死亡もありえるので、ここでも削除
	--死んだら敵対にはならないので削除
	proxy:DeleteEvent( 760 );

	proxy:SetEventFlag( 761 , 1 );
	
	print("OnEvent_761 end");
end




--------------------------------------------------------------------------------------
--■550■ボスカメラ切り替えイベント■
--------------------------------------------------------------------------------------
function OnEvent_550(proxy,param)
	--print("OnEvent_550 begin");
	--ボスが死んでいない　かつ　ボスとの戦闘を開始している
	if proxy:IsCompleteEvent( 4224 ) == false and proxy:IsCompleteEvent( 585 ) == true then
		--ボス戦　非ロックカメラ
		proxy:SetCamModeParamTargetId(2021);
		--ボス戦　ロックカメラ
		proxy:SetCamModeParamTargetIdForBossLock(2020);
	end
	--print("OnEvent_550 end");
end


--------------------------------------------------------------------------------------
--カラスが飛び立つ
--------------------------------------------------------------------------------------
function FryAwayKarasu(proxy,param, KarasuEventID, karasuID, KarasuAnimID)	
	print("FryAwayKarasu_"..karasuID.." begin");

	proxy:PlayAnimation( karasuID, KarasuAnimID );

	proxy:NotNetMessage_begin();
		--▼カラスアニメ再生終了▼
		proxy:OnObjAnimEnd( KarasuEventID , karasuID , KarasuAnimID , "OnEvent_"..KarasuEventID.."_1" , once );	
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( KarasuEventID , 1 );

	print("FryAwayKarasu_"..karasuID.." end");
end

-----------------------------------------
--カラスアニメ再生終了したので消していく
-----------------------------------------
function OnEvent_850_1(proxy,param)	proxy:SetDrawEnable( 1230 , false ); print("KarasuFryAway ID=1230"); end
function OnEvent_851_1(proxy,param)	proxy:SetDrawEnable( 1231 , false ); print("KarasuFryAway ID=1231"); end
function OnEvent_852_1(proxy,param)	proxy:SetDrawEnable( 1232 , false ); print("KarasuFryAway ID=1232"); end
function OnEvent_853_1(proxy,param)	proxy:SetDrawEnable( 1233 , false ); print("KarasuFryAway ID=1233"); end
function OnEvent_854_1(proxy,param)	proxy:SetDrawEnable( 1234 , false ); print("KarasuFryAway ID=1234"); end
function OnEvent_855_1(proxy,param)	proxy:SetDrawEnable( 1235 , false ); print("KarasuFryAway ID=1235"); end
function OnEvent_856_1(proxy,param)	proxy:SetDrawEnable( 1236 , false ); print("KarasuFryAway ID=1236"); end
function OnEvent_857_1(proxy,param)	proxy:SetDrawEnable( 1237 , false ); print("KarasuFryAway ID=1237"); end
function OnEvent_858_1(proxy,param)	proxy:SetDrawEnable( 1238 , false ); print("KarasuFryAway ID=1238"); end
function OnEvent_859_1(proxy,param)	proxy:SetDrawEnable( 1239 , false ); print("KarasuFryAway ID=1239"); end
function OnEvent_860_1(proxy,param)	proxy:SetDrawEnable( 1240 , false ); print("KarasuFryAway ID=1240"); end
function OnEvent_861_1(proxy,param)	proxy:SetDrawEnable( 1241 , false ); print("KarasuFryAway ID=1241"); end
function OnEvent_862_1(proxy,param)	proxy:SetDrawEnable( 1242 , false ); print("KarasuFryAway ID=1242"); end
function OnEvent_863_1(proxy,param)	proxy:SetDrawEnable( 1243 , false ); print("KarasuFryAway ID=1243"); end
function OnEvent_864_1(proxy,param)	proxy:SetDrawEnable( 1244 , false ); print("KarasuFryAway ID=1244"); end
function OnEvent_865_1(proxy,param)	proxy:SetDrawEnable( 1245 , false ); print("KarasuFryAway ID=1245"); end
function OnEvent_866_1(proxy,param)	proxy:SetDrawEnable( 1246 , false ); print("KarasuFryAway ID=1246"); end
function OnEvent_867_1(proxy,param)	proxy:SetDrawEnable( 1247 , false ); print("KarasuFryAway ID=1247"); end
function OnEvent_868_1(proxy,param)	proxy:SetDrawEnable( 1248 , false ); print("KarasuFryAway ID=1248"); end
function OnEvent_869_1(proxy,param)	proxy:SetDrawEnable( 1249 , false ); print("KarasuFryAway ID=1249"); end
function OnEvent_870_1(proxy,param)	proxy:SetDrawEnable( 1250 , false ); print("KarasuFryAway ID=1250"); end

---------------------------------
--カラスが飛び立つ関数を呼び出す
---------------------------------
function OnEvent_850(proxy, param) FryAwayKarasu(proxy, param, 850, 1230, 12); end
function OnEvent_851(proxy, param) FryAwayKarasu(proxy, param, 851, 1231, 12); end
function OnEvent_852(proxy, param) FryAwayKarasu(proxy, param, 852, 1232, 12); end
function OnEvent_853(proxy, param) FryAwayKarasu(proxy, param, 853, 1233, 12); end
function OnEvent_854(proxy, param) FryAwayKarasu(proxy, param, 854, 1234, 12); end
function OnEvent_855(proxy, param) FryAwayKarasu(proxy, param, 855, 1235, 12); end
function OnEvent_856(proxy, param) FryAwayKarasu(proxy, param, 856, 1236, 12); end
function OnEvent_857(proxy, param) FryAwayKarasu(proxy, param, 857, 1237, 12); end
function OnEvent_858(proxy, param) FryAwayKarasu(proxy, param, 858, 1238, 12); end
function OnEvent_859(proxy, param) FryAwayKarasu(proxy, param, 859, 1239, 12); end
function OnEvent_860(proxy, param) FryAwayKarasu(proxy, param, 860, 1240, 12); end
function OnEvent_861(proxy, param) FryAwayKarasu(proxy, param, 861, 1241, 12); end
function OnEvent_862(proxy, param) FryAwayKarasu(proxy, param, 862, 1242, 12); end
function OnEvent_863(proxy, param) FryAwayKarasu(proxy, param, 863, 1243, 12); end
function OnEvent_864(proxy, param) FryAwayKarasu(proxy, param, 864, 1244, 12); end
function OnEvent_865(proxy, param) FryAwayKarasu(proxy, param, 865, 1245, 11); end
function OnEvent_866(proxy, param) FryAwayKarasu(proxy, param, 866, 1246, 10); end
function OnEvent_867(proxy, param) FryAwayKarasu(proxy, param, 867, 1247, 11); end
function OnEvent_868(proxy, param) FryAwayKarasu(proxy, param, 868, 1248, 10); end
function OnEvent_869(proxy, param) FryAwayKarasu(proxy, param, 869, 1249, 11); end
function OnEvent_870(proxy, param) FryAwayKarasu(proxy, param, 870, 1250, 10); end


--------------------------------------------------------------------------------------
--■610■QWC:ソウルモンスター出現１■
--------------------------------------------------------------------------------------
function OnEvent_610(proxy,param)
	print("OnEvent_610 begin");
	
	--ソウルモンスターを表示させる
	ValidCharactor( proxy, 150 );
	ValidCharactor( proxy, 151 );
	
	--ソウルモンスターの出現アニメの再生
	proxy:PlayAnimation( 150, 6100 );
	proxy:PlayAnimation( 151, 6100 );
	
	--フラグON
	proxy:SetEventFlag( 610, true )

	print("OnEvent_610 end");
end



--------------------------------------------------------------------------------------
--■570■封印城門開放？■
--------------------------------------------------------------------------------------
function OnEvent_570(proxy,param)
	print("OnEvent_570 begin");
	if proxy:IsCompleteEvent( 8035 ) == false then
		--表示「強力なソウルの力で封印されいる」
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010195, 1);
		--proxy:ShowGenDialog(10010195,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:RequestOpenBriefingMsg(10010195,true);
			proxy:OnRegionJustOut( 570 , 10000 , 2251, "OnEvent_570_out",once);
			--proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010195, 0, 6, 1270, 10, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	else
		--王都の門開放ポリ劇
		proxy:RequestRemo( 20101 ,REMO_FLAG , 571 ,1);
		proxy:SetEventFlag( 571,true );
	end
	print("OnEvent_570 end");
end

--領域から出た
function OnEvent_570_out(proxy,param)
	print("OnEvent_570_out begin");
	proxy:CroseBriefingMsg();
	print("OnEvent_570_out end");
end

--ポリ劇開始フォードアウト後
function OnEvent_571_RemoStart(proxy,param)
	print("OnEvent_571_RemoStart begin");
	proxy:DeleteEvent( 570 );
	proxy:InvalidSfx( 2210 , true);
	print("OnEvent_571_RemoStart end");
end

--ポリ劇終了フェードイン前
function OnEvent_571_RemoFinish(proxy,param)
	print("OnEvent_571_RemoFinish begin");
	OnEvent_781(proxy,param);
	proxy:EndAnimation(1270,2);
	print("OnEvent_571_RemoFinish end");
end


-----------------------------------------------------------------------------
--■590■結晶トカゲイベント2
-----------------------------------------------------------------------------
function OnEvent_590(proxy,param)
	print("OnEvent_590 begin");
	proxy:SetEventFlag( 590, true);
	proxy:DeleteEvent( 590 );
	print("OnEvent_590 end");
end

-----------------------------------------------------------------------------
--■592■結晶トカゲイベント3
-----------------------------------------------------------------------------
function OnEvent_592(proxy,param)
	print("OnEvent_592 begin");
	proxy:SetEventFlag( 592, true);
	proxy:DeleteEvent( 592 );
	print("OnEvent_592 end");
end
