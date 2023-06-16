-----------------------------------------------------------------------------------------------
--	クマムシ用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_kuma313000_Battle, "kuma313000_Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( kuma313000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function kuma313000_Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得
local targethprate = ai:GetHpRate( TARGET_ENE_0 )	--敵ターゲットのHP割合を取得
local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２

local farDist = 15.0		--うんと遠いと判断する距離
local nearDist = 4.0		--近いと判断する距離
local maaiDist = 1.0		--攻撃のために近づく距離　★汎用化の為、攻撃ごとに分けず★

local role = ai:GetTeamOrder(ORDER_TYPE_Role);					--自分の役割を取得


		--遠いなら
		if targetDist >= farDist then
			
			--80％　３ｍほど歩いてから走って近づく
			--20％　走って近づく
			
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, (targetDist - 3.0), TARGET_ENE_0, true, -1 );
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, nearDist, TARGET_ENE_0, true, -1 );
			
						
		--遠くもないが近くもないなら
		elseif targetDist >= nearDist then
			--80％　歩いて近づく
			--20％　歩いて近づく
			if fate < 80 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, nearDist, TARGET_ENE_0, true, -1 );
			else
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, nearDist, TARGET_ENE_0, true, -1 );
			end
			
		--近いなら	
		elseif targetDist >= maaiDist then
			--歩いて近づく
			--ジャンプ攻撃する
			if fate < 60 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			else
--~ 				goal:AddSubGoal(GOAL_COMMON_Step, 5, 700, 0, 0, 0);
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
			end
		--間合い以内なら
		else
			--攻撃する
			kuma313000_Battle_Kougeki(ai, goal)
			
			--攻撃後行動
			kuma313000_Battle_Kougeki_Noato(ai, goal)
			
		end
	end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function kuma313000_Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--70% 3000
	--20% 3001
	--10% 3002
	if K_fate < 70 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);

	elseif K_fate < 90 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	else
--~ 		goal:AddSubGoal(GOAL_COMMON_Step, 5, 700, 0, 0, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
	end
end

	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function kuma313000_Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local SideDist = 2.5							--横に動く距離
local SideTime = 5.0							--横に動く時間
local BackDist = 1.0							--後退する距離
local BackTime = 5.0							--後退する時間
local bRight = ai:GetRandam_Int(0,1);			--右か左か
-- 同じ方向に左右移動している仲間の数
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);

	
	--待機 
	--待機
	if  KN_fate < 70 and friendNum < 1 then
	    goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_NONE, 0, 0, 0 );
	else
		goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_NONE, 0, 0, 0 );				
	end
end

	
	
---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function kuma313000_Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function kuma313000_Battle_Terminate(ai, goal)
end

---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function kuma313000_Battle_Interupt(ai, goal)

return false;
end





			


	