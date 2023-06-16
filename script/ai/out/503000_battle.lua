-----------------------------------------------------------------------------------------------
--	嵐の獣専用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_akemono503000_Battle, "akemono503000Battle");


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function akemono503000Battle_Activate(ai, goal)

	local rate0 = ai:GetRandam_Int( 0, 100 );

	local eventNo = ai:GetEventRequest();

	-- 遠方・右への攻撃命令
	if( eventNo == AI_EVENT_FOR_RIGHT )then
		    
			-- 遠方・右叩き
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3000, TARGET_ENE_0, DIST_None, 0);

	-- 遠方・正面へ攻撃命令
	elseif( eventNo == AI_EVENT_FOR_CENTER ) then	
    -- 遠方・正面叩き
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3010, TARGET_ENE_0, DIST_None, 0);
	
    -- 遠方・左へ攻撃命令
	elseif( eventNo == AI_EVENT_FOR_LEFT ) then	
		
	-- 遠方・左叩き
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3020, TARGET_ENE_0, DIST_None, 0);
	
    -- 正面へ攻撃命令
	elseif( eventNo == AI_EVENT_NEAR ) then	
		
        -- 正面払い
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3030, TARGET_ENE_0, DIST_None, 0);
	
	else
		
		-- 待つ
			goal:AddSubGoal( GOAL_COMMON_Wait, 5.0, TARGET_NONE, 0, 0, 0 );	
	end
	
end

---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function akemono503000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function akemono503000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function akemono503000Battle_Interupt(ai, goal)
	
	-- 敵がアイテムを使った場合
	if ai:IsInterupt( INTERUPT_UseItem ) then
		-- ゴールクリア
		goal:ClearSubGoal();

		akemono503000Battle_Activate( ai, goal );
		return true;
	elseif ai:IsInterupt( INTERUPT_MissSwing ) then
		-- ゴールクリア
		goal:ClearSubGoal();
		akemono503000Battle_Activate( ai, goal );
		return true;
	end
	
	return false;
end
