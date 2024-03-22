//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/01/09, 18:00:24
	// ----------------------------------------------------
	// Method: WKHR_LoadLineItem
	// Description
	// Tasks for loading line items
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_CM_5404  // ("WKHRSMODS")
End if 
C_LONGINT:C283($1; $ItemIndex; $i; $CurrBrkdns)
$ItemIndex:=$1
C_TEXT:C284($2; $Task)
$Task:=$2
C_LONGINT:C283($CommentIndx; $RevItmIndx; $OfficeItmIndx; $SubItmIndx; $OffEstSubItmIndx)
C_POINTER:C301($var_ptr)
C_LONGINT:C283($i_sub; $i_subv)
Line_ItemNo:=arrPtr_1->{$itemIndex}
$CommentIndx:=Find in array:C230(Arr_WKHR_CommentsRef; Num:C11(Line_ItemNo))
$RevItmIndx:=Find in array:C230(Arr_WKHR_ReviewRef; Num:C11(Line_ItemNo))
$OfficeItmIndx:=Find in array:C230(Arr_WKHR_OfficeEstRef; Num:C11(Line_ItemNo))
$SubItmIndx:=Find in array:C230(Arr_WKHR_SubItmRef; Num:C11(Line_ItemNo))
$OffEstSubItmIndx:=Find in array:C230(Arr_WKHR_OffEstSubItmRef; Num:C11(Line_ItemNo))
Case of 
	: ($Task="LOAD")
		LineDesc_Text:=arrPtr_2->{$itemIndex}
		wkHr_Real_1:=arrPtr_3->{1}{$itemIndex}
		wkHr_Real_2:=arrPtr_3->{2}{$itemIndex}
		wkHr_Real_3:=arrPtr_3->{3}{$itemIndex}
		wkHr_Real_4:=arrPtr_3->{4}{$itemIndex}
		wkHr_Real_5:=arrPtr_3->{5}{$itemIndex}
		wkHr_Real_6:=arrPtr_3->{6}{$itemIndex}
		If ([Work_Estimate:103]Version_L:47>0)
			wkHr_Real_7:=arrPtr_3->{7}{$itemIndex}
		Else 
			wkHr_Real_7:=0
		End if 
		WKHR_EditLineItem:=($ItemIndex>WKHR_MaxItemNo)
		
		If ($CommentIndx>0)
			ItemCmmts_Txt:=Arr_WKHR_Comments{$CommentIndx}
		Else 
			ItemCmmts_Txt:=""
		End if 
		If ($RevItmIndx>0)
			ReviewItm_1:=arr_WKHR_ReviewVal{1}{$RevItmIndx}
			ReviewItm_2:=arr_WKHR_ReviewVal{2}{$RevItmIndx}
			ReviewItm_3:=arr_WKHR_ReviewVal{3}{$RevItmIndx}
			ReviewItm_4:=arr_WKHR_ReviewVal{4}{$RevItmIndx}
			ReviewItm_5:=arr_WKHR_ReviewVal{5}{$RevItmIndx}
			ReviewItm_6:=arr_WKHR_ReviewVal{6}{$RevItmIndx}
			If ([Work_Estimate:103]Version_L:47>0)
				ReviewItm_7:=arr_WKHR_ReviewVal{7}{$RevItmIndx}
			Else 
				ReviewItm_7:=0
			End if 
		End if 
		
		If ($OfficeItmIndx>0)
			OfficeEstItm_1:=arr_WKHR_OfficeEstVal{1}{$OfficeItmIndx}
			OfficeEstItm_2:=arr_WKHR_OfficeEstVal{2}{$OfficeItmIndx}
			OfficeEstItm_3:=arr_WKHR_OfficeEstVal{3}{$OfficeItmIndx}
			OfficeEstItm_4:=arr_WKHR_OfficeEstVal{4}{$OfficeItmIndx}
			OfficeEstItm_5:=arr_WKHR_OfficeEstVal{5}{$OfficeItmIndx}
			OfficeEstItm_6:=arr_WKHR_OfficeEstVal{6}{$OfficeItmIndx}
			If ([Work_Estimate:103]Version_L:47>0)
				OfficeEstItm_7:=arr_WKHR_OfficeEstVal{7}{$OfficeItmIndx}
			Else 
				OfficeEstItm_7:=0
			End if 
		End if 
		
		If ($SubItmIndx>0)
			C_LONGINT:C283($numSubBrkdwn)
			$numSubBrkdwn:=Size of array:C274(Arr_WKHR_SubItmDesc{$SubItmIndx})
			WKHR_SubItemCount:=MinNum($numSubBrkdwn; WKHR_MaxNumSubBreakDwn)
			For ($i_sub; 1; WKHR_SubItemCount)
				$var_ptr:=Get pointer:C304("SubItDsc_"+String:C10($i_sub))
				$var_ptr->:=Arr_WKHR_SubItmDesc{$SubItmIndx}{$i_sub}
				For ($i_subv; 1; (WKHR_CategoryCount_i+1))
					$var_ptr:=Get pointer:C304("SubItmV"+String:C10($i_sub)+"_"+String:C10($i_subv))
					$var_ptr->:=Arr_WKHR_SubItmVal{$SubItmIndx}{(($i_sub-1)*(WKHR_CategoryCount_i+1)+$i_subv)}
				End for 
			End for 
		End if 
		
		If ($OffEstSubItmIndx>0)
			C_LONGINT:C283($numSubBrkdwn)
			$numSubBrkdwn:=Size of array:C274(Arr_WKHR_OffEstSubItmDesc{$OffEstSubItmIndx})
			WKHR_OffEstSubItemCount:=MinNum($numSubBrkdwn; WKHR_MaxNumSubBreakDwn)
			For ($i_sub; 1; WKHR_OffEstSubItemCount)
				$var_ptr:=Get pointer:C304("OffEstSubItDsc_"+String:C10($i_sub))
				$var_ptr->:=Arr_WKHR_OffEstSubItmDesc{$OffEstSubItmIndx}{$i_sub}
				For ($i_subv; 1; (WKHR_CategoryCount_i+1))
					$var_ptr:=Get pointer:C304("OffEstSubItmV"+String:C10($i_sub)+"_"+String:C10($i_subv))
					$var_ptr->:=Arr_WKHR_OffEstSubItmVal{$OffEstSubItmIndx}{(($i_sub-1)*(WKHR_CategoryCount_i+1)+$i_subv)}
				End for 
			End for 
		End if 
		
	: ($Task="SAVE")
		arrPtr_2->{$itemIndex}:=LineDesc_Text
		arrPtr_3->{1}{$itemIndex}:=wkHr_Real_1
		arrPtr_3->{2}{$itemIndex}:=wkHr_Real_2
		arrPtr_3->{3}{$itemIndex}:=wkHr_Real_3
		arrPtr_3->{4}{$itemIndex}:=wkHr_Real_4
		arrPtr_3->{5}{$itemIndex}:=wkHr_Real_5
		arrPtr_3->{6}{$itemIndex}:=wkHr_Real_6
		If ([Work_Estimate:103]Version_L:47>0)
			arrPtr_3->{7}{$itemIndex}:=wkHr_Real_7
		End if 
		ItemCmmts_Txt:=f_TrimStr(ItemCmmts_Txt; True:C214; True:C214)
		If (Length:C16(ItemCmmts_Txt)>0)
			If ($CommentIndx>0)
				Arr_WKHR_Comments{$CommentIndx}:=ItemCmmts_Txt
			Else 
				INSERT IN ARRAY:C227(Arr_WKHR_CommentsRef; 1; 1)
				INSERT IN ARRAY:C227(Arr_WKHR_Comments; 1; 1)
				INSERT IN ARRAY:C227(Arr_WKHR_CommentCat; 1; 1)
				Arr_WKHR_CommentsRef{1}:=Num:C11(Line_ItemNo)
				Arr_WKHR_Comments{1}:=ItemCmmts_Txt
				Arr_WKHR_CommentCat{1}:=Num:C11(CategoryPrefix)
			End if 
		Else 
			If ($CommentIndx>0)
				DELETE FROM ARRAY:C228(Arr_WKHR_CommentsRef; $CommentIndx; 1)
				DELETE FROM ARRAY:C228(Arr_WKHR_Comments; $CommentIndx; 1)
				DELETE FROM ARRAY:C228(Arr_WKHR_CommentCat; $CommentIndx; 1)
			End if 
		End if 
		If (ReviewItm_6>0)  //Reviewer Edits
			If ($RevItmIndx>0)
				arr_WKHR_ReviewVal{1}{$RevItmIndx}:=ReviewItm_1
				arr_WKHR_ReviewVal{2}{$RevItmIndx}:=ReviewItm_2
				arr_WKHR_ReviewVal{3}{$RevItmIndx}:=ReviewItm_3
				arr_WKHR_ReviewVal{4}{$RevItmIndx}:=ReviewItm_4
				arr_WKHR_ReviewVal{5}{$RevItmIndx}:=ReviewItm_5
				arr_WKHR_ReviewVal{6}{$RevItmIndx}:=ReviewItm_6
				arr_WKHR_ReviewVal{7}{$RevItmIndx}:=ReviewItm_7
			Else 
				INSERT IN ARRAY:C227(Arr_WKHR_ReviewRef; 1; 1)
				INSERT IN ARRAY:C227(arr_WKHR_ReviewVal{1}; 1; 1)
				INSERT IN ARRAY:C227(arr_WKHR_ReviewVal{2}; 1; 1)
				INSERT IN ARRAY:C227(arr_WKHR_ReviewVal{3}; 1; 1)
				INSERT IN ARRAY:C227(arr_WKHR_ReviewVal{4}; 1; 1)
				INSERT IN ARRAY:C227(arr_WKHR_ReviewVal{5}; 1; 1)
				INSERT IN ARRAY:C227(arr_WKHR_ReviewVal{6}; 1; 1)
				INSERT IN ARRAY:C227(arr_WKHR_ReviewVal{7}; 1; 1)
				Arr_WKHR_ReviewRef{1}:=Num:C11(Line_ItemNo)
				arr_WKHR_ReviewVal{1}{1}:=ReviewItm_1
				arr_WKHR_ReviewVal{2}{1}:=ReviewItm_2
				arr_WKHR_ReviewVal{3}{1}:=ReviewItm_3
				arr_WKHR_ReviewVal{4}{1}:=ReviewItm_4
				arr_WKHR_ReviewVal{5}{1}:=ReviewItm_5
				arr_WKHR_ReviewVal{6}{1}:=ReviewItm_6
				If ([Work_Estimate:103]Version_L:47>0)
					arr_WKHR_ReviewVal{7}{1}:=ReviewItm_7
				Else 
				End if 
			End if 
		Else 
			//clear the edits -if any
			If ($RevItmIndx>0)
				DELETE FROM ARRAY:C228(Arr_WKHR_ReviewRef; $RevItmIndx; 1)
				DELETE FROM ARRAY:C228(arr_WKHR_ReviewVal{1}; $RevItmIndx; 1)
				DELETE FROM ARRAY:C228(arr_WKHR_ReviewVal{2}; $RevItmIndx; 1)
				DELETE FROM ARRAY:C228(arr_WKHR_ReviewVal{3}; $RevItmIndx; 1)
				DELETE FROM ARRAY:C228(arr_WKHR_ReviewVal{4}; $RevItmIndx; 1)
				DELETE FROM ARRAY:C228(arr_WKHR_ReviewVal{5}; $RevItmIndx; 1)
				DELETE FROM ARRAY:C228(arr_WKHR_ReviewVal{6}; $RevItmIndx; 1)
				DELETE FROM ARRAY:C228(arr_WKHR_ReviewVal{7}; $RevItmIndx; 1)
			End if 
			
		End if 
		If (WKHR_OfficeEstEdit_b)
			If (OfficeEstItm_6>0)  //Office Est 
				If ($OfficeItmIndx>0)
					arr_WKHR_OfficeEstVal{1}{$OfficeItmIndx}:=OfficeEstItm_1
					arr_WKHR_OfficeEstVal{2}{$OfficeItmIndx}:=OfficeEstItm_2
					arr_WKHR_OfficeEstVal{3}{$OfficeItmIndx}:=OfficeEstItm_3
					arr_WKHR_OfficeEstVal{4}{$OfficeItmIndx}:=OfficeEstItm_4
					arr_WKHR_OfficeEstVal{5}{$OfficeItmIndx}:=OfficeEstItm_5
					arr_WKHR_OfficeEstVal{6}{$OfficeItmIndx}:=OfficeEstItm_6
					If ([Work_Estimate:103]Version_L:47>0)
						arr_WKHR_OfficeEstVal{7}{$OfficeItmIndx}:=OfficeEstItm_7
					Else 
					End if 
				Else 
					INSERT IN ARRAY:C227(Arr_WKHR_OfficeEstRef; 1; 1)
					INSERT IN ARRAY:C227(arr_WKHR_OfficeEstVal{1}; 1; 1)
					INSERT IN ARRAY:C227(arr_WKHR_OfficeEstVal{2}; 1; 1)
					INSERT IN ARRAY:C227(arr_WKHR_OfficeEstVal{3}; 1; 1)
					INSERT IN ARRAY:C227(arr_WKHR_OfficeEstVal{4}; 1; 1)
					INSERT IN ARRAY:C227(arr_WKHR_OfficeEstVal{5}; 1; 1)
					INSERT IN ARRAY:C227(arr_WKHR_OfficeEstVal{6}; 1; 1)
					INSERT IN ARRAY:C227(arr_WKHR_OfficeEstVal{7}; 1; 1)
					Arr_WKHR_OfficeEstRef{1}:=Num:C11(Line_ItemNo)
					arr_WKHR_OfficeEstVal{1}{1}:=OfficeEstItm_1
					arr_WKHR_OfficeEstVal{2}{1}:=OfficeEstItm_2
					arr_WKHR_OfficeEstVal{3}{1}:=OfficeEstItm_3
					arr_WKHR_OfficeEstVal{4}{1}:=OfficeEstItm_4
					arr_WKHR_OfficeEstVal{5}{1}:=OfficeEstItm_5
					arr_WKHR_OfficeEstVal{6}{1}:=OfficeEstItm_6
					If ([Work_Estimate:103]Version_L:47>0)
						arr_WKHR_OfficeEstVal{7}{1}:=OfficeEstItm_7
					Else 
					End if 
				End if 
			Else 
				//clear the edits -if any
				If ($OfficeItmIndx>0)
					DELETE FROM ARRAY:C228(Arr_WKHR_OfficeEstRef; $OfficeItmIndx; 1)
					DELETE FROM ARRAY:C228(arr_WKHR_OfficeEstVal{1}; $OfficeItmIndx; 1)
					DELETE FROM ARRAY:C228(arr_WKHR_OfficeEstVal{2}; $OfficeItmIndx; 1)
					DELETE FROM ARRAY:C228(arr_WKHR_OfficeEstVal{3}; $OfficeItmIndx; 1)
					DELETE FROM ARRAY:C228(arr_WKHR_OfficeEstVal{4}; $OfficeItmIndx; 1)
					DELETE FROM ARRAY:C228(arr_WKHR_OfficeEstVal{5}; $OfficeItmIndx; 1)
					DELETE FROM ARRAY:C228(arr_WKHR_OfficeEstVal{6}; $OfficeItmIndx; 1)
					If ([Work_Estimate:103]Version_L:47>0)
						DELETE FROM ARRAY:C228(arr_WKHR_OfficeEstVal{7}; $OfficeItmIndx; 1)
					Else 
					End if 
				End if 
				
			End if 
		End if 
		
		ARRAY INTEGER:C220($arr_subitemEntered; 0)
		WKHR_SubItemCount:=0
		For ($i; 1; WKHR_MaxNumSubBreakDwn)
			$var_ptr:=Get pointer:C304("SubItmV"+String:C10($i)+"_6")  //get the sum
			If (($var_ptr->)>0)
				WKHR_SubItemCount:=WKHR_SubItemCount+1
				INSERT IN ARRAY:C227($arr_subitemEntered; 1; 1)
				$arr_subitemEntered{1}:=$i
			End if 
		End for 
		
		If (WKHR_SubItemCount>0)  //Item BreakDowns
			If ($SubItmIndx>0)
				C_LONGINT:C283($numCurrItems)
				$numCurrItems:=Size of array:C274(Arr_WKHR_SubItmDesc{$SubItmIndx})
				DELETE FROM ARRAY:C228(Arr_WKHR_SubItmDesc{$SubItmIndx}; 1; $numCurrItems)
				$numCurrItems:=Size of array:C274(Arr_WKHR_SubItmVal{$SubItmIndx})
				DELETE FROM ARRAY:C228(Arr_WKHR_SubItmVal{$SubItmIndx}; 1; $numCurrItems)
				INSERT IN ARRAY:C227(Arr_WKHR_SubItmDesc{$SubItmIndx}; 1; WKHR_SubItemCount)
				INSERT IN ARRAY:C227(Arr_WKHR_SubItmVal{$SubItmIndx}; 1; ((WKHR_CategoryCount_i+1)*WKHR_SubItemCount))
				C_LONGINT:C283($subItemNo)  //Command Replaced was o_C_INTEGER
				$subItemNo:=0
				For ($i_sub; 1; WKHR_MaxNumSubBreakDwn)
					If (Find in array:C230($arr_subitemEntered; $i_sub)>0)
						$subItemNo:=$subItemNo+1
						$var_ptr:=Get pointer:C304("SubItDsc_"+String:C10($i_sub))
						Arr_WKHR_SubItmDesc{$SubItmIndx}{$subItemNo}:=$var_ptr->
						For ($i_subv; 1; (WKHR_CategoryCount_i+1))
							$var_ptr:=Get pointer:C304("SubItmV"+String:C10($i_sub)+"_"+String:C10($i_subv))
							Arr_WKHR_SubItmVal{$SubItmIndx}{((WKHR_CategoryCount_i+1)*($subItemNo-1)+$i_subv)}:=$var_ptr->
						End for 
						
					End if 
				End for 
				
			Else 
				$CurrBrkdns:=Size of array:C274(Arr_WKHR_SubItmRef)
				INSERT IN ARRAY:C227(Arr_WKHR_SubItmRef; ($CurrBrkdns+1); 1)
				INSERT IN ARRAY:C227(Arr_WKHR_SubItmDesc; ($CurrBrkdns+1); 1)
				INSERT IN ARRAY:C227(Arr_WKHR_SubItmDesc{($CurrBrkdns+1)}; 1; WKHR_SubItemCount)
				INSERT IN ARRAY:C227(Arr_WKHR_SubItmVal; ($CurrBrkdns+1); 1)
				INSERT IN ARRAY:C227(Arr_WKHR_SubItmVal{($CurrBrkdns+1)}; 1; ((WKHR_CategoryCount_i+1)*WKHR_SubItemCount))
				Arr_WKHR_SubItmRef{$CurrBrkdns+1}:=Num:C11(Line_ItemNo)
				C_LONGINT:C283($subItemNo)  //Command Replaced was o_C_INTEGER
				$subItemNo:=0
				For ($i_sub; 1; WKHR_MaxNumSubBreakDwn)
					If (Find in array:C230($arr_subitemEntered; $i_sub)>0)
						$subItemNo:=$subItemNo+1
						$var_ptr:=Get pointer:C304("SubItDsc_"+String:C10($i_sub))
						Arr_WKHR_SubItmDesc{($CurrBrkdns+1)}{$subItemNo}:=$var_ptr->
						For ($i_subv; 1; (WKHR_CategoryCount_i+1))
							$var_ptr:=Get pointer:C304("SubItmV"+String:C10($i_sub)+"_"+String:C10($i_subv))
							Arr_WKHR_SubItmVal{($CurrBrkdns+1)}{((WKHR_CategoryCount_i+1)*($subItemNo-1)+$i_subv)}:=$var_ptr->
						End for 
					End if 
					
				End for 
				
			End if 
			
		Else 
			//Clear all breakdowns
			If ($SubItmIndx>0)
				DELETE FROM ARRAY:C228(Arr_WKHR_SubItmRef; $SubItmIndx; 1)
				ARRAY TEXT:C222(Arr_WKHR_SubItmDesc{$SubItmIndx}; 0)
				DELETE FROM ARRAY:C228(Arr_WKHR_SubItmDesc; $SubItmIndx; 1)
				ARRAY REAL:C219(Arr_WKHR_SubItmVal{$SubItmIndx}; 0)
				DELETE FROM ARRAY:C228(Arr_WKHR_SubItmVal; $SubItmIndx; 1)
			End if 
		End if 
		
		//```Office Esitmate submitems
		ARRAY INTEGER:C220($arr_subitemEntered; 0)
		WKHR_OffEstSubItemCount:=0
		For ($i; 1; WKHR_MaxNumSubBreakDwn)
			$var_ptr:=Get pointer:C304("OffEstSubItmV"+String:C10($i)+"_6")  //get the sum
			If (($var_ptr->)>0)
				WKHR_OffEstSubItemCount:=WKHR_OffEstSubItemCount+1
				INSERT IN ARRAY:C227($arr_subitemEntered; 1; 1)
				$arr_subitemEntered{1}:=$i
			End if 
		End for 
		
		If (WKHR_OffEstSubItemCount>0)  //Office Esitmate Item BreakDowns
			If ($OffEstSubItmIndx>0)
				C_LONGINT:C283($numCurrItems)
				$numCurrItems:=Size of array:C274(Arr_WKHR_OffEstSubItmDesc{$OffEstSubItmIndx})
				DELETE FROM ARRAY:C228(Arr_WKHR_OffEstSubItmDesc{$OffEstSubItmIndx}; 1; $numCurrItems)
				$numCurrItems:=Size of array:C274(Arr_WKHR_OffEstSubItmVal{$OffEstSubItmIndx})
				DELETE FROM ARRAY:C228(Arr_WKHR_OffEstSubItmVal{$OffEstSubItmIndx}; 1; $numCurrItems)
				INSERT IN ARRAY:C227(Arr_WKHR_OffEstSubItmDesc{$OffEstSubItmIndx}; 1; WKHR_OffEstSubItemCount)
				INSERT IN ARRAY:C227(Arr_WKHR_OffEstSubItmVal{$OffEstSubItmIndx}; 1; ((WKHR_CategoryCount_i+1)*WKHR_OffEstSubItemCount))
				C_LONGINT:C283($subItemNo)  //Command Replaced was o_C_INTEGER
				$subItemNo:=0
				For ($i_sub; 1; WKHR_MaxNumSubBreakDwn)
					If (Find in array:C230($arr_subitemEntered; $i_sub)>0)
						$subItemNo:=$subItemNo+1
						$var_ptr:=Get pointer:C304("OffEstSubItDsc_"+String:C10($i_sub))
						Arr_WKHR_OffEstSubItmDesc{$OffEstSubItmIndx}{$subItemNo}:=$var_ptr->
						For ($i_subv; 1; (WKHR_CategoryCount_i+1))
							$var_ptr:=Get pointer:C304("OffEstSubItmV"+String:C10($i_sub)+"_"+String:C10($i_subv))
							Arr_WKHR_OffEstSubItmVal{$OffEstSubItmIndx}{((WKHR_CategoryCount_i+1)*($subItemNo-1)+$i_subv)}:=$var_ptr->
						End for 
						
					End if 
				End for 
				
			Else 
				$CurrBrkdns:=Size of array:C274(Arr_WKHR_OffEstSubItmRef)
				INSERT IN ARRAY:C227(Arr_WKHR_OffEstSubItmRef; ($CurrBrkdns+1); 1)
				INSERT IN ARRAY:C227(Arr_WKHR_OffEstSubItmDesc; ($CurrBrkdns+1); 1)
				INSERT IN ARRAY:C227(Arr_WKHR_OffEstSubItmDesc{($CurrBrkdns+1)}; 1; WKHR_OffEstSubItemCount)
				INSERT IN ARRAY:C227(Arr_WKHR_OffEstSubItmVal; ($CurrBrkdns+1); 1)
				INSERT IN ARRAY:C227(Arr_WKHR_OffEstSubItmVal{($CurrBrkdns+1)}; 1; ((WKHR_CategoryCount_i+1)*WKHR_OffEstSubItemCount))
				Arr_WKHR_OffEstSubItmRef{$CurrBrkdns+1}:=Num:C11(Line_ItemNo)
				C_LONGINT:C283($subItemNo)  //Command Replaced was o_C_INTEGER
				$subItemNo:=0
				For ($i_sub; 1; WKHR_MaxNumSubBreakDwn)
					If (Find in array:C230($arr_subitemEntered; $i_sub)>0)
						$subItemNo:=$subItemNo+1
						$var_ptr:=Get pointer:C304("OffEstSubItDsc_"+String:C10($i_sub))
						Arr_WKHR_OffEstSubItmDesc{($CurrBrkdns+1)}{$subItemNo}:=$var_ptr->
						For ($i_subv; 1; (WKHR_CategoryCount_i+1))
							$var_ptr:=Get pointer:C304("OffEstSubItmV"+String:C10($i_sub)+"_"+String:C10($i_subv))
							Arr_WKHR_OffEstSubItmVal{($CurrBrkdns+1)}{((WKHR_CategoryCount_i+1)*($subItemNo-1)+$i_subv)}:=$var_ptr->
						End for 
					End if 
					
				End for 
				
			End if 
			
		Else 
			//Clear all breakdowns
			If ($OffEstSubItmIndx>0)
				DELETE FROM ARRAY:C228(Arr_WKHR_OffEstSubItmRef; $OffEstSubItmIndx; 1)
				ARRAY TEXT:C222(Arr_WKHR_OffEstSubItmDesc{$OffEstSubItmIndx}; 0)
				DELETE FROM ARRAY:C228(Arr_WKHR_OffEstSubItmDesc; $OffEstSubItmIndx; 1)
				ARRAY REAL:C219(Arr_WKHR_OffEstSubItmVal{$OffEstSubItmIndx}; 0)
				DELETE FROM ARRAY:C228(Arr_WKHR_OffEstSubItmVal; $OffEstSubItmIndx; 1)
			End if 
		End if 
		
End case 