-----------------------------------------------------------------------------------------------
--	王の剣　戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Ounoken502000_Battle, "Ounoken502000Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Ounoken502000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function Ounoken502000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);				--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字　その３

local AttRen_Dist_min = 0.0						--連続攻撃の適正間合い（最小）
local AttRen_Dist_max = 3.5						--連続攻撃の適正間合い（最大）
local Att3070_Dist_min = 3.0					--3070番の適正間合い（最小）
local Att3070_Dist_max = 5.5					--3070番の適正間合い（最大）


	--うんと遠いなら、走って迫る
	if targetDist >= 7.0 then
		if fate <= 60 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 4.5, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3070, TARGET_ENE_0, DIST_Middle, 0);
			Ounoken502000Battle_Kougeki_Noato(ai, goal)
		else
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, AttRen_Dist_max, TARGET_ENE_0, false, -1 );
			Ounoken502000Battle_Renzoku(ai, goal)
			Ounoken502000Battle_Kougeki_Noato(ai, goal)
		end
		
	--やや遠いならゆっくり近づいてくる
	--しばしばステップ攻撃
	elseif targetDist >= 3.5 then
		if fate <= 80 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, Att3070_Dist_max, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3070, TARGET_ENE_0, DIST_Middle, 0);
			Ounoken502000Battle_Kougeki_Noato(ai, goal)
		else
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, AttRen_Dist_max, TARGET_ENE_0, true, -1 );
			Ounoken502000Battle_Renzoku(ai, goal)
			Ounoken502000Battle_Kougeki_Noato(ai, goal)
		end
		
	--近すぎないなら、連続攻撃を狙う
	--ただしガード中だったら、まず突きを狙う
	elseif targetDist >= 0.5 then
		if ai:IsTargetGuard( TARGET_ENE_0 ) and 
		   fate <= 75 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
			Ounoken502000Battle_Renzoku(ai, goal)
			Ounoken502000Battle_Kougeki_Noato(ai, goal)
		else 
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, AttRen_Dist_max, TARGET_ENE_0, true, -1 );
			Ounoken502000Battle_Renzoku(ai, goal)
			Ounoken502000Battle_Kougeki_Noato(ai, goal)
		end
		
	--近すぎるなら、連続攻撃を狙うか、一気に距離を離す	
	else
		if fate <= 75 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, AttRen_Dist_max, TARGET_ENE_0, true, -1 );
			Ounoken502000Battle_Renzoku(ai, goal)
			Ounoken502000Battle_Kougeki_Noato(ai, goal)
		else
			goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 4);
			--ステップの後に攻撃する
			local stepConutPer = 40					--攻撃を試みる確率
			if fate2 <= stepConutPer then
				if KN_fate3 <= 50 then
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3060, TARGET_ENE_0, DIST_Middle, 0);
				end
			end
		end
	end
end	



---------------------------------------------------------
--  連続攻撃
---------------------------------------------------------
function Ounoken502000Battle_Renzoku(ai, goal)

	local R_fate = ai:GetRandam_Int(1,100)
	local R_fate2 = ai:GetRandam_Int(1,100)

--[[コピペ用
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3060, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3070, TARGET_ENE_0, DIST_Middle, 0);
]]
	
	--15％ 3000-3020-3050or3060				--いきなり突き刺し
	--5％ 3000-3030or3050					--いきなり左薙ぎ系
	--20％ 3000-3010-3040or3060				--３連で右薙ぎ系
	--30％ 3000-3010-3020					--３連で突き刺し
	--10％ 3000-3010-3020-3060-3030or3050	--３連で突き刺し　続いて２連薙ぎ
	--10％ 3000-3010-3020-3050-3040or3060	--３連で突き刺し　続いて２連薙ぎ（左右違い）
	--5％ 3060-3030or3050					--いきなり２連薙ぎ
	--5％ 3050-3040or3060					--いきなり２連薙ぎ（左右違い）

	if R_fate <= 15 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
		if R_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3060, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	elseif R_fate <= 20 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		if R_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	elseif R_fate <= 40 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		if R_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3060, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	elseif R_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
		
	elseif R_fate <= 80 then	
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3060, TARGET_ENE_0, DIST_Middle, 0);
		if R_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	elseif R_fate <= 90 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
		if R_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3060, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	elseif R_fate <= 95 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3060, TARGET_ENE_0, DIST_Middle, 0);
		if R_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Middle, 0);
		if R_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3060, TARGET_ENE_0, DIST_Middle, 0);
		end	
	end
	
end


---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function Ounoken502000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local KN_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local KN_fate3 = ai:GetRandam_Int(1,100)		--確率判定用
local KN_fate4 = ai:GetRandam_Int(1,100)		--確率判定用

	--65％　なにもしない
	--10％　少し横に移動
	--5％　後退で間をあける
	--20％　ステップで後退
	if KN_fate <= 65 then
		
	elseif KN_fate <= 75 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
	elseif KN_fate <= 80 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, true, -1 );				
	else
		if KN_fate2 <= 70 then
			goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 4);
		elseif KN_fate2 <= 85 then
			goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0, AI_DIR_TYPE_L, 4);
		else
			goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0, AI_DIR_TYPE_R, 4);
		end
		
		--ステップの後に攻撃する
		local stepConutPer = 40					--攻撃を試みる確率
		if KN_fate3 <= stepConutPer then
			if KN_fate4 <= 50 then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Near, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3060, TARGET_ENE_0, DIST_Near, 0);
			end
		end
	end
end




---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function Ounoken502000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function Ounoken502000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function Ounoken502000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);				--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字　その３
local fate4 = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字　その４
local fate5 = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字　その５

local AttRen_Dist_min = 0.0						--連続攻撃の適正間合い（最小）
local AttRen_Dist_max = 3.5						--連続攻撃の適正間合い（最大）
local Att3070_Dist_min = 3.0					--3070番の適正間合い（最小）
local Att3070_Dist_max = 5.5					--3070番の適正間合い（最大）


	--空振りしたら攻撃
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 3.5			--空振り追撃する距離
local MissSwingAttPer = 30			--空振り追撃する確率	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				--65％突いてから連続攻撃　35％連続攻撃
				if fate2 <= 65 then
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
					Ounoken502000Battle_Renzoku(ai, goal)
				else
					Ounoken502000Battle_Renzoku(ai, goal)
				end
				Ounoken502000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end	
	end

	--至近距離でダメージ受けたらコンボとみなして後退
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.5				--コンボ逃れする距離
local combRunPer = 40				--コンボ逃れする確率
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
				if fate2 <= 60 then
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 4);
				elseif fate2 <= 80 then
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0, AI_DIR_TYPE_L, 4);
				else
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0, AI_DIR_TYPE_R, 4);
				end
				return true;
			end
		end
	end	

	--至近距離で攻撃されそうになったら超反応ステップ
	if ai:IsInterupt( INTERUPT_FindAttack ) then
local superStepDist = 2.0			--超反応する距離
local superStepPer = 10				--超反応する確率	
		if targetDist <= superStepDist then
			if fate <= superStepPer then
				goal:ClearSubGoal();
				--逃れる
				if fate2 <= 60 then
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 4);
				elseif fate2 <= 80 then
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0, AI_DIR_TYPE_L, 4);
				else
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0, AI_DIR_TYPE_R, 4);
				end
				return true;
			end
		end
	end

	--ガード崩壊したら攻撃
	if ai:IsInterupt( INTERUPT_GuardBreak ) then
local guardBreakConutDist = 3.5			--ガード崩壊で攻撃する距離
local guardBreakConutPer = 65			--ガード崩壊で攻撃する確率
		if targetDist <= guardBreakConutDist then
			if fate <= guardBreakConutPer then
				goal:ClearSubGoal();
				--65％突いてから連続攻撃　35％連続攻撃
				if fate2 <= 65 then
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
					Ounoken502000Battle_Renzoku(ai, goal)
				else
					Ounoken502000Battle_Renzoku(ai, goal)
				end
				Ounoken502000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end
	end
	

	--飛び道具を撃ってきたら最適行動
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 40					--飛び道具使用時に最適行動を取る確率（近いとき）
local shootIntPer2 = 65					--飛び道具使用時に最適行動を取る確率（やや遠いとき）
local shootIntPer3 = 90					--飛び道具使用時に最適行動を取る確率（遠いとき）
local Per2_Dist = 3.5					--「やや遠い」の距離
local Per3_Dist = 5.5					--「遠い」の距離
local shootIntConutPer = 75				--反撃を試みる確率（近いとき）
local shootIntConutPer2 = 65			--反撃を試みる確率（やや遠いとき）
local shootIntConutPer3 = 65			--反撃を試みる確率（遠いとき）

		--近い
		if targetDist <= Per2_Dist then
			if fate <= shootIntPer then
				goal:ClearSubGoal();
				if fate2 <= 50 then
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0, AI_DIR_TYPE_L, 4);
				else
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0, AI_DIR_TYPE_R, 4);
				end
				
				--連続攻撃
				if fate3 <= shootIntConutPer then
					Ounoken502000Battle_Renzoku(ai, goal)
					Ounoken502000Battle_Kougeki_Noato(ai, goal)
				end
				return true
			end
			
		--やや遠い
		elseif targetDist <= Per3_Dist then
			if fate <= shootIntPer2 then
				if fate2 <= 50 then
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0, AI_DIR_TYPE_L, 4);
				else
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0, AI_DIR_TYPE_R, 4);
				end
				
				--ステップ攻撃
				if fate3 <= shootIntConutPer2 then
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3070, TARGET_ENE_0, DIST_Middle, 0);
					Ounoken502000Battle_Kougeki_Noato(ai, goal)
				end
				return true
			end
			
		--遠い
		else
			if fate <= shootIntPer3 then
				goal:ClearSubGoal();
				if fate2 <= 50 then
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 702, TARGET_ENE_0, 0, AI_DIR_TYPE_L, 4);
				else
					goal:AddSubGoal( GOAL_COMMON_SpinStep, 10.0, 703, TARGET_ENE_0, 0, AI_DIR_TYPE_R, 4);
				end
				
				if fate3 <= shootIntConutPer3 then
					--怒りのダッシュ＆ステップ攻撃or連続攻撃
					if fate4 <= 75 then
						goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3070_Dist_max, TARGET_ENE_0, false, -1 );
						goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3070, TARGET_ENE_0, DIST_Middle, 0);
						Ounoken502000Battle_Kougeki_Noato(ai, goal)
					else	
						goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, AttRen_Dist_max, TARGET_ENE_0, false, -1 );
						Ounoken502000Battle_Renzoku(ai, goal)
						Ounoken502000Battle_Kougeki_Noato(ai, goal)
					end
				end
				
				return true
			end	
		end
	end
	
return false;
end



