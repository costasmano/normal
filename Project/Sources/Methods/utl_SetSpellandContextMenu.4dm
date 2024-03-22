//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 08/26/16, 11:08:05
//----------------------------------------------------
//Method: utl_SetSpellandContextMenu
//Description
//This method will set spell check and contextual menu for all objects on form that are object type text
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_08  // 
	//Modified by: Chuck Miller (8/26/16 11:08:07)
	
End if 

ARRAY POINTER:C280($Variables_aptr; 0)
ARRAY TEXT:C222($Objects_atxt; 0)
C_LONGINT:C283($Loop_l; $Type_L)

FORM GET OBJECTS:C898($Objects_atxt; $Variables_aptr; $Pages_al)
For ($loop_l; 1; Size of array:C274($Objects_atxt))
	If (OBJECT Get type:C1300(*; $Objects_atxt{$loop_l})=Object type text input:K79:4)
		OBJECT SET AUTO SPELLCHECK:C1173(*; $Objects_atxt{$Loop_l}; True:C214)
		OBJECT SET CONTEXT MENU:C1251(*; $Objects_atxt{$Loop_l}; True:C214)
	End if 
End for 
//End utl_SetSpellandContextMenu

