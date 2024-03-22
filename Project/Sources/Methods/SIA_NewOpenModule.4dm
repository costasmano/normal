//%attributes = {"invisible":true}
//Method: SIA_NewOpenModule
//Description
//  ` Uniform method to handle the 'modules' in the Bridge Input form
// Parameters
// $1 : $LBQueryName_txt
// $2 : $PageNo_L
// $3 : $FormName_txt (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/03/12, 08:28:05
	// ----------------------------------------------------
	//Created : 
	Mods_2012_05
	// Modified by: Costas Manousakis-(Designer)-(10/23/13 14:04:55)
	Mods_2013_10
	//  `Added Alerts if not one record is found in the  LB_Query table
	
End if 
//
C_TEXT:C284($1; $LBQueryName_txt)
C_LONGINT:C283($2; $PageNo_L)
C_TEXT:C284($FormName_txt; $alertmsg_txt)
$LBQueryName_txt:=$1
$PageNo_L:=$2
$FormName_txt:=$LBQueryName_txt

If (Count parameters:C259>2)
	C_TEXT:C284($3)
	$FormName_txt:=$3
End if 

C_LONGINT:C283($LBcount_L)
SET QUERY DESTINATION:C396(Into variable:K19:4; $LBcount_L)
QUERY:C277([LB_QueryTable:147]; [LB_QueryTable:147]QueryName_s:1=$LBQueryName_txt)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

Case of 
	: ($LBcount_L>1)
		$alertmsg_txt:="Error searching for size information on listing ["+$LBQueryName_txt+"] : Multiple Entries ("+String:C10($LBcount_L)+") found!!!"
		$alertmsg_txt:=$alertmsg_txt+Char:C90(13)+"Please notify the Bridge Data Control Unit!"
		ALERT:C41($alertmsg_txt)
		SIA_MountModule($FormName_txt)
	: ($LBcount_L=1)
		SIA_BridgeInpNavCTRL($PageNo_L)
	Else 
		
		If (User in group:C338(<>CurrentUser_Name; "Design Access Group"))
			SIA_BridgeInpNavCTRL($PageNo_L)
		Else 
			$alertmsg_txt:="Error searching for size information on listing ["+$LBQueryName_txt+"] : No Entries found!!!"
			$alertmsg_txt:=$alertmsg_txt+Char:C90(13)+"Please notify the Bridge Data Control Unit!"
			ALERT:C41($alertmsg_txt)
			SIA_MountModule($FormName_txt)
		End if 
		
End case 
//End SIA_NewOpenModule