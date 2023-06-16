-----------------------------------------------------------------------------------------------
--	ハーフハンド用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_half815000_Battle, "half815000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_half815000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function half815000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------
local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得
local selfmp = ai:GetMp(TARGET_SELF)					--自分の残りMPを取得

	--HPが2割より多い
	if hprate >= 0.2 then
	
		--通常行動
		half815000Battle_Normal_Act(ai, goal)

	--HPが2割より少ない
	else
		
		--瀕死行動
		half815000Battle_Dying_Act(ai, goal)
		
	end
end

---------------------------------------------------------
--  通常行動
---------------------------------------------------------
function half815000Battle_Normal_Act(ai, goal)

local selfmp = ai:GetMp(TARGET_SELF)			--自分の残りMPを取得

	--リジェネを使えるなら
	if selfmp >= 40 then
		
		--リジェネを使ってタイマーセット
		if ( ai:IsFinishTimer(0) ) then
			half815000Battle_Magic_Comb_First(ai, goal)
			ai:SetTimer(0,180);
			
		--リジェネを使ってから一定時間経過していないなら
		else
			--攻撃
			half815000Battle_Normal_Attack(ai, goal)
			half815000Battle_Kougeki_Noato(ai, goal)
			
		end
	
	--リジェネを使えないなら
	else
	
		--攻撃
		half815000Battle_Normal_Attack(ai, goal)
		half815000Battle_Kougeki_Noato(ai, goal)
	
	end

end	
	
	
---------------------------------------------------------
--  瀕死行動
---------------------------------------------------------
function half815000Battle_Dying_Act(ai, goal)

local selfmp = ai:GetMp(TARGET_SELF)			--自分の残りMPを取得

	--自分のMPが60より多ければ
	if selfmp >= 60 then
	
		--魔法コンボ（回復）
		half815000Battle_Magic_Comb_Cure(ai, goal)

	--自分のMPが60以下なら
	else
		
		--攻撃：剣
		half815000Battle_Weapon(ai, goal)
		half815000Battle_Kougeki_Noato(ai, goal)

	end
end	


--[[-------------------------------------------------------
--  攻撃（魔法を出すか武器攻撃を出すか距離で判別）
---------------------------------------------------------]]
function half815000Battle_Normal_Attack(ai, goal)	

local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離を取得
local magicDist = 4.0							--魔法で攻撃する距離
	
	--魔法で攻撃する距離なら
	if targetDist >= magicDist then
		--魔法で攻撃
		half815000Battle_Magic(ai, goal)
		
	--武器で攻撃する距離なら
	else
		--武器で攻撃
		half815000Battle_Weapon(ai, goal)
	end	
end
	
	
--[[-------------------------------------------------------
--  攻撃：魔法（自分のMPの現在値を見て魔法を切り替える）
---------------------------------------------------------]]
function half815000Battle_Magic(ai, goal)

local selfmp = ai:GetMp(TARGET_SELF)			--自分の残りMPを取得
	
	--自分のMPが20より多ければ
	if selfmp >= 20 then
	
		--魔法１と２をランダムに切り替える
		ai:ChangeEquipMagic(ai:GetRandam_Int(0,1));
		half815000Battle_Magic_Comb(ai, goal)

	--自分のMPが2より多ければ
	elseif selfmp >= 2 then
		
		--魔法１に切り替える
		ai:ChangeEquipMagic(0);
		half815000Battle_Magic_Comb(ai, goal)
	
	--自分のMPが2以下なら
	else
		
		half815000Battle_Weapon(ai, goal)
		half815000Battle_Kougeki_Noato(ai, goal)

	end
	
end

---------------------------------------------------------
--  攻撃：剣
---------------------------------------------------------
function half815000Battle_Weapon(ai, goal)

local fate = ai:GetRandam_Int(1,100)			--確率判定用
local NormalR_Dist = 2.5						--右手攻撃の適正間合い	

	--30% 歩いて近づいて攻撃
	if fate <= 30 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		half815000Battle_NormalR_Comb(ai, goal)
		half815000Battle_Kougeki_Noato(ai, goal)

	--30% 走って近づいてガードしながら回り込んで攻撃
	elseif fate <= 60 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), false, true , -1 );
		half815000Battle_NormalR_Comb(ai, goal)
		half815000Battle_Kougeki_Noato(ai, goal)

	--20% 近接魔法を使う
	elseif fate <= 80 then
		
		--魔法3に切り替える
		half815000Battle_Magic_Comb_Near(ai, goal)
	
	--20% 距離を取る
	else 
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, ai:GetRandam_Int(6,8), TARGET_ENE_0, false, -1 );
	end
	
end


---------------------------------------------------------
--  武器コンボ（近距離）
---------------------------------------------------------
function half815000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用
local NR_fate2 = ai:GetRandam_Int(1,100)		--確率判定用

	--100% 右手攻撃2回
	--60% 右手攻撃4回
	--10% 強攻撃

	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
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
--  魔法コンボ
---------------------------------------------------------
function half815000Battle_Magic_Comb(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離を取得
local magicDist = 7.0							--魔法適性距離
local index_magic = ai:GetEquipMagicIndex();	--現在装備している魔法の種類を取得

	--装備している魔法がマシンガンなら
--	if ( 0 == index_magic ) then
		
		--魔法コンボ（マシンガン用）
--		half815000Battle_Magic_Comb_MACHINEGUN(ai, goal)
		
	--それ以外なら
--	else
	
		--敵が魔法適性距離より遠くにいる
		if targetDist >= magicDist then
		
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, magicDist, TARGET_ENE_0, true, -1 );
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
			half815000Battle_Kougeki_Noato(ai, goal)
			
		else
		
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
			half815000Battle_Kougeki_Noato(ai, goal)
		end
--	end
end


---------------------------------------------------------
--  魔法コンボ（マシンガン用）
---------------------------------------------------------
function half815000Battle_Magic_Comb_MACHINEGUN(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離を取得
local magicDist = 7.0							--魔法適性距離
local selfmp = ai:GetMp(TARGET_SELF)			--自分の残りMPを取得

	--残りMPが10以上なら連射
	if selfmp >= 10 then
	
		--敵が魔法適性距離より遠くにいる
		if targetDist >= magicDist then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, magicDist, TARGET_ENE_0, true, -1 );
		end
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
			half815000Battle_Kougeki_Noato(ai, goal)
	else
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
		half815000Battle_Kougeki_Noato(ai, goal)
	end
end

---------------------------------------------------------
--  魔法コンボ（近接）
---------------------------------------------------------
function half815000Battle_Magic_Comb_Near(ai, goal)

local selfmp = ai:GetMp(TARGET_SELF)			--自分の残りMPを取得
local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離を取得
local magicDist = 1.5							--魔法適性距離

	--魔法３を使える
	if selfmp >= 10 then 
 
		--魔法３に切り替える
		ai:ChangeEquipMagic(2);	

		--敵が魔法適性距離より遠くにいる
		if targetDist >= magicDist then
		
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, magicDist, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
			half815000Battle_Kougeki_Noato(ai, goal)
			
		else
		
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
			half815000Battle_Kougeki_Noato(ai, goal)
		end

	--魔法３を使えない
	else
		
		--武器コンボ
		half815000Battle_NormalR_Comb(ai, goal)
	end
end

---------------------------------------------------------
--  魔法コンボ（回復）
---------------------------------------------------------
function half815000Battle_Magic_Comb_Cure(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離を取得
local magicDist = 5.0							--魔法適性距離

	--魔法４（大回復）に切り替える
	ai:ChangeEquipMagic(3);

	--敵が魔法適性距離より遠くにいる
	if targetDist >= magicDist then
	
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
		half815000Battle_Kougeki_Noato(ai, goal)

	else
	
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, 6.0, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_Far, 0);
		half815000Battle_Kougeki_Noato(ai, goal)
		
	end

end

---------------------------------------------------------
--  魔法コンボ（準備）
---------------------------------------------------------
function half815000Battle_Magic_Comb_First(ai, goal)

	--距離を取る
	half815000Battle_Kougeki_Noato(ai, goal)
	
	--魔法５に切り替える
	ai:ChangeEquipMagic(4);
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_None, 0);

end

---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function half815000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local BackDist = ai:GetRandam_Int(4,7)							--後退する距離

	--50％　横に移動
	--50％　後ろに移動
	if KN_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );				
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(3,5), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(45,65), false, true , -1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(4,6), TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );				

	end
end



---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function half815000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function half815000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function half815000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

	--近くで空振りしたら攻撃する
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 4.0			--空振り逃走する距離
local MissSwingAttPer = 50			--空振り逃走する確率	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				half815000Battle_Weapon(ai, goal)
				half815000Battle_Kougeki_Noato(ai, goal)
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
				half815000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end
	end	

	--飛び道具を撃ってきたら最適行動
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 50					--飛び道具使用時に最適行動を取る確率
		if fate <= shootIntPer then
			goal:ClearSubGoal();
			half815000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end	
	

	return false;
end

