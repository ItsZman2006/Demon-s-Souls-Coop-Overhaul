-----------------------------------------------------------------------------------------------
--	審判者専用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Sinpansya504000_Battle, "Sinpansya504000Battle");


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function Sinpansya504000Battle_Activate(ai, goal)
	
local targetDist = ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
local targetDistY = ai:GetDistY( TARGET_ENE_0 );	--敵ターゲットとの距離を取得(Y)

local fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その３

	
	--３Fにいたら
	if ai:IsInsideTargetRegion( TARGET_ENE_0, 2260) then
		if fate <= 80 then
			goal:AddSubGoal( GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, 7.9, 9.2, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3050, TARGET_ENE_0, DIST_None, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, 8.2, 10.1, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3060, TARGET_ENE_0, DIST_None, 0);
		end	
		
	--２.５Fにいたら
	elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2261) then
		goal:AddSubGoal( GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, 6.5, 10.1, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3060, TARGET_ENE_0, DIST_None, 0);
		
	--２Fにいたら
	elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2262) then
		if fate <= 50 then
			goal:AddSubGoal( GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, 4.2, 7.3, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3010, TARGET_ENE_0, DIST_None, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, 3.1, 5.1, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3030, TARGET_ENE_0, DIST_None, 0);
		end	
		
	--１.５Fにいたら
	elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2263) then
		goal:AddSubGoal( GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, 4.2, 7.3, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3010, TARGET_ENE_0, DIST_None, 0);
		
	--１Fにいたら
	elseif ai:IsInsideTargetRegion( TARGET_ENE_0, 2264) then
		if targetDist <= 3.0 then
			if fate <= 90 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3000, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3010, TARGET_ENE_0, DIST_None, 0);
			end
		else
			if fate <= 20 then
				goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, 6.7, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3000, TARGET_ENE_0, DIST_None, 0);
			elseif fate <= 40 then
				goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, 6.9, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3010, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, 3.0, 6.3, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3040, TARGET_ENE_0, DIST_None, 0);
			end	
		end
		
	--部屋の中にだれもいなければ、巣に戻る
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 3.0, POINT_INITIAL, 1.0, TARGET_SELF, true, -1 );
		goal:AddSubGoal( GOAL_COMMON_Wait, 5.0, TARGET_NONE, 0, 0, 0 );
	end
	
	--ごくまれに巣に戻る
	if fate2 <= 5 then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 3.0, POINT_INITIAL, 1.0, TARGET_ENE_0, true, -1 );
	end

end

---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function Sinpansya504000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function Sinpansya504000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function Sinpansya504000Battle_Interupt(ai, goal)
	
	return false;
end
