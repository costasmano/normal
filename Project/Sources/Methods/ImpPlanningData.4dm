//%attributes = {"invisible":true}
//proccedure: ImportPlanningData
//created by: Albert Leung
//date: 4/23/97
//purpose: Get data from planning file.
//This is a DOS file so expect CRLF at the end of every record.
//Modified 2-10-2000 : CM
//    Adjusted GOTO XY x param from 6 pixels to 1 character


C_TIME:C306($dImportFile)
C_TEXT:C284($BIN)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($CSN)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284($City_Num)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($RIN)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($ADT)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284($Admin_sys)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($Fedaid_sys)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($Fedaid_ur)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($Func_class)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($Acc_con)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($tbuff)
C_TEXT:C284($sFldDel)  // Command Replaced was o_C_STRING length was 1
C_LONGINT:C283($counter)

ARRAY TEXT:C222($aBIN; 0)  //Command Replaced was o_ARRAY string length was 3

$sFldDel:=","
$dImportFile:=Open document:C264(""; "TEXT")
//Ignore the first line
RECEIVE PACKET:C104($dImportFile; $tbuff; <>sLF)
//First line of data
RECEIVE PACKET:C104($dImportFile; $BIN; $sFldDel)
RECEIVE PACKET:C104($dImportFile; $CSN; $sFldDel)
RECEIVE PACKET:C104($dImportFile; $City_Num; $sFldDel)
RECEIVE PACKET:C104($dImportFile; $RIN; $sFldDel)
RECEIVE PACKET:C104($dImportFile; $ADT; $sFldDel)
RECEIVE PACKET:C104($dImportFile; $Admin_sys; $sFldDel)
RECEIVE PACKET:C104($dImportFile; $Fedaid_sys; $sFldDel)
RECEIVE PACKET:C104($dImportFile; $Fedaid_ur; $sFldDel)
RECEIVE PACKET:C104($dImportFile; $Func_class; $sFldDel)
RECEIVE PACKET:C104($dImportFile; $Acc_con; <>sCR)
RECEIVE PACKET:C104($dImportFile; $tbuff; 1)  //ignore the line feed character

NewWindow(200; 30; 0; 4; "Importing")
$counter:=0
ALL RECORDS:C47([Bridge MHD NBIS:1])
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $aBIN)
While (Ok=1)
	//Process a record
	If ((Length:C16($BIN)=3) & (Blank($BIN)=False:C215))
		GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; Find in array:C230($aBIN; $BIN))
		[Bridge MHD NBIS:1]Item29:88:=Num:C11($ADT)
		[Bridge MHD NBIS:1]Item30:89:=Year of:C25(Current date:C33(*))
		Case of 
			: (($Fedaid_sys="0") | ($Fedaid_sys="7"))
				[Bridge MHD NBIS:1]Item104:119:=False:C215
			: (Position:C15($Fedaid_sys; "1.2.3.4.5.6")>0)
				[Bridge MHD NBIS:1]Item104:119:=True:C214
		End case 
		Case of 
			: (($Fedaid_sys="2") & ([Bridge MHD NBIS:1]Item100:121="0"))
				[Bridge MHD NBIS:1]Item100:121:="1"
		End case 
		Case of 
			: (($Fedaid_ur="5") & ($Func_class="1"))
				[Bridge MHD NBIS:1]Item26:120:="01"
			: ($Func_class="2")
				[Bridge MHD NBIS:1]Item26:120:="02"
			: ($Func_class="3")
				[Bridge MHD NBIS:1]Item26:120:="06"
			: ($Func_class="5")
				[Bridge MHD NBIS:1]Item26:120:="07"
			: ($Func_class="6")
				[Bridge MHD NBIS:1]Item26:120:="08"
			: ($Func_class="0")
				[Bridge MHD NBIS:1]Item26:120:="09"
		End case 
		If (($Fedaid_ur="1") | ($Fedaid_ur="2"))
			Case of 
				: ($Func_class="1")
					[Bridge MHD NBIS:1]Item26:120:="11"
				: (($Acc_con="1") & (($Func_class="2") | ($Func_class="3") | ($Func_class="4")))
					[Bridge MHD NBIS:1]Item26:120:="12"
				: ((($Acc_con="0") | ($Acc_con="2")) & (($Func_class="2") | ($Func_class="3") | ($Func_class="4")))
					[Bridge MHD NBIS:1]Item26:120:="14"
				: ($Func_class="5")
					[Bridge MHD NBIS:1]Item26:120:="16"
				: ($Func_class="6")
					[Bridge MHD NBIS:1]Item26:120:="17"
				: ($Func_class="0")
					[Bridge MHD NBIS:1]Item26:120:="19"
			End case 
		End if 
		SAVE RECORD:C53([Bridge MHD NBIS:1])
	End if 
	//read in a record
	RECEIVE PACKET:C104($dImportFile; $BIN; $sFldDel)
	RECEIVE PACKET:C104($dImportFile; $CSN; $sFldDel)
	RECEIVE PACKET:C104($dImportFile; $City_Num; $sFldDel)
	RECEIVE PACKET:C104($dImportFile; $RIN; $sFldDel)
	RECEIVE PACKET:C104($dImportFile; $ADT; $sFldDel)
	RECEIVE PACKET:C104($dImportFile; $Admin_sys; $sFldDel)
	RECEIVE PACKET:C104($dImportFile; $Fedaid_sys; $sFldDel)
	RECEIVE PACKET:C104($dImportFile; $Fedaid_ur; $sFldDel)
	RECEIVE PACKET:C104($dImportFile; $Func_class; $sFldDel)
	RECEIVE PACKET:C104($dImportFile; $Acc_con; <>sCR)
	RECEIVE PACKET:C104($dImportFile; $tbuff; 1)  //ignore the line feed character
	
	$counter:=$counter+1
	If ($counter%25=0)
		GOTO XY:C161(1; 1)  //2-10-2000 : CM
		MESSAGE:C88("Record "+String:C10($counter))
	End if 
End while 

CLOSE WINDOW:C154
CLOSE DOCUMENT:C267($dImportFile)