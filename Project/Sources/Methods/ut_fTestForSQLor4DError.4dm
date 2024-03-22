//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 11/04/11, 10:23:34
//----------------------------------------------------
//Method: ut_fTestForSQLor4DError
//Description
//This method will return false if either a 4d or a sql error occurred else it wil lreturn true
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Fix delete bug and alert how $0 is returned
	//Modified by: Charles Miller (11/4/11 10:23:36)
End if 
C_BOOLEAN:C305($0)

Case of 
	: (SQLError_b)
		$0:=False:C215
	: (4DError_b)
		$0:=False:C215
	Else 
		$0:=True:C214
End case 
//End ut_fTestForSQLor4DError

