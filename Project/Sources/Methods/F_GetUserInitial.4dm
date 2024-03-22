//%attributes = {"invisible":true}
//F_GetUserInitial 
//get user initials from the 4D User name 
//Parameters
// $0 : Initials
// $1 : $4Dusername "FirstName LastName"
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(1/13/17 15:31:09)
	Mods_2017_01
	//  `search for the username in the 4D User List and then in Personnel by the  4D user ID
	// Modified by: Costas Manousakis-(Designer)-(3/29/17 10:58:41)
	Mods_2017_03
	//  `fixed incorrect calculation for the initials
End if 

C_TEXT:C284($userName; $lastName; $firstName; $1)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284($initial; $0)  // Command Replaced was o_C_STRING length was 5

$userName:=$1

ARRAY TEXT:C222($UserNames_atxt; 0)
ARRAY LONGINT:C221($UserIDS_aL; 0)
GET USER LIST:C609($UserNames_atxt; $UserIDS_aL)

If (False:C215)
	
	$lastName:=Substring:C12($userName; Position:C15(" "; $userName)+1; Length:C16($userName))
	$firstName:=Substring:C12($userName; 1; Position:C15(" "; $userName)-1)
	$initial:=Substring:C12($firstName; 1; 1)
	
	QUERY:C277([Personnel:42]; [Personnel:42]Last Name:5=$lastName; *)
	QUERY:C277([Personnel:42];  & ; [Personnel:42]First Name:3=$firstName)
	
End if 

C_LONGINT:C283($Indx_L)
$Indx_L:=Find in array:C230($UserNames_atxt; $userName)

QUERY:C277([Personnel:42]; [Personnel:42]UserID_4D:12=$UserIDS_aL{$Indx_L})
$initial:=""
If (Records in selection:C76([Personnel:42])=1)
	If ([Personnel:42]Middle Name:4#"")
		$initial:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Middle Name:4; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
	Else 
		$initial:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
	End if 
	
End if 

$0:=$initial