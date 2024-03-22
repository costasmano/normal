//%attributes = {"invisible":true}
If (False:C215)
	//GP P_MDC
	//Copyright © 1995-1997,  Albert S. Leung, Thomas D. Nee, All Rights Reserved.
	//Load data for MDC Bridge inspection
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(12/7/2005 16:10:55)
	Mods_2005_CM20
	// Modified by: costasmanousakis-(Designer)-(4/16/08 09:30:54)
	Mods_2008_CM_5403  //Added to include DEM bridges
	// Modified by: costasmanousakis-(Designer)-(11/30/09 12:31:56)
	Mods_2009_11
	//Search for legacy owner too
	Mods_2011_03  //Change width of form from 620 to 830
	// Modified by: Costas Manousakis-(Designer)-(3/4/14 10:04:31)
	Mods_2014_03
	//  `Removed the search for Legacy Owner and Other Owner
	Mods_2019_07  //Create new list box NewNBIS_StackInfoform to test as width and height changed
	//Modified by: Chuck Miller (7/18/19 12:51:34)
	
End if 
InitProcessVar
C_LONGINT:C283($Width_L; $Height_L)
C_LONGINT:C283($FW; $FL)
FORM GET PROPERTIES:C674([Bridge MHD NBIS:1]; DefOutLay; $FW; $FL)

$Width_L:=$FW
$Height_L:=600

MainTitle:="Department of Conservation and Recreation"
C_TEXT:C284(OtherOwner; LegacyOwner)
CurInsp:="MDC"
//OtherOwner:="DEM"
//LegacyOwner:="MDC"

C_POINTER:C301($Tbl_ptr; $SortFld_ptr; $Fld1_ptr; $Fld2_ptr; $val1_ptr; $val2_ptr; $Fld3_ptr; $val3_ptr)
$Tbl_ptr:=->[Bridge MHD NBIS:1]
$SortFld_ptr:=->[Bridge MHD NBIS:1]BDEPT:1
$Fld1_ptr:=->[Bridge MHD NBIS:1]InspResp:173
//$Fld2_ptr:=->[Bridge MHD NBIS]Item8 Owner
//$Fld3_ptr:=->[Bridge MHD NBIS]LegacyOwner

$val1_ptr:=->CurInsp
//$val2_ptr:=->OtherOwner
//$val3_ptr:=->LegacyOwner
//ModSelSort (->[Bridge MHD NBIS];DefInLay;DefOutLay;MainTitle;620;456;1;8;->[Bridge MHD NBIS]BDEPT;">";->[Bridge MHD NBIS]InspResp;->CurInsp)

//ModSelSort ($Tbl_ptr;DefInLay;DefOutLay;MainTitle;830;456;1;8;$SortFld_ptr;">";$Fld1_ptr;$val1_ptr;$Fld2_ptr;$val2_ptr;$Fld3_ptr;$val3_ptr)
ModSelSort($Tbl_ptr; DefInLay; DefOutLay; MainTitle; $Width_L; $Height_L; 1; 8; $SortFld_ptr; ">"; $Fld1_ptr; $val1_ptr)
