//Method: SpellAllTest.SpellCheck
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-03-17T00:00:00, 11:47:17
	// ----------------------------------------------------
	//Created : 
	Mods_2022_03
End if 

//
C_POINTER:C301($Wpfield_ptr; $todoaction_ptr; $wp_ptr)
$Wpfield_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "wpfield")
$todoaction_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "todoaction")
$wp_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "WPArea")
C_OBJECT:C1216(SpellCheckAllData_o)
C_POINTER:C301($Field_ptr)
C_TEXT:C284($WpLabel_txt)
C_LONGINT:C283($stack_L)
$Field_ptr:=SpellCheckAllData_o.fieldptr
$WpLabel_txt:=SpellCheckAllData_o.label
$stack_L:=SpellCheckAllData_o.stack

C_TEXT:C284($before_txt; $after_txt; $currArea_txt)
$before_txt:=WP Get text:C1575($wp_ptr->; wk expressions as value:K81:255)
C_BOOLEAN:C305($modified)
$modified:=OB Get:C1224($wp_ptr->; "modified"; Is boolean:K8:9)  // check if there have been some modifications before the spell check

SPELL CHECKING:C900

$after_txt:=WP Get text:C1575($wp_ptr->; wk expressions as value:K81:255)
$modified:=$modified | Not:C34($before_txt=$after_txt)
//ALERT(OBJECT Get title(*;"Wparealabel")+" done. Changes made : "+Choose($modified;"YES";"NOPE")+" text different "+Choose(($before_txt=$after_txt);"NO";"Yes"))
If ($modified)
	WP_CleanupComments($wp_ptr)  // first clean up the text
	$currArea_txt:=OBJECT Get title:C1068(*; "Wparealabel")
	SpellCheckAllData_o.modified:=True:C214
	Case of 
		: ($currArea_txt="Orientation")
			INSP_SaveComments_WP(New object:C1471("WPAreaname"; "WPArea"; "fieldptr"; ->[Inspections:27]OrientationText:204; "changeStack"; $stack_L))
			//
		: ($currArea_txt="General Remarks")
			INSP_SaveComments_WP(New object:C1471("WPAreaname"; "WPArea"; "fieldptr"; ->[Inspections:27]InspComments:171; "changeStack"; $stack_L))
		Else 
			InitChangeStack($stack_L)  // need to initialize the stack for elements
			INSP_SaveComments_WP(New object:C1471("WPAreaname"; "WPArea"; "fieldptr"; ->[ElementsSafety:29]ElmComments:23; "changeStack"; $stack_L))
			[ElementsSafety:29]Comment Flag:6:=(BLOB size:C605([ElementsSafety:29]ElmComments:23)>0)
			PushChange(2; ->[ElementsSafety:29]Comment Flag:6)
			TimeStamp_ut(->[ElementsSafety:29]; ->[ElementsSafety:29]DateCreated:16; ->[ElementsSafety:29]TimeCreated:17; ->[ElementsSafety:29]DateModified:18; ->[ElementsSafety:29]TimeModified:19)
			[ElementsSafety:29]Modified By:14:=<>CurrentUser_Name
			PushChange(2; ->[ElementsSafety:29]Modified By:14)
			PushChange(2; ->[ElementsSafety:29]DateModified:18)
			PushChange(2; ->[ElementsSafety:29]TimeModified:19)
			FlushGrpChgs(2; ->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2)
			SAVE RECORD:C53([ElementsSafety:29])
	End case 
	
End if 

//now cancel out of form
CANCEL:C270

//End SpellAllTest.SpellCheck