-----------------------------------------------------------------------------------------------
--	魔女用戦闘
--	説明： 
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Majo_821000_Battle, "majo_821000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Majo_821000_Battle, 1 );

---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function majo_821000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２

local NormalR_Dist = 4.0					--右手攻撃の適正間合い


	--極端に近くないなら
	if targetDist >= NormalR_Dist then
		--30％　歩いて近づく
		--70％　旋回して攻撃
		if fate <= 30 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0,  true, -1 );
		else
			goal:AddSubGoal( GOAL_COMMON_SidewayMove, 4.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
			majo_821000Battle_Magic_Comb(ai, goal)
			majo_821000Battle_Kougeki_Noato(ai, goal)
		end
	--極端に近いなら
	else
		--60％　後退
		--40％　旋回攻撃
		if fate2 <= 60 then
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, 2.0, TARGET_ENE_0, true, -1 );
		else
			goal:AddSubGoal( GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
			majo_821000Battle_Magic_Comb2(ai, goal)
		end
	end

end



---------------------------------------------------------
--  魔法コンボ
---------------------------------------------------------
function majo_821000Battle_Magic_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用
local NR_fate2 = ai:GetRandam_Int(1,100)			--確率判定用2

	--遠距離魔法に切り替える
	ai:ChangeEquipMagic(1);
	
	--魔法で攻撃
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_MagicR, TARGET_ENE_0, DIST_Far, 0);

end
	

---------------------------------------------------------
--  魔法コンボ２
---------------------------------------------------------
function majo_821000Battle_Magic_Comb2(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用
local NR_fate2 = ai:GetRandam_Int(1,100)			--確率判定用2

	--近距離魔法に切り替える
	ai:ChangeEquipMagic(0);
	
	--魔法で攻撃
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_MagicR, TARGET_ENE_0, DIST_Far, 0);

end
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function majo_821000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local KN_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local BackDist = 2.5							--後退する距離

	--50％　少し待つ
	--25％　横に移動
	--15％　後ろに移動
	--10％　ステップで後退
	if KN_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_NONE, 0, 0, 0 );
	elseif KN_fate <= 75 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end




---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function majo_821000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function majo_821000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function majo_821000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local BackDist = 5.0				--後退する距離
local NormalR_Dist = 4.0			--右手攻撃の適正間合い

	--空振りしたら後退
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 4.0			--空振り後退する距離
local MissSwingAttPer = 50			--空振り後退する確率	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );	
				return true;
			end
		end	
	end

	--至近距離でダメージ受けたらコンボとみなして後退
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--コンボ逃れする距離
local combRunPer = 40				--コンボ逃れする確率
local combRunCountPer = 5			--コンボ逃れの後に攻撃する確率	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
				if fate2 <= 60 then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
					goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, 2.0, TARGET_ENE_0, true, -1 );
				else
					majo_821000Battle_Magic_Comb2(ai, goal)
					majo_821000Battle_Kougeki_Noato(ai, goal)
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
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			end
			return true
		end
	end
	
	--アイテムを使ったら最適行動
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 30				--アイテム使用時に最適行動を取る確率
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();		
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
			majo_821000Battle_Magic_Comb(ai, goal)
			majo_821000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	
return false;
end

