//%attributes = {"invisible":true,"shared":true}
// IcJ_Launcher method for Informed Cron4D™
//copyright 2013 Informed Solutions, Inc. All rights reserved.
//This method is what actually launches your scheduled methods. It is what allows Informed cron4D™ to execute methods without setting them as shared
//Changing any of the data in the method other than variable names is ill advised


ON ERR CALL:C155("IcJ_Errors")
IcJ_Error_b:=False:C215
C_LONGINT:C283($0; $ProcessNumber_L; $2; $StackSize_L; $UniqueProcessNumber_l; $ProcessTime_l)
C_TEXT:C284($1; $3; $MethodName_s; $ProcessName_s; $MyProcessName_s)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284($4; $WheretoRun_s)  // Command Replaced was o_C_STRING length was 1
$MethodName_s:=$1
$StackSize_L:=$2
$ProcessName_s:=$3
$WheretoRun_s:=$4
Case of 
	: ($WheretoRun_s="S")  //Run on server remember that process must last enoght time for next command to get unique process #
		$ProcessNumber_L:=Execute on server:C373($MethodName_s; $StackSize_L; $ProcessName_s)
		PROCESS PROPERTIES:C336($ProcessNumber_l; $MyProcessName_s; $ProcessState_l; $ProcessTime_l; $ProcessVisible_b; $UniqueProcessNumber_l; $ProcessOrigin_l)
		If ($UniqueProcessNumber_l#$ProcessNumber_L) & ($UniqueProcessNumber_l>0)
			$ProcessNumber_L:=$UniqueProcessNumber_l
		End if 
		
	: ($WheretoRun_s="C")  //run on client remember that process must last enoght time for next command to get unique process #
		
		$ProcessNumber_L:=New process:C317($MethodName_s; $StackSize_L; $ProcessName_s)
		C_LONGINT:C283($ProcessState_l; $ProcessTime_l; $ProcessOrigin_l; $ProcessOrigin_l; $Another_L)
		C_BOOLEAN:C305($ProcessVisible_b)
		
		PROCESS PROPERTIES:C336($ProcessNumber_l; $MyProcessName_s; $ProcessState_l; $ProcessTime_l; $ProcessVisible_b; $UniqueProcessNumber_l; $ProcessOrigin_l)
		If ($UniqueProcessNumber_l#$ProcessNumber_L) & ($UniqueProcessNumber_l>0)
			$ProcessNumber_L:=$UniqueProcessNumber_l
		End if 
		
		
		
End case 
If (IcJ_Error_b)
	If (Find in array:C230(IcJ_ErrorNumbers_al; 21)>0)
		$ProcessNumber_L:=-99999
		
	Else 
		$ProcessNumber_L:=-88888
		
	End if 
Else 
	
End if 
$0:=$ProcessNumber_L

ON ERR CALL:C155("")