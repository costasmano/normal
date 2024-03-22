//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/27/09, 10:02:10
	// ----------------------------------------------------
	// Method: PRJ_QRBINList
	// Description
	// Return the list of BINs associated with a project
	// Must have a [PRJ_ProjectDetails] record current
	// 
	// Parameters
	// $0 : Res_txt : result
	// ----------------------------------------------------
	
	Mods_2009_CM_5404
End if 
C_TEXT:C284($0; $Res_txt)
$Res_txt:=""
If ([PRJ_ProjectDetails:115]PRJ_ProjectID_l:1#0)
	READ ONLY:C145([PRJ_ProjectDetailsIncludedBINS:122])
	QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
	If (Records in selection:C76([PRJ_ProjectDetailsIncludedBINS:122])>0)
		ARRAY TEXT:C222($inclBIns_atxt; 0)
		SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; $inclBIns_atxt)
		SORT ARRAY:C229($inclBIns_atxt)
		$Res_txt:=$inclBIns_atxt{1}
		C_LONGINT:C283($Loop_L)
		For ($Loop_L; 2; Size of array:C274($inclBIns_atxt))
			$Res_txt:=$Res_txt+","+$inclBIns_atxt{$Loop_L}
		End for 
	End if 
	
	READ WRITE:C146([PRJ_ProjectDetailsIncludedBINS:122])
End if 

$0:=$Res_txt