If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(2/13/19 14:38:58)
	Mods_2019_02_bug
	//  `do not search if there are no criteria selected
End if 

If (cbDeficiency=0) & (cbUrgency=0) & (cbElmtCond=0) & (cbElementCat=0) & (cbElemDescTxt=0) & (cbElementTxt=0)
	ALERT:C41("No Search Criteria specified!")
Else 
	CreateRandomSetForDefElement
	vtSearchResultCnt:="Found "+String:C10(Records in set:C195("Random Set"))+" BINs"
	vtSearchResultCnt:=vtSearchResultCnt+<>sCR+"with "+String:C10(Records in set:C195("TotalElmtsFound"))+" Elements"
End if 