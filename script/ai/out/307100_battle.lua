-----------------------------------------------------------------------------------------------
--	Namekuji307100専用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Namekuji307100_Battle, "Namekuji307100Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Namekuji307100_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function Namekuji307100Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate1 = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字	
local fate2 = ai:GetRandam_Int(1,100)
local fate3 = ai:GetRandam_Int(1,100)
local fate4 = ai:GetRandam_Int(1,100)

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 1.5					--3000番の適正間合い（最大）
local Att3002_Dist_min = 0.0					--3002番の適正間合い（最小）
local Att3002_Dist_max = 3.0					--3002番の適正間合い（最大）
local Att3003_Dist_min = 0.0					--3003番の適正間合い（最小）
local Att3003_Dist_max = 5.0					--3003番の適正間合い（最大）

local Act01Per = 0		--歩行＆噛み付き
local Act02Per = 0		--歩行＆飛び掛り
local Act03Per = 0		--歩行＆光粘液

	--ナメクジ的に遠いなら
	if targetDist >= 4.0 then
		Act01Per = 0		--歩行＆噛み付き
		Act02Per = 5		--歩行＆飛び掛り
		Act03Per = 95		--歩行＆光粘液
		
	--ナメクジ的にやや遠いなら	
	elseif targetDist >= 2.0 then
		Act01Per = 5		--歩行＆噛み付き
		Act02Per = 35		--歩行＆飛び掛り
		Act03Per = 60		--歩行＆光粘液
		
	--もっと近いなら
	else
		Act01Per = 20		--歩行＆噛み付き
		Act02Per = 20		--歩行＆飛び掛り
		Act03Per = 60		--歩行＆光粘液
	end

	--行動01　歩行＆噛み付き
	if fate2 <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動02　歩行＆飛び掛り
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動03　歩行＆光粘液
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);	
	end
	goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (2.0,4.0) ,0,0,0,0)

	
end

---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function Namekuji307100Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function Namekuji307100Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function Namekuji307100Battle_Interupt(ai, goal)

return false;

end
