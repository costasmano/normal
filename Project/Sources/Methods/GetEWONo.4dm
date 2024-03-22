//%attributes = {"invisible":true}
C_TEXT:C284($sContractNo; $1)  // Command Replaced was o_C_STRING length was 10
C_TEXT:C284(vEWO)  // Command Replaced was o_C_STRING length was 30

$sContractNo:=$1
//EWO number for different contract numbers      
Case of 
	: ($sContractNo="30171")
		vEWO:="X009-027-P12-2"
	: ($sContractNo="30176")
		vEWO:="X009-027-P22-2"
	: ($sContractNo="30177")
		vEWO:="X009-027-P32-2"
	: ($sContractNo="30178")
		vEWO:="X009-027-P42-2"
	: ($sContractNo="30179")
		vEWO:="X009-027-P52-2"
	: ($sContractNo="30180")
		vEWO:="X009-027-P62-2"
	: ($sContractNo="30181")
		vEWO:="X009-027-P72-2"
	: ($sContractNo="30182")
		vEWO:="X009-026-P12-2"
	: ($sContractNo="30183")
		vEWO:="X009-027-P82-2"
	: ($sContractNo="30184")
		vEWO:="X009-027-P92-2"
	: ($sContractNo="30185")
		vEWO:="X009-027-P02-2"
	Else 
		vEWO:=""
End case 