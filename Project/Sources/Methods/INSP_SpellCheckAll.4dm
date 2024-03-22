//%attributes = {"invisible":true}
//Method: INSP_SpellCheckAll
//Description
//  ` Go through all 4D Write Pro blobs in an inspection and execute a spell check on each.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/14/12, 10:17:37
	// ----------------------------------------------------
	//Created : 
	Mods_2012_03
	//Mods_2021_Delete 
	// Modified by: Costas Manousakis-(Designer)-(2022-03-17T00:00:00 15:06:20)
	Mods_2022_03
	//  `modified for Write Pro
End if 
//
//save any changes to the WP areas
INSP_SaveInspCommts
C_LONGINT:C283($AreasChecked)
//C_TEXT($vsStrValue)
$AreasChecked:=0
//$NewTempWin:=0
C_LONGINT:C283($spellWindow)
C_OBJECT:C1216(SpellCheckAllData_o)

If (BLOB size:C605([Inspections:27]OrientationText:204)>0)
	$AreasChecked:=$AreasChecked+1
	SpellCheckAllData_o:=New object:C1471("fieldptr"; ->[Inspections:27]OrientationText:204; "stack"; 1; "label"; "Orientation"; "modified"; False:C215)
	$spellWindow:=Open form window:C675("SpellCheckWP"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4)
	DIALOG:C40("SpellCheckWP")
	
	CLOSE WINDOW:C154($spellWindow)
	
	If (SpellCheckAllData_o.modified)
		//need to update the Orientation area in the current form
		INSP_Comments_WP_OM(New object:C1471("WPAreaname"; "DE Orientation_WP"; "fieldptr"; ->[Inspections:27]OrientationText:204; "formEvent"; On Load:K2:1; "changeStack"; 1))
	End if 
	
End if 

If (BLOB size:C605([Inspections:27]InspComments:171)>0) & (Not:C34(OB Get:C1224(SpellCheckAllData_o; "abortspell"; Is boolean:K8:9)))
	$AreasChecked:=$AreasChecked+1
	SpellCheckAllData_o:=New object:C1471("fieldptr"; ->[Inspections:27]InspComments:171; "stack"; 1; "label"; "General Remarks"; "modified"; False:C215)
	$spellWindow:=Open form window:C675("SpellCheckWP"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4)
	DIALOG:C40("SpellCheckWP")
	
	CLOSE WINDOW:C154($spellWindow)
	If (SpellCheckAllData_o.modified)
		//need to update the general remarks area in the current form
		INSP_Comments_WP_OM(New object:C1471("WPAreaname"; "DE GenRemarks_WP"; "fieldptr"; ->[Inspections:27]InspComments:171; "formEvent"; On Load:K2:1; "changeStack"; 1))
	End if 
	
End if 

COPY NAMED SELECTION:C331([ElementsSafety:29]; "INSPELMTSPRESPLCHK")
QUERY:C277([ElementsSafety:29]; [ElementsSafety:29]InspID:4=[Inspections:27]InspID:2)
QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Comment Flag:6=True:C214)
If (Records in selection:C76([ElementsSafety:29])>0) & (Not:C34(OB Get:C1224(SpellCheckAllData_o; "abortspell"; Is boolean:K8:9)))
	Insp_SortElmtSfty  //sort the elements
	InitChangeStack(2)
	FIRST RECORD:C50([ElementsSafety:29])
	While (Not:C34(End selection:C36([ElementsSafety:29]))) & (Not:C34(OB Get:C1224(SpellCheckAllData_o; "abortspell"; Is boolean:K8:9)))
		If (BLOB size:C605([ElementsSafety:29]ElmComments:23)>0)
			$AreasChecked:=$AreasChecked+1
			GetElmtNumber
			SpellCheckAllData_o:=New object:C1471("fieldptr"; ->[ElementsSafety:29]ElmComments:23; \
				"stack"; 2; \
				"label"; INSP_ElmtSfty_ItemNo([ElementsSafety:29]ElementNo:1)+" "+\
				GetElmtNumber+" "+[ElementsSafety:29]Description:22; \
				"modified"; False:C215)
			$spellWindow:=Open form window:C675("SpellCheckWP"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4)
			DIALOG:C40("SpellCheckWP")
			
			CLOSE WINDOW:C154($spellWindow)
			
		End if 
		
		NEXT RECORD:C51([ElementsSafety:29])
	End while 
	
End if 

If ($AreasChecked>0)
	ALERT:C41("SpellCheck Complete!")
Else 
	ALERT:C41("No Comments found in Inspection Orientation, General Remarks, or Element Comments!!")
End if 

USE NAMED SELECTION:C332("INSPELMTSPRESPLCHK")
CLEAR NAMED SELECTION:C333("INSPELMTSPRESPLCHK")
//End INSP_SpellCheckAll