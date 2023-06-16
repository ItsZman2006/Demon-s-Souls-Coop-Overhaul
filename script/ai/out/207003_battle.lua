-----------------------------------------------------------------------------------------------
--	虜囚戦闘
--	説明：
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Ryosyu207003_Battle, "Ryosyu207003Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Ryosyu207003_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function Ryosyu207003Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

	local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離
	local fate = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字
	local fate2 = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　その２
	local fate3 = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　その３
	local sekkin = ai:GetRandam_Float(0.75, 1.5)			--接近する距離
	local maai = ai:GetRandam_Float(0.75, 1.5)				--間合い調整する距離
	local rate = ai:GetHpRate( TARGET_SELF )				--自分のHP

	local farDist = 10.0		--遠いと判断する距離
	local nearDist = 7.5		--近いと判断する距離
	local maaiDist = 5.5		--攻撃のために近づく距離　★汎用化の為、攻撃ごとに分けず★


	
	--遠いなら
	if targetDist >= nearDist then
		--10％　歩き接近
		--35％　歩きから走り接近
		--55％　走り接近
		if fate < 10 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
		elseif fate < 45 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, (targetDist - 3.0), TARGET_ENE_0, true, -1 );
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );			
		else
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
		end
		
	--近いなら
	elseif targetDist >= maaiDist then
		--60％　歩き接近→回り込み＆再接近　　40％　距離保つ→70%突進体当たり30%攻撃（中）・
		if fate < 60 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			if fate2 < 20 then
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(10,20), true, true ,-1 );
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			end
		else

			goal:AddSubGoal( GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, maaiDist, nearDist, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3002, TARGET_ENE_0, DIST_Near, 0);

		end
		
	else
	--間合い以内なら
		--攻撃する
		--攻撃後行動
		Ryosyu207003Battle_Attack(ai, goal)
		Ryosyu207003Battle_AfterAttack(ai, goal)
	end
end

	
	
---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function Ryosyu207003Battle_Attack(ai, goal)

	local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	
	if K_fate <= 100 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
	end

end

	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function Ryosyu207003Battle_AfterAttack(ai, goal)

	local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
	local SideTime = 0.7							--横に動く時間
	local BackDist = 1.0							--後退する距離
	local BackTime = 0.7							--後退する時間
	local bRight = ai:GetRandam_Int(0,1);			--右か左か
	-- 同じ方向に左右移動している仲間の数
	local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);

	--85% 一呼吸	--5% 適当に横にガード移動	--10% 後ろにガード移動
	if KN_fate <= 85 then
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.2,0.6) ,0,0,0,0)
	elseif KN_fate <= 90 and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, bRight, ai:GetRandam_Int(30,45), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end


---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function Ryosyu207003Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function Ryosyu207003Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function Ryosyu207003Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字
local maaiDist = 1.0										--攻撃のために近づく距離　★汎用化の為、攻撃ごとに分けず★

	--空振り追い討ち
	--25％　近くのターゲットが空振りしたら攻撃
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < maaiDist then
			if fate <= 25 then
				goal:ClearSubGoal();
				Ryosyu207003Battle_Attack(ai, goal)
				Ryosyu207003Battle_AfterAttack(ai, goal)
				return true;
			end	
		end
	end

return false;

end

