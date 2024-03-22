//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/04/07, 16:26:16
	// ----------------------------------------------------
	// Method: PRJ_BPGM_RelateToBINs
	// Description
	// From the current selection of BINs get the list of projects related to them
	// 
	// Parameters
	// ----------------------------------------------------
	
	//Spawns
	PRJ_BPGM_ListFromBINs
	
	// Modified by: costasmanousakis-(Designer)-(8/16/2007 16:56:59)
	Mods_2007_CM12_5301
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
If (Records in selection:C76([Bridge MHD NBIS:1])>0)
	C_LONGINT:C283($i; $ProcessID_l)
	READ ONLY:C145([PRJ_ProjectDetails:115])
	READ ONLY:C145([PRJ_ProjectDetailsIncludedBINS:122])
	ARRAY TEXT:C222($PRJ_BINs_as; 0)  //Command Replaced was o_ARRAY string length was 3
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $PRJ_BINs_as)
	QUERY WITH ARRAY:C644([PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; $PRJ_BINs_as)
	ARRAY LONGINT:C221($PRJ_PrjDetIDs_aL; 0)
	SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1; $PRJ_PrjDetIDs_aL)
	QUERY WITH ARRAY:C644([PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; $PRJ_PrjDetIDs_aL)
	CREATE SET:C116([PRJ_ProjectDetails:115]; "PROJECTSPART1")
	ARRAY TEXT:C222($PRJ_BDEPTs_as; 0)  //Command Replaced was o_ARRAY string length was 6
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BDEPT:1; $PRJ_BDEPTs_as)
	ARRAY TEXT:C222($PRJ_BDEPTsw_as; Size of array:C274($PRJ_BDEPTs_as))  //Command Replaced was o_ARRAY string length was 8
	For ($i; 1; Size of array:C274($PRJ_BDEPTs_as))
		$PRJ_BDEPTsw_as{$i}:=$PRJ_BDEPTs_as{$i}+"@"
	End for 
	QUERY WITH ARRAY:C644([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; $PRJ_BDEPTsw_as)
	CREATE SET:C116([PRJ_ProjectDetails:115]; "PROJECTSPART2")
	UNION:C120("PROJECTSPART1"; "PROJECTSPART2"; "PROJECTSPART1")
	USE SET:C118("PROJECTSPART1")
	CLEAR SET:C117("PROJECTSPART1")
	CLEAR SET:C117("PROJECTSPART2")
	If (Records in selection:C76([PRJ_ProjectDetails:115])>0)
		C_TEXT:C284($MyprocName_txt)
		C_LONGINT:C283($MyProcState_L; $MyProcTime_L)
		C_TEXT:C284($MyprocName_txt; $ProcName)
		PROCESS PROPERTIES:C336(Current process:C322; $MyprocName_txt; $MyProcState_L; $MyProcTime_L)
		$ProcName:=$MyprocName_txt+"-Projects-"+String:C10(LNextView($MyprocName_txt+"-PRJ-")+1)
		CREATE SET:C116([PRJ_ProjectDetails:115]; "◊"+$ProcName)
		$ProcessID_l:=LSpawnProcess("PRJ_BPGM_ListFromBINs"; <>LStackSize; $ProcName; True:C214; False:C215)
		
	Else 
		ALERT:C41("No Projects found for this List of bridges!")
	End if 
	
Else 
	ALERT:C41("No Bridges listed!!")
End if 