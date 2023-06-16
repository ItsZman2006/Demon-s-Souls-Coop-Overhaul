-----------------------------------------------------------------------------------------------
--	虜囚戦闘
--	説明：
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Ryosyu207000_Battle, "Ryosyu207000Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Ryosyu207000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function Ryosyu207000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

	local hpRate 		= ai:GetHpRate( TARGET_SELF )		--自分のHP割合を取得
	local targetHpRate 	= ai:GetHpRate( TARGET_ENE_0 )	--敵ターゲットのHP割合を取得
	local targetDist 	= ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
	local fate 			= ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字
	local fate2 		= ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　その２
	
	-- 近距離
	if( targetDist <= ai:GetDistParam( DIST_Near ) ) then
			
			-- たまにお祈り
			if( fate2 <= 30 ) then
				goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_EVENT,DIST_None, 0 )
			
			-- プレイヤーの左右を走り回る
			elseif( fate2 <= 70) then
				goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 3.0, TARGET_ENE_0, AI_DIR_TYPE_L, 0.5, TARGET_ENE_0, false );
				goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 3.0, TARGET_ENE_0, AI_DIR_TYPE_R, 0.5, TARGET_ENE_0, false );
				
			else
--				goal:AddSubGoal( GOAL_COMMON_WalkAround, 15, -1, 0, 0, 0 );
				goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 15, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 1, TARGET_ENE_0, false );
			end
			
			
--~ 			-- たまに攻撃
--~ 			if( fate <= 5 ) then
--~ 				goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3000, TARGET_ENE_0, DIST_Near, 0 )
--~ 			end
			
	-- 中距離
	elseif( targetDist <= ai:GetDistParam( DIST_Middle ) ) then
		-- たまにお祈り
		if( fate2 <= 30 ) then
			goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_EVENT,DIST_None, 0 )
		end

		-- 歩いて追いかける
		if( fate <= 99 ) then
--			goal:AddSubGoal( GOAL_COMMON_WalkAround, 15, -1, 0, 0, 0 );
			goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 15, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 1, TARGET_ENE_0, false );
		
		-- 稀にダッシュ
		else
			goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 5, TARGET_EVENT, AI_DIR_TYPE_CENTER, 1, TARGET_EVENT, false );
			goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_EVENT,DIST_None, 0 )
			goal:AddSubGoal(GOAL_COMMON_BackToHome, 60, -1, 0, 0, 0 );
		end	
	
	-- 遠距離以上
	else
		-- たまにお祈り
		if( fate2 <= 20 ) then
			goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_EVENT,DIST_None, 0 )
		end
	
		-- 追いかける
		if( fate <= 90 ) then
--			goal:AddSubGoal( GOAL_COMMON_WalkAround, 15, -1, 0, 0, 0 );
			goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 15, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 1, TARGET_ENE_0, false );
		
		-- 稀にダッシュ
		else
			goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 5, TARGET_EVENT, AI_DIR_TYPE_CENTER, 1, TARGET_EVENT, false );
			goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_EVENT,DIST_None, 0 )
			goal:AddSubGoal(GOAL_COMMON_BackToHome, 60, -1, 0, 0, 0 );
		end	
	end


end

---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function Ryosyu207000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function Ryosyu207000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function Ryosyu207000Battle_Interupt(ai, goal)

	

	if( ai:IsInterupt( INTERUPT_FindAttack ) ) then
		local targetDist 	= ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
		if( targetDist <= 2 ) then
			goal:ClearSubGoal();
			goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_ENE_0, DIST_Near, 0 )
		end
	end

	-- 攻撃された
	if( ai:IsInterupt( INTERUPT_Damaged ) ) then
		goal:ClearSubGoal();
		local dist = 5.0;
		-- 敵とは逆方向に逃げる
		goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 8, TARGET_ENE_0, AI_DIR_TYPE_F, dist, TARGET_SELF, false );
		
		-- 初期位置に戻る
		goal:AddSubGoal( GOAL_COMMON_PathMovePoint, 5, POINT_INITIAL, AI_DIR_TYPE_CENTER, 1.0, TARGET_SELF, true );

		-- お祈り
		goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_EVENT,DIST_None, 0 )
		
		return true;
	elseif( ai:IsInterupt( INTERUPT_Damaged_Stranger ) ) then
		goal:ClearSubGoal();
		local dist = 5.0;
		-- 敵とは逆方向に逃げる
		goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 8, TARGET_ENE_0, AI_DIR_TYPE_F, dist, TARGET_SELF, false );
		
		-- 初期位置に戻る
		goal:AddSubGoal( GOAL_COMMON_PathMovePoint, 5, POINT_INITIAL, AI_DIR_TYPE_CENTER, 1.0, TARGET_SELF, true );

		-- お祈り
		goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_EVENT,DIST_None, 0 )
		
		return true;
	end
	

	return false;
end	

	
	
	
	
	
--[[**********************************************************************************************************]]
--[[********************************** 牢城の虜囚全般 ************************************************************************]]
--[[**********************************************************************************************************]]




--[[*******************************************************************************************
	虜囚用待ちゴール。
	説明：
		ウロコ虜囚用の待機時に行うアクションを書く。
		待ち中のランダム性はここで。
		
	パラメータ0  なし。
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Ryosyu_COMMON_Wait, "RYOSHUWait");
REGISTER_GOAL_NO_UPDATE( GOAL_Ryosyu_COMMON_Wait, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_Ryosyu_COMMON_Wait, true);

--[[*****************************************************
	ゴール起動
*******************************************************]]
function RYOSHUWait_Activate(ai, goal)

	--パラメータIDで、変化を加える;
	local idParam 	= ai:GetNpcThinkParamID();
	local ezStateNo	= 0;

	
	if 		(idParam==211000) then		ezStateNo	= 3300; --ピッケル
	elseif 	(idParam==211001) then		ezStateNo	= 3301;	--袋
	elseif 	(idParam==211002) then		ezStateNo	= 3302;	--小剣
	elseif 	(idParam==211003) then		ezStateNo	= 3302;	--大剣
	elseif 	(idParam==211004) then		ezStateNo	= 0;	--ゴクリ手下
	end


	--アクション前、間。
	local wait_time = ai:GetRandam_Float( 0.5, 2.5);
	goal:AddSubGoal( GOAL_COMMON_Wait, wait_time, TARGET_NONE);
	
	--まちアクション。
	if ( 0<ezStateNo) then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 100, ezStateNo, TARGET_NONE, DIST_None);
	end
	
end

--[[*****************************************************
	ゴール更新・終了・割り込みを行わない。
*******************************************************]]
function RYOSHUWait_Update(ai, goal) return GOAL_RESULT_Continue; end
function RYOSHUWait_Terminate(ai, goal) end
function RYOSHUWait_Interupt(ai, goal) return false; end





			


