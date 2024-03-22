//%attributes = {"invisible":true}
//Method: PHOTO_DelSIAorConsultantPages
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 05/04/21, 16:59:01
	// ----------------------------------------------------
	//Created : 
	Mods_2021_05  //Add code to allow for addition/ replacement/ or viewing of SIA aND QA FORMS
	// Modified by: designer (7/12/21)
	Mods_2021_07
	//  //use constants BMS Cons Transmittal and BMS Cons QA form
	// Modified by: Costas Manousakis-(Designer)-(2021-12-20T00:00:00 20:53:57)
	Mods_2021_12_bug
	//  `adjusted alert messages;fixed load record interactive
End if 
//
C_TEXT:C284($1; $Title_txt; $PictType_txt; $SelectMsg_txt)
$Title_txt:=$1
Case of 
	: ($Title_txt="Delete SIA Original")
		$PictType_txt:=BMS SIA
		$SelectMsg_txt:="Delete SIA Original Document"
		
	: ($Title_txt="Delete SIA Markup")
		$PictType_txt:=BMS SIA Markup
		$SelectMsg_txt:="Delete SIA Markup"
		
	: ($Title_txt="Delete Transmittal")
		$PictType_txt:=BMS Cons Transmittal
		$SelectMsg_txt:="Delete Consultant Transmittal"
		
	: ($Title_txt="Delete QA Form")
		$PictType_txt:=BMS Cons QA form
		$SelectMsg_txt:="Delete Consultant QA Form"
		
		
End case 
C_BOOLEAN:C305($delete_B)
$delete_B:=False:C215
QUERY:C277([Standard Photos:36]; [Standard Photos:36]InspID:1=[Inspections:27]InspID:2; *)
QUERY:C277([Standard Photos:36];  & ; [Standard Photos:36]PictType:5=$PictType_txt)
If (Records in selection:C76([Standard Photos:36])=1)
	CONFIRM:C162($SelectMsg_txt; "Delete"; "Do NOT Delete")
	$delete_B:=OK=1
	
	
End if 
If ($delete_B)
	//InitChangeStack (2)
	
	If (ut_LoadRecordInteractive(->[Standard Photos:36]))
		LogDeletion(->[Inspections:27]InspID:2; ->[Standard Photos:36]InspID:1; ->[Standard Photos:36]StdPhotoID:7; 2)
		DELETE RECORD:C58([Standard Photos:36])
		ALERT:C41("Deleted "+Replace string:C233($SelectMsg_txt; "Delete "; "")+"!")
	Else 
		ALERT:C41("Could not load "+Replace string:C233($SelectMsg_txt; "Delete "; "")+" record for deletion!")
	End if 
End if 
//End PHOTO_DelSIAorConsultantPages