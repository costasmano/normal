//%attributes = {"invisible":true}
If (False:C215)
	Mods_2005_CM06
	// Modified by: costasmanousakis-(Administrator)-(11/7/2005 11:48:46)
	Mods_2005_CM18
	// Modified by: costasmanousakis-(Designer)-(11/30/2005 15:30:17)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(1/30/2006 12:16:22)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(1/31/2006 14:36:26)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(8/28/2006 15:41:42)
	Mods_2006_CM06
	// Modified by: costasmanousakis-(Designer)-(8/13/2007 14:12:40)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(11/5/2007 11:29:12)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(1/25/08 12:05:44)
	Mods_2007_CM_5401
	//Use Method ut_WarmUpDatabase
	Mods_2009_03  //CJM  r001   `03/06/09, 13:04:33`Upgrade from open form window to open window
	// Modified by: costasmanousakis-(Designer)-(4/21/09 20:11:32)
	Mods_2009_04
	//  `Place WildCard around "MHD BMS External" to account for the new .4Dx extensions in 2004
	// Modified by: costasmanousakis-(Designer)-(6/25/09 09:30:05)
	Mods_2009_06
	//  ` For Designer center the splash screen window
	Mods_2009_10  //v451 r001 CJ Miller`10/22/09, 11:50:43   `Add check to make sure triggers run only on inside data base
	Mods_2009_10  //v451 r001 CostasManousakis `Moved the splash screen resizer to all users
	// Modified by: costasmanousakis-(Designer)-(8/16/10 08:19:48)
	Mods_2010_08
	//  `Added District 6 to the launch of initial windows
	Mods_2011_05  //r002 CJ Miller`05/10/11, 17:25:28      `Add code ◊NextNumberArray_al to set up for v11
	Mods_2011_06  // CJ Miller`06/13/11, 16:43:54      ` Type all local variables for v11
	// Modified by: costasmanousakis-(Designer)-(12/2/11 09:40:16)
	Mods_2011_12
	//  `Modified code that stores machinename to include last date and count of logins from that machine
	// Modified by: Costas Manousakis-(Designer)-(11/1/13 07:50:07)
	Mods_2013_11
	//  `Move the trace if designer to the database On Startup method
	// Modified by: Costas Manousakis-(Designer)-(8/22/14 10:45:22)
	Mods_2014_08
	//  `Exclude designer and Administrator from the group checks allowing users to connect
	// Modified by: Costas Manousakis-(Designer)-(11/4/15 12:38:44)
	Mods_2015_11_bug
	//  `should not initialize ◊NextNumberArray_al ; done in "on Startup"
	// Modified by: Costas Manousakis-(Designer)-(9/22/17 11:31:28)
	Mods_2017_09
	//  `remove call to ut_ResetIPToServer
	// Modified by: Costas Manousakis-(Designer)-(11/20/18 09:57:21)
	Mods_2018_11
	//  `use system parameter MADOTBMSContact for contact
	// Modified by: Costas Manousakis-(Designer)-(3/28/19 12:28:48)
	Mods_2019_03_bug
	//  `call method ut_ResetPathToServer
	
	Mods_2019_04  //Change so that we use G_SortTable_new instead of ut_RetrieveTableArrDoc 
	//Modified by: Chuck Miller (4/2/19 15:17:59)
	// Modified by: Costas Manousakis-(Designer)-(3/18/21 16:41:39)
	Mods_2021_03
	//  `use method PERS_UpdateLoginStats to collect login stats
	// Modified by: Costas Manousakis-(Designer)-(2022-01-12T00:00:00 15:59:21)
	Mods_2022_01
	//  `no need to call ut_ResetPathToServer
	// Modified by: Costas Manousakis-(Designer)-(2022-03-24 18:16:00)
	Mods_2022_03
	//  `when checking for user access allow any active user to connect to a server - now we have only one server
End if 

//ut_ResetIPToServer (Application file)
//ut_ResetPathToServer 

C_TEXT:C284(<>SavedMethodFolder_txt)
<>SavedMethodFolder_txt:="MHD_BMS_Dev_Source"
C_LONGINT:C283(<>LSplashWinID)
<>LSplashWinID:=Frontmost window:C447

C_TEXT:C284(<>DatabaseStructureName_txt)
//SET PLATFORM INTERFACE(0)  `Use Mac interface: white background.
HIDE TOOL BAR:C434
C_LONGINT:C283($ScrHt; $ScrW; $WTop; $WLeft; $Wbot; $Wright; $WWidt; $WHt)
$ScrHt:=Screen height:C188
$ScrW:=Screen width:C187
GET WINDOW RECT:C443($Wleft; $Wtop; $WRight; $Wbot)
C_PICTURE:C286($Splash_pic)
//GET PICTURE FROM LIBRARY("BMS Splash Image"; $Splash_pic)
READ PICTURE FILE:C678("\\Resources\\Images\\library\\BMS Splash Image.png"; $Splash_pic)
PICTURE PROPERTIES:C457($Splash_pic; $WWidt; $WHt)
$Splash_pic:=$Splash_pic*0
$Wleft:=($ScrW-$WWidt)/2
$Wtop:=($ScrHt-$WHt)/2
SET WINDOW RECT:C444($Wleft; $Wtop; ($Wleft+$WWidt); ($Wtop+$WHt))

//If (Application type=4D Remote mode)

//ut_ClearSavedPassword (GetPath (Application file))
//End if 
Startup_PL  //Get Platform info.
C_BOOLEAN:C305($vbExtServer; $vbExtUser; $vbDbgCheck; $vbDesAccess; $vbExtInternal; $NotDesOrAdm_b; $ActiveUser_b)
C_TEXT:C284($msg)
If (False:C215)
	//Using 4D Client connecting to External server
	$vbExtServer:=((Structure file:C489="MHD BMS External") & (Application type:C494=4D Remote mode:K5:5))
Else 
	$vbExtServer:=(Structure file:C489="@MHD BMS External@")
End if 
$vbDesAccess:=User in group:C338(Current user:C182; "Design Access Group")
$NotDesOrAdm_b:=(Current user:C182#"Designer") & (Current user:C182#"Administrator")
$vbExtInternal:=User in group:C338(Current user:C182; "ExternalInternal")
$vbExtInternal:=$vbExtInternal | $vbDesAccess
$vbExtUser:=(User in group:C338(Current user:C182; "ExternalInspectors") | User in group:C338(Current user:C182; "ExternalDesigners"))
$ActiveUser_b:=User in group:C338(Current user:C182; "ActiveUsers")
$vbDbgCheck:=True:C214  //set to true to enable the case statements
C_TEXT:C284($BMSContact_txt)
$BMSContact_txt:=ut_GetSysParameter("MADOTBMSContact"; "Constantine Manousakis - MassDOT/Bridge Section - Tel 978-368-9402.")

Case of 
	: (Not:C34($ActiveUser_b) & $NotDesOrAdm_b)
		//Log-out inactive users...  
		$msg:="User <"+Current user:C182+"> has been de-activated in Database"+Char:C90(13)
		$msg:=$msg+"<"+Structure file:C489+"> !"+Char:C90(13)
		$msg:=$msg+"If you have any questions contact :"+Char:C90(13)
		$msg:=$msg+$BMSContact_txt+Char:C90(13)
		$msg:=$msg+"QUITTING 4D NOW..."
		ALERT:C41($msg)
		QUIT 4D:C291
		
		// ****
		// ****  only one server accesible by all
		// ****
		
		//: (($vbExtServer & Not($vbExtUser | $vbExtInternal)) & $vbDbgCheck & $NotDesOrAdm_b)
		//$msg:="User <"+Current user+"> is not allowed to connect to Database"+Char(13)
		//$msg:=$msg+"<"+Structure file+"> !"+Char(13)
		//$msg:=$msg+"If you have any questions contact :"+Char(13)
		//$msg:=$msg+$BMSContact_txt+Char(13)
		//$msg:=$msg+"QUITTING 4D NOW..."
		//ALERT($msg)
		//QUIT 4D
		
		//: ((Not($vbExtServer) & ($vbExtUser & Not($vbExtInternal))) & $vbDbgCheck & $NotDesOrAdm_b)
		//$msg:="User <"+Current user+"> is not allowed to connect to Database"+Char(13)
		//$msg:=$msg+"<"+Structure file+"> !"+Char(13)
		//$msg:=$msg+"If you have any questions contact :"+Char(13)
		//$msg:=$msg+$BMSContact_txt+Char(13)
		//$msg:=$msg+"QUITTING 4D NOW..."
		//ALERT($msg)
		//QUIT 4D
		
	Else 
		SHORT_MESSAGE("Initializing. Please Wait...")
		ut_SetUpBridgeInfoLinkTable  //This code will add [BridgeInfoLink] records if any do not exist
		CLOSE WINDOW:C154
		C_LONGINT:C283($tempwin)
		$tempwin:=Open window:C153(((Screen width:C187/2)-150); ((Screen height:C188/2)-15); ((Screen width:C187/2)+150); ((Screen height:C188/2)+15); Regular window:K27:1)
		C_LONGINT:C283($vrMillisecondsSt)
		$vrMillisecondsSt:=Milliseconds:C459
		
		C_BOOLEAN:C305($DisplayStartTime_b)
		$DisplayStartTime_b:=False:C215
		C_TIME:C306($StartTime; $EndTime; $EndInitUIGV; $EndInitUIArrays; $EndInitFields; $EndInitTown; $EndInitPers; $EndInitBMS; $EndSortTable; $EndInitFields_1)
		C_LONGINT:C283($EndInitUIGV_L; $EndInitUIArrays_L; $EndInitFields_L; $EndInitTown_L; $EndInitPers_L; $EndInitBMS_L; $EndSortTable_L; $EndTime_L; $EndInitFields_1_L)
		If (Shift down:C543)
			$DisplayStartTime_b:=True:C214
		End if 
		
		$StartTime:=Current time:C178
		SET ABOUT:C316("About NBIS Bridge Inspection Management System…"; "About")
		MESSAGE:C88(Char:C90(13)+"  Interproc arrays...."+String:C10(Milliseconds:C459-$vrMillisecondsSt))
		ut_BarCodeFontSetup
		INIT_UI_GV  //Initialize interprocess variables for this application
		QUERY:C277([Personnel:42]; [Personnel:42]UserID_4D:12=<>CurrentUser_UID)
		If (Records in selection:C76([Personnel:42])=1)
			PERS_UpdateLoginStats
			
		End if 
		$EndInitUIGV:=Current time:C178
		$EndInitUIGV_L:=Milliseconds:C459-$vrMillisecondsSt
		
		MESSAGE:C88(Char:C90(13)+"  UI arrays...."+String:C10(Milliseconds:C459-$vrMillisecondsSt))
		C_LONGINT:C283($LocalProcessl_l)
		$LocalProcessl_l:=LSpawnProcess("ut_UpdateLocalDictionary"; <>LStackSize; "$Update Local Dictionary"; True:C214; False:C215)
		
		INIT_UI_ARRAYS  //Load arrays for user interface
		$EndInitUIArrays:=Current time:C178
		$EndInitUIArrays_L:=Milliseconds:C459-$vrMillisecondsSt
		MESSAGE:C88(Char:C90(13)+"  Town Data arrays...."+String:C10(Milliseconds:C459-$vrMillisecondsSt))
		//INIT_TOWN_DATA   `Load text file for converting BDEPT to Town names
		ut_RetrieveTOWNDATADoc
		$EndInitTown:=Current time:C178
		$EndInitTown_L:=Milliseconds:C459-$vrMillisecondsSt
		MESSAGE:C88(Char:C90(13)+"  Field Descr arrays...."+String:C10(Milliseconds:C459-$vrMillisecondsSt))
		//begin changes  Mods_2004_CJM03 
		ut_RetrieveBlobDocument
		// INIT_FIELDS_DES   `Load description data for fields from tables
		//end changes  Mods_2004_CJM03 
		$EndInitFields:=Current time:C178
		$EndInitFields_L:=Milliseconds:C459-$vrMillisecondsSt
		Init_Fields_DES1  //Load description data for fields from lists
		
		$EndInitFields_1:=Current time:C178
		$EndInitFields_1_L:=Milliseconds:C459-$vrMillisecondsSt
		MESSAGE:C88(Char:C90(13)+"  Personnel arrays...."+String:C10(Milliseconds:C459-$vrMillisecondsSt))
		//InitPers   `Load Personnel data.    Also called from GP InitProcessVar.
		ut_RetrievePersArraysDoc
		$EndInitPers:=Current time:C178
		$EndInitPers_L:=Milliseconds:C459-$vrMillisecondsSt
		MESSAGE:C88(Char:C90(13)+"  BMS arrays...."+String:C10(Milliseconds:C459-$vrMillisecondsSt))
		INIT_BMS  //Load BMS data.    Also called from GP InitProcessVar.
		$EndInitBMS:=Current time:C178
		$EndInitBMS_L:=Milliseconds:C459-$vrMillisecondsSt
		// make sure Fields in Bridge MHD NBIS table are shown in alphabetical order
		//   added Jan-2001 : CM
		MESSAGE:C88(Char:C90(13)+"  Sorting tables...."+String:C10(Milliseconds:C459-$vrMillisecondsSt))
		//G_SortTable_new   `new ver sorts all tables with more than 10 fields
		C_BOOLEAN:C305($v_SortTables_b)
		$v_SortTables_b:=True:C214
		If (Shift down:C543)
			
			If (Current user:C182="Designer")
				CONFIRM:C162("Do you want to have tables and fields sorted?"; "Sort"; "Unsorted")
				$v_SortTables_b:=(OK=1)
			End if 
			
		End if 
		If ($v_SortTables_b)
			G_SortTable_new
			//ut_RetrieveTableArrDoc 
		End if 
		
		$EndSortTable:=Current time:C178
		$EndSortTable_L:=Milliseconds:C459-$vrMillisecondsSt
		//G_Hide_ConsltRatingCost_Table 
		
		MESSAGE:C88(Char:C90(13)+"  Loading menus...."+String:C10(Milliseconds:C459-$vrMillisecondsSt))
		If (User in group:C338(Current user:C182; "Access Level 1")=False:C215)
			InitFilePalette
			Case of 
				: (User in group:C338(Current user:C182; "MTA")=True:C214)
					M_MTA
				: (User in group:C338(Current user:C182; "MDC")=True:C214)
					M_MDC
				: (User in group:C338(Current user:C182; "MBTA")=True:C214)
					M_MBTA
				: (User in group:C338(Current user:C182; "MassPort")=True:C214)
					M_MPA
			End case 
		Else 
			If (User in group:C338(Current user:C182; "Access Level 1")=True:C214)
				Case of 
					: (User in group:C338(Current user:C182; "District 1")=True:C214)
						M_DISTRICT1
					: (User in group:C338(Current user:C182; "District 2")=True:C214)
						M_DISTRICT2
					: (User in group:C338(Current user:C182; "District 3")=True:C214)
						M_DISTRICT3
					: (User in group:C338(Current user:C182; "District 4")=True:C214)
						M_DISTRICT4
					: (User in group:C338(Current user:C182; "District 5")=True:C214)
						M_DISTRICT5
					: (User in group:C338(Current user:C182; "District 6")=True:C214)
						M_DISTRICT6
					: (User in group:C338(Current user:C182; "MTA")=True:C214)
						M_MTA
					: (User in group:C338(Current user:C182; "MDC")=True:C214)
						M_MDC
					: (User in group:C338(Current user:C182; "MBTA")=True:C214)
						M_MBTA
					: (User in group:C338(Current user:C182; "MassPort")=True:C214)
						M_MPA
				End case 
			End if 
		End if 
		
		MESSAGE:C88(Char:C90(13)+"  Clean Up...."+String:C10(Milliseconds:C459-$vrMillisecondsSt))
		G_CloseAllTables
		//ON ERR CALL("ERR_SpellCheckErr")
		//G_SpellCheckSetup
		//ON ERR CALL("")
		CLOSE WINDOW:C154
		If (Application type:C494#4D Remote mode:K5:5)
			ChkActLogQueue
		End if 
		$EndTime:=Current time:C178
		$EndTime_L:=Milliseconds:C459-$vrMillisecondsSt
		If ($DisplayStartTime_b)
			C_TEXT:C284($Msg_txt)
			$Msg_txt:="Start up began "+String:C10($StartTime)+Char:C90(13)
			$Msg_txt:=$Msg_txt+"INIT_UI_GV ended "+String:C10($EndInitUIGV)+" Elapsed "+String:C10($EndInitUIGV-$StartTime)+" - "+String:C10($EndInitUIGV_L)+Char:C90(13)
			$Msg_txt:=$Msg_txt+"INIT_UI_ARRAYS "+String:C10($EndInitUIArrays)+" Elapsed "+String:C10($EndInitUIArrays-$EndInitUIGV)+" - "+String:C10($EndInitUIArrays_L-$EndInitUIGV_L)+Char:C90(13)
			$Msg_txt:=$Msg_txt+"INIT_TOWN_DATA "+String:C10($EndInitTown)+" Elapsed "+String:C10($EndInitTown-$EndInitUIArrays)+" - "+String:C10($EndInitTown_L-$EndInitUIArrays_L)+Char:C90(13)
			$Msg_txt:=$Msg_txt+"INIT_FIELDS_DES "+String:C10($EndInitFields)+" Elapsed "+String:C10($EndInitFields-$EndInitTown)+" - "+String:C10($EndInitFields_L-$EndInitTown_L)+Char:C90(13)
			$Msg_txt:=$Msg_txt+"INIT_FIELDS_DES1 "+String:C10($EndInitFields_1)+" Elapsed "+String:C10($EndInitFields_1-$EndInitFields)+" - "+String:C10($EndInitFields_1_L-$EndInitFields_L)+Char:C90(13)
			$Msg_txt:=$Msg_txt+"InitPers "+String:C10($EndInitPers)+" Elapsed "+String:C10($EndInitPers-$EndInitFields_1)+" - "+String:C10($EndInitPers_L-$EndInitFields_1_L)+Char:C90(13)
			$Msg_txt:=$Msg_txt+"INIT_BMS "+String:C10($EndInitBMS)+" Elapsed "+String:C10($EndInitBMS-$EndInitPers)+" - "+String:C10($EndInitBMS_L-$EndInitPers_L)+Char:C90(13)
			$Msg_txt:=$Msg_txt+"G_SortTable_new "+String:C10($EndSortTable)+" Elapsed "+String:C10($EndSortTable-$EndInitBMS)+" - "+String:C10($EndSortTable_L-$EndInitBMS_L)+Char:C90(13)
			$Msg_txt:=$Msg_txt+"Start up Ended "+String:C10($EndTime)+" Elapsed "+String:C10($EndTime-$EndSortTable)+" - "+String:C10($EndTime_L-$EndSortTable_L)+Char:C90(13)
			$Msg_txt:=$Msg_txt+"Total elapsed time "+String:C10($EndTime-$StartTime)+" - "+String:C10($EndTime_L)+Char:C90(13)
			//  ALERT($Msg_txt)
			Msg:=$Msg_txt
			
			C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
			C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
			C_TEXT:C284($Title_txt)
			FORM GET PROPERTIES:C674([Dialogs:21]; "stats"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
			$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; 0; $Title_txt; "ut_CloseCancel")
			//$ref:=Open form window([Dialogs];"stats";0)
			DIALOG:C40([Dialogs:21]; "stats")
			CLOSE WINDOW:C154($Win_l)
		End if 
		
		If (User in group:C338(Current user:C182; "READWRITE"))
			ut_WarmUpDatabase
		End if 
		//ut_UnloadAllTables ("S")
		
End case   //end of active user startup