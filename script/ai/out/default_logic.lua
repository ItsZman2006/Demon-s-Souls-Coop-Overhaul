-----------------------------------------------------------------------------------------------
--	デフォルトの思考ロジック
--	説明：テストキャラなどに設定してください。
-----------------------------------------------------------------------------------------------
REGISTER_LOGIC_FUNC(LOGIC_ID_Default, "Default_Logic", "Default_Interupt");

-----------------------------------------------------------------------------------------------
--	デフォルトの思考ロジック
--	この中で現在の状況を判別し、使用するゴールをひとつ決定します。
-----------------------------------------------------------------------------------------------
function	Default_Logic(ai)

	if ai:IsSearchTarget(TARGET_ENE_0) == true then
		-- 敵を見つけていたら戦闘
		ai:AddTopGoal( GOAL_COMMON_Normal, -1, 0,0,0,0 );
		return;
	end;
	
	ai:AddTopGoal( GOAL_COMMON_WalkAround, -1, ai:GetDistParam(DIST_Far),0,0,0 );
	return;
end


-----------------------------------------------------------------------------------------------
--	デフォルトの割り込みロジック
--	割り込み判定を行ってゴールを追加します。
-----------------------------------------------------------------------------------------------
function	Default_Interupt(ai, goal)
end
