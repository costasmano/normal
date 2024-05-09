//%attributes = {"invisible":true}
//Method: LSS_DuplicateInspection
//Description
// duplicate the current inspection - meant to be used in 'batch' mode to create inspection assignments.
// Parameters
// $1 : $parameterobject
//   ->  .contractno
//   ->  .assignno
//   ->  .batch (boolean) optional
//   ->  .showmessage  (boolean) optional

//   <-  .newinspid 
//   <-  .newinsptype 
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Feb 6, 2024, 15:12:56
	Mods_2024_LSS_1
	// ----------------------------------------------------
	
	C_OBJECT:C1216(LSS_DuplicateInspection; $1)
	
End if 
//
C_OBJECT:C1216($1; $param_o)
$param_o:=$1

C_BOOLEAN:C305($one_b; $many_b)
GET AUTOMATIC RELATIONS:C899($one_b; $many_b)
SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)

C_TEXT:C284($ErrorMethodCalled_txt; $NewInspectionTypeID_txt)
$ErrorMethodCalled_txt:=Method called on error:C704
ON ERR CALL:C155("LSS_ErrorMethod")
C_TEXT:C284($oldInspID_txt)
$oldInspID_txt:=[LSS_Inspection:164]LSS_InspectionId_s:1
C_LONGINT:C283($Key_L; $Loop_l; $InnerLoop_l; $totUtresults_L)

C_BOOLEAN:C305($showMessage_b; $batchDuplication)
$batchDuplication:=True:C214
$showMessage_b:=False:C215
If ($param_o.batch#Null:C1517)
	$batchDuplication:=$param_o.batch
End if 

If ($param_o.showmessage#Null:C1517)
	$showMessage_b:=$param_o.showmessage
End if 


If ($showMessage_b)
	//start the bar
	C_OBJECT:C1216($dupprogress_o)
	$dupprogress_o:=ProgressNew("Duplicating inspection "+$param_o.strnum; 1; False:C215; ""; 0)
	Progress SET PROGRESS($dupprogress_o.progress; -1)
End if 

Inc_Sequence("LSS_InspectionId_s"; ->$Key_L)
DUPLICATE RECORD:C225([LSS_Inspection:164])
$param_o.oldinspid:=[LSS_Inspection:164]LSS_InspectionId_s:1
$param_o.oldinsptype:=[LSS_Inspection:164]LSS_InspectionTypeId_s:3
$param_o.oldinspdate:=[LSS_Inspection:164]LSS_InspectionDate_d:4

If (Not:C34($batchDuplication))
	[LSS_Inspection:164]LSS_InspectionDate_d:4:=Current date:C33
	[LSS_Inspection:164]LSS_CreatedBy_s:45:=Current user:C182
	[LSS_Inspection:164]LSS_ConsultantName_txt:10:=<>PERS_MyCompany_txt
	
	ARRAY TEXT:C222(LSS_ProjManagers_atxt; 0)
	LSS_SetPersonnel
	[LSS_Inspection:164]LSS_TeamLeaderId_L:8:=0
	If (GRP_UserInGroup("LSS_TeamLeader"; <>CurrentUser_PID)=1)
		[LSS_Inspection:164]LSS_TeamLeaderId_L:8:=<>CurrentUser_PID
	End if 
	C_LONGINT:C283($currentPM_L)
	$currentPM_L:=[LSS_Inspection:164]LSS_ProjectManagerId_L:9
	If (Size of array:C274(LSS_ProjManagers_atxt)>0)
		If (Find in array:C230(LSS_ProjManagerIDs_aL; $currentPM_L)>0)
			
		Else 
			[LSS_Inspection:164]LSS_ProjectManagerId_L:9:=LSS_ProjManagerIDs_aL{1}
		End if 
		
	Else 
		[LSS_Inspection:164]LSS_ProjectManagerId_L:9:=0
	End if 
	
	$NewInspectionTypeID_txt:=[LSS_Inspection:164]LSS_InspectionTypeId_s:3
	If ([LSS_Inspection:164]LSS_InspectionTypeId_s:3="@01")
		//duplicating an initial inspection - change the type to Routine
		$NewInspectionTypeID_txt:=Substring:C12([LSS_Inspection:164]LSS_InspectionTypeId_s:3; 1; Length:C16([LSS_Inspection:164]LSS_InspectionTypeId_s:3)-1)+"2"
	Else 
		
	End if 
	[LSS_Inspection:164]LSS_InspectionTypeId_s:3:=$NewInspectionTypeID_txt
	[LSS_Inspection:164]LSS_ContractNo_L:60:=0
	[LSS_Inspection:164]LSS_AssignmentNo_L:61:=0
	
Else 
	
	[LSS_Inspection:164]LSS_InspectionDate_d:4:=!00-00-00!
	[LSS_Inspection:164]LSS_CreatedBy_s:45:=""
	[LSS_Inspection:164]LSS_ConsultantName_txt:10:=""
	[LSS_Inspection:164]LSS_TeamLeaderId_L:8:=0
	[LSS_Inspection:164]LSS_ProjectManagerId_L:9:=0
	//assign Contract no and assignment number
	[LSS_Inspection:164]LSS_ContractNo_L:60:=$param_o.contractno
	[LSS_Inspection:164]LSS_AssignmentNo_L:61:=$param_o.assignno
	//in batch mode we use the type from parameter
	[LSS_Inspection:164]LSS_InspectionTypeId_s:3:=$param_o.insptype
	
End if 

[LSS_Inspection:164]LSS_CreatedISODate_s:46:=ISODateTime(Current date:C33; Current time:C178)
[LSS_Inspection:164]LSS_InspectionId_s:1:=String:C10($Key_L; <>KeyMask_s)

$param_o.newinspid:=[LSS_Inspection:164]LSS_InspectionId_s:1
$param_o.newinsptype:=[LSS_Inspection:164]LSS_InspectionTypeId_s:3

//clear fields
[LSS_Inspection:164]LSS_DistHWYEngineerId_L:5:=0
[LSS_Inspection:164]LSS_ModifiedBy_s:47:=""
[LSS_Inspection:164]LSS_ModifiedISODate_s:48:=""
[LSS_Inspection:164]LSS_Approved_L:43:=0
[LSS_Inspection:164]LSS_ApprovedDate_d:44:=!00-00-00!
[LSS_Inspection:164]LSS_Complete_b:39:=False:C215
[LSS_Inspection:164]LSS_CompleteDate_d:40:=!00-00-00!
[LSS_Inspection:164]LSS_DateOfPhotos_d:30:=!00-00-00!
[LSS_Inspection:164]LSS_Photos_b:29:=False:C215
[LSS_Inspection:164]LSS_ReviewDate_d:42:=!00-00-00!
[LSS_Inspection:164]LSS_Reviewed_L:41:=0

//set previous cond to the current
[LSS_Inspection:164]LSS_CondFoundationPrev_s:13:=[LSS_Inspection:164]LSS_CondFoundationCurr_s:12
[LSS_Inspection:164]LSS_CondLuminairePrev_s:23:=[LSS_Inspection:164]LSS_CondLuminaireCurr_s:22
[LSS_Inspection:164]LSS_CondOverallPrev_s:25:=[LSS_Inspection:164]LSS_CondOverallCurr_s:24
[LSS_Inspection:164]LSS_CondSignPanelsPrev_s:19:=[LSS_Inspection:164]LSS_CondSignPanelsCurr_s:18
[LSS_Inspection:164]LSS_CondStructurePrev_s:15:=[LSS_Inspection:164]LSS_CondStructureCurr_s:14
[LSS_Inspection:164]LSS_CondTrafficSafetyPrev_s:21:=[LSS_Inspection:164]LSS_CondTrafficSafetyPrev_s:21
[LSS_Inspection:164]LSS_StructAttachmentsPrev_s:17:=[LSS_Inspection:164]LSS_StructAttachmentsCurr_s:16

SAVE RECORD:C53([LSS_Inspection:164])
C_TEXT:C284($newInspID_txt)
$newInspID_txt:=[LSS_Inspection:164]LSS_InspectionId_s:1
$param_o.items:=New object:C1471

//copy accessibility
QUERY:C277([LSS_Accessibility:159]; [LSS_Accessibility:159]LSS_InspectionId_s:3=$oldInspID_txt)
$param_o.items.accessibility:=Records in selection:C76([LSS_Accessibility:159])
If (Records in selection:C76([LSS_Accessibility:159])>0)
	If ($showMessage_b)
		Progress SET MESSAGE($dupprogress_o.progress; String:C10(Records in selection:C76([LSS_Accessibility:159]))+" Accessibility Items...")
		//MESSAGE(Char(13)+String(Records in selection([LSS_Accessibility]))+" Accessibility Items...")
	End if 
	ARRAY LONGINT:C221($RecordNumbers_aL; 0)
	LONGINT ARRAY FROM SELECTION:C647([LSS_Accessibility:159]; $RecordNumbers_aL)
	For ($Loop_l; 1; Size of array:C274($RecordNumbers_aL))
		
		GOTO RECORD:C242([LSS_Accessibility:159]; $RecordNumbers_aL{$Loop_l})
		DUPLICATE RECORD:C225([LSS_Accessibility:159])
		[LSS_Accessibility:159]LSS_InspectionId_s:3:=$newInspID_txt
		C_LONGINT:C283($Key_L)
		Inc_Sequence("LSS_AccessibilityId_s"; ->$Key_L)
		[LSS_Accessibility:159]LSS_AccessibilityId_s:1:=String:C10($Key_L; <>KeyMask_s)
		
		SAVE RECORD:C53([LSS_Accessibility:159])
		
	End for 
	
End if 

//copy d-meter
QUERY:C277([LSS_DMeter:161]; [LSS_DMeter:161]LSS_InspectionId_s:2=$oldInspID_txt)
$param_o.items.dmeter:=Records in selection:C76([LSS_DMeter:161])

If (Records in selection:C76([LSS_DMeter:161])>0)
	If ($showMessage_b)
		Progress SET MESSAGE($dupprogress_o.progress; String:C10(Records in selection:C76([LSS_DMeter:161]))+" D-Meter...")
	End if 
	
	ARRAY LONGINT:C221($RecordNumbers_aL; 0)
	LONGINT ARRAY FROM SELECTION:C647([LSS_DMeter:161]; $RecordNumbers_aL)
	For ($Loop_l; 1; Size of array:C274($RecordNumbers_aL))
		
		GOTO RECORD:C242([LSS_DMeter:161]; $RecordNumbers_aL{$Loop_l})
		DUPLICATE RECORD:C225([LSS_DMeter:161])
		[LSS_DMeter:161]LSS_InspectionId_s:2:=$newInspID_txt
		C_LONGINT:C283($Key_L)
		
		Inc_Sequence("LSS_DMeterId_s"; ->$Key_L)
		[LSS_DMeter:161]LSS_DMeterId_s:1:=String:C10($Key_L; <>KeyMask_s)
		
		SAVE RECORD:C53([LSS_DMeter:161])
		
	End for 
	
End if 

//copy elements
QUERY:C277([LSS_ElementInspection:163]; [LSS_ElementInspection:163]LSS_InspectionId_s:3=$oldInspID_txt; *)
QUERY:C277([LSS_ElementInspection:163];  & ; [LSS_ElementInspection:163]LSS_Rating_s:4#"N")
$param_o.items.elements:=Records in selection:C76([LSS_ElementInspection:163])

If (Records in selection:C76([LSS_ElementInspection:163])>0)
	If ($showMessage_b)
		Progress SET MESSAGE($dupprogress_o.progress; String:C10(Records in selection:C76([LSS_ElementInspection:163]))+" Inspection Elements...")
		//MESSAGE(Char(13)+String(Records in selection([LSS_ElementInspection]))+" Inspection Elements...")
	End if 
	
	ARRAY LONGINT:C221($RecordNumbers_aL; 0)
	LONGINT ARRAY FROM SELECTION:C647([LSS_ElementInspection:163]; $RecordNumbers_aL)
	For ($Loop_l; 1; Size of array:C274($RecordNumbers_aL))
		If ($showMessage_b)
			Progress SET MESSAGE($dupprogress_o.progress; String:C10($Loop_l; " #####")+" of "+String:C10(Size of array:C274($RecordNumbers_aL))+" Inspection Elements...")
			//MESSAGE(String($Loop_l;" #####..."))
		End if 
		GOTO RECORD:C242([LSS_ElementInspection:163]; $RecordNumbers_aL{$Loop_l})
		DUPLICATE RECORD:C225([LSS_ElementInspection:163])
		[LSS_ElementInspection:163]LSS_InspectionId_s:3:=$newInspID_txt
		C_LONGINT:C283($Key_L)
		
		Inc_Sequence("LSS_ElementInspectionId_s"; ->$Key_L)
		[LSS_ElementInspection:163]LSS_ElementInspectionId_s:1:=String:C10($Key_L; <>KeyMask_s)
		
		SAVE RECORD:C53([LSS_ElementInspection:163])
		
	End for 
	
	
End if 

//copy D-Meter, UT sketches if not blank
QUERY:C277([LSS_Photos:166]; [LSS_Photos:166]LSS_PhotoType_s:3="Sketch D Meter"; *)
QUERY:C277([LSS_Photos:166];  | ; [LSS_Photos:166]LSS_PhotoType_s:3="Sketch UT"; *)
QUERY:C277([LSS_Photos:166];  & ; [LSS_Photos:166]LSS_InspectionId_s:2=$oldInspID_txt)
$param_o.items.sketchUt:=Records in selection:C76([LSS_Photos:166])

If (Records in selection:C76([LSS_Photos:166])>0)
	If ($showMessage_b)
		Progress SET MESSAGE($dupprogress_o.progress; String:C10(Records in selection:C76([LSS_Photos:166]))+" Sketch UT - DMeter...")
		//MESSAGE(Char(13)+String(Records in selection([LSS_Photos]))+" Images...")
	End if 
	ARRAY LONGINT:C221($RecordNumbers_aL; 0)
	LONGINT ARRAY FROM SELECTION:C647([LSS_Photos:166]; $RecordNumbers_aL)
	For ($Loop_l; 1; Size of array:C274($RecordNumbers_aL))
		If ($showMessage_b)
			Progress SET MESSAGE($dupprogress_o.progress; String:C10($Loop_l; " ##### of ")+String:C10(Size of array:C274($RecordNumbers_aL))+" Sketch UT - DMeter...")
			//MESSAGE(String($Loop_l;" #####..."))
		End if 
		GOTO RECORD:C242([LSS_Photos:166]; $RecordNumbers_aL{$Loop_l})
		If (BLOB size:C605([LSS_Photos:166]LSS_Photo_blb:5)>0)
			DUPLICATE RECORD:C225([LSS_Photos:166])
			[LSS_Photos:166]LSS_InspectionId_s:2:=$newInspID_txt
			C_LONGINT:C283($Key_L)
			
			Inc_Sequence("LSS_PhotoId_s"; ->$Key_L)
			[LSS_Photos:166]LSS_PhotoId_s:1:=String:C10($Key_L; <>KeyMask_s)
			
			SAVE RECORD:C53([LSS_Photos:166])
		End if 
		
	End for 
	
End if 

//copy Clearance sketches if not blank
QUERY:C277([LSS_Photos:166]; [LSS_Photos:166]LSS_PhotoType_s:3="Sketch"; *)
QUERY:C277([LSS_Photos:166];  & ; [LSS_Photos:166]LSS_InspectionId_s:2=$oldInspID_txt; *)
QUERY:C277([LSS_Photos:166];  & ; [LSS_Photos:166]LSS_Photo_txt:4="@Clearance@")
$param_o.items.sketchclr:=Records in selection:C76([LSS_Photos:166])

If (Records in selection:C76([LSS_Photos:166])>0)
	If ($showMessage_b)
		Progress SET MESSAGE($dupprogress_o.progress; String:C10(Records in selection:C76([LSS_Photos:166]))+" Clearance sketches...")
		//MESSAGE(Char(13)+String(Records in selection([LSS_Photos]))+" Images...")
	End if 
	ARRAY LONGINT:C221($RecordNumbers_aL; 0)
	LONGINT ARRAY FROM SELECTION:C647([LSS_Photos:166]; $RecordNumbers_aL)
	For ($Loop_l; 1; Size of array:C274($RecordNumbers_aL))
		If ($showMessage_b)
			Progress SET MESSAGE($dupprogress_o.progress; String:C10($Loop_l; " ##### of ")+String:C10(Size of array:C274($RecordNumbers_aL))+" Clearance sketches...")
			//MESSAGE(String($Loop_l;" #####..."))
		End if 
		GOTO RECORD:C242([LSS_Photos:166]; $RecordNumbers_aL{$Loop_l})
		If (BLOB size:C605([LSS_Photos:166]LSS_Photo_blb:5)>0)
			DUPLICATE RECORD:C225([LSS_Photos:166])
			[LSS_Photos:166]LSS_InspectionId_s:2:=$newInspID_txt
			C_LONGINT:C283($Key_L)
			
			Inc_Sequence("LSS_PhotoId_s"; ->$Key_L)
			[LSS_Photos:166]LSS_PhotoId_s:1:=String:C10($Key_L; <>KeyMask_s)
			
			SAVE RECORD:C53([LSS_Photos:166])
		End if 
		
	End for 
	
End if 

//sign Panels
QUERY:C277([LSS_SignPanel:172]; [LSS_SignPanel:172]LSS_InspectionId_s:2=$oldInspID_txt)
$param_o.items.signpanel:=Records in selection:C76([LSS_SignPanel:172])

If (Records in selection:C76([LSS_SignPanel:172])>0)
	If ($showMessage_b)
		Progress SET MESSAGE($dupprogress_o.progress; String:C10(Records in selection:C76([LSS_SignPanel:172]))+" Sign Panels...")
		//MESSAGE(Char(13)+String(Records in selection([LSS_SignPanel]))+" Sign Panels...")
	End if 
	ARRAY LONGINT:C221($RecordNumbers_aL; 0)
	LONGINT ARRAY FROM SELECTION:C647([LSS_SignPanel:172]; $RecordNumbers_aL)
	For ($Loop_l; 1; Size of array:C274($RecordNumbers_aL))
		If ($showMessage_b)
			Progress SET MESSAGE($dupprogress_o.progress; String:C10($Loop_l; " ##### of ")+String:C10(Size of array:C274($RecordNumbers_aL))+" Sign Panels...")
			//MESSAGE(String($Loop_l;" #####..."))
			
		End if 
		
		GOTO RECORD:C242([LSS_SignPanel:172]; $RecordNumbers_aL{$Loop_l})
		DUPLICATE RECORD:C225([LSS_SignPanel:172])
		[LSS_SignPanel:172]LSS_InspectionId_s:2:=$newInspID_txt
		C_LONGINT:C283($Key_L)
		
		Inc_Sequence("LSS_SignPanelId_s"; ->$Key_L)
		[LSS_SignPanel:172]LSS_SignPanelId_s:1:=String:C10($Key_L; <>KeyMask_s)
		
		SAVE RECORD:C53([LSS_SignPanel:172])
		
	End for 
	
End if 

//Tower distances
QUERY:C277([LSS_TowerDistance:174]; [LSS_TowerDistance:174]LSS_InspectionId_s:2=$oldInspID_txt)
$param_o.items.towerdist:=Records in selection:C76([LSS_TowerDistance:174])

If (Records in selection:C76([LSS_TowerDistance:174])>0)
	If ($showMessage_b)
		Progress SET MESSAGE($dupprogress_o.progress; String:C10(Records in selection:C76([LSS_TowerDistance:174]))+" Tower distances...")
		//MESSAGE(Char(13)+String(Records in selection([LSS_TowerDistance]))+" Tower Distances...")
		
	End if 
	
	ARRAY LONGINT:C221($RecordNumbers_aL; 0)
	LONGINT ARRAY FROM SELECTION:C647([LSS_TowerDistance:174]; $RecordNumbers_aL)
	For ($Loop_l; 1; Size of array:C274($RecordNumbers_aL))
		GOTO RECORD:C242([LSS_TowerDistance:174]; $RecordNumbers_aL{$Loop_l})
		DUPLICATE RECORD:C225([LSS_TowerDistance:174])
		[LSS_TowerDistance:174]LSS_InspectionId_s:2:=$newInspID_txt
		C_LONGINT:C283($Key_L)
		
		Inc_Sequence("LSS_TowerDistanceId_s"; ->$Key_L)
		[LSS_TowerDistance:174]LSS_TowerDistanceId_s:1:=String:C10($Key_L; <>KeyMask_s)
		
		SAVE RECORD:C53([LSS_TowerDistance:174])
		
	End for 
	
End if 

//UT inspections
QUERY:C277([LSS_UT:175]; [LSS_UT:175]LSS_InspectionId_s:2=$oldInspID_txt)
$param_o.items.ut:=Records in selection:C76([LSS_UT:175])
If (Records in selection:C76([LSS_UT:175])>0)
	C_TEXT:C284($oldUTID_txt; $newUTID_txt)
	$totUtresults_L:=0
	If ($showMessage_b)
		Progress SET MESSAGE($dupprogress_o.progress; String:C10(Records in selection:C76([LSS_UT:175]))+" UT Tests...")
		//MESSAGE(Char(13)+String(Records in selection([LSS_UT]))+" UT Tests...")
	End if 
	ARRAY LONGINT:C221($RecordNumbers_aL; 0)
	LONGINT ARRAY FROM SELECTION:C647([LSS_UT:175]; $RecordNumbers_aL)
	C_LONGINT:C283($totUtresults_L)
	For ($Loop_l; 1; Size of array:C274($RecordNumbers_aL))
		If ($showMessage_b)
			Progress SET MESSAGE($dupprogress_o.progress; String:C10($Loop_l; " ##### of ")+String:C10(Size of array:C274($RecordNumbers_aL))+" UT Tests...")
			//MESSAGE(String($Loop_l;" #####..."))
		End if 
		
		GOTO RECORD:C242([LSS_UT:175]; $RecordNumbers_aL{$Loop_l})
		$oldUTID_txt:=[LSS_UT:175]LSS_UTId_s:1
		DUPLICATE RECORD:C225([LSS_UT:175])
		[LSS_UT:175]LSS_InspectionId_s:2:=$newInspID_txt
		C_LONGINT:C283($Key_L)
		
		Inc_Sequence("LSS_UTId_s"; ->$Key_L)
		[LSS_UT:175]LSS_UTId_s:1:=String:C10($Key_L; <>KeyMask_s)
		$newUTID_txt:=[LSS_UT:175]LSS_UTId_s:1
		
		SAVE RECORD:C53([LSS_UT:175])
		
		QUERY:C277([LSS_UtResult:176]; [LSS_UtResult:176]LSS_UTId_s:2=$oldUTID_txt)
		$totUtresults_L:=$totUtresults_L+Records in selection:C76([LSS_UtResult:176])
		ARRAY LONGINT:C221($RecordNumbers1_aL; 0)
		LONGINT ARRAY FROM SELECTION:C647([LSS_UtResult:176]; $RecordNumbers1_aL)
		For ($InnerLoop_l; 1; Size of array:C274($RecordNumbers1_aL))
			GOTO RECORD:C242([LSS_UtResult:176]; $RecordNumbers1_aL{$InnerLoop_l})
			DUPLICATE RECORD:C225([LSS_UtResult:176])
			[LSS_UtResult:176]LSS_UTId_s:2:=$newUTID_txt
			C_LONGINT:C283($Key_L)
			
			Inc_Sequence("LSS_UTResultId_s"; ->$Key_L)
			[LSS_UtResult:176]LSS_UTResultId_s:1:=String:C10($Key_L; <>KeyMask_s)
			
			SAVE RECORD:C53([LSS_UtResult:176])
			
		End for 
	End for 
	
End if 
$param_o.items.utresults:=$totUtresults_L

QUERY:C277([LSS_VerticalClearance:177]; [LSS_VerticalClearance:177]LSS_InspectionId_s:2=$oldInspID_txt)
$param_o.items.vert:=Records in selection:C76([LSS_VerticalClearance:177])
If (Records in selection:C76([LSS_VerticalClearance:177])>0)
	If ($showMessage_b)
		Progress SET MESSAGE($dupprogress_o.progress; String:C10(Records in selection:C76([LSS_VerticalClearance:177]))+" Vertical Clearances...")
		//MESSAGE(Char(13)+"Vertical Clearances...")
	End if 
	ARRAY LONGINT:C221($RecordNumbers_aL; 0)
	LONGINT ARRAY FROM SELECTION:C647([LSS_VerticalClearance:177]; $RecordNumbers_aL)
	For ($Loop_l; 1; Size of array:C274($RecordNumbers_aL))
		If ($showMessage_b)
			Progress SET MESSAGE($dupprogress_o.progress; String:C10($Loop_l; " ##### of ")+String:C10(Size of array:C274($RecordNumbers_aL))+" Vertical Clearances...")
			//MESSAGE(String($Loop_l;" #####..."))
		End if 
		GOTO RECORD:C242([LSS_VerticalClearance:177]; $RecordNumbers_aL{$Loop_l})
		DUPLICATE RECORD:C225([LSS_VerticalClearance:177])
		[LSS_VerticalClearance:177]LSS_InspectionId_s:2:=$newInspID_txt
		C_LONGINT:C283($Key_L)
		
		Inc_Sequence("LSS_VerticalClearanceId_s"; ->$Key_L)
		[LSS_VerticalClearance:177]LSS_VerticalClearanceId_s:1:=String:C10($Key_L; <>KeyMask_s)
		
		SAVE RECORD:C53([LSS_VerticalClearance:177])
		
	End for 
	
End if 

If ($showMessage_b)
	//quit progress
	Progress QUIT(OB Get:C1224($dupprogress_o; "progress"; Is longint:K8:6))
	//CLOSE WINDOW
End if 

SET AUTOMATIC RELATIONS:C310($one_b; $many_b)

//unload all records of LSS tables
C_LONGINT:C283($table_L; $numtables_L)
$numtables_L:=Get last table number:C254

For ($table_L; 1; $numtables_L)
	
	Case of 
		: (Not:C34(Is table number valid:C999($table_L)))
		: (Table name:C256($table_L)="LSS@")
			If (Is record loaded:C669(Table:C252($table_L)->))
				UNLOAD RECORD:C212(Table:C252($table_L)->)
			End if 
	End case 
	
End for 

ON ERR CALL:C155($ErrorMethodCalled_txt)

//End LSS_DuplicateInspection   