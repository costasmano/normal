//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_prtSubrepError
// User name (OS): charlesmiller
// Date and time: 03/15/11, 12:07:35
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_03  //r002 CJ Miller`03/15/11, 12:07:37      `Error handler to identify why report does not get created
	// Modified by: Costas Manousakis-(Designer)-(2022-03-28 17:04:09)
	Mods_2022_03
	//  `added error stack info to the ReportError var
End if 

SRVReportErrror_b:=True:C214
ARRAY LONGINT:C221(SQLErrorNumbers_al; 0)
ARRAY TEXT:C222(SQL_InternalCodes_atxt; 0)
ARRAY TEXT:C222(SQL_InternalDescriptions_atxt; 0)
GET LAST ERROR STACK:C1015(SQLErrorNumbers_al; SQL_InternalCodes_atxt; SQL_InternalDescriptions_atxt)

If (ReportError_txt="")
	ReportError_txt:=ReportError_txt+"from ut_prtSubRepError : "+String:C10(Error)+Char:C90(Carriage return:K15:38)+\
		ut_ArraysToText("\t"; ->SQLErrorNumbers_al; ->SQL_InternalCodes_atxt; ->SQL_InternalDescriptions_atxt)+Char:C90(Carriage return:K15:38)
Else 
	ReportError_txt:=ReportError_txt+Char:C90(Carriage return:K15:38)+"from ut_prtSubRepError : "+String:C10(Error)+Char:C90(Carriage return:K15:38)+\
		ut_ArraysToText("\t"; ->SQLErrorNumbers_al; ->SQL_InternalCodes_atxt; ->SQL_InternalDescriptions_atxt)+Char:C90(Carriage return:K15:38)
End if 
//End ut_prtSubrepError