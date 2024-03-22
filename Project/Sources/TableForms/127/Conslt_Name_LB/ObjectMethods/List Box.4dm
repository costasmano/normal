//Method: [Conslt_Name].Conslt_Name_LB.List Box
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 07/07/20, 13:33:05
	// ----------------------------------------------------
	//Created : 
	Mods_2020_07
End if 
//

Case of 
	: (Form event code:C388=On Open Detail:K2:23)
		ut_SetWindowSize("create"; Current method name:C684)
	: (Form event code:C388=On Close Detail:K2:24)
		ut_SetWindowSize("RESET"; Current method name:C684)
	: (Form event code:C388=On Header Click:K2:40)
		C_TEXT:C284($NameofObj_txt; $SortVariableName_txt)
		C_LONGINT:C283($dumTbl_L; $dumFld_L)
		C_POINTER:C301($SortVariable_ptr)
		
		RESOLVE POINTER:C394(Self:C308; $NameofObj_txt; $dumTbl_L; $dumFld_L)
		$SortVariableName_txt:=Replace string:C233($NameofObj_txt; "Header"; "SortDirection")
		$SortVariable_ptr:=Get pointer:C304($SortVariableName_txt)
		
		
		Case of 
			: ($NameofObj_txt="LB_Header1_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([Conslt_Name:127]; [Conslt_Name:127]ConsultantName_s:2; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Conslt_Name:127]; [Conslt_Name:127]ConsultantName_s:2; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
				
		End case 
End case 
//End [Conslt_Name].Conslt_Name_LB.List Box