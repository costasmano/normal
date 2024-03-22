//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/20/05, 11:59:23
	// ----------------------------------------------------
	// Method: WKHR_StoreVariables_2
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(12/28/2005 22:42:49)
	Mods_2005_CM21
	// Modified by: costasmanousakis-(Designer)-06/19/08, 08:37:55
	Mods_2008_CM_5403  // ("WKHRS")
	// Modified by: costasmanousakis-(Designer)-(2/9/09 22:52:33)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 12:01:13  ` ("WKHRMODS")
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
	Mods_2012_02  //r002   `Fix bug where resolve pointer not retuning corect data
	//Modified by: Charles Miller (2/9/12 14:43:44)
End if 
C_BLOB:C604($BlobField)
C_POINTER:C301(arrPtr_1; arrPtr_2; arrPtr_3; arrPtr_4)
C_LONGINT:C283($pgno; $vPointerTnum; $vPointerFnum; $i)
C_POINTER:C301($t)
C_BOOLEAN:C305($btOK)
C_TEXT:C284($IndexPrefix; $vsPointername)
For ($pgno; 1; <>WKH_NumPgs)
	CategoryPrefix:=<>a_WKH_Index_Name{$pgNo}
	
	arrPtr_1:=Get pointer:C304("Arr_"+CategoryPrefix+"_1")
	arrPtr_2:=Get pointer:C304("Arr_"+CategoryPrefix+"_2")
	arrPtr_3:=Get pointer:C304("Arr_"+CategoryPrefix+"_Values")
	arrPtr_4:=Get pointer:C304("Arr_"+CategoryPrefix+"_Totals")
	
	If ($pgno=1)
		VARIABLE TO BLOB:C532(arrPtr_1->; $BlobField)
	Else 
		VARIABLE TO BLOB:C532(arrPtr_1->; $BlobField; *)
	End if 
	VARIABLE TO BLOB:C532(arrPtr_2->; $BlobField; *)
	VARIABLE TO BLOB:C532(arrPtr_3->{1}; $BlobField; *)
	VARIABLE TO BLOB:C532(arrPtr_3->{2}; $BlobField; *)
	VARIABLE TO BLOB:C532(arrPtr_3->{3}; $BlobField; *)
	VARIABLE TO BLOB:C532(arrPtr_3->{4}; $BlobField; *)
	VARIABLE TO BLOB:C532(arrPtr_3->{5}; $BlobField; *)
	VARIABLE TO BLOB:C532(arrPtr_3->{6}; $BlobField; *)
	If ([Work_Estimate:103]Version_L:47>0)
		VARIABLE TO BLOB:C532(arrPtr_3->{7}; $BlobField; *)
	End if 
	
	VARIABLE TO BLOB:C532(arrPtr_4->; $BlobField; *)
	
End for 
//Store Category total costs
ARRAY REAL:C219($aPg1Vals; 0)
ARRAY REAL:C219($aPg1Vals; <>WKH_NumPgs)
For ($pgno; 1; <>WKH_NumPgs)
	$IndexPrefix:="item_"+<>a_WKH_Index_Name{$pgNo}+"_totCost"
	$t:=Get pointer:C304($IndexPrefix)  //User defined element description      
	//RESOLVE POINTER($t;$vsPointername;$vPointerTnum;$vPointerFnum)
	//$btOK:=($vsPointername=$IndexPrefix)
	$btOK:=(Type:C295($t->)#5)
	If ($btOK)
		$aPg1Vals{$pgno}:=$t->
	End if 
End for 
VARIABLE TO BLOB:C532($aPg1Vals; $BlobField; *)
//Store Assignement hour Totals
ARRAY REAL:C219($aPg1Vals; 0)
ARRAY REAL:C219($aPg1Vals; (WKHR_CategoryCount_i+1))
For ($i; 1; (WKHR_CategoryCount_i+1))
	$IndexPrefix:="Assgn_Tot_"
	$t:=Get pointer:C304($IndexPrefix+String:C10($i))  //User defined element description      
	//RESOLVE POINTER($t;$vsPointername;$vPointerTnum;$vPointerFnum)
	//$btOK:=($vsPointername=($IndexPrefix+String($i)))
	$btOK:=(Type:C295($t->)#5)
	If ($btOK)
		$aPg1Vals{$i}:=$t->
	End if 
End for 
VARIABLE TO BLOB:C532($aPg1Vals; $BlobField; *)

VARIABLE TO BLOB:C532(Arr_WKHR_MinItemN; $BlobField; *)

VARIABLE TO BLOB:C532(Arr_WKHR_CommentsRef; $BlobField; *)
VARIABLE TO BLOB:C532(Arr_WKHR_Comments; $BlobField; *)
VARIABLE TO BLOB:C532(Arr_WKHR_CommentCat; $BlobField; *)

VARIABLE TO BLOB:C532(Arr_WKHR_ReviewRef; $BlobField; *)
VARIABLE TO BLOB:C532(arr_WKHR_ReviewVal{1}; $BlobField; *)
VARIABLE TO BLOB:C532(arr_WKHR_ReviewVal{2}; $BlobField; *)
VARIABLE TO BLOB:C532(arr_WKHR_ReviewVal{3}; $BlobField; *)
VARIABLE TO BLOB:C532(arr_WKHR_ReviewVal{4}; $BlobField; *)
VARIABLE TO BLOB:C532(arr_WKHR_ReviewVal{5}; $BlobField; *)
VARIABLE TO BLOB:C532(arr_WKHR_ReviewVal{6}; $BlobField; *)
If ([Work_Estimate:103]Version_L:47>0)
	VARIABLE TO BLOB:C532(arr_WKHR_ReviewVal{7}; $BlobField; *)
End if 

VARIABLE TO BLOB:C532(Arr_WKHR_SubItmRef; $BlobField; *)
C_LONGINT:C283($NumSubs)
$NumSubs:=Size of array:C274(Arr_WKHR_SubItmRef)
If ($NumSubs>0)
	For ($i; 1; $NumSubs)
		VARIABLE TO BLOB:C532(Arr_WKHR_SubItmDesc{$i}; $BlobField; *)
		VARIABLE TO BLOB:C532(Arr_WKHR_SubItmVal{$i}; $BlobField; *)
	End for 
End if 

VARIABLE TO BLOB:C532(Arr_WKHR_OfficeEstRef; $BlobField; *)
VARIABLE TO BLOB:C532(arr_WKHR_OfficeEstVal{1}; $BlobField; *)
VARIABLE TO BLOB:C532(arr_WKHR_OfficeEstVal{2}; $BlobField; *)
VARIABLE TO BLOB:C532(arr_WKHR_OfficeEstVal{3}; $BlobField; *)
VARIABLE TO BLOB:C532(arr_WKHR_OfficeEstVal{4}; $BlobField; *)
VARIABLE TO BLOB:C532(arr_WKHR_OfficeEstVal{5}; $BlobField; *)
VARIABLE TO BLOB:C532(arr_WKHR_OfficeEstVal{6}; $BlobField; *)
If ([Work_Estimate:103]Version_L:47>0)
	VARIABLE TO BLOB:C532(arr_WKHR_OfficeEstVal{7}; $BlobField; *)
End if 

VARIABLE TO BLOB:C532(Arr_WKHR_OffEstSubItmRef; $BlobField; *)
C_LONGINT:C283($NumSubs)
$NumSubs:=Size of array:C274(Arr_WKHR_OffEstSubItmRef)
If ($NumSubs>0)
	For ($i; 1; $NumSubs)
		VARIABLE TO BLOB:C532(Arr_WKHR_OffEstSubItmDesc{$i}; $BlobField; *)
		VARIABLE TO BLOB:C532(Arr_WKHR_OffEstSubItmVal{$i}; $BlobField; *)
	End for 
End if 

COMPRESS BLOB:C534($BlobField)
[Work_Estimate:103]WkEstValues:5:=$BlobField
SET BLOB SIZE:C606($BlobField; 0)