//%attributes = {"invisible":true}
//proccedure: ImportFEDrecord
//purpose: import NBI data according to the NBI record format
//date created: 9/14/98
//by: Albert Leung
//if a new bridge key is found a new record is created otherwise the NBI fields
//are updated
//
If (False:C215)
	// Modified 2-10-2000 : CM
	//    -Changed logic to check whether file has records that are CRLF
	//      delimited or just CR
	//    -Adjusted GOTO XY x param from 6 pixels to 1 character
	//    -Disabled creating new records if Brkey is not found in 4D data
	//    -Fixed error in checking for Y2K date issues for items 93A,B,C
	//      and item 90.  This will need to be revisited in 2050
	//21-Aug-2001 : CM
	//Create a report of the import process with the errors.
	// Modified by: Costas Manousakis-(Designer)-(3/1/17 12:24:07)
	Mods_2017_03
	//  `use  new global var ◊SIA_LoadRtg_63_RF_txt for load ratings 64 and 66
	
End if 

C_TIME:C306($dImportFile; $dImportRpt)
C_TEXT:C284($path; $file; $text)
C_TEXT:C284($tBuffer; $tNBI)
C_LONGINT:C283($counter; $recnum)
C_TEXT:C284($brkey)  // Command Replaced was o_C_STRING length was 12
C_TEXT:C284($sdate)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283(vBIN_Dec)

//Initialize bridge key array
ALL RECORDS:C47([Bridge MHD NBIS:1])
ARRAY TEXT:C222($abridgekey; 0)  //Command Replaced was o_ARRAY string length was 12
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Bridge Key:2; $abridgekey)

NewWindow(200; 30; 0; 4; "Importing")
$counter:=0
$dImportFile:=Open document:C264(""; "TEXT")  //Prompt user

//21-aug-2001 : added following to create a Import report
vdImpFile:=$dImportFile
$path:=GetPath

$file:=$path+"Import FED Record Report"
$dImportRpt:=Create document:C266($file)
$text:="Import FED Record Report"+(2*<>sCR)
SEND PACKET:C103($dImportRpt; $text)
//end of 21-aug-2001

//read in the first record
RECEIVE PACKET:C104($dImportFile; $tBuffer; <>sCR)
$tNBI:=$tBuffer
// 2-10-2000 : CM - Line removed
//RECEIVE PACKET($dImportFile;$tBuffer;1)  `read in line feed character
While (Ok=1)
	// 2-10-2000 : CM
	// Modification to account for CRLF or just CR records
	If (Substring:C12($tNBI; 1; 1)=<>sLF)
		//if 1st char is a LF then skip it    
		$tNBI:=Substring:C12($tNBI; 2)
	End if 
	
	$brkey:=Substring:C12($tNBI; 7; 12)
	$recnum:=Find in array:C230($abridgekey; $brkey)
	If ($recnum>0)
		GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; $recnum)
		GOTO XY:C161(1; 1)  // 2-10-2000 : CM 
		MESSAGE:C88("Updating record "+$brkey)
		//     10-10-2000 : CM Else statement that was here moved to bottom of routine
		//     to avoid creating new records
		[Bridge MHD NBIS:1]Item5:59:=Substring:C12($tNBI; 19; 9)
		[Bridge MHD NBIS:1]Item2:60:=Substring:C12($tNBI; 28; 2)
		[Bridge MHD NBIS:1]Item3:61:=Substring:C12($tNBI; 30; 3)
		[Bridge MHD NBIS:1]Item4:62:=Substring:C12($tNBI; 33; 5)
		[Bridge MHD NBIS:1]Item6A:63:=Substring:C12($tNBI; 38; 24)
		[Bridge MHD NBIS:1]Item6B:64:=(Substring:C12($tNBI; 62; 1)="*")
		[Bridge MHD NBIS:1]Item7:65:=Substring:C12($tNBI; 63; 18)
		[Bridge MHD NBIS:1]Item9:66:=Substring:C12($tNBI; 81; 25)
		[Bridge MHD NBIS:1]Item10:102:=Num:C11(Substring:C12($tNBI; 106; 4))/100
		[Bridge MHD NBIS:1]Item11:67:=Num:C11(Substring:C12($tNBI; 110; 7))/1000
		[Bridge MHD NBIS:1]Item12:196:=(Substring:C12($tNBI; 117; 1)="1")
		[Bridge MHD NBIS:1]Item 13A:197:=Substring:C12($tNBI; 118; 10)
		[Bridge MHD NBIS:1]Item 13B:198:=Substring:C12($tNBI; 128; 2)
		[Bridge MHD NBIS:1]Item16A:68:=Num:C11(Substring:C12($tNBI; 130; 2))
		[Bridge MHD NBIS:1]Item16B:69:=Num:C11(Substring:C12($tNBI; 132; 2))
		[Bridge MHD NBIS:1]Item16C:109:=Num:C11(Substring:C12($tNBI; 134; 4))/100
		[Bridge MHD NBIS:1]Item17A:70:=Num:C11(Substring:C12($tNBI; 138; 3))
		[Bridge MHD NBIS:1]Item17B:71:=Num:C11(Substring:C12($tNBI; 141; 2))
		[Bridge MHD NBIS:1]Item17C:136:=Num:C11(Substring:C12($tNBI; 143; 4))/100
		[Bridge MHD NBIS:1]Item19:91:=Num:C11(Substring:C12($tNBI; 147; 3))
		[Bridge MHD NBIS:1]Item20:126:=Substring:C12($tNBI; 150; 1)
		[Bridge MHD NBIS:1]Item21:127:=Substring:C12($tNBI; 151; 2)
		[Bridge MHD NBIS:1]Item22:128:=Substring:C12($tNBI; 153; 2)
		[Bridge MHD NBIS:1]Item26:120:=Substring:C12($tNBI; 155; 2)
		[Bridge MHD NBIS:1]Item27:83:=Num:C11(Substring:C12($tNBI; 157; 4))
		[Bridge MHD NBIS:1]Item28A:86:=Num:C11(Substring:C12($tNBI; 161; 2))
		[Bridge MHD NBIS:1]Item28B:87:=Num:C11(Substring:C12($tNBI; 163; 2))
		[Bridge MHD NBIS:1]Item29:88:=Num:C11(Substring:C12($tNBI; 165; 6))
		[Bridge MHD NBIS:1]Item30:89:=Num:C11(Substring:C12($tNBI; 171; 4))
		[Bridge MHD NBIS:1]Item31:135:=Substring:C12($tNBI; 175; 1)
		[Bridge MHD NBIS:1]Item32:98:=Num:C11(Substring:C12($tNBI; 176; 4))/10
		[Bridge MHD NBIS:1]Item33:99:=Substring:C12($tNBI; 180; 1)
		[Bridge MHD NBIS:1]Item34:100:=Num:C11(Substring:C12($tNBI; 181; 2))
		[Bridge MHD NBIS:1]Item35:101:=(Substring:C12($tNBI; 183; 1)="1")
		[Bridge MHD NBIS:1]Item36A:147:=Substring:C12($tNBI; 184; 1)
		[Bridge MHD NBIS:1]Item36B:148:=Substring:C12($tNBI; 185; 1)
		[Bridge MHD NBIS:1]Item36C:149:=Substring:C12($tNBI; 186; 1)
		[Bridge MHD NBIS:1]Item36D:150:=Substring:C12($tNBI; 187; 1)
		[Bridge MHD NBIS:1]Item37:129:=Substring:C12($tNBI; 188; 1)
		[Bridge MHD NBIS:1]Item38:113:=Substring:C12($tNBI; 189; 1)
		[Bridge MHD NBIS:1]Item39:115:=Num:C11(Substring:C12($tNBI; 190; 4))/10
		[Bridge MHD NBIS:1]Item40:117:=Num:C11(Substring:C12($tNBI; 194; 5))/10
		[Bridge MHD NBIS:1]Item41:141:=Substring:C12($tNBI; 199; 1)
		[Bridge MHD NBIS:1]Item42:85:=Substring:C12($tNBI; 200; 2)
		[Bridge MHD NBIS:1]Item43:75:=Substring:C12($tNBI; 202; 3)
		[Bridge MHD NBIS:1]Item44:76:=Substring:C12($tNBI; 205; 3)
		[Bridge MHD NBIS:1]Item45:77:=Num:C11(Substring:C12($tNBI; 208; 3))
		[Bridge MHD NBIS:1]Item46:78:=Num:C11(Substring:C12($tNBI; 211; 4))
		[Bridge MHD NBIS:1]Item47:104:=Num:C11(Substring:C12($tNBI; 215; 3))/10
		[Bridge MHD NBIS:1]Item48:92:=Num:C11(Substring:C12($tNBI; 218; 5))/10
		[Bridge MHD NBIS:1]Item49:93:=Num:C11(Substring:C12($tNBI; 223; 6))/10
		[Bridge MHD NBIS:1]Item50A:94:=Num:C11(Substring:C12($tNBI; 229; 3))/10
		[Bridge MHD NBIS:1]Item50B:95:=Num:C11(Substring:C12($tNBI; 232; 3))/10
		[Bridge MHD NBIS:1]Item51:96:=Num:C11(Substring:C12($tNBI; 235; 4))/10
		[Bridge MHD NBIS:1]Item52:97:=Num:C11(Substring:C12($tNBI; 239; 4))/10
		[Bridge MHD NBIS:1]Item53:105:=Num:C11(Substring:C12($tNBI; 243; 4))/100
		[Bridge MHD NBIS:1]Item54A:107:=Substring:C12($tNBI; 247; 1)
		[Bridge MHD NBIS:1]Item54B:108:=Num:C11(Substring:C12($tNBI; 248; 4))/100
		[Bridge MHD NBIS:1]Item55A:110:=Substring:C12($tNBI; 252; 1)
		[Bridge MHD NBIS:1]Item55B:111:=Num:C11(Substring:C12($tNBI; 253; 3))/10
		[Bridge MHD NBIS:1]Item56:112:=Num:C11(Substring:C12($tNBI; 256; 3))/10
		[Bridge MHD NBIS:1]Item58:130:=Substring:C12($tNBI; 259; 1)
		[Bridge MHD NBIS:1]Item59:131:=Substring:C12($tNBI; 260; 1)
		[Bridge MHD NBIS:1]Item60:132:=Substring:C12($tNBI; 261; 1)
		[Bridge MHD NBIS:1]Item61:133:=Substring:C12($tNBI; 262; 1)
		[Bridge MHD NBIS:1]Item62:134:=Substring:C12($tNBI; 263; 1)
		[Bridge MHD NBIS:1]Item 63:199:=Substring:C12($tNBI; 264; 1)
		
		If (Position:C15([Bridge MHD NBIS:1]Item 63:199; <>SIA_LoadRtg_63_RF_txt)>0)
			[Bridge MHD NBIS:1]Item64:137:=Num:C11(Substring:C12($tNBI; 265; 3))/100
		Else 
			[Bridge MHD NBIS:1]Item64:137:=Num:C11(Substring:C12($tNBI; 265; 3))/10
		End if 
		
		[Bridge MHD NBIS:1]Item 65:200:=Substring:C12($tNBI; 268; 1)
		
		If (Position:C15([Bridge MHD NBIS:1]Item 65:200; <>SIA_LoadRtg_63_RF_txt)>0)
			[Bridge MHD NBIS:1]Item66:139:=Num:C11(Substring:C12($tNBI; 269; 3))/100
		Else 
			[Bridge MHD NBIS:1]Item66:139:=Num:C11(Substring:C12($tNBI; 269; 3))/10
		End if 
		
		[Bridge MHD NBIS:1]Item67:142:=Substring:C12($tNBI; 272; 1)
		[Bridge MHD NBIS:1]Item68:143:=Substring:C12($tNBI; 273; 1)
		[Bridge MHD NBIS:1]Item69:144:=Substring:C12($tNBI; 274; 1)
		[Bridge MHD NBIS:1]Item70:140:=Substring:C12($tNBI; 275; 1)
		[Bridge MHD NBIS:1]Item71:145:=Substring:C12($tNBI; 276; 1)
		[Bridge MHD NBIS:1]Item72:146:=Substring:C12($tNBI; 277; 1)
		[Bridge MHD NBIS:1]Item75A:152:=Substring:C12($tNBI; 278; 2)
		[Bridge MHD NBIS:1]Item75B:153:=Substring:C12($tNBI; 280; 1)
		[Bridge MHD NBIS:1]Item76:154:=Num:C11(Substring:C12($tNBI; 281; 6))/10
		$sdate:=Substring:C12($tNBI; 287; 4)
		//      10-10-2000 : CM following line changed
		// If (Num(Substring($sdate;2;2))<50)
		If (Num:C11(Substring:C12($sdate; 3; 2))<50)
			$sdate:=Insert string:C231($sdate; "/01/20"; 3)  //Y2000 problem
		Else 
			$sdate:=Insert string:C231($sdate; "/01/19"; 3)
		End if 
		[Bridge MHD NBIS:1]Item90:161:=Date:C102($sdate)
		[Bridge MHD NBIS:1]Item91:162:=Num:C11(Substring:C12($tNBI; 291; 2))
		[Bridge MHD NBIS:1]Item92AA:163:=(Substring:C12($tNBI; 293; 1)="Y")
		[Bridge MHD NBIS:1]Item92AB:164:=Num:C11(Substring:C12($tNBI; 294; 2))
		[Bridge MHD NBIS:1]Item92BA:165:=(Substring:C12($tNBI; 296; 1)="Y")
		[Bridge MHD NBIS:1]Item92BB:166:=Num:C11(Substring:C12($tNBI; 297; 2))
		[Bridge MHD NBIS:1]Item92CA:167:=(Substring:C12($tNBI; 299; 1)="Y")
		[Bridge MHD NBIS:1]Item92CB:168:=Num:C11(Substring:C12($tNBI; 300; 2))
		$sdate:=Substring:C12($tNBI; 302; 4)
		//      10-10-2000 : CM following line changed
		// If (Num(Substring($sdate;2;2))<50)
		If (Num:C11(Substring:C12($sdate; 3; 2))<50)
			$sdate:=Insert string:C231($sdate; "/01/20"; 3)  //Y2000 problem
		Else 
			$sdate:=Insert string:C231($sdate; "/01/19"; 3)
		End if 
		[Bridge MHD NBIS:1]Item93A:169:=Date:C102($sdate)
		$sdate:=Substring:C12($tNBI; 306; 4)
		//      10-10-2000 : CM following line changed
		// If (Num(Substring($sdate;2;2))<50)
		If (Num:C11(Substring:C12($sdate; 3; 2))<50)
			$sdate:=Insert string:C231($sdate; "/01/20"; 3)  //Y2000 problem
		Else 
			$sdate:=Insert string:C231($sdate; "/01/19"; 3)
		End if 
		[Bridge MHD NBIS:1]Item93B:170:=Date:C102($sdate)
		$sdate:=Substring:C12($tNBI; 310; 4)
		//      10-10-2000 : CM following line changed
		// If (Num(Substring($sdate;2;2))<50)
		If (Num:C11(Substring:C12($sdate; 3; 2))<50)
			$sdate:=Insert string:C231($sdate; "/01/20"; 3)  //Y2000 problem
		Else 
			$sdate:=Insert string:C231($sdate; "/01/19"; 3)
		End if 
		[Bridge MHD NBIS:1]Item93C:171:=Date:C102($sdate)
		[Bridge MHD NBIS:1]Item94:155:=Num:C11(Substring:C12($tNBI; 314; 6))
		[Bridge MHD NBIS:1]Item95:156:=Num:C11(Substring:C12($tNBI; 320; 6))
		[Bridge MHD NBIS:1]Item96:157:=Num:C11(Substring:C12($tNBI; 326; 6))
		[Bridge MHD NBIS:1]Item97:158:=Num:C11(Substring:C12($tNBI; 332; 4))
		[Bridge MHD NBIS:1]Item98A:72:=Substring:C12($tNBI; 336; 3)
		[Bridge MHD NBIS:1]Item98B:73:=Substring:C12($tNBI; 339; 2)
		[Bridge MHD NBIS:1]Item99:74:=Substring:C12($tNBI; 341; 15)
		[Bridge MHD NBIS:1]Item100:121:=Substring:C12($tNBI; 356; 1)
		[Bridge MHD NBIS:1]Item101:122:=Substring:C12($tNBI; 357; 1)
		[Bridge MHD NBIS:1]Item102:123:=Substring:C12($tNBI; 358; 1)
		[Bridge MHD NBIS:1]Item103:124:=(Substring:C12($tNBI; 359; 1)="T")
		[Bridge MHD NBIS:1]Item104:119:=(Substring:C12($tNBI; 360; 1)="1")
		[Bridge MHD NBIS:1]Item 105:201:=Substring:C12($tNBI; 361; 1)
		[Bridge MHD NBIS:1]Item106:84:=Num:C11(Substring:C12($tNBI; 362; 4))
		[Bridge MHD NBIS:1]Item107:79:=Substring:C12($tNBI; 366; 1)
		[Bridge MHD NBIS:1]Item108A:80:=Substring:C12($tNBI; 367; 1)
		[Bridge MHD NBIS:1]Item108B:81:=Substring:C12($tNBI; 368; 1)
		[Bridge MHD NBIS:1]Item108C:82:=Substring:C12($tNBI; 369; 1)
		[Bridge MHD NBIS:1]Item109:90:=Num:C11(Substring:C12($tNBI; 370; 2))
		[Bridge MHD NBIS:1]Item110:125:=(Substring:C12($tNBI; 372; 1)="1")
		[Bridge MHD NBIS:1]Item111:114:=Substring:C12($tNBI; 373; 1)
		[Bridge MHD NBIS:1]Item112:118:=(Substring:C12($tNBI; 374; 1)="Y")
		[Bridge MHD NBIS:1]Item113:151:=Substring:C12($tNBI; 375; 1)
		[Bridge MHD NBIS:1]Item114:159:=Num:C11(Substring:C12($tNBI; 376; 6))
		[Bridge MHD NBIS:1]Item115:160:=Num:C11(Substring:C12($tNBI; 382; 4))
		[Bridge MHD NBIS:1]Item116:116:=Num:C11(Substring:C12($tNBI; 386; 4))/10
		[Bridge MHD NBIS:1]FHWA Select:4:=False:C215
		[Bridge MHD NBIS:1]AASHTO:5:=AASHTO_SuffRat
		[Bridge MHD NBIS:1]StructDef:103:=(bDeficient & bFuncObsCheck & ([Bridge MHD NBIS:1]AASHTO:5<80))
		[Bridge MHD NBIS:1]FunctObs:106:=(bObsolete & bFuncObsCheck & ([Bridge MHD NBIS:1]AASHTO:5<80))
		[Bridge MHD NBIS:1]OnSystem:138:=bOnSystem
		[Bridge MHD NBIS:1]InspResp:173:="FED"
		[Bridge MHD NBIS:1]FHWARecord:174:=False:C215
		SAVE RECORD:C53([Bridge MHD NBIS:1])  //Save record resets the Ok variable so we must read a record
		//     10-10-2000 : CM This Else statement moved from  top of IF($recnum>0)
	Else 
		//   10-10-2000 : CM
		//21-aug-2001 : modified from ALERT to send detail info to report file.
		SEND PACKET:C103($dImportRpt; "Import Record with Bridge Key "+$brkey+" not found in Database")
		SEND PACKET:C103($dImportRpt; <>sCR)
		$text:="Item5="+Substring:C12($tNBI; 19; 9)+<>sCR
		$text:=$text+"Item2="+Substring:C12($tNBI; 28; 2)+<>sCR
		$text:=$text+"Item3="+Substring:C12($tNBI; 30; 3)+<>sCR
		$text:=$text+"Item4="+Substring:C12($tNBI; 33; 5)+<>sCR
		$text:=$text+"Item6A="+Substring:C12($tNBI; 38; 24)+<>sCR
		$text:=$text+"Item7="+Substring:C12($tNBI; 63; 18)+<>sCR
		$text:=$text+"Item9="+Substring:C12($tNBI; 81; 25)+<>sCR+<>sCR
		SEND PACKET:C103($dImportRpt; $text)
		//    10-10-2000 : CM   commented out following code ******    
		//    CREATE RECORD([Bridge MHD NBIS])
		//    Inc_Sequence ("BIN";->vBIN_Dec)
		//    [Bridge MHD NBIS]BIN:=ConvertBIN (vBIN_Dec)
		//    [Bridge MHD NBIS]Bridge Key:=$brkey
		//    $place_code:=Substring($tNBI;33;5)
		//   $i:=Find in array(◊aPlace_Code;$place_code)
		//    If ($i>0)
		//      [Bridge MHD NBIS]Town Name:=◊aTownName{$i}
		//      [Bridge MHD NBIS]BDEPT:=
		//           Get_BDEPT ([Bridge MHD NBIS]Town Name)
		//      $counter:=$counter+1
		//     GOTO XY(1;1)  ` 2-10-2000 : CM 
		//     MESSAGE("New Record "+String($counter))
		//  End if 
		//     10-10-2000 : CM
		//   *******  Remove code ends here
	End if 
	
	//read in a record-this must follow
	RECEIVE PACKET:C104($dImportFile; $tBuffer; <>sCR)
	$tNBI:=$tBuffer
	//  2-10-2000 : CM - Line removed
	//RECEIVE PACKET($dImportFile;$tBuffer;1)  `read in line feed character for a DOS
End while 
CLOSE DOCUMENT:C267($dImportFile)
CLOSE DOCUMENT:C267($dImportRpt)  //21-aug-2001 : added to close report