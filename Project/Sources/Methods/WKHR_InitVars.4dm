//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 
	// ----------------------------------------------------
	// Method: WKHR_InitVars
	// Description
	// Initialize variables for the Work Hour estimate module
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(11/28/2005 09:08:59)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/3/2005 17:45:31)
	Mods_2005_CM20
	// Modified by: costasmanousakis-(Designer)-(12/28/2005 22:39:02)
	Mods_2005_CM21
	// Modified by: costasmanousakis-(Designer)-(8/20/2007 16:55:00)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(06/19/08, 08:37:55)
	Mods_2008_CM_5403  //("WKHRS")
	// Modified by: costasmanousakis-(Designer)-(1/2/09 16:42:33)
	Mods_2009_CM_5404  //("WKHRSMODS")
	// Modified by: costasmanousakis-(Designer)-(3/20/09 08:38:57)
	Mods_2009_CM_5404  //Copied to Server on : 03/20/09, 08:39:15  ` ("WKHRMODS")  `bug-fix
	//fixed the costrate variables for PIC to be _6 not _7
	//Also added Assgn_Tot_6_pct to avoid runtime error 59 when running the ut_zerobypointer
	
End if 
C_LONGINT:C283(WKHR_ItemColor_WR; WKHR_ItemColor_RO; WKHR_RevColor_WR; WKHR_RevColor_RO; WKHR_SubItmColor_WR; WKHR_SubItmColor_WR)
WKHR_ItemColor_WR:=-(Black:K11:16+(256*((10*16)+1)))
WKHR_ItemColor_RO:=-(Black:K11:16+(256*((15*16)+1)))
WKHR_RevColor_WR:=-(Black:K11:16+(256*((14*16)+0)))
WKHR_RevColor_RO:=-(Red:K11:4+(256*((15*16)+1)))
WKHR_SubItmColor_WR:=-(Black:K11:16+(256*((11*16)+1)))
WKHR_SubItmColor_RO:=-(Black:K11:16+(256*((15*16)+1)))
C_LONGINT:C283(WKHR_LineEntryFormMargin)  //Command Replaced was o_C_INTEGER
WKHR_LineEntryFormMargin:=20
C_LONGINT:C283(WKHR_CategoryCount_i)  //Command Replaced was o_C_INTEGER
WKHR_CategoryCount_i:=6  //******
C_REAL:C285(Assgn_Tot_1; Assgn_Tot_2; Assgn_Tot_3; Assgn_Tot_4; Assgn_Tot_5; Assgn_Tot_6; Assgn_Tot_7; Assgn_Tot_Cost)
ut_ZeroByPointer("Assgn_Tot_$Loop"; 1; (WKHR_CategoryCount_i+1))
C_REAL:C285(Assgn_Tot_1_pct; Assgn_Tot_2_pct; Assgn_Tot_3_pct; Assgn_Tot_4_pct; Assgn_Tot_5_pct; Assgn_Tot_6_pct; Assgn_Tot_7_pct)
ut_ZeroByPointer("Assgn_Tot_$Loop_pct"; 1; (WKHR_CategoryCount_i+1))
C_REAL:C285(Assgn_Des_Salary; Assgn_Des_Indir; Assgn_Des_Net; Assgn_Des_TLF; Assgn_Des_MaxPay; Assgn_Des_MaxObl)
C_REAL:C285(Assgn_Cons_Salary; Assgn_Cons_Indir; Assgn_Cons_Net; Assgn_Cons_TLF; Assgn_Cons_MaxPay; Assgn_Cons_MaxObl)
C_REAL:C285(Assgn_Tot_Salary; Assgn_Tot_Indir; Assgn_Tot_Net; Assgn_Tot_TLF; Assgn_Tot_MaxPay; Assgn_Tot_MaxObl)
C_REAL:C285(IndirCostRate_1; IndirCostRate_2; IndirCostRate_3; IndirCostRate_4; IndirCostRate_5; IndirCostRate_6)
ut_ZeroByPointer("IndirCostRate_$Loop"; 1; WKHR_CategoryCount_i)
C_REAL:C285(NetFeeRate_1; NetFeeRate_2; NetFeeRate_3; NetFeeRate_4; NetFeeRate_5; NetFeeRate_6)
ut_ZeroByPointer("NetFeeRate_$Loop"; 1; WKHR_CategoryCount_i)
C_REAL:C285(TotalFeeRate_1; TotalFeeRate_2; TotalFeeRate_3; TotalFeeRate_4; TotalFeeRate_5; TotalFeeRate_6)
ut_ZeroByPointer("TotalFeeRate_$Loop"; 1; WKHR_CategoryCount_i)
C_REAL:C285(ConstrIndirCostRate_1; ConstrIndirCostRate_2; ConstrIndirCostRate_3; ConstrIndirCostRate_4; ConstrIndirCostRate_5; ConstrIndirCostRate_6)
ut_ZeroByPointer("ConstrIndirCostRate_$Loop"; 1; WKHR_CategoryCount_i)
C_REAL:C285(ConstrNetFeeRate_1; ConstrNetFeeRate_2; ConstrNetFeeRate_3; ConstrNetFeeRate_4; ConstrNetFeeRate_5; ConstrNetFeeRate_6)
ut_ZeroByPointer("ConstrNetFeeRate_$Loop"; 1; WKHR_CategoryCount_i)
C_REAL:C285(ConstrTotalFeeRate_1; ConstrTotalFeeRate_2; ConstrTotalFeeRate_3; ConstrTotalFeeRate_4; ConstrTotalFeeRate_5; ConstrTotalFeeRate_6)
ut_ZeroByPointer("ConstrTotalFeeRate_$Loop"; 1; WKHR_CategoryCount_i)

ARRAY POINTER:C280(RateFldPtr_a; WKHR_CategoryCount_i)
ARRAY POINTER:C280(ConstrRateFldPtr_a; WKHR_CategoryCount_i)

RateFldPtr_a{1}:=->[Work_Estimate:103]Cat1Rate:7
RateFldPtr_a{2}:=->[Work_Estimate:103]Cat2Rate:8
RateFldPtr_a{3}:=->[Work_Estimate:103]Cat3Rate:9
RateFldPtr_a{4}:=->[Work_Estimate:103]Cate4Rate:10
RateFldPtr_a{5}:=->[Work_Estimate:103]Cat5Rate:11
RateFldPtr_a{6}:=->[Work_Estimate:103]Cat6Rate:45
ConstrRateFldPtr_a{1}:=->[Work_Estimate:103]ConstCat1Rate:40
ConstrRateFldPtr_a{2}:=->[Work_Estimate:103]ConstCat2Rate:41
ConstrRateFldPtr_a{3}:=->[Work_Estimate:103]ConstCat3Rate:42
ConstrRateFldPtr_a{4}:=->[Work_Estimate:103]ConstCat4Rate:43
ConstrRateFldPtr_a{5}:=->[Work_Estimate:103]ConstCat5Rate:44
ConstrRateFldPtr_a{6}:=->[Work_Estimate:103]ConstCat6Rate:46
ARRAY LONGINT:C221(WKHR_CatIndx_aL; WKHR_CategoryCount_i)  //array to match Rates to Value arrays
WKHR_CatIndx_aL{1}:=1
WKHR_CatIndx_aL{2}:=2
WKHR_CatIndx_aL{3}:=3
WKHR_CatIndx_aL{4}:=4
WKHR_CatIndx_aL{5}:=5
WKHR_CatIndx_aL{6}:=7

ARRAY REAL:C219(PayRates; WKHR_CategoryCount_i)
ARRAY REAL:C219(ConstrPayRates; WKHR_CategoryCount_i)

C_LONGINT:C283($Wkhr_list; $ItemSubList; $catRef; $ItemRef; $ItemCount)
C_TEXT:C284($ItemTxt)
C_BOOLEAN:C305($sublistExp)

C_TEXT:C284(item_100_T0; item_150_T0; item_200_T0; item_220_T0; item_300_T0; item_350_T0; item_400_T0; item_450_T0; item_500_T0; item_600_T0)
C_TEXT:C284(item_700_T0; item_710_T0; item_750_T0; item_800_T0; item_900_T0)
C_REAL:C285(item_100_totCost; item_150_totCost; item_200_totCost; item_220_totCost; item_300_totCost; item_350_totCost; item_400_totCost; item_450_totCost)
C_REAL:C285(item_500_totCost; item_600_totCost; item_700_totCost; item_710_totCost; item_750_totCost; item_800_totCost; item_900_totCost)

$ItemCount:=0
ARRAY TEXT:C222(Arr_100_1; $ItemCount)  //Item Number
ARRAY TEXT:C222(Arr_100_2; $ItemCount)  //Item description
ARRAY REAL:C219(Arr_100_Values; (WKHR_CategoryCount_i+1); $ItemCount)  //Item Hours
ARRAY REAL:C219(Arr_100_Totals; (WKHR_CategoryCount_i+1))  //Category Totals
C_REAL:C285(Item_100_Tot_1; Item_100_Tot_2; Item_100_Tot_3; Item_100_Tot_4; Item_100_Tot_5; Item_100_Tot_6; Item_100_Tot_7)
ut_ZeroByPointer("Item_100_Tot_$Loop"; 1; (WKHR_CategoryCount_i+1))


ARRAY TEXT:C222(Arr_150_1; $ItemCount)
ARRAY TEXT:C222(Arr_150_2; $ItemCount)
ARRAY REAL:C219(Arr_150_Values; (WKHR_CategoryCount_i+1); $ItemCount)
ARRAY REAL:C219(Arr_150_Totals; (WKHR_CategoryCount_i+1))
C_REAL:C285(Item_150_Tot_1; Item_150_Tot_2; Item_150_Tot_3; Item_150_Tot_4; Item_150_Tot_5; Item_150_Tot_6; Item_150_Tot_7)
ut_ZeroByPointer("Item_150_Tot_$Loop"; 1; (WKHR_CategoryCount_i+1))

ARRAY TEXT:C222(Arr_200_1; $ItemCount)
ARRAY TEXT:C222(Arr_200_2; $ItemCount)
ARRAY REAL:C219(Arr_200_Values; (WKHR_CategoryCount_i+1); $ItemCount)
ARRAY REAL:C219(Arr_200_Totals; (WKHR_CategoryCount_i+1))
C_REAL:C285(Item_200_Tot_1; Item_200_Tot_2; Item_200_Tot_3; Item_200_Tot_4; Item_200_Tot_5; Item_200_Tot_6; Item_200_Tot_7)
ut_ZeroByPointer("Item_200_Tot_$Loop"; 1; (WKHR_CategoryCount_i+1))

ARRAY TEXT:C222(Arr_220_1; $ItemCount)
ARRAY TEXT:C222(Arr_220_2; $ItemCount)
ARRAY REAL:C219(Arr_220_Values; (WKHR_CategoryCount_i+1); $ItemCount)
ARRAY REAL:C219(Arr_220_Totals; (WKHR_CategoryCount_i+1))
C_REAL:C285(Item_220_Tot_1; Item_220_Tot_2; Item_220_Tot_3; Item_220_Tot_4; Item_220_Tot_5; Item_220_Tot_6; Item_220_Tot_7)
ut_ZeroByPointer("Item_220_Tot_$Loop"; 1; (WKHR_CategoryCount_i+1))

ARRAY TEXT:C222(Arr_250_1; $ItemCount)
ARRAY TEXT:C222(Arr_250_2; $ItemCount)
ARRAY REAL:C219(Arr_250_Values; (WKHR_CategoryCount_i+1); $ItemCount)
ARRAY REAL:C219(Arr_250_Totals; (WKHR_CategoryCount_i+1))
C_REAL:C285(Item_250_Tot_1; Item_250_Tot_2; Item_250_Tot_3; Item_250_Tot_4; Item_250_Tot_5; Item_250_Tot_6; Item_250_Tot_7)
ut_ZeroByPointer("Item_250_Tot_$Loop"; 1; (WKHR_CategoryCount_i+1))

ARRAY TEXT:C222(Arr_300_1; $ItemCount)
ARRAY TEXT:C222(Arr_300_2; $ItemCount)
ARRAY REAL:C219(Arr_300_Values; (WKHR_CategoryCount_i+1); $ItemCount)
ARRAY REAL:C219(Arr_300_Totals; (WKHR_CategoryCount_i+1))
C_REAL:C285(Item_300_Tot_1; Item_300_Tot_2; Item_300_Tot_3; Item_300_Tot_4; Item_300_Tot_5; Item_300_Tot_6; Item_300_Tot_7)
ut_ZeroByPointer("Item_300_Tot_$Loop"; 1; (WKHR_CategoryCount_i+1))

ARRAY TEXT:C222(Arr_350_1; $ItemCount)
ARRAY TEXT:C222(Arr_350_2; $ItemCount)
ARRAY REAL:C219(Arr_350_Values; (WKHR_CategoryCount_i+1); $ItemCount)
ARRAY REAL:C219(Arr_350_Totals; (WKHR_CategoryCount_i+1))
C_REAL:C285(Item_350_Tot_1; Item_350_Tot_2; Item_350_Tot_3; Item_350_Tot_4; Item_350_Tot_5; Item_350_Tot_6; Item_350_Tot_7)
ut_ZeroByPointer("Item_350_Tot_$Loop"; 1; (WKHR_CategoryCount_i+1))

ARRAY TEXT:C222(Arr_400_1; $ItemCount)
ARRAY TEXT:C222(Arr_400_2; $ItemCount)
ARRAY REAL:C219(Arr_400_Values; (WKHR_CategoryCount_i+1); $ItemCount)
ARRAY REAL:C219(Arr_400_Totals; (WKHR_CategoryCount_i+1))
C_REAL:C285(Item_400_Tot_1; Item_400_Tot_2; Item_400_Tot_3; Item_400_Tot_4; Item_400_Tot_5; Item_400_Tot_6; Item_400_Tot_7)
ut_ZeroByPointer("Item_400_Tot_$Loop"; 1; (WKHR_CategoryCount_i+1))

ARRAY TEXT:C222(Arr_450_1; $ItemCount)
ARRAY TEXT:C222(Arr_450_2; $ItemCount)
ARRAY REAL:C219(Arr_450_Values; (WKHR_CategoryCount_i+1); $ItemCount)
ARRAY REAL:C219(Arr_450_Totals; (WKHR_CategoryCount_i+1))
C_REAL:C285(Item_450_Tot_1; Item_450_Tot_2; Item_450_Tot_3; Item_450_Tot_4; Item_450_Tot_5; Item_450_Tot_6; Item_450_Tot_7)
ut_ZeroByPointer("Item_450_Tot_$Loop"; 1; (WKHR_CategoryCount_i+1))

ARRAY TEXT:C222(Arr_500_1; $ItemCount)
ARRAY TEXT:C222(Arr_500_2; $ItemCount)
ARRAY REAL:C219(Arr_500_Values; (WKHR_CategoryCount_i+1); $ItemCount)
ARRAY REAL:C219(Arr_500_Totals; (WKHR_CategoryCount_i+1))
C_REAL:C285(Item_500_Tot_1; Item_500_Tot_2; Item_500_Tot_3; Item_500_Tot_4; Item_500_Tot_5; Item_500_Tot_6; Item_500_Tot_7)
ut_ZeroByPointer("Item_500_Tot_$Loop"; 1; (WKHR_CategoryCount_i+1))

ARRAY TEXT:C222(Arr_600_1; $ItemCount)
ARRAY TEXT:C222(Arr_600_2; $ItemCount)
ARRAY REAL:C219(Arr_600_Values; (WKHR_CategoryCount_i+1); $ItemCount)
ARRAY REAL:C219(Arr_600_Totals; (WKHR_CategoryCount_i+1))
C_REAL:C285(Item_600_Tot_1; Item_600_Tot_2; Item_600_Tot_3; Item_600_Tot_4; Item_600_Tot_5; Item_600_Tot_6; Item_600_Tot_7)
ut_ZeroByPointer("Item_600_Tot_$Loop"; 1; (WKHR_CategoryCount_i+1))

ARRAY TEXT:C222(Arr_700_1; $ItemCount)
ARRAY TEXT:C222(Arr_700_2; $ItemCount)
ARRAY REAL:C219(Arr_700_Values; (WKHR_CategoryCount_i+1); $ItemCount)
ARRAY REAL:C219(Arr_700_Totals; (WKHR_CategoryCount_i+1))
C_REAL:C285(Item_700_Tot_1; Item_700_Tot_2; Item_700_Tot_3; Item_700_Tot_4; Item_700_Tot_5; Item_700_Tot_6; Item_700_Tot_7)
ut_ZeroByPointer("Item_700_Tot_$Loop"; 1; (WKHR_CategoryCount_i+1))

ARRAY TEXT:C222(Arr_710_1; $ItemCount)
ARRAY TEXT:C222(Arr_710_2; $ItemCount)
ARRAY REAL:C219(Arr_710_Values; (WKHR_CategoryCount_i+1); $ItemCount)
ARRAY REAL:C219(Arr_710_Totals; (WKHR_CategoryCount_i+1))
C_REAL:C285(Item_710_Tot_1; Item_710_Tot_2; Item_710_Tot_3; Item_710_Tot_4; Item_710_Tot_5; Item_710_Tot_6; Item_710_Tot_7)
ut_ZeroByPointer("Item_710_Tot_$Loop"; 1; (WKHR_CategoryCount_i+1))

ARRAY TEXT:C222(Arr_750_1; $ItemCount)
ARRAY TEXT:C222(Arr_750_2; $ItemCount)
ARRAY REAL:C219(Arr_750_Values; (WKHR_CategoryCount_i+1); $ItemCount)
ARRAY REAL:C219(Arr_750_Totals; (WKHR_CategoryCount_i+1))
C_REAL:C285(Item_750_Tot_1; Item_750_Tot_2; Item_750_Tot_3; Item_750_Tot_4; Item_750_Tot_5; Item_750_Tot_6; Item_750_Tot_7)
ut_ZeroByPointer("Item_750_Tot_$Loop"; 1; (WKHR_CategoryCount_i+1))

ARRAY TEXT:C222(Arr_800_1; $ItemCount)
ARRAY TEXT:C222(Arr_800_2; $ItemCount)
ARRAY REAL:C219(Arr_800_Values; (WKHR_CategoryCount_i+1); $ItemCount)
ARRAY REAL:C219(Arr_800_Totals; (WKHR_CategoryCount_i+1))
C_REAL:C285(Item_800_Tot_1; Item_800_Tot_2; Item_800_Tot_3; Item_800_Tot_4; Item_800_Tot_5; Item_800_Tot_6; Item_800_Tot_7)
ut_ZeroByPointer("Item_800_Tot_$Loop"; 1; (WKHR_CategoryCount_i+1))

ARRAY TEXT:C222(Arr_900_1; $ItemCount)
ARRAY TEXT:C222(Arr_900_2; $ItemCount)
ARRAY REAL:C219(Arr_900_Values; (WKHR_CategoryCount_i+1); $ItemCount)
ARRAY REAL:C219(Arr_900_Totals; (WKHR_CategoryCount_i+1))
C_REAL:C285(Item_900_Tot_1; Item_900_Tot_2; Item_900_Tot_3; Item_900_Tot_4; Item_900_Tot_5; Item_900_Tot_6; Item_900_Tot_7)
ut_ZeroByPointer("Item_900_Tot_$Loop"; 1; (WKHR_CategoryCount_i+1))

//Additional Category to be defined
ARRAY TEXT:C222(Arr_999_1; $ItemCount)
ARRAY TEXT:C222(Arr_999_2; $ItemCount)
ARRAY REAL:C219(Arr_999_Values; (WKHR_CategoryCount_i+1); $ItemCount)
ARRAY REAL:C219(Arr_999_Totals; (WKHR_CategoryCount_i+1))
C_REAL:C285(Item_999_Tot_1; Item_999_Tot_2; Item_999_Tot_3; Item_999_Tot_4; Item_999_Tot_5; Item_999_Tot_6; Item_999_Tot_7)
ut_ZeroByPointer("Item_999_Tot_$Loop"; 1; (WKHR_CategoryCount_i+1))

ARRAY INTEGER:C220(Arr_WKHR_MinItemN; 0)

ARRAY INTEGER:C220(Arr_WKHR_CommentsRef; 0)  //Array containing Item IDs of comments
ARRAY TEXT:C222(Arr_WKHR_Comments; 0)  //Array containing Comments
ARRAY INTEGER:C220(Arr_WKHR_CommentCat; 0)  //Array containing Categories of comments

ARRAY INTEGER:C220(Arr_WKHR_ReviewRef; 0)  //Reviewer values
ARRAY REAL:C219(arr_WKHR_ReviewVal; (WKHR_CategoryCount_i+1); 0)

ARRAY INTEGER:C220(Arr_WKHR_SubItmRef; 0)  //Sub Item breakdowns
ARRAY TEXT:C222(Arr_WKHR_SubItmDesc; 0; 0)
ARRAY REAL:C219(Arr_WKHR_SubItmVal; 0; 0)

ARRAY INTEGER:C220(Arr_WKHR_OfficeEstRef; 0)  //OfficeEst values
ARRAY REAL:C219(arr_WKHR_OfficeEstVal; (WKHR_CategoryCount_i+1); 0)
ARRAY INTEGER:C220(Arr_WKHR_OffEstSubItmRef; 0)  //Sub Item breakdowns
ARRAY TEXT:C222(Arr_WKHR_OffEstSubItmDesc; 0; 0)
ARRAY REAL:C219(Arr_WKHR_OffEstSubItmVal; 0; 0)


C_TEXT:C284(CategoryPrefix)  // Command Replaced was o_C_STRING length was 3
CategoryPrefix:=""
C_BLOB:C604($RestrictedList_Blob)
$RestrictedList_Blob:=[Work_Estimate:103]RestrictedItemList:32
ARRAY INTEGER:C220(Arr_WKHR_RestrictedItems_I; 0)
ARRAY INTEGER:C220(Arr_WKHR_RestrictedSubItms_I; 0)

If (BLOB size:C605($RestrictedList_Blob)>0)
	C_LONGINT:C283($v_compressed_i)  //Command Replaced was o_C_INTEGER
	BLOB PROPERTIES:C536($RestrictedList_Blob; $v_compressed_i)
	If ($v_compressed_i#0)
		EXPAND BLOB:C535($RestrictedList_Blob)
	End if 
	C_LONGINT:C283($offset)
	$offset:=0
	BLOB TO VARIABLE:C533($RestrictedList_Blob; Arr_WKHR_RestrictedItems_I; $offset)
	BLOB TO VARIABLE:C533($RestrictedList_Blob; Arr_WKHR_RestrictedSubItms_I; $offset)
Else 
	
End if 
SET BLOB SIZE:C606($RestrictedList_Blob; 0)

C_LONGINT:C283(AllCategories_HL)  //check to see if all arrays are initialized
//If (Not(Is a list(AllCategories_HL)))
//End if 
WKHR_InitConfigArrays  //do this always

WKHR_SetUpCategPullDwn

ARRAY TEXT:C222(OfficeEstItm_Ctrld; 2)
OfficeEstItm_Ctrld{1}:="Engineer's Proposal"
OfficeEstItm_Ctrld{2}:="Office Estimate"

WKHR_PageTitles:=1

C_BOOLEAN:C305(WKHR_AllowRevieCmts_b)
WKHR_AllowRevieCmts_b:=False:C215  //Mods_2007_CM12_5301