//%attributes = {"invisible":true}
//Method: Insp_SortElmtSfty
//Description
//  ` Sort the current selection of ElementsSafety based on the current Inspection type.
//  ` Inspection type can be passed as an argumanet (optional)

// Parameters
// $1 : $InspType_txt (Optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/28/12, 10:24:36
	// ----------------------------------------------------
	//Created : 
	Mods_2012_12
	// Modified by: Costas Manousakis-(Designer)-(10/25/19 12:29:35)
	Mods_2019_10_bug
	//  `use the same method for PED inspections as for RR@ inspections - CallReference #667
End if 
//
C_TEXT:C284($InspType_txt)

If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$InspType_txt:=$1
Else 
	$InspType_txt:=[Inspections:27]Insp Type:6
End if 

Case of 
	: ($InspType_txt="RTA")
		ORDER BY:C49([ElementsSafety:29]; [ElementDict:30]Category:3; >; [ElementDict:30]FullLabelArch:14; >)
		
	: ([Inspections:27]Insp Type:6="RR@")
		ARRAY LONGINT:C221($elmRecNos_aL; Records in selection:C76([ElementsSafety:29]))
		ARRAY INTEGER:C220($elmDictNos_ai; Records in selection:C76([ElementsSafety:29]))
		SELECTION TO ARRAY:C260([ElementsSafety:29]; $elmRecNos_aL; [ElementsSafety:29]ElementNo:1; $elmDictNos_ai)
		ARRAY LONGINT:C221($elmSortedby_aL; Records in selection:C76([ElementsSafety:29]))
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($elmDictNos_ai))
			$elmSortedby_aL{$loop_L}:=Find in array:C230(INSP_NewElementNumbers_ai; $elmDictNos_ai{$loop_L})
		End for 
		SORT ARRAY:C229($elmSortedby_aL; $elmRecNos_aL)
		CREATE SELECTION FROM ARRAY:C640([ElementsSafety:29]; $elmRecNos_aL)
		
	: ([Inspections:27]Insp Type:6="PED")
		ARRAY LONGINT:C221($elmRecNos_aL; Records in selection:C76([ElementsSafety:29]))
		ARRAY INTEGER:C220($elmDictNos_ai; Records in selection:C76([ElementsSafety:29]))
		SELECTION TO ARRAY:C260([ElementsSafety:29]; $elmRecNos_aL; [ElementsSafety:29]ElementNo:1; $elmDictNos_ai)
		ARRAY LONGINT:C221($elmSortedby_aL; Records in selection:C76([ElementsSafety:29]))
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($elmDictNos_ai))
			$elmSortedby_aL{$loop_L}:=Find in array:C230(INSP_NewElementNumbers_ai; $elmDictNos_ai{$loop_L})
		End for 
		SORT ARRAY:C229($elmSortedby_aL; $elmRecNos_aL)
		CREATE SELECTION FROM ARRAY:C640([ElementsSafety:29]; $elmRecNos_aL)
		
	: ([Inspections:27]Insp Type:6="T@")
		ARRAY LONGINT:C221($elmRecNos_aL; Records in selection:C76([ElementsSafety:29]))
		ARRAY INTEGER:C220($elmDictNos_ai; Records in selection:C76([ElementsSafety:29]))
		SELECTION TO ARRAY:C260([ElementsSafety:29]; $elmRecNos_aL; [ElementsSafety:29]ElementNo:1; $elmDictNos_ai)
		ARRAY LONGINT:C221($elmSortedby_aL; Records in selection:C76([ElementsSafety:29]))
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($elmDictNos_ai))
			$elmSortedby_aL{$loop_L}:=Find in array:C230(INSP_NewElementNumbers_ai; $elmDictNos_ai{$loop_L})
		End for 
		SORT ARRAY:C229($elmSortedby_aL; $elmRecNos_aL)
		CREATE SELECTION FROM ARRAY:C640([ElementsSafety:29]; $elmRecNos_aL)
		
	Else 
		ORDER BY:C49([ElementsSafety:29]; [ElementDict:30]Category:3; >; [ElementDict:30]FullLabel:13; >)
		
End case 

//End Insp_SortElmtSfty