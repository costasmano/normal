//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/16/10, 12:00:16
	// ----------------------------------------------------
	// Method: Method: ut_PRJRetrieveCPAmounts
	// Description
	//  ` Retrieve the construction contract cost ammounts
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_12
	Mods_2011_01  //r001 CJ Miller`01/14/11, 11:28:21     
	//Add code to allow for retrieve of [PRJ_DesignContracts] amounts and
	//[PRJ_ConstructionProject] seperately
	Mods_2011_06  // CJ Miller`06/20/11, 10:24:51      ` Type all local variables for v11
	Mods_2019_06_bug  //Modify sql server retrieves to not use ODBC plugin but native 4D SQL
	//Modified by: Chuck Miller (6/18/19 11:13:10)
	Mods_2019_11_bug  //Moved Project retrieve code from development into bug fix 
	//and back as there were a few changes made in testing
	//Modified by: Chuck Miller (11/5/19 13:28:12)
	
End if 
C_BOOLEAN:C305($OkToProceed_b)


C_TIME:C306($SQLDocument_tm)
$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
PRJ_SQLRetrieveStats_txt:="Begin Retrieve Constr Cost Data on"+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
CLOSE DOCUMENT:C267($SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=""

ut_PRJGetCPAmounts
$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"End Retrieve Constr Cost Data on"+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
CLOSE DOCUMENT:C267($SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=""

