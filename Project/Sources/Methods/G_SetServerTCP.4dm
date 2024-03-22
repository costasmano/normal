//%attributes = {"invisible":true}
//
//Set the global var ServerTCPAddr.
//Used by 
If (False:C215)
	Mods_2011_06  // CJ Miller`06/13/11, 17:06:58      ` Type all local variables for v11
End if 
C_LONGINT:C283($errCode)
C_TEXT:C284(<>ServerTCPAddr; $Mask)  // Command Replaced was o_C_STRING length was 32
$errCode:=IT_MyTCPAddr(<>ServerTCPAddr; $Mask)