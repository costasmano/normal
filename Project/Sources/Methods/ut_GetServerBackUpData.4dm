//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/14/12, 13:21:14
//----------------------------------------------------
//Method: ut_GetServerBackUpData
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_02  //r003   `Add function call to get backup info
	//Modified by: Charles Miller (2/14/12 13:21:15)
End if 
C_TEXT:C284($1; $2; $3)
C_TEXT:C284($UserName_txt; $Password_txt; $IPAddress_txt)
$UserName_txt:=$1
$Password_txt:=$2
$IPAddress_txt:=$3
SQLError_b:=False:C215
4DError_b:=False:C215
C_BOOLEAN:C305($Priority_b)
$Priority_b:=False:C215
ut_SQLConnect($UserName_txt; $Password_txt; $IPAddress_txt)
If (SQLConnectionMade_b)
	
	
	C_TEXT:C284(SQLQuery_txt; BackUpdata_txt)
	SQLQuery_txt:="SELECT {fn ut_ReturnBackupInfo() AS TEXT} FROM Preferences INTO :BackUpdata_txt;"
	ON ERR CALL:C155("SQL_ERROR")  //
	Begin SQL
		EXECUTE IMMEDIATE :SQLQuery_txt;
	End SQL
	If (Not:C34(SQLError_b))
		
		If (Substring:C12(BackUpdata_txt; 1; 8)="Priority")
			$Priority_b:=True:C214
			BackUpdata_txt:=Replace string:C233(BackUpdata_txt; "Priority "; "")
		End if 
	Else 
		BackUpdata_txt:="Call to ut_ReturnBackupInfo on IP "+$IPAddress_txt+" address failed "
	End if 
	ut_SQLLogout
Else 
	If (SQLError_b | 4DError_b)
		$Priority_b:=True:C214
		Case of 
			: (Find in array:C230(SQLErrorNumbers_al; 1003)>0)
				BackUpdata_txt:=("Connection to 4D SQL server not made to IP "+$IPAddress_txt+" as 4D Server running but SQL Server not started")
			: (Find in array:C230(SQLErrorNumbers_al; 1004)>0)
				BackUpdata_txt:=("Connection to 4D SQL server not made to IP "+$IPAddress_txt+" as maximum users have already connected")
			: (Find in array:C230(SQLErrorNumbers_al; 1006)>0)
				BackUpdata_txt:=("Connection to 4D SQL server not made to IP "+$IPAddress_txt+" as 4D Server not running ")
			: (Find in array:C230(SQLErrorNumbers_al; 1105)>0)
				BackUpdata_txt:=("Connection to 4D SQL server not made to IP "+$IPAddress_txt+" Bad user name or password")
				
			Else 
				BackUpdata_txt:=("Connection to 4D SQL server not made to IP "+$IPAddress_txt+" unknown error ")
		End case 
		
	End if 
End if 
C_TEXT:C284($From_txt; $To_txt)
$From_txt:=ut_GetSysParameter("MAIL_BRGSTATFROM"; "Costas.Manousakis@MHD.state.ma.us")

$To_txt:=ut_GetSysParameter("MAIL_TRANSFCHKLIST"; "costas.manousakis@MHD.state.ma.us,cjmiller@informed-solutions.com")

If ($Priority_b)
	$To_txt:=$To_txt+","+ut_GetSysParameter("MAIL_TRANSFEMRGLIST"; "costas.manousakis@MHD.state.ma.us,cjmiller@informed-solutions.com")
End if 

ut_SendEmail($To_txt; $From_txt; ""; ""; BackUpdata_txt; "Backup Info for IP "+$IPAddress_txt; $Priority_b)

//End ut_GetServerBackUpData