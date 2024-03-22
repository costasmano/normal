//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/07/14, 11:25:38
//----------------------------------------------------
//Method: cjm_TestMonthly
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
DELAY PROCESS:C323(Current process:C322; 10)
If (Application type:C494=4D Server:K5:6)
	C_TIME:C306($Doc_tm)
	If (Test path name:C476(Current method name:C684+".txt")=Is a document:K24:1)
		$Doc_tm:=Append document:C265(Current method name:C684+".txt")
	Else 
		$Doc_tm:=Create document:C266(Current method name:C684+".txt")
	End if 
	SEND PACKET:C103($Doc_tm; Current system user:C484+" run on "+String:C10(Current date:C33; 7)+" at "+String:C10(Current time:C178)+Char:C90(Carriage return:K15:38))
	CLOSE DOCUMENT:C267($Doc_tm)
Else 
	ALERT:C41("We are running this weekly on client. The current time is "+String:C10(Current time:C178))
End if 
//End cjm_TestMonthly

