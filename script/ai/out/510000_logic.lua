--[[*******************************************************************************************
	大蜘蛛用の思考ロジック
	説明： 
	
	主な更新履歴：
		ダメージを食らったら一定時間で、特定行動発動。08/8/3 hasem
	
	
	●ai:SetTimer()の使用状況。
		０：
		１：
		２：
		３：火炎放射アクション（3040）発動までのタイマ。
	
	●ai:SetNumber()の使用状況。
		０：
		１：両触角攻撃回数。
		２：両触角攻撃ガード回数。
		３：火炎放射アクション（3040）発動タイマが設定済みか？（０以外で、設定済み。）
	
	●ai:AddObserveRegion()の使用状況。
		０：火炎アクショントリガー。
		１：
		２：
		３：
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_kumo510000, "kumo510000_Logic", "kumo510000_Interupt");

--[[************************************************************
	汎用を呼び出すだけ。
**************************************************************]]
function kumo510000_Logic(ai)

--[[■企画調整項目■]]
	
	--クモ部屋を覆うサイズのイベント領域。
	local KUMO_ROOM_REGION_ID		= 2070;
	
	--両触角攻撃のガード許容回数。これを超えると大攻撃。
	local FEELER_GUARD_THRESHOLD	= ai:GetRandam_Int(1,3) ;
	
	--両触角攻撃の許容回数。これを超えると大攻撃。
	local FEELER_ATTACK_THRESHOLD	= ai:GetRandam_Int(1,3) ;

--[[■企画調整項目■]]

	--火炎アクショントリガーを設定。
	ai:AddObserveRegion(0, TARGET_ENE_0, KUMO_ROOM_REGION_ID);

	if ( 	FEELER_GUARD_THRESHOLD	<= ai:GetNumber(2) 
		or 	FEELER_ATTACK_THRESHOLD <= ai:GetNumber(1) ) then
		
		--大攻撃実行。
		kumo510000_LOGIC_PowerAttack( ai);
	
	elseif ( not(0==ai:GetNumber(3)) and (ai:GetTimer(3)<=0) ) then
		--火炎タイマ切れなら、火炎攻撃。
	
		--攻撃を設定。
		ai:AddTopGoal(GOAL_kumo510000_Blaze, 100);

	else
		--通常動作。
		COMMON_EasySetup3(ai);
	end
end

--[[************************************************************
	割り込み。
**************************************************************]]
function	kumo510000_Interupt(ai, goal)

--[[■企画調整項目■]]

	--領域に入ってから、火炎放射するまでの時間[sec]。
	local FIRE_COUNTDOWN	= 28;

--[[■企画調整項目■]]


	--領域に入って、まだ発動カウンタが入力されていなければ、
	--タイマーでカウント開始。
	if (ai:IsInterupt( INTERUPT_Inside_ObserveArea )) then
	
		if ( ai:IsInsideObserveRegion(0) ) then
		--設定済みでなければ設定。
			if ( 0==ai:GetNumber(3) ) then
				ai:SetTimer( 3, FIRE_COUNTDOWN);
				ai:SetNumber( 3, 1);
			end
		end
	
	end
end


--[[************************************************************
	クモ、相手のガードに耐えかねて強攻撃。
**************************************************************]]
function	kumo510000_LOGIC_PowerAttack(ai)

	--正面方向？
	if ( ai:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 40) ) then

		ai:AddTopGoal(GOAL_COMMON_Attack2, 100, 3090, TARGET_ENE_0, DIST_None, 0);
	
	--右側？
	elseif ( ai:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) ) then
		
		ai:AddTopGoal(GOAL_COMMON_Attack2, 100, 3070, TARGET_ENE_0, DIST_None, 0);
		
	--左側？
	elseif ( ai:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_L, 180) ) then
		
		ai:AddTopGoal(GOAL_COMMON_Attack2, 100, 3080, TARGET_ENE_0, DIST_None, 0);
		
	end
	
	--カウンタクリア。
	ai:SetNumber( 2, 0);
	ai:SetNumber( 1, 0);
	
end

--[[******************************************************************************************************************]]
--[[**************************************************** サブゴール **************************************************]]
--[[******************************************************************************************************************]]


--[[************************************************************
	火炎放射ゴール。
**************************************************************]]
REGISTER_GOAL(GOAL_kumo510000_Blaze, "kumo510000Blaze");
REGISTER_GOAL_NO_UPDATE( GOAL_kumo510000_Blaze, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_kumo510000_Blaze, true);

function kumo510000Blaze_Activate(ai, goal)
	--攻撃を設定。
	goal:AddSubGoal(GOAL_COMMON_Attack, 100, 3040, TARGET_ENE_0, DIST_None);
end

function kumo510000Blaze_Terminate(ai, goal)
	--カウンタをリセット。
	--	このタイミングまで、カウンタの再スタートがかからないようにする。
	ai:SetTimer(3,0);
	ai:SetNumber(3,0);
end

function kumo510000Blaze_Update(ai, goal) return GOAL_RESULT_Continue; end
function kumo510000Blaze_Interupt(ai, goal) return false; end


--[[************************************************************
	両触角攻撃。
**************************************************************]]
REGISTER_GOAL(GOAL_kumo510000_FeelerAttack, "kumo510000FeelerAttack");
REGISTER_GOAL_NO_UPDATE( GOAL_kumo510000_FeelerAttack, true);

function kumo510000FeelerAttack_Activate(ai, goal)
	--攻撃を設定。
	goal:AddSubGoal(GOAL_COMMON_Attack2, 100, 3050, TARGET_ENE_0, DIST_None, 0);
local count_A = ai:GetNumber(1);
	count_A = count_A +1;
	ai:SetNumber( 1, count_A);
end

function kumo510000FeelerAttack_Terminate(ai, goal)
end

function kumo510000FeelerAttack_Update(ai, goal) return GOAL_RESULT_Continue; end
function kumo510000FeelerAttack_Interupt(ai, goal) 
	
	if ( ai:IsInterupt(INTERUPT_TargetIsGuard) ) then
		--敵がガードしたカウンタをインクリメント。
		local count = ai:GetNumber(2);
		count = count +1;
		ai:SetNumber( 2, count);
	end

	return false; 
end








