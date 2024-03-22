//%attributes = {"invisible":true}
//Method: INSP_GetDefaultDBIE
//Description
// get the default DBIE ID for a bridge inspection based on Insp resp 
// CallReference #639
// Parameters
// $0 : $DBIE_L
// $1 : $InspResp_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/26/19, 17:27:42
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06_bug
	
	C_LONGINT:C283(INSP_GetDefaultDBIE; $0)
	C_TEXT:C284(INSP_GetDefaultDBIE; $1)
	
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
		$Grpsuffix_txt:=Substring:C12($InspResp_txt; 5; 1)
		$vsDivNo:="044"+Substring:C12([Bridge MHD NBIS:1]InspResp:173; 5; 1)
		
	: ($InspResp_txt="MDC@")
		$Grpsuffix_txt:=" "+"DCR"
		$vsDivNo:="DCR"
		
	: ($InspResp_txt="MBTA@")
		$Grpsuffix_txt:=" "+$InspResp_txt
		$vsDivNo:=$InspResp_txt
		
	: ($InspResp_txt="MTA@")
		$Grpsuffix_txt:=" "+$InspResp_txt
		$vsDivNo:=$InspResp_txt
		
	: ($InspResp_txt="MPA@")
		$Grpsuffix_txt:=" "+$InspResp_txt
		$vsDivNo:=$InspResp_txt
		
End case 

$DBIE_L:=GRP_GetGroupRepID("DistrictBIE"+$Grpsuffix_txt)

If ($DBIE_L>0)
Else 
	C_BOOLEAN:C305($PersRO_b)
	$PersRO_b:=Read only state:C362([Personnel:42])
	READ ONLY:C145([Personnel:42])
	
	QUERY:C277([Personnel:42]; [Personnel:42]Job Code:8=1; *)
	QUERY:C277([Personnel:42];  & ; [Personnel:42]Active:11=True:C214; *)
	QUERY:C277([Personnel:42];  & ; [Personnel:42]Division No:7=$vsDivNo)
	If (Records in selection:C76([Personnel:42])=1)
		$DBIE_L:=[Personnel:42]Person ID:1
	End if 
	
	If (Not:C34($PersRO_b))
		READ WRITE:C146([Personnel:42])
	End if 
	
End if 

$0:=$DBIE_L
//End INSP_GetDefaultDBIE