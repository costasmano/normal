//%attributes = {"invisible":true}
//Method: PRV_InvoicesLB_OM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/13/12, 16:21:25
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/17/17 13:40:53)
End if 
//
C_LONGINT:C283($FormEvent_L)
C_TEXT:C284($LBName_txt)
C_LONGINT:C283($1)
$FormEvent_L:=$1
C_TEXT:C284($2)
$LBName_txt:=$2

Case of 
	: ($FormEvent_L=On Load:K2:1)
	: ($FormEvent_L=On Display Detail:K2:22)
		
		Case of 
			: ($LBName_txt="INVOICES")
				//Variable LB_Detail5_r total TLF
				LB_Detail5_r:=[Invoice_Maintenance:95]TotalLimFeeConstr:14+[Invoice_Maintenance:95]TotalLimFeeDes:8
				LB_Detail7_r:=[Invoice_Maintenance:95]TotalLimFeeConstr:14+[Invoice_Maintenance:95]TotalLimFeeDes:8+[Invoice_Maintenance:95]DirectExpenses:15
				
		End case 
		
	: ($FormEvent_L=On Data Change:K2:15)
		
	: ($FormEvent_L=On Clicked:K2:4)
		
	: ($FormEvent_L=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			C_TEXT:C284($LBName_txt; $SetName_txt; PRV_NEWREVIEWTYPE_s; $LBSelection_txt)
			C_LONGINT:C283($Dumm_L; $LBCol_L; $LBRow_L; $LbTableNum_L)
			//ALERT("doubleClicked on "+$LBName_txt)
			PRV_NEWREVIEWTYPE_s:=$LBName_txt
			$SetName_txt:="PRV_"+$LBName_txt+"_HS"
			$LBName_txt:="PRV_"+$LBName_txt+"_LB"
			If (Records in set:C195($SetName_txt)>0)
				LISTBOX GET TABLE SOURCE:C1014(*; $LBName_txt; $LbTableNum_L; $LBSelection_txt)
				If ($LBSelection_txt#"")
					USE NAMED SELECTION:C332($LBSelection_txt)
				End if 
				LISTBOX GET CELL POSITION:C971(*; $LBName_txt; $LBCol_L; $LBRow_L)
				If ($LBRow_L>0)
					FORM SET INPUT:C55([Invoice_Maintenance:95]; "PreservationInput")
					If (ut_LoadRecordInteractiveV2(->[Invoice_Maintenance:95])=1)
						MODIFY RECORD:C57([Invoice_Maintenance:95])
					End if 
					PRV_Variables("TOTALHRS")
					PRV_Variables("TOTALCOSTS")
					PRV_CTRLSelections(PRV_NEWREVIEWTYPE_s)
					
				End if 
			Else 
				ALERT:C41("Nothing")
			End if 
			InDoubleClick_B:=False:C215
		End if 
		
		
End case 

//End PRV_InvoicesLB_OM