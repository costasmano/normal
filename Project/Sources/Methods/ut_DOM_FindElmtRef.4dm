//%attributes = {"invisible":true}
//Method: ut_DOM_FindElmtRef
//Description
// find the reference in a DOM tree of an element with a value
// Parameters
// $0 : $elemRef_txt
// $1 : $DomTree_txt
// $2 : $ElementPath_txt
// $3 : $FindElemValue_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/16/16, 16:22:26
	// ----------------------------------------------------
	//Created : 
	Mods_2016_08
	
	C_TEXT:C284(ut_DOM_FindElmtRef; $0)
	C_TEXT:C284(ut_DOM_FindElmtRef; $1)
	C_TEXT:C284(ut_DOM_FindElmtRef; $2)
	C_POINTER:C301(ut_DOM_FindElmtRef; $3)
	
	// Modified by: Costas Manousakis-(Designer)-(9/1/16 17:12:35)
	Mods_2016_09
	//  `for alpha text strings use f_trimstr to remove spaces , linefeeds etc.
End if 
//
C_TEXT:C284($0; $FoundelemRef_txt)
C_TEXT:C284($1; $DomTree_txt)
C_TEXT:C284($2; $ElementPath_txt)
C_POINTER:C301($3; $FindElemValue_ptr)

$FoundelemRef_txt:=""

$DomTree_txt:=$1
$ElementPath_txt:=$2
$FindElemValue_ptr:=$3

C_TEXT:C284($elemRef_txt)

C_TEXT:C284($elemValue_txt)
C_LONGINT:C283($elemValue_L)
C_REAL:C285($elemValue_r)
C_DATE:C307($elemValue_d)
C_TIME:C306($elemValue_t)
C_BOOLEAN:C305($elemValue_b)

ARRAY TEXT:C222($ElemeRefs_atxt; 0)
$elemRef_txt:=DOM Find XML element:C864($DomTree_txt; $ElementPath_txt; $ElemeRefs_atxt)
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($ElemeRefs_atxt))
	
	Case of 
		: ((Type:C295($FindElemValue_ptr->)=Is alpha field:K8:1) | (Type:C295($FindElemValue_ptr->)=Is text:K8:3) | (Type:C295($FindElemValue_ptr->)=Is string var:K8:2))
			DOM GET XML ELEMENT VALUE:C731($ElemeRefs_atxt{$loop_L}; $elemValue_txt)
			$elemValue_txt:=f_TrimStr($elemValue_txt; True:C214; True:C214)
			If ($elemValue_txt=$FindElemValue_ptr->)
				$FoundelemRef_txt:=$ElemeRefs_atxt{$loop_L}
				$loop_L:=Size of array:C274($ElemeRefs_atxt)+1
			End if 
		: ((Type:C295($FindElemValue_ptr->)=Is integer:K8:5) | (Type:C295($FindElemValue_ptr->)=Is longint:K8:6))
			DOM GET XML ELEMENT VALUE:C731($ElemeRefs_atxt{$loop_L}; $elemValue_L)
			If ($elemValue_L=$FindElemValue_ptr->)
				$FoundelemRef_txt:=$ElemeRefs_atxt{$loop_L}
				$loop_L:=Size of array:C274($ElemeRefs_atxt)+1
			End if 
		: (Type:C295($FindElemValue_ptr->)=Is real:K8:4)
			DOM GET XML ELEMENT VALUE:C731($ElemeRefs_atxt{$loop_L}; $elemValue_r)
			If ($elemValue_r=$FindElemValue_ptr->)
				$FoundelemRef_txt:=$ElemeRefs_atxt{$loop_L}
				$loop_L:=Size of array:C274($ElemeRefs_atxt)+1
			End if 
		: (Type:C295($FindElemValue_ptr->)=Is date:K8:7)
			DOM GET XML ELEMENT VALUE:C731($ElemeRefs_atxt{$loop_L}; $elemValue_d)
			If ($elemValue_d=$FindElemValue_ptr->)
				$FoundelemRef_txt:=$ElemeRefs_atxt{$loop_L}
				$loop_L:=Size of array:C274($ElemeRefs_atxt)+1
			End if 
		: (Type:C295($FindElemValue_ptr->)=Is time:K8:8)
			DOM GET XML ELEMENT VALUE:C731($ElemeRefs_atxt{$loop_L}; $elemValue_t)
			If ($elemValue_t=$FindElemValue_ptr->)
				$FoundelemRef_txt:=$ElemeRefs_atxt{$loop_L}
				$loop_L:=Size of array:C274($ElemeRefs_atxt)+1
			End if 
		: (Type:C295($FindElemValue_ptr->)=Is boolean:K8:9)
			DOM GET XML ELEMENT VALUE:C731($ElemeRefs_atxt{$loop_L}; $elemValue_b)
			If ($elemValue_b=$FindElemValue_ptr->)
				$FoundelemRef_txt:=$ElemeRefs_atxt{$loop_L}
				$loop_L:=Size of array:C274($ElemeRefs_atxt)+1
			End if 
			
	End case 
	
End for 

$0:=$FoundelemRef_txt
//End ut_DOM_FindElmtRef