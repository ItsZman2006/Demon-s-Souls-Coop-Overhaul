-----------------------------------------------------------------------------------------------
--	Test10004専用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Test10004_Battle, "Test10004Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Test10004_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function Test10004Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )
	--自分のHP割合を取得
local targethprate = ai:GetHpRate( TARGET_ENE_0 )
	--敵ターゲットのHP割合を取得
local targetDist = ai:GetDist(TARGET_ENE_0);
	--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)
	--確率判定で使用する運命の数字

----------------
--●戦闘行動●--
----------------

	if targetDist <= 4.5 then
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 0.5 , TARGET_ENE_0, true );
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3000, TARGET_ENE_0, DIST_Far, 0);
--		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, POINT_INITIAL, AI_DIR_TYPE_CENTER, 0.0, TARGET_ENE_0, true );

		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 0.5 , TARGET_ENE_0, true );
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3001, TARGET_ENE_0, DIST_Far, 0);
--		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, POINT_INITIAL, AI_DIR_TYPE_CENTER, 0.0, TARGET_ENE_0, true );

		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 0.5 , TARGET_ENE_0, true );
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3002, TARGET_ENE_0, DIST_Far, 0);
--		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, POINT_INITIAL, AI_DIR_TYPE_CENTER, 0.0, TARGET_ENE_0, true );
		
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 0.5 , TARGET_ENE_0, true );		
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3300, TARGET_ENE_0, DIST_Far, 0);
--		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, POINT_INITIAL, AI_DIR_TYPE_CENTER, 0.0, TARGET_ENE_0, true );
		
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 0.5 , TARGET_ENE_0, true );
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9800, TARGET_ENE_0, DIST_Far, 0);
--		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, POINT_INITIAL, AI_DIR_TYPE_CENTER, 0.0, TARGET_ENE_0, true );
		
	else
		goal:AddSubGoal(GOAL_COMMON_Wait, 5.0, 0, 0, 0, 0);
	end
	
end



---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function Test10004Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function Test10004Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function Test10004Battle_Interupt(ai, goal)

	return false;
end
