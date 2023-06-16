-----------------------------------------------------------------------------------------------
--	ロガーン用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Rogan_817000_Battle, "rogan_817000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Rogan_817000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function rogan_817000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字

	--30% 武器で攻撃
	if fate <= 30 then
		
		--武器攻撃
		rogan_817000Battle_Weapon_Attack(ai, goal)
	
	--70% 魔法で攻撃
	else
		
		--魔法攻撃
		rogan_817000Battle_Magic_Attack(ai, goal)

	end
	
end

---------------------------------------------------------
--  武器攻撃
---------------------------------------------------------
function rogan_817000Battle_Weapon_Attack(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２

local NormalR_Dist = 1.5					--右手攻撃の適正間合い

	--極端に近くないなら
	if targetDist >= NormalR_Dist then
		--60％　歩いて近づく
		--40％　歩いて近づいて旋回して攻撃
		if fate <= 60 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1);
		else
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1);
			goal:AddSubGoal( GOAL_COMMON_SidewayMove, 4.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
			rogan_817000Battle_NormalR_Comb(ai, goal)
			rogan_817000Battle_Kougeki_Noato(ai, goal)
		end
	--極端に近いなら
	else
		--40％　後退
		--60％　旋回攻撃
		if fate2 <= 40 then
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, 2.0, TARGET_ENE_0, true, -1 );
		else
			goal:AddSubGoal( GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
			rogan_817000Battle_NormalR_Comb(ai, goal)
		end
	end
end

---------------------------------------------------------
--  魔法攻撃
---------------------------------------------------------
function rogan_817000Battle_Magic_Attack(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２

local NormalR_Dist = 4.0					--右手攻撃の適正間合い

local selfmp = ai:GetMp(TARGET_SELF)		--自分の残りMPを取得

	--自分の残りMPが50より多ければ魔法攻撃
	if selfmp >= 50 then		

		--極端に近くないなら
		if targetDist >= NormalR_Dist then
			--30％　歩いて近づく
			--70％　旋回して攻撃
			if fate <= 10 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1);
			elseif fate <= 40 then
				goal:AddSubGoal( GOAL_COMMON_SidewayMove, 4.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
				rogan_817000Battle_Magic_Comb(ai, goal)
				rogan_817000Battle_Kougeki_Noato(ai, goal)
			else
				rogan_817000Battle_Magic_Comb(ai, goal)
				rogan_817000Battle_Kougeki_Noato(ai, goal)
			end
		--極端に近いなら
		else
			--60％　後退
			--40％　旋回攻撃
			if fate2 <= 60 then
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, 2.0, TARGET_ENE_0, true, -1 );
			else
				goal:AddSubGoal( GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
				rogan_817000Battle_Magic_Comb(ai, goal)
			end
		end
		
	--自分の残りMPが50より少なければアイテムを使用してMP回復
	else
		goal:AddSubGoal( GOAL_COMMON_UseItem, 10.0, 0 );
	end
end

---------------------------------------------------------
--  魔法コンボ
---------------------------------------------------------
function rogan_817000Battle_Magic_Comb(ai, goal)

	--触媒を持っていなければ触媒に持ち替える
	CommonNPC_ChangeWepR1(ai, goal)

	--魔法をランダムに切り替える
	ai:ChangeEquipMagic(ai:GetRandam_Int(0,3));
	
	--魔法で攻撃
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_MagicR, TARGET_ENE_0, DIST_Middle, 0);

end
	
	
	
---------------------------------------------------------
--  右手コンボ
---------------------------------------------------------
function rogan_817000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用

	--武器を持っていなければ持ち替える
	CommonNPC_ChangeWepR2(ai, goal)

	--70% 左右連携攻撃
	--30% 左右連携後大攻撃
	if NR_fate <= 20 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);

	elseif NR_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);

	elseif NR_fate <= 80 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function rogan_817000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local KN_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local BackDist = 4.0							--後退する距離

	--20％　少し待つ
	--55％　横に移動
	--25％　後ろに移動
	if KN_fate <= 20 then
		goal:AddSubGoal( GOAL_COMMON_Wait, 1.0, TARGET_NONE, 0, 0, 0 );
	elseif KN_fate <= 75 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end




---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function rogan_817000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function rogan_817000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function rogan_817000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local NormalR_Dist = 4.0			--右手攻撃の適正間合い


	--至近距離でダメージ受けたらコンボとみなして後退
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--コンボ逃れする距離
local combRunPer = 40				--コンボ逃れする確率
local combRunCountPer = 5			--コンボ逃れの後に攻撃する確率	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, 2.0, TARGET_ENE_0, false, -1 );
				return true;
			end
		end
	end	
	
	
	--アイテムを使ったら最適行動
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 50				--アイテム使用時に最適行動を取る確率
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();		
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
			rogan_817000Battle_Magic_Attack(ai, goal)
			rogan_817000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	
return false;
end

