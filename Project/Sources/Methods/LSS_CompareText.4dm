//%attributes = {"invisible":true}
//Method: LSS_CompareText
//Description
// Compares two text passed by pointers; returns true if they are NOT equal considering Case
// Parameters
// $0 : $NotEqual_b
// $1 : $Text1_ptr
// $2 : $Text2_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/19/15, 17:13:08
	// ----------------------------------------------------
	//Created : 
	Mods_2015_06
	C_BOOLEAN:C305(LSS_CompareText; $0)
	C_POINTER:C301(LSS_CompareText; $1)
	C_POINTER:C301(LSS_CompareText; $2)
	
End if 
//
C_BOOLEAN:C305($0)
C_POINTER:C301($1)
C_POINTER:C301($2)

$0:=False:C215
If (Length:C16($1->)#Length:C16($2->))
	$0:=True:C214
Else 
	If (Length:C16($1->)>0)
		If (Position:C15($1->; $2->; *)=0)
			$0:=True:C214
		End if 
		
	End if 
End if 

//End LSS_CompareText