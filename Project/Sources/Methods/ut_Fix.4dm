//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 01/28/16, 11:28:53
//----------------------------------------------------
//Method: ut_Fix
//Description
//Fix duplicate [FileIDRes Table] records
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_01_bug  // 
	//Modified by: administrator (1/28/16 11:28:56)
	// Modified by: Costas Manousakis-(Designer)-(3/4/16 13:05:14)
	Mods_2016_03_bug
	//  `
	// Modified by: Costas Manousakis-(Designer)-(3/30/16 12:06:42)
	Mods_2016_03_bug
	//  `remove alert at end
End if 
compiler_clone
COMPILER_forSQL
//146.243.135.139:29902
Compiler_FieldVariables(27)  //[Inspections]
Compiler_FieldVariables(29)  //[ElementsSafety]
Compiler_FieldVariables(36)  //[Standard Photos]
Compiler_FieldVariables(44)  //[BMS Inspections]
Compiler_FieldVariables(45)  //[Cond Units]
Compiler_FieldVariables(90)  //[Combined Inspections]
Compiler_FieldVariables(152)  //[TunnelInspection]
Compiler_FieldVariables(179)  //[PON_ELEM_INSP]
clone_ClearFieldVariables(27)  //[Inspections]
clone_ClearFieldVariables(29)  //[ElementsSafety]
clone_ClearFieldVariables(36)  //[Standard Photos]
clone_ClearFieldVariables(44)  //[BMS Inspections]
clone_ClearFieldVariables(45)  //[Cond Units]
clone_ClearFieldVariables(90)  //[Combined Inspections]
clone_ClearFieldVariables(152)  //[TunnelInspection]
clone_ClearFieldVariables(179)  //[PON_ELEM_INSP]
CREATE EMPTY SET:C140([FileIDRes Table:60]; "DeleteSet")
CREATE EMPTY SET:C140([FileIDRes Table:60]; "QuerySet")


ARRAY TEXT:C222($Files_atxt; 0)
C_BOOLEAN:C305($DoSelect_B)
C_BLOB:C604($REPORT_BLB)
SET BLOB SIZE:C606($REPORT_BLB; 0)

C_TEXT:C284($Path_txt)
C_LONGINT:C283($OFFSET_L)
// CONFIRM("Select from remote or from stored Blob";"Remote";"Blob")
$DoSelect_B:=True:C214
//If (OK=1)
//$DoSelect_B:=True
//Else 
//$Path_txt:=Select document("";"";"Select Server Blob document";Multiple files ;$Files_atxt)
//DOCUMENT TO BLOB($Files_atxt{1};$REPORT_BLB)
//
//$OFFSET_L:=0
//
//BLOB TO VARIABLE($REPORT_BLB;v_27_002_aL;$OFFSET_L)
//BLOB TO VARIABLE($REPORT_BLB;v_27_001_atxt;$OFFSET_L)
//
//BLOB TO VARIABLE($REPORT_BLB;v_29_004_aL;$OFFSET_L)
//BLOB TO VARIABLE($REPORT_BLB;v_29_007_aL;$OFFSET_L)
//
//BLOB TO VARIABLE($REPORT_BLB;v_36_001_aL;$OFFSET_L)
//BLOB TO VARIABLE($REPORT_BLB;v_36_007_aL;$OFFSET_L)
//
//BLOB TO VARIABLE($REPORT_BLB;v_44_001_aL;$OFFSET_L)
//BLOB TO VARIABLE($REPORT_BLB;v_44_002_atxt;$OFFSET_L)
//
//BLOB TO VARIABLE($REPORT_BLB;v_45_001_aL;$OFFSET_L)
//BLOB TO VARIABLE($REPORT_BLB;v_45_002_aL;$OFFSET_L)
//
//BLOB TO VARIABLE($REPORT_BLB;v_90_001_atxt;$OFFSET_L)
//BLOB TO VARIABLE($REPORT_BLB;v_90_006_aL;$OFFSET_L)
//
//BLOB TO VARIABLE($REPORT_BLB;v_152_001_aL;$OFFSET_L)
//BLOB TO VARIABLE($REPORT_BLB;v_152_015_aL;$OFFSET_L)
//
//BLOB TO VARIABLE($REPORT_BLB;v_179_021_aL;$OFFSET_L)
//BLOB TO VARIABLE($REPORT_BLB;v_179_022_aL;$OFFSET_L)
//
//$DoSelect_B:=False
//
//End if 

If (Not:C34($DoSelect_B))
Else 
	C_TEXT:C284($IPAddress_txt; TRANSF_DestIP_txt)
	If (TRANSF_DestIP_txt#"")
		
		$IPAddress_txt:=TRANSF_DestIP_txt
	Else 
		$IPAddress_txt:=<>DestIP
		CONFIRM:C162("Use IP address "+<>DestIP)
		If (OK=0)
			$IPAddress_txt:=SQL_TestConnection
		End if 
	End if 
	ut_SQLConnect("Designer"; "caesar"; $IPAddress_txt)
	
	Begin SQL
		select
		[Inspections].[InspID], 
		[Inspections].[BIN]
		from
		[Inspections]
		into
		:v_27_002_aL, 
		:v_27_001_atxt;
		
		select
		[ElementsSafety].[InspID], 
		[ElementsSafety].[ElmSafetyID] 
		from
		[ElementsSafety]
		into
		:v_29_004_aL,
		:v_29_007_aL;
		
		select
		[Standard Photos].[InspID],
		[Standard Photos].[StdPhotoID]
		from [Standard Photos]
		into
		:v_36_001_aL,
		:v_36_007_aL;
		
		select
		[BMS Inspections].[Inspection ID], 
		[BMS Inspections].[BIN]
		from
		[BMS Inspections]
		into
		:v_44_001_aL,
		:v_44_002_atxt;
		
		select 
		[Cond Units].[Cond Unit ID],  
		[Cond Units].[Inspection ID] 
		from
		[Cond Units]
		into
		:v_45_001_aL, 
		:v_45_002_aL;
		
		select
		[Combined Inspections].[BIN], 
		[Combined Inspections].[ID] 
		from
		[Combined Inspections]
		into
		:v_90_001_atxt,
		:v_90_006_aL;
		
		select
		[TunnelInspection].[InspID], 
		[TunnelInspection].[TunnelInspID_L]
		from
		[TunnelInspection]
		into
		:v_152_001_aL,
		:v_152_015_aL;
		
		select
		[PON_ELEM_INSP].[INSPID], 
		[PON_ELEM_INSP].[ELEMID]
		from
		[PON_ELEM_INSP]
		into
		:v_179_021_aL, 
		:v_179_022_aL;
		
	End SQL
	ut_SQLLogout
	C_TIME:C306($Doc_tm)
	//ALERT("Saving Data from server in a Blob")
	//$Doc_tm:=Create document("")
	//SET BLOB SIZE($REPORT_BLB;0)
	//
	//  `DOCUMENT TO BLOB($Files_atxt{1};$REPORT_BLB)
	//VARIABLE TO BLOB(v_27_002_aL;$REPORT_BLB;*)
	//VARIABLE TO BLOB(v_27_001_atxt;$REPORT_BLB;*)
	//VARIABLE TO BLOB(v_29_004_aL;$REPORT_BLB;*)
	//VARIABLE TO BLOB(v_29_007_aL;$REPORT_BLB;*)
	//VARIABLE TO BLOB(v_36_001_aL;$REPORT_BLB;*)
	//VARIABLE TO BLOB(v_36_007_aL;$REPORT_BLB;*)
	//VARIABLE TO BLOB(v_44_001_aL;$REPORT_BLB;*)
	//VARIABLE TO BLOB(v_44_002_atxt;$REPORT_BLB;*)
	//VARIABLE TO BLOB(v_45_001_aL;$REPORT_BLB;*)
	//VARIABLE TO BLOB(v_45_002_aL;$REPORT_BLB;*)
	//VARIABLE TO BLOB(v_90_001_atxt;$REPORT_BLB;*)
	//VARIABLE TO BLOB(v_90_006_aL;$REPORT_BLB;*)
	//VARIABLE TO BLOB(v_152_001_aL;$REPORT_BLB;*)
	//VARIABLE TO BLOB(v_152_015_aL;$REPORT_BLB;*)
	//VARIABLE TO BLOB(v_179_021_aL;$REPORT_BLB;*)
	//VARIABLE TO BLOB(v_179_022_aL;$REPORT_BLB;*)
	//CLOSE DOCUMENT($Doc_tm)
	//BLOB TO DOCUMENT(Document;$REPORT_BLB)
	
End if 
C_TEXT:C284($Deletions_txt; $Reason_txt)
ARRAY TEXT:C222($Deletions_atxt; 0)
$Deletions_txt:=$Deletions_txt+"Destination"+Char:C90(Tab:K15:37)
$Deletions_txt:=$Deletions_txt+"Destination ID"+Char:C90(Tab:K15:37)
$Deletions_txt:=$Deletions_txt+"File Number"+Char:C90(Tab:K15:37)
$Deletions_txt:=$Deletions_txt+"Local ID"+Char:C90(Tab:K15:37)
$Deletions_txt:=$Deletions_txt+"Reason"+Char:C90(Carriage return:K15:38)
$Deletions_txt:=$Deletions_txt+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)
$Deletions_txt:=$Deletions_txt+"Local or Remote ID"+Char:C90(Tab:K15:37)

$Deletions_txt:=$Deletions_txt+"RefID"+Char:C90(Tab:K15:37)
$Deletions_txt:=$Deletions_txt+"Activity Type"+Char:C90(Tab:K15:37)
$Deletions_txt:=$Deletions_txt+"Source"+Char:C90(Tab:K15:37)
$Deletions_txt:=$Deletions_txt+"Destination ID Local"+Char:C90(Carriage return:K15:38)

C_LONGINT:C283($Loop_l; $InspectionPos_L; $LocalID_L; $RemoteID_L; $Pos1_L; $inServerParTablefromServer_L)
C_BOOLEAN:C305($DeleteRecord_B)
ARRAY LONGINT:C221($LocalIDs_aL; 0)
ARRAY LONGINT:C221($RemoteIDs_aL; 0)
ARRAY LONGINT:C221($BMSLocalIDs_aL; 0)
ARRAY LONGINT:C221($BMSRemoteIDs_aL; 0)

Begin SQL
	select
	cast ([FileIDRes Table].[Destination ID] as INT),  
	cast ([FileIDRes Table].[Local ID] as INT)
	from
	[FileIDRes Table]
	where
	[FileIDRes Table].[Destination] = 'here'
	and
	[FileIDRes Table].[File Number] = 27
	into
	:$LocalIDs_aL, 
	:$RemoteIDs_aL;
	
	select
	cast ([FileIDRes Table].[Destination ID] as INT),  
	cast ([FileIDRes Table].[Local ID] as INT)
	from
	[FileIDRes Table]
	where
	[FileIDRes Table].[Destination] = 'here'
	and
	[FileIDRes Table].[File Number] = 44
	into
	:$BMSLocalIDs_aL, 
	:$BMSRemoteIDs_aL;
	
End SQL
QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]Destination:4="here")
//ORDER BY([FileIDRes Table];[FileIDRes Table]File Number;>)



ARRAY TEXT:C222(LocalIDs_atxt; 0)
ARRAY TEXT:C222(RemoteIDs_atxt; 0)
ARRAY TEXT:C222(Reasons_atxt; 0)

C_LONGINT:C283($LocalChildInspID_L; $LocalParInspID_L; $DestInspID_L)
C_TEXT:C284($LocalParBIN_txt)
C_LONGINT:C283($ServerChildInspID_L; $ServerParInspID_L)
C_TEXT:C284($ServerParBIN_txt)
$ServerChildInspID_L:=-1
$DestInspID_L:=-1
$LocalParBIN_txt:=""
$ServerParBIN_txt:=""
C_LONGINT:C283($ErrorCount_L; $DRCCount_L; $FileNumber_L; $Pos_L; $inServerParTable_L)
$ErrorCount_L:=0
C_BOOLEAN:C305($Ignore_B; $NoLocal_B)
ARRAY LONGINT:C221($RecordNumbers_aL; 0)
LONGINT ARRAY FROM SELECTION:C647([FileIDRes Table:60]; $RecordNumbers_aL)
//start the bar
C_LONGINT:C283(<>ProgressPID)
<>ProgressPID:=StartProgress("FileIDRes Scan"; "NONE"; "Scanning "+String:C10(Records in selection:C76([FileIDRes Table:60]); "###,###,###,###")+" records"; "Records left ")
//initialize the bar
UpdateProgress(0; Size of array:C274($RecordNumbers_aL))

For ($Loop_l; 1; Size of array:C274($RecordNumbers_aL))
	If (($Loop_l%20)=0)
		UpdateProgress($Loop_l; Size of array:C274($RecordNumbers_aL))
	End if 
	$DeleteRecord_B:=True:C214
	$Ignore_B:=False:C215
	$Reason_txt:=""
	$NoLocal_B:=False:C215
	GOTO RECORD:C242([FileIDRes Table:60]; $RecordNumbers_aL{$Loop_l})
	
	$FileNumber_L:=[FileIDRes Table:60]File Number:1
	
	Case of 
		: ([FileIDRes Table:60]Destination:4="here")
			$LocalID_L:=Num:C11([FileIDRes Table:60]Destination ID:3)
			$RemoteID_L:=Num:C11([FileIDRes Table:60]Local ID:2)
		Else 
			$RemoteID_L:=Num:C11([FileIDRes Table:60]Destination ID:3)
			$LocalID_L:=Num:C11([FileIDRes Table:60]Local ID:2)
	End case 
	
	
	
	Case of 
		: ([FileIDRes Table:60]File Number:1=27)  //[Inspections]
			$InspectionPos_L:=Find in array:C230(v_27_002_aL; $RemoteID_L)
			QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=$LocalID_L)
			$Ignore_B:=(Records in selection:C76([Inspections:27])=0) & ($InspectionPos_L<1)
			$NoLocal_B:=(Records in selection:C76([Inspections:27])=0) & ($InspectionPos_L>0)
			
			Case of 
				: ($NoLocal_B)
					$Reason_txt:="Local ID not found $LocalID_L--> "+String:C10($LocalID_L)+" $RemoteID_L --> "+String:C10($RemoteID_L)+" to be deleted"
					//If (Records in selection([Activity Log])=0)&($NoLocal_B)
					//ut_DeleteFileIDRes ($LocalID_L;$RemoteID_L;$FileNumber_L)
					//End if 
				: ($Ignore_B)
					$DeleteRecord_B:=False:C215
				: ($InspectionPos_L<1)
					$Reason_txt:="Remote ID not found --> $RemoteID_L "+String:C10($RemoteID_L)
				: (Records in selection:C76([Inspections:27])<1)
					$Reason_txt:="Local ID not found $LocalID_L --> "+String:C10($LocalID_L)
				: (v_27_001_atxt{$InspectionPos_L}#[Inspections:27]BIN:1)
					$Reason_txt:="Mismatch BIN Remote --> "+v_27_001_atxt{$InspectionPos_L}+" Local --> "+[Inspections:27]BIN:1
				Else 
					$DeleteRecord_B:=False:C215
			End case 
		: ([FileIDRes Table:60]File Number:1=29)  // [ElementsSafety]
			
			QUERY:C277([ElementsSafety:29]; [ElementsSafety:29]ElmSafetyID:7=$LocalID_L)
			QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[ElementsSafety:29]InspID:4)
			$Reason_txt:=""
			
			$LocalParInspID_L:=[ElementsSafety:29]InspID:4
			$LocalParBIN_txt:=[Inspections:27]BIN:1
			$Pos_L:=Find in array:C230($LocalIDs_aL; [ElementsSafety:29]InspID:4)
			
			If ($Pos_L>0)
				$DestInspID_L:=$RemoteIDs_aL{$Pos_L}
			Else 
				$DestInspID_L:=[ElementsSafety:29]InspID:4
			End if 
			
			$Pos1_L:=Find in array:C230(v_29_007_aL; $RemoteID_L)  //pos in server child table
			$Ignore_B:=(Records in selection:C76([ElementsSafety:29])=0) & ($Pos1_L<1)
			
			If ($Pos1_L>0)
				$ServerChildInspID_L:=v_29_004_aL{$Pos1_L}
			End if 
			$inServerParTable_L:=Find in array:C230(v_27_002_aL; $DestInspID_L)
			
			If ($inServerParTable_L>0)
				$ServerParBIN_txt:=v_27_001_atxt{$inServerParTable_L}
			End if 
			$NoLocal_B:=(Records in selection:C76([ElementsSafety:29])=0) & ($Pos1_L>0)
			
			Case of 
				: ($NoLocal_B)
					$Reason_txt:="Local ID not found $LocalID_L--> "+String:C10($LocalID_L)+" $RemoteID_L --> "+String:C10($RemoteID_L)+" to be deleted"
					
				: ($Ignore_B)
					$DeleteRecord_B:=False:C215
				: ($Pos1_L<=0)
					$Reason_txt:="Remote ID not found $RemoteID_L --> "+String:C10($RemoteID_L)  //remote child rec not found
				: ($ServerChildInspID_L#$DestInspID_L)
					$Reason_txt:="Inspection ID Mismatch $ServerChildInspID_L --> "+String:C10($ServerChildInspID_L)+" $DestInspID_L --> "+String:C10($DestInspID_L)  //remote  parent of child mismatch"
				: (Records in selection:C76([Inspections:27])=0)
					$Reason_txt:="No Local inspection record -->"+String:C10([ElementsSafety:29]InspID:4)  //orphan local element
				: ($inServerParTable_L<=0)
					$Reason_txt:="Remote Inspection not found -->"+String:C10($DestInspID_L)  //remote parent rec not found
				: ($ServerParBIN_txt#$LocalParBIN_txt)
					$Reason_txt:="Mismatch BIN $ServerParBIN_txt --> "+$ServerParBIN_txt+"$LocalParBIN_txt --> "+$LocalParBIN_txt  //BIN mismatch"
				Else 
					$DeleteRecord_B:=False:C215
					
			End case 
			
		: ([FileIDRes Table:60]File Number:1=36)  //[Standard Photos]
			//select
			//[Standard Photos].[InspID],
			//[Standard Photos].[StdPhotoID]
			//from [Standard Photos]
			//into
			//:v_36_001_aL,
			//:v_36_007_aL;
			
			QUERY:C277([Standard Photos:36]; [Standard Photos:36]StdPhotoID:7=$LocalID_L)
			QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[Standard Photos:36]InspID:1)
			$Reason_txt:=""
			
			$LocalParInspID_L:=[Standard Photos:36]InspID:1
			$LocalParBIN_txt:=[Inspections:27]BIN:1
			$Pos_L:=Find in array:C230($LocalIDs_aL; [Standard Photos:36]InspID:1)
			
			If ($Pos_L>0)
				$DestInspID_L:=$RemoteIDs_aL{$Pos_L}
			Else 
				$DestInspID_L:=[Standard Photos:36]InspID:1
			End if 
			
			$Pos1_L:=Find in array:C230(v_36_007_aL; $RemoteID_L)  //pos in server child table
			
			If ($Pos1_L>0)
				$ServerChildInspID_L:=v_36_001_aL{$Pos1_L}
			End if 
			If ($DestInspID_L=0)
				If ($ServerChildInspID_L>0)
					$inServerParTable_L:=Find in array:C230(v_27_002_aL; $ServerChildInspID_L)
				End if 
			Else 
				$inServerParTable_L:=Find in array:C230(v_27_002_aL; $DestInspID_L)  //parent on server
			End if 
			
			If ($inServerParTable_L>0)
				$ServerParBIN_txt:=v_27_001_atxt{$inServerParTable_L}
			End if 
			$Ignore_B:=(Records in selection:C76([Standard Photos:36])=0) & ($Pos1_L<1)
			$NoLocal_B:=(Records in selection:C76([Standard Photos:36])=0) & ($Pos1_L>0)
			
			
			Case of 
				: ($NoLocal_B)
					$Reason_txt:="Local ID not found $LocalID_L--> "+String:C10($LocalID_L)+" $RemoteID_L --> "+String:C10($RemoteID_L)+" to be deleted"
					
				: ($Ignore_B)
					$DeleteRecord_B:=False:C215
				: ($Pos1_L<=0)
					$Reason_txt:="Remote ID not found $RemoteID_L --> "+String:C10($RemoteID_L)  //remote child rec not found
				: ($ServerChildInspID_L#$DestInspID_L)
					$Reason_txt:="Inspection ID Mismatch $ServerChildInspID_L --> "+String:C10($ServerChildInspID_L)+" $DestInspID_L --> "+String:C10($DestInspID_L)  //remote  parent of child mismatch"
				: (Records in selection:C76([Inspections:27])=0)
					$Reason_txt:="No Local inspection record -->"+String:C10([Standard Photos:36]InspID:1)  //orphan local element
				: ($inServerParTable_L<=0)
					$Reason_txt:="Remote Inspection not found -->"+String:C10($DestInspID_L)  //remote parent rec not found
				: ($ServerParBIN_txt#$LocalParBIN_txt)
					$Reason_txt:="Mismatch BIN $ServerParBIN_txt --> "+$ServerParBIN_txt+"$LocalParBIN_txt --> "+$LocalParBIN_txt  //BIN mismatch"
				Else 
					$DeleteRecord_B:=False:C215
					
			End case 
			
		: ([FileIDRes Table:60]File Number:1=44)  //[BMS Inspections]
			//select
			//[BMS Inspections].[Inspection ID],
			//[BMS Inspections].[BIN]
			//from
			//[BMS Inspections]
			//into
			//:v_44_001_aL,
			//:v_44_002_atxt;
			
			QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=$LocalID_L)  //same as inspections
			$InspectionPos_L:=Find in array:C230(v_44_001_aL; $RemoteID_L)
			$Ignore_B:=(Records in selection:C76([BMS Inspections:44])=0) & ($InspectionPos_L<1)
			$NoLocal_B:=(Records in selection:C76([BMS Inspections:44])=0) & ($InspectionPos_L>0)
			
			Case of 
				: ($NoLocal_B)
					$Reason_txt:="Local ID not found $LocalID_L--> "+String:C10($LocalID_L)+" $RemoteID_L --> "+String:C10($RemoteID_L)+" to be deleted"
					//If (Records in selection([Activity Log])=0)
					//ut_DeleteFileIDRes ($LocalID_L;$RemoteID_L;$FileNumber_L)
					//End if 
				: ($Ignore_B)
					$DeleteRecord_B:=False:C215
				: ($InspectionPos_L<1)
					$Reason_txt:="Remote ID not found $RemoteID_L --> "+String:C10($RemoteID_L)
				: (Records in selection:C76([BMS Inspections:44])<1)
					$Reason_txt:="Local ID not found $LocalID_L --> "+String:C10($LocalID_L)
				: (v_44_002_atxt{$InspectionPos_L}#[BMS Inspections:44]BIN:2)
					$Reason_txt:="Mismatch BIN Remote --> "+v_44_002_atxt{$InspectionPos_L}+" Local --> "+[BMS Inspections:44]BIN:2
				Else 
					$DeleteRecord_B:=False:C215
			End case 
		: ([FileIDRes Table:60]File Number:1=45)  //[Cond Units]
			//select
			//[Cond Units].[Cond Unit ID],
			//[Cond Units].[Inspection ID],
			//[Cond Units].[Element ID]
			//from
			//[Cond Units]
			//into
			//:v_45_001_aL,
			//:v_45_002_aL,
			//:v_45_003_aL;
			//select
			//[BMS Inspections].[Inspection ID],
			//[BMS Inspections].[BIN]
			//from
			//[BMS Inspections]
			//into
			//:v_44_001_aL,
			//:v_44_002_atxt;
			
			
			QUERY:C277([Cond Units:45]; [Cond Units:45]Cond Unit ID:1=$LocalID_L)
			QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Cond Units:45]Inspection ID:2)
			$Reason_txt:=""
			$LocalParInspID_L:=[Cond Units:45]Inspection ID:2
			$LocalParBIN_txt:=[BMS Inspections:44]BIN:2
			$Pos_L:=Find in array:C230($BMSLocalIDs_aL; [Cond Units:45]Inspection ID:2)
			
			If ($Pos_L>0)
				$DestInspID_L:=$BMSRemoteIDs_aL{$Pos_L}
			Else 
				$DestInspID_L:=[Cond Units:45]Inspection ID:2
			End if 
			
			$Pos1_L:=Find in array:C230(v_45_001_aL; $RemoteID_L)  //pos in server child table
			
			If ($Pos1_L>0)
				$ServerChildInspID_L:=v_45_002_aL{$Pos1_L}
			End if 
			$inServerParTable_L:=Find in array:C230(v_44_001_aL; $DestInspID_L)
			
			If ($inServerParTable_L>0)
				$ServerParBIN_txt:=v_44_002_atxt{$inServerParTable_L}
			End if 
			
			$Ignore_B:=(Records in selection:C76([Cond Units:45])=0) & ($Pos1_L<1)
			$NoLocal_B:=(Records in selection:C76([Cond Units:45])=0) & ($Pos1_L>0)
			
			Case of 
				: ($NoLocal_B)
					$Reason_txt:="Local ID not found $LocalID_L--> "+String:C10($LocalID_L)+" $RemoteID_L --> "+String:C10($RemoteID_L)+" to be deleted"
					//If (Records in selection([Activity Log])=0)
					//ut_DeleteFileIDRes ($LocalID_L;$RemoteID_L;$FileNumber_L)
					//End if 
				: ($Ignore_B)
					$DeleteRecord_B:=False:C215
				: ($Pos1_L<=0)
					$Reason_txt:="Remote ID not found $RemoteID_L --> "+String:C10($RemoteID_L)  //remote child rec not found
				: ($ServerChildInspID_L#$DestInspID_L)
					$Reason_txt:="Inspection ID Mismatch $ServerChildInspID_L --> "+String:C10($ServerChildInspID_L)+" $DestInspID_L --> "+String:C10($DestInspID_L)  //remote  parent of child mismatch"
				: (Records in selection:C76([BMS Inspections:44])=0)
					$Reason_txt:="No Local inspection record -->"+String:C10([Cond Units:45]Inspection ID:2)  //orphan local element
				: ($inServerParTable_L<=0)
					$Reason_txt:="Remote Inspection not found -->"+String:C10($DestInspID_L)  //remote parent rec not found
				: ($ServerParBIN_txt#$LocalParBIN_txt)
					$Reason_txt:="Mismatch BIN $ServerParBIN_txt --> "+$ServerParBIN_txt+"$LocalParBIN_txt --> "+$LocalParBIN_txt  //BIN mismatch"
				Else 
					$DeleteRecord_B:=False:C215
					
			End case 
			
			
		: ([FileIDRes Table:60]File Number:1=90)  //[Combined Inspections]`same as inspections
			//select
			//[Combined Inspections].[BIN],
			//[Combined Inspections].[ID]
			//from
			//[Combined Inspections]
			//into
			//:v_90_001_atxt,
			//:v_90_006_aL;
			
			
			QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]ID:6=$LocalID_L)
			$InspectionPos_L:=Find in array:C230(v_90_006_aL; $RemoteID_L)
			$Ignore_B:=(Records in selection:C76([Combined Inspections:90])=0) & ($InspectionPos_L<1)
			$NoLocal_B:=(Records in selection:C76([Combined Inspections:90])=0) & ($InspectionPos_L>0)
			
			//If (Not($Ignore_B))
			//$DRCCount_L:=ut_FixGetActivityLogRecords ($LocalID_L)
			//End if 
			Case of 
				: ($NoLocal_B)
					$Reason_txt:="Local ID not found $LocalID_L--> "+String:C10($LocalID_L)+" $RemoteID_L --> "+String:C10($RemoteID_L)+" to be deleted"
					//If (Records in selection([Activity Log])=0)
					//ut_DeleteFileIDRes ($LocalID_L;$RemoteID_L;$FileNumber_L)
					//End if 
				: ($Ignore_B)
					$DeleteRecord_B:=False:C215
				: ($InspectionPos_L<1)
					$Reason_txt:="Remote ID not found $RemoteID_L --> "+String:C10($RemoteID_L)
				: (Records in selection:C76([Combined Inspections:90])<1)
					$Reason_txt:="Local ID not found $LocalID_L --> "+String:C10($LocalID_L)
				: (v_90_001_atxt{$InspectionPos_L}#[Combined Inspections:90]BIN:1)
					$Reason_txt:="Mismatch BIN Remote --> "+v_27_001_atxt{$InspectionPos_L}+" Local --> "+[Combined Inspections:90]BIN:1
				Else 
					$DeleteRecord_B:=False:C215
			End case 
		: ([FileIDRes Table:60]File Number:1=152)  //[TunnelInspection]
			//select
			//[TunnelInspection].[InspID],
			//[TunnelInspection].[TunnelInspID_L]
			//from
			//[TunnelInspection]
			//into
			//:v_152_001_aL,
			//:v_152_015_aL;
			QUERY:C277([TunnelInspection:152]; [TunnelInspection:152]TunnelInspID_L:15=$LocalID_L)
			QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[TunnelInspection:152]InspID:1)
			$Reason_txt:=""
			
			$LocalParInspID_L:=[TunnelInspection:152]InspID:1
			$LocalParBIN_txt:=[Inspections:27]BIN:1
			$Pos_L:=Find in array:C230($LocalIDs_aL; [TunnelInspection:152]InspID:1)
			
			If ($Pos_L>0)
				$DestInspID_L:=$RemoteIDs_aL{$Pos_L}
			Else 
				$DestInspID_L:=[TunnelInspection:152]InspID:1
			End if 
			
			$Pos1_L:=Find in array:C230(v_152_015_aL; $RemoteID_L)  //pos in server child table
			
			If ($Pos1_L>0)
				$ServerChildInspID_L:=v_152_001_aL{$Pos1_L}
			End if 
			$inServerParTable_L:=Find in array:C230(v_27_002_aL; $DestInspID_L)
			
			If ($inServerParTable_L>0)
				$ServerParBIN_txt:=v_27_001_atxt{$inServerParTable_L}
			End if 
			
			$Ignore_B:=(Records in selection:C76([TunnelInspection:152])=0) & ($Pos1_L<1)
			$NoLocal_B:=(Records in selection:C76([TunnelInspection:152])=0) & ($Pos1_L>0)
			
			Case of 
				: ($NoLocal_B)
					$Reason_txt:="Local ID not found $LocalID_L--> "+String:C10($LocalID_L)+" $RemoteID_L --> "+String:C10($RemoteID_L)+" to be deleted"
					//If (Records in selection([Activity Log])=0)
					//ut_DeleteFileIDRes ($LocalID_L;$RemoteID_L;$FileNumber_L)
					//End if 
				: ($Ignore_B)
					$DeleteRecord_B:=False:C215
				: ($Pos1_L<=0)
					$Reason_txt:="Remote ID not found $RemoteID_L --> "+String:C10($RemoteID_L)  //remote child rec not found
				: ($ServerChildInspID_L#$DestInspID_L)
					$Reason_txt:="Inspection ID Mismatch $ServerChildInspID_L --> "+String:C10($ServerChildInspID_L)+" $DestInspID_L --> "+String:C10($DestInspID_L)  //remote  parent of child mismatch"
				: (Records in selection:C76([Inspections:27])=0)
					$Reason_txt:="No Local inspection record -->"+String:C10([TunnelInspection:152]InspID:1)  //orphan local element
				: ($inServerParTable_L<=0)
					$Reason_txt:="Remote Inspection not found -->"+String:C10($DestInspID_L)  //remote parent rec not found
				: ($ServerParBIN_txt#$LocalParBIN_txt)
					$Reason_txt:="Mismatch BIN $ServerParBIN_txt --> "+$ServerParBIN_txt+"$LocalParBIN_txt --> "+$LocalParBIN_txt  //BIN mismatch"
				Else 
					$DeleteRecord_B:=False:C215
					
			End case 
			
		: ([FileIDRes Table:60]File Number:1=179)  //[PON_ELEM_INSP]
			//select
			//[PON_ELEM_INSP].[INSPID],
			//[PON_ELEM_INSP].[ELEMID]
			//from
			//[PON_ELEM_INSP]
			//into
			//:v_179_021_aL,
			//:v_179_022_aL;
			QUERY:C277([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEMID:22=$LocalID_L)
			QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[PON_ELEM_INSP:179]INSPID:21)
			$Reason_txt:=""
			
			$LocalParInspID_L:=[PON_ELEM_INSP:179]INSPID:21
			$LocalParBIN_txt:=[Inspections:27]BIN:1
			$Pos_L:=Find in array:C230($LocalIDs_aL; [PON_ELEM_INSP:179]INSPID:21)
			
			If ($Pos_L>0)
				$DestInspID_L:=$RemoteIDs_aL{$Pos_L}
			Else 
				$DestInspID_L:=[PON_ELEM_INSP:179]INSPID:21
			End if 
			
			$Pos1_L:=Find in array:C230(v_179_022_aL; $RemoteID_L)  //pos in server child table
			
			If ($Pos1_L>0)
				$ServerChildInspID_L:=v_179_021_aL{$Pos1_L}
			End if 
			$inServerParTable_L:=Find in array:C230(v_27_002_aL; $DestInspID_L)
			
			If ($inServerParTable_L>0)
				$ServerParBIN_txt:=v_27_001_atxt{$inServerParTable_L}
			End if 
			$Ignore_B:=(Records in selection:C76([PON_ELEM_INSP:179])=0) & ($Pos1_L<1)
			$NoLocal_B:=(Records in selection:C76([PON_ELEM_INSP:179])=0) & ($Pos1_L>0)
			
			
			Case of 
				: ($NoLocal_B)
					$Reason_txt:="Local ID not found $LocalID_L--> "+String:C10($LocalID_L)+" $RemoteID_L --> "+String:C10($RemoteID_L)+" to be deleted"
					
				: ($Ignore_B)
					$DeleteRecord_B:=False:C215
				: ($Pos1_L<=0)
					$Reason_txt:="Remote ID not found $RemoteID_L --> "+String:C10($RemoteID_L)  //remote child rec not found
				: ($ServerChildInspID_L#$DestInspID_L)
					$Reason_txt:="Inspection ID Mismatch $ServerChildInspID_L --> "+String:C10($ServerChildInspID_L)+" $DestInspID_L --> "+String:C10($DestInspID_L)  //remote  parent of child mismatch"
				: (Records in selection:C76([Inspections:27])=0)
					$Reason_txt:="No Local inspection record -->"+String:C10([PON_ELEM_INSP:179]INSPID:21)  //orphan local element
				: ($inServerParTable_L<=0)
					$Reason_txt:="Remote Inspection not found -->"+String:C10($DestInspID_L)  //remote parent rec not found
				: ($ServerParBIN_txt#$LocalParBIN_txt)
					$Reason_txt:="Mismatch BIN $ServerParBIN_txt --> "+$ServerParBIN_txt+"$LocalParBIN_txt --> "+$LocalParBIN_txt  //BIN mismatch"
				Else 
					$DeleteRecord_B:=False:C215
					
			End case 
			
		Else 
			$DeleteRecord_B:=False:C215
	End case 
	If ($DeleteRecord_B)
		
		//If (Records in selection([Activity Log])=0)&($NoLocal_B)
		//This is one of the delete terms
		
		//QUERY([FileIDRes Table];[FileIDRes Table]Destination ID=$LocalID_L;*)
		//QUERY([FileIDRes Table]; & ;[FileIDRes Table]Local ID=$RemoteID_L;*)
		//QUERY([FileIDRes Table]; & ;[FileIDRes Table]Destination="here";*)
		//QUERY([FileIDRes Table]; & ;[FileIDRes Table]File Number=$FileNumber_L)
		//
		//QUERY([FileIDRes Table];[FileIDRes Table]Destination ID=$RemoteID_L;*)
		//QUERY([FileIDRes Table]; & ;[FileIDRes Table]Local ID=$LocalID_L;*)
		//QUERY([FileIDRes Table]; & ;[FileIDRes Table]Destination#"here";*)
		//QUERY([FileIDRes Table]; & ;[FileIDRes Table]File Number=$FileNumber_L)
		//
		//
		//end if
		
		
		$ErrorCount_L:=$ErrorCount_L+1
		If (Length:C16($Deletions_txt)>25000)
			APPEND TO ARRAY:C911($Deletions_atxt; $Deletions_txt)
			$Deletions_txt:=""
		End if 
		$Deletions_txt:=$Deletions_txt+[FileIDRes Table:60]Destination:4+Char:C90(Tab:K15:37)
		$Deletions_txt:=$Deletions_txt+[FileIDRes Table:60]Destination ID:3+Char:C90(Tab:K15:37)
		$Deletions_txt:=$Deletions_txt+Table name:C256([FileIDRes Table:60]File Number:1)+Char:C90(Tab:K15:37)
		$Deletions_txt:=$Deletions_txt+[FileIDRes Table:60]Local ID:2+Char:C90(Tab:K15:37)
		APPEND TO ARRAY:C911(Reasons_atxt; $Reason_txt)
		APPEND TO ARRAY:C911(LocalIDs_atxt; String:C10($LocalID_L))
		APPEND TO ARRAY:C911(RemoteIDs_atxt; String:C10($RemoteID_L))
		APPEND TO ARRAY:C911(NoLocal_aB; $NoLocal_B)
		//COMPILER_Utilities 
		If (Not:C34($Ignore_B))
			$DRCCount_L:=ut_FixGetActivityLogRecords($LocalID_L)
		End if 
		//If (Records in selection([Activity Log])=0) & ($NoLocal_B)
		//ut_DeleteFileIDRes ($LocalID_L;$RemoteID_L;$FileNumber_L)
		//End if 
		If ($DRCCount_L>0)
			$Deletions_txt:=$Deletions_txt+$Reason_txt+Char:C90(Tab:K15:37)
			
			$Deletions_txt:=$Deletions_txt+"DRC Count "+String:C10($DRCCount_L)+Char:C90(Carriage return:K15:38)
		Else 
			$Deletions_txt:=$Deletions_txt+$Reason_txt+Char:C90(Carriage return:K15:38)
			
		End if 
		C_LONGINT:C283($InnerLoop_L)
		
		For ($InnerLoop_L; 1; Records in selection:C76([Activity Log:59]))
			GOTO SELECTED RECORD:C245([Activity Log:59]; $InnerLoop_L)
			$Deletions_txt:=$Deletions_txt+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)
			$Deletions_txt:=$Deletions_txt+"Local--> "+String:C10($LocalID_L)+Char:C90(Tab:K15:37)
			$Deletions_txt:=$Deletions_txt+String:C10([Activity Log:59]RefID:28)+Char:C90(Tab:K15:37)
			$Deletions_txt:=$Deletions_txt+[Activity Log:59]Activity Type:3+Char:C90(Tab:K15:37)
			$Deletions_txt:=$Deletions_txt+[Activity Log:59]Source:2+Char:C90(Tab:K15:37)
			$Deletions_txt:=$Deletions_txt+[Activity Log:59]Dest ID local:19+Char:C90(Carriage return:K15:38)
			
		End for 
		
		//QUERY([Activity Log];[Activity Log]Dest ID local=String($RemoteID_L))
		//QUERY SELECTION([Activity Log];[Activity Log]FileID Local=[FileIDRes Table]File Number)
		//
		//For ($InnerLoop_L;1;Records in selection([Activity Log]))
		//GOTO SELECTED RECORD([Activity Log];$InnerLoop_L)
		//$Deletions_txt:=$Deletions_txt+Char(Tab)+Char(Tab)+Char(Tab)+Char(Tab)+Char(Tab)+Char(Tab)
		//$Deletions_txt:=$Deletions_txt+"Remote--> "+String($RemoteID_L)+Char(Tab)
		//
		//$Deletions_txt:=$Deletions_txt+String([Activity Log]RefID)+Char(Tab)
		//$Deletions_txt:=$Deletions_txt+[Activity Log]Activity Type+Char(Tab)
		//$Deletions_txt:=$Deletions_txt+[Activity Log]Source+Char(Tab)
		//$Deletions_txt:=$Deletions_txt+[Activity Log]Dest ID local+Char(Carriage return)
		//
		//End for 
		
	End if 
	
End for 
POST OUTSIDE CALL:C329(<>ProgressPID)

clone_ClearFieldVariables(27)  //[Inspections]
clone_ClearFieldVariables(29)  //[ElementsSafety]
clone_ClearFieldVariables(36)  //[Standard Photos]
clone_ClearFieldVariables(44)  //[BMS Inspections]
clone_ClearFieldVariables(45)  //[Cond Units]
clone_ClearFieldVariables(90)  //[Combined Inspections]
clone_ClearFieldVariables(152)  //[TunnelInspection]
clone_ClearFieldVariables(179)  //[PON_ELEM_INSP]
If (Length:C16($Deletions_txt)>0)
	APPEND TO ARRAY:C911($Deletions_atxt; $Deletions_txt)
	$Deletions_txt:=""
End if 

//ALERT("Saving Results to text file")
$Doc_tm:=Create document:C266(MessageDefDir_txt+"ut_FixoutPut.txt")
If (OK=1)
	For ($loop_l; 1; Size of array:C274($Deletions_atxt))
		SEND PACKET:C103($Doc_tm; $Deletions_atxt{$Loop_l})
		
		
	End for 
	CLOSE DOCUMENT:C267($Doc_tm)
End if 
If (Records in set:C195("DeleteSet")>0)
	//ALERT("Now deleting "+String(Records in set("DeleteSet"))+" records in  DeleteSet")
	UNLOAD RECORD:C212([FileIDRes Table:60])
	READ WRITE:C146([FileIDRes Table:60])
	
	USE SET:C118("DeleteSet")
	//QR REPORT([FileIDRes Table];Char(1))
	//Repeat 
	//DELETE SELECTION([FileIDRes Table])
	//If (Records in set("LockedSet")>0)
	//USE SET("LockedSet")
	//End if 
	//Until (Records in set("LockedSet")=0)
	UNLOAD RECORD:C212([FileIDRes Table:60])
	READ WRITE:C146([FileIDRes Table:60])
	APPLY TO SELECTION:C70([FileIDRes Table:60]; ut_ResetFileIDResRecords)
	CLEAR SET:C117("DeleteSet")
	CLEAR SET:C117("QuerySet")
	
End if 
//ALERT("Done")
//End ut_Fix