//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJMoveConsultants
// User name (OS): cjmiller
// Date and time: 11/21/06, 15:53:16
// ----------------------------------------------------
// Description
// This method wil create new consultant name records
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2  //11/21/06, 15:27:12` new calls to get consultant company name and contact info
End if 
READ ONLY:C145(*)
READ WRITE:C146([Conslt Address:77])
READ WRITE:C146([Conslt_Name:127])
ALL RECORDS:C47([Conslt_Name:127])
DELETE SELECTION:C66([Conslt_Name:127])

ALL RECORDS:C47([Conslt Address:77])
ARRAY TEXT:C222($Names_atxt; 0)
C_LONGINT:C283($Loop_l; $SizeOfArray_l)
C_LONGINT:C283($Key_l)

DISTINCT VALUES:C339([Conslt Address:77]ConsltName:2; $Names_atxt)
$SizeOfArray_l:=Size of array:C274($Names_atxt)
For ($Loop_l; 1; $SizeOfArray_l)
	CREATE RECORD:C68([Conslt_Name:127])
	Inc_Sequence("ConsultantNameID_l"; ->[Conslt_Name:127]ConsultantNameID_l:1)
	[Conslt_Name:127]ConsultantName_s:2:=$Names_atxt{$Loop_l}
	$Key_l:=[Conslt_Name:127]ConsultantNameID_l:1
	SAVE RECORD:C53([Conslt_Name:127])
	UNLOAD RECORD:C212([Conslt_Name:127])
	QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsltName:2=$Names_atxt{$Loop_l})
	APPLY TO SELECTION:C70([Conslt Address:77]; [Conslt Address:77]ConsultantNameID_l:22:=$Key_l)
	
End for 

//End ut_PRJMoveConsultants