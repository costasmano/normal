//%attributes = {"shared":true}
// Method: QR_SearchElements
// Description
// Search for Element by descr, Inspection type, and inspection stage
// 
// Parameters
// $0 : InspType (3CharCode)+" "+InspDate+":"+NumbElmtsInInspect+"-"+NumElmtsMatchingDescr
// $1 : $ElmtDesc_txt
// $2 : $TypeSearch_txt : Comma separated list of inspection types
// $3 : $InspStage_L (optional)
//  ` 0 : any stage
//  ` 1 : completed
//  ` 2 : Approved by DBIE
//  ` 3 : Final Approval
// $4 : $Bin_txt (Optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/06/11, 21:34:05
	// ----------------------------------------------------
	
	Mods_2011_04
	// Modified by: Costas Manousakis-(Designer)-(3/25/14 17:20:36)
	Mods_2014_03
	//  `if no inspections found return a blank string
	//  `unload records at the end
	// Modified by: Costas Manousakis-(Designer)-(3/27/14 17:15:27)
	Mods_2014_03
	//  `added 4th optional parameter to specify the BIN
End if 
C_TEXT:C284($0)
C_TEXT:C284($1; $ElmtDesc_txt)
$ElmtDesc_txt:=$1
C_TEXT:C284($2; $TypeSearch_txt)
$TypeSearch_txt:=$2
ARRAY TEXT:C222($SearchTypes_atxt; 0)
//SET AUTOMATIC RELATIONS(False;False)
C_LONGINT:C283($InspStage_L)
$InspStage_L:=3
If (Count parameters:C259>2)
	C_LONGINT:C283($3)
	$InspStage_L:=$3
End if 
C_TEXT:C284($Bin_txt)
$Bin_txt:=[Bridge MHD NBIS:1]BIN:3
If (Count parameters:C259>3)
	C_TEXT:C284($4)
	$Bin_txt:=$4
End if 

READ ONLY:C145([Inspections:27])
READ ONLY:C145([ElementsSafety:29])

QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=$Bin_txt)

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


If (Records in selection:C76([Inspections:27])>0)
	
	ORDER BY:C49([Inspections:27]; [Inspections:27]Insp Date:78; <)
	//REDUCE SELECTION([Inspections];1)
	FIRST RECORD:C50([Inspections:27])
	$0:=[Inspections:27]Insp Type:6+" "+String:C10([Inspections:27]Insp Date:78)
	QUERY:C277([ElementsSafety:29]; [ElementsSafety:29]InspID:4=[Inspections:27]InspID:2)
	$0:=$0+":"+String:C10(Records in selection:C76([ElementsSafety:29]))
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Description:22=$ElmtDesc_txt)
	FIRST RECORD:C50([ElementsSafety:29])
	$0:=$0+"-"+String:C10(Records in selection:C76([ElementsSafety:29]))
Else 
	$0:=""
End if 
UNLOAD RECORD:C212([Inspections:27])
UNLOAD RECORD:C212([ElementsSafety:29])
READ WRITE:C146([ElementsSafety:29])
READ WRITE:C146([Inspections:27])