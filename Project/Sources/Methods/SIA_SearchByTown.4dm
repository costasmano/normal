//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/13/07, 15:25:24
	// ----------------------------------------------------
	// Method: SIA_SearchByTown
	// Description
	// look for bridges in or bordering a Town by name
	// 
	// Parameters
	// $1 : TownName
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_TEXT:C284($1; $BridgePrefix)
C_BOOLEAN:C305($2; $GetTwnLines_b)
C_LONGINT:C283($0)
If (Count parameters:C259>1)
	$GetTwnLines_b:=$2
Else 
	$GetTwnLines_b:=True:C214
End if 

READ ONLY:C145([Town Data:2])
READ ONLY:C145([TownLineInfo:73])
C_BOOLEAN:C305($NBI_RW_State_b)
$NBI_RW_State_b:=Read only state:C362([Bridge MHD NBIS:1])
READ ONLY:C145([Bridge MHD NBIS:1])
QUERY:C277([Town Data:2]; [Town Data:2]Town Name:1=$1)
If (Records in selection:C76([Town Data:2])=1)
	$BridgePrefix:=[Town Data:2]BDEPT Prefix:2
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=($BridgePrefix+"@"))
	If ($GetTwnLines_b)
		CREATE SET:C116([Bridge MHD NBIS:1]; "TOWNBRIDGES")
		QUERY:C277([TownLineInfo:73]; [TownLineInfo:73]BDEPT:2=($BridgePrefix+"@"))
		If (Records in selection:C76([TownLineInfo:73])>0)
			SELECTION TO ARRAY:C260([TownLineInfo:73]BIN:1; $TLineBINS_as)
			QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BIN:3; $TLineBINS_as)
			CREATE SET:C116([Bridge MHD NBIS:1]; "NEIGHBORBRIDGES")
			UNION:C120("TOWNBRIDGES"; "NEIGHBORBRIDGES"; "TOWNBRIDGES")
			CLEAR SET:C117("NEIGHBORBRIDGES")
		End if 
		USE SET:C118("TOWNBRIDGES")
		CLEAR SET:C117("TOWNBRIDGES")
		
	End if 
	$0:=Records in selection:C76([Bridge MHD NBIS:1])
Else 
	$0:=-1  //bad/unknown town name
End if 
READ WRITE:C146([Town Data:2])
READ WRITE:C146([TownLineInfo:73])
If ($NBI_RW_State_b)
Else 
	READ WRITE:C146([Bridge MHD NBIS:1])
End if 