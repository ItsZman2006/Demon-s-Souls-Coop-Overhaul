-----------------------------------------------------------------------------------------------
--	Haetakari508000専用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Haetakari508000_Battle, "Haetakari508000Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Haetakari508000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function Haetakari508000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離
local fate = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　その３
local sekkin = ai:GetRandam_Float(0.75, 1.5)			--接近する距離
local maai = ai:GetRandam_Float(0.75, 1.5)				--間合い調整する距離
local rate = ai:GetHpRate( TARGET_SELF )				--自分のHP

local farDist = 15.0		--遠いと判断する距離
local masiDist = 10.0		--蝿マシンガンを放つ距離
local nearDist = 5.5		--近いと判断する距離
local maaiDist = 2.0		--攻撃のために近づく距離　★汎用化の為、攻撃ごとに分けず★

local SideTime = 5.0		--横に動く時間

	-- 最初にちょっとだけ待つ
	if ai:IsFinishTimer(0) == true then
		local firstTime = ai:GetRandam_Float(0.0, 1.0)			--最初の動き出しまでの時間
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
		ai:SetTimer( 0, 9999.0 );
	end

	if ai:IsInsideTargetRegion( TARGET_SELF, 2235) then
	
		--近くないなら
		if targetDist >= nearDist then
			--30％　歩き接近→50％　右腕振り下ろし 80% HPが2割以下で自分に蝿を纏わせる
			--80％　蝿を飛ばす（遠距離攻撃）→接近
			if fate < 30 then
				if fate3 < 40 then
					goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 2.0, TARGET_ENE_0, nearDist, TARGET_ENE_0, true, -1 );
				else
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
				end
					if fate2 < 50 then
						goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_None, 0);
					elseif fate2 < 80 then
						if rate < 0.2 then
							goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_None, 0);
						else
							if targetDist < masiDist then
								goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_None, 0);
							else
								goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3060, TARGET_ENE_0, DIST_None, 0);
							end
						end
					end
				
			else
				if targetDist < masiDist then
					goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3030, TARGET_ENE_0, DIST_None, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3060, TARGET_ENE_0, DIST_None, 0);
				end
				if fate3 < 40 then
					goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 2.0, TARGET_ENE_0, nearDist, TARGET_ENE_0, true, -1 );
				else
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
				end
			end
			
			
	--~ 	--近いなら
	--~ 	elseif targetDist >= maaiDist then
	--~ 		--60％　歩き接近→回り込み＆再接近
	--~ 		--40％　さらに接近→50%暴れる50%右腕で殴る�
	--~ 		if fate < 60 then
	--~ 			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
	--~ 			if fate2 < 50 then
	--~ 				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
	--~ 				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
	--~ 			end
	--~ 		else
	--~ 			goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, 0.3, 0.8, TARGET_ENE_0, true, -1 );
	--~ 			if fate2 < 50 then
	--~ 				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3020, TARGET_ENE_0, DIST_Near, 0);
	--~ 			else
	--~ 				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
	--~ 			end
	--~ 		end
			

		--至近距離なら
		elseif targetDist < maaiDist then
			--50% 蝿爆発
			--10% 暴れる
			--40% 右腕で殴る
			if fate < 50 then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Near, 0);
				
			elseif fate < 60 then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
			
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
				
			end

		else
		--間合い以内なら (maaiDist < x <= nearDist)
			--攻撃する
			--攻撃後行動
			Haetakari508000Battle_Kougeki(ai, goal)
			Haetakari508000Battle_Kougeki_Noato(ai, goal)
		end

	else
		--遠かったら飛び道具、近かったら殴る
 		if targetDist > nearDist then
 			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_None, 0);
 		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_None, 0);
 		end
		--領域から戻る
		goal:AddSubGoal(GOAL_COMMON_BackToHome, 4.0, -1, 0, 0, 0 );
	end
	
end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function Haetakari508000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local rate = ai:GetHpRate( TARGET_SELF )				--自分のHP

	--45% 3000　右腕で殴る
	--20% 3000-3010　右腕で殴る＆右腕振り下ろし�
	--30% 3020　暴れる
	--05% 3040　自分に蝿を纏わせる

	if K_fate < 45 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
	elseif K_fate < 65 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Near, 0);
	elseif K_fate < 95 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
	else
		if rate < 0.2 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Near, 0);

		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);

		end
	end
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function Haetakari508000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local SideTime = 0.5							--横に動く時間
local BackDist = ai:GetRandam_Float(0.75, 1.5)	--後退する距離
local BackTime = 0.5							--後退する時間


local bRight = ai:GetRandam_Int(0,1);							--左右移動の方向
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- 同じ方向に左右移動している仲間の数



--後ろに下がった後にときどき横移動させると良いかも
--あまりに近すぎる横移動よりも、すこし下がってから横移動させると良いかも

	--25% なにもしない（ちょっとだけ横移動）
	--50% 適当に横に移動
	--25% 後ろに移動
	if KN_fate < 25  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 10, true, true ,-1 );
	elseif KN_fate < 75  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end



---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function Haetakari508000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function Haetakari508000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function Haetakari508000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字
local maaiDist = 1.0										--攻撃のために近づく距離　★汎用化の為、攻撃ごとに分けず★

	--空振り追い討ち
	--25％　近くのターゲットが空振りしたら攻撃
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < maaiDist then
			if fate <= 25 then
				goal:ClearSubGoal();
				Haetakari508000Battle_Kougeki(ai, goal)
				Haetakari508000Battle_Kougeki_Noato(ai, goal)
				return true;
			end	
		end
	end

return false;

end
