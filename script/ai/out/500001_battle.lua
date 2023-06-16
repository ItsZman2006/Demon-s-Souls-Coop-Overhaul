-----------------------------------------------------------------------------------------------
--	FaranCIBI_B500001専用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_FaranCIBI_B500001_Battle, "FaranCIBI_B500001Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_FaranCIBI_B500001_Battle, 1 );



---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function FaranCIBI_B500001Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離
local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用

	--遠いなら射撃
	if targetDist >= 3.0 then
		goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3010, TARGET_ENE_0, DIST_None, 0);
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(0.5, 1.5), TARGET_NONE, 0, 0, 0 );
		
	--中くらいの距離なら射撃or接近
--	elseif targetDist >= 4.0 then
--		if fate <= 60 then
--			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3010, TARGET_ENE_0, DIST_None, 0);
--			goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(0.5, 1.5), TARGET_NONE, 0, 0, 0 );	
--		else
--			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 3.0, TARGET_ENE_0, false, -1 );
--		end
		
	--近いなら近接攻撃	
	else
--		goal:AddSubGoal( GOAL_COMMON_KeepDist, 5.0, TARGET_ENE_0, 0.5, 3.0, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3030, TARGET_ENE_0, DIST_None, 0);
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(0.0, 1.0), TARGET_NONE, 0, 0, 0 );
	end
end



---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function FaranCIBI_B500001Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function FaranCIBI_B500001Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function FaranCIBI_B500001Battle_Interupt(ai, goal)
return false;

end
