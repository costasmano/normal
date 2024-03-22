//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/17/10, 16:04:21
	// ----------------------------------------------------
	// Method: PERS_EditGroups
	// Description
	//  ` Edit the Personnel Groups table
	//  `Launched from a designer pulldown on the Personnel output form  
	// 
	// Parameters
	// $1 : If not passed will launch as a separate process
	// ----------------------------------------------------
	
	Mods_2010_09
	// Modified by: Costas Manousakis-(Designer)-(5/15/13 12:38:24)
	Mods_2013_05
	//  `set the needed tables to READ WRITE
	Mods_2020_06  //Added new list box output form. Only for designer now
	//Modified by: Chuck (6/25/20 16:03:37)\
		
End if 
If (Count parameters:C259=0)
	C_LONGINT:C283($LPid_L)
	$LPid_L:=LSpawnProcess("PERS_EditGroups"; <>LStackSize; "Personnel Groups"; True:C214; False:C215; "RUN")
Else 
	C_TEXT:C284($1)
	InitProcessVar
	C_TEXT:C284($outputForm_txt)
	MainTitle:="Personnel Groups"
	C_LONGINT:C283(vOutputMenuBar_L)
	vOutputMenuBar_L:=3
	C_LONGINT:C283($InpW; $inpH; $outW; $outH; $Wwid; $wht)
	C_BOOLEAN:C305($useLB_B)
	$useLB_B:=ut_UseListBox(Current method name:C684)
	If (Not:C34($useLB_B))
		$outputForm_txt:="Output"  //Default output layout 
	Else 
		$outputForm_txt:="PG_Output_LB"
	End if 
	FORM GET PROPERTIES:C674([PERS_Groups:109]; "Input"; $InpW; $inpH)
	FORM GET PROPERTIES:C674([PERS_Groups:109]; $outputForm_txt; $outW; $outH)
	$Wwid:=MaxNum($InpW; $outW)
	$wht:=MaxNum($outH; $inpH)
	READ WRITE:C146([PERS_GroupMembers:110])
	READ WRITE:C146([PERS_Groups:109])
	ModSelSort(->[PERS_Groups:109]; "Input"; $outputForm_txt; MainTitle; $Wwid; $wht; 0; Plain window:K34:13; ->[PERS_Groups:109]PERS_GroupName_s:2; ">")
	
End if 