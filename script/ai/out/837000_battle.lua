------------------------------------------------------------------------------------------------
--	王城三銃士A用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_TroisM_A837000_Battle, "TroisM_A837000Battle");
-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_TroisM_A837000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function TroisM_A837000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local NormalR_Dist = 2.5					--右手攻撃の適正間合い
local FarDist = 25.0

	--ガード開始
	ai:StartGuard(4);

	--遠いなら
	if targetDist >= FarDist then
		--基本戦闘（遠い）
		TroisM_A837000Battle_Normal_Far(ai, goal)
	--近いなら
	elseif targetDist >= NormalR_Dist then
		--基本戦闘（近い）
		TroisM_A837000Battle_Normal_Near(ai, goal)
	--極端に近いなら
	else
		--基本戦闘（極端に近い）
		TroisM_A837000Battle_Normal_TooNear(ai, goal)

	end	
end


--------------------------------------------------------
--  基本戦闘（極端に近い）
---------------------------------------------------------
function TroisM_A837000Battle_Normal_TooNear(ai, goal)

local fate = ai:GetRandam_Int(1,100)	--確率判定用
local Attack_fate = 60 					--攻撃する確率
 
	--60% ガード攻撃
	if fate <= Attack_fate then
		TroisM_A837000Battle_NormalR_Comb(ai, goal)
		TroisM_A837000Battle_Kougeki_Noato(ai, goal)
	--40% ガード
	else
		TroisM_A837000Battle_Kougeki_Noato(ai, goal)
	end

end

--------------------------------------------------------
--  基本戦闘（近い）
---------------------------------------------------------
function TroisM_A837000Battle_Normal_Near(ai, goal)

local NormalR_Dist = 2.5				--右手攻撃の適正間合い

local fate = ai:GetRandam_Int(1,100)	--確率判定用
local Attack_fate = 90					--接近攻撃をする確率

	--90% ガードしながら接近
	if fate <= Attack_fate then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	
	--10% ガードしながら旋回後、接近
	else
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,25), true, true, -1 )
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		
	end
end

--------------------------------------------------------
--  基本戦闘（遠い）
---------------------------------------------------------
function TroisM_A837000Battle_Normal_Far(ai, goal)

local fate = ai:GetRandam_Int(1,100)	--確率判定用
local Attack_fate = 70					--接近する確率

	--70% ガードしながら接近
	if fate <= Attack_fate then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
	
	--30% ガードしながらその場で待機
	else
		goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_ENE_0, 0, 0, 0 );

	end
end
	
---------------------------------------------------------
--  右手コンボ
---------------------------------------------------------
function TroisM_A837000Battle_NormalR_Comb(ai, goal)

local fate = ai:GetRandam_Int(1,100)	--確率判定用
local fate2 = ai:GetRandam_Int(1,100)	--確率判定用2
local Second_Attack_Per = 30 			--追加攻撃する確率

	if fate <= 60 then
	
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);

		if fate2 <= Second_Attack_Per then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		end
	
	else
	
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		
	end
	
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function TroisM_A837000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local BackDist = 3.0							--後退する距離

	--60% ガードしながら横移動
	--40% ガードしながら後退
	if KN_fate <= 60 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true , -1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end




---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function TroisM_A837000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function TroisM_A837000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function TroisM_A837000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local NormalR_Dist = 2.5			--右手攻撃の適正間合い
local BackDist = 3.0				--後退する距離


	--近くで空振りしたら攻撃する
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 2.5			--空振り攻撃する距離
local MissSwingAttPer = 50			--空振り攻撃する確率	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				TroisM_A837000Battle_NormalR_Comb(ai, goal)
				return true;
			end
		end	
	end


	--至近距離でダメージ受けたらコンボとみなして後退
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 2.0				--コンボ逃れする距離
local combRunPer = 45				--コンボ逃れする確率
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
				if fate2 <= 60 then
					goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );
				else
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true , -1 );
				end	
				return true;
			end
		end
	end	
	
	--アイテムを使ったら最適行動
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 20				--アイテム使用時に最適行動を取る確率
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();		
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
			TroisM_A837000Battle_NormalR_Comb(ai, goal)
			TroisM_A837000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	
return false;
end

