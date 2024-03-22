//%attributes = {"invisible":true}
// Method: INSP_ViewAllComments
// Description
// Display the assembled comments
// 
// Parameters
// 1 : 4D Write area
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/10/06, 20:09:52
	// ----------------------------------------------------
	Mods_2007_CM04
	// Modified by: costasmanousakis-(Designer)-(12/2/11 15:58:27)
	Mods_2011_12
	//  `Moved external window to 20,20 from 10,10
	//  `Disabled editing in the area to avoid confusion.
	// Modified by: Costas Manousakis-(Designer)-(3/14/12 16:47:41)
	Mods_2012_03
	//  `Moved external window to  top letft corner 20,60 to clear the menubar
	// Modified by: Costas Manousakis-(Designer)-(11/2/17 10:38:23)
	Mods_2017_11
	//  `For design users do not lock the document or the File menu.
	Mods_2021_Delete
End if 
//C_LONGINT($1;$MainArea)
//$MainArea:=$1
//C_BLOB($vCmtsArea_BLOB)
//C_LONGINT($newTempwin)
//$newTempwin:=_ O_Open external window(20;60;500;500;Plain window;"All Comments";"_4D Write")
//  //Set Doc Margins ($newTempwin)
//$vCmtsArea_BLOB:=WR Area to blob ($MainArea;1)
//WR BLOB TO AREA ($newTempwin;$vCmtsArea_BLOB)
//WR SET AREA PROPERTY ($newTempwin;wr modified;0;"")  // not modified
//WR SET DOC PROPERTY ($newTempwin;wr view menubar;1)
//WR SET DOC PROPERTY ($newTempwin;wr view rulers;1)
//If (User in group(Current user;"Design Access Group"))
//Else 
//WR LOCK DOCUMENT ($newTempwin;1)
//WR LOCK COMMAND ($newTempwin;100;1)  // lock file menu.
//WR LOCK COMMAND ($newTempwin;101;1)  // lock file menu.
//WR LOCK COMMAND ($newTempwin;102;1)  // lock file menu.
//WR LOCK COMMAND ($newTempwin;103;1)  // lock file menu.
//WR LOCK COMMAND ($newTempwin;104;1)  // lock file menu.

//End if 

//SET BLOB SIZE($vCmtsArea_BLOB;0)