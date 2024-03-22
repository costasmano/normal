//%attributes = {"invisible":true}
//Method: PON_ELEMINP_FM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/19/15, 17:03:01
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
	// Modified by: Costas Manousakis-(Designer)-(8/19/15 13:28:08)
	Mods_2015_08_bug
	//  `Added the total quantity to the display of the parent text 
	// Modified by: Costas Manousakis-(Designer)-(9/25/15 17:35:13)
	Mods_2015_09_bug
	//  `use new option  PON_ELEMINPUTIL("SETPARENT_GP_TXT")
	// Modified by: Costas Manousakis-(Designer)-(10/2/15 13:20:49)
	Mods_2015_10_bug
	//  `added PON_ELEMUNIT_txt  declaration in the On Load event
	//  `added code to handle the percent/quantity UI setting when read only
	// Modified by: Costas Manousakis-(Designer)-(2/10/16 14:05:35)
	Mods_2016_02_bug
	//  ` use PON_ELEM_Defect_b to keep track if element is a defect
	// Modified by: Costas Manousakis-(Designer)-(5/4/16 13:58:56)
	Mods_2016_05_bug
	//  `log the CreateDate and createUser
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/21/17 15:07:37)
	// Modified by: Costas Manousakis-(Designer)-(6/20/18 14:04:26)
	Mods_2018_06
	//  `disable the delete button for new element.
	// Modified by: Costas Manousakis-(Designer)-(2021-09-27T00:00:00 15:02:31)
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
		FORM GET PROPERTIES:C674([PON_ELEM_INSP:179]; "input"; $FW_L; $fH_L)
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
		If (Is new record:C668([PON_ELEM_INSP:179]))
			// set up pull down
			// if parent show NBEs and  Env key and str unit
			[PON_ELEM_INSP:179]BRKEY:1:=[Inspections:27]BIN:1  // ***** Is this what we'll do????
			[PON_ELEM_INSP:179]INSPKEY:2:=PON_INSPID2INSPKEY([Inspections:27]InspID:2)
			[PON_ELEM_INSP:179]INSPID:21:=[Inspections:27]InspID:2
			[PON_ELEM_INSP:179]ELEM_SCALE_FACTOR:8:=1
			[PON_ELEM_INSP:179]ELEM_CREATEDATETIME:17:=ISODateTime(Current date:C33(*); Current time:C178(*))
			[PON_ELEM_INSP:179]ELEM_CREATEUSERKEY:24:=Current user:C182
			
			Inc_Sequence("PON_ELEM_INSP"; ->[PON_ELEM_INSP:179]ELEMID:22)
			
			Case of 
				: (PON_PARENTKEY_L=0)  // no parent-primary element
					COPY ARRAY:C226(PON_MASTERELEM_Desc_atxt; PON_ELEMSELECT_atxt)
					COPY ARRAY:C226(PON_MASTERELEM_KEY_aL; PON_ELEMSELECT_aL)
					[PON_ELEM_INSP:179]STRUNITKEY:6:=1  // default
					[PON_ELEM_INSP:179]ELEM_QorP:29:=True:C214  //default to show quantity
				: (PON_PARENTKEY_L>0)  // child element-copy parent stuff
					[PON_ELEM_INSP:179]ENVKEY:5:=PON_PARENTENV_L
					[PON_ELEM_INSP:179]STRUNITKEY:6:=PON_PARENTSTRUNIT_L
					[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4:=PON_PARENTKEY_L
					[PON_ELEM_INSP:179]ELEM_PARENTID:27:=PON_PARENTID_L
					[PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19:=PON_GRANDPARENTKEY_L
					[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28:=PON_GRANDPARENTID_L
					[PON_ELEM_INSP:179]ELEM_QorP:29:=PON_ShowQuantity_b
					// if prot sys load prot sys lists
					If (PON_ADDPROTSYS_b)
						COPY ARRAY:C226(PON_PROTSYSELEM_Desc_atxt; PON_ELEMSELECT_atxt)
						COPY ARRAY:C226(PON_PROTSYSELEM_KEY_aL; PON_ELEMSELECT_aL)
					Else 
						COPY ARRAY:C226(PON_SFLAGSELEM_Desc_atxt; PON_ELEMSELECT_atxt)
						COPY ARRAY:C226(PON_SFLAGSELEM_KEY_aL; PON_ELEMSELECT_aL)
					End if 
					PON_SetElemSelectPulldown(0; [PON_ELEM_INSP:179]ELEM_PARENT_KEY:4; ->PON_ELEMSELECT_aL; ->PON_ELEMSELECT_atxt; PON_ADDPROTSYS_b)
					OBJECT SET ENABLED:C1123(*; "@PON_ENVDESC_atxt"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
					
			End case 
			
			OBJECT SET VISIBLE:C603(*; "@ELEM_QTYSTATE@"; ([PON_ELEM_INSP:179]ELEM_QorP:29))
			OBJECT SET VISIBLE:C603(*; "@ELEM_PCTSTATE@"; (Not:C34([PON_ELEM_INSP:179]ELEM_QorP:29)))
			//[PON_ELEM_INSP]ELEM_QorP:=(bQuantity=1)
			
			bQuantity1:=bQuantity
			bPercent1:=bPercent
			FORM GOTO PAGE:C247(2)
			
			// disable all quantities/percentages until elem and env are picked
			OBJECT SET ENTERABLE:C238([PON_ELEM_INSP:179]ELEM_QUANTITY:7; False:C215)
			OBJECT SET ENTERABLE:C238(*; "DE ELEM_QTYSTATE@"; False:C215)
			OBJECT SET ENTERABLE:C238(*; "DE ELEM_PCTSTATE@"; False:C215)
			OBJECT SET RGB COLORS:C628([PON_ELEM_INSP:179]ELEM_QUANTITY:7; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([PON_ELEM_INSP]ELEM_QUANTITY; PON_Color_NotEditable_L)
			OBJECT SET RGB COLORS:C628(*; "DE ELEM_QTYSTATE@"; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE ELEM_QTYSTATE@"; PON_Color_NotEditable_L)
			OBJECT SET RGB COLORS:C628(*; "DE ELEM_PCTSTATE@"; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE ELEM_PCTSTATE@"; PON_Color_NotEditable_L)
			
			PON_ELEM_PROTSYS_L:=0
			PON_ELEM_DAMAGE_L:=0
			
			POPUPMENUC(->PON_ENVDESC_atxt; ->PON_ENVKEY_aL; ->[PON_ELEM_INSP:179]ENVKEY:5)
			
			If ([PON_ELEM_INSP:179]ELEM_QorP:29)
				bquantity:=1
				bPercent:=0
			Else 
				bquantity:=0
				bPercent:=1
			End if 
			
			PON_ELEMINPUTIL("QUANTPERCENT")
			
			PON_ELEMINPUTIL("SETFILTERS")
			
			//disable all the navigation buttons for new record
			PON_ELEMINP_SetNavControls
			OBJECT SET ENABLED:C1123(*; "DE Actions"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"DE Actions")
			OBJECT SET ENABLED:C1123(*; "DE bDelete"; False:C215)  //disable Delete for new records 
			
		Else 
			// existing element
			QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=[PON_ELEM_INSP:179]ELEM_KEY:3)
			C_BOOLEAN:C305($NBE_b; $Defect_b; $Protsys_b)
			$NBE_b:=([PON_ELEM_DEFS:178]ELEM_NBE_STAT:2="Y")
			$Defect_b:=([PON_ELEM_DEFS:178]ELEM_SMART_FLAG:4="Y")
			$Protsys_b:=([PON_ELEM_DEFS:178]ELEM_PROTECT_SYS:3="Y")
			PON_ELEMUNIT_txt:=[PON_ELEM_DEFS:178]ELEM_SCALEUNIT:13
			PON_ELEM_Defect_b:=$Defect_b
			
			Case of 
				: (Not:C34($Defect_b) & Not:C34($Protsys_b))
					COPY ARRAY:C226(PON_MASTERELEM_Desc_atxt; PON_ELEMSELECT_atxt)
					COPY ARRAY:C226(PON_MASTERELEM_KEY_aL; PON_ELEMSELECT_aL)
				: ($Defect_b)
					COPY ARRAY:C226(PON_SFLAGSELEM_Desc_atxt; PON_ELEMSELECT_atxt)
					COPY ARRAY:C226(PON_SFLAGSELEM_KEY_aL; PON_ELEMSELECT_aL)
				: ($Protsys_b)
					COPY ARRAY:C226(PON_PROTSYSELEM_Desc_atxt; PON_ELEMSELECT_atxt)
					COPY ARRAY:C226(PON_PROTSYSELEM_KEY_aL; PON_ELEMSELECT_aL)
					
			End case 
			PON_ElemNoQuantState1_b:=False:C215
			If ([PON_ELEM_INSP:179]ELEM_PARENT_KEY:4=0)
			Else 
				// use same units as parent if a defect
				If ($Defect_b)
					QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4)
					PON_ELEMUNIT_txt:=[PON_ELEM_DEFS:178]ELEM_SCALEUNIT:13
					PON_ElemNoQuantState1_b:=PON_NoQuantityState1([PON_ELEM_INSP:179]ELEM_KEY:3)
				End if 
				PON_SetElemSelectPulldown([PON_ELEM_INSP:179]ELEM_KEY:3; [PON_ELEM_INSP:179]ELEM_PARENT_KEY:4; ->PON_ELEMSELECT_aL; ->PON_ELEMSELECT_atxt; $Protsys_b)
			End if 
			
			PON_ELEMINPUTIL("SETFILTERS")
			
			PON_ELEMINPUTIL("BUILDELEMCHILD")
			
			Case of 
				: (([PON_ELEM_INSP:179]ELEM_PARENT_KEY:4=0) & $NBE_b)
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
			
			If ([PON_ELEM_INSP:179]ELEM_PARENT_KEY:4>0)  // element has parent cannot change Env
				$EnvPullDownOn_b:=False:C215
			End if 
			
			//Settings for editable or not enviroment
			If (Read only state:C362([PON_ELEM_INSP:179]))
				OBJECT SET ENABLED:C1123(*; "DE @"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENTERABLE:C238(*; "DE @"; False:C215)
				If ([PON_ELEM_INSP:179]ELEM_QorP:29)
					bquantity:=1
					bPercent:=0
				Else 
					bquantity:=0
					bPercent:=1
				End if 
				PON_ELEMINPUTIL("QUANTPERCENT")
				
			Else 
				OBJECT SET ENABLED:C1123(*; "DE @"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENTERABLE:C238(*; "DE @"; True:C214)
				If (Not:C34($EnvPullDownOn_b))
					OBJECT SET ENABLED:C1123(*; "@PON_ENVDESC_atxt"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				End if 
				
				If ([PON_ELEM_INSP:179]ELEM_QorP:29)
					bquantity:=1
					bPercent:=0
				Else 
					bquantity:=0
					bPercent:=1
				End if 
				PON_ELEMINPUTIL("QUANTPERCENT")
				
				If (True:C214 | Not:C34($Defect_b))
					If (PON_ElemNoQuantState1_b)
						OBJECT SET ENTERABLE:C238([PON_ELEM_INSP:179]ELEM_QTYSTATE2:14; False:C215)
						OBJECT SET ENTERABLE:C238([PON_ELEM_INSP:179]ELEM_PCTSTATE2:10; False:C215)
						OBJECT SET RGB COLORS:C628([PON_ELEM_INSP:179]ELEM_QTYSTATE2:14; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([PON_ELEM_INSP]ELEM_QTYSTATE2; PON_Color_NotEditable_L)
						OBJECT SET RGB COLORS:C628([PON_ELEM_INSP:179]ELEM_PCTSTATE2:10; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([PON_ELEM_INSP]ELEM_PCTSTATE2; PON_Color_NotEditable_L)
					End if 
					
				Else 
					If (PON_ElemNoQuantState1_b)
						//enble quantity entry in state 2 - pct staysthe same
						OBJECT SET ENTERABLE:C238([PON_ELEM_INSP:179]ELEM_PCTSTATE2:10; False:C215)
						OBJECT SET RGB COLORS:C628([PON_ELEM_INSP:179]ELEM_PCTSTATE2:10; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([PON_ELEM_INSP]ELEM_PCTSTATE2; PON_Color_NotEditable_L)
					Else 
						//enable qty entry ins tate  1 for defects
						OBJECT SET ENTERABLE:C238([PON_ELEM_INSP:179]ELEM_QTYSTATE1:13; False:C215)
						OBJECT SET RGB COLORS:C628([PON_ELEM_INSP:179]ELEM_QTYSTATE1:13; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([PON_ELEM_INSP]ELEM_QTYSTATE1; PON_Color_NotEditable_L)
					End if 
					
				End if 
				
				If ($Defect_b)
					OBJECT SET VISIBLE:C603(*; "DE Actions"; False:C215)
				Else 
					OBJECT SET VISIBLE:C603(*; "DE Actions"; True:C214)
				End if 
			End if 
			
			POPUPMENUC(->PON_ELEMSELECT_atxt; ->PON_ELEMSELECT_aL; ->[PON_ELEM_INSP:179]ELEM_KEY:3; On Load:K2:1)
			POPUPMENUC(->PON_ENVDESC_atxt; ->PON_ENVKEY_aL; ->[PON_ELEM_INSP:179]ENVKEY:5; On Load:K2:1)
			
			PON_ELEMINP_SetNavControls
		End if 
		
		PON_ELEMINPUTIL("SETPARENT_GP_TXT")
		InDoubleClick_B:=False:C215
		
	: ($FormEvent_L=On Data Change:K2:15)
		// keep q1 not enterable, change others and subtract from total to figure out q1
		
	: ($FormEvent_L=On Validate:K2:3)
		
	: ($FormEvent_L=On Unload:K2:2)
		DELETE FROM ARRAY:C228(PON_ELEMDEPTH_aL; Size of array:C274(PON_ELEMDEPTH_aL))  //event has been disabled for the input form
		
End case 

//End PON_ELEMINP_FM