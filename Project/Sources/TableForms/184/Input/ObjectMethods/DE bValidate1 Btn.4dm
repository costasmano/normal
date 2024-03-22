
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/09/15, 15:46:11
//----------------------------------------------------
//Method: Object Method: [LSS_Inspection].Inspection_Template.bValidate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/9/15 15:46:13)
	
	Mods_2015_08_bug  // 
	//Modified by: administrator (8/20/15 12:22:27)
	Mods_2015_12_bug  //Fix bug where accessibility records, ut records, dmeter recdords not updated all the time
	//Modified by: administrator (12/30/15 16:10:34)
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 12:20:55)
	Mods_2021_WP
	//  `
End if 
If (Not:C34(Read only state:C362([TIN_Inspections:184])))
	
	C_BOOLEAN:C305($Update_B)
	
	$Update_B:=False:C215
	CONFIRM:C162("Exit this Inspection and Save?"; "Exit and Save"; "Cancel")
	If (OK=1)
		NTI_SaveAndUpdateComments_WP(False:C215)
		NTI_InspCompleteCheck
		
		NTI_SaveInspection
		If (Modified record:C314([NTI_TunnelInfo:181]))
			[NTI_TunnelInfo:181]NTI_ModifiedBy_s:3:=Current user:C182
			[NTI_TunnelInfo:181]NTI_ModifiedTimeStamp_s:5:=ISODateTime(Current date:C33(*); Current time:C178(*))
			PushChange(1; ->[NTI_TunnelInfo:181]NTI_ModifiedBy_s:3)
			PushChange(1; ->[NTI_TunnelInfo:181]NTI_ModifiedTimeStamp_s:5)
			If (Old:C35([NTI_TunnelInfo:181]NTI_D2_d:54)#[NTI_TunnelInfo:181]NTI_D2_d:54)
				PushChange(1; ->[NTI_TunnelInfo:181]NTI_D2_d:54)
			End if 
			If (Old:C35([NTI_TunnelInfo:181]NTI_Damage_Actual_d:83)#[NTI_TunnelInfo:181]NTI_Damage_Actual_d:83)
				PushChange(1; ->[NTI_TunnelInfo:181]NTI_Damage_Actual_d:83)
			End if 
			If (Old:C35([NTI_TunnelInfo:181]NTI_Overhead_Actual_d:76)#[NTI_TunnelInfo:181]NTI_Overhead_Actual_d:76)
				PushChange(1; ->[NTI_TunnelInfo:181]NTI_Overhead_Actual_d:76)
			End if 
			If (Old:C35([NTI_TunnelInfo:181]NTI_SpecMemb_Actual_d:79)#[NTI_TunnelInfo:181]NTI_SpecMemb_Actual_d:79)
				PushChange(1; ->[NTI_TunnelInfo:181]NTI_SpecMemb_Actual_d:79)
			End if 
			
			FlushGrpChgs(1; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[NTI_TunnelInfo:181]NTI_i1_s:6; 0)
			SAVE RECORD:C53([NTI_TunnelInfo:181])
			
		End if 
		VALIDATE TRANSACTION:C240
		ACCEPT:C269
		
	End if 
Else 
	
	CANCEL TRANSACTION:C241
	CANCEL:C270
End if 


//End Object Method: [LSS_Inspection].Inspection_Template.bValidate

