//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/18/07, 20:08:55
	// ----------------------------------------------------
	// Method: PRJ_BPGM_CustomSearch
	// Description
	// Perform custom sorts for the Bridge Program list
	// 
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(6/18/2007 12:26:01)
	Mods_2007_CM12_5301
	Mods_2020_10  //Replace [PRJ_ProjectDetails];"BridgeProgram" with Listbox [PRJ_ProjectDetails];"BridgeProgram_LB"
	//Modified by: CJ (10/8/20 14:28:27)
End if 
PRJ_BPGM_InitSRCHVars
C_LONGINT:C283($Widt_L; $Ht_L)
COPY NAMED SELECTION:C331([PRJ_ProjectDetails:115]; "PRJ_OriginalSelection")
CREATE SET:C116([PRJ_ProjectDetails:115]; "PRJ_OriginalSet")
CREATE EMPTY SET:C140([PRJ_ProjectDetails:115]; "PRJ_SearchSet")
FORM GET PROPERTIES:C674([Dialogs:21]; "PRJ_BPGM_Search"; $Widt_L; $Ht_L)
CENTER_WINDOW($Widt_L; $Ht_L; Movable dialog box:K34:7)
DIALOG:C40([Dialogs:21]; "PRJ_BPGM_Search")
CLOSE WINDOW:C154
If (OK=1)
	PRJ_BPGM_CleanSearchVars
	If (PRJ_SRCH_TotalVars_s#"")
		PRJ_BPGM_CreateSearchSet
	End if 
	If (Records in set:C195("PRJ_SearchSet")>0)
		USE SET:C118("PRJ_SearchSet")
		If (Size of array:C274(v_115_002_aL)>0)
			PRJ_SetupListBoxDisplayEvent
		Else 
			PRJ_BPGM_LoadArrays
			PRJ_BPGM_DoSort
		End if 
		PRJ_BPGM_WinTitle
	Else 
		ALERT:C41("No Bridge Program Records Found!!")
		USE NAMED SELECTION:C332("PRJ_OriginalSelection")
	End if 
Else 
	USE NAMED SELECTION:C332("PRJ_OriginalSelection")
	
End if 
CLEAR NAMED SELECTION:C333("PRJ_OriginalSelection")
CLEAR SET:C117("PRJ_OriginalSet")
CLEAR SET:C117("PRJ_SearchSet")