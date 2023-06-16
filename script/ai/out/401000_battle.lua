-----------------------------------------------------------------------------------------------
--	死神用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_sinigami401000_Battle, "sinigami401000Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_sinigami401000_Battle, 1 );


--------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function sinigami401000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 2.8					--3000番の適正間合い（最大）
local Att3001_Dist_min = 0.0					--3001番の適正間合い（最小）
local Att3001_Dist_max = 2.8					--3001番の適正間合い（最大）
local Att3002_Dist_min = 0.0					--3002番の適正間合い（最小）
local Att3002_Dist_max = 2.8					--3002番の適正間合い（最大）
local Att3300_Dist_min = 0.0					--3300番の適正間合い（最小）
local Att3300_Dist_max = 10.0					--3300番の適正間合い（最大）

local Act01Per = 0		--速歩き＆強攻撃
local Act02Per = 0		--速歩き＆弱攻撃
local Act03Per = 0		--速歩き＆振り下ろし攻撃
local Act04Per = 0		--速歩き＆魔法攻撃

	--PCが遠めなら
	if targetDist >= 7.5 then
		--PCがガードしていたなら
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 0		--速歩き＆強攻撃
			Act02Per = 0		--速歩き＆弱攻撃
			Act03Per = 5		--速歩き＆振り下ろし攻撃
			Act04Per = 95		--速歩き＆魔法攻撃
			
		--そうでなければ
		else
			Act01Per = 0		--速歩き＆強攻撃
			Act02Per = 0		--速歩き＆弱攻撃
			Act03Per = 0		--速歩き＆振り下ろし攻撃
			Act04Per = 100		--速歩き＆魔法攻撃
		end
		
	--ＰＣが近めなら	
	elseif targetDist >= 3.0 then
		--PCがガードしていたなら
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 5		--速歩き＆強攻撃
			Act02Per = 5		--速歩き＆弱攻撃
			Act03Per = 30		--速歩き＆振り下ろし攻撃
			Act04Per = 60		--速歩き＆魔法攻撃
			
		--そうでなければ
		else
			Act01Per = 5		--速歩き＆強攻撃
			Act02Per = 5		--速歩き＆弱攻撃
			Act03Per = 5		--速歩き＆振り下ろし攻撃
			Act04Per = 85		--速歩き＆魔法攻撃
		end	
		
	--PCがうんと近いなら
	else
		--PCがガードしていたなら
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 10		--速歩き＆強攻撃
			Act02Per = 10		--速歩き＆弱攻撃
			Act03Per = 40		--速歩き＆振り下ろし攻撃
			Act04Per = 40		--速歩き＆魔法攻撃
			
		--そうでなければ
		else
			Act01Per = 25		--速歩き＆強攻撃
			Act02Per = 25		--速歩き＆弱攻撃
			Act03Per = 10		--速歩き＆振り下ろし攻撃
			Act04Per = 50		--速歩き＆魔法攻撃
		end
	end
	
	--行動01　速歩き＆強攻撃
	if fate2 <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動02　速歩き＆弱攻撃
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3001_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動03　速歩き＆振り下ろし攻撃
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動04　速歩き＆魔法攻撃
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3300_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);	
		
	end
	sinigami401000Battle_Kougeki_Noato(ai, goal)
	
end

---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function sinigami401000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

local KNAct01Per	= 75	--何もしない
local KNAct02Per	= 20	--少しだけ横移動
local KNAct06Per	= 5		--少しだけ後退

	--行動01　何もしない
	if  KN_fate <= KNAct01Per then
   		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.0,1.0) ,0,0,0,0)
		
	--行動02　少しだけ横移動
	elseif  KN_fate <= (KNAct01Per + KNAct02Per) then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
		
	--行動03　少しだけ後退
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, 5.0, TARGET_SELF, true, -1 );
		
	end
end
	
	
---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function sinigami401000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function sinigami401000Battle_Terminate(ai, goal)
end

---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function sinigami401000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　その２

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 3.1					--3000番の適正間合い（最大）
local Att3001_Dist_min = 0.0					--3001番の適正間合い（最小）
local Att3001_Dist_max = 3.1					--3001番の適正間合い（最大）
local Att3002_Dist_min = 0.0					--3002番の適正間合い（最小）
local Att3002_Dist_max = 3.1					--3002番の適正間合い（最大）
local Att3300_Dist_min = 0.0					--3300番の適正間合い（最小）
local Att3300_Dist_max = 10.0					--3300番の適正間合い（最大）

	--飛び道具追い討ち
	--ターゲットが飛び道具を発射したら、まれに近づく
local farResDist	=5.0	--反応する距離
local farResPer		=20		--反応する確率
	if FarDamaged_Act(ai, goal, farResDist, farResPer ) then
		goal:ClearSubGoal();
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		return true;
	end	

	--ガード崩壊したら攻撃　■共通関数
local guardBreakConutDist = 10.0			--ガード崩壊で攻撃する距離
local guardBreakConutPer = 50			--ガード崩壊で攻撃する確率
	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
		goal:ClearSubGoal();
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);	
		return true;
	end	
	

return false;
end




			


