//%attributes = {"invisible":true}
//Method: NTI_DisplayInspChkMsgs
//Description
// Display the messages from an inspection check
// Parameters
// $1 : $Message_Obj
// $2 : $MessageHeader_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/23/18, 16:43:01
	// ----------------------------------------------------
	//Created : 
	Mods_2018_02
	
	C_OBJECT:C1216(NTI_DisplayInspChkMsgs; $1)
	C_TEXT:C284(NTI_DisplayInspChkMsgs; $2)
	
End if 
//
C_OBJECT:C1216($1; $Message_Obj)
C_TEXT:C284($2; $MessageHeader_txt)

$Message_Obj:=$1
$MessageHeader_txt:=$2

C_TEXT:C284($message_txt; $TempMessage_txt)

$message_txt:=$MessageHeader_txt+Char:C90(Carriage return:K15:38)

ARRAY TEXT:C222($Messages_atxt; 0)
OB GET ARRAY:C1229($Message_Obj; "Error"; $Messages_atxt)
C_LONGINT:C283($loop_L; $Start_L; $End_L)

If (Size of array:C274($Messages_atxt)>0)
	$Start_L:=Length:C16($message_txt)
	$Message_txt:=$Message_txt+"LIST OF ERRORS"+Char:C90(Carriage return:K15:38)
	ST SET ATTRIBUTES:C1093($message_txt; $Start_L; $End_L; Attribute text color:K65:7; "Red")
	$End_L:=Length:C16($message_txt)
	For ($loop_L; 1; Size of array:C274($Messages_atxt))
		$Start_L:=Length:C16($message_txt)
		$TempMessage_txt:=$Messages_atxt{$loop_L}
		ST SET ATTRIBUTES:C1093($TempMessage_txt; ST Start text:K78:15; ST End text:K78:16; Attribute text color:K65:7; "Red")
		$Message_txt:=$Message_txt+$TempMessage_txt+Char:C90(Carriage return:K15:38)
		
		//$Message_txt:=$Message_txt+$Messages_atxt{$loop_L}+Char(Carriage return)
		//$End_L:=Length($message_txt)
		//ST SET ATTRIBUTES($message_txt;$Start_L;$End_L;Attribute text color;"Red")
	End for 
	$Message_txt:=$Message_txt+Char:C90(Carriage return:K15:38)
End if 
ARRAY TEXT:C222($Messages_atxt; 0)
OB GET ARRAY:C1229($Message_Obj; "Warning"; $Messages_atxt)
If (Size of array:C274($Messages_atxt)>0)
	$Message_txt:=$Message_txt+"LIST OF WARNINGS"+Char:C90(Carriage return:K15:38)
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($Messages_atxt))
		$Message_txt:=$Message_txt+$Messages_atxt{$loop_L}+Char:C90(Carriage return:K15:38)
	End for 
	$Message_txt:=$Message_txt+Char:C90(Carriage return:K15:38)
End if 
ARRAY TEXT:C222($Messages_atxt; 0)
OB GET ARRAY:C1229($Message_Obj; "Info"; $Messages_atxt)
If (Size of array:C274($Messages_atxt)>0)
	$Message_txt:=$Message_txt+"LIST OF INFORMATION MESSAGES"+Char:C90(Carriage return:K15:38)
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($Messages_atxt))
		$Message_txt:=$Message_txt+$Messages_atxt{$loop_L}+Char:C90(Carriage return:K15:38)
	End for 
End if 

ut_BigAlert($Message_txt; "Inspection Verification Report")

//End NTI_DisplayInspChkMsgs