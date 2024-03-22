//%attributes = {"invisible":true}
If (False:C215)
	//GP Check_DupInsp.
	//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
	
	//Check for duplicate Inspection.
	//Look for duplicate BIN/Date/Span Group combination.
	Mods_2004_CM09
	// Modified by: Chuck Miller-(Designer)-(8/24/17 14:54:52)
	Mods_2017_08_bug  //replace _ o _during
	
	
End if 

C_BOOLEAN:C305($0)  //Returns true if duplicate was found.
C_TEXT:C284($BIN)  // Command Replaced was o_C_STRING length was 3
C_LONGINT:C283($SpanGroup)  //Command Replaced was o_C_INTEGER
C_DATE:C307($Date)
C_LONGINT:C283($ID)
C_BOOLEAN:C305($FoundDup)
C_LONGINT:C283(vlDuplInspsFnd)
C_TEXT:C284($Text)  // Command Replaced was o_C_STRING length was 255

//TRACE

$BIN:=[BMS Inspections:44]BIN:2
$SpanGroup:=[BMS Inspections:44]Span Group No:3
$Date:=[BMS Inspections:44]Insp Date:4
$ID:=[BMS Inspections:44]Inspection ID:1
SET QUERY DESTINATION:C396(Into variable:K19:4; vlDuplInspsFnd)
//PUSH RECORD([BMS Inspections])
//CUT NAMED SELECTION([BMS Inspections];"Check_DupInsp")

QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]BIN:2=$BIN; *)
QUERY:C277([BMS Inspections:44];  & ; [BMS Inspections:44]Span Group No:3=$SpanGroup; *)
QUERY:C277([BMS Inspections:44];  & ; [BMS Inspections:44]Insp Date:4=$Date; *)
QUERY:C277([BMS Inspections:44];  & ; [BMS Inspections:44]Inspection ID:1#$ID)

SET QUERY DESTINATION:C396(Into current selection:K19:1)
$FoundDup:=(vlDuplInspsFnd>0)

//USE NAMED SELECTION("Check_DupInsp")
//POP RECORD([BMS Inspections])

//If it is a duplicate and data is being entered on the layout, present an alert.
//If this is an import, do not display the alert.
If (($FoundDup) & ((Form event code:C388=On Clicked:K2:4) | (After:C31)))
	$Text:="This structure (BIN='"+[BMS Inspections:44]BIN:2
	$Text:=$Text+"', Span Group="+String:C10([BMS Inspections:44]Span Group No:3)
	$Text:=$Text+") already has an inspection on this date."
	$Text:=$Text+<>sCR+<>sCR+"Please enter a different date."
	ALERT:C41($Text)
	
	REJECT:C38
	//The date field can't be specified unless it is on the layout.
	//REJECT([BMS Inspections]Insp Date)
End if 

$0:=$FoundDup