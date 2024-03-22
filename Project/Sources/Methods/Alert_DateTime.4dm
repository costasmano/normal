//%attributes = {"invisible":true}
//Method: Alert_DateTime
//Description
// Alert user if date and time of copmuter is more than a couple of hours off from internet time.
// currently only works on OSX computers
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/04/18, 14:42:15
	// ----------------------------------------------------
	//Created : 
	Mods_2018_10
	
	// Modified by: Costas Manousakis-(Designer)-(6/10/20 13:36:47)
	Mods_2020_06
	//  `force JSON Parse to return an object
End if 
//

If (<>PL_LPLATFRM=Windows:K25:3)
Else 
	C_TEXT:C284($input; $empty; $error; $output; $time; $ComputerDateTime_t; $datetime_txt; $NetDateTime_t)
	
	$input:="date -u +%Y-%m-%dT%H:%M:%S"
	LAUNCH EXTERNAL PROCESS:C811($input; $empty; $output; $error)
	$ComputerDateTime_t:=Substring:C12($output; 1; 19)
	
	$input:="curl http://worldclockapi.com/api/json/utc/now"  // this gets utc from worldclockapi
	$empty:=""
	LAUNCH EXTERNAL PROCESS:C811($input; $empty; $output; $error)
	If ($output#"") & ($ComputerDateTime_t#"")
		C_OBJECT:C1216($data_o)
		$data_o:=JSON Parse:C1218($output; Is object:K8:27)
		
		$datetime_txt:=OB Get:C1224($data_o; "currentDateTime"; Is text:K8:3)  // format is yyyy-mm-ddThh:mm+XX:00 +XX:00 Need to account for this!!!!
		//$datetime_txt:=Replace string($datetime_txt;"T";"Z")  // replace T with Z
		$NetDateTime_t:=Substring:C12($datetime_txt; 1; 16)+":00"  // strip unneeded stuff and add seconds
		C_TIME:C306($diff_t; $maxtimeDiff_t)
		$diff_t:=GEN_TimestampDifference($ComputerDateTime_t; $NetDateTime_t)
		C_TEXT:C284($maxtimeDiff_txt)
		$maxtimeDiff_txt:=ut_GetSysParameter("MAXSYSCLOCKTIMEDIFF"; "12:00:00")
		$maxtimeDiff_t:=Time:C179($maxtimeDiff_txt)
		If ($diff_t>$maxtimeDiff_t)
			C_LONGINT:C283($daysDiff_L)
			$daysDiff_L:=$diff_t\(24*60*60)
			C_TIME:C306($HrsDiff_t)
			$HrsDiff_t:=$diff_t-($daysDiff_L*24*60*60)
			
			If ($daysDiff_L>0)
				ALERT:C41("Computer time is off from Net Time in worldclockapi by : "+String:C10($daysDiff_L)+" days, "+String:C10($HrsDiff_t)+" hrs")
				
			Else 
				ALERT:C41("Computer time is off from Net Time in worldclockapi by : "+String:C10($HrsDiff_t)+" hrs")
				
			End if 
			
		End if 
		
	End if 
	
End if 
//End Alert_DateTime