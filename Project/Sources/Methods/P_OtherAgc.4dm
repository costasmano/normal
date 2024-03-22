//%attributes = {"invisible":true}
If (False:C215)
	//GP P_OtherAgc
	//Copyright © 1995-1997,  Albert S. Leung, Thomas D. Nee, All Rights Reserved.
	//Load data for Other Agency Bridge inspection
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(12/7/2005 16:10:55)
	Mods_2005_CM20
	Mods_2011_03  //Change width of form from 620 to 830
	Mods_2019_07  //Create new list box NewNBIS_StackInfoform to test as width and height changed
	//Modified by: Chuck Miller (7/18/19 12:51:34)
	// Modified by: Costas Manousakis-(Designer)-(3/31/20 15:04:37)
	Mods_2020_03
	//  `added missing title for DIST6
End if 

InitProcessVar
C_LONGINT:C283($Width_L; $Height_L)
C_LONGINT:C283($FW; $FL)
FORM GET PROPERTIES:C674([Bridge MHD NBIS:1]; DefOutLay; $FW; $FL)

$Width_L:=$FW
$Height_L:=600

If (Ok=1)
	Case of 
		: (<>vOtherAgc="DIST1")
			MainTitle:="District 1 Inspection"
		: (<>vOtherAgc="DIST2")
			MainTitle:="District 2 Inspection"
		: (<>vOtherAgc="DIST3")
			MainTitle:="District 3 Inspection"
		: (<>vOtherAgc="DIST4")
			MainTitle:="District 4 Inspection"
		: (<>vOtherAgc="DIST5")
			MainTitle:="District 5 Inspection"
		: (<>vOtherAgc="DIST6")
			MainTitle:="District 6 Inspection"
		: (<>vOtherAgc="MDC")
			MainTitle:="Department of Conservation and Recreation"
		: (<>vOtherAgc="DCR")
			MainTitle:="Department of Conservation and Recreation"
		: (<>vOtherAgc="MTA")
			MainTitle:="Massachusetts Turnpike Authority Inspection"
		: (<>vOtherAgc="MBTA")
			MainTitle:="Massachusetts Bay Transportation Authority Inspection"
		: (<>vOtherAgc="COE")
			MainTitle:="Corps of Engineers Inspection"
		: (<>vOtherAgc="MPA")
			MainTitle:="Massachusetts Port Authority Inspection"
		: (<>vOtherAgc="FED")
			MainTitle:="Federal Government Inspection"
	End case 
	CurInsp:=<>vOtherAgc
	ModSelSort(->[Bridge MHD NBIS:1]; DefInLay; DefOutLay; MainTitle; $Width_L; $Height_L; 1; 8; ->[Bridge MHD NBIS:1]BDEPT:1; ">"; ->[Bridge MHD NBIS:1]InspResp:173; ->CurInsp)
End if 