//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/23/10, 15:18:18
	// ----------------------------------------------------
	// Method: CRTG_RecentAction
	// Description
	//  ` Get the recent action for rating review group
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_09
End if 
C_POINTER:C301($1; $ReceActDate_ptr; $2; $IsHere_ptr)
$ReceActDate_ptr:=$1
$IsHere_ptr:=$2
$ReceActDate_ptr->:=!00-00-00!
$ReceActDate_ptr->:=MaxDate([Conslt Rating:63]SentInHouseRev1:36; [Conslt Rating:63]SentInHouseRev2:37; [Conslt Rating:63]SentInHouseRev3:38; [Conslt Rating:63]SentInHouseRev4:53; [Conslt Rating:63]SentBackToConslt1:33; [Conslt Rating:63]SentBackToConslt2:34; [Conslt Rating:63]SentBackToConslt3:35; [Conslt Rating:63]SentBackToConslt4:62; [Conslt Rating:63]NBISLetter:26)
$IsHere_ptr->:=""
Case of 
	: ([Conslt Rating:63]NBISLetter:26#!00-00-00!)
		$IsHere_ptr->:="A"
	: ([Conslt Rating:63]SentBackToConslt4:62#!00-00-00!)
		$IsHere_ptr->:="N"
	: ([Conslt Rating:63]SentInHouseRev4:53#!00-00-00!)
		$IsHere_ptr->:="Y"
	: ([Conslt Rating:63]SentBackToConslt3:35#!00-00-00!)
		$IsHere_ptr->:="N"
	: ([Conslt Rating:63]SentInHouseRev3:38#!00-00-00!)
		$IsHere_ptr->:="Y"
	: ([Conslt Rating:63]SentBackToConslt2:34#!00-00-00!)
		$IsHere_ptr->:="N"
	: ([Conslt Rating:63]SentInHouseRev2:37#!00-00-00!)
		$IsHere_ptr->:="Y"
	: ([Conslt Rating:63]SentBackToConslt1:33#!00-00-00!)
		$IsHere_ptr->:="N"
	: ([Conslt Rating:63]SentInHouseRev1:36#!00-00-00!)
		$IsHere_ptr->:="Y"
End case 