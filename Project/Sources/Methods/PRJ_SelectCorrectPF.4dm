//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SelectCorrectPF
// User name (OS): charlesmiller
// Date and time: 05/08/09, 10:23:48
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_05  //r001  `05/08/09, 10:23:51  `Continue changes PRJ Design Contract Changes 
	Mods_2009_06  //r002 `06/11/09, 13:41:43   `Merge PRJ Design Contract Changes
End if 
If (Records in selection:C76([PRJ_ProjectFile:117])>1)
	ARRAY LONGINT:C221(PRJ_FileNumbers_al; 0)
	ARRAY LONGINT:C221(PRJ_FileNumbers_al; Records in selection:C76([PRJ_ProjectFile:117]))
	ARRAY LONGINT:C221($FileIds_al; 0)
	ARRAY LONGINT:C221($FileIds_al; Records in selection:C76([PRJ_ProjectFile:117]))
	
	SELECTION TO ARRAY:C260([PRJ_ProjectFile:117]PF_FileNumber_l:3; PRJ_FileNumbers_al; [PRJ_ProjectFile:117]PF_FileID_l:1; $FileIds_al)
	C_LONGINT:C283($Loop_l; $Width_l; $Height_l; $Win_l)
	C_TEXT:C284(PRJ_FileMessage_txt)
	PRJ_FileMessage_txt:="Select one of the "+String:C10(Size of array:C274(PRJ_FileNumbers_al))+" File Numbers are associated with this design contract from the drop down below."+Char:C90(Carriage return:K15:38)
	For ($Loop_l; 1; Size of array:C274(PRJ_FileNumbers_al))
		If ($Loop_l>1)
			PRJ_FileMessage_txt:=PRJ_FileMessage_txt+" ,"+String:C10(PRJ_FileNumbers_al{$Loop_l})
		Else 
			PRJ_FileMessage_txt:=PRJ_FileMessage_txt+String:C10(PRJ_FileNumbers_al{$Loop_l})
		End if 
		
	End for 
	FORM GET PROPERTIES:C674([PRJ_ProjectDetails:115]; "SelectFileFromDC"; $Width_l; $Height_l)
	INSERT IN ARRAY:C227(PRJ_FileNumbers_al; 0; 1)
	
	$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; ""; "ut_CloseCancel")
	DIALOG:C40([PRJ_ProjectDetails:115]; "SelectFileFromDC")
	CLOSE WINDOW:C154
	If (OK=1) & (PRJ_FileNumbers_al>1)
		[PRJ_ProjectDetails:115]PF_FileID_l:3:=$FileIds_al{PRJ_FileNumbers_al-1}
		[PRJ_ProjectDetails:115]DC_DesignContractID_l:54:=Num:C11(<>PRJ_SelectedData_txt)
	Else 
		
	End if 
	ARRAY LONGINT:C221(PRJ_FileNumbers_al; 0)
	ARRAY LONGINT:C221($FileIds_al; 0)
	
Else 
	If (Records in selection:C76([PRJ_ProjectFile:117])=0)
		CREATE RECORD:C68([PRJ_ProjectFile:117])
		Inc_Sequence("PF_FileID_l"; ->[PRJ_ProjectFile:117]PF_FileID_l:1)
		[PRJ_ProjectFile:117]PF_FileNumber_l:3:=[PRJ_ProjectFile:117]PF_FileID_l:1*-1
		SAVE RECORD:C53([PRJ_ProjectFile:117])
	End if 
	[PRJ_ProjectDetails:115]PF_FileID_l:3:=[PRJ_ProjectFile:117]PF_FileID_l:1
	[PRJ_ProjectDetails:115]DC_DesignContractID_l:54:=Num:C11(<>PRJ_SelectedData_txt)
End if 
//End PRJ_SelectCorrectPF