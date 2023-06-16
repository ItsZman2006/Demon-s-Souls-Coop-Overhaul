-----------------------------------------------------------------------------------------------
--	FaranCIBI500000専用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_FaranCIBI500000_Battle, "FaranCIBI500000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_FaranCIBI500000_Battle, 1 );



---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function FaranCIBI500000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------
local role = ai:GetTeamOrder(ORDER_TYPE_Role);			--自分の役割を取得	
local eventNo = ai:GetEventRequest();					--イベントからのリクエスト番号を取得

local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得
local targethprate = ai:GetHpRate( TARGET_ENE_0 )		--敵ターゲットのHP割合を取得
local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その３
local fate4 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その４
local fate5 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その５
	
local waitTime = ai:GetRandam_Float(0.5, 2.0)			--待ち時間

	--タイマー０番が終了していれば、ちょっとまつ
	if ai:IsFinishTimer(0) == true then
		--ここでタイマー０番をセット 9999秒
		ai:SetTimer( 0, 9999.0 );
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(0.0, 1.0), TARGET_ENE_0, 0, 0, 0 );
	end

	--合体状態
	if eventNo == AI_EVENT_Phalanx_Gattai then
		--PCが近いなら
		if targetDist <= 4.0 then
			--67％　突き
			if fate <= 67 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3030, TARGET_ENE_0, DIST_None, 0);
				goal:AddSubGoal(GOAL_COMMON_Wait, waitTime, TARGET_NONE, 0, 0, 0 );
				
			--3％　射撃
			elseif fate <= 70 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3010, TARGET_ENE_0, DIST_None, 0);
				goal:AddSubGoal(GOAL_COMMON_Wait, waitTime, TARGET_NONE, 0, 0, 0 );
				
			--30％　待機			
			else
				goal:AddSubGoal(GOAL_COMMON_Wait, waitTime, TARGET_NONE, 0, 0, 0 );
			end
			
		--PCが近くないなら	
		else
			--21％　突き
			if fate <= 21 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3030, TARGET_ENE_0, DIST_None, 0);
				goal:AddSubGoal(GOAL_COMMON_Wait, waitTime, TARGET_NONE, 0, 0, 0 );
				
			--4％　射撃
			elseif fate <= 25 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3010, TARGET_ENE_0, DIST_None, 0);
				goal:AddSubGoal(GOAL_COMMON_Wait, waitTime, TARGET_NONE, 0, 0, 0 );
				
			--75%　待機
			else
				goal:AddSubGoal(GOAL_COMMON_Wait, waitTime, TARGET_NONE, 0, 0, 0 );
			end
			
		end	
		
	--分散状態
	else
		--攻撃役、その他役なら
		if role == ROLE_TYPE_Attack or role == ROLE_TYPE_None then
			goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, 0.5, 3.0, TARGET_ENE_0, true, -1 );
			FaranCIBI500000Battle_Tukisasi(ai, goal)
			
		--取り巻き役なら
		elseif role == ROLE_TYPE_Torimaki then
			--10％槍投げ　75％接近して突き　15％何もしない
			if fate <= 10 then
				goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, 3.0, 10.0, TARGET_ENE_0, true, -1 );
				FaranCIBI500000Battle_Syasyutu(ai, goal)
			elseif fate <= 85 then
				goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, 0.5, 3.0, TARGET_ENE_0, true, -1 );
				FaranCIBI500000Battle_Tukisasi(ai, goal)
			else
				goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(0.5, 2.0), TARGET_NONE, 0, 0, 0 );
			end
			
		--観衆役なら
		else
			--4％槍投げ　16％接近して突き　80％何もしない
			if fate <= 4 then
				goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, 3.0, 10.0, TARGET_ENE_0, true, -1 );
				FaranCIBI500000Battle_Syasyutu(ai, goal)
			elseif fate <= 20 then
				goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, 0.5, 3.0, TARGET_ENE_0, true, -1 );
				FaranCIBI500000Battle_Tukisasi(ai, goal)
			else
				goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(0.5, 2.0), TARGET_NONE, 0, 0, 0 );
			end
		end
	end
end


-----------------------------------
--槍で突き刺す
-----------------------------------
function FaranCIBI500000Battle_Tukisasi(ai, goal )

local T_fate = ai:GetRandam_Int(1,100)
local SideTime = 3.0							--横に動く時間
local BackDist = 2.5							--後退する距離
local BackTime = 3.0							--後退する時間
local bRight = ai:GetRandam_Int(0,1);			--右か左か

	--3030で攻撃
	goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3030, TARGET_ENE_0, DIST_Middle, 0);
	
	--60% なにもしない（ちょっと待つ）	--30% 適当に横に移動	--10% 後ろに移動
	if T_fate <= 60 then
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(0.5, 2.0), TARGET_NONE, 0, 0, 0 );
	elseif T_fate <= 90  then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, bRight, ai:GetRandam_Int(30,45), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end

end

-------------------------------------------
--槍射出
-------------------------------------------
function FaranCIBI500000Battle_Syasyutu(ai, goal)

local S_fate = ai:GetRandam_Int(1,100)
local SideTime = 3.0							--横に動く時間
local BackDist = 2.5							--後退する距離
local BackTime = 3.0							--後退する時間
local bRight = ai:GetRandam_Int(0,1);			--右か左か

	--3010で攻撃して、少し休む
	goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3010, TARGET_ENE_0, DIST_Far, 0);
	goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(0.5, 2.0), TARGET_NONE, 0, 0, 0 );
	
	--70% なにもしない（ちょっと待つ）	--30% 適当に横に移動	--0% 後ろに移動
	if S_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float(0.5, 2.0), TARGET_NONE, 0, 0, 0 );
	elseif S_fate <= 100  then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, bRight, ai:GetRandam_Int(30,45), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end



---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function FaranCIBI500000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function FaranCIBI500000Battle_Terminate(ai, goal)
end




-- 割り込みなし宣言
-- これがtrueの場合には割り込みが呼ばれないので注意してください。
REGISTER_GOAL_NO_INTERUPT(GOAL_FaranCIBI500000_Battle, true);
---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function FaranCIBI500000Battle_Interupt(ai, goal)

return false;

end
