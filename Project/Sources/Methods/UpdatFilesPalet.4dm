//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: UpdatFilesPalet
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By:  Jim Steinman
	//Date:  10/5/95
	
	//Purpose: This keeps the files pallete popup in sync with the frontmost window
	
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

C_LONGINT:C283($i; <>LFilePalPID)

If (<>LFilePalPID>0)  //There is an active files palette
	$i:=Find in array:C230(<>aiWindows; Frontmost process:C327(*))
	
	If (Size of array:C274(<>asWindows)=1)
		$i:=1
	End if 
	
	If ($i>0)  //This process is in the popup
		<>asWindows:=$i
		<>aiWindows{0}:=$i
		POST OUTSIDE CALL:C329(-1)
	End if 
End if 
REDRAW:C174(<>asWindows)