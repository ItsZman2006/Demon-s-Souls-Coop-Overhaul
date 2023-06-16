-----------------------------------------------------------------------------------------------
--	レンドル王用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_King723000_Battle, "king723000Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_King723000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function king723000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

	-- 番号0に1が入っているときは割込みをキャンセルする
	ai:SetNumber(0, 0);	-- デフォルトでオフ
	
local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local Att3010_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3010_Dist_max = 2.8					--3000番の適正間合い（最大）
local Att3030_Dist_min = 2.5					--3030番の適正間合い（最小）
local Att3030_Dist_max = 5.6					--3030番の適正間合い（最大）
local Att3040_Dist_min = 0.0					--3030番の適正間合い（最小）
local Att3040_Dist_max = 1.3					--3030番の適正間合い（最大）
local Att3050_Dist_min = 0.0					--3050番の適正間合い（最小）
local Att3050_Dist_max = 3.5					--3050番の適正間合い（最大）
local Att3080_Dist_min = 0.0					--3080番の適正間合い（最小）
local Att3080_Dist_max = 3.0					--3080番の適正間合い（最大）
local Att3090_Dist_min = 4.5					--3090番の適正間合い（最小）
local Att3090_Dist_max = 6.0					--3090番の適正間合い（最大）	*旧6.5ｍ
local Att3100_Dist_min = 0.0					--3100番の適正間合い（最小）
local Att3100_Dist_max = 2.4					--3100番の適正間合い（最大）
local Att3110_Dist_min = 0.0					--3110番の適正間合い（最小）
local Att3110_Dist_max = 1.0					--3110番の適正間合い（最大）
local Att3130_Dist_min = 8.0					--3130番の適正間合い（最小）
local Att3130_Dist_max = 20.0					--3130番の適正間合い（最大）

--memo 3100 3020 3070 3080 は攻撃後のモーションキャンセルがやや遅めで隙になる

local Act01Per = 0		--ダッシュ接近＆3070斬り
local Act02Per = 0		--歩行接近＆小ジャンプ斬りコンボ
local Act03Per = 0		--歩行接近＆前ステップ斬りコンボ
local Act04Per = 0		--歩行接近＆いきなり掴む
local Act05Per = 0		--歩行接近＆近接コンボ
local Act06Per = 0		--歩行接近＆ラッシュ
local Act07Per = 0		--後ステップ斬り
local Act08Per = 0		--小ジャンプ斬り接近＆ラッシュなど攻撃
local Act09Per = 0		--強斬り
local Act10Per = 0		--その場で攻撃（衝撃波に頼る）
local Act11Per = 0		--その場で広範囲攻撃

	--うんと遠いなら
	if targetDist >= 22.0 then
		Act01Per = 90		--ダッシュ接近＆3070斬り
		Act02Per = 0		--歩行接近＆小ジャンプ斬りコンボ
		Act03Per = 0		--歩行接近＆前ステップ斬りコンボ
		Act04Per = 0		--歩行接近＆いきなり掴む
		Act05Per = 0		--歩行接近＆近接コンボ
		Act06Per = 0		--歩行接近＆ラッシュ
		Act07Per = 0		--後ステップ斬り
		Act08Per = 0		--小ジャンプ斬り接近＆ラッシュなど攻撃
		Act09Per = 0		--歩行接近＆強斬り
		Act10Per = 10		--その場で攻撃（衝撃波に頼る）
		Act11Per = 0		--その場で広範囲攻撃
		
	--遠いなら
	elseif targetDist >= 9.0 then
		Act01Per = 50		--ダッシュ接近＆3070斬り
		Act02Per = 0		--歩行接近＆小ジャンプ斬りコンボ
		Act03Per = 0		--歩行接近＆前ステップ斬りコンボ
		Act04Per = 0		--歩行接近＆いきなり掴む
		Act05Per = 0		--歩行接近＆近接コンボ
		Act06Per = 0		--歩行接近＆ラッシュ
		Act07Per = 0		--後ステップ斬り
		Act08Per = 0		--小ジャンプ斬り接近＆ラッシュなど攻撃
		Act09Per = 0		--歩行接近＆強斬り
		Act10Per = 10		--その場で攻撃（衝撃波に頼る）
		Act11Per = 40		--その場で広範囲攻撃
		
	--中途半端に遠いなら（一番困る距離）
	elseif targetDist >= 7.0 then
		Act01Per = 35		--ダッシュ接近＆3070斬り
		Act02Per = 15		--歩行接近＆小ジャンプ斬りコンボ
		Act03Per = 15		--歩行接近＆前ステップ斬りコンボ
		Act04Per = 0		--歩行接近＆いきなり掴む
		Act05Per = 0		--歩行接近＆近接コンボ
		Act06Per = 0		--歩行接近＆ラッシュ
		Act07Per = 0		--後ステップ斬り
		Act08Per = 0		--小ジャンプ斬り接近＆ラッシュなど攻撃
		Act09Per = 0		--歩行接近＆強斬り
		Act10Per = 5		--その場で攻撃（衝撃波に頼る）
		Act11Per = 30		--その場で広範囲攻撃
		
	--小ジャンプ斬りをしても変でないなら	
	elseif targetDist >= 5.0 then
		Act01Per = 0		--ダッシュ接近＆3070斬り
		Act02Per = 30		--歩行接近＆小ジャンプ斬りコンボ
		Act03Per = 30		--歩行接近＆前ステップ斬りコンボ
		Act04Per = 5		--歩行接近＆いきなり掴む
		Act05Per = 5		--歩行接近＆近接コンボ
		Act06Per = 0		--歩行接近＆ラッシュ
		Act07Per = 0		--後ステップ斬り
		Act08Per = 10		--小ジャンプ斬り接近＆ラッシュなど攻撃	
		Act09Per = 5		--歩行接近＆強斬り
		Act10Per = 0		--その場で攻撃（衝撃波に頼る）
		Act11Per = 15		--その場で広範囲攻撃
		
	--それよりは近くて、敵がガードしていたなら、６０％の確率で
	elseif ai:IsTargetGuard( TARGET_ENE_0 )  and fate <= 60 then
		Act09Per = 100		--歩行接近＆強斬り	
		
	--前ステップ斬りをしても変でないなら	
	elseif targetDist >= 2.5 then
		Act01Per = 0		--ダッシュ接近＆3070斬り
		Act02Per = 0		--歩行接近＆小ジャンプ斬りコンボ
		Act03Per = 30		--歩行接近＆前ステップ斬りコンボ
		Act04Per = 20		--歩行接近＆いきなり掴む
		Act05Per = 20		--歩行接近＆近接コンボ
		Act06Per = 20		--歩行接近＆ラッシュ
		Act07Per = 0		--後ステップ斬り
		Act08Per = 0		--小ジャンプ斬り接近＆ラッシュなど攻撃	
		Act09Per = 10		--歩行接近＆強斬り
		Act10Per = 0		--その場で攻撃（衝撃波に頼る）
		Act11Per = 0		--その場で広範囲攻撃
		
	--後ステップ斬りをできない程度に離れているなら
	elseif targetDist >= 1.3 then
		Act01Per = 0		--ダッシュ接近＆3070斬り
		Act02Per = 0		--歩行接近＆小ジャンプ斬りコンボ
		Act03Per = 0		--歩行接近＆前ステップ斬りコンボ
		Act04Per = 20		--歩行接近＆いきなり掴む
		Act05Per = 40		--歩行接近＆近接コンボ
		Act06Per = 20		--歩行接近＆ラッシュ
		Act07Per = 0		--後ステップ斬り
		Act08Per = 0		--小ジャンプ斬り接近＆ラッシュなど攻撃
		Act09Per = 20		--歩行接近＆強斬り
		Act10Per = 0		--その場で攻撃（衝撃波に頼る）
		Act11Per = 0		--その場で広範囲攻撃
		
	--もっと近いなら
	else
		Act01Per = 0		--ダッシュ接近＆3070斬り
		Act02Per = 0		--歩行接近＆小ジャンプ斬りコンボ
		Act03Per = 0		--歩行接近＆前ステップ斬りコンボ
		Act04Per = 20		--歩行接近＆いきなり掴む
		Act05Per = 20		--歩行接近＆近接コンボ
		Act06Per = 20		--歩行接近＆ラッシュ
		Act07Per = 20		--後ステップ斬り
		Act08Per = 0		--小ジャンプ斬り接近＆ラッシュなど攻撃
		Act09Per = 20		--歩行接近＆強斬り
		Act10Per = 0		--その場で攻撃（衝撃波に頼る）
		Act11Per = 0		--その場で広範囲攻撃
		
	end
	
	--行動01　ダッシュ接近＆3070斬り
	if fate2 <= Act01Per then
		ai:SetNumber(0, 1);	-- ダッシュ切り中は割込み不可
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal( GOAL_COMMON_Attack2, 10.0, 3070, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動02　歩行接近＆小ジャンプ斬りコンボ
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, Att3090_Dist_max, TARGET_ENE_0, true, -1 );
		king723000Battle_Att3090(ai, goal)
		
	--行動03　歩行接近＆前ステップ斬りコンボ
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, Att3030_Dist_max, TARGET_ENE_0, true, -1 );
		king723000Battle_Att3030(ai, goal)
		
	--行動04　歩行接近＆いきなり掴む
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, Att3080_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3080, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動05　歩行接近＆近接コンボ
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per) then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, Att3010_Dist_max, TARGET_ENE_0, true, -1 );
		king723000Battle_Att3010(ai, goal)
		
	--行動06　歩行接近＆ラッシュ
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per) then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, Att3100_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3100, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動07　後ステップ斬り
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per) then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, Att3040_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動08　小ジャンプ斬り接近＆ラッシュなど攻撃
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per + Act08Per) then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3090, TARGET_ENE_0, DIST_Middle, 0);	
		if fate3 <= 80 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3100, TARGET_ENE_0, DIST_Middle, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	--行動09　強斬り
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per + Act08Per + Act09Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, Att3050_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
		if fate3 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3080, TARGET_ENE_0, DIST_Middle, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3100, TARGET_ENE_0, DIST_Middle, 0);
		end	
		
	--行動10　その場で攻撃（衝撃波に頼る）
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per + Act08Per + Act09Per + Act10Per) then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動10　その場で広範囲攻撃	
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3130, TARGET_ENE_0, DIST_None, 0);
		
	end
	king723000Battle_Kougeki_Noato(ai, goal)
	
end

---------------------------------------------------------
--  攻撃3010～
---------------------------------------------------------
function king723000Battle_Att3010(ai, goal)

local Att3010_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local Att3010_fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２


	--10％ 3010-3020
	--45％ 3010-3000-3010-3020
	--15％ 3010-3000-3010
	--10％ 3010-3000-3010-3040
	--20％ 3010-3000-step-3050
	if Att3010_fate <=10 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
	elseif Att3010_fate <= 55 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Middle, 0);
		elseif Att3010_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
	elseif Att3010_fate <= 80 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		if Att3010_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0.0, AI_DIR_TYPE_L, 3);
		else
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0.0, AI_DIR_TYPE_R, 3);
		end
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
---------------------------------------------------------
--  攻撃3030～
---------------------------------------------------------
function king723000Battle_Att3030(ai, goal)

local Att3030_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--50％ 3030
	--20％ 3030-3010-3020
	--5％ 3030-3010-3020-3040
	--20％ 3030-3100
	--5％ 3030-3100-3040
	if Att3030_fate <= 50 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3030_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3030_fate <= 75 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3030_fate <= 95 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3100, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3100, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
	end
end

---------------------------------------------------------
--  攻撃3090～
---------------------------------------------------------
function king723000Battle_Att3090(ai, goal)

local Att3090_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--50％ 3090
	--20％ 3090-3010-3020
	--5％ 3090-3010-3020-3040
	--20％ 3090-3100
	--5％ 3090-3100-3040
	if Att3090_fate <= 50 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3090, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3090_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3090, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3090_fate <= 75 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3090, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3090_fate <= 95 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3090, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3100, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3090, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3100, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
	end
end


	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function king723000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local KN_fate2 = ai:GetRandam_Int(1,100)		--確率判定用

	--40％　なにもしない
	--25％　横に歩行移動
	--20％　横にステップ移動
	--5％　後にステップ移動
	--10％　後ステップ斬り
	if KN_fate <= 40 then
		
	elseif KN_fate <= 65 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
		
	elseif KN_fate <= 85 then
		if KN_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0.0, AI_DIR_TYPE_L, 3);
		else
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0.0, AI_DIR_TYPE_R, 3);
		end	
		
	elseif KN_fate <= 90 then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 701, TARGET_ENE_0, 0.0, AI_DIR_TYPE_B, 3);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
	end
end


---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function king723000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function king723000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function king723000Battle_Interupt(ai, goal)

	if ai:GetNumber(0) == 1 then
		-- 番号スロット0に1が設定されている場合は割込み不可
		
-- スーパーアーマー入れるそうなのでリセットしない		
--		-- スーパーアーマーが入っていないので、食らったらリセットする
--		if ai:IsInterupt( INTERUPT_Damaged ) then
--			-- ダメージ食らった場合はやり直し
--			ai:Replaning();
--			return true;
--		end
		return false;
	end

	
-- PCが死亡した際、行動を止める
	if ai:IsInterupt( INTERUPT_ForgetTarget ) then
		goal:ClearSubGoal();
		ai:Replaning(); 
		return true; 
	end

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local Att3010_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3010_Dist_max = 2.8					--3000番の適正間合い（最大）
local Att3030_Dist_min = 2.5					--3030番の適正間合い（最小）
local Att3030_Dist_max = 5.6					--3030番の適正間合い（最大）
local Att3040_Dist_min = 0.0					--3030番の適正間合い（最小）
local Att3040_Dist_max = 1.3					--3030番の適正間合い（最大）
local Att3050_Dist_min = 0.0					--3050番の適正間合い（最小）
local Att3050_Dist_max = 3.5					--3050番の適正間合い（最大）
local Att3080_Dist_min = 0.0					--3080番の適正間合い（最小）
local Att3080_Dist_max = 3.0					--3080番の適正間合い（最大）
local Att3090_Dist_min = 4.5					--3090番の適正間合い（最小）
local Att3090_Dist_max = 6.0					--3090番の適正間合い（最大）	*旧6.5ｍ
local Att3100_Dist_min = 0.0					--3100番の適正間合い（最小）
local Att3100_Dist_max = 2.4					--3100番の適正間合い（最大）
local Att3110_Dist_min = 0.0					--3110番の適正間合い（最小）
local Att3110_Dist_max = 1.0					--3110番の適正間合い（最大）
local Att3130_Dist_min = 8.0					--3130番の適正間合い（最小）
local Att3130_Dist_max = 20.0					--3130番の適正間合い（最大）


	--空振り追撃　■共通関数
local missSwingDist = 2.4			--空振り追撃する距離
local missSwingAttPer = 50			--空振り追撃する確率	
	if MissSwing_Act(ai, goal, missSwingDist, missSwingAttPer ) then
		goal:ClearSubGoal();
		--40％ 掴む
		--30％ 強斬り
		--30％ ラッシュ
		if fate <= 40 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3080, TARGET_ENE_0, DIST_Middle, 0);
		elseif fate <= 70 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3100, TARGET_ENE_0, DIST_Middle, 0);
		end
		king723000Battle_Kougeki_Noato(ai, goal)
		return true;
	end

	
	--至近距離でダメージ受けたらコンボとみなして後退
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist	 = 1.5			--コンボ逃れする距離
local combRunPer	 = 60			--コンボ逃れする確率
local bkStepAttPer	 = 25			--後方ステップ攻撃で逃れようとする確率
local rushAttPer	 = 25			--ラッシュ攻撃する確率
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
				if fate2 <= bkStepAttPer then
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
					
				elseif fate2 <= (bkStepAttPer + rushAttPer) then	
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3100, TARGET_ENE_0, DIST_Middle, 0);
					king723000Battle_Kougeki_Noato(ai, goal)
					
				else
					if fate3 <= 60 then
						goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 701, TARGET_ENE_0, 0.0, AI_DIR_TYPE_B, 3);
					elseif fate3 <= 80 then
						goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0.0, AI_DIR_TYPE_L, 3);
					else
						goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0.0, AI_DIR_TYPE_R, 3);
					end
				end
				return true;
			end
		end
	end	

	
	--至近距離で攻撃されそうになったらステップ　■共通関数
local superStepDist		=2.0	--反応する距離
local superStepPer		=25		--反応する確率	
local bkStepPer			=60		--バックステップ確率
local leftStepPer		=20		--左ステップ確率
local rightStepPer		=20		--右ステップ確率
local safetyDist		=3.0	--安全確認距離	
FindAttack_SafetyStep(ai, goal, superStepDist, superStepPer, bkStepPer, leftStepPer, rightStepPer, safetyDist )

	
	--ガード崩壊したら攻撃
	if ai:IsInterupt( INTERUPT_GuardBreak ) then
local guardBreakConutDist = 3.7			--ガード崩壊で攻撃する距離
local guardBreakConutPer = 40			--ガード崩壊で攻撃する確率
		if targetDist <= guardBreakConutDist then
			if fate <= guardBreakConutPer then
				goal:ClearSubGoal();
				if fate <= 25 then
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3080, TARGET_ENE_0, DIST_Middle, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3100, TARGET_ENE_0, DIST_Middle, 0);
					king723000Battle_Kougeki_Noato(ai, goal)
				end
				return true;
			end
		end
	end
	
	--飛び道具を撃ってきたら最適行動
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 40					--飛び道具使用時に最適行動を取る確率（近いとき）
local shootIntPer2 = 65					--飛び道具使用時に最適行動を取る確率（やや遠いとき）
local shootIntPer3 = 90					--飛び道具使用時に最適行動を取る確率（遠いとき）
local Per2_Dist = 4.5					--「やや遠い」の距離
local Per3_Dist = 10.0					--「遠い」の距離

		--近い
		if targetDist <= Per2_Dist then
			if fate <= shootIntPer then
				goal:ClearSubGoal();
				if fate2 <= 50 then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0.0, AI_DIR_TYPE_L, 3);
				else
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0.0, AI_DIR_TYPE_R, 3);
				end
				return true
			end
			
		--やや遠い
		elseif targetDist <= Per3_Dist then
			if fate <= shootIntPer2 then
				goal:ClearSubGoal();
				if fate2 <= 50 then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0.0, AI_DIR_TYPE_L, 3);
				else
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0.0, AI_DIR_TYPE_R, 3);
				end
				return true
			end
			
		--遠い
		else
			if fate <= shootIntPer3 then
				goal:ClearSubGoal();
				if fate2 <= 50 then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0.0, AI_DIR_TYPE_L, 3);
				else
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0.0, AI_DIR_TYPE_R, 3);
				end
				return true
			end	
		end
	end
	
	--アイテムを使ったら最適行動
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 75				--アイテム使用時に最適行動を取る確率（近いとき）
local itemUseIntPer2 = 60				--アイテム使用時に最適行動を取る確率（やや遠いとき）
local itemUseIntPer3 = 45				--アイテム使用時に最適行動を取る確率（遠いとき）
local Per2_Dist = 3.7					--「やや遠い」の距離
local Per3_Dist = 10.0					--「遠い」の距離

		--近い
		if targetDist <= Per2_Dist then
			if fate <= itemUseIntPer then
				goal:ClearSubGoal();
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3080, TARGET_ENE_0, DIST_Middle, 0);
				return true
			end	
			
		--やや遠い
		elseif targetDist <= Per3_Dist then
			if fate <= itemUseIntPer2 then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, 6.5, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3090, TARGET_ENE_0, DIST_Middle, 0);	
				return true
			end	
			
		--遠い
		else
			if fate <= itemUseIntPer3 then
				ai:SetNumber(0, 1);	-- ダッシュ切り中は割込み不可
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal( GOAL_COMMON_Attack2, 10.0, 3070, TARGET_ENE_0, DIST_Middle, 0);
				return true
			end
		end	
	end
	
return false;
end

