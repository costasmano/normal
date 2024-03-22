// ----------------------------------------------------
// Object Method: PRJ_DENewValue_txt
// User name (OS): cjmiller
// Date and time: 04/12/07, 12:38:52
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2
End if 
If (Self:C308->="")
	OBJECT SET VISIBLE:C603(*; "MakeChangeButton"; False:C215)
Else 
	If (<>FieldToChange_txt="File No")
		QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3=PRJ_DENewValue_txt)
		If (Records in selection:C76([PRJ_ProjectFile:117])=1)
			OBJECT SET VISIBLE:C603(*; "MakeChangeButton"; True:C214)
		Else 
			PRJ_DENewValue_txt:=""
		End if 
	Else 
		OBJECT SET VISIBLE:C603(*; "MakeChangeButton"; True:C214)
	End if 
	
End if 
//End Object Method: PRJ_DENewValue_txt