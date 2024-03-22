//%attributes = {"invisible":true}
// ----------------------------------------------------
//ut_PRJSetRetrieveDate 
// User name (OS): cjmiller
// Date and time: 03/02/06, 10:53:38
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (SQL_Change_d=!00-00-00!)
	CTR_LastUpdateYYYYMMDD_txt:="01-01-1950"
Else 
	CTR_LastUpdateYYYYMMDD_txt:=String:C10(Month of:C24(SQL_Change_d))+"-"+String:C10(Day of:C23(SQL_Change_d))+"-"+String:C10(Year of:C25(SQL_Change_d))
End if 



//End ut_PRJSetRetrieveDate 
