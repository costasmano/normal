//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/28/05, 09:47:11
	// ----------------------------------------------------
	// Method: WKHR_StoreVariables
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
	Mods_2012_02  //r002   `Fix bug where resolve pointer not retuning corect data
	//Modified by: Charles Miller (2/9/12 14:43:44)
End if 
C_BLOB:C604($BlobField)
C_LONGINT:C283($pgno; $NumVars; $i; $vPointerTnum; $vPointerFnum)
C_TEXT:C284($IndexPrefix; $vsPointername)
C_POINTER:C301($t)
C_BOOLEAN:C305($btOK)
For ($pgno; 1; <>WKH_NumPgs)
	$IndexPrefix:="item_"+<>a_WKH_Index_Name{$pgNo}+"_S"
	$NumVars:=(6*<>a_WKH_NumRows{$pgNo})
	ARRAY REAL:C219($aPg1Vals; 0)
	ARRAY REAL:C219($aPg1Vals; $NumVars)
	For ($i; 1; $NumVars)
		$t:=Get pointer:C304($IndexPrefix+String:C10($i))  //User defined element description      
		//RESOLVE POINTER($t;$vsPointername;$vPointerTnum;$vPointerFnum)
		//$btOK:=($vsPointername=($IndexPrefix+String($i)))
		$btOK:=(Type:C295($t->)#5)
		If ($btOK)
			$aPg1Vals{$i}:=$t->
		End if 
	End for 
	If ($pgno=1)
		VARIABLE TO BLOB:C532($aPg1Vals; $BlobField)
	Else 
		VARIABLE TO BLOB:C532($aPg1Vals; $BlobField; *)
	End if 
End for 
//Store Item total costs
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
ARRAY REAL:C219($aPg1Vals; 6)
For ($i; 1; 6)
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

COMPRESS BLOB:C534($BlobField)
[Work_Estimate:103]WkEstValues:5:=$BlobField