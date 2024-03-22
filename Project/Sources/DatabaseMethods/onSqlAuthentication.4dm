If (False:C215)
	//On SQL Authentication 
	// Modified by: Costas Manousakis-(Designer)-(3/16/12 11:16:07)
	Mods_2012_03
	//Include the password in the error message if a system parameter SQLAUTHSAVEPW is set to "SAVE"
End if 

ON ERR CALL:C155("SQLAuthenticationError")
C_BOOLEAN:C305(SQL_ConnectionOK_b)

C_TEXT:C284($1; $2; $3; ONSQLAuthenUser_txt; ONSQLAuthUserPW_txt; ONSQLAuthenIP_txt)
C_BOOLEAN:C305($0)
ONSQLAuthenUser_txt:=$1
ONSQLAuthUserPW_txt:=$2
ONSQLAuthenIP_txt:=$3
SQL_ConnectionOK_b:=True:C214
C_LONGINT:C283($Count_l)
SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_l)
QUERY:C277([ONSQLAuthenticationErrors:146]; [ONSQLAuthenticationErrors:146]UserName_s:1=ONSQLAuthenUser_txt; *)
QUERY:C277([ONSQLAuthenticationErrors:146];  & ; [ONSQLAuthenticationErrors:146]NumberofAttempts_l:6>10)


SET QUERY DESTINATION:C396(Into current selection:K19:1)
Case of 
	: ($Count_l>0)
		SQL_ConnectionOK_b:=False:C215
	: (User in group:C338(ONSQLAuthenUser_txt; " "))
		CHANGE CURRENT USER:C289("SQL_ReadOnly"; "12345")
	: (User in group:C338(ONSQLAuthenUser_txt; "ReadOnly"))
		CHANGE CURRENT USER:C289(ONSQLAuthenUser_txt; ONSQLAuthUserPW_txt)
	: (User in group:C338(ONSQLAuthenUser_txt; "ReadWrite"))
		CHANGE CURRENT USER:C289(ONSQLAuthenUser_txt; ONSQLAuthUserPW_txt)
	Else 
		If (Not:C34(User in group:C338(ONSQLAuthenUser_txt; "ActiveUsers")))
			C_LONGINT:C283($Processid_l)
			$Processid_l:=New process:C317("ut_LogExternalConnects"; 0; "ONSQLAuthenticate"; ONSQLAuthenUser_txt; ONSQLAuthenIP_txt; ONSQLAuthUserPW_txt; "InactiveUser")
		Else 
			
		End if 
		SQL_ConnectionOK_b:=False:C215
End case 
$0:=SQL_ConnectionOK_b
ON ERR CALL:C155("")
