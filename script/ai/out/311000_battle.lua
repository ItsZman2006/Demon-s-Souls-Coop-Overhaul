-----------------------------------------------------------------------------------------------
--	結晶トカゲ用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_tokage311000_Battle, "tokage311000_Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_tokage311000_Battle, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_tokage311000_Battle, true);


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function tokage311000_Battle_Activate(ai, goal)
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
			
				goal:AddSubGoal( GOAL_COMMON_Wait, 5.0, TARGET_NONE, 0, 0, 0 );
			
						
		--遠くもないが近くもないなら
		elseif targetDist >= nearDist then
			--50％　逃げる
			--50％　逃げる
			if fate < 50 then
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, 10.0, TARGET_SELF, false, -1 );
			else
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, 10.0, TARGET_SELF, false, -1 );
			end
			
		--近いなら	
		elseif targetDist >= maaiDist then
			--走って逃げる
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, 10.0, TARGET_SELF, false, -1 );
			
		--間合い以内なら
		else
			--走って逃げる
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, 10.0, TARGET_SELF, false, -1 );
						
		end
	end

---------------------------------------------------------
--  攻撃　※08.05.06　使っていません
---------------------------------------------------------
function tokage311000_Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--80% 3000
	--20% 3000-3001-3002
	if K_fate < 60 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0); 
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
	end
end

	
	
---------------------------------------------------------
--  攻撃後の行動　※08.05.06　使っていません
---------------------------------------------------------
function tokage311000_Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local SideDist = 2.5							--横に動く距離
local SideTime = 5.0							--横に動く時間
local BackDist = 1.0							--後退する距離
local BackTime = 5.0							--後退する時間
local bRight = ai:GetRandam_Int(0,1);			--右か左か
-- 同じ方向に左右移動している仲間の数
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);

	
	--50% 適当に横に移動(ガード無し)
	--50% 後ろに移動(ガードなし)
	if  KN_fate < 70 and friendNum < 1 then
	    goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
	else
		goal:AddSubGoal( GOAL_COMMON_KeepDist, 1, TARGET_ENE_0, 0.0, 10.0, TARGET_ENE_0, true, -1 );				
	end
end

	
	
---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function tokage311000_Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function tokage311000_Battle_Terminate(ai, goal)
end

---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function tokage311000_Battle_Interupt(ai, goal)

return false;
end





			


	