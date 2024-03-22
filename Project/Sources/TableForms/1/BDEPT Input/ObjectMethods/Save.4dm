// ----------------------------------------------------
//Object Method: [Bridge MHD NBIS]."BDEPT Input".Save 
// User name (OS): cjmiller
// Date and time: 04/01/08, 15:45:35
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_v55  //r001 `04/01/08, 15:46:12  
	Mods_2008_CJM_v56  //r002 `06/30/08, 11:05:05  `Add code to create include bin record when not replacement
	Mods_2011_06  // CJ Miller`06/20/11, 10:35:22      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(6/22/12 16:48:50)
	Mods_2012_06
	//  `Check if a BIN has been assigned
	// Modified by: Costas Manousakis-(Designer)-(2/26/16 12:55:57)
	Mods_2016_02_bug
	//  `log new record only if the record is a new record. it might have been saved already if user canceled out of the "AssignReplacement.dlg" dialog
	//  ` PRJ_DEBridgeNo_s was coded wrong
	// Modified by: Costas Manousakis-(Designer)-(9/20/19 17:14:02)
	Mods_2019_09_bug
	//  `added more checks on BDEPT entry
	// Modified by: Costas Manousakis-(Designer)-(10/18/19 17:20:34)
	Mods_2019_10_bug
	//  `list all errors found - add checks for Item7, 6A , InspResp
	Mods_2019_12  //Remove code to deal with included project bins as they are now to be handled in project screen
End if 

C_BOOLEAN:C305($Continue_b)
$Continue_b:=True:C214
C_TEXT:C284($Errors_txt)
$Errors_txt:=""

If ([Bridge MHD NBIS:1]BIN:3="")
	$Continue_b:=False:C215
	$Errors_txt:=$Errors_txt+"You must specify a BIN !"+Char:C90(13)
End if 
If ([Bridge MHD NBIS:1]Item8 Owner:208="")
	$Continue_b:=False:C215
	$Errors_txt:=$Errors_txt+"You must select an item 8 owner !"+Char:C90(13)
End if 
If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="")
	$Continue_b:=False:C215
	$Errors_txt:=$Errors_txt+"You must select an item 8 bridge category !"+Char:C90(13)
End if 
If (Position:C15("_"; [Bridge MHD NBIS:1]BDEPT:1)>0)
	$Continue_b:=False:C215
	$Errors_txt:=$Errors_txt+"You must enter a valid BDEPT !"+Char:C90(13)
End if 
If (Length:C16([Bridge MHD NBIS:1]BDEPT:1)<6)
	$Continue_b:=False:C215
	$Errors_txt:=$Errors_txt+"BDEPT has not been completed !"+Char:C90(13)
Else 
	If (Find in array:C230(<>aBDEPT; Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 1; 3))<=0)
		$Continue_b:=False:C215
		$Errors_txt:=$Errors_txt+"BDEPT Town code is not valid : "+Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 1; 3)+" !"+Char:C90(13)
	End if 
End if 

If ([Bridge MHD NBIS:1]Item7:65="")
	$Continue_b:=False:C215
	$Errors_txt:=$Errors_txt+"Item 7 cannot be blank !"+Char:C90(13)
End if 
If ([Bridge MHD NBIS:1]Item6A:63="")
	$Continue_b:=False:C215
	$Errors_txt:=$Errors_txt+"Item 6A cannot be blank !"+Char:C90(13)
End if 
If ([Bridge MHD NBIS:1]InspResp:173="")
	$Continue_b:=False:C215
	$Errors_txt:=$Errors_txt+"Inspection Responsibility cannot be blank !"+Char:C90(13)
End if 


If ($Continue_b)
	
	ACCEPT:C269
	
Else 
	ALERT:C41("Errors exist in the input! :"+Char:C90(13)+$Errors_txt)
End if 
//End Object Method: ZZ8