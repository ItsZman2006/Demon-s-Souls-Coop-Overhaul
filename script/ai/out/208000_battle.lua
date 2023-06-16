-----------------------------------------------------------------------------------------------
--	【獄吏】用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Gokuri208000_Battle, "gokuri208000Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Gokuri208000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function gokuri208000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 1.4					--3000番の適正間合い（最大）
local Att3002_Dist_min = 1.5					--3002番の適正間合い（最小）
local Att3002_Dist_max = 4.3					--3002番の適正間合い（最大）
local Att3003_Dist_min = 0.0					--3003番の適正間合い（最小）
local Att3003_Dist_max = 2.0					--3003番の適正間合い（最大）
local Att3301_Dist_min = 4.0					--3301番の適正間合い（最小）
local Att3301_Dist_max = 15.0					--3301番の適正間合い（最大）
local Att3303_Dist_min = 0.0					--3303番の適正間合い（最小）
local Att3303_Dist_max = 0.6					--3303番の適正間合い（最大）
local Att3304_Dist_min = 6.0					--3304番の適正間合い（最小）
local Att3304_Dist_max = 15.0					--3304番の適正間合い（最大）

local Act01Per = 0		--ダッシュ接近＆ジャンプアタック
local Act02Per = 0		--ダッシュ接近＆薙ぎ払い
local Act03Per = 0		--ダッシュ接近＆連続攻撃	
local Act04Per = 0		--ダッシュ接近＆発火
local Act05Per = 0		--歩行接近＆ジャンプアタック
local Act06Per = 0		--歩行接近＆薙ぎ払い
local Act07Per = 0		--歩行接近＆連続攻撃
local Act08Per = 0		--歩行接近＆ファイア（長）
local Act09Per = 0		--歩行接近＆ファイア（短）


	if targetDist >= 16.0 then
		Act01Per = 15		--ダッシュ接近＆ジャンプアタック
		Act02Per = 0		--ダッシュ接近＆薙ぎ払い
		Act03Per = 0		--ダッシュ接近＆連続攻撃	
		Act04Per = 5		--ダッシュ接近＆発火
		Act05Per = 0		--歩行接近＆ジャンプアタック
		Act06Per = 0		--歩行接近＆薙ぎ払い
		Act07Per = 0		--歩行接近＆連続攻撃
		Act08Per = 40		--歩行接近＆ファイア（長）
		Act09Per = 40		--歩行接近＆ファイア（短）
		
	elseif targetDist >= 8.0 then
		Act01Per = 25		--ダッシュ接近＆ジャンプアタック
		Act02Per = 5		--ダッシュ接近＆薙ぎ払い
		Act03Per = 5		--ダッシュ接近＆連続攻撃	
		Act04Per = 5		--ダッシュ接近＆発火
		Act05Per = 0		--歩行接近＆ジャンプアタック
		Act06Per = 0		--歩行接近＆薙ぎ払い
		Act07Per = 0		--歩行接近＆連続攻撃
		Act08Per = 30		--歩行接近＆ファイア（長）
		Act09Per = 30		--歩行接近＆ファイア（短）
		
	elseif targetDist >= 5.0 then	
		Act01Per = 0		--ダッシュ接近＆ジャンプアタック
		Act02Per = 10		--ダッシュ接近＆薙ぎ払い
		Act03Per = 10		--ダッシュ接近＆連続攻撃	
		Act04Per = 10		--ダッシュ接近＆発火
		Act05Per = 20		--歩行接近＆ジャンプアタック
		Act06Per = 0		--歩行接近＆薙ぎ払い
		Act07Per = 0		--歩行接近＆連続攻撃
		Act08Per = 20		--歩行接近＆ファイア（長）
		Act09Per = 30		--歩行接近＆ファイア（短）
		
	elseif targetDist >= 3.0 then
		Act01Per = 0		--ダッシュ接近＆ジャンプアタック
		Act02Per = 0		--ダッシュ接近＆薙ぎ払い
		Act03Per = 20		--ダッシュ接近＆連続攻撃	
		Act04Per = 20		--ダッシュ接近＆発火
		Act05Per = 20		--歩行接近＆ジャンプアタック
		Act06Per = 10		--歩行接近＆薙ぎ払い
		Act07Per = 10		--歩行接近＆連続攻撃
		Act08Per = 0		--歩行接近＆ファイア（長）
		Act09Per = 20		--歩行接近＆ファイア（短）
		
	elseif targetDist >= 1.0 then
		Act01Per = 0		--ダッシュ接近＆ジャンプアタック
		Act02Per = 0		--ダッシュ接近＆薙ぎ払い
		Act03Per = 0		--ダッシュ接近＆連続攻撃	
		Act04Per = 20		--ダッシュ接近＆発火
		Act05Per = 10		--歩行接近＆ジャンプアタック
		Act06Per = 25		--歩行接近＆薙ぎ払い
		Act07Per = 40		--歩行接近＆連続攻撃
		Act08Per = 0		--歩行接近＆ファイア（長）
		Act09Per = 5		--歩行接近＆ファイア（短）
		
	else
		Act01Per = 0		--ダッシュ接近＆ジャンプアタック
		Act02Per = 0		--ダッシュ接近＆薙ぎ払い
		Act03Per = 0		--ダッシュ接近＆連続攻撃	
		Act04Per = 20		--ダッシュ接近＆発火
		Act05Per = 0		--歩行接近＆ジャンプアタック
		Act06Per = 40		--歩行接近＆薙ぎ払い
		Act07Per = 40		--歩行接近＆連続攻撃
		Act08Per = 0		--歩行接近＆ファイア（長）
		Act09Per = 0		--歩行接近＆ファイア（短）
		
	end
	
	--行動01　ダッシュ接近＆ジャンプアタック
	if fate2 <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動02　ダッシュ接近＆薙ぎ払い
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動03　ダッシュ接近＆連続攻撃
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, -1 );
		gokuri208000Battle_Kougeki(ai, goal)
		
	--行動04　ダッシュ接近＆発火
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3303_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動05　歩行接近＆ジャンプアタック
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動06　歩行接近＆薙ぎ払い
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動07　歩行接近＆連続攻撃
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, -1 );
		gokuri208000Battle_Kougeki(ai, goal)
		
	--行動08　歩行接近＆ファイア（長）
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per + Act08Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3304_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);

	--行動09　歩行接近＆ファイア（短）
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3301_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
		
	end
	gokuri208000Battle_Kougeki_Noato(ai, goal)
	
end


---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function gokuri208000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--20% 3000
	--50% 3000-3001
	--30% 3000-3001-3303
	if K_fate <= 30 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function gokuri208000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--70% なにもしない
	--5% 適当に横に移動
	--25% 後ろに移動
	if KN_fate <= 70 then
	
	elseif KN_fate < 0 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true, -1);
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, true, -1 );				
	end
end

	
	
---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function gokuri208000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function gokuri208000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function gokuri208000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２
	
local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 1.4					--3000番の適正間合い（最大）
local Att3002_Dist_min = 1.5					--3002番の適正間合い（最小）
local Att3002_Dist_max = 4.3					--3002番の適正間合い（最大）
local Att3003_Dist_min = 0.0					--3003番の適正間合い（最小）
local Att3003_Dist_max = 2.0					--3003番の適正間合い（最大）
local Att3301_Dist_min = 4.0					--3301番の適正間合い（最小）
local Att3301_Dist_max = 15.0					--3301番の適正間合い（最大）
local Att3303_Dist_min = 0.0					--3303番の適正間合い（最小）
local Att3303_Dist_max = 0.6					--3303番の適正間合い（最大）
local Att3304_Dist_min = 6.0					--3304番の適正間合い（最小）
local Att3304_Dist_max = 15.0					--3304番の適正間合い（最大）

local Act01Per = 0		--ダッシュ接近＆ジャンプアタック
local Act02Per = 0		--ダッシュ接近＆薙ぎ払い
local Act03Per = 0		--ダッシュ接近＆連続攻撃	
local Act04Per = 0		--ダッシュ接近＆発火
local Act05Per = 0		--歩行接近＆ジャンプアタック
local Act06Per = 0		--歩行接近＆薙ぎ払い
local Act07Per = 0		--歩行接近＆連続攻撃
local Act08Per = 0		--歩行接近＆ファイア（長）
local Act09Per = 0		--歩行接近＆ファイア（短）


	-- コンボ逃れ　■共通関数
local combRunDist		= 1.6		--コンボ逃れする距離
local combRunPer		= 30		--コンボ逃れする確率
	if Damaged_Act(ai, goal, combRunDist, combRunPer ) then
		goal:ClearSubGoal();
		gokuri208000Battle_Kougeki(ai, goal)
		gokuri208000Battle_Kougeki_Noato(ai, goal)
		return true;
	end	
	
	--ガード崩壊したら攻撃　■共通関数
local guardBreakConutDist = 4.5			--ガード崩壊で攻撃する距離
local guardBreakConutPer = 65			--ガード崩壊で攻撃する確率
	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
		goal:ClearSubGoal();
		--距離別に対応
		if targetDist >= Att3002_Dist_min then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
			
		else
			gokuri208000Battle_Kougeki(ai, goal)
			
		end
		gokuri208000Battle_Kougeki_Noato(ai, goal)
		return true;
	end	
	
return false;

end


	