If (False:C215)
	//SC[TownLineInfo]BDEPT on layout [TownLineInfo];"TownLineInfoIN"
	//Copyright © 1998, Albert S. Leung, All Rights Reserved.
	// Modified by: costasmanousakis-(Designer)-(5/10/11 14:09:07)
	Mods_2011_05
	//  `Use Set Query Destination to get counts
	
End if 


C_TEXT:C284($bin)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($bdept)  // Command Replaced was o_C_STRING length was 6
C_LONGINT:C283($recs; $RecsT)
C_TEXT:C284($text)  // Command Replaced was o_C_STRING length was 255

$bin:=[TownLineInfo:73]BIN:1
$bdept:=[TownLineInfo:73]BDEPT:2
SET QUERY DESTINATION:C396(Into variable:K19:4; $recs)
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=$bdept; *)
QUERY:C277([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]BIN:3#$bin)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
SET QUERY DESTINATION:C396(Into variable:K19:4; $RecsT)
QUERY:C277([TownLineInfo:73]; [TownLineInfo:73]BDEPT:2=$bdept; *)
QUERY:C277([TownLineInfo:73];  & ; [TownLineInfo:73]BIN:1#$bin)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
$recs:=$recs+$RecsT
If ($recs>=1)
	$text:="Warning:"+<>sCR+<>sCR+"There already "
	Case of 
		: ($recs=1)
			$text:=$text+"is one record "
		: ($recs>1)
			$text:=$text+"are "+String:C10($recs)+" records "
	End case 
	$text:=$text+"with BDEPT='"+Substring:C12($bdept; 1; 1)+"-"+Substring:C12($bdept; 2; 2)
	$text:=$text+"-"+Substring:C12($bdept; 4; 3)+"'."+<>sCR+<>sCR+"Please verify."
	ALERT:C41($text)
	GOTO OBJECT:C206([TownLineInfo:73]BDEPT:2)
End if 