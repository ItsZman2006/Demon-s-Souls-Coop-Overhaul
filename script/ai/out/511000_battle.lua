-----------------------------------------------------------------------------------------------
--	鉱石の精霊用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_seirei511000_Battle, "seirei511000Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_seirei511000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function seirei511000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------
local targetDist = ai:GetDist(TARGET_ENE_0);	--ターゲットとの距離を取得
local Normal_ATK_Dist = 0.7						--攻撃の届く距離
local TAEGET_DIR = 40							--攻撃の届く角度

	if targetDist >= Normal_ATK_Dist then
	
		goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_NONE, 0, 0, 0 );
	
	else
	
		if ( ai:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, TAEGET_DIR) ) then
		
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		
		else
		
			goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_NONE, 0, 0, 0 );
			
		end
	end
end

	
---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function seirei511000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function seirei511000Battle_Terminate(ai, goal)
end

---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function seirei511000Battle_Interupt(ai, goal)

return false;
end




			


