//%attributes = {"invisible":true}
//Method: NTI_ELEMINP_TIN_FM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/26/16, 16:01:58
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_LONGINT:C283(NTI_ELEMINP_TIN_FM; $1)
	// Modified by: Costas Manousakis-(Designer)-(11/28/17 10:15:59)
	Mods_2017_11_bug
	//  `added missing InDoubleClick_B:=False at end of On Load event
	// Modified by: Costas Manousakis-(Designer)-(1/11/18 13:35:00)
	Mods_2018_01
	//  `handle elements/defects with unit=precent
	//  ` when percent - set to quantity to be used. set total to 100 for element and do not allow change total q
	//  ` for defects also set to use quantity. 
	// Modified by: Costas Manousakis-(Designer)-(1/19/18 17:43:10)
	Mods_2018_01
	//  `changes for multiple states with no quantity allowed
	// Modified by: Costas Manousakis-(Designer)-(6/20/18 14:04:26)
	Mods_2018_06
	//  `disable the delete button for new element.
	// Modified by: Costas Manousakis-(Designer)-(2021-09-27T00:00:00 15:04:35)
	Mods_2021_09
	//  `add form event to call to POPUPMENUC 
End if 
//
C_LONGINT:C283($1)

C_LONGINT:C283($FormEvent_L)

$FormEvent_L:=$1
Case of 
	: ($FormEvent_L=On Load:K2:1)
		C_LONGINT:C283($wW_L; $wH_L; $wT_L; $wL_L; $wr_L; $wB_L; $FW_L; $fH_L)
		GET WINDOW RECT:C443($wL_L; $wT_L; $wr_L; $wB_L)
		$wW_L:=$wr_L-$wL_L
		$wH_L:=$wB_L-$wT_L
		FORM GET PROPERTIES:C674([NTI_ELEM_TIN_INSP:185]; "input"; $FW_L; $fH_L)
		If (($FW_L>$wW_L) | ($fH_L>$wH_L))
			If ($FW_L>$wW_L)
				$wr_L:=$wL_L+$FW_L
			End if 
			If ($fH_L>$wH_L)
				$wB_L:=$wT_L+$fH_L
			End if 
			
			SET WINDOW RECT:C444($wL_L; $wT_L; $wr_L; $wB_L)
		End if 
		
		InitChangeStack(PON_ChangeStackLvl_L)
		
		//_ o _ENABLE BUTTON(*;"PON_ENVDESC_atxt")
		C_BOOLEAN:C305(PON_ElemNoQuantState1_b)
		C_LONGINT:C283(PON_PARENTENV_L; PON_PARENTSTRUNIT_L; PON_PARENTKEY_L; PON_GRANDPARENTKEY_L)
		C_TEXT:C284(PON_INSPBRKEY_txt; PON_INSPKEY_txt; PON_ELEMUNIT_txt)
		
		C_BOOLEAN:C305(PON_ADDPROTSYS_b)
		C_BOOLEAN:C305($EnvPullDownOn_b)
		C_BOOLEAN:C305($NBE_b; $Defect_b; $Protsys_b)
		$Defect_b:=False:C215
		$Protsys_b:=False:C215
		$EnvPullDownOn_b:=True:C214
		If (Is new record:C668([NTI_ELEM_TIN_INSP:185]))
			// set up pull down
			// if parent show NBEs and  Env key and str unit
			[NTI_ELEM_TIN_INSP:185]InspectionID:1:=[TIN_Inspections:184]InspectionID:2
			[NTI_ELEM_TIN_INSP:185]ELEM_SCALE_FACTOR:22:=1
			[NTI_ELEM_TIN_INSP:185]ELEM_CREATEDATETIME:4:=ISODateTime(Current date:C33(*); Current time:C178(*))
			[NTI_ELEM_TIN_INSP:185]ELEM_CREATEUSER:5:=Current user:C182
			
			Inc_Sequence("NTI_ELEM_TIN_INSP"; ->[NTI_ELEM_TIN_INSP:185]ELEMID:2)
			
			ARRAY LONGINT:C221($SiblingKeys_aL; 0)
			C_LONGINT:C283($loop_L; $InspID_L)
			
			Case of 
				: (PON_PARENTKEY_L=0)  // no parent-primary element
					//we can add only TIN_only elements
					
					COPY ARRAY:C226(NTI_MASTER_TIN_Desc_atxt; PON_ELEMSELECT_atxt)
					COPY ARRAY:C226(NTI_MASTER_TIN_KEY_aL; PON_ELEMSELECT_aL)
					$InspID_L:=[TIN_Inspections:184]InspectionID:2
					[NTI_ELEM_TIN_INSP:185]ELEM_QorP:16:=True:C214  //default to show quantity
					Begin SQL
						select [NTI_ELEM_TIN_INSP].ELEM_KEY from [NTI_ELEM_TIN_INSP]
						where [NTI_ELEM_TIN_INSP].InspectionID = :$InspID_L
						into :$SiblingKeys_aL ;
					End SQL
					
					//_ o _DISABLE BUTTON(*;"DE bQuantity")
					//_ o _DISABLE BUTTON(*;"DE bPercent")
					OBJECT SET ENABLED:C1123(*; "DE bQuantity"; False:C215)
					OBJECT SET ENABLED:C1123(*; "DE bPercent"; False:C215)
					
				: (PON_PARENTKEY_L>0)  // child element-copy parent stuff
					ARRAY REAL:C219($ElemQ_ar; 0)
					ARRAY TEXT:C222($Defect_atxt; 0)
					
					[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7:=PON_PARENTKEY_L
					[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8:=PON_PARENTID_L
					[NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_ID:26:=PON_GRANDPARENTID_L
					[NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_KEY:25:=PON_GRANDPARENTKEY_L
					[NTI_ELEM_TIN_INSP:185]ELEM_QorP:16:=True:C214  //default to show quantity
					//Get list of children from the parent
					Begin SQL
						select [NTI_ELEM_TIN_INSP].ELEM_KEY from [NTI_ELEM_TIN_INSP]
						where [NTI_ELEM_TIN_INSP].ELEM_PARENT_ID = :PON_PARENTID_L
						into :$SiblingKeys_aL ;
					End SQL
					// if prot sys load prot sys lists
					If (PON_ADDPROTSYS_b)
						$Protsys_b:=True:C214
						COPY ARRAY:C226(PON_PROTSYSELEM_Desc_atxt; PON_ELEMSELECT_atxt)
						COPY ARRAY:C226(PON_PROTSYSELEM_KEY_aL; PON_ELEMSELECT_aL)
						PON_ELEMSELECT_atxt:=0
						PON_ELEMUNIT_txt:=""
					Else 
						$Defect_b:=True:C214
						COPY ARRAY:C226(PON_SFLAGSELEM_Desc_atxt; PON_ELEMSELECT_atxt)
						COPY ARRAY:C226(PON_SFLAGSELEM_KEY_aL; PON_ELEMSELECT_aL)
						// use same units as parent if a defect
						QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7)
						PON_ELEMUNIT_txt:=[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12
						If (PON_ELEMUNIT_txt="percent")
							[NTI_ELEM_TIN_INSP:185]ELEM_QorP:16:=True:C214  //set to quantity
							OBJECT SET VISIBLE:C603(*; "DE bQuantity"; False:C215)
							OBJECT SET VISIBLE:C603(*; "DE bPercent"; False:C215)  // hide the options to switch
						End if 
					End if 
					
					NTI_SetElemSelectPulldown(0; [NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7; ->PON_ELEMSELECT_aL; ->PON_ELEMSELECT_atxt; PON_ADDPROTSYS_b)
					//_ o _DISABLE BUTTON(*;"@PON_ENVDESC_atxt")
					
			End case 
			
			//remove from list items used already
			For ($loop_L; Size of array:C274(PON_ELEMSELECT_aL); 1; -1)
				If (Find in array:C230($SiblingKeys_aL; PON_ELEMSELECT_aL{$loop_L})>0)
					DELETE FROM ARRAY:C228(PON_ELEMSELECT_aL; $loop_L; 1)
					DELETE FROM ARRAY:C228(PON_ELEMSELECT_atxt; $loop_L; 1)
				End if 
			End for 
			
			If (Size of array:C274(PON_ELEMSELECT_atxt)=0)
				
				Case of 
					: (PON_ADDPROTSYS_b)
						PON_ELEMSELECT_atxt{0}:="All allowed Protective Systems have been assigned to Element "+String:C10(PON_PARENTKEY_L)
					: ($Defect_b)
						PON_ELEMSELECT_atxt{0}:="All allowed Defects have been assigned to Element "+String:C10(PON_PARENTKEY_L)
					Else 
						PON_ELEMSELECT_atxt{0}:="All Elements have been assigned to the current inspection!"
				End case 
				
			Else 
				
				Case of 
					: (PON_ADDPROTSYS_b)
						PON_ELEMSELECT_atxt{0}:="Select Protective system for Element "+String:C10(PON_PARENTKEY_L)+" ..."
					: ($Defect_b)
						PON_ELEMSELECT_atxt{0}:="Select Defect for Element "+String:C10(PON_PARENTKEY_L)+" ..."
					Else 
						PON_ELEMSELECT_atxt{0}:="Select Element... "
				End case 
				
			End if 
			
			PON_ELEMSELECT_atxt:=0  //set array to zero
			
			OBJECT SET VISIBLE:C603(*; "@ELEM_QTYSTATE@"; ([NTI_ELEM_TIN_INSP:185]ELEM_QorP:16))
			OBJECT SET VISIBLE:C603(*; "@ELEM_PCTSTATE@"; (Not:C34([NTI_ELEM_TIN_INSP:185]ELEM_QorP:16)))
			//[NTI_ELEM_TIN_INSP]ELEM_QorP:=(bQuantity=1)
			
			bQuantity1:=bQuantity
			bPercent1:=bPercent
			FORM GOTO PAGE:C247(2)
			
			If ([NTI_ELEM_TIN_INSP:185]ELEM_QorP:16)
				bquantity:=1
				bPercent:=0
			Else 
				bquantity:=0
				bPercent:=1
			End if 
			NTI_ELEMINPUTIL_TIN("QUANTPERCENT")
			// disable all quantities/percentages until elem is picked
			OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; False:C215)
			OBJECT SET ENTERABLE:C238(*; "DE ELEM_QTYSTATE@"; False:C215)
			OBJECT SET ENTERABLE:C238(*; "DE ELEM_PCTSTATE@"; False:C215)
			OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_QUANTITY; PON_Color_NotEditable_L)
			OBJECT SET RGB COLORS:C628(*; "DE ELEM_QTYSTATE@"; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE ELEM_QTYSTATE@"; PON_Color_NotEditable_L)
			OBJECT SET RGB COLORS:C628(*; "DE ELEM_PCTSTATE@"; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE ELEM_PCTSTATE@"; PON_Color_NotEditable_L)
			
			PON_ELEM_PROTSYS_L:=0
			PON_ELEM_DAMAGE_L:=0
			
			NTI_ELEMINPUTIL_TIN("SETFILTERS")
			
			//disable all the navigation buttons for new record
			NTI_ELEMINP_SetNavControls
			//_ o _DISABLE BUTTON(*;"DE Actions")
			OBJECT SET ENABLED:C1123(*; "DE Actions"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE bDelete"; False:C215)  //disable the delete button for new element
			//_ o _ENABLE BUTTON(*;"PON_ELEMSELECT_atxt")
			OBJECT SET ENABLED:C1123(*; "PON_ELEMSELECT_atxt"; True:C214)
			//clear defect and protective system selections 
			NTI_ELEMINPUTIL_TIN("CLEARELEMCHILD")
			
		Else 
			// existing element
			QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
			$NBE_b:=True:C214  // 
			$Defect_b:=([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y")
			$Protsys_b:=([NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21="Y")
			PON_ELEMUNIT_txt:=[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12
			PON_ELEM_Defect_b:=$Defect_b
			C_BOOLEAN:C305($BinOnly_b)
			$BinOnly_b:=False:C215
			PON_PARENTKEY_L:=[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7
			Case of 
				: (Not:C34($Defect_b) & Not:C34($Protsys_b))
					
					If ([NTI_ELEM_DEFS:182]ELEM_TIN_ONLY:19="Y")
						COPY ARRAY:C226(NTI_MASTER_TIN_Desc_atxt; PON_ELEMSELECT_atxt)
						COPY ARRAY:C226(NTI_MASTER_TIN_KEY_aL; PON_ELEMSELECT_aL)
					Else 
						COPY ARRAY:C226(NTI_MASTERELEM_Desc_atxt; PON_ELEMSELECT_atxt)
						COPY ARRAY:C226(NTI_MASTERELEM_KEY_aL; PON_ELEMSELECT_aL)
						$BinOnly_b:=True:C214
					End if 
				: ($Protsys_b)
					COPY ARRAY:C226(NTI_PROTSYSELEM_Desc_atxt; PON_ELEMSELECT_atxt)
					COPY ARRAY:C226(NTI_PROTSYSELEM_KEY_aL; PON_ELEMSELECT_aL)
					
				: ($Defect_b)
					COPY ARRAY:C226(NTI_SFLAGSELEM_Desc_atxt; PON_ELEMSELECT_atxt)
					COPY ARRAY:C226(NTI_SFLAGSELEM_KEY_aL; PON_ELEMSELECT_aL)
					
			End case 
			PON_ElemNoQuantState1_b:=False:C215
			PON_ElemNoQuantityFlag_L:=0
			If ([NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7=0)
			Else 
				// use same units as parent if a defect
				If (PON_ELEM_Defect_b)
					QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7)
					PON_ELEMUNIT_txt:=[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12
					PON_ElemNoQuantState1_b:=NTI_NoQuantityState1([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
					PON_ElemNoQuantityFlag_L:=NTI_NoQuantityState([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
					//$BinOnly_b:=([NTI_ELEM_DEFS]ELEM_BINONLY="Y")
				End if 
				NTI_SetElemSelectPulldown([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3; [NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7; ->PON_ELEMSELECT_aL; ->PON_ELEMSELECT_atxt; $Protsys_b)
			End if 
			
			NTI_ELEMINPUTIL_TIN("SETFILTERS")
			
			NTI_ELEMINPUTIL_TIN("BUILDELEMCHILD")
			
			Case of 
				: (([NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7=0) & $NBE_b)
					OBJECT SET VISIBLE:C603(*; "@PON_NBE_DAM_LB@"; True:C214)
					OBJECT SET VISIBLE:C603(*; "@PON_NBE_Prot_LB@"; True:C214)
					// show both Listboxes
				: ($Defect_b)  // hide prot sys and damage for defects
					OBJECT SET VISIBLE:C603(*; "@PON_NBE_DAM_LB@"; False:C215)
					OBJECT SET VISIBLE:C603(*; "@PON_NBE_Prot_LB@"; False:C215)
				: ($Protsys_b)  // hide prot sys for prot sys
					OBJECT SET VISIBLE:C603(*; "@PON_NBE_DAM_LB@"; True:C214)
					OBJECT SET VISIBLE:C603(*; "@PON_NBE_Prot_LB@"; False:C215)
					
			End case 
			
			//Settings for editable or not enviroment
			If (Read only state:C362([NTI_ELEM_TIN_INSP:185]))
				//_ o _DISABLE BUTTON(*;"DE @")
				OBJECT SET ENTERABLE:C238(*; "DE @"; False:C215)
				OBJECT SET ENABLED:C1123(*; "DE @"; False:C215)
				If ([NTI_ELEM_TIN_INSP:185]ELEM_QorP:16)
					bquantity:=1
					bPercent:=0
				Else 
					bquantity:=0
					bPercent:=1
				End if 
				NTI_ELEMINPUTIL_TIN("QUANTPERCENT")
				
			Else 
				//_ o _ENABLE BUTTON(*;"DE @")
				OBJECT SET ENTERABLE:C238(*; "DE @"; True:C214)
				OBJECT SET ENABLED:C1123(*; "DE @"; True:C214)
				
				If (Not:C34($EnvPullDownOn_b))
					//_ o _DISABLE BUTTON(*;"@PON_ENVDESC_atxt")
				End if 
				
				If ([NTI_ELEM_TIN_INSP:185]ELEM_QorP:16)
					bquantity:=1
					bPercent:=0
				Else 
					bquantity:=0
					bPercent:=1
				End if 
				NTI_ELEMINPUTIL_TIN("QUANTPERCENT")
				
				If (Not:C34($Defect_b))
					OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; False:C215)
					OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_QTYSTATE1; PON_Color_NotEditable_L)
					
				Else 
					If (PON_ElemNoQuantState1_b)
						//enable quantity entry in state 2 - pct stays the same
						//SET ENTERABLE([NTI_ELEM_TIN_INSP]ELEM_PCTSTATE2;False)
						//SET COLOR([NTI_ELEM_TIN_INSP]ELEM_PCTSTATE2;PON_Color_NotEditable_L)
						//SET ENTERABLE([NTI_ELEM_TIN_INSP]ELEM_PCTSTATE2;False)
						//SET COLOR([NTI_ELEM_TIN_INSP]ELEM_PCTSTATE2;PON_Color_NotEditable_L)
						//can leave things as is
					Else 
						//enable qty entry in state  1 for defects
						OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; True:C214)
						OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_QTYSTATE1; PON_Color_Editable_L)
					End if 
					
				End if 
				
				//need a case of whether the 
				NTI_ELEMINPUTIL_TIN("QUANTPERCENT")
				
				If ($BinOnly_b)
					//disable changing quantities or desc or other...
					//allow only editing of comments
					NTI_ELEMINPUTIL_TIN("SETBINONLY")
				Else 
					NTI_ELEMINPUTIL_TIN("SETTINONLY")
				End if 
				
				If ($Defect_b)
					OBJECT SET VISIBLE:C603(*; "DE Actions"; False:C215)
				Else 
					OBJECT SET VISIBLE:C603(*; "DE Actions"; True:C214)
				End if 
			End if 
			POPUPMENUC(->PON_ELEMSELECT_atxt; ->PON_ELEMSELECT_aL; ->[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3; On Load:K2:1)
			
			NTI_ELEMINP_SetNavControls
		End if 
		
		NTI_ELEMINPUTIL_TIN("SETPARENT_GP_TXT")
		
		If (PON_ELEMUNIT_txt="percent")
			
			OBJECT SET VISIBLE:C603(*; "DE bQuantity"; False:C215)
			OBJECT SET VISIBLE:C603(*; "DE bPercent"; False:C215)
			
			If (PON_PARENTKEY_L=0)
				//main element
				OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; False:C215)
				OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_QUANTITY; PON_Color_NotEditable_L)
				
			End if 
			
		End if 
		
		If ($Defect_b)
			//for defects etc. hide the condition state 
			OBJECT SET VISIBLE:C603(*; "CondRating@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "CondRating@"; True:C214)
		End if 
		
		InDoubleClick_B:=False:C215
		
	: ($FormEvent_L=On Data Change:K2:15)
		
	: ($FormEvent_L=On Validate:K2:3)
		
	: ($FormEvent_L=On Unload:K2:2)
		//DELETE FROM ARRAY(PON_ELEMDEPTH_aL;Size of array(PON_ELEMDEPTH_aL))  //event has been disabled for the input form
		
End case 

//End NTI_ELEMINP_TIN_FM