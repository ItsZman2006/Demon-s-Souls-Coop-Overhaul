
--毒沼効果の発生周期パラメータ
PoizonCycle_low			= 1.00;	--毒沼効果の周期(最長)
PoizonCycle_High		= 1.01;	--毒沼効果の周期(最短)

IsInPoizonArea			= false;--毒沼エリアに入っているか？



--[[【セレン】の状態]]
SELEN_STATE_SEARCH_BROTHER	= 16380;--弟を探している
SELEN_STATE_ANGRY			= 16381;--敵対
SELEN_STATE_DEAD			= 16382;--死亡
SELEN_STATE_THANKS			= 16383;--満足
SELEN_STATE_PURIFY			= 16384;--成仏
selen_flag_list = {
	SELEN_STATE_SEARCH_BROTHER,
	SELEN_STATE_ANGRY,
	SELEN_STATE_DEAD,
	SELEN_STATE_THANKS,
	SELEN_STATE_PURIFY
};
TOTALDAMAGE_SELEN = 100;--【セレン】敵対蓄積ダメージ

--クラゲジェネレータA関係クラゲID
KURAGE_GEN_ALIST = {170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192};
--クラゲジェネレータB関係クラゲID
KURAGE_GEN_BLIST = {200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218};
--クラゲジェネレータC関係クラゲID
KURAGE_GEN_CLIST = {220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244};
--クラゲジェネレータD関係クラゲID
KURAGE_GEN_DLIST = {250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268};

RapConditionCount = 0;
--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■
--------------------------------------------------------------------------------------
function Initialize_m05_01_00_00(proxy)
	print("Initialize_m05_01_00_00 begin");
-----------------------------------------------------------------------------------------
--ボス関連
-----------------------------------------------------------------------------------------
--■533■ボス部屋に入る■
	--中ボスが生きているときだけイベント登録
	if proxy:IsCompleteEvent( 5770 ) == false then
	
		--<追加>ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。
		SingleReset(proxy, 533);
	
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き)
		proxy:LuaCall( 534, 1, "OnEvent_534_1", everytime );
		--▽2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCall( 534 , 5 , "OnEvent_533_GO_TO_IN" , everytime );
		--▽フラグセット(同期用)
		proxy:LuaCall( 534 , 6 , "OnEvent_533_flag_set" , everytime );
		
		--誰かがボス前扉をまだ通過していない
		if proxy:IsCompleteEvent( 533 ) == false then
		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--▼533▼中に入るためのイベントを追加▼
				proxy:OnPlayerActionInRegionAttribute( 533, 2894, "OnEvent_533", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --グレイゴーストできたときようにいると思われる。
			proxy:NotNetMessage_begin();
				--▼534▼中に入るためのイベントを追加▼--ハンドラは上と同じ
				proxy:OnPlayerActionInRegion( 534, 2894, "OnEvent_533", HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		end
	else
		InvalidBackRead( proxy, 809 );
	end
	
--■537■ボス戦闘開始■
	if proxy:IsCompleteEvent( 5770 ) == false then
		SingleReset( proxy, 537 );
		proxy:OnRegionJustIn( 537 , 10000 , 2886 , "OnEvent_537" , once );
	end
--■5770■ボスが死んだら--
	proxy:AddFieldInsFilter( 809 );
	if proxy:IsCompleteEvent( 5770 ) == false then
		proxy:OnCharacterDead(5770,809,"OnEvent_5770",once);
	else
		proxy:InvalidSfx( 1986, false );
		proxy:InvalidSfx( 1990, false );
	end

--■ボス関連の初期化処理
	if proxy:IsCompleteEvent( 5770 ) ==true then
		
		--▽ボス死んでいるとき
		--ボスいなくなる
		InvalidCharactor( proxy , 809 );
		
		--魔法壁消える
		proxy:SetColiEnable( 1998 , false );
		proxy:SetColiEnable( 1994 , false );
	
		proxy:SetDrawEnable( 1998 , false );
		proxy:SetDrawEnable( 1994 , false );
		
		--SFX OFF
		proxy:InvalidSfx( 1986 , false );
		proxy:InvalidSfx( 1990 , false );
		
		--ホストプレイヤーのみアイテム入手イベントに使用
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--宝死体(ソウル?)有効化
		proxy:SetDrawEnable( 1981 , true );
		proxy:SetColiEnable( 1981 , true );
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--光らせる
		--ソウルに刺さった剣有効化
		proxy:SetDrawEnable( 1976 , true );
		proxy:SetColiEnable( 1976 , true );
		--proxy:TreasureDispModeChange2( 1976 , true ,KANAME_SFX);--光らせる
		
		--▼(ソウル)アイテム取得用イベント監視追加▼
		if proxy:IsCompleteEvent( 5773 ) == false then
			--SFXの有効化
			proxy:ValidSfx( 2360 );--要石のオーラ
			proxy:ValidSfx( 2361 );--光の粒子
			
			proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--光らせる
			proxy:OnDistanceActionAttribute( 5773 , 10000 , 1981 , "OnEvent_5773" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--SFX OFF
			proxy:InvalidSfx( 2360 , false );--要石のオーラ
			--proxy:InvalidSfx( 2361 , false );--光の粒子
			--▼要石でワープ用の監視を追加▼
			SingleReset(proxy,5774);
			proxy:OnDistanceActionAttribute( 5774 , 10000 , 1981 , "OnEvent_5774" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
		
	else
		--▽ボス生きているとき
		--ロジックOFF
		proxy:EnableLogic( 809, false );
		
		--宝(ソウル?)
		proxy:SetDrawEnable( 1981 , false );
		proxy:SetColiEnable( 1981 , false );
		--ソウルに刺さった剣無効化
		proxy:SetDrawEnable( 1976 , false );
		proxy:SetColiEnable( 1976 , false );
		
		--SFX OFF
		proxy:InvalidSfx( 2360 , false );--要石のオーラ
		proxy:InvalidSfx( 2361 , false );--光の粒子
		
		--魔法壁有効化
		proxy:SetColiEnable( 1998 , true );
		proxy:SetColiEnable( 1994 , true );
		
		proxy:SetDrawEnable( 1998 , true );
		proxy:SetDrawEnable( 1994 , true );
		
		--SFX ON
		proxy:ValidSfx( 1986 );
		proxy:ValidSfx( 1990 );
	end	

-----------------------------------------------------------------------------------------
--ギミック関連
-----------------------------------------------------------------------------------------	
--■512■跳ね橋A■PCがOBJ(1200)に対して反応角度(30)、角度オフセット(180)、距離(150)でアクションボタンを押す--
	if proxy:IsCompleteEvent( 512 ) ==false then
		proxy:OnDistanceActionPlus( 512, 10000, 1200, "OnEvent_512", DrawBridgeDist_A, HELPID_START, 180, DrawBridgeAngle_A, -1.3, -1.5, 1.3, once);
	else
		proxy:EndAnimation( 1200, 1 );
	end

--■580■大ナメクジ壁待機■
	if proxy:IsCompleteEvent( 580 ) == false then
		proxy:OnRegionJustIn( 580 , 10000 , 2340 , "OnEvent_580" , once );--領域入ったとき
		proxy:OnSimpleDamage( 580 , 421 , 10000 , "OnEvent_580" , once );--攻撃受けたとき
		proxy:OnSimpleDamage( 580 , 422 , 10000 , "OnEvent_580" , once );--攻撃受けたとき
		proxy:OnSimpleDamage( 580 , 423 , 10000 , "OnEvent_580" , once );--攻撃受けたとき		
	end
	

--■581■大ナメクジ壁待機■
	if proxy:IsCompleteEvent( 581 ) == false then
		proxy:OnRegionJustIn( 581 , 10000 , 2341 , "OnEvent_581" , once );--領域入ったとき
		proxy:OnSimpleDamage( 581 , 424 , 10000 , "OnEvent_581" , once );--攻撃受けたとき
		proxy:OnSimpleDamage( 581 , 425 , 10000 , "OnEvent_581" , once );--攻撃受けたとき
		proxy:OnSimpleDamage( 581 , 426 , 10000 , "OnEvent_581" , once );--攻撃受けたとき
	end
	
--■??■徘徊デーモンの登場■ハンドラ登録
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。
		proxy:LuaCall( 4000, 100, "PlayerDeath_m05_01_00_00", everytime );
		--プレイヤーが復活した時にキックされます。
		proxy:LuaCall( 4032, 100, "PlayerRevive_m05_01_00_00", everytime );
	proxy:NotNetMessage_end();

	--■大ナメクジ壁待機用
	if proxy:IsCompleteEvent( 580 ) == false then
		proxy:SetDisableGravity( 421, true  );--重力OFF
		proxy:EnableLogic      ( 421, false );--思考OFF
		
		proxy:SetDisableGravity( 422, true  );--重力OFF
		proxy:EnableLogic      ( 422, false );--思考OFF
		
		proxy:SetDisableGravity( 423, true  );--重力OFF
		proxy:EnableLogic      ( 423, false );--思考OFF
	end

	
	--■大ナメクジ壁待機用2
	if proxy:IsCompleteEvent( 581 ) == false then
		proxy:SetDisableGravity( 424, true  );--重力OFF
		proxy:EnableLogic      ( 424, false );--思考OFF
		
		proxy:SetDisableGravity( 425, true  );--重力OFF
		proxy:EnableLogic      ( 425, false );--思考OFF
		
		proxy:SetDisableGravity( 426, true  );--重力OFF
		proxy:EnableLogic      ( 426, false );--思考OFF
	end
	


	--■630～659■(有)ナメクジジェネレート■
	GenerateRegist(proxy, 630, 100, 29,  5, "NamekuziGen" );
	
	--■670～689■(有)腐敗人ジェネレート■
	GenerateRegist(proxy, 670, 140, 19,  6, "HuhaibitoGen" );
	
	--■699■クラゲジェネレート用配信■
	SingleReset( proxy,699 );
	proxy:CustomLuaCall( 699 , "GenPoint" , everytime );
	
	--■700～709■(有)クラゲジェネレートA■
	GenerateRegistKURAGE(proxy, 700, 170, 22, 13, "KurageGenA");
	
	--■710～719■(有)クラゲジェネレートB■
	GenerateRegistKURAGE(proxy, 710, 200, 18,  9, "KurageGenB");
	
	--■720～729■(有)クラゲジェネレートC■
	GenerateRegistKURAGE(proxy, 720, 220, 24, 15, "KurageGenC");
	
	--■730～739■(有)クラゲジェネレートD■
	GenerateRegistKURAGE(proxy, 730, 250, 18,  9, "KurageGenD");
	
	--■クラゲジェネレータの領域内のプレイヤ有無判定用
	proxy:OnNetRegion( 790, 2310 );
	proxy:OnNetRegion( 791, 2311 );
	proxy:OnNetRegion( 792, 2312 );
	proxy:OnNetRegion( 793, 2313 );
	proxy:OnNetRegion( 794, 2314 );
	proxy:OnNetRegion( 795, 2315 );
	proxy:OnNetRegion( 796, 2316 );
	proxy:OnNetRegion( 797, 2317 );
	proxy:OnNetRegion( 798, 2318 );
	proxy:OnNetRegion( 799, 2319 );
	
	proxy:InvalidSfx( 2222, false );
	--■515■ナメクジコロニー■
	if proxy:IsCompleteEvent( 515 ) == false then
		proxy:OnRegistFunc(515,"Check_515","OnEvent_515",1,everytime);
		
		proxy:SetColiEnable( 1260, false );
		proxy:SetDrawEnable( 1260, false );
		for index = 1, 15, 1 do
			InvalidCharactor( proxy, 700 + index - 1);
		end
	else
		proxy:SetColiEnable( 1250, false );
		proxy:SetDrawEnable( 1250, false );
		
		--■517■ムーンライトソード■
		if proxy:IsCompleteEvent( 517 ) == false then
			--ホスト、生存、グレイのみ調べることができる
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:OnDistanceActionAttribute( 517 , 10000 , 1260 , "OnEvent_517_0" , ItemBoxDist_A , 10010140 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
			proxy:LuaCall( 517,1,"OnEvent_517_2",once);
			proxy:LuaCall( 517,2,"OnEvent_517_4",once);
			proxy:TreasureDispModeChange2( 1260, true ,KEN_SFX);
		else
			proxy:SetDrawEnable( 1260 , false );--ひとまず描画だけOFF
			proxy:SetColiEnable( 1260 , false );
		end
	end	
	--proxy:SetRarity( 1260, 10430 );
	
	--■520■毒沼■
	--ホストが沼に入っている状態で召喚されると、
	--フラグがOnの為追加できない場合があるのでフラグを下ろす。
	proxy:SetEventFlag( 520, false );
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc( 520, "PoizonFloorDam", "dummy", 2, everytime );
	proxy:NotNetMessage_end();
	
	
	
--[[
	--■徘徊デーモン用 (フラグは仮、指定があれば変える)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m05_01_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m05_01_00_00);
	end
]]
		
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
	
--■538■ボス戦カメラ対応■
	--ボスが生きているなら登録
	if proxy:IsCompleteEvent(5770) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 538 , 10000 , 2886 ,"OnEvent_538" , everytime );
		proxy:NotNetMessage_end();
	end

--祈り腐敗人のダミー
--[[
	proxy:OnPlayerDistanceInTarget( 820, 10000, 140, "testINORI", 5.0, once );
	proxy:OnPlayerDistanceInTarget( 821, 10000, 141, "testINORI", 5.0, once );
	proxy:OnPlayerDistanceInTarget( 822, 10000, 142, "testINORI", 5.0, once );
	proxy:OnPlayerDistanceInTarget( 823, 10000, 143, "testINORI", 5.0, once );
	proxy:OnPlayerDistanceInTarget( 824, 10000, 144, "testINORI", 5.0, once );
	proxy:OnPlayerDistanceInTarget( 825, 10000, 145, "testINORI", 5.0, once );
]]

--■536■不浄へ来たフラグを立てる■
	proxy:SetEventFlag( 8087, true );

-----------------------------------------------------------------------------------------
--NPC関連
-----------------------------------------------------------------------------------------
--------------------------------▽▽▽QWCイベント関連▽▽▽--------------------------------
--■827■QWC鉱石の精霊出現■
	if proxy:IsCompleteEvent(828) == true or	--まだ鉱石の精霊が死亡してない　か
	   proxy:IsSuccessQWC(50110) == false then	--QWCが成立していなければ
		print("QWC鉱石の精霊　未成立");
		--鉱石の精霊を無効化
		InvalidBackRead(proxy, 434);
		
		proxy:SetEventFlag(827, true);
	else
		print("QWC鉱石の精霊　成立");
	end

--■828■QWC鉱石の精霊死亡監視■
	if proxy:IsCompleteEvent(828) == false then	--まだ鉱石の精霊が死亡してないなら
	   --鉱石の精霊の死亡監視追加
		proxy:OnCharacterDead( 828, 434, "OnEvent_828", once );
		if proxy:IsClient() == false and proxy:IsCompleteEvent(8020) == false then
			proxy:NotNetMessage_begin();
				proxy:AddCorpseEvent( 8020 , 434 );
				proxy:LuaCall( 8020 , 0 , "OnEvent_8020",once);
			proxy:NotNetMessage_end();
		end
	end
	
--■800■QWCセレン出現■
	if proxy:IsSuccessQWC(50130) == false then	--QWCが成立していなければ
		print("QWCセレン　未成立");
		--セレンを無効化
		InvalidBackRead(proxy, 652);		
		proxy:SetEventFlag(800, true);
	else
		print("QWCセレン　成立");
	end

--■15600■セレンの死体を調べた■
	if proxy:IsCompleteEvent( 15600 ) == false then
		proxy:AddCorpseEvent( 15600 , 435 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15600 ,0 , "OnEvent_15600",once );
 		proxy:NotNetMessage_end();
	end

--■820■QWCセレン・ブラックゴースト死亡監視■
	if proxy:IsCompleteEvent(820) == false then	--まだセレンが死亡してないなら
	   --セレン・ラックゴーストの死亡監視追加
		proxy:OnCharacterDead( 820, 435, "OnEvent_820", once );
	end
--■821■QWCセレン・ブラックゴースト出現■
	if proxy:IsCompleteEvent(820) == true or	--まだセレン・ブラックゴーストが死亡してない　か 
	   proxy:IsSuccessQWC(50120) == false then	--QWCが成立していなければ
	   
	   if 	proxy:IsCompleteEvent( 820 ) == true and
			proxy:IsCompleteEvent( 15600 ) == false then
			--死体を再現する
			proxy:OpeningDeadPlus( 435 , true ,false ,false );
		else
			print("QWCセレン・ブラックゴースト　未成立");
			--セレンを無効化
			InvalidBackRead(proxy, 435);			
		end
		--proxy:SetEventFlag(821, true);
	else
		print("QWCセレン・ブラックゴースト　成立");
	end

--【セレン】
	SetFirstNpcStateFlag(proxy, param, selen_flag_list, SELEN_STATE_SEARCH_BROTHER);
	if proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork( 652);		
	end
	
--■15633■セレンの死体を調べた■
	if proxy:IsCompleteEvent( 15633 ) == false then
		proxy:AddCorpseEvent( 15633 , 652 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15633 ,0 , "OnEvent_15633",once );
 		proxy:NotNetMessage_end();
	end
	
	if	proxy:IsCompleteEvent( SELEN_STATE_DEAD )	== false and
		proxy:IsCompleteEvent( SELEN_STATE_ANGRY )	== false then
		if	proxy:IsCompleteEvent( SELEN_STATE_ANGRY ) == false then
			proxy:OnCharacterTotalDamage( 803, 652, 10000, TOTALDAMAGE_SELEN, "OnEvent_803", once );
		end
		--ゴールドラン紋章削除
		proxy:LuaCall( 801, 0, "OnEvent_801",once );
		--信仰が高い報酬
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 808, 0, "OnEvent_808",once );
		proxy:NotNetMessage_end();
		--信仰が低い報酬
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 809, 0, "OnEvent_809",once );
		proxy:NotNetMessage_end();		
	end
	--死亡監視追加
	if proxy:IsCompleteEvent( 804 ) == false then
		proxy:OnCharacterDead( 804, 652, "OnEvent_804", once );
	end

	if proxy:IsCompleteEvent( SELEN_STATE_ANGRY )	== true then --敵対しているならば
			proxy:EnableLogic( 652, true );
			proxy:SetTeamType( 652, TEAM_TYPE_AngryFriend );
			--SetNpcStateFlag( proxy, param, selen_flag_list, SELEN_STATE_ANGRY );
	end
	
	if	proxy:IsClient() == false then 
		if	proxy:IsCompleteEvent( SELEN_STATE_THANKS ) == true then
			if proxy:IsRegionIn(10000,2240) == true then
				proxy:NotNetMessage_begin();
					proxy:OnRegionJustOut( 802, LOCAL_PLAYER, 2240, "OnEvent_802", once );
				proxy:NotNetMessage_end();
				print("まだセレンに近い所にいる");
			else
				SetNpcStateFlag( proxy, param, selen_flag_list, SELEN_STATE_PURIFY );
				print("もうセレンと離れている")
			end
		end
	end
	
	--成仏していたら無効化
	if	proxy:IsCompleteEvent( SELEN_STATE_PURIFY ) == true or
		proxy:IsCompleteEvent( SELEN_STATE_DEAD ) == true then		
		if 	proxy:IsCompleteEvent( 804 ) == true and		--セレンが死んでいる
			proxy:IsCompleteEvent( 15633 ) == false then	--宝を取っていない
			--宝死体を再現
			proxy:OpeningDeadPlus( 652 , true ,false ,false );			
		else
			InvalidBackRead( proxy, 652 );
		end
	end

--■822■QWCソウルモンスター■
	if proxy:IsSuccessQWC(50100) == false then--成立していないならば
		print("ブラックゴースト無効化");
		--431を無効化
		InvalidBackRead(proxy, 436);
		--432を無効化
		InvalidBackRead(proxy, 437);
		--433を無効化
		InvalidBackRead(proxy, 438);
		
		proxy:SetEventFlag(822, true);
	end
--------------------------------△△△QWCイベント関連△△△--------------------------------
	
--■842■肉きりブラック死亡監視■
	if proxy:IsCompleteEvent( 842 ) == false then
		proxy:OnCharacterDead( 842 , 470,"OnEvent_842",once);
	else
		--無効化
		InvalidCharactor(proxy,470 );
	end
	
--■15500■乱入アイテム取得監視■ハンドラはグローバルに定義
	if proxy:IsCompleteEvent( 15500 ) == false then
--~ 		proxy:AddCorpseEvent( 15500 , 435 );--姫騎士・ブラック
		proxy:AddCorpseEvent( 15500 , 470 );--通常・ブラック
	end

--■770■ナメクジ死亡監視■
	if proxy:IsCompleteEvent( 770 ) == false then
		proxy:OnCharacterDead( 770 , 440 , "OnEvent_770",once );
	end
--■15626■ナメクジ死体調べたか？■
	if proxy:IsCompleteEvent( 15626 ) == false then
		proxy:AddCorpseEvent( 15626 , 440 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15626 ,0 , "OnEvent_15626",once );
 		proxy:NotNetMessage_end();
	end
	
--■771■ナメクジの死亡再現■
	if proxy:IsCompleteEvent( 770 ) == true then
		if proxy:IsCompleteEvent( 15626 ) == false then
			--死体を再現する
			proxy:OpeningDeadPlus( 440 , true ,false ,false );
		else
			--無効化
			InvalidCharactor( proxy, 440 );
		end
	end

--■775■呪術師死亡監視■
	if proxy:IsCompleteEvent( 775 ) == false then
		proxy:OnCharacterDead( 775 , 439 , "OnEvent_775",once );
	end
	
--■15623■呪術師の死体を調べたか？■
	if proxy:IsCompleteEvent( 15623 ) == false then
		proxy:AddCorpseEvent( 15623 , 439 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15623 , 0 ,"OnEvent_15623",once);
		proxy:NotNetMessage_end();
	end
	
--■776■呪術師の死亡再現■
	if proxy:IsCompleteEvent( 775 ) == true then
		if proxy:IsCompleteEvent( 15623 ) == false then
			--死体を再現する
			proxy:OpeningDeadPlus( 439 , true ,false ,false );
		else
			InvalidCharactor( proxy,439 );
		end
	end


	--■999999■フレーム遅れの初期化処理イベントを発行■
	proxy:NotNetMessage_begin();
		--▼0秒後▼--
		proxy:OnKeyTime2( 999992, "Second_Initialize_m05_01_00_00", 0.2, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	proxy:OnKeyTime2( 999993, "Third_Initialize_m05_01_00_00", 1.0, 1, 2, once );
	
	print("Initialize_m05_01_00_00 end");
end

--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく
function Second_Initialize_m05_01_00_00(proxy, param)
	print("Second_Initialize_m05_01_00_00 begin");
--------------------------------▽▽▽QWCイベント関連▽▽▽--------------------------------
--------------------------------△△△QWCイベント関連△△△--------------------------------

	proxy:NotNetMessage_begin();
		--■840■蠅SFX表示領域に入った■
		proxy:OnRegionJustIn( 840 , 10000 , 2260, "OnEvent_840",everytime);
		--■841■蠅SFX表示領域から出た■
		proxy:OnRegionJustOut( 841 , 10000 , 2260, "OnEvent_841",everytime);
	proxy:NotNetMessage_end();
	print("Second_Initialize_m05_01_00_00 end");
end


function Third_Initialize_m05_01_00_00(proxy,param)
--祈り腐敗人のダミー
--[[
	proxy:SetEventCommand( 140, 200 );
	proxy:SetEventCommand( 141, 200 );
	proxy:SetEventCommand( 142, 200 );
	proxy:SetEventCommand( 143, 200 );
	proxy:SetEventCommand( 144, 200 );
	proxy:SetEventCommand( 145, 200 );
]]
end

function testINORI(proxy,param)
--祈り腐敗人のダミー
--[[
	proxy:SetEventCommand( param:GetParam2(), 201 );
]]
end

--------------------------------------------------------------------------------------
--跳ね橋A■512
--------------------------------------------------------------------------------------
--■512■跳ね橋■
function OnEvent_512(proxy, param)
	print("OnEvent_512 begin");
	
	if proxy:IsCompleteEvent(512) == true then
		print("ID 512 IsCompleteEvent true"); 
		print("OnEvent_512 end");
		return;
	end
	
	proxy:PlayAnimation(1200,1);--跳ね橋の作動アニメーション
	proxy:SetEventFlag( 512, 1 );--跳ね橋は作動済み
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_KICK ) == true then
		print("OnEvent_512 end");
		return;
	end
	
	proxy:WarpDmy( 10000 , 1200 , 191 ); 
	
	print("OnEvent_512 end");
end

--------------------------------------------------------------------------------------
--■5774■石柱にワープ■
--------------------------------------------------------------------------------------
function OnEvent_5774(proxy,param)	
	print("OnEvent_5774 begin");
	
	if proxy:IsCompleteEvent( 5774 ) == true then
		return;
	end
	
	proxy:RepeatMessage_begin();
		--▼_1▼選択メニューの監視▼
		proxy:OnSelectMenu(5774, "OnEvent_5774_1", 10010710, 0, 2, 1981, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_5774 end");
end

--▲5774_1▲選択メニューの監視▲
function OnEvent_5774_1(proxy,param)	
	print("OnEvent_5774_1 begin");
	
	if proxy:IsSession() == false then
	
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1981 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			proxy:OnChrAnimEnd( 5774 , 10000 , 8283 , "OnEvent_5774_2",once);
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(5774,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_5774_1 end");
end

--▲5774_2▲選択メニューの監視▲
function OnEvent_5774_2(proxy,param)	
	print("OnEvent_5774_2 begin");
	
	proxy:SetEventFlag(5774,false);
			
	proxy:PlayAnimation(10000,8284);
	
	proxy:SetEventFlag(5774,true);
	
	OnEvent_5774_3(proxy, param);
	
	print("OnEvent_5774_2 end");
end

--■5774_3■石柱にワープ■
function OnEvent_5774_3(proxy,param)	
	print("OnEvent_5774_3 begin");
	
	--石柱へ戻ってきた判定のフラグを立てる
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag(5774,false);
	--完全回復要求
	proxy:RequestFullRecover();
	--古砦要石に戻る
	proxy:WarpNextStage( 1, 0, 0, 0, 1009);	
	print("OnEvent_5774_3 end");
end

--------------------------------------------------------------------------------------
--■580■大ナメクジ壁待機■
--------------------------------------------------------------------------------------
--■580■大ナメクジ壁待機■
function OnEvent_580(proxy,param)	
	print("OnEvent_580 begin");
	
	proxy:SetDisableGravity( 421 , false ); --重力ON
	proxy:EnableLogic( 421 , true ); --ロジックON
	proxy:SetSpStayAndDamageAnimId( 421, -1, -1 );--特殊待機アニメの無効化
	
	proxy:SetDisableGravity( 422 , false ); --重力ON
	proxy:EnableLogic( 422 , true ); --ロジックON
	proxy:SetSpStayAndDamageAnimId( 422, -1, -1 );--特殊待機アニメの無効化
	
	proxy:SetDisableGravity( 423 , false ); --重力ON
	proxy:EnableLogic( 423 , true ); --ロジックON
	proxy:SetSpStayAndDamageAnimId( 423, -1, -1 );--特殊待機アニメの無効化
	
	proxy:SetEventFlag( 580 , true );
	proxy:DeleteEvent( 580 );--監視が2種類あるので片方発動したら消す
	
	print("OnEvent_580 end");
end



--------------------------------------------------------------------------------------
--■581■大ナメクジ壁待機■
--------------------------------------------------------------------------------------
--■581■大ナメクジ壁待機■
function OnEvent_581(proxy,param)	
	print("OnEvent_581 begin");

	proxy:SetDisableGravity( 424 , false ); --重力ON
	proxy:EnableLogic( 424 , true ); --ロジックON
	proxy:SetSpStayAndDamageAnimId( 424, -1, -1 );--特殊待機アニメの無効化
	
	proxy:SetDisableGravity( 425 , false ); --重力ON
	proxy:EnableLogic( 425 , true ); --ロジックON
	proxy:SetSpStayAndDamageAnimId( 425, -1, -1 );--特殊待機アニメの無効化
	
	proxy:SetDisableGravity( 426 , false ); --重力ON
	proxy:EnableLogic( 426 , true ); --ロジックON
	proxy:SetSpStayAndDamageAnimId( 426, -1, -1 );--特殊待機アニメの無効化
	
	proxy:SetEventFlag( 581 , true );
	proxy:DeleteEvent( 581 );--監視が2種類あるので片方発動したら消す
	
	print("OnEvent_581 end");
end




--------------------------------------------------------------------------------------
--■630～659■(有)ナメクジジェネレート■
--------------------------------------------------------------------------------------
--■630～659■(有)ナメクジジェネレート■
function NamekuziGen(proxy,param)
	print("NamekuziGen begin");
	
	if proxy:IsCompleteEvent( 515 ) == true then
		--コロニーが無いので発生できない。
		return;
	end
	
	local count = 0;
	proxy:SetEventFlag( param:GetParam1(), true );
	for index = 0, 29, 1 do
		local ACID 		= 630 + index;
		local targetId 	= 100 + index;
		if proxy:IsCompleteEvent( ACID ) == false then
			count = count + 1;
			--未成立のカウントが5以上の時は、まだ出現していないナメクジになるので射出
			if count >= 5 then
				local region_list = {2302, 2305, 2306};
				local warp_point = GetWarpPoint(proxy, region_list, index );
				
				proxy:Warp(targetId, warp_point);
				proxy:RepeatMessage_begin();
					proxy:OnCharacterDead( ACID, targetId, "NamekuziGen", once );
				proxy:RepeatMessage_end();
				ValidCharactor( proxy, targetId );
				
				proxy:SetDisableGravity( targetId, false );	--重力ON
				proxy:DisableMapHit( targetId, true );		--マップ当たりOFF
				proxy:SetDeadMode(targetId, true);			--無敵ON
				
				proxy:NotNetMessage_begin();
					--1秒後にtargetIdのキャラ当たりをON
					--proxy:OnKeyTime2( ACID, "TimerCollisionOn", 1.0, 0, targetId, once );

					--ナメクジが落下視し内容に
					proxy:OnRegionJustIn( ACID, targetId, 2221, "NamekuziGen_1", once );
				proxy:NotNetMessage_begin();
				
				return;
			end
		end
	end
	print("NamekuziGen end");
end

function NamekuziGen_1(proxy,param)
	print("NamekuziGen_1 begin");
	proxy:NotNetMessage_begin();
		proxy:DisableMapHit( param:GetParam2(), false );
		--2秒後にtargetIdの無敵をOFF
		proxy:OnKeyTime2( param:GetParam1(), "TimerMutekiOff", 1.0, 0, param:GetParam2()+2000, once );
	proxy:NotNetMessage_end();
	print("NamekuziGen_1 end");
end


--------------------------------------------------------------------------------------
--■670～689■(有)腐敗人ジェネレート■
--------------------------------------------------------------------------------------
--■670～689■(有)腐敗人ジェネレート■
function HuhaibitoGen(proxy,param)
	print("HuhaibitoGen begin");
	local count = 0;
	proxy:SetEventFlag( param:GetParam1(), true );
	for index = 0, 19, 1 do
		local ACID 		= 670 + index;
		local targetId 	= 140 + index;
		if proxy:IsCompleteEvent( ACID ) == false then
			count = count + 1;
			--未成立のカウントが4以上の時は、まだ出現していない腐敗人になるので射出
			if count >= 4 then
				--print("HuhaibitoGen index = ",index, ", count = ", count, ", Dead = ", param:GetParam2(), ", nextTarget = ", targetId );
				if index <= 5 then
					--print("index check return end");
					return;
				end
				local region_list = {2301};
				local warp_point = GetWarpPoint(proxy, region_list, index );
				
				proxy:Warp(targetId, warp_point);
				proxy:OnCharacterDead( ACID, targetId, "HuhaibitoGen", once );
				ValidCharactor( proxy, targetId );
				proxy:SetDisableGravity( targetId, false );	--重力ON
				return;
			end
		end
	end
	print("HuhaibitoGen end");
end


--------------------------------------------------------------------------------------
--■700～709■(有)クラゲジェネレートA■
--------------------------------------------------------------------------------------
--■700～709■(有)クラゲジェネレートA■
function KurageGenA(proxy,param)
	print("KurageGenA begin");
	
	proxy:SetEventFlag( param:GetParam1(), true );
	KurageLap( proxy, "KurageGenA", "WarpReSearchA_1", 22, 700, 170, 1, 13, 1 ,KURAGE_GEN_ALIST);
	print("KurageGenA end");
end

function WarpReSearchA_1(proxy,param)
	print("WarpReSearchA_1 begin");
	
	KurageLap( proxy, "KurageGenA", "WarpReSearchA_2", 22, 700, 170, 1, 13, 2 ,KURAGE_GEN_ALIST);
	print("WarpReSearchA_1 end");
end

function WarpReSearchA_2(proxy,param)
	print("WarpReSearchA_2 begin");
	
	KurageLap( proxy, "KurageGenA", "WarpReSearchA_1", 22, 700, 170, 1, 13, 1 ,KURAGE_GEN_ALIST)
	print("WarpReSearchA_2 end");
end




--------------------------------------------------------------------------------------
--■710～719■(有)クラゲジェネレートB■
--------------------------------------------------------------------------------------
--■710～719■(有)クラゲジェネレートB■
function KurageGenB(proxy,param)
	print("KurageGenB begin");
	
	proxy:SetEventFlag( param:GetParam1(), true );
	KurageLap( proxy, "KurageGenB", "WarpReSearchB_1", 18, 710, 200, 2, 9, 1 ,KURAGE_GEN_BLIST);
	print("KurageGenB end");
end
function WarpReSearchB_1(proxy,param)
	print("WarpReSearchB_1 begin");
	
	KurageLap( proxy, "KurageGenB", "WarpReSearchB_2", 18, 710, 200, 2, 9, 2 ,KURAGE_GEN_BLIST);
	print("WarpReSearchB_1 end");
end

function WarpReSearchB_2(proxy,param)
	print("WarpReSearchB_2 begin");
	
	KurageLap( proxy, "KurageGenB", "WarpReSearchB_1", 18, 710, 200, 2, 9, 1 ,KURAGE_GEN_BLIST)
	print("WarpReSearchB_2 end");
end



--------------------------------------------------------------------------------------
--■720～729■(有)クラゲジェネレートC■
--------------------------------------------------------------------------------------
--■720～729■(有)クラゲジェネレートC■
function KurageGenC(proxy,param)
	print("KurageGenC begin");
	
	KurageLap( proxy, "KurageGenC", "WarpReSearchC_1", 24, 720, 220, 3, 15, 1 ,KURAGE_GEN_CLIST);
	proxy:SetEventFlag( param:GetParam1(), true );
	print("KurageGenC end");
end
function WarpReSearchC_1(proxy,param)
	print("WarpReSearchC_1 begin");
	
	KurageLap( proxy, "KurageGenC", "WarpReSearchC_2", 24, 720, 220, 3, 15, 2 ,KURAGE_GEN_CLIST);
	print("WarpReSearchC_1 end");
end

function WarpReSearchC_2(proxy,param)
	print("WarpReSearchC_2 begin");
	
	KurageLap( proxy, "KurageGenC", "WarpReSearchC_1", 24, 720, 220, 3, 15, 1 ,KURAGE_GEN_CLIST)
	print("WarpReSearchC_2 end");
end


--------------------------------------------------------------------------------------
--■730～739■(有)クラゲジェネレートD■
--------------------------------------------------------------------------------------
--■730～739■(有)クラゲジェネレートD■
function KurageGenD(proxy,param)
	print("KurageGenD begin");
	
	KurageLap( proxy, "KurageGenD", "WarpReSearchD_1", 18, 730, 250, 4, 9, 1 ,KURAGE_GEN_DLIST);
	proxy:SetEventFlag( param:GetParam1(), true );
	print("KurageGenC end");
end
function WarpReSearchD_1(proxy,param)
	print("WarpReSearchD_1 begin");
	
	KurageLap( proxy, "KurageGenD", "WarpReSearchD_2", 18, 730, 250, 4, 9, 2 ,KURAGE_GEN_DLIST);
	print("WarpReSearchD_1 end");
end

function WarpReSearchD_2(proxy,param)
	print("WarpReSearchD_2 begin");
	
	KurageLap( proxy, "KurageGenD", "WarpReSearchD_1", 18, 730, 250, 4, 9, 1 ,KURAGE_GEN_DLIST)
	print("WarpReSearchD_2 end");
end



--[[
--■クラゲジェネレータの処理まとめ関数■＠KurageLap
	proxy					…イベントプロキシ
	func_ok					…開いているスペースが存在していた時に追加する死亡監視のハンドラ名
	func_ng					…開いているスペースが存在し無かった時に追加する秒後のハンドラ名
	max_index				…最大体数-1(初期配置の体数も含めた全部の数-1)
	ACID_start				…アクションIDの頭
	TCID_start				…ターゲットのイベントIDの頭
	list_index				…登録されているポイント等の2次元配列インデックス
	staticChrNum			…初期配置体数
	conditionParam			…秒後の開始で指定するパラメータ(ループさせるのに同じハンドラが使えないため)
	checklist				…出現ポイントに先客が居ないかのチェック用リスト
]]
function KurageLap( proxy, func_ok, func_ng, max_index, ACID_start, TCID_start, list_index, staticChrNum, conditionParam ,checklist)
	--print("KurageLap begin");
	local count = 0;
	for index = 0, max_index, 1 do
		local ACID 		= ACID_start + index;
		local targetId 	= TCID_start + index;
		if proxy:IsCompleteEvent( ACID ) == false then
			count = count + 1;
			
			if count >= staticChrNum then
				local warp_point = GetWarpPointCheck(proxy, index, list_index );
				
				--ポイントが見つけれたか？
				if warp_point ~= -1 then
					--ジェネレーターに属するキャラがポイントに居るか？
					local chrnum = table.getn( checklist );
					local chridx = 1;
					local isOut = false;--既に誰かいる
					for chridx=1 , chrnum , 1 do
						local chrId = checklist[chridx];
						if proxy:IsAlive( chrId ) == true and proxy:IsRegionIn( chrIdx , warp_point ) == true then
							isOut = true;							
						end
					end
					if isOut == false then
						if proxy:IsClient() == false then
							if proxy:IsAlive(tarrgetId) == true then
								proxy:NotNetMessage_begin();
								proxy:RepeatMessage_begin();
									proxy:OnCharacterDead( ACID, targetId, func_ok, once );
								proxy:RepeatMessage_end();
								proxy:NotNetMessage_end();
							else
								print("dead chrEvent");
							end
						end
						--ココを配信できるように改良
						proxy:CustomLuaCallStartPlus( 699 , targetId,warp_point );
						--proxy:Warp(targetId, warp_point);						
						--ValidCharactor( proxy, targetId );
						--proxy:SetDisableGravity( targetId, false );	--重力ON						
					else
						proxy:NotNetMessage_begin();
							proxy:OnKeyTime2( ACID, func_ng, 1.0, 0, RapConditionCount, once );
							RapConditionCount = RapConditionCount +1;
						proxy:NotNetMessage_end();
					end
				else
					proxy:NotNetMessage_begin();
						proxy:OnKeyTime2( ACID, func_ng, 1.0, 0, RapConditionCount, once );
						RapConditionCount = RapConditionCount+1;
					proxy:NotNetMessage_end();
				end
				--print("KurageLap return end");
				return;
			end
		end
	end
	--print("KurageLap end");
end

function GenPoint(proxy,param)	
	local target = param:GetParam2();
	local point = param:GetParam3();
	if proxy:IsAlive( target ) == true then
		proxy:Warp( target , point );						
		ValidCharactor( proxy, target );
		proxy:SetDisableGravity( target, false );	--重力ON
		print("GenPoint target:",target,"  point:",point);
	end
end

--[[
--■クラゲジェネレータ用のワープポイント取得■＠GetWarpPoint
	proxy					…イベントプロキシ
	region_list				…領域のIDが登録されているリスト
	rand					…乱数要素(こいつの値に%領域の数で出現箇所の初期検索位置を決める)
]]
function GetWarpPoint(proxy, region_list, rand )
	local region_num = table.getn( region_list );
	local index = 0;
	for index = 0, region_num - 1, 1 do
		local rest = proxy:DivideRest( rand + index, region_num );
		return region_list[rest+1];
	end
	return -1;
end

--[[
--■クラゲジェネレータ用のワープポイント取得■＠GetWarpPointCheck
	proxy					…イベントプロキシ
	rand					…乱数要素(こいつの値に%領域の数で出現箇所の初期検索位置を決める)
	list_index				…登録されているポイント等の2次元配列インデックス
]]
function GetWarpPointCheck( proxy, rand, list_index)
	local reg_listA = {2310, 2311, 2312};
	local reg_listB = {2313, 2314, 2315};
	local reg_listC = {2316, 2317};
	local reg_listD = {2318, 2319};
	local region_listlist = {reg_listA, reg_listB, reg_listC, reg_listD};
	
	local act_listA = { 790,  791,  792};
	local act_listB = { 793,  794,  795};
	local act_listC = { 796,  797};
	local act_listD = { 798,  799};
	local action_listlist = {act_listA, act_listB, act_listC, act_listD};

	--要素数を取得
	local region_num = table.getn( region_listlist[list_index] );
	local index = 0;
	--print("rand ", rand);
	--print("list_index ", list_index);
	--print("region_num ", region_num);
	for index = 0, region_num - 1, 1 do
		--割った余りを取得
		local rest = proxy:DivideRest( rand + index, region_num );
		--print("index ",index);
		--print("rest ",rest);
		--print("region_num = ",region_num,", rest = ",rest,", rand = ",rand, ", last = ", region_listlist[list_index][rest+1]);
		
		--中に誰もいない
		if proxy:IsCompleteEvent(action_listlist[list_index][rest+1]) == false then
			--print("GetWarpPointCheck return WarpPoint to ",region_listlist[list_index][rest+1]);
			return region_listlist[list_index][rest+1];
		end
	end
	print("GetWarpPointCheck Failed");
	return -1;
end


--[[
--■ジェネレータの登録まとめ関数■＠GenerateRegist
	proxy					…イベントプロキシ
	ACID_start				…アクションIDの頭
	TCID_start				…ターゲットのイベントIDの頭
	max_index				…最大体数-1(初期配置の体数も含めた全部の数-1)
	staticChrNum			…初期配置体数
	func					…追加する死亡監視のハンドラ名
]]
function GenerateRegist(proxy, ACID_start, TCID_start, max_index, staticChrNum, func)
	local count = 0;
	for index = 0, max_index, 1 do
		local ACID 		= ACID_start + index;
		local targetId 	= TCID_start + index;
		if proxy:IsCompleteEvent( ACID ) == false then
			count = count + 1;
			if count <= staticChrNum then
				proxy:OnCharacterDead( ACID, targetId, func, once );
			else
				proxy:SetDisableGravity( targetId, true );
				InvalidCharactor( proxy, targetId );
			end
		else
			proxy:SetDisableGravity( targetId, true );
			InvalidCharactor( proxy, targetId );
		end
	end
end

function GenerateRegistKURAGE(proxy, ACID_start, TCID_start, max_index, staticChrNum, func)
	local count = 0;
	for index = 0, max_index, 1 do
		local ACID 		= ACID_start + index;
		local targetId 	= TCID_start + index;
		if proxy:IsCompleteEvent( ACID ) == false then
			count = count + 1;
			if count <= staticChrNum then
				if proxy:IsClient() == false then					
					proxy:NotNetMessage_begin();
					proxy:RepeatMessage_begin();
						proxy:OnCharacterDead( ACID, targetId, func, once );
					proxy:RepeatMessage_end();
					proxy:NotNetMessage_end();
				end
			else
				proxy:SetDisableGravity( targetId, true );
				InvalidCharactor( proxy, targetId );
			end
		else
			proxy:SetDisableGravity( targetId, true );
			InvalidCharactor( proxy, targetId );
		end
	end
end

--[[
--■OnKeyTime用関数■＠TimerCollisionOn
--一定時間で当たりをOnにする。際、OnKeyTimeのParamに当たりを操作したいキャラのイベントIDを指定する
]]
function TimerCollisionOn(proxy,param)
	print("TimerCollisionOn target = ", param:GetParam3() );
	proxy:DisableMapHit( param:GetParam3(), false );
	--proxy:SetColiEnable( param:GetParam3(), true );
end
--[[
--■OnKeyTime用関数■＠TimerMutekiOff
--一定時間で無敵をOffにする。際、OnKeyTimeのParamに当たりを操作したいキャラのイベントIDを指定する
]]
function TimerMutekiOff(proxy,param)
	print("TimerMutekiOff target = ", param:GetParam3() );
	proxy:SetDeadMode( param:GetParam3()-2000, false);--無敵OFF
end

--------------------------------------------------------------------------------------
--■515■ナメクジコロニー■
--------------------------------------------------------------------------------------
--■515■ナメクジコロニー■
Namekuzi_HitCount = 0;
function Check_515(proxy,param)
	--ココは毎フレーム監視されるのでprintを入れるのはお勧めしません。テストの時だけにしてください。
	if proxy:CheckChrHit_Obj(10000,1250) == true then
		if proxy:IsRegionIn( 10000, 2220 ) == true then
			--条件が成立した瞬間なので、ココにはprintを入れておくことをお勧めします
			print("Check_515 true");
			return true
		end
	end
	return false;
end

function OnEvent_515(proxy,param)	
	if Namekuzi_HitCount > 5 then		
		--コロニー落ちるアニメ再生
		proxy:ForcePlayAnimation( 1250, 2 );

		proxy:NotNetMessage_begin();
			proxy:OnCharacterAnimEnd( 524, 1250, 2, "NamekuziFallAnimEnd", once );
		proxy:NotNetMessage_end();
		
		--コロニーの当たりOFF
		proxy:SetColiEnable( 1250, false );
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 517, "OnEvent_517", 1.7, 0, 2, once );
		proxy:NotNetMessage_end();
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 517, "OnEvent_517_3", 1.6, 0, 3, once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 515, true );
		proxy:SetEventFlag( 516, true );--便宜上立てておく
		proxy:DeleteEvent( 515 );
	else		
		Namekuzi_HitCount = Namekuzi_HitCount + 1;
		print("Namekuzi_HitCount = ", Namekuzi_HitCount );
		if proxy:IsEventAnim( 1250 , 0 ) == true then
			proxy:PlayAnimation( 1250, 1 );
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				proxy:OnCharacterAnimEnd( 515, 1250, 1, "NamekuziDamageAnimEnd", once );
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();
		end
	end	
end

function NamekuziDamageAnimEnd(proxy,param)
	if proxy:IsEventAnim( 1250 , 2 ) == false then
		print("NamekuziDamageAnimEnd begin");
		proxy:PlayAnimation( 1250, 0 );
		print("NamekuziDamageAnimEnd end");
	end
end

function NamekuziFallAnimEnd(proxy,param)
	print("NamekuziFallAnimEnd begin");
	for index = 1, 15, 1 do
		ValidCharactor( proxy, 700 + index - 1);
	end
	proxy:SetColiEnable( 1250, false );
	proxy:SetDrawEnable( 1250, false );
	print("NamekuziFallAnimEnd end");
end


--------------------------------------------------------------------------------------
--■517■ムーンライト■
--------------------------------------------------------------------------------------
function OnEvent_517(proxy,param)

	--ムーンライトの当たり・表示ON
	proxy:SetColiEnable( 1260, true );
	proxy:SetDrawEnable( 1260, true );
	proxy:TreasureDispModeChange2( 1260, true ,KEN_SFX);
	
	if proxy:IsCompleteEvent( 517 ) == false then
		--ホスト、生存、グレイのみ調べることができる
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		
		proxy:OnDistanceActionAttribute( 517 , 10000 , 1260 , "OnEvent_517_0" , ItemBoxDist_A , 10010140 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
		proxy:LuaCall( 517,1,"OnEvent_517_2",once);
		proxy:LuaCall( 517,2,"OnEvent_517_4",once);
		
	else
		proxy:SetDrawEnable( 1260 , false );--ひとまず描画だけOFF
		proxy:SetColiEnable( 1260 , false );
	end
	
end


--ムーンライト取得処理
function OnEvent_517_0(proxy,param)
	if param:IsNetMessage() == false then
	print("OnEvent_517_0 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:PlayAnimation( 10000 , 8290);		
		proxy:PlayAnimation( 1260 , 1);	
		proxy:OnKeyTime2( 517 , "OnEvent_517_wait",0.01,0,100,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_517_0 end");
	end
end

function OnEvent_517_wait(proxy,param)
	print("OnEvent_517_wait begin");
	if proxy:IsEventAnim( 10000 , 8290 ) == true then
		proxy:LuaCallStart( 517 , 2 );
	else
		proxy:ForcePlayAnimation( 1260 , 0);	
	end
	print("OnEvent_517_wait end");
end

function OnEvent_517_1(proxy,param)
	print("OnEvent_517_1 begin");
	
	--アイテム取得関数--パラメータ10430参照
	proxy:GetRateItem(10430);	
		
	--OBJを消すためのイベント配信
	proxy:LuaCallStart( 517, 1);

	print("OnEvent_517_1 end");
end

function OnEvent_517_2(proxy,param)
	print("OnEvent_517_2 begin");
	--オブジェが消える
	proxy:SetDrawEnable( 1260 , false );--ひとまず描画だけOFF
	proxy:SetColiEnable( 1260 , false );--当たりはあるのは不明(現状ではないようなので消さない)
	
	--アイテムを取得済み
	proxy:SetEventFlag( 517, true );
	proxy:DeleteEvent( 517 );
	
	print("OnEvent_517_2 end");
end

function OnEvent_517_3(proxy,param)
	print("OnEvent_517_3 begin");
	proxy:ValidSfx( 2222 );
	print("OnEvent_517_3 end");
end

--アニメ同期・監視
function OnEvent_517_4(proxy,param)
	print("OnEvent_517_4 begin");	
	proxy:TreasureDispModeChange2( 1260, false ,KEN_SFX);
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8290 ) == true then--新しいアニメ 
		proxy:PlayAnimation( 1260 , 1);	
		print("OnEvent_517 end");
		return true;
	end

	--剣にワープ
	proxy:WarpDmy( 10000 , 1260 , 191 );	
	
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 517 , 10000 , 8290 , "OnEvent_517_1", once);
	proxy:NotNetMessage_end();
	print("OnEvent_517_4 end");
end



--------------------------------------------------------------------------------------
--■520■毒沼■
--------------------------------------------------------------------------------------
--■520■毒沼■
function PoizonFloorDam(proxy,param)
	--床ダメージ用ポイントの各イベントID
	--2210
	local floorTbl = {2210};
	local tblnum = table.getn( floorTbl );	
	local ACID = 520;
	
	--とりあえず判定前に倒しておく
	IsInPoizonArea = false;
	
	--領域の中でも毒ダメージを受けない領域
	local floorTbl_out = {2215, 2216};
	local tblnum_out = table.getn( floorTbl_out );
	
	for index = 1, tblnum, 1 do
		if proxy:IsRegionIn( 10000, floorTbl[index] ) == true then
			IsInPoizonArea = true;
		end
	end
	
	if IsInPoizonArea == true then
		for index = 1, tblnum_out, 1 do
			if proxy:IsRegionIn( 10000, floorTbl_out[index] ) == true then
				IsInPoizonArea = false;
			end
		end
	end
	
--~ 	--入っている間はかけ続ける(毒耐性で毒がかからなくなる問題対策)
--~ 	if	IsInPoizonArea == true then
--~ 	end
	
	--入った瞬間
	if proxy:IsCompleteEvent( ACID ) == false and
		IsInPoizonArea == true then
		print("PoizonFloorDam JustIn", tblnum);
		proxy:SetEventSpecialEffect(10000, 10080);
		
		proxy:SetEventFlag( ACID, IsInPoizonArea );
		
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 521, "OnEvent_521", 0.0, 0, 1, once );
		proxy:NotNetMessage_end();
	end
	
	--抜け出た瞬間
	if  proxy:IsCompleteEvent( ACID ) == true and
		IsInPoizonArea == false then
		print("PoizonFloorDam JustOut", tblnum);
		proxy:EraseEventSpecialEffect(10000, 10080);
		
		proxy:SetEventFlag( ACID, IsInPoizonArea );
		proxy:DeleteEvent( 521 );
	end

	
	--絶対に結果を成立させないよ
	return false;
end

function dummy(proxy,param)
end

function OnEvent_521(proxy,param)
	--print("OnEvent_521 begin");
	local set_param = proxy:DivideRest( param:GetParam3() + 1, 2 );
	local reload = Lua_GetReloadTime(proxy,PoizonCycle_low,PoizonCycle_High);
	
	--print("reload ",reload)
	
	--継続的に入っている時のみ次の監視を追加できる
	if IsInPoizonArea == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 521, "OnEvent_521", reload, 0, set_param, once );
		proxy:NotNetMessage_end();
	else
		--念の為重い歩き解除
		proxy:EraseEventSpecialEffect(10000, 10080);
	end
	
	proxy:SetEventSpecialEffect( LOCAL_PLAYER, 10280);
	--print("OnEvent_521 end");
end

--------------------------------------------------------------------------------------
--徘徊デーモンの登場■??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ)
function PlayerDeath_m05_01_00_00(proxy, param)
	print("PlayerDeath_m05_01_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m05_01_00_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。
	
	print("PlayerDeath_m05_01_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ)
function PlayerRevive_m05_01_00_00(proxy,param)
	print("PlayerRevive_m05_01_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m05_01_00_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。
	
	print("PlayerRevive_m05_01_00_00");
end

--------------------------------------------------------------------------------------
--ボス部屋の中に入る■533
--------------------------------------------------------------------------------------

--■イベントがループなので、全部リピートにする↓

--■533■中ボス部屋への扉が開く■
function OnEvent_533(proxy,param)
	print("OnEvent_533 begin");

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_533 end");
		return;
	end	
	
	--クライアントへ、ボス部屋阻止失敗を通知
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 534 , 1 );--旋回アニメの同期再生
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE , true );--多重発動防止用フラグON
	--多重起動システムIDをタイムアウトを設定してONにする
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_533 end");
end


--旋回アニメの同期再生(IDが別)
function OnEvent_534_1(proxy,param)
	print("OnEvent_534_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を行い、その終了時にOnEvent_534_2を発行する
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2890 );
		else
			proxy:LockSession();--ルームをロックします！
			--旋回アニメ再生を行い、その終了時にOnEvent_534_2を発行する
			proxy:OnTurnCharactorEnd( 534, 10000, 2890, "OnEvent_534_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_534_1 end");
end

--旋回アニメの同期再生終了後
function OnEvent_534_2(proxy,param)
	print("OnEvent_534_2 begin");
	
	--同期用歩きアニメ再生
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 534, 10000, ANIMEID_WALK, "OnEvent_534_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();

	print("OnEvent_534_2 end");
end

--歩きアニメの同期再生終了後
function OnEvent_534_3(proxy,param)
	print("OnEvent_534_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ
	if proxy:IsCompleteEvent( 533 ) == false then
		proxy:LuaCallStart( 534 , 5 );--2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知
		proxy:LuaCallStart( 534 , 6 );--フラグセット(同期用)
		Lua_MultiDoping(proxy,809);--マルチプレイドーピング
	end

	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );

	print("OnEvent_534_3 end");
end


--■533 2回目以降にボス部屋に入るためのイベント配信用
function OnEvent_533_GO_TO_IN(proxy, param)
	print("OnEvent_533_GO_TO_IN begin");
		
	proxy:NotNetMessage_begin();
		--▼534▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_533
		proxy:OnPlayerActionInRegion( 534, 2894, "OnEvent_533", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	
	print("OnEvent_533_GO_TO_IN end");
end


--■533 フラグセット(同期用)
function OnEvent_533_flag_set(proxy, param)
	print("OnEvent_533_flag_set begin");
		
	proxy:SetEventFlag( 533 , 1 );
	proxy:DeleteEvent( 533 );

	print("OnEvent_533_flag_set end");
end


--------------------------------------------------------------------------------------
--■537■ボス戦闘開始■
--------------------------------------------------------------------------------------
--■537■ボス戦闘開始■
function OnEvent_537(proxy,param)
	print("OnEvent_537 begin");
	proxy:PlayPointSE( 2250, SOUND_TYPE_M, 50100000, 1 );
	proxy:ResetThink( 809 );
	proxy:EnableLogic( 809, true );

	--1度ボスを倒し損ねて再戦する時、フラグが立ったままだと初期化できません。
	--proxy:SetEventFlag(537, true);
	
	--ボスゲージ表示
	proxy:SetBossGauge(809, 0, 5080);
	proxy:SetEventFlag( 537 , true );
	
	print("OnEvent_537 end");
end


--------------------------------------------------------------------------------------
--■5770■ボス死亡■
--------------------------------------------------------------------------------------
--■5770■ボス死亡■
function OnEvent_5770(proxy,param)
	print("OnEvent_5770 begin");
	
	proxy:NotNetMessage_begin();
		--1秒後にアイテム取得イベントを発行--
		proxy:OnKeyTime2(5770,"OnEvent_5770_1", 1.0,0,0,once);
		--2秒後に崩れる壁発動イベントを発行--
		proxy:OnKeyTime2(5772,"OnEvent_5772", 2.0,0,0,once);
		--マルチ解散監視
		proxy:OnRegistFunc( 5770,"Check_5770_PT","OnEvent_5770_PT",0,once);
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( 5770, true );--フラグを立てる。

	--ブロッククリア処理へ
	proxy:CustomLuaCallStart( 4050, 809 );
	--トカゲリセット
	ResetTokage(proxy);
	
	print("OnEvent_5770 end");
end

--▲5770_1▲1秒後▲
function OnEvent_5770_1(proxy, param)
	print("OnEvent_5770_1 begin");
	
	--ボスを倒した数を更新(数によってフラグを立てる)
	GetBossFlagCount( proxy, param );
	
	--▼トロフィー取得判定▼
	Lua_RequestUnlockTrophy(proxy, 35);--トロフィの状況を判定し、取得
		
	--ホストプレイヤーのみアイテム入手イベントに使用
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	
	--宝死体(ソウル?)有効化
	proxy:SetDrawEnable( 1981 , true );
	proxy:SetColiEnable( 1981 , true );
	--ソウルに刺さった剣有効化
	proxy:SetDrawEnable( 1976 , true );
	proxy:SetColiEnable( 1976 , true );
	
	--▼(ソウル)アイテム取得用イベント監視追加▼
	if proxy:IsCompleteEvent( 5773 ) == false then
		--SFXの有効化
		proxy:ValidSfx( 2360 );--要石のオーラ
		proxy:ValidSfx( 2361 );--光の粒子
		--ソウルと刺さっている剣を輝かせる
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--光らせる
		--proxy:TreasureDispModeChange2( 1976 , true ,KANAME_SFX);--光らせる
		proxy:OnDistanceActionAttribute( 5773 , 10000 , 1981 , "OnEvent_5773" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end
	
	print("OnEvent_5770_1 end");
end

--▲5770_2▲2秒後▲
function OnEvent_5772(proxy, param)
	print("OnEvent_5772 begin");
	
	--ボス戦用のBGM停止
	--proxy:StopPointSE( 0 );
	proxy:StopPointSE( 1 );	

	print("OnEvent_5772 end");
end

--マルチ解散監視
function Check_5770_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--マルチじゃない
function OnEvent_5770_PT(proxy,param)
	print("OnEvent_5770_PT begin");
	--中ボス部屋の前後の魔法壁が消える(全プレイヤー)
	proxy:SetColiEnable( 1998 , false );
	proxy:SetColiEnable( 1994 , false );
	
	proxy:SetDrawEnable( 1998 , false );
	proxy:SetDrawEnable( 1994 , false );	

	--光の壁Sfxを消す
	proxy:InvalidSfx( 1986, true );
	proxy:InvalidSfx( 1990, true );	
	
	--中ボス部屋前の移動処理イベントを削除
	proxy:DeleteEvent( 533 );--一人目が入るとき用
	proxy:DeleteEvent( 534 );--二人目以降が入るとき用
	print("OnEvent_5770_PT end");
end

--------------------------------------------------------------------------------------
--■5773■ソウル入手■
--------------------------------------------------------------------------------------
function OnEvent_5773(proxy, param)
	print("OnEvent_5773 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ 
		print("OnEvent_5773 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行
		proxy:OnKeyTime2( 5773, "OnEvent_5773_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_5773 end");
end


--■5773_1■アイテム取得■
function OnEvent_5773_1(proxy, param)
	print("OnEvent_5773_1 begin");

	--アイテム取得関数
	proxy:GetRateItem(10451);--パラメータ10451参照
	proxy:GetRateItem(10474);--パラメータ10474参照
	proxy:GetRateItem(10475);--パラメータ10475参照
	proxy:GetRateItem(10476);--パラメータ10476参照
	proxy:GetRateItem(10477);--パラメータ10477参照
	
	--アイテムを取得済み
	proxy:SetEventFlag( 5773, 1 );
	
	--宝シェーダーOFF
	--proxy:TreasureDispModeChange( 1981 , false );

	--SFXが消える
	proxy:InvalidSfx( 2360 , true );--要石のオーラ
	--proxy:InvalidSfx( 2361 , true );--光の粒子
	
	--▼要石でワープ用の監視を追加▼
	proxy:OnDistanceActionAttribute( 5774 , 10000 , 1981 , "OnEvent_5774" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_5773_1 end");
end

--------------------------------------------------------------------------------------
--■535■光の壁■
--------------------------------------------------------------------------------------
--■535■光の壁■
function OnEvent_535(proxy,param)
	print("OnEvent_535 begin");
	
	if proxy:IsCompleteEvent(535) == true then
		return;
	end
	
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
	
	proxy:DeleteEvent( 535 );
	proxy:SetDrawEnable( 1300, false );--描画OFF
	proxy:SetColiEnable( 1300, false );--当たりOFF
	proxy:InvalidSfx( 2200, true );
	proxy:SetObjDeactivate( 1300 , true );--デアクティブ
	
	print("OnEvent_535_delete end");
end



--------------------------------------------------------------------------------------
--■536■光の壁■
--------------------------------------------------------------------------------------
--■536■光の壁■
function OnEvent_536(proxy,param)
	print("OnEvent_536 begin");
	
	if proxy:IsCompleteEvent(536) == true then
		return;
	end
	
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
	
	proxy:DeleteEvent( 536 );
	proxy:SetDrawEnable( 1301, false );--描画OFF
	proxy:SetColiEnable( 1301, false );--当たりOFF
	proxy:SetObjDeactivate( 1301 , true );--デアクティブ
	proxy:InvalidSfx( 2201, true );
	
	print("OnEvent_536_delete end");
end

--------------------------------------------------------------------------------------
--■538■ボスカメラ切り替えイベント■
--------------------------------------------------------------------------------------
function OnEvent_538(proxy,param)
	--print("OnEvent_538 begin");
	--ボスが死んでいない　かつ　ボスとの戦闘を開始している
	if proxy:IsCompleteEvent( 5770 ) == false and proxy:IsCompleteEvent( 537 ) == true then
		--ボス戦　非ロックカメラ
		proxy:SetCamModeParamTargetId(5021);
		--ボス戦　ロックカメラ
		proxy:SetCamModeParamTargetIdForBossLock(5020);
	end
	--print("OnEvent_538 end");
end

--------------------------------------------------------------------------------------
--■セレン関連■
--------------------------------------------------------------------------------------
-----------------------------------------------------------------------------
--801■ゴールドランの紋章譲渡
-----------------------------------------------------------------------------
function OnEvent_801(proxy,param)
	print("OnEvent_801 begin");
	
	if	proxy:RemoveInventoryEquip( TYPE_GOODS, 37 ) == true then
		print("OnEvent_801 アイテム削除成功");
	end
	SetNpcStateFlag( proxy, param, selen_flag_list, SELEN_STATE_THANKS );
	
	proxy:SetEventFlag( 801, true );
	proxy:NotNetMessage_begin();
	proxy:OnRegionJustOut( 802, LOCAL_PLAYER, 2240, "OnEvent_802", once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_801 end");
end

function OnEvent_802(proxy,param)
	print("OnEvent_802 begin");
	
	proxy:SetEventFlag( 802, true );
	SetNpcStateFlag( proxy, param, selen_flag_list, SELEN_STATE_PURIFY );
	InvalidCharactor( proxy, 652 );
	
	print("OnEvent_802 end");
end

-----------------------------------------------------------------------------
--803■セレン敵対
-----------------------------------------------------------------------------
function OnEvent_803(proxy,param)
	print("OnEvent_803 begin");
	proxy:SetEventFlag( 803, true );
	
	proxy:EnableLogic( 652, true );
	proxy:SetTeamType( 652, TEAM_TYPE_AngryFriend );
	SetNpcStateFlag( proxy, param, selen_flag_list, SELEN_STATE_ANGRY );

	print("OnEvent_803 end");
end

-----------------------------------------------------------------------------
--804■セレン死亡
-----------------------------------------------------------------------------
function OnEvent_804(proxy,param)
	print("OnEvent_804 begin");
	
	proxy:SetEventFlag( 804, true );
	SetNpcStateFlag( proxy, param, selen_flag_list, SELEN_STATE_DEAD );
	
	print("OnEvent_804 end");
end

--セレンの死体を調べた
function OnEvent_15633(proxy,param)
	print("OnEvent_15633 begin");
	proxy:SetEventFlag( 15633 , true );
	print("OnEvent_15633 end");
end

-----------------------------------------------------------------------------
--808■信仰が高い時の報酬（指輪）
-----------------------------------------------------------------------------
function OnEvent_808(proxy,param)
	print("OnEvent_808 begin");
	--アイテムを入手する
	proxy:GetRateItem(10750);--指輪
	
	proxy:SetEventFlag( 808,true);
	
	print("OnEvent_808 end");
end

-----------------------------------------------------------------------------
--809■信仰が低い時の報酬（暗月草）
-----------------------------------------------------------------------------
function OnEvent_809(proxy,param)
	print("OnEvent_809 begin");
	--アイテムを入手する
	proxy:GetRateItem(10751);--暗月草

	proxy:SetEventFlag( 809,true);
	
	print("OnEvent_809 end");
end

-----------------------------------------------------------------------------
--セレン・ブラックゴーストが死亡したかどうかのフラグセット
-----------------------------------------------------------------------------
function OnEvent_820(proxy, param)
	print("OnEvent_820 begin");
	--死亡したフラグを立てる
	proxy:SetEventFlag( 820, true );
		
	print("OnEvent_820 end");
end

-----------------------------------------------------------------------------
--■15600■セレン・ブラックゴーストの死体を調べたか？
-----------------------------------------------------------------------------
function OnEvent_15600(proxy,param)
	print("OnEvent_15600 begin");
	proxy:SetEventFlag( 15600 , true );
	print("OnEvent_15600 end");
end

--------------------------------------------------------------------------------------
--乞食(女)に一定ダメージ■810
--------------------------------------------------------------------------------------
function OnEvent_810(proxy,param)
	print("OnEvent_810 begin");

	--ロジックOn
	proxy:EnableLogic( 677, true );
	
	--乞食(女)の状態を敵対(不浄3)にする
	SetNpcStateFlag(proxy, param, Kojiki_Shop_Flag_list, KOJIKI_FEMALE_SHOP_HOSTILE02);
	--乞食(女)のチームタイプを変更する
	proxy:SetTeamType( 677, TEAM_TYPE_AngryFriend );

	--フラグを立てる
	proxy:SetEventFlag( 810, true );
	
	print("OnEvent_810 end");
end


--------------------------------------------------------------------------------------
--乞食(女)死亡■811
--------------------------------------------------------------------------------------
function OnEvent_811(proxy,param)
	print("OnEvent_811 begin");

	--乞食(女)の状態を「死亡」に変える
	SetNpcStateFlag( proxy, param, Kojiki_Shop_Flag_list, KOJIKI_FEMALE_SHOP_DEAD );
	
	--敵に削られて敵対を通り越して死亡もありえるので、ここでも削除
	--死んだら敵対にはならないので削除
	proxy:DeleteEvent( 270 );
	proxy:DeleteEvent( 810 );

	--フラグを立てる
	proxy:SetEventFlag( 811, true );
	
	print("OnEvent_811 end");
end


------------------------------
--鉱石の精霊死亡監視--
------------------------------
function OnEvent_828(proxy, param)
	print("OnEvent_828 begin");
	--死亡したフラグを立てる
	proxy:SetEventFlag( 828, true );
		
	print("OnEvent_828 end");
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
--■842■肉きりブラック死亡監視■
--------------------------------------------------------------------------------------
function OnEvent_842(proxy,param)
	print("OnEvent_842 begin");
	proxy:SetEventFlag( 842 , true );
	print("OnEvent_842 end");
end


--------------------------------------------------------------------------------------
--■840■蠅SFX表示領域に入った■
--------------------------------------------------------------------------------------
function OnEvent_840(proxy,param)
	print("OnEvent_840 begin");
	proxy:CreateCamSfx(95202,0);
	print("OnEvent_840 end");
end


--------------------------------------------------------------------------------------
--■841■蠅SFX表示領域から出た■
--------------------------------------------------------------------------------------
function OnEvent_841(proxy,param)
	print("OnEvent_841 begin");
	proxy:DeleteCamSfx( 0 );
	print("OnEvent_841 end");
end


--------------------------------------------------------------------------------------
--■770■ナメクジ死亡した■
--------------------------------------------------------------------------------------
function OnEvent_770(proxy,param)
	print("OnEvent_770 begin");	
	proxy:SetEventFlag( 770 , true );
	print("OnEvent_770 end");
end

--------------------------------------------------------------------------------------
--■15626■ナメクジ死体調べた■
--------------------------------------------------------------------------------------
function OnEvent_15626(proxy,param)
	print("OnEvent_15626 begin");
	proxy:SetEventFlag( 15626 , true );
	print("OnEvent_15626 end");
end

--------------------------------------------------------------------------------------
--■775■呪術師死亡した■
--------------------------------------------------------------------------------------
function OnEvent_775(proxy,param)
	print("OnEvent_775 begin");	
	proxy:SetEventFlag( 775 , true );
	print("OnEvent_775 end");
end

--------------------------------------------------------------------------------------
--■15623■呪術師死体調べた■
--------------------------------------------------------------------------------------
function OnEvent_15623(proxy,param)
	print("OnEvent_15623 begin");
	proxy:SetEventFlag( 15623 , true );
	print("OnEvent_15623 end");
end
