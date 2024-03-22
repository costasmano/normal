//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/24/06, 16:38:45
	// ----------------------------------------------------
	// Method: POPUP_HL_MENUC
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
C_LONGINT:C283($1; $HLIST_ID)
C_POINTER:C301($2; $Field_ptr)
C_LONGINT:C283($ItemRef)
C_TEXT:C284($ItemText)

$HLIST_ID:=$1
$Field_ptr:=$2
Case of 
	: (Form event code:C388=On Load:K2:1)
		SELECT LIST ITEMS BY REFERENCE:C630($HLIST_ID; $Field_ptr->)
		GET LIST ITEM:C378($HLIST_ID; Selected list items:C379($HLIST_ID); $ItemRef; $ItemText)
		If ($ItemRef#$Field_ptr->)
			SELECT LIST ITEMS BY POSITION:C381($HLIST_ID; 0)  //0 shows a blank list
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		If (Selected list items:C379($HLIST_ID)>0)
			GET LIST ITEM:C378($HLIST_ID; Selected list items:C379($HLIST_ID); $ItemRef; $ItemText)
			$Field_ptr->:=$ItemRef
		End if 
End case 