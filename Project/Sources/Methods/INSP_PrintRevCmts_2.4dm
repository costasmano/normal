//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/17/07, 11:13:23
	// ----------------------------------------------------
	// Method: INSP_PrintRevCmts_2
	// Description
	// called from the approve/reject dialog
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:42:49)
	Mods_2007_CM12_5301
End if 

C_TEXT:C284(vRemarks; $DBIERemarks_txt; $AERemarks_txt)
C_TEXT:C284(vtRevComments; $CurrentCmts_txt)
If (vtRevComments#"")
	$CurrentCmts_txt:=Current user:C182+" - "+String:C10(Current date:C33(*); Internal date short:K1:7)+" : "+vtRevComments
Else 
	$CurrentCmts_txt:=""
End if 

vRemarks:=""
If (Length:C16([Inspections:27]InspRevCmts:170)>0)
	$DBIERemarks_txt:="DBIE COMMENTS:"+<>sCR+[Inspections:27]InspRevCmts:170
End if 
If (Length:C16([Inspections:27]InspApprCmts:169)>0)
	$AERemarks_txt:="AREA ENGINEER COMMENTS:"+<>sCR+[Inspections:27]InspApprCmts:169
End if 
If ($CurrentCmts_txt#"")
	Case of 
		: (vApproveLvl=1)
			If ($DBIERemarks_txt#"")
				$DBIERemarks_txt:=$DBIERemarks_txt+<>sCR+<>sCR+$CurrentCmts_txt
			Else 
				$DBIERemarks_txt:="DBIE COMMENTS:"+<>sCR+$CurrentCmts_txt
			End if 
			
		: (vApproveLvl=2)
			If ($AERemarks_txt#"")
				$AERemarks_txt:=$AERemarks_txt+<>sCR+<>sCR+$CurrentCmts_txt
			Else 
				$AERemarks_txt:="AREA ENGINEER COMMENTS:"+<>sCR+$CurrentCmts_txt
			End if 
			
	End case 
	
End if 
If ($DBIERemarks_txt#"")
	vRemarks:=$DBIERemarks_txt
End if 
If ($AERemarks_txt#"")
	If (vRemarks#"")
		vRemarks:=vRemarks+<>sCR+<>sCR+$AERemarks_txt
	Else 
		vRemarks:=$AERemarks_txt
	End if 
	
End if 

If (vRemarks#"")
	C_TEXT:C284(sBDEPT; sBDEPT_P; sTOWN; sInspDATE)  // Command Replaced was o_C_STRING length was 80
	G_SIA_BuildTownLine
	sInspDATE:=Uppercase:C13(String:C10([Inspections:27]Insp Date:78; Internal date abbreviated:K1:6))
	G_PrintOptions
	FORM SET OUTPUT:C54([Inspections:27]; "Routine Remarks")
	PRINT RECORD:C71([Inspections:27])
	FORM SET OUTPUT:C54([Inspections:27]; "InspectionReview")
Else 
	ALERT:C41("No Review Comments available!!!")
End if 
$DBIERemarks_txt:=""
$AERemarks_txt:=""
vRemarks:=""