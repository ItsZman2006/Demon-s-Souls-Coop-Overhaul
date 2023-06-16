-----------------------------------------------------------------------------------------------
--	軍用犬用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Gunyou301000_Battle, "gunyou301000Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Gunyou301000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function gunyou301000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得
local targethprate = ai:GetHpRate( TARGET_ENE_0 )		--敵ターゲットのHP割合を取得
local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)							--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)							--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)							--確率判定で使用する運命の数字　その３
local fate4 = ai:GetRandam_Int(1,100)							--確率判定で使用する運命の数字　その４

local role = ai:GetTeamOrder(ORDER_TYPE_Role);					--自分の役割を取得
local bRight = ai:GetRandam_Int(0,1);							--左右移動の方向
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- 同じ方向に左右移動している仲間の数

local Att3000_Dist_min = 0.5					--3000番の適正間合い（最小）
local Att3000_Dist_max = 2.2					--3000番の適正間合い（最大）
local Att3001_Dist_min = 0.0					--3001番の適正間合い（最小）
local Att3001_Dist_max = 0.5					--3001番の適正間合い（最大）
local Att3300_Dist_min = 2.0					--3300番の適正間合い（最小）
local Att3300_Dist_max = 4.3					--3300番の適正間合い（最大）
local Att3301_Dist_min = 2.0					--3301番の適正間合い（最小）
local Att3301_Dist_max = 6.4					--3301番の適正間合い（最大）
local Att3302_Dist_min = 4.0					--3302番の適正間合い（最小）
local Att3302_Dist_max = 8.4					--3302番の適正間合い（最大）

local Act01Per = 0		--ダッシュ接近＆突進飛びかかり
local Act02Per = 0		--ダッシュ接近＆飛びかかり・ジャンプ高い
local Act03Per = 0		--ダッシュ接近＆飛びかかり
local Act04Per = 0		--ダッシュ接近＆かみつく	
local Act05Per = 0		--歩行接近＆突進飛びかかり
local Act06Per = 0		--歩行接近＆飛びかかり・ジャンプ高い
local Act07Per = 0		--歩行接近＆飛びかかり
local Act08Per = 0		--歩行接近＆かみつく	
local Act09Per = 0		--ダッシュで離れる	


	--ダッシュ＆突進飛びかかり　しても良い程度に遠いなら	
	if targetDist >= 11.4 then	
		Act01Per = 75		--ダッシュ接近＆突進飛びかかり
		Act02Per = 15		--ダッシュ接近＆飛びかかり・ジャンプ高い
		Act03Per = 10		--ダッシュ接近＆飛びかかり
		Act04Per = 0		--ダッシュ接近＆かみつく	
		Act05Per = 0		--歩行接近＆突進飛びかかり
		Act06Per = 0		--歩行接近＆飛びかかり・ジャンプ高い
		Act07Per = 0		--歩行接近＆飛びかかり
		Act08Per = 0		--歩行接近＆かみつく
		Act09Per = 0		--ダッシュで離れる	
		
	--ダッシュ＆飛びかかり・ジャンプ高い　しても良い程度に遠いなら		
	elseif targetDist >= 8.4 then	
		Act01Per = 0		--ダッシュ接近＆突進飛びかかり
		Act02Per = 50		--ダッシュ接近＆飛びかかり・ジャンプ高い
		Act03Per = 15		--ダッシュ接近＆飛びかかり
		Act04Per = 5		--ダッシュ接近＆かみつく	
		Act05Per = 30		--歩行接近＆突進飛びかかり
		Act06Per = 0		--歩行接近＆飛びかかり・ジャンプ高い
		Act07Per = 0		--歩行接近＆飛びかかり
		Act08Per = 0		--歩行接近＆かみつく
		Act09Per = 0		--ダッシュで離れる	
		
	--ダッシュ＆飛びかかり　しても良い程度に遠いなら		
	elseif targetDist >= 6.3 then	
		Act01Per = 0		--ダッシュ接近＆突進飛びかかり
		Act02Per = 0		--ダッシュ接近＆飛びかかり・ジャンプ高い
		Act03Per = 35		--ダッシュ接近＆飛びかかり
		Act04Per = 5		--ダッシュ接近＆かみつく	
		Act05Per = 50		--歩行接近＆突進飛びかかり
		Act06Per = 10		--歩行接近＆飛びかかり・ジャンプ高い
		Act07Per = 0		--歩行接近＆飛びかかり
		Act08Per = 0		--歩行接近＆かみつく
		Act09Per = 0		--ダッシュで離れる	
		
	--歩行＆突進飛びかかり　および　ダッシュ＆かみつく　しても良い程度に遠いなら		
	elseif targetDist >= 4.0 then	
		Act01Per = 0		--ダッシュ接近＆突進飛びかかり
		Act02Per = 0		--ダッシュ接近＆飛びかかり・ジャンプ高い
		Act03Per = 0		--ダッシュ接近＆飛びかかり
		Act04Per = 20		--ダッシュ接近＆かみつく	
		Act05Per = 50		--歩行接近＆突進飛びかかり
		Act06Per = 20		--歩行接近＆飛びかかり・ジャンプ高い
		Act07Per = 10		--歩行接近＆飛びかかり
		Act08Per = 0		--歩行接近＆かみつく
		Act09Per = 0		--ダッシュで離れる	
		
	--歩行＆飛びかかり・ジャンプ高い　しても良い程度に近いなら	
	elseif targetDist >= 2.0 then	
		Act01Per = 0		--ダッシュ接近＆突進飛びかかり
		Act02Per = 0		--ダッシュ接近＆飛びかかり・ジャンプ高い
		Act03Per = 0		--ダッシュ接近＆飛びかかり
		Act04Per = 0		--ダッシュ接近＆かみつく	
		Act05Per = 0		--歩行接近＆突進飛びかかり
		Act06Per = 50		--歩行接近＆飛びかかり・ジャンプ高い
		Act07Per = 40		--歩行接近＆飛びかかり
		Act08Per = 10		--歩行接近＆かみつく
		Act09Per = 0		--ダッシュで離れる			
		
	--もっと近いなら	
	else
		Act01Per = 0		--ダッシュ接近＆突進飛びかかり
		Act02Per = 0		--ダッシュ接近＆飛びかかり・ジャンプ高い
		Act03Per = 0		--ダッシュ接近＆飛びかかり
		Act04Per = 0		--ダッシュ接近＆かみつく	
		Act05Per = 0		--歩行接近＆突進飛びかかり
		Act06Per = 0		--歩行接近＆飛びかかり・ジャンプ高い
		Act07Per = 0		--歩行接近＆飛びかかり
		Act08Per = 70		--歩行接近＆かみつく
		Act09Per = 30		--ダッシュで離れる		
	end

	--行動01　ダッシュ接近＆突進飛びかかり	
	if fate2 <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3302_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3302, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_Attack2, 5.0, 3302, TARGET_ENE_0, DIST_Near, 0);
		if fate3 <= 5 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		end
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 12.0, TARGET_SELF, false, -1 );
		
		
	--行動02　ダッシュ接近＆飛びかかり・ジャンプ高い
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3301_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3301, TARGET_ENE_0, DIST_Near, 0);
		if fate3 <= 5 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		end
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 12.0, TARGET_SELF, false, -1 );
		
	--行動03　ダッシュ接近＆飛びかかり
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then	
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3300_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Near, 0);
		if fate3 <= 5 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		end
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 12.0, TARGET_SELF, false, -1 );
		
	--行動04　ダッシュ接近＆かみつく	
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		if fate3 <= 20 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		end
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 12.0, TARGET_SELF, false, -1 );		
		
	--行動05　歩行接近＆突進飛びかかり
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3302_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3302, TARGET_ENE_0, DIST_Near, 0);
		if fate3 <= 5 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		end
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 12.0, TARGET_SELF, false, -1 );	
		
	--行動06　歩行接近＆飛びかかり・ジャンプ高い
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per) then	
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3301_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3301, TARGET_ENE_0, DIST_Near, 0);
		if fate3 <= 5 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		end
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 12.0, TARGET_SELF, false, -1 );
		
	--行動07　歩行接近＆飛びかかり
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per) then	
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3300_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Near, 0);
		if fate3 <= 5 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		end
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 12.0, TARGET_SELF, false, -1 );
		
	--行動08　歩行接近＆かみつく	
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per + Act08Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		if fate3 <= 20 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		end
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 12.0, TARGET_SELF, false, -1 );	
		
	--行動09　ダッシュで離れる
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 12.0, TARGET_SELF, false, -1 );	
		
	end
	
end

	
---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function gunyou301000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function gunyou301000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function gunyou301000Battle_Interupt(ai, goal)

return false;
end



	