//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/20/11, 15:18:14
//----------------------------------------------------
//Method: SQL_TestConnection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Ugrade to v11
	//Modified by: Charles Miller (1/20/11 15:18:16)
End if 
C_BOOLEAN:C305($Complete_b; SQLConnectionMade_b; SQLError_b)
$Complete_b:=False:C215
C_TEXT:C284($IPAddress_txt; $0)
$IPAddress_txt:="146.243.135.242:19812"

Repeat 
	$IPAddress_txt:=Request:C163("Enter IP Address that server is running on"; $IPAddress_txt)
	ut_SQLConnect("Designer"; "caesar"; $IPAddress_txt)
	If (SQLConnectionMade_b)
		$Complete_b:=True:C214
		ut_SQLLogout
		DELAY PROCESS:C323(Current process:C322; 120)  //make sure sql log out made
	Else 
		Case of 
			: (SQLErrorNumbers_al{1}=1006)
				ALERT:C41("Connection to 4D SQL server not made to IP "+$IPAddress_txt+" as 4D Server not running ")
			: (SQLErrorNumbers_al{1}=1003)
				ALERT:C41("Connection to 4D SQL server not made to IP "+$IPAddress_txt+" as 4D Server running but SQL Server not started")
			: (SQLErrorNumbers_al{1}=1004)
				ALERT:C41("Connection to 4D SQL server not made to IP "+$IPAddress_txt+" as maximum users have already connected")
				
			Else 
				ALERT:C41("Connection to 4D SQL server not made to IP "+$IPAddress_txt+" unknown error ")
		End case 
		CONFIRM:C162("Try again")
		If (OK=1)
			SQLError_b:=False:C215
		Else 
			$Complete_b:=True:C214
			$IPAddress_txt:=""
		End if 
	End if 
Until ($Complete_b)
$0:=$IPAddress_txt
//End SQL_TestConnection

