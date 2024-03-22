//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 03/03/16, 16:46:26
//----------------------------------------------------
//Method: ut_DeleteNoMatchFileIDResRecord
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_02_bug  // 
	//Modified by: Chuck Miller (3/3/16 16:46:28)
	
End if 
Compiler_Clone
COMPILER_forSQL
Compiler_FieldVariables(Table:C252(->[Sequences:28]))

ARRAY LONGINT:C221($UniqueFileNumbers_aL; 0)
ALL RECORDS:C47([FileIDRes Table:60])
DISTINCT VALUES:C339([FileIDRes Table:60]File Number:1; $UniqueFileNumbers_aL)
C_TEXT:C284($Find_txt)
ARRAY POINTER:C280($FieldPtr_aptr; 0)
ARRAY TEXT:C222($KeyNames_atxt; 0)
C_POINTER:C301($Field_Ptr)

ARRAY LONGINT:C221($FileUniqueFileNumbers_aL; 0)

C_LONGINT:C283($Loop_l)
//build tables and corresponding Sequences to check
For ($Loop_l; Size of array:C274($UniqueFileNumbers_aL); 1; -1)
	$Find_txt:=""
	
	Case of 
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="inspections")
			//$Field_Ptr:=->[Inspections]InspID
			//$Find_txt:="inspections"
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="ElementsSafety")
			$Field_Ptr:=->[ElementsSafety:29]ElmSafetyID:7
			$Find_txt:="ElementsSafety"
			
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="Standard Photos")
			$Field_Ptr:=->[Standard Photos:36]StdPhotoID:7
			$Find_txt:="StandardPhotos"
			
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="Personnel")
			//$Field_Ptr:=->[Personnel]Person ID
			//$Find_txt:="Personnel"
			//
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="BMS Inspections")
			//$Field_Ptr:=->[BMS Inspections]Inspection ID
			//$Find_txt:="Pontis Insp ID"
			
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="Cond Units")
			$Field_Ptr:=->[Cond Units:45]Cond Unit ID:1
			$Find_txt:="Cond Unit ID"
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="Conslt Rating")
			//$Field_Ptr:=->[Conslt Rating]ConsltRatingID
			//$Find_txt:="ConsRtg"
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="Cons Inspection")
			//$Field_Ptr:=->[Cons Inspection]ConsInspectionID
			//$Find_txt:="ConsInsp"
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="RatingReports")
			//$Field_Ptr:=->[RatingReports]RatingID
			//$Find_txt:="RatingReports"
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="TownLineInfo")
			//$Field_Ptr:=->[TownLineInfo]RefID
			//$Find_txt:="TownLine"
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="Bridge Design")
			//$Field_Ptr:=->[Bridge Design]BridgeDesignID
			//$Find_txt:="BrDesign"
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="Conslt Address")
			//$Field_Ptr:=->[Conslt Address]ConsltAddressID
			//$Find_txt:="ConsAddress"
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="Town Address")
			//$Field_Ptr:=->[Town Address]TownAddressID
			//$Find_txt:="TownAddress"
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="Combined Inspections")
			//$Field_Ptr:=->[Combined Inspections]ID
			//$Find_txt:="CombinedInspections"
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="InventoryPhotoInsp")
			//$Field_Ptr:=->[InventoryPhotoInsp]InvPhotoInspID_L
			//$Find_txt:="InventoryPhotoInsp"
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="InventoryPhotos")
			$Field_Ptr:=->[InventoryPhotos:113]InvPhoto_ID:1
			$Find_txt:="InventoryPhoto"
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="ScourPOA")
			//$Field_Ptr:=->[ScourPOA]ScourPOAID
			//$Find_txt:="ScourPOA"
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="ScourPOA_Images")
			//$Field_Ptr:=->[ScourPOA_Images]ScourPOAImgID
			//$Find_txt:="ScourPOA_Images"
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="TunnelInspection")
			$Field_Ptr:=->[TunnelInspection:152]TunnelInspID_L:15
			$Find_txt:="TunnelInspection"
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="RatingRequests")
			//$Field_Ptr:=->[RatingRequests]RatingRequestID_L
			//$Find_txt:="RatingRequest"
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="AddtlRatingRequests")
			//$Field_Ptr:=->[AddtlRatingRequests]AddtlRequestID_L
			//$Find_txt:="AddRatingRequest"
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="ElmtRatingLoads")
			//$Field_Ptr:=->[ElmtRatingLoads]ElmtRtgLoadID_L
			//$Find_txt:="ElmtRatingLoads"
		: (Table name:C256($UniqueFileNumbers_aL{$Loop_l})="PON_ELEM_INSP")
			
			$Field_Ptr:=->[PON_ELEM_INSP:179]ELEMID:22
			$Find_txt:="PON_ELEM_INSP"
		Else 
			
			
	End case 
	If ($Find_txt#"")
		APPEND TO ARRAY:C911($FileUniqueFileNumbers_aL; $UniqueFileNumbers_aL{$Loop_l})
		
		APPEND TO ARRAY:C911($FieldPtr_aptr; $Field_Ptr)
		APPEND TO ARRAY:C911($KeyNames_atxt; $Find_txt)
	Else 
		DELETE FROM ARRAY:C228($UniqueFileNumbers_aL; $Loop_l; 1)
	End if 
End for 
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
//get sequences from server
ON ERR CALL:C155("SQL_ERROR")
Begin SQL
	select 
	[Sequences].[Name],
	[Sequences].[Value]
	from
	[Sequences]
	into
	:v_28_001_atxt,
	:v_28_002_aL;
	
End SQL
ut_SQLLogout
ON ERR CALL:C155("4D_Errors")  //
C_TEXT:C284($Find_txt)
ARRAY LONGINT:C221($RecordsToDelete_aL; 0)
C_LONGINT:C283($InnerLoop_L; $pos_L)
CREATE EMPTY SET:C140([FileIDRes Table:60]; "FinalDELSet")

For ($Loop_l; 1; Size of array:C274($FileUniqueFileNumbers_aL))
	$pos_L:=Find in array:C230(v_28_001_atxt; $KeyNames_atxt{$Loop_l})
	If ($pos_L>0)
		SET QUERY DESTINATION:C396(Into set:K19:2; "FileIDResSet")  //All FileIDRes for table
		QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]File Number:1=$FileUniqueFileNumbers_aL{$Loop_l})
		USE SET:C118("FileIDResSet")
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		QUERY SELECTION:C341([FileIDRes Table:60]; [FileIDRes Table:60]Destination:4="here")
		ARRAY TEXT:C222($LocalID_atxt; 0)
		
		SELECTION TO ARRAY:C260([FileIDRes Table:60]Local ID:2; $LocalID_atxt)
		For ($InnerLoop_L; Size of array:C274($LocalID_atxt); 1; -1)  //Remove IDs 
			If (Num:C11($LocalID_atxt{$InnerLoop_L})<=v_28_002_aL{$pos_L})
				DELETE FROM ARRAY:C228($LocalID_atxt; $InnerLoop_L; 1)
			End if 
		End for 
		USE SET:C118("FileIDResSet")
		QUERY SELECTION:C341([FileIDRes Table:60]; [FileIDRes Table:60]Destination:4="here")
		
		SET QUERY DESTINATION:C396(Into set:K19:2; "Here")
		
		QUERY SELECTION WITH ARRAY:C1050([FileIDRes Table:60]Local ID:2; $LocalID_atxt)
		ARRAY TEXT:C222($MyLocalIds_atxt; 0)
		USE SET:C118("Here")
		SELECTION TO ARRAY:C260([FileIDRes Table:60]Destination ID:3; $MyLocalIds_atxt)
		USE SET:C118("FileIDResSet")
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		QUERY SELECTION:C341([FileIDRes Table:60]; [FileIDRes Table:60]Destination:4#"here")
		
		SET QUERY DESTINATION:C396(Into set:K19:2; "NotHere")
		QUERY SELECTION WITH ARRAY:C1050([FileIDRes Table:60]Destination ID:3; $LocalID_atxt)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		
		UNION:C120("Here"; "NotHere"; "Final")
		USE SET:C118("Final")
		
		ARRAY LONGINT:C221($MyLocalIDs_al; 0)
		CLEAR VARIABLE:C89($MyLocalIds_aL)
		ARRAY LONGINT:C221($MyLocalIds_aL; Size of array:C274($MyLocalIds_atxt))
		
		For ($InnerLoop_L; 1; Size of array:C274($MyLocalIds_atxt))
			$MyLocalIds_aL{$InnerLoop_L}:=Num:C11($MyLocalIds_atxt{$InnerLoop_L})
		End for 
		
		QUERY WITH ARRAY:C644($FieldPtr_aptr{$Loop_L}->; $MyLocalIds_aL)
		C_POINTER:C301($Table_ptr)
		$Table_ptr:=Table:C252($FileUniqueFileNumbers_aL{$Loop_L})
		
		If (Records in selection:C76($Table_ptr->)>0)
			
			//QR REPORT($Table_ptr->;Char(1))
			//CONFIRM("Add to FinalDELSet set";"Yes";"No")
			//If (OK=1)
			
			UNION:C120("Final"; "FinalDELSet"; "FinalDELSet")
			//End if 
		Else 
			UNION:C120("Final"; "FinalDELSet"; "FinalDELSet")
			
		End if 
		
	End if 
End for 
USE SET:C118("FinalDELSet")

//QR REPORT([FileIDRes Table];Char(1))
//CONFIRM("Set "+String(Records in selection([FileIDRes Table]))+" File ID res Records to be deleted?";"Yes";"No")

//If (OK=1)
UNLOAD RECORD:C212([FileIDRes Table:60])
READ WRITE:C146([FileIDRes Table:60])
APPLY TO SELECTION:C70([FileIDRes Table:60]; ut_ResetFileIDResRecords)
//End if 

//End ut_DeleteNoMatchFileIDResRecord