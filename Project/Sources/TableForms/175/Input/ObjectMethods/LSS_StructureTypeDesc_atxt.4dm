
// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 07/08/14, 15:20:29
// ----------------------------------------------------
// Method: Object Method: [LSS_Inspection].Input_ITS.LSS_StructureTypeDesc_atxt
// Description
// 
//
// Parameters
// ----------------------------------------------------
Case of 
	: (Form event code:C388=On Load:K2:1)
		LSS_StructureTypeIDs_atxt:=Find in array:C230(LSS_StructureTypeIDs_atxt; [LSS_UT:175]LSS_StructureTypeId_s:7)
		If (LSS_StructureTypeIDs_atxt>0)
			LSS_StructureTypeDesc_atxt:=LSS_StructureTypeIDs_atxt
		Else 
			LSS_StructureTypeDesc_atxt:=-1
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		If (LSS_StructureTypeDesc_atxt>0)
			[LSS_UT:175]LSS_StructureTypeId_s:7:=LSS_StructureTypeIDs_atxt{LSS_StructureTypeDesc_atxt}
		End if 
End case 