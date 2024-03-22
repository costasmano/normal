//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 10/29/15, 16:27:24
//----------------------------------------------------
//Method: NTI_ControlModification
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (10/29/15 16:27:26)
	// Modified by: Costas Manousakis-(Designer)-(6/15/18 13:52:48)
	Mods_2018_06
	//  `get the table name from the table ptr
End if 
C_POINTER:C301($1; $Table_ptr)
$Table_ptr:=$1
C_TEXT:C284($2; $FormName_txt)
$FormName_txt:=$2

C_LONGINT:C283($Width_L; $Height_L; $Choice_L)
FORM GET PROPERTIES:C674($Table_ptr->; $FormName_txt; $Width_L; $Height_L)
//ut_OpenNewWindow ($Width_L;$Height_l;0;Plain window )

Repeat 
	NTI_SetModDeleteAccess(->NTI_Modify_B; ->NTI_CanDelete_B)
	If (User in group:C338(Current user:C182; "Design Access Group"))
		CONFIRM:C162("Do You "+Current user:C182+" want to edit this "+Table name:C256($Table_ptr)+" item"; "Edit"; "Read Only")
		If (OK=1)
			NTI_Modify_B:=True:C214
		Else 
			NTI_Modify_B:=False:C215
		End if 
	End if 
	//ut_LSSSetInventoryEntry
	If (NTI_Modify_B)
		$Choice_L:=ut_LoadRecordInteractiveV2($Table_ptr)
	Else 
		$Choice_L:=2
	End if 
	
	Case of 
		: ($Choice_L=1)
			ut_SetReadWrite("write"; ->[NTI_TunnelRatings:189])
			FORM SET INPUT:C55($Table_ptr->; $FormName_txt)
			MODIFY RECORD:C57($Table_ptr->)
			UNLOAD RECORD:C212($Table_ptr->)
			ut_SetReadWrite("read"; $Table_ptr)
			
		: ($Choice_L=2)
			UNLOAD RECORD:C212($Table_ptr->)
			ut_SetReadWrite("read"; $Table_ptr)
			LOAD RECORD:C52($Table_ptr->)
			DIALOG:C40($Table_ptr->; $FormName_txt)
			
	End case 
	
Until (Not:C34(NTI_MovingRecords_B))

//End NTI_ControlModification