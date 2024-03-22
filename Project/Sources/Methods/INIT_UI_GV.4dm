//%attributes = {"invisible":true}
//GP: INIT_UI_GV
//Initialize interprocess variables for the MHD BMS application
//setup splash screen

If (False:C215)
	//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
	Mods_2004_CM11
	Mods_2005_CM05
	// Modified by: costasmanousakis-(Designer)-(11/4/2005 14:58:20)
	Mods_2005_CM18
	// Modified by: costasmanousakis-(Designer)-(1/30/2006 12:30:53)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(4/4/2006 09:13:17)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(4/13/2006 12:21:10)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(11/13/2006 12:23:14)
	Mods_2006_CM07
	// Modified by: costasmanousakis-(Designer)-(1/12/2007 09:10:04)
	Mods_2007_CM04
	// Modified by: costasmanousakis-(Designer)-(1/30/2007 09:22:50)
	Mods_2007_CM06
	// Modified by: costasmanousakis-(Designer)-(4/13/2007 12:15:54)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(8/22/2007 12:46:38)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(8/28/2007 16:48:41)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(8/30/2007 10:59:14)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/22/2007 12:26:17)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(10/3/08 11:47:10)
	Mods_2008_CM_5404  // ("DESIGNMODS")
	//  `Added arrays ◊MHDItm31Codes_atxt and ◊FHWAItm31Codes_atxt
	// Modified by: costasmanousakis-(Designer)-(9/29/09 11:01:45)
	Mods_2009_09
	//added temp def for ◊D6TownList_txt
	// Modified by: costasmanousakis-(Designer)-(1/29/10 14:13:12)
	Mods_2010_01
	//  `Added global var ◊InspFormRevDate_6:= Date("02/14/2010")
	// Modified by: costasmanousakis-(Designer)-(5/23/11 12:28:49)
	Mods_2011_05
	//  `Moved ControlMenuBar at the end so that the Personal info is loaded.
	// Modified by: costasmanousakis-(Designer)-(7/1/11 14:13:46)
	Mods_2011_06
	//  `Removed Somerville from the D6 towns
	// Modified by: costasmanousakis-(Designer)-(10/18/11 10:39:02)
	Mods_2011_10
	//  `Define new global var ◊CurrentUser_Name for function Current user
	// Modified by: Costas Manousakis-(Designer)-(9/10/12 11:29:55)
	Mods_2012_09
	//  `Added call to ut_defineBrgCondRtg
	// Modified by: Costas Manousakis-(Designer)-(4/4/13 09:25:21)
	Mods_2013_04
	//  `Changed Splash window title to MassDOT
	// Modified by: Costas Manousakis-(Designer)-(2/27/14 15:35:52)
	Mods_2014_02
	//  `New Freeze thaw date effective 1/1/2014 ◊InspFormRevDate_7
	// Modified by: Costas Manousakis-(Designer)-(4/28/14 17:31:05)
	Mods_2014_04
	//  `LStackSize set to 1024*1024
	// Modified by: Costas Manousakis-(Designer)-(6/4/14 17:25:29)
	Mods_2014_06
	//  `added name of DB in splash window title
	// Modified by: Costas Manousakis-(Designer)-(1/15/15 16:29:53)
	Mods_2015_01
	//  `added ◊INSPFORMREVDATE_8
	// Modified by: Costas Manousakis-(Designer)-(3/1/17 12:03:42)
	Mods_2017_03
	//  `added global vars to indicate  MetricTon or RatingFactor for item 63,65
	Mods_2021_04  //Reset stack size to use app version default
	//Modified by: CJ (4/8/21 16:09:56)
	// Modified by: Costas Manousakis-(Designer)-(2021-10-28T00:00:00 18:00:24)
	Mods_2021_10
	//  `added C_DATE(<>Insp_ESignatureStart)
	// Modified by: Costas Manousakis-(Designer)-(2022-03-30 11:49:25)
	Mods_2022_03
	//  `fixed parameter name "SIA_LoadRtg_63_RF"
	// Modified by: Costas Manousakis-(Designer)-(2022-09-26 17:59:29)
	Mods_2022_09_bug
	//  `connected to Boston Server when str file = MHD BMS & is compiled mode
	// Modified by: Costas Manousakis-(Designer)-(2023-12-08 14:27:51)
	Mods_2023_12
	//  `  <>LwinY - set to 50
End if 

C_BOOLEAN:C305(<>CM_LogChanges_b)
<>CM_LogChanges_b:=False:C215  //!!!!!If changed, review ALL Log commands for correctness for keytypes etc.  
C_BOOLEAN:C305(<>TWNAD_LogChanges_b)
<>TWNAD_LogChanges_b:=True:C214

C_TEXT:C284($SplashTitle)  // Command Replaced was o_C_STRING length was 255//Startup window

$SplashTitle:="MassDOT Bridge Inspection"

Case of 
	: (Application type:C494=4D Local mode:K5:1)
		$SplashTitle:=$SplashTitle+" ("+Structure file:C489+")"
		
	: (Application type:C494=4D Remote mode:K5:5)
		$SplashTitle:=$SplashTitle+" (Connected to "
		Case of 
			: (Structure file:C489="MHD BMS") & Is compiled mode:C492
				$SplashTitle:=$SplashTitle+"Boston Server"
			Else 
				$SplashTitle:=$SplashTitle+Structure file:C489
		End case 
		$SplashTitle:=$SplashTitle+" via Client)"
		
	: (Application type:C494=4D Volume desktop:K5:2)
		$SplashTitle:=$SplashTitle+" (Standalone App)"
		
End case 

C_LONGINT:C283(<>LSplashWinID)
SET WINDOW TITLE:C213($SplashTitle; <>LSplashWinID)
C_BOOLEAN:C305(<>fQuit)  //moved here to initialize it before ControlMenuBar call
<>fQuit:=False:C215
REDRAW WINDOW:C456(<>LSplashWinID)

C_LONGINT:C283(<>LWinX; <>LWinY)

C_DATE:C307(<>InspFormRevDate_1)
<>InspFormRevDate_1:=!2004-12-15!
C_DATE:C307(<>InspFormRevDate_2)
<>InspFormRevDate_2:=!2005-03-22!
C_DATE:C307(<>InspFormRevDate_3)
<>InspFormRevDate_3:=!2007-01-18!
C_DATE:C307(<>InspFormRevDate_4)
<>InspFormRevDate_4:=!2007-04-30!
C_DATE:C307(<>InspFormRevDate_5)
<>InspFormRevDate_5:=!2007-09-29!
C_DATE:C307(<>InspFormRevDate_6)
<>InspFormRevDate_6:=Date:C102("03/06/2010")
C_DATE:C307(<>InspFormRevDate_7)
<>InspFormRevDate_7:=Date:C102("01/01/2014")

C_DATE:C307(<>InspFormRevDate_8)  //implemented more tracking features incuding FieldWorkComplete
<>InspFormRevDate_8:=Date:C102(ut_GetSysParameter("InspFormRevDate_8"))

C_DATE:C307(<>Insp_ESignatureStart)
<>Insp_ESignatureStart:=Date:C102(ut_GetSysParameter("Insp_ESignatureStart"))

C_TEXT:C284(<>LNK_CHANGE_Vers)  //version of change in the way LNK is executed and used
<>LNK_CHANGE_Vers:="5.2"
//Default settings for window stacking
<>LWinX:=10
<>LWinY:=50  //  Start of Mods_2023_12

Characters

C_LONGINT:C283(<>LDifference)
C_DATE:C307($dServDate; $dMyDate)
C_TIME:C306($hServTime; $hMyTime; <>hDifference)

$dServDate:=Current date:C33(*)  //Get the Server date
$dMyDate:=Current date:C33  //Get the My date
<>LDifference:=$dServDate-$dMyDate  // Set the Date difference

$hServTime:=Current time:C178(*)  //Get the Server time
$hMyTime:=Current time:C178  //Get the My time
<>hDifference:=$hServTime-$hMyTime  // Set the Time difference

//Global variables for preferences
InitPrefs

//C_STRING(80;$StationName;$OwnerName)
C_TEXT:C284(<>Source)  // Command Replaced was o_C_STRING length was 80

//Get the computer name from the File Sharing setup dialog box
//Commented  GetNames on 6 3 00 by RLV
//GetNames ($StationName;$OwnerName)
//Source:=$StationName
<>Source:=Current system user:C484

//Interprocess variable for procedure GetKey
C_LONGINT:C283(<>Key)  //Command Replaced was o_C_INTEGER

//READ ONLY(*)  `Set all file to read only

C_LONGINT:C283(<>LStackSize)
<>LStackSize:=0  //1024*1024  //Increased on 23-jun-03//Make it use default for each new process

ARRAY TEXT:C222(<>asWindows; 0)  //Command Replaced was o_ARRAY string length was 80
ARRAY INTEGER:C220(<>aiWindows; 0)

C_LONGINT:C283(<>LFilesPalet)
<>LFilesPalet:=0
C_LONGINT:C283(<>LFilePalPID)
<>LFilePalPID:=0

//global variables for Progress menu bar
C_TEXT:C284(<>vTitle; <>vItemDesc)  // Command Replaced was o_C_STRING length was 132
C_LONGINT:C283(<>Remaining)
C_BOOLEAN:C305(<>Ready; <>Abort)
C_LONGINT:C283(<>ProgressPID)
<>ProgressPID:=0

//global variables for colors of fields
C_LONGINT:C283(<>Color_Not_editable; <>Color_Alert_Field; <>Color_Editable)  //Command Replaced was o_C_INTEGER
<>Color_Editable:=-(Blue:K11:7+(256*Grey:K11:15))
<>Color_Not_editable:=-(Blue:K11:7+(256*Light grey:K11:13))
<>Color_Alert_Field:=-(Dark blue:K11:6+(256*Red:K11:4))

C_LONGINT:C283(<>PRJ_Color_Not_editable; <>PRJ_Color_Editable)  //Command Replaced was o_C_INTEGER
<>PRJ_Color_Editable:=-(Black:K11:16+(256*White:K11:1))
<>PRJ_Color_Not_editable:=-(Black:K11:16+(256*Light grey:K11:13))
//vars for limits of comments on 1st page of FCR,DVS,DAM 
//----FCR and CMI inspections use the same form 
C_LONGINT:C283(<>vLimitCharFCR; <>vLimitCharDVS; <>vLimitCharDAM)  //Command Replaced was o_C_INTEGER
<>vLimitCharFCR:=50
<>vLimitCharDAM:=50
<>vLimitCharDVS:=50

ARRAY TEXT:C222(<>asViewName; 0)  //Command Replaced was o_ARRAY string length was 80
ARRAY LONGINT:C221(<>aLViewNum; 0)

<>LBackground:=0  //Number of processes in background so we don't quit with
//them running
//C_LONGINT($Lpid)
//$Lpid:=LSpawnProcess ("P_LogoffChecker";◊LStackSize;"$Logoff";False;False)

<>fCompiled:=Is compiled mode:C492  //Find out if the database is compiled

C_TEXT:C284(<>CurrentUser_Name)
<>CurrentUser_Name:=Current user:C182
C_LONGINT:C283(<>CurrentUser_UID)  //ID of curr user from 4D Password system
<>CurrentUser_UID:=utf_GetUserID(<>CurrentUser_Name)
C_LONGINT:C283(<>CurrentUser_PID)  //Command Replaced was o_C_INTEGER//ID of curr user from [Personnel] Table
<>CurrentUser_PID:=utf_GetUserPID(<>CurrentUser_Name)

PERS_GetMyInfo  // Load Personnel data for the current user

C_BOOLEAN:C305(<>vCancel)  //variable checks for Command-.
<>vCancel:=False:C215

ut_RetrieveUIGVarrDoc  //Get arrays from a doc or load them clean

C_LONGINT:C283(<>MessageFileCycle_L)  //Number of files to cycle thru in the ut_StartMessage method
<>MessageFileCycle_L:=16

//These two variables are used to translate Historical Significance
//between the internal MHD code and NBI Item 37.
C_TEXT:C284(<>Item37FHWA; <>Item37Code)  // Command Replaced was o_C_STRING length was 11
<>Item37FHWA:="12235334435"  //NBI Coding Guide
<>Item37Code:="HEPANCR ?XZ"  //MHD internal code

//Constants for safety elements
C_LONGINT:C283(<>kOVRs_; <>kOVRf_)
C_LONGINT:C283(<>kAPRs_; <>kAPRf_)
C_LONGINT:C283(<>kTRAs_; <>kTRAf_)
C_LONGINT:C283(<>k58s_; <>k59s_; <>k60s_; <>k61s_; <>k62s_)
C_LONGINT:C283(<>k58f_; <>k59f_; <>k60f_; <>k61f_; <>k62f_)
C_LONGINT:C283(<>k59truss_; <>k59pin_; <>k61fdr_; <>ktrussf_)
C_LONGINT:C283(<>k60abutf_; <>k60piers_; <>k60piersf_)

<>kAPRs_:=10  //start of approach
<>kAPRf_:=13  //end of approach -changed 2003-10-10 include blank
<>kOVRs_:=20  //start of overhead signs
<>kOVRf_:=22  //end of overhead signs
<>kTRAs_:=30
<>kTRAf_:=33
<>k58s_:=100
<>k58f_:=116  //jan-2003 include arch insp and blanks
<>k59s_:=200
<>k59f_:=228  //jan-2003 include arch insp and blanks
<>k59truss_:=204
<>k59trussf_:=211
<>k59pin_:=212
<>k60s_:=300
<>k60abutf_:=312  //ASL 1/11/2002 Include blank element
<>k60piers_:=313  //ASL 1/11/2002 Include blank element
<>k60piersf_:=324  //ASL 1/11/2002 Include blank elements
<>k60piles_:=325  //ASL 1/11/2002 Include blank element
<>k60f_:=331  //ASL 1/11/2002 Include blank element
<>k61s_:=400  //Start Item 61 Channel and Channel protection
<>k61fdr_:=407  //Fender system
//3/17/2001 ASL
<>k61fdrs_:=408  //Start Fender system elements
//End 3/17/2001 ASL
//ASL 1/11/2002 Include blank element
<>k61f_:=416  //End Item 61 Channel and Channel protection
<>k62s_:=500
<>k62f_:=517  //ASL 1/11/2002 Include blank elements

C_TEXT:C284($MHDCodes_txt; $FHWACodes_txt)
$MHDCodes_txt:=ut_GetSysParameter("SIA_DESLOADCODE_MHD"; ""; "VALUE")
$FHWACodes_txt:=ut_GetSysParameter("SIA_DESLOADCODE_FHWA"; ""; "VALUE")
ARRAY TEXT:C222(<>MHDItm31Codes_atxt; 0)
ARRAY TEXT:C222(<>FHWAItm31Codes_atxt; 0)
ut_TextToArray($MHDCodes_txt; -><>MHDItm31Codes_atxt; ",")
ut_TextToArray($FHWACodes_txt; -><>FHWAItm31Codes_atxt; ",")

C_TEXT:C284(<>D6TownList_txt)
<>D6TownList_txt:="Boston;Braintree;Brookline;Cambridge;Canton;Chelsea;Dedham;Dover;Milton;Needham;N"+"ewton;Quincy;Randolph;Watertown;Wellesley;Weston;Westwood;Weymouth;Win"+"throp"

C_TEXT:C284(<>SIA_LoadRtg_63_MT_txt; <>SIA_LoadRtg_63_RF_txt)
<>SIA_LoadRtg_63_MT_txt:=ut_GetSysParameter("SIA_LoadRtg_63_MT"; ";0;1;2;3;4;5;A;B;C;"; "VALUE")
<>SIA_LoadRtg_63_RF_txt:=ut_GetSysParameter("SIA_LoadRtg_63_RF"; ";6;7;8;D;E;F;"; "VALUE")

ut_defineBrgCondRtg

ControlMenuBar(1)