//%attributes = {"invisible":true}
//Method: PHOTO_LoadSIAorConsultantPages
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 04/20/21, 13:40:12
	// ----------------------------------------------------
	//Created : 
	Mods_2021_04
	// Modified by: designer (7/12/21)
	Mods_2021_07
	//  //use constants BMS Cons Transmittal and BMS Cons QA form
	// Modified by: Costas Manousakis-(Designer)-(2021-12-20T00:00:00 21:12:04)
	Mods_2021_12_bug
	//  `added descriptive alerts;fixed load record interactive
End if 
//
C_TEXT:C284($1; $Title_txt; $PictType_txt; $SelectMsg_txt; $Descr_txt)
$Title_txt:=$1
Case of 
	: ($Title_txt="Load SIA Original")
		$PictType_txt:=BMS SIA
		$SelectMsg_txt:="Select SIA Original Document"
	: ($Title_txt="Replace SIA Original")
		$PictType_txt:=BMS SIA
		$SelectMsg_txt:="Select Replacement SIA Original Document"
		
	: ($Title_txt="Load SIA Markup")
		$PictType_txt:=BMS SIA Markup
		$SelectMsg_txt:="Select SIA Markup"
		
	: ($Title_txt="Replace SIA Markup")
		$PictType_txt:=BMS SIA Markup
		$SelectMsg_txt:="Select Replacement SIA Markup"
		
	: ($Title_txt="Load Consultant Transmittal")
		$PictType_txt:=BMS Cons Transmittal
		$SelectMsg_txt:="Select Consultant Transmittal"
		
	: ($Title_txt="Replace Consultant Transmittal")
		$PictType_txt:="BMS Cons Transmittal"
		$SelectMsg_txt:="Select Replacement Consultant Transmittal"
		
	: ($Title_txt="Load Consultant QA Form")
		$PictType_txt:=BMS Cons QA form
		$SelectMsg_txt:="Select Consultant QA Form"
	: ($Title_txt="Replace Consultant QA Form")
		$PictType_txt:=BMS Cons QA form
		$SelectMsg_txt:="Select Replacement Consultant QA Form"
		
End case 
$Descr_txt:=Replace string:C233($SelectMsg_txt; "Select "; "")  //get the attachment descr
$Descr_txt:=Replace string:C233($Descr_txt; "Replacement "; "")

QUERY:C277([Standard Photos:36]; [Standard Photos:36]InspID:1=[Inspections:27]InspID:2; *)
QUERY:C277([Standard Photos:36];  & ; [Standard Photos:36]PictType:5=$PictType_txt)
C_LONGINT:C283($imgSize_L; $vlRes; $MaxImageSize_L)
C_BOOLEAN:C305($NewRecord_B)
$NewRecord_B:=(Records in selection:C76([Standard Photos:36])=0)

C_TEXT:C284($File_txt)
C_PICTURE:C286($vTempPic)
ARRAY TEXT:C222($Files_atxt; 0)
$File_txt:=Select document:C905(""; ".PDF"; $SelectMsg_txt; Multiple files:K24:7; $Files_atxt)
If (OK=1)
	READ PICTURE FILE:C678($Files_atxt{1}; $vTempPic)
	$vlRes:=1-OK
	
	$imgSize_L:=Picture size:C356($vTempPic)
	
	InitChangeStack(2)
	$MaxImageSize_L:=1350  //in kb
	
	If ($vlRes=0)
		If ($imgSize_L>($MaxImageSize_L*1024))
			
			C_TEXT:C284($vsmsg)
			$vsmsg:="Selected image file size ("+String:C10(($imgSize_L/1024); "###,###,###")+"Kb) is excessive!"
			$vsmsg:=$vsmsg+" Image will not been saved! "
			$vsmsg:=$vsmsg+" Please use an image less than "+String:C10($MaxImageSize_L; "###,### Kb")+" !"
			ALERT:C41($vsmsg)
			
		Else 
			If ($NewRecord_B)
				CREATE RECORD:C68([Standard Photos:36])
				[Standard Photos:36]InspID:1:=[Inspections:27]InspID:2
				[Standard Photos:36]PictType:5:=$PictType_txt
				[Standard Photos:36]Portrait:4:=True:C214
				Inc_Sequence("StandardPhotos"; ->[Standard Photos:36]StdPhotoID:7)
				//log the stuff
				PushChange(2; ->[Standard Photos:36]PictType:5)
				PushChange(2; ->[Standard Photos:36]Portrait:4)
				LogNewRecord(->[Inspections:27]InspID:2; ->[Standard Photos:36]InspID:1; ->[Standard Photos:36]StdPhotoID:7; 2; "StandardPhotos")
				SAVE RECORD:C53([Standard Photos:36])
			End if 
			
			If (ut_LoadRecordInteractive(->[Standard Photos:36]))
				[Standard Photos:36]Std Photo:3:=$vTempPic
				PushChange(2; ->[Standard Photos:36]Std Photo:3)
				
				FlushGrpChgs(2; ->[Inspections:27]InspID:2; ->[Standard Photos:36]InspID:1; ->[Standard Photos:36]StdPhotoID:7; 2)
				SAVE RECORD:C53([Standard Photos:36])
				UNLOAD RECORD:C212([Standard Photos:36])
				ALERT:C41("Loaded "+$Descr_txt+"!")
				
			Else 
				ALERT:C41("Could not load "+$Descr_txt+" record to save changes")
			End if 
		End if 
	Else 
		ALERT:C41("Could not load file")
	End if 
End if 
//End PHOTO_LoadSIAorConsultantPages