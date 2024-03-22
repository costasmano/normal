//%attributes = {"invisible":true}
If (False:C215)
	//procedure: CreateDefElemHlist
	//by: Albert Leung
	//created: 6/26/2001
	//modified:
	//purpose: create a hierarchical list based on the ElementDict Table
	//  using only the default elements (elementno <800)
	//copied from CreateElemDictHlist
	//parameters:
	//$0 return a hList
	//$1..$N the element categories the list will be created from
	
	// Modified by: costasmanousakis-(Designer)-(1/19/11 09:54:46)
	Mods_2011_01
	//  `Use method INSP_AddElmtCat2HL
End if 

C_LONGINT:C283($0; $hlList)  //added Oct-2002
C_TEXT:C284($cat; ${1})  // Command Replaced was o_C_STRING length was 3
C_LONGINT:C283($vlParam)  //Command Replaced was o_C_INTEGER
//the list that gets created
$hlList:=New list:C375
//the sublist that goes with this list
For ($vlParam; 1; Count parameters:C259)
	$cat:=${$vlParam}
	//Name of this element category
	INSP_AddElmtCat2HL($hlList; $cat)
	
End for 
$0:=$hlList