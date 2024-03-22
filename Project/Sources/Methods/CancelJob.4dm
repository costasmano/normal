//%attributes = {"invisible":true}
If (False:C215)
	//procedure: CancelJob
	//by: Albert Leung
	//created: 10/1/97
	//purpose: check for the keys Command-.  
End if 

If ((Modifiers ?? Command key bit:K16:2) & (KeyCode=Period:K15:45))
	CONFIRM:C162("Abort?")
	If (Ok=1)
		<>vCancel:=True:C214
		FILTER EVENT:C321
	End if 
End if 