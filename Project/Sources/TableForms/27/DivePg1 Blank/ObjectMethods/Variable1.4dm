//[Inspections];"Routine Form"
//Description for vUOE

C_TEXT:C284(vUOE)  // Command Replaced was o_C_STRING length was 44

If (Form event code:C388=On Printing Detail:K2:18)
	vUOE:=Uppercase:C13(Get_Description(->aPeople; ->aPeople_ID; ->[Inspections:27]DBrInspEngr:3))
End if 