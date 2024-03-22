//%attributes = {"invisible":true}
If (False:C215)
	
	//GP P_AllBridges
	//Copyright © 1995-1997,  Albert S. Leung, Thomas D. Nee, All Rights Reserved.
	//Load data for all bridges
	
	// Modified by: costasmanousakis-(Designer)-(12/7/2005 16:10:55)
	Mods_2005_CM20
	Mods_2011_03  //Change width of form from 620 to 830
	Mods_2019_07  //Create new form to test as designer so width and height changed
	//Modified by: Chuck Miller (7/18/19 12:51:34)
End if 
C_LONGINT:C283($Width_L; $Height_L)
//If (Current user="Designer")
$Width_L:=880
$Height_L:=600
//Else 
//$Width_L:=830
//$Height_L:=456
//End if 
InitProcessVar
MainTitle:="All Bridge Records for the State of Massachusetts"
CurInsp:=""
ModSelSort(->[Bridge MHD NBIS:1]; DefInLay; DefOutLay; MainTitle; $Width_L; $Height_L; 1; 8; ->[Bridge MHD NBIS:1]BDEPT:1; ">")
//ModSelSort (»[Bridge MHD NBIS];DefInLay;DefOutLay;MainTitle;620;450;1;4;
//»[Bridge MHD NBIS]BDEPT;">")
