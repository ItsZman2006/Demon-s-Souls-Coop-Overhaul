-----------------------------------------------------------------------------------------------
--	【獄吏】用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Gokuri208003_Battle, "Gokuri208003Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Gokuri208003_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function Gokuri208003Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得
local targethprate = ai:GetHpRate( TARGET_ENE_0 )	--敵ターゲットのHP割合を取得
local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２

local farDist = 15.0		--うんと遠いと判断する距離
local nonPassDist = 10.0	--パス移動で近づく距離（精度に自信なし）　★暫定措置★　★しかも削除中★
local nearDist = 3.0		--近いと判断する距離
local maaiDist = 2.0		--攻撃のために近づく距離　★汎用化の為、攻撃ごとに分けず★

	-- まずは攻撃命令を出す
	if ai:GetTeamRecordCount(COORDINATE_TYPE_AttackOrder, TARGET_ENE_0, 100.0) <= 0 then
		-- 命令出ていないので命令出す
		ai:AddTeamRecord(COORDINATE_TYPE_AttackOrder, TARGET_ENE_0, 0.0);
		-- ポーズを取る
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	else
		--遠いなら
		if targetDist >= farDist then
			--30％　歩いて近づく
			--0％　３ｍほど歩いてから走って近づく
			--70％　走って近づく
			if fate < 30 then
	--			
				--魔法攻撃
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_None, 0);
				
			else
				goal:AddSubGoal( GOAL_COMMON_Wait, 5.0, TARGET_ENE_0, 0, 0, 0 );
			end
			
		--遠くもないが近くもないなら
		elseif targetDist >= nearDist then
			--70％　走って近づく
			--30％　歩いて近づく
			if fate < 70 then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_KeepDist, 10, TARGET_ENE_0, 3.0, 5.0, TARGET_ENE_0, false, -1 );
			end
			
		--近いなら	
		elseif targetDist >= maaiDist then
			--100％　歩いて近づく
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			
		--間合い以内なら
		else
			--攻撃する
			Gokuri208003Battle_Kougeki(ai, goal)
			
			--攻撃後行動
			Gokuri208003Battle_Kougeki_Noato(ai, goal)
			
		end
	end
end


---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function Gokuri208003Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--15% 3000
	--40% 3000-3001
	--30% 3002
	--15% 3000-3001-3002
	if K_fate < 30 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate < 60 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function Gokuri208003Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local SideDist = 2.5							--横に動く距離
local SideTime = 5.0							--横に動く時間
local BackDist = 2.5							--後退する距離
local BackTime = 5.0							--後退する時間

	--70% なにもしない（ちょっとだけ待つ）
	--0% 適当に横に移動
	--30% 後ろに移動
	if KN_fate < 70 then
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.0,0.5) ,0,0,0,0)
	elseif KN_fate < 0 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true, 9910);
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end

	
	
---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function Gokuri208003Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function Gokuri208003Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function Gokuri208003Battle_Interupt(ai, goal)

local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得
local targethprate = ai:GetHpRate( TARGET_ENE_0 )	--敵ターゲットのHP割合を取得
local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２
	
local maaiDist = 2.0		--攻撃のために近づく距離　★汎用化の為、攻撃ごとに分けず★

	-- コンボ逃れ用
	-- ターゲットが近い時にダメージを受けたなら
	if ai:IsInterupt( INTERUPT_Damaged ) then
		if targetDist < 2.0 then
			local combPer = 0			--コンボ逃れを実行する確率
			local CountPer = 20			--コンボ逃れの後に攻撃する確率
			if fate <= combPer then
				--ガードして下がる
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 3.0, TARGET_ENE_0, true, -1 );				
				if fate2 <= CountPer then
					--ガードして近づく
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
					--攻撃する
					Gokuri208003Battle_Kougeki(ai, goal)
					--攻撃後行動
					Gokuri208003Battle_Kougeki_Noato(ai, goal)
				end
				return true;
			end
		end
	end
	
	-- ターゲットが近い時に、ターゲットがガード崩され状態になったら
	if ai:IsInterupt( INTERUPT_GuardBreak ) then
		if targetDist < 2.0 then
			local oiutiPer = 40			--ガード崩れ追い討ちを実行する確率
			if fate <= oiutiPer then		
				goal:ClearSubGoal();
					--攻撃する
					Gokuri208003Battle_Kougeki(ai, goal)
					--攻撃後行動
					Gokuri208003Battle_Kougeki_Noato(ai, goal)
			end
			return true;
		end
	end
	
return false;
end


	