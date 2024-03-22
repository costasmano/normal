//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/27/09, 09:50:00
	// ----------------------------------------------------
	// Method: PRJ_QRSDFOStatus
	// Description
	// Return the SD/FO status of the current Bridge project
	// Must have a [PRJ_ProjectDetails] record current
	// Parameters
	// $0 : Res_txt : result
	// ----------------------------------------------------
	
	Mods_2009_CM_5404
End if 
C_TEXT:C284($0; $Res_txt)
$Res_txt:=""
If ([PRJ_ProjectDetails:115]PRJ_ProjectID_l:1#0)
	READ ONLY:C145([Bridge MHD NBIS:1])
	READ ONLY:C145([PRJ_ProjectDetailsIncludedBINS:122])
	QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
	If (Records in selection:C76([PRJ_ProjectDetailsIncludedBINS:122])>0)
		ARRAY TEXT:C222($inclBIns_atxt; 0)
		SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; $inclBIns_atxt)
		QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BIN:3; $inclBIns_atxt)
		ARRAY BOOLEAN:C223($SDstat_ab; 0)
		ARRAY BOOLEAN:C223($FOstat_ab; 0)
		SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]StructDef:103; $SDstat_ab; [Bridge MHD NBIS:1]FunctObs:106; $FOstat_ab)
		C_LONGINT:C283($Loop_L)
		C_BOOLEAN:C305($SD_b; $FO_B)
		$SD_b:=False:C215
		$FO_B:=False:C215
		For ($Loop_L; 1; Size of array:C274($SDstat_ab))
			$SD_b:=$SD_b | $SDstat_ab{$Loop_L}
			$FO_B:=$FO_B | $FOstat_ab{$Loop_L}
		End for 
		If ($SD_b)
			$Res_txt:="SD"
		End if 
		If ($FO_B)
			If ($Res_txt#"")
				$Res_txt:=$Res_txt+",FO"
			Else 
				$Res_txt:="FO"
			End if 
		End if 
		If ($Res_txt="")
			$Res_txt:="ND"
		End if 
		
	End if 
	
	READ WRITE:C146([Bridge MHD NBIS:1])
	READ WRITE:C146([PRJ_ProjectDetailsIncludedBINS:122])
End if 

$0:=$Res_txt