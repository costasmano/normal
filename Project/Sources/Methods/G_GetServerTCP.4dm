//%attributes = {"invisible":true}
//Method to retrieve the Server's TCP address.
//Uses G_SetServerTCP method

If (False:C215)  //for reference
	G_SetServerTCP
	// Modified by: Costas Manousakis-(Designer)-(2021-12-01T00:00:00 17:38:14)
	Mods_2021_12_bug
	//  `changed stack size to 0 - method was crashing on server.
End if 

C_TEXT:C284(<>ServerTCPAddr; $ServerTCP; $0)  // Command Replaced was o_C_STRING length was 32
$0:=""
C_LONGINT:C283($RetCode)  //Command Replaced was o_C_INTEGER
$RetCode:=Execute on server:C373("G_SetServerTCP"; 0)
GET PROCESS VARIABLE:C371(-1; <>ServerTCPAddr; $ServerTCP)
$0:=$ServerTCP