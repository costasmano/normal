//%attributes = {"invisible":true}
//procedure: ControlMenuBar
//purpose: change the menu bar depending on access rights
//$1 : normal parameter for menu bar, the menu bar number  
If (False:C215)
	//by: Albert Leung
	//date: August 6, 1997
	
	// Modified by: costasmanousakis-(Designer)-(12/1/2005 10:57:51)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/5/2005 10:59:44)
	Mods_2005_CM19
	// Modified by: ManousakisC (2/14/2006)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(8/13/2007 16:01:42)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(1/17/08 12:13:27)
	Mods_2007_CM_5401
	//  `Give access to the Data menu to members of Inspection Admin only
	// Modified by: costasmanousakis-(Designer)-(10/7/08 12:18:41)
	Mods_2008_CM_5404  //("ACCESS")
	// Modified by: costasmanousakis-(Designer)-(11/1/09 12:23:22)
	Mods_2009_10("MASSDOT")
	//  `Change text on enter menu, to indicate Insp. by
	// Modified by: costasmanousakis-(Designer)-(1/11/10 12:13:31)
	Mods_2010_01
	//  `Replaced Current User with text variable $CurrentUser_txt
	// Modified by: costasmanousakis-(Designer)-(2/12/10 16:12:48)
	Mods_2010_02
	//  `Change code to allow users assigned to multiple districts access to them
	// Modified by: costasmanousakis-(Designer)-(3/3/10 07:55:47)
	Mods_2010_03
	//  `for all users enable the "@ 6" menu item in the enter menu - for the District 6 menu item
	// Modified by: costasmanousakis-(Designer)-(5/28/10 )
	Mods_2010_05
	//  `Modified for the new menu item District Maintenance Contracts
	// Modified by: costasmanousakis-(Designer)-(8/6/10 09:59:46)
	Mods_2010_08
	//  `Changed the access to District 6 item to be same as other distrcts
	// Modified by: costasmanousakis-(Designer)-(11/29/10 14:09:58)
	Mods_2010_11
	//  `change CMD-S to 4D Query instead of EZSearch for Designer
	// Modified by: costasmanousakis-(Designer)-(12/2/10 14:48:02)
	Mods_2010_12
	//  `Added enabling of new menu item (set ITEM 75) in the data menu for menu bar 2
	// Modified by: costasmanousakis-(Designer)-(1/11/11 16:32:02)
	Mods_2011_01
	//`MenuNumber fix for v11 transition use new methods MENU_GetMenuByName, MENU_MenuItemUtil
	// Modified by: costasmanousakis-(Designer)-(5/19/11 17:47:18)
	Mods_2011_05
	//  `changes for scourpoa review and disabling some import items under the File menu
	//  `Also control the display of the window Palette from the tools menu
	// Modified by: Costas Manousakis-(Designer)-(10/17/13 14:25:39)
	Mods_2013_10
	//  `Added code for the Preservation Assignments item in the Special menu
	// Modified by: Costas Manousakis-(Designer)-(6/20/16 14:29:27)
	Mods_2016_06
	//  `disable transfer menu items when not applicable it menu bars 1 and 2
	//  `add cases for "Tunnel Information" item in the "Enter" menu
	// Modified by: Costas Manousakis-(Designer)-(10/26/16 00:41:50)
	Mods_2016_10
	//  `enable preferences for external users
	// Modified by: Costas Manousakis-(Designer)-(1/30/17 12:20:49)
	Mods_2017_01
	//  `added  TunnelInformation to MPA
	// Modified by: Costas Manousakis-(Designer)-(4/10/17 17:01:23)
	Mods_2017_04
	//  `Enable for designer Search by NBEs in menu #2 /Records
	Mods_2019_09  //Add new menu option to copy BIN request It replaces button on form
	//Modified by: Chuck Miller (9/24/19 13:54:41)
	// Modified by: Costas Manousakis-(Designer)-(4/1/20 09:21:23)
	Mods_2020_04
	//  `added new item in Special menu of Bridgelistmenu to load SU EV loads
	// Modified by: Costas Manousakis-(Designer)-(8/10/20 12:37:58)
	Mods_2020_08
	//  `for Work hours added pers_groups WKHR_Consultants, WKHR_Reviewers
	//  `and for district maintenance contracts , group DistrictMaintenance.
	// Modified by: Costas Manousakis-(Designer)-(2022-05-24 12:41:13)
	Mods_2022_05
	//  `Added menu item to "Reports" menu after the "Quick Reports..." item
	// Modified by: Costas Manousakis-(Designer)-(2023-03-29 12:41:33)
	Mods_2023_03
	//  `Window palette menu item is enabled for all users.
End if 

C_LONGINT:C283($mno; $1)  //Command Replaced was o_C_INTEGER

$mno:=$1

C_TEXT:C284($CurrentUser_txt)
$CurrentUser_txt:=Current user:C182
If (Not:C34(<>fQuit))  //don't bother if we're quiting
	C_LONGINT:C283($Nummenuitems2_L; $i)
	SET MENU BAR:C67($mno)
	C_LONGINT:C283(MNU_ENTERMENU_NO_L; MNU_Special_NO_L)
	MNU_ENTERMENU_NO_L:=MENU_GetMenuByName("ENTER")
	MNU_Special_NO_L:=MENU_GetMenuByName("Special")
	If (($mno=1) | ($mno=2))
		C_LONGINT:C283($Nummenuitems2_L; $i)
		$Nummenuitems2_L:=Count menu items:C405(MNU_ENTERMENU_NO_L)
		ARRAY TEXT:C222(Menu2Items_atxt; $Nummenuitems2_L)
		For ($i; 1; $Nummenuitems2_L)
			Menu2Items_atxt{$i}:=Get menu item:C422(MNU_ENTERMENU_NO_L; $i)
		End for 
		If (User in group:C338($CurrentUser_txt; "Access Level 1"))
			If (User in group:C338($CurrentUser_txt; "District 1"))
				MENU_EnableEnterItem("District 1")
			End if 
			If (User in group:C338($CurrentUser_txt; "District 2"))
				MENU_EnableEnterItem("District 2")
			End if 
			If (User in group:C338($CurrentUser_txt; "District 3"))
				MENU_EnableEnterItem("District 3")
			End if 
			If (User in group:C338($CurrentUser_txt; "District 4"))
				MENU_EnableEnterItem("District 4")
			End if 
			If (User in group:C338($CurrentUser_txt; "District 5"))
				MENU_EnableEnterItem("District 5")
			End if 
			If (User in group:C338($CurrentUser_txt; "District 6"))
				MENU_EnableEnterItem("District 6")
				MENU_EnableEnterItem("Tunnel Information")
			End if 
			If (User in group:C338($CurrentUser_txt; "MTA"))
				MENU_EnableEnterItem("MTA")
			End if 
			If (User in group:C338($CurrentUser_txt; "MDC"))
				MENU_EnableEnterItem("DCR")
			End if 
			If (User in group:C338($CurrentUser_txt; "MBTA"))
				MENU_EnableEnterItem("MBTA")
			End if 
			If (User in group:C338($CurrentUser_txt; "MassPort"))
				MENU_EnableEnterItem("MassPort")
				MENU_EnableEnterItem("Tunnel Information")
			End if 
			
			If (User in group:C338($CurrentUser_txt; "DiveGroup"))
				MENU_EnableEnterItem("District 1")
				MENU_EnableEnterItem("District 2")
				MENU_EnableEnterItem("District 3")
				MENU_EnableEnterItem("District 4")
				MENU_EnableEnterItem("District 5")
				MENU_EnableEnterItem("District 6")
				MENU_EnableEnterItem("MTA")
				MENU_EnableEnterItem("DCR")
				MENU_EnableEnterItem("MBTA")
				MENU_EnableEnterItem("MassPort")
				MENU_EnableEnterItem("Other agencies…")
				MENU_EnableEnterItem("All records")
				//MENU_MenuItemUtil ("ENABLE";"Tools";"Window Palette")
				
			End if 
		Else 
			MENU_EnableEnterItem("District 1")
			MENU_EnableEnterItem("District 2")
			MENU_EnableEnterItem("District 3")
			MENU_EnableEnterItem("District 4")
			MENU_EnableEnterItem("District 5")
			MENU_EnableEnterItem("District 6")
			MENU_EnableEnterItem("MTA")
			MENU_EnableEnterItem("DCR")
			MENU_EnableEnterItem("MBTA")
			MENU_EnableEnterItem("MassPort")
			MENU_EnableEnterItem("Other agencies…")
			MENU_EnableEnterItem("All records")
			MENU_EnableEnterItem("Tunnel Information")
			
			If (User in group:C338($CurrentUser_txt; "Personnel Admin"))
				MENU_EnableEnterItem("Personnel")
			End if 
			//If ($mno=1)
			//MENU_MenuItemUtil ("ENABLE";"Tools";"Window Palette")  //Turn on the file palette
			//End if 
			If ((User in group:C338($CurrentUser_txt; "ExternalInspectors") | User in group:C338($CurrentUser_txt; "ExternalDesigners")) & Not:C34(User in group:C338($CurrentUser_txt; "Design Access Group")))
				C_LONGINT:C283($vinumitems; $i; $FileMenu_L)
				$FileMenu_L:=MENU_GetMenuByName("File")
				$vinumitems:=Count menu items:C405($FileMenu_L)-1
				For ($i; 1; $vinumitems)
					DISABLE MENU ITEM:C150($FileMenu_L; $i)  //All of File menu except the last one=QUIT
				End for 
				MENU_MenuItemUtil("ENABLE"; "File"; "Preferences@")  //Delete scour report item in Reports menu
				
				Case of 
					: ($mno=1)
						MENU_ClearMenu(MENU_GetMenuByName("Reports"))  //All of Reports menu
						$vinumitems:=Count menu items:C405(MNU_Special_NO_L)  //Special Menu
						For ($i; $vinumitems; 1; -1)
							Case of 
								: (Get menu item:C422(MNU_Special_NO_L; $i)="Review Pending Inspections")
									If (Not:C34(User in group:C338($CurrentUser_txt; "ExternalInspectors")))
										DISABLE MENU ITEM:C150(MNU_Special_NO_L; $i)
									End if 
									
								: (Get menu item:C422(MNU_Special_NO_L; $i)="Review Work Hour Estimates")
									SET MENU ITEM:C348(MNU_Special_NO_L; $i; "Submit Work Hour Estimate")
									If (Not:C34(User in group:C338($CurrentUser_txt; "ExternalDesigners")))
										DISABLE MENU ITEM:C150(MNU_Special_NO_L; $i)
									End if 
									
								: ($i=1)
									If ($CurrentUser_txt="BMSExternal Server")
									Else 
										DISABLE MENU ITEM:C150(MNU_Special_NO_L; $i)
									End if 
								Else 
									DISABLE MENU ITEM:C150(MNU_Special_NO_L; $i)  //All of Special menu-except Review Inspections
							End case 
						End for 
						MENU_ClearMenu(MENU_GetMenuByName("Data"))  //All of Data menu
						
					: ($mno=2)
						MENU_ClearMenu(MENU_GetMenuByName("Reports"))  //All of Reports menu
						MENU_ClearMenu(MENU_GetMenuByName("Data"))  //All of Data menu
						MENU_ClearMenu(MNU_Special_NO_L)  //All of Special menu
				End case 
			End if   //if ExternalInspector
			
		End if 
		C_TEXT:C284($menuitem_txt)
		For ($i; 1; $Nummenuitems2_L)
			
			Case of 
				: (Menu2Items_atxt{$i}="District @")
					SET MENU ITEM:C348(MNU_ENTERMENU_NO_L; $i; "Insp. by "+Menu2Items_atxt{$i})
				: ((Menu2Items_atxt{$i}="MTA") | (Menu2Items_atxt{$i}="DCR") | (Menu2Items_atxt{$i}="MBTA") | (Menu2Items_atxt{$i}="MassPort"))
					SET MENU ITEM:C348(MNU_ENTERMENU_NO_L; $i; "Insp. by "+Menu2Items_atxt{$i})
			End case 
			
		End for 
		
	End if 
	Case of 
		: ($mno=1)
			If (Application type:C494=4D Remote mode:K5:5)
				MENU_MenuItemUtil("ENABLE"; "Tools"; "Make Key")  //enable the make key function for 4D client
				If (Not:C34(User in group:C338($CurrentUser_txt; "Inspection Admin")))
					MENU_ClearMenu(MENU_GetMenuByName("Data"))  //Data menu
					MENU_MenuItemUtil("DELETE"; "Reports"; "Scour@")  //Delete scour report item in Reports menu
				End if 
			End if 
			C_BOOLEAN:C305($ConsContrAcc_b)
			$ConsContrAcc_b:=(User in group:C338(Current user:C182; "Design Access Group"))
			$ConsContrAcc_b:=$ConsContrAcc_b | (GRP_UserInGroup("WKHR_Consultants")=1)
			$ConsContrAcc_b:=$ConsContrAcc_b | (GRP_UserInGroup("WKHR_Reviewers")=1)
			//$ConsContrAcc_b:=User in group($CurrentUser_txt;"ExternalInspectors")
			//$ConsContrAcc_b:=$ConsContrAcc_b | User in group($CurrentUser_txt;"ExternalDesigners")
			//$ConsContrAcc_b:=$ConsContrAcc_b | User in group($CurrentUser_txt;"BridgeMaintenance")
			//$ConsContrAcc_b:=$ConsContrAcc_b | ($CurrentUser_txt="Designer")
			If ($ConsContrAcc_b)
			Else 
				MENU_MenuItemUtil("DISABLE"; "Special"; "Review Work Hour Estimates")
				MENU_MenuItemUtil("DISABLE"; "Special"; "Consultant Contract Maintenance")
			End if 
			If ((GRP_UserInGroup("DistrictMaintenance")=1) | User in group:C338($CurrentUser_txt; "Design Access Group"))
				MENU_MenuItemUtil("ENABLE"; "Special"; "District Maintenance Contracts")
			End if 
			If ((GRP_UserInGroup("SCPOA_Proj@")=1) | (GRP_UserInGroup("SCPOA_App@")=1) | User in group:C338($CurrentUser_txt; "Design Access Group"))
			Else 
				MENU_MenuItemUtil("DISABLE"; "Special"; "Review Scour POA")
			End if 
			If (User in group:C338($CurrentUser_txt; "Design Access Group"))
				If (Application type:C494=4D Remote mode:K5:5)
					MENU_MenuItemUtil("DISABLE"; "File"; "MSC")
				End if 
			Else 
				MENU_MenuItemUtil("DISABLE"; "File"; "Import Pontis Data")
				MENU_MenuItemUtil("DISABLE"; "File"; "Update Project Data ODBC")
				MENU_MenuItemUtil("DISABLE"; "File"; "Update Design Contract Amounts")
				MENU_MenuItemUtil("DISABLE"; "File"; "Update Const Cont Amounts")
				MENU_MenuItemUtil("DISABLE"; "File"; "MSC")
				MENU_MenuItemUtil("DISABLE"; "File"; "Fill From DC")
				MENU_MenuItemUtil("DISABLE"; "File"; "Fill Empty Data File")
			End if 
			C_BOOLEAN:C305($PreservAssignAccess_b)
			$PreservAssignAccess_b:=(GRP_UserInGroup("PreservationEdit")=1)
			$PreservAssignAccess_b:=$PreservAssignAccess_b | (GRP_UserInGroup("PreservationRO")=1)
			$PreservAssignAccess_b:=$PreservAssignAccess_b | (User in group:C338(Current user:C182; "Design Access Group"))
			If ($PreservAssignAccess_b)
			Else 
				MENU_MenuItemUtil("DISABLE"; "Special"; "Preservation@")
			End if 
			C_BOOLEAN:C305($AllowTransfer_b)
			$AllowTransfer_b:=(<>Transfer#-1)
			$AllowTransfer_b:=$AllowTransfer_b & (Not:C34(<>LockUserTx) | (<>LockUserTx & (<>TxUserName=Current user:C182)))
			If ($AllowTransfer_b)
				
			Else 
				MENU_MenuItemUtil("DISABLE"; "Special"; "Execute Transfer")
				MENU_MenuItemUtil("DISABLE"; "Special"; "Download Data")
			End if 
		: ($mno=2)
			//If (User in group($CurrentUser_txt;"Access Level 1"))
			//If ((User in group($CurrentUser_txt;"DiveGroup")))
			//MENU_MenuItemUtil ("ENABLE";"Tools";"Window Palette")
			//Else 
			//MENU_MenuItemUtil ("DISABLE";"Tools";"Window Palette")
			//End if 
			//End if 
			If (Not:C34(User in group:C338($CurrentUser_txt; "Inspection Admin")))
				MENU_ClearMenu(MENU_GetMenuByName("Data"))  //Data menu
			End if 
			If ($CurrentUser_txt="Designer")
				MENU_MenuItemUtil("SETKEY"; "Records"; ("Search"+Char:C90(201)); "S")
				MENU_MenuItemUtil("SETKEY"; "Records"; "Easy Search"; Char:C90(0))
				MENU_MenuItemUtil("ENABLE"; "Data"; "Update Item 75 coding")
				MENU_MenuItemUtil("ENABLE"; "Records"; "Search by NBEs")
			End if 
			C_LONGINT:C283($ReportsMenu; $QRReport_)
			$ReportsMenu:=MENU_GetMenuByName("Reports")
			$QRReport_:=MENU_GetMenuItemByName($ReportsMenu; "Quick Report@")
			INSERT MENU ITEM:C412($ReportsMenu; $QRReport_; "Run a Quick Report to Excel")
			SET MENU ITEM METHOD:C982($ReportsMenu; -1; "QR_RunReportToExcel")
			
			If (User in group:C338($CurrentUser_txt; "Design Access Group"))
			Else 
				MENU_MenuItemUtil("DISABLE"; "File"; "Import Pontis Data")
			End if 
			C_BOOLEAN:C305($AllowTransfer_b)
			$AllowTransfer_b:=(<>Transfer#-1)
			$AllowTransfer_b:=$AllowTransfer_b & (Not:C34(<>LockUserTx) | (<>LockUserTx & (<>TxUserName=Current user:C182)))
			If ($AllowTransfer_b)
				
			Else 
				MENU_MenuItemUtil("DISABLE"; "Special"; "Execute Transfer")
			End if 
			Case of 
				: (User in group:C338($CurrentUser_txt; "Design Access Group"))
				: ($CurrentUser_txt="Designer")
				: (GRP_UserInGroup("BINRequestCopy")=1)
				Else 
					MENU_MenuItemUtil("DISABLE"; "Special"; "Copy BIN Request")
			End case 
			
			Case of 
				: (User in group:C338($CurrentUser_txt; "Design Access Group"))
				: ($CurrentUser_txt="Designer")
				: (GRP_UserInGroup("LoadSUEVRatings")=1)
				Else 
					MENU_MenuItemUtil("DISABLE"; "Special"; "Load SU / EV rating loads")
			End case 
			
	End case 
	
End if 