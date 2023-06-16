-----------------------------------------------------------------------------------------------
--	arasiSensi602000専用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし

-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_ArasiSensi602000_Battle, "ArasiSensi602000Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_ArasiSensi602000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function ArasiSensi602000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字	
local fate2 = ai:GetRandam_Int(1,100)
local fate3 = ai:GetRandam_Int(1,100)
local fate4 = ai:GetRandam_Int(1,100)

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 4.8					--3000番の適正間合い（最大）
local Att3001_Dist_min = 0.0					--3001番の適正間合い（最小）
local Att3001_Dist_max = 4.5					--3001番の適正間合い（最大）
local Att3002_Dist_min = 0.0					--3002番の適正間合い（最小）
local Att3002_Dist_max = 6.8					--3002番の適正間合い（最大）
local Att3003_Dist_min = 0.0					--3003番の適正間合い（最小）
local Att3003_Dist_max = 3.7					--3003番の適正間合い（最大）
local Att3302_Dist_min = 8.5					--3302番の適正間合い（最小）
local Att3302_Dist_max = 15.0					--3302番の適正間合い（最大）
local Att3304_Dist_min = 3.0					--3304番の適正間合い（最小）
local Att3304_Dist_max = 8.2					--3304番の適正間合い（最大）
local Att3306_Dist_min = 0.0					--3306番の適正間合い（最小）
local Att3306_Dist_max = 6.2					--3306番の適正間合い（最大）

local Act01Per = 0		--ダッシュ＆飛び込み
local Act02Per = 0		--ダッシュ＆3304コンボ
local Act03Per = 0		--ダッシュ＆3306コンボ
local Act04Per = 0		--ダッシュ＆3000コンボ
local Act05Per = 0		--単発薙ぎ
local Act06Per = 0		--単発アッパー
local Act07Per = 0		--単発足元
--local Act08Per = 0		--（予備）

	--怒りの猛攻　怒っていないときはlogicで動く

	--うんと遠いなら
	if targetDist >= 15.0 then
		Act01Per = 85		--ダッシュ＆飛び込み
		Act02Per = 10		--ダッシュ＆3304コンボ
		Act03Per = 5		--ダッシュ＆3306コンボ
		Act04Per = 0		--ダッシュ＆3000コンボ
		Act05Per = 0		--単発薙ぎ
		Act06Per = 0		--単発アッパー
		Act07Per = 0		--単発足元
		
	--飛び込み　最適間合い
	elseif targetDist >= 9.0 then
		Act01Per = 75		--ダッシュ＆飛び込み
		Act02Per = 20		--ダッシュ＆3304コンボ
		Act03Per = 5		--ダッシュ＆3306コンボ
		Act04Per = 0		--ダッシュ＆3000コンボ
		Act05Per = 0		--単発薙ぎ
		Act06Per = 0		--単発アッパー
		Act07Per = 0		--単発足元
		
	--3304コンボ　最適間合い
	elseif targetDist >= 6.2 then
		Act01Per = 0		--ダッシュ＆飛び込み
		Act02Per = 80		--ダッシュ＆3304コンボ
		Act03Per = 15		--ダッシュ＆3306コンボ
		Act04Per = 5		--ダッシュ＆3000コンボ
		Act05Per = 0		--単発薙ぎ
		Act06Per = 0		--単発アッパー
		Act07Per = 0		--単発足元
		
	--3306コンボ　最適間合い
	elseif targetDist >= 4.8 then
		Act01Per = 0		--ダッシュ＆飛び込み
		Act02Per = 5		--ダッシュ＆3304コンボ
		Act03Per = 40		--ダッシュ＆3306コンボ
		Act04Per = 5		--ダッシュ＆3000コンボ
		Act05Per = 50		--単発薙ぎ
		Act06Per = 0		--単発アッパー
		Act07Per = 0		--単発足元
		
	--3000コンボ　最適間合い
	elseif targetDist >= 2.5 then
		Act01Per = 0		--ダッシュ＆飛び込み
		Act02Per = 0		--ダッシュ＆3304コンボ
		Act03Per = 10		--ダッシュ＆3306コンボ
		Act04Per = 55		--ダッシュ＆3000コンボ
		Act05Per = 10		--単発薙ぎ
		Act06Per = 5		--単発アッパー
		Act07Per = 20		--単発足元
		
	--単発足元　最適間合い
	else
		Act01Per = 0		--ダッシュ＆飛び込み
		Act02Per = 0		--ダッシュ＆3304コンボ
		Act03Per = 10		--ダッシュ＆3306コンボ
		Act04Per = 25		--ダッシュ＆3000コンボ
		Act05Per = 0		--単発薙ぎ
		Act06Per = 35		--単発アッパー
		Act07Per = 30		--単発足元
		
	end

	--行動01　ダッシュ＆飛び込み
	if fate2 <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3302_Dist_max, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3302, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動02　ダッシュ＆3304コンボ
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3304_Dist_max, TARGET_ENE_0, false, -1 );
		ArasiSensi602000Battle_Att3304(ai, goal)
		
	--行動03　ダッシュ＆3306コンボ
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, false, -1 );
		ArasiSensi602000Battle_Att3306(ai, goal)
		
	--行動04　ダッシュ＆3000コンボ
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, -1 );
		ArasiSensi602000Battle_Att3000(ai, goal)
		
	--行動05　単発薙ぎ
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per) then
		goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動06　単発アッパー
	elseif fate2 <= (Act01Per + Act02Per + Act03Per + Act04Per + Act05Per + Act06Per) then	
		goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動07　単発足元
	else
		goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	end
	ArasiSensi602000Battle_Kougeki_Noato(ai, goal)
	
end

---------------------------------------------------------
--  3304コンボ
---------------------------------------------------------
function ArasiSensi602000Battle_Att3304(ai, goal)

local Att3304_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--60％ 3304-3305-3306
	--30％ 3304-3305
	--10％ 3304-3305-3306-3001
--	if Att3304_fate <= 60 then
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3305, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);
--		
--	elseif Att3304_fate <= 90 then
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3305, TARGET_ENE_0, DIST_Middle, 0);
--		
--	else
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3305, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);	--Attack
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
--	end
	
	
	--60％ 3304
	--40％ 3304-3001
	if Att3304_fate <= 60 then
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	end	
	
	
end


---------------------------------------------------------
--  3306コンボ
---------------------------------------------------------
function ArasiSensi602000Battle_Att3306(ai, goal)

local Att3306_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--30％ 3306-3304-3305-3306
	--60％ 3306-3304-3305
	--10％ 3306-3304-3305-3306-3001
--	if Att3306_fate <= 30 then
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3305, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);
--		
--	elseif Att3306_fate <= 90 then
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3305, TARGET_ENE_0, DIST_Middle, 0);
--		
--	else
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3305, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);	--Attack
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
--	end


	--30％ 3306
	--40％ 3306-3304
	--30％ 3306-3304-3001
	if Att3306_fate <= 30 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3306_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	end	
	
	
end


---------------------------------------------------------
--  3000コンボ
---------------------------------------------------------
function ArasiSensi602000Battle_Att3000(ai, goal)

local Att3000_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--40％ 3000-3304-3305-3306
	--50％ 3000-3304-3305
	--10％ 3000-3304-3305-3306-3001
--	if Att3000_fate <= 40 then
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3305, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);
--		
--	elseif Att3000_fate <= 90 then
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3305, TARGET_ENE_0, DIST_Middle, 0);
--		
--	else
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3304, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3305, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3306, TARGET_ENE_0, DIST_Middle, 0);
--		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
--	end
	
	--35％ 3000
	--15％ 3000-3001
	--35％ 3000-3002
	--15％ 3000-3002-3001
	if Att3000_fate <= 35 then
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3000_fate <= 50 then
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif Att3000_fate <= 85 then
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	end
	
	
end



---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function ArasiSensi602000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

local KNAct01Per	= 70	--何もしない
local KNAct02Per	= 5		--右ステップ
local KNAct03Per	= 5		--左ステップ
local KNAct04Per	= 0		--少しだけ横移動
local KNAct05Per	= 15	--バックステップ
local KNAct06Per	= 5		--前ステップ

	--行動01　何もしない
	if  KN_fate <= KNAct01Per then
   		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.0,1.0) ,0,0,0,0)
		
	--行動02　右ステップ
	elseif  KN_fate <= (KNAct01Per + KNAct02Per) then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 703, TARGET_ENE_0, 0);
		
	--行動03　左ステップ
	elseif  KN_fate <= (KNAct01Per + KNAct02Per + KNAct03Per) then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 702, TARGET_ENE_0, 0);
		
	--行動04　少しだけ横移動
	elseif  KN_fate <= (KNAct01Per + KNAct02Per + KNAct03Per + KNAct04Per) then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
		
	--行動05　バックステップ
	elseif  KN_fate <= (KNAct01Per + KNAct02Per + KNAct03Per + KNAct04Per + KNAct05Per) then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 701, TARGET_ENE_0, 0);
		
	else	
	--行動06　前ステップ
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 700, TARGET_ENE_0, 0);
		
	end
end


---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function ArasiSensi602000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function ArasiSensi602000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function ArasiSensi602000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字	
local fate2 = ai:GetRandam_Int(1,100)
local fate3 = ai:GetRandam_Int(1,100)
local fate4 = ai:GetRandam_Int(1,100)

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 4.8					--3000番の適正間合い（最大）
local Att3001_Dist_min = 0.0					--3001番の適正間合い（最小）
local Att3001_Dist_max = 4.5					--3001番の適正間合い（最大）
local Att3002_Dist_min = 0.0					--3002番の適正間合い（最小）
local Att3002_Dist_max = 6.8					--3002番の適正間合い（最大）
local Att3003_Dist_min = 0.0					--3003番の適正間合い（最小）
local Att3003_Dist_max = 3.7					--3003番の適正間合い（最大）
local Att3302_Dist_min = 8.5					--3302番の適正間合い（最小）
local Att3302_Dist_max = 15.0					--3302番の適正間合い（最大）
local Att3304_Dist_min = 3.0					--3304番の適正間合い（最小）
local Att3304_Dist_max = 8.2					--3304番の適正間合い（最大）
local Att3306_Dist_min = 0.0					--3306番の適正間合い（最小）
local Att3306_Dist_max = 6.2					--3306番の適正間合い（最大）

	--至近距離でダメージ受けたらコンボとみなして後退or反撃
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist	 = 3.0			--コンボ逃れする距離
local combRunPer	 = 60			--コンボ逃れする確率
		if targetDist <= combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				if fate2 <= 25 then
					--逃れる
					if fate3 <= 60 then
						goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 701, TARGET_ENE_0, 0.0, AI_DIR_TYPE_B, 3);
					elseif fate3 <= 80 then
						goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 702, TARGET_ENE_0, 0.0, AI_DIR_TYPE_L, 3);
					else
						goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 703, TARGET_ENE_0, 0.0, AI_DIR_TYPE_R, 3);
					end
					
				else
					if fate3 <= 30 then
						goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
					else
						ArasiSensi602000Battle_Att3000(ai, goal)
					end
					ArasiSensi602000Battle_Kougeki_Noato(ai, goal)
				end	
					
				return true;
			end
		end
	end	

	--飛び道具を撃ってきたら最適行動
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 60					--飛び道具使用時に最適行動を取る確率（近いとき）
local shootIntPer2 = 60					--飛び道具使用時に最適行動を取る確率（やや遠いとき）
local shootIntPer3 = 80					--飛び道具使用時に最適行動を取る確率（遠いとき）
local Per2_Dist = 2.5					--「やや遠い」の距離
local Per3_Dist = 8.5					--「遠い」の距離

		--近い
		if targetDist <= Per2_Dist then
			if fate <= shootIntPer then
				goal:ClearSubGoal();
				if fate2 <= 40 then
					goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
				end
				return true
			end
			
		--やや遠い
		elseif targetDist <= Per3_Dist then
			if fate <= shootIntPer2 then
				goal:ClearSubGoal();
				if fate2 <= 70 then
					goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, -1 );
					ArasiSensi602000Battle_Att3000(ai, goal)
				else
					goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, false, -1 );
					ArasiSensi602000Battle_Att3306(ai, goal)
				end
				return true
			end
			
		--遠い
		else
			if fate <= shootIntPer3 then
				goal:ClearSubGoal();
				if fate2 <= 80 then
					goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3302_Dist_max, TARGET_ENE_0, false, -1 );
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3302, TARGET_ENE_0, DIST_Middle, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3304_Dist_max, TARGET_ENE_0, false, -1 );
					ArasiSensi602000Battle_Att3304(ai, goal)
				end
				return true
			end	
		end
	end


	
return false;
end

