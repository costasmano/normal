//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 04/26/12, 13:16:07
//----------------------------------------------------
//Method: ut_PRJRetrieveVendorID
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_04  //r001 `Add Vendor ID
	//Modified by: Charles Miller (4/26/12 13:16:08)
	Mods_2019_06_bug  //Modify sql server retrieves to not use ODBC plugin but native 4D SQL
	//Modified by: Chuck Miller (6/18/19 11:13:10)
	Mods_2019_11_bug  //Moved Project retrieve code from development into bug fix 
	//and back as there were a few changes made in testing
	//Modified by: Chuck Miller (11/5/19 13:28:12)
	
End if 


C_BOOLEAN:C305($0)



If (<>PL_LPlatfrm<3)
	$EOL:=Char:C90(Carriage return:K15:38)
Else 
	$EOL:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
End if 
$0:=True:C214
If (SQL_Direct("sp_RetrieveVendorID"))
Else 
	C_TIME:C306($SQLDocument_tm)
	C_TEXT:C284(PRJ_SQLRetrieveStats_txt; $Eol)
	$Eol:=Char:C90(10)
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Call to sp_RetrieveVendorID Failed"+$Eol
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+SQL_ReturnErrorDescriptions+$eol
	$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
	SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
	CLOSE DOCUMENT:C267($SQLDocument_tm)
	PRJ_SQLRetrieveStats_txt:=""
	
	$0:=False:C215
End if 
//End ut_PRJRetrieveVendorID

