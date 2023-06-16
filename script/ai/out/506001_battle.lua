-----------------------------------------------------------------------------------------------
--	偽神さまデーモン戦闘
--	説明：
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Nisekamisama506001_Battle, "nisekamisama506001Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Nisekamisama506001_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function nisekamisama506001Battle_Activate(ai, goal)
-------------------------------------------------------------------------------
	
	local targetDist = ai:GetDist( TARGET_ENE_0 );
	
	-- ファイヤーボール
	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, 3010, TARGET_ENE_0, DIST_Far, 0);	
end

---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function nisekamisama506001Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function nisekamisama506001Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function nisekamisama506001Battle_Interupt(ai, goal)

	-- 攻撃された
	if( ai:IsInterupt( INTERUPT_Damaged ) ) then
		goal:ClearSubGoal();
		
		-- 消滅
		goal:AddSubGoal( GOAL_COMMON_Step, 50, 9600, 0, 0, 0 )
		return true;

	end

	return false;
end




	

	