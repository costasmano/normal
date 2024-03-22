//%attributes = {"invisible":true}
If (False:C215)
	//procedure: M_SetItem75
	// Modified by: costasmanousakis-(Designer)-(3/13/2006 09:45:49)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(11/7/2007 12:11:27)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(12/5/08 08:42:50)
	Mods_2008_CM_5404
	//  `Added code to export various values to a tab delim text file.
	// Modified by: costasmanousakis-(Designer)-(3/31/10 17:07:52)
	Mods_2010_03
	//  `Added code to check for current selection of records.
	//  `and verification of whether to save changes to data.
	// Modified by: costasmanousakis-(Designer)-(3/7/11 08:56:32)
	Mods_2011_03
	//  `Use  ut_OpenDocument instead of AP ShellExecute
	// Modified by: Costas Manousakis-(Designer)-(3/15/19 15:00:11)
	Mods_2019_03_bug
	//  `use new progress bar
	// Modified by: Costas Manousakis-(Designer)-(3/12/20 13:12:31)
	Mods_2020_03_bug
	//  `removed old UpdateProgress call
	// Modified by: Costas Manousakis-(Designer)-(9/3/20 10:22:20)
	Mods_2020_09_bug
	//  `change the message folder name to include the server IP and port number
	// Modified by: Costas Manousakis-(Designer)-(2021-12-07T00:00:00 20:02:39)
	Mods_2021_12_bug
	//  `removed Set doc type and creator commands
End if 

C_LONGINT:C283($i; $Recs; $Interval; $total)  // **replaced _ o _C_INTEGER()
C_LONGINT:C283($wDialog)
C_TEXT:C284($Msg)
C_TIME:C306(dMsgFile)
C_BOOLEAN:C305(bItm75Errors)
C_REAL:C285(ReplaceCost; RehabCost; DeckRepCost)
C_LONGINT:C283(ITM75_SaveData_L)
READ ONLY:C145([Parameters:107])
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="BRG_REPLCOST_AVG")
If (Records in selection:C76([Parameters:107])=1)
	ReplaceCost:=Num:C11([Parameters:107]Value:3)
	RehabCost:=Int:C8(0.75*ReplaceCost)
	DeckRepCost:=Int:C8(0.6*ReplaceCost)
	UNLOAD RECORD:C212([Parameters:107])
End if 
READ WRITE:C146([Parameters:107])
C_LONGINT:C283($w; $h)
FORM GET PROPERTIES:C674([Dialogs:21]; "Item75Costs"; $w; $H)

//$wDialog:=Open form window([Dialogs];"Item75Costs";4)
CENTER_WINDOW($w; $H; 4)
DIALOG:C40([Dialogs:21]; "Item75Costs")
CLOSE WINDOW:C154
C_LONGINT:C283($Option_L)
$Recs:=Records in selection:C76([Bridge MHD NBIS:1])
$Option_L:=ut_3Option_Confirm("Run Item 75 update on current list of "+String:C10($Recs; "##,##0")+" record(s)?"; "Current"; "New Search"; "Cancel")
Case of 
	: ($Option_L=2)
		QUERY:C277([Bridge MHD NBIS:1])
		If (OK=1)
			$Recs:=Records in selection:C76([Bridge MHD NBIS:1])
		Else 
			$Option_L:=3  //Cancel
		End if 
End case 

If ($Option_L<3)
	CONFIRM:C162("Save Calculations to the database?")
	If (OK=1)
		READ WRITE:C146([Bridge MHD NBIS:1])
		ITM75_SaveData_L:=1
	Else 
		ITM75_SaveData_L:=0
	End if 
	C_OBJECT:C1216($serverinfo_o)
	$serverinfo_o:=SYSUTIL_GetServerInfo
	C_TEXT:C284($messageDir_txt)
	$messageDir_txt:="Item75Logs_"+Replace string:C233(OB Get:C1224($serverinfo_o; "ServerIP"; Is text:K8:3); "."; "_")+"_"+OB Get:C1224($serverinfo_o; "ServerPort"; Is text:K8:3)
	
	ut_SetMessageDir($messageDir_txt)
	ut_StartMessage(2; "Item75ErrMessages")
	C_TEXT:C284($msgfile_txt; $ReportFile_txt)
	$msgfile_txt:=Document
	//dMsgFile:=Create document("Item75Messages")
	bItm75Errors:=False:C215
	C_TIME:C306(ITEM75Report_F)
	$ReportFile_txt:=MessageDefDir_txt+"ITEM75Rpt"+ut_CreateTimeStamp+".txt"
	ITEM75Report_F:=Create document:C266($ReportFile_txt; "TEXT")
	//_ O_SET DOCUMENT TYPE($ReportFile_txt;"TEXT")
	//_ O_SET DOCUMENT CREATOR($ReportFile_txt;"????")
	C_TEXT:C284($ExportLine_txt)
	SEND PACKET:C103(ITEM75Report_F; (" Costs "+<>sTAB+"Replacement"+<>sTAB+String:C10(ReplaceCost)+<>sTAB+"$/SqM"+<>sTAB+String:C10(ReplaceCost/10.7639104)+<>sTAB+"$/SqFt"+<>sCR))
	SEND PACKET:C103(ITEM75Report_F; (""+<>sTAB+"Rehab"+<>sTAB+String:C10(RehabCost)+<>sTAB+"$/SqM"+<>sTAB+String:C10(RehabCost/10.7639104)+<>sTAB+"$/SqFt"+<>sCR))
	SEND PACKET:C103(ITEM75Report_F; (""+<>sTAB+"Deck Replacement"+<>sTAB+String:C10(DeckRepCost)+<>sTAB+"$/SqM"+<>sTAB+String:C10(DeckRepCost/10.7639104)+<>sTAB+"$/SqFt"+<>sCR))
	$ExportLine_txt:="Item102"+<>sTAB+"Item51"+<>sTAB+"Item32"+<>sTAB+"Item53"
	$ExportLine_txt:=$ExportLine_txt+<>sTAB+"Item71"+<>STAB+"Item58"+<>STAB+"Item59"
	$ExportLine_txt:=$ExportLine_txt+<>sTAB+"Item60"+<>STAB+"Item62"+<>STAB+"Item66"
	$ExportLine_txt:=$ExportLine_txt+<>sTAB+"Item72"+<>STAB+"Item107"+<>STAB+"Item69"
	$ExportLine_txt:=$ExportLine_txt+<>sTAB+"Item113"+<>STAB+"Item36A"+<>STAB+"Item34"
	$ExportLine_txt:=$ExportLine_txt+<>sTAB+"Item49"+<>STAB+"Item52"+<>STAB+"Item41"
	$ExportLine_txt:=$ExportLine_txt+<>sTAB+"Item29"+<>STAB+"Item28A"
	$ExportLine_txt:="BDEPT"+<>sTAB+"BIN"+<>STAB+"Item8"+<>STAB+"Item7"+<>sTAB+"Item6A"+<>sTab+$ExportLine_txt
	$ExportLine_txt:=$ExportLine_txt+<>sTAB+"Itm75Reason"+<>sTAB+"Item75A"+<>sTAB+"RdwyWidth"
	$ExportLine_txt:=$ExportLine_txt+<>sTAB+"LFReason"+<>sTAB+"Factor/value"+<>sTAB+"Item76"+<>sTAB+"Width"+<>sTAB+"Area"
	$ExportLine_txt:=$ExportLine_txt+<>sTAB+"Cost"+<>sTAB+"Costfactor"+<>sTAB+"Item94"+<>sTAB+"Item95"+<>sTAB+"Item96"
	
	SEND PACKET:C103(ITEM75Report_F; ($ExportLine_txt+<>sCR))
	C_OBJECT:C1216($progress_o)
	//start the bar
	C_OBJECT:C1216($progress_o)
	
	$Recs:=Records in selection:C76([Bridge MHD NBIS:1])
	$total:=$Recs
	$Interval:=MaxNum(MinNum(Int:C8($Recs/40); 20); 1)  // get an update interval between 1 and 20
	$progress_o:=ProgressNew("Updating Item 75"; $Recs; False:C215; " Bridge records"; 3)
	FIRST RECORD:C50([Bridge MHD NBIS:1])
	InitChangeStack(1)
	For ($i; 1; $Recs)
		If (ut_LoadRecordInteractive(->[Bridge MHD NBIS:1]; 2))
			SET_Item75
			If (ITM75_SaveData_L=1)
				PushAllChanges(1; ->[Bridge MHD NBIS:1]; ->[Bridge MHD NBIS:1]BIN:3)
				FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
				SAVE RECORD:C53([Bridge MHD NBIS:1])
			End if 
		End if 
		NEXT RECORD:C51([Bridge MHD NBIS:1])
		If ($i%$Interval)=0
			//UpdateProgress ($i;$Recs)
			//update progress
			UpdateProgressNew($progress_o; $i)
			//FLUSH CACHE
		End if 
		
	End for 
	//quit progress
	Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
	
	//BEEP
	//Close Message file
	ut_CloseMessage
	ut_SetMessageDir($messageDir_txt)
	CLOSE DOCUMENT:C267(ITEM75Report_F)
	
	$Msg:="Item 75 Updated for "+String:C10($total; "####0")+" records!"
	If (bItm75Errors)
		$Msg:=$Msg+<>sCR+"Some Error messages written in file Item75Messages."
		ut_OpenDocument($msgfile_txt)
	End if 
	ALERT:C41($Msg)
	
	CONFIRM:C162("Open the Report file generated ?"; "Open"; "NO")
	If (OK=1)
		ut_OpenDocument($ReportFile_txt)
	End if 
	
End if 