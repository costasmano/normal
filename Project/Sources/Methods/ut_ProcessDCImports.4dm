//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_ProcessDCImports
// User name (OS): charlesmiller
// Date and time: 03/13/09, 13:04:10
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//CJM  r001   `03/13/09, 13:04:13
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

C_LONGINT:C283(gDC_tnum; $cnt; $1; $LastFileNumber_li)  //Begin changes Mods_2003_v324 - 4/21/03  1:42 PM

//$doc:=Open document("")
//CLOSE DOCUMENT($doc)

$cnt:=0
$LastFileNumber_li:=0
SET CHANNEL:C77(10; "")
//BRING TO FRONT(◊Serverprocess)

If (OK=1)
	$WindowTitle_txt:=Document
	C_TEXT:C284($WindowTitle_txt)
	C_LONGINT:C283($Loop_l)
	$Loop_l:=Length:C16($WindowTitle_txt)
	Repeat 
		$Loop_l:=$Loop_l-1
	Until ($WindowTitle_txt[[$Loop_l]]=":")
	$WindowTitle_txt:=Substring:C12($WindowTitle_txt; $Loop_l+1)
	C_LONGINT:C283($Win_l)
	$Win_l:=ut_OpenNewWindow(300; 200; 4; Plain form window:K39:10; $WindowTitle_txt)
	While (OK=1)
		$cnt:=$cnt+1
		//Begin changes Mods_2003_v324 - 4/21/03  1:42 PM
		RECEIVE VARIABLE:C81(gDC_tnum)  //before each record, you'll find the table number
		
		If (($cnt%100)=0)
			ERASE WINDOW:C160
			MESSAGE:C88("Importing File "+Table name:C256(gDC_tnum))
			GOTO XY:C161(5; 2)
			MESSAGE:C88(String:C10($cnt))
		End if 
		If ($LastFileNumber_li#gDC_tnum)
			ERASE WINDOW:C160
			MESSAGE:C88(String:C10($cnt))
			GOTO XY:C161(5; 2)
			MESSAGE:C88("Importing File "+Table name:C256(gDC_tnum))
			$LastFileNumber_li:=gDC_tnum
		End if 
		//End changes Mods_2003_v324
		If (OK=1)
			RECEIVE RECORD:C79(Table:C252(gDC_tnum)->)  //read in the record
			SAVE RECORD:C53(Table:C252(gDC_tnum)->)  //save it away
		End if 
		
	End while 
	SET CHANNEL:C77(11)
End if 
//End ut_ProcessDCImports

