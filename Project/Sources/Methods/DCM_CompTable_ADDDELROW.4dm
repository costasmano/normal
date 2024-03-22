//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/13/10, 08:39:29
	// ----------------------------------------------------
	// Method: DCM_CompTable_ADDDELROW
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_12
End if 

C_TEXT:C284($1)
C_LONGINT:C283($Row_L)
$Row_L:=DCM_CompTable_LB
Case of 
	: ($1="ADD")
		
		If ($Row_L>0)
		Else 
			$Row_L:=Size of array:C274(DCM_CompTable_LB)
		End if 
		C_LONGINT:C283($loop_L)
		C_LONGINT:C283($MaxIndx_L)
		$MaxIndx_L:=fn_MaxElement_L(->DCM_CompTblArtisanNo_aL)
		
		LISTBOX INSERT ROWS:C913(DCM_CompTable_LB; ($Row_L+1))
		REDRAW:C174(DCM_CompTable_LB)
		
		DCM_CompTblArtisanNo_aL{$Row_L}:=DCM_CompTblArtisanNo_aL{$MaxIndx_L}+1
		EDIT ITEM:C870(DCM_CompTblArtisan_atxt; $Row_L+1)
		DCM_COMPTBLCHANGES_b:=True:C214
		
	: ($1="DEL@")
		If ($Row_L>0)
			CONFIRM:C162("DELETE RATES FOR "+<>sQU+DCM_CompTblArtisan_atxt{$Row_L}+<>sQU+"? There is no UNDO for this action"; "Delete"; "Cancel")
			If (OK=1)
				LISTBOX DELETE ROWS:C914(DCM_CompTable_LB; $Row_L)
				DCM_COMPTBLCHANGES_b:=True:C214
			End if 
			REDRAW:C174(DCM_CompTable_LB)
		Else 
			ALERT:C41("Must Select an Artisan to Remove from the list")
		End if 
		
End case 