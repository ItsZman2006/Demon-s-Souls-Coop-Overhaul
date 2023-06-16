-----------------------------------------------------------------------------------------------
--	一般兵士（チュートリアル・弱い／パリィ用）　用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_IppanLONG200010_Battle, "ippanLONG200010Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_IppanLONG200010_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function ippanLONG200010Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local role = ai:GetTeamOrder(ORDER_TYPE_Role);					--自分の役割を取得

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　その３

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 1.5					--3000番の適正間合い（最大）
local Att3003_Dist_min = 0.0					--3003番の適正間合い（最小）
local Att3003_Dist_max = 1.5					--3003番の適正間合い（最大）
local Att3300_Dist_min = 0.0					--3300番の適正間合い（最小）
local Att3300_Dist_max = 1.5					--3300番の適正間合い（最大）
local Guard			   = 9910					--ガード可能なら9910　不可なら0

local Att3002_Dist_min = 0.0					--3002番の適正間合い（最小）
local Att3002_Dist_max = 0.7					--3002番の適正間合い（最大）
local Att6060_Dist_min = 2.0					--6060番の適正間合い（最小）
local Att6060_Dist_max = 5.0					--6060番の適正間合い（最大）

local myThinkId = ai:GetNpcThinkParamID()		--思考IDを取得

	--武器ごとの適正間合いを設定
	--ガードできるかどうかを設定
	if myThinkId == 201000 or myThinkId == 201004 then				--剣
		Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
		Att3000_Dist_max = 1.6					--3000番の適正間合い（最大）
		Att3003_Dist_min = 4.0					--3003番の適正間合い（最小）
		Att3003_Dist_max = 5.5					--3003番の適正間合い（最大）
		Att3300_Dist_min = 0.0					--3300番の適正間合い（最小）
		Att3300_Dist_max = 1.5					--3300番の適正間合い（最大）
		Guard			 = 9910					--ガード可能なら9910　不可なら0
		
	elseif  myThinkId == 201006 then		--スピア
		Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
		Att3000_Dist_max = 2.8					--3000番の適正間合い（最大）
		Att3003_Dist_min = 3.5					--3003番の適正間合い（最小）
		Att3003_Dist_max = 4.8					--3003番の適正間合い（最大）
		Att3300_Dist_min = 0.0					--3300番の適正間合い（最小）
		Att3300_Dist_max = 2.3					--3300番の適正間合い（最大）
		Guard			 = 9910					--ガード可能なら9910　不可なら0
		
	elseif  myThinkId == 201007 then		--アクス
		Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
		Att3000_Dist_max = 1.1					--3000番の適正間合い（最大）
		Att3003_Dist_min = 3.7					--3003番の適正間合い（最小）
		Att3003_Dist_max = 5.3					--3003番の適正間合い（最大）
		Att3300_Dist_min = 0.0					--3300番の適正間合い（最小）
		Att3300_Dist_max = 2.0					--3300番の適正間合い（最大）
		Guard			 = 9910					--ガード可能なら9910　不可なら0
		
	elseif  myThinkId == 201008 then		--ハルバード
		Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
		Att3000_Dist_max = 2.3					--3000番の適正間合い（最大）
		Att3003_Dist_min = 4.0					--3003番の適正間合い（最小）
		Att3003_Dist_max = 6.2					--3003番の適正間合い（最大）
		Att3300_Dist_min = 0.0					--3300番の適正間合い（最小）
		Att3300_Dist_max = 2.5					--3300番の適正間合い（最大）
		Guard			 = 0					--ガード可能なら9910　不可なら0
		
	else
		--ここに来てはいけない
	end

local Act01Per = 0		--ダッシュ接近＆ガード崩し
local Act02Per = 0		--歩行接近＆ガード崩し
local Act03Per = 0		--ダッシュ接近＆助走攻撃
local Act04Per = 0		--ダッシュ間合い調整＆火炎瓶	
local Act05Per = 0		--ダッシュ接近＆溜め斬り
local Act06Per = 0		--ダッシュ接近＆近接攻撃
local Act07Per = 0		--歩行接近＆助走攻撃
local Act08Per = 0		--歩行間合い調整＆火炎瓶	
local Act09Per = 0		--歩行接近＆溜め斬り
local Act10Per = 0		--歩行接近＆近接攻撃
local Act11Per = 0		--回復を使う

	--遠いなら
	if targetDist >= 8.0 then
		--PCがガードしていたら	
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆助走攻撃
			Act04Per = 0		--ダッシュ間合い調整＆火炎瓶	
			Act05Per = 0		--ダッシュ接近＆溜め斬り
			Act06Per = 50		--ダッシュ接近＆近接攻撃
			Act07Per = 0		--歩行接近＆助走攻撃
			Act08Per = 0		--歩行間合い調整＆火炎瓶	
			Act09Per = 0		--歩行接近＆溜め斬り
			Act10Per = 50		--歩行接近＆近接攻撃
			Act11Per = 0		--回復を使う
			
		--そうでなければ	
		else
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 5		--ダッシュ接近＆助走攻撃
			Act04Per = 0		--ダッシュ間合い調整＆火炎瓶	
			Act05Per = 0		--ダッシュ接近＆溜め斬り
			Act06Per = 50		--ダッシュ接近＆近接攻撃
			Act07Per = 5		--歩行接近＆助走攻撃
			Act08Per = 0		--歩行間合い調整＆火炎瓶	
			Act09Per = 0		--歩行接近＆溜め斬り
			Act10Per = 40		--歩行接近＆近接攻撃
			Act11Per = 0		--回復を使う
			
		end	
		
	--ダッシュしても良い程度に遠いなら	
	elseif targetDist >= 4.0 then	
		--PCがガードしていたら	
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 10		--ダッシュ接近＆助走攻撃
			Act04Per = 0		--ダッシュ間合い調整＆火炎瓶	
			Act05Per = 0		--ダッシュ接近＆溜め斬り
			Act06Per = 35		--ダッシュ接近＆近接攻撃
			Act07Per = 5		--歩行接近＆助走攻撃
			Act08Per = 0		--歩行間合い調整＆火炎瓶	
			Act09Per = 0		--歩行接近＆溜め斬り
			Act10Per = 50		--歩行接近＆近接攻撃
			Act11Per = 0		--回復を使う
			
		else
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆助走攻撃
			Act04Per = 0		--ダッシュ間合い調整＆火炎瓶	
			Act05Per = 0		--ダッシュ接近＆溜め斬り
			Act06Per = 30		--ダッシュ接近＆近接攻撃
			Act07Per = 20		--歩行接近＆助走攻撃
			Act08Per = 0		--歩行間合い調整＆火炎瓶	
			Act09Per = 10		--歩行接近＆溜め斬り
			Act10Per = 40		--歩行接近＆近接攻撃
			Act11Per = 0		--回復を使う
			
		end
		
	--助走攻撃しても良い程度に遠いなら
	elseif targetDist >= Att3003_Dist_max then	
		--PCがガードしていたら	
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆助走攻撃
			Act04Per = 0		--ダッシュ間合い調整＆火炎瓶	
			Act05Per = 0		--ダッシュ接近＆溜め斬り
			Act06Per = 0		--ダッシュ接近＆近接攻撃
			Act07Per = 30		--歩行接近＆助走攻撃
			Act08Per = 0		--歩行間合い調整＆火炎瓶	
			Act09Per = 0		--歩行接近＆溜め斬り
			Act10Per = 70		--歩行接近＆近接攻撃
			Act11Per = 0		--回復を使う
			
		else
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆助走攻撃
			Act04Per = 0		--ダッシュ間合い調整＆火炎瓶	
			Act05Per = 0		--ダッシュ接近＆溜め斬り
			Act06Per = 0		--ダッシュ接近＆近接攻撃
			Act07Per = 20		--歩行接近＆助走攻撃
			Act08Per = 0		--歩行間合い調整＆火炎瓶	
			Act09Per = 10		--歩行接近＆溜め斬り
			Act10Per = 70		--歩行接近＆近接攻撃
			Act11Per = 0		--回復を使う
		end
		
	--近いなら	
	else	
		--PCがガードしていたら
		if ai:IsTargetGuard( TARGET_ENE_0 ) then
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆助走攻撃
			Act04Per = 0		--ダッシュ間合い調整＆火炎瓶	
			Act05Per = 0		--ダッシュ接近＆溜め斬り
			Act06Per = 0		--ダッシュ接近＆近接攻撃
			Act07Per = 20		--歩行接近＆助走攻撃
			Act08Per = 0		--歩行間合い調整＆火炎瓶	
			Act09Per = 20		--歩行接近＆溜め斬り
			Act10Per = 60		--歩行接近＆近接攻撃
			Act11Per = 0		--回復を使う
			
		else
			Act01Per = 0		--ダッシュ接近＆ガード崩し
			Act02Per = 0		--歩行接近＆ガード崩し
			Act03Per = 0		--ダッシュ接近＆助走攻撃
			Act04Per = 0		--ダッシュ間合い調整＆火炎瓶	
			Act05Per = 0		--ダッシュ接近＆溜め斬り
			Act06Per = 0		--ダッシュ接近＆近接攻撃
			Act07Per = 0		--歩行接近＆助走攻撃
			Act08Per = 0		--歩行間合い調整＆火炎瓶	
			Act09Per = 25		--歩行接近＆溜め斬り
			Act10Per = 75		--歩行接近＆近接攻撃
			Act11Per = 0		--回復を使う
			
		end
	end

	-- 最初にちょっとだけ待つ
	if ai:IsFinishTimer(0) == true then
		local firstTime = ai:GetRandam_Float(0.0, 1.0)			--最初の動き出しまでの時間
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
		ai:SetTimer( 0, 9999.0 );
	end

	--戦闘用のアニメセットに切り替えます
	ai:ChangeMoveAnimParam(2)

	--攻撃役、その他役なら
	if role == ROLE_TYPE_Attack or role == ROLE_TYPE_None then
		
		--行動01　ダッシュ接近＆ガード崩し
		if fate2 <= Act01Per then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
			if fate3 <= 90 then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6060, TARGET_ENE_0, DIST_Far, 0);
			end	
			
		--行動02　歩行接近＆ガード崩し
		elseif fate2 <= (Act01Per + Act02Per) then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);		
			if fate3 <= 90 then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6060, TARGET_ENE_0, DIST_Far, 0);
			end	
			
		--行動03　ダッシュ接近＆助走攻撃
		elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);		
			
		--行動04　ダッシュ間合い調整＆火炎瓶	
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
			goal:AddSubGoal(GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, Att6060_Dist_min, Att6060_Dist_max, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6060, TARGET_ENE_0, DIST_Far, 0);			
			
		--行動05　ダッシュ接近＆溜め斬り
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per) then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3300_Dist_max, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);	
			
		--行動06　ダッシュ接近＆近接攻撃
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per) then	
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, -1 );
			ippanLONG200010Battle_Kougeki(ai, goal)	
			
		--行動07　歩行接近＆助走攻撃
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per) then	
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);	
			
		--行動08　歩行間合い調整＆火炎瓶	
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per + Act08Per) then
			goal:AddSubGoal(GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, Att6060_Dist_min, Att6060_Dist_max, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6060, TARGET_ENE_0, DIST_Far, 0);	
			
		--行動09　歩行接近＆溜め斬り
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per + Act08Per + Act09Per) then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3300_Dist_max, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);		
			
		--行動10　歩行接近＆近接攻撃
		elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per + Act07Per + Act08Per + Act09Per + Act10Per) then	
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, -1 );
			ippanLONG200010Battle_Kougeki(ai, goal)			
			
		--行動11　回復を使う
		else
			goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 8.0, TARGET_ENE_0, true, -1 );				
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6200, TARGET_ENE_0, DIST_Far, 0);		
		end
		ippanLONG200010Battle_Kougeki_Noato(ai, goal)
		
		
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
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
		--近すぎれば、離れる
		else
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, true, -1 );
		end
		--攻撃後っぽくウロウロ
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
		
		
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
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
		--近すぎれば、離れる
		else
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 6.0, TARGET_ENE_0, true, -1 );
		end
		--攻撃後っぽくウロウロ
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
		
	end
end


---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function ippanLONG200010Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local K_fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--5% 3000
	--70% 3000-3001
	--20% 3000-3001-3300
	--5%  3001
	if K_fate <= 5 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 75 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 95 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	end
end

	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function ippanLONG200010Battle_Kougeki_Noato(ai, goal, Guard)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local SideTime = 3.0							--横に動く時間
local BackDist = 2.5							--後退する距離
local BackTime = 3.0							--後退する時間

local bRight = ai:GetRandam_Int(0,1);			--左右移動の方向
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- 同じ方向に左右移動している仲間の数


	--35% なにもしない（ちょっとだけ横移動）
	--40% 適当に横にガード移動
	--35% 後ろにガード移動
	if KN_fate <= 35  and friendNum < 1 then
		
	elseif KN_fate <= 65  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
	else
		goal:AddSubGoal(GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, Guard );
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
	end
end



---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function ippanLONG200010Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function ippanLONG200010Battle_Terminate(ai, goal)
	--非戦闘時のアニメセットに切り替えます
	ai:ChangeMoveAnimParam(0)
end

---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function ippanLONG200010Battle_Interupt(ai, goal)

--local targetDist = ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
--local fate = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字
--local fate2 = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字　その２
--local fate3 = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字　その３
	
--local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
--local Att3000_Dist_max = 1.5					--3000番の適正間合い（最大）
--local Att3003_Dist_min = 0.0					--3003番の適正間合い（最小）
--local Att3003_Dist_max = 1.5					--3003番の適正間合い（最大）
--local Att3300_Dist_min = 0.0					--3300番の適正間合い（最小）
--local Att3300_Dist_max = 1.5					--3300番の適正間合い（最大）
--local Guard			   = 9910					--ガード可能なら9910　不可なら0

--local Att3002_Dist_min = 0.0					--3002番の適正間合い（最小）
--local Att3002_Dist_max = 0.7					--3002番の適正間合い（最大）
--local Att6060_Dist_min = 2.0					--6060番の適正間合い（最小）
--local Att6060_Dist_max = 5.0					--6060番の適正間合い（最大）

--local myThinkId = ai:GetNpcThinkParamID()		--思考IDを取得

	--武器ごとの適正間合いを設定
	--ガードできるかどうかを設定
--	if myThinkId == 201000 or myThinkId == 201004 then	--剣
--		Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
--		Att3000_Dist_max = 1.6					--3000番の適正間合い（最大）
--		Att3003_Dist_min = 4.0					--3003番の適正間合い（最小）
--		Att3003_Dist_max = 5.5					--3003番の適正間合い（最大）
--		Att3300_Dist_min = 0.0					--3300番の適正間合い（最小）
--		Att3300_Dist_max = 1.5					--3300番の適正間合い（最大）
--		Guard			 = 9910					--ガード可能なら9910　不可なら0
		
--	elseif  myThinkId == 201006 then		--スピア
--		Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
--		Att3000_Dist_max = 2.8					--3000番の適正間合い（最大）
--		Att3003_Dist_min = 3.5					--3003番の適正間合い（最小）
--		Att3003_Dist_max = 4.8					--3003番の適正間合い（最大）
--		Att3300_Dist_min = 0.0					--3300番の適正間合い（最小）
--		Att3300_Dist_max = 2.3					--3300番の適正間合い（最大）
--		Guard			 = 9910					--ガード可能なら9910　不可なら0
		
--	elseif  myThinkId == 201007 then		--アクス
--		Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
--		Att3000_Dist_max = 1.1					--3000番の適正間合い（最大）
--		Att3003_Dist_min = 3.7					--3003番の適正間合い（最小）
--		Att3003_Dist_max = 5.3					--3003番の適正間合い（最大）
--		Att3300_Dist_min = 0.0					--3300番の適正間合い（最小）
--		Att3300_Dist_max = 2.0					--3300番の適正間合い（最大）
--		Guard			 = 9910					--ガード可能なら9910　不可なら0
		
--	elseif  myThinkId == 201008 then		--ハルバード
--		Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
--		Att3000_Dist_max = 2.3					--3000番の適正間合い（最大）
--		Att3003_Dist_min = 4.0					--3003番の適正間合い（最小）
--		Att3003_Dist_max = 6.2					--3003番の適正間合い（最大）
--		Att3300_Dist_min = 0.0					--3300番の適正間合い（最小）
--		Att3300_Dist_max = 2.5					--3300番の適正間合い（最大）
--		Guard			 = 0					--ガード可能なら9910　不可なら0
		
--	else
		--ここに来てはいけない
--	end


	-- コンボ逃れ　■共通関数
--local combRunDist		= 1.0		--コンボ逃れする距離
--local combRunPer		= 50		--コンボ逃れする確率
--	if Damaged_Act(ai, goal, combRunDist, combRunPer ) then
--		goal:ClearSubGoal();
		--ガードできる人はガード
--		if Guard == 9910 then
--			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,Guard );
--		else
		--ガード出来ない人は攻撃
--			ippanLONG200010Battle_Kougeki(ai, goal)
--			ippanLONG200010Battle_Kougeki_Noato(ai, goal, Guard)
--		end
--		return true;
--	end	

	--ガード崩壊したら攻撃　■共通関数
--local guardBreakConutDist = Att3003_Dist_max	--ガード崩壊で攻撃する距離
--local guardBreakConutPer = 65					--ガード崩壊で攻撃する確率
--	if FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer ) then
--		goal:ClearSubGoal();
		--距離別に対応
--		if targetDist >= Att3003_Dist_min then
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
			
--		else
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
--		end
--		ippanLONG200010Battle_Kougeki_Noato(ai, goal, Guard)
--		return true;
--	end		

	--空振り追い討ち　■共通関数
--local missSwingDist		= 5.0		--空振り追撃する距離
--local missSwingAttPer	= 10		--空振り追撃する確率
--	if MissSwing_Act(ai, goal, missSwingDist, missSwingAttPer ) then
--		goal:ClearSubGoal();
		--距離別に対応
--		if targetDist >= 2.0 then
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6060, TARGET_ENE_0, DIST_Far, 0);
			
--		else
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3300, TARGET_ENE_0, DIST_Middle, 0);
			
--		end
--		ippanLONG200010Battle_Kougeki_Noato(ai, goal, Guard)
--		return true;
--	end	

	
return false;
end


