--[[*******************************************************************************************
	ウロコ鉱夫（ピックル・非戦）用戦闘
	説明：

	パラメータ0  なし
	パラメータ1  なし
	パラメータ2  なし
	パラメータ3　なし
*********************************************************************************************]]
REGISTER_GOAL(GOAL_urokoP211000_Battle, "urokoP211000_Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_urokoP211000_Battle, true);


--[[*****************************************************
	ゴール起動
*******************************************************]]
function urokoP211000_Battle_Activate(ai, goal)

	--自分の背後にいる場合は、後ろを攻撃するアニメを。
	if ( ai:IsInsideTargetEx( TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_B, 90, 4 ) ) then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3006, TARGET_ENE_0, DIST_None);
	end

	--攻撃が当たる距離まで、接近する。
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 3, TARGET_ENE_0, false, -1 );

	--攻撃する
	urokoP211000_Battle_Kougeki(ai, goal)
	
	--攻撃後行動
	urokoP211000_Battle_Kougeki_Noato(ai, goal)
end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function urokoP211000_Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--80% 3000
	--20% 3000-3001
	if K_fate < 80 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	
	end
end

	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function urokoP211000_Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local SideDist = 1.0							--横に動く距離
local SideTime = 0.5							--横に動く時間
local BackDist = 1.0							--後退する距離
local BackTime = 0.5							--後退する時間
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






--[[*****************************************************
	ゴール更新（更新しません。）
*******************************************************]]
function urokoP211000_Battle_Update(ai, goal)return GOAL_RESULT_Continue;end

--[[*****************************************************
	ゴール終了
*******************************************************]]
function urokoP211000_Battle_Terminate(ai, goal)
end

--[[*****************************************************
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
*******************************************************]]
function urokoP211000_Battle_Interupt(ai, goal)
	return false;
end


--[[************************************************************************************************************]]
--[[************************************ ウロコ鉱夫サブゴール **************************************************]]
--[[************************************************************************************************************]]



--[[*******************************************************************************************
	ウロコ鉱夫用待ちゴール。
	説明：
		ウロコ鉱夫用の待機時に行うアクションを書く。
		待ち中のランダム性はここで。
		
	パラメータ0  なし。
*********************************************************************************************]]
REGISTER_GOAL(GOAL_uroko_COMMON_Wait, "UROKOWait");
REGISTER_GOAL_NO_UPDATE( GOAL_uroko_COMMON_Wait, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_uroko_COMMON_Wait, true);

--[[*****************************************************
	ゴール起動
*******************************************************]]
function UROKOWait_Activate(ai, goal)

	--パラメータIDで、変化を加える;
	local idParam 	= ai:GetNpcThinkParamID();
	local ezStateNo	= 0;

	
	if 		(idParam==211000) then		ezStateNo	= 3300; --ピッケル
	elseif 	(idParam==211001) then		ezStateNo	= 3301;	--袋
	elseif 	(idParam==211002) then		ezStateNo	= 0;	--小剣
	elseif 	(idParam==211003) then		ezStateNo	= 0;	--大剣
	elseif 	(idParam==211004) then		ezStateNo	= 0;	--ゴクリ手下
	elseif 	(idParam==211006) then		ezStateNo	= 3300;	--ハンマー
	elseif 	(idParam==211007) then		ezStateNo	= 3302;	--素手
	elseif 	(idParam==211008) then		ezStateNo	= 0;	--攻撃型。
	elseif 	(idParam==211009) then		ezStateNo	= 3302;	--岩投げ。
	end


	--アクション前、間。
	local wait_time = ai:GetRandam_Float( 1.0, 3.0);
	goal:AddSubGoal( GOAL_COMMON_Wait, wait_time, TARGET_NONE);
	
	--まちアクション。
	if ( 0<ezStateNo) then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 100, ezStateNo, TARGET_NONE, DIST_None);
	end
	
end

--[[*****************************************************
	ゴール更新・終了・割り込みを行わない。
*******************************************************]]
function UROKOWait_Update(ai, goal) return GOAL_RESULT_Continue; end
function UROKOWait_Terminate(ai, goal) end
function UROKOWait_Interupt(ai, goal) return false; end





			


