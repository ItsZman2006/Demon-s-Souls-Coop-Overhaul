
--古砦の囚人用の状態
SYUUJIN_STATE_ESCAPE   	= 16050;--牢から出たい
SYUUJIN_STATE_THANKS 	= 16051;--解放してくれて感謝
SYUUJIN_STATE_INTERVAL	= 16052;--水牢で休憩
SYUUJIN_STATE_ANGRY_01	= 16053;--敵対(水牢)
SYUUJIN_STATE_DEAD 		= 16054;--死亡
SYUUJIN_STATE_STAY		= 16055;--古砦２にいる
SYUUJIN_STATE_ANGRY_02	= 16056;--敵対(古砦2)


syuujin_flag_list = { 
	SYUUJIN_STATE_ESCAPE,
	SYUUJIN_STATE_THANKS,
	SYUUJIN_STATE_INTERVAL, 
	SYUUJIN_STATE_ANGRY_01, 
	SYUUJIN_STATE_DEAD,
	SYUUJIN_STATE_STAY,
	SYUUJIN_STATE_ANGRY_02,
};

--古砦囚人トータルダメージ
SYUUJIN_TOTAL_DAMAGE = 50;

---------------------------------
--マスターサツキの状態変化フラグ
---------------------------------
MasterSATSUKI_NORMAL  = 16360;--「剣を探している」
MasterSATSUKI_HOSTILE = 16361;--「敵対」
MasterSATSUKI_DEAD    = 16362;--「死亡」
MasterSATSUKI_HOSTILE_Makoto = 16363;--「敵対(誠装備)」

MasterParamFlag_list = {
	MasterSATSUKI_NORMAL,
	MasterSATSUKI_HOSTILE,
	MasterSATSUKI_DEAD,
	MasterSATSUKI_HOSTILE_Makoto
}

--PCの攻撃によってマスターが敵対するためのダメージ値
MasterSATSUKI_TotalDamage = 100;

---------------------------------
--鷲の娘
---------------------------------
--アイテム交換イベント用--必ず要素の数は合わせてください
--使える定数
--TYPE_WEAPON
--TYPE_PROTECTER
--TYPE_ACCESSORY
--TYPE_GOODS
itemevent_typelist		=	{TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,
							 TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_PROTECTER	,TYPE_PROTECTER	,TYPE_PROTECTER	,TYPE_WEAPON	,TYPE_WEAPON	,TYPE_WEAPON	};
							 
itemevent_idlist		=	{1014			,1022			,1018			,38				,2027			,2028			,2029			,2039			,2040			,2041			,
							 2045			,2046			,2047			,100100			,100000			,301700			,21600			,80300			,90400			};

itemevent_paramlist		=	{20000			,20001			,20002			,20003			,20004			,20005			,20006			,20007			,20008			,20009			,
							 20010			,20011			,20012			,20013			,20014			,20015			,20016			,20017			,20018			};

itemevent_eventidlist	=	{12621			,12622			,12623			,12624			,12625			,12626			,12627			,12628			,12629			,12630			,
							 12631			,12632			,12633			,12634			,12635			,12636			,12637			,12638			,12639			};

itemevent_endidlist		=	{12641			,12642			,12643			,12644			,12645			,12646			,12647			,12648			,12649			,12650			,
							 12651			,12652			,12653			,12654			,12655			,12656			,12657			,12658			,12659			};

--アイテム交換イベント用分布
ITEM_LOT_A = 10;--0～A
ITEM_LOT_B = 20;--A～B
ITEM_LOT_C = 30;--B～C
ITEM_LOT_D = 40;--C～D
ITEM_LOT_E = 50;--D～E
ITEM_LOT_F = 60;--E～F
ITEM_LOT_G = 70;--F～G
ITEM_LOT_H = 80;--G～H
ITEM_LOT_I = 90;--H～I
--J				--I～100

ITEM_SHOWMENU = false;
PREV_ITEM_SHOWMENU = false;
--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■
--------------------------------------------------------------------------------------
function Initialize_m03_01_00_00(proxy)
	print("Initialize_m03_01_00_00 begin");
	
	proxy:LuaCall( 99999 , 0 , "OnEvent_4000_Hp_1",everytime);
-----------------------------------------------------------------------------------------
--ボス関連
-----------------------------------------------------------------------------------------
--■594■ボス部屋に入る■	
	--中ボスが生きているときだけイベント登録
	if proxy:IsCompleteEvent( 4756 ) == false then	
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。
		SingleReset(proxy, 594);
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き)
		proxy:LuaCall( 593, 1, "OnEvent_594_1", everytime );		
		--▽2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCall( 593 , 5 , "OnEvent_594_GO_TO_IN" , everytime );		
		--▽フラグセット(同期用)
		proxy:LuaCall( 593 , 6 , "OnEvent_594_flag_set" , everytime );		
		--誰かがボス前扉をまだ通過していない
		if proxy:IsCompleteEvent( 594 ) == false then		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;			
			proxy:NotNetMessage_begin();
				--▼594▼扉が開いているときに中に入るためのイベントを追加▼
				proxy:OnPlayerActionInRegionAttribute( 594, 2894, "OnEvent_594", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
		else --グレイゴーストできたときようにいると思われる。		
			proxy:NotNetMessage_begin();			
				--▼593▼扉が開いているときに中に入るためのイベントを追加▼
				proxy:OnPlayerActionInRegion( 593, 2894, "OnEvent_594", HELPID_GO_TO_IN, everytime );--ハンドラは上と同じ
			proxy:NotNetMessage_end();		
		end
	end	

	--■595■ボス登場演出■
	if proxy:IsCompleteEvent( 595 ) == false then
		proxy:LuaCall( 595, 0, "OnEvent_595", once );
	end
	
	--■641■ボス戦闘開始■
	if proxy:IsCompleteEvent( 4756 ) == false then
		proxy:OnRegionJustIn( 641 , 10000 , 2886 , "OnEvent_641" , once );
	end	
	
	--■4756■中ボス死亡で扉が開く■
	proxy:AddFieldInsFilter( 804 );	
	if proxy:IsCompleteEvent( 4756 ) ==false then
		--▼OBJ(804)が死に、死亡アニメーションも再生し終わった時▼--
		proxy:OnCharacterDead(4756, 804, "OnEvent_4756", once);
		proxy:OnCharacterDead(642,804,"OnEvent_642",once);
	else
		proxy:EndAnimation( 1206, 1);
	end
	
--■4766-4787■中ボス部屋　床破壊■

	local first_block_id  = 1208;
	local block_num = 21;  -- 全部の場合は22個、今は2Ｆのとかが無効になっているので13個
	local now_block_id    = first_block_id;
	
	local first_event_id  = 4766;
	local end_event_id    = first_event_id + block_num;
	
	for i=first_event_id, end_event_id, 1 do
		
		print( "add block id is " .. now_block_id );
		if proxy:IsCompleteEvent( 4756 ) == false then
			SingleReset( proxy, i );
		end
		if proxy:IsCompleteEvent( i ) == false then
			--初期化時に壊れてない事にする
			proxy:RestorePiece( now_block_id );
			proxy:OnObjectDestroy( i, now_block_id, "OnEvent_"..i , once );
		else
			proxy:ReconstructBreak( now_block_id , 2 );
		end
		
		now_block_id = now_block_id + 1;
	end

	local actIdlist2 = { 4788, 4789, 4790, 4791, 4792 };
	local objIdlist2 = { 1230, 1231, 1232, 1233, 1234 };
	local num = table.getn( actIdlist2 );
	for index = 1 , num , 1 do
		local actionid = actIdlist2[index];
		local objid = objIdlist2[index];
		--ボスが生きていたら
		if proxy:IsCompleteEvent( 4756 ) == false then
			SingleReset( proxy, actionid );
		end
		if proxy:IsCompleteEvent( actionid ) == false then
			proxy:NotNetMessage_begin();
				--先に修復
				proxy:RestorePiece( objid );
				proxy:OnObjectDestroy( actionid , objid , "OnEvent_"..actionid , once);
			proxy:NotNetMessage_end();
		else
			proxy:ReconstructBreak( objid , 1 );
		end	
	end
	
	--現状、ReconstructBreakをInitializeのタイミングで呼んでも
	--ReconstructBreakの中の処理がまだ途中なため、
	--破壊の再現は行われず、オブジェが表示されない状態になる。
	--中身ができたらこのタイミングで呼んでも破壊再現してくれるはず(たぶん)
	--今の状態で、破壊再現したい場合はSecond_Initializeの中に書くようにする。

	--■ボス関連の初期化処理
	if proxy:IsCompleteEvent( 4756 ) ==true then
		
		--▽ボス死んでいるとき
		--ボスいなくなる
		InvalidBackRead( proxy , 804 );

		--魔法壁消える
		proxy:SetDrawEnable( 1994 , false );
		proxy:SetColiEnable( 1994 , false );

		proxy:SetDrawEnable( 1998 , false );
		proxy:SetColiEnable( 1998 , false );

		--魔法壁の SFX OFF		
		proxy:InvalidSfx( 1990 , false );
		proxy:InvalidSfx( 1986 , false );

		--ホストプレイヤーのみアイテム入手イベントに使用
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--宝死体(ソウル?)有効化
		proxy:SetDrawEnable( 1981 , true );
		proxy:SetColiEnable( 1981 , true );
		--宝死体(ソウル?)有効化
		proxy:SetDrawEnable( 1976 , true );
		proxy:SetColiEnable( 1976 , true );
		
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--光らせる
		--▼(ソウル)アイテム取得用イベント監視追加▼
		if proxy:IsCompleteEvent( 4804 ) == false then
			proxy:ValidSfx( 2286 );--SFX 有効化
			proxy:ValidSfx( 2287 );--SFX 有効化			
			proxy:OnDistanceActionAttribute( 4804 , 10000 , 1981 , "OnEvent_4804" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--▼要石でワープ用の監視を追加▼
			SingleReset(proxy,4805);			
			proxy:InvalidSfx( 2286, false );--SFX 無効化
			proxy:OnDistanceActionAttribute( 4805 , 10000 , 1981 , "OnEvent_4805" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
		
	else
		--▽ボス生きているとき		
		proxy:EnableLogic( 804 , false );--ロジックOFFで待機
		
		--宝(ソウル?)
		proxy:SetDrawEnable( 1981 , false );
		proxy:SetColiEnable( 1981 , false );
		--宝(ソウル?)2
		proxy:SetDrawEnable( 1976 , false );
		proxy:SetColiEnable( 1976 , false );
		
		--SFX 無効化
		proxy:InvalidSfx( 2287 , false );--ソウル用
		proxy:InvalidSfx( 2286 , false );--ボスアイテム用		
	end	
	
-----------------------------------------------------------------------------------------
--ギミック関連
-----------------------------------------------------------------------------------------
	--■636■鷹の攻撃■
	--proxy:OnRegistFunc(636, "Check_636", "OnEvent_636", 1, everytime );
	--proxy:OnCharacterDead( 636, 325, "OnEvent_636_1", once );
	--■637■鷹の攻撃■
	--proxy:OnRegistFunc(637, "Check_637", "OnEvent_637", 1, everytime );
	--proxy:OnCharacterDead( 637, 326, "OnEvent_637_1", once );
	
	--■638■鷹の攻撃■	
	--proxy:OnRegistFunc(638, "Check_638", "OnEvent_638", 1, everytime );
	--proxy:OnCharacterDead( 638, 327, "OnEvent_638_1", once );	
	
	--■542■はしごA降り■
	--▼PCがイベントエリア(2200)の中に居て、反応角度(LadderAngle_A)でアクションボタンを押したとき▼--
	proxy:OnActionEventRegion( 542, 2200, "OnEvent_542", LadderAngle_A, HELPID_DOWN, everytime );
	--■543■はしごA昇り■
	--▼PCがイベントエリア(2201)の中に居て、反応角度(90)でアクションボタンを押したとき▼--
	proxy:OnActionEventRegion( 543, 2201, "OnEvent_543", LadderAngle_A, HELPID_UP, everytime );	

	--■583■石柱にワープ■
	SingleReset(proxy,583);
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	--2008.06.05/toyohide 処理変更につき、修正
	--proxy:OnDistanceActionAttribute( 583, 10000, 1983, "OnEvent_583", WarpGimmickDist_A, HELPID_GO_TO_SEKITYUU, 0, 180, ATTR_NOSESSION, everytime );
	proxy:OnDistanceAction( 583, 10000, 1983, "OnEvent_583", WarpGimmickDist_A,HELPID_GO_TO_SEKITYUU, 0, 180 , everytime);

	
--■660■最初の要石の光が消える■
	proxy:OnSessionJustIn( 660 , "OnEvent_660" , everytime );
		
--■661■最初の要石の光が復活する■
	proxy:OnSessionJustOut( 661 , "OnEvent_661" , everytime );

--■8085■砦に来たフラグを立てる■
	proxy:SetEventFlag(8085, true);

	
--光の霧を通過できるキャラタイプ(このタイプの人だけアクションボタンが反応する)
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	
	--■644■ホストPCのみが通れる光の霧■
	if proxy:IsCompleteEvent( 644 ) == true then--ホストが通過済み
		proxy:SetDrawEnable( 1332 , false );
		proxy:SetColiEnable( 1332 , false );
		proxy:InvalidSfx( 2231, false );
	else
		--▼644▼魔法壁削除同期用▼
		proxy:LuaCall( 644 , 1 , "OnEvent_644_delete_wall" , once );
	
		--▼644▼壁の中に入るイベント発動用▼
		proxy:OnDistanceActionAttribute( 644 , 10000 , 1332 , "OnEvent_644" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
	
	--■645■ホストPCのみが通れる光の霧2■
	if proxy:IsCompleteEvent( 645 ) == true then--ホストが通過済み
		proxy:SetDrawEnable( 1333 , false );
		proxy:SetColiEnable( 1333 , false );
		proxy:InvalidSfx( 2232, false );
	else
	
		--▼645▼魔法壁削除同期用▼
		proxy:LuaCall( 645 , 1 , "OnEvent_645_delete_wall" , once );
		
		--▼645▼壁の中に入るイベント発動用▼
		proxy:OnDistanceActionAttribute( 645 , 10000 , 1333 , "OnEvent_645" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
	
		
	--■646■ホストPCのみが通れる光の霧3■
	if proxy:IsCompleteEvent( 646 ) == true then--ホストが通過済み
		proxy:SetDrawEnable( 1334 , false );
		proxy:SetColiEnable( 1334 , false );
		proxy:InvalidSfx( 2233, false );
	else
		
		--▼646▼魔法壁削除同期用▼
		proxy:LuaCall( 646 , 1 , "OnEvent_646_delete_wall" , once );
		
		--▼646▼壁の中に入るイベント発動用▼
		proxy:OnDistanceActionAttribute( 646 , 10000 , 1334 , "OnEvent_646" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
	
--■639■牢の扉■
	if proxy:IsCompleteEvent( 639 ) == false then
		proxy:NotNetMessage_begin();
			proxy:OnDistanceActionPlus( 639, 10000, 1331, "OnEvent_639", DoorDist_A, HELPID_OPEN, 0.0, DoorAngle_A, 0.0, 0.0, 0.0, everytime );
		proxy:NotNetMessage_end();
		proxy:LuaCall( 639, 1, "OnEvent_639_2", once );
	else
		proxy:EndAnimation( 1331, 1 );
	end
	
	--■■アイテム交換系イベント■
	--生存orグレイゴーストのみ
	if proxy:IsClient() == false and proxy:IsCompleteEvent(659) == false then

		--アイテムを捨てていたら交換する
		if proxy:IsCompleteEvent(12613) == true then
			proxy:SetEventFlag(12614,true);
			--proxy:SetEventFlag(12613,false);
			SingleReset(proxy, 12613);
		end
		
		print("live or grey");
	--■654■天の声■
		--会話の登録
		--交換可能アイテムを捨てた時の会話
		proxy:RegistSimpleTalk( 12613, 2284, 25040, TALK_ATTR_ALL - TALK_ATTR_REPEAT );
		--交換可能アイテムを捨てたが既に交換済みの会話
		proxy:RegistSimpleTalk( 663, 2284, 25060, TALK_ATTR_ALL - TALK_ATTR_REPEAT );
		--交換できるよ～会話
		proxy:RegistSimpleTalk( 654, 2284, 25000, TALK_ATTR_ALL - TALK_ATTR_REPEAT );
		--まだ交換できるよ～会話
		proxy:RegistSimpleTalk( 655, 2284, 25010, TALK_ATTR_ALL - TALK_ATTR_REPEAT );
		--もうだめぽー
		proxy:RegistSimpleTalk( 659, 2284, 25070, TALK_ATTR_ALL - TALK_ATTR_REPEAT );		
		
		--交換対象外のアイテムをドロップ
		proxy:RegistSimpleTalk( 662, 2284, 25050, TALK_ATTR_ALL - TALK_ATTR_REPEAT );
		
		
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnRegionIn(654,10000,2284,"OnEvent_654",once);				
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();		
		
	--■12613■アイテムドロップの監視■	
		proxy:NotNetMessage_begin();
			--常に調べます
			proxy:OnRegionIn(12613,10000,2284,"OnEvent_12613",everytime);
			--拾った時の監視
			--proxy:LuaCall(12613,0,"OnEvent_12613_1",everytime);
			local num = table.getn(itemevent_eventidlist);
			for index=1 ,num ,1 do
				proxy:LuaCall( itemevent_eventidlist[index],0,"OnEvent_"..itemevent_eventidlist[index].."_1",everytime);
			end
		proxy:NotNetMessage_end();
	
	--■658■アイテム交換■
		if proxy:IsCompleteEvent(12614) == true then
			print("Item event treu");
			proxy:NotNetMessage_begin();
			proxy:RepeatMessage_begin();
				proxy:OnDistanceAction(658,10000,1335,"OnEvent_658",ItemBoxDist_A,HELPID_CHECK,0,60,once);
				proxy:TreasureDispModeChange2(1335,true,ITEM_SFX);
				--proxy:SetRarity(1335,10217);
			proxy:RepeatMessage_end();
			proxy:NotNetMessage_end();
		else
			print("Item event false");			
			--表示も消しておく
			proxy:SetDrawEnable(1335,false);
		end
	else
		print("dead");
		proxy:SetDrawEnable(1335,false);
	end

------------------------------------------------------------------------------------------------
--★骸骨剣士起動★
------------------------------------------------------------------------------------------------
--■730～753■骸骨剣士_起動■
	--入りなおした時にリセット
	for ActionID = 730, 759, 1 do
		SingleReset(proxy, ActionID);
	end
	
	local actIdlist = { 730, 731, 732, 733, 734, 735, 736, 737, 738, 739, 
						740, 741, 742, 743, 744, 745, 746, 747, 748, 749,
						750, 751, 752, 753, 754, 755, 756, 757, 758, 759,
						};
	local eneIdlist = { 360, 361, 362, 363, 364, 365, 366, 367, 368, 369,
						370, 371, 372, 373, 374, 375, 376, 377, 378, 379,
						380, 381, 382, 383, 384, 428, 429, 430, 431, 432,
						};
						
	local num = table.getn( actIdlist );
	--起動する距離監視の追加と初期化
	for index=1 , num , 1 do 	
		local SkeletonID = eneIdlist[ index ];
		local ActionID = actIdlist[ index ];		
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
			end
		end
	end

-----------------------------------------------------------------------------
--■780～784■槍射出トラップ
-----------------------------------------------------------------------------
--OnEvent_780, OnEvent_781, OnEvent_782, OnEvent_783, OnEvent_784

--槍射出トラップ発動ハンドラ
	proxy:NotNetMessage_begin();
		proxy:LuaCall(780, 0, "SpearTrapMove_780", everytime);
		proxy:LuaCall(782, 0, "SpearTrapMove_782", everytime);
		proxy:LuaCall(783, 0, "SpearTrapMove_783", everytime);
		proxy:LuaCall(784, 0, "SpearTrapMove_784", everytime);
	proxy:NotNetMessage_end();
	
--各トラップ初期化
	for index = 1, 5, 1 do
		local acId		= 780  + index - 1;
		local regionId	= 2250 + index - 1;
		local objId_1	= 1240 + index - 1;--スイッチ
		local objId_2	= 1250 + index - 1;--連射用
		local objId_3	= 1260 + index - 1;--掃射用
		local ownerId	= 330;
		local SfxId	= 93005;--SFXのID
		
		--シングルならリセット
		SingleReset(proxy, acId);
		--敵を無効化するはずだが
		CreateBulletOwner(proxy, ownerId);	
		
		proxy:SetBallista( objId_2, ownerId );
		proxy:SetBallista( objId_3, ownerId );
		if	proxy:IsCompleteEvent( acId ) == false then
			--OBJのダミポリにSFXを設定
			proxy:SetObjSfx(objId_1, 1, SfxId, false);
			proxy:OnRegionJustIn( acId, LOCAL_PLAYER, regionId, "OnEvent_"..acId, once );
		else
			proxy:EndAnimation( objId_1, 1 );
			proxy:EndAnimation( objId_2, 1 );
		end
	end

--■785■カラス鳴き声が響く■
	--OnEvent_784の1秒後に発動

--[[
	--■572■岩が消滅する■QWCイベント
	
	if proxy:IsCompleteEvent(572) ==true then
		print("[成立]QWC岩消滅");
		proxy:SetDrawEnable(1207, false );
		proxy:SetColiEnable(1207, false );
	else
		print("[未成立]QWC岩消滅");
	end]]
--[[イベントが削除された為、コメントアウト
	--■532-534■閂(かんぬき)扉A■
	if proxy:IsCompleteEvent( 532 ) == false then		
		proxy:OnDistanceActionPlus( 532, 10000, 1204, "OnEvent_532", DoorDist_A, HELPID_OPEN, 180.0, 30.0, 0.0, -1.2, 0.0, once );	
	else
		proxy:EndAnimation( 1204, 1 );--閂扉を開ける
	end
	
	--■651■骸骨イベント■		
	if proxy:IsCompleteEvent(651) == false then
		proxy:OnRegionJustIn( 651,10000,2050,"OnEvent_651",once);
		proxy:PlayLoopAnimation(328,7000);--潰れてるアニメ
		proxy:SetColiEnable(328,false);--アタリOFF
	end
	
	--■652■骸骨イベント■
	if proxy:IsCompleteEvent(652) == false then
		proxy:OnRegionJustIn( 652,10000,2060,"OnEvent_652",once);
		
		local eneid = 1;
		for eneid = 329, 334, 1 do
			proxy:PlayLoopAnimation(eneid,7000);--潰れてるアニメ
			proxy:SetColiEnable(eneid,false);--アタリOFF
		end		
	end
	
	--■653■骸骨イベント■
	if proxy:IsCompleteEvent(653) == false then
		proxy:OnRegionJustIn( 653,10000,2070,"OnEvent_653",once);
		local eneid = 1;
		for eneid = 336, 339, 1 do
			proxy:PlayLoopAnimation(eneid,7000);--潰れてるアニメ
			proxy:SetColiEnable(eneid,false);--アタリOFF
		end				
	end]]

-----------------------------------------------------------------------------------------
--NPC関連
-----------------------------------------------------------------------------------------
	if proxy:IsClient() == false	then
	--■631■古砦囚人NPCチェックポイント(スタート地点)■
		proxy:OnRegionJustIn( 631 , 10000 , 2300 ,"OnEvent_631" , everytime);
	
	--■632■古砦囚人NPCチェックポイント(審判者の部屋)■
		proxy:OnRegionJustIn( 632 , 10000 , 2301 , "OnEvent_632" , everytime);
	
	--■634■古砦囚人NPCチェックポイント(嵐の戦士の部屋)■
		proxy:OnRegionJustIn( 633 , 10000 , 2550 , "OnEvent_633" , everytime);
	end
	
	--■635■チェックポイントの監視■
	proxy:LuaCall( 634 , 1 , "OnEvent_634",everytime);

--------------------------------▽▽▽QWCイベント関連▽▽▽--------------------------------
----------------------------------------------------------------
--マスターサツキ(638)
----------------------------------------------------------------
	--マスターサツキの初期状態を「剣を探している」にセットする
	SetFirstNpcStateFlag( proxy, param, MasterParamFlag_list, MasterSATSUKI_NORMAL );

	if proxy:IsCompleteEvent(MasterSATSUKI_NORMAL) == false or	--「剣を探している」でない　か
	   proxy:IsSuccessQWC(30120) == true or--QWCが成立している　か
	   proxy:IsSuccessQWC(30130) == true then--QWCが成立している　ならば
		--■703■サツキ(638)無効化■
		InvalidBackRead(proxy, 638);--サツキ(638)無効化
		
		print("サツキ(638)出現条件を満たしていない");
		proxy:SetEventFlag(702, false);
		proxy:SetEventFlag(703, true);
	else--「剣を探している」かつQWC条件を満たしているならば
		--■702■サツキ(638)有効化■
		proxy:SetDeadMode(638, true);--HPが1以下にならない
		
		--■700■サツキが去る■
		SingleReset( proxy,700 );
		if proxy:IsCompleteEvent(700) == false then
			proxy:OnCharacterTotalDamage(700, 638, -1, 1, "OnEvent_700", once);--ダメージ監視追加（ダメージ量１）
		end
		
		--■701■サツキが消える■
		SingleReset( proxy,701 );
		if proxy:IsCompleteEvent(701) == false then
			proxy:OnRegionJustIn(701,638,2241,"OnEvent_701",once);--領域監視追加
		end
		
		print("サツキ(638)出現");
		proxy:SetEventFlag(703, false);
		proxy:SetEventFlag(702, true);
	end
----------------------------------------------------------------
--マスターサツキ(637)
----------------------------------------------------------------
	--マスターサツキの状態変化の処理
	if proxy:IsCompleteEvent( MasterSATSUKI_DEAD ) == false then--死んでいないならば
		if proxy:IsCompleteEvent( MasterSATSUKI_HOSTILE ) == false and		   --敵対していない　かつ
           proxy:IsCompleteEvent( MasterSATSUKI_HOSTILE_Makoto ) == false then --敵対（誠）していない　ならば
			--■704■サツキ敵対化■
			proxy:OnCharacterTotalRateDamage( 704, 637, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_704", once );
			--■705■サツキ敵対化(誠入手)■
			proxy:LuaCall( 705, 0, "OnEvent_705", once );--サツキに「誠」を渡しての敵対処理
			proxy:LuaCall( 713, 0, "OnEvent_713", once );--サツキに「誠+1」を渡しての敵対処理
			proxy:LuaCall( 714, 0, "OnEvent_714", once );--サツキに「誠+2」を渡しての敵対処理
			proxy:LuaCall( 715, 0, "OnEvent_715", once );--サツキに「誠+3」を渡しての敵対処理
			proxy:LuaCall( 716, 0, "OnEvent_716", once );--サツキに「誠+4」を渡しての敵対処理
			proxy:LuaCall( 717, 0, "OnEvent_717", once );--サツキに「誠+5」を渡しての敵対処理
			
			
			--■706■サツキ敵対化(誠未入手)■
			proxy:LuaCall( 706, 0, "OnEvent_706", once );--サツキに「誠」を渡さないでの敵対処理
		end
		--■707■サツキ死亡■
		proxy:OnCharacterDead( 707, 637, "OnEvent_707", once );--死亡監視追加
	end

	--マスターサツキの初期化処理
	if proxy:IsSuccessQWC(30130) == true then--QWC条件を満たしている　ならば
		if proxy:IsCompleteEvent( MasterSATSUKI_HOSTILE ) == true then--マスターサツキが敵対していた時の初期化処理
			--■708■サツキ敵対初期化■
			proxy:EnableLogic(637, true);--ロジックON
			proxy:SetTeamType(637, TEAM_TYPE_AngryFriend);--チームタイプ変更
			--SetNpcStateFlag(proxy, param, MasterParamFlag_list, MasterSATSUKI_HOSTILE);--状態変化
			proxy:SetEventFlag(708, true);
			print("サツキ(637)状態　敵対");
			
		elseif proxy:IsCompleteEvent(MasterSATSUKI_HOSTILE_Makoto) == true then--マスターサツキが敵対(誠装備)していた時の初期化処理
			--■709■サツキ敵対(誠)初期化■
			
			--TargetChangeWepR2(proxy, 637);--サブ武器（誠）に切り替えさせる
			
			proxy:EnableLogic(637, true);--ロジックON
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 705,"OnEvent_705_1",0.0,0,0,once);
			proxy:NotNetMessage_end();
			proxy:SetTeamType(637, TEAM_TYPE_AngryFriend);--チームタイプ変更
			--SetNpcStateFlag(proxy, param, MasterParamFlag_list, MasterSATSUKI_HOSTILE_Makoto);--状態変化
			proxy:SetEventFlag(709, true);
			print("サツキ(637)状態　敵対（誠）");
			
		elseif proxy:IsCompleteEvent( MasterSATSUKI_DEAD ) == true then--マスターサツキが死亡していた時の初期化処理
			--■710■サツキ死亡初期化■
			InvalidBackRead(proxy, 637);--無効化
			proxy:SetEventFlag(710, true);
			print("サツキ(637)状態　死亡");
			
		end
	else--QWC条件を満たしていない　ならば
		--■710■サツキ無効初期化■
		InvalidBackRead(proxy, 637);--無効化
		proxy:SetEventFlag(710, true);
		print("サツキ(637)状態　出現条件を満たしていない");
	
	end
----------------------------------------------------------------
--マスターサツキ・ブラック(420)
----------------------------------------------------------------


--■15634■サツキ・ブラックの死体を調べた■
	if proxy:IsCompleteEvent( 15634 ) == false then
		proxy:AddCorpseEvent( 15634 , 420 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15634 ,0 , "OnEvent_15634",once );
 		proxy:NotNetMessage_end();
	end
	
	if	proxy:IsCompleteEvent(711) == false and --死亡していない　かつ
		proxy:IsSuccessQWC(30120) == true then --QWC条件を満たしている　ならば
		--■711■サツキ・ブラック死亡監視■
		proxy:OnCharacterDead( 711, 420, "OnEvent_711", once );--死亡監視追加
--		proxy:SetTeamType( 420, TEAM_TYPE_AngryFriend );--チームタイプ変更　敵対		
		
		proxy:SetEventFlag(712, false);
		
		print("サツキ・ブラック（420）出現");
	else--死亡しているかQWCをみたしていないならば
		--■712■サツキ・ブラック死亡初期化■
		if 	proxy:IsCompleteEvent( 711 ) == true and
			proxy:IsCompleteEvent( 15634 ) == false then
			--死体を再現する
			proxy:OpeningDeadPlus( 420 , true ,false ,false );
		else
			InvalidBackRead(proxy, 420);
		end
		proxy:SetEventFlag(712, true);
		print("サツキ・ブラック（420）状態　無効");
	end

----------------------------------------------------------------
--QWCソウルモンスター
----------------------------------------------------------------

--■690■QWCソウルモンスター出現１■
	if	proxy:IsSuccessQWC(30100) == true then
		print("m03_01 QWCソウルモンスター出現　成立");
		ValidCharactor( proxy, 428 );
		ValidCharactor( proxy, 429 );
		ValidCharactor( proxy, 430 );
		ValidCharactor( proxy, 431 );
		ValidCharactor( proxy, 432 );
	else
		print("m03_01 QWCソウルモンスター出現　未成立");
		InvalidCharactor( proxy, 428 );
		InvalidCharactor( proxy, 429 );
		InvalidCharactor( proxy, 430 );
		InvalidCharactor( proxy, 431 );
		InvalidCharactor( proxy, 432 );
	end
	
	RegistTokage( proxy, 620 , 250,7);
	RegistTokage( proxy, 622 , 251,8);
--------------------------------△△△QWCイベント関連△△△--------------------------------

--------------------------------------------------------------------------------------
--整理済み↑　未整理↓■Initialize_m03_01_00_00
--------------------------------------------------------------------------------------
--■??■徘徊デーモンの登場■ハンドラ登録
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。
		proxy:LuaCall( 4000, 100, "PlayerDeath_m03_01_00_00", everytime );
		--プレイヤーが復活した時にキックされます。
		proxy:LuaCall( 4032, 100, "PlayerRevive_m03_01_00_00", everytime );
	proxy:NotNetMessage_end();

	
--■682■ボス戦カメラ対応■
	--ボスが生きているなら登録
	if proxy:IsCompleteEvent(4756) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 682 , 10000 , 2886 ,"OnEvent_682" , everytime );
		proxy:NotNetMessage_end();
	end

--[[
	--フラグを見てNPC状態を初期化
	SetFirstNpcStateFlag( proxy, param, syuujin_flag_list, SYUUJIN_STATE_ESCAPE )

	--死亡していないとき
	if proxy:IsCompleteEvent( SYUUJIN_STATE_DEAD ) == false then
		--敵対していないとき
		if proxy:IsCompleteEvent( SYUUJIN_STATE_ANGRY_01 ) == false then
			--EzStateにコマンド送信:うつぶせ待機になる
			proxy:SetEventCommand(633,30);
			--■627■【水牢NPC】NPCが感謝状態じゃない■
			if proxy:IsCompleteEvent( 627 ) == false then
				proxy:OnRegistFunc( 627, "Condition_627", "OnEvent_627", 1, once );				
			end	
			--■628■【水牢NPC】NPCからアイテムをもらってない■
			if proxy:IsCompleteEvent( 628 ) == false then
				proxy:NotNetMessage_begin();
					proxy:LuaCall( 628, 0, "OnEvent_628", once );
				proxy:NotNetMessage_end();
			end
			--■629■【水牢NPC】NPCが敵になってない■
			if proxy:IsCompleteEvent( 629 ) == false then
				proxy:OnCharacterTotalDamage( 629, 633, 10000, 50, "OnEvent_629", once );
			end
			
		--それ以外の初期化
		else
			print("意味の無い所");
			proxy:EnableLogic( 633, false );
		end
		--■630■【水牢NPC】NPCが死んだ■
		if proxy:IsCompleteEvent( 630 ) == false then
			proxy:OnCharacterDead( 630, 633, "OnEvent_630", once );		
		end
	else
		print("水牢NPC死亡");		
		--死んでいるので無効化		
		proxy:ForceUpdateNextFrame(633);
		InvalidBackRead(proxy, 633 );		
	end	
	]]
	--古砦囚人状態変化詰め合わせ
	OnEvent_634(proxy,param);
	--なんだこのInvalid・・・
	--InvalidCharactor(proxy,326);
	
--■550■デブデーモン死亡監視■
	if proxy:IsCompleteEvent( 550 ) == false then
		proxy:OnCharacterDead( 550 , 421 , "OnEvent_550",once);
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 552 , 10000, 2269 , "OnEvent_552",everytime);
		proxy:NotNetMessage_end();
	else
		InvalidCharactor( proxy , 421 );
	end
	
--■790■魔法の壁破壊１■
	SingleReset(proxy,790);
	if proxy:IsCompleteEvent( 790 ) == false then
		--復帰
		proxy:RestorePiece( 1270 );
		proxy:OnObjectDestroy( 790 , 1270 ,"OnEvent_790",once);
	else
		proxy:ReconstructBreak( 1270,1);
	end
	
--■791■魔法の壁破壊２■
	SingleReset(proxy,791);
	if proxy:IsCompleteEvent( 791 ) == false then
		--復帰
		proxy:RestorePiece( 1271 );
		proxy:OnObjectDestroy( 791 , 1271 ,"OnEvent_791",once);
	else
		proxy:ReconstructBreak( 1271,1);
	end


--■15500■乱入アイテム取得監視■ハンドラはグローバルに定義
--~ 	if proxy:IsCompleteEvent( 15500 ) == false then		
--~ 		proxy:AddCorpseEvent( 15500 , 420 );--マスターサツキ・ブラック
--~ 	end
	
	-----------------------------------------------------------------------------
	--■999999■フレーム遅れの初期化処理イベントを発行■
	proxy:NotNetMessage_begin();
		--▼0秒後▼--
		proxy:OnKeyTime2( 999991, "Second_Initialize_m03_01_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	if proxy:IsDbgReLoad() == true then
		proxy:OnKeyTime2( 4021,"OnEvent_DbgReLoad",1.0,0,0,once);
	end
	print("Initialize_m03_01_00_00 end");
end

--リロードデバッグ
function OnEvent_DbgReLoad(proxy,param)
	--古砦要石に戻る
	--完全回復要求
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1007);	
end


--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく
function Second_Initialize_m03_01_00_00(proxy, param)
	print("Second_Initialize_m03_01_00_00 begin");

--------------------------------▽▽▽QWCイベント関連▽▽▽--------------------------------
--------------------------------△△△QWCイベント関連△△△--------------------------------

	print("Second_Initialize_m03_01_00_00 end");
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
	proxy:SetDeadMode2(804 , true );
	proxy:SetDeadMode2(805 , true );
	proxy:SetDeadMode2(822 , true );
	print("OnEvent_4000_Hp_1 end");
end

--[[
--同時発動によるハボックメモリテスト用
function test_destroy(proxy, param )
	local ObjID =0;
    for ObjID = 1208,1214,1 do
	--  proxy:ChangeModel(ObjID, 1);
	--	proxy:SetBrokenPiece(ObjID);
		proxy:ReconstructBreak( ObjID , 1 );
    end
	OnEvent_4766_1(proxy,param);
	OnEvent_4767_1(proxy,param);
	OnEvent_4768_1(proxy,param);
	OnEvent_4769_1(proxy,param);
	OnEvent_4770_1(proxy,param);
	
	OnEvent_4771_1(proxy,param);
	OnEvent_4772_1(proxy,param);
end
]]







--------------------------------------------------------------------------------------
--■644■ホストPCのみが通れる光の霧1■
--------------------------------------------------------------------------------------
--■644_delete_wall■魔法壁削除同期用■
function OnEvent_644_delete_wall(proxy , param)
	print("OnEvent_644_delete_wall begin");
	
	proxy:SetDrawEnable( 1332 , false );--描画OFF
	proxy:SetColiEnable( 1332 , false );--当たりOFF
	proxy:SetObjDeactivate( 1332 , true );--デアクティブ
	proxy:InvalidSfx( 2231 , true );--SFX OFF
	proxy:DeleteEvent( 644 );
	
	print("OnEvent_644_delete_wall end");
end

--■644■イベント発動用■
function OnEvent_644(proxy , param)
	print("OnEvent_644 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 644 ) == true then
		print("OnEvent_644 end");
		return;
	end

	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 644 , true );
		print("OnEvent_644 end");
		return;
	end
	
	--ダミポリへワープ
	proxy:WarpDmy( 10000 , 1332 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼644_1▼歩きアニメ終了▼
		--proxy:OnChrAnimEnd( 644 , 10000 , ANIMEID_WALK , "OnEvent_644_1" , once );
		proxy:LuaCallStart( 644 , 1 );--光の霧削除同期
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 644 , true );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_644 end");
end

--▲644_1▲歩きアニメ終了▲
function OnEvent_644_1(proxy , param)
	print("OnEvent_644_1 begin");
	
	proxy:LuaCallStart( 644 , 1 );--光の霧削除同期
	
	print("OnEvent_644_1 end");
end


--------------------------------------------------------------------------------------
--■645■ホストPCのみが通れる光の霧2■
--------------------------------------------------------------------------------------
--■645_delete_wall■魔法壁削除同期用■
function OnEvent_645_delete_wall(proxy , param)
	print("OnEvent_645_delete_wall begin");
	
	proxy:SetDrawEnable( 1333 , false );--描画OFF
	proxy:SetColiEnable( 1333 , false );--当たりOFF
	proxy:SetObjDeactivate( 1333 , true );--デアクティブ
	proxy:DeleteEvent( 645 );
	proxy:InvalidSfx( 2232 , true );--SFX OFF
	
	print("OnEvent_645_delete_wall end");
end

--■645■イベント発動用■
function OnEvent_645(proxy , param)
	print("OnEvent_645 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 645 ) == true then
		print("OnEvent_645 end");
		return;
	end

	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 645 , true );
		print("OnEvent_645 end");
		return;
	end
	
	--ダミポリへワープ
	proxy:WarpDmy( 10000 , 1333 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼645_1▼歩きアニメ終了▼
		--proxy:OnChrAnimEnd( 645 , 10000 , ANIMEID_WALK , "OnEvent_645_1" , once );
		proxy:LuaCallStart( 645 , 1 );--光の霧削除同期
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 645 , true );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_645 end");
end

--▲645_1▲歩きアニメ終了▲
function OnEvent_645_1(proxy , param)
	print("OnEvent_645_1 begin");
	
	proxy:LuaCallStart( 645 , 1 );--光の霧削除同期
	
	print("OnEvent_645_1 end");
end


--------------------------------------------------------------------------------------
--■646■ホストPCのみが通れる光の霧3■
--------------------------------------------------------------------------------------
--■646_delete_wall■魔法壁削除同期用■
function OnEvent_646_delete_wall(proxy , param)
	print("OnEvent_646_delete_wall begin");
	
	proxy:SetDrawEnable( 1334 , false );--描画OFF
	proxy:SetColiEnable( 1334 , false );--当たりOFF
	proxy:InvalidSfx( 2233 , true );--SFX OFF
	proxy:SetObjDeactivate( 1334 , true );--デアクティブ
	proxy:DeleteEvent( 646 );
	
	print("OnEvent_646_delete_wall end");
end

--■646■イベント発動用■
function OnEvent_646(proxy , param)
	print("OnEvent_646 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 646 ) == true then
		print("OnEvent_646 end");
		return;
	end

	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 646 , true );
		print("OnEvent_646 end");
		return;
	end
	
	--ダミポリへワープ
	proxy:WarpDmy( 10000 , 1334 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼646_1▼歩きアニメ終了▼
		--proxy:OnChrAnimEnd( 646 , 10000 , ANIMEID_WALK , "OnEvent_646_1" , once );
		proxy:LuaCallStart( 646 , 1 );--光の霧削除同期
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 646 , true );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_646 end");
end

--▲646_1▲歩きアニメ終了▲
function OnEvent_646_1(proxy , param)
	print("OnEvent_646_1 begin");
	
	proxy:LuaCallStart( 646 , 1 );--光の霧削除同期
	
	print("OnEvent_646_1 end");
end


--------------------------------------------------------------------------------------
--ボス部屋の中に入る■594
--------------------------------------------------------------------------------------
--■イベントがループなので、全部リピートにする↓
--■594■中ボス部屋への扉が開く■
function OnEvent_594(proxy,param)
	print("OnEvent_594 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_594 end");
		return;
	end
	
	--クライアントへ、ボス部屋阻止失敗を通知
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 593 , 1 );--旋回アニメの同期再生
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--多重起動システムIDをタイムアウトを設定してONにする
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_594 end");
end


--旋回アニメの同期再生(IDが別)
function OnEvent_594_1(proxy,param)
	print("OnEvent_594_1 begin");

	--proxy:SetEventFlag( 593 , 0 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を同期
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2890 );
		else
			proxy:LockSession();--ルームをロックします！
			--旋回アニメ再生を行い、その終了時にOnEvent_593_2を発行する
			proxy:OnTurnCharactorEnd( 593, 10000, 2890, "OnEvent_594_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	--proxy:SetEventFlag( 593 , 1 );
	
	print("OnEvent_594_1 end");
end

--旋回アニメの同期再生終了後
function OnEvent_594_2(proxy,param)
	print("OnEvent_594_2 begin");

	--proxy:SetEventFlag( 593 , 0 );
	
	--同期用歩きアニメ再生
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 593, 10000, ANIMEID_WALK, "OnEvent_594_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	--proxy:SetEventFlag( 593 , 1 );
	
	print("OnEvent_594_2 end");
end

--歩きアニメの同期再生終了後
function OnEvent_594_3(proxy,param)
	print("OnEvent_594_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ
	if proxy:IsCompleteEvent( 594 ) == false then
		proxy:LuaCallStart( 593 , 5 );--2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知
		proxy:LuaCallStart( 593 , 6 );--フラグセット(同期用)
		Lua_MultiDoping(proxy,804);--マルチプレイドーピング
	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない)
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:ResetThink( 804 );
	end
	
	
	--proxy:SetEventFlag( 593 , 0 );--多重発動防止用フラグOFF
	proxy:SetEventFlag( SYSTEM_ID_IGNORE,false);
	
	print("OnEvent_594_3 end");
end


--■594 2回目以降にボス部屋に入るためのイベント配信用
function OnEvent_594_GO_TO_IN(proxy, param)
	print("OnEvent_594_GO_TO_IN begin");
	
	--proxy:SetEventFlag( 593 , 0 );
	
	proxy:NotNetMessage_begin();
		--▼593▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_111
		proxy:OnPlayerActionInRegion( 593, 2894, "OnEvent_594", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 593, "StandBy_Sinpansya",0.5,0,0,once);	
	proxy:NotNetMessage_end();

	--proxy:SetEventFlag( 593 , 1 );
	
	print("OnEvent_594_GO_TO_IN end");
end


--■594 フラグセット(同期用)
function OnEvent_594_flag_set(proxy, param)
	print("OnEvent_594_flag_set begin");
		
	proxy:SetEventFlag( 594 , true );
	proxy:DeleteEvent( 594 );

	print("OnEvent_594_flag_set end");
end

--[[イベント削除されたのでコメントアウト
--------------------------------------------------------------------------------------
--閂(かんぬき)扉A■532
--------------------------------------------------------------------------------------
function OnEvent_532(proxy, param)
	print("OnEvent_532 begin");
	
	--閂扉アニメ再生(扉が開く)
	proxy:PlayAnimation( 1204, 1 );

	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_KICK ) == true then
		print("OnEvent_532 end");
		proxy:SetEventFlag( 532, true );
		return;
	end

	proxy:WarpDmy( 10000 , 1204 , 191 );
	proxy:SetEventFlag( 532, true );
	
	print("OnEvent_532 end");
end]]


--[[
--------------------------------------------------------------------------------------
--鷹の攻撃■636
--------------------------------------------------------------------------------------
--■636■鷹の攻撃■
function Check_636(proxy,param)
	local region = { 2278 };
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
		proxy:SetInsideBattleArea(325,0);
	end
	
	return isIn;
end

--領域に入っている
function OnEvent_636(proxy,param)
	proxy:SetInsideBattleArea(325,1);
end

--鷹が死んだ
function OnEvent_636_1(proxy,param)
	print("OnEvent_636_1 begin");
	proxy:DeleteEvent( 636 );
	print("OnEvent_636_1 end");
end
]]
--[[
--------------------------------------------------------------------------------------
--鷹の攻撃■637
--------------------------------------------------------------------------------------
--■637■鷹の攻撃■
function Check_637(proxy,param)
	local region = { 2279 };
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
		proxy:SetInsideBattleArea(326,0);
	end
	
	return isIn;
end

--領域に入っている
function OnEvent_637(proxy,param)
	proxy:SetInsideBattleArea(326,1);
end

--鷹が死んだ
function OnEvent_637_1(proxy,param)
	print("OnEvent_637_1 begin");
	proxy:DeleteEvent( 637 );
	print("OnEvent_637_1 end");
end
]]
--[[
--------------------------------------------------------------------------------------
--鷹の攻撃■638
--------------------------------------------------------------------------------------
--■638■鷹の攻撃■
function Check_638(proxy,param)
	local region = { 2280 };
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
		proxy:SetInsideBattleArea(327,0);
	end
	
	return isIn;
end

--領域に入っている
function OnEvent_638(proxy,param)
	proxy:SetInsideBattleArea(327,1);
end

--鷹が死んだ
function OnEvent_638_1(proxy,param)
	print("OnEvent_638_1 begin");
	proxy:DeleteEvent( 638 );
	print("OnEvent_638_1 end");
end
]]

--------------------------------------------------------------------------------------
--ボスBGM停止■642
--------------------------------------------------------------------------------------
--■642■ボスが死んだ瞬間■
function OnEvent_642(proxy,param)
	print("OnEvent_642 begin");	
	proxy:NotNetMessage_begin();
		--▼4756▼***条件追加***1秒後に扉が開く▼
		proxy:OnKeyTime2( 642, "OnEvent_642_1", 0, 0, 0, once );
	proxy:NotNetMessage_end();
	print("OnEvent_642 end");
end

--■642_1■死んでから1秒後■
function OnEvent_642_1(proxy,param)
	print("OnEvent_642_1 begin");
	proxy:StopPointSE( 1 );--ボス戦用BGM停止
	proxy:SetEventFlag( 642 ,true );
--	BlockClear(proxy,param);
	print("OnEvent_642_1 end");
end


--------------------------------------------------------------------------------------
--中ボス死亡で扉が開く■4756
--------------------------------------------------------------------------------------
--■4756■中ボス死亡で扉が開く■
function OnEvent_4756(proxy, param)
	print("OnEvent_4756 begin");
	
	proxy:NotNetMessage_begin();
		--▼4756_1▼***条件追加***0秒後に扉が開く▼
		proxy:OnKeyTime2( 4756, "OnEvent_4756_1", 0, 0, 0, once );
		--▼4756_2▼2秒経過▼
		proxy:OnKeyTime2( 4992, "OnEvent_4756_2", 0, 0, 1, once);
	proxy:NotNetMessage_end();
	
	proxy:CustomLuaCallStart( 4050 , 804 );--ブロッククリア処理
	--トカゲリセット
	ResetTokage(proxy);
	
	--マルチプレイ時にすぐ次のエリアにいけてしまう問題回避
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc( 4756 , "Check_4756_PT","OnEvent_4756_PT",0,once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 4756, true );--ボスの死亡記録用
	proxy:SetEventFlag( 4800, true );--新仕様のフラグも立てる

	print("OnEvent_4756 end");
end

--▲4756_1▲0秒後に扉が開く▲
function OnEvent_4756_1(proxy, param)
	print("OnEvent_4756_1 begin");	
	
	--ボスを倒した数を更新(数によってフラグを立てる)
	GetBossFlagCount( proxy, param );
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
	if proxy:IsCompleteEvent( 4804 ) == false then
		proxy:ValidSfx( 2287 );--光の粒子
		proxy:ValidSfx( 2286 );--SFX 有効化
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--光らせる
		proxy:OnDistanceActionAttribute( 4804 , 10000 , 1981 , "OnEvent_4804" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end
------------------------
	
	--▼トロフィーの取得▼
	Lua_RequestUnlockTrophy( proxy, 30 );
	
	--古砦囚人の状態遷移チェック
	OnEvent_634(proxy,param)
	
	print("OnEvent_4756_1 end");
end

--▲4756_2▲城内部扉開放:中ボス死亡後0秒▲
function OnEvent_4756_2(proxy, param)
	print("OnEvent_4756_2 begin");
		
	--ボス戦用のBGM停止
	proxy:StopPointSE( 1 );	
	
	print("OnEvent_4756_2 end");
end

--PTを組んでいるかのチェック
function Check_4756_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--PT解散が終わったイベント
function OnEvent_4756_PT(proxy,param)
	print("OnEvent_4756_PT begin");
	
	proxy:PlayAnimation( 1206, 1 );	--扉アニメ再生
	
	--中ボス部屋の前後の魔法壁が消える(全プレイヤー)	
	proxy:SetColiEnable( 1998 , false );	
	proxy:SetDrawEnable( 1998 , false );
	--proxy:SetObjDeactivate( 1998 , true );--デアクティブ
	
	proxy:SetColiEnable( 1994 , false );	
	proxy:SetDrawEnable( 1994 , false );
	--proxy:SetObjDeactivate( 1994 , true );--デアクティブ
	
	--中ボス部屋魔法壁のSFX削除
	proxy:InvalidSfx( 1990 , true );
	proxy:InvalidSfx( 1986 , true );
	
	--中ボス部屋前の移動処理イベントを削除
	proxy:DeleteEvent( 594 );--一人目が入るとき用
	proxy:DeleteEvent( 593 );--二人目以降が入るとき用
	proxy:DeleteEvent( 641 );--ボス戦闘開始用	
	print("OnEvent_4756_PT end");
end


--------------------------------------------------------------------------------------
--■4805■石柱にワープ■
--------------------------------------------------------------------------------------
function OnEvent_4805(proxy,param)	
	print("OnEvent_4805 begin");
	
	proxy:RepeatMessage_begin();
		--▼70_1▼選択メニューの監視▼
		proxy:OnSelectMenu(4805, "OnEvent_4805_1", 10010710, 0, 2, 1981, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_4805 end");
end

--▲4805_1▲選択メニューの監視▲
function OnEvent_4805_1(proxy,param)	
	print("OnEvent_4805_1 begin");
	
	if proxy:IsSession() == false then
		if param:IsNetMessage() == true then
			proxy:PlayAnimation(10001+param:GetPlayID(),8305);
			print("OnEvent_4805_1 end");
			return;
		end
			
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1981 ,TURNSKIP_ANGLE);
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd( 4805 , 10000 , 8283 , "OnEvent_4805_2",once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
			
		proxy:SetEventFlag(4805,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	print("OnEvent_4805_1 end");
end

--■4805_2■石柱にワープ■
function OnEvent_4805_2(proxy,param)	
	print("OnEvent_4805_2 begin");	
	
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生
	--石柱へ戻ってきた判定のフラグを立てる
	proxy:SetEventFlag(8083, true);
	
	--古砦要石に戻る
	--完全回復要求
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1007);	
	print("OnEvent_4805_2 end");
end

--------------------------------------------------------------------------------------
--■4804■ソウル入手■
--------------------------------------------------------------------------------------
function OnEvent_4804(proxy, param)
	print("OnEvent_4804 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ 
		print("OnEvent_4804 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行
		proxy:OnKeyTime2( 4804, "OnEvent_4804_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4804 end");
end


--■4804_1■アイテム取得■
function OnEvent_4804_1(proxy, param)
	print("OnEvent_4804_1 begin");

	--アイテム取得関数--パラメータ10230参照
	proxy:GetRateItem(10230);	
	--アイテム取得関数--パラメータ10270参照
	proxy:GetRateItem(10270);	
	--アイテム取得関数--パラメータ10271参照
	proxy:GetRateItem(10271);	
	--アイテム取得関数--パラメータ10272参照
	proxy:GetRateItem(10272);	
	--アイテム取得関数--パラメータ10273参照
	proxy:GetRateItem(10273);	
	
	--アイテムを取得済み
	proxy:SetEventFlag( 4804, true	);
	--宝箱シェーダーは消えない
	--proxy:TreasureDispModeChange( 1981 , false );

	--SFXが消える
	proxy:InvalidSfx( 2286 , true );
	--proxy:InvalidSfx( 2287 , true );--光の粒子
		
	--▼要石でワープ用の監視を追加▼
	proxy:OnDistanceActionAttribute( 4805 , 10000 , 1981 , "OnEvent_4805" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_4804_1 end");
end

--------------------------------------------------------------------------------------
--はしごA上■542
--------------------------------------------------------------------------------------
--■542■はしごA上■
function OnEvent_542(proxy, param)
	print("OnEvent_542 begin");

	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_542 end");
		return;
	end

	--はしご降りに必要な前処理--
	proxy:BeginAction(10000,2,2,2);				--ホバー移動モードに移行
	proxy:HoverMoveValDmy(10000,1330,192,LadderTime_A);--移動位置(192)に0.5秒でホバー移動
	proxy:SetEventCommand(10000,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行
		proxy:OnKeyTime2(542,"OnEvent_542_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理)
		proxy:OnKeyTime2(542,"LadderDown",3.0,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_542 end");
end

function OnEvent_542_1(proxy, param)
	print("OnEvent_542_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_542_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	proxy:BeginAction(10000,1,7,6);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_542_1 end");
end


--------------------------------------------------------------------------------------
--はしごA下■543
--------------------------------------------------------------------------------------
--■543■はしごA下■
function OnEvent_543(proxy, param)
	print("OnEvent_543 begin");

	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_543 end");
		return;
	end

	--はしご降りに必要な前処理--
	proxy:BeginAction(10000,2,-1,1);			--ホバー移動モードに移行
	proxy:HoverMoveValDmy(10000,1330,191,LadderTime_A);--移動位置(191)に0.5秒でホバー移動
	proxy:SetEventCommand(10000,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行
		proxy:OnKeyTime2(543,"OnEvent_543_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理)
		proxy:OnKeyTime2(543,"LadderDown",3.0,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_543 end");
end

function OnEvent_543_1(proxy, param)
	print("OnEvent_543_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_543_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	proxy:BeginAction(10000,1,-1,6);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_543_1 end");
end


--------------------------------------------------------------------------------------
--ボスが動き出す(戦闘開始)■641
--------------------------------------------------------------------------------------
--■641■PCが戦闘領域に入った■
function OnEvent_641(proxy, param)
	print("OnEvent_641 begin");	
	--ボス戦用BGM再生開始
	proxy:PlayPointSE( 2000, SOUND_TYPE_M, 30100000, 1 );	
	--ボスロジックON
	proxy:EnableLogic( 804 , true );	
	--読み込みタイミングのとき毎回追加されてほしいのでフラグたてない
	
	--審判者イベントスタート
	BossEventStart_Sinpansya(proxy,param);
	
	proxy:OnKeyTime2( 595, "OnEvent_595", 1.5, 0, 0, once );
	
	--ボスゲージ表示
	proxy:SetBossGauge( 804 , 0 ,5040 );
	
	print("OnEvent_641 end");
end

---------------------
--ボス登場演出■595
---------------------
--■595■ボス登場演出■
function OnEvent_595(proxy, param)
	print("OnEvent_595 begin");

	proxy:PlayAnimation( 804, 7100 );
	
	proxy:SetEventFlag( 595, true );

	print("OnEvent_595 end");
end


--------------------------------------------------------------------------------------
--石柱にワープ■583
--------------------------------------------------------------------------------------

--■583■石柱にワープ■
function OnEvent_583(proxy,param)	

	if proxy:IsCompleteEvent( 583 ) == true then
		return;
	end
	
	if param:IsNetMessage() == true then
		return;
	end
	
	
	print("OnEvent_583 begin");
	
	--セッション中ではないか？
	if proxy:IsSession() == false then
		proxy:RepeatMessage_begin();
			--▼583_1▼選択メニューの監視▼
			proxy:OnSelectMenu(583, "OnEvent_583_0", 10010710, 0, 2, 1983, 2, once);			
		proxy:RepeatMessage_end();
	else
		--セッション中なんで表示
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010720, 1);
		--proxy:ShowGenDialog(10010720,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end

	print("OnEvent_583 end");
end

--▲583_0▲選択メニューの監視▲
function OnEvent_583_0(proxy, param)
	print("OnEvent_583_0 begin");
	if proxy:IsSession() == false then
		proxy:PlayAnimation( 10000 , 8283 );--要石に触れるアニメを再生
		proxy:NoAnimeTurnCharactor( 10000 , 1983 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--▼要石に触れるアニメ再生終了▼
			proxy:OnChrAnimEnd( 583 , 10000 , 8283 , "OnEvent_583_1" , once );
		proxy:NotNetMessage_end();

		proxy:SetEventFlag( 583 , true );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	print("OnEvent_583_0 end");
end

--▲583_1▲選択メニューの監視▲
function OnEvent_583_1(proxy, param)
	print("OnEvent_583_1 begin");
	
	proxy:SetEventFlag( 583 , 0 );
	
	proxy:PlayAnimation( 10000 , 8284 );--要石に触れるアニメを再生
	
	--[[
	proxy:NotNetMessage_begin();
		--▼要石に触れるアニメ再生終了▼
		proxy:OnChrAnimEnd( 583 , 10000 , 8284 , "OnEvent_583_2" , once );
	proxy:NotNetMessage_end();
	]]
	OnEvent_583_2(proxy,param);
	--proxy:SetEventFlag( 583 , true );
	
	print("OnEvent_583_1 end");
end

--▲要石に触れるアニメ再生終了▲
function OnEvent_583_2(proxy,param)	
	print("OnEvent_583_2 begin");
	
	--石柱へ戻ってきた判定のフラグを立てる
	proxy:SetEventFlag(8083, true);

	proxy:SetEventFlag( 583 , 0 );
	--完全回復要求
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1007 );
	
	print("OnEvent_583_2 end");
end


--------------------------------------------------------------------------------------
--牢の扉■639
--------------------------------------------------------------------------------------
--■639■牢の扉■
function OnEvent_639(proxy,param)
	--必要アイテムの指定
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 9;--水牢の鍵
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010803, 0, 6, 1331, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_639_1(proxy,param);

	--必要アイテムを所持していない
	else
		--扉が開かない場合のメッセージを表示
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1331, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end
end

--選択メニューでYESを選択
function OnEvent_639_1(proxy,param)
	print("OnEvent_639_1 begin");
	--イベント発動を配信する為、LuaCallを噛ませる
	proxy:LuaCallStart( 639, 1 );
	print("OnEvent_639_1 end");
end

--結果を配信
function OnEvent_639_2(proxy,param)
	print("OnEvent_639_2 begin");
	proxy:PlayAnimation( 1331, 1 );--扉が開くアニメーション
	
	proxy:SetEventFlag( 639, true );	
	proxy:DeleteEvent( 639 );	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		return;
	end
	proxy:WarpDmy( 10000 , 1331 , 191 );
	print("OnEvent_639_2 end");
end


--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4766
--------------------------------------------------------------------------------------
--■4766■中ボス部屋　床破壊■
function OnEvent_4766(proxy, param)
	print("OnEvent_4766 begin");
	
	--すぐにダメージを発生させるとプレイヤーに当たる為、待ち時間をいれる
	--▼4766_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4766, "OnEvent_4766_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4766 end");
end

--▲4766_1▲１秒後▲
function OnEvent_4766_1(proxy, param)
	print("OnEvent_4766_1 begin");
	
	------------------------パラメータ説明--------------------------------
	--	アクションID(4766),ターゲットOBJ(1208),ターゲットのダミポリID(1)
	--	ダメージ量(50),ダメージ球当たり半径(2.0),ダメージ球有効時間(5.0秒)
	--	ダメージ球の衝突時に(OnEvent_4766_2)発行
	----------------------------------------------------------------------
	--▼4766_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4766, 1208, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4766_2", once );
	proxy:NotNetMessage_end();
	
	-- フラグをセット
	proxy:SetEventFlag( 4766, true );
	
	print("OnEvent_4766_1 end");
end

--▲4766_2▲ダメージ球が当たった▲
function OnEvent_4766_2(proxy, param)
	print("OnEvent_4766_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定
	--ダミポリを使うのでモデル差し替えなどのタイミングに注意!!
	--差し替えた後のモデルに指定IDのダミポリが無い場合保障できません。)	
	SecondStageBreak(proxy,1208,2);	
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1208,1,93100);
	
	print("OnEvent_4766_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4767
--------------------------------------------------------------------------------------
--■4767■中ボス部屋　床破壊■
function OnEvent_4767(proxy, param)
	print("OnEvent_4767 begin");
	
	--▼4767_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4767, "OnEvent_4767_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4767 end");
end

--▲4767_1▲１秒後▲
function OnEvent_4767_1(proxy, param)
	print("OnEvent_4767_1 begin");
	
	--▼4767_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4767, 1209, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4767_2", once );
	proxy:NotNetMessage_end();
	-- フラグをセット
	proxy:SetEventFlag( 4767, true );
	
	print("OnEvent_4767_1 end");
end

--▲4767_2▲ダメージ球が当たった▲
function OnEvent_4767_2(proxy, param)
	print("OnEvent_4767_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定
	SecondStageBreak(proxy,1209,2);	
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1209,1,93100);
	
	print("OnEvent_4767_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4768
--------------------------------------------------------------------------------------
--■4768■中ボス部屋　床破壊■
function OnEvent_4768(proxy, param)
	print("OnEvent_4768 begin");
	
	--▼4768_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4768, "OnEvent_4768_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4768 end");
end

--▲4768_1▲１秒後▲
function OnEvent_4768_1(proxy, param)
	print("OnEvent_4768_1 begin");
	
	--▼4768_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4768, 1210, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4768_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット
	proxy:SetEventFlag( 4768, true );
	
	print("OnEvent_4768_1 end");
end

--▲4768_2▲ダメージ球が当たった▲
function OnEvent_4768_2(proxy, param)
	print("OnEvent_4768_2 begin");
	
	SecondStageBreak(proxy,1210,2);	
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1210,1,93100);
	
	print("OnEvent_4768_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4769
--------------------------------------------------------------------------------------
--■4769■中ボス部屋　床破壊■
function OnEvent_4769(proxy, param)
	print("OnEvent_4769 begin");
	
	--▼4769_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4769, "OnEvent_4769_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	print("OnEvent_4769 end");
end

--▲4769_1▲１秒後▲
function OnEvent_4769_1(proxy, param)
	print("OnEvent_4769_1 begin");
	
	--▼4769_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4769, 1211, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4769_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット
	proxy:SetEventFlag( 4769, true );
	
	print("OnEvent_4769_1 end");
end

--▲4769_2▲ダメージ球が当たった▲
function OnEvent_4769_2(proxy, param)
	print("OnEvent_4769_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定
	SecondStageBreak(proxy,1211,2);
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1211,1,93100);	
	
	print("OnEvent_4769_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4770
--------------------------------------------------------------------------------------
--■4770■中ボス部屋　床破壊■
function OnEvent_4770(proxy, param)
	print("OnEvent_4770 begin");
	
	--▼4770_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4770, "OnEvent_4770_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4770 end");
end

--▲4770_1▲１秒後▲
function OnEvent_4770_1(proxy, param)
	print("OnEvent_4770_1 begin");
	
	--▼4770_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4770, 1212, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4770_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット
	proxy:SetEventFlag( 4770, true );
	
	print("OnEvent_4770_1 end");
end

--▲4770_2▲ダメージ球が当たった▲
function OnEvent_4770_2(proxy, param)
	print("OnEvent_4770_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定
	SecondStageBreak(proxy,1212,2);	
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1212,1,93100);
	
	print("OnEvent_4770_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4771
--------------------------------------------------------------------------------------
--■4771■中ボス部屋　床破壊■
function OnEvent_4771(proxy, param)
	print("OnEvent_4771 begin");
	
	--▼4771_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4771, "OnEvent_4771_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4771 end");
end

--▲4771_1▲１秒後▲
function OnEvent_4771_1(proxy, param)
	print("OnEvent_4771_1 begin");
	
	--▼4771_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4771, 1213, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4771_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット
	proxy:SetEventFlag( 4771, true );
	
	print("OnEvent_4771_1 end");
end

--▲4771_2▲ダメージ球が当たった▲
function OnEvent_4771_2(proxy, param)
	print("OnEvent_4771_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定
	SecondStageBreak(proxy,1213,2);	
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1213,1,93100);
	
	print("OnEvent_4771_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4772
--------------------------------------------------------------------------------------
--■4772■中ボス部屋　床破壊■
function OnEvent_4772(proxy, param)
	print("OnEvent_4772 begin");
	
	--▼4772_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4772, "OnEvent_4772_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4772 end");
end

--▲4772_1▲１秒後▲
function OnEvent_4772_1(proxy, param)
	print("OnEvent_4772_1 begin");
	
	--▼4772_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4772, 1214, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4772_2", once );
	proxy:NotNetMessage_end();
	-- フラグをセット
	proxy:SetEventFlag( 4772, true );
	
	print("OnEvent_4772_1 end");
end

--▲4772_2▲ダメージ球が当たった▲
function OnEvent_4772_2(proxy, param)
	print("OnEvent_4772_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定
	SecondStageBreak(proxy,1214,2);	
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1214,1,93100);
	
	print("OnEvent_4772_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4773
--------------------------------------------------------------------------------------
--■4773■中ボス部屋　床破壊■
function OnEvent_4773(proxy, param)
	print("OnEvent_4773 begin");
	
	--▼4773_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4773, "OnEvent_4773_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4773 end");
end

--▲4773_1▲１秒後▲
function OnEvent_4773_1(proxy, param)
	print("OnEvent_4773_1 begin");
	
	--▼4773_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4773, 1215, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4773_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット
	proxy:SetEventFlag( 4773, true );
	
	print("OnEvent_4773_1 end");
end

--▲4773_2▲ダメージ球が当たった▲
function OnEvent_4773_2(proxy, param)
	print("OnEvent_4773_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定
	SecondStageBreak(proxy,1215,2);	
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1215,1,93100);
	
	print("OnEvent_4773_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4774
--------------------------------------------------------------------------------------
--■4774■中ボス部屋　床破壊■
function OnEvent_4774(proxy, param)
	print("OnEvent_4774 begin");
	
	--▼4774_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4774, "OnEvent_4774_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4774 end");
end

--▲4774_1▲１秒後▲
function OnEvent_4774_1(proxy, param)
	print("OnEvent_4774_1 begin");
	
	--▼4774_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4774, 1216, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4774_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット
	proxy:SetEventFlag( 4774, true );
	
	print("OnEvent_4774_1 end");
end

--▲4774_2▲ダメージ球が当たった▲
function OnEvent_4774_2(proxy, param)
	print("OnEvent_4774_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定
	SecondStageBreak(proxy,1216,2);	
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1216,1,93100);
	
	print("OnEvent_4774_2 end");
end



--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4775
--------------------------------------------------------------------------------------
--■4775■中ボス部屋　床破壊■
function OnEvent_4775(proxy, param)
	print("OnEvent_4775 begin");
	
	--▼4775_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4775, "OnEvent_4775_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4775 end");
end

--▲4775_1▲１秒後▲
function OnEvent_4775_1(proxy, param)
	print("OnEvent_4775_1 begin");
	
	--▼4775_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4775, 1217, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4775_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット
	proxy:SetEventFlag( 4775, true);
	
	print("OnEvent_4775_1 end");
end

--▲4775_2▲ダメージ球が当たった▲
function OnEvent_4775_2(proxy, param)
	print("OnEvent_4775_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定
	SecondStageBreak(proxy,1217,2);	
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1217,1,93100);
	
	print("OnEvent_4775_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4776
--------------------------------------------------------------------------------------
--■4776■中ボス部屋　床破壊■
function OnEvent_4776(proxy, param)
	print("OnEvent_4776 begin");
	
	--▼4776_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4776, "OnEvent_4776_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4776 end");
end

--▲4776_1▲１秒後▲
function OnEvent_4776_1(proxy, param)
	print("OnEvent_4776_1 begin");
	
	--▼4776_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4776, 1218, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4776_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット
	proxy:SetEventFlag( 4776, true );
	
	print("OnEvent_4776_1 end");
end

--▲4776_2▲ダメージ球が当たった▲
function OnEvent_4776_2(proxy, param)
	print("OnEvent_4776_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定
	SecondStageBreak(proxy,1218,2);	
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1218,1,93100);

	print("OnEvent_4776_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4777
--------------------------------------------------------------------------------------
--■4777■中ボス部屋　床破壊■
function OnEvent_4777(proxy, param)
	print("OnEvent_4777 begin");
	
	--▼4777_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4777, "OnEvent_4777_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4777 end");
end

--▲4777_1▲１秒後▲
function OnEvent_4777_1(proxy, param)
	print("OnEvent_4777_1 begin");
	
	--▼4777_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4777, 1219, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4777_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット
	proxy:SetEventFlag( 4777, true );
	
	print("OnEvent_4777_1 end");
end

--▲4777_2▲ダメージ球が当たった▲
function OnEvent_4777_2(proxy, param)
	print("OnEvent_4777_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定
	SecondStageBreak(proxy,1219,2);	
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1219,1,93100);
	
	print("OnEvent_4777_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4778
--------------------------------------------------------------------------------------
--■4778■中ボス部屋　床破壊■
function OnEvent_4778(proxy, param)
	print("OnEvent_4778 begin");
	
	--▼4778_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4778, "OnEvent_4778_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4778 end");
end

--▲4778_1▲１秒後▲
function OnEvent_4778_1(proxy, param)
	print("OnEvent_4778_1 begin");
	
	--▼4778_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4778, 1220, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4778_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット
	proxy:SetEventFlag( 4778, true);
	
	print("OnEvent_4778_1 end");
end

--▲4778_2▲ダメージ球が当たった▲
function OnEvent_4778_2(proxy, param)
	print("OnEvent_4778_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定
	SecondStageBreak(proxy,1220,2);	
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1220,1,93100);
	
	print("OnEvent_4778_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4779
--------------------------------------------------------------------------------------
--■4779■中ボス部屋　床破壊■
function OnEvent_4779(proxy, param)
	print("OnEvent_4779 begin");
	
	--▼4779_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4779, "OnEvent_4779_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4779 end");
end

--▲4779_1▲１秒後▲
function OnEvent_4779_1(proxy, param)
	print("OnEvent_4779_1 begin");
	
	--▼4779_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4779, 1221, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4779_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット
	proxy:SetEventFlag( 4779, true );
	
	print("OnEvent_4779_1 end");
end

--▲4779_2▲ダメージ球が当たった▲
function OnEvent_4779_2(proxy, param)
	print("OnEvent_4779_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定
	SecondStageBreak(proxy,1221,2);	
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1221,1,93100);
	
	print("OnEvent_4779_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4780
--------------------------------------------------------------------------------------
--■4780■中ボス部屋　床破壊■
function OnEvent_4780(proxy, param)
	print("OnEvent_4780 begin");
	
	--▼4780_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4780, "OnEvent_4780_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4780 end");
end

--▲4780_1▲１秒後▲
function OnEvent_4780_1(proxy, param)
	print("OnEvent_4780_1 begin");
	
	--▼4780_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4780, 1222, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4780_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット
	proxy:SetEventFlag( 4780, true );
	
	print("OnEvent_4780_1 end");
end

--▲4780_2▲ダメージ球が当たった▲
function OnEvent_4780_2(proxy, param)
	print("OnEvent_4780_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定
	SecondStageBreak(proxy,1222,2);	
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1222,1,93100);
	
	print("OnEvent_4780_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4781
--------------------------------------------------------------------------------------
--■4781■中ボス部屋　床破壊■
function OnEvent_4781(proxy, param)
	print("OnEvent_4781 begin");
	
	--▼4781_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4781, "OnEvent_4781_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4781 end");
end

--▲4781_1▲１秒後▲
function OnEvent_4781_1(proxy, param)
	print("OnEvent_4781_1 begin");
	
	--▼4781_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4781, 1223, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4781_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット
	proxy:SetEventFlag( 4781, true );
	
	print("OnEvent_4781_1 end");
end

--▲4781_2▲ダメージ球が当たった▲
function OnEvent_4781_2(proxy, param)
	print("OnEvent_4781_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定
	SecondStageBreak(proxy,1223,2);	
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1223,1,93100);
	
	print("OnEvent_4781_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4782
--------------------------------------------------------------------------------------
--■4782■中ボス部屋　床破壊■
function OnEvent_4782(proxy, param)
	print("OnEvent_4782 begin");
	
	--▼4782_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4782, "OnEvent_4782_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4782 end");
end

--▲4782_1▲１秒後▲
function OnEvent_4782_1(proxy, param)
	print("OnEvent_4782_1 begin");
	
	--▼4782_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4782, 1224, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4782_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット
	proxy:SetEventFlag( 4782, true );
	
	print("OnEvent_4782_1 end");
end

--▲4782_2▲ダメージ球が当たった▲
function OnEvent_4782_2(proxy, param)
	print("OnEvent_4782_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定
	SecondStageBreak(proxy,1224,2);	
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1224,1,93100);
	
	print("OnEvent_4782_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4783
--------------------------------------------------------------------------------------
--■4783■中ボス部屋　床破壊■
function OnEvent_4783(proxy, param)
	print("OnEvent_4783 begin");
	
	--▼4783_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4783, "OnEvent_4783_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4783 end");
end

--▲4783_1▲１秒後▲
function OnEvent_4783_1(proxy, param)
	print("OnEvent_4783_1 begin");
	
	--▼4783_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4783, 1225, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4783_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット
	proxy:SetEventFlag( 4783, true );
	
	print("OnEvent_4783_1 end");
end

--▲4783_2▲ダメージ球が当たった▲
function OnEvent_4783_2(proxy, param)
	print("OnEvent_4783_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定
	SecondStageBreak(proxy,1225,2);	
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1225,1,93100);
	
	print("OnEvent_4783_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4784
--------------------------------------------------------------------------------------
--■4784■中ボス部屋　床破壊■
function OnEvent_4784(proxy, param)
	print("OnEvent_4784 begin");
	
	--▼4784_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4784, "OnEvent_4784_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4784 end");
end

--▲4784_1▲１秒後▲
function OnEvent_4784_1(proxy, param)
	print("OnEvent_4784_1 begin");
	
	--▼4784_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();	
		proxy:OnObjectDamageHit( 4784, 1226, 1, 10030,EV_HIT_ALL, 2.0, 5.0, "OnEvent_4784_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット
	proxy:SetEventFlag( 4784, true );
	
	print("OnEvent_4784_1 end");
end

--▲4784_2▲ダメージ球が当たった▲
function OnEvent_4784_2(proxy, param)
	print("OnEvent_4784_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定
	SecondStageBreak(proxy,1226,2);	
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1226,1,93100);
	
	print("OnEvent_4784_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4785
--------------------------------------------------------------------------------------
--■4785■中ボス部屋　床破壊■
function OnEvent_4785(proxy, param)
	print("OnEvent_4785 begin");
	
	--▼4785_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4785, "OnEvent_4785_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4785 end");
end

--▲4785_1▲１秒後▲
function OnEvent_4785_1(proxy, param)
	print("OnEvent_4785_1 begin");
	
	--▼4785_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4785, 1227, 1, 10030,EV_HIT_ALL, 2.0, 5.0, "OnEvent_4785_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット
	proxy:SetEventFlag( 4785, true );
	
	print("OnEvent_4785_1 end");
end

--▲4785_2▲ダメージ球が当たった▲
function OnEvent_4785_2(proxy, param)
	print("OnEvent_4785_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定
	SecondStageBreak(proxy,1227,2);	
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1227,1,93100);
	
	print("OnEvent_4785_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4786
--------------------------------------------------------------------------------------
--■4786■中ボス部屋　床破壊■
function OnEvent_4786(proxy, param)
	print("OnEvent_4786 begin");
	
	--▼4786_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4786, "OnEvent_4786_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4786 end");
end

--▲4786_1▲１秒後▲
function OnEvent_4786_1(proxy, param)
	print("OnEvent_4786_1 begin");
	
	--▼4786_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4786, 1228, 1, 10030,EV_HIT_ALL, 2.0, 5.0, "OnEvent_4786_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット
	proxy:SetEventFlag( 4786, true );
	
	print("OnEvent_4786_1 end");
end

--▲4786_2▲ダメージ球が当たった▲
function OnEvent_4786_2(proxy, param)
	print("OnEvent_4786_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定
	SecondStageBreak(proxy,1228,2);	
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1228,1,93100);
	
	print("OnEvent_4786_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4787
--------------------------------------------------------------------------------------
--■4787■中ボス部屋　床破壊■
function OnEvent_4787(proxy, param)
	print("OnEvent_4787 begin");
	
	--▼4787_1▼***条件追加***--１秒後▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4787, "OnEvent_4787_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4787 end");
end

--▲4787_1▲１秒後▲
function OnEvent_4787_1(proxy, param)
	print("OnEvent_4787_1 begin");
	
	--▼4786_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4787, 1229, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4787_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット
	proxy:SetEventFlag( 4787, true );
	
	print("OnEvent_4787_1 end");
end

--▲4787_2▲ダメージ球が当たった▲
function OnEvent_4787_2(proxy, param)
	print("OnEvent_4787_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定
	SecondStageBreak(proxy,1229,2);	
	--破壊のSFX発生
	proxy:CreateSfx_DummyPoly(1229,1,93100);
	
	print("OnEvent_4787_2 end");
end


--[[
--------------------------------------------------------------------------------------
--骸骨起き上がり■651
--------------------------------------------------------------------------------------
function OnEvent_651(proxy,param)
	print("OnEvent_651 begin");
	proxy:StopLoopAnimation(328);
	proxy:PlayAnimation(328,7001);
	proxy:SetColiEnable(328,true);
	proxy:SetEventFlag(651,true);
	print("OnEvent_651 end");
end


--------------------------------------------------------------------------------------
--骸骨起き上がり■652
--------------------------------------------------------------------------------------
function OnEvent_652(proxy,param)
	print("OnEvent_652 begin");
	for eneid = 329, 334, 1 do
		proxy:StopLoopAnimation(eneid);
		proxy:PlayAnimation(eneid,7001);
		proxy:SetColiEnable(eneid,true);
	end		
	proxy:SetEventFlag(652,true);
	print("OnEvent_652 end");
end


--------------------------------------------------------------------------------------
--骸骨起き上がり■653
--------------------------------------------------------------------------------------
function OnEvent_653(proxy,param)
	print("OnEvent_653 begin");
	for eneid = 336, 339, 1 do
		proxy:StopLoopAnimation(eneid);
		proxy:PlayAnimation(eneid,7001);
		proxy:SetColiEnable(eneid,true);
	end		
	proxy:SetEventFlag(653,true);
	print("OnEvent_653 end");
end]]


--------------------------------------------------------------------------------------
--天の声■654
--------------------------------------------------------------------------------------
function OnEvent_654(proxy,param)
	print("OnEvent_654 begin");
	--アイテムイベント待ちじゃない時だけ
	if proxy:IsCompleteEvent( 12614 ) == false then		
		if proxy:IsCompleteEvent( 12613 ) == false then
			--アイテム交換希望会話
			proxy:CloseMenu();
			proxy:TalkNextPage(654);
		end
	end
	
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			--proxy:OnPlayerActionInRegion(656,2285,"OnEvent_656",0,once);
			proxy:OnRegionJustOut(657,10000,2285,"OnEvent_657",once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	
	print("OnEvent_654 end");
end

--次ページに送ると消える？
function OnEvent_656(proxy,param)
	print("OnEvent_656 begin");	
	--proxy:CloseMenu();
	--proxy:TalkNextPage(654);	
	print("OnEvent_656 end");
end

--エリアから出ると消える?
function OnEvent_657(proxy,param)
	print("OnEvent_657 begin");
	--アイテム交換希望用の会話
	proxy:CloseTalk(654);
	proxy:SetValidTalk(654,true);
	--アイテム更に希望の会話
	proxy:CloseTalk(655);
	proxy:SetValidTalk(655,true);
	--希望アイテムと違う会話
	proxy:CloseTalk(662);
	proxy:SetValidTalk(662,true);
	
	proxy:DeleteEvent(656);	
	
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnRegionIn(654,10000,2284,"OnEvent_654",once);				
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	print("OnEvent_657 end");
end




--------------------------------------------------------------------------------------
--アイテムドロップの監視■12613
--------------------------------------------------------------------------------------
--アイテムを捨てた
function OnEvent_12613(proxy,param)
	--print("OnEvent_12613 begin");
	
	if proxy:IsCompleteEvent(12614) == false and proxy:IsCompleteEvent(12613) == false then				
		local num = table.getn(itemevent_typelist);
		local idx = 0;
		local isDrop = false;
		
		--何か捨てたか詳細関係無く判定
		if proxy:IsDropCheck_Only( 10000 , -1 , -1 , 2284 ) == true then
			for idx=1 ,num , 1 do
				if CheckItemDrop(proxy,param,idx) == true then
				--if proxy:IsRegionDrop(12613,10000, itemevent_typelist[idx], itemevent_idlist[idx] ,2284) == true then
					print("Drop!!");
					--proxy:SetEventFlag(12613,true);					
					--該当アイテムが落ちたのでとりあえずここで終了
					return;
				end
			end
			
			--何か捨てたけど上の候補に無い・・・該当アイテム以外を捨てた！
			--不必要なものを捨てた会話
			proxy:CloseMenu();--メニュー閉じます。
			proxy:SetValidTalk(662,true);
			proxy:TalkNextPage(662)
		end
		
	--[[else
		print("Event Complete!");
		proxy:SetEventFlag(12000,false);
		proxy:DeleteEvent(57);
		]]
	end	
	--print("OnEvent_12613 end");
end

--[[
function OnEvent_12613_1(proxy,param)
	print("OnEvent_12613_1 begin");
	print("PickUpItem");
	proxy:SetEventFlag(12613,false);
	print("OnEvent_12613_1 end");
end]]


function OnEvent_12621_1(proxy,param) PickUpItem(proxy,param,12621) end
function OnEvent_12622_1(proxy,param) PickUpItem(proxy,param,12622) end
function OnEvent_12623_1(proxy,param) PickUpItem(proxy,param,12623) end
function OnEvent_12624_1(proxy,param) PickUpItem(proxy,param,12624) end
function OnEvent_12625_1(proxy,param) PickUpItem(proxy,param,12625) end
function OnEvent_12626_1(proxy,param) PickUpItem(proxy,param,12626) end
function OnEvent_12627_1(proxy,param) PickUpItem(proxy,param,12627) end
function OnEvent_12628_1(proxy,param) PickUpItem(proxy,param,12628) end
function OnEvent_12629_1(proxy,param) PickUpItem(proxy,param,12629) end
function OnEvent_12630_1(proxy,param) PickUpItem(proxy,param,12630) end
function OnEvent_12631_1(proxy,param) PickUpItem(proxy,param,12631) end
function OnEvent_12632_1(proxy,param) PickUpItem(proxy,param,12632) end
function OnEvent_12633_1(proxy,param) PickUpItem(proxy,param,12633) end
function OnEvent_12634_1(proxy,param) PickUpItem(proxy,param,12634) end
function OnEvent_12635_1(proxy,param) PickUpItem(proxy,param,12635) end
function OnEvent_12636_1(proxy,param) PickUpItem(proxy,param,12636) end
function OnEvent_12637_1(proxy,param) PickUpItem(proxy,param,12637) end
function OnEvent_12638_1(proxy,param) PickUpItem(proxy,param,12638) end
function OnEvent_12639_1(proxy,param) PickUpItem(proxy,param,12639) end


--該当アイテムを拾った
function PickUpItem(proxy,param,id)
	print("OnEvent_",id,"_1 begin");
	print("PickUpItem");
	proxy:SetEventFlag(12613,false);
	proxy:SetEventFlag(id,false);
	print("OnEvent_",id,"_1 end");
end

--------------------------------------------------------------------------------------
--アイテム取得の監視■658
--------------------------------------------------------------------------------------
function OnEvent_658(proxy,param)
	print("OnEvent_658 begin");
	
	local idx = 0;
	local num = table.getn( itemevent_endidlist );
	local count = 0;
	for idx = 1, num, 1 do
		ItemChangeCheck(proxy,param,idx);
		if proxy:IsCompleteEvent( itemevent_endidlist[idx] ) == true then
			count = count+1;
		end
	end
	
	print("count = ",count," num = ",num);
	if count == num then
		--すべて取った！
		proxy:SetEventFlag( 659,true );
	end		
		
	proxy:TreasureDispModeChange2(1335,false,ITEM_SFX);
	proxy:SetDrawEnable( 1335,false);
	
	proxy:LuaCallStart(4010,1);--アイテム取得同期
	
	--アイテムイベントフラグOFF
	proxy:SetEventFlag(12613,false);
	proxy:SetEventFlag(12614,false);
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc( 655 ,"Check_655","OnEvent_655",1,once);
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_658 end");
end

--メニュー表示の判定
function Check_655(proxy,param)

	ITEM_SHOWMENU = proxy:IsShowMenu();
	
	if ITEM_SHOWMENU == false and PREV_ITEM_SHOWMENU == true then
		return true;
	end
	PREV_ITEM_SHOWMENU = ITEM_SHOWMENU;
	return false;
end

--交換会話
function OnEvent_655(proxy,param)
	print("OnEvent_655 begin");
	if proxy:IsCompleteEvent( 659 ) == false then
		proxy:CloseMenu();
		proxy:SetValidTalk(655,true);
		proxy:TalkNextPage(655);
	else
		proxy:CloseMenu();
		proxy:SetValidTalk(659,true);
		proxy:TalkNextPage(659);
		--[[
		関連イベントデリート
		654
658
12613
		]]
		proxy:DeleteEvent( 654 );
		proxy:DeleteEvent( 657 );
		proxy:DeleteEvent( 658 );
		proxy:DeleteEvent( 12613 );
	end	
	print("OnEvent_655 end");
end




--[[
鷹の娘の交換イベント
アイテム捨てた？

]]

function CheckItemDrop(proxy,param,setNo)	
	--itemevent_typelist		=	{TYPE_WEAPON,TYPE_WEAPON,TYPE_WEAPON,TYPE_GOODS	,	};
	--itemevent_idlist		=	{10000		,10100		,10200		,1017		,	};	
	--itemevent_eventidlist	=	{12621		,12622		,12623		,12624		,	};
	--itemevent_endidlist		=	{12631		,12632		,12633		,12634		,	};
	if proxy:IsDropCheck_Only(10000,itemevent_typelist[setNo],itemevent_idlist[setNo],2284) == true then
		--まだ交換が終わっていない
		if proxy:IsCompleteEvent(itemevent_endidlist[setNo]) == false then
			if proxy:IsRegionDrop( itemevent_eventidlist[setNo] , 10000,itemevent_typelist[setNo],itemevent_idlist[setNo],2284) == true then			
				proxy:CloseMenu();--メニュー閉じます。
				proxy:SetValidTalk( 12613 ,true);
				proxy:TalkNextPage( 12613 );
				proxy:SetEventFlag( itemevent_eventidlist[setNo],true);
				proxy:SetEventFlag( 12613 , true);
			end
			--該当アイテムを捨てたフラグをON
			return true;
		else
			proxy:CloseMenu();--メニュー閉じます。
			--もう交換が終わっている
			proxy:SetValidTalk( 663 ,true);
			proxy:TalkNextPage( 663 );		
			return true;
		end
	end
	--そもそも捨てて無い
	return false;
end

--アイテム交換チェック
function ItemChangeCheck(proxy,param,setNo)
	--元アイテムを捨てていて,先アイテムをまだ取ってない
	if proxy:IsCompleteEvent( itemevent_eventidlist[setNo] ) == true and proxy:IsCompleteEvent( itemevent_endidlist[setNo] ) == false then
		proxy:GetRateItem( itemevent_paramlist[setNo] );
		proxy:SetEventFlag( itemevent_eventidlist[setNo] ,false);
		proxy:SetEventFlag( itemevent_endidlist[setNo] ,true);
	end
end

--------------------------------------------------------------------------------------
--整理済み↑　未整理↓■function
--------------------------------------------------------------------------------------

















--------------------------------------------------------------------------------------
--徘徊デーモンの登場■??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ)
function PlayerDeath_m03_01_00_00(proxy, param)
	print("PlayerDeath_m03_01_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m03_01_00_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。
	
	print("PlayerDeath_m03_01_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ)
function PlayerRevive_m03_01_00_00(proxy,param)
	print("PlayerRevive_m03_01_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m03_01_00_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。
	
	print("PlayerRevive_m03_01_00_00");
end



--------------------------------------------------------------------------------------
--【水牢NPC】NPCが感謝状態になる■627
--------------------------------------------------------------------------------------
--■627■【水牢NPC】NPCが感謝状態になる■
function Condition_627(proxy,param)
	if proxy:IsCompleteEvent(639)== true then	
		print("Condition_627 Success");
		return true;
	end
	return false;
end

function OnEvent_627(proxy,param)
	print("OnEvent_627 begin");
	--proxy:SetEventCommand(633,31);	
	--囚人の状態を解放してくれて感謝に設定
	SetNpcStateFlag( proxy, param, syuujin_flag_list, SYUUJIN_STATE_THANKS );	
	--フラグを立てる
	proxy:SetEventFlag( 627, true );
	
	print("OnEvent_627 end");
end

--------------------------------------------------------------------------------------
--【水牢NPC】古砦囚人感謝＞休憩■628
--------------------------------------------------------------------------------------
--■628■古砦囚人感謝＞休憩■
function OnEvent_628(proxy,param)
	print("OnEvent_628 begin");
	
	--会話から呼ばれているので同期させるためにLuaCallStartで発動
	proxy:LuaCallStart(628, 1);
	
	print("OnEvent_628 end");
end

--古砦囚人感謝＞休憩
function OnEvent_628_1(proxy,param)
	print("OnEvent_628_1 begin");	
	--囚人の状態を水牢で休憩に設定
	SetNpcStateFlag( proxy, param, syuujin_flag_list, SYUUJIN_STATE_INTERVAL );		
	--フラグを立てる
	proxy:SetEventFlag( 628, true );
	
	print("OnEvent_628_1 end");
end

--------------------------------------------------------------------------------------
--【水牢NPC】NPCが敵になる■629
--------------------------------------------------------------------------------------
--■629■【水牢NPC】NPCが敵になる■
function OnEvent_629(proxy,param)
	print("OnEvent_629 begin");
	
	--ロジックOn
	proxy:EnableLogic( 633, true );

	--囚人の状態を敵対に設定
	SetNpcStateFlag( proxy, param, syuujin_flag_list, SYUUJIN_STATE_ANGRY_01 );
	proxy:SetTeamType( 633, TEAM_TYPE_AngryFriend );

	--敵対したら感謝、休憩にはならないので削除
	proxy:DeleteEvent( 627 );
	proxy:DeleteEvent( 628 );	
	
	--フラグを立てる
	proxy:SetEventFlag( 629, true );
	
	print("OnEvent_629 end");
end

--------------------------------------------------------------------------------------
--【【水牢NPC】NPCが死んだ■630
--------------------------------------------------------------------------------------
--■630■【水牢NPC】NPCが死んだ■
function OnEvent_630(proxy,param)
	print("OnEvent_630 begin");
	
	--囚人の状態を敵対に設定
	SetNpcStateFlag( proxy, param, syuujin_flag_list, SYUUJIN_STATE_DEAD );
	
	--フラグを立てる
	proxy:SetEventFlag( 630, true );
	
	--敵に削られて敵対を通り越して死亡もありえるので、ここでも削除
	--死んだら感謝、休憩、敵対にはならないので削除
	proxy:DeleteEvent( 627 );
	proxy:DeleteEvent( 628 );
	proxy:DeleteEvent( 629 );
	
	print("OnEvent_630 end");
end




--------------------------------------------------------------------------------------
--■660■最初の要石の光が消える■
--------------------------------------------------------------------------------------

function OnEvent_660(proxy, param)
	print("OnEvent_660 begin");
	
	proxy:TreasureDispModeChange2( 1983 , false ,KANAME_SFX);
	
	print("OnEvent_660 end");
end


--------------------------------------------------------------------------------------
--■661■最初の要石の光が復活する■
--------------------------------------------------------------------------------------

function OnEvent_661(proxy, param)
	print("OnEvent_661 begin");
	
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	
	print("OnEvent_661 end");
end


--------------------------------------------------------------------------------------
--■682■ボスカメラ設定■
--------------------------------------------------------------------------------------
function OnEvent_682(proxy,param)
	--print("OnEvent_682 begin");
	--ボスが死んでいない　かつ　ボスとの戦闘を開始している
	if proxy:IsCompleteEvent( 4756 ) == false and proxy:IsCompleteEvent( 641 ) == true then
		--ボス戦　非ロックカメラ
		proxy:SetCamModeParamTargetId(3011);
		--ボス戦　ロックカメラ
		proxy:SetCamModeParamTargetIdForBossLock(3010);
	end
	--print("OnEvent_682 end");
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
function OnEvent_730(proxy, param)	Move_Skeleton(proxy, param, 730, 360);end
function OnEvent_731(proxy, param)	Move_Skeleton(proxy, param, 731, 361);end
function OnEvent_732(proxy, param)	Move_Skeleton(proxy, param, 732, 362);end
function OnEvent_733(proxy, param)	Move_Skeleton(proxy, param, 733, 363);end
function OnEvent_734(proxy, param)	Move_Skeleton(proxy, param, 734, 364);end
function OnEvent_735(proxy, param)	Move_Skeleton(proxy, param, 735, 365);end
function OnEvent_736(proxy, param)	Move_Skeleton(proxy, param, 736, 366);end
function OnEvent_737(proxy, param)	Move_Skeleton(proxy, param, 737, 367);end
function OnEvent_738(proxy, param)	Move_Skeleton(proxy, param, 738, 368);end
function OnEvent_739(proxy, param)	Move_Skeleton(proxy, param, 739, 369);end
function OnEvent_740(proxy, param) 	Move_Skeleton(proxy, param, 740, 370);end
function OnEvent_741(proxy, param) 	Move_Skeleton(proxy, param, 741, 371);end
function OnEvent_742(proxy, param) 	Move_Skeleton(proxy, param, 742, 372);end
function OnEvent_743(proxy, param)	Move_Skeleton(proxy, param, 743, 373);end
function OnEvent_744(proxy, param) 	Move_Skeleton(proxy, param, 744, 374);end
function OnEvent_745(proxy, param)	Move_Skeleton(proxy, param, 745, 375);end
function OnEvent_746(proxy, param) 	Move_Skeleton(proxy, param, 746, 376);end
function OnEvent_747(proxy, param)	Move_Skeleton(proxy, param, 747, 377);end
function OnEvent_748(proxy, param)	Move_Skeleton(proxy, param, 748, 378);end
function OnEvent_749(proxy, param) 	Move_Skeleton(proxy, param, 749, 379);end
function OnEvent_750(proxy, param)	Move_Skeleton(proxy, param, 750, 380);end
function OnEvent_751(proxy, param)	Move_Skeleton(proxy, param, 751, 381);end
function OnEvent_752(proxy, param)	Move_Skeleton(proxy, param, 752, 382);end
function OnEvent_753(proxy, param)	Move_Skeleton(proxy, param, 753, 383);end
function OnEvent_754(proxy, param)	Move_Skeleton(proxy, param, 754, 384);end
function OnEvent_755(proxy, param)	Move_Skeleton(proxy, param, 755, 428);end
function OnEvent_756(proxy, param)	Move_Skeleton(proxy, param, 756, 429);end
function OnEvent_757(proxy, param)	Move_Skeleton(proxy, param, 757, 430);end
function OnEvent_758(proxy, param)	Move_Skeleton(proxy, param, 758, 431);end
function OnEvent_759(proxy, param)	Move_Skeleton(proxy, param, 759, 432);end

--[[マスターサツキ関連]]-----------------------------------------------------------------------------------------------------
----------------------------------------------------------------
--■700■サツキが去る■
----------------------------------------------------------------
function OnEvent_700(proxy, param)
	proxy:DisableInterupt(638,true);--割り込み禁止
	MoveRegion(proxy,638, 2240, -1, 0.0, true);--ポイント移動
	proxy:SetEventFlag(700, true);
end
----------------------------------------------------------------
--■701■サツキが消える■
----------------------------------------------------------------
function OnEvent_701(proxy, param)
	print("OnEvent_701 begin");
	InvalidBackRead(proxy, 638);--無効化させる	
	proxy:SetEventFlag(701, true);
	print("OnEvent_701 end");
end
--------------------------------------------------------------------------------------
--■704■サツキ敵対化■
--------------------------------------------------------------------------------------
function OnEvent_704(proxy, param)
	if proxy:IsCompleteEvent( 704 ) == false then
		print("OnEvent_704 begin");
		proxy:EnableLogic(637, true);--ロジックON
		if proxy:IsCompleteEvent( MasterSATSUKI_HOSTILE_Makoto ) == false then
			SetNpcStateFlag(proxy, param, MasterParamFlag_list, MasterSATSUKI_HOSTILE);--状態変化
		end
		proxy:SetTeamType(637, TEAM_TYPE_AngryFriend);--チームタイプ変更
		
		proxy:SetEventFlag( 704, true );
		print("OnEvent_704 end");
	end
end

function MakotoAngry(proxy,param,eventid,wepoid)
	print("OnEvent_",eventid," begin");
	--誠をPCのアイテム欄から削除
	if	proxy:RemoveInventoryEquip( TYPE_WEAPON, wepoid ) == true then--誠を削除できた　ならば
		print("OnEvent_",eventid," アイテム(誠)削除成功");
	end
	
	proxy:EnableLogic(637, true);--ロジックON
	SetNpcStateFlag(proxy, param, MasterParamFlag_list, MasterSATSUKI_HOSTILE_Makoto);--状態変化
	proxy:SetTeamType(637, TEAM_TYPE_AngryFriend);--チームタイプ変更		
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 705,"OnEvent_705_1",0.0,0,0,once);
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( eventid, true );
	print("OnEvent_",eventid," end");
end

--------------------------------------------------------------------------------------
--■705■サツキ敵対化(誠入手)■
--------------------------------------------------------------------------------------
function OnEvent_705(proxy, param) MakotoAngry(proxy,param,705,40700); end
function OnEvent_713(proxy, param) MakotoAngry(proxy,param,713,40701); end
function OnEvent_714(proxy, param) MakotoAngry(proxy,param,714,40702); end
function OnEvent_715(proxy, param) MakotoAngry(proxy,param,715,40703); end
function OnEvent_716(proxy, param) MakotoAngry(proxy,param,716,40704); end
function OnEvent_717(proxy, param) MakotoAngry(proxy,param,717,40705); end

function OnEvent_705_1(proxy,param)
	print("OnEvent_705_1 begin");
	--proxy:ResetThink( 637 );
	proxy:SendEventRequest( 637 , 0 , 10 );	
	--if TargetChangeWepR2(proxy, 637) == false then
		--print("★★★★★武器切り替え失敗！！★★★★★");
	--end--サブ武器（誠）に切り替えさせる
	print("OnEvent_705_1 end");
end

--------------------------------------------------------------------------------------
--■706■サツキ敵対化(誠未入手)■
--------------------------------------------------------------------------------------
function OnEvent_706(proxy, param)
	print("OnEvent_706 begin");
	proxy:EnableLogic(637, true);--ロジックON
	SetNpcStateFlag(proxy, param, MasterParamFlag_list, MasterSATSUKI_HOSTILE);--状態変化
	proxy:SetTeamType(637, TEAM_TYPE_AngryFriend);--チームタイプ変更

	proxy:SetEventFlag( 706, true );
	print("OnEvent_706 end");
end
--------------------------------------------------------------------------------------
--■707■サツキ死亡■
--------------------------------------------------------------------------------------
function OnEvent_707(proxy, param)
	print("OnEvent_707 begin");
	SetNpcStateFlag( proxy, param, MasterParamFlag_list, MasterSATSUKI_DEAD );
	
	proxy:SetEventFlag( 707, true );
	print("OnEvent_707 end");
end
------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--■711■サツキブラック死亡■
--------------------------------------------------------------------------------------
function OnEvent_711(proxy, param)
	print("OnEvent_711 begin");
	proxy:SetEventFlag( 711, true );
	print("OnEvent_711 end");
end

--サツキ・ブラックの死体を調べてない
function OnEvent_15634(proxy,param)
	print("OnEvent_15634 begin");
	proxy:SetEventFlag( 15634 , true );
	print("OnEvent_15634 end");
end


------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
--古砦囚人管理ポイント■631～633
--------------------------------------------------------------------------------------
function OnEvent_631(proxy,param) proxy:LuaCallStart(634,1); end
function OnEvent_632(proxy,param) proxy:LuaCallStart(634,1); end
function OnEvent_633(proxy,param) proxy:LuaCallStart(634,1); end


--------------------------------------------------------------------------------------
--古砦囚人状態変化■634
--------------------------------------------------------------------------------------
function OnEvent_634(proxy,param)
	print("OnEvent_634 begin");
	print("JustInCheckPoint");
	
	local SyuujinId_1 = 633;--古砦１のイベントID
	local SyuujinId_2 = 678;--古砦２のイベントID
	
	local SyuujinBlock1_acid_list = {627,628,629,630};
	local SyuujinBlock2_acid_list = {1185,1186};
	
	--一旦2体とも消える
	InvalidCharactor(proxy,SyuujinId_1);
	InvalidCharactor(proxy,SyuujinId_2);
	
	if proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork( SyuujinId_1);
		proxy:RequestForceUpdateNetwork( SyuujinId_2);		
	end
	
	--ブロックの監視を削除
	DeleteConditionList(proxy,SyuujinBlock1_acid_list);	
	DeleteConditionList(proxy,SyuujinBlock2_acid_list);
	
	--取りあえず初期状態を設定
	SetFirstNpcStateFlag( proxy, param, syuujin_flag_list, SYUUJIN_STATE_ESCAPE );
	
	--囚人牢から出たい
	if proxy:IsCompleteEvent( SYUUJIN_STATE_ESCAPE ) == true then
		print("Syuujin NowState SYUUJIN_STATE_ESCAPE");
		SetSyuujinState1(proxy,param);
		RegistConditionBlock1(proxy,param);
	
	--囚人牢から出してくれて感謝
	elseif proxy:IsCompleteEvent( SYUUJIN_STATE_THANKS ) == true then
		print("Syuujin NowState SYUUJIN_STATE_THANKS");
		SetSyuujinState2(proxy,param);
		RegistConditionBlock1(proxy,param);
	
	--囚人牢屋で休憩
	elseif proxy:IsCompleteEvent( SYUUJIN_STATE_INTERVAL ) == true then
		print("Syuujin NowState SYUUJIN_STATE_INTERVAL");
		SetSyuujinState3(proxy,param);
		RegistConditionBlock2(proxy,param);
	
	--囚人古砦１で敵対	
	elseif proxy:IsCompleteEvent( SYUUJIN_STATE_ANGRY_01 ) == true then
		print("Syuujin NowState SYUUJIN_STATE_ANGRY_01");
		SetSyuujinState4(proxy,param);
		RegistConditionBlock1(proxy,param);
	
	--囚人死亡
	elseif proxy:IsCompleteEvent( SYUUJIN_STATE_DEAD ) == true then
		print("Syuujin NowState SYUUJIN_STATE_DEAD");
		SetSyuujinState5(proxy,param);
	
	--囚人古砦２にいる
	elseif proxy:IsCompleteEvent( SYUUJIN_STATE_STAY ) == true then
		print("Syuujin NowState SYUUJIN_STATE_STAY");
		SetSyuujinState6(proxy,param);
		RegistConditionBlock2(proxy,param);
	
	--囚人古砦２で敵対
	elseif proxy:IsCompleteEvent( SYUUJIN_STATE_ANGRY_02 ) == true then
		print("Syuujin NowState SYUUJIN_STATE_ANGRY_02");
		SetSyuujinState7(proxy,param);
		RegistConditionBlock2(proxy,param);
	
	--状態遷移なくねー？
	else
		print("Syuujin NowState UnKnown");	
	end
	print("OnEvent_634 end");
end

--------------------------------------------------------------------------------------
--囚人牢から出たい■16050
--------------------------------------------------------------------------------------
function SetSyuujinState1(proxy,param)	
	ValidCharactor(proxy,633);--古砦１にいる囚人を有効化
	--proxy:SetEventCommand(633,30);
	--■627■【水牢NPC】NPCが感謝状態じゃない■
	if proxy:IsCompleteEvent( 627 ) == false then
		proxy:OnRegistFunc( 627, "Condition_627", "OnEvent_627", 1, once );				
	end	
	
	--■628■【水牢NPC】NPCからアイテムをもらってない■
	if proxy:IsCompleteEvent( 628 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 628, 0, "OnEvent_628", once );
		proxy:NotNetMessage_end();
		--同期用のハンドラ
		proxy:LuaCall(628, 1, "OnEvent_628_1", once);
	end
end

--------------------------------------------------------------------------------------
--囚人牢から出してくれて感謝■16051
--------------------------------------------------------------------------------------
function SetSyuujinState2(proxy,param)	
	ValidCharactor(proxy,633);--古砦１にいる囚人を有効化
	--■628■【水牢NPC】NPCからアイテムをもらってない■
	if proxy:IsCompleteEvent( 628 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 628, 0, "OnEvent_628", once );
		proxy:NotNetMessage_end();
		--同期用のハンドラ
		proxy:LuaCall(628, 1, "OnEvent_628_1", once);
		
	end
end

--------------------------------------------------------------------------------------
--囚人牢屋で休憩■16052
--------------------------------------------------------------------------------------
function SetSyuujinState3(proxy,param)
	--審判者が死んでいない
	if proxy:IsCompleteEvent( 4756 ) == false then
		ValidCharactor(proxy,633);--古砦１にいる囚人を有効化		
		
	--審判者が死んでいる
	else
		print("Syuujin NowState SYUUJIN_STATE_INTERVAL > Chenge to SYUUJIN_STATE_STAY");
		InvalidBackRead(proxy,633);--古砦１にいる囚人を無効化
		ValidCharactor(proxy,678);--古砦２にいる囚人を有効化
		--状態を古砦２にいるに変更
		SetNpcStateFlag( proxy, param, syuujin_flag_list, SYUUJIN_STATE_STAY );	
	end
end

--------------------------------------------------------------------------------------
--囚人古砦１で敵対■16053
--------------------------------------------------------------------------------------
function SetSyuujinState4(proxy,param)
	ValidCharactor(proxy,633);--古砦１にいる囚人を有効化
	proxy:SetTeamType( 633, TEAM_TYPE_AngryFriend );
end

--------------------------------------------------------------------------------------
--囚人死亡■16054
--------------------------------------------------------------------------------------
function SetSyuujinState5(proxy,param)
	InvalidBackRead(proxy,633);--古砦１にいる囚人を無効化
	InvalidBackRead(proxy,678);--古砦２にいる囚人を無効化
end

--------------------------------------------------------------------------------------
--囚人古砦２にいる■16055
--------------------------------------------------------------------------------------
function SetSyuujinState6(proxy,param)
	InvalidBackRead(proxy,633);--古砦１にいる囚人を無効化
	ValidCharactor(proxy,678);--古砦２にいる囚人を有効化
end

--------------------------------------------------------------------------------------
--囚人古砦２で敵対■16056
--------------------------------------------------------------------------------------
function SetSyuujinState7(proxy,param)
	InvalidBackRead(proxy,633);--古砦１にいる囚人を無効化
	ValidCharactor(proxy,678);--古砦２にいる囚人を有効化
	proxy:SetTeamType( 678, TEAM_TYPE_AngryFriend );
end


--------------------------------------------------------------------------------------
--囚人古砦1監視■
--------------------------------------------------------------------------------------
function RegistConditionBlock1(proxy,param)	
	--囚人が死んでいない
	if proxy:IsCompleteEvent( SYUUJIN_STATE_DEAD ) == false then
		--古砦１、２で敵対になっていない
		if proxy:IsCompleteEvent( SYUUJIN_STATE_ANGRY_01 ) == false 
		and proxy:IsCompleteEvent( SYUUJIN_STATE_ANGRY_02 ) == false then			
			--ホストからのダメージ監視
			--m03_01
			--proxy:OnCharacterTotalDamage( 629, 633, 10000, SYUUJIN_TOTAL_DAMAGE, "OnEvent_629", once );	
			proxy:OnCharacterTotalRateDamage( 629, 633, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_629", once );
			--m03_02
			--proxy:OnCharacterTotalDamage( 1185, 678, 10000, SYUUJIN_TOTAL_DAMAGE, "OnEvent_1185_1", once );				
			proxy:OnCharacterTotalRateDamage( 1185, 678, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1185_1", once );
		end
		--囚人の死亡監視
		proxy:OnCharacterDead( 630, 633, "OnEvent_630", once );				
	end
end

--------------------------------------------------------------------------------------
--囚人古砦2監視■
--------------------------------------------------------------------------------------
function RegistConditionBlock2(proxy,param)
	--囚人が死んでいない
	if proxy:IsCompleteEvent( SYUUJIN_STATE_DEAD ) == false then
		--古砦１、２で敵対になっていない
		if proxy:IsCompleteEvent( SYUUJIN_STATE_ANGRY_01 ) == false
		and proxy:IsCompleteEvent( SYUUJIN_STATE_ANGRY_02 ) == false then
			--ホストからのダメージ監視
			--m03_01
			--proxy:OnCharacterTotalDamage( 629, 633, 10000, SYUUJIN_TOTAL_DAMAGE, "OnEvent_629", once );			
			proxy:OnCharacterTotalRateDamage( 629, 633, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_629", once );
			--m03_02
			--proxy:OnCharacterTotalDamage( 1185, 678, 10000, SYUUJIN_TOTAL_DAMAGE, "OnEvent_1185_1", once );
			proxy:OnCharacterTotalRateDamage( 1185, 678, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1185_1", once );
		end
			--囚人の死亡監視
			proxy:OnCharacterDead( 1186 , 678 , "OnEvent_1186" , once );
		
	end
end


-----------------------------------------------------------------------------
--■780～784■槍射出トラップ
-----------------------------------------------------------------------------
--■780～784■トラップ発動！槍射出
function SpearTrapMove_780(proxy, param)
	proxy:ForcePlayAnimation(1250, 1);--強制的にアニメを再生（再生されていた場合、強制終了）
end
function SpearTrapMove_782(proxy, param)
	proxy:ForcePlayAnimation(1252, 1);--強制的にアニメを再生（再生されていた場合、強制終了）
end
function SpearTrapMove_783(proxy, param)
	proxy:ForcePlayAnimation(1253, 1);--強制的にアニメを再生（再生されていた場合、強制終了）
end
function SpearTrapMove_784(proxy, param)
	proxy:ForcePlayAnimation(1254, 1);--強制的にアニメを再生（再生されていた場合、強制終了）
end

--■780■槍射出トラップ（連射）■----------------------------------------------------
function OnEvent_780(proxy,param)
	print("OnEvent_780 begin");
	proxy:PlayAnimation( 1240, 1 );
	
	proxy:DeleteObjSfxDmyPlyID(1240, 1);--SFX無効化
	proxy:CreateSfx_DummyPoly(1240, 1, 93006 );--新たなSFXを設定
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd( 780, 1240, 1, "SpearTrapCount_780", once );
	proxy:NotNetMessage_end();
	print("OnEvent_780 end");
end
function SpearTrapCount_780(proxy,param)--準備
	--ネット配信されていたら
	if param:IsNetMessage() == true then
		return;--抜ける
	end
	
	print("Count_780 begin");
		--発動者のみ秒数カウント
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 780, "OnEvent_780_1", 1.0, 0, 0, once );--１発目(1.0秒後)
			proxy:OnKeyTime2( 780, "OnEvent_780_2", 1.5, 0, 1, once );--２発目(1.5秒後)↑の0.5秒後
			proxy:OnKeyTime2( 780, "OnEvent_780_3", 2.0, 0, 2, once );--３発目(2.0秒後)↑の0.5秒後
		proxy:NotNetMessage_end();
	print("Count_780 end");
end
function OnEvent_780_1(proxy,param)--1発目
	print("OnEvent_780_1 begin");
	proxy:LuaCallStart(780, 0);
	print("OnEvent_780_1 end");
end
function OnEvent_780_2(proxy,param)--2発目
	print("OnEvent_780_2 begin");
	proxy:LuaCallStart(780, 0);
	print("OnEvent_780_2 end");
end
function OnEvent_780_3(proxy,param)--3発目
	print("OnEvent_780_3 begin");
	proxy:LuaCallStart(780, 0);
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd(780, 1250, 1, "OnEvent_780_End", once);--アニメが終了したらフラグを立てる
	proxy:NotNetMessage_end();
	print("OnEvent_780_3 end");
end
function OnEvent_780_End(proxy, param)
	proxy:SetEventFlag( 780, true );
end

--■781■槍射出トラップ（散弾）■----------------------------------------------------
function OnEvent_781(proxy,param)
	print("OnEvent_781 begin");
	proxy:PlayAnimation( 1241, 1 );
	
	proxy:DeleteObjSfxDmyPlyID(1241, 1);--SFX無効化
	proxy:CreateSfx_DummyPoly(1241, 1, 93006 );--新たなSFXを設定
	
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd( 781, 1241, 1, "OnEvent_781_1", once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 781, true );
	print("OnEvent_781 end");
end
function OnEvent_781_1(proxy,param)
	print("OnEvent_781_1 begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 781, "OnEvent_781_2", 1.0, 0, 0, once );
	proxy:NotNetMessage_end();
	print("OnEvent_781_1 end");
end
function OnEvent_781_2(proxy,param)--一斉発射
	print("OnEvent_781_2 begin");
	proxy:PlayAnimation(1251, 1);
	proxy:PlayAnimation(1260, 1);
	proxy:PlayAnimation(1261, 1);
	proxy:PlayAnimation(1262, 1);
	proxy:PlayAnimation(1263, 1);
	proxy:PlayAnimation(1264, 1);
	print("OnEvent_781_2 end");
end


--■782■槍射出トラップ（連射）■----------------------------------------------------
function OnEvent_782(proxy,param)
	print("OnEvent_782 begin");
	proxy:PlayAnimation( 1242, 1 );
	
	proxy:DeleteObjSfxDmyPlyID(1242, 1);--SFX無効化
	proxy:CreateSfx_DummyPoly(1242, 1, 93006 );--新たなSFXを設定
	
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd( 782, 1242, 1, "SpearTrapCount_782", once );
	proxy:NotNetMessage_end();
	print("OnEvent_782 end");
end
function SpearTrapCount_782(proxy,param)
	--ネット配信されていたら
	if param:IsNetMessage() == true then
		return;--抜ける
	end
	
	print("Count_782 begin");
		--発動者のみ秒数カウント
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 782, "OnEvent_782_1", 1.0, 0, 0, once );--１発目(1.0秒後)
			proxy:OnKeyTime2( 782, "OnEvent_782_2", 1.5, 0, 1, once );--２発目(1.5秒後)↑の0.5秒後
			proxy:OnKeyTime2( 782, "OnEvent_782_3", 2.0, 0, 2, once );--３発目(2.0秒後)↑の0.5秒後
		proxy:NotNetMessage_end();
	print("Count_782 end");
end
function OnEvent_782_1(proxy,param)--1発目
	print("OnEvent_782_1 begin");
	proxy:LuaCallStart(782, 0);
	print("OnEvent_782_1 end");
end
function OnEvent_782_2(proxy,param)--2発目
	print("OnEvent_782_2 begin");
	proxy:LuaCallStart(782, 0);
	print("OnEvent_782_2 end");
end
function OnEvent_782_3(proxy,param)--3発目
	print("OnEvent_782_3 begin");
	proxy:LuaCallStart(782, 0);
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd(782, 1252, 1, "OnEvent_782_End", once);--アニメが終了したらフラグを立てる
	proxy:NotNetMessage_end();
	print("OnEvent_782_3 end");
end
function OnEvent_782_End(proxy, param)
	proxy:SetEventFlag( 782, true );
end

--■783■槍射出トラップ（連射）■----------------------------------------------------
function OnEvent_783(proxy,param)
	print("OnEvent_783 begin");
	proxy:PlayAnimation( 1243, 1 );
	
	proxy:DeleteObjSfxDmyPlyID(1243, 1);--SFX無効化
	proxy:CreateSfx_DummyPoly(1243, 1, 93006 );--新たなSFXを設定
	
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd( 783, 1243, 1, "SpearTrapCount_783", once );
	proxy:NotNetMessage_end();
	print("OnEvent_783 end");
end
function SpearTrapCount_783(proxy,param)--準備
	--ネット配信されていたら
	if param:IsNetMessage() == true then
		return;--抜ける
	end
	
	print("Count_783 begin");
		--発動者のみ秒数カウント
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 783, "OnEvent_783_1", 1.0, 0, 0, once );--１発目(1.0秒後)
			proxy:OnKeyTime2( 783, "OnEvent_783_2", 1.5, 0, 1, once );--２発目(1.5秒後)↑の0.5秒後
			proxy:OnKeyTime2( 783, "OnEvent_783_3", 2.0, 0, 2, once );--３発目(2.0秒後)↑の0.5秒後
		proxy:NotNetMessage_end();
	print("Count_783 end");
end
function OnEvent_783_1(proxy,param)--1発目
	print("OnEvent_783_1 begin");
	proxy:LuaCallStart(783, 0);
	print("OnEvent_783_1 end");
end
function OnEvent_783_2(proxy,param)--2発目
	print("OnEvent_783_2 begin");
	proxy:LuaCallStart(783, 0);
	print("OnEvent_783_2 end");
end
function OnEvent_783_3(proxy,param)--3発目
	print("OnEvent_783_3 begin");
	proxy:LuaCallStart(783, 0);

	--■785■カラスの鳴き声が響く
	SingleReset(proxy, 785);--リピートなので、リセット
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 785, "OnEvent_785", 2.0, 0, 0, once );--2秒後に、ボスが生きていたらカラスの鳴き声を鳴らす
		proxy:OnObjAnimEnd(783, 1253, 1, "OnEvent_783_End", once);--アニメが終了したらフラグを立てる
	proxy:NotNetMessage_end();	
	print("OnEvent_783_3 end");
end
function OnEvent_783_End(proxy, param)
	proxy:SetEventFlag( 783, true );
end

--■784■槍射出トラップ（連射）■----------------------------------------------------
function OnEvent_784(proxy,param)
	print("OnEvent_784 begin");
	proxy:PlayAnimation( 1244, 1 );
	
	proxy:DeleteObjSfxDmyPlyID(1244, 1);--SFX無効化
	proxy:CreateSfx_DummyPoly(1244, 1, 93006 );--新たなSFXを設定
	
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd( 784, 1244, 1, "SpearTrapCount_784", once );
	proxy:NotNetMessage_end();
	print("OnEvent_784 end");
end
function SpearTrapCount_784(proxy,param)--準備
	--ネット配信されていたら
	if param:IsNetMessage() == true then
		return;--抜ける
	end
	
	print("Count_784 begin");
		--発動者のみ秒数カウント
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 784, "OnEvent_784_1", 1.0, 0, 0, once );--１発目(0.0秒後)
			proxy:OnKeyTime2( 784, "OnEvent_784_2", 1.5, 0, 1, once );--２発目(0.5秒後)
			proxy:OnKeyTime2( 784, "OnEvent_784_3", 2.0, 0, 2, once );--３発目(1.0秒後)
		proxy:NotNetMessage_end();
	print("Count_784 end");
end
function OnEvent_784_1(proxy,param)--1発目
	print("OnEvent_784_1 begin");
	proxy:LuaCallStart(784, 0);
	print("OnEvent_784_1 end");
end
function OnEvent_784_2(proxy,param)--2発目
	print("OnEvent_784_2 begin");
	proxy:LuaCallStart(784, 0);
	print("OnEvent_784_2 end");
end
function OnEvent_784_3(proxy,param)--3発目
	print("OnEvent_784_3 begin");
	proxy:LuaCallStart(784, 0);
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd(784, 1254, 1, "OnEvent_784_End", once);--アニメが終了したらフラグを立てる
	proxy:NotNetMessage_end();
	print("OnEvent_784_3 end");
end
function OnEvent_784_End(proxy, param)
	proxy:SetEventFlag( 784, true );
end

--■785■カラス鳴き声が響く■----------------------------------------------------
function OnEvent_785(proxy,param)
	print("OnEvent_785 begin");
	if proxy:IsCompleteEvent(4756) == false then--ボスが生きていたら
		proxy:PlayTypeSE(804, SOUND_TYPE_C, 504077777);
	end
	proxy:SetEventFlag( 785, true );
	print("OnEvent_785 end");
end


-----------------------------------------------------------------------------
--■4788～4792■柱破壊イベント監視
-----------------------------------------------------------------------------
function OnEvent_4788(proxy,param) 
	print("OnEvent_4788 begin");
	proxy:SetEventFlag( 4788 , true );
	print("OnEvent_4788 end");
end

function OnEvent_4789(proxy,param) 
	print("OnEvent_4789 begin");
	proxy:SetEventFlag( 4789 , true );
	print("OnEvent_4789 end");
end

function OnEvent_4790(proxy,param) 
	print("OnEvent_4790 begin");
	proxy:SetEventFlag( 4790 , true );
	print("OnEvent_4790 end");
end

function OnEvent_4791(proxy,param) 
	print("OnEvent_4791 begin");
	proxy:SetEventFlag( 4791 , true );
	print("OnEvent_4791 end");
end

function OnEvent_4792(proxy,param) 
	print("OnEvent_4792 begin");
	proxy:SetEventFlag( 4792 , true );
	print("OnEvent_4792 end");
end


-----------------------------------------------------------------------------
--■550■デブデーモン監視
-----------------------------------------------------------------------------
function OnEvent_550(proxy,param)
	print("OnEvent_550 begin");
	proxy:SetEventFlag( 550 , true );
	proxy:SetEventFlag( 551 , true );	
	proxy:DeleteEvent( 552 );
	print("OnEvent_550 end");
end

function OnEvent_552(proxy,param)
	--if proxy:GetTargetChrID( 10000 ) == 421 then
		proxy:SetCamModeParamTargetIdForBossLock(3110);
--		print("true");
--	else
--		print("false");
--	end
--やっぱりAIからのターゲットIDじゃロックは取れなかった
end

-----------------------------------------------------------------------------
--■■結晶トカゲイベント
-----------------------------------------------------------------------------
--ボス撃破時のトカゲリセット用
function ResetTokage(proxy)
	print("ResetTokage");
	--proxy:SetEventFlag(620,false);
	--proxy:SetEventFlag(622,false);
	--proxy:SetEventFlag(1040,false);
	--proxy:SetEventFlag(1580,false);
	--proxy:SetEventFlag(1582,false);	
	AddEventCounter(proxy,7);
	AddEventCounter(proxy,8);
	AddEventCounter(proxy,9);
	AddEventCounter(proxy,10);
	AddEventCounter(proxy,11);
	
end


-----------------------------------------------------------------------------
--■620■結晶トカゲイベント1
-----------------------------------------------------------------------------
function OnEvent_620(proxy,param)
	print("OnEvent_620 begin");
	proxy:SetEventFlag( 620, true);
	proxy:DeleteEvent( 620 );
	print("OnEvent_620 end");
end

-----------------------------------------------------------------------------
--■622■結晶トカゲイベント2
-----------------------------------------------------------------------------
function OnEvent_622(proxy,param)
	print("OnEvent_622 begin");
	proxy:SetEventFlag( 622 , true );
	proxy:DeleteEvent( 622 );
	print("OnEvent_622 end");
end

-----------------------------------------------------------------------------
--■790■魔法壁破壊1
-----------------------------------------------------------------------------
function OnEvent_790(proxy,param)
	print("OnEvent_790 begin");
	proxy:InvalidSfx( 2320 , true );
	proxy:SetEventFlag( 790,true );
	print("OnEvent_790 end");
end

-----------------------------------------------------------------------------
--■791■魔法壁破壊2
-----------------------------------------------------------------------------
function OnEvent_791(proxy,param)
	print("OnEvent_791 begin");
	proxy:InvalidSfx( 2321 , true );
	proxy:SetEventFlag( 791,true );
	print("OnEvent_791 end");
end
