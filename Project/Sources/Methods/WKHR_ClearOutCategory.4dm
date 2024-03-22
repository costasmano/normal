//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/09/05, 14:29:07
	// ----------------------------------------------------
	// Method: WKHR_ClearOutCategory
	// Description
	// Clear Extra Items for a category - leave only default items.
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(12/28/2005 22:16:33)
	Mods_2005_CM21
	// Modified by: costasmanousakis-(Designer)-(4/10/2006 16:54:19)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(12/3/07 11:06:16)
	Mods_2007_CM_5401  //use role variables
	// Modified by: costasmanousakis-(Designer)-(3/13/09 22:37:13)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 12:07:53  ` ("WKHRMODS")
	// Modified by: costasmanousakis-(Designer)-(4/2/09 11:33:38)
	Mods_2009_04
	//  `Fix for the new Version of Work hours.
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_POINTER:C301(arrPtr_1; arrPtr_2; arrPtr_3)
C_LONGINT:C283($vNumItems_L; $i; $PosInStdItems_L; $PosInCmts_L; $PosInReviews_L; $vItemNumber_L)
arrPtr_1:=Get pointer:C304("Arr_"+CategoryPrefix+"_1")
arrPtr_2:=Get pointer:C304("Arr_"+CategoryPrefix+"_2")
arrPtr_3:=Get pointer:C304("Arr_"+CategoryPrefix+"_Values")
$vNumItems_L:=Size of array:C274(arrPtr_1->)
For ($i; $vNumItems_L; 1; -1)
	$vItemNumber_L:=Num:C11(arrPtr_1->{$i})
	$PosInStdItems_L:=Find in array:C230(Arr_AllCategories_L; $vItemNumber_L)
	If ($PosInStdItems_L<0)
		//Not a std item - delete all item arrays
		DELETE FROM ARRAY:C228(arrPtr_1->; $i)
		DELETE FROM ARRAY:C228(arrPtr_2->; $i)
		DELETE FROM ARRAY:C228(arrPtr_3->{1}; $i)
		DELETE FROM ARRAY:C228(arrPtr_3->{2}; $i)
		DELETE FROM ARRAY:C228(arrPtr_3->{3}; $i)
		DELETE FROM ARRAY:C228(arrPtr_3->{4}; $i)
		DELETE FROM ARRAY:C228(arrPtr_3->{5}; $i)
		DELETE FROM ARRAY:C228(arrPtr_3->{6}; $i)
		If ([Work_Estimate:103]Version_L:47>0)
			DELETE FROM ARRAY:C228(arrPtr_3->{7}; $i)
		End if 
		
		
	End if 
	$PosInCmts_L:=Find in array:C230(Arr_WKHR_CommentsRef; $vItemNumber_L)
	If ($PosInCmts_L>0)
		DELETE FROM ARRAY:C228(Arr_WKHR_CommentsRef; $PosInCmts_L)
		DELETE FROM ARRAY:C228(Arr_WKHR_Comments; $PosInCmts_L)
		DELETE FROM ARRAY:C228(Arr_WKHR_CommentCat; $PosInCmts_L)
	End if 
	If (WKHR_RoleReview_b & WKHR_RoleApprove_b)
		//Clear review values only if reviewer
		$PosInReviews_L:=Find in array:C230(Arr_WKHR_ReviewRef; $vItemNumber_L)
		If ($PosInReviews_L>0)
			DELETE FROM ARRAY:C228(Arr_WKHR_ReviewRef; $PosInReviews_L; 1)
			DELETE FROM ARRAY:C228(arr_WKHR_ReviewVal{1}; $PosInReviews_L; 1)
			DELETE FROM ARRAY:C228(arr_WKHR_ReviewVal{2}; $PosInReviews_L; 1)
			DELETE FROM ARRAY:C228(arr_WKHR_ReviewVal{3}; $PosInReviews_L; 1)
			DELETE FROM ARRAY:C228(arr_WKHR_ReviewVal{4}; $PosInReviews_L; 1)
			DELETE FROM ARRAY:C228(arr_WKHR_ReviewVal{5}; $PosInReviews_L; 1)
			DELETE FROM ARRAY:C228(arr_WKHR_ReviewVal{6}; $PosInReviews_L; 1)
			DELETE FROM ARRAY:C228(arr_WKHR_ReviewVal{7}; $PosInReviews_L; 1)
			
		End if 
	End if 
	C_LONGINT:C283($SubItmIndx)
	$SubItmIndx:=Find in array:C230(Arr_WKHR_SubItmRef; $vItemNumber_L)
	If ($SubItmIndx>0)
		DELETE FROM ARRAY:C228(Arr_WKHR_SubItmRef; $SubItmIndx; 1)
		ARRAY TEXT:C222(Arr_WKHR_SubItmDesc{$SubItmIndx}; 0)
		DELETE FROM ARRAY:C228(Arr_WKHR_SubItmDesc; $SubItmIndx; 1)
		ARRAY REAL:C219(Arr_WKHR_SubItmVal{$SubItmIndx}; 0)
		DELETE FROM ARRAY:C228(Arr_WKHR_SubItmVal; $SubItmIndx; 1)
	End if 
End for 