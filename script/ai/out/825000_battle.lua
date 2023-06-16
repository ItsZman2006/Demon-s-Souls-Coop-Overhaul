-----------------------------------------------------------------------------------------------
--	神の信徒２用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Sinto2_825000_Battle, "sinto2_825000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Sinto2_825000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function sinto2_825000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得

	--自分のHP残りが30%以上なら
	if hprate >= 0.3 then

		--通常行動
		sinto2_825000Battle_Normal_Attack(ai, goal)			

	--自分のHP残りが30%以下なら
	else

		--瀕死行動		
		sinto2_825000Battle_Dying_Attack(ai, goal)

	end
	
end

---------------------------------------------------------
--  通常行動
---------------------------------------------------------
function sinto2_825000Battle_Normal_Attack(ai, goal)	

	--逃げる
	sinto2_825000Battle_Normal(ai, goal)
	sinto2_825000Battle_Kougeki_Noato(ai, goal)
		
end


---------------------------------------------------------
--  瀕死行動
---------------------------------------------------------
function sinto2_825000Battle_Dying_Attack(ai, goal)	

	--MPが30より多ければ
	if selfmp >= 30 then

		--敵から距離をとる
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 4.0, TARGET_ENE_0, 5.0, TARGET_ENE_0, false, -1 );

		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_SELF, DIST_None, 0 );
		sinto2_825000Battle_Kougeki_Noato(ai, goal)
		
	--MPが30より少なければ
	else

		--100% 通常攻撃
		sinto2_825000Battle_Normal(ai, goal)
		sinto2_825000Battle_Kougeki_Noato(ai, goal)
		
	end
		
end

	
---------------------------------------------------------
--  通常行動：逃げ
---------------------------------------------------------
function sinto2_825000Battle_Normal(ai, goal)

local fate = ai:GetRandam_Int(1,100)			--確率判定用
local NormalR_Dist = 2.0 						--攻撃の届く距離

	if fate <= 40 then

		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,50), false, true , -1 );
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		
	--60% 距離を取る
	else 
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(2,4), TARGET_ENE_0, false, -1 );
	end
	
end

---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function sinto2_825000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local BackDist = 2.5							--後退する距離

	--30% 何もしない
	--40% 横に移動
	--30% 後ろに移動してから横移動
	
	if KN_fate <= 30 then
		goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_NONE, 0, 0, 0 );
	elseif KN_fate <= 70 then
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true , -1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(1,3), TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,50), true, true , -1 );
	end
end



---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function sinto2_825000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function sinto2_825000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function sinto2_825000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local BackDist = 5.0									--逃走する距離

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
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
					goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, 2.0, TARGET_ENE_0, true, -1 );
				return true;
			end
		end
	end	

	

	return false;
end

