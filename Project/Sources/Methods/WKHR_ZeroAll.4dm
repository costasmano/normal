//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/08/05, 12:17:46
	// ----------------------------------------------------
	// Method: WKHR_ZeroAll
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(12/5/2005 10:56:24)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/28/2005 22:16:12)
	Mods_2005_CM21
	// Modified by: costasmanousakis-(Designer)-(12/3/07 11:05:55)
	Mods_2007_CM_5401  //use role variables
	// Modified by: costasmanousakis-(Designer)-06/19/08, 08:37:55
	Mods_2008_CM_5403  // ("WKHRS")
	// Modified by: costasmanousakis-(Designer)-(2/9/09 20:29:05)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 11:59:03  ` ("WKHRMODS")
	// Modified by: costasmanousakis-(Designer)-(4/6/11 08:26:45)
	Mods_2011_04
	//  `Added call to ut_CollapseList to make sure the List is collapsed - Fix for the v11 transition
	Mods_2012_02  //r002   `Fix bug where resolve pointer not retuning corect data
	//Modified by: Charles Miller (2/9/12 14:43:44)
End if 
//Initialize all page Variables
C_TEXT:C284($IndexPrefix; $ItemTxt; $vsPointername; $ItemText_txt)
C_POINTER:C301($arr_1_ptr; $arr_2_ptr; $arr_3_ptr; $arr_4_ptr)
C_POINTER:C301($textVar_ptr; $t)
C_LONGINT:C283($pgno; $i; $Wkhr_list; $ItemSubList; $catRef; $ItemCount; $ic; $ItemRef; $vPointerTnum; $vPointerFnum; $ItemRef_L)
C_BOOLEAN:C305($btOK; $sublistExp)

$Wkhr_list:=Load list:C383(WKHR_ItmListName_txt)
ut_CollapseList(->$Wkhr_list)
For ($i; 1; <>WKH_NumPgs)
	SELECT LIST ITEMS BY POSITION:C381($Wkhr_list; $i)
	GET LIST ITEM:C378($Wkhr_list; $i; $catRef; $ItemTxt; $ItemSubList; $sublistExp)
	$textVar_ptr:=Get pointer:C304("item_"+<>a_WKH_Index_Name{$i}+"_T0")
	$textVar_ptr->:=<>a_WKH_Index_Name{$i}+" - "+$ItemTxt
	$ItemCount:=<>a_WKH_NumRows{$i}
	$arr_1_ptr:=Get pointer:C304("Arr_"+String:C10($catRef)+"_1")
	ARRAY TEXT:C222($arr_1_ptr->; $ItemCount)
	$arr_2_ptr:=Get pointer:C304("Arr_"+String:C10($catRef)+"_2")
	ARRAY TEXT:C222($arr_2_ptr->; $ItemCount)
	$arr_3_ptr:=Get pointer:C304("Arr_"+String:C10($catRef)+"_Values")
	ARRAY REAL:C219($arr_3_ptr->; (WKHR_CategoryCount_i+1); 0)
	ARRAY REAL:C219($arr_3_ptr->; (WKHR_CategoryCount_i+1); $ItemCount)
	$arr_4_ptr:=Get pointer:C304("Arr_"+String:C10($catRef)+"_Totals")
	ARRAY REAL:C219($arr_4_ptr->; 0)
	ARRAY REAL:C219($arr_4_ptr->; (WKHR_CategoryCount_i+1))
	
	For ($ic; 1; $ItemCount)
		GET LIST ITEM:C378($ItemSubList; $ic; $ItemRef; $ItemTxt)
		$arr_1_ptr->{$ic}:=String:C10($ItemRef)
		$arr_2_ptr->{$ic}:=$ItemTxt
	End for 
	
End for 

COPY ARRAY:C226(<>a_WKH_NumRows; Arr_WKHR_MinItemN)

CLEAR LIST:C377($Wkhr_list; *)

//Zero total Costs
For ($pgno; 1; <>WKH_NumPgs)
	$IndexPrefix:="item_"+<>a_WKH_Index_Name{$pgNo}+"_totCost"
	$t:=Get pointer:C304($IndexPrefix)  //User defined element description      
	//RESOLVE POINTER($t;$vsPointername;$vPointerTnum;$vPointerFnum)
	//$btOK:=($vsPointername=$IndexPrefix)
	$btOK:=(Type:C295($t->)#5)
	If ($btOK)
		$t->:=0
	End if 
End for 
//Zero total sums
$IndexPrefix:="Assgn_Tot_"
For ($i; 1; (WKHR_CategoryCount_i+1))
	$t:=Get pointer:C304($IndexPrefix+String:C10($i))  //User defined element description      
	//RESOLVE POINTER($t;$vsPointername;$vPointerTnum;$vPointerFnum)
	//$btOK:=($vsPointername=($IndexPrefix+String($i)))
	$btOK:=(Type:C295($t->)#5)
	If ($btOK)
		$t->:=0
	End if 
End for 
//Clear all comments
ARRAY INTEGER:C220(Arr_WKHR_CommentsRef; 0)  //Array containing Item IDs of comments
ARRAY TEXT:C222(Arr_WKHR_Comments; 0)  //Array containing Comments
ARRAY INTEGER:C220(Arr_WKHR_CommentCat; 0)  //Array containing Categories of comments

If (WKHR_RoleReview_b & WKHR_RoleApprove_b)
	ARRAY INTEGER:C220(Arr_WKHR_ReviewRef; 0)  //Reviewer values only if reviewer
	ARRAY REAL:C219(arr_WKHR_ReviewVal; (WKHR_CategoryCount_i+1); 0)
End if 
ARRAY INTEGER:C220(Arr_WKHR_SubItmRef; 0)  //Sub Item breakdowns
ARRAY TEXT:C222(Arr_WKHR_SubItmDesc; 0; 0)
ARRAY REAL:C219(Arr_WKHR_SubItmVal; 0; 0)

If (WKHR_OfficeEstEdit_b)
	ARRAY INTEGER:C220(Arr_WKHR_OfficeEstRef; 0)  //OfficeEst values
	ARRAY REAL:C219(arr_WKHR_OfficeEstVal; (WKHR_CategoryCount_i+1); 0)
	ARRAY INTEGER:C220(Arr_WKHR_OffEstSubItmRef; 0)  //Sub Item breakdowns
	ARRAY TEXT:C222(Arr_WKHR_OffEstSubItmDesc; 0; 0)
	ARRAY REAL:C219(Arr_WKHR_OffEstSubItmVal; 0; 0)
End if 