//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/27/07, 09:34:32
	// ----------------------------------------------------
	// Method: ut_ArrayToHL
	// Description
	// Create an Hierarch list from an array. must be a one dim array.
	// picture/boolean not supported
	// 
	// Parameters
	// $0 : HL : Longint
	// $1 : ArrayPtr : ptr
	// $2 : Optional format : String (for dates must pass the string (ex string(MM DD YYYY Forced))
	// $3 : $ArrIndx_ptr : ptr : ref ids for the first array
	// ----------------------------------------------------
	
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(11/30/07 14:29:16)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(9/24/08 21:14:24)
	Mods_2008_CM_5404  // ("HLISTSELECT")
	//  `Added capacity to create sublists based on whether the item desc
	//  `is in the format "Desc (Category)"
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($0; $HL; $TempList; $starti; $j)
C_POINTER:C301($1; $Arr_ptr)
C_TEXT:C284($2; $OptFormat)
C_BOOLEAN:C305($CustomIndx_b)
$Arr_ptr:=$1
$CustomIndx_b:=False:C215
If (Count parameters:C259>1)
	$OptFormat:=$2
	If (Count parameters:C259>2)
		C_POINTER:C301($3; $ArrIndx_ptr)
		$ArrIndx_ptr:=$3
		If ((Type:C295($ArrIndx_ptr->)=Integer array:K8:18) | (Type:C295($ArrIndx_ptr->)=LongInt array:K8:19))
			If (Size of array:C274($ArrIndx_ptr->)=Size of array:C274($Arr_ptr->))
				$CustomIndx_b:=True:C214
			End if 
		End if 
	Else 
		
	End if 
	
Else 
	$OptFormat:=""
End if 

C_LONGINT:C283($ArrSize_L; $i)
$ArrSize_L:=Size of array:C274($Arr_ptr->)
Case of 
	: ($ArrSize_L=0)
	Else 
		$HL:=New list:C375
		C_TEXT:C284($ListItemName; $CategName; $CategName_j)
		C_LONGINT:C283($ArrayType_L)
		$ArrayType_L:=Type:C295($Arr_ptr->)
		
		For ($i; 1; $ArrSize_L)
			$ListItemName:=""
			Case of 
				: ($ArrayType_L=Date array:K8:20)
					$ListItemName:=String:C10($Arr_ptr->{$i}; Num:C11($OptFormat))  //dates the format is a number
				: (($ArrayType_L=Integer array:K8:18) | ($ArrayType_L=LongInt array:K8:19))
					$ListItemName:=String:C10($Arr_ptr->{$i}; $OptFormat)
				: ($ArrayType_L=String array:K8:15)
					$ListItemName:=$Arr_ptr->{$i}
				: ($ArrayType_L=Text array:K8:16)
					$ListItemName:=Substring:C12($Arr_ptr->{$i}; 1; 255)  //truncate any way
				: ($ArrayType_L=Real array:K8:17)
					$ListItemName:=String:C10($Arr_ptr->{$i}; $OptFormat)
			End case 
			If (($ArrayType_L=String array:K8:15) | ($ArrayType_L=Text array:K8:16))
				If ((Position:C15("("; $ListItemName)>0) & (Substring:C12($ListItemName; Length:C16($ListItemName))=")"))
					$CategName:=Substring:C12($ListItemName; (Position:C15("("; $ListItemName)+1))
					$CategName:=Substring:C12($CategName; 1; (Length:C16($CategName)-1))
					$TempList:=New list:C375
					$ListItemName:=Substring:C12($ListItemName; 1; (Position:C15("("; $ListItemName)-2))
					If ($CustomIndx_b)
						APPEND TO LIST:C376($TempList; $ListItemName; $ArrIndx_ptr->{$i})
					Else 
						APPEND TO LIST:C376($TempList; $ListItemName; $i)
					End if 
					$starti:=$i+1
					For ($j; $starti; $ArrSize_L)
						$i:=$j
						$ListItemName:=Substring:C12($Arr_ptr->{$j}; 1; 255)
						If ((Position:C15("("; $ListItemName)>0) & (Substring:C12($ListItemName; Length:C16($ListItemName))=")"))
							$CategName_j:=Substring:C12($ListItemName; (Position:C15("("; $ListItemName)+1))
							$CategName_j:=Substring:C12($CategName_j; 1; (Length:C16($CategName_j)-1))
						Else 
							$CategName_j:=""
						End if 
						If ($CategName_j=$CategName)
							//same category
							$ListItemName:=Substring:C12($ListItemName; 1; (Position:C15("("; $ListItemName)-2))
							If ($CustomIndx_b)
								APPEND TO LIST:C376($TempList; $ListItemName; $ArrIndx_ptr->{$j})
							Else 
								APPEND TO LIST:C376($TempList; $ListItemName; $j)
							End if 
						Else 
							//new category
							$i:=$j-1  //reset the outside loop
							$j:=$ArrSize_L+1  //exit loop
						End if 
						
					End for 
					APPEND TO LIST:C376($HL; $CategName; 0; $TempList; True:C214)
					$ListItemName:=""  //so nothing gets inserted
				End if 
				
			End if 
			
			If ($ListItemName#"")
				If ($CustomIndx_b)
					APPEND TO LIST:C376($HL; $ListItemName; $ArrIndx_ptr->{$i})
				Else 
					APPEND TO LIST:C376($HL; $ListItemName; $i)
				End if 
				
			End if 
			
		End for 
End case 
If (Is a list:C621($HL))
	$0:=$HL
Else 
	$0:=0
End if 