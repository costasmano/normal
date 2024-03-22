//%attributes = {"invisible":true}
//Method: NTI_TinINSP_ImageLB_OM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/31/16, 11:39:29
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(8/9/16 10:22:29)
	Mods_2016_08_bug
	//  `added  NTI_ListInspImages at end of double click
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
	// Modified by: Costas Manousakis-(Designer)-(9/13/18 09:52:58)
	Mods_2018_09_bug
	//  `added form set input before modify record
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		CLEAR SET:C117("ImgListBoxSet")
	: (Form event code:C388=On Display Detail:K2:22)
		C_LONGINT:C283($type_pos_L)
		C_TEXT:C284(vImageDescr)
		$type_pos_L:=Find in array:C230(aPictCode; [TIN_Insp_Images:186]ImageType:5)
		If ($type_pos_L>0)
			vImgType:=aPicttype{$type_pos_L}
		Else 
			vImgType:="???"
		End if 
		
		vImageDescr:=Replace string:C233([TIN_Insp_Images:186]ImageDescr:4; <>sCR; "_")
		
	: (Form event code:C388=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			C_LONGINT:C283($rowClick_L; $column_l; $CurrQuant_L; $CurrPerc_L)
			LISTBOX GET CELL POSITION:C971(PHotos_LB; $column_l; $rowClick_L)
			
			If (($rowClick_L<1) | ($rowClick_L>Records in selection:C76([TIN_Insp_Images:186])))
				InDoubleClick_B:=False:C215
			Else 
				ARRAY LONGINT:C221($ImgRecords_aL; 0)
				SELECTION TO ARRAY:C260([TIN_Insp_Images:186]ImageID:2; $ImgRecords_aL)
				
				GOTO SELECTED RECORD:C245([TIN_Insp_Images:186]; $rowClick_L)
				If (Read only state:C362([TIN_Insp_Images:186]))
					DIALOG:C40([TIN_Insp_Images:186]; "Input")
					InDoubleClick_B:=False:C215
				Else 
					C_LONGINT:C283($load_L)
					$load_L:=ut_LoadRecordInteractiveV2(->[TIN_Insp_Images:186])
					
					Case of 
						: ($load_L=1)
							//save current selection
							FORM SET INPUT:C55([TIN_Insp_Images:186]; "Input")
							MODIFY RECORD:C57([TIN_Insp_Images:186])
							//NTI_ListInspImages 
							//If (OK=1)
							//QUERY WITH ARRAY([TIN_Insp_Images]ImageID;$ImgRecords_aL)
							//NTI_UpdateNextImgSeq 
							//End if 
						: ($load_L=1)
							DIALOG:C40([TIN_Insp_Images:186]; "Input")
					End case 
					InDoubleClick_B:=False:C215
				End if 
				ARRAY LONGINT:C221($ImgRecords_aL; 0)
				NTI_ListInspImages
			End if 
			
		End if 
		
	: (Form event code:C388=On Begin Drag Over:K2:44)
		C_LONGINT:C283($row; $col)
		
		Use (Storage:C1525)
			Storage:C1525.dragAndDrop:=New shared object:C1526
			//If (Not(Undefined(Storage.dragAndDrop)))
			Use (Storage:C1525.dragAndDrop)
				Storage:C1525.dragAndDrop.source:=FORM Event:C1606.objectName
				LISTBOX GET CELL POSITION:C971(PHotos_LB; $col; $row)
				Storage:C1525.dragAndDrop.index:=$row
				Storage:C1525.dragAndDrop.process:=Current process:C322
			End use 
			//End if 
		End use 
		
	: (Form event code:C388=On Drop:K2:12)
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
		
		//If ($src_ptr=Self)  //only from me
		If ($src_name=FORM Event:C1606.objectName)  //only from me
			
			//check if we have same types selected
			ARRAY LONGINT:C221($SelImgIDs_aL; 0)
			ARRAY TEXT:C222($SelimgTypes_atxt; 0)
			ARRAY LONGINT:C221($ImgIDs_aL; 0)
			ARRAY TEXT:C222($imgTypes_atxt; 0)
			SELECTION TO ARRAY:C260([TIN_Insp_Images:186]; $ImgIDs_aL; [TIN_Insp_Images:186]ImageType:5; $imgTypes_atxt)
			FIRST RECORD:C50([TIN_Insp_Images:186])
			While (Not:C34(End selection:C36([TIN_Insp_Images:186])))
				If (Is in set:C273("ImgListBoxSet"))
					APPEND TO ARRAY:C911($SelImgIDs_aL; Record number:C243([TIN_Insp_Images:186]))
					APPEND TO ARRAY:C911($SelimgTypes_atxt; [TIN_Insp_Images:186]ImageType:5)
				End if 
				NEXT RECORD:C51([TIN_Insp_Images:186])
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
				$dropRow_L:=Drop position:C608($ColNum_L)
				C_TEXT:C284($dropType_txt)
				//the selected images will replace the one dropped on and after
				//images starting from the dropped on and above will 
				If ($dropRow_L>0)
					
					//find if dropped before or after same type
					$dropType_txt:=$imgTypes_atxt{$dropRow_L}
					
					Case of 
						: ($dropType_txt=$SelimgTypes_atxt{1})  //same
							//replace $dropRow is as is
						: ($dropType_txt>$SelimgTypes_atxt{1})  //after
							//all go at the end of the same type
							//drop row is the last row of current type
							For ($loop_L; 1; Size of array:C274($imgTypes_atxt))
								If ($SelimgTypes_atxt{1}=$imgTypes_atxt{$loop_L})
									$dropRow_L:=$loop_L
								End if 
								
							End for 
							
						: ($dropType_txt<$SelimgTypes_atxt{1})  //before
							//all go at the start of the same type
							//drop row is the first row of current type
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
					CREATE SELECTION FROM ARRAY:C640([TIN_Insp_Images:186]; $newIds_aL)
					ARRAY LONGINT:C221($newIds_aL; 0)
					REDRAW:C174(PHotos_LB)
					REDRAW WINDOW:C456
				End if 
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
		
End case 

//End NTI_TinINSP_ImageLB_OM