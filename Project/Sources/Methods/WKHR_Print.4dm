//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/21/05, 20:14:14
	// ----------------------------------------------------
	// Method: WKHR_Print
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(12/2/2005 15:13:20)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/2/2005 19:58:43)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/20/2005 15:29:49)
	Mods_2005_CM20
	// Modified by: costasmanousakis-(Designer)-(12/28/2005 22:40:13)
	Mods_2005_CM21
	// Modified by: costasmanousakis-(Designer)-(12/5/07 10:00:24)
	Mods_2007_CM_5401  //Additions to print subitems. SubItems are printed in smaller font by
	//  `  `  ` ` setting the printed value to negative
	// Modified by: costasmanousakis-(Designer)-06/19/08, 08:37:55
	Mods_2008_CM_5403  // ("WKHRS")
	//  `Added office estimate printing
	//  `Also when CMD key  (mac) or CTRL key (win), print just the blank form
	// Modified by: costasmanousakis-(Designer)-(3/18/09 08:20:54)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 12:04:14  ` ("WKHRMODS")
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_BOOLEAN:C305(WKHR_PrintBlank_b)
If (Macintosh command down:C546 | Windows Ctrl down:C562)
	WKHR_PrintBlank_b:=True:C214
Else 
	WKHR_PrintBlank_b:=False:C215
End if 

PRINT SETTINGS:C106
If (OK=1)
	C_TEXT:C284($catRef)  // Command Replaced was o_C_STRING length was 8
	C_LONGINT:C283($pgno; $NumItems; $ItemNo)
	C_REAL:C285($PrintRowHt; $PrintHt; $PrintWd; $PrintedHt)
	GET PRINTABLE AREA:C703($PrintHt; $PrintWd)
	C_TEXT:C284($SummForm_txt; $DetForm_txt)
	If ([Work_Estimate:103]Version_L:47>0)
		$SummForm_txt:="Print4"
		$DetForm_txt:="Print3"
	Else 
		$SummForm_txt:="Print4_V0"
		$DetForm_txt:="Print3_V0"
	End if 
	
	If (Not:C34(WKHR_PrintBlank_b))
		$PrintRowHt:=Print form:C5([Work_Estimate:103]; $SummForm_txt; Form detail:K43:1)
		PAGE BREAK:C6(>)
	End if 
	
	C_POINTER:C301(CatTitle_ptr; arrPtr_1; arrPtr_2; arrPtr_3; arrPtr_4)
	C_TEXT:C284(Item_Title)
	C_REAL:C285(Item_S1; Item_S2; Item_S3; Item_S4; Item_S5; Item_S6)
	C_REAL:C285(CatSum_1; CatSum_2; CatSum_3; CatSum_4; CatSum_5; CatSum_6)
	C_TEXT:C284(vWKHR_Add_SubReview)
	vWKHR_Add_SubReview:=""
	$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form header:K43:3)
	For ($pgno; 1; <>WKH_NumPgs)
		$catRef:=<>a_WKH_Index_Name{$pgno}
		CatTitle_ptr:=Get pointer:C304("Item_"+$catRef+"_T0")
		Category_title:=CatTitle_ptr->
		arrPtr_1:=Get pointer:C304("Arr_"+$catRef+"_1")
		arrPtr_2:=Get pointer:C304("Arr_"+$catRef+"_2")
		arrPtr_3:=Get pointer:C304("Arr_"+$catRef+"_Values")
		arrPtr_4:=Get pointer:C304("Arr_"+$catRef+"_Totals")
		C_LONGINT:C283($PosInRevCmts_L; $NumRevCmts_L; $RevCmtHt_L; $PosInOfficeEst_L)
		C_BOOLEAN:C305($ShowOffEst_b)
		$PosInRevCmts_L:=Find in array:C230(Arr_WKHR_ReviewRef; Num:C11($catRef))
		$PosInOfficeEst_L:=Find in array:C230(Arr_WKHR_OfficeEstRef; Num:C11($catRef))
		$ShowOffEst_b:=(($PosInOfficeEst_L>0) & (WKHR_OfficeEstEdit_b | WKHR_OfficeEstView_b))
		If (((arrPtr_4->{6})>0) | ($PosInRevCmts_L>0) | $ShowOffEst_b | WKHR_PrintBlank_b)
			$NumItems:=Size of array:C274(arrPtr_1->)
			$NumRevCmts_L:=0
			$RevCmtHt_L:=0
			C_LONGINT:C283($numSubBrkdwn)
			$numSubBrkdwn:=0
			For ($itemNo; 1; $NumItems)
				$PosInRevCmts_L:=Find in array:C230(Arr_WKHR_ReviewRef; Num:C11((arrPtr_1->{$ItemNo})))
				If ($PosInRevCmts_L>0)
					$NumRevCmts_L:=$NumRevCmts_L+1
				End if 
				$RevCmtHt_L:=1  //Set to one -used to calc print ht
				C_LONGINT:C283($SubItmIndx)
				$SubItmIndx:=Find in array:C230(Arr_WKHR_SubItmRef; Num:C11((arrPtr_1->{$ItemNo})))
				If ($SubItmIndx>0)
					$numSubBrkdwn:=$numSubBrkdwn+Size of array:C274(Arr_WKHR_SubItmDesc{$SubItmIndx})
				End if 
				
			End for 
			$PrintedHt:=Get printed height:C702
			If (($PrintedHt+(($NumItems+$NumRevCmts_L+$numSubBrkdwn)*16)+24+((1+$RevCmtHt_L)*19))>$PrintHt)
				PAGE BREAK:C6(>)
				$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form header:K43:3)
			End if 
			$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form header1:K43:4)
			For ($ItemNo; 1; $NumItems)
				Item_title:=(arrPtr_1->{$ItemNo})+" - "+(arrPtr_2->{$ItemNo})
				Item_S1:=(arrPtr_3->{1}{$ItemNo})
				Item_S2:=(arrPtr_3->{2}{$ItemNo})
				Item_S3:=(arrPtr_3->{3}{$ItemNo})
				Item_S4:=(arrPtr_3->{4}{$ItemNo})
				Item_S5:=(arrPtr_3->{5}{$ItemNo})
				Item_S6:=(arrPtr_3->{6}{$ItemNo})
				If ([Work_Estimate:103]Version_L:47=1)
					Item_S7:=(arrPtr_3->{7}{$ItemNo})
				Else 
					Item_S7:=0
				End if 
				
				$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form detail:K43:1)
				$PrintedHt:=Get printed height:C702
				If (($PrintedHt+$PrintRowHt)>$PrintHt)
					PAGE BREAK:C6(>)
					$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form header:K43:3)
					Category_title:=Category_title+" (Cont.)"
					$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form header1:K43:4)
				End if 
				$SubItmIndx:=Find in array:C230(Arr_WKHR_SubItmRef; Num:C11((arrPtr_1->{$ItemNo})))
				If ($SubItmIndx>0)
					$numSubBrkdwn:=Size of array:C274(Arr_WKHR_SubItmDesc{$SubItmIndx})
					C_POINTER:C301($var_ptr)
					C_LONGINT:C283($i_sub; $i_subv)
					For ($i_sub; 1; $numSubBrkdwn)
						Item_title:=(arrPtr_1->{$ItemNo})+"."+String:C10($i_sub)+" - "+Arr_WKHR_SubItmDesc{$SubItmIndx}{$i_sub}
						For ($i_subv; 1; (WKHR_CategoryCount_i+1))
							$var_ptr:=Get pointer:C304("Item_S"+String:C10($i_subv))
							$var_ptr->:=-(Arr_WKHR_SubItmVal{$SubItmIndx}{(($i_sub-1)*(WKHR_CategoryCount_i+1)+$i_subv)})
						End for 
						$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form detail:K43:1)
						$PrintedHt:=Get printed height:C702
						If (($PrintedHt+$PrintRowHt)>$PrintHt)
							PAGE BREAK:C6(>)
							$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form header:K43:3)
							Category_title:=Category_title+" (Cont.)"
							$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form header1:K43:4)
						End if 
						
					End for 
				End if 
				
				If (Not:C34(WKHR_PrintBlank_b))
					$PosInRevCmts_L:=Find in array:C230(Arr_WKHR_ReviewRef; Num:C11((arrPtr_1->{$ItemNo})))
					If ($PosInRevCmts_L>0)
						Item_title:=(arrPtr_1->{$ItemNo})+"----->Reviewer Edits"
						Item_S1:=(arr_WKHR_ReviewVal{1}{$PosInRevCmts_L})
						Item_S2:=(arr_WKHR_ReviewVal{2}{$PosInRevCmts_L})
						Item_S3:=(arr_WKHR_ReviewVal{3}{$PosInRevCmts_L})
						Item_S4:=(arr_WKHR_ReviewVal{4}{$PosInRevCmts_L})
						Item_S5:=(arr_WKHR_ReviewVal{5}{$PosInRevCmts_L})
						Item_S6:=(arr_WKHR_ReviewVal{6}{$PosInRevCmts_L})
						If ([Work_Estimate:103]Version_L:47=1)
							Item_S7:=(arr_WKHR_ReviewVal{7}{$PosInRevCmts_L})
						Else 
							Item_S7:=0
						End if 
						
						$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form detail:K43:1)
						$PrintedHt:=Get printed height:C702
						If (($PrintedHt+$PrintRowHt)>$PrintHt)
							PAGE BREAK:C6(>)
							$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form header:K43:3)
							Category_title:=Category_title+" (Cont.)"
							$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form header1:K43:4)
						End if 
					End if 
					If ($ShowOffEst_b)
						$PosInRevCmts_L:=Find in array:C230(Arr_WKHR_OfficeEstRef; Num:C11((arrPtr_1->{$ItemNo})))
						If ($PosInRevCmts_L>0)
							Item_title:=(arrPtr_1->{$ItemNo})+"----->Office Estimate"
							Item_S1:=(arr_WKHR_OfficeEstVal{1}{$PosInRevCmts_L})
							Item_S2:=(arr_WKHR_OfficeEstVal{2}{$PosInRevCmts_L})
							Item_S3:=(arr_WKHR_OfficeEstVal{3}{$PosInRevCmts_L})
							Item_S4:=(arr_WKHR_OfficeEstVal{4}{$PosInRevCmts_L})
							Item_S5:=(arr_WKHR_OfficeEstVal{5}{$PosInRevCmts_L})
							Item_S6:=(arr_WKHR_OfficeEstVal{6}{$PosInRevCmts_L})
							If ([Work_Estimate:103]Version_L:47=1)
								Item_S7:=(arr_WKHR_OfficeEstVal{7}{$PosInRevCmts_L})
							Else 
								Item_S7:=0
							End if 
							$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form detail:K43:1)
							$PrintedHt:=Get printed height:C702
							If (($PrintedHt+$PrintRowHt)>$PrintHt)
								PAGE BREAK:C6(>)
								$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form header:K43:3)
								Category_title:=Category_title+" (Cont.)"
								$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form header1:K43:4)
							End if 
						End if 
						
					End if 
					
				End if 
				
			End for 
			vWKHR_Add_SubReview:=""
			CatSum_1:=(arrPtr_4->{1})
			CatSum_2:=(arrPtr_4->{2})
			CatSum_3:=(arrPtr_4->{3})
			CatSum_4:=(arrPtr_4->{4})
			CatSum_5:=(arrPtr_4->{5})
			CatSum_6:=(arrPtr_4->{6})
			If ([Work_Estimate:103]Version_L:47=1)
				CatSum_7:=(arrPtr_4->{7})
			Else 
				CatSum_7:=0
			End if 
			$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form break0:K43:14)
			$PrintedHt:=Get printed height:C702
			If (($PrintedHt+$PrintRowHt)>$PrintHt)
				PAGE BREAK:C6(>)
				$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form header:K43:3)
				Category_title:=Category_title+" (Cont.)"
				$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form header1:K43:4)
			End if 
			If (Not:C34(WKHR_PrintBlank_b))
				$PosInRevCmts_L:=Find in array:C230(Arr_WKHR_ReviewRef; Num:C11($catRef))
				If ($PosInRevCmts_L>0)
					vWKHR_Add_SubReview:="----->Reviewer Edits "
					CatSum_1:=(arr_WKHR_ReviewVal{1}{$PosInRevCmts_L})
					CatSum_2:=(arr_WKHR_ReviewVal{2}{$PosInRevCmts_L})
					CatSum_3:=(arr_WKHR_ReviewVal{3}{$PosInRevCmts_L})
					CatSum_4:=(arr_WKHR_ReviewVal{4}{$PosInRevCmts_L})
					CatSum_5:=(arr_WKHR_ReviewVal{5}{$PosInRevCmts_L})
					CatSum_6:=(arr_WKHR_ReviewVal{6}{$PosInRevCmts_L})
					If ([Work_Estimate:103]Version_L:47=1)
						CatSum_7:=(arr_WKHR_ReviewVal{7}{$PosInRevCmts_L})
					Else 
						CatSum_7:=0
					End if 
					$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form break0:K43:14)
					$PrintedHt:=Get printed height:C702
					If (($PrintedHt+$PrintRowHt)>$PrintHt)
						PAGE BREAK:C6(>)
						$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form header:K43:3)
						Category_title:=Category_title+" (Cont.)"
						$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form header1:K43:4)
					End if 
				End if 
				If ($ShowOffEst_b)
					$PosInRevCmts_L:=Find in array:C230(Arr_WKHR_OfficeEstRef; Num:C11($catRef))
					If ($PosInRevCmts_L>0)
						vWKHR_Add_SubReview:="----->Office Estimate "
						CatSum_1:=(arr_WKHR_OfficeEstVal{1}{$PosInRevCmts_L})
						CatSum_2:=(arr_WKHR_OfficeEstVal{2}{$PosInRevCmts_L})
						CatSum_3:=(arr_WKHR_OfficeEstVal{3}{$PosInRevCmts_L})
						CatSum_4:=(arr_WKHR_OfficeEstVal{4}{$PosInRevCmts_L})
						CatSum_5:=(arr_WKHR_OfficeEstVal{5}{$PosInRevCmts_L})
						CatSum_6:=(arr_WKHR_OfficeEstVal{6}{$PosInRevCmts_L})
						If ([Work_Estimate:103]Version_L:47=1)
							CatSum_7:=(arr_WKHR_OfficeEstVal{7}{$PosInRevCmts_L})
						Else 
							CatSum_7:=0
						End if 
						$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form break0:K43:14)
						$PrintedHt:=Get printed height:C702
						If (($PrintedHt+$PrintRowHt)>$PrintHt)
							PAGE BREAK:C6(>)
							$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form header:K43:3)
							Category_title:=Category_title+" (Cont.)"
							$PrintRowHt:=Print form:C5([Work_Estimate:103]; $DetForm_txt; Form header1:K43:4)
						End if 
					End if 
					
				End if 
				
			End if 
			
		End if 
	End for 
	
	If (Not:C34(WKHR_PrintBlank_b))
		C_LONGINT:C283($NumberCmmts)  //Command Replaced was o_C_INTEGER
		$NumberCmmts:=Size of array:C274(Arr_WKHR_CommentsRef)
		If ($NumberCmmts>0)
			PAGE BREAK:C6(>)
			C_TEXT:C284(vPrintArea_S)  // Command Replaced was o_C_STRING length was 8
			vPrintArea_S:="Header"
			$PrintRowHt:=Print form:C5([Work_Estimate:103]; "PrintCmts"; Form header:K43:3)
			SORT ARRAY:C229(Arr_WKHR_CommentsRef; Arr_WKHR_Comments; Arr_WKHR_CommentCat)
			C_LONGINT:C283($i; $ItemID)
			For ($i; 1; $NumberCmmts)
				ItemCmmts_Txt:=Arr_WKHR_Comments{$i}
				Line_ItemNo:=String:C10(Arr_WKHR_CommentsRef{$i})
				$catRef:=String:C10(Arr_WKHR_CommentCat{$i})
				arrPtr_1:=Get pointer:C304("Arr_"+$catRef+"_1")
				arrPtr_2:=Get pointer:C304("Arr_"+$catRef+"_2")
				$ItemID:=Find in array:C230(arrPtr_1->; Line_ItemNo)
				LineDesc_Text:=arrPtr_2->{$ItemID}
				vPrintArea_S:="Detail"
				$PrintRowHt:=Print form:C5([Work_Estimate:103]; "PrintCmts"; Form detail:K43:1)
				If (OK=0)
					PAGE BREAK:C6(>)
					vPrintArea_S:="Header"
					$PrintRowHt:=Print form:C5([Work_Estimate:103]; "PrintCmts"; Form header:K43:3)
					vPrintArea_S:="Detail"
					$PrintRowHt:=Print form:C5([Work_Estimate:103]; "PrintCmts"; Form detail:K43:1)
				End if 
			End for 
		End if 
		If (Size of array:C274(Arr_WKHR_ReviewRef)>0)
			C_TEXT:C284(vWKHR_Add_Title)
			WKHR_CalcReviewTotals
			PAGE BREAK:C6(>)
			vWKHR_Add_Title:="- Reviewers Corrections"
			$PrintRowHt:=Print form:C5([Work_Estimate:103]; $SummForm_txt; Form detail:K43:1)
			WKHR_CalcTotals  //calc values again
			vWKHR_Add_Title:=""
		End if 
		If ((Size of array:C274(Arr_WKHR_OfficeEstRef)>0) & (WKHR_OfficeEstEdit_b | WKHR_OfficeEstView_b))
			C_TEXT:C284(vWKHR_Add_Title)
			WKHR_CalcOffEstTotals
			PAGE BREAK:C6(>)
			vWKHR_Add_Title:="- Office Estimate"
			$PrintRowHt:=Print form:C5([Work_Estimate:103]; $SummForm_txt; Form detail:K43:1)
			WKHR_CalcTotals  //calc values again
			vWKHR_Add_Title:=""
		End if 
		
	End if 
	PAGE BREAK:C6
End if 