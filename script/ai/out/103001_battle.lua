--[[*******************************************************************************************
	デブデーモン用戦闘
	説明：古砦１の広場に居るデブデーモン用。

	●変更履歴
		チュートリアルからコピー	08/8/2 hasem
	
	●ゴールパラメータ
		パラメータ0  なし
		パラメータ1  なし
		パラメータ2  なし
		パラメータ3　なし
	
	●ai:SetNumber()の使用状況。
		０：
		１：
		２：
		３：
	
	●ai:AddObserveRegion()の使用状況。
		０：移動禁止領域に差し掛かっていたかどうかのチェック。
		１：
		２：
		３：
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Debu103001_Battle, "debu103001Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Debu103001_Battle, true);

--[[*****************************************************
	ゴール起動
*******************************************************]]
function debu103001Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

--[[■調整項目■]]

	local APPROACH_DIST	= 6;
	local BACKHOME_DIST	= 3;

--[[■調整項目■]]

	
	
	if ( ai:IsInsideTargetRegion(TARGET_ENE_0, 2270) ) then
		
		--後半勝負。
		--	後半はちょっと追いかけるそぶりを見せる。
		--	移動禁止領域に入っていなければ。。。
		if ( not(ai:IsInsideTargetRegion(TARGET_SELF, 2271)) ) then
			--あんまり追いかけると、壁を突き抜ける攻撃をしてしまったり、
			--穴に落ちたりするので、執拗には追いかけない。。
			goal:AddSubGoal(GOAL_Debu103001_SafeApproach, 3);
		end
		
		debu103001Battle_Attack(ai, goal);
	
	else
		
		--前半勝負。
		--	前半は、プレイヤーが来たら攻撃。
		
		--初期位置から離れていたら、戻る。
		local distToInipos = ai:GetDist(POINT_INITIAL);
		if ( BACKHOME_DIST < distToInipos ) then
			goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 3, POINT_INITIAL, AI_DIR_TYPE_CENTER, 1, TARGET_ENE_0, false);
		end
		
		debu103001Battle_Attack(ai, goal);
	
	end
	
end
	
---------------------------------------------------------
--  攻撃。
---------------------------------------------------------
function debu103001Battle_Attack(ai, goal)

	--攻撃していい領域に入っていれば、攻撃。
	if ( debu103001Battle_IsEnableAttack(ai, goal) ) then
	
		if ( not debu103001Battle_SelectAttack(ai, goal) ) then
			--何も選択されていなければ、ちょっと待つ。
			goal:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_ENE_0);
		end
		
	else
		--ちょっと待つ。
		goal:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_ENE_0);
	end
	
	--攻撃後
	debu103001Battle_Kougeki_Noato(ai, goal);
end

---------------------------------------------------------
--  攻撃の選択。
--	hasem　:この関数は企画サイドで好き勝手いじって良いです。
---------------------------------------------------------
function debu103001Battle_SelectAttack(ai, goal)

	--[[●メモ。
	
		3000	通常		0		7.5
		3001	右なぎ		2		10.2
		3002	右上		2.6		9.5
		3003	左上		2.6		9.5		（3002からコンボ可、単発で出すのは禁止。）
		3300	溜め攻撃	1		8
		
		組み合わせは、debu103001Battle_Attack_1 ～ 6
	]]

	
	--各攻撃の割合。
	local rate1	= 0;
	local rate2	= 0;
	local rate3	= 0;
	local rate4	= 0;
	local rate5	= 0;
	local rate6	= 0;
	
	
	local dist = ai:GetDist(TARGET_ENE_0);
	if 		( 10.5<=dist) then
		rate1	= 0;
		rate2	= 0;
		rate3	= 0;
		rate4	= 0;
		rate5	= 0;
		rate6	= 0;
		
	elseif 	( 9.5<=dist) then
		rate1	= 0;
		rate2	= 100;
		rate3	= 0;
		rate4	= 0;
		rate5	= 0;
		rate6	= 0;
		
	elseif 	( 7.5<=dist ) then
		rate1	= 0;
		rate2	= 45;
		rate3	= 10;
		rate4	= 0;
		rate5	= 40;
		rate6	= 5;
		
	elseif 	( 2.5<=dist ) then
		rate1	= 20;
		rate2	= 10;
		rate3	= 10;
		rate4	= 0;
		rate5	= 30;
		rate6	= 30;
		
	elseif 	( 1.5<=dist ) then
		rate1	= 50;
		rate2	= 0;
		rate3	= 0;
		rate4	= 0;
		rate5	= 0;
		rate6	= 50;
		
	else
		rate1	= 15;
		rate2	= 0;
		rate3	= 0;
		rate4	= 80;
		rate5	= 0;
		rate6	= 5;
		
	end
	
	local total_rate 	= rate1 + rate2 + rate3
						+ rate4 + rate5 + rate6;
						
	--どれも選択されない。
	if (total_rate==0) then
		return false;
	end

	local thr1	= rate1;
	local thr2	= rate1 + rate2;
	local thr3	= rate1 + rate2 + rate3;
	local thr4	= rate1 + rate2 + rate3 + rate4;
	local thr5	= rate1 + rate2 + rate3 + rate4 + rate5;
						
	local rand_val		= ai:GetRandam_Int(0,total_rate);
	if 		( rand_val<=thr1 ) then	debu103001Battle_Attack_1(ai, goal);
	elseif	( rand_val<=thr2 ) then	debu103001Battle_Attack_2(ai, goal);
	elseif	( rand_val<=thr3 ) then	debu103001Battle_Attack_3(ai, goal);
	elseif	( rand_val<=thr4 ) then	debu103001Battle_Attack_4(ai, goal);
	elseif	( rand_val<=thr5 ) then	debu103001Battle_Attack_5(ai, goal);
	else							debu103001Battle_Attack_6(ai, goal);
	end
	
	return true;
end

--[[攻撃 1]]
function debu103001Battle_Attack_1(ai, goal)
	goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_None, 0);
end

--[[攻撃 2]]
function debu103001Battle_Attack_2(ai, goal)
	goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_None, 0);
end

--[[攻撃 3]]
function debu103001Battle_Attack_3(ai, goal)
	goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_None, 0);
end

--[[攻撃 4]]
function debu103001Battle_Attack_4(ai, goal)
	goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_None, 0);
end

--[[攻撃 5]]
function debu103001Battle_Attack_5(ai, goal)
	goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_None, 0);
end

--[[攻撃 6]]
function debu103001Battle_Attack_6(ai, goal)
	goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_None, 0);
end

---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function debu103001Battle_Kougeki_Noato(ai, goal)

--[[■調整項目■]]

	local BACKHOME_DIST = 3;

--[[■調整項目■]]

	--初期位置から離れていたら戻る。
	local distToInipos = ai:GetDist(POINT_INITIAL);
	if ( BACKHOME_DIST < distToInipos ) then
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 2, POINT_INITIAL, AI_DIR_TYPE_CENTER, 0, TARGET_ENE_0, true);				
	end
	
	goal:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_ENE_0);
end

---------------------------------------------------------
--  攻撃していい場所か？
---------------------------------------------------------
function debu103001Battle_IsEnableAttack(ai, goal)
	
	if ( ai:IsInsideTargetRegion(TARGET_ENE_0, 2275) ) then return true; end
	if ( ai:IsInsideTargetRegion(TARGET_ENE_0, 2276) ) then return true; end
	
	return false;
end



--[[*****************************************************
	更新・終了なし。
*******************************************************]]
function debu103001Battle_Update(ai, goal) return GOAL_RESULT_Continue; end
function debu103001Battle_Terminate(ai, goal)end


--[[*****************************************************
	割り込み。
*******************************************************]]
function debu103001Battle_Interupt(ai, goal)

--~ 	if ( ai:IsInterupt(INTERUPT_Inside_ObserveArea) ) then
--~ 		if ( ai:IsInsideObserveRegion(0) ) then
--~ 			goal:ClearSubGoal();
--~ 			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_None, 0);
--~ 			return true;
--~ 		end
--~ 	end

	return false;
end



--[[************************************************************************************************************]]
--[[************************************************************************************************************]]
--[[************************************************************************************************************]]


--[[*****************************************************
	安全接近。
	・移動不可能領域に差し掛かったら、
	　その時点で割り込みをかけて、ゴールを成功させ、移動しないようにする。
*******************************************************]]
REGISTER_GOAL(GOAL_Debu103001_SafeApproach, "debu103001SafeApproach");
REGISTER_GOAL_NO_UPDATE( GOAL_Debu103001_SafeApproach, true);

function debu103001SafeApproach_Activate(ai, goal)

	--領域監視開始。
	ai:AddObserveRegion( 0, TARGET_SELF, 2271 );
	
	--ターゲットに向かって移動。
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 3, TARGET_ENE_0, APPROACH_DIST, AI_DIR_TYPE_CENTER, false, -1);
end

function debu103001SafeApproach_Terminate(ai, goal)end
function debu103001SafeApproach_Update(ai, goal) return GOAL_RESULT_Continue; end

function debu103001SafeApproach_Interupt(ai, goal)
	
	if (ai:IsInterupt(INTERUPT_Inside_ObserveArea)) then
		--もし、移動禁止領域に差し掛かっていたら、
		--現在の移動をクリアして、ちょっとのwaitを入れて成功させる。
		if (ai:IsInsideObserveRegion(0)) then
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_Wait, 0.1);
			return true;
		end
	end
	
	return false;
end
