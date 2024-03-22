//%attributes = {"invisible":true}
//G_TickDelay
//Delay for x ticks

C_LONGINT:C283($1)
C_LONGINT:C283($starttick; $endtick; $dummy)
$starttick:=Tickcount:C458
$endtick:=$starttick+$1
$dummy:=0
If (Current process:C322=1)  //1 is the user/menu process - cannot use DELAY PROCESS
	While (Tickcount:C458<$endtick)
		$dummy:=$dummy+1  //do something
	End while 
	If (Current user:C182="Designer")
		C_TEXT:C284($vsPname)  // Command Replaced was o_C_STRING length was 80
		C_LONGINT:C283($vlPstate; $vlPtime)
		PROCESS PROPERTIES:C336(Current process:C322; $vsPname; $vlPstate; $vlPtime)
		ALERT:C41("From "+$vsPname+" Delay of ..."+String:C10($dummy))
	End if 
Else 
	DELAY PROCESS:C323(Current process:C322; $1)
End if 