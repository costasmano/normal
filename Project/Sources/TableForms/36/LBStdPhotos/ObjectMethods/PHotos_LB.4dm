//Method: [Standard Photos];"LB_StdPhotosInc_SUB".List Box
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 04/18/19, 13:18:48
	// ----------------------------------------------------
	//Created : 
	Mods_2019_04
	Mods_2021_04  //Change from auto to selecting input on sub forms by double clicking 
	//Modified by: CJ (4/8/21 15:51:14)
	// Modified by: Costas Manousakis-(Designer)-(4/20/21 13:46:02)
	Mods_2021_04
	//  `removed on Close detail event- moved CTRL_SubFormDoubleClick to on double clicked - removed InDoubleClick:=true
End if 
//
Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		C_TEXT:C284(vImgType; vImageDescr)
		vImgType:=Get_Description(->aPictType; ->aPictCode; ->[Standard Photos:36]PictType:5)
		vImageDescr:=[Standard Photos:36]Description:2
		vImageDescr:=Replace string:C233(vImageDescr; <>sCR; "_")
		
	: (Form event code:C388=On Double Clicked:K2:5)
		CTRL_SubFormDoubleClick(->[Standard Photos:36]; "Standard Photos"; "PHotos_LB")
		
		
		//: ((Form event code=On Drag Over) & Not(InDoubleClick_B))
		//If (Not(Read only state(Current form table->)))
		//ARRAY LONGINT($ImgIDs_aL; 0)
		//ARRAY TEXT($imgTypes_atxt; 0)
		//SELECTION TO ARRAY([Standard Photos]; $ImgIDs_aL; [Standard Photos]PictType; $imgTypes_atxt)
		//C_POINTER($src_ptr)
		//C_LONGINT($Src_element; $Src_process; $dropRow_L; $ColNum_L)
		//_O_DRAG AND DROP PROPERTIES($src_ptr; $Src_element; $Src_process)
		//$dropRow_L:=Drop position($ColNum_L)
		
		//If ($dropRow_L>0) & ($Src_element>0)
		//If ($imgTypes_atxt{$dropRow_L}=$imgTypes_atxt{$Src_element})
		//$0:=0
		//Else 
		//$0:=-1
		//End if 
		//Else 
		//$0:=-1
		//End if 
		//Else 
		//$0:=-1
		
		//End if 
		
		// to be ver
		
	: (Form event code:C388=On Begin Drag Over:K2:44)
		C_LONGINT:C283($col; $row)
		
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
		
		
	: ((Form event code:C388=On Drop:K2:12) & Not:C34(InDoubleClick_B))
		
		INSP_DropImageEvent(->[Standard Photos:36]PictType:5)
		//INSP_DropImageEvent(->[Standard Photos]PictType)
End case 
//End [Standard Photos];"LB_StdPhotosInc_SUB".List Box