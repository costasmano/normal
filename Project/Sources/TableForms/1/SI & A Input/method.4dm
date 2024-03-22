If (False:C215)
	
	//Form Method: [Bridge MHD NBIS];"SI & A Input" 
	Mods_2005_CM05
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(1/17/2006 11:28:17)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(2/27/2006 14:43:58)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(4/10/2006 09:27:32)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(3/28/2007 16:05:30)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(1/4/08 12:26:58)
	Mods_2007_CM_5401
	//  `Release the curr bridge rec if the user is not part of the SIAAccess group
	// Modified by: costasmanousakis-(Designer)-(3/6/08 15:19:32)
	Mods_2008_CM_5403
	//Allow Area and Bridge inps engineer access to the Freeze thaw
	// Modified by: costasmanousakis-(Designer)-(4/4/08 16:52:21)
	Mods_2008_CM_5403
	// Modified by: costasmanousakis-(Designer)-(4/30/08 16:46:33)
	Mods_2008_CM_5403
	//  `Adjust entry order on page 1; change objects for item7,6a to use the new
	//  `SIA_@_OM project methods.
	Mods_2008_CM_5403
	//Added rank and HI object and method
	// Modified by: costasmanousakis-(Designer)-(10/13/09 14:30:40)
	Mods_2009_10
	//  `Added display of Scour Categry and rank; call SIA_ScourRank_OM in form method
	// Modified by: costasmanousakis-(Designer)-(12/18/09 16:07:46)
	Mods_2009_12
	//  `Added help tip on the Accept and Cacnel  buttons and control with the method SIA_HelpTipCtrl 
	// Modified by: costasmanousakis-(Designer)-(1/20/11 09:54:57)
	Mods_2011_01
	//` RR Changes To allow RRBridgeEdit users access to the SIA for @RO bridges; also use $currUser_txt
	// Modified by: costasmanousakis-(Designer)-(2/28/11 10:11:04)
	Mods_2011_02
	//  `Applied entry filter Item5Main to Item 5
	// Modified by: costasmanousakis-(Designer)-(11/30/11 16:01:44)
	Mods_2011_11
	//  ` Use ◊CurrentUser_Name instead of Current user
	Mods_2013_03  //r001 ` Add code for access for MBTA users Group MBTA ad MBTA_RO
	//Modified by: Charles Miller (3/12/13 16:23:47)
	// Modified by: Costas Manousakis-(Designer)-(5/23/13 11:51:17)
	Mods_2013_05
	//  `Added fields from [RAILBridgeInfo] for load ratings of hwy bridges - Rail road ratings are in the railinput form
	// Modified by: Costas Manousakis-(Designer)-(9/6/13 16:55:49)
	Mods_2013_09
	//  `Named inspection data fields to DE BridgeInsp@
	// Modified by: Costas Manousakis-(Designer)-(10/22/13 16:41:35)
	Mods_2013_10
	//  `at the end of the load event, if the table is in RO mode lock the whole input form anyway
	// Modified by: Costas Manousakis-(Designer)-(10/24/13 16:57:11)
	Mods_2013_10
	//  `Special case for (GRP_UserInGroup ("TEMP_EditLatLon")=1) to allow interns to edit lat long values only
	// Modified by: Costas Manousakis-(Designer)-(4/23/14 17:21:46)
	Mods_2014_04
	//  `added Hybrid Artic loads under MBTARtg bridge loads
	// Modified by: Costas Manousakis-(Designer)-(6/20/14 11:58:00)
	Mods_2014_06_bug
	//  `change entry filter for item 5 for  TNL, BTS, BLD records to allow a 2;A-Z = Under  record per coding guide
	// Modified by: Costas Manousakis-(Designer)-(9/12/14 16:07:27)
	Mods_2014_09_bug
	//  `fixed  data entry order  in lat/long fields
	// Modified by: Costas Manousakis-(Designer)-(10/12/17 16:38:51)
	Mods_2017_10
	//  `added Multistyle text var to display the Select List status; use hidden label object "FHWASelect" as the base for the label.
	//  //use the color of the AASHTO field
	// Modified by: Costas Manousakis-(Designer)-(4/11/18 16:47:13)
	Mods_2018_04
	//  `restrict inspection dates not to be greater than the current date. restrict Years not to be greater than the current year
	// Modified by: Costas Manousakis-(Designer)-(3/13/19 13:19:23)
	Mods_2019_03_bug
	//  `Enabled Page Change at the form properties
	//  //at end of on Load and on Page Change make sure no object has focus to avoid inadvertant data entry. CallReference #615
	//  `for item 6A and 7 created new entry filter Item6_7 CallReference #617
	// Modified by: Costas Manousakis-(Designer)-(4/9/19 17:18:05)
	Mods_2019_04_bug
	//  `fixed filter Item5Main to correctly allow A for route number, added filter Item5TNL - use these directly instead of building them in code
	// Modified by: Costas Manousakis-(Designer)-(6/3/19 15:36:02)
	Mods_2019_06_bug
	//  `disabled automatic drag and drop on item 5 field
	// Modified by: Costas Manousakis-(Designer)-(1/30/20 17:24:33)
	Mods_2020_01_bug
	//  `added object "RAILNotice" on page 9 in the "MBTAHWYLoads" view
	// Modified by: Costas Manousakis-(Designer)-(2021-10-13)
	Mods_2021_10
	//Added objects on page 10
	// [Bridge MHD NBIS];"SI & A Input".DE StairsOnAdjacent ; .BridgeStairCount ; .StairsLabel
	//  // call SIA_StairsOn_OM (On Load) in form method
	// Modified by: Costas Manousakis-(Designer)-(2021-10-29T00:00:00 10:37:19)
	Mods_2021_10_bug
	//  `changed labels for HWYRTGs to TBusA, TBusB, TBusC - reuquested by D. NG 10/19/2021
End if 

C_TEXT:C284($currUser_txt)
$currUser_txt:=<>CurrentUser_Name

Case of 
	: (Form event code:C388=On Page Change:K2:54)
		//make sure no object has focus to avoid inadvertant entry
		GOTO OBJECT:C206(*; "")
		
	: (Form event code:C388=On Load:K2:1)
		UI_ResizeDropdowns
		utl_SetSpellandContextMenu
		//SIA Page Ref
		ARRAY TEXT:C222(aSIAPages; 0)  //Command Replaced was o_ARRAY string length was 25
		COPY ARRAY:C226(<>aSIAPages; aSIAPages)
		aSIAPages:=11
		
		SIA_HelpTipCtrl("INIT")
		//SJH 04/21/2004 `````````````````````````````````````````````````
		//ARRAY STRING(25;aNBIPages;0)
		COPY ARRAY:C226(<>aNBIPages; aNBIPages)
		aNBIPages:=1
		//SJH 04/21/2004 `````````````````````````````````````````````````
		
		C_DATE:C307($FhwaSelDate_d; $BMSLoadDate_d)
		SIA_LoadSelectionListInfo(->$FhwaSelDate_d; ->$BMSLoadDate_d)
		//sFHWASelect:=
		C_TEXT:C284($label_txt)
		C_LONGINT:C283($Color1_L)
		OBJECT GET RGB COLORS:C1074([Bridge MHD NBIS:1]AASHTO:5; $Color1_L)
		$label_txt:=OBJECT Get title:C1068(*; "FHWASelect")
		ST SET TEXT:C1115(*; "FHWASelect1"; OBJECT Get title:C1068(*; "FHWASelect")+Choose:C955([Bridge MHD NBIS:1]FHWA Select:4; "Y"; "N")+"  ("+String:C10($FhwaSelDate_d)+")")
		ST SET ATTRIBUTES:C1093(*; "FHWASelect1"; Length:C16($label_txt); (Length:C16($label_txt)+2); Attribute bold style:K65:1; 0; Attribute text color:K65:7; $Color1_L)
		
		//## Initialize transfer data
		InitChangeStack(1)
		
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
		
		C_TEXT:C284($Item5TunnelFmt_txt; $Item5Fmt_txt)
		
		//$Item5TunnelFmt_txt:="!0~"+Char(Double quote)+"2;A-Z"+Char(Double quote)+"#&"+Char(Double quote)+"1-9"+Char(Double quote)+"#&"
		//$Item5TunnelFmt_txt:=$Item5TunnelFmt_txt+Char(Double quote)+"0-8"+Char(Double quote)+"#&"+Char(Double quote)+"0-9"+Char(Double quote)+"####&"+Char(Double quote)+"0-9;A-Z"+Char(Double quote)+"#&"
		//$Item5TunnelFmt_txt:=$Item5TunnelFmt_txt+Char(Double quote)+"0-4"+Char(Double quote)+"#"
		
		//$Item5Fmt_txt:="!0~"+Char(Double quote)+"1"+Char(Double quote)+"#&"+Char(Double quote)+"1-9"+Char(Double quote)+"#&"
		//$Item5Fmt_txt:=$Item5Fmt_txt+Char(Double quote)+"0-8"+Char(Double quote)+"#&"+Char(Double quote)+"0-9"+Char(Double quote)+"####&"+Char(Double quote)+"0-9,A-Z"+Char(Double quote)+"#&"
		//$Item5Fmt_txt:=$Item5Fmt_txt+Char(Double quote)+"0-4"+Char(Double quote)+"#"
		$Item5TunnelFmt_txt:="|Item5TNL"
		$Item5Fmt_txt:="|Item5Main"
		If (([Bridge MHD NBIS:1]Item8 BridgeCat:207="TNL") | ([Bridge MHD NBIS:1]Item8 BridgeCat:207="BTS") | ([Bridge MHD NBIS:1]Item8 BridgeCat:207="BLD"))
			OBJECT SET FILTER:C235([Bridge MHD NBIS:1]Item5:59; $Item5TunnelFmt_txt)
		Else 
			OBJECT SET FILTER:C235([Bridge MHD NBIS:1]Item5:59; $Item5Fmt_txt)
		End if 
		
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
		SIA_StairsOn_OM(On Load:K2:1)
		
		SIA_SecureInputForm("RELEASE")  //make sure we start clean..
		SIA_SecureInputForm("APPLY")
		
		OBJECT SET MAXIMUM VALUE:C1244([Bridge MHD NBIS:1]Item90:161; Current date:C33(*))
		OBJECT SET MAXIMUM VALUE:C1244([Bridge MHD NBIS:1]Item93A:169; Current date:C33(*))
		OBJECT SET MAXIMUM VALUE:C1244([Bridge MHD NBIS:1]Item93B:170; Current date:C33(*))
		OBJECT SET MAXIMUM VALUE:C1244([Bridge MHD NBIS:1]Item93C:171; Current date:C33(*))
		OBJECT SET MAXIMUM VALUE:C1244([Bridge MHD NBIS:1]OtherIDate:41; Current date:C33(*))
		OBJECT SET MAXIMUM VALUE:C1244([Bridge MHD NBIS:1]ClosedIDate:44; Current date:C33(*))
		OBJECT SET MAXIMUM VALUE:C1244([Bridge MHD NBIS:1]DamageInsp:47; Current date:C33(*))
		OBJECT SET MAXIMUM VALUE:C1244([Bridge MHD NBIS:1]UWSpInspDate:214; Current date:C33(*))
		OBJECT SET MAXIMUM VALUE:C1244([Bridge MHD NBIS:1]Item27:83; Year of:C25(Current date:C33(*)))
		OBJECT SET MAXIMUM VALUE:C1244([Bridge MHD NBIS:1]Item106:84; Year of:C25(Current date:C33(*)))
		OBJECT SET MAXIMUM VALUE:C1244([Bridge MHD NBIS:1]Item30:89; Year of:C25(Current date:C33(*)))
		OBJECT SET MAXIMUM VALUE:C1244([Bridge MHD NBIS:1]Item115:160; (Year of:C25(Current date:C33(*))+22))
		OBJECT SET MINIMUM VALUE:C1242([Bridge MHD NBIS:1]Item115:160; (Year of:C25(Current date:C33(*))+17))
		OBJECT SET MAXIMUM VALUE:C1244([Bridge MHD NBIS:1]Item97:158; Year of:C25(Current date:C33(*)))
		
		If (User in group:C338($currUser_txt; "MBTA"))
			If (User in group:C338($currUser_txt; "MBTA_RO"))
				SIA_SecureInputForm("LOCK")
			End if 
		Else 
			
			If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="@RO")
				If (User in group:C338($currUser_txt; "RRBridgeEdit") | User in group:C338($currUser_txt; "BMS Admin") | User in group:C338($currUser_txt; "Application Admin"))
					
				Else 
					SIA_SecureInputForm("LOCK")
				End if 
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
		
		If ([Bridge MHD NBIS:1]InspResp:173="MBTA")
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
			
		End if 
		
		If (GRP_UserInGroup("TEMP_EditLatLon")=1)
			SIA_SecureInputForm("EDITLATLONG")
		End if 
		
		If (Read only state:C362([Bridge MHD NBIS:1]))
			SIA_SecureInputForm("LOCK")
		End if 
		//make sure no object has focus to avoid inadvertant entry
		GOTO OBJECT:C206(*; "")
		
	: (Form event code:C388=On Validate:K2:3)
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
		
	: (Form event code:C388=On Unload:K2:2)
		SIA_HelpTipCtrl("RESET")
		
End case 