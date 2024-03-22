//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/28/07, 12:25:18
	// ----------------------------------------------------
	// Method: CRTG_RatingStatus
	// Description
	// 
	// 
	// Parameters
	// $0 : $Status_txt : txt
	// ----------------------------------------------------
	Mods_2007_CM07
End if 
C_TEXT:C284($0; $Status_txt)
$Status_txt:=""
C_DATE:C307($Rec_d; $Inhouse_d; $Sent_d)
C_TEXT:C284($Subm_txt)

Case of 
	: ([Conslt Rating:63]AssignStatus:43#"Active")
		//Nothing for non-active 
	: ([Conslt Rating:63]RepSubmit3:41#!00-00-00!)
		$Subm_txt:="3"
		$Rec_d:=[Conslt Rating:63]RepSubmit3:41
		$Inhouse_d:=[Conslt Rating:63]SentInHouseRev3:38
		$Sent_d:=[Conslt Rating:63]SentBackToConslt3:35
	: ([Conslt Rating:63]RepSubmit2:31#!00-00-00!)
		$Subm_txt:="2"
		$Rec_d:=[Conslt Rating:63]RepSubmit2:31
		$Inhouse_d:=[Conslt Rating:63]SentInHouseRev2:37
		$Sent_d:=[Conslt Rating:63]SentBackToConslt2:34
	: ([Conslt Rating:63]RepSubmit1:23#!00-00-00!)
		$Subm_txt:="1"
		$Rec_d:=[Conslt Rating:63]RepSubmit1:23
		$Inhouse_d:=[Conslt Rating:63]SentInHouseRev1:36
		$Sent_d:=[Conslt Rating:63]SentBackToConslt1:33
	Else 
		$Rec_d:=!00-00-00!
		$Inhouse_d:=!00-00-00!
		$Sent_d:=!00-00-00!
		$Subm_txt:=""
		
End case 
If ($Subm_txt#"")
	$Status_txt:=CRTG_SubmStatus($Rec_d; $Inhouse_d; $Sent_d)+"-"+$Subm_txt
End if 

$0:=$Status_txt