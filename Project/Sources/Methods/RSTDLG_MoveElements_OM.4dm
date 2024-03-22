//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/09/07, 08:56:49
	// ----------------------------------------------------
	// Method: RSTDLG_MoveElements_OM
	// Description
	// Method that handles the moving of elements from one array to the other
	// used in object methods of dialog [zDialogs];"ResetDialog"
	// 
	// Parameters
	// $1 : $Direction : Text ">" ; ">>" ; "<" ; "<<" ;  "anything but > >> < <<"
	//  `When "anything but.. will just enable/disable move buttons
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_TEXT:C284($1; $Direction_txt)
C_LONGINT:C283($arrIndex_L)
$Direction_txt:=$1
Case of 
	: ($Direction_txt=">")  //single move to right array 
		If ((RSTDLG_Array1_ptr->)>0)
			INSERT IN ARRAY:C227(RSTDLG_Array2_ptr->; 0; 1)
			$arrIndex_L:=RSTDLG_Array1_ptr->
			RSTDLG_Array2_ptr->{1}:=RSTDLG_Array1_ptr->{$arrIndex_L}
			SORT ARRAY:C229(RSTDLG_Array2_ptr->)
			DELETE FROM ARRAY:C228(RSTDLG_Array1_ptr->; RSTDLG_Array1_ptr->; 1)
			RSTDLG_Array1_ptr->:=RSTDLG_Array1_ptr->
		End if 
	: ($Direction_txt=">>")  //move all to right array
		If (Size of array:C274(RSTDLG_Array1_ptr->)>0)
			C_LONGINT:C283($i)
			INSERT IN ARRAY:C227(RSTDLG_Array2_ptr->; 0; Size of array:C274(RSTDLG_Array1_ptr->))
			For ($i; 1; Size of array:C274(RSTDLG_Array1_ptr->))
				RSTDLG_Array2_ptr->{$i}:=RSTDLG_Array1_ptr->{$i}
			End for 
			SORT ARRAY:C229(RSTDLG_Array2_ptr->)
			DELETE FROM ARRAY:C228(RSTDLG_Array1_ptr->; 1; Size of array:C274(RSTDLG_Array1_ptr->))
		End if 
	: ($Direction_txt="<")  //single move to left array 
		If ((RSTDLG_Array2_ptr->)>0)
			INSERT IN ARRAY:C227(RSTDLG_Array1_ptr->; 0; 1)
			$arrIndex_L:=RSTDLG_Array1_ptr->
			RSTDLG_Array1_ptr->{1}:=RSTDLG_Array2_ptr->{$arrIndex_L}
			SORT ARRAY:C229(RSTDLG_Array1_ptr->)
			DELETE FROM ARRAY:C228(RSTDLG_Array2_ptr->; RSTDLG_Array2_ptr->; 1)
			RSTDLG_Array2_ptr->:=RSTDLG_Array2_ptr->
		End if 
	: ($Direction_txt="<<")  //move all to left array
		If (Size of array:C274(RSTDLG_Array2_ptr->)>0)
			INSERT IN ARRAY:C227(RSTDLG_Array1_ptr->; 0; Size of array:C274(RSTDLG_Array2_ptr->))
			For ($i; 1; Size of array:C274(RSTDLG_Array2_ptr->))
				RSTDLG_Array1_ptr->{$i}:=RSTDLG_Array2_ptr->{$i}
			End for 
			SORT ARRAY:C229(RSTDLG_Array1_ptr->)
			DELETE FROM ARRAY:C228(RSTDLG_Array2_ptr->; 1; Size of array:C274(RSTDLG_Array1_ptr->))
		End if 
		
End case 

If (Size of array:C274(RSTDLG_Array1_ptr->)=0)
	OBJECT SET ENABLED:C1123(*; "MoveButtonRight@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
Else 
	OBJECT SET ENABLED:C1123(*; "MoveButtonRight@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
End if 
If (Size of array:C274(RSTDLG_Array2_ptr->)=0)
	OBJECT SET ENABLED:C1123(*; "MoveButtonLeft@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
Else 
	OBJECT SET ENABLED:C1123(*; "MoveButtonLeft@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
End if 