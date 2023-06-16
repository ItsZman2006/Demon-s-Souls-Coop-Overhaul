-----------------------------------------------------------------------------------------------
--	レンドル王子（生存）用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Ouji_807001_Battle, "ouji_807001Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Ouji_807001_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function ouji_807001Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

	--通常行動
	ouji_807001Battle_Kyori(ai, goal)
	
end

---------------------------------------------------------
--  行動（距離判別）
---------------------------------------------------------
function ouji_807001Battle_Kyori(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離を取得
local NormalR_Dist = 2.0						--攻撃の適性間合い
local Middle_Dist = 6.0 						--走って近づく距離

	--走って近づく距離なら
	if targetDist >= Middle_Dist then
	
		--行動（中距離）
		ouji_807001Battle_Middle_Action(ai, goal)

	--攻撃が届かない距離なら
	elseif targetDist >= NormalR_Dist then

		--行動（近距離）
		ouji_807001Battle_Near_Action(ai, goal)

	--攻撃が届く距離なら
	else
	
		--行動（至近距離）
		ouji_807001Battle_TooNear_Action(ai, goal)
	
	end
end

---------------------------------------------------------
--  行動（中距離）
---------------------------------------------------------
function ouji_807001Battle_Middle_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local NormalR_Dist = 2.0					--攻撃の適性間合い

	--40% 何もしない
	if fate <= 20 then
		goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_NONE, 0, 0, 0 );
	
	--60% 旋回して様子見
	elseif fate <= 80 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(3,5), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), ai:GetRandam_Int(0,1), true , 4 );
	
	--20% 走って接近
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, 4 )
	end
	
end


---------------------------------------------------------
--  行動（近距離）
---------------------------------------------------------
function ouji_807001Battle_Near_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その３
local fate4 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その4

local NormalR_Dist = 2.0					--攻撃の適性間合い

	--20% 何もしない
	if fate <= 20 then
		goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_NONE, 0, 0, 0 );

	--60% 旋回して様子見
	elseif fate <= 80 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(3,5), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), ai:GetRandam_Int(0,1), true , 4 );
	
	--10% 走って近づく
	elseif fate <= 90 then
	
		--70% ガードしない
		if fate2 <= 70 then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 )
		
		--30% ガードする
		else
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, 4 )
		end
		
	--10% 歩いて近づく
	else
	
		--40% ガードしない
		if fate3 <= 40 then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 )
		
		--70% ガードする
		else
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, 4 )
		end
	end
	
	if fate <= 40 then
		--50% 攻撃
		ouji_807001Battle_Attack(ai, goal)
		ouji_807001Battle_Kougeki_Noato(ai, goal)
	else
		ouji_807001Battle_Kougeki_Noato(ai, goal)
	end
	
end

---------------------------------------------------------
--  行動（至近距離）
---------------------------------------------------------
function ouji_807001Battle_TooNear_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字

	--20% 攻撃
	if fate <= 20 then
		ouji_807001Battle_Attack(ai, goal)
		ouji_807001Battle_Kougeki_Noato(ai, goal)
	else
		ouji_807001Battle_Kougeki_Noato(ai, goal)
	end

end



---------------------------------------------------------
--  攻撃パターン・通常時
---------------------------------------------------------
function ouji_807001Battle_Attack(ai, goal)

	ouji_807001Battle_NormalR_OneHand_Comb(ai, goal)

end
 

---------------------------------------------------------
--  右手コンボ・片手
---------------------------------------------------------
function ouji_807001Battle_NormalR_OneHand_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用

	--80% 弱
	if NR_fate <= 80 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	
	--20% 弱弱
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	
	end
end

	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function ouji_807001Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local KN_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local KN_fate3 = ai:GetRandam_Int(1,100)		--確率判定用

local BackDist = ai:GetRandam_Int(3,6)			--後退する距離

	--50% 盾を構えて後退・旋回
	--50% ステップ移動（落ちないやつ）

	if KN_fate <= 50 then
	
		if KN_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(3,5), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), ai:GetRandam_Int(0,1), true , 4 );
		else
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(3,5), TARGET_ENE_0, BackDist, TARGET_ENE_0, ai:GetRandam_Int(0,1), 4 );
		end
		
	else
	
		if KN_fate3 <= 40 then
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepB, TARGET_SELF, 0, AI_DIR_TYPE_B, 4.0);
		elseif KN_fate3	<= 70 then
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepL, TARGET_SELF, 0, AI_DIR_TYPE_L, 4.0);
		else
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepR, TARGET_SELF, 0, AI_DIR_TYPE_R, 4.0);
		end			
	end
end




---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function ouji_807001Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function ouji_807001Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function ouji_807001Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local NormalR_Dist = 2.5			--右手攻撃の適正間合い


	--至近距離でダメージ受けたらコンボとみなして後退
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 2.0				--コンボ逃れする距離
local combRunPer = 60				--コンボ逃れする確率
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
				if fate2 <= 40 then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepB, TARGET_SELF, 0, AI_DIR_TYPE_B, 4.0);
				elseif fate2 <= 70 then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepL, TARGET_SELF, 0, AI_DIR_TYPE_L, 4.0);
				else
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepR, TARGET_SELF, 0, AI_DIR_TYPE_R, 4.0);
				end		
				return true;
			end
		end 
	end	
	
	
	--飛び道具を撃ってきたら最適行動
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 50					--飛び道具使用時に最適行動を取る確率
		if fate <= shootIntPer then
			goal:ClearSubGoal();
			if fate2 <= 50 then
				goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepL, TARGET_SELF, 0, AI_DIR_TYPE_L, 4.0);
			else
				goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepR, TARGET_SELF, 0, AI_DIR_TYPE_R, 4.0);
			end	
			return true
		end
	end

return false;
end

