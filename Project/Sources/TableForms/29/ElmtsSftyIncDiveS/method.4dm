If (False:C215)
	//Form method [ElementsSafety]"ElmtsSftyIncDiveS"
	//Display Safety Elements and lock input fields if Inspection is locked.
	
	// Modified by: costasmanousakis-(Designer)-(8/5/08 10:49:15)
	Mods_2008_CM_5404
	//  `Use method INSP_ElmtSfty_ItemNo
End if 

If (Form event code:C388=On Display Detail:K2:22)
	vItemNo:=INSP_ElmtSfty_ItemNo
	//Display description
	vElmDescr:=[ElementDict:30]Prefix:11+" "+[ElementsSafety:29]Description:22
	If ([ElementDict:30]Parent:4#0)
		//get parent's prefix too
		QUERY:C277([ElementDict:30]; [ElementDict:30]ElementNo:1=[ElementDict:30]Parent:4)
		vElmDescr:=[ElementDict:30]Prefix:11+vElmDescr
	End if 
	
	If (False:C215)  //avoid this 3-oct-2003
		If (vbInspectionLocked)
			//disable entry if inspection is locked
			OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
		Else 
			//otherwise make sure they are enterable    
			OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
		End if 
	End if 
	
End if 