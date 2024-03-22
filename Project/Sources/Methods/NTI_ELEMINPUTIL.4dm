//%attributes = {"invisible":true}
//Method: NTI_ELEMINPUTIL
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/22/16, 12:00:24
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_TEXT:C284(NTI_ELEMINPUTIL; $1)
	
End if 
//

C_TEXT:C284($1)
C_TEXT:C284($Task_txt)

$Task_txt:=$1

Case of 
	: ($Task_txt="CLEARELEMCHILD")
		CLEAR NAMED SELECTION:C333("PON_NBE_PROTSYS")
		CLEAR NAMED SELECTION:C333("PON_NBE_DAMAGE")
		PON_ELEM_PROTSYS_L:=0
		PON_ELEM_DAMAGE_L:=0
		
	: ($Task_txt="BUILDELEMCHILD")
		COPY NAMED SELECTION:C331([NTI_ELEM_BIN_INSP:183]; "$TEMPSELECTION")
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		SET QUERY DESTINATION:C396(Into named selection:K19:3; "PON_NBE_PROTSYS")
		QUERY:C277([NTI_ELEM_BIN_INSP:183]; [NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8=[NTI_ELEM_BIN_INSP:183]ELEMID:2; *)
		QUERY:C277([NTI_ELEM_BIN_INSP:183])
		USE NAMED SELECTION:C332("PON_NBE_PROTSYS")
		ORDER BY:C49([NTI_ELEM_BIN_INSP:183]; [NTI_ELEM_BIN_INSP:183]ELEM_KEY:3)
		PON_ELEM_PROTSYS_L:=Records in selection:C76([NTI_ELEM_BIN_INSP:183])
		COPY NAMED SELECTION:C331([NTI_ELEM_BIN_INSP:183]; "PON_NBE_PROTSYS")
		USE NAMED SELECTION:C332("$TEMPSELECTION")
		SET QUERY DESTINATION:C396(Into named selection:K19:3; "PON_NBE_DAMAGE")
		QUERY:C277([NTI_ELEM_BIN_INSP:183]; [NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8=[NTI_ELEM_BIN_INSP:183]ELEMID:2; *)
		QUERY:C277([NTI_ELEM_BIN_INSP:183];  & ; [NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y"; *)
		//
		QUERY:C277([NTI_ELEM_BIN_INSP:183])
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		USE NAMED SELECTION:C332("PON_NBE_DAMAGE")
		ORDER BY:C49([NTI_ELEM_BIN_INSP:183]; [NTI_ELEM_BIN_INSP:183]ELEM_KEY:3)
		PON_ELEM_DAMAGE_L:=Records in selection:C76([NTI_ELEM_BIN_INSP:183])
		COPY NAMED SELECTION:C331([NTI_ELEM_BIN_INSP:183]; "PON_NBE_DAMAGE")
		
		USE NAMED SELECTION:C332("$TEMPSELECTION")
		CLEAR NAMED SELECTION:C333("$TEMPSELECTION")
		
	: ($Task_txt="QUANTPERCENT")
		
		//[nti_elem_bin_insp]ELEM_QorP:=(bQuantity=1)
		
		OBJECT SET VISIBLE:C603(*; "@ELEM_QTYSTATE@"; (bQuantity=1))
		If ((bQuantity=1) & Not:C34(Read only state:C362([NTI_ELEM_BIN_INSP:183])))
			OBJECT SET ENTERABLE:C238(*; "DE@ELEM_QTYSTATE@"; True:C214)
			OBJECT SET RGB COLORS:C628(*; "DE@ELEM_QTYSTATE@"; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@ELEM_QTYSTATE@"; PON_Color_Editable_L)
		Else 
			OBJECT SET RGB COLORS:C628(*; "DE@ELEM_QTYSTATE@"; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@ELEM_QTYSTATE@"; PON_Color_NotEditable_L)
		End if 
		OBJECT SET VISIBLE:C603(*; "@ELEM_PCTSTATE@"; (bPercent=1))
		
		If ((bPercent=1) & Not:C34(Read only state:C362([NTI_ELEM_BIN_INSP:183])))
			OBJECT SET ENTERABLE:C238(*; "DE@ELEM_PCTSTATE@"; True:C214)
			OBJECT SET RGB COLORS:C628(*; "DE@ELEM_PCTSTATE@"; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@ELEM_PCTSTATE@"; PON_Color_Editable_L)
		Else 
			OBJECT SET RGB COLORS:C628(*; "DE@ELEM_PCTSTATE@"; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@ELEM_PCTSTATE@"; PON_Color_NotEditable_L)
		End if 
		
		If ([NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7=0)
			//major element - lock Q1
			OBJECT SET ENTERABLE:C238(*; "DE@ELEM_QTYSTATE1"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "DE@ELEM_QTYSTATE1"; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@ELEM_QTYSTATE1"; PON_Color_NotEditable_L)
		Else 
			
			If (PON_ElemNoQuantState1_b)
				OBJECT SET ENTERABLE:C238(*; "DE@ELEM_QTYSTATE1"; False:C215)
				OBJECT SET RGB COLORS:C628(*; "DE@ELEM_QTYSTATE1"; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@ELEM_QTYSTATE1"; PON_Color_NotEditable_L)
				OBJECT SET ENTERABLE:C238(*; "DE@ELEM_PCTSTATE2"; False:C215)
				OBJECT SET RGB COLORS:C628(*; "DE@ELEM_PCTSTATE2"; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@ELEM_PCTSTATE2"; PON_Color_NotEditable_L)
			Else 
				
			End if 
			
		End if 
		
	: ($Task_txt="RESETUI")
		
		NTI_ELEMINPUTIL("BUILDELEMCHILD")
		If ([NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7>0)  //element has parent cannot change Env
			OBJECT SET ENABLED:C1123(*; "DE PON_ENVDESC_atxt"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_BIN_INSP:183]ELEM_KEY:3)
		NTI_SetElemSelectPulldown([NTI_ELEM_BIN_INSP:183]ELEM_KEY:3; [NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7; ->PON_ELEMSELECT_aL; ->PON_ELEMSELECT_atxt)
		
		PON_ELEMUNIT_txt:=[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12
		PON_ElemNoQuantState1_b:=False:C215
		If ([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y")
			//defects / smart flags get parent units
			QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7)
			PON_ELEMUNIT_txt:=[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12
			PON_ElemNoQuantState1_b:=NTI_NoQuantityState1([NTI_ELEM_BIN_INSP:183]ELEM_KEY:3)
			OBJECT SET VISIBLE:C603(*; "DE Actions"; False:C215)
		Else 
			OBJECT SET ENABLED:C1123(*; "DE Actions"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET VISIBLE:C603(*; "DE Actions"; True:C214)
		End if 
		If (PON_ELEMUNIT_txt="each")
			//default to quantity and don't switch from it
			OBJECT SET VISIBLE:C603(*; "DE bQuantity@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "DE bPercent@"; False:C215)
		End if 
		If ([NTI_ELEM_BIN_INSP:183]ELEM_QorP:16)  //set the radio buttons
			bquantity:=1
			bPercent:=0
		Else 
			bquantity:=0
			bPercent:=1
		End if 
		NTI_ELEMINPUTIL("QUANTPERCENT")
		//reset the element select pulldown array and env key
		//POPUPMENUC (->PON_ELEMSELECT_atxt;->PON_ELEMSELECT_aL;->[nti_elem_bin_insp]ELEM_KEY)
		C_LONGINT:C283($key_L)
		$key_L:=Find in array:C230(PON_ELEMSELECT_aL; [NTI_ELEM_BIN_INSP:183]ELEM_KEY:3)
		If ($key_L>0)
			PON_ELEMSELECT_atxt:=$key_L
		Else 
			PON_ELEMSELECT_atxt:=0
		End if 
		//POPUPMENUC (->PON_ENVDESC_atxt;->PON_ENVKEY_aL;->[nti_elem_bin_insp]ENVKEY)
		NTI_ELEMINPUTIL("SETPARENT_GP_TXT")
		NTI_ELEMINP_SetNavControls(->[NTI_ELEM_BIN_INSP:183])
		
		
	: ($Task_txt="SETFILTERS")
		C_TEXT:C284($QFilter_txt; $qFormat_txt)
		If (PON_ELEMUNIT_txt="each")
			$QFilter_txt:="&9"
			$qFormat_txt:="###,###,###,###,###,###,##0"
		Else 
			$QFilter_txt:="|PosReals"
			$qFormat_txt:="###,###,###,###,###,###,###.00"
		End if 
		OBJECT SET FILTER:C235(*; "@ELEM_QTYSTATE@"; $QFilter_txt)
		OBJECT SET FILTER:C235([NTI_ELEM_BIN_INSP:183]ELEM_QUANTITY:21; $QFilter_txt)
		OBJECT SET FORMAT:C236(*; "@ELEM_QTYSTATE@"; $qFormat_txt)
		OBJECT SET FORMAT:C236([NTI_ELEM_BIN_INSP:183]ELEM_QUANTITY:21; $qFormat_txt)
		
	: ($Task_txt="SETPARENT_GP_TXT")
		PON_ELEMPARENT_txt:=""
		C_LONGINT:C283(PON_SEARCHKEY_L)
		OBJECT SET VISIBLE:C603(*; "PON_ELEM_PARENT@"; ([NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7>0))
		If ([NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7>0)
			PON_SEARCHKEY_L:=[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7
			OBJECT SET VISIBLE:C603(*; "PON_ELEM_PARENT@"; True:C214)
			Begin SQL
				select [NTI_ELEM_DEFS].ELEM_SHORTNAME from [NTI_ELEM_DEFS]
				where [NTI_ELEM_DEFS].ELEM_KEY = :PON_SEARCHKEY_L
				into :PON_ELEMPARENT_txt ;
			End SQL
			
			C_REAL:C285(v_179_007_r)
			v_179_007_r:=0
			If ([NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8>0)
				PON_SEARCHKEY_L:=[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8
				Begin SQL
					select [nti_elem_bin_insp].ELEM_QUANTITY from [nti_elem_bin_insp]
					where [nti_elem_bin_insp].ELEMID = :PON_SEARCHKEY_L
					into :v_179_007_r ;
				End SQL
				If (v_179_007_r>0)
					PON_ELEMPARENT_txt:=PON_ELEMPARENT_txt+" - Tot Q = "+String:C10(Round:C94(v_179_007_r; 2); "###,###,###,###.##")
				End if 
				
			End if 
			
		End if 
		
End case 
//End NTI_ELEMINPUTIL