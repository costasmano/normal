//%attributes = {"invisible":true}
//Method: PERS_ExpandGroups
//Description
// starting from a collection of group ids, find all groups that the start set is a member of
// Parameters
// $1 : $startCollection [{"PERS_GroupID_I", grpId}]
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Apr 25, 2023, 17:10:00
	Mods_2023_04
	// ----------------------------------------------------
	
	C_COLLECTION:C1488(PERS_ExpandGroups; $1)  //collection  of PERS_Group IDs
End if 
//
C_COLLECTION:C1488($1)  //collection  of PERS_Group IDs
C_COLLECTION:C1488($new_c; $start_c; $base_c)
C_OBJECT:C1216($grp_o; $grps_o; $new_o)
$start_c:=$1  // use this as a start to search for more parent groups
$base_c:=$1  // will be adding new found groups to this collection
C_BOOLEAN:C305($done_b)
$done_b:=False:C215
C_COLLECTION:C1488($search_c)
Repeat 
	$search_c:=New collection:C1472  //make the collection to use for query - groupids are stored as negative
	For each ($grp_o; $start_c)
		$search_c.push(-($grp_o.PERS_GroupID_I))
	End for each 
	$new_o:=ds:C1482.PERS_Groups.query("PERS_GroupID_I_54_GroupID_I.PersonID_I IN :1"; $search_c)
	$start_c:=New collection:C1472  // start setting up the new base for searching
	$new_c:=New collection:C1472
	If ($new_o.length>0)
		$new_c:=$new_o.toCollection("PERS_GroupName_s, PERS_GroupID_I")
		For each ($grp_o; $new_c)
			C_LONGINT:C283($pos_L; $i)
			// check to see if it is a new group
			$pos_L:=-1
			For ($i; 1; $base_c.length)
				If ($grp_o.PERS_GroupID_I=$base_c[$i-1].PERS_GroupID_I)
					$pos_L:=$i-1
					$i:=$base_c.length+1
				End if 
			End for 
			//$pos_L:=$base_c.lastIndexOf($grp_o;0) `lastIndexOf does not seem to work for objects
			If ($pos_L<0)
				// group not found previously - add it to the members and to the new search
				$base_c.push($grp_o)
				$start_c.push($grp_o)
			End if 
			
		End for each 
		
	End if 
	
	If ($start_c.length=0)
		$done_b:=True:C214
	End if 
Until ($done_b)

//End PERS_ExpandGroups   