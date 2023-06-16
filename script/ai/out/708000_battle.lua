-----------------------------------------------------------------------------------------------
--	要人戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Kaname_708000_Battle, "kaname_708000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Kaname_708000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function kaname_708000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

goal:AddSubGoal( GOAL_COMMON_Wait, 10.0, TARGET_NONE, 0, 0, 0 );

end


---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function kaname_708000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function kaname_708000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function kaname_708000Battle_Interupt(ai, goal)

return false;
end
