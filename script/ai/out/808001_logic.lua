--[[*******************************************************************************************
	王城４ビヨロジック
	説明：
	　・ドラゴンが前の城壁に出ている時は、攻撃しない。（イベントリクエスト０が、-1以外になる。）
	　・指定の戦闘領域(EvID:2730)からターゲットが出たら、攻撃しない。
	
	TIPS：
	　・王城４でビヨを出すためには、イベントフラグ：16072を立てて入る。
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_Biyo808001, "Biyo808001_Logic", "Biyo808001_Interupt");

--[[***********************************************************************
	ロジック。
*************************************************************************]]
function Biyo808001_Logic(ai)

--[[■調整項目■]]

	local 	BATTLE_REGION_EVID	= 2730;		--戦闘領域。

--[[■調整項目■]]

	if ( 	ai:IsInsideTargetRegion(TARGET_ENE_0, BATTLE_REGION_EVID) 
		and ai:IsSearchTarget(TARGET_ENE_0)
		and (-1==ai:GetEventRequest())) then
		
		--戦闘領域内なので、戦闘。
		ai:AddTopGoal(GOAL_Biyo_808000_Battle, -1);
	
	else
		--NonBattleActのActivateから。。。
		local pointDist = ai:GetMovePointEffectRange();		-- 移動ポイントからの影響範囲
		if (pointDist<3) then
			-- その場で待機
			ai:AddTopGoal( GOAL_COMMON_Stay, 10, 0, POINT_INIT_POSE);
		else
			-- 移動ポイントなし 初期位置に戻る
			ai:AddTopGoal( GOAL_COMMON_BackToHome, 10, 0);
		end
	end
end

--[[***********************************************************************
	割り込み。
*************************************************************************]]
function Biyo808001_Interupt(ai, goal)
end


