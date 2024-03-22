//%attributes = {"invisible":true}
//Method: CTRL_SubFormDoubleClick
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 04/06/21, 13:01:31
	// ----------------------------------------------------
	//Created : 
	Mods_2021_04  //Change from auto to selecting input on sub forms by double clicking 
	//Modified by: CJ (4/8/21 15:51:14)
	
End if 
//

If (Not:C34(InDoubleClick_B))
	InDoubleClick_B:=True:C214
	C_POINTER:C301($1; $Table_ptr)
	$Table_ptr:=$1
	C_TEXT:C284($2; $3; $InputFormName_txt; $LisboxObjectName_txt)
	$InputFormName_txt:=$2
	$LisboxObjectName_txt:=$3
	C_LONGINT:C283($LBCol_L; $LBRow_L)
	LISTBOX GET CELL POSITION:C971(*; $LisboxObjectName_txt; $LBCol_L; $LBRow_L)
	If ($LBRow_L>0)
		GOTO SELECTED RECORD:C245($Table_ptr->; $LBRow_L)
		If (Read only state:C362($Table_ptr->))
			READ ONLY:C145($Table_ptr->)
			LOAD RECORD:C52($Table_ptr->)
			DIALOG:C40($Table_ptr->; $InputFormName_txt)
		Else 
			C_LONGINT:C283($LoadRecResult_L)
			$LoadRecResult_L:=ut_LoadRecordInteractiveV2($Table_ptr)
			Case of 
				: ($LoadRecResult_L=1)
					FORM SET INPUT:C55($Table_ptr->; $InputFormName_txt)
					MODIFY RECORD:C57($Table_ptr->)
				: ($LoadRecResult_L=2)
					LOAD RECORD:C52($Table_ptr->)
					DIALOG:C40($Table_ptr->; $InputFormName_txt)
			End case 
		End if 
		
		
	End if 
	InDoubleClick_B:=False:C215
End if 
//End CTRL_SubFormDoubleClick