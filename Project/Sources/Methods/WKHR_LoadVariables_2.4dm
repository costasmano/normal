//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/20/05, 12:05:17
	// ----------------------------------------------------
	// Method: WKHR_LoadVariables_2
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(12/28/2005 22:39:50)
	Mods_2005_CM21
	// Modified by: costasmanousakis-(Designer)-` Date and time: 06/19/08, 08:45:35
	Mods_2008_CM_5403  // ("WKHRS")
	// Modified by: costasmanousakis-(Designer)-(3/19/09 16:44:21)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 16:44:47  ` ("WKHRMODS")
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
	Mods_2012_02  //r002   `Fix bug where resolve pointer not retuning corect data
	//Modified by: Charles Miller (2/9/12 14:43:44)
End if 
C_BLOB:C604($BlobField)
$BlobField:=[Work_Estimate:103]WkEstValues:5
If ([Work_Estimate:103]Version_L:47=0)
	WKHR_CategoryCount_i:=WKHR_CategoryCount_i-1
End if 

C_POINTER:C301(arrPtr_1; arrPtr_2; arrPtr_3; arrPtr_4)

If (BLOB size:C605($BlobField)>0)
	C_LONGINT:C283($v_compressed_i)  //Command Replaced was o_C_INTEGER
	BLOB PROPERTIES:C536($BlobField; $v_compressed_i)
	If ($v_compressed_i#0)
		EXPAND BLOB:C535($BlobField)
	End if 
	C_LONGINT:C283($offset; $i; $vPointerTnum; $vPointerFnum; $pgNo)
	C_POINTER:C301($t)
	C_BOOLEAN:C305($btOK)
	C_TEXT:C284($IndexPrefix; $vsPointername)  // Command Replaced was o_C_STRING length was 40
	$offset:=0
	For ($pgNo; 1; <>WKH_NumPgs)
		CategoryPrefix:=<>a_WKH_Index_Name{$pgNo}
		
		arrPtr_1:=Get pointer:C304("Arr_"+CategoryPrefix+"_1")
		arrPtr_2:=Get pointer:C304("Arr_"+CategoryPrefix+"_2")
		arrPtr_3:=Get pointer:C304("Arr_"+CategoryPrefix+"_Values")
		arrPtr_4:=Get pointer:C304("Arr_"+CategoryPrefix+"_Totals")
		
		BLOB TO VARIABLE:C533($BlobField; arrPtr_1->; $offset)
		BLOB TO VARIABLE:C533($BlobField; arrPtr_2->; $offset)
		BLOB TO VARIABLE:C533($BlobField; arrPtr_3->{1}; $offset)
		BLOB TO VARIABLE:C533($BlobField; arrPtr_3->{2}; $offset)
		BLOB TO VARIABLE:C533($BlobField; arrPtr_3->{3}; $offset)
		BLOB TO VARIABLE:C533($BlobField; arrPtr_3->{4}; $offset)
		BLOB TO VARIABLE:C533($BlobField; arrPtr_3->{5}; $offset)
		BLOB TO VARIABLE:C533($BlobField; arrPtr_3->{6}; $offset)
		If ([Work_Estimate:103]Version_L:47>0)
			BLOB TO VARIABLE:C533($BlobField; arrPtr_3->{7}; $offset)
		Else 
			ARRAY REAL:C219(arrPtr_3->{7}; Size of array:C274(arrPtr_3->{6}))
		End if 
		BLOB TO VARIABLE:C533($BlobField; arrPtr_4->; $offset)
		//If ([Work_Estimate]Version_L=0)
		//ARRAY REAL(arrPtr_4->;(WKHR_CategoryCount_i+1))
		//End if 
		
	End for 
	//Load total Costs
	ARRAY REAL:C219($aPg1Vals; 0)
	BLOB TO VARIABLE:C533($BlobField; $aPg1Vals; $offset)
	If (Size of array:C274($aPg1Vals)=<>WKH_NumPgs)
		For ($pgNo; 1; <>WKH_NumPgs)
			$IndexPrefix:="item_"+<>a_WKH_Index_Name{$pgNo}+"_totCost"
			$t:=Get pointer:C304($IndexPrefix)  //User defined element description      
			//RESOLVE POINTER($t;$vsPointername;$vPointerTnum;$vPointerFnum)
			$btOK:=(Type:C295($t->)#5)
			//$btOK:=($vsPointername=$IndexPrefix)
			If ($btOK)
				$t->:=$aPg1Vals{$pgNo}
			End if 
		End for 
	End if 
	//Load Assignement Total hrs
	ARRAY REAL:C219($aPg1Vals; 0)
	BLOB TO VARIABLE:C533($BlobField; $aPg1Vals; $offset)
	If (Size of array:C274($aPg1Vals)=(WKHR_CategoryCount_i+1))
		For ($i; 1; (WKHR_CategoryCount_i+1))
			$IndexPrefix:="Assgn_Tot_"
			$t:=Get pointer:C304($IndexPrefix+String:C10($i))  //User defined element description      
			//RESOLVE POINTER($t;$vsPointername;$vPointerTnum;$vPointerFnum)
			//$btOK:=($vsPointername=($IndexPrefix+String($i)))
			$btOK:=(Type:C295($t->)#5)
			If ($btOK)
				$t->:=$aPg1Vals{$i}
			End if 
		End for 
	End if 
	
	BLOB TO VARIABLE:C533($BlobField; Arr_WKHR_MinItemN; $offset)
	
	BLOB TO VARIABLE:C533($BlobField; Arr_WKHR_CommentsRef; $offset)
	BLOB TO VARIABLE:C533($BlobField; Arr_WKHR_Comments; $offset)
	BLOB TO VARIABLE:C533($BlobField; Arr_WKHR_CommentCat; $offset)
	
	BLOB TO VARIABLE:C533($BlobField; Arr_WKHR_ReviewRef; $offset)  //Reviewer Edits
	BLOB TO VARIABLE:C533($BlobField; arr_WKHR_ReviewVal{1}; $offset)
	BLOB TO VARIABLE:C533($BlobField; arr_WKHR_ReviewVal{2}; $offset)
	BLOB TO VARIABLE:C533($BlobField; arr_WKHR_ReviewVal{3}; $offset)
	BLOB TO VARIABLE:C533($BlobField; arr_WKHR_ReviewVal{4}; $offset)
	BLOB TO VARIABLE:C533($BlobField; arr_WKHR_ReviewVal{5}; $offset)
	BLOB TO VARIABLE:C533($BlobField; arr_WKHR_ReviewVal{6}; $offset)
	If ([Work_Estimate:103]Version_L:47>0)
		BLOB TO VARIABLE:C533($BlobField; arr_WKHR_ReviewVal{7}; $offset)
	Else 
		ARRAY REAL:C219(arr_WKHR_ReviewVal{7}; Size of array:C274(arr_WKHR_ReviewVal{6}))
	End if 
	
	BLOB TO VARIABLE:C533($BlobField; Arr_WKHR_SubItmRef; $offset)  //SubItem breakdowns
	C_LONGINT:C283($NumSubs)
	$NumSubs:=Size of array:C274(Arr_WKHR_SubItmRef)
	If ($NumSubs>0)
		ARRAY TEXT:C222(Arr_WKHR_SubItmDesc; $NumSubs; 0)
		ARRAY REAL:C219(Arr_WKHR_SubItmVal; $NumSubs; 0)
		For ($i; 1; $NumSubs)
			BLOB TO VARIABLE:C533($BlobField; Arr_WKHR_SubItmDesc{$i}; $offset)
			BLOB TO VARIABLE:C533($BlobField; Arr_WKHR_SubItmVal{$i}; $offset)
		End for 
	End if 
	
	BLOB TO VARIABLE:C533($BlobField; Arr_WKHR_OfficeEstRef; $offset)  //OfficeEst 
	BLOB TO VARIABLE:C533($BlobField; arr_WKHR_OfficeEstVal{1}; $offset)
	BLOB TO VARIABLE:C533($BlobField; arr_WKHR_OfficeEstVal{2}; $offset)
	BLOB TO VARIABLE:C533($BlobField; arr_WKHR_OfficeEstVal{3}; $offset)
	BLOB TO VARIABLE:C533($BlobField; arr_WKHR_OfficeEstVal{4}; $offset)
	BLOB TO VARIABLE:C533($BlobField; arr_WKHR_OfficeEstVal{5}; $offset)
	BLOB TO VARIABLE:C533($BlobField; arr_WKHR_OfficeEstVal{6}; $offset)
	If ([Work_Estimate:103]Version_L:47>0)
		BLOB TO VARIABLE:C533($BlobField; arr_WKHR_OfficeEstVal{7}; $offset)
	Else 
		ARRAY REAL:C219(arr_WKHR_OfficeEstVal{7}; Size of array:C274(arr_WKHR_OfficeEstVal{6}))
	End if 
	
	BLOB TO VARIABLE:C533($BlobField; Arr_WKHR_OffEstSubItmRef; $offset)  //SubItem breakdowns
	C_LONGINT:C283($NumSubs)
	$NumSubs:=Size of array:C274(Arr_WKHR_OffEstSubItmRef)
	If ($NumSubs>0)
		ARRAY TEXT:C222(Arr_WKHR_OffEstSubItmDesc; $NumSubs; 0)
		ARRAY REAL:C219(Arr_WKHR_OffEstSubItmVal; $NumSubs; 0)
		For ($i; 1; $NumSubs)
			BLOB TO VARIABLE:C533($BlobField; Arr_WKHR_OffEstSubItmDesc{$i}; $offset)
			BLOB TO VARIABLE:C533($BlobField; Arr_WKHR_OffEstSubItmVal{$i}; $offset)
		End for 
	End if 
	
Else 
	//if a blank blob
	WKHR_ZeroAll
End if 

SET BLOB SIZE:C606($BlobField; 0)