//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/23/07, 10:04:12
	// ----------------------------------------------------
	// Method: ut_CleanOwnersofDataDupl 
	// Description
	// Utility to clean duplicates from the [Owners of Data] where 
	// there are multiple entries for a user per Log ID
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM05a
End if 
SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
ALL RECORDS:C47([Owners of Data:62])
ORDER BY:C49([Owners of Data:62]; [Owners of Data:62]RefID:1; >; [Owners of Data:62]Owner Name:2)
C_LONGINT:C283($NumOwnRecs_L; $RecCounter_L; $NumOwnRecsDup_L; $NumOwnRecsDupLock_L; $LastRefID_L)
C_TEXT:C284($DuplicateSetName_txt; $LastOwner_txt)
$DuplicateSetName_txt:="DuplicateOwnerRecs"
CREATE EMPTY SET:C140([Owners of Data:62]; $DuplicateSetName_txt)
$LastRefID_L:=0
$LastOwner_txt:=""
While (Not:C34(End selection:C36([Owners of Data:62])))
	If ([Owners of Data:62]RefID:1=$LastRefID_L)
		If ([Owners of Data:62]Owner Name:2=$LastOwner_txt)
			ADD TO SET:C119([Owners of Data:62]; $DuplicateSetName_txt)
		Else 
			$LastOwner_txt:=[Owners of Data:62]Owner Name:2
		End if 
	Else 
		$LastRefID_L:=[Owners of Data:62]RefID:1
	End if 
	
	NEXT RECORD:C51([Owners of Data:62])
End while 
$NumOwnRecsDup_L:=Records in set:C195($DuplicateSetName_txt)
If ($NumOwnRecsDup_L=0)
	ALERT:C41("There were no duplicate records found in the [Owners] table!")
Else 
	
	CONFIRM:C162("There are "+String:C10($NumOwnRecsDup_L)+" duplicates in [Owners] table. Delete them?"; "Delete"; "No")
	If (OK=1)
		USE SET:C118($DuplicateSetName_txt)
		DELETE SELECTION:C66([Owners of Data:62])
		If (Records in set:C195("LockedSet")>0)
			$NumOwnRecsDupLock_L:=Records in set:C195("LockedSet")
			ALERT:C41("There were "+String:C10($NumOwnRecsDupLock_L)+" locked records not deleted")
		End if 
		//FLUSH CACHE
	End if 
End if 

CLEAR SET:C117($DuplicateSetName_txt)
REDUCE SELECTION:C351([Owners of Data:62]; 0)
UNLOAD RECORD:C212([Owners of Data:62])
SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
