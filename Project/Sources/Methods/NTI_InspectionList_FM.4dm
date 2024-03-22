//%attributes = {"invisible":true}
//Method: NTI_InspectionList_FM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/04/16, 16:40:00
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
End if 
//
Case of 
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		
	: (Form event code:C388=On Load:K2:1)
		NTI_i8_s_atxt:=0
		If ([NTI_TunnelInfo:181]NTI_i8_s:13#"")
			NTI_i8_s_atxt:=Find in array:C230(NTI_i8_s_atxt; [NTI_TunnelInfo:181]NTI_i8_s:13+"@")
		End if 
		If (NTI_i8_s_atxt<1)
			NTI_i8_s_atxt:=0
			NTI_i8_s_atxt{0}:="Select Route Direction"
		End if 
		
		NTI_i9_L_atxt:=0
		NTI_i9_L_atxt:=Find in array:C230(NTI_i9_L_atxt; String:C10([NTI_TunnelInfo:181]NTI_i9_L:14)+"@")
		
		If (NTI_i9_L_atxt<1)
			NTI_i9_L_atxt:=0
			NTI_i9_L_atxt{0}:="Select Route Type"
		End if 
		OBJECT SET ENABLED:C1123(NTI_i8_s_atxt; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(NTI_i9_L_atxt; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		G_SetInspFont
		NTI_ListTIN_Inspections
		OBJECT SET VISIBLE:C603(*; "PrintInspections"; Records in selection:C76([TIN_Inspections:184])>0)
	: (Form event code:C388=On Validate:K2:3)
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
		
End case 

//End NTI_InspectionList_FM