//%attributes = {"invisible":true}
// Method: SIA_RAILINPUT_FM
// Description
//  `Form method for new input form [Bridge MHD NBIS];RAIL_SIA_Input 
// 
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 03/03/14, 13:47:19
	// ----------------------------------------------------
	// First Release
	Mods_2014_03
	// Modified by: Costas Manousakis-(Designer)-(2/15/19 14:32:18)
	Mods_2019_02_bug
	//  `use Case statement at the start for @RO to lock the record or not
	//  `use Case statement for insp resp to account for DOTRT
	
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 
C_TEXT:C284($currUser_txt)
$currUser_txt:=<>CurrentUser_Name

Case of 
	: ($FormEvent_L=On Close Detail:K2:24)
		
	: ($FormEvent_L=On Load:K2:1)
		//SIA Page Ref
		ARRAY TEXT:C222(aSIAPages; 0)  // old _ O _ARRAY STRING length 25
		COPY ARRAY:C226(<>aSIAPages; aSIAPages)
		aSIAPages:=11
		
		SIA_HelpTipCtrl("INIT")
		//SJH 04/21/2004 `````````````````````````````````````````````````
		//ARRAY STRING(25;aNBIPages;0)
		COPY ARRAY:C226(<>aNBIPages; aNBIPages)
		aNBIPages:=1
		//SJH 04/21/2004 `````````````````````````````````````````````````
		
		//## Initialize transfer data
		InitChangeStack(1)
		InitChangeStack(2)
		
		//Unrestricted check box for Item 10
		If ([Bridge MHD NBIS:1]Item10:102=99.99)
			CBItem10:=1
		Else 
			CBItem10:=0
		End if 
		
		//Blank check box for Item 106
		If ([Bridge MHD NBIS:1]Item106:84=0)
			CBItem106:=1
		Else 
			CBItem106:=0
		End if 
		
		//Check box for Item 47
		If ([Bridge MHD NBIS:1]Item47:104=99.9)
			CBItem47:=1
		Else 
			CBItem47:=0
		End if 
		
		//Blank check box for Item 51
		If ([Bridge MHD NBIS:1]Item51:96=0)
			CBItem51:=1
		Else 
			CBItem51:=0
		End if 
		
		//Blank check box for Item 52
		If ([Bridge MHD NBIS:1]Item52:97=0)
			CBItem52:=1
		Else 
			CBItem52:=0
		End if 
		
		//Blank check box for Item 98
		If (Blank([Bridge MHD NBIS:1]Item98A:72))
			CBItem98:=1
		Else 
			CBItem98:=0
		End if 
		
		//Checkbox for Item 53
		CBItem53:=0
		Case of 
			: ([Bridge MHD NBIS:1]Item53:105=99.99)
				CBItem53:=1
		End case 
		
		//Checkbox for Item 54B
		CBItem54:=0
		Case of 
			: ([Bridge MHD NBIS:1]Item54B:108=99.99)
				CBItem54:=1
		End case 
		
		//Radio buttons for Bypass detour length
		rItem19a:=0
		rItem19b:=0
		rItem19c:=0
		Case of 
			: ([Bridge MHD NBIS:1]Item19:91=0)
				rItem19a:=1
			: ([Bridge MHD NBIS:1]Item19:91=1)
				rItem19b:=1
			: ([Bridge MHD NBIS:1]Item19:91=199)
				rItem19c:=1
		End case 
		
		//Radio buttons for feature underneath for Item 54
		Case of 
			: ([Bridge MHD NBIS:1]Item54A:107="H")
				sItem54h:=1
			: ([Bridge MHD NBIS:1]Item54A:107="R")
				sItem54r:=1
			: ([Bridge MHD NBIS:1]Item54A:107="N")
				sItem54n:=1
		End case 
		
		//Radio buttons for feature underneath for Item 55
		Case of 
			: ([Bridge MHD NBIS:1]Item55A:110="H")
				tItem55h:=1
			: ([Bridge MHD NBIS:1]Item55A:110="R")
				tItem55r:=1
			: ([Bridge MHD NBIS:1]Item55A:110="N")
				tItem55n:=1
		End case 
		
		//Check box for Item 55
		If ([Bridge MHD NBIS:1]Item55B:111>30)
			CBItem55:=1
		Else 
			CBItem55:=0
		End if 
		
		//radio buttons for Item 56
		Case of 
			: ([Bridge MHD NBIS:1]Item56:112=99.9)
				uItem56a:=1
			: ([Bridge MHD NBIS:1]Item56:112=99.8)
				uItem56b:=1
			: ([Bridge MHD NBIS:1]Item56:112=0)
				uItem56c:=1
			: (([Bridge MHD NBIS:1]Item56:112<99.8) & ([Bridge MHD NBIS:1]Item56:112>0))
				uItem56d:=1
		End case 
		
		//Init integral bridge type
		If ([Bridge MHD NBIS:1]JointlessType:202="")
			[Bridge MHD NBIS:1]JointlessType:202:="X"
			PushChange(1; ->[Bridge MHD NBIS:1]JointlessType:202)  //Added Mar-03 (was missing)
			aIntegralD_:=Find in array:C230(aIntegralC_; "X")
		End if 
		//Init Item 42    
		If ([Bridge MHD NBIS:1]Item42:85="")
			[Bridge MHD NBIS:1]Item42:85:="  "
			item42a:=Substring:C12([Bridge MHD NBIS:1]Item42:85; 1; 1)  //need to redo related popups
			POPUPMENUC(->aItem42aDes; ->aItem42a; ->item42a)
			item42b:=Substring:C12([Bridge MHD NBIS:1]Item42:85; 2; 1)
			POPUPMENUC(->aItem42bDes; ->aItem42b; ->item42b)
			PushChange(1; ->[Bridge MHD NBIS:1]Item42:85)
		End if 
		//Init Item 43 
		If ([Bridge MHD NBIS:1]Item43:75="")
			[Bridge MHD NBIS:1]Item43:75:="   "
			item43a:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 1; 1)  //need to redo related popups
			POPUPMENUC(->aItem43aDes; ->aItem43a; ->item43a)
			item43b:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 2; 2)
			POPUPMENUC(->aItem43bDes; ->aItem43b; ->item43b)
			PushChange(1; ->[Bridge MHD NBIS:1]Item43:75)
		End if 
		//Init item 44
		If ([Bridge MHD NBIS:1]Item44:76="")
			[Bridge MHD NBIS:1]Item44:76:="   "
			item44a:=Substring:C12([Bridge MHD NBIS:1]Item44:76; 1; 1)  //need to redo related popups
			POPUPMENUC(->aItem44aDes; ->aItem44a; ->item44a)
			item44b:=Substring:C12([Bridge MHD NBIS:1]Item44:76; 2; 2)
			POPUPMENUC(->aItem44bDes; ->aItem44b; ->item44b)
			PushChange(1; ->[Bridge MHD NBIS:1]Item44:76)
		End if 
		
		//added to get the Recommended Posting values from the [RatingReports] table
		If (([Bridge MHD NBIS:1]PostingStatus:8="DESIGN") | ([Bridge MHD NBIS:1]PostingStatus:8="CLOSED"))
			vRecPostingH:=0
			vRecPost3:=0
			vRecPost3S2:=0
		Else 
			G_SIA_GetRecPostings
		End if 
		SIA_ScourRank_OM
		SIA_BridgeRankOM
		SIA_SecureInputForm("RELEASE")  //make sure we start clean..
		SIA_SecureInputForm("APPLY")
		
		If (User in group:C338($currUser_txt; "MBTA"))
			If (User in group:C338($currUser_txt; "MBTA_RO"))
				SIA_SecureInputForm("LOCK")
			End if 
		Else 
			
			If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="@RO")
				
				Case of 
					: (User in group:C338($currUser_txt; "RRBridgeEdit"))
					: (User in group:C338($currUser_txt; "BMS Admin"))
					: (User in group:C338($currUser_txt; "Application Admin"))
					: (User in group:C338(Current user:C182; "Design Access Group"))
					: ([Bridge MHD NBIS:1]InspResp:173="DOTRT") & ((GRP_UserInGroup("DOTRT_FullEdit")=1) | (GRP_UserInGroup("DOTRT_Inspectors")=1))
					: ([Bridge MHD NBIS:1]InspResp:173="MBTA") & ((User in group:C338($currUser_txt; "MBTA_FullEdit")) | (User in group:C338($currUser_txt; "MBTA_Inspectors")))
					Else 
						SIA_SecureInputForm("LOCK")
						
				End case 
				
			Else 
				If (Not:C34(User in group:C338($currUser_txt; "SIA Access")) | Not:C34(BRG_RWAccess))
					SIA_SecureInputForm("LOCK")
				End if 
				
			End if 
		End if 
		//``` 
		//``` Changes for MBTA Ratings
		//```
		OBJECT SET VISIBLE:C603(*; "DisplayOnlyRtg@"; True:C214)
		OBJECT SET VISIBLE:C603(*; "MBTARating_@"; False:C215)
		
		
		Case of 
			: ([Bridge MHD NBIS:1]InspResp:173="MBTA")
				OBJECT SET VISIBLE:C603(*; "DisplayOnlyRtg@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "MBTARating_@"; True:C214)
				QUERY:C277([RAILBridgeInfo:37]; [RAILBridgeInfo:37]BIN:1=[Bridge MHD NBIS:1]BIN:3)
				If ((User in group:C338($currUser_txt; "MBTA_FullEdit")) | (User in group:C338($currUser_txt; "MBTA_Inspectors")) | User in group:C338(Current user:C182; "Design Access Group"))
					InitChangeStack(2)
					If (Records in selection:C76([RAILBridgeInfo:37])=1)
						
						If (ut_LoadRecordInteractive(->[RAILBridgeInfo:37]))
							
						Else 
							ALERT:C41("Cannot edit Rating Loads at this time!")
							OBJECT SET ENTERABLE:C238(*; "MBTARating_@"; False:C215)
							OBJECT SET RGB COLORS:C628(*; "MBTARating_@"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "MBTARating_@"; <>Color_not_editable)
						End if 
						
					Else 
						CREATE RECORD:C68([RAILBridgeInfo:37])
						[RAILBridgeInfo:37]BIN:1:=[Bridge MHD NBIS:1]BIN:3
						[RAILBridgeInfo:37]Created_Date_d:18:=Current date:C33(*)
						[RAILBridgeInfo:37]Created_Time_t:19:=Current time:C178(*)
						[RAILBridgeInfo:37]CreatedBy_s:17:=Current user:C182
						[RAILBridgeInfo:37]LineName:6:=[Bridge MHD NBIS:1]RRBranch:210
						[RAILBridgeInfo:37]MilePt:2:=[Bridge MHD NBIS:1]RRBridgeNo:211
						LogNewRecord(->[RAILBridgeInfo:37]BIN:1; ->[RAILBridgeInfo:37]BIN:1; ->[RAILBridgeInfo:37]BIN:1; 0; "")
						PushChange(2; ->[RAILBridgeInfo:37]Created_Date_d:18)
						PushChange(2; ->[RAILBridgeInfo:37]Created_Time_t:19)
						PushChange(2; ->[RAILBridgeInfo:37]CreatedBy_s:17)
						PushChange(2; ->[RAILBridgeInfo:37]LineName:6)
						PushChange(2; ->[RAILBridgeInfo:37]MilePt:2)
						FlushGrpChgs(2; ->[RAILBridgeInfo:37]BIN:1; ->[RAILBridgeInfo:37]BIN:1; ->[RAILBridgeInfo:37]BIN:1; 0)
						SAVE RECORD:C53([RAILBridgeInfo:37])
					End if 
					
				Else 
					OBJECT SET ENTERABLE:C238(*; "MBTARating_@"; False:C215)
					OBJECT SET RGB COLORS:C628(*; "MBTARating_@"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "MBTARating_@"; <>Color_not_editable)
				End if 
				SIA_RRInput_FM(On Load:K2:1)
				
			: ([Bridge MHD NBIS:1]InspResp:173="DOTRT")
				OBJECT SET VISIBLE:C603(*; "MBTARating_@"; True:C214)
				QUERY:C277([RAILBridgeInfo:37]; [RAILBridgeInfo:37]BIN:1=[Bridge MHD NBIS:1]BIN:3)
				If ((GRP_UserInGroup("DOTRT_FullEdit")=1) | (GRP_UserInGroup("DOTRT_Inspectors")=1) | User in group:C338(Current user:C182; "Design Access Group"))
					InitChangeStack(2)
					If (Records in selection:C76([RAILBridgeInfo:37])=1)
						
						If (ut_LoadRecordInteractive(->[RAILBridgeInfo:37]))
							
						Else 
							ALERT:C41("Cannot edit Rating Loads at this time!")
							OBJECT SET ENTERABLE:C238(*; "MBTARating_@"; False:C215)
							OBJECT SET RGB COLORS:C628(*; "MBTARating_@"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "MBTARating_@"; <>Color_not_editable)
						End if 
						
					Else 
						CREATE RECORD:C68([RAILBridgeInfo:37])
						[RAILBridgeInfo:37]BIN:1:=[Bridge MHD NBIS:1]BIN:3
						[RAILBridgeInfo:37]Created_Date_d:18:=Current date:C33(*)
						[RAILBridgeInfo:37]Created_Time_t:19:=Current time:C178(*)
						[RAILBridgeInfo:37]CreatedBy_s:17:=Current user:C182
						[RAILBridgeInfo:37]LineName:6:=[Bridge MHD NBIS:1]RRBranch:210
						[RAILBridgeInfo:37]MilePt:2:=[Bridge MHD NBIS:1]RRBridgeNo:211
						LogNewRecord(->[RAILBridgeInfo:37]BIN:1; ->[RAILBridgeInfo:37]BIN:1; ->[RAILBridgeInfo:37]BIN:1; 0; "")
						PushChange(2; ->[RAILBridgeInfo:37]Created_Date_d:18)
						PushChange(2; ->[RAILBridgeInfo:37]Created_Time_t:19)
						PushChange(2; ->[RAILBridgeInfo:37]CreatedBy_s:17)
						PushChange(2; ->[RAILBridgeInfo:37]LineName:6)
						PushChange(2; ->[RAILBridgeInfo:37]MilePt:2)
						FlushGrpChgs(2; ->[RAILBridgeInfo:37]BIN:1; ->[RAILBridgeInfo:37]BIN:1; ->[RAILBridgeInfo:37]BIN:1; 0)
						SAVE RECORD:C53([RAILBridgeInfo:37])
					End if 
					
				Else 
					OBJECT SET ENTERABLE:C238(*; "MBTARating_@"; False:C215)
					OBJECT SET RGB COLORS:C628(*; "MBTARating_@"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "MBTARating_@"; <>Color_not_editable)
				End if 
				SIA_RRInput_FM(On Load:K2:1)
				
		End case 
		
		If (GRP_UserInGroup("TEMP_EditLatLon")=1)
			SIA_SecureInputForm("EDITLATLONG")
		End if 
		
		If (Read only state:C362([Bridge MHD NBIS:1]))
			SIA_SecureInputForm("LOCK")
		End if 
		
	: ($FormEvent_L=On Validate:K2:3)
		If (Modified record:C314([Bridge MHD NBIS:1]))
			If (Size of array:C274(ptr_changes{1})>0)  //added this to avoid un-needed log entries
				TimeStamp_ut(->[Bridge MHD NBIS:1]; ->[Bridge MHD NBIS:1]DateCreated:192; ->[Bridge MHD NBIS:1]TimeCreated:193; ->[Bridge MHD NBIS:1]DateModified:194; ->[Bridge MHD NBIS:1]TimeModified:195)
				[Bridge MHD NBIS:1]Modified By:191:=$currUser_txt
				If ([Bridge MHD NBIS:1]Modified By:191#Old:C35([Bridge MHD NBIS:1]Modified By:191))
					PushChange(1; ->[Bridge MHD NBIS:1]Modified By:191)
				End if 
				If ([Bridge MHD NBIS:1]DateModified:194#Old:C35([Bridge MHD NBIS:1]DateModified:194))
					PushChange(1; ->[Bridge MHD NBIS:1]DateModified:194)
				End if 
				PushChange(1; ->[Bridge MHD NBIS:1]TimeModified:195)
			End if 
			//Recalculate the AASHTO Sufficiency rating
			[Bridge MHD NBIS:1]AASHTO:5:=AASHTO_SuffRat
			If ([Bridge MHD NBIS:1]AASHTO:5#Old:C35([Bridge MHD NBIS:1]AASHTO:5))
				PushChange(1; ->[Bridge MHD NBIS:1]AASHTO:5)  //This should be recalculated at the remote!
			End if 
			If ([Bridge MHD NBIS:1]Item67:142#Old:C35([Bridge MHD NBIS:1]Item67:142))
				PushChange(1; ->[Bridge MHD NBIS:1]Item67:142)
			End if 
			If ([Bridge MHD NBIS:1]Item68:143#Old:C35([Bridge MHD NBIS:1]Item68:143))
				PushChange(1; ->[Bridge MHD NBIS:1]Item68:143)
			End if 
			If ([Bridge MHD NBIS:1]Item69:144#Old:C35([Bridge MHD NBIS:1]Item69:144))
				PushChange(1; ->[Bridge MHD NBIS:1]Item69:144)
			End if 
			If ([Bridge MHD NBIS:1]Item70:140#Old:C35([Bridge MHD NBIS:1]Item70:140))
				PushChange(1; ->[Bridge MHD NBIS:1]Item70:140)
			End if 
			If ([Bridge MHD NBIS:1]Item91:162#Old:C35([Bridge MHD NBIS:1]Item91:162))
				PushChange(1; ->[Bridge MHD NBIS:1]Item91:162)
			End if 
			//##Save changes made to file
			FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
		End if 
		
		If (Modified record:C314([RAILBridgeInfo:37]))
			[RAILBridgeInfo:37]Modified_Date_d:21:=Current date:C33(*)
			[RAILBridgeInfo:37]Modified_Time_t:22:=Current time:C178(*)
			[RAILBridgeInfo:37]ModifiedBy_s:20:=Current user:C182
			PushChange(2; ->[RAILBridgeInfo:37]Modified_Date_d:21)
			PushChange(2; ->[RAILBridgeInfo:37]Modified_Time_t:22)
			PushChange(2; ->[RAILBridgeInfo:37]ModifiedBy_s:20)
			FlushGrpChgs(2; ->[RAILBridgeInfo:37]BIN:1; ->[RAILBridgeInfo:37]BIN:1; ->[RAILBridgeInfo:37]BIN:1; 0)
			SAVE RECORD:C53([RAILBridgeInfo:37])
		End if 
		
		If (Not:C34(User in group:C338($currUser_txt; "SIA Access")))
			OBJECT SET ENTERABLE:C238(*; "Field@"; True:C214)
			OBJECT SET ENTERABLE:C238(*; "Featur@"; True:C214)
			OBJECT SET ENTERABLE:C238(*; "UW @"; True:C214)
			OBJECT SET ENTERABLE:C238(*; "DE @"; True:C214)
			
			OBJECT SET RGB COLORS:C628(*; "Field@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "Field@"; <>Color_editable)
			OBJECT SET RGB COLORS:C628(*; "Featur@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "Featur@"; <>Color_editable)
			OBJECT SET RGB COLORS:C628(*; "UW @"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "UW @"; <>Color_editable)
			OBJECT SET RGB COLORS:C628(*; "DE @"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE @"; <>Color_editable)
			OBJECT SET ENTERABLE:C238(*; "Variable@"; True:C214)
			OBJECT SET ENABLED:C1123(*; "Variable@"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"Variable@")
			OBJECT SET ENABLED:C1123(*; "Featur@"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"Featur@")
		End if 
		
	: ($FormEvent_L=On Unload:K2:2)
		SIA_HelpTipCtrl("RESET")
		
End case 