//%attributes = {"invisible":true}
// Method: INSP_PrintSketchChartSingle
// Description
// Print a single sketch or chart.
// 
// Parameters
// $0 : Ending portrait/landscape mode : boolean
// $1 : $bPortrait : starting porttrait mode : boolean
// $2 : $NewPage_b : send a new page before printing or not : boolean
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/22/07, 08:59:45
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:45:37)
	Mods_2007_CM12_5301
	// Modified by: Costas Manousakis-(Designer)-(7/15/16 19:12:05)
	Mods_2016_08
	//  `use only set Print option(orientation;1 | 2) to switch portrait or landscape
	//  `use method Print_SetPDFDest to change name of output
	Mods_2021_01  //Add code that will create PDFs of all [Inspections]InspApproved=2
	// Code to  use new form to print rotated images in landscape
	// Modified by: Costas Manousakis-(Designer)-(2/25/21 13:43:48)
	Mods_2021_02
	//  `always use the rotated form for landscape sketches/charts
End if 
C_BOOLEAN:C305($0; $1; $bPortrait; $2; $NewPage_b)
$bPortrait:=$1
If (Count parameters:C259>1)
	$NewPage_b:=$2
Else 
	$NewPage_b:=True:C214
End if 

C_BOOLEAN:C305(Insp_PrintLandscapeRotated; INSP_CreatePDFsofApproved_B)

vPicture1:=[Standard Photos:36]Std Photo:3
Case of 
	: ([Standard Photos:36]PictType:5=BMS Sketch)
		vPage2Title:="SKETCHES"
		vPhotoNum1:="Sketch "+String:C10([Standard Photos:36]SeqNum:6)+":"
	: ([Standard Photos:36]PictType:5=BMS Chart)
		vPage2Title:="CHARTS"
		vPhotoNum1:="Chart "+String:C10([Standard Photos:36]SeqNum:6)+":"
End case 
INSP_ConvertSKCH([Standard Photos:36]Portrait:4)
If ([Standard Photos:36]Portrait:4)
	If ([Standard Photos:36]Portrait:4#$bPortrait)
		PAGE BREAK:C6
		//G_PrintOptions 
		SET PRINT OPTION:C733(Orientation option:K47:2; 1)
		Print_SetPDFDest
		$bPortrait:=True:C214
	Else 
		If ($NewPage_b)
			PAGE BREAK:C6(>)
		End if 
	End if 
	If (viInspPreviewErr=0)
		Print form:C5([Standard Photos:36]; "PrintPhotoPortrait")
	End if 
Else 
	//Sketch or chart in Landscape mode
	If (True:C214)
		//print the image rotatedINSP_ViewAllComments_WP
		If (Not:C34(INSP_CreatePDFsofApproved_B))
			SET PRINT OPTION:C733(Orientation option:K47:2; 1)  //make sure orientation is portrait
		End if 
		SET PRINT OPTION:C733(Orientation option:K47:2; 1)  //make sure orientation is portrait
		
		If ($NewPage_b)
			PAGE BREAK:C6(>)
		End if 
		If (viInspPreviewErr=0)
			Print form:C5([Standard Photos:36]; "PrintPhoto_Rotate")
		End if 
	Else 
		// print it the old way
		If ([Standard Photos:36]Portrait:4#$bPortrait)
			//CLOSE PRINTING JOB
			PAGE BREAK:C6
			//G_PrintOptions (2)
			SET PRINT OPTION:C733(Orientation option:K47:2; 2)
			Print_SetPDFDest
			$bPortrait:=False:C215
		Else 
			If ($NewPage_b)
				PAGE BREAK:C6(>)
			End if 
		End if 
		If (viInspPreviewErr=0)
			Print form:C5([Standard Photos:36]; "PrintPhotoLand")
		End if 
		
	End if 
	
End if 

$0:=$bPortrait