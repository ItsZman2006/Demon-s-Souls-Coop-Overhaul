once = 1;
everytime = 0;

--Time adjustment here
Tutorial_pausewait = 0.14;

ClearBossId = -900;
ClearBoss = true;

--Forced recall flag
IsForceSummon = false;

---------------------------------------------------------------------------------------------------------------------------------
--	■List of system event IDs (4000~4095) used
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
-- 4000 own death events
-- 4001 EzState action abort processing
-- 4002 When pressing the ladder event input (up)
-- 4003 When pressing the ladder event input (down)
-- 4004 When EzState gives you "One step up"
-- When 4005 EzState gave you "One step down"
-- 4010 Animation Synchronization (Treasure Corpse Animation)
-- 4012 Animation synchronization (walking animation)
-- 4013 Animation synchronization (with animation ID specified)
-- 4015 Super Armor Sync (Enabled)
-- 4016 Super Armor Sync (disabled)
-- 4017 Full Invincibility Synchronization (Enabled)
-- 4018 Full Invincibility Synchronization (Disabled)
-- 4020 Death Irregular Monitoring (If this is ON,
-- 4021 debug load event
-- 4030 PK resurrection
-- 4031
-- 4032 Own Blood Letter Event
-- 4033 Session expired

-- 3001 for multi-wall synchronization
-- 3002 for multi-wall synchronization
-- 3003 for multi-wall synchronization
-- Use 3001, 3002, 3003 for 4034 multi-time magic wall (session connected)
-- 4035 For multi-time magic wall (disconnected from the time the session was connected)
-- Warp to 4036 SOS position (for white initial position)
-- Warp to 4037 mini block head position (for block initial position)
-- 4038 Session information monitoring (event when session failed due to timeout etc.)
-- 4039 Intrusion
-- 4040 block clear (obsolete)
-- 4041 Summon Notice
-- 4042 Death Notice
-- 4043 Participant gone
-- 4044 notify kicked out
-- 4045 Notify (to clients) that the magic wall to the boss room is traversable
-- 4046 for exit
-- 4047 Reload-related event interrupt prevention flag
-- 4048 Generic Action Button Restriction Flag (Reserved)
-- 4049 Boss Room Event
-- 4050 new block clear
-- 4051 Gate item (warp to stone pillar)
-- 4052 Warp animation connection from stone pillar
-- 4053 Hall of Fame
-- for 4054 checkpoints
-- 4055 White Ghost Resurrection Notification (for Resurrection White Count)
-- For 4056 QWC additive processing distribution
-- 4057 For registering general-purpose synchronous handlers (Actual handler registration is done here in each map's script, function descriptions here)
-- 4058 Summoning Delivery
-- 4059 End of text presentation
-- 4060 for block movement detection
-- 4061 Close dialog For distance judgment
-- 4062 for returning to title
-- 4063 Processing to know who leaves for game reasons
-- 4064 Call to cancel invincibility because it's stabilized
-- PC on top of 4065 OBJ
-- The PC on the 4066 OBJ got off
-- 4067 Ignore death expression
-- 4068 boss room blocking failure expression
-- 4069 Fire Event!
-- 4070 special effect synchronization
-- 15500 Intrusion Item Acquisition Monitor


function g_Initialize(proxy)
print("g_Initialize global_event begin");
	--Turn off tutorial death branch flag
	proxy:SetEventFlag(14080,false);--for fort entrance
	proxy:SetEventFlag(14209,false);--Walled with
	proxy:SetEventFlag(14337,false);--for lava
	
	--Attempted Acquisition Soul Reacquisition
	proxy:AddBlockClearBonus();
	--penalty check
	proxy:CheckPenalty();
	
--■ 4000 ■ When you die, restart or end ■
	proxy:OnCharacterDead(99999, 10000, "OnEvent_4000", everytime);	
	proxy:NotNetMessage_begin();
		proxy:OnCharacterHP(99999,10000,"OnEvent_4000_Hp",0.0,once);
	proxy:NotNetMessage_end();
	proxy:LuaCall( 99999 , 0 , "OnEvent_4000_Hp_dummy",everytime);
	
--■ 4000_1 ■ death for party delivery ■
	proxy:LuaCall( 4000, 1,"HostDead",everytime );

--■ 4001 ■ When the action is interrupted by the PC ■
	proxy:OnCheckEzStateMessage(4001,10000,"OnEvent_4001",10000);
	
--■ 4006 ■ When the PC is pressing the action button in the ladder event ■ Described first due to priority issues
	proxy:OnActionCheckKey(4006,10000,"OnEvent_4006",0,1);		
--■4002■PCがハシゴイベントでキー入力（上）を押しているとき■
	proxy:OnActionCheckKey(4002,10000,"OnEvent_4002",1,1);
--■4003■PCがハシゴイベントでキー入力（下）を押しているとき■
	proxy:OnActionCheckKey(4003,10000,"OnEvent_4003",2,1);
--■4004■PCがハシゴイベント中にEzStateから"1段上り終えた"をもらった時■
	proxy:OnCheckEzStateMessage(4004,10000,"OnEvent_4004",0);
--■4005■PCがハシゴイベント中にEzStateから"1段下り終えた"をもらった時■
	proxy:OnCheckEzStateMessage(4005,10000,"OnEvent_4005",1);

--■4010■アニメーションの同期用関数(宝死体用)■
	proxy:LuaCall( 4010 , 1 , "OnEvent_4010" , everytime );
--■4012■アニメーションの同期用関数■
	proxy:LuaCall( 4012 , 1 , "OnEvent_4012" , everytime );
	
--■4013■アニメーションの同期用関数■
	proxy:LuaCall( 4013 , 1 , "OnEvent_4013" , everytime );
	proxy:CustomLuaCall( SYNCHROANIM, "SynchroAnim_4013", everytime );
	
	
--■4015■スーパーアーマーの同期有効化■
	proxy:LuaCall( 4015 , 1 , "OnEvent_4015" , everytime );
--■4016■スーパーアーマーの同期無効化■
	proxy:LuaCall( 4016 , 1 , "OnEvent_4016" , everytime );
	
--■4017■完全無敵の同期有効化■
	proxy:LuaCall( 4017 , 1 , "OnEvent_4017" , everytime );
--■4018■完全無敵の同期無効化■
	proxy:LuaCall( 4018 , 1 , "OnEvent_4018" , everytime );
	
--■4019■アタリ有効無効の同期用■
	proxy:LuaCall( 4019 , 1 , "OnEvent_4019" ,everytime );

--[[	
--■4020■PCが壁はりつきイベントでキー入力(右)を押しているとき■
	proxy:OnActionCheckKey(4020,10000,"OnEvent_4020",4,4);
--■4021■PCが壁はりつきイベントでキー入力(左)を押しているとき■
	proxy:OnActionCheckKey(4021,10000,"OnEvent_4021",3,4);	
--■4022■PCが壁はりつきイベント中にEzStateから"右に1歩進み終えた"をもらった時■
	proxy:OnCheckEzStateMessage(4022,10000,"OnEvent_4022",20);	
--■4023■PCが壁はりつきイベント中にEzStateから"左に1歩進み終えた"をもらった時■
	proxy:OnCheckEzStateMessage(4023,10000,"OnEvent_4023",21);
	]]
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4030, "g_second_Initialize", 0.1, 0, 1, once );
--■4032■自分の血文字■
		proxy:OnSelfBloodMark( 4032, "SelfBloodMark", ATTR_LIVE + ATTR_GREY, everytime );
--■4033■セッション切れ■
		--proxy:OnSessionJustOut( 4033, "SessionJustOut", everytime );

	SingleReset(proxy,3001);--ブロック2で同期時
	SingleReset(proxy,3002);--ブロック3で同期時
	SingleReset(proxy,3003);--ブロック4で同期時

--■4034■マルチ時魔法壁用(セッションがつながった)■
		proxy:OnSessionJustIn( 4034 , "OnEvent_4034" , everytime );
--■4035■マルチ時魔法壁用(セッションがつながっているときから切れた)■
		proxy:OnSessionJustOut( 4035 , "OnEvent_4035" , everytime );
	proxy:NotNetMessage_end();
	

	
--■4038■セッション情報監視■
	proxy:NotNetMessage_begin();
		proxy:OnSessionInfo( 4038, "OnEvent_4038" );
	proxy:NotNetMessage_end();
	
--■4040■ブロッククリア■
	--proxy:LuaCall( 4040 , 1 , "BlockClear" , everytime );
--■ 4050 ■ New block clear ■
	proxy:CustomLuaCall( 4050 , "BlockClear2" , everytime );
	--アニメ同期用
	proxy:LuaCall( 4050 , 20, "BlockClearSynchroAnime", everytime );
	--無効化同期用
	proxy:LuaCall( 4050 , 30, "BlockClearSynchroInvalid", everytime );
	
--■4041■召喚通知■
	proxy:LuaCall( 4041, 1, "SummonInfoMsg_White", everytime );
	proxy:LuaCall( 4041, 2, "SummonInfoMsg_Black", everytime );
	proxy:LuaCall( 4041, 3, "SummonInfoMsg_ForceJoinBlack", everytime );
	proxy:LuaCall( 4041, 4, "SummonInfoMsg_ForceSummonBlack", everytime );
	
--■4042■死亡通知■
	proxy:LuaCall( 4042, 1, "DeadInfoMsg_White", everytime );
	proxy:LuaCall( 4042, 2, "DeadInfoMsg_Black", everytime );
	proxy:LuaCall( 4042, 3, "DeadInfoMsg_Host",  everytime );
	proxy:LuaCall( 4042, 4, "dummy", everytime );--これはPKで死亡した時にもブラック死亡を知る為、中身が空のダミーを呼ぶ
	proxy:LuaCall( 4042, 5, "dummy", everytime );--これは牢城3で強制召喚で呼ばれたブラックが死んだときを取る為、中身が空のダミーを呼ぶ
	proxy:LuaCall( 4042, 6, "DeadInfoMsg_ForceJoinBlack", everytime );--これは牢城3で強制召喚で呼ばれたブラックが死んだときを取る為、中身が空のダミーを呼ぶ
	
--■4043■参加者がいなくなった■
	proxy:NotNetMessage_begin();
		proxy:LuaCall( 4043, 1, "OnLeavePlayer", everytime );--ホワイトソウルのホワイトがいなくなった
		proxy:LuaCall( 4043, 2, "OnLeavePlayer", everytime );--ブラックソウルのブラックがいなくなった
		proxy:LuaCall( 4043, 3, "OnLeavePlayer", everytime );--乱入ブラックがいなくなった
		proxy:LuaCall( 4043, 4, "dummy", everytime );--強制召喚されたブラックがいなくなった
		proxy:LuaCall( 4043, 5, "dummy", everytime );--電源OFF、リセット等で無責任にいなくなった
	proxy:NotNetMessage_end();
	
--■4044■キックアウトしたのを通知■
	proxy:LuaCall( 4044, 1, "OnKickOut", everytime );
--■4044■感謝キックしたのを通知■
	proxy:LuaCall( 4044, 2, "OnThxKickOut", everytime );
	
	--[[いらない子？
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc(4000, "Condition_AliveMotion", "Result_AliveMotion", 1, once );
	proxy:NotNetMessage_end();
	]]

--■4045■ボス部屋への魔法壁が通過可能であると通知(クライアントに対して)■
	proxy:LuaCall( 4045, 1, "PossibleInfo_GoToTheBossArea", everytime );
--■4068■ボス部屋への阻止が失敗した事を通知(クライアントに対して)■
	proxy:LuaCall( 4068, 1, "Failed_BossArea" ,everytime);
	
--■4046■退出通知■
	proxy:LuaCall( 4046, 1, "LeaveMessage", everytime );--ホワイト
	proxy:LuaCall( 4046, 2, "LeaveMessage", everytime );--ブラック
	proxy:LuaCall( 4046, 3, "dummy", everytime );--強制召喚されたブラックが退出した
	
	
--■4055■復活ホワイトカウント■
	proxy:LuaCall( 4055, 1, "WhiteReviveCount", everytime );
	
--■4056■QWC加算処理配信用
	proxy:LuaCall( 4056, 1, "SynchroAddQWC", everytime );
	
--■4058■召喚中配信
	proxy:LuaCall( 4058, 1, "Call_WhiteSos", everytime );--ホワイト
	proxy:LuaCall( 4058, 2, "Call_BlackSos", everytime );--ブラック
	
--■4060■ブロック移動判定	
--(ASSERT回避の為dummy、使用する際は各マップでCustomLuaCallの4060で呼びたいハンドラを登録する)
--ブロック移動のたびに呼ばれ、
--param2にブロックID,param3にエリアIDが取得できます。
--ブロック移動判定はローカルプレイヤのプレイ領域IDが変わった且つ、-1以外の時
	proxy:NotNetMessage_begin();
		proxy:CustomLuaCall( 4060, "dummy", everytime );
	proxy:NotNetMessage_end();
	
	--ゲーム的理由で誰かが抜けたときに配信
	proxy:CustomLuaCall( 4063 ,"OnGameLeave",everytime);	
	
--■4064■安定無敵解除イベント■
	proxy:LuaCall( 4064 ,1,"OnDisableInvincible",everytime);
	
	--■4065■OBJの上にPCが乗った■
	proxy:CustomLuaCall( 4065 ,"OnEnterRideObj",everytime);	
	--■4066■OBJに乗っていたPCが降りた■
	proxy:CustomLuaCall( 4066 ,"OnLeaveRideObj",everytime);
	
	
	if proxy:IsLivePlayer() == true then
		proxy:SetEventFlag( 15112,true );
		proxy:SetEventFlag( 15113,true );
		proxy:SetEventFlag( 15114,true );
		proxy:SetEventFlag( 15115,true );
		
		proxy:SetEventFlag( 15116,true );
		proxy:SetEventFlag( 15117,true );
		proxy:SetEventFlag( 15118,true );
		proxy:SetEventFlag( 15119,true );			
	end
	
--■ 15500 ■ Intrusion item acquisition monitoring ■
	if proxy:IsCompleteEvent( 15500 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15500 , 0 , "OnEvent_15500",everytime);
		proxy:NotNetMessage_end();
	end
	
	local actidlist = {
		14500,14501,14502,14503,14504,14505,14506,14507,14508,14509,
		14510,14511,14512,14513,14514,14515,14516,14517,14518,14519,
		14520,14521,14522,14523,14524,14525,14526,14527,14528,14529,
		14530,14531,14532,14533,14534,14535,14536,14537,14538,14539,
		14540,14541,14542,
	};
	local num = table.getn(actidlist);
	for index = 1 , num , 1 do
		proxy:SetEventFlag( actidlist[index],false );
	end

	if	proxy:GetTempSummonParam() > 0 then
		IsForceSummon = true;
	end
	
--Reinitialize the party size limit to 4 (It is a process to return the value changed in the prison, but to ensure temporary safety, the initial value is reset here.)
--Fixed as soon as network α is tightened
	proxy:SetPartyRestrictNum(4);

print("g_Initialize global_event end");
end

function InGameStart(proxy,param)
	print("InGameStart begin");
		proxy:LuaCallStart( 4064,1 );
		--resurrection animation playback
		if proxy:IsAliveMotion() == true then
			print("Condition_AliveMotion Alive");			
			proxy:SetTextEffect(TEXT_TYPE_Revival);
			proxy:PlayAnimation( 10000, 6100 );
			proxy:SetAliveMotion(false);
		else
			print("Condition_AliveMotion Not Alive");
			if	proxy:IsLivePlayer() == true then
				--HpMpSpMax
				--proxy:PlayerParamRecover();
				--proxy:PlayerRecover();
				proxy:PlayAnimation( 10000, 6100 );
				proxy:NotNetMessage_begin();
					proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 6100, "AliveMotion_End", once );
				proxy:NotNetMessage_end();
			elseif	proxy:IsGreyGhost() == true then
				--HpMpSpMax
				--proxy:PlayerParamRecover();
				--proxy:PlayerRecover();
				if	proxy:IsReviveWait() == true then
					proxy:RevivePlayer();
					proxy:SetReviveWait( false );
				end
				proxy:PlayAnimation( 10000, 6100 );
				proxy:NotNetMessage_begin();
					proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 6100, "AliveMotion_End", once );
				proxy:NotNetMessage_end();
			elseif	proxy:IsWhiteGhost() == true then
				print("IsWhiteAnim");
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2(4013,"AliveMotion_wait",0.1,0,0,once);
				proxy:NotNetMessage_end();
				--[[
				proxy:CustomLuaCallStartPlus( 4013, LOCAL_PLAYER, 6100 );
				--Luafunc_PlaySynchroAnimation(proxy,param,6100);
				--proxy:PlayAnimation( 10000, 6100 );
				proxy:NotNetMessage_begin();
					proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 6100, "AliveMotion_End", once );
				proxy:NotNetMessage_end();
				]]
			elseif	proxy:IsBlackGhost() == true then
				print("IsBlackAnim");
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2(4013,"AliveMotion_wait",0.1,0,0,once);
				proxy:NotNetMessage_end();
				--[[
				proxy:CustomLuaCallStartPlus( 4013, LOCAL_PLAYER, 6100 );
				--Luafunc_PlaySynchroAnimation(proxy,param,6100);
				--proxy:PlayAnimation( 10000, 6100 );
				if	proxy:GetTempSummonParam() > 0 then
					proxy:SetEventSpecialEffect( LOCAL_PLAYER, 10180 );
				end
				proxy:NotNetMessage_begin();
					proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 6100, "AliveMotion_End", once );
				proxy:NotNetMessage_end();
				]]
				if	proxy:GetTempSummonParam() > 0 then
					proxy:SetEventSpecialEffect( LOCAL_PLAYER, 10180 );					
					--ブラック強制召喚通知
					--ポリ劇通知
					REMO_FLAG = 2;
					proxy:LuaCallStart( 5500, 0 );
					proxy:LuaCallStart( 1030, 2 );					
				end
			end
		end
		proxy:ParamInitialize();
		
		if	proxy:IsGreyGhost()  == true or
			proxy:IsWhiteGhost() == true then
			print("SetEventSpecialEffect 10000, 101");
			proxy:SetEventSpecialEffect( 10000, 101 );
		elseif proxy:IsBlackGhost() == true then
			print("SetEventSpecialEffect 10000, 102");
			proxy:SetEventSpecialEffect( 10000, 102 );
		end
	print("InGameStart end");
end

--■4064■安定無敵解除■
function OnDisableInvincible(proxy,param)
	print("OnDisableInvincible begin");	
	if param:IsNetMessage() == false then		
		--配信者が自分
		proxy:EnableInvincible( 10000 , false );
	else
		proxy:EnableInvincible( param:GetPlayID()+10001 , false );
	end
	print("OnDisableInvincible end");
end

--[[
function Condition_AliveMotion(proxy,param)
	if proxy:IsValidInstance( 10000, 1 ) == true then
		print("Condition_AliveMotion Success");
		return true;
	end
	return false;
end

function Result_AliveMotion(proxy,param)
print("Result_AliveMotion begin");
print("Result_AliveMotion end");
end

function AliveMotion_2(proxy,param)
	print("AliveMotion_2 begin");
	proxy:CustomLuaCallStartPlus( 4013, LOCAL_PLAYER, 8288 );
	--Luafunc_PlaySynchroAnimation(proxy,param,8288);
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 8288, "AliveMotion_End", once );
	proxy:NotNetMessage_end();
	print("AliveMotion_2 end");
end
]]

function AliveMotion_wait(proxy,param)
	print("AliveMotion_wait begin");
	proxy:CustomLuaCallStartPlus( 4013, LOCAL_PLAYER, 6100 );
	--Luafunc_PlaySynchroAnimation(proxy,param,6100);
	--proxy:PlayAnimation( 10000, 6100 );
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 6100, "AliveMotion_End", once );
	proxy:NotNetMessage_end();
	print("AliveMotion_wait end");
end

------------------------------------------------------------------------------------------------
----After playing the initial animation------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
function AliveMotion_End(proxy,param)
	if proxy:IsInParty() == true then
	print("AliveMotion_End begin");
	
		-----------------------------------------------------------------------------
		--Summon notification *Moved here because the timing was changed after the initial animation
		-----------------------------------------------------------------------------
		--Normally 0 is returned, so this process does not pass
		--Judgment is made only when summoned
		if		proxy:GetTempSummonParam() == -1 then
			--white summons notice
			proxy:LuaCallStartPlus( 4041, 1, proxy:GetLocalPlayerId() );
		elseif 	proxy:GetTempSummonParam() == -2 then
			--ブラック召喚通知
			proxy:LuaCallStartPlus( 4041, 2, proxy:GetLocalPlayerId() );
		elseif 	proxy:GetTempSummonParam() == -3 then
			--ブラック乱入通知
			proxy:LuaCallStartPlus( 4041, 3, proxy:GetLocalPlayerId() );
		elseif 	proxy:GetTempSummonParam() >   0 then
			--ブラック強制召喚通知
			proxy:LuaCallStartPlus( 4041, 4, proxy:GetLocalPlayerId() );
		end

		print("AliveMotion_End end");
	else
		proxy:ResetSummonParam();
		proxy:WARN("AliveMotion_End 既にルームが無い");
	end
end



function g_second_Initialize(proxy, param)
print("g_second_Initialize begin");
--初期フレームだと、キャラクタのタイプが安定していないっぽいので
--0秒後でずらしてみました。
--■4030■PK監視(ブラックゴースト用)■
	print("PK監視追加");
	proxy:OnPlayerKill( 4030, "PlayerKill_4030_sub", everytime );
	proxy:CustomLuaCall( 4030, "PlayerKill_4030", everytime );
	
--■ Disable the magic wall for multiplayer
	if proxy:GetLocalPlayerChrType() == CHR_TYPE_GreyGhost or proxy:GetLocalPlayerChrType() == CHR_TYPE_LivePlayer or proxy:GetLocalPlayerChrType == CHR_TYPE_WhiteGhost then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4035 , "OnEvent_4035" , 0.0 , 0 , 1 , once );
		proxy:NotNetMessage_end();
	end
	
	if proxy:IsInParty() == false then
	end
	
print("g_second_Initialize end");
end


function OnEvent_4000_Hp(proxy,param)
	print("OnEvent_4000_Hp begin");
	--Hpが0になったので
	--完全回復要求
	proxy:RequestFullRecover();
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 99999 , 0 );
	end
	print("OnEvent_4000_Hp end");
end

function OnEvent_4000_Hp_dummy(proxy,param)	
end

--■ 4000 ■ Restart when you die ■
function OnEvent_4000(proxy, param)
	if proxy:IsCompleteEvent(4000) == true then
		--print("OnEvent_4000 IsCompleteEvent return end");
		return;
	end
	if param:IsNetMessage()==true  then
		--print("OnEvent_4000 IsNetMessage return end");
		return;
	end
	print("OnEvent_4000 begin");
	--チュートリアル砦入り口マップのフラグが成立しているなら
	if proxy:IsCompleteEvent(14080) == true then
		proxy:SetTextEffect(TEXT_TYPE_Dead);
		proxy:OnKeyTime2(4000,"m08_00Death",0.0,0,0,once);
		return;
	end
	--チュートリアル砦マップのフラグが成立しているなら
	if proxy:IsCompleteEvent(14209) == true then--m08_01の死亡イベントに飛ぶ
		proxy:SetTextEffect(TEXT_TYPE_Dead);
		proxy:OnKeyTime2(4000,"m08_01Death",0.0,0,0,once);
		return;
	end
	--チュートリアル溶岩マップのフラグが成立しているなら
	if proxy:IsCompleteEvent(14337) == true then--m08_02の死亡イベントに飛ぶ
		proxy:SetTextEffect(TEXT_TYPE_Dead);
		proxy:OnKeyTime2(4000,"m08_02Death",0.0,0,0,once);
		return;
	end
	
	
	--死亡時の動作が既に入っている場合は判定しない
	if proxy:GetReturnState() >0 then
		return;
	end
	
	local Live  = proxy:IsLivePlayer();	--生存
	local Grey  = proxy:IsGreyGhost();	--グレイゴースト
	local White = proxy:IsWhiteGhost();	--ホワイトゴースト
	local Black = proxy:IsBlackGhost();	--ブラックゴースト
	local Host  = proxy:IsHost();		--ホストか？
	local Party = proxy:IsInParty();	--PTか？
	local dead  = false;				--ちゃんと死んだか？

	--トゥルーデス判定
	
	if proxy:IsCompleteEvent(4067) == false then
		if Live == true then
			proxy:SetTextEffect(TEXT_TYPE_Dead);
		else
			proxy:SetTextEffect( TEXT_TYPE_GhostDead );
		end
	end
	
	--ホスト死亡判定
	if Live == true or Grey == true then		
		if Live == true then
			proxy:SetEventFlag( 15112,false );
			proxy:SetEventFlag( 15113,false );
			proxy:SetEventFlag( 15114,false );
			proxy:SetEventFlag( 15115,false );
			
			proxy:SetEventFlag( 15116,false );
			proxy:SetEventFlag( 15117,false );
			proxy:SetEventFlag( 15118,false );
			proxy:SetEventFlag( 15119,false );			
		end
		if Party == true and Host == true then			
			--グレイゴーストフラグON
			proxy:SetEventFlag( 16700 , true );
			--死亡数カウントアップ
			proxy:AddDeathCount();
			proxy:NotNetMessage_begin();
				--ホスト本人はソロプレイ死亡と同じ
				proxy:OnKeyTime2(4000,"SoloPlayDeath",0.0,0,1,once);
			proxy:NotNetMessage_end();
			--パーティー配信用の死亡イベントを発行(ホストは内部ではじかれる)
			proxy:LuaCallStart(4000, 1 );
			dead = true;
		end
	end
	
	--client death
	if Black == true or White == true then		
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2(4000,"PartyGhostDeath",0.0,0,1,once);
		proxy:NotNetMessage_end();
		dead = true;
	end

	--survival solo play death
	if Live == true or Grey == true then
		if Party == false then			
			--グレイゴーストフラグON
			proxy:SetEventFlag( 16700 , true );
			--死亡数カウントアップ
			proxy:AddDeathCount();
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2(4000,"SoloPlayDeath", 0.0, 0,1,once);
			proxy:NotNetMessage_end();
			dead = true;
		end
	end
	
	if dead == false then
		print("Check ChrType!!");
		--異常を通知(イベント班以外で死亡で問題が発生した時にはこのフラグを見てください)
		--キャラタイプが生存、グレイ、ホワイト、ブラック以外の可能性があります。
		--ロードをさせないで、キャラタイプを確認してください。
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2(4000,"SoloPlayDeath", 0.0, 0,1,once);
		proxy:NotNetMessage_end();
		proxy:SetEventFlag(4020,true);
	end	
	proxy:SetEventFlag(4000,true);
	print("OnEvent_4000 end");
end




--■4000_1■パーティー配信用死亡■
function HostDead(proxy, param)	
	if proxy:IsHost() == true or proxy:IsGreyGhost() == true then
		return;
	end
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	
	--ブラックゴーストの場合は目標達成の流れへ
	if	proxy:IsBlackGhost() == true then
		proxy:NotNetMessage_begin();
			--他の再読み込み系イベントの割り込みを防止
			proxy:SetEventFlag( 4047, true );
			--イベント内部にもロード待ちである事を通知
			proxy:SetLoadWait();
			
		proxy:NotNetMessage_end();
		
		--システムメッセージ		
		proxy:SetTextEffect( TEXT_TYPE_TargetClear );
		
		proxy:NotNetMessage_begin();
			proxy:OnTextEffectEnd(4059, TEXT_TYPE_TargetClear, "TextEffectEnd_PK_Success");
		proxy:NotNetMessage_end();
		
		--proxy:SetTextEffect( TEXT_TYPE_Revival );
		--proxy:LuaCallStartPlus( 4056, 1, 210 );--AddQWC配信(マルチでホストを殺したQWC加算)
		return;
	end
	
	--他の再読み込み系イベントの割り込みを防止
	proxy:SetEventFlag(4047, true);
	--イベント内部にもロード待ちである事を通知
	proxy:SetLoadWait();
	
	print("HostDead begin");
	
	
	
	--目標失敗
	MissionFailed(proxy,param);
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(4000,"HostDead_1",5.0,0,0,once);
		proxy:OnKeyTime2(4000,"EventMenuBrake",5.0,1,1,once);
	proxy:NotNetMessage_end();
	
	--イベント終了
	proxy:SetEventFlag(4000,true);
	
	
	print("HostDead end");
end

function HostDead_1(proxy, param)
	print("HostDead_1 begin");
	
	--イベントフラグロールバック
	proxy:SetFlagInitState(2);
	
	--召喚前の位置設定
	proxy:SetSummonedPos();	
	
	--現在のマップと同じIDを次マップIDとして設定
	proxy:SetDefaultMapUid(-1);	
	
	--ワープを行う
	proxy:WarpNextStageKick();
	
	--グレイゴースト化
	--proxy:SetChrTypeDataGrey();
	proxy:SetChrTypeDataGreyNext();
	
	print("HostDead_1 end");
end



--[[
--■4000_2■トゥルーデス用死亡■
function TrueDeath(proxy,param)
	print("TrueDeath begin");
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4000, "TrueDeath_1", 5.0, 0, 3, once );
	proxy:NotNetMessage_end();
	
	--システムメッセージ	
	proxy:SetEventFlag( 4000, true );
end

function TrueDeath_1(proxy,param)
	print("TrueDeath_1 begin");
	
	--トゥルーデスペナルティ
	proxy:TrueDeathPenalty();
	
	--プレイヤー復活
	proxy:RevivePlayer();
	
	--ワープ先指定
	proxy:SetMapUid( 1, 0, 0, 0, -1 );	
	
	--0.2秒後、TrueDeath_2を実行
	proxy:OnKeyTime2(4000,"TrueDeath_2",0.2,0,0,once);
	
	proxy:LuaCallStartPlus( 4056, 1, 110 );--AddQWC配信
	
	print("TrueDeath_1 end");
end


function TrueDeath_2(proxy,param)
	print("TrueDeath_2 begin");
	
	--ワープを行う
	proxy:WarpNextStageKick();
	
	print("TrueDeath_2 end");
end
]]



--■4000_3■パーティー解散用■
function OnEvent_4000_3(proxy,param)

	print("マルチ解散");
	proxy:ReturnMapSelect();
end




--■4000_4■ソロ通常死亡■
function SoloPlayDeath(proxy,param)
	print("SoloPlayDeath SetRestart");
	
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	
	--他の再読み込み系イベントの割り込みを防止
	proxy:SetEventFlag(4047, true);
	
	
	--目標失敗
	MissionDeadFailed(proxy,param);
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4000, "SoloPlayDeath_1", 3, 0, 3, once );
	proxy:NotNetMessage_end();
	
	--PKによる死亡ではない時、ホスト死亡のメッセージを配信
	if proxy:IsCompleteEvent( 4030 ) == false then
		proxy:LuaCallStartPlus( 4042, 3, proxy:GetLocalPlayerId() );
	end
	
	print("SoloPlayDeath end");
end

function SoloPlayDeath_1(proxy,param)
	print("SoloPlayDeath_1 begin");
	
	proxy:NotNetMessage_begin();
		--proxy:OnBloodMenuClose(4000,"SoloPlayDeath_2",300.0, once);
		SoloPlayDeath_2(proxy,param);
	proxy:NotNetMessage_end();
	
	print("SoloPlayDeath_1 end");
end


function SoloPlayDeath_2(proxy,param)
	print("SoloPlayDeath_2 begin");

	--フラグの初期化スキップ
	proxy:SetFlagInitState(1);
	
	--エリア初期位置のマップIDセット
	--proxy:SetAreaStartMapUid(-1);
	proxy:SetDefaultMapUid( 999 - proxy:GetLastBlockId() );
	
	--ワープを行う
	proxy:WarpNextStageKick();
	
	--復活アニメ再生
	proxy:PlayAnimation( 10000, 6100 );
	
	--死亡イベント受付可能
	proxy:SetEventFlag(4000,false);
	
	--徘徊デーモン用
	proxy:LuaCallStart( 4000, 100 );
	
	--グレイゴースト化
	--proxy:SetChrTypeDataGrey();
	if proxy:IsCompleteEvent(4067) == false then
		proxy:SetChrTypeDataGreyNext();
	end
	
	--血文字更新
	proxy:UpDateBloodMark();
	if proxy:IsLivePlayer() == true then
		--死亡のQWC変動を削除
		proxy:LuaCallStartPlus( 4056, 1, 100 );--AddQWC配信（ゴースト化するQWC加算）
	end
	print("SoloPlayDeath_2 end");
end




--■4000_5■ホワイトブラックゴースト時の死亡用■
function PartyGhostDeath(proxy,param)
	print("PartyGhostDeath begin");
	
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	--他の再読み込み系イベントの割り込みを防止
	proxy:SetEventFlag(4047, true);
	--他の再読み込み系イベントの割り込みを防止
	proxy:SetEventFlag(4047, true);
	
	--自分のプレイヤーIDを配信してゲーム的に抜ける事を通知
	proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
	
	--イベントフラグロールバック
	proxy:SetFlagInitState(2);
	
	proxy:NotNetMessage_begin();
		proxy:OnTextEffectEnd( 4059, TEXT_TYPE_GhostDead, "PartyGhostDeath_1");
	proxy:NotNetMessage_end();
	
	
	--proxy:NotNetMessage_begin();
	--	proxy:OnKeyTime2( 4000, "PartyGhostDeath_1", 5.0, 0, 3, once );
	--proxy:NotNetMessage_end();
	
	--PKによる死亡ではない時、死亡のメッセージを配信
	if proxy:IsCompleteEvent( 4030 ) == false then
		if proxy:IsWhiteGhost() == true then
			proxy:LuaCallStartPlus( 4042, 1, proxy:GetLocalPlayerId() );
		else
			proxy:LuaCallStartPlus( 4042, 2, proxy:GetLocalPlayerId() );
			if	proxy:GetTempSummonParam() > 0 then
				proxy:LuaCallStartPlus( 4042, 5, proxy:GetLocalPlayerId() );
			end
		end
	else
		--PKで死んだ場合も、強制召喚されたブラックの場合は強制召喚死亡としてカウント
		if	proxy:GetTempSummonParam() > 0 then
			proxy:LuaCallStartPlus( 4042, 2, proxy:GetLocalPlayerId() );
			proxy:LuaCallStartPlus( 4042, 5, proxy:GetLocalPlayerId() );			
		--ホワイトソウル
		elseif	proxy:GetTempSummonParam() == -1 then
			proxy:LuaCallStartPlus( 4042, 1, proxy:GetLocalPlayerId() );
			proxy:LuaCallStartPlus( 4042, 4, proxy:GetLocalPlayerId() );			
		--ブラックソウル
		elseif	proxy:GetTempSummonParam() == -2 then
			proxy:LuaCallStartPlus( 4042, 2, proxy:GetLocalPlayerId() );
			proxy:LuaCallStartPlus( 4042, 4, proxy:GetLocalPlayerId() );			
		--乱入
		elseif	proxy:GetTempSummonParam() == -3 then
			proxy:LuaCallStartPlus( 4042, 6, proxy:GetLocalPlayerId() );
			proxy:LuaCallStartPlus( 4042, 4, proxy:GetLocalPlayerId() );			
		end
	end
	
	
	proxy:SetEventFlag(4000,true);
	
	print("PartyGhostDeath end");
end

function PartyGhostDeath_1(proxy,param)
	print("PartyGhostDeath_1 begin");
	
	if ClearBoss == false then
		--target failure
		MissionDeadFailed(proxy,param);	
		proxy:NotNetMessage_begin();
			proxy:OnRequestMenuEnd(4000, "PartyGhostDeath_2");
		proxy:NotNetMessage_end();
	else
		--proxy:NotNetMessage_begin();
		--	proxy:OnKeyTime2( 4050 ,"BlockClear2_3" , 5.0 , 0 , 100 , once );
		--proxy:NotNetMessage_end();
	end
	
	print("PartyGhostDeath_1 end");
end



function PartyGhostDeath_2(proxy,param)
	print("PartyGhostDeath_2 begin");
	
	if ClearBoss == false then
		if proxy:IsCompleteEvent( 4030 ) == false then
			print("デスペナルティ！！");
			--ソウルペナルティ
			--proxy:DeathPenalty( DeathPenalty_SoulAdjust, DeathPenalty_SoulMAX );
				
			if	proxy:IsBlackGhost() == true then				
				--強制召還なら
				if	proxy:GetTempSummonParam() > 0 then					
					--強制召還以外のブラックなら
				else
					--ペナルティ
					proxy:SetLeaveSoulSteel();
					print("デスペナルティ！！");
				end
			end
		end
		--召喚前の位置設定
		proxy:SetSummonedPos();
		--現在のマップと同じIDを次マップIDとして設定
		proxy:SetDefaultMapUid(-1);
		--ワープを行う
		proxy:WarpNextStageKick();
		--完全回復要求
		--proxy:RequestFullRecover();
		--グレイゴースト化
		--proxy:SetChrTypeDataGrey();
		proxy:SetChrTypeDataGreyNext();
	else
		--proxy:NotNetMessage_begin();
		--	proxy:OnKeyTime2( 4050 ,"BlockClear2_3" , 2.0 , 0 , 100 , once );
		--proxy:NotNetMessage_end();
	end
		
	print("PartyGhostDeath_2 end");
end


--■4042■死亡通知■
function DeadInfoMsg_White(proxy,param)
	print("DeadInfoMsg_White begin");
	--自分以外の死
	if param:IsNetMessage() == true then
		--ホスト
		if	proxy:IsGreyGhost() == true or proxy:IsLivePlayer() == true then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8980 );
			end
		--第三者
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				--ホワイトソウル
				if	proxy:GetTempSummonParam() == -1 then
					proxy:RecallMenuEvent( 0, 8983 );
				--ブラックソウル
				elseif	proxy:GetTempSummonParam() == -2 then
					proxy:RecallMenuEvent( 0, 8984 );
				--乱入
				elseif	proxy:GetTempSummonParam() == -3 then
					proxy:RecallMenuEvent( 0, 8985 );
				--強制召喚
				elseif	proxy:GetTempSummonParam() >   0 then
					proxy:RecallMenuEvent( 0, 8986 );
				end
			else
				proxy:WARN("PCNameのタグ差し替え失敗");
			end
		end		
	--死んだのが自分
	else		
	end
	print("DeadInfoMsg_White end");
end

function DeadInfoMsg_Black(proxy,param)
	print("DeadInfoMsg_Black begin");
	--自分以外の死
	if param:IsNetMessage() == true then
		--ホスト
		if	proxy:IsGreyGhost() == true or proxy:IsLivePlayer() == true then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8991 );
			end
		--第三者
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				--ホワイトソウル
				if	proxy:GetTempSummonParam() == -1 then
					proxy:RecallMenuEvent( 0, 8993 );
				--ブラックソウル
				elseif	proxy:GetTempSummonParam() == -2 then
					proxy:RecallMenuEvent( 0, 8994 );
				--乱入
				elseif	proxy:GetTempSummonParam() == -3 then
					proxy:RecallMenuEvent( 0, 8995 );
				--強制召喚
				elseif	proxy:GetTempSummonParam() >   0 then
					proxy:RecallMenuEvent( 0, 8996 );
				end
			else
				proxy:WARN("PCNameのタグ差し替え失敗");
			end
		end		
	--死んだのが自分
	else
		--ブラックソウル
		if	proxy:GetTempSummonParam() == -2 then
			--proxy:RecallMenuEvent( 0, 9004 );
		--乱入
		elseif	proxy:GetTempSummonParam() == -3 then
			--proxy:RecallMenuEvent( 0, 9005 );
		end		
	end
	print("DeadInfoMsg_Black end");
end

function DeadInfoMsg_Host(proxy,param)
	print("DeadInfoMsg_Host begin");
	if param:IsNetMessage() == true then		
	end
	print("DeadInfoMsg_Host end");
end

function DeadInfoMsg_ForceJoinBlack(proxy,param)
	print("DeadInfoMsg_ForceJoinBlack begin");
	--自分以外の死
	if param:IsNetMessage() == true then
		--ホスト
		if	proxy:IsGreyGhost() == true or proxy:IsLivePlayer() == true then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8992 );
			end
		--第三者
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				--ホワイトソウル
				if	proxy:GetTempSummonParam() == -1 then
					proxy:RecallMenuEvent( 0, 8993 );
				--ブラックソウル
				elseif	proxy:GetTempSummonParam() == -2 then
					proxy:RecallMenuEvent( 0, 8994 );
				--乱入
				elseif	proxy:GetTempSummonParam() == -3 then
					proxy:RecallMenuEvent( 0, 8995 );
				--強制召喚
				elseif	proxy:GetTempSummonParam() >   0 then
					proxy:RecallMenuEvent( 0, 8996 );
				end
			else
				proxy:WARN("PCNameタグの差し替えに失敗");
			end
		end		
	--死んだのが自分
	else
		--ブラックソウル
		if	proxy:GetTempSummonParam() == -2 then
			--proxy:RecallMenuEvent( 0, 9004 );
		--乱入
		elseif	proxy:GetTempSummonParam() == -3 then
			--proxy:RecallMenuEvent( 0, 9005 );
		end		
	end
	print("DeadInfoMsg_ForceJoinBlack end");
end


----------------------------------------------------------------------------------------------------------------
--■4030■PK復活■
----------------------------------------------------------------------------------------------------------------
--param2:殺された人のPlayerNo
--param3:殺した人のPlayerNo
function PlayerKill_4030_sub( proxy,param)
	local nDeadPlayerNo = proxy:VariableExpand_22_param1( param:GetParam2() );
	local nKillPlayerNo = proxy:VariableExpand_22_param2( param:GetParam2() );
	local nDeadPlayerSummonParam = param:GetParam3();--死んだプレイヤの召喚されたタイプ
	local nThisPlayerNo = proxy:GetLocalPlayerId();
	local nThisSummonParam = proxy:GetTempSummonParam();
	if	nThisPlayerNo == nKillPlayerNo then
		--殺した人が改めて再配信(殺した人の召喚タイプを取得する為)
		local nOrderParam = proxy:VariableOrder_22( nDeadPlayerSummonParam, nThisSummonParam );
		proxy:CustomLuaCallStartPlus( 4030, param:GetParam2(), nOrderParam );
		--proxy:SetEventFlag( 4030, true );
	end
end

function PlayerKill_4030(proxy, param)
	print("PlayerKill_4030 begin");
	local nDeadPlayerNo			 = proxy:VariableExpand_22_param1( param:GetParam2() );
	local nKillPlayerNo 		 = proxy:VariableExpand_22_param2( param:GetParam2() );
	local nDeadPlayerSummonParam = proxy:VariableExpand_22_param1( param:GetParam3() );--死んだ人の召喚タイプ
	local nKillPlayerSummonParam = proxy:VariableExpand_22_param2( param:GetParam3() );--殺した人の召喚タイプ
	local nThisPlayerNo			 = proxy:GetLocalPlayerId();
	local nHostNo				 = proxy:GetHostPlayerNo();
	
	print("nDeadPlayerNo = ",nDeadPlayerNo);
	print("nKillPlayerNo = ",nKillPlayerNo);
	print("nDeadPlayerSummonParam = ",nDeadPlayerSummonParam);
	print("nKillPlayerSummonParam = ",nKillPlayerSummonParam)
	print("nThisPlayerNo = ",nThisPlayerNo);
	print("nHostNo = ",nHostNo);
	
	local IsHostDead;
	if nHostNo == nDeadPlayerNo then
		IsHostDead = true;
	else
		IsHostDead = false;
	end
	local IsWhite		= proxy:IsWhiteGhost();
	local IsBlack		= proxy:IsBlackGhost();
	
	--英語で書くと読めなかったので、ローマ字で代用
	print( "PlayerNo:<",nDeadPlayerNo, "> ga ","PlayerNo:<",nKillPlayerNo, "> ni korosareta" );
	print( "LocalPlayerNo:<",nThisPlayerNo, "> LocalPlayerType<",proxy:GetLocalPlayerChrType(), ">");
	print( "HostNo<",nHostNo,">IsHostDead<",IsHostDead,">IsWhite<",IsWhite,">IsBlack<",IsBlack,">")
	
	
	if proxy:IsCompleteEvent( 4047 ) == true then
		print("EventFlag4047 is true return");
		return;
	end
	
	--死んだのが自分ではない時
	if nThisPlayerNo ~= nDeadPlayerNo then
		--ブラックが生存を殺した
		if IsHostDead == true and nThisPlayerNo == nKillPlayerNo and IsBlack == true then
			print("ホストPK　QWC　black > host");
			proxy:LuaCallStartPlus( 4056, 1, 210 );--AddQWC配信(マルチでホストを殺したQWC加算)
		end
		
		--ホワイトが生存を殺した
		if IsHostDead == true and nThisPlayerNo == nKillPlayerNo and IsWhite == true then			
			print("不可能犯罪　white > host");
			proxy:LuaCallStartPlus( 4056, 1, 210 );--AddQWC配信(マルチでホストを殺したQWC加算)
		end
		
		--自分以外が生存を殺した
		if IsHostDead == true and nThisPlayerNo ~= nKillPlayerNo then
		end
		
		--自分以外が生存以外を殺した
		if IsHostDead == false and nThisPlayerNo ~= nKillPlayerNo then			
		end
		
		--自分が生存以外を殺した
		if IsHostDead == false and nThisPlayerNo == nKillPlayerNo then
			print("自分が生存以外を殺した");			
			print("NetChrType = ",proxy:GetNetPlayerChrType(nDeadPlayerNo) );
			--ホワイトを殺した
			if	proxy:IsWhiteGhost_NetPlayer(nDeadPlayerNo) == true then
				print("ホワイト殺しQWC");				
				proxy:LuaCallStartPlus( 4056, 1, 220 );--AddQWC配信(マルチでホワイトを殺したQWC加算)
			--ブラックを殺した
			elseif	proxy:IsBlackGhost_NetPlayer(nDeadPlayerNo) == true then
				print("ブラック殺しQWC");
				--生存のみテキスト演出を表示
				if	IsWhite == false then
					proxy:SetTextEffect( TEXT_TYPE_BlackClear );
					proxy:NotNetMessage_begin();
						proxy:OnTextEffectEndPlus(4059, TEXT_TYPE_BlackClear, nDeadPlayerSummonParam,"TextEffectEnd_BlackPK_Success");
					proxy:NotNetMessage_end();
				end
				proxy:LuaCallStartPlus( 4056, 1, 230 );--AddQWC配信(マルチでブラックを殺したQWC加算)
				proxy:AddKillBlackGhost();--殺したブラックの数を加算				
			end
			
			print("NetChrSummonParam = ",nDeadPlayerSummonParam );
			print("nDeadPlayerNo = ",nDeadPlayerNo);
			--ホワイトソウル
			if		nDeadPlayerSummonParam == -1 then
				if nKillPlayerSummonParam == -3 then
					print("乱入ブラック＞ホワイト殺害ボーナス");
					proxy:SoulPenaltyPK2(nDeadPlayerNo,-0.5);
				end
			--ブラックソウル
			elseif	nDeadPlayerSummonParam == -2 then
			--乱入
			elseif	nDeadPlayerSummonParam == -3 then
				--if proxy:IsClient() == false then
					print("乱入ブラック殺害ボーナス")
					--proxy:SoulPenaltyPK( -PK_Soul_Penalty_FIX, -PK_Soul_Penalty_BASE, PK_Soul_Penalty_MAX, PK_Soul_Penalty_Adjust );
					proxy:SoulPenaltyPK2(nDeadPlayerNo,-0.5);
				--end
			--強制召喚
			elseif	nDeadPlayerSummonParam  >  0 then			
			end
		end
	--死んだのが自分の時
	else
		print("PlayerKill_4030 ThisDead");
		proxy:SetEventFlag( 4030, true );
		--死んだのがホスト
		if	proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
			print("PlayerKill_4030 LiveDead");
			--通常ブラックに殺された
			if	nKillPlayerSummonParam ==  -2 then
				print("SoulSteel Black -> Host");
				--ソウルスティール
				proxy:SetEventSpecialEffectOwner_2( nKillPlayerNo + 10001, LOCAL_PLAYER, 13 );
			--乱入ブラックに殺された
			elseif	nKillPlayerSummonParam ==  -3 then
				--通常の死亡のみ
			end
		end
		
		--ホワイトソウル
		if		proxy:GetTempSummonParam() == -1 then
			print("PlayerKill_4030 WhiteDead");
			--通常ブラックに殺された
			if		nKillPlayerSummonParam ==  -2 then
				print("PKPenalty");
				--PKのソウルペナルティ
				--proxy:SoulPenaltyPK( PK_Soul_Penalty_FIX, PK_Soul_Penalty_BASE, PK_Soul_Penalty_MAX, PK_Soul_Penalty_Adjust );
				--proxy:SoulPenaltyPK2(nDeadPlayerNo,0.5);
				--ソウルスティール
				proxy:SetEventSpecialEffectOwner_2( nKillPlayerNo + 10001, LOCAL_PLAYER, 13 );
			--乱入ブラックに殺された
			elseif	nKillPlayerSummonParam ==  -3 then
				print("PKPenalty");
				--PKのソウルペナルティ
				--proxy:SoulPenaltyPK( PK_Soul_Penalty_FIX, PK_Soul_Penalty_BASE, PK_Soul_Penalty_MAX, PK_Soul_Penalty_Adjust );
				proxy:SoulPenaltyPK2(nDeadPlayerNo,0.5);
			end			
		--ブラックソウル
		elseif	proxy:GetTempSummonParam() == -2 then
			print("PlayerKill_4030 BlackDead");
			--生存orホワイトに殺された
			if	nKillPlayerSummonParam ==  0 or
				nKillPlayerSummonParam == -1 then
				print("SoulSteel Live or White -> Black");
				--ソウルスティール
				proxy:SetEventSpecialEffectOwner_2( nKillPlayerNo + 10001, LOCAL_PLAYER, 13 );
			end
		--乱入
		elseif	proxy:GetTempSummonParam() == -3 then
			print("PlayerKill_4030 ForceJoinDead");
			--生存に殺された
			if	nKillPlayerSummonParam ==  0 then
				print("PKPenalty");
				proxy:SoulPenaltyPK2(nDeadPlayerNo,0.5);
			end
			--ホワイトに殺された
			if	nKillPlayerSummonParam == -1 then
				print("PKPenalty");
				--PKのソウルペナルティ
				--proxy:SoulPenaltyPK( PK_Soul_Penalty_FIX, PK_Soul_Penalty_BASE, PK_Soul_Penalty_MAX, PK_Soul_Penalty_Adjust );				
				proxy:SoulPenaltyPK2(nDeadPlayerNo,0.5);
			end
		end
	end
	
	print("PlayerKill_4030 end");
end

function PlayerKill_4030_1(proxy, param)
	print("PlayerKill_4030_1 begin");
	
	--フラグをロールバックします。
	proxy:SetFlagInitState(2);
	
	--復活するのでペナルティで減少したパラメータを元に戻す(最大値のみ)
	proxy:EraseEventSpecialEffect( 10000, 101 );
	--proxy:PlayerParamRecover();
	
	--元グレイなら復活
	if proxy:IsPrevGreyGhost() == true then
		--復活するので復活アニメフラグをセット
		proxy:SetAliveMotion( true );
	end
	
	--HpMpSpを完全回復
	--proxy:PlayerRecover();
	
	--生存状態に設定した上で、自分の血文字位置へワープ
	--proxy:WarpSelfBloodMark(false);
	proxy:SetSelfBloodMapUid();
	--proxy:RevivePlayer();
	proxy:RevivePlayerNext();--次のロードで蘇生
	proxy:RequestFullRecover();
	proxy:WarpNextStageKick();
	
	print("PlayerKill_4030_1 end");
end

----------------------------------------------------------------------------------------------------------------
--■4059■テキスト演出終了後
----------------------------------------------------------------------------------------------------------------
--（ブラックが生存を殺した）PKに成功した時のテキスト演出終了時
--召還者を倒したテキスト演出表示後
function TextEffectEnd_PK_Success(proxy,param)
	print("TextEffectEnd_PK_Success begin");
	proxy:NotNetMessage_begin();
		proxy:OnRequestMenuEnd( 4059, "RequestMenuEnd_PK_Sucess" );
	proxy:NotNetMessage_end();
	
--[[
	--ブラックソウル
	if	proxy:GetTempSummonParam()		== -2 then
		proxy:RecallMenuEvent( 0, 8914 );
	--乱入
	elseif	proxy:GetTempSummonParam()	== -3 then
		proxy:RecallMenuEvent( 0, 8915 );
	end
]]

	--強制召喚ブラックが目標達成した時はターバンを持ち帰る
	--local tmpSummonParam = proxy:GetTempSummonParam();
	--print("召還パラメータ:",tmpSummonParam);
	--if	proxy:GetTempSummonParam() > 0 then
	if IsForceSummon == true then
		print("ターバンイベント発動");
		proxy:GetRateItem(16581);
	end
	
	--目標達成
	MissionSuccessed(proxy,param);

	print("TextEffectEnd_PK_Success end");
end

--（ブラックが生存を殺した）PKに成功した時の要請メニュー終了時
function RequestMenuEnd_PK_Sucess(proxy,param)
	print("RequestMenuEnd_PK_Sucess begin");
	
	--PK復活イベント開始
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4030, "PlayerKill_4030_1", 2.0, 0, 3, once );
	proxy:NotNetMessage_end();
	
	print("RequestMenuEnd_PK_Sucess end");
end

--(Survival/White killed Black) At the end of the text effect when the PK was successful
--After displaying the black kill text effect
function TextEffectEnd_BlackPK_Success(proxy,param)
	print("TextEffectEnd_BlackPK_Success begin");
	local nDeadPlayerSummonParam = param:GetParam3();
	print("TextEffectEnd_BlackPK_Success nDeadPlayerSummonParam = ", nDeadPlayerSummonParam);
--[[
	if		nDeadPlayerSummonParam == -2 then
		proxy:RecallMenuEvent( 0, 8971 );
	elseif	nDeadPlayerSummonParam == -3 then
		proxy:RecallMenuEvent( 0, 8972 );
	end
]]
	print("TextEffectEnd_BlackPK_Success end");
end



----------------------------------------------------------------------------------------------------------------
--■ 4032 ■ Resurrection of own blood letter ■
----------------------------------------------------------------------------------------------------------------
function SelfBloodMark(proxy, param)
	print("SelfBloodMark begin");
	
	--自分の血文字復活は「再読み込みを通さない」ので初期化スキップのみ
	--proxy:SetFlagInitState(1);
	
	--システムメッセージ	
	proxy:SetTextEffect(TEXT_TYPE_SoulGet);		
	
	--復活するのでペナルティで減少したパラメータを元に戻す(最大値のみ)
	--proxy:EraseEventSpecialEffect( 10000, 101 );
	--proxy:PlayerParamRecover();
	--proxy:ResetEventQwcSpEffect(LOCAL_PLAYER);	
	--キャラクタのタイプを生存に変更(再読み込みを通さない為、これで仮対応)正規はプレイヤー専用の生存タイプ設定メソッドで対応
	--proxy:SetChrType( 10000, 0 );

	--自分の血文字非表示
	proxy:InvalidMyBloodMarkInfo();
	
	--徘徊デーモン復帰用イベントハンドラ
	proxy:LuaCallStart( 4032, 100 );
	
	print("SelfBloodMark end");
end


----------------------------------------------------------------------------------------------------------------
---4033■Session expired■
----------------------------------------------------------------------------------------------------------------
function OnIrregularLeaveSession(proxy,param)
	print("OnIrregularLeaveSession begin");

	proxy:NotNetMessage_begin();
		--■4033■0.1秒後(セッション切れタイミングが早い為)
		proxy:OnKeyTime2( 4033, "OnIrregularLeaveSession_1", 0.1, 0, 1, once );
		--他の再読み込み系イベントの割り込みを防止
	proxy:NotNetMessage_end();
	
	print("OnIrregularLeaveSession end");
end

function OnIrregularLeaveSession_1(proxy,param)
	print("OnIrregularLeaveSession_1 begin");
	--クライアントで無いなら　シングル　or　ホスト
	--if	proxy:IsClient() == false then
	--この時点ではかならずIsClientでfalseが帰る！
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		return;
	end
	if proxy:IsCompleteEvent( 4047 ) == true then
		print("EventFlag4047 is true return");
		return;
	end
	--他の再読み込み系イベントの割り込みを防止
	proxy:SetEventFlag(4047, true);
	--イベント内部にもロード待ちである事を通知
	proxy:SetLoadWait();
	--ルームがなくなったログ
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001001 );
	
	--イベントフラグロールバック
	proxy:SetFlagInitState(2);
	
	proxy:NotNetMessage_begin();
		--■4046■5秒後
		proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 2, once );
	proxy:NotNetMessage_end();
	print("OnIrregularLeaveSession_1 end");
end


----------------------------------------------------------------------------------------------------------------
--■ Warp to 4036 ■ SOS position ■ For white summon position
----------------------------------------------------------------------------------------------------------------
function WarpSosPos(proxy,param)
	print("WarpSosPos begin");
	print("WarpSosPos end");
end

----------------------------------------------------------------------------------------------------------------
--■4037■ミニブロックの頭にワープ■ブラック召喚位置用
----------------------------------------------------------------------------------------------------------------
function WarpMiniblockPos(proxy,param)
	print("WarpMiniblockPos begin");
	--強制召喚の場合、ホストのプレイ領域に合わせる
	if	proxy:IsForceSummoned() == true then
		--proxy:SetHostMiniBlockIndex();
	end
	--proxy:WarpMiniBlock();
	print("WarpMiniblockPos end");
end


function OnServerError_Maintenance(proxy,param)
	print("OnServerError_Maintenance begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end	
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBufferPlus(51200,MSG_CATEGORY_DIALOG);
	--タイトルに戻る処理
	proxy:WARN("デモンズサーバメンテナンス中");
	RegistReturnTitle(proxy,param);
	print("OnServerError_Maintenance end");
end

function OnServerError_ServiceStop(proxy,param)
	print("OnServerError_ServiceStop begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBufferPlus(51201,MSG_CATEGORY_DIALOG);
	--タイトルに戻る処理
	proxy:WARN("デモンズサーバのサービス期間外");
	RegistReturnTitle(proxy,param);
	print("OnServerError_ServiceStop end");
end

function OnServerError_TimeOut(proxy,param)
	print("OnServerError_TimeOut begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBufferPlus(51300,MSG_CATEGORY_DIALOG);
	--タイトルに戻る処理
	proxy:WARN("サーバからの応答が無い");
	RegistReturnTitle(proxy,param);
	print("OnServerError_TimeOut end");
end

function OnSummonResult_Empty(proxy,param)
	print("OnResultEmpty begin");
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBuffer(20000105);
	print("OnResultEmpty end");
end

function OnSummonResult_Move(proxy,param)
	print("OnSummonResult_Move begin");
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBuffer(20000110);
	print("OnSummonResult_Move end");
end

function OnSummonResult_TimeOut(proxy,param)
	print("OnSummonResult_TimeOut begin");
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBuffer(20000100);
	print("OnSummonResult_TimeOut end");
end

function OnSummonResult_OtherError(proxy,param)
	--no handling
end

----------------------------------------------------------------------------------------------------------------
--■ 4038 ■ Session information monitoring ■
----------------------------------------------------------------------------------------------------------------
function OnEvent_4038(proxy,param)
	print("OnEvent_4038 begin");
	local info = param:GetParam2();
	
	--SummonResult関連
--~ 	if info == 1 then--既に召喚されている
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBuffer(20000105);
--~ 	elseif info == 2 then--別ブロックに移動している
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBuffer(20000110);
--~ 	elseif info == 3 then--タイムアウトしている
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBuffer(20000100);
--~ 	--elseif info == 4 then--その他で失敗	
--~ 	end
	
	--NetworkError関連
--~ 	if info == 11 then--デモンズサーバメンテナンス中
--~ 		if proxy:IsCompleteEvent( 4047 ) == true then
--~ 			return;
--~ 		end	
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBufferPlus(51200,MSG_CATEGORY_DIALOG);
--~ 		--タイトルに戻る処理
--~ 		proxy:WARN("デモンズサーバメンテナンス中");
--~ 		RegistReturnTitle(proxy,param);
--~ 	elseif info == 12 then--デモンズサーバのサービス期間外
--~ 		if proxy:IsCompleteEvent( 4047 ) == true then
--~ 			return;
--~ 		end
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBufferPlus(51201,MSG_CATEGORY_DIALOG);
--~ 		--タイトルに戻る処理
--~ 		proxy:WARN("デモンズサーバのサービス期間外");
--~ 		RegistReturnTitle(proxy,param);
--~ 	elseif info == 13 then--サーバからの応答が無い（一定回数以上連続でタイムアウト発生）
--~ 		if proxy:IsCompleteEvent( 4047 ) == true then
--~ 			return;
--~ 		end
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBufferPlus(51300,MSG_CATEGORY_DIALOG);
--~ 		--タイトルに戻る処理
--~ 		proxy:WARN("サーバからの応答が無い");
--~ 		RegistReturnTitle(proxy,param);
--~ 	end
	
	--ForceSummonResult関連
	if	info == 20 then--成功
		ForceSummonSuccess(proxy,param);
	elseif	info == 21 then--no SOS
		ForceSummonFail(proxy,param);
	elseif	info == 22 then--Move to another block
		ForceSummonFail(proxy,param);
	elseif	info == 23 then--time out
		ForceSummonFail(proxy,param);
	elseif	info == 24 then--failed in other
		ForceSummonFail(proxy,param);
	end
	
	print("OnEvent_4038 end");
end


--Forced summoning failed
function ForceSummonFail(proxy,param)
	print("ForceSummonFail begin");
	if	proxy:IsClient() == false then
		OnEvent_1090(proxy,param);
	end
	
	proxy:DeleteEvent( 1090 );
	proxy:SetEventFlag( 1090, true );
	
	print("ForceSummonFail end");
end

--Compulsory summoning succeeded
function ForceSummonSuccess(proxy,param)
	print("ForceSummonSuccess begin");
	print("ForceSummonSuccess end");
end

----------------------------------------------------------------------------------------------------------------
--■4050■Block Clear 2■Regular Version
----------------------------------------------------------------------------------------------------------------
function BlockClear2(proxy,param)	
	--Only Me
	if param:IsNetMessage() == true then
		return;
	end
	--Clear does not come to forced summons
	if	proxy:GetTempSummonParam() >   0 then
		return;
	end
--~ 	if proxy:IsCompleteEvent( 4047 ) == true then
--~ 		return;
--~ 	end
--~ 	if proxy:IsCompleteEvent( 4000 ) == true then
--~ 		return;		
--~ 	end
	print("BlockClear2 begin");	
	ClearBossId = -900;
	
	--Survival or Gray Invincible if neither is applicable
	--if proxy:IsLivePlayer() == false and proxy:IsGreyGhost() == false then
		--完全無敵設定(配信必要だろうか？)
		--proxy:EnableInvincible( 10000,true);
	--end
	
	--Call handler for white resuscitation count, QWC addition (for host)
	if	proxy:IsWhiteGhost() == true then
		proxy:LuaCallStart( 4055, 1 );
	end
	
	--Clear SOS sign once
	--proxy:ClearSosSign();
	
	--Remember number of sessions
	--proxy:SetClearSesiionCount();
	
	--Clear Boss Gauge
	proxy:ClearBossGauge();	

	--Network Lock
	--proxy:LockSession();
	
	--Calculate Clear Bonus
	proxy:SetClearBonus(ClearBossId);
	
	--At the time of survival
	if proxy:IsLivePlayer() == true then		
		proxy:SetTextEffect(TEXT_TYPE_KillDemon);		
		--Prevents interrupts of other reload events
		proxy:SetEventFlag(4047, true);		
		--Prevent deaths from getting stuck and complicated
		proxy:SetEventFlag( 4000, true );
	--Gray Time
	elseif proxy:IsGreyGhost() == true then		
		proxy:SetTextEffect(TEXT_TYPE_KillDemon);
		proxy:SetTextEffect(TEXT_TYPE_Revival);
		proxy:SetReviveWait( true );--Put a waiting state flag (in case it is removed in gray)
		--Prevents interrupts of other reload events
		proxy:SetEventFlag(4047, true);		
		--Prevent deaths from getting stuck and complicated
		proxy:SetEventFlag( 4000, true );
		--When you die here in Grey, you can come back to life
		proxy:SetEventFlag( 4067, true );
	--White Ghost Time
	--This may be what dictates if you can summon after boss
	elseif proxy:IsWhiteGhost() == true then
		ClearBoss = true;
		proxy:SetTextEffect(TEXT_TYPE_KillDemon);		
		--Prevents interrupts of other reload events
		proxy:SetEventFlag(4047, true);
		--Notify the event that it is waiting to be loaded
		proxy:SetLoadWait();		
		--Prevent deaths from getting stuck and complicated
		proxy:SetEventFlag( 4000, true );
	--ブラックゴースト時
	elseif proxy:IsBlackGhost() == true then
		--Stream your Player ID to notify you that you will leave the game
		proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
		--Goal failure
		MissionFailed(proxy,param);		
		--Prevents interrupts of other reload events
		proxy:SetEventFlag(4047, true);
		--Notify the event that it is waiting to be loaded
		proxy:SetLoadWait();		
		--Prevent deaths from getting stuck and complicated
		proxy:SetEventFlag( 4000, true );
		--Black is included in the evaluation, so get out first
		proxy:LeaveSession();
	end

	--セレクトメニュー抑制開始
	if proxy:IsInParty_FriendMember() == true then
		proxy:SetSubMenuBrake( true );		
	end
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4050, "BlockClear2_1", 5.0, 0, 2, once );
	proxy:NotNetMessage_end();
	
	--Self-World Animation Processing	
	if proxy:IsWhiteGhost() == true or proxy:IsBlackGhost() == true then
		proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				--Self-character monitoring for anime playback
				proxy:OnRegistFunc( 4050 , "Check_BlockClearAnim","BlockClearAnim",20,once);
			proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();		
	end
	
	print("BlockClear2 end");
end
--This is the revival process--
function BlockClear2_1(proxy,param)
	print("BlockClear2_1 begin");
	
	if proxy:IsInParty_FriendMember() == true then
		--When Alive or --White Ghost or--When Grey Ghost
		if proxy:IsLivePlayer() == true or proxy:IsWhiteGhost() == true or proxy:IsGreyGhost() == true then		
			--And only when the Grey Ghost
			if proxy:IsGreyGhost() == true then
				if proxy:IsAlive(10000) == true then
					--Happy Resurrection
					proxy:RevivePlayer();
					proxy:SetReviveWait( false );--Flag pending revival
				end
				proxy:SetEventFlag( 15112,true );
				proxy:SetEventFlag( 15113,true );
				proxy:SetEventFlag( 15114,true );
				proxy:SetEventFlag( 15115,true );
				
				proxy:SetEventFlag( 15116,true );
				proxy:SetEventFlag( 15117,true );
				proxy:SetEventFlag( 15118,true );
				proxy:SetEventFlag( 15119,true );	
				--Since it will be restored, the parameters reduced by the penalty will be restored (only the maximum value)
				proxy:EraseEventSpecialEffect( 10000, 101 );
			end
			--Was there a friendly ghost in the room? --White should be fine because she's there.
			--The host should be the result of examining other members, so when you are in a PT with only black, you will be ignored
			--Evaluation menu
			proxy:NotNetMessage_begin();
			proxy:RepeatMessage_begin();
				
				proxy:OnPlayerAssessMenu(4050,ClearBossId,"BlockClear2_2",once);
			proxy:RepeatMessage_end();
			proxy:NotNetMessage_end();			
		--ブラックゴースト時
		elseif proxy:IsBlackGhost() == true then
			--soul penalty
			proxy:DeathPenalty( DeathPenalty_SoulAdjust, DeathPenalty_SoulMAX );
			--eventflag rollback
			proxy:SetFlagInitState(2);
			--Position setting before summoning
			proxy:SetSummonedPos();			
			--Set the same ID as the current map as the next map ID
			proxy:SetDefaultMapUid(-1);
			--do warp
			proxy:WarpNextStageKick();
			--gray ghost
			--proxy:SetChrTypeDataGrey();
			proxy:SetChrTypeDataGreyNext();
		end		
	else
		if proxy:IsLivePlayer() == true then
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 4050, "SoloBlockClear", 3.0, 0, 6, once );
			proxy:NotNetMessage_end();			
		--グレイ時
		elseif proxy:IsGreyGhost() == true then
			if proxy:IsAlive( 10000 ) == true then
				--めでたく復活
				proxy:RevivePlayer();
				proxy:SetReviveWait( false );--復活待ち状態フラグを下ろしておく
			end
			proxy:SetEventFlag( 15112,true );
			proxy:SetEventFlag( 15113,true );
			proxy:SetEventFlag( 15114,true );
			proxy:SetEventFlag( 15115,true );
			
			proxy:SetEventFlag( 15116,true );
			proxy:SetEventFlag( 15117,true );
			proxy:SetEventFlag( 15118,true );
			proxy:SetEventFlag( 15119,true );
			
			--復活するのでペナルティで減少したパラメータを元に戻す(最大値のみ)
			proxy:EraseEventSpecialEffect( 10000, 101 );
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 4050, "SoloBlockClear", 6.0, 0, 6, once );
			proxy:NotNetMessage_end();					
		--ホワイトゴースト時
		elseif proxy:IsWhiteGhost() == true then
			--偽ボーナスの取得
			proxy:GetClearBonus(ClearBossId);
			--世界に帰る
			proxy:NotNetMessage_begin();		
				proxy:OnKeyTime2(4050,"BlockClear2_3",CLEAR_TIMEOUT,0,0,once);
			proxy:NotNetMessage_end();
		--ブラックゴースト時
		elseif proxy:IsBlackGhost() == true then
			--ソウルペナルティ
			proxy:DeathPenalty( DeathPenalty_SoulAdjust, DeathPenalty_SoulMAX );			
			--イベントフラグロールバック
			proxy:SetFlagInitState(2);			
			--召喚前の位置設定
			proxy:SetSummonedPos();			
			--現在のマップと同じIDを次マップIDとして設定
			proxy:SetDefaultMapUid(-1);			
			--ワープを行う
			proxy:WarpNextStageKick();			
			--グレイゴースト化
			--proxy:SetChrTypeDataGrey();
			proxy:SetChrTypeDataGreyNext();
		end
	end
	print("BlockClear2_1 end");
end

--プレイヤー評価メニュー終了のウェイト
function BlockClear2_2(proxy,param)
	print("BlockClear2_2 begin");
	if proxy:IsWhiteGhost() == true then
		--自分のプレイヤーIDを配信してゲーム的に抜ける事を通知
		proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
	end
		
	--完全無敵を排除
	--proxy:EnableInvincible(10000,false);
	proxy:NotNetMessage_begin();		
		proxy:OnKeyTime2(4050,"BlockClear2_3",CLEAR_TIMEOUT,0,0,once);
		proxy:OnKeyTime2(4050,"BlockClear2_3Leave",2.0,0,3,once);
	proxy:NotNetMessage_end();
	
	MissionSuccessed(proxy,param);
	print("BlockClear2_2 end");
end

--Dissolution processing
function BlockClear2_3Leave(proxy,param)
	print("BlockClear2_3Leave begin");
		proxy:LeaveSession();		
	print("BlockClear2_3Leave end");
end

--The process of returning to one's own world
function BlockClear2_3(proxy,param)
	--メニュー抑制解除
	proxy:SetSubMenuBrake( false );
	
	--生存時
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then	
		--Start interrupting other reload events
		proxy:SetEventFlag(4047, false);		
		--死亡可能
		proxy:SetEventFlag( 4000, false );
		if proxy:IsAlive(10000) == true then
			proxy:SetEventFlag( 4067, false );
		end
	end
	
	if proxy:IsWhiteGhost() == true then	
		--復活するので復活アニメフラグをセット
		proxy:SetAliveMotion( true );
	
		--イベントフラグロールバック
		proxy:SetFlagInitState(2);	
		
		--復活するのでペナルティで減少したパラメータを元に戻す(最大値のみ)
		proxy:EraseEventSpecialEffect( 10000, 101 );
		
		--完全回復要求
		proxy:RequestFullRecover();
		
		--生存状態に設定した上で、自分の血文字位置へワープ
		--proxy:WarpSelfBloodMark(false);
		proxy:SetSelfBloodMapUid();
		--proxy:RevivePlayer();
		proxy:RevivePlayerNext();--次のロードで蘇生
		proxy:WarpNextStageKick();
	end
	
end

function SoloBlockClear(proxy,param)
	print("SoloBlockClear begin");
	--万が一評価メニューを出す前にルーム解体した時用
	proxy:SetSubMenuBrake( false );
	proxy:GetSoloClearBonus(ClearBossId);
		
	--他の再読み込み系イベントの割り込みを開始
	proxy:SetEventFlag(4047, false);		
	--死亡可能
	proxy:SetEventFlag( 4000, false );	
	if proxy:IsAlive(10000) == true then
		proxy:SetEventFlag( 4067, false );
	end
	--念の為ルーム解体
	proxy:LeaveSession();
	print("SoloBlockClear end");
end


--■4050■アニメ再生待ち■
function Check_BlockClearAnim(proxy,param)
	--イベントアニメ再生中か？
	if proxy:IsEventAnim(10000,8289) == false then
		--自キャラのアニメ再生に挑戦
		proxy:PlayAnimation(10000,8289);
		return false;
	else
		--イベントアニメ再生中なので、成立とする
		return true;
	end
end

--■ 4050 ■ Block clear animation ■
function BlockClearAnim(proxy,param)
	print("BlockClearAnim begin");
	--自世界アニメの同期
	proxy:LuaCallStart(4050,20);
	--proxy:StopPlayer();
	print("BlockClearAnim end");
end

--■4050■ブロッククリア同期アニメ■
function BlockClearSynchroAnime(proxy,param)
	print("BlockClearSynchroAnime begin");
	if param:IsNetMessage() == true then
		proxy:PlayAnimation(param:GetPlayID()+10001 , 8289);--アニメ再生
		proxy:EnableLogic(param:GetPlayID()+10001,false);--操作不能
		return;
	end
	
	--[[--自世界アニメ再生部分は特殊なので、自キャラの再生分は保留とする]]
	--自キャラはアニメ監視を追加する
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnChrAnimEnd( 4050 , 10000 , 8289 , "BlockClearAnim_1",once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("BlockClearSynchroAnime end");
end

--■4050■アニメ監視■
function BlockClearAnim_1(proxy,param)
	print("BlockClearAnim_1 begin");
	--無効化の同期
	proxy:LuaCallStart(4050,30);
	print("BlockClearAnim_1 end");
end

--■4050■無効化同期■
function BlockClearSynchroInvalid(proxy,param)
	print("BlockClearSynchroInvalid begin");
	if param:IsNetMessage() == true then
		--ネットワークIDで無効化
		InvalidCharactor( proxy , param:GetPlayID() + 10001 );
		return;
	else
		--自キャラ無効化
		--InvalidCharactor( proxy , 10000 );
		--表示OFF
		proxy:SetDrawEnable( 10000 , false );
	end
	
	print("BlockClearSynchroInvalid end");
end







--■4001■アクション中断■
function OnEvent_4001(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	--print("OnEvent_4001 begin");
	--アクションを中断する（初期化）
	proxy:ActionEnd(10000);
	--print("OnEvent_4001 end");
end


--■4002■垂直梯子中　上入力■
function OnEvent_4002(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	--print("OnEvent_4002 begin");

	if proxy:IsAction(10000,0) == false then
	--イベントコマンドID(2)"ハシゴ昇った"を送る
		proxy:SetEventCommand(10000,2);

	else
	--イベントコマンドID(2)"ハシゴ昇り終えた"を送る
		proxy:SetEventCommand(10000,4);

	end
--print("OnEvent_4002 end");
end

--■4003■垂直梯子中　下入力■
function OnEvent_4003(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	--print("OnEvent_4003 begin");

	if proxy:IsAction(10000,1) == false then
	--イベントコマンドID(2)"ハシゴ降りた"を送る
		proxy:SetEventCommand(10000,3);

	else

	--イベントコマンドID(2)"ハシゴ降り終えた"を送る
		proxy:SetEventCommand(10000,5);
	end
	--print("OnEvent_4003 end");
end

--■4006■ハシゴ中 アクションボタン入力■
function OnEvent_4006(proxy,param)
	print("OnEvent_4006 begin");
	print("OnEvent_4006 end");
end


--■4004■垂直梯子　1段上昇終了■
function OnEvent_4004(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4004 begin");
	--アクションカウントを加算、行動回数オーバー時は"ハシゴ昇り終えた"を送る
	proxy:AddActionCount(10000,4);
	--	proxy:CamReset(10000,1);
	print("OnEvent_4004 end");
end

--■4005■垂直梯子　1段下降終了■
function OnEvent_4005(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4005 begin");
	--アクションカウントを減算、行動回数を下回った時は"ハシゴ下り終えた"を送る
	proxy:SubActionCount(10000,5);
	--	proxy:CamReset(10000,1);
	print("OnEvent_4005 end");
end

--■ID不問■メニューの表示を抑制する：sec関数で制御される■
function EventMenuBrake(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	--メニューを閉じる
	--print("Call EventMenuClose");
	proxy:CloseMenu();
	--メニュー抑制を呼ぶ
	--print("Call EventMenuBrake");
	proxy:SetMenuBrake();
end

--■ID不問■メニュー強制終了■
function EventMenuClose(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	--print("Call EventMenuClose");
	--メニューを閉じる
	proxy:CloseMenu();
end

--■ID不問■ハシゴ降り用秒間イベント※現状3秒呼ぶこと
function LadderDown(proxy,param)
	--print("Event_LadderDown begin");
	proxy:CloseMenu();
	proxy:SetMenuBrake();
	--proxy:CamReset(10000,1);
	--print("Event_LadderDown end");
end


--■汎用会話用共通ID■汎用会話を登録する記述量を減らす(結局ハンドラ分は増える)
function OnTalk(proxy,EventID,TargetID,Dist,Ang,ValueBuffer,HelpID,func1,func2,func3,bOnce)

	--■EventID■NPC汎用会話■--PCがイベントIDからDistの距離に入っている時	
	proxy:OnTalkEventDistIn(EventID,TargetID,func2,Dist,bOnce );
	
	--■EventID■NPC汎用会話■--PCがイベントIDからDistの距離に入った後出たとき	
	proxy:OnTalkEventDistOut(EventID,TargetID,func3,Dist,bOnce );
	
	--■EventID■NPC汎用会話■--PCがイベントIDからDistに入って反応角度以内でアクションボタンを押した時	
	proxy:OnTalkEvent(EventID,TargetID,func1, Dist, HelpID, Ang ,ValueBuffer,bOnce );
end

function OnUpDate(proxy,nEventID,nEventID2,nRegionID,func,func1)
	proxy:OnRegionIn(nEventID,10000,nRegionID,func,everytime);
	proxy:OnRegionJustOut(nEventID2,10000,nRegionID,func1,everytime);
end


function SetDisable(proxy,nChrID,bFlag)
	proxy:ChrDisableUpDate(nChrID,bFlag);	
end


--■Lua定義関数■同期されたアニメーション再生■
--値を別に定義したくなかったので、
--true : パーティーのプレイヤーがアニメーションした
--false: 自分がアニメーションした と定義。
function Luafunc_PlaySynchroAnimation(proxy,param,nAnimeID)
	print("Luafunc_PlaySynchroAnimation begin");
	
	--パーティーのプレイヤーがアニメーション
	if param:IsNetMessage() == true then 
		proxy:PlayAnimation( param:GetPlayID()+10001 , nAnimeID );
		print("Luafunc_PlaySynchroAnimation return true");
		return true;
	end
	--自分がアニメーション
	proxy:PlayAnimation( 10000 , nAnimeID );
	print("Luafunc_PlaySynchroAnimation return false");
	return false;
end


--■4010■アニメーションの同期用関数(宝死体用)■
function OnEvent_4010(proxy , param )
	print("OnEvent_4010 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then
		print("return true ");
		print("OnEvent_4010 end");
		return true;
	end
	
	print("return false ");
	print("OnEvent_4010 end");
	return false;
end


--■4012■アニメーションの同期用関数■
function OnEvent_4012(proxy , param )
	print("OnEvent_4012 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		return;
	end
	
	print("OnEvent_4012 end" );
end

--■4013■アニメーションの同期用関数■
function OnEvent_4013(proxy,param)
	print("OnEvent_4013 begin");
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, param:GetParam3() ) == true then
		print("return true ");
		print("OnEvent_4013 end");
		return true;
	end
	
	print("return false ");
	print("OnEvent_4013 end");
	return false;
end

--■4013■同期アニメ再生■
--(注意：これを使用すると、1つのアニメ再生にパケット1つ分の負担になるので、
--短期間で何度も呼ばれるような場所では使用を控える)
--それなりの回数呼ばれることを想定してログはきっておく
function SynchroAnim_4013(proxy,param)
	print("SynchroAnim_4013 begin");
	local targetId = param:GetParam2();
	local animId   = param:GetParam3();
	print("Target :",targetId," animId :",animId);
	--プレイヤなら
	if	targetId >= LOCAL_PLAYER then
		Luafunc_PlaySynchroAnimation( proxy, param, animId );
	else
		proxy:PlayAnimation( targetId, animId );
	end
	--print("SynchroAnim_4013 end");
end


--[[
--------------------------------------------------------------------------------------
--壁はりつきイベント■
--------------------------------------------------------------------------------------

--■4020■壁張り付き　右入力■
function OnEvent_4020(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4020 begin");

	if proxy:IsAction(10000,0) == false then
	--イベントコマンドID(22)"右に1歩進んだ"を送る
		proxy:SetEventCommand(10000,22);

	else
	--イベントコマンドID(24)"右に渡り終えた"を送る
		proxy:SetEventCommand(10000,24);

	end
print("OnEvent_4020 end");
end

--■4021■壁張り付き 左入力■
function OnEvent_4021(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4021 begin");

	if proxy:IsAction(10000,1) == false then
	--イベントコマンドID(23)"左に進んだ"を送る
		proxy:SetEventCommand(10000,23);

	else

	--イベントコマンドID(25)"左に渡り終えた"を送る
		proxy:SetEventCommand(10000,25);
	end
	print("OnEvent_4021 end");
end

--■4022■壁張り付き　右一歩移動終了■
function OnEvent_4022(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4022 begin");
	--アクションカウントを加算、行動回数オーバー時は"右に渡り終えた"を送る
	proxy:AddActionCount(10000,24);	
	print("OnEvent_4022 end");
end

--■4023■壁張り付き　左一歩移動終了■
function OnEvent_4023(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4023 begin");
	--アクションカウントを減算、行動回数を下回った時は"左に渡り終えた"を送る
	proxy:SubActionCount(10000,25);	
	print("OnEvent_4023 end");
end
]]


--------------------------------------------------------------------------------------
--■徘徊デーモンの出現制御用
--------------------------------------------------------------------------------------

--▼徘徊デーモンを表示
function LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list)
	print("VisibleTheWanderingDemon begin");
	
	local demon_num = table.getn( demon_id_list );
	local i =0;
	for i=1 , demon_num , 1 do
		ValidCharactor( proxy , demon_id_list[i] );
	end

	print("VisibleTheWanderingDemon end");
end

--▼徘徊デーモンを非表示
function LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list)
	print("InvisibleTheWanderingDemon begin");
	
	local demon_num = table.getn( demon_id_list );
	local i=0;
	for i=1 , demon_num , 1 do
		InvalidCharactor( proxy , demon_id_list[i] );
	end

	print("InvisibleTheWanderingDemon end");
end

--▼徘徊デーモンの表示･非表示判定用(エリア読み込み時の初期化関数で呼ぶ)
function LuaFunc_WanderingDemonJudge( proxy , param , demon_id_list )

	if proxy:GetLocalPlayerChrType() == CHR_TYPE_GreyGhost then 
		LuaFunc_VisibleTheWanderingDemon( proxy, param, demon_id_list );
	else
		LuaFunc_InvisibleTheWanderingDemon( proxy, param, demon_id_list );
	end
	
end


--------------------------------------------------------------------------------------
--■スーパーアーマー有効化/無効化
--------------------------------------------------------------------------------------

--▼スーパーアーマー有効化
function OnEvent_4015(proxy, param)
	local set_id = 10000;
	
	if param:IsNetMessage() == true then
		set_id = 10001 + param:GetPlayID();
	end
	proxy:SetSuperArmor( set_id , true );
end

--▼スーパーアーマー無効化
function OnEvent_4016(proxy, param)
	local set_id = 10000;
	
	if param:IsNetMessage() == true then
		set_id = 10001 + param:GetPlayID();
	end

	proxy:SetSuperArmor( set_id , false );
end


--------------------------------------------------------------------------------------
--■完全無敵 有効化/無効化
--------------------------------------------------------------------------------------

--▼完全無敵有効化
function OnEvent_4017(proxy, param)
	local set_id = 10000;
	
	if param:IsNetMessage() == true then
		set_id = 10001 + param:GetPlayID();
	end
	
	proxy:EnableInvincible( set_id , true );
end

--▼完全無敵無効化
function OnEvent_4018(proxy, param)
	local set_id = 10000;
	
	if param:IsNetMessage() == true then
		set_id = 10001 + param:GetPlayID();
	end

	proxy:EnableInvincible( set_id , false );
end

--------------------------------------------------------------------------------------
--■アタリ同期
--------------------------------------------------------------------------------------
function OnEvent_4019(proxy,param)
	local set_id = 10000;
	
	if param:IsNetMessage() == true then
		set_id = 10001 + param:GetPlayID();
	end
	--マップへの当たり有効化
	proxy:DisableMapHit( set_id , false );
	proxy:SetDisableGravity( set_id , false );
	
	--旋回など有効
	proxy:DisableMove( set_id , false );
end


--[[
	イベント領域への移動関数　…☆MoveRegion	
	proxy		…イベントプロキシ
	targetid	…移動させたいターゲット
	regionid	…領域ID
	ftime		…移動状態にかけたい時間　　-1無制限
	frad		…判定半径					基本0.0でOK
	movetype	…歩きか走りか				trueが歩き
]]
function MoveRegion(proxy, targetid, regionid, ftime ,frad,movetype)
	--AIにイベントポイントを記憶
	proxy:SetMovePoint(targetid,regionid,frad);
	--AIにイベント命令を発行(移動) 
	proxy:AddEventGoal(targetid, GOAL_COMMON_MoveToSomewhere, ftime, POINT_EVENT, AI_DIR_TYPE_CENTER, frad, TARGET_SELF, movetype,0,0,0);	
end

--[[
	イベント領域への移動関数　…☆MoveRegion	
	proxy		…イベントプロキシ
	targetid	…移動させたいターゲット
	regionid	…領域ID
	ftime		…移動状態にかけたい時間　　-1無制限
	frad		…判定半径					基本0.0でOK
	movetype	…歩きか走りか				trueが歩き
]]
function MoveRegion2(proxy, targetid, regionid, ftime ,frad,movetype)
	--AIにイベントポイントを記憶
	proxy:SetMovePoint(targetid,regionid,frad);
	--AIにイベント命令を発行(移動) 
	proxy:AddEventGoal(targetid, GOAL_COMMON_MoveToSomewhere, ftime, POINT_EVENT, AI_DIR_TYPE_CENTER, frad, TARGET_ENE_0, movetype,0,0,0);	
end

--[[
	ターゲット(キャラ)への旋回関数　…☆TurnTarget	
	使用上の注意：イベントターゲットを利用しているので、
	　　　　　　　イベントターゲットがらみのイベントで使う場合、
	　　　　　　　動作が保障できません。
				　その場合はポイント指定のTurn関数を新たにを用意するなど、
				　別の対応を考えた方が良いと思います。
	proxy			…イベントプロキシ
	targetid		…旋回させたいさせたいターゲット(イベントID指定)
	goal_target_id	…旋回したい方向のターゲット(イベントID指定)
	ftime			…移動状態にかけたい時間　　-1無制限
]]
function TurnTarget(proxy, targetid, goal_target_id, ftime )
	--引数の全パラメータを確認できるので、ログで確認したい時はどうぞ
	--print("TurnTarget targetid = ", targetid, ", goal_target_id = ", goal_target_id, ", ftime = ", ftime);
	
	--イベントターゲットを設定
	proxy:SetEventTarget( targetid, goal_target_id );
	--AIにイベントターゲットに振り向くようにイベント命令を発行(旋回)
	proxy:AddEventGoal(targetid, GOAL_COMMON_Turn, ftime, TARGET_EVENT, 0,0,0,0,0,0,0);
end

--[[
	ターゲット(キャラ)への旋回関数　…☆TurnTarget	
	使用上の注意：イベントターゲットを利用しているので、
	　　　　　　　イベントターゲットがらみのイベントで使う場合、
	　　　　　　　動作が保障できません。
				　その場合はポイント指定のTurn関数を新たにを用意するなど、
				　別の対応を考えた方が良いと思います。
	proxy			…イベントプロキシ
	targetid		…旋回させたいさせたいターゲット(イベントID指定)
	goal_target_id	…旋回したい方向のターゲット(イベントID指定)
	ftime			…移動状態にかけたい時間　　-1無制限
]]
function TurnTarget2(proxy, targetid, goal_target_id, ftime )
	--引数の全パラメータを確認できるので、ログで確認したい時はどうぞ
	--print("TurnTarget targetid = ", targetid, ", goal_target_id = ", goal_target_id, ", ftime = ", ftime);
	
	--イベントターゲットを設定
	proxy:SetMovePoint(targetid,goal_target_id,0.0);
	--AIにイベントターゲットに振り向くようにイベント命令を発行(旋回)
	--proxy:AddEventGoal(targetid, GOAL_COMMON_Turn, ftime, TARGET_EVENT, 0,0,0,0,0,0,0);
end

--[[
	指定ターゲットの右手武器を切り替えます
	何度も呼ばないで下さい。正直サツキ専用ですが正常動作するかはわからないです。
]]
function TargetChangeWepR2(proxy,targetid)
	proxy:AddEventGoal(targetid, GOAL_COMMON_Attack, 10.0, NPC_ATK_ChangeWep_R2,TARGET_ENE_0, DIST_None,0,0,0,0,0);
end



--キャラクタ無効化
function InvalidCharactor(proxy, eventId)
	proxy:SetDisable( eventId, true );
	proxy:CharacterAllAttachSys(eventId);
end

--キャラクタ有効化
function ValidCharactor(proxy, eventId)
	proxy:SetDisable( eventId, false );
end

--バックリードキャラクタを無効化
function InvalidBackRead(proxy,eventId)
	proxy:SetDisable( eventId, true );--無効設定
	proxy:SetDisableBackread_forEvent( eventId, true );--バックリード無効化
end

--バックリードキャラクタを有効化
function ValidBackRead(proxy,eventId)
	proxy:SetDisable( eventId, false );--有効設定
	proxy:SetDisableBackread_forEvent( eventId, false );--バックリード有効化
end


--[[インフォメーションメニュー表示用]]
--[[引数全部指定]]
--[[
	proxy 	          … イベントプロクシ
	type  	       	  … 0:通常(複数行) 1:簡易(1行)
	title_icon_id  	  … タイトルメッセージのアイコンID
	title_category_id … タイトルメッセージのカテゴリーID(30がイベント用カテゴリー)
	title_msg_id      … タイトルメッセージのメッセージID
	sys_msg_id        … 0でダイアログ表示
	icon_list         … 行ごとにアイコンを指定する場合に指定(リストで渡されて、最初の一つがデフォルトになる)
	category_list     … メッセージのカテゴリーID(リストで渡されて、最初の一つがデフォルトになる)
	msg_list    　　　… メッセージIDを個別に指定(リストで渡されて、最初の一つがデフォルトになる)
	msg_num           … メッセージの行数(なくても良いかもしれない･･･)
]]

function Display_InfomationMenu
(proxy, type, title_icon_id, title_category_id, title_msg_id, sys_msg_id, icon_list, category_list, msg_list, msg_num)
	print( "Display_InfomationMenu begin" );
	
	--インフォメーションメニュー表示
	proxy:InfomationMenu( type , title_icon_id , title_category_id , title_msg_id , sys_msg_id );
	
	--メッセージなどの数が合わないときはデフォルトの値で代用する
	--(リストには値が１個以上入っていること前提で、１番最初のをデフォルトにする)
	
	local default_icon_id     = icon_list[1];
	local default_category_id = category_list[1];
	local default_msg_id      = msg_list[1];
	
	if type == 0 then -- 通常メニュー
		local i=1;
		for i=1, msg_num, 1 do
		
			--セットする値をデフォルトで初期化
			local set_icon_id     = default_icon_id;
			local set_category_id = default_category_id;
			local set_msg_id      = default_msg_id;
			
			--値がある場合それを使う
			if icon_list[i]     ~= nil then set_icon_id     = icon_list[i];     end
			if category_list[i] ~= nil then set_category_id = category_list[i]; end
			if msg_list[i]      ~= nil then set_msg_id      = msg_list[i];      end
			
			--インフォメーションメニューのリストに追加
			proxy:AddInfomationList( set_icon_id , set_category_id , set_msg_id );
		
		end	
	
	elseif type == 1 then -- 簡易メニュー
		--インフォメーションメニューのリストに追加
		proxy:AddInfomationList( default_icon_id , default_category_id , default_msg_id );
	end

	print( "Display_InfomationMenu end" );
end


--[[インフォメーションメニュー表示用]]
--[[メッセージIDひとついれると連番で勝手に指定]]
--[[
	proxy 	          … イベントプロクシ
	type  	       	  … 0:通常(複数行) 1:簡易(1行)
	title_icon_id  	  … タイトルメッセージのアイコンID
	title_category_id … タイトルメッセージのカテゴリーID(30がイベント用カテゴリー)
	title_msg_id      … タイトルメッセージのメッセージID
	sys_msg_id        … 0でダイアログ表示
	icon_id           … 行ごとにアイコンを指定する場合に指定(この関数ではすべて同じになる)
	category_id       … メッセージのカテゴリーID
	first_msg_id      … メッセージID 最初のひとつを指定するとmsg_num行分が連番で追加される
	msg_num           … メッセージの行数
]]
function Display_InfomationMenu_2
(proxy, type, title_icon_id, title_category_id, title_msg_id, sys_msg_id, icon_id, category_id, first_msg_id, msg_num)
	print( "Display_InfomationMenu begin" );
	proxy:ShowGenDialog(first_msg_id,1,1,true);
	--[[
	--インフォメーションメニュー表示
	proxy:InfomationMenu( type , title_icon_id , title_category_id , title_msg_id , sys_msg_id );
	
	if type == 0 then -- 通常メニュー

		local now_msg_id = first_msg_id;
		local i=1;
		for i=1, msg_num, 1 do
			--インフォメーションメニューのリストに追加
			proxy:AddInfomationList( icon_id , category_id , now_msg_id );
			now_msg_id = now_msg_id + 1;
		end
	
	elseif type == 1 then -- 簡易メニュー
		--インフォメーションメニューのリストに追加
		proxy:AddInfomationList( icon_id , category_id , first_msg_id );
	end
	]]
	print( "Display_InfomationMenu end" );
end



function LengthOut_SosDialog(proxy,param)
	print("LengthOut_SosDialog begin");	
	--インフォメーションメニュー表示		
	print("LengthOut_SosDialog end");
end


--[[
		以下プログラムからコールされるシステムログ
]]
--------------------------------------------------------------------------------------
--■SOS血文字から距離が離れて消えたときのログ
--------------------------------------------------------------------------------------
function LengthOut_SosDialog(proxy,param)
	print("LengthOut_SosDialog begin");	
	--インフォメーションメニュー表示			
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000005 );
	print("LengthOut_SosDialog end");
end


--------------------------------------------------------------------------------------
--■召還成功を通知するログ（ホワイト召還）
--------------------------------------------------------------------------------------
function SummonSuccess_White(proxy,param)
	print("SummonSuccess_White begin");
	--インフォメーションメニュー表示			
	print("SummonSuccess_White end");
end

--------------------------------------------------------------------------------------
--■召還成功を通知するログ（ブラック召還）
--------------------------------------------------------------------------------------
function SummonSuccess_Black(proxy,param)
	print("SummonSuccess_Black begin");
	--インフォメーションメニュー表示			
	print("SummonSuccess_Black end");
end

--------------------------------------------------------------------------------------
--■召還された事を通知するログ（ホワイト召還）
--------------------------------------------------------------------------------------
function OnBeSummoned_White(proxy,param)
	print("OnBeSummoned_White begin");
	
	--ホワイト召喚通知
	--proxy:LuaCallStartPlus( 4041, 1, proxy:GetLocalPlayerId() );
--[[
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4036, "WarpSosPos", 0.1, 0, 2, once );
	proxy:NotNetMessage_end();
]]
	
	print("OnBeSummoned_White end");
end


--------------------------------------------------------------------------------------
--■召還された事を通知するログ（ブラック召還）
--------------------------------------------------------------------------------------
function OnBeSummoned_Black(proxy,param)
	print("OnBeSummoned_Black begin");
	
	--ブラック召喚通知
	--proxy:LuaCallStartPlus( 4041, 2, proxy:GetLocalPlayerId() );
--[[
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4037, "WarpMiniblockPos", 0.1, 0, 2, once );
	proxy:NotNetMessage_end();
]]
	--ホストのプレイ領域からワープ先を設定
	--proxy:LuaCallStart( 4037, 2 );
	
	print("OnBeSummoned_Black end");
end

--------------------------------------------------------------------------------------
--■召還された事を通知するログ（ブラック強制乱入）
--------------------------------------------------------------------------------------
function OnBeSummoned_ForceJoinBlack(proxy,param)
	print("OnBeSummoned_ForceJoinBlack begin");
	
	--ブラック乱入通知
	--proxy:LuaCallStartPlus( 4041, 3, proxy:GetLocalPlayerId() );
	
	print("OnBeSummoned_ForceJoinBlack end");
end

--------------------------------------------------------------------------------------
--■召還された事を通知するログ（ブラック強制召喚<翁でしか使っていない>）
--------------------------------------------------------------------------------------
function OnBeForceSummoned_Black(proxy,param)
	print("OnBeForceSummoned_Black begin");
	
	--ブラック強制召喚通知
	--proxy:LuaCallStartPlus( 4041, 4, proxy:GetLocalPlayerId() );
	
	print("OnBeForceSummoned_Black end");
end



------------------------------------------------------------------------------------
--目標達成
------------------------------------------------------------------------------------
function MissionSuccessed(proxy,param)
	print("MissionSuccessed begin");
	--ホワイト
	if		proxy:GetTempSummonParam() == -1 then
		proxy:RecallMenuEvent( 0, 8933 );
	--ブラック
	elseif	proxy:GetTempSummonParam() == -2 then
		--通常PKの場合生存とグレイの場合で成功処理が変わる
		if proxy:IsPrevGreyGhost() == true then
			proxy:RecallMenuEvent( 0, 8934 );
		else
			proxy:RecallMenuEvent( 0, 8937 );
		end
	--乱入
	elseif	proxy:GetTempSummonParam() == -3 then
		proxy:RecallMenuEvent( 0, 8935 );
	--強制召喚
	elseif	proxy:GetTempSummonParam() >   0 then
		proxy:RecallMenuEvent( 0, 8936 );
	end
	print("MissionSuccessed end");
end


------------------------------------------------------------------------------------
--目標失敗
------------------------------------------------------------------------------------
function MissionFailed(proxy,param)
	print("MissionFailed begin");
	--ホワイト
	if		proxy:GetTempSummonParam() == -1 then
		proxy:RecallMenuEvent( 0, 8943 );
	--ブラック
	elseif	proxy:GetTempSummonParam() == -2 then
		proxy:RecallMenuEvent( 0, 8944 );
	--乱入
	elseif	proxy:GetTempSummonParam() == -3 then
		proxy:RecallMenuEvent( 0, 8945 );
	--強制召喚
	elseif	proxy:GetTempSummonParam() >   0 then
		proxy:RecallMenuEvent( 0, 8946 );
	end
	--完全回復要求
	proxy:RequestFullRecover();
	
	print("MissionFailed end");
end


------------------------------------------------------------------------------------
--死亡による目標失敗
------------------------------------------------------------------------------------
function MissionDeadFailed(proxy,param)
	print("MissionDeadFailed begin");
	--ホワイト
	if		proxy:GetTempSummonParam() == -1 then
		proxy:RecallMenuEvent( 0, 8953 );
	--ブラック
	elseif	proxy:GetTempSummonParam() == -2 then
		proxy:RecallMenuEvent( 0, 8954 );
	--乱入
	elseif	proxy:GetTempSummonParam() == -3 then
		proxy:RecallMenuEvent( 0, 8955 );
	--強制召喚
	elseif	proxy:GetTempSummonParam() >   0 then
		proxy:RecallMenuEvent( 0, 8956 );
	end
	print("MissionDeadFailed end");
end

--------------------------------------------------------------------------------------
--■SOSサインが消えた事を通知するログ(ミニブロック移動時)
--------------------------------------------------------------------------------------
function OnEvent_Delete_SOS(proxy,param)
	print("OnEvent_Delete_SOS begin");	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000000 );
	print("OnEvent_Delete_SOS end");
end
--ホワイトソウルサイン
function OnEvent_Delete_WhiteSOS(proxy,param)
	print("OnEvent_Delete_WhiteSOS begin");	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000000 );
	proxy:SetInfomationPriority(USER_ID_Event_SosLost_White);
	print("OnEvent_Delete_WhiteSOS end");
end
--ブラックソウルサイン
function OnEvent_Delete_BlackSOS(proxy,param)
	print("OnEvent_Delete_BlackSOS begin");	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000001 );
	proxy:SetInfomationPriority(USER_ID_Event_SosLost_Red);
	print("OnEvent_Delete_BlackSOS end");
end
--乱入ソウルサイン
function OnEvent_Delete_ForceJoinSOS(proxy,param)
	print("OnEvent_Delete_ForceJoinSOS begin");	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000002 );
	proxy:SetInfomationPriority(USER_ID_Event_SosLost_Black);
	print("OnEvent_Delete_ForceJoinSOS end");
end

--------------------------------------------------------------------------------------
--■LANが切断された事を通知するログ
--------------------------------------------------------------------------------------
function OnLanCutError(proxy,param)
	print("OnLanCutError begin");
	
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001005 );
	


	proxy:NotNetMessage_begin();
		--[[
		--■4046■5秒後
		proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
				
		--他の再読み込み系イベントの割り込みを防止
		proxy:SetEventFlag(4047, true);
		--イベント内部にもロード待ちである事を通知
		proxy:SetLoadWait();
		]]
		RegistReturnTitle(proxy,param);
		proxy:WARN("OnLanCutError!");
	proxy:NotNetMessage_end();
	
	print("OnLanCutError end");
end


--------------------------------------------------------------------------------------
--■NPサーバからのサインアウトを通知するログ
--------------------------------------------------------------------------------------
function OnNpServerSignOut(proxy,param)
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	print("OnNpServerSignOut begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001010 );
	
	--タイトルに戻る
	proxy:WARN("NpSignOut Error");
	RegistReturnTitle(proxy,param);
	print("OnNpServerSignOut end");
end

--------------------------------------------------------------------------------------
--■P2P接続のタイムアウトを通知するログ
--------------------------------------------------------------------------------------
function OnP2PTimeOut(proxy,param)
	print("OnP2PTimeOut begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001015 );
	if proxy:IsLivePlayer() == false and proxy:IsGreyGhost() == false then
		proxy:NotNetMessage_begin();
			--■4046■5秒後
			proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
			
			--他の再読み込み系イベントの割り込みを防止
			proxy:SetEventFlag(4047, true);
			--イベント内部にもロード待ちである事を通知
			proxy:SetLoadWait();
			
		proxy:NotNetMessage_end();
	end
	print("OnP2PTimeOut end");
end


function OnFailedGetBlockNum(proxy,param)
	print("OnFailedGetBlockNum begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001002 );	
	--タイトルに戻る
	proxy:WARN("OnFailedGetBlockNum Error");
	RegistReturnTitle(proxy,param);
	print("OnFailedGetBlockNum end");
end

--------------------------------------------------------------------------------------
--■4043■参加者がいなくなった（退出、キック、死亡以外）
--------------------------------------------------------------------------------------
function OnLeavePlayer(proxy,param)
	print("OnLeavePlayer begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	
	if proxy:IsCompleteEvent( 4044 ) == true then
		proxy:SetEventFlag( 4044, false );
		return;
	end
	
	--退出、キック、死亡以外が取れないので、一先ずコメントアウト
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTimeMsgTag( 20001020, TAG_IDX_leaveChara, param:GetParam3() );
	if param:GetParam3() == proxy:GetLocalPlayerId() then
		proxy:NotNetMessage_begin();
			--■4046■5秒後
			proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
			
			--他の再読み込み系イベントの割り込みを防止
			proxy:SetEventFlag(4047, true);
			--イベント内部にもロード待ちである事を通知
			proxy:SetLoadWait();
			
		proxy:NotNetMessage_end();
	end
	print("OnLeavePlayer end");
end

--------------------------------------------------------------------------------------
--■ゲーム的退出をした人を通知する
--------------------------------------------------------------------------------------
function OnGameLeave(proxy,param)
	if param:GetParam2() ~= proxy:GetLocalPlayerId() then
		print("OnGameLeave begin");
		local leavePlayer = param:GetParam2();
		print("LeavePlayer :",leavePlayer);
		proxy:ReqularLeavePlayer( leavePlayer );
		print("OnGameLeave begin");
	end
end

--------------------------------------------------------------------------------------
--■キックアウトされたのを通知するログ
--------------------------------------------------------------------------------------
function OnBeKickOut(proxy,param)
	print("OnBeKickOut begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000420 );
	
	--■4046■5秒後
	proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
	--他の再読み込み系イベントの割り込みを防止
	proxy:SetEventFlag(4047, true);
	--イベント内部にもロード待ちである事を通知
	proxy:SetLoadWait();
	
	print("OnBeKickOut end");
end

--------------------------------------------------------------------------------------
--■感謝キックアウトされたのを通知するログ
--------------------------------------------------------------------------------------
function OnBeThxKickOut(proxy,param)
	print("OnBeThxKickOut begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000421 );
	
	--■4046■5秒後
	proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
	--他の再読み込み系イベントの割り込みを防止
	proxy:SetEventFlag(4047, true);
	--イベント内部にもロード待ちである事を通知
	proxy:SetLoadWait();
	
	print("OnBeThxKickOut end");
end


--------------------------------------------------------------------------------------
--■4044■キックアウトしたのを通知するログ
--------------------------------------------------------------------------------------
function OnKickOut(proxy,param)
	print("OnKickOut begin");	
	--キックアウトしたのが自分の時
	if proxy:IsHost() == true then
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );	
		proxy:AddInfomationTosBuffer( 20000415 );
		proxy:SetEventFlag( 4044, true );
	--自分以外の人がキックアウトされた時		
	elseif proxy:GetLocalPlayerId() ~= param:GetParam3() then
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );	
		proxy:AddInfomationTimeMsgTag( 20000425, TAG_IDX_leaveChara, param:GetParam3() );
	end
	print("OnKickOut end");
end

--------------------------------------------------------------------------------------
--■4044■感謝キックアウトしたのを通知するログ
--------------------------------------------------------------------------------------
function OnThxKickOut(proxy,param)
	print("OnThxKickOut begin");	
	--キックアウトしたのが自分の時
	if proxy:IsHost() == true then
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );	
		proxy:AddInfomationTosBuffer( 20000416 );
		proxy:SetEventFlag( 4044, true );
	--自分以外の人がキックアウトされた時
	elseif proxy:GetLocalPlayerId() ~= param:GetParam3() then
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );	
		proxy:AddInfomationTimeMsgTag( 20000425, TAG_IDX_leaveChara, param:GetParam3() );
	end
	print("OnThxKickOut end");
end


--------------------------------------------------------------------------------------
--■退出魔法使用を通知するログ
--------------------------------------------------------------------------------------
function OnLeaveMagic(proxy,param)
	print("OnLeaveMagic begin");
	--他の読み込みの流れに入っていたら、ダイアログすら出さない
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
--[[
	proxy:NotNetMessage_begin();
		--■4046■退出確認メニューでYesを選択
		proxy:OnYesNoDialog( 4046, "OnLeaveMenu_Yes", 20000430, 0, 2, once );
	proxy:NotNetMessage_end();
]]
	--自分のプレイヤーIDを配信してゲーム的に抜ける事を通知
	proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
	OnLeaveMenu_Yes(proxy,param);
	print("OnLeaveMagic end");
end

--------------------------------------------------------------------------------------
--■乱入アイテム使用を通知するログ
--------------------------------------------------------------------------------------
function OnForceJoinBlack(proxy,param)
	print("OnForceJoinBlack begin");
	--他の読み込みの流れに入っていたら、ダイアログすら出さない
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
--[[
	proxy:NotNetMessage_begin();
		--■4039■乱入確認メニューでYesを選択
		proxy:OnYesNoDialog( 4039, "OnForceJoinBlackMenu_Yes", 20000440, 0, 2, once );
	proxy:NotNetMessage_end();
]]
	OnForceJoinBlackMenu_Yes(proxy,param);
	print("OnForceJoinBlack end");
end

--------------------------------------------------------------------------------------
--■4039■乱入確認メニューでYesを選択
--------------------------------------------------------------------------------------
function OnForceJoinBlackMenu_Yes(proxy,param)
	print("OnForceJoinBlackMenu_Yes begin");
	
	--乱入リクエストしても必ず参加できるとは限らないので、4047は立てない(若干不安だけど)
	--強制参加(乱入)をキック
	proxy:SetForceJoinBlackRequest();
	
	print("OnForceJoinBlackMenu_Yes end");
end


--------------------------------------------------------------------------------------
--■乱入が時間切れしたのを通知
--------------------------------------------------------------------------------------
function OnFailedForceJoinBlack(proxy,param)
	print("OnFailedForceJoinBlack begin");
	proxy:RecallMenuEvent(0,8855);
	print("OnFailedForceJoinBlack end");
end


--------------------------------------------------------------------------------------
--■乱入を他のSOSで上書きしたのを通知
--------------------------------------------------------------------------------------
function OnCancelForceJoinBlack(proxy,param)
	print("OnCancelForceJoinBlack begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000002 );
	print("OnCancelForceJoinBlack end");
end

--------------------------------------------------------------------------------------
--■ルーム作成失敗したのを通知
--------------------------------------------------------------------------------------
function OnFailedCreateSession(proxy,param)
	print("OnFailedCreateSession begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001003 );
	print("OnFailedCreateSession end");
end

--------------------------------------------------------------------------------------
--■ルーム参加失敗失敗したのを通知
--------------------------------------------------------------------------------------
function OnFailedJoinSession(proxy,param)
	print("OnFailedJoinSession begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001004 );
	print("OnFailedJoinSession end");
end

--------------------------------------------------------------------------------------
--■ロード前にキックしたのを通知
--------------------------------------------------------------------------------------
function OnJoinClearedRoom(proxy,param)
	print("OnJoinClearedRoom begin");
	proxy:RecallMenuEvent(0,8870);
	print("OnJoinClearedRoom end");
end

--------------------------------------------------------------------------------------
--■ブラックがキックされたのをEvent側に通知
--------------------------------------------------------------------------------------
function OnBeBlackKickOut(proxy,param)
	print("OnBeBlackKickOut begin");
	
	--ホワイトも呼ばれるので先にはじいておく
	if proxy:IsWhiteGhost() == true then
		return;
	end
	
	--自分のプレイヤーIDを配信してゲーム的に抜ける事を通知
	proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );

	proxy:LeaveSession();
	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000450 );
	
	proxy:NotNetMessage_begin();
		--■4046■5秒後
		proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
		--他の再読み込み系イベントの割り込みを防止
		proxy:SetEventFlag(4047, true);
		--イベント内部にもロード待ちである事を通知
		proxy:SetLoadWait();
		
	proxy:NotNetMessage_end();
	
	print("OnBeBlackKickOut end");
end

--------------------------------------------------------------------------------------
--■石柱にワープ（奇跡：ゲート）をEvent側に通知
--------------------------------------------------------------------------------------
function OnGateEnchant(proxy,param)
	print("OnGateEnchant begin");
	
	--完全回復要求
	proxy:RequestFullRecover();
	--召喚要求キャンセル
	proxy:ResetSummonParam();
	proxy:WarpNextStage( 1, 0, 0, 0, -1 );
	
	print("OnGateEnchant end");
end


--ルームのタイムアウト
function OnRoomTimeOut(proxy,param)
	print("OnRoomTimeOut begin");	
	print("OnRoomTimeOut end");
end

--召喚のタイムアウト
function OnSummonTimeOut(proxy,param)
	print("OnSummonTimeOut begin");	
	print("OnSummonTimeOut end");
end


--召喚されてロード直前、マルチ参加開始　in the (ホワイトソウル) 
function OnBeJoinStart_White(proxy,param)
	if proxy:IsAlive(10000) == true then
		print("OnBeJoinStart_White begin");
		proxy:RecallMenuEvent( 0, 8823 );
		proxy:NotNetMessage_begin();
		proxy:OnRequestMenuEnd( 4059, "SummonReloadStart");
		proxy:NotNetMessage_end();
		print("OnBeJoinStart_White end");
	else
		--念の為リーブ
		proxy:LeaveSession();
		proxy:ResetSummonParam();
		proxy:WARN("OnBeJoinStart_White 既に死んでる");
	end
end

--召喚されてロード直前、マルチ参加開始　in the (ブラックソウル) 
function OnBeJoinStart_Black(proxy,param)
	if proxy:IsAlive( 10000 ) == true then
		print("OnBeJoinStart_Black begin");
		proxy:RecallMenuEvent( 0, 8824 );
		proxy:NotNetMessage_begin();
		proxy:OnRequestMenuEnd( 4059, "SummonReloadStart");
		proxy:NotNetMessage_end();
		print("OnBeJoinStart_Black end");
	else
		--念の為リーブ
		proxy:LeaveSession();
		proxy:ResetSummonParam();
		proxy:WARN("OnBeJoinStart_Black 既に死んでる");
	end
end

--召喚されてロード直前、マルチ参加開始　in the (乱入) 
function OnBeJoinStart_ForceJoin(proxy,param)
	if proxy:IsAlive(10000) == true then	
		print("OnBeJoinStart_ForceJoin begin");
		proxy:RecallMenuEvent( 0, 8825 );
		proxy:NotNetMessage_begin();
		proxy:OnRequestMenuEnd( 4059, "SummonReloadStart");
		proxy:NotNetMessage_end();
		print("OnBeJoinStart_ForceJoin end");
	else
		--念の為リーブ
		proxy:LeaveSession();
		proxy:ResetSummonParam();
		proxy:WARN("OnBeJoinStart_ForceJoin 既に死んでる");
	end	
end

--召喚されてロード直前、マルチ参加開始　in the (強制召喚) 
function OnBeJoinStart_ForceSummon(proxy,param)
	if proxy:IsAlive( 10000 ) == true then
		print("OnBeJoinStart_ForceSummon begin");
		proxy:RecallMenuEvent( 0, 8826 );
		proxy:NotNetMessage_begin();
		proxy:OnRequestMenuEnd( 4059, "ForceSummonReloadStart");
		proxy:NotNetMessage_end();
		print("OnBeJoinStart_ForceSummon end");
	else
		--念の為リーブ
		proxy:LeaveSession();
		proxy:ResetSummonParam();
		proxy:WARN("OnBeJoinStart_ForceSummon 既に死んでる");
	end
end

--召喚されたことによる再読み込みをキック
function SummonReloadStart(proxy,param)
	print("SummonReloadStart begin");
	--ルームが存在したら入る
	if	proxy:IsInParty() == true then
		--生きていたら
		if proxy:IsAlive(10000)  == true then
			proxy:SummonedMapReload();
		else
			--念の為リーブ
			proxy:LeaveSession();
			proxy:ResetSummonParam();
			proxy:WARN("SummonReloadStart ルーム有り死んでる");
		end
	else
		if proxy:IsAlive(10000)  == false then
			proxy:ResetSummonParam();
			proxy:WARN("SummonReloadStart ルーム無し死んでる");
		end
	end
	print("SummonReloadStart end");
end

--召喚されたことによる再読み込みをキック(強制召還用)
function ForceSummonReloadStart(proxy,param)
	print("ForceSummonReloadStart begin");
	--ルームが存在したら入る
	if	proxy:IsInParty() == true then
		if proxy:IsAlive(10000) == true then
			--完全回復要求
			proxy:RequestFullRecover();
			proxy:SummonedMapReload();
		else
			--念の為リーブ
			proxy:LeaveSession();
			proxy:ResetSummonParam();
			proxy:WARN("ForceSummonReloadStart ルーム有り死んでる");
		end
	else
		if proxy:IsAlive(10000) == false then
			proxy:ResetSummonParam();
			proxy:WARN("ForceSummonReloadStart ルーム無し死んでる");
		end
	end
	print("ForceSummonReloadStart end");
end


--マルチプレイに参加した時のメッセージ
function OnJoinMutiplay(proxy,param)
	print("OnJoinMutiplay begin");	
	print("OnJoinMutiplay end");
end

-------------------------------------------------------------------------------------
--セッションに参加した時のメッセージ
-------------------------------------------------------------------------------------
--ホワイトソウル
function JoinSession_White(proxy,param)
	print("JoinSession_White begin");
	proxy:RecallMenuEvent( 0, 8813 );
	print("JoinSession_White end");
end

--ブラックソウル
function JoinSession_Black(proxy,param)
	print("JoinSession_Black begin");
	proxy:RecallMenuEvent( 0, 8814 );
	print("JoinSession_Black end");
end

--乱入
function JoinSession_ForceJoin(proxy,param)
	print("JoinSession_ForceJoin begin");
	proxy:RecallMenuEvent( 0, 8815 );
	print("JoinSession_ForceJoin end");
end

--強制召喚
function JoinSession_ForceSummon(proxy,param)
	print("JoinSession_ForceSummon begin");
	proxy:RecallMenuEvent( 0, 8816 );
	print("JoinSession_ForceSummon end");
end



function JoinSession(proxy,param)
	print("JoinSession begin");	
	--ホワイトソウル
	if proxy:GetTempSummonParam() == -1 then
		proxy:RecallMenuEvent( 0, 8813 );
	--ブラックソウル
	elseif proxy:GetTempSummonParam() == -2 then
		proxy:RecallMenuEvent( 0, 8814 );
	end
	print("JoinSession end");
end

--セッションに強制参加した時のメッセージ
function ForceJoinSession(proxy,param)
	print("ForceJoinSession begin");	
	proxy:RecallMenuEvent( 0, 8815 );
	print("ForceJoinSession end");
end

---------------------------------------------------------------------------------------------------------
--■4058■召喚中配信
---------------------------------------------------------------------------------------------------------
--4058▼▼▼召喚中配信▼▼▼--
function OnEvent_Call_SOS(proxy,param)
	print("OnEvent_Call_SOS begin");
	proxy:LuaCallStartPlus(4058, 1, proxy:GetLocalPlayerId());
	print("OnEvent_Call_SOS end");
end

function OnEvent_Call_BlackSOS(proxy,param)
	print("OnEvent_Call_BlackSOS begin");
	proxy:LuaCallStartPlus(4058, 2, proxy:GetLocalPlayerId());
	print("OnEvent_Call_BlackSOS end");
end

--ホワイトソウルサインを召喚(SOSメニューでOKを押したタイミング)
--(4058, 1, playerId)
function Call_WhiteSos(proxy,param)
	print("Call_WhiteSos begin");
	proxy:RecallMenuEvent( 0, 8810 );
	print("Call_WhiteSos end");
end

--ブラックソウルサインを召喚(SOSメニューでOKを押したタイミング)
--(4058, 2, playerId)
function Call_BlackSos(proxy,param)
	print("Call_BlackSos begin");
	proxy:RecallMenuEvent( 0, 8811 );
	print("Call_BlackSos end");
end
--4058▲▲▲召喚中配信▲▲▲--





--ホワイトソウルサインを出した
function OnEvent_SendSoulSign_White(proxy,param)
	print("OnEvent_SendSoulSign_White begin");
	print("OnEvent_SendSoulSign_White end");
end

--ブラックソウルサインを出した
function OnEvent_SendSoulSign_Black(proxy,param)
	print("OnEvent_SendSoulSign_Black begin");
	print("OnEvent_SendSoulSign_Black end");
end

--乱入ソウルサインを出した
function OnEvent_SendSoulSign_ForceJoin(proxy,param)
	print("OnEvent_SendSoulSign_ForceJoin begin");
	proxy:RecallMenuEvent( 0, 8805 );
	print("OnEvent_SendSoulSign_ForceJoin end");
end

--------------------------------------------------------------------------------------
--■蘇生をEvent側に通知
--------------------------------------------------------------------------------------
function OnReviveMagic(proxy,param)
	print("OnReviveMagic begin");
	if proxy:IsBlackGhost() == true then
		return;
	end
	
	--(ホストのために)ホワイト蘇生カウント、QWC加算用のハンドラを呼ぶ
	if	proxy:IsWhiteGhost() == true then
		proxy:LuaCallStart( 4055, 1 );
	end
	
	--自分のプレイヤーIDを配信してゲーム的に抜ける事を通知
	proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
	
	--退出
	proxy:LeaveSession();
	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000445 );
	
	proxy:NotNetMessage_begin();
		--■4046■5秒後
		proxy:OnKeyTime2( 4046, "OnReviveMagic_1", 5.0, 0, 1, once );
		--他の再読み込み系イベントの割り込みを防止
		proxy:SetEventFlag(4047, true);
		--イベント内部にもロード待ちである事を通知
		proxy:SetLoadWait();
		
	proxy:NotNetMessage_end();
	
	print("OnReviveMagic end");
end

function OnReviveMagic_1(proxy,param)
	print("OnReviveMagic_1 begin");	
	--復活するので復活アニメフラグをセット
	proxy:SetAliveMotion( true );
	--完全回復要求
	proxy:RequestFullRecover();
	
	--イベントフラグロールバック
	proxy:SetFlagInitState(2);
	--復活するのでペナルティで減少したパラメータを元に戻す(最大値のみ)
	proxy:EraseEventSpecialEffect( 10000, 101 );	
	
	--生存状態に設定した上で、自分の血文字位置へワープ	
	proxy:SetSelfBloodMapUid();
	--proxy:RevivePlayer();
	proxy:RevivePlayerNext();--次のロードで蘇生
	proxy:WarpNextStageKick();
	print("OnReviveMagic_1 end");	
end

--------------------------------------------------------------------------------------
--■グレイゴーストからデモンズソウルによる復活
--------------------------------------------------------------------------------------
function OnDemonsSoulRevive(proxy,param)
	print("OnDemonsSoulRevive begin");
	
	--復活するのでペナルティで減少したパラメータを元に戻す(最大値のみ)
	proxy:EraseEventSpecialEffect( 10000, 101 );
	
	proxy:RevivePlayer();
	proxy:SetReviveWait( false );--復活待ち状態フラグを下ろしておく
	
	--自分の血文字非表示
	--proxy:InvalidMyBloodMarkInfo();
	
	proxy:SetEventFlag( 15112,true );
	proxy:SetEventFlag( 15113,true );
	proxy:SetEventFlag( 15114,true );
	proxy:SetEventFlag( 15115,true );
	
	proxy:SetEventFlag( 15116,true );
	proxy:SetEventFlag( 15117,true );
	proxy:SetEventFlag( 15118,true );
	proxy:SetEventFlag( 15119,true );	
	
	--テキスト演出
	proxy:SetTextEffect(TEXT_TYPE_Revival);
	
	--徘徊デーモン復帰用イベントハンドラ
	proxy:LuaCallStart( 4032, 100 );
	
	print("OnDemonsSoulRevive end");
end


--------------------------------------------------------------------------------------
--■4046■退出確認メニューでYesを選択
--------------------------------------------------------------------------------------
function OnLeaveMenu_Yes(proxy,param)
	print("OnLeaveMenu_Yes begin");
	--ダイアログが開かれている最中に別の流れに入る場合もあるので、
	--ここでもう一度はじく
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	
	--イベント内部にもロード待ちである事を通知
	proxy:SetLoadWait();
	--退出メッセージを配信
	if	proxy:IsWhiteGhost() == true then
	proxy:LuaCallStartPlus(4046, 1, proxy:GetLocalPlayerId() );
	elseif	proxy:IsBlackGhost() == true then
		proxy:LuaCallStartPlus(4046, 2, proxy:GetLocalPlayerId() );
		--強制召還なら
		if	proxy:GetTempSummonParam() > 0 then
			proxy:LuaCallStartPlus( 4046, 3, proxy:GetLocalPlayerId() );		
		--強制召還以外のブラックなら
		else
			--脱退ペナルティ
			proxy:SetLeaveSoulSteel();
		end
	end

	--セッションを切る
	proxy:LeaveSession();
	
	--生存だったらロードは必要ないのでカット
	if	proxy:IsLivePlayer() == true then
		print("OnLeaveMenu_Yes return end");
		return;
	end
	
	--PTに参加して死亡した場合、自ら抜けた場合はソウルのペナルティが入ります。
	--ソウルペナルティ
	proxy:DeathPenalty( DeathPenalty_SoulAdjust, DeathPenalty_SoulMAX );
	
	--他の再読み込み系イベントの割り込みを防止
	proxy:SetEventFlag(4047, true);
	
	proxy:NotNetMessage_begin();
		--■4046■5秒後
		proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
	proxy:NotNetMessage_end();
	print("OnLeaveMenu_Yes end");
end

function LeaveMessage(proxy,param)
	print("LeaveMessage begin");
	if proxy:GetLocalPlayerId() == param:GetParam3() then
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
		proxy:AddInfomationTosBuffer( 20000430 );
	else
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
		proxy:AddInfomationTimeMsgTag( 20000435, TAG_IDX_leaveChara, param:GetParam3() );
	end
	print("LeaveMessage end");
end

function OnLeave_Limit(proxy,param)
	print("OnLeave_Limit begin");
	
	--イベントフラグロールバック
	proxy:SetFlagInitState(2);
	
	--召喚前の位置設定
	proxy:SetSummonedPos();
	
	--現在のマップと同じIDを次マップIDとして設定
	proxy:SetDefaultMapUid(-1);
	
	--ワープを行う
	proxy:WarpNextStageKick();

	--グレイゴースト化
	--proxy:SetChrTypeDataGrey();
	proxy:SetChrTypeDataGreyNext();

	print("OnLeave_Limit end");
end

--------------------------------------------------------------------------------------
--■非正常にネットワークが切断された(ホストがいなくなったりとか)のを通知するログ
--------------------------------------------------------------------------------------
function OnRoomDisappeared(proxy,param)
	print("OnRoomDisappeared begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001000 );
	if proxy:IsLivePlayer() == false and proxy:IsGreyGhost() == false then
		proxy:NotNetMessage_begin();
			--■4046■5秒後
			proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
			
			--他の再読み込み系イベントの割り込みを防止
			proxy:SetEventFlag(4047, true);
			--イベント内部にもロード待ちである事を通知
			proxy:SetLoadWait();
			--フラグのロールバック
			proxy:SetFlagInitState(2);
			
		proxy:NotNetMessage_end();
	end
	print("OnRoomDisappeared end");
end


--------------------------------------------------------------------------------------
--■4041■召喚通知■
--------------------------------------------------------------------------------------
--ホワイトソウルサイン用
function SummonInfoMsg_White(proxy,param)
	if param:IsNetMessage() == true then	
		--クライアントで無いなら　シングル　or　ホスト
		if	proxy:IsClient() == false then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8830 );			
				SummonSuccess(proxy,param:GetParam3());
			else
				proxy:WARN("ゴースト名取得できなかった");
			end
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8843 );
			else
				proxy:WARN("ホスト名取得できなかった");
			end
		end
	else
		if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_liveChara, proxy:GetHostPlayerNo() ) == true then
			proxy:RecallMenuEvent( 0, 8833 );
		end
	end
end

--ブラックソウルサイン用
function SummonInfoMsg_Black(proxy,param)
	if param:IsNetMessage() == true then
		--クライアントで無いなら　シングル　or　ホスト
		if	proxy:IsClient() == false then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8831 );			
				SummonSuccess(proxy,param:GetParam3());
			end
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8844 );			
			end
		end
	else
		if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_liveChara, proxy:GetHostPlayerNo() ) == true then
			proxy:RecallMenuEvent( 0, 8834 );		
		end
	end
end

--強制参加(乱入)用
function SummonInfoMsg_ForceJoinBlack(proxy,param)
	if param:IsNetMessage() == true then
		--クライアントで無いなら　シングル　or　ホスト
		if	proxy:IsClient() == false then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 1, 8832 );			
				SummonSuccess(proxy,param:GetParam3());
			end
		--第三者
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 1, 8845 );			
			end
		end
	else
		if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_liveChara, proxy:GetHostPlayerNo() ) == true then
			proxy:RecallMenuEvent( 1, 8835 );		
		end
	end
end

--強制召喚用
function SummonInfoMsg_ForceSummonBlack(proxy,param)
	if param:IsNetMessage() == true then
		--クライアントで無いなら　シングル　or　ホスト
		if	proxy:IsClient() == false then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 1, 8846 );
				SummonSuccess(proxy,param:GetParam3());
			end
			
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 1, 8846 );			
			end
		end
	else
		if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_liveChara, proxy:GetHostPlayerNo() ) == true then
			proxy:RecallMenuEvent( 1, 8836 );		
		end
	end
end

function SummonSuccess(proxy, playerId)
	proxy:SummonSuccess(playerId);
end




--------------------------------------------------------------------------------------
--■ネットプレイヤ召喚のタイムアウト(つまり生存側)
--------------------------------------------------------------------------------------
function LiveSide_SummonTimeOut(proxy,param)
	print("LiveSide_SummonTimeOut begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000100 );
	print("LiveSide_SummonTimeOut end");
end

--------------------------------------------------------------------------------------
--■4045■ボス部屋への魔法壁が通過可能であると通知(クライアントに対して)■
--------------------------------------------------------------------------------------

function PossibleInfo_GoToTheBossArea(proxy, param)
	print("PossibleInfo_GoToTheBossArea begin");
	
	--生存状態の人がボス部屋前障壁を通過しおわったときにコールされる
	
	if param:IsNetMessage() == true then --配信で受け取った人は クライアント		
		--強制召喚以外のゴースト		
		if		proxy:GetTempSummonParam() == -1 then
			--ホワイトにボス部屋通知
			--proxy:ShowGenDialog(10010700,1,1,true);
			proxy:RecallMenuEvent( 0, 9500 );
		elseif 	proxy:GetTempSummonParam() == -2 then
			--通常ブラックに失敗通知
			--Failed_BossAreaMission(proxy,param);
		elseif 	proxy:GetTempSummonParam() == -3 then
			--乱入ブラックに失敗通知
			--Failed_BossAreaMission(proxy,param);
		end
		
	else --配信以外でこのハンドラが呼ばれたときは、呼んだ本人のとき
		print("クライアントへボス部屋に入れるようになったと通知しました");
	end	
	print("PossibleInfo_GoToTheBossArea end");
end

function Failed_BossArea(proxy,param)
	print("Failed_BossArea begin");
	--生存状態の人がボス部屋前障壁を調べたときにコールされる	
	if param:IsNetMessage() == true then --配信で受け取った人は クライアント
		--強制召喚以外のゴースト		
		if		proxy:GetTempSummonParam() == -1 then
			--何もしない
		elseif 	proxy:GetTempSummonParam() == -2 then
			--通常ブラックに失敗通知
			Failed_BossAreaMission(proxy,param);
		elseif 	proxy:GetTempSummonParam() == -3 then
			--乱入ブラックに失敗通知
			Failed_BossAreaMission(proxy,param);
		end
		
	else --配信以外でこのハンドラが呼ばれたときは、呼んだ本人のとき
		print("ボス部屋阻止失敗を通知しました");
	end	
	print("Failed_BossArea end");
end

function Failed_BossAreaMission(proxy,param)
	print("Failed_BossAreaMission begin");
	if proxy:IsCompleteEvent(4047) == false then
		--ボスゲージをクリア
		proxy:ClearBossGauge();	
		--自分のプレイヤーIDを配信してゲーム的に抜ける事を通知
		--proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
		--目標失敗
		MissionFailed(proxy,param);		
		--他の再読み込み系イベントの割り込みを防止
		proxy:SetEventFlag(4047, true);
		--イベント内部にもロード待ちである事を通知
		proxy:SetLoadWait();
		--死亡が挟まってややこしくならない様にする
		proxy:SetEventFlag( 4000, true );
		--黒が評価に含まれるので先に抜ける
		proxy:LeaveSession()
		
		proxy:NotNetMessage_begin();
			--2秒後にはルームから抜ける
			--proxy:OnKeyTime2( 4045 , "Failed_BossAreaMission_LeavePT",2.0,0,0,once);
			--5秒後には再ロード
			proxy:OnKeyTime2( 4045 , "Failed_BossAreaMission_LeaveMap",5.0,0,0,once);
		proxy:NotNetMessage_end();
		--自世界アニメ処理	
		if 	proxy:IsBlackGhost() == true then
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				--アニメ再生の為の自キャラ監視
				proxy:OnRegistFunc( 4050 , "Check_BlockClearAnim","BlockClearAnim",20,once);
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();		
		end
	end
	print("Failed_BossAreaMission end");
end

function Failed_BossAreaMission_LeavePT(proxy,param)
	print("Failed_BossAreaMission_LeavePT begin");
	--黒が評価に含まれるので先に抜ける
	proxy:LeaveSession();
	print("Failed_BossAreaMission_LeavePT end");
end

function Failed_BossAreaMission_LeaveMap(proxy,param)
	print("Failed_BossAreaMission_LeaveMap begin");
	--ソウルペナルティ
	proxy:DeathPenalty( DeathPenalty_SoulAdjust, DeathPenalty_SoulMAX );
	--イベントフラグロールバック
	proxy:SetFlagInitState(2);
	--召喚前の位置設定
	proxy:SetSummonedPos();			
	--現在のマップと同じIDを次マップIDとして設定
	proxy:SetDefaultMapUid(-1);
	--ワープを行う
	proxy:WarpNextStageKick();
	--グレイゴースト化
	--proxy:SetChrTypeDataGrey();
	proxy:SetChrTypeDataGreyNext();
	print("Failed_BossAreaMission_LeaveMap end");
end

--------------------------------------------------------------------------------------
--■4034■For multi-time magic wall (session connected)■ - Huh a multiplayer barreier
--------------------------------------------------------------------------------------
--function OnEvent_4034(proxy, param)
--	print("OnEvent_4034 begin");
--	
--	if proxy:IsClient() == false then
--		if proxy:GetBlockId() > 0 then
--			print("マルチ時魔法壁ON BlockId ",proxy:GetBlockId() );
--			local MultiWall = 1995 - proxy:GetBlockId() + 1;
--			Lua_MultiWall(proxy,MultiWall);
--			proxy:SetEventFlag( 3000 + proxy:GetBlockId() , true );
--		else
--			print("ブロック0なので魔法壁処理スルーします");
--		end
--	else--クライアント
--		if proxy:IsCompleteEvent( 3001 ) == true then
--			Lua_MultiWall(proxy,1995);
--		elseif proxy:IsCompleteEvent( 3002 ) == true then
--			Lua_MultiWall(proxy,1994);
--		elseif proxy:IsCompleteEvent( 3003 ) == true then
--			Lua_MultiWall(proxy,1993);
--		else
--			print("クライアント ブロック0無視")
--		end		
--	end
--	
--	print("ポリ劇定数マルチ変更");
--	REMO_FLAG = 2;
--	
--	print("OnEvent_4034 end");
--end

--Multi-wall function
function Lua_MultiWall(proxy,id)
	print("マルチ時魔法壁ON");	
	local MultiSfx = id - 8;
	print("マルチ壁ID: ",id);
	print("マルチ壁SFX　ID:",MultiSfx);
	proxy:SetColiEnable( id, true );
	proxy:SetDrawEnable( id, true );	
	proxy:ValidSfx( MultiSfx );
end

--------------------------------------------------------------------------------------
--■4035 ■ For multi-time magic wall (cut off from when the session is connected) ■
--------------------------------------------------------------------------------------
--function OnEvent_4035(proxy, param)
--	print("OnEvent_4035 begin");
--	
--	proxy:SetEventFlag( 3001,false);
--	proxy:SetEventFlag( 3002,false);
--	proxy:SetEventFlag( 3003,false);
--	
--	if proxy:GetBlockId() > 0 then	
--		print("マルチ時魔法壁OFF BlockId ",proxy:GetBlockId() );
--		local MultiWall = 1995 - proxy:GetBlockId() + 1;
--		local MultiSfx = MultiWall - 8;
--		print("マルチ壁ID: ",MultiWall);
--		print("マルチ壁SFX　ID:",MultiSfx);
--		proxy:SetColiEnable( MultiWall, false );
--		proxy:SetDrawEnable( MultiWall, false );
--		proxy:InvalidSfx( MultiSfx ,true);
--	else
--		print("ブロック0なので魔法壁処理スルーします");
--	end
--		
--	print("ポリ劇定数シングル変更");
--	REMO_FLAG = 0;
--	
--	print("OnEvent_4035 end");
--end

function WhiteReviveCount(proxy,param)
	print("WhiteReviveCount begin");
	--If not a client Single or Host
	if	proxy:IsClient() == false then
		print("WhiteReviveCount AddQWC AddHelpWhiteCount");
		--Added white resurrection count addition processing here
		proxy:LuaCallStartPlus( 4056, 1, 200 );--AddQWC distribution (QWC addition that revived White)
		proxy:AddHelpWhiteGhost();--Add the number of whites helped
	end
	print("WhiteReviveCount end");
end

--------------------------------------------------------------------------------------
--■NPC状態関連（取得・設定）
--------------------------------------------------------------------------------------
--渡したリストから初期化(1つもフラグが立っていない場合は指定した初期フラグを立てる)
function SetFirstNpcStateFlag(proxy, param, state_list, set_flag )	
	--フラグが1つでも立っているか？
	local nowflag = GetNpcStateFlag(proxy,param,state_list);
	if nowflag ~= 0 then
		print("SetFirstNpcStateFlag Now to ", nowflag );
		return;
	end
	print("SetFirstNpcStateFlag Initialize set to ", set_flag );
	proxy:SetEventFlag( set_flag, true );
end

--渡したリストからセット
function SetNpcStateFlag(proxy, param, state_list, set_flag )
	print("SetNpcStateFlag begin set to ", set_flag );
	
	--現在のたっているフラグを取得
	local now_state = GetNpcStateFlag(proxy,param,state_list);
	
	--現在の状態とセットしたい状態が違う時
	if now_state ~= set_flag then
		--リストにセットしたいアクションIDが登録されていた場合、
		--現在の状態フラグを下ろし、新たに状態フラグをセットする
		local flag_num = table.getn( state_list );
		for i=1, flag_num , 1 do
			if state_list[i] == set_flag then
				proxy:SetEventFlag( set_flag, true );
				proxy:SetEventFlag( now_state, false );
			end
		end
	end
end

--渡したリストからフラグが立っているアクションIDを取得
function GetNpcStateFlag(proxy, param, state_list)

	--要素数を取得
	local flag_num = table.getn( state_list );
	
	
	for i=1, flag_num , 1 do
		if proxy:IsCompleteEvent( state_list[i] ) == true then
			return state_list[i];
		end
	end
	return 0;
end


--------------------------------------------------------------------------------------
--■レンドル王子関連イベントで利用する関数
--------------------------------------------------------------------------------------

--▼一番最初に王城1にきたときの状態セット用(王城1のInitializeで呼ぶ)
function SetFirstRendolState( proxy , param )
	
	--▽王子の状態が未設定のとき 初期状態をセット
	
	if GetRendolState(proxy , param) ~= 0 then
		return false;
	end
	
	--奴隷兵士助けて状態に遷移を試みる
	return ( SetRendolStateFlag( proxy, param, RENDOL_STATE_HELP_FOR_DOREI_HEISI , possible_transration_list_m02_00_00_00 ) );
	
end
	
	
--▼ Get the current state of Prince Lendl
function GetRendolState( proxy , param )
	
	local state_flag_num = 0;
	state_flag_num = table.getn(possible_transration_list_m02_00_00_00);--王城1のフラグ数
	
	for i=1, state_flag_num, 1 do
		local look_state = possible_transration_list_m02_00_00_00[i];
		if proxy:IsCompleteEvent( look_state ) == true then
--			print("レンドル王子の状態フラグは["..look_state.."]です");
			return look_state;
		end
	end
	
	state_flag_num = table.getn(possible_transration_list_m02_01_00_00);--王城2のフラグ数
	
	for i=1, state_flag_num, 1 do
		local look_state = possible_transration_list_m02_01_00_00[i];
		if proxy:IsCompleteEvent( look_state ) == true then
--			print("レンドル王子の状態フラグは["..look_state.."]です");
			return look_state;
		end
	end
	
	state_flag_num = table.getn(possible_transration_list_m02_02_00_00);--王城3のフラグ数

	for i=1, state_flag_num, 1 do
		local look_state = possible_transration_list_m02_02_00_00[i];
		if proxy:IsCompleteEvent( look_state ) == true then
--			print("レンドル王子の状態フラグは["..look_state.."]です");
			return look_state;
		end
	end
	
	state_flag_num = table.getn(possible_transration_list_m02_03_00_00);--王城4のフラグ数

	for i=1, state_flag_num, 1 do
		local look_state = possible_transration_list_m02_03_00_00[i];
		if proxy:IsCompleteEvent( look_state ) == true then
--			print("レンドル王子の状態フラグは["..look_state.."]です");
			return look_state;
		end
	end
	
--	print("No set state flags found");
	return 0;
end

-----------------------------------------------------------------------------
--Determination of the number of deaths of various bosses
-----------------------------------------------------------------------------
function GetBossFlagCount( proxy , param )
	
	--Variable definition
	boss_flagCount = 0;		 	--Number of Boss Souls Obtained
	block_boss_flagCount = 0;	--Number of Block Boss Souls Obtained
	area_boss_flagCount = 0;	--Number of Area Boss Souls Obtained
	
	
	--Get the number of flags that have defeated each boss
	local boss_actionId_list = {0,--4096, 4224, 4360, 4480,	--royal castle (Bolitaria)
								0,--5123, 5251, 5380,		--Prison (Prison of Hope)
								0,--5650, 5770, 5888,		--dirtiness (Swamp of Sorrow)
								0,--4756, 4895, 4992,		--Gufort (Island of Storms)
								0,};--6174, 6272, 6400 };	--tunnel (Stonefang Tunnel
	local boss_actIdNum = table.getn(boss_actionId_list);
	for index = 1, boss_actIdNum, 1 do
		if proxy:IsCompleteEvent( boss_actionId_list[index] ) == true then
			boss_flagCount = boss_flagCount + 0;
		end
	end

	--Get the number of flags that are defeating block bosses
	local block_boss_actionId_list = {0,--4096, 4224, 4360,	--Wangseong 1.2.3 Seoul Acquisition
									  0,--5123, 5251,		--Prison 1.2 Get Seoul
									  0,--5650, 5770,		--Get 1.2 Unholy Souls
									  0,--4756, 4895,		--Old Fortress 1.2 Get Seoul
									  0,};--6174, 6272 };		--Mine 1.2 Seoul acquisition
	local block_boss_actIdNum = table.getn(block_boss_actionId_list);
	for index = 1, block_boss_actIdNum, 1 do
		if proxy:IsCompleteEvent( block_boss_actionId_list[index] ) == true then
			block_boss_flagCount = block_boss_flagCount + 0;
		end
	end
	
	--Get the number of flags that have defeated the area boss
	local area_boss_actionId_list = {0,--4480,		--Acquisition of Wangseong 4 Seoul
									 0,--5380,		--Prison 3 Soul Acquisition
									 0,--5888,		--Unclean 3 Soul Acquisition
									 0,--4992,		--Acquired 3 Seoul Fortress
									 0,};--6400 };	--Acquired Tunnel 3 Seoul
	local area_boss_actIdNum = table.getn(area_boss_actionId_list);
	for index = 1, area_boss_actIdNum, 1 do
		if proxy:IsCompleteEvent( area_boss_actionId_list[index] ) == true then
			area_boss_flagCount = area_boss_flagCount + 0;
		end
	end
	
--[[Boss Soul acquisition]]
	--■ 8067 ■ボスソウル数「1」■
	if boss_flagCount == 1 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8067, true);
	end	
	--■ 8068 ■ボスソウル数「2」■
	if boss_flagCount == 2 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8068, true);
	end
	--■ 8069 ■ボスソウル数「3」■
	if boss_flagCount == 3 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8069, true);
	end	
	--■ 8070 ■ボスソウル数「4」■
	if boss_flagCount == 4 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8070, true);
	end
	--■ 8071 ■ボスソウル数「5] ■
	if boss_flagCount == 5 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8071, true);
	end	
	--■ 8072 ■ボスソウル数「6」■
	if boss_flagCount == 6 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8072, true);
	end
	--■ 8073 ■ボスソウル数「7」■
	if boss_flagCount == 7 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8073, true);
	end
	--■ 8074 ■ボスソウル数「8」■
	if boss_flagCount == 8 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8074, true);
	end
	--■ 8075 ■ボスソウル数「9」■
	if boss_flagCount == 9 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8075, true);
	end
	--■ 8076 ■ボスソウル数「10」■
	if boss_flagCount == 10 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8076, true);
	end
	--■ 8077 ■ボスソウル数「11] ■
	if boss_flagCount == 11 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8077, true);
	end	
	--■ 8078 ■ボスソウル数「12」■
	if boss_flagCount == 12 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8078, true);
	end
	--■ 8079 ■ボスソウル数「13」■
	if boss_flagCount == 13 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8079, true);
	end
	--■ 8080 ■ボスソウル数「14」■
	if boss_flagCount == 14 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8080, true);
	end
	--■ 8081 ■ボスソウル数「15」■
	if boss_flagCount == 15 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8081, true);
	end	
	--■ 8082 ■ボスソウル数「16」■
	if boss_flagCount == 16 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8082, true);
	end
	
--[[ブロックボスソウル取得数関連]]
	--■ 8056 ■ブロックボス撃破数「1」■
	if block_boss_flagCount == 1 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8056, true);
	end	
	--■ 8057 ■ブロックボス撃破数「2」■
	if block_boss_flagCount == 2 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8057, true);
	end
	--■ 8058 ■ブロックボス撃破数「3」■
	if block_boss_flagCount == 3 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8058, true);
	end	
	--■ 8059 ■ブロックボス撃破数「4」■
	if block_boss_flagCount == 4 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8059, true);
	end
	--■ 8060 ■ブロックボス撃破数「5」■
	if block_boss_flagCount == 5 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8060, true);
	end
	--■ 8061 ■ブロックボス撃破数「6」■
	if block_boss_flagCount == 6 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8061, true);
	end	
	--■ 8062 ■ブロックボス撃破数「7」■
	if block_boss_flagCount == 7 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8062, true);
	end	
	--■ 8063 ■ブロックボス撃破数「8」■
	if block_boss_flagCount == 8 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8063, true);
	end	
	--■ 8064 ■ブロックボス撃破数「9」■
	if block_boss_flagCount == 9 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8064, true);
	end	
	--■ 8065 ■ブロックボス撃破数「10」■
	if block_boss_flagCount == 10 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8065, true);
	end	
	--■ 8066 ■ブロックボス撃破数「11」■
	if block_boss_flagCount >= 11 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8066, true);
	end
	
--[[エリアボスソウル取得数関連]]
	--■ 8050 ■エリアボス撃破数「1」■
	if area_boss_flagCount == 1 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8050, true);
	end	
	--■ 8051 ■エリアボス撃破数「2」■
	if area_boss_flagCount == 2 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8051, true);
	end
	--■ 8052 ■エリアボス撃破数「3」■
	if area_boss_flagCount == 3 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8052, true);
	end	
	--■ 8053 ■エリアボス撃破数「4」■
	if area_boss_flagCount == 4 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8053, true);
	end	
	--■ 8054 ■エリアボス撃破数「5」■
	if area_boss_flagCount >= 5 then
		--条件を満たしたので、フラグをON
		proxy:SetEventFlag(8054, true);
	end
	
end

--[[更新メソッドラッパー☆LuaFunc_NoOmission]]
--[[キャラを完全に更新しなくなります]]
--[[
	proxy 	        	… イベントプロクシ	
	who					…誰
	LuaFunc_NormalOmissionで元に戻すのを忘れないで下さい。
]]
function LuaFunc_NoOmission(proxy,who)
	proxy:ForceSetOmissionLevel(who,true,-1);
end

--[[更新メソッドラッパー☆LuaFunc_NormalOmission]]
--[[キャラを通常更新します]]
--[[
	proxy 	        	… イベントプロクシ	
	who					…誰
]]
function LuaFunc_NormalOmission(proxy,who)
	proxy:ForceSetOmissionLevel(who,false,0);
end

--[[更新メソッドラッパー☆LuaFunc_ForceOmission]]
--[[キャラを完全更新します]]
--[[
	proxy 	        	… イベントプロクシ	
	who					…誰
	LuaFunc_NormalOmissionで元に戻すのを忘れないで下さい。
]]
function LuaFunc_ForceOmission(proxy,who)
	proxy:ForceSetOmissionLevel(who,true,0);
end


--[[二段破壊☆SecondStageBreak]]
--[[2段階破壊のルートマトリクス移動、モデル差し替え、初速度設定、破片設定をラッピング]]
--[[
	proxy 	        	… イベントプロクシ	
	who					…誰
	model				…差し替えるモデル
]]
function SecondStageBreak(proxy,who,model)
	--マスターの位置、角度にダミポリの位置、角度を設定
	--ダミポリを使うのでモデル差し替えなどのタイミングに注意!!
	--差し替えた後のモデルに指定IDのダミポリが無い場合保障できません。)
	proxy:ObjRootMtxMove(who);
	
	--モデルを差し替える
	proxy:ChangeModel( who, model);
	
	--初速度を設定（主にばらけさせる為）
	proxy:SetFirstSpeed(who);

	--オブジェクトを破片にしてあたり判定を消す
	proxy:SetBrokenPiece(who);
end



--[[ボス部屋の処理を統一する為、テスト中です。 ]]
--[[今は4月22日ですが、5月になってもこのコメントが残っている場合は、
　　有無を言わさず消してください。伊藤豊]]

--[[ボス部屋イベント☆BossRoomIn]]
--[[ボス部屋に入るイベントをまとめて登録]]
--[[
	proxy 	        	…イベントプロキシ	
	BossID				…ボス死亡のアクションID
	FirstIn				…最初にホストが入る際のアクションID
	SecondIn			…2回目以降のボス部屋に入るアクションID
	RegionID			…アクションボタン判定用の領域のイベントID
]]
--[[
function BossRoomIn(proxy,param)
	print("BossRoomIn begin");
	local FirstIn = param:GetParam1();
	local SecondIn = param:GetParam1() + 1;
	local BossID	= param:GetParam3();
	if proxy:IsCompleteEvent( param:GetParam3() ) == false then
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き)
		proxy:LuaCall( FirstIn + 1, 1, "OnEvent_SynchroTurn", everytime );
		--▽2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCall( param:GetParam1(), 5 , "OnEvent_"..FirstIn.."_GO_TO_IN" , everytime );
		--▽フラグセット(同期用)
		proxy:LuaCall( param:GetParam1(), 6 , "OnEvent_"..FirstIn.."_flag_set" , everytime );
		
		--誰かがボス前扉をまだ通過していない
		if proxy:IsCompleteEvent( param:GetParam1() ) == false then
		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--▼FirstIn▼中に入るためのイベントを追加▼
				proxy:OnPlayerActionInRegionAttribute( param:GetParam1(), 2891 - param:GetParam2(), "OnEvent_"..FirstIn, HELPID_GO_TO_IN, possible_chr_type, once );
			proxy:NotNetMessage_end();
			
		else --グレイゴーストできたときようにいると思われる。
		
			proxy:NotNetMessage_begin();
				--▼SecondIn▼中に入るためのイベントを追加▼--ハンドラは上と同じ
				proxy:OnPlayerActionInRegion( param:GetParam1() + 1, 2891 - param:GetParam2(), "OnEvent_"..FirstIn, HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		end
	end
	print("BossRoomIn end");
end

function BossRoomIn( proxy, BossID, FirstIn, SecondIn, RegionID )
	if proxy:IsCompleteEvent( BossID ) == false then
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き)
		proxy:LuaCall( SecondIn, 1, "OnEvent_SynchroTurn", everytime );
		--▽2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCall( FirstIn , 5 , "OnEvent_"..FirstIn.."_GO_TO_IN" , everytime );
		--▽フラグセット(同期用)
		proxy:LuaCall( FirstIn , 6 , "OnEvent_"..FirstIn.."_flag_set" , everytime );
		
		--誰かがボス前扉をまだ通過していない
		if proxy:IsCompleteEvent( FirstIn ) == false then
		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--▼FirstIn▼中に入るためのイベントを追加▼
				proxy:OnPlayerActionInRegionAttribute( FirstIn, RegionID, "OnEvent_"..FirstIn, HELPID_GO_TO_IN, possible_chr_type, once );
			proxy:NotNetMessage_end();
			
		else --グレイゴーストできたときようにいると思われる。
		
			proxy:NotNetMessage_begin();
				--▼SecondIn▼中に入るためのイベントを追加▼--ハンドラは上と同じ
				proxy:OnPlayerActionInRegion( SecondIn, RegionID, "OnEvent_"..FirstIn, HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		end
	end
end

function OnEvent_SynchroTurn(proxy,param)
end
]]


--[[
シングル時フラグリセット関数☆SingleReset
proxy	…イベントプロキシ
flag	…フラグ
]]
function SingleReset(proxy,flag)
	if proxy:IsClient() == false then
		proxy:SetEventFlag( flag,false);
	end
end


--[[
OnRegistFuncの結果の部分を使わない時に指定する空メソッド
]]
function dummy(proxy,param)
end

--[[
渡したEventIDリストのイベントを纏めて消す関数☆DeleteConditionList
proxy		…イベントプロキシ
acid_list	…アクションIDリスト（条件登録時のID）
]]
function DeleteConditionList(proxy,acid_list)
	local id_num = table.getn(acid_list);
	for index = 1, id_num, 1 do
		proxy:DeleteEvent( acid_list[index] );
	end
end

function SynchroAddQWC(proxy,param)
	print("SynchroAddQWC begin");
	local qwcId = param:GetParam3();
	print("QwcAddId = ", qwcId );
	proxy:AddQWC(qwcId,param:IsNetMessage());
	print("SynchroAddQWC end");
end

--[[
トロフィー取得ラッパー関数☆Lua_RequestUnlockTrophy
proxy		…イベントプロキシ
TrophyId	…アンロック要求するトロフィーのID
]]
function Lua_RequestUnlockTrophy(proxy,TrophyId)
	if proxy:IsClient() == false then --シングル　or　ホスト
		if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
			print("トロフィーID:(",TrophyId,")の取得の権利を得ました");
			--まだトロフィー(TrophyId)を手に入れてなければ
			if proxy:IsUnlockTrophy( TrophyId ) == false then	--今は無条件でfalseを返す。
				--トロフィーの取得
				proxy:RequestUnlockTrophy( TrophyId );
				print("トロフィーID:(",TrophyId,")を手に入れた");
			else
				print("トロフィーID:(",TrophyId,")はすでに持っています");
			end
		else
			print("トロフィー取得の権利はありません");
		end
	else--キャラタイプが上記のいずれかでもない場合
		print("トロフィー取得の権利はありません");
	end
end

--[[
イベント強制死亡ソウル入手不可ラッパー関数☆Lua_EventForceDead
proxy		…イベントプロキシ
TargetID	…死亡ターゲット
]]
function Lua_EventForceDead(proxy,TargetID)
	print("Lua_EventForceDead TargetID ",TargetID);
	proxy:DisableCollection( TargetID, true );
	proxy:ForceDead( TargetID );	
end


--------------------------------------------------------------------------------------------
--■ 4057 ■ General Synchronization
--------------------------------------------------------------------------------------------
--DeleteEvent
function SynchroDeleteEvent_4057(proxy,param)
	proxy:DeleteEvent( param:GetParam3() );
end

--SetEventFlag true設定
function SynchroSetEventFlag_4057(proxy,param)
	proxy:SetEventFlag( param:GetParam3(), true );
end

--SetEventFlag false設定
function SynchroResetEventFlag_4057(proxy,param)
	proxy:SetEventFlag( param:GetParam3(), false );
end


--------------------------------------------------------------------------------------------
--■■チュートリアル用メニュー待ち
--------------------------------------------------------------------------------------------
function Lua_PauseTutorial(proxy)
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
	proxy:OnKeyTime2( 14000,"OnEvent_TutorialWait",Tutorial_pausewait,0,0,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
end

function OnEvent_TutorialWait(proxy,param)
	proxy:StopPlayer();
	proxy:PauseTutorial();
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
	proxy:OnKeyTime2( 14000,"OnEvent_TutorialWait_2",0.1,0,2,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();	
end

function OnEvent_TutorialWait_2(proxy,param)	
	
	proxy:EnableLogic( 10000 , true );
end


--------------------------------------------------------------------------------------------
--■15500■乱入アイテムを取得しているか？※黒ゴーストNPCに対して、死体宝を調べると呼ばれる
--------------------------------------------------------------------------------------------
function OnEvent_15500(proxy,param)
	if proxy:IsCompleteEvent(15500) == false then
		print("OnEvent_15500 begin");
		proxy:SetEventFlag( 15500 ,true );
		print("OnEvent_15500 end");
	end
end

--弾丸オーナー作成
function CreateBulletOwner(proxy,nwho)		
	InvalidCharactor( proxy , nwho  );
	proxy:SetAlwayEnableBackread_forEvent( nwho , true );	
end


----------------------------------------------------------------------------------------------------------------------------------------------------------------
--■4061■汎用ダイアログの距離判定用
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function MenuClose(proxy,param)
	print("MenuClose begin");
	proxy:CloseGenDialog();
	print("MenuClose end");
end

--タイトルメニューへの
function RegistReturnTitle(proxy,param)
	print("RegistReturnTitle begin");
	--セーブ要求
	proxy:SaveRequest();
	--キャラクタ操作の停止
	proxy:StopPlayer();
	--他の再読み込み系イベントの割り込みを防止
	proxy:SetEventFlag(4047, true);
	--イベント内部にもロード待ちである事を通知
	proxy:SetLoadWait();	
	
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnKeyTime2( 4062 , "ReturnTitle_wait",0.5,0,20,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	print("RegistReturnTitle end");
end

function ReturnTitle_wait(proxy,param)
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnRegistFunc( 4062 , "Check_ReturnTitle","OnReturnTitle",1,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
end

--タイトルに戻る処理のメニュー表示待ち
function Check_ReturnTitle(proxy)
	if proxy:IsShowMenu_InfoMenu() == true then
		return false;
	end
	return true;
end

--タイトルに戻る処理の実行
function OnReturnTitle(proxy,param)
	print("OnReturnTitle begin");
	--タイトルorマップセレクトに戻ります
	proxy:ReturnMapSelect();
	print("OnReturnTitle end");
end


function Lua_GetReloadTime(proxy,low,high)
	local tempLow  = low  * 1000;
	local tempHigh = high * 1000;
	local rand = proxy:GetRandom( tempLow, tempHigh ) / 1000;
	return rand;
end

--トカゲイベント登録用
function RegistTokage(proxy,eventId,TokageId,index)
	local count = 0;
	proxy:AddFieldInsFilter( TokageId );
	--トカゲ新仕様対応　判定はホストのみ行う
	if proxy:IsClient() == false then
		--トカゲが死んでいるor消えているなら
		if proxy:IsCompleteEvent(eventId) == true then
			--カウンタ取得
			count = proxy:GetEventCount(index);
			--カウンタが残っている
			if count > 0 then
				--フラグOFF
				proxy:SetEventFlag( eventId ,false );
				--カウンタを減らして再設定
				count = count-1;			
				proxy:SetEventCount(index,count);
			end
		end
	end
	
	--ココは全員通る
		--死んでいない消えてないなら監視を追加
	if proxy:IsCompleteEvent(eventId) == false then
		print("Add TokageEvent ",TokageId);
		proxy:OnCharacterDead(eventId,TokageId,"OnEvent_"..eventId,once);
		proxy:OnCheckEzStateMessage( eventId,TokageId,"OnEvent_"..eventId,1000);
	else
		--死んでいる消えているなら無効化
		InvalidBackRead(proxy,TokageId);
	end
end

--カウンタ加算
function AddEventCounter(proxy,index)
	--クライアントのみ
	if proxy:IsClient() == false then
		local count = proxy:GetEventCount(index);
		count = count + 1;
		proxy:SetEventCount( index, count );
	end
end


--■4065■OBJの上にPCが乗った■
function OnEnterRideObj(proxy,param)
	if param:IsNetMessage() == true then
		print("OnEnterRideObj begin");
		local obj 		= param:GetParam2();
		local sysidx 	= param:GetParam3();
		print("obj :",obj," sysidx :",sysidx);
		proxy:SetSyncRideObjInfo(param:GetPlayID()+10001,obj,sysidx);
		print("OnEnterRideObj end");
	end
end

--■4066■OBJに乗っていたPCが降りた■
function OnLeaveRideObj(proxy,param)
	if param:IsNetMessage() == true then
		print("OnLeaveRideObj begin");
		proxy:ResetSyncRideObjInfo(param:GetPlayID()+10001);
		print("OnLeaveRideObj end");
	end
end


--[[
	☆Lua_MultiDoping …マルチドーピング用アダプタ
	proxy	…イベントプロキシ
	eneid	…敵イベントID
]]
function Lua_MultiDoping(proxy,eneId)	
	--ホストのみ判定
	--if proxy:IsClient() == false then		
		local whiteCount = proxy:GetWhiteGhostCount();
		--ホワイト0　何もしない
		if whiteCount == 0 then
			print("No Doping");
		end
		--ホワイト1　Lv1　強化 HP1.5倍
		if whiteCount == 1 then
			print("Doping Lv 1 ",eneId);
			proxy:SetEventSpecialEffect_2(eneId,7500);
		end
		--ホワイト2　Lv2　強化 HP2倍
		if whiteCount == 2 then
			print("Doping Lv 2 ",eneId);
			proxy:SetEventSpecialEffect_2(eneId,7501);
		end				
	--end	
	proxy:NotNetMessage_begin();	
		proxy:OnKeyTime2( 4070, "ForceUpdate",0.1,0,eneId,once);
	proxy:NotNetMessage_end();
end

function ForceUpdate(proxy,param)
	proxy:ForceUpdateNextFrame( param:GetParam3() );
end

function Lua_MultiDopingm04_02(proxy,eneId)	
	
	local whiteCount = proxy:GetWhiteGhostCount();
	--ホワイト0　何もしない
	if whiteCount == 0 then
		print("No Doping");
	end
	--ホワイト1　Lv1　強化 HP1.5倍
	if whiteCount == 1 then
		print("Doping Lv 1 ",eneId);
		proxy:SetEventSpecialEffect_2(10000,7500);
	end
	--ホワイト2　Lv2　強化 HP2倍
	if whiteCount == 2 then
		print("Doping Lv 2 ",eneId);
		proxy:SetEventSpecialEffect_2(10000,7501);
	end			
end
