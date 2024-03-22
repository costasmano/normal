If (False:C215)
	//Script: bzPrint
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	
End if 

C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($Recs)
C_TEXT:C284($text)

$Recs:=Records in selection:C76([Scour Report:129])

If ($Recs>0)
	//_O_PAGE SETUP([Scour Report]; "Scour Report - State")
	//_O_PAGE SETUP([Scour Report]; "Scour Report - Agencies")
	//_O_PAGE SETUP([Scour Report]; "Scour Report - Mass")
	//_O_PAGE SETUP([Scour Report]; "Scour Report - Summary")
	
	FORM SET OUTPUT:C54([Scour Report:129]; "Scour Report - State")
	FORM SET OUTPUT:C54([Scour Report:129]; "Scour Report - Agencies")
	FORM SET OUTPUT:C54([Scour Report:129]; "Scour Report - Mass")
	FORM SET OUTPUT:C54([Scour Report:129]; "Scour Report - Summary")
	
	PRINT SETTINGS:C106
	If ($Recs>10)
		$text:="Do you really want to print "+String:C10($Recs)+" Bridge Scour Reports?"
		CONFIRM:C162($text)
	End if 
	If (Ok=1)
		FIRST RECORD:C50([Scour Report:129])
		For ($i; 1; $Recs)
			Print form:C5([Scour Report:129]; "Scour Report - State")
			Print form:C5([Scour Report:129]; "Scour Report - Agencies")
			Print form:C5([Scour Report:129]; "Scour Report - Mass")
			Print form:C5([Scour Report:129]; "Scour Report - Summary")
			PAGE BREAK:C6
			NEXT RECORD:C51([Scour Report:129])
		End for 
	End if 
Else 
	BEEP:C151
	ALERT:C41("No records have been selected!")
End if 


//End of script