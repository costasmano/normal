//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/12/10, 17:34:58
	// ----------------------------------------------------
	// Method: QR_SearchInspections
	// Description
	// Search for inspections and load the latest from the list found
	// 
	// Parameters
	// $1: $TypeSearch_txt : Comma separated list of inspection types
	// $2 : $InspStage_L (Optional)
	//  ` 0 : any stage
	//  ` 1 : completed
	//  ` 2 : Approved by DBIE
	//  ` 3 : Final Approval
	// ----------------------------------------------------
	
	Mods_2010_08
	// Modified by: costasmanousakis-(Designer)-(8/26/10 10:51:42)
	Mods_2010_08
	//  `Modified search for InspStage=2 to include inspections with a 1 step final approval
End if 
C_TEXT:C284($1; $TypeSearch_txt)
$TypeSearch_txt:=$1
ARRAY TEXT:C222($SearchTypes_atxt; 0)
//SET AUTOMATIC RELATIONS(False;False)
READ ONLY:C145([Inspections:27])
QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[Bridge MHD NBIS:1]BIN:3)

If (Length:C16($TypeSearch_txt)>0)
	C_BLOB:C604($parseResult_x)
	$parseResult_x:=ut_ParseTextToArrayDelim($TypeSearch_txt; ",")
	C_LONGINT:C283($offset_L)
	$offset_L:=0
	BLOB TO VARIABLE:C533($parseResult_x; $SearchTypes_atxt; $offset_L)
	SET BLOB SIZE:C606($parseResult_x; 0)
	If (Size of array:C274($SearchTypes_atxt)>0)
		C_LONGINT:C283($loop_L)
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6=$SearchTypes_atxt{1}; *)
		
		For ($loop_L; 2; Size of array:C274($SearchTypes_atxt))
			QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6=$SearchTypes_atxt{$loop_L}; *)
		End for 
		
		QUERY SELECTION:C341([Inspections:27])
		
	End if 
	
End if 
C_LONGINT:C283($InspStage_L)
$InspStage_L:=3
If (Count parameters:C259>1)
	C_LONGINT:C283($2)
	$InspStage_L:=$2
End if 

Case of 
	: ($InspStage_L=3)
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspApproved:167=BMS Approved)
	: ($InspStage_L=2)
		SET QUERY DESTINATION:C396(Into set:K19:2; "DBIEAPPROVEDSET")
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspReviewed:12=BMS Approved)
		SET QUERY DESTINATION:C396(Into set:K19:2; "ABIEAPRROVEONLYSET")
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspApproved:167=BMS Approved; *)
		QUERY SELECTION:C341([Inspections:27];  & ; [Inspections:27]InspReviewed:12#BMS Approved)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		UNION:C120("DBIEAPPROVEDSET"; "ABIEAPRROVEONLYSET"; "DBIEAPPROVEDSET")
		USE SET:C118("DBIEAPPROVEDSET")
		CLEAR SET:C117("DBIEAPPROVEDSET")
		CLEAR SET:C117("ABIEAPRROVEONLYSET")
		
	: ($InspStage_L=1)
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspComplete:168=True:C214)
		
End case 

ORDER BY:C49([Inspections:27]; [Inspections:27]Insp Date:78; <)
//REDUCE SELECTION([Inspections];1)
FIRST RECORD:C50([Inspections:27])
READ WRITE:C146([Inspections:27])
