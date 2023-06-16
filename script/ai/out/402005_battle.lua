-----------------------------------------------------------------------------------------------
--	骸骨剣士（金・二刀流）用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_honeNITOU402005_Battle, "honeNITOU402005Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_honeNITOU402005_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function honeNITOU402005Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字　その３

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 2.9					--3000番の適正間合い（最大）
local Att3001_Dist_min = 0.0					--3001番の適正間合い（最小）
local Att3001_Dist_max = 2.9					--3001番の適正間合い（最大）
local Att3002_Dist_min = 0.0					--3002番の適正間合い（最小）
local Att3002_Dist_max = 2.7					--3002番の適正間合い（最大）
local Att3003_Dist_min = 0.0					--3003番の適正間合い（最小）
local Att3003_Dist_max = 2.2					--3003番の適正間合い（最大）
local Att3300_Dist_min = 3.0					--3300番の適正間合い（最小）
local Att3300_Dist_max = 4.2					--3300番の適正間合い（最大）
local Att3301_Dist_min = 0.0					--3301番の適正間合い（最小）
local Att3301_Dist_max = 2.6					--3301番の適正間合い（最大）
local Att3302_Dist_min = 0.0					--3302番の適正間合い（最小）
local Att3302_Dist_max = 3.0					--3302番の適正間合い（最大）
local Att3303_Dist_min = 4.0					--3303番の適正間合い（最小）
local Att3303_Dist_max = 5.4					--3303番の適正間合い（最大）
local Att3304_Dist_min = 0.0					--3304番の適正間合い（最小）
local Att3304_Dist_max = 2.9					--3304番の適正間合い（最大）

local Act01Per = 0		--ダッシュ接近＆ガード崩し
local Act02Per = 0		--歩行接近＆ガード崩し
local Act03Per = 0		--ダッシュ接近＆3000or3002コンボ	
local Act04Per = 0		--ダッシュ接近＆居合い3300コンボ
local Act05Per = 0		--ダッシュ接近＆突き3301コンボ
local Act06Per = 0		--歩行接近＆3000or3002コンボ
local Act07Per = 0		--歩行接近＆居合い3300コンボ
local Act08Per = 0		--歩行接近＆突き3301コンボ
local Act09Per = 0		--ダッシュ接近＆飛び掛り3303コンボ
local Act10Per = 0		--歩行接近＆飛び掛り3303コンボ

	--ダッシュして飛び掛っても良い程度に離れている時
	if targetDist >= 9.0 then
		Act01Per = 0		--ダッシュ接近＆ガード崩し
		Act02Per = 0		--歩行接近＆ガード崩し
		Act03Per = 0		--ダッシュ接近＆3000or3002コンボ	
		Act04Per = 5		--ダッシュ接近＆居合い3300コンボ
		Act05Per = 5		--ダッシュ接近＆突き3301コンボ
		Act06Per = 0		--歩行接近＆3000or3002コンボ
		Act07Per = 0		--歩行接近＆居合い3300コンボ
		Act08Per = 0		--歩行接近＆突き3301コンボ		
		Act09Per = 90		--ダッシュ接近＆飛び掛り3303コンボ
		Act10Per = 0		--歩行接近＆飛び掛り3303コンボ
		
	--ダッシュして3300攻撃しても良い程度に離れているとき
	elseif targetDist >= 6.0 then
--		--ガードしているとき
--		if ai:IsTargetGuard( TARGET_ENE_0 ) then
--			Act01Per = 55		--ダッシュ接近＆ガード崩し
--			Act02Per = 5		--歩行接近＆ガード崩し
--			Act03Per = 5		--ダッシュ接近＆3000or3002コンボ	
--			Act04Per = 5		--ダッシュ接近＆居合い3300コンボ
--			Act05Per = 5		--ダッシュ接近＆突き3301コンボ
--			Act06Per = 0		--歩行接近＆3000or3002コンボ
--			Act07Per = 5		--歩行接近＆居合い3300コンボ
--			Act08Per = 0		--歩行接近＆突き3301コンボ
--			Act09Per = 0		--ダッシュ接近＆飛び掛り3303コンボ
--			Act10Per = 20		--歩行接近＆飛び掛り3303コンボ
--			
--		--ガードしていないとき
--		else
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆3000or3002コンボ	
			Act04Per = 10		--ダッシュ接近＆居合い3300コンボ
			Act05Per = 5		--ダッシュ接近＆突き3301コンボ
			Act06Per = 0		--歩行接近＆3000or3002コンボ
			Act07Per = 5		--歩行接近＆居合い3300コンボ
			Act08Per = 0		--歩行接近＆突き3301コンボ
			Act09Per = 0		--ダッシュ接近＆飛び掛り3303コンボ
			Act10Per = 80		--歩行接近＆飛び掛り3303コンボ
--		end
		
	--3300攻撃しても良い（＝3303飛び掛りしても良い）程度に離れているとき
	elseif targetDist >= 4.2 then
--		--ガードしているとき
--		if ai:IsTargetGuard( TARGET_ENE_0 ) then
--			Act01Per = 55		--ダッシュ接近＆ガード崩し
--			Act02Per = 5		--歩行接近＆ガード崩し
--			Act03Per = 10		--ダッシュ接近＆3000or3002コンボ	
--			Act04Per = 0		--ダッシュ接近＆居合い3300コンボ
--			Act05Per = 5		--ダッシュ接近＆突き3301コンボ
--			Act06Per = 0		--歩行接近＆3000or3002コンボ
--			Act07Per = 5		--歩行接近＆居合い3300コンボ
--			Act08Per = 0		--歩行接近＆突き3301コンボ
--			Act09Per = 0		--ダッシュ接近＆飛び掛り3303コンボ
--			Act10Per = 20		--歩行接近＆飛び掛り3303コンボ
--			
--		--ガードしていないとき
--		else
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 5		--ダッシュ接近＆3000or3002コンボ	
			Act04Per = 0		--ダッシュ接近＆居合い3300コンボ
			Act05Per = 5		--ダッシュ接近＆突き3301コンボ
			Act06Per = 0		--歩行接近＆3000or3002コンボ
			Act07Per = 10		--歩行接近＆居合い3300コンボ
			Act08Per = 0		--歩行接近＆突き3301コンボ
			Act09Per = 0		--ダッシュ接近＆飛び掛り3303コンボ
			Act10Per = 80		--歩行接近＆飛び掛り3303コンボ
--		end
		
	--もっと近いとき
	else
--		--ガードしているとき
--		if ai:IsTargetGuard( TARGET_ENE_0 ) then
--			Act01Per = 0		--ダッシュ接近＆ガード崩し
--			Act02Per = 60		--歩行接近＆ガード崩し
--			Act03Per = 0		--ダッシュ接近＆3000or3002コンボ	
--			Act04Per = 0		--ダッシュ接近＆居合い3300コンボ
--			Act05Per = 0		--ダッシュ接近＆突き3301コンボ
--			Act06Per = 30		--歩行接近＆3000or3002コンボ
--			Act07Per = 0		--歩行接近＆居合い3300コンボ
--			Act08Per = 10		--歩行接近＆突き3301コンボ
--			Act09Per = 0		--ダッシュ接近＆飛び掛り3303コンボ
--			Act10Per = 0		--歩行接近＆飛び掛り3303コンボ
--			
--		--ガードしていないとき
--		else
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 15		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆3000or3002コンボ	
			Act04Per = 0		--ダッシュ接近＆居合い3300コンボ
			Act05Per = 0		--ダッシュ接近＆突き3301コンボ
			Act06Per = 70		--歩行接近＆3000or3002コンボ
			Act07Per = 0		--歩行接近＆居合い3300コンボ
			Act08Per = 15		--歩行接近＆突き3301コンボ
			Act09Per = 0		--ダッシュ接近＆飛び掛り3303コンボ
			Act10Per = 0		--歩行接近＆飛び掛り3303コンボ
--		end		
	end
	
	--行動01　ダッシュ接近＆ガード崩し
	if fate2 <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3302_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 10.0, 3302, TARGET_ENE_0, DIST_Middle, 0);	
		if fate3 <= 75 then
			honeNITOU402005Battle_Att3301(ai, goal)
		else
			honeNITOU402005Battle_Att3000(ai, goal)
		end
		
	--行動02　歩行接近＆ガード崩し
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3302_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 10.0, 3302, TARGET_ENE_0, DIST_Middle, 0);	
		if fate3 <= 75 then
			honeNITOU402005Battle_Att3301(ai, goal)
		else
			honeNITOU402005Battle_Att3000(ai, goal)
		end
		
	--行動03　ダッシュ接近＆3000or3002コンボ
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, false, -1 );
		honeNITOU402005Battle_Att3000(ai, goal)
		
	--行動04　ダッシュ接近＆居合い3300コンボ
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, -1 );
		honeNITOU402005Battle_Att3000(ai, goal)
		
	--行動05　ダッシュ接近＆突き3301コンボ
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3301_Dist_max, TARGET_ENE_0, false, -1 );
		honeNITOU402005Battle_Att3301(ai, goal)	
		
	--行動06　歩行接近＆3000or3002コンボ
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, true, -1 );
		honeNITOU402005Battle_Att3000(ai, goal)
		
	--行動07　歩行接近＆居合い3300コンボ
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, -1 );
		honeNITOU402005Battle_Att3000(ai, goal)
		
	--行動08　歩行接近＆突き3301コンボ
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per + Act08Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3301_Dist_max, TARGET_ENE_0, true, -1 );
		honeNITOU402005Battle_Att3301(ai, goal)	
		
	--行動09　ダッシュ接近＆飛び掛り3303コンボ
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per + Act08Per + Act09Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3303_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動10　歩行接近＆飛び掛り3303コンボ	
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3303_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
		
	end
	honeNITOU402005Battle_Kougeki_Noato(ai, goal)

end



---------------------------------------------------------
--  3000or3002コンボ
---------------------------------------------------------
function honeNITOU402005Battle_Att3000(ai, goal)

local Att3000_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--20% 3001-3304
	--20% 3000-3002-3000-3001-3304
	--20% 3000-3001-3000-3002-3302
	--20% 3002-3000-3001-3304
	--20% 3002-3003-3002-3302
	
	if Att3000_fate <= 20 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3000_fate <= 40 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3000_fate <= 60 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3302, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3000_fate <= 80 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3302, TARGET_ENE_0, DIST_Middle, 0);
		
	end
end

---------------------------------------------------------
--  居合い3300コンボ
---------------------------------------------------------
function honeNITOU402005Battle_Att3300(ai, goal)

local Att3300_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--20% 3300
	--50% 3300-3304
	--30% 3300-3000-3001-3302
	if Att3300_fate <= 20 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3300_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3302, TARGET_ENE_0, DIST_Middle, 0);
		
	end
end



---------------------------------------------------------
--  突き3301コンボ
---------------------------------------------------------
function honeNITOU402005Battle_Att3301(ai, goal)

local Att3301_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--100% 3301
	if Att3301_fate <= 100 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
		
	end
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function honeNITOU402005Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

local KNAct01Per	= 40	--何もしない
local KNAct02Per	= 0		--右ステップ
local KNAct03Per	= 0		--左ステップ
local KNAct04Per	= 0		--ゴロゴロ退散
local KNAct05Per	= 30	--少しだけ横移動
local KNAct06Per	= 30	--バックステップ（セーフティ）

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
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
		
	--行動06　バックステップ
	else
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 4.0);
		
	end
end


	
	
---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function honeNITOU402005Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function honeNITOU402005Battle_Terminate(ai, goal)
end

---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function honeNITOU402005Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 2.9					--3000番の適正間合い（最大）
local Att3001_Dist_min = 0.0					--3001番の適正間合い（最小）
local Att3001_Dist_max = 2.9					--3001番の適正間合い（最大）
local Att3002_Dist_min = 0.0					--3002番の適正間合い（最小）
local Att3002_Dist_max = 2.7					--3002番の適正間合い（最大）
local Att3003_Dist_min = 0.0					--3003番の適正間合い（最小）
local Att3003_Dist_max = 2.2					--3003番の適正間合い（最大）
local Att3300_Dist_min = 3.0					--3300番の適正間合い（最小）
local Att3300_Dist_max = 4.2					--3300番の適正間合い（最大）
local Att3301_Dist_min = 0.0					--3301番の適正間合い（最小）
local Att3301_Dist_max = 2.6					--3301番の適正間合い（最大）
local Att3302_Dist_min = 0.0					--3301番の適正間合い（最小）
local Att3302_Dist_max = 3.0					--3301番の適正間合い（最大）
local Att3303_Dist_min = 4.0					--3303番の適正間合い（最小）
local Att3303_Dist_max = 5.4					--3303番の適正間合い（最大）
local Att3304_Dist_min = 0.0					--3304番の適正間合い（最小）
local Att3304_Dist_max = 2.9					--3304番の適正間合い（最大）

	--コンボ逃れ　■共通関数
local combRunDist = 2.0				--コンボ逃れする距離
local combRunPer = 25				--コンボ逃れする確率
	if Damaged_Act(ai, goal, combRunDist, combRunPer ) then
		goal:ClearSubGoal();
		--ごり押し
		if fate <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3302, TARGET_ENE_0, DIST_Middle, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
		end
		
		if fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 4.0);
		end
		return true;
	end	

	--ガード崩壊したら攻撃　■共通関数
local guardBreakConutDist = 4.2			--ガード崩壊で攻撃する距離
local guardBreakConutPer = 65			--ガード崩壊で攻撃する確率
	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
		goal:ClearSubGoal();
		--距離別に対応
		--居合い
		if targetDist >= Att3300_Dist_min then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
			
		end
		return true;
	end	
	
	--飛び道具を撃ってきたら最適行動
local ShootActPer	= 75	--反応する確率（近）
local ShootActPer2	= 75	--反応する確率（中）
local ShootActPer3	= 50	--反応する確率（遠）
local ShootActDist	= 2.6	--反応する距離（近）
local ShootActDist2	= 4.2	--反応する距離（中）
local ShootActDist3	= 30	--反応する距離（遠）

local ShootRessID =	FindShoot_Act(ai, goal, ShootActPer, ShootActPer2, ShootActPer3, ShootActDist, ShootActDist2, ShootActDist3)
	--近距離で反撃する決意をした
	if ShootRessID == 1 then
		goal:ClearSubGoal();
		honeNITOU402005Battle_Att3301(ai, goal)	
		honeNITOU402005Battle_Kougeki_Noato(ai, goal)
		return true;
		
	--中距離で反撃する決意をした
	elseif ShootRessID == 2 then
		goal:ClearSubGoal();
		honeNITOU402005Battle_Att3300(ai, goal)	
		honeNITOU402005Battle_Kougeki_Noato(ai, goal)
		return true;
		
	--遠距離で反撃する決意をした
	elseif ShootRessID == 3 then
		goal:ClearSubGoal();
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3303_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
		honeNITOU402005Battle_Kougeki_Noato(ai, goal)
		return true;
	end

	return false;
end


