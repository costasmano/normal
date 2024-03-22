//%attributes = {"invisible":true}
//Method: NTI_SaveInspection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/25/16, 15:59:32
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(4/20/18 14:23:47)
	Mods_2018_04
	//  `use NTI_CalcClearances
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 12:20:55)
	Mods_2021_WP
	//  `
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//Add call to Synch_ReturnForward to reset new style vsForward
	//Modified by: Chuck Miller (1/11/22 14:41:42)
End if 
//
If (NTI_ImageSortNeeded_b)
	CONFIRM:C162("Images have been Re-arranged! Apply the new sequence before saving? If you do not, the arrangement will be lost!"; "Apply new Sequence")
	If (OK=1)
		NTI_ApplyImageSort
	Else 
		OBJECT SET VISIBLE:C603(*; "ImageSortWarning"; False:C215)
		NTI_ImageSortNeeded_b:=False:C215
	End if 
	
End if 
NTI_CalcClearances
If ([TIN_Inspections:184]TeamLeader:11#0) & (Old:C35([TIN_Inspections:184]TeamLeader:11)=0)
	vsForward:=Synch_ReturnForward([NTI_TunnelInfo:181]NTI_i6_s:11; [NTI_TunnelInfo:181]NTI_InspResp:73; ""; [TIN_Inspections:184]TeamLeader:11)
End if 
PushAllChanges(1; ->[TIN_Inspections:184]; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; ->[TIN_Inspections:184]TeamLeader:11; ->[TIN_Inspections:184]DistrInspEng:12; ->[TIN_Inspections:184]DistrTnlInspEng:22; ->[TIN_Inspections:184]ProjManager:14)
If ([TIN_Inspections:184]TeamLeader:11#Old:C35([TIN_Inspections:184]TeamLeader:11))
	
	If ([TIN_Inspections:184]TeamLeader:11#0)
		LogLink(->[TIN_Inspections:184]TeamLeader:11; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; 1; ->[Personnel:42]Person ID:1)
	Else 
		LogChanges(->[TIN_Inspections:184]TeamLeader:11; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; 1)
	End if 
End if 
If ([TIN_Inspections:184]DistrInspEng:12#Old:C35([TIN_Inspections:184]DistrInspEng:12))
	
	If ([TIN_Inspections:184]DistrInspEng:12#0)
		LogLink(->[TIN_Inspections:184]DistrInspEng:12; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; 1; ->[Personnel:42]Person ID:1)
	Else 
		LogChanges(->[TIN_Inspections:184]DistrInspEng:12; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; 1)
	End if 
	
End if 
If ([TIN_Inspections:184]DistrTnlInspEng:22#Old:C35([TIN_Inspections:184]DistrTnlInspEng:22))
	
	If ([TIN_Inspections:184]DistrTnlInspEng:22#0)
		LogLink(->[TIN_Inspections:184]DistrTnlInspEng:22; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; 1; ->[Personnel:42]Person ID:1)
	Else 
		LogChanges(->[TIN_Inspections:184]DistrTnlInspEng:22; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; 1)
	End if 
	
End if 
If ([TIN_Inspections:184]ProjManager:14#Old:C35([TIN_Inspections:184]ProjManager:14))
	
	If ([TIN_Inspections:184]ProjManager:14#0)
		LogLink(->[TIN_Inspections:184]ProjManager:14; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; 1; ->[Personnel:42]Person ID:1)
	Else 
		LogChanges(->[TIN_Inspections:184]ProjManager:14; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; 1)
	End if 
	
End if 

//C_LONGINT($viAreaMod)//Command Replaced was o_C_INTEGER
//C_TEXT($vsStrValue)// Command Replaced was o_C_STRING length was 2
//WR GET AREA PROPERTY (AreaGeneralRemarks;wr modified;$viAreaMod;$vsStrValue)
//If ($viAreaMod=1)
//INSP_4DWRITE_SaveToFld (AreaGeneralRemarks;->[TIN_Inspections]Comments;1)
//End if 
If (Size of array:C274(ptr_changes{1})>0)
	[TIN_Inspections:184]ModifiedBy:10:=Current user:C182
	[TIN_Inspections:184]ModifiedTimeStamp:9:=ISODateTime(Current date:C33(*); Current time:C178(*))
	PushChange(1; ->[TIN_Inspections:184]ModifiedBy:10)
	PushChange(1; ->[TIN_Inspections:184]ModifiedTimeStamp:9)
End if 
FlushGrpChgs(1; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; 1)

SAVE RECORD:C53([TIN_Inspections:184])

//End NTI_SaveInspection