//%attributes = {"invisible":true}
// Method: SIA_BridgeInput_FM
// Description
//  ` Method for the [Bridge MHD NBIS];"Bridge Input" form
// 
// Parameters
// $1 : $FormEvent_L (Optional)
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/15/10, 11:30:43
	// ----------------------------------------------------
	
	Mods_2010_02
	// Modified by: costasmanousakis-(Administrator)-(4/5/10 12:36:40)
	Mods_2010_04
	//  `Added Variable $currUser_txt; Also allow users in BMS Admin to override the MDC restrictions 
	// Modified by: costasmanousakis-(Designer)-(9/2/10 15:47:54)
	Mods_2010_09
	//  `Use method BMSUtil_BelongToBridge for MDC users
	// Modified by: costasmanousakis-(Designer)-(1/18/11 15:22:49)
	Mods_2011_01
	//` Rail Road changes
	// Modified by: costasmanousakis-(Designer)-(6/6/11 14:18:28)
	Mods_2011_06
	//  `After the On Load release any other records loaded during the load event
	// Modified by: Costas Manousakis-(Designer)-(5/9/12 11:04:06)
	Mods_2012_05
	//  `Changed method of adjusting window size. Now the size is adjusted in the on  load form method of the input form.
	//  `sized back to the original in the close detail of this form. keep track by setting a variable in the On Open Detail of the 
	//  `Output form
	Mods_2013_02  //r001 ` Add [ScourCriticalInfo] to maintain new table records
	//Modified by: Charles Miller (2/12/13 13:16:23)
	Mods_2013_03  //r001 ` Add code to display correct headings on forms based upon [Bridge MHD NBIS]InspResp
	//Modified by: Charles Miller (3/12/13 11:55:46)
	// Modified by: Costas Manousakis-(Designer)-(3/18/13 14:00:22)
	Mods_2013_03
	//  `Added code to enable MBTA users access to Rail Info button
	// Modified by: Costas Manousakis-(Designer)-(5/16/13 10:19:01)
	Mods_2013_05
	//  `Added cases for Tunnel  records
	// Modified by: Costas Manousakis-(Designer)-(10/21/13 10:19:23)
	Mods_2013_10
	//  `Include BLD records for Tunnels
	// Modified by: Costas Manousakis-(Designer)-(10/28/13 10:00:07)
	Mods_2013_10
	//  `Allow Ext designers and inspectors access to the SIA button 
	// Modified by: Costas Manousakis-(Designer)-(11/6/13 16:22:47)
	Mods_2013_11
	//  `Fixed bug in hiding the ScourCritical button when there is a record in the table
	// Modified by: Costas Manousakis-(Designer)-(2/27/14 17:29:55)
	Mods_2014_02
	//  `Added call to SET MENU BAR("BLANKMENU") to avoid  actions from Quick report where the selection is chaanged
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
	// Modified by: Costas Manousakis-(Designer)-(2/22/19 17:18:17)
	Mods_2019_02_bug
	//  `for Rail/Transit SIA (page=9) use case for insp Resp to account also for DOTRT 
	// Modified by: Costas Manousakis-(Designer)-(6/17/19 16:20:32)
	Mods_2019_06
	//  `Enabled on Resize event on the [Bridge MHD NBIS];"Bridge Input" form and added code to redraw any listboxes on the current page
	Mods_2019_07  //Create new list box NewNBIS_StackInfoform to test as width and height changed
	//Modified by: Chuck Miller (7/18/19 12:51:34)
	// Modified by: Costas Manousakis-(Designer)-(11/8/19 11:43:58)
	Mods_2019_11
	//  `account for form resizing for page 4
	Mods_2021_03  //Add new Buttons to select and view approved inspection PDFs that are on the share
	// Modified by: Costas Manousakis-(Designer)-(2022-09-15 17:53:52)
	Mods_2022_09_bug
	//  `Enable all buttons to start with - added handling of the RtgRequestBtn
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Load:K2:1)
		
		InDoubleClick_B:=False:C215
		ARRAY TEXT:C222(v_1_230_atxt; 0)  // Let's use the UUID array for storing path to approved docs
		
		utl_SetSpellandContextMenu
		Case of 
			: ([Bridge MHD NBIS:1]InspResp:173="MBTA")
				OBJECT SET VISIBLE:C603(*; "MBTAText@"; True:C214)
				OBJECT SET VISIBLE:C603(*; "NonMBTAText@"; False:C215)
				
			Else 
				OBJECT SET VISIBLE:C603(*; "MBTAText@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "NonMBTAText@"; True:C214)
				
		End case 
		
		OBJECT SET VISIBLE:C603(*; "BridgeTemplate_@"; True:C214)
		C_TEXT:C284($currUser_txt)
		$currUser_txt:=<>CurrentUser_Name
		C_LONGINT:C283(bRailRoad)
		
		//Enable all buttons to start
		OBJECT SET ENABLED:C1123(bCsltInsp; True:C214)
		OBJECT SET ENABLED:C1123(bCsltRating; True:C214)
		OBJECT SET ENABLED:C1123(bDesign; True:C214)
		OBJECT SET ENABLED:C1123(bID; True:C214)
		OBJECT SET ENABLED:C1123(bInspection; True:C214)
		OBJECT SET ENABLED:C1123(bInventory; True:C214)
		OBJECT SET ENABLED:C1123(bMaint; True:C214)
		OBJECT SET ENABLED:C1123(bMisc; True:C214)
		OBJECT SET ENABLED:C1123(bRatingRep; True:C214)
		OBJECT SET ENABLED:C1123(bScourCritical; True:C214)
		OBJECT SET ENABLED:C1123(bScourPOA; True:C214)
		OBJECT SET ENABLED:C1123(bSecond; True:C214)
		OBJECT SET ENABLED:C1123(bTunnelInsp; True:C214)
		OBJECT SET ENABLED:C1123(bTunnelSIA; True:C214)
		OBJECT SET ENABLED:C1123(*; "RtgRequestBtn"; True:C214)
		//Railroad is disabled by default
		OBJECT SET ENABLED:C1123(bRailRoad; False:C215)
		OBJECT SET VISIBLE:C603(bRailRoad; False:C215)
		
		
		If ((User in group:C338($currUser_txt; "MDC")) & Not:C34(User in group:C338($currUser_txt; "BMS Admin")))
			If (([Bridge MHD NBIS:1]InspResp:173="MDC") | ([Bridge MHD NBIS:1]LegacyOwner:226="MDC"))
			Else 
				C_BOOLEAN:C305($Access_b)
				$Access_b:=BMSUtil_BelongToBridge($CurrUser_txt; [Bridge MHD NBIS:1]InspResp:173)
				If (Not:C34($Access_b))
					OBJECT SET ENABLED:C1123(bMisc; False:C215)  // **replaced _ o _DISABLE BUTTON(bMisc)
					OBJECT SET ENABLED:C1123(bMaint; False:C215)  // **replaced _ o _DISABLE BUTTON(bMaint)
					OBJECT SET ENABLED:C1123(bSecond; False:C215)  // **replaced _ o _DISABLE BUTTON(bSecond)
					OBJECT SET ENABLED:C1123(bRatingRep; False:C215)  // **replaced _ o _DISABLE BUTTON(bRatingRep)
					OBJECT SET ENABLED:C1123(bCsltRating; False:C215)  // **replaced _ o _DISABLE BUTTON(bCsltRating)
					OBJECT SET ENABLED:C1123(bCsltInsp; False:C215)  // **replaced _ o _DISABLE BUTTON(bCsltInsp)
					OBJECT SET ENABLED:C1123(bDesign; False:C215)  // **replaced _ o _DISABLE BUTTON(bDesign)
					OBJECT SET ENABLED:C1123(bID; False:C215)  // **replaced _ o _DISABLE BUTTON(bID)
				End if 
			End if 
		End if 
		SCPOA_POABtnCtrl
		//Added to change Forward address per maintenance responsibility      
		If (Structure file:C489="MHD BMS External@")
			If ([Bridge MHD NBIS:1]InspResp:173="DIST@")
				vsForward:="District "+Substring:C12([Bridge MHD NBIS:1]InspResp:173; 5; 1)+" BMS"
			End if 
		End if 
		
		Case of 
			: ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DUM")
				OBJECT SET ENABLED:C1123(bMaint; False:C215)  // **replaced _ o _DISABLE BUTTON(bMaint)
				OBJECT SET ENABLED:C1123(bSecond; False:C215)  // **replaced _ o _DISABLE BUTTON(bSecond)
				OBJECT SET ENABLED:C1123(bRatingRep; False:C215)  // **replaced _ o _DISABLE BUTTON(bRatingRep)
				OBJECT SET ENABLED:C1123(bCsltRating; False:C215)  // **replaced _ o _DISABLE BUTTON(bCsltRating)
				OBJECT SET ENABLED:C1123(bCsltInsp; False:C215)  // **replaced _ o _DISABLE BUTTON(bCsltInsp)
				OBJECT SET ENABLED:C1123(bDesign; False:C215)  // **replaced _ o _DISABLE BUTTON(bDesign)
				OBJECT SET ENABLED:C1123(bInventory; False:C215)  // **replaced _ o _DISABLE BUTTON(bInventory)
				OBJECT SET ENABLED:C1123(bInspection; False:C215)  // **replaced _ o _DISABLE BUTTON(bInspection)
				OBJECT SET ENABLED:C1123(bScourPOA; False:C215)  // **replaced _ o _DISABLE BUTTON(bScourPOA)
				OBJECT SET ENABLED:C1123(bScourCritical; False:C215)  // **replaced _ o _DISABLE BUTTON(bScourCritical)
				OBJECT SET ENABLED:C1123(bRailRoad; False:C215)  // **replaced _ o _DISABLE BUTTON(bRailRoad)
				OBJECT SET ENABLED:C1123(bTunnelSIA; False:C215)  // **replaced _ o _DISABLE BUTTON(bTunnelSIA)
				OBJECT SET ENABLED:C1123(bTunnelInsp; False:C215)  // **replaced _ o _DISABLE BUTTON(bTunnelInsp)
				OBJECT SET ENABLED:C1123(*; "RtgRequestBtn"; False:C215)
				
			: ([Bridge MHD NBIS:1]Item8 BridgeCat:207="REM")
				OBJECT SET ENABLED:C1123(bCsltRating; False:C215)  // **replaced _ o _DISABLE BUTTON(bCsltRating)
				OBJECT SET ENABLED:C1123(bCsltInsp; False:C215)  // **replaced _ o _DISABLE BUTTON(bCsltInsp)
				OBJECT SET ENABLED:C1123(bDesign; False:C215)  // **replaced _ o _DISABLE BUTTON(bDesign)
				OBJECT SET ENABLED:C1123(bScourPOA; False:C215)  // **replaced _ o _DISABLE BUTTON(bScourPOA)
				OBJECT SET ENABLED:C1123(bDesign; False:C215)  // **replaced _ o _DISABLE BUTTON(bDesign)
				OBJECT SET ENABLED:C1123(*; "RtgRequestBtn"; False:C215)
				
			: ([Bridge MHD NBIS:1]Item8 BridgeCat:207="@RO")
				If (User in group:C338($currUser_txt; "RRBridgeEdit") | User in group:C338($currUser_txt; "BMS Admin") | User in group:C338($currUser_txt; "Application Admin"))
					OBJECT SET ENABLED:C1123(bRailRoad; True:C214)  // **replaced _ o _ENABLE BUTTON(bRailRoad)
					OBJECT SET VISIBLE:C603(bRailRoad; True:C214)
					OBJECT SET ENABLED:C1123(bSIA; True:C214)  // **replaced _ o _ENABLE BUTTON(bSIA)
				End if 
				
				If (([Bridge MHD NBIS:1]InspResp:173="MBTA") & User in group:C338($currUser_txt; "MBTA"))
					OBJECT SET ENABLED:C1123(bRailRoad; True:C214)  // **replaced _ o _ENABLE BUTTON(bRailRoad)
					OBJECT SET VISIBLE:C603(bRailRoad; True:C214)
				End if 
				If (([Bridge MHD NBIS:1]InspResp:173="DOTRT") & (GRP_UserInGroup("DOTRT_FullEdit")=1))
					OBJECT SET ENABLED:C1123(bRailRoad; True:C214)  // **replaced _ o _ENABLE BUTTON(bRailRoad)
					OBJECT SET VISIBLE:C603(bRailRoad; True:C214)
				End if 
				
		End case 
		
		If (([Bridge MHD NBIS:1]Item8 BridgeCat:207="TNL") | ([Bridge MHD NBIS:1]Item8 BridgeCat:207="BTS") | ([Bridge MHD NBIS:1]Item8 BridgeCat:207="BLD"))
			OBJECT SET VISIBLE:C603(*; "bTunnel@"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "bTunnel@"; False:C215)
		End if 
		
		C_LONGINT:C283($Count_l)
		C_BOOLEAN:C305($EditScourCritical_b; $Visible_b)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_l)
		QUERY:C277([ScourCriticalInfo:150]; [ScourCriticalInfo:150]BIN:1=[Bridge MHD NBIS:1]BIN:3)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		$Visible_b:=False:C215
		
		Case of 
			: ($Count_l=1)
				$Visible_b:=True:C214
			: (User in group:C338($CurrUser_txt; "ScourCritical") | User in group:C338($CurrUser_txt; "Design Access Group"))
				$Visible_b:=True:C214
			Else 
				$Visible_b:=False:C215
		End case 
		OBJECT SET VISIBLE:C603(bScourCritical; $Visible_b)
		
		If ((User in group:C338($currUser_txt; "ExternalInspectors")) | (User in group:C338($currUser_txt; "ExternalDesigners")))
			//For external Inspectors disable access to other modules
			//DISABLE BUTTON(bSIA)
			OBJECT SET ENABLED:C1123(bMisc; False:C215)  // **replaced _ o _DISABLE BUTTON(bMisc)
			OBJECT SET ENABLED:C1123(bMaint; False:C215)  // **replaced _ o _DISABLE BUTTON(bMaint)
			OBJECT SET ENABLED:C1123(bSecond; False:C215)  // **replaced _ o _DISABLE BUTTON(bSecond)
			OBJECT SET ENABLED:C1123(bRatingRep; False:C215)  // **replaced _ o _DISABLE BUTTON(bRatingRep)
			OBJECT SET ENABLED:C1123(bCsltRating; False:C215)  // **replaced _ o _DISABLE BUTTON(bCsltRating)
			OBJECT SET ENABLED:C1123(bCsltInsp; False:C215)  // **replaced _ o _DISABLE BUTTON(bCsltInsp)
			OBJECT SET ENABLED:C1123(bDesign; False:C215)  // **replaced _ o _DISABLE BUTTON(bDesign)
			OBJECT SET ENABLED:C1123(bID; False:C215)  // **replaced _ o _DISABLE BUTTON(bID)
			OBJECT SET ENABLED:C1123(bTunnelSIA; False:C215)  // **replaced _ o _DISABLE BUTTON(bTunnelSIA)
		End if 
		
		vTown:=[Bridge MHD NBIS:1]Town Name:175
		vTown:=vTown+" (D-"+String:C10(Num:C11([Bridge MHD NBIS:1]Item2:60))+")"
		SIA_ReleaseBridgeRec
		G_CloseAllTables(->[Bridge MHD NBIS:1])  //close all tables except the main one.
		OBJECT SET VISIBLE:C603(*; "ForDesigner@"; False:C215)
		
		If (FORM Get current page:C276#1)
			SIA_BridgeInpNavCTRL(FORM Get current page:C276)
		End if 
		C_LONGINT:C283($vlWL; $vlWT; $vlWR; $vlWB; vlNBIStckWinW; vlNBIStckWinH; $fw; $fH)
		C_LONGINT:C283(vNBIOPENDETAIL_L)
		If (vNBIOPENDETAIL_L=1)
			If (vlNBIStckWinW=0)
				GET WINDOW RECT:C443($vlWL; $vlWT; $vlWR; $vlWB)
				vlNBIStckWinW:=$vlWR-$vlWL
				vlNBIStckWinH:=$vlWB-$vlWT
				FORM GET PROPERTIES:C674([Bridge MHD NBIS:1]; "Bridge Input"; $fW; $FH)
				SET WINDOW RECT:C444($vlWL; $vlWT; $vlWL+$fW; $vlWT+$FH)
			End if 
			vNBIOPENDETAIL_L:=0
		End if 
		SET MENU BAR:C67("Blankmenu")
		
	: ($FormEvent_L=On Resize:K2:27)
		
		Case of 
			: (FORM Get current page:C276=4)
				//C_LONGINT($WinW;$WinH;$Win)
				//GET WINDOW RECT($WL;$WT;$WR;$WB)
				//$winW:=$WR-$WL
				//OBJECT GET COORDINATES(*;"RatingReports";$OL;$OT;$OR;$OB)
				SIA_ResetWidths("RatingReports")
		End case 
		
		ARRAY TEXT:C222($objects_atxt; 0)
		ARRAY POINTER:C280($objects_aptr; 0)
		ARRAY LONGINT:C221($pages_aL; 0)
		FORM GET OBJECTS:C898($objects_atxt; $objects_aptr; $pages_aL; Form current page:K67:6)
		C_LONGINT:C283($obj_L)
		
		For ($obj_L; 1; Size of array:C274($objects_atxt))
			If (OBJECT Get type:C1300(*; $objects_atxt{$obj_L})=Object type listbox:K79:8)
				REDRAW:C174($objects_aptr{$obj_L}->)
			End if 
		End for 
		
	: ($FormEvent_L=On Unload:K2:2)
		ARRAY TEXT:C222(v_1_230_atxt; 0)
		G_CloseAllTables(->[Bridge MHD NBIS:1])  //close all tables except the main one.
		//restore Forward to global variable
		vsForward:=<>Forward
		If (ZZ9=1)
			vNBIOPENDETAIL_L:=0
			
			vlNBIStckWinW:=0  //Set this so that the On Open does not re-size when using rec navigati
		End if 
	: ($FormEvent_L=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
End case 