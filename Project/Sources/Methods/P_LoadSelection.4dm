//%attributes = {"invisible":true}
If (False:C215)
	//GP P_LoadSelection
	//Copyright © 1995-1997,  Albert S. Leung, Thomas D. Nee, All Rights Reserved.
	//Load data from saved set
	// Modified by: costasmanousakis-(Designer)-(12/7/2005 16:10:55)
	Mods_2005_CM20
	// Modified by: costasmanousakis-(Designer)-(5/24/10 14:14:17)
	Mods_2010_05
	//  `Added the name of the Set file in the MainTitle
	Mods_2011_03  //Change width of form from 620 to 830
	Mods_2019_09  //Create method to handle resize of windows between out and input forms
	//Modified by: Chuck Miller (9/26/19 14:51:05)
End if 
Compiler_Utilities
InitProcessVar
MainTitle:="Saved Selection"
CurInsp:=""
C_TEXT:C284($path; $extension)

LOAD SET:C185([Bridge MHD NBIS:1]; "Temp"; "")
If (Ok=1)
	$path:=GetPath(Document)
	$path:=Replace string:C233(Document; $path; "")
	$extension:=GetFileExtension(Document)
	$path:=Replace string:C233($path; $extension; "")
	MainTitle:=MainTitle+" : "+$path
	USE SET:C118("Temp")
	CLEAR SET:C117("Temp")
	
	C_LONGINT:C283($Width_L; $Height_L)
	C_LONGINT:C283($FW; $FL)
	FORM GET PROPERTIES:C674([Bridge MHD NBIS:1]; DefOutLay; $FW; $FL)
	
	$Width_L:=$Width_L
	$Height_L:=600
	
	FORM SET INPUT:C55([Bridge MHD NBIS:1]; DefInLay)
	//FORM SET OUTPUT([Bridge MHD NBIS];DefOutLay)
	C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 10
	$RecSel:=String:C10(Records in selection:C76([Bridge MHD NBIS:1]))
	ControlMenuBar(2)
	COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "UserRegionA")
	NewWindow($Width_L; $Height_L; 1; 8)  //Window for this process
	UpdatWindArray(""; Current process:C322)
	SET WINDOW TITLE:C213(MainTitle+" ["+$RecSel+"]")
	DIALOG:C40([Bridge MHD NBIS:1]; DefOutLay)
	//MODIFY SELECTION([Bridge MHD NBIS])
	UpdatWindArray(""; Current process:C322)
	CLEAR NAMED SELECTION:C333("UserRegionA")
	CLOSE WINDOW:C154
	ControlMenuBar(1)
End if 
