-----------------------------------------------------------------------------------------------
--	騎士用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Kisi202002_Battle, "kisi202002Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Kisi202002_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function kisi202002Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得

local fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その３
local fate4 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その４
local fate5 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その５

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 2.3					--3000番の適正間合い（最大）
local Att3300_Dist_min = 0.0					--3300番の適正間合い（最小）
local Att3300_Dist_max = 3.2					--3300番の適正間合い（最大）
local Att3301_Dist_min = 2.3					--3301番の適正間合い（最小）
local Att3301_Dist_max = 6.7					--3301番の適正間合い（最大）
local Att9800_Dist_min = 0.0					--9800番の適正間合い（最小）
local Att9800_Dist_max = 1.3					--9800番の適正間合い（最大）

local Act01Per = 0		--ダッシュ接近＆ガード崩し
local Act02Per = 0		--歩行接近＆ガード崩し
local Act03Per = 0		--ダッシュ接近＆突撃	
local Act04Per = 0		--ダッシュ接近＆近接攻撃
local Act05Per = 0		--歩行接近＆突撃
local Act06Per = 0		--歩行接近＆強攻撃
local Act07Per = 0		--歩行接近＆近接攻撃
local Act08Per = 0		--回復を使う

	--ＨＰが減っていたら、一定確率で回復薬を使う
	if hprate <= 0.4 and fate <= 50 then
		Act08Per = 100		--回復を使う
		
	--遠いなら
	elseif targetDist >= 8.0 then
		--PCが背を向けていたら
		if ai:IsInsideTargetEx( TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_B, 30.0, 100) then
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 95		--ダッシュ接近＆突撃	
			Act04Per = 5		--ダッシュ接近＆近接攻撃
			Act05Per = 0		--歩行接近＆突撃
			Act06Per = 0		--歩行接近＆強攻撃
			Act07Per = 0		--歩行接近＆近接攻撃
			Act08Per = 0		--回復を使う
			
		--PCがガードしていたら	
		elseif ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 40		--ダッシュ接近＆ガード崩し
			Act02Per = 5		--歩行接近＆ガード崩し
			Act03Per = 50		--ダッシュ接近＆突撃	
			Act04Per = 5		--ダッシュ接近＆近接攻撃
			Act05Per = 0		--歩行接近＆突撃
			Act06Per = 0		--歩行接近＆強攻撃
			Act07Per = 0		--歩行接近＆近接攻撃
			Act08Per = 0		--回復を使う
			
		--どちらでもなかったら	
		else
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 95		--ダッシュ接近＆突撃	
			Act04Per = 5		--ダッシュ接近＆近接攻撃
			Act05Per = 0		--歩行接近＆突撃
			Act06Per = 0		--歩行接近＆強攻撃
			Act07Per = 0		--歩行接近＆近接攻撃
			Act08Per = 0		--回復を使う
			
		end	
		
	--ダッシュしても良い程度に遠いなら	
	elseif targetDist >= 4.0 then	
		--PCがガードしていたら
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 40		--ダッシュ接近＆ガード崩し
			Act02Per = 5		--歩行接近＆ガード崩し
			Act03Per = 50		--ダッシュ接近＆突撃	
			Act04Per = 5		--ダッシュ接近＆近接攻撃
			Act05Per = 0		--歩行接近＆突撃
			Act06Per = 0		--歩行接近＆強攻撃
			Act07Per = 0		--歩行接近＆近接攻撃
			Act08Per = 0		--回復を使う
			
		else
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆突撃	
			Act04Per = 25		--ダッシュ接近＆近接攻撃
			Act05Per = 50		--歩行接近＆突撃
			Act06Per = 10		--歩行接近＆強攻撃
			Act07Per = 15		--歩行接近＆近接攻撃
			Act08Per = 0		--回復を使う
			
		end
		
	--突進突きしても良い程度に遠いなら
	elseif targetDist >= 2.5 then	
		--PCがガードしていたら80％の確率で	
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 40		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆突撃	
			Act04Per = 0		--ダッシュ接近＆近接攻撃
			Act05Per = 50		--歩行接近＆突撃
			Act06Per = 5		--歩行接近＆強攻撃
			Act07Per = 5		--歩行接近＆近接攻撃
			Act08Per = 0		--回復を使う
			
		else
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆突撃	
			Act04Per = 0		--ダッシュ接近＆近接攻撃
			Act05Per = 65		--歩行接近＆突撃
			Act06Per = 10		--歩行接近＆強攻撃
			Act07Per = 25		--歩行接近＆近接攻撃
			Act08Per = 0		--回復を使う
			
		end
		
	else	
		--PCがガードしていたら80％の確率で	
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 60		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆突撃	
			Act04Per = 0		--ダッシュ接近＆近接攻撃
			Act05Per = 0		--歩行接近＆突撃
			Act06Per = 15		--歩行接近＆強攻撃
			Act07Per = 25		--歩行接近＆近接攻撃
			Act08Per = 0		--回復を使う
			
		else
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆突撃	
			Act04Per = 0		--ダッシュ接近＆近接攻撃
			Act05Per = 0		--歩行接近＆突撃
			Act06Per = 25		--歩行接近＆強攻撃
			Act07Per = 75		--歩行接近＆近接攻撃
			Act08Per = 0		--回復を使う
			
		end
	end

	--行動01　ダッシュ接近＆ガード崩し
	if fate2 <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att9800_Dist_max, TARGET_ENE_0, false, 9910 );
		goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 5.0, 9800, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動02　歩行接近＆ガード崩し
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att9800_Dist_max, TARGET_ENE_0, true, 9910 );
		goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 5.0, 9800, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動03　ダッシュ接近＆突撃
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3301_Dist_max, TARGET_ENE_0, false, 9910 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動04　ダッシュ接近＆近接攻撃
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, 9910 );
		kisi202002Battle_Kougeki(ai, goal)
		
	--行動05　歩行接近＆突撃
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3301_Dist_max, TARGET_ENE_0, true, 9910 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動06　歩行接近＆強攻撃
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3300_Dist_max, TARGET_ENE_0, true, 9910 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動07　歩行接近＆近接攻撃
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, 9910 );
		kisi202002Battle_Kougeki(ai, goal)
		
	--行動08　回復薬を使う
	else
		goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 3.0, TARGET_ENE_0, true, 9910 );				
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6200, TARGET_ENE_0, DIST_Far, 0);	
		
	end
	kisi202002Battle_Kougeki_Noato(ai, goal)
	
end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function kisi202002Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--20％　3000-3001
	--70％　3000-3001-3002
	--10％　3000-3001-3300
	if K_fate <= 20 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 90 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function kisi202002Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字
local KN_fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２

local SideTime = 4.0							--横に動く時間
local BackDist = 2.5							--後退する距離
local BackTime = 4.0							--後退する時間

	--55％　何もしない
	--30％　適当に横に移動
	--15％　少し下がってから横に移動
	if KN_fate <= 55 then
		
	elseif KN_fate <= 85 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,9910 );
		
	else
		goal:AddSubGoal(GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, 9910 );
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,9910 );
	end
end




---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function kisi202002Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function kisi202002Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function kisi202002Battle_Interupt(ai, goal)

local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得
local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　その２

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 2.3					--3000番の適正間合い（最大）
local Att3300_Dist_min = 0.0					--3300番の適正間合い（最小）
local Att3300_Dist_max = 3.2					--3300番の適正間合い（最大）
local Att3301_Dist_min = 2.3					--3301番の適正間合い（最小）
local Att3301_Dist_max = 6.7					--3301番の適正間合い（最大）
local Att9800_Dist_min = 0.0					--9800番の適正間合い（最小）
local Att9800_Dist_max = 1.3					--9800番の適正間合い（最大）


	--空振り追い討ち　■共通関数
local missSwingDist		= 6.7		--空振り追撃する距離
local missSwingAttPer	= 20		--空振り追撃する確率
	if MissSwing_Act(ai, goal, missSwingDist, missSwingAttPer ) then
		goal:ClearSubGoal();
		--距離別に対応
		if targetDist >= 3.2 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
			
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
		end
		kisi202002Battle_Kougeki_Noato(ai, goal)
		return true;
	end

	
	--ガードおろし追い討ち　■共通関数
local guardFinishConutDist	= 6.7		--ガード終了で攻撃する距離
local guardFinishConutPer	= 10		--ガード終了で攻撃する確率
	if FindGuardFinish_Act(ai, goal, guardFinishConutDist, guardFinishConutPer ) then
		goal:ClearSubGoal();
		--距離別に対応
		if targetDist >= 3.2 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
			
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
		end
		kisi202002Battle_Kougeki_Noato(ai, goal)
		return true;
	end

	-- コンボ逃れ　■共通関数
local combRunDist		= 1.5		--コンボ逃れする距離
local combRunPer		= 30		--コンボ逃れする確率
	if Damaged_Act(ai, goal, combRunDist, combRunPer ) then
		goal:ClearSubGoal();
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 4.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,9910 );
		--一定確率で反撃
		if fate2 <= 30 then
			goal:AddSubGoal(GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, Att3301_Dist_min, Att3301_Dist_max, TARGET_ENE_0, true, 9910 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
			kisi202002Battle_Kougeki_Noato(ai, goal)
		end
		return true;
	end	
	
	--超反応ガード
	--近くで攻撃している人がいたら
	if ai:IsInterupt( INTERUPT_FindAttack ) then
		if targetDist <= 2.0 then
			-- 自身のＨＰ割合が80％以上なら
			if hprate >= 0.8 then
				--25％　ガードで後退
				if fate <= 25 then
					goal:ClearSubGoal();
					goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 4.0, TARGET_ENE_0, 2.5, TARGET_ENE_0, true, 9910 );
					return true;
				end
				
			-- 自身のＨＰ割合が80％以上でないなら
			else
				--50％　ガードで後退
				if fate <= 50 then
					goal:ClearSubGoal();
					goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 4.0, TARGET_ENE_0, 2.5, TARGET_ENE_0, true, 9910 );
					return true;
				end
			end
		end
	end


	--ガード崩壊したら攻撃　■共通関数
local guardBreakConutDist = 6.7			--ガード崩壊で攻撃する距離
local guardBreakConutPer = 65			--ガード崩壊で攻撃する確率
	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
		goal:ClearSubGoal();
		--距離別に対応
		if targetDist >= 3.2 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
			
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
		end
		kisi202002Battle_Kougeki_Noato(ai, goal)
		return true;
	end	
	
	--飛び道具追い討ち
	--ターゲットが飛び道具を発射したら、遠距離対応行動
	if ai:IsInterupt( INTERUPT_Shoot ) then
		if kisi202002Battle_Enkyori(ai, goal ) == true then
		return true
		end
	end
	
	--アイテム使用追い討ち
	--ターゲットがアイテムを使ったたら、遠距離対応行動
	if ai:IsInterupt( INTERUPT_UseItem ) then
		if kisi202002Battle_Enkyori(ai, goal ) == true then
		return true
		end
	end
	
	
return false;
end


---------------------------------------------------------
--  遠距離対応
---------------------------------------------------------
function kisi202002Battle_Enkyori(ai, goal )

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 2.3					--3000番の適正間合い（最大）
local Att3300_Dist_min = 0.0					--3300番の適正間合い（最小）
local Att3300_Dist_max = 3.2					--3300番の適正間合い（最大）
local Att3301_Dist_min = 2.3					--3301番の適正間合い（最小）
local Att3301_Dist_max = 6.7					--3301番の適正間合い（最大）
local Att9800_Dist_min = 0.0					--9800番の適正間合い（最小）
local Att9800_Dist_max = 1.3					--9800番の適正間合い（最大）

	--強攻撃の間合い以内なら
	if targetDist <= Att3300_Dist_max then
		--90％　強攻撃
		if fate <= 90 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			kisi202002Battle_Kougeki_Noato(ai, goal)
			return true;
		end
		
	--突撃の間合い以内なら	
	elseif targetDist <= Att3301_Dist_max then
		--90％　突撃
		if fate <= 90 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
			kisi202002Battle_Kougeki_Noato(ai, goal)
			return true;
		end		
		
	--遠くも近くもないなら	
	elseif targetDist <= 12.0 then
		--70％　突撃
		if fate <= 70 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3301_Dist_max, TARGET_ENE_0, false, 9910 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
			kisi202002Battle_Kougeki_Noato(ai, goal)
			return true;
		end
		
	--遠いなら
	else
		--45％　突進突き
		if fate <= 45 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3301_Dist_max, TARGET_ENE_0, false, 9910 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
			kisi202002Battle_Kougeki_Noato(ai, goal)
			return true;
		end
		
	end
	
return false
end


