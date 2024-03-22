//%attributes = {"invisible":true}
//Method: PON_VerifyNBELinks
//Description
// Verify whether the NBEs related to the current inspection are correctly linked.
// Parameters
// $0 : $text : text containing results of check
// $1 : $InspectionID_L (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/03/19, 13:10:43
	// ----------------------------------------------------
	//Created : 
	Mods_2019_01
	
	C_TEXT:C284(PON_VerifyNBELinks; $0)
	C_LONGINT:C283(PON_VerifyNBELinks; $1)
	
End if 
//

C_TEXT:C284($0)

C_LONGINT:C283($InspID_L)

If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$InspID_L:=$1
Else 
	$InspID_L:=[Inspections:27]InspID:2
End if 

PON_SETARRAYS  //initialize dictionary arrays if needed

ARRAY LONGINT:C221($ElemID_aL; 0)
ARRAY LONGINT:C221($StrUnit_aL; 0)
ARRAY LONGINT:C221($EnvKey_aL; 0)
ARRAY LONGINT:C221($elemKey_aL; 0)
ARRAY LONGINT:C221($ParentKey_aL; 0)
ARRAY LONGINT:C221($ParentID_aL; 0)
ARRAY LONGINT:C221($GParentKey_aL; 0)
ARRAY LONGINT:C221($GParentID_aL; 0)

Begin SQL
	select 
	[PON_ELEM_INSP].[ELEMID]
	,[PON_ELEM_INSP].[STRUNITKEY]
	,[PON_ELEM_INSP].[ENVKEY]
	,[PON_ELEM_INSP].[ELEM_KEY]
	,[PON_ELEM_INSP].[ELEM_PARENT_KEY]
	,[PON_ELEM_INSP].[ELEM_PARENTID]
	,[PON_ELEM_INSP].[ELEM_GRANDPARENT_KEY]
	,[PON_ELEM_INSP].[ELEM_GRANDPARENTID]
	from [PON_ELEM_INSP]
	where
	[PON_ELEM_INSP].[INSPID] = :$InspID_L 
	into 
	:$ElemID_aL
	, :$StrUnit_aL
	, :$EnvKey_aL
	, :$elemKey_aL
	, :$ParentKey_aL
	, :$ParentID_aL
	, :$GParentKey_aL
	, :$GParentID_aL ;
End SQL

ARRAY TEXT:C222($CombineIndx_atxt; Size of array:C274($ElemID_aL))
C_TEXT:C284($StrUFmt_txt; $keyFmt_txt; $envFmt_txt)
$StrUFmt_txt:="000"
$keyFmt_txt:="000000"
$envFmt_txt:="000"

C_LONGINT:C283($elmtloop_L)
//build a combined index for searching
For ($elmtloop_L; 1; Size of array:C274($ElemID_aL))
	$CombineIndx_atxt{$elmtloop_L}:=String:C10($StrUnit_aL{$elmtloop_L}; $StrUFmt_txt)+\
		String:C10($EnvKey_aL{$elmtloop_L}; $envFmt_txt)+\
		String:C10($elemKey_aL{$elmtloop_L}; $keyFmt_txt)
End for 

C_LONGINT:C283($child_indx_L; $parent_indx_L)
C_TEXT:C284($InspErrors_txt; $elmtErr_txt; $childErr_txt)
$InspErrors_txt:=""

// part 1 : find if the children by ID point back to the parent
For ($elmtloop_L; 1; Size of array:C274($ElemID_aL))
	$child_indx_L:=0
	$child_indx_L:=Find in array:C230($ParentID_aL; $ElemID_aL{$elmtloop_L})
	$elmtErr_txt:=""
	While ($child_indx_L>0)
		$childErr_txt:=""
		If ($ParentKey_aL{$child_indx_L}#$elemKey_aL{$elmtloop_L})
			//error : parent key of child does not match current
			$childErr_txt:=$childErr_txt+"Parent key of child ("+String:C10($ParentKey_aL{$child_indx_L})+") does not match current\r"
		End if 
		If ($StrUnit_aL{$child_indx_L}#$StrUnit_aL{$elmtloop_L})
			//error : Str unit of child does not match current
			$childErr_txt:=$childErr_txt+"Str unit of child ("+String:C10($StrUnit_aL{$child_indx_L})+") does not match current\r"
		End if 
		If ($EnvKey_aL{$child_indx_L}#$EnvKey_aL{$elmtloop_L})
			//error : enviroment of child
			$childErr_txt:=$childErr_txt+"Env of child ("+String:C10($EnvKey_aL{$child_indx_L})+") does not match current\r"
		End if 
		
		If ($childErr_txt#"")
			$elmtErr_txt:=$elmtErr_txt+"Child ID : "+String:C10($ElemID_aL{$child_indx_L})+\
				" Key "+String:C10($elemKey_aL{$child_indx_L})+" Errors :\r"+$childErr_txt
		End if 
		$child_indx_L:=Find in array:C230($ParentID_aL; $ElemID_aL{$elmtloop_L}; $child_indx_L+1)
	End while 
	If ($elmtErr_txt#"")
		$InspErrors_txt:=$InspErrors_txt+"Element ID "+String:C10($ElemID_aL{$elmtloop_L})+\
			" Key "+String:C10($elemKey_aL{$elmtloop_L})+" StrUnit "+String:C10($StrUnit_aL{$elmtloop_L})+\
			" Env "+String:C10($EnvKey_aL{$elmtloop_L})+" has child errors : \r"+$elmtErr_txt
	End if 
End for 

// part 2 : find if the grandchildren by ID point back to the grandparent

For ($elmtloop_L; 1; Size of array:C274($ElemID_aL))
	$child_indx_L:=0
	$child_indx_L:=Find in array:C230($GParentID_aL; $ElemID_aL{$elmtloop_L})
	$elmtErr_txt:=""
	
	While ($child_indx_L>0)
		$childErr_txt:=""
		
		If ($GParentKey_aL{$child_indx_L}#$elemKey_aL{$elmtloop_L})
			//error : grandparentkey does not match current
			$childErr_txt:=$childErr_txt+"Grandparent key of grandchild ("+String:C10($ParentKey_aL{$child_indx_L})+") does not match current\r"
		End if 
		If ($StrUnit_aL{$child_indx_L}#$StrUnit_aL{$elmtloop_L})
			//error : strunit of grandchild does not match current
			$childErr_txt:=$childErr_txt+"Str unit of grandchild ("+String:C10($StrUnit_aL{$child_indx_L})+") does not match current\r"
		End if 
		
		If ($EnvKey_aL{$child_indx_L}#$EnvKey_aL{$elmtloop_L})
			//error : env of grandchild does not match current
			$childErr_txt:=$childErr_txt+"Env of grandchild ("+String:C10($EnvKey_aL{$child_indx_L})+") does not match current\r"
		End if 
		
		If ($childErr_txt#"")
			$elmtErr_txt:=$elmtErr_txt+"GrandChild ID : "+String:C10($ElemID_aL{$child_indx_L})+\
				" Key "+String:C10($elemKey_aL{$child_indx_L})+" Errors :\r"+$childErr_txt
		End if 
		
		$child_indx_L:=Find in array:C230($GParentID_aL; $ElemID_aL{$elmtloop_L}; $child_indx_L+1)
	End while 
	If ($elmtErr_txt#"")
		$InspErrors_txt:=$InspErrors_txt+"Element ID "+String:C10($ElemID_aL{$elmtloop_L})+\
			" Key "+String:C10($elemKey_aL{$elmtloop_L})+" StrUnit "+String:C10($StrUnit_aL{$elmtloop_L})+\
			" Env "+String:C10($EnvKey_aL{$elmtloop_L})+" has grandchild errors : \r"+$elmtErr_txt
	End if 
End for 

// part 3 : find if the the parent exists and matches 
For ($elmtloop_L; 1; Size of array:C274($ElemID_aL))
	$parent_indx_L:=0
	
	$elmtErr_txt:=""
	
	Case of 
		: ($ParentKey_aL{$elmtloop_L}=0) & ($ParentId_aL{$elmtloop_L}=0)
			//no parent for this element
		: ($ParentKey_aL{$elmtloop_L}=0)
			//error : parent key = 0  with Parent index > 0
			$elmtErr_txt:="parent key = 0 with Parent index > 0 "+String:C10($ParentID_aL{$elmtloop_L})+"\r"
		: ($ParentId_aL{$elmtloop_L}=0)
			//error : parent ID = with Parent key > 0
			$elmtErr_txt:="parent ID = 0 with Parent key > 0 "+String:C10($ParentKey_aL{$elmtloop_L})+"\r"
		Else 
			$parent_indx_L:=Find in array:C230($ElemID_aL; $ParentID_aL{$elmtloop_L})
			
			If ($parent_indx_L>0)
				
				If ($elemKey_aL{$parent_indx_L}#$ParentKey_aL{$elmtloop_L})
					//error : key of parent elmt does not match parent key
					$elmtErr_txt:=$elmtErr_txt+"key of parent elmt "+String:C10($elemKey_aL{$parent_indx_L})+\
						" does not match parent key "+String:C10($ParentKey_aL{$elmtloop_L})+"\r"
				End if 
				If ($EnvKey_aL{$parent_indx_L}#$EnvKey_aL{$elmtloop_L})
					//error : enviroment of parent elmt does not match current env
					$elmtErr_txt:=$elmtErr_txt+"enviroment of parent elmt "+String:C10($EnvKey_aL{$parent_indx_L})+\
						" does not match curr env "+String:C10($EnvKey_aL{$elmtloop_L})+"\r"
				End if 
				
				If ($StrUnit_aL{$parent_indx_L}#$StrUnit_aL{$elmtloop_L})
					//error : structure unit of parent elmt does not match structure unit
					$elmtErr_txt:=$elmtErr_txt+"Struct unit of parent elmt "+String:C10($StrUnit_aL{$parent_indx_L})+\
						" does not match curr Str U "+String:C10($StrUnit_aL{$elmtloop_L})+"\r"
				End if 
				
			Else 
				//error : parent not in list of inspection elements
				$elmtErr_txt:="Parent ID "+String:C10($ParentID_aL{$elmtloop_L})+" not found in list of inspection elements\r"
				
			End if 
			
	End case 
	If ($elmtErr_txt#"")
		$InspErrors_txt:=$InspErrors_txt+"Element ID "+String:C10($ElemID_aL{$elmtloop_L})+\
			" Key "+String:C10($elemKey_aL{$elmtloop_L})+" StrUnit "+String:C10($StrUnit_aL{$elmtloop_L})+\
			" Env "+String:C10($EnvKey_aL{$elmtloop_L})+\
			" Parent Key "+String:C10($ParentKey_aL{$elmtloop_L})+\
			" Parent ID "+String:C10($ParentID_aL{$elmtloop_L})+\
			" has parent errors : \r"+$elmtErr_txt
		
	End if 
	
End for 

// part 4 : find if the the grandparent exists and matches 
For ($elmtloop_L; 1; Size of array:C274($ElemID_aL))
	$parent_indx_L:=0
	$elmtErr_txt:=""
	
	Case of 
		: ($gParentKey_aL{$elmtloop_L}=0) & ($gParentId_aL{$elmtloop_L}=0)
			
		: ($gParentKey_aL{$elmtloop_L}=0)
			//error : grandparent key = with grandParent index > 0
			$elmtErr_txt:="Grandparent key = 0 with grandParent index > 0 "+String:C10($ParentID_aL{$elmtloop_L})+"\r"
		: ($gParentId_aL{$elmtloop_L}=0)
			//error : grandparent ID = with grandParent key > 0
			$elmtErr_txt:="Grandparent ID = 0 with GrandParent key > 0 "+String:C10($ParentKey_aL{$elmtloop_L})+"\r"
			
		Else 
			$parent_indx_L:=Find in array:C230($ElemID_aL; $gParentID_aL{$elmtloop_L})
			
			If ($parent_indx_L>0)
				
				If ($elemKey_aL{$parent_indx_L}#$GParentKey_aL{$elmtloop_L})
					//error : key of grandparent elmt does not match parent key
					$elmtErr_txt:=$elmtErr_txt+"key of grandparent elmt "+String:C10($elemKey_aL{$parent_indx_L})+\
						" does not match grandparent key "+String:C10($gParentKey_aL{$elmtloop_L})+"\r"
				End if 
				
				If ($EnvKey_aL{$parent_indx_L}#$EnvKey_aL{$elmtloop_L})
					//error : enviroment of grandparent elmt does not match current env
					$elmtErr_txt:=$elmtErr_txt+"enviroment of grandparent elmt "+String:C10($EnvKey_aL{$parent_indx_L})+\
						" does not match curr env "+String:C10($EnvKey_aL{$elmtloop_L})+"\r"
				End if 
				
				If ($StrUnit_aL{$parent_indx_L}#$StrUnit_aL{$elmtloop_L})
					//error : structure unit of grandparent elmt does not match structure unit
					$elmtErr_txt:=$elmtErr_txt+"Struct unit of grandparent elmt "+String:C10($StrUnit_aL{$parent_indx_L})+\
						" does not match curr Str U "+String:C10($StrUnit_aL{$elmtloop_L})+"\r"
				End if 
				
			Else 
				//error : grandparent not in list of inspection elements
				$elmtErr_txt:="GrandParent ID "+String:C10($gParentID_aL{$elmtloop_L})+" not found in list of inspection elements\r"
				
			End if 
			
	End case 
	
	If ($elmtErr_txt#"")
		$InspErrors_txt:=$InspErrors_txt+"Element ID "+String:C10($ElemID_aL{$elmtloop_L})+\
			" Key "+String:C10($elemKey_aL{$elmtloop_L})+" StrUnit "+String:C10($StrUnit_aL{$elmtloop_L})+\
			" Env "+String:C10($EnvKey_aL{$elmtloop_L})+\
			" GrandParent Key "+String:C10($GParentKey_aL{$elmtloop_L})+\
			" GrandParent ID "+String:C10($GParentID_aL{$elmtloop_L})+\
			" has grandparent errors : \r"+$elmtErr_txt
		
	End if 
	
End for 

$0:=$InspErrors_txt
//End PON_VerifyNBELinks