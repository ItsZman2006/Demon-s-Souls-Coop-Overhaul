-----------------------------------------------------------------------------------------------
--	NpcPlayerTest専用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_NpcPlayerTest_Battle, "NpcPlayerTestBattle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_NpcPlayerTest_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function NpcPlayerTestBattle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字

	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 2.0, TARGET_ENE_0, true, NPC_ATK_GuardL );
	
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_None, 0);
	--goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_PushR, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_GuardL, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Parry, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Item, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepF, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);


end



---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function NpcPlayerTestBattle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function NpcPlayerTestBattle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function NpcPlayerTestBattle_Interupt(ai, goal)

	return false;
end
