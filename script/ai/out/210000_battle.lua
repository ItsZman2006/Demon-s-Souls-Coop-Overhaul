-----------------------------------------------------------------------------------------------
--	Huhai210000専用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Huhai210000_Battle, "Huhai210000Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Huhai210000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function Huhai210000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離
local fate = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　その３
local sekkin = ai:GetRandam_Float(0.75, 1.5)			--接近する距離
local maai = ai:GetRandam_Float(0.75, 1.5)				--間合い調整する距離
local rate = ai:GetHpRate( TARGET_SELF )				--自分のHP
local idParam = ai:GetNpcThinkParamID();				--NPCのIDを取得

local farDist = 10.0		--遠いと判断する距離
local nearDist = 5.0		--近いと判断する距離
local maaiDist = 3.0		--攻撃のために近づく距離　★汎用化の為、攻撃ごとに分けず★

	-- 最初にちょっとだけ待つ
	if ai:IsFinishTimer(0) == true then
		local firstTime = ai:GetRandam_Float(0.0, 2.0)			--最初の動き出しまでの時間
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
		ai:SetTimer( 0, 9999.0 );
	end

	--遠いなら
	if targetDist >= nearDist then
		--10％　歩き接近
		--35％　歩きから走り接近
		--55％　走り接近
		if fate < 10 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
		elseif fate < 45 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, (targetDist - 3.0), TARGET_ENE_0, true, -1 );
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );			
		else
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
		end
		
	--近いなら
	elseif targetDist >= maaiDist then
		--60％　歩き接近→回り込み＆再接近　　40％　距離保つ→70%突進体当たり30%攻撃（中）�
		if fate < 60 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			if fate2 < 20 then
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(10,20), true, true ,-1 );
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			end
		else
			goal:AddSubGoal( GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, 3.0, 5.0, TARGET_ENE_0, false, -1 );
			if fate2 < 70 then
				if 		(idParam==210004) then		
					goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3004, TARGET_ENE_0, DIST_Near, 0);
				end
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
			end
		end
		
	else
	--間合い以内なら
		--攻撃する
		--攻撃後行動
		Huhai210000Battle_Kougeki(ai, goal)
		Huhai210000Battle_Kougeki_Noato(ai, goal)
	end
end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function Huhai210000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local rate = ai:GetHpRate( TARGET_SELF )
local idParam = ai:GetNpcThinkParamID();				--NPCのIDを取得

	--20% 3000　攻撃（小）（HPが50%以下なら突進体当たり）
	--10% 3003　突き落とす
	--15% 3004　突進体当たり
	--20% 3000-3001　攻撃（小）＆攻撃（中）�
	--15% 3002　暴れる
	--20% 3300　両手攻撃
	if K_fate < 20 then
		if rate < 0.5 then
			if 		(idParam==210004) then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Near, 0);
			end
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		end
	elseif K_fate < 30 then
		if 		(idParam==210004) then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Near, 0);
		end
	elseif K_fate < 45 then
		if 		(idParam==210004) then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Near, 0);
		end
	elseif K_fate < 65 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Near, 0);
	elseif K_fate < 80 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Near, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Near, 0);
	end
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function Huhai210000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local SideTime = 0.5							--横に動く時間
local BackDist = ai:GetRandam_Float(0.25, 1.0)	--後退する距離
local BackTime = 0.5							--後退する時間


local bRight = ai:GetRandam_Int(0,1);							--左右移動の方向
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- 同じ方向に左右移動している仲間の数



--後ろに下がった後にときどき横移動させると良いかも
--あまりに近すぎる横移動よりも、すこし下がってから横移動させると良いかも

	--25% なにもしない（ちょっとだけ横移動）
	--50% 適当に横に移動
	--25% 後ろに移動
	if KN_fate < 25  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 0.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 10, true, true ,-1 );
	elseif KN_fate < 75  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end



---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function Huhai210000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function Huhai210000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function Huhai210000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字
local maaiDist = 1.0										--攻撃のために近づく距離　★汎用化の為、攻撃ごとに分けず★

	--空振り追い討ち
	--25％　近くのターゲットが空振りしたら攻撃
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < maaiDist then
			if fate <= 25 then
				goal:ClearSubGoal();
				Huhai210000Battle_Kougeki(ai, goal)
				Huhai210000Battle_Kougeki_Noato(ai, goal)
				return true;
			end	
		end
	end

return false;

end










--[[************************************************************************************************************]]
--[[**************************************** 腐敗人サブゴール **************************************************]]
--[[************************************************************************************************************]]



--[[*******************************************************************************************
	腐敗人用待ちゴール。
	説明：
		腐敗人用の待機時に行うアクションを書く。
		待ち中のランダム性はここで。
		
	パラメータ0  なし。
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Huhai_COMMON_Wait, "HUHAIWait");
REGISTER_GOAL_NO_UPDATE( GOAL_Huhai_COMMON_Wait, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_Huhai_COMMON_Wait, true);

--[[*****************************************************
	ゴール起動
*******************************************************]]
function HUHAIWait_Activate(ai, goal)

	--パラメータIDで、変化を加える;
	local idParam 	= ai:GetNpcThinkParamID();
	local ezStateNo	= 0;

	
	if 		(idParam==211000) then		ezStateNo	= 3300; --ピッケル
	elseif 	(idParam==211001) then		ezStateNo	= 3301;	--袋
	elseif 	(idParam==211002) then		ezStateNo	= 3302;	--小剣
	elseif 	(idParam==211003) then		ezStateNo	= 3302;	--大剣
	elseif 	(idParam==211004) then		ezStateNo	= 0;	--ゴクリ手下
	end


	--アクション前、間。
	local wait_time = ai:GetRandam_Float( 0.5, 2.5);
	goal:AddSubGoal( GOAL_COMMON_Wait, wait_time, TARGET_NONE);
	
	--まちアクション。
	if ( 0<ezStateNo) then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 100, ezStateNo, TARGET_NONE, DIST_None);
	end
	
end

--[[*****************************************************
	ゴール更新・終了・割り込みを行わない。
*******************************************************]]
function HUHAIWait_Update(ai, goal) return GOAL_RESULT_Continue; end
function HUHAIWait_Terminate(ai, goal) end
function HUHAIWait_Interupt(ai, goal) return false; end





			


