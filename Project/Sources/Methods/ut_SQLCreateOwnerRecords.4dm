//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 07/08/10, 14:21:48
// ----------------------------------------------------
// Method: ut_SQLCreateOwnerRecords
// Description
// <caret/>
//
// Parameters
// ----------------------------------------------------


// Modified by: Charles Miller (7/8/10)
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:17:56) 
	//Modify how (Not(4DError_b)) and (Not(SQLError_b)) handled replace with (ut_fTestForSQLor4DError)
	//Modified by: Charles Miller (11/4/11 11:12:42)
	
End if 
C_BOOLEAN:C305($OriginalonScreen_b)
C_LONGINT:C283($InnerLoop_l)
If (ut_fTestForSQLor4DError)
	CREATE RECORD:C68([Owners of Data:62])
	[Owners of Data:62]RefID:1:=[Activity Log:59]RefID:28
	[Owners of Data:62]Owner Name:2:=Current user:C182
	SAVE RECORD:C53([Owners of Data:62])
	ut_SQLCreateRemoteOwnerRecord
	$OriginalonScreen_b:=vbOnScreenMessage
	If (ut_fTestForSQLor4DError)
		UNLOAD RECORD:C212([Owners of Data:62])
		
		vbOnScreenMessage:=$OriginalonScreen_b
		C_LONGINT:C283($Count_l)
		
		ut_SQLReturnownerRecords
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_l)
		
		If (ut_fTestForSQLor4DError)
			For ($InnerLoop_l; 1; Size of array:C274(Owners_atxt))
				QUERY:C277([Owners of Data:62]; [Owners of Data:62]RefID:1=[Activity Log:59]RefID:28; *)
				QUERY:C277([Owners of Data:62];  & ; [Owners of Data:62]Owner Name:2=Owners_atxt{$InnerLoop_l})
				If ($Count_l=0)
					CREATE RECORD:C68([Owners of Data:62])
					[Owners of Data:62]RefID:1:=[Activity Log:59]RefID:28
					[Owners of Data:62]Owner Name:2:=Owners_atxt{$InnerLoop_l}
					SAVE RECORD:C53([Owners of Data:62])
					UNLOAD RECORD:C212([Owners of Data:62])
				End if 
			End for 
		Else 
			
			If (4DError_b)
				C_BOOLEAN:C305($OriginalonScreen_b)
				$OriginalonScreen_b:=vbOnScreenMessage
				vbOnScreenMessage:=False:C215
				ut_SQLWriteErrorsToLog("Act Log error in "+Current method name:C684+"  -ID"+String:C10([Activity Log:59]RefID:28)+<>sCR)
				vbOnScreenMessage:=$OriginalonScreen_b
			End if 
			
		End if 
	End if 
End if 
SET QUERY DESTINATION:C396(Into current selection:K19:1)
