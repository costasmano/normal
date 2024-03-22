//%attributes = {"invisible":true}
//Method: LSS_PhotoSubForm_FM
//Description
// Method for form [LSS_Photos];"PhotoSubFormLB"
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/10/20, 17:20:01
	// ----------------------------------------------------
	//Created : 
	Mods_2020_02  //Modify the way photos are sequenced
	
	C_LONGINT:C283(LSS_PhotoSubForm_FM; $1)
	
End if 
//

C_LONGINT:C283($FormEvent_L)

If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
	
End if 

Case of 
	: ($FormEvent_L=On Load:K2:1)
		
		If (Read only state:C362(Current form table:C627->))
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)
		Else 
			OBJECT SET ENABLED:C1123(*; "DE@"; True:C214)
		End if 
		C_BOOLEAN:C305(InDoubleClick_B)  //initialize this var to trap the double-click
		InDoubleClick_B:=False:C215
		LISTBOX SELECT ROW:C912(*; "Photos_LB"; 0; lk remove from selection:K53:3)
		REDRAW:C174(PHotos_LB)
		
	: ($FormEvent_L=On Resize:K2:27)
		REDRAW:C174(PHotos_LB)
		
End case 

//End LSS_PhotSubForm_FM