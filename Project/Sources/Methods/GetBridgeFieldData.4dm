//%attributes = {}
// ----------------------------------------------------
// Method: GetBridgeFieldData
// Description
//  ` Retrieve a data field from a bridge record by BIN.
//  ` Usefull for searching by formula on tables with a BIN field but 
//  ` with no relation defined in the structure to the [Bridge MHD NBIS] table
// 
// Parameters
// $0 : $RetValue_txt
// $1 : $BIN_txt
// $2 : $Bridgefld_ptr
// ----------------------------------------------------

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/01/11, 10:11:45
	// First Release
	Mods_2011_12
End if 
C_TEXT:C284($1; $BIN_txt)
$BIN_txt:=$1
C_POINTER:C301($2; $Bridgefld_ptr)
$Bridgefld_ptr:=$2
C_TEXT:C284($0; $RetValue_txt)
$RetValue_txt:=""
C_LONGINT:C283($ptrTable_L; $ptrFld_L)
C_TEXT:C284($ptrName_txt)
RESOLVE POINTER:C394($Bridgefld_ptr; $ptrName_txt; $ptrTable_L; $ptrFld_L)
If ($ptrTable_L#Table:C252(->[Bridge MHD NBIS:1]))
	ALERT:C41(Current method name:C684+" : Error = Pointer passed is not to a field in the Bridge MHD NBIS table!")
Else 
	C_LONGINT:C283($FldType_L)
	$FldType_L:=Type:C295($Bridgefld_ptr->)
	C_BOOLEAN:C305($BridgeRO_b; $AutoOne_b; $AutoMany_b)
	$BridgeRO_b:=Read only state:C362([Bridge MHD NBIS:1])
	If (Not:C34($BridgeRO_b))
		READ ONLY:C145([Bridge MHD NBIS:1])
	End if 
	//also avoid loading other records
	GET AUTOMATIC RELATIONS:C899($AutoOne_b; $AutoMany_b)
	SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BIN_txt)
	If (Records in selection:C76([Bridge MHD NBIS:1])=1)
		
		Case of 
			: ($FldType_L=Is alpha field:K8:1) | ($FldType_L=Is text:K8:3)
				$RetValue_txt:=$Bridgefld_ptr->
			: ($FldType_L=Is boolean:K8:9)
				If ($Bridgefld_ptr->)
					$RetValue_txt:="True"
				Else 
					$RetValue_txt:="False"
				End if 
			Else 
				$RetValue_txt:=String:C10($Bridgefld_ptr->)
		End case 
		
	End if 
	SET AUTOMATIC RELATIONS:C310($AutoOne_b; $AutoMany_b)
	If (Not:C34($BridgeRO_b))
		READ WRITE:C146([Bridge MHD NBIS:1])
	End if 
	
End if 

$0:=$RetValue_txt