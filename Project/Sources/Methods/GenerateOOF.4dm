//%attributes = {"invisible":true}
If (False:C215)
	//GP: GenerateOOF
	//Copyright © 1995-1997,  Albert S. Leung, All Rights Reserved.
	
	//C_INTEGER($t)
	//C_INTEGER($leeway)
	
	// Modified by: manousakisc-(Designer)-(9/7/2023 10:20:42)
	Mods_2023_09
	//  `removed use of nonmodal windows and on event call to stop - replaced with progress bars.
	//  `changed searches to send one request to server - use goto record instead of next record
	
End if 
C_DATE:C307($d)
C_LONGINT:C283($Month)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($Year)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($curinsp)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($i; $j)  //Command Replaced was o_C_INTEGER
ARRAY TEXT:C222($agency; 4)  //Command Replaced was o_ARRAY string length was 80

$agency{1}:="MBTA"
$agency{2}:="MDC"
$agency{3}:="MTA"
$agency{4}:="MPA"

//Get current date from server
$d:=Current date:C33(*)
//Always get the previous month
$Year:=Year of:C25($d)
$Month:=Month of:C24($d)-1
If ($Month=0)
	$Month:=12
	$Year:=$Year-1
End if 

ARRAY INTEGER:C220($reqd; 6)
ARRAY INTEGER:C220($done; 6)
ARRAY INTEGER:C220($ytd1; 6)
ARRAY INTEGER:C220($ytd2; 6)
ARRAY INTEGER:C220($ytd3; 6)
//State bridge inspection out of frequency
//MessageNM ("District and Dive OOF - Press "+Choose(Is Windows;"CTRL";"CMD")+"-. to stop")
For ($i; 1; 6)
	$reqd{$i}:=0
	$done{$i}:=0
	$ytd1{$i}:=0
	$ytd2{$i}:=0
	$ytd3{$i}:=0
End for 

//QUERY([Bridge MHD NBIS];[Bridge MHD NBIS]FHWARecord=True)
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]InspResp:173="DIST1"; *)
QUERY:C277([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]InspResp:173="DIST2"; *)
QUERY:C277([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]InspResp:173="DIST3"; *)
QUERY:C277([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]InspResp:173="DIST4"; *)
QUERY:C277([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]InspResp:173="DIST5"; *)
QUERY:C277([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]InspResp:173="MDC"; *)
QUERY:C277([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)
//FIRST RECORD([Bridge MHD NBIS])
//start the bar
C_OBJECT:C1216($progress_o)
$progress_o:=ProgressNew("Dist 1-5 and MDC OOF"; Records in selection:C76([Bridge MHD NBIS:1])\
; True:C214; " Bridges"; 3)

For ($i; 1; Records in selection:C76([Bridge MHD NBIS:1]))
	//update progress
	UpdateProgressNew($progress_o; $i)
	
	$curinsp:=[Bridge MHD NBIS:1]InspResp:173
	If ($curinsp#"MDC")
		$j:=Num:C11($curinsp[[5]])
		If (fCombineInsp($Year; $Month; 0; 0; False:C215)=True:C214)
			$reqd{$j}:=$reqd{$j}+1
		End if 
		If (bDoneInMonthYr($Month; $Year)=True:C214)
			$done{$j}:=$done{$j}+1
		End if 
		If (fOutofFreq(7; 1)=True:C214)
			$ytd1{$j}:=$ytd1{$j}+1
		End if 
		If (fOutofFreq(7; 2)=True:C214)
			$ytd2{$j}:=$ytd2{$j}+1
		End if 
		If (fOutofFreq(7; 3)=True:C214)
			$ytd3{$j}:=$ytd3{$j}+1
		End if 
	End if 
	If (fUpforInsp($Year; $Month; 0; 0; 6; False:C215)=True:C214)
		$reqd{6}:=$reqd{6}+1
	End if 
	If (bInMonth([Bridge MHD NBIS:1]Item93B:170; $Month; $Year)=True:C214)
		$done{6}:=$done{6}+1
	End if 
	If (fOutofFreq(6; 1)=True:C214)
		$ytd1{6}:=$ytd1{6}+1
	End if 
	If (fOutofFreq(6; 2)=True:C214)
		$ytd2{6}:=$ytd2{6}+1
	End if 
	If (fOutofFreq(6; 3)=True:C214)
		$ytd3{6}:=$ytd3{6}+1
	End if 
	//NEXT RECORD([Bridge MHD NBIS])
	GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; $i)
	//check if progress stopped
	If (Progress Stopped(OB Get:C1224($progress_o; "progress"; Is longint:K8:6)))
		//abort loop
		Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
		ABORT:C156
	End if 
	
End for 

//quit progress
Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))

[Out of Freq:70]D1_reqd:5:=$reqd{1}
[Out of Freq:70]D2_reqd:6:=$reqd{2}
[Out of Freq:70]D3_reqd:7:=$reqd{3}
[Out of Freq:70]D4_reqd:8:=$reqd{4}
[Out of Freq:70]D5_reqd:9:=$reqd{5}
[Out of Freq:70]D1_made:17:=$done{1}
[Out of Freq:70]D2_made:18:=$done{2}
[Out of Freq:70]D3_made:19:=$done{3}
[Out of Freq:70]D4_made:20:=$done{4}
[Out of Freq:70]D5_made:21:=$done{5}
D1_month:=$reqd{1}-$done{1}
If (D1_month<0)
	D1_month:=0
End if 
D2_month:=$reqd{2}-$done{2}
If (D2_month<0)
	D2_month:=0
End if 
D3_month:=$reqd{3}-$done{3}
If (D3_month<0)
	D3_month:=0
End if 
D4_month:=$reqd{4}-$done{4}
If (D4_month<0)
	D4_month:=0
End if 
D5_month:=$reqd{5}-$done{5}
If (D5_month<0)
	D5_month:=0
End if 
[Out of Freq:70]D1_1ytd:29:=$ytd1{1}
[Out of Freq:70]D2_1ytd:30:=$ytd1{2}
[Out of Freq:70]D3_1ytd:31:=$ytd1{3}
[Out of Freq:70]D4_1ytd:32:=$ytd1{4}
[Out of Freq:70]D5_1ytd:33:=$ytd1{5}
[Out of Freq:70]D1_2ytd:41:=$ytd2{1}
[Out of Freq:70]D2_2ytd:42:=$ytd2{2}
[Out of Freq:70]D3_2ytd:43:=$ytd2{3}
[Out of Freq:70]D4_2ytd:44:=$ytd2{4}
[Out of Freq:70]D5_2ytd:45:=$ytd2{5}
[Out of Freq:70]D1_3ytd:53:=$ytd3{1}
[Out of Freq:70]D2_3ytd:54:=$ytd3{2}
[Out of Freq:70]D3_3ytd:55:=$ytd3{3}
[Out of Freq:70]D4_3ytd:56:=$ytd3{4}
[Out of Freq:70]D5_3ytd:57:=$ytd3{5}
[Out of Freq:70]Dive_reqd:16:=$reqd{6}
[Out of Freq:70]Dive_made:28:=$done{6}
Dive_month:=$reqd{6}-$done{6}
[Out of Freq:70]Dive_1ytd:40:=$ytd1{6}
[Out of Freq:70]Dive_2ytd:52:=$ytd2{6}
[Out of Freq:70]Dive_3ytd:64:=$ytd3{6}
S_reqd:=0
S_made:=0
S_1ytd:=0
S_2ytd:=0
S_3ytd:=0
For ($i; 1; 6)
	S_reqd:=S_reqd+$reqd{$i}
	S_made:=S_made+$done{$i}
	S_1ytd:=S_1ytd+$ytd1{$i}
	S_2ytd:=S_2ytd+$ytd2{$i}
	S_3ytd:=S_3ytd+$ytd3{$i}
End for 
S_month:=S_reqd-S_made
If (S_month<0)
	S_month:=0
End if 
//Agencies out of frequency
//start the bar
C_OBJECT:C1216($agencyprogress_o)
$agencyprogress_o:=ProgressNew("Other Agencies "; 4; False:C215; " Agencies"; 3)

For ($i; 1; 4)
	
	//update progress
	UpdateProgressNew($agencyprogress_o; $i)
	
	
	$curinsp:=$agency{$i}
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]InspResp:173=$curinsp; *)
	QUERY:C277([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)
	$reqd{$i}:=0
	$done{$i}:=0
	$ytd1{$i}:=0
	$ytd2{$i}:=0
	$ytd3{$i}:=0
	//FIRST RECORD([Bridge MHD NBIS])
	//start the bar
	C_OBJECT:C1216($agencyBridgeProgr_o)
	$agencyBridgeProgr_o:=ProgressNew($curinsp; Records in selection:C76([Bridge MHD NBIS:1]); True:C214; " bridges"; 3)
	
	For ($j; 1; Records in selection:C76([Bridge MHD NBIS:1]))
		//update progress
		UpdateProgressNew($agencyBridgeProgr_o; $j)
		
		If (fCombineInsp($Year; $Month; 0; 0; False:C215)=True:C214)
			$reqd{$i}:=$reqd{$i}+1
		End if 
		If (bDoneInMonthYr($Month; $Year)=True:C214)
			$done{$i}:=$done{$i}+1
		End if 
		If (fOutofFreq(7; 1)=True:C214)
			$ytd1{$i}:=$ytd1{$i}+1
		End if 
		If (fOutofFreq(7; 2)=True:C214)
			$ytd2{$i}:=$ytd2{$i}+1
		End if 
		If (fOutofFreq(7; 3)=True:C214)
			$ytd3{$i}:=$ytd3{$i}+1
		End if 
		//NEXT RECORD([Bridge MHD NBIS])
		GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; $j)
		
		//check if progress stopped
		If (Progress Stopped(OB Get:C1224($agencyBridgeProgr_o; "progress"; Is longint:K8:6)))
			//abort loop - quit both progress bars
			Progress QUIT(OB Get:C1224($agencyBridgeProgr_o; "progress"; Is longint:K8:6))
			Progress QUIT(OB Get:C1224($agencyprogress_o; "progress"; Is longint:K8:6))
			ABORT:C156
		End if 
		
	End for 
	
	//quit progress
	Progress QUIT(OB Get:C1224($agencyBridgeProgr_o; "progress"; Is longint:K8:6))
	
End for 

//quit progress
Progress QUIT(OB Get:C1224($agencyprogress_o; "progress"; Is longint:K8:6))

[Out of Freq:70]MBTA_reqd:10:=$reqd{1}
[Out of Freq:70]MDC_reqd:11:=$reqd{2}
[Out of Freq:70]MTA_reqd:12:=$reqd{3}
[Out of Freq:70]MPA_reqd:13:=$reqd{4}
[Out of Freq:70]MBTA_made:22:=$done{1}
[Out of Freq:70]MDC_made:23:=$done{2}
[Out of Freq:70]MTA_made:24:=$done{3}
[Out of Freq:70]MPA_made:25:=$done{4}
MBTA_month:=$reqd{1}-$done{1}
If (MBTA_month<0)
	MBTA_month:=0
End if 
MDC_month:=$reqd{2}-$done{2}
If (MDC_month<0)
	MDC_month:=0
End if 
MTA_month:=$reqd{3}-$done{3}
If (MTA_month<0)
	MTA_month:=0
End if 
MPA_month:=$reqd{4}-$done{4}
If (MPA_month<0)
	MPA_month:=0
End if 
[Out of Freq:70]MBTA_1ytd:34:=$ytd1{1}
[Out of Freq:70]MDC_1ytd:35:=$ytd1{2}
[Out of Freq:70]MTA_1ytd:36:=$ytd1{3}
[Out of Freq:70]MPA_1ytd:37:=$ytd1{4}
[Out of Freq:70]MBTA_2ytd:46:=$ytd2{1}
[Out of Freq:70]MDC_2ytd:47:=$ytd2{2}
[Out of Freq:70]MTA_2ytd:48:=$ytd2{3}
[Out of Freq:70]MPA_2ytd:49:=$ytd2{4}
[Out of Freq:70]MBTA_3ytd:58:=$ytd3{1}
[Out of Freq:70]MDC_3ytd:59:=$ytd3{2}
[Out of Freq:70]MTA_3ytd:60:=$ytd3{3}
[Out of Freq:70]MPA_3ytd:61:=$ytd3{4}
A_reqd:=0
A_made:=0
A_1ytd:=0
A_2ytd:=0
A_3ytd:=0
For ($i; 1; 5)
	A_reqd:=A_reqd+$reqd{$i}
	A_made:=A_made+$done{$i}
	A_1ytd:=A_1ytd+$ytd1{$i}
	A_2ytd:=A_2ytd+$ytd2{$i}
	A_3ytd:=A_3ytd+$ytd3{$i}
End for 
A_month:=A_reqd-A_made
If (A_month<0)
	A_month:=0
End if 

total_reqd:=S_reqd+A_reqd
total_made:=S_made+A_made
total_1ytd:=S_1ytd+A_1ytd
total_2ytd:=S_2ytd+A_2ytd
total_3ytd:=S_3ytd+A_3ytd
total_month:=S_month+A_month

[Out of Freq:70]Date_Created:1:=Current date:C33(*)
[Out of Freq:70]Time_Created:2:=Current time:C178(*)
[Out of Freq:70]Owner:3:=Current user:C182
