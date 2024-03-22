//%attributes = {"invisible":true}
// Method: NTI_ELEMINPTOOL_OM_TIN  
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 05/20/16, 17:34:50
	// ----------------------------------------------------
	// First Release
	Mods_2016_NTE
	
	C_LONGINT:C283(NTI_ELEMINPTOOL_OM_TIN; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(1/12/18 17:06:57)
	Mods_2018_01
	//  `update element condition rating when rolling up quantities
End if 

//
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
			C_LONGINT:C283(v_179_027_l; v_179_003_l)
			v_179_027_l:=[NTI_ELEM_TIN_INSP:185]ELEMID:2
			
			Begin SQL
				select count(*), sum([NTI_ELEM_TIN_INSP].ELEM_QUANTITY), sum([NTI_ELEM_TIN_INSP].ELEM_QTYSTATE1), sum([NTI_ELEM_TIN_INSP].ELEM_QTYSTATE2)
				, sum([NTI_ELEM_TIN_INSP].ELEM_QTYSTATE3),
				sum([NTI_ELEM_TIN_INSP].ELEM_QTYSTATE4)
				from [NTI_ELEM_TIN_INSP], [NTI_ELEM_DEFS]
				where 
				[NTI_ELEM_DEFS].ELEM_KEY = [NTI_ELEM_TIN_INSP].ELEM_KEY
				and [NTI_ELEM_TIN_INSP].ELEM_PARENT_ID = :v_179_027_l
				and [NTI_ELEM_DEFS].[DEFECTFLAG] = 'Y'
				/* and [NTI_ELEM_TIN_INSP].ELEM_KEY <> 7000CHECKTHIS */
				into :v_179_003_l, :v_179_007_r, :v_179_013_r, :v_179_014_r, :v_179_015_r, :v_179_016_r ;
			End SQL
			
		End if 
		Case of 
			: ($Choise_L=1)
				C_TEXT:C284($ErrMsg_txt)
				$ErrMsg_txt:=""
				If (v_179_007_r>[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21)
					$ErrMsg_txt:=$ErrMsg_txt+"ERROR : Sum of Total Quantities of Defect(s) = "+String:C10(v_179_007_r)+"  EXCEEDS Total Quantity of Element = "+String:C10([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21)+Char:C90(13)
				End if 
				//$ErrMsg_txt:=$ErrMsg_txt+PON_CompareState (1;v_179_013_r;[NTI_ELEM_TIN_INSP]ELEM_QTYSTATE1)  ` cannot compare state 1
				$ErrMsg_txt:=$ErrMsg_txt+PON_CompareState(2; v_179_014_r; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18)
				$ErrMsg_txt:=$ErrMsg_txt+PON_CompareState(3; v_179_015_r; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19)
				$ErrMsg_txt:=$ErrMsg_txt+PON_CompareState(4; v_179_016_r; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20)
				
				If ($ErrMsg_txt#"")
					ut_BigAlert($ErrMsg_txt)
				Else 
					ALERT:C41("All Quantities are OK")
				End if 
				
			: ($Choise_L=2)
				//verify still~~
				//all we need to check is the sum of total defect q <= current quantity
				If (v_179_003_l>0)
					If (v_179_007_r<=[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21)
						[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20:=v_179_016_r
						[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19:=v_179_015_r
						[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18:=v_179_014_r
						[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17:=[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21-[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18-[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19-[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20
						[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13:=Round:C94(100*[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18/[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundP_L)
						[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14:=Round:C94(100*[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19/[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundP_L)
						[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15:=Round:C94(100*[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20/[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundP_L)
						[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE1:12:=100-[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13-[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14-[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15
						[NTI_ELEM_TIN_INSP:185]ELEM_RATING:24:=NTI_CalculateRating([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20)
					Else 
						ALERT:C41("Sum of Defect Quantities ("+String:C10(v_179_007_r)+") is greater than Element Total Quantity ("+String:C10([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21)+"). Roll up of defect State Quantities not done!")
					End if 
				Else 
					ALERT:C41("There are no Defects Assigned to this Element!")
				End if 
				//need to update percentages
				
		End case 
		
End case 

//End NTI_ELEMINPTOOL_OM