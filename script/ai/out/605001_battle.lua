-----------------------------------------------------------------------------------------------
--	ドラゴンデーモン（坑道）専用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_DD605001_Battle, "DD605001Battle");


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function DD605001Battle_Activate(ai, goal)

	
	local fate0 = ai:GetRandam_Int( 0, 100 );
	local eventNo = ai:GetEventRequest();
	local rate = ai:GetHpRate( TARGET_SELF )		--自分のHP
	local state = ai:GetNumber(0);					-- インデックス0でステートを保存しておく

	
	-- 上廊下入口
	if( eventNo == AI_EVENT_PUNCH1 ) then
		-- パンチ1
			goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
			
	-- 上廊下手前
	elseif( eventNo == AI_EVENT_PUNCH2  ) then	
			-- パンチ2
			if state == 0 then
				goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3020, TARGET_ENE_0, DIST_Far, 0);
				-- 次のステートへ 0番インデックスにステート1を設定する
				ai:SetNumber(0, 1);
			else
				goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3010, TARGET_ENE_0, DIST_Far, 0);
			end
			
    -- 上廊下中間
	elseif( eventNo == AI_EVENT_PUNCH3   ) then	
		
			-- パンチ3
			if state == 0 then
				goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3030, TARGET_ENE_0, DIST_Far, 0);
				-- 次のステートへ 0番インデックスにステート1を設定する
				ai:SetNumber(0, 1);
			else
				goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3020, TARGET_ENE_0, DIST_Far, 0);
			end
			
    -- 上廊下奥
	elseif( eventNo == AI_EVENT_PUNCH4) then	
		
			-- パンチ4
			goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3030, TARGET_ENE_0, DIST_Far, 0);
			
	-- 下廊手前
	elseif( eventNo == AI_EVENT_BREATH1) then	
		
			-- ブレス1
			if state == 0 or state == 1 then
				goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3060, TARGET_ENE_0, DIST_Far, 0);
				-- 次のステートへ 0番インデックスにステート2を設定する
				ai:SetNumber(0, 2);
			else
				goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3050, TARGET_ENE_0, DIST_Far, 0);
			end
	
	-- 下廊中間
	elseif( eventNo == AI_EVENT_BREATH2) then	
		
			-- ブレス2
			if state == 0 or state == 1 then
				goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3070, TARGET_ENE_0, DIST_Far, 0);
				-- 次のステートへ 0番インデックスにステート2を設定する
				ai:SetNumber(0, 2);
			else
				goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3060, TARGET_ENE_0, DIST_Far, 0);
			end
			
	-- 下廊奥
	elseif( eventNo == AI_EVENT_BREATH3) then	
		
			-- ブレス3
			if state == 0 or state == 1 then
				goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3080, TARGET_ENE_0, DIST_Far, 0);
				-- 次のステートへ 0番インデックスにステート2を設定する
				ai:SetNumber(0, 2);
			else
				goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3070, TARGET_ENE_0, DIST_Far, 0);
			end
			
	-- 下廊階段
	elseif( eventNo == AI_EVENT_BREATH4) then	
		
			-- ブレス4
			goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3080, TARGET_ENE_0, DIST_Far, 0);
	
	-- 顔の前
	elseif( eventNo == AI_EVENT_BITEATTACK) then	
	
		if rate <= 0.3 then

			--衰弱状態噛み付き１
			goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3140, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal(GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);

		else

			--衰弱吐息ブレス
			goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3130, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal(GOAL_COMMON_Wait, 2.6, TARGET_ENE_0);
		
		end
			
	-- その他
	else
		goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_NONE, 0, 0, 0 );
	end
	
end

---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function DD605001Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function DD605001Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function DD605001Battle_Interupt(ai, goal)
	
	-- 敵がアイテムを使った場合
	if ai:IsInterupt( INTERUPT_UseItem ) then
		-- ゴールクリア
		goal:ClearSubGoal();

		DD605001Battle_Activate( ai, goal );
		return true;
	elseif ai:IsInterupt( INTERUPT_MissSwing ) then
		-- ゴールクリア
		goal:ClearSubGoal();
		DD605001Battle_Activate( ai, goal );
		return true;
	end
	
	return false;
end
