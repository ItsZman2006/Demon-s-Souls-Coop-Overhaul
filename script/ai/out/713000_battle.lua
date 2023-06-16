-----------------------------------------------------------------------------------------------
--	鍛冶屋（坑道）戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_kajiyaK_713000_Battle, "kajiyaK_713000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_kajiyaK_713000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function kajiyaK_713000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local playerDist = ai:GetDist(TARGET_LOCALPLAYER);		--ローカルプレイヤーとの距離を取得
local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２

local Kougeki_Dist = 0.8					--攻撃の適正間合い

	if fate <= 60 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Kougeki_Dist, TARGET_ENE_0, true, -1 );
		kajiyaK_713000Battle_Kougeki(ai, goal)
		kajiyaK_713000Battle_Kougeki_Noato(ai, goal)	

	else
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Kougeki_Dist, TARGET_ENE_0, false, -1 );
		kajiyaK_713000Battle_Kougeki(ai, goal)
		kajiyaK_713000Battle_Kougeki_Noato(ai, goal)	
	end
	
end


---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function kajiyaK_713000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)		--確率判定用
local K_fate2 = ai:GetRandam_Int(1,100)		--確率判定用

	--100% ワンツー
	
local tsuika_fate	= 60			--追加攻撃
local upper_fate	= 40			--アッパー
local R_straight	= 30			--30% 右ストレート
local BackhandBrow	= 30			--30% 裏拳
		
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 3005, TARGET_ENE_0, DIST_Middle, 0);

	if K_fate <= tsuika_fate then
	
		if K_fate2 <= upper_fate then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	
		elseif K_fate2 <= (upper_fate + R_straight) then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		end
	end
	
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function kajiyaK_713000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local KN_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local BackDist = 3.0							--後退する距離


	--50％　少し待つ
	--15％　横に移動
	--35％　後ろに移動
	if KN_fate <= 50 then
		if KN_fate2 <= 40 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, 701, TARGET_ENE_0, DIST_None, 0);
		elseif KN_fate2 <= 70 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, 702, TARGET_ENE_0, DIST_None, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, 703, TARGET_ENE_0, DIST_None, 0);
		end
	elseif KN_fate <= 65 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end




---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function kajiyaK_713000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function kajiyaK_713000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function kajiyaK_713000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local NormalR_Dist = 0.8			--右手攻撃の適正間合い

	--至近距離でダメージ受けたらコンボとみなして反撃・後退
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--コンボ逃れする距離
local combRunPer = 40				--コンボ逃れする確率
local combRunCountPer = 15			--コンボ逃れの後に攻撃する確率	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, 701, TARGET_ENE_0, DIST_None, 0);
				return true;
			end
		end
	end	
	
	--至近距離で攻撃されそうになったら超反応ステップ
	if ai:IsInterupt( INTERUPT_FindAttack ) then
local superStepDist = 2.0			--超反応する距離
local superStepPer = 50				--超反応する確率	
		if targetDist <= superStepDist then
			if fate <= superStepPer then
			--逃れる
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, 701, TARGET_ENE_0, DIST_None, 0);
				return true;
			end
		end
	end
	
	
	--飛び道具を撃ってきたら最適行動
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 10					--飛び道具使用時に最適行動を取る確率
		if fate <= shootIntPer then
			goal:ClearSubGoal();
			if fate2 <= 50 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, 702, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, 703, TARGET_ENE_0, DIST_None, 0);
			end
			return true;
		end
	end	
	
	
	
return false;
end
