-----------------------------------------------------------------------------------------------
--	大蜘蛛用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_kumo510000_Battle, "kumo510000Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_kumo510000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function kumo510000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------
local fate0     = ai:GetRandam_Int(1,100)               --確率判定で使用する運命の数字
local fate1     = ai:GetRandam_Int(1,100)               --確率判定で使用する運命の数字
local fate2     = ai:GetRandam_Int(1,100)               --確率判定で使用する運命の数字

--~ -- 待機状態の更新
--~ --プレイヤーがトンネルにいる(slot0)
--~ if( ai:GetEventRequest( 0 ) == AI_EVENT_STAY_TUNNEL ) then
--~     -- かがみ待機
--~     ai:ChangeMoveAnimParam(1);

--~ --プレイヤーが部屋に入ってきてる(slot0)
--~ elseif( ai:GetEventRequest( 0 ) == AI_EVENT_STAY_ROOM ) then
--~     -- 通常の立ち待機
--~     ai:ChangeMoveAnimParam(0);
--~ end

--ファイヤーボール１　低速
--ファイヤーボール２　近距離3WAY
--蜘蛛の糸１　高速
--蜘蛛の糸２　近距離2WAY


-- 攻撃
--プレイヤーがトンネルの中央・奥にいる(slot1)
--~ elseif( ai:GetEventRequest( 1 ) == AI_EVENT_TUNNEL_CENTER ) then
if ai:IsInsideTargetRegion( TARGET_ENE_0, 2090) then
    if( fate0 <= 40 ) then
		--ファイヤーボール１
		if fate1 <= 20 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6020, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.0, TARGET_ENE_0);
		--ファイヤーボール２　３連射して休憩
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6021, TARGET_ENE_0, DIST_None, 0);			
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6021, TARGET_ENE_0, DIST_None, 0);			
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6021, TARGET_ENE_0, DIST_None, 0);			
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
		end
    else
		--蜘蛛の糸１→ファイヤーボール１
		if fate1 <= 20 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6050, TARGET_ENE_0, DIST_None, 0);     
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6020, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		--蜘蛛の糸２→ファイヤーボール１
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6051, TARGET_ENE_0, DIST_None, 0);     
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6020, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		end
	end
	
--プレイヤーがトンネルの中央・手前にいる(slot1)
--~ if( ai:GetEventRequest( 1 ) == AI_EVENT_TUNNEL_RIGHT ) then
elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2091) then
    if( fate0 <= 60) then
		--ファイヤーボール１
		if fate1 <= 80 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6020, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.0, TARGET_ENE_0);
		--ファイヤーボール２　３連射して休憩
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6021, TARGET_ENE_0, DIST_None, 0);			
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6021, TARGET_ENE_0, DIST_None, 0);			
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6021, TARGET_ENE_0, DIST_None, 0);			
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
		end
    else
		--蜘蛛の糸１→ファイヤーボール１
		if fate1 <= 80 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6050, TARGET_ENE_0, DIST_None, 0);     
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6020, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		--蜘蛛の糸２→ファイヤーボール１
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6051, TARGET_ENE_0, DIST_None, 0);     
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6020, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		end
	end


--プレイヤーがトンネルの右端・奥にいる(slot1)
--~ if( ai:GetEventRequest( 1 ) == AI_EVENT_TUNNEL_RIGHT ) then
elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2080) then
    if( fate0 <= 40) then
		--ファイヤーボール１
		if fate1 <= 20 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6000, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.0, TARGET_ENE_0);
		--ファイヤーボール２　３連射して休憩
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6001, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6001, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6001, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
		end
    else
		--蜘蛛の糸１→ファイヤーボール１
		if fate1 <= 20 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6030, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6000, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		--蜘蛛の糸２→ファイヤーボール１
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6031, TARGET_ENE_0, DIST_None, 0);			
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6000, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		end
	end
	
	
--プレイヤーがトンネルの右端・手前にいる(slot1)
--~ if( ai:GetEventRequest( 1 ) == AI_EVENT_TUNNEL_RIGHT ) then
elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2081) then
    if( fate0 <= 60) then
		--ファイヤーボール１
		if fate1 <= 80 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6000, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.0, TARGET_ENE_0);
		--ファイヤーボール２　３連射して休憩
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6001, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6001, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6001, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
		end
    else
		--蜘蛛の糸１→ファイヤーボール１
		if fate1 <= 80 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6030, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6000, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		--蜘蛛の糸２→ファイヤーボール１
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6031, TARGET_ENE_0, DIST_None, 0);			
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6000, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		end
	end

--プレイヤーがトンネルの左端・奥にいる(slot1)
--~ elseif( ai:GetEventRequest( 1 ) == AI_EVENT_TUNNEL_LEFT ) then
elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2100) then
    if( fate0 <= 40) then
		--ファイヤーボール１
		if fate1 <= 20 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6010, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.0, TARGET_ENE_0);
		--ファイヤーボール２　３連射して休憩
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6011, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6011, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6011, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
		end
	else
		--蜘蛛の糸１→ファイヤーボール１
		if fate1 <= 20 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6040, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6010, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		--蜘蛛の糸２→ファイヤーボール１
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6041, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6010, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		end
	end

--プレイヤーがトンネルの左端・手前にいる(slot1)
--~ elseif( ai:GetEventRequest( 1 ) == AI_EVENT_TUNNEL_LEFT ) then
elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2101) then
    if( fate0 <= 50) then
		--ファイヤーボール１
		if fate1 <= 80 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6010, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.0, TARGET_ENE_0);
		--ファイヤーボール２　３連射して休憩
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6011, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6011, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6011, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
		end
	else
		--蜘蛛の糸１→ファイヤーボール１
		if fate1 <= 80 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6040, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6010, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		--蜘蛛の糸２→ファイヤーボール１
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, 6041, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 6010, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
		end
	end
	
	
--プレイヤーが部屋内部の中央にいる(slot1)
--~ elseif( ai:GetEventRequest( 1 ) == AI_EVENT_ROOM_CENTER ) then
elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2120) then

	--60% 近距離殴り
	--0% 近距離炎
	if fate2 <= 100 then
		goal:AddSubGoal( GOAL_kumo510000_FeelerAttack, 5);
		goal:AddSubGoal( GOAL_COMMON_Wait, ai:GetRandam_Float (0.3,0.6) ,0,0,0,0)
	else
		goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 5.0, 3060, TARGET_ENE_0, DIST_None, 0);
		goal:AddSubGoal( GOAL_COMMON_Wait, ai:GetRandam_Float (2.2,4.5) ,0,0,0,0)
	end
		
--プレイヤーが部屋内部の右側にいる(slot1)
--~ elseif( ai:GetEventRequest( 1 ) == AI_EVENT_ROOM_RIGHT ) then
elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2110) then
    goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);

--プレイヤーが部屋内部の左側にいる(slot1)
--~ elseif( ai:GetEventRequest( 1 ) == AI_EVENT_ROOM_LEFT ) then
elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2130) then
    goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 5.0, 3010, TARGET_ENE_0, DIST_None, 0);

-- 上記全てに当てはまらない場合
else
--~ 	goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 5.0, 3020, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Wait, 0.1, TARGET_ENE_0);
	end
end	

---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function kumo510000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function kumo510000Battle_Terminate(ai, goal)
end

---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function kumo510000Battle_Interupt(ai, goal)

return false;
end





			


