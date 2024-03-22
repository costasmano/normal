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

$Recs:=Records in selection:C76([Out of Freq:70])

If ($Recs>0)
	SET PRINT OPTION:C733(Orientation option:K47:2; 1)
	PRINT SETTINGS:C106
	If (OK=1)
		If ($Recs>10)
			$text:="Do you really want to print "+String:C10($Recs)+" Out of frequency Reports?"
			CONFIRM:C162($text)
		End if 
		If (Ok=1)
			FIRST RECORD:C50([Out of Freq:70])
			For ($i; 1; $Recs)
				Print form:C5([Out of Freq:70]; "P_OutofFreq")
				PAGE BREAK:C6
				NEXT RECORD:C51([Out of Freq:70])
			End for 
		End if 
		
	End if 
Else 
	BEEP:C151
	ALERT:C41("No records have been selected!")
End if 


//End of script