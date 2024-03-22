//%attributes = {"invisible":true}
//Method: DEV_logEventPath
//Description
// stuff in object DEV_LogEvents_o info with the current method name, the formevent and other info
// can be viewed with DEV_showEventPath
// Parameters
// $1 : $Methodname_txt
// $2 : $Formevent_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/17/17, 14:18:20
	// ----------------------------------------------------
	//Created : 
	Mods_2017_08
	C_TEXT:C284(DEV_logEventPath; $1)
	C_LONGINT:C283(DEV_logEventPath; $2)
End if 

C_OBJECT:C1216(DEV_LogEvents_o)

ARRAY TEXT:C222($methPaths_atxt; 0)
ARRAY TEXT:C222($CurrObj_atxt; 0)
ARRAY TEXT:C222($FocusObj_atxt; 0)
ARRAY LONGINT:C221($Events_aL; 0)
ARRAY TEXT:C222($EventName_atxt; 0)
ARRAY LONGINT:C221($MilliSecs_aL; 0)

If (OB Is defined:C1231(DEV_LogEvents_o; "EventPaths"))
	OB GET ARRAY:C1229(DEV_LogEvents_o; "EventPaths"; $methPaths_atxt)
End if 
If (OB Is defined:C1231(DEV_LogEvents_o; "Events"))
	OB GET ARRAY:C1229(DEV_LogEvents_o; "Events"; $Events_aL)
End if 
If (OB Is defined:C1231(DEV_LogEvents_o; "EventNames"))
	OB GET ARRAY:C1229(DEV_LogEvents_o; "Events"; $EventName_atxt)
End if 
If (OB Is defined:C1231(DEV_LogEvents_o; "MilliSec"))
	OB GET ARRAY:C1229(DEV_LogEvents_o; "MilliSec"; $MilliSecs_aL)
End if 
If (OB Is defined:C1231(DEV_LogEvents_o; "CurrentObj"))
	OB GET ARRAY:C1229(DEV_LogEvents_o; "CurrentObj"; $CurrObj_atxt)
End if 
If (OB Is defined:C1231(DEV_LogEvents_o; "FocusObj"))
	OB GET ARRAY:C1229(DEV_LogEvents_o; "FocusObj"; $FocusObj_atxt)
End if 
C_TEXT:C284($newEvent_txt)
$newEvent_txt:=$1+Char:C90(Tab:K15:37)+"/"+String:C10($2)+Char:C90(Tab:K15:37)+"/"+fGetFormEvent($2)+Char:C90(Tab:K15:37)+"/"+OBJECT Get name:C1087(Object current:K67:2)+Char:C90(Tab:K15:37)+"/"+OBJECT Get name:C1087(Object with focus:K67:3)+Char:C90(Tab:K15:37)+"/"+String:C10(Milliseconds:C459)

APPEND TO ARRAY:C911($methPaths_atxt; $newEvent_txt)
APPEND TO ARRAY:C911($Events_aL; $2)
APPEND TO ARRAY:C911($EventName_atxt; fGetFormEvent($2))
APPEND TO ARRAY:C911($MilliSecs_aL; Milliseconds:C459)
APPEND TO ARRAY:C911($CurrObj_atxt; OBJECT Get name:C1087(Object current:K67:2))
APPEND TO ARRAY:C911($FocusObj_atxt; OBJECT Get name:C1087(Object with focus:K67:3))

OB SET ARRAY:C1227(DEV_LogEvents_o; "EventPaths"; $methPaths_atxt)
OB SET ARRAY:C1227(DEV_LogEvents_o; "Events"; $Events_aL)
OB SET ARRAY:C1227(DEV_LogEvents_o; "EventNames"; $EventName_atxt)
OB SET ARRAY:C1227(DEV_LogEvents_o; "MilliSec"; $MilliSecs_aL)
OB SET ARRAY:C1227(DEV_LogEvents_o; "CurrentObj"; $CurrObj_atxt)
OB SET ARRAY:C1227(DEV_LogEvents_o; "FocusObj"; $FocusObj_atxt)

//End DEV_logEventPath