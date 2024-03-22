//%attributes = {}
//Method: QR_GetBridgeStairsInfo
//Description
// Return object with info about the stairs on/adjacent to a BIN
// Parameters
// $0 : $Info_o
// "count" : $numberofstairs_L
// "owners" : $owners_txt : list of owners comma separated
// $1 : $BIN (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-10-21T00:00:00, 12:15:49
	// ----------------------------------------------------
	//Created : 
	Mods_2021_10
	
	C_OBJECT:C1216(QR_GetBridgeStairsInfo; $0)
	C_TEXT:C284(QR_GetBridgeStairsInfo; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(2023-04-10 14:05:53)
	Mods_2023_04
	//  `Replace SQL with ds query
End if 
//

C_OBJECT:C1216($0)
C_TEXT:C284($BIN_txt; $owners_txt)
C_LONGINT:C283($numberofstairs_L)
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$BIN_txt:=$1
Else 
	$BIN_txt:=[Bridge MHD NBIS:1]BIN:3
End if 

$owners_txt:=""

C_OBJECT:C1216($stairs_o)
C_COLLECTION:C1488($owners_c)
C_TEXT:C284($owners_txt)
$stairs_o:=ds:C1482["BridgeStairs"].query("BIN = :1"; $BIN_txt)

If ($stairs_o.length>0)
	$owners_c:=$stairs_o.toCollection("OwnerCode_s")
	C_OBJECT:C1216($stair_o)
	$owners_txt:=$stairs_o[0].OwnerCode_s
	C_LONGINT:C283($i)
	For ($i; 1; ($stairs_o.length-1))
		$owners_txt:=$owners_txt+", "+$stairs_o[$i].OwnerCode_s
	End for 
	
End if 
$numberofstairs_L:=$stairs_o.length

OB SET:C1220($0; "count"; $numberofstairs_L; "owners"; $owners_txt)

//End QR_GetBridgeStairsInfo