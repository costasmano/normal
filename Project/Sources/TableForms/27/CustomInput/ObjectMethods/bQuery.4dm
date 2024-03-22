READ ONLY:C145(Current form table:C627->)
QUERY:C277(Current form table:C627->)
If (OK=1)
	If (Records in selection:C76(Current form table:C627->)>0)
		READ ONLY:C145([Bridge MHD NBIS:1])
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Inspections:27]BIN:1)
	End if 
End if 
OBJECT SET ENABLED:C1123(bValidate; False:C215)  // Command Replaced was o_DISABLE BUTTON 
