//%attributes = {"shared":true}
// Method: QR_ConsInspElecSubm
// Description
// Calculate the electronic submittal col for consultant inspections. Searches in [Inspections] table
// to find matching non-dive inspection in the inspection month, by a consultant. Results are 
// "Not Started", "In Progress", "Late"
// Parameters
// $0 : ElecSubmittal : Text
// $1 : Sortable (optional - pass "sort" to return a sortable string (ISO date) )
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/07/06, 16:30:23
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(11/8/2007 08:56:49)
	Mods_2007_CM12_5302
	// Modified by: Costas Manousakis-(Designer)-(2/26/20 17:27:14)
	Mods_2020_02_bug
	//  `changed sequence of search in [inspections] to improve speed - leave the agency search last.
	//  `CallReference #701
	// Modified by: Costas Manousakis-(Designer)-(8/7/20 11:02:51)
	Mods_2020_08_bug
	//  `check Inspections table only if status is not Completed or Rescinded or if NTP and NTP verbal are 00/00/00
	//  `set auto relations to false at start
	// Modified by: Costas Manousakis-(Designer)-(2021-10-04T00:00:00 17:19:36)
	Mods_2021_10
	//  `added optional 1st param to indicate if return values should be sortable - pass a string starting with "S"
End if 
C_TEXT:C284($0; $vInspProgress_txt)
If (([Cons Inspection:64]AssignStatus:24="Completed") | ([Cons Inspection:64]AssignStatus:24="Rescinded") | \
(([Cons Inspection:64]NTPdate_verbal:35=!00-00-00!) & ([Cons Inspection:64]ProceedConDate:8=!00-00-00!)))
	$vInspProgress_txt:=""
Else 
	C_BOOLEAN:C305($sortable_b)
	$sortable_b:=False:C215
	If (Count parameters:C259>0)
		C_TEXT:C284($1)
		$sortable_b:=($1="S@")
	End if 
	
	C_TEXT:C284($InspMo_S; $InspYear_S)  // **Replaced old C_STRING length 4
	C_DATE:C307($MonthStart_D; $MonthEnd_D)
	$vInspProgress_txt:=""
	$InspMo_S:=String:C10(Month of:C24([Cons Inspection:64]InspMonth:34))
	$InspYear_S:=String:C10(Year of:C25([Cons Inspection:64]InspMonth:34))
	$MonthStart_D:=Date:C102($InspMo_S+"/01/"+$InspYear_S)
	
	$MonthEnd_D:=Add to date:C393($MonthStart_D; 0; 4; 0)  // add 4 months to the start date
	
	C_BOOLEAN:C305($InspTableRO_b; $One_b; $many_b)
	$InspTableRO_b:=Read only state:C362([Inspections:27])
	GET AUTOMATIC RELATIONS:C899($One_b; $many_b)
	SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)  // to avoid loading other records
	READ ONLY:C145([Inspections:27])
	
	QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[Cons Inspection:64]BIN:1; *)
	QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6#"DV@")
	//QUERY SELECTION([Inspections]; & ;[Inspections]Insp Type#"DV@";*)
	QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Date:78>=$MonthStart_D; *)
	QUERY SELECTION:C341([Inspections:27];  & ; [Inspections:27]Insp Date:78<$MonthEnd_D)
	QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Agency:156#"Mass. Highway@")
	
	C_DATE:C307($Curr_month_D; $Last_month_D)
	$Curr_month_D:=Date:C102(String:C10(Month of:C24(Current date:C33(*)))+"/01/"+String:C10(Year of:C25(Current date:C33(*))))
	$Last_month_D:=Add to date:C393($Curr_month_D; 0; -1; 0)
	
	If (Records in selection:C76([Inspections:27])>0)
		
		If ([Inspections:27]ConsAcceptanceDate:202#!00-00-00!)
			
			If ($sortable_b)
				$vInspProgress_txt:=String:C10([Inspections:27]ConsAcceptanceDate:202; ISO date:K1:8)
			Else 
				$vInspProgress_txt:=String:C10([Inspections:27]ConsAcceptanceDate:202)
			End if 
		Else 
			$vInspProgress_txt:="In Progress"
			If ([Cons Inspection:64]InspMonth:34<$Last_month_D)
				$vInspProgress_txt:="Late"
			End if 
			
		End if 
	Else 
		$vInspProgress_txt:="Not Started"
		If ([Cons Inspection:64]InspMonth:34<$Last_month_D)
			$vInspProgress_txt:="Late"
		End if 
	End if 
	
	SET AUTOMATIC RELATIONS:C310($One_b; $many_b)
	If (Not:C34($InspTableRO_b))
		READ WRITE:C146([Inspections:27])
	End if 
	
End if 

$0:=$vInspProgress_txt