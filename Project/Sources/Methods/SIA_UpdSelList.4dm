//%attributes = {"invisible":true}
//SIA_UpdSelList  Renamed from TEMP_UpdSelList
//This procedure updates the Select List.
If (False:C215)
	//GP TEMP_UpdSelList
	
	//Modified 
	//2-10-2000 : CM
	//    Adjust logic to recognize files with records ending either in CRLF or CR.
	//31-Jan-1
	// Changed to use new Item8 instead of BIN+Bridgekey
	//21-Aug-201
	//Fixes for new way of transmittal by the FHWA. They send an excel
	//spreadsheet. We extract a tab-delimited file with Item 8 and AASHTO rating only.
	//BIN is incorporated in Item8 now. Add a check for Brkey if Item8 not found. this
	//mainly for FHWA records
	
	// Modified by: costasmanousakis-(Designer)-(9/22/08 14:01:09)
	Mods_2008_CM_5404  // ("SELECTLIST")
	//  `Adjust to receive the download from the FHWA UPACS site. Receive the Current Year Select List report.
	//  `Will use the column Fed Agency. Will not use the BIN as a last check
	//  `Columns needed are : Fed Agency (Y/N column), Item 8, Sufficiency rating
	//  `Also enhanced the case of locked records. Will give a chance to keep trying to update the
	//  `locked records, and if cancel will write the unchanged item8s with what they're supposed to be.
	//  `Open the input file in Read mode.
	//  `The report file now gets a timestamp in the name.
	//  `Add some progress messages.
	//  `At the end unload records and clear selection.
	
	// Modified by: costasmanousakis-(Designer)-(1/11/10 16:03:02)
	Mods_2010_01
	//  `Added use of BIN in case Item 8 does not match. First check is BIN , then try for BRKEY; This is controlled
	//  `by  a prompt at the start of the run.  Addeda more detailed Confirm statement at the end using method
	//  `G_MyConfirm
	// Modified by: costasmanousakis-(Designer)-(11/23/10 12:09:26)
	Mods_2010_11
	//  `Added Alert at the end to adjust parameter FHWASELECT_INFO in Parameters table
	// Modified by: costasmanousakis-(Designer)-(2/7/11 09:16:40)
	Mods_2011_02
	//  `Presize the $aItem8;$aAASHTO... arrays to Records in selection([Bridge MHD NBIS]); use one Sele to Array command
	//  `Renamed to SIA_UpdSelList
	// Modified by: costasmanousakis-(Designer)-(10/31/11 12:48:52)
	Mods_2011_10
	//  `Adde code to update parameter FHWASELECT_INFO and log the changes to the Parameter.
	// Modified by: Costas Manousakis-(Designer)-(10/11/16 16:29:28)
	Mods_2016_10
	//  `adjusted sequence of Flushgrpchanges and Save record for [Parameters]; open report at the end
	// Modified by: Costas Manousakis-(Designer)-(10/11/16 17:39:25)
	Mods_2016_10
	//  ` write the $summary text in the report file
	// Modified by: Costas Manousakis-(Designer)-(10/12/17 16:04:00)
	Mods_2017_10
	//  `Save FHWASELECT_Info parameter in XML format in Description instead of VALUE
	//  // Added info at the start of the report about the application name, structure, data file, and server IP/port and name of file loaded
	// Modified by: Costas Manousakis-(Designer)-(10/20/17 16:38:04)
	Mods_2017_10
	//  `Added making logchanges for the changed records - using the new progress bar
End if 

C_TEXT:C284($text; $path; $file)
C_TEXT:C284($Item8; $AASHTO; $BrKey; $BIN; $FedAgency)  // Command Replaced was o_C_STRING length was 20
C_LONGINT:C283($i; $j; $k; $recs; $TotalValid_L; $TotalNew_L; $TotalWarn_L; $TotalRemoved_L)
C_BOOLEAN:C305($PrintWarn)
C_TIME:C306($dImportFile; $dUpdateRpt)  //21-Aug-2001 : added for correctness
C_DATE:C307($UpacsDate_d; $ImportDate_d)
C_TEXT:C284($OldValue_txt; $NewValue_txt)

$text:="In the following dialog box, select the tab-delimited "
$text:=$text+"text file containing the Select List."+(2*<>sCR)
$text:=$text+"Each record should consist of an Fed Agency(Y/N),  Item 8, and an AASHTO rating."
ALERT:C41($text)

$dImportFile:=Open document:C264(""; "TEXT"; Read mode:K24:5)

If (OK=1)
	$path:=GetPath
	$text:="Select List Update Report"+(1*<>sCR)
	$text:=$text+"Input  : "+Document+(1*<>sCR)
	$text:=$text+"Application : "+Application file:C491+(1*<>sCR)
	$text:=$text+"Structure : "+Structure file:C489+(1*<>sCR)
	$text:=$text+"Data : "+Data file:C490+(1*<>sCR)
	$text:=$text+"Server IP : Port : "+G_GetServerTCP+":"+String:C10(Get database parameter:C643(Client Server port ID:K37:35))+(2*<>sCR)
	//try ot get the date from the file name usually "SelectionList_25 YYYY_MM_DD.txt"
	C_BOOLEAN:C305($match_b)
	ARRAY LONGINT:C221($pos_aL; 0)
	ARRAY LONGINT:C221($len_aL; 0)
	$match_b:=Match regex:C1019("SelectionList_25 (\\d{4})_(\\d{2})_(\\d{2})"; Document; 1; $pos_aL; $len_aL)
	If ($match_b)
		If (Size of array:C274($pos_aL)=3)
			//got 3 parts for a date
			$UpacsDate_d:=Add to date:C393(!00-00-00!; Num:C11(Substring:C12(Document; $pos_aL{1}; $len_aL{1})); Num:C11(Substring:C12(Document; $pos_aL{2}; $len_aL{2})); Num:C11(Substring:C12(Document; $pos_aL{3}; $len_aL{3})))
		End if 
	End if 
	$file:=$path+"SelListRpt"+ut_CreateTimeStamp+".txt"
	$dUpdateRpt:=Create document:C266($file; "TEXT")
	SEND PACKET:C103($dUpdateRpt; $text)
	//TRACE
	ALL RECORDS:C47([Bridge MHD NBIS:1])
	$recs:=Records in selection:C76([Bridge MHD NBIS:1])
	ARRAY TEXT:C222($aItem8; $recs)  //Mar-2003 : added for correctness//Command Replaced was o_ARRAY string length was 15
	ARRAY REAL:C219($aAASHTO; $recs)  //Mar-2003 : added for correctness
	ARRAY BOOLEAN:C223($aXSelect; $recs)  //Mar-2003 : added for correctness
	ARRAY TEXT:C222($aBrKey; $recs)  //Mar-2003 : added for correctness//Command Replaced was o_ARRAY string length was 12
	ARRAY TEXT:C222($aBIN; $recs)  //Aug-2003 : //Command Replaced was o_ARRAY string length was 3
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item8:206; $aItem8; [Bridge MHD NBIS:1]AASHTO:5; $aAASHTO; [Bridge MHD NBIS:1]FHWA Select:4; $aXSelect; [Bridge MHD NBIS:1]Bridge Key:2; $aBrKey; [Bridge MHD NBIS:1]BIN:3; $aBIN)
	ARRAY BOOLEAN:C223($aSelect; Size of array:C274($aXSelect))
	
	$i:=0
	$TotalValid_L:=0
	$TotalNew_L:=0
	$TotalWarn_L:=0
	$TotalRemoved_L:=0
	ARRAY TEXT:C222($ModBINs_atxt; 0)
	SHORT_MESSAGE("Reading File...")
	RECEIVE PACKET:C104($dImportFile; $FedAgency; <>sTab)
	C_BOOLEAN:C305($UseBINCheck_b)
	$UseBINCheck_b:=True:C214
	CONFIRM:C162("Should the discrepancies between Item 8 in input file and Item 8 in MHD BMS be re"+"solved by BIN substring?")
	$UseBINCheck_b:=(OK=1)
	
	While (OK=1)
		// 2-10-2000 : CM  
		// Modified to account for CRLF or Just CR record delimited files
		If (Substring:C12($FedAgency; 1; 1)=<>sLF)
			$FedAgency:=Substring:C12($FedAgency; 2)
		End if 
		
		$i:=$i+1
		RECEIVE PACKET:C104($dImportFile; $Item8; <>sTab)
		RECEIVE PACKET:C104($dImportFile; $AASHTO; <>sCR)
		
		$j:=Find in array:C230($aItem8; $Item8)
		If ($j<0)
			//1st check if we have a BIN match
			If ($UseBINCheck_b)
				$BIN:=Substring:C12($Item8; 7; 3)
				$j:=Find in array:C230($aBIN; $BIN)
				
			End if 
			If ($j<0)
				//Check if we have a bridge key match    
				$BrKey:=Substring:C12($Item8; 4)
				$j:=Find in array:C230($aBrKey; $BrKey)
				
			End if 
		End if 
		If ($j<0)
			If ($FedAgency="Y")
				//FED record
				For ($k; 1; Size of array:C274($aBrKey))
					If (Substring:C12($Item8; 10)=Substring:C12($aBrKey{$k}; 7))
						$j:=$k
						$k:=Size of array:C274($aBrKey)+1
					End if 
				End for 
			End if 
		End if 
		
		$text:=""
		$PrintWarn:=False:C215
		If ($j>0)
			$TotalValid_L:=$TotalValid_L+1
			$aSelect{$j}:=True:C214
			If ($Item8#$aItem8{$j})
				$text:=$text+"≠"+$aItem8{$j}
				$PrintWarn:=True:C214
			End if 
			$text:=$text+<>sTab  //This tab will help things line up properly.
			If (Abs:C99(Num:C11($AASHTO)-$aAASHTO{$j})>0.05)
				$text:=$text+$AASHTO+"≠"+String:C10(Round:C94($aAASHTO{$j}; 3))
				$PrintWarn:=True:C214
			End if 
			If ($PrintWarn)
				$TotalWarn_L:=$TotalWarn_L+1  //Some discrepancy between Item8 and/or AASHTO
			End if 
			
			If ($aXSelect{$j})
				//Reset this so the only ones left are the ones that
				//have been removed from the Select List.
				$aXSelect{$j}:=False:C215
			Else 
				APPEND TO ARRAY:C911($ModBINs_atxt; $aBIN{$j})
				$TotalNew_L:=$TotalNew_L+1
				$text:=$text+<>sTab+"Newly Added to List."
				$PrintWarn:=True:C214
			End if 
		Else 
			$text:=$Item8+<>sTab+"***  Bad Item8, and Bridge key !? ***"
			$PrintWarn:=True:C214
		End if 
		If ($PrintWarn)
			$text:=String:C10($i; "^^^^0")+<>sTab+$Item8+<>sTab+$text+<>sCR
			SEND PACKET:C103($dUpdateRpt; $text)
		End if 
		
		RECEIVE PACKET:C104($dImportFile; $FedAgency; <>sTab)
		If ($i%20=0)
			MESSAGE:C88(String:C10($i)+"..")
		End if 
		
	End while 
	$recs:=$i
	$j:=Find in array:C230($aXSelect; True:C214)
	If ($j>0)
		$text:=<>sCR+"Bridges no longer on the Select List:"+<>sCR
		SEND PACKET:C103($dUpdateRpt; $text)
		While ($j>0)
			$TotalRemoved_L:=$TotalRemoved_L+1
			APPEND TO ARRAY:C911($ModBINs_atxt; $aBIN{$j})
			$text:=<>sTab+$aItem8{$j}+<>sCR
			SEND PACKET:C103($dUpdateRpt; $text)
			$j:=Find in array:C230($aXSelect; True:C214; $j+1)
		End while 
	End if 
	
	MESSAGE:C88(<>sCR+"Applying Changes...")
	START TRANSACTION:C239
	ARRAY TO SELECTION:C261($aSelect; [Bridge MHD NBIS:1]FHWA Select:4)
	$j:=Records in set:C195("LockedSet")
	CLOSE WINDOW:C154
	While ($j>0)
		TRACE:C157
		USE SET:C118("LockedSet")
		CONFIRM:C162("There were "+String:C10($j)+" locked records! Try again?")
		If (OK=1)
			ARRAY BOOLEAN:C223($aLockedSel; $j)
			FIRST RECORD:C50([Bridge MHD NBIS:1])
			For ($i; 1; $j)
				$k:=Find in array:C230($aItem8; [Bridge MHD NBIS:1]Item8:206)
				$aLockedSel{$i}:=$aSelect{$k}
				NEXT RECORD:C51([Bridge MHD NBIS:1])
			End for 
			ARRAY TO SELECTION:C261($aLockedSel; [Bridge MHD NBIS:1]FHWA Select:4)
			$j:=Records in set:C195("LockedSet")
		Else 
			$text:=<>sCR+"Bridges with Select List status not updated :"+<>sCR
			SEND PACKET:C103($dUpdateRpt; $text)
			FIRST RECORD:C50([Bridge MHD NBIS:1])
			For ($i; 1; $j)
				$k:=Find in array:C230($aItem8; [Bridge MHD NBIS:1]Item8:206)
				$text:=<>sTab+[Bridge MHD NBIS:1]Item8:206+<>sTab+f_Boolean2String($aSelect{$k}; "YN")+<>sCR
				SEND PACKET:C103($dUpdateRpt; $text)
				//remove the bin from the list that have been modified
				$k:=Find in array:C230($ModBINs_atxt; $aBIN{$k})
				If ($k>0)
					DELETE FROM ARRAY:C228($ModBINs_atxt; $k; 1)
				End if 
				NEXT RECORD:C51([Bridge MHD NBIS:1])
			End for 
			$j:=0  //to exit the while
		End if 
	End while 
	C_TEXT:C284($Summary_txt)
	$Summary_txt:="Read "+String:C10($recs)+" records. Found "+String:C10($TotalValid_L)+" valid records. There were "
	$Summary_txt:=$Summary_txt+String:C10($TotalWarn_L)+" minor discrepancies (Item 8/AASHTO). Found "+String:C10($TotalNew_L)+" new records. "
	$Summary_txt:=$Summary_txt+"There were "+String:C10($TotalRemoved_L)+" BIN records removed from the Select List. "+<>sCR
	$Summary_txt:=$Summary_txt+"Save Select List Update?"
	
	G_MyConfirm($Summary_txt; "Save"; "Cancel")
	If (OK=1)
		//create logchange records for the changes
		If (Size of array:C274($ModBINs_atxt)>0)
			C_LONGINT:C283($loop_L; $Progress_L)
			C_TEXT:C284(vsForward)  //just for interpreted
			$Progress_L:=Progress New
			Progress SET TITLE($Progress_L; "loging changes to "+String:C10(Size of array:C274($ModBINs_atxt))+" BINs")
			Progress SET PROGRESS($Progress_L; 0)
			For ($loop_L; 1; Size of array:C274($ModBINs_atxt))
				QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$ModBINs_atxt{$loop_L})
				If (Records in selection:C76([Bridge MHD NBIS:1])=1)
					FIRST RECORD:C50([Bridge MHD NBIS:1])
					LogChanges(->[Bridge MHD NBIS:1]FHWA Select:4; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
				Else 
					ALERT:C41("Modified BIN "+$ModBINs_atxt{$loop_L}+" not found!?!?!?!?")
				End if 
				Progress SET PROGRESS($Progress_L; $loop_L/Size of array:C274($ModBINs_atxt))
			End for 
			Progress QUIT($Progress_L)
			UNLOAD RECORD:C212([Bridge MHD NBIS:1])
		End if 
		
		VALIDATE TRANSACTION:C240
		$text:=(2*<>sCR)+"Select List Import Completed."+<>sCR
		
		ALERT:C41("REMEMBER TO UPDATE DATABASE PARAMETER FHWASELECT_INFO IN TABLE PARAMETERS!")
		$UpacsDate_d:=Date:C102(Request:C163("Enter UPACS Date of Select List Report"; String:C10($UpacsDate_d)))
		$ImportDate_d:=Date:C102(Request:C163("Enter Import Date of Select List"; String:C10(Current date:C33(*))))
		If (($UpacsDate_d#!00-00-00!) & ($ImportDate_d#!00-00-00!))
			$NewValue_txt:=String:C10(Year of:C25($UpacsDate_d); "0000")+"_"+String:C10(Month of:C24($UpacsDate_d); "00")+"_"+String:C10(Day of:C23($UpacsDate_d); "00")+" : "
			$NewValue_txt:=$NewValue_txt+String:C10(Year of:C25($ImportDate_d); "0000")+"_"+String:C10(Month of:C24($ImportDate_d); "00")+"_"+String:C10(Day of:C23($ImportDate_d); "00")
			$NewValue_txt:="<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\" ?>"
			$NewValue_txt:=$NewValue_txt+"<FHWASELECT_INFO UPACSDate=\""+String:C10($UpacsDate_d)+"\" ImportDate=\""+String:C10($ImportDate_d)+"\" />"
			
			CONFIRM:C162("Change FHWASELECT_INFO value to "+$NewValue_txt+"?")
			
			If (Ok=1)
				QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="FHWASELECT_INFO")
				Case of 
					: (Records in selection:C76([Parameters:107])=1)
						If (ut_LoadRecordInteractive(->[Parameters:107]))
							InitChangeStack(1)
							[Parameters:107]Description:2:=$NewValue_txt
							PushChange(1; ->[Parameters:107]Description:2)
							If (Match regex:C1019("^\\d{4}_\\d{2}_\\d{2} : \\d{4}_\\d{2}_\\d{2}$"; [Parameters:107]Value:3))
								//Value has the old coding - replace it with description
								[Parameters:107]Value:3:="Select list import info. (UPACSDate : ImportDate)"
								PushChange(1; ->[Parameters:107]Value:3)
							End if 
							FlushGrpChgs(1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
							SAVE RECORD:C53([Parameters:107])
							UNLOAD RECORD:C212([Parameters:107])
						Else 
							ALERT:C41("Did not change parameter FHWASELECT_INFO !!!!  Please remember to change it later "+"manually to "+$NewValue_txt+" !!!")
						End if 
					: (Records in selection:C76([Parameters:107])=0)
						InitChangeStack(1)
						CREATE RECORD:C68([Parameters:107])
						[Parameters:107]ParamCode:1:="FHWASELECT_INFO"
						[Parameters:107]Description:2:=$NewValue_txt
						[Parameters:107]Value:3:="Select list import info. (UPACSDate : ImportDate)"
						PushChange(1; ->[Parameters:107]Value:3)
						PushChange(1; ->[Parameters:107]Description:2)
						LogNewRecord(->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0; "PARAMETERS")
						FlushGrpChgs(1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
						SAVE RECORD:C53([Parameters:107])
						UNLOAD RECORD:C212([Parameters:107])
					Else 
						ALERT:C41("ERROR : There were more than one Parameter records found with code FHWASELECT_INFO"+"!!!!")
				End case 
				
			End if 
			
		End if 
		
	Else 
		CANCEL TRANSACTION:C241
		$text:=(2*<>sCR)+"Select List Import Aborted."+<>sCR
	End if 
	SEND PACKET:C103($dUpdateRpt; $Summary_txt)
	SEND PACKET:C103($dUpdateRpt; $text)
	CLOSE DOCUMENT:C267($dUpdateRpt)
	CLOSE DOCUMENT:C267($dImportFile)
	ut_OpenDocument($file)
	
	UNLOAD RECORD:C212([Bridge MHD NBIS:1])
	REDUCE SELECTION:C351([Bridge MHD NBIS:1]; 0)
	
End if 