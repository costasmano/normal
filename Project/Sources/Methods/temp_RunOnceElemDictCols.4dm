//%attributes = {"invisible":true}
If (False:C215)
	//Modified from temp_FixActLog
	//to assign values to two new columns in Elem Dict
	//run only once
End if 

//First see if we did this already
C_LONGINT:C283($vlActLogFixes)
SET QUERY DESTINATION:C396(Into variable:K19:4; $vlActLogFixes)
QUERY:C277([Activity Log:59]; [Activity Log:59]Activity Type:3="FIX")
SET QUERY DESTINATION:C396(Into current selection:K19:1)

If ($vlActLogFixes=0)  //didn't run the method yet.
	SHORT_MESSAGE("Updating Elements Table ....")
	temp_SetFullLabelInElemDict
	
	//mark the activity log as run. 
	CREATE RECORD:C68([Activity Log:59])
	Inc_Sequence("Activity Log"; ->[Activity Log:59]RefID:28)  //Get the next sequence
	[Activity Log:59]Activity Type:3:="FIX"
	[Activity Log:59]User Name:4:=Current user:C182
	[Activity Log:59]dDate:5:=Current date:C33(*)
	[Activity Log:59]tTime:6:=Current time:C178(*)
	[Activity Log:59]Status:9:=1  //so it doesn't show in unsent
	SAVE RECORD:C53([Activity Log:59])
	//FLUSH CACHE
	UNLOAD RECORD:C212([Activity Log:59])
	CLOSE WINDOW:C154
End if 