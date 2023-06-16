-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
--	Huhai210003専用戦闘
--	説明：呪術師用（3006 魔法を使う）
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Huhai210003_Battle, "Huhai210003Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Huhai210003_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function Huhai210003Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離
local fate = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　その３
local sekkin = ai:GetRandam_Float(2, 3.5)				--接近する距離
local maai = ai:GetRandam_Float(2, 3.5)					--間合い調整する距離

local farDist = 10.0		--遠いと判断する距離
local nearDist = 7.0		--近いと判断する距離
local maaiDist = 4.5		--攻撃のために近づく距離
local pushDist = 2.0		--突き落とす距離

	-- 最初にちょっとだけ待つ
	if ai:IsFinishTimer(0) == true then
		local firstTime = ai:GetRandam_Float(0.0, 1.2)			--最初の動き出しまでの時間
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
		--20% 歩き接近→回り込み＆再接近
		--70% 魔法を放って逃げる
		--10% 距離を保つ
		if fate < 20 then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			if fate2 < 50 then
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 1.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
				goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			end

		elseif fate < 90 then
			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3006, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 8.0, TARGET_SELF, false, -1 );
		
		else
			goal:AddSubGoal(GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, maaiDist, nearDist, TARGET_ENE_0, false, -1 );
			
		end
		
	--至近なら
	elseif targetDist <= pushDist then
		--40% 突き落とし攻撃して逃げる　60% 叩きつけて逃げる　（成功したら相手に旋回）
		if fate < 40 then
			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3003, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 8.0, TARGET_SELF, false, -1 );
			goal:AddSubGoal(GOAL_COMMON_Turn, 3.0, TARGET_ENE_0 );
		else
			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3001, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 8.0, TARGET_SELF, false, -1 );
			goal:AddSubGoal(GOAL_COMMON_Turn, 3.0, TARGET_ENE_0 );
		end
		
	else
	--間合い以内なら
		--攻撃する
		--攻撃後行動
		Huhai210003Battle_Kougeki(ai, goal)
		Huhai210003Battle_Kougeki_Noato(ai, goal)
	end
end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function Huhai210003Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--40% 3000 攻撃（小）
	--20% 3006 魔法を放つ
	--20% 3000-3001 攻撃（小）＆攻撃（中）
	--10% 3300 両手攻撃
	--00% 3002 暴れる
	--00% 3003 突き落とす
	--10% 3004 突進体当たり

	if K_fate < 40 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
	elseif K_fate < 60 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3006, TARGET_ENE_0, DIST_None, 0);
	elseif K_fate < 80 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Near, 0);
	elseif K_fate < 90 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Near, 0);
	elseif K_fate < 90 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Near, 0);
	elseif K_fate < 90 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Near, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Near, 0);
	end
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function Huhai210003Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local SideTime = 0.1							--横に動く時間
local BackDist = ai:GetRandam_Float(8.0, 10.0)	--後退する距離
local BackTime = 5.0							--後退する時間


local bRight = ai:GetRandam_Int(0,1);							--左右移動の方向
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- 同じ方向に左右移動している仲間の数



--後ろに下がった後にときどき横移動させると良いかも
--あまりに近すぎる横移動よりも、すこし下がってから横移動させると良いかも

	--40% なにもしない（ちょっとだけ横移動）
	--10% 適当に横に移動
	--50% 後ろに移動
	if KN_fate < 10  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 1.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 10, true, true ,-1 );
	elseif KN_fate < 30  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
	else
		goal:AddSubGoal(GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_SELF, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_Turn, 3.0, TARGET_ENE_0 );
	end
end



---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function Huhai210003Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function Huhai210003Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function Huhai210003Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字
local maaiDist = 1.0										--攻撃のために近づく距離　★汎用化の為、攻撃ごとに分けず★

	--空振り追い討ち
	--25％　近くのターゲットが空振りしたら攻撃
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < maaiDist then
			if fate <= 25 then
				goal:ClearSubGoal();
				Huhai210003Battle_Kougeki(ai, goal)
				Huhai210003Battle_Kougeki_Noato(ai, goal)
				return true;
			end	
		end
	end

return false;

end

