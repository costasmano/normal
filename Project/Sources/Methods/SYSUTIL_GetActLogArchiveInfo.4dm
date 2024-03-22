//%attributes = {"invisible":true}
//Method: SYSUTIL_GetActLogArchiveInfo
//Description
// get information for the act log archive export tag 
// Parameters
// $0 : $infoObject
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/26/20, 12:17:59
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08_bug
	
	C_OBJECT:C1216(SYSUTIL_GetActLogArchiveInfo; $0)
End if 
//
C_OBJECT:C1216($info_o; $server_o)
OB SET:C1220($info_o; "ExecutionMode"; Application type:C494; \
"ExecutionModeDesc"; DEV_ApplicationType(Application type:C494))

If (Application type:C494=4D Remote mode:K5:5)
	//get info from server
	$server_o:=SYSUTIL_GetServerInfo
	//add all attributes
	ARRAY TEXT:C222($props_atxt; 0)
	ARRAY LONGINT:C221($proptype_aL; 0)
	OB GET PROPERTY NAMES:C1232($server_o; $props_atxt; $proptype_aL)
	If (Size of array:C274($props_atxt)>0)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($props_atxt))
			OB SET:C1220($info_o; $props_atxt{$loop_L}; OB Get:C1224($server_o; $props_atxt{$loop_L}; $proptype_aL{$loop_L}))
		End for 
	End if 
Else 
	OB SET:C1220($info_o; "LocalStructurefile"; Structure file:C489)
	OB SET:C1220($info_o; "LocalDatafile"; Data file:C490)
End if 
OB SET:C1220($info_o; "LocalMachineName"; Current machine:C483)
OB SET:C1220($info_o; "LocalCurrentUser"; Current system user:C484)

$0:=$info_o

//End SYSUTIL_GetActLogArchiveInfo