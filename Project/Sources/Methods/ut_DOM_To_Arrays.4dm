//%attributes = {"invisible":true}
//Method: ut_DOM_To_Arrays
//Description
// Parse an XML Tree to arrays.  Row name is the name of the elements to be parsed;
// pass a pointer to an array that will be filled with the values of the elements;
// pass a pointer to a text array containing the names of attributes to be retrieved
// pass a pointer to an array of pointers that will retrieve the values of the attributes
// Values of elements and attributes will be retrieved based on the type of arrays that need to be filled

// Parameters
// $1 : $Tree_txt
// $2 : $RowNames_txt - name of the elements to be parsed;
// $3 : $RowValArray_ptr - pointer to an array that will be filled with the values of the elements;
// $4 : $AttrNameArray_ptr - pointer to a text array containing the names of attributes to be retrieved
// $5 : $AttrValArrays_ptr - pointer to an array of pointers that will retrieve the values of the attributes
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/09/14, 16:13:45
	// ----------------------------------------------------
	//Created : 
	Mods_2014_10
	//example
	
	//$paramValue_txt:=ut_GetSysParameter ("PON_ELEM_MATERIALS")
	//$PON_ELEM_CATEGORIES_tree:=DOM Parse XML variable($paramValue_txt)
	//ARRAY TEXT($RowValues_atx;0)
	//ARRAY TEXT($AttrNames_atxt;0)
	//APPEND TO ARRAY($AttrNames_atxt;"key")
	//APPEND TO ARRAY($AttrNames_atxt;"name")
	//ARRAY TEXT(PON_MATERIALS_KEY_atxt;0)
	//ARRAY TEXT(PON_MATERIALS_Desc_atxt;0)
	//ARRAY POINTER($AttrValueArrays_aptr;0)
	//APPEND TO ARRAY($AttrValueArrays_aptr;->PON_MATERIALS_KEY_atxt)
	//APPEND TO ARRAY($AttrValueArrays_aptr;->PON_MATERIALS_Desc_atxt)
	//ut_DOM_To_Arrays ($PON_ELEM_CATEGORIES_tree;"Material";->$RowValues_atx;->$AttrNames_atxt;->$AttrValueArrays_aptr)
	
End if 
//
C_TEXT:C284($1)
C_TEXT:C284($2)
C_POINTER:C301($3; $4; $5)

C_TEXT:C284($Tree_txt)
C_TEXT:C284($RowNames_txt)
C_POINTER:C301($RowValArray_ptr; $AttrNameArray_ptr; $AttrValArrays_ptr)

$Tree_txt:=$1
$RowNames_txt:=$2
$RowValArray_ptr:=$3
$AttrNameArray_ptr:=$4
$AttrValArrays_ptr:=$5

C_LONGINT:C283($Elmts_L; $lopp_L; $AttrLoop_L; $loop_L)
C_TEXT:C284($Row_txt; $RowTree_txt)

$Elmts_L:=DOM Count XML elements:C726($Tree_txt; $RowNames_txt)

C_LONGINT:C283($LongV_L)
C_REAL:C285($RealV_r)
C_DATE:C307($DateV_d)
C_TEXT:C284($TextV_txt)
C_BOOLEAN:C305($BoolV_b)
C_LONGINT:C283($ArrayType_L)

$RowTree_txt:=DOM Get first child XML element:C723($Tree_txt)

$ArrayType_L:=Type:C295($RowValArray_ptr->)

Case of 
	: ($ArrayType_L=LongInt array:K8:19)
		DOM GET XML ELEMENT VALUE:C731($RowTree_txt; $LongV_L)
		APPEND TO ARRAY:C911($RowValArray_ptr->; $LongV_L)
		
	: ($ArrayType_L=String array:K8:15) | ($ArrayType_L=Text array:K8:16)
		DOM GET XML ELEMENT VALUE:C731($RowTree_txt; $TextV_txt)
		APPEND TO ARRAY:C911($RowValArray_ptr->; $TextV_txt)
		
	: ($ArrayType_L=Real array:K8:17)
		DOM GET XML ELEMENT VALUE:C731($RowTree_txt; $RealV_r)
		APPEND TO ARRAY:C911($RowValArray_ptr->; $RealV_r)
		
	: ($ArrayType_L=Date array:K8:20)
		DOM GET XML ELEMENT VALUE:C731($RowTree_txt; $DateV_d)
		APPEND TO ARRAY:C911($RowValArray_ptr->; $DateV_d)
		
	: ($ArrayType_L=Boolean array:K8:21)
		DOM GET XML ELEMENT VALUE:C731($RowTree_txt; $BoolV_b)
		APPEND TO ARRAY:C911($RowValArray_ptr->; $BoolV_b)
		
End case 

For ($AttrLoop_L; 1; Size of array:C274($AttrNameArray_ptr->))
	$ArrayType_L:=Type:C295(($AttrValArrays_ptr->{$AttrLoop_L})->)
	
	Case of 
		: ($ArrayType_L=LongInt array:K8:19)
			DOM GET XML ATTRIBUTE BY NAME:C728($RowTree_txt; $AttrNameArray_ptr->{$AttrLoop_L}; $LongV_L)
			APPEND TO ARRAY:C911(($AttrValArrays_ptr->{$AttrLoop_L})->; $LongV_L)
			
		: ($ArrayType_L=String array:K8:15) | ($ArrayType_L=Text array:K8:16)
			DOM GET XML ATTRIBUTE BY NAME:C728($RowTree_txt; $AttrNameArray_ptr->{$AttrLoop_L}; $TextV_txt)
			APPEND TO ARRAY:C911(($AttrValArrays_ptr->{$AttrLoop_L})->; $TextV_txt)
			
		: ($ArrayType_L=Real array:K8:17)
			DOM GET XML ATTRIBUTE BY NAME:C728($RowTree_txt; $AttrNameArray_ptr->{$AttrLoop_L}; $RealV_r)
			APPEND TO ARRAY:C911(($AttrValArrays_ptr->{$AttrLoop_L})->; $RealV_r)
			
		: ($ArrayType_L=Date array:K8:20)
			DOM GET XML ATTRIBUTE BY NAME:C728($RowTree_txt; $AttrNameArray_ptr->{$AttrLoop_L}; $DateV_d)
			APPEND TO ARRAY:C911(($AttrValArrays_ptr->{$AttrLoop_L})->; $DateV_d)
			
		: ($ArrayType_L=Boolean array:K8:21)
			DOM GET XML ATTRIBUTE BY NAME:C728($RowTree_txt; $AttrNameArray_ptr->{$AttrLoop_L}; $BoolV_b)
			APPEND TO ARRAY:C911(($AttrValArrays_ptr->{$AttrLoop_L})->; $BoolV_b)
			
	End case 
	
End for 

For ($loop_L; 2; $Elmts_L)
	$RowTree_txt:=DOM Get next sibling XML element:C724($RowTree_txt)
	$ArrayType_L:=Type:C295($RowValArray_ptr->)
	
	Case of 
		: ($ArrayType_L=LongInt array:K8:19)
			DOM GET XML ELEMENT VALUE:C731($RowTree_txt; $LongV_L)
			APPEND TO ARRAY:C911($RowValArray_ptr->; $LongV_L)
			
		: ($ArrayType_L=String array:K8:15) | ($ArrayType_L=Text array:K8:16)
			DOM GET XML ELEMENT VALUE:C731($RowTree_txt; $TextV_txt)
			APPEND TO ARRAY:C911($RowValArray_ptr->; $TextV_txt)
			
		: ($ArrayType_L=Real array:K8:17)
			DOM GET XML ELEMENT VALUE:C731($RowTree_txt; $RealV_r)
			APPEND TO ARRAY:C911($RowValArray_ptr->; $RealV_r)
			
		: ($ArrayType_L=Date array:K8:20)
			DOM GET XML ELEMENT VALUE:C731($RowTree_txt; $DateV_d)
			APPEND TO ARRAY:C911($RowValArray_ptr->; $DateV_d)
			
		: ($ArrayType_L=Boolean array:K8:21)
			DOM GET XML ELEMENT VALUE:C731($RowTree_txt; $BoolV_b)
			APPEND TO ARRAY:C911($RowValArray_ptr->; $BoolV_b)
			
	End case 
	
	For ($AttrLoop_L; 1; Size of array:C274($AttrNameArray_ptr->))
		$ArrayType_L:=Type:C295(($AttrValArrays_ptr->{$AttrLoop_L})->)
		
		Case of 
			: ($ArrayType_L=LongInt array:K8:19)
				DOM GET XML ATTRIBUTE BY NAME:C728($RowTree_txt; $AttrNameArray_ptr->{$AttrLoop_L}; $LongV_L)
				APPEND TO ARRAY:C911(($AttrValArrays_ptr->{$AttrLoop_L})->; $LongV_L)
				
			: ($ArrayType_L=String array:K8:15) | ($ArrayType_L=Text array:K8:16)
				DOM GET XML ATTRIBUTE BY NAME:C728($RowTree_txt; $AttrNameArray_ptr->{$AttrLoop_L}; $TextV_txt)
				APPEND TO ARRAY:C911(($AttrValArrays_ptr->{$AttrLoop_L})->; $TextV_txt)
				
			: ($ArrayType_L=Real array:K8:17)
				DOM GET XML ATTRIBUTE BY NAME:C728($RowTree_txt; $AttrNameArray_ptr->{$AttrLoop_L}; $RealV_r)
				APPEND TO ARRAY:C911(($AttrValArrays_ptr->{$AttrLoop_L})->; $RealV_r)
				
			: ($ArrayType_L=Date array:K8:20)
				DOM GET XML ATTRIBUTE BY NAME:C728($RowTree_txt; $AttrNameArray_ptr->{$AttrLoop_L}; $DateV_d)
				APPEND TO ARRAY:C911(($AttrValArrays_ptr->{$AttrLoop_L})->; $DateV_d)
				
			: ($ArrayType_L=Boolean array:K8:21)
				DOM GET XML ATTRIBUTE BY NAME:C728($RowTree_txt; $AttrNameArray_ptr->{$AttrLoop_L}; $BoolV_b)
				APPEND TO ARRAY:C911(($AttrValArrays_ptr->{$AttrLoop_L})->; $BoolV_b)
				
		End case 
		
	End for 
	
End for 


//End ut_DOM_To_Arrays