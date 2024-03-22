//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 08/07/13, 15:35:02
//----------------------------------------------------
//Method: GetServerSerial
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_07  //r001 ` 
	//Modified by: Charles Miller (8/7/13 15:35:05)
	
End if 
C_BLOB:C604($Return_blb)
SET BLOB SIZE:C606($Return_blb; 0)

$Return_blb:=ut_ReturnSerialData

C_LONGINT:C283($Offset_L)
C_LONGINT:C283($Key; $Connected; $MaxUsers)
C_TEXT:C284($User)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($Company)  // Command Replaced was o_C_STRING length was 80

$Offset_L:=0
BLOB TO VARIABLE:C533($Return_blb; $Key; $Offset_L)
BLOB TO VARIABLE:C533($Return_blb; $User; $Offset_L)
BLOB TO VARIABLE:C533($Return_blb; $Company; $Offset_L)
BLOB TO VARIABLE:C533($Return_blb; $Connected; $Offset_L)
BLOB TO VARIABLE:C533($Return_blb; $MaxUsers; $Offset_L)
C_TEXT:C284($Text_txt)
$Text_txt:="Key is "+String:C10($Key)+Char:C90(Carriage return:K15:38)
$Text_txt:=$Text_txt+"$User is "+$User+Char:C90(Carriage return:K15:38)
$Text_txt:=$Text_txt+"$Company is "+$Company+Char:C90(Carriage return:K15:38)
$Text_txt:=$Text_txt+"$Connected is "+String:C10($Connected)+Char:C90(Carriage return:K15:38)
$Text_txt:=$Text_txt+"$MaxUsers is "+String:C10($MaxUsers)+Char:C90(Carriage return:K15:38)


SET TEXT TO PASTEBOARD:C523($Text_txt)
ALERT:C41("Send me an email by pasting results form clipboard")


//End Get_ServererSerial
