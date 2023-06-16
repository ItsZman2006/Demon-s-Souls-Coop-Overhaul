--[[*******************************************************************************************
	ウロコ鉱夫の思考ロジック
	説明：
		悪鉱夫と違い、仲間・自分が攻撃されるまでは、
		自発的に戦闘状態には入りません。
	
	ai:SetNumber()の用途。
		０：
		１：
		２：
		３：援護のためのリプランニングかどうか。
	
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_urokoF211001, "urokoF211001_Logic", "urokoF211001_Interupt");

--[[*******************************************************
	ウロコ鉱夫用の思考ロジック
*********************************************************]]
function	urokoF211001_Logic(ai)

	--仲間が攻撃されて、ターゲットが追加される事によるリプランニングの場合、
	--ランダムな時間でちょっと待ってから、バトルゴールへ。
	if ( 0~=ai:GetNumber(3)) then
		--気づくまでちょっと待つ。
		local time_rag = ai:GetRandam_Float( 3, 5);
		ai:AddTopGoal( GOAL_COMMON_Stay, time_rag, 0, TARGET_NONE);
		--援護リプランニングフラグを下げる。
		ai:SetNumber( 3, 0);
	end
	
	
	-- 共通関数でロジックを判別
	-- この中で戦闘、非戦闘を判別して設定を行っている。
	UROKO_EasySetup( ai, GOAL_uroko_COMMON_Wait);
end


--[[*******************************************************
	ウロコ鉱夫用の割り込みロジック
*********************************************************]]
function	urokoF211001_Interupt(ai, goal)
	--救援要請受け取り。
	if ( ai:IsInterupt(INTERUPT_FriendRequestSupport)) then
		--１０ｍ以内に救援要請を出している味方がいるか？
		if ( 0 < ai:GetTeamRecordCount( COORDINATE_TYPE_Support, TARGET_NONE, 16) ) then
			--すでに誰かと戦闘状態か？
			if ( false==ai:IsBattleState() ) then 
				--味方を攻撃したターゲットを追加。
				ai:AddFriendAttackedTarget();
				--援護リプランニングの場合のフラグを立てる。
				ai:SetNumber( 3, 1);
			end
		end
	end
end





