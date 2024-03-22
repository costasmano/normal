//%attributes = {"invisible":true}
// Method: Method: INSP_AddElmtCat2HL
// Description
//  ` Adds elements from a category to an Hierarchical list
// 
// Parameters
// $1 : $hlList : hierarchical list
// $2 : $cat : Category to add to the hlList
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/18/11, 16:08:30
	// ----------------------------------------------------
	
	Mods_2011_01
	//` RR
	// Modified by: Costas Manousakis-(Designer)-(2/29/12 16:57:23)
	Mods_2012_02
	//  `check if bridge is RRO or inspection type is RR@
	// Modified by: Costas Manousakis-(Designer)-(5/6/13 11:16:22)
	Mods_2013_05
	//  `RR elements are between 2000 and 3999 
	// Modified by: Costas Manousakis-(Designer)-(4/24/15 10:06:19)
	Mods_2015_04_bug
	//  `for Dive inspections select only elements below 2000 always
End if 
C_LONGINT:C283($1; $hlList)
C_TEXT:C284($2; $cat)  // Command Replaced was o_C_STRING length was 3

C_LONGINT:C283($hChildList; $hSubList)
C_TEXT:C284($name; $parent_description)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284($sItemNumber)  // Command Replaced was o_C_STRING length was 2
C_LONGINT:C283($n; $i; $j; $parent_refnum; $parent; $vlParam)  //Command Replaced was o_C_INTEGER
$hlList:=$1
$cat:=$2
$n:=Find in array:C230(<>ALLElmtCatCode_as; $cat)
If ($n<=0)
	C_TEXT:C284($Msg_txt)
	$Msg_txt:="Unrecognizable Element Safety Category ["+$cat+"]  Category ignored in "+"method "+Current method name:C684+" !!!"
	$Msg_txt:=$Msg_txt+Char:C90(13)+"Please notify the Database Admin!"
	ALERT:C41($Msg_txt)
Else 
	If ($cat="N@")
		$name:=Replace string:C233($cat; "N"; "Item ")
	Else 
		$name:=<>ALLElmtCatDesc_as{$n}
	End if 
	
	$n:=9500+$n
	
	//Get all elements in this category
	QUERY:C277([ElementDict:30]; [ElementDict:30]Category:3=$cat)
	Case of 
		: ([Inspections:27]Insp Type:6="DV@")
			QUERY SELECTION:C341([ElementDict:30]; [ElementDict:30]ElementNo:1<2000)
			
		: ((([Bridge MHD NBIS:1]Item8 BridgeCat:207="@RO") | ([Inspections:27]Insp Type:6="RR@")) & (Position:C15($cat; "N58N59N60N61N62GEN")>0))
			QUERY SELECTION:C341([ElementDict:30]; [ElementDict:30]ElementNo:1>=2000; *)
			QUERY SELECTION:C341([ElementDict:30];  & ; [ElementDict:30]ElementNo:1<4000)
			
		Else 
			QUERY SELECTION:C341([ElementDict:30]; [ElementDict:30]ElementNo:1<2000)
	End case 
	
	ORDER BY:C49([ElementDict:30]; [ElementDict:30]ElementNo:1; >)
	//start with a fresh sub list
	$hSubList:=New list:C375
	For ($i; 1; Records in selection:C76([ElementDict:30]))
		If (([ElementDict:30]IsParent:5=False:C215) & ([ElementDict:30]Parent:4=0))
			APPEND TO LIST:C376($hSubList; [ElementDict:30]Description:2; [ElementDict:30]ElementNo:1)
		Else 
			If ([ElementDict:30]Parent:4=0)
				//Save the current state    
				COPY NAMED SELECTION:C331([ElementDict:30]; "CurrentElements")
				//Get the parent of this category
				$parent_description:=[ElementDict:30]Description:2
				$parent_refnum:=[ElementDict:30]ElementNo:1
				$parent:=[ElementDict:30]ElementNo:1
				QUERY SELECTION:C341([ElementDict:30]; [ElementDict:30]Parent:4=$parent)
				ORDER BY:C49([ElementDict:30]; [ElementDict:30]ElementNo:1)
				$hChildList:=New list:C375
				For ($j; 1; Records in selection:C76([ElementDict:30]))
					APPEND TO LIST:C376($hChildList; [ElementDict:30]Description:2; [ElementDict:30]ElementNo:1)
					NEXT RECORD:C51([ElementDict:30])
				End for 
				APPEND TO LIST:C376($hSubList; $parent_description; $parent_refnum; $hChildList; False:C215)
				USE NAMED SELECTION:C332("CurrentElements")
				CLEAR NAMED SELECTION:C333("CurrentElements")
			End if 
		End if 
		NEXT RECORD:C51([ElementDict:30])
	End for 
	APPEND TO LIST:C376($hlList; $name; $n; $hSubList; False:C215)
	//Set the property of the last item in the list
	SET LIST ITEM PROPERTIES:C386($hlList; 0; False:C215; Bold:K14:2; 0)
	
End if 