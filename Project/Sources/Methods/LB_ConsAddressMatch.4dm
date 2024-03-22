//%attributes = {"invisible":true}
//Method: LB_ConsAddressMatch
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 07/02/20, 16:21:21
	// ----------------------------------------------------
	//Created : 
	Mods_2020_07
	Mods_2020_10  //Fix sort direction issue where pointer was not set correctly
	//Modified by: CJ (10/6/20 13:35:45)
	
End if 
//
Case of 
	: (Form event code:C388=On Open Detail:K2:23)
		ut_SetWindowSize("create"; Current method name:C684)
	: (Form event code:C388=On Close Detail:K2:24)
		ut_SetWindowSize("Reset"; Current method name:C684)
	: (Form event code:C388=On Header Click:K2:40)
		
		C_TEXT:C284($NameofObj_txt; $SortVariableName_txt)
		C_LONGINT:C283($dumTbl_L; $dumFld_L)
		C_POINTER:C301($SortVariable_ptr)
		
		RESOLVE POINTER:C394(Self:C308; $NameofObj_txt; $dumTbl_L; $dumFld_L)
		//$SortVariableName_txt:=Replace string($NameofObj_txt;"Header";"SortDirection")
		$SortVariable_ptr:=Get pointer:C304($NameofObj_txt)
		
		
		Case of 
			: ($NameofObj_txt="LB_Header1_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([Conslt Address:77]; [Conslt Address:77]ConsltName:2; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Conslt Address:77]; [Conslt Address:77]ConsltName:2; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
				
			: ($NameofObj_txt="LB_Header2_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([Conslt Address:77]; [Conslt Address:77]ContactLName:4; >; [Conslt Address:77]ContactFName:3; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Conslt Address:77]; [Conslt Address:77]ContactLName:4; <; [Conslt Address:77]ContactFName:3; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
				
			: ($NameofObj_txt="LB_Header3_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([Conslt Address:77]; [Conslt Address:77]Func_Insp:20; <)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Conslt Address:77]; [Conslt Address:77]Func_Insp:20; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
			: ($NameofObj_txt="LB_Header5_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([Conslt Address:77]; [Conslt Address:77]City:10; >\
						; [Conslt Address:77]State:11; >\
						; [Conslt Address:77]Zip:12; >)
					
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Conslt Address:77]; [Conslt Address:77]City:10; <\
						; [Conslt Address:77]State:11; <\
						; [Conslt Address:77]Zip:12; <)
					
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
				
			Else 
				ALERT:C41("Sorting no enabled for these columns")
		End case 
		Self:C308->:=$SortVariable_ptr->
End case 
//End lB_ConsAddressMatch