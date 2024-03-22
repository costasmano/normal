//%attributes = {"invisible":true}
If (False:C215)
	//G_InitInspVars
	//Method to initialize variables used in an Inspection form
	//To be called from On Load event of form method.
	
	Mods_2004_CM11
	Mods_2005_CM06
	Mods_2005_CM15
	// Modified by: costasmanousakis-(Designer)-(11/10/2006 19:49:00)
	Mods_2007_CM04
	// Modified by: costasmanousakis-(Designer)-(4/13/2007 12:03:12)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(10/19/2007 15:35:24)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(3/28/08 11:58:32)
	Mods_2008_CM_5403
	//Added vars for Kilo/Mile display 
	// Modified by: costasmanousakis-(Designer)-(9/7/08 16:56:32)
	Mods_2008_CM_5404  // ("INSPREVCMTS")
	//  `Added vars needed for new method of modifying/updating Inspection review/approve comments.
	// Modified by: costasmanousakis-(Designer)-(4/9/09 20:40:48)
	Mods_2009_04
	//added Vars INSP_ThermoRed_L, INSP_ThermoBlack_L
	// Modified by: costasmanousakis-(Designer)-(10/27/09 15:18:39)
	Mods_2009_10("MASSDOT")
	//  `MassDOT change on vsInspDepartment
	//  `Added INSP_Item8_s var and adjust it according to inspection date
	// Modified by: costasmanousakis-(Designer)-(7/27/10 08:41:12)
	Mods_2010_07
	//Replaced a lot of declarations with a call to COMPILER_InspElmtVars
	// Modified by: Costas Manousakis-(Designer)-(5/9/12 14:53:02)
	Mods_2012_05
	//  `Added declaration for the format pulldowns for the 4D Write areas
	Mods_2012_09  //r001 `added c_string(40;vDBIE )
	//Modified by: Charles Miller (9/13/12 15:26:43)
	Mods_2012_12  //r001 `Add code for new inspection types
	//Modified by: Charles Miller (12/13/12 16:12:20)
	// Modified by: Costas Manousakis-(Designer)-(4/15/14 15:32:27)
	Mods_2014_04
	//  `added call to set INSP_MBTABridgeType_txt
	// Modified by: Costas Manousakis-(Designer)-(12/10/18 16:42:52)
	Mods_2018_12_bug
	//  `for any RRO bridge set INSP_MBTABridgeType_txt = "Commuter" to allow DOT rail div to snter Rail engine loads
End if 

C_TEXT:C284(sBDEPT; sBDEPT_P; sTOWN; sInspDATE)  // Command Replaced was o_C_STRING length was 80
G_SIA_BuildTownLine
sTOWN:=Uppercase:C13(sTOWN)

Compiler_InspElmtVars
insp_ClearPrintedFormVariables

C_TEXT:C284(vsNorthEast; vsSouthWest; vsNESideWlk; vsSWSideWlk)  // Command Replaced was o_C_STRING length was 2

//Variables all uppercase because they were taken from a compiler symbol file
//Deficiency variables for inspection forms
C_TEXT:C284(VD_58_1; VD_58_2; VD_58_3; VD_59_1; VD_59_10; VD_59_2; VD_59_3; VD_59_4; VD_59_5)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(VD_59_6; VD_59_7; VD_59_8; VD_59_9)  // Command Replaced was o_C_STRING length was 6

//Item ratings
C_TEXT:C284(VR_58_1; VR_58_2; VR_58_3; VR_59_1; VR_59_10; VR_59_2; VR_59_3; VR_59_4; VR_59_5)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(VR_59_6; VR_59_7; VR_59_8; VR_59_9)  // Command Replaced was o_C_STRING length was 1

//Item descr variables
C_TEXT:C284(VDESCR_58_1; VDESCR_58_2; VDESCR_58_3; VDESCR_59_1; VDESCR_59_10; VDESCR_59_2)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(VDESCR_59_3; VDESCR_59_4; VDESCR_59_5; VDESCR_59_6; VDESCR_59_7; VDESCR_59_8)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(VDESCR_59_9)  // Command Replaced was o_C_STRING length was 50

//Accessibility sub-items
C_TEXT:C284(VACCESIBN1; VACCESIBN10; VACCESIBN11; VACCESIBN2; VACCESIBN3; VACCESIBN4; VACCESIBN5)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(VACCESIBN6; VACCESIBN7; VACCESIBN8; VACCESIBN9; VACCESIBU1; VACCESIBU10; VACCESIBU11)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(VACCESIBU2; VACCESIBU3; VACCESIBU4; VACCESIBU5; VACCESIBU6; VACCESIBU7; VACCESIBU8)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(VACCESIBU9; VACCESIBN12; VACCESIBN13; VACCESIBN14; VACCESIBU12; VACCESIBU13; VACCESIBU14)  // Command Replaced was o_C_STRING length was 1

//Page counting variables
C_LONGINT:C283(vTotalPages; viNumCmtsPgs; viCmtsPgStart; viSkPgStart; viChPgStart; viPhPgStart)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(viNumSkPgs; viNumChPgs; viNumPhPgs; viNumSpMPages)  //Command Replaced was o_C_INTEGER
//SIA Item Ratings
C_TEXT:C284(vItem58; vItem58Prev; vItem59; vItem59Prev)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vItem60; vItem60UW; vItem60Cur; vItem60Prev; vItem61; vItem61UW; vItem61Cur; vItem61Prev)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vItem62; vItem62UW; vItem62Cur; vItem62Prev)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vItem58_R; vItem59_R; vItem60_R; vItem62_R)  // Command Replaced was o_C_STRING length was 1

C_TEXT:C284(vInspTitlePr)  // Command Replaced was o_C_STRING length was 255//Printed Inspection Title

C_TEXT:C284(vsInspDepartment)  // Command Replaced was o_C_STRING length was 150
C_TEXT:C284(INSP_Item8_s)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(vDBIE)  // Command Replaced was o_C_STRING length was 40
C_TEXT:C284(vItem22)  // Command Replaced was o_C_STRING length was 27
If ([Inspections:27]Insp Date:78>=!2009-11-01!)
	INSP_Item8_s:=[Bridge MHD NBIS:1]Item8:206
	Case of 
		: ([Bridge MHD NBIS:1]InspResp:173="MBTA")
			vsInspDepartment:="MASSACHUSETTS BAY TRANSPORTATION AUTHORITY"
		: ([Bridge MHD NBIS:1]InspResp:173="MDC")
			If ([Bridge MHD NBIS:1]Item8 Owner:208="DOT")
				vsInspDepartment:="MASSACHUSETTS DEPARTMENT OF TRANSPORTATION"
			Else 
				vsInspDepartment:="DEPARTMENT OF CONSERVATION AND RECREATION"
			End if 
		Else 
			vsInspDepartment:="MASSACHUSETTS DEPARTMENT OF TRANSPORTATION"
	End case 
Else 
	If ([Bridge MHD NBIS:1]LegacyOwner:226#"")
		INSP_Item8_s:=[Bridge MHD NBIS:1]BDEPT:1+[Bridge MHD NBIS:1]BIN:3+[Bridge MHD NBIS:1]LegacyOwner:226+[Bridge MHD NBIS:1]Item8 BridgeCat:207
	Else 
		INSP_Item8_s:=[Bridge MHD NBIS:1]Item8:206
	End if 
	
	Case of 
		: ([Bridge MHD NBIS:1]InspResp:173="MTA")
			vsInspDepartment:="MASSACHUSETTS TURNPIKE AUTHORITY"
		: ([Bridge MHD NBIS:1]InspResp:173="MBTA")
			vsInspDepartment:="MASSACHUSETTS BAY TRANSPORTATION AUTHORITY"
		: ([Bridge MHD NBIS:1]InspResp:173="MDC")
			vsInspDepartment:="DEPARTMENT OF CONSERVATION AND RECREATION"
		Else 
			vsInspDepartment:="MASSACHUSETTS HIGHWAY DEPARTMENT"
	End case 
	
End if 

C_BOOLEAN:C305(vInsp_FontAlertShown)
If (Form event code:C388=On Load:K2:1)
	vInsp_FontAlertShown:=False:C215
End if 
C_TEXT:C284(INSP_MBTABridgeType_txt)
INSP_MBTABridgeType_txt:=""

If ([Bridge MHD NBIS:1]InspResp:173="MBTA")
	INSP_MBTABridgeType_txt:=mbta_ReturnBridgeType
Else 
	
	Case of 
		: ([Bridge MHD NBIS:1]Item8 BridgeCat:207="RRO")
			INSP_MBTABridgeType_txt:="Commuter"
	End case 
	
End if 

INSP_KiloPtValues

C_TEXT:C284(INSP_DBIECmmtsAdd_txt; INSP_DBIECmmtsDisp_txt; INSP_DBIECmmtsOrig_txt)
C_TEXT:C284(INSP_AECmmtsAdd_txt; INSP_AECmmtsDisp_txt; INSP_AECmmtsOrig_txt)
INSP_DBIECmmtsAdd_txt:=""
INSP_AECmmtsAdd_txt:=""
INSP_DBIECmmtsOrig_txt:=[Inspections:27]InspRevCmts:170
INSP_AECmmtsOrig_txt:=[Inspections:27]InspApprCmts:169
INSP_DBIECmmtsDisp_txt:=INSP_DBIECmmtsOrig_txt
INSP_AECmmtsDisp_txt:=INSP_AECmmtsOrig_txt

C_LONGINT:C283(INSP_ThermoRed_L; INSP_ThermoBlack_L)
INSP_ThermoRed_L:=-(Red:K11:4+(256*White:K11:1))
INSP_ThermoBlack_L:=-(Black:K11:16+(256*White:K11:1))

//Declare arrays for format pulldown menus one for each area
ARRAY TEXT:C222(vFormatPopUpG; 0)  //general comments
ARRAY TEXT:C222(vFormatPopUpO; 0)  //orientation text
ARRAY TEXT:C222(vFormatPopUpE; 0)  //element comments
