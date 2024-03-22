If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222(cboBridgePrjMgr; 0)
	ut_GetGroupMembers("BridgeMaintCtrl"; ->cboBridgePrjMgr)
	INSERT IN ARRAY:C227(cboBridgePrjMgr; 1; 1)
	cboBridgePrjMgr{1}:=""
	SORT ARRAY:C229(cboBridgePrjMgr)
End if 
POPUPMENUC(Self:C308; Self:C308; ->[Contract_Maintenance:97]BridgePrjMgr:33)