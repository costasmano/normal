//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/17/07, 19:55:37
	// ----------------------------------------------------
	// Method: LTR_VerifyVertCL
	// Description
	// Verify the vertical clearance value
	// 
	// Parameters
	// $0 : $Verified_b (Boolean)
	// ----------------------------------------------------
	
	Mods_2007_CM07
End if 
C_BOOLEAN:C305($0; $Verified_b)
C_TEXT:C284(VERTCL_Feet_txt; VERTCL_Inches_txt; VERTCL_B1_txt; VERTCL_B2_txt; VERTCL_B3_txt; VERTCL_B4_txt; VERTCL_B5_txt)
C_TEXT:C284(VERTCL_A1_txt; VERTCL_A2_txt; VERTCL_A3_txt; VERTCL_A4_txt; VERTCL_A5_txt)
C_TEXT:C284(VERTCL_1_txt; VERTCL_2_txt)
C_REAL:C285(VERTCL_Itm54_r; VERTCL_Itm53_r)
C_LONGINT:C283(VERTCL_Use54_rb; VERTCL_Use53_rb)
C_BOOLEAN:C305(VERTCL_Use54_b)
VERTCL_Feet_txt:="???"
VERTCL_Inches_txt:="??"
VERTCL_1_txt:="?"
VERTCL_2_txt:="?"
VERTCL_B1_txt:="?"
VERTCL_B2_txt:="?"
VERTCL_B3_txt:="?"
VERTCL_B4_txt:="?"
VERTCL_B5_txt:="?"
VERTCL_A1_txt:="?"
VERTCL_A2_txt:="?"
VERTCL_A3_txt:="?"
VERTCL_A4_txt:="?"
VERTCL_A5_txt:="?"
C_REAL:C285($ClearanceMet_r; $ClearanceFT_r; $ClearanceIN_r)
VERTCL_Itm54_r:=[Bridge MHD NBIS:1]Item54B:108
VERTCL_Itm53_r:=[Bridge MHD NBIS:1]Item53:105
If ([Bridge MHD NBIS:1]Item54A:107="H")  //Roadway under
	$ClearanceMet_r:=[Bridge MHD NBIS:1]Item54B:108
	VERTCL_Use54_b:=True:C214
Else 
	$ClearanceMet_r:=[Bridge MHD NBIS:1]Item53:105
	VERTCL_Use54_b:=False:C215
End if 
LTR_GetVertCLtoFTIN($ClearanceMet_r)
C_LONGINT:C283($DWid_L; $DHt_L)
FORM GET PROPERTIES:C674([Dialogs:21]; "VertCLR_Sign"; $DWid_L; $DHt_L)
CENTER_WINDOW($DWid_L; $DHt_L; Movable dialog box:K34:7)
DIALOG:C40([Dialogs:21]; "VertCLR_Sign")
CLOSE WINDOW:C154
$Verified_b:=(OK=1)
$0:=$Verified_b
