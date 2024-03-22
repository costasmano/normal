//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/03/07, 14:20:42
	// ----------------------------------------------------
	// Method: WKHR_AcceptReviewer
	// Description
	// Accept the reviewers values for an  item
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(3/19/09 16:43:01)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 16:48:21  ` ("WKHRMODS")
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
If (WKHR_SubItemCount>0)
	//need to distribute to sub items
	C_POINTER:C301($RevwV_ptr; $ItemV_ptr; $SubV_ptr; $SubSumV_ptr)
	C_LONGINT:C283($i; $Subcnt)
	C_REAL:C285($Remainder_r)
	For ($i; 1; WKHR_CategoryCount_i)
		$RevwV_ptr:=Get pointer:C304("ReviewItm_"+String:C10(WKHR_CatIndx_aL{$i}))
		$ItemV_ptr:=Get pointer:C304("WkHr_Real_"+String:C10(WKHR_CatIndx_aL{$i}))
		$Remainder_r:=$RevwV_ptr->
		If (($ItemV_ptr->)>0)
			//distribute according to current ratios
			For ($Subcnt; 1; (WKHR_SubItemCount-1))
				$SubV_ptr:=Get pointer:C304("SubItmV"+String:C10($Subcnt)+"_"+String:C10(WKHR_CatIndx_aL{$i}))
				$SubV_ptr->:=Round:C94((($RevwV_ptr->)*(($SubV_ptr->)/($ItemV_ptr->))); 0)
				$Remainder_r:=$Remainder_r-$SubV_ptr->
			End for 
			$SubV_ptr:=Get pointer:C304("SubItmV"+String:C10(WKHR_SubItemCount)+"_"+String:C10(WKHR_CatIndx_aL{$i}))
			$SubV_ptr->:=$Remainder_r
		Else 
			//divide evenly
			For ($Subcnt; 1; (WKHR_SubItemCount-1))
				$SubV_ptr:=Get pointer:C304("SubItmV"+String:C10($Subcnt)+"_"+String:C10(WKHR_CatIndx_aL{$i}))
				$SubV_ptr->:=Round:C94(($RevwV_ptr->)/WKHR_SubItemCount; 0)
				$Remainder_r:=$Remainder_r-$SubV_ptr->
			End for 
			$SubV_ptr:=Get pointer:C304("SubItmV"+String:C10(WKHR_SubItemCount)+"_"+String:C10(WKHR_CatIndx_aL{$i}))
			$SubV_ptr->:=$Remainder_r
		End if 
		
	End for 
	For ($Subcnt; 1; WKHR_SubItemCount)
		$SubSumV_ptr:=Get pointer:C304("SubItmV"+String:C10($Subcnt)+"_6")
		$SubSumV_ptr->:=0
		For ($i; 1; WKHR_CategoryCount_i)
			$SubV_ptr:=Get pointer:C304("SubItmV"+String:C10($Subcnt)+"_"+String:C10(WKHR_CatIndx_aL{$i}))
			$SubSumV_ptr->:=$SubSumV_ptr->+$SubV_ptr->
		End for 
		
	End for 
	
End if 
WkHr_Real_1:=ReviewItm_1
WkHr_Real_2:=ReviewItm_2
WkHr_Real_3:=ReviewItm_3
WkHr_Real_4:=ReviewItm_4
WkHr_Real_5:=ReviewItm_5
WkHr_Real_6:=ReviewItm_6
WkHr_Real_7:=ReviewItm_7

WKHR_DataEntered_B:=True:C214