//%attributes = {"invisible":true}
//Method: Test_Client_Process
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 08/14/20, 11:50:14
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08
End if 
//
C_TEXT:C284($Path_txt)
$Path_txt:=System folder:C487(Documents folder:K41:18)

$Path_txt:=$Path_txt+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)+".txt"

C_TEXT:C284($report_txt)
$report_txt:="Running "+Current method name:C684+" at "+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)+Char:C90(Carriage return:K15:38)
DELAY PROCESS:C323(Current process:C322; 20)
$report_txt:=$report_txt+" at "+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)+Char:C90(Carriage return:K15:38)
DELAY PROCESS:C323(Current process:C322; 20)
$report_txt:=$report_txt+" at "+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)+Char:C90(Carriage return:K15:38)

TEXT TO DOCUMENT:C1237($Path_txt; $report_txt; UTF8 text without length:K22:17)

//End Test_Client_Process