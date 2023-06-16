-----------------------------------------------------------------------------------------------
--	神さまデーモン戦闘
--	説明：
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Kamisama506000_Battle, "kamisama506000Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Kamisama506000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function kamisama506000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------
	
	local targetDist = ai:GetDist( TARGET_ENE_0 );
	
	-- 魔法陣を発動させていない場合
	if( ai:GetNumber( 0 ) <= 0.0 ) then
		goal:AddSubGoal( GOAL_COMMON_Attack, 50.0, 3300, TARGET_ENE_0, DIST_None, 0);	
		ai:SetNumber( 0, 1.0 );
	end
	
	-- ファイヤーボール
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, 3000, TARGET_ENE_0, DIST_Far, 0);	
end

---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function kamisama506000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function kamisama506000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function kamisama506000Battle_Interupt(ai, goal)

	-- 攻撃された
	if( ai:IsInterupt( INTERUPT_Damaged ) ) then
		goal:ClearSubGoal();
		
		-- 瞬間移動
		goal:AddSubGoal( GOAL_COMMON_Step, 10.0, 9010, 0, 0, 0 )
		
		-- 魔方陣配置フラグのリセット
		ai:SetNumber( 0, -1.0 );
		return true;
	end

	return false;
end




	

	