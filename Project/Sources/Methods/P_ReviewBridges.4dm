//%attributes = {"invisible":true}
//GP P_ReviewBridges
//Copyright © 1995-1997,  Albert S. Leung, Thomas D. Nee, All Rights Reserved.
//Search for bridges that will have data sent
If (False:C215)
	Mods_2020_07_bug  // Fix bug where modify selection still being used. It should have been dialog
	//Also changed to use ut_OpenNewWindow so we can add a close box
	//Modified by: CJ (7/6/20 15:54:47)
End if 
ARRAY TEXT:C222($aLocal; 0)  //Command Replaced was o_ARRAY string length was 20
C_LONGINT:C283($i)

InitProcessVar
MainTitle:="Bridges with changes that have not been sent"
CurInsp:=""
CREATE EMPTY SET:C140([Bridge MHD NBIS:1]; "Temp")
QUERY:C277([Activity Log:59]; [Activity Log:59]Status:9=0; *)
QUERY:C277([Activity Log:59];  & ; [Activity Log:59]RefIDType:26=0)
DISTINCT VALUES:C339([Activity Log:59]Local ID:15; $aLocal)
For ($i; 1; Size of array:C274($aLocal))
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$aLocal{$i})
	ADD TO SET:C119([Bridge MHD NBIS:1]; "Temp")
End for 
If (Ok=1)
	USE SET:C118("Temp")
	CLEAR SET:C117("Temp")
End if 
FORM SET INPUT:C55([Bridge MHD NBIS:1]; DefInLay)
FORM SET OUTPUT:C54([Bridge MHD NBIS:1]; DefOutLay)
C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 10
$RecSel:=String:C10(Records in selection:C76([Bridge MHD NBIS:1]))
ControlMenuBar(2)
COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "UserRegionA")
C_LONGINT:C283($win_L; $Width_l; $Height_L)
FORM GET PROPERTIES:C674([Bridge MHD NBIS:1]; DefOutLay; $Width_l; $Height_L)

$win_L:=ut_OpenNewWindow($Width_l+10; 500; 1; Plain form window:K39:10; MainTitle+" ["+$RecSel+"]"; "ut_CloseCancel")

//NewWindow (620;450;1;4)  //Window for this process
UpdatWindArray(""; Current process:C322)
//SET WINDOW TITLE(MainTitle+" ["+$RecSel+"]")
DIALOG:C40([Bridge MHD NBIS:1]; DefOutLay)

//MODIFY SELECTION([Bridge MHD NBIS])
UpdatWindArray(""; Current process:C322)
CLEAR NAMED SELECTION:C333("UserRegionA")
CLOSE WINDOW:C154
ControlMenuBar(1)