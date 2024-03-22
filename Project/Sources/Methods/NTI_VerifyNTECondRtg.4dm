//%attributes = {"invisible":true}
//Method: NTI_VerifyNTECondRtg
//Description
// Verify and if necessary update the cond rating of NTEs.
// Returns an object with info messages in an array
// Parameters
// $0 : $InfoMessage_obj
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/23/18, 13:02:36
	// ----------------------------------------------------
	//Created : 
	Mods_2018_02
	// Modified by: Costas Manousakis-(Designer)-(3/23/18 16:03:35)
	Mods_2018_03
	//  `
End if 
//
C_OBJECT:C1216($0; $InfoMessage_obj)
//save current list of NTEs
COPY NAMED SELECTION:C331([NTI_ELEM_TIN_INSP:185]; "$TEMPVERIFNTELIST")
ARRAY TEXT:C222($InfoMessages_atxt; 0)
C_LONGINT:C283($NewRating_L)

FIRST RECORD:C50([NTI_ELEM_TIN_INSP:185])
While (Not:C34(End selection:C36([NTI_ELEM_TIN_INSP:185])))
	//do only for elements that are not defects
	QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
	If (Not:C34([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y"))
		$NewRating_L:=NTI_CalculateRating([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; \
			[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18; \
			[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19; \
			[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20)
		If ($NewRating_L#[NTI_ELEM_TIN_INSP:185]ELEM_RATING:24)
			[NTI_ELEM_TIN_INSP:185]ELEM_RATING:24:=$NewRating_L
			LogChanges(->[NTI_ELEM_TIN_INSP:185]ELEM_RATING:24; ->[TIN_Inspections:184]InspectionID:2; ->[NTI_ELEM_TIN_INSP:185]InspectionID:1; ->[NTI_ELEM_TIN_INSP:185]ELEMID:2; 2)
			APPEND TO ARRAY:C911($InfoMessages_atxt; "Updated Condition Rating for Element "+String:C10([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3))
			SAVE RECORD:C53([NTI_ELEM_TIN_INSP:185])
		End if 
		
	End if 
	
	NEXT RECORD:C51([NTI_ELEM_TIN_INSP:185])
End while 

//Restore the seletion
USE NAMED SELECTION:C332("$TEMPVERIFNTELIST")
CLEAR NAMED SELECTION:C333("$TEMPVERIFNTELIST")
If (Size of array:C274($InfoMessages_atxt)>0)
	OB SET ARRAY:C1227($InfoMessage_obj; "Info"; $InfoMessages_atxt)
End if 

$0:=$InfoMessage_obj
//End NTI_VerifyNTECondRtg