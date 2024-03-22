//%attributes = {"invisible":true}
//Method: fGetProcessOrigin
//Description
// return the name of the Proc origin Constant 
// Parameters
// $0 : $Name of proc origin constant
// $1 : $ProcOrigin_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/30/18, 12:19:08
	// ----------------------------------------------------
	//Created : 
	Mods_2018_01
	
	C_TEXT:C284(fGetProcessOrigin; $0)
	C_LONGINT:C283(fGetProcessOrigin; $1)
End if 
//

C_TEXT:C284($0)
C_LONGINT:C283($1)

C_LONGINT:C283($ProcOrigin_L)

Case of 
		//: ($ProcOrigin_L=_o_Web process with context)  //-11
		//$0:="_o_Web process with context"
	: ($ProcOrigin_L=Apple event manager:K36:4)  //-7
		$0:="Apple event manager"
	: ($ProcOrigin_L=Backup process:K36:24)  //-19
		$0:="Backup process"
	: ($ProcOrigin_L=Cache manager:K36:7)  //-4
		$0:="Cache manager"
	: ($ProcOrigin_L=Client manager process:K36:31)  //-31
		$0:="Client manager process"
	: ($ProcOrigin_L=Created from execution dialog:K36:14)  //3
		$0:="Created from execution dialog"
	: ($ProcOrigin_L=Created from menu command:K36:13)  //2
		$0:="Created from menu command"
	: ($ProcOrigin_L=Design process:K36:9)  //-2
		$0:="Design process"
	: ($ProcOrigin_L=Event manager:K36:3)  //-8
		$0:="Event manager"
	: ($ProcOrigin_L=Execute on client process:K36:19)  //-14
		$0:="Execute on client process"
	: ($ProcOrigin_L=Execute on server process:K36:12)  //1
		$0:="Execute on server process"
	: ($ProcOrigin_L=External task:K36:2)  //-9
		$0:="External task"
	: ($ProcOrigin_L=Indexing process:K36:6)  //-5
		$0:="Indexing process"
	: ($ProcOrigin_L=Internal 4D server process:K36:23)  //-18
		$0:="Internal 4D server process"
	: ($ProcOrigin_L=Internal timer process:K36:29)  //-25
		$0:="Internal timer process"
	: ($ProcOrigin_L=Log file process:K36:25)  //-20
		$0:="Log file process"
	: ($ProcOrigin_L=Main process:K36:10)  //-1
		$0:="Main process"
	: ($ProcOrigin_L=Method editor macro process:K36:22)  //-17
		$0:="Method editor macro process"
	: ($ProcOrigin_L=Monitor process:K36:30)  //-26
		$0:="Monitor process"
	: ($ProcOrigin_L=MSC Process:K36:27)  //-22
		$0:="MSC process"
	: ($ProcOrigin_L=None:K36:11)  //0
		$0:="None"
	: ($ProcOrigin_L=On exit process:K36:21)  //-16
		$0:="On exit process"
	: ($ProcOrigin_L=Other 4D process:K36:1)  //-10
		$0:="Other 4D process"
	: ($ProcOrigin_L=Other user process:K36:15)  //4
		$0:="Other user process"
	: ($ProcOrigin_L=Restore process:K36:26)  //-21
		$0:="Restore Process"
	: ($ProcOrigin_L=Serial port manager:K36:5)  //-6
		$0:="Serial Port Manager"
	: ($ProcOrigin_L=Server interface process:K36:20)  //-15
		$0:="Server interface process"
	: ($ProcOrigin_L=SQL Method execution process:K36:28)  //-24
		$0:="SQL Method execution process"
	: ($ProcOrigin_L=Web process on 4D remote:K36:17)  //-12
		$0:="Web process on 4D remote"
	: ($ProcOrigin_L=Web process with no context:K36:8)  //-3
		$0:="Web process with no context"
	: ($ProcOrigin_L=Web server process:K36:18)  //-13
		$0:="Web server process"
	Else 
		$0:="?"
End case 

//End fGetProcessOrigin