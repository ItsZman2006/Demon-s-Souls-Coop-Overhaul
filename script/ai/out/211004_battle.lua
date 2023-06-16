-----------------------------------------------------------------------------------------------
--	ウロコ鉱夫（獄吏手下、袋）用戦闘
--	説明：左右に動いて獄吏への接近を妨害
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_uroko211004_Battle, "uroko211004_Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_uroko211004_Battle, 1 );
-- 割り込まない。
REGISTER_GOAL_NO_INTERUPT( GOAL_uroko211004_Battle, true);

---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function uroko211004_Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得
local targethprate = ai:GetHpRate( TARGET_ENE_0 )	--敵ターゲットのHP割合を取得
local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２

local farDist = 15.0		--うんと遠いと判断する距離
local nearDist = 4.0		--近いと判断する距離
local maaiDist = 1.5		--攻撃のために近づく距離　★汎用化の為、攻撃ごとに分けず★
local bRight = ai:GetRandam_Int(0,1);			--右か左か
local SideDist = 2.5							--横に動く距離
local SideTime = 5.0							--横に動く時間

        
		-- 命令が来ている場合は移動タイプを変える
		if ai:GetTeamRecordCount(COORDINATE_TYPE_AttackOrder, TARGET_ENE_0, 100.0) >= 1 then
		else
		end
		
		-- 命令が来ていなければ待機
		if ai:GetTeamRecordCount(COORDINATE_TYPE_AttackOrder, TARGET_ENE_0, 100.0) <= 0 then
			-- 命令がないので採掘
			ai:ChangeMoveAnimParam(0)
			-- その場で作業
			goal:AddSubGoal( GOAL_COMMON_Wait, 5.0, TARGET_ENE_NONE, 0, 0, 0 );
		else
			-- 命令が来ていたので通常戦闘

			-- 命令が着ているので通常移動アニメに切り替え
			ai:ChangeMoveAnimParam(1)
			
			--遠いなら
			if targetDist >= farDist then
				
				--歩いて近づく
						
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, nearDist, TARGET_ENE_0, true, -1 );
				
							
			--遠くもないが近くもないなら
			elseif targetDist >= nearDist then
			
				--右に動いてから歩いて近づく
				if fate < 40 then
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, true, 20.0, true, true, -1);
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );

				--左に動いてから歩いて近づく
				elseif fate < 80 then 
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, false, 10.0, true, true, -1);
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
				--歩いて近づく
				else
				    goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 2.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			end
				
			--近いなら	
			elseif targetDist >= maaiDist then
			
				--右に動いてから歩いて近づく
				if fate2 < 40 then
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, true, 10.0, true, true, -1);
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
				
				--左に動いてから歩いて近づく
				elseif fate2 < 80 then 
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, false, 20.0, true, true, -1);
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
				
				--歩いて近づく
				else
				    goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 2.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			end
			
			--間合い以内なら
			else
				--攻撃する
				uroko211004_Battle_Kougeki(ai, goal)
				
				--攻撃後行動
				uroko211004_Battle_Kougeki_Noato(ai, goal)
				
			end
		end
	end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function uroko211004_Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--80% 3000
	--20% 3000-3001
	if K_fate < 50 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, AI_DIST_TYPE_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, AI_DIST_TYPE_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, AI_DIST_TYPE_Middle, 0);
	
	end
end

	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function uroko211004_Battle_Kougeki_Noato(ai, goal)

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
	    goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, bRight, ai:GetRandam_Int(30,45), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end

	
	
---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function uroko211004_Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function uroko211004_Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function uroko211004_Battle_Interupt(ai, goal)
	return false;
end

			


	