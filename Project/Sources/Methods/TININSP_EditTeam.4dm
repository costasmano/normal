//%attributes = {"invisible":true}
//Method: TININSP_EditTeam
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/12/16, 12:49:40
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
End if 
//
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
ARRAY INTEGER:C220(aTempTmID; 0)
ARRAY TEXT:C222(aTempTeam; 0)  //Command Replaced was o_ARRAY string length was 44
C_LONGINT:C283(UseList_HL; OmitList_HL)
COPY ARRAY:C226(aTeamMbr; aTempTeam)
COPY ARRAY:C226(aTeamMbrID; aTempTmID)
C_BOOLEAN:C305(TWOLIST_MOVEONLY_B)
TWOLIST_MOVEONLY_B:=True:C214
C_LONGINT:C283(UseList_HL; OmitList_HL)

If (Size of array:C274(aInspTeam)>0)
	OmitList_HL:=ut_ArrayToHL(->aInspTeam; ""; ->aInspTeamID)
Else 
	OmitList_HL:=New list:C375
End if 
UseList_HL:=ut_ArrayToHL(->aTempTeam; ""; ->aTempTmID)

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
C_LONGINT:C283($numTmMmbrs)
$numTmMmbrs:=Count list items:C380(OmitList_HL)
ARRAY INTEGER:C220(aTempTmID; $numTmMmbrs)
ARRAY TEXT:C222(aTempTeam; $numTmMmbrs)  //Command Replaced was o_ARRAY string length was 44
For ($i; 1; $numTmMmbrs)
	C_LONGINT:C283($ref)
	C_TEXT:C284($Name)
	GET LIST ITEM:C378(OmitList_HL; $i; $Ref; $Name)
	
	aTempTeam{$i}:=$Name
	aTempTmID{$i}:=$Ref
End for 
If (Is a list:C621(UseList_HL))
	CLEAR LIST:C377(UseList_HL; *)
End if 
If (Is a list:C621(OmitList_HL))
	CLEAR LIST:C377(OmitList_HL; *)
End if 
TWOLIST_MOVEONLY_B:=False:C215  //set to the default
If ((Ok=1) & (Size of array:C274(aTempTeam)>=0))
	//Preserve current selection of safety elements  
	COPY ARRAY:C226(aTempTeam; aInspTeam)
	COPY ARRAY:C226(aTempTmID; aInspTeamID)
	QUERY:C277([TIN_Insp_TmMembers:187]; [TIN_Insp_TmMembers:187]InspectionID:1=[TIN_Inspections:184]InspectionID:2)
	If (Records in selection:C76([TIN_Insp_TmMembers:187])>0)
		FIRST RECORD:C50([TIN_Insp_TmMembers:187])
		For ($i; 1; Records in selection:C76([TIN_Insp_TmMembers:187]))
			LogDeletion(->[TIN_Inspections:184]InspectionID:2; ->[TIN_Insp_TmMembers:187]InspectionID:1; ->[TIN_Insp_TmMembers:187]PersonID:2; 3; ->[Personnel:42]Person ID:1)
			NEXT RECORD:C51([TIN_Insp_TmMembers:187])
		End for 
		DELETE SELECTION:C66([TIN_Insp_TmMembers:187])
	End if 
	For ($i; 1; Size of array:C274(aInspTeam))
		CREATE RECORD:C68([TIN_Insp_TmMembers:187])
		[TIN_Insp_TmMembers:187]InspectionID:1:=[TIN_Inspections:184]InspectionID:2
		[TIN_Insp_TmMembers:187]PersonID:2:=aInspTeamID{$i}
		LogNewRecord(->[TIN_Inspections:184]InspectionID:2; ->[TIN_Insp_TmMembers:187]InspectionID:1; ->[TIN_Insp_TmMembers:187]PersonID:2; 3; ""; ->[Personnel:42]Person ID:1)
		SAVE RECORD:C53([TIN_Insp_TmMembers:187])
	End for 
	QUERY:C277([TIN_Insp_TmMembers:187]; [TIN_Insp_TmMembers:187]InspectionID:1=[TIN_Inspections:184]InspectionID:2)
End if 
ARRAY INTEGER:C220(aTempTmID; 0)
ARRAY TEXT:C222(aTempTeam; 0)  //Command Replaced was o_ARRAY string length was 44
//End TININSP_EditTeam