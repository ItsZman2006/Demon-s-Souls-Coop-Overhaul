--[[*******************************************************************************************
	アイテム使用。

	パラメータ0  アーキタイプ別初期パラメータ.xlsのアイテムパラメータの順番（０から）
*********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_UseItem, "UseItem");

-- 更新間隔設定
REGISTER_GOAL_NO_UPDATE(GOAL_COMMON_UseItem, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_UseItem, true);

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_UseItem, 0, "アイテムインデックス", 	0);


--[[*****************************************************
	ゴール開始。
*******************************************************]]
function UseItem_Activate(ai, goal)

	local item_index = goal:GetParam(0);
	
	--アイテムを切り替え。
	ai:ChangeEquipItem( item_index);
	--アイテムの使用。
	goal:AddSubGoal( GOAL_COMMON_Attack, 5, NPC_ATK_Item, TARGET_NONE, DIST_None);
	
end

--[[*****************************************************
	ゴール更新
*******************************************************]]
function UseItem_Update(ai, goal) return GOAL_RESULT_Continue; end

--[[*****************************************************
	ゴール終了。
*******************************************************]]
function UseItem_Terminate(ai, goal) end

--[[*********************
	割り込みなし。
***********************]]
function UseItem_Interupt(ai, goal)return false;end
