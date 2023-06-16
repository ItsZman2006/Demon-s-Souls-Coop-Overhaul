once = 1;
everytime = 0;


--職業テスト用
test_flag_solder    = 15000;
test_flag_magi_kure = 15001;
test_flag_hanta     = 15002;

name_list = {"一般兵士","マジシャン","ハンタ","クレリック"};

now_job_type_SOL  = 1;
now_job_type_MAJI = 2;
now_job_type_HAN  = 3;
now_job_type_KURE = 4;


--------------------------------------------------------------------------------------
--初期化
--------------------------------------------------------------------------------------
function Initialize_m08_01_00_00(proxy)
	print("Initialize m08_01_00_00 begin");

--■14209■チュートリアル死亡■
	proxy:SetEventFlag(14209,true);--砦用死亡分岐フラグON	
	
--■14210■ハシゴA(斜め10度)降り■
	--proxy:OnActionEventRegion(14210, 2200, "OnEvent_14210", LadderAngle_A, HELPID_DOWN, everytime);

--■14215■ハシゴA(斜め10度)昇り■
	--proxy:OnActionEventRegion(14215, 2201, "OnEvent_14215", LadderAngle_A, HELPID_UP,   everytime);

--■14225■砦天井崩落■
	--proxy:OnRegionJustIn( 14225, 10000, 2300, "OnEvent_14225", once);
	
	--ポリ劇開始のハンドラ
	--proxy:LuaCall( 14225, REMO_START , "OnEvent_14225_RemoStart",once);
	--proxy:LuaCall( 14225, REMO_FINISH , "OnEvent_14225_RemoFinish",once);
	

--■14320■血文字で復活■
--(死んだときに追加)

--■14200■インフォ表示：強攻撃■
	proxy:OnRegionJustIn( 14200 , 10000 , 2240 , "OnEvent_14200" , once );
		
--■14212■インフォ表示：パリィ■
	proxy:OnRegionJustIn( 14212 , 10000 , 2235 , "OnEvent_14212" , once );
	
--■14213■インフォ表示：両手持ち替え■
	proxy:OnRegionJustIn( 14213 , 10000 , 2236 , "OnEvent_14213" , once );
	
--■14005■光る死体■
	proxy:OnRegionJustIn( 14005 , 10000 , 2310 , "OnEvent_14005" , once );
	
--■14006■アイテム使用■
	proxy:OnRegionJustIn( 14006 , 10000 , 2311 , "OnEvent_14006" , once );
	
--■14214■インフォ表示：ＳＯＳサインの書き方■
	--proxy:OnRegionJustIn( 14214 , 10000 , 2237 , "OnEvent_14214" , everytime );--[[everytime]]
	
--■14221■インフォ表示：他人のSOS■
	--proxy:OnRegionJustIn( 14221 , 10000 , 2239 , "OnEvent_14221" , everytime );--[[everytime]]
	
--■14241■ワープする■
	SingleReset( proxy, 14241 );--とてつもなく念のため…	
	
--■14201■インフォ表示：武器チェンジ（ソルジャー）■
	proxy:OnRegionJustIn( 14201 , 10000 , 2241 , "OnEvent_14201" , once );
	
--■14325■インフォ表示：左手攻撃■
	proxy:OnRegionJustIn( 14325 , 10000 , 2238 , "OnEvent_14325" , once );
	
	
	
--■14202■インフォ表示：武器チェンジ（マジシャンorクレリック）■
	proxy:OnRegionJustIn( 14202 , 10000 , 2242 , "OnEvent_14202" , once );
	
--■14203■インフォ表示：魔法■
	proxy:OnRegionJustIn( 14203 , 10000 , 2243 , "OnEvent_14203" , once );
	
--■14208■インフォ表示：魔法選択■
	proxy:OnRegionJustIn( 14208 , 10000 , 2249 , "OnEvent_14208" , once );
	
	
--■14204■インフォ表示：武器チェンジ（ハンター）■
	proxy:OnRegionJustIn( 14204 , 10000 , 2244 , "OnEvent_14204" , once );
	
--■14205■インフォ表示：両手持ち替え促す■
	proxy:OnRegionJustIn( 14205 , 10000 , 2245 , "OnEvent_14205" , once );
	
--■14206■インフォ表示：弓射撃■
	proxy:OnRegionJustIn( 14206 , 10000 , 2246 , "OnEvent_14206" , once );
	
--■14207■インフォ表示：精密射撃モード■
	proxy:OnRegionJustIn( 14207 , 10000 , 2247 , "OnEvent_14207" , once );
	
--■14211■インフォ表示：精密射撃モード解除■
--(14207から連動)


--■14350■インフォ表示：奇跡■
	proxy:OnRegionJustIn( 14350 , 10000 , 2250 , "OnEvent_14350" , once);
	
--■14351■インフォ表示：奇跡選択■
	proxy:OnRegionJustIn( 14351 , 10000 , 2251 , "OnEvent_14351" , once);

	
	
--■14305■インフォ表示：魔法扉■
	proxy:OnRegionJustIn( 14305 , 10000 , 2248 , "OnEvent_14305" , once );

--■14306■インフォ表示：光の扉■
	proxy:OnRegionJustIn( 14306 , 10000 , 2312 , "OnEvent_14306" , once );
	
--■14291■光の壁■
	if proxy:IsCompleteEvent( 14291 ) == false then
		proxy:OnDistanceAction( 14291 , 10000 , 1271 , "OnEvent_14291" , 1.5, 10010403 , 0 , 90 , once );
	else
		proxy:SetDrawEnable( 1271 , false );--魔法壁描画OFF
		proxy:SetColiEnable( 1271 , false );--魔法壁当たりOFF		
		proxy:InvalidSfx( 2275 , false );--SFX OFF
	end

--■14231■ボス部屋に入る■
	if proxy:IsCompleteEvent( 14233 ) == false then
		SingleReset(proxy , 14232 );
		SingleReset(proxy , 14231 );
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き)
		proxy:LuaCall( 14232, 1, "OnEvent_14232_1", everytime );
		--▽2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCall( 14232 , 5 , "OnEvent_14231_GO_TO_IN" , everytime );
		--▽フラグセット(同期用)
		proxy:LuaCall( 14232 , 6 , "OnEvent_14231_flag_set" , everytime );
		
		--誰かがボス前扉をまだ通過していない
		if proxy:IsCompleteEvent( 14231 ) == false then	
			
			--<追加>ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。
			--SingleReset(proxy, 14231);			
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--▼14231▼中に入るためのイベントを追加▼
				proxy:OnPlayerActionInRegionAttribute( 14231, 2290, "OnEvent_14231", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --グレイゴーストできたときようにいると思われる。
		
			proxy:NotNetMessage_begin();
				--▼14232▼中に入るためのイベントを追加▼--ハンドラは上と同じ
				proxy:OnPlayerActionInRegion( 14232, 2290, "OnEvent_14231", HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();		
		end
	end

--■14234■ボスが動き出す■
--■14232■ボスBGM再生■
	if proxy:IsCompleteEvent( 14233 ) == false then
		SingleReset( proxy, 14234 );
		--SingleReset( proxy, 14232 );
		proxy:OnRegionJustIn( 14234 , 10000 , 2291 , "OnEvent_14234" , once );
	end


--■14233■ボス死亡処理■
	proxy:AddFieldInsFilter( 300 );
	if proxy:IsCompleteEvent( 14233 ) == false then
		proxy:OnCharacterDead( 14233 , 300 , "OnEvent_14233" , once );
		--■ボス関連の初期化処理
		if proxy:IsCompleteEvent( 14301 ) ==false then	
			--宝(ソウル?)
			proxy:SetDrawEnable( 1310 , false );
			proxy:SetColiEnable( 1310 , false );			
			--剣表示OFF
			proxy:SetDrawEnable( 1311 , false );
			proxy:SetColiEnable( 1311 , false );			
			--SFX 無効化
			proxy:InvalidSfx( 1290 , false );--ソウル用
			proxy:InvalidSfx( 1291 , false );--ボスアイテム用		
		end
	else
		InvalidCharactor( proxy , 300 );
		--中ボス部屋の魔法壁が消える
		proxy:SetColiEnable( 1272 , false );
		proxy:SetDrawEnable( 1272 , false );
		proxy:InvalidSfx( 2274, true );
		--▼(ソウル)アイテム取得用イベント監視追加▼
		if proxy:IsCompleteEvent( 14301 ) == false then
			proxy:ValidSfx( 1290 );--光の粒子
			proxy:ValidSfx( 1291 );--SFX 有効化
			--proxy:TreasureDispModeChange2( 1310 , true ,KANAME_SFX);--光らせる		
			proxy:TreasureDispModeChange2( 1311 , true ,KANAME_SFX);--光らせる
			proxy:OnDistanceActionAttribute( 14301 , 10000 , 1310 , "OnEvent_14301" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_NOSESSION, once );
		else
			proxy:InvalidSfx( 1290 ,false);--光の粒子
			--proxy:InvalidSfx( 1291 ,false);--SFX 有効化
			proxy:OnDistanceAction( 14242 , 10000 , 1311 , "OnEvent_14242" , WarpGimmickDist_A , 10010180 , 0 , 180, everytime );
		end
	end	
	
--■14230■ボスカメラ切り替え■
	proxy:OnRegionIn( 14230 , 10000, 2292 , "OnEvent_14230" , everytime );
	

--■??■徘徊デーモンの登場■ハンドラ登録
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。
		proxy:LuaCall( 4000, 100, "PlayerDeath_m08_01_00_00", everytime );
		--プレイヤーが復活した時にキックされます。
		proxy:LuaCall( 4032, 100, "PlayerRevive_m08_01_00_00", everytime );
	proxy:NotNetMessage_end();
	
	--	proxy:PlayerRecover();--プレイヤー全回復 全回復しない･･･
	proxy:SetHp( 10000 , 1.0 );
	proxy:SetDeadMode( 10000 , true );--プレイヤーは死なない
	proxy:EnableLogic( 300 , false );--中ボスロジックOFF
	
	--[[
	--グレイゴーストになったとき(岩天井崩落で死んで読み込みを通したとき)
	if proxy:IsCompleteEvent( 14226 ) == true then

		--▼チュートリアル用の自分の血文字削除関数
		proxy:InvalidMyBloodMarkInfo_Tutorial();
	
		--▼(似非)血文字復活のイベント登録▼
		proxy:OnKeyTime2( 14227 , "OnEvent_14227" , 0.0 , 0 , 1 , once );
	
	--生存状態のとき
	else
		proxy:InvalidSfx( 2218 , false );--自分の血文字を表示OFF
	end
	]]
	
	
	--▼イベント再現(正規のグレイゴーストになるために読み込みを通すため)
	--[[
	--岩天井崩落
	if proxy:IsCompleteEvent( 14225 ) == true then

		proxy:ReconstructBreak( 1300 , 1 );--初期化タイミングを遅らせたら壊れた
	end
	]]
	
	--■14410■徘徊ゴースト始動■
	proxy:SetDrawEnable( 401 , false );
	proxy:SetDrawEnable( 402 , false );
	proxy:SetDrawEnable( 403 , false );
	proxy:SetDrawEnable( 404 , false );
	proxy:OnRegionJustIn( 14410 , 10000 , 2291 , "OnEvent_14410" , once);


	
	
	--職業別イベントテスト用
	
	--デフォルトはソルジャー
	--now_job = test_flag_solder;
	
	now_job_type = JobCheck(proxy, now_job);
	
	now_job_name = name_list[now_job_type];
	
	print("今の職業は"..now_job_name.."です");	
	
	proxy:OnKeyTime2(999991,"Second_Initialize_m08_01_00_00",0.1,0,0,once);
	
	print("Initialize_m08_01_00_00 end");
end

--１フレーム後の初期化
function Second_Initialize_m08_01_00_00(proxy,param)
	print("Second_Initialize_m08_01_00_00 begin");
	--職業用ヒント血文字無効
	now_job_type = JobCheck(proxy, now_job);
	if now_job_type == now_job_type_SOL then
		--戦士なら
		print("戦士以外の血文字無効");
		proxy:InvalidHintMsgId(9200);
		proxy:InvalidHintMsgId(9300);
		proxy:InvalidHintMsgId(9400);
		proxy:InvalidHintMsgId(9500);
	elseif now_job_type == now_job_type_MAJI then
		--魔法なら		
		print("魔法以外の血文字無効");
		proxy:InvalidHintMsgId(9300);
		proxy:InvalidHintMsgId(9400);
		proxy:InvalidHintMsgId(9500);
	elseif now_job_type == now_job_type_HAN then
		--ハンターなら
		print("ハンター以外の血文字無効");
		proxy:InvalidHintMsgId(9200);
		proxy:InvalidHintMsgId(9300);		
	else
		--それ以外なら
		print("神職以外の血文字無効");
		proxy:InvalidHintMsgId(9200);		
		proxy:InvalidHintMsgId(9400);
		proxy:InvalidHintMsgId(9500);
	end
	print("Second_Initialize_m08_01_00_00 end");
end

--------------------------------------------------------------------------------------
--マルチになった時にホストじゃ無かったら■無し
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end

---------------------------------
--PCのジョブが何かを判定する関数
---------------------------------
function JobCheck(proxy, now_job_style)
	--PCのジョブのタイプが戦士系だった場合
	local job = now_job_type_SOL;
	
	if proxy:IsJobType( JOB_MERCENARY ) == true then
		--print("傭兵");
		job = now_job_type_SOL;
	end
	if proxy:IsJobType( JOB_LOW_SOLDIER ) == true then
		--print("下級兵士");
		job = now_job_type_SOL;
	end
	if proxy:IsJobType( JOB_LOW_KNIGHT ) == true then
		--print("下級騎士");
		job = now_job_type_SOL;
	end
	if proxy:IsJobType( JOB_NEET ) == true then
		--print("ニート王");
		job = now_job_type_SOL;
	end
	   
	--PCのジョブのタイプがハンター系だった場合	
	if proxy:IsJobType( JOB_HUNTER ) == true then	
		--print("狩人");
		job = now_job_type_HAN;
	end	
	if proxy:IsJobType( JOB_THIEF ) == true then
		--print("盗賊");
		job = now_job_type_HAN;
	end	
		
	--PCのジョブのタイプが魔術師	
	if proxy:IsJobType( JOB_SHAMAN ) == true then
		--print("魔術師");
		job = now_job_type_MAJI;
	end
	if proxy:IsJobType( JOB_NOBLEMAN ) == true then
		--print("貴族");
		job = now_job_type_MAJI;
	end
	
	--PCのジョブのタイプが僧侶系だった場合
	if proxy:IsJobType( JOB_TEMPLE_KNIGHT ) == true then
		--print("神殿騎士");
		job = now_job_type_KURE;
	end
	if proxy:IsJobType( JOB_CLERIC ) == true then
		--print("聖職者");
		job = now_job_type_KURE;
	end
	
	return job;
end

--[[
--------------------------------------------------------------------------------------
--砦天井崩落■14225
--------------------------------------------------------------------------------------

--■14225■砦天井崩落
function OnEvent_14225(proxy, param)
	print("OnEvent_14225 begin");
	
	--岩オブジェを破片に切り替え
	--proxy:ChangeModel(1300, 1);
	--proxy:SetBrokenPiece(1300);
	--破壊SE再生
	--proxy:PlayObjectSE(1300,22400000);

	--プレイヤー行動制限
	--proxy:EnableLogic( 10000 , false );
	proxy:StopPlayer();
	
	--proxy:SetSuperArmor( 10000 , true );
	
	--▼14226▼数秒後▼
	--proxy:OnKeyTime2( 14226 , "OnEvent_14226" , 2.0 , 0 , 1 , once );
	proxy:RequestRemo( 80100 , REMO_FLAG,14225,1);

	--フラグON
	proxy:SetEventFlag( 14225, 1 );
	
	print("OnEvent_14225 end");
end

function OnEvent_14225_RemoStart(proxy,param)
	print("OnEvent_14225_RemoStart begin");
	InvalidCharactor( proxy, 10000);
	print("OnEvent_14225_RemoStart end");
end

function OnEvent_14225_RemoFinish(proxy,param)
	print("OnEvent_14225_RemoFinish begin");
	--▼14226▼数秒後▼
	--proxy:OnKeyTime2( 14226 , "OnEvent_14226_1" , 2.0 , 0 , 1 , once );
	OnEvent_14226_2(proxy,param);
	print("OnEvent_14225_RemoFinish end");
end

--[[
--▲14226▲数秒後▲
function OnEvent_14226(proxy, param)
	print("OnEvent_14226 begin");

	proxy:PlayAnimation( 10000 , 6000 );--プレイヤー死亡アニメ(生存→グレイ)
	
	--▼14226_1▼プレイヤー死亡アニメ終了▼
	proxy:OnChrAnimEnd( 14226 , 10000 , 6000 , "OnEvent_14226_1" , once );
	
	print("OnEvent_14226 end");
end
]]

--▲14226_1▲プレイヤー死亡アニメ終了▲
function OnEvent_14226_1(proxy, param)
	print("OnEvent_14226_1 begin");

	--proxy:PlayLoopAnimation( 10000 , 6050 );--プレイヤー死亡待機アニメ
	
	--▼血文字メニュー終了▼
	--proxy:OnBloodMenuClose(14226, "OnEvent_14226_2",300.0, once);
	--OnEvent_14226_2(proxy,param);
	
	print("OnEvent_14226_1 end");
end

--▲14226_2▲血文字メニュー終了▲
function OnEvent_14226_2(proxy, param)
	print("OnEvent_14226_2 begin");

	--（似非）血文字・SOS SFX表示切替
	
	proxy:ValidSfx( 2218 );
	proxy:InvalidSfx( 2216 , false );
	
	--プレイヤーに制限をかけていたのを解除
	
	proxy:StopLoopAnimation( 10000 );--死亡待機アニメをやめる
	proxy:EnableLogic( 10000 , true );--行動制限解除	
	proxy:SetSuperArmor( 10000 , false );
	
	--グレイゴーストになる(読み込みを通す必要がある)
	
	--現在のマップと同じIDを次マップIDとして設定
	proxy:SetDefaultMapUid(-1);
	--ワープを行う
	proxy:WarpNextStageKick();
	--グレイゴースト化
	proxy:SetChrTypeDataGrey();
	proxy:SetHp( 10000 , 1.0 );--HP全快?(リカバーで全快にならなかったので･･･)
	
--[[--読み込みタイミングで呼ばれるように変更
	--▼14227▼数秒後▼
	proxy:OnKeyTime2( 14227 , "OnEvent_14227" , 2.0 , 0 , 1 , once );
]]	
	proxy:SetEventFlag( 14226 , 1 );
	
	print("OnEvent_14226_2 end");
end
]]

--[[
--▲14227▲数秒後▲
function OnEvent_14227(proxy, param)
	print("OnEvent_14227 begin")

	--インフォメーションメッセージの表示
	Display_InfomationMenu_2(proxy, 0, -1, 30, 81001400, 1, -1, 30, 81001401, 7);
	--Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14227 , 1 );
	
	--▼(似非)血文字復活イベント監視追加▼
	proxy:OnPlayerActionInRegion( 14320 , 2217 , "OnEvent_14320" , 50000200 , everytime );--[[everytime]]
	
	print("OnEvent_14227 end");
end
]]

--[[
--------------------------------------------------------------------------------------
--血文字復活■14320
--------------------------------------------------------------------------------------

--■14320■血文字復活
function OnEvent_14320(proxy, param)
	print("OnEvent_14320 begin");
	
	--岩天井崩落(14227)が最後まで終わっている(=グレイゴーストのとき)
	if proxy:IsCompleteEvent( 14227 ) == true then
	
		--システムメッセージ(血文字復活しました)
		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
		proxy:AddInfomationBuffer(20000020);
		
		--復活するのでペナルティで減少したパラメータを元に戻す(最大値のみ)
		proxy:EraseEventSpecialEffect( 10000, 101 );
		proxy:PlayerParamRecover();
		proxy:ResetEventQwcSpEffect(LOCAL_PLAYER);
	
		--▼14321▼数秒後に復活▼
		proxy:OnKeyTime2( 14321 , "OnEvent_14321" , 3.0 , 0 , 1 , once );
		
		proxy:SetEventFlag( 14320, 1 );--フラグON
		proxy:DeleteEvent( 14320 );--everytimeなので消す
	end

	print("OnEvent_14320 end");
end


--▲14321▲数秒後に復活▲
function OnEvent_14321(proxy ,param)
	print("OnEvent_14321 begin");

	--復活するのでペナルティで減少したパラメータを元に戻す(最大値のみ)
	proxy:PlayerParamRecover();

	--キャラクタのタイプを生存に変更(再読み込みを通さない為、これで仮対応)正規はプレイヤー専用の生存タイプ設定メソッドで対応
	proxy:SetChrType( 10000, 0 );
		
	--自分の血文字非表示(&SOS魔法が消える)
	proxy:InvalidMyBloodMarkInfo();
	
	--(似非)血文字･SOS SFX表示切替
	proxy:InvalidSfx( 2218 , false );
	proxy:ValidSfx( 2216 );
	
	proxy:SetEventFlag( 14321 , 1 );

	print("OnEvent_14321 end");
end
]]

--[[
--------------------------------------------------------------------------------------
--ハシゴB降り■14210
--------------------------------------------------------------------------------------
--■14210■ハシゴB降りスタート■
function OnEvent_14210(proxy, param)
	print("OnEvent_14210 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_14210 end");
		return;
	end

	--はしご降りに必要な前処理--
	proxy:BeginAction(10000,2,2,2);				--ホバー移動モードに移行
	proxy:HoverMoveValDmy(10000,1204,192,LadderTime_A);--移動位置(192)に0.5秒でホバー移動
	proxy:SetEventCommand(10000,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る
--	proxy:SetKeepCommandIndex(10000, 4, 1, 3.0 );
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行
		proxy:OnKeyTime2(14210,"OnEvent_14210_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理)
		proxy:OnKeyTime2(14210,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_14210 end");
end

--■14210_1■ハシゴB降りスタート:ホバー移動終了■
function OnEvent_14210_1(proxy, param)
	print("OnEvent_14210_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_14210_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	proxy:BeginAction(10000,1,7,6);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_14210_1 end");
end
]]

--[[
--------------------------------------------------------------------------------------
--ハシゴB昇り■14215
--------------------------------------------------------------------------------------
--■14215■ハシゴB昇りスタート■
function OnEvent_14215(proxy, param)
	print("OnEvent_14215 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_14215 end");
		return;
	end
	
	--はしご昇りに必要な前処理--
	proxy:BeginAction(10000,2,-1,1);			--ホバー移動モードに移行
	proxy:HoverMoveValDmy(10000,1204,191,LadderTime_A);--移動位置(191)に0.5秒でホバー移動
	proxy:SetEventCommand(10000,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る
--	proxy:SetKeepCommandIndex(10000, 4, 1, 3.0 );
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご昇りスタートイベントを発行
		proxy:OnKeyTime2(14215,"OnEvent_14215_1",LadderTime_A,0,0,once);
		--はしご昇り用の関数を1秒間発行(イベントメニューの中断処理?)
		proxy:OnKeyTime2(14215,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_14215 end");
end

--■14215_1■ハシゴA昇りスタート:ホバー移動終了■
function OnEvent_14215_1(proxy, param)
	print("OnEvent_14215_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_14215_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	proxy:BeginAction(10000,1,-1,6);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_14215_1 end");
end
]]


--------------------------------------------------------------------------------------
--マップ移動（→溶岩広場）■14241
--------------------------------------------------------------------------------------

--■14241■マップ移動（→溶岩広場）
function OnEvent_14241(proxy, param)
	print("OnEvent_14241 begin");

--・たどり着いたＰＣのみ、砦から溶岩広場（m08_02_00_00）の指定位置に移動
--・移動先（m08_02_00_00）の対応キャライベントID
--　ＰＣ（0）→キャラ（30）
--　ＰＣ（1）→キャラ（31）
--　ＰＣ（2）→キャラ（32）
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage( 8,02,00,00, 30); end
	if playerId ==1 then proxy:WarpNextStage( 8,02,00,00, 31); end
	if playerId ==2 then proxy:WarpNextStage( 8,02,00,00, 32); end
	if playerId ==3 then proxy:WarpNextStage( 8,02,00,00, 33); end

	--※移動するキャラクターは、移動時にパッと消してしまいます
	
	proxy:SetEventFlag( 14241, true );
	
	print("OnEvent_14241 end");
end


--------------------------------------------------------------------------------------
--徘徊デーモンの登場■??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ)
function PlayerDeath_m08_01_00_00(proxy, param)
	print("PlayerDeath_m08_01_00_00");
	print("PlayerDeath_m08_01_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ)
function PlayerRevive_m08_01_00_00(proxy,param)
	print("PlayerRevive_m08_01_00_00");	
	print("PlayerRevive_m08_01_00_00");
end



--------------------------------------------------------------------------------------
--インフォ表示：強攻撃■14200
--------------------------------------------------------------------------------------

--■14200■インフォ表示：強攻撃■
function OnEvent_14200(proxy , param)
	print("OnEvent_14200 begin");
	
	--インフォメーションメッセージの表示
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80000400, 1, -1, 30, 80000401, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14200 , 1 );	
	
	print("OnEvent_14200 end");
end



--------------------------------------------------------------------------------------
--インフォ表示：パリィ■14212
--------------------------------------------------------------------------------------

--■14212■インフォ表示：パリィ■
function OnEvent_14212(proxy , param)
	print("OnEvent_14212 begin");
	
	--インフォメーションメッセージの表示
	Display_InfomationMenu_2(proxy, 0, -1, 30, 81000000, 1, -1, 30, 81000001, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14212 , 1 );
	
	print("OnEvent_14212 end");
end


--------------------------------------------------------------------------------------
--インフォ表示：両手持ち替え■14213
--------------------------------------------------------------------------------------

--■14213■インフォ表示：両手持ち替え■
function OnEvent_14213(proxy , param)
	print("OnEvent_14213 begin");
	
	--インフォメーションメッセージの表示
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80000900, 1, -1, 30, 80000901, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14213 , 1 );
	
	print("OnEvent_14213 end");
end


--------------------------------------------------------------------------------------
--インフォ表示：光る死体■14005
--------------------------------------------------------------------------------------
function OnEvent_14005(proxy,param)
	print("OnEvent_14005 begin");
	
	--インフォメーションメッセージの表示
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80000500, 1, -1, 30, 80000501, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14005 , 1 );
	
	print("OnEvent_14005 end");
end


--------------------------------------------------------------------------------------
--インフォ表示：アイテム使用■14006
--------------------------------------------------------------------------------------
function OnEvent_14006(proxy,param)
	print("OnEvent_14006 begin");
	
	--インフォメーションメッセージの表示
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80000600, 1, -1, 30, 80000601, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14006 , 1 );
	
	print("OnEvent_14006 end");
end


--[[
--------------------------------------------------------------------------------------
--インフォ表示：ＳＯＳサインの書き方■14214
--------------------------------------------------------------------------------------

--■14214■インフォ表示：ＳＯＳサインの書き方■
function OnEvent_14214(proxy , param)
	print("OnEvent_14214 begin");
	
	--岩天井崩落(14227)が終わっている
	if proxy:IsCompleteEvent( 14227 ) == true then
	
		--インフォメーションメッセージの表示
		Display_InfomationMenu_2(proxy, 0, -1, 30, 83000000, 1, -1, 30, 83000001, 7);
		--Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14214 , 1 );
		proxy:DeleteEvent( 14214 );--everytimeなので消す
	end
	
	print("OnEvent_14214 end");
end
]]

--[[
--------------------------------------------------------------------------------------
--インフォ表示：他人のSOS■14221
--------------------------------------------------------------------------------------

--■14221■インフォ表示：他人のSOS■
function OnEvent_14221(proxy , param)
	print("OnEvent_14221 begin");
	
	--岩天井崩落(14227)が終わっていない or 血文字で復活(14320)が終わっている
	if proxy:IsCompleteEvent( 14227 ) == false or
	   proxy:IsCompleteEvent( 14320 ) == true  then

		--インフォメーションメッセージの表示
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81001300, 1, -1, 30, 81001301, 7);
		--Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14221 , 1 );
		proxy:DeleteEvent( 14221 );--everytimeなので消す
	end
	
	print("OnEvent_14221 end");
end
]]



--------------------------------------------------------------------------------------
--インフォ表示：武器チェンジ（ソルジャー）■14201
--------------------------------------------------------------------------------------

--■14201■インフォ表示：武器チェンジ（ソルジャー）■
function OnEvent_14201(proxy , param)
	print("OnEvent_14201 begin");
	
	now_job_type = JobCheck(proxy, now_job);
	
	--ソルジャーのときだけ表示(デバック用の判定追加)
	if now_job_type == now_job_type_SOL then
	
		--インフォメーションメッセージの表示
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81000100, 1, -1, 30, 81000101, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14201 , 1 );
		
		--▼14325▼インフォ表示：左手攻撃▼
		--if proxy:IsCompleteEvent( 14325 ) == false then
		--	proxy:OnKeyTime2( 14325 , "OnEvent_14325" , 10.0 , 0 , 1 , once );
		--end
	end
	
	print("OnEvent_14201 end");
end


--------------------------------------------------------------------------------------
--インフォ表示：左手攻撃■14325
--------------------------------------------------------------------------------------

--■14325■インフォ表示：左手攻撃■
function OnEvent_14325(proxy , param)
	print("OnEvent_14325 begin");
	
	now_job_type = JobCheck(proxy, now_job);
	
	--ソルジャーのときだけ表示(デバック用の判定追加)
	if now_job_type == now_job_type_SOL then
	
		--多重発動防止
		if proxy:IsCompleteEvent( 14325 ) == true then
			print("OnEvent_14325 end");
			return ;
		end
		
		--インフォメーションメッセージの表示
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81001200, 1, -1, 30, 81001201, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14325 , 1 );	
	end
	
	print("OnEvent_14325 end");
end



--------------------------------------------------------------------------------------
--インフォ表示：武器チェンジ（マジシャンorクレリック）■14202
--------------------------------------------------------------------------------------

--■14202■インフォ表示：武器チェンジ（マジシャンorクレリック）■
function OnEvent_14202(proxy , param)
	print("OnEvent_14202 begin");
	
	now_job_type = JobCheck(proxy, now_job);
	
	--ウィザードorクレリックのときだけ表示
	if now_job_type == now_job_type_MAJI or now_job_type == now_job_type_KURE then
	
		--インフォメーションメッセージの表示
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81000200, 1, -1, 30, 81000201, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14202 , 1 );
		
		--▼インフォ表示：魔法▼
		--if proxy:IsCompleteEvent( 14203 ) == false then
		--	proxy:OnKeyTime2( 14203 , "OnEvent_14203" , 10.0 , 0 , 1 , once );
		--end
	end
	
	print("OnEvent_14202 end");
end


--------------------------------------------------------------------------------------
--インフォ表示：魔法■14203
--------------------------------------------------------------------------------------

--■14203■インフォ表示：魔法■
function OnEvent_14203(proxy , param)
	print("OnEvent_14203 begin");
	
	now_job_type = JobCheck(proxy, now_job);
	
	--ウィザードorクレリックのときだけ表示
	if now_job_type == now_job_type_MAJI then
	
		--多重発動防止
		if proxy:IsCompleteEvent( 14203 ) == true then
			print("OnEvent_14203 end");
			return;
		end
		
		--インフォメーションメッセージの表示
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81000300, 1, -1, 30, 81000301, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14203 , 1 );	
		
		--▼インフォ表示：魔法選択▼
		--if proxy:IsCompleteEvent( 14208 ) == false then
		--	proxy:OnKeyTime2( 14208 , "OnEvent_14208" , 10.0 , 0 , 1 , once );
		--end
	end
	
	print("OnEvent_14203 end");
end



--------------------------------------------------------------------------------------
--インフォ表示：魔法選択■14208
--------------------------------------------------------------------------------------

--■14208■インフォ表示：魔法選択■
function OnEvent_14208(proxy , param)
	print("OnEvent_14208 begin");
	
	now_job_type = JobCheck(proxy, now_job);
	
	--ウィザードorクレリックのときだけ表示
	if now_job_type == now_job_type_MAJI then
	
		--多重発動防止
		if proxy:IsCompleteEvent( 14208 ) == true then
			print("OnEvent_14208 end");
			return;
		end
		
		--インフォメーションメッセージの表示
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81000400, 1, -1, 30, 81000401, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14208 , 1 );	
	end
	
	print("OnEvent_14208 end");
end



--------------------------------------------------------------------------------------
--インフォ表示：武器チェンジ（ハンター）■14204
--------------------------------------------------------------------------------------

--■14204■インフォ表示：武器チェンジ（ハンター）■
function OnEvent_14204(proxy , param)
	print("OnEvent_14204 begin");
	
	now_job_type = JobCheck(proxy, now_job);
	
	--ハンターのときだけ表示
	if now_job_type == now_job_type_HAN then
	
		--インフォメーションメッセージの表示
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81000500, 1, -1, 30, 81000501, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14204 , 1 );
		
		--▼インフォ表示：両手持ち替え促す▼
		--if proxy:IsCompleteEvent( 14205 ) == false then
		--	proxy:OnKeyTime2( 14205 , "OnEvent_14205" , 10.0 , 0 , 1 , once );
		--end
	end
	
	print("OnEvent_14204 end");
end


--------------------------------------------------------------------------------------
--インフォ表示：両手持ち替え促す■14205
--------------------------------------------------------------------------------------

--■14205■インフォ表示：両手持ち替え促す■
function OnEvent_14205(proxy , param)
	print("OnEvent_14205 begin");
	
	now_job_type = JobCheck(proxy, now_job);
	
	--ハンターのときだけ表示
	if now_job_type == now_job_type_HAN then
	
		--多重発動防止
		if proxy:IsCompleteEvent( 14205 ) == true then
			print("OnEvent_14205 end");
			return;
		end
		
		--インフォメーションメッセージの表示
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81000600, 1, -1, 30, 81000601, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14205 , 1 );
		
		--▼インフォ表示：両手持ち替え促す▼
		--if proxy:IsCompleteEvent( 14206 ) == false then
		--	proxy:OnKeyTime2( 14206 , "OnEvent_14206" , 10.0 , 0 , 1 , once );
		--end
	end	
	
	print("OnEvent_14205 end");
end



--------------------------------------------------------------------------------------
--インフォ表示：弓射撃■14206
--------------------------------------------------------------------------------------

--■14206■インフォ表示：弓射撃■
function OnEvent_14206(proxy , param)
	print("OnEvent_14206 begin");

	now_job_type = JobCheck(proxy, now_job);
	
	--ハンターのときだけ表示
	if now_job_type == now_job_type_HAN then
	
		--多重発動防止
		if proxy:IsCompleteEvent( 14206 ) == true then
			print("OnEvent_14206 end");
			return;
		end
		
		--インフォメーションメッセージの表示
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81000700, 1, -1, 30, 81000701, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14206 , 1 );
		
		--▼インフォ表示：精密射撃モード▼
		--if proxy:IsCompleteEvent( 14207 ) == false then
		--	proxy:OnKeyTime2( 14207 , "OnEvent_14207" , 10.0 , 0 , 1 , once );
		--end
	end	
	
	print("OnEvent_14206 end");
end


--------------------------------------------------------------------------------------
--インフォ表示：精密射撃モード■14207
--------------------------------------------------------------------------------------

--■14207■インフォ表示：精密射撃モード■
function OnEvent_14207(proxy , param)
	print("OnEvent_14207 begin");

	now_job_type = JobCheck(proxy, now_job);
	
	--ハンターのときだけ表示
	if now_job_type == now_job_type_HAN then
	
		--多重発動防止
		if proxy:IsCompleteEvent( 14207 ) == true then
			print("OnEvent_14207 end");
			return;
		end
		
		--インフォメーションメッセージの表示
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81000800, 1, -1, 30, 81000801, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14207 , 1 );
		
		--▼インフォ表示：精密射撃モード解除▼
		--if proxy:IsCompleteEvent( 14211 ) == false then
		--	proxy:OnKeyTime2( 14211 , "OnEvent_14211_1" , 0.2 , 0 , 1 , once );
		--end
	end
		
	print("OnEvent_14207 end");
end

--[[
function OnEvent_14211_1(proxy,param)
	proxy:OnRegistFunc( 14211 , "Check_14211_2","OnEvent_14211_2",0,once);
end

function Check_14211_2(proxy)
	if proxy:IsShowMenu() == true then
		return false;
	end
	return true;
end

function OnEvent_14211_2(proxy,param)
	proxy:OnKeyTime2( 14211 , "OnEvent_14211" , 0.0 , 0 , 1 , once );
end

--▲インフォ表示：精密射撃モード解除▲
function OnEvent_14211(proxy , param)
	print("OnEvent_14211 begin");

	now_job_type = JobCheck(proxy, now_job);
	
	--ハンターのときだけ表示
	if now_job_type == now_job_type_HAN then
	
		--インフォメーションメッセージの表示
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81000900, 1, -1, 30, 81000901, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14211 , 1 );	
	end
	
	print("OnEvent_14211 end");
end
]]

function OnEvent_14350(proxy,param)
	print("OnEvent_14350 begin");
	now_job_type = JobCheck(proxy, now_job);
	
	--クレリックのときだけ表示
	if now_job_type == now_job_type_KURE then
	
		--インフォメーションメッセージの表示
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81001500, 1, -1, 30, 81001501, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14211 , 1 );	
	end
	print("OnEvent_14350 end");
end

function OnEvent_14351(proxy,param)
	print("OnEvent_14351 begin");
	now_job_type = JobCheck(proxy, now_job);
	
	--クレリックのときだけ表示
	if now_job_type == now_job_type_KURE then
	
		--インフォメーションメッセージの表示
		Display_InfomationMenu_2(proxy, 0, -1, 30, 81001600, 1, -1, 30, 81001601, 7);
		Lua_PauseTutorial(proxy);
		proxy:SetEventFlag( 14211 , 1 );	
	end
	print("OnEvent_14351 end");
end


--------------------------------------------------------------------------------------
--インフォ表示：魔法扉■14305
--------------------------------------------------------------------------------------

--■14305■インフォ表示：魔法扉■
function OnEvent_14305(proxy , param)
	print("OnEvent_14305 begin");
	
	--インフォメーションメッセージの表示
	Display_InfomationMenu_2(proxy, 0, -1, 30, 81001000, 1, -1, 30, 81001001, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14305 , 1 );	
	
	print("OnEvent_14305 end");
end




--------------------------------------------------------------------------------------
--ボス部屋の中に入る■14231
--------------------------------------------------------------------------------------

--■イベントがループなので、全部リピートにする↓

--■14231■中ボス部屋への扉が開く■
function OnEvent_14231(proxy,param)
	print("OnEvent_14231 begin");
	
	--クライアントへ、ボス部屋阻止失敗を通知
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end

	proxy:LuaCallStart( 14232, 1 );--旋回アニメの同期再生
	
	print("OnEvent_14231 end");
end


--旋回アニメの同期再生(IDが別)
function OnEvent_14232_1(proxy,param)
	print("OnEvent_14232_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を行い、その終了時にOnEvent_14232_2を発行する
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2280 );
		else
			--旋回アニメ再生を行い、その終了時にOnEvent_14232_2を発行する
			proxy:OnTurnCharactorEnd( 14232, 10000, 2280, "OnEvent_14232_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_14232_1 end");
end

--旋回アニメの同期再生終了後
function OnEvent_14232_2(proxy,param)
	print("OnEvent_14232_2 begin");

	--同期用歩きアニメ再生
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 14232, 10000, ANIMEID_WALK, "OnEvent_14232_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_14232_2 end");
end

--歩きアニメの同期再生終了後
function OnEvent_14232_3(proxy,param)
	print("OnEvent_14232_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ
	if proxy:IsCompleteEvent( 14231 ) == false then
		proxy:LuaCallStart( 14232 , 5 );--2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知
		proxy:LuaCallStart( 14232 , 6 );--フラグセット(同期用)
	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない)
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:ResetThink( 300 );
	end	

	print("OnEvent_14232_3 end");
end


--■14231 2回目以降にボス部屋に入るためのイベント配信用
function OnEvent_14231_GO_TO_IN(proxy, param)
	print("OnEvent_14231_GO_TO_IN begin");
		
	proxy:NotNetMessage_begin();
		--▼14232▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_14231
		proxy:OnPlayerActionInRegion( 14232, 2290, "OnEvent_14231", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	

	print("OnEvent_14231_GO_TO_IN end");
end


--■14231 フラグセット(同期用)
function OnEvent_14231_flag_set(proxy, param)
	print("OnEvent_14231_flag_set begin");
		
	proxy:SetEventFlag( 14231 , 1 );
	proxy:DeleteEvent( 14231 );
	proxy:SetDeadMode( 10000 , false );--無敵解除

	print("OnEvent_14231_flag_set end");
end



--------------------------------------------------------------------------------------
--ボスが動き出す(戦闘開始)■14234＆14232
--------------------------------------------------------------------------------------

function OnEvent_14234(proxy, param)
	print("OnEvent_14234 begin");
	
	--■14232■ボス戦用BGM再生開始
	proxy:PlayPointSE( 2292, SOUND_TYPE_M, 80100000, 1 );
	
	--ボスロジックON
	proxy:EnableLogic( 300 , true );
	
	--フラグON
	--proxy:SetEventFlag( 14232 , true );--BGM
	proxy:SetEventFlag( 14234 , true );
	
	--ボスゲージ表示
	proxy:SetBossGauge(300, 0, 1030);
	
	print("OnEvent_14234 end");
end


--------------------------------------------------------------------------------------
--■14301■ソウル入手■
--------------------------------------------------------------------------------------
function OnEvent_14301(proxy, param)
	print("OnEvent_14301 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ 
		print("OnEvent_14301 end");
		return true;
	end
	
	--アイテム取得関数
	proxy:GetRateItem(10800);--パラメータ10800参照
	proxy:GetRateItem(10870);--パラメータ10870参照
	proxy:GetRateItem(10871);--パラメータ10871参照
	proxy:GetRateItem(10872);--パラメータ10872参照
	proxy:GetRateItem(10873);--パラメータ10873参照
	Lua_PauseTutorial(proxy);
	--アイテムを取得済み
	proxy:SetEventFlag( 14301, 1 );

	--SFXが消える
	proxy:InvalidSfx( 1290 , true );
	
	proxy:OnKeyTime2( 14242,"OnEvent_14242_wait",1.0,0,0,once);
	
	print("OnEvent_14301 end");
end

function OnEvent_14242_wait(proxy,param)
	print("OnEvent_14242_wait begin");
	proxy:OnRegistFunc( 14242 , "Check_14242_regist","OnEvent_14242_regist",0,once);
	print("OnEvent_14242_wait end")
end

function Check_14242_regist(proxy)
	if proxy:IsShowMenu() == true then
		return false;
	end
	return true;	
end

function OnEvent_14242_regist(proxy,param)
	print("OnEvent_14242_regist begin");
	proxy:RepeatMessage_begin();		
		proxy:OnDistanceAction( 14242 , 10000 , 1311 , "OnEvent_14242" , WarpGimmickDist_A , 10010180 , 0 , 180, everytime );
	proxy:RepeatMessage_end();
	print("OnEvent_14242_regist begin");
end

function OnEvent_14242(proxy,param)
	
	if proxy:IsCompleteEvent( 14242 ) == true then
		return;
	end	
	if param:IsNetMessage() == true then
		return;
	end	
	
	print("OnEvent_14242 begin");
	
	--セッション中ならば、要石のワープ無効
	if proxy:IsSession() == false then--セッション中ではない
		proxy:RepeatMessage_begin();
		--▼70_1▼選択メニューの監視▼
			proxy:OnSelectMenu(14242, "OnEvent_14242_1", 84000000, 0, 2, 1311, 2, once);			
		proxy:RepeatMessage_end();
	else--セッション中
		--エラー表示「セッション中は楔の神殿には戻れません」
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010720, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1311, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	print("OnEvent_14242 end");
end

function OnEvent_14242_1(proxy,param)
	print("OnEvent_14242_1 beign");

	proxy:PlayAnimation( 10000 , 8283 );--要石に触れるアニメを再生	
	proxy:NoAnimeTurnCharactor( 10000 , 1311 ,TURNSKIP_ANGLE);
	proxy:NotNetMessage_begin();
		--▼要石に触れるアニメ再生終了▼
		proxy:OnChrAnimEnd( 14241 , 10000 , 8283 , "OnEvent_14241" , once );
	proxy:NotNetMessage_end();	
	proxy:SetEventFlag( 14242, true );
	print("OnEvent_14242_1 end");
	
end

--------------------------------------------------------------------------------------
--中ボス死亡処理■14233
--------------------------------------------------------------------------------------
--■14233■中ボス死亡処理■
function OnEvent_14233(proxy, param)
	print("OnEvent_14233 begin");

	proxy:NotNetMessage_begin();
		--▼14233_1▼中ボス死亡処理▼
		proxy:OnKeyTime2(14233,"OnEvent_14233_1", 1,0,0,once);	
	proxy:NotNetMessage_end();
	
	proxy:CustomLuaCallStart( 4050 , 300 );
	--BlockClear2(proxy,param);
	proxy:SetEventFlag( 14233, 1 );--ボス死亡
	
	print("OnEvent_14233 end");
end

--■14233_1■中ボス死亡処理■
function OnEvent_14233_1(proxy, param)
	print("OnEvent_14233_1 begin");
	
--アイテム入手関連--------------------------------------------------
	--宝死体(ソウル?)有効化
	proxy:SetDrawEnable( 1310 , true );
	proxy:SetColiEnable( 1310 , true );
	
	proxy:SetDrawEnable( 1311 , true );
	proxy:SetColiEnable( 1311 , true );
	
	--▼(ソウル)アイテム取得用イベント監視追加▼
	if proxy:IsCompleteEvent( 14301 ) == false then
		proxy:ValidSfx( 1290 );--光の粒子
		proxy:ValidSfx( 1291 );--SFX 有効化
		--proxy:TreasureDispModeChange2( 1310 , true ,KANAME_SFX);--光らせる		
		proxy:TreasureDispModeChange2( 1311 , true ,KANAME_SFX);--光らせる
		proxy:OnDistanceActionAttribute( 14301 , 10000 , 1310 , "OnEvent_14301" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_NOSESSION, once );
	end
--------------------------------------------------------------------
 
 --ボス死亡で次のエリアへ道が開く
	--proxy:PlayAnimation( 1311 , 1 );
	
	--ボス戦用のBGM停止
	proxy:StopPointSE( 1 );

	--中ボス部屋の魔法壁が消える
	proxy:SetColiEnable( 1272 , false );
	proxy:SetDrawEnable( 1272 , false );

	--中ボス部屋前のイベントを削除
	proxy:DeleteEvent( 14231 );--中に入る用
	proxy:DeleteEvent( 14232 );--中に入る用
	proxy:DeleteEvent( 14234 );--戦闘開始用

	proxy:InvalidSfx( 2274, true );
	
	--▼インフォメーションメッセージ表示▼
	proxy:SetEventFlag( 14233 , 0 );
	--proxy:OnChrAnimEnd( 14233 , 1311 , 1 , "OnEvent_14233_2" , once );
	--proxy:OnKeyTime2( 14233 , "OnEvent_14233_2", 0.0 , 0 , 10 , once );
	proxy:SetEventFlag( 14233 , 1 );
	
	print("OnEvent_14233_1 end");
end

--[[
--▲14233_2▲インフォメーションメッセージ表示▲
function OnEvent_14233_2(proxy, param)
	print("OnEvent_14233_2 begin");
	
	--インフォメーションメッセージの表示
	--Display_InfomationMenu_2(proxy, 0, -1, 30, 81001100, 1, -1, 30, 81001101, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14233 , 1 );	
	
	print("OnEvent_14233_2 end");
end
]]

--------------------------------------------------------------------------------------
--砦での死亡■無し
--------------------------------------------------------------------------------------
function m08_01Death(proxy,param)
	print("m08_01Death begin");
--[[	
	--proxy:SetMapUid( 8, 1, 0, 0, -1 );			
	proxy:SetHp( 10000, 1 );
	--召還位置に再出現		
	proxy:SetEventFlag(14300,true);]]	
	proxy:SetEventFlag(4000,true);	
	proxy:OnKeyTime2(143000,"OnEvent_14300",1.5,0,10,once);
	print("m08_01Death end");
end

--[[
--初期位置へのワープ
function m08_01Death_Load(proxy,param)
	print("m08_01Death_Load begin");
	--ワープを行う
	--proxy:WarpNextStageKick();
	proxy:WarpRestart(10000,-1);
	proxy:OnKeyTime2(4000,"OnEvent_14300",1.0,0,0,once);
	print("m08_01Death_Load end");
end
]]

--------------------------------------------------------------------------------------
--砦での死亡後のシステムメニュー■14300
--------------------------------------------------------------------------------------
function OnEvent_14300(proxy,param)
	print("OnEvent_14300 begin");
	--Display_InfomationMenu_2(proxy, 0, -1, 30, 89999999, 1, -1, 30, 88999900, 6);
	--Lua_PauseTutorial(proxy);
	--proxy:SetEventFlag(14300,false);
	
	proxy:OnKeyTime2( 14300 , "OnEvent_14300_1",1.5,0,0,once);
	print("OnEvent_14300 end");
end

function OnEvent_14300_1(proxy,param)
	print("OnEvent_14300_1 begin");
	proxy:OnRegistFunc( 14300 , "Check_14300","OnEvent_14300_2",1,once);
	print("OnEvent_14300_1 end");
end

function Check_14300(proxy)
	if proxy:IsShowMenu() == true then
		return false;
	end
	return true;
end

function OnEvent_14300_2(proxy,param)
	print("OnEvent_14300_2 begin");
	proxy:OnKeyTime2( 14300 , "OnEvent_14300_3",1.0,0,0,once);
	print("OnEvent_14300_2 end");
end


--石柱へのワープ
function OnEvent_14300_3(proxy,param)
	print("OnEvent_14300_3 begin");
	proxy:SetEventFlag( 4000 , 0 );--プレイヤー死亡フラグOFF	
	proxy:RevivePlayer();	
	proxy:Tutorial_end();
	
	--チュートリアルマップ3ではマップ開始時から必ずグレイゴーストになる必要がある。
	--このタイミングでグレイゴーストに変わっておけば、必要な処理をグローバルの処理で
	--行ってくれる。(=正規のグレイゴーストになれる)
	proxy:ChangeGreyGhost();
	
	--完全回復要求
	proxy:RequestFullRecover();
	--石柱の入り口にワープ
	proxy:WarpNextStage( 1,0,0,0,-1);
	print("OnEvent_14300_3 end");
end


--------------------------------------------------------------------------------------
--ボス戦闘カメラ切り替えイベント■14230
--------------------------------------------------------------------------------------
function OnEvent_14230(proxy,param)
	--print("OnEvent_14230 begin");
	--ボスが生きている　かつ　ボスとの戦闘が開始されている
	if proxy:IsCompleteEvent( 14233 ) == false and proxy:IsCompleteEvent( 14234 ) == true then
		--ボス戦　非ロックカメラ
		proxy:SetCamModeParamTargetId(8011);
		--ボス戦　ロックカメラ
		proxy:SetCamModeParamTargetIdForBossLock(8010);
	end	
	--print("OnEvent_14230 end");
end


--------------------------------------------------------------------------------------
--インフォ表示：光の壁■14306
--------------------------------------------------------------------------------------
--■14306■インフォ表示：光の壁■
function OnEvent_14306(proxy , param)
	print("OnEvent_14306 begin");
	
	--インフォメーションメッセージの表示
	Display_InfomationMenu_2(proxy, 0, -1, 30, 81001050, 1, -1, 30, 81001051, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14306 , 1 );	
	
	print("OnEvent_14306 end");
end



--------------------------------------------------------------------------------------
--インフォ表示：光の壁■14291
--------------------------------------------------------------------------------------
--■14291■イベント発動用■
function OnEvent_14291(proxy , param)
	print("OnEvent_14291 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 14291 ) == true then
		print("OnEvent_14291 end");
		return;
	end
	
	proxy:InvalidSfx( 2275 , true );--SFX OFF
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 14291 , 1 );
		print("OnEvent_14291 end");
		return;
	end
	
	--ダミポリへワープ
	proxy:WarpDmy( 10000 , 1271 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼240_1▼歩きアニメ終了▼
		--proxy:OnChrAnimEnd( 14291 , 10000 , ANIMEID_WALK , "OnEvent_14291_1" , once );
		OnEvent_14291_1(proxy , param);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 14291 , 1 );
	
	print("OnEvent_14291 end");
end


--▲14291_1▲歩きアニメ終了▲
function OnEvent_14291_1(proxy , param)
	print("OnEvent_14291_1 begin");
	
	proxy:SetDrawEnable( 1271 , false );--魔法壁描画OFF
	proxy:SetColiEnable( 1271 , false );--魔法壁当たりOFF
	proxy:SetObjDeactivate( 1271 , true );--デアクティブ
	proxy:DeleteEvent( 14291 );--全プレイヤー分の監視消えるはず。
	
	print("OnEvent_14291_1 end");
end


--------------------------------------------------------------------------------------
--徘徊ゴースト目撃イベント■14410
--------------------------------------------------------------------------------------
function OnEvent_14410(proxy,param)
    proxy:RepeatMessage_begin();    
    proxy:ForceChangeTarget( 401 ,403 ); 
    proxy:ForceChangeTarget( 402 ,404 ); 
    proxy:ForceChangeTarget( 403 ,401 ); 
    proxy:ForceChangeTarget( 404 ,402 ); 
    proxy:SetColiEnable( 401 ,false );
    proxy:SetColiEnable( 402 ,false );
	proxy:SetColiEnable( 403 ,false );
	proxy:SetColiEnable( 404 ,false );
    --401の目撃イベント
    proxy:OnKeyTime2( 14411 , "OnEvent_14411_401",0.7 , 0 , 0,once);
    --402の目撃イベント
    proxy:OnKeyTime2( 14411 , "OnEvent_14411_402",4.6 , 0 , 1,once);
    proxy:RepeatMessage_end();
end


function OnEvent_14411_401(proxy,param)
	proxy:SetDrawEnable( 401 , true );
	proxy:OnWanderFade( 14411 , 401 ,2.0,2.0,10.0,12.5,once);
	--proxy:ChrFadeIn( 401 , 2.0 , 0.0 );
	proxy:RepeatMessage_begin();
		proxy:OnKeyTime2( 14411 , "OnEvent_14411_401_end",10.0,0,2,once);
	proxy:RepeatMessage_end();
end

--[[
function OnEvent_14411_401_fadeout(proxy,param)
	proxy:ChrFadeOut( 401 , 2.0 , 1.0 );
	proxy:RepeatMessage_begin();
		proxy:OnKeyTime2( 14411 , "OnEvent_14411_401_end", 2.0, 0, 3, once);
	proxy:RepeatMessage_end();
end
]]

function OnEvent_14411_401_end(proxy,param)
	if proxy:IsCompleteEvent( 14233 ) == false then
		proxy:RepeatMessage_begin();
			proxy:OnKeyTime2( 14411 , "OnEvent_14411_401", 12.5 , 0, 4, once);
		proxy:RepeatMessage_end();
	else
		print("徘徊イベントEnd　401");
	end
end

function OnEvent_14411_402(proxy,param)	
	proxy:SetDrawEnable( 402 , true );
	--proxy:ChrFadeIn( 402 , 2.0 , 0.0 );
	proxy:OnWanderFade( 14411 , 402 ,2.0,2.0,10.0,10.0,once);
	proxy:RepeatMessage_begin();
		proxy:OnKeyTime2( 14411 , "OnEvent_14411_402_end",10,0,5,once);
	proxy:RepeatMessage_end();
end

--[[
function OnEvent_14411_402_fadeout(proxy,param)
	proxy:ChrFadeOut( 402 , 2.0 , 1.0 );
	proxy:RepeatMessage_begin();
		proxy:OnKeyTime2( 14411 , "OnEvent_14411_402_end", 2.0, 0, 6, once);
	proxy:RepeatMessage_end();
end
]]

function OnEvent_14411_402_end(proxy,param)
	if proxy:IsCompleteEvent( 14233 ) == false then
		proxy:RepeatMessage_begin();
			proxy:OnKeyTime2( 14411 , "OnEvent_14411_402", 10.0 , 0, 7, once);
		proxy:RepeatMessage_end();
	else
		print("徘徊イベントEnd　402");
	end
end
