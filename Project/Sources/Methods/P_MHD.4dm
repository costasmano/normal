//%attributes = {"invisible":true}
//GP P_MHD
//Load data for MHD Bridge inspection
If (False:C215)
	Mods_2011_03  //Change width of form from 620 to 830
	// Modified by: Costas Manousakis-(Designer)-(3/23/15 13:58:50)
	Mods_2015_03
	//  `Changed window title to Mass DOT
	Mods_2019_07  //Create new list box NewNBIS_StackInfoform to test as width and height changed
	//Modified by: Chuck Miller (7/18/19 12:51:34)
	
End if 
InitProcessVar
C_LONGINT:C283($Width_L; $Height_L)
C_LONGINT:C283($FW; $FL)
FORM GET PROPERTIES:C674([Bridge MHD NBIS:1]; DefOutLay; $FW; $FL)

$Width_L:=$FW
$Height_L:=600

MainTitle:="Massachusetts DOT"
CurInsp:="DIST@"
ModSelSort(->[Bridge MHD NBIS:1]; DefInLay; DefOutLay; MainTitle; $Width_L; $Height_L; 1; 8; ->[Bridge MHD NBIS:1]BDEPT:1; ">"; ->[Bridge MHD NBIS:1]InspResp:173; ->CurInsp)
