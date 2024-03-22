//%attributes = {"invisible":true}
If (False:C215)
	//GP P_MBTA
	//Copyright © 1995-1997,  Albert S. Leung, Thomas D. Nee, All Rights Reserved.
	//Load data for MBTA Bridge inspection
	// Modified by: costasmanousakis-(Designer)-(12/7/2005 16:10:55)
	Mods_2005_CM20
	Mods_2011_03  //Change width of form from 620 to 830
	Mods_2013_02  //r001 ` Created so that we can have two nbis stack info forms
	//NBIS Stack Info
	//NBIS Stack Info MBTA 
	//Modified by: Charles Miller (2/14/13 14:01:06)
	
End if 
InitProcessVar
MainTitle:="Massachusetts Bay Transportation Authority"
CurInsp:="MBTA"
DefOutLay:="NewMBTANBIS_StackInfo"
C_LONGINT:C283($Width_L; $Height_L)
//If (Current user="Designer")
$Width_L:=880
$Height_L:=600
ModSelSort(->[Bridge MHD NBIS:1]; DefInLay; DefOutLay; MainTitle; $Width_l; 456; 1; 8; ->[Bridge MHD NBIS:1]BDEPT:1; ">"; ->[Bridge MHD NBIS:1]InspResp:173; ->CurInsp)
