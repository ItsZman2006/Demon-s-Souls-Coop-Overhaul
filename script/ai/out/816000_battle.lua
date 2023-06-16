--[[*******************************************************************************************
	ガル・ヴィンランド用戦闘
	説明：

	パラメータ0  なし
	パラメータ1  なし
	パラメータ2  なし
	パラメータ3　なし
	
	●ai:SetNumber()の使用状況。
		０：0で前衛迎撃モード、1で退却モード、2でリープラ護衛モード。
		１：0でリーブラ前に移動、1でリーブラ前でガード
		２：敵が攻撃できない範囲にいたとき0で巣に帰る、1でインタラプトしない
		３：敵が攻撃できる範囲にいたとき0でリプランニングして近づいて攻撃、1でインタラプトしない
		
	●ai:SetTimer()の使用状況。
	　　
*********************************************************************************************]]


--[[===========================================================
	●メインゴール。
=============================================================]]
REGISTER_GOAL(GOAL_GalV_816000_Battle_Main , "GalV_816000Battle_Main");
REGISTER_GOAL_NO_UPDATE( GOAL_GalV_816000_Battle_Main, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_GalV_816000_Battle_Main, true);

function GalV_816000Battle_Main_Activate(ai, goal)
	
	local life	= goal:GetLife();
	local mode 	= ai:GetNumber(0);

	if 		(mode==1) then	goal:AddSubGoal( GOAL_GalV_816000_Battle_Retreat, 	life);
	elseif 	(mode==2) then	goal:AddSubGoal( GOAL_GalV_816000_Battle_Guard, 	life);
	else					goal:AddSubGoal( GOAL_GalV_816000_Battle_Forward, 	life);
	end
	
end

function GalV_816000Battle_Main_Update(ai, goal) return GOAL_RESULT_Continue; end
function GalV_816000Battle_Main_Terminate(ai, goal) end
function GalV_816000Battle_Main_Interupt(ai, goal) return false; end









--[[===========================================================
	●非戦闘ゴール
=============================================================]]
REGISTER_GOAL(GOAL_GalV_816000_NonBattle, "GalV_816000NonBattle");
REGISTER_GOAL_NO_UPDATE(GOAL_GalV_816000_NonBattle, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_GalV_816000_NonBattle, true);

function GalV_816000NonBattle_Activate(ai, goal)

	local life			= goal:GetLife();
	local distInitPos 	= ai:GetDist(TARGET_SELF);

	if ( distInitPos < 1 ) then
		--初期位置に近い場合は、その場で待つ。
		goal:AddSubGoal( GOAL_COMMON_Stay, 	life);
	else
		--そうで無い場合は、初期位置に戻る。
		goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, life, POINT_INITIAL, AI_DIR_TYPE_CENTER, 0.5, TARGET_SELF, -1);
	end
	
end

function GalV_816000NonBattle_Update(ai, goal) return GOAL_RESULT_Continue; end
function GalV_816000NonBattle_Terminate(ai, goal) end
function GalV_816000NonBattle_Interupt(ai, goal) return false; end



--[[===========================================================
	●前衛迎撃ゴール。
=============================================================]]
REGISTER_GOAL(GOAL_GalV_816000_Battle_Forward , "GalV_816000Battle_Fwd");
REGISTER_GOAL_NO_UPDATE( GOAL_GalV_816000_Battle_Forward, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_GalV_816000_Battle_Forward, true);

function GalV_816000Battle_Fwd_Activate(ai, goal)
	goal:AddSubGoal( GOAL_GalV_816000_Battle, goal:GetLife(), 0);
end

function GalV_816000Battle_Fwd_Update(ai, goal) return GOAL_RESULT_Continue; end
function GalV_816000Battle_Fwd_Terminate(ai, goal) end
function GalV_816000Battle_Fwd_Interupt(ai, goal)	return false; end



--[[===========================================================
	●退却ゴール。
=============================================================]]
REGISTER_GOAL(GOAL_GalV_816000_Battle_Retreat , "GalV_816000Battle_Retreat");
REGISTER_GOAL_NO_UPDATE( GOAL_GalV_816000_Battle_Retreat, true);
--REGISTER_GOAL_NO_INTERUPT( GOAL_GalV_816000_Battle_Retreat, true);


function GalV_816000Battle_Retreat_Activate(ai, goal) 
local Life = goal:GetLife();
local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

	--リーブラ前の領域を監視
	ai:AddObserveRegion( 0, TARGET_SELF, 2505 );

	--リーブラ前に巣を移していなければルート移動
	if (false==ai:IsInsideObserveRegion(0)) then
		if targetDist <= 1.5 then
			if (goal:IsFinishTimer(3)) then
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
				goal:SetTimer(3,6.0);
			end
		end
	goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 10.0, POINT_MOVE_POINT, AI_DIR_TYPE_CENTER, 1, TARGET_ENE_0, false);
	end
end
	
---------------------------------------------------------
--  割り込み攻撃
---------------------------------------------------------
function GalV_816000Battle_Retreat_Attack(ai, goal)
local fate = ai:GetRandam_Int(1,100)

	--吹き飛ばす必要があるので片手小攻撃をメインで使用
	if fate <= 80 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	end

end

function GalV_816000Battle_Retreat_Update(ai, goal) return GOAL_RESULT_Continue; end
function GalV_816000Battle_Retreat_Terminate(ai, goal) 
	--ちゃんと目的地に到着できたら、リーブラ護衛モードに変更
	if (ai:IsInsideObserveRegion(0)) then
--	if (GOAL_RESULT_Success==goal:GetLastSubGoalResult()) then
		if ( 1==ai:GetNumber(0) ) then
			ai:SetNumber(0, 2);
		end
	end
end

-----------------------------------------------------------
-- 割り込み
-----------------------------------------------------------
function GalV_816000Battle_Retreat_Interupt(ai, goal) 

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local NormalR_Dist = 2.5			--右手攻撃の適正間合い
local hprate = ai:GetHpRate( TARGET_SELF )	--自分のHPの割合を取得

	--至近距離で攻撃行動を発見したら最適行動
	if ai:IsInterupt( INTERUPT_FindAttack ) then
local superStepDist = 1.0			--超反応する距離
local superStepPer = 100			--超反応する確率
		if targetDist <= superStepDist then
			if fate <= superStepPer then
				goal:ClearSubGoal();
				if fate2 <= 80 then
					goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Parry, TARGET_ENE_0, DIST_None, 0);
					goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
				else
					GalV_816000Battle_Retreat_Attack(ai, goal)
				end
				return true;
			end
		end
	end

	--移動中に飛び道具を撃ったら最適行動
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 100					--飛び道具使用時に最適行動を取る確率
local shootDist = 1.0					--飛び道具に反応する距離
	if fate <= shootIntPer then
			goal:ClearSubGoal();
			GalV_816000Battle_Retreat_Attack(ai, goal)
			return true;
		end
	end

	return false;
end


--[[===========================================================
	●リーブラ護衛ゴール。
=============================================================]]
REGISTER_GOAL(GOAL_GalV_816000_Battle_Guard, "GalV_816000Battle_Guard");
REGISTER_GOAL_NO_UPDATE( GOAL_GalV_816000_Battle_Guard, true);

function GalV_816000Battle_Guard_Activate(ai, goal) 

	--領域監視開始。
	ai:AddObserveRegion( 1, TARGET_ENE_0, 2504	);
	ai:AddObserveRegion( 2, TARGET_ENE_0, 2506	);

	goal:AddSubGoal( GOAL_GalV_816000_Battle, goal:GetLife(), 1);
end


---------------------------------------------------------
--  遠距離攻撃（対象：リーブラ用）
---------------------------------------------------------
function GalV_816000Battle_Guard_Interupt_Action(ai, goal)

local selfmp = ai:GetMp(TARGET_SELF)			--自分の残りMPを取得
local fate = ai:GetRandam_Int(1,100)			--確率判定用

	ai:StartGuard(4);

	--自分が巣に戻ってから動いていない
	if ( 0 == ai:GetNumber(1) ) then
		--巣に戻ってフラグを立てる
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 100.0, POINT_INITIAL, 0.5, TARGET_ENE_0, true, -1 )
		ai:SetNumber(1,1)
	end
	
	--片手持ちに切り替え
	CommonNPC_SwitchOneHandMode(ai, goal)
	
	--盾でガード
	goal:AddSubGoal( GOAL_COMMON_Wait, 9999.0, TARGET_ENE_0, 0, 0, 0 );
	
end

function GalV_816000Battle_Guard_Update(ai, goal) return GOAL_RESULT_Continue; end
function GalV_816000Battle_Guard_Terminate(ai, goal) end
function GalV_816000Battle_Guard_Interupt(ai, goal) 

	if (ai:IsInterupt(INTERUPT_Inside_ObserveArea)) then
		--もし侵入不可領域より先に敵が居たら、
		--巣に帰ってガード
		if (ai:IsInsideObserveRegion(1)) then
			if ( 0 == ai:GetNumber(2) ) then
				if ( goal:IsFinishTimer(1) ) then
					goal:SetTimer(1,4.0);
					goal:ClearSubGoal();
					GalV_816000Battle_Guard_Interupt_Action(ai, goal)
					ai:SetNumber(2,1);
					ai:SetNumber(3,0);
					return true;
				end
			end
		end
	end

	if (ai:IsInterupt(INTERUPT_Inside_ObserveArea)) then
		--もし攻撃可能な場所に敵が居たら、
		--リプランニング
		if (ai:IsInsideObserveRegion(2)) then
			if ( 0 == ai:GetNumber(3) ) then
				if ( goal:IsFinishTimer(2) ) then
					goal:SetTimer(2,4.0);
					goal:ClearSubGoal();
					ai:Replaning();
					ai:SetNumber(3,1);
					ai:SetNumber(2,0);
					return true;
				end
			end
		end
	end	

	return false; 
	
end



--[[===========================================================
	●通常戦闘ゴール。
=============================================================]]
REGISTER_GOAL(GOAL_GalV_816000_Battle , "GalV_816000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_GalV_816000_Battle, true);

--[[*****************************************************
	ゴール起動
*******************************************************]]
function GalV_816000Battle_Activate(ai, goal)

--[[領域監視]]

	ai:AddObserveRegion( 1, TARGET_ENE_0, 2504	);

--[[領域内にターゲット0がいなければフラグをおろす]]

	if (ai:IsInsideObserveRegion(1)) then
		ai:SetNumber(1,1) else
		ai:SetNumber(1,0);
		ai:EndGuard();
		ai:Replaning ();
	end

--[[現在の守備位置を判断して行動を変更する]]	
	
local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得

	--自分のHPが残り2割以上
	if hprate >= 0.2 then		

		--リーブラを護っている
		if (1==goal:GetParam(0) ) then

			--リーブラ前行動
			GalV_816000Battle_Back_Attack(ai, goal)
			
		--前衛にいる
		else

			--前衛行動	
			GalV_816000Battle_Front_Attack(ai, goal)
		
		end

	--自分の残りHPが2割以下
	else

		--リーブラを護っている
		if (1==goal:GetParam(0) ) then

			--瀕死行動・リーブラ前
			GalV_816000Battle_Dying_Attack(ai, goal)
			
		--前衛にいる
		else

			--瀕死行動・前衛	
			GalV_816000Battle_Dying_Attack_Front(ai, goal)

		end
	
	end	
	
end

---------------------------------------------------------
--  リーブラ前行動
---------------------------------------------------------
function GalV_816000Battle_Back_Attack(ai, goal)

local fate = ai:GetRandam_Int(1,100)
local fate2 = ai:GetRandam_Int(1,100)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local nearDist = 4.0						--近いと判断する距離
local NormalR_Dist = 2.5			--右手攻撃の適正間合い

local selfmp = ai:GetMp(TARGET_SELF)			--自分の残りMPを取得

	--MPが100以上なら
	if selfmp >= 100 then
		--ターゲットとの距離が4M以上あれば
		if targetDist >= nearDist then
			--85% リーブラ前行動
			--15% 魔法攻撃
			if fate <= 85 then
				GalV_816000Battle_Back_NormalATK(ai, goal)
			else
				GalV_816000Battle_Magic(ai, goal)
			end
		else
			GalV_816000Battle_Back_NormalATK(ai, goal)
		end
			
	--MPが100以下なら
	else
		--100% 通常攻撃
		GalV_816000Battle_Back_NormalATK(ai, goal)

	end
end


---------------------------------------------------------
--  前衛行動
---------------------------------------------------------
function GalV_816000Battle_Front_Attack(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local nearDist = 3.0						--近いと判断する距離
local NormalR_Dist = 2.5			--右手攻撃の適正間合い


	--遠くもないが、近くもないなら
	if targetDist >= nearDist then
		--100％　ガード
		GalV_816000Battle_Normal_Guard(ai, goal)

	--近いなら
	elseif targetDist >= NormalR_Dist then
		
		GalV_816000Battle_NearATK(ai, goal)
	
	--極端に近いなら
	else

		GalV_816000Battle_TooNearATK(ai, goal)
	
	end

end

---------------------------------------------------------
--  瀕死行動・リーブラ前
---------------------------------------------------------
function GalV_816000Battle_Dying_Attack(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local selfmp = ai:GetMp(TARGET_SELF)			--自分の残りMPを取得


	--MPが60より多ければ
	if selfmp >= 60 then

		--PCが6メートル以上離れていれば
		if targetDist >= 6.0 then
			--魔法を大回復に切り替える
			ai:ChangeEquipMagic(1);
			
			--片手持ちに切り替え
			CommonNPC_SwitchOneHandMode(ai, goal)
			
			--タリスマンを持っていなければ切り替える
			CommonNPC_ChangeWepR2(ai, goal)

			--100% 大回復
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_MagicR, TARGET_SELF, DIST_None, 0 );
		
		--PCが6メートル以上離れていなければ
		else
		
			--リーブラ前攻撃
			GalV_816000Battle_Back_NormalATK(ai, goal)
			
		end
		
	--MPが60より少なければ
	else

		--100% リーブラ前攻撃
		GalV_816000Battle_Back_NormalATK(ai, goal)
		
	end

end


---------------------------------------------------------
--  瀕死行動・前衛
---------------------------------------------------------
function GalV_816000Battle_Dying_Attack_Front(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local selfmp = ai:GetMp(TARGET_SELF)			--自分の残りMPを取得


	--MPが60より多ければ
	if selfmp >= 60 then

		--PCが6メートル以上離れていれば
		if targetDist >= 6.0 then
			--魔法を大回復に切り替える
			ai:ChangeEquipMagic(1);
			
			--片手持ちに切り替え
			CommonNPC_SwitchOneHandMode(ai, goal)
			
			--タリスマンを持っていなければ切り替える
			CommonNPC_ChangeWepR2(ai, goal)

			--100% 大回復
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_MagicR, TARGET_SELF, DIST_None, 0 );
		
		--PCが6メートル以上離れていなければ
		else
		
			--前衛行動
			GalV_816000Battle_Front_Attack(ai, goal)
			
		end
		
	--MPが60より少なければ
	else

		--100% 前衛行動
		GalV_816000Battle_Front_Attack(ai, goal)
		
	end

end


---------------------------------------------------------
--  前衛攻撃・近いなら
---------------------------------------------------------
function GalV_816000Battle_NearATK(ai, goal)

	GalV_816000Battle_NormalR_Comb(ai, goal)
	GalV_816000Battle_Kougeki_Noato(ai, goal)
end


---------------------------------------------------------
--  前衛攻撃・極端に近いなら
---------------------------------------------------------
function GalV_816000Battle_TooNearATK(ai, goal)

local fate = ai:GetRandam_Int(1,100)

	--70％　攻撃
	--30％　プッシュ
	if fate <= 70 then
		GalV_816000Battle_NormalR_Comb(ai, goal)
		GalV_816000Battle_Kougeki_Noato(ai, goal)
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_PushR, TARGET_ENE_0, DIST_None, 0);
		GalV_816000Battle_Kougeki_Noato(ai, goal)
	end

end


---------------------------------------------------------
--  リーブラ前攻撃・通常
---------------------------------------------------------
function GalV_816000Battle_Back_NormalATK(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local nearDist = 4.0				--近いと判断する距離
local NormalR_Dist = 2.5			--右手攻撃の適正間合い

local fate = ai:GetRandam_Int(1,100)		--確率判定用1
local fate2 = ai:GetRandam_Int(1,100)		--確率判定用2
local fate3 = ai:GetRandam_Int(1,100)		--確率判定用3


	
	--遠くもないが、近くもないなら
	if targetDist >= nearDist then
		--100％　走って近づいて攻撃
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, 4 );

		if fate <= 50 then
			GalV_816000Battle_NormalR_Comb(ai, goal)
			GalV_816000Battle_Kougeki_Noato2(ai, goal)
		
		else
			GalV_816000Battle_NormalR_Comb2(ai, goal)
			GalV_816000Battle_Kougeki_Noato2(ai, goal)
		end
		
	--近いなら
	elseif targetDist >= NormalR_Dist then
	
		if fate2 <= 40 then
			GalV_816000Battle_NormalR_Comb(ai, goal)
			GalV_816000Battle_Kougeki_Noato2(ai, goal)
		
		else
			GalV_816000Battle_NormalR_Comb2(ai, goal)
			GalV_816000Battle_Kougeki_Noato2(ai, goal)
		
		end
	--極端に近いなら
	else
		
		if fate3 <= 30 then
			GalV_816000Battle_NormalR_Comb(ai, goal)
			GalV_816000Battle_Kougeki_Noato2(ai, goal)
	
		else
			GalV_816000Battle_NormalR_Comb2(ai, goal)
			GalV_816000Battle_Kougeki_Noato2(ai, goal)
		end
	
	end


end

---------------------------------------------------------
--  右手コンボ
---------------------------------------------------------
function GalV_816000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用

	--武器に持ち替える
	CommonNPC_ChangeWepR1(ai, goal)

	--片手持ちに切り替え
	CommonNPC_SwitchOneHandMode(ai, goal)

	--20% 右手攻撃
	--80% 右手強攻撃
	if NR_fate <= 20 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	end

end
	
---------------------------------------------------------
--  右手コンボ2・猛攻撃
---------------------------------------------------------
function GalV_816000Battle_NormalR_Comb2(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用
local NR_fate2 = ai:GetRandam_Int(1,100)			--確率判定用

	--武器に持ち替える
	CommonNPC_ChangeWepR1(ai, goal)

	if NR_fate <= 35 then
	
		--片手持ちに切り替え
		CommonNPC_SwitchOneHandMode(ai, goal)
		
		--20% 右手攻撃
		--80% 右手強攻撃
		if NR_fate2 <= 20 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
		end

	else
	
		--両手持ちに切り替え
		CommonNPC_SwitchBothHandMode(ai, goal)

		--100% 両手持ち攻撃二回
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);

	end
		
end


---------------------------------------------------------
--  攻撃・魔法
---------------------------------------------------------
function GalV_816000Battle_Magic(ai, goal)

	--片手持ちに切り替え
	CommonNPC_SwitchOneHandMode(ai, goal)

	--魔法を自己中心爆発に切り替える
	ai:ChangeEquipMagic(0);

	--タリスマンを装備していなければ切り替える
	CommonNPC_ChangeWepR2(ai, goal)
	
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_MagicR, TARGET_ENE_0, DIST_None, 0);
	GalV_816000Battle_Kougeki_Noato2(ai, goal)
		
	
end


---------------------------------------------------------
--  攻撃・ガード
---------------------------------------------------------
function GalV_816000Battle_Normal_Guard(ai, goal)

	--片手持ちに切り替え
	CommonNPC_SwitchOneHandMode(ai, goal)

	--盾を持っていなければ切り替えてガード
	goal:AddSubGoal( GOAL_COMMON_Guard, 2.0, 4, TARGET_ENE_0, true, 0 );

end

---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function GalV_816000Battle_Kougeki_Noato(ai, goal)

	--100％　巣に戻る
	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, POINT_INITIAL, 0.5, TARGET_ENE_0, true, 4 )

end

---------------------------------------------------------
--  攻撃後の行動2
---------------------------------------------------------
function GalV_816000Battle_Kougeki_Noato2(ai, goal)

	goal:AddSubGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true ,4 );
end


---------------------------------------------------------
--  割り込みの攻撃パターン
---------------------------------------------------------
function GalV_816000Battle_Interupt_Attack_ptn(ai, goal)

	--武器を持っていなければ持ち替える
	CommonNPC_ChangeWepR1(ai, goal);

	--片手持ちだったら
	if ( not( ai:IsBothHandMode(TARGET_SELF) ) ) then
		--パリィ
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Parry, TARGET_ENE_0, DIST_None, 0);
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	--両手持ちだったら連続攻撃
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	end
end


--[[*****************************************************
	更新・終了
*******************************************************]]
function GalV_816000Battle_Update(ai, goal) return GOAL_RESULT_Continue; end
function GalV_816000Battle_Terminate(ai, goal) end


--[[*****************************************************
	割り込み
		割り込んだ場合にはtrueを返してください。
		ここで割り込み用のサブゴールを追加してください。
		割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
*******************************************************]]
function GalV_816000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local NormalR_Dist = 2.5			--右手攻撃の適正間合い

	
	--至近距離で攻撃されそうになったら超反応パリィ
	if ai:IsInterupt( INTERUPT_FindAttack ) then
local superStepDist = 2.0			--超反応する距離
local superStepPer = 40			--超反応する確率	
		if targetDist <= superStepDist then
			if fate <= superStepPer then
			goal:ClearSubGoal();
			GalV_816000Battle_Interupt_Attack_ptn(ai, goal)
			return true;
			end
		end
	end
	
	
	--飛び道具を撃ってきたら最適行動
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 100					--飛び道具使用時に最適行動を取る確率
		if fate <= shootIntPer then
			goal:ClearSubGoal();
			if ( 0==goal:GetParam(0) ) then
				GalV_816000Battle_Normal_Guard(ai, goal)
			else
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, 4 );
				GalV_816000Battle_NormalR_Comb(ai, goal)
			end
			return true;
		end
	end
	
	
return false;
end

