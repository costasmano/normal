//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJRetrieveCPName
// User name (OS): cjmiller
// Date and time: 06/15/06, 10:39:29
// ----------------------------------------------------
// Description
// This method will cal SQL and retrieve contract (company) name for construction p  `rojects
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJM_v54  //r001 `11/13/07, 11:45:28`Make param code no more than 20 characters
	Mods_2009_07  //r003 `07/27/09, 10:42:59   `Fix errors when SQL calls fail
	// Modified by: ManousakisC (2/26/2010)
	Mods_2010_02  //Fix errors when SQL calls fail
	Mods_2013_09  //r001 ` Add [PRJ_ConstructionProject]CP_ConstructionContractNo_s when call fails
	//Modified by: Charles Miller (9/4/13 13:26:01)
	// Modified by: Costas Manousakis-(Designer)-(1/6/17 16:47:12)
	Mods_2017_01
	//  `removed $EOL:=char(10) before writing the stats message
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


If (SQL_Direct("sp_RTRVConstCompany"))
Else 
	C_TIME:C306($SQLDocument_tm)
	C_TEXT:C284(PRJ_SQLRetrieveStats_txt; $Eol)
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Call to sp_RTRVConstCompany Failed"+$Eol
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"when [PRJ_ConstructionProject]CP_ConstructionContractNo_s = "+[PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5+$Eol
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+SQL_ReturnErrorDescriptions+$eol
	$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
	SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
	CLOSE DOCUMENT:C267($SQLDocument_tm)
	PRJ_SQLRetrieveStats_txt:=""
	
	$0:=False:C215
End if 

//End ut_PRJRetrieveCPName