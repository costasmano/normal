//%attributes = {"invisible":true}
//Method: INSP_GetDefaultUOE
//Description
// Get the default UOE ID for a bridge inspection based on Insp resp 
// Parameters
// $0 : $DBIE_L
// $1 : $InspResp_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/25/19, 17:26:47
	// ----------------------------------------------------
	//Created : 
	Mods_2019_10_bug
	C_LONGINT:C283(INSP_GetDefaultUOE; $0)
	C_TEXT:C284(INSP_GetDefaultUOE; $1)
End if 
//

C_LONGINT:C283($0)
C_TEXT:C284($1)

C_LONGINT:C283($DBIE_L)
C_TEXT:C284($InspResp_txt; $Grpsuffix_txt; $vsDivNo)
$DBIE_L:=0
$InspResp_txt:=$1


Case of 
	: ($InspResp_txt="DIST@")
		$Grpsuffix_txt:=""
		$vsDivNo:="0449"
		
	: ($InspResp_txt="MDC@")
		$Grpsuffix_txt:="_DCR"
		$vsDivNo:="DCR"
	Else 
		//all others are based on inspection resp
		$Grpsuffix_txt:="_"+$InspResp_txt
		$vsDivNo:=$InspResp_txt
		
End case 

$DBIE_L:=GRP_GetGroupRepID("UWInspEngineer"+$Grpsuffix_txt)

$0:=$DBIE_L

//End INSP_getDefaultUOE