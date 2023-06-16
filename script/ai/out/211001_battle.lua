-----------------------------------------------------------------------------------------------
--	ウロコ鉱夫（袋 ・非戦）用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_urokoF211001_Battle, "urokoF211001_Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_urokoF211001_Battle, true);


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function urokoF211001_Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得
local targethprate = ai:GetHpRate( TARGET_ENE_0 )	--敵ターゲットのHP割合を取得
local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２

local farDist = 15.0		--うんと遠いと判断する距離
local nearDist = 4.0		--近いと判断する距離
local maaiDist = 1.5		--攻撃のために近づく距離　★汎用化の為、攻撃ごとに分けず★

local role = ai:GetTeamOrder(ORDER_TYPE_Role);					--自分の役割を取得


		--遠いなら
		if targetDist >= farDist then
			
			--待機
			
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 1, TARGET_ENE_0, true, -1 );
			
						
		--遠くもないが近くもないなら
		elseif targetDist >= nearDist then
			--待機
			
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 1, TARGET_ENE_0, true, -1 );
			
		--近いなら	
		elseif targetDist >= maaiDist then
			--待機
			
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 1, TARGET_ENE_0, true, -1 );
			
		--間合い以内なら
		else
		    goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 1, TARGET_ENE_0, true, -1 );
			--攻撃する
			urokoF211001_Battle_Kougeki(ai, goal)
			
			--攻撃後行動
			urokoF211001_Battle_Kougeki_Noato(ai, goal)
			
		end
	end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function urokoF211001_Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local myThinkId = ai:GetNpcThinkParamID()		--思考IDを取得

	--90% 3000
	--10% 3001
	if K_fate < 90 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, AI_DIST_TYPE_Middle, 0);
	else
		if myThinkId == 211001 or myThinkId == 211007 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, AI_DIST_TYPE_Middle, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, AI_DIST_TYPE_Middle, 0);
		end
	end
end

	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function urokoF211001_Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local SideDist = 1.5							--横に動く距離
local SideTime = 1.0							--横に動く時間
local BackDist = 1.0							--後退する距離
local BackTime = 1.0							--後退する時間
local bRight = ai:GetRandam_Int(0,1);			--右か左か
-- 同じ方向に左右移動している仲間の数
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);

	
	--50% 適当に横に移動(ガード無し)
	--50% 後ろに移動(ガードなし)
	if  KN_fate < 70 and friendNum < 1 then
	    goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, bRight, ai:GetRandam_Int(30,45), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end

	
	
---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function urokoF211001_Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function urokoF211001_Battle_Terminate(ai, goal)
end

---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function urokoF211001_Battle_Interupt(ai, goal)

return false;
end


--[[***********************************************************************************]]
--[[******************************* サブゴール ****************************************]]
--[[***********************************************************************************]]

--[[*********************************************************************
	岩投げ。
***********************************************************************]]
REGISTER_GOAL(GOAL_uroko_ThrowRock, "uroko_ThrowRock");
REGISTER_GOAL_NO_UPDATE( GOAL_uroko_ThrowRock, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_uroko_ThrowRock, true);

function uroko_ThrowRock_Activate(ai, goal)

--[[■企画さん調整項目■]]

	local WaitTime_Long				= 3;	--長いランダム幅。
	local WaitTime_Short			= 1;	--短いランダム幅。
	local WaitTime_SelectLongRate	= 20;	--長いランダム幅を選択する割合。
	local idParam = ai:GetNpcThinkParamID();
	local fate = ai:GetRandam_Int(1,100)	--確率判定で使用する運命の数字
	
--[[■企画さん調整項目■]]

	--岩投げ(その場（53003、53006、53011、53012）裏から（53004、53005、53013、53014）（岩種類異なる）をランダムに投げる)
	if 		(idParam==211009) then
		if fate < 25 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3004, TARGET_ENE_0, DIST_None);
		elseif fate < 50 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3005, TARGET_ENE_0, DIST_None);
		elseif fate < 75 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3013, TARGET_ENE_0, DIST_None);
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3014, TARGET_ENE_0, DIST_None);
		end
			
	elseif  (idParam==211011) then
		if fate < 25 then
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3004, TARGET_ENE_0, DIST_None);
		elseif fate < 50 then
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3005, TARGET_ENE_0, DIST_None);
		elseif fate < 75 then
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3013, TARGET_ENE_0, DIST_None);
		else
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3014, TARGET_ENE_0, DIST_None);
		end
	
	elseif 	(idParam==211010) then
		goal:AddSubGoal( GOAL_COMMON_Wait, ai:GetRandam_Int(1,3), TARGET_ENE_0);
		if fate < 25 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3003, TARGET_ENE_0, DIST_None);
		elseif fate < 50 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3006, TARGET_ENE_0, DIST_None);
		elseif fate < 75 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3011, TARGET_ENE_0, DIST_None);
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3012, TARGET_ENE_0, DIST_None);
		end
		
	elseif 	(idParam==211012) then
		if fate < 25 then
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3003, TARGET_ENE_0, DIST_None);
		elseif fate < 50 then
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3006, TARGET_ENE_0, DIST_None);
		elseif fate < 75 then
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3011, TARGET_ENE_0, DIST_None);
		else
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3012, TARGET_ENE_0, DIST_None);
		end
		
	end

--~ 	goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3003, TARGET_ENE_0, DIST_None);
	
	
	--投擲後、待ち時間。
	
	local wait_time_range	= WaitTime_Short;
	local random_val		= ai:GetRandam_Int( 0, 100);
	if ( random_val < WaitTime_SelectLongRate ) then
		wait_time_range = WaitTime_Long;		--長い待ち。
	else
		wait_time_range = WaitTime_Short;		--短い待ち。
	end
	
	--実際のランダム時間。
	local wait_time = ai:GetRandam_Float( wait_time_range*0.5, wait_time_range*1.5);
	
	--
	goal:AddSubGoal( GOAL_COMMON_Wait, wait_time, TARGET_NONE);
	
	--チームに岩投げ中を通知。
	goal:AddGoalScopedTeamRecord(COORDINATE_TYPE_UROKOIwaSupport, TARGET_NONE, 0);
	
end

function uroko_ThrowRock_Update(ai, goal)return GOAL_RESULT_Continue;end
function uroko_ThrowRock_Terminate(ai, goal)end
function uroko_ThrowRock_Interupt(ai, goal)return false;end










