-----------------------------------------------------------------------------------------------
--	牢城１教会前ブラックゴースト用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_RouBG_836000_Battle, "RouBG_836000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_RouBG_836000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function RouBG_836000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local nearDist = 6.0						--ボウガンで攻撃する距離


	--ボウガンで攻撃する距離なら
	if targetDist >= nearDist then

		--遠距離攻撃
		RouBG_836000Battle_Normal_FarAttack(ai, goal)
			
	--ダガーで攻撃する距離なら
	else
		
		--近距離攻撃
		RouBG_836000Battle_Normal_NearAttack(ai, goal)
	end
end


---------------------------------------------------------
--  遠距離攻撃パターン
---------------------------------------------------------
function RouBG_836000Battle_Normal_FarAttack(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字

	--ボウガンに持ち替える
	CommonNPC_ChangeWepL1(ai, goal)

	--45% その場で発射
	if fate <= 45 then
		RouBG_836000Battle_NormalL_Comb(ai, goal)
		RouBG_836000Battle_Kougeki_Noato(ai, goal)

	--55% 横移動してから発射
	else
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(1,3), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(20,35), true, true ,-1 );
		RouBG_836000Battle_NormalL_Comb(ai, goal)
		RouBG_836000Battle_Kougeki_Noato(ai, goal)
	end

end

---------------------------------------------------------
--  近距離攻撃パターン
---------------------------------------------------------
function RouBG_836000Battle_Normal_NearAttack(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local NormalR_Dist = 1.0					--右手攻撃の適正間合い

	--バックラーに持ち替える
	CommonNPC_ChangeWepL2(ai, goal)

	--40% 走って近づいて攻撃
	if fate <= 40 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		RouBG_836000Battle_NormalR_Comb(ai, goal)
		RouBG_836000Battle_Kougeki_Noato(ai, goal)

	--25% 走って近づいてガードしながら回り込んで攻撃
	elseif fate <= 65 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(90,120), false, true , 4 );
		RouBG_836000Battle_NormalR_Comb(ai, goal)
		RouBG_836000Battle_Kougeki_Noato(ai, goal)
	--35% 距離を取る
	else 
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(5,6), TARGET_ENE_0, ai:GetRandam_Int(6,8), TARGET_ENE_0, false, 4 );
	end
end

---------------------------------------------------------
--  右手コンボ（近距離）
---------------------------------------------------------
function RouBG_836000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用
local NR_fate2 = ai:GetRandam_Int(1,100)		--確率判定用

	--100% 右手攻撃2回
	--60% 右手攻撃4回
	--10% 強攻撃
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);

	if NR_fate <= 60 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	end
	
	if NR_fate2 <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	end
end
	
---------------------------------------------------------
--  左手攻撃（遠距離）
---------------------------------------------------------
function RouBG_836000Battle_NormalL_Comb(ai, goal)

	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Far, 0);

end


	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function RouBG_836000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local BackDist = 2.5							--後退する距離


	--50％　横に移動
	--50％　後ろに移動
	if KN_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, BackDist, TARGET_ENE_0, false, 4 );				
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(3,5), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(45,65), false, true , 4 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(4,6), TARGET_ENE_0, BackDist, TARGET_ENE_0, true, 4 );				

	end
end




---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function RouBG_836000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function RouBG_836000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function RouBG_836000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local NormalR_Dist = 1.0			--右手攻撃の適正間合い
local BackDist = 5.0				--後退する距離

	--空振りしたら攻撃
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 2.0			--空振り追撃する距離
local MissSwingAttPer = 40			--空振り追撃する確率	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
				RouBG_836000Battle_NormalR_Comb(ai, goal)
				RouBG_836000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end	
	end

	--至近距離でダメージ受けたらコンボとみなして後退・旋回（投げ）
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 2.0				--コンボ逃れする距離
local combRunPer = 40				--コンボ逃れする確率
local combRunCountPer = 100			--コンボ逃れの後に攻撃する確率	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
				if fate2 <= 60 then
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(90,120), false, true , 4 );
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
				else
					goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, BackDist, TARGET_ENE_0, false, 4 );				
				end	
				return true;
			end
		end
	end	
	
	
	--ガード崩壊したら攻撃
	if ai:IsInterupt( INTERUPT_GuardBreak ) then
local guardBreakConutDist = 2.0			--ガード崩壊で攻撃する距離
local guardBreakConutPer = 50			--ガード崩壊で攻撃する確率
		if targetDist <= guardBreakConutDist then
			if fate <= guardBreakConutPer then
				goal:ClearSubGoal();
				RouBG_836000Battle_NormalR_Comb(ai, goal)
				RouBG_836000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end
	end
	
	--飛び道具を撃ってきたら最適行動
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 10					--飛び道具使用時に最適行動を取る確率
		if fate <= shootIntPer then
			goal:ClearSubGoal();
			if fate2 <= 50 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			end
			return true;
		end
	end
	
	--敵がガード開始したら後退・旋回をする
	if ai:IsInterupt( INTERUPT_GuardBegin ) then
local GuardBeginMovePer = 70			--ガード開始時に移動をする確率
		if fate <= GuardBeginMovePer then
			goal:ClearSubGoal();
			if fate2 <= 20 then
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, 5.0, TARGET_ENE_0, true, -1 );
			else
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 1.5, TARGET_ENE_0, 2.5, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,55), true, true ,-1 );
			end
			return true
		end
	end
	

return false;
end

