-----------------------------------------------------------------------------------------------
--	チュートリアル・一般兵士（火炎） 戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_IppanLONG_B200012_Battle, "ippanLONG_B200012Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_IppanLONG_B200012_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function ippanLONG_B200012Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local role = ai:GetTeamOrder(ORDER_TYPE_Role);			--自分の役割を取得
local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得

local targetDist = ai:GetDist(TARGET_ENE_0);						--敵ターゲットとの距離を取得
local targetDistY = ai:GetDistYSigned(TARGET_ENE_0);				--敵ターゲットとの高低差を取得

local fate = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字　その３

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 1.5					--3000番の適正間合い（最大）
local Att3003_Dist_min = 4.0					--3003番の適正間合い（最小）
local Att3003_Dist_max = 5.5					--3003番の適正間合い（最大）
local Att3300_Dist_min = 0.0					--3300番の適正間合い（最小）
local Att3300_Dist_max = 1.5					--3300番の適正間合い（最大）

local Att3002_Dist_min = 0.0					--3002番の適正間合い（最小）
local Att3002_Dist_max = 0.7					--3002番の適正間合い（最大）
local Att6060_Dist_min = 2.0					--6060番の適正間合い（最小）
local Att6060_Dist_max = 5.0					--6060番の適正間合い（最大）

local Act01Per = 0		--何もしない
local Act02Per = 0		--（予備）
local Act03Per = 0		--（予備）
local Act04Per = 0		--（予備）	
local Act05Per = 0		--歩行間合い調整＆火炎瓶
local Act06Per = 0		--歩行接近＆近接攻撃
local Act07Per = 0		--蹴る
local Act08Per = 0		--回復を使う

local absDistY = math.abs(targetDistY);		--絶対値をとる
local myBlockId = ai:GetMyBlockID();		--自分のいるブロック

	--ブロックによるガード率設定（ガードしない率）
local Guard			   = 9910							--ガード番号を宣言
local fateG = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　番外編
	if myBlockId == 0 and fateG <= 60 then
		Guard			 = 0
	elseif myBlockId == 1 and fateG <= 40 then
		Guard			 = 0
	elseif myBlockId == 2 and fateG <= 20 then
		Guard			 = 0
	elseif myBlockId == 3 and fateG <= 10 then
		Guard			 = 0
	else
		Guard			 = 0
	end	


	--ＨＰが減っていたら、一定確率で回復薬を使う
	if (hprate <= 0.4) and (fate <= 50) and (myBlockId == 1 or myBlockId == 2 or myBlockId == 3) then
		Act08Per = 100		--回復を使う
		
	--遠いが、高いおかげで届きそうなら
	elseif targetDist >= 5.0 and targetDistY < 0.0 and targetDist <= (5.0 + math.sqrt(absDistY) + (absDistY / 4) ) then
		Act01Per = 0		--何もしない
		Act02Per = 100		--その場で投げる
		Act03Per = 0		--（予備）
		Act04Per = 0		--（予備）	
		Act05Per = 0		--歩行間合い調整＆火炎瓶
		Act06Per = 0		--歩行接近＆近接攻撃
		Act07Per = 0		--蹴る
		Act08Per = 0		--回復を使う
		
	--ちょっと遠くて、届きそうもないなら
	elseif targetDist >= 5.0 then
		Act01Per = 100		--何もしない
		Act02Per = 0		--その場で投げる
		Act03Per = 0		--（予備）
		Act04Per = 0		--（予備）	
		Act05Per = 0		--歩行間合い調整＆火炎瓶
		Act06Per = 0		--歩行接近＆近接攻撃
		Act07Per = 0		--蹴る
		Act08Per = 0		--回復を使う
		
	--火炎瓶を投げても変じゃない程度に遠いなら
	elseif targetDist >= 2.0 then
		Act01Per = 0		--何もしない
		Act02Per = 0		--その場で投げる
		Act03Per = 0		--（予備）
		Act04Per = 0		--（予備）	
		Act05Per = 100		--歩行間合い調整＆火炎瓶
		Act06Per = 0		--歩行接近＆近接攻撃
		Act07Per = 0		--蹴る
		Act08Per = 0		--回復を使う
		
	--蹴りには遠いが、火炎瓶には遠い程度なら
	elseif targetDist >= 0.7 then
		Act01Per = 0		--何もしない
		Act02Per = 0		--その場で投げる
		Act03Per = 0		--（予備）
		Act04Per = 0		--（予備）	
		Act05Per = 30		--歩行間合い調整＆火炎瓶
		Act06Per = 70		--歩行接近＆近接攻撃
		Act07Per = 0		--蹴る
		Act08Per = 0		--回復を使う
		
	--もっと近いなら
	else
		Act01Per = 0		--何もしない
		Act02Per = 0		--その場で投げる
		Act03Per = 0		--（予備）
		Act04Per = 0		--（予備）	
		Act05Per = 40		--歩行間合い調整＆火炎瓶
		Act06Per = 60		--歩行接近＆近接攻撃
		Act07Per = 0		--蹴る
		Act08Per = 0		--回復を使う
		
	end

	--戦闘用のアニメセットに切り替えます
	ai:ChangeMoveAnimParam(2)

	--攻撃役、その他役なら
	if role == ROLE_TYPE_Attack or role == ROLE_TYPE_None then
		
		--行動01　何もしない
		if fate2 <= Act01Per then
			goal:AddSubGoal(GOAL_COMMON_Wait, 1.0, TARGET_ENE_0, 0, 0, 0 );
			
		--行動02　その場で投げる
		elseif fate2 <= (Act01Per + Act02Per) then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6060, TARGET_ENE_0, DIST_Far, 0);
			goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(1.0,3.0), TARGET_ENE_0, 0, 0, 0 );
			
		--行動03　（予備）
		elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
			goal:AddSubGoal(GOAL_COMMON_Wait, 1.0, TARGET_ENE_0, 0, 0, 0 );
			
		--行動04　（予備）	
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
			goal:AddSubGoal(GOAL_COMMON_Wait, 1.0, TARGET_ENE_0, 0, 0, 0 );
			
		--行動05　歩行間合い調整＆火炎瓶
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per) then
			goal:AddSubGoal(GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, Att6060_Dist_min, Att6060_Dist_max, TARGET_ENE_0, true, Guard );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6060, TARGET_ENE_0, DIST_Far, 0);
			goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(1.0,3.0), TARGET_ENE_0, 0, 0, 0 );
			
		--行動06　歩行接近＆近接攻撃
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per) then	
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, Guard );
			ippanLONG_B200012Battle_Kougeki(ai, goal)	
			ippanLONG_B200012Battle_Kougeki_Noato(ai, goal, Guard)	
			
		--行動07　蹴る
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per) then	
			--ブロック3or4なら蹴る
			if (myBlockId == 2 or myBlockId == 3) then
				goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, true, Guard );
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Near, 0);
				
			--ブロック1or2なら通常攻撃
			else
				goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, Guard );
				ippanLONG_B200012Battle_Kougeki(ai, goal)	
				ippanLONG_B200012Battle_Kougeki_Noato(ai, goal, Guard)	
			end
			
		--行動08　回復を使う
		else
			goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 3.0, TARGET_ENE_0, true, Guard );				
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6200, TARGET_ENE_0, DIST_Far, 0);
			ippanLONG_B200012Battle_Kougeki_Noato(ai, goal, Guard)	
		end
		
	--取り巻き役なら
	elseif role == ROLE_TYPE_Torimaki then
		--遠ければ、走って近づいてくる
		if targetDist >= 20.0 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 9.5, TARGET_ENE_0, false, -1 );
		--近ければ、歩いて近づいてくる
		elseif targetDist >= 11.0 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 9.5, TARGET_ENE_0, true, -1 );
		--適度な距離ならば、横に動く
		elseif targetDist >= 8.0 then
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,Guard );
		--近すぎれば、離れる
		else
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 9.0, TARGET_ENE_0, true, Guard );
		end
		--攻撃後っぽくウロウロ
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,Guard );
		
		
	--観衆役なら
	else
		--遠ければ、走って近づいてくる
		if targetDist >= 20.0 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 11.5, TARGET_ENE_0, false, -1 );
		--近ければ、歩いて近づいてくる
		elseif targetDist >= 13.0 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 11.5, TARGET_ENE_0, true, -1 );
		--適度な距離ならば、横に動く
		elseif targetDist >= 9.0 then
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,Guard );
		--近すぎれば、離れる
		else
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 11.0, TARGET_ENE_0, true, Guard );
		end
		--攻撃後っぽくウロウロ
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,Guard );
		
	end
	
end


---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function ippanLONG_B200012Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local K_fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--15% 3000
	--40% 3000-3001
	--15% 3300
	--30% 3000-3001-3300
	if K_fate <= 15 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 55 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function ippanLONG_B200012Battle_Kougeki_Noato(ai, goal, Guard)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local SideTime = 3.0							--横に動く時間
local BackDist = 2.5							--後退する距離
local BackTime = 3.0							--後退する時間

local bRight = ai:GetRandam_Int(0,1);			--左右移動の方向
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- 同じ方向に左右移動している仲間の数


	--60% なにもしない
	--20% 適当に横にガード移動
	--20% 後ろにガード移動
	if KN_fate <= 60  and friendNum < 1 then
		
	elseif KN_fate <= 80  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, bRight, ai:GetRandam_Int(30,45), true, true ,Guard );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, Guard );				
	end
end



---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function ippanLONG_B200012Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function ippanLONG_B200012Battle_Terminate(ai, goal)
	--非戦闘時のアニメセットに切り替えます
	ai:ChangeMoveAnimParam(0)
end

---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function ippanLONG_B200012Battle_Interupt(ai, goal)

local role = ai:GetTeamOrder(ORDER_TYPE_Role);			--自分の役割を取得
local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得

local targetDist = ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字　その３

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 1.5					--3000番の適正間合い（最大）
local Att3003_Dist_min = 4.0					--3003番の適正間合い（最小）
local Att3003_Dist_max = 5.5					--3003番の適正間合い（最大）
local Att3300_Dist_min = 0.0					--3300番の適正間合い（最小）
local Att3300_Dist_max = 1.5					--3300番の適正間合い（最大）

local Att3002_Dist_min = 0.0					--3002番の適正間合い（最小）
local Att3002_Dist_max = 0.7					--3002番の適正間合い（最大）
local Att6060_Dist_min = 2.0					--6060番の適正間合い（最小）
local Att6060_Dist_max = 5.0					--6060番の適正間合い（最大）

local myThinkId = ai:GetNpcThinkParamID()		--思考IDを取得
local myBlockId = ai:GetMyBlockID();			--自分のいるブロック

	--ブロックによるガード率設定（ガードしない率）
local fateG = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　番外編
	if myBlockId == 0 and fateG <= 60 then
		Guard			 = 0
	elseif myBlockId == 1 and fateG <= 40 then
		Guard			 = 0
	elseif myBlockId == 2 and fateG <= 20 then
		Guard			 = 0
	elseif myBlockId == 3 and fateG <= 10 then
		Guard			 = 0
	else
		Guard			 = 0
	end	

	-- コンボ逃れ　■共通関数
local combRunDist		= 1.5		--コンボ逃れする距離
local combRunPer		= 30		--コンボ逃れする確率
	if Damaged_Act(ai, goal, combRunDist, combRunPer ) then
		goal:ClearSubGoal();
		--ガード
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,9910 );
		return true;
	end	

	-- コンボ逃れ（非共通）
	if ai:IsInterupt( INTERUPT_Damaged ) then
		if targetDist >= 5.0 and fate <= 90 then
			goal:ClearSubGoal();
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 5.0, TARGET_ENE_0, false, 9910 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6060, TARGET_ENE_0, DIST_Far, 0);
			ippanLONG_B200012Battle_Kougeki_Noato(ai, goal, Guard)	
			return true;		
			
		elseif targetDist <= 5.0 and fate <= 30 then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,9910 );
			return true;		
		end
	end	


	--ガード崩壊したら攻撃　■共通関数
local guardBreakConutDist = Att6060_Dist_max	--ガード崩壊で攻撃する距離
local guardBreakConutPer = 65					--ガード崩壊で攻撃する確率
	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
		goal:ClearSubGoal();
		--距離別に対応
		if targetDist >= Att6060_Dist_min then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 6060, TARGET_ENE_0, DIST_Far, 0);
			
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
		end
		ippanLONG_B200012Battle_Kougeki_Noato(ai, goal, Guard)
		return true;
	end		

	
	--空振り追い討ち　■共通関数
local missSwingDist		= 5.0		--空振り追撃する距離
local missSwingAttPer	= 10		--空振り追撃する確率
	if MissSwing_Act(ai, goal, missSwingDist, missSwingAttPer ) then
		goal:ClearSubGoal();
		--距離別に対応
		if targetDist >= Att6060_Dist_min then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 6060, TARGET_ENE_0, DIST_Far, 0);
			
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
		end
		ippanLONG_B200012Battle_Kougeki_Noato(ai, goal, Guard)
		return true;
	end	
	
	
return false;
end