//%attributes = {"invisible":true}
//procedure: M_PutBackNBI
//created: 10/2/97
//by: Albert Leung
//purpose: put bridges back on the NBI database

C_LONGINT:C283($i; $recs)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($text)  // Command Replaced was o_C_STRING length was 80

FIRST RECORD:C50([Bridge MHD NBIS:1])
$recs:=Records in selection:C76([Bridge MHD NBIS:1])
If ($recs<=0)
	ALERT:C41("There are no bridges in the selection.")
Else 
	$text:="Do you really want to add "
	If ($recs=1)
		$text:=$text+"this bridge to the NBI list?"
	Else 
		$text:=$text+"these "+String:C10($recs)+" bridges to the NBI list?"
	End if 
	CONFIRM:C162($text)
	
	If (OK=1)
		For ($i; 1; $recs)
			If (Not:C34([Bridge MHD NBIS:1]FHWARecord:174))
				[Bridge MHD NBIS:1]FHWARecord:174:=True:C214
				LogChanges(->[Bridge MHD NBIS:1]FHWARecord:174; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
				SAVE RECORD:C53([Bridge MHD NBIS:1])
			End if 
			NEXT RECORD:C51([Bridge MHD NBIS:1])
		End for 
	End if 
End if 