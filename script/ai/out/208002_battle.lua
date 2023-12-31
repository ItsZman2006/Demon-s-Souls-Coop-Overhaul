--[[*******************************************************************************************
	【獄吏】用戦闘
	説明：

	変更履歴：
	　・08/7/24 hasem	チーム命令を出さない＆動かない＆連射魔法を使う。
	　・08/7/26 hasem	近/中/遠距離で攻撃を分ける。
	　・
	
	パラメータ0  なし
	パラメータ1  なし
	パラメータ2  なし
	パラメータ3　なし
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Gokuri208002_Battle, "Gokuri208002Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Gokuri208002_Battle, true);
--~ REGISTER_GOAL_NO_INTERUPT( GOAL_Gokuri208002_Battle, true);


--[[*****************************************************
	ゴール起動
*******************************************************]]
function Gokuri208002Battle_Activate(ai, goal)

	--[[■企画さん調整項目■]]
	
		--各距離のしきい値は、エクセル側（NPC思考パラメータにあります。
	
	--[[■企画さん調整項目■]]

	local targetDist 	= ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
	local NEAR_DIST		= ai:GetDistParam(DIST_Near);	--近距離しきい値。
	local MIDDLE_DIST	= ai:GetDistParam(DIST_Middle);	--中距離しきい値。
	local FAR_DIST		= ai:GetDistParam(DIST_Far);	--遠距離しきい値。
	local fate			= ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字

	
	if 		( targetDist<NEAR_DIST ) then
		if fate < 30 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true, -1);
		else
			Gokuri208002Battle_NearAttack( ai, goal);
		end
		
	elseif 	( targetDist<MIDDLE_DIST ) then
		if fate < 20 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NEAR_DIST, TARGET_ENE_0, false, -1 );
		elseif fate < 30 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NEAR_DIST, TARGET_ENE_0, true, -1 );		
		elseif fate < 40 then
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true, -1);
		else
			Gokuri208002Battle_MiddleAttack( ai, goal);
		end
	else
		Gokuri208002Battle_FarAttack( ai, goal);
	end
	
end


---------------------------------------------------------
--  遠距離砲撃。
---------------------------------------------------------
function Gokuri208002Battle_FarAttack(ai, goal)

	--[[■企画さん調整項目■]]
	
	local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
	local idMotion_Long			= 3304;		--長めの魔法発動動作。
	local idMotion_Short		= 3301;		--短めの魔法発動動作。
	local RANDOM_LONG_SELECT	= 35;		--長めの魔法を選ぶ割合。(100未満にする事。)
	
	local rand_val = ai:GetRandam_Int( 0, 100);
	
	if ( Gokuri208002Battle_IsEnableFarAttack(ai, goal) ) then
	
		if ( rand_val < RANDOM_LONG_SELECT ) then
			Gokuri208002Battle_AddAttackGoal( ai, goal, 10.0, idMotion_Long, TARGET_ENE_0, DIST_None);
		else
			if fate <= 50 then
				goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_ENE_NONE, 0, 0, 0 );
				Gokuri208002Battle_AddAttackGoal( ai, goal, 10.0, idMotion_Short, TARGET_ENE_0, DIST_None);
			else
				Gokuri208002Battle_AddAttackGoal( ai, goal, 10.0, idMotion_Short, TARGET_ENE_0, DIST_None);
			end
		end

	else
		goal:AddSubGoal(GOAL_COMMON_Wait, 0.1, target);
	end
	
end
	
	
---------------------------------------------------------
--  中距離砲撃。
---------------------------------------------------------
function Gokuri208002Battle_MiddleAttack(ai, goal)
	
	--ヨガフレイム！→距離が短い攻撃だったので、縦ムチに変更
	Gokuri208002Battle_AddGuardbreakGoal( ai, goal, 10.0, 3001, TARGET_ENE_0, DIST_None);
end
	
	
---------------------------------------------------------
--  近い距離攻撃。
---------------------------------------------------------
function Gokuri208002Battle_NearAttack(ai, goal)

	--[[■企画さん調整項目■]]
	
	local idMotion_YOKO			= 3000;		--横ムチ。ガチ。�
	local idMotion_TATE			= 3303;		--縦ムチ。→発火魔法に変更
	local idMotion_FIRE			= 3301;		--フェイント用ファイヤーボルト。
	local RANDOM_YOKO_SELECT	= 30;		--横ムチを選ぶ割合。(100未満にする事。)
	local RANDOM_FIRE_SELECT	= (RANDOM_YOKO_SELECT+10);		--発火を選ぶ割合(数字だけ変える)。
	
	--[[■企画さん調整項目■]]

	local rate = ai:GetRandam_Int(1,100);

	--近距離攻撃。
	--	半分の割合で、出し分けるだけ。
	if ( rate<RANDOM_YOKO_SELECT ) then
		Gokuri208002Battle_AddGuardbreakGoal( ai, goal, 10.0, idMotion_YOKO, TARGET_ENE_0, DIST_None);
	elseif ( rate<RANDOM_FIRE_SELECT) then
		Gokuri208002Battle_AddAttackGoal( ai, goal, 10.0, idMotion_FIRE, TARGET_ENE_0, DIST_None);
	else
		Gokuri208002Battle_AddAttackGoal( ai, goal, 10.0, idMotion_TATE, TARGET_ENE_0, DIST_None);
	end

end

---------------------------------------------------------
--  遠距離砲撃していいか？
---------------------------------------------------------
function Gokuri208002Battle_IsEnableFarAttack(ai, goal)
	local idParam = ai:GetNpcThinkParamID();
	if 		(idParam==208003) then	CheckRegionID = 2165;
	elseif 	(idParam==208004) then	CheckRegionID = 2166;
	elseif 	(idParam==208005) then	CheckRegionID = 2167;
	else	CheckRegionID = -1
	end
	
	if ( false==ai:IsFinishTimer(0))	then return true; end
	if ( CheckRegionID==-1)				then return true; end
	
	return ai:IsInsideTargetRegion( TARGET_ENE_0, CheckRegionID);
end


--[[*****************************************************
	ゴール更新・終了は、なし。
*******************************************************]]
function Gokuri208002Battle_Update(ai, goal)return GOAL_RESULT_Continue;end
function Gokuri208002Battle_Terminate(ai, goal)end


--[[*****************************************************
	割り込み。
*******************************************************]]
function Gokuri208002Battle_Interupt(ai, goal)

	--ダメージを受けたら、一定時間、射撃制限領域を無視する。
	if ( ai:IsInterupt(INTERUPT_Damaged) or ai:IsInterupt(INTERUPT_Damaged_Stranger) ) then
		ai:SetTimer(0, 20);
	end

	return false; 
end


--[[*****************************************************
	攻撃ゴール追加。
*******************************************************]]
function Gokuri208002Battle_AddAttackGoal(ai, goal, life, EzStateID, target, typeDist)
	
	if ( ai:IsVisibleTarget(target) ) then
		--見えていれば普通に攻撃。
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, life, EzStateID, target, typeDist, 0);
	else
		--見えていなければ、ちょっと待つを入れる。
		goal:AddSubGoal(GOAL_COMMON_Wait, 0.1, target);
	end
	
end

--[[*****************************************************
	ガードブレイク攻撃ゴール追加。
*******************************************************]]
function Gokuri208002Battle_AddGuardbreakGoal(ai, goal, life, EzStateID, target, typeDist)

	local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
	
	if ( ai:IsVisibleTarget(target) ) then
		--見えていれば普通に攻撃。
		goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, life, EzStateID, target, typeDist, 0);
        if fate <= 40 then
            goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
        else
            goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
        end 
	else
		--見えていなければ、ちょっと待つを入れる。
		goal:AddSubGoal(GOAL_COMMON_Wait, 0.1, target);
	end
	
end



	