//%attributes = {"invisible":true}
If (False:C215)
	//procedure: GetDefElemHlistFromArr
	//by: Albert Leung
	//created: 1/10/2003
	//modified:
	//purpose: create a hierarchical list based on a given array of element numbers
	//assumption: list of elements are in order by category and the array is
	//terminated by 0.
	//parameters:
	//$0 return a hList
	//$1 pointer to an array of Integer
End if 

C_POINTER:C301($1; $ptrArrElemNo)
C_LONGINT:C283($vlSize; $i; $parent_refnum; $currparent; $n)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($cat; $prevcat)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($sItemNumber)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($parent_description; $name)  // Command Replaced was o_C_STRING length was 255

//Get the array of element numbers
$ptrArrElemNo:=$1
C_LONGINT:C283($0; $hlList; $hSubList; $hChildList)
//the list that gets created
$hlList:=New list:C375

//Get the size of the array
$vlSize:=Size of array:C274($ptrArrElemNo->)
$cat:=""
$prevcat:=""
$hSubList:=0
$hChildList:=0
$parent_description:=""
$parent_refnum:=-1
$currparent:=-1
For ($i; 1; $vlSize)
	//Get the entry in the ElementDict table
	$prevcat:=$cat
	QUERY:C277([ElementDict:30]; [ElementDict:30]ElementNo:1=$ptrArrElemNo->{$i})
	If (Records in selection:C76([ElementDict:30])=1)
		//Get the current category
		$cat:=[ElementDict:30]Category:3
		If ($cat#$prevcat)
			//Found a new category      
			If ($prevcat#"")
				If ($parent_refnum#-1)
					APPEND TO LIST:C376($hSubList; $parent_description; $parent_refnum; $hChildList; $hChildList=0)
					$parent_refnum:=-1
				End if 
				APPEND TO LIST:C376($hlList; $name; $n; $hSubList; $hSubList=0)
				//Set the property of the last item in the list
				SET LIST ITEM PROPERTIES:C386($hlList; 0; False:C215; Bold:K14:2; 0)
			End if 
			Case of 
				: ($cat="APP")
					$name:="Approaches"
					$n:=1
				: ($cat="OVR")
					$name:="Overhead Signs"
					$n:=2
				: ($cat="TRA")
					$name:="Traffic Safety"
					$n:=3
				Else 
					//Name of this element category
					$name:=Replace string:C233($cat; "N"; "Item ")
					$sItemNumber:=Substring:C12($cat; 2; 2)
					$n:=Num:C11($sItemNumber)
			End case 
			$prevcat:=$cat
			//start with a fresh sub list
			$hSubList:=New list:C375
		End if 
		If (([ElementDict:30]IsParent:5=False:C215) & ([ElementDict:30]Parent:4=0))
			//Append the child list if it exists.
			If ($parent_refnum#-1)
				APPEND TO LIST:C376($hSubList; $parent_description; $parent_refnum; $hChildList; $hChildList=0)
				$parent_refnum:=-1
			End if 
			//This element can not fall into a sub category. Just append it.
			APPEND TO LIST:C376($hSubList; [ElementDict:30]Description:2; [ElementDict:30]ElementNo:1)
			//No parent
			$currparent:=0
		Else 
			//It is a parent      
			If ([ElementDict:30]Parent:4=0)
				//Append the child list if it exists.        
				If ($parent_refnum#-1)
					APPEND TO LIST:C376($hSubList; $parent_description; $parent_refnum; $hChildList; $hChildList=0)
					$parent_refnum:=-1
					//Done. A parent can not have no children, so don't worry about
					//not appending the parent.
				End if 
				//This is a parent element. Create a child list.
				$hChildList:=New list:C375
				$currparent:=[ElementDict:30]ElementNo:1
				$parent_description:=[ElementDict:30]Description:2
				$parent_refnum:=[ElementDict:30]ElementNo:1
			Else 
				//This is a child element. See if the parent is there.
				If ([ElementDict:30]Parent:4=$currparent)
					//The parent is already there.
					APPEND TO LIST:C376($hChildList; [ElementDict:30]Description:2; [ElementDict:30]ElementNo:1)
				Else 
					$currparent:=[ElementDict:30]Parent:4
					//Create the child list
					$hChildList:=New list:C375
					APPEND TO LIST:C376($hChildList; [ElementDict:30]Description:2; [ElementDict:30]ElementNo:1)
					//Get the parent.        
					QUERY:C277([ElementDict:30]; [ElementDict:30]ElementNo:1=$currparent)
					APPEND TO LIST:C376($hSubList; [ElementDict:30]Description:2; [ElementDict:30]ElementNo:1)
					$parent_description:=[ElementDict:30]Description:2
					$parent_refnum:=[ElementDict:30]ElementNo:1
				End if 
			End if 
		End if 
	End if 
	//See if we are at the end of the array
	If ($ptrArrElemNo->{$i+1}=0)
		//Get out of the loop
		$i:=$vlSize+1
	End if 
End for 
If ($parent_refnum#-1)
	APPEND TO LIST:C376($hSubList; $parent_description; $parent_refnum; $hChildList; $hChildList=0)
	//Done. A parent can not have no children, so don't worry about
	//not appending the parent.
End if 
APPEND TO LIST:C376($hlList; $name; $n; $hSubList; $hSubList=0)
//Set the property of the last item in the list
SET LIST ITEM PROPERTIES:C386($hlList; 0; False:C215; Bold:K14:2; 0)
$0:=$hlList