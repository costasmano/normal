//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:58:42
	// ----------------------------------------------------
	// Method: SC_WriteSingleDataCol
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
C_TEXT:C284($1; $2)
Case of 
	: (SC_SAVEASHTML_i=1)
		SEND PACKET:C103(vScourCalcDocRef; SC_DataColumnStart_txt+$1+"</FONT></td>"+<>sCR)
	: (SC_SAVEASHTML_i=2)
		C_TEXT:C284($datatype)
		If (Count parameters:C259=2)
			$datatype:=$2
		Else 
			$datatype:="Number"
		End if 
		SEND PACKET:C103(vScourCalcDocRef; SC_DataColumnStart_txt+<>sQU+$datatype+<>sQU+">"+$1+"</Data></Cell>"+<>sCR)
End case 