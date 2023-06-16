--[[*******************************************************************************************
	ガル・ヴィンランド用戦闘
	説明：

	パラメータ0  なし
	パラメータ1  なし
	パラメータ2  なし
	パラメータ3　なし
	
	●ai:SetNumber()の使用状況。
		０：0で前衛迎撃モード、1で退却モード、2でリープラ護衛モード。
		１：
		２：
		３：
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_GalV816000, "GalV816000_Logic", "GalV816000_Interupt");

--[[*******************************************************
	ロジック。
*********************************************************]]
function GalV816000_Logic(ai)

	--イベントリクエスト０番が０以外で、
	--退却モードへ遷移OK.
	if ( not(-1==ai:GetEventRequest()) ) then
		--まだ、前衛迎撃モードなら。
		if ( 0==ai:GetNumber(0) ) then
			--退却モードへ
			ai:SetNumber(0, 1);
		end
	end

	
	--行動選択。
	if (1==ai:GetNumber(0)) then
		
		--退却。
		--	戦闘中だろうがお構いなし。
		ai:AddTopGoal(GOAL_GalV_816000_Battle_Retreat, -1);

	elseif (ai:IsBattleState()) then
	
		--戦闘状態。
		if ( 0==ai:GetNumber(0) ) then
			--前衛迎撃戦闘。
			ai:AddTopGoal(GOAL_GalV_816000_Battle_Forward, -1);
		else
			--リーブラ護衛戦闘。
			ai:AddTopGoal(GOAL_GalV_816000_Battle_Guard, -1);
		end
		
	else
		--戦闘状態に入っていないから、非戦闘。
		ai:AddTopGoal(GOAL_GalV_816000_NonBattle, -1);
	end
end

--[[*******************************************************
	割り込み。
*********************************************************]]
function GalV816000_Interupt(ai, goal)
end


