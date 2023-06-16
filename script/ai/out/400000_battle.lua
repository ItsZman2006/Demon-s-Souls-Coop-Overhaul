----------------------------------------------------------------------------------------------
--	なりそこない用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Narisoko400000_Battle, "narisoko400000Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Narisoko400000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function narisoko400000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targethprate = ai:GetHpRate( TARGET_ENE_0 )		--敵ターゲットのHP割合を取得
local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　その２

	if fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 2.3, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);		
	else
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 1.2, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);		
	end
	
	if fate <= 50 then
		goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
	end


end

	
---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function narisoko400000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function narisoko400000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function narisoko400000Battle_Interupt(ai, goal)

return false;
end



	