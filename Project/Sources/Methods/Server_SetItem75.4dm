//%attributes = {"invisible":true}
//Method: Server_SetItem75
//Description
//  ` copied from M_SetItem75 - modified to run on server
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/13/13, 16:52:32
	// ----------------------------------------------------
	//Created : 
	Mods_2013_05
	// Modified by: Costas Manousakis-(Designer)-(9/3/20 10:22:20)
	Mods_2020_09_bug
	//  `change the message folder name to include the server IP and port number
End if 
//
//TRACE
//*****  Need special characters, tab cr etc
Startup_PL
INIT_UI_GV

C_LONGINT:C283($Option_L)
C_LONGINT:C283($i; $Recs; $Interval; $total)  //Command Replaced was o_C_INTEGER
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

QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)

If ($Option_L<3)
	ITM75_SaveData_L:=0
	READ WRITE:C146([Bridge MHD NBIS:1])
	
	Case of 
		: ((Application type:C494=4D Remote mode:K5:5) & (Structure file:C489="MHD BMS.@"))
			ITM75_SaveData_L:=1
			
		: ((Application type:C494=4D Server:K5:6) & (<>DatabaseStructureName_txt="MHD BMS"))
			ITM75_SaveData_L:=1
	End case 
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
	//_ O _SET DOCUMENT TYPE($ReportFile_txt;"TEXT")
	//_ O _SET DOCUMENT CREATOR($ReportFile_txt;"????")
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
	
	$Recs:=Records in selection:C76([Bridge MHD NBIS:1])
	$total:=$Recs
	$Interval:=MaxNum(MinNum(Int:C8($Recs/40); 20); 1)  // get an update interval between 1 and 20
	FIRST RECORD:C50([Bridge MHD NBIS:1])
	//on server we need the array pointers
	ARRAY POINTER:C280(ptr_Changes; 0; 0)
	InitChangeStack(1)
	For ($i; 1; $Recs)
		If (ut_LoadRecordonServer(->[Bridge MHD NBIS:1]; 2))
			SET_Item75
			If (ITM75_SaveData_L=1)
				PushAllChanges(1; ->[Bridge MHD NBIS:1]; ->[Bridge MHD NBIS:1]BIN:3)
				FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
				SAVE RECORD:C53([Bridge MHD NBIS:1])
			End if 
		End if 
		NEXT RECORD:C51([Bridge MHD NBIS:1])
		If ($i%$Interval)=0
			//FLUSH CACHE
		End if 
	End for 
	//Close Message file
	ut_CloseMessage
	ut_SetMessageDir($messageDir_txt)
	CLOSE DOCUMENT:C267(ITEM75Report_F)
	
End if 

//End Server_SetItem75