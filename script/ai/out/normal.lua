-----------------------------------------------------------------------------------------------
--	通常行動
--	説明：とりあえずデフォルトで設定する行動です。
--		  一通りの行動を試す際に使用してください。
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3  なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_COMMON_Normal, "Normal");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_COMMON_Normal, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function Normal_Activate(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);
	--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)
	--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)
	--確率判定で使用する運命の数字　その２


--■戦闘行動用パラメータ
local trigDistNear				=	2.0
	--条件距離【近】
local trigDistMid				=	4.0
	--条件距離【中】
local trigDistFar				=	0
	--条件距離【遠】
	
local ezsNoNear					=	3000
	--ezstate番号【近距離行動】
local ezsNoMid					=	3000
	--ezstate番号【中距離行動】
local ezsNoFar					=	3000
	--ezstate番号【遠距離行動】
	
local moveDistNear				=	3.0
	--離脱距離【近→中】
local moveDistMid				=	1.0
	--接近距離【中→近】
local moveDistFar				=	3.0
	--接近距離【遠→中】

local movePerNear				=	20
	--離脱確率【近→中】
local movePerMid				=	30
	--接近確率【中→近】
local movePerFar				=	40
	--接近確率【遠→中】


local maaiDistNear				=	1.5
	--間合い距離【近】
local maaiDistMid				=	3.5
	--間合い距離【中】
local maaiDistFar				=	5.5
	--間合い距離【遠】

local maaiPerNear				=	40
	--間合い確率【近】
local maaiPerMid				=	30
	--間合い確率【中】
local maaiPerFar				=	20
	--間合い確率【遠】

	
--■攻撃範囲外の行動用パラメータ
local attActDist				=	6.0
	--攻撃行動をする距離
	
local trigDistDash				=	0
	--接近の条件距離【ダッシュ】
local trigDistWalk				=	9.0
	--接近の条件距離【歩行】
	
local moveDistDash				=	7.0
	--接近距離【ダッシュ】
local moveDistWalk				=	3.0
	--接近距離【歩行】
	

	--敵ターゲットが攻撃範囲内にいるなら
	if targetDist <= attActDist then
		--近距離行動
		if targetDist < trigDistNear then
			--離脱
			if fate <= movePerNear then
				goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 5.0 , TARGET_ENE_0, AI_DIR_TYPE_CENTER, moveDistNear, TARGET_ENE_0, true);
				
			--アクション
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, ezsNoNear, TARGET_ENE_0, DIST_Near, 0);
				if fate2 <= maaiPerNear then
					goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 5.0 , TARGET_ENE_0, AI_DIR_TYPE_CENTER, maaiDistNear, TARGET_ENE_0, true);
				end
			end
		--中距離行動	
		elseif targetDist < trigDistMid then
			--接近
			if fate <= movePerMid then
				goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 5.0 , TARGET_ENE_0, AI_DIR_TYPE_CENTER, moveDistMid, TARGET_ENE_0, true);
				
			--アクション
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, ezsNoMid, TARGET_ENE_0, DIST_Near, 0);
				if fate2 <= maaiPerMid then
					goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 5.0 , TARGET_ENE_0, AI_DIR_TYPE_CENTER, maaiDistMid, TARGET_ENE_0, true);
				end
			end
			
		--遠距離行動
		else
			--接近
			if fate <= movePerFar then
				goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 5.0 , TARGET_ENE_0, AI_DIR_TYPE_CENTER, moveDistFar, TARGET_ENE_0, true);
				
			--アクション
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, ezsNoFar, TARGET_ENE_0, DIST_Near, 0);
				if fate2 <= maaiPerFar then
					goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 5.0 , TARGET_ENE_0, AI_DIR_TYPE_CENTER, maaiDistFar, TARGET_ENE_0, true);
				end
			end
		end
		
	--攻撃範囲内にいないなら	
	else
		--接近（歩行）
		if targetDist <= trigDistWalk then
			goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 10.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, moveDistWalk , TARGET_ENE_0, true );
			
		--接近（ダッシュ＆歩行）
		else
			goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 10.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, moveDistDash , TARGET_ENE_0, false );
			goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 10.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, moveDistWalk , TARGET_ENE_0, true );
		end
	end	

end


---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function Normal_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function Normal_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function Normal_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);
	--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)
	--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)
	--確率判定で使用する運命の数字　その２


local guardDist						=	3.0
	--ガード距離
local guardPer						=	50
	--ガード確率
local ezsNoguard					=	9910
	--ezstate番号【ガード】	
	
local missContDist					=	3.0
	--空振り反撃距離
local missContPer					=	50
	--空振り反撃確率
local ezsNoMissCont					=	3300
	--ezstate番号【空振り反撃】

local guardBreakAttDist				=	3.0
	--ガード崩れ時の攻撃距離
local guardBreakAttPer				=	75
	--ガード崩れ時の攻撃確率
local ezsNoguardBreakAtt			=	3300
	--ezstate番号【ガード崩れ時】
	
local guardDownAttDist				=	3.0
	--ガード解除時の攻撃距離
local guardDownAttPer				=	40
	--ガード解除時の攻撃確率
local ezsNoguardDownAtt				=	3000
	--ezstate番号【ガード解除時】


	--ガードする
	if ai:IsInterupt( INTERUPT_FindAttack ) then
		if targetDist <= guardDist then
			if fate <= guardPer then
				goal:ClearSubGoal();
				goal:AddSubGoal(GOAL_COMMON_Guard, 5.0, ezsNoguard, TARGET_ENE_0, 0, 0);
				return true;
			end
		end
	end

	--空振りしたら反撃する
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < missContDist then
			if fate <= missContPer then
				goal:ClearSubGoal();
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, ezsNoMissCont, TARGET_ENE_0, DIST_Near, 0);
				return true;
			end
		end
	end

	--ガード崩れたら攻撃する
	if ai:IsInterupt( INTERUPT_GuardBreak ) then
		if targetDist < guardBreakAttDist then
			if fate <= guardBreakAttPer then
				goal:ClearSubGoal();
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, ezsNoguardBreakAtt, TARGET_ENE_0, DIST_Near, 0);
				return true;
			end
		end
	end

	--ガード止めたら攻撃する
	if ai:IsInterupt( INTERUPT_GuardFinish ) then
		if targetDist < guardDownAttDist then
			if fate <= guardDownAttPer then
				goal:ClearSubGoal();
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, ezsNoguardDownAtt, TARGET_ENE_0, DIST_Near, 0);
				return true;
			end
		end
	end
	
	return false;
end

