//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// Date and time: 03/26/05, 19:02:04
	// ----------------------------------------------------
	// Method: Method: ONETIME_ReSendLNKLogEntries
	// Description
	// ReSend LNK entries in Activity log where the source is not the ◊Destination of this DB,
	//and they have not been sent already.
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM08
	
End if 


QUERY:C277([Activity Log:59]; [Activity Log:59]Activity Type:3="FIX"; *)
QUERY:C277([Activity Log:59];  & ; [Activity Log:59]ActField Name:20="FIXLNK")
If (Records in selection:C76([Activity Log:59])=0)
	ALERT:C41("Setting Link Records to be ReSent")
	SHORT_MESSAGE("Please Wait...")
	
	QUERY:C277([Activity Log:59]; [Activity Log:59]Activity Type:3="LNK"; *)
	QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Status:9=1; *)
	QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Source:2#<>Destination)
	If (Records in selection:C76([Activity Log:59])>0)
		While (Not:C34(End selection:C36([Activity Log:59])))
			[Activity Log:59]Status:9:=0  //mark as unsent
			SAVE RECORD:C53([Activity Log:59])
			NEXT RECORD:C51([Activity Log:59])
		End while 
	End if 
	
	CREATE RECORD:C68([Activity Log:59])
	[Activity Log:59]Activity Type:3:="FIX"
	[Activity Log:59]ActField Name:20:="FIXLNK"
	[Activity Log:59]dDate:5:=Current date:C33(*)
	[Activity Log:59]tTime:6:=Current time:C178(*)
	[Activity Log:59]User Name:4:=Current user:C182
	[Activity Log:59]Status:9:=1  //not in the transfer list
	SAVE RECORD:C53([Activity Log:59])
	//FLUSH CACHE
	CLOSE WINDOW:C154
End if 

