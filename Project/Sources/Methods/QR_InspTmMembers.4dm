//%attributes = {"shared":true}
//Method: QR_InspTmMembers
//Description
//Return the names of the inspection team members 
// Parameters
// $0 : $TmMembers_txt
// $1 : $InspID_L (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/15/16, 15:25:37
	// ----------------------------------------------------
	//Created : 
	Mods_2016_08
	
	C_TEXT:C284(QR_InspTmMembers; $0)
	C_LONGINT:C283(QR_InspTmMembers; $1)  //optional
	
End if 
//
C_TEXT:C284($TmMembers_txt; $s)
C_LONGINT:C283($InspID_L)
C_TEXT:C284($0)

If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$InspID_L:=$1
Else 
	$InspID_L:=[Inspections:27]InspID:2
End if 
$TmMembers_txt:=""
QUERY:C277([Field Trip:43]; [Field Trip:43]InspID:1=$InspID_L)
If (Records in selection:C76([Field Trip:43])>0)
	ARRAY INTEGER:C220($TmMembers_ai; 0)
	SELECTION TO ARRAY:C260([Field Trip:43]Person ID:2; $TmMembers_ai)
	
	$TmMembers_txt:=Pers_GetNames(->$TmMembers_ai)
	
End if 

$0:=$TmMembers_txt

//End QR_InspTmMembers