//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/03/07, 14:19:38
	// ----------------------------------------------------
	// Method: WKHR_AcceptRevwCat
	// Description
	// Accept All reviewer values for the current category
	// 
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(12/3/07 12:01:38)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(2/9/09 22:10:45)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 14:01:42  ` ("WKHRMODS")
	//Mods for V1 version of Work Hours
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_TEXT:C284($msg_txt)
$msg_txt:="If you continue, all of your hours for this Section will be adjusted to match the"
$msg_txt:=$msg_txt+" hours recommended by the Reviewer!"
$msg_txt:=$msg_txt+" If there are any sub-items, the new hours will be distributed among them!"
CONFIRM:C162($msg_txt; "Continue"; "Cancel")
C_LONGINT:C283($SubItmIndx; $i_sub; $i; $CurrBrkdns; $i_subv)
C_POINTER:C301($var_ptr)
If (OK=1)
	WKHR_InitLineItemVars
	C_POINTER:C301(arrPtr_1; arrPtr_2; arrPtr_3)
	arrPtr_1:=Get pointer:C304("Arr_"+CategoryPrefix+"_1")
	arrPtr_2:=Get pointer:C304("Arr_"+CategoryPrefix+"_2")
	arrPtr_3:=Get pointer:C304("Arr_"+CategoryPrefix+"_Values")
	C_LONGINT:C283($ItemIndex; $NumItems; $ItmCnt_L)
	C_TEXT:C284($ItemNum)  // Command Replaced was o_C_STRING length was 10
	$NumItems:=Size of array:C274(Arr_ItemNos)
	C_BOOLEAN:C305(WKHR_DataEntered_B)
	WKHR_DataEntered_B:=False:C215
	For ($ItmCnt_L; 1; $NumItems)
		$ItemNum:=Arr_ItemNos{$ItmCnt_L}
		$itemIndex:=Find in array:C230(arrPtr_1->; $ItemNum)
		Line_ItemNo:=arrPtr_1->{$itemIndex}
		C_LONGINT:C283($RevItmIndx)
		$RevItmIndx:=Find in array:C230(Arr_WKHR_ReviewRef; Num:C11(Line_ItemNo))
		If ($RevItmIndx>0)
			wkHr_Real_1:=arrPtr_3->{1}{$itemIndex}
			wkHr_Real_2:=arrPtr_3->{2}{$itemIndex}
			wkHr_Real_3:=arrPtr_3->{3}{$itemIndex}
			wkHr_Real_4:=arrPtr_3->{4}{$itemIndex}
			wkHr_Real_5:=arrPtr_3->{5}{$itemIndex}
			wkHr_Real_6:=arrPtr_3->{6}{$itemIndex}
			If ([Work_Estimate:103]Version_L:47>0)
				wkHr_Real_7:=arrPtr_3->{7}{$itemIndex}
			End if 
			ReviewItm_1:=arr_WKHR_ReviewVal{1}{$RevItmIndx}
			ReviewItm_2:=arr_WKHR_ReviewVal{2}{$RevItmIndx}
			ReviewItm_3:=arr_WKHR_ReviewVal{3}{$RevItmIndx}
			ReviewItm_4:=arr_WKHR_ReviewVal{4}{$RevItmIndx}
			ReviewItm_5:=arr_WKHR_ReviewVal{5}{$RevItmIndx}
			ReviewItm_6:=arr_WKHR_ReviewVal{6}{$RevItmIndx}
			If ([Work_Estimate:103]Version_L:47>0)
				ReviewItm_7:=arr_WKHR_ReviewVal{7}{$RevItmIndx}
			End if 
			
			
			$SubItmIndx:=Find in array:C230(Arr_WKHR_SubItmRef; Num:C11(Line_ItemNo))
			
			If ($SubItmIndx>0)
				C_LONGINT:C283($numSubBrkdwn)
				$numSubBrkdwn:=Size of array:C274(Arr_WKHR_SubItmDesc{$SubItmIndx})
				WKHR_SubItemCount:=MinNum($numSubBrkdwn; WKHR_MaxNumSubBreakDwn)
				For ($i_sub; 1; WKHR_SubItemCount)
					For ($i_subv; 1; (WKHR_CategoryCount_i+1))
						$var_ptr:=Get pointer:C304("SubItmV"+String:C10($i_sub)+"_"+String:C10($i_subv))
						$var_ptr->:=Arr_WKHR_SubItmVal{$SubItmIndx}{(($i_sub-1)*(WKHR_CategoryCount_i+1)+$i_subv)}
					End for 
				End for 
			End if 
			
			WKHR_AcceptReviewer
			WKHR_DataEntered_B:=True:C214
			
			arrPtr_3->{1}{$itemIndex}:=wkHr_Real_1
			arrPtr_3->{2}{$itemIndex}:=wkHr_Real_2
			arrPtr_3->{3}{$itemIndex}:=wkHr_Real_3
			arrPtr_3->{4}{$itemIndex}:=wkHr_Real_4
			arrPtr_3->{5}{$itemIndex}:=wkHr_Real_5
			arrPtr_3->{6}{$itemIndex}:=wkHr_Real_6
			If ([Work_Estimate:103]Version_L:47>0)
				arrPtr_3->{7}{$itemIndex}:=wkHr_Real_7
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
				
			End if 
			
		End if 
		
	End for 
	//force validate event to kick in
	If (WKHR_DataEntered_B)
		[Work_Estimate:103]Consultant:6:=[Work_Estimate:103]Consultant:6
		WKHR_RecalcPage2
		WKHR_LoadItemHRs
	End if 
End if 