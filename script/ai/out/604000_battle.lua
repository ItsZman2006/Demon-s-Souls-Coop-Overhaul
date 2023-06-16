-----------------------------------------------------------------------------------------------
--	Libra604000専用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Libra604000_Battle, "Libra604000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Libra604000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function Libra604000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------
	--なにもしない
	goal:AddSubGoal(GOAL_COMMON_Wait, -1.0,TARGET_ENE_0, 0, 0, 0 );
	
end


---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function Libra604000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function Libra604000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function Libra604000Battle_Interupt(ai, goal)


	local hprate = ai:GetHpRate( TARGET_SELF )	--自分のHP割合を取得
	local state = ai:GetNumber(0);	-- インデックス0でステートを保存しておく
	local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離
	
	local nearDist = 3.9		--近いと判断する距離(自分中心爆発半径程度)
	
	-- ダメージ受けたら割り込み
	if( ai:IsInterupt( INTERUPT_Damaged ) ) then

	--[[
			ステート番号で現在の状態をあらわす
			HPがへっていくごとにステートが切り替わり、
			切り替わるタイミングでだけ攻撃を実行する
	]]

		-- 一番最初
		if state == 1 then
			if hprate < 0.55 then
				-- HP？％以下まで待つ
				-- いまやっていることををクリア
				goal:ClearSubGoal();
				-- 距離によって攻撃、もしくは回復
				if targetDist < nearDist then
					goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0, 3000, TARGET_ENE_0, DIST_None, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0, 3001, TARGET_ENE_0, DIST_None, 0);
				end
				-- 次のステートへ 0番インデックスにステート1を設定する
				ai:SetNumber(0, 2);
				return true;
			end
		elseif state == 2 then
			if hprate < 0.3 then
				-- HP？％以下まで待つ
				-- いまやっていることををクリア
				goal:ClearSubGoal();
				-- 距離によって攻撃、もしくは回復
				if targetDist < nearDist then
					goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0, 3000, TARGET_ENE_0, DIST_None, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0, 3001, TARGET_ENE_0, DIST_None, 0);
				end
				-- 次のステートへ 0番インデックスにステート1を設定する
				ai:SetNumber(0, 3);
				return true;
			end
		elseif state == 3 then
			-- 割り込まない
			return false;
		else
			if hprate < 0.8 then
				-- 一番最初にくる
				-- HP？％以下まで待つ
				-- いまやっていることををクリア
				goal:ClearSubGoal();
				-- 距離によって攻撃、もしくは回復
				if targetDist < nearDist then
					goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0, 3000, TARGET_ENE_0, DIST_None, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0, 3001, TARGET_ENE_0, DIST_None, 0);
				end
				-- 次のステートへ 0番インデックスにステート1を設定する
				ai:SetNumber(0, 1);
				return true;
			end
		end
	end

	return false;
end

