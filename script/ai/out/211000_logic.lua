--[[*********************************************************************************************************
	ウロコ鉱夫（ピックル・非戦）用の思考ロジック
	説明：

	●変更履歴。
	- 08/7/16 hasem
		・悪鉱夫仕様に。
	
	●
	ai:SetNumber()の用途。
		０：＜未使用＞
		１：＜未使用＞
		２：＜未使用＞
		３：援護のためのリプランニングかどうか。
	
	
	ai:AddObserveArea()　監視エリアのスロット。
		０：ターゲットの背後に入ったかどうかの判定用。	
	
***********************************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_urokoP211000, "urokoP211000_Logic", "urokoP211000_Interupt");



--[[*******************************************************************************************
--	ウロコ鉱夫（ピックル・非戦）用の思考ロジック
--	この中で現在の状況を判別し、使用するトップゴールをひとつ決定します。
*********************************************************************************************]]
function	urokoP211000_Logic(ai)

	--仲間が攻撃されて、ターゲットが追加される事によるリプランニングの場合、
	--ランダムな時間でちょっと待ってから、バトルゴールへ。
	if ( 0~=ai:GetNumber(3)) then
		--気づくまでちょっと待つ。
		local time_rag = ai:GetRandam_Float( 3, 5);
		ai:AddTopGoal( GOAL_COMMON_Stay, time_rag, 0, TARGET_NONE);
		--援護リプランニングフラグを下げる。
		ai:SetNumber( 3, 0);
	end
	
	if (false == ai:IsBattleState()) then
		--監視領域に、ターゲットの背後を設定。
		ai:AddObserveArea( 0, TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_B, 90, 4);
	end

	-- 共通関数でロジックを判別
	-- この中で戦闘、非戦闘を判別して設定を行っている。
	UROKO_EasySetup( ai, GOAL_uroko_COMMON_Wait);

end


--[[*******************************************************************************************
--	ウロコ鉱夫（ピックル・非戦）用の割り込みロジック
--	現在の状態でわりこめるのであればtrueを、
--	そのまま無視するのであればfalseを返してください。
*********************************************************************************************]]
function	urokoP211000_Interupt(ai, goal)

	--救援要請受け取り。
	if ( ai:IsInterupt(INTERUPT_FriendRequestSupport)) then
		--１０ｍ以内に救援要請を出している味方がいるか？
		if ( 0 < ai:GetTeamRecordCount( COORDINATE_TYPE_Support, TARGET_NONE, 10) ) then
			--すでに誰かと戦闘状態か？
			if ( false==ai:IsBattleState() ) then 
				--味方を攻撃したターゲットを追加。
				ai:AddFriendAttackedTarget();
				--援護リプランニングの場合のフラグを立てる。
				ai:SetNumber( 3, 1);
			end
		end
		
	elseif (ai:IsInterupt(INTERUPT_Inside_ObserveArea)) then
	
		--０番が引っかかっているか？
		if ( ai:IsInsideObserveArea( 0)) then
			--攻撃を開始してもいい。
			ai:ShiftCurrTargetBattleState();
			--リプランニング。
			ai:Replaning();
			--エリア監視を削除。
			ai:DeleteObserveArea(0);
		end

	end

end


