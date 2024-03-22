//----------------------------------------------------
//Method: Form Method: [Bridge MHD NBIS];"NewMBTANBIS_StackInfo"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(5/1/20 14:37:59)
	Mods_2020_05
	//  `made all columns in LB not editable
End if 
If (Form event code:C388=On Load:K2:1)
	C_TEXT:C284(mbta_BridgeType_txt)
	C_REAL:C285(INSP_KiloPtVal_r)
End if 
NBISStackInfo_FM
//End Form Method: [Bridge MHD NBIS];"NewMBTANBIS_StackInfo"