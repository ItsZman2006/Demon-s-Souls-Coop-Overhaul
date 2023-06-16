-----------------------------------------------------------------------------------------------
--	心折れた戦士用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Kokoro_805000_Battle, "kokoro_805000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Kokoro_805000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function kokoro_805000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

	kokoro_805000Battle_Normal_Action(ai, goal)

end


---------------------------------------------------------
--  行動・非瀕死時
---------------------------------------------------------
function kokoro_805000Battle_Normal_Action(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離を取得
local farDist = 12.0							--遠いと判断する距離
local nearDist = 4.0							--近いと判断する距離
local NormalR_Dist = 2.5						--右手攻撃の適正間合い


	--遠いなら
	if targetDist >= farDist then

		kokoro_805000Battle_Far_Dist_Action(ai, goal)
	
	--遠くもないが、近くもないなら
	elseif targetDist >= nearDist then
		
		kokoro_805000Battle_Near_Dist_Action(ai, goal)
	
	--近いなら
	elseif targetDist >= NormalR_Dist then
	
		kokoro_805000Battle_NormalR_Dist_Action(ai, goal)

	--極端に近いなら
	else
	
		kokoro_805000Battle_TooNear_Dist_Action(ai, goal)
	
	end
end


---------------------------------------------------------
--  行動・非瀕死時・遠距離
---------------------------------------------------------
function kokoro_805000Battle_Far_Dist_Action(ai, goal)

	--100％　待機
	goal:AddSubGoal( GOAL_COMMON_Wait, 5.0, TARGET_NONE, 0, 0, 0 );

end


---------------------------------------------------------
--  行動・非瀕死時・中距離
---------------------------------------------------------
function kokoro_805000Battle_Near_Dist_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local NormalR_Dist = 2.5			--右手攻撃の適正間合い


	--20％　歩いて近づいて攻撃
	--80％　横移動で様子見
	if fate <= 20 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, 4 );
		kokoro_805000Battle_NormalR_Comb(ai, goal)
		kokoro_805000Battle_Kougeki_Noato(ai, goal)
	else
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true ,4 );
	end

end

---------------------------------------------------------
--  行動・非瀕死時・近距離
---------------------------------------------------------
function kokoro_805000Battle_NormalR_Dist_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local NormalR_Dist = 2.5			--右手攻撃の適正間合い


	--30％　歩いて近づいて攻撃	
	--70％　旋回し様子を窺う
	if fate <= 30 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, 4 );
		kokoro_805000Battle_NormalR_Comb(ai, goal)
		kokoro_805000Battle_Kougeki_Noato(ai, goal)
	else
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,55), true, true ,4 );
	end

end

---------------------------------------------------------
--  行動・非瀕死時・至近距離
---------------------------------------------------------
function kokoro_805000Battle_TooNear_Dist_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２

	--30％　攻撃
	--70％　移動
	if fate <= 30 then
		kokoro_805000Battle_NormalR_Comb(ai, goal)
		kokoro_805000Battle_Kougeki_Noato(ai, goal)
	else
		if fate2 <= 50 then
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(1,3), TARGET_ENE_0, ai:GetRandam_Int(2,4), TARGET_ENE_0, true, 4 );
		else
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, ai:GetRandam_Int(2,4), TARGET_ENE_0, true, 4 );
			goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,55), true, true ,4 );
		end
	end
end


---------------------------------------------------------
--  右手コンボ
---------------------------------------------------------
function kokoro_805000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用
local NR_fate2 = ai:GetRandam_Int(1,100)		--確率判定用

	--右手攻撃２回
	--100% 右手二回
		--10% 右手攻撃
		--10% 右手強攻撃
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	
	if NR_fate <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	end
	
	if NR_fate2 <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	end	

end
	

---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function kokoro_805000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local BackDist = 3.0							--後退する距離

	--60％　横に移動
	--40％　後ろに移動
	if KN_fate <= 60 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true ,4 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, BackDist, TARGET_ENE_0, true, 4 );				
	end
end


---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function kokoro_805000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function kokoro_805000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function kokoro_805000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local NormalR_Dist = 2.5			--右手攻撃の適正間合い

	--空振りしたら攻撃
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 1.0			--空振り追撃する距離
local MissSwingAttPer = 10			--空振り追撃する確率	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				kokoro_805000Battle_NormalR_Comb(ai, goal)
				kokoro_805000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end	
	end

	--至近距離でダメージ受けたらコンボとみなして反撃・後退
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--コンボ逃れする距離
local combRunPer = 40				--コンボ逃れする確率
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
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
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
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
		
return false;
end

