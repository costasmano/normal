If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/5/2005 11:41:38)
	Mods_2005_CM19
End if 
Case of 
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
		
	: (Form event code:C388=On Open Detail:K2:23)
		READ ONLY:C145([Bridge MHD NBIS:1])
		
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		//REDRAW(◊asWindows)
End case 