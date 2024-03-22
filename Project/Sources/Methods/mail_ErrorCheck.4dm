//%attributes = {"invisible":true}
If (False:C215)  //•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
	//©1993-1995, PACIFIC DATA MANAGEMENT, INC.
	//-----------------------------------------------
	//Procedure: Mail_ErrorCheck ("Command Name"; Error# ) : True = Everything was OK
	//-----------------------------------------------
	//DESCRIPTION:  
	//
	//-----------------------------------------------
	
	Mods_2006_CMy4
End if   //••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••• 
C_BOOLEAN:C305($0; $Result)
C_LONGINT:C283($Error)
C_TEXT:C284($Command)
C_TEXT:C284(vErrorMsg)
$Command:=$1
$Error:=$2
$Result:=True:C214
If ($Error#0)
	$Result:=False:C215
	Case of 
		: ($Error=10000)  //always supress messages on user cancel of dialogs
		: (<>SHOWERRORS)  //if the database is configured to display error messages
			vErrorMsg:=IT_ErrorText($Error)
			ALERT:C41("ERROR ---"+Char:C90(13)+"Command: "+$Command+Char:C90(13)+"Error Code: "+String:C10($Error)+Char:C90(13)+"Description: "+vErrorMsg)
			
	End case 
End if 
$0:=$Result