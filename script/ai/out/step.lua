-----------------------------------------------------------------------------------------------
--	ステップで移動します
--	移動量はアニメーションに依存します
--	実行すれば必ず成功と判定します
--
--	パラメータ0  EzState番号
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
--
--	使用例
--	-- 3700のステップ移動を実行
--	goal:AddSubGoal(GOAL_COMMON_Step, 寿命, 3000, 0, 0, 0);
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_COMMON_Step, "Step");

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Step, 0, "EzState番号", 0);

-- 更新間隔設定
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_Step, 0, 0);

---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function Step_Activate(ai, goal)

	-- パラメータ取得
	-- EzState番号
	local behaviorNo = goal:GetParam(0);

	-- ステップ移動
	ai:SetAttackRequest(behaviorNo);

end


---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function Step_Update(ai, goal)

	-- パラメータ取得
	-- EzState番号
	local behaviorNo = goal:GetParam(0);

	
	local bFinish = false;
	
	-- 次の連続攻撃が可能か
	if ai:IsEnableComboAttack() == true then
		bFinish = true;
	end
	
	-- 攻撃終わってしまったか
	if ai:IsFinishAttack() == true then
		-- 連続攻撃なのだから失敗にしたほうがいいのか・・？
		bFinish = true;
	end
	
	-- 攻撃終わったら成功
	if bFinish== true then
		return GOAL_RESULT_Success;
	end
	
	-- 攻撃アニメ開始していないときだけリクエストする
	if ai:IsStartAttack() == false then
		-- ステップ移動
		ai:SetAttackRequest(behaviorNo);
	end
	
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function Step_Terminate(ai, goal)
end


-- 割り込みなし宣言
-- これがtrueの場合には割り込みが呼ばれないので注意してください。
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_Step, true);

---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function Step_Interupt(ai, goal)
	return false;
end
