//%attributes = {"invisible":true}
//Method: INSP_ImageSubForm_FM
//Description
// Method for the image subform
// Parameters
// $1 : $FormEvent (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/10/20, 10:45:49
	// ----------------------------------------------------
	//Created : 
	Mods_2020_02
	
	C_LONGINT:C283(INSP_ImageSubForm_FM; $1)
End if 
//

C_LONGINT:C283($FormEvent_L)


If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

C_TEXT:C284($LB_Name)
$LB_Name:="Photos_LB"
C_POINTER:C301($LB_ptr)
$LB_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $LB_Name)

Case of 
	: ($FormEvent_L=On Load:K2:1)
		G_Insp_RelateInsp(->[Standard Photos:36]InspID:1)
		QUERY SELECTION WITH ARRAY:C1050([Standard Photos:36]PictType:5; aPictCode)
		G_SortInspImages
		
		If (Read only state:C362(Current form table:C627->))
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)
		Else 
			OBJECT SET ENABLED:C1123(*; "DE@"; True:C214)
		End if 
		
		LISTBOX SELECT ROW:C912(*; $LB_Name; 0; lk remove from selection:K53:3)
		REDRAW:C174($LB_ptr->)
		
		C_BOOLEAN:C305(InDoubleClick_B)  //initialize this var to trap the double-click
		InDoubleClick_B:=False:C215
		
	: ($FormEvent_L=On Resize:K2:27)
		REDRAW:C174($LB_ptr->)
		
End case 


//End INSP_ImageSubForm_FM