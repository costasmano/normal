//%attributes = {"invisible":true}
//Method: COMPILER_XMLUtils
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/07/12, 13:14:39
	// ----------------------------------------------------
	//Created : 
	Mods_2012_12
	// Modified by: Costas Manousakis-(Designer)-(4/27/16 13:00:25)
	Mods_2016_04_bug
	//  `add ut_DOM_GetElementIndex
	Mods_2018_01  //Fix Compiler issues Methods not in Compiler directives
	//Modified by: Chuck Miller (1/9/18 13:06:22)
	
End if 
//
C_BOOLEAN:C305(XMLError_b)
ARRAY LONGINT:C221(XMLErrorNumbers_al; 0)
ARRAY TEXT:C222(XML_InternalCodes_atxt; 0)
ARRAY TEXT:C222(XML_InternalDescriptions_atxt; 0)

If (False:C215)
	//For XML methods
	
	C_LONGINT:C283(ut_DOM_GetElementIndex; $0)
	C_TEXT:C284(ut_DOM_GetElementIndex; $1)
	C_TEXT:C284(ut_DOM_GetElementIndex; $2)
	C_LONGINT:C283(ut_DOM_GetElementIndex; $3)
	
	
	C_TEXT:C284(ut_DOM_FindElmtRef; $0)
	C_TEXT:C284(ut_DOM_FindElmtRef; $1)
	C_TEXT:C284(ut_DOM_FindElmtRef; $2)
	C_POINTER:C301(ut_DOM_FindElmtRef; $3)
	
	C_TEXT:C284(ut_DOM_To_Arrays; $1)
	C_TEXT:C284(ut_DOM_To_Arrays; $2)
	C_POINTER:C301(ut_DOM_To_Arrays; $3; $4; $5)
	
	C_BOOLEAN:C305(getToRowCell; $0)
	C_TIME:C306(getToRowCell; $1)
	C_LONGINT:C283(getToRowCell; $2; $3)
	C_POINTER:C301(getToRowCell; $4; $5; $6)
	
	C_TEXT:C284(f_getXMLNode; $0)
	C_LONGINT:C283(f_getXMLNode; $1)
	
	C_TEXT:C284(ut_DOM_LoadXML; $0)
	C_TEXT:C284(ut_DOM_LoadXML; $1)
	C_TEXT:C284(ut_DOM_LoadXML; $2)
	
End if 

//End COMPILER_XMLUtils