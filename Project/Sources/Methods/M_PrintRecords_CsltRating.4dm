//%attributes = {"invisible":true}
If (False:C215)
	//GP: M_PrintRecords
	//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
	//Prints SIA's for current selection
	
	// Modified by: Costas Manousakis-(Designer)-(5/17/13 16:40:34)
	Mods_2013_05
	//  `Added redraw window
	// Modified by: Costas Manousakis-(Designer)-(10/21/13 12:35:45)
	Mods_2013_10
	//  `Added call to  G_PrintOptions
End if 
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($Recs)
C_TEXT:C284($text)

$Recs:=Records in selection:C76([Conslt Rating:63])

If ($Recs>0)
	
	If ($Recs>10)
		$text:="Do you really want to print Rating Print Form for "+String:C10($Recs; "###,##0")+"  records?"
		CONFIRM:C162($text)
	End if 
	
	If (Ok=1)
		G_PrintOptions
		If (<>ShowPrint)
			PRINT SETTINGS:C106
		End if 
		FIRST RECORD:C50([Conslt Rating:63])
		For ($i; 1; $Recs)
			Print form:C5([Conslt Rating:63]; "Rating Print Form")
			NEXT RECORD:C51([Conslt Rating:63])
		End for 
	End if 
	
Else 
	
	BEEP:C151
	ALERT:C41("No records have been selected!")
	
End if 
REDRAW WINDOW:C456