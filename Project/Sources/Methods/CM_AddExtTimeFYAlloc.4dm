//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/09/06, 20:47:05
	// ----------------------------------------------------
	// Method: CM_AddExtTimeFYAlloc
	// Description
	// Add Extension Time Fiscal Year fund allocations for
	// current ExtensionTime record
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CMz1
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
End if 
C_LONGINT:C283($CurrFY_I; $EndingFY_I; $FY)
C_BOOLEAN:C305(<>CM_LogChanges_b)
$CurrFY_I:=F_FiscalYear(Current date:C33(*))
If ([ExtendTime_Maintenance:98]ExtendedDate:7#!00-00-00!)
	$EndingFY_I:=F_FiscalYear([ExtendTime_Maintenance:98]ExtendedDate:7)
	If ($EndingFY_I>$CurrFY_I)
		QUERY:C277([CM_ExtTimeFYAlloc:111]; [CM_ExtTimeFYAlloc:111]EOT_ID_L:2=[ExtendTime_Maintenance:98]EOT_ID:2)
		//delete ones that we do not need
		For ($FY; Records in selection:C76([CM_ExtTimeFYAlloc:111]); 1; -1)
			GOTO SELECTED RECORD:C245([CM_ExtTimeFYAlloc:111]; $FY)
			LOAD RECORD:C52([CM_ExtTimeFYAlloc:111])
			If (([CM_ExtTimeFYAlloc:111]FYear_I:4>=$CurrFY_I) & ([CM_ExtTimeFYAlloc:111]FYear_I:4<=$EndingFY_I))
			Else 
				If (<>CM_LogChanges_b)
					LogDeletion(->[ExtendTime_Maintenance:98]EOT_ID:2; ->[CM_ExtTimeFYAlloc:111]EOT_ID_L:2; ->[CM_ExtTimeFYAlloc:111]ExtTimeFYAllocID_L:1; 2)
				End if 
				DELETE RECORD:C58([CM_ExtTimeFYAlloc:111])
				vCM_ExtTimFYFundChg_b:=True:C214
			End if 
		End for 
		QUERY:C277([CM_ExtTimeFYAlloc:111]; [CM_ExtTimeFYAlloc:111]EOT_ID_L:2=[ExtendTime_Maintenance:98]EOT_ID:2)
		ARRAY INTEGER:C220($arr_ExistFYs_I; 0)
		SELECTION TO ARRAY:C260([CM_ExtTimeFYAlloc:111]FYear_I:4; $arr_ExistFYs_I)
		For ($FY; $CurrFY_I; $EndingFY_I)
			If (Find in array:C230($arr_ExistFYs_I; $FY)>0)
			Else 
				vCM_ExtTimFYFundChg_b:=True:C214
				CREATE RECORD:C68([CM_ExtTimeFYAlloc:111])
				[CM_ExtTimeFYAlloc:111]EOT_ID_L:2:=[ExtendTime_Maintenance:98]EOT_ID:2
				Inc_Sequence("ExtTimeMntFYAlloc"; ->[CM_ExtTimeFYAlloc:111]ExtTimeFYAllocID_L:1)
				[CM_ExtTimeFYAlloc:111]FYear_I:4:=$FY
				SAVE RECORD:C53([CM_ExtTimeFYAlloc:111])
				If (<>CM_LogChanges_b)
					LogNewRecord(->[ExtendTime_Maintenance:98]EOT_ID:2; ->[CM_ExtTimeFYAlloc:111]EOT_ID_L:2; ->[CM_ExtTimeFYAlloc:111]ExtTimeFYAllocID_L:1; 2; "ExtTimeMntFYAlloc")
					LogChanges(->[CM_ExtTimeFYAlloc:111]FYear_I:4; ->[ExtendTime_Maintenance:98]EOT_ID:2; ->[CM_ExtTimeFYAlloc:111]EOT_ID_L:2; ->[CM_ExtTimeFYAlloc:111]ExtTimeFYAllocID_L:1; 2)
				End if 
				
			End if 
		End for 
	Else 
		ALERT:C41("Ending Fiscal year same or earlier than Current fiscal year! ("+String:C10($EndingFY_I)+")")
	End if 
Else 
	ALERT:C41("No extended date specified!")
End if 
