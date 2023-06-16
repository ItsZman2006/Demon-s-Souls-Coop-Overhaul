-----------------------------------------------------------------------------------------------
--	暗殺者用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Ansatu203000_Battle, "ansatu203000Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Ansatu203000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function ansatu203000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その３

local farDist = 15.0				--うんと遠いと判断する距離
local nearDist = 6.0				--近いと判断する距離
local maaiDist = 1.0				--攻撃のために近づく距離　★汎用化の為、攻撃ごとに分けず★
local AttHanyouDist = 1.5			--汎用攻撃関数を実行する距離
local Att3004Dist = 6.0				--攻撃3004を実行する距離

local role = ai:GetTeamOrder(ORDER_TYPE_Role);					--自分の役割を取得

	--攻撃役、その他役なら
	if role == ROLE_TYPE_Attack or role == ROLE_TYPE_None then
		--遠いなら
		if targetDist >= farDist then
			--60％　適切な間合いでナイフ投げをする
			if fate2 < 60 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3004Dist, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3004, TARGET_ENE_0, DIST_Far, 0);
				if fate3 < 50 then
					goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3004, TARGET_ENE_0, DIST_Far, 0);
				end
				
			--40％　適切な間合いで汎用攻撃をし、攻撃後行動をする
			else
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, AttHanyouDist, TARGET_ENE_0, false, -1 );
				ansatu203000Battle_Kougeki(ai, goal)
				ansatu203000Battle_Kougeki_Noato(ai, goal)
				
			end
			
		--遠くもないが近くもないなら
		elseif targetDist >= nearDist then
			--一定確率でナイフを投げてから、走って近づく
			if fate2 < 75 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3004, TARGET_ENE_0, DIST_Far, 0);
				if fate3 < 50 then
					goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3004, TARGET_ENE_0, DIST_Far, 0);
				end
			end
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
			
		--近いなら	
		elseif targetDist >= maaiDist then
			--100％　走って歩いて近づく
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
			
		--間合い以内なら
		else
			--攻撃する
			ansatu203000Battle_Kougeki(ai, goal)
			
			--攻撃後行動
			ansatu203000Battle_Kougeki_Noato(ai, goal)
			
		end
		
	--取り巻き役なら
	elseif role == ROLE_TYPE_Torimaki then
		--５ｍまで走って近づく
		--少しだけ横移動
		--50％　４ｍまで遠ざかる
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 5.0, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 15, true, true ,-1 );
		if fate < 50 then
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, true, -1 );				
		end		
		
	--観衆役なら
	else
		--９ｍまで走って近づく
		--少しだけ横移動
		--50％　８ｍまで遠ざかる
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 9.0, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 15, true, true ,-1 );
		if fate < 50 then
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 8.0, TARGET_ENE_0, true, -1 );				
		end
	end	

end


---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function ansatu203000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)							--確率判定で使用する運命の数字
local K_fate2 = ai:GetRandam_Int(1,100)							--確率判定で使用する運命の数字　その２

	--１５％　3000-3001-3002
	--１５％　3000-3001-3300-(3002)	
	--１０％　3000-3300-3001-(3002)	
	--２０％　3001-3002-(3300)	
	--２０％　3002-3001-3000-(3001)	
	--２０％　3300-3001-(3002)	
	if K_fate < 15 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif K_fate < 30 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		if K_fate2 < 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	elseif K_fate < 40 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		if K_fate2 < 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	elseif K_fate < 60 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		if K_fate2 < 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	elseif K_fate < 80 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		if K_fate2 < 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		if K_fate2 < 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		end
	end
	
end


---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function ansatu203000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local KN_fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２
local KN_fate3 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その３
local SideDist = 2.5							--横に動く距離
local SideTime = 5.0							--横に動く時間
local BackDist = 2.5							--後退する距離
local BackTime = 5.0							--後退する時間


local bRight = ai:GetRandam_Int(0,1);			--左右移動の方向
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- 同じ方向に左右移動している仲間の数



--後ろに下がった後にときどき横移動させると良いかも
--あまりに近すぎる横移動よりも、すこし下がってから横移動させると良いかも

	--20% なにもしない（ちょっとだけ横移動）
	--40% バックステップ１回or２回
	--40% バックステップ０回or１回のあとサイドステップ
	if KN_fate < 20  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
		
	elseif KN_fate < 60 then
		goal:AddSubGoal(GOAL_COMMON_Step, 5.0, 701, 0, 0, 0);
		if KN_fate2 < 50 then
			goal:AddSubGoal(GOAL_COMMON_Step, 5.0, 701, 0, 0, 0);
		end
		
	else
		if KN_fate2 < 50 then
			goal:AddSubGoal(GOAL_COMMON_Step, 5.0, 701, 0, 0, 0);
		end	
		goal:AddSubGoal(GOAL_COMMON_Step, 5.0, ai:GetRandam_Int(702,703), 0, 0, 0);		
		
	end
end

	
	
---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function ansatu203000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function ansatu203000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function ansatu203000Battle_Interupt(ai, goal)

return false;
end



	