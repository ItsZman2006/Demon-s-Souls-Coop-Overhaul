-----------------------------------------------------------------------------------------------
--	王の盾　戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Ounotate501000_Battle, "ounotate501000Battle");


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function ounotate501000Battle_Activate(ai, goal)
-----------------------------------------------------------------
local targetDist = ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
local targetDistY = ai:GetDistY( TARGET_ENE_0 );	--敵ターゲットとの距離を取得(Y)

local fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その３

--今のところ使っていない
local Att3000_Dist_min = -2.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 5.0					--3000番の適正間合い（最大）
local Att3020_Dist_min = 3.5					--3020番の適正間合い（最小）
local Att3020_Dist_max = 8.5					--3020番の適正間合い（最大）
local Att3040_Dist_min = 4.0					--3040番の適正間合い（最小）
local Att3040_Dist_max = 10.0					--3040番の適正間合い（最大）

--おまじない
local Att3040Per = 0.0		--薙ぎ払い
local Att3020Per = 0.0		--槍突き
local Att3000Per = 0.0		--前方盾アタック　推奨0.0～4.5ｍ
local LeavePer = 0.0		--離れる
local BackStepPer = 0.0		--バックステップする
local Att3030Per = 0.0		--左の盾で踏む

	--攻撃禁止領域にいたら、旋回するだけ
	if ( ai:IsInsideTargetRegion(TARGET_ENE_0, 2260) ) then
		goal:AddSubGoal( GOAL_COMMON_Turn,	3.0, TARGET_ENE_0, 0, 0, 0 );
		
	elseif ( ai:IsInsideTargetRegion(TARGET_ENE_0, 2261) ) then
		goal:AddSubGoal( GOAL_COMMON_Turn,	3.0, TARGET_ENE_0, 0, 0, 0 );
		
		
	--高さが一定以上違ったら、高台にいるので槍投げ
	elseif targetDistY >= 1.5 then
		
		--攻撃が許可されている領域
--		if ( ai:IsInsideTargetRegion(TARGET_ENE_0, 2270) ) or
--			( ai:IsInsideTargetRegion(TARGET_ENE_0, 2271) ) or
--			( ai:IsInsideTargetRegion(TARGET_ENE_0, 2272) ) or
--			( ai:IsInsideTargetRegion(TARGET_ENE_0, 2273) ) then
			
			--距離別対応　近すぎたら下がる
			if targetDist <= 14.0 then
				goal:AddSubGoal(GOAL_COMMON_Step, 10.0, 701, 0, 0, 0);
				goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 15.0, TARGET_ENE_0, true, -1 );				
				goal:AddSubGoal( GOAL_COMMON_Attack, 7.0, 3300, TARGET_ENE_0, DIST_Far, 0 );
				if fate <= 50 then
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 30, true, true ,-1 );
				end
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 7.0, 3300, TARGET_ENE_0, DIST_Far, 0 );
				if fate <= 50 then
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 30, true, true ,-1 );
				end
			end
			
--		--攻撃禁止領域
--		else
--			goal:AddSubGoal( GOAL_COMMON_Turn,	3.0, TARGET_ENE_0, 0, 0, 0 );
--		end
		
	--高さが同じくらい	
	else
		--うんと遠いなら近づいて攻撃
		if targetDist >= 10.0 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 8.5, TARGET_ENE_0, true, -1 );
			if fate <= 35 then
				goal:AddSubGoal( GOAL_COMMON_Turn,	3.0, TARGET_ENE_0, 0, 0, 0 );
				goal:AddSubGoal( GOAL_COMMON_Attack, 7.0, 3020, TARGET_ENE_0, DIST_Middle, 0 );
			elseif fate <= 70 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 7.0, 3040, TARGET_ENE_0, DIST_Middle, 0 );
			else
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal( GOAL_COMMON_Attack, 7.0, 3000, TARGET_ENE_0, DIST_Middle, 0 );
			end	
			
			if fate2 <= 10 then
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 30, true, true ,-1 );
			end
			
		--遠めなら、適した攻撃するか、ときどき近づく	
		elseif targetDist >= 5.0 then
			--攻撃
			if fate <= 50 then
				if fate2 <= 50 then
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 8.5, TARGET_ENE_0, true, -1 );
					goal:AddSubGoal( GOAL_COMMON_Attack3, 7.0, 3020, TARGET_ENE_0, DIST_Middle, 3.0, -1, 1);
				else
					goal:AddSubGoal( GOAL_COMMON_Attack3, 7.0, 3040, TARGET_ENE_0, DIST_Middle, 3.0, 30, 1);
				end
				
				if fate3 <= 20 then
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 30, true, true ,-1 );
				end
			--近づく
			else
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal( GOAL_COMMON_Attack, 7.0, 3000, TARGET_ENE_0, DIST_Middle, 0 );
				
				if fate3 <= 20 then
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 30, true, true ,-1 );
				end
			end
			
		--近めなら、適した行動をするか、ときどき離れる
		elseif targetDist >= 1.0 then
			--距離別に最適攻撃
			if targetDist >= 4.0 then
				Att3040Per = 25
				Att3020Per = 25
				Att3000Per = 40
				LeavePer = 5
				BackStepPer = 5
				Att3030Per = 0				
				
			elseif targetDist >= 3.0 then
				Att3040Per = 0	
				Att3020Per = 30
				Att3000Per = 50
				LeavePer = 5
				BackStepPer = 5
				Att3030Per = 0				
				
			else
				Att3040Per = 0	
				Att3020Per = 0
				Att3000Per = 50
				LeavePer = 10
				BackStepPer = 10
				Att3030Per = 30				
			end
				
			if fate <= Att3040Per then
				--真後ろにいる状態で攻撃しないように、直前に少しだけ旋回を入れるかも
				goal:AddSubGoal( GOAL_COMMON_Attack3, 7.0, 3040, TARGET_ENE_0, DIST_Middle, 3.0, 30, 1);
				
			elseif fate <= (Att3040Per + Att3020Per) then
				goal:AddSubGoal( GOAL_COMMON_Attack3, 7.0, 3020, TARGET_ENE_0, DIST_Middle, 3.0, -1, 1);
				
			elseif fate <= (Att3040Per + Att3020Per + Att3000Per) then
				goal:AddSubGoal( GOAL_COMMON_Attack, 7.0, 3000, TARGET_ENE_0, DIST_Middle, 0 );
				
			elseif fate <= (Att3040Per + Att3020Per + Att3000Per + LeavePer ) then
				goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 5.5, TARGET_ENE_0, true, -1 );
				
			elseif fate <= (Att3040Per + Att3020Per + Att3000Per + LeavePer + BackStepPer ) then
				goal:AddSubGoal(GOAL_COMMON_Step, 10.0, 701, 0, 0, 0);
				
			else
				goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 7.0, 3030, TARGET_ENE_0, DIST_Near, 0);		
			end
			
		--足元に入られたら、方向によって適した攻撃をするか、ステップで離れる
		else
			--右後ろ側にいる場合、高確率で踏みつけ
			if ai:IsInsideTarget( TARGET_ENE_0, AI_DIR_TYPE_R, 180.0 ) and
				   ai:IsInsideTarget( TARGET_ENE_0, AI_DIR_TYPE_B, 180.0 ) then
				if fate <= 40 then
					goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 7.0, 3010, TARGET_ENE_0, DIST_Near, 0);		
				elseif fate <= 65 then
					goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 7.0, 3030, TARGET_ENE_0, DIST_Near, 0);		
				elseif fate <= 85 then
					goal:AddSubGoal(GOAL_COMMON_Attack, 7.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_Step, 10.0, 701, 0, 0, 0);
				end
				
			--左後側にいる場合、やや高確率でバックステップしてから前方盾潰し
			elseif ai:IsInsideTarget( TARGET_ENE_0, AI_DIR_TYPE_B, 180.0 ) then
				if fate <= 40 then
					goal:AddSubGoal(GOAL_COMMON_Step, 10.0, 701, 0, 0, 0);
					goal:AddSubGoal(GOAL_COMMON_Attack, 7.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
				elseif fate <= 95 then
					goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 7.0, 3030, TARGET_ENE_0, DIST_Near, 0);		
				else
					goal:AddSubGoal(GOAL_COMMON_Attack, 7.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
				end
				
			--いずれでもない場合、高確率で足元盾潰し
			else
				if fate <= 65 then
					goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 7.0, 3030, TARGET_ENE_0, DIST_Near, 0);		
				elseif fate <= 95 then
					goal:AddSubGoal(GOAL_COMMON_Step, 10.0, 701, 0, 0, 0);
					goal:AddSubGoal(GOAL_COMMON_Attack, 7.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
				else
					goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 7.0, 3010, TARGET_ENE_0, DIST_Near, 0);		
				end	
			end
		end
	end	
end

---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function ounotate501000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function ounotate501000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function ounotate501000Battle_Interupt(ai, goal)

	return false;
end
