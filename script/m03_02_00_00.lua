
--■徘徊デーモン用のID

demon_id_list_m03_02_00_00 = { 832 };


--影人行進待ち
START_MARCH_WAIT = 0.0;

--------------------------
--マスターサツキ用のQWC値
--------------------------
--マスターサツキ出現用QWC
MasterQWC_01 = 0;
MasterQWC_02 = 0;
MasterQWC_03 = 0;
--剣出現用QWC
MasterSwordQWC_01 = 0;
MasterSwordQWC_02 = 0;
MasterSwordQWC_03 = 0;
---------------------------------
--マスターサツキの状態変化フラグ
---------------------------------
--m_03_01_00_00に記載

--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■
--------------------------------------------------------------------------------------
function Initialize_m03_02_00_00(proxy)
	print("Initialize_m03_02_00_00 begin");
-----------------------------------------------------------------------------------------
--ボス関連
-----------------------------------------------------------------------------------------
--■1108■ボスのポリ劇再生■
	if proxy:IsCompleteEvent( 4895 ) == false then	
		SingleReset( proxy,1108 );
		SingleReset( proxy,4880 );
	end
	if proxy:IsCompleteEvent( 1108 ) == false then 	
		--▼ボス前のポリ劇再生用監視追加
		proxy:NotNetMessage_begin();
			proxy:OnRegionJustIn( 1108 , 10000 , 2897 , "OnEvent_1108" , once );
		proxy:NotNetMessage_end();
		proxy:LuaCall( 1108 , 1 ,"OnEvent_1108_1",once);
		
		proxy:NotNetMessage_begin();
			--ポリ劇開始に呼ばれるハンドラ
			proxy:LuaCall(1108, REMO_START, "OnEvent_1108_RemoStart", once);
			--ポリ劇終了後に呼ばれるハンドラ(トリガー起こした人用)
			proxy:LuaCall(1108, REMO_FINISH, "OnEvent_1108_RemoFinish", once);
		proxy:NotNetMessage_end();	
	end
	
--■1108■ボスのポリ劇再生■
	if proxy:IsCompleteEvent( 1108 ) == true then--ポリ劇終了済み	
		proxy:EndAnimation( 1408 , 1 );--扉が開くアニメ終了
		proxy:EndAnimation( 1407 , 1 );--床がへこむアニメ終了
	else
		--ポリ劇後の瓦礫の表示と当たりを消しておく
		proxy:SetDrawEnable( 1421, false );
		proxy:SetColiEnable( 1421, false );--瓦礫に当たりがあるかは不明…
		--敵を表示させない
		InvalidCharactor( proxy, 805 );
	end	

--■1190■ボス部屋に入る■	
	--中ボスが生きているときだけイベント登録
	if proxy:IsCompleteEvent( 4895 ) == false then	
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。
		SingleReset(proxy, 1190);
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き)
		proxy:LuaCall( 1191, 1, "OnEvent_1190_1", everytime );		
		--▽2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCall( 1191 , 5 , "OnEvent_1190_GO_TO_IN" , everytime );		
		--▽フラグセット(同期用)
		proxy:LuaCall( 1191 , 6 , "OnEvent_1190_flag_set" , everytime );		
		--誰かがボス前扉をまだ通過していない
		if proxy:IsCompleteEvent( 1190 ) == false then		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;			
			proxy:NotNetMessage_begin();
				--▼1190▼扉が開いているときに中に入るためのイベントを追加▼
				proxy:OnPlayerActionInRegionAttribute( 1190, 2893, "OnEvent_1190", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
		
		else --グレイゴーストできたときようにいると思われる。		
			proxy:NotNetMessage_begin();			
				--▼1191▼扉が開いているときに中に入るためのイベントを追加▼
				proxy:OnPlayerActionInRegion( 1191, 2893, "OnEvent_1190", HELPID_GO_TO_IN, everytime );--ハンドラは上と同じ
			proxy:NotNetMessage_end();		
		end
	end	

--■4895■中ボス死亡時■
	proxy:AddFieldInsFilter( 805 );
	if proxy:IsCompleteEvent( 4895 ) ==false then
		proxy:OnCharacterDead(4895, 805, "OnEvent_4895", once);
	else
		proxy:EndAnimation( 1002, 1 );
	end

--■4897■ボス部屋BGM再生&ロジックON■
	if proxy:IsCompleteEvent(4895) == false then
		SingleReset( proxy, 4897 );
		proxy:OnRegionIn( 4897,10000,2885,"OnEvent_4897",everytime);
	end

	
--■1122■ポリ劇開始■
	if proxy:IsCompleteEvent( 1122 ) == false then
		--▼ボス前のポリ劇再生用監視追加
		proxy:OnRegionJustIn( 1122 , 10000 , 2423 , "OnEvent_1122" , once );		
		
		--影人無効化
		InvalidCharactor(proxy, 200);
		InvalidCharactor(proxy, 201);
		InvalidCharactor(proxy, 202);
		InvalidCharactor(proxy, 203);
		
		--ポリ劇配信用ハンドラ
		proxy:LuaCall( 1122, 1, "OnEvent_1122_3", once );
		proxy:NotNetMessage_begin();			
			--ポリ劇開始に呼ばれるハンドラ
			proxy:LuaCall(1122, REMO_START, "OnEvent_1122_RemoStart", once);
			--ポリ劇終了後に呼ばれるハンドラ(トリガー起こした人用)
			proxy:LuaCall(1122, REMO_FINISH, "OnEvent_1122_RemoFinish", once);
		proxy:NotNetMessage_end();
	else	
		--スイッチを押し込んだ状態にしておく
		proxy:EndAnimation( 1400, 1 );
		--扉を開いた状態にしておく
		proxy:EndAnimation( 1401, 1 );
		
		--無効化していた影人有効化
		ValidCharactor(proxy, 200);
		ValidCharactor(proxy, 201);
		ValidCharactor(proxy, 202);
		ValidCharactor(proxy, 203);
	end	

--■1195■ボス部屋のボス壁・石扉処理■
	if proxy:IsCompleteEvent( 1195 ) == false then
		proxy:InvalidSfx( 1985 , false );
	end

--■ボス関連の初期化処理
	if proxy:IsCompleteEvent( 4895 ) ==true then
		
		--▽ボス死んでいるとき
		--ボスはもう現れない
		InvalidBackRead( proxy , 805 );
		--初期化でボスを消した時のフラグを立てる
		proxy:SetEventFlag( 4896, true );
		
		--ホストプレイヤーのみアイテム入手イベントに使用
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		
		--魔法壁消える
		proxy:SetColiEnable( 1993 , false );			
		proxy:SetDrawEnable( 1993 , false );
		
		proxy:SetColiEnable( 1997 , false );			
		proxy:SetDrawEnable( 1997 , false );
		
		--SFX消去
		proxy:InvalidSfx(1985,false);
		proxy:InvalidSfx(1989,false);
		
		--要石OBJ有効化
		proxy:SetDrawEnable( 1980 , true );--描画
		proxy:SetColiEnable( 1980 , true );--アタリ
		--要石OBJ2有効化
		proxy:SetDrawEnable( 1977 , true );--描画
		proxy:SetColiEnable( 1977 , true );--アタリ
		
		proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--光らせる
		--▼(ソウル)アイテム取得用イベント監視追加▼
		if proxy:IsCompleteEvent( 4874 ) == false then
			proxy:ValidSfx( 2532 );--SFX 有効化
			proxy:ValidSfx( 2533 );--SFX 有効化			
			proxy:OnDistanceActionAttribute( 4874 , 10000 , 1980 , "OnEvent_4874" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--▼要石でワープ用の監視を追加▼
			SingleReset(proxy,4875);
			--SFX消去
			proxy:InvalidSfx(2532,false);--光の粒子
			proxy:OnDistanceActionAttribute( 4875 , 10000 , 1980 , "OnEvent_4875" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end

	else
		--▽ボス生きているとき
		proxy:EnableLogic( 805 , false );--ロジックOFFで待機
		
		--ポリ劇再生でまだ表示されてないので、無効化
		if proxy:IsCompleteEvent( 1108 )== false then
			InvalidCharactor(proxy, 805);
			--proxy:SetDrawEnable( 1420, true );
			proxy:SetDrawEnable( 1421, false );
		end

		--要石OBJの無効化
		proxy:SetColiEnable( 1980 , false );--アタリ
		proxy:SetDrawEnable( 1980 , false );--描画
		--要石OBJ2の無効化
		proxy:SetColiEnable( 1977 , false );--アタリ
		proxy:SetDrawEnable( 1977 , false );--描画
		
		--SFXのOFF
		proxy:InvalidSfx(2532,false);
		proxy:InvalidSfx(2533,false);
		
	end

--■1220■ボス戦カメラ対応■
	--ボスが生きているなら登録
	if proxy:IsCompleteEvent(4895) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 1220 , 10000 , 2885 ,"OnEvent_1220" , everytime );
		proxy:NotNetMessage_end();
	end

-----------------------------------------------------------------------------------------
--ギミック関連
-----------------------------------------------------------------------------------------
--光の霧を通過できるキャラタイプ(このタイプの人だけアクションボタンが反応する)
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

--■1094■石柱にワープ■
	--本来要石ワープなので不必要
	--proxy:OnDistanceActionAttribute( 1094, 10000, 1982, "OnEvent_1094", WarpGimmickDist_A, HELPID_GO_TO_SEKITYUU, 0, 180, ATTR_NOSESSION, everytime );

--■1160■扉が開くポリ劇再生■
	if proxy:IsCompleteEvent( 1160 ) == false then
		proxy:OnRegionJustIn( 1160 , 10000 , 2528 , "OnEvent_1160" , once );
		
		proxy:NotNetMessage_begin();
			--ポリ劇開始フェード後に呼ばれるハンドラ
			proxy:LuaCall(1160,REMO_START,"OnEvent_1160_RemoStart",once);
			--ポリ劇終了後に呼ばれるハンドラ
			proxy:LuaCall(1160,REMO_FINISH,"OnEvent_1160_RemoFinish",once);
		proxy:NotNetMessage_end();
	else
	end
	
--■1111■ホストPCのみが通れる光の霧■
	if proxy:IsCompleteEvent( 1111 ) == true then--ホストが通過済み
		proxy:SetDrawEnable( 1499 , false );
		proxy:SetColiEnable( 1499 , false );
		proxy:InvalidSfx(2501,false);
	else
		--▼1111▼魔法壁削除同期用▼
		proxy:LuaCall( 1111 , 1 , "OnEvent_1111_delete_wall" , once );
		--▼1111▼壁の中に入るイベント発動用▼
		proxy:OnDistanceActionAttribute( 1111 , 10000 , 1499 , "OnEvent_1111" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
	
--■1112■ホストPCのみが通れる光の霧■
	if proxy:IsCompleteEvent( 1112 ) == true then--ホストが通過済み
		proxy:SetDrawEnable( 1500 , false );
		proxy:SetColiEnable( 1500 , false );
		proxy:InvalidSfx(2502,false);
	else
		--▼1112▼魔法壁削除同期用▼
		proxy:LuaCall( 1112 , 1 , "OnEvent_1112_delete_wall" , once );
		--▼1112▼壁の中に入るイベント発動用▼
		proxy:OnDistanceActionAttribute( 1112 , 10000 , 1500 , "OnEvent_1112" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
	
--[[
--■1113■ホストPCのみが通れる光の霧■
	if proxy:IsCompleteEvent( 1113 ) == true then--ホストが通過済み
		proxy:SetDrawEnable( 1501 , false );
		proxy:SetColiEnable( 1501 , false );
		proxy:InvalidSfx(2503,false);
	else
		--▼1113▼魔法壁削除同期用▼
		proxy:LuaCall( 1113 , 1 , "OnEvent_1113_delete_wall" , once );
		--▼1113▼壁の中に入るイベント発動用▼
		proxy:OnDistanceActionAttribute( 1113 , 10000 , 1501 , "OnEvent_1113" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
]]

--[[
--■1119■鷹の攻撃■
	proxy:OnRegistFunc(1119, "Check_1119", "OnEvent_1119", 1, everytime );
	proxy:OnCharacterDead( 1119, 346, "OnEvent_1119_1", once );

--■1120■鷹の攻撃■
	proxy:OnRegistFunc(1120, "Check_1120", "OnEvent_1120", 1, everytime );
	proxy:OnCharacterDead( 1120, 347, "OnEvent_1120_1", once );
]]

--■1054■パッチに突き落とされる扉の開放■
	if proxy:IsCompleteEvent(1054) == false then
		print("落とし穴開放");
		proxy:EndAnimation(1410,1);
		proxy:SetEventFlag(1054, true);
	else
		print("すでに落とし穴は開放済み");
		proxy:EndAnimation(1410,1);
	end
	
--■1143■ゴーストロジックON■
	--パッチに突き落とされるポリ劇を見てるか誠入手領域に入ったら
	if proxy:IsCompleteEvent(1143) == true or proxy:IsCompleteEvent(1165) == true then
		proxy:EnableLogic(355, true);

	else
		proxy:EnableLogic(355,false);
		proxy:OnRegionIn(1143,10000,2513,"OnEvent_1143",once);		
		--proxy:OnRegionIn(1143,10000,2553,"OnEvent_1143",once);
		
	end
	
--■1064■遺体廃棄所の扉■
	if proxy:IsCompleteEvent( 1064 ) == false then
		proxy:OnDistanceActionPlus( 1064, 10000, 1412, "OnEvent_1064", DoorDist_A, HELPID_OPEN , 180 , DoorAngle_A, 1.2 , -1.2 , -0.1 , once );
	else
		proxy:EndAnimation( 1412, 1 );
	end


--■1074■遺体廃棄所の両開き扉(床スイッチC)■
	if proxy:IsCompleteEvent( 1074 ) ==false then
	--▼PCがOBJ(1413)に対して距離(150)内にいる時▼--
		proxy:OnPlayerDistanceInTarget( 1074, 10000, 1413, "OnEvent_1074", FloorSwitchDist_A, once );
	else
		proxy:EndAnimation( 1413, 1 );--床アニメ
		proxy:EndAnimation( 1406, 1 );--扉アニメ
	end

	
--■1160■扉が開くポリ劇再生
	if proxy:IsCompleteEvent( 1160 ) == true then
		proxy:EndAnimation( 1409 , 1 );--対応する扉が開くアニメ終了
		--床アニメ
		proxy:EndAnimation( 1405, 1 );
	end

------------------------------------------------------------------------------------------------
--★骸骨剣士起動★
------------------------------------------------------------------------------------------------
--■1390～1395■骸骨剣士_起動■
	--入りなおした時にリセット
	for ActionID_02 = 1390, 1398, 1 do
		SingleReset(proxy, ActionID_02);
	end
	
	local actidlist = { 1390 ,1391 ,1392 ,1393 ,1394 ,1395 ,1396 ,1397 ,1398 };
	local eneidlist = { 290 ,291 ,292 ,293 ,294 ,295 ,434 ,435 ,436 };
	local num = table.getn( actidlist );

	--起動する距離監視の追加と初期化
	for index = 1 ,num , 1 do
		local SkeletonID = eneidlist[index];	
		local ActionID = actidlist[index];
		if proxy:IsCompleteEvent(ActionID) == false then
			proxy:OnPlayerDistanceInTarget(ActionID, 10000, SkeletonID, "OnEvent_"..ActionID, 30.0, once);--骨剣士との距離が一定値(25)以下
			--骨剣士初期化
			proxy:PlayLoopAnimation(SkeletonID, 7000);--潰れてるアニメ
			proxy:SetColiEnable(SkeletonID, false);--アタリOFF
		else
			if proxy:IsAlive(SkeletonID) == true then--生きているならば
				proxy:StopLoopAnimation(SkeletonID);--潰れているアニメのループ終了
				proxy:SetSpStayAndDamageAnimId(SkeletonID,-1,-1);--特殊待機アニメの無効化
				proxy:EndAnimation(SkeletonID, 7001);--起き上がるアニメ再生
				proxy:SetColiEnable(SkeletonID, true);--アタリON
				proxy:EnableLogic( SkeletonID, true );--ロジックON
				print("★"..SkeletonID.."は、すでに起動済み");
			else--死亡していたら
				proxy:ForceDead(SkeletonID);--強制的に死亡させる
				--InvalidCharactor(proxy, SkeletonID);
				print("※"..SkeletonID.."は、すでに死んでいる");
			end
		end
	end

------------------------------------------------------------------------------------------------
--★ウィルオウィスプ爆発★
------------------------------------------------------------------------------------------------
--■1370～1375■ウィルオウィスプ爆発■
	--InvalidCharactor(proxy, 340);
	--起動する距離監視の追加と初期化
	CreateBulletOwner(proxy,340);
	for WillOTheWispID = 1480, 1485, 1 do	--ウィルオウィスプID
		local ActionID = WillOTheWispID - 110;
		
		--入りなおした時にリセット
		SingleReset(proxy, ActionID);
		
		if proxy:IsCompleteEvent(ActionID) == false then--まだ爆発していない
			proxy:OnPlayerDistanceInTarget(ActionID, 10000, WillOTheWispID, "OnEvent_"..ActionID, 2.0, once);--距離監視（2ｍ）追加
			proxy:SetObjSfx(WillOTheWispID, 1 , 93000 , true );	--オブジェにＳＦＸをセット
		else--すでに爆発している
			--InvalidCharactor(proxy, WillOTheWispID);--すでに爆発しているので消去
			print("※ウィルオウィスプ（"..WillOTheWispID..")は、すでに爆死している");
		end
	end

-----------------------------------------------------------------------------
--■1380～1381■槍射出トラップ
-----------------------------------------------------------------------------
--[[OnEvent_1380, OnEvent_1381
	for index = 1, 2, 1 do
		local acId		= 1380 + index - 1;
		local regionId	= 2450 + index - 1;
		local objId_1	= 1430 + index - 1;
		local objId_2	= 1440 + index - 1;
		local ownerId	= 343  + index - 1;
		
		--シングルならリセット
		SingleReset(proxy, acId);
		
		--敵を無効にする
		InvalidCharactor(proxy, ownerId);
		
		proxy:SetBallista( objId_2, ownerId );
		if	proxy:IsCompleteEvent( acId ) == false then
			proxy:OnRegionJustIn( acId, LOCAL_PLAYER, regionId, "OnEvent_"..acId, once );
		else
			proxy:EndAnimation( objId_1, 1 );
			proxy:EndAnimation( objId_2, 1 );
		end
	end]]
	--１発だけになったので、無駄なエラーを出さないように別記
	local acId		= 1381;
	local regionId	= 2451;
	local objId_1	= 1431;
	local objId_2	= 1441;
	local ownerId	= 344;
	local SfxId	= 93005;--SFXのID
	
	--シングルならリセット
	SingleReset(proxy, 1381);
	
	proxy:SetBallista( 1441, 344 );

	--敵を無効にする
	InvalidCharactor(proxy, ownerId);
	
	if	proxy:IsCompleteEvent( acId ) == false then
		proxy:OnRegionJustIn( acId, LOCAL_PLAYER, regionId, "OnEvent_"..acId, once );
		proxy:SetObjSfx(objId_1, 1, SfxId, false);		
	else
		proxy:EndAnimation( objId_1, 1 );
		proxy:EndAnimation( objId_2, 1 );
	end
	
--■1084■徘徊デーモンの登場■ハンドラ登録
	--必要か？
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。
		proxy:LuaCall( 4000, 100, "PlayerDeath_m03_02_00_00", everytime );
		--プレイヤーが復活した時にキックされます。
		proxy:LuaCall( 4032, 100, "PlayerRevive_m03_02_00_00", everytime );
	proxy:NotNetMessage_end();

--■徘徊デーモン用
	if proxy:IsCompleteEvent( 1084 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m03_02_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m03_02_00_00);
	end

--------------------------------▽▽▽QWCイベント関連▽▽▽--------------------------------
--■鉱石の精霊■
	--■610■鉱石の精霊がいない■
	if proxy:IsCompleteEvent( 1234 ) == true
	   or proxy:IsSuccessQWC( 30110 ) == false then
		InvalidCharactor( proxy, 433 );
		print("QWC未成立、もしくは死んでいるので鉱石の精霊を無効化します");
	end
	--■611■鉱石の精霊の死亡監視■
	if proxy:IsCompleteEvent( 1234 ) == false then
		proxy:OnCharacterDead( 1234, 433, "OnEvent_1234", once );
		
		if proxy:IsClient() == false and proxy:IsCompleteEvent(8020) == false then
			proxy:NotNetMessage_begin();
				proxy:AddCorpseEvent( 8020 , 433 );
				proxy:LuaCall( 8020 , 0 , "OnEvent_8020",once);
			proxy:NotNetMessage_end();
		end
	end
--------------------------------△△△QWCイベント関連△△△--------------------------------

---------------------------------------------------------------------------
--■魔法使い＆影人関連イベント■
---------------------------------------------------------------------------
--■1310■魔法使い死亡■
	SingleReset(proxy, 1310);
	if proxy:IsCompleteEvent(1310) == false then
		--[[ジェネレーター
		proxy:EnableGeneratorSystem(1450, true);
		proxy:EnableGeneratorSystem(1451, true);
		proxy:EnableGeneratorSystem(1452, true);
		proxy:EnableGeneratorSystem(1453, true);
		proxy:EnableGeneratorSystem(1454, true);
		proxy:EnableGeneratorSystem(1455, true);
		print("ジェネレーター有効化");]]
		
		proxy:OnCharacterDead(1310, 100, "OnEvent_1310", once);
	end
	
--■1320■魔法使い死亡■
	SingleReset(proxy, 1320);
	if proxy:IsCompleteEvent(1320) == false then
		--[[ジェネレーター
		proxy:EnableGeneratorSystem(1460, true);
		proxy:EnableGeneratorSystem(1461, true);
		proxy:EnableGeneratorSystem(1462, true);
		proxy:EnableGeneratorSystem(1463, true);
		print("ジェネレーター有効化");]]
		
		proxy:OnCharacterDead(1320, 101, "OnEvent_1320", once);
	end
	
--■1330■魔法使い死亡■
	SingleReset(proxy, 1330);
	if proxy:IsCompleteEvent(1330) == false then
		--[[ジェネレーター
		proxy:EnableGeneratorSystem(1470, true);
		print("ジェネレーター有効化");]]
		
		proxy:OnCharacterDead(1330, 102, "OnEvent_1330", once);
	end

--[[	
--■1151～1156■魔法使い移動イベント■
	if proxy:IsAlive(356) == true then
	
		if proxy:IsCompleteEvent(1151) == false then
			--初期位置から動いて無い
			proxy:OnRegionIn(1151,10000,2515,"OnEvent_1151",once);
			
		elseif proxy:IsCompleteEvent(1152) == false then
			--領域2522までたどり着いてる
			proxy:ChangeInitPosAng(356,2522);
			if proxy:IsClient() == false then
				proxy:Warp(356,2522);
			end
			proxy:OnRegionIn(1152,10000,2516,"OnEvent_1152",once);
			
		elseif proxy:IsCompleteEvent(1153) == false then
			--領域2523までたどり着いてる
			proxy:ChangeInitPosAng(356,2523);
			if proxy:IsClient() == false then
				proxy:Warp(356,2523);
			end
			proxy:OnRegionIn(1153,10000,2517,"OnEvent_1153",once);
			
		elseif proxy:IsCompleteEvent(1154) == false then
			--領域2524までたどり着いてる
			proxy:ChangeInitPosAng(356,2524);
			if proxy:IsClient() == false then
				proxy:Warp(356,2524);
			end
			proxy:OnRegionIn(1154,10000,2518,"OnEvent_1154",once);
			
		elseif proxy:IsCompleteEvent(1155) == false then
			--領域2525までたどり着いてる
			proxy:ChangeInitPosAng(356,2525);
			if proxy:IsClient() == false then
				proxy:Warp(356,2525);
			end
			proxy:OnRegionIn(1155,10000,2519,"OnEvent_1155",once);
			
		elseif proxy:IsCompleteEvent(1156) == false then
			--領域2526までたどり着いてる
			proxy:ChangeInitPosAng(356,2526);
			if proxy:IsClient() == false then
				proxy:Warp(356,2526);
			end
			proxy:OnRegionIn(1156,10000,2520,"OnEvent_1156",once);
			
		else
			--領域2527までたどり着いている
			proxy:ChangeInitPosAng(356,2527);
			if proxy:IsClient() == false then
				proxy:Warp(356,2527);
			end
			
		end
		--次の地点へ向かう為のハンドラ
		proxy:LuaCall(1151,1,"OnEvent_1151_ToMove",once);
		proxy:LuaCall(1152,1,"OnEvent_1152_ToMove",once);
		proxy:LuaCall(1153,1,"OnEvent_1153_ToMove",once);
		proxy:LuaCall(1154,1,"OnEvent_1154_ToMove",once);
		proxy:LuaCall(1155,1,"OnEvent_1155_ToMove",once);
		proxy:LuaCall(1156,1,"OnEvent_1156_ToMove",once);
		--フラグ同期用のハンドラ
		proxy:LuaCall(1151,2,"OnEvent_1151_flag",once);
		proxy:LuaCall(1152,2,"OnEvent_1152_flag",once);
		proxy:LuaCall(1153,2,"OnEvent_1153_flag",once);
		proxy:LuaCall(1154,2,"OnEvent_1154_flag",once);
		proxy:LuaCall(1155,2,"OnEvent_1155_flag",once);
		proxy:LuaCall(1156,2,"OnEvent_1156_flag",once);
	end

--■1173■魔法使い死亡■
	SingleReset(proxy,1173);
	if proxy:IsCompleteEvent(1173) == false then
		proxy:OnCharacterDead(1173,357,"OnEvent_1173",once);
	end
	
--■1174■魔法使い死亡■
	SingleReset(proxy,1174);
	if proxy:IsCompleteEvent(1174) == false then
		proxy:OnCharacterDead(1174,356,"OnEvent_1174",once);
	end
	
--■1175■魔法使い死亡■
	SingleReset(proxy,1175);
	if proxy:IsCompleteEvent(1175) == false then
		proxy:OnCharacterDead(1175,358,"OnEvent_1175",once);
	end
	
--■1176■魔法使い死亡■
	SingleReset(proxy,1176);
	if proxy:IsCompleteEvent(1176) == false then
		proxy:OnCharacterDead(1176,359,"OnEvent_1176",once);
	end


--■1123■影人行進■
	--シングルならフラグOFF
	SingleReset(proxy,1123);	

	--行進終わってなくて　進入し切れてないなら
	if proxy:IsCompleteEvent(1123) == false and proxy:IsCompleteEvent(1132) == false then		
		proxy:OnRegionIn(1123,10000,2512,"OnEvent_1123",once);		
		--影人A登録
		proxy:LuaCall(1125,0,"OnEvent_1125",once);
		proxy:LuaCall(1126,0,"OnEvent_1126",once);			
		--影人B登録
		proxy:LuaCall(1127,0,"OnEvent_1127",once);
		proxy:LuaCall(1128,0,"OnEvent_1128",once);
		--影人C登録
		proxy:LuaCall(1129,0,"OnEvent_1129",once);
		proxy:LuaCall(1130,0,"OnEvent_1130",once);
		proxy:LuaCall(1131,0,"OnEvent_1131",once);		
		--影人D登録
		proxy:LuaCall(1132,0,"OnEvent_1132",once);
		proxy:LuaCall(1133,0,"OnEvent_1133",once);
		proxy:LuaCall(1134,0,"OnEvent_1134",once);		
		--影人E登録
		proxy:LuaCall(1135,0,"OnEvent_1135",once);
		proxy:LuaCall(1136,0,"OnEvent_1136",once);
		proxy:LuaCall(1137,0,"OnEvent_1137",once);
		--影人F登録
		proxy:LuaCall(1138,0,"OnEvent_1138",once);
		proxy:LuaCall(1139,0,"OnEvent_1139",once);
		proxy:LuaCall(1140,0,"OnEvent_1140",once);
	end
	
	--シングルリセット
	SingleReset(proxy,1132);	
	
	if proxy:IsCompleteEvent(1123) == false and proxy:IsCompleteEvent(1132) == false then
		proxy:OnRegionIn(1132,10000,2424,"OnEvent_1132",once);
	end

--■1177■複数影人死亡監視：ジェネレータ起動■
	SingleReset(proxy,1177);
	if proxy:IsCompleteEvent(1177) == false then
		proxy:OnCharacterDead(1177,360,"OnEvent_1177_360",once);
		proxy:OnCharacterDead(1177,361,"OnEvent_1177_361",once);
		proxy:OnCharacterDead(1177,362,"OnEvent_1177_362",once);
		proxy:OnCharacterDead(1177,363,"OnEvent_1177_363",once);
		proxy:OnCharacterDead(1177,364,"OnEvent_1177_364",once);
	else
		if proxy:IsCompleteEvent(1173) == false then
			--ジェネレータ起動
			proxy:EnableGeneratorSystem(2532,true);
			proxy:OnRegistFunc( 1181,"Check_1181","OnEvent_1181",1,once);
		end
	end

--■1178■領域監視:ジェネレータ起動■
	SingleReset(proxy,1178);
	if proxy:IsCompleteEvent(1178) == false then
		proxy:OnRegionIn(1178,10000,2542,"OnEvent_1178",once);
	else
		--既に発動していたら停止しているのかを調べてから起動させる
		if proxy:IsCompleteEvent(1174) == false then
			--ジェネレータ起動
			if proxy:IsCompleteEvent(1151) == false then
				proxy:EnableGeneratorSystem(2533,true);
			elseif proxy:IsCompleteEvent(1152) == false then
				proxy:EnableGeneratorSystem(2534,true);
			elseif proxy:IsCompleteEvent(1153) == false then
				proxy:EnableGeneratorSystem(2535,true);
			elseif proxy:IsCompleteEvent(1154) == false then
				proxy:EnableGeneratorSystem(2536,true);
			elseif proxy:IsCompleteEvent(1155) == false then
				proxy:EnableGeneratorSystem(2537,true);
			elseif proxy:IsCompleteEvent(1156) == false then
				proxy:EnableGeneratorSystem(2538,true);
			else
				proxy:EnableGeneratorSystem(2539,true);
			end
			proxy:OnRegistFunc( 1182,"Check_1182","OnEvent_1182",0,once);
		end
	end
	
--■1179■領域監視:ジェネレータ起動■
	SingleReset(proxy,1179);
	if proxy:IsCompleteEvent(1179) == false then
		proxy:OnRegionIn(1179,10000,2543,"OnEvent_1179",once);
	else
		if proxy:IsCompleteEvent(1175) == false then
			--ジェネレータ起動
			proxy:EnableGeneratorSystem(2540,true);
			proxy:OnRegistFunc(1183,"Check_1183","OnEvent_1183",1,once);
		end
	end
	
--■1180■領域監視:ジェネレータ起動■
	SingleReset(proxy,1180);
	if proxy:IsCompleteEvent(1180) == false then
		proxy:OnRegionIn(1180,10000,2544,"OnEvent_1180",once);
	else
		if proxy:IsCompleteEvent(1176) == false then
			--ジェネレータ起動
			proxy:EnableGeneratorSystem(2541,true);
			proxy:OnRegistFunc(1184,"Check_1184","OnEvent_1184",1,once);
		end
	end
]]

--■8085■古砦に来たフラグを立てる■
	proxy:SetEventFlag(8085, true);

-----------------------------------------------------------------------------------------
--NPC関連
-----------------------------------------------------------------------------------------
	--フラグを見てスキル屋NPC状態を初期化
	SetFirstNpcStateFlag( proxy, param, urubain_flag_list, URUBAIN_STATE_HELP );
	
	if proxy:IsCompleteEvent( URUBAIN_STATE_HELP ) == true then
		proxy:SetEventFlag( 1161, true );
	end


	--死亡していないとき
	if proxy:IsCompleteEvent( URUBAIN_STATE_DEAD ) == false then
		--敵対していないとき
		if proxy:IsCompleteEvent( URUBAIN_STATE_ANGRY ) == false then			
			
			--■1250■スキル屋NPCを助けてない
			if proxy:IsCompleteEvent(1250) == false then
				--黒ゴーストの監視
				proxy:OnCharacterDead(1250,355,"OnEvent_1250",once);
			else--助けてる
				InvalidBackRead(proxy,355);
			end
			
			--ウルベイン感謝
			if proxy:IsCompleteEvent( 1157 ) == false then
				proxy:LuaCall( 1157 , 0 , "OnEvent_1157",once);
			end
			
			--■1158■【スキル屋NPC】NPCが敵になってない■
			if proxy:IsCompleteEvent( 1158 ) == false then
				--proxy:OnCharacterTotalDamage( 1158, 635, 10000,TOTALDAMAGE_SKILLSHOP, "OnEvent_1158", once );
				proxy:OnCharacterTotalRateDamage( 1158, 635, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1158", once );
			end				
			
		else--敵対していたら
			proxy:EnableLogic( 635, true );
			SetNpcStateFlag(proxy,param,urubain_flag_list,URUBAIN_STATE_ANGRY);
			
			proxy:SetTeamType( 635, TEAM_TYPE_AngryFriend );
			
			proxy:SetEventFlag( 1162, true );
		end
		--■1159■【スキル屋NPC】NPCが死んだ■
		if proxy:IsCompleteEvent( 1159 ) == false then
			proxy:OnCharacterDead( 1159, 635, "OnEvent_1159", once );		
		end
	else
		print("スキル屋NPC死亡");		
		--死んでいるので無効化		
		proxy:ForceUpdateNextFrame(635);
		InvalidBackRead(proxy, 635 );		
		proxy:SetEventFlag( 1163, true );
	end
	
	--スキル屋感謝で石柱に移動になるので・・・キャラを消す
	if proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR ) == true then
		InvalidBackRead(proxy,635);
	end

------------------------------------
--フラグを見てバッチNPC状態を初期化
------------------------------------
	SetFirstNpcStateFlag( proxy, param, batti_flag_list, BATTI_NOT_STAY );--状態が設定されていなければ、どこにもいないに
	
	--パッチの更新権限はホストが管理
	if proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork(636);
	end
	
--■1193■パッチがアイテムをくれる(会話からの呼び出し)
	proxy:NotNetMessage_begin();
		proxy:LuaCall(1193, 0, "OnEvent_1193", once);
	proxy:NotNetMessage_end();
	
--■1192■パッチイベント監視(初めて古砦に来た場合)
	--落とすポリ劇が終わってないなら
	if proxy:IsCompleteEvent( 1165 ) == false then
		--バッチがどこにもいないか出撃準備中ならば
		if	proxy:IsCompleteEvent( BATTI_NOT_STAY ) 	== true or
			proxy:IsCompleteEvent( BATTI_RESERVE_M1 )	== true	then
			proxy:OnRegionJustIn( 1192, 10000, 2540, "OnEvent_1192", once);--領域への侵入監視追加
		end
	end

--■1165■
	if proxy:IsCompleteEvent( 1165 ) == false then--領域監視が追加されていなかったら(なかで状態判定)
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionJustIn(1165,10000,2530,"OnEvent_1165",everytime);--突き落とすアクション監視追加
			proxy:NotNetMessage_end();
		end
		
		proxy:LuaCall(1165, 1, "OnEvent_1165_0", once);
		
		proxy:NotNetMessage_begin();
			--ポリ劇開始に呼ばれるハンドラ
			proxy:LuaCall(1165, REMO_START, "OnEvent_1165_RemoStart", once);
			--ポリ劇終了後に呼ばれるハンドラ(トリガー起こした人用)
			proxy:LuaCall(1165, REMO_FINISH, "OnEvent_1165_RemoFinish", once);
		proxy:NotNetMessage_end();
	end

--■1166■突き落として敵対
	if proxy:IsCompleteEvent( 1166 ) == false then--領域監視が追加されていなかったら(なかで状態判定)
		proxy:OnRegionJustIn(1165,636,2410,"OnEvent_1166",everytime);
		
	end
	--パッチの死亡監視と敵対監視
	if	proxy:IsCompleteEvent( BATTI_ANGRY ) == false then--敵対ではない
		--proxy:OnCharacterTotalDamage( 1167, 636, 10000,TOTALDAMAGE_BATTI, "OnEvent_1167", once );--ダメージ監視追加
		proxy:OnCharacterTotalRateDamage( 1167, 636, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1167", once );
	end
	--上記の状態の時に、死亡監視追加
	proxy:OnCharacterDead( 1168, 636, "OnEvent_1168", once );
	
	--突き落とした(古砦)か満足ならば
	if	proxy:IsCompleteEvent( BATTI_PUSHING )		== true or
		proxy:IsCompleteEvent( BATTI_SATISFIED )	== true then
			
		proxy:SetEventFlag( 1169, true );
		
	--敵対しているならば
	elseif	proxy:IsCompleteEvent( BATTI_ANGRY )		== true then
		proxy:EnableLogic( 636 , true );--ロジックＯＮ
		--SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_ANGRY);--敵対にする
		proxy:SetTeamType( 636, TEAM_TYPE_AngryFriend );--チームタイプを変更
		proxy:SetEventFlag( 1171, 1 );
	--「どこにもいない」もしくは「出撃準備中」の時は領域に入った時に有効にするので、一先ず無効化
	elseif	proxy:IsCompleteEvent( BATTI_RESERVE_M1 )	== true or
			proxy:IsCompleteEvent( BATTI_NOT_STAY )		== true then
		InvalidCharactor( proxy, 636 );--一先ず無効化(領域に入った時に有効にする)
	
	--上記のどれにも当てはまらなければ(「どこにもいない」もしくは「出撃準備中」でないのは絶対条件)
	elseif	proxy:IsCompleteEvent( BATTI_NOT_STAY )		== false and
			proxy:IsCompleteEvent( BATTI_RESERVE_M1 )	== false then 
		InvalidBackRead(proxy, 636);--無効化
		proxy:SetEventFlag( 1170, false );
	
	end
--------------------------------▽▽▽QWCイベント関連▽▽▽--------------------------------
--■ブラックゴースト■
	--■1233■ブラックゴーストがいない■
	--QWC条件(30100)が成立していないときに
	if proxy:IsSuccessQWC( 30100 ) == false then
		--ブラックゴーストをいなくする
		InvalidCharactor( proxy, 434 );
		InvalidCharactor( proxy, 435 );
		InvalidCharactor( proxy, 436 );
		print("ValidCharactor BlackGhost Failed!!");
	end
--------------------------------△△△QWCイベント関連△△△--------------------------------
--[[2008.06.10 toyohide 状態判定を　m03_01に移動
	--盗掘者が敵対している
	if proxy:IsCompleteEvent( 1185 ) == true and proxy:IsCompleteEvent( 1186 ) == false then
		proxy:EnableLogic( 678 , true );
		SetNpcStateFlag(proxy,param,STEAL_SHOP_Flag_list,STEAL_SHOP_HOSTILE);
		proxy:SetTeamType( 678, TEAM_TYPE_AngryFriend );
		proxy:SetEventFlag( 1187, true );
	end

	--盗掘者が死亡しているので消える
	if proxy:IsCompleteEvent( 1186 ) == true then
		proxy:EnableLogic( 678 , false );
		SetNpcStateFlag(proxy,param,STEAL_SHOP_Flag_list,STEAL_SHOP_DEAD);
		InvalidBackRead( proxy , 678 );
		proxy:SetEventFlag( 1188, true );
	end

--■160■盗掘者NPCが敵になる■
	if proxy:IsCompleteEvent(1185) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 1185 , 0 , "OnEvent_1185" , everytime );
		proxy:NotNetMessage_end();
		proxy:OnCharacterTotalDamage( 1185, 678, 10000, STEAL_SHOP_TOTALDAMAGE, "OnEvent_1185_1", once );	
	end

--■161■盗掘者NPC死亡■
	if proxy:IsCompleteEvent( 1186 ) == false then
		proxy:OnCharacterDead( 1186 , 678 , "OnEvent_1186" , once );
	end
]]

--結晶トカゲ逃走イベント
	RegistTokage(proxy,1040,253,9);	
	
--■15500■乱入アイテム取得監視■ハンドラはグローバルに定義
	if proxy:IsCompleteEvent( 15500 ) == false then
		proxy:AddCorpseEvent( 15500 , 355 );--閉じ込めNPC		
	end
	
--■1400■魔法の壁破壊3■
	SingleReset(proxy,1400);
	if proxy:IsCompleteEvent( 1400 ) == false then
		--復帰
		proxy:RestorePiece( 1520 );
		proxy:OnObjectDestroy( 1400 , 1520 ,"OnEvent_1400",once);
	else
		proxy:ReconstructBreak( 1520,1);
	end

--■999999■フレーム遅れの初期化処理イベントを発行■
	proxy:NotNetMessage_begin();
		--▼0秒後▼--
		proxy:OnKeyTime2( 999992, "Second_Initialize_m03_02_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
--------------------------------------------------------------------------------------
--↑整理済み　↓未整理　■Initialize_m03_02_00_00
--------------------------------------------------------------------------------------
	print("Initialize_m03_02_00_00 end");
end


--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく
function Second_Initialize_m03_02_00_00(proxy, param)
	print("Second_Initialize_m03_02_00_00 begin");

--------------------------------▽▽▽QWCイベント関連▽▽▽--------------------------------
--■1200■QWCイベントで「誠」入手■
	if	proxy:IsSuccessQWC(30140) == true then--QWC条件を満たした場合
		print("QWC「成立」誠 有効");
		--地面に落ちてない方の「誠」
		proxy:SetDrawEnable( 1511 , false );
		proxy:EnableObjTreasure( 1511, false );
		--地面に落ちている方の「誠」
		proxy:SetDrawEnable( 11280, true );
		proxy:EnableObjTreasure( 11280, true );
		
		proxy:SetEventFlag(1200, true);
		
	else--QWC条件が満たされていない場合
		print("QWC「不成立」誠 無効");
		--地面に落ちてないほうの「誠」
		proxy:SetDrawEnable( 1511, true );
		proxy:EnableObjTreasure( 1511, true );
		--地面に落ちているほうの「誠」
		proxy:SetDrawEnable( 11280 , false );
		proxy:EnableObjTreasure( 11280 , false );
		
		proxy:SetEventFlag(1200, false);
		
	end
--------------------------------△△△QWCイベント関連△△△--------------------------------

	print("Second_Initialize_m03_02_00_00 end");
end

--------------------------------------------------------------------------------------
--■1111■ホストPCのみが通れる光の霧■
--------------------------------------------------------------------------------------
--■1111_delete_wall■魔法壁削除同期用■
function OnEvent_1111_delete_wall(proxy , param)
	print("OnEvent_1111_delete_wall begin");
	
	proxy:SetDrawEnable( 1499 , false );--魔法壁描画OFF
	proxy:SetColiEnable( 1499 , false );--魔法壁当たりOFF
	proxy:SetObjDeactivate( 1499 , true );--デアクティブ
	proxy:InvalidSfx( 2501 , true );--SFX OFF
	proxy:DeleteEvent( 1111 );--全プレイヤー分の監視消えるはず。
	
	print("OnEvent_1111_delete_wall end");
end

--■1111■イベント発動用■
function OnEvent_1111(proxy , param)
	print("OnEvent_1111 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 1111 ) == true then
		print("OnEvent_1111 end");
		return;
	end
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 1111 , 1 );
		print("OnEvent_1111 end");
		return;
	end
	
	--ダミポリへワープ
	proxy:WarpDmy( 10000 , 1499 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼1111_1▼歩きアニメ終了▼
		--proxy:OnChrAnimEnd( 1111 , 10000 , ANIMEID_WALK , "OnEvent_1111_1" , once );
		proxy:LuaCallStart( 1111 , 1 );--光の霧削除同期
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1111 , 1 );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1111 end");
end

--▲1111_1▲歩きアニメ終了▲
function OnEvent_1111_1(proxy , param)
	print("OnEvent_1111_1 begin");
	
	proxy:LuaCallStart( 1111 , 1 );--光の霧削除同期
	
	print("OnEvent_1111_1 end");
end


--------------------------------------------------------------------------------------
--■1112■ホストPCのみが通れる光の霧■
--------------------------------------------------------------------------------------
--■1112_delete_wall■魔法壁削除同期用■
function OnEvent_1112_delete_wall(proxy , param)
	print("OnEvent_1112_delete_wall begin");
	
	proxy:SetDrawEnable( 1500 , false );--魔法壁描画OFF
	proxy:SetColiEnable( 1500 , false );--魔法壁当たりOFF
	proxy:SetObjDeactivate( 1500 , true );--デアクティブ
	proxy:InvalidSfx( 2502 , true );--SFX OFF
	proxy:DeleteEvent( 1112 );--全プレイヤー分の監視消えるはず。
	
	print("OnEvent_1112_delete_wall end");
end

--■1112■イベント発動用■
function OnEvent_1112(proxy , param)
	print("OnEvent_1112 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 1112 ) == true then
		print("OnEvent_1112 end");
		return;
	end
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 1112 , 1 );
		print("OnEvent_1112 end");
		return;
	end
	
	--ダミポリへワープ
	proxy:WarpDmy( 10000 , 1500 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼1111_1▼歩きアニメ終了▼
		--proxy:OnChrAnimEnd( 1112 , 10000 , ANIMEID_WALK , "OnEvent_1112_1" , once );
		proxy:LuaCallStart( 1112 , 1 );--光の霧削除同期
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1112 , 1 );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1112 end");
end

--▲1112_1▲歩きアニメ終了▲
function OnEvent_1112_1(proxy , param)
	print("OnEvent_1112_1 begin");
	
	proxy:LuaCallStart( 1112 , 1 );--光の霧削除同期
	
	print("OnEvent_1112_1 end");
end

--[[
--------------------------------------------------------------------------------------
--■1113■ホストPCのみが通れる光の霧■
--------------------------------------------------------------------------------------
--■1113_delete_wall■魔法壁削除同期用■
function OnEvent_1113_delete_wall(proxy , param)
	print("OnEvent_1113_delete_wall begin");
	
	proxy:SetDrawEnable( 1501 , false );--魔法壁描画OFF
	proxy:SetColiEnable( 1501 , false );--魔法壁当たりOFF
	proxy:DeleteEvent( 1113 );--全プレイヤー分の監視消えるはず。
	
	print("OnEvent_1113_delete_wall end");
end

--■1113■イベント発動用■
function OnEvent_1113(proxy , param)
	print("OnEvent_1113 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 1113 ) == true then
		print("OnEvent_1113 end");
		return;
	end
	
	proxy:InvalidSfx( 2503 , true );--SFX OFF
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 1113 , 1 );
		print("OnEvent_1113 end");
		return;
	end
	
	--ダミポリへワープ
	proxy:WarpDmy( 10000 , 1501 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼1111_1▼歩きアニメ終了▼
		proxy:OnChrAnimEnd( 1113 , 10000 , ANIMEID_WALK , "OnEvent_1113_1" , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1113 , 1 );
	
	print("OnEvent_1113 end");
end

--▲1113_1▲歩きアニメ終了▲
function OnEvent_1113_1(proxy , param)
	print("OnEvent_1113_1 begin");
	
	proxy:LuaCallStart( 1113 , 1 );--光の霧削除同期
	
	print("OnEvent_1113_1 end");
end
]]

--------------------------------------------------------------------------------------
--■4875■石柱にワープ監視■
--------------------------------------------------------------------------------------
function OnEvent_4875(proxy,param)	
	print("OnEvent_4875 begin");
	
	
	--セッション中ではないか？
	if proxy:IsSession() == false then
		proxy:RepeatMessage_begin();
			--▼70_1▼選択メニューの監視▼
			proxy:OnSelectMenu(4875, "OnEvent_4875_1", 10010710, 0, 2, 1980, 2, once);			
		proxy:RepeatMessage_end();
	else
		--セッション中なんで表示
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010720, 1);
		--proxy:ShowGenDialog(10010720,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1980, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end

	print("OnEvent_4875 end");
end

--▲4875_1▲選択メニューの監視▲
function OnEvent_4875_1(proxy,param)	
	print("OnEvent_4875_1 begin");	
	
	if proxy:IsSession() == false then
		if param:IsNetMessage() == true then
			proxy:PlayAnimation(10001+param:GetPlayID(),8305);
			print("OnEvent_4875_1 end");
			return;
		end
			
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1980 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd( 4875 , 10000 , 8283 , "OnEvent_4875_2",once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(4875,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_4875_1 end");
end

--■4875_2■石柱にワープ■
function OnEvent_4875_2(proxy,param)	
	print("OnEvent_4875_2 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生
	--石柱へ戻ってきた判定のフラグを立てる
	proxy:SetEventFlag(8083, true);
	
	--完全回復要求
	proxy:RequestFullRecover();
	--古砦要石に戻る
	proxy:WarpNextStage( 1, 0, 0, 0, 1007);	
	print("OnEvent_4875_2 end");
end


--------------------------------------------------------------------------------------
--■4874■ソウル入手■
--------------------------------------------------------------------------------------
function OnEvent_4874(proxy, param)
	print("OnEvent_4874 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ 
		print("OnEvent_4874 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行
		proxy:OnKeyTime2( 4874, "OnEvent_4874_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4874 end");
end


--■4874_1■アイテム取得■
function OnEvent_4874_1(proxy, param)
	print("OnEvent_4874_1 begin");

	--アイテム取得関数--パラメータ10232参照
	proxy:GetRateItem(10231);	
	--アイテム取得関数--パラメータ10274参照
	proxy:GetRateItem(10274);	
	--アイテム取得関数--パラメータ10275参照
	proxy:GetRateItem(10275);	
	--アイテム取得関数--パラメータ10276参照
	proxy:GetRateItem(10276);	
	--アイテム取得関数--パラメータ10277参照
	proxy:GetRateItem(10277);	
	
	--アイテムを取得済み
	proxy:SetEventFlag( 4874, 1 );
	
	--宝箱シェーダーは消えません
	--proxy:TreasureDispModeChange( 1980 , false );

	--SFXが消える
	proxy:InvalidSfx( 2532 , true );--光の粒子
	--proxy:InvalidSfx( 2533 , true );
		
	--▼要石でワープ用の監視を追加▼
	proxy:OnDistanceActionAttribute( 4875 , 10000 , 1980 , "OnEvent_4875" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_4874_1 end");
end

--------------------------------------------------------------------------------------
--中ボスポリ劇再生■1108
--------------------------------------------------------------------------------------
--発動領域の中に入った
function OnEvent_1108(proxy, param)
	--終わってないか？　生きているか？
	if proxy:IsCompleteEvent(1108) == false then
		if proxy:IsAlive( 10000 ) == true then
			print("OnEvent_1108 begin");
			--ポリ劇配信
			proxy:LuaCallStart( 1108 , 1 );		
			print("OnEvent_1108 end");
		end
	end
end

--ポリ劇配信
function OnEvent_1108_1(proxy,param)
	print("OnEvent_1108_1 begin");
	--ポリ劇再生開始
	proxy:RequestRemo(30201,REMO_FLAG,1108,1);
	proxy:SetEventFlag( 1108 , 1 );--ポリ劇再生終了フラグON	
	--proxy:SetDrawEnable( 1420, false );--壁にめりこむボスOBJを消す
	print("OnEvent_1108_1 end");
end

--■1108_RemoStart■ポリ劇開始 フェードアウト完了■
function OnEvent_1108_RemoStart(proxy,param)
	print( "OnEvent_1108_RemoStart begin" );
	print( "OnEvent_1108_RemoStart end" );
end

--■1108_RemoFinish■ポリ劇再生終了後■
function OnEvent_1108_RemoFinish(proxy , param)
	print( "OnEvent_1108_RemoFinish begin" );	
	
	proxy:PlayAnimation( 1407 , 1 );--床がへこむアニメを終了
	ValidCharactor( proxy, 805 );--ボスを有効化
	
	proxy:NotNetMessage_begin();
		--▼扉が開くアニメ再生終了▼
		proxy:OnKeyTime2( 1195, "OnEvent_1195", 0, 0, 0, once );
	proxy:NotNetMessage_end();	
	
	proxy:SetEventFlag( 4880 , true);
	
	print( "OnEvent_1108_RemoFinish end" );
end


--▲1195扉が開くアニメ再生終了▲
function OnEvent_1195(proxy , param)
	print("OnEvent_1195 begin");
	
	proxy:ValidSfx( 1985 );--ボス壁用のSFXを有効化
	
	--床に落ちてる瓦礫の表示
	proxy:SetDrawEnable( 1421, true );
	proxy:SetColiEnable( 1421, true );
	
	proxy:SetEventFlag(1195, true);
	
	print("OnEvent_1195 end");
end


--------------------------------------------------------------------------------------
--ボス部屋の中に入る■1190
--------------------------------------------------------------------------------------
--■イベントがループなので、全部リピートにする↓
--■1190■中ボス部屋への扉が開く■
function OnEvent_1190(proxy,param)
	print("OnEvent_1190 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_1190 end");
		return;
	end
	
	--クライアントへ、ボス部屋阻止失敗を通知
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 1191 , 1 );--旋回アニメの同期再生
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--多重起動システムIDをタイムアウトを設定してONにする
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1190 end");
end


--旋回アニメの同期再生(IDが別)
function OnEvent_1190_1(proxy,param)
	print("OnEvent_1190_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を同期
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2889 );
		else
			proxy:LockSession();--ルームをロックします！
			--旋回アニメ再生を行い、その終了時にOnEvent_1190_2を発行する
			proxy:OnTurnCharactorEnd( 1191, 10000, 2889, "OnEvent_1190_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();	
	
	print("OnEvent_1190_1 end");
end

--旋回アニメの同期再生終了後
function OnEvent_1190_2(proxy,param)
	print("OnEvent_1190_2 begin");
	
	--同期用歩きアニメ再生
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1191, 10000, ANIMEID_WALK, "OnEvent_1190_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
		
	print("OnEvent_1190_2 end");
end

--歩きアニメの同期再生終了後
function OnEvent_1190_3(proxy,param)
	print("OnEvent_1190_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ
	if proxy:IsCompleteEvent( 1190 ) == false then
		proxy:LuaCallStart( 1191 , 5 );--2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知
		Lua_MultiDoping(proxy,805);--マルチプレイドーピング
		proxy:LuaCallStart( 1191 , 6 );--フラグセット(同期用)
	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない)
	if proxy:IsClient() == false then
		proxy:ResetThink( 805 );
	end
	
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE,false);	
	print("OnEvent_1190_3 end");
end


--■1190 2回目以降にボス部屋に入るためのイベント配信用
function OnEvent_1190_GO_TO_IN(proxy, param)
	print("OnEvent_1190_GO_TO_IN begin");	
	proxy:NotNetMessage_begin();
		--▼593▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_1190
		proxy:OnPlayerActionInRegion( 1191, 2893, "OnEvent_1190", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	print("OnEvent_1190_GO_TO_IN end");
end


--■1190 フラグセット(同期用)
function OnEvent_1190_flag_set(proxy, param)
	print("OnEvent_1190_flag_set begin");		
	proxy:SetEventFlag( 1190 , 1 );
	proxy:DeleteEvent( 1190 );
	print("OnEvent_1190_flag_set end");
end

--------------------------------------------------------------------------------------
--中ボス死亡■4895
--------------------------------------------------------------------------------------
function OnEvent_4895(proxy, param)
	print("OnEvent_4895begin");
	
	proxy:NotNetMessage_begin();
		
		--▼4895_1▼1秒経過▼
		proxy:OnKeyTime2( 4895, "OnEvent_4895_1", 0, 0, 0, once);
		--▼4895_2▼2秒経過▼
		proxy:OnKeyTime2( 4895, "OnEvent_4895_2", 0, 0, 1, once);
		
		--マルチ解散監視
		proxy:OnRegistFunc( 4895 ,"Check_4895_PT","OnEvent_4895_PT",0,once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 4895, 1 );--ボスの死亡記録用
	proxy:SetEventFlag( 4870, 1 );--新仕様のフラグも立てる
	
	print("OnEvent_4895 end");
end


----------------------------------------------------------------------------

--▲4895_1▲中ボスの死亡:中ボス死亡後1秒▲
function OnEvent_4895_1(proxy, param)
	print("OnEvent_4895_1 begin");
	
	--ボスを倒した数を更新(数によってフラグを立てる)
	GetBossFlagCount( proxy, param );
	
--アイテム入手関連-------
	
	--ホストプレイヤーのみアイテム入手イベントに使用
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

	--要石OBJ有効化
	proxy:SetDrawEnable( 1980 , true );--描画
	proxy:SetColiEnable( 1980 , true );--アタリ
	--要石OBJ2有効化
	proxy:SetDrawEnable( 1977 , true );--描画
	proxy:SetColiEnable( 1977 , true );--アタリ
	
	--▼(ソウル)アイテム取得用イベント監視追加▼
	if proxy:IsCompleteEvent( 4874 ) == false then
		proxy:ValidSfx( 2532 );--SFX 有効化
		proxy:ValidSfx( 2533 );--SFX 有効化
		proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--光らせる
		proxy:OnDistanceActionAttribute( 4874 , 10000 , 1980 , "OnEvent_4874" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end

	--▼トロフィー取得判定▼
	Lua_RequestUnlockTrophy(proxy, 31);
	
------------------------

	
	--[[中ボス部屋前の移動処理イベントを削除
	proxy:DeleteEvent( 1542 );--一人目が入るとき用
	proxy:DeleteEvent( 1543 );--二人目以降が入るとき用
	proxy:DeleteEvent( 4999 );--ボス戦闘開始用]]
	
	print("OnEvent_4895_1 end");
end


--▲4895_2▲中ボスの死亡:中ボス死亡後1秒▲
function OnEvent_4895_2(proxy, param)
	print("OnEvent_4895_2 begin");

	--ボス戦用のBGM停止	
	proxy:StopPointSE( 2 );		
	
	--ブロッククリア処理へ
	--proxy:LuaCallStart( 4040, 1 );
	--新ブロッククリア処理へ
	proxy:CustomLuaCallStart( 4050, 805);
	--結晶トカゲリセット
	ResetTokage(proxy);
	
	--[[セッション解散時の魔法壁切り替え処理はグローバル?]]
	
	print("OnEvent_4895_2 end");
end

--マルチ解散監視
function Check_4895_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--マルチじゃない
function OnEvent_4895_PT(proxy,param)
	print("OnEvent_4895_PT begin");
	proxy:PlayAnimation( 1408 , 1 );--扉のアニメを流す
	
	--中ボス部屋の前後の魔法壁が消える(全プレイヤー)
	proxy:SetColiEnable( 1997 , false );
	proxy:SetColiEnable( 1993 , false );
	
	proxy:SetDrawEnable( 1997 , false );
	proxy:SetDrawEnable( 1993 , false );
	
	proxy:InvalidSfx(1989,true);
	proxy:InvalidSfx(1985,true);

	--中ボス部屋前の移動処理イベントを削除
	proxy:DeleteEvent( 1190 );--一人目が入るとき用
	proxy:DeleteEvent( 1191 );--二人目以降が入るとき用
	proxy:DeleteEvent( 1108 );--ボス前ポリ劇用
	proxy:DeleteEvent( 1109 );--ボス戦闘開始用
	print("OnEvent_4895_PT end");
end


--ボス部屋BGM領域に入り込んだ
function OnEvent_4897(proxy,param)	
	--ボスポリ劇が終わってなかったら
	if proxy:IsCompleteEvent( 4880 ) == false then
		return;
	end
	print("OnEvent_4897 begin");
	--ボス戦用BGM再生開始	
	proxy:PlayPointSE( 2500, SOUND_TYPE_M, 30200000, 2 );
	proxy:EnableLogic(805,true);
	
	proxy:SetEventFlag(4897, true);
	
	--ボスゲージ表示
	proxy:SetBossGauge( 805 , 0 ,6020 );
	
	--監視の削除
	proxy:DeleteEvent( 4897 );
	
	print("OnEvent_4897 end");	
end

--[[
--------------------------------------------------------------------------------------
--鷹の攻撃■1119
--------------------------------------------------------------------------------------
--■1119■鷹の攻撃■
function Check_1119(proxy,param)
	local region = { 2420 };
	local tblnum = table.getn(region);
	local index =0;
	local isIn = false;
	
	for index = 1, tblnum, 1 do
		if proxy:IsRegionIn(10000,region[index]) == true then
			isIn = true;
			break;
		end
	end
	
	--領域に入ってない時のみ処理
	if isIn == false then
		proxy:SetInsideBattleArea(346,0);
	end
	
	return isIn;
end

--領域に入っている
function OnEvent_1119(proxy,param)
	proxy:SetInsideBattleArea(346,1);
end

--鷹が死んだ
function OnEvent_1119_1(proxy,param)
	print("OnEvent_1119_1 begin");
	proxy:DeleteEvent( 1119 );
	print("OnEvent_1119_1 end");
end
]]

--[[
--------------------------------------------------------------------------------------
--鷹の攻撃■1120
--------------------------------------------------------------------------------------
--■1120■鷹の攻撃■
function Check_1120(proxy,param)
	local region = { 2421 };
	local tblnum = table.getn(region);
	local index =0;
	local isIn = false;
	
	for index = 1, tblnum, 1 do
		if proxy:IsRegionIn(10000,region[index]) == true then
			isIn = true;
			break;
		end
	end
	
	--領域に入ってない時のみ処理
	if isIn == false then
		proxy:SetInsideBattleArea(347,0);
	end
	
	return isIn;
end

--領域に入っている
function OnEvent_1120(proxy,param)
	proxy:SetInsideBattleArea(347,1);
end

--鷹が死んだ
function OnEvent_1120_1(proxy,param)
	print("OnEvent_1120_1 begin");
	proxy:DeleteEvent( 1120 );
	print("OnEvent_1120_1 end");
end
]]


--------------------------------------------------------------------------------------
--影人ポリ劇再生■
--------------------------------------------------------------------------------------
function OnEvent_1122(proxy,param)
	print("OnEvent_1122 begin");
	
	--スイッチが沈むアニメを流す
	proxy:PlayAnimation( 1400, 1 );
	
	proxy:NotNetMessage_begin();
		--OBJが読み込めているかどうか？
		if proxy:IsReady_Obj( 1400 ) == true then
			proxy:OnObjAnimEnd( 1122, 1400, 1, "OnEvent_1122_1", once );
		else
			proxy:OnKeyTime2( 1122 , "OnEvent_1122_1",5.0,0,0,once);
		end
	proxy:NotNetMessage_end();	
	print("OnEvent_1122 end");
end

--時間経過orOBJのアニメ待ち
function OnEvent_1122_1(proxy,param)
	print("OnEvent_1122_1 begin");	
	--扉を開けるアニメを流す
	--proxy:PlayAnimation( 1401, 1 );	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1122, "OnEvent_1122_2", 0.5, 0, 2, once );
	proxy:NotNetMessage_end();	
	print("OnEvent_1122_1 end");
end

--ポリ劇配信用
function OnEvent_1122_2(proxy,param)
	if proxy:IsCompleteEvent(1122) == false then
		print("OnEvent_1122_2 begin");
		proxy:LuaCallStart( 1122 , 1 );
		print("OnEvent_1122_2 end");
	end
end

--ポリ劇再生を受け取った
function OnEvent_1122_3(proxy,param)
	if proxy:IsCompleteEvent(1122) == false then
		print("OnEvent_1122_3 begin");	
		proxy:RequestRemo(30200,REMO_FLAG,1122,1);--ポリ劇要求	
		proxy:SetEventFlag( 1122 ,true );
		print("OnEvent_1122_3 end");
	end
end

function OnEvent_1122_RemoStart(proxy,param)
	print("OnEvent_1122_RemoStart begin");
	print("OnEvent_1122_RemoStart end");
end

function OnEvent_1122_RemoFinish(proxy,param)
	print("OnEvent_1122_RemoFinish begin");
	
	--扉が開くアニメを終了させる
	proxy:EndAnimation( 1401, 1 );
	
	--無効化していた影人有効化
	ValidCharactor(proxy, 200);
	ValidCharactor(proxy, 201);
	ValidCharactor(proxy, 202);
	ValidCharactor(proxy, 203);
	print("OnEvent_1122_RemoFinish end");
end


--------------------------------------------------------------------------------------
--影人行進開始■1123
--------------------------------------------------------------------------------------
--領域に入った
function OnEvent_1123(proxy,param)
	print("OnEvent_1123 begin");
	
	--生存もしくはグレイの人にだけ設定
	if proxy:IsClient() == false then
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnKeyTime2(1123,"OnEvent_1123_1",START_MARCH_WAIT,0,0,once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	
	print("OnEvent_1123 end");
end

--START_MARCH_WAIT秒後影人行進
function OnEvent_1123_1(proxy,param)
	print("OnEvent_1123_1 begin");
	--影人Aスタート
	proxy:LuaCallStart(1125,0);
	--影人Bスタート
	proxy:LuaCallStart(1127,0);
	--影人Cスタート
	proxy:LuaCallStart(1129,0);
	--影人Dスタート
	proxy:LuaCallStart(1132,0);
	--影人Eスタート
	proxy:LuaCallStart(1135,0);
	--影人Fスタート
	proxy:LuaCallStart(1138,0);
	print("OnEvent_1123_1 end");
end


--------------------------------------------------------------------------------------
--影人通常■1132
--------------------------------------------------------------------------------------
--領域に入った
function OnEvent_1132(proxy,param)
	print("OnEvent_1132 begin");
	local eneid = 349;
	for eneid = 349, 354, 1 do
		if proxy:IsAlive(eneid) == true then
			proxy:ResetThink(eneid);
		end
	end
	print("OnEvent_1132 end");
end



--------------------------------------------------------------------------------------
--影人A■1125・1126
--------------------------------------------------------------------------------------
--ポイント１へ向かう
function OnEvent_1125(proxy,param)
	print("OnEvent_1125 begin");
	if proxy:IsAlive(349) == true then
		LuaFunc_ForceOmission(proxy,349);
		proxy:ResetThink( 349 );
		MoveRegion(proxy, 349, 2505, -1,0.0,true);
		proxy:OnRegionIn(1125,349,2505,"OnEvent_1125_1",once);
	end
	print("OnEvent_1125 end");
end

--ポイント到着
function OnEvent_1125_1(proxy,param)
	print("OnEvent_1125_1 begin");
	proxy:LuaCallStart(1126,0);
	print("OnEvent_1125_1 end");
end

--ポイント２へ向かう
function OnEvent_1126(proxy,param)
	print("OnEvent_1126 beign");
	if proxy:IsAlive(349) == true then
		LuaFunc_NormalOmission(proxy,349);
		proxy:ResetThink( 349 );
		MoveRegion(proxy, 349, 2506, -1,0.0,true);		
	end
	print("OnEvent_1126 end");
end


--------------------------------------------------------------------------------------
--影人B■1127・1128
--------------------------------------------------------------------------------------
--ポイント１へ向かう
function OnEvent_1127(proxy,param)
	print("OnEvent_1127 begin");
	if proxy:IsAlive(350) == true then
		LuaFunc_ForceOmission(proxy,350);
		proxy:ResetThink( 350 );
		MoveRegion(proxy, 350, 2507, -1,0.0,true);
		proxy:OnRegionIn(1127,350,2507,"OnEvent_1127_1",once);
	end
	print("OnEvent_1127 end");
end

--ポイント到着
function OnEvent_1127_1(proxy,param)
	print("OnEvent_1127_1 begin");
	proxy:LuaCallStart(1128,0);
	print("OnEvent_1127_1 end");
end

--ポイント２へ向かう
function OnEvent_1128(proxy,param)
	print("OnEvent_1128 beign");
	if proxy:IsAlive(350) == true then
		LuaFunc_NormalOmission(proxy,350);
		proxy:ResetThink( 350 );
		MoveRegion(proxy, 350, 2508, -1,0.0,true);		
	end
	print("OnEvent_1128 end");
end


--------------------------------------------------------------------------------------
--影人C■1129・1130・1131
--------------------------------------------------------------------------------------
--ポイント１へ向かう
function OnEvent_1129(proxy,param)
	print("OnEvent_1129 begin");
	if proxy:IsAlive(351) == true then
		LuaFunc_ForceOmission(proxy,351);
		proxy:ResetThink( 351 );
		MoveRegion(proxy, 351, 2509, -1,0.0,true);
		proxy:OnRegionIn(1129,351,2509,"OnEvent_1129_1",once);
	end
	print("OnEvent_1129 end");
end

--ポイント１到着
function OnEvent_1129_1(proxy,param)
	print("OnEvent_1129_1 begin");
	proxy:LuaCallStart(1130,0);
	print("OnEvent_1129_1 end");
end

--ポイント２へ向かう
function OnEvent_1130(proxy,param)
	print("OnEvent_1130 beign");
	if proxy:IsAlive(351) == true then
		LuaFunc_ForceOmission(proxy,351);
		proxy:ResetThink( 351 );
		MoveRegion(proxy, 351, 2505, -1,0.0,true);
		proxy:OnRegionIn(1130,351,2505,"OnEvent_1130_1",once);
	end
	print("OnEvent_1130 end");
end

--ポイント２到着
function OnEvent_1130_1(proxy,param)
	print("OnEvent_1130_1 begin");
	proxy:LuaCallStart(1131,0);
	print("OnEvent_1130_1 end");
end

--ポイント３へ向かう
function OnEvent_1131(proxy,param)
	print("OnEvent_1131 beign");
	if proxy:IsAlive(351) == true then
		LuaFunc_NormalOmission(proxy,351);
		proxy:ResetThink( 351 );
		MoveRegion(proxy, 351, 2506, -1,0.0,true);		
	end
	print("OnEvent_1131 end");
end


--------------------------------------------------------------------------------------
--影人D■1132・1133・1134
--------------------------------------------------------------------------------------
--ポイント１へ向かう
function OnEvent_1132(proxy,param)
	print("OnEvent_1132 begin");
	if proxy:IsAlive(352) == true then
		LuaFunc_ForceOmission(proxy,352);
		proxy:ResetThink( 352 );
		MoveRegion(proxy, 352, 2509, -1,0.0,true);
		proxy:OnRegionIn(1132,352,2509,"OnEvent_1132_1",once);
	end
	print("OnEvent_1132 end");
end

--ポイント１到着
function OnEvent_1132_1(proxy,param)
	print("OnEvent_1132_1 begin");
	proxy:LuaCallStart(1133,0);
	print("OnEvent_1132_1 end");
end

--ポイント２へ向かう
function OnEvent_1133(proxy,param)
	print("OnEvent_1133 beign");
	if proxy:IsAlive(352) == true then
		LuaFunc_ForceOmission(proxy,352);
		proxy:ResetThink( 352 );
		MoveRegion(proxy, 352, 2507, -1,0.0,true);
		proxy:OnRegionIn(1133,352,2507,"OnEvent_1133_1",once);
	end
	print("OnEvent_1133 end");
end

--ポイント２到着
function OnEvent_1133_1(proxy,param)
	print("OnEvent_1133_1 begin");
	proxy:LuaCallStart(1134,0);
	print("OnEvent_1133_1 end");
end

--ポイント３へ向かう
function OnEvent_1134(proxy,param)
	print("OnEvent_1134 beign");
	if proxy:IsAlive(352) == true then
		LuaFunc_NormalOmission(proxy,352);
		proxy:ResetThink( 352 );
		MoveRegion(proxy, 352, 2508, -1,0.0,true);		
	end
	print("OnEvent_1134 end");
end


--------------------------------------------------------------------------------------
--影人E■1135・1136・1137
--------------------------------------------------------------------------------------
--ポイント１へ向かう
function OnEvent_1135(proxy,param)
	print("OnEvent_1135 begin");
	if proxy:IsAlive(353) == true then
		LuaFunc_ForceOmission(proxy,353);
		proxy:ResetThink( 353 );
		MoveRegion(proxy, 353, 2509, -1,0.0,true);
		proxy:OnRegionIn(1135,353,2509,"OnEvent_1135_1",once);
	end
	print("OnEvent_1135 end");
end

--ポイント１到着
function OnEvent_1135_1(proxy,param)
	print("OnEvent_1135_1 begin");
	proxy:LuaCallStart(1136,0);
	print("OnEvent_1135_1 end");
end

--ポイント２へ向かう
function OnEvent_1136(proxy,param)
	print("OnEvent_1136 beign");
	if proxy:IsAlive(353) == true then
		LuaFunc_ForceOmission(proxy,353);
		proxy:ResetThink( 353 );
		MoveRegion(proxy, 353, 2505, -1,0.0,true);
		proxy:OnRegionIn(1136,353,2505,"OnEvent_1136_1",once);
	end
	print("OnEvent_1136 end");
end

--ポイント２到着
function OnEvent_1136_1(proxy,param)
	print("OnEvent_1136_1 begin");
	proxy:LuaCallStart(1137,0);
	print("OnEvent_1136_1 end");
end

--ポイント３へ向かう
function OnEvent_1137(proxy,param)
	print("OnEvent_1137 beign");
	if proxy:IsAlive(353) == true then
		LuaFunc_NormalOmission(proxy,353);
		proxy:ResetThink( 353 );
		MoveRegion(proxy, 353, 2506, -1,0.0,true);		
	end
	print("OnEvent_1137 end");
end


--------------------------------------------------------------------------------------
--影人F■1138・1139・1140
--------------------------------------------------------------------------------------
--ポイント１へ向かう
function OnEvent_1138(proxy,param)
	print("OnEvent_1138 begin");
	if proxy:IsAlive(354) == true then
		LuaFunc_ForceOmission(proxy,354);
		proxy:ResetThink( 354 );
		MoveRegion(proxy, 354, 2509, -1,0.0,true);
		proxy:OnRegionIn(1138,354,2509,"OnEvent_1138_1",once);
	end
	print("OnEvent_1138 end");
end

--ポイント１到着
function OnEvent_1138_1(proxy,param)
	print("OnEvent_1138_1 begin");
	proxy:LuaCallStart(1139,0);
	print("OnEvent_1138_1 end");
end

--ポイント２へ向かう
function OnEvent_1139(proxy,param)
	print("OnEvent_1139 beign");
	if proxy:IsAlive(354) == true then
		LuaFunc_ForceOmission(proxy,354);
		proxy:ResetThink( 354 );
		MoveRegion(proxy, 354, 2507, -1,0.0,true);
		proxy:OnRegionIn(1139,354,2507,"OnEvent_1139_1",once);
	end
	print("OnEvent_1139 end");
end

--ポイント２到着
function OnEvent_1139_1(proxy,param)
	print("OnEvent_1139_1 begin");
	proxy:LuaCallStart(1140,0);
	print("OnEvent_1139_1 end");
end

--ポイント３へ向かう
function OnEvent_1140(proxy,param)
	print("OnEvent_1140 beign");
	if proxy:IsAlive(354) == true then
		LuaFunc_NormalOmission(proxy,354);
		proxy:ResetThink( 354 );
		MoveRegion(proxy, 354, 2508, -1,0.0,true);		
	end
	print("OnEvent_1140 end");
end






--------------------------------------------------------------------------------------
--ゴーストロジックON■1143
--------------------------------------------------------------------------------------
function OnEvent_1143(proxy,param)
	print("OnEvent_1143 begin");
	proxy:EnableLogic(355,true);
	proxy:SetEventFlag(1143, true);
	print("OnEvent_1143 end");
end


--------------------------------------------------------------------------------------
--魔法使いのポイント移動1■1151
--------------------------------------------------------------------------------------
--プレイヤーが範囲内に入った
function OnEvent_1151(proxy,param)
	print("OnEvent_1151 begin");
	proxy:SetEventFlag( 1182, 1 );
	proxy:LuaCallStart(1151,1);
	print("OnEvent_1151 end");
end

--魔法使いが逃げるイベント
function OnEvent_1151_ToMove(proxy,param)
	print("OnEvent_1151_ToMove begin");	
	proxy:EnableGeneratorSystem(2533,false);--ジェネレータOFF		
	
	proxy:ResetThink(356);
	proxy:DisableInterupt(356,true);
	MoveRegion2(proxy, 356, 2522, -1,0.0,false);
	proxy:ChangeInitPosAng(356,2522);
	proxy:OnRegionIn(1151,356,2522,"OnEvent_1151_EndMove",once);
	print("OnEvent_1151_ToMove end");
end

--魔法使いが逃げ切った
function OnEvent_1151_EndMove(proxy,param)
	print("OnEvent_1151_EndMove begin");	
	proxy:LuaCallStart(1151,2);
	print("OnEvent_1151_EndMove end");
end

--魔法使いの記憶初期位置変更と次のエリア監視追加、フラグON
function OnEvent_1151_flag(proxy,param)
	print("OnEvent_1151_flag begin");
	proxy:DisableInterupt(356,false);
	proxy:SetEventFlag( 1182, 0 );
	proxy:SetEventFlag(1151,true);
	proxy:ChangeInitPosAng(356,2522);
	proxy:OnRegionIn(1152,10000,2516,"OnEvent_1152",once);
	
	--魔法使いが生きてる事
	if proxy:IsAlive(356) == true then		
		proxy:EnableGeneratorSystem(2534,true);--ジェネレータON
		proxy:PlayAnimation(356,3005);
		--配信しない
		proxy:NotNetMessage_begin();
			--再登録を可能にする
			proxy:RepeatMessage_begin();
				proxy:OnRegistFunc( 1182,"Check_1182","OnEvent_1182",1,once);		
			proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	print("OnEvent_1151_flag end");
end


--------------------------------------------------------------------------------------
--魔法使いのポイント移動2■1152
--------------------------------------------------------------------------------------
--プレイヤーが範囲内に入った
function OnEvent_1152(proxy,param)
	print("OnEvent_1152 begin");
	proxy:SetEventFlag( 1182, 1 );
	proxy:LuaCallStart(1152,1);
	print("OnEvent_1152 end");
end

--魔法使いが逃げるイベント
function OnEvent_1152_ToMove(proxy,param)
	print("OnEvent_1152_ToMove begin");		
	proxy:EnableGeneratorSystem(2534,false);--ジェネレータOFF		
	
	proxy:DisableInterupt(356,true);
	proxy:ResetThink(356);
	MoveRegion2(proxy, 356, 2523, -1,0.0,false);
	proxy:ChangeInitPosAng(356,2523);
	proxy:OnRegionIn(1152,356,2523,"OnEvent_1152_EndMove",once);
	print("OnEvent_1152_ToMove end");
end

--魔法使いが逃げ切った
function OnEvent_1152_EndMove(proxy,param)
	print("OnEvent_1152_EndMove begin");
	proxy:LuaCallStart(1152,2);	
	print("OnEvent_1152_EndMove end");
end

--魔法使いの記憶初期位置変更と次のエリア監視追加、フラグON
function OnEvent_1152_flag(proxy,param)
	print("OnEvent_1152_flag begin");
	proxy:DisableInterupt(356,false);
	proxy:SetEventFlag( 1182, 0 );
	proxy:SetEventFlag(1152,true);
	proxy:ChangeInitPosAng(356,2523);
	proxy:OnRegionIn(1153,10000,2517,"OnEvent_1153",once);
	
	--魔法使いが生きてる事
	if proxy:IsAlive(356) == true then		
		proxy:EnableGeneratorSystem(2535,true);--ジェネレータON
		proxy:PlayAnimation(356,3005);
		--配信しない
		proxy:NotNetMessage_begin();
			--再登録を可能にする
			proxy:RepeatMessage_begin();
				proxy:OnRegistFunc( 1182,"Check_1182","OnEvent_1182",1,once);		
			proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	print("OnEvent_1152_flag end");
end


--------------------------------------------------------------------------------------
--魔法使いのポイント移動3■1153
--------------------------------------------------------------------------------------
--プレイヤーが範囲内に入った
function OnEvent_1153(proxy,param)
	print("OnEvent_1153 begin");
	proxy:SetEventFlag( 1182, 1 );
	proxy:LuaCallStart(1153,1);
	print("OnEvent_1153 end");
end

--魔法使いが逃げるイベント
function OnEvent_1153_ToMove(proxy,param)
	print("OnEvent_1153_ToMove begin");
	proxy:EnableGeneratorSystem(2535,false);--ジェネレータOFF
	proxy:DisableInterupt(356,true);
	proxy:ResetThink(356);
	MoveRegion2(proxy, 356, 2524, -1,0.0,false);
	proxy:ChangeInitPosAng(356,2524);
	proxy:OnRegionIn(1153,356,2524,"OnEvent_1153_EndMove",once);
	print("OnEvent_1153_ToMove end");
end

--魔法使いが逃げ切った
function OnEvent_1153_EndMove(proxy,param)
	print("OnEvent_1153_EndMove begin");
	proxy:LuaCallStart(1153,2);	
	print("OnEvent_1153_EndMove end");
end

--魔法使いの記憶初期位置変更と次のエリア監視追加、フラグON
function OnEvent_1153_flag(proxy,param)
	print("OnEvent_1153_flag begin");
	proxy:DisableInterupt(356,false);
	proxy:SetEventFlag( 1182, 0 );
	proxy:SetEventFlag(1153,true);
	proxy:ChangeInitPosAng(356,2524);
	proxy:OnRegionIn(1154,10000,2518,"OnEvent_1154",once);
	
	--魔法使いが生きてる事
	if proxy:IsAlive(356) == true then		
		proxy:EnableGeneratorSystem(2536,true);--ジェネレータON
		proxy:PlayAnimation(356,3005);
		--配信しない
		proxy:NotNetMessage_begin();
			--再登録を可能にする
			proxy:RepeatMessage_begin();
				proxy:OnRegistFunc( 1182,"Check_1182","OnEvent_1182",1,once);		
			proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	print("OnEvent_1153_flag end");
end



--------------------------------------------------------------------------------------
--魔法使いのポイント移動4■1154
--------------------------------------------------------------------------------------
--プレイヤーが範囲内に入った
function OnEvent_1154(proxy,param)
	print("OnEvent_1154 begin");
	proxy:SetEventFlag( 1182, 1 );
	proxy:LuaCallStart(1154,1);
	print("OnEvent_1154 end");
end

--魔法使いが逃げるイベント
function OnEvent_1154_ToMove(proxy,param)
	print("OnEvent_1154_ToMove begin");	
	proxy:EnableGeneratorSystem(2536,false);--ジェネレータOFF
	proxy:DisableInterupt(356,true);
	proxy:ResetThink(356);
	MoveRegion2(proxy, 356, 2525, -1,0.0,false);
	proxy:ChangeInitPosAng(356,2525);
	proxy:OnRegionIn(1154,356,2525,"OnEvent_1154_EndMove",once);
	print("OnEvent_1154_ToMove end");
end

--魔法使いが逃げ切った
function OnEvent_1154_EndMove(proxy,param)
	print("OnEvent_1154_EndMove begin");
	proxy:LuaCallStart(1154,2);	
	print("OnEvent_1154_EndMove end");
end

--魔法使いの記憶初期位置変更と次のエリア監視追加、フラグON
function OnEvent_1154_flag(proxy,param)
	print("OnEvent_1154_flag begin");
	proxy:DisableInterupt(356,false);
	proxy:SetEventFlag( 1182, 0 );
	proxy:SetEventFlag(1154,true);
	proxy:ChangeInitPosAng(356,2525);
	proxy:OnRegionIn(1155,10000,2519,"OnEvent_1155",once);
	
	--魔法使いが生きてる事
	if proxy:IsAlive(356) == true then		
		proxy:EnableGeneratorSystem(2537,true);--ジェネレータON
		proxy:PlayAnimation(356,3005);
		--配信しない
		proxy:NotNetMessage_begin();
			--再登録を可能にする
			proxy:RepeatMessage_begin();
				proxy:OnRegistFunc( 1182,"Check_1182","OnEvent_1182",1,once);		
			proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	print("OnEvent_1154_flag end");
end


--------------------------------------------------------------------------------------
--魔法使いのポイント移動5■1155
--------------------------------------------------------------------------------------
--プレイヤーが範囲内に入った
function OnEvent_1155(proxy,param)
	print("OnEvent_1155 begin");
	proxy:SetEventFlag( 1182, 1 );
	proxy:LuaCallStart(1155,1);
	print("OnEvent_1155 end");
end

--魔法使いが逃げるイベント
function OnEvent_1155_ToMove(proxy,param)
	print("OnEvent_1155_ToMove begin");
	proxy:EnableGeneratorSystem(2537,false);--ジェネレータOFF
	proxy:DisableInterupt(356,true);
	proxy:ResetThink(356);
	MoveRegion2(proxy, 356, 2526, -1,0.0,false);
	proxy:ChangeInitPosAng(356,2526);
	proxy:OnRegionIn(1155,356,2526,"OnEvent_1155_EndMove",once);
	print("OnEvent_1155_ToMove end");
end

--魔法使いが逃げ切った
function OnEvent_1155_EndMove(proxy,param)
	print("OnEvent_1155_EndMove begin");
	proxy:LuaCallStart(1155,2);	
	print("OnEvent_1155_EndMove end");
end

--魔法使いの記憶初期位置変更と次のエリア監視追加、フラグON
function OnEvent_1155_flag(proxy,param)
	print("OnEvent_1155_flag begin");
	proxy:DisableInterupt(356,false);
	proxy:SetEventFlag( 1182, 0 );
	proxy:SetEventFlag(1155,true);
	proxy:ChangeInitPosAng(356,2526);
	proxy:OnRegionIn(1156,10000,2520,"OnEvent_1156",once);
	
	--魔法使いが生きてる事
	if proxy:IsAlive(356) == true then		
		proxy:EnableGeneratorSystem(2538,true);--ジェネレータON
		proxy:PlayAnimation(356,3005);
		--配信しない
		proxy:NotNetMessage_begin();
			--再登録を可能にする
			proxy:RepeatMessage_begin();
				proxy:OnRegistFunc( 1182,"Check_1182","OnEvent_1182",1,once);
			proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	
	print("OnEvent_1155_flag end");
end


--------------------------------------------------------------------------------------
--魔法使いのポイント移動6■1156
--------------------------------------------------------------------------------------
--プレイヤーが範囲内に入った
function OnEvent_1156(proxy,param)
	print("OnEvent_1156 begin");
	proxy:SetEventFlag( 1182, 1 );
	proxy:LuaCallStart(1156,1);
	print("OnEvent_1156 end");
end

--魔法使いが逃げるイベント
function OnEvent_1156_ToMove(proxy,param)
	print("OnEvent_1156_ToMove begin");	
	proxy:EnableGeneratorSystem(2538,false);--ジェネレータOFF
	proxy:DisableInterupt(356,true);
	proxy:ResetThink(356);
	MoveRegion2(proxy, 356, 2527, -1,0.0,false);
	proxy:ChangeInitPosAng(356,2527);
	proxy:OnRegionIn(1156,356,2527,"OnEvent_1156_EndMove",once);
	print("OnEvent_1156_ToMove end");
end

--魔法使いが逃げ切った
function OnEvent_1156_EndMove(proxy,param)
	print("OnEvent_1156_EndMove begin");
	proxy:LuaCallStart(1156,2);	
	print("OnEvent_1156_EndMove end");
end

--魔法使いの記憶初期位置変更と次のエリア監視追加、フラグON
function OnEvent_1156_flag(proxy,param)
	print("OnEvent_1156_flag begin");
	proxy:DisableInterupt(356,false);
	proxy:SetEventFlag( 1182, 0 );
	proxy:SetEventFlag(1156,true);
	proxy:ChangeInitPosAng(356,2527);
	
	--魔法使いが生きてる事
	if proxy:IsAlive(356) == true then
		proxy:EnableGeneratorSystem(2539,true);--ジェネレータON
		proxy:PlayAnimation(356,3005);
		--配信しない
		proxy:NotNetMessage_begin();
			--再登録を可能にする
			proxy:RepeatMessage_begin();
				proxy:OnRegistFunc( 1182,"Check_1182","OnEvent_1182",1,once);		
			proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	
	print("OnEvent_1156_flag end");
end


--------------------------------------------------------------------------------------
--スキル屋を助ける■1250
--------------------------------------------------------------------------------------
function OnEvent_1250(proxy,param)
	if proxy:IsCompleteEvent( URUBAIN_STATE_ANGRY ) == false then
		print("OnEvent_1250 begin");
		proxy:SetEventFlag(1250,true);
		if 	proxy:IsCompleteEvent( URUBAIN_STATE_HELP ) == true and
			proxy:IsCompleteEvent( 1064 ) == true then
			SetNpcStateFlag(proxy,param,urubain_flag_list,URUBAIN_STATE_THANKS);			
		end		
		print("OnEvent_1250 end");
	else
		print("OnEvent_1250 URUBAIN_STATE_ANGRY");
	end
end


--------------------------------------------------------------------------------------
--ウルベイン感謝■1157
--------------------------------------------------------------------------------------
function OnEvent_1157(proxy,param)
	print("OnEvent_1157 begin");
	if proxy:IsCompleteEvent( URUBAIN_STATE_HELP ) == true then
		SetNpcStateFlag(proxy,param,urubain_flag_list,URUBAIN_STATE_THANKS);
		proxy:SetEventFlag( 1157 , true );
	end
	print("OnEvent_1157 end");
end


--------------------------------------------------------------------------------------
--スキル屋に一定ダメージ■1158
--------------------------------------------------------------------------------------
function OnEvent_1158(proxy,param)
	print("OnEvent_1158 begin");
	proxy:SetEventFlag(1158,true);
	
	proxy:EnableLogic( 635, true );
	SetNpcStateFlag(proxy,param,urubain_flag_list,URUBAIN_STATE_ANGRY);
	
	proxy:SetTeamType( 635, TEAM_TYPE_AngryFriend );
	print("OnEvent_1158 end");
end


--------------------------------------------------------------------------------------
--スキル屋の死亡■1159
--------------------------------------------------------------------------------------
function OnEvent_1159(proxy,param)
	print("OnEvent_1159 begin");
	proxy:SetEventFlag(1159,true);
	SetNpcStateFlag(proxy,param,urubain_flag_list,URUBAIN_STATE_DEAD);
	print("OnEvent_1159 end");
end

--------------------------------------------------------------------------------------
--バッチ初期処理■1192
--------------------------------------------------------------------------------------
--■1192■バッチ初期処理■
function OnEvent_1192(proxy, param)
	print("OnEvent_1192 begin");

	--proxy:EnableLogic( 636 , true );--ロジックON
	SetNpcStateFlag( proxy, param, batti_flag_list, BATTI_PUSHING );--状態を「突き落としたい」にかえる
	ValidCharactor( proxy, 636 );
	
	proxy:SetEventFlag( 1192, true );

	print("OnEvent_1192 end");
end
--------------------------------------------------------------------------------------
--バッチがアイテムをくれる■1193
--------------------------------------------------------------------------------------
--■1193■パッチがアイテムをくれる(会話からの呼び出し)
function OnEvent_1193(proxy, param)
	print("OnEvent_1193 begin");
	proxy:GetRateItem(16290);
	proxy:SetEventFlag(1193, true);
	print("OnEvent_1193 end");
end

--------------------------------------------------------------------------------------
--バッチが突き落とす■1165
--------------------------------------------------------------------------------------
function OnEvent_1165(proxy,param)
	if	proxy:IsRegionIn( 636, 2531 ) == true then--領域内に居る ならば
		if proxy:IsCompleteEvent( BATTI_ANGRY ) == false and--敵対していない　かつ
		   proxy:IsCompleteEvent( BATTI_PUSHING ) == true then--突き落としたいならば
			print("OnEvent_1165 begin");
			--ポリ劇を再生
			proxy:LuaCallStart(1165, 1);
			
			--[[ポリ劇再生開始
			if param:IsNetMessage() == true then
				--発動者出演ポリ劇
				proxy:RequestRemoPlus(30203,REMO_FLAG,1165,1, param:GetPlayID()+10001);
			else
				--ポリ劇再生
				proxy:RequestRemo(30203,REMO_FLAG,1165,1);
			end	]]
			
			print("OnEvent_1165 end");
		else
			print("OnEvent_1165 BATTI_ANGRY");
		end
	else
		print("OnEvent_1165 Region 2531 not In");
	end
end

--マルチ配信用
function OnEvent_1165_0(proxy,param)
	print("OnEvent_1165_0 begin");
	--ポリ劇再生開始
	if param:IsNetMessage() == true then
		--発動者出演ポリ劇
		proxy:RequestRemoPlus(30203,REMO_FLAG,1165,1, param:GetPlayID()+10001);
		print("ホスト出演ポリ劇再生");
	else
		--ポリ劇再生
		proxy:RequestRemo(30203,REMO_FLAG,1165,1);
		print("ポリ劇再生");
	end

--2009.04.24 toyohide バグ対応の為引越し
--	proxy:SetEventFlag( 4890, true );--会話用 
--	proxy:SetEventFlag( 1165, true );--ポリ劇発動用
	
	print("OnEvent_1165_0 end");
end

--■1541_RemoStart■ポリ劇開始 フェードアウト完了■
function OnEvent_1165_RemoStart(proxy,param)
	print( "OnEvent_1165_RemoStart begin" );
	if proxy:IsClient() == false then--ホストならば
		proxy:Warp( LOCAL_PLAYER, 2405 );
		proxy:CamReset( LOCAL_PLAYER, true );
		if proxy:IsAlive( 10000 ) == true then
			proxy:PlayerChrResetAnimation_RemoOnly(10000);
			proxy:ChrResetRequest(10000);
		end
	else
		print("クライアントなので、処理は無い");
	end
	print( "OnEvent_1165_RemoStart end" );
end

--■1541_RemoFinish■ポリ劇再生終了後■
function OnEvent_1165_RemoFinish(proxy , param)
	print( "OnEvent_1165_RemoFinish begin" );
	
	proxy:SetEventFlag( 4890, true );--会話用 
	proxy:SetEventFlag( 1165, true );--ポリ劇発動用
	
	SetNpcStateFlag( proxy, param, batti_flag_list, BATTI_SATISFIED );--パッチの状態を「満足」に変える
	OnEvent_1143(proxy,param);
	
	print( "OnEvent_1165_RemoFinish end" );
end

--------------------------------------------------------------------------------------
--穴に落ちたら敵対■1166
--------------------------------------------------------------------------------------
function OnEvent_1166(proxy,param)
	print("OnEvent_1166 begin");
	if	proxy:IsCompleteEvent( BATTI_PUSHING )		== true or
		proxy:IsCompleteEvent( BATTI_SATISFIED )	== true then
		
		proxy:EnableLogic( 636 , true );
		proxy:SetEventFlag(1166,true);
		SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_ANGRY);
		proxy:SetTeamType( 636, TEAM_TYPE_AngryFriend );
		
	end
	
	print("OnEvent_1166 end");
end
--------------------------------------------------------------------------------------
--バッチに一定ダメージ■1167
--------------------------------------------------------------------------------------
function OnEvent_1167(proxy,param)
	print("OnEvent_1167 begin");
	proxy:EnableLogic( 636 , true );
	SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_ANGRY);
	proxy:SetTeamType( 636, TEAM_TYPE_AngryFriend );
	proxy:SetEventFlag(1167,true);
	print("OnEvent_1167 end");
end


--------------------------------------------------------------------------------------
--バッチ死亡■1168
--------------------------------------------------------------------------------------
function OnEvent_1168(proxy,param)
	print("OnEvent_1168 begin");
	proxy:SetEventFlag(1168,true);
	SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_DEAD);
	print("OnEvent_1168 end");
end


--------------------------------------------------------------------------------------
--魔法使いA死亡■1173
--------------------------------------------------------------------------------------
function OnEvent_1173(proxy,param)
	print("OnEvent_1173 begin");
	proxy:SetEventFlag(1173,true);
	--ジェネレータ無効
	proxy:EnableGeneratorSystem(2532,false);
	print("OnEvent_1173 end");
end

--------------------------------------------------------------------------------------
--魔法使いB死亡■1174
--------------------------------------------------------------------------------------
function OnEvent_1174(proxy,param)
	print("OnEvent_1174 begin");
	proxy:SetEventFlag(1174,true);
	--ジェネレータ無効
	proxy:EnableGeneratorSystem(2533,false);
	proxy:EnableGeneratorSystem(2534,false);
	proxy:EnableGeneratorSystem(2535,false);
	proxy:EnableGeneratorSystem(2536,false);
	proxy:EnableGeneratorSystem(2537,false);
	proxy:EnableGeneratorSystem(2538,false);
	proxy:EnableGeneratorSystem(2539,false);
	print("OnEvent_1174 end");
end

--------------------------------------------------------------------------------------
--魔法使いC死亡■1175
--------------------------------------------------------------------------------------
function OnEvent_1175(proxy,param)
	print("OnEvent_1175 begin");
	proxy:SetEventFlag(1175,true);
	--ジェネレータ無効
	proxy:EnableGeneratorSystem(2540,false);
	print("OnEvent_1175 end");
end

--------------------------------------------------------------------------------------
--魔法使いD死亡■1176
--------------------------------------------------------------------------------------
function OnEvent_1176(proxy,param)
	print("OnEvent_1176 begin");
	proxy:SetEventFlag(1176,true);
	--ジェネレータ無効
	proxy:EnableGeneratorSystem(2541,false);
	print("OnEvent_1176 end");
end


--------------------------------------------------------------------------------------
--影人360死亡■1177
--------------------------------------------------------------------------------------
function OnEvent_1177_360(proxy,param)
	--既に終わってる場合は不要
	if proxy:IsCompleteEvent(1177) == true or proxy:IsCompleteEvent(1173) == true then
		return;
	end
	print("OnEvent_1177_360 begin");
	local deadCount = 0;
	local id = 360;
	
	for id = 360, 364, 1 do
		if proxy:IsAlive(id) == false then
			deadCount = deadCount+1;
		end
	end
	
	--死亡カウンタが３以上なら
	if deadCount >= 3 then
		--ジェネレータ起動
		proxy:EnableGeneratorSystem(2532,true);
		proxy:SetEventFlag(1177,true);
		proxy:PlayAnimation(357,3005);
		proxy:OnRegistFunc( 1181,"Check_1181","OnEvent_1181",1,once);
	end	
	print("OnEvent_1177_360 end");
end


--------------------------------------------------------------------------------------
--影人361死亡■1177
--------------------------------------------------------------------------------------
function OnEvent_1177_361(proxy,param)
	--既に終わってる場合は不要
	if proxy:IsCompleteEvent(1177) == true or proxy:IsCompleteEvent(1173) == true then
		return;
	end
	print("OnEvent_1177_361 begin");
	local deadCount = 0;
	local id = 360;
	
	for id = 360, 364, 1 do
		if proxy:IsAlive(id) == false then
			deadCount = deadCount+1;
		end
	end
	
	--死亡カウンタが３以上なら
	if deadCount >= 3 then
		--ジェネレータ起動
		proxy:EnableGeneratorSystem(2532,true);
		proxy:SetEventFlag(1177,true);
		proxy:PlayAnimation(357,3005);
		proxy:OnRegistFunc( 1181,"Check_1181","OnEvent_1181",1,once);
	end	
	print("OnEvent_1177_361 end");
end


--------------------------------------------------------------------------------------
--影人362死亡■1177
--------------------------------------------------------------------------------------
function OnEvent_1177_362(proxy,param)
	--既に終わってる場合は不要
	if proxy:IsCompleteEvent(1177) == true or proxy:IsCompleteEvent(1173) == true then
		return;
	end
	print("OnEvent_1177_362 begin");
	local deadCount = 0;
	local id = 360;
	
	for id = 360, 364, 1 do
		if proxy:IsAlive(id) == false then
			deadCount = deadCount+1;
		end
	end
	--死亡カウンタが３以上なら
	if deadCount >= 3 then
		--ジェネレータ起動
		proxy:EnableGeneratorSystem(2532,true);
		proxy:SetEventFlag(1177,true);
		proxy:PlayAnimation(357,3005);
		proxy:OnRegistFunc( 1181,"Check_1181","OnEvent_1181",1,once);
	end	
	print("OnEvent_1177_362 end");
end


--------------------------------------------------------------------------------------
--影人363死亡■1177
--------------------------------------------------------------------------------------
function OnEvent_1177_363(proxy,param)
	--既に終わってる場合は不要 or 既に魔法使い死んでる
	if proxy:IsCompleteEvent(1177) == true or proxy:IsCompleteEvent(1173) == true then
		return;
	end
	print("OnEvent_1177_363 begin");
	local deadCount = 0;
	local id = 360;
	
	for id = 360, 364, 1 do
		if proxy:IsAlive(id) == false then
			deadCount = deadCount+1;
		end
	end
	
	--死亡カウンタが３以上なら
	if deadCount >= 3 then
		--ジェネレータ起動
		proxy:EnableGeneratorSystem(2532,true);
		proxy:SetEventFlag(1177,true);
		proxy:PlayAnimation(357,3005);
		proxy:OnRegistFunc( 1181,"Check_1181","OnEvent_1181",1,once);
	end	
	print("OnEvent_1177_363 end");
end


--------------------------------------------------------------------------------------
--影人364死亡■1177
--------------------------------------------------------------------------------------
function OnEvent_1177_364(proxy,param)
	--既に終わってる場合は不要
	if proxy:IsCompleteEvent(1177) == true or proxy:IsCompleteEvent(1173) == true then
		return;
	end
	print("OnEvent_1177_364 begin");
	local deadCount = 0;
	local id = 360;
	
	for id = 360, 364, 1 do
		if proxy:IsAlive(id) == false then
			deadCount = deadCount+1;
		end
	end
	
	--死亡カウンタが３以上なら
	if deadCount >= 3 then
		--ジェネレータ起動
		proxy:EnableGeneratorSystem(2532,true);
		proxy:SetEventFlag(1177,true);
		proxy:PlayAnimation(357,3005);
		proxy:OnRegistFunc( 1181,"Check_1181","OnEvent_1181",1,once);
	end	
	print("OnEvent_1177_364 end");
end


--------------------------------------------------------------------------------------
--ジェネレータ起動■1178
--------------------------------------------------------------------------------------
function OnEvent_1178(proxy,param)
	print("OnEvent_1178 begin");
	if proxy:IsCompleteEvent(1174) == false then
		--召還アニメ
		proxy:PlayAnimation(356,3005);
		proxy:OnRegistFunc( 1182,"Check_1182","OnEvent_1182",1,once);
		--ジェネレータ起動
		if proxy:IsCompleteEvent(1151) == false then
			proxy:EnableGeneratorSystem(2533,true);
		elseif proxy:IsCompleteEvent(1152) == false then
			proxy:EnableGeneratorSystem(2534,true);
		elseif proxy:IsCompleteEvent(1153) == false then
			proxy:EnableGeneratorSystem(2535,true);
		elseif proxy:IsCompleteEvent(1154) == false then
			proxy:EnableGeneratorSystem(2536,true);
		elseif proxy:IsCompleteEvent(1155) == false then
			proxy:EnableGeneratorSystem(2537,true);
		elseif proxy:IsCompleteEvent(1156) == false then
			proxy:EnableGeneratorSystem(2538,true);
		else
			proxy:EnableGeneratorSystem(2539,true);
		end
		proxy:SetEventFlag(1178,true);
	end
	print("OnEvent_1178 end");
end


--------------------------------------------------------------------------------------
--ジェネレータ起動■1179
--------------------------------------------------------------------------------------
function OnEvent_1179(proxy,param)
	print("OnEvent_1179 begin");
	if proxy:IsCompleteEvent(1175) == false then
		--ジェネレータ起動
		proxy:EnableGeneratorSystem(2540,true);
		proxy:PlayAnimation(358,3005);
		proxy:OnRegistFunc(1183,"Check_1183","OnEvent_1183",1,once);
		proxy:SetEventFlag(1179,true);
	end
	print("OnEvent_1179 end");
end


--------------------------------------------------------------------------------------
--ジェネレータ起動■1180
--------------------------------------------------------------------------------------
function OnEvent_1180(proxy,param)
	print("OnEvent_1180 begin");
	if proxy:IsCompleteEvent(1176) == false then
		--ジェネレータ起動
		proxy:EnableGeneratorSystem(2541,true);
		proxy:SetEventFlag(1180,true);
		proxy:PlayAnimation(359,3005);
		proxy:OnRegistFunc(1184,"Check_1184","OnEvent_1184",1,once);
	end
	print("OnEvent_1180 end");
end







--------------------------------------------------------------------------------------
--↑整理済み　↓未整理　■ function
--------------------------------------------------------------------------------------





--------------------------------------------------------------------------------------
--マルチになった時にホストじゃ無かったら■無し
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end

--------------------------------------------------------------------------------------
--遺体廃棄所の扉A■1064
--------------------------------------------------------------------------------------

--■1064■遺体廃棄所の扉A■
function OnEvent_1064(proxy, param)
	print("OnEvent_1064 begin");

	proxy:PlayAnimation( 1412 , 1 );--扉のアニメーション
	
	if 	proxy:IsCompleteEvent( URUBAIN_STATE_HELP ) == true and --助けて状態で
		proxy:IsCompleteEvent( 1250 ) == true then	--黒を倒している
		SetNpcStateFlag(proxy,param,urubain_flag_list,URUBAIN_STATE_THANKS);
	end	
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 1064 , 1 );--開閉扉A(手前から開ける)への操作を無効にする。
		return;
	end
--[[	
	proxy:NotNetMessage_begin();
		--▼1064_1▼プレイヤーアニメーションの終了イベント▼
		proxy:OnChrAnimEnd( 1064, 10000, ANIMEID_OPEN, "OnEvent_1064_1", once );
	proxy:NotNetMessage_end();
]]	
--	proxy:DisableMove(10000,1);	 --キャラクタを移動、旋回不能に
	proxy:WarpDmy( 10000 , 1412 , 191 );
	
	proxy:SetEventFlag( 1064 , 1 );--開閉扉A(手前から開ける)への操作を無効にする。
	
	print("OnEvent_1064 end");
end
--[[
--▲1064_1▲プレイヤーアニメーションの終了イベント▲
function OnEvent_1064_1(proxy, param)
	print("OnEvent_1064_1 begin");
	
	proxy:DisableMove(10000,0);	--キャラクタを移動、旋回可能に
	
	print("OnEvent_1064_1 end");
end
]]

--------------------------------------------------------------------------------------
--遺体廃棄場の両開き扉(床スイッチC)■1074
--------------------------------------------------------------------------------------
--■1074■床スイッチ■
function OnEvent_1074(proxy, param)
	print("OnEvent_1074 begin");

	--床アニメ
	proxy:PlayAnimation( 1413, 1 );
	
	proxy:NotNetMessage_begin();
		--▼1074_1▼***条件追加***0.5秒後▼
		proxy:OnKeyTime2( 1074, "OnEvent_1074_1", 0.5, 0, 0, once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 1074, 1 );
	
	print("OnEvent_1074 end");
end

--▲1074_1▲0.5秒後▲
function OnEvent_1074_1(proxy, param)
	print("OnEvent_1074_1 begin");
	
	proxy:PlayAnimation( 1406, 1 );	--扉が開くアニメ
	
	print("OnEvent_1074_1 end");
end



--------------------------------------------------------------------------------------
--徘徊デーモンの登場■1084
--------------------------------------------------------------------------------------

--■1084■徘徊デーモンの登場■
function OnEvent_1084(proxy, param)
	print("OnEvent_1084 begin");

	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m03_02_00_00);
	
	print("OnEvent_1084 end");
end

--------------------------------------------------------------------------------------
--徘徊デーモンの登場■1084
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ)
function PlayerDeath_m03_02_00_00(proxy, param)
	print("PlayerDeath_m03_02_00_00");
	--[[
	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m03_02_00_00);
	proxy:SetEventFlag( 1084 , 1 );
	]]
	print("PlayerDeath_m03_02_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ)
function PlayerRevive_m03_02_00_00(proxy,param)
	print("PlayerRevive_m03_02_00_00");
	--[[
	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m03_02_00_00);
	proxy:SetEventFlag( 1084 , 0 );
	]]
	print("PlayerRevive_m03_02_00_00");
end



--------------------------------------------------------------------------------------
--■1160■扉が開くポリ劇再生■
--------------------------------------------------------------------------------------

function OnEvent_1160(proxy , param)
	print("OnEvent_1160 begin");
	
	if param:IsNetMessage() == true then
		--発動者出演ポリ劇
		proxy:RequestRemoPlus(30202,REMO_FLAG,1160,1, param:GetPlayID()+10001);
	else
		--ポリ劇再生
		proxy:RequestRemo(30202,REMO_FLAG,1160,1);
	end
	
	proxy:SetEventFlag( 1160 , 1 );--フラグセット
	
	print("OnEvent_1160 end");
end


--■ポリ劇再生開始(フェード終了)
function OnEvent_1160_RemoStart(proxy,param)
	print("OnEvent_1160_RemoStart begin");	
	print("OnEvent_1160_RemoStart end");
end


--■ポリ劇再生終了(フェード終了)
function OnEvent_1160_RemoFinish(proxy , param)
	print("OnEvent_1160_RemoFinish begin");
	
	proxy:EndAnimation( 1409 , 1 );--対応する扉が開くアニメ再生終了
	--床アニメ
	proxy:EndAnimation( 1405, 1 );
	
	print("OnEvent_1160_RemoFinish end");
end


--------------------------------------------------------------------------------------
--古砦囚人通常■1185
--------------------------------------------------------------------------------------
function OnEvent_1185(proxy,param)
	print("OnEvent_1185 begin");
		
	--古砦囚人の状態を古砦２にいるにする
	SetNpcStateFlag(proxy,param,syuujin_flag_list,SYUUJIN_STATE_STAY);
	proxy:SetEventFlag(1185,true);

	print("OnEvent_1185 end");
end

--------------------------------------------------------------------------------------
--古砦囚人敵対■1185
--------------------------------------------------------------------------------------
function OnEvent_1185_1(proxy, param)
	print("OnEvent_1185_1 begin");

	--ロジックON
	proxy:EnableLogic( 678 , true );
	
	--古砦囚人の状態を古砦２敵対にする
	SetNpcStateFlag(proxy,param,syuujin_flag_list,SYUUJIN_STATE_ANGRY_02);
	proxy:SetTeamType( 678, TEAM_TYPE_AngryFriend );
	proxy:SetEventFlag(1185,true);

	print("OnEvent_1185_1 end");
end


--------------------------------------------------------------------------------------
--古砦囚人死亡■1186
--------------------------------------------------------------------------------------
function OnEvent_1186(proxy, param)
	print("OnEvent_1186 begin");

	--古砦囚人の状態を死亡にする
	SetNpcStateFlag(proxy, param, syuujin_flag_list, SYUUJIN_STATE_DEAD );
	proxy:SetEventFlag( 1186 , 1 );
	
	print("OnEvent_1186 end");
end



--------------------------------------------------------------------------------------
--魔法使いリアクション■1181
--------------------------------------------------------------------------------------
function Check_1181(proxy,param)
	if proxy:IsAlive(357) == true then
		local eneid = 370;
		local maxid = 374;
		for eneid = 370, maxid , 1 do
			if proxy:IsAlive(eneid) == false then
				proxy:PlayAnimation(357,3005);
				return false;
			end
		end
		return false;
	end
	return true;	
end

--消去
function OnEvent_1181(proxy,param)
	print("OnEvent_1181 begin");
	print("OnEvent_1181 end");
end


--------------------------------------------------------------------------------------
--魔法使いリアクション■1182
--------------------------------------------------------------------------------------
function Check_1182(proxy,param)
	if proxy:IsAlive(356) == true then
		--PCが指定された領域に侵入していなかった場合
		if proxy:IsCompleteEvent( 1182 ) == false then
			local eneid;
			local maxid;
			if proxy:IsCompleteEvent(1151) == false then
				eneid = 476;
				maxid = 479;
			elseif proxy:IsCompleteEvent(1152) == false then
				eneid = 480;
				maxid = 483;
			elseif proxy:IsCompleteEvent(1153) == false then
				eneid = 484;
				maxid = 487;
			elseif proxy:IsCompleteEvent(1154) == false then
				eneid = 488;
				maxid = 491;
			elseif proxy:IsCompleteEvent(1155) == false then
				eneid = 492;
				maxid = 497;
			elseif proxy:IsCompleteEvent(1156) == false then
				eneid = 498;
				maxid = 501;
			else
				eneid = 502;
				maxid = 505;
			end
			for IndexID = eneid, maxid , 1 do
				--各ジェネレータ毎の影人が生きてるかどうかの判定
				if proxy:IsAlive(IndexID) == false then
					proxy:PlayAnimation(356,3005);	--影人が死んでたら鎌を振るモーションをする
					return false;
				end
			end
			return false;
		end
		return false;
	end
	return true;
end

--消去
function OnEvent_1182(proxy,param)
	print("OnEvent_1182 begin");
	print("OnEvent_1182 end");
end


--------------------------------------------------------------------------------------
--魔法使いリアクション■1183
--------------------------------------------------------------------------------------
function Check_1183(proxy,param)
	if proxy:IsAlive(358) == true then
		local eneid = 507;
		local maxid = 511;
		for eneid = 507, maxid , 1 do
			if eneid ~= 506 then
				if proxy:IsAlive(eneid) == false then
					proxy:PlayAnimation(358,3005);
					return false;
				end
			end
		end
		return false;
	end
	return true;
end

--消去
function OnEvent_1183(proxy,param)
	print("OnEvent_1183 begin");
	print("OnEvent_1183 end");
end


--------------------------------------------------------------------------------------
--魔法使いリアクション■1184
--------------------------------------------------------------------------------------
function Check_1184(proxy,param)
	if proxy:IsAlive(359) == true then
		local eneid = 512;
		local maxid = 516;
		for eneid = 512, maxid , 1 do
			if proxy:IsAlive(eneid) == false then
				proxy:PlayAnimation(359,3005);
				return false;
			end
		end
		return false;
	end
	return true;
end

--消去
function OnEvent_1184(proxy,param)
	print("OnEvent_1184 begin");
	print("OnEvent_1184 end");
end

--------------------------------------------------------------------------------------
--■骸骨剣士が動き出す■
--------------------------------------------------------------------------------------
function Move_Skeleton(proxy, param, ActID, SkeletonCharaID)
	proxy:StopLoopAnimation(SkeletonCharaID);
	proxy:PlayAnimation(SkeletonCharaID, 7001);--起き上がるアニメ再生
	proxy:SetSpStayAndDamageAnimId(SkeletonID,-1,-1);--特殊待機アニメの無効化
	proxy:SetColiEnable(SkeletonCharaID, true);--アタリON
	proxy:EnableLogic( SkeletonCharaID, true );--ロジックON
	print("骸骨剣士("..SkeletonCharaID..")起動");
	proxy:SetEventFlag(ActID, true);
end

---------------------------------
--骸骨剣士起動関数発動
---------------------------------
function OnEvent_1390(proxy, param)	Move_Skeleton(proxy, param, 1390, 290);end
function OnEvent_1391(proxy, param)	Move_Skeleton(proxy, param, 1391, 291);end
function OnEvent_1392(proxy, param)	Move_Skeleton(proxy, param, 1392, 292);end
function OnEvent_1393(proxy, param)	Move_Skeleton(proxy, param, 1393, 293);end
function OnEvent_1394(proxy, param)	Move_Skeleton(proxy, param, 1394, 294);end
function OnEvent_1395(proxy, param)	Move_Skeleton(proxy, param, 1395, 295);end
function OnEvent_1396(proxy, param)	Move_Skeleton(proxy, param, 1396, 434);end
function OnEvent_1397(proxy, param)	Move_Skeleton(proxy, param, 1397, 435);end
function OnEvent_1398(proxy, param)	Move_Skeleton(proxy, param, 1398, 436);end


--------------------------------------------------------------------------------------
--■ウィルオウィスプ爆発■
--------------------------------------------------------------------------------------
function WillOTheWisp_Explosion(proxy ,param ,ActID, WillID)
	proxy:DeleteObjSfxEventID(WillID);
	proxy:CastPointSpell_Horming(340, WillID, 10170 , 0,0,0,WillID);
	proxy:SetEventFlag(ActID ,true);
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( ActID,"WispRumble",1.2,0,WillID,once);
	proxy:NotNetMessage_end();
	
	print("ウィルオウィスプ（"..WillID.."）爆発！");
end

---------------------------------
--ウィルオウィスプ爆発関数発動
---------------------------------
function OnEvent_1370(proxy, param)	WillOTheWisp_Explosion(proxy, param, 1370, 1480);end
function OnEvent_1371(proxy, param)	WillOTheWisp_Explosion(proxy, param, 1371, 1481);end
function OnEvent_1372(proxy, param)	WillOTheWisp_Explosion(proxy, param, 1372, 1482);end
function OnEvent_1373(proxy, param)	WillOTheWisp_Explosion(proxy, param, 1373, 1483);end
function OnEvent_1374(proxy, param)	WillOTheWisp_Explosion(proxy, param, 1374, 1484);end
function OnEvent_1375(proxy, param)	WillOTheWisp_Explosion(proxy, param, 1375, 1485);end

function WispRumble(proxy,param)
	print("WispRumble begin");
	proxy:AddRumble(121, param:GetParam3(), -1,1.0, 25.0);
	print("WispRumble end");
end

-----------------------------------------------------------------------------
--■1380～1381■槍射出トラップ
-----------------------------------------------------------------------------
--■1380■槍射出トラップ■----------------------------------------------------
function OnEvent_1380(proxy,param)
	print("OnEvent_1380 begin");
	proxy:PlayAnimation( 1430, 1 );
	proxy:OnCharacterAnimEnd( 1380, 1430, 1, "OnEvent_1380_1", once );
	proxy:SetEventFlag( 1380, true );
	print("OnEvent_1380 end");
end
function OnEvent_1380_1(proxy,param)
	print("OnEvent_1380_1 begin");
	proxy:OnKeyTime2( 1380, "OnEvent_1380_2", 0.0, 0, 2, once );
	print("OnEvent_1380_1 end");
end
function OnEvent_1380_2(proxy,param)
	print("OnEvent_1380_2 begin");
	proxy:PlayAnimation( 1440, 1 );
	print("OnEvent_1380_2 end");
end


--■1381■槍射出トラップ■----------------------------------------------------
function OnEvent_1381(proxy,param)
	print("OnEvent_1381 begin");
	proxy:PlayAnimation( 1431, 1 );
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd( 1381, 1431, 1, "OnEvent_1381_1", once );
	proxy:NotNetMessage_end();
	proxy:CreateSfx_DummyPoly(1431, 1, 93006 );--新たなSFXを設定
	proxy:SetEventFlag( 1381, true );
	print("OnEvent_1381 end");
end
function OnEvent_1381_1(proxy,param)
	print("OnEvent_1381_1 begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1381, "OnEvent_1381_2", 0.0, 0, 2, once );
		proxy:OnKeyTime2( 1381, "OnEvent_1381_2", 0.5, 0, 3, once );
		proxy:OnKeyTime2( 1381, "OnEvent_1381_2", 1.0, 0, 4, once );
	proxy:NotNetMessage_end();
	print("OnEvent_1381_1 end");
end
function OnEvent_1381_2(proxy,param)
	print("OnEvent_1381_2 begin");
	proxy:ForcePlayAnimation( 1441, 1 );
	print("OnEvent_1381_2 end");
end

-------------------------------------------------------------------------------------
--■1220■ボスカメラ設定■
--------------------------------------------------------------------------------------
function OnEvent_1220(proxy,param)
	--print("OnEvent_1220 begin");
	--ボスが死んでいない　かつ　ボスとの戦闘を開始している
	if proxy:IsCompleteEvent( 4895 ) == false and proxy:IsCompleteEvent( 4897 ) == true then
		--ボス戦　非ロックカメラ
		proxy:SetCamModeParamTargetId(3021);
		--ボス戦　ロックカメラ
		proxy:SetCamModeParamTargetIdForBossLock(3020);
	end
	--print("OnEvent_1220 end");
end


--------------------------------------------------------------------------------------
--【鉱石の精霊】死亡■1234
--------------------------------------------------------------------------------------
--【鉱石の精霊】死亡■1234
function OnEvent_1234(proxy,param)
	print("OnEvent_1234 begin");
	
	--フラグON
	proxy:SetEventFlag( 1234, true );
	
	print("OnEvent_1234 end");
end


--------------------------------------------------------------------------------------
--■8020■鉱石の精霊からアイテム取得■
--------------------------------------------------------------------------------------
function OnEvent_8020(proxy,param)
	print("OnEvent_8020 begin");
	proxy:SetEventFlag( 8020 , true );
	print("OnEvent_8020 end");
end

--[[------------------------------------↓魔法使い＆影人関連↓------------------------------------------------]]--
--------------------------------------------------------------------------------------
--魔法使い(100)死亡■1310
--------------------------------------------------------------------------------------
function OnEvent_1310(proxy,param)
	print("OnEvent_1310 begin");
	--ジェネレータ無効
	proxy:EnableGeneratorSystem(1450,false);
	proxy:EnableGeneratorSystem(1451,false);
	proxy:EnableGeneratorSystem(1452,false);
	proxy:EnableGeneratorSystem(1453,false);
	proxy:EnableGeneratorSystem(1454,false);
	proxy:EnableGeneratorSystem(1455,false);
	print("影人ジェネレーター無効");
	
	--生み出した影人死亡
	proxy:ForceDead(200);
	proxy:ForceDead(201);
	proxy:ForceDead(202);
	proxy:ForceDead(203);
	proxy:ForceDead(204);
	proxy:ForceDead(205);
	proxy:ForceDead(206);
	proxy:ForceDead(207);
	proxy:ForceDead(208);
	proxy:ForceDead(209);
	proxy:ForceDead(210);
	print("召還された影人蒸発");
	
	--フラグセット
	proxy:SetEventFlag(1310,true);

	print("OnEvent_1310 end");
end
--------------------------------------------------------------------------------------
--魔法使い(101)死亡■1320
--------------------------------------------------------------------------------------
function OnEvent_1320(proxy,param)
	print("OnEvent_1320 begin");
	--ジェネレータ無効
	proxy:EnableGeneratorSystem(1460,false);
	proxy:EnableGeneratorSystem(1461,false);
	proxy:EnableGeneratorSystem(1462,false);
	proxy:EnableGeneratorSystem(1463,false);
	print("影人ジェネレーター無効");
	
	--生み出した影人死亡
	proxy:ForceDead(220);
	proxy:ForceDead(221);
	proxy:ForceDead(222);
	proxy:ForceDead(223);
	proxy:ForceDead(224);
	print("召還された影人蒸発");
	  
	--フラグセット
	proxy:SetEventFlag(1320,true);

	print("OnEvent_1320 end");
end
--------------------------------------------------------------------------------------
--魔法使い(102)死亡■1330
--------------------------------------------------------------------------------------
function OnEvent_1330(proxy,param)
	print("OnEvent_1330 begin");
	--ジェネレータ無効
	proxy:EnableGeneratorSystem(1470,false);
	print("影人ジェネレーター無効");

	--生み出した影人死亡
	proxy:ForceDead(230);
	proxy:ForceDead(231);
	print("召還された影人蒸発");
	
	--フラグセット	
	proxy:SetEventFlag(1330,true);
	
	print("OnEvent_1330 end");
end

--[[------------------------------------↑魔法使い＆影人関連↑------------------------------------------------]]--


-----------------------------------------------------------------------------
--■1040■結晶トカゲイベント3
-----------------------------------------------------------------------------
function OnEvent_1040(proxy,param)
	print("OnEvent_1040 begin");
	proxy:SetEventFlag( 1040 , true );
	proxy:DeleteEvent( 1040 );
	print("OnEvent_1040 end");
end


-----------------------------------------------------------------------------
--■1400■魔法壁破壊3
-----------------------------------------------------------------------------
function OnEvent_1400(proxy,param)
	print("OnEvent_1400 begin");
	proxy:InvalidSfx( 2470 , true );
	proxy:SetEventFlag( 1400,true );
	print("OnEvent_1400 end");
end
