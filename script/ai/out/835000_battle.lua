-----------------------------------------------------------------------------------------------
--	チュートリアル徘徊ゴースト用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_TutorialHG_835000_Battle, "TutorialHG_835000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_TutorialHG_835000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function TutorialHG_835000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２

local farDist = 15.0						--遠いと判断する距離
local nearDist = 4.0						--近いと判断する距離
local NormalR_Dist = 2.5			--右手攻撃の適正間合い

	--遠いなら
	if targetDist >= farDist then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		TutorialHG_835000Battle_NormalR_Comb(ai, goal)
		TutorialHG_835000Battle_Kougeki_Noato(ai, goal)
		
	--遠くもないが、近くもないなら
	elseif targetDist >= nearDist then
		if fate <= 20 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		else
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		end
		TutorialHG_835000Battle_NormalR_Comb(ai, goal)
		TutorialHG_835000Battle_Kougeki_Noato(ai, goal)
		
	--近いなら
	elseif targetDist >= NormalR_Dist then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		TutorialHG_835000Battle_NormalR_Comb(ai, goal)
		TutorialHG_835000Battle_Kougeki_Noato(ai, goal)
		
	--極端に近いなら
	else
		--65％　攻撃
		--35％　ステップで後退
		if fate <= 65 then
			TutorialHG_835000Battle_NormalR_Comb(ai, goal)
			TutorialHG_835000Battle_Kougeki_Noato(ai, goal)
		else
			if fate2 <= 60 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			end
		end
	end
end


---------------------------------------------------------
--  右手コンボ
---------------------------------------------------------
function TutorialHG_835000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用

	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	
	if NR_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	

---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function TutorialHG_835000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local KN_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local BackDist = 2.5							--後退する距離

	--15％　なにもしない
	--30％　横に移動
	--15％　後ろに移動
	--40％　ステップで後退
	if KN_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_Wait, 5.0, TARGET_NONE, 0, 0, 0 );
	elseif KN_fate <= 100 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
	elseif KN_fate <= 100 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	else
		if KN_fate2 <= 60 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
		end			
	end
end





---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function TutorialHG_835000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function TutorialHG_835000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function TutorialHG_835000Battle_Interupt(ai, goal)


return false;
end

