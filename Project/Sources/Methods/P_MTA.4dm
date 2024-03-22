//%attributes = {"invisible":true}
If (False:C215)
	//GP P_MTA
	//Copyright © 1995-1997,  Albert S. Leung, Thomas D. Nee, All Rights Reserved.
	//Load data for MTA Bridge inspection
	// Modified by: costasmanousakis-(Designer)-(12/7/2005 16:10:55)
	Mods_2005_CM20
	// Modified by: costasmanousakis-(Designer)-(2/5/10 16:15:17)
	Mods_2010_02
	//Allow switching of inspection responsibility to districts, and letting MTA users get to the bridges.
	Mods_2011_03  //Change width of form from 620 to 830
	Mods_2019_07  //Create new list box NewNBIS_StackInfoform to test as width and height changed
	//Modified by: Chuck Miller (7/18/19 12:51:34)
	
End if 
InitProcessVar
C_LONGINT:C283($Width_L; $Height_L)
C_LONGINT:C283($FW; $FL)
FORM GET PROPERTIES:C674([Bridge MHD NBIS:1]; DefOutLay; $FW; $FL)

$Width_L:=$FW
$Height_L:=600

MainTitle:="Massachusetts Turnpike Authority Inspection"
C_TEXT:C284(OtherOwner; LegacyOwner)
CurInsp:="MTA"
LegacyOwner:="MTA"

C_POINTER:C301($Tbl_ptr; $SortFld_ptr; $Fld1_ptr; $Fld2_ptr; $val1_ptr; $val2_ptr; $Fld3_ptr; $val3_ptr)
$Tbl_ptr:=->[Bridge MHD NBIS:1]
$SortFld_ptr:=->[Bridge MHD NBIS:1]BDEPT:1
$Fld1_ptr:=->[Bridge MHD NBIS:1]InspResp:173
$Fld2_ptr:=->[Bridge MHD NBIS:1]LegacyOwner:226

$val1_ptr:=->CurInsp
$val2_ptr:=->LegacyOwner
//ModSelSort (->[Bridge MHD NBIS];DefInLay;DefOutLay;MainTitle;620;456;1;8;->[Bridge MHD NBIS]BDEPT;">";->[Bridge MHD NBIS]InspResp;->CurInsp)

ModSelSort($Tbl_ptr; DefInLay; DefOutLay; MainTitle; $Width_L; $Height_L; 1; 8; $SortFld_ptr; ">"; $Fld1_ptr; $val1_ptr; $Fld2_ptr; $val2_ptr)
