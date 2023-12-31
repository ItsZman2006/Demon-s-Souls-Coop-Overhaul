-----------------------------------------------------------------------------------------------
--	騎士用戦闘(チュートリアル・パリィ用)
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Kisi200020_Battle, "kisi200020Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Kisi200020_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function kisi200020Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その３
local fate4 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その４
local fate5 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その５

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 1.6					--3000番の適正間合い（最大）
local Att3003_Dist_min = 2.5					--3003番の適正間合い（最小）
local Att3003_Dist_max = 4.3					--3003番の適正間合い（最大）
local Att3300_Dist_min = 0.0					--3300番の適正間合い（最小）
local Att3300_Dist_max = 1.9					--3300番の適正間合い（最大）
local Att9800_Dist_min = 0.0					--9800番の適正間合い（最小）
local Att9800_Dist_max = 1.3					--9800番の適正間合い（最大）

local Act01Per = 0		--ダッシュ接近＆ガード崩し
local Act02Per = 0		--歩行接近＆ガード崩し
local Act03Per = 0		--ダッシュ接近＆突進突き	
local Act04Per = 0		--ダッシュ接近＆近接攻撃
local Act05Per = 0		--歩行接近＆突進突き
local Act06Per = 0		--歩行接近＆溜め斬り
local Act07Per = 0		--歩行接近＆近接攻撃


	--遠いなら
	if targetDist >= 8.0 then
		--PCが背を向けていたら
		if ai:IsInsideTargetEx( TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_B, 30.0, 100) then
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆突進突き	
			Act04Per = 100		--ダッシュ接近＆近接攻撃
			Act05Per = 0		--歩行接近＆突進突き
			Act06Per = 0		--歩行接近＆溜め斬り
			Act07Per = 0		--歩行接近＆近接攻撃
			
		--PCがガードしていたら	
		elseif ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 20		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆突進突き	
			Act04Per = 80		--ダッシュ接近＆近接攻撃
			Act05Per = 0		--歩行接近＆突進突き
			Act06Per = 0		--歩行接近＆溜め斬り
			Act07Per = 0		--歩行接近＆近接攻撃
			
		--どちらでもなかったら	
		else
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆突進突き	
			Act04Per = 50		--ダッシュ接近＆近接攻撃
			Act05Per = 0		--歩行接近＆突進突き
			Act06Per = 15		--歩行接近＆溜め斬り
			Act07Per = 35		--歩行接近＆近接攻撃
			
		end	
		
	--ダッシュしても良い程度に遠いなら	
	elseif targetDist >= 4.0 then	
		--PCがガードしていたら
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 20		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆突進突き	
			Act04Per = 80		--ダッシュ接近＆近接攻撃
			Act05Per = 0		--歩行接近＆突進突き
			Act06Per = 0		--歩行接近＆溜め斬り
			Act07Per = 0		--歩行接近＆近接攻撃
			
		else
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆突進突き	
			Act04Per = 60		--ダッシュ接近＆近接攻撃
			Act05Per = 0		--歩行接近＆突進突き
			Act06Per = 10		--歩行接近＆溜め斬り
			Act07Per = 30		--歩行接近＆近接攻撃
		end
		
	--突進突きしても良い程度に遠いなら
	elseif targetDist >= 2.5 then	
		--PCがガードしていたら80％の確率で	
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 20		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆突進突き	
			Act04Per = 65		--ダッシュ接近＆近接攻撃
			Act05Per = 0		--歩行接近＆突進突き
			Act06Per = 15		--歩行接近＆溜め斬り
			Act07Per = 0		--歩行接近＆近接攻撃
			
		else
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆突進突き	
			Act04Per = 85		--ダッシュ接近＆近接攻撃
			Act05Per = 0		--歩行接近＆突進突き
			Act06Per = 15		--歩行接近＆溜め斬り
			Act07Per = 0		--歩行接近＆近接攻撃
		end
		
	else	
		--PCがガードしていたら80％の確率で	
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 30		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆突進突き	
			Act04Per = 0		--ダッシュ接近＆近接攻撃
			Act05Per = 0		--歩行接近＆突進突き
			Act06Per = 10		--歩行接近＆溜め斬り
			Act07Per = 60		--歩行接近＆近接攻撃
			
		else
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆突進突き	
			Act04Per = 0		--ダッシュ接近＆近接攻撃
			Act05Per = 0		--歩行接近＆突進突き
			Act06Per = 25		--歩行接近＆溜め斬り
			Act07Per = 75		--歩行接近＆近接攻撃
		end
	end

	--行動01　ダッシュ接近＆ガード崩し
	if fate2 <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att9800_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 5.0, 9800, TARGET_ENE_0, DIST_Middle, 0);
		if fate3 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		end	
		
	--行動02　歩行接近＆ガード崩し
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att9800_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 5.0, 9800, TARGET_ENE_0, DIST_Middle, 0);
		if fate3 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		end	
		
	--行動03　ダッシュ接近＆突進突き
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動04　ダッシュ接近＆近接攻撃
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, -1 );
		kisi200020Battle_Kougeki(ai, goal)
		
	--行動05　歩行接近＆突進突き
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動06　歩行接近＆溜め斬り
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per) then	
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3300_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動07　歩行接近＆近接攻撃
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, -1 );
		kisi200020Battle_Kougeki(ai, goal)
		
	end
	kisi200020Battle_Kougeki_Noato(ai, goal)
	
end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function kisi200020Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--15％　3000-3001
	--70％　3000-3001-3002
	--10％　3000-3001-3300
	--5％　3002
	if K_fate <= 60 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 75 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 95 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function kisi200020Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字
local KN_fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２

local SideTime = 3.0							--横に動く時間
local BackDist = 2.0							--後退する距離
local BackTime = 3.0							--後退する時間

--後ろに下がった後にときどき横移動させると良いかも
--あまりに近すぎる横移動よりも、すこし下がってから横移動させると良いかも

	--65％　一呼吸　⇒何もしない
	--25％　適当に横に移動
	--10％　少し下がってから横に移動
	if KN_fate <= 65 then
		
	elseif KN_fate <= 90 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
		
	else
		goal:AddSubGoal(GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, 9910 );
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
	end
end




---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function kisi200020Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function kisi200020Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function kisi200020Battle_Interupt(ai, goal)

--local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得
--local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
--local fate = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字
--local fate2 = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　その２

--local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
--local Att3000_Dist_max = 1.6					--3000番の適正間合い（最大）
--local Att3003_Dist_min = 2.5					--3003番の適正間合い（最小）
--local Att3003_Dist_max = 4.3					--3003番の適正間合い（最大）
--local Att3300_Dist_min = 0.0					--3300番の適正間合い（最小）
--local Att3300_Dist_max = 1.9					--3300番の適正間合い（最大）
--local Att9800_Dist_min = 0.0					--9800番の適正間合い（最小）
--local Att9800_Dist_max = 1.3					--9800番の適正間合い（最大）


	--空振り追い討ち　■共通関数
--local missSwingDist		= 4.3		--空振り追撃する距離
--local missSwingAttPer	= 10		--空振り追撃する確率
--	if MissSwing_Act(ai, goal, missSwingDist, missSwingAttPer ) then
--		goal:ClearSubGoal();
		--距離別に対応
--		if targetDist >= Att3003_Dist_min then
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
			
--		else
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
--		end
--		kisi200020Battle_Kougeki_Noato(ai, goal)
--		return true;
--	end

	
	--ガードおろし追い討ち　■共通関数
--local guardFinishConutDist	= 4.3		--ガード終了で攻撃する距離
--local guardFinishConutPer	= 10		--ガード終了で攻撃する確率
--	if FindGuardFinish_Act(ai, goal, guardFinishConutDist, guardFinishConutPer ) then
--		goal:ClearSubGoal();
		--距離別に対応
--		if targetDist >= Att3003_Dist_min then
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
			
--		else
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
--		end
--		kisi200020Battle_Kougeki_Noato(ai, goal)
--		return true;
--	end

	-- コンボ逃れ　■共通関数
--local combRunDist		= 1.0		--コンボ逃れする距離
--local combRunPer		= 30		--コンボ逃れする確率
--	if Damaged_Act(ai, goal, combRunDist, combRunPer ) then
--		goal:ClearSubGoal();
--		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,9910 );
		--一定確率で反撃
--		if fate2 <= 30 then
--			goal:AddSubGoal(GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, Att3003_Dist_min, Att3003_Dist_max, TARGET_ENE_0, true, 9910 );
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
--			kisi200020Battle_Kougeki_Noato(ai, goal)
--		end
--		return true;
--	end	
	
	--超反応ガード
	--近くで攻撃している人がいたら
--	if ai:IsInterupt( INTERUPT_FindAttack ) then
--		if targetDist <= 2.0 then
			-- 自身のＨＰ割合が80％以上なら
--			if hprate >= 0.8 then
				--25％　ガードで後退
--				if fate <= 25 then
--					goal:ClearSubGoal();
--					goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, 2.5, TARGET_ENE_0, true, 9910 );
--					return true;
--				end
				
			-- 自身のＨＰ割合が80％以上でないなら
--			else
				--50％　ガードで後退
--				if fate <= 50 then
--					goal:ClearSubGoal();
--					goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, 2.5, TARGET_ENE_0, true, 9910 );
--					return true;
--				end
--			end
--		end
--	end


	--ガード崩壊したら攻撃　■共通関数
--local guardBreakConutDist = 4.3			--ガード崩壊で攻撃する距離
--local guardBreakConutPer = 65			--ガード崩壊で攻撃する確率
--	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
--		goal:ClearSubGoal();
		--距離別に対応
--		if targetDist >= Att3003_Dist_min then
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
			
--		else
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
--		end
--		kisi200020Battle_Kougeki_Noato(ai, goal)
--		return true;
--	end	
	
	--飛び道具追い討ち
	--ターゲットが飛び道具を発射したら、遠距離対応行動
--	if ai:IsInterupt( INTERUPT_Shoot ) then
--		if kisi200020Battle_Enkyori(ai, goal ) == true then
--		return true
--		end
--	end
	
	--アイテム使用追い討ち
	--ターゲットがアイテムを使ったたら、遠距離対応行動
--	if ai:IsInterupt( INTERUPT_UseItem ) then
--		if kisi200020Battle_Enkyori(ai, goal ) == true then
--		return true
--		end
--	end
	
	
return false;
end


---------------------------------------------------------
--  遠距離対応
---------------------------------------------------------
function kisi200020Battle_Enkyori(ai, goal )

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字

local Att3003_Dist_max = 4.3					--3003番の適正間合い（最大）
local Att3300_Dist_max = 1.9					--3300番の適正間合い（最大）

	--溜め切りの間合い以内なら
	if targetDist <= Att3300_Dist_max then
		--90％　溜め切り
		if fate <= 90 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			kisi200020Battle_Kougeki_Noato(ai, goal)
			return true;
		end
		
	--突進突きの間合い以内なら	
	elseif targetDist <= Att3003_Dist_max then
		--90％　突進突き
		if fate <= 90 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
			kisi200020Battle_Kougeki_Noato(ai, goal)
			return true;
		end		
		
	--遠くも近くもないなら	
	elseif targetDist <= 12.0 then
		--70％　突進突き
		if fate <= 70 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, false, 9910 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
			kisi200020Battle_Kougeki_Noato(ai, goal)
			return true;
		end
		
	--遠いなら
	else
		--45％　突進突き
		if fate <= 45 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, false, 9910 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
			kisi200020Battle_Kougeki_Noato(ai, goal)
			return true;
		end
		
	end
	
return false
end


