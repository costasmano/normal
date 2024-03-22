//Method: [Bridge MHD NBIS].NewNBIS_StackInfo.NBISStack_LB
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 09/19/19, 13:38:12
	// ----------------------------------------------------
	//Created : 
	Mods_2019_09  //Create method to handle resize of windows between out and input forms
	//Modified by: Chuck Miller (9/26/19 14:51:05)
	// Modified by: Costas Manousakis-(Designer)-(4/17/20 12:23:15)
	Mods_2020_04
	//  `use on header click to capture the sort for use in the search, select button methods
End if 
//
C_TEXT:C284(GEN_SORTLISTCMD_txt)

Case of 
	: (Form event code:C388=On Load:K2:1)
		LISTBOX SORT COLUMNS:C916(*; "NBISStack_LB"; 1; >)
		GEN_SORTLISTCMD_txt:="ORDER BY([Bridge MHD NBIS];[Bridge MHD NBIS]BDEPT;>)"
		
	: (Form event code:C388=On Open Detail:K2:23)
		vNBIOPENDETAIL_L:=1
		ut_SetWindowSize("Create"; Current method name:C684)
		
	: (Form event code:C388=On Close Detail:K2:24)
		vNBIOPENDETAIL_L:=0
		ut_SetWindowSize("Reset"; Current method name:C684)
	: (Form event code:C388=On Selection Change:K2:29)
		
		ARRAY TEXT:C222($BridgeSearchArray_atxt; 0)
		GET PROCESS VARIABLE:C371(-1; <>BridgeSearchArray_atxt; $BridgeSearchArray_atxt)
		If (Size of array:C274($BridgeSearchArray_atxt)=0)
			Bridge_FileBridgeSearchArray
		End if 
		
	: (Form event code:C388=On Header Click:K2:40)
		
		C_TEXT:C284($nameofLB_txt)
		$nameofLB_txt:=OBJECT Get name:C1087(Object current:K67:2)  //this is the lb name
		ARRAY TEXT:C222($ColNames_atxt; 0)
		ARRAY TEXT:C222($hdrNames_atxt; 0)
		ARRAY POINTER:C280($colVars_aptr; 0)
		ARRAY POINTER:C280($hdrVars_aptr; 0)
		ARRAY BOOLEAN:C223($colVis_ab; 0)
		ARRAY POINTER:C280($Styles_aptr; 0)
		LISTBOX GET ARRAYS:C832(*; $nameofLB_txt; $ColNames_atxt; $hdrNames_atxt; $colVars_aptr; $hdrVars_aptr; $colVis_ab; $Styles_aptr)
		C_LONGINT:C283($hdrindx_L)
		$hdrindx_L:=Find in array:C230($hdrVars_aptr; Self:C308)
		If ($hdrindx_L>0)
			If ((Self:C308->=0) | (Self:C308->=2))
				GEN_SORTLISTCMD_txt:="ORDER BY([Bridge MHD NBIS];[Bridge MHD NBIS]"+Field name:C257($colVars_aptr{$hdrindx_L})+";>)"
				
			Else 
				GEN_SORTLISTCMD_txt:="ORDER BY([Bridge MHD NBIS];[Bridge MHD NBIS]"+Field name:C257($colVars_aptr{$hdrindx_L})+";<)"
				
			End if 
			
		End if 
		
End case 

//End [Bridge MHD NBIS].NewNBIS_StackInfo.NBISStack_LB