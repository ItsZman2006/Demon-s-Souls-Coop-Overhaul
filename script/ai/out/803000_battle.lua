------------------------------------------------------------------------------------------------
--	王城三銃士C専用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_NpcKISI_C803000_Battle, "npcKISI_C803000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_NpcKISI_C803000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function npcKISI_C803000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得
local selfmp = ai:GetMp(TARGET_SELF)					--自分の残りMPを取得

	--自分のHP残りが20%以上なら
	if hprate >= 0.2 then

		--基本戦闘
		npcKISI_C803000Battle_Normal_Attack(ai, goal)			

	else

		--MPが最大値であれば
		if selfmp >= 100 then 		
		
			--魔法攻撃
			npcKISI_C803000Battle_Magic(ai, goal)

		--MPが最大値でなければ
		else
		
			--基本攻撃
			npcKISI_C803000Battle_Normal_Attack(ai, goal)	
		end
	end
	
end

---------------------------------------------------------
--  基本戦闘
---------------------------------------------------------
function npcKISI_C803000Battle_Normal_Attack(ai, goal)	

local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離を取得
local nearDist = 4.0							--弓で攻撃する距離
	
	
	--弓で攻撃する距離なら
	if targetDist >= nearDist then
		--弓で攻撃
		npcKISI_C803000Battle_Bow(ai, goal)

	--剣で攻撃する距離なら
	else
		--剣で攻撃
		npcKISI_C803000Battle_Sword(ai, goal)
	end	
end
	
---------------------------------------------------------
--  攻撃：弓
---------------------------------------------------------
function npcKISI_C803000Battle_Bow(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)	--確率判定用
local fate2 = ai:GetRandam_Int(1,100)	--確率判定用
local fate3 = ai:GetRandam_Int(1,100)	--確率判定用


	--弓を持っていなければ弓に持ち替える
	CommonNPC_ChangeWepR1(ai, goal)

	--敵ターゲットが7M以内のとき
	if targetDist <= 7.0 then
	
		--50% その場で射撃後、走って後退
		if fate <= 50 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Far, 0);
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 10.0, TARGET_ENE_0, false, -1 );
		
		--50% その場で射撃後、走って旋回
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Far, 0);
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(20,45), false, true , -1 );
		end
		
	--敵ターゲットが12M以内のとき
	elseif targetDist <= 12.0 then

		--50% その場で射撃後、歩いて後退
		if fate2 <= 50 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Far, 0);
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 5.0, TARGET_ENE_0, true, -1 );
		
		--50% その場で射撃後、歩いて旋回
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Far, 0);
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(20,45), true, true , -1 );
		end
		
	--敵ターゲットが20M以内のとき
	else		
		--50% その場で射撃
		if fate3 <= 50 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Far, 0);
		
		--50% 旋回して射撃
		else
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(20,45), false, true , -1 );
			goal:AddSubGoal( GOAL_COMMON_Attack, 5.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Far, 0);
		end
	end
end

---------------------------------------------------------
--  攻撃：剣
---------------------------------------------------------
function npcKISI_C803000Battle_Sword(ai, goal)

local fate = ai:GetRandam_Int(1,100)			--確率判定用
local NormalR_Dist = 2.5						--右手攻撃の適正間合い	

	--キリジと盾を持っていなければ持ち替える
	CommonNPC_ChangeWepR2(ai, goal)
	CommonNPC_ChangeWepL1(ai, goal)

	--40% 歩いて近づいて攻撃
	if fate <= 40 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		npcKISI_C803000Battle_NormalR_Comb(ai, goal)

	--30% 走って近づいてガードしながら回り込んで攻撃
	elseif fate <= 70 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(90,120), false, true , 4 );
		npcKISI_C803000Battle_NormalR_Comb(ai, goal)

	--30% 距離を取る
	else 
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 4.0, TARGET_ENE_0, 5.0, TARGET_ENE_0, false, 4 );
	end
	
end


---------------------------------------------------------
--  攻撃：魔法
---------------------------------------------------------
function npcKISI_C803000Battle_Magic(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離を取得
local NormalR_Dist = 2.5						--右手攻撃の適正間合い	

	--触媒に持ち替える
	CommonNPC_ChangeWepL2(ai, goal)			

	--4M以上離れていたら走って近づいて魔法
	if targetDist >= 4.0 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 )
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_None, 0);
		npcKISI_C803000Battle_Kougeki_Noato(ai, goal)

	--4M以内にいればその場で魔法
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_None, 0);
		npcKISI_C803000Battle_Kougeki_Noato(ai, goal)
		
	end

end	


---------------------------------------------------------
--  右手コンボ（近距離）
---------------------------------------------------------
function npcKISI_C803000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用
local NR_fate2 = ai:GetRandam_Int(1,100)		--確率判定用

	--100% 右手攻撃2回
	--60% 右手攻撃4回
	--10% 強攻撃
	
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);

	if NR_fate <= 60 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	end
	
	if NR_fate2 <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	end
end
	

---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function npcKISI_C803000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local BackDist = 2.5							--後退する距離

	--盾を持っていなければ持ち替える
	CommonNPC_ChangeWepL1(ai, goal)

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
function npcKISI_C803000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function npcKISI_C803000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function npcKISI_C803000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

	--近くで空振りしたら一目散に逃げる
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 1.0			--空振り逃走する距離
local MissSwingAttPer = 50			--空振り逃走する確率	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 10.0, TARGET_ENE_0, false, -1 );
				return true;
			end
		end	
	end


	--至近距離でダメージ受けたらコンボとみなして後退
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 2.0				--コンボ逃れする距離
local combRunPer = 40				--コンボ逃れする確率
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
				if fate2 <= 60 then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
				elseif fate2 <= 80 then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
				else
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
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
	

	return false;
end

