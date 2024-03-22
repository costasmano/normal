//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/08/11, 11:59:49
//----------------------------------------------------
//Method: SQLAuthenticationError
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//
	//Modified by: Charles Miller (12/8/11 11:59:50)
	// Modified by: Costas Manousakis-(Designer)-(3/16/12 11:16:07)
	Mods_2012_03
	//  `Include the password in the error message if a system parameter SQLAUTHSAVEPW is set to "SAVE"
	
End if 
ARRAY LONGINT:C221(SQLErrorNumbers_al; 0)
ARRAY TEXT:C222(SQL_InternalCodes_atxt; 0)
ARRAY TEXT:C222(SQL_InternalDescriptions_atxt; 0)
GET LAST ERROR STACK:C1015(SQLErrorNumbers_al; SQL_InternalCodes_atxt; SQL_InternalDescriptions_atxt)
C_LONGINT:C283($Processid_l)
$Processid_l:=New process:C317("ut_LogExternalConnects"; 0; "ONSQLAuthenticate"; ONSQLAuthenUser_txt; ONSQLAuthenIP_txt; ONSQLAuthUserPW_txt; String:C10(SQLErrorNumbers_al{1})+" "+SQL_InternalDescriptions_atxt{1})

SQL_ConnectionOK_b:=False:C215

//End SQLAuthenticationError