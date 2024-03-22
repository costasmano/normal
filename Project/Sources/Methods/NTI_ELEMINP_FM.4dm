//%attributes = {"invisible":true}
//Method: NTI_ELEMINP_FM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/22/16, 16:19:32
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_LONGINT:C283(NTI_ELEMINP_FM; $1)
	// Modified by: Costas Manousakis-(Designer)-(11/28/17 10:15:59)
	Mods_2017_11_bug
	//  `added missing InDoubleClick_B:=False at end of On Load event
	// Modified by: Costas Manousakis-(Designer)-(6/20/18 14:04:26)
	Mods_2018_06
	//  `disable the delete button for new element.
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
		FORM GET PROPERTIES:C674([NTI_ELEM_BIN_INSP:183]; "input"; $FW_L; $fH_L)
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
		
		OBJECT SET ENABLED:C1123(*; "PON_ENVDESC_atxt"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		C_BOOLEAN:C305(PON_ElemNoQuantState1_b)
		C_LONGINT:C283(PON_PARENTENV_L; PON_PARENTSTRUNIT_L; PON_PARENTKEY_L; PON_GRANDPARENTKEY_L)
		C_TEXT:C284(PON_INSPBRKEY_txt; PON_INSPKEY_txt; PON_ELEMUNIT_txt)
		
		C_BOOLEAN:C305(PON_ADDPROTSYS_b)
		C_BOOLEAN:C305($EnvPullDownOn_b)
		$EnvPullDownOn_b:=True:C214
		If (Is new record:C668([NTI_ELEM_BIN_INSP:183]))
			// set up pull down
			// if parent show NBEs and  Env key and str unit
			[NTI_ELEM_BIN_INSP:183]INSPID:1:=[Inspections:27]InspID:2
			[NTI_ELEM_BIN_INSP:183]ELEM_SCALE_FACTOR:22:=1
			[NTI_ELEM_BIN_INSP:183]ELEM_CREATEDATETIME:4:=ISODateTime(Current date:C33(*); Current time:C178(*))
			[NTI_ELEM_BIN_INSP:183]ELEM_CREATEUSER:5:=Current user:C182
			
			Inc_Sequence("NTI_ELEM_BIN_INSP"; ->[NTI_ELEM_BIN_INSP:183]ELEMID:2)
			
			Case of 
				: (PON_PARENTKEY_L=0)  // no parent-primary element
					COPY ARRAY:C226(NTI_MASTERELEM_Desc_atxt; PON_ELEMSELECT_atxt)
					COPY ARRAY:C226(NTI_MASTERELEM_KEY_aL; PON_ELEMSELECT_aL)
					[NTI_ELEM_BIN_INSP:183]ELEM_QorP:16:=True:C214  //default to show quantity
					//_ o _DISABLE BUTTON(*;"DE bQuantity")
					//_ o _DISABLE BUTTON(*;"DE bPercent")
					OBJECT SET ENABLED:C1123(*; "DE bQuantity"; False:C215)
					OBJECT SET ENABLED:C1123(*; "DE bPercent"; False:C215)
					
				: (PON_PARENTKEY_L>0)  // child element-copy parent stuff
					[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7:=PON_PARENTKEY_L
					[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8:=PON_PARENTID_L
					[NTI_ELEM_BIN_INSP:183]ELEM_QorP:16:=True:C214  //default to show quantity
					COPY ARRAY:C226(NTI_SFLAGSELEM_Desc_atxt; PON_ELEMSELECT_atxt)
					COPY ARRAY:C226(NTI_SFLAGSELEM_KEY_aL; PON_ELEMSELECT_aL)
					NTI_SetElemSelectPulldown(0; [NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7; ->PON_ELEMSELECT_aL; ->PON_ELEMSELECT_atxt)
					//_ o _DISABLE BUTTON(*;"@PON_ENVDESC_atxt")
					
			End case 
			
			OBJECT SET VISIBLE:C603(*; "@ELEM_QTYSTATE@"; ([NTI_ELEM_BIN_INSP:183]ELEM_QorP:16))
			OBJECT SET VISIBLE:C603(*; "@ELEM_PCTSTATE@"; (Not:C34([NTI_ELEM_BIN_INSP:183]ELEM_QorP:16)))
			//[nti_elem_bin_insp]ELEM_QorP:=(bQuantity=1)
			
			bQuantity1:=bQuantity
			bPercent1:=bPercent
			FORM GOTO PAGE:C247(2)
			
			If ([NTI_ELEM_BIN_INSP:183]ELEM_QorP:16)
				bquantity:=1
				bPercent:=0
			Else 
				bquantity:=0
				bPercent:=1
			End if 
			NTI_ELEMINPUTIL("QUANTPERCENT")
			// disable all quantities/percentages until elem is picked
			OBJECT SET ENTERABLE:C238([NTI_ELEM_BIN_INSP:183]ELEM_QUANTITY:21; False:C215)
			OBJECT SET ENTERABLE:C238(*; "DE ELEM_QTYSTATE@"; False:C215)
			OBJECT SET ENTERABLE:C238(*; "DE ELEM_PCTSTATE@"; False:C215)
			OBJECT SET RGB COLORS:C628([NTI_ELEM_BIN_INSP:183]ELEM_QUANTITY:21; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_BIN_INSP]ELEM_QUANTITY; PON_Color_NotEditable_L)
			OBJECT SET RGB COLORS:C628(*; "DE ELEM_QTYSTATE@"; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE ELEM_QTYSTATE@"; PON_Color_NotEditable_L)
			OBJECT SET RGB COLORS:C628(*; "DE ELEM_PCTSTATE@"; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE ELEM_PCTSTATE@"; PON_Color_NotEditable_L)
			
			PON_ELEM_PROTSYS_L:=0
			PON_ELEM_DAMAGE_L:=0
			
			NTI_ELEMINPUTIL("SETFILTERS")
			
			//disable all the navigation buttons for new record
			NTI_ELEMINP_SetNavControls
			//_ o _DISABLE BUTTON(*;"DE Actions")
			OBJECT SET ENABLED:C1123(*; "DE Actions"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE bDelete"; False:C215)  //disable the delete button for new element
			
		Else 
			// existing element
			QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_BIN_INSP:183]ELEM_KEY:3)
			C_BOOLEAN:C305($NBE_b; $Defect_b; $Protsys_b)
			$NBE_b:=True:C214
			$Defect_b:=([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y")
			//$Protsys_b:=([NTI_ELEM_DEFS]ELEM_PROTECT_SYS="Y")
			PON_ELEMUNIT_txt:=[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12
			PON_ELEM_Defect_b:=$Defect_b
			
			Case of 
				: (Not:C34($Defect_b) & Not:C34($Protsys_b))
					COPY ARRAY:C226(NTI_MASTERELEM_Desc_atxt; PON_ELEMSELECT_atxt)
					COPY ARRAY:C226(NTI_MASTERELEM_KEY_aL; PON_ELEMSELECT_aL)
				: ($Defect_b)
					COPY ARRAY:C226(NTI_SFLAGSELEM_Desc_atxt; PON_ELEMSELECT_atxt)
					COPY ARRAY:C226(NTI_SFLAGSELEM_KEY_aL; PON_ELEMSELECT_aL)
					//: ($Protsys_b)
					//COPY ARRAY(PON_PROTSYSELEM_Desc_atxt;PON_ELEMSELECT_atxt)
					//COPY ARRAY(PON_PROTSYSELEM_KEY_aL;PON_ELEMSELECT_aL)
					
			End case 
			PON_ElemNoQuantState1_b:=False:C215
			If ([NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7=0)
			Else 
				// use same units as parent if a defect
				If (PON_ELEM_Defect_b)
					QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7)
					PON_ELEMUNIT_txt:=[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12
					PON_ElemNoQuantState1_b:=NTI_NoQuantityState1([NTI_ELEM_BIN_INSP:183]ELEM_KEY:3)
				End if 
				NTI_SetElemSelectPulldown([NTI_ELEM_BIN_INSP:183]ELEM_KEY:3; [NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7; ->PON_ELEMSELECT_aL; ->PON_ELEMSELECT_atxt; $Protsys_b)
			End if 
			
			NTI_ELEMINPUTIL("SETFILTERS")
			
			NTI_ELEMINPUTIL("BUILDELEMCHILD")
			
			Case of 
				: (([NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7=0) & $NBE_b)
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
			
			If ([NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7>0)  // element has parent cannot change Env
				$EnvPullDownOn_b:=False:C215
			End if 
			
			//Settings for editable or not enviroment
			If (Read only state:C362([NTI_ELEM_BIN_INSP:183]))
				//_ o _DISABLE BUTTON(*;"DE @")
				OBJECT SET ENABLED:C1123(*; "DE @"; False:C215)
				OBJECT SET ENTERABLE:C238(*; "DE @"; False:C215)
				If ([NTI_ELEM_BIN_INSP:183]ELEM_QorP:16)
					bquantity:=1
					bPercent:=0
				Else 
					bquantity:=0
					bPercent:=1
				End if 
				NTI_ELEMINPUTIL("QUANTPERCENT")
				
			Else 
				//_ o _ENABLE BUTTON(*;"DE @")
				OBJECT SET ENABLED:C1123(*; "DE @"; True:C214)
				OBJECT SET ENTERABLE:C238(*; "DE @"; True:C214)
				If (Not:C34($EnvPullDownOn_b))
					//_ o _DISABLE BUTTON(*;"@PON_ENVDESC_atxt")
				End if 
				
				If ([NTI_ELEM_BIN_INSP:183]ELEM_QorP:16)
					bquantity:=1
					bPercent:=0
				Else 
					bquantity:=0
					bPercent:=1
				End if 
				NTI_ELEMINPUTIL("QUANTPERCENT")
				
				If (Not:C34($Defect_b))
					OBJECT SET ENTERABLE:C238([NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE1:17; False:C215)
					OBJECT SET RGB COLORS:C628([NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE1:17; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_BIN_INSP]ELEM_QTYSTATE1; PON_Color_NotEditable_L)
					
				Else 
					If (PON_ElemNoQuantState1_b)
						//enable quantity entry in state 2 - pct stays the same
						//SET ENTERABLE([NTI_ELEM_BIN_INSP]ELEM_PCTSTATE2;False)
						//SET COLOR([NTI_ELEM_BIN_INSP]ELEM_PCTSTATE2;PON_Color_NotEditable_L)
						//SET ENTERABLE([NTI_ELEM_BIN_INSP]ELEM_PCTSTATE2;False)
						//SET COLOR([NTI_ELEM_BIN_INSP]ELEM_PCTSTATE2;PON_Color_NotEditable_L)
						//can leave things as is
					Else 
						//enable qty entry ins state  1 for defects
						OBJECT SET ENTERABLE:C238([NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE1:17; True:C214)
						OBJECT SET RGB COLORS:C628([NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE1:17; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_BIN_INSP]ELEM_QTYSTATE1; PON_Color_Editable_L)
					End if 
					
				End if 
				
				If ($Defect_b)
					OBJECT SET VISIBLE:C603(*; "DE Actions"; False:C215)
				Else 
					OBJECT SET VISIBLE:C603(*; "DE Actions"; True:C214)
				End if 
			End if 
			
			POPUPMENUC(->PON_ELEMSELECT_atxt; ->PON_ELEMSELECT_aL; ->[NTI_ELEM_BIN_INSP:183]ELEM_KEY:3)
			
			NTI_ELEMINP_SetNavControls
		End if 
		
		NTI_ELEMINPUTIL("SETPARENT_GP_TXT")
		
		InDoubleClick_B:=False:C215
		
	: ($FormEvent_L=On Data Change:K2:15)
		// keep q1 not enterable, change others and subtract from total to figure out q1
		
	: ($FormEvent_L=On Validate:K2:3)
		
	: ($FormEvent_L=On Unload:K2:2)
		//DELETE FROM ARRAY(PON_ELEMDEPTH_aL;Size of array(PON_ELEMDEPTH_aL))  //event has been disabled for the input form
		
End case 

//End NTI_ELEMINP_FM