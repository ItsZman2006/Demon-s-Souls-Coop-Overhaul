-----------------------------------------------------------------------------------------------
--	Mukade507000専用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Mukade507000_Battle, "Mukade507000Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Mukade507000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function Mukade507000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離
local fate = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　その２
local maai = ai:GetRandam_Float(0.75, 1.5)				--間合い調整する距離

local farDist = 10.0		--遠いと判断する距離
local nearDist = 6.0		--近いと判断する距離
local maaiDist = 1.5		--攻撃のために近づく距離　★汎用化の為、攻撃ごとに分けず★

	-- 最初にちょっとだけ待つ
	if ai:IsFinishTimer(0) == true then
		local firstTime = ai:GetRandam_Float(0.0, 1.0)			--最初の動き出しまでの時間
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
		ai:SetTimer( 0, 9999.0 );
	end

	--近くないなら
	if targetDist >= nearDist then
		--75％　走り接近
		--25％　待機
		if fate < 75 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
		else
			goal:AddSubGoal(GOAL_COMMON_Wait,2.0,TARGET_ENE_0, 0, 0, 0 );
		end
		
	--近いなら
	elseif targetDist >= maaiDist then
		--60％　走り接近→再接近　　40％　さらに接近→攻撃�
		if fate < 60 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
			if fate2 < 50 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
			end
		else
			goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, maaiDist, nearDist, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3001, TARGET_ENE_0, DIST_Near, 0);
		end
		
	else
	--間合い以内なら
		--攻撃する
		--攻撃後行動
		Mukade507000Battle_Kougeki(ai, goal)
		Mukade507000Battle_Kougeki_Noato(ai, goal)
	end
end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function Mukade507000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--100% 3000　攻撃
	if (K_fate < 80) and not((AI_EVENT_MUKADE_TALE_CUT==ai:GetEventRequest(0)) )  then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Near, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
	end
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function Mukade507000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local SideTime = 0.0							--横に動く時間
local BackDist = ai:GetRandam_Float(0.5, 1.0)	--後退する距離
local BackTime = 1.0							--後退する時間


local bRight = ai:GetRandam_Int(0,1);							--左右移動の方向
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- 同じ方向に左右移動している仲間の数


	--50% なにもしない（ちょっとだけ横移動）
	--50% 間合いまで接近
	--0% 後ろに移動
	if KN_fate < 50  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
	elseif KN_fate < 100  and friendNum < 1 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end



---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function Mukade507000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function Mukade507000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function Mukade507000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);				--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字
local maaiDist = 1.0										--攻撃のために近づく距離　★汎用化の為、攻撃ごとに分けず★

	--空振り追い討ち
	--25％　近くのターゲットが空振りしたら攻撃
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < maaiDist then
			if fate <= 25 then
				goal:ClearSubGoal();
				Mukade507000Battle_Kougeki(ai, goal)
				Mukade507000Battle_Kougeki_Noato(ai, goal)
				return true;
			end	
		end
	end

return false;

end
