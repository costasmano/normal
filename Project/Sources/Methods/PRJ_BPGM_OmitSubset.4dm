//%attributes = {"invisible":true}
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(6/13/08 09:41:37)
	Mods_2008_CM_5403
	//new method
End if 

If (Records in selection:C76([PRJ_ProjectDetails:115])>0)
	
	If (Records in set:C195("UserSet")>0)
		COPY SET:C600("UserSet"; "PRJBPGMTEMPSELSET")
		CREATE SET:C116([PRJ_ProjectDetails:115]; "PRJBPGMTEMPSTARTSET")
		//USE SET("UserSet")
		DIFFERENCE:C122("PRJBPGMTEMPSTARTSET"; "PRJBPGMTEMPSELSET"; "PRJBPGMTEMPSTARTSET")
		C_BOOLEAN:C305($Useres_b)
		If (Records in set:C195("PRJBPGMTEMPSTARTSET")>0)
			$Useres_b:=True:C214
		Else 
			CONFIRM:C162("Do you want to clear all records listed?")
			$Useres_b:=(OK=1)
		End if 
		If ($Useres_b)
			USE SET:C118("PRJBPGMTEMPSTARTSET")
			If (Size of array:C274(v_115_002_aL)>0)
				PRJ_SetupListBoxDisplayEvent
			Else 
				PRJ_BPGM_LoadArrays
				PRJ_BPGM_DoSort  //re-apply current sort
			End if 
			PRJ_BPGM_WinTitle
			CLEAR SET:C117("PRJBPGMTEMPSTARTSET")
		End if 
	Else 
		ALERT:C41("No Records Selected!!")
	End if 
End if 
