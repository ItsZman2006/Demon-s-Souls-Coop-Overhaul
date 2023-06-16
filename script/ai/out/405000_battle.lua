-----------------------------------------------------------------------------------------------
--	Honokaijin405000専用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Honokaijin405000_Battle, "Honokaijin405000Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Honokaijin405000_Battle, 1 );

---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function Honokaijin405000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

-- 基本情報
local hpRate 		= ai:GetHpRate( TARGET_SELF )		--自分のHP割合を取得
local targetHpRate 	= ai:GetHpRate( TARGET_ENE_0)	--敵ターゲットのHP割合を取得
local targetDist 	= ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得

-- ランダム情報
local fate 	= ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字　その２
local fate3	= ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字　その３
local fate4	= ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字　その４
local fate5	= ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字　その5

-- 攻撃を行う上でベストな距離
local nearAtkDist	= ai:GetRandam_Float( 1.0, 1.2 );	-- 近距離のベスト攻撃範囲
local middleAtkDist	= ai:GetRandam_Float( 5.1, 5.5 );	-- 中距離のベスト攻撃範囲
local farAtkDist	= ai:GetRandam_Float( 7.0, 8.1 );	-- 遠距離のベスト攻撃範囲

-- 連続攻撃用情報
local isGuard = ai:IsTargetGuard( TARGET_ENE_0 );
 
local nearMaai = ai:GetRandam_Float(3.0, 6.0)
	--近距離間合い（ｍ）
local middleSekkin = ai:GetDistParam(DIST_Middle) - 1.0
	--中距離接近用（ｍ）
local maaiTime = ai:GetRandam_Float(2.0, 4.0)
	--間合いを取る行動の寿命（sec）

local approachDist = ai:GetRandam_Float( 4.5, 5.1 );
	

local	lv = 1;	-- 攻撃レベル
	--------------------------------------------------------------
	-- 自分のＨＰから攻撃Ｌｖを設定する
	--------------------------------------------------------------
	-- Ｌｖ３
	if( hpRate <= 0.3 ) then
		lv = 3
	-- Ｌｖ２
	elseif( hpRate <= 0.6 ) then
		lv = 2
	-- Ｌｖ１
	else
		lv = 1
	end
	
	
	
	--------------------------------------------------------------
	-- イベントから命令を受けて身震いリアクション
	--------------------------------------------------------------
	
	if( eventNo == AI_EVENT_REACTION )then 	
		goal:AddSubGoal( GOAL_COMMON_Turn, 2, TARGET_ENE_0 );
		goal:AddSubGoal(GOAL_COMMON_Step, 5, 701, 0, 0, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 9920, TARGET_ENE_0, DIST_None, 0);
		--return;
	end
	--------------------------------------------------------------
	-- 後ろにターゲットがいたら後ろ振り向き攻撃
	--------------------------------------------------------------
	
	if ( ai:IsInsideTargetEx( TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_B, 30, 10)) then
	--自分の後方３０度・１０ｍ以内にいたら
    
	goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 3.0, 3060, TARGET_ENE_0, DIST_None, 0);
	--振り向き攻撃
    
    end

	--------------------------------------------------------------
	-- 条件：敵ターゲットが殴れる範囲にいる場合
	-- Desc：近接攻撃
	--------------------------------------------------------------
	if targetDist <= nearAtkDist then
		
		-- レベル１
		if( lv <= 1 ) then
			
			-- 近接攻撃
			Honokaijin405000Battle_kinsetsu_1(ai, goal, lv)
            Honokaijin405000Battle_kougekigo(ai, goal, lv )
			
		-- レベル２
		elseif( lv <= 2 ) then
			
			-- 近接攻撃
			Honokaijin405000Battle_kinsetsu_2(ai, goal, lv)
			Honokaijin405000Battle_kougekigo(ai, goal, lv )    
			
		-- レベル３
		elseif( lv <= 3 ) then
		
			-- 近接攻撃
			Honokaijin405000Battle_kinsetsu_3(ai, goal, lv)
			Honokaijin405000Battle_kougekigo(ai, goal, lv )
		end
	--------------------------------------------------------------
	-- 条件：敵ターゲットが近くにいる場合
	-- Desc：近づいて攻撃近接攻撃
	--------------------------------------------------------------
	elseif targetDist <= middleAtkDist then
		
		-- レベル１
		if( lv <= 1 ) then
			
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 3, TARGET_ENE_0, false, -1 );			
			-- 近接攻撃
			Honokaijin405000Battle_kinsetsu_1(ai, goal, lv)
            Honokaijin405000Battle_kougekigo(ai, goal, lv )
			
		-- レベル２
		elseif( lv <= 2 ) then
			
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 3, TARGET_ENE_0, false, -1 );			
			-- 近接攻撃
			Honokaijin405000Battle_kinsetsu_2(ai, goal, lv)
			Honokaijin405000Battle_kougekigo(ai, goal, lv )    
			
		-- レベル３
		elseif( lv <= 3 ) then
		
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 3, TARGET_ENE_0, false, -1 );			
			-- 近接攻撃
			Honokaijin405000Battle_kinsetsu_3(ai, goal, lv)
			Honokaijin405000Battle_kougekigo(ai, goal, lv )
		end
    ----------------------------------------------------
	-- 条件：敵ターゲットが少しだけ離れている
	-- Desc：踏む込み攻撃
	--------------------------------------------------------------
	elseif targetDist <= farAtkDist then
		
		-- レベル１
		if( lv <= 1 ) then
		
			--遠距離攻撃
			Honokaijin405000Battle_enkyori_1(ai, goal, lv )
			Honokaijin405000Battle_kougekigo(ai, goal, lv )
			
        -- レベル２
		elseif( lv <= 2 ) then
			
			--遠距離攻撃
			Honokaijin405000Battle_enkyori_2(ai, goal, lv )
			Honokaijin405000Battle_kougekigo(ai, goal, lv )
			
		-- レベル３
		elseif( lv <= 3 ) then
		
			--遠距離攻撃
			Honokaijin405000Battle_enkyori_3(ai, goal, lv )
			Honokaijin405000Battle_kougekigo(ai, goal, lv )
				
		end

	--------------------------------------------------------------
	-- 条件：敵ターゲットが遠距離にいる場合
	-- Desc：近づいて攻撃
	--------------------------------------------------------------
	else
		-- レベル１
		if( lv <= 1 ) then
		
		    goal:AddSubGoal(GOAL_COMMON_SidewayMove, maaiTime, TARGET_ENE_0, true, 15.0, true, true, -1);   
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 4, TARGET_ENE_0, false, -1 );
			
			-- 近接攻撃
			Honokaijin405000Battle_kinsetsu_1(ai, goal, lv)
			Honokaijin405000Battle_kougekigo(ai, goal, lv )		
            
			
		-- レベル２
		elseif( lv <= 2 ) then
			
			goal:AddSubGoal( GOAL_COMMON_Step, 8, 702, 0, 0, 0 )
			goal:AddSubGoal( GOAL_COMMON_Step, 8, 703, 0, 0, 0 )
			
			--●SEQ1903  	坑道2　ボス　炎の怪人がサイドステップをし続ける
			--		距離用の変数が、ゴールの寿命に入っている。。。しかもほぼ全てのApproachTargetに入っています。
			--		このバグは、ステップ後に距離が離れていると、このステップを繰り返してしまうので、
			--		寿命をある程度延ばしてやる事で解決します。
			--		が、潜在的な問題は抱えています。→直しました（北崎）
--			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, nearAtkDist, TARGET_ENE_0, 5, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5, TARGET_ENE_0, 5, TARGET_ENE_0, false, -1 );
				
				-- 近接攻撃
				Honokaijin405000Battle_kinsetsu_2(ai, goal,lv)
			    Honokaijin405000Battle_kougekigo(ai, goal, lv )
			
		-- レベル３
		elseif( lv <= 3 ) then
		
				-- 攻撃ベスト範囲へ移動
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 4, TARGET_ENE_0, false, -1 );
								
				-- 近接攻撃
				Honokaijin405000Battle_kinsetsu_3(ai, goal,lv)
				Honokaijin405000Battle_kougekigo(ai, goal, lv )	
		end

	end
	
end
---------------------------------------------------------
--  連続攻撃_1 【近接】
---------------------------------------------------------
function Honokaijin405000Battle_kinsetsu_1(ai, goal, lv )

	-- ランダム情報
	local fate1 = ai:GetRandam_Int(1,100)
	local fate2 = ai:GetRandam_Int(1,100)
	local fate3 = ai:GetRandam_Int(1,100)
	
	-- 攻撃ＩＤ一覧(default:Lv1)
	local rightSmash 	= 3000	-- 右払い
	local leftSmash		= 3001	-- 左払い
    local top           = 3002	-- 上から殴り
	local dashFight		= 3050	-- 踏み込み格闘
	local tackle		= 3005	-- 突進
	
	-- Ｌｖ２の場合は攻撃ＩＤを変更する
	if( lv >= 2 ) then
		rightSmash		= 3007
		leftSmash		= 3008
		top     		= 3009
		
	end
	
	if fate1 < 30 then
	-- 近接パターン1
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, leftSmash, TARGET_ENE_0, DIST_Far, 0);
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, top, TARGET_ENE_0, DIST_Far, 0);
		
	elseif fate1 < 70 then
    -- 近接パターン2
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3020 , TARGET_ENE_0, DIST_Far, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, rightSmash, TARGET_ENE_0, DIST_Far, 0);
		
	else
	-- 近接パターン3
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 3040, TARGET_ENE_0, DIST_Far, 0);
	
	end
end	
---------------------------------------------------------
--  連続攻撃_2 【近接】
---------------------------------------------------------
function Honokaijin405000Battle_kinsetsu_2(ai, goal, lv )

	-- ランダム情報
	local fate1 = ai:GetRandam_Int(1,100)
	local fate2 = ai:GetRandam_Int(1,100)
	local fate3 = ai:GetRandam_Int(1,100)
	
	-- 攻撃ＩＤ一覧(default:Lv1)
	local rightSmash 	= 3000	-- 右払い
	local leftSmash		= 3001	-- 左払い
    local top           = 3002	-- 上から殴り
	local dashFight		= 3050	-- 踏み込み格闘
	local tackle		= 3005	-- 突進
	
	-- Ｌｖ２の場合は攻撃ＩＤを変更する
	if( lv >= 2 ) then
		rightSmash		= 3007
		leftSmash		= 3008
		top     		= 3009
		
	end
	
	if fate1 < 30 then
	-- 近接パターン1
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, leftSmash, TARGET_ENE_0, DIST_Middle, 0);
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, top, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif fate1 < 60 then
    -- 近接パターン2
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, rightSmash, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3020, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3030, TARGET_ENE_0, DIST_Middle, 0);
		
	else
	-- 近接パターン3
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, rightSmash, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3030, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
	
	end
end	

---------------------------------------------------------
--  連続攻撃_3 【近接】
---------------------------------------------------------
function Honokaijin405000Battle_kinsetsu_3(ai, goal, lv )

	-- ランダム情報
	local fate1 = ai:GetRandam_Int(1,100)
	local fate2 = ai:GetRandam_Int(1,100)
	local fate3 = ai:GetRandam_Int(1,100)
	
	-- 攻撃ＩＤ一覧(default:Lv1)
	local rightSmash 	= 3000	-- 右払い
	local leftSmash		= 3001	-- 左払い
    local top           = 3002	-- 上から殴り
	local dashFight		= 3050	-- 踏み込み格闘
	local tackle		= 3005	-- 突進
	
	-- Ｌｖ２の場合は攻撃ＩＤを変更する
	if( lv >= 2 ) then
		rightSmash		= 3007
		leftSmash		= 3008
		top     		= 3009
		
	end
	
	if fate1 < 30 then
	-- 近接パターン1
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, top, TARGET_ENE_0, DIST_Middle, 0);
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3020, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif fate1 < 60 then
    -- 近接パターン2
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3020, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, rightSmash, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3030, TARGET_ENE_0, DIST_Middle, 0);
	
	else
	-- 近接パターン3
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3020, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, top, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
	
	end
end	
---------------------------------------------------------
--  連続攻撃_1 【遠距離】
---------------------------------------------------------
function Honokaijin405000Battle_enkyori_1(ai, goal, lv )

	-- ランダム情報
	local fate1 = ai:GetRandam_Int(1,100)
	local fate2 = ai:GetRandam_Int(1,100)
	local fate3 = ai:GetRandam_Int(1,100)
	
	-- 攻撃ＩＤ一覧(default:Lv1)
	local rightSmash 	= 3000	-- 右払い
	local leftSmash		= 3001	-- 左払い
    local top           = 3002	-- 上から殴り
    local dashFight     = 3050	-- 踏み込み格闘
	local tackle		= 3005	-- 突進
			
	if fate1 < 30 then
	-- 遠距離パターン1
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 700, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, top, TARGET_ENE_0, DIST_None, 0);
		
	elseif fate1 < 60 then
    -- 遠距離パターン2
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 700, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3020, TARGET_ENE_0, DIST_None, 0);
		
	else
	-- 遠距離パターン3
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, dashFight, TARGET_ENE_0, DIST_None, 0);
		
	end
end	

---------------------------------------------------------
--  連続攻撃_2 【遠距離】
---------------------------------------------------------
function Honokaijin405000Battle_enkyori_2(ai, goal, lv )

	-- ランダム情報
	local fate1 = ai:GetRandam_Int(1,100)
	local fate2 = ai:GetRandam_Int(1,100)
	local fate3 = ai:GetRandam_Int(1,100)
	
	-- 攻撃ＩＤ一覧(default:Lv1)
	local rightSmash 	= 3000	-- 右払い
	local leftSmash		= 3001	-- 左払い
    local top           = 3002	-- 上から殴り
    local dashFight     = 3050	-- 踏み込み格闘
	local tackle		= 3005	-- 突進
	
	-- Ｌｖ２の場合は攻撃ＩＤを変更する
	if( lv >= 2 ) then
		rightSmash		= 3007
		leftSmash		= 3008
		top     		= 3009
		dashFight		= 3010
	end
	
	if fate1 < 30 then
	-- 遠距離パターン1
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, dashFight, TARGET_ENE_0, DIST_Middle, 0);
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, top, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif fate1 < 60 then
    -- 遠距離パターン2
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, dashFight, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, leftSmash, TARGET_ENE_0, DIST_Middle, 0);
		
	else
	-- 遠距離パターン3
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, dashFight, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, leftSmash, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
	
	end
end	
---------------------------------------------------------
--  連続攻撃_3 【遠距離】
---------------------------------------------------------
function Honokaijin405000Battle_enkyori_3(ai, goal, lv )

	-- ランダム情報
	local fate1 = ai:GetRandam_Int(1,100)
	local fate2 = ai:GetRandam_Int(1,100)
	local fate3 = ai:GetRandam_Int(1,100)
	
	-- 攻撃ＩＤ一覧(default:Lv1)
	local rightSmash 	= 3000	-- 右払い
	local leftSmash		= 3001	-- 左払い
    local top           = 3002	-- 上から殴り
    local dashFight     = 3050	-- 踏み込み格闘
	local tackle		= 3005	-- 突進
	
	-- Ｌｖ２の場合は攻撃ＩＤを変更する
	if( lv >= 2 ) then
		rightSmash		= 3007
		leftSmash		= 3008
		top     		= 3009
		dashFight		= 3010
	end
	
	if fate1 < 30 then
	-- 遠距離パターン1
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, dashFight, TARGET_ENE_0, DIST_None, 0);
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, top, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3020, TARGET_ENE_0, DIST_None, 0);
	
	elseif fate1 < 60 then
    -- 遠距離パターン2
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, dashFight, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3030, TARGET_ENE_0, DIST_None, 0);
		
	else
	-- 遠距離パターン3
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, dashFight, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3020, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3040, TARGET_ENE_0, DIST_None, 0);
	
	end
end
---------------------------------------------------------
--  攻撃後行動
---------------------------------------------------------
function Honokaijin405000Battle_kougekigo(ai, goal, lv )

	-- ランダム情報
	local fate1 = ai:GetRandam_Int(1,100)
	local fate2 = ai:GetRandam_Int(1,100)
	local fate3 = ai:GetRandam_Int(1,100)
	
	if fate1 < 60 then
	-- 少し待ってすぐ攻撃へ
		goal:AddSubGoal( GOAL_COMMON_Wait, 1.0, TARGET_NONE, 0, 0, 0 );
	
	else
	-- バックスステップで仕切りなおす
	
		goal:AddSubGoal(GOAL_COMMON_Step, 5, 701, 0, 0, 0);	
	    goal:AddSubGoal(GOAL_COMMON_Step, 5, 701, 0, 0, 0);	
	end
end

---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function Honokaijin405000Battle_Update(ai, goal)
	targetDist 	= ai:GetDist(TARGET_ENE_0);
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function Honokaijin405000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function Honokaijin405000Battle_Interupt(ai, goal)
local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用


	--至近距離でダメージ受けたらコンボとみなして後退
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--コンボ逃れする距離
local combRunPer = 30				--コンボ逃れする確率
local combRunCountPer = 35			--コンボ逃れの後に攻撃する確率	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
				if fate2 <= 40 then
					goal:AddSubGoal( GOAL_COMMON_Step, 7, 702, 0, 0, 0 )
				elseif fate2 <= 80 then
					goal:AddSubGoal( GOAL_COMMON_Step, 7, 703, 0, 0, 0 )
				else
					goal:AddSubGoal( GOAL_COMMON_Step, 7, 701, 0, 0, 0 )
				end	
					if fate3 <= combRunCountPer then
						goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Middle, 0);
					end
				return true;
			end
		end
	end	
	
	--至近距離で攻撃されそうになったら超反応ステップ
	if ai:IsInterupt( INTERUPT_FindAttack ) then
local superStepDist = 1.0			--超反応する距離
local superStepPer = 5				--超反応する確率	
		if targetDist <= superStepDist then
			if fate <= superStepPer then
			--逃れる
				if fate2 <= 60 then
					goal:AddSubGoal( GOAL_COMMON_Step, 7, 702, 0, 0, 0 )
				elseif fate2 <= 80 then
					goal:AddSubGoal( GOAL_COMMON_Step, 7, 703, 0, 0, 0 )
				else
					goal:AddSubGoal( GOAL_COMMON_Step, 7, 701, 0, 0, 0 )
				end
				return true;
			end
		end
	end
	
	--飛び道具を撃ってきたら最適行動
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 20					--飛び道具使用時に最適行動を取る確率
		if fate <= shootIntPer then
			goal:ClearSubGoal();
			if fate2 <= 50 then
				goal:AddSubGoal( GOAL_COMMON_Step, 7, 702, 0, 0, 0 )
			else
				goal:AddSubGoal( GOAL_COMMON_Step, 7, 703, 0, 0, 0 )
			end
			   	return true
		end
	end
	

	
return false;
end




