//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// SQL_sp_Update_NBI_Data
	// User name (OS): 
	// Date and time: 05/24/05, 10:35:17
	// ----------------------------------------------------
	// Description
	// This method will set up sql state for stored proce named as method name
	//$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings ()+$SingleQuote_s+", "`STRINGS
	//$SQLStatement_txt:=$SQLStatement_txt+String([Bridge MHD NBIS]Item10)+", "`NUMBERS
	
	// Parameters
	//none
	// ----------------------------------------------------
	Mods_2005_CJM04
	Mods_2005_CJM04  //Modify to pass corrected True false data for following fields
	//[Bridge MHD NBIS]Item12 False = 0, True = 1
	//[Bridge MHD NBIS]Item35 False = 0, True = 1
	//[Bridge MHD NBIS]Item92AA False = N, True = Y
	//[Bridge MHD NBIS]Item92BA False = N, True = Y
	//[Bridge MHD NBIS]Item92CA False = N, True = Y
	//[Bridge MHD NBIS]Item103 False = " ", True = T
	//[Bridge MHD NBIS]Item104 False = 0, True = 1
	//[Bridge MHD NBIS]Item110 False = 0, True = 1
	//[Bridge MHD NBIS]Item112 False = N, True = Y
	//Modified following to use function call HistoricalTrans
	//[Bridge MHD NBIS]item37 
	//checked item111 and item113
	// Modified by: Costas Manousakis-(Designer)-(3/1/17 12:38:21)
	Mods_2017_03
	//  `use ◊SIA_LoadRtg_63_RF_txt for the rating loads 64 and 66
End if 
C_TEXT:C284($0; $SQLStatement_txt)
C_TEXT:C284($SingleQuote_s; $QuoteMark_s)  // Command Replaced was o_C_STRING length was 1
$SingleQuote_s:=Char:C90(39)
$QuoteMark_s:=Char:C90(34)


$SQLStatement_txt:=""

C_TEXT:C284($Spaces_txt)

$SQLStatement_txt:=$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item2:60)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item3:61)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item4:62)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item5:59)+$SingleQuote_s+", "
$Spaces_txt:=" "*24
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+Change string:C234($Spaces_txt; SQL_SetUpStrings([Bridge MHD NBIS:1]Item6A:63); 1)+$SingleQuote_s+", "
$Spaces_txt:=" "*18
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+Change string:C234($Spaces_txt; SQL_SetUpStrings([Bridge MHD NBIS:1]Item7:65); 1)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item8:206)+$SingleQuote_s+", "
$Spaces_txt:=" "*25
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+Change string:C234($Spaces_txt; SQL_SetUpStrings([Bridge MHD NBIS:1]Item9:66); 1)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item10:102; 2))+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item11:67; 3))+", "
If ([Bridge MHD NBIS:1]Item12:196)
	$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+"1"+$SingleQuote_s+", "
Else 
	$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+"0"+$SingleQuote_s+", "
End if 
$Spaces_txt:=" "*10
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+Change string:C234($Spaces_txt; SQL_SetUpStrings([Bridge MHD NBIS:1]Item 13A:197); 1)+$SingleQuote_s+", "
$Spaces_txt:=" "*2
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+Change string:C234($Spaces_txt; SQL_SetUpStrings([Bridge MHD NBIS:1]Item 13B:198); 1)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([Bridge MHD NBIS:1]Item16A:68; "00")+String:C10([Bridge MHD NBIS:1]Item16B:69; "00")+String:C10(Round:C94([Bridge MHD NBIS:1]Item16C:109; 2); "0000")+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([Bridge MHD NBIS:1]Item17A:70; "00")+String:C10([Bridge MHD NBIS:1]Item17B:71; "00")+String:C10(Round:C94([Bridge MHD NBIS:1]Item17C:136; 2); "0000")+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([Bridge MHD NBIS:1]Item19:91)+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item20:126)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item21:127)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item22:128)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item26:120)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([Bridge MHD NBIS:1]Item27:83)+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([Bridge MHD NBIS:1]Item28A:86)+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([Bridge MHD NBIS:1]Item28B:87)+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([Bridge MHD NBIS:1]Item29:88)+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([Bridge MHD NBIS:1]Item30:89)+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item31:135)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item32:98; 1))+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item33:99)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([Bridge MHD NBIS:1]Item34:100)+", "

If ([Bridge MHD NBIS:1]Item35:101)
	$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+"1"+$SingleQuote_s+", "
Else 
	$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+"0"+$SingleQuote_s+", "
End if 

$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item36A:147)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item36B:148)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item36C:149)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item36D:150)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings(HistoricalTrans)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item38:113)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([Bridge MHD NBIS:1]Item39:115)+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item40:117; 1))+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item41:141)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item42:85)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item43:75)+$SingleQuote_s+", "
$Spaces_txt:=" "*3
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+Change string:C234($Spaces_txt; SQL_SetUpStrings([Bridge MHD NBIS:1]Item44:76); 1)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([Bridge MHD NBIS:1]Item45:77)+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([Bridge MHD NBIS:1]Item46:78)+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item47:104; 1))+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item48:92; 1))+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item49:93; 1))+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item50A:94; 1))+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item50B:95; 1))+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item51:96; 2))+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item52:97; 1))+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item53:105; 2))+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item54A:107)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item54B:108; 2))+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item55A:110)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item55B:111; 2))+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item56:112; 1))+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item58:130)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item59:131)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item60:132)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item61:133)+$SingleQuote_s+", "
$Spaces_txt:=" "*1
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+Change string:C234($Spaces_txt; SQL_SetUpStrings([Bridge MHD NBIS:1]Item62:134); 1)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+Change string:C234($Spaces_txt; SQL_SetUpStrings([Bridge MHD NBIS:1]Item 63:199); 1)+$SingleQuote_s+", "

If (Position:C15([Bridge MHD NBIS:1]Item 63:199; <>SIA_LoadRtg_63_RF_txt)>0)
	$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item64:137; 2))+", "
Else 
	$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item64:137; 1))+", "
End if 

$Spaces_txt:=" "*1
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+Change string:C234($Spaces_txt; SQL_SetUpStrings([Bridge MHD NBIS:1]Item 65:200); 1)+$SingleQuote_s+", "
If (Position:C15([Bridge MHD NBIS:1]Item 65:200; <>SIA_LoadRtg_63_RF_txt)>0)
	$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item66:139; 2))+", "
Else 
	$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item66:139; 1))+", "
End if 
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item67:142)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item68:143)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item69:144)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item70:140)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item71:145)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item72:146)+$SingleQuote_s+", "
$Spaces_txt:=" "*2
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+Change string:C234($Spaces_txt; SQL_SetUpStrings([Bridge MHD NBIS:1]Item75A:152); 1)+$SingleQuote_s+", "
$Spaces_txt:=" "*1
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+Change string:C234($Spaces_txt; SQL_SetUpStrings([Bridge MHD NBIS:1]Item75B:153); 1)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item76:154; 1))+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+String:C10([Bridge MHD NBIS:1]Item90:161; 7)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([Bridge MHD NBIS:1]Item91:162)+", "
If ([Bridge MHD NBIS:1]Item92AA:163)
	$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+"Y"+$SingleQuote_s+", "
Else 
	$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+"N "+$SingleQuote_s+", "
End if 
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item92AB:164; 2))+", "
If ([Bridge MHD NBIS:1]Item92BA:165)
	$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+"Y"+$SingleQuote_s+", "
Else 
	$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+"N"+$SingleQuote_s+", "
End if 
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item92BB:166; 2))+", "
If ([Bridge MHD NBIS:1]Item92CA:167)
	$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+"Y"+$SingleQuote_s+", "
Else 
	$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+"N"+$SingleQuote_s+", "
End if 
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item92CB:168; 2))+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+String:C10([Bridge MHD NBIS:1]Item93A:169; 7)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+String:C10([Bridge MHD NBIS:1]Item93B:170; 7)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+String:C10([Bridge MHD NBIS:1]Item93C:171; 7)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([Bridge MHD NBIS:1]Item94:155)+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([Bridge MHD NBIS:1]Item95:156)+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([Bridge MHD NBIS:1]Item96:157)+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([Bridge MHD NBIS:1]Item97:158)+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item98A:72)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Num:C11([Bridge MHD NBIS:1]Item98B:73))+", "  //treat this one as a number
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item99:74)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item100:121)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item101:122)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item102:123)+$SingleQuote_s+", "
If ([Bridge MHD NBIS:1]Item103:124)
	$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+"T"+$SingleQuote_s+", "
Else 
	$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+" "+$SingleQuote_s+", "
End if 
If ([Bridge MHD NBIS:1]Item104:119)
	$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+"1"+$SingleQuote_s+", "
Else 
	$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+"0"+$SingleQuote_s+", "
End if 

$Spaces_txt:=" "*1
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+Change string:C234($Spaces_txt; SQL_SetUpStrings([Bridge MHD NBIS:1]Item 105:201); 1)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([Bridge MHD NBIS:1]Item106:84)+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item107:79)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item108A:80)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item108B:81)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item108C:82)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([Bridge MHD NBIS:1]Item109:90)+", "
If ([Bridge MHD NBIS:1]Item110:125)
	$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+"1"+$SingleQuote_s+", "
Else 
	$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+"0"+$SingleQuote_s+", "
End if 

$Spaces_txt:=" "*1
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+Change string:C234($Spaces_txt; SQL_SetUpStrings([Bridge MHD NBIS:1]Item111:114); 1)+$SingleQuote_s+", "
If ([Bridge MHD NBIS:1]Item112:118)
	$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+"Y"+$SingleQuote_s+", "
Else 
	$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+"N"+$SingleQuote_s+", "
End if 
If ([Bridge MHD NBIS:1]Item113:151="D")
	$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+"6"+$SingleQuote_s+", "
Else 
	$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item113:151)+$SingleQuote_s+", "
End if 
$SQLStatement_txt:=$SQLStatement_txt+String:C10([Bridge MHD NBIS:1]Item114:159)+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item115:160; 1))+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([Bridge MHD NBIS:1]Item116:116)+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Bridge Name:29)+$SingleQuote_s+" "

$0:=$SQLStatement_txt

//End SQL_sp_Update_NBI_Data