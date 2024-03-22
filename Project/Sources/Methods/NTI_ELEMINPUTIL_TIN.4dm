//%attributes = {"invisible":true}
// Method: NTI_ELEMINPUTIL_TIN
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 05/20/16, 17:36:55
	// ----------------------------------------------------
	// First Release
	Mods_2016_NTE
	
	C_TEXT:C284(NTI_ELEMINPUTIL_TIN; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(1/19/18 17:41:35)
	Mods_2018_01
	//  `changes to account for multiple states with no quantity allowed
	// Modified by: Costas Manousakis-(Designer)-(3/21/18 09:26:32)
	Mods_2018_03
	//  `protective systems enabled
End if 

//

C_TEXT:C284($1)
C_TEXT:C284($Task_txt)

$Task_txt:=$1

Case of 
	: ($Task_txt="CLEARELEMCHILD")
		C_TEXT:C284($errMethod_txt)
		$errMethod_txt:=Method called on error:C704
		ON ERR CALL:C155("4D_Errors")  //avoid the error if selections don't exist
		CLEAR NAMED SELECTION:C333("PON_NBE_PROTSYS")
		CLEAR NAMED SELECTION:C333("PON_NBE_DAMAGE")
		ON ERR CALL:C155($errMethod_txt)
		PON_ELEM_PROTSYS_L:=0
		PON_ELEM_DAMAGE_L:=0
		
	: ($Task_txt="BUILDELEMCHILD")
		COPY NAMED SELECTION:C331([NTI_ELEM_TIN_INSP:185]; "$TEMPSELECTION")
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		SET QUERY DESTINATION:C396(Into named selection:K19:3; "PON_NBE_PROTSYS")
		QUERY:C277([NTI_ELEM_TIN_INSP:185]; [NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8=[NTI_ELEM_TIN_INSP:185]ELEMID:2; *)
		QUERY:C277([NTI_ELEM_TIN_INSP:185];  & ; [NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21="Y"; *)
		QUERY:C277([NTI_ELEM_TIN_INSP:185])
		USE NAMED SELECTION:C332("PON_NBE_PROTSYS")
		ORDER BY:C49([NTI_ELEM_TIN_INSP:185]; [NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
		PON_ELEM_PROTSYS_L:=Records in selection:C76([NTI_ELEM_TIN_INSP:185])
		COPY NAMED SELECTION:C331([NTI_ELEM_TIN_INSP:185]; "PON_NBE_PROTSYS")
		USE NAMED SELECTION:C332("$TEMPSELECTION")
		SET QUERY DESTINATION:C396(Into named selection:K19:3; "PON_NBE_DAMAGE")
		QUERY:C277([NTI_ELEM_TIN_INSP:185]; [NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8=[NTI_ELEM_TIN_INSP:185]ELEMID:2; *)
		QUERY:C277([NTI_ELEM_TIN_INSP:185];  & ; [NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y"; *)
		//
		QUERY:C277([NTI_ELEM_TIN_INSP:185])
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		USE NAMED SELECTION:C332("PON_NBE_DAMAGE")
		ORDER BY:C49([NTI_ELEM_TIN_INSP:185]; [NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
		PON_ELEM_DAMAGE_L:=Records in selection:C76([NTI_ELEM_TIN_INSP:185])
		COPY NAMED SELECTION:C331([NTI_ELEM_TIN_INSP:185]; "PON_NBE_DAMAGE")
		
		USE NAMED SELECTION:C332("$TEMPSELECTION")
		CLEAR NAMED SELECTION:C333("$TEMPSELECTION")
		
	: ($Task_txt="QUANTPERCENT")
		
		//[NTI_ELEM_TIN_INSP]ELEM_QorP:=(bQuantity=1)
		
		OBJECT SET VISIBLE:C603(*; "@ELEM_QTYSTATE@"; (bQuantity=1))
		If ((bQuantity=1) & Not:C34(Read only state:C362([NTI_ELEM_TIN_INSP:185])))
			OBJECT SET ENTERABLE:C238(*; "DE@ELEM_QTYSTATE@"; True:C214)
			OBJECT SET RGB COLORS:C628(*; "DE@ELEM_QTYSTATE@"; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@ELEM_QTYSTATE@"; PON_Color_Editable_L)
		Else 
			OBJECT SET RGB COLORS:C628(*; "DE@ELEM_QTYSTATE@"; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@ELEM_QTYSTATE@"; PON_Color_NotEditable_L)
		End if 
		OBJECT SET VISIBLE:C603(*; "@ELEM_PCTSTATE@"; (bPercent=1))
		
		If ((bPercent=1) & Not:C34(Read only state:C362([NTI_ELEM_TIN_INSP:185])))
			OBJECT SET ENTERABLE:C238(*; "DE@ELEM_PCTSTATE@"; True:C214)
			OBJECT SET RGB COLORS:C628(*; "DE@ELEM_PCTSTATE@"; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@ELEM_PCTSTATE@"; PON_Color_Editable_L)
		Else 
			OBJECT SET RGB COLORS:C628(*; "DE@ELEM_PCTSTATE@"; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@ELEM_PCTSTATE@"; PON_Color_NotEditable_L)
		End if 
		
		If ([NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7=0)  //main element
			//major element - lock Q1
			OBJECT SET ENTERABLE:C238(*; "DE@ELEM_QTYSTATE1"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "DE@ELEM_QTYSTATE1"; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@ELEM_QTYSTATE1"; PON_Color_NotEditable_L)
		Else   //defect
			
			If (False:C215)
				If (PON_ElemNoQuantState1_b)
					OBJECT SET ENTERABLE:C238(*; "DE@ELEM_QTYSTATE1"; False:C215)
					OBJECT SET RGB COLORS:C628(*; "DE@ELEM_QTYSTATE1"; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@ELEM_QTYSTATE1"; PON_Color_NotEditable_L)
					OBJECT SET ENTERABLE:C238(*; "DE@ELEM_PCTSTATE2"; False:C215)
					OBJECT SET RGB COLORS:C628(*; "DE@ELEM_PCTSTATE2"; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@ELEM_PCTSTATE2"; PON_Color_NotEditable_L)
				Else 
					
				End if 
			End if 
			
			//USE_PON_ElemNoQuantityFlag_L:=True  //use PON_ElemNoQuantityFlag_L instead of PON_ElemNoQuantState1_b
			C_LONGINT:C283($CS_L; $LowestAllowed_L; PON_ElemNoQuantityFlag_L)
			$LowestAllowed_L:=0
			For ($CS_L; 1; 4)
				
				If (PON_ElemNoQuantityFlag_L ?? $CS_L)
					OBJECT SET ENTERABLE:C238(*; "DE@ELEM_QTYSTATE"+String:C10($CS_L); False:C215)
					OBJECT SET RGB COLORS:C628(*; "DE@ELEM_QTYSTATE"+String:C10($CS_L); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@ELEM_QTYSTATE"+String($CS_L); PON_Color_NotEditable_L)
					OBJECT SET ENTERABLE:C238(*; "DE@ELEM_PCTSTATE"+String:C10($CS_L); False:C215)
					OBJECT SET RGB COLORS:C628(*; "DE@ELEM_PCTSTATE"+String:C10($CS_L); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@ELEM_PCTSTATE"+String($CS_L); PON_Color_NotEditable_L)
					
				Else 
					OBJECT SET ENTERABLE:C238(*; "DE@ELEM_QTYSTATE"+String:C10($CS_L); True:C214)
					OBJECT SET RGB COLORS:C628(*; "DE@ELEM_QTYSTATE"+String:C10($CS_L); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@ELEM_QTYSTATE"+String($CS_L); PON_Color_Editable_L)
					
					If ($LowestAllowed_L=0)
						$LowestAllowed_L:=$CS_L
						//for lowest allowed lock the percent - it is calculated automatically
						OBJECT SET ENTERABLE:C238(*; "DE@ELEM_PCTSTATE"+String:C10($CS_L); False:C215)
						OBJECT SET RGB COLORS:C628(*; "DE@ELEM_PCTSTATE"+String:C10($CS_L); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@ELEM_PCTSTATE"+String($CS_L); PON_Color_NotEditable_L)
						
					Else 
						OBJECT SET ENTERABLE:C238(*; "DE@ELEM_PCTSTATE"+String:C10($CS_L); True:C214)
						OBJECT SET RGB COLORS:C628(*; "DE@ELEM_PCTSTATE"+String:C10($CS_L); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@ELEM_PCTSTATE"+String($CS_L); PON_Color_Editable_L)
						
					End if 
					
				End if 
				
			End for   //end CS Loop
			
			
		End if 
		
	: ($Task_txt="SETBINONLY")
		
		OBJECT SET ENABLED:C1123(*; "PON_ELEMSELECT_atxt"; False:C215)
		OBJECT SET ENABLED:C1123(*; "DE Actions"; False:C215)
		OBJECT SET ENABLED:C1123(*; "DE PON_NBE_DAM_LB_add"; False:C215)
		OBJECT SET ENABLED:C1123(*; "DE bQuantity"; False:C215)
		OBJECT SET ENABLED:C1123(*; "DE bPercent"; False:C215)
		
		OBJECT SET ENTERABLE:C238(*; "DE ELEM_QUANTITY1"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "@PCTSTATE@"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "@QTYSTATE@"; False:C215)
		
	: ($Task_txt="SETTINONLY")
		
		OBJECT SET ENABLED:C1123(*; "PON_ELEMSELECT_atxt"; True:C214)
		OBJECT SET ENABLED:C1123(*; "DE Actions"; True:C214)
		OBJECT SET ENABLED:C1123(*; "DE PON_NBE_DAM_LB_add"; True:C214)
		OBJECT SET ENABLED:C1123(*; "DE bQuantity"; True:C214)
		OBJECT SET ENABLED:C1123(*; "DE bPercent"; True:C214)
		
	: ($Task_txt="RESETUI")
		
		NTI_ELEMINPUTIL_TIN("BUILDELEMCHILD")
		
		QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
		NTI_SetElemSelectPulldown([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3; [NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7; ->PON_ELEMSELECT_aL; ->PON_ELEMSELECT_atxt; ([NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21="Y"))
		C_BOOLEAN:C305($BinOnly_b)
		$BinOnly_b:=False:C215
		PON_ELEMUNIT_txt:=[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12
		PON_ElemNoQuantState1_b:=False:C215
		PON_ElemNoQuantityFlag_L:=0
		$BinOnly_b:=Not:C34([NTI_ELEM_DEFS:182]ELEM_TIN_ONLY:19="Y")
		
		If ([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y")
			//defects / smart flags get parent units
			QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7)
			
			$BinOnly_b:=Not:C34([NTI_ELEM_DEFS:182]ELEM_TIN_ONLY:19="Y")
			
			PON_ELEMUNIT_txt:=[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12
			PON_ElemNoQuantState1_b:=NTI_NoQuantityState1([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
			PON_ElemNoQuantityFlag_L:=NTI_NoQuantityState([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
			OBJECT SET VISIBLE:C603(*; "DE Actions"; False:C215)
		Else 
			//_ o _ENABLE BUTTON(*;"DE Actions")
			OBJECT SET ENABLED:C1123(*; "DE Actions"; True:C214)
			OBJECT SET VISIBLE:C603(*; "DE Actions"; True:C214)
		End if 
		If (PON_ELEMUNIT_txt="each")
			//default to quantity and don't switch from it
			OBJECT SET VISIBLE:C603(*; "DE bQuantity@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "DE bPercent@"; False:C215)
		End if 
		If ([NTI_ELEM_TIN_INSP:185]ELEM_QorP:16)  //set the radio buttons
			bquantity:=1
			bPercent:=0
		Else 
			bquantity:=0
			bPercent:=1
		End if 
		NTI_ELEMINPUTIL_TIN("QUANTPERCENT")
		//reset the element select pulldown array and env key
		//POPUPMENUC (->PON_ELEMSELECT_atxt;->PON_ELEMSELECT_aL;->[NTI_ELEM_TIN_INSP]ELEM_KEY)
		C_LONGINT:C283($key_L)
		$key_L:=Find in array:C230(PON_ELEMSELECT_aL; [NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
		If ($key_L>0)
			PON_ELEMSELECT_atxt:=$key_L
		Else 
			PON_ELEMSELECT_atxt:=0
		End if 
		//POPUPMENUC (->PON_ENVDESC_atxt;->PON_ENVKEY_aL;->[NTI_ELEM_TIN_INSP]ENVKEY)
		NTI_ELEMINPUTIL_TIN("SETPARENT_GP_TXT")
		NTI_ELEMINP_SetNavControls(->[NTI_ELEM_TIN_INSP:185])
		If ($BinOnly_b)
			NTI_ELEMINPUTIL_TIN("SETBINONLY")
		Else 
			NTI_ELEMINPUTIL_TIN("SETTINONLY")
		End if 
		
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
		OBJECT SET FILTER:C235([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; $QFilter_txt)
		OBJECT SET FORMAT:C236(*; "@ELEM_QTYSTATE@"; $qFormat_txt)
		OBJECT SET FORMAT:C236([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; $qFormat_txt)
		
	: ($Task_txt="SETPARENT_GP_TXT")
		PON_ELEMPARENT_txt:=""
		C_LONGINT:C283(PON_SEARCHKEY_L)
		OBJECT SET VISIBLE:C603(*; "PON_ELEM_PARENT@"; ([NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7>0))
		If ([NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7>0)
			PON_SEARCHKEY_L:=[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7
			OBJECT SET VISIBLE:C603(*; "PON_ELEM_PARENT@"; True:C214)
			Begin SQL
				select [NTI_ELEM_DEFS].ELEM_SHORTNAME from [NTI_ELEM_DEFS]
				where [NTI_ELEM_DEFS].ELEM_KEY = :PON_SEARCHKEY_L
				into :PON_ELEMPARENT_txt ;
			End SQL
			
			//now check if we have to get other defect quantities.
			C_BOOLEAN:C305($Defect_b)
			$Defect_b:=False:C215
			If ([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3>0)
				QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
				$Defect_b:=([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y")
				
			Else 
				//dont'have a key yet - new record - can use var PON_ADDPROTSYS_B
				$Defect_b:=Not:C34(PON_ADDPROTSYS_B)
			End if 
			
			
			C_REAL:C285(v_179_007_r)
			v_179_007_r:=0
			If ([NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8>0)
				
				If ($Defect_b)
					PON_SEARCHKEY_L:=[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8
					C_LONGINT:C283($MyCurrID_L)
					$MyCurrID_L:=[NTI_ELEM_TIN_INSP:185]ELEMID:2
					
					Begin SQL
						select [NTI_ELEM_TIN_INSP].ELEM_QUANTITY from [NTI_ELEM_TIN_INSP]
						where [NTI_ELEM_TIN_INSP].ELEMID = :PON_SEARCHKEY_L
						into :v_179_007_r ;
					End SQL
					If (v_179_007_r>0)
						PON_ELEMPARENT_txt:=PON_ELEMPARENT_txt+" - Tot Q = "+String:C10(Round:C94(v_179_007_r; 2); "###,###,###,###.##")
					End if 
					
					C_REAL:C285($OtherDefQ_r)
					
					Begin SQL
						select sum([NTI_ELEM_TIN_INSP].ELEM_QUANTITY) from [NTI_ELEM_TIN_INSP] , [NTI_ELEM_DEFS]
						where [NTI_ELEM_TIN_INSP].ELEM_PARENT_ID = :PON_SEARCHKEY_L
						and [NTI_ELEM_TIN_INSP].ELEMID <> :$MyCurrID_L
						and [NTI_ELEM_DEFS].ELEM_KEY = [NTI_ELEM_TIN_INSP].ELEM_KEY
						and [NTI_ELEM_DEFS].DEFECTFLAG = 'Y'
						into :$OtherDefQ_r ;
					End SQL
					
					PON_ELEMPARENT_txt:=PON_ELEMPARENT_txt+"  Q Avail = "+String:C10(Round:C94(v_179_007_r; 2)-Round:C94($OtherDefQ_r; 2); "###,###,###,###.##")
				End if 
			End if 
			
		End if 
		
		PON_ELEMGRANDP_txt:=""
		OBJECT SET VISIBLE:C603(*; "PON_ELEM_GRANDPARENT@"; ([NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_KEY:25>0))
		If ([NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_KEY:25>0)
			PON_SEARCHKEY_L:=[NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_KEY:25
			OBJECT SET VISIBLE:C603(*; "PON_ELEM_GRANDPARENT@"; True:C214)
			Begin SQL
				select [NTI_ELEM_DEFS].ELEM_SHORTNAME from [NTI_ELEM_DEFS]
				where [NTI_ELEM_DEFS].ELEM_KEY = :PON_SEARCHKEY_L
				into :PON_ELEMGRANDP_txt ;
			End SQL
		End if 
		
End case 
//End NTI_ELEMINPUTIL