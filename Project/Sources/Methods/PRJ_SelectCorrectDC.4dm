//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SelectCorrectDC
// User name (OS): charlesmiller
// Date and time: 05/14/09, 13:31:22
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_05  //r001  `05/14/09, 13:31:24  `r001  `05/07/09, 11:28:58  `Continue changes PRJ Design Contract Changes 
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_ConsultantOverideID_l
	Mods_2009_06  //r002 `06/11/09, 13:43:02   `Merge PRJ Design Contract Changes
End if 
If (Records in selection:C76([PRJ_DesignContracts:123])>1)
	ARRAY LONGINT:C221(PRJ_DesignContract_al; 0)
	ARRAY LONGINT:C221(PRJ_DesignContract_al; Records in selection:C76([PRJ_DesignContracts:123]))
	ARRAY LONGINT:C221($DesignContractIDs_al; 0)
	ARRAY LONGINT:C221($DesignContractIDs_al; Records in selection:C76([PRJ_DesignContracts:123]))
	
	SELECTION TO ARRAY:C260([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3; PRJ_DesignContract_al; [PRJ_DesignContracts:123]DC_DesignContractID_l:1; $DesignContractIDs_al)
	C_LONGINT:C283($Loop_l; $Width_l; $Height_l; $Win_l)
	C_TEXT:C284(PRJ_FileMessage_txt)
	PRJ_FileMessage_txt:="Select one of the "+String:C10(Size of array:C274(PRJ_FileNumbers_al))+" Design Contract Numbers from the drop down below."+Char:C90(Carriage return:K15:38)
	For ($Loop_l; 1; Size of array:C274(PRJ_FileNumbers_al))
		If ($Loop_l>1)
			PRJ_FileMessage_txt:=PRJ_FileMessage_txt+" ,"+String:C10(PRJ_FileNumbers_al{$Loop_l})
		Else 
			PRJ_FileMessage_txt:=PRJ_FileMessage_txt+String:C10(PRJ_FileNumbers_al{$Loop_l})
		End if 
		
	End for 
	FORM GET PROPERTIES:C674([PRJ_ProjectDetails:115]; "SelectFileFromPF"; $Width_l; $Height_l)
	INSERT IN ARRAY:C227(PRJ_DesignContract_al; 0; 1)
	
	$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; ""; "ut_CloseCancel")
	DIALOG:C40([PRJ_ProjectDetails:115]; "SelectFileFromPF")
	CLOSE WINDOW:C154
	If (OK=1) & (PRJ_DesignContract_al>1)
		[PRJ_ProjectDetails:115]DC_DesignContractID_l:54:=$DesignContractIDs_al{PRJ_DesignContract_al-1}
	End if 
	ARRAY LONGINT:C221(PRJ_DesignContract_al; 0)
	ARRAY LONGINT:C221($DesignContractIDs_al; 0)
End if 

//End PRJ_SelectCorrectDC