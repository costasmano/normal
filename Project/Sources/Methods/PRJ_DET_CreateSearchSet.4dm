//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/11/07, 16:14:46
	// ----------------------------------------------------
	// Method: PRJ_DET_CreateSearchSet
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2009_05  //r001  `05/08/09, 14:08:11  `Continue changes PRJ Design Contract Changes 
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_ConsultantOverideID_l
	//[PRJ_ProjectFile]DC_DesignContractID_l to [PRJ_ProjectDetails]DC_DesignContractID_l
	Mods_2009_06  //r002 `06/11/09, 13:34:23   `Merge PRJ Design Contract Changes
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_TEXT:C284($s)  // Command Replaced was o_C_STRING length was 180
PRJ_BPGM_CleanSearchVars
If (PRJ_SRCH_TotalVars_s#"")
	If ((vAddTo) & (Records in set:C195("PRJ_SearchSet")=0))
		CREATE SET:C116([PRJ_ProjectDetails:115]; "PRJ_SearchSet")
	End if 
	
	SHORT_MESSAGE("Looking…")
	If (PRJ_SRCH_BDEPT_s#"")
		$s:=fRemoveChar(" "; PRJ_SRCH_BDEPT_s)+"@"
		If (PRJ_SearchAll_rb=1)
			ALL RECORDS:C47([PRJ_ProjectDetails:115])
		Else 
			USE SET:C118("PRJ_OriginalSet")
		End if 
		SET QUERY DESTINATION:C396(Into set:K19:2; "PRJ_BridgeSearch")
		QUERY SELECTION:C341([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5=$s)
		SET QUERY DESTINATION:C396(Into set:K19:2; "PRJ_NonBridgeSearch")
		QUERY SELECTION:C341([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_NonBridge_s:7=$s)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		UNION:C120("PRJ_BridgeSearch"; "PRJ_NonBridgeSearch"; "PRJ_BridgeSearch")
		USE SET:C118("PRJ_BridgeSearch")
		CLEAR SET:C117("PRJ_BridgeSearch")
		CLEAR SET:C117("PRJ_NonBridgeSearch")
	End if 
	If (PRJ_SRCH_TownName_s#"")
		$s:=Substring:C12(PRJ_SRCH_TownName_s; 1; 80)+"@"
		If (PRJ_SearchAll_rb=1)
			ALL RECORDS:C47([PRJ_ProjectDetails:115])
		Else 
			USE SET:C118("PRJ_OriginalSet")
		End if 
		QUERY SELECTION:C341([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8=$s)
	End if 
	If (PRJ_SRCH_Program_s#"")
		$s:=Substring:C12(PRJ_SRCH_Program_s; 1; 80)+"@"
		If (PRJ_SearchAll_rb=1)
			ALL RECORDS:C47([PRJ_ProjectDetails:115])
		Else 
			USE SET:C118("PRJ_OriginalSet")
		End if 
		QUERY SELECTION:C341([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_Program_s:23=$s)
	End if 
	If (PRJ_SRCH_Consltant_s#"")
		READ ONLY:C145([Conslt_Name:127])
		READ ONLY:C145([PRJ_DesignContracts:123])
		READ ONLY:C145([PRJ_ProjectFile:117])
		ARRAY LONGINT:C221($DesIDS_AL; 0)
		$s:=Substring:C12(PRJ_SRCH_Consltant_s; 1; 80)+"@"
		QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantName_s:2=$s)
		SELECTION TO ARRAY:C260([Conslt_Name:127]ConsultantNameID_l:1; $DesIDS_AL)
		QUERY WITH ARRAY:C644([PRJ_DesignContracts:123]ConsultantNameID_l:2; $DesIDS_AL)
		//RELATE ONE SELECTION([PRJ_DesignContracts];[Conslt_Name])
		
		SELECTION TO ARRAY:C260([PRJ_DesignContracts:123]DC_DesignContractID_l:1; $DesIDS_AL)
		
		QUERY WITH ARRAY:C644([PRJ_DCPFJoin:135]DC_DesignProjectID_l:2; $DesIDS_AL)
		SELECTION TO ARRAY:C260([PRJ_DCPFJoin:135]PF_FileID_l:3; $DesIDS_AL)
		
		SET QUERY DESTINATION:C396(Into set:K19:2; "PRJ_JOINSET")
		QUERY WITH ARRAY:C644([PRJ_ProjectDetails:115]PF_FileID_l:3; $DesIDS_AL)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If (PRJ_SearchAll_rb=1)
			ALL RECORDS:C47([PRJ_ProjectDetails:115])
			CREATE SET:C116([PRJ_ProjectDetails:115]; "PRJ_ALLBRGPGMSet")
			INTERSECTION:C121("PRJ_ALLBRGPGMSet"; "PRJ_JOINSET"; "PRJ_JOINSET")
			USE SET:C118("PRJ_JOINSET")
			CLEAR SET:C117("PRJ_JOINSET")
			CLEAR SET:C117("PRJ_ALLBRGPGMSet")
			
		Else 
			INTERSECTION:C121("PRJ_OriginalSet"; "PRJ_JOINSET"; "PRJ_JOINSET")
			USE SET:C118("PRJ_JOINSET")
			CLEAR SET:C117("PRJ_JOINSET")
		End if 
		
		READ WRITE:C146([Conslt_Name:127])
		READ WRITE:C146([PRJ_DesignContracts:123])
		READ WRITE:C146([PRJ_ProjectFile:117])
		ARRAY LONGINT:C221($DesIDS_AL; 0)
		
	End if 
	If (PRJ_SRCH_Contractor_s#"")
		READ ONLY:C145([PRJ_Contractor:114])
		READ ONLY:C145([PRJ_ConstructionProject:116])
		ARRAY LONGINT:C221($DesIDS_AL; 0)
		$s:=Substring:C12(PRJ_SRCH_Contractor_s; 1; 80)+"@"
		QUERY:C277([PRJ_Contractor:114]; [PRJ_Contractor:114]CTR_CompanyName_s:2=$s)
		SELECTION TO ARRAY:C260([PRJ_Contractor:114]CTR_ContractorID_l:1; $DesIDS_AL)
		QUERY WITH ARRAY:C644([PRJ_ConstructionProject:116]CTR_ContractorID_l:2; $DesIDS_AL)
		//RELATE ONE SELECTION([PRJ_DesignContracts];[Conslt_Name])
		SELECTION TO ARRAY:C260([PRJ_ConstructionProject:116]CP_ConstructionProjectID_l:1; $DesIDS_AL)
		QUERY WITH ARRAY:C644([PRJ_ProjectDetails:115]CP_ConstructionProjectID_l:2; $DesIDS_AL)
		If (PRJ_SearchAll_rb=1)
			CREATE SET:C116([PRJ_ProjectDetails:115]; "PRJ_JOINSET")
			ALL RECORDS:C47([PRJ_ProjectDetails:115])
			CREATE SET:C116([PRJ_ProjectDetails:115]; "PRJ_ALLBRGPGMSet")
			INTERSECTION:C121("PRJ_ALLBRGPGMSet"; "PRJ_JOINSET"; "PRJ_JOINSET")
			USE SET:C118("PRJ_JOINSET")
			CLEAR SET:C117("PRJ_JOINSET")
			CLEAR SET:C117("PRJ_ALLBRGPGMSet")
		Else 
			CREATE SET:C116([PRJ_ProjectDetails:115]; "PRJ_JOINSET")
			INTERSECTION:C121("PRJ_OriginalSet"; "PRJ_JOINSET"; "PRJ_JOINSET")
			USE SET:C118("PRJ_JOINSET")
			CLEAR SET:C117("PRJ_JOINSET")
		End if 
		
		READ WRITE:C146([PRJ_Contractor:114])
		READ WRITE:C146([PRJ_ConstructionProject:116])
		ARRAY LONGINT:C221($DesIDS_AL; 0)
		
	End if 
	If (PRJ_SRCH_DistrNo_s#"")
		ARRAY TEXT:C222($Brno3_as; 0)  //Command Replaced was o_ARRAY string length was 3
		READ ONLY:C145([Town Data:2])
		QUERY:C277([Town Data:2]; [Town Data:2]District:6="@"+PRJ_SRCH_DistrNo_s)
		
		SELECTION TO ARRAY:C260([Town Data:2]BDEPT Prefix:2; $Brno3_as)
		If (Size of array:C274($Brno3_as)>0)
			C_LONGINT:C283($i)
			ARRAY TEXT:C222($Brno3Wild_as; Size of array:C274($Brno3_as))  //Command Replaced was o_ARRAY string length was 5
			For ($i; 1; Size of array:C274($Brno3_as))
				$Brno3Wild_as{$i}:=$Brno3_as{$i}+"@"
			End for 
			SET QUERY DESTINATION:C396(Into set:K19:2; "PRJ_BridgeSearch")
			QUERY WITH ARRAY:C644([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; $Brno3Wild_as)
			SET QUERY DESTINATION:C396(Into set:K19:2; "PRJ_NonBridgeSearch")
			QUERY WITH ARRAY:C644([PRJ_ProjectDetails:115]PRJ_NonBridge_s:7; $Brno3Wild_as)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			UNION:C120("PRJ_BridgeSearch"; "PRJ_NonBridgeSearch"; "PRJ_BridgeSearch")
			USE SET:C118("PRJ_BridgeSearch")
			CLEAR SET:C117("PRJ_BridgeSearch")
			CLEAR SET:C117("PRJ_NonBridgeSearch")
			If (PRJ_SearchAll_rb=1)
			Else 
				CREATE SET:C116([PRJ_ProjectDetails:115]; "PRJ_JOINSET")
				INTERSECTION:C121("PRJ_OriginalSet"; "PRJ_JOINSET"; "PRJ_JOINSET")
				USE SET:C118("PRJ_JOINSET")
				CLEAR SET:C117("PRJ_JOINSET")
			End if 
		Else 
			REDUCE SELECTION:C351([PRJ_ProjectDetails:115]; 0)
		End if 
		
	End if 
	
	CLOSE WINDOW:C154
	OBJECT SET ENABLED:C1123(PRJ_FindBtn_l; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	Case of 
		: (PRJ_SRCH_Consltant_s#"")
			GOTO OBJECT:C206(PRJ_SRCH_Consltant_s)
		: (PRJ_SRCH_BDEPT_s#"")
			GOTO OBJECT:C206(PRJ_SRCH_BDEPT_s)
		: (PRJ_SRCH_TownName_s#"")
			GOTO OBJECT:C206(PRJ_SRCH_TownName_s)
		: (PRJ_SRCH_Contractor_s#"")
			GOTO OBJECT:C206(PRJ_SRCH_Contractor_s)
		: (PRJ_SRCH_Program_s#"")
			GOTO OBJECT:C206(PRJ_SRCH_Program_s)
		: (PRJ_SRCH_DistrNo_s#"")
			GOTO OBJECT:C206(PRJ_SRCH_DistrNo_s)
			
	End case 
	POST KEY:C465(Tab key:K12:28)
	POST KEY:C465(Tab key:K12:28; Shift key mask:K16:3)
	PRJ_SRCH_Consltant_s:=""
	PRJ_SRCH_BDEPT_s:=""
	PRJ_SRCH_TownName_s:=""
	PRJ_SRCH_Contractor_s:=""
	PRJ_SRCH_Program_s:=""
	PRJ_SRCH_DistrNo_s:=""
	CREATE SET:C116([PRJ_ProjectDetails:115]; "PRJ_FoundSearchSet")
	If (Records in set:C195("PRJ_SearchSet")=0)
		If (vAddTo=False:C215)
			CREATE EMPTY SET:C140([PRJ_ProjectDetails:115]; "PRJ_SearchSet")
		End if 
	End if 
	UNION:C120("PRJ_SearchSet"; "PRJ_FoundSearchSet"; "PRJ_SearchSet")
	C_TEXT:C284(PRJ_SRCH_Result_txt)
	PRJ_SRCH_Result_txt:="Last Find : "+String:C10(Records in set:C195("PRJ_FoundSearchSet"))+" Recs"
	PRJ_SRCH_Result_txt:=PRJ_SRCH_Result_txt+" - Total Recs Found : "+String:C10(Records in set:C195("PRJ_SearchSet"))
	CLEAR SET:C117("PRJ_FoundSearchSet")
	
End if 