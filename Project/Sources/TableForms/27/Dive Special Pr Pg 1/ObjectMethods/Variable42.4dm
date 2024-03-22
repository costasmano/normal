C_DATE:C307($vdInspDate)
If (Form event code:C388=On Printing Detail:K2:18)
	$vdInspDate:=Date:C102(String:C10([Bridge MHD NBIS:1]Item93B:170))
	If ([Bridge MHD NBIS:1]Item92BB:166#0)
		$vdInspDate:=Add to date:C393($vdInspDate; 0; [Bridge MHD NBIS:1]Item92BB:166; 0)
		vNextInspectionDate:=Uppercase:C13(String:C10($vdInspDate; Internal date abbreviated:K1:6))
	Else 
		vNextInspectionDate:="N"
	End if 
End if 