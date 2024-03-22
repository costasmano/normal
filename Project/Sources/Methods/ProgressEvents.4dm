//%attributes = {"invisible":true}
If (False:C215)
	// Procedure: ProgressEvents
	//
	// This procedure provides event-handling for
	// the progress indicator, trapping for Cmd+period
	// and setting the ◊Abort flag to true if pressed.
	
	// Preconditions : None
	
	// Assumptions : None
	//
	// Created 4/30/94 —Forrest Swilling
End if 

If ((Modifiers ?? Command key bit:K16:2) & (KeyCode=Period:K15:45))
	<>Abort:=True:C214
	FILTER EVENT:C321
End if 