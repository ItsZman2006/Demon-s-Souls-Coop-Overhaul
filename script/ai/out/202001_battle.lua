-----------------------------------------------------------------------------------------------
--	騎士クレイモア用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Kisi202001_Battle, "kisi202001Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Kisi202001_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function kisi202001Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local hprate = ai:GetHpRate( TARGET_SELF )						--自分のHP割合を取得

local fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その３
local fate4 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その４
local fate5 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その５

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 2.2					--3000番の適正間合い（最大）
local Att3003_Dist_min = 0.0					--3003番の適正間合い（最小）
local Att3003_Dist_max = 2.0					--3003番の適正間合い（最大）
local Att3004_Dist_min = 3.5					--3004番の適正間合い（最小）
local Att3004_Dist_max = 4.8					--3004番の適正間合い（最大）
local Att3300_Dist_min = 0.0					--3300番の適正間合い（最小）
local Att3300_Dist_max = 2.4					--3300番の適正間合い（最大）

local Act01Per = 0		--ダッシュ接近＆連続振り回し
local Act02Per = 0		--ダッシュ接近＆溜め斬り	
local Act03Per = 0		--ダッシュ接近＆近接攻撃
local Act04Per = 0		--歩行接近＆連続振り回し
local Act05Per = 0		--歩行接近＆溜め斬り
local Act06Per = 100	--歩行接近＆近接攻撃
local Act07Per = 0		--ダッシュ接近＆助走攻撃
local Act08Per = 0		--歩行接近＆助走攻撃
local Act09Per = 0		--回復を使う


	--ＨＰが減っていたら、一定確率で回復薬を使う
	if hprate <= 0.4 and fate <= 50 then
		Act09Per = 100		--回復を使う
		
	--遠いなら
	elseif targetDist >= 8.0 then
		--PCが背を向けていたら
		if ai:IsInsideTargetEx( TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_B, 30.0, 100) then
			Act01Per = 30		--ダッシュ接近＆連続振り回し
			Act02Per = 5		--ダッシュ接近＆溜め斬り	
			Act03Per = 5		--ダッシュ接近＆近接攻撃
			Act04Per = 0		--歩行接近＆連続振り回し
			Act05Per = 0		--歩行接近＆溜め斬り
			Act06Per = 0		--歩行接近＆近接攻撃
			Act07Per = 60		--ダッシュ接近＆助走攻撃
			Act08Per = 0		--歩行接近＆助走攻撃
			Act09Per = 0		--回復を使う
			
		--PCがガードしていたら	
		elseif ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 5		--ダッシュ接近＆連続振り回し
			Act02Per = 60		--ダッシュ接近＆溜め斬り	
			Act03Per = 5		--ダッシュ接近＆近接攻撃
			Act04Per = 5		--歩行接近＆連続振り回し
			Act05Per = 5		--歩行接近＆溜め斬り
			Act06Per = 5		--歩行接近＆近接攻撃
			Act07Per = 10		--ダッシュ接近＆助走攻撃
			Act08Per = 5		--歩行接近＆助走攻撃
			Act09Per = 0		--回復を使う
			
		--どちらでもなかったら	
		else
			Act01Per = 15		--ダッシュ接近＆連続振り回し
			Act02Per = 5		--ダッシュ接近＆溜め斬り	
			Act03Per = 25		--ダッシュ接近＆近接攻撃
			Act04Per = 5		--歩行接近＆連続振り回し
			Act05Per = 5		--歩行接近＆溜め斬り
			Act06Per = 5		--歩行接近＆近接攻撃
			Act07Per = 35		--ダッシュ接近＆助走攻撃
			Act08Per = 5		--歩行接近＆助走攻撃
			Act09Per = 0		--回復を使う
			
		end	
		
	--ダッシュ＆溜め斬り　しても良い程度に遠いなら	
	elseif targetDist >= 5.0 then	
		--PCがガードしていたら	
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 5		--ダッシュ接近＆連続振り回し
			Act02Per = 65		--ダッシュ接近＆溜め斬り	
			Act03Per = 5		--ダッシュ接近＆近接攻撃
			Act04Per = 5		--歩行接近＆連続振り回し
			Act05Per = 5		--歩行接近＆溜め斬り
			Act06Per = 5		--歩行接近＆近接攻撃
			Act07Per = 5		--ダッシュ接近＆助走攻撃
			Act08Per = 5		--歩行接近＆助走攻撃
			Act09Per = 0		--回復を使う
			
		else
			Act01Per = 15		--ダッシュ接近＆連続振り回し
			Act02Per = 5		--ダッシュ接近＆溜め斬り	
			Act03Per = 55		--ダッシュ接近＆近接攻撃
			Act04Per = 5		--歩行接近＆連続振り回し
			Act05Per = 5		--歩行接近＆溜め斬り
			Act06Per = 5		--歩行接近＆近接攻撃
			Act07Per = 5		--ダッシュ接近＆助走攻撃
			Act08Per = 5		--歩行接近＆助走攻撃
			Act09Per = 0		--回復を使う
			
		end
		
	--ダッシュ＆近接攻撃　しても良い程度に遠いなら	
	elseif targetDist >= 3.5 then	
		--PCがガードしていたら	
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 0		--ダッシュ接近＆連続振り回し
			Act02Per = 0		--ダッシュ接近＆溜め斬り	
			Act03Per = 5		--ダッシュ接近＆近接攻撃
			Act04Per = 10		--歩行接近＆連続振り回し
			Act05Per = 70		--歩行接近＆溜め斬り
			Act06Per = 5		--歩行接近＆近接攻撃
			Act07Per = 0		--ダッシュ接近＆助走攻撃
			Act08Per = 10		--歩行接近＆助走攻撃
			Act09Per = 0		--回復を使う
			
		else
			Act01Per = 0		--ダッシュ接近＆連続振り回し
			Act02Per = 0		--ダッシュ接近＆溜め斬り	
			Act03Per = 60		--ダッシュ接近＆近接攻撃
			Act04Per = 15		--歩行接近＆連続振り回し
			Act05Per = 10		--歩行接近＆溜め斬り
			Act06Per = 5		--歩行接近＆近接攻撃
			Act07Per = 0		--ダッシュ接近＆助走攻撃
			Act08Per = 10		--歩行接近＆助走攻撃
			Act09Per = 0		--回復を使う
			
		end
		
	else	
		--PCがガードしていたら	
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 0		--ダッシュ接近＆連続振り回し
			Act02Per = 0		--ダッシュ接近＆溜め斬り	
			Act03Per = 0		--ダッシュ接近＆近接攻撃
			Act04Per = 15		--歩行接近＆連続振り回し
			Act05Per = 70		--歩行接近＆溜め斬り
			Act06Per = 15		--歩行接近＆近接攻撃
			Act07Per = 0		--ダッシュ接近＆助走攻撃
			Act08Per = 0		--歩行接近＆助走攻撃
			Act09Per = 0		--回復を使う
			
		else
			Act01Per = 0		--ダッシュ接近＆連続振り回し
			Act02Per = 0		--ダッシュ接近＆溜め斬り	
			Act03Per = 0		--ダッシュ接近＆近接攻撃
			Act04Per = 20		--歩行接近＆連続振り回し
			Act05Per = 10		--歩行接近＆溜め斬り
			Act06Per = 70		--歩行接近＆近接攻撃
			Act07Per = 0		--ダッシュ接近＆助走攻撃
			Act08Per = 0		--歩行接近＆助走攻撃
			Act09Per = 0		--回復を使う
			
		end
	end

	--行動01　ダッシュ接近＆連続振り回し
	if fate <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動02　ダッシュ接近＆溜め斬り
	elseif fate <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3300_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動03　ダッシュ接近＆近接攻撃
	elseif fate <= (Act01Per + Act02Per + Act03Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, -1 );
		kisi202001Battle_Kougeki(ai, goal)
		
	--行動04　歩行接近＆連続振り回し
	elseif fate <= (Act01Per + Act02Per + Act03Per + Act04Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動05　歩行接近＆溜め斬り
	elseif fate <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3300_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動06　歩行接近＆近接攻撃
	elseif fate <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, -1 );
		kisi202001Battle_Kougeki(ai, goal)
		
	--行動07　ダッシュ接近＆助走攻撃
	elseif fate <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3004_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動08　歩行接近＆助走攻撃
	elseif fate <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per + Act08Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3004_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Middle, 0);	
		
	--行動09　回復薬を使う
	else
		goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 3.0, TARGET_ENE_0, true, -1 );				
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6200, TARGET_ENE_0, DIST_Far, 0);	
		
	end
	kisi202001Battle_Kougeki_Noato(ai, goal)
	
end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function kisi202001Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--15％　3000-3001
	--70％　3000-3001-3002
	--10％　3000-3001-3300
	--5％　3002
	if K_fate <= 15 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 85 then
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
function kisi202001Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字
local KN_fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２

local SideTime = 4.0							--横に動く時間
local BackDist = 2.5							--後退する距離
local BackTime = 4.0							--後退する時間

--後ろに下がった後にときどき横移動させると良いかも
--あまりに近すぎる横移動よりも、すこし下がってから横移動させると良いかも

	--0％　一呼吸
	if KN_fate2 <= 0 then
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.5,1.0) ,0,0,0,0)
	end
	
	--85％　一呼吸
	--10％　適当に横に移動
	--5％　少し下がってから横に移動
	if KN_fate <= 85 then
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.2,0.5) ,0,0,0,0)
		
	elseif KN_fate <= 95 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
		
	else
		goal:AddSubGoal(GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
	end
end




---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function kisi202001Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function kisi202001Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function kisi202001Battle_Interupt(ai, goal)

local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得
local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　その２

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 2.2					--3000番の適正間合い（最大）
local Att3003_Dist_min = 0.0					--3003番の適正間合い（最小）
local Att3003_Dist_max = 2.0					--3003番の適正間合い（最大）
local Att3004_Dist_min = 3.5					--3004番の適正間合い（最小）
local Att3004_Dist_max = 4.8					--3004番の適正間合い（最大）
local Att3300_Dist_min = 0.0					--3300番の適正間合い（最小）
local Att3300_Dist_max = 2.4					--3300番の適正間合い（最大）


	--空振り追い討ち　■共通関数
local missSwingDist		= 2.4		--空振り追撃する距離
local missSwingAttPer	= 10		--空振り追撃する確率
	if MissSwing_Act(ai, goal, missSwingDist, missSwingAttPer ) then
		goal:ClearSubGoal();
		--距離別に対応
		if targetDist >= Att3300_Dist_min then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
		else
			kisi202001Battle_Kougeki(ai, goal)
			
		end
		kisi202001Battle_Kougeki_Noato(ai, goal)
		return true;
	end

	
	--ガードおろし追い討ち　■共通関数
local guardFinishConutDist	= 2.4		--ガード終了で攻撃する距離
local guardFinishConutPer	= 10		--ガード終了で攻撃する確率
	if FindGuardFinish_Act(ai, goal, guardFinishConutDist, guardFinishConutPer ) then
		goal:ClearSubGoal();
		--距離別に対応
		if targetDist >= Att3300_Dist_min then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
		else
			kisi202001Battle_Kougeki(ai, goal)
			
		end
		kisi202001Battle_Kougeki_Noato(ai, goal)
		return true;
	end

	-- コンボ逃れ　■共通関数
local combRunDist		= 1.5		--コンボ逃れする距離
local combRunPer		= 30		--コンボ逃れする確率
	if Damaged_Act(ai, goal, combRunDist, combRunPer ) then
		goal:ClearSubGoal();
		kisi202001Battle_Kougeki(ai, goal)
		kisi202001Battle_Kougeki_Noato(ai, goal)
		return true;
	end	
	

	--ガード崩壊したら攻撃　■共通関数
local guardBreakConutDist = 4.8			--ガード崩壊で攻撃する距離
local guardBreakConutPer = 65			--ガード崩壊で攻撃する確率
	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
		goal:ClearSubGoal();
		--距離別に対応
		if targetDist >= Att3004_Dist_min then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3004, TARGET_ENE_0, DIST_Middle, 0);
			
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
		end
		kisi202001Battle_Kougeki_Noato(ai, goal)
		return true;
	end	
	
	--飛び道具追い討ち
	--ターゲットが飛び道具を発射したら、遠距離対応行動
	if ai:IsInterupt( INTERUPT_Shoot ) then
		if kisi202001Battle_Enkyori(ai, goal ) == true then
		return true;
		end
	end
	
	--アイテム使用追い討ち
	--ターゲットがアイテムを使ったたら、遠距離対応行動
	if ai:IsInterupt( INTERUPT_UseItem ) then
		if kisi202001Battle_Enkyori(ai, goal ) == true then
		return true;
		end
	end
	
	
return false;
end


---------------------------------------------------------
--  遠距離対応
---------------------------------------------------------
function kisi202001Battle_Enkyori(ai, goal )

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字

local Att3000_Dist_max = 1.6					--3000番の適正間合い（最大）
local Att3003_Dist_max = 2.0					--3003番の適正間合い（最大）
local Att3300_Dist_max = 2.4					--3300番の適正間合い（最大）

	--溜め切りの間合い以内なら
	if targetDist <= Att3300_Dist_max then
		--90％　溜め切り
		if fate <= 90 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			kisi202001Battle_Kougeki_Noato(ai, goal)
			return true;
		end
		
	--連続振り下ろしの間合い以内なら	
	elseif targetDist <= Att3003_Dist_max then
		--90％　連続振り下ろし
		if fate <= 90 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
			kisi202001Battle_Kougeki_Noato(ai, goal)
			return true;
		end		
		
	--遠くも近くもないなら	
	elseif targetDist <= 12.0 then
		--70％　連続振り下ろし
		if fate <= 70 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
			kisi202001Battle_Kougeki_Noato(ai, goal)
			return true;
		end
		
	--遠いなら
	else
		--45％　連続振り下ろし
		if fate <= 45 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
			kisi202001Battle_Kougeki_Noato(ai, goal)
			return true;
		end
		
	end
	
return false
end


