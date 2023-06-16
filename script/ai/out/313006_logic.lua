--[[*******************************************************************************************
	坑道３特定位置用の羽クマムシ用の思考ロジック
	説明：
		
	作成：hasem 08/7/26
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_HaneKuma313006, "SpHaneKuma313006_Logic", "SpHaneKuma313006_Interupt");

--[[**********************************************************************
	ロジック。
************************************************************************]]
function SpHaneKuma313006_Logic(ai)

	--まずは、着地していたら、空中に上がろう。
	if ( ai:IsLanding()) then
		ai:AddTopGoal( GOAL_COMMON_Attack, 10, 9520, TARGET_NONE, DIST_None);
	end
	

	--ターゲットが指定領域内にいない場合、即初期位置に帰る。
	if ( ai:IsInsideTargetRegion(TARGET_ENE_0, 2290) ) then
		
		--通常ロジック。
		COMMON_EasySetup3(ai);
	
	else
	
		--問答無用で初期位置に戻る。
		ai:AddTopGoal( GOAL_kuma_ApproachXZAndFall, 10);
		
	end
	
end

--[[**********************************************************************
	割り込み。
************************************************************************]]
function SpHaneKuma313006_Interupt(ai, goal)
	return false;
end





--[[******************************************************************************************************]]
--[[************************************** 羽クマムシ用サブゴール ****************************************]]
--[[******************************************************************************************************]]


--[[*******************************************************************************************
	初期位置に戻る。
*********************************************************************************************]]
REGISTER_GOAL(GOAL_kuma_ApproachXZAndFall, "ApproachXZAndFall");
REGISTER_GOAL_NO_UPDATE( GOAL_kuma_ApproachXZAndFall, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_kuma_ApproachXZAndFall, true);
function ApproachXZAndFall_Activate( ai, goal )

	-- まずは、初期位置に向かう。
	goal:AddSubGoal( GOAL_kuma_ApproachIniXZ, 3);
	
	-- 止まる。
	goal:AddSubGoal( GOAL_COMMON_Fall, 3, POINT_INITIAL, 9510, 9520, -10);
	
end
function ApproachXZAndFall_Update( ai, goal ) return GOAL_RESULT_Continue; end
function ApproachXZAndFall_Terminate( ai, goal ) end
function ApproachXZAndFall_Interupt( ai, goal )	return false; end




--[[*******************************************************************************************
	XZ平面上で移動する。
	単に終了条件が、XZ平面距離というだけ。
*********************************************************************************************]]
REGISTER_GOAL(GOAL_kuma_ApproachIniXZ, "ApproachIniXZ");
REGISTER_GOAL_NO_INTERUPT( GOAL_kuma_ApproachIniXZ, true);
function ApproachIniXZ_Activate( ai, goal )
	goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 3, POINT_INITIAL, AI_DIR_TYPE_CENTER, 1, TARGET_SELF, false);
end
function ApproachIniXZ_Update( ai, goal )

--[[企画さん調整項目]]

	--XZ平面で、これより接近したら、このゴールを終了する。
	local NEAR_RANGE 	= 2;

--[[企画さん調整項目]]



	local distXZ 		= ai:GetDistXZ(POINT_INITIAL);
	if ( distXZ < NEAR_RANGE ) then
		return GOAL_RESULT_Success;
	end
	
	return GOAL_RESULT_Continue; 
end
function ApproachIniXZ_Terminate( ai, goal )end
function ApproachIniXZ_Interupt( ai, goal )	return false; end




