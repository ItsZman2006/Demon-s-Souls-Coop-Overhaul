
--エイの突撃イベント発動の残HP割合
StormOfBeast_HpRate = 0.5;

--子エイの死んだ数
BeastChildDeadCount = 12;

--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■
--------------------------------------------------------------------------------------
function Initialize_m03_03_00_00(proxy)
	print("Initialize_m03_03_00_00 begin");

--■1541■エリアボスのポリ劇再生■
	--ボスが生きている時だけイベント登録
	if proxy:IsCompleteEvent( 4992 ) == false then
		--死亡時にももう一度再生したい為。
		SingleReset( proxy,1541);
		SingleReset( proxy,5085);
		if proxy:IsCompleteEvent( 1541 ) == false then 	
			--▼ボス前のポリ劇再生用監視追加
			proxy:OnRegionJustIn( 1541 , 10000 , 2896 , "OnEvent_1541" , once );		
			proxy:NotNetMessage_begin();
				--ポリ劇開始に呼ばれるハンドラ
				proxy:LuaCall(1541, REMO_START, "OnEvent_1541_RemoStart", once);
				--ポリ劇終了後に呼ばれるハンドラ(トリガー起こした人用)
				proxy:LuaCall(1541, REMO_FINISH, "OnEvent_1541_RemoFinish", once);
			proxy:NotNetMessage_end();	
		else
			--終わっている状態で入ってきた人にはもう一度
			BossInit_StormOfBeast(proxy,param);
		end
	end


--■1542■ボス部屋に入る■	
	--中ボスが生きているときだけイベント登録
	if proxy:IsCompleteEvent( 4992 ) == false then
	
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。
		SingleReset(proxy, 1542);
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き)
		proxy:LuaCall( 1543, 1, "OnEvent_1542_1", everytime );		
		--▽2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCall( 1543 , 5 , "OnEvent_1542_GO_TO_IN" , everytime );		
		--▽フラグセット(同期用)
		proxy:LuaCall( 1543 , 6 , "OnEvent_1542_flag_set" , everytime );		
		--誰かがボス前扉をまだ通過していない
		if proxy:IsCompleteEvent( 1542 ) == false then		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			proxy:NotNetMessage_begin();
				--▼1542▼扉が開いているときに中に入るためのイベントを追加▼
				proxy:OnPlayerActionInRegionAttribute( 1542, 2892, "OnEvent_1542", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --グレイゴーストできたときようにいると思われる。
			proxy:NotNetMessage_begin();
				--▼1543▼扉が開いているときに中に入るためのイベントを追加▼
				proxy:OnPlayerActionInRegion( 1543, 2892, "OnEvent_1542", HELPID_GO_TO_IN, everytime );--ハンドラは上と同じ
			proxy:NotNetMessage_end();
		end
	end
	
--■4999■ボス戦闘開始■	
	if proxy:IsCompleteEvent( 4992 ) == false then
		proxy:OnRegionIn( 4999 , 10000 , 2884 , "OnEvent_4999" , everytime );
	end	
	
--■4992■エリアボス死亡■
	proxy:AddFieldInsFilter( 822 );
	if proxy:IsCompleteEvent( 4992 ) == false then
		proxy:OnCharacterDead(4992,822,"OnEvent_4992",once);
	end
		
--[[
--■5000・5001■ボス体当たりポリ劇■
	--ボスを倒してない and 指定ポリ劇をみていない
	SingleReset( proxy,5001 );	
	if proxy:IsCompleteEvent( 4992 ) == false and proxy:IsCompleteEvent( 5001 ) == false then
		local eneID = 400;
		local num = 12;
		
		for eneID = 400 , 411 , 1 do
			--子エイの死亡監視
			print("add ",eneID);
			proxy:OnCharacterDead( 5000, eneID ,"OnEvent_5000_"..eneID,once);
		end
		--エイのHp監視		
		proxy:OnCharacterHP( 5000, 822, "OnEvent_5000_HP",StormOfBeast_HpRate,once );
		
		--ポリ劇起動用
		proxy:NotNetMessage_begin();
			--キック
			proxy:LuaCall(5001,1,"OnEvent_5001",once);
			--フェードアウト時
			proxy:LuaCall(5001,REMO_START,"OnEvent_5001_RemoStart",once);
			--フェードイン時
			proxy:LuaCall(5001,REMO_FINISH,"OnEvent_5001_RemoFinish",once);
		proxy:NotNetMessage_end();
	end
	]]
--■??■徘徊デーモンの登場■ハンドラ登録
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。
		proxy:LuaCall( 4000, 100, "PlayerDeath_m03_03_00_00", everytime );
		--プレイヤーが復活した時にキックされます。
		proxy:LuaCall( 4032, 100, "PlayerRevive_m03_03_00_00", everytime );
	proxy:NotNetMessage_end();

	
	--■ボス関連の初期化処理
	if proxy:IsCompleteEvent( 4992 ) ==true then
		
		--▽ボス死んでいるとき
		--ボスいなくなる
		InvalidBackRead( proxy , 822 );
		--初期化で消したフラグを立てる
		proxy:SetEventFlag( 4991, true );
		
		--子エイも表示しない
		--[[
		local eneID = 400;		
		for eneID=400,411,1 do		
			InvalidCharactor( proxy, eneID);
		end
		]]
		--ジェネレータ止める
		proxy:EnableGeneratorSystem( 2605 , false );
		
		--魔法壁消える
		proxy:SetColiEnable( 1996 , false );			
		proxy:SetDrawEnable( 1996 , false );
		
		--SFX消去
		proxy:InvalidSfx(1988,false);	

		--ホストプレイヤーのみアイテム入手イベントに使用
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--宝死体(ソウル?)有効化
		proxy:SetDrawEnable( 1979 , true );
		proxy:SetColiEnable( 1979 , true );
		--宝死体(ソウル?)2有効化
		proxy:SetDrawEnable( 1978 , true );
		proxy:SetColiEnable( 1978 , true );
		
		proxy:TreasureDispModeChange2( 1979 , true ,KANAME_SFX);--光らせる
		--▼(ソウル)アイテム取得用イベント監視追加▼
		if proxy:IsCompleteEvent( 4996 ) == false then
			proxy:ValidSfx( 2601 );--SFX 有効化
			proxy:ValidSfx( 2600 );--SFX 有効化			
			proxy:OnDistanceActionAttribute( 4996 , 10000 , 1979 , "OnEvent_4996" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--▼要石でワープ用の監視を追加▼
			SingleReset(proxy,4998);
			--proxy:InvalidSfx( 2601, false );--SFX 有効化
			proxy:InvalidSfx( 2600, false );--SFX 有効化
			proxy:OnDistanceActionAttribute( 4998 , 10000 , 1979 , "OnEvent_4998" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
	else
		--▽ボス生きているとき
		
		--エリアボスポリ劇を見ていないとき
		if proxy:IsCompleteEvent(1541) == false then
			
			InvalidCharactor( proxy,822 );			
			--何にも当たらない
			--proxy:SetIgnoreHit( 822, true);
			--proxy:DisableMapHit( 822 , true);
	
			--子エイを表示しない
			local eneID;
			for eneID = 400, 411, 1 do
				proxy:SetDrawEnable( eneID, false );
				proxy:SetColiEnable( eneID, false );
			end
		end
		
		proxy:EnableLogic( 822 , false );--ロジックOFFで待機
		
		
		--子エイロジックOFF
		local eneID = 400;
		for eneID=400 , 411 , 1 do
			proxy:EnableLogic(eneID,false);
		end
		
		--宝(ソウル?)
		proxy:SetDrawEnable( 1979 , false );
		proxy:SetColiEnable( 1979 , false );
		--宝(ソウル?)2
		proxy:SetDrawEnable( 1978 , false );
		proxy:SetColiEnable( 1978 , false );

		--SFX 無効化
		proxy:InvalidSfx( 2600 , false );--ソウル用
		proxy:InvalidSfx( 2601 , false );--ボスアイテム用			

	end
	
--■1544■ボス戦カメラ対応■
	--ボスが生きているなら登録
	if proxy:IsCompleteEvent(4992) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 1544 , 10000 , 2884 ,"OnEvent_1544" , everytime );
		proxy:NotNetMessage_end();
	end

--■1590■ストームブリンガー強化■
	--ボスが生きているなら登録
	--if proxy:IsCompleteEvent(4992) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 1590, 10000, 2610 , "OnEvent_1590",everytime ); 
			proxy:OnRegionJustOut( 1590 , 10000 , 2610 , "OnEvent_1590_out",everytime );
		proxy:NotNetMessage_end();
	--end
	
--■1570■砦１・２の子エイの無効化■
	SingleReset( proxy , 1570 );
	
	--if proxy:IsCompleteEvent( 4992 ) == false then
		proxy:NotNetMessage_begin();
			if proxy:IsClient() == false then
				proxy:OnRegionJustIn( 1570 ,10000 , 2680 , "OnEvent_1570" , everytime );
			end
			if proxy:IsCompleteEvent( 1570 ) == true then
				for eneid = 388 , 399 , 1 do
					InvalidCharactor( proxy , eneid );
				end
			end
		proxy:NotNetMessage_end();
		proxy:LuaCall( 1570 , 0 , "OnEvent_1570_1",everytime );
	--end
	
--■1571■砦１・２の子エイの有効化■
	--if proxy:IsCompleteEvent( 4992 ) == false then
		proxy:NotNetMessage_begin();
			if proxy:IsClient() == false then
				proxy:OnRegionJustIn( 1571 ,10000 , 2681, "OnEvent_1571" , everytime );
			end
		proxy:NotNetMessage_end();
		proxy:LuaCall( 1571 , 0 , "OnEvent_1571_1",everytime );
	--end

--■8085■古砦に来たフラグを立てる■	
	proxy:SetEventFlag(8085, true);
	
	--結晶トカゲ逃亡イベント
	RegistTokage(proxy,1580,256,10);
	RegistTokage(proxy,1582,257,11);
	


--■1591■ストームブリンガー■
	if proxy:IsCompleteEvent( 1591 ) == false then
		--ホスト、生存、グレイのみ調べることができる
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		
		proxy:OnDistanceActionAttribute( 1591 , LOCAL_PLAYER , 1610 , "OnEvent_1591" , ItemBoxDist_A , 10010158 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
		proxy:LuaCall( 1591,1,"OnEvent_1591_2",once);
		proxy:LuaCall( 1591,2,"OnEvent_1591_3",once);
		proxy:TreasureDispModeChange2( 1610, true ,KEN_SFX);
	else
		proxy:SetDrawEnable( 1610 , false );--ひとまず描画だけOFF
		proxy:SetColiEnable( 1610 , false );
	end	
	

	--■999999■フレーム遅れの初期化処理イベントを発行■
	proxy:NotNetMessage_begin();
		--▼0秒後▼--
		proxy:OnKeyTime2( 999993, "Second_Initialize_m03_03_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m03_03_00_00 end");
end


--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく
function Second_Initialize_m03_03_00_00(proxy, param)
	print("Second_Initialize_m03_03_00_00 begin");

--------------------------------▽▽▽QWCイベント関連▽▽▽--------------------------------
--------------------------------△△△QWCイベント関連△△△--------------------------------

	print("Second_Initialize_m03_03_00_00 end");
end



	


--------------------------------------------------------------------------------------
--エリアボスポリ劇再生■1541
--------------------------------------------------------------------------------------
--発動領域の中に入った
function OnEvent_1541(proxy, param)
	print("OnEvent_1541 begin");
	
	--ポリ劇再生開始
	proxy:RequestRemo(30300,REMO_FLAG,1541,1);
	proxy:SetEventFlag( 1541 , 1 );--ポリ劇再生終了フラグON	
	print("OnEvent_1541 end");
end

--■1541_RemoStart■ポリ劇開始 フェードアウト完了■
function OnEvent_1541_RemoStart(proxy,param)
	print( "OnEvent_1541_RemoStart begin" );
	print( "OnEvent_1541_RemoStart end" );
end

--■1541_RemoFinish■ポリ劇再生終了後■
function OnEvent_1541_RemoFinish(proxy , param)
	print( "OnEvent_1541_RemoFinish begin" );
	
	--ボス戦闘開始用の処理を呼び出す
	BossInit_StormOfBeast(proxy,param);

	--ボスポリ劇終了後のボスの表示
	--proxy:SetDrawEnable( 822, true );
	--proxy:SetColiEnable( 822, true );
	ValidCharactor( proxy, 822);
	
	--ボスポリ劇終了後の子エイの表示
	local eneID;
	for eneID = 400, 411, 1 do
		proxy:SetDrawEnable( eneID, true );
		proxy:SetColiEnable( eneID, true );
	end
	
	--ポリ劇再生終了のフラグ
	proxy:SetEventFlag( 5085 ,true );
	
	print( "OnEvent_1541_RemoFinish end" );
end



--------------------------------------------------------------------------------------
--ボス部屋の中に入る■1542
--------------------------------------------------------------------------------------
--■イベントがループなので、全部リピートにする↓
--■1542■中ボス部屋への扉が開く■
function OnEvent_1542(proxy,param)
	print("OnEvent_1542 begin");

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_1542 end");
		return;
	end	
	
	--クライアントへ、ボス部屋阻止失敗を通知
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 1543 , 1 );--旋回アニメの同期再生
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--多重起動システムIDをタイムアウトを設定してONにする
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1542 end");
end


--旋回アニメの同期再生(IDが別)
function OnEvent_1542_1(proxy,param)
	print("OnEvent_1542_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を同期
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2888 );
		else
			proxy:LockSession();--ルームをロックします！
			--旋回アニメ再生を行い、その終了時にOnEvent_1542_2を発行する
			proxy:OnTurnCharactorEnd( 1543, 10000, 2888, "OnEvent_1542_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1542_1 end");
end

--旋回アニメの同期再生終了後
function OnEvent_1542_2(proxy,param)
	print("OnEvent_1542_2 begin");

	--同期用歩きアニメ再生
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1543, 10000, ANIMEID_WALK, "OnEvent_1542_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1542_2 end");
end

--歩きアニメの同期再生終了後
function OnEvent_1542_3(proxy,param)
	print("OnEvent_1542_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ
	if proxy:IsCompleteEvent( 1542 ) == false then
		proxy:LuaCallStart( 1543 , 5 );--2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知
		proxy:LuaCallStart( 1543 , 6 );--フラグセット(同期用)		
		--嵐の獣と子エイ対応
		local eneidlist = {822,400,401,402,403,404,405,406,407,408,409,410,411};
		local num = table.getn( eneidlist );
		for index = 1 , num , 1 do
			Lua_MultiDoping(proxy,eneidlist[index]);--マルチプレイドーピング
		end
	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない)
	if proxy:IsClient() == false then
		proxy:ResetThink( 822 );
	end	
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );
	print("OnEvent_1542_3 end");
end


--■1542 2回目以降にボス部屋に入るためのイベント配信用
function OnEvent_1542_GO_TO_IN(proxy, param)
	print("OnEvent_1542_GO_TO_IN begin");	
	proxy:NotNetMessage_begin();
		--▼1542▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_1542
		proxy:OnPlayerActionInRegion( 1543, 2892, "OnEvent_1542", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	print("OnEvent_1542_GO_TO_IN end");
end


--■1542 フラグセット(同期用)
function OnEvent_1542_flag_set(proxy, param)
	print("OnEvent_1542_flag_set begin");		
	proxy:SetEventFlag( 1542 , 1 );
	proxy:DeleteEvent( 1542 );
	print("OnEvent_1542_flag_set end");
end


--------------------------------------------------------------------------------------
--ボスが動き出す(戦闘開始)■4999
--------------------------------------------------------------------------------------
function OnEvent_4999(proxy, param)
	if proxy:IsCompleteEvent( 5085 ) == false then
		return;
	end
	
	print("OnEvent_4999 begin");
	
	--ボス戦用BGM再生開始
	proxy:PlayPointSE( 2602, SOUND_TYPE_M, 30300000, 3 );
	--ロジックON
	proxy:EnableLogic( 822 , true );
	--嵐の獣はこの段階ではロジックOFF
	
	--ボス戦闘開始用の処理を呼び出す
	--BossInit_StormOfBeast(proxy,param);
	--読み込みタイミングのとき毎回追加されてほしいのでフラグたてない
	--ボスゲージ表示
	proxy:SetBossGauge( 822 , 0 ,5030 );
	
	--監視削除
	proxy:DeleteEvent( 4999 );
	
	print("OnEvent_4999 end");
end


--------------------------------------------------------------------------------------
--エリアボスの死亡■4992
--------------------------------------------------------------------------------------
function OnEvent_4992(proxy, param)
	print("OnEvent_4992begin");
	
	proxy:NotNetMessage_begin();
		--▼4992_1▼1秒経過▼
		proxy:OnKeyTime2( 4992, "OnEvent_4992_1", 1, 0, 0, once);
		--▼4992_2▼2秒経過▼
		proxy:OnKeyTime2( 4992, "OnEvent_4992_2", 2, 0, 1, once);
		--マルチ解散監視
		proxy:OnRegistFunc( 4992 , "Check_4992_PT","OnEvent_4992_PT",0,once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 4992, 1 );--ボス記録用　新仕様共用
	--２秒後には、BGMと光の壁が消えているはず
	proxy:SetEventFlag(4995 , true);

	--ホスト自キャラ　or　シングル		
	proxy:SetEventFlag(	8011, 1 );--クリアフラグON	

	--エイ通常更新を開始
	--LuaFunc_NormalOmission(proxy,822);
	
	--子エイ後始末--親と心中
	local eneID = 400;
	for eneID=400 , 411 , 1 do
		if proxy:IsAlive(eneID) == true then
			proxy:ForceDead(eneID);
		end
	end	
	
	--ブロッククリア処理へ
	--proxy:LuaCallStart( 4040, 1 );
	--新ブロッククリア処理へ
	proxy:CustomLuaCallStart( 4050, 822);
	
	--結晶トカゲリセット
	ResetTokage(proxy);
		
	print("OnEvent_4992 end");
end

--▲4992_1▲城内部扉開放:中ボス死亡後1秒▲
function OnEvent_4992_1(proxy, param)
	print("OnEvent_4992_1 begin");
	
	--ボスを倒した数を更新(数によってフラグを立てる)
	GetBossFlagCount( proxy, param );
	
--アイテム入手関連-------
	
	--ホストプレイヤーのみアイテム入手イベントに使用
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

	--宝死体(ソウル?)有効化
	proxy:SetDrawEnable( 1979 , true );
	proxy:SetColiEnable( 1979 , true );
	--宝死体(ソウル?)2有効化
	proxy:SetDrawEnable( 1978 , true );
	proxy:SetColiEnable( 1978 , true );
	
	--▼(ソウル)アイテム取得用イベント監視追加▼
	if proxy:IsCompleteEvent( 4996 ) == false then
		proxy:ValidSfx( 2600 );--SFX 有効化
		proxy:ValidSfx( 2601 );--SFX 有効化
		proxy:TreasureDispModeChange2( 1979 , true ,KANAME_SFX);--光らせる
		proxy:OnDistanceActionAttribute( 4996 , 10000 , 1979 , "OnEvent_4996" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end
------------------------

	--▼トロフィー取得判定▼
	Lua_RequestUnlockTrophy(proxy, 7);
end

--マルチ解散監視
function Check_4992_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--マルチじゃない
function OnEvent_4992_PT(proxy,param)
	print("OnEvent_4992_PT begin");
	--中ボス部屋の前後の魔法壁が消える(全プレイヤー)	
	proxy:SetColiEnable( 1996 , false );	
	proxy:SetDrawEnable( 1996 , false );
	
	--中ボス部屋魔法壁のSFX削除
	proxy:InvalidSfx( 1988 , true );	
	
	--中ボス部屋前の移動処理イベントを削除
	proxy:DeleteEvent( 1542 );--一人目が入るとき用
	proxy:DeleteEvent( 1543 );--二人目以降が入るとき用
	proxy:DeleteEvent( 4999 );--ボス戦闘開始用	
	print("OnEvent_4992_PT end");	
end


--▲4992_2▲城内部扉開放:中ボス死亡後1秒▲
function OnEvent_4992_2(proxy, param)
	print("OnEvent_4992_2 begin");
		
	--ボス戦用のBGM停止
	proxy:StopPointSE( 3 );
		
	--[[セッション解散時の魔法壁切り替え処理はグローバル?]]
	
	print("OnEvent_4992_2 end");
end

--王城３解放の表示
function OnEvent_8050(proxy,param)
	print("OnEvent_8050 begin");
	--インフォ表示
	--システムメッセージ
	--[[
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationBuffer( 10010750 );	
	]]
	proxy:RequestOpenBriefingMsgPlus(10010750,true);
	proxy:PlayTypeSE( 10000 ,SOUND_TYPE_M ,777777777 );
	print("OnEvent_8050 end");
end


--------------------------------------------------------------------------------------
--■4998■石柱にワープ■
--------------------------------------------------------------------------------------
function OnEvent_4998(proxy,param)	
	print("OnEvent_4998 begin");
		
	--セッション中ではないか？
	if proxy:IsSession() == false then
		proxy:RepeatMessage_begin();
			--▼70_1▼選択メニューの監視▼
			proxy:OnSelectMenu(4998, "OnEvent_4998_1", 10010710, 0, 2, 1979, 2, once);			
		proxy:RepeatMessage_end();
	else
		--セッション中なんで表示
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010720, 1);
		--proxy:ShowGenDialog(10010720,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1979, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end

	print("OnEvent_4998 end");
end

--▲4998_1▲選択メニューの監視▲
function OnEvent_4998_1(proxy,param)	
	print("OnEvent_4998_1 begin");	
	
	if proxy:IsSession() == false then
		if param:IsNetMessage() == true then
			proxy:PlayAnimation(10001+param:GetPlayID(),8283);
			print("OnEvent_4998_1 end");
			return;
		end
			
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1979 ,TURNSKIP_ANGLE);
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd( 4998 , 10000 , 8283 , "OnEvent_4998_2",once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(4998,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_4998_1 end");
end

--■4998_2■石柱にワープ■
function OnEvent_4998_2(proxy,param)	
	print("OnEvent_4998_2 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生
	--石柱へ戻ってきた判定のフラグを立てる
	proxy:SetEventFlag(8083, true);
	
	--完全回復要求
	proxy:RequestFullRecover();
	--古砦要石に戻る
	proxy:WarpNextStage( 1, 0, 0, 0, 1007);	
	print("OnEvent_4998_2 end");
end



--------------------------------------------------------------------------------------
--■4996■ソウル入手■
--------------------------------------------------------------------------------------
function OnEvent_4996(proxy, param)
	print("OnEvent_4996 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ 
		print("OnEvent_4996 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行
		proxy:OnKeyTime2( 4996, "OnEvent_4996_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4996 end");
end


--■4996_1■アイテム取得■
function OnEvent_4996_1(proxy, param)
	print("OnEvent_4996_1 begin");

	--アイテム取得関数--パラメータ10232参照
	proxy:GetRateItem(10232);	
	--アイテム取得関数--パラメータ10278参照
	proxy:GetRateItem(10278);	
	--アイテム取得関数--パラメータ10279参照
	proxy:GetRateItem(10279);	
	--アイテム取得関数--パラメータ10280参照
	proxy:GetRateItem(10280);	
	--アイテム取得関数--パラメータ10281参照
	proxy:GetRateItem(10281);	
	
	--アイテムを取得済み
	proxy:SetEventFlag( 4996, 1 );
	
	--宝箱シェーダーは消えません。
	--proxy:TreasureDispModeChange( 1979 , false );

	--SFXが消える
	proxy:InvalidSfx( 2600 , true );
	--proxy:InvalidSfx( 2601 , true );
	
	if proxy:IsCompleteEvent( 8035 ) == false then
		proxy:NotNetMessage_begin();
			--瞬間で表示するとメニューが先に出るので待つ
			proxy:OnKeyTime2( 8035 , "OnEvent_8035_wait",0.5 , 0 , 1, once);			
		proxy:NotNetMessage_end();
	else
		--▼要石でワープ用の監視を追加▼
		proxy:OnDistanceActionAttribute( 4998 , 10000 , 1979 , "OnEvent_4998" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	end	

	print("OnEvent_4996_1 end");
end	

--[[
	if proxy:IsCompleteEvent( 8035 ) == false then
		proxy:NotNetMessage_begin();
			--瞬間で表示するとメニューが先に出るので待つ
			proxy:OnKeyTime2( 8035 , "OnEvent_8035_wait",0.5 , 0 , 1, once);			
		proxy:NotNetMessage_end();
	else
		--▼要石でワープ用の監視を追加▼
		proxy:OnDistanceActionAttribute( 4998 , 10000 , 1979 , "OnEvent_4998" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	end	
]]
--アイテム取得後のウェイト
function OnEvent_8035_wait(proxy,param)
	print("OnEvent_8035_wait begin");
	proxy:NotNetMessage_begin();
		--インフォメニューが消えるのを待ちたい
		proxy:OnRegistFunc( 8035 , "Check_8035" , "OnEvent_8035" , 1 , ocne);
	proxy:NotNetMessage_end();
	print("OnEvent_8035_wait end");
end	
--インフォ待ち
function Check_8035(proxy)
	if proxy:IsShowMenu_InfoMenu() == true then
		return false;
	end
	return true;
end

--開放インフォ表示
function OnEvent_8035(proxy,param)
	print("OnEvent_8035 begin");
	proxy:NotNetMessage_begin();		
		OnEvent_8050(proxy,param);
		proxy:SetEventFlag( 8035 , true );
	proxy:NotNetMessage_end();
	--▼要石でワープ用の監視を追加▼	
	proxy:OnDistanceActionAttribute( 4998 , 10000 , 1979 , "OnEvent_4998" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	print("OnEvent_8035 end");
end


--[[
--------------------------------------------------------------------------------------
--■5000■ボスHP・子エイ死亡監視■
--------------------------------------------------------------------------------------
--死亡監視の統合
function CheckDeadCount(proxy,eneID)
	print("OnEvent_5000_",eneID," begin");	
	local deadCount = 0;
	local ID = 400;	
		
	for ID = 400, 411, 1 do
		if proxy:IsAlive(ID) == false then
			deadCount = deadCount + 1;
		end
	end
		
	if deadCount >= BeastChildDeadCount then
		proxy:LuaCallStart(5001,1);
	end	
	print("OnEvent_5000_",eneID," end");	
end
]]

--[[
--子エイの死亡監視
function OnEvent_5000_400(proxy,param) CheckDeadCount(proxy,400); end--ID400
function OnEvent_5000_401(proxy,param) CheckDeadCount(proxy,401); end--ID401
function OnEvent_5000_402(proxy,param) CheckDeadCount(proxy,402); end--ID402
function OnEvent_5000_403(proxy,param) CheckDeadCount(proxy,403); end--ID403
function OnEvent_5000_404(proxy,param) CheckDeadCount(proxy,404); end--ID404
function OnEvent_5000_405(proxy,param) CheckDeadCount(proxy,405); end--ID405
function OnEvent_5000_406(proxy,param) CheckDeadCount(proxy,406); end--ID406
function OnEvent_5000_407(proxy,param) CheckDeadCount(proxy,407); end--ID407
function OnEvent_5000_408(proxy,param) CheckDeadCount(proxy,408); end--ID408
function OnEvent_5000_409(proxy,param) CheckDeadCount(proxy,409); end--ID409
function OnEvent_5000_410(proxy,param) CheckDeadCount(proxy,410); end--ID410
function OnEvent_5000_411(proxy,param) CheckDeadCount(proxy,411); end--ID411

--エイのHPの割合監視
function OnEvent_5000_HP(proxy,param)
	print("OnEvent_5000_HP begin");
	proxy:LuaCallStart(5001,1);
	print("OnEvent_5000_HP end");
end
]]

--[[
--------------------------------------------------------------------------------------
--■5001■ボス突撃ポリ劇■
--------------------------------------------------------------------------------------
--ポリ劇の起動
function OnEvent_5001(proxy,param)
	print("OnEvent_5001 begin");
	proxy:DeleteEvent(5000);
	proxy:RequestRemo(30301,REMO_FLAG,5001,1);
	proxy:SetEventFlag(5001,true);
	print("OnEvent_5001 end");
end

--ポリ劇のフェードアウト
function OnEvent_5001_RemoStart(proxy,param)
	print("OnEvent_5001_RemoStart begin");
	--飛行関連アニメ監視削除
	proxy:DeleteEvent(5030);
	print("OnEvent_5001_RemoStart end");
end

--ポリ劇のフェードイン
function OnEvent_5001_RemoFinish(proxy,param)
	print("OnEvent_5001_RemoFinish begin");
	--ボス切り替え初期化
	BossInit_StormOfBeast2(proxy,param);
	print("OnEvent_5001_RemoFinish end");
end
]]






--------------------------------------------------------------------------------------
--↓未整理　↑整理済み function 
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--■1544■ボスカメラ設定■
--------------------------------------------------------------------------------------
function OnEvent_1544(proxy,param)
	--print("OnEvent_1544 begin");
	--ボスが死んでいない　かつ　ボスとの戦闘を開始している
	if proxy:IsCompleteEvent( 4992 ) == false and proxy:IsCompleteEvent( 4999 ) == true then
		--ボス戦　非ロックカメラ
		proxy:SetCamModeParamTargetId(3031);
		--ボス戦　ロックカメラ
		proxy:SetCamModeParamTargetIdForBossLock(3030);
	end
	--print("OnEvent_1544 end");
end


--------------------------------------------------------------------------------------
--■1590■強化ストームブリンガー設定■
--------------------------------------------------------------------------------------
function OnEvent_1590(proxy,param)
	--ボスが死んでいない　かつ　ボスとの戦闘を開始している
	--if proxy:IsCompleteEvent( 4992 ) == false and proxy:IsCompleteEvent( 4999 ) == true then
		local isHasWepon = false;		
		if proxy:GetRightCurrentWeponId() == 21100 then isHasWepon = true end;		
		--print("HadWepId",proxy:GetRightCurrentWeponId());		
		--print("isHasWepon ",isHasWepon);
		--判定した結果をそのまま設定
		proxy:SetIsUseLongLongSword( isHasWepon );		
	--end
end

--ストームブリンガー終了
function OnEvent_1590_out(proxy,param)
	print("OnEvent_1590_out begin");
	proxy:SetIsUseLongLongSword( false );		
	print("OnEvent_1590_out end");
end



--------------------------------------------------------------------------------------
--マルチになった時にホストじゃ無かったら■無し
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end




--------------------------------------------------------------------------------------
--徘徊デーモンの登場■??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ)
function PlayerDeath_m03_03_00_00(proxy, param)
	print("PlayerDeath_m03_03_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m03_03_00_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。
	
	print("PlayerDeath_m03_03_00_00");
end
	
--▼グローバルの血文字復活から呼ばれる(ソロ)
function PlayerRevive_m03_03_00_00(proxy,param)
	print("PlayerRevive_m03_03_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m03_03_00_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。
	
	print("PlayerRevive_m03_03_00_00");
end


--------------------------------------------------------------------------------------
--1570■砦１・２の子エイの無効化
--------------------------------------------------------------------------------------
function OnEvent_1570(proxy,param)
	--if proxy:IsClient() == false then
	print("OnEvent_1570 begin");
	proxy:LuaCallStart( 1570 , 0 );
	print("OnEvent_1570 end");
	--end
end

function OnEvent_1570_1(proxy,param)
	print("OnEvent_1570_1 begin");
	for eneid = 388 , 399 , 1 do
		InvalidCharactor( proxy , eneid );
	end
	proxy:SetEventFlag( 1570 ,true );
	print("OnEvent_1570_1 end");
end

--------------------------------------------------------------------------------------
--1571■砦１・２の子エイの有効化
--------------------------------------------------------------------------------------
function OnEvent_1571(proxy,param)
	--if proxy:IsClient() == false then
	print("OnEvent_1571 begin");
	proxy:LuaCallStart( 1571 , 0 );
	print("OnEvent_1571 end");
	--end
end

function OnEvent_1571_1(proxy,param)
	print("OnEvent_1571_1 begin");
	for eneid = 388 , 399 , 1 do
		ValidCharactor( proxy , eneid );
	end
	proxy:SetEventFlag( 1570 ,false );
	print("OnEvent_1571_1 end");
end


-----------------------------------------------------------------------------
--■1580■結晶トカゲイベント4
-----------------------------------------------------------------------------
function OnEvent_1580(proxy,param)
	print("OnEvent_1580 begin");
	proxy:SetEventFlag( 1580 , true );
	proxy:DeleteEvent( 1580 );
	print("OnEvent_1580 end");
end

-----------------------------------------------------------------------------
--■1582■結晶トカゲイベント5
-----------------------------------------------------------------------------
function OnEvent_1582(proxy,param)
	print("OnEvent_1582 begin");
	proxy:SetEventFlag( 1582 , true );
	proxy:DeleteEvent( 1582 );
	print("OnEvent_1582 end");
end




--------------------------------------------------------------------------------------
--ストームブリンガー■1591
--------------------------------------------------------------------------------------
function OnEvent_1591(proxy,param)
	if param:IsNetMessage() == false then	
	print("OnEvent_1591 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		--アニメ
		proxy:PlayAnimation( 10000 , 8290);
		proxy:PlayAnimation( 1610 , 1);	
		proxy:OnKeyTime2( 1591 , "OnEvent_1591_0",0.01,0,0,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	print("OnEvent_1591 end");
	end
end

function OnEvent_1591_0(proxy,param)
	print("OnEvent_1591_0 begin");
	--if proxy:IsPlayerStay(10000) == true then
	if proxy:IsEventAnim( 10000 , 8290 ) == true then		
		proxy:LuaCallStart( 1591, 2);			
	else
		proxy:ForcePlayAnimation( 1610 , 0);	
	end
	print("OnEvent_1591_0 end");
end

--■1591_1■アイテム取得■
function OnEvent_1591_1(proxy,param)
	print("OnEvent_1591_1 begin");
	--アイテム取得関数--パラメータ10419参照
	proxy:GetRateItem(10217);	
	
	--アイテムを取得済み
	proxy:SetEventFlag( 1591, true );
	
	--OBJを消すためのイベント配信
	proxy:LuaCallStart( 1591, 1);

	print("OnEvent_1591_1 end");
end

--■1591_2■剣OBJ非表示用■
function OnEvent_1591_2(proxy,param)
	print("OnEvent_1591_2 begin");
	--オブジェが消える
	proxy:SetDrawEnable( 1610 , false );--ひとまず描画だけOFF
	proxy:SetColiEnable( 1610 , false );--当たりはあるのは不明(現状ではないようなので消さない)
	
	proxy:DeleteEvent( 1591 );
	print("OnEvent_1591_2 end");
end

--アニメの同期監視
function OnEvent_1591_3(proxy,param)
	print("OnEvent_1591_3 begin");
	proxy:TreasureDispModeChange2( 1610, false ,KEN_SFX);
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8290 ) == true then--新しいアニメ 
		proxy:PlayAnimation( 1610 , 1);	
		print("OnEvent_1591_3 end");
		return true;
	end		
	
	--剣にワープ
	proxy:WarpDmy( LOCAL_PLAYER , 1610 , 191 );
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1591 , LOCAL_PLAYER , 8290 , "OnEvent_1591_1", once);
	proxy:NotNetMessage_end();	
	print("OnEvent_1591_3 end");	
end
