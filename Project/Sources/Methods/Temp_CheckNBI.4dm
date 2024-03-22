//%attributes = {"invisible":true}
C_TIME:C306($dExportFile)
C_TIME:C306($dErrFile)  //Added 4/3/2000 CM
C_TEXT:C284($NBfile)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($NBErrfile)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($fill)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284($vsOutputFolder; <>vsNBICheckOutF)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284($t)
C_TEXT:C284($et)  // added 3/21/2001
C_LONGINT:C283($i; $j; $k; $Recs; $Interval)
C_LONGINT:C283($l)  //Added 4/3/2000 cm - error record counter
C_LONGINT:C283($y; $m)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($crit)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($Item6A)  // Command Replaced was o_C_STRING length was 24//Added 3/6/98 by Tom Nee.
C_TEXT:C284($Item6B)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($Item7)  // Command Replaced was o_C_STRING length was 18//Added 3/6/98 by Tom Nee.
C_TEXT:C284($Item9)  // Command Replaced was o_C_STRING length was 25//Added 3/6/98 by Tom Nee.
C_TEXT:C284($Item10)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($Item11)  // Command Replaced was o_C_STRING length was 7
C_TEXT:C284($Item12)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($Item16)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284($Item17)  // Command Replaced was o_C_STRING length was 9
C_TEXT:C284($Item19)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($Item27; $Item28)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($Item29)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284($Item30; $Item32)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($Item34)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($Item35; $Item37)  // Command Replaced was o_C_STRING length was 1
//C_STRING(11;$Item37FHWA;$Item37Code) ` Replaced by call to GP HistoricalTrans.
C_TEXT:C284($Item39)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($Item40)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284($Item45)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($Item46)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($Item47)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($Item48)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284($Item49)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284($Item50)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284($Item51; $Item52; $Item53)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($Item54)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284($Item55)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($Item56; $Item64; $Item66)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($Item76)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284($Item90)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($Item91)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($Item92)  // Command Replaced was o_C_STRING length was 9
C_TEXT:C284($Item93A; $Item93B; $Item93C)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($Item94; $Item95; $Item96)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284($Item97)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($Item103; $Item104)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($Item106)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($Item109)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($Item1101; $Item1121; $Item113)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($Item114)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284($Item115)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($Item116)  // Command Replaced was o_C_STRING length was 4
//C_STRING(2;$Item2)
C_TEXT:C284($Item13)  // Command Replaced was o_C_STRING length was 12
//C_STRING(2;$Item21;$Item22) 
//C_STRING(1;$Item31;$Item33;$Item36;$Item38;$Item41)
C_TEXT:C284($Item44)  // Command Replaced was o_C_STRING length was 3
//C_STRING(1;$Item58;$Item59;$Item60;$Item61;$Item62); 
C_TEXT:C284($Item63; $Item65)  // Command Replaced was o_C_STRING length was 1
//C_STRING(1;$Item67;$Item68;$Item69;$Item70;$Item71;$Item72)
C_TEXT:C284($Item75)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($Item105)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($Item111)  // Command Replaced was o_C_STRING length was 1

$Recs:=Records in selection:C76([Bridge MHD NBIS:1])

$t:="Select folder for Export files."
If (<>vsNBICheckOutF#"")
	$t:=$t+"  (Press Cancel for "+<>vsNBICheckOutF+")"
End if 
$vsOutputFolder:=Select folder:C670($t)
If (OK=1)
	<>vsNBICheckOutF:=$vsOutputFolder
Else 
	$vsOutputFolder:=<>vsNBICheckOutF
End if 

$NBErrfile:="MFCHECK.ERR"
If (False:C215)
	$dErrFile:=Create document:C266($vsOutputFolder+$NBErrfile)
Else 
	$dErrFile:=Create document:C266("")
End if 

//TRACE
<>ProgressPID:=StartProgress("NBICheck"; "None"; "Checking NBI Records")
UpdateProgress(0; $Recs)  //Start the progress

$Interval:=MaxNum(MinNum(Int:C8($Recs/40); 20); 2)  // get an update interval between 2 and 20

//NewWindow (200;30;0;4;"Exporting")
//GOTO XY(1;0)
//MESSAGE("Exporting Records…")
$t:=""
$k:=0
$l:=0
FIRST RECORD:C50([Bridge MHD NBIS:1])
For ($i; 1; $Recs)
	$et:=""
	If (Length:C16([Bridge MHD NBIS:1]Item5:59)<9)
		$et:=$et+"5 < 9 : -"+[Bridge MHD NBIS:1]Item5:59+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item20:126)=" ")
		$et:=$et+"20 < 1 : -"+[Bridge MHD NBIS:1]Item20:126+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item21:127)="  ")
		$et:=$et+"21 < 2 : -"+[Bridge MHD NBIS:1]Item21:127+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item22:128)="  ")
		$et:=$et+"22 < 2 : -"+[Bridge MHD NBIS:1]Item22:128+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item26:120)="  ")
		$et:=$et+"26 < 2 : -"+[Bridge MHD NBIS:1]Item26:120+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item31:135)=" ")
		$et:=$et+"31 < 1 : -"+[Bridge MHD NBIS:1]Item31:135+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item33:99)=" ")
		$et:=$et+"33 < 1 : -"+[Bridge MHD NBIS:1]Item33:99+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item38:113)=" ")
		$et:=$et+"38 < 1 : -"+[Bridge MHD NBIS:1]Item38:113+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item41:141)=" ")
		$et:=$et+"41 < 1 : -"+[Bridge MHD NBIS:1]Item41:141+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item42:85)="  ")
		$et:=$et+"42 < 2 : -"+[Bridge MHD NBIS:1]Item42:85+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item43:75)="   ")
		$et:=$et+"43 < 3 : -"+[Bridge MHD NBIS:1]Item43:75+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item58:130)=" ")
		$et:=$et+"58 < 1 : -"+[Bridge MHD NBIS:1]Item58:130+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item59:131)=" ")
		$et:=$et+"59 < 1 : -"+[Bridge MHD NBIS:1]Item59:131+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item60:132)=" ")
		$et:=$et+"60 < 1 : -"+[Bridge MHD NBIS:1]Item60:132+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item61:133)=" ")
		$et:=$et+"61 < 1 : -"+[Bridge MHD NBIS:1]Item61:133+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item62:134)=" ")
		$et:=$et+"62 < 1 : -"+[Bridge MHD NBIS:1]Item62:134+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item71:145)=" ")
		$et:=$et+"71 < 1 : -"+[Bridge MHD NBIS:1]Item71:145+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item72:146)=" ")
		$et:=$et+"72 < 1 : -"+[Bridge MHD NBIS:1]Item72:146+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item100:121)=" ")
		$et:=$et+"100 < 1 : -"+[Bridge MHD NBIS:1]Item100:121+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item101:122)=" ")
		$et:=$et+"101 < 1 : -"+[Bridge MHD NBIS:1]Item101:122+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item102:123)=" ")
		$et:=$et+"102 < 1 : -"+[Bridge MHD NBIS:1]Item102:123+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item107:79)=" ")
		$et:=$et+"107 < 1 : -"+[Bridge MHD NBIS:1]Item107:79+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item108A:80)=" ")
		$et:=$et+"108A < 1 : -"+[Bridge MHD NBIS:1]Item108A:80+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item108B:81)=" ")
		$et:=$et+"108B < 1 : -"+[Bridge MHD NBIS:1]Item108B:81+"-"+<>sCR+<>sLF
	End if 
	If (([Bridge MHD NBIS:1]Item108C:82)=" ")
		$et:=$et+"108C < 1 : -"+[Bridge MHD NBIS:1]Item108C:82+"-"+<>sCR+<>sLF
	End if 
	If ($et#"")
		SEND PACKET:C103($dErrFile; ("Item Length Errors found for BIN : "+[Bridge MHD NBIS:1]BIN:3+<>sCR+<>sLF))
		SEND PACKET:C103($dErrFile; ("(Item) < (Required Length) : -(Actual Item Value)- "+<>sCR+<>sLF))
		SEND PACKET:C103($dErrFile; $et)
	End if 
	$l:=$l+1
	NEXT RECORD:C51([Bridge MHD NBIS:1])
	If ($k%$Interval=0)  //Don't slow down things just to display
		//ERASE WINDOW
		//GOTO XY(1;1)
		//MESSAGE("Record "+String($i)+" of "+String($Recs))
		UpdateProgress($i; $Recs)
	End if 
	// check to see if aborted from the Progress window
	If (<>Abort)
		$i:=$Recs+1
	End if 
End for 
POST OUTSIDE CALL:C329(<>ProgressPID)
CLOSE DOCUMENT:C267($dErrFile)