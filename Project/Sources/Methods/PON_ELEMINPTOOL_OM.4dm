//%attributes = {"invisible":true}
// Method: PON_ELEMINPTOOL_OM
// Description
// method for the Tool button in the pon element input form
// 
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 04/07/15, 16:23:21
	// ----------------------------------------------------
	// First Release
	Mods_2015_04
	// Modified by: Costas Manousakis-(Designer)-(2/10/16 11:56:06)
	Mods_2016_02_bug
	//  `Account for Damage element which must be included in other defects
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Mouse Enter:K2:33)
		ut_GenericHelp_OM("Element Quantity Tools")
	: ($FormEvent_L=On Mouse Leave:K2:34)
		ut_GenericHelp_OM
	: ($FormEvent_L=On Clicked:K2:4)
		C_LONGINT:C283($Choise_L)
		$Choise_L:=Pop up menu:C542("Check Quantities;Roll up Defect States;")
		If ($Choise_L>0)
			C_REAL:C285(v_179_016_r; v_179_015_r; v_179_014_r; v_179_013_r; v_179_007_r)
			C_LONGINT:C283(v_179_027_l)
			v_179_027_l:=[PON_ELEM_INSP:179]ELEMID:22
			
			Begin SQL
				select count(*), sum([PON_ELEM_INSP].ELEM_QUANTITY), sum([PON_ELEM_INSP].ELEM_QTYSTATE1), sum([PON_ELEM_INSP].ELEM_QTYSTATE2)
				, sum([PON_ELEM_INSP].ELEM_QTYSTATE3),
				sum([PON_ELEM_INSP].ELEM_QTYSTATE4)
				from [PON_ELEM_INSP], [PON_ELEM_DEFS]
				where 
				[PON_ELEM_DEFS].ELEM_KEY = [PON_ELEM_INSP].ELEM_KEY
				and [PON_ELEM_INSP].ELEM_PARENTID = :v_179_027_l
				and [PON_ELEM_DEFS].ELEM_SMART_FLAG = 'Y'
				and [PON_ELEM_INSP].ELEM_KEY <> 7000
				into :v_179_003_l, :v_179_007_r, :v_179_013_r, :v_179_014_r, :v_179_015_r, :v_179_016_r ;
			End SQL
			
		End if 
		Case of 
			: ($Choise_L=1)
				C_TEXT:C284($ErrMsg_txt)
				$ErrMsg_txt:=""
				If (v_179_007_r>[PON_ELEM_INSP:179]ELEM_QUANTITY:7)
					$ErrMsg_txt:=$ErrMsg_txt+"ERROR : Sum of Total Quantities of Defect(s) = "+String:C10(v_179_007_r)+"  EXCEEDS Total Quantity of Element = "+String:C10([PON_ELEM_INSP:179]ELEM_QUANTITY:7)+Char:C90(13)
				End if 
				//$ErrMsg_txt:=$ErrMsg_txt+PON_CompareState (1;v_179_013_r;[PON_ELEM_INSP]ELEM_QTYSTATE1)  ` cannot compare state 1
				$ErrMsg_txt:=$ErrMsg_txt+PON_CompareState(2; v_179_014_r; [PON_ELEM_INSP:179]ELEM_QTYSTATE2:14)
				$ErrMsg_txt:=$ErrMsg_txt+PON_CompareState(3; v_179_015_r; [PON_ELEM_INSP:179]ELEM_QTYSTATE3:15)
				$ErrMsg_txt:=$ErrMsg_txt+PON_CompareState(4; v_179_016_r; [PON_ELEM_INSP:179]ELEM_QTYSTATE4:16)
				//need to check if Damage quantities exceed other defects
				C_REAL:C285($DefQ_r; $DefQ1_r; $DefQ2_r; $DefQ3_r; $DefQ4_r)
				$DefQ_r:=v_179_007_r
				$DefQ2_r:=v_179_014_r
				$DefQ3_r:=v_179_015_r
				$DefQ4_r:=v_179_016_r
				Begin SQL
					select count(*), sum([PON_ELEM_INSP].ELEM_QUANTITY), sum([PON_ELEM_INSP].ELEM_QTYSTATE1), sum([PON_ELEM_INSP].ELEM_QTYSTATE2)
					, sum([PON_ELEM_INSP].ELEM_QTYSTATE3),
					sum([PON_ELEM_INSP].ELEM_QTYSTATE4)
					from [PON_ELEM_INSP], [PON_ELEM_DEFS]
					where 
					[PON_ELEM_DEFS].ELEM_KEY = [PON_ELEM_INSP].ELEM_KEY
					and [PON_ELEM_INSP].ELEM_PARENTID = :v_179_027_l
					and [PON_ELEM_INSP].ELEM_KEY = 7000
					into :v_179_003_l, :v_179_007_r, :v_179_013_r, :v_179_014_r, :v_179_015_r, :v_179_016_r ;
				End SQL
				
				If (v_179_003_l>0)  // this is the count  - ie found a damage element
					If (v_179_007_r>$DefQ_r)
						$ErrMsg_txt:=$ErrMsg_txt+"ERROR : Sum of Damage (7000) Total Quantity = "+String:C10(v_179_007_r)+"  EXCEEDS Total Quantity of other Defects = "+String:C10($DefQ_r)+Char:C90(13)
					End if 
					If (v_179_014_r>$DefQ2_r)
						$ErrMsg_txt:=$ErrMsg_txt+"ERROR : Damage (7000) Quantity in State 2 = "+String:C10(v_179_014_r)+"  EXCEEDS Total Quantity in State 2 of other Defects = "+String:C10($DefQ2_r)+Char:C90(13)
					End if 
					If (v_179_015_r>$DefQ3_r)
						$ErrMsg_txt:=$ErrMsg_txt+"ERROR : Damage (7000) Quantity in State 3 = "+String:C10(v_179_015_r)+"  EXCEEDS Total Quantity in State 3 of other Defects = "+String:C10($DefQ3_r)+Char:C90(13)
					End if 
					If (v_179_016_r>$DefQ4_r)
						$ErrMsg_txt:=$ErrMsg_txt+"ERROR : Damage (7000) Quantity in State 4 = "+String:C10(v_179_016_r)+"  EXCEEDS Total Quantity in State 4 of other Defects = "+String:C10($DefQ4_r)+Char:C90(13)
					End if 
					
				End if 
				If ($ErrMsg_txt#"")
					ut_BigAlert($ErrMsg_txt)
				Else 
					ALERT:C41("All Quantities are OK")
				End if 
				
			: ($Choise_L=2)
				//verify still~~
				//all we need to check is the sum of total defect q <= current quantity
				If (v_179_003_l>0)
					If (v_179_007_r<=[PON_ELEM_INSP:179]ELEM_QUANTITY:7)
						[PON_ELEM_INSP:179]ELEM_QTYSTATE4:16:=v_179_016_r
						[PON_ELEM_INSP:179]ELEM_QTYSTATE3:15:=v_179_015_r
						[PON_ELEM_INSP:179]ELEM_QTYSTATE2:14:=v_179_014_r
						[PON_ELEM_INSP:179]ELEM_QTYSTATE1:13:=[PON_ELEM_INSP:179]ELEM_QUANTITY:7-[PON_ELEM_INSP:179]ELEM_QTYSTATE2:14-[PON_ELEM_INSP:179]ELEM_QTYSTATE3:15-[PON_ELEM_INSP:179]ELEM_QTYSTATE4:16
						[PON_ELEM_INSP:179]ELEM_PCTSTATE2:10:=Round:C94(100*[PON_ELEM_INSP:179]ELEM_QTYSTATE2:14/[PON_ELEM_INSP:179]ELEM_QUANTITY:7; PON_RoundP_L)
						[PON_ELEM_INSP:179]ELEM_PCTSTATE3:11:=Round:C94(100*[PON_ELEM_INSP:179]ELEM_QTYSTATE3:15/[PON_ELEM_INSP:179]ELEM_QUANTITY:7; PON_RoundP_L)
						[PON_ELEM_INSP:179]ELEM_PCTSTATE4:12:=Round:C94(100*[PON_ELEM_INSP:179]ELEM_QTYSTATE4:16/[PON_ELEM_INSP:179]ELEM_QUANTITY:7; PON_RoundP_L)
						[PON_ELEM_INSP:179]ELEM_PCTSTATE1:9:=100-[PON_ELEM_INSP:179]ELEM_PCTSTATE2:10-[PON_ELEM_INSP:179]ELEM_PCTSTATE3:11-[PON_ELEM_INSP:179]ELEM_PCTSTATE4:12
					Else 
						ALERT:C41("Sum of Defect Quantities ("+String:C10(v_179_007_r)+") is greater than Element Total Quantity ("+String:C10([PON_ELEM_INSP:179]ELEM_QUANTITY:7)+"). Roll up of defect State Quantities not done!")
					End if 
				Else 
					ALERT:C41("There are no non-Damage (7000) Defects Assigned to this Element!")
				End if 
				//need to update percentages
				
		End case 
		
End case 

//End PON_ELEMINPTOOL_OM