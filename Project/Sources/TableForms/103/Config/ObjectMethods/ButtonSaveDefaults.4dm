If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/02/05, 16:15:07
	// ----------------------------------------------------
	// Method: Object Method: SaveDefaultsBtn
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(12/2/2005 16:15:12)
	Mods_2005_CM19
	Mods_2011_06  // CJ Miller`06/20/11, 11:37:53      ` Type all local variables for v11
End if 
C_TEXT:C284($CatRef_S)  // Command Replaced was o_C_STRING length was 3
C_LONGINT:C283($NumAllowedCats_L; $CatRef_L)
C_TEXT:C284($ItemTxt_txt)
C_BOOLEAN:C305($SaveDefault_B)
$NumAllowedCats_L:=Count list items:C380(CurrCategories_HL)
If ($NumAllowedCats_L=0)
	CONFIRM:C162("Current exclusion list is BLANK! IT WILL CLEAR OUT THE EXISTING DEFAULTS IF ANY!!"+" ARE YOU SURE YOU WANT TO CONTINUE?")
	If (OK=1)
		$SaveDefault_B:=True:C214
	Else 
		$SaveDefault_B:=False:C215
	End if 
Else 
	$SaveDefault_B:=True:C214
End if 
If ($SaveDefault_B)
	READ ONLY:C145([WorkHour_Config:104])
	QUERY:C277([WorkHour_Config:104]; [WorkHour_Config:104]AssignType:2=[Contract_Assignment_Maintenance:101]ProjectType:36)
	C_TEXT:C284($msg; $Save_txt)
	If (Records in selection:C76([WorkHour_Config:104])>0)
		If ($NumAllowedCats_L=0)
			$Msg:="Clear default exclusion list for "+[WorkHour_Config:104]AssignType:2+" projects?"
			$Save_txt:="Clear"
		Else 
			$Msg:="Replace default exclusion list for "+[WorkHour_Config:104]AssignType:2+" projects with the list above?"
			$Save_txt:="Replace"
		End if 
	Else 
		If ($NumAllowedCats_L=0)
			$msg:="Save a blank exclusion list as the default list for "+[Contract_Assignment_Maintenance:101]ProjectType:36+" projects?"
			$Save_txt:="Save blank"
		Else 
			$msg:="Save current exclusion list as the default list for "+[Contract_Assignment_Maintenance:101]ProjectType:36+" projects?"
			$Save_txt:="Save"
		End if 
		
	End if 
	CONFIRM:C162($msg; $Save_txt; "Cancel")
	If (OK=1)
		ARRAY INTEGER:C220(Arr_WKHR_RestrictedItems_I; 0)
		ARRAY INTEGER:C220(Arr_WKHR_RestrictedSubItms_I; 0)
		If ($NumAllowedCats_L>0)
			C_LONGINT:C283($i; $PosInMajCat)
			For ($i; 1; $NumAllowedCats_L)
				GET LIST ITEM:C378(CurrCategories_HL; $i; $CatRef_L; $ItemTxt_txt)
				$CatRef_S:=String:C10($CatRef_L)
				$PosInMajCat:=Find in array:C230(<>a_WKH_Index_Name; $CatRef_S)
				
				Case of 
					: ($PosInMajCat>0)
						INSERT IN ARRAY:C227(Arr_WKHR_RestrictedItems_I; 0)
						Arr_WKHR_RestrictedItems_I{1}:=Num:C11($CatRef_S)
					Else 
						INSERT IN ARRAY:C227(Arr_WKHR_RestrictedSubItms_I; 0)
						Arr_WKHR_RestrictedSubItms_I{1}:=Num:C11($CatRef_S)
				End case 
				
			End for 
		End if 
		
		C_BLOB:C604($RestrictedList_Blob)
		VARIABLE TO BLOB:C532(Arr_WKHR_RestrictedItems_I; $RestrictedList_Blob; *)
		VARIABLE TO BLOB:C532(Arr_WKHR_RestrictedSubItms_I; $RestrictedList_Blob; *)
		
		COMPRESS BLOB:C534($RestrictedList_Blob)
		
		If (Records in selection:C76([WorkHour_Config:104])>0)
			UNLOAD RECORD:C212([WorkHour_Config:104])
			READ WRITE:C146([WorkHour_Config:104])
			LOAD RECORD:C52([WorkHour_Config:104])
		Else 
			CREATE RECORD:C68([WorkHour_Config:104])
			[WorkHour_Config:104]AssignType:2:=[Contract_Assignment_Maintenance:101]ProjectType:36
		End if 
		[WorkHour_Config:104]ConfigArrays:1:=$RestrictedList_Blob
		SAVE RECORD:C53([WorkHour_Config:104])
		
	End if 
End if 