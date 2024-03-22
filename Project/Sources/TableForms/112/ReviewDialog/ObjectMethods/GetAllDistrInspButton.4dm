If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/12/07, 10:08:50
	// ----------------------------------------------------
	// Method: Object Method: GetAllDistrInsp
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM06
	// Modified by: costasmanousakis-(Designer)-(12/20/07 08:50:16)
	Mods_2007_CM_5401
	//  `Use var ◊CurrentUser_UID
End if 

C_LONGINT:C283($MyID_I; $Distr_no_I)  //Command Replaced was o_C_INTEGER
If (User in group:C338(Current user:C182; "Inspection Engineers"))
	//Find the current district by getting the distr of current user
	READ ONLY:C145([Personnel:42])
	$MyID_I:=<>CurrentUser_UID
	QUERY:C277([Personnel:42]; [Personnel:42]UserID_4D:12=$MyID_I)
	If (Records in selection:C76([Personnel:42])=1)
		$Distr_no_I:=Num:C11(Substring:C12([Personnel:42]Division No:7; 4))
		If (($Distr_no_I>0) & ($Distr_no_I<6))
			QUERY:C277([InventoryPhotoInsp:112]; [Bridge MHD NBIS:1]InspResp:173=("DIST"+String:C10($Distr_no_I)))
			INV_DisplayInvInspections(True:C214)
			INV_ReDoSort
			REDRAW WINDOW:C456
			RegionTitle
		Else 
			ALERT:C41("You do not have a District assigned to you in the Personnel Table!")
		End if 
	Else 
		ALERT:C41("You do not have a correctly linked record in the Personnel Table!")
	End if 
Else 
	ALERT:C41("You're not a DBIE!!!!")
End if 