//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 11/15/12, 13:42:47
//----------------------------------------------------
//Method: insp_NewAddElmtCat2HL
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_11  //r002 ` 
	//Modified by: Charles Miller (11/15/12 13:42:48)
	// Modified by: Costas Manousakis-(Designer)-(5/1/13 11:54:48)
	Mods_2013_05
	//  `make the itemreference of the category sublist negative to avoid mixup with element numbers
End if 
C_LONGINT:C283($hlList)
C_TEXT:C284($cat)
$hlList:=$1
$cat:=$2

C_POINTER:C301($3; $Array_Ptr)
$Array_Ptr:=$3

C_LONGINT:C283($n; $Loop_l; $i; $j)
$n:=Find in array:C230(<>ALLElmtCatCode_as; $cat)
C_LONGINT:C283($hSubList; $hChildList; $parent_refnum; $parent)
C_TEXT:C284($name; $parent_description)
If ($n<=0)
	C_TEXT:C284($Msg_txt)
	$Msg_txt:="Unrecognizable Element Safety Category ["+$cat+"]  Category ignored in "+"method "+Current method name:C684+" !!!"
	$Msg_txt:=$Msg_txt+Char:C90(13)+"Please notify the Database Admin!"
	ALERT:C41($Msg_txt)
Else 
	ARRAY INTEGER:C220($ElementNumbers_al; Size of array:C274($Array_Ptr->))
	
	For ($Loop_l; 1; Size of array:C274($Array_Ptr->))
		$ElementNumbers_al{$Loop_l}:=Num:C11($Array_Ptr->{$Loop_l})
	End for 
	
	If ($cat="N@")
		$name:=Replace string:C233($cat; "N"; "Item ")
	Else 
		$name:=<>ALLElmtCatDesc_as{$n}
	End if 
	QUERY WITH ARRAY:C644([ElementDict:30]ElementNo:1; $ElementNumbers_al)
	
	ORDER BY:C49([ElementDict:30]; [ElementDict:30]ElementNo:1; >)
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
	APPEND TO LIST:C376($hlList; $name; (-$n); $hSubList; False:C215)
	//Set the property of the last item in the list
	SET LIST ITEM PROPERTIES:C386($hlList; 0; False:C215; Bold:K14:2; 0)
End if 
//End insp_NewAddElmtCat2HL