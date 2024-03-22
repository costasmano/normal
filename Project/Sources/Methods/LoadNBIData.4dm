//%attributes = {"invisible":true}
// Method: LoadNBIData
// Description
//  ` Parse a text line to NBI data items. The text should be a record line
//  ` formatted the same as the NBI submission tape. Will update the 
//  ` current record with the values extracted from the 'tape record'.
//  ` Can do either a Primary or Secondary record.
// 
// Parameters
// $1 : $tNBI : Text to parse
// $2 : $RecType [optional] ("Primary" | "Secondary")
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/09/08, 18:57:11
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
	// Modified by: Costas Manousakis-(Designer)-(4/5/12 )
	Mods_2012_04
	//  `adjustments to the date calculations
	// Modified by: Costas Manousakis-(Designer)-(3/1/17 12:24:07)
	Mods_2017_03
	//  `use  new global var ◊SIA_LoadRtg_63_RF_txt for load ratings 64 and 66
	
End if 
C_TEXT:C284($1; $tNBI; $RecType)
$tNBI:=$1
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	$RecType:=$2
Else 
	$RecType:="Primary"
End if 
C_TEXT:C284($sdate)  // Command Replaced was o_C_STRING length was 255
Case of 
	: ($RecType="Primary")
		
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
		C_LONGINT:C283($ThisCentury_L; $ThisDecade_L)
		$ThisCentury_L:=Year of:C25(Current date:C33(*))
		$ThisDecade_L:=$ThisCentury_L%100
		$ThisCentury_L:=($ThisCentury_L-$ThisDecade_L)/100
		If (Num:C11(Substring:C12($sdate; 3; 2))<$ThisDecade_L)
			$sdate:=Insert string:C231($sdate; ("/01/"+String:C10($ThisCentury_L)); 3)  //Y2000 problem
		Else 
			$sdate:=Insert string:C231($sdate; "/01/"+String:C10($ThisCentury_L-1); 3)
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
		If (Num:C11(Substring:C12($sdate; 3; 2))<$ThisDecade_L)
			$sdate:=Insert string:C231($sdate; ("/01/"+String:C10($ThisCentury_L)); 3)  //Y2000 problem
		Else 
			$sdate:=Insert string:C231($sdate; "/01/"+String:C10($ThisCentury_L-1); 3)
		End if 
		[Bridge MHD NBIS:1]Item93A:169:=Date:C102($sdate)
		$sdate:=Substring:C12($tNBI; 306; 4)
		//      10-10-2000 : CM following line changed
		// If (Num(Substring($sdate;2;2))<50)
		If (Num:C11(Substring:C12($sdate; 3; 2))<$ThisDecade_L)
			$sdate:=Insert string:C231($sdate; ("/01/"+String:C10($ThisCentury_L)); 3)  //Y2000 problem
		Else 
			$sdate:=Insert string:C231($sdate; "/01/"+String:C10($ThisCentury_L-1); 3)
		End if 
		[Bridge MHD NBIS:1]Item93B:170:=Date:C102($sdate)
		$sdate:=Substring:C12($tNBI; 310; 4)
		//      10-10-2000 : CM following line changed
		// If (Num(Substring($sdate;2;2))<50)
		If (Num:C11(Substring:C12($sdate; 3; 2))<$ThisDecade_L)
			$sdate:=Insert string:C231($sdate; ("/01/"+String:C10($ThisCentury_L)); 3)  //Y2000 problem
		Else 
			$sdate:=Insert string:C231($sdate; "/01/"+String:C10($ThisCentury_L-1); 3)
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
		
	: ($RecType="Secondary")
		
		[NBIS Secondary:3]Item5:4:=Substring:C12($tNBI; 19; 9)
		[NBIS Secondary:3]Item3:2:=Substring:C12($tNBI; 30; 3)
		[NBIS Secondary:3]Item4:3:=Substring:C12($tNBI; 33; 5)
		[NBIS Secondary:3]Item6A:5:=Substring:C12($tNBI; 38; 24)
		[NBIS Secondary:3]Item6B:6:=(Substring:C12($tNBI; 62; 1)="*")
		[NBIS Secondary:3]Item7:7:=Substring:C12($tNBI; 63; 18)
		[NBIS Secondary:3]Item9:8:=Substring:C12($tNBI; 81; 25)
		[NBIS Secondary:3]Item10:9:=Num:C11(Substring:C12($tNBI; 106; 4))/100
		[NBIS Secondary:3]Item11:11:=Num:C11(Substring:C12($tNBI; 110; 7))/1000
		[NBIS Secondary:3]Item16A:12:=Num:C11(Substring:C12($tNBI; 130; 2))
		[NBIS Secondary:3]Item16B:13:=Num:C11(Substring:C12($tNBI; 132; 2))
		[NBIS Secondary:3]Item16C:35:=Num:C11(Substring:C12($tNBI; 134; 4))/100
		[NBIS Secondary:3]Item17A:14:=Num:C11(Substring:C12($tNBI; 138; 3))
		[NBIS Secondary:3]Item17B:15:=Num:C11(Substring:C12($tNBI; 141; 2))
		[NBIS Secondary:3]Item17C:36:=Num:C11(Substring:C12($tNBI; 143; 4))/100
		[NBIS Secondary:3]Item19:16:=Num:C11(Substring:C12($tNBI; 147; 3))
		[NBIS Secondary:3]Item20:17:=Substring:C12($tNBI; 150; 1)
		[NBIS Secondary:3]Item26:18:=Substring:C12($tNBI; 155; 2)
		[NBIS Secondary:3]Item27:19:=Num:C11(Substring:C12($tNBI; 157; 4))
		[NBIS Secondary:3]Item28A:20:=Num:C11(Substring:C12($tNBI; 161; 2))
		[NBIS Secondary:3]Item28B:21:=Num:C11(Substring:C12($tNBI; 163; 2))
		[NBIS Secondary:3]Item29:22:=Num:C11(Substring:C12($tNBI; 165; 6))
		[NBIS Secondary:3]Item30:37:=Num:C11(Substring:C12($tNBI; 171; 4))
		[NBIS Secondary:3]Item42:23:=Substring:C12($tNBI; 200; 2)
		[NBIS Secondary:3]Item43:24:=Substring:C12($tNBI; 202; 3)
		[NBIS Secondary:3]Item47:25:=Num:C11(Substring:C12($tNBI; 215; 3))/10
		[NBIS Secondary:3]Item48:26:=Num:C11(Substring:C12($tNBI; 218; 5))/10
		[NBIS Secondary:3]Item49:27:=Num:C11(Substring:C12($tNBI; 223; 6))/10
		[NBIS Secondary:3]Item100:28:=Substring:C12($tNBI; 356; 1)
		[NBIS Secondary:3]Item101:29:=Substring:C12($tNBI; 357; 1)
		[NBIS Secondary:3]Item102:30:=Substring:C12($tNBI; 358; 1)
		[NBIS Secondary:3]Item103:31:=(Substring:C12($tNBI; 359; 1)="T")
		[NBIS Secondary:3]Item104:32:=(Substring:C12($tNBI; 360; 1)="1")
		[NBIS Secondary:3]Item109:10:=Num:C11(Substring:C12($tNBI; 370; 2))
		[NBIS Secondary:3]Item110:33:=(Substring:C12($tNBI; 372; 1)="1")
		
End case 