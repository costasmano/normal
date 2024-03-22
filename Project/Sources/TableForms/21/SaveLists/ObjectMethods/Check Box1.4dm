// ----------------------------------------------------
// Object Method: Check Box1
// User name (OS): charlesmiller
// Date and time: 05/23/11, 13:16:17
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_05  //r002 CJ Miller`05/23/11, 13:16:18      `Fix bugs found during testing of initial release of v11
	// Modified by: Costas Manousakis-(Designer)-(10/10/17 11:15:35)
	Mods_2017_10
	//  `use LIST OF CHOICE LISTS to get lists - added checks when loading a document and reading from it
	
End if 

If (Check Box1=1)
	ARRAY TEXT:C222(ProcessLists_atxt; 0)
	ARRAY TEXT:C222(AvailableLists_atxt; 0)
	ARRAY LONGINT:C221(AvailableListIds_al; 0)
	ARRAY LONGINT:C221(ProcessListIDS_al; 0)
	ARRAY TEXT:C222($SelectedFiles_atxt; 0)
	C_TEXT:C284($FileName_txt)
	
	$FileName_txt:=Select document:C905(""; "*"; "Select List Document"; 0; $SelectedFiles_atxt)
	If (Size of array:C274($SelectedFiles_atxt)=1)
		ARRAY TEXT:C222(AvailableLists_atxt; 0)
		ARRAY LONGINT:C221(AvailableListIds_al; 0)
		C_BLOB:C604($Blob_blb)
		SET BLOB SIZE:C606($Blob_blb; 0)
		C_LONGINT:C283($Size_l; $Offset_l; $ListID_l; $lastOffset_L)
		C_TEXT:C284($ListName_txt)
		$Offset_l:=0
		If (Test path name:C476($SelectedFiles_atxt{1})=Is a document:K24:1)
			DOCUMENT TO BLOB:C525($SelectedFiles_atxt{1}; $Blob_blb)
			$Size_l:=BLOB size:C605($Blob_blb)
			C_BOOLEAN:C305($Error_b)
			$Error_b:=False:C215
			If ($Size_l>0)
				Repeat 
					$lastOffset_L:=$Offset_l
					BLOB TO VARIABLE:C533($Blob_blb; $ListName_txt; $Offset_l)
					If ($Offset_l=$lastOffset_L)
						$Error_b:=True:C214
					Else 
						$lastOffset_L:=$Offset_l
						$ListID_l:=BLOB to list:C557($Blob_blb; $Offset_l)
						If ($Offset_l=$lastOffset_L)
							$Error_b:=True:C214
						Else 
							APPEND TO ARRAY:C911(AvailableLists_atxt; $ListName_txt)
							APPEND TO ARRAY:C911(AvailableListIds_al; $ListID_l)
						End if 
					End if 
					
				Until ($Offset_l>=$Size_l) | ($Error_b)
				If ($Error_b)
					ALERT:C41("Error Reading file "+$SelectedFiles_atxt{1}+"! probably does not contain List names and Lists!")
				End if 
				
			Else 
				ALERT:C41("File "+$SelectedFiles_atxt{1}+" has no size!")
			End if 
		Else 
			ALERT:C41("Selection "+$SelectedFiles_atxt{1}+" is not a document")
		End if 
		SET BLOB SIZE:C606($Blob_blb; 0)
		
	End if 
Else 
	ARRAY TEXT:C222(ProcessLists_atxt; 0)
	//QUERY([TableOfLists];[TableOfLists]ListName_s="4DLists")
	ARRAY TEXT:C222(AvailableLists_atxt; 0)
	//ARRAY TEXT(AvailableLists_atxt;Records in selection([TableOfLists]))
	ARRAY LONGINT:C221($listNums_aL; 0)
	//SELECTION RANGE TO ARRAY(1;Records in selection([TableOfLists]);[TableOfLists]ListValue_s;AvailableLists_atxt)
	LIST OF CHOICE LISTS:C957(AvailableListIds_al; AvailableLists_atxt)
	ARRAY LONGINT:C221(AvailableListIds_al; Size of array:C274(AvailableLists_atxt))
	SORT ARRAY:C229(AvailableLists_atxt; AvailableListIds_al; >)
End if 
REDRAW WINDOW:C456
//End Object Method: Check Box1
