//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// Method: Temp_TestUserGroups
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2011_06  // CJ Miller`06/13/11, 16:59:30      ` Type all local variables for v11
End if 

//method to check consistancy of group assignements

ARRAY TEXT:C222($aUserNames; 0)  //Command Replaced was o_ARRAY string length was 120
ARRAY LONGINT:C221($aUserIDs; 0)
C_LONGINT:C283($Numusers; $i)
GET USER LIST:C609($aUserNames; $aUserIDs)
ARRAY TEXT:C222(aActiveUsers; 0)  //Command Replaced was o_ARRAY string length was 120
ARRAY TEXT:C222(aActiveUsersDES; 0)  //Command Replaced was o_ARRAY string length was 120
ARRAY TEXT:C222(aInactiveUsers; 0)  //Command Replaced was o_ARRAY string length was 120
ARRAY TEXT:C222(aReadWrite; 0)  //Command Replaced was o_ARRAY string length was 120
ARRAY TEXT:C222(aReadWriteDES; 0)  //Command Replaced was o_ARRAY string length was 120
ARRAY TEXT:C222(aReadOnly; 0)  //Command Replaced was o_ARRAY string length was 120
ARRAY TEXT:C222(aReadOnlyDES; 0)  //Command Replaced was o_ARRAY string length was 120
ARRAY TEXT:C222($aGroupNames; 0)  //Command Replaced was o_ARRAY string length was 120
ARRAY LONGINT:C221($aGroupIDs; 0)
GET GROUP LIST:C610($aGroupNames; $aGroupIDs)
$i:=Find in array:C230($aGroupNames; "ActiveUsers")
Temp_addGroupMembers($aGroupIDs{$i}; ->aActiveUsers)
$i:=Find in array:C230($aGroupNames; "InactiveUsers")
Temp_addGroupMembers($aGroupIDs{$i}; ->aInactiveUsers)
$i:=Find in array:C230($aGroupNames; "ReadWrite")
Temp_addGroupMembers($aGroupIDs{$i}; ->aReadWrite)
$i:=Find in array:C230($aGroupNames; "ReadOnly")
Temp_addGroupMembers($aGroupIDs{$i}; ->aReadOnly)
$i:=Find in array:C230($aGroupNames; "ActiveUsers -DES")
Temp_addGroupMembers($aGroupIDs{$i}; ->aActiveUsersDES)
$i:=Find in array:C230($aGroupNames; "ReadWrite -DES")
Temp_addGroupMembers($aGroupIDs{$i}; ->aReadWriteDES)
$i:=Find in array:C230($aGroupNames; "ReadOnly -DES")
Temp_addGroupMembers($aGroupIDs{$i}; ->aReadOnlyDES)

$Numusers:=Size of array:C274($aUserNames)
C_BOOLEAN:C305($vbActive; $vbInactive; $vbRW; $vbRN; $vbChk1; $vbChk2; $vbChk3)
For ($i; 1; $Numusers)
	$vbActive:=(Find in array:C230(aActiveUsers; $aUserNames{$i})>0)
	$vbInactive:=(Find in array:C230(aInactiveUsers; $aUserNames{$i})>0)
	If ($vbActive & $vbInactive)
		ALERT:C41("User "+$aUserNames{$i}+" Is both Active and Inactive")
	End if 
	$vbRW:=(Find in array:C230(aReadWrite; $aUserNames{$i})>0)
	$vbRN:=(Find in array:C230(aReadOnly; $aUserNames{$i})>0)
	If ($vbRW & $vbRN)
		ALERT:C41("User "+$aUserNames{$i}+" Is both ReadWrite and ReadOnly")
	End if 
	If ($vbActive & (Not:C34($vbRW) & Not:C34($vbRN)))
		ALERT:C41("User "+$aUserNames{$i}+" Is Active but neither ReadWrite and ReadOnly")
	End if 
	$vbChk3:=(Find in array:C230(aActiveUsersDES; $aUserNames{$i})>0)
	$vbChk1:=(Find in array:C230(aReadWriteDES; $aUserNames{$i})>0)
	$vbChk2:=(Find in array:C230(aReadOnlyDES; $aUserNames{$i})>0)
	If ($vbActive & Not:C34($vbChk3))
		ALERT:C41("User "+$aUserNames{$i}+" Is Active but not Acitve-DES")
	End if 
	If ($vbRW & Not:C34($vbChk1))
		ALERT:C41("User "+$aUserNames{$i}+" Is ReadWrite but not ReadWrite-DES")
	End if 
	If ($vbRN & Not:C34($vbChk2))
		ALERT:C41("User "+$aUserNames{$i}+" Is ReadOnly but not Readonly-DES")
	End if 
	
End for 
ARRAY TEXT:C222($aGroupNames; 0)  //Command Replaced was o_ARRAY string length was 120
ARRAY LONGINT:C221($aGroupIDs; 0)
GET GROUP LIST:C610($aGroupNames; $aGroupIDs)
C_LONGINT:C283($Numgroups; $k; $vsOwner)
$NumGroups:=Size of array:C274($aGroupNames)
C_TEXT:C284($vsGrpName)
For ($i; 1; $NumGroups)
	
	GET GROUP PROPERTIES:C613($aGroupIDs{$i}; $vsGrpName; $vsOwner; $agrpMem)
	$NumUsers:=Size of array:C274($agrpMem)
	ARRAY TEXT:C222(aUserNames; 0)  //Command Replaced was o_ARRAY string length was 120
	Temp_addGroupMembers($agroupids{$i}; ->aUserNames)
End for 
ARRAY TEXT:C222(aActiveUsers; 0)  //Command Replaced was o_ARRAY string length was 120
ARRAY TEXT:C222(aActiveUsersDES; 0)  //Command Replaced was o_ARRAY string length was 120
ARRAY TEXT:C222(aInactiveUsers; 0)  //Command Replaced was o_ARRAY string length was 120
ARRAY TEXT:C222(aReadWrite; 0)  //Command Replaced was o_ARRAY string length was 120
ARRAY TEXT:C222(aReadWriteDES; 0)  //Command Replaced was o_ARRAY string length was 120
ARRAY TEXT:C222(aReadOnly; 0)  //Command Replaced was o_ARRAY string length was 120
ARRAY TEXT:C222(aReadOnlyDES; 0)  //Command Replaced was o_ARRAY string length was 120
ARRAY TEXT:C222($aGroupNames; 0)  //Command Replaced was o_ARRAY string length was 120