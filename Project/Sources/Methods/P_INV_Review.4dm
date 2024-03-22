//%attributes = {"invisible":true}
// Method: P_INV_Review 
// Description
// Run the inventory photos review window
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/13/06, 14:50:25
	// ----------------------------------------------------
	
	Mods_2007_CM02
	// Modified by: Costas Manousakis-(Designer)-(2/13/12 13:46:02)
	Mods_2012_02
	//  `Use similar logic to find the pending inv inspections as in the regular inspection review
	// Modified by: Costas Manousakis-(Designer)-(7/10/20 12:38:08)
	Mods_2020_07
	//  `Added Initializing review message
End if 
C_BOOLEAN:C305(InDoubleClick_B)
C_TEXT:C284(MainTitle)  // Command Replaced was o_C_STRING length was 255
MainTitle:="Pending Inventory Photo Insp"
InitProcessVar
SHORT_MESSAGE("Initializing Inventory Photo Review ...")
C_POINTER:C301(pFile)
pFile:=->[InventoryPhotoInsp:112]
C_LONGINT:C283(<>CurrentUser_PID)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($IAmDBIE_b)
$IAmDBIE_b:=False:C215
C_TEXT:C284($MyDistr_s)  // Command Replaced was o_C_STRING length was 1
$MyDistr_s:=""
READ ONLY:C145([Personnel:42])
QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=<>CurrentUser_PID)
If (Records in selection:C76([Personnel:42])=1)
	$IAmDBIE_b:=([Personnel:42]Job Code:8=1)
	$MyDistr_s:=Substring:C12([Personnel:42]Division No:7; 4)
End if 
INSP_InspReviewControl
QUERY:C277([InventoryPhotoInsp:112]; [InventoryPhotoInsp:112]Approved_I:6#BMS Approved)
CREATE SET:C116([InventoryPhotoInsp:112]; "AllPendingPhotoSet")
If (Current user:C182#"Designer")
	
	QUERY SELECTION:C341([InventoryPhotoInsp:112]; [InventoryPhotoInsp:112]TeamLeader_I:5=<>CurrentUser_PID; *)
	QUERY SELECTION:C341([InventoryPhotoInsp:112];  | ; [InventoryPhotoInsp:112]TeamMember_I:10=<>CurrentUser_PID)
	//If ($IAmDBIE_b)
	//QUERY SELECTION([InventoryPhotoInsp];[Bridge MHD NBIS]InspResp=("DIST"+$MyDistr_s))
	If (Size of array:C274(<>INSP_MyDistricts_atxt)>0)
		CREATE SET:C116([InventoryPhotoInsp:112]; "StartInvPhotoSet")
		USE SET:C118("AllPendingPhotoSet")
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		SET QUERY DESTINATION:C396(Into set:K19:2; "MYDISTRICTSINSPECTS")
		QUERY SELECTION:C341([InventoryPhotoInsp:112]; [Bridge MHD NBIS:1]InspResp:173=<>INSP_MyDistricts_atxt{1}; *)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 2; Size of array:C274(<>INSP_MyDistricts_atxt))
			QUERY SELECTION:C341([InventoryPhotoInsp:112];  | ; [Bridge MHD NBIS:1]InspResp:173=<>INSP_MyDistricts_atxt{$loop_L}; *)
		End for 
		QUERY SELECTION:C341([InventoryPhotoInsp:112])
		//CREATE SET([InventoryPhotoInsp];"DistrInvPhotoSet")
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		UNION:C120("MYDISTRICTSINSPECTS"; "StartInvPhotoSet"; "AllPendingPhotoSet")
		CLEAR SET:C117("StartInvPhotoSet")
		CLEAR SET:C117("MYDISTRICTSINSPECTS")
	Else 
		CREATE SET:C116([InventoryPhotoInsp:112]; "AllPendingPhotoSet")
		
	End if 
	
	//Else 
	//End if 
	
End if 
USE SET:C118("AllPendingPhotoSet")
CLEAR SET:C117("AllPendingPhotoSet")

ORDER BY:C49([InventoryPhotoInsp:112]; [InventoryPhotoInsp:112]InvPhotoDate_D:3; <)
C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 10//Mar-2003:added for correctness
$RecSel:=String:C10(Records in selection:C76([InventoryPhotoInsp:112]))
COPY NAMED SELECTION:C331([InventoryPhotoInsp:112]; "UserRegionA")  //save the selection
INV_DisplayInvInspections(True:C214)
CLOSE WINDOW:C154
C_LONGINT:C283($widthO; $htO; $widthI; $htI; $width; $ht)
FORM GET PROPERTIES:C674([InventoryPhotoInsp:112]; "ReviewDialog"; $widthO; $htO)
FORM GET PROPERTIES:C674([InventoryPhotoInsp:112]; "Input"; $widthI; $htI)
$width:=MaxNum($widthO; $widthI)
$ht:=MaxNum($htO; $htI)
NewWindow($width; $ht; 1; Plain window:K34:13)
UpdatWindArray(""; Current process:C322)
SET WINDOW TITLE:C213(MainTitle+" ["+$RecSel+"]")
SET MENU BAR:C67(3)
DIALOG:C40([InventoryPhotoInsp:112]; "ReviewDialog")
CLEAR NAMED SELECTION:C333("UserRegionA")
UpdatWindArray(""; Current process:C322)
CLOSE WINDOW:C154