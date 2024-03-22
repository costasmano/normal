C_TEXT:C284(vLevelOfInsp)  // Command Replaced was o_C_STRING length was 5

If (Form event code:C388=On Printing Detail:K2:18)
	vLevelOfInsp:=Get_Description(->aInspLevel_; ->aInspLevelCod_; ->[Inspections:27]LevelofInsp:105)
End if 