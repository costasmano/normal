//%attributes = {"invisible":true}
//Method: NTI_CheckInspComplete
//Description
// check the current inspection if it is OK to mark as complete
// Parameters
// $0 : $Message_Obj ` object containing information/warnings/errors
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/15/18, 11:55:27
	// ----------------------------------------------------
	//Created : 
	Mods_2018_02
	
	C_OBJECT:C1216(NTI_CheckInspComplete; $0)
	
	// Modified by: Costas Manousakis-(Designer)-(10/09/19 11:22:45)
	Mods_2019_10_bug
	//  `check if field work complete date is in the future. CallReferences #663
End if 
//
C_OBJECT:C1216($0; $Message_obj)
ARRAY TEXT:C222($InfoMessages_atxt; 0)
ARRAY TEXT:C222($WarningMessages_atxt; 0)
ARRAY TEXT:C222($ErrorMessages_atxt; 0)

If ([TIN_Inspections:184]TeamLeader:11<=0)
	APPEND TO ARRAY:C911($ErrorMessages_atxt; "A Team leader has not been assigned to this Inspection!")
End if 

Case of 
	: ([TIN_Inspections:184]Agency:13="Mass. Highway@")
	: ([TIN_Inspections:184]Agency:13="Mass. Turnpike@")
	: ([TIN_Inspections:184]Agency:13="MassPort@")
	: ([TIN_Inspections:184]Agency:13="MBTA")
	: ([TIN_Inspections:184]Agency:13="MDC")
	: ([TIN_Inspections:184]Agency:13="MHD Underwater@")
	Else 
		If ([TIN_Inspections:184]ProjManager:14<=0)
			APPEND TO ARRAY:C911($ErrorMessages_atxt; "A Project Manager has not been assigned to this Inspection!")
		End if 
End case 

If ([TIN_Inspections:184]InspDate:3>[TIN_Inspections:184]InspCompleteDate:15)
	APPEND TO ARRAY:C911($ErrorMessages_atxt; "Inspection Complete Date "+String:C10([TIN_Inspections:184]InspCompleteDate:15; Internal date short:K1:7)+" is before Inspection Date "+String:C10([TIN_Inspections:184]InspDate:3; Internal date short:K1:7))
End if 

If ([TIN_Inspections:184]InspCompleteDate:15>Current date:C33(*))
	APPEND TO ARRAY:C911($ErrorMessages_atxt; "Inspection Complete Date "+String:C10([TIN_Inspections:184]InspCompleteDate:15; Internal date short:K1:7)+" is in the future!")
End if 

If ([TIN_Inspections:184]InspType:21="ZDA")
	//for damage inspections
	If ([TIN_Inspections:184]InspDate:3<[TIN_Inspections:184]DamageDate_d:48)
		APPEND TO ARRAY:C911($ErrorMessages_atxt; "Inspection Date "+String:C10([TIN_Inspections:184]InspDate:3; Internal date short:K1:7)+" is before Damage Date "+String:C10([TIN_Inspections:184]DamageDate_d:48; Internal date short:K1:7))
	End if 
	If ([TIN_Inspections:184]DamageBy_s:47="")
		APPEND TO ARRAY:C911($WarningMessages_atxt; "[Damage By] field has not been completed!")
	End if 
	
End if 

If (NTI_ImageSortNeeded_b)
	APPEND TO ARRAY:C911($ErrorMessages_atxt; "Image Sequences have been re-arranged! You have to Apply the New Sequence!")
End if 

C_TEXT:C284($NTE_Errors_txt)

$NTE_Errors_txt:=NTI_VerifyNTIQuantities
If ($NTE_Errors_txt#"")
	APPEND TO ARRAY:C911($ErrorMessages_atxt; $NTE_Errors_txt)
End if 
C_OBJECT:C1216($InfoMessage_obj)

$InfoMessage_obj:=NTI_VerifyNTECondRtg
OB GET ARRAY:C1229($InfoMessage_obj; "Info"; $InfoMessages_atxt)

If (Size of array:C274($InfoMessages_atxt)>0)
	OB SET ARRAY:C1227($Message_obj; "Info"; $InfoMessages_atxt)
End if 
If (Size of array:C274($WarningMessages_atxt)>0)
	OB SET ARRAY:C1227($Message_obj; "Warning"; $WarningMessages_atxt)
End if 
If (Size of array:C274($ErrorMessages_atxt)>0)
	OB SET ARRAY:C1227($Message_obj; "Error"; $ErrorMessages_atxt)
End if 

$0:=$Message_obj
//End NTI_CheckInspComplete