//%attributes = {"invisible":true}
// Method: PON_ELEMINPUTIL
// Description
// Utitlity method for NBE Element input form
// 
// Parameters
// $1 : $Task_txt
//  `Options : CLEARELEMCHILD | BUILDELEMCHILD | QUANTPERCENT | RESETUI
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/18/15, 17:38:41
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
	// Modified by: Costas Manousakis-(Designer)-(9/25/15 17:35:49)
	Mods_2015_09_bug
	//  `added  task option "SETPARENT_GP_TXT"
	//  `use this task under "RESETUI"
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
		COPY NAMED SELECTION:C331([PON_ELEM_INSP:179]; "$TEMPSELECTION")
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		SET QUERY DESTINATION:C396(Into named selection:K19:3; "PON_NBE_PROTSYS")
		QUERY:C277([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_PARENTID:27=[PON_ELEM_INSP:179]ELEMID:22; *)
		QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_DEFS:178]ELEM_PROTECT_SYS:3="Y"; *)
		QUERY:C277([PON_ELEM_INSP:179])
		USE NAMED SELECTION:C332("PON_NBE_PROTSYS")
		ORDER BY:C49([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_KEY:3)
		PON_ELEM_PROTSYS_L:=Records in selection:C76([PON_ELEM_INSP:179])
		COPY NAMED SELECTION:C331([PON_ELEM_INSP:179]; "PON_NBE_PROTSYS")
		USE NAMED SELECTION:C332("$TEMPSELECTION")
		SET QUERY DESTINATION:C396(Into named selection:K19:3; "PON_NBE_DAMAGE")
		QUERY:C277([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_PARENTID:27=[PON_ELEM_INSP:179]ELEMID:22; *)
		QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_DEFS:178]ELEM_SMART_FLAG:4="Y"; *)
		//
		QUERY:C277([PON_ELEM_INSP:179])
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		USE NAMED SELECTION:C332("PON_NBE_DAMAGE")
		ORDER BY:C49([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_KEY:3)
		PON_ELEM_DAMAGE_L:=Records in selection:C76([PON_ELEM_INSP:179])
		COPY NAMED SELECTION:C331([PON_ELEM_INSP:179]; "PON_NBE_DAMAGE")
		
		USE NAMED SELECTION:C332("$TEMPSELECTION")
		CLEAR NAMED SELECTION:C333("$TEMPSELECTION")
		
	: ($Task_txt="QUANTPERCENT")
		
		//[PON_ELEM_INSP]ELEM_QorP:=(bQuantity=1)
		
		OBJECT SET VISIBLE:C603(*; "@ELEM_QTYSTATE@"; (bQuantity=1))
		OBJECT SET ENTERABLE:C238(*; "DE@ELEM_QTYSTATE@"; ((bQuantity=1) & Not:C34(Read only state:C362([PON_ELEM_INSP:179]))))
		OBJECT SET VISIBLE:C603(*; "@ELEM_PCTSTATE@"; (bPercent=1))
		OBJECT SET ENTERABLE:C238(*; "DE@ELEM_PCTSTATE@"; ((bPercent=1) & Not:C34(Read only state:C362([PON_ELEM_INSP:179]))))
		
	: ($Task_txt="RESETUI")
		
		PON_ELEMINPUTIL("BUILDELEMCHILD")
		If ([PON_ELEM_INSP:179]ELEM_PARENT_KEY:4>0)  //element has parent cannot change Env
			OBJECT SET ENABLED:C1123(*; "DE PON_ENVDESC_atxt"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=[PON_ELEM_INSP:179]ELEM_KEY:3)
		PON_SetElemSelectPulldown([PON_ELEM_INSP:179]ELEM_KEY:3; [PON_ELEM_INSP:179]ELEM_PARENT_KEY:4; ->PON_ELEMSELECT_aL; ->PON_ELEMSELECT_atxt; ([PON_ELEM_DEFS:178]ELEM_PROTECT_SYS:3="Y"))
		
		PON_ELEMUNIT_txt:=[PON_ELEM_DEFS:178]ELEM_SCALEUNIT:13
		PON_ElemNoQuantState1_b:=False:C215
		If ([PON_ELEM_DEFS:178]ELEM_SMART_FLAG:4="Y")
			//defects / smart flags get parent units
			QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4)
			PON_ELEMUNIT_txt:=[PON_ELEM_DEFS:178]ELEM_SCALEUNIT:13
			PON_ElemNoQuantState1_b:=PON_NoQuantityState1([PON_ELEM_INSP:179]ELEM_KEY:3)
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
		If ([PON_ELEM_INSP:179]ELEM_QorP:29)  //set the radio buttons
			bquantity:=1
			bPercent:=0
		Else 
			bquantity:=0
			bPercent:=1
		End if 
		PON_ELEMINPUTIL("QUANTPERCENT")
		//reset the element select pulldown array and env key
		//POPUPMENUC (->PON_ELEMSELECT_atxt;->PON_ELEMSELECT_aL;->[PON_ELEM_INSP]ELEM_KEY)
		C_LONGINT:C283($key_L)
		$key_L:=Find in array:C230(PON_ELEMSELECT_aL; [PON_ELEM_INSP:179]ELEM_KEY:3)
		If ($key_L>0)
			PON_ELEMSELECT_atxt:=$key_L
		Else 
			PON_ELEMSELECT_atxt:=0
		End if 
		//POPUPMENUC (->PON_ENVDESC_atxt;->PON_ENVKEY_aL;->[PON_ELEM_INSP]ENVKEY)
		PON_ELEMINPUTIL("SETPARENT_GP_TXT")
		PON_ELEMINP_SetNavControls
		
		
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
		OBJECT SET FILTER:C235([PON_ELEM_INSP:179]ELEM_QUANTITY:7; $QFilter_txt)
		OBJECT SET FORMAT:C236(*; "@ELEM_QTYSTATE@"; $qFormat_txt)
		OBJECT SET FORMAT:C236([PON_ELEM_INSP:179]ELEM_QUANTITY:7; $qFormat_txt)
		
	: ($Task_txt="SETPARENT_GP_TXT")
		PON_ELEMPARENT_txt:=""
		C_LONGINT:C283(PON_SEARCHKEY_L)
		OBJECT SET VISIBLE:C603(*; "PON_ELEM_PARENT@"; ([PON_ELEM_INSP:179]ELEM_PARENT_KEY:4>0))
		If ([PON_ELEM_INSP:179]ELEM_PARENT_KEY:4>0)
			PON_SEARCHKEY_L:=[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4
			OBJECT SET VISIBLE:C603(*; "PON_ELEM_PARENT@"; True:C214)
			Begin SQL
				select [PON_ELEM_DEFS].ELEM_SHORTNAME from [PON_ELEM_DEFS]
				where [PON_ELEM_DEFS].ELEM_KEY = :PON_SEARCHKEY_L
				into :PON_ELEMPARENT_txt ;
			End SQL
			
			C_REAL:C285(v_179_007_r)
			v_179_007_r:=0
			If ([PON_ELEM_INSP:179]ELEM_PARENTID:27>0)
				PON_SEARCHKEY_L:=[PON_ELEM_INSP:179]ELEM_PARENTID:27
				Begin SQL
					select [PON_ELEM_INSP].ELEM_QUANTITY from [PON_ELEM_INSP]
					where [PON_ELEM_INSP].ELEMID = :PON_SEARCHKEY_L
					into :v_179_007_r ;
				End SQL
				If (v_179_007_r>0)
					PON_ELEMPARENT_txt:=PON_ELEMPARENT_txt+" - Tot Q = "+String:C10(Round:C94(v_179_007_r; 2); "###,###,###,###.##")
				End if 
				
			End if 
			
		End if 
		
		PON_ELEMGRANDP_txt:=""
		OBJECT SET VISIBLE:C603(*; "PON_ELEM_GRANDPARENT@"; ([PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19>0))
		If ([PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19>0)
			PON_SEARCHKEY_L:=[PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19
			OBJECT SET VISIBLE:C603(*; "PON_ELEM_GRANDPARENT@"; True:C214)
			Begin SQL
				select [PON_ELEM_DEFS].ELEM_SHORTNAME from [PON_ELEM_DEFS]
				where [PON_ELEM_DEFS].ELEM_KEY = :PON_SEARCHKEY_L
				into :PON_ELEMGRANDP_txt ;
			End SQL
		End if 
		
End case 
//End PON_ELEMINPUTIL