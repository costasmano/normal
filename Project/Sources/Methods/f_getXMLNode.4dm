//%attributes = {"invisible":true}
//Method: f_getXMLNode
//Description
// show the name od the node from the SAX get xml Node
// Parameters
// $0 : $Name_txt
// $1 : $Node_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/12/17, 17:08:25
	// ----------------------------------------------------
	//Created : 
	Mods_2017_12
	C_TEXT:C284(f_getXMLNode; $0)
	C_LONGINT:C283(f_getXMLNode; $1)
	
End if 
//
C_TEXT:C284($0)
C_LONGINT:C283($1)

Case of 
	: ($1=1)
		$0:="XML Start Document"
	: ($1=2)
		$0:="XML Comment"
	: ($1=3)
		$0:="XML Processing Instruction"
	: ($1=4)
		$0:="XML Start Element"
	: ($1=5)
		$0:="XML End Element"
	: ($1=6)
		$0:="XML DATA"
	: ($1=7)
		$0:="XML CDATA"
	: ($1=8)
		$0:="XML Entity"
	: ($1=9)
		$0:="XML End Document"
	Else 
		$0:="not 1-9"
End case 

//End f_getXMLNode