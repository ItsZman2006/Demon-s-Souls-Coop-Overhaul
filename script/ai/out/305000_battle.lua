--[[*******************************************************************************************
	Gagoiru305000専用戦闘
	説明：

	パラメータ0  なし
	パラメータ1  なし
	パラメータ2  なし
	パラメータ3　なし

	●ai:SetNumber()の使用状況。
		０：起動領域に入ったか？	入ってたら０以外。
		１：地上移行タイマ、設定済みか？　０以外で、設定済み。
		２：地上移行モードになったか？
		３：起動時地上移動モードになったか？
		
	●ai:AddObserveRegion()の使用状況。
		０：ガーゴイル起動領域
		１：
		２：
		３：
		
	●ai:SetTimer()の使用状況。
		０：地上へ移行タイマ。
		１：
		２：
		３：
		
*********************************************************************************************]]


function Gagoiru305000_IsSwordType( ai )

	--NPC思考パラメータが増えたら、必ず対応する事！！！！

	local idParam = ai:GetNpcThinkParamID();
	if ( idParam==305001 ) then return false; end
	
	return true;
end



--[[*******************************************************************************************
	戦闘全体。
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Gagoiru305000_Battle, "Gagoiru305000Battle");
REGISTER_GOAL_NO_UPDATE(GOAL_Gagoiru305000_Battle, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_Gagoiru305000_Battle, true);

function Gagoiru305000Battle_Activate(ai, goal)
	
	if ( ai:IsLanding() ) then
		goal:AddSubGoal( GOAL_Gagoiru305000_LandBattle, goal:GetLife());
	else
		goal:AddSubGoal( GOAL_Gagoiru305000_AirBattle, goal:GetLife());
	end

end

function Gagoiru305000Battle_Update(ai, goal) return GOAL_RESULT_Continue; end
function Gagoiru305000Battle_Terminate(ai, goal)end
function Gagoiru305000Battle_Interupt(ai, goal)	return false; end




--[[*******************************************************************************************
	空中戦闘。
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Gagoiru305000_AirBattle, "Gagoiru305000AirBattle");
REGISTER_GOAL_NO_UPDATE(GOAL_Gagoiru305000_AirBattle, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_Gagoiru305000_AirBattle, true);

function Gagoiru305000AirBattle_Activate(ai, goal)
	
--[[■調整項目■]]

	local ON_AIR_TIME=0;
	if ( Gagoiru305000_IsSwordType(ai) ) then
	
		--剣タイプの場合。	
		ON_AIR_TIME = 2;		--空中から地上へ移行するまでの時間.
	else
	
		--ボウガンタイプの場合。
		ON_AIR_TIME = 4;		--空中から地上へ移行するまでの時間.(空中から狙撃できるので長め。)		
	end


--[[■調整項目■]]

	--設定済みでなければ。
	if ( 0==ai:GetNumber(1) ) then
		--タイマ設定。
		ai:SetTimer(0, ON_AIR_TIME);
		ai:SetNumber(1, 1);
	end
	
	--タイマ設定済み、かつ、時間切れの場合。
	if ( ai:IsFinishTimer(0) and not(0==ai:GetNumber(1)) ) then
		ai:SetNumber(1, 0);
		ai:SetNumber(2, 1);
	end
	
	if ( not(0==ai:GetNumber(2))) then
		--
		goal:AddSubGoal( GOAL_Gagoiru305000_Battle_Landing, 10);
		
		
		if ( Gagoiru305000_IsSwordType(ai) ) then
			--床の際にターゲットが立っていると着地できない。ので、一辺攻撃して仕切りなおし。
			goal:AddSubGoal( GOAL_Gagoiru305000_LandingAttack, 10);
		end
		
	else
		--剣タイプで。。
		if ( Gagoiru305000_IsSwordType(ai) ) then
			--高度がずれすぎていたら、ちょっと高い程度におろす。
			if ( ai:GetDistYSigned(TARGET_ENE_0)<-2 ) then
				goal:AddSubGoal( GOAL_COMMON_Fall, 	10.0, 	TARGET_ENE_0, 9510, 9520, -1);
			end
		end
		--攻撃。
		Gagoiru305000AirBattle_Attack(ai, goal);
	end

end

function Gagoiru305000AirBattle_Update(ai, goal) return GOAL_RESULT_Continue; end
function Gagoiru305000AirBattle_Terminate(ai, goal)end
function Gagoiru305000AirBattle_Interupt(ai, goal)	return false; end

function Gagoiru305000AirBattle_Attack(ai, goal)

	local attack_range	= ai:GetDistParam(DIST_Near);
	local leave_range	= ai:GetDistParam(DIST_Far);
		
	if ( Gagoiru305000_IsSwordType(ai) ) then
		--剣タイプ。

		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 	10.0, 	TARGET_ENE_0, attack_range, TARGET_ENE_0, false, -1 );
		Gagoiru305000LandBattle_Kougeki(ai, goal);
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 		10.0, 	TARGET_ENE_0, leave_range, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal( GOAL_COMMON_Wait, 				2.0, 	TARGET_ENE_0);
	else
		--ボウガンタイプ。（攻撃間隔調整）
		Gagoiru305000LandBattle_Kougeki(ai, goal);
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 		10.0, 	TARGET_ENE_0, leave_range, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal( GOAL_COMMON_Wait, 				5.0, 	TARGET_ENE_0);
	end

end


--[[*******************************************************************************************
	地上戦闘。
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Gagoiru305000_LandBattle, "Gagoiru305000LandBattle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Gagoiru305000_LandBattle, true);

--遠距離
--　空中から走り接近、もしくは旋回してから走り接近
--　もしくは歩き接近
--　ボウガンは攻撃してから接近
--
--中距離
--　旋回してから走り接近、もしくは歩き接近
--
--近距離
--　攻撃
--
--攻撃後の行動
--　少し後退する
--　ときどき飛び立って少し離れる（地上）


--[[*****************************************************
--  ゴール起動
*******************************************************]]
function Gagoiru305000LandBattle_Activate(ai, goal)
------------------------------------------------------------------------------

	--地上に移行完了したから、フラグを下げる。
	ai:SetNumber(2, 0);

	--行動選択。
	if ( Gagoiru305000_IsSwordType(ai) ) then
		--剣
		Gagoiru305000LandBattle_BehaviorSelection_SWORD(ai, goal);
	else
		--ボウガン
		Gagoiru305000LandBattle_BehaviorSelection_BOWGUN(ai, goal);
	end
end

---------------------------------------------------------
--  行動選択：剣タイプ。
---------------------------------------------------------
function Gagoiru305000LandBattle_BehaviorSelection_SWORD(ai, goal)
	--行動切り替え。
	local targetDist 		= ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離
	local RANGE_TOO_NEAR	= 1.5;								--至近。これ以上近いと間合い敵に攻撃しずらい。
	local RANGE_NEAR		= ai:GetDistParam(DIST_Near);		--近距離
	local RANGE_MIDDLE		= ai:GetDistParam(DIST_Middle);		--中距離
	local RANGE_FAR			= ai:GetDistParam(DIST_Far);		--遠距離

	
	--各距離における行動選択。
	if 		( targetDist < RANGE_TOO_NEAR ) then	Gagoiru305000LandBattle_Attack_TOO_NEAR(ai, goal);
	elseif 	( targetDist < RANGE_NEAR ) 	then	Gagoiru305000LandBattle_Attack_NEAR(ai, goal);
	elseif	( targetDist < RANGE_MIDDLE ) 	then	Gagoiru305000LandBattle_Attack_MIDDLE(ai, goal);
	else											Gagoiru305000LandBattle_Attack_FAR(ai, goal);
	end
end

---------------------------------------------------------
--  行動選択：ボウガンタイプ。
---------------------------------------------------------
function Gagoiru305000LandBattle_BehaviorSelection_BOWGUN(ai, goal)

	--攻撃。
	Gagoiru305000LandBattle_Kougeki(ai, goal);
end

---------------------------------------------------------
--  攻撃：至近距離。
---------------------------------------------------------
function Gagoiru305000LandBattle_Attack_TOO_NEAR(ai, goal)
	--ちょっと離れて。
	Gagoiru305000LandBattle_KeepDist(ai, goal);
	--近距離攻撃。
	Gagoiru305000LandBattle_Attack_NEAR(ai, goal);
end

---------------------------------------------------------
--  攻撃：近距離
---------------------------------------------------------
function Gagoiru305000LandBattle_Attack_NEAR(ai, goal)
	--攻撃する
	--攻撃後行動
	Gagoiru305000LandBattle_Kougeki(ai, goal);
	Gagoiru305000LandBattle_Kougeki_Noato(ai, goal);
end

---------------------------------------------------------
--  攻撃：中距離
---------------------------------------------------------
function Gagoiru305000LandBattle_Attack_MIDDLE(ai, goal)
	local RANGE_NEAR	= ai:GetDistParam(DIST_Near);		--近距離
	local target_range	= RANGE_NEAR *0.8;
	local fate 			= ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
	
	--50％　（旋回→）走り接近　　
	--35％　飛び込み攻撃
	--15％　歩き接近
	if fate < 50 then
--	 	goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 20, false, true ,-1 );
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, target_range, TARGET_ENE_0, false, -1 );
		
	elseif fate < 85 then
		goal:AddSubGoal(GOAL_COMMON_KeepDist, 5.0, TARGET_ENE_0, 2.0, 5.5, TARGET_ENE_0, false, -1 );		--追加　平井
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Near, 0);
		
	else
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, target_range, TARGET_ENE_0, true, -1 );
		
	end
end

---------------------------------------------------------
--  攻撃：遠距離
---------------------------------------------------------
function Gagoiru305000LandBattle_Attack_FAR(ai, goal)
	local RANGE_NEAR	= ai:GetDistParam(DIST_Near);		--近距離
	local target_range	= RANGE_NEAR *0.8;
	local fate 			= ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
	local isWalk		= false;
	
	--75％　走り接近
	--25％　歩き接近
	if fate < 75 then
		isWalk	= false;
	else
		isWalk	= true;
	end
	
	--接近。
	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, target_range, TARGET_ENE_0, isWalk, -1 );
end



---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function Gagoiru305000LandBattle_Kougeki(ai, goal)

	if ( Gagoiru305000_IsSwordType(ai) ) then
		Gagoiru305000LandBattle_Kougeki_SWORD(ai, goal);
	else
		Gagoiru305000LandBattle_Kougeki_BOWGUN(ai, goal);
	end

end


---------------------------------------------------------
--  攻撃：ボウガン
---------------------------------------------------------
function Gagoiru305000LandBattle_Kougeki_BOWGUN(ai, goal)

local fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--距離を保つ。
	goal:AddSubGoal( GOAL_COMMON_KeepDist, 2, TARGET_ENE_0, 15, 16, TARGET_ENE_0, false, -1 );
	--攻撃。
	goal:AddSubGoal(GOAL_Gagoiru305000_BowgunAttack, 3.0);
	--ちょっと待つ。。（※重要）
	if fate < 30 then
		goal:AddSubGoal(GOAL_COMMON_Wait, 3.0);
	else
		Gagoiru305000LandBattle_Kougeki_Noato(ai, goal);
	end

end


---------------------------------------------------------
--  攻撃：剣
---------------------------------------------------------
function Gagoiru305000LandBattle_Kougeki_SWORD(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--空中
	--30% 3001　刺突剣1
	--30% 3002　刺突剣1→2
	--20% 3003　刺突剣1→2→3
	--20% 3300　溜め刺突剣
	
	--地上
	--70% 3001(13001)　刺突剣1
	--30% 3004(13004)　飛び込み攻撃
	if (ai:IsLanding()) then
		if K_fate < 30 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Near, 0);
		elseif K_fate < 60 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Near, 0);
		elseif K_fate < 80 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Near, 0);
		end
	else
		if K_fate < 50 then
			goal:AddSubGoal(GOAL_COMMON_KeepDist, 5.0, TARGET_ENE_0, 0.0, 5.0, TARGET_ENE_0, false, -1 );		--追加　平井
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_KeepDist, 5.0, TARGET_ENE_0, 2.0, 5.5, TARGET_ENE_0, false, -1 );		--追加　平井
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Near, 0);
		end
	end
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function Gagoiru305000LandBattle_Kougeki_Noato(ai, goal)

	Gagoiru305000LandBattle_KeepDist(ai, goal);
end

---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function Gagoiru305000LandBattle_KeepDist(ai, goal)

	local RANGE_NEAR		= ai:GetDistParam(DIST_Near);	--近距離
	local RANGE_NEAR_near	= RANGE_NEAR - 0.5;
	local RANGE_NEAR_far	= RANGE_NEAR + 0.5;
	local BackTime 			= 4.0							--後退する時間

	goal:AddSubGoal( GOAL_COMMON_KeepDist, BackTime, TARGET_ENE_0, RANGE_NEAR_near, RANGE_NEAR_far, TARGET_ENE_0, false, -1 );				

end


--[[*****************************************************
--  ゴール更新
*******************************************************]]
function Gagoiru305000LandBattle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


--[[*****************************************************
--  ゴール終了
*******************************************************]]
function Gagoiru305000LandBattle_Terminate(ai, goal)
end


--[[*****************************************************
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
*******************************************************]]
function Gagoiru305000LandBattle_Interupt(ai, goal)

--[[■調整項目■]]

	--空振り攻撃割合。
	local MISS_SWING_ATTACK_RATE	= 25;
	
	--空中に逃げ出すダメージ量。
	local AWAY_DAMAGE				= 100;
	--逃げる距離。
	local AWAY_DISTANCE				= 3;

--[[■調整項目■]]


	local targetDist		= ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
	local RANGE_NEAR		= ai:GetDistParam(DIST_Near);	--近距離
	local RANGE_NEAR_near	= RANGE_NEAR -1;
	local RANGE_NEAR_far	= RANGE_NEAR +1;
	local fate 				= ai:GetRandam_Int(1,100);		--確率判定で使用する運命の数字

	--空振り追い討ち
	--25％　近くのターゲットが空振りしたら攻撃
	if ( ai:IsInterupt( INTERUPT_MissSwing ) ) then
		if ((RANGE_NEAR_far < targetDist) and (targetDist < RANGE_NEAR_far)) then
			if (fate <= MISS_SWING_ATTACK_RATE) then
			
				--近接攻撃。
				goal:ClearSubGoal();
				Gagoiru305000LandBattle_Kougeki(ai, goal)
				Gagoiru305000LandBattle_Kougeki_Noato(ai, goal)
				
				return true;
			end	
		end
	end

	--ダメージを食らった。
	if (ai:IsInterupt(INTERUPT_Damaged)) then
		--現在のダメージ率を
		local lastdamage = ai:GetDamageLastFrame();
		
		--ダメージ量に応じて、空中に逃げるか？
		if ( AWAY_DAMAGE < lastdamage ) then
			goal:ClearSubGoal();
			
			--空中に離脱＆離れる。
			goal:AddSubGoal( GOAL_Gagoiru305000_LiftOff, 	10);
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 		2.0, 	TARGET_ENE_0, AWAY_DISTANCE, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal( GOAL_COMMON_Wait, 				2.0, 	TARGET_ENE_0);
		end
	end
		
	return false;
end



--[[***********************************************************************************]]
--[[**************************** 以下、ガーゴイル用サブゴール *************************]]
--[[***********************************************************************************]]


--[[*****************************************************
--  着地できるところに移動⇒着地。
*******************************************************]]
REGISTER_GOAL(GOAL_Gagoiru305000_Battle_Landing, "Gagoiru305000Battle_Landing");
REGISTER_GOAL_NO_UPDATE( GOAL_Gagoiru305000_Battle_Landing, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_Gagoiru305000_Battle_Landing, true);

function Gagoiru305000Battle_Landing_Activate(ai, goal)

	--AI固定目標を設定。
	ai:SetAIFixedMoveTarget( POINT_2ndNEAR_LANDING, TARGET_SELF, 0);
--~ 	ai:SetAIFixedMoveTarget( POINT_FAR_LANDING, TARGET_SELF, 0);

	--まず、目標位置へ向かう。
	goal:AddSubGoal( GOAL_Gagoiru305000_Battle_Landing_Move, 10);
	
	if (0<ai:GetDistYSigned(TARGET_ENE_0)) then
		--接近。
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, POINT_AI_FIXED_POS, 0.1, TARGET_SELF, false, -1 );
	else
		goal:AddSubGoal( GOAL_Gagoiru305000_Battle_Landing_Landing, 10);
	end
end
function Gagoiru305000Battle_Landing_Update(ai, goal)return GOAL_RESULT_Continue;end
function Gagoiru305000Battle_Landing_Terminate(ai, goal)end
function Gagoiru305000Battle_Landing_Interupt(ai, goal)	return false;end

--[[*****************************************************
--  着地できるところに移動する。
*******************************************************]]
REGISTER_GOAL(GOAL_Gagoiru305000_Battle_Landing_Move, "Gagoiru305000Battle_Landing_Move");
REGISTER_GOAL_UPDATE_TIME( GOAL_Gagoiru305000_Battle_Landing_Move, 0.5, 0.5);
REGISTER_GOAL_NO_INTERUPT( GOAL_Gagoiru305000_Battle_Landing_Move, true);

function Gagoiru305000Battle_Landing_Move_Activate(ai, goal)
	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, POINT_AI_FIXED_POS, 2, TARGET_SELF, false, -1 );
end
function Gagoiru305000Battle_Landing_Move_Update(ai, goal)
	
	local distXZ = ai:GetDistXZ(POINT_AI_FIXED_POS);
	if ( distXZ < 1 ) then
		return GOAL_RESULT_Success;
	end
	
	--目標位置前に、不意に着地しちゃったら、失敗してリプランニング。
	if ( ai:IsLanding() ) then
		return GOAL_RESULT_Failed;
	end

	return GOAL_RESULT_Continue;
end
function Gagoiru305000Battle_Landing_Move_Terminate(ai, goal)end
function Gagoiru305000Battle_Landing_Move_Interupt(ai, goal)	return false;end

--[[*****************************************************
--  着地。
*******************************************************]]
REGISTER_GOAL(GOAL_Gagoiru305000_Battle_Landing_Landing, "Gagoiru305000Battle_Landing_Landing");
REGISTER_GOAL_UPDATE_TIME( GOAL_Gagoiru305000_Battle_Landing_Landing, 0.5, 0.5);
REGISTER_GOAL_NO_INTERUPT( GOAL_Gagoiru305000_Battle_Landing_Landing, true);

function Gagoiru305000Battle_Landing_Landing_Activate(ai, goal)
	goal:AddSubGoal( GOAL_COMMON_Attack, 1, 9510, TARGET_NONE, DIST_None);
end
function Gagoiru305000Battle_Landing_Landing_Update(ai, goal)
	if ( ai:IsLanding() ) then
	
		--着地判定瞬間にゴールを終わらせると、どうやら、すんなり
		--着地できないみたい。
		local cnt = goal:GetNumber(0);
		if ( 10<cnt ) then
			return GOAL_RESULT_Success;
		else
			cnt = cnt +1;
			goal:SetNumber(0,cnt);
		end
	end
	
	--着地できるまでしつこく。
	local resultSubGoal = goal:GetLastSubGoalResult();
	if ( (resultSubGoal==GOAL_RESULT_Success) or (resultSubGoal==GOAL_RESULT_Failed) ) then
		if ( not(ai:IsLanding()) ) then
			goal:AddSubGoal( GOAL_COMMON_Attack, 1, 9510, TARGET_NONE, DIST_None);
		end
	end

	--ターゲットより高さが下になったら。。。
	if ( 1<ai:GetDistYSigned(POINT_AI_FIXED_POS)) then
		--落っこちすぎたので、やり直し。
		return GOAL_RESULT_Failed;
	end
	
	return GOAL_RESULT_Continue;
end
function Gagoiru305000Battle_Landing_Landing_Terminate(ai, goal)end
function Gagoiru305000Battle_Landing_Landing_Interupt(ai, goal)	return false;end


--[[*****************************************************
	着地しきれなかったときのリカバー用。
	PCに攻撃させないため、先に攻撃しちゃう。
*******************************************************]]
REGISTER_GOAL(GOAL_Gagoiru305000_LandingAttack, "Gagoiru305000Battle_LandingAttack");
REGISTER_GOAL_NO_UPDATE( GOAL_Gagoiru305000_LandingAttack, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_Gagoiru305000_LandingAttack, true);

function Gagoiru305000Battle_LandingAttack_Activate(ai, goal)
	
	if ( ai:IsLanding() ) then
		goal:AddSubGoal( GOAL_COMMON_Wait, 0.1, TARGET_ENE_0);
	else
		Gagoiru305000AirBattle_Attack(ai, goal);
	end

end

function Gagoiru305000Battle_LandingAttack_Update(ai, goal) return GOAL_RESULT_Continue; end
function Gagoiru305000Battle_LandingAttack_Terminate(ai, goal) end
function Gagoiru305000Battle_LandingAttack_Interupt(ai, goal) return false; end


--[[*****************************************************
	ボウガン攻撃。
*******************************************************]]
REGISTER_GOAL(GOAL_Gagoiru305000_BowgunAttack, "Gagoiru305000Battle_BowgunAttack");
REGISTER_GOAL_NO_UPDATE(GOAL_Gagoiru305000_BowgunAttack, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_Gagoiru305000_BowgunAttack, true);

function Gagoiru305000Battle_BowgunAttack_Activate(ai, goal)

--[[■調整項目■]]
	--この値以下に距離がなったら、後ろに間合いをあけられていないと言うことで、離陸する。
	local LIFT_OFF_DISTANCE	= 10;
--[[■調整項目■]]


	local distXZ = ai:GetDistXZ(TARGET_ENE_0);
	if ( ai:IsLanding() and distXZ<LIFT_OFF_DISTANCE ) then
		--着地してて、動けなくなっている場合は、離陸する。
		goal:AddSubGoal(GOAL_Gagoiru305000_LiftOff, goal:GetLife(), 9520, TARGET_NONE, DIST_None);
	else
		--普通に攻撃。
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, goal:GetLife(), 3000, TARGET_ENE_0, DIST_None);
		--ちょっと待つ。。
--~ 		goal:AddSubGoal(GOAL_COMMON_Wait, 3.0);
	end
end

function Gagoiru305000Battle_BowgunAttack_Update(ai, goal) return GOAL_RESULT_Continue; end
function Gagoiru305000Battle_BowgunAttack_Terminate(ai, goal)end
function Gagoiru305000Battle_BowgunAttack_Interupt(ai, goal) return false; end


--[[*****************************************************
	離陸。
*******************************************************]]
REGISTER_GOAL(GOAL_Gagoiru305000_LiftOff, "Gagoiru305000Battle_LiftOff");
--~ REGISTER_GOAL_NO_UPDATE(GOAL_Gagoiru305000_LiftOff, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_Gagoiru305000_LiftOff, true);

function Gagoiru305000Battle_LiftOff_Activate(ai, goal)

	goal:AddSubGoal(GOAL_COMMON_Attack, goal:GetLife(), 9520, TARGET_NONE, DIST_None);
end

function Gagoiru305000Battle_LiftOff_Update(ai, goal)
	--着地できるまでしつこく。
	local resultSubGoal = goal:GetLastSubGoalResult();
	if ( (resultSubGoal==GOAL_RESULT_Success) or (resultSubGoal==GOAL_RESULT_Failed) ) then
		if ( ai:IsLanding() ) then
			goal:AddSubGoal( GOAL_COMMON_Attack, 1, 9520, TARGET_NONE, DIST_None);
		end
	end
	
	return GOAL_RESULT_Continue;
end

function Gagoiru305000Battle_LiftOff_Terminate(ai, goal)end
function Gagoiru305000Battle_LiftOff_Interupt(ai, goal) return false; end


--[[*****************************************************
	地面に着地。
*******************************************************]]
REGISTER_GOAL(GOAL_Gagoiru305000_LandingOnGround, "Gagoiru305000LandingOnGround");
REGISTER_GOAL_UPDATE_TIME(GOAL_Gagoiru305000_LandingOnGround, 0.5, 0.5);
REGISTER_GOAL_NO_INTERUPT(GOAL_Gagoiru305000_LandingOnGround, true);

function Gagoiru305000LandingOnGround_Activate(ai, goal)
	goal:AddSubGoal( GOAL_COMMON_Attack, 1, 9510, TARGET_NONE, DIST_None);
end
function Gagoiru305000LandingOnGround_Update(ai, goal)
	if ( ai:IsLanding() ) then
	
		--着地判定瞬間にゴールを終わらせると、どうやら、すんなり
		--着地できないみたい。
		local cnt = goal:GetNumber(0);
		if ( 3<cnt ) then
			return GOAL_RESULT_Success;
		else
			cnt = cnt +1;
			goal:SetNumber(0,cnt);
		end
	end
	
	--着地できるまでしつこく。
	local resultSubGoal = goal:GetLastSubGoalResult();
	if ( (resultSubGoal==GOAL_RESULT_Success) or (resultSubGoal==GOAL_RESULT_Failed) ) then
		if ( not(ai:IsLanding()) ) then
			goal:AddSubGoal( GOAL_COMMON_Attack, 1, 9510, TARGET_NONE, DIST_None);
		end
	end

	return GOAL_RESULT_Continue;
end
function Gagoiru305000LandingOnGround_Terminate(ai, goal)end
function Gagoiru305000LandingOnGround_Interupt(ai, goal)	return false;end






