
--乞食(女)の状態変化フラグ
KOJIKI_FEMALE_SHOP_SELL01  	 = 16230;--販売中(不浄1)
KOJIKI_FEMALE_SHOP_HOSTILE01 = 16231;--敵対(不浄1)
KOJIKI_FEMALE_SHOP_DEAD	   	 = 16232;--死亡
KOJIKI_FEMALE_SHOP_SELL02  	 = 16233;--販売中(不浄2)
KOJIKI_FEMALE_SHOP_HOSTILE02 = 16234;--敵対(不浄2)

--乞食(女)の状態変化フラグリスト
Kojiki_Shop_Flag_list = {
	KOJIKI_FEMALE_SHOP_SELL01,
	KOJIKI_FEMALE_SHOP_HOSTILE01,
	KOJIKI_FEMALE_SHOP_DEAD,
	KOJIKI_FEMALE_SHOP_SELL02,
	KOJIKI_FEMALE_SHOP_HOSTILE02,
}

--敵対するためのダメージ量
KojikiShop_TotalDamage = 50;

--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■
--------------------------------------------------------------------------------------
function Initialize_m05_00_00_00(proxy)
	print("Initialize_m05_00_00_00 begin");
	
	proxy:LuaCall( 99999 , 0 , "OnEvent_4000_Hp_1",everytime);
-----------------------------------------------------------------------------------------
--ボス関連
-----------------------------------------------------------------------------------------
--■160■ボス部屋に入る■
	
	--中ボスが生きているときだけイベント登録
	if proxy:IsCompleteEvent( 5650 ) == false then
	
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。
		SingleReset(proxy, 160);
	
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き)
		proxy:LuaCall( 161, 1, "OnEvent_161_1", everytime );
		--▽2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCall( 161 , 5 , "OnEvent_160_GO_TO_IN" , everytime );
		--▽フラグセット(同期用)
		proxy:LuaCall( 161 , 6 , "OnEvent_160_flag_set" , everytime );
		
		--誰かがボス前扉をまだ通過していない
		if proxy:IsCompleteEvent( 160 ) == false then
		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--▼160▼中に入るためのイベントを追加▼
				proxy:OnPlayerActionInRegionAttribute( 160, 2895, "OnEvent_160", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --グレイゴーストできたときようにいると思われる。
			proxy:NotNetMessage_begin();
				--▼161▼中に入るためのイベントを追加▼--ハンドラは上と同じ
				proxy:OnPlayerActionInRegion( 161, 2895, "OnEvent_160", HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		end
	end


--■162■中ボスポリ劇演出■	
	--ボス生きている
	if proxy:IsCompleteEvent( 5650 ) == false then
		if proxy:IsCompleteEvent( 162 ) ==false then
			proxy:OnRegionJustIn( 162, LOCAL_PLAYER, 2899, "OnEvent_162", once );
			proxy:NotNetMessage_begin();
				--ポリ劇開始に呼ばれるハンドラ
				proxy:LuaCall(162, REMO_START, "OnEvent_162_RemoStart", once);
				--ポリ劇終了後に呼ばれるハンドラ(トリガー起こした人用)
				proxy:LuaCall(162, REMO_FINISH, "OnEvent_162_RemoFinish", once);
			proxy:NotNetMessage_end();
		end
	end


--■163■ボス戦闘開始■
	if proxy:IsCompleteEvent( 5650 ) == false then
		--ローカルプレイ時はボスが死んでいない限り毎回登録
		if	proxy:IsClient() == false then
			proxy:SetEventFlag( 163, false );
		end
		if proxy:IsCompleteEvent( 163 ) == false then
			proxy:OnRegionJustIn( 163 , LOCAL_PLAYER , 2887 , "OnEvent_163" , once );
		else
			proxy:PlayPointSE( 2120, SOUND_TYPE_M, 50000000, 0 );--領域のIDのみ未定
		end	
	end

--■5650■ボスが死んだら■
	proxy:AddFieldInsFilter( 808 );
	if proxy:IsCompleteEvent( 5650 ) ==false then
		proxy:OnCharacterDead(5650,808,"OnEvent_5650",once);
	else
		proxy:InvalidSfx( 1987, false );
		proxy:InvalidSfx( 1991, false );
	end

	--■ボス関連の初期化処理
	if proxy:IsCompleteEvent( 5650 ) ==true then
		
		--▽ボス死んでいるとき
		--ボスいなくなる
		InvalidBackRead( proxy , 808 );
		
		--魔法壁消える
		proxy:SetColiEnable( 1999 , false );
		proxy:SetColiEnable( 1995 , false );
	
		proxy:SetDrawEnable( 1999 , false );
		proxy:SetDrawEnable( 1995 , false );	

		--ボス壁Sfx
		proxy:InvalidSfx( 1987, false );
		proxy:InvalidSfx( 1991, false );
		
		--崩れる壁の破壊再現(次のブロックへの道がひらく)
		proxy:ReconstructBreak( 2060 , 1 );
		
		--ホストプレイヤーのみアイテム入手イベントに使用
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--宝死体(ソウル?)有効化
		proxy:SetDrawEnable( 1982, true );
		proxy:SetColiEnable( 1982, true );
		proxy:TreasureDispModeChange2( 1982, true ,KANAME_SFX);--光らせる
		--ソウルにささった剣
		proxy:SetDrawEnable( 1975, true );
		proxy:SetColiEnable( 1975, true );
		--proxy:TreasureDispModeChange2( 1975, true ,KANAME_SFX);--光らせる
		
		--▼(ソウル)アイテム取得用イベント監視追加▼
		if proxy:IsCompleteEvent( 5653 ) == false then
			--SFX有効化
			proxy:ValidSfx( 2150 );--要石のオーラ
			proxy:ValidSfx( 2151 );--光の粒子
			
			proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);--光らせる
			proxy:OnDistanceActionAttribute( 5653 , LOCAL_PLAYER , 1982 , "OnEvent_5653" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--SFX無効化
			proxy:InvalidSfx( 2150, false );--要石のオーラ
			--proxy:InvalidSfx( 2151, false );--光の粒子
			
			--▼要石でワープ用の監視を追加▼
			SingleReset(proxy,5654);
			proxy:OnDistanceActionAttribute( 5654 , LOCAL_PLAYER , 1982 , "OnEvent_5654" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
		
	else
		--▽ボス生きているとき
		
		--ボスポリ劇未発動時
		if proxy:IsCompleteEvent(162) == false then
			--InvalidCharactor( proxy , 808 );
			--ValidCharactor( proxy , 808 );
			proxy:SetDrawEnable( 808, false );
			proxy:EnableLogic( 808, false );
		end
		
		--PT組んでない時は初期化します
		if proxy:IsClient() == false  then
			
			SingleReset(proxy,6274);
			SingleReset(proxy,6275);
		end
		
		proxy:EnableLogic( 808 , false );--ロジックOFFで待機
		
		--初期効果は必ず付与
		proxy:SetEventSpecialEffect( 811,5000);	
		--2段階目付与
		if proxy:IsCompleteEvent(6274) == true then
			proxy:SetEventSpecialEffect( 811, 5001);
		end
		--3段階目付与
		if proxy:IsCompleteEvent(6274) == true then
			proxy:SetEventSpecialEffect( 811, 5002);
		end
		
		--宝(ソウル)初期化
		proxy:SetDrawEnable( 1982 , false );
		proxy:SetColiEnable( 1982 , false );
		--ソウルに刺さった剣初期化
		proxy:SetDrawEnable( 1975 , false );
		proxy:SetColiEnable( 1975 , false );
		
		--SFX初期化
		proxy:InvalidSfx( 2150 , false );--要石のオーラ
		proxy:InvalidSfx( 2151 , false );--光の粒子
		
		--魔法壁ON
		proxy:SetColiEnable( 1999 , true );
		proxy:SetColiEnable( 1995 , true );
		
		proxy:SetDrawEnable( 1999 , true );
		proxy:SetDrawEnable( 1995 , true );
		
		--光の壁Sfxを有効化
		proxy:ValidSfx( 1987 );
		proxy:ValidSfx( 1991 );
	end	

-----------------------------------------------------------------------------------------
--ギミック関連
-----------------------------------------------------------------------------------------
--■0■ハシゴA降り■PCがイベントエリア(2000)の中に居て、アクションボタンを押したとき--
	proxy:OnActionEventRegion(0, 2000, "OnEvent_0", LadderAngle_A, HELPID_DOWN, everytime);
--■1■ハシゴA昇り■PCがイベントエリア(2001)の中に居て、アクションボタンを押したとき--
	proxy:OnActionEventRegion(1, 2001, "OnEvent_1", LadderAngle_A, HELPID_UP,   everytime);

--■10■ハシゴB降り■PCがイベントエリア(2004)の中に居て、アクションボタンを押したとき--
	proxy:OnActionEventRegion(10, 2004, "OnEvent_10", LadderAngle_A, HELPID_DOWN, everytime);
--■11■ハシゴB昇り■PCがイベントエリア(2005)の中に居て、アクションボタンを押したとき--
	proxy:OnActionEventRegion(11, 2005, "OnEvent_11", LadderAngle_A, HELPID_UP,   everytime);

--■20■ハシゴC降り■PCがイベントエリア(2030)の中に居て、アクションボタンを押したとき--
	proxy:OnActionEventRegion(20, 2030, "OnEvent_20", LadderAngle_A, HELPID_DOWN, everytime);
--■21■ハシゴC昇り■PCがイベントエリア(2031)の中に居て、アクションボタンを押したとき--
	proxy:OnActionEventRegion(21, 2031, "OnEvent_21", LadderAngle_A, HELPID_UP,   everytime);

--■23■イスタレル■
	if proxy:IsCompleteEvent( 23 ) == false then
		--ホスト、生存、グレイのみ調べることができる
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		
		proxy:OnDistanceActionAttribute( 23 , LOCAL_PLAYER , 1002 , "OnEvent_23" , ItemBoxDist_A , 10010145 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
		proxy:LuaCall( 23,1,"OnEvent_23_2",once);
		proxy:LuaCall( 23,2,"OnEvent_23_3",once);
		proxy:TreasureDispModeChange2( 1002, true ,KEN_SFX);
	else
		proxy:SetDrawEnable( 1002 , false );--ひとまず描画だけOFF
		proxy:SetColiEnable( 1002 , false );
	end	
	--proxy:SetRarity( 1002, 10419 );
	
	

--■30■跳ね橋A■PCがOBJ(1000)に対して反応角度(30)、角度オフセット(180)、距離(150)でアクションボタンを押す--
	if proxy:IsCompleteEvent( 30 ) ==false then
		proxy:OnDistanceActionPlus( 30, LOCAL_PLAYER, 1000, "OnEvent_30", DrawBridgeDist_A, HELPID_START, 180, DrawBridgeAngle_A, -1.5, -1.0, 1.4, once);
	else
		proxy:EndAnimation( 1000, 1 );
	end
	
--■40■跳ね橋B■PCがOBJ(1001)に対して反応角度(30)、角度オフセット(180)、距離(150)でアクションボタンを押す--
	if proxy:IsCompleteEvent( 40 ) ==false then
		proxy:OnDistanceActionPlus( 40, LOCAL_PLAYER, 1001, "OnEvent_40", DrawBridgeDist_A, HELPID_START, 180, DrawBridgeAngle_A, 0.3, -2.5, 1.9, once);
	else
		proxy:EndAnimation( 1001, 1 );
	end
	
--■50■床抜けA■PCがイベントエリア(1020)に入った時--
	if proxy:IsCompleteEvent( 50 ) ==false then
		proxy:OnRegionJustIn(50,LOCAL_PLAYER,1020, "OnEvent_50",once);
	else
		proxy:ReconstructBreak( 1020 , 1 );
	end
	
--■60■床抜けB■PCがイベントエリア(1021)に入った時--
	if proxy:IsCompleteEvent( 60 ) ==false then
		proxy:OnRegionJustIn(60,LOCAL_PLAYER,1021, "OnEvent_60",once);
	else
		proxy:ReconstructBreak( 1021 , 1 );
	end



	
--■70■揺れるつり橋A■PCがイベントエリア(2050)に入ったら
	proxy:OnRegionIn(70,LOCAL_PLAYER,2050,"OnEvent_70",everytime);	
	
--■80■揺れるつり橋B■PCがイベントエリア(2051)に入ったら
	proxy:OnRegionIn(80,LOCAL_PLAYER,2051,"OnEvent_80",everytime);	

--■90■揺れるつり橋C■PCがイベントエリア(2052)に入ったら
	proxy:OnRegionIn(90,LOCAL_PLAYER,2052,"OnEvent_90",everytime);	

--■100■揺れるつり橋D■PCがイベントエリア(2053)に入ったら
	proxy:OnRegionIn(100,LOCAL_PLAYER,2053,"OnEvent_100",everytime);


--■130-131■ふわふわ足場■
	proxy:RepeatMessage_begin();
		proxy:OnRegionIn( 130,LOCAL_PLAYER,2040,"OnEvent_130_1", once );
	proxy:RepeatMessage_end();
--■131■ふわふわ足場(領域内移動)■PCがイベントエリア(2041)に入ったら
	proxy:OnRegionIn(131,LOCAL_PLAYER,2041,"OnEvent_131",everytime);
--■132■ふわふわ足場(領域内移動)■PCがイベントエリア(2042)に入ったら
	proxy:OnRegionIn(132,LOCAL_PLAYER,2042,"OnEvent_132",everytime);
--■133■ふわふわ足場(領域内移動)■PCがイベントエリア(2043)に入ったら
	proxy:OnRegionIn(133,LOCAL_PLAYER,2043,"OnEvent_133",everytime);

	

--■110■カラスが飛び立つ
	if proxy:IsCompleteEvent( 110 ) == false then
		proxy:OnRegistFunc(110,"Check_110","OnEvent_110",1,once);
	end
	--OnRegistFuncの場合最初のハンドラに自由に条件を定義してそこでtrueを返した時に結果のハンドラが呼ばれます。eginAction
	--ハンドラのあとの1は識別子です。ここを変化する事で同イベントIDでも異なる監視として登録できます。

--■280■石柱にワープ■
	SingleReset(proxy,280);
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	proxy:OnDistanceAction( 280, LOCAL_PLAYER, 1983, "OnEvent_280", WarpGimmickDist_A, HELPID_GO_TO_SEKITYUU, 0, 180, everytime );
	
--■281■最初の要石の光が消える■
	proxy:OnSessionJustIn( 281 , "OnEvent_281" , everytime );
	
--■282■最初の要石の光が復活する■
	proxy:OnSessionJustOut( 282 , "OnEvent_282" , everytime );
	
	
--■140■死んだふり腐敗人■
	if proxy:IsCompleteEvent( 140 ) == false then
		--proxy:OnPlayerDistanceInTarget( 140, LOCAL_PLAYER, 13056, "OnEvent_140", 1.5, once );
		proxy:OnRegionJustIn( 140, LOCAL_PLAYER, 2109, "OnEvent_140", once );
	end
		
--■141■死んだふり腐敗人■
	if proxy:IsCompleteEvent( 141 ) == false then
		--proxy:OnPlayerDistanceInTarget( 141, LOCAL_PLAYER, 13057, "OnEvent_141", 1.5, once );--宝
		proxy:OnRegionJustIn( 141, LOCAL_PLAYER, 2110, "OnEvent_141", once );--つり橋	 
		proxy:OnRegionJustIn( 141, LOCAL_PLAYER, 2100, "OnEvent_141", once );--つり橋	 
	end
	
--■142■死んだふり腐敗人■
	if proxy:IsCompleteEvent( 142 ) == false then
		--proxy:OnPlayerDistanceInTarget( 142, LOCAL_PLAYER, 13058, "OnEvent_142", 1.5, once );--宝
		proxy:OnRegionJustIn( 142, LOCAL_PLAYER, 2111, "OnEvent_142", once );--つり橋	 
	end
	
--■143■死んだふり腐敗人■
	if proxy:IsCompleteEvent( 143 ) == false then
		--proxy:OnPlayerDistanceInTarget( 143, LOCAL_PLAYER, 13059, "OnEvent_143", 1.5, once );--宝
		proxy:OnRegionJustIn( 143, LOCAL_PLAYER, 2112, "OnEvent_143", once );--つり橋	 
		proxy:OnRegionJustIn( 143, LOCAL_PLAYER, 2104, "OnEvent_143", once );--跳ね橋
	end
	
--■144■死んだふり腐敗人■
	if proxy:IsCompleteEvent( 144 ) == false then
		proxy:OnRegionJustIn( 144, LOCAL_PLAYER, 2101, "OnEvent_144", once );--つり橋
	end
	
--■145■死んだふり腐敗人■
	if proxy:IsCompleteEvent( 145 ) == false then
		proxy:OnRegionJustIn( 145, LOCAL_PLAYER, 2102, "OnEvent_145", once );--つり橋
		proxy:OnRegionJustIn( 145, LOCAL_PLAYER, 2103, "OnEvent_145", once );--つり橋
	end
	
--■146■死んだふり腐敗人■
	if proxy:IsCompleteEvent( 146 ) == false then
		proxy:OnRegionJustIn( 146, LOCAL_PLAYER, 2040, "OnEvent_146", once );--ふわふわ足場
	end
	
--■147■死んだふり腐敗人■
	if proxy:IsCompleteEvent( 147 ) == false then
		proxy:OnRegionJustIn( 147, LOCAL_PLAYER, 2105, "OnEvent_147", once );--領域
		proxy:OnRegionJustIn( 147, LOCAL_PLAYER, 2106, "OnEvent_147", once );--領域
	end
	
--■148■死んだふり腐敗人■
	if proxy:IsCompleteEvent( 148 ) == false then
		proxy:OnRegionJustIn( 148, LOCAL_PLAYER, 2107, "OnEvent_148", once );--領域
	end
	
--■149■死んだふり腐敗人■
	if proxy:IsCompleteEvent( 149 ) == false then
		proxy:OnRegionJustIn( 149, LOCAL_PLAYER, 2108, "OnEvent_149", once );--領域
	end
	
	
--■150■小石が振ってくる■
	if proxy:IsCompleteEvent( 150 ) == false then
		proxy:OnRegionJustIn( 150, LOCAL_PLAYER, 2080, "OnEvent_150", once );
	end	
--■151■小石が振ってくる■
	if proxy:IsCompleteEvent( 151 ) == false then
		proxy:OnRegionJustIn( 151, LOCAL_PLAYER, 2081, "OnEvent_151", once );
	end	

--■200～256■腐敗人転落死■
	local fall_chrId_list = {300, 301, 302, 303, 304, 305, 306, 307, 308, 309,
							 310, 311, 312, 313, 314, 315, 316, 317, 318, 319,
							 320, 321, 322, 323, 324, 325, 326, 327, 328, 329,
							 330, 333, 334, 335, 336, 338,
							 500, 501, 502, 503, 504, 505, 506, 507, 508, 509,
							 510, 511, 512, 513, 514, 515, 516};
	local fall_chrNum = table.getn(fall_chrId_list);
	for index = 1, fall_chrNum, 1 do
		proxy:OnRegionJustIn( 200 + index - 1, fall_chrId_list[index], 2141, "fall_countup", once );
		proxy:OnRegionJustIn( 200 + index - 1, fall_chrId_list[index], 2142, "fall_countup", once );
		--proxy:OnRegistFunc( 200 + index - 1, "fall_Condition", "fall_result",fall_chrId_list[index], once );
	end


--■??■徘徊デーモンの登場■ハンドラ登録
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。
		proxy:LuaCall( 4000, 100, "PlayerDeath_m05_00_00_00", everytime );
		--プレイヤーが復活した時にキックされます。
		proxy:LuaCall( 4032, 100, "PlayerRevive_m05_00_00_00", everytime );
	proxy:NotNetMessage_end();	

--■22■はしご出現■QWCイベント
	SingleReset(proxy,22);	
	if 	proxy:IsSuccessQWC(50150) == false and
		proxy:IsCompleteEvent(24) == false then
		proxy:SetEventFlag( 22, true );--QWC未成立		
	end
	
	if proxy:IsCompleteEvent(24) == false then
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionJustIn( 24 , 10000 , 2170 , "OnEvent_24",once);
			proxy:NotNetMessage_end();
		end
	end
	
	if proxy:IsCompleteEvent( 22 ) == false then
		print("[成立]QWCはしご");
	else
		print("[未成立]QWCはしご");
		--はしご上り下りイベントを削除し、はしごの当たり・描画を消去
		proxy:DeleteEvent(20);
		proxy:DeleteEvent(21);
		proxy:SetColiEnable( 1062, false );
		proxy:SetDrawEnable( 1062, false );
	end

--[[
--■床抜けのオブジェの破壊同期
	
	--床抜けA
	if proxy:IsCompleteEvent( 50 ) ==true then
		proxy:ReconstructBreak( 1020 , 1 );
	end
	
	--床抜けB
	if proxy:IsCompleteEvent( 60 ) ==true then
		proxy:ReconstructBreak( 1021 , 1 );
	end
]]
	
	
--■140■死んだふり腐敗人■
	if proxy:IsCompleteEvent(140) == false then
		--フラグが立ってない場合はひとまず死んだフリ
		proxy:EnableLogic( 500, false );
		proxy:SetColiEnable( 500, false );
		proxy:EnableHide( 500, true );
	else
		--特殊待機解除
		proxy:SetSpStayAndDamageAnimId( 500 ,-1,-1);
	end
	
--■141■死んだふり腐敗人■
	if proxy:IsCompleteEvent(141) == false then
		--フラグが立ってない場合はひとまず死んだフリ
		proxy:EnableLogic( 501, false );
		proxy:EnableLogic( 502, false );
		proxy:SetColiEnable( 501, false );
		proxy:SetColiEnable( 502, false );
		proxy:EnableHide( 501, true );
		proxy:EnableHide( 502, true );
	else
		--特殊待機解除
		proxy:SetSpStayAndDamageAnimId( 501 ,-1,-1);		
		proxy:SetSpStayAndDamageAnimId( 502 ,-1,-1);
	end

--■142■死んだふり腐敗人■
	if proxy:IsCompleteEvent(142) == false then
		--フラグが立ってない場合はひとまず死んだフリ
		proxy:EnableLogic( 503, false );
		proxy:SetColiEnable( 503, false );
		proxy:EnableHide( 503, true );
	else
		--特殊待機解除
		proxy:SetSpStayAndDamageAnimId( 503 ,-1,-1);
	end
	
--■143■死んだふり腐敗人■
	if proxy:IsCompleteEvent(143) == false then
		--フラグが立ってない場合はひとまず死んだフリ
		proxy:EnableLogic( 504, false );
		proxy:EnableLogic( 505, false );
		proxy:SetColiEnable( 504, false );
		proxy:SetColiEnable( 505, false );
		proxy:EnableHide( 504, true );
		proxy:EnableHide( 505, true );
	else
		proxy:SetSpStayAndDamageAnimId( 504 ,-1,-1);
		proxy:SetSpStayAndDamageAnimId( 505 ,-1,-1);
	end

--■144■死んだふり腐敗人■
	if proxy:IsCompleteEvent(144) == false then
		--フラグが立ってない場合はひとまず死んだフリ
		proxy:EnableLogic( 506, false );
		proxy:SetColiEnable( 506, false );
		proxy:EnableHide( 506, true );
	else
		proxy:SetSpStayAndDamageAnimId( 506 ,-1,-1);
	end
	
--■145■死んだふり腐敗人■
	if proxy:IsCompleteEvent(145) == false then
		--フラグが立ってない場合はひとまず死んだフリ
		proxy:EnableLogic( 507, false );
		proxy:EnableLogic( 508, false );
		proxy:SetColiEnable( 507, false );
		proxy:SetColiEnable( 508, false );
		proxy:EnableHide( 507, true );
		proxy:EnableHide( 508, true );
	else
		proxy:SetSpStayAndDamageAnimId( 507 ,-1,-1);
		proxy:SetSpStayAndDamageAnimId( 508 ,-1,-1);
	end
	
--■146■死んだふり腐敗人■
	if proxy:IsCompleteEvent(146) == false then
		--フラグが立ってない場合はひとまず死んだフリ
		proxy:EnableLogic( 509, false );
		proxy:EnableLogic( 510, false );
		proxy:SetColiEnable( 509, false );
		proxy:SetColiEnable( 510, false );
		proxy:EnableHide( 509, true );
		proxy:EnableHide( 510, true );
	else
		proxy:SetSpStayAndDamageAnimId( 509 ,-1,-1);
		proxy:SetSpStayAndDamageAnimId( 510 ,-1,-1);
	end
	
--■147■死んだふり腐敗人■
	if proxy:IsCompleteEvent(147) == false then
		--フラグが立ってない場合はひとまず死んだフリ
		proxy:EnableLogic( 511, false );
		proxy:EnableLogic( 512, false );
		proxy:SetColiEnable( 511, false );
		proxy:SetColiEnable( 512, false );
		proxy:EnableHide( 511, true );
		proxy:EnableHide( 512, true );
	else
		proxy:SetSpStayAndDamageAnimId( 511 ,-1,-1);
		proxy:SetSpStayAndDamageAnimId( 512 ,-1,-1);
	end
	
--■148■死んだふり腐敗人■
	if proxy:IsCompleteEvent(148) == false then
		--フラグが立ってない場合はひとまず死んだフリ
		proxy:EnableLogic( 513, false );
		proxy:EnableLogic( 514, false );
		proxy:EnableLogic( 515, false );
		proxy:SetColiEnable( 513, false );
		proxy:SetColiEnable( 514, false );
		proxy:SetColiEnable( 515, false );
		proxy:EnableHide( 513, true );
		proxy:EnableHide( 514, true );
		proxy:EnableHide( 515, true );
	else
		proxy:SetSpStayAndDamageAnimId( 513 ,-1,-1);
		proxy:SetSpStayAndDamageAnimId( 514 ,-1,-1);
		proxy:SetSpStayAndDamageAnimId( 515 ,-1,-1);
	end

--■149■死んだふり腐敗人■
	if proxy:IsCompleteEvent(149) == false then
		--フラグが立ってない場合はひとまず死んだフリ
		proxy:EnableLogic( 516, false );
		proxy:SetColiEnable( 516, false );
		proxy:EnableHide( 516, true );
	else
		proxy:SetSpStayAndDamageAnimId( 516 ,-1,-1);
	end	
	
	

--■150■小石が振ってくる■
	if proxy:IsCompleteEvent(150) == true then
		proxy:ReconstructBreak( 1070 , 1 );
		proxy:ReconstructBreak( 1071 , 1 );
		proxy:ReconstructBreak( 1072 , 1 );
		proxy:ReconstructBreak( 1073 , 1 );
		proxy:ReconstructBreak( 1074 , 1 );
		proxy:ReconstructBreak( 1075 , 1 );
	end
	
	
--[[
	--■徘徊デーモン用 (フラグは仮、指定があれば変える)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m05_00_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m05_00_00_00);
	end
	proxy:SetEventSimpleTalk( 100, LOCAL_PLAYER, 500, 2.0, 10010200, 0.0, 45.0, 0.0, 0.0, 0.0, ATTR_ALL, true, everytime );
	proxy:AddEventSimpleTalk( 100, 16000 );
	proxy:AddEventSimpleTalkTimer( 100, 16001, 1.5 );
	proxy:AddEventSimpleTalkTimer( 100, 16002, 3.0 );
	proxy:AddEventSimpleTalk( 100, 16003 );
	proxy:AddEventSimpleTalk( 100, 16010 );
]]	
	
	--■180■光の壁■
	if proxy:IsCompleteEvent( 180 ) == false then
		proxy:OnDistanceActionAttribute( 180, LOCAL_PLAYER, 1080, "OnEvent_180", 1.5, 10010403, 180.0, 90.0, ATTR_HOST + ATTR_LIVE + ATTR_GREY, everytime );
		--proxy:SetObjSfx( 1080, 200, 85990, true );
	end
	
	--■181■光の壁■
	if proxy:IsCompleteEvent( 181 ) == false then
		proxy:OnDistanceActionAttribute( 181, LOCAL_PLAYER, 1081, "OnEvent_181", 1.5, 10010403, 180.0, 90.0, ATTR_HOST + ATTR_LIVE + ATTR_GREY, everytime );
		--proxy:SetObjSfx( 1081, 200, 85991, true );
	end
	
	--■180,181■光の壁再現■
	if proxy:IsCompleteEvent( 180 ) == false or
	   proxy:IsCompleteEvent( 181 ) == false then
		proxy:LuaCall( 180, 1, "OnEvent_180_181_delete", once );
	else
		proxy:SetDrawEnable( 1080, false );--描画OFF
		proxy:SetColiEnable( 1080, false );--当たりOFF
		
		proxy:SetDrawEnable( 1081, false );--描画OFF
		proxy:SetColiEnable( 1081, false );--当たりOFF
		
		--ただの再現なので自然な表現の必要が無い為、RootErase指定ではない
		proxy:InvalidSfx( 2125, false );
		proxy:InvalidSfx( 2126, false );
	end

	--■190■板落ち■
	if proxy:IsCompleteEvent( 190 ) == false then
		proxy:OnRegionJustIn( 190, LOCAL_PLAYER, 2085, "OnEvent_190", once );
	else
		proxy:ReconstructBreak( 2085, 1 );
	end

--■167■ボス戦カメラ対応■
	--ボスが生きているなら登録
	if proxy:IsCompleteEvent(5650) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 167 , LOCAL_PLAYER , 2887 ,"OnEvent_167" , everytime );
		proxy:NotNetMessage_end();
	end
	
--■8087■不浄に来たフラグを立てる■
	proxy:SetEventFlag( 8087, true );
	
--[[---------------------------------------------------------------------------------------
--NPC関連
-----------------------------------------------------------------------------------------	
	--フラグを見てNPC状態を初期化
	SetFirstNpcStateFlag( proxy, param, kojiki_m50_flag_list, KOJIKI_M50_STATE_SEELING );
	
	--死亡していないとき
	if proxy:IsCompleteEvent(KOJIKI_M50_STATE_DEAD) == false then
		--■270■乞食(男)敵対■
		if proxy:IsCompleteEvent( 270 ) == false then
			proxy:OnCharacterTotalDamage( 270, 650, LOCAL_PLAYER, TOTALDAMAGE_KOJIKI_M50, "OnEvent_270", once );
		end
		--■271■乞食(男)死亡■
		if proxy:IsCompleteEvent( 271 ) == false then
			proxy:OnCharacterDead( 271, 650, "OnEvent_271", once );
		end
	else
		print("乞食(男)死亡");
		--死んでいるので無効化
		proxy:ForceUpdateNextFrame(650);
		InvalidCharactor( proxy, 650 );
	end
]]

	--乞食(女)のショップNPC
	if proxy:IsClient() == false then
	--■340■乞食(女)のショップNPCチェックポイント(要石)■
		proxy:OnRegionJustIn(272 , LOCAL_PLAYER , 2160 ,"OnEvent_272" , everytime);
	--■340■乞食(女)のショップNPCチェックポイント(蛭デーモン)■
		proxy:OnRegionJustIn(273 , LOCAL_PLAYER , 2161 ,"OnEvent_273" , everytime);
	--■340■乞食(女)のショップNPCチェックポイント(蝿デーモン)■
		proxy:OnRegionJustIn(275 , LOCAL_PLAYER , 2370 ,"OnEvent_275" , everytime);
	end
	
	--■635■チェックポイントの監視■
	proxy:LuaCall( 812 , 1 , "OnEvent_812",everytime);

	--乞食(女)の初期化用
	OnEvent_812(proxy, param);

--------------------------------▽▽▽QWCイベント関連▽▽▽--------------------------------

--■292■QWCソウルモンスター■
	if proxy:IsSuccessQWC(50100) == false then--成立していないならば
		print("ブラックゴースト無効化");
		--431を無効化
		InvalidBackRead(proxy, 431);
		--432を無効化
		InvalidBackRead(proxy, 432);
		--433を無効化
		InvalidBackRead(proxy, 433);
		
		proxy:SetEventFlag(292, true);
	end
	
--トカゲ逃亡イベント
	RegistTokage(proxy,310,461,15);
	RegistTokage(proxy,830,462,16);
	RegistTokage(proxy,1140,463,17);
	
	--[[
00      520     9000    9600　　320 
0000    521     9000    9600　　321 
01      523     9000    9600　　322 
02      524     9000    9600　　323 
03      525     9000    9600　　324 
04      526     9000    9600　　325 
	]]
	
	local actidlist = {320,321,322,323,324,325};
	local daniidlist= {520,521,522,523,524,525};
	local num = table.getn( actidlist );

	for index = 1 ,num , 1 do
		--■actidlist■血ダニダメージ■
		SingleReset(proxy,actidlist[index]);
		if proxy:IsCompleteEvent( actidlist[index] ) == false then
			--proxy:EnableLogic( daniidlist[index], false );
			proxy:OnSimpleDamage( actidlist[index] , daniidlist[index] , 10000 , "OnEvent_"..actidlist[index],once);
		else
			--proxy:SetSpStayAndDamageAnimId( daniidlist[index] ,-1,-1);
		end
	end
	
	
	
--------------------------------△△△QWCイベント関連△△△--------------------------------
	
	--■999999■フレーム遅れの初期化処理イベントを発行■
	proxy:NotNetMessage_begin();
		--▼0秒後▼--
		proxy:OnKeyTime2( 999991, "Second_Initialize_m05_00_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	--■1フレーム遅れの初期化処理イベントを発行■
--~ 	proxy:NotNetMessage_begin();
--~ 		--▼1秒間▼--初期位置が若干浮いている場合、初期状態が待機モーションにならない可能性があるため、1秒間送り続ける
--~ 		proxy:OnKeyTime2( 999990, "Third_Initialize_m05_00_00_00", 1.0, 1, 1, once );
--~ 	proxy:NotNetMessage_end();
	
	if proxy:IsDbgReLoad() == true then
		proxy:OnKeyTime2( 4021,"OnEvent_DbgReLoad",1.0,0,0,once);
	end	
	print("Initialize_m05_00_00_00 end");
end

--リロードデバッグ
function OnEvent_DbgReLoad(proxy,param)
	--完全回復要求
	proxy:RequestFullRecover();
	--石柱の不浄要石へ
	proxy:WarpNextStage( 1, 0, 0, 0, 1009 );
end

function OnEvent_4000_Hp_1(proxy,param)
	print("OnEvent_4000_Hp_1 begin");
	proxy:SetDeadMode2(808 , true );
	proxy:SetDeadMode2(809 , true );
	proxy:SetDeadMode2(824 , true );
	print("OnEvent_4000_Hp_1 end");
end


--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく
function Second_Initialize_m05_00_00_00(proxy, param)
	print("Second_Initialize_m05_00_00_00 begin");
	
--------------------------------▽▽▽QWCイベント関連▽▽▽--------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--------------------------------△△△QWCイベント関連△△△--------------------------------

--■198,199■腐敗人死体有効化■
	local fall_chrId_list = {300, 301, 302, 303, 304, 305, 306, 307, 308, 309,
							 310, 311, 312, 313, 314, 315, 316, 317, 318, 319,
							 320, 321, 322, 323, 324, 325, 326, 327, 328, 329,
							 330, 331, 332, 333, 334, 335, 336, 337, 338, 339,
							 500, 501, 502, 503, 504, 505, 506, 507, 508, 509,
							 510, 511, 512, 513, 514, 515, 516};
	local fall_chrNum = table.getn(fall_chrId_list);
	
	proxy:SetEventFlag( 198, false );
	proxy:SetEventFlag( 199, false );
	proxy:OnNetRegion( 198, 2140 );
	--proxy:OnRegistFunc( 199, "corpse_Condition", "corpse_Result", fall_chrNum, everytime );
	--proxy:OnRegionJustIn( 199, LOCAL_PLAYER, 2140, "corpse_ReginIn", everytime );
	
	proxy:OnRegionJustIn( 199, LOCAL_PLAYER, 2140, "corpseCheck", everytime );
	proxy:LuaCall( 199, 2, "corpseUpdate", everytime );
	local fall_count = 0;
	for index = 1, fall_chrNum, 1 do
		if proxy:IsCompleteEvent( 200 + index - 1 ) == true then
			fall_count = fall_count + 1;
		end
	end
	for index = 1, 10, 1 do
		if fall_count >= index then
			proxy:SetDrawEnable( 10270 + index - 1, true );
			proxy:SetColiEnable( 10270 + index - 1, true );
			proxy:EnableObjTreasure( 10270 + index - 1, true );
		else
			print("宝死体無効化",10270 + index - 1);
			proxy:SetDrawEnable( 10270 + index - 1, false );
			proxy:SetColiEnable( 10270 + index - 1, false );
			proxy:EnableObjTreasure( 10270 + index - 1, false );
		end
	end
	
	

	print("Second_Initialize_m05_00_00_00 end");
end


--■1フレーム遅れの初期化処理■
function Third_Initialize_m05_00_00_00(proxy, param)
	print("Third_Initialize_m05_00_00_00 begin");
	--死んだふり腐敗人にコマンドを送る
	if proxy:IsCompleteEvent(140) == false then
		--proxy:SetEventCommand( 500, 200);
	end
	if proxy:IsCompleteEvent(141) == false then
		--proxy:SetEventCommand( 501, 200);
		--proxy:SetEventCommand( 502, 200);
	end
	if proxy:IsCompleteEvent(142) == false then
		--proxy:SetEventCommand( 503, 200);
	end
	if proxy:IsCompleteEvent(143) == false then
		--proxy:SetEventCommand( 504, 200);
		--proxy:SetEventCommand( 505, 200);
	end
	if proxy:IsCompleteEvent(144) == false then
		--proxy:SetEventCommand( 506, 200);
	end
	if proxy:IsCompleteEvent(145) == false then
		--proxy:SetEventCommand( 507, 200);
		--proxy:SetEventCommand( 508, 200);
	end
	if proxy:IsCompleteEvent(146) == false then
		--proxy:SetEventCommand( 509, 200);
		--proxy:SetEventCommand( 510, 200);
	end
	if proxy:IsCompleteEvent(147) == false then
		--proxy:SetEventCommand( 511, 200);
		--proxy:SetEventCommand( 512, 200);
	end
	if proxy:IsCompleteEvent(148) == false then
		--proxy:SetEventCommand( 513, 200);
		--proxy:SetEventCommand( 514, 200);
		--proxy:SetEventCommand( 515, 200);
	end
	if proxy:IsCompleteEvent(149) == false then
		--proxy:SetEventCommand( 516, 200);
	end
	

--■初期化のみなのでID無し■血ダニ満服■
--~ 	proxy:SetEventCommand( 520, 350);
--~ 	proxy:SetEventCommand( 521, 350);
--~ 	proxy:SetEventCommand( 522, 350);
--~ 	proxy:SetEventCommand( 523, 350);
--~ 	proxy:SetEventCommand( 524, 350);
--~ 	proxy:SetEventCommand( 525, 350);
--~ 	proxy:SetEventCommand( 526, 350);

	
	print("Third_Initialize_m05_00_00_00 end");
end


--------------------------------------------------------------------------------------
--ハシゴA降り■0
--------------------------------------------------------------------------------------
--■0■ハシゴA降りスタート■
function OnEvent_0(proxy, param)
	print("OnEvent_0 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_0 end");
		return;
	end

	--はしご降りに必要な前処理--
	proxy:BeginAction(LOCAL_PLAYER,2,2,2);				--ホバー移動モードに移行
	--proxy:HoverMoveVal(LOCAL_PLAYER,2002,LadderTime_A);--移動位置(2002)に0.5秒でホバー移動
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1060,192,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動
	proxy:SetEventCommand(LOCAL_PLAYER,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );
	proxy:DisableMove(LOCAL_PLAYER,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行
		proxy:OnKeyTime2(0,"OnEvent_0_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理)
		proxy:OnKeyTime2(0,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_0 end");
end

--■0_1■ハシゴA降りスタート:ホバー移動終了■
function OnEvent_0_1(proxy, param)
	print("OnEvent_0_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_0_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,5,4);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_0_1 end");
end


--------------------------------------------------------------------------------------
--ハシゴA昇り■1
--------------------------------------------------------------------------------------
--■1■ハシゴA昇りスタート■
function OnEvent_1(proxy, param)
	print("OnEvent_1 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1 end");
		return;
	end
	
	--はしご昇りに必要な前処理--
	proxy:BeginAction(LOCAL_PLAYER,2,-1,1);			--ホバー移動モードに移行
	--proxy:HoverMoveVal(LOCAL_PLAYER,2003,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1060,191,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動
	proxy:SetEventCommand(LOCAL_PLAYER,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );
	proxy:DisableMove(LOCAL_PLAYER,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご昇りスタートイベントを発行
		proxy:OnKeyTime2(1,"OnEvent_1_1",LadderTime_A,0,0,once);
		--はしご昇り用の関数を1秒間発行(イベントメニューの中断処理?)
		proxy:OnKeyTime2(1,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1 end");
end

--■1_1■ハシゴA昇りスタート:ホバー移動終了■
function OnEvent_1_1(proxy, param)
	print("OnEvent_1_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,-1,4);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_1_1 end");
end


--------------------------------------------------------------------------------------
--ハシゴB降り■10
--------------------------------------------------------------------------------------
--■10■ハシゴB降りスタート■
function OnEvent_10(proxy, param)
	print("OnEvent_10 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_10 end");
		return;
	end

	--はしご降りに必要な前処理--
	proxy:BeginAction(LOCAL_PLAYER,2,2,2);				--ホバー移動モードに移行
	--proxy:HoverMoveVal(LOCAL_PLAYER,2006,LadderTime_A);--移動位置(2006)に0.5秒でホバー移動
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1061,192,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動
	--proxy:HoverMoveVal(LOCAL_PLAYER,1060,192,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動
	proxy:SetEventCommand(LOCAL_PLAYER,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );--垂直：0、　斜め：4
	proxy:DisableMove(LOCAL_PLAYER,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行
		proxy:OnKeyTime2(10,"OnEvent_10_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理)
		proxy:OnKeyTime2(10,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_10 end");
end

--■10_1■ハシゴB降りスタート:ホバー移動終了■
function OnEvent_10_1(proxy, param)
	print("OnEvent_10_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_10_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,11,10);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_10_1 end");
end


--------------------------------------------------------------------------------------
--ハシゴB昇り■11
--------------------------------------------------------------------------------------
--■11■ハシゴB昇りスタート■
function OnEvent_11(proxy, param)
	print("OnEvent_11 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_11 end");
		return;
	end
	
	--はしご昇りに必要な前処理--
	proxy:BeginAction(LOCAL_PLAYER,2,-1,1);			--ホバー移動モードに移行
	--proxy:HoverMoveVal(LOCAL_PLAYER,2007,LadderTime_A);--移動位置(2007)に0.5秒でホバー移動
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1061,191,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動
	proxy:SetEventCommand(LOCAL_PLAYER,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );
	proxy:DisableMove(LOCAL_PLAYER,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご昇りスタートイベントを発行
		proxy:OnKeyTime2(11,"OnEvent_11_1",LadderTime_A,0,0,once);
		--はしご昇り用の関数を1秒間発行(イベントメニューの中断処理?)
		proxy:OnKeyTime2(11,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_11 end");
end

--■11_1■ハシゴA昇りスタート:ホバー移動終了■
function OnEvent_11_1(proxy, param)
	print("OnEvent_11_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_11_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,-1,10);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_11_1 end");
end


--------------------------------------------------------------------------------------
--ハシゴC降り■20
--------------------------------------------------------------------------------------
--■20■ハシゴC降りスタート■
function OnEvent_20(proxy, param)
	print("OnEvent_20 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_20 end");
		return;
	end

	--はしご降りに必要な前処理--
	proxy:BeginAction(LOCAL_PLAYER,2,2,2);				--ホバー移動モードに移行
	--proxy:HoverMoveVal(LOCAL_PLAYER,2032,LadderTime_A);--移動位置(2032)に0.5秒でホバー移動
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1062,192,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動
	proxy:SetEventCommand(LOCAL_PLAYER,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );
	proxy:DisableMove(LOCAL_PLAYER,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行
		proxy:OnKeyTime2(20,"OnEvent_20_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理)
		proxy:OnKeyTime2(20,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_20 end");
end

--■20_1■ハシゴB降りスタート:ホバー移動終了■
function OnEvent_20_1(proxy, param)
	print("OnEvent_20_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_20_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,11,10);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_20_1 end");
end


--------------------------------------------------------------------------------------
--ハシゴC昇り■21
--------------------------------------------------------------------------------------
--■21■ハシゴC昇りスタート■
function OnEvent_21(proxy, param)
	print("OnEvent_21 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_21 end");
		return;
	end
	
	--はしご昇りに必要な前処理--
	proxy:BeginAction(LOCAL_PLAYER,2,-1,1);			--ホバー移動モードに移行
	--proxy:HoverMoveVal(LOCAL_PLAYER,2033,LadderTime_A);--移動位置(2033)に0.5秒でホバー移動
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1062,191,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動
	proxy:SetEventCommand(LOCAL_PLAYER,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );
	proxy:DisableMove(LOCAL_PLAYER,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご昇りスタートイベントを発行
		proxy:OnKeyTime2(21,"OnEvent_21_1",LadderTime_A,0,0,once);
		--はしご昇り用の関数を1秒間発行(イベントメニューの中断処理?)
		proxy:OnKeyTime2(21,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_21 end");
end

--■21_1■ハシゴC昇りスタート:ホバー移動終了■
function OnEvent_21_1(proxy, param)
	print("OnEvent_21_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_21_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,-1,10);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_21_1 end");
end


--------------------------------------------------------------------------------------
--イスタレル■23
--------------------------------------------------------------------------------------
function OnEvent_23(proxy,param)
	if param:IsNetMessage() == false then	
	print("OnEvent_23 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		--アニメ
		proxy:PlayAnimation( 10000 , 8290);
		proxy:PlayAnimation( 1002 , 1);	
		proxy:OnKeyTime2( 23 , "OnEvent_23_0",0.01,0,0,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	print("OnEvent_23 end");
	end
end

function OnEvent_23_0(proxy,param)
	print("OnEvent_23_0 begin");
	--if proxy:IsPlayerStay(10000) == true then
	if proxy:IsEventAnim( 10000 , 8290 ) == true then		
		proxy:LuaCallStart( 23, 2);			
	else
		proxy:ForcePlayAnimation( 1002 , 0);	
	end
	print("OnEvent_23_0 end");
end

--■23_1■アイテム取得■
function OnEvent_23_1(proxy,param)
	print("OnEvent_23_1 begin");
	--アイテム取得関数--パラメータ10419参照
	proxy:GetRateItem(10419);	
	
	--アイテムを取得済み
	proxy:SetEventFlag( 23, true );
	
	--OBJを消すためのイベント配信
	proxy:LuaCallStart( 23, 1);

	print("OnEvent_23_1 end");
end

--■23_2■剣OBJ非表示用■
function OnEvent_23_2(proxy,param)
	print("OnEvent_23_2 begin");
	--オブジェが消える
	proxy:SetDrawEnable( 1002 , false );--ひとまず描画だけOFF
	proxy:SetColiEnable( 1002 , false );--当たりはあるのは不明(現状ではないようなので消さない)
	
	proxy:DeleteEvent( 23 );
	print("OnEvent_23_2 end");
end

--アニメの同期監視
function OnEvent_23_3(proxy,param)
	print("OnEvent_23_3 begin");
	proxy:TreasureDispModeChange2( 1002, false ,KEN_SFX);
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8290 ) == true then--新しいアニメ 
		proxy:PlayAnimation( 1002 , 1);	
		print("OnEvent_23_3 end");
		return true;
	end		
	
	--剣にワープ
	proxy:WarpDmy( LOCAL_PLAYER , 1002 , 191 );
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 23 , LOCAL_PLAYER , 8290 , "OnEvent_23_1", once);
	proxy:NotNetMessage_end();	
	print("OnEvent_23_3 end");	
end

--------------------------------------------------------------------------------------
--跳ね橋A■30
--------------------------------------------------------------------------------------
--■30■跳ね橋■
function OnEvent_30(proxy, param)
	print("OnEvent_30 begin");
	
	if proxy:IsCompleteEvent(30) == true then
		print("ID 30 IsCompleteEvent true"); 
		print("OnEvent_30 end");
		return;
	end

	proxy:PlayAnimation(1000,1);--跳ね橋の作動アニメーション
	proxy:SetEventFlag( 30, 1 );--跳ね橋は作動済み
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_KICK ) == true then
		print("OnEvent_30_1 end");
		return;
	end
	
	proxy:WarpDmy( LOCAL_PLAYER , 1000 , 191 );
	
	print("OnEvent_30 end");
end


--------------------------------------------------------------------------------------
--跳ね橋B■40
--------------------------------------------------------------------------------------
--■40■跳ね橋■
function OnEvent_40(proxy, param)
	print("OnEvent_40 begin");
		
	if proxy:IsCompleteEvent(40) == true then
		print("ID 40 IsCompleteEvent true"); 
		print("OnEvent_40 end");
		return;
	end

	proxy:PlayAnimation(1001,1);--跳ね橋の作動アニメーション
	proxy:SetEventFlag( 40, 1 );--跳ね橋は作動済み
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_KICK ) == true then
		print("OnEvent_40 end");
		return;
	end
	
	proxy:WarpDmy( LOCAL_PLAYER , 1001 , 191 );
	
	print("OnEvent_40 end");
end


--------------------------------------------------------------------------------------
--床抜けA■50
--------------------------------------------------------------------------------------
--■50■床抜けA:登録■
function OnEvent_50(proxy, param)
	print("OnEvent_50 begin");
	
	if proxy:IsDestroyed(1020) == true then
		print("ID 1020 IsDestroyed true");
		print("OnEvent_50 end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--効果音再生
		proxy:PlayObjectSE(1020,500000);
		--0.5秒後に床抜け発動イベントを発行
		proxy:OnKeyTime2(50,"OnEvent_50_1", 0.5,0,0,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_50 end");
end

--■50_1■床抜けA:発動■
function OnEvent_50_1(proxy, param)
	print("OnEvent_50_1 begin");
	
	proxy:ChangeModel(1020, 1);		--モデル差し替え
	proxy:SetBrokenPiece(1020);
	
	proxy:PlayObjectSE(1020,500100);--効果音再生
	proxy:SetEventFlag( 50, 1 );	--床抜け発動済み
	
	print("OnEvent_50_1 end");
end

--------------------------------------------------------------------------------------
--床抜けB■60
--------------------------------------------------------------------------------------
--■60■床抜けB:登録■
function OnEvent_60(proxy, param)
	print("OnEvent_60 begin");
	
	if proxy:IsDestroyed(1021) == true then
		print("ID 1021 IsDestroyed true");
		print("OnEvent_60 end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--効果音再生
		proxy:PlayObjectSE(1021,500000);
		--0.5秒後に床抜け発動イベントを発行
		proxy:OnKeyTime2(60,"OnEvent_60_1", 0.5,0,0,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_60 end");
end

--■60_1■床抜けB:発動■
function OnEvent_60_1(proxy, param)
	print("OnEvent_60_1 begin");
	
	proxy:ChangeModel(1021, 1);		--モデル差し替え
	proxy:SetBrokenPiece(1021);
	
	proxy:PlayObjectSE(1021,500100);--効果音再生
	proxy:SetEventFlag( 60, 1 );	--床抜け発動済み
	
	print("OnEvent_60_1 end");
end


--------------------------------------------------------------------------------------
--ボス部屋の中に入る■160
--------------------------------------------------------------------------------------

--■イベントがループなので、全部リピートにする↓

--■160■中ボス部屋への扉が開く■
function OnEvent_160(proxy,param)
	print("OnEvent_160 begin");

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_160 end");
		return;
	end
	
	--クライアントへ、ボス部屋阻止失敗を通知
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 161 , 1 );--旋回アニメの同期再生
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE , true );--多重発動防止用フラグON
	--多重起動システムIDをタイムアウトを設定してONにする
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_160 end");
end


--旋回アニメの同期再生(IDが別)
function OnEvent_161_1(proxy,param)
	print("OnEvent_161_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を行い、その終了時にOnEvent_161_2を発行する
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2891 );
		else
			proxy:LockSession();--ルームをロックします！
			--旋回アニメ再生を行い、その終了時にOnEvent_161_2を発行する
			proxy:OnTurnCharactorEnd( 161, LOCAL_PLAYER, 2891, "OnEvent_161_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_161_1 end");
end

--旋回アニメの同期再生終了後
function OnEvent_161_2(proxy,param)
	print("OnEvent_161_2 begin");
	
	--同期用歩きアニメ再生
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 161, LOCAL_PLAYER, ANIMEID_WALK, "OnEvent_161_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();

	print("OnEvent_161_2 end");
end

--歩きアニメの同期再生終了後
function OnEvent_161_3(proxy,param)
	print("OnEvent_161_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ
	if proxy:IsCompleteEvent( 160 ) == false then
		proxy:LuaCallStart( 161 , 5 );--2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知
		proxy:LuaCallStart( 161 , 6 );--フラグセット(同期用)
		Lua_MultiDoping(proxy,808);--マルチプレイドーピング
	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない)
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:ResetThink( 808 );
	end	
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );

	print("OnEvent_161_3 end");
end


--■160 2回目以降にボス部屋に入るためのイベント配信用
function OnEvent_160_GO_TO_IN(proxy, param)
	print("OnEvent_160_GO_TO_IN begin");
		
	proxy:NotNetMessage_begin();
		--▼161▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_160
		proxy:OnPlayerActionInRegion( 161, 2895, "OnEvent_160", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	
	print("OnEvent_160_GO_TO_IN end");
end


--■160 フラグセット(同期用)
function OnEvent_160_flag_set(proxy, param)
	print("OnEvent_160_flag_set begin");
		
	proxy:SetEventFlag( 160 , 1 );
	proxy:DeleteEvent( 160 );

	print("OnEvent_160_flag_set end");
end


--------------------------------------------------------------------------------------
--中ボスポリ劇再生■162
--------------------------------------------------------------------------------------
--■162■中ボス主張演出■
function OnEvent_162(proxy, param)
	print("OnEvent_162 begin");
	--中ボス登場ポリ劇
	proxy:RequestRemo(50000,REMO_FLAG,162,1);
	proxy:SetEventFlag( 162 , 1 );	
	print("OnEvent_162 end");
end

function OnEvent_162_RemoStart(proxy,param)
	print("OnEvent_162_RemoStart begin");
	--特に無し
	print("OnEvent_162_RemoStart end");
end

function OnEvent_162_RemoFinish(proxy,param)
	print("OnEvent_162_RemoFinish begin");
	--特に無し
	print("OnEvent_162_RemoFinish end");
end


--------------------------------------------------------------------------------------
--ボスが動き出す(戦闘開始)■163
--------------------------------------------------------------------------------------

function OnEvent_163(proxy, param)
	print("OnEvent_163 begin");
	
	--ボス戦用BGM再生開始
	proxy:PlayPointSE( 2120, SOUND_TYPE_M, 50000000, 0 );--領域のIDのみ未定
	
	proxy:SetDrawEnable( 808, true );
	
	--ボスロジックON
	proxy:EnableLogic( 808 , true );
	
	proxy:SetEventFlag( 163, true );
	
	--読み込みタイミングのとき毎回追加されてほしいのでフラグたてない
	
	--ボスゲージ表示
	proxy:SetBossGauge(808 , 0, 5090);
	
	print("OnEvent_163 end");
end


--------------------------------------------------------------------------------------
--■5650■ボス死亡■
--------------------------------------------------------------------------------------
--■5650■ボス死亡■
function OnEvent_5650(proxy,param)
	print("OnEvent_5650 begin");
	
	proxy:NotNetMessage_begin();
		--1秒後にアイテム取得イベントを発行--
		proxy:OnKeyTime2(5650,"OnEvent_5650_1", 1.0,0,0,once);
		--2秒後に崩れる壁発動イベントを発行--
		proxy:OnKeyTime2(5652,"OnEvent_5652", 2.0,0,0,once);
		
		--マルチ解散監視
		proxy:OnRegistFunc( 5650,"Check_5650_PT","OnEvent_5650_PT",0,once);
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( 5650, true );--フラグを立てる。
	
	--蛭沼のダメージ床監視削除
	proxy:DeleteEvent(5730);
	
	--既に蛭沼に入っている人はここで解除
	proxy:EraseEventSpecialEffect(LOCAL_PLAYER, 10060);
	
	--ブロッククリア処理へ
	proxy:CustomLuaCallStart( 4050, 808 );
	--トカゲリセット
	ResetTokage(proxy);
	
	print("OnEvent_5650 end");
end

--▲5650_1▲1秒後▲
function OnEvent_5650_1(proxy, param)
	print("OnEvent_5650_1 begin");
	
	--ボスを倒した数を更新(数によってフラグを立てる)
	GetBossFlagCount( proxy, param );
		
	--▼トロフィー取得判定▼
	Lua_RequestUnlockTrophy(proxy, 34);
		
	--乞食(女)の初期化用
	OnEvent_812(proxy, param);

	--ホストプレイヤーのみアイテム入手イベントに使用
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	
	--宝死体(ソウル?)有効化
	proxy:SetDrawEnable( 1982 , true );
	proxy:SetColiEnable( 1982 , true );
	--ソウルに刺さった剣有効化
	proxy:SetDrawEnable( 1975 , true );
	proxy:SetColiEnable( 1975 , true );
		
	--▼(ソウル)アイテム取得用イベント監視追加▼
	if proxy:IsCompleteEvent( 5653 ) == false then
		--SFX 有効化
		proxy:ValidSfx( 2150 );--要石のオーラ
		proxy:ValidSfx( 2151 );--光の粒子
		proxy:TreasureDispModeChange2( 1982, true ,KANAME_SFX);--光らせる
		--proxy:TreasureDispModeChange2( 1975, true ,KANAME_SFX);--光らせる
		proxy:OnDistanceActionAttribute( 5653 , LOCAL_PLAYER , 1982 , "OnEvent_5653" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end		
		
	print("OnEvent_5650_1 end");
end

--▲5652▲2秒後▲
function OnEvent_5652(proxy, param)
	print("OnEvent_5652 begin");
	
	--ボス戦用のBGM停止
	proxy:StopPointSE( 0 );

	proxy:SetEventFlag( 5652, true );

	print("OnEvent_5652 end");
end

--マルチ解散監視
function Check_5650_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;	
end

function OnEvent_5650_PT(proxy,param)
	print("OnEvent_5650_PT begin");
	--中ボス部屋の前後の魔法壁が消える(全プレイヤー)
	proxy:SetColiEnable( 1999 , false );
	proxy:SetColiEnable( 1995 , false );
	
	proxy:SetDrawEnable( 1999 , false );
	proxy:SetDrawEnable( 1995 , false );	

	--光の壁Sfxを消す
	proxy:InvalidSfx( 1987, true );
	proxy:InvalidSfx( 1991, true );

	
	--中ボス部屋前の移動処理イベントを削除
	proxy:DeleteEvent( 160 );--一人目が入るとき用
	proxy:DeleteEvent( 161 );--二人目以降が入るとき用
	print("OnEvent_5650_PT end");
end
--------------------------------------------------------------------------------------
--■5653■ソウル入手■
--------------------------------------------------------------------------------------
function OnEvent_5653(proxy, param)
	print("OnEvent_5653 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ 
		print("OnEvent_5653 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行
		proxy:OnKeyTime2( 5653, "OnEvent_5653_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_5653 end");
end


--■5653_1■アイテム取得■
function OnEvent_5653_1(proxy, param)
	print("OnEvent_5653_1 begin");

	--アイテム取得関数--パラメータ10232参照
	proxy:GetRateItem(10450);
	proxy:GetRateItem(10470);
	proxy:GetRateItem(10471);
	proxy:GetRateItem(10472);
	proxy:GetRateItem(10473);
	
	--アイテムを取得済み
	proxy:SetEventFlag( 5653, 1 );

	--宝箱シェーダーOFF
	--proxy:TreasureDispModeChange( 1982 , false );

	--SFXが消える
	proxy:InvalidSfx( 2150 , true );--要石のオーラ
	--proxy:InvalidSfx( 2151 , true );--光の粒子
		
	--▼要石でワープ用の監視を追加▼
	proxy:OnDistanceActionAttribute( 5654 , LOCAL_PLAYER , 1982 , "OnEvent_5654" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_5653_1 end");
end

--------------------------------------------------------------------------------------
--揺れるつり橋A■70
--------------------------------------------------------------------------------------
--■70■つり橋A揺れ発動■
function OnEvent_70(proxy,param)	
	if proxy:IsPlayerStay(LOCAL_PLAYER) == false then		
--		print("Player Is Move");		
		--つり橋が揺れるアニメーション再生
		proxy:PlayAnimation(1034,1);				
	end
end


--------------------------------------------------------------------------------------
--揺れるつり橋B■80
--------------------------------------------------------------------------------------
--■80■つり橋B揺れ発動■
function OnEvent_80(proxy,param)	
	if proxy:IsPlayerStay(LOCAL_PLAYER) == false then			
--		print("Player Is Move");		
		--つり橋が揺れるアニメーション再生
		proxy:PlayAnimation(1035,1);		
	end	
end


--------------------------------------------------------------------------------------
--揺れるつり橋C■90
--------------------------------------------------------------------------------------
--■90■つり橋C揺れ発動■
function OnEvent_90(proxy,param)	
	if proxy:IsPlayerStay(LOCAL_PLAYER) == false then	
--		print("Player Is Move");	
		--つり橋が揺れるアニメーション再生
		proxy:PlayAnimation(1036,1);			
	end	
end


--------------------------------------------------------------------------------------
--揺れるつり橋D■100
--------------------------------------------------------------------------------------
--■100■つり橋D揺れ発動■
function OnEvent_100(proxy,param)	
	if proxy:IsPlayerStay(LOCAL_PLAYER) == false then		
--		print("Player Is Move");		
		--つり橋が揺れるアニメーション再生
		proxy:PlayAnimation(1037,1);			
	end
end

--------------------------------------------------------------------------------------
--ふわふわ足場■130
--------------------------------------------------------------------------------------

--■130■上の領域侵入■
function OnEvent_130_1(proxy,param)	
	print("OnEvent_130_1 begin");
	
	--下側の領域進入イベントを発行
	proxy:RepeatMessage_begin();
		proxy:OnRegionIn( 131,LOCAL_PLAYER,2041,"OnEvent_130_2", once );
	proxy:RepeatMessage_end();

	print("OnEvent_130_1 end");
end

--■130■下の領域侵入■
function OnEvent_130_2(proxy,param)	
	print("OnEvent_130_2 begin");
	
	--上側の領域進入イベントを発行
	proxy:RepeatMessage_begin();
		proxy:OnRegionIn( 130,LOCAL_PLAYER,2040,"OnEvent_130_1", once );
	proxy:RepeatMessage_end();
	
	proxy:PlayAnimation( 1040 , 1 );--ふわふわアニメ再生
	
	print("OnEvent_130_2 end");
end

--■131■ふわふわアニメ(領域内移動)■
function OnEvent_131(proxy,param)
	if proxy:IsPlayerStay(LOCAL_PLAYER) == false then	
		--ふわふわアニメ再生
		proxy:PlayAnimation(1040,1);			
	end	
end

--■132■ふわふわアニメ(領域内移動)■
function OnEvent_132(proxy,param)
	if proxy:IsPlayerStay(LOCAL_PLAYER) == false then	
		--ふわふわアニメ再生
		proxy:PlayAnimation(1050,1);			
	end	
end
--■133■ふわふわアニメ(領域内移動)■
function OnEvent_133(proxy,param)
	if proxy:IsPlayerStay(LOCAL_PLAYER) == false then	
		--ふわふわアニメ再生
		proxy:PlayAnimation(1051,1);			
	end	
end

--------------------------------------------------------------------------------------
--からす飛び立つ■110
--------------------------------------------------------------------------------------
function Check_110(proxy)	
	--ココは毎フレーム監視されるのでprintを入れるのはお勧めしません。テストの時だけにしてください。
	if proxy:CheckChrHit_Obj(LOCAL_PLAYER,1039) == true then
		--条件が成立した瞬間なので、ココにはprintを入れておくことをお勧めします
		print("Check_110 true");
		return true
	end
	return false;
end

function OnEvent_110(proxy,param)
	print("OnEvent_110 begin");
	local animId = {10,10,10,11,11,11,12,12,12};
	local objId = {1041,1042,1043,1044,1045,1046,1047,1048,1049};
	for index = 1, 9, 1 do
		proxy:PlayAnimation( objId[index], animId[index] );
	end
	
	proxy:SetEventFlag( 110 , 1 );
	
	print("OnEvent_110 end");
end


--------------------------------------------------------------------------------------
--■280■石柱にワープ■
--------------------------------------------------------------------------------------

--■280■石柱にワープ■
function OnEvent_280(proxy,param)	

	if proxy:IsCompleteEvent( 280 ) == true then
		return;
	end
	
	if param:IsNetMessage() == true then
		return;
	end
	
	
	print("OnEvent_280 begin");
	
	--セッション中ならば、要石のワープ無効
	if proxy:IsSession() == false then--セッション中ではない
		proxy:RepeatMessage_begin();
			--▼659_1▼選択メニューの監視▼
			proxy:OnSelectMenu(280, "OnEvent_280_0", 10010710, 0, 2, 1983, 2, once);			
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

	print("OnEvent_280 end");
end

--▲280_0▲選択メニューの監視▲
function OnEvent_280_0(proxy, param)
	print("OnEvent_280_0 begin");
	
	if proxy:IsSession() == false then
		
		proxy:PlayAnimation( LOCAL_PLAYER , 8283 );--要石に触れるアニメを再生
		proxy:NoAnimeTurnCharactor( 10000 , 1983 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--▼要石に触れるアニメ再生終了▼
			proxy:OnChrAnimEnd( 280 , LOCAL_PLAYER , 8283 , "OnEvent_280_1" , once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 280 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_280_0 end");
end

--▲280_1▲選択メニューの監視▲
function OnEvent_280_1(proxy, param)
	print("OnEvent_280_1 begin");
	
	proxy:SetEventFlag( 280 , 0 );
	
	proxy:PlayAnimation( LOCAL_PLAYER , 8284 );--自世界に帰るアニメを再生

	proxy:SetEventFlag( 280 , 1 );
	
	OnEvent_280_2(proxy,param);
	
	print("OnEvent_280_1 end");
end

--▲要石に触れるアニメ再生終了▲
function OnEvent_280_2(proxy,param)	
	print("OnEvent_280_2 begin");
	
	--石柱へ戻ってきた判定のフラグを立てる
	proxy:SetEventFlag(8083, true);

	proxy:SetEventFlag( 280 , 0 );
	--完全回復要求
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1009 );
	
	print("OnEvent_280_2 end");
end


--------------------------------------------------------------------------------------
--■5654■石柱にワープ■
--------------------------------------------------------------------------------------
function OnEvent_5654(proxy,param)	
	print("OnEvent_5654 begin");
	
	if proxy:IsCompleteEvent( 5654 ) == true then
		return;
	end
	
	proxy:RepeatMessage_begin();
		--▼_1▼選択メニューの監視▼
		proxy:OnSelectMenu(5654, "OnEvent_5654_1", 10010710, 0, 2, 1982, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_5654 end");
end

--▲5654_1▲選択メニューの監視▲
function OnEvent_5654_1(proxy,param)	
	print("OnEvent_5654_1 begin");

	if proxy:IsSession() == false then
		
		proxy:PlayAnimation(LOCAL_PLAYER,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1982 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--▲要石に触れるアニメ再生終了したら▲
			proxy:OnChrAnimEnd( 5654 , LOCAL_PLAYER , 8283 , "OnEvent_5654_2",once);
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(5654,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_5654_1 end");
end

--▲5654_2▲要石に触れるアニメ再生終了▲
function OnEvent_5654_2(proxy,param)	
	print("OnEvent_5654_2 begin");
	
	proxy:SetEventFlag(5654,false);
	
	proxy:PlayAnimation(LOCAL_PLAYER,8284);
	
	proxy:SetEventFlag(5654,true);
	--ワープ処理開始
	OnEvent_5654_3(proxy,param);
	
	print("OnEvent_5654_2 end");
end

--▲自世界に帰るアニメ再生終了▲
function OnEvent_5654_3(proxy,param)	
	print("OnEvent_5654_3 begin");
	
	--石柱へ戻ってきた判定のフラグを立てる
	proxy:SetEventFlag(8083, true);

	proxy:SetEventFlag(5654,false);
	--完全回復要求
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1009 );
	
	print("OnEvent_5654_3 end");
end

--------------------------------------------------------------------------------------
--死んだフリ腐敗人■140
--------------------------------------------------------------------------------------
--■140■死んだフリ腐敗人■
function OnEvent_140(proxy,param)
	print("OnEvent_140 begin");
	
	if proxy:IsAlive( 500 ) == true then
	
		--起き上がりアニメ再生
		--proxy:SetEventCommand( 500, 201 );
		proxy:PlayAnimation( 500 , 9920);		
		proxy:SetSpStayAndDamageAnimId( 500 ,-1,-1);
		--当たりを有効に設定
		proxy:SetColiEnable(500, true);	
		--ロジックを再開
		proxy:EnableLogic( 500, true );
		--索敵をOn（ロック可能にする）
		proxy:EnableHide( 500, false );
		
	end
	
	--フラグをセット
	proxy:SetEventFlag( 140, 1 );

	print("OnEvent_140 end");
end

--------------------------------------------------------------------------------------
--死んだフリ腐敗人■141
--------------------------------------------------------------------------------------
--■141■死んだフリ腐敗人■
function OnEvent_141(proxy,param)
	print("OnEvent_141 begin");
	
	if proxy:IsAlive( 501 ) == true then
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新
		proxy:ForceUpdateNextFrame( 501 );
		--起き上がりアニメ再生
		--proxy:SetEventCommand( 501, 201 );
		proxy:PlayAnimation( 501,9920 );
		proxy:SetSpStayAndDamageAnimId( 501 ,-1,-1);
		--当たりを有効に設定
		proxy:SetColiEnable(501, true);
		--ロジックを再開
		proxy:EnableLogic( 501, true );
		--索敵をOn（ロック可能にする）
		proxy:EnableHide( 501, false );
		
		
	end
	
	if proxy:IsAlive( 502 ) == true then
	
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新
		proxy:ForceUpdateNextFrame( 502 );
		--起き上がりアニメ再生
		--proxy:SetEventCommand( 502, 202 );--9800
		proxy:PlayAnimation( 502 , 9800 );
		proxy:SetSpStayAndDamageAnimId( 502 ,-1,-1);
		--当たりを有効に設定
		proxy:SetColiEnable(502, true);
		--ロジックを再開
		proxy:EnableLogic( 502, true );
		--索敵をOn（ロック可能にする）
		proxy:EnableHide( 502, false );		
	end
	
	--フラグをセット
	proxy:SetEventFlag( 141, 1 );

	--このイベントへの反応領域が2つあり、(登録IDは同じ)
	--片方が反応すると、もう片方は反応しないようにする。
	--パーティープレイヤーの監視も含め ここで削除。
	proxy:DeleteEvent( 141 );
	
	print("OnEvent_141 end");
end

--------------------------------------------------------------------------------------
--死んだフリ腐敗人■142
--------------------------------------------------------------------------------------
--■142■死んだフリ腐敗人■
function OnEvent_142(proxy,param)	
	print("OnEvent_142 begin");
	
	if proxy:IsAlive( 503 ) == true then
	
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新
		proxy:ForceUpdateNextFrame( 503 );
		--起き上がりアニメ再生
		--proxy:SetEventCommand( 503, 201 );
		proxy:PlayAnimation( 503 ,9920 );
		proxy:SetSpStayAndDamageAnimId( 503 ,-1,-1);
		--当たりを有効に設定
		proxy:SetColiEnable(503, true);	
		--ロジックを再開
		proxy:EnableLogic( 503, true );
		--索敵をOn（ロック可能にする）
		proxy:EnableHide( 503, false );
	end
	
	--フラグをセット
	proxy:SetEventFlag( 142, 1 );
	
	print("OnEvent_142 end");
end

--------------------------------------------------------------------------------------
--死んだフリ腐敗人■143
--------------------------------------------------------------------------------------
--■143■死んだフリ腐敗人■
function OnEvent_143(proxy,param)
	print("OnEvent_143 begin");
	
	if proxy:IsAlive( 504 ) == true then
	
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新
		proxy:ForceUpdateNextFrame( 504 );
		--起き上がりアニメ再生
		--proxy:SetEventCommand( 504, 201 );
		proxy:PlayAnimation( 504 , 9920 );
		proxy:SetSpStayAndDamageAnimId( 504 ,-1,-1);	
		--当たりを有効に設定
		proxy:SetColiEnable(504, true);
		--ロジックを再開
		proxy:EnableLogic( 504, true );
		--索敵をOn（ロック可能にする）
		proxy:EnableHide( 504, false );		
	end
	
	if proxy:IsAlive( 505 ) == true then
		
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新
		proxy:ForceUpdateNextFrame( 505 );
		--起き上がりアニメ再生
		--proxy:SetEventCommand( 505, 202 );--9800
		proxy:PlayAnimation( 505 , 9800 );
		proxy:SetSpStayAndDamageAnimId( 505 ,-1,-1);
		--当たりを有効に設定
		proxy:SetColiEnable(505, true);
		--ロジックを再開
		proxy:EnableLogic( 505, true );
		--索敵をOn（ロック可能にする）
		proxy:EnableHide( 505, false );
	end
	
	--フラグをセット
	proxy:SetEventFlag( 143, 1 );
	
	--このイベントへの反応領域が2つあり、(登録IDは同じ)
	--片方が反応すると、もう片方は反応しないようにする。
	--パーティープレイヤーの監視も含め ここで削除。
	proxy:DeleteEvent( 143 );
	
	print("OnEvent_143 end");
end


--------------------------------------------------------------------------------------
--死んだフリ腐敗人■144
--------------------------------------------------------------------------------------
--■144■死んだフリ腐敗人■
function OnEvent_144(proxy,param)
	print("OnEvent_144 begin");
	
	if proxy:IsAlive( 506 ) == true then
	
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新
		proxy:ForceUpdateNextFrame( 506 );
		--起き上がりアニメ再生
		--proxy:SetEventCommand( 506, 201 );
		proxy:PlayAnimation( 506 , 9920 );
		proxy:SetSpStayAndDamageAnimId( 506 ,-1,-1);
		--当たりを有効に設定
		proxy:SetColiEnable(506, true);
		--ロジックを再開
		proxy:EnableLogic( 506, true );
		--索敵をOn（ロック可能にする）
		proxy:EnableHide( 506, false );
	end
	
	--フラグをセット
	proxy:SetEventFlag( 144, 1 );

	print("OnEvent_144 end");
end


--------------------------------------------------------------------------------------
--死んだフリ腐敗人■145
--------------------------------------------------------------------------------------
--■145■死んだフリ腐敗人■
function OnEvent_145(proxy,param)
	print("OnEvent_145 begin");
	
	if proxy:IsAlive( 507 ) == true then
	
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新
		proxy:ForceUpdateNextFrame( 507 );
		--起き上がりアニメ再生
		--proxy:SetEventCommand( 507, 201 );
		proxy:PlayAnimation( 507 , 9920 );
		proxy:SetSpStayAndDamageAnimId( 507 ,-1,-1);		
		--当たりを有効に設定
		proxy:SetColiEnable(507, true);
		--ロジックを再開
		proxy:EnableLogic( 507, true );
		--索敵をOn（ロック可能にする）
		proxy:EnableHide( 507, false );
	end
	
	if proxy:IsAlive( 508 ) == true then
		
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新
		proxy:ForceUpdateNextFrame( 508 );
		--起き上がりアニメ再生
		--proxy:SetEventCommand( 508, 202 );--9800
		proxy:PlayAnimation( 508 , 9800 );
		proxy:SetSpStayAndDamageAnimId( 508 ,-1,-1);
		--当たりを有効に設定
		proxy:SetColiEnable(508, true);
		--ロジックを再開
		proxy:EnableLogic( 508, true );
		--索敵をOn（ロック可能にする）
		proxy:EnableHide( 508, false );
	end
	
	--フラグをセット
	proxy:SetEventFlag( 145, 1 );
	
	--このイベントへの反応領域が2つあり、(登録IDは同じ)
	--片方が反応すると、もう片方は反応しないようにする。
	--パーティープレイヤーの監視も含め ここで削除。
	proxy:DeleteEvent( 145 );

	print("OnEvent_145 end");
end


--------------------------------------------------------------------------------------
--死んだフリ腐敗人■146
--------------------------------------------------------------------------------------
--■146■死んだフリ腐敗人■
function OnEvent_146(proxy,param)
	print("OnEvent_146 begin");
	
	if proxy:IsAlive( 509 ) == true then	
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新
		proxy:ForceUpdateNextFrame( 509 );
		--起き上がりアニメ再生
		--proxy:SetEventCommand( 509, 203 );--7000
		proxy:PlayAnimation( 509 , 7000 );
		proxy:SetSpStayAndDamageAnimId( 509 ,-1,-1);
		--当たりを有効に設定
		proxy:SetColiEnable(509, true);
		--ロジックを再開
		proxy:EnableLogic( 509, true );
		--索敵をOn（ロック可能にする）
		proxy:EnableHide( 509, false );
	end
	
	if proxy:IsAlive( 510 ) == true then
		
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新
		proxy:ForceUpdateNextFrame( 510 );
		--起き上がりアニメ再生
		--proxy:SetEventCommand( 510, 203 );--7000
		proxy:PlayAnimation( 510 , 7000 );
		proxy:SetSpStayAndDamageAnimId( 510 ,-1,-1);
		--当たりを有効に設定
		proxy:SetColiEnable(510, true);
		--ロジックを再開
		proxy:EnableLogic( 510, true );
		--索敵をOn（ロック可能にする）
		proxy:EnableHide( 510, false );
	end
	
	--フラグをセット
	proxy:SetEventFlag( 146, 1 );

	print("OnEvent_146 end");
end


--------------------------------------------------------------------------------------
--死んだフリ腐敗人■147
--------------------------------------------------------------------------------------
--■147■死んだフリ腐敗人■
function OnEvent_147(proxy,param)
	print("OnEvent_147 begin");
	
	if proxy:IsAlive( 511 ) == true then
	
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新
		proxy:ForceUpdateNextFrame( 511 );
		--起き上がりアニメ再生
		--proxy:SetEventCommand( 511, 201 );
		proxy:PlayAnimation( 511 , 9920 );
		proxy:SetSpStayAndDamageAnimId( 511 ,-1,-1);
		--当たりを有効に設定
		proxy:SetColiEnable(511, true);
		--ロジックを再開
		proxy:EnableLogic( 511, true );
		--索敵をOn（ロック可能にする）
		proxy:EnableHide( 511, false );
	end
	
	if proxy:IsAlive( 512 ) == true then
		
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新
		proxy:ForceUpdateNextFrame( 512 );
		--起き上がりアニメ再生
		--proxy:SetEventCommand( 512, 202 );--9800
		proxy:PlayAnimation( 512 , 9800 );
		proxy:SetSpStayAndDamageAnimId( 512 ,-1,-1);
		--当たりを有効に設定
		proxy:SetColiEnable(512, true);
		--ロジックを再開
		proxy:EnableLogic( 512, true );
		--索敵をOn（ロック可能にする）
		proxy:EnableHide( 512, false );
	end
	
	--フラグをセット
	proxy:SetEventFlag( 147, 1 );
	
	--このイベントへの反応領域が2つあり、(登録IDは同じ)
	--片方が反応すると、もう片方は反応しないようにする。
	--パーティープレイヤーの監視も含め ここで削除。
	proxy:DeleteEvent( 147 );

	print("OnEvent_147 end");
end


--------------------------------------------------------------------------------------
--死んだフリ腐敗人■148
--------------------------------------------------------------------------------------
--■148■死んだフリ腐敗人■
function OnEvent_148(proxy,param)
	print("OnEvent_148 begin");
	
	if proxy:IsAlive( 513 ) == true then
	
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新
		proxy:ForceUpdateNextFrame( 513 );
		--起き上がりアニメ再生
		--proxy:SetEventCommand( 513, 203 );--7000
		proxy:PlayAnimation( 513 , 7000 );
		proxy:SetSpStayAndDamageAnimId( 513 ,-1,-1);		
		--当たりを有効に設定
		proxy:SetColiEnable(513, true);
		--ロジックを再開
		proxy:EnableLogic( 513, true );
		--索敵をOn（ロック可能にする）
		proxy:EnableHide( 513, false );
	
	end
	
	if proxy:IsAlive( 514 ) == true then
		
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新
		proxy:ForceUpdateNextFrame( 514 );
		--起き上がりアニメ再生
		--proxy:SetEventCommand( 514, 202 );--9800
		proxy:PlayAnimation( 514 , 9800 );
		proxy:SetSpStayAndDamageAnimId( 514 ,-1,-1);
		--当たりを有効に設定
		proxy:SetColiEnable(514, true);
		--ロジックを再開
		proxy:EnableLogic( 514, true );
		--索敵をOn（ロック可能にする）
		proxy:EnableHide( 514, false );
		
	end
	
	if proxy:IsAlive( 515 ) == true then
		
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新
		proxy:ForceUpdateNextFrame( 515 );
		--起き上がりアニメ再生
		--proxy:SetEventCommand( 515, 201 );
		proxy:PlayAnimation( 515 , 9920 );
		proxy:SetSpStayAndDamageAnimId( 515 ,-1,-1);
		--当たりを有効に設定
		proxy:SetColiEnable(515, true);
		--ロジックを再開
		proxy:EnableLogic( 515, true );
		--索敵をOn（ロック可能にする）
		proxy:EnableHide( 515, false );
		
	end
	
	--フラグをセット
	proxy:SetEventFlag( 148, 1 );

	print("OnEvent_148 end");
end


--------------------------------------------------------------------------------------
--死んだフリ腐敗人■149
--------------------------------------------------------------------------------------
--■149■死んだフリ腐敗人■
function OnEvent_149(proxy,param)
	print("OnEvent_149 begin");
	
	if proxy:IsAlive( 516 ) == true then
	
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新
		proxy:ForceUpdateNextFrame( 516 );
		--起き上がりアニメ再生
		--proxy:SetEventCommand( 516, 202 );--9800
		proxy:PlayAnimation( 516 , 9800 );
		proxy:SetSpStayAndDamageAnimId( 516 ,-1,-1);
		--当たりを有効に設定
		proxy:SetColiEnable(516, true);
		--ロジックを再開
		proxy:EnableLogic( 516, true );
		--索敵をOn（ロック可能にする）
		proxy:EnableHide( 516, false );
	
	end
	
	--フラグをセット
	proxy:SetEventFlag( 149, 1 );

	print("OnEvent_149 end");
end


--------------------------------------------------------------------------------------
--小石が振ってくる■150
--------------------------------------------------------------------------------------
--■150■小石が振ってくる■
function OnEvent_150(proxy,param)
	print("OnEvent_150 begin");
	--モデルを差し替えて落とす
	proxy:ChangeModel(1070,1);
	proxy:ChangeModel(1071,1);
	proxy:ChangeModel(1072,1);
	proxy:ChangeModel(1073,1);
	proxy:ChangeModel(1074,1);
	proxy:ChangeModel(1075,1);
	
	proxy:PlayTypeSE( 1070, SOUND_TYPE_O, 513005140 );
	
	--1秒後でずらして、開始直後に付近のマップパーツに当たるのを防ぐ
	proxy:OnKeyTime2( 150, "OnEvent_150_1", 1.0, 0, 1, once );

	print("OnEvent_150 end");
end

function OnEvent_150_1(proxy,param)
	print("OnEvent_150_1 begin");
	
	--落下岩ダメージ球
	local paramid = 10040; --落下岩ダメージ
	local rad    = 0.5;--半径(あとで、正式な値になるはず･･･今は適当)
	local time   = 5; --ひとまずアニメ再生終了でダメージ球消すので、アニメより長い時間を指定しておく
	--▼150_hit▼石1があたったとき▼
	--proxy:OnObjectDamageHit_NoCall( 150, 1070, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	proxy:OnObjectDamageHit( 150, 1070, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_150_1070hit", once );
	--▼150_hit▼石2があたったとき▼
	--proxy:OnObjectDamageHit_NoCall( 150, 1071, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	proxy:OnObjectDamageHit( 150, 1071, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_150_1071hit", once );
	--▼150_hit▼石3があたったとき▼
	--proxy:OnObjectDamageHit_NoCall( 150, 1072, 1, paramid, EV_HIT_ALL ,  rad, time,  once );	
	proxy:OnObjectDamageHit( 150, 1072, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_150_1072hit", once );
	--▼150_hit▼石4があたったとき▼
	proxy:OnObjectDamageHit_NoCall( 150, 1073, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	--▼150_hit▼石5があたったとき▼
	proxy:OnObjectDamageHit_NoCall( 150, 1074, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	--▼150_hit▼石6があたったとき▼
	proxy:OnObjectDamageHit_NoCall( 150, 1075, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	
	proxy:OnKeyTime2( 150, "OnEvent_150_bloken", time, 0, 2, once );
	
	print("OnEvent_150_1 end");
end

function OnEvent_150_1070hit(proxy,param)
	print("OnEvent_150_1070hit begin");

	--マトリクス移動、モデル差し替え<2>、初速度、物理インスタンス消し
	SecondStageBreak(proxy, 1070, 2 );
	
	print("OnEvent_150_1070hit end");
end


function OnEvent_150_1071hit(proxy,param)
	print("OnEvent_150_1071hit begin");
	
	--マトリクス移動、モデル差し替え<2>、初速度、物理インスタンス消し
	SecondStageBreak(proxy, 1071, 2 );
	
	print("OnEvent_150_1071hit end");
end


function OnEvent_150_1072hit(proxy,param)
	print("OnEvent_150_1072hit begin");
	
	--マトリクス移動、モデル差し替え<2>、初速度、物理インスタンス消し
	SecondStageBreak(proxy, 1072, 2 );
	
	print("OnEvent_150_1072hit end");
end

function OnEvent_150_bloken(proxy,param)
	print("OnEvent_150_bloken begin");
	
	proxy:SetBrokenPiece(1070);
	proxy:SetBrokenPiece(1071);
	proxy:SetBrokenPiece(1072);
	proxy:SetBrokenPiece(1073);
	proxy:SetBrokenPiece(1074);
	proxy:SetBrokenPiece(1075);
	
	--フラグをセット
	proxy:SetEventFlag( 150, true );
	
	print("OnEvent_150_bloken end");
end

--------------------------------------------------------------------------------------
--小石が振ってくる■151
--------------------------------------------------------------------------------------
--■151■小石が振ってくる■
function OnEvent_151(proxy,param)
	print("OnEvent_151 begin");
	--モデルを差し替えて落とす
	proxy:ChangeModel(1064,1);
	proxy:ChangeModel(1065,1);
	proxy:ChangeModel(1066,1);
	proxy:ChangeModel(1067,1);
	proxy:ChangeModel(1068,1);
	proxy:ChangeModel(1069,1);
	
	proxy:PlayTypeSE( 1064, SOUND_TYPE_O, 513005140 );
	
	--1秒後でずらして、開始直後に付近のマップパーツに当たるのを防ぐ
	proxy:OnKeyTime2( 151, "OnEvent_151_1", 1.0, 0, 1, once );
	print("OnEvent_151 end");
end

function OnEvent_151_1(proxy,param)
	print("OnEvent_151_1 begin");
	
	--落下岩ダメージ球
	local paramid = 10040; --落下岩ダメージ
	local rad    = 0.5;--半径(あとで、正式な値になるはず･･･今は適当)
	local time   = 5; --ひとまずアニメ再生終了でダメージ球消すので、アニメより長い時間を指定しておく
	--▼151_hit▼石1があたったとき▼
	proxy:OnObjectDamageHit( 151, 1064, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_151_1064hit", once );
	--▼151_hit▼石2があたったとき▼
	proxy:OnObjectDamageHit( 151, 1065, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_151_1065hit", once );
	--▼151_hit▼石3があたったとき▼
	proxy:OnObjectDamageHit( 151, 1066, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_151_1066hit", once );
	--▼151_hit▼石4があたったとき▼
	proxy:OnObjectDamageHit_NoCall( 151, 1067, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	--▼151_hit▼石5があたったとき▼
	proxy:OnObjectDamageHit_NoCall( 151, 1068, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	--▼151_hit▼石6があたったとき▼
	proxy:OnObjectDamageHit_NoCall( 151, 1069, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	
	proxy:OnKeyTime2( 151, "OnEvent_151_bloken", time, 0, 2, once );
	
	print("OnEvent_151_1 end");
end

function OnEvent_151_1064hit(proxy,param)
	print("OnEvent_151_1064hit begin");
	
	--マトリクス移動、モデル差し替え<2>、初速度、物理インスタンス消し
	SecondStageBreak(proxy, 1064, 2 );
	
	print("OnEvent_151_1064hit end");
end

function OnEvent_151_1065hit(proxy,param)
	print("OnEvent_151_1065hit begin");
	
	--マトリクス移動、モデル差し替え<2>、初速度、物理インスタンス消し
	SecondStageBreak(proxy, 1065, 2 );
	
	print("OnEvent_151_1065hit end");
end

function OnEvent_151_1066hit(proxy,param)
	print("OnEvent_151_1066hit begin");
	
	--マトリクス移動、モデル差し替え<2>、初速度、物理インスタンス消し
	SecondStageBreak(proxy, 1066, 2 );
	
	print("OnEvent_151_1066hit end");
end

function OnEvent_151_bloken(proxy,param)
	print("OnEvent_151_bloken begin");
	
	proxy:SetBrokenPiece(1064);
	proxy:SetBrokenPiece(1065);
	proxy:SetBrokenPiece(1066);
	proxy:SetBrokenPiece(1067);
	proxy:SetBrokenPiece(1068);
	proxy:SetBrokenPiece(1069);
	
	--フラグをセット
	proxy:SetEventFlag( 151, true );
	
	print("OnEvent_151_bloken end");
end

--------------------------------------------------------------------------------------
--光の壁■180
--------------------------------------------------------------------------------------
--■180■光の壁■
function OnEvent_180(proxy,param)
	print("OnEvent_180 begin");
	

	--多重発動防止
	if proxy:IsCompleteEvent( 180 ) == true then
		print("OnEvent_180 end");
		return;
	end
	
	--２つの光の壁が同期しなければいけないので２つとも消す	
	--proxy:DeleteObjSfxDmyPlyID( 1081, 200 );--Sfxを消去
	--proxy:DeleteObjSfxDmyPlyID( 1080, 200 );--Sfxを消去	
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 180 , 1 );
		proxy:SetEventFlag( 181 , 1 );
		print("OnEvent_180 end");
		return;
	end
	
	--ダミポリへワープ
	proxy:WarpDmy( LOCAL_PLAYER, 1080, 191 );
	
	proxy:NotNetMessage_begin();
		--▼180_1▼歩きアニメ終了▼
		--proxy:OnChrAnimEnd( 180, LOCAL_PLAYER, ANIMEID_WALK, "OnEvent_180_1" , once );
		proxy:LuaCallStart( 180, 1 );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 180, 1 );
	proxy:SetEventFlag( 181, 1 );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_180 end");
end

function OnEvent_180_1(proxy,param)
	print("OnEvent_180_1 begin");
	
	proxy:LuaCallStart( 180, 1 );
	
	print("OnEvent_180_1 end");
end

--配信用アタリ,描画OFF
function OnEvent_180_181_delete(proxy,param)
	print("OnEvent_180_delete begin");
	
	proxy:DeleteEvent( 180 );
	proxy:DeleteEvent( 181 );
	
	proxy:InvalidSfx( 2125, true );
	proxy:InvalidSfx( 2126, true );
	
	proxy:SetDrawEnable( 1080, false );--描画OFF
	proxy:SetColiEnable( 1080, false );--当たりOFF
	proxy:SetObjDeactivate( 1080 , true );--デアクティブ
	
	proxy:SetDrawEnable( 1081, false );--描画OFF
	proxy:SetColiEnable( 1081, false );--当たりOFF
	proxy:SetObjDeactivate( 1081 , true );--デアクティブ
	
	
	print("OnEvent_180_delete end");
end

--------------------------------------------------------------------------------------
--光の壁■181
--------------------------------------------------------------------------------------
--■181■光の壁■
function OnEvent_181(proxy,param)
	print("OnEvent_181 begin");
	

	--多重発動防止
	if proxy:IsCompleteEvent( 181 ) == true then
		print("OnEvent_181 end");
		return;
	end
	
	--２つの光の壁が同期しなければいけないので２つとも消す	
	--proxy:DeleteObjSfxDmyPlyID( 1081, 200 );--Sfxを消去
	--proxy:DeleteObjSfxDmyPlyID( 1080, 200 );--Sfxを消去
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 180 , 1 );
		proxy:SetEventFlag( 181 , 1 );
		print("OnEvent_181 end");
		return;
	end
	
	--ダミポリへワープ
	proxy:WarpDmy( LOCAL_PLAYER, 1081, 191 );	
	
	proxy:NotNetMessage_begin();
		--▼180_1▼歩きアニメ終了▼
		--proxy:OnChrAnimEnd( 180, LOCAL_PLAYER, ANIMEID_WALK, "OnEvent_181_1" , once );
		proxy:LuaCallStart( 180, 1 );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 180, 1 );
	proxy:SetEventFlag( 181, 1 );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_181 end");
end

function OnEvent_181_1(proxy,param)
	print("OnEvent_181_1 begin");
	
	proxy:LuaCallStart( 180, 1 );
	
	print("OnEvent_181_1 end");
end


--------------------------------------------------------------------------------------
--板落ち■190
--------------------------------------------------------------------------------------
--■190■板落ち■
function OnEvent_190(proxy,param)
	print("OnEvent_190 begin");
	
	proxy:ChangeModel( 1090, 1 );
	proxy:SetBrokenPiece(1090);

	--効果音再生
	proxy:PlayTypeSE( 1090, SOUND_TYPE_O, 512000000);
	
	proxy:SetEventFlag( 190, true );
	
	
	print("OnEvent_190 end");
end


--------------------------------------------------------------------------------------
--■198,199■腐敗人死体有効化■
--------------------------------------------------------------------------------------
--■198,199■腐敗人死体有効化■
--[[
function corpse_Condition(proxy,param)
	local IsIn 		= proxy:IsCompleteEvent( 198 );
	local IsInOld 	= proxy:IsCompleteEvent( 199 );
	
	--前のフレームと今のフレームで違いがある場合、今のフレームを設定
	if IsIn ~= IsInOld then
		proxy:SetEventFlag( 199, IsIn );
	end
	
	--前のフレームで誰もいなくて、今フレームで誰かが入っている時
	if	IsIn == true and IsInOld == false then
		return true;
	end
	
	return false;
end

function corpse_Result(proxy,param)
	local count = 0;
	for index = 1, param:GetParam2(), 1 do
		if proxy:IsCompleteEvent( 200 + index - 1 ) == true then
			count = count + 1;
		end
	end
	
	for index = 1, count, 1 do
		proxy:SetDrawEnable( 10270 + index - 1, true );
		proxy:SetColiEnable( 10270 + index - 1, true );
		proxy:EnableObjTreasure( 10270 + index - 1, true );
	end
end
function corpse_ReginIn(proxy,param)
	local region_list = {2141, 2142};
	local region_num = table.getn(region_list);
	local fall_chrId_list = {300, 301, 302, 303, 304, 305, 306, 307, 308, 309,
							 310, 311, 312, 313, 314, 315, 316, 317, 318, 319,
							 320, 321, 322, 323, 324, 325, 326, 327, 328, 329,
							 330, 331, 332, 333, 334, 335, 336, 337, 338, 339,
							 340, 500, 501, 502, 503, 504, 505, 506, 507, 508,
							 509, 510, 511, 512, 513, 514, 515, 516};
	local fall_chrNum = table.getn(fall_chrId_list);
	local count = 0;
	print("corpse_ReginIn begin");
	for chr_index = 1, fall_chrNum, 1 do
		for region_index = 1, region_num, 1 do
			if	proxy:IsRegionIn( fall_chrNum[chr_index], region_list[region_index] ) == true then
				count = count + 1;
			end
		end
	end
	
	for index = 1, count, 1 do
		if	index > 10 then
			return;
		end
		proxy:SetDrawEnable( 10270 + index - 1, true );
		proxy:SetColiEnable( 10270 + index - 1, true );
		proxy:EnableObjTreasure( 10270 + index - 1, true );
	end
end
]]

function corpseCheck(proxy,param)
	print("corpseCheck begin");
	--ホストのみがキックする
	if proxy:IsClient() == true then
		print("corpseCheck return end");
		return;
	end
	proxy:LuaCallStart( 199, 2 );
	print("corpseCheck end");
end

function corpseUpdate(proxy,param)
	print("corpseUpdate begin");
	local fall_counter = 0;
	
	for actId = 200, 256, 1 do
		if	proxy:IsCompleteEvent( actId ) == true then
			fall_counter = fall_counter + 1;
		end
	end
	for index = 1, 10, 1 do
		if fall_counter > index + 1 then
			print("宝死体有効化",10270 + index - 1);
			proxy:SetDrawEnable( 10270 + index - 1, true );
			proxy:SetColiEnable( 10270 + index - 1, true );
			proxy:EnableObjTreasure( 10270 + index - 1, true );
		end
	end
	print("corpseUpdate end");
end
--------------------------------------------------------------------------------------
--■200～256■腐敗人転落死■
--------------------------------------------------------------------------------------
--■200～256■腐敗人転落死■
--[[
function fall_Condition(proxy,param)
	local region_list = {2141, 2142};
	local region_num = table.getn(region_list);
	for index = 1, region_num, 1 do
		if proxy:IsRegionIn( param:GetParam2(), region_list[index] ) == true then
			--領域の中に入っているので成立
			return true;
		end
	end
	return false;
end

function fall_result(proxy,param)
	--フラグを立てておく
	proxy:SetEventFlag( param:GetParam1(), true );
end
]]
function fall_countup(proxy,param)
	--同アクションID、別領域で対に登録されているので、もう片方を削除
	proxy:DeleteEvent(param:GetParam1());
	--フラグを立てておく
	proxy:SetEventFlag( param:GetParam1(), true );
end

--[[
function OnEvent_270(proxy,param)
	print("OnEvent_270 begin");
	SetNpcStateFlag( proxy, param, kojiki_m50_flag_list, KOJIKI_M50_STATE_ANGRY );
	proxy:SetEventFlag( 270, true );
	print("OnEvent_270 end");
end

function OnEvent_271(proxy,param)
	print("OnEvent_271 begin");
	SetNpcStateFlag( proxy, param, kojiki_m50_flag_list, KOJIKI_M50_STATE_DEAD );
	proxy:SetEventFlag( 271, true );
	
	--死亡したので敵対監視を消す
	proxy:DeleteEvent( 270 );
	print("OnEvent_271 end");
end
]]

--------------------------------------------------------------------------------------
--■167■ボスカメラ切り替えイベント■
--------------------------------------------------------------------------------------
function OnEvent_167(proxy,param)
	--print("OnEvent_167 begin");
	--ボスが死んでいない　かつ　ボスとの戦闘を開始している
	if proxy:IsCompleteEvent( 808 ) == false and proxy:IsCompleteEvent( 163 ) == true then
		--ボス戦　非ロックカメラ
		proxy:SetCamModeParamTargetId(5011);
		--ボス戦　ロックカメラ
		proxy:SetCamModeParamTargetIdForBossLock(5010);
	end
	--print("OnEvent_167 end");
end

--------------------------------------------------------------------------------------
--■281■最初の要石の光が消える■
--------------------------------------------------------------------------------------

function OnEvent_281(proxy, param)
	print("OnEvent_281 begin");
	
	proxy:TreasureDispModeChange2( 1983 , false ,KANAME_SFX);
	
	print("OnEvent_281 end");
end


--------------------------------------------------------------------------------------
--■282■最初の要石の光が復活する■
--------------------------------------------------------------------------------------

function OnEvent_282(proxy, param)
	print("OnEvent_282 begin");
	
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	
	print("OnEvent_282 end");
end

--------------------------------------------------------------------------------------
--徘徊デーモンの登場■??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ)
function PlayerDeath_m05_00_00_00(proxy, param)
	print("PlayerDeath_m05_00_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m05_00_00_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。
	
	print("PlayerDeath_m05_00_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ)
function PlayerRevive_m05_00_00_00(proxy,param)
	print("PlayerRevive_m05_00_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m05_00_00_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。
	
	print("PlayerRevive_m05_00_00_00");
end

------------------------------
--乞食(女)ショップの状態変化--
------------------------------
--▼乞食(女)が不浄1で敵対する▼--
function OnEvent_270(proxy, param)
	print("OnEvent_270 begin");

	--ロジックOn
	proxy:EnableLogic( 650, true );
	
	--乞食(女)の状態を敵対(不浄1)にする
	SetNpcStateFlag(proxy, param, Kojiki_Shop_Flag_list, KOJIKI_FEMALE_SHOP_HOSTILE01 );
	--乞食(女)のチームタイプを変更する
	proxy:SetTeamType( 650, TEAM_TYPE_AngryFriend );

	--フラグを立てる
	proxy:SetEventFlag( 270, true );
	
	print("OnEvent_270 end");
end
--▲-------------------------▲--


--▼乞食(女)が死亡する(不浄1)▼--
function OnEvent_271(proxy, param)
	print("OnEvent_271 begin");

	--乞食(女)の状態を「死亡」に変える
	SetNpcStateFlag( proxy, param, Kojiki_Shop_Flag_list, KOJIKI_FEMALE_SHOP_DEAD );
	
	--フラグを立てる
	proxy:SetEventFlag( 271, true );
	
	--敵に削られて敵対を通り越して死亡もありえるので、ここでも削除
	--死んだら敵対にはならないので削除
	proxy:DeleteEvent( 270 );
	proxy:DeleteEvent( 810 );

	print("OnEvent_271 end");
end
--▲-------------------------▲--


function OnEvent_272(proxy, param) proxy:LuaCallStart(812, 1); end
function OnEvent_273(proxy, param) proxy:LuaCallStart(812, 1); end
function OnEvent_275(proxy, param) proxy:LuaCallStart(812, 1); end

function OnEvent_812(proxy, param)
	print("OnEvent_812 begin");
	print("JustInCheckPoint");
	
	local KojikiShop01_id = 650;
	local KojikiShop02_id = 677;
	
	local KojikiShopBlock1_acid_list = {274,270,271};
	local KojikiShopBlock2_acid_list = {810,811};
	
	--一旦2体とも消える
	InvalidCharactor(proxy,KojikiShop01_id);
	InvalidCharactor(proxy,KojikiShop02_id);
	
	if proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork( KojikiShop01_id);
		proxy:RequestForceUpdateNetwork( KojikiShop02_id);
	end
	
	--ブロックの監視を削除
	DeleteConditionList(proxy,KojikiShopBlock1_acid_list);
	DeleteConditionList(proxy,KojikiShopBlock2_acid_list);
	
	
	--取りあえず初期状態を設定
	SetFirstNpcStateFlag( proxy, param, Kojiki_Shop_Flag_list, KOJIKI_FEMALE_SHOP_SELL01 );
	
	
	--乞食(女)が不浄2に移動する
	if proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_SELL01 ) == true then
		print("KojikiShop NowState KOJIKI_FEMALE_SHOP_SELL01");
		SetKojikiShopState01(proxy, param);
		KojikiRegistConditionBlock01(proxy,param);

	--乞食(女)が不浄1で敵対
	elseif proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_HOSTILE01 ) == true then
		print("KojikiShop NowState KOJIKI_FEMALE_SHOP_HOSTILE01");
		SetKojikiShopState02(proxy, param);
		KojikiRegistConditionBlock01(proxy,param);

	--乞食(女)が死亡した
	elseif proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_DEAD ) == true then
		print("KojikiShop NowState KOJIKI_FEMALE_SHOP_DEAD");
		SetKojikiShopState03(proxy, param);
		KojikiRegistConditionBlock01(proxy,param);

	--乞食(女)が不浄2で販売中
	elseif proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_SELL02 ) == true then
		print("KojikiShop NowState KOJIKI_FEMALE_SHOP_SELL02");
		SetKojikiShopState04(proxy, param);
		KojikiRegistConditionBlock02(proxy,param);

	--乞食(女)が不浄2で敵対している
	elseif proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_HOSTILE02 ) == true then
		print("KojikiShop NowState KOJIKI_FEMALE_HOSTILE02");
		SetKojikiShopState05(proxy, param);
		KojikiRegistConditionBlock02(proxy,param);

	end

	print("OnEvent_812 end");
end


--▼乞食(女)が販売している(不浄1)▼-----------------------------------------
function SetKojikiShopState01( proxy, param )
	--蛭デーモンが生きている
	if proxy:IsCompleteEvent( 5650 ) == false then
		ValidCharactor(proxy,650);--不浄1にいる乞食(女)を有効化
	
	--蛭デーモンが死んでいる
	else
		print("KojikiShop NowState KOJIKI_FEMALE_SHOP_SELL01 > Chenge to KOJIKI_FEMALE_SHOP_SELL02");
		InvalidBackRead(proxy,650);--不浄1にいる乞食(女)を無効化
		ValidCharactor(proxy,677);--不浄2にいる乞食(女)を有効化
		
		--ロジックOFFにする
		--proxy:EnableLogic( 677, false );
		
		--乞食(女)の状態を「販売(不浄2)」に変える
		SetNpcStateFlag( proxy, param, Kojiki_Shop_Flag_list, KOJIKI_FEMALE_SHOP_SELL02 );
	end
end
--▲-----------------------------▲-----------------------------------------


--▼乞食(女)が敵対している(不浄1)▼-------------------------
function SetKojikiShopState02( proxy, param )
	ValidCharactor(proxy,650);--不浄1にいる乞食(女)を有効化
	InvalidBackRead(proxy,677);--不浄2にいる乞食(女)を無効化
	--乞食(女)のチームタイプを変更する
	proxy:SetTeamType( 650, TEAM_TYPE_AngryFriend );
end
--▲-----------------------------▲-------------------------


--▼乞食(女)が死亡した(不浄1)▼-------------------------------------
function SetKojikiShopState03( proxy, param )
	InvalidBackRead(proxy,650);--不浄1にいる乞食(女)を無効化
	InvalidBackRead(proxy,677);--不浄2にいる乞食(女)を無効化
end
--▲-------------------------▲-------------------------------------


--▼乞食(女)が販売している(不浄2)▼-----------------------------------------
function SetKojikiShopState04( proxy, param )
	InvalidBackRead(proxy,650);--不浄1にいる乞食(女)を無効化
	ValidCharactor(proxy,677);--不浄2にいる乞食(女)を有効化
end
--▲-------------------------▲-------------------------------------


--▼乞食(女)が敵対している(不浄2)▼-------------------------
function SetKojikiShopState05( proxy, param )
	InvalidBackRead(proxy,650);--不浄1にいる乞食(女)を無効化
	ValidCharactor(proxy,677);--不浄2にいる乞食(女)を有効化
	--乞食(女)のチームタイプを変更する
	proxy:SetTeamType( 677, TEAM_TYPE_AngryFriend );
end
--▲-----------------------------▲-------------------------


--▼乞食(女)の状態遷移(不浄1)▼--------------------------------------------------------------------------------------
function KojikiRegistConditionBlock01(proxy, param)
	--乞食(女)が死んでいない
	if proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_DEAD ) == false then
		--乞食(女)が不浄1,2のいずれでも敵対していない場合
		if proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_HOSTILE01 ) == false
		   and proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_HOSTILE02 ) == false then
			--ホストからのダメージ監視
			--m05_00
			--proxy:OnCharacterTotalDamage( 270, 650, LOCAL_PLAYER, KojikiShop_TotalDamage, "OnEvent_270", once );
			proxy:OnCharacterTotalRateDamage( 270, 650, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_270", once );
			--m05_01
			--proxy:OnCharacterTotalDamage( 810, 677, LOCAL_PLAYER, KojikiShop_TotalDamage, "OnEvent_810", once );
			proxy:OnCharacterTotalRateDamage( 810, 677, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_810", once );
		end
		proxy:OnCharacterDead( 271, 650, "OnEvent_271", once );
	end
end
--▲------------------▲--------------------------------------------------------------------------------------


--▼乞食(女)の状態遷移(不浄2)▼-------------------------------------------------------------------------------
function KojikiRegistConditionBlock02(proxy, param)
	--乞食(女)が死んでいない
	if proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_DEAD ) == false then
		--乞食(女)が不浄1,2のいずれでも敵対していない場合
		if proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_HOSTILE01 ) == false
		   and proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_HOSTILE02 ) == false then
			--ホストからのダメージ監視
			--m05_00
			--proxy:OnCharacterTotalDamage( 270, 650, LOCAL_PLAYER, KojikiShop_TotalDamage, "OnEvent_270", once );
			proxy:OnCharacterTotalRateDamage( 270, 650, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_270", once );
			--m05_01
			--proxy:OnCharacterTotalDamage( 810, 677, LOCAL_PLAYER, KojikiShop_TotalDamage, "OnEvent_810", once );
			proxy:OnCharacterTotalRateDamage( 810, 677, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_810", once );
		end
		proxy:OnCharacterDead( 811, 677, "OnEvent_811", once );
	end
end
--▲------------------▲--------------------------------------------------------------------------------------


-----------------------------------------------------------------------------
--■■結晶トカゲイベント
-----------------------------------------------------------------------------
--ボス撃破時のトカゲリセット用
function ResetTokage(proxy)
	print("ResetTokage");
	--proxy:SetEventFlag(310,false);
	--proxy:SetEventFlag(830,false);
	--proxy:SetEventFlag(1140,false);			
	AddEventCounter(proxy,15);
	AddEventCounter(proxy,16);
	AddEventCounter(proxy,17);
end

-----------------------------------------------------------------------------
--■310■結晶トカゲイベント1
-----------------------------------------------------------------------------
function OnEvent_310(proxy,param)
	print("OnEvent_310 begin");
	proxy:SetEventFlag( 310, true);
	proxy:DeleteEvent( 310 );
	print("OnEvent_310 end");
end

-----------------------------------------------------------------------------
--■830■結晶トカゲイベント2
-----------------------------------------------------------------------------
function OnEvent_830(proxy,param)
	print("OnEvent_830 begin");
	proxy:SetEventFlag( 830, true);
	proxy:DeleteEvent( 830 );
	print("OnEvent_830 end");
end

-----------------------------------------------------------------------------
--■1140■結晶トカゲイベント3
-----------------------------------------------------------------------------
function OnEvent_1140(proxy,param)
	print("OnEvent_1140 begin");
	proxy:SetEventFlag( 1140, true);
	proxy:DeleteEvent( 1140 );
	print("OnEvent_1140 end");
end


-----------------------------------------------------------------------------
--■24■QWCハシゴの先に進んだ
-----------------------------------------------------------------------------
function OnEvent_24(proxy,param)
	print("OnEvent_24 begin");
	proxy:SetEventFlag( 24,true );
	print("OnEvent_24 end");
end


--血ダニダメージ
function OnEvent_320(proxy,param)
	print("OnEvent_320 begin");
	proxy:EnableLogic( 520, true );
	proxy:SetEventFlag( 320 , true );
	print("OnEvent_320 end");
end

--血ダニダメージ
function OnEvent_321(proxy,param)
	print("OnEvent_321 begin");
	proxy:EnableLogic( 521, true );
	proxy:SetEventFlag( 321 , true );
	print("OnEvent_321 end");
end

--血ダニダメージ
function OnEvent_322(proxy,param)
	print("OnEvent_322 begin");
	proxy:EnableLogic( 522, true );
	proxy:SetEventFlag( 322 , true );
	print("OnEvent_322 end");
end

--血ダニダメージ
function OnEvent_323(proxy,param)
	print("OnEvent_323 begin");
	proxy:EnableLogic( 523, true );
	proxy:SetEventFlag( 323 , true );
	print("OnEvent_323 end");
end

--血ダニダメージ
function OnEvent_324(proxy,param)
	print("OnEvent_324 begin");
	proxy:EnableLogic( 524, true );
	proxy:SetEventFlag( 324 , true );
	print("OnEvent_324 end");
end

--血ダニダメージ
function OnEvent_325(proxy,param)
	print("OnEvent_325 begin");
	proxy:EnableLogic( 525, true );
	proxy:SetEventFlag( 325 , true );
	print("OnEvent_325 end");
end

