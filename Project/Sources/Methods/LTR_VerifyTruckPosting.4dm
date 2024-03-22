//%attributes = {"invisible":true}
// Method: LTR_VerifyTruckPosting
// Description
// verify the truck postings to be used in a letter
// 
// Parameters
// $0 : $Verified_b (Boolean)
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/17/07, 18:38:55
	// ----------------------------------------------------
	// ----------------------------------------------------
	
	Mods_2007_CM07
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(10/23/18 10:12:19)
	Mods_2018_10
	//  `changes for addition of field [Bridge MHD NBIS]PostingSingle
End if 
C_BOOLEAN:C305($0; $Verified_b)
C_TEXT:C284(TRUCK_Post_1_txt; TRUCK_Post_2_txt; TRUCK_Post_3_txt; TRUCK_Post_4_txt)
TRUCK_Post_1_txt:=String:C10([Bridge MHD NBIS:1]Posting2Axle:9; "####;;")
TRUCK_Post_2_txt:=String:C10([Bridge MHD NBIS:1]Posting3Axle:10; "####;;")
TRUCK_Post_3_txt:=String:C10([Bridge MHD NBIS:1]Posting5Axle:11; "####;;")

If ([Bridge MHD NBIS:1]PostingSingle:231>0)
	TRUCK_Post_4_txt:=String:C10([Bridge MHD NBIS:1]PostingSingle:231; "####;;")
	TRUCK_Post_1_txt:=""
	TRUCK_Post_2_txt:=""
	TRUCK_Post_3_txt:=""
Else 
	If ((TRUCK_Post_1_txt=TRUCK_Post_3_txt) & (TRUCK_Post_1_txt=TRUCK_Post_2_txt))
		TRUCK_Post_4_txt:=TRUCK_Post_1_txt
		TRUCK_Post_1_txt:=""
		TRUCK_Post_2_txt:=""
		TRUCK_Post_3_txt:=""
	Else 
		TRUCK_Post_4_txt:=""
	End if 
	
End if 

C_LONGINT:C283($DWid_L; $DHt_L)
FORM GET PROPERTIES:C674([Dialogs:21]; "TruckPosting"; $DWid_L; $DHt_L)
CENTER_WINDOW($DWid_L; $DHt_L; Movable dialog box:K34:7)
DIALOG:C40([Dialogs:21]; "TruckPosting")
CLOSE WINDOW:C154
$Verified_b:=(OK=1)
$0:=$Verified_b