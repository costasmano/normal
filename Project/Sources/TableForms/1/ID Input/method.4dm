If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/01/05, 17:06:19
	// ----------------------------------------------------
	// Method: Form Method: [Bridge MHD NBIS];"ID Input"
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM10
	// Modified by: costasmanousakis-(Designer)-(11/19/05 17:16:27)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(2/7/2006 12:28:36)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(1/4/08 12:37:44)
	Mods_2007_CM_5401
	//  `Release the curr bridge rec if the user is not part of the SIAAccess group and not MTA
	// Modified by: costasmanousakis-(Designer)-(4/30/08 16:25:55)
	Mods_2008_CM_5403
	//  `Adjsut some object arrangement; for all the objects in Item7 and item6A use the new methods
	//  `SIA_@@_OM.
	//  `Call the SIA_Feature_OM on Load of form event
	// Modified by: Costas Manousakis-(Designer)-(2/21/13 14:27:45)
	Mods_2013_02
	//Use ◊CurrentUser_Name; add case for MBTA users; allow acess to Rail Branch
	// Modified by: Costas Manousakis-(Designer)-(3/29/13 13:42:16)
	Mods_2013_03
	//  `Increased width of [Bridge MHD NBIS]RRBranch field
	// Modified by: Costas Manousakis-(Designer)-(5/29/18 11:50:12)
	Mods_2018_05
	//  `removed reference to vIt8OwnerDes and vIt8BrCatDes
	// Modified by: Costas Manousakis-(Designer)-(6/20/18 16:09:50)
	Mods_2018_06
	//  `name of first tab to MADOT
	// Modified by: Costas Manousakis-(Designer)-(2/25/20 10:46:27)
	Mods_2020_02_bug
	//  `When changing category to REM change Item7 and 6A CallReference #685
End if 

C_TEXT:C284($CurrUser_txt)
$CurrUser_txt:=<>CurrentUser_Name

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		If (User in group:C338($CurrUser_txt; "Key Access"))
			//## Initialize transfer data
			InitChangeStack(1)
			OBJECT SET ENABLED:C1123(*; "ID_INP_@"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"ID_INP_@")
			OBJECT SET ENTERABLE:C238(*; "ID_INP_@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "ID_INP_Town@"; True:C214)
			OBJECT SET RGB COLORS:C628(*; "ID_INP_@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "ID_INP_@"; <>Color_Editable)
			SIA_Feature_OM(->[Bridge MHD NBIS:1]Item7:65; ->IDa7FDescr_; ->IDv7FDescr; ->IDa7FCodes_; ->IDv7RteNum; ->IDv7suffix; ->IDv7Descr)
			SIA_Feature_OM(->[Bridge MHD NBIS:1]Item6A:63; ->IDaFeatDescr_; ->IDvFeatDescr; ->IDaFeatCodes_; ->IDvRteNum; ->IDvSuffix; ->IDv6Descr)
		Else 
			OBJECT SET ENABLED:C1123(*; "ID_INP_ARROW@"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"ID_INP_ARROW@")
			OBJECT SET ENABLED:C1123(*; "ID_INP_CKB@"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"ID_INP_CKB@")
			OBJECT SET ENABLED:C1123(*; "ID_INP_Var@"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"ID_INP_Var@")
			OBJECT SET ENTERABLE:C238(*; "ID_INP_@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "ID_INP_Town@"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "ID_INP_@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "ID_INP_@"; <>Color_Not_Editable)
			Case of 
				: (([Bridge MHD NBIS:1]InspResp:173="MTA") & User in group:C338($CurrUser_txt; "MTA"))
					
					//ALERT("Enabling access")
					InitChangeStack(1)
					OBJECT SET ENABLED:C1123(*; "ID_INP_BTN_ACCEPT"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"ID_INP_BTN_ACCEPT")
					OBJECT SET ENTERABLE:C238(*; "ID_INP_Agency@"; True:C214)
					OBJECT SET RGB COLORS:C628(*; "ID_INP_Agency@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "ID_INP_Agency@"; <>Color_Editable)
					
				: (([Bridge MHD NBIS:1]InspResp:173="MBTA") & (User in group:C338($CurrUser_txt; "MBTA_FullEdit") | User in group:C338($CurrUser_txt; "MBTA_Inspectors")))
					//ALERT("Enabling access")
					InitChangeStack(1)
					OBJECT SET ENABLED:C1123(*; "ID_INP_BTN_ACCEPT"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"ID_INP_BTN_ACCEPT")
					OBJECT SET ENTERABLE:C238(*; "ID_INP_Agency@"; True:C214)
					OBJECT SET RGB COLORS:C628(*; "ID_INP_Agency@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "ID_INP_Agency@"; <>Color_Editable)
					OBJECT SET ENTERABLE:C238(*; "ID_INP_RR@"; True:C214)
					OBJECT SET RGB COLORS:C628(*; "ID_INP_RR@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "ID_INP_RR@"; <>Color_Editable)
					
				Else 
					SIA_ReleaseBridgeRec
					OBJECT SET ENABLED:C1123(*; "ID_INP_BTN_ACCEPT"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"ID_INP_BTN_ACCEPT")
			End case 
			
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		If (Modified record:C314([Bridge MHD NBIS:1]))
			TimeStamp_ut(->[Bridge MHD NBIS:1]; ->[Bridge MHD NBIS:1]DateCreated:192; ->[Bridge MHD NBIS:1]TimeCreated:193; ->[Bridge MHD NBIS:1]DateModified:194; ->[Bridge MHD NBIS:1]TimeModified:195)
			[Bridge MHD NBIS:1]Modified By:191:=$CurrUser_txt
			
			If ([Bridge MHD NBIS:1]Modified By:191#Old:C35([Bridge MHD NBIS:1]Modified By:191))
				PushChange(1; ->[Bridge MHD NBIS:1]Modified By:191)
			End if 
			If ([Bridge MHD NBIS:1]DateModified:194#Old:C35([Bridge MHD NBIS:1]DateModified:194))
				PushChange(1; ->[Bridge MHD NBIS:1]DateModified:194)
			End if 
			PushChange(1; ->[Bridge MHD NBIS:1]TimeModified:195)
			
			If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="REM") & (Old:C35([Bridge MHD NBIS:1]Item8 BridgeCat:207)#"REM")
				//changed to REM
				[Bridge MHD NBIS:1]Item7:65:="OTHER REMOVED"
				IDv6Descr:=Substring:C12([Bridge MHD NBIS:1]Item6A:63; 7)
				C_LONGINT:C283($dlg_L)
				$dlg_L:=Open form window:C675([Bridge MHD NBIS:1]; "RemovedBridge"; Movable form dialog box:K39:8)
				DIALOG:C40([Bridge MHD NBIS:1]; "RemovedBridge")
				CLOSE WINDOW:C154($dlg_L)
				
				[Bridge MHD NBIS:1]Item6A:63:="OTHER "+IDv6Descr
				
				PushChange(1; ->[Bridge MHD NBIS:1]Item7:65)
				PushChange(1; ->[Bridge MHD NBIS:1]Item6A:63)
			End if 
			//##Save changes made to file
			FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
		End if 
		
End case 