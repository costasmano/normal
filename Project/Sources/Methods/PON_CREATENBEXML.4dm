//%attributes = {"invisible":true}
//Method: PON_CREATENBEXML
//Description
//Export NBEs for FHWA submittal
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/18/15, 17:22:13
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 
//

// for each bridge we export
// find last approved inspection with pon_elements
// select all NBEs with NBE_FLAG = "Y" 
// build arrays with 
//  `Element Number (EN) code in xml
//  `Element parent Number (EPN) code in xml (for no parent EPN = 0)
//  `Element parent + element code in format 0000-0000
//  `total q (TOTALQTY) value in xml
//  `state 2 (CS2) value in xml
//  `State 3 (CS3) value in xml
//  `state 4 (CS4) value in xml

// CS1 will be calculated at the end = round(tot quant;0) - round (c2;0) - round (c3;0) - round(c4;0)

// loop through the elements
//  ` make the pair EPN_EN := string(EPN;"0000")+"-"+string(EN;"0000")
//  ` if elem number and parent number pair does not exist yet
//  `  ` add to the arrays
//  ` if elem parent_elem code exist
//  `  ` add quantities and Cs2,3,4 to the arrays
// end element loop

// loop through arrays
// sax open node FHWAED
// sax open node STATE = 25 sax close node STATE
// sax open node STRUCNUM = proper item8 or FHWAItem8 sax close node STRUCNUM
// sax open node EN = elem_key sax close node EN
// if EPN#0 sax open node EN + sax close node EPN
// sax open node TOTALQTY = round(TOTALQTY;0) sax close node TOTALQTY
// CS1 = round(tot quant;0) - round (c2;0) - round (c3;0) - round(c4;0)
// sax open node CS1 = CS1 sax close node CS1
// sax open node CS2 = round(cs2;0) sax close node cs2
// sax open node cs3 = round(cs3;0) sax close node cs3
// sax open node cs4 = round(cs4;0) sax close node cs4
// sax close node FHWAED


//End PON_CREATENBEXML