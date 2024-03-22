//Method: [Bridge MHD NBIS].Rating Evalu 10y.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 07/18/17, 14:01:45
	// ----------------------------------------------------
	//Created : 
	Mods_2017_07_bug
End if 
//

//_O_PAGE SETUP([Bridge MHD NBIS]; "Rating Evalu 10y")
FORM SET OUTPUT:C54([Bridge MHD NBIS:1]; "Rating Evalu 10y")
PRINT SETTINGS:C106
If (OK=1)
	SET BLOB SIZE:C606(report_blb; 0)
	C_TEXT:C284($Title_txt)
	
	$Title_txt:=OBJECT Get title:C1068(*; "RatedValue")
	TEXT TO BLOB:C554("RatedValue"; report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554(Char:C90(Tab:K15:37); report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554($Title_txt; report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554(Char:C90(Carriage return:K15:38); report_blb; UTF8 text without length:K22:17; *)
	
	$Title_txt:=OBJECT Get title:C1068(*; "HighPriority")
	TEXT TO BLOB:C554("HighPriority"; report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554(Char:C90(Tab:K15:37); report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554($Title_txt; report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554(Char:C90(Carriage return:K15:38); report_blb; UTF8 text without length:K22:17; *)
	
	$Title_txt:=OBJECT Get title:C1068(*; "MediumPriority")
	TEXT TO BLOB:C554("MediumPriority"; report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554(Char:C90(Tab:K15:37); report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554($Title_txt; report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554(Char:C90(Carriage return:K15:38); report_blb; UTF8 text without length:K22:17; *)
	
	$Title_txt:=OBJECT Get title:C1068(*; "LowPriority")
	TEXT TO BLOB:C554("LowPriority"; report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554(Char:C90(Tab:K15:37); report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554($Title_txt; report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554(Char:C90(Carriage return:K15:38); report_blb; UTF8 text without length:K22:17; *)
	
	$Title_txt:=OBJECT Get title:C1068(*; "NoRatingNeeded")
	TEXT TO BLOB:C554("NoRatingNeeded"; report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554(Char:C90(Tab:K15:37); report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554($Title_txt; report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554(Char:C90(Carriage return:K15:38); report_blb; UTF8 text without length:K22:17; *)
	
	$Title_txt:=OBJECT Get title:C1068(*; "CurbRevealNO")
	TEXT TO BLOB:C554("CurbRevealNO"; report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554(Char:C90(Tab:K15:37); report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554($Title_txt; report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554(Char:C90(Carriage return:K15:38); report_blb; UTF8 text without length:K22:17; *)
	
	
	$Title_txt:=OBJECT Get title:C1068(*; "CurbRevealSO")
	TEXT TO BLOB:C554("CurbRevealSO"; report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554(Char:C90(Tab:K15:37); report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554($Title_txt; report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554(Char:C90(Carriage return:K15:38); report_blb; UTF8 text without length:K22:17; *)
	
	
	$Title_txt:=OBJECT Get title:C1068(*; "DBIE")
	TEXT TO BLOB:C554("DBIE"; report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554(Char:C90(Tab:K15:37); report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554($Title_txt; report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554(Char:C90(Carriage return:K15:38); report_blb; UTF8 text without length:K22:17; *)
	
	$Title_txt:=OBJECT Get title:C1068(*; "EvalDate")
	TEXT TO BLOB:C554("EvalDate"; report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554(Char:C90(Tab:K15:37); report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554($Title_txt; report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554(Char:C90(Carriage return:K15:38); report_blb; UTF8 text without length:K22:17; *)
	
	$Title_txt:=OBJECT Get title:C1068(*; "AreaEngineer")
	TEXT TO BLOB:C554("AreaEngineer"; report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554(Char:C90(Tab:K15:37); report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554($Title_txt; report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554(Char:C90(Carriage return:K15:38); report_blb; UTF8 text without length:K22:17; *)
	
	Print form:C5([Bridge MHD NBIS:1]; "Rating Evalu 10y"; Form detail:K43:1)
	SET BLOB SIZE:C606(report_blb; 0)
End if 
CANCEL:C270
//End [Bridge MHD NBIS].Rating Evalu 10y.Button