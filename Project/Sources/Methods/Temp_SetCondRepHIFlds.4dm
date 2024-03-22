//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/26/05, 12:13:33
	// ----------------------------------------------------
	// Method: Temp_SetCondRepHIFlds
	// Description
	// Set all HI fields in table [status reports] to -1 (NA)
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM18
End if 
ALL RECORDS:C47([Status Report:69])
C_LONGINT:C283($numrecs; $i)
$numrecs:=Records in selection:C76([Status Report:69])
ARRAY REAL:C219($ar_NA; $numrecs)
SELECTION TO ARRAY:C260([Status Report:69]ALLBR_HI:160; $ar_NA)
C_BOOLEAN:C305($datahere)
$datahere:=False:C215
For ($i; 1; $numrecs)
	$datahere:=($datahere | ($ar_NA{$i}>0))
End for 
C_TEXT:C284($msg)
If ($datahere)
	$Msg:="Warning!!!  Apparently there are some data in the status report table!!  Do you w"+"ant to initialize all health index values to -1?"
Else 
	$Msg:="Do you want to initialize all health index fields to -1?"
End if 
CONFIRM:C162($msg)
If (OK=1)
	For ($i; 1; $numrecs)
		$ar_NA{$i}:=-1
	End for 
	
	ARRAY TO SELECTION:C261($ar_NA; [Status Report:69]S_D1_HI:136; $ar_NA; [Status Report:69]S_D2_HI:137; $ar_NA; [Status Report:69]S_D3_HI:138; $ar_NA; [Status Report:69]S_D4_HI:139; $ar_NA; [Status Report:69]S_D5_HI:140; $ar_NA; [Status Report:69]S_Tot_HI:141)
	ARRAY TO SELECTION:C261($ar_NA; [Status Report:69]T_D1_HI:142; $ar_NA; [Status Report:69]T_D2_HI:143; $ar_NA; [Status Report:69]T_D3_HI:144; $ar_NA; [Status Report:69]T_D4_HI:145; $ar_NA; [Status Report:69]T_D5_HI:146; $ar_NA; [Status Report:69]T_Tot_HI:147)
	ARRAY TO SELECTION:C261($ar_NA; [Status Report:69]S_T_D1_HI:148; $ar_NA; [Status Report:69]S_T_D2_HI:149; $ar_NA; [Status Report:69]S_T_D3_HI:150; $ar_NA; [Status Report:69]S_T_D4_HI:151; $ar_NA; [Status Report:69]S_T_D5_HI:152; $ar_NA; [Status Report:69]S_T_Tot_HI:153)
	ARRAY TO SELECTION:C261($ar_NA; [Status Report:69]INT_D1_HI:161; $ar_NA; [Status Report:69]INT_D2_HI:162; $ar_NA; [Status Report:69]INT_D3_HI:163; $ar_NA; [Status Report:69]INT_D4_HI:164; $ar_NA; [Status Report:69]INT_D5_HI:165; $ar_NA; [Status Report:69]INT_Tot_HI:166)
	ARRAY TO SELECTION:C261($ar_NA; [Status Report:69]SU_D1_HI:167; $ar_NA; [Status Report:69]SU_D2_HI:168; $ar_NA; [Status Report:69]SU_D3_HI:169; $ar_NA; [Status Report:69]SU_D4_HI:170; $ar_NA; [Status Report:69]SU_D5_HI:171; $ar_NA; [Status Report:69]SU_Tot_HI:172)
	ARRAY TO SELECTION:C261($ar_NA; [Status Report:69]Loc_D1_HI:173; $ar_NA; [Status Report:69]Loc_D2_HI:174; $ar_NA; [Status Report:69]Loc_D3_HI:175; $ar_NA; [Status Report:69]Loc_D4_HI:176; $ar_NA; [Status Report:69]Loc_D5_HI:177; $ar_NA; [Status Report:69]Loc_Tot_HI:178)
	ARRAY TO SELECTION:C261($ar_NA; [Status Report:69]MBTA_HI:154; $ar_NA; [Status Report:69]MDC_HI:155; $ar_NA; [Status Report:69]MTA_HI:156; $ar_NA; [Status Report:69]MPA_HI:157; $ar_NA; [Status Report:69]DEM_HI:158; $ar_NA; [Status Report:69]OTHER_HI:159)
	ARRAY TO SELECTION:C261($ar_NA; [Status Report:69]ALLBR_HI:160)
	If (Records in set:C195("LockedSet")>0)
		ALERT:C41("Not All Status report records were initialized!!   Try again later")
	End if 
End if 