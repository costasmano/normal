If (False:C215)
	//Script: ◊asWindows   [Dialogs];"FilesPalette"
	//ACI University Programming Classes
	//Created By: Jim Steinman
	//Date:  10/5/95
	
	//Purpose: Brings to front the selected window or hides process if appropriate
	
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

Case of 
	: (<>aiWindows{<>asWindows}<0)  //This is a background process
		If (Frontmost process:C327(*)=Abs:C99(<>aiWindows{<>asWindows}))  //Is front window a background process (-num)
			HIDE PROCESS:C324(-<>aiWindows{<>asWindows})
		Else 
			SHOW PROCESS:C325(-<>aiWindows{<>asWindows})
			BRING TO FRONT:C326(-<>aiWindows{<>asWindows})
		End if 
		
	: (<>asWindows>0)
		SHOW PROCESS:C325(<>aiWindows{<>asWindows})
		BRING TO FRONT:C326(<>aiWindows{<>asWindows})
		
	: (<>asWindows=0)
		<>asWindows:=<>aiWindows{0}
End case 

<>aiWindows{0}:=<>asWindows

REDRAW:C174(<>asWindows)
//End of script