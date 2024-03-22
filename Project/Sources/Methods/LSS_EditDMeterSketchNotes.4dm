//%attributes = {"invisible":true}
//Method: LSS_EditDMeterSketchNotes
//Description
// Edit the Notes for the D-Meter Sketch
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/20/16, 15:53:25
	// ----------------------------------------------------
	//Created : 
	Mods_2016_04_bug
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 
//

LSS_SetDefDMeterNotes

C_TEXT:C284(vtExtraText)
vtExtraText:=[LSS_Inspection:164]LSS_DMeterNotes_txt:50

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674([Dialogs:21]; "GetInspExtraCmts"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow(875; $Height_l; 0; Plain form window:K39:10; "D-Meter Sketch Notes")
DIALOG:C40([Dialogs:21]; "GetInspExtraCmts")
CLOSE WINDOW:C154
If (OK=1)
	vtExtraText:=f_TrimStr(vtExtraText; True:C214; True:C214)
	If (vtExtraText="")
		ALERT:C41("Cannot Clear the Notes for D-METER Sketch")
	Else 
		[LSS_Inspection:164]LSS_DMeterNotes_txt:50:=vtExtraText
	End if 
	
End if 
LSS_SetSaveandDelete
//End LSS_EditDMeterSketchNotes