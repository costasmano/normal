//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/09/06, 22:56:11
	// ----------------------------------------------------
	// Method: SC_WriteRowEnd
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
End if 
Case of 
	: (SC_SAVEASHTML_i=1)
		SEND PACKET:C103(vScourCalcDocRef; "</tr>"+<>sCR)
	: (SC_SAVEASHTML_i=2)
		SEND PACKET:C103(vScourCalcDocRef; "</Row>"+<>sCR)
End case 