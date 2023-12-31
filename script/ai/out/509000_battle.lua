-----------------------------------------------------------------------------------------------
--	Hiru509000専用戦闘
--	説明：色々ぐちゃぐちゃだけど、とりあえず攻撃対応はしておく
--　　　　遠距離攻撃の対応とか
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Hiru509000_Battle, "Hiru509000Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Hiru509000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function Hiru509000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------
local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離
local fate = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　その３
local sekkin = ai:GetRandam_Float(0.75, 1.5)			--接近する距離
local maai = ai:GetRandam_Float(0.75, 1.5)				--間合い調整する距離
local hprate = ai:GetHpRate( TARGET_SELF )			--自分のHPの残量を取得

local farDist = 20.0		--遠いと判断する距離
local nearDist = 14.0		--近いと判断する距離
local maaiDist = 5.0		--攻撃のために近づく距離　★汎用化の為、攻撃ごとに分けず★

	-- 最初にちょっとだけ待つ
	if ai:IsFinishTimer(0) == true then
		local firstTime = ai:GetRandam_Float(0.0, 3.0)			--最初の動き出しまでの時間
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
		ai:SetTimer( 0, 9999.0 );
	end

--[[特定領域に居るときに強制的にヒル復活をする]]

local		Wait_time	=	2.0				--回復の待ち時間

	if	ai:IsInsideTargetRegion( TARGET_ENE_0, 2020 ) 
		or ai:IsInsideTargetRegion( TARGET_ENE_0, 2021 ) 
		or ai:IsInsideTargetRegion( TARGET_ENE_0, 2022 )
		or ai:IsInsideTargetRegion( TARGET_ENE_0, 2023 ) then
		goal:AddSubGoal( GOAL_COMMON_Wait, Wait_time, TARGET_ENE_0);
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);
	else

	--近くないなら
	if targetDist >= nearDist then
--~ 		--100% 待機
--~ 		goal:AddSubGoal( GOAL_COMMON_Wait, 0.1, TARGET_ENE_0);
		
		if hprate < 0.95 then
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);
			
		else
			if fate2 < 90 then
				goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_ENE_0);
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3020, TARGET_ENE_0, DIST_None, 0);
				
			end
		end
		
--~ 		--75％　歩き接近→10％　回り込み＆再接近
--~ 		--25％　歩き接近→暴れる→攻撃後行動
--~ 		if fate < 75 then
--~ 			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
--~ 			if fate2 < 10 then
--~ 				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
--~ 				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
--~ 			end
--~ 			
--~ 		else
--~ 			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 1.50, TARGET_ENE_0, true, -1 );
--~ 			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3020, TARGET_ENE_0, DIST_Near, 0);
--~ 			Hiru509000Battle_Kougeki_Noato(ai, goal)
--~ 		end
		
	--近いなら
	elseif targetDist >= maaiDist then
		--30% 待機
		--70% 遠距離（蛭玉）攻撃
		
		if fate < 30 then
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
		
		else
			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3040, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.0, TARGET_ENE_0);
		
		end
		
--~ 		--60％　歩き接近→回り込み＆再接近　　40％　さらに接近→50%暴れる50%右腕で殴る�
--~ 		if fate < 60 then
--~ 			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
--~ 			if fate2 < 50 then
--~ 				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
--~ 				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
--~ 			end
--~ 		else
--~ 			goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, 0.3, 0.8, TARGET_ENE_0, true, -1 );
--~ 			if fate2 < 50 then
--~ 				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3020, TARGET_ENE_0, DIST_Near, 0);
--~ 			else
--~ 				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
--~ 		end
		
	else
	--間合い以内なら
		--攻撃する
		--攻撃後行動
		Hiru509000Battle_Kougeki(ai, goal)
		Hiru509000Battle_Kougeki_Noato(ai, goal)
	end
	end
end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function Hiru509000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--20% 3000　ビンタ
	--10% 3030　蛭まみれ攻撃
	--30% 3000-3010　ビンタ＆腕を振り回す�
	--30% 3020　激しく暴れる
	--10% 3040　蛭玉

		--イベントから条件を拾ってきて、ヒル復活
	if (ai:GetEventRequest( 0 ) == AI_EVENT_LEECH_REGENERATE) then

		--ヒル復活
		Hiru509000Battle_Hukkatsu(ai, goal)
		Hiru509000Battle_Kougeki_Pettern(ai, goal)
--		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);

	else
	
		--通常攻撃
		Hiru509000Battle_Kougeki_Pettern(ai, goal)
	
--		if K_fate < 20 then
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);

--		elseif K_fate < 30 then
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Near, 0);
			
--		elseif K_fate < 60 then
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Near, 0);
			
--		elseif K_fate < 90 then
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
			
--		else
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_None, 0);
			
--		end
		
	end
end

---------------------------------------------------------
--  通常攻撃
---------------------------------------------------------
function Hiru509000Battle_Kougeki_Pettern(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	if K_fate < 20 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);

	elseif K_fate < 30 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Near, 0);
			
	elseif K_fate < 60 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Near, 0);
			
	elseif K_fate < 90 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_None, 0);
	
	end

end


---------------------------------------------------------
--  ヒル復活
---------------------------------------------------------
function Hiru509000Battle_Hukkatsu(ai, goal)

local hprate = ai:GetHpRate( TARGET_SELF )	--自分のHP割合を取得
local fate = ai:GetRandam_Int(1,100)		--確率判定用
local fate2 = ai:GetRandam_Int(1,100)		--確率判定用2
local fate3 = ai:GetRandam_Int(1,100)		--確率判定用3
local fate4 = ai:GetRandam_Int(1,100)		--確率判定用4


--[[HPの残り割合を見てヒル復活の頻度を変える]]

local		HPLevel1 = 0.85					--HPの残量レベル１　85%以上
local		HPLevel2 = 0.60					--HPの残量レベル２	60%以上		
local		HPLevel3 = 0.35					--HPの残量レベル３	35%以上
local		HPLevel4 = 0.0					--HPの残量レベル４	0%以上

local		RecoveryPer1 = 25				--HP残量レベル１のときのヒル復活確率
local		RecoveryPer2 = 40				--HP残量レベル２のときのヒル復活確率
local		RecoveryPer3 = 55				--HP残量レベル３のときのヒル復活確率
local		RecoveryPer4 = 80				--HP残量レベル４のときのヒル復活確率


	if hprate >= HPLevel1 then
		
		if (fate <= RecoveryPer1) then
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);
		else
			Hiru509000Battle_Kougeki_Pettern(ai, goal)
		end
	
	elseif hprate >= HPLevel2 then
	
		if (fate2 <= RecoveryPer2) then
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);
		else
			Hiru509000Battle_Kougeki_Pettern(ai, goal)
		end
	
	elseif hprate >= HPLevel3 then
	
		if (fate3 <= RecoveryPer3) then
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);
		else
			Hiru509000Battle_Kougeki_Pettern(ai, goal)
		end	
	
	else
		
		if (fate4 <= RecoveryPer4) then
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);
		else
			Hiru509000Battle_Kougeki_Pettern(ai, goal)
		end

	end

end
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function Hiru509000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local SideTime = 0.5							--横に動く時間
local BackDist = ai:GetRandam_Float(0.75, 1.5)	--後退する距離
local BackTime = 0.5							--後退する時間


local bRight = ai:GetRandam_Int(0,1);							--左右移動の方向
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- 同じ方向に左右移動している仲間の数



--後ろに下がった後にときどき横移動させると良いかも
--あまりに近すぎる横移動よりも、すこし下がってから横移動させると良いかも

	--100% なにもしない
	--0% 適当に横に移動
	--0% 後ろに移動
	if KN_fate < 100  and friendNum < 1 then
		goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
--~ 		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 10, true, true ,-1 );
	elseif KN_fate < 100  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end



---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function Hiru509000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function Hiru509000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function Hiru509000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字
local maaiDist = 1.0										--攻撃のために近づく距離　★汎用化の為、攻撃ごとに分けず★

	--空振り追い討ち
	--25％　近くのターゲットが空振りしたら攻撃
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < maaiDist then
			if fate <= 25 then
				goal:ClearSubGoal();
				Hiru509000Battle_Kougeki(ai, goal)
				Hiru509000Battle_Kougeki_Noato(ai, goal)
				return true;
			end	
		end
	end
	
	
--~ 	--飛び道具を撃ってきたら最適行動
--~ 	if ai:IsInterupt( INTERUPT_Shoot ) then
--~ local shootIntPer = 100						--飛び道具使用時に最適行動を取る確率
--~ local hprate = ai:GetHpRate( TARGET_SELF )	--自分のHPの残量を取得
--~ 		if fate <= shootIntPer then
--~ 			if targetDist >= 14.0 then
--~ 				if hprate <= 0.95 then
--~ 				goal:ClearSubGoal();
--~ 				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);
--~ 				end
--~ 			end
--~ 			return true;
--~ 		end
--~ 	end

return false;

end
