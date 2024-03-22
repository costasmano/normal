//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/19/06, 09:39:51
	// ----------------------------------------------------
	// Method: Method: INSP_ut_FixTeamMember
	// Description
	// fix Team member mixups
	// 
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(10/10/2006 14:29:35)
	Mods_2006_CM06A
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
End if 
C_TEXT:C284($TmMbrID_s)  // Command Replaced was o_C_STRING length was 10
C_LONGINT:C283($FromTmMbrID_L; $ToTmMbrID_L; $CurrInspID_L)
READ ONLY:C145(*)
C_BOOLEAN:C305($Done_b)
$Done_b:=False:C215
SORT ARRAY:C229(aPeople; aPeople_ID)
ARRAY TEXT:C222(ListofInspectors_at; Size of array:C274(aPeople))
C_LONGINT:C283($i; $k)
For ($i; 1; Size of array:C274(aPeople))
	ListofInspectors_at{$i}:=aPeople{$i}+" <"+String:C10(aPeople_ID{$i})+">"
End for 

Repeat 
	$K:=G_PickFromList(->ListofInspectors_at)
	If ($k>0)
		$FromTmMbrID_L:=aPeople_ID{$K}
		$Done_b:=True:C214
	Else 
		$FromTmMbrID_L:=0
		$Done_b:=True:C214
	End if 
Until ($Done_b)
If ($FromTmMbrID_L>0)
	$Done_b:=False:C215
	Repeat 
		$K:=G_PickFromList(->ListofInspectors_at)
		If ($k>0)
			$ToTmMbrID_L:=aPeople_ID{$K}
			$Done_b:=True:C214
		Else 
			$ToTmMbrID_L:=0
			$Done_b:=True:C214
		End if 
		
	Until ($Done_b)
	
End if 
If (($FromTmMbrID_L>0) & ($ToTmMbrID_L>0))
	QUERY:C277([Field Trip:43]; [Field Trip:43]Person ID:2=$FromTmMbrID_L)
	ARRAY LONGINT:C221($InspIDS_aL; 0)
	If (Records in selection:C76([Field Trip:43])>0)
		SELECTION TO ARRAY:C260([Field Trip:43]InspID:1; $InspIDS_aL)
		READ WRITE:C146([Field Trip:43])
		FIRST RECORD:C50([Field Trip:43])
		While (Not:C34(End selection:C36([Field Trip:43])))
			QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[Field Trip:43]InspID:1)
			If (Records in selection:C76([Inspections:27])=1)
				LogDeletion(->[Inspections:27]InspID:2; ->[Field Trip:43]InspID:1; ->[Field Trip:43]Person ID:2; 3; ->[Personnel:42]Person ID:1)
			End if 
			NEXT RECORD:C51([Field Trip:43])
		End while 
		DELETE SELECTION:C66([Field Trip:43])
		For ($i; 1; Size of array:C274($InspIDS_aL))
			QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=$InspIDS_aL{$i})
			If (Records in selection:C76([Inspections:27])=1)
				CREATE RECORD:C68([Field Trip:43])
				[Field Trip:43]InspID:1:=[Inspections:27]InspID:2
				[Field Trip:43]Person ID:2:=$ToTmMbrID_L
				LogNewRecord(->[Inspections:27]InspID:2; ->[Field Trip:43]InspID:1; ->[Field Trip:43]Person ID:2; 3; ""; ->[Personnel:42]Person ID:1)
				SAVE RECORD:C53([Field Trip:43])
			End if 
		End for 
		
	Else 
		ALERT:C41("No Field trip records found for ID "+String:C10($FromTmMbrID_L))
	End if 
	QUERY:C277([BMS Field Trip:56]; [BMS Field Trip:56]Person ID:2=$FromTmMbrID_L)
	If (Records in selection:C76([BMS Field Trip:56])>0)
		SELECTION TO ARRAY:C260([BMS Field Trip:56]Inspection ID:1; $InspIDS_aL)
		READ WRITE:C146([BMS Field Trip:56])
		FIRST RECORD:C50([BMS Field Trip:56])
		While (Not:C34(End selection:C36([BMS Field Trip:56])))
			QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[BMS Field Trip:56]Inspection ID:1)
			If (Records in selection:C76([BMS Inspections:44])=1)
				LogDeletion(->[BMS Inspections:44]Inspection ID:1; ->[BMS Field Trip:56]Inspection ID:1; ->[BMS Field Trip:56]Person ID:2; 3; ->[Personnel:42]Person ID:1)
			End if 
			NEXT RECORD:C51([BMS Field Trip:56])
		End while 
		DELETE SELECTION:C66([BMS Field Trip:56])
		For ($i; 1; Size of array:C274($InspIDS_aL))
			QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=$InspIDS_aL{$i})
			If (Records in selection:C76([BMS Inspections:44])=1)
				CREATE RECORD:C68([BMS Field Trip:56])
				[BMS Field Trip:56]Inspection ID:1:=[BMS Inspections:44]Inspection ID:1
				[BMS Field Trip:56]Person ID:2:=$ToTmMbrID_L
				LogNewRecord(->[BMS Inspections:44]Inspection ID:1; ->[BMS Field Trip:56]Inspection ID:1; ->[BMS Field Trip:56]Person ID:2; 3; ""; ->[Personnel:42]Person ID:1)
				SAVE RECORD:C53([BMS Field Trip:56])
			End if 
		End for 
		
	Else 
		ALERT:C41("No BMS Field trip records found for ID "+String:C10($FromTmMbrID_L))
	End if 
	
End if 