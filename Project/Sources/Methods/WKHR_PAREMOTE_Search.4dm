//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/26/07, 12:32:07
	// ----------------------------------------------------
	// Method: WKHR_PAREMOTE_Search
	// Description
	// Search for the assignement record on the boston server
	// 
	// Parameters
	// $0 : $Error_L
	// $1 : $ConnID_L : connection ID (long)
	// ----------------------------------------------------
	Mods_2007_CM07
	
	Mods_2007_CM12_5301
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (9/3/10 15:39:41)
	//Modify how (Not(4DError_b)) and (Not(SQLError_b)) handled replace with (ut_fTestForSQLor4DError)
	//Modified by: Charles Miller (11/4/11 11:24:03)
	
End if 
C_LONGINT:C283($0; $Error_L; $Numrec_l; $RecFound_L)

$RecFound_L:=0
C_TEXT:C284($SQLSelectQuery_txt)
WKHR_SRCH_AssgnNo_L:=[Work_Estimate:103]AssignNo:16
WKHR_SRCH_ContractNo_s:=[Work_Estimate:103]ContractNo:3
WKHR_SRCH_AddendNo_L:=[Work_Estimate:103]AddendumNo:29
If (WKHR_SRCH_AddendNo_L=0)
	$SQLSelectQuery_txt:="Select ContractNo from [Contract_Assignment_Maintenance] WHERE ContractNo = :WKHR_SRCH_ContractNo_s"
	$SQLSelectQuery_txt:=$SQLSelectQuery_txt+" AND AssignNo = :WKHR_SRCH_AssgnNo_L for UPDATE"
	$Numrec_l:=ut_SQLSelectForLoad($SQLSelectQuery_txt; 0)  //return is a string
	
	
	Case of 
		: (($Numrec_l=1) & (ut_fTestForSQLor4DError))
		: (SQLError_b) | (4DError_b)
		Else 
			ALERT:C41("Contract <"+WKHR_SRCH_ContractNo_s+"> or AssignNo <"+String:C10(WKHR_SRCH_AssgnNo_L)+"> not found on Boston Server!")
	End case 
	
Else 
	$SQLSelectQuery_txt:="Select ContractNo from [Addendum_Maintenance] WHERE ContractNo = :WKHR_SRCH_ContractNo_s"
	$SQLSelectQuery_txt:=$SQLSelectQuery_txt+" AND AssignNo = :WKHR_SRCH_AssgnNo_L "
	$SQLSelectQuery_txt:=$SQLSelectQuery_txt+"AND AddendumNo =:WKHR_SRCH_AddendNo_L for UPDATE"
	$Numrec_l:=ut_SQLSelectForLoad($SQLSelectQuery_txt; 0)  //return is a string
	Case of 
		: (($Numrec_l=1) & (ut_fTestForSQLor4DError))
		: (SQLError_b) | (4DError_b)
		Else 
			ALERT:C41("Contract <"+WKHR_SRCH_ContractNo_s+"> or AssignNo <"+String:C10(WKHR_SRCH_AssgnNo_L)+"> or AddendumNo"+String:C10(WKHR_SRCH_AddendNo_L)+"> not found on Boston Server!")
	End case 
	
	
End if 

$0:=$Numrec_l