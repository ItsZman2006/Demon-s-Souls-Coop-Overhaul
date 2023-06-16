--[[******************************************************************************************
	指定ターゲットを中心に横移動をして回り込もうとする。
	ターゲットのして方向・指定角度内に入ると成功。

	横移動の方向は目標位置に対して最短で到着できる方向に移動します。

	パラメータ0  移動対象【Type】			TARGET_XXXX
	パラメータ1  対象の方向【Type】			AI_DIR_TYPE_XXXX
	パラメータ2  角度【度】
	パラメータ3  歩くか						(true、false)
	パラメータ4  寿命尽きても成功とするか	(true, false)
	パラメータ5  ガード用のEzState行動ID

	使用例
	-- ターゲット0を中心に回り込み
	ai:AddTopGoal( GOAL_COMMON_TurnAround, -1, TARGET_ENE_0, AI_DIR_TYPE_B, 10, true, false, -1);
********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_TurnAround, "TurnAround");

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_TurnAround, 0, 	"移動対象【Type】",		0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_TurnAround, 1, 	"対象の方向【Type】",	0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_TurnAround, 2, 	"角度【度】", 			0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_TurnAround, 3, 	"歩く?", 				0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_TurnAround, 4, 	"寿命で成功？", 		0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_TurnAround, 5, 	"ガードEzState番号", 	0);

-- 更新間隔設定
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_TurnAround, 0.1, 0.2);


--[[***************************************************************************
	起動
*****************************************************************************]]
function TurnAround_Activate(ai, goal)

	-- パラメータ取得
	local targetType 	= goal:GetParam(0);	-- 移動対象
	local targetDir		= goal:GetParam(1);	-- 対象方向
	local bWalk 		= goal:GetParam(3);	-- 歩くか
	local guardActionId = goal:GetParam(5);	-- ガードするか

	if guardActionId > 0 then
		-- ガード行動
		goal:AddSubGoal( GOAL_COMMON_Guard, goal:GetLife(), guardActionId, targetType, 0, 0);	
	end

	-- ターゲットを向く
	ai:TurnTo( targetType );
	
	--移動方向を決定。
	local move_dir = ai:GetTurnAroundOptimizedDirection( targetType, targetDir);

	-- 左右移動設定
	ai:SetMoveLROnly(true);
	
	-- 移動。
	ai:MoveTo( TARGET_SELF, move_dir, 10.0, bWalk );
	
	
	-- チームに横移動していることを通知
	if ( move_dir==AI_DIR_TYPE_L) then
		goal:AddGoalScopedTeamRecord(COORDINATE_TYPE_SideWalk_L, targetType, 0);
	elseif ( move_dir==AI_DIR_TYPE_R ) then
		goal:AddGoalScopedTeamRecord(COORDINATE_TYPE_SideWalk_R, targetType, 0);
	end
end


--[[***************************************************************************
	更新
*****************************************************************************]]
function TurnAround_Update(ai, goal, dT)

	-- パラメータ取得
	local dirType		= goal:GetParam(1);	-- 対象方向
	local turnAng 		= goal:GetParam(2);	-- 角度
	local bLifeSucces 	= goal:GetParam(4);	-- 寿命がつきたら成功とするか
	local distRange		= 999;				--	適当な長距離。

	-- 角度判定
	if ai:IsInsideTargetEx( targetType, TARGET_SELF, dirType, turnAng, distRange) then
		-- 指定角度分だけ移動し、相手の方を向いている
		return GOAL_RESULT_Success;
	end
	
	-- 寿命尽きたら成功にする
	if bLifeSucces ~= 0.0 then
		if goal:GetLife() <= 0.0 then
			return GOAL_RESULT_Success;
		end
	end
	
	-- 移動できなくなっていたら、終了させる。
	if ( ai:CannotMove()) then
		return GOAL_RESULT_Success;
	end

	return GOAL_RESULT_Continue;
end

--[[***************************************************************************
	終了
*****************************************************************************]]
function TurnAround_Terminate(ai, goal) end
--[[***************************************************************************
	割り込み
*****************************************************************************]]
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_TurnAround, true);
function TurnAround_Interupt(ai, goal) return false; end
