//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/14/08, 11:51:53
	// ----------------------------------------------------
	// Method: SIA_SecureInputForm
	// Description
	// Handle security settings in the SIA Input form.
	// 
	// Parameters
	// $1 : Action type ("APPLY" | "RELEASE" | "LOCK")
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
	// Modified by: costasmanousakis-(Designer)-(10/30/09 12:55:24)
	Mods_2009_10
	//  `Added code to secure Item 113 
	// Modified by: costasmanousakis-(Designer)-(12/8/09 10:32:28)
	Mods_2009_12
	//Added Bridge insp Engineer and Area Engineers to edit UW inspection info
	// Modified by: costasmanousakis-(Designer)-(9/1/10 12:34:38)
	Mods_2010_09
	//  `Added more color changes to fields being set to editable/noneditable
	// Modified by: costasmanousakis-(Designer)-(11/30/11 16:33:55)
	Mods_2011_11
	//  `For non_NBI records unlock Item91 Inspection frequency
	// Modified by: Costas Manousakis-(Designer)-(12/7/12 14:31:08)
	Mods_2012_12
	//  `For ALL non_NBI records unlock Item91 Inspection frequency
	// Modified by: Costas Manousakis-(Designer)-(9/6/13 16:52:50)
	Mods_2013_09
	//  `For tunnel records lock all inspection fields - must be entered in the Tunnel SIA input form
	// Modified by: Costas Manousakis-(Designer)-(10/24/13 16:03:10)
	Mods_2013_10
	//  `added special action for users to edit LatLon fields only
	// Modified by: Costas Manousakis-(Designer)-(2/19/14 11:30:08)
	Mods_2014_02_bug
	//  `Allow agencies to enter UW inspection values - use new group UWInspectionItemEdit
	// Modified by: Costas Manousakis-(Designer)-(9/11/18 13:50:36)
	Mods_2018_09_bug
	//  `allow only members of personnel group "SIA_Item5Edit", or designer to edit Item 5
	// Modified by: Costas Manousakis-(Designer)-(9/12/18 17:16:13)
	Mods_2018_09_bug
	//  `change from 4D Group Historical Significance" to Personnel group SIA_Item37Edit
	// Modified by: Costas Manousakis-(Designer)-(1/30/20)
	Mods_2020_01_bug
	//  `lock MBTARating loads and show RailNotice when TRO or RRO bridge
End if 
C_TEXT:C284($1)
C_TEXT:C284($currentuser_txt)
$currentuser_txt:=<>CurrentUser_Name
Case of 
	: ($1="APPLY")
		If (User in group:C338($currentuser_txt; "Jointless Bridge"))
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]JointlessBridge:176; True:C214)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]JointlessBridge:176; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]JointlessBridge; <>Color_Editable)
			OBJECT SET ENABLED:C1123(aIntegralD_; True:C214)  // **replaced _ o _ENABLE BUTTON(aIntegralD_)
		Else 
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]JointlessBridge:176; False:C215)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]JointlessBridge:176; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]JointlessBridge; <>Color_not_editable)
			OBJECT SET ENABLED:C1123(aIntegralD_; False:C215)  // **replaced _ o _DISABLE BUTTON(aIntegralD_)
		End if 
		
		If ((GRP_UserInGroup("SIA_Item37Edit")=1) | User in group:C338(Current user:C182; "Design Access Group"))
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item37:129; True:C214)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item37:129; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item37; <>Color_Editable)
		Else 
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item37:129; False:C215)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item37:129; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item37; <>Color_not_editable)
		End if 
		
		If ((GRP_UserInGroup("SIA_Item5Edit")=1) | User in group:C338(Current user:C182; "Design Access Group"))
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item5:59; True:C214)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item5:59; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item5; <>Color_Editable)
		Else 
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item5:59; False:C215)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item5:59; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item5; <>Color_not_editable)
		End if 
		
		If ([Bridge MHD NBIS:1]Item103:124=True:C214)
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item70:140; True:C214)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item70:140; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item70; <>Color_Editable)
		Else 
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item70:140; False:C215)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item70:140; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item70; <>Color_not_editable)
		End if 
		C_BOOLEAN:C305($UWInfoEdit_b)
		$UWInfoEdit_b:=User in group:C338($currentuser_txt; "UWInspectionItemEdit")
		
		If ([Bridge MHD NBIS:1]InspResp:173#"DIST@")
			//For agency bridges - allow Agency people to edit
			$UWInfoEdit_b:=$UWInfoEdit_b | BMSUtil_BelongToBridge
		End if 
		
		If ($UWInfoEdit_b)
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item92BA:165; True:C214)
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item92BB:166; True:C214)
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item93B:170; True:C214)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item92BA:165; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item92BA; <>Color_Editable)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item92BB:166; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item92BB; <>Color_Editable)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item93B:170; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item93B; <>Color_Editable)
			OBJECT SET ENTERABLE:C238(*; "UW Inspection Item@"; True:C214)
			OBJECT SET RGB COLORS:C628(*; "UW Inspection Item@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "UW Inspection Item@"; <>Color_Editable)
		Else 
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item92BA:165; False:C215)
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item92BB:166; False:C215)
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item93B:170; False:C215)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item92BA:165; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item92BA; <>Color_not_editable)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item92BB:166; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item92BB; <>Color_not_editable)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item93B:170; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item93B; <>Color_not_editable)
			OBJECT SET ENTERABLE:C238(*; "UW Inspection Item@"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "UW Inspection Item@"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "UW Inspection Item@"; <>Color_not_editable)
		End if 
		
		//Per request from F. Rastegari Dec-24-2001 Lock Feat. Over Under
		If (User in group:C338($currentuser_txt; "Key Access"))
			OBJECT SET ENTERABLE:C238(*; "Features@"; True:C214)
			OBJECT SET ENABLED:C1123(*; "Features@"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"Features@")
		Else 
			OBJECT SET ENTERABLE:C238(*; "Features@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "Features@"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"Features@")
		End if 
		
		//Per request from F. Rastegari Aug-24-2001
		If (User in group:C338($currentuser_txt; "Ratings and Overloads"))
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item64:137; True:C214)
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item66:139; True:C214)
			OBJECT SET ENABLED:C1123(aORatMethD_; True:C214)  // **replaced _ o _ENABLE BUTTON(aORatMethD_)
			OBJECT SET ENABLED:C1123(aIRatMethD_; True:C214)  // **replaced _ o _ENABLE BUTTON(aIRatMethD_)
		Else 
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item64:137; False:C215)
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item66:139; False:C215)
			OBJECT SET ENABLED:C1123(aORatMethD_; False:C215)  // **replaced _ o _DISABLE BUTTON(aORatMethD_)
			OBJECT SET ENABLED:C1123(aIRatMethD_; False:C215)  // **replaced _ o _DISABLE BUTTON(aIRatMethD_)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item66:139; Col_paletteToRGB(Abs:C99(-Green:K11:9)%256); Col_paletteToRGB(Abs:C99(-Green:K11:9)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item66; -Green)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item64:137; Col_paletteToRGB(Abs:C99(-Green:K11:9)%256); Col_paletteToRGB(Abs:C99(-Green:K11:9)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item64; -Green)
			OBJECT SET RGB COLORS:C628(aORatMethD_; Col_paletteToRGB(Abs:C99(-Dark green:K11:10)%256); Col_paletteToRGB(Abs:C99(-Dark green:K11:10)\256))  // **Replaced o OBJECT SET COLOR(aORatMethD_; -Dark green)
			OBJECT SET RGB COLORS:C628(aIRatMethD_; Col_paletteToRGB(Abs:C99(-Dark green:K11:10)%256); Col_paletteToRGB(Abs:C99(-Dark green:K11:10)\256))  // **Replaced o OBJECT SET COLOR(aIRatMethD_; -Dark green)
		End if 
		//Also per request from F. Rastegari Aug-24-2001
		If ((User in group:C338($currentuser_txt; "Bridge Engineer")) | (User in group:C338($currentuser_txt; "Bridge Insp Engineer")) | ($currentuser_txt="designer"))
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]PostingDate:7; True:C214)
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Complex Bridge:178; True:C214)
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Complex Rating:219; True:C214)  //Req. from F. Rastegari Mar-03
			OBJECT SET ENABLED:C1123(aPostStat_; True:C214)  // **replaced _ o _ENABLE BUTTON(aPostStat_)
			OBJECT SET ENABLED:C1123(vDesRating; True:C214)  // **replaced _ o _ENABLE BUTTON(vDesRating)
			OBJECT SET VISIBLE:C603(vDesRating; True:C214)
		Else 
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]PostingDate:7; False:C215)
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Complex Bridge:178; False:C215)
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Complex Rating:219; False:C215)
			OBJECT SET ENABLED:C1123(aPostStat_; False:C215)  // **replaced _ o _DISABLE BUTTON(aPostStat_)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]PostingDate:7; Col_paletteToRGB(Abs:C99(-Green:K11:9)%256); Col_paletteToRGB(Abs:C99(-Green:K11:9)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]PostingDate; -Green)
			OBJECT SET RGB COLORS:C628(aPostStat_; Col_paletteToRGB(Abs:C99(-Dark green:K11:10)%256); Col_paletteToRGB(Abs:C99(-Dark green:K11:10)\256))  // **Replaced o OBJECT SET COLOR(aPostStat_; -Dark green)
			OBJECT SET ENABLED:C1123(vDesRating; False:C215)  // **replaced _ o _DISABLE BUTTON(vDesRating)
			OBJECT SET VISIBLE:C603(vDesRating; False:C215)
		End if 
		
		//Added to enable Entry for Item 91 for  NonNBI records
		If (Not:C34([Bridge MHD NBIS:1]FHWARecord:174))
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item91:162; True:C214)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item91:162; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item91; <>Color_Editable)
		End if 
		If ((User in group:C338($currentuser_txt; "Inspection Engineers")) | (User in group:C338($currentuser_txt; "Bridge Insp Engineer")) | User in group:C338($currentuser_txt; "Area Engineers"))
			OBJECT SET ENTERABLE:C238(*; "DE FreezeThawList"; True:C214)
			OBJECT SET ENABLED:C1123(*; "DE FreezeThawList"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"DE FreezeThawList")
			OBJECT SET RGB COLORS:C628(*; "DE FreezeThawList"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE FreezeThawList"; <>Color_Editable)
		Else 
			OBJECT SET ENTERABLE:C238(*; "DE FreezeThawList"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE FreezeThawList"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"DE FreezeThawList")
			OBJECT SET RGB COLORS:C628(*; "DE FreezeThawList"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE FreezeThawList"; <>Color_not_editable)
		End if 
		
		If (User in group:C338($currentuser_txt; "ITEM113EDIT"))
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item113:151; True:C214)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item113:151; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item113; <>Color_Editable)
		Else 
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item113:151; False:C215)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item113:151; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item113; <>Color_not_editable)
		End if 
		
		SIA_Feature_OM(->[Bridge MHD NBIS:1]Item7:65; ->a7FDescr_; ->v7FDescr; ->a7FCodes_; ->v7RteNum; ->v7Suffix; ->v7Descr; On Load:K2:1)
		SIA_Feature_OM(->[Bridge MHD NBIS:1]Item6A:63; ->aFeatDescr_; ->vFeatDescr; ->aFeatCodes_; ->vRteNum; ->vsuffix; ->v6Descr; On Load:K2:1)
		If ([Bridge MHD NBIS:1]FHWARecord:174)
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item91:162; False:C215)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item91:162; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item91; <>Color_not_editable)
		Else 
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item91:162; True:C214)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item91:162; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item91; <>Color_Editable)
		End if 
		
		If (([Bridge MHD NBIS:1]Item8 BridgeCat:207="TNL") | ([Bridge MHD NBIS:1]Item8 BridgeCat:207="BTS"))
			//Lock all inspection for Boat and Tunnel records
			OBJECT SET ENTERABLE:C238(*; "DE BridgeInsp@"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "DE BridgeInsp@"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE BridgeInsp@"; <>Color_not_editable)
			OBJECT SET ENTERABLE:C238(*; "UW @"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "UW @"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "UW @"; <>Color_not_editable)
			OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item91:162; False:C215)
			OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item91:162; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item91; <>Color_not_editable)
			OBJECT SET VISIBLE:C603(*; "TUNNELNotice"; True:C214)
		End if 
		If (([Bridge MHD NBIS:1]Item8 BridgeCat:207="TRO") | ([Bridge MHD NBIS:1]Item8 BridgeCat:207="RRO"))
			//lock MBTA Hwy rating loads and show a notice
			OBJECT SET ENTERABLE:C238(*; "MBTARating@"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "MBTARating@"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "MBTARating@"; <>Color_not_editable)
			OBJECT SET VISIBLE:C603(*; "RailNotice"; True:C214)
		End if 
		
		
	: ($1="EDITLATLONG")
		SIA_SecureInputForm("LOCK")
		LOAD RECORD:C52([Bridge MHD NBIS:1])
		OBJECT SET ENABLED:C1123(*; "SaveBtn"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"SaveBtn")
		OBJECT SET ENABLED:C1123(*; "VariableCopyLatLon"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"VariableCopyLatLon")
		OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item16A:68; True:C214)
		OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item16B:69; True:C214)
		OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item16C:109; True:C214)
		OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item17A:70; True:C214)
		OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item17B:71; True:C214)
		OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item17C:136; True:C214)
		OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item16A:68; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item16A; <>Color_editable)
		OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item16B:69; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item16B; <>Color_editable)
		OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item16C:109; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item16C; <>Color_editable)
		OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item17A:70; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item17A; <>Color_editable)
		OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item17B:71; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item17B; <>Color_editable)
		OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item17C:136; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item17C; <>Color_editable)
		
		
	: ($1="LOCK")
		OBJECT SET ENTERABLE:C238(*; "Field@"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "DE BridgeInsp@"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "Featur@"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "UW @"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "DE @"; False:C215)
		
		OBJECT SET RGB COLORS:C628(*; "Field@"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "Field@"; <>Color_not_editable)
		OBJECT SET RGB COLORS:C628(*; "DE BridgeInsp@"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE BridgeInsp@"; <>Color_not_editable)
		OBJECT SET RGB COLORS:C628(*; "Featur@"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "Featur@"; <>Color_not_editable)
		OBJECT SET RGB COLORS:C628(*; "UW @"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "UW @"; <>Color_not_editable)
		OBJECT SET RGB COLORS:C628(*; "DE @"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE @"; <>Color_not_editable)
		OBJECT SET ENTERABLE:C238(*; "Variable@"; False:C215)
		OBJECT SET ENABLED:C1123(*; "Variable@"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"Variable@")
		OBJECT SET ENABLED:C1123(*; "Featur@"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"Featur@")
		OBJECT SET VISIBLE:C603(*; "SIALockBtn"; False:C215)
		SIA_ReleaseBridgeRec
		If ((Not:C34(User in group:C338($currentuser_txt; "SIA Access"))) | (Not:C34(BRG_RWAccess)))
			OBJECT SET VISIBLE:C603(*; "SIALockBtn"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "SIALockBtn"; True:C214)
		End if 
		
	: ($1="RELEASE")
		OBJECT SET ENTERABLE:C238(*; "Field@"; True:C214)
		OBJECT SET ENTERABLE:C238(*; "DE BridgeInsp@"; True:C214)
		OBJECT SET ENTERABLE:C238(*; "Featur@"; True:C214)
		OBJECT SET ENTERABLE:C238(*; "UW @"; True:C214)
		OBJECT SET ENTERABLE:C238(*; "DE @"; True:C214)
		
		OBJECT SET RGB COLORS:C628(*; "Field@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "Field@"; <>Color_editable)
		OBJECT SET RGB COLORS:C628(*; "DE BridgeInsp@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE BridgeInsp@"; <>Color_editable)
		OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]JointlessBridge:176; Col_paletteToRGB(Abs:C99(-White:K11:1)%256); Col_paletteToRGB(Abs:C99(-White:K11:1)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]JointlessBridge; -White)
		OBJECT SET RGB COLORS:C628(*; "Featur@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "Featur@"; <>Color_editable)
		OBJECT SET RGB COLORS:C628(*; "UW @"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "UW @"; <>Color_editable)
		OBJECT SET RGB COLORS:C628(*; "DE @"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE @"; <>Color_editable)
		OBJECT SET ENTERABLE:C238(*; "Variable@"; True:C214)
		OBJECT SET ENABLED:C1123(*; "Variable@"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"Variable@")
		OBJECT SET ENABLED:C1123(*; "Featur@"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"Featur@")
		OBJECT SET VISIBLE:C603(*; "SIALockBtn"; True:C214)
		
End case 