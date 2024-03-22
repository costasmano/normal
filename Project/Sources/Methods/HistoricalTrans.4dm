//%attributes = {}
//GP HistoricalTrans
//Copyright © 1998, Thomas D. Nee, All Rights Reserved.

//Return the NBI Coding Guide value for Item 37, Historical Significance.
//It is a number betwwen 1 and 5.  MHD's internal code uses various characters.

//Two interprocess variables, set in INIT_UI_GV, are used to translate
//Historical Significance between the internal MHD code and NBI Item 37.
//C_STRING(11;◊Item37FHWA;◊Item37Code)
//◊Item37FHWA:="12235334435"  `NBI Coding Guide
//◊Item37Code:="HEPANCR ?XZ"  `MHD internal code
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(10/18/11 13:12:00)
	Mods_2011_10
	//  `Added Optional param
End if 

C_TEXT:C284($0; $Item37)  // Command Replaced was o_C_STRING length was 1
C_LONGINT:C283($viPos)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($code_txt)

If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$code_txt:=$1
Else 
	$code_txt:=[Bridge MHD NBIS:1]Item37:129
End if 
$viPos:=Position:C15($code_txt; <>Item37code)
If (($viPos>0) & ($viPos<=Length:C16(<>Item37FHWA)))
	$Item37:=<>Item37FHWA[[$viPos]]
Else 
	$Item37:="4"
End if 

$0:=$Item37