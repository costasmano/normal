//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/17/08, 22:03:21
	// ----------------------------------------------------
	// Method: WKHR_StoreOrigEngEst
	// Description
	// Initialize/store/retrieve the original estimate
	// 
	// Parameters
	// $1 : $Task ("STORE";"LOAD";"INIT")
	
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(1/4/09 20:58:04)
	Mods_2009_CM_5404  //("WKHRMODS")
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

C_BLOB:C604($BlobField)
C_POINTER:C301(arrPtr_1; arrPtr_2; arrPtr_3; arrPtr_4)
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
C_LONGINT:C283($pgno)
Case of 
	: ($Task_txt="STORE")
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
		
		VARIABLE TO BLOB:C532(Arr_WKHR_SubItmRef; $BlobField; *)
		C_LONGINT:C283($NumSubs)
		$NumSubs:=Size of array:C274(Arr_WKHR_SubItmRef)
		If ($NumSubs>0)
			For ($i; 1; $NumSubs)
				VARIABLE TO BLOB:C532(Arr_WKHR_SubItmDesc{$i}; $BlobField; *)
				VARIABLE TO BLOB:C532(Arr_WKHR_SubItmVal{$i}; $BlobField; *)
			End for 
		End if 
		
		COMPRESS BLOB:C534($BlobField)
		[Work_Estimate:103]WkOrigEngEstVal_x:39:=$BlobField
		PushChange(1; ->[Work_Estimate:103]WkOrigEngEstVal_x:39)
		
	: ($Task_txt="LOAD")
		C_BLOB:C604($BlobField)
		$BlobField:=[Work_Estimate:103]WkOrigEngEstVal_x:39
		C_POINTER:C301(arrPtr_1; arrPtr_2; arrPtr_3; arrPtr_4)
		
		If (BLOB size:C605($BlobField)>0)
			C_LONGINT:C283($v_compressed_i)  //Command Replaced was o_C_INTEGER
			BLOB PROPERTIES:C536($BlobField; $v_compressed_i)
			If ($v_compressed_i#0)
				EXPAND BLOB:C535($BlobField)
			End if 
			C_LONGINT:C283($offset; $i; $vPointerTnum; $vPointerFnum)
			C_POINTER:C301($t)
			C_BOOLEAN:C305($btOK)
			C_TEXT:C284($IndexPrefix; $vsPointername)  // Command Replaced was o_C_STRING length was 40
			$offset:=0
			For ($pgNo; 1; <>WKH_NumPgs)
				CategoryPrefix:=<>a_WKH_Index_Name{$pgNo}
				
				arrPtr_1:=Get pointer:C304("Arr0_"+CategoryPrefix+"_1")
				arrPtr_2:=Get pointer:C304("Arr0_"+CategoryPrefix+"_2")
				arrPtr_3:=Get pointer:C304("Arr0_"+CategoryPrefix+"_Values")
				arrPtr_4:=Get pointer:C304("Arr0_"+CategoryPrefix+"_Totals")
				
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
				End if 
				
				BLOB TO VARIABLE:C533($BlobField; arrPtr_4->; $offset)
				If ([Work_Estimate:103]Version_L:47>0)
					ARRAY REAL:C219(arrPtr_4->; (WKHR_CategoryCount_i+1))
				End if 
				
			End for 
			//Load total Costs
			ARRAY REAL:C219($aPg1Vals; 0)
			BLOB TO VARIABLE:C533($BlobField; $aPg1Vals; $offset)
			If (Size of array:C274($aPg1Vals)=<>WKH_NumPgs)
				For ($pgNo; 1; <>WKH_NumPgs)
					$IndexPrefix:="item0_"+<>a_WKH_Index_Name{$pgNo}+"_totCost"
					$t:=Get pointer:C304($IndexPrefix)  //User defined element description      
					//RESOLVE POINTER($t;$vsPointername;$vPointerTnum;$vPointerFnum)
					//$btOK:=($vsPointername=$IndexPrefix)
					$btOK:=(Type:C295($t->)#5)
					If ($btOK)
						$t->:=$aPg1Vals{$pgNo}
					End if 
				End for 
			End if 
			//Load Assignement Total hrs
			ARRAY REAL:C219($aPg1Vals; 0)
			BLOB TO VARIABLE:C533($BlobField; $aPg1Vals; $offset)
			If (Size of array:C274($aPg1Vals)=6)
				For ($i; 1; (WKHR_CategoryCount_i+1))
					$IndexPrefix:="Assgn0_Tot_"
					$t:=Get pointer:C304($IndexPrefix+String:C10($i))  //User defined element description      
					//RESOLVE POINTER($t;$vsPointername;$vPointerTnum;$vPointerFnum)
					//$btOK:=($vsPointername=($IndexPrefix+String($i)))
					$btOK:=(Type:C295($t->)#5)
					If ($btOK)
						$t->:=$aPg1Vals{$i}
					End if 
				End for 
			End if 
			
			BLOB TO VARIABLE:C533($BlobField; Arr0_WKHR_MinItemN; $offset)
			
			BLOB TO VARIABLE:C533($BlobField; Arr0_WKHR_CommentsRef; $offset)
			BLOB TO VARIABLE:C533($BlobField; Arr0_WKHR_Comments; $offset)
			BLOB TO VARIABLE:C533($BlobField; Arr0_WKHR_CommentCat; $offset)
			
			BLOB TO VARIABLE:C533($BlobField; Arr0_WKHR_SubItmRef; $offset)  //SubItem breakdowns
			C_LONGINT:C283($NumSubs)
			$NumSubs:=Size of array:C274(Arr0_WKHR_SubItmRef)
			If ($NumSubs>0)
				ARRAY TEXT:C222(Arr0_WKHR_SubItmDesc; $NumSubs; 0)
				ARRAY REAL:C219(Arr0_WKHR_SubItmVal; $NumSubs; 0)
				For ($i; 1; $NumSubs)
					BLOB TO VARIABLE:C533($BlobField; Arr0_WKHR_SubItmDesc{$i}; $offset)
					BLOB TO VARIABLE:C533($BlobField; Arr0_WKHR_SubItmVal{$i}; $offset)
				End for 
			End if 
			
		End if 
		
	: ($Task_txt="INIT")
		
		C_REAL:C285(Assgn0_Tot_1; Assgn0_Tot_2; Assgn0_Tot_3; Assgn0_Tot_4; Assgn0_Tot_5; Assgn0_Tot_6; Assgn0_Tot_Cost; Assgn0_Tot_7)
		C_REAL:C285(Assgn0_Tot_1_pct; Assgn0_Tot_2_pct; Assgn0_Tot_3_pct; Assgn0_Tot_4_pct; Assgn0_Tot_5_pct; Assgn0_Tot_6_pct)
		C_REAL:C285(Assgn0_Des_Salary; Assgn0_Des_Indir; Assgn0_Des_Net; Assgn0_Des_TLF; Assgn0_Des_MaxPay; Assgn0_Des_MaxObl)
		C_REAL:C285(Assgn0_Cons_Salary; Assgn0_Cons_Indir; Assgn0_Cons_Net; Assgn0_Cons_TLF; Assgn0_Cons_MaxPay; Assgn0_Cons_MaxObl)
		C_REAL:C285(Assgn0_Tot_Salary; Assgn0_Tot_Indir; Assgn0_Tot_Net; Assgn0_Tot_TLF; Assgn0_Tot_MaxPay; Assgn0_Tot_MaxObl)
		
		C_LONGINT:C283($Wkhr_list; $ItemSubList; $catRef; $ItemRef; $ItemCount)
		C_TEXT:C284($ItemTxt)
		C_BOOLEAN:C305($sublistExp)
		
		C_TEXT:C284(Item0_100_T0; Item0_150_T0; Item0_200_T0; Item0_220_T0; Item0_300_T0; Item0_350_T0; Item0_400_T0; Item0_450_T0; Item0_500_T0; Item0_600_T0)
		C_TEXT:C284(Item0_700_T0; Item0_710_T0; Item0_750_T0; Item0_800_T0; Item0_900_T0)
		C_REAL:C285(Item0_100_totCost; Item0_150_totCost; Item0_200_totCost; Item0_220_totCost; Item0_300_totCost; Item0_350_totCost; Item0_400_totCost; Item0_450_totCost)
		C_REAL:C285(Item0_500_totCost; Item0_600_totCost; Item0_700_totCost; Item0_710_totCost; Item0_750_totCost; Item0_800_totCost; Item0_900_totCost)
		
		$ItemCount:=0
		ARRAY TEXT:C222(Arr0_100_1; $ItemCount)  //Item Number
		ARRAY TEXT:C222(Arr0_100_2; $ItemCount)  //Item description
		ARRAY REAL:C219(Arr0_100_Values; (WKHR_CategoryCount_i+1); $ItemCount)  //Item Hours
		ARRAY REAL:C219(Arr0_100_Totals; 0)  //Category Totals
		ARRAY REAL:C219(Arr0_100_Totals; (WKHR_CategoryCount_i+1))  //Category Totals
		C_REAL:C285(Item0_100_Tot_1; Item0_100_Tot_2; Item0_100_Tot_3; Item0_100_Tot_4; Item0_100_Tot_5; Item0_100_Tot_6)
		
		ARRAY TEXT:C222(Arr0_150_1; $ItemCount)
		ARRAY TEXT:C222(Arr0_150_2; $ItemCount)
		ARRAY REAL:C219(Arr0_150_Values; (WKHR_CategoryCount_i+1); $ItemCount)
		ARRAY REAL:C219(Arr0_150_Totals; 0)
		ARRAY REAL:C219(Arr0_150_Totals; (WKHR_CategoryCount_i+1))
		C_REAL:C285(Item0_150_Tot_1; Item0_150_Tot_2; Item0_150_Tot_3; Item0_150_Tot_4; Item0_150_Tot_5; Item0_150_Tot_6)
		
		ARRAY TEXT:C222(Arr0_200_1; $ItemCount)
		ARRAY TEXT:C222(Arr0_200_2; $ItemCount)
		ARRAY REAL:C219(Arr0_200_Values; (WKHR_CategoryCount_i+1); $ItemCount)
		ARRAY REAL:C219(Arr0_200_Totals; 0)
		ARRAY REAL:C219(Arr0_200_Totals; (WKHR_CategoryCount_i+1))
		C_REAL:C285(Item0_200_Tot_1; Item0_200_Tot_2; Item0_200_Tot_3; Item0_200_Tot_4; Item0_200_Tot_5; Item0_200_Tot_6)
		
		ARRAY TEXT:C222(Arr0_220_1; $ItemCount)
		ARRAY TEXT:C222(Arr0_220_2; $ItemCount)
		ARRAY REAL:C219(Arr0_220_Values; (WKHR_CategoryCount_i+1); $ItemCount)
		ARRAY REAL:C219(Arr0_220_Totals; 0)
		ARRAY REAL:C219(Arr0_220_Totals; (WKHR_CategoryCount_i+1))
		C_REAL:C285(Item0_220_Tot_1; Item0_220_Tot_2; Item0_220_Tot_3; Item0_220_Tot_4; Item0_220_Tot_5; Item0_220_Tot_6)
		
		ARRAY TEXT:C222(Arr0_250_1; $ItemCount)
		ARRAY TEXT:C222(Arr0_250_2; $ItemCount)
		ARRAY REAL:C219(Arr0_250_Values; (WKHR_CategoryCount_i+1); $ItemCount)
		ARRAY REAL:C219(Arr0_250_Totals; 0)
		ARRAY REAL:C219(Arr0_250_Totals; (WKHR_CategoryCount_i+1))
		C_REAL:C285(Item0_250_Tot_1; Item0_250_Tot_2; Item0_250_Tot_3; Item0_250_Tot_4; Item0_250_Tot_5; Item0_250_Tot_6)
		
		ARRAY TEXT:C222(Arr0_300_1; $ItemCount)
		ARRAY TEXT:C222(Arr0_300_2; $ItemCount)
		ARRAY REAL:C219(Arr0_300_Values; (WKHR_CategoryCount_i+1); $ItemCount)
		ARRAY REAL:C219(Arr0_300_Totals; 0)
		ARRAY REAL:C219(Arr0_300_Totals; (WKHR_CategoryCount_i+1))
		C_REAL:C285(Item0_300_Tot_1; Item0_300_Tot_2; Item0_300_Tot_3; Item0_300_Tot_4; Item0_300_Tot_5; Item0_300_Tot_6)
		
		ARRAY TEXT:C222(Arr0_350_1; $ItemCount)
		ARRAY TEXT:C222(Arr0_350_2; $ItemCount)
		ARRAY REAL:C219(Arr0_350_Values; (WKHR_CategoryCount_i+1); $ItemCount)
		ARRAY REAL:C219(Arr0_350_Totals; 0)
		ARRAY REAL:C219(Arr0_350_Totals; (WKHR_CategoryCount_i+1))
		C_REAL:C285(Item0_350_Tot_1; Item0_350_Tot_2; Item0_350_Tot_3; Item0_350_Tot_4; Item0_350_Tot_5; Item0_350_Tot_6)
		
		ARRAY TEXT:C222(Arr0_400_1; $ItemCount)
		ARRAY TEXT:C222(Arr0_400_2; $ItemCount)
		ARRAY REAL:C219(Arr0_400_Values; (WKHR_CategoryCount_i+1); $ItemCount)
		ARRAY REAL:C219(Arr0_400_Totals; 0)
		ARRAY REAL:C219(Arr0_400_Totals; (WKHR_CategoryCount_i+1))
		C_REAL:C285(Item0_400_Tot_1; Item0_400_Tot_2; Item0_400_Tot_3; Item0_400_Tot_4; Item0_400_Tot_5; Item0_400_Tot_6)
		
		ARRAY TEXT:C222(Arr0_450_1; $ItemCount)
		ARRAY TEXT:C222(Arr0_450_2; $ItemCount)
		ARRAY REAL:C219(Arr0_450_Values; (WKHR_CategoryCount_i+1); $ItemCount)
		ARRAY REAL:C219(Arr0_450_Totals; 0)
		ARRAY REAL:C219(Arr0_450_Totals; (WKHR_CategoryCount_i+1))
		C_REAL:C285(Item0_450_Tot_1; Item0_450_Tot_2; Item0_450_Tot_3; Item0_450_Tot_4; Item0_450_Tot_5; Item0_450_Tot_6)
		
		ARRAY TEXT:C222(Arr0_500_1; $ItemCount)
		ARRAY TEXT:C222(Arr0_500_2; $ItemCount)
		ARRAY REAL:C219(Arr0_500_Values; (WKHR_CategoryCount_i+1); $ItemCount)
		ARRAY REAL:C219(Arr0_500_Totals; 0)
		ARRAY REAL:C219(Arr0_500_Totals; (WKHR_CategoryCount_i+1))
		C_REAL:C285(Item0_500_Tot_1; Item0_500_Tot_2; Item0_500_Tot_3; Item0_500_Tot_4; Item0_500_Tot_5; Item0_500_Tot_6)
		
		ARRAY TEXT:C222(Arr0_600_1; $ItemCount)
		ARRAY TEXT:C222(Arr0_600_2; $ItemCount)
		ARRAY REAL:C219(Arr0_600_Values; (WKHR_CategoryCount_i+1); $ItemCount)
		ARRAY REAL:C219(Arr0_600_Totals; 0)
		ARRAY REAL:C219(Arr0_600_Totals; (WKHR_CategoryCount_i+1))
		C_REAL:C285(Item0_600_Tot_1; Item0_600_Tot_2; Item0_600_Tot_3; Item0_600_Tot_4; Item0_600_Tot_5; Item0_600_Tot_6)
		
		ARRAY TEXT:C222(Arr0_700_1; $ItemCount)
		ARRAY TEXT:C222(Arr0_700_2; $ItemCount)
		ARRAY REAL:C219(Arr0_700_Values; (WKHR_CategoryCount_i+1); $ItemCount)
		ARRAY REAL:C219(Arr0_700_Totals; 0)
		ARRAY REAL:C219(Arr0_700_Totals; (WKHR_CategoryCount_i+1))
		C_REAL:C285(Item0_700_Tot_1; Item0_700_Tot_2; Item0_700_Tot_3; Item0_700_Tot_4; Item0_700_Tot_5; Item0_700_Tot_6)
		
		ARRAY TEXT:C222(Arr0_710_1; $ItemCount)
		ARRAY TEXT:C222(Arr0_710_2; $ItemCount)
		ARRAY REAL:C219(Arr0_710_Values; (WKHR_CategoryCount_i+1); $ItemCount)
		ARRAY REAL:C219(Arr0_710_Totals; 0)
		ARRAY REAL:C219(Arr0_710_Totals; (WKHR_CategoryCount_i+1))
		C_REAL:C285(Item0_710_Tot_1; Item0_710_Tot_2; Item0_710_Tot_3; Item0_710_Tot_4; Item0_710_Tot_5; Item0_710_Tot_6)
		
		ARRAY TEXT:C222(Arr0_750_1; $ItemCount)
		ARRAY TEXT:C222(Arr0_750_2; $ItemCount)
		ARRAY REAL:C219(Arr0_750_Values; (WKHR_CategoryCount_i+1); $ItemCount)
		ARRAY REAL:C219(Arr0_750_Totals; 0)
		ARRAY REAL:C219(Arr0_750_Totals; (WKHR_CategoryCount_i+1))
		C_REAL:C285(Item0_750_Tot_1; Item0_750_Tot_2; Item0_750_Tot_3; Item0_750_Tot_4; Item0_750_Tot_5; Item0_750_Tot_6)
		
		ARRAY TEXT:C222(Arr0_800_1; $ItemCount)
		ARRAY TEXT:C222(Arr0_800_2; $ItemCount)
		ARRAY REAL:C219(Arr0_800_Values; (WKHR_CategoryCount_i+1); $ItemCount)
		ARRAY REAL:C219(Arr0_800_Totals; 0)
		ARRAY REAL:C219(Arr0_800_Totals; (WKHR_CategoryCount_i+1))
		C_REAL:C285(Item0_800_Tot_1; Item0_800_Tot_2; Item0_800_Tot_3; Item0_800_Tot_4; Item0_800_Tot_5; Item0_800_Tot_6)
		
		ARRAY TEXT:C222(Arr0_900_1; $ItemCount)
		ARRAY TEXT:C222(Arr0_900_2; $ItemCount)
		ARRAY REAL:C219(Arr0_900_Values; (WKHR_CategoryCount_i+1); $ItemCount)
		ARRAY REAL:C219(Arr0_900_Totals; 0)
		ARRAY REAL:C219(Arr0_900_Totals; (WKHR_CategoryCount_i+1))
		C_REAL:C285(Item0_900_Tot_1; Item0_900_Tot_2; Item0_900_Tot_3; Item0_900_Tot_4; Item0_900_Tot_5; Item0_900_Tot_6)
		
		//Additional Category to be defined
		ARRAY TEXT:C222(Arr0_999_1; $ItemCount)
		ARRAY TEXT:C222(Arr0_999_2; $ItemCount)
		ARRAY REAL:C219(Arr0_999_Values; (WKHR_CategoryCount_i+1); $ItemCount)
		ARRAY REAL:C219(Arr0_999_Totals; 0)
		ARRAY REAL:C219(Arr0_999_Totals; (WKHR_CategoryCount_i+1))
		C_REAL:C285(Item0_999_Tot_1; Item0_999_Tot_2; Item0_999_Tot_3; Item0_999_Tot_4; Item0_999_Tot_5; Item0_999_Tot_6)
		
		ARRAY INTEGER:C220(Arr0_WKHR_MinItemN; 0)
		
		ARRAY INTEGER:C220(Arr0_WKHR_CommentsRef; 0)  //Array containing Item IDs of comments
		ARRAY TEXT:C222(Arr0_WKHR_Comments; 0)  //Array containing Comments
		ARRAY INTEGER:C220(Arr0_WKHR_CommentCat; 0)  //Array containing Categories of comments
		
		ARRAY INTEGER:C220(Arr0_WKHR_SubItmRef; 0)  //Sub Item breakdowns
		ARRAY TEXT:C222(Arr0_WKHR_SubItmDesc; 0; 0)
		ARRAY REAL:C219(Arr0_WKHR_SubItmVal; 0; 0)
		
End case 

SET BLOB SIZE:C606($BlobField; 0)