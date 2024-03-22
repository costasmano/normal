PRJ_DEBridgeNo_s:=Substring:C12(PRJ_ItemDescription_atxt{PRJ_ItemDescription_atxt}; 1; 6)

POST OUTSIDE CALL:C329(<>ProjectProcess_l)
HIDE PROCESS:C324(Current process:C322)
PAUSE PROCESS:C319(Current process:C322)