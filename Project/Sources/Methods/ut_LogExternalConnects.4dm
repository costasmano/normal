//%attributes = {"invisible":true}

//Method: ut_LogExternalConnects
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 12/08/11, 13:45:42
	//----------------------------------------------------
	//
	//Modified by: Charles Miller (12/8/11 13:45:43)
	// Modified by: Costas Manousakis-(Designer)-(3/16/12 11:16:07)
	Mods_2012_03
	//  `Include the password in the error message if a system parameter SQLAUTHSAVEPW is set to "SAVE"
	
End if 


C_TEXT:C284($1; $2; $3; $4; $User_txt; $IP_txt; $PW_txt; $Reason_txt; $ReasonTime_txt)
$User_txt:=$1
$IP_txt:=$2
$PW_txt:=$3
$Reason_txt:=$4
C_TIME:C306($CurrentTm_tm)
$CurrentTm_tm:=Current time:C178
$ReasonTime_txt:=String:C10(Current date:C33; System date short:K1:1)+" "+String:C10($CurrentTm_tm)+Char:C90(Carriage return:K15:38)+$Reason_txt
C_TEXT:C284($SavePW_txt)
$SavePW_txt:=ut_GetSysParameter("SQLAUTHSAVEPW")

If ($SavePW_txt="SAVE")
	$ReasonTime_txt:=$ReasonTime_txt+" - PW :"+$PW_txt
End if 
$ReasonTime_txt:=$ReasonTime_txt+Char:C90(Carriage return:K15:38)

READ WRITE:C146([ONSQLAuthenticationErrors:146])
QUERY:C277([ONSQLAuthenticationErrors:146]; [ONSQLAuthenticationErrors:146]UserName_s:1=$User_txt)
If (Records in selection:C76([ONSQLAuthenticationErrors:146])=0)
	CREATE RECORD:C68([ONSQLAuthenticationErrors:146])
	[ONSQLAuthenticationErrors:146]UserName_s:1:=$User_txt
	[ONSQLAuthenticationErrors:146]LastLogin_d:4:=Current date:C33
	[ONSQLAuthenticationErrors:146]LastLogin_tm:5:=Current time:C178
	[ONSQLAuthenticationErrors:146]Reason_txt:3:=$ReasonTime_txt
	[ONSQLAuthenticationErrors:146]IPAddress_txt:2:=$IP_txt
	SAVE RECORD:C53([ONSQLAuthenticationErrors:146])
	UNLOAD RECORD:C212([ONSQLAuthenticationErrors:146])
Else 
	If (ut_LoadRecordonServer(->[ONSQLAuthenticationErrors:146]))
		
		If ([ONSQLAuthenticationErrors:146]LastLogin_d:4=Current date:C33) & ([ONSQLAuthenticationErrors:146]NumberofAttempts_l:6>=10)
			[ONSQLAuthenticationErrors:146]Reason_txt:3:=[ONSQLAuthenticationErrors:146]Reason_txt:3+Char:C90(Carriage return:K15:38)+$ReasonTime_txt
			[ONSQLAuthenticationErrors:146]NumberofAttempts_l:6:=[ONSQLAuthenticationErrors:146]NumberofAttempts_l:6+1
			[ONSQLAuthenticationErrors:146]IPAddress_txt:2:=$IP_txt
			
			C_TEXT:C284($To_txt; $From_txt)
			$To_txt:="costas.manousakis@MHD.state.ma.us,cjmiller@informed-solutions.com"
			$From_txt:="costas.manousakis@MHD.state.ma.us"
			C_TEXT:C284($Message_txt)
			$Message_txt:="User name "+[ONSQLAuthenticationErrors:146]UserName_s:1+" has tried to log in "+String:C10([ONSQLAuthenticationErrors:146]NumberofAttempts_l:6)+" times in the last "
			$Message_txt:=$Message_txt+String:C10($CurrentTm_tm-[ONSQLAuthenticationErrors:146]LastLogin_tm:5)+". The errors will be listed below:"+Char:C90(Carriage return:K15:38)
			$Message_txt:=$Message_txt+[ONSQLAuthenticationErrors:146]Reason_txt:3
			ut_SendEmail($To_txt; $From_txt; ""; ""; $Message_txt; " Log In Failures"; True:C214)
			
			[ONSQLAuthenticationErrors:146]LastLogin_tm:5:=$CurrentTm_tm
			
		Else 
			[ONSQLAuthenticationErrors:146]IPAddress_txt:2:=$IP_txt
			
			If ([ONSQLAuthenticationErrors:146]LastLogin_d:4=Current date:C33)
				[ONSQLAuthenticationErrors:146]NumberofAttempts_l:6:=[ONSQLAuthenticationErrors:146]NumberofAttempts_l:6+1
			Else 
				[ONSQLAuthenticationErrors:146]LastLogin_d:4:=Current date:C33
				[ONSQLAuthenticationErrors:146]NumberofAttempts_l:6:=1
			End if 
			[ONSQLAuthenticationErrors:146]LastLogin_tm:5:=$CurrentTm_tm
			[ONSQLAuthenticationErrors:146]Reason_txt:3:=[ONSQLAuthenticationErrors:146]Reason_txt:3+Char:C90(Carriage return:K15:38)+$ReasonTime_txt
			
		End if 
		
		SAVE RECORD:C53([ONSQLAuthenticationErrors:146])
		UNLOAD RECORD:C212([ONSQLAuthenticationErrors:146])
	End if 
End if 
READ ONLY:C145([ONSQLAuthenticationErrors:146])
//End ut_LogExternalConnects

