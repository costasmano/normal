//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJRetrieveAEData
// User name (OS): cjmiller
// Date and time: 03/02/06, 12:19:58
// ----------------------------------------------------
// Description
//This method control retrieve of construction cotnract data from the AE data base
// Parameters
If (False:C215)
	Mods_2009_07  //r001 `07/23/09, 10:19:55   `Add call to AE to retrieve additional [PRJ_ConstructionProject] data
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(3/12/12 11:00:55)
	Mods_2012_03
	//  `Added missing call to ut_ResetSQLLastUpdateDate
	Mods_2019_06_bug  //Modify sql server retrieves to not use ODBC plugin but native 4D SQL
	//Modified by: Chuck Miller (6/18/19 11:13:10)
	Mods_2019_11_bug  //Moved Project retrieve code from development into bug fix 
	//and back as there were a few changes made in testing
	//Modified by: Chuck Miller (11/5/19 13:28:12)
	
End if 


C_BOOLEAN:C305($OkToProceed_b)
C_TIME:C306($SQLDocument_tm)


$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
PRJ_SQLRetrieveStats_txt:="Begin Retrieve AE Data on"+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
CLOSE DOCUMENT:C267($SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=""

ut_PRJGetAEData
$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"End Retrieve AE Data on "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
CLOSE DOCUMENT:C267($SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=""



//End ut_PRJRetrieveAEData