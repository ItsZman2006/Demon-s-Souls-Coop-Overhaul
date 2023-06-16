-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
--	Huhai210002専用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Huhai210002_Battle, "Huhai210002Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Huhai210002_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function Huhai210002Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離
local fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その３
local sekkin = ai:GetRandam_Float(2, 3.5)		--接近する距離
local maai = ai:GetRandam_Float(2, 3.5)			--間合い調整する距離

local farDist = 10.0		--遠いと判断する距離
local nearDist = 7.0		--近いと判断する距離
local maaiDist = 3.2		--攻撃のために近づく距離
local pushDist = 1.0		--突き落とす距離

	-- 最初にちょっとだけ待つ
	if ai:IsFinishTimer(0) == true then
		local firstTime = ai:GetRandam_Float(0.0, 0.1)			--最初の動き出しまでの時間
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
		ai:SetTimer( 0, 9999.0 );
	end

	--遠いなら
	if targetDist >= nearDist then
		--10％　歩き接近
		--35％　歩きから走り接近
		--55％　走り接近
		if fate < 10 then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
		elseif fate < 45 then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, (targetDist - 3.0), TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );			
		else
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
		end
		
	--近いなら
	elseif targetDist >= maaiDist then
		--60％　歩き接近→回り込み＆再接近　40％　急接近→50%二回突く50%突く 
		if fate < 60 then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			if fate2 < 50 then
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 1.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
				goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			end
		else
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
--~ 			goal:AddSubGoal(GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, maaiDist, nearDist, TARGET_ENE_0, false, -1 );
			if fate2 < 50 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3002, TARGET_ENE_0, DIST_Near, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
			end
		end
		
	--至近なら
	elseif targetDist <= pushDist then
		--40% 突き落とし攻撃して後ろに下がる　60% 叩きつけて後ろに下がる　（成功したら相手に旋回）
		if fate < 40 then
			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3003, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, true, -1 );
--~ 			goal:AddSubGoal(GOAL_COMMON_Turn, 3.0, TARGET_ENE_0 );
		else
			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3001, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, 4.0, TARGET_E, true, -1 );
--~ 			goal:AddSubGoal(GOAL_COMMON_Turn, 3.0, TARGET_ENE_0 );
		end
		
	else
	--間合い以内なら
		--攻撃する
		--攻撃後行動
		Huhai210002Battle_Kougeki(ai, goal)
		Huhai210002Battle_Kougeki_Noato(ai, goal)
	end
end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function Huhai210002Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--45% 3000　突く
	--10% 3000-3001　突く＆叩きつける
	--40% 3002　2回突き
	--05% 3003　突き落とす
	if K_fate < 25 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
	elseif K_fate < 75 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Near, 0);
	elseif K_fate < 95 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Near, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Near, 0);
	end
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function Huhai210002Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local SideTime = 0.1							--横に動く時間
local BackDist = ai:GetRandam_Float(3.0, 4.5)	--後退する距離
local BackTime = 1.5							--後退する時間


local bRight = ai:GetRandam_Int(0,1);							--左右移動の方向
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- 同じ方向に左右移動している仲間の数



--後ろに下がった後にときどき横移動させると良いかも
--あまりに近すぎる横移動よりも、すこし下がってから横移動させると良いかも

	--10% なにもしない（ちょっとだけ横移動）
	--20% 適当に横に移動
	--70% 後ろに移動
	if KN_fate < 10  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 1.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 10, true, true ,-1 );
	elseif KN_fate < 30  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
	else
		goal:AddSubGoal(GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );
--~ 		goal:AddSubGoal(GOAL_COMMON_Turn, 3.0, TARGET_ENE_0 );
	end
end



---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function Huhai210002Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function Huhai210002Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function Huhai210002Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字
local maaiDist = 1.0										--攻撃のために近づく距離　★汎用化の為、攻撃ごとに分けず★

	--空振り追い討ち
	--25％　近くのターゲットが空振りしたら攻撃
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < maaiDist then
			if fate <= 25 then
				goal:ClearSubGoal();
				Huhai210002Battle_Kougeki(ai, goal)
				Huhai210002Battle_Kougeki_Noato(ai, goal)
				return true;
			end	
		end
	end

return false;

end

