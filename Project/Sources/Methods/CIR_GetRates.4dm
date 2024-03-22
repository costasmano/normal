//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/10/08, 10:01:22
	// ----------------------------------------------------
	// Method: CIR_GetRates
	// Description
	// Retrieve the OverHead and NetFee Rates for
	// Consultant inspection, rating assignements.
	// Stores them in the process variables netFeeRate;overheadRate
	// 
	// Parameters
	// $1 : ContractNo_s (string)
	// $2  : AsignmentNo_L (long)
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
End if 
C_TEXT:C284($1; $ContractNo_s)  // Command Replaced was o_C_STRING length was 10
C_LONGINT:C283($2; $AssignmentNo_L)

$ContractNo_s:=$1
$AssignmentNo_L:=$2

C_REAL:C285(netFeeRate; overheadRate)

netFeeRate:=0
overheadRate:=0
READ ONLY:C145([Contracts:79])
READ ONLY:C145([Contract Assignments:83])
QUERY:C277([Contract Assignments:83]; [Contract Assignments:83]ContractNo:1=$ContractNo_s; *)
QUERY:C277([Contract Assignments:83];  & ; [Contract Assignments:83]AssignNo:2=$AssignmentNo_L)
If (Records in selection:C76([Contract Assignments:83])>0)
	FIRST RECORD:C50([Contract Assignments:83])
	netFeeRate:=[Contract Assignments:83]NetFeeRate:22
	overheadRate:=[Contract Assignments:83]OverHeadRate:23
End if 
If ((netFeeRate=0) & (overheadRate=0))
	QUERY:C277([Contracts:79]; [Contracts:79]ContractNo:1=$ContractNo_s)
	
	If (Records in selection:C76([Contracts:79])>0)
		FIRST RECORD:C50([Contracts:79])
		netFeeRate:=[Contracts:79]NetFeeRate:11
		overheadRate:=[Contracts:79]OverheadRate:10
	End if 
End if 

READ WRITE:C146([Contracts:79])
READ WRITE:C146([Contract Assignments:83])