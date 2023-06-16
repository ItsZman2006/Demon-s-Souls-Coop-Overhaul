-----------------------------------------------------------------------------------------------
--	影人（強い人）用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_kagebito212001_Battle, "kagebito212001_Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( kagebito212001_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function kagebito212001_Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local targetDistY = ai:GetDistY(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local height_dist = ai:GetDistYSigned(target);			--敵ターゲットがどれくらい上にいるか取得

local fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その３

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 1.8					--3000番の適正間合い（最大）
local Att3002_Dist_min = 0.0					--3002番の適正間合い（最小）
local Att3002_Dist_max = 2.0					--3002番の適正間合い（最大）
local Att3003_Dist_min = 0.0					--3003番の適正間合い（最小）
local Att3003_Dist_max = 3.2					--3003番の適正間合い（最大）
local Att3004_Dist_min = 0.0					--3004～3006番の適正間合い（最小）
local Att3004_Dist_max = 15.0					--3004～3006番の適正間合い（最大）

local Act01Per = 70		--歩行接近＆連続攻撃
local Act02Per = 10		--歩行接近＆両手で攻撃
local Act03Per = 20		--歩行接近＆薙ぎ払う
local Act04Per = 0		--その場でビーム攻撃（水平）
local Act05Per = 0		--その場でビーム攻撃（上）
local Act06Per = 0		--その場でビーム攻撃（下）
local Act07Per = 0		--15ｍくらいまで近づく
	
	--15ｍ以上離れている時
	if targetDist >= 15.0 then
		Act01Per = 0		--歩行接近＆連続攻撃
		Act02Per = 0		--歩行接近＆両手で攻撃
		Act03Per = 0		--歩行接近＆薙ぎ払う
		Act04Per = 0		--その場でビーム攻撃（水平）
		Act05Per = 0		--その場でビーム攻撃（上）
		Act06Per = 0		--その場でビーム攻撃（下）
		Act07Per = 100		--15ｍくらいまで近づく
		
	--7ｍ以上離れていて、相手が1～6ｍ上方にいるとき
	elseif targetDist >= 7.0 and height_dist >= 1.0 and height_dist <= 6.0 then
		Act01Per = 0		--歩行接近＆連続攻撃
		Act02Per = 5		--歩行接近＆両手で攻撃
		Act03Per = 5		--歩行接近＆薙ぎ払う
		Act04Per = 0		--その場でビーム攻撃（水平）
		Act05Per = 90		--その場でビーム攻撃（上）
		Act06Per = 0		--その場でビーム攻撃（下）
		Act07Per = 0		--15ｍくらいまで近づく
		
	--7ｍ以上離れていて、相手が1～6ｍ下方にいるとき
	elseif targetDist >= 7.0 and height_dist >= -6.0 and height_dist <= -1.0 then
		Act01Per = 0		--歩行接近＆連続攻撃
		Act02Per = 5		--歩行接近＆両手で攻撃
		Act03Per = 5		--歩行接近＆薙ぎ払う
		Act04Per = 0		--その場でビーム攻撃（水平）
		Act05Per = 0		--その場でビーム攻撃（上）
		Act06Per = 90		--その場でビーム攻撃（下）
		Act07Per = 0		--15ｍくらいまで近づく
		
	--7ｍ以上離れていて、相手との高低差が1ｍ以内のとき
	elseif targetDist >= 7.0 and height_dist >= -1.0 and height_dist <= 1.0 then
		Act01Per = 0		--歩行接近＆連続攻撃
		Act02Per = 5		--歩行接近＆両手で攻撃
		Act03Per = 5		--歩行接近＆薙ぎ払う
		Act04Per = 90		--その場でビーム攻撃（水平）
		Act05Per = 0		--その場でビーム攻撃（上）
		Act06Per = 0		--その場でビーム攻撃（下）
		Act07Per = 0		--15ｍくらいまで近づく		
		
	--7ｍ以内にいて、相手が1～3ｍ上方にいるとき
	elseif height_dist >= 1.0 and height_dist <= 3.0 then
		Act01Per = 10		--歩行接近＆連続攻撃
		Act02Per = 15		--歩行接近＆両手で攻撃
		Act03Per = 15		--歩行接近＆薙ぎ払う
		Act04Per = 0		--その場でビーム攻撃（水平）
		Act05Per = 60		--その場でビーム攻撃（上）
		Act06Per = 0		--その場でビーム攻撃（下）
		Act07Per = 0		--15ｍくらいまで近づく		
		
	--7ｍ以内にいて、相手が1～3ｍ下方にいるとき
	elseif height_dist >= -3.0 and height_dist <= -1.0 then
		Act01Per = 10		--歩行接近＆連続攻撃
		Act02Per = 15		--歩行接近＆両手で攻撃
		Act03Per = 15		--歩行接近＆薙ぎ払う
		Act04Per = 0		--その場でビーム攻撃（水平）
		Act05Per = 0		--その場でビーム攻撃（上）
		Act06Per = 60		--その場でビーム攻撃（下）
		Act07Per = 0		--15ｍくらいまで近づく			
		
	--7ｍ以内にいて、相手との高度差が1ｍ以内のとき	
	elseif height_dist >= -1.0 and height_dist <= -1.0 then
		Act01Per = 10		--歩行接近＆連続攻撃
		Act02Per = 15		--歩行接近＆両手で攻撃
		Act03Per = 15		--歩行接近＆薙ぎ払う
		Act04Per = 60		--その場でビーム攻撃（水平）
		Act05Per = 0		--その場でビーム攻撃（上）
		Act06Per = 0		--その場でビーム攻撃（下）
		Act07Per = 0		--15ｍくらいまで近づく			
		
	--どれにも当てはまらない（＝高低差が沢山ある）とき	
	else
		Act01Per = 30		--歩行接近＆連続攻撃
		Act02Per = 40		--歩行接近＆両手で攻撃
		Act03Per = 30		--歩行接近＆薙ぎ払う
		Act04Per = 0		--その場でビーム攻撃（水平）
		Act05Per = 0		--その場でビーム攻撃（上）
		Act06Per = 0		--その場でビーム攻撃（下）
		Act07Per = 0		--15ｍくらいまで近づく
		
	end
	
	
	--行動01　歩行接近＆連続攻撃
	if fate2 <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, -1 );
		kagebito212001_Battle_Kougeki(ai, goal)
		kagebito212001_Battle_Kougeki_Noato(ai, goal)
		
	--行動02　歩行接近＆両手で攻撃
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		kagebito212001_Battle_Kougeki_Noato(ai, goal)
		
	--行動03　歩行接近＆薙ぎ払う
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		kagebito212001_Battle_Kougeki_Noato(ai, goal)
		
	--行動04　その場でビーム攻撃（水平）
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3004_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_None, 0);
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(1.0,3.0), TARGET_ENE_0, 0, 0, 0 );
		
	--行動05　その場でビーム攻撃（上）
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3004_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3005, TARGET_ENE_0, DIST_None, 0);
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(1.0,3.0), TARGET_ENE_0, 0, 0, 0 );
		
	--行動06　その場でビーム攻撃（下）
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3004_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3006, TARGET_ENE_0, DIST_None, 0);
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(1.0,3.0), TARGET_ENE_0, 0, 0, 0 );
		
	--行動07　15ｍくらいまで近づく
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 14.0, TARGET_ENE_0, true, -1 );
	end
	
end


---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function kagebito212001_Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--5% 3000
	--60% 3000-3001
	--35% 3000-3001-3002
	if K_fate <= 5 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif K_fate <= 65 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0); 
		
	end
end

	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function kagebito212001_Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

local SideTime = 3.0							--横に動く時間
local BackDist = 2.0							--後退する距離
local BackTime = 3.0							--後退する時間

	
	--90％　一呼吸
	--5％　少しだけ横に移動
	--5％　少しだけ下がる
	if KN_fate <= 90 then
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(1.0,3.0), TARGET_ENE_0, 0, 0, 0 );
		
	elseif KN_fate <= 95 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
		
	else
		goal:AddSubGoal(GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );
	end
end

	
	
---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function kagebito212001_Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function kagebito212001_Battle_Terminate(ai, goal)
end

---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function kagebito212001_Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local targetDistY = ai:GetDistY(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 1.8					--3000番の適正間合い（最大）
local Att3002_Dist_min = 0.0					--3002番の適正間合い（最小）
local Att3002_Dist_max = 2.0					--3002番の適正間合い（最大）
local Att3003_Dist_min = 0.0					--3003番の適正間合い（最小）
local Att3003_Dist_max = 3.2					--3003番の適正間合い（最大）
local Att3004_Dist_min = 0.0					--3004～3006番の適正間合い（最小）
local Att3004_Dist_max = 15.0					--3004～3006番の適正間合い（最大）


	--ガード崩壊したら攻撃　■共通関数
local guardBreakConutDist = 3.2			--ガード崩壊で攻撃する距離
local guardBreakConutPer = 65			--ガード崩壊で攻撃する確率
	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
		goal:ClearSubGoal();
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		kagebito212001_Battle_Kougeki_Noato(ai, goal)
		return true;
	end	

	--飛び道具追い討ち
	--ターゲットが飛び道具を発射したら、まれに走って近づく
local farResDist	=5.0	--反応する距離
local farResPer		=20		--反応する確率
	if FarDamaged_Act(ai, goal, farResDist, farResPer ) then
		goal:ClearSubGoal();
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		return true;
	end	


return false;
end





			


	