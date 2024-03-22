//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/25/11, 09:06:09
	// ----------------------------------------------------
	// Method: Method: G_Insp_ReviewUtils
	// Description
	//  ` Utitlities for  Inspection review screen
	// 
	// Parameters
	// $1 : $Task_txt (REMOVEApprove | REMOVEReview | DBIEREVIEW | AREAREVIEW) - Optional
	// ----------------------------------------------------
	
	Mods_2011_08
End if 

C_TEXT:C284($1; $Task_txt)
$Task_txt:=""
If (Count parameters:C259>0)
	$Task_txt:=$1
Else 
	ARRAY TEXT:C222($ReviewUtils_atxt; 0)
	ARRAY TEXT:C222($ReviewUtilsDesc_atxt; 0)
	APPEND TO ARRAY:C911($ReviewUtils_atxt; "REMOVEApprove")
	APPEND TO ARRAY:C911($ReviewUtils_atxt; "REMOVEReview")
	APPEND TO ARRAY:C911($ReviewUtils_atxt; "DBIEREVIEW")
	APPEND TO ARRAY:C911($ReviewUtils_atxt; "AREAREVIEW")
	APPEND TO ARRAY:C911($ReviewUtilsDesc_atxt; "REMOVE Approval Check")
	APPEND TO ARRAY:C911($ReviewUtilsDesc_atxt; "REMOVE Review Check")
	APPEND TO ARRAY:C911($ReviewUtilsDesc_atxt; "Switch to DBIE REVIEW")
	APPEND TO ARRAY:C911($ReviewUtilsDesc_atxt; "Switch to AREA Eng REVIEW")
	C_LONGINT:C283($choise_L)
	$choise_L:=G_PickFromList(->$ReviewUtilsDesc_atxt)
	If ($choise_L>0)
		$Task_txt:=$ReviewUtils_atxt{$choise_L}
	End if 
	
End if 

Case of 
	: ($Task_txt="REMOVEApprove")
		C_LONGINT:C283($LRecsInSet; $i; $RecordsInSele_L; $tempWin)
		$LRecsInSet:=Records in set:C195("UserSet")
		$RecordsInSele_L:=Records in selection:C76([Inspections:27])
		If ($LRecsInSet>0)
			ut_SelectionFromUserSet("CREATE"; ->[Inspections:27]; "StartingInspects"; "TempUserSet1")
			
			FIRST RECORD:C50([Inspections:27])
			For ($i; 1; $LRecsInSet)
				[Inspections:27]InspApproved:167:=0  //mark inspection as rejected
				[Inspections:27]InspAreaEngApprDate:207:=!00-00-00!
				InitChangeStack(1)
				PushChange(1; ->[Inspections:27]InspApproved:167)
				PushChange(1; ->[Inspections:27]InspAreaEngApprDate:207)
				FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
				SAVE RECORD:C53([Inspections:27])
				
				NEXT RECORD:C51([Inspections:27])
				
			End for   //end of selected record loop
			
			vbSortedHeader:=True:C214  //do not do a header sort
			
			ut_SelectionFromUserSet("RESTORE"; ->[Inspections:27]; "StartingInspects"; "TempUserSet1")
			
		Else 
			ALERT:C41("You must first Highlight Records to use the REMOVEApprove utility!")
		End if 
		
	: ($Task_txt="REMOVEReview")
		C_LONGINT:C283($LRecsInSet; $i; $RecordsInSele_L; $tempWin)
		$LRecsInSet:=Records in set:C195("UserSet")
		$RecordsInSele_L:=Records in selection:C76([Inspections:27])
		If ($LRecsInSet>0)
			ut_SelectionFromUserSet("CREATE"; ->[Inspections:27]; "StartingInspects"; "TempUserSet1")
			
			FIRST RECORD:C50([Inspections:27])
			For ($i; 1; $LRecsInSet)
				[Inspections:27]InspReviewed:12:=0  //mark inspection as rejected
				[Inspections:27]InspDBIEApprDate:206:=!00-00-00!
				InitChangeStack(1)
				PushChange(1; ->[Inspections:27]InspReviewed:12)
				PushChange(1; ->[Inspections:27]InspDBIEApprDate:206)
				FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
				SAVE RECORD:C53([Inspections:27])
				
				NEXT RECORD:C51([Inspections:27])
				
			End for   //end of selected record loop
			
			vbSortedHeader:=True:C214  //do not do a header sort
			
			ut_SelectionFromUserSet("RESTORE"; ->[Inspections:27]; "StartingInspects"; "TempUserSet1")
			
		Else 
			ALERT:C41("You must first Highlight Records to use the REMOVEReview utility!")
		End if 
		
	: ($Task_txt="DBIEREVIEW")
		ALERT:C41("Setting Aprrove level to 1 - DBIE approval!")
		vApproveLvl:=1
		
	: ($Task_txt="AREAREVIEW")
		ALERT:C41("Setting Aprrove level to 2 - AE approval!")
		vApproveLvl:=2
		
End case 