//%attributes = {"invisible":true}
//ut_StartMessage
//Start the message output
//Initializes process variables vbOnScreenMessage and
//vfMessageDocRef.
//ut_startmessage(MsgOption:Integer;Win | FileName:String80 _
//  [; Width:LInt[;Ht:Lint[;Wtype:LInt[;Location:Lint]]]])
// MsgOption : 0 - no messages
//                 : 1 - on screen messages
//                 : 2 - to file messages
//                 : 3 - on screen and to file messages
// Location : 0-32 - as defined in method NewWindow
If (False:C215)
	
	Mods_2004_CM09
	Mods_2005_CM13
	// Modified by: costasmanousakis-(Designer)-(1/11/2007 09:04:31)
	Mods_2007_CM03
	// Modified by: costasmanousakis-(Designer)-(8/22/2007 11:43:52)
	Mods_2007_CM12_5301
	Mods_2011_05  //r002 CJ Miller`05/20/11, 12:08:33      `Change directory where exports are stored to the users documents folder
	// Modified by: Costas Manousakis-(Designer)-(12/17/18 11:14:44)
	Mods_2018_12_bug
	//  `increased $maxcycle to 48 from 16
End if 

C_LONGINT:C283($1; $viMsgOption)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305(vbOnScreenMessage; vbToFileMessage)
C_TEXT:C284($2; $WinTitle)  //<--- Added// Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($3; $Width; $4; $Height)
C_LONGINT:C283($5; $WinType)
C_LONGINT:C283($6; $Location)
C_TIME:C306(vfMessageDocRef)
C_TEXT:C284(MessageDefDir_txt)

$viMsgOption:=$1
vbOnScreenMessage:=False:C215
vbToFileMessage:=False:C215

Case of 
	: ($viMsgOption=1)
		vbOnScreenMessage:=True:C214
	: ($viMsgOption=2)
		vbToFileMessage:=True:C214
	: ($viMsgOption=3)
		vbOnScreenMessage:=True:C214
		vbToFileMessage:=True:C214
End case 

Startup_PL
Characters

$WinTitle:=$2
If (Count parameters:C259>2)
	$Width:=$3
Else 
	$Width:=300
End if 
If (Count parameters:C259>3)
	$Height:=$4
Else 
	$Height:=300
End if 
If (Count parameters:C259>4)
	$WinType:=$5
Else 
	$WinType:=Regular window:K27:1
End if 
If (Count parameters:C259>5)
	$Location:=$6
Else 
	$Location:=0  //Centered
End if 
If ($Width<=0)
	$Width:=300
End if 
If ($Height<=0)
	$Height:=300
End if 

vfMessageDocRef:=?00:00:00?  //initialize it.

If (vbOnScreenMessage)
	NewWindow($Width; $Height; $Location; $WinType; $WinTitle)
	//CENTER_WINDOW ($Width;$Height;$WinType;$WinTitle)
End if 
If (vbToFileMessage)
	If (MessageDefDir_txt="")
		
		ut_SetMessageDir("DefaultMessages")
		
	End if 
	C_TEXT:C284($vsMsgFile)
	$vsMsgFile:=MessageDefDir_txt+$WinTitle+".txt"
	If (Test path name:C476($vsMsgFile)#1)
		vfMessageDocRef:=Create document:C266($vsMsgFile; "TEXT")
	Else 
		C_LONGINT:C283($i; $MaxCycle)  //Command Replaced was o_C_INTEGER
		$MaxCycle:=48
		For ($i; 1; $MaxCycle)
			$vsMsgFile:=MessageDefDir_txt+$WinTitle+"_"+String:C10($i)+".txt"
			If (Test path name:C476($vsMsgFile)#1)
				vfMessageDocRef:=Create document:C266($vsMsgFile; "TEXT")
				$vsMsgFile:=MessageDefDir_txt+$WinTitle+"_"+String:C10($i+1)+".txt"
				If (Test path name:C476($vsMsgFile)=1)
					DELETE DOCUMENT:C159($vsMsgFile)
				End if 
				$i:=$MaxCycle+1
			End if 
			If ($i=$MaxCycle)
				$vsMsgFile:=MessageDefDir_txt+$WinTitle+".txt"
				vfMessageDocRef:=Create document:C266($vsMsgFile; "TEXT")
				$vsMsgFile:=MessageDefDir_txt+$WinTitle+"_1"+".txt"
				If (Test path name:C476($vsMsgFile)=1)
					DELETE DOCUMENT:C159($vsMsgFile)
				End if 
			End if 
		End for 
	End if 
End if 