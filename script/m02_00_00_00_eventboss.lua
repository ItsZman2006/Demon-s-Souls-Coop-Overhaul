
--ファランクスJrのイベントIDの列挙用、最初と最後
PHALANXJRID_START = 860;
PHALANXJRID_END = 897;
--Jr通常状態でいられる時間のウェイト
--※時間経過後に戻り数に空きがなければウェイトを再計算して設定します
PHALANXTIMER_NormalMin = 20;
PHALANXTIMER_NormalMax = 40;
--Jrがコアを目指している時間のウェイト
--※AIがコアに到着したと返す前にこの時間が切れたら通常に戻ります
--※この時間が尽きるまでにコアにたどり着いたと認識されたら吸着へ以降します
PHALANXTIMER_ToCoreMin = 20;
PHALANXTIMER_ToCoreMax = 40;

PHALANXCORE_STATE = -1;

--剥がれ処理で使用する各パラメータ定数
BEGINFADEDIST = 0.30;	--減衰開始距離[m]
ENDFADEDIST = 1.0;		--減衰終了距離[m]
BEGINVELOCITY = 5.0;	--減衰前線速度[m/sec]
ENDVELOCITY = 1.0;		--減衰後線速度[m/sec]

--単純運動量値
PAHALNX_ANGULARDAMPING = 20.0;

PHALANX_1st_DOPING = 15;
PHALANX_2nd_DOPING = 25;

function EventBoss_Initialize_m02_00_00_00(proxy)
	print("EventBoss_Initialize begin");
	
	--ファランクス初期化判定
	--▽ボス生きているとき
	if proxy:IsCompleteEvent( 4096 ) == false then
		if proxy:IsClient() == false then--シングルかホストならば			
			--ファランクス用の初期化処理
			BossInit_Phalanx(proxy,param);
			print("※ファランクス 初期化※");
		else--クライアントならば
			proxy:NotNetMessage_begin();
				--クライアント用の初期化を行う
				BossInit_Phalanx_ForClient(proxy,param);
				--proxy:OnKeyTime2( 4175 ,"BossInit_Phalanx3",0.1,0,3,once);
				BossInit_Phalanx3(proxy,param);
			proxy:NotNetMessage_end();
		end
	else--ボスは死んでいるとき
		--ファランクス死亡
		PhalanxEventDead(proxy,param);
		print("※ファランクス 死亡初期化※");
	end
	
	--------------------------------------------------------------------------------------
	--4173～4223■ファランクスイベント
	--------------------------------------------------------------------------------------
	proxy:NotNetMessage_begin();
		if proxy:IsClient() == false then--PTじゃ無かったら
			--■4173■ファランクスイベント■突進攻撃開始
			proxy:OnCheckEzStateMessage(4173,800,"OnEvent_4173",RES_PHALANX_TotugekiStart);	
			--■4174■ファランクスイベント■突進攻撃終了
			proxy:OnCheckEzStateMessage(4174,800,"OnEvent_4174",RES_PHALANX_TotugekiEnd);
			
		end
	proxy:NotNetMessage_end();	
	
	--■4176■Jrのアタリ変更：ボス化■
	proxy:LuaCall( 4176 , 1 ,"OnEvent_4176" , everytime);
	--■4177■Jrのアタリ変更：通常化■
	proxy:LuaCall( 4177 , 1 , "OnEvent_4177", everytime);
	
	--■4177■JrのHP回復特殊効果解除■
	proxy:CustomLuaCall( 4177, "OnEvent_4177_Doping", everytime);
	
	print("EventBoss_Initialize end");
end

--------------------------------------------------------------------------------------
--ボス用の初期化処理が必要なときに使用：固有情報の作成等
--------------------------------------------------------------------------------------
function BossInit_Phalanx(proxy,param)
	print("BossInit_Phalanx begin");
	--ファランクスの思考を止めておく
    proxy:EnableLogic(800, false );		
	local JrID =0;
    for JrID = PHALANXJRID_START,PHALANXJRID_END,1 do		
        proxy:EnableLogic(JrID, false );
		proxy:AddFieldInsFilter( JrID );
    end
	
	--クライアントで無いなら　シングル　or　ホスト
	if	proxy:IsClient() == false then
		--ネットワークの更新権限を取得
		proxy:RequestForceUpdateNetwork(800);
		for JrID = PHALANXJRID_START,PHALANXJRID_END,1 do
			--ネットワークの更新権限を要求
			proxy:RequestForceUpdateNetwork(JrID);
		end
	end
	
	if proxy:IsClient() == false then--PTじゃ無かったら
		--ファランクス作成
		proxy:CreatePhalanx(800,PHALANXJRID_START,0.95,1020);
		proxy:SetPhalanxCollision();
		--Jrのダミポリ間移動のウェイト
		proxy:SetBaseDmyPolyMoveWait(JR_BaseDmyPolyMoveWait);
		--Jrの戻り状態の最大数
		proxy:SetMaxReturnCount(PHALANX_MaxReturnCount);
		--Jrの剥がれ処理に使用するパラメータ
		proxy:SetVelocityParam(BEGINFADEDIST,ENDFADEDIST,BEGINVELOCITY,ENDVELOCITY);
		--ファランクスの角速度単純運動量減衰値を設定
		proxy:SetAngularDampingByPhalanx( PAHALNX_ANGULARDAMPING );
		--引っ付きになるために更新は必要
		proxy:SetDoesUpdateByPhalanx(true);
	end	
	proxy:NotNetMessage_begin();
		--proxy:OnKeyTime2( 4175 ,"BossInit_Phalanx2",0.1,0,0,once);
		BossInit_Phalanx2(proxy,param);
	proxy:NotNetMessage_end();
	print("BossInit_Phalanx end");
end

--クライアント用の初期化
function BossInit_Phalanx_ForClient(proxy,param)
	print("BossInit_Phalanx_ForClient begin");
	--ファランクスのアタリを変える
    proxy:SetPhalanxCollision();
	local JrID =0;
    for JrID = PHALANXJRID_START,PHALANXJRID_END,1 do		
        proxy:SetBossUnitJrHit(JrID, true );
    end
	print("BossInit_Phalanx_ForClient end");
end


--------------------------------------------------------------------------------------
--時間差で更新OFF
--------------------------------------------------------------------------------------
function BossInit_Phalanx2(proxy,param)
	print("BossInit_Phalanx2 begin");	
	--ファランクスイベント処理は重めなので更新をOFF
	proxy:SetDoesUpdateByPhalanx(false);	
	print("BossInit_Phalanx2 end");
	BossInit_Phalanx3(proxy,param);
end

function BossInit_Phalanx3(proxy,param)
	print("BossInit_Phalanx3 begin");		
	--ファランクスキャラ更新OFF
	--proxy:ForceSetOmissionLevel(800,true,-1);
	LuaFunc_NoOmission(proxy,800);
	local JrID =0;
    for JrID = PHALANXJRID_START,PHALANXJRID_END,1 do		        
		--proxy:ForceSetOmissionLevel(JrID,true,-1);
		LuaFunc_NoOmission(proxy,JrID);
    end
	print("BossInit_Phalanx3 end");
end


--------------------------------------------------------------------------------------
--ファランクスの動作開始処理
--------------------------------------------------------------------------------------
function PhalanxEventStart(proxy,param)
	print("PhalanxEventStart");
	--クライアントで無いなら　シングル　or　ホスト
	if	proxy:IsClient() == false then
		--■4175■ファランクスイベント■Jr監視
		proxy:OnRegistFunc(4180,"Check_PhalanxJr","OnEvent_4175",1,once);
	end
	
	--ファランクスのロジックをオン
    proxy:EnableLogic(800, true );
	--proxy:ForceSetOmissionLevel(800,true,0);	
end

function PhalanxStandBy(proxy,param)
	print("PhalanxStandBy");
	if	proxy:IsClient() == false then
		--ファランクス処理の更新をON
		proxy:SetDoesUpdateByPhalanx(true);		
	end	
	LuaFunc_ForceOmission(proxy,800);
	proxy:SetAlwaysDrawForEvent(800,true);
	local JrID=0;
    for JrID = PHALANXJRID_START,PHALANXJRID_END,1 do
        proxy:EnableLogic(JrID, true );
		--proxy:ForceSetOmissionLevel(JrID,true,0);
		LuaFunc_ForceOmission(proxy,JrID);
		proxy:SetAlwaysDrawForEvent(JrID,true);
    end
end

--------------------------------------------------------------------------------------
--ファランクス用死亡処理
--------------------------------------------------------------------------------------
function PhalanxDead(proxy,param)
	proxy:ForceDead(800);
	--proxy:ForceSetOmissionLevel(800,false,0);
	LuaFunc_NormalOmission(proxy,800);
	local JrID=0;
	for JrID = PHALANXJRID_START,PHALANXJRID_END,1 do
		--Jrを殺す
		--if proxy:IsAlive(JrID) == true then
			proxy:EventIdDetach_PhalanxJr(JrID);			
			proxy:ForceDead_ByJrId(JrID,JR_STATE_Dead);
			--proxy:ForceSetOmissionLevel(JrID,false,0);
			LuaFunc_NormalOmission(proxy,JrID);
		--end
	end
	--ファランクスイベントの監視を削除する
	proxy:DeleteEvent(4173);
	proxy:DeleteEvent(4174);
	proxy:DeleteEvent(4175);
	proxy:DeleteEvent(4180);
end


--------------------------------------------------------------------------------------
--ファランクス再現用死亡処理
--------------------------------------------------------------------------------------
function PhalanxEventDead(proxy,param)
	InvalidBackRead(proxy,800);
	local JrID =0;
	for JrID = PHALANXJRID_START,PHALANXJRID_END,1 do
		--Jrを殺す
		--if proxy:IsAlive(JrID) == true then
			InvalidBackRead(proxy,JrID);
		--end
	end	
end

--------------------------------------------------------------------------------------
--4173～4223■以下ファランクス
--------------------------------------------------------------------------------------




--------------------------------------------------------------------------------------
--4173■突撃攻撃開始
--------------------------------------------------------------------------------------
function OnEvent_4173(proxy,param)
	print("OnEvent_4173 begin");
	proxy:SetEventCommand_PhalanxJr(PHALANX_Jr_Totugeki);
	PHALANXCORE_STATE = PHALANX_Jr_Totugeki;
	print("OnEvent_4173 end");
end

--------------------------------------------------------------------------------------
--4174■突撃攻撃終了
--------------------------------------------------------------------------------------
function OnEvent_4174(proxy,param)
	print("OnEvent_4174 begin");
	proxy:SetEventCommand_PhalanxCore(-1);
	PHALANXCORE_STATE = -1;
	proxy:SetEventCommand_PhalanxJr(-1);
	print("OnEvent_4174 end");
end


--------------------------------------------------------------------------------------
--ファランクスJrの状態チェック■???
--------------------------------------------------------------------------------------
function Check_PhalanxJr(proxy,param)
	--[[
	if proxy:IsCompleteEvent( 111 ) ==false then
		return false;
	end
	]]
	--print(" begin");
	--Jrのループ
	if PHALANXCORE_STATE ~= PHALANX_Jr_Totugeki then
	end
	
	local attachCount = proxy:GetAttachCount();
	
	local dopi1 = 5020;
	local dopi2 = 5021;
	--結合数が最大ドーピング数より上か？
	if attachCount >= PHALANX_2nd_DOPING then
		--弱ドーピングを消去
		proxy:EraseEventSpecialEffect( 800 , dopi1);
		--強ドーピングを設定
		proxy:SetEventSpecialEffect( 800 , dopi2);
	elseif attachCount >= PHALANX_1st_DOPING then
		--強ドーピングを消去
		proxy:EraseEventSpecialEffect( 800 , dopi2);
		--弱ドーピングを設定
		proxy:SetEventSpecialEffect( 800 , dopi1);
	else
		--両ドーピングを消去		
		proxy:EraseEventSpecialEffect( 800 , dopi1);		
		proxy:EraseEventSpecialEffect( 800 , dopi2);
	end
	
	for JrID = PHALANXJRID_START,PHALANXJRID_END,1 do
	--local FOREND = PHALANXJRID_START+1;
	--for JrID = PHALANXJRID_START,FOREND,1 do
		--イベントIDが一致するJr情報があるか？
		if proxy:FindJrByEventID(JrID) == true then	
			if proxy:IsAlive(JrID) == true then			
				local state = proxy:GetTempJrState();
				
				--HPでJrの状態を遷移する,判定を行うのは一人身以外のJrです
				if state ~= JR_STATE_Single then
					PHALANX_JR_HPRATE = 0.3;
					if proxy:GetHpRate_ByTempJr() <= PHALANX_JR_HPRATE then
						--通常
						if state == JR_STATE_Normal then
							--直接一人身に移行
							proxy:SetTempJrState( JR_STATE_Single );									
						--ダミポリへの完全吸着
						elseif state == JR_STATE_DmyAttach then
							--剥がれに移行
							proxy:PlayAnimation(JrID,9015);
							proxy:EventIdDetach_PhalanxJr(JrID);
							proxy:SetTempJrState( JR_STATE_HavokFly );
						end
					end					
				end
				
				--状態を判定する
				--通常
				if state == JR_STATE_Normal then
					--コアを目指すに移行する条件判定
					if proxy:IsTempJrNoWait() == true then--ウェイトが無くなっている
						--戻り状態に空きがあるか？
						local rand = proxy:GetRandom(PHALANXTIMER_ToCoreMin,PHALANXTIMER_ToCoreMax);
						local rand2 = rand+1;
						if proxy:IsReturn_PhalanxJr() == true then						
							if proxy:SetNearDmyPoint_Core(JrID,0.0) == true then						
								proxy:SetTempJrState( JR_STATE_ToCore );	--状態をコアを目指す移動に
								proxy:SetTempJrWait(rand);	--生成したランダムウェイトを設定						
								if proxy:AddEventGoal(JrID, GOAL_COMMON_MoveToSomewhere, rand2, POINT_EVENT, AI_DIR_TYPE_CENTER, 0.0, TARGET_SELF, false,0,0,0) == true then			
									--print("設定成功 :",JrID);
									proxy:DisableInterupt(JrID,true);
								else
									--print("設定失敗 :",JrID);
								end
								--proxy:DisableInterupt(JrID,true);							
							else
								--print("Point設定失敗 :",JrID);
								proxy:SetTempJrWait(rand);	--生成したランダムウェイトを設定
								proxy:SetReserveDmyPolyIDByTempJr(0);--予約ダミポリを初期化(再検索用？)
							end
						else--戻り状態がいっぱいです
							proxy:SetTempJrWait(rand);	--生成したランダムウェイトを設定
							--状態変更無し:通常のまま
						end
					end			
				--コアを目指す移動
				elseif state == JR_STATE_ToCore then
					--ダミポリへのホバー移動に移行する条件判定
					if proxy:IsProcessEventGoal(JrID) == true then	--実行中
						proxy:SetNearDmyPoint_Core(JrID,0.0);--移動先ポイント設定
						if proxy:IsBossCollisionByTempJr() == false then
							if proxy:IsDistance(JrID,800,6.0) == true then	--距離内に入ったら
								if proxy:AddEventGoal(JrID, GOAL_COMMON_MoveToSomewhere, -1, POINT_EVENT, AI_DIR_TYPE_CENTER, 0.0, TARGET_SELF, false,0,0,0) == true then
									--print("アタリ変更、期限無し移動開始 :",JrID);								
									proxy:SetTempJrWait(100);
									proxy:TempJrChangeBossCollision();
								else
									--print("アタリ変更無し、期限無し移動設定失敗 :",JrID);
									--proxy:SetTempJrWait(100);
								end
							end
						end
					else--実行してない
						local rand = proxy:GetRandom(PHALANXTIMER_NormalMin,PHALANXTIMER_NormalMax);
						local rand2 = rand+1;
						
						if proxy:GetEventGoalState( JrID ) == -1 then--ゴールが失敗したら通常
						--if proxy:IsTempJrNoWait() == true then--ウェイトが無くなっているなら目的地到着失敗
							--print("ID:",JrID," 目的地検索失敗");
							proxy:SetTempJrState( JR_STATE_Normal );	--状態を通常に
							proxy:SetBossUnitJrHit(JrID, false );						
							proxy:SetTempJrWait(rand);	--生成したランダムウェイトを設定
							proxy:SetReserveDmyPolyIDByTempJr(0);--予約ダミポリを初期化(再検索用？)
						elseif proxy:GetEventGoalState( JrID ) == 1 then--ゴールが成功なら取り付く
						--ウェイトがまだあるなら目的地到着						
							--local rand = proxy:GetRandom(2,4);						
							if proxy:Attach_PhalanxJr(JrID) == true then
								--取り合えず吸着
								--print("ID:",JrID," 目的地到着")
								proxy:PlayAnimation(JrID,602);
								proxy:SetTempJrWait(2);--3秒間
								proxy:SetTempJrState(JR_STATE_HoverMove);							
								proxy:DisableInterupt(JrID,false);
							else
								--print("取り付き失敗再検索:",JrID);
								proxy:SetTempJrState( JR_STATE_Normal );	--状態を通常に
								proxy:SetBossUnitJrHit(JrID, false );
								proxy:SetTempJrWait(rand);	--生成したランダムウェイトを設定
								proxy:SetReserveDmyPolyIDByTempJr(0);--予約ダミポリを初期化(再検索用？)							
							end
						else
							print("変な奴がいる！",JrID);
							proxy:SetTempJrState( JR_STATE_Normal );	--状態を通常に
							proxy:SetBossUnitJrHit(JrID, false );
							proxy:SetTempJrWait(rand);	--生成したランダムウェイトを設定
							proxy:SetReserveDmyPolyIDByTempJr(0);--予約ダミポリを初期化(再検索用？)
						end					
					end
					
				--ダミポリへのホバー移動
				elseif state == JR_STATE_HoverMove then
					--ダミポリへのホバー吸着への条件判定				
					if proxy:IsTempJrNoWait() == true then--ウェイトが無くなれば次の状態へ					
						proxy:SetTempJrState(JR_STATE_DmyAttach);
						proxy:SetTempJrWait(1);															
					end
					
				--ダミポリへのホバー吸着
				elseif state == JR_STATE_DmyHover then
					--ダミポリへの完全吸着への条件判定
				
				--ダミポリへの完全吸着
				elseif state == JR_STATE_DmyAttach then
					--ダミポリからの切り離しへの条件判定
					if proxy:IsTempJrNoWait() == true then
						if proxy:CheckEventChr_Proxy(JrID,3001) == true then
							--if proxy:IsLimitOver_ByTempJr() == true then
							--if PHALANXCORE_STATE == PHALANX_Jr_Totugeki then
								proxy:PlayAnimation(JrID,9015);
								proxy:EventIdDetach_PhalanxJr(JrID);
								proxy:SetTempJrState( JR_STATE_HavokFly );
							--end
							--end
						end
					end							
				--Havok剥がれ		
				elseif state == JR_STATE_HavokFly then
					--安定したら通常へ
					if proxy:IsBalanceByTempJr() == true then					
						--proxy:SetTempJrState( JR_STAET_Reverse );	--転倒アニメ再生へ
						local rand = proxy:GetRandom(PHALANXTIMER_NormalMin,PHALANXTIMER_NormalMax);		--乱数生成
						proxy:SetTempJrWait(rand);					--乱数ウェイト設定
						proxy:SetTempJrState( JR_STATE_Normal );	--通常状態に
					end
				elseif state == JR_STATE_Dead then--死亡状態更新に
					proxy:EventIdDetach_PhalanxJr(JrID);			
					proxy:ForceDead_ByJrId(JrID,JR_STATE_Dead);				
				end				
			else--死んでいたら
				proxy:SetTempJrState( JR_STATE_Dead );	--死亡状態更新に				
			end
		end
	end
	return false;
	--print(" end");
end

--------------------------------------------------------------------------------------
--4175■空
--------------------------------------------------------------------------------------
function OnEvent_4175(proxy,param)
	print("OnEvent_4175 begin");
	print("呼ばれる事は無いはずのイベントが発動しています");
	--呼ばれる事は無いはず
	print("OnEvent_4175 end");
end

--------------------------------------------------------------------------------------
--4176■ボスアタリ化
--------------------------------------------------------------------------------------
function OnEvent_4176(proxy,param)
	print("OnEvent_4176 begin");
	--param3　変更したいキャラのID
	if param:IsNetMessage() == true then
		proxy:SetBossUnitJrHit( param:GetParam3(),true);
	end
	
	print("OnEvent_4176 end");
end

--------------------------------------------------------------------------------------
--4177■通常アタリ化
--------------------------------------------------------------------------------------
function OnEvent_4177(proxy,param)
	print("OnEvent_4177 begin");
	--param3 変更したいキャラのID
	if param:IsNetMessage() == true then
		proxy:SetBossUnitJrHit( param:GetParam3(),false);
	end	
	print("OnEvent_4177 end");
end

function OnEvent_4177_Doping(proxy,param)
	proxy:EraseEventSpecialEffect_2(param:GetParam2(), 5066 );
end
--~ --------------------------------------------------------------------------------------
--~ --■
--~ --------------------------------------------------------------------------------------
--~ function (proxy,param)
--~ 	print(" begin");
--~ 	print(" end");
--~ end

