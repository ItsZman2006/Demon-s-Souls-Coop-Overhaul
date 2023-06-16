-----------------------------------------------------------------------------------------------
--	デブデーモン用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Debu103000_Battle, "debu103000Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Debu103000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function debu103000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得
local targethprate = ai:GetHpRate( TARGET_ENE_0 )		--敵ターゲットのHP割合を取得
local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その３

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その３

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 7.5					--3000番の適正間合い（最大）
local Att3001_Dist_min = 2.0					--3001番の適正間合い（最小）
local Att3001_Dist_max = 10.2					--3001番の適正間合い（最大）
local Att3002_Dist_min = 2.5					--3002番の適正間合い（最小）
local Att3002_Dist_max = 9.5					--3002番の適正間合い（最大）
local Att3300_Dist_min = 1.0					--3300番の適正間合い（最小）
local Att3300_Dist_max = 8.0					--3300番の適正間合い（最大）
local Att3301_Dist_min = 0.0					--3300番の適正間合い（最小）
local Att3301_Dist_max = 1.5					--3300番の適正間合い（最大）

local Act01Per = 0		--近接攻撃
local Act02Per = 0		--なぎはらい
local Act03Per = 0		--連続攻撃	
local Act04Per = 0		--溜め攻撃
local Act05Per = 0		--その場ジャンプ攻撃

	--うんと遠いなら
	if targetDist >= 10.2 then
		Act01Per = 5		--近接攻撃
		Act02Per = 50		--なぎはらい
		Act03Per = 30		--連続攻撃	
		Act04Per = 15		--溜め攻撃
		Act05Per = 0		--その場ジャンプ攻撃
		
	--得意な距離なら	
	elseif targetDist >= 3.0 then
		Act01Per = 5		--近接攻撃
		Act02Per = 30		--なぎはらい
		Act03Per = 40		--連続攻撃	
		Act04Per = 25		--溜め攻撃
		Act05Per = 0		--その場ジャンプ攻撃
		
	--近いなら	
	elseif targetDist >= 1.5 then
		Act01Per = 60		--近接攻撃
		Act02Per = 20		--なぎはらい
		Act03Per = 10		--連続攻撃	
		Act04Per = 10		--溜め攻撃
		Act05Per = 0		--その場ジャンプ攻撃
		
		
	--うんと近いなら	
	else	
		Act01Per = 20		--近接攻撃
		Act02Per = 10		--なぎはらい
		Act03Per = 5		--連続攻撃	
		Act04Per = 5		--溜め攻撃
		Act05Per = 60		--その場ジャンプ攻撃
	end

	--行動01　近接攻撃
	if fate <= Act01Per then
		goal:AddSubGoal( GOAL_COMMON_KeepDist, 5.0, TARGET_ENE_0, Att3000_Dist_min, Att3000_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動02　なぎはらい
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal( GOAL_COMMON_KeepDist, 5.0, TARGET_ENE_0, Att3001_Dist_min, Att3001_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動03　連続攻撃
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
		goal:AddSubGoal( GOAL_COMMON_KeepDist, 5.0, TARGET_ENE_0, Att3002_Dist_min, Att3002_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動04　溜め攻撃
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
		goal:AddSubGoal( GOAL_COMMON_KeepDist, 5.0, TARGET_ENE_0, Att3300_Dist_min, Att3300_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動05　その場ジャンプ攻撃
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
	end

	debu103000Battle_Kougeki_Noato(ai, goal)
	
end


	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function debu103000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字
local KN_fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２

local SideTime = 3.0							--横に動く時間
local BackDist = 2.0							--後退する距離
local BackTime = 3.0							--後退する時間

	--80％　何もしない
	--10％　適当に横に移動
	--10％　少し下がる
	if KN_fate <= 80 then
		
	elseif KN_fate <= 90 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(20,30), true, true ,-1 );
		
	else
		goal:AddSubGoal(GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );
	end
end



---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function debu103000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function debu103000Battle_Terminate(ai, goal)
end

---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function debu103000Battle_Interupt(ai, goal)
return false;
end
