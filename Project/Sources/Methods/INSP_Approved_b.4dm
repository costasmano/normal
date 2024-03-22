//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/20/10, 10:46:37
	// ----------------------------------------------------
	// Method: INSP_Approved_b
	// Description
	//  ` Return True|False whether the current inspection has been approved.
	//  `Generally if InspReviewed = BMS Approved
	//  `if the inspection type is FRZ - freeze thaw allow with only dbie approval
	//  `Can also take optional parameters
	
	// 
	// Parameters
	// $0 : $Approved_b
	// $1 : $inspTYpe_s (Optional)
	// $2 : $Approve_i  (Optional)
	// $3 : $Review_i  (Optional)
	
	// ----------------------------------------------------
	
	Mods_2010_04
End if 
C_BOOLEAN:C305($0; $Approved_b)
C_TEXT:C284($inspTYpe_s)  // Command Replaced was o_C_STRING length was 3
C_LONGINT:C283($Approve_i; $Review_i)  //Command Replaced was o_C_INTEGER
If (Count parameters:C259>0)
	//must have all three
	C_TEXT:C284($1)  // Command Replaced was o_C_STRING length was 3
	C_LONGINT:C283($2; $3)  //Command Replaced was o_C_INTEGER
	$inspTYpe_s:=$1
	$Approve_i:=$2
	$Review_i:=$3
	
Else 
	$inspTYpe_s:=[Inspections:27]Insp Type:6
	$Approve_i:=[Inspections:27]InspApproved:167
	$Review_i:=[Inspections:27]InspReviewed:12
End if 

$Approved_b:=($Approve_i=BMS Approved)
$Approved_b:=$Approved_b | (($Review_i=BMS Approved) & ($inspTYpe_s="FRZ"))

$0:=$Approved_b