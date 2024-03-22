//%attributes = {"invisible":true}
//Method: getTableByName
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/18/15, 16:22:34
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 
//
C_TEXT:C284($1)

C_POINTER:C301($0)

C_POINTER:C301(makeBielief_p; $local_ptr)
makeBielief_p:=$local_ptr
ON ERR CALL:C155("Error Handler")
EXECUTE FORMULA:C63("makeBielief_p:=->["+$1+"]")
ON ERR CALL:C155("")
$0:=makeBielief_p

//End getTableByName