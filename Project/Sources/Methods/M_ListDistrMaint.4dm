//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/01/09, 11:22:33
	// ----------------------------------------------------
	// Method: M_ListDistrMaint
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_05
	// Modified by: costasmanousakis-(Designer)-(12/1/10 16:09:30)
	Mods_2010_12
	//  `Added search for contracts belonging only to my district
	// Modified by: costasmanousakis-(Designer)-(4/6/11 14:16:00)
	Mods_2011_04
	//  `Added declaration of parameter 1
	Mods_2020_12  // Modifed to add current method name to ut_UseListBox call
	//Modified by: CJ (12/22/20 14:45:46)
	
End if 
If (Count parameters:C259=0)
	C_LONGINT:C283($Lpid)
	$Lpid:=LSpawnProcess("M_ListDistrMaint"; <>LStackSize; "DistrMaint"; True:C214; False:C215; "RUN")
Else 
	Compiler_LB
	C_TEXT:C284($1)
	
	C_TEXT:C284(MainTitle)  // Command Replaced was o_C_STRING length was 255
	
	InitProcessVar
	pFile:=->[DCM_Contracts:136]
	SHORT_MESSAGE("Retrieving data. Please wait…")
	
	MainTitle:="District Bridge Maint. Contracts"
	
	If (<>PERS_MyDivision_txt="")
		ALL RECORDS:C47([DCM_Contracts:136])
	Else 
		C_LONGINT:C283($mydistr_L)
		$mydistr_L:=Num:C11(Substring:C12(<>PERS_MyDivision_txt; Length:C16(<>PERS_MyDivision_txt)))
		If ($mydistr_L>0)
			ARRAY TEXT:C222($MydistrContracts_as; 0)  //Command Replaced was o_ARRAY string length was 20
			QUERY:C277([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_AELocation_s:23="District "+String:C10($mydistr_L))
			ARRAY TEXT:C222($MydistrContracts_as; Records in selection:C76([PRJ_ConstructionProject:116]))  //Command Replaced was o_ARRAY string length was 20
			SELECTION TO ARRAY:C260([PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5; $MydistrContracts_as)
			QUERY WITH ARRAY:C644([DCM_Contracts:136]ContractNo:1; $MydistrContracts_as)
		Else 
			ALL RECORDS:C47([DCM_Contracts:136])
		End if 
		
	End if 
	
	ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ContractNo:1; >)
	
	CLOSE WINDOW:C154  //close message window
	C_BOOLEAN:C305($UseLB_B)
	$UseLB_B:=ut_UseListBox(Current method name:C684)
	If ($UseLB_B)
		$FormName_txt:="DCM_Contracts_LB"
	Else 
		$FormName_txt:="Output"
	End if 
	FORM SET INPUT:C55([DCM_Contracts:136]; "DistrMaintInput")
	FORM SET OUTPUT:C54([DCM_Contracts:136]; $FormName_txt)
	C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 10
	$RecSel:=String:C10(Records in selection:C76([DCM_Contracts:136]))
	COPY NAMED SELECTION:C331([DCM_Contracts:136]; "UserRegionA")  //save the selection
	SET MENU BAR:C67(7)
	C_TEXT:C284($FormName_txt)
	
	C_LONGINT:C283($Width_i_l; $Height_i_l; $Width_l; $Height_l)
	FORM GET PROPERTIES:C674([DCM_Contracts:136]; "DistrMaintInput"; $Width_i_l; $Height_i_l)
	FORM GET PROPERTIES:C674([DCM_Contracts:136]; $FormName_txt; $Width_l; $Height_l)
	If ($Width_i_l>$Width_l)
		$Width_l:=$Width_i_l
	Else 
		$Width_l:=$Width_l+20
	End if 
	If ($Height_i_l>$Height_i_l)
		$Height_l:=$Height_i_l
	End if 
	If ($Height_l<550)
		$Height_l:=550
	End if 
	
	C_LONGINT:C283($Win_L)
	$Win_L:=ut_OpenNewWindow($Width_l; $Height_l; 1; Plain form window:K39:10; MainTitle+" ["+$RecSel+"]"; "ut_CloseCancel")
	//NewWindow ($Width_l;$Height_l;1;Plain window)
	//SET WINDOW RECT(16;44;16+$Width_l;44+$Height_l)
	
	UpdatWindArray(""; Current process:C322)
	SET WINDOW TITLE:C213(MainTitle+" ["+$RecSel+"]")
	If ($UseLB_B)
		DIALOG:C40([DCM_Contracts:136]; $FormName_txt)
	Else 
		MODIFY SELECTION:C204([DCM_Contracts:136]; *)  //Display output form even for one record
	End if 
	CLEAR NAMED SELECTION:C333("UserRegionA")
	UpdatWindArray(""; Current process:C322)
	CLOSE WINDOW:C154
End if 