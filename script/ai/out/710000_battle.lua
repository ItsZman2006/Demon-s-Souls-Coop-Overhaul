-----------------------------------------------------------------------------------------------
--	乞食（男）用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_kojiki710000_Battle, "kojiki710000_Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( kojiki710000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function kojiki710000_Battle_Activate(ai, goal)
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
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			
						
		--遠くもないが近くもないなら
		elseif targetDist >= nearDist then
			--80％　走って近づく
			--20％　歩いて近づく
			if fate < 80 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			else
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			end
			
		--近いなら	
		elseif targetDist >= maaiDist then
			--100％　歩いて近づく
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			
		--間合い以内なら
		else
			--攻撃する
			kojiki710000_Battle_Kougeki(ai, goal)
			
			--攻撃後行動
			kojiki710000_Battle_Kougeki_Noato(ai, goal)
			
		end
	end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function kojiki710000_Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--80% 3000
	--20% 3000
	if K_fate < 60 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		
	end
end

	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function kojiki710000_Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local SideDist = 2.5							--横に動く距離
local SideTime = 5.0							--横に動く時間
local BackDist = 1.0							--後退する距離
local BackTime = 5.0							--後退する時間
local bRight = ai:GetRandam_Int(0,1);			--右か左か
	
	--50% 適当に横に移動(ガード無し)
	--50% 後ろに移動(ガードなし)
	if  (KN_fate < 70) then
	    goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
	else
		goal:AddSubGoal( GOAL_COMMON_KeepDist, 1, TARGET_ENE_0, 0.0, 10.0, TARGET_ENE_0, true, -1 );				
	end
end

	
	
---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function kojiki710000_Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function kojiki710000_Battle_Terminate(ai, goal)
end

---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function kojiki710000_Battle_Interupt(ai, goal)

return false;
end





			


	