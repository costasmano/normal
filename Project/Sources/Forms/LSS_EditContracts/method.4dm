//Form Method: "LSS_EditContracts"
//Description
// Form to edit system parameter LSS_Contracts
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Feb 8, 2024, 19:22:43
	Mods_2024_LSS_1
	// ----------------------------------------------------
	
	
End if 
//
C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388
Case of 
	: ($FormEvent_L=On Load:K2:1)
		//load the LSS Contracts from parameter LSS_Contracts
		SET WINDOW TITLE:C213("Ancillary Structure Contracts")
		C_TEXT:C284($Contracts_txt)
		$Contracts_txt:=ut_GetSysParameter("LSS_Contracts")
		
		If ($Contracts_txt#"")
			C_COLLECTION:C1488($contracts_c)
			$contracts_c:=JSON Parse:C1218($Contracts_txt; Is collection:K8:32)
			//$contracts_c.orderBy("ContractNo asc")
			Form:C1466.LssContracts:=$contracts_c
		End if 
		LISTBOX SORT COLUMNS:C916(*; "LSSContracts"; 1; >)
		
		// merge with Employers from Personnel
		C_COLLECTION:C1488($empl_c; $OmitEmpl_c; $list_c)
		$OmitEmpl_c:=New collection:C1472
		$OmitEmpl_c.push("Mass. Highway@")
		$OmitEmpl_c.push("Mass. TurnPike@")
		$OmitEmpl_c.push("MassDOT Rail")
		$OmitEmpl_c.push("KEOLIS")
		$OmitEmpl_c.push("InspectTech@")
		$OmitEmpl_c.push("MBTA")
		$OmitEmpl_c.push("DCR")
		$OmitEmpl_c.push("MDC")
		$OmitEmpl_c.push("Massport")
		$OmitEmpl_c.push("FHWA")
		$OmitEmpl_c.push("MHD Underwater@")
		$OmitEmpl_c.push("")
		
		$empl_c:=ds:C1482.Personnel.query("NOT(Employer In :1)"; $OmitEmpl_c).distinct("Employer")
		ARRAY TEXT:C222($list_atxt; 0)
		LIST TO ARRAY:C288("Employers"; $list_atxt)
		$list_c:=New collection:C1472
		ARRAY TO COLLECTION:C1563($list_c; $list_atxt)
		$empl_c:=$list_c.combine($empl_c)
		$empl_c:=$empl_c.distinct()
		
		C_TEXT:C284($emp_txt)
		For each ($emp_txt; $OmitEmpl_c)
			If ($empl_c.indexOf($emp_txt)>=0)
				$empl_c.remove($empl_c.indexOf($emp_txt))
			End if 
		End for each 
		
		Form:C1466.ConsultantList:=$empl_c
		
	: ($FormEvent_L=On Validate:K2:3)
	: ($FormEvent_L=On Close Box:K2:21)
		CONFIRM:C162("Exit without saving any changes?"; "Exit"; "Cancel")
		If (OK=1)
			CANCEL:C270
		Else 
			REJECT:C38
		End if 
End case 

//End "LSS_EditContracts"