//%attributes = {"invisible":true}
//  G_Insp_ApproveReject_new
//Method to Approve/Reject Inspections
//Called from bzApprove button of [Inspections];"InspectionReview" form.

//  `Copied from G_Insp_ApproveReject method 
//  `Now uses method INSP_ReviewAction
If (False:C215)
	
	Mods_2005_CM05  //- twice
	// Modified by: costasmanousakis-(Designer)-(2/27/2006 13:56:46)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(12/21/2006 16:18:09)
	Mods_2006_CM07
	// Modified by: costasmanousakis-(Designer)-(2/14/2007 10:06:19)
	Mods_2007_CM06
	// Modified by: costasmanousakis-(Designer)-(8/29/2007 11:44:07)
	Mods_2007_CM12_5301
	Mods_2009_03  //CJM  r001   `03/06/09, 14:26:25`Upgrade from open form window to open window
	// Modified by: costasmanousakis-(Designer)-(2/12/10 13:44:46)
	Mods_2010_02
	//  `Adjustments to allow reviews of multiple Insp resp bridges.
	//  `And on DBIE Reject/Approve dont prompt to send email if Cancel was pressed on the dialog 
	// Modified by: costasmanousakis-(Designer)-(8/27/10 15:06:55)
	Mods_2010_08
	//  `Changed method of looping thru records : Go thru the whole selection and check if the record is highlighted
	//  `Modified the ALerts when Inspection is not ready for review to add more info re the inspection
	// Modified by: costasmanousakis-(Designer)-(8/30/10 09:26:05)
	Mods_2010_08
	//  `Create a selection that is in the same order as the current llist from the UserSet 
	//  `- use new method ut_SelectionFromUserSet
	// Modified by: costasmanousakis-(Designer)-(10/16/11 15:30:00)
	Mods_2011_10
	//Use INSP_ReviewAction
	// Modified by: Costas Manousakis-(Designer)-(4/1/16 17:40:04)
	Mods_2016_04_bug
	//  `added ut_UnloadAllTables - need twice - one to set arrays - one to unload tables
End if 

C_TEXT:C284($msg; vTextMsg; vtRevComments; vtPrevRevComments)
C_BOOLEAN:C305(INSP_OneStepApprove_b)
C_LONGINT:C283(vbAccept; vbReject)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($sRevType)  // Command Replaced was o_C_STRING length was 80
C_BOOLEAN:C305($bOKtoApprove)

C_LONGINT:C283($LRecsInSet; $i; $RecordsInSele_L; $tempWin)
$LRecsInSet:=Records in set:C195("UserSet")
$RecordsInSele_L:=Records in selection:C76([Inspections:27])
If ($LRecsInSet>0)
	ut_SelectionFromUserSet("CREATE"; ->[Inspections:27]; "StartingInspects"; "TempUserSet1")
	
	FIRST RECORD:C50([Inspections:27])
	For ($i; 1; $LRecsInSet)
		
		RELATE ONE:C42([Inspections:27]BIN:1)
		RELATE ONE:C42([Inspections:27]Insp Type:6)
		C_LONGINT:C283($StartApproveLvl_L)
		$StartApproveLvl_L:=vApproveLvl
		INSP_ReviewAction
		vApproveLvl:=$StartApproveLvl_L
		NEXT RECORD:C51([Inspections:27])
		
	End for   //end of selected record loop
	
	ut_UnloadAllTables("SET")
	ut_UnloadAllTables
	
	
	vbSortedHeader:=True:C214  //do not do a header sort
	
	ut_SelectionFromUserSet("RESTORE"; ->[Inspections:27]; "StartingInspects"; "TempUserSet1")
	
Else 
	ALERT:C41("You must first Highlight Records to Approve!")
End if 