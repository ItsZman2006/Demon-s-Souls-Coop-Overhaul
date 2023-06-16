-----------------------------------------------------------------------------------------------
--	【奴隷兵士（短剣）】用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_DoreiTANKEN200000_Battle, "doreiTANKEN200000Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_DoreiTANKEN200000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function doreiTANKEN200000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------


local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その３
local fate4 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その４
local fate5 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その５

local eventNo = ai:GetEventRequest();					--イベントからのリクエスト番号を取得
local role = ai:GetTeamOrder(ORDER_TYPE_Role);			--自分の役割を取得


	--レンドル王子追い込み行動（イベント用）
	--威嚇中だったら
	if eventNo == AI_EVENT_DOREI_IKAKU then
		--100％右へ、左へ、威嚇
		--25％威嚇
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 4.0, TARGET_EVENT, 0, ai:GetRandam_Int(15), true, true ,-1 );
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 4.0, TARGET_EVENT, 1, ai:GetRandam_Int(15), true, true ,-1 );
		goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0, 7000, TARGET_EVENT, DIST_None, 0);
		if fate <= 25 then
			goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0, 7000, TARGET_EVENT, DIST_None, 0);
		end
		
		
	--威嚇中ではなかったら
	else
		--攻撃役、その他役なら
		if role == ROLE_TYPE_Attack or role == ROLE_TYPE_None then
			local Att3300Per = 0		--超ジャンプ攻撃の確率
			local Att3003Per = 0		--遠ジャンプ攻撃の確率
			local Att3004Per = 0		--近ジャンプ攻撃の確率
			local AttNormalPer = 100	--近距離攻撃　　の確率	
			
			--距離別に確率を決める
			if targetDist >= 9.0 then
				Att3300Per = 75	
				Att3003Per = 10	
				Att3004Per = 10
				AttNormalPer = 5
				
			elseif targetDist >= 7.0 then
				Att3300Per = 0
				Att3003Per = 70
				Att3004Per = 20	
				AttNormalPer = 10
				
			elseif targetDist >= 2.0 then
				Att3300Per = 0
				Att3003Per = 0
				Att3004Per = 25
				AttNormalPer = 75	
				
			else
				Att3300Per = 0
				Att3003Per = 0
				Att3004Per = 0
				AttNormalPer = 100	
				
			end
			
			--移動＆攻撃
			if fate <= Att3300Per then
				goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 6.7, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_None, 0);
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_None, 0);
				
			elseif fate <= (Att3300Per + Att3003Per) then	
				goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 4.7, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_None, 0);
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_None, 0);
				
			elseif fate <= (Att3300Per + Att3003Per + Att3004Per) then		
				goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 2.8, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_None, 0);
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_None, 0);
				
			else
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 1.3, TARGET_ENE_0, true, -1 );
				doreiTANKEN200000Battle_Kougeki(ai, goal)
				
			end
			doreiTANKEN200000Battle_Kougeki_Noato(ai, goal)	
			
		--取り巻き役なら
		elseif role == ROLE_TYPE_Torimaki then
			--遠ければ、走って近づいてくる
			if targetDist >= 15.0 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 4.5, TARGET_ENE_0, false, -1 );
			--近ければ、歩いて近づいてくる
			elseif targetDist >= 6.0 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 4.5, TARGET_ENE_0, true, -1 );
			--適度な距離ならば、横に動く
			elseif targetDist >= 3.0 then
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,9910 );
			--近すぎれば、離れる
			else
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, true, 9910 );
			end
			--攻撃後っぽくウロウロ
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,9910 );
			
		--観衆役なら
		else
			--遠ければ、走って近づいてくる
			if targetDist >= 15.0 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 6.5, TARGET_ENE_0, false, -1 );
			--近ければ、歩いて近づいてくる
			elseif targetDist >= 8.0 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 6.5, TARGET_ENE_0, true, -1 );
			--適度な距離ならば、横に動く
			elseif targetDist >= 4.0 then
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,9910 );
			--近すぎれば、離れる
			else
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 6.0, TARGET_ENE_0, true, 9910 );
			end
			--攻撃後っぽくウロウロ
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,9910 );
		end
	end
end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function doreiTANKEN200000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--15% 3002
	--30% 3001-3000
	--15% 3001-3002
	--40% 3000-3006
	if K_fate <= 15 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 45 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 60 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3006, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function doreiTANKEN200000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local SideTime = 5.0							--横に動く時間
local BackDist = 2.5							--後退する距離
local BackTime = 5.0							--後退する時間
local bRight = ai:GetRandam_Int(0,1);			--右か左か
-- 同じ方向に左右移動している仲間の数
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);

	--85% 一呼吸
	--10% 適当に横にガード移動
	--5% 後ろにガード移動
	if KN_fate <= 85 then
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.5,1.0) ,0,0,0,0)
	elseif KN_fate <= 95 and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, bRight, ai:GetRandam_Int(30,45), true, true ,9910 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, 9910 );				
	end
end

	
	
---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function doreiTANKEN200000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function doreiTANKEN200000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function doreiTANKEN200000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２

	--ガード崩壊したら攻撃　■共通関数
local guardBreakConutDist = 5.0			--ガード崩壊で攻撃する距離
local guardBreakConutPer = 65			--ガード崩壊で攻撃する確率
	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
		goal:ClearSubGoal();
		
		--距離別に対応
		if targetDist >= 3.0 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_None, 0);
			
		elseif targetDist >= 2.0 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_None, 0);
			
		else
			if fate <= 50 then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3006, TARGET_ENE_0, DIST_Middle, 0);
			end
			
		end
		doreiTANKEN200000Battle_Kougeki_Noato(ai, goal)
		return true;
	end	
	
	
	--コンボ逃れ　■共通関数
local combRunDist = 1.3				--コンボ逃れする距離
local combRunPer = 75				--コンボ逃れする確率
	if Damaged_Act(ai, goal, combRunDist, combRunPer ) then
		goal:ClearSubGoal();
		doreiTANKEN200000Battle_Kougeki(ai, goal)
		doreiTANKEN200000Battle_Kougeki_Noato(ai, goal)
		return true;
	end	

	
return false;
end


	