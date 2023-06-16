-----------------------------------------------------------------------------------------------
--	骸骨剣士（白・剣）用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_honeKEN402100_Battle, "honeKEN402100Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_honeKEN402100_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function honeKEN402100Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字　その２

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 1.5					--3000番の適正間合い（最大）
local Att3001_Dist_min = 0.0					--3001番の適正間合い（最小）
local Att3001_Dist_max = 1.3					--3001番の適正間合い（最大）
local Att3002_Dist_min = 3.0					--3002番の適正間合い（最小）
local Att3002_Dist_max = 4.5					--3002番の適正間合い（最大）
local Att3303_Dist_min = 3.0					--3303番の適正間合い（最小）
local Att3303_Dist_max = 5.5					--3303番の適正間合い（最大）
local Att3300_Dist_min = 1.5					--3300番の適正間合い（最小）
local Att3300_Dist_max = 3.0					--3300番の適正間合い（最大）


	--突きをしても変ではないくらい離れているとき
	if targetDist >= 9.0 then
		--ガードしていたら、高確率でガードつぶし
		if ai:IsTargetGuard( TARGET_ENE_0 ) and fate2 <= 80 then
			goal:AddSubGoal(GOAL_COMMON_ApproachStep, 5.0, 700, TARGET_ENE_0, Att3300_Dist_max, 0)
			goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			if fate2 <= 50 then
				honeKEN402100Battle_Att3002(ai, goal)
			else
				honeKEN402100Battle_Att3000(ai, goal)
			end
		else
			if fate <= 25 then
				goal:AddSubGoal(GOAL_COMMON_ApproachStep, 5.0, 700, TARGET_ENE_0, Att3303_Dist_max, 0)
				honeKEN402100Battle_Att3303(ai, goal)
				
			elseif fate <= 50 then
				goal:AddSubGoal(GOAL_COMMON_ApproachStep, 5.0, 700, TARGET_ENE_0, Att3002_Dist_max, 0)
				honeKEN402100Battle_Att3002(ai, goal)
				
			else
				goal:AddSubGoal(GOAL_COMMON_ApproachStep, 5.0, 700, TARGET_ENE_0, Att3000_Dist_max, 0)
				honeKEN402100Battle_Att3000(ai, goal)
			end
		end
		honeKEN402100Battle_Kougeki_Noato(ai, goal)
		
	--回転攻撃をしても変ではないくらい離れている時	
	elseif targetDist >= 4.0 then
		--ガードしていたら、高確率でガードつぶし
		if ai:IsTargetGuard( TARGET_ENE_0 ) and fate2 <= 80 then
			goal:AddSubGoal(GOAL_COMMON_ApproachStep, 5.0, 700, TARGET_ENE_0, Att3300_Dist_max, 0)
			goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			if fate2 <= 50 then
				honeKEN402100Battle_Att3002(ai, goal)
			else
				honeKEN402100Battle_Att3000(ai, goal)
			end
		else
			if fate <= 25 then
				goal:AddSubGoal(GOAL_COMMON_ApproachStep, 5.0, 700, TARGET_ENE_0, Att3303_Dist_max, 0)
				honeKEN402100Battle_Att3303(ai, goal)
				
			else
				goal:AddSubGoal(GOAL_COMMON_ApproachStep, 5.0, 700, TARGET_ENE_0, Att3000_Dist_max, 0)
				honeKEN402100Battle_Att3000(ai, goal)
			end
		end
		honeKEN402100Battle_Kougeki_Noato(ai, goal)	
		
	--近接じゃないと変なくらい近いとき
	else
		--ガードしていたら、高確率でガードつぶし
		if ai:IsTargetGuard( TARGET_ENE_0 ) and fate2 <= 80 then
			goal:AddSubGoal(GOAL_COMMON_ApproachStep, 5.0, 700, TARGET_ENE_0, Att3300_Dist_max, 0)
			goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			if fate2 <= 50 then
				honeKEN402100Battle_Att3002(ai, goal)
			else
				honeKEN402100Battle_Att3000(ai, goal)
			end
		else
			goal:AddSubGoal(GOAL_COMMON_ApproachStep, 5.0, 700, TARGET_ENE_0, Att3000_Dist_max, 0)
			honeKEN402100Battle_Att3000(ai, goal)
		end
		honeKEN402100Battle_Kougeki_Noato(ai, goal)	
	end
	
end

---------------------------------------------------------
--  攻撃3000～
---------------------------------------------------------
function honeKEN402100Battle_Att3000(ai, goal)

local Att3300_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--10% 3000-3001
	--40% 3000-3001-3000
	--35% 3000-3001-3000-3001
	--15% 3000-3001-3300
	if Att3300_fate <= 10 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3300_fate <= 50 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3300_fate <= 85 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
	end
end


---------------------------------------------------------
--  攻撃3303
---------------------------------------------------------
function honeKEN402100Battle_Att3303(ai, goal)

local Att3303_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--25% 3303
	--10% 3303-3001
	--30% 3303-3001-3000
	--35% 3303-3001-3000-3001
	if Att3303_fate <= 25 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3303_fate <= 35 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3303_fate <= 65 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);

	end
end


---------------------------------------------------------
--  攻撃3002
---------------------------------------------------------
function honeKEN402100Battle_Att3002(ai, goal)

local Att3002_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--80% 3002
	--20% 3002-3001-3000
	if Att3002_fate <= 80 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function honeKEN402100Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local LeaveDist = ai:GetRandam_Int(8,12)		--離れる距離

local myThinkId = ai:GetNpcThinkParamID()		--思考IDを取得

local KNAct01Per	= 10	--何もしない
local KNAct02Per	= 25	--右ステップ
local KNAct03Per	= 25	--左ステップ
local KNAct04Per	= 30	--ゴロゴロ退散
local KNAct05Per	= 5		--少しだけ横移動
local KNAct06Per	= 5		--バックステップ

	if myThinkId == 402102 then		--狭いところ用
		KNAct01Per	= 50	--何もしない
		KNAct02Per	= 10	--右ステップ
		KNAct03Per	= 10	--左ステップ
		KNAct04Per	= 0		--ゴロゴロ退散
		KNAct05Per	= 0		--少しだけ横移動
		KNAct06Per	= 30	--バックステップ
	end
	
	--行動01　何もしない
	if  KN_fate <= KNAct01Per then
   		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.5,1.0) ,0,0,0,0)
		
	--行動02　右ステップ
	elseif  KN_fate <= (KNAct01Per + KNAct02Per) then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 703, TARGET_ENE_0, 0);
		
	--行動03　左ステップ
	elseif  KN_fate <= (KNAct01Per + KNAct02Per + KNAct03Per) then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 702, TARGET_ENE_0, 0);
		
	--行動04　ゴロゴロ退散
	elseif  KN_fate <= (KNAct01Per + KNAct02Per + KNAct03Per + KNAct04Per) then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 700, TARGET_SELF, 0, AI_DIR_TYPE_F, 4.0);
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 700, TARGET_SELF, 0, AI_DIR_TYPE_F, 4.0);
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 700, TARGET_SELF, 0, AI_DIR_TYPE_F, 4.0);
		
	--行動05　少しだけ横移動
	elseif  KN_fate <= (KNAct01Per + KNAct02Per + KNAct03Per + KNAct04Per + KNAct05Per) then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
		
	--行動06　バックステップ
	else
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0.0);
		
	end
end

	
	
---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function honeKEN402100Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function honeKEN402100Battle_Terminate(ai, goal)
end

---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function honeKEN402100Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 1.5					--3000番の適正間合い（最大）
local Att3001_Dist_min = 0.0					--3001番の適正間合い（最小）
local Att3001_Dist_max = 1.3					--3001番の適正間合い（最大）
local Att3002_Dist_min = 3.0					--3002番の適正間合い（最小）
local Att3002_Dist_max = 4.5					--3002番の適正間合い（最大）
local Att3303_Dist_min = 3.0					--3303番の適正間合い（最小）
local Att3303_Dist_max = 5.5					--3303番の適正間合い（最大）
local Att3300_Dist_min = 1.5					--3300番の適正間合い（最小）
local Att3300_Dist_max = 3.0					--3300番の適正間合い（最大）

	--空振り追撃　■共通関数
local missSwingDist = 4.5			--空振り追撃する距離
local missSwingAttPer = 30			--空振り追撃する確率	
	if MissSwing_Act(ai, goal, missSwingDist, missSwingAttPer ) then
		goal:ClearSubGoal();
		
		--距離別に対応
		if targetDist >= Att3002_Dist_min then
			honeKEN402100Battle_Att3002(ai, goal)
		elseif targetDist >= Att3300_Dist_min then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		else
			honeKEN402100Battle_Att3000(ai, goal)
		end
		honeKEN402100Battle_Kougeki_Noato(ai, goal)
		return true;
	end

	--コンボ逃れ　■共通関数
local combRunDist = 1.5				--コンボ逃れする距離
local combRunPer = 40				--コンボ逃れする確率
	if Damaged_Act(ai, goal, combRunDist, combRunPer ) then
		goal:ClearSubGoal();
		
		--左右にステップ
		if fate <= 50 then
			goal:AddSubGoal( GOAL_COMMON_Step, 10.0, 702, 0, 0, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_Step, 10.0, 703, 0, 0, 0);
		end
		return true;
	end	

	--ガード崩壊したら攻撃　■共通関数
local guardBreakConutDist = 4.5			--ガード崩壊で攻撃する距離
local guardBreakConutPer = 65			--ガード崩壊で攻撃する確率
	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
		goal:ClearSubGoal();
		
		--距離別に対応
		if targetDist >= Att3002_Dist_min then
			honeKEN402100Battle_Att3002(ai, goal)
		elseif targetDist >= Att3300_Dist_min then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		else
			honeKEN402100Battle_Att3000(ai, goal)
		end
		honeKEN402100Battle_Kougeki_Noato(ai, goal)
		return true;
	end

return false;
end



