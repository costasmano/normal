//%attributes = {"invisible":true}
//Method: PON_ut_compareNBEs
//Description
// Compare NBE elements between a local Db and the Destination db
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/20/15, 17:29:20
	// ----------------------------------------------------
	//Created : 
	Mods_2015_10_bug
	// Modified by: Costas Manousakis-(Designer)-(11/6/15 14:24:32)
	Mods_2015_11_bug
	//  `fix bug in the seraching for  $ServerInspID_L ;
	//  `add a check to find first inspID and first ElemID in FileIDRes  to avoid errors in id matching
	// Modified by: Costas Manousakis-(Designer)-(11/18/15 14:11:11)
	Mods_2015_11
	//  `Added verification  for records on server that are not in local - to account for Delete bug.
	// Modified by: Costas Manousakis-(Designer)-(12/21/15 11:45:49)
	Mods_2015_12_bug
	//  `use the current datatransfer settings as default IP and to search in FileIDRes table
	//  `make sure we found records in the FileIDRes table for the destination - otherwise abort 
End if 
//

ARRAY LONGINT:C221($Lv_179_003_aL; 0)
ARRAY LONGINT:C221($Lv_179_019_aL; 0)
ARRAY LONGINT:C221($Lv_179_004_aL; 0)
ARRAY TEXT:C222($Lv_179_020_atxt; 0)
ARRAY REAL:C219($Lv_179_007_ar; 0)
ARRAY REAL:C219($Lv_179_013_ar; 0)
ARRAY REAL:C219($Lv_179_014_ar; 0)
ARRAY REAL:C219($Lv_179_015_ar; 0)
ARRAY REAL:C219($Lv_179_016_ar; 0)
ARRAY BOOLEAN:C223($Lv_179_029_ab; 0)
ARRAY LONGINT:C221($Lv_179_005_aL; 0)
ARRAY LONGINT:C221($Lv_179_022_aL; 0)
ARRAY LONGINT:C221($Lv_179_021_aL; 0)
ARRAY TEXT:C222($Lv_60_004_atxt; 0)
ARRAY TEXT:C222($Lv_60_003_atxt; 0)
ARRAY LONGINT:C221($Lv_60_001_aL; 0)
ARRAY TEXT:C222($Lv_60_002_atxt; 0)

ARRAY TEXT:C222($LPv_60_004_atxt; 0)
ARRAY TEXT:C222($LPv_60_003_atxt; 0)
ARRAY LONGINT:C221($LPv_60_001_aL; 0)
ARRAY TEXT:C222($LPv_60_002_atxt; 0)

ARRAY TEXT:C222($Lv_27_001_atxt; 0)
ARRAY LONGINT:C221($Lv_27_002_aL; 0)

ARRAY LONGINT:C221($Sv_179_003_aL; 0)
ARRAY LONGINT:C221($Sv_179_019_aL; 0)
ARRAY LONGINT:C221($Sv_179_004_aL; 0)
ARRAY TEXT:C222($Sv_179_020_atxt; 0)
ARRAY REAL:C219($Sv_179_007_ar; 0)
ARRAY REAL:C219($Sv_179_013_ar; 0)
ARRAY REAL:C219($Sv_179_014_ar; 0)
ARRAY REAL:C219($Sv_179_015_ar; 0)
ARRAY REAL:C219($Sv_179_016_ar; 0)
ARRAY BOOLEAN:C223($Sv_179_029_ab; 0)
ARRAY LONGINT:C221($Sv_179_005_aL; 0)
ARRAY LONGINT:C221($Sv_179_022_aL; 0)
ARRAY LONGINT:C221($Sv_179_021_aL; 0)
ARRAY TEXT:C222(LBGeneric_atxt; 0)
C_TEXT:C284($ServerIP; $UserName; $Password)
C_BLOB:C604($localarrays_x)
C_TIME:C306($newdoc_t)
C_TEXT:C284($find_doc_txt)
SET BLOB SIZE:C606($localarrays_x; 0)

READ ONLY:C145(*)

CONFIRM:C162("Reload local vars or read from disk"; "Reload"; "Readfromdisk")
If (OK=1)
	Compiler_FieldVariables(Table:C252(->[PON_ELEM_INSP:179]))
	Compiler_FieldVariables(Table:C252(->[Inspections:27]))
	Compiler_FieldVariables(Table:C252(->[FileIDRes Table:60]))
	Compiler_FieldVariables(Table:C252(->[Preferences:57]))
	ARRAY TEXT:C222($vP_60_002_atxt; 0)  //Local ID
	ARRAY TEXT:C222($vP_60_003_atxt; 0)  //Destination ID
	ARRAY TEXT:C222($vP_60_004_atxt; 0)  //Destination
	ARRAY LONGINT:C221($vP_60_001_aL; 0)  //File Number
	C_BOOLEAN:C305($useLocal_b)
	CONFIRM:C162("Specify IP for Local DB or Use current local DB?"; "Use Local"; "Specify IP")
	$useLocal_b:=(OK=1)
	If ($useLocal_b)
	Else 
		$ServerIP:=Request:C163("Enter server IP"; "74.8.145.3:19812")
		$UserName:="designer"
		$Password:="caesar"
		ON ERR CALL:C155("SQL_ERROR")  //
		SQL LOGIN:C817("IP:"+$ServerIP; $UserName; $Password; *)
	End if 
	v_57_001_txt:=<>Destination
	Begin SQL
		select 
		[PON_ELEM_INSP].ELEM_KEY,
		[PON_ELEM_INSP].ELEM_GRANDPARENT_KEY,
		[PON_ELEM_INSP].ELEM_PARENT_KEY,
		[PON_ELEM_INSP].ELEM_NOTES,
		[PON_ELEM_INSP].ELEM_QUANTITY,
		[PON_ELEM_INSP].ELEM_QTYSTATE1,
		[PON_ELEM_INSP].ELEM_QTYSTATE2,
		[PON_ELEM_INSP].ELEM_QTYSTATE3,
		[PON_ELEM_INSP].ELEM_QTYSTATE4,
		[PON_ELEM_INSP].ELEM_QorP,
		[PON_ELEM_INSP].ENVKEY,
		[PON_ELEM_INSP].ELEMID,
		[PON_ELEM_INSP].INSPID
		from [PON_ELEM_INSP]
		into 
		:v_179_003_aL ,
		:v_179_019_aL,
		:v_179_004_aL,
		:v_179_020_atxt,
		:v_179_007_ar,
		:v_179_013_ar,
		:v_179_014_ar,
		:v_179_015_ar,
		:v_179_016_ar,
		:v_179_029_ab,
		:v_179_005_aL,
		:v_179_022_aL,
		:v_179_021_aL  ;
		
		select 
		[FileIDRes Table].[Destination],
		[FileIDRes Table].[Destination ID],
		[FileIDRes Table].[File Number],
		[FileIDRes Table].[Local ID]
		from [FileIDRes Table]
		where
		[FileIDRes Table].[File Number] = 179
		and
		[FileIDRes Table].[Destination] = :v_57_001_txt
		into 
		:v_60_004_atxt ,
		:v_60_003_atxt,
		:v_60_001_aL,
		:v_60_002_atxt ;
		
		select 
		[FileIDRes Table].[Destination],
		[FileIDRes Table].[Destination ID],
		[FileIDRes Table].[File Number],
		[FileIDRes Table].[Local ID]
		from [FileIDRes Table]
		where
		[FileIDRes Table].[File Number] = 27
		and
		[FileIDRes Table].[Destination] = :v_57_001_txt
		into 
		:$vP_60_004_atxt ,
		:$vP_60_003_atxt,
		:$vP_60_001_aL,
		:$vP_60_002_atxt ;
		
		select
		[Inspections].[BIN],
		[Inspections].[InspID]
		from [inspections]
		into 
		:v_27_001_atxt,
		:v_27_002_aL ;
	End SQL
	//[PON_ELEM_INSP]
	//[PON_ELEM_INSP]ELEM_KEY
	//[PON_ELEM_INSP]ELEM_GRANDPARENT_KEY
	//[PON_ELEM_INSP]ELEM_PARENT_KEY
	//[PON_ELEM_INSP]ELEM_NOTES
	//[PON_ELEM_INSP]ELEM_QUANTITY
	//[PON_ELEM_INSP]ELEM_QTYSTATE1
	//[PON_ELEM_INSP]ELEM_QTYSTATE2
	//[PON_ELEM_INSP]ELEM_QTYSTATE3
	//[PON_ELEM_INSP]ELEM_QTYSTATE4
	//[PON_ELEM_INSP]ELEM_QorP
	//[PON_ELEM_INSP]ENVKEY
	//[PON_ELEM_INSP]ELEMID
	//[PON_ELEM_INSP]INSPID
	
	//While (Not(SQL End selection))
	//  `SQL LOAD RECORD(1)
	//SQL LOAD RECORD(SQL All Records )
	//End while 
	//SQL CANCEL LOAD
	
	//[FileIDRes Table]
	//[FileIDRes Table]Destination
	//[FileIDRes Table]File Number
	//[FileIDRes Table]Local ID
	//[FileIDRes Table]Destination ID
	
	//[inspections]
	//[Inspections]InspID
	//[Inspections]BIN
	
	If ($useLocal_b)
	Else 
		SQL LOGOUT:C872
	End if 
	
	ON ERR CALL:C155("")
	
	//save arrays locally in a document
	
	VARIABLE TO BLOB:C532(v_179_003_aL; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_019_aL; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_004_aL; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_020_atxt; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_007_ar; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_013_ar; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_014_ar; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_015_ar; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_016_ar; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_029_ab; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_005_aL; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_022_aL; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_021_aL; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_60_004_atxt; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_60_003_atxt; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_60_001_aL; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_60_002_atxt; $localarrays_x; *)
	VARIABLE TO BLOB:C532($vP_60_004_atxt; $localarrays_x; *)
	VARIABLE TO BLOB:C532($vP_60_003_atxt; $localarrays_x; *)
	VARIABLE TO BLOB:C532($vP_60_001_aL; $localarrays_x; *)
	VARIABLE TO BLOB:C532($vP_60_002_atxt; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_27_001_atxt; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_27_002_aL; $localarrays_x; *)
	
	
	C_TIME:C306($newdoc_t)
	ALERT:C41("saving vars to a document")
	
	$newdoc_t:=Create document:C266("")
	CLOSE DOCUMENT:C267($newdoc_t)
	BLOB TO DOCUMENT:C526(document; $localarrays_x)
	
	Compiler_FieldVariables(179)
	Compiler_FieldVariables(60)
	ARRAY TEXT:C222($vP_60_002_atxt; 0)  //Local ID
	ARRAY TEXT:C222($vP_60_003_atxt; 0)  //Destination ID
	ARRAY TEXT:C222($vP_60_004_atxt; 0)  //Destination
	ARRAY LONGINT:C221($vP_60_001_aL; 0)  //File Number
	
Else 
	
	SET BLOB SIZE:C606($localarrays_x; 0)
	$find_doc_txt:=Select document:C905(""; ""; "Select a document"; 0)
	If (OK=1)
		DOCUMENT TO BLOB:C525(Document; $localarrays_x)
	End if 
End if 
If (BLOB size:C605($localarrays_x)>0)
	C_LONGINT:C283($offset_L)
	$offset_L:=0
	BLOB TO VARIABLE:C533($localarrays_x; $Lv_179_003_aL; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Lv_179_019_aL; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Lv_179_004_aL; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Lv_179_020_atxt; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Lv_179_007_ar; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Lv_179_013_ar; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Lv_179_014_ar; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Lv_179_015_ar; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Lv_179_016_ar; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Lv_179_029_ab; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Lv_179_005_aL; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Lv_179_022_aL; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Lv_179_021_aL; $offset_L)
	
	BLOB TO VARIABLE:C533($localarrays_x; $Lv_60_004_atxt; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Lv_60_003_atxt; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Lv_60_001_aL; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Lv_60_002_atxt; $offset_L)
	
	BLOB TO VARIABLE:C533($localarrays_x; $LPv_60_004_atxt; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $LPv_60_003_atxt; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $LPv_60_001_aL; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $LPv_60_002_atxt; $offset_L)
	
	BLOB TO VARIABLE:C533($localarrays_x; $Lv_27_001_atxt; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Lv_27_002_aL; $offset_L)
	
	SET BLOB SIZE:C606($localarrays_x; 0)
	
	C_LONGINT:C283($loop_L)
	CONFIRM:C162("Run check to verify REFIDs?"; "Run"; "Skip")
	If (OK=1)
		ARRAY TEXT:C222($REFIDMissing_atxt; 0)
		//start the bar
		C_LONGINT:C283(<>ProgressPID)
		<>ProgressPID:=StartProgress("Checking Ref IDs"; "Button"; "Scanning "+String:C10(Size of array:C274($Lv_179_022_aL))+" records"; "NBE Records remaining")
		//initialize the bar
		UpdateProgress(0; Size of array:C274($Lv_179_022_aL))
		For ($loop_L; 1; Size of array:C274($Lv_179_022_aL))
			If (Find in array:C230($Lv_60_002_atxt; String:C10($Lv_179_022_aL{$loop_L}))>0)
				
			Else 
				APPEND TO ARRAY:C911($REFIDMissing_atxt; "Did not find NBE local ID "+String:C10($Lv_179_022_aL{$loop_L})+" for Insp id ="+String:C10($Lv_179_021_aL{$loop_L}))
			End if 
			//update the bar
			If (Mod:C98($loop_L; 200)=0)
				UpdateProgress($loop_L; Size of array:C274($Lv_179_022_aL))
			End if 
			If (<>Abort)
				$loop_L:=Size of array:C274($Lv_179_022_aL)+1
			End if 
		End for 
		//stop the progress bar
		POST OUTSIDE CALL:C329(<>ProgressPID)
		
		ut_DisplayArray(->$REFIDMissing_atxt; "Missing REFIDs = "+String:C10(Size of array:C274($REFIDMissing_atxt)); "NBE Record description")
		
	End if 
	
End if 

SET BLOB SIZE:C606($localarrays_x; 0)

CONFIRM:C162("Reload server vars or read from disk?"; "Reload"; "ReadFromDisk")

If (OK=1)
	Compiler_FieldVariables(179)
	$ServerIP:=Request:C163("Enter Destination Server IP"; <>DestIP)
	$UserName:="designer"
	$Password:="caesar"
	ON ERR CALL:C155("SQL_ERROR")  //
	SQL LOGIN:C817("IP:"+$ServerIP; $UserName; $Password; *)
	
	Begin SQL
		select 
		[PON_ELEM_INSP].ELEM_KEY,
		[PON_ELEM_INSP].ELEM_GRANDPARENT_KEY,
		[PON_ELEM_INSP].ELEM_PARENT_KEY,
		[PON_ELEM_INSP].ELEM_NOTES,
		[PON_ELEM_INSP].ELEM_QUANTITY,
		[PON_ELEM_INSP].ELEM_QTYSTATE1,
		[PON_ELEM_INSP].ELEM_QTYSTATE2,
		[PON_ELEM_INSP].ELEM_QTYSTATE3,
		[PON_ELEM_INSP].ELEM_QTYSTATE4,
		[PON_ELEM_INSP].ELEM_QorP,
		[PON_ELEM_INSP].ENVKEY,
		[PON_ELEM_INSP].ELEMID,
		[PON_ELEM_INSP].INSPID
		from [PON_ELEM_INSP]
		into 
		:v_179_003_aL ,
		:v_179_019_aL,
		:v_179_004_aL,
		:v_179_020_atxt,
		:v_179_007_ar,
		:v_179_013_ar,
		:v_179_014_ar,
		:v_179_015_ar,
		:v_179_016_ar,
		:v_179_029_ab,
		:v_179_005_aL,
		:v_179_022_aL,
		:v_179_021_aL  ;
		
	End SQL
	
	SQL LOGOUT:C872
	ON ERR CALL:C155("")
	
	//save arrays locally in a document
	
	VARIABLE TO BLOB:C532(v_179_003_aL; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_019_aL; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_004_aL; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_020_atxt; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_007_ar; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_013_ar; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_014_ar; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_015_ar; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_016_ar; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_029_ab; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_005_aL; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_022_aL; $localarrays_x; *)
	VARIABLE TO BLOB:C532(v_179_021_aL; $localarrays_x; *)
	
	C_TIME:C306($newdoc_t)
	ALERT:C41("saving  server vars to a document")
	
	$newdoc_t:=Create document:C266("")
	CLOSE DOCUMENT:C267($newdoc_t)
	BLOB TO DOCUMENT:C526(document; $localarrays_x)
	Compiler_FieldVariables(179)
Else 
	SET BLOB SIZE:C606($localarrays_x; 0)
	$find_doc_txt:=Select document:C905(""; ""; "Select a document"; 0)
	If (OK=1)
		DOCUMENT TO BLOB:C525(Document; $localarrays_x)
	End if 
	
End if 

If (BLOB size:C605($localarrays_x)>0)
	C_LONGINT:C283($offset_L)
	$offset_L:=0
	BLOB TO VARIABLE:C533($localarrays_x; $Sv_179_003_aL; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Sv_179_019_aL; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Sv_179_004_aL; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Sv_179_020_atxt; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Sv_179_007_ar; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Sv_179_013_ar; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Sv_179_014_ar; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Sv_179_015_ar; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Sv_179_016_ar; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Sv_179_029_ab; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Sv_179_005_aL; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Sv_179_022_aL; $offset_L)
	BLOB TO VARIABLE:C533($localarrays_x; $Sv_179_021_aL; $offset_L)
	
End if 

SET BLOB SIZE:C606($localarrays_x; 0)
//find first Local inspID recorded in FileIDRes table
C_LONGINT:C283($minLocalInspID_L; $minLocalNBEID_L; $maxLocalInspID_L; $maxLocalNBEID_L)
C_BOOLEAN:C305($RefArraysOK_b)
$RefArraysOK_b:=True:C214
If (Size of array:C274($LPv_60_002_atxt)>0)
	SORT ARRAY:C229($LPv_60_002_atxt; $LPv_60_003_atxt; $LPv_60_001_aL; $LPv_60_004_atxt)
	$minLocalInspID_L:=Num:C11($LPv_60_002_atxt{1})
	$maxLocalInspID_L:=Num:C11($LPv_60_002_atxt{Size of array:C274($LPv_60_002_atxt)})
Else 
	ALERT:C41("Did not find any inspection ID resolution records for destination "+<>Destination)
	$RefArraysOK_b:=False:C215
End if 

//find first Local ElemID recorded in FileIDRes table

If (Size of array:C274($Lv_60_002_atxt)>0)
	SORT ARRAY:C229($Lv_60_002_atxt; $Lv_60_003_atxt; $Lv_60_001_aL; $Lv_60_004_atxt)
	$minLocalNBEID_L:=Num:C11($Lv_60_002_atxt{1})
	$maxLocalNBEID_L:=Num:C11($Lv_60_002_atxt{Size of array:C274($Lv_60_002_atxt)})
Else 
	ALERT:C41("Did not find any NBE ID resolution records for destination "+<>Destination)
	$RefArraysOK_b:=False:C215
End if 

//now compare all records
If ((Size of array:C274($Lv_179_003_aL)>0) & (Size of array:C274($Sv_179_003_aL)>0) & $RefArraysOK_b)
	//start the bar
	C_LONGINT:C283(<>ProgressPID)
	<>ProgressPID:=StartProgress("Verifying Data"; "Button"; "Scanning "+String:C10(Size of array:C274($Lv_179_022_aL))+" records"; "NBE Records remaining")
	//initialize the bar
	UpdateProgress(0; Size of array:C274($Lv_179_003_aL))
	//update the bar
	
	C_LONGINT:C283($loop_L; $ServerNBEID_L; $ServerInspID_L; $ServerRecIndex_L; $BinIndx_L)
	C_TEXT:C284($MatchError_txt; $BIN_txt)
	ARRAY LONGINT:C221($NBEErrorIDS_aL; 0)
	ARRAY TEXT:C222($NBErrorMsgs_atxt; 0)
	For ($loop_L; 1; Size of array:C274($Lv_179_003_aL))
		//find server record
		//server NBE ID
		If ($Lv_179_022_aL{$loop_L}>=$minLocalNBEID_L)
			$ServerNBEID_L:=Find in array:C230($Lv_60_002_atxt; String:C10($Lv_179_022_aL{$loop_L}))
			If ($ServerNBEID_L>0)
				$ServerNBEID_L:=Num:C11($Lv_60_003_atxt{$ServerNBEID_L})
			End if 
			
		Else 
			
			If ($Lv_179_022_aL{$loop_L}>$maxLocalNBEID_L)
				$ServerNBEID_L:=-1  //not sent yet
			Else 
				$ServerNBEID_L:=$Lv_179_022_aL{$loop_L}
			End if 
			
		End if 
		//Server Insp ID
		If ($Lv_179_021_aL{$loop_L}>=$minLocalInspID_L)
			$ServerInspID_L:=Find in array:C230($LPv_60_002_atxt; String:C10($Lv_179_021_aL{$loop_L}))
			If ($ServerInspID_L>0)
				$ServerInspID_L:=Num:C11($LPv_60_003_atxt{$ServerInspID_L})
			End if 
			
		Else 
			
			If ($Lv_179_021_aL{$loop_L}>$maxLocalInspID_L)
				$ServerInspID_L:=-1  //not sent yet
			Else 
				$ServerInspID_L:=$Lv_179_021_aL{$loop_L}
			End if 
			
		End if 
		
		$BIN_txt:=""
		$BinIndx_L:=Find in array:C230($Lv_27_002_aL; $Lv_179_021_aL{$loop_L})
		If ($BinIndx_L>0)
			$BIN_txt:=$Lv_27_001_atxt{$BinIndx_L}
		End if 
		//check if both are >0 - for now all inspids should be in the fileidres table.
		$ServerRecIndex_L:=Find in array:C230($Sv_179_022_aL; $ServerNBEID_L)
		$MatchError_txt:=""
		
		Case of 
			: ($ServerNBEID_L<=0)
				//No remote NBE id found
				$MatchError_txt:=$MatchError_txt+Char:C90(9)+"Remote NBE ID not recorded"
			: ($ServerInspID_L<=0)
				//No remote Insp id found
				$MatchError_txt:=$MatchError_txt+Char:C90(9)+"Remote Inspection ID not recorded"
			: ($ServerRecIndex_L<=0)
				//target NBE ID not found in the server list
				$MatchError_txt:=$MatchError_txt+Char:C90(9)+"Recorded Remote NBE ID "+String:C10($ServerNBEID_L)+" not found in server"
			: ($Sv_179_021_aL{$ServerRecIndex_L}#$ServerInspID_L)
				//inspection IDs don't match
				$MatchError_txt:=$MatchError_txt+Char:C90(9)+"Remote Inspection ID "+String:C10($Sv_179_021_aL{$ServerRecIndex_L})+" does not match recorded "+String:C10($ServerInspID_L)
			Else 
				
				If ($Lv_179_003_aL{$loop_L}#$Sv_179_003_aL{$ServerRecIndex_L})
					$MatchError_txt:=$MatchError_txt+Char:C90(9)+"Elem Key"
				End if 
				
				If ($Lv_179_019_aL{$loop_L}#$Sv_179_019_aL{$ServerRecIndex_L})
					$MatchError_txt:=$MatchError_txt+Char:C90(9)+"GrandParent Key"
				End if 
				
				If ($Lv_179_004_aL{$loop_L}#$Sv_179_004_aL{$ServerRecIndex_L})
					$MatchError_txt:=$MatchError_txt+Char:C90(9)+"Parent Key"
				End if 
				If ($Lv_179_020_atxt{$loop_L}#$Sv_179_020_atxt{$ServerRecIndex_L})
					$MatchError_txt:=$MatchError_txt+Char:C90(9)+"Notes"
				End if 
				If ($Lv_179_007_ar{$loop_L}#$Sv_179_007_ar{$ServerRecIndex_L})
					$MatchError_txt:=$MatchError_txt+Char:C90(9)+"Quantity"
				End if 
				If ($Lv_179_013_ar{$loop_L}#$Sv_179_013_ar{$ServerRecIndex_L})
					$MatchError_txt:=$MatchError_txt+Char:C90(9)+"State 1"
				End if 
				If ($Lv_179_014_ar{$loop_L}#$Sv_179_014_ar{$ServerRecIndex_L})
					$MatchError_txt:=$MatchError_txt+Char:C90(9)+"State 2"
				End if 
				If ($Lv_179_015_ar{$loop_L}#$Sv_179_015_ar{$ServerRecIndex_L})
					$MatchError_txt:=$MatchError_txt+Char:C90(9)+"State 3"
				End if 
				If ($Lv_179_016_ar{$loop_L}#$Sv_179_016_ar{$ServerRecIndex_L})
					$MatchError_txt:=$MatchError_txt+Char:C90(9)+"State 4"
				End if 
				If ($Lv_179_029_ab{$loop_L}#$Sv_179_029_ab{$ServerRecIndex_L})
					$MatchError_txt:=$MatchError_txt+Char:C90(9)+"Q or P"
				End if 
				If ($Lv_179_005_aL{$loop_L}#$Sv_179_005_aL{$ServerRecIndex_L})
					$MatchError_txt:=$MatchError_txt+Char:C90(9)+"Enviroment"
				End if 
				
		End case 
		
		If ($MatchError_txt#"")
			APPEND TO ARRAY:C911($NBEErrorIDS_aL; $Lv_179_022_aL{$loop_L})
			APPEND TO ARRAY:C911($NBErrorMsgs_atxt; "NBE ID "+String:C10($Lv_179_022_aL{$loop_L})+Char:C90(9)+"Insp ID "+String:C10($Lv_179_021_aL{$loop_L})+Char:C90(9)+"BIN "+$BIN_txt+$MatchError_txt)
		End if 
		
		If (Mod:C98($loop_L; 100)=0)
			UpdateProgress($loop_L; Size of array:C274($Lv_179_003_aL))
		End if 
		
		If (<>Abort)
			$loop_L:=Size of array:C274($Lv_179_003_aL)+1
		End if 
	End for 
	
	//stop the progress bar
	POST OUTSIDE CALL:C329(<>ProgressPID)
	
	//check for records in Server not in Local - probably due to Delete bug - fixed by removing Delete action from Delete button.
	C_LONGINT:C283($minServNBEID_L; $minServInspID_L; $LocalNBEID_L; $LocalInspID_L; $LocalRecIndex_L; $maxServNBEID_L; $maxServInspID_L)
	SORT ARRAY:C229($LPv_60_003_atxt; $LPv_60_002_atxt; $LPv_60_001_aL; $LPv_60_004_atxt)
	$minServInspID_L:=Num:C11($LPv_60_002_atxt{1})
	$maxServInspID_L:=Num:C11($LPv_60_002_atxt{Size of array:C274($LPv_60_002_atxt)})
	//find first Local ElemID recorded in FileIDRes table
	SORT ARRAY:C229($Lv_60_003_atxt; $Lv_60_002_atxt; $Lv_60_001_aL; $Lv_60_004_atxt)
	$minServNBEID_L:=Num:C11($Lv_60_002_atxt{1})
	$maxServNBEID_L:=Num:C11($Lv_60_002_atxt{Size of array:C274($Lv_60_002_atxt)})
	
	<>ProgressPID:=StartProgress("Verifying Remote Data"; "Button"; "Scanning "+String:C10(Size of array:C274($Sv_179_003_aL))+" records"; "NBE Records remaining")
	//initialize the bar
	UpdateProgress(0; Size of array:C274($Sv_179_003_aL))
	
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($Sv_179_003_aL))
		//find local record
		//local NBE ID
		If ($Sv_179_022_aL{$loop_L}>=$minLocalNBEID_L)
			$LocalNBEID_L:=Find in array:C230($Lv_60_003_atxt; String:C10($Sv_179_022_aL{$loop_L}))
			If ($LocalNBEID_L>0)
				$LocalNBEID_L:=Num:C11($Lv_60_002_atxt{$LocalNBEID_L})
			End if 
			
		Else 
			
			If ($Sv_179_022_aL{$loop_L}>$maxLocalNBEID_L)
				$LocalNBEID_L:=-1  //not downloaded yet from server
			Else 
				$LocalNBEID_L:=$Sv_179_022_aL{$loop_L}
			End if 
			
		End if 
		//local Insp ID
		If ($Sv_179_021_aL{$loop_L}>=$minServInspID_L)
			$LocalInspID_L:=Find in array:C230($LPv_60_003_atxt; String:C10($Sv_179_021_aL{$loop_L}))
			If ($LocalInspID_L>0)
				$LocalInspID_L:=Num:C11($LPv_60_002_atxt{$LocalInspID_L})
			End if 
			
		Else 
			
			If ($Sv_179_021_aL{$loop_L}>$maxServInspID_L)
				$LocalInspID_L:=-1  //Inspection not downloaded from server
			Else 
				$LocalInspID_L:=$Sv_179_021_aL{$loop_L}
			End if 
			
		End if 
		//get BIN from local insp ID
		$BIN_txt:=""
		$BinIndx_L:=Find in array:C230($Lv_27_002_aL; $LocalInspID_L)
		If ($BinIndx_L>0)
			$BIN_txt:=$Lv_27_001_atxt{$BinIndx_L}
		End if 
		
		$LocalRecIndex_L:=Find in array:C230($Lv_179_022_aL; $LocalNBEID_L)
		
		$MatchError_txt:=""
		
		Case of 
			: ($LocalNBEID_L<0)
				//Element not downloaded yet - no need for error yet
			: ($LocalInspID_L<0)
				//Inspection not downloaded yet - no need for error yet
			: ($LocalRecIndex_L<0)
				//No Local NBE id found
				$MatchError_txt:=$MatchError_txt+Char:C90(9)+"Local NBE record ID "+String:C10($LocalNBEID_L)+" not found"
			: ($Lv_179_021_aL{$LocalRecIndex_L}#$LocalInspID_L)
				//inspection IDs don't match
				$MatchError_txt:=$MatchError_txt+Char:C90(9)+"Local Inspection ID "+String:C10($Lv_179_021_aL{$LocalRecIndex_L})+" does not match recorded "+String:C10($LocalInspID_L)
		End case 
		If ($MatchError_txt#"")
			APPEND TO ARRAY:C911($NBEErrorIDS_aL; $Sv_179_022_aL{$loop_L})
			APPEND TO ARRAY:C911($NBErrorMsgs_atxt; "Server NBE ID "+String:C10($Sv_179_022_aL{$loop_L})+Char:C90(9)+"Server Insp ID "+String:C10($Sv_179_021_aL{$loop_L})+Char:C90(9)+"BIN "+$BIN_txt+$MatchError_txt)
		End if 
		
		If (Mod:C98($loop_L; 100)=0)
			UpdateProgress($loop_L; Size of array:C274($Sv_179_003_aL))
		End if 
		
		If (<>Abort)
			$loop_L:=Size of array:C274($Sv_179_003_aL)+1
		End if 
		
	End for 
	
	//stop the progress bar
	POST OUTSIDE CALL:C329(<>ProgressPID)
	
	ut_DisplayArray(->$NBErrorMsgs_atxt; "NBE Data Verification Errors = "+String:C10(Size of array:C274($NBErrorMsgs_atxt)); "Error Message")
	
	CONFIRM:C162("Save Error messages to file?"; "Save"; "Cancel")
	If (OK=1)
		C_TIME:C306($ErrMsgFile_t)
		$ErrMsgFile_t:=Create document:C266(""; ".txt")
		If (OK=1)
			C_TEXT:C284($Filename_txt)
			$Filename_txt:=Document
			C_LONGINT:C283($loop_L)
			For ($loop_L; 1; Size of array:C274($NBErrorMsgs_atxt))
				SEND PACKET:C103($ErrMsgFile_t; ($NBErrorMsgs_atxt{$loop_L}+Char:C90(13)))
			End for 
			CLOSE DOCUMENT:C267($ErrMsgFile_t)
			ut_OpenDocument($Filename_txt)
		End if 
		
	End if 
Else 
	ALERT:C41("Not All data required to do comparison have been loaded")
End if 
//End PON_ut_compareNBEs