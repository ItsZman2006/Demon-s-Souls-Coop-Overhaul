--[[*******************************************************************************************
	Kimera304000専用戦闘
	説明：

	パラメータ0  なし
	パラメータ1  なし
	パラメータ2  なし
	パラメータ3　なし
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Kimera304000_Battle, "Kimera304000Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Kimera304000_Battle, 1 );


--[[*****************************************************
	ゴール起動
*******************************************************]]
function Kimera304000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離
local fate = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　その２
local maai = ai:GetRandam_Float(0.75, 1.5)				--間合い調整する距離

local farDist = 12.0		--遠いと判断する距離
local nearDist = 6.0		--近いと判断する距離
local maaiDist = 3.1		--攻撃のために近づく距離　★汎用化の為、攻撃ごとに分けず★
local skyDist = 1.5			--空中から接近する為の距離


	--遠いとき
	if targetDist >= farDist then
		if ai:IsFlying() == true then
			goal:AddSubGoal( GOAL_Kimera304000_Battle_FlyLeaveAndApproach, 20, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
		end
		
	--近くないなら
	elseif targetDist >= nearDist then
		--75％　接近
		--25％　待機
		if fate < 50 then
--			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			if ai:IsFlying() == true then
				goal:AddSubGoal( GOAL_Kimera304000_Battle_FlyLeaveAndApproach, 20, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
			end
			
		elseif fate < 75 then

			if ai:IsFlying() == true then
				goal:AddSubGoal( GOAL_Kimera304000_Battle_FlyLeaveAndApproach, 20, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_NONE, 0, 0, 0 );
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 13010, TARGET_ENE_0, DIST_Near, 0 );
			end
	
		else
			goal:AddSubGoal(GOAL_COMMON_Wait,2.0,TARGET_ENE_0, 0, 0, 0 );
			if ai:IsFlying() == true then
				Kimera304000Battle_FlyAttack(ai, goal);
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 13030, TARGET_ENE_0, DIST_Near, 0);
			end
		end

	--近いなら
	elseif targetDist >= maaiDist then
		--60％　走り接近→再接近
		--40％　接近→攻撃
		if fate < 60 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
			if fate2 < 50 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
			end
		else
			goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, maaiDist, nearDist, TARGET_ENE_0, true, -1 );
			if ai:IsFlying() == true then
				Kimera304000Battle_FlyAttack(ai, goal);
			else
				if targetDist < maaiDist then
					goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 13000, TARGET_ENE_0, DIST_Near, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13040, TARGET_ENE_0, DIST_Near, 0);	
				end
			end
		end

	else
	--間合い以内なら
		--攻撃する
		--攻撃後行動
		Kimera304000Battle_Kougeki(ai, goal)
		Kimera304000Battle_Kougeki_Noato(ai, goal)
	end
end

---------------------------------------------------------
--  空中攻撃。
---------------------------------------------------------
function Kimera304000Battle_FlyAttack(ai, goal)

	local targetDist 	= ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離
	local NEAR_DIST		= 6.0;		--近いと判断する距離
	
	if (targetDist < NEAR_DIST) or (AI_EVENT_KIMERA_TALE_CUT==ai:GetEventRequest(0))  then
		goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3010, TARGET_ENE_0, DIST_None, 0);
	end
end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function Kimera304000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--空中
	--50% 3000　咆哮（空）
	--50% 3010　蛇が魔法（空）
	--地上
	--20% 13000　右振り下ろし（地）
	--20% 13010　両手振り下ろし（地）
	--00% 13020　右殴り（地 切替し）
	--15% 304000 悲鳴（地）
	--25% 13030　咆哮（地）
	--30% 13040　タックル（地）
	if ai:IsFlying() == true then
		if ( (K_fate < 50) or (AI_EVENT_KIMERA_TALE_CUT==ai:GetEventRequest(0)) ) then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Near, 0);
		end
	else
		if K_fate < 40 then
			Kimera304000Battle_Kougeki_Riku_Ude(ai, goal)
		elseif K_fate < 55 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13030, TARGET_ENE_0, DIST_Near, 0);
		elseif K_fate < 70 then
			if(  (ai:GetTeamRecordCount(COORDINATE_TYPE_KIMERAbite, TARGET_NONE, 100) <= 0) 
				and ( AI_EVENT_KIMERA_TALE_CUT ~= ai:GetEventRequest(0)) ) then
				goal:AddSubGoal(GOAL_Kimera304000_Battle_Bite, 10);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13040, TARGET_ENE_0, DIST_Near, 0);
			end
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13040, TARGET_ENE_0, DIST_Near, 0);
		end
	end
end
	
	
---------------------------------------------------------
--  攻撃・腕
---------------------------------------------------------
function Kimera304000Battle_Kougeki_Riku_Ude(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離
local hprate = ai:GetHpRate( TARGET_SELF )		--自分のHP割合を取得
local fate = ai:GetRandam_Int(1,100)			--確率判定用
local fate2 = ai:GetRandam_Int(1,100)			--確率判定用2
local fate3 = ai:GetRandam_Int(1,100)			--確率判定用3
local fate4 = ai:GetRandam_Int(1,100)			--確率判定用4

--[[片腕(遠)両腕(近)を使い分けるため、さらに距離を判定]]
local nearDist = 1.7							--近いと判断して、両腕で殴る距離

--[[HPの残り割合を見て腕の強攻撃頻度を変える]]

local		HPLevel1 = 0.75						--HPの残量レベル１　75%以上
local		HPLevel2 = 0.50						--HPの残量レベル２	50%以上		
local		HPLevel3 = 0.25						--HPの残量レベル３	25%以上
local		HPLevel4 = 0.0						--HPの残量レベル４	0%以上

local		LargeAttackPer1 = 10				--HP残量レベル１のときの強攻撃の確率
local		LargeAttackPer2 = 30				--HP残量レベル２のときの強攻撃の確率
local		LargeAttackPer3 = 70				--HP残量レベル３のときの強攻撃の確率
local		LargeAttackPer4 = 90				--HP残量レベル４のときの強攻撃の確率


	if hprate >= HPLevel1 then
		
		if (fate <= LargeAttackPer1) then
			if targetDist < nearDist then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13010, TARGET_ENE_0, DIST_Near, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13000, TARGET_ENE_0, DIST_Near, 0);	
			end
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13000, TARGET_ENE_0, DIST_Near, 0);	
		end
	
	elseif hprate >= HPLevel2 then
	
		if (fate2 <= LargeAttackPer2) then
			if targetDist < nearDist then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13010, TARGET_ENE_0, DIST_Near, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13000, TARGET_ENE_0, DIST_Near, 0);	
			end
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13000, TARGET_ENE_0, DIST_Near, 0);	
		end	
	
	elseif hprate >= HPLevel3 then
	
		if (fate3 <= LargeAttackPer3) then
			if targetDist < nearDist then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13010, TARGET_ENE_0, DIST_Near, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13000, TARGET_ENE_0, DIST_Near, 0);	
			end
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13000, TARGET_ENE_0, DIST_Near, 0);	
		end	
	
	else
		
		if (fate4 <= LargeAttackPer4) then
			if targetDist < nearDist then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13010, TARGET_ENE_0, DIST_Near, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13000, TARGET_ENE_0, DIST_Near, 0);	
			end
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 13000, TARGET_ENE_0, DIST_Near, 0);	
		end

	end
end
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function Kimera304000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local SideTime = 2.0							--横に動く時間
local BackDist = ai:GetRandam_Float(0.75, 1.5)	--後退する距離
local BackTime = 1.0							--後退する時間


local bRight = ai:GetRandam_Int(0,1);							--左右移動の方向
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- 同じ方向に左右移動している仲間の数



--後ろに下がった後にときどき横移動させると良いかも
--あまりに近すぎる横移動よりも、すこし下がってから横移動させると良いかも

	--25% なにもしない（ちょっとだけ横移動）
	--50% 適当に横に移動
	--25% 後ろに移動
	if KN_fate < 25  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 10, true, true ,-1 );
	elseif KN_fate < 75  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end



---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function Kimera304000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function Kimera304000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function Kimera304000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);				--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字
local fate3 = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字
local maaiDist = 1.0	


	-- ダメージ食らったときの対応
	if ai:IsInterupt( INTERUPT_Damaged ) then
		--飛んでいなくて、距離が近いなら一定確率で攻撃
		if targetDist <= 1.5 and fate <= 30 and ai:IsFlying() == false then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 13040, TARGET_ENE_0, DIST_Near, 0);
			return true;
			
		--飛んでいなくて、距離が近くて、一定確率なら何もしない	
		elseif targetDist <= 1.5 and fate > 30 and ai:IsFlying() == false then
			
		--それ以外なら、今まで通りリプランニング		
		else
			goal:ClearSubGoal();
			Kimera304000Battle_Activate(ai, goal);
			return true;
		end
	end

	--空振り追い討ち
	--25％　近くのターゲットが空振りしたら攻撃
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < 3.5 then
			if fate <= 25 then
				goal:ClearSubGoal();
				Kimera304000Battle_Kougeki(ai, goal)
				Kimera304000Battle_Kougeki_Noato(ai, goal)
				return true;
			end	
		end
	end
	
	
	--アイテムを使ったら最適行動
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 30				--アイテム使用時に最適行動を取る確率
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();
			if ai:IsFlying() == true then
				goal:AddSubGoal( GOAL_Kimera304000_Battle_FlyLeaveAndApproach, 20, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 13010, TARGET_ENE_0, DIST_Near, 0 );
			end
			return true
		end
	end	
	
	
	--飛び道具を撃ってきたら最適行動
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer_near = 40					--飛び道具使用時に最適行動を取る確率(近い)
local shootIntPer_near_fly = 10				--飛び道具使用時に最適行動を取る確率(近い＆飛んでいる)
local shootIntPer_far = 80					--飛び道具使用時に最適行動を取る確率(遠い)
local shootIntPer_far_fly = 20				--飛び道具使用時に最適行動を取る確率(遠い＆飛んでいる)
local nearDist = 9.0						--近いときの距離
local LockOnDist = 15.0						--PCがキメラをロックオンできる距離

	--近いときタックル
		if targetDist < nearDist then 
			if fate < shootIntPer_near then
--				goal:ClearSubGoal();
				if ai:IsFlying() == true then
					if fate2 < shootIntPer_near_fly then
						goal:ClearSubGoal();
						if fate3 < 30 then
							goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0 );
						elseif fate < 60 then
							goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Near, 0 );
						else
							goal:AddSubGoal( GOAL_Kimera304000_Battle_FlyLeaveAndApproach, 20, 0);
						end
						return true;
					end
				else
					goal:ClearSubGoal();
					goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.0,1.0) ,0,0,0,0)
					goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 13040, TARGET_ENE_0, DIST_Near, 0 );
					return true;
				end
			end
			
	--遠いとき咆哮
		else
			if fate < shootIntPer_far then
			--	goal:ClearSubGoal();
				if ai:IsFlying() == true then
					if fate2 < shootIntPer_far_fly and targetDist < LockOnDist then
						goal:ClearSubGoal();
						if fate3 < 30 then
							goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0 );
						elseif fate < 60 then
							goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Near, 0 );
						else
							goal:AddSubGoal( GOAL_Kimera304000_Battle_FlyLeaveAndApproach, 20, 0);
						end
						return true;
					end
				else
					if targetDist < 15 then
					goal:ClearSubGoal();
						goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.0,1.0) ,0,0,0,0)	
						if fate2 < 35 then
							goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 13040, TARGET_ENE_0, DIST_Near, 0 );
						else
							goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 13030, TARGET_ENE_0, DIST_Near, 0 );
						end
					end
					return true;
				end
			end
			
		end
	end
	
--~ 		if fate <= shootIntPer then
--~ 			goal:ClearSubGoal();
--~ 			if ai:IsFlying() == true then
--~ 				goal:AddSubGoal( GOAL_Kimera304000_Battle_FlyLeaveAndApproach, 20, 0);
--~ 			else
--~ 				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
--~ 				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 13010, TARGET_ENE_0, DIST_Near, 0 );
--~ 			end
--~ 			return true;
--~ 		end
--~ 	end

return false;

end




--*****************************************************************************************
--********************* 以下キメラ用噛み付きアクションサブゴール **************************
--*****************************************************************************************

--[[***************************************************************************
	噛み付き。
	・噛み付く
	・一定時間or攻撃を受けるで、解除。
	
	パラメータなし。
	
	使用方法
		goal:AddSubGoal( GOAL_Kimera304000_Battle_Bite, 寿命);
	
*****************************************************************************]]

REGISTER_GOAL(GOAL_Kimera304000_Battle_Bite, "Kimera304000Battle_Bite");
REGISTER_GOAL_NO_UPDATE( GOAL_Kimera304000_Battle_Bite, true );
REGISTER_GOAL_NO_INTERUPT( GOAL_Kimera304000_Battle_Bite, true );

function Kimera304000Battle_Bite_Activate( ai, goal)

	--噛み付き。
	goal:AddSubGoal( GOAL_Kimera304000_Battle_BiteAction, goal:GetLife());
	
	--チームに噛み付き中なのをお知らせ。
	goal:AddGoalScopedTeamRecord(COORDINATE_TYPE_KIMERAbite, TARGET_NONE, 0);
end

function Kimera304000Battle_Bite_Update(ai, goal)return GOAL_RESULT_Continue;end
function Kimera304000Battle_Bite_Terminate(ai, goal)end
function Kimera304000Battle_Bite_Interupt(ai, goal)	return false; end

--[[***************************************************************************
	噛み付き。
*****************************************************************************]]
REGISTER_GOAL(GOAL_Kimera304000_Battle_BiteAction, "Kimera304000Battle_BiteAct");
REGISTER_GOAL_UPDATE_TIME( GOAL_Kimera304000_Battle_BiteAction, 0, 0);

function Kimera304000Battle_BiteAct_Activate( ai, goal)
	goal:SetNumber( 0, 304000);
end

function Kimera304000Battle_BiteAct_Update(ai, goal)

	-- ガード終わった
	local 	bFinish 	= ai:IsFinishAttack();
	bFinish = bFinish or ai:IsEnableComboAttack();
	if ( bFinish ) then
		return GOAL_RESULT_Success;
	end

	-- 寿命尽きたら成功にする
	if ( goal:GetLife() <= 0) then
		return GOAL_RESULT_Success;
	end
	
	-- ダメージを受けていたら、即終了。
	if ( 0~=goal:GetNumber(1) ) then
		return GOAL_RESULT_Success;
	end
	
	-- 空中にいたら即終了
	if ai:IsFlying() == true then
		return GOAL_RESULT_Success;
	end

	-- 時間が切れるまでかみ続ける。
	local ActNo = goal:GetNumber(0);
	ai:SetAttackRequest( ActNo);
	
	return GOAL_RESULT_Continue;
end

function Kimera304000Battle_BiteAct_Terminate(ai, goal)end
function Kimera304000Battle_BiteAct_Interupt(ai, goal)	
	if ai:IsInterupt( INTERUPT_Damaged ) then
		ai:SetAttackRequest(-1);
		goal:SetNumber( 0, -1);
		goal:SetNumber( 1, 1);
	end
	return false;
end






--*****************************************************************************************
--********************* 以下キメラ用空中ポイント移動サブゴール ****************************
--*****************************************************************************************


--[[***************************************************************************
	空中巡回ポイントに移動
	⇒	着地点に移動
	
	パラメータなし。
	
	使用方法
	@code
		goal:AddSubGoal( GOAL_Kimera304000_Battle_FlyLeaveAndApproach, 寿命);
	@endcode
	
*****************************************************************************]]
REGISTER_GOAL(GOAL_Kimera304000_Battle_FlyLeaveAndApproach, "Kimera304000FlyLeaveAndApproach");
REGISTER_GOAL_NO_UPDATE( GOAL_Kimera304000_Battle_FlyLeaveAndApproach, 1 );
REGISTER_GOAL_NO_INTERUPT( GOAL_Kimera304000_Battle_FlyLeaveAndApproach, true );

function Kimera304000FlyLeaveAndApproach_Activate(ai, goal)

	--↓寿命を適当に設定してください。
	
	goal:AddSubGoal( GOAL_Kimera304000_Battle_FlyLeave, 6, 0);
	goal:AddSubGoal( GOAL_Kimera304000_Battle_FlyApproach, 10, 0);
end

function Kimera304000FlyLeaveAndApproach_Update(ai, goal)return GOAL_RESULT_Continue;end
function Kimera304000FlyLeaveAndApproach_Terminate(ai, goal)end
function Kimera304000FlyLeaveAndApproach_Interupt(ai, goal)	return false;end




--[[***************************************************************************
	空中巡回ポイントに移動
	パラメータなし。
*****************************************************************************]]
REGISTER_GOAL(GOAL_Kimera304000_Battle_FlyLeave, "Kimera304000FlyLeave");
REGISTER_GOAL_NO_UPDATE( GOAL_Kimera304000_Battle_FlyLeave, 1 );
REGISTER_GOAL_NO_INTERUPT( GOAL_Kimera304000_Battle_FlyLeave, true );

function Kimera304000FlyLeave_Activate(ai, goal)
	--移動ポイントタイプを変更＆そのポイントタイプでの次の点を設定。
	ai:SetMovePointType( POINT_MOVE_TYPE_Gargoyle_Air_Patrol);
	ai:StepNextMovePoint();
	
	--ポイント移動。
	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 20, POINT_MOVE_POINT, 0, TARGET_SELF, false, -1);
end

function Kimera304000FlyLeave_Update(ai, goal)	return GOAL_RESULT_Continue;end
function Kimera304000FlyLeave_Terminate(ai, goal)end
function Kimera304000FlyLeave_Interupt(ai, goal) return false;end


--[[***************************************************************************
	地上着地点ポイントに移動
	パラメータなし。
*****************************************************************************]]
REGISTER_GOAL(GOAL_Kimera304000_Battle_FlyApproach, "Kimera304000FlyApproach");
REGISTER_GOAL_NO_UPDATE( GOAL_Kimera304000_Battle_FlyApproach, 1 );
REGISTER_GOAL_NO_INTERUPT( GOAL_Kimera304000_Battle_FlyApproach, true );

function Kimera304000FlyApproach_Activate(ai, goal)
	--移動ポイントタイプを変更＆そのポイントタイプでの次の点を設定。
	ai:SetMovePointType( POINT_MOVE_TYPE_Gargoyle_Landing);
	ai:StepNextMovePoint();
	
	--ポイント移動。
	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 20, POINT_MOVE_POINT, 0, TARGET_SELF, false, -1);
end

function Kimera304000FlyApproach_Update(ai, goal)	return GOAL_RESULT_Continue;end
function Kimera304000FlyApproach_Terminate(ai, goal)end
function Kimera304000FlyApproach_Interupt(ai, goal) return false;end


