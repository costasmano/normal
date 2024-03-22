//%attributes = {"invisible":true}
//Method: PHOTO_ViewSIAorConsultantPages
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 04/20/21, 14:36:04
	// ----------------------------------------------------
	//Created : 
	Mods_2021_04
	// Modified by: designer (7/12/21)
	Mods_2021_07
	//  //use constants BMS Cons Transmittal and BMS Cons QA form
End if 
//
C_TEXT:C284($1; $Title_txt; $TempFolderPath_txt; $PictType_txt)
$Title_txt:=$1
Case of 
	: ($Title_txt="View SIA Original")
		$PictType_txt:=BMS SIA
	: ($Title_txt="View SIA Markup")
		$PictType_txt:=BMS SIA Markup
	: ($Title_txt="View Transmittal")
		$PictType_txt:=BMS Cons Transmittal
	: ($Title_txt="View QA Form")
		$PictType_txt:=BMS Cons QA form
End case 

QUERY:C277([Standard Photos:36]; [Standard Photos:36]InspID:1=[Inspections:27]InspID:2; *)
QUERY:C277([Standard Photos:36];  & ; [Standard Photos:36]PictType:5=$PictType_txt)  // BMS SI&A

$TempFolderPath_txt:=Temporary folder:C486
$TempFolderPath_txt:=$TempFolderPath_txt+$Title_txt+".pdf"
WRITE PICTURE FILE:C680($TempFolderPath_txt; [Standard Photos:36]Std Photo:3; ".pdf")
OPEN URL:C673($TempFolderPath_txt)

//End PHOTO_ViewSIAorConsultantPages