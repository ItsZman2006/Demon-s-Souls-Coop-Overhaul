
FIREDAM_WAIT = 2.0;

--■ドランの状態一覧
DORAN_STATE_GUARD 		= 16280;--霊廟を護る
DORAN_STATE_ALLOWED		= 16281;--許してくれた
DORAN_STATE_NOT_ALLOWED	= 16282;--もう許さない
DORAN_STATE_DEAD		= 16283;--死亡

doran_flag_list = {
	DORAN_STATE_GUARD 		,
	DORAN_STATE_ALLOWED 	,
	DORAN_STATE_NOT_ALLOWED ,
	DORAN_STATE_DEAD 
};

--奴隷兵士ショップの状態一覧
DOREISOL_SHOP_SELL01	= 16083;	--移動したい(王城1)
DOREISOL_SHOP_HOSTILE01 = 16084;	--敵対(王城1)
DOREISOL_SHOP_DEAD		= 16082;	--死亡
DOREISOL_SHOP_SELL02	= 16080;	--移動したい(王城2)
DOREISOL_SHOP_HOSTILE02 = 16081;	--敵対(王城2)
DOREISOL_SHOP_SELL03	= 16085;	--移動したい(王城3)
DOREISOL_SHOP_HOSTILE03 = 16086;	--敵対(王城3)

DOREISOL_SHOP_Flag_list = {
	DOREISOL_SHOP_SELL01,
	DOREISOL_SHOP_HOSTILE01,
	DOREISOL_SHOP_DEAD,
	DOREISOL_SHOP_SELL02,
	DOREISOL_SHOP_HOSTILE02,
	DOREISOL_SHOP_SELL03,
	DOREISOL_SHOP_HOSTILE03
}

--奴隷兵士のショップが敵対するためのダメージ値
DoreiShop_TotalDamage = 100;


--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■
--------------------------------------------------------------------------------------
function Initialize_m02_00_00_00(proxy)
	print("Initialize_m02_00_00_00 begin");
	
	proxy:LuaCall( 99999 , 0 , "OnEvent_4000_Hp_1",everytime);
--■0■城門開放レバー■--PCがイベントエリア(1000)の中に距離(1.5m)有効角(30度幅)でアクションボタンを押した
		
	--ボスがいきているときだけ監視追加
	if proxy:IsCompleteEvent( 4096 ) == false then	
		if proxy:IsCompleteEvent( 0 ) ==false then
			proxy:OnDistanceAction( 0, LOCAL_PLAYER, 1000, "OnEvent_0", LeverDist_A, HELPID_PULL_LEVER, 0, LeverAngle_A, once);
			proxy:LuaCall(0,1,"OnEvent_0_4",once);
			proxy:NotNetMessage_begin();
				proxy:LuaCall(0,REMO_START,"OnEvent_0_RemoStart",once);
				proxy:LuaCall(0,REMO_FINISH,"OnEvent_0_RemoFinish",once);
			proxy:NotNetMessage_end();
			proxy:SetDrawEnable( 1008 , false );
			proxy:SetColiEnable( 1008 , false );
		else
			proxy:EndAnimation( 1000, 1 );--レバーアニメを終了
			proxy:EndAnimation( 1001, 1 );--正門が開くアニメを終了
			proxy:EndAnimation( 1140, 1 );--ギアが動くアニメを終了
		end
	else
		proxy:EndAnimation( 1000, 1 );--レバーアニメを終了
		proxy:EndAnimation( 1001, 1 );--正門が開くアニメを終了
		proxy:EndAnimation( 1140, 1 );--ギアが動くアニメを終了
	end
	
--■4096■城内部への扉開放■中ボス死亡時--
	proxy:AddFieldInsFilter( 800 );
	if proxy:IsCompleteEvent( 4096 ) ==false then		
		proxy:OnCharacterDead(4096, 800, "OnEvent_4096", once);
	else
		proxy:EndAnimation( 1002, 1 );
	end
	

--■10■レバー操作で城門塔右の扉開放■--PCがイベントエリア(1005)の中に距離(1.5m)有効角(30度幅)でアクションボタンを押した
	if proxy:IsCompleteEvent( 10 ) ==false then
		--扉開く配信用
		--アクション監視追加
		proxy:OnDistanceAction( 10, LOCAL_PLAYER, 1005, "OnEvent_10", LeverDist_A, HELPID_PULL_LEVER, 0, LeverAngle_A, once);
		
	else
		proxy:EndAnimation( 1003, 1 );--扉アニメを終了
		proxy:EndAnimation( 1005, 1 );--レバーアニメを終了
	end

--■110■ボス部屋に入る■
	
	--中ボスが生きているときだけイベント登録
	if proxy:IsCompleteEvent( 4096 ) == false then
	
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。
		SingleReset(proxy, 110);
	
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き)
		proxy:LuaCall( 111, 1, "OnEvent_111_1", everytime );
		
		--▽2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCall( 111 , 5 , "OnEvent_110_GO_TO_IN" , everytime );
		
		--▽フラグセット(同期用)
		proxy:LuaCall( 111 , 6 , "OnEvent_110_flag_set" , everytime );
		
		--誰かがボス前扉をまだ通過していない
		if proxy:IsCompleteEvent( 110 ) == false then
		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--▼110▼扉が開いているときに中に入るためのイベントを追加▼
				proxy:OnPlayerActionInRegionAttribute( 110, 2895, "OnEvent_110", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
		
		else --グレイゴーストできたときようにいると思われる。
		
			proxy:NotNetMessage_begin();
				--▼111▼扉が開いているときに中に入るためのイベントを追加▼
				proxy:OnPlayerActionInRegion( 111, 2895, "OnEvent_110", HELPID_GO_TO_IN, everytime );--ハンドラは上と同じ
			proxy:NotNetMessage_end();
		
		end

		--取り合えずファランクス部屋のみ対応
		--ボス用アタリ切り替え
		print("ボス部屋アタリボス用");
		proxy:SetColiEnableArray(3010,false);--通常無効		
		proxy:SetColiEnableArray(3002,true);--ボス用有効
		proxy:SetColiEnableArray(3001,true);--ボス用有効		
		
	else
		--取り合えずファランクス部屋のみ対応
		--ボス用アタリ切り替え
		print("ボス部屋アタリ通常");
		proxy:SetColiEnableArray(3010,true);--通常有効		
		proxy:SetColiEnableArray(3002,false);--ボス用無効
		proxy:SetColiEnableArray(3001,false);--ボス用無効
	end

	
--■114■ボス戦闘開始■	
	if proxy:IsCompleteEvent( 4096 ) == false then
		proxy:OnRegionJustIn( 114 , LOCAL_PLAYER , 2887 , "OnEvent_114" , once );
		proxy:LuaCall( 114 , 10 , "OnEvent_114_1",everytime);
	end	
	
	--[[
	proxy:NotNetMessage_begin();
		proxy:OnRegionJustIn( 450, LOCAL_PLAYER , 2887 , "OnEvent_450_In",everytime );
		proxy:OnRegionJustOut( 450 , LOCAL_PLAYER , 2887 , "OnEvent_450_Out",everytime );
	proxy:NotNetMessage_end();
	]]
	
--■50■レバー対応扉（左）■PCがイベントエリア(1006)距離(1.5m)反応角(180度幅)でアクションボタンを押した
	if proxy:IsCompleteEvent( 50 ) ==false then
		--アクション監視追加
		proxy:OnDistanceAction( 50, LOCAL_PLAYER, 1006, "OnEvent_50", LeverDist_A, HELPID_PULL_LEVER, 0, LeverAngle_A ,once);
	else
		proxy:EndAnimation( 1004, 1 );--扉アニメを終了
		proxy:EndAnimation( 1006, 1 );--レバーアニメを終了
	end

--■70■石柱にワープ■
	SingleReset(proxy,70);
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	proxy:OnDistanceAction( 70 , LOCAL_PLAYER , 1983 , "OnEvent_70" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180, everytime );


--カラスイベントをリピートさせるためにSingleReset()
	local actionId_list = { 350 , 351 ,353 , 354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375};	
	local num = table.getn( actionId_list );
	for IndexID = 1, num , 1 do
		SingleReset(proxy, actionId_list[ IndexID ]);
	end

--カラスがＰＣが近づくと飛び立つ
	for KarasuID = 1, num, 1 do
		if proxy:IsCompleteEvent( actionId_list[ KarasuID ] ) == false then
			proxy:OnPlayerDistanceInTarget( actionId_list[ KarasuID ], LOCAL_PLAYER, 740 + actionId_list[KarasuID], "OnEvent_"..actionId_list[KarasuID], 5, once );
		else
			proxy:SetDrawEnable(740 + actionId_list[KarasuID], false);
			proxy:SetColiEnable(740 + actionId_list[KarasuID], false);		
		end
	end

--■90■薄板壁を壊して敵が飛び出してくる■
	
	--[[2008.06.28/toyohide とりあえず
	if proxy:IsCompleteEvent( 90 ) == false then
		proxy:OnRegionJustIn( 90, LOCAL_PLAYER, 2040, "OnEvent_90" , once );
	else
		proxy:EndAnimation( 1120 , 1 );
	end
	]]
	proxy:EndAnimation( 1120 , 1 );
	
--■91■薄板壁を壊して敵が飛び出してくる2■
	if proxy:IsCompleteEvent( 91 ) == false then
		proxy:SetSuperArmor( 215 , true );
		proxy:SetSuperArmor( 216 , true );
		proxy:OnRegionJustIn( 91, LOCAL_PLAYER, 2041, "OnEvent_91" , once );
	else
		proxy:EndAnimation( 1121 , 1 );
		proxy:EndAnimation( 1122 , 1 );
	end


	
--■180■一般兵士が降りてくる■
	if proxy:IsCompleteEvent( 180 ) == false then
		proxy:SetSuperArmor( 211 , true );
		proxy:SetSuperArmor( 206 , true );
		proxy:OnRegionJustIn( 180 , LOCAL_PLAYER , 2100 , "OnEvent_180" , once );--領域用
		proxy:OnSimpleDamage( 182 , 211 , LOCAL_PLAYER , "OnEvent_180_00" , once );--攻撃受けた用(ID:211) 別ID
		proxy:OnSimpleDamage( 183 , 206 , LOCAL_PLAYER , "OnEvent_180_01" , once );--攻撃受けた用(ID:206) 別ID
	else

	end
	
	
--■200■処刑場への扉■
	SingleReset(proxy,200);
	if proxy:IsClient() == false then
		if	proxy:IsSuccessQWC(20600) == true or 
			proxy:IsSuccessQWC(20300) == true or 
			proxy:IsCompleteEvent(201) == true then
			proxy:SetEventFlag( 200, true );	
		end
	end
	
	if proxy:IsCompleteEvent( 200 ) == false then
		--[[
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 200, LOCAL_PLAYER, 1040, "OnEvent_200", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, everytime ); 
		proxy:NotNetMessage_end();	
		proxy:LuaCall( 200, 1, "OnEvent_200_1", once );--アニメーション同期用
		]]
	else
		proxy:EndAnimation( 1040, 1 );
	end
	
--■201■処刑場の扉を超えた■
	if proxy:IsCompleteEvent( 201 ) == false then
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionIn( 201 , 10000 , 2020 , "OnEvent_201",once);
			proxy:NotNetMessage_end();
		end
	else
	
	end
	
--■210■霊廟への扉■
	--[[
	if proxy:IsCompleteEvent( 210 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 210, LOCAL_PLAYER, 1045, "OnEvent_210", DoorDist_A, HELPID_OPEN, 0, DoorAngle_A, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 210, 1, "OnEvent_210_1", once );--アニメーション同期用
	else
		proxy:EndAnimation( 1045, 1 );
	end
	]]

--■211■霊廟への扉2■
	if proxy:IsCompleteEvent( 211 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 211, LOCAL_PLAYER, 1047, "OnEvent_211", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 211, 1, "OnEvent_211_1", once );--アニメーション同期用
	else
		proxy:EndAnimation( 1047, 1 );
	end

--■5■霊廟の祭壇■
	if proxy:IsCompleteEvent( 5 ) == false then
		--ドランが既に許している
		if proxy:IsCompleteEvent( 330 ) == true then
	
			--調べるイベント自体は同期します、調べれる人はホストorシングルプレイヤーです
			--proxy:NotNetMessage_begin();
				--ホスト、生存、グレイのみ調べることができる
				local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
				--HELPIDがデモンブランド専用になった
				proxy:OnDistanceActionAttribute( 5 , LOCAL_PLAYER , 1192 , "OnEvent_5" , ItemBoxDist_A , 10010130 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
				proxy:LuaCall( 5,1,"OnEvent_5_2",once);
				proxy:LuaCall( 5,2,"OnEvent_5_3",once);
				proxy:TreasureDispModeChange2( 1192, true ,KEN_SFX);
				--proxy:SetRarity( 1192, 10104 );
			--proxy:NotNetMessage_end();
		end
	else
		proxy:SetDrawEnable( 1192 , false );--ひとまず描画だけOFF
		proxy:SetColiEnable( 1192 , false );
		
		proxy:InvalidSfx( 1192, false );
	end	
	--proxy:TreasureDispModeChange( 1192, true );
	--proxy:SetRarity( 1192, 10104 );
	
--■35■QWCによる飛竜の無効化
	SingleReset(proxy,35);
	if	proxy:IsSuccessQWC(20400 ) == true then
		proxy:SetEventFlag( 35, true );
	end
	if	proxy:IsCompleteEvent( 35 ) == false then
		--■232■領域監視■指定領域にプレイヤーがひとりでもいる場合フラグON/誰もいない場合フラグOFF
			proxy:OnNetRegion( 222, 2039 );
			proxy:OnNetRegion( 223, 2131 );
			proxy:OnNetRegion( 224, 2132 );
			proxy:OnNetRegion( 225, 2133 );
	else
		--飛竜無効化
		--InvalidCharactor(proxy, 300);
		--InvalidCharactor(proxy, 301);
	end
	
	
	
	--☆☆☆☆☆☆☆☆☆☆飛竜のネットワーク位置非同期設定☆☆☆☆☆☆☆☆☆☆
	proxy:SetNoNetSync(300,true);
	proxy:SetNoNetSync(501,true);
	proxy:SetNoNetSync(301,true);
	proxy:SetNoNetSync(110,true);
	--☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆	
--■236■飛竜の眷属の表示切替
	--proxy:OnRegionJustIn( 236, LOCAL_PLAYER, 2190, "HiryuKenzokuCheck", everytime );
	--proxy:OnRegionJustIn( 236, LOCAL_PLAYER, 2191, "HiryuKenzokuCheck", everytime );
	--[[
	アサート回避の為、初回登録にダミー登録
	]]
	proxy:LuaCall( 199, 1, "dummy", everytime );
	proxy:LuaCall( 221, 1, "dummy", everytime );
	proxy:LuaCall( 221, 2, "dummy", everytime );
	proxy:LuaCall( 190, 1, "dummy", everytime );
	proxy:LuaCall( 190, 2, "dummy", everytime );
	proxy:LuaCall( 191, 1, "dummy", everytime );
	proxy:LuaCall( 191, 2, "dummy", everytime );
	proxy:LuaCall( 230, 1, "dummy", everytime );
	proxy:LuaCall( 230, 2, "dummy", everytime );
	proxy:LuaCall( 231, 1, "dummy", everytime );
	proxy:LuaCall( 231, 2, "dummy", everytime );
	proxy:LuaCall( 232, 1, "dummy", everytime );
	proxy:LuaCall( 232, 2, "dummy", everytime );
	proxy:LuaCall( 800 , 1 , "dummy"   , everytime );--待機
	proxy:LuaCall( 800 , 2 , "dummy" , everytime );--待機2
	proxy:LuaCall( 800 , 3 , "dummy" , everytime );--死亡待機
	proxy:LuaCall( 801 , 1 , "dummy" , everytime );--ブレスA
	proxy:LuaCall( 802 , 1 , "dummy" , everytime );--ブレスB
	proxy:LuaCall( 803 , 1 , "dummy" , everytime );--ブレスC
	proxy:LuaCall( 804 , 1 , "dummy" , everytime );--ヘロヘロ
	proxy:LuaCall( 806 , 1 , "dummy" , everytime );--死亡		
--■807■飛竜の眷属の表示切替
	--proxy:OnRegionJustIn( 807, LOCAL_PLAYER, 2390, "HiryuKenzokuCheck", everytime );
	--proxy:OnRegionJustIn( 807, LOCAL_PLAYER, 2391, "HiryuKenzokuCheck", everytime );
	proxy:NotNetMessage_begin();
	--	proxy:LuaCall( 236, 2, "HiryuKenzokuCheck", once );
	proxy:CustomLuaCall( 4060, "HiryuKenzokuCheck", everytime );
	proxy:NotNetMessage_end();
	--一先ず、王城１からという設定にしておく
	--理由としては王城１からならチェックポイントを経由せずに飛竜に会うことが起こりにくい為です。
	--正式な対応は、ブロック移動した時に呼び出すハンドラを用意して、
	--チェックポイントを無視した簡易バックリード的な作りが良いと思います。
	--ブロックごとに読み込みを切り替えるのは、
	--飛竜が常にバックリード＆強制更新の為、関係ない場所でイベントが動くのを防ぐのが主な理由です。
	--proxy:LuaCallStartPlus( 236, 2, 2190 );

--■258■奴隷兵士がレンドル王子を狙うのをやめる
	--(状態判定部分で監視追加)
	

--■391～409■樽爆発(小)■
--■421～430■樽爆発(大)■
	TaruRegist( proxy,param);
--■6■兵士が火炎瓶を投げる■
	ThrowFirePotRegist_b1(proxy);
	
--■251～256■奴隷兵士の死亡監視(レンドル王子周り)
	DoreiRegist_block1(proxy);
	
	

--■280■吊るされた死体1が落下する■
	if proxy:IsCompleteEvent( 280 ) == false then
		proxy:OnObjectDestroy( 280 , 1172 , "OnEvent_280" , once );--吊るしている紐の破壊監視
	else
		proxy:EndAnimation( 10240 , 1000 );--死体のほうのアニメを終了
	end

	
--■281■吊るされた死体2が落下する■
	if proxy:IsCompleteEvent( 281 ) == false then
		proxy:OnObjectDestroy( 281 , 1174 , "OnEvent_281" , once );--吊るしている紐の破壊監視
	else
		proxy:EndAnimation( 10241 , 1000 );--死体のほうのアニメを終了
	end

	
--
--■285■砲弾ゴロゴロ■
	SingleReset( proxy, 285 );
	if proxy:IsCompleteEvent( 285 ) == false then
		proxy:OnObjectDestroy( 285 , 1190 , "OnEvent_285" , once );--箱の破壊監視	
	else
		proxy:EndAnimation( 1191 , 1 );--ゴロゴロアニメ再生終了
	end
	
--■310～319■ソウルモンスター出現■
	RegistSoulMonster_block1(proxy);
	

--■320■はしご1降りる■
	proxy:OnActionEventRegion(320, 2026, "OnEvent_320", LadderAngle_A, HELPID_DOWN, everytime);
		
--■321■はしご1昇る■
	proxy:OnActionEventRegion(321, 2027, "OnEvent_321", LadderAngle_A, HELPID_UP,   everytime);
	
	
--■2■飛竜が飛んでくるポリ劇を再生する■
	if proxy:IsCompleteEvent( 2 ) == false then
	
		--proxy:OnRegionJustIn( 2 , LOCAL_PLAYER , 2000 , "OnEvent_2" , once );
	
		proxy:NotNetMessage_begin();
			--ポリ劇開始フェード後に呼ばれるハンドラ
			proxy:LuaCall(2,REMO_START,"OnEvent_2_RemoStart",once);
			--ポリ劇終了後に呼ばれるハンドラ
			proxy:LuaCall(2,REMO_FINISH,"OnEvent_2_RemoFinish",once);
		proxy:NotNetMessage_end();
		OnEvent_2(proxy,param);
	end

--■30■最初の要石の光が消える■
		proxy:OnSessionJustIn( 30 , "OnEvent_30" , everytime );
		
--■31■最初の要石の光が復活する■
		proxy:OnSessionJustOut( 31 , "OnEvent_31" , everytime );


	
--■??■徘徊デーモンの登場■ハンドラ登録
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。
		proxy:LuaCall( 4000, 100, "PlayerDeath_m02_00_00_00", everytime );
		--プレイヤーが復活した時にキックされます。
		proxy:LuaCall( 4032, 100, "PlayerRevive_m02_00_00_00", everytime );
	proxy:NotNetMessage_end();
	
	

--チェックポイント用の監視
	local check_point_list	= {2190, 2191, 2390, 2590, 2790, 2791};
	local check_point_num	= table.getn(check_point_list);
	for index = 1, check_point_num, 1 do
		proxy:OnRegionJustIn( SYSTEM_CHECK_POINT, LOCAL_PLAYER, check_point_list[index], "CheckPointIn_AttrCheck", everytime );
	end
	--最初に1回チェックしておく
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "InitializeNpc", 0.0, 0, 2, once );
		proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "HiryuOsaCheck",0.0, 0, 3, once );
	proxy:NotNetMessage_end();

	--チェックポイント配信用
	proxy:LuaCall( SYSTEM_CHECK_POINT, 2, "CheckPointIn", everytime );
	
	if proxy:IsClient() == false then
		if proxy:IsCompleteEvent( 85 ) == false then
			proxy:NotNetMessage_begin();
			proxy:OnRegionJustIn( 85 , LOCAL_PLAYER , 2002 , "OnEvent_85" , once );
			proxy:NotNetMessage_end();
		end
	end
	
	--レンドル王子の更新権限はホストが管理
	if	proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork( 620 );
		proxy:RequestForceUpdateNetwork( 621 );
		proxy:RequestForceUpdateNetwork( 624 );
		proxy:RequestForceUpdateNetwork( 626 );
	end

	
	--■0■城門開放レバー■がおわっているとき
	if proxy:IsCompleteEvent( 0 ) == true then

		proxy:DeleteEvent( 230 );--飛竜飛んでくるイベント監視削除
		
		--魔法壁見えている
		proxy:SetColiEnable( 1999 , true );
		proxy:SetColiEnable( 1995 , true );
	
		proxy:SetDrawEnable( 1999 , true );
		proxy:SetDrawEnable( 1995 , true );
		
		--魔法壁のSFX ON
		proxy:ValidSfx( 1987 );
		proxy:ValidSfx( 1991 );
	else
	
		--魔法壁消えている
		proxy:SetColiEnable( 1999 , false );
		proxy:SetColiEnable( 1995 , false );
	
		proxy:SetDrawEnable( 1999 , false );
		proxy:SetDrawEnable( 1995 , false );
		
		--魔法壁のSFX OFF
		proxy:InvalidSfx( 1987 , false );
		proxy:InvalidSfx( 1991 , false );
	end
	
	
--■ボス関連の初期化処理
	if proxy:IsCompleteEvent( 4096 ) ==true then
		
		--▽ボス死んでいるとき
		--ファランクス死亡
		--m02_00_00_00_eventboss のInitにて記述
		
		--魔法壁消える
		proxy:SetColiEnable( 1999 , false );
		proxy:SetColiEnable( 1995 , false );
	
		proxy:SetDrawEnable( 1999 , false );
		proxy:SetDrawEnable( 1995 , false );
		
		--魔法壁のSFX OFF
		proxy:InvalidSfx( 1987 , false );
		proxy:InvalidSfx( 1991 , false );
		

	else
		--▽ボス生きているとき	
		
			--ファランクス用の初期化処理
			--m02_00_00_00_eventboss のInitにて記述
		
		--[[光の壁を表示しなければならないが、■0■城門開放レバー■でやっている]]
	end		
	
	
	--■4103,4105■ソウル入手、要石でワープ■
	if proxy:IsCompleteEvent( 4096 ) ==true then--ボスが死んでいるとき
		
		proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);--光らせる
		--▼(ソウル)アイテム取得用イベント監視追加▼
		if proxy:IsCompleteEvent( 4103 ) == false then
			--SFX有効化
			proxy:ValidSfx( 1080 );--光の粒子
			proxy:ValidSfx( 1081 );--要石のオーラ			
			proxy:OnDistanceActionAttribute( 4103 , LOCAL_PLAYER , 1982 , "OnEvent_4103" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );

			--ソウル有効化
			proxy:SetDrawEnable( 1982 , true );
			proxy:SetColiEnable( 1982 , true );
			--ソウル2有効化
			proxy:SetDrawEnable( 1975 , true );
			proxy:SetColiEnable( 1975 , true );

		else
			--SFX OFF
			proxy:InvalidSfx( 1080, false );--光の粒子
			--proxy:InvalidSfx( 1081, false );--要石のオーラ
			--▼要石でワープ用の監視を追加▼
			SingleReset(proxy,4105);
			proxy:OnDistanceActionAttribute( 4105 , LOCAL_PLAYER , 1982 , "OnEvent_4105" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end

	else
		--ボスが生きている
		--ソウル無効化
		proxy:SetDrawEnable( 1982 , false );
		proxy:SetColiEnable( 1982 , false );
		--ソウル2無効化
		proxy:SetDrawEnable( 1975 , false );
		proxy:SetColiEnable( 1975 , false );
		
		--SFX OFF
		proxy:InvalidSfx( 1080, false );--光の粒子
		proxy:InvalidSfx( 1081, false );--要石のオーラ
	end

--[[--削除との事なので、コメントアウト
--■90■薄板壁を壊して敵が飛び出してくる■キャラ制御
	
	if proxy:IsCompleteEvent( 90 ) == false then
		proxy:EnableLogic( 202 , 0 );--ロジックきってるけど、敵が攻撃してくる?
		proxy:SetDrawEnable( 202 , false );
		proxy:SetColiEnable( 202 , false );
	else
		proxy:EnableLogic( 202 , 1 );
		proxy:SetDrawEnable( 202 , true );
		proxy:SetColiEnable( 202 , true );
	end]]
	
	--■91■薄板壁を壊して敵が飛び出してくる2■キャラ制御
	if proxy:IsCompleteEvent( 91 ) == false then
		proxy:EnableLogic( 215 , 0 );
		proxy:SetDrawEnable( 215 , false );
		proxy:SetColiEnable( 215 , false );
		
		proxy:EnableLogic( 216 , 0 );
		proxy:SetDrawEnable( 216 , false );
		proxy:SetColiEnable( 216 , false );
	else
		proxy:EnableLogic( 215 , 1 );
		proxy:SetDrawEnable( 215 , true );
		proxy:SetColiEnable( 215 , true );
		
		proxy:EnableLogic( 216 , 1 );
		proxy:SetDrawEnable( 216 , true );
		proxy:SetColiEnable( 216 , true );
	end
	
	
	--■160■奴隷兵士が落ちてくる■ロジック制御
	if proxy:IsCompleteEvent( 160 ) == false then
		proxy:EnableLogic( 220 , false );
		proxy:SetDrawEnable( 220 , false );
		proxy:SetColiEnable( 220 , false );--場所が変わっていたので、あたりも消した。
	--	proxy:Warp( 220 , 2110 );--塔(?)のほうにワープ
	else
		proxy:EnableLogic( 220 , 1 );
	end
	
	
	--■180■一般兵士が降りてくる■ロジック制御	
	if proxy:IsCompleteEvent( 180 ) == false then
		
		proxy:Warp( 211 , 2170 );
		proxy:Warp( 206 , 2171 );
		
		proxy:ForceUpdateNextFrame( 211 );
		proxy:ForceUpdateNextFrame( 206 );
		
		proxy:EnableLogic( 211 , 0 );
		proxy:EnableLogic( 206 , 0 );
	else
		proxy:EnableLogic( 211 , 1 );
		proxy:EnableLogic( 206 , 1 );
	end
	
--[[	
	--■181■一般兵士が降りてくる2■ロジック制御
	if proxy:IsCompleteEvent( 181 ) == false then
		proxy:EnableLogic( 221 , 0 );
	else
		proxy:EnableLogic( 221 , 1 );
	end
]]	


	--■中ボス死亡で扉が開く(死んでいたら、描画と当たりを消す)
	if proxy:IsCompleteEvent( 4096 ) == true then
		proxy:SetColiEnable( 1999 , false );
		proxy:SetColiEnable( 1995 , false );
	
		proxy:SetDrawEnable( 1999 , false );
		proxy:SetDrawEnable( 1995 , false );	
	end
	

--[[
	--■徘徊デーモン用 (フラグは仮、指定があれば変える)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m02_00_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m02_00_00_00);
	end
]]

--[[
	--■220■飛竜(長)が寝ている■
	proxy:EnableLogic( 300 , false );--飛竜(長)ロジックOFF
	proxy:PlayLoopAnimation( 300 , 7000 );--警戒しているアニメループ再生
	
	if proxy:IsCompleteEvent( 220 ) == true then

		--領域監視を追加しなおす
		proxy:SetEventFlag( 220 , 0 );
		proxy:OnRegionIn( 220 , LOCAL_PLAYER , 2130 , "OnEvent_220" , everytime );
		proxy:SetEventFlag( 220 , 1 );
	
	else
		proxy:PlayLoopAnimation( 300 , 7000 );--寝ているアニメループ再生
	end
]]
	
	
	--光の霧を通過できるキャラタイプ(このタイプの人だけアクションボタンが反応する)
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	
	--■240■ホストPCのみが通れる光の霧■
	if proxy:IsCompleteEvent( 240 ) == true then--ホストが通過済み
		proxy:SetDrawEnable( 1055 , false );
		proxy:SetColiEnable( 1055 , false );
		proxy:InvalidSfx(2075, false);
	else
		--▼240▼魔法壁削除同期用▼
		proxy:LuaCall( 240 , 1 , "OnEvent_240_delete_wall" , once );
		--▼240▼壁の中に入るイベント発動用▼
		proxy:OnDistanceActionAttribute( 240 , LOCAL_PLAYER , 1055 , "OnEvent_240" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
	
	
	--■241■ホストPCのみが通れる光の霧■
	if proxy:IsCompleteEvent( 241 ) == true then--ホストが通過済み
		proxy:SetDrawEnable( 1056 , false );
		proxy:SetColiEnable( 1056 , false );
		proxy:InvalidSfx(2076, false);
	else
		--▼241▼魔法壁削除同期用▼
		proxy:LuaCall( 241 , 1 , "OnEvent_241_delete_wall" , once );
		
		--▼241▼壁の中に入るイベント発動用▼
		proxy:OnDistanceActionAttribute( 241 , LOCAL_PLAYER , 1056 , "OnEvent_241" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
	
	
	--■242■ホストPCのみが通れる光の霧■
	if proxy:IsCompleteEvent( 242 ) == true then--ホストが通過済み
		proxy:SetDrawEnable( 1057 , false );
		proxy:SetColiEnable( 1057 , false );
		proxy:InvalidSfx(2077, false);
	else		
		--▼242▼魔法壁削除同期用▼
		proxy:LuaCall( 242 , 1 , "OnEvent_242_delete_wall" , once );
		
		--▼242▼壁の中に入るイベント発動用▼
		proxy:OnDistanceActionAttribute( 242 , LOCAL_PLAYER , 1057 , "OnEvent_242" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end

	


	
	--■285■砲弾ゴロゴロ■
	if proxy:IsCompleteEvent( 285 ) == true then
		proxy:ReconstructBreak( 1190 , 1 );--箱オブジェの破壊再現
	end
	
	
	
	

--■飛竜(長)イベント関連初期化

	--初期化
	proxy:SetDisableGravity( 300 , true );--重力OFF
	proxy:EnableLogic( 300 , false );--思考OFF
	proxy:SetSuperArmor( 300 , true );--ダメージモーションさせない
	proxy:SetDeadMode(300, true);--飛竜は死なない設定(死にそうになったら撤退する)
	
	
	--初期状態をセット(状態が未設定の場合、指定した状態をセットする)
	SetFirstNpcStateFlag( proxy , param , tyo_flag_list , TYO_STATE_WARNING_AISLE );
	
	--現在の状態取得
	local now_tyo_state = GetNpcStateFlag( proxy , param , tyo_flag_list );
	
	--飛竜の長が、王の間(王城4)からこっそり退去する
	if now_tyo_state == TYO_STATE_WARNING_KING_ROOM or 
	   now_tyo_state == TYO_STATE_WARNING_GATE      then
	   
		--飛竜(長)の状態を「警戒(通路)」にセット
		SetNpcStateFlag( proxy , param , tyo_flag_list , TYO_STATE_WARNING_AISLE );
	end
	
	--現在の状態取得(状態が変わった可能性があるので)
	local now_tyo_state = GetNpcStateFlag( proxy , param , tyo_flag_list );
	
	--警戒(通路)
	if now_tyo_state == TYO_STATE_WARNING_AISLE then
		
		proxy:EnableLogic( 300 , false );
		proxy:PlayLoopAnimation( 300 , 7000 );
		
	--死亡
	elseif now_tyo_state == TYO_STATE_DEAD then
		InvalidCharactor( proxy , 300 );--いないことに･･･
		
		--飛竜(長)関連イベント削除
		proxy:DeleteEvent( 220 );--巣で寝ている
	end

	if	proxy:IsCompleteEvent( KENZOKU_2_STATE_DEAD ) == true or
	    proxy:IsCompleteEvent( KENZOKU_STATE_DEAD ) == true then
		proxy:OpeningDead( 301, false );
	end
	
--[[	
	--現在の状態取得
	local now_kenzoku_state = GetNpcStateFlag( proxy , param , kenzoku_flag_list );
	
	--状態ごとに必要な初期化があるなら･･･
	
	if now_kenzoku_state == KENZOKU_STATE_WARNING or 
       now_kenzoku_state == KENZOKU_STATE_WARNING_AND_LEVER then
		
		--巣にいる
		proxy:EnableLogic( 301 , false );
		proxy:PlayLoopAnimation( 301 , 0 );
		
	elseif now_kenzoku_state == KENZOKU_STATE_PROTECT_CASTLE then
	
		--城壁護ってる
		--プレイヤーがいなくなったら、勝手に巣帰るのでそのままで良いと思われる。
		
	elseif now_kenzoku_state == KENZOKU_STATE_DEAD    or 
		   now_kenzoku_state == KENZOKU_2_STATE_DEAD then
		   
		InvalidCharactor( proxy , 301 );--いないことに･･･
		
		--飛竜(眷属)関連イベント削除
		proxy:DeleteEvent( 221 );--巣で警戒している
		proxy:DeleteEvent( 230 );--城壁に飛んでくる
		
	end
]]
	
--■15610■ドランの死体を調べた■
	if proxy:IsCompleteEvent( 15610 ) == false then
		proxy:AddCorpseEvent( 15610 , 697 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15610 ,0 , "OnEvent_15610",once );
 		proxy:NotNetMessage_end();
	end
--■【NPC:ドラン】イベント関連初期化
	SetFirstNpcStateFlag( proxy , param , doran_flag_list , DORAN_STATE_GUARD );
	--ドランが生きているか
	if proxy:IsCompleteEvent( DORAN_STATE_DEAD ) == false then
		--ドランが戦闘態勢を取っている
		if proxy:IsCompleteEvent(DORAN_STATE_GUARD) == true then
			proxy:OnCharacterHP( 330, 697, "OnEvent_330", 0.8, once );	--ドランのＨＰが80％をきったら
			proxy:OnCharacterHP( 331, 697, "OnEvent_331", 0.6, once );	--ドランのＨＰが60％をきったら
			if proxy:IsCompleteEvent( 329 ) == false then
				proxy:EnableLogic( 697, false );			
				proxy:OnSimpleDamage( 329 , 697 , 10000 , "OnEvent_329" , once );
				proxy:LuaCall( 329 , 0 , "OnEvent_329",once );
			end
			--王子を最後まで助けた
			if proxy:IsCompleteEvent( 11790 ) == true then
				print("ドラン手加減");
				proxy:SendEventRequest( 697 ,0, 1);
				proxy:SetEventSpecialEffect_2( 697 , 5042 );
			end
			
		--ドランがPCを許している
		elseif proxy:IsCompleteEvent(DORAN_STATE_ALLOWED) == true then
			proxy:SetTeamType( 697, TEAM_TYPE_Friend );
			proxy:OnCharacterHP( 331, 697, "OnEvent_331", 0.6, once );
		elseif proxy:IsCompleteEvent(DORAN_STATE_NOT_ALLOWED) == true then
		end
		proxy:OnCharacterDead( 332, 697, "OnEvent_332", once );
	--ドランが死んでいたら
	else
		if proxy:IsCompleteEvent( 15610 ) == true then
			InvalidBackRead( proxy, 697 );
		else
			--死体を再現する
			proxy:OpeningDeadPlus( 697 , true ,false ,false );
		end
	end



	--■280■吊るされている宝死体■
	if proxy:IsCompleteEvent( 280 ) == true then
		proxy:ReconstructBreak( 1172 , 1 );--紐の破壊再現(タイミングの問題により･･･)
	else
		--死体の待機アニメ(吊るされている状態)
		proxy:PlayAnimation( 10240 , 1001 );

		--宝システム無効化
		proxy:EnableObjTreasure( 10240 , false );
	end
	
	--■281■吊るされている宝死体■
	if proxy:IsCompleteEvent( 281 ) == true then
		proxy:ReconstructBreak( 1174 , 1 );--紐の破壊再現
	else
		--死体の待機アニメ(吊るされている状態)
		proxy:PlayAnimation( 10241 , 1001 );

		--宝システム無効化
		proxy:EnableObjTreasure( 10241 , false );
	end	
	
--■61■ミラルダが死亡している場合の初期化処理■
	SingleReset( proxy, 61 );
	if proxy:IsCompleteEvent( 60 ) == true or
		proxy:IsSuccessQWC(20500) == false then
		proxy:SetEventFlag( 61 , true );
	end
	
--■15605■ミラルダ死体調べた■
	if proxy:IsCompleteEvent( 15605 ) == false then 
		proxy:AddCorpseEvent( 15605 , 628 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15605 , 0 , "OnEvent_15605",once);
		proxy:NotNetMessage_end();
	end
	
	if proxy:IsCompleteEvent( 61 ) == true then
		if proxy:IsCompleteEvent( 60 ) == true and proxy:IsCompleteEvent( 15605 ) == false then
			proxy:OpeningDeadPlus( 628 , true ,false ,false );			
		else
			InvalidBackRead( proxy, 628 );
			print("ミラルダのInvalidBackReadが成功しました");
		end
	else
		--■86■領域に入ったらフラグON■
		if proxy:IsCompleteEvent( 86 ) == false then
			proxy:OnRegionJustIn( 86 , 10000 , 2003 , "OnEvent_86",once);
		end
	end
	
	--[[
	--ホストは必ず登録する為、ふらぐおふ
	if	proxy:IsClient() == false then
		SingleReset( proxy, 62 );
	end
	]]
	
--■15635■ミラルダ・ブラックの死体を調べた■
	if proxy:IsCompleteEvent( 15635 ) == false then
		proxy:AddCorpseEvent( 15635 , 231 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15635 ,0 , "OnEvent_15635",once );
 		proxy:NotNetMessage_end();
	end	
	
	--■ミラルダ・ブラックの出現判定■
	if	proxy:IsCompleteEvent(62) == true or
		proxy:IsSuccessQWC(20300) == false then
		
		if 	proxy:IsCompleteEvent( 62 ) == true and
			proxy:IsCompleteEvent( 15635 ) == false then
			--死体を再現する
			proxy:OpeningDeadPlus( 231 , true ,false ,false );
		else
			InvalidBackRead( proxy, 231 );
		end
	else
		proxy:OnCharacterDead( 62, 231, "OnEvent_62", once );
		proxy:SetTeamType( 698, TEAM_TYPE_AngryFriend );
	end
	
	
--■60■ミラルダが死亡■
	if proxy:IsCompleteEvent( 60 ) == false then
		proxy:OnCharacterDead( 60, 628, "OnEvent_60", once );
	end
	
--■86■領域に入ったらフラグON■
	if proxy:IsCompleteEvent( 86 ) == false then
		proxy:OnRegionJustIn( 86 , 10000 , 2003 , "OnEvent_86",once);
	end

--■8084■吊るされている宝死体■
	proxy:SetEventFlag(8084, true)
--[[	
	--奴隷兵士のショップNPC
	if proxy:IsClient() == false then
		--クライアントが登録しないイベントなので、配信するとクライアント側でアサートが出る為、非配信設定に変更
		proxy:NotNetMessage_begin();
	--■340■奴隷兵士のショップNPCチェックポイント(扉前)■
		proxy:OnRegionJustIn(343 , LOCAL_PLAYER , 2120 ,"OnEvent_343" , everytime);
	--■340■奴隷兵士のショップNPCチェックポイント(扉前)■
		proxy:OnRegionJustIn(344 , LOCAL_PLAYER , 2191 ,"OnEvent_344" , everytime);
	--■340■奴隷兵士のショップNPCチェックポイント(扉前)■
		proxy:OnRegionJustIn(345 , LOCAL_PLAYER , 2390 ,"OnEvent_345" , everytime);
	--■340■奴隷兵士のショップNPCチェックポイント(扉前)■
		proxy:OnRegionJustIn(780 , LOCAL_PLAYER , 2790 ,"OnEvent_780" , everytime);
		proxy:NotNetMessage_end();
	end
	
	--■635■チェックポイントの監視■
	proxy:LuaCall( 781 , 1 , "OnEvent_781",everytime);

	--奴隷兵士の初期化用
	OnEvent_781(proxy, param);
]]	
	
--■7■敵が砲弾ごろごろ■
	RegistEvent_7(proxy);
	

--[[--削除との事なので、コメントアウト
--■10700,10701■吊るされている人が話しかけてくる■
	if proxy:IsCompleteEvent( 10700 ) == false then
		proxy:OnRegionIn( 10700 , LOCAL_PLAYER , 2051 , "OnEvent_10700" , everytime );
		--死体から会話(助けて)
		proxy:RegistSimpleTalk( 10700 , 10241 , 16000, TALK_ATTR_ALL );
		
		--死体から会話(感謝)
		proxy:RegistSimpleTalk( 10701, 10241, 16010, TALK_ATTR_ALL );
	end]]
	

--■15500■乱入アイテム取得監視■ハンドラはグローバルに定義
--~     if proxy:IsCompleteEvent( 15500 ) == false then
--~         proxy:AddCorpseEvent( 15500 , 231 );--ミラルダ・ブラック		
--~     end
	
	
--■100■かがり火ダメージ■
	local objIdlist = {1180,1181,1182,1183,1185,1186};
	local num = table.getn( objIdlist );
	local sec = FIREDAM_WAIT;
	for index=1 , num ,1 do
		proxy:NotNetMessage_begin();	
			proxy:OnObjectDamageHit_NoCallPlus( 100, objIdlist[index],1,10300,EV_HIT_CHR,0.5,-1,2.0,everytime);
			--proxy:OnKeyTime2( 100, "OnEvent_100_"..objIdlist[index],sec,0,objIdlist[index],once);		
		proxy:NotNetMessage_end();
		--proxy:OnDistanceJustIn(100,10000,objIdlist[index],"OnEvent_100_"..objIdlist[index],0.5,everytime);		
		sec = sec + 0.1;
	end
	
	
	--■8■一般兵士が火炎瓶投げる■
	SingleReset( proxy, 8 );
	if proxy:IsCompleteEvent( 8 ) == false then
		proxy:OnRegionJustIn( 8, 10000 , 2007 , "OnEvent_8" , once);
		proxy:OnSimpleDamage( 8, 247 , 10000 , "OnEvent_8" , once);
		
		proxy:OnRegionJustIn( 9, 10000 , 2008 , "OnEvent_9" , once);
		
		proxy:EnableLogic( 247, false );
	end
	
	
	--結晶トカゲ逃亡イベント
	RegistTokage(proxy,120,250,0);	
	
	--■999999■フレーム遅れの初期化処理イベントを発行■
	proxy:NotNetMessage_begin();
		--▼0秒後▼--
		proxy:OnKeyTime2( 999990, "Second_Initialize_m02_00_00_00", 0.3, 0, 0, once );	
	proxy:NotNetMessage_end();
	
	proxy:LuaCall(4081, 2, "hiryuu_test_1", everytime );
	proxy:LuaCall(4081, 3, "hiryuu_test_2", everytime );
	
	if proxy:IsDbgReLoad() == true then
		proxy:OnKeyTime2( 4021,"OnEvent_DbgReLoad",1.0,0,0,once);
	end
	print("Initialize_m02_00_00_00 end");
end

--リロードデバッグ
function OnEvent_DbgReLoad(proxy,param)
	--石柱の王城要石へ
	--完全回復要求
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1006 );	
end


function hiryuu_test_1(proxy,param)
	print("hiryuu_test_1 begin");
	proxy:PlayAnimation( 300, 7018 );
	print("hiryuu_test_1 end");
end

function hiryuu_test_2(proxy,param)
	print("hiryuu_test_2 begin");
	proxy:PlayAnimation( 301, 7011 );
	print("hiryuu_test_2 end");
end


--------------------------------------------------------------------------------------
--マルチになった時にホストじゃ無かったら■無し
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end

function OnEvent_4000_Hp_1(proxy,param)
	print("OnEvent_4000_Hp_1 begin");
	proxy:SetDeadMode2(800 , true );
	proxy:SetDeadMode2(801 , true );
	proxy:SetDeadMode2(802 , true );
	proxy:SetDeadMode2(821 , true );	
	print("OnEvent_4000_Hp_1 end");
end

--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく
function Second_Initialize_m02_00_00_00(proxy, param)
	print("Second_Initialize_m02_00_00_00 begin");

	--■280■吊るされている宝死体■
	if proxy:IsCompleteEvent( 280 ) == true then
		proxy:ReconstructBreak( 1172 , 1 );--紐の破壊再現(タイミングの問題により･･･)
	else
		--死体の待機アニメ(吊るされている状態)
		proxy:PlayAnimation( 10240 , 1001 );

		--宝システム無効化
		proxy:EnableObjTreasure( 10240 , false );
	end
	
	--■281■吊るされている宝死体■
	if proxy:IsCompleteEvent( 281 ) == true then
		proxy:ReconstructBreak( 1174 , 1 );--紐の破壊再現
	else
		--死体の待機アニメ(吊るされている状態)
		proxy:PlayAnimation( 10241 , 1001 );

		--宝システム無効化
		proxy:EnableObjTreasure( 10241 , false );
	end
--------------------------------▽▽▽QWCイベント関連▽▽▽--------------------------------
--------------------------------△△△QWCイベント関連△△△--------------------------------
	
	print("Second_Initialize_m02_00_00_00 end");
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--■391～409■樽爆発(小)■
--■421～430■樽爆発(大)■
-----------------------------------------------------------------------------------------------------------------------------------------------
function TaruRegist(proxy,param)
	print("TaruRegist begin");
	local Owner = 235;
	--弾丸オーナー利用
	CreateBulletOwner(proxy,Owner);	
	
	local small_acId_list	= {  391,  392,  393,  394,  395,  396,  397,  398,  399,  400,  401,  402,  403,  404,  405,  406,  407,  408,  409};
	local small_objId_list	= { 1141, 1142, 1143, 1144, 1145, 1146, 1147, 1148, 1149, 1150, 1151, 1152, 1153, 1154, 1155, 1156, 1157, 1158, 1159};
	local small_event_num = table.getn( small_acId_list );
	for index = 1, small_event_num, 1 do
		local acid = small_acId_list[index];
		local evid = small_objId_list[index];
		SingleReset(proxy,acid);
		if	proxy:IsCompleteEvent( acid ) == false then
			--proxy:OnFireDamage( acid, evid, -1, "OnEvent_"..acid, once );
			proxy:OnFireDamage( acid, evid, -1, "OnEvent_"..acid, once );
		else
			proxy:ReconstructBreak( evid, 1 );
		end
	end
	
	
	
	local big_acId_list		= {  421,  422,  423,  424,  425,  426,  427,  428,  429,  430};
	local big_objId_list	= { 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030};
	local big_event_num = table.getn( big_acId_list );
	for index = 1, big_event_num, 1 do
		local acid = big_acId_list[index];
		local evid = big_objId_list[index];
		SingleReset(proxy,acid);
		if	proxy:IsCompleteEvent( acid ) == false then
			proxy:OnFireDamage( acid, evid, -1, "OnEvent_"..acid, once );
		else
			proxy:ReconstructBreak( evid, 1 );
		end
	end
	print("TaruRegist end");
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--■391～409■樽爆発(小)■
-----------------------------------------------------------------------------------------------------------------------------------------------
function OnEvent_391(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_392(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_393(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_394(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_395(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_396(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_397(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_398(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_399(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_400(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_401(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_402(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_403(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_404(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_405(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_406(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_407(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_408(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_409(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end

-----------------------------------------------------------------------------------------------------------------------------------------------
--■421～430■樽爆発(大)■
-----------------------------------------------------------------------------------------------------------------------------------------------
function OnEvent_421(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_422(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_423(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_424(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_425(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_426(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_427(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_428(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_429(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_430(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end

--樽爆発まとめ
function TaruFunc(proxy,param,acId,Owner,objId,behaviorId,angX,angY,angZ)
	print("OnEvent_"..acId.." begin");
	proxy:CastPointSpell( Owner, objId, behaviorId, angX, angY, angZ );
	proxy:SetEventFlag( acId, true );
	print("OnEvent_"..acId.." end");
end




--------------------------------------------------------------------------------------
--城門開放レバー■0
--------------------------------------------------------------------------------------
--■0■城門開放レバー■
function OnEvent_0(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_0 begin");

	proxy:NotNetMessage_begin();
		--▼***条件追加***0秒後▼
		proxy:OnKeyTime2( 0, "OnEvent_0_3", 0.0, 0, 1, once);
	proxy:NotNetMessage_end();
	

	print("OnEvent_0 end");
end

--▲0_3▲PCがレバーイベントを起こしてから0秒後▲
function OnEvent_0_3(proxy, param)
	print("OnEvent_0_3 begin");
	
	proxy:LuaCallStart(0,1);
	
	--フラグを立てる(指示書に合わせるため)
	proxy:SetEventFlag( 1 , 1 );
	
	print("OnEvent_0_3 end");
end

function OnEvent_0_4(proxy,param)
	print("OnEvent_0_4 begin");
	
	if param:IsNetMessage() == true then
		--発動者出演ポリ劇
		proxy:RequestRemoPlus(20001,REMO_FLAG,0,1, param:GetPlayID()+10001);
	else
		--ポリ劇再生
		proxy:RequestRemoPlus(20001,REMO_FLAG,0,1,LOCAL_PLAYER);--正門が開くポリ劇
	end
	
	proxy:SetEventFlag( 0 , 1 );
	
	print("OnEvent_0_4 end");
end

--ポリ劇フェードアウト後
function OnEvent_0_RemoStart(proxy,param)
	print("OnEvent_0_RemoStart begin");
	--空
	print("OnEvent_0_RemoStart end");
end

--ポリ劇再生後
function OnEvent_0_RemoFinish(proxy,param)
	print("OnEvent_0_RemoFinish begin");
	
	--魔法壁が表示される
	proxy:SetColiEnable( 1999 , true );
	proxy:SetColiEnable( 1995 , true );

	proxy:SetDrawEnable( 1999 , true );
	proxy:SetDrawEnable( 1995 , true );
	
	--魔法壁のSFX ON
	proxy:ValidSfx( 1987 );
	proxy:ValidSfx( 1991 );
	
	--飛竜関連が飛んでくる(帰る)イベント監視削除
	--proxy:DeleteEvent( 230 );--飛んでくる
	
	proxy:EndAnimation( 1000, 1 );--レバーアニメを再生
	proxy:EndAnimation( 1001, 1 );--正門開放アニメを再生
	proxy:EndAnimation( 1140, 1 );--ギアが動くアニメ再生
	
	--槍OBJを有効化
	proxy:SetDrawEnable( 1008 , true );
	proxy:SetColiEnable( 1008 , true );
	
	print("OnEvent_0_RemoFinish end");
end

--------------------------------------------------------------------------------------
--城内部扉開放4096
--------------------------------------------------------------------------------------
--■4096■中ボス死亡時■
function OnEvent_4096(proxy, param)
	print("OnEvent_4096 begin");
	
	--ファランクス用死亡処理
	PhalanxDead(proxy,param);
	
	proxy:NotNetMessage_begin();
		--▼4100▼クライアントPCワープ演出▼
		proxy:OnKeyTime2( 4100, "OnEvent_4100", 0, 0, 0, once);
		--▼4096_1▼1秒経過▼
		proxy:OnKeyTime2( 4096, "OnEvent_4096_1", 1, 0, 1, once);
		--▼4102▼2秒経過▼
		proxy:OnKeyTime2( 4102, "OnEvent_4102", 2, 0, 2, once);
		
		--マルチ時のPTエリア移動回避
		proxy:OnRegistFunc( 4096 , "Check_4096_PT","OnEvent_4096_PT",0,once);
	proxy:NotNetMessage_end();

	
	proxy:SetEventFlag( 4096, 1 );
	
	--レンドル王子が探索だったら一定距離以上離れた時点で次の状態に遷移
	if	proxy:IsClient() == false then
		if	proxy:IsCompleteEvent( RENDOL_STATE_SEARCH_1 ) == true then
			if	proxy:IsDistance( LOCAL_PLAYER, 624, 20 ) == false then
				proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "OnEvent_301", 0.0, 0, 2, once );
			else
				proxy:OnPlayerDistanceOut( 301, LOCAL_PLAYER, 624, "OnEvent_301", 20, once );
			end
		end
	end
	
	--新ブロッククリア処理へ
	proxy:CustomLuaCallStart( 4050, 800);
	--結晶トカゲイベントリセット
	ResetTokage(proxy);
	
	--[[
	if proxy:IsClient() == false then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4096 , "OnEvent_4096_2",5.0,0,0,once);
		proxy:NotNetMessage_end();
	end
	]]
	print("OnEvent_4096 end");
end

--▲4096_1▲城内部扉開放:中ボス死亡後1秒▲
function OnEvent_4096_1(proxy, param)
	print("OnEvent_4096_1 begin");
	
	--ボスを倒した数を更新(数によってフラグを立てる)
	GetBossFlagCount( proxy, param );
	
	--▼トロフィー取得判定▼
	Lua_RequestUnlockTrophy(proxy, 27);
	
	--奴隷兵士の状態遷移チェック
	OnEvent_781(proxy,param)
	
	--▼(ソウル)アイテム取得用イベント監視追加▼
	if proxy:IsCompleteEvent( 4103 ) == false then
	
		--ソウル有効化
		proxy:SetDrawEnable( 1982 , true );
		proxy:SetColiEnable( 1982 , true );
		--ソウル2有効化
		proxy:SetDrawEnable( 1975 , true );
		proxy:SetColiEnable( 1975 , true );
	
		--SFX有効化
		proxy:ValidSfx( 1080 );--光の粒子
		proxy:ValidSfx( 1081 );--要石のオーラ
		
		proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);--光らせる
		proxy:OnDistanceActionAttribute( 4103 , LOCAL_PLAYER , 1982 , "OnEvent_4103" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );
	else
		--ソウル無効化(取ったら消えるので･･･)
		proxy:SetDrawEnable( 1982 , false );
		proxy:SetColiEnable( 1982 , false );
	end

	--取り合えずファランクス部屋のみ対応
	print("ボス部屋アタリ通常");
	--一時的に全OFF
	proxy:SetColiEnableArray(3010,true);--通常有効		
	proxy:SetColiEnableArray(3002,false);--ボス用無効
	proxy:SetColiEnableArray(3001,false);--ボス用無効
		
	print("OnEvent_4096_1 end");
end

--[[
--エリア解放の表示
function OnEvent_4096_2(proxy,param)
	print("OnEvent_4096_2 begin");
	--インフォ表示
	--システムメッセージ
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationBuffer( 10010740 );
	proxy:PlayTypeSE( LOCAL_PLAYER ,SOUND_TYPE_M ,777777777 );
	print("OnEvent_4096_2 end");
end
]]

--------------------------------------------------------------------------------------
--■4100■クライアントPCワープ演出■
--------------------------------------------------------------------------------------

--■4100■クライアントPCワープ演出■
function OnEvent_4100(proxy, param)
	print("OnEvent_4100 begin");

	if proxy:IsClient() == true then
		proxy:PlayAnimation( LOCAL_PLAYER , 8284 );--ワープアニメを再生
	end

	proxy:SetEventFlag( 4100 , 1 );
	
	print("OnEvent_4100 end");
end


--------------------------------------------------------------------------------------
--■4102■シングル：光の壁、BGM消去■
--------------------------------------------------------------------------------------

--■4102■シングル：光の壁、BGM消去■
function OnEvent_4102(proxy, param)
	print("OnEvent_4102 begin");
		
	--ボス戦用のBGM停止
	proxy:StopPointSE( 0 );
		
	proxy:SetEventFlag( 4102 , 1 );
	
	print("OnEvent_4102 end");
end

--PTを組んでいるかの監視
function Check_4096_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--PTじゃないなら
function OnEvent_4096_PT(proxy,param)
	print("OnEvent_4096_PT begin");
	--中ボス部屋の前後の魔法壁が消える(全プレイヤー)
	proxy:SetColiEnable( 1999 , false );
	proxy:SetColiEnable( 1995 , false );
	--proxy:SetObjDeactivate( 1999 , true );--デアクティブ
	--proxy:SetObjDeactivate( 1995 , true );--デアクティブ
	
	proxy:SetDrawEnable( 1999 , false );
	proxy:SetDrawEnable( 1995 , false );
	
	--中ボス部屋魔法壁のSFX削除
	proxy:InvalidSfx( 1987 , true );
	proxy:InvalidSfx( 1991 , true );
	
	--中ボス部屋前の移動処理イベントを削除
	proxy:DeleteEvent( 110 );--一人目が入るとき用
	proxy:DeleteEvent( 111 );--二人目以降が入るとき用
	proxy:DeleteEvent( 114 );--ボス戦闘開始用
	print("OnEvent_4096_PT end");
end


--------------------------------------------------------------------------------------
--城門塔右の扉開放■10
--------------------------------------------------------------------------------------
--■10■レバー対応扉（右）の開放■ActionButton判定
function OnEvent_10(proxy, param)
	print("OnEvent_10 begin");
	
	proxy:PlayAnimation(1005, 1);--レバーアニメ再生
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PULL_LEVER );

	proxy:NotNetMessage_begin();
		--▼10_2▼***条件追加***レバーアニメ終了▼
		proxy:OnObjAnimEnd( 10, 1005, 1, "OnEvent_10_2", once);
	proxy:NotNetMessage_end();
	
	if	param:IsNetMessage() == false then
		proxy:WarpDmy( LOCAL_PLAYER , 1005 , 191 );
	end
	
	proxy:SetEventFlag( 10 , true );

	print("OnEvent_10 end");
end


--▲10_2▲レバーアニメの終了▲
function OnEvent_10_2(proxy, param)
	print("OnEvent_10_2 begin");
	
	proxy:NotNetMessage_begin();
		--▼10_3▼***条件追加***1秒経過▼
		proxy:OnKeyTime2( 10, "OnEvent_10_3", 1.0, 0, 1, once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_10_2 end");
end

--▲10_3▲レバーアニメ終了から1秒経過▲
function OnEvent_10_3(proxy, param)
	print("OnEvent_10_3 begin");
	
	proxy:PlayAnimation(1003, 1);--扉アニメ再生
	
	--フラグを立てる(指示書に合わせるため)
	proxy:SetEventFlag( 11, true );
	print("OnEvent_10_3 end");
end
	


--------------------------------------------------------------------------------------
--レバー対応扉(左)■50
--------------------------------------------------------------------------------------
--■50■レバー対応扉（左）■
function OnEvent_50(proxy, param)
	print("OnEvent_50 begin");
	
	proxy:PlayAnimation(1006, 1);--レバーアニメ再生
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PULL_LEVER );

	proxy:NotNetMessage_begin();
		--▼50_2▼***条件追加***レバーアニメ終了▼
		proxy:OnObjAnimEnd( 50, 1006, 1, "OnEvent_50_2", once );
	proxy:NotNetMessage_end();
	
--	proxy:Warp(LOCAL_PLAYER, 2016);		--プレイヤーを所定位置にワープ
	--発動者のみワープ
	if	param:IsNetMessage() == false then
		proxy:WarpDmy( LOCAL_PLAYER , 1006 , 191 );
	end
	proxy:SetEventFlag( 50 , true );
--	proxy:DisableMove(LOCAL_PLAYER, true); --プレイヤーを操作不能に

	print("OnEvent_50 end");
end


--▲50_2▲レバーアニメ終了▲
function OnEvent_50_2(proxy, param)
	print("OnEvent_50_2 begin");
	
	proxy:NotNetMessage_begin();
		--▼50_3▼***条件追加***1秒経過▼
		proxy:OnKeyTime2( 50, "OnEvent_50_3", 1.0, 0, 1, once);
	proxy:NotNetMessage_end();

	print("OnEvent_50_2 end");
end


--▲50_3▲レバーアニメ終了から1秒後▲
function OnEvent_50_3(proxy, param)
	print("OnEvent_50_3 begin");
	
	proxy:PlayAnimation( 1004, 1 );--扉アニメ再生
	
	--フラグを立てる(指示書に合わせるため)
	proxy:SetEventFlag( 51 , true );
	
	print("OnEvent_50_3 end");
end


--グローバルにおく？
--------------------------------------------------------------------------------------
--□扉用の関数□  m04 のとはちょっとちがう。引数が一個多い。（player_anime_id)
--------------------------------------------------------------------------------------

--▽これを呼ぶ▽
function EventNormalDoor(proxy, param, event_id, door_id, door_anime_id, player_anime_id)
	print("OnEvent_"..event_id.." begin");
	
	proxy:PlayAnimation( door_id , door_anime_id );--扉のアニメーション

	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, player_anime_id ) == true then
		proxy:SetEventFlag( event_id , 1 );--開閉扉A(手前から開ける)への操作を無効にする。
		return;
	end

--	proxy:DisableMove(LOCAL_PLAYER,1);	 --キャラクタを移動、旋回不能に
	proxy:SetEventFlag( event_id , 1 );--開閉扉A(手前から開ける)への操作を無効にする。

	print("OnEvent_"..event_id.." end");
end



--------------------------------------------------------------------------------------
--石柱にワープ■70
--------------------------------------------------------------------------------------
--■70■石柱にワープ■
function OnEvent_70(proxy,param)	

	if proxy:IsCompleteEvent( 70 ) == true then
		return;
	end
	
	if param:IsNetMessage() == true then
		return;
	end
	
	
	print("OnEvent_70 begin");
	
	--セッション中ならば、要石のワープ無効
	if proxy:IsSession() == false then--セッション中ではない
		proxy:RepeatMessage_begin();
		--▼70_1▼選択メニューの監視▼
			proxy:OnSelectMenu(70, "OnEvent_70_0", 10010710, 0, 2, 1983, 2, once);			
		proxy:RepeatMessage_end();
	else--セッション中
		--エラー表示「セッション中は楔の神殿には戻れません」
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010720, 1);
		--proxy:ShowGenDialog(10010720,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end

	print("OnEvent_70 end");
end

--▲70_0▲選択メニューの監視▲
function OnEvent_70_0(proxy, param)
	print("OnEvent_70_0 begin");	
	
	if proxy:IsSession() == false then
		proxy:PlayAnimation( LOCAL_PLAYER , 8283 );--要石に触れるアニメを再生
		proxy:NoAnimeTurnCharactor( 10000 , 1983 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--▼要石に触れるアニメ再生終了▼
			proxy:OnChrAnimEnd( 70 , LOCAL_PLAYER , 8283 , "OnEvent_70_1" , once );
		proxy:NotNetMessage_end();

		proxy:SetEventFlag( 70 , true );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_70_0 end");
end

--▲70_1▲要石に触れるアニメ再生終了▲
function OnEvent_70_1(proxy, param)
	print("OnEvent_70_1 begin");
	
	proxy:SetEventFlag( 70 , false );
	
	proxy:PlayAnimation( LOCAL_PLAYER , 8284 );--自世界に帰るアニメを再生
	
	--[[
	proxy:NotNetMessage_begin();
		--▼自世界に帰るアニメ再生終了▼
		proxy:OnChrAnimEnd( 70 , LOCAL_PLAYER , 8284 , "OnEvent_70_2" , once );
	proxy:NotNetMessage_end();
	]]

	proxy:SetEventFlag( 70 , true );
	OnEvent_70_2(proxy,param);
	
	print("OnEvent_70_0 end");
end

--▲自世界に帰るアニメ再生終了▲
function OnEvent_70_2(proxy,param)	
	print("OnEvent_70_2 begin");

	--石柱へ戻ってきた判定のフラグを立てる
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag( 70 , false );
	
	--完全回復要求
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1006 );
	
	print("OnEvent_70_2 end");
end


--------------------------------------------------------------------------------------
--石柱にワープ(ボス倒した後用)■4105
--------------------------------------------------------------------------------------
--■4105■石柱にワープ■
function OnEvent_4105(proxy,param)	

	if proxy:IsCompleteEvent( 4105 ) == true then
		return;
	end	

	print("OnEvent_4105 begin");
	
	proxy:RepeatMessage_begin();
		--▼4105_1▼選択メニューの監視▼
		proxy:OnSelectMenu(4105, "OnEvent_4105_0", 10010710, 0, 2, 1982, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_4105 end");
end

--▲4105_0▲選択メニューの監視▲
function OnEvent_4105_0(proxy, param)
	print("OnEvent_4105_0 begin");	
	
	if proxy:IsSession() == false then
		proxy:PlayAnimation( LOCAL_PLAYER , 8283 );--要石に触れるアニメを再生
		proxy:NoAnimeTurnCharactor( 10000 , 1982 ,TURNSKIP_ANGLE);
		
		
		proxy:NotNetMessage_begin();
			--▼要石に触れるアニメ再生終了▼
			proxy:OnChrAnimEnd( 4105 , LOCAL_PLAYER , 8283 , "OnEvent_4105_1" , once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 4105 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_4105_0 end");
end

--▲4105_1▲自世界に帰るアニメ再生終了▲
function OnEvent_4105_1(proxy,param)	
	print("OnEvent_4105_1 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生
	--石柱へ戻ってきた判定のフラグを立てる
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag( 4105 , 0 );	
	--完全回復要求
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1006 );
	
	print("OnEvent_4105_1 end");
end


--------------------------------------------------------------------------------------
--■350■ＰＣが近づくとカラスが飛び立つ■
--------------------------------------------------------------------------------------
function FryAwayKarasu(proxy,param, KarasuEventID, karasuID, KarasuAnimID)	
	print("FryAwayKarasu_"..karasuID.." begin");
	
	proxy:PlayAnimation( karasuID , KarasuAnimID );
	
	proxy:NotNetMessage_begin();
		--▼カラスアニメ再生終了▼
		proxy:OnObjAnimEnd( KarasuEventID , karasuID , KarasuAnimID , "OnEvent_"..KarasuEventID.."_1" , once );	
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( KarasuEventID , true );

	print("FryAwayKarasu_"..karasuID.." end");
end

-----------------------------------------
--カラスアニメ再生終了したので消していく
-----------------------------------------
function OnEvent_350_1(proxy,param)	proxy:SetDrawEnable( 1090 , false ); print("KarasuFryAway ID=1090"); end
function OnEvent_351_1(proxy,param)	proxy:SetDrawEnable( 1091 , false ); print("KarasuFryAway ID=1091"); end
--function OnEvent_352_1(proxy,param)	proxy:SetDrawEnable( 1092 , false ); print("KarasuFryAway ID=1092"); end
function OnEvent_353_1(proxy,param)	proxy:SetDrawEnable( 1093 , false ); print("KarasuFryAway ID=1093"); end
function OnEvent_354_1(proxy,param)	proxy:SetDrawEnable( 1094 , false ); print("KarasuFryAway ID=1094"); end
function OnEvent_355_1(proxy,param)	proxy:SetDrawEnable( 1095 , false ); print("KarasuFryAway ID=1095"); end
function OnEvent_356_1(proxy,param)	proxy:SetDrawEnable( 1096 , false ); print("KarasuFryAway ID=1096"); end
function OnEvent_357_1(proxy,param)	proxy:SetDrawEnable( 1097 , false ); print("KarasuFryAway ID=1097"); end
function OnEvent_358_1(proxy,param)	proxy:SetDrawEnable( 1098 , false ); print("KarasuFryAway ID=1098"); end
function OnEvent_359_1(proxy,param)	proxy:SetDrawEnable( 1099 , false ); print("KarasuFryAway ID=1099"); end
function OnEvent_360_1(proxy,param)	proxy:SetDrawEnable( 1100 , false ); print("KarasuFryAway ID=1100"); end
function OnEvent_361_1(proxy,param)	proxy:SetDrawEnable( 1101 , false ); print("KarasuFryAway ID=1101"); end
function OnEvent_362_1(proxy,param)	proxy:SetDrawEnable( 1102 , false ); print("KarasuFryAway ID=1102"); end
function OnEvent_363_1(proxy,param)	proxy:SetDrawEnable( 1103 , false ); print("KarasuFryAway ID=1103"); end
function OnEvent_364_1(proxy,param)	proxy:SetDrawEnable( 1104 , false ); print("KarasuFryAway ID=1104"); end
function OnEvent_365_1(proxy,param)	proxy:SetDrawEnable( 1105 , false ); print("KarasuFryAway ID=1105"); end
function OnEvent_366_1(proxy,param)	proxy:SetDrawEnable( 1106 , false ); print("KarasuFryAway ID=1106"); end
function OnEvent_367_1(proxy,param)	proxy:SetDrawEnable( 1107 , false ); print("KarasuFryAway ID=1107"); end
function OnEvent_368_1(proxy,param)	proxy:SetDrawEnable( 1108 , false ); print("KarasuFryAway ID=1108"); end
function OnEvent_369_1(proxy,param)	proxy:SetDrawEnable( 1109 , false ); print("KarasuFryAway ID=1109"); end
function OnEvent_370_1(proxy,param)	proxy:SetDrawEnable( 1110 , false ); print("KarasuFryAway ID=1110"); end
function OnEvent_371_1(proxy,param)	proxy:SetDrawEnable( 1111 , false ); print("KarasuFryAway ID=1111"); end
function OnEvent_372_1(proxy,param)	proxy:SetDrawEnable( 1112 , false ); print("KarasuFryAway ID=1112"); end
function OnEvent_373_1(proxy,param)	proxy:SetDrawEnable( 1113 , false ); print("KarasuFryAway ID=1113"); end
function OnEvent_374_1(proxy,param)	proxy:SetDrawEnable( 1114 , false ); print("KarasuFryAway ID=1114"); end
function OnEvent_375_1(proxy,param)	proxy:SetDrawEnable( 1115 , false ); print("KarasuFryAway ID=1115"); end
	
---------------------------------
--カラスが飛び立つ関数を呼び出す
---------------------------------
function OnEvent_350(proxy, param) FryAwayKarasu(proxy, param, 350, 1090, 11); end
function OnEvent_351(proxy, param) FryAwayKarasu(proxy, param, 351, 1091, 10); end
--function OnEvent_352(proxy, param) FryAwayKarasu(proxy, param, 352, 1092, 12); end
function OnEvent_353(proxy, param) FryAwayKarasu(proxy, param, 353, 1093, 12); end
function OnEvent_354(proxy, param) FryAwayKarasu(proxy, param, 354, 1094, 12); end
function OnEvent_355(proxy, param) FryAwayKarasu(proxy, param, 355, 1095, 12); end
function OnEvent_356(proxy, param) FryAwayKarasu(proxy, param, 356, 1096, 12); end
function OnEvent_357(proxy, param) FryAwayKarasu(proxy, param, 357, 1097, 12); end
function OnEvent_358(proxy, param) FryAwayKarasu(proxy, param, 358, 1098, 12); end
function OnEvent_359(proxy, param) FryAwayKarasu(proxy, param, 359, 1099, 12); end
function OnEvent_360(proxy, param) FryAwayKarasu(proxy, param, 360, 1100, 12); end
function OnEvent_361(proxy, param) FryAwayKarasu(proxy, param, 361, 1101, 12); end
function OnEvent_362(proxy, param) FryAwayKarasu(proxy, param, 362, 1102, 12); end
function OnEvent_363(proxy, param) FryAwayKarasu(proxy, param, 363, 1103, 12); end
function OnEvent_364(proxy, param) FryAwayKarasu(proxy, param, 364, 1104, 12); end
function OnEvent_365(proxy, param) FryAwayKarasu(proxy, param, 365, 1105, 12); end
function OnEvent_366(proxy, param) FryAwayKarasu(proxy, param, 366, 1106, 12); end
function OnEvent_367(proxy, param) FryAwayKarasu(proxy, param, 367, 1107, 12); end
function OnEvent_368(proxy, param) FryAwayKarasu(proxy, param, 368, 1108, 12); end
function OnEvent_369(proxy, param) FryAwayKarasu(proxy, param, 369, 1109, 12); end
function OnEvent_370(proxy, param) FryAwayKarasu(proxy, param, 370, 1110, 12); end
function OnEvent_371(proxy, param) FryAwayKarasu(proxy, param, 371, 1111, 12); end
function OnEvent_372(proxy, param) FryAwayKarasu(proxy, param, 372, 1112, 12); end
function OnEvent_373(proxy, param) FryAwayKarasu(proxy, param, 373, 1113, 12); end
function OnEvent_374(proxy, param) FryAwayKarasu(proxy, param, 374, 1114, 12); end
function OnEvent_375(proxy, param) FryAwayKarasu(proxy, param, 375, 1115, 12); end

--[[
--------------------------------------------------------------------------------------
--薄板壁を壊して敵が飛び出してくる■90
--------------------------------------------------------------------------------------
--■90■薄板壁を壊して敵が飛び出してくる■
function OnEvent_90(proxy,param)	
	print("OnEvent_90 begin");
	
	proxy:SetDrawEnable( 202 , true );	
	proxy:SetColiEnable( 202 , true );

	proxy:PlayAnimation( 1120 , 1 );--扉アニメ再生
	
	proxy:NotNetMessage_begin();
		--▼90_1▼攻撃アニメの再生時間を調整▼
		proxy:OnKeyTime2( 90 , "OnEvent_90_1" , ( 72.0 / 30.0 ) , 0 , 3 , once );
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( 90 , 1 );
	
	print("OnEvent_90 end");
end


--▲90_1▲攻撃アニメの再生時間を調整▲
function OnEvent_90_1(proxy,param)	
	print("OnEvent_90_1 begin");	
	
	proxy:PlayAnimation( 202 , 7010 );--攻撃アニメ再生

	proxy:SetEventFlag( 90 , 0 );
	
	proxy:NotNetMessage_begin();
		--▼90_2▼攻撃アニメ終了後▼
		proxy:OnChrAnimEnd( 90 , 202, 7010, "OnEvent_90_2" , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 90 , 1 );
	
	print("OnEvent_90_1 end");
end


--▲90_2▲攻撃アニメ終了後▲
function OnEvent_90_2(proxy,param)	
	print("OnEvent_90_2 begin");	
	
	proxy:PlayLoopAnimation( 202 , 500 );--走りアニメ再生
	
	proxy:SetEventFlag( 90 , 0 );
	
	proxy:NotNetMessage_begin();
		--▼90_3▼走りアニメを数秒間再生後▼
		proxy:OnKeyTime2( 90 , "OnEvent_90_3" , 1.0 , 0, 1, once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 90 , 1 );
	
	print("OnEvent_90_2 end");
end

--▲90_3▲走りアニメ終了後▲
function OnEvent_90_3(proxy,param)	
	print("OnEvent_90_3 begin");	
	
	proxy:StopLoopAnimation( 202 );
	proxy:EnableLogic( 202 , true );
	
	print("OnEvent_90_3 end");
end
]]

--------------------------------------------------------------------------------------
--薄板壁を壊して敵が飛び出してくる2■91
--------------------------------------------------------------------------------------
--■91■薄板壁を壊して敵が飛び出してくる2■
function OnEvent_91(proxy,param)	
	print("OnEvent_91 begin");
	
	proxy:SetDrawEnable( 215 , true );
	proxy:SetDrawEnable( 216 , true );
	
	proxy:SetColiEnable( 216 , true );
	proxy:SetColiEnable( 215 , true );
	
	proxy:PlayAnimation( 1121 , 1 );--扉アニメ再生
	proxy:PlayAnimation( 1122 , 1 );--扉アニメ再生
	
	proxy:NotNetMessage_begin();
		--▼91_1▼攻撃アニメの再生時間を調整▼
		proxy:OnKeyTime2( 91 , "OnEvent_91_1_215" , ( 72.0 / 30.0 ) , 0 , 3 , once );
		proxy:OnKeyTime2( 91 , "OnEvent_91_1_216" , ( 72.0 / 30.0 ) , 0 , 4 , once );
	proxy:NotNetMessage_end();

	print("OnEvent_91 end");
end

--▲91_1_215▲攻撃アニメの再生時間を調整▲
function OnEvent_91_1_215(proxy,param)	
	print("OnEvent_91_1_215 begin");		
	proxy:PlayAnimation( 215 , 7010 );
	proxy:SetEventFlag( 91 , 0 );
	proxy:NotNetMessage_begin();
		--▼91_2▼攻撃アニメ終了後▼
		proxy:OnChrAnimEnd( 91 , 215, 7010, "OnEvent_91_2_215" , once );
		--proxy:OnKeyTime2(91,"OnEvent_91_2_215",2.0,0,0,once);
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 91 , 1 );
	print("OnEvent_91_1_215 end");
end

--▲91_1_216▲攻撃アニメの再生時間を調整▲
function OnEvent_91_1_216(proxy,param)	
	print("OnEvent_91_1_216 begin");		
	proxy:PlayAnimation( 216 , 7010 );	
	proxy:SetEventFlag( 91 , 0 );	
	proxy:NotNetMessage_begin();
		--▼91_2▼攻撃アニメ終了後▼
		proxy:OnChrAnimEnd( 91 , 216, 7010, "OnEvent_91_2_216" , once );		
	proxy:NotNetMessage_end();	
	proxy:SetEventFlag( 91 , 1 );	
	print("OnEvent_91_1_216 end");
end

--▲91_2_215▲攻撃アニメ終了後▲
function OnEvent_91_2_215(proxy,param)	
	print("OnEvent_91_2_215 begin");		
	proxy:PlayLoopAnimation( 215 , 500 );--走りアニメ再生	
	proxy:SetEventFlag( 91 , 0 );	
	proxy:NotNetMessage_begin();
		--▼91_3▼走りアニメを数秒間再生後▼
		proxy:OnKeyTime2( 91 , "OnEvent_91_3_215" , 1.0 , 0, 1, once );
	proxy:NotNetMessage_end();	
	proxy:SetEventFlag( 91 , 1 );	
	print("OnEvent_91_2_215 end");
end

--▲91_2_216▲攻撃アニメ終了後▲
function OnEvent_91_2_216(proxy,param)	
	print("OnEvent_91_2_216 begin");			
	proxy:PlayLoopAnimation( 216 , 500 );	
	proxy:SetEventFlag( 91 , 0 );	
	proxy:NotNetMessage_begin();
		--▼91_3▼走りアニメを数秒間再生後▼
		proxy:OnKeyTime2( 91 , "OnEvent_91_3_216" , 1.0 , 0, 10, once );
	proxy:NotNetMessage_end();	
	proxy:SetEventFlag( 91 , 1 );	
	print("OnEvent_91_2_216 end");
end

--▲91_3_215▲走りアニメ終了後▲
function OnEvent_91_3_215(proxy,param)	
	print("OnEvent_91_3_215 begin");	
	
	proxy:StopLoopAnimation( 215 );	
	proxy:SetSuperArmor( 215 , false );	
	proxy:EnableLogic( 215 , true );	
	
	print("OnEvent_91_3_215 end");
end

--▲91_3_216▲走りアニメ終了後▲
function OnEvent_91_3_216(proxy,param)	
	print("OnEvent_91_3_216 begin");	
	
	proxy:StopLoopAnimation( 216 );	
	proxy:SetSuperArmor( 216 , false );	
	proxy:EnableLogic( 216 , true );	
	
	print("OnEvent_91_3_216 end");
end


--------------------------------------------------------------------------------------
--一般兵士が落ちてくる■180
--------------------------------------------------------------------------------------
--■180_00■攻撃を受けたときのノックバック分歩かせ用(ID:211)■
function OnEvent_180_00(proxy,param)
	print("OnEvent_180_00 begin");
	
	proxy:PlayAnimation( 211 , 500 ) --移動アニメ再生
	
	proxy:NotNetMessage_begin();
		--▼180▼移動アニメの再生終了→敵が落ちてくるへ▼
		proxy:OnChrAnimEnd( 180 , 211 , 500 , "OnEvent_180" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_180_00 end");
end


--■180_01■攻撃を受けたときのノックバック分歩かせ用(ID:206)■
function OnEvent_180_01(proxy,param)
	print("OnEvent_180_01 begin");
	
	proxy:PlayAnimation( 206 , 500 ) --移動アニメ再生
	
	proxy:NotNetMessage_begin();
		--▼180▼移動アニメの再生終了→敵が落ちてくるへ▼
		proxy:OnChrAnimEnd( 180 , 206 , 500 , "OnEvent_180" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_180_01 end");
end




--■180■一般兵士が落ちてくる■
function OnEvent_180(proxy,param)
	print("OnEvent_180 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 180 ) == true then
		print("OnEvent_180 end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--▼一人目が落ちてくる▼
		proxy:OnKeyTime2( 180 , "OnEvent_180_211" , 0.0 , 0 , 1 , once );
		--▼二人目が落ちてくる▼
		proxy:OnKeyTime2( 180 , "OnEvent_180_206" , 1.0 , 0 , 2 , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 180 , 1 );
	
	print("OnEvent_180 end");
end




--■180_211■一般兵士が落ちてくる(一人目)■ID211
function OnEvent_180_211(proxy,param)
	print("OnEvent_180_211 begin");

	proxy:SetColiEnable( 211 , false );
	proxy:DisableMapHit( 211, true );
	proxy:SetDisableGravity( 211 , true );
	
	proxy:PlayAnimation( 211 , 7000 );

	proxy:SetEventFlag( 180 , 0 );
	proxy:NotNetMessage_begin();
		--▼180_1▼飛び降りアニメ再生終了▼
		proxy:OnKeyTime2( 180 , "OnEvent_180_211_1" , ( 23.0 / 30.0 ) , 0 , 3 , once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 180 , 1 );
	
	print("OnEvent_180_211 end");
end

--▲180_211_1▲飛び降りアニメ再生終了(一人目)▲ID211
function OnEvent_180_211_1(proxy,param)
	print("OnEvent_180_211_1 begin");
	
	proxy:DisableMapHit( 211, false );	
	proxy:SetDisableGravity( 211 , false );
	
	proxy:EnableLogic( 211 , true );
	proxy:SetColiEnable( 211 , true );	
	
	proxy:SetSuperArmor( 211 , false );
	
	proxy:DeleteEvent( 182 );--ダメージ監視消す
	
	print("OnEvent_180_211_1 end");
end




--■180_206■一般兵士が落ちてくる(二人目)■ID206
function OnEvent_180_206(proxy,param)
	print("OnEvent_180_206 begin");

	proxy:SetColiEnable( 206 , false );
	proxy:DisableMapHit( 206, true );
	proxy:SetDisableGravity( 206 , true );
	
	proxy:PlayAnimation( 206 , 7000 );

	proxy:SetEventFlag( 180 , 0 );
	proxy:NotNetMessage_begin();
		--▼180_1▼飛び降りアニメ再生終了▼
		proxy:OnKeyTime2( 180 , "OnEvent_180_206_1" , ( 23.0 / 30.0 ) , 0 , 4 , once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 180 , 1 );
	
	--フラグを立てる(指示書に合わせるため)
	proxy:SetEventFlag( 181 , 1 );
	
	print("OnEvent_180_206 end");
end

--▲180_206_1▲飛び降りアニメ再生終了(二人目)▲ID206
function OnEvent_180_206_1(proxy,param)
	print("OnEvent_180_206_1 begin");
	
	proxy:DisableMapHit( 206, false );	
	proxy:SetDisableGravity( 206 , false );
	
	proxy:EnableLogic( 206 , true );
	proxy:SetColiEnable( 206 , true );	
	proxy:SetSuperArmor( 206 , false );
	
	proxy:DeleteEvent( 183 );--ダメージ監視消す
	proxy:DeleteEvent( 180 );--領域監視も消す
	
	print("OnEvent_180_206_1 end");
end


--------------------------------------------------------------------------------------
--徘徊デーモンの登場■??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ)
function PlayerDeath_m02_00_00_00(proxy, param)
	print("PlayerDeath_m02_00_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m02_00_00_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。
	
	print("PlayerDeath_m02_00_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ)
function PlayerRevive_m02_00_00_00(proxy,param)
	print("PlayerRevive_m02_00_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m02_00_00_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。
	
	print("PlayerRevive_m02_00_00_00");
end






--------------------------------------------------------------------------------------
--ボス部屋の中に入る■110
--------------------------------------------------------------------------------------

--■イベントがループなので、全部リピートにする↓

--■110■中ボス部屋への扉が開く■
function OnEvent_110(proxy,param)
	print("OnEvent_110 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_110 end");
		return;
	end
	--クライアントへ、ボス部屋阻止失敗を通知
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	--自分自身がファランクスを準備
	if param:IsNetMessage() == false then
		PhalanxStandBy(proxy,param);
	end
	
	proxy:LuaCallStart( 111, 1 );--旋回アニメの同期再生
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--多重起動システムIDをタイムアウトを設定してONにする
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_110 end");
end


--旋回アニメの同期再生(IDが別)
function OnEvent_111_1(proxy,param)
	print("OnEvent_111_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を行い、その終了時にOnEvent_111_2を発行する
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2891 );
		else
			proxy:LockSession();--ルームをロックします！
			--旋回アニメ再生を行い、その終了時にOnEvent_111_2を発行する
			proxy:OnTurnCharactorEnd( 111, LOCAL_PLAYER, 2891, "OnEvent_111_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_111_1 end");
end

--旋回アニメの同期再生終了後
function OnEvent_111_2(proxy,param)
	print("OnEvent_111_2 begin");

	--同期用歩きアニメ再生
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 111, LOCAL_PLAYER, ANIMEID_WALK, "OnEvent_111_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_111_2 end");
end

--歩きアニメの同期再生終了後
function OnEvent_111_3(proxy,param)
	print("OnEvent_111_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ
	if proxy:IsCompleteEvent( 110 ) == false then
		proxy:LuaCallStart( 111 , 5 );--2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知
		proxy:LuaCallStart( 111 , 6 );--フラグセット(同期用)
		local eneidlist = {800,
		860,861,862,863,864,865,866,867,868,869,
		870,871,872,873,874,875,876,877,878,879,
		880,881,882,883,884,885,886,887,888,889,
		890,891,892,893,894,895,896,897};
		
		local num = table.getn(eneidlist);
		for index = 1, num , 1 do
			Lua_MultiDoping(proxy,eneidlist[index]);--マルチプレイドーピング
		end		
	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない)
	if proxy:IsClient() == false then
		proxy:ResetThink( 800 );
	end	
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );

	print("OnEvent_111_3 end");
end


--■110 2回目以降にボス部屋に入るためのイベント配信用
function OnEvent_110_GO_TO_IN(proxy, param)
	print("OnEvent_110_GO_TO_IN begin");

	proxy:NotNetMessage_begin();
		--▼111▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_110
		proxy:OnPlayerActionInRegion( 111, 2895, "OnEvent_110", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	

	print("OnEvent_110_GO_TO_IN end");
end


--■110 フラグセット(同期用)
function OnEvent_110_flag_set(proxy, param)
	print("OnEvent_110_flag_set begin");
		
	proxy:SetEventFlag( 110 , 1 );
	proxy:DeleteEvent( 110 ); 

	print("OnEvent_110_flag_set end");
end



--------------------------------------------------------------------------------------
--ボスが動き出す(戦闘開始)■114
--------------------------------------------------------------------------------------

function OnEvent_114(proxy, param)
	print("OnEvent_114 begin");
	
	--ボス戦用BGM再生開始
	proxy:PlayPointSE( 2160, SOUND_TYPE_M, 20000000, 0 );
	
	--ファランクスの動作開始
	PhalanxEventStart(proxy,param); 
	
	--読み込みタイミングのとき毎回追加されてほしいのでフラグたてない
	
	--ボスゲージをセット
	proxy:SetBossGauge(800,0,5001);	
	
	--強制更新を配信
	proxy:LuaCallStart( 114 , 10 );
	print("OnEvent_114 end");
end

--ボス部屋に入ったPCの為に強制更新を配信
function OnEvent_114_1(proxy,param)
	print("OnEvent_114_1 begin");
	if param:IsNetMessage() == true then
		--LuaFunc_ForceOmission(proxy,10001+param:GetPlayID());
		proxy:SetAlwaysDrawForEvent(10001+param:GetPlayID(),true);
	else
		--LuaFunc_ForceOmission(proxy,10000);
	end
	print("OnEvent_114_1 end");
end


--------------------------------------------------------------------------------------
--■200■処刑場への扉■
--------------------------------------------------------------------------------------
--[[
--■200_1■処刑場への扉■LuaCall定義
function OnEvent_200_1(proxy, param)
	print("OnEvent_200_1 begin");

	proxy:PlayAnimation( 1040, 1 );--扉が開くアニメーション
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 200, 1 );
		proxy:DeleteEvent( 200 );--パーティープレイヤーの監視削除
		print("OnEvent_200_1 end");
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1040 , 191 );
	proxy:SetEventFlag( 200, 1 );
	proxy:DeleteEvent( 200 );--自分の監視削除

	print("OnEvent_200_1 end");
end


--■200■処刑場への扉■
function OnEvent_200(proxy, param)
	print("OnEvent_200 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 200 ) == true then
		print("OnEvent_200 end");
		return;
	end
	
	--QWC条件は満たしているか？
	if	proxy:IsCompleteEvent( 201 ) == true then
		proxy:LuaCallStart( 200 , 1 );--アニメーションの同期再生(全体に配信)	

	--必要アイテムを所持していない
	else
		--扉が開かない場合のメッセージを表示
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1040, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_200 end");
end
]]


--------------------------------------------------------------------------------------
--■210■霊廟への扉■
--------------------------------------------------------------------------------------

--■210_1■霊廟への扉■LuaCall定義
function OnEvent_210_1(proxy, param)
	print("OnEvent_210_1 begin");

	proxy:PlayAnimation( 1045, 1 );--扉が開くアニメーション
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 210 , 1 );
		proxy:DeleteEvent( 210 );
		print("OnEvent_210_1 end");
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1045 , 191 );
	proxy:SetEventFlag( 210, 1 );

	print("OnEvent_210_1 end");
end


--■210■霊廟への扉■
function OnEvent_210(proxy, param)
	print("OnEvent_210 begin");
	
	--多重発動防止
	if proxy:IsCompleteEvent( 210 ) == true then
		print("OnEvent_210 end");
		return;
	end
	
	--必要アイテムの指定
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 35;--霊廟の鍵
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼210_3▼選択メニューの監視▼
			--proxy:OnSelectMenu(210, "OnEvent_210_3", 10010829, 0, 1, 1045, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010829, 0, 6, 1045, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_210_3(proxy,param);

	--必要アイテムを所持していない
	else
		--扉が開かない場合のメッセージを表示
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1045, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_210 end");
end


--▲210_3▲選択メニューの監視▲(YESを選択したとき)
function OnEvent_210_3(proxy,param)
	print("OnEvent_210_3 begin");
	proxy:LuaCallStart( 210 , 1 );--アニメーションの同期再生(全体に配信)	
	proxy:DeleteEvent( 210 );	
	print("OnEvent_210_3 end");
end
	

--------------------------------------------------------------------------------------
--■211■霊廟への扉■
--------------------------------------------------------------------------------------

--■211_1■霊廟への扉■LuaCall定義
function OnEvent_211_1(proxy, param)
	print("OnEvent_211_1 begin");

	proxy:PlayAnimation( 1047, 1 );--扉が開くアニメーション
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 211, 1 );		
		proxy:DeleteEvent( 211 );
		print("OnEvent_211_1 end");
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1047 , 191 );
	proxy:SetEventFlag( 211, 1 );

	print("OnEvent_211_1 end");
end


--■211■霊廟への扉2■
function OnEvent_211(proxy, param)
	print("OnEvent_211 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 211 ) == true then
		print("OnEvent_211 end");
		return;
	end
	
	--必要アイテムの指定
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 35;--霊廟の鍵
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼211_3▼選択メニューの監視▼
			--proxy:OnSelectMenu(211, "OnEvent_211_3", 10010829, 0, 2, 1047, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010829, 0, 6, 1047, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_211_3(proxy,param);

	--必要アイテムを所持していない
	else
		--扉が開かない場合のメッセージを表示
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1047, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_211 end");
end


--▲211_3▲選択メニューの監視▲(YESを選択したとき)
function OnEvent_211_3(proxy,param)
	print("OnEvent_211_3 begin");
	proxy:LuaCallStart( 211 , 1 );--アニメーションの同期再生(全体に配信)	
	proxy:DeleteEvent( 211 );
	print("OnEvent_211_3 end");
end


--------------------------------------------------------------------------------------
--■5■霊廟の祭壇■
--------------------------------------------------------------------------------------

function OnEvent_5(proxy, param)
	if param:IsNetMessage() == false then
	print("OnEvent_5 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:PlayAnimation( 10000 , 8290);		
		proxy:PlayAnimation( 1192 , 1);	
		proxy:OnKeyTime2( 5 , "OnEvent_5_0",0.01,0,0,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();	
	print("OnEvent_5 end");
	end
end

function OnEvent_5_0(proxy,param)
	print("OnEvent_5_0 begin");
	--if proxy:IsPlayerStay(10000) == true then
	if proxy:IsEventAnim( 10000 , 8290 ) == true then
		proxy:LuaCallStart( 5 , 2 );
	else
		proxy:ForcePlayAnimation( 1192 , 0);	
	end
	print("OnEvent_5_0 end");
end

--■5_1■アイテム取得■
function OnEvent_5_1(proxy, param)
	print("OnEvent_5_1 begin");

	--アイテム取得関数--パラメータ10104参照
	proxy:GetRateItem(10104);	
	
	--アイテムを取得済み
	proxy:SetEventFlag( 5, 1 );
	
	--OBJを消すためのイベント配信
	proxy:LuaCallStart( 5, 1);
	
	print("OnEvent_5_1 end");
end

--■5_2■剣OBJ非表示用■
function OnEvent_5_2(proxy,param)
	print("OnEvent_5_2 begin");
	--オブジェが消える
	proxy:SetDrawEnable( 1192 , false );--ひとまず描画だけOFF
	proxy:SetColiEnable( 1192 , false );--当たりはあるのは不明(現状ではないようなので消さない)	
	
	--イベント消える
	proxy:DeleteEvent( 5 );
	print("OnEvent_5_2 end");
end

--アニメ再生の同期＆監視
function OnEvent_5_3(proxy,param)
	print("OnEvent_5_3 begin");
	
	proxy:TreasureDispModeChange2( 1192, false ,KEN_SFX);
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8290 ) == true then--新しいアニメ 
		proxy:PlayAnimation( 1192 , 1);	
		print("OnEvent_5 end");
		return true;
	end
	
	--剣にワープ
	proxy:WarpDmy( LOCAL_PLAYER , 1192 , 191 );		
	
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 5 , LOCAL_PLAYER , 8290 , "OnEvent_5_1", once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_5_3 end");
end



--------------------------------------------------------------------------------------
--■220■飛竜(長)が寝ている■
--------------------------------------------------------------------------------------

TYOU_STATE_WAIT = 0;
TYOU_STATE_ATACK = 1;
TYOU_STATE_ATACK_DILAY = 2;

tyou_state_in_home = TYOU_STATE_WAIT;

function OnEvent_220(proxy, param)
--	print("OnEvent_220 begin");

	--待機状態(攻撃可能)
	if tyou_state_in_home == TYOU_STATE_WAIT then
			
		tyou_state_in_home = TYOU_STATE_ATACK;--攻撃状態へ
		
		proxy:StopLoopAnimation( 300 );--待機アニメとめる
		proxy:PlayAnimation( 300 , 3001 );--攻撃アニメ再生開始
		proxy:SetEventFlag( 220 , 0 );
		proxy:NotNetMessage_begin();
			--▼220▼攻撃アニメの終了▼
			proxy:OnChrAnimEnd( 220 , 300 , 3001 , "OnEvent_220_atack_end" , once );
		proxy:NotNetMessage_end();
		proxy:SetEventFlag( 220 , 1 );
	
	--攻撃中
	elseif tyou_state_in_home == TYOU_STATE_ATACK then
			
	--再攻撃待ち
	elseif tyou_state_in_home == TYOU_STATE_ATACK_DILAY then
	
	end
	
--	print("OnEvent_220 end");
end

--▲220▲攻撃アニメの終了▲
function OnEvent_220_atack_end(proxy ,param)
	print("OnEvent_220_atack_end begin");
	
	--攻撃終わったので、再攻撃待ち状態へ
	tyou_state_in_home = TYOU_STATE_ATACK_DILAY;
	
	proxy:SetEventFlag( 220 , 0 );
	proxy:NotNetMessage_begin();
		--▼220_dilay_end▼再攻撃待機▼
		local dilay_time = 3.0;--3秒
		proxy:OnKeyTime2( 220 , "OnEvent_220_atack_dilay_end" , dilay_time , 0 , 1 , once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 220 , 1 );
	
	proxy:PlayLoopAnimation( 300, 7000 );--待機アニメループ再生
	
	print("OnEvent_220_atack_end end");
end


--▲220▲攻撃アニメの終了▲
function OnEvent_220_atack_dilay_end(proxy ,param)
	print("OnEvent_220_atack_dilay_end begin");
	
	--攻撃まち状態おわったので、再攻撃可能→待機状態へ
	tyou_state_in_home = TYOU_STATE_WAIT;
		
	print("OnEvent_220_atack_dilay_end end");
end



--------------------------------------------------------------------------------------
--■221■飛竜(眷属)が警戒している■
--------------------------------------------------------------------------------------

KENZOKU_STATE_WAIT = 0;--待機状態
KENZOKU_STATE_ATACK = 1;--攻撃状態(範囲内にいるとき)
KENZOKU_STATE_ATACK_DILAY = 2;--攻撃のあとの待機は 攻撃待ち状態

kenzoku_state_in_home = KENZOKU_STATE_WAIT;--最初はとりあえず待機
--これも同期するとしたら、フラグ3個つかって初期化時に再現?

--待機→攻撃になるときに、3秒だと、アニメの途中から再生になるので、1回分後
--とかのほうが良いかもしれない?
kenzoku_play_anime_id = 0;
function OnEvent_199(proxy,param)
	print("OnEvent_199 begin");

	--巣にいる状態時に諦めに切り替え
	if	proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true and
		proxy:IsCompleteEvent( 0 ) == true then
		SetNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_WARNING_AND_LEVER );
	end
	
	--巣を警戒中　or　巣を警戒中(レバー阻止あきらめ)　の場合で撤退フラグON
	if	   (proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true   or
			proxy:IsCompleteEvent( KENZOKU_STATE_WARNING_AND_LEVER ) == true ) and
			proxy:IsCompleteEvent( 234 ) == true then
		print("OnEvent_199 -> OnEvent_234_1");
		--→OnEvent_234_1
		proxy:LuaCallStart( 234, 2 );
	
	--■230■イベント条件
	elseif	proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true and
			proxy:IsCompleteEvent( 222 ) == true then
		print("OnEvent_199 -> OnEvent_230_1");
		--→OnEvent_230_1
		proxy:LuaCallStart( 230, 1 );
	--■221■イベント条件
	elseif	(proxy:IsCompleteEvent( KENZOKU_STATE_WARNING_AND_LEVER ) == true or
		 proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true ) and
		proxy:IsCompleteEvent( 222 ) == false and
		proxy:IsCompleteEvent( 223 ) == true then
		print("OnEvent_199 -> OnEvent_221_1");
		--→OnEvent_221_1
		proxy:LuaCallStart( 221, 1 );
		
	--■190■イベント条件
	elseif (proxy:IsCompleteEvent( KENZOKU_STATE_WARNING_AND_LEVER ) == true or
			proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true ) and
			proxy:IsCompleteEvent( 222 ) == false and
			proxy:IsCompleteEvent( 223 ) == false and
			proxy:IsCompleteEvent( 224 ) == true then
		print("OnEvent_199 -> OnEvent_190_1");
		--→OnEvent_190_1
		proxy:LuaCallStart( 190, 1 );
		
	--■191■イベント条件
	elseif (proxy:IsCompleteEvent( KENZOKU_STATE_WARNING_AND_LEVER ) == true or
			proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true ) and
			proxy:IsCompleteEvent( 222 ) == false and
			proxy:IsCompleteEvent( 223 ) == false and
			proxy:IsCompleteEvent( 224 ) == false and
			proxy:IsCompleteEvent( 225 ) == true then
		print("OnEvent_199 -> OnEvent_191_1");
		--→OnEvent_191_1
		proxy:LuaCallStart( 191, 1 );
		
		
	--巣から城壁へ飛んでくる流れ
	--■231■イベント条件
	elseif	proxy:IsCompleteEvent( KENZOKU_STATE_PROTECT_CASTLE ) == true and
			proxy:IsCompleteEvent( 222 ) == true and
			proxy:IsCompleteEvent( 0 )   == false and
			proxy:IsCompleteEvent( 234 ) == false then
		if	kenzoku_play_anime_id == 7001 or
			kenzoku_play_anime_id == 7002 or
			kenzoku_play_anime_id == 7005 then
			print("OnEvent_199 -> OnEvent_231_1");
			--→OnEvent_231_1
			proxy:LuaCallStart( 231, 1 );
		elseif	kenzoku_play_anime_id == 7004 then
			print("OnEvent_199 -> OnEvent_231_2");
			--→OnEvent_231_2
			proxy:LuaCallStart( 231, 2 );
		else
			print("OnEvent_199 -> 231 Failed");
			print("animId = ", kenzoku_play_anime_id);
		end
		
	--ブレスループから撤退への流れ
	--■232■イベント条件
	--■233■イベント条件
	--領域に誰もいない or レバーが引かれた or 自分が死にそう
	elseif	(proxy:IsCompleteEvent( KENZOKU_STATE_PROTECT_CASTLE ) == true and
			 proxy:IsCompleteEvent( 222 ) == false ) or
			(proxy:IsCompleteEvent( KENZOKU_STATE_PROTECT_CASTLE ) == true and
			proxy:IsCompleteEvent( 0 ) == true ) or
			(proxy:IsCompleteEvent( KENZOKU_STATE_PROTECT_CASTLE ) == true and
			proxy:IsCompleteEvent( 234 ) == true ) then
			
		--通常の巣に戻るか
		if	proxy:IsCompleteEvent( 0 ) == true then
			SetNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_WARNING_AND_LEVER );
		else
			SetNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_WARNING );
		end
		
		if	kenzoku_play_anime_id == 7002 or
			kenzoku_play_anime_id == 7004 or
			kenzoku_play_anime_id == 7005 then
			print("OnEvent_199 -> OnEvent_232_1");
			--→OnEvent_232_1
			proxy:LuaCallStart( 232, 1 );
		elseif	kenzoku_play_anime_id == 7003 then
			print("OnEvent_199 -> OnEvent_232_2");
			--→OnEvent_232_2
			proxy:LuaCallStart( 232, 2 );
		else
			print("OnEvent_199 -> 232 Failed");
			print("animId = ", kenzoku_play_anime_id);
		end
		
	--■199■デフォルト待機アニメループ
	else
			print("OnEvent_199 -> OnEvent_199_default");
		--→OnEvent_199_default
		proxy:LuaCallStart( 199, 1 );
	end
	print("OnEvent_199 end");
end


--飛竜アニメ終了の節に必ず通るイベント
function OnEvent_199_anim_end(proxy,param)
	print("OnEvent_199_anim_end begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 199, "OnEvent_199", 0.0, 0, 2, once );
	proxy:NotNetMessage_end();
	print("OnEvent_199_anim_end end");
end


function OnEvent_199_default(proxy,param)
	print("OnEvent_199_default begin");
	
	kenzoku_play_anime_id = 0;
	proxy:ForcePlayAnimation( 301, 0 );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_199_default return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 199, 301, 0, "OnEvent_199_anim_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_199_default end");
end


--------------------------------------------------------------------------------------
--■221■飛竜(眷属)が暴れる１→待ち１～３秒■
--------------------------------------------------------------------------------------
function OnEvent_221_1(proxy, param)
	print("OnEvent_221_1 begin");

	kenzoku_play_anime_id = 3001;
	proxy:ForcePlayAnimationStayCancel( 301, 3001 );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_221_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		--▼221▼攻撃アニメの終了▼
		proxy:OnChrAnimEnd( 221 , 301 , 3001 , "OnEvent_221_1_1" , once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_221_1 end");
end

function OnEvent_221_1_1(proxy,param)
	--→OnEvent_221_2
	proxy:LuaCallStart( 221, 2 );
end


--▲221▲攻撃アニメの終了▲
function OnEvent_221_2(proxy ,param)
	print("OnEvent_221_2 begin");
	
	kenzoku_play_anime_id = 0;
	proxy:ForcePlayLoopAnimation( 301, 0 );--待機アニメループ再生
	
	if	param:IsNetMessage() == true then
		print("OnEvent_221_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--▼221_dilay_end▼再攻撃待機▼
		local dilay_time = proxy:GetRandom( 10, 30 ) / 10;--1秒～3秒
		proxy:OnKeyTime2( 221 , "OnEvent_199_anim_end" , dilay_time , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_221_2 end");
end

--------------------------------------------------------------------------------------
--■190■飛竜(眷属)が暴れる２→待ち１～３秒■
--------------------------------------------------------------------------------------
function OnEvent_190_1(proxy,param)
	print("OnEvent_190_1 begin");
	kenzoku_play_anime_id = 3003;
	proxy:ForcePlayAnimation( 301, 3003 );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_190_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		--▼221▼攻撃アニメの終了▼
		proxy:OnChrAnimEnd( 221 , 301 , 3003 , "OnEvent_190_1_1" , once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_190_1 end");
end

function OnEvent_190_1_1(proxy,param)
	print("OnEvent_190_1_1 begin");
	--→OnEvent_190_2
	proxy:LuaCallStart( 190, 2 );
	print("OnEvent_190_1_1 end");
end


function OnEvent_190_2(proxy,param)
	print("OnEvent_190_2 begin");
	
	kenzoku_play_anime_id = 0;
	proxy:ForcePlayLoopAnimation( 301, 0 );--待機アニメループ再生
	
	if	param:IsNetMessage() == true then
		print("OnEvent_190_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		local dilay_time = proxy:GetRandom( 10, 30 ) / 10;--1秒～3秒
		proxy:OnKeyTime2( 190 , "OnEvent_199_anim_end" , dilay_time , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_190_2 end")
end



--------------------------------------------------------------------------------------
--■191■飛竜(眷属)が暴れる３→待ち１～３秒■
--------------------------------------------------------------------------------------
function OnEvent_191_1(proxy,param)
	print("OnEvent_191_1 begin");
	kenzoku_play_anime_id = 3002;
	proxy:ForcePlayAnimation( 301, 3002 );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_191_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		--▼221▼攻撃アニメの終了▼
		proxy:OnChrAnimEnd( 221 , 301 , 3002 , "OnEvent_191_1_1" , once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_191_1 end");
end

function OnEvent_191_1_1(proxy,param)
	print("OnEvent_191_1_1 begin");
	--→OnEvent_191_2
	proxy:LuaCallStart( 191, 2 );
	print("OnEvent_191_1_1 end");
end

function OnEvent_191_2(proxy,param)
	print("OnEvent_191_2 begin");
	
	kenzoku_play_anime_id = 0;
	proxy:ForcePlayLoopAnimation( 301, 0 );--待機アニメループ再生
	
	if	param:IsNetMessage() == true then
		print("OnEvent_191_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		local dilay_time = proxy:GetRandom( 10, 30 ) / 10;--1秒～3秒
		proxy:OnKeyTime2( 191 , "OnEvent_199_anim_end" , dilay_time , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_191_2 end")
end


--------------------------------------------------------------------------------------
--■230■飛竜(眷属)が飛んでくる→ブレス吐く■
--------------------------------------------------------------------------------------

function OnEvent_230_1(proxy, param)
	print("OnEvent_230_1 begin");

	--位置・角度を合わせるためにワープ
	proxy:Warp(301,2030);

	--飛竜(眷属)が飛立つアニメ
	kenzoku_play_anime_id = 7000;
	proxy:ForcePlayAnimationStayCancel( 301 , 7000 );
	
	--飛竜(眷属)の状態を城壁護るにセット
	SetNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_PROTECT_CASTLE );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_230_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		--▼230_1▼飛竜(眷属)が飛立つアニメ再生終了▼
		proxy:OnChrAnimEnd( 230 , 301, 7000, "OnEvent_230_1_1" , once);
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_230_1 end");
end

function OnEvent_230_1_1(proxy,param)
	print("OnEvent_230_1_1 begin");
	--→OnEvent_230_2
	proxy:LuaCallStart( 230, 2 );
	print("OnEvent_230_1_1 end");
end


--▲230_2▲飛竜(眷属)が飛立つアニメ再生終了▲
function OnEvent_230_2(proxy , param )
	print("OnEvent_230_2 begin");
	
	--位置・角度を合わせるためにワープ
	proxy:Warp(301,2031);
	
    --飛竜(眷属)が飛んでくるアニメ
	kenzoku_play_anime_id = 7002;
	proxy:ForcePlayAnimationStayCancel( 301 , 7002 );

	if	param:IsNetMessage() == true then
		print("OnEvent_230_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--▼231▼飛竜(眷属)が飛んでくるアニメ再生終了▼
		proxy:OnChrAnimEnd( 230 , 301 , 7002 , "OnEvent_199_anim_end" , once );
	proxy:NotNetMessage_end();
	

	print("OnEvent_230_2 end");
end


--------------------------------------------------------------------------------------
--■231■飛竜(眷属)がブレス吐く1→ブレス吐く2ループ■
--------------------------------------------------------------------------------------
--▲231▲飛竜(眷属)が飛んでくるアニメ再生終了▲
function OnEvent_231_1(proxy , param )
	print("OnEvent_231_1 begin");
	
	--位置・角度を合わせるためにワープ
	proxy:Warp(301,2032);

	--飛びながらブレス攻撃アニメ1
	kenzoku_play_anime_id = 7004;
	proxy:ForcePlayAnimationStayCancel( 301 , 7004 );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_231_1 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--▼231_1▼飛びながらブレス攻撃アニメ1終了▼
		proxy:OnChrAnimEnd( 231 , 301 , 7004 , "OnEvent_231_1_1" , once );
	proxy:NotNetMessage_end();


	print("OnEvent_231_1 end");
end


function OnEvent_231_1_1(proxy,param)
	print("OnEvent_231_1_1 begin");
	--→OnEvent_231_2
	proxy:LuaCallStart( 231, 2 );
	print("OnEvent_231_1_1 end");
end


--▲231_1▲飛びながらブレス攻撃アニメ1終了▲
function OnEvent_231_2(proxy , param )
	print("OnEvent_231_2 begin");

	--位置・角度を合わせるためにワープ
	proxy:Warp(301,2032);
	
	--飛びながらブレス攻撃アニメ2
	kenzoku_play_anime_id = 7005;
	proxy:ForcePlayAnimationStayCancel( 301 , 7005 );

	
	if	param:IsNetMessage() == true then
		print("OnEvent_231_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--▼231_2▼飛びながらブレス攻撃アニメ2終了▼
		proxy:OnChrAnimEnd( 231 , 301 , 7005 , "OnEvent_199_anim_end" , once );
	proxy:NotNetMessage_end();

	print("OnEvent_231_2 end");
end



--------------------------------------------------------------------------------------
--■232■飛竜(眷属)が帰っていく■
--------------------------------------------------------------------------------------

function OnEvent_232_1(proxy, param)
	print("OnEvent_232_1 begin");

	--位置・角度を合わせるためにワープ
	proxy:Warp(301,2034);
	
	--飛びながらブレス攻撃アニメ2
	kenzoku_play_anime_id = 7003;
	proxy:ForcePlayAnimationStayCancel( 301 , 7003 );

	if	param:IsNetMessage() == true then
		print("OnEvent_232_1 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--▼232_1▼飛竜(眷属)が去っていくアニメ終了▼
		proxy:OnChrAnimEnd( 232 , 301 , 7003 , "OnEvent_232_1_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_232_1 end");
end

function OnEvent_232_1_1(proxy,param)
	print("OnEvent_232_1_1 begin");
	--→OnEvent_232_2
	proxy:LuaCallStart( 232, 2 );
	print("OnEvent_232_1_1 end");
end

--▲232_1▲飛竜(眷属)が去っていくアニメ終了▲
function OnEvent_232_2(proxy, param)
	print("OnEvent_232_2 begin");

	--位置・角度を合わせるためにワープ
	proxy:Warp(301,2035);
	
	--飛びながらブレス攻撃アニメ2
	kenzoku_play_anime_id = 7001;
	proxy:ForcePlayAnimation( 301 , 7001 );

	if	param:IsNetMessage() == true then
		print("OnEvent_232_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--▼232_2▼飛竜(眷属)が寝床に戻るアニメ終了▼
		proxy:OnChrAnimEnd( 232 , 301 , 7001 , "OnEvent_232_3" , once );
		--proxy:OnChrAnimEnd( 232 , 301 , 7001 , "OnEvent_199_anim_end" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_232_2 end");
end

function OnEvent_232_3(proxy,param)
	print("OnEvent_232_3 begin");
	
	--位置・角度を合わせるためにワープ
	proxy:Warp( 301,2036);
	OnEvent_199_anim_end(proxy,param);
	
	print("OnEvent_232_3 end");
end

--------------------------------------------------------------------------------------
--■234■飛竜(眷属)の死亡監視■
--------------------------------------------------------------------------------------

function OnEvent_234(proxy , param)
	print( "OnEvent_234 begin" );
	
	--撤退したフラグを立てる
	proxy:SetEventFlag( 234, true );
	
--[[	
	--飛竜(眷属)の状態を死亡にする
	--SetNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_DEAD );
	
	--飛竜(眷属)関連イベント削除
	proxy:DeleteEvent( 221 );--巣で警戒している
	proxy:DeleteEvent( 230 );--城壁に飛んでくる
	
	proxy:OnKeyTime2( 234, "OnEvent_234_1", 0.0, 0, 2, once );

	--ホストのみアイテム入手
	if	proxy:IsClient() == false then
		proxy:GetRateItem( 10118 );--アイテム入手
	end
]]	
	print( "OnEvent_234 end" );
end

--LuaCallParam(234,2)
function OnEvent_234_1(proxy,param)
	print("OnEvent_234_1 begin");
	
	--位置・角度を合わせるためにワープ
	proxy:Warp(301,2030);
	
	--飛びながらブレス攻撃アニメ2
	kenzoku_play_anime_id = 7011;
	proxy:ForcePlayAnimation( 301 , 7011 );

	--ここは全員登録する
	proxy:NotNetMessage_begin();
		--▼232_1▼飛竜(眷属)が去っていくアニメ終了▼
		proxy:OnChrAnimEnd( 199 , 301 , 7011 , "OnEvent_234_1_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_234_1 end");
end

--撤退アニメ終了で無効化
function OnEvent_234_1_1(proxy,param)
	print("OnEvent_234_1_1 begin");
	SetNpcStateFlag(proxy, param, kenzoku_flag_list, KENZOKU_STATE_ESCAPE );
	InvalidCharactor( proxy, 301 );
	print("OnEvent_234_1_1 end");
end



--[[
function OnEvent_234_1(proxy,param)
	print("OnEvent_234_1 begin");
	
	--proxy:OnRegistFunc(234, "Condition_234_anim_wait", "OnEvent_234_2", 2, once);
	--キャラなので、ここでのアニメIDに意味は無く、ただ尺を取る為に使用
	if	proxy:IsEventAnim( 301, 10 ) == true then
		proxy:OnChrAnimEnd( 234, 301, 10, "OnEvent_234_2", once );
	else
		OnEvent_234_2(proxy,param);
	end
	
	print("OnEvent_234_1 end");
end


function Condition_234_anim_wait(proxy,param)
	if	proxy:IsEventAnim(301, 7011) == false then
		return false;
	end
	return true;
end


function OnEvent_234_2(proxy,param)
	print("OnEvent_234_2 begin");
	proxy:ForcePlayAnimation( 301, 7011 );
	proxy:Warp(301, 2030);
	
	proxy:OnChrAnimEnd( 234, 301, 7011, "OnEvent_234_3", once );
	proxy:SetEventFlag( 234 , 1 );
	print("OnEvent_234_2 end");
end

--飛竜の眷属　撤退アニメ終了後、無効化
function OnEvent_234_3(proxy,param)
	print("OnEvent_234_3 begin");
	InvalidCharactor(proxy, 301);
	print("OnEvent_234_3 end");
end
]]
--------------------------------------------------------------------------------------
--■235■飛竜(長)の死亡監視■
--------------------------------------------------------------------------------------

function OnEvent_235(proxy , param)
	print( "OnEvent_235 begin" );

	--飛竜の長は撤退するだけで、死んだわけではない
	--SetNpcStateFlag( proxy , param , tyo_flag_list , TYO_STATE_DEAD );
	
	--飛竜(長)関連イベント削除
	proxy:DeleteEvent( 220 );--巣で寝ている
	
	proxy:OnKeyTime2( 235, "OnEvent_235_1", 0.0, 0, 2, once );

	print( "OnEvent_235 end" );
end

function OnEvent_235_1(proxy,param)
	print( "OnEvent_235_1 begin" );
	
	--proxy:OnRegistFunc(235, "Condition_235_anim_wait", "OnEvent_235_2", 2, once);
	--キャラなので、ここでのアニメIDに意味は無く、ただ尺を取る為に使用
	if	proxy:IsEventAnim( 300, 10 ) == true then
		proxy:OnChrAnimEnd( 235, 300, 10, "OnEvent_235_2", once );
	else
		OnEvent_235_2(proxy,param);
	end
	
	print( "OnEvent_235_1 end" );
end

function Condition_235_anim_wait(proxy,param)
	if	proxy:IsEventAnim(300, 7018) == false then
		return false;
	end
	return true;
end


function OnEvent_235_2(proxy,param)
	print("OnEvent_235_2 begin");
	proxy:ForcePlayAnimation( 300, 7018 );
	proxy:NotNetMessage_begin();
		--飛竜の長、撤退アニメ(7018)再生
		proxy:OnChrAnimEnd(235, 300, 7018, "OnEvent_235_3", once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_235_2 end");
end

--撤退アニメ終了後
function OnEvent_235_3(proxy,param)
	print("OnEvent_235_3 begin");
	SetNpcStateFlag(proxy, param, tyo1_flag_list, TYO_STATE_ESCAPE );
	InvalidCharactor(proxy, 300 );	
	print("OnEvent_235_3 end");
end



--------------------------------------------------------------------------------------
--■240■ホストPCのみが通れる光の霧■
--------------------------------------------------------------------------------------

--■240_delete_wall■魔法壁削除同期用■
function OnEvent_240_delete_wall(proxy , param)
	print("OnEvent_240_delete_wall begin");
	
	proxy:SetDrawEnable( 1055 , false );--魔法壁描画OFF
	proxy:SetColiEnable( 1055 , false );--魔法壁当たりOFF
	proxy:SetObjDeactivate( 1055 , true );--デアクティブ
	proxy:InvalidSfx( 2075 , true );--SFX OFF
	proxy:DeleteEvent( 240 );--全プレイヤー分の監視消えるはず。
	
	print("OnEvent_240_delete_wall end");
end


--■240■イベント発動用■
function OnEvent_240(proxy , param)
	print("OnEvent_240 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 240 ) == true then
		print("OnEvent_240 end");
		return;
	end
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 240 , 1 );
		print("OnEvent_240 end");
		return;
	end
	
	--ダミポリへワープ
	proxy:WarpDmy( LOCAL_PLAYER , 1055 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼240_1▼歩きアニメ終了▼
		--proxy:OnChrAnimEnd( 240 , LOCAL_PLAYER , ANIMEID_WALK , "OnEvent_240_1" , once );
		proxy:LuaCallStart( 240 , 1 );--光の霧削除同期
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 240 , 1 );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_240 end");
end


--▲240_1▲歩きアニメ終了▲
function OnEvent_240_1(proxy , param)
	print("OnEvent_240_1 begin");
	
	--proxy:LuaCallStart( 240 , 1 );--光の霧削除同期
	
	print("OnEvent_240_1 end");
end





--------------------------------------------------------------------------------------
--■241■ホストPCのみが通れる光の霧■
--------------------------------------------------------------------------------------

--■241_delete_wall■魔法壁削除同期用■
function OnEvent_241_delete_wall(proxy , param)
	print("OnEvent_241_delete_wall begin");
	
	proxy:SetDrawEnable( 1056 , false );--描画OFF
	proxy:SetColiEnable( 1056 , false );--当たりOFF
	proxy:SetObjDeactivate( 1056 , true );--デアクティブ
	proxy:DeleteEvent( 241 );
	proxy:InvalidSfx( 2076 , true );--SFX OFF
	
	print("OnEvent_241_delete_wall end");
end


--■241■イベント発動用■
function OnEvent_241(proxy , param)
	print("OnEvent_241 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 241 ) == true then
		print("OnEvent_241 end");
		return;
	end	
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 241 , 1 );
		print("OnEvent_241 end");
		return;
	end
	
	--ダミポリへワープ
	proxy:WarpDmy( LOCAL_PLAYER , 1056 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼241_1▼歩きアニメ終了▼
		--proxy:OnChrAnimEnd( 241 , LOCAL_PLAYER , ANIMEID_WALK , "OnEvent_241_1" , once );
		proxy:LuaCallStart( 241 , 1 );--光の霧削除同期
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 241 , 1 );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	print("OnEvent_241 end");
end


--▲241_1▲歩きアニメ終了▲
function OnEvent_241_1(proxy , param)
	print("OnEvent_241_1 begin");
	
	proxy:LuaCallStart( 241 , 1 );--光の霧削除同期
	
	print("OnEvent_241_1 end");
end


--------------------------------------------------------------------------------------
--■242■ホストPCのみが通れる光の霧■
--------------------------------------------------------------------------------------

--■242_delete_wall■魔法壁削除同期用■
function OnEvent_242_delete_wall(proxy , param)
	print("OnEvent_242_delete_wall begin");
	
	proxy:SetDrawEnable( 1057 , false );--描画OFF
	proxy:SetColiEnable( 1057 , false );--当たりOFF
	proxy:SetObjDeactivate( 1057 , true );--デアクティブ
	proxy:DeleteEvent( 242 );
	proxy:InvalidSfx( 2077 , true );--SFX OFF
	
	print("OnEvent_242_delete_wall end");
end


--■242■イベント発動用■
function OnEvent_242(proxy , param)
	print("OnEvent_242 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 242 ) == true then
		print("OnEvent_242 end");
		return;
	end	
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 242 , 1 );
		print("OnEvent_242 end");
		return;
	end
	
	--ダミポリへワープ
	proxy:WarpDmy( LOCAL_PLAYER , 1057 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼242_1▼歩きアニメ終了▼
		--proxy:OnChrAnimEnd( 242 , LOCAL_PLAYER , ANIMEID_WALK , "OnEvent_242_1" , once );
		proxy:LuaCallStart( 242 , 1 );--光の霧削除同期
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 242 , 1 );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_242 end");
end


--▲242_1▲歩きアニメ終了▲
function OnEvent_242_1(proxy , param)
	print("OnEvent_242_1 begin");
	
	proxy:LuaCallStart( 242 , 1 );--光の霧削除同期
	
	print("OnEvent_242_1 end");
end


--[[

--------------------------------------------------------------------------------------
--■251■奴隷兵士の死亡監視■
--------------------------------------------------------------------------------------

function OnEvent_251(proxy , param)
	print("OnEvent_251 begin");
	
	proxy:SetEventFlag( 251 , 1 );
	
	print("OnEvent_251 end");
end

--------------------------------------------------------------------------------------
--■252■奴隷兵士の死亡監視■
--------------------------------------------------------------------------------------

function OnEvent_252(proxy , param)
	print("OnEvent_252 begin");
	
	proxy:SetEventFlag( 252 , 1 );
	
	print("OnEvent_252 end");
end

--------------------------------------------------------------------------------------
--■253■奴隷兵士の死亡監視■
--------------------------------------------------------------------------------------

function OnEvent_253(proxy , param)
	print("OnEvent_253 begin");
	
	proxy:SetEventFlag( 253 , 1 );
	
	print("OnEvent_253 end");
end


--------------------------------------------------------------------------------------
--■254■奴隷兵士の死亡監視■
--------------------------------------------------------------------------------------

function OnEvent_254(proxy , param)
	print("OnEvent_254 begin");
	
	proxy:SetEventFlag( 254 , 1 );
	
	print("OnEvent_254 end");
end


--------------------------------------------------------------------------------------
--■255■奴隷兵士の死亡監視■
--------------------------------------------------------------------------------------

function OnEvent_255(proxy , param)
	print("OnEvent_255 begin");
	
	proxy:SetEventFlag( 255 , 1 );
	
	print("OnEvent_255 end");
end


--------------------------------------------------------------------------------------
--■256■奴隷兵士の死亡監視■
--------------------------------------------------------------------------------------

function OnEvent_256(proxy , param)
	print("OnEvent_256 begin");
	
	proxy:SetEventFlag( 256 , 1 );
	
	print("OnEvent_256 end");
end
]]
--------------------------------------------------------------------------------------
--■295■レンドル王子が敵になる■
--------------------------------------------------------------------------------------
function OnEvent_295(proxy,param)
	--敵対に状態遷移
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HOSTILE_1 );
	proxy:EnableLogic( 624 , true );
	proxy:SetTeamType( 624, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( 624 , 5062 );
	proxy:SetEventFlag( 295 , true );
end


--------------------------------------------------------------------------------------
--■300■レンドル王子の死亡監視■
--------------------------------------------------------------------------------------

function OnEvent_300(proxy , param)
	print("OnEvent_300 begin");
	
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_DEAD );
	RendolCheck(proxy,param);
	--死亡でRendolCheckする場合、その瞬間に消えてしまうので、
	--距離を見て再度有効にするか決める
	if	proxy:IsDistance( LOCAL_PLAYER, 624, 20 ) == true then
		ValidCharactor( proxy, 624 );
	end
	
	proxy:SetEventFlag( 300 , 1 );
	
	print("OnEvent_300 end");
end


--------------------------------------------------------------------------------------
--■260■王子の監視■
--------------------------------------------------------------------------------------
function DoreiRegist_block1(proxy)
	local acid_list = { 251, 252, 253, 254, 255, 256};
	local evid_list = { 310, 311, 312, 313, 314, 315};
	local event_num = table.getn(acid_list);
	for index = 1, event_num, 1 do
		local acid = acid_list[index];
		local evid = evid_list[index];
		if	proxy:IsCompleteEvent( acid ) == false then
			proxy:OnCharacterDead( acid , evid , "OnEvent_260" , once );
		else
			proxy:OpeningDead( evid, false );
		end
	end
end



function OnEvent_260(proxy,param)
	print("OnEvent_260 begin");

	proxy:SetEventFlag( param:GetParam1(), true );
	
	if 	proxy:IsCompleteEvent(251) == false or
		proxy:IsCompleteEvent(252) == false or
		proxy:IsCompleteEvent(253) == false or
		proxy:IsCompleteEvent(254) == false or
		proxy:IsCompleteEvent(255) == false or
		proxy:IsCompleteEvent(256) == false then
		print("OnEvent_260 is No Success");
		print("OnEvent_260 end");
		return;
	end

	--王城1で感謝に 状態遷移を試みる
	if proxy:IsCompleteEvent(RENDOL_STATE_HELP_FOR_DOREI_HEISI) == true then	--状態が「奴隷兵士から助けて」 ならば
		SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_THANKS_1 );
		RendolCheck(proxy,param);
	else--助けて以外ならば（敵対と死亡？）
		print("王子は死んでいるか、怒っています");
	end
--[[
		proxy:EnableLogic(624,true);--王子ロジックON
		proxy:ChangeInitPosAng( 624 , 2150 );--王子の帰還場所を変更
		
		proxy:NotNetMessage_begin();
			--▼アイテム取得用の監視を追加▼
			proxy:LuaCall(10501,0,"OnEvent_10501",once);
		proxy:NotNetMessage_end();
]]
	proxy:SetEventFlag( 260 , 1 );
	
	print("OnEvent_260 end");	
end


--------------------------------------------------------------------------------------
--■10501■王子から感謝のアイテム■
--------------------------------------------------------------------------------------
function OnEvent_10501(proxy,param)
	print("OnEvent_10501 begin");	
	proxy:NotNetMessage_begin();
	
		--アニメ再生がトリガーになるかも？その場合監視を追加してコール
		--今回はただのLua関数で呼ぶ
		OnEvent_10501_1(proxy,param);
--[[
		--移動タイプを往復に変更
		proxy:SetEventMovePointType( 624, POINT_MOVE_TYPE_RoundTrip );
	
		--移動ポイントを設定
		proxy:AddCustomRoutePoint(624, 2010);
		proxy:AddCustomRoutePoint(624, 2011);
		proxy:AddCustomRoutePoint(624, 2012);
		proxy:AddCustomRoutePoint(624, 2013);
		proxy:AddCustomRoutePoint(624, 2012);
		proxy:AddCustomRoutePoint(624, 2011);
		proxy:AddCustomRoutePoint(624, 2014);
		proxy:AddCustomRoutePoint(624, 2015);
]]	
	proxy:NotNetMessage_end();
	print("OnEvent_10501 end");
end

--
function OnEvent_10501_1(proxy,param)
	
	print("OnEvent_10501_1 begin");
	OnEvent_260_1(proxy,param);
	
	if param:IsNetMessage() == false then
		--アイテム取得関数--パラメータ10101参照
		proxy:GetRateItem(10193);
	end	
	--アイテムを取得済み
	proxy:SetEventFlag( 10501, 1 );
	
	--王城1で探索に 状態遷移を試みる	
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_SEARCH_1 );
	RendolCheck(proxy,param);
--[[	
		proxy:EnableLogic( 624 , true );--レンドル王子、探索状態で歩き出す
		proxy:ResetThink( 624 );
		
		proxy:NotNetMessage_begin();
			--▼レンドル王子が次のブロックへ移動用の距離監視▼
		--proxy:OnRegistFunc( 301 , "Check_OnEvent_301" , "OnEvent_301" , 1 , once );
		proxy:NotNetMessage_end();
]]	
	print("OnEvent_10501_1 end")
end

--[[
--------------------------------------------------------------------------------------
--■301■レンドル王子が次のブロックに移動■
--------------------------------------------------------------------------------------

function Check_OnEvent_301( proxy , param )

	--生存プレイヤー(グレイ)のみ判定
	if proxy:IsLivePlayer() == false and
	   proxy:IsGreyGhost()  == false then
		return false;
	end
	
	--ボス(ファランクス)生きてたら判定しない
	if proxy:IsCompleteEvent( 4096 ) == false then
		return false;
	end
	
	--距離判定
	if proxy:IsDistance( LOCAL_PLAYER , 624 , 20 ) == true then
		return false;
	else
		print("レンドル王子、次ブロックへ移動");
		return true;
	end
	
	return false;
end
]]

function OnEvent_301( proxy , param )
	print("OnEvent_301 begin");
	
	--王城2で「隠れているので助けて」に 状態遷移
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HELP_HIDING_ME );
	RendolCheck(proxy,param);
	
	proxy:SetEventFlag( 301 , 1 );--イベント終了
	
	print("OnEvent_301 end");
end




--------------------------------------------------------------------------------------
--■280■吊るされた死体1が落下する■
--------------------------------------------------------------------------------------

function OnEvent_280( proxy , param )
	print("OnEvent_280 begin");

	--オブジェ破壊を同期させる(配信で受け取った人は、オブジェ破壊を再現する)
	if param:IsNetMessage() == true then	
		proxy:ReconstructBreak( 1172 , 1 );
	end
	
	proxy:PlayAnimation( 10240 , 1000 );--死体のアニメを終了
	
	proxy:NotNetMessage_begin();
		--▼280_1▼破壊アニメ再生終了▼
		proxy:OnObjAnimEnd( 280 , 10240 , 1000 , "OnEvent_280_1" , once );
	proxy:NotNetMessage_end();
	
	--オブジェ破壊は個人でそれぞれ判定されるのでLuaCallにしなくても大丈夫(ﾀﾌﾞﾝ)
	proxy:SetEventFlag( 280 , true );
	
	print("OnEvent_280 end");
end

--▲280_1▲破壊アニメ再生終了▲
function OnEvent_280_1( proxy , param )
	print("OnEvent_280_1 begin");
	
	if proxy:IsClient() == false then
		--宝システム有効化
		proxy:EnableObjTreasure( 10240 , true );
	end
	
	print("OnEvent_280_1 end");
end


--------------------------------------------------------------------------------------
--■281■吊るされた死体2が落下する■
--------------------------------------------------------------------------------------

function OnEvent_281( proxy , param )
	print("OnEvent_281 begin");

	--オブジェ破壊を同期させる(配信で受け取った人は、オブジェ破壊を再現する)
	if param:IsNetMessage() == true then	
		proxy:ReconstructBreak( 1174 , 1 );
	end
	
	proxy:PlayAnimation( 10241 , 1000 );--死体のアニメを終了
	
	proxy:NotNetMessage_begin();
		--▼281_1▼破壊アニメ再生終了▼
		proxy:OnObjAnimEnd( 281 , 10241 , 1000 , "OnEvent_281_1" , once );
	proxy:NotNetMessage_end();
	
	--オブジェ破壊は個人でそれぞれ判定されるのでLuaCallにしなくても大丈夫(ﾀﾌﾞﾝ)
	proxy:SetEventFlag( 281 , true );
	
	print("OnEvent_281 end");
end

--▲281_1▲破壊アニメ再生終了▲
function OnEvent_281_1( proxy , param )
	print("OnEvent_281_1 begin");

	--宝システム有効化
	proxy:EnableObjTreasure( 10241 , true );
	
	print("OnEvent_281_1 end");
end


--------------------------------------------------------------------------------------
--■285■砲弾ゴロゴロ■
--------------------------------------------------------------------------------------

function OnEvent_285( proxy , param )
	print("OnEvent_285 begin");

	--オブジェ破壊を同期させる(配信で受け取った人は、オブジェ破壊を再現する)
	if param:IsNetMessage() == true then	
		proxy:ReconstructBreak( 1190 , 1 );
	end
	
	--砲弾ゴロゴロアニメ再生
	proxy:PlayAnimation( 1191 , 1 );
	
	--砲弾からダメージ球
	local paramid = 10000; --無属性ダメージ
	local rad    = 0.5;--半径(あとで、正式な値になるはず･･･今は適当)
	--local time   = 20; --ひとまずアニメ再生終了でダメージ球消すので、アニメより長い時間を指定しておく
	local time   = 120; --ひとまずアニメ再生終了でダメージ球消すので、アニメより長い時間を指定しておく
	local requestTime = 1.0;--ダメージ球再作成間隔
	
	--▼285_hit▼砲弾1があたったとき▼
	proxy:OnObjectDamageHit_NoCallPlus( 285, 1191, 1, paramid, EV_HIT_CHR ,  rad, time, requestTime, everytime );
	--▼285_hit▼砲弾2があたったとき▼
	proxy:OnObjectDamageHit_NoCallPlus( 285, 1191, 2, paramid, EV_HIT_CHR ,  rad, time, requestTime,  everytime );
	--▼285_hit▼砲弾3があたったとき▼
	proxy:OnObjectDamageHit_NoCallPlus( 285, 1191, 3, paramid, EV_HIT_CHR ,  rad, time, requestTime,  everytime );	
	--▼285_hit▼砲弾4があたったとき▼
	proxy:OnObjectDamageHit_NoCallPlus( 285, 1191, 4, paramid, EV_HIT_CHR ,  rad, time, requestTime,  everytime );
	--▼285_hit▼砲弾5があたったとき▼
	proxy:OnObjectDamageHit_NoCallPlus( 285, 1191, 5, paramid, EV_HIT_CHR ,  rad, time, requestTime,  everytime );
	proxy:SetObjEventCollisionFill( 1191, true );

	--アニメ再生が終わったら、ダメージ球消すなどする?
	proxy:NotNetMessage_begin();
		--▼285_anime_end▼砲弾ゴロゴロアニメ終了▼
		proxy:OnObjAnimEnd( 285 , 1191 , 1 , "OnEvent_285_anime_end" , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 285 , true );

	print("OnEvent_285 end");
end
	

--▲285_anime_end▲砲弾ゴロゴロアニメ終了▲
function OnEvent_285_anime_end( proxy , param )
	print("OnEvent_285_anime_end begin");

	proxy:DeleteEvent( 285 );--ダメージ球など削除

	print("OnEvent_285_anime_end end");
end
	

--------------------------------------------------------------------------------------
--■310～319■ソウルモンスター出現■
--------------------------------------------------------------------------------------
--ソウルモンスターイベント登録
function RegistSoulMonster_block1(proxy)
	local acid_list = {   310,   311,   312,   313,   314,   315,   316,   317,   318,   319};
	local evid_list = {   320,   321,   322,   323,   324,   325,   326,   327,   328,   329};
	local qwc_list  = { 20100, 20100,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1};
	local event_num = table.getn(acid_list);
	for index = 1, event_num, 1 do
		acid = acid_list[index];
		evid = evid_list[index];
		qwc_id = qwc_list[index];
		SingleReset( proxy,acid );
		if	(qwc_id ~= -1 and proxy:IsSuccessQWC(qwc_id) == true) or (qwc_id == -1) then
			if	proxy:IsCompleteEvent( acid ) == false then
				proxy:OnPlayerDistanceInTarget( acid, LOCAL_PLAYER, evid, "OnEvent_"..acid, 10.0, once );
				InvalidCharactor( proxy, evid );
			else
				proxy:EnableLogic( evid, true );
			end
		else
			InvalidCharactor( proxy, evid );
		end
	end
	
	SingleReset( proxy , 310);
	if proxy:IsCompleteEvent( 310 ) == false then
		if proxy:IsSuccessQWC(20100) == true then--QWCが成立したら
			proxy:OnPlayerDistanceInTarget( 310 , LOCAL_PLAYER , 320 , "OnEvent_310" , 10.0 , once );
		end
	else 
		proxy:EnableLogic( 320 , true );--ロジックON
	end
	
end


function OnEvent_310(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_311(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_312(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_313(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_314(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_315(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_316(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_317(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_318(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_319(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end

function SoulMonsterFunc_block1(proxy,param,acid,evid)
	print("OnEvent_"..acid.." begin")
	if	proxy:IsAlive(evid) == false then
		print("OnEvent_"..acid.." return end")
	end
	
	ValidCharactor( proxy , evid );--キャラクタ有効化
	proxy:PlayAnimation( evid , 6100 );--ソウル体出現アニメ再生(今は待機アニメになっている)
	proxy:SetEventFlag( acid , true );
	
	print("OnEvent_"..acid.." end")
end







--------------------------------------------------------------------------------------
--ハシゴ1降り■320
--------------------------------------------------------------------------------------
--■320■ハシゴ1降りスタート■
function OnEvent_320(proxy, param)
	print("OnEvent_320 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_320 end");
		return;
	end

	--はしご降りに必要な前処理--
	proxy:BeginAction(LOCAL_PLAYER,2,2,2);				--ホバー移動モードに移行
	--proxy:HoverMoveVal(LOCAL_PLAYER,2002,LadderTime_A);--移動位置(2002)に0.5秒でホバー移動
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1060,192,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動
	proxy:SetEventCommand(LOCAL_PLAYER,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );--nCommandID を 垂直のとき0 斜めのとき4
	proxy:DisableMove(LOCAL_PLAYER,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行
		proxy:OnKeyTime2(320,"OnEvent_320_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理)
		proxy:OnKeyTime2(320,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_320 end");
end

--■320_1■ハシゴA降りスタート:ホバー移動終了■
function OnEvent_320_1(proxy, param)
	print("OnEvent_320_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_320_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,50,49);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_320_1 end");
end


--------------------------------------------------------------------------------------
--ハシゴ1昇り■321
--------------------------------------------------------------------------------------
--■321■ハシゴ1昇りスタート■
function OnEvent_321(proxy, param)
	print("OnEvent_321 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_321 end");
		return;
	end
	
	--はしご昇りに必要な前処理--
	proxy:BeginAction(LOCAL_PLAYER,2,-1,1);			--ホバー移動モードに移行
	--proxy:HoverMoveVal(LOCAL_PLAYER,2003,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1060,191,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動
	proxy:SetEventCommand(LOCAL_PLAYER,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );--nCommandID を 垂直のとき0 斜めのとき4
	proxy:DisableMove(LOCAL_PLAYER,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご昇りスタートイベントを発行
		proxy:OnKeyTime2(321,"OnEvent_321_1",LadderTime_A,0,0,once);
		--はしご昇り用の関数を1秒間発行(イベントメニューの中断処理?)
		proxy:OnKeyTime2(321,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_321 end");
end

--■321_1■ハシゴ1昇りスタート:ホバー移動終了■
function OnEvent_321_1(proxy, param)
	print("OnEvent_321_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_321_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,-1,49);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_321_1 end");
end


--------------------------------------------------------------------------------------
--■2■飛竜が飛んでくるポリ劇を再生する■
--------------------------------------------------------------------------------------

function OnEvent_2(proxy , param)
	print("OnEvent_2 begin");

	--▼飛竜が飛んでくるポリ劇再生
	proxy:RequestRemo(20000,REMO_FLAG,2,1);
	proxy:SetEventFlag( 2, true );

	print("OnEvent_2 end");
end


--■ポリ劇再生開始(フェード終了)
function OnEvent_2_RemoStart(proxy,param)
	print("OnEvent_2_RemoStart begin");
	
	--SEが残るらしいので-1再生
	--proxy:ForcePlayAnimation( 1110 ,-1);
	--proxy:ForcePlayAnimation( 1111 ,-1);
	--proxy:ForcePlayAnimation( 1112 ,-1);
	--カラスが残ってしまうようなので消す。
	--proxy:SetDrawEnable( 1110 , false );
	--proxy:SetDrawEnable( 1111 , false );
	--proxy:SetDrawEnable( 1112 , false );
	
	print("OnEvent_2_RemoStart end");
end


--■ポリ劇再生終了(フェード終了)
function OnEvent_2_RemoFinish(proxy , param)
	print("OnEvent_2_RemoFinish begin");
	print("OnEvent_2_RemoFinish end");
end

--------------------------------------------------------------------------------------
--■258■奴隷兵士がレンドル王子を狙うのをやめる監視追加(ロジック切り替え)■
--------------------------------------------------------------------------------------

--■領域入ったとき(奴隷兵士 通常ロジックにする)
function OnEvent_258(proxy,param)
	print("OnEvent_258 begin");

	--レンドル王子の状態取得
	local now_state = GetRendolState( proxy, param );
	
	--状態が「奴隷兵士から助けて」じゃない　
	--状態が「王城１敵対」じゃない
	--状態が「王城１死亡」じゃないときは 処理しない(監視削除)
	if 	now_state ~= RENDOL_STATE_HELP_FOR_DOREI_HEISI and
		now_state ~= RENDOL_STATE_HOSTILE_1 and
		now_state ~= RENDOL_STATE_DEAD then
		proxy:DeleteEvent( 258 );--ロジック切り替え監視削除
		proxy:DeleteEvent( 245 );--奴隷兵士のダメージ監視削除
		print("OnEvent_258 end");
		return;
	end
		
	--奴隷兵士通常ロジックに切り替え(レンドル王子と睨み合うのをやめる)
	local dorei_heisi_id_list = {310,311,312,313,314,315};
	local dorei_heisi_num = table.getn( dorei_heisi_id_list );
	
	for i=1 , dorei_heisi_num , 1 do
		proxy:ForceUpdateNextFrame( dorei_heisi_id_list[i] );--次のフレームは強制更新
		proxy:SendEventRequest    ( dorei_heisi_id_list[i] , 0 , AI_EVENT_None);
		--proxy:SetEventTarget   ( dorei_heisi_id_list[i] , -1);--強制ターゲットクリア
	end
	
	proxy:DeleteEvent( 245 );--奴隷兵士のダメージ監視を一旦削除
	
	proxy:SetEventFlag( 258 , 1 );--王子を狙うのをやめた

	print("OnEvent_258 end");
end

--■領域を出たとき(奴隷兵士 威嚇ロジックにする)
function OnEvent_258_out(proxy,param)
	print("OnEvent_258_out begin");

	--領域に入ったフラグがOFFだったら処理しない(恐らくないと思われるけれど･･･)
	if proxy:IsCompleteEvent( 258 ) == false then
		print("OnEvent_258_out end");
		return;
	end
	
	--レンドル王子の状態取得
	local now_state = GetRendolState( proxy, param );
	
	--状態が「奴隷兵士から助けて」じゃないときは 処理しない(監視削除)
	if now_state ~= RENDOL_STATE_HELP_FOR_DOREI_HEISI then
		proxy:DeleteEvent( 258 );--ロジック切り替え監視削除
		proxy:DeleteEvent( 245 );--奴隷兵士のダメージ監視削除
		print("OnEvent_258_out end");
		return;
	end
	
	--奴隷兵士威嚇ロジックに切り替え(レンドル王子と睨み合う)
	local dorei_heisi_id_list = {310,311,312,313,314,315};
	local dorei_heisi_num = table.getn( dorei_heisi_id_list );
	local rendol_id = 624;
		
	for i=1, dorei_heisi_num, 1 do		
		proxy:SendEventRequest( dorei_heisi_id_list[i] , 0 , AI_EVENT_DOREI_IKAKU);
		proxy:SetEventTarget( dorei_heisi_id_list[i] , rendol_id);--強制ターゲット設定
		
		--▼奴隷兵士たちのダメージ監視▼
		proxy:OnSimpleDamage( 245 , dorei_heisi_id_list[i], LOCAL_PLAYER, "OnEvent_258", once );--ダメージ監視
	end
	
	proxy:SetEventFlag( 258 , 0 );--王子を狙うのを再開
	
	print("OnEvent_258_out end");
end

--■259■レンドル王子が領域侵入で仕方なく戦う■
function OnEvent_259(proxy,param)
	print("OnEvent_259 begin");
	proxy:EnableLogic( 624, true );
	print("OnEvent_259 end");
end


--------------------------------------------------------------------------------------
--■4103■ソウル入手■
--------------------------------------------------------------------------------------

function OnEvent_4103(proxy, param)
	print("OnEvent_4103 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ 
		print("OnEvent_4103 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行
		proxy:OnKeyTime2( 4103, "OnEvent_4103_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4103 end");
end


--■4103_1■アイテム取得■
function OnEvent_4103_1(proxy, param)
	print("OnEvent_4103_1 begin");

	--アイテム取得関数--パラメータ10101参照
	proxy:GetRateItem(10110);
	proxy:GetRateItem(10170);
	proxy:GetRateItem(10171);
	proxy:GetRateItem(10172);
	proxy:GetRateItem(10173);
	
	--アイテムを取得済み
	proxy:SetEventFlag( 4103, 1 );
	
	--宝箱シェーダーは消えません
	--proxy:TreasureDispModeChange( 1982 , false );

	--SFXが消える
	proxy:InvalidSfx( 1080 , true );--光の粒子
	--proxy:InvalidSfx( 1081 , true );--要石のオーラ
	
	--▼要石でワープ用の監視を追加▼
	proxy:OnDistanceActionAttribute( 4105 , LOCAL_PLAYER , 1982 , "OnEvent_4105" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_4103_1 end");
end

--------------------------------------------------------------------------------------
--■30■最初の要石の光が消える■
--------------------------------------------------------------------------------------

function OnEvent_30(proxy, param)
	print("OnEvent_30 begin");
	
	proxy:TreasureDispModeChange2( 1983 , false ,KANAME_SFX);
	
	print("OnEvent_30 end");
end


--------------------------------------------------------------------------------------
--■31■最初の要石の光が復活する■
--------------------------------------------------------------------------------------

function OnEvent_31(proxy, param)
	print("OnEvent_31 begin");
	
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	
	print("OnEvent_31 end");
end

--【ドラン】戦闘開始
function OnEvent_329(proxy,param)
	proxy:EnableLogic( 697 , true );
	proxy:SetEventFlag( 329 , true );
end

--【ドラン】許してくれた
function OnEvent_330(proxy,param)
	print("OnEvent_330 begin");
	if proxy:IsAlive( 697 ) == true then
		proxy:SetTeamType( 697, TEAM_TYPE_Friend );
		SetNpcStateFlag( proxy , param , doran_flag_list , DORAN_STATE_ALLOWED );
		proxy:ResetThink(697);
	
		proxy:ClearTarget(nWho);
	end
	
	--ホスト、生存、グレイのみ調べることができる
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	--HELPIDがデモンブランド専用になった
	proxy:OnDistanceActionAttribute( 5 , LOCAL_PLAYER , 1192 , "OnEvent_5" , ItemBoxDist_A , 10010130 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
	proxy:LuaCall( 5,1,"OnEvent_5_2",once);	
	proxy:LuaCall( 5,2,"OnEvent_5_3",once);
	proxy:TreasureDispModeChange2( 1192, true ,KEN_SFX);
	--proxy:SetRarity( 1192, 10104 );
				
	proxy:SetEventFlag( 330, true );
	print("OnEvent_330 end");
end

--【ドラン】許さない
function OnEvent_331(proxy,param)
	if proxy:IsAlive( 697 ) == true then
		print("OnEvent_331 begin");
		proxy:SetTeamTypeDefault( 697 );
		SetNpcStateFlag( proxy , param , doran_flag_list , DORAN_STATE_NOT_ALLOWED );
		print("ドラン手加減やめる");
		proxy:SendEventRequest( 697 ,0, -1);
		proxy:EraseEventSpecialEffect_2( 697 , 5042 );
		proxy:SetEventFlag( 331, true );
		print("OnEvent_331 end");
	end
end

--【ドラン】死亡
function OnEvent_332(proxy,param)
	print("OnEvent_332 begin");
	SetNpcStateFlag( proxy , param , doran_flag_list , DORAN_STATE_DEAD );
	proxy:SetEventFlag( 332, true );

	--▼トロフィー取得判定▼
	Lua_RequestUnlockTrophy(proxy, 11);

	print("OnEvent_332 end");
end

--【ドラン】死体を調べた
function OnEvent_15610(proxy,param)
	print("OnEvent_15610 begin");
	proxy:SetEventFlag( 15610 , true );
	print("OnEvent_15610 end");
end



function CheckPointIn_AttrCheck(proxy,param)
	print("CheckPointIn_AttrCheck begin");
	--ホストのみチェックポイント判定を行う
	if	proxy:IsClient() == false then
		--→CheckPointIn
		--パラメータとして領域のイベントIDを渡しておく
		proxy:LuaCallStartPlus( SYSTEM_CHECK_POINT, 2, param:GetParam2() );
	end
	print("CheckPointIn_AttrCheck end");
end

--チェックポイント通過
function CheckPointIn(proxy,param)
	print("CheckPointIn begin");
	RendolCheck(proxy,param);
	BiyoCheck(proxy,param);
	--HiryuOsaCheck(proxy,param);
	OnEvent_781(proxy,param);--奴隷兵士ショップ
	print("CheckPointIn end");
end

function InitializeNpc(proxy,param)
	RendolCheck2(proxy,param,false);
	BiyoCheck2(proxy,param,false);
	--HiryuOsaCheck(proxy,param);
	OnEvent_781(proxy,param);--奴隷兵士ショップ
end

--[[削除との事なので、コメントアウト
--------------------------------------------------------------------------------------
--■10700■吊るされている人が話しかけてくる■
--------------------------------------------------------------------------------------
function OnEvent_10700(proxy,param)
--	print("OnEvent_10700 begin");

	--死体を落とすイベントが終わっている
	if proxy:IsCompleteEvent( 281 ) == true then
		
		if proxy:IsCompleteEvent( 10701 ) == false then
			--断末魔(感謝)
			proxy:CloseTalk(10700);
			proxy:TalkNextPage( 10701 );
			proxy:SetEventFlag( 10701 , 1 );
		else
			proxy:DeleteEvent( 10700 );
			return;
		end
		
	--まだ吊るされている
	else
		if proxy:IsCompleteEvent( 10700 ) == false then
			--話しかけてくる
			proxy:TalkNextPage( 10700 );	
			proxy:SetEventFlag( 10700 , 1 );
		end
	end

--	print("OnEvent_10700 end");
end]]


--[[-----------------------------------------------------------------------------------------------------------------------------------------
	レンドル王子関連　ここから
-----------------------------------------------------------------------------------------------------------------------------------------]]
function RendolCheck(proxy,param)
	RendolCheck2(proxy,param,true);
end

function RendolCheck2(proxy,param,flag)
	print("RendolCheck begin");
	local rendol_id_1 = 624;--王城１のレンドル王子
	local rendol_id_2 = 620;--王城２のレンドル王子
	local rendol_id_3 = 621;--王城３のレンドル王子
	local rendol_id_4 = 626;--王城４のレンドル王子
	
	local rendol_block1_acid_list = {   245,   258,   259,   301,   260,   300,   295, 10501};
	local rendol_block2_acid_list = { 10800,   723,   724,   643};
	local rendol_block3_acid_list = {  1310,  1311,  1312,  1313,  1314,  1315,  1316,  1316,  1317,  1318,  1349, 1350,  1351,  1352,  1360,  1361,  1362, 11501};
	local rendol_block4_acid_list = { 11790,  1700,  1702};
	
	--一旦全員消しておく
	InvalidCharactor(proxy,rendol_id_1);
	InvalidCharactor(proxy,rendol_id_2);
	InvalidCharactor(proxy,rendol_id_3);
	InvalidCharactor(proxy,rendol_id_4);
	--InvalidCharactor(proxy, 102);
	--InvalidCharactor(proxy, 103);
	

	
	--監視を一旦全削除
	DeleteConditionList(proxy,rendol_block1_acid_list);
	DeleteConditionList(proxy,rendol_block2_acid_list);
	DeleteConditionList(proxy,rendol_block3_acid_list);
	DeleteConditionList(proxy,rendol_block4_acid_list);
	
	SetFirstNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HELP_FOR_DOREI_HEISI );
	
	----------------------------------------------------------------------------------------------------------------
	--王子が奴隷兵士から助けて状態--16000
	if	proxy:IsCompleteEvent(RENDOL_STATE_HELP_FOR_DOREI_HEISI) == true then
		print("rendol state RENDOL_STATE_HELP_FOR_DOREI_HEISI");
		SetRendolState_01(proxy, param, rendol_id_1 );
		RendolRegistCondition_block1(proxy,param,rendol_id_1);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が感謝（王城１）状態--16001
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_THANKS_1) == true then
		print("rendol state RENDOL_STATE_THANKS_1");
		if flag == true then
			SetRendolState_02(proxy, param, rendol_id_1 );
		else
			SetRendolState_02Init(proxy, param, rendol_id_1 );
		end
		RendolRegistCondition_block1(proxy,param,rendol_id_1);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が探索（王城１）状態--16002
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_SEARCH_1) == true then
		print("rendol state RENDOL_STATE_SEARCH_1");
		if flag == true then
			SetRendolState_03(proxy, param, rendol_id_1 );
		else
			SetRendolState_03Init(proxy, param, rendol_id_1 );
		end
		RendolRegistCondition_block1(proxy,param,rendol_id_1);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が敵対（王城１）状態--16003
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_1) == true then
		print("rendol state RENDOL_STATE_HOSTILE_1");
		if flag == true then
			SetRendolState_04(proxy, param, rendol_id_1 );
		else
			SetRendolState_04Init(proxy, param, rendol_id_1 );
		end
		RendolRegistCondition_block1(proxy,param,rendol_id_1);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が死んでいる状態--16004
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_DEAD) == true then
		print("rendol state RENDOL_STATE_DEAD");
		--ここでは追加も設定もしない
		
	----------------------------------------------------------------------------------------------------------------
	--王子が隠れているので助けて状態--16005
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HELP_HIDING_ME) == true then
		print("rendol state RENDOL_STATE_HELP_HIDING_ME");
		SetRendolState_05(proxy, param, rendol_id_2 );
		RendolRegistCondition_block2(proxy,param,rendol_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が感謝（王城２）状態--16006
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_THANKS_2) == true then
		print("rendol state RENDOL_STATE_THANKS_2");
		SetRendolState_06(proxy, param, rendol_id_2 );
		RendolRegistCondition_block2(proxy,param,rendol_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が探索（王城２）状態--16007
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_SEARCH_2) == true then
		print("rendol state RENDOL_STATE_SEARCH_2");
		SetRendolState_07(proxy, param, rendol_id_2 );
		RendolRegistCondition_block2(proxy,param,rendol_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が敵対（王城２）状態--16008
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_2) == true then
		print("rendol state RENDOL_STATE_HOSTILE_2");
		SetRendolState_08(proxy, param, rendol_id_2 );
		RendolRegistCondition_block2(proxy,param,rendol_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が見えない場所にこっそり状態--16009
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_LOCATION_INVISIBLE) == true then
		print("rendol state RENDOL_STATE_LOCATION_INVISIBLE");
		SetRendolState_09(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が門を開けて欲しい状態--16010
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_WANT_TO_OPEN_THE_GATE) == true then
		print("rendol state RENDOL_STATE_WANT_TO_OPEN_THE_GATE");
		SetRendolState_10(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が袋小路で怯え状態--16011
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_SCARED) == true then
		print("rendol state RENDOL_STATE_SCARED");
		SetRendolState_11(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が感謝（王城３）状態--16012
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_THANKS_3) == true then
		print("rendol state RENDOL_STATE_THANKS_3");
		SetRendolState_12(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が探索（王城３）状態--16013
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_SEARCH_3) == true then
		print("rendol state RENDOL_STATE_SEARCH_3");
		SetRendolState_13(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が敵対（王城３）城門の前状態--16014
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_3_FRONT_GATE) == true then
		print("rendol state RENDOL_STATE_HOSTILE_3_FRONT_GATE");
		SetRendolState_14(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が敵対（王城３）城門の後ろ状態--16015
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_3_BACK_GATE) == true then
		print("rendol state RENDOL_STATE_HOSTILE_3_BACK_GATE");
		SetRendolState_15(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--王子がエレベータ前状態--16016
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_LIFT_FRONT) == true then
		print("rendol state RENDOL_STATE_LIFT_FRONT");
		SetRendolState_16(proxy, param, rendol_id_4 );
		RendolRegistCondition_block4(proxy,param,rendol_id_4);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が敵対（王城４）状態--16017
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_4_LIFT_FRONT) == true then
		print("rendol state RENDOL_STATE_HOSTILE_4_LIFT_FRONT");
		SetRendolState_17(proxy, param, rendol_id_4 );
		RendolRegistCondition_block4(proxy,param,rendol_id_4);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が敵対（石柱）状態--16018
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_STONE_PILLAR) == true then
		print("rendol state RENDOL_STATE_HOSTILE_STONE_PILLAR");
		SetRendolState_18(proxy, param, rendol_id_4 );
		RendolRegistCondition_block4(proxy,param,rendol_id_4);
	end
	print("RendolCheck end");
end


--[[11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
---------------------------------------▽▽▽王城１レンドル王子▽▽▽------------------------------
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111]]
function RendolRegistCondition_block1(proxy,param,chrId)
	print("RendolRegistCondition_block1 begin");
	
	if	proxy:IsCompleteEvent(RENDOL_STATE_DEAD) == false then
		if	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_1) == false then
			--■295■レンドル王子が敵になる■
			if proxy:IsCompleteEvent( 295 ) == false then
				--レンドル王子(624)がPC(LOCAL_PLAYER)から100ダメージを受けた
				--proxy:OnCharacterTotalDamage( 295, chrId, LOCAL_PLAYER, 100, "OnEvent_295", once );
				proxy:OnCharacterTotalRateDamage( 295, chrId, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_295", once );
			end
		end
		--■300■レンドル王子の死亡■
		if proxy:IsCompleteEvent( 300 ) == false then
			proxy:OnCharacterDead( 300 , chrId , "OnEvent_300" , once );
		end
		
		
		--■260■レンドル王子を囲んでいる奴隷兵士を全部倒した■
		if proxy:IsCompleteEvent( 260 ) == true then
			proxy:DeleteEvent( 258 );--王子から奴隷兵士助けるイベント削除
		end
	end

	
	print("RendolRegistCondition_block1 end");
end


-------------------------------------------------------------------------------------------------
--王子が奴隷兵士から助けて状態--16000
function SetRendolState_01(proxy,param,chrId)
	print("SetRendolState_01 begin");
	local enemy_list = {310, 311, 312, 313, 314, 315};
	local enemy_num = table.getn( enemy_list );
	for index = 1, enemy_num, 1 do
		--奴隷が生きていたら威嚇にして、レンドル王子をターゲットに設定
		if	proxy:IsAlive(enemy_list[index]) == true then
			--proxy:ChangeThink( enemy_list[index], AI_EVENT_DOREI_IKAKU);
			proxy:SendEventRequest( enemy_list[index], 0, AI_EVENT_DOREI_IKAKU );
			proxy:SetEventTarget( enemy_list[index] , chrId );--強制ターゲット設定
			--▼奴隷兵士たちのダメージ監視▼
			proxy:OnSimpleDamage( 245 , enemy_list[index] , LOCAL_PLAYER , "OnEvent_258" , once );--ダメージ監視			
		end
	end
	--▼レンドル王子が領域侵入で仕方なく戦う▼
	proxy:OnRegionJustIn( 259, chrId, 2151, "OnEvent_259", once );
	
	proxy:EnableLogic( chrId , false );--レンドル王子ロジックOFF
	--王子有効化
	ValidCharactor( proxy, chrId );
	
	--▼奴隷兵士がレンドル王子を狙うのをやめる監視追加(ロジック切り替え)▼	
	proxy:SetEventFlag( 258 , 0 );--毎回追加されてほしいので･･･。
	proxy:OnRegionJustIn ( 258 , LOCAL_PLAYER , 2151 , "OnEvent_258"     , everytime );--領域入ったとき通常へ		
	proxy:OnRegionJustIn ( 258 , chrId , 2151 , "OnEvent_258"     , everytime );--レンドル領域入ったとき通常へ		
	proxy:OnRegionJustOut( 258 , LOCAL_PLAYER , 2151 , "OnEvent_258_out" , everytime );--領域でたとき威嚇へ
	
	print("SetRendolState_01 end");
end


-------------------------------------------------------------------------------------------------
--王子が感謝（王城１）状態--16001
function SetRendolState_02(proxy,param,chrId)
	print("SetRendolState_02 begin");
	
	--王子有効化
	ValidCharactor( proxy, chrId );
	
	proxy:EnableLogic(chrId,true);--王子ロジックON
	proxy:ChangeInitPosAng( chrId , 2150 );--王子の帰還場所を変更
	proxy:ResetThink( chrId );
	proxy:ForceUpdateNextFrame( chrId );
	proxy:SendEventRequest( chrId, 0, 10 );
	
	--■10501■アイテム取得(会話で呼び出し)■
	--proxy:NotNetMessage_begin();
		proxy:LuaCall(10501,0,"OnEvent_10501",once);--アイテム取得用ハンドラ追加
	--proxy:NotNetMessage_end();
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 10502, "OnEvent_260_1", 5, 0, 2, once );
	proxy:NotNetMessage_end();
	
	
	print("SetRendolState_02 end");
end

function SetRendolState_02Init(proxy, param, chrId )
	print("SetRendolState_02Init begin");
	--王子有効化
	ValidCharactor( proxy, chrId );
	
	proxy:EnableLogic(chrId,true);--王子ロジックON
	proxy:ChangeInitPosAng( chrId , 2150 );--王子の帰還場所を変更
	proxy:Warp( chrId , 2150 );
	proxy:ResetThink( chrId );
	proxy:ForceUpdateNextFrame( chrId );
	--proxy:SendEventRequest( chrId, 0, 10 );	
	--■10501■アイテム取得(会話で呼び出し)■
	--proxy:NotNetMessage_begin();
		proxy:LuaCall(10501,0,"OnEvent_10501",once);--アイテム取得用ハンドラ追加
	--proxy:NotNetMessage_end();
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 10502, "OnEvent_260_1", 2, 0, 2, once );
	proxy:NotNetMessage_end();
	print("SetRendolState_02Init end");
end

function OnEvent_260_1(proxy,param)
	print("OnEvent_260_1 begin");
	proxy:SendEventRequest( 624, 0, AI_EVENT_None );
	print("OnEvent_260_1 end");
end

-------------------------------------------------------------------------------------------------
--王子が探索（王城１）状態--16002
function SetRendolState_03(proxy,param,chrId)
	print("SetRendolState_03 begin");
	
	--王子有効化
	ValidCharactor( proxy, chrId );
	proxy:ChangeInitPosAng( chrId , 2150 );--王子の帰還場所を変更
	
	--移動タイプを往復に変更
	
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	proxy:ForceUpdateNextFrame( chrId );
	proxy:ClearTarget(chrId);
	proxy:ResetThink( chrId );
	
	--移動ポイントを変更
	local point_list = {2010, 2011, 2012, 2013, 2012, 2011, 2014, 2015};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--移動ポイントを設定
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	--レンドル王子が探索だったら一定距離以上離れた時点で次の状態に遷移
	if	proxy:IsClient() == false then
		if	proxy:IsCompleteEvent( 4096 ) == true then
			if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
				--フレームをずらして安全性の確保
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2( 301, "OnEvent_301", 0.0, 0, 2, once );
				proxy:NotNetMessage_end();
			else
				proxy:NotNetMessage_begin();
					proxy:OnPlayerDistanceOut( 301, LOCAL_PLAYER, chrId "OnEvent_301", 20, once );
				proxy:NotNetMessage_end();
			end
		end
	end

	print("SetRendolState_03 end");
end

function SetRendolState_03Init(proxy, param, chrId )
	print("SetRendolState_03Init begin");
	--王子有効化
	ValidCharactor( proxy, chrId );
	proxy:Warp( chrId, 2150);
	proxy:ChangeInitPosAng( chrId , 2150 );--王子の帰還場所を変更
	
	--移動タイプを往復に変更
	
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	proxy:ForceUpdateNextFrame( chrId );
	proxy:ClearTarget(chrId);
	proxy:ResetThink( chrId );
	
	--移動ポイントを変更
	local point_list = {2010, 2011, 2012, 2013, 2012, 2011, 2014, 2015};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--移動ポイントを設定
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	--レンドル王子が探索だったら一定距離以上離れた時点で次の状態に遷移
	if	proxy:IsClient() == false then
		if	proxy:IsCompleteEvent( 4096 ) == true then
			if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
				--フレームをずらして安全性の確保
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2( 301, "OnEvent_301", 0.0, 0, 2, once );
				proxy:NotNetMessage_end();
			else
				proxy:NotNetMessage_begin();
					proxy:OnPlayerDistanceOut( 301, LOCAL_PLAYER, chrId "OnEvent_301", 20, once );
				proxy:NotNetMessage_end();
			end
		end
	end
	print("SetRendolState_03Init end");
end

-------------------------------------------------------------------------------------------------
--王子が敵対（王城１）状態--16003
function SetRendolState_04(proxy,param,chrId)
	print("SetRendolState_04 begin");
	
	proxy:SendEventRequest( 624, 0, AI_EVENT_None );
	--移動タイプを往復に変更
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	proxy:ChangeInitPosAng( chrId , 2150 );--王子の帰還場所を変更
	
	--移動ポイントを変更
	local point_list = {2010, 2011, 2012, 2013, 2012, 2011, 2014, 2015};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--移動ポイントを設定
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( chrId , 5062 );
	--王子有効化
	ValidCharactor( proxy, chrId );
	
	print("SetRendolState_04 end");
end

function SetRendolState_04Init(proxy,param,chrId)
	print("SetRendolState_04Init begin");
	--移動タイプを往復に変更
	proxy:SendEventRequest( 624, 0, AI_EVENT_None );
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	proxy:ChangeInitPosAng( chrId , 2150 );--王子の帰還場所を変更
	proxy:Warp( chrId,2150);
	
	--移動ポイントを変更
	local point_list = {2010, 2011, 2012, 2013, 2012, 2011, 2014, 2015};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--移動ポイントを設定
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( chrId , 5062 );
	--王子有効化
	ValidCharactor( proxy, chrId );
	print("SetRendolState_04Init end");
end


--[[11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
---------------------------------------△△△王城１レンドル王子△△△------------------------------
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111]]




--[[22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
---------------------------------------▽▽▽王城２レンドル王子▽▽▽------------------------------
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222]]
function RendolRegistCondition_block2(proxy,param,chrId)
	print("RendolRegistCondition_block2 begin");
	if	proxy:IsCompleteEvent(RENDOL_STATE_DEAD) == false then
		if	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_2) == false then
		--■723■王子が敵対する■
			if proxy:IsCompleteEvent( 723 ) == false then
				--proxy:OnCharacterTotalDamage( 723, 620, LOCAL_PLAYER, 100, "OnEvent_723", once );
				proxy:OnCharacterTotalRateDamage( 723, 620, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_723", once );
			end
		end
	--■720■レンドルが感謝する■
		--(初期化のタイミングで、監視を追加)

	--■10800■王子が探索を開始する■(会話システムから呼び出し)
		--(王子が感謝状態になったときに、監視を追加)



	--■724■王子が死ぬ■
		if proxy:IsCompleteEvent( 724 ) == false then
			proxy:OnCharacterDead( 724 , 620 , "OnEvent_724" , once );
		end	
	end
	print("RendolRegistCondition_block2 end");
end

-------------------------------------------------------------------------------------------------
--王子が隠れているので助けて状態--16005
function SetRendolState_05(proxy,param,chrId)
	print("SetRendolState_05 begin");
	--proxy:EnableLogic( chrId , false );--レンドル王子ロジックOFF(アイテム渡し待ち?)
	--proxy:SetEventCommand( chrId , 40 );--EzStateに制御番号(怯える)を渡す。
	
--■643■レンドル王子呼びかけ範囲取得■	
	--proxy:SetEventFlag( 643 , 0 );--毎回追加されてほしいので･･･
	SingleReset(proxy,643);
	proxy:NotNetMessage_begin();
		if proxy:IsClient() == false then
			proxy:OnRegionJustIn( 643 , LOCAL_PLAYER , 2340 , "OnEvent_643" , everytime );
			proxy:OnRegionJustOut( 643, LOCAL_PLAYER , 2340 , "OnEvent_643_out" , everytime );
		end
	proxy:NotNetMessage_end();
	
	--王子有効化
	ValidCharactor( proxy, chrId );	
	
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
	--[[
	ValidCharactor( proxy, 102 );
	ValidCharactor( proxy, 103 );
	]]
	print("SetRendolState_05 end");
end

-------------------------------------------------------------------------------------------------
--王子が感謝（王城２）状態--16006
function SetRendolState_06(proxy,param,chrId)
	print("SetRendolState_06 begin");
	--proxy:EnableLogic( chrId , false );--レンドル王子ロジックOFF(アイテム渡し待ち?)
	proxy:SetSpStayAndDamageAnimId( chrId,-1,-1);
	
	if proxy:IsCompleteEvent( 10800 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 10800 , 0 , "OnEvent_10800" , once );--会話システムから呼ぶ場合にはparam=0
		proxy:NotNetMessage_end();
	end
	
	--王子有効化
	ValidCharactor( proxy, chrId );
	
	--[[
	--その場で消えられない様に距離でチェックをかけておく
	if	proxy:IsDistance(LOCAL_PLAYER, 102, 20) == true then
		ValidCharactor( proxy, 102 );
	end
	if	proxy:IsDistance(LOCAL_PLAYER, 103, 20) == true then
		ValidCharactor( proxy, 103 );
	end
	]]
	print("SetRendolState_06 end");
end
-------------------------------------------------------------------------------------------------
--王子が探索（王城２）状態--16007
function SetRendolState_07(proxy,param,chrId)
	print("SetRendolState_07 begin");
	-----------------レンドル王子状態スキップチェック-----------------------
	--王の盾が死んでる
	if	proxy:IsCompleteEvent(4224) == true then
		--既に王の盾が死んでいたので王城３の状態へ
		if	proxy:IsCompleteEvent( 1041 ) == false then
			print("SetRendolState_07 レンドル王子　王の盾が死んでいたので、王城３の状態へ移行");
			SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_LOCATION_INVISIBLE );
			proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "RendolCheck", 0.0, 0, 2, once );
			
		--既に王城３のレバー扉が開いていたので王城４の状態へ
		else
			print("SetRendolState_07 レンドル王子　王城３レバー扉が開いているので、王城４の状態へ移行");
			SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_LIFT_FRONT );
			proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "RendolCheck", 0.0, 0, 2, once );
		end
	end
	
	--王子有効化
	ValidCharactor( proxy, chrId );
	proxy:SetSpStayAndDamageAnimId( chrId,-1,-1);
	--移動タイプを往復に変更
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	
	--移動ポイントを変更
	local point_list = {2220, 2221, 2222, 2223};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--移動ポイントを設定
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	--[[
	--その場で消えられない様に距離でチェックをかけておく
	if	proxy:IsDistance(LOCAL_PLAYER, 102, 20) == true then
		ValidCharactor( proxy, 102 );
	end
	if	proxy:IsDistance(LOCAL_PLAYER, 103, 20) == true then
		ValidCharactor( proxy, 103 );
	end
	]]
	print("SetRendolState_07 end");
end

-------------------------------------------------------------------------------------------------
--王子が敵対（王城２）状態--16008
function SetRendolState_08(proxy,param,chrId)
	print("SetRendolState_08 begin");
	
	print("レンドル王子が敵になりました");
	proxy:EnableLogic( chrId , true );--[[レンドル王子ロジックON(ロジック切り替え?)]]
	--proxy:SetEventCommand( chrId , 41 );--EzStateに制御番号(怯え終了)を渡す。
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( chrId , 5062 );
	--王子有効化
	ValidCharactor( proxy, chrId );
	--[[
	--その場で消えられない様に距離でチェックをかけておく
	if	proxy:IsDistance(LOCAL_PLAYER, 102, 40) == true then
		ValidCharactor( proxy, 102 );
	end
	if	proxy:IsDistance(LOCAL_PLAYER, 103, 40) == true then
		ValidCharactor( proxy, 103 );
	end
	]]
	print("SetRendolState_08 end");
end


--[[22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
---------------------------------------△△△王城２レンドル王子△△△------------------------------
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222]]


--[[33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
---------------------------------------▽▽▽王城３レンドル王子▽▽▽------------------------------
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333]]
function RendolRegistCondition_block3(proxy,param,chrId)
	print("RendolRegistCondition_block3 begin");
	if	proxy:IsCompleteEvent(RENDOL_STATE_DEAD) == false then
		if	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_3_FRONT_GATE) == false and
			proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_3_BACK_GATE) == false then
		--■1316■王子が敵対する(城門前)■
			if proxy:IsCompleteEvent( 1316 ) == false then
				--proxy:OnCharacterTotalDamage( 1316 , 621 , LOCAL_PLAYER , 100 , "OnEvent_1316" , once );
				proxy:OnCharacterTotalRateDamage( 1316, 621, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1316", once );
			end
		
		--■1317■王子が敵対する(城門後ろ)■
			if proxy:IsCompleteEvent( 1317 ) == false then
				--proxy:OnCharacterTotalDamage( 1317 , 621 , LOCAL_PLAYER , 100 , "OnEvent_1317" , once );
				proxy:OnCharacterTotalRateDamage( 1317, 621, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1317", once );
			end
		end


	--■11501■王子が探索を開始する■(会話システムから呼び出し)
		if proxy:IsCompleteEvent( 11501 ) == false then
			proxy:NotNetMessage_begin();
				proxy:LuaCall( 11501 , 0 , "OnEvent_11501" , once );
			proxy:NotNetMessage_end();
		end

		
	--■1318■王子が死亡する■
		if proxy:IsCompleteEvent( 1318 ) == false then
			proxy:OnCharacterDead( 1318, 621, "OnEvent_1318", once );
		end
		
	--■1338■王子会話用領域判定■
		SingleReset( proxy,1338 );
		if proxy:IsCompleteEvent( 1338 ) == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionJustIn( 1338, 621 , 2416 , "OnEvent_1338_in",everytime);
				proxy:OnRegionJustOut( 1338 , 621 , 2416 , "OnEvent_1338_out",everytime);
			proxy:NotNetMessage_end();
		end
		
	end
	print("RendolRegistCondition_block3 end");
end


-------------------------------------------------------------------------------------------------
--王子が見えない場所にこっそり状態--16009
function SetRendolState_09(proxy,param,chrId)
	print("SetRendolState_09 begin");
--■1310■王子が門の前に移動する■
	--必ず追加する
	proxy:SetEventFlag( 1310, false );
	proxy:OnRegionJustIn( 1310 , LOCAL_PLAYER , 2550 , "OnEvent_1310" , once );
--■1312■王子が袋小路に到着したあとに怯えさせる■
	if proxy:IsCompleteEvent( 1312 ) == false then
		proxy:OnRegionJustIn( 1312 , chrId , 2553 , "OnEvent_1312" , once );
	end
--■1349■王子が門の前まで到着したけど、門は閉まっていた
	if	proxy:IsCompleteEvent( 1349 ) == false then
		proxy:OnRegionJustIn( 1349, chrId, 2415, "OnEvent_1349", once );
	end
	--王子有効化
	ValidCharactor( proxy, chrId );
	print("SetRendolState_09 end");
end

-------------------------------------------------------------------------------------------------
--王子が門を開けて欲しい状態--16010
function SetRendolState_10(proxy,param,chrId)
	print("SetRendolState_10 begin");
	--proxy:DisableInterupt( chrId, true );--割り込みを遮断(敵に攻撃されても戦闘ロジックにしないため)

	proxy:ChangeInitPosAng( chrId , 2552 );--巣を門の前の領域にする
	proxy:EnableLogic( chrId , true );--ロジックON
	proxy:SendEventRequest( chrId, 0, AI_EVENT_None );
	proxy:ResetThink( chrId );
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
		proxy:Warp( chrId , 2552 );--初期位置にワープ
	end
	proxy:NotNetMessage_begin();
		----▼王子を追う敵が出現する1▼
		--proxy:OnKeyTime2( 1350 , "OnEvent_1350" , 2.0 , 0 , 1 , once );
		
		--■1312■王子が袋小路に到着したあとに怯えさせる■
		if proxy:IsCompleteEvent( 1312 ) == false then
			proxy:OnRegionJustIn( 1312 , 621 , 2553 , "OnEvent_1312" , once );
		end
	proxy:NotNetMessage_end();
	
	--王子有効化
	ValidCharactor( proxy, chrId );
	print("SetRendolState_10 end");
end

-------------------------------------------------------------------------------------------------
--王子が袋小路で怯え状態--16011
function SetRendolState_11(proxy,param,chrId)
	print("SetRendolState_11 begin");
	proxy:ChangeInitPosAng( chrId , 2553 );--巣を袋小路の領域にする
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
		proxy:ForceUpdateNextFrame( chrId );
		proxy:Warp( chrId , 2553 );--初期位置にワープ
		print("レンドルワープ　2553");
	end
	--proxy:EnableLogic( chrId , false );--ロジックOFF
	--proxy:SetEventCommand( chrId, 40 );--怯える
	proxy:SetSpStayAndDamageAnimId(chrId,7600,9600);
	
	proxy:NotNetMessage_begin();
		proxy:NotNetMessage_begin();
			--▼王子を追う敵の巣を変える1▼
			proxy:OnKeyTime2( 1360 , "OnEvent_1360" ,  5.0 , 0 , 1 , once );		
			--▼王子を追う敵の巣を変える2▼
			proxy:OnKeyTime2( 1361 , "OnEvent_1361" ,  8.0 , 0 , 1 , once );		
			--▼王子を追う敵の巣を変える3▼
			proxy:OnKeyTime2( 1362 , "OnEvent_1362" , 11.0 , 0 , 1 , once );
		proxy:NotNetMessage_end();
		--■1312■王子が袋小路に到着したあとに怯えさせる■
		if proxy:IsCompleteEvent( 1312 ) == false then
			proxy:OnRegionJustIn( 1312 , chrId , 2553 , "OnEvent_1312" , once );
		end
	proxy:NotNetMessage_end();
	
	--王子有効化
	ValidCharactor( proxy, chrId );
	print("SetRendolState_11 end");
end

-------------------------------------------------------------------------------------------------
--王子が感謝（王城３）状態--16012
function SetRendolState_12(proxy,param,chrId)
	print("SetRendolState_12 begin");
	proxy:ChangeInitPosAng( chrId , 2555 );--巣を袋小路の領域にする
	
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
		proxy:Warp( chrId , 2555 );--初期位置にワープ
	end
	--proxy:EnableLogic( chrId, false );--ロジックOFF
	
	proxy:DisableInterupt( chrId, false );--割り込みを有効
	--proxy:SetEventCommand( chrId , 41 );--EzStateに制御番号を送る(怯え終了)
	proxy:SetSpStayAndDamageAnimId(chrId,-1,-1);
	
	--王子有効化
	ValidCharactor( proxy, chrId );
	print("SetRendolState_12 end");
end

-------------------------------------------------------------------------------------------------
--王子が探索（王城３）状態--16013
function SetRendolState_13(proxy,param,chrId)
	print("SetRendolState_13 begin");
	
	--王子有効化
	ValidCharactor( proxy, chrId );
	
	proxy:EnableLogic( chrId , true );--レンドル王子、探索状態で歩き出す
	proxy:ResetThink( chrId );
	proxy:ChangeInitPosAng( chrId , 2555 );--巣を袋小路の領域にする
	proxy:ForceUpdateNextFrame( chrId );
	proxy:ClearTarget(chrId);
	proxy:SendEventRequest( chrId, 0, AI_EVENT_None );
	proxy:SetSpStayAndDamageAnimId(chrId,-1,-1);
	
	
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
		proxy:Warp( chrId , 2555 );--初期位置にワープ
	end
	
	--移動タイプを往復に変更
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	
	--移動ポイントを変更
	local point_list = {2410, 2411, 2412, 2413, 2414};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--移動ポイントを設定
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	
	print("SetRendolState_13 end");
end

-------------------------------------------------------------------------------------------------
--王子が敵対（王城３）城門の前状態--16014
function SetRendolState_14(proxy,param,chrId)
	print("SetRendolState_14 begin");
	proxy:ChangeInitPosAng( chrId , 2552 );--巣を袋小路の領域にする
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 60 ) == false then
		proxy:Warp( chrId , 2552 );--初期位置にワープ
	end
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( chrId , 5063 );
	proxy:EnableLogic( chrId , true );--ロジックON
	proxy:SendEventRequest( chrId , 0 , AI_EVENT_None );--ロジックを切り替えてたのをやめる。
	proxy:SetSpStayAndDamageAnimId(chrId,-1,-1);
	proxy:ResetThink( chrId );
	
	--王子有効化
	ValidCharactor( proxy, chrId );
	print("SetRendolState_14 end");
end

-------------------------------------------------------------------------------------------------
--王子が敵対（王城３）城門の後ろ状態--16015
function SetRendolState_15(proxy,param,chrId)
	print("SetRendolState_15 begin");
	proxy:ChangeInitPosAng( chrId , 2555 );--巣を袋小路の領域にする
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 60 ) == false then
		proxy:Warp( chrId , 2555 );--初期位置にワープ
	end
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( chrId , 5063 );
	proxy:SetSpStayAndDamageAnimId(621,-1,-1);
	proxy:EnableLogic( chrId , true );--ロジックON
	proxy:SendEventRequest( chrId , 0 , AI_EVENT_None );--ロジックを切り替えてたのをやめる。
	proxy:ResetThink( chrId );
	
	--王子有効化
	ValidCharactor( proxy, chrId );
	print("SetRendolState_15 end");
end

--[[33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
---------------------------------------△△△王城３レンドル王子△△△------------------------------
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333]]



--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------▽▽▽王城４レンドル王子▽▽▽------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]
function RendolRegistCondition_block4(proxy,param,chrId)
	print("RendolRegistCondition_block4 begin");
	
	if	proxy:IsCompleteEvent(RENDOL_STATE_DEAD) == false then
	--王城４でのレンドル王子の敵対監視はなくなりました。
--~ 		if	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_4_LIFT_FRONT) == false then
--~ 			--レンドル王子敵対監視
--~ 			--proxy:OnCharacterTotalDamage( 1702, 626, LOCAL_PLAYER, 100, "OnEvent_1702", once );
--~ 			--proxy:OnCharacterTotalRateDamage( 1702, 626, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1702", once );
--~ 		end
		proxy:OnCharacterDead( 1700, 626, "OnEvent_1700", once );
		
		--会話呼び出しハンドラ
		if	proxy:IsCompleteEvent(11790) == false then			
			proxy:LuaCall( 11790, 0, "OnEvent_11790", everytime );
		end
	end
	print("RendolRegistCondition_block4 end");
end

-------------------------------------------------------------------------------------------------
--王子がエレベータ前状態--16016
function SetRendolState_16(proxy,param,chrId)
	print("SetRendolState_16 begin");
	proxy:SetHp( chrId, 0.001);
	
	--王子有効化
	ValidCharactor( proxy, chrId );
	print("SetRendolState_16 end");
end
-------------------------------------------------------------------------------------------------
--王子が敵対（王城４）状態--16017
function SetRendolState_17(proxy,param,chrId)
	print("SetRendolState_17 begin");
	
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	
	--王子有効化
	ValidCharactor( proxy, chrId );
	print("SetRendolState_17 end");
end
-------------------------------------------------------------------------------------------------
--王子が敵対（石柱）状態--16018
function SetRendolState_18(proxy,param,chrId)
	print("SetRendolState_16 begin");
	print("SetRendolState_18 end");
end

--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------△△△王城４レンドル王子△△△------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]


--[[-----------------------------------------------------------------------------------------------------------------------------------------
	レンドル王子関連　ここまで
-----------------------------------------------------------------------------------------------------------------------------------------]]





--[[-----------------------------------------------------------------------------------------------------------------------------------------
	ビヨルングルム関連　ここから
-----------------------------------------------------------------------------------------------------------------------------------------]]
function BiyoCheck(proxy,param)
	BiyoCheck2(proxy,param,true);
end

function BiyoCheck2(proxy,param,flag)
	print("BiyoCheck begin");
	
	local biyo_id_2 = 622;--王城２のビヨルングルム
	local biyo_id_3 = 627;--王城３のビヨルングルム
	local biyo_id_4 = 698;--王城４のビヨルングルム
	
	local biyo_block2_acid_list = { 525, 526, 521, 522, 527 , 530};
	local biyo_block3_acid_list = { 1432, 1433, 1460};
	local biyo_block4_acid_list = { 1711, 1712, 1717};
	
	--王城2のビヨのデフォルトを味方に変更
	proxy:SetTeamType( biyo_id_2 , TEAM_TYPE_Friend );	
	
	--一旦全員消しておく
	InvalidCharactor(proxy,biyo_id_2);
	InvalidCharactor(proxy,biyo_id_3);
	InvalidCharactor(proxy,biyo_id_4);
	
	--監視を一旦全削除
	DeleteConditionList(proxy,biyo_block2_acid_list);
	DeleteConditionList(proxy,biyo_block3_acid_list);
	DeleteConditionList(proxy,biyo_block4_acid_list);
	
	
	
	SetFirstNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_CAPTIVE );
	
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが牢屋に囚われ状態--16060
	if	proxy:IsCompleteEvent(BIYO_STATE_CAPTIVE) == true then
		print("biyo state BIYO_STATE_CAPTIVE");
		SetBiyoState_01(proxy, param, biyo_id_2 );
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが解放してくれて感謝状態--16061
	elseif	proxy:IsCompleteEvent(BIYO_STATE_THANKS) == true then
		print("biyo state BIYO_STATE_THANKS");
		SetBiyoState_02(proxy, param, biyo_id_2 );
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが牢屋で寝ている状態--16062
	elseif	proxy:IsCompleteEvent(BIYO_STATE_SLEEPING_IN_PRISON) == true then
		print("biyo state BIYO_STATE_SLEEPING_IN_PRISON");
		if flag == true then 
			SetBiyoState_03(proxy, param, biyo_id_2 );
		else
			SetBiyoState_03Init(proxy , param , biyo_id_2 );
		end
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);		
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが敵対(牢内)状態--16063
	elseif	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_PRISON) == true then
		print("biyo state BIYO_STATE_HOSTILE_IN_PRISON");
		SetBiyoState_04(proxy, param, biyo_id_2 );
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが死んでいる状態--16064
	elseif	proxy:IsCompleteEvent(BIYO_STATE_DEAD) == true then
		print("biyo state BIYO_STATE_DEAD");
		--ここでは追加も設定もしない
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが獄吏を倒したい状態--16065
	elseif	proxy:IsCompleteEvent(BIYO_STATE_TARGET_ENEMY) == true then
		print("biyo state BIYO_STATE_TARGET_ENEMY");
		SetBiyoState_05(proxy, param, biyo_id_2 );
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが逆襲が終わって満足して寝る状態--16066
	elseif	proxy:IsCompleteEvent(BIYO_STATE_END_OF_STRIKES_BACK) == true then
		print("biyo state BIYO_STATE_END_OF_STRIKES_BACK");
		if flag == true then
			SetBiyoState_06(proxy, param, biyo_id_2 );
		else
			SetBiyoState_06Init(proxy, param, biyo_id_2 );		
		end
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが敵対(城壁)状態--16067
	elseif	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_RAMPART) == true then
		print("biyo state BIYO_STATE_HOSTILE_IN_RAMPART");
		SetBiyoState_07(proxy, param, biyo_id_2 );
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが王城3を探索状態--16068
	elseif	proxy:IsCompleteEvent(BIYO_STATE_SEARCH_3) == true then
		print("biyo state BIYO_STATE_SEARCH_3");
		SetBiyoState_08(proxy, param, biyo_id_3 );
		BiyoRegistCondition_block3(proxy,param,biyo_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが王の剣を倒して満足状態--16069
	elseif	proxy:IsCompleteEvent(BIYO_STATE_KING_OF_SWORD_KILL) == true then
		print("biyo state BIYO_STATE_KING_OF_SWORD_KILL");
		if flag == true then
			SetBiyoState_09(proxy, param, biyo_id_3 );
		else
			SetBiyoState_09Init(proxy, param, biyo_id_3 );
		end
		BiyoRegistCondition_block3(proxy,param,biyo_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが敵対(王の剣の部屋)状態--16070
	elseif	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_KING_ROOM) == true then
		print("biyo state BIYO_STATE_HOSTILE_IN_KING_ROOM");
		SetBiyoState_10(proxy, param, biyo_id_3 );
		BiyoRegistCondition_block3(proxy,param,biyo_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが王の剣の部屋で寝る状態--16071
	elseif	proxy:IsCompleteEvent(BIYO_STATE_KING_ROOM_DOWN) == true then
		print("biyo state BIYO_STATE_KING_ROOM_DOWN");
		SetBiyoState_11(proxy, param, biyo_id_3 );
		BiyoRegistCondition_block3(proxy,param,biyo_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが飛竜の長と戦う状態--16072
	elseif	proxy:IsCompleteEvent(BIYO_STATE_BATTLE_FLY_DRAGON) == true then
		print("biyo state BIYO_STATE_BATTLE_FLY_DRAGON");
		SetBiyoState_12(proxy, param, biyo_id_4 );
		BiyoRegistCondition_block4(proxy,param,biyo_id_4);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが石柱に戻りたい状態--16073
	elseif	proxy:IsCompleteEvent(BIYO_STATE_RETURN_TO_STONE_PILLAR) == true then
		print("biyo state BIYO_STATE_RETURN_TO_STONE_PILLAR");
		SetBiyoState_13(proxy, param, biyo_id_4 );
		BiyoRegistCondition_block4(proxy,param,biyo_id_4);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが石柱にいる状態--16074
	elseif	proxy:IsCompleteEvent(BIYO_STATE_WAIT_M1) == true then
		print("biyo state BIYO_STATE_WAIT_M1");
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが敵対(石柱)状態--16075
	elseif	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_STONE_PILLAR) == true then
		print("biyo state BIYO_STATE_HOSTILE_IN_STONE_PILLAR");
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが敵対(ゲート前)状態--16076
	elseif	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_GATE_FRONT) == true then
		print("biyo state BIYO_STATE_HOSTILE_IN_GATE_FRONT");
		SetBiyoState_16(proxy, param, biyo_id_4 );
		BiyoRegistCondition_block4(proxy,param,biyo_id_4);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムがもういない状態--16077
	elseif	proxy:IsCompleteEvent(BIYO_STATE_EXIT) == true then
		print("biyo state BIYO_STATE_EXIT");
	end
	
	print("BiyoCheck end");
end

--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------▽▽▽王城２ビヨルングルム▽▽▽------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]

function BiyoRegistCondition_block2(proxy,param,chrId)
	print("BiyoRegistCondition_block2 begin");
	if	proxy:IsCompleteEvent( BIYO_STATE_DEAD ) == false then
		if	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_PRISON ) == false and
			proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_RAMPART) == false then
			
			--■525■ビヨが牢内で敵になる■
			if proxy:IsCompleteEvent( 525 ) == false then
				--proxy:OnCharacterTotalDamage( 525 , 622 , LOCAL_PLAYER , 100 , "OnEvent_525" , once );
				proxy:OnCharacterTotalRateDamage( 525, 622, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_525", once );
			end
			
			--■526■ビヨが城壁で敵になる■
			if proxy:IsCompleteEvent( 526 ) == false then
				--proxy:OnCharacterTotalDamage( 526 , 622 , LOCAL_PLAYER , 100 , "OnEvent_526" , once );
				proxy:OnCharacterTotalRateDamage( 526, 622, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_526", once );
			end
		end

		--■521■ビヨが獄吏を倒しに行く■(会話システムから呼び出し)
		if proxy:IsCompleteEvent( 521 ) == false then
				proxy:LuaCall( 521 , 0 , "OnEvent_521" , once );--会話システムから呼び出す場合はparam=0を指定
		end
		--■522■ビヨが牢屋内で寝る■(会話システムから呼び出し)
		if proxy:IsCompleteEvent( 522 ) == false then
				proxy:LuaCall( 522 , 0 , "OnEvent_522" , once );--会話システムから呼び出す場合はparam=0を指定
		end

		--■527■ビヨ死亡■
		if proxy:IsCompleteEvent( 527 ) == false then
			proxy:OnCharacterDead(527,622,"OnEvent_527",once);
		end
		
		--■530■ビヨが逆襲に満足して寝る■(会話システムから呼び出し)
		proxy:LuaCall( 530, 0, "OnEvent_530", everytime );--会話システムから呼び出す場合はparam=0を指定
	end
	print("BiyoRegistCondition_block2 end");
end


----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが牢屋に囚われ状態--16060
function SetBiyoState_01(proxy,param,chrId)
	print("SetBiyoState_01 begin");
	ValidCharactor( proxy, chrId );
	print("SetBiyoState_01 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが解放してくれて感謝状態--16061
function SetBiyoState_02(proxy,param,chrId)
	print("SetBiyoState_02 begin");
	ValidCharactor( proxy, chrId );
	proxy:SetTeamType( chrId , TEAM_TYPE_BattleFriend );
	print("SetBiyoState_02 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが牢屋で寝ている状態--16062
function SetBiyoState_03(proxy,param,chrId)
	print("SetBiyoState_03 begin");
	--王の剣が既に死んでいる
	if	proxy:IsCompleteEvent(4360) == true then
		print("SetBiyoState_03 王の剣が死んでいるので飛び級");
		--飛竜の長の状態が死んでいるとき
		if	proxy:IsCompleteEvent(TYO_STATE_DEAD) == true then
			print("SetBiyoState_03 飛竜の長が死んでいるので、もういない状態へ");
			SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_EXIT );
			proxy:SetEventFlag( 529, true);
		else
			print("SetBiyoState_03 飛竜の長が生きているので、飛竜の長と戦う状態へ");
			SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_BATTLE_FLY_DRAGON );
		end
	else
		--ビヨの状態を「王城3を探索」にする
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_SEARCH_3 );
		--状態を変えたので再チェック
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "BiyoCheck", 0.0, 0, 2, once );
		proxy:NotNetMessage_begin();
	end
	print("SetBiyoState_03 end");
end

-------------------------------------------------------------------------------------------------
--ビヨルングルムが牢屋で寝ている状態初期化チェック--16062
function SetBiyoState_03Init(proxy,param,chrId)
	print("SetBiyoState_03Init begin");
	ValidCharactor( proxy, chrId );--有効に
	print("SetBiyoState_03Init end");
end

-------------------------------------------------------------------------------------------------
--ビヨルングルムが敵対(牢内)状態--16063
function SetBiyoState_04(proxy,param,chrId)
	print("SetBiyoState_04 begin");
	ValidCharactor( proxy, chrId );
	proxy:EraseEventSpecialEffect_2(chrId,5064);
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	print("SetBiyoState_04 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが獄吏を倒したい状態--16065
function SetBiyoState_05(proxy,param,chrId)
	print("SetBiyoState_05 begin");
	ValidCharactor( proxy, chrId );
	proxy:SetTeamType( chrIs , TEAM_TYPE_BattleFriend );	
	print("SetBiyoState_05 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが逆襲が終わって満足して寝る状態--16066
function SetBiyoState_06(proxy,param,chrId)
	print("SetBiyoState_06 begin");
	--王の剣が既に死んでいる
	if	proxy:IsCompleteEvent(4360) == true then
		print("SetBiyoState_06 王の剣が死んでいるので飛び級");
		--飛竜の長の状態が死んでいるとき
		if	proxy:IsCompleteEvent(TYO_STATE_DEAD) == true then
			print("SetBiyoState_06 飛竜の長が死んでいるので、もういない状態へ");
			SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_EXIT );
			proxy:SetEventFlag( 529, true);
		else
			print("SetBiyoState_06 飛竜の長が生きているので、飛竜の長と戦う状態へ");
			SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_BATTLE_FLY_DRAGON );
		end
	else
		--ビヨの状態を「王城3を探索」にする
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_SEARCH_3 );
		--状態を変えたので再チェック
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "BiyoCheck", 0.0, 0, 2, once );
		proxy:NotNetMessage_begin();
	end
	print("SetBiyoState_06 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが逆襲が終わって満足して寝る状態用の初期化--16066
function SetBiyoState_06Init(proxy,param,chrId)
	print("SetBiyoState_06Init beign");
	ValidCharactor( proxy, chrId );--有効に
	print("SetBiyoState_06Init end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが敵対(城壁)状態--16067
function SetBiyoState_07(proxy,param,chrId)
	print("SetBiyoState_07 begin");
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2(chrId,5064);
	ValidCharactor( proxy, chrId );
	print("SetBiyoState_07 end");
end



--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------△△△王城２ビヨルングルム△△△------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]


--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------▽▽▽王城３ビヨルングルム▽▽▽------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]
function BiyoRegistCondition_block3(proxy,param,chrId)
	print("BiyoRegistCondition_block3 begin");
	if	proxy:IsCompleteEvent( BIYO_STATE_DEAD ) == false then
		proxy:OnCharacterDead( 1433, 627, "OnEvent_1433", once );
		if proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_KING_ROOM) == false then
			--proxy:OnCharacterTotalDamage( 1432, 627, LOCAL_PLAYER, 100, "OnEvent_1432", once );
			proxy:OnCharacterTotalRateDamage( 1432, 627, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1432", once );
			if proxy:IsCompleteEvent(1470) == false then
				proxy:OnRegionJustIn( 1470 , LOCAL_PLAYER , 2581 , "OnEvent_1470",once );
			end
		end
		--■1460■ビヨが獄吏を倒しに行く■(会話システムから呼び出し)
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 1460 , 0 , "OnEvent_1460" , everytime );--会話システムから呼び出す場合はparam=0を指定
		proxy:NotNetMessage_end();
	end
	print("BiyoRegistCondition_block3 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが王城3を探索状態--16068
function SetBiyoState_08(proxy,param,chrId)
	print("SetBiyoState_08 begin");
	proxy:EnableLogic( chrId,false );	
	ValidCharactor( proxy, chrId );	
	print("SetBiyoState_08 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが王の剣を倒して満足状態--16069
function SetBiyoState_09(proxy,param,chrId)
	print("SetBiyoState_09 begin");
	ValidCharactor( proxy, chrId );
	--ValidCharactor( proxy, 627 );	
--~ 	if	proxy:IsDistance( chrId, LOCAL_PLAYER, 20 ) == false then
--~ 		proxy:Warp( chrId, 2580 );
--~ 	end
	
	print("SetBiyoState_09 Param3 = ",param:GetParam3() );
	--ポイントが違う場合は特に何もしない
	if	param:GetParam3() == 2590 then
		print("SetBiyoState_09 Param return end");
		return;
	end

	--飛竜の長が死んでいるか？
	if	proxy:IsCompleteEvent(TYO_STATE_DEAD) == true then
		print("SetBiyoState_09 飛竜の長が死んでいるので、もういない状態へ");
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_EXIT );
		proxy:SetEventFlag( 1462, true );
		proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "BiyoCheck", 0.0, 0, 2, once );
	else
		print("SetBiyoState_09 飛竜の長が生きているので、飛竜の長と戦う状態へ");
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_BATTLE_FLY_DRAGON );
		proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "BiyoCheck", 0.0, 0, 2, once );
	end
	
	print("SetBiyoState_09 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが王の剣を倒して満足状態用の初期化--16069
function SetBiyoState_09Init(proxy,param,chrId)
	print("SetBiyoState_09Init begin");
	ValidCharactor( proxy, chrId );
	print("SetBiyoState_09Init end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが敵対(王の剣の部屋)状態--16070
function SetBiyoState_10(proxy,param,chrId)
	print("SetBiyoState_10 begin");
	ValidCharactor( proxy, chrId );
	--proxy:Warp( chrId, 2580 );
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2(chrId,5064);
	print("SetBiyoState_10 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが王の剣の部屋で寝る状態--16071
function SetBiyoState_11(proxy,param,chrId)
	print("SetBiyoState_11 begin");
	print("SetBiyoState_11 end");
end

--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------△△△王城３ビヨルングルム△△△------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]


--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------▽▽▽王城４ビヨルングルム▽▽▽------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]
function BiyoRegistCondition_block4(proxy,param,chrId)
	print("BiyoRegistCondition_block4 begin");
	if	proxy:IsCompleteEvent( BIYO_STATE_HOSTILE_IN_GATE_FRONT) == false then
		--proxy:OnCharacterTotalDamage( 1711, chrId, LOCAL_PLAYER, 100, "OnEvent_1711", once );
		proxy:OnCharacterTotalRateDamage( 1711, chrId, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1711", once );
	end
	
	--■1717■ビヨが寝る■(会話システムから呼び出し)
	proxy:LuaCall( 1717, 0, "OnEvent_1717", everytime );--会話システムから呼び出す場合はparam=0を指定
	
	--■1790■飛竜の情報をビヨルングルムに教える
	proxy:OnRegistFunc( 1790, "Condition_1790", "dummy", 2, once );

	proxy:OnCharacterDead( 1712, chrId, "OnEvent_1712", once );

	print("BiyoRegistCondition_block4 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが飛竜の長と戦う状態--16072
function SetBiyoState_12(proxy,param,chrId)
	print("SetBiyoState_12 begin");
	if	proxy:IsCompleteEvent( TYO_STATE_DEAD ) == true then
		SetNpcStateFlag(proxy, param, biyo_flag_list, BIYO_STATE_EXIT);
		proxy:SetEventFlag( 1716, true );
		proxy:OnKeyTime2(SYSTEM_CHECK_POINT, "BiyoCheck", 0.0, 0, 2, once);
	end
	ValidCharactor( proxy, chrId );
	print("SetBiyoState_12 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが石柱に戻りたい状態--16073
function SetBiyoState_13(proxy,param,chrId)
	print("SetBiyoState_13 begin");
	ValidCharactor( proxy, chrId );
	print("SetBiyoState_13 end");
end


----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが敵対(ゲート前)状態--16076
function SetBiyoState_16(proxy,param,chrId)
	print("SetBiyoState_16 begin");
	ValidCharactor( proxy, chrId );
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2(chrId,5064);
	print("SetBiyoState_16 end");
end
--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------△△△王城４ビヨルングルム△△△------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]


--[[-----------------------------------------------------------------------------------------------
---------------------------------------▽▽▽石柱ビヨルングルム▽▽▽------------------------------
-----------------------------------------------------------------------------------------------]]

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが石柱にいる状態--16074
function SetBiyoState_14(proxy,param,chrId)
	print("SetBiyoState_14 begin");
	print("SetBiyoState_14 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが敵対(石柱)状態--16075
function SetBiyoState_15(proxy,param,chrId)
	print("SetBiyoState_15 begin");
	print("SetBiyoState_15 end");
end

--[[-----------------------------------------------------------------------------------------------
---------------------------------------△△△石柱ビヨルングルム△△△------------------------------
-----------------------------------------------------------------------------------------------]]


--[[-----------------------------------------------------------------------------------------------------------------------------------------
	ビヨルングルム関連　ここまで
-----------------------------------------------------------------------------------------------------------------------------------------]]


--[[-----------------------------------------------------------------------------------------------------------------------------------------
	飛竜の眷属関連　ここから
-----------------------------------------------------------------------------------------------------------------------------------------]]

--■236■飛竜の眷属の表示切替
--■807■飛竜の眷属の表示切替
function HiryuKenzokuCheck(proxy,param)
	print("HiryuKenzokuCheck begin");
--■飛竜(眷属)イベント関連初期化

	--初期状態をセット(状態が未設定の場合、指定した状態をセットする)
	SetFirstNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_WARNING );
	
	--local regionId	   = param:GetParam3();--領域のイベントID
	local block_id		= param:GetParam2();
	local kenzoku_id_1 = 301;--王城１の飛流の眷属
	local kenzoku_id_2 = 110;--王城２の飛流の眷属
	
	local kenzoku_block1_acid_list = { 190, 191, 199, 221, 230, 231, 232, 233, 234};
	local kenzoku_block2_acid_list = { 805, 800, 801, 802, 803, 804, 806};
	
	proxy:AddFieldInsFilter(kenzoku_id_1);
	proxy:AddFieldInsFilter(kenzoku_id_2);
	
	--一旦全員消しておく
	InvalidCharactor(proxy,kenzoku_id_1);
	InvalidCharactor(proxy,kenzoku_id_2);
	
	--監視を一旦全削除
	DeleteConditionList(proxy,kenzoku_block1_acid_list);
	DeleteConditionList(proxy,kenzoku_block2_acid_list);
	
	--常時バックリードOFF
	proxy:SetAlwayEnableBackread_forEvent( kenzoku_id_1, false );
	proxy:SetAlwayEnableBackread_forEvent( kenzoku_id_2, false );
	
	--強制更新解除
	LuaFunc_NormalOmission( proxy, kenzoku_id_1 );
	LuaFunc_NormalOmission( proxy, kenzoku_id_2 );
	
	--飛竜の眷属が生きている
	if	proxy:IsCompleteEvent(KENZOKU_2_STATE_DEAD) 			== false and
		proxy:IsCompleteEvent(KENZOKU_STATE_DEAD) 				== false then
		
		--王城１用のチェックポイントか？
		if	block_id == 0 then
			
			--■35■QWCによる飛竜の無効化
			if	proxy:IsCompleteEvent(35) == false then
				--撤退では無い
				if proxy:IsCompleteEvent( KENZOKU_STATE_ESCAPE ) == false then
					--初期化
					proxy:SetDisableGravity( kenzoku_id_1 , true );--重力OFF
					proxy:EnableLogic( kenzoku_id_1 , false );--思考OFF
					proxy:SetSuperArmor( kenzoku_id_1 , true );--ダメージモーションさせない
					proxy:SetDeadMode( kenzoku_id_1, true);--飛竜は死なない設定(死にそうになったら撤退する)
					proxy:SetAlwayEnableBackread_forEvent( kenzoku_id_1, true );
					LuaFunc_ForceOmission(proxy, kenzoku_id_1 );
					proxy:ForcePlayLoopAnimation( kenzoku_id_1 , 0 );--警戒しているアニメループ再生
					if proxy:IsClient() == false then
						proxy:RequestForceUpdateNetwork(kenzoku_id_1);
					end
					ValidCharactor( proxy, kenzoku_id_1 );
					
					--王城１飛竜管理用アクションID:199(イベントで自由に使えるアクションID)
					SingleReset( proxy, 199 );
					if	proxy:IsClient() == false then
						--レバーが惹かれていたら阻止諦め、そうでなければ通常の巣にいる状態へ
						if	proxy:IsCompleteEvent( 0 ) == true then
							SetNpcStateFlag( proxy, param, kenzoku_flag_list, KENZOKU_STATE_WARNING_AND_LEVER );
						else
							SetNpcStateFlag( proxy, param, kenzoku_flag_list, KENZOKU_STATE_WARNING );
						end
						
					end
					
					--■234■飛竜(眷属)の撤退監視(25%以下で撤退)■
					SingleReset( proxy, 234 );
					proxy:NotNetMessage_begin();
						proxy:OnCharacterHP( 234 , kenzoku_id_1 , "OnEvent_234" , 0.25 , once );
						proxy:LuaCall( 234, 2, "OnEvent_234_1", everytime );
					proxy:NotNetMessage_end();
					
					if	proxy:IsCompleteEvent( 234 ) == false then					
						if	proxy:IsClient() == false then
							proxy:NotNetMessage_begin();
							proxy:OnKeyTime2( 199, "OnEvent_199", 0.0, 0, 2, once );
							proxy:NotNetMessage_end();
						end
						
						proxy:LuaCall( 199, 1, "OnEvent_199_default", everytime );
						proxy:LuaCall( 221, 1, "OnEvent_221_1", everytime );
						proxy:LuaCall( 221, 2, "OnEvent_221_2", everytime );
						proxy:LuaCall( 190, 1, "OnEvent_190_1", everytime );
						proxy:LuaCall( 190, 2, "OnEvent_190_2", everytime );
						proxy:LuaCall( 191, 1, "OnEvent_191_1", everytime );
						proxy:LuaCall( 191, 2, "OnEvent_191_2", everytime );
						proxy:LuaCall( 230, 1, "OnEvent_230_1", everytime );
						proxy:LuaCall( 230, 2, "OnEvent_230_2", everytime );
						proxy:LuaCall( 231, 1, "OnEvent_231_1", everytime );
						proxy:LuaCall( 231, 2, "OnEvent_231_2", everytime );
						proxy:LuaCall( 232, 1, "OnEvent_232_1", everytime );
						proxy:LuaCall( 232, 2, "OnEvent_232_2", everytime );
					end
				end
			end
		--王城２用のチェックポイントか？
		elseif	block_id == 1 then
		--elseif	regionId == 2390 or regionId == 2391 then
			proxy:SetAlwayEnableBackread_forEvent( kenzoku_id_2, true );
			LuaFunc_ForceOmission(proxy, kenzoku_id_2 );
			--飛竜のアニメ再生のトリガー(最初からずっととんでいる)
			if proxy:IsClient() == false then
				--ホストの飛竜アニメループ開始
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2( 800 , "OnEvent_800" , 0.0 , 0 , 1 , once );
				proxy:NotNetMessage_end();
				--更新権限はホストが管理
				--ここではホストが権限を持つと、ネットワークの座標同期の問題でクライアント側での見た目が悪くなる為、
				--権限を固定しません。
				--proxy:RequestForceUpdateNetwork(kenzoku_id_2);
			end
			
			--■800■飛竜の眷属２が元気に飛び回る■	
			--■801■飛竜の眷属２が領域Aをブレス攻撃■	
			--■802■飛竜の眷属２が領域Bをブレス攻撃■
			--■803■飛竜の眷属２が領域Cをブレス攻撃■	
			--■804■飛竜の眷属２がヘロヘロになりながら飛び回る■
			--■805■飛竜の眷属２がヘロヘロになる■
			--■806■飛竜の眷属２が死ぬ■(実際には死に待ち状態)
			
			--▼飛竜アニメの同期再生用▼
			proxy:LuaCall( 800 , 1 , "OnEvent_800_syncro_anime"   , everytime );--待機
			proxy:LuaCall( 800 , 2 , "OnEvent_800_2_syncro_anime" , everytime );--待機2
			proxy:LuaCall( 800 , 3 , "OnEvent_800_3_syncro_anime" , everytime );--死亡待機
			proxy:LuaCall( 801 , 1 , "OnEvent_801_syncro_anime" , everytime );--ブレスA
			proxy:LuaCall( 802 , 1 , "OnEvent_802_syncro_anime" , everytime );--ブレスB
			proxy:LuaCall( 803 , 1 , "OnEvent_803_syncro_anime" , everytime );--ブレスC
			proxy:LuaCall( 804 , 1 , "OnEvent_804_syncro_anime" , everytime );--ヘロヘロ
			proxy:LuaCall( 806 , 1 , "OnEvent_806_syncro_anime" , everytime );--死亡		
			--[[
			if proxy:IsCompleteEvent( 805 ) == false then
				proxy:OnCharacterHP( 805 , kenzoku_id_2 , "OnEvent_805" , 0.5 , once );
			end
			]]
			if proxy:IsCompleteEvent( 806 ) == false then
				proxy:OnCharacterHP( 806 , kenzoku_id_2 , "OnEvent_806" , 0.01 , once );
			end

			
			proxy:EnableLogic( kenzoku_id_2, false );
			ValidCharactor( proxy, kenzoku_id_2 );
		end
	end
	
	print("HiryuKenzokuCheck end");
	
	--王城１の長の描画を制限します
	print("HiryuOsa DrawCheck　begin");
	if block_id == 0 then
		if	proxy:IsCompleteEvent(35) == false then
			if 	proxy:IsCompleteEvent( TYO_STATE_DEAD ) == false and	--死んでない
				proxy:IsCompleteEvent( TYO_STATE_ESCAPE ) == false then		--撤退してない
				--有効
				ValidCharactor(proxy,300);
				print("広場長有効中です");
			else
				print("広場長　死亡なので無効中です");
				InvalidCharactor(proxy,300);
			end
		else
			print("広場長　QWCで無効中です");
			InvalidCharactor(proxy,300);
		end
	else
		--無効
		InvalidCharactor(proxy,300);
		print("広場長ブロック外無効中です")
	end
	print("HiryuOsa DrawCheck　end");
end




--[[-----------------------------------------------------------------------------------------------------------------------------------------
	飛竜の眷属関連　ここまで
-----------------------------------------------------------------------------------------------------------------------------------------]]


--[[-----------------------------------------------------------------------------------------------------------------------------------------
	飛竜の長関連　ここから
-----------------------------------------------------------------------------------------------------------------------------------------]]


function HiryuOsaCheck(proxy,param)
	print("HiryuOsaCheck begin");
	
	--初期状態をセット(状態が未設定の場合、指定した状態をセットする)
	SetFirstNpcStateFlag( proxy , param , tyo_flag_list , TYO_STATE_WARNING_AISLE );
	SetFirstNpcStateFlag( proxy , param , tyo1_flag_list , TYO_STATE_SLEEPING );
	
	proxy:DeleteEvent(220);
	proxy:DeleteEvent(235);
	proxy:DeleteEvent(1770);

	--InvalidCharactor(proxy,300);
	InvalidCharactor(proxy,501);
	if	proxy:IsCompleteEvent(TYO_STATE_DEAD)	== true then
		print("HiryuOsaCheck state check end");
		return;
	end
	
	--常時バックリードOFF
	proxy:SetAlwayEnableBackread_forEvent( 300, false );
	proxy:SetAlwayEnableBackread_forEvent( 501, false );
	
	--強制更新解除
	LuaFunc_NormalOmission( proxy, 300 );
	LuaFunc_NormalOmission( proxy, 501 );
	
		
	--王城１の飛竜の長
	--QWC判定チェック
	if	proxy:IsCompleteEvent(35) == false then
		if proxy:IsCompleteEvent(TYO_STATE_ESCAPE) == false then--撤退してない
			if 	proxy:IsCompleteEvent( TYO_STATE_DEAD ) == false then
				--ValidCharactor(proxy, 300 );
				proxy:SetAlwayEnableBackread_forEvent( 300, true );
				LuaFunc_ForceOmission(proxy, 300 );
				--王城１の飛竜の長
				proxy:PlayLoopAnimation(300,7000);
				proxy:EnableLogic(300, false);
				proxy:Warp( 300, 2055 );
				--■220■飛竜(長)が寝ている■
				SingleReset(proxy, 220);
				proxy:OnRegionIn( 220 , LOCAL_PLAYER , 2130 , "OnEvent_220" , everytime );
						
				--■235■飛竜(長)の死亡監視■
				proxy:NotNetMessage_begin();
					--proxy:OnCharacterDead( 235 , 300 , "OnEvent_235" , once );
					proxy:OnCharacterHP( 235 , 300 , "OnEvent_235" , 0.01 , once );
				proxy:NotNetMessage_end();
			end
		end
	end
	

	--王城４の飛竜の長
	if 	proxy:IsCompleteEvent( 4480 ) ==false and --ボスが生きているとき
		proxy:IsCompleteEvent( TYO_STATE_DEAD ) == false then --長が死んでない時
		ValidCharactor(proxy, 501 );
		
		--DeleteEventで消されてしまうので退去
		if proxy:IsCompleteEvent( 1560 ) == false then--登場ポリ劇見ていなかったら
		
			InvalidCharactor( proxy , 501 );--飛竜いない
			
			--演出用(?)のOBJを無効化(描画･当たりOFF)しておく
			proxy:SetDrawEnable( 1720 , false );
			proxy:SetColiEnable( 1720 , false );
			
			proxy:SetDrawEnable( 1721 , false );
			proxy:SetColiEnable( 1721 , false );
			
			proxy:SetDrawEnable( 1710 , false );
			proxy:SetColiEnable( 1710 , false );
			
			proxy:SetDrawEnable( 1711 , false );
			proxy:SetColiEnable( 1711 , false );
		else
		
			--▼飛竜が再生するアニメの判定用トリガー(生存orグレイのみ)▼
			if proxy:IsClient() == false then
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2( 1590 , "OnEvent_1590" , 0.0 , 0 , 1 , once );
				proxy:NotNetMessage_end();
			end
			
			--演出用(?)のOBJを有効化/無効化する
			proxy:SetDrawEnable( 1720 , true );
			proxy:SetColiEnable( 1720 , true );
			
			proxy:SetDrawEnable( 1721 , true );
			proxy:SetColiEnable( 1721 , true );
			
			proxy:SetDrawEnable( 1700 , false );
			proxy:SetColiEnable( 1700 , false );
			
			proxy:SetDrawEnable( 1701 , false );
			proxy:SetColiEnable( 1701 , false );
		end
		--初期化
		proxy:SetDisableGravity( 501 , true );--重力OFF
		proxy:EnableLogic( 501 , false );--思考OFF
		proxy:SetSuperArmor( 501 , true );--ダメージモーションさせない
		proxy:SetDeadMode(501, true);--飛竜は死なない設定(死にそうになったら撤退する)
		proxy:SetAlwayEnableBackread_forEvent( 501, true );
		LuaFunc_ForceOmission(proxy, 501 );
		
		--■1770■飛竜の長が仮死状態■
		if	proxy:IsCompleteEvent( 1770 ) == false then
			proxy:OnCharacterHP( 1770 , 501 , "OnEvent_1770" , 0.01 , once );
		end
		
	end
	print("HiryuOsaCheck end");
end

--[[-----------------------------------------------------------------------------------------------------------------------------------------
	飛竜の長関連　ここまで
-----------------------------------------------------------------------------------------------------------------------------------------]]




--■60■ミラルダ死亡処理■
function OnEvent_60(proxy, param)
	print("OnEvent_60 begin");
	print("ミラルダは死亡しました。");
	proxy:SetEventFlag( 60, true );
	print("OnEvent_60 end");
end

--■62■ブラックミラルダ死亡■
function OnEvent_62(proxy,param)
	print("OnEvent_62 begin");
	proxy:SetEventFlag(62, true);
	print("OnEvent_62 end");
end

--■15635■ミラルダ黒の死体をしらべた■
function OnEvent_15635(proxy,param)
	print("OnEvent_15635 begin");
	proxy:SetEventFlag( 15635 , true );
	print("OnEvent_15635 end");
end

--■86■ミラルダ会話用フラグON■
function OnEvent_86(proxy,param)
	print("OnEvent_86 begin");
	proxy:SetEventFlag( 86,true );
	print("OnEvent_86 end");
end

--■15605■ミラルダの死体調べた■
function OnEvent_15605(proxy,param)
	print("OnEvent_15605 begin");
	proxy:SetEventFlag( 15605 , true );
	print("OnEvent_15605 end");
end

------------------------------
--奴隷兵士ショップの状態変化--
------------------------------
--▼奴隷兵士が王城1で敵対する▼--
function OnEvent_341(proxy, param)
	print("OnEvent_341 begin");

	--ロジックOn
	proxy:EnableLogic( 691, true );
	
	--奴隷兵士の状態を敵対(王城1)にする
	SetNpcStateFlag(proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_HOSTILE01);
	--奴隷兵士のチームタイプを変更する
	proxy:SetTeamType( 691, TEAM_TYPE_AngryFriend );

	--フラグを立てる
	proxy:SetEventFlag( 341, true );
	
	print("OnEvent_341 end");
end
--▲-------------------------▲--


--▼奴隷兵士が死亡する(王城1)▼--
function OnEvent_342(proxy, param)
	print("OnEvent_342 begin");

	--奴隷兵士の状態を「死亡」に変える
	SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_DEAD );
	
	--フラグを立てる
	proxy:SetEventFlag( 342, true );
	
	--敵に削られて敵対を通り越して死亡もありえるので、ここでも削除
	--死んだら敵対にはならないので削除
	proxy:DeleteEvent( 341 );
	proxy:DeleteEvent( 760 );
	proxy:DeleteEvent( 1441 );

	print("OnEvent_342 end");
end

--▲-------------------------▲--


--[[▼奴隷兵士が死亡する(王城3)▼--
function OnEvent_1441(proxy, param)
	print("OnEvent_1441 begin");

	--奴隷兵士の状態を「死亡」に変える
	SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_DEAD );
	
	--フラグを立てる
	proxy:SetEventFlag( 1441, true );
	
	--敵に削られて敵対を通り越して死亡もありえるので、ここでも削除
	--死んだら敵対にはならないので削除
	proxy:DeleteEvent( 341 );
	proxy:DeleteEvent( 760 );
	proxy:DeleteEvent( 1441 );

	print("OnEvent_1441 end");
end

--▲-------------------------▲--]]

--[[
function OnEvent_343(proxy, param) proxy:LuaCallStart(781, 1); end
function OnEvent_344(proxy, param) proxy:LuaCallStart(781, 1); end
function OnEvent_345(proxy, param) proxy:LuaCallStart(781, 1); end
function OnEvent_780(proxy, param) proxy:LuaCallStart(781, 1); end
]]


function OnEvent_781(proxy, param)
	print("OnEvent_781 begin");
	print("JustInCheckPoint");
	
	local DoreiShop01_id = 691;
	local DoreiShop02_id = 623;
	local DoreiShop03_id = 679;
	
	local DoreiShopBlock1_acid_list = {340,341,342};
	local DoreiShopBlock2_acid_list = {760,761,762};
	local DoreiShopBlock3_acid_list = {1440,1441};
	
	--一旦3体とも消える
	InvalidCharactor(proxy,DoreiShop01_id);
	InvalidCharactor(proxy,DoreiShop02_id);
	InvalidCharactor(proxy,DoreiShop03_id);
	
	if proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork( DoreiShop01_id);
		proxy:RequestForceUpdateNetwork( DoreiShop02_id);
		proxy:RequestForceUpdateNetwork( DoreiShop03_id);
	end
	
	--ブロックの監視を削除
	DeleteConditionList(proxy,DoreiShopBlock1_acid_list);
	DeleteConditionList(proxy,DoreiShopBlock2_acid_list);
	DeleteConditionList(proxy,DoreiShopBlock3_acid_list);
	
	
	--取りあえず初期状態を設定
	SetFirstNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_SELL01 );
	
	
	--奴隷兵士が王城2に移動する
	if proxy:IsCompleteEvent( DOREISOL_SHOP_SELL01 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_SELL01");
		SetDoreiShopState01(proxy, param);
		RegistConditionBlock01(proxy,param);

	--奴隷兵士が王城1で敵対
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE01 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_HOSTILE01");
		SetDoreiShopState02(proxy, param);
		RegistConditionBlock01(proxy,param);

	--奴隷兵士が死亡した
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_DEAD ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_DEAD");
		SetDoreiShopState03(proxy, param);
		RegistConditionBlock01(proxy,param);

	--奴隷兵士が王城3に移動する
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_SELL02 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_SELL02");
		SetDoreiShopState04(proxy, param);
		RegistConditionBlock02(proxy,param);

	--奴隷兵士が王城2で敵対している
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE02 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_HOSTILE02");
		SetDoreiShopState05(proxy, param);
		RegistConditionBlock02(proxy,param);

	--奴隷兵士が販売している
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_SELL03 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_SELL03");
		SetDoreiShopState06(proxy, param);
		RegistConditionBlock03(proxy,param);

	--奴隷兵士が王城3で敵対している
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE03 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_HOSTILE03");
		SetDoreiShopState07(proxy, param);
		RegistConditionBlock03(proxy,param);
	end

	print("OnEvent_781 end");
end

--▼奴隷兵士が販売している(王城1)▼-----------------------------------------
function SetDoreiShopState01( proxy, param )
	--ファランクスが生きている
	if proxy:IsCompleteEvent( 4096 ) == false then
		ValidCharactor(proxy,691);--王城1にいる奴隷兵士を有効化
	
	--ファランクスが死んでいる
	else
		print("DoreiShop NowState DOREISOL_SHOP_SELL01 > Chenge to DOREISOL_SHOP_SELL02");
		InvalidBackRead(proxy,691);--王城1にいる奴隷兵士を無効化
		ValidCharactor(proxy,623);--王城2にいる奴隷兵士を有効化
		
		--ロジックOFFにする
		proxy:EnableLogic( 623, false );
		
		--奴隷兵士の状態を「販売(王城2)」に変える
		SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_SELL02 );
	end
end
--▲-----------------------------▲-----------------------------------------


--▼奴隷兵士が敵対している(王城1)▼-------------------------
function SetDoreiShopState02( proxy, param )
	ValidCharactor(proxy,691);--王城1にいる奴隷兵士を有効化
	--奴隷兵士のチームタイプを変更する
	proxy:SetTeamType( 691, TEAM_TYPE_AngryFriend );
end
--▲-----------------------------▲-------------------------


--▼奴隷兵士が死亡した(王城1)▼-------------------------------------
function SetDoreiShopState03( proxy, param )
	InvalidBackRead(proxy,691);--王城1にいる奴隷兵士を無効化
	InvalidBackRead(proxy,623);--王城2にいる奴隷兵士を無効化
	InvalidBackRead(proxy,679);--王城3にいる奴隷兵士を無効化
end
--▲-------------------------▲-------------------------------------


--▼奴隷兵士が販売している(王城2)▼-----------------------------------------
function SetDoreiShopState04( proxy, param )
	--王の盾が生きている or エリアボスを撃破してきていない or 王都の門が開いて無い
	if 	proxy:IsCompleteEvent( 4224 ) == false or
		proxy:IsCompleteEvent( 8035 ) == false or
		proxy:IsCompleteEvent( 571) == false then
		ValidCharactor(proxy,623);--王城2にいる奴隷兵士を有効化
		InvalidBackRead(proxy,691);--王城1にいる奴隷兵士を無効化
	else
		print("DoreiShop NowState DOREISOL_SHOP_SELL02 > Chenge to DOREISOL_SHOP_SELL03");
		InvalidBackRead(proxy,691);--王城1にいる奴隷兵士を無効化
		InvalidBackRead(proxy,623);--王城2にいる奴隷兵士を無効化
		ValidCharactor(proxy,679);--王城3にいる奴隷兵士を有効化
		
		--ロジックOFFにする
		proxy:EnableLogic( 679, false );
		
		--奴隷兵士の状態を「販売(王城3)」に変える
		SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_SELL03 );
	end
end
--▲-----------------------------▲-----------------------------------------


--▼奴隷兵士が敵対している(王城2)▼-------------------------
function SetDoreiShopState05( proxy, param )
	ValidCharactor(proxy,623);--王城2にいる奴隷兵士を有効化
	InvalidBackRead(proxy,691);--王城1にいる奴隷兵士を無効化
	--奴隷兵士のチームタイプを変更する
	proxy:SetTeamType( 623, TEAM_TYPE_AngryFriend );
end
--▲-----------------------------▲-------------------------


--▼奴隷兵士が販売している(王城3)▼-------------------------
function SetDoreiShopState06( proxy, param )
	ValidCharactor(proxy,679);--王城3にいる奴隷兵士を有効化
	InvalidBackRead(proxy,691);--王城1にいる奴隷兵士を無効化
	InvalidBackRead(proxy,623);--王城2にいる奴隷兵士を無効化
end
--▲-----------------------------▲-------------------------


--▼奴隷兵士が敵対している(王城3)▼-------------------------
function SetDoreiShopState07( proxy, param )
	ValidCharactor(proxy,679);--王城3にいる奴隷兵士を有効化
	InvalidBackRead(proxy,691);--王城1にいる奴隷兵士を無効化
	InvalidBackRead(proxy,623);--王城2にいる奴隷兵士を無効化
	--奴隷兵士のチームタイプを変更する
	proxy:SetTeamType( 679, TEAM_TYPE_AngryFriend );
end
--▲-----------------------------▲-------------------------


--▼奴隷兵士の状態遷移(王城1)▼--------------------------------------------------------------------------------------
function RegistConditionBlock01(proxy, param)
	--奴隷兵士が死んでいない
	if proxy:IsCompleteEvent( DOREISOL_SHOP_DEAD ) == false then
		--奴隷兵士が王城1,2,3のいずれでも敵対していない場合
		if proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE01 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE02 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE03 ) == false then
			--ホストからのダメージ監視
			--m02_00
			--proxy:OnCharacterTotalDamage( 341, 691, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_341", once );
			proxy:OnCharacterTotalRateDamage( 341, 691, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_341", once );
			--m02_01
			--proxy:OnCharacterTotalDamage( 760, 623, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_760", once );
			proxy:OnCharacterTotalRateDamage( 760, 623, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_760", once );
			--m02_02
			--proxy:OnCharacterTotalDamage( 1440, 679, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_1440", once );
			proxy:OnCharacterTotalRateDamage( 1440, 679, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1440", once );
		end
		proxy:OnCharacterDead( 342, 691, "OnEvent_342", once );
	end
end
--▲------------------▲--------------------------------------------------------------------------------------


--▼奴隷兵士の状態遷移(王城2)▼-------------------------------------------------------------------------------
function RegistConditionBlock02(proxy, param)
	--奴隷兵士が死んでいない
	if proxy:IsCompleteEvent( DOREISOL_SHOP_DEAD ) == false then
		--奴隷兵士が王城1,2,3のいずれでも敵対していない場合
		if proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE01 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE02 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE03 ) == false then
			--ホストからのダメージ監視
			--m02_00
			--proxy:OnCharacterTotalDamage( 341, 691, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_341", once );
			proxy:OnCharacterTotalRateDamage( 341, 691, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_341", once );
			--m02_01
			--proxy:OnCharacterTotalDamage( 760, 623, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_760", once );
			proxy:OnCharacterTotalRateDamage( 760, 623, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_760", once );
			--m02_02
			--proxy:OnCharacterTotalDamage( 1440, 679, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_1440", once );
			proxy:OnCharacterTotalRateDamage( 1440, 679, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1440", once );
		end
		proxy:OnCharacterDead( 761, 623, "OnEvent_761", once );
	end
end
--▲------------------▲--------------------------------------------------------------------------------------


--▼奴隷兵士の状態遷移(王城3)▼-------------------------------------------------------------------------------
function RegistConditionBlock03(proxy, param)
	--奴隷兵士が死んでいない
	if proxy:IsCompleteEvent( DOREISOL_SHOP_DEAD ) == false then
		--奴隷兵士が王城1,2,3のいずれでも敵対していない場合
		if proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE01 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE02 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE03 ) == false then
			--ホストからのダメージ監視
			--m02_00
			--proxy:OnCharacterTotalDamage( 341, 691, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_341", once );
			proxy:OnCharacterTotalRateDamage( 341, 679, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_341", once );
			--m02_01
			--proxy:OnCharacterTotalDamage( 760, 623, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_760", once );
			proxy:OnCharacterTotalRateDamage( 760, 623, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_760", once );
			--m02_02
			--proxy:OnCharacterTotalDamage( 1440, 679, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_1440", once );
			proxy:OnCharacterTotalRateDamage( 1440, 679, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1440", once );
		end
		proxy:OnCharacterDead( 1441, 679, "OnEvent_1441", once );
	end
end
--▲------------------▲--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--■85■王子会話用フラグ制御■
--------------------------------------------------------------------------------------
function OnEvent_85(proxy,param)
	print("OnEvent_85 begin");
	proxy:SetEventFlag( 85 ,true );
	print("OnEvent_85 end");
end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--■7■敵が砲弾ごろごろ■
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegistEvent_7(proxy)
	--SingleReset( proxy, 7 );
	if	proxy:IsCompleteEvent( 7 ) == false then
		proxy:OnRegionJustIn( 7, LOCAL_PLAYER, 2006, "OnEvent_7", once );
		proxy:OnSimpleDamage( 7, 246, LOCAL_PLAYER, "OnEvent_7", once );
		proxy:EnableLogic( 246, false );
	else
		proxy:EndAnimation( 1010, 1 );
		proxy:ReconstructBreak( 1011 , 1 );
		proxy:ReconstructBreak( 1012 , 1 );
	end
end

function OnEvent_7(proxy,param)
	print("OnEvent_7 begin");
	proxy:DeleteEvent( 7 );
	proxy:PlayAnimation( 1010, 1 );
	proxy:SetObjEventCollisionFill( 1010, true );
	
	proxy:PlayAnimation( 470 , 3002 );--兵士が蹴る
	proxy:EnableLogic( 246, true );
	
	proxy:SetEventFlag( 7, true );
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 7, "OnEvent_7_1", 0.5, 0, 2, once );
	proxy:NotNetMessage_end();
	print("OnEvent_7 end");
end

function OnEvent_7_1(proxy,param)
	print("OnEvent_7_1 begin");
	proxy:OnObjectDamageHit_NoCallPlus( 7, 1010, 1, 10210, EV_HIT_CHR, 1.0, 5.0,1.0, everytime );
	
	print("OnEvent_7_1 end");
end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--■6■兵士が火炎瓶を投げる■
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ThrowFirePotRegist_b1(proxy)
	SingleReset(proxy, 6 );
	if	proxy:IsCompleteEvent( 6 ) == false then
		proxy:OnRegionJustIn( 6, LOCAL_PLAYER, 2005, "OnEvent_6", once );
		proxy:OnRegionJustIn( 6, LOCAL_PLAYER, 2004, "OnEvent_6", once );
		proxy:OnSimpleDamage( 6, 245, LOCAL_PLAYER, "OnEvent_6", once );
		proxy:EnableLogic( 245, false );
	end
end

function OnEvent_6(proxy,param)
	print("OnEvent_6 begin");
	proxy:DeleteEvent( 6 );
	proxy:SetEventFlag( 6, true );
	proxy:PlayAnimation( 245, 6060 );
	if param:GetParam2() == 245 then
		--第2パラが兵士の時は殴られてます
		proxy:EnableLogic( 245, true );
	else
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 6,"OnEvent_6_1",4,0,0,once);
		proxy:NotNetMessage_end();
	end
	print("OnEvent_6 end");
end

function OnEvent_6_1(proxy,param)
	print("OnEvent_6_1 begin");
	proxy:EnableLogic( 245 , true );
	print("OnEvent_6_1 end");
end

--[[
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--■100■篝火に突っ込んだ■
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ObjDamage(proxy,objid)
	--print(objid);
	if proxy:IsReady_Obj(objid) == true then
		proxy:OnObjectDamageHit_NoCall( 100, objid,1,10300,EV_HIT_CHR,0.5,FIREDAM_WAIT,everytime);
	end
	proxy:NotNetMessage_begin();	
		proxy:OnKeyTime2( 100 , "OnEvent_100_"..objid.."_1",FIREDAM_WAIT,0,objid+10000,once);	
	proxy:NotNetMessage_end();
end

function ObjDamage_1(proxy,objid)
	if proxy:IsReady_Obj(objid) == true then
		proxy:OnObjectDamageHit_NoCall( 100, objid,1,10300,EV_HIT_CHR,0.5,FIREDAM_WAIT,everytime);
	end
	proxy:NotNetMessage_begin();	
		proxy:OnKeyTime2( 100 , "OnEvent_100_"..objid,FIREDAM_WAIT,0,objid,once);	
	proxy:NotNetMessage_end();
end

function OnEvent_100_1180(proxy,param) ObjDamage(proxy,1180); end
function OnEvent_100_1180_1(proxy,param) ObjDamage_1(proxy,1180); end
function OnEvent_100_1181(proxy,param) ObjDamage(proxy,1181); end
function OnEvent_100_1181_1(proxy,param) ObjDamage_1(proxy,1181); end
function OnEvent_100_1182(proxy,param) ObjDamage(proxy,1182); end
function OnEvent_100_1182_1(proxy,param) ObjDamage_1(proxy,1182); end
function OnEvent_100_1183(proxy,param) ObjDamage(proxy,1183); end
function OnEvent_100_1183_1(proxy,param) ObjDamage_1(proxy,1183); end
function OnEvent_100_1185(proxy,param) ObjDamage(proxy,1185); end
function OnEvent_100_1185_1(proxy,param) ObjDamage_1(proxy,1185); end
function OnEvent_100_1186(proxy,param) ObjDamage(proxy,1186); end
function OnEvent_100_1186_1(proxy,param) ObjDamage_1(proxy,1186); end
]]

-----------------------------------------------------------------------------
--■■結晶トカゲイベント
-----------------------------------------------------------------------------
--ボス撃破時のトカゲリセット用
function ResetTokage(proxy)
	print("ResetTokage");
	--proxy:SetEventFlag(120,false);
	--proxy:SetEventFlag(590,false);
	--proxy:SetEventFlag(592,false);
	--proxy:SetEventFlag(1090,false);
	--proxy:SetEventFlag(1680,false);	
	--proxy:SetEventFlag(1682,false);	
	--proxy:SetEventFlag(1684,false);
	AddEventCounter(proxy,0);
	AddEventCounter(proxy,1);
	AddEventCounter(proxy,2);
	AddEventCounter(proxy,3);
	AddEventCounter(proxy,4);
	AddEventCounter(proxy,5);
	AddEventCounter(proxy,6);
end

-----------------------------------------------------------------------------
--■120■結晶トカゲイベント1
-----------------------------------------------------------------------------
function OnEvent_120(proxy,param)
	print("OnEvent_120 begin");
	proxy:SetEventFlag( 120, true);
	proxy:DeleteEvent( 120 );
	print("OnEvent_120 end");
end


-----------------------------------------------------------------------------
--■201■処刑場の扉を超えた
-----------------------------------------------------------------------------
function OnEvent_201(proxy,param)
	print("OnEvent_201 begin");
	proxy:SetEventFlag(201,true);
	print("OnEvent_201 end");
end


function OnEvent_450_In(proxy,param)
	print("OnEvent_450_In begin");
	proxy:SetDrawEnable( 300,false );
	proxy:SetDrawEnable( 301,false );
	print("OnEvent_450_In end");
end

function OnEvent_450_Out(proxy,param)
	print("OnEvent_450_Out begin");
	proxy:SetDrawEnable( 300,true );
	proxy:SetDrawEnable( 301,true );
	print("OnEvent_450_Out end");
end


-----------------------------------------------------------------------------
--■8■一般兵士火炎瓶投げる
-----------------------------------------------------------------------------
function OnEvent_8(proxy,param)
	if proxy:IsCompleteEvent( 8 ) == false then
		print("OnEvent_8 begin");
		proxy:SetEventFlag( 8 , true );
		proxy:EnableLogic( 247 , true );
		proxy:PlayAnimation( 247 , 6060 );
		print("OnEvent_8 end");
	end	
end

--後ろからPCが来た
function OnEvent_9(proxy,param)
	proxy:DeleteEvent( 8 );
	proxy:EnableLogic( 247 , true );
	proxy:ResetThink( 247 );
end
