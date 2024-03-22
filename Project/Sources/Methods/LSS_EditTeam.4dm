//%attributes = {"invisible":true}
//Method: LSS_EditTeam
//Description
// Edit the Team member list
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/11/15, 15:47:48
	// ----------------------------------------------------
	//Created : 
	Mods_2015_05
	// Modified by: Costas Manousakis-(Designer)-(9/1/15 10:39:08)
	Mods_2015_09
	//  `The TwoListMove dialog is a Project Form now
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 
//
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
ARRAY LONGINT:C221($TempTmID_aL; 0)
ARRAY TEXT:C222($TempTeam_atxt; 0)
C_LONGINT:C283(UseList_HL; OmitList_HL)
COPY ARRAY:C226(LSS_TeamMembers_atxt; $TempTeam_atxt)
COPY ARRAY:C226(LSS_TeamMemberIDs_aL; $TempTmID_aL)
C_BOOLEAN:C305(TWOLIST_MOVEONLY_B)
TWOLIST_MOVEONLY_B:=True:C214
C_TEXT:C284($Key_txt)
$Key_txt:=[LSS_Inspection:164]LSS_InspectionId_s:1
ARRAY LONGINT:C221($InspTeamIDs_aL; 0)
ARRAY TEXT:C222($InspTeam_atxt; 0)

Begin SQL
	select [LSS_TeamMembers].[LSS_TeamMemberId_L]
	from 
	[LSS_TeamMembers]
	where [LSS_TeamMembers].[LSS_InspectionId_s] = :$Key_txt
	into :$InspTeamIDs_aL
	
End SQL

C_LONGINT:C283($loop_L; $persIndx_L)
ARRAY TEXT:C222($InspTeam_atxt; Size of array:C274($InspTeamIDs_aL))

For ($loop_L; 1; Size of array:C274($InspTeamIDs_aL))
	$persIndx_L:=Find in array:C230(aPeople_ID; $InspTeamIDs_aL{$loop_L})
	
	If ($persIndx_L>0)
		$InspTeam_atxt{$loop_L}:=aPeople{$persIndx_L}
	Else 
		$InspTeam_atxt{$loop_L}:="Unknown ID"
	End if 
	
End for 

If (Size of array:C274($InspTeam_atxt)>0)
	OmitList_HL:=ut_ArrayToHL(->$InspTeam_atxt; ""; ->$InspTeamIDs_aL)
Else 
	OmitList_HL:=New list:C375
End if 
UseList_HL:=ut_ArrayToHL(->$TempTeam_atxt; ""; ->$TempTmID_aL)

C_TEXT:C284(vCancelBtntxt; vOKBtnTxt; vUseListLbl_txt; vOmitLbl_txt)
vCancelBtntxt:="No Changes"
vOKBtnTxt:="Proceed"
vUseListLbl_txt:="Available Team members"
vOmitLbl_txt:="Inspection Team"
//Display 

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674("TwoListMove"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
//$winID:=Open form window([Dialogs];"TwoListMove")
DIALOG:C40("TwoListMove")
CLOSE WINDOW:C154($Win_l)
C_LONGINT:C283($numTmMmbrs; $i)
$numTmMmbrs:=Count list items:C380(OmitList_HL)
ARRAY LONGINT:C221($TempTmID_aL; $numTmMmbrs)
ARRAY TEXT:C222($TempTeam_atxt; $numTmMmbrs)
For ($i; 1; $numTmMmbrs)
	C_LONGINT:C283($ref)
	C_TEXT:C284($Name)
	GET LIST ITEM:C378(OmitList_HL; $i; $Ref; $Name)
	
	$TempTeam_atxt{$i}:=$Name
	$TempTmID_aL{$i}:=$Ref
End for 
If (Is a list:C621(UseList_HL))
	CLEAR LIST:C377(UseList_HL; *)
End if 
If (Is a list:C621(OmitList_HL))
	CLEAR LIST:C377(OmitList_HL; *)
End if 
TWOLIST_MOVEONLY_B:=False:C215  //set to the default
If ((Ok=1) & (Size of array:C274($TempTeam_atxt)>=0))
	
	//Preserve current selection 
	COPY ARRAY:C226($TempTeam_atxt; $InspTeam_atxt)
	COPY ARRAY:C226($TempTmID_aL; $InspTeamIDs_aL)
	QUERY:C277([LSS_TeamMembers:173]; [LSS_TeamMembers:173]LSS_InspectionId_s:1=[LSS_Inspection:164]LSS_InspectionId_s:1)
	//[LSS_TeamMembers]LSS_InspectionId_s
	//[LSS_TeamMembers]LSS_TeamMemberId_L
	C_TEXT:C284($ErrorMethodCalled_txt)
	$ErrorMethodCalled_txt:=Method called on error:C704
	ON ERR CALL:C155("LSS_ErrorMethod")
	If (Records in selection:C76([LSS_TeamMembers:173])>0)
		
		FIRST RECORD:C50([LSS_TeamMembers:173])
		For ($i; 1; Records in selection:C76([LSS_TeamMembers:173]))
			LogDeletion(->[LSS_Inspection:164]LSS_InspectionId_s:1; ->[LSS_TeamMembers:173]LSS_InspectionId_s:1; ->[LSS_TeamMembers:173]LSS_TeamMemberId_L:2; 3; ->[Personnel:42]Person ID:1)
			NEXT RECORD:C51([LSS_TeamMembers:173])
		End for 
		DELETE SELECTION:C66([LSS_TeamMembers:173])
		
	End if 
	For ($i; 1; Size of array:C274($InspTeam_atxt))
		CREATE RECORD:C68([LSS_TeamMembers:173])
		[LSS_TeamMembers:173]LSS_InspectionId_s:1:=[LSS_Inspection:164]LSS_InspectionId_s:1
		[LSS_TeamMembers:173]LSS_TeamMemberId_L:2:=$InspTeamIDs_aL{$i}
		LogNewRecord(->[LSS_Inspection:164]LSS_InspectionId_s:1; ->[LSS_TeamMembers:173]LSS_InspectionId_s:1; ->[LSS_TeamMembers:173]LSS_TeamMemberId_L:2; 3; ""; ->[Personnel:42]Person ID:1)
		SAVE RECORD:C53([LSS_TeamMembers:173])
	End for 
	ON ERR CALL:C155($ErrorMethodCalled_txt)
	LSS_FillTeamMembers
End if 

//End LSS_EditTeam