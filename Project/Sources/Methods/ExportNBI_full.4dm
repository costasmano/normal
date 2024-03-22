//%attributes = {"invisible":true}
// Method: ExportNBI_full
// Description
// copied from exportNBI to export all records making sure that the record is correct length
// Still run our checks and log to the error file
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 03/03/17, 12:26:58
	// ----------------------------------------------------
	// First Release
	Mods_2017_03
	// Modified by: Costas Manousakis-(Designer)-(3/8/17 12:48:25)
	Mods_2017_03
	//  `fixed setting variable $item113 to have a length of 1
	// Modified by: Costas Manousakis-(Designer)-(3/20/17 16:09:50)
	Mods_2017_03
	//  `modified the errors alert
End if 


C_TIME:C306($dExportFile)
C_TIME:C306($dErrFile)  //Added 4/3/2000 CM
C_TEXT:C284($NBfile)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($NBErrfile)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($fill)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284($vsOutputFolder; <>vsNBIExportOutF)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284($t)
C_TEXT:C284($et; $errPrefix_txt; $errHeader_txt)  // added 3/21/2001
C_BOOLEAN:C305($errHeader_b)
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
C_TEXT:C284($Item110; $Item112; $Item113)  // Command Replaced was o_C_STRING length was 1
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
//C_STRING(5;$Item98);  `C_STRING(15;$Item99)
C_TEXT:C284($Item105)  // Command Replaced was o_C_STRING length was 1
//C_STRING(1;$Item107);  `C_STRING(3;$Item108)
C_TEXT:C284($Item111)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($item8_txt)
C_BOOLEAN:C305($igItem97; $igItem92a)

//Get only FHWA records
//SEARCH([Bridge MHD NBIS];[Bridge MHD NBIS]FHWARecord=True)
//  changed by CM to do it for records in selection
$Recs:=Records in selection:C76([Bridge MHD NBIS:1])
$errHeader_b:=False:C215
$errHeader_txt:="Distr"+Char:C90(9)+"BIN"+Char:C90(9)+"Item5"+Char:C90(9)+"Item"+Char:C90(9)+"ErrorType"+Char:C90(9)+" < (Required Length) : -(Actual Item Value)- "+<>sCR+<>sLF
CONFIRM:C162("Export "+String:C10($Recs; "##,##0")+" records to an NBI file (fixed length, 434 characters per record)?")
If (OK=1)
	C_BLOB:C604($SaveRO_state_x)
	$SaveRO_state_x:=ut_db_SaveROState
	READ ONLY:C145(*)
	
	CENTER_WINDOW(250; 190)
	DIALOG:C40([Dialogs:21]; "SuppressErrors")
	CLOSE WINDOW:C154
	If (Ok=1)
		$igItem97:=(CBItem97=1)
		$igItem92a:=(CBItem92a=1)
	End if 
	//  $Item37FHWA:="12235334435" ` Replaced by call to GP HistoricalTrans.
	//  $Item37Code:="HEPANCR ?XZ" ` Replaced by call to GP HistoricalTrans.
	$fill:=" "*43
	$t:="Select folder for Export files."
	If (<>vsNBIExportOutF#"")
		$t:=$t+"  (Press Cancel for "+<>vsNBIExportOutF+")"
	End if 
	$vsOutputFolder:=Select folder:C670($t)
	If (OK=1)
		<>vsNBIExportOutF:=$vsOutputFolder
	Else 
		$vsOutputFolder:=<>vsNBIExportOutF
	End if 
	
	$NBfile:="MFINPUT.TXT"
	$dExportFile:=Create document:C266($vsOutputFolder+$NBfile; "TEXT")
	$NBErrfile:="MFINPUTERR.TXT"
	$dErrFile:=Create document:C266($vsOutputFolder+$NBErrfile; "TEXT")
	If (Ok=1)
		//TRACE
		C_LONGINT:C283($ProgressID_L; $DT_L; $RemainingMilli_L; $StartMilliSec_L)
		C_REAL:C285($RRR_r)
		$ProgressID_L:=Progress New
		Progress SET TITLE($ProgressID_L; "Exporting NBI Records")
		//initialize the bar
		//UpdateProgress (0;Size of array($IDs_aL))
		Progress SET PROGRESS($ProgressID_L; 0)
		Progress SET BUTTON ENABLED($ProgressID_L; True:C214)
		$StartMilliSec_L:=Milliseconds:C459
		
		//<>ProgressPID:=StartProgress ("NBIExport";"None";"Exporting NBI Records")
		//UpdateProgress (0;$Recs)  //Start the progress
		
		$Interval:=MaxNum(MinNum(Int:C8($Recs/40); 20); 2)  // get an update interval between 2 and 20
		
		$t:=""
		$k:=0
		$l:=0
		FIRST RECORD:C50([Bridge MHD NBIS:1])
		For ($i; 1; $Recs)
			$Item6A:=" "*24
			$Item6A:=Change string:C234($Item6A; [Bridge MHD NBIS:1]Item6A:63; 1)  //Added 3/6/98 by Tom Nee.
			If ([Bridge MHD NBIS:1]Item6B:64=True:C214)
				$Item6B:="*"
			Else 
				$Item6B:=" "
			End if 
			$Item7:=" "*18
			$Item7:=Change string:C234($Item7; [Bridge MHD NBIS:1]Item7:65; 1)  //Added 3/6/98 by Tom Nee.
			$Item9:=" "*25
			$Item9:=Change string:C234($Item9; [Bridge MHD NBIS:1]Item9:66; 1)  //Added 3/6/98 by Tom Nee.
			
			$Item10:=String:C10([Bridge MHD NBIS:1]Item10:102*100; "0000")
			$Item11:=String:C10([Bridge MHD NBIS:1]Item11:67*1000; "0000000")
			If ([Bridge MHD NBIS:1]Item12:196=True:C214)
				$Item12:="1"
			Else 
				$Item12:="0"
			End if 
			$Item13:=" "*12  //Added 3/10/98 by Tom Nee.
			$Item13:=Change string:C234($Item13; [Bridge MHD NBIS:1]Item 13A:197; 11-Length:C16([Bridge MHD NBIS:1]Item 13A:197))  //Right justified, 10 chars.
			$Item13:=Change string:C234($Item13; [Bridge MHD NBIS:1]Item 13B:198; 13-Length:C16([Bridge MHD NBIS:1]Item 13B:198))  //Right justified, 2 chars.
			$Item16:=String:C10([Bridge MHD NBIS:1]Item16A:68; "00")+String:C10([Bridge MHD NBIS:1]Item16B:69; "00")+String:C10([Bridge MHD NBIS:1]Item16C:109*100; "0000")
			$Item17:=String:C10([Bridge MHD NBIS:1]Item17A:70; "000")+String:C10([Bridge MHD NBIS:1]Item17B:71; "00")+String:C10([Bridge MHD NBIS:1]Item17C:136*100; "0000")
			$Item19:=String:C10([Bridge MHD NBIS:1]Item19:91; "000")
			$Item27:=String:C10([Bridge MHD NBIS:1]Item27:83; "0000")
			$Item28:=String:C10([Bridge MHD NBIS:1]Item28A:86; "00")+String:C10([Bridge MHD NBIS:1]Item28B:87; "00")
			$Item29:=String:C10([Bridge MHD NBIS:1]Item29:88; "000000")
			$Item30:=String:C10([Bridge MHD NBIS:1]Item30:89; "0000")
			$Item32:=String:C10([Bridge MHD NBIS:1]Item32:98*10; "0000")
			$Item34:=String:C10([Bridge MHD NBIS:1]Item34:100; "00")
			If ([Bridge MHD NBIS:1]Item35:101=True:C214)
				$Item35:="1"
			Else 
				$Item35:="0"
			End if 
			//These four lines are now in  HistoricalTrans.  TDN 12/24/98.     
			//      $Item37:=$Item37FHWA≤Position([Bridge MHD NBIS]Item37;$Item37code)≥
			//      If (Position($Item37;$Item37FHWA)<1)
			//        $Item37:="4"
			//      End if 
			$Item37:=HistoricalTrans
			$Item39:=String:C10([Bridge MHD NBIS:1]Item39:115*10; "0000")
			$Item40:=String:C10([Bridge MHD NBIS:1]Item40:117*10; "00000")
			$Item44:=" "*3
			$Item44:=Change string:C234($Item44; [Bridge MHD NBIS:1]Item44:76; 1)  //Added 3/10/98 by Tom Nee.
			$Item45:=String:C10([Bridge MHD NBIS:1]Item45:77; "000")
			$Item46:=String:C10([Bridge MHD NBIS:1]Item46:78; "0000")
			$Item47:=String:C10([Bridge MHD NBIS:1]Item47:104*10; "000")
			$Item48:=String:C10([Bridge MHD NBIS:1]Item48:92*10; "00000")
			//3/21/01 Rounding before truncating
			//$Item49:=String([Bridge MHD NBIS]Item49*10;"000000")
			$Item49:=String:C10(Round:C94([Bridge MHD NBIS:1]Item49:93; 1)*10; "000000")
			//End of change
			$Item50:=String:C10([Bridge MHD NBIS:1]Item50A:94*10; "000")+String:C10([Bridge MHD NBIS:1]Item50B:95*10; "000")
			//3/21/01 Rounding before truncating
			//$Item51:=String([Bridge MHD NBIS]Item51*10;"0000")
			$Item51:=String:C10(Round:C94([Bridge MHD NBIS:1]Item51:96; 1)*10; "0000")
			// End of change
			$Item52:=String:C10([Bridge MHD NBIS:1]Item52:97*10; "0000")
			$Item53:=String:C10([Bridge MHD NBIS:1]Item53:105*100; "0000")
			$Item54:=" "
			$Item54:=Change string:C234($Item54; [Bridge MHD NBIS:1]Item54A:107; 1)
			$Item54:=$Item54+String:C10([Bridge MHD NBIS:1]Item54B:108*100; "0000")
			$Item55:=" "
			$Item55:=Change string:C234($Item55; [Bridge MHD NBIS:1]Item55A:110; 1)
			$Item55:=$Item55+String:C10([Bridge MHD NBIS:1]Item55B:111*10; "000")
			$Item56:=String:C10([Bridge MHD NBIS:1]Item56:112*10; "000")
			$Item63:=" "
			$Item63:=Change string:C234($Item63; [Bridge MHD NBIS:1]Item 63:199; 1)
			If (Position:C15($Item63; <>SIA_LoadRtg_63_RF_txt)>0)
				$Item64:=String:C10([Bridge MHD NBIS:1]Item64:137*100; "000")
			Else 
				$Item64:=String:C10([Bridge MHD NBIS:1]Item64:137*10; "000")
			End if 
			$Item65:=" "
			$Item65:=Change string:C234($Item65; [Bridge MHD NBIS:1]Item 65:200; 1)
			If (Position:C15($Item65; <>SIA_LoadRtg_63_RF_txt)>0)
				$Item66:=String:C10([Bridge MHD NBIS:1]Item66:139*100; "000")
			Else 
				$Item66:=String:C10([Bridge MHD NBIS:1]Item66:139*10; "000")
			End if 
			$Item75:=" "*3  //Added 3/10/98 by Tom Nee.
			$Item75:=Change string:C234($Item75; [Bridge MHD NBIS:1]Item75A:152; 1)
			$Item75:=Change string:C234($Item75; [Bridge MHD NBIS:1]Item75B:153; 3)
			$Item76:=String:C10([Bridge MHD NBIS:1]Item76:154*10; "000000")
			$m:=Month of:C24([Bridge MHD NBIS:1]Item90:161)
			$y:=Year of:C25([Bridge MHD NBIS:1]Item90:161)
			If ($y>1999)
				$y:=$y-2000
			Else 
				$y:=$y-1900
			End if 
			$Item90:=String:C10($m; "00")+String:C10($y; "00")
			$Item91:=String:C10([Bridge MHD NBIS:1]Item91:162; "00")
			$Item92:=""
			If ([Bridge MHD NBIS:1]Item92AA:163=True:C214)
				If (($igItem92a=True:C214) & ([Bridge MHD NBIS:1]Item92AB:164>24))
					$crit:="Y24"
				Else 
					$crit:="Y"+String:C10([Bridge MHD NBIS:1]Item92AB:164; "00")
				End if 
				$m:=Month of:C24([Bridge MHD NBIS:1]Item93A:169)
				$y:=Year of:C25([Bridge MHD NBIS:1]Item93A:169)
				Case of 
					: ($y>1999)
						$y:=$y-2000
						$Item93A:=String:C10($m; "00")+String:C10($y; "00")
					: ($y>1900)
						$y:=$y-1900
						$Item93A:=String:C10($m; "00")+String:C10($y; "00")
					: ($y=0)
						$Item93A:=" "*4
				End case 
			Else 
				$crit:="N  "
				$Item93A:="    "
			End if 
			$Item92:=$crit
			If ([Bridge MHD NBIS:1]Item92BA:165=True:C214)
				$crit:="Y"+String:C10([Bridge MHD NBIS:1]Item92BB:166; "00")
				$m:=Month of:C24([Bridge MHD NBIS:1]Item93B:170)
				$y:=Year of:C25([Bridge MHD NBIS:1]Item93B:170)
				Case of 
					: ($y>1999)
						$y:=$y-2000
						$Item93B:=String:C10($m; "00")+String:C10($y; "00")
					: ($y>1900)
						$y:=$y-1900
						$Item93B:=String:C10($m; "00")+String:C10($y; "00")
					: ($y=0)
						$Item93B:=" "*4
				End case 
			Else 
				$crit:="N  "
				$Item93B:="    "
			End if 
			$Item92:=$Item92+$crit
			If ([Bridge MHD NBIS:1]Item92CA:167=True:C214)
				$crit:="Y"+String:C10([Bridge MHD NBIS:1]Item92CB:168; "00")
				$m:=Month of:C24([Bridge MHD NBIS:1]Item93C:171)
				$y:=Year of:C25([Bridge MHD NBIS:1]Item93C:171)
				Case of 
					: ($y>1999)
						$y:=$y-2000
						$Item93C:=String:C10($m; "00")+String:C10($y; "00")
					: ($y>1900)
						$y:=$y-1900
						$Item93C:=String:C10($m; "00")+String:C10($y; "00")
					: ($y=0)
						$Item93C:=" "*4
				End case 
			Else 
				$crit:="N  "
				$Item93C:="    "
			End if 
			$Item92:=$Item92+$crit
			$Item94:=String:C10([Bridge MHD NBIS:1]Item94:155; "000000")
			$Item95:=String:C10([Bridge MHD NBIS:1]Item95:156; "000000")
			$Item96:=String:C10([Bridge MHD NBIS:1]Item96:157; "000000")
			$Item97:=String:C10([Bridge MHD NBIS:1]Item97:158; "0000")
			If (($igItem97=True:C214) & ($Item97="0000"))
				$Item97:=String:C10(Year of:C25(Current date:C33(*)); "0000")
			End if 
			If ([Bridge MHD NBIS:1]Item103:124=True:C214)
				$Item103:="T"
			Else 
				$Item103:=" "
			End if 
			If ([Bridge MHD NBIS:1]Item104:119=True:C214)
				$Item104:="1"
			Else 
				$Item104:="0"
			End if 
			$Item105:=" "  //Added 3/10/98 by Tom Nee.
			$Item105:=Change string:C234($Item105; [Bridge MHD NBIS:1]Item 105:201; 1)
			$Item106:=String:C10([Bridge MHD NBIS:1]Item106:84; "0000")
			$Item109:=String:C10([Bridge MHD NBIS:1]Item109:90; "00")
			If ([Bridge MHD NBIS:1]Item110:125=True:C214)
				$Item110:="1"
			Else 
				$Item110:="0"
			End if 
			$Item111:=" "  //Added 3/10/98 by Tom Nee.
			$Item111:=Change string:C234($Item111; [Bridge MHD NBIS:1]Item111:114; 1)
			If ([Bridge MHD NBIS:1]Item112:118=True:C214)
				$Item112:="Y"
			Else 
				$Item112:="N"
			End if 
			$Item113:=Change string:C234((" "*1); [Bridge MHD NBIS:1]Item113:151; 1)
			If ($Item113="D")
				$Item113:="6"
			End if 
			$Item114:=String:C10([Bridge MHD NBIS:1]Item114:159; "000000")
			$Item115:=String:C10([Bridge MHD NBIS:1]Item115:160; "0000")
			$Item116:=String:C10([Bridge MHD NBIS:1]Item116:116*10; "0000")
			
			$item8_txt:=[Bridge MHD NBIS:1]Item8:206
			If ([Bridge MHD NBIS:1]FHWAItem8:229#"")
				$item8_txt:=[Bridge MHD NBIS:1]FHWAItem8:229
			End if 
			$t:="251"+$item8_txt
			$t:=$t+Change string:C234((" "*9); [Bridge MHD NBIS:1]Item5:59; 1)
			$t:=$t+[Bridge MHD NBIS:1]Item2:60  //2 , 3 , 4 are always filled correctly
			$t:=$t+[Bridge MHD NBIS:1]Item3:61
			$t:=$t+[Bridge MHD NBIS:1]Item4:62+$Item6A+$Item6B+$Item7
			$t:=$t+$Item9+$Item10+$Item11+$Item12+$Item13
			$t:=$t+$Item16+$Item17+$Item19
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item20:126; 1)
			$t:=$t+Change string:C234((" "*2); [Bridge MHD NBIS:1]Item21:127; 1)
			$t:=$t+Change string:C234((" "*2); [Bridge MHD NBIS:1]Item22:128; 1)
			$t:=$t+Change string:C234((" "*2); [Bridge MHD NBIS:1]Item26:120; 1)
			$t:=$t+$Item27+$Item28+$Item29+$Item30+Change string:C234((" "*1); SIA_DesignLoadTrans([Bridge MHD NBIS:1]Item31:135); 1)+$Item32
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item33:99; 1)
			$t:=$t+$Item34+$Item35
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item36A:147; 1)
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item36B:148; 1)
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item36C:149; 1)
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item36D:150; 1)
			$t:=$t+$Item37
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item38:113; 1)
			$t:=$t+$Item39+$Item40
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item41:141; 1)
			$t:=$t+Change string:C234((" "*2); [Bridge MHD NBIS:1]Item42:85; 1)
			$t:=$t+Change string:C234((" "*3); [Bridge MHD NBIS:1]Item43:75; 1)
			$t:=$t+$Item44+$Item45+$Item46+$Item47+$Item48+$Item49
			$t:=$t+$Item50+$Item51+$Item52+$Item53+Change string:C234((" "*5); $Item54; 1)+Change string:C234((" "*4); $Item55; 1)+$Item56
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item58:130; 1)
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item59:131; 1)
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item60:132; 1)
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item61:133; 1)
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item62:134; 1)
			$t:=$t+$Item63+$Item64
			$t:=$t+$Item65+$Item66
			$t:=$t+[Bridge MHD NBIS:1]Item67:142  //67 68 69 70 are also calculated
			$t:=$t+[Bridge MHD NBIS:1]Item68:143
			$t:=$t+[Bridge MHD NBIS:1]Item69:144
			$t:=$t+[Bridge MHD NBIS:1]Item70:140
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item71:145; 1)
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item72:146; 1)
			$t:=$t+$Item75+$Item76+$Item90+$Item91+$Item92+$Item93A+$Item93B+$Item93C
			$t:=$t+$Item94+$Item95+$Item96+$Item97
			$t:=$t+Change string:C234((" "*3); [Bridge MHD NBIS:1]Item98A:72; 1)
			$t:=$t+Change string:C234((" "*2); [Bridge MHD NBIS:1]Item98B:73; 1)
			$t:=$t+Change string:C234((" "*15); [Bridge MHD NBIS:1]Item99:74; 1)
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item100:121; 1)
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item101:122; 1)
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item102:123; 1)
			$t:=$t+$Item103+$Item104+$Item105
			$t:=$t+$Item106
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item107:79; 1)
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item108A:80; 1)
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item108B:81; 1)
			$t:=$t+Change string:C234((" "*1); [Bridge MHD NBIS:1]Item108C:82; 1)
			$t:=$t+$Item109+$Item110+$Item111+$Item112+$Item113+$Item114+$Item115+$Item116+$fill+<>sCR+<>sLF
			
			If (True:C214)  //Includes CR and LF
				//run checks anyway and print to File
				// Do some checks for data length and write any errors to the error file
				$et:=""
				$errprefix_txt:=[Bridge MHD NBIS:1]InspResp:173+Char:C90(9)+[Bridge MHD NBIS:1]BIN:3+Char:C90(9)+[Bridge MHD NBIS:1]Item5:59+Char:C90(9)
				If (Length:C16([Bridge MHD NBIS:1]Item5:59)<9)
					$et:=$et+$errPrefix_txt+"5"+Char:C90(9)+"Length"+Char:C90(9)+" < 9 : -"+[Bridge MHD NBIS:1]Item5:59+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16($Item9)<25)
					$et:=$et+$errPrefix_txt+"9"+Char:C90(9)+"Length"+Char:C90(9)+": blank : -"+[Bridge MHD NBIS:1]Item9:66+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item20:126)<1)
					$et:=$et+$errPrefix_txt+"20"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item20:126+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item21:127)<2)
					$et:=$et+$errPrefix_txt+"21"+Char:C90(9)+"Length"+Char:C90(9)+" < 2 : -"+[Bridge MHD NBIS:1]Item21:127+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item22:128)<2)
					$et:=$et+$errPrefix_txt+"22"+Char:C90(9)+"Length"+Char:C90(9)+" < 2 : -"+[Bridge MHD NBIS:1]Item22:128+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item26:120)<2)
					$et:=$et+$errPrefix_txt+"26"+Char:C90(9)+"Length"+Char:C90(9)+" < 2 : -"+[Bridge MHD NBIS:1]Item26:120+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item31:135)<1)
					$et:=$et+$errPrefix_txt+"31"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item31:135+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item33:99)<1)
					$et:=$et+$errPrefix_txt+"33"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item33:99+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item36A:147)<1)
					$et:=$et+$errPrefix_txt+"36A"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item36A:147+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item36B:148)<1)
					$et:=$et+$errPrefix_txt+"36B"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item36B:148+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item36C:149)<1)
					$et:=$et+$errPrefix_txt+"36C"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item36C:149+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item36D:150)<1)
					$et:=$et+$errPrefix_txt+"36D"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item36D:150+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item38:113)<1)
					$et:=$et+$errPrefix_txt+"38"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item38:113+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item41:141)<1)
					$et:=$et+$errPrefix_txt+"41"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item41:141+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item42:85)<2)
					$et:=$et+$errPrefix_txt+"42"+Char:C90(9)+"Length"+Char:C90(9)+" < 2 : -"+[Bridge MHD NBIS:1]Item42:85+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item43:75)<3)
					$et:=$et+$errPrefix_txt+"43"+Char:C90(9)+"Length"+Char:C90(9)+" < 3 : -"+[Bridge MHD NBIS:1]Item43:75+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16($Item54)<5)
					$et:=$et+$errPrefix_txt+"54"+Char:C90(9)+"Length"+Char:C90(9)+" < 5 : -"+$Item54+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16($Item55)<4)
					$et:=$et+$errPrefix_txt+"55"+Char:C90(9)+"Length"+Char:C90(9)+" < 4 : -"+$Item55+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item58:130)<1)
					$et:=$et+$errPrefix_txt+"58"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item58:130+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item59:131)<1)
					$et:=$et+$errPrefix_txt+"59"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item59:131+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item60:132)<1)
					$et:=$et+$errPrefix_txt+"60"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item60:132+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item61:133)<1)
					$et:=$et+$errPrefix_txt+"61"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item61:133+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item62:134)<1)
					$et:=$et+$errPrefix_txt+"62"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item62:134+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item71:145)<1)
					$et:=$et+$errPrefix_txt+"71"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item71:145+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item72:146)<1)
					$et:=$et+$errPrefix_txt+"72"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item72:146+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item98A:72)<3)
					$et:=$et+$errPrefix_txt+"98A"+Char:C90(9)+"Length"+Char:C90(9)+" < 3 : -"+[Bridge MHD NBIS:1]Item98A:72+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item98B:73)<2)
					$et:=$et+$errPrefix_txt+"98b"+Char:C90(9)+"Length"+Char:C90(9)+" < 2 : -"+[Bridge MHD NBIS:1]Item98B:73+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item99:74)<15)
					$et:=$et+$errPrefix_txt+"99"+Char:C90(9)+"Length"+Char:C90(9)+" < 15 : -"+[Bridge MHD NBIS:1]Item99:74+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item100:121)<1)
					$et:=$et+$errPrefix_txt+"100"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item100:121+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item101:122)<1)
					$et:=$et+$errPrefix_txt+"101"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item101:122+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item102:123)<1)
					$et:=$et+$errPrefix_txt+"102"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item102:123+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item107:79)<1)
					$et:=$et+$errPrefix_txt+"107"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item107:79+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item108A:80)<1)
					$et:=$et+$errPrefix_txt+"108A"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item108A:80+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item108B:81)<1)
					$et:=$et+$errPrefix_txt+"108B"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item108B:81+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16([Bridge MHD NBIS:1]Item108C:82)<1)
					$et:=$et+$errPrefix_txt+"108C"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[Bridge MHD NBIS:1]Item108C:82+"-"+<>sCR+<>sLF
				End if 
				If (Length:C16($Item113)<1)
					$et:=$et+$errPrefix_txt+"113"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+$Item113+"-"+<>sCR+<>sLF
				End if 
				If ($et#"")
					If (Not:C34($errHeader_b))
						$errHeader_b:=True:C214
						//SEND PACKET($dErrFile;("Item Length Errors found for BIN : "+[Bridge MHD NBIS]BIN+◊sCR+◊sLF))
						SEND PACKET:C103($dErrFile; $errHeader_txt)
					End if 
					SEND PACKET:C103($dErrFile; $et)
					$l:=$l+1
				End if 
				//SEND PACKET($dErrFile;$t)
				//SEND PACKET($dErrFile;(2*Char(13)))
			End if 
			//Also run SIA check anyway
			$et:=SIA_DataCheck
			If ($et#"")
				If (Not:C34($errHeader_b))
					$errHeader_b:=True:C214
					//SEND PACKET($dErrFile;("Item Length Errors found for BIN : "+[Bridge MHD NBIS]BIN+◊sCR+◊sLF))
					SEND PACKET:C103($dErrFile; $errHeader_txt)
				End if 
				SEND PACKET:C103($dErrFile; $et)
				//SEND PACKET($dErrFile;(2*Char(13)))
				//SEND PACKET($dErrFile;$t)
				$l:=$l+1
			End if 
			//Send record to the export file regardless
			SEND PACKET:C103($dExportFile; $t)
			$k:=$k+1
			//Check to see if there is a secondary record
			RELATE MANY:C262([Bridge MHD NBIS:1])
			FIRST RECORD:C50([NBIS Secondary:3])
			For ($j; 1; Records in selection:C76([NBIS Secondary:3]))
				$Item6A:=" "*24
				$Item6A:=Change string:C234($Item6A; [NBIS Secondary:3]Item6A:5; 1)
				If ([NBIS Secondary:3]Item6B:6=True:C214)
					$Item6B:="*"
				Else 
					$Item6B:=" "
				End if 
				$Item7:=" "*18
				$Item7:=Change string:C234($Item7; [NBIS Secondary:3]Item7:7; 1)
				$Item9:=" "*25
				$Item9:=Change string:C234($Item9; [NBIS Secondary:3]Item9:8; 1)
				$Item10:=String:C10([NBIS Secondary:3]Item10:9*100; "0000")
				$Item11:=String:C10([NBIS Secondary:3]Item11:11*1000; "0000000")
				$Item16:=String:C10([NBIS Secondary:3]Item16A:12; "00")+String:C10([NBIS Secondary:3]Item16B:13; "00")+String:C10([NBIS Secondary:3]Item16C:35*100; "0000")
				$Item17:=String:C10([NBIS Secondary:3]Item17A:14; "000")+String:C10([NBIS Secondary:3]Item17B:15; "00")+String:C10([NBIS Secondary:3]Item17C:36*100; "0000")
				$Item19:=String:C10([NBIS Secondary:3]Item19:16; "000")
				$Item27:=String:C10([NBIS Secondary:3]Item27:19; "0000")
				$Item28:=String:C10([NBIS Secondary:3]Item28A:20; "00")+String:C10([NBIS Secondary:3]Item28B:21; "00")
				$Item29:=String:C10([NBIS Secondary:3]Item29:22; "000000")
				$Item30:=String:C10([NBIS Secondary:3]Item30:37; "0000")
				$Item47:=String:C10([NBIS Secondary:3]Item47:25*10; "000")
				$Item48:=String:C10([NBIS Secondary:3]Item48:26*10; "00000")
				$Item49:=String:C10([NBIS Secondary:3]Item49:27*10; "000000")
				If ([NBIS Secondary:3]Item103:31=True:C214)
					$Item103:="T"
				Else 
					$Item103:=" "
				End if 
				If ([NBIS Secondary:3]Item104:32=True:C214)
					$Item104:="1"
				Else 
					$Item104:="0"
				End if 
				$Item109:=String:C10([NBIS Secondary:3]Item109:10; "00")
				If ([NBIS Secondary:3]Item110:33=True:C214)
					$Item110:="1"
				Else 
					$Item110:="0"
				End if 
				
				$t:="251"+$item8_txt+[NBIS Secondary:3]Item5:4+(" "*2)  //item 5 should always be OK 
				$t:=$t+[NBIS Secondary:3]Item3:2+[NBIS Secondary:3]Item4:3+$Item6A+$Item6B+$Item7  // 3 and 4 are always OK
				$t:=$t+$Item9+$Item10+$Item11+(" "*13)
				$t:=$t+$Item16+$Item17+$Item19+Change string:C234((" "*1); [NBIS Secondary:3]Item20:17; 1)+(" "*4)
				$t:=$t+Change string:C234((" "*2); [NBIS Secondary:3]Item26:18; 1)+$Item27+$Item28+$Item29+$Item30+(" "*5)
				$t:=$t+(" "*8)
				$t:=$t+(" "*12)+Change string:C234((" "*2); [NBIS Secondary:3]Item42:23; 1)
				$t:=$t+Change string:C234((" "*3); [NBIS Secondary:3]Item43:24; 1)+(" "*10)+$Item47+$Item48+$Item49
				$t:=$t+(" "*127)
				$t:=$t+Change string:C234((" "*1); [NBIS Secondary:3]Item100:28; 1)+Change string:C234((" "*1); [NBIS Secondary:3]Item101:29; 1)+Change string:C234((" "*1); [NBIS Secondary:3]Item102:30; 1)+$Item103+$Item104
				$t:=$t+(" "*9)
				$t:=$t+$Item109+$Item110+(" "*17)+$fill+<>sCR+<>sLF
				
				//check anyway
				If (True:C214)  //Includes CR and LF
					// ALERT("Data length not 434 for BIN Secondary Record "+[NBIS Secondary]BIN+
					//" (="+String(Length($t))+")."+(2*◊sCR)+"Export aborted.")
					// UNLOAD RECORD([NBIS Secondary])
					//CLOSE DOCUMENT($dExportFile)
					// Do some data checks and export error message to error file.    
					$et:=""
					$errprefix_txt:=[Bridge MHD NBIS:1]InspResp:173+Char:C90(9)+[Bridge MHD NBIS:1]BIN:3+Char:C90(9)+[NBIS Secondary:3]Item5:4+Char:C90(9)
					If (Length:C16([NBIS Secondary:3]Item20:17)<1)
						$et:=$et+$errPrefix_txt+"20"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[NBIS Secondary:3]Item20:17+"-"+<>sCR+<>sLF
					End if 
					If (Length:C16([NBIS Secondary:3]Item26:18)<2)
						$et:=$et+$errPrefix_txt+"26"+Char:C90(9)+"Length"+Char:C90(9)+" < 2 : -"+[NBIS Secondary:3]Item26:18+"-"+<>sCR+<>sLF
					End if 
					If (Length:C16([NBIS Secondary:3]Item42:23)<2)
						$et:=$et+$errPrefix_txt+"42"+Char:C90(9)+"Length"+Char:C90(9)+" < 2 : -"+[NBIS Secondary:3]Item42:23+"-"+<>sCR+<>sLF
					End if 
					If (Length:C16([NBIS Secondary:3]Item43:24)<3)
						$et:=$et+$errPrefix_txt+"43"+Char:C90(9)+"Length"+Char:C90(9)+" < 3 : -"+[NBIS Secondary:3]Item43:24+"-"+<>sCR+<>sLF
					End if 
					If (Length:C16([NBIS Secondary:3]Item100:28)<1)
						$et:=$et+$errPrefix_txt+"100"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[NBIS Secondary:3]Item100:28+"-"+<>sCR+<>sLF
					End if 
					If (Length:C16([NBIS Secondary:3]Item101:29)<1)
						$et:=$et+$errPrefix_txt+"101"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[NBIS Secondary:3]Item101:29+"-"+<>sCR+<>sLF
					End if 
					If (Length:C16([NBIS Secondary:3]Item102:30)<1)
						$et:=$et+$errPrefix_txt+"102"+Char:C90(9)+"Length"+Char:C90(9)+" < 1 : -"+[NBIS Secondary:3]Item102:30+"-"+<>sCR+<>sLF
					End if 
					If ($et#"")
						If (Not:C34($errHeader_b))
							//SEND PACKET($dErrFile;("Item Length Errors found for BIN : "+[Bridge MHD NBIS]BIN+◊sCR+◊sLF))
							$errHeader_b:=True:C214
							SEND PACKET:C103($dErrFile; $errHeader_txt)
						End if 
						//SEND PACKET($dErrFile;("Errors found for Secondary BIN : "+[Bridge MHD NBIS]BIN+◊sCR+◊sLF))
						SEND PACKET:C103($dErrFile; $et)
						$l:=$l+1
					End if 
					//SEND PACKET($dErrFile;$t)
					//SEND PACKET($dErrFile;(2*(Char(13))))
					//ABORT
				End if 
				//send record anyway
				SEND PACKET:C103($dExportFile; $t)
				$k:=$k+1
				NEXT RECORD:C51([NBIS Secondary:3])
			End for 
			NEXT RECORD:C51([Bridge MHD NBIS:1])
			If ($k%$Interval=0)  //Don't slow down things just to display
				//UpdateProgress ($i;$Recs)
				Progress SET PROGRESS($ProgressID_L; ($i/$Recs))
				$DT_L:=Milliseconds:C459-$StartMilliSec_L
				$RRR_r:=($DT_L/$i)*($Recs-$i)
				$RemainingMilli_L:=$RRR_r
				Progress SET MESSAGE($ProgressID_L; String:C10($i)+" of "+String:C10($Recs; "###,###,###,###")+" Est time left: "+FN_MilliSec2TimeStr($RemainingMilli_L))
			End if 
			// check to see if aborted from the Progress window
			If (Progress Stopped($ProgressID_L))
				ALERT:C41("Aborting after "+String:C10($i)+" records")
				$i:=$Recs+1
			End if 
		End for 
		Progress QUIT($ProgressID_L)
		//CALL PROCESS(<>ProgressPID)
		CLOSE DOCUMENT:C267($dExportFile)
		CLOSE DOCUMENT:C267($dErrFile)
		ALERT:C41(String:C10($k; "##,##0")+" total records (primary & secondary) exported to "+$vsOutputFolder+$NBfile)
		If ($l>0)
			ALERT:C41(String:C10($l; "##,##0")+" total records (primary & secondary) with errors placed in "+$vsOutputFolder+$NBErrfile+".  These errors are included in the export file!")
			ut_OpenDocument($vsOutputFolder+$NBErrfile)
		End if 
	End if 
	ut_db_RestoreROState($SaveRO_state_x)
End if 
//NO TRACE