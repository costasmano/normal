//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_BridgesEntry
// User name (OS): cjmiller
// Date and time: 04/07/06, 13:15:25
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJMv2  //r060   `05/16/07, 16:38:26`Make sure that call to select passes in correct bdept
	Mods_PRJSELECTION
	// Modified by: costasmanousakis-(Designer)-(8/28/2007 15:51:31)
	Mods_2007_CM12_5301
	// Modified by: Costas Manousakis-(Designer)-(2023-04-07 16:13:08)
	Mods_2023_04
	//  `removed IDLE after delay process
End if 
C_TEXT:C284($search_txt)
$search_txt:=Substring:C12(PRJ_DEBridgeNo_s; 1; 6)+"@"
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=$search_txt)


If (PRJ_DEBridgeNo_s#[PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5)
	READ WRITE:C146([PRJ_ProjectDetailsIncludedBINS:122])
	UNLOAD RECORD:C212([PRJ_ProjectDetailsIncludedBINS:122])
	QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
	Repeat 
		DELETE SELECTION:C66([PRJ_ProjectDetailsIncludedBINS:122])
		If (Records in set:C195("LockedSet")>0)
			USE SET:C118("LockedSet")
			DELAY PROCESS:C323(Current process:C322; 10)
			//IDLE
		End if 
		
		
		
	Until (Records in set:C195("LockedSet")=0)
	
	ARRAY TEXT:C222(BinDescP2_atxt; 0)
End if 

Case of 
	: (Records in selection:C76([Bridge MHD NBIS:1])=0)
		PRJ_NoBridgeFound
		
	: (Records in selection:C76([Bridge MHD NBIS:1])=1)
		PRJ_OneBridgeFound
		PRJ_SetEntryCheckBoxes
		PRJ_LoadPage2Bins
	Else 
		C_LONGINT:C283(<>ProjectSelectionProcess_l)
		<>SelectionOption_txt:="Bridge"
		<>ProjectProcess_l:=Current process:C322
		<>PRJ_SelectedData_txt:=Substring:C12(PRJ_DEBridgeNo_s; 1; 6)
		PRJ_StartOrResumeProjSelection
		
End case 

//End PRJ_BridgesEntry