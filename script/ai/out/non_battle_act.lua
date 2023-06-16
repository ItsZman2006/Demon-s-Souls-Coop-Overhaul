--[[*******************************************************************************************
	非戦闘行動
	説明：非戦闘行動

	パラメータ0  	敵に反応する距離[m]
	パラメータ1  	敵を見つけていたら終了（距離に関係ない）
	パラメータ2  	走る？
	パラメータ3		旋回ターゲット。デフォルト：TARGET_ENE_0 (0)
	パラメータ4		巣の到着距離[m]
	パラメータ5		待機時ゴール。０なら、Stay
*********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_NonBattleAct, "NonBattleAct");

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonBattleAct, 0, "敵に反応する距離【m】", 		0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonBattleAct, 1, "敵いたら終了？", 				0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonBattleAct, 2, "走る？", 						0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonBattleAct, 3, "旋回【TYPE】", 				0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonBattleAct, 4, "巣の到着距離【m】",			0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonBattleAct, 5, "待機時ゴール",				0);

	
-- 更新間隔設定
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_NonBattleAct, 0.1, 0.2);



--[[*****************************************************
	ゴール起動
*******************************************************]]
function NonBattleAct_Activate(ai, goal)

	local idx 		= ai:GetMovePointNumber();			-- 現在の移動ポイントがあるか
	local pointDist = ai:GetMovePointEffectRange();		-- 移動ポイントからの影響範囲
	local isWalk	= (0==goal:GetParam(2));			-- 歩く？]
	local turn_tgt	= goal:GetParam(3);					-- 旋回ターゲット。
	
	if idx >= 0 then
		-- 移動ポイントあり
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, goal:GetLife(), POINT_MOVE_POINT, AI_DIR_TYPE_CENTER, 0.0, TARGET_SELF, isWalk);

		-- 到着したときの行動をここに列挙する
		-- お試し
		--goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_NONE, 0,0,0 );
	else
	
		local arrive_dist = goal:GetParam(4);
		if ( arrive_dist==0 ) then 
			--０の場合は、今までどおりデフォルトの５ｍ。
			arrive_dist = 5;
		end
	
		if (pointDist > arrive_dist) then
			-- 移動ポイントなし 初期位置に戻る
			goal:AddSubGoal( GOAL_COMMON_BackToHome, goal:GetLife(), 0,0,0,0 );
		else
		
			--待機時アクションIDが入っていたら、Attackで実行。
			local wait_goalID = goal:GetParam(5);
			if ( 0<wait_goalID) then
				--アクション実行。
				goal:AddSubGoal( wait_goalID, goal:GetLife());
			else
				-- その場で待機
				goal:AddSubGoal( GOAL_COMMON_Stay, goal:GetLife(), 0, turn_tgt);
			end
			
		end
	end
end

--[[*****************************************************
	ゴール更新は、cpp側で実装してある。
	ゴール終了は何もない。
*******************************************************]]
function NonBattleAct_Update(ai, goal)	return GOAL_RESULT_Continue; end
function NonBattleAct_Terminate(ai, goal) end


--[[*****************************************************
	割り込み
	割り込んだ場合にはtrueを返してください。
	ここで割り込み用のサブゴールを追加してください。
	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
*******************************************************]]
function NonBattleAct_Interupt(ai, goal)

	-- いまのところフラグがないのでタイマーで代用
	-- タイマーを設定しているのは、Updateで失敗を返したいから
	-- なぜFAILEDを返したいのかは不明

	local isDamaged = false;
	isDamaged = isDamaged or ai:IsInterupt( INTERUPT_Damaged_Stranger );	-- 知らない人に殴られたら
	isDamaged = isDamaged or ai:IsInterupt( INTERUPT_Damaged );				-- ダメージを食らったら
	
	if (isDamaged) then
		goal:SetTimer( 1, 99999 );		
		return true;
	end

	return false;
end
