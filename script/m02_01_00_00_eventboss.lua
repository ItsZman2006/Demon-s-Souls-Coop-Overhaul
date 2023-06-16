
LEFTBRAKE_COUNT = 0;
RIGHTBRAKE_COUNT = 0;

--非表示マスクの用意
DISPMASK_RIGHT1 = 1;
DISPMASK_RIGHT2 = 2;
DISPMASK_LEFT1 = 4;
DISPMASK_LEFT2 = 8;

--現在の表示マスクの管理用
DISP_ALL = 15;
DISPMASK_NOW = 15;

--足のダメージ倍率
FOOTDAMAGE_RATE = 0.33;
--足のHP
--FOOTHP_01 = 30;--1段階目まで>ソウル表現弱
FOOTHP_01 = 28.6;--1段階目まで>ソウル表現弱
--FOOTHP_02 = 30;--2段階目まで>ソウル表現中&1段階破壊
FOOTHP_02 = 28.6;--2段階目まで>ソウル表現中&1段階破壊
--FOOTHP_03 = 30;--3段階目まで>ソウル表現強&2段階破壊
FOOTHP_03 = 28.6;--3段階目まで>ソウル表現強&2段階破壊

--初回転倒は　FOOTHP_01+FOOTHP_02+FOOTHP_03　です
--FOOTHP_04 = 75;--初回転倒した後、足のHP回復量
FOOTHP_04 = 71.5;--初回転倒した後、足のHP回復量

STAND_UP_TIME = 12;	--ダウンしてから起き上がるまでの時間（sec)

--頭のダメージ倍率
HEADDMAGE_RATE = 2.5;--通常攻撃用の倍率です
--頭に対する弾丸ダメージ抵抗
HEADBULLETREGIST_RATE = 0.4;

--------------------------------------------------------------------------------------
--イベント初期化■ボス固有のイベントを登録する際に使用してください
--------------------------------------------------------------------------------------
function EventBoss_Initialize_m02_01_00_00(proxy)
	print("EventBoss_Initialize_m02_01_00_00 begin");
	
	--■中ボスが生きていたら
	if proxy:IsCompleteEvent( 4224 ) ==false then
		--クライアントで無いなら　シングル　or　ホスト
		if	proxy:IsClient() == false then
			proxy:RequestForceUpdateNetwork( 801 );
		end
		--王の盾の初期化
		BossInit_KingOfShield(proxy,param);
		print("※王の盾 初期化※");
	end
	
	print("EventBoss_Initialize_m02_01_00_00 end");
end

--------------------------------------------------------------------------------------
--ボス用の初期化処理が必要なときに使用：固有情報の作成等
--------------------------------------------------------------------------------------
function BossInit_KingOfShield(proxy,param)
	print("BossInit_KingOfShield begin");
	--4260～4280とりあえず王の盾用アクションID
	--王の盾、槍にダメージが行かないように部位ダメージで管理する
	--正確にはダメージが入らないのでハンドラを用意する必要は無いが、念のため用意	
	if proxy:CreateEventBody(4260,801,"OnEvent_4260_EVENTDAMAGE",1000000,0.0,once) == true then
		proxy:AddEventParts_Ignore(4260,801,"Ragdoll_L_weapon02");
		proxy:AddEventParts_Ignore(4260,801,"Ragdoll_R_weapon01");
	end
	
	--左足用イベントダメージ
	SingleReset( proxy , 4261 );
	if proxy:CreateEventBody(4261,801,"OnEvent_4261",FOOTHP_01,FOOTDAMAGE_RATE,everytime) == true then
		proxy:AddEventParts( 4261,801,"Ragdoll_L_Foot01");
		proxy:AddEventParts( 4261,801,"Ragdoll_L_Calf01");
		proxy:AddEventParts( 4261,801,"Ragdoll_L_Toe01");
		proxy:AddEventParts( 4261,801,"Ragdoll_L_Thigh01");		
	end
	
	--右足用イベントダメージ
	SingleReset( proxy , 4262 );
	if proxy:CreateEventBody(4262,801,"OnEvent_4262",FOOTHP_01,FOOTDAMAGE_RATE,everytime) == true then
		proxy:AddEventParts( 4262,801,"Ragdoll_R_Foot01");
		proxy:AddEventParts( 4262,801,"Ragdoll_R_Calf01");
		proxy:AddEventParts( 4262,801,"Ragdoll_R_Toe01");
		proxy:AddEventParts( 4262,801,"Ragdoll_R_Thigh01");		
	end
	
	--頭用イベントダメージ
	SingleReset( proxy, 4263 );
	if proxy:CreateEventBody(4263,801,"OnEvent_4263",10000000,HEADDMAGE_RATE,once) == true then
		proxy:SetEventBodyBulletCorrect( 4263 , HEADBULLETREGIST_RATE );
		proxy:AddEventParts( 4263,801,"Ragdoll_Head01");
		proxy:AddEventParts( 4263,801,"Ragdoll_Neck01");
		proxy:AddEventParts( 4263,801,"Ragdoll_R_Clavicle01");
		proxy:AddEventParts( 4263,801,"Ragdoll_L_Clavicle01");		
	end
	
	--装甲全表示
	proxy:SetDispMask( 801 , DISP_ALL );
	--proxy:SetDispMask( 801 , 12 );--左足のみ
	--proxy:SetDispMask( 801 , 3 );--右足のみ
	
	--部位破壊SFX用ハンドラ用意 左足用
	proxy:LuaCall( 4264 , 0 , "OnEvent_4264",everytime);
	--部位破壊SFX用ハンドラ用意 右足用
	proxy:LuaCall( 4265 , 0 , "OnEvent_4265",everytime);
	
	
	--SingleReset( proxy ,4741);
	SingleReset( proxy ,4266);
	--EzState命令用秒数イベント削除
	--proxy:LuaCall(4741,0,"OnEvent_4741",everytime);
	--proxy:LuaCall(4741,1,"OnEvent_4741_1",everytime);
	proxy:LuaCall(4266,0,"OnEvent_4266",everytime);
	proxy:LuaCall(4266,1,"OnEvent_4266_1",everytime);
	
	--SingleReset( proxy ,4742);
	SingleReset( proxy ,4267);
	--EzState命令配信用
	--proxy:LuaCall(4742,1,"OnEvent_4742_1",everytime);
	--proxy:LuaCall(4742,2,"OnEvent_4742_2",everytime);
	proxy:LuaCall(4267,1,"OnEvent_4267_1",everytime);
	proxy:LuaCall(4267,2,"OnEvent_4267_2",everytime);
	
	--SingleReset( proxy ,4743);
	--SingleReset( proxy ,4744);
	SingleReset( proxy ,4268);
	SingleReset( proxy ,4269);
	--EzStateの監視
	--proxy:OnCheckEzStateMessage(4743,804,"OnEvent_4743",250);
	--proxy:OnCheckEzStateMessage(4744,804,"OnEvent_4744",260);
	proxy:OnCheckEzStateMessage(4268,801,"OnEvent_4268",1101);
	proxy:OnCheckEzStateMessage(4269,801,"OnEvent_4269",1100);
	
	--[[
その他　（盾槍抜き）
Ragdoll_Pelvis01
Ragdoll_Spine01
Ragdoll_Spine02
Ragdoll_L_Clavicle01
Ragdoll_L_UpperArm01
Ragdoll_L_Forearm01
Ragdoll_L_Hand01
Ragdoll_R_Clavicle01
Ragdoll_R_UpperArm01
Ragdoll_R_Forearm01
Ragdoll_R_Hand01
	]]	
	print("BossInit_KingOfShield end");
end

--王の盾戦闘開始
function StandBy_KingOfShield(proxy,param)
	print("StandBy_KingOfShield begin");
	--とりあえずココでMax設定&回復
	proxy:SetEventBodyMaxHp(4261,FOOTHP_01);	
	--とりあえずココでMax設定&回復
	proxy:SetEventBodyMaxHp(4262,FOOTHP_01);
	print("StandBy_KingOfShield end");
end

--王の盾の無敵部位監視のハンドラ・・・呼ばれたらどっかおかしい。
function OnEvent_4260_EVENTDAMAGE(proxy,param)
	print("OnEvent_4260_EVENTDAMAGE begin");
	print("ERROR! 発動してはいけないイベントが発動しています！");
	print("OnEvent_4260_EVENTDAMAGE end");
end


--------------------------------------------------------------------------------------
--左足部位のHPが0になった時のイベント
--------------------------------------------------------------------------------------
function OnEvent_4261(proxy,param)
	if 	proxy:IsCompleteEvent( 4261 ) == true or
		proxy:IsCompleteEvent( 4262 ) == true then
		return false;
	end	
	
	if proxy:IsClient() == false then
		print("OnEvent_4261 begin");
		proxy:LuaCallStart( 4264 , 0);
		print("OnEvent_4261 end");
		--左右両方壊してる
		if 	LEFTBRAKE_COUNT == 3 and
			RIGHTBRAKE_COUNT == 3 then
			--部位破壊イベント重複禁止用
			proxy:SetEventFlag( 4261 , true );
			--ダウンできるように命令配信
			proxy:NotNetMessage_begin();				
				proxy:OnKeyTime2(4270,"OnEvent_4270_1",5,1,0,once);
			proxy:NotNetMessage_end();
		end
	end
	
	--[[
	--とりあえずココで回復
	--proxy:CheckEventBody(4261);
	]]
end

--------------------------------------------------------------------------------------
--右足部位のHPが0になった時のイベント
--------------------------------------------------------------------------------------
function OnEvent_4262(proxy,param)
	if 	proxy:IsCompleteEvent( 4261 ) == true or
		proxy:IsCompleteEvent( 4262 ) == true then
		return false;
	end	
	
	if proxy:IsClient() == false then
		print("OnEvent_4262 begin");
		proxy:LuaCallStart( 4265 , 0 );
		print("OnEvent_4262 end");
		--左右両方壊してる
		if 	LEFTBRAKE_COUNT == 3 and
			RIGHTBRAKE_COUNT == 3 then
			--部位破壊イベント重複禁止用
			proxy:SetEventFlag( 4262 , true );
			--ダウンできるように命令配信
			proxy:NotNetMessage_begin();				
				proxy:OnKeyTime2(4270,"OnEvent_4270_1",5,1,0,once);
			proxy:NotNetMessage_end();			
		end
	end	
	--とりあえずココで回復
	--proxy:CheckEventBody(4262);
end


--------------------------------------------------------------------------------------
--左足の破壊イベント配信用
--------------------------------------------------------------------------------------
function OnEvent_4264(proxy,param)
	print("OnEvent_4264 begin");
	--破壊回数の段階によってSFX表現を行う
	if LEFTBRAKE_COUNT == 0 then
		proxy:SetEventSpecialEffect_2(801,5067);
		--とりあえずココでMax設定&回復
		proxy:SetEventBodyMaxHp(4261,FOOTHP_02);
		proxy:CheckEventBody(4261);
		proxy:SetEventFlag( 4261 , false );
	elseif LEFTBRAKE_COUNT == 1 then
		proxy:EraseEventSpecialEffect_2(801,5067);
		proxy:SetEventSpecialEffect_2(801,5068);
		--proxy:CreateSfx_DummyPoly( 801 , 225 , 14990 );
		--DISPMASK_NOW = DISPMASK_NOW - DISPMASK_LEFT1
		--proxy:SetDispMask(801, DISPMASK_NOW);--防具非表示
		--print("DISPMASK_NOW ",DISPMASK_NOW);
		--とりあえずココでMax設定&回復
		proxy:SetEventBodyMaxHp(4261,FOOTHP_03);
		proxy:CheckEventBody(4261);
		proxy:SetEventFlag( 4261 , false );
	elseif LEFTBRAKE_COUNT == 2 then		
		 DISPMASK_NOW = DISPMASK_NOW - DISPMASK_LEFT1 - DISPMASK_LEFT2;
		proxy:SetDispMask(801, DISPMASK_NOW);--防具非表示
		print("DISPMASK_NOW ",DISPMASK_NOW);
		proxy:CreateSfx_DummyPoly( 801 , 225 , 14990 );
		--ロックダミポリ無効
		proxy:SetLockActPntInvalidateMask( 801 , 225 ,true );
	elseif LEFTBRAKE_COUNT == 3 then
		proxy:EraseEventSpecialEffect_2(801,5068);
		proxy:SetEventSpecialEffect_2(801,5069);
		--ロックダミポリ無効
		proxy:SetLockActPntInvalidateMask( 801 , 225 ,true );	
	end	
	if LEFTBRAKE_COUNT < 3 then 
		LEFTBRAKE_COUNT = LEFTBRAKE_COUNT + 1;
	else
		LEFTBRAKE_COUNT = 3;
	end	
	print("OnEvent_4264 end");
end

--------------------------------------------------------------------------------------
--右足の破壊イベント配信用
--------------------------------------------------------------------------------------
function OnEvent_4265(proxy,param)
	print("OnEvent_4265 begin");	
	--破壊回数によってSFX表現を変える
	if RIGHTBRAKE_COUNT == 0 then		
		proxy:SetEventSpecialEffect_2(801,5070);
		--とりあえずココでMax設定&回復
		proxy:SetEventBodyMaxHp(4262,FOOTHP_02);
		proxy:CheckEventBody(4262);
		proxy:SetEventFlag( 4262 , false );
	elseif RIGHTBRAKE_COUNT == 1 then
		proxy:EraseEventSpecialEffect_2(801,5070);
		proxy:SetEventSpecialEffect_2(801,5071);
		--DISPMASK_NOW = DISPMASK_NOW - DISPMASK_RIGHT1;
		--print("DISPMASK_NOW ",DISPMASK_NOW);
		--proxy:SetDispMask(801, DISPMASK_NOW);--防具非表示
		--proxy:CreateSfx_DummyPoly( 801 , 226 , 14990 );
		--とりあえずココでMax設定&回復
		proxy:SetEventBodyMaxHp(4262,FOOTHP_03);
		proxy:CheckEventBody(4262);
		proxy:SetEventFlag( 4262 , false );
	elseif RIGHTBRAKE_COUNT == 2 then
		proxy:EraseEventSpecialEffect_2(801,5071);
		proxy:SetEventSpecialEffect_2(801,5072);
		DISPMASK_NOW = DISPMASK_NOW - DISPMASK_RIGHT1 - DISPMASK_RIGHT2;
		print("DISPMASK_NOW ",DISPMASK_NOW);
		proxy:SetDispMask(801, DISPMASK_NOW);--防具非表示		
		proxy:CreateSfx_DummyPoly( 801 , 226 , 14990 );
		--ロックダミポリ無効
		proxy:SetLockActPntInvalidateMask( 801 , 226 ,true );
	elseif RIGHTBRAKE_COUNT == 3 then
		proxy:EraseEventSpecialEffect_2(801,5071);
		proxy:SetEventSpecialEffect_2(801,5072);
		--ロックダミポリ無効
		proxy:SetLockActPntInvalidateMask( 801 , 226 ,true );
	end
	if RIGHTBRAKE_COUNT < 3 then
		RIGHTBRAKE_COUNT = RIGHTBRAKE_COUNT + 1;
	else
		RIGHTBRAKE_COUNT = 3;
	end
	print("OnEvent_4265 end");
end



--------------------------------------------------------------------------------------
--4270■王の盾EzStateへの命令用
--------------------------------------------------------------------------------------
function OnEvent_4270_1(proxy,param)
	--print("OnEvent_4270_1 begin");
	--ダウン命令を送信し続ける
	proxy:LuaCallStart(4267,1);
	--print("OnEvent_4270_1 end");
end

function OnEvent_4270_2(proxy,param)
	--print("OnEvent_4270_2 begin");
	--起き上がり命令を送信し続ける
	proxy:LuaCallStart(4267,2);
	--print("OnEvent_4270_2 end");
end


--------------------------------------------------------------------------------------
--4266■王の盾EzStateへの命令削除(秒数監視
--------------------------------------------------------------------------------------
function OnEvent_4266(proxy,param)
	print("OnEvent_4266 begin");
	proxy:DeleteEvent(4270);
	print("OnEvent_4266 end");
end

--------------------------------------------------------------------------------------
--4266■王の盾EzStateへの命令削除(秒数監視
--------------------------------------------------------------------------------------
function OnEvent_4266_1(proxy,param)
	print("OnEvent_4266_1 begin");
	proxy:DeleteEvent(4270);	
	--とりあえずココでMax設定&回復
	proxy:SetEventBodyMaxHp(4261,FOOTHP_04);
	proxy:CheckEventBody(4261);
	--とりあえずココでMax設定&回復
	proxy:SetEventBodyMaxHp(4262,FOOTHP_04);
	proxy:CheckEventBody(4262);
	
	proxy:EraseEventSpecialEffect_2(801,5069);
	proxy:SetEventSpecialEffect_2(801,5068);
	proxy:EraseEventSpecialEffect_2(801,5072);
	proxy:SetEventSpecialEffect_2(801,5071);		
		
	--ロックダミポリ無効
	proxy:SetLockActPntInvalidateMask( 801 , 225 ,false );		
	proxy:SetLockActPntInvalidateMask( 801 , 226 ,false );

	--ダウンイベント可能
	proxy:SetEventFlag(4261,false);
	proxy:SetEventFlag(4262,false);
	print("OnEvent_4266_1 end");
end

--------------------------------------------------------------------------------------
--4267■王の盾EzStateへの命令配信用
--------------------------------------------------------------------------------------
function OnEvent_4267_1(proxy,param)
	--ダウン命令送信
	proxy:SetEventCommand(801, 850);	
end

function OnEvent_4267_2(proxy,param)
	--起き上がり命令送信
	proxy:SetEventCommand(801, 851);
end

--------------------------------------------------------------------------------------
--4268■EzStateから"ダウン始めた"を受け取った
--------------------------------------------------------------------------------------
function OnEvent_4268(proxy,param)
	print("OnEvent_4268 begin");
	print("王の盾ダウンし始めた");
	proxy:LuaCallStart(4266,0);
	
	proxy:NotNetMessage_begin();
		--n秒後に起き上がるイベント
		proxy:OnKeyTime2(4268,"OnEvent_4268_1",STAND_UP_TIME,0,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_4743 end");
end

function OnEvent_4268_1(proxy,param)
	print("OnEvent_4268_1 begin");
	--起き始めるまで命令を送る
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(4270,"OnEvent_4270_2",5,1,20,once);
	proxy:NotNetMessage_end();
	print("OnEvent_4268_1 end");
end

--------------------------------------------------------------------------------------
--4269■EzStateから"起き上がり始めた"を受け取った
--------------------------------------------------------------------------------------
function OnEvent_4269(proxy,param)
	print("OnEvent_4269 begin");
	print("王の盾起き上がり始めた");
	proxy:LuaCallStart(4266,1);	
	print("OnEvent_4269 end");
end
