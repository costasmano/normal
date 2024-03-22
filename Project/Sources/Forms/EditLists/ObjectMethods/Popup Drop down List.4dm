// Method: Object Method: EditLists.LISTEDIT_Lists_atxt
// Description
// 
//   ` ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 02/26/13, 12:09:49
	// ----------------------------------------------------
	// First Release
	Mods_2013_02
End if 
C_LONGINT:C283($FormEvent_L)

$FormEvent_L:=Form event code:C388

Case of 
	: ($FormEvent_L=On Load:K2:1)
		ARRAY LONGINT:C221($LISTEDIT_Lists_aL; 0)
		ARRAY TEXT:C222(LISTEDIT_Lists_atxt; 0)
		LIST OF CHOICE LISTS:C957($LISTEDIT_Lists_aL; LISTEDIT_Lists_atxt)
		SORT ARRAY:C229(LISTEDIT_Lists_atxt; $LISTEDIT_Lists_aL)
		
	: ($FormEvent_L=On Data Change:K2:15)
		
	: ($FormEvent_L=On Clicked:K2:4)
		C_LONGINT:C283($ListPick_L)
		$ListPick_L:=LISTEDIT_Lists_atxt
		
		If ($ListPick_L>0)
			OBJECT SET LIST BY NAME:C237(LISTMODIFIER_txt; LISTEDIT_Lists_atxt{$ListPick_L})
		End if 
		
	: ($FormEvent_L=On Double Clicked:K2:5)
		
End case 