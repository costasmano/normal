//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 11/29/11, 11:11:40
//----------------------------------------------------
//Method: INSP_CheckCompleteness
//Description
//
// Parameters
// ----------------------------------------------------
//$0 boolean set to true if download needed
//  `set to false if all records match
//$1 longint  table we are checking

If (False:C215)
	//Mods_2011_11 `
	//Modified by: Charles Miller (11/29/11 11:11:41)
End if 
C_BOOLEAN:C305($0)
C_BOOLEAN:C305($Return_b)
C_LONGINT:C283($1; $TableNumber_l; $LocalRecordCount_l; $FileResIDCount_l; $LocalFromFileIDCount_l)
$TableNumber_l:=$1
C_TEXT:C284($TableName_txt)
$TableName_txt:=Table name:C256($TableNumber_l)
ARRAY LONGINT:C221(RemoteIDs_al; 0)
CLEAR VARIABLE:C89(RemoteIDs_al)
//$FileResIDCount_l number of records found in [FileIDRes Table] using remote ids
//$LocalFromFileIDCount_l # local table records from [FileIDRes Table]
//$LocalRecordCount_l # of local recods form inspection id

SET QUERY DESTINATION:C396(Into set:K19:2; "$FileIDRestableSet")
QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]File Number:1=$TableNumber_l; *)
QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination:4=<>Destination)
C_BOOLEAN:C305($AutoOne_b; $AutoMany_b)
GET AUTOMATIC RELATIONS:C899($AutoOne_b; $AutoMany_b)
SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
SET QUERY DESTINATION:C396(Into variable:K19:4; $LocalRecordCount_l)
C_BOOLEAN:C305($FoundCombined_b)
$FoundCombined_b:=True:C214
Case of 
	: ($TableName_txt="ElementsSafety")
		
		QUERY:C277([ElementsSafety:29]; [ElementsSafety:29]InspID:4=[Inspections:27]InspID:2)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		SQL_Select:="SELECT [ElmSafetyID] FROM [ElementsSafety] WHERE [InspID] = :RemoteID_l INTO :RemoteIDs_al"
		
	: ($TableName_txt="Standard Photos")
		
		QUERY:C277([Standard Photos:36]; [Standard Photos:36]InspID:1=[Inspections:27]InspID:2)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		SQL_Select:="SELECT [StdPhotoID] FROM [Standard Photos] WHERE [InspID] = :RemoteID_l INTO :RemoteIDs_al"
		
	: ($TableName_txt="Cond Units")
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]NBISInspID:2=[Inspections:27]InspID:2)
		QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $LocalRecordCount_l)
		QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2=[Combined Inspections:90]BMSInspID:3)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		//[Combined Inspections]
		SQL_Select:="SELECT [BMSInspID] FROM [Combined Inspections] WHERE [NBISInspID] = :RemoteID_l INTO :RemoteIDs_al"
		Begin SQL
			EXECUTE IMMEDIATE :SQL_Select;
		End SQL
		If (Size of array:C274(RemoteIDs_al)=1)
			C_LONGINT:C283(CONDRemoteID_l)
			CONDRemoteID_l:=RemoteIDs_al{1}
			
			SQL_Select:="SELECT [Cond Unit ID] FROM [Cond Units] WHERE [Inspection ID] = :CONDRemoteID_l INTO :RemoteIDs_al"
		Else 
			$FoundCombined_b:=False:C215
			ALERT:C41("Problem with remote inspection ID "+String:C10(RemoteID_l)+". Notify datra base administrator!!!!")
			
		End if 
End case 

SET QUERY DESTINATION:C396(Into current selection:K19:1)
C_LONGINT:C283($InnerLoop_l)

//do the select
If ($FoundCombined_b)
	Begin SQL
		EXECUTE IMMEDIATE :SQL_Select;
	End SQL
	
	ARRAY TEXT:C222($QueryArray_atxt; 0)
	CLEAR VARIABLE:C89($QueryArray_atxt)
	ARRAY TEXT:C222($QueryArray_atxt; Size of array:C274(RemoteIDs_al))
	For ($InnerLoop_l; 1; Size of array:C274(RemoteIDs_al))
		$QueryArray_atxt{$InnerLoop_l}:=String:C10(RemoteIDs_al{$InnerLoop_l})
	End for 
	USE SET:C118("$FileIDRestableSet")
	SET QUERY DESTINATION:C396(Into set:K19:2; "$LocalIdsSet")
	QUERY SELECTION WITH ARRAY:C1050([FileIDRes Table:60]Destination ID:3; $QueryArray_atxt)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	CLEAR VARIABLE:C89($QueryArray_atxt)
	ARRAY TEXT:C222($QueryArray_atxt; 0)
	$Return_b:=False:C215
	$FileResIDCount_l:=Records in set:C195("$LocalIdsSet")
	
	If ($FileResIDCount_l=0)
		If (Size of array:C274(RemoteIDs_al)#$LocalRecordCount_l)
			$Return_b:=True:C214
		End if 
	Else 
		USE SET:C118("$LocalIdsSet")
		ARRAY TEXT:C222($QueryArray_atxt; $FileResIDCount_l)
		SELECTION RANGE TO ARRAY:C368(1; $FileResIDCount_l; [FileIDRes Table:60]Local ID:2; $QueryArray_atxt)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $LocalFromFileIDCount_l)
		ARRAY LONGINT:C221($LocalIDs_al; 0)
		CLEAR VARIABLE:C89($LocalIDs_al)
		ARRAY LONGINT:C221($LocalIDs_al; Size of array:C274($QueryArray_atxt))
		For ($InnerLoop_l; 1; Size of array:C274($LocalIDs_al))
			$LocalIDs_al{$InnerLoop_l}:=Num:C11($QueryArray_atxt{$InnerLoop_l})
		End for 
		
		Case of 
			: ($TableName_txt="ElementsSafety")
				QUERY WITH ARRAY:C644([ElementsSafety:29]ElmSafetyID:7; $LocalIDs_al)
			: ($TableName_txt="Standard Photos")
				QUERY WITH ARRAY:C644([Standard Photos:36]StdPhotoID:7; $LocalIDs_al)
			: ($TableName_txt="Cond Units")
				QUERY WITH ARRAY:C644([Cond Units:45]Cond Unit ID:1; $LocalIDs_al)
				
		End case 
		
		Case of 
			: ($LocalFromFileIDCount_l#$LocalRecordCount_l)
				$Return_b:=True:C214
			: (Size of array:C274(RemoteIDs_al)#$LocalRecordCount_l)
				$Return_b:=True:C214
			Else 
				$Return_b:=False:C215
		End case 
		//
		//If ($LocalFromFileIDCount_l#$LocalRecordCount_l)
		//$Return_b:=True
		//Else 
		//$Return_b:=False
		//End if 
	End if 
	
Else 
	$Return_b:=False:C215
End if 
CLEAR SET:C117("$FileIDRestableSet")
CLEAR SET:C117("$LocalIdsSet")

SET AUTOMATIC RELATIONS:C310($AutoOne_b; $AutoMany_b)

SET QUERY DESTINATION:C396(Into current selection:K19:1)
$0:=$Return_b
//End INSP_CheckCompleteness