//[Bridge MHD NBIS];"SI & A Input"
//Popupmenu for the Integral Bridge type

If (User in group:C338(Current user:C182; "Jointless Bridge"))
	POPUPMENUC(->aIntegralD_; ->aIntegralC_; ->[Bridge MHD NBIS:1]JointlessType:202)
	If (Form event code:C388=On Clicked:K2:4)
		PushChange(1; ->[Bridge MHD NBIS:1]JointlessType:202)
	End if 
End if 