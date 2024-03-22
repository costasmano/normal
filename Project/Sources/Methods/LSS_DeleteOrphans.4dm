//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 02/22/16, 13:16:11
//----------------------------------------------------
//Method: LSS_DeleteOrphans
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// 
	//Modified by: administrator (2/22/16 13:16:12)
	
End if 
ARRAY TEXT:C222($LSSUTResults_atxt; 0)
ARRAY TEXT:C222($LSSUTInspID_atxt; 0)
ARRAY TEXT:C222($LSSVCInspID_atxt; 0)
ARRAY TEXT:C222($LSSTDInspID_atxt; 0)
ARRAY TEXT:C222($LSSSPInspID_atxt; 0)
ARRAY TEXT:C222($LSSPhotoInspID_atxt; 0)
ARRAY TEXT:C222($LSSInspID_atxt; 0)
ARRAY TEXT:C222($LSSElemInspID_atxt; 0)
ARRAY TEXT:C222($LSSDmeterInspID_atxt; 0)
ARRAY TEXT:C222($LSSACCInspID_atxt; 0)
ARRAY TEXT:C222($LSSInvID_atxt; 0)
ARRAY TEXT:C222($LSSInventoryID_atxt; 0)


Begin SQL
	
	select [LSS_UtResult].[LSS_UTId_s]
	from
	[LSS_UtResult]
	into :$LSSUTResults_atxt;
	
	select [LSS_UT].[LSS_InspectionId_s]
	from
	 [LSS_UT]
	 into :$LSSUTInspID_atxt;
	
	select [LSS_VerticalClearance].[LSS_InspectionId_s]
	from
	 [LSS_VerticalClearance]
	 into :$LSSVCInspID_atxt;
	
	select [LSS_TowerDistance].[LSS_InspectionId_s]
	from
	 [LSS_TowerDistance]
	 into :$LSSTDInspID_atxt;
	
	select [LSS_SignPanel].[LSS_InspectionId_s]
	from
	 [LSS_SignPanel]
	 into :$LSSSPInspID_atxt;
	
	select [LSS_Photos].[LSS_InspectionId_s]
	from
	 [LSS_Photos]
	 into :$LSSPhotoInspID_atxt;
	
	select [LSS_Inspection].[LSS_InspectionId_s],
	[LSS_Inspection].[LSS_InventoryId_s]
	from
	[LSS_Inspection]
	 into :$LSSInspID_atxt,
	 :$LSSInvID_atxt;
	
	select [LSS_ElementInspection].[LSS_InspectionId_s]
	from
	[LSS_ElementInspection]
	 into :$LSSElemInspID_atxt;
	
	select [LSS_DMeter].[LSS_InspectionId_s]
	from
	[LSS_DMeter]
	 into :$LSSDmeterInspID_atxt;
	
	select [LSS_Accessibility].[LSS_InspectionId_s]
	from
	[LSS_Accessibility]
	 into :$LSSACCInspID_atxt;
	
	select [LSS_Inventory].[LSS_InventoryId_s]
	from
	[LSS_Inventory]
	into :$LSSInventoryID_atxt;
	
	
End SQL


C_LONGINT:C283($Loop_L; $Count_L)

SHORT_MESSAGE(" [LSS_UtResult] ......")
For ($Loop_L; Size of array:C274($LSSUTResults_atxt); 1; -1)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
	QUERY:C277([LSS_UT:175]; [LSS_UT:175]LSS_UTId_s:1=$LSSUTResults_atxt{$Loop_L})
	If ($Count_L=0)
		
	Else 
		DELETE FROM ARRAY:C228($LSSUTResults_atxt; $Loop_L; 1)
	End if 
	
End for 
SET QUERY DESTINATION:C396(Into current selection:K19:1)
If (Size of array:C274($LSSUTResults_atxt)>0)
	UNLOAD RECORD:C212([LSS_UtResult:176])
	READ WRITE:C146([LSS_UtResult:176])
	
	QUERY WITH ARRAY:C644([LSS_UtResult:176]LSS_UTId_s:2; $LSSUTResults_atxt)
	ALERT:C41("Deleting "+String:C10(Records in selection:C76([LSS_UtResult:176]))+" orphan [LSS_UtResult] records")
	Repeat 
		DELETE SELECTION:C66([LSS_UtResult:176])
		If (Records in set:C195("LockedSet")>0)
			USE SET:C118("LockedSet")
			ALERT:C41("Trying to delete orphan [LSS_UtResult] records")
		End if 
		
	Until (Records in set:C195("LockedSet")=0)
End if 

MESSAGE:C88(" [LSS_UT] .........")
For ($Loop_L; Size of array:C274($LSSUTInspID_atxt); 1; -1)
	
	If (Find in array:C230($LSSInspID_atxt; $LSSUTInspID_atxt{$Loop_L})>0)
		DELETE FROM ARRAY:C228($LSSUTInspID_atxt; $Loop_L; 1)
	End if 
End for 

If (Size of array:C274($LSSUTInspID_atxt)>0)
	UNLOAD RECORD:C212([LSS_UT:175])
	READ WRITE:C146([LSS_UT:175])
	
	QUERY WITH ARRAY:C644([LSS_UT:175]LSS_InspectionId_s:2; $LSSUTInspID_atxt)
	ALERT:C41("Deleting "+String:C10(Records in selection:C76([LSS_UT:175]))+" orphan [LSS_UT] records")
	
	Repeat 
		DELETE SELECTION:C66([LSS_UT:175])
		If (Records in set:C195("LockedSet")>0)
			USE SET:C118("LockedSet")
			ALERT:C41("Trying to delete orphan [LSS_UT] records")
		End if 
		
	Until (Records in set:C195("LockedSet")=0)
End if 

MESSAGE:C88(" [LSS_VerticalClearance] .........")

For ($Loop_L; Size of array:C274($LSSVCInspID_atxt); 1; -1)
	
	If (Find in array:C230($LSSInspID_atxt; $LSSVCInspID_atxt{$Loop_L})>0)
		DELETE FROM ARRAY:C228($LSSVCInspID_atxt; $Loop_L; 1)
	End if 
End for 

If (Size of array:C274($LSSVCInspID_atxt)>0)
	UNLOAD RECORD:C212([LSS_VerticalClearance:177])
	READ WRITE:C146([LSS_VerticalClearance:177])
	
	QUERY WITH ARRAY:C644([LSS_VerticalClearance:177]LSS_InspectionId_s:2; $LSSVCInspID_atxt)
	ALERT:C41("Deleting "+String:C10(Records in selection:C76([LSS_VerticalClearance:177]))+" orphan [LSS_VerticalClearance] records")
	
	Repeat 
		DELETE SELECTION:C66([LSS_VerticalClearance:177])
		If (Records in set:C195("LockedSet")>0)
			USE SET:C118("LockedSet")
			ALERT:C41("Trying to delete orphan [LSS_VerticalClearance] records")
		End if 
		
	Until (Records in set:C195("LockedSet")=0)
End if 

MESSAGE:C88(" [LSS_TowerDistance] .........")
For ($Loop_L; Size of array:C274($LSSTDInspID_atxt); 1; -1)
	If (Find in array:C230($LSSInspID_atxt; $LSSTDInspID_atxt{$Loop_L})>0)
		DELETE FROM ARRAY:C228($LSSTDInspID_atxt; $Loop_L; 1)
	End if 
	
	
End for 

If (Size of array:C274($LSSTDInspID_atxt)>0)
	UNLOAD RECORD:C212([LSS_TowerDistance:174])
	READ WRITE:C146([LSS_TowerDistance:174])
	
	QUERY WITH ARRAY:C644([LSS_TowerDistance:174]LSS_InspectionId_s:2; $LSSTDInspID_atxt)
	ALERT:C41("Deleting "+String:C10(Records in selection:C76([LSS_TowerDistance:174]))+" orphan [LSS_TowerDistance] records")
	
	Repeat 
		DELETE SELECTION:C66([LSS_TowerDistance:174])
		If (Records in set:C195("LockedSet")>0)
			USE SET:C118("LockedSet")
			ALERT:C41("Trying to delete orphan [LSS_TowerDistance] records")
		End if 
		
	Until (Records in set:C195("LockedSet")=0)
End if 

MESSAGE:C88(" [LSS_SignPanel] .........")
For ($Loop_L; Size of array:C274($LSSSPInspID_atxt); 1; -1)
	If (Find in array:C230($LSSInspID_atxt; $LSSSPInspID_atxt{$Loop_L})>0)
		DELETE FROM ARRAY:C228($LSSSPInspID_atxt; $Loop_L; 1)
	End if 
	
End for 

If (Size of array:C274($LSSSPInspID_atxt)>0)
	UNLOAD RECORD:C212([LSS_SignPanel:172])
	READ WRITE:C146([LSS_SignPanel:172])
	
	QUERY WITH ARRAY:C644([LSS_SignPanel:172]LSS_InspectionId_s:2; $LSSSPInspID_atxt)
	ALERT:C41("Deleting "+String:C10(Records in selection:C76([LSS_SignPanel:172]))+" orphan [LSS_SignPanel] records")
	
	Repeat 
		DELETE SELECTION:C66([LSS_SignPanel:172])
		If (Records in set:C195("LockedSet")>0)
			USE SET:C118("LockedSet")
			ALERT:C41("Trying to delete orphan [LSS_SignPanel] records")
		End if 
		
	Until (Records in set:C195("LockedSet")=0)
End if 

MESSAGE:C88(" [LSS_Photos] .........")
For ($Loop_L; Size of array:C274($LSSPhotoInspID_atxt); 1; -1)
	If (Find in array:C230($LSSInspID_atxt; $LSSPhotoInspID_atxt{$Loop_L})>0)
		DELETE FROM ARRAY:C228($LSSPhotoInspID_atxt; $Loop_L; 1)
	End if 
	
End for 

If (Size of array:C274($LSSPhotoInspID_atxt)>0)
	UNLOAD RECORD:C212([LSS_Photos:166])
	READ WRITE:C146([LSS_Photos:166])
	
	QUERY WITH ARRAY:C644([LSS_Photos:166]LSS_InspectionId_s:2; $LSSPhotoInspID_atxt)
	ALERT:C41("Deleting "+String:C10(Records in selection:C76([LSS_Photos:166]))+" orphan [LSS_Photos] records")
	
	Repeat 
		DELETE SELECTION:C66([LSS_Photos:166])
		If (Records in set:C195("LockedSet")>0)
			USE SET:C118("LockedSet")
			ALERT:C41("Trying to delete orphan [LSS_Photos] records")
		End if 
		
	Until (Records in set:C195("LockedSet")=0)
End if 

MESSAGE:C88(" [LSS_ElementInspection] .........")
For ($Loop_L; Size of array:C274($LSSElemInspID_atxt); 1; -1)
	If (Find in array:C230($LSSInspID_atxt; $LSSElemInspID_atxt{$Loop_L})>0)
		DELETE FROM ARRAY:C228($LSSElemInspID_atxt; $Loop_L; 1)
	End if 
End for 

If (Size of array:C274($LSSElemInspID_atxt)>0)
	UNLOAD RECORD:C212([LSS_ElementInspection:163])
	READ WRITE:C146([LSS_ElementInspection:163])
	
	QUERY WITH ARRAY:C644([LSS_ElementInspection:163]LSS_InspectionId_s:3; $LSSElemInspID_atxt)
	ALERT:C41("Deleting "+String:C10(Records in selection:C76([LSS_ElementInspection:163]))+" orphan [LSS_ElementInspection] records")
	
	Repeat 
		DELETE SELECTION:C66([LSS_ElementInspection:163])
		If (Records in set:C195("LockedSet")>0)
			USE SET:C118("LockedSet")
			ALERT:C41("Trying to delete orphan [LSS_ElementInspection] records")
		End if 
		
	Until (Records in set:C195("LockedSet")=0)
End if 

MESSAGE:C88(" [LSS_DMeter] .........")
For ($Loop_L; Size of array:C274($LSSDmeterInspID_atxt); 1; -1)
	If (Find in array:C230($LSSInspID_atxt; $LSSDmeterInspID_atxt{$Loop_L})>0)
		DELETE FROM ARRAY:C228($LSSDmeterInspID_atxt; $Loop_L; 1)
	End if 
	
End for 

If (Size of array:C274($LSSDmeterInspID_atxt)>0)
	UNLOAD RECORD:C212([LSS_DMeter:161])
	READ WRITE:C146([LSS_DMeter:161])
	
	QUERY WITH ARRAY:C644([LSS_DMeter:161]LSS_InspectionId_s:2; $LSSDmeterInspID_atxt)
	ALERT:C41("Deleting "+String:C10(Records in selection:C76([LSS_DMeter:161]))+" orphan [LSS_DMeter] records")
	
	Repeat 
		DELETE SELECTION:C66([LSS_DMeter:161])
		If (Records in set:C195("LockedSet")>0)
			USE SET:C118("LockedSet")
			ALERT:C41("Trying to delete orphan [LSS_DMeter] records")
		End if 
		
	Until (Records in set:C195("LockedSet")=0)
End if 

MESSAGE:C88(" [LSS_Accessibility] .........")
For ($Loop_L; Size of array:C274($LSSACCInspID_atxt); 1; -1)
	If (Find in array:C230($LSSInspID_atxt; $LSSACCInspID_atxt{$Loop_L})>0)
		DELETE FROM ARRAY:C228($LSSACCInspID_atxt; $Loop_L; 1)
	End if 
End for 

If (Size of array:C274($LSSACCInspID_atxt)>0)
	UNLOAD RECORD:C212([LSS_Accessibility:159])
	READ WRITE:C146([LSS_Accessibility:159])
	
	QUERY WITH ARRAY:C644([LSS_Accessibility:159]LSS_InspectionId_s:3; $LSSACCInspID_atxt)
	ALERT:C41("Deleting "+String:C10(Records in selection:C76([LSS_Accessibility:159]))+" orphan [LSS_Accessibility] records")
	
	Repeat 
		DELETE SELECTION:C66([LSS_Accessibility:159])
		If (Records in set:C195("LockedSet")>0)
			USE SET:C118("LockedSet")
			ALERT:C41("Trying to delete orphan [LSS_Accessibility] records")
		End if 
		
	Until (Records in set:C195("LockedSet")=0)
End if 


MESSAGE:C88(" [LSS_Inspection] .........")
For ($Loop_L; Size of array:C274($LSSInspID_atxt); 1; -1)
	If (Find in array:C230($LSSInventoryID_atxt; $LSSInvID_atxt{$Loop_L})>0)
		DELETE FROM ARRAY:C228($LSSInspID_atxt; $Loop_L; 1)
	End if 
End for 

If (Size of array:C274($LSSInspID_atxt)>0)
	UNLOAD RECORD:C212([LSS_Inspection:164])
	READ WRITE:C146([LSS_Inspection:164])
	
	QUERY WITH ARRAY:C644([LSS_Inspection:164]LSS_InspectionId_s:1; $LSSInspID_atxt)
	ALERT:C41("Deleting "+String:C10(Records in selection:C76([LSS_Inspection:164]))+" orphan [LSS_Inspection] records")
	
	Repeat 
		DELETE SELECTION:C66([LSS_Inspection:164])
		If (Records in set:C195("LockedSet")>0)
			USE SET:C118("LockedSet")
			ALERT:C41("Trying to delete orphan [LSS_Inspection] records")
		End if 
		
	Until (Records in set:C195("LockedSet")=0)
End if 
CLOSE WINDOW:C154
ALERT:C41("Done")

//End LSS_DeleteOrphans