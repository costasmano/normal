//%attributes = {"invisible":true}
//Method: Dev_ProcOrigin
//Description
// text of process origin from process properties
// Parameters
// $0: $proc origin desc
// $1 : $procorigin
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/11/20, 15:33:24
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08_bug
	C_TEXT:C284(Dev_ProcOrigin; $0)
	C_LONGINT:C283(Dev_ProcOrigin; $1)
	
End if 
//

Case of 
	: ($1=-11)
		$0:="_o_Web process with context"
	: ($1=-7)
		$0:="Apple event manager"
	: ($1=-19)
		$0:="Backup process"
	: ($1=-4)
		$0:="Cache manager"
	: ($1=-31)
		$0:="Client manager process"
	: ($1=3)
		$0:="Created from execution dialog"
	: ($1=2)
		$0:="Created from menu command"
	: ($1=-2)
		$0:="Design process"
	: ($1=-8)
		$0:="Event manager"
	: ($1=-14)
		$0:="Execute on client process"
	: ($1=1)
		$0:="Execute on server process"
	: ($1=-9)
		$0:="External task"
	: ($1=-5)
		$0:="Indexing process"
	: ($1=-18)
		$0:="Internal 4D server process"
	: ($1=-25)
		$0:="Internal timer process"
	: ($1=-20)
		$0:="Log file process"
	: ($1=-1)
		$0:="Main process"
	: ($1=-17)
		$0:="Method editor macro process"
	: ($1=-26)
		$0:="Monitor process"
	: ($1=-22)
		$0:="MSC process"
	: ($1=0)
		$0:="None"
	: ($1=-16)
		$0:="On exit process"
	: ($1=-10)
		$0:="Other 4D process"
	: ($1=4)
		$0:="Other user process"
	: ($1=-21)
		$0:="Restore Process"
	: ($1=-6)
		$0:="Serial Port Manager"
	: ($1=-15)
		$0:="Server interface process"
	: ($1=-24)
		$0:="SQL Method execution process"
	: ($1=-12)
		$0:="Web process on 4D remote"
	: ($1=-3)
		$0:="Web process with no context"
	: ($1=-13)
		$0:="Web server process"
		
End case 

//End Dev_ProcOrigin