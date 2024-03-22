//%attributes = {"invisible":true}
If (False:C215)
	//procedure: EditTeam
	//By: Albert Leung
	//Date Created: 12/31/96
	//Purpose:  Handle the team member arrays in the dialog TeamMember
	
	Mods_2005_CM01
	Mods_2005_CM06
	// Modified by: costasmanousakis-(Designer)-(11/30/07 14:27:14)
	Mods_2007_CM_5401
	Mods_2009_03  //CJM  r001   `03/06/09, 12:50:27`Upgrade from open form window to open window
	// Modified by: costasmanousakis-(Designer)-(5/13/11 15:52:23)
	Mods_2011_05
	//  `Cleand up If false code
	Mods_2011_06  // CJ Miller`06/13/11, 16:28:48      `Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(9/1/15 10:39:08)
	Mods_2015_09
	//  `The TwoListMove dialog is a Project Form now
End if 
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
	G_Insp_RelateInsp(->[Field Trip:43]InspID:1)
	If (Records in selection:C76([Field Trip:43])>0)
		FIRST RECORD:C50([Field Trip:43])
		For ($i; 1; Records in selection:C76([Field Trip:43]))
			LogDeletion(->[Inspections:27]InspID:2; ->[Field Trip:43]InspID:1; ->[Field Trip:43]Person ID:2; 3; ->[Personnel:42]Person ID:1)
			NEXT RECORD:C51([Field Trip:43])
		End for 
		DELETE SELECTION:C66([Field Trip:43])
	End if 
	For ($i; 1; Size of array:C274(aInspTeam))
		CREATE RECORD:C68([Field Trip:43])
		[Field Trip:43]InspID:1:=[Inspections:27]InspID:2
		[Field Trip:43]Person ID:2:=aInspTeamID{$i}
		LogNewRecord(->[Inspections:27]InspID:2; ->[Field Trip:43]InspID:1; ->[Field Trip:43]Person ID:2; 3; ""; ->[Personnel:42]Person ID:1)
		SAVE RECORD:C53([Field Trip:43])
	End for 
	If ([BMS Inspections:44]Inspection ID:1>0)
		QUERY:C277([BMS Field Trip:56]; [BMS Field Trip:56]Inspection ID:1=[BMS Inspections:44]Inspection ID:1)
		If (Records in selection:C76([BMS Field Trip:56])>0)
			FIRST RECORD:C50([BMS Field Trip:56])
			For ($i; 1; Records in selection:C76([BMS Field Trip:56]))
				LogDeletion(->[BMS Inspections:44]Inspection ID:1; ->[BMS Field Trip:56]Inspection ID:1; ->[BMS Field Trip:56]Person ID:2; 3; ->[Personnel:42]Person ID:1)
				NEXT RECORD:C51([BMS Field Trip:56])
			End for 
			DELETE SELECTION:C66([BMS Field Trip:56])
		End if 
		For ($i; 1; Size of array:C274(aInspTeam))
			CREATE RECORD:C68([BMS Field Trip:56])
			[BMS Field Trip:56]Inspection ID:1:=[BMS Inspections:44]Inspection ID:1
			[BMS Field Trip:56]Person ID:2:=aInspTeamID{$i}
			LogNewRecord(->[BMS Inspections:44]Inspection ID:1; ->[BMS Field Trip:56]Inspection ID:1; ->[BMS Field Trip:56]Person ID:2; 3; ""; ->[Personnel:42]Person ID:1)
			SAVE RECORD:C53([BMS Field Trip:56])
		End for 
		QUERY:C277([BMS Field Trip:56]; [BMS Field Trip:56]Inspection ID:1=[BMS Inspections:44]Inspection ID:1)
	End if 
End if 
ARRAY INTEGER:C220(aTempTmID; 0)
ARRAY TEXT:C222(aTempTeam; 0)  //Command Replaced was o_ARRAY string length was 44