//%attributes = {"invisible":true}
If (False:C215)
	//procedure: AddElemtoHlist
	//by: Albert Leung
	//created: 4/20/2001
	//modified:
	//purpose: add an element a to hierarchical list
	//Copyright © 1995-2001,  Albert S. Leung, All Rights Reserved.
	//parameters:
	//$1 hierarchical list to add
	//$2 element number of element to add
	//$3 the description of the elemen
	//$4 the sublist that comes with this element
	//$5 if that sublist is expanded or not
	Mods_2013_01  //r001 ` Fix bug where category description was being set incorrectly
	//Issue surfaced for category of GEN which should have been General but became GEItem
	//Modified by: Charles Miller (1/8/13 12:23:57)
	// Modified by: Costas Manousakis-(Designer)-(5/22/13 16:28:29)
	Mods_2013_05
	//  `added numbering for  new categories in rail and tunnels
End if 

C_POINTER:C301($pHlist; $1)
C_LONGINT:C283($2; $elementNo)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($3; $elementName)  // Command Replaced was o_C_STRING length was 255
C_BOOLEAN:C305($5; $elementSublistExpanded)

C_LONGINT:C283($viParentNo; $viCat; $viItemPos; $viItemRef; $j)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($vbIsParent; $vbExpanded)
C_TEXT:C284($vsCatName; $vsItemText)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($elementSublist; $hElement; $hlChild; $hSubList; $4; $n)

//get the hierarchical list
$pHlist:=$1
//get the element number of the element to add
$elementNo:=$2
$elementName:=$3
$elementSublist:=$4
$elementSublistExpanded:=$5
//find out if this element has a parent
QUERY:C277([ElementDict:30]; [ElementDict:30]ElementNo:1=$elementNo)
If ($elementName="")
	$elementName:=[ElementDict:30]Description:2
End if 
If (Records in selection:C76([ElementDict:30])#0)
	//This is an element  
	$viParentNo:=[ElementDict:30]Parent:4
	$viCat:=Num:C11(Substring:C12([ElementDict:30]Category:3; 2; 2))
	$vsCatName:=[ElementDict:30]Category:3
	If ($viCat=0)
		Case of 
			: ($vsCatName="APP")
				$viCat:=70
			: ($vsCatName="OVR")
				$viCat:=71
			: ($vsCatName="TRA")
				$viCat:=72
			: ($vsCatName="GEN")
				$viCat:=73
			: ($vsCatName="STR")
				$viCat:=74
			: ($vsCatName="ROA")
				$viCat:=75
			: ($vsCatName="CEI")
				$viCat:=76
			: ($vsCatName="SUP")
				$viCat:=77
			: ($vsCatName="CRO")
				$viCat:=78
			: ($vsCatName="EGR")
				$viCat:=79
			: ($vsCatName="UTI")
				$viCat:=80
			: ($vsCatName="WET")
				$viCat:=81
				
		End case 
	End if 
	$n:=Find in array:C230(<>ALLElmtCatCode_as; [ElementDict:30]Category:3)
	If ($n>0)
		If ([ElementDict:30]Category:3="N@")
			$vsCatName:=Replace string:C233([ElementDict:30]Category:3; "N"; "Item ")
		Else 
			$vsCatName:=<>ALLElmtCatDesc_as{$n}
		End if 
	Else 
		If ([ElementDict:30]Category:3="N@")
			$vsCatName:=Replace string:C233([ElementDict:30]Category:3; "N"; "Item ")
		Else 
			$vsCatName:=[ElementDict:30]Category:3
		End if 
	End if 
	//$vsCatName:=Replace string([ElementDict]Category;"N";"Item ")
	$vbIsParent:=[ElementDict:30]IsParent:5
	If ($viParentNo#0)
		//This item has a parent
		If (List item position:C629($pHlist->; $viParentNo)=0)
			//Add the parent with the new element as a sublist.      
			$elementSublist:=New list:C375
			APPEND TO LIST:C376($elementSublist; $elementName; $elementNo)
			//Find out who the parent is
			QUERY:C277([ElementDict:30]; [ElementDict:30]ElementNo:1=$viParentNo)
			//Create the element list
			//Now append this to the root category
			If (List item position:C629($pHlist->; $viCat)=0)
				//Create the root item
				$hElement:=New list:C375
				APPEND TO LIST:C376($hElement; [ElementDict:30]Description:2; [ElementDict:30]ElementNo:1; $elementSublist; $elementSublistExpanded)
				APPEND TO LIST:C376($pHList->; $vsCatName; $viCat; $hElement; True:C214)
			Else 
				//Get the existing category
				SELECT LIST ITEMS BY REFERENCE:C630($pHList->; $viCat)
				$viItemPos:=Selected list items:C379($pHList->)
				GET LIST ITEM:C378($pHList->; $viItemPos; $viItemRef; $vsItemText; $hSubList; $vbExpanded)
				APPEND TO LIST:C376($hSubList; [ElementDict:30]Description:2; [ElementDict:30]ElementNo:1; $elementSubList; True:C214)
				SET LIST ITEM:C385($pHList->; $viCat; $vsCatName; $viCat; $hSubList; True:C214)
			End if 
		Else 
			//Append the new item to the parent.      
			SELECT LIST ITEMS BY REFERENCE:C630($pHList->; $viParentNo)
			$viItemPos:=Selected list items:C379($pHList->)
			//Get the parent
			GET LIST ITEM:C378($pHList->; $viItemPos; $viItemRef; $vsItemText; $hSubList; $vbExpanded)
			APPEND TO LIST:C376($hSubList; $elementName; $elementNo)
			SET LIST ITEM:C385($pHList->; $viParentNo; $vsItemText; $viItemRef; $hSubList; True:C214)
		End if 
	Else 
		//This item has no parent    
		If ($vbIsParent)
			//This element is a parent so get the child list.
			QUERY:C277([ElementDict:30]; [ElementDict:30]Parent:4=$elementNo)
			ORDER BY:C49([ElementDict:30]; [ElementDict:30]ElementNo:1)
			$hlChild:=New list:C375
			For ($j; 1; Records in selection:C76([ElementDict:30]))
				APPEND TO LIST:C376($hlChild; [ElementDict:30]Description:2; [ElementDict:30]ElementNo:1)
				NEXT RECORD:C51([ElementDict:30])
			End for 
		End if 
		//This element is not a parent      
		//See if the element category exists
		If (List item position:C629($pHlist->; $viCat)=0)
			//Create the element list
			$hElement:=New list:C375
			If ($vbIsparent)
				APPEND TO LIST:C376($hElement; $elementName; $elementNo; $hlChild; True:C214)
			Else 
				APPEND TO LIST:C376($hElement; $elementName; $elementNo)
			End if 
			APPEND TO LIST:C376($pHlist->; $vsCatName; $viCat; $hElement; True:C214)
		Else 
			//Get the existing category
			SELECT LIST ITEMS BY REFERENCE:C630($pHList->; $viCat)
			$viItemPos:=Selected list items:C379($pHList->)
			GET LIST ITEM:C378($pHList->; $viItemPos; $viItemRef; $vsItemText; $hSubList; $vbExpanded)
			If ($vbIsParent)
				APPEND TO LIST:C376($hSubList; $elementName; $elementNo; $hlChild; True:C214)
			Else 
				APPEND TO LIST:C376($hSubList; $elementName; $elementNo)
			End if 
			SET LIST ITEM:C385($pHList->; $viCat; $vsCatName; $viCat; $hSubList; True:C214)
		End if 
	End if 
	SET LIST ITEM PROPERTIES:C386($pHList->; 0; False:C215; Bold:K14:2; 0)
	//SORT LIST($pHlist->) 
	REDRAW:C174($pHlist->)  // Command Replaced was o_REDRAW LIST 
Else 
	//This is a root item like Item 58, 59, 60, etc.
	C_LONGINT:C283($copylist)
	$copylist:=ut_CopyList($elementSublist)  //make a copy of the sublist 2004-04-28
	APPEND TO LIST:C376($pHlist->; $elementName; $elementNo; $copylist; $elementSublistExpanded)
	SET LIST ITEM PROPERTIES:C386($pHList->; 0; False:C215; Bold:K14:2; 0)
	//SORT LIST($pHlist->)
	REDRAW:C174($pHlist->)  // Command Replaced was o_REDRAW LIST 
End if 