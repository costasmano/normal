//%attributes = {"invisible":true}
//Method: ARCHIVE_ExportNBItabDelim
//Description
//  ` Export an NBI tape from the current list of [BridgeMHDNBISArchive] records
//  ` to a tab delim file.  No error checks are done
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/17/12, 11:15:05
	// ----------------------------------------------------
	//Created : 
	Mods_2012_04
	// Modified by: Costas Manousakis-(Designer)-(6/18/13 09:54:36)
	Mods_2013_06
	//  `Added $item8_txt to get fhwaItem8 field if it is populated
	// Modified by: Costas Manousakis-(Designer)-(3/1/17 16:02:40)
	Mods_2017_03
	//  `use ◊SIA_LoadRtg_63_RF_txt to decide if  item 64 is rating factor or MT
	// Modified by: Costas Manousakis-(Designer)-(10/25/17 12:12:14)
	Mods_2017_10
	//  `use new ProgressNew and UpdateProgressNew
End if 
//
C_TIME:C306($dExportFile)
C_TIME:C306($dErrFile)  //Added 4/3/2000 CM
C_TEXT:C284($NBfile)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($NBErrfile)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($fill)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284($vsOutputFolder; <>vsNBIExportOutF)  // Command Replaced was o_C_STRING length was 255
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

C_BOOLEAN:C305($igItem97; $igItem92a)
C_TEXT:C284($tab_c)  // Command Replaced was o_C_STRING length was 1
$tab_c:=Char:C90(9)
//Get only FHWA records
//SEARCH([BridgeMHDNBISArchive];[BridgeMHDNBISArchive]FHWARecord=True)
//  changed by CM to do it for records in selection
$Recs:=Records in selection:C76([BridgeMHDNBISArchive:139])

CONFIRM:C162("Export "+String:C10($Recs; "##,##0")+" records to an NBI file (fixed length, 434 characters per record)?")
If (OK=1)
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
		//start the bar
		C_OBJECT:C1216($progressObj_o)
		$progressObj_o:=ProgressNew("Exporting NBI Records"; $Recs; True:C214; ""; 3)
		
		$Interval:=MaxNum(MinNum(Int:C8($Recs/40); 20); 2)  // get an update interval between 2 and 20
		$t:=""
		$t:="StateCode"+$tab_c+"Item8"+$tab_c+"Item5"+$tab_c+"Item2"+$tab_c
		$t:=$t+"Item3"+$tab_c+"Item4"+$tab_c+"Item6A"+$tab_c+"Item6B"+$tab_c+"Item7"+$tab_c
		$t:=$t+"Item9"+$tab_c+"Item10"+$tab_c+"Item11"+$tab_c+"Item12"+$tab_c+"Item13"+$tab_c
		$t:=$t+"Item16"+$tab_c+"Item17"+$tab_c+"Item19"+$tab_c+"Item20"+$tab_c+"Item21"+$tab_c+"Item22"+$tab_c
		$t:=$t+"Item26"+$tab_c+"Item27"+$tab_c+"Item28"+$tab_c+"Item29"+$tab_c+"Item30"+$tab_c+"Item31"+$tab_c+"Item32"+$tab_c
		$t:=$t+"Item33"+$tab_c+"Item34"+$tab_c+"Item35"+$tab_c+"Item36"+$tab_c
		$t:=$t+"Item37"+$tab_c+"Item38"+$tab_c+"Item39"+$tab_c+"Item40"+$tab_c+"Item41"+$tab_c+"Item42"+$tab_c
		$t:=$t+"Item43"+$tab_c+"Item44"+$tab_c+"Item45"+$tab_c+"Item46"+$tab_c+"Item47"+$tab_c+"Item48"+$tab_c+"Item49"+$tab_c
		$t:=$t+"Item50"+$tab_c+"Item51"+$tab_c+"Item52"+$tab_c+"Item53"+$tab_c+"Item54"+$tab_c+"Item55"+$tab_c+"Item56"+$tab_c+"Item58"+$tab_c+"Item59"+$tab_c
		$t:=$t+"Item60"+$tab_c+"Item61"+$tab_c+"Item62"+$tab_c+"Item63"+$tab_c+"Item64"+$tab_c
		$t:=$t+"Item65"+$tab_c+"Item66"+$tab_c+"Item67"+$tab_c+"Item68"+$tab_c
		$t:=$t+"Item69"+$tab_c+"Item70"+$tab_c+"Item71"+$tab_c+"Item72"+$tab_c
		$t:=$t+"Item75"+$tab_c+"Item76"+$tab_c+"Item90"+$tab_c+"Item91"+$tab_c+"Item92"+$tab_c+"Item93"+$tab_c
		$t:=$t+"Item94"+$tab_c+"Item95"+$tab_c+"Item96"+$tab_c+"Item97"+$tab_c+"Item98"+$tab_c+"Item99"+$tab_c
		$t:=$t+"Item100"+$tab_c+"Item101"+$tab_c+"Item102"+$tab_c+"Item103"+$tab_c+"Item104"+$tab_c+"Item105"+$tab_c
		$t:=$t+"Item106"+$tab_c+"Item107"+$tab_c+"Item108"+$tab_c
		$t:=$t+"Item109"+$tab_c+"Item110"+$tab_c+"Item111"+$tab_c+"Item112"+$tab_c+"Item113"+$tab_c+"Item114"+$tab_c+"Item115"+$tab_c+"Item116"+$tab_c+$fill+<>sCR+<>sLF
		
		SEND PACKET:C103($dExportFile; $t)
		
		$t:=""
		$k:=0
		$l:=0
		FIRST RECORD:C50([BridgeMHDNBISArchive:139])
		For ($i; 1; $Recs)
			$Item6A:=" "*24
			$Item6A:=Change string:C234($Item6A; [BridgeMHDNBISArchive:139]Item6A:62; 1)  //Added 3/6/98 by Tom Nee.
			If ([BridgeMHDNBISArchive:139]Item6B:63=True:C214)
				$Item6B:="*"
			Else 
				$Item6B:=" "
			End if 
			$Item7:=" "*18
			$Item7:=Change string:C234($Item7; [BridgeMHDNBISArchive:139]Item7:64; 1)  //Added 3/6/98 by Tom Nee.
			$Item9:=" "*25
			$Item9:=Change string:C234($Item9; [BridgeMHDNBISArchive:139]Item9:65; 1)  //Added 3/6/98 by Tom Nee.
			
			$Item10:=String:C10([BridgeMHDNBISArchive:139]Item10:101*100; "0000")
			$Item11:=String:C10([BridgeMHDNBISArchive:139]Item11:66*1000; "0000000")
			If ([BridgeMHDNBISArchive:139]Item12:193=True:C214)
				$Item12:="1"
			Else 
				$Item12:="0"
			End if 
			$Item13:=" "*12  //Added 3/10/98 by Tom Nee.
			$Item13:=Change string:C234($Item13; [BridgeMHDNBISArchive:139]Item 13A:194; 11-Length:C16([BridgeMHDNBISArchive:139]Item 13A:194))  //Right justified, 10 chars.
			$Item13:=Change string:C234($Item13; [BridgeMHDNBISArchive:139]Item 13B:195; 13-Length:C16([BridgeMHDNBISArchive:139]Item 13B:195))  //Right justified, 2 chars.
			$Item16:=String:C10([BridgeMHDNBISArchive:139]Item16A:67; "00")+String:C10([BridgeMHDNBISArchive:139]Item16B:68; "00")+String:C10([BridgeMHDNBISArchive:139]Item16C:108*100; "0000")
			$Item17:=String:C10([BridgeMHDNBISArchive:139]Item17A:69; "000")+String:C10([BridgeMHDNBISArchive:139]Item17B:70; "00")+String:C10([BridgeMHDNBISArchive:139]Item17C:135*100; "0000")
			$Item19:=String:C10([BridgeMHDNBISArchive:139]Item19:90; "000")
			$Item27:=String:C10([BridgeMHDNBISArchive:139]Item27:82; "0000")
			$Item28:=String:C10([BridgeMHDNBISArchive:139]Item28A:85; "00")+String:C10([BridgeMHDNBISArchive:139]Item28B:86; "00")
			$Item29:=String:C10([BridgeMHDNBISArchive:139]Item29:87; "000000")
			$Item30:=String:C10([BridgeMHDNBISArchive:139]Item30:88; "0000")
			$Item32:=String:C10([BridgeMHDNBISArchive:139]Item32:97*10; "0000")
			$Item34:=String:C10([BridgeMHDNBISArchive:139]Item34:99; "00")
			If ([BridgeMHDNBISArchive:139]Item35:100=True:C214)
				$Item35:="1"
			Else 
				$Item35:="0"
			End if 
			//These four lines are now in  HistoricalTrans.  TDN 12/24/98.     
			//      $Item37:=$Item37FHWA≤Position([BridgeMHDNBISArchive]Item37;$Item37code)≥
			//      If (Position($Item37;$Item37FHWA)<1)
			//        $Item37:="4"
			//      End if 
			$Item37:=HistoricalTrans([BridgeMHDNBISArchive:139]Item37:128)
			$Item39:=String:C10([BridgeMHDNBISArchive:139]Item39:114*10; "0000")
			$Item40:=String:C10([BridgeMHDNBISArchive:139]Item40:116*10; "00000")
			$Item44:=" "*3
			$Item44:=Change string:C234($Item44; [BridgeMHDNBISArchive:139]Item44:75; 1)  //Added 3/10/98 by Tom Nee.
			$Item45:=String:C10([BridgeMHDNBISArchive:139]Item45:76; "000")
			$Item46:=String:C10([BridgeMHDNBISArchive:139]Item46:77; "0000")
			$Item47:=String:C10([BridgeMHDNBISArchive:139]Item47:103*10; "000")
			$Item48:=String:C10([BridgeMHDNBISArchive:139]Item48:91*10; "00000")
			//3/21/01 Rounding before truncating
			//$Item49:=String([BridgeMHDNBISArchive]Item49*10;"000000")
			$Item49:=String:C10(Round:C94([BridgeMHDNBISArchive:139]Item49:92; 1)*10; "000000")
			//End of change
			$Item50:=String:C10([BridgeMHDNBISArchive:139]Item50A:93*10; "000")+String:C10([BridgeMHDNBISArchive:139]Item50B:94*10; "000")
			//3/21/01 Rounding before truncating
			//$Item51:=String([BridgeMHDNBISArchive]Item51*10;"0000")
			$Item51:=String:C10(Round:C94([BridgeMHDNBISArchive:139]Item51:95; 1)*10; "0000")
			// End of change
			$Item52:=String:C10([BridgeMHDNBISArchive:139]Item52:96*10; "0000")
			$Item53:=String:C10([BridgeMHDNBISArchive:139]Item53:104*100; "0000")
			$Item54:=" "
			$Item54:=Change string:C234($Item54; [BridgeMHDNBISArchive:139]Item54A:106; 1)
			$Item54:=$Item54+String:C10([BridgeMHDNBISArchive:139]Item54B:107*100; "0000")
			$Item55:=" "
			$Item55:=Change string:C234($Item55; [BridgeMHDNBISArchive:139]Item55A:109; 1)
			$Item55:=$Item55+String:C10([BridgeMHDNBISArchive:139]Item55B:110*10; "000")
			$Item56:=String:C10([BridgeMHDNBISArchive:139]Item56:111*10; "000")
			$Item63:=" "
			$Item63:=Change string:C234($Item63; [BridgeMHDNBISArchive:139]Item 63:196; 1)
			If (Position:C15($Item63; <>SIA_LoadRtg_63_RF_txt)>0)
				$Item64:=String:C10([BridgeMHDNBISArchive:139]Item64:136*100; "000")
			Else 
				$Item64:=String:C10([BridgeMHDNBISArchive:139]Item64:136*10; "000")
			End if 
			$Item65:=" "
			$Item65:=Change string:C234($Item65; [BridgeMHDNBISArchive:139]Item 65:197; 1)
			If (Position:C15($Item65; <>SIA_LoadRtg_63_RF_txt)>0)
				$Item66:=String:C10([BridgeMHDNBISArchive:139]Item66:138*100; "000")
			Else 
				$Item66:=String:C10([BridgeMHDNBISArchive:139]Item66:138*10; "000")
			End if 
			$Item75:=" "*3  //Added 3/10/98 by Tom Nee.
			$Item75:=Change string:C234($Item75; [BridgeMHDNBISArchive:139]Item75A:151; 1)
			$Item75:=Change string:C234($Item75; [BridgeMHDNBISArchive:139]Item75B:152; 3)
			$Item76:=String:C10([BridgeMHDNBISArchive:139]Item76:153*10; "000000")
			$m:=Month of:C24([BridgeMHDNBISArchive:139]Item90:160)
			$y:=Year of:C25([BridgeMHDNBISArchive:139]Item90:160)
			If ($y>1999)
				$y:=$y-2000
			Else 
				$y:=$y-1900
			End if 
			$Item90:=String:C10($m; "00")+String:C10($y; "00")
			$Item91:=String:C10([BridgeMHDNBISArchive:139]Item91:161; "00")
			$Item92:=""
			If ([BridgeMHDNBISArchive:139]Item92AA:162=True:C214)
				If (($igItem92a=True:C214) & ([BridgeMHDNBISArchive:139]Item92AB:163>24))
					$crit:="Y24"
				Else 
					$crit:="Y"+String:C10([BridgeMHDNBISArchive:139]Item92AB:163; "00")
				End if 
				$m:=Month of:C24([BridgeMHDNBISArchive:139]Item93A:168)
				$y:=Year of:C25([BridgeMHDNBISArchive:139]Item93A:168)
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
			If ([BridgeMHDNBISArchive:139]Item92BA:164=True:C214)
				$crit:="Y"+String:C10([BridgeMHDNBISArchive:139]Item92BB:165; "00")
				$m:=Month of:C24([BridgeMHDNBISArchive:139]Item93B:169)
				$y:=Year of:C25([BridgeMHDNBISArchive:139]Item93B:169)
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
			If ([BridgeMHDNBISArchive:139]Item92CA:166=True:C214)
				$crit:="Y"+String:C10([BridgeMHDNBISArchive:139]Item92CB:167; "00")
				$m:=Month of:C24([BridgeMHDNBISArchive:139]Item93C:170)
				$y:=Year of:C25([BridgeMHDNBISArchive:139]Item93C:170)
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
			$Item94:=String:C10([BridgeMHDNBISArchive:139]Item94:154; "000000")
			$Item95:=String:C10([BridgeMHDNBISArchive:139]Item95:155; "000000")
			$Item96:=String:C10([BridgeMHDNBISArchive:139]Item96:156; "000000")
			$Item97:=String:C10([BridgeMHDNBISArchive:139]Item97:157; "0000")
			If (($igItem97=True:C214) & ($Item97="0000"))
				$Item97:=String:C10(Year of:C25(Current date:C33(*)); "0000")
			End if 
			If ([BridgeMHDNBISArchive:139]Item103:123=True:C214)
				$Item103:="T"
			Else 
				$Item103:=" "
			End if 
			If ([BridgeMHDNBISArchive:139]Item104:118=True:C214)
				$Item104:="1"
			Else 
				$Item104:="0"
			End if 
			$Item105:=" "  //Added 3/10/98 by Tom Nee.
			$Item105:=Change string:C234($Item105; [BridgeMHDNBISArchive:139]Item 105:198; 1)
			$Item106:=String:C10([BridgeMHDNBISArchive:139]Item106:83; "0000")
			$Item109:=String:C10([BridgeMHDNBISArchive:139]Item109:89; "00")
			If ([BridgeMHDNBISArchive:139]Item110:124=True:C214)
				$Item110:="1"
			Else 
				$Item110:="0"
			End if 
			$Item111:=" "  //Added 3/10/98 by Tom Nee.
			$Item111:=Change string:C234($Item111; [BridgeMHDNBISArchive:139]Item111:113; 1)
			If ([BridgeMHDNBISArchive:139]Item112:117=True:C214)
				$Item112:="Y"
			Else 
				$Item112:="N"
			End if 
			$Item113:=[BridgeMHDNBISArchive:139]Item113:150
			If ($Item113="D")
				$Item113:="6"
			End if 
			$Item114:=String:C10([BridgeMHDNBISArchive:139]Item114:158; "000000")
			$Item115:=String:C10([BridgeMHDNBISArchive:139]Item115:159; "0000")
			$Item116:=String:C10([BridgeMHDNBISArchive:139]Item116:115*10; "0000")
			
			C_TEXT:C284($item8_txt)
			$item8_txt:=[BridgeMHDNBISArchive:139]Item8:203
			If ([BridgeMHDNBISArchive:139]FHWAItem8:228#"")
				$item8_txt:=[BridgeMHDNBISArchive:139]FHWAItem8:228
			End if 
			$t:="251"+$tab_c+$item8_txt+$tab_c+[BridgeMHDNBISArchive:139]Item5:58+$tab_c+[BridgeMHDNBISArchive:139]Item2:59
			$t:=$t+$tab_c+[BridgeMHDNBISArchive:139]Item3:60+$tab_c+[BridgeMHDNBISArchive:139]Item4:61+$tab_c+$Item6A+$tab_c+$Item6B+$tab_c+$Item7
			$t:=$t+$tab_c+$Item9+$tab_c+$Item10+$tab_c+$Item11+$tab_c+$Item12+$tab_c+$Item13
			$t:=$t+$tab_c+$Item16+$tab_c+$Item17+$tab_c+$Item19+$tab_c+[BridgeMHDNBISArchive:139]Item20:125+$tab_c+[BridgeMHDNBISArchive:139]Item21:126+$tab_c+[BridgeMHDNBISArchive:139]Item22:127+$tab_c
			$t:=$t+$tab_c+[BridgeMHDNBISArchive:139]Item26:119+$tab_c+$Item27+$tab_c+$Item28+$tab_c+$Item29+$tab_c+$Item30+$tab_c+SIA_DesignLoadTrans([BridgeMHDNBISArchive:139]Item31:134)+$tab_c+$Item32+$tab_c
			$t:=$t+[BridgeMHDNBISArchive:139]Item33:98+$tab_c+$Item34+$tab_c+$Item35+$tab_c+[BridgeMHDNBISArchive:139]Item36A:146+[BridgeMHDNBISArchive:139]Item36B:147+[BridgeMHDNBISArchive:139]Item36C:148+[BridgeMHDNBISArchive:139]Item36D:149+$tab_c
			$t:=$t+$Item37+$tab_c+[BridgeMHDNBISArchive:139]Item38:112+$tab_c+$Item39+$tab_c+$Item40+$tab_c+[BridgeMHDNBISArchive:139]Item41:140+$tab_c+[BridgeMHDNBISArchive:139]Item42:84+$tab_c
			$t:=$t+[BridgeMHDNBISArchive:139]Item43:74+$tab_c+$Item44+$tab_c+$Item45+$tab_c+$Item46+$tab_c+$Item47+$tab_c+$Item48+$tab_c+$Item49+$tab_c
			$t:=$t+$Item50+$tab_c+$Item51+$tab_c+$Item52+$tab_c+$Item53+$tab_c+$Item54+$tab_c+$Item55+$tab_c+$Item56+$tab_c+[BridgeMHDNBISArchive:139]Item58:129+$tab_c+[BridgeMHDNBISArchive:139]Item59:130+$tab_c
			$t:=$t+[BridgeMHDNBISArchive:139]Item60:131+$tab_c+[BridgeMHDNBISArchive:139]Item61:132+$tab_c+[BridgeMHDNBISArchive:139]Item62:133+$tab_c+$Item63+$tab_c+$Item64+$tab_c
			$t:=$t+$Item65+$tab_c+$Item66+$tab_c+[BridgeMHDNBISArchive:139]Item67:141+$tab_c+[BridgeMHDNBISArchive:139]Item68:142+$tab_c
			$t:=$t+[BridgeMHDNBISArchive:139]Item69:143+$tab_c+[BridgeMHDNBISArchive:139]Item70:139+$tab_c+[BridgeMHDNBISArchive:139]Item71:144+$tab_c+[BridgeMHDNBISArchive:139]Item72:145+$tab_c
			$t:=$t+$Item75+$tab_c+$Item76+$tab_c+$Item90+$tab_c+$Item91+$tab_c+$Item92+$tab_c+$Item93A+$Item93B+$Item93C+$tab_c
			$t:=$t+$Item94+$tab_c+$Item95+$tab_c+$Item96+$tab_c+$Item97+$tab_c+[BridgeMHDNBISArchive:139]Item98A:71+[BridgeMHDNBISArchive:139]Item98B:72+$tab_c+[BridgeMHDNBISArchive:139]Item99:73+$tab_c
			$t:=$t+[BridgeMHDNBISArchive:139]Item100:120+$tab_c+[BridgeMHDNBISArchive:139]Item101:121+$tab_c+[BridgeMHDNBISArchive:139]Item102:122+$tab_c+$Item103+$tab_c+$Item104+$tab_c+$Item105+$tab_c
			$t:=$t+$Item106+$tab_c+[BridgeMHDNBISArchive:139]Item107:78+$tab_c+[BridgeMHDNBISArchive:139]Item108A:79+[BridgeMHDNBISArchive:139]Item108B:80+[BridgeMHDNBISArchive:139]Item108C:81+$tab_c
			$t:=$t+$Item109+$tab_c+$Item110+$tab_c+$Item111+$tab_c+$Item112+$tab_c+$Item113+$tab_c+$Item114+$tab_c+$Item115+$tab_c+$Item116+$tab_c+$fill+<>sCR+<>sLF
			
			SEND PACKET:C103($dExportFile; $t)
			$k:=$k+1
			
			//Check to see if there is a secondary record
			QUERY:C277([NBISSecondaryArchive:140]; [NBISSecondaryArchive:140]ArchiveReason_s:39=[BridgeMHDNBISArchive:139]ArchiveReason_s:223; *)
			QUERY:C277([NBISSecondaryArchive:140];  & ; [NBISSecondaryArchive:140]ArchiveDate_d:40=[BridgeMHDNBISArchive:139]ArchiveDate_d:224)
			QUERY SELECTION:C341([NBISSecondaryArchive:140]; [NBISSecondaryArchive:140]BIN:1=[BridgeMHDNBISArchive:139]BIN:3)
			FIRST RECORD:C50([NBISSecondaryArchive:140])
			For ($j; 1; Records in selection:C76([NBISSecondaryArchive:140]))
				$Item6A:=" "*24
				$Item6A:=Change string:C234($Item6A; [NBISSecondaryArchive:140]Item6A:5; 1)
				If ([NBISSecondaryArchive:140]Item6B:6=True:C214)
					$Item6B:="*"
				Else 
					$Item6B:=" "
				End if 
				$Item7:=" "*18
				$Item7:=Change string:C234($Item7; [NBISSecondaryArchive:140]Item7:7; 1)
				$Item9:=" "*25
				$Item9:=Change string:C234($Item9; [NBISSecondaryArchive:140]Item9:8; 1)
				$Item10:=String:C10([NBISSecondaryArchive:140]Item10:9*100; "0000")
				$Item11:=String:C10([NBISSecondaryArchive:140]Item11:11*1000; "0000000")
				$Item16:=String:C10([NBISSecondaryArchive:140]Item16A:12; "00")+String:C10([NBISSecondaryArchive:140]Item16B:13; "00")+String:C10([NBISSecondaryArchive:140]Item16C:35*100; "0000")
				$Item17:=String:C10([NBISSecondaryArchive:140]Item17A:14; "000")+String:C10([NBISSecondaryArchive:140]Item17B:15; "00")+String:C10([NBISSecondaryArchive:140]Item17C:36*100; "0000")
				$Item19:=String:C10([NBISSecondaryArchive:140]Item19:16; "000")
				$Item27:=String:C10([NBISSecondaryArchive:140]Item27:19; "0000")
				$Item28:=String:C10([NBISSecondaryArchive:140]Item28A:20; "00")+String:C10([NBISSecondaryArchive:140]Item28B:21; "00")
				$Item29:=String:C10([NBISSecondaryArchive:140]Item29:22; "000000")
				$Item30:=String:C10([NBISSecondaryArchive:140]Item30:37; "0000")
				$Item47:=String:C10([NBISSecondaryArchive:140]Item47:25*10; "000")
				$Item48:=String:C10([NBISSecondaryArchive:140]Item48:26*10; "00000")
				$Item49:=String:C10([NBISSecondaryArchive:140]Item49:27*10; "000000")
				If ([NBISSecondaryArchive:140]Item103:31=True:C214)
					$Item103:="T"
				Else 
					$Item103:=" "
				End if 
				If ([NBISSecondaryArchive:140]Item104:32=True:C214)
					$Item104:="1"
				Else 
					$Item104:="0"
				End if 
				$Item109:=String:C10([NBISSecondaryArchive:140]Item109:10; "00")
				If ([NBISSecondaryArchive:140]Item110:33=True:C214)
					$Item110:="1"
				Else 
					$Item110:="0"
				End if 
				
				//$t:="251"+$tab_c+[BridgeMHDNBISArchive]Item8+$tab_c+[NBISSecondaryArchive]Item5+$tab_c+(" "*2)+$tab_c
				//$t:=$t+[NBISSecondaryArchive]Item3+$tab_c+[NBISSecondaryArchive]Item4+$tab_c+$Item6A+$Item6B+$tab_c+$Item7+$tab_c
				//$t:=$t+$Item9+$tab_c+$Item10+$tab_c+$Item11+$tab_c+(" "*13)+$tab_c
				//$t:=$t+$Item16+$tab_c+$Item17+$tab_c+$Item19+$tab_c+[NBISSecondaryArchive]Item20+$tab_c+(" "*4)
				//$t:=$t+[NBISSecondaryArchive]Item26+$tab_c+$Item27+$tab_c+$Item28+$tab_c+$Item29+$tab_c+$Item30+$tab_c+(" "*5)
				//$t:=$t+(" "*8)
				//$t:=$t+(" "*12)+[NBISSecondaryArchive]Item42+$tab_c
				//$t:=$t+[NBISSecondaryArchive]Item43+$tab_c+(" "*10)+$Item47+$tab_c+$Item48+$tab_c+$Item49+$tab_c
				//$t:=$t+(" "*127)
				//$t:=$t+[NBISSecondaryArchive]Item100+$tab_c+[NBISSecondaryArchive]Item101+$tab_c+[NBISSecondaryArchive]Item102+$tab_c+$Item103+$tab_c+$Item104+$tab_c
				//$t:=$t+(" "*9)
				//$t:=$t+$Item109+$tab_c+$Item110+$tab_c+(" "*17)+$fill+◊sCR+◊sLF
				
				$t:="251"+$tab_c+[BridgeMHDNBISArchive:139]Item8:203+$tab_c+[NBISSecondaryArchive:140]Item5:4+$tab_c+" "
				$t:=$t+$tab_c+[NBISSecondaryArchive:140]Item3:2+$tab_c+[NBISSecondaryArchive:140]Item4:3+$tab_c+$Item6A+$Item6B+$tab_c+$Item7
				$t:=$t+$tab_c+$Item9+$tab_c+$Item10+$tab_c+$Item11+$tab_c+" "+$tab_c+" "
				$t:=$t+$tab_c+$Item16+$tab_c+$Item17+$tab_c+$Item19+$tab_c+[NBISSecondaryArchive:140]Item20:17+$tab_c+" "+$tab_c+" "+$tab_c
				$t:=$t+$tab_c+[NBISSecondaryArchive:140]Item26:18+$tab_c+$Item27+$tab_c+$Item28+$tab_c+$Item29+$tab_c+$Item30+$tab_c+" "+$tab_c+" "+$tab_c
				$t:=$t+" "+$tab_c+" "+$tab_c+" "+$tab_c+" "+" "+" "+" "+$tab_c
				$t:=$t+" "+$tab_c+" "+$tab_c+" "+$tab_c+" "+$tab_c+" "+$tab_c+[NBISSecondaryArchive:140]Item42:23+$tab_c
				$t:=$t+[NBISSecondaryArchive:140]Item43:24+$tab_c+" "+$tab_c+" "+$tab_c+" "+$tab_c+$Item47+$tab_c+$Item48+$tab_c+$Item49+$tab_c
				$t:=$t+" "+$tab_c+" "+$tab_c+" "+$tab_c+" "+$tab_c+" "+$tab_c+" "+$tab_c+" "+$tab_c+" "+$tab_c+" "+$tab_c
				$t:=$t+" "+$tab_c+" "+$tab_c+" "+$tab_c+" "+$tab_c+" "+$tab_c
				$t:=$t+" "+$tab_c+" "+$tab_c+" "+$tab_c+" "+$tab_c
				$t:=$t+" "+$tab_c+" "+$tab_c+" "+$tab_c+" "+$tab_c
				$t:=$t+" "+$tab_c+" "+$tab_c+" "+$tab_c+" "+$tab_c+" "+$tab_c+" "+" "+" "+$tab_c
				$t:=$t+" "+$tab_c+" "+$tab_c+" "+$tab_c+" "+$tab_c+" "+" "+$tab_c+" "+$tab_c
				$t:=$t+[NBISSecondaryArchive:140]Item100:28+$tab_c+[NBISSecondaryArchive:140]Item101:29+$tab_c+[NBISSecondaryArchive:140]Item102:30+$tab_c+$Item103+$tab_c+$Item104+$tab_c+" "+$tab_c
				$t:=$t+" "+$tab_c+" "+$tab_c+" "+" "+" "+$tab_c
				$t:=$t+$Item109+$tab_c+$Item110+$tab_c+" "+$tab_c+" "+$tab_c+" "+$tab_c+" "+$tab_c+" "+$tab_c+" "+$tab_c+$fill+<>sCR+<>sLF
				
				
				SEND PACKET:C103($dExportFile; $t)
				$k:=$k+1
				NEXT RECORD:C51([NBISSecondaryArchive:140])
			End for 
			NEXT RECORD:C51([BridgeMHDNBISArchive:139])
			If ($k%$Interval=0)  //Don't slow down things just to display
				UpdateProgressNew($progressObj_o; $i)
				
			End if 
			
			//check if progress stopped
			If (Progress Stopped(OB Get:C1224($progressObj_o; "progress")))
				//abort loop
				$i:=$Recs+1
			End if 
			
			
		End for 
		//quit progress
		Progress QUIT(OB Get:C1224($progressObj_o; "progress"))
		CLOSE DOCUMENT:C267($dExportFile)
		CLOSE DOCUMENT:C267($dErrFile)
		ALERT:C41(String:C10($k; "##,##0")+" total records (primary & secondary) exported successfully to "+$vsOutputFolder+$NBfile)
		If ($l>0)
			ALERT:C41(String:C10($l; "##,##0")+" total records (primary & secondary) with errors placed in "+$vsOutputFolder+$NBErrfile)
			ut_OpenDocument($vsOutputFolder+$NBErrfile)
		End if 
	End if 
End if 
//NO TRACE3
//End ARCHIVE_ExportNBI

//End ARCHIVE_ExportNBItabDelim