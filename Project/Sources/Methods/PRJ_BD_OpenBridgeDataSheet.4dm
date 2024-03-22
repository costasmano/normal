//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/22/07, 20:53:51
	// ----------------------------------------------------
	// Method: PRJ_BD_OpenBridgeDataSheet
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_DataSheet
	Mods_2007_CJMv2  //04/30/07, 11:50:58`Fix compiler errors
	Mods_2009_03  //CJM  r001   `03/06/09, 14:42:54`Upgrade from open form window to open window
End if 
C_TEXT:C284($1; $DesBIN)  // Command Replaced was o_C_STRING length was 3
$DesBIN:=$1
QUERY:C277([Bridge Design:75]; [Bridge Design:75]BIN:1=$DesBIN; *)
QUERY:C277([Bridge Design:75];  & ; [Bridge Design:75]PROJIS:2=String:C10([PRJ_ProjectFile:117]PF_FileNumber_l:3))
If (Records in selection:C76([Bridge Design:75])=1)
	
	C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
	C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
	C_TEXT:C284($Title_txt)
	FORM GET PROPERTIES:C674([Bridge Design:75]; "Bridge Design In"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
	$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
	//$newWin:=Open form window([Bridge Design];"Bridge Design In")
	FORM SET INPUT:C55([Bridge Design:75]; "Bridge Design In")
	READ ONLY:C145([Bridge MHD NBIS:1])
	READ WRITE:C146([Bridge Design:75])
	UNLOAD RECORD:C212([Bridge Design:75])
	GOTO SELECTED RECORD:C245([Bridge Design:75]; 1)
	LOAD RECORD:C52([Bridge Design:75])
	MODIFY RECORD:C57([Bridge Design:75])
	
Else 
	If (User in group:C338(Current user:C182; "BridgeDataSheet"))
		
		CONFIRM:C162("Add Data sheet for BIN "+$DesBIN+" ?")
		If (OK=1)
			FORM SET INPUT:C55([Bridge Design:75]; "Bridge Design In")
			CREATE RECORD:C68([Bridge Design:75])
			[Bridge Design:75]BIN:1:=$DesBIN
			[Bridge Design:75]PROJIS:2:=String:C10([PRJ_ProjectFile:117]PF_FileNumber_l:3)
			[Bridge Design:75]Designer:5:=PRJ_ConsultantName_txt
			[Bridge Design:75]ContractNumber:33:=String:C10([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)
			MODIFY RECORD:C57([Bridge Design:75])
		End if 
		
	Else 
		
	End if 
	
End if 

