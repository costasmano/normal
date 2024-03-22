//SC vEntryData on layout [zDialogs];"EasySearch".
//Copyright © 1998, Thomas D. Nee, All Rights Reserved.
//
//Modified 15-Mar-2001 : CM Changed call to String function for "Date" data to
//                         format option 7 : MM DD YYYYForced

C_DATE:C307($Date)
C_TIME:C306($Time)
C_BOOLEAN:C305($Error)

//TRACE

Case of 
	: (asShowTyps{vBuildCount}="Boolean")
		If (vEntryData="1") | (vEntryData="T") | (vEntryData="Y")
			asShowData{vBuildCount}:="True"
		Else 
			asShowData{vBuildCount}:="False"
		End if 
	: (asShowTyps{vBuildCount}="Date")
		$Date:=Date:C102(vEntryData)
		If ($Date=!00-00-00!) | ($Date<!1700-01-01!) | ($Date>!2200-01-01!)
			$Error:=True:C214
		End if 
		vEntryData:=String:C10($Date; Internal date short:K1:7)
		asShowData{vBuildCount}:=vEntryData
	: (asShowTyps{vBuildCount}="Time")
		$Time:=Time:C179(vEntryData)
		If ($Time<?00:00:00?) | ($Time>?23:59:59?)
			$Error:=True:C214
		End if 
		vEntryData:=String:C10($Time)
		asShowData{vBuildCount}:=vEntryData
	Else 
		//String, integer or real data, it should be okay.
		asShowData{vBuildCount}:=vEntryData
End case 

If ($Error)
	BEEP:C151
	GOTO OBJECT:C206(vEntryData)
Else 
	EZCloseEntryDat
End if 