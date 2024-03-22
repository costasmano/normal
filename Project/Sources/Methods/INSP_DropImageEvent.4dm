//%attributes = {"invisible":true}
//Method: INSP_DropImageEvent
//Description
// handle drop in an image listbox to re-arrange images
// the highlight set of the listbox MUST BE named "ImgListBoxSet"
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/26/19, 15:45:34
	// ----------------------------------------------------
	//Created : 
	Mods_2019_04
	
	C_POINTER:C301(INSP_DropImageEvent; $1)  //pointer to image type
	
End if 
//
C_POINTER:C301($1; $PicTypeFld_ptr; $ImagesTable_ptr)
$PicTypeFld_ptr:=$1
$ImagesTable_ptr:=Table:C252(Table:C252($PicTypeFld_ptr))
//C_POINTER($src_ptr)
C_TEXT:C284($src_name)

C_LONGINT:C283($Src_element; $Src_process; $dropRow_L; $ColNum_L)
//_O_DRAG AND DROP PROPERTIES($src_ptr; $Src_element; $Src_process)

Use (Storage:C1525)
	If (Not:C34(Undefined:C82(Storage:C1525.dragAndDrop)))
		Use (Storage:C1525.dragAndDrop)
			$src_name:=Storage:C1525.dragAndDrop.source
			$Src_element:=Storage:C1525.dragAndDrop.index
			$Src_process:=Storage:C1525.dragAndDrop.process
		End use 
	End if 
End use 
//If ($src_ptr=Self) & Not(Read only state($ImagesTable_ptr->))  //only from me


If ($src_name=FORM Event:C1606.objectName) & Not:C34(Read only state:C362($ImagesTable_ptr->))  //only from me
	$dropRow_L:=Drop position:C608($ColNum_L)
	
	If ($dropRow_L>0) & ($dropRow_L#$Src_element)
		
		
		//check if we have same types selected
		ARRAY LONGINT:C221($SelImgIDs_aL; 0)
		ARRAY TEXT:C222($SelimgTypes_atxt; 0)
		ARRAY LONGINT:C221($ImgIDs_aL; 0)
		ARRAY TEXT:C222($imgTypes_atxt; 0)
		SELECTION TO ARRAY:C260($ImagesTable_ptr->; $ImgIDs_aL; $PicTypeFld_ptr->; $imgTypes_atxt)
		FIRST RECORD:C50($ImagesTable_ptr->)
		While (Not:C34(End selection:C36($ImagesTable_ptr->)))
			If (Is in set:C273("ImgListBoxSet"))
				APPEND TO ARRAY:C911($SelImgIDs_aL; Record number:C243($ImagesTable_ptr->))
				APPEND TO ARRAY:C911($SelimgTypes_atxt; $PicTypeFld_ptr->)
			End if 
			NEXT RECORD:C51($ImagesTable_ptr->)
		End while 
		C_BOOLEAN:C305($SameTypes_b)
		$SameTypes_b:=True:C214
		C_LONGINT:C283($loop_L)
		For ($loop_L; 2; Size of array:C274($SelimgTypes_atxt))
			If ($SelimgTypes_atxt{$loop_L}#$SelimgTypes_atxt{$loop_L-1})
				$SameTypes_b:=False:C215
			End if 
			
		End for 
		If ($SameTypes_b)
			C_TEXT:C284($dropType_txt)
			//the selected images will replace the one dropped on and after
			//images starting from the dropped on and above will 
			
			//find if dropped before or after same type
			$dropType_txt:=$imgTypes_atxt{$dropRow_L}
			C_TEXT:C284($dropType_pl_txt; $source_PL_txt; $source_imgtype_txt)
			$source_imgtype_txt:=Get_Description(->aPictType; ->aPictCode; ->$SelimgTypes_atxt{1})
			Case of 
				: ($dropType_txt="1")
					$dropType_pl_txt:="Sketches"
				: ($dropType_txt="2")
					$dropType_pl_txt:="Charts"
				: ($dropType_txt="3")
					$dropType_pl_txt:="Photos"
			End case 
			Case of 
				: ($SelimgTypes_atxt{1}="1")
					$source_PL_txt:="Sketches"
				: ($SelimgTypes_atxt{1}="2")
					$source_PL_txt:="Charts"
				: ($SelimgTypes_atxt{1}="3")
					$source_PL_txt:="Photos"
			End case 
			
			
			Case of 
				: ($dropType_txt=$SelimgTypes_atxt{1})  //same
					//replace $dropRow is as is
				: ($dropType_txt>$SelimgTypes_atxt{1})  //after
					//all go at the end of the same type
					//drop row is the last row of current type
					ALERT:C41("You cannot mix a "+$source_imgtype_txt+" with "+$dropType_pl_txt+"! "+$source_imgtype_txt+" moved to the end of "+$source_PL_txt+"!")
					For ($loop_L; 1; Size of array:C274($imgTypes_atxt))
						If ($SelimgTypes_atxt{1}=$imgTypes_atxt{$loop_L})
							$dropRow_L:=$loop_L
						End if 
						
					End for 
					
				: ($dropType_txt<$SelimgTypes_atxt{1})  //before
					//all go at the start of the same type
					//drop row is the first row of current type
					ALERT:C41("You cannot mix a "+$source_imgtype_txt+" with "+$dropType_pl_txt+"! "+$source_imgtype_txt+" moved to the beginning of "+$source_PL_txt+"!")
					For ($loop_L; Size of array:C274($imgTypes_atxt); 1; -1)
						If ($SelimgTypes_atxt{1}=$imgTypes_atxt{$loop_L})
							$dropRow_L:=$loop_L
						End if 
						
					End for 
					
			End case 
			ARRAY LONGINT:C221($newIds_aL; 0)
			If ($Src_element>$dropRow_L)
				$dropRow_L:=$dropRow_L-1
			End if 
			For ($loop_L; 1; $dropRow_L)
				If (Find in array:C230($SelImgIDs_aL; $ImgIDs_aL{$loop_L})<=0)
					APPEND TO ARRAY:C911($newIds_aL; $ImgIDs_aL{$loop_L})
				End if 
			End for 
			For ($loop_L; 1; Size of array:C274($SelImgIDs_aL))
				APPEND TO ARRAY:C911($newIds_aL; $SelImgIDs_aL{$loop_L})
			End for 
			For ($loop_L; ($dropRow_L+1); Size of array:C274($ImgIDs_aL))
				If (Find in array:C230($SelImgIDs_aL; $ImgIDs_aL{$loop_L})<=0)
					APPEND TO ARRAY:C911($newIds_aL; $ImgIDs_aL{$loop_L})
				End if 
			End for 
			CREATE SELECTION FROM ARRAY:C640($ImagesTable_ptr->; $newIds_aL)
			ARRAY LONGINT:C221($newIds_aL; 0)
			REDRAW:C174(PHotos_LB)
			REDRAW WINDOW:C456
			
			OBJECT SET VISIBLE:C603(*; "ImageSortWarning"; True:C214)
			NTI_ImageSortNeeded_b:=True:C214
			
		Else 
			ALERT:C41("Multiple Image types selected to be moved! Can only work with one type at a time (Sketch, or Chart, or Photo)")
		End if 
		
		ARRAY LONGINT:C221($SelImgIDs_aL; 0)
		ARRAY TEXT:C222($SelimgTypes_atxt; 0)
		ARRAY LONGINT:C221($ImgIDs_aL; 0)
		ARRAY TEXT:C222($imgTypes_atxt; 0)
	End if 
	
End if 

//End INSP_DropImageEvent