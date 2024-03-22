//%attributes = {"invisible":true,"publishedWeb":true}
//Method: NTI_LoadExportArrays
//Description
// load NTE export arrays for FHWA export for the current TIN record
// available trhough 4DACTION 4DMETHOD 4DSCRIPT
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/23/17, 17:39:41
	// ----------------------------------------------------
	//Created : 
	Mods_2017_03
	// Modified by: Costas Manousakis-(Designer)-(3/29/17 16:47:38)
	Mods_2017_03
	//  `check if required to use approved or complete or any inspection
	// Modified by: Costas Manousakis-(Designer)-(4/20/17 15:56:09)
	Mods_2017_04
	//  `added declaration of $0;$1 - needed for compiled execution
	// Modified by: Costas Manousakis-(Designer)-(7/2/18 17:49:55)
	Mods_2018_07
	//  `Make sure that parent of element is also reportable
	// Modified by: Costas Manousakis-(Designer)-(2/8/19 12:17:23)
	Mods_2019_02_bug
	//  `modified to use method NTI_CombineRecent; also adjusted logic in determining element key and parent key; 
	
	C_TEXT:C284(NTI_LoadExportArrays; $0; $1)
	
End if 
//
C_TEXT:C284($0; $1)  //required when called in process 4DTags
//
C_TEXT:C284(NTI_FHWAExportOpt_txt)
ARRAY LONGINT:C221(PON_SUMEn_AL; 0)
ARRAY LONGINT:C221(PON_SUMEPN_AL; 0)
ARRAY TEXT:C222($NTI_SUMParentAndKEY_atxt; 0)
ARRAY REAL:C219(PON_SUMTotQ_Ar; 0)
ARRAY REAL:C219(PON_SUMCS1_Ar; 0)
ARRAY REAL:C219(PON_SUMCS2_Ar; 0)
ARRAY REAL:C219(PON_SUMCS3_Ar; 0)
ARRAY REAL:C219(PON_SUMCS4_Ar; 0)
C_BOOLEAN:C305($completed_b; $Dbieapproved_b)

QUERY:C277([TIN_Inspections:184]; [TIN_Inspections:184]NTI_i1_S:1=[NTI_TunnelInfo:181]NTI_i1_s:6)

Case of 
	: (NTI_FHWAExportOpt_txt="APPROVED")
		QUERY SELECTION:C341([TIN_Inspections:184]; [TIN_Inspections:184]InspReview:5=BMS Approved)
		$Dbieapproved_b:=True:C214
		$completed_b:=True:C214
	: (NTI_FHWAExportOpt_txt="COMPLETE")
		QUERY SELECTION:C341([TIN_Inspections:184]; [TIN_Inspections:184]Complete:4=True:C214)
		$completed_b:=True:C214
		
End case 
QUERY SELECTION:C341([TIN_Inspections:184]; [NTI_ELEM_TIN_INSP:185]InspectionID:1>0)
ORDER BY:C49([TIN_Inspections:184]; [TIN_Inspections:184]InspDate:3; <)
SELECTION TO ARRAY:C260([TIN_Inspections:184]InspectionID:2; $InspIDs_aL)
If (Size of array:C274($InspIDs_aL)>0)
	
	ARRAY LONGINT:C221($En_AL; 0)
	ARRAY LONGINT:C221($EPN_AL; 0)
	ARRAY REAL:C219($TotQ_Ar; 0)
	ARRAY REAL:C219($CS1_Ar; 0)
	ARRAY REAL:C219($CS2_Ar; 0)
	ARRAY REAL:C219($CS3_Ar; 0)
	ARRAY REAL:C219($CS4_Ar; 0)
	
	C_OBJECT:C1216($NTEObject_o)
	$NTEObject_o:=NTI_CombineRecent($completed_b; $Dbieapproved_b)
	
	//unpack the arrays we need
	OB GET ARRAY:C1229($NTEObject_o; "keys"; $En_AL)
	OB GET ARRAY:C1229($NTEObject_o; "parent"; $EPN_AL)
	OB GET ARRAY:C1229($NTEObject_o; "totq"; $TotQ_Ar)
	OB GET ARRAY:C1229($NTEObject_o; "q1"; $CS1_Ar)
	OB GET ARRAY:C1229($NTEObject_o; "q2"; $CS2_Ar)
	OB GET ARRAY:C1229($NTEObject_o; "q3"; $CS3_Ar)
	OB GET ARRAY:C1229($NTEObject_o; "q4"; $CS4_Ar)
	
	//NTI_FHWAExportOpt_txt:=[TIN_Inspections]NTI_i1_S
	
	If (False:C215)
		//get the latest inspection - should be the latest approved inspection in the final code
		QUERY:C277([NTI_ELEM_TIN_INSP:185]; [NTI_ELEM_TIN_INSP:185]InspectionID:1=$InspIDs_aL{1})
		//sort them in right order
		ORDER BY FORMULA:C300([NTI_ELEM_TIN_INSP:185]; NTI_ElemSort_TIN)
		
		SELECTION TO ARRAY:C260([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3; $En_AL; [NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7; $EPN_AL; [NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; $TotQ_Ar; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; $CS1_Ar)
		SELECTION TO ARRAY:C260([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18; $CS2_Ar; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19; $CS3_Ar; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20; $CS4_Ar)
		
	End if 
	
	ARRAY LONGINT:C221(PON_SUMEn_AL; Size of array:C274($En_AL))
	ARRAY LONGINT:C221(PON_SUMEPN_AL; Size of array:C274($En_AL))
	ARRAY TEXT:C222($NTI_SUMParentAndKEY_atxt; Size of array:C274($En_AL))
	ARRAY REAL:C219(PON_SUMTotQ_Ar; Size of array:C274($En_AL))
	ARRAY REAL:C219(PON_SUMCS1_Ar; Size of array:C274($En_AL))
	ARRAY REAL:C219(PON_SUMCS2_Ar; Size of array:C274($En_AL))
	ARRAY REAL:C219(PON_SUMCS3_Ar; Size of array:C274($En_AL))
	ARRAY REAL:C219(PON_SUMCS4_Ar; Size of array:C274($En_AL))
	
	//loop to sum the quantities
	C_LONGINT:C283($Elemindx_L; $pondefIndx_L; $CurrElemKey_L; $CurrParKey_L; $pondefParIndx_L; $ElemLoop_L)
	C_TEXT:C284($myParAndKey_txt)
	C_BOOLEAN:C305($report_b)
	
	For ($ElemLoop_L; 1; Size of array:C274($En_AL))
		$report_b:=False:C215  //assume not reportable
		$CurrElemKey_L:=$EN_AL{$ElemLoop_L}
		$CurrParKey_L:=$EPN_AL{$ElemLoop_L}
		
		$pondefIndx_L:=Find in array:C230(v_182_004_aL; $En_AL{$ElemLoop_L})
		
		If ($pondefIndx_L>0)
			If (v_182_013_aL{$pondefIndx_L}>0)  // check if element is a Subset of another element.
				$CurrElemKey_L:=v_182_013_aL{$pondefIndx_L}  // use the subsetkey
			End if 
			//now check if the active element key is reportable
			$pondefIndx_L:=Find in array:C230(v_182_004_aL; $CurrElemKey_L)
			If ($pondefIndx_L>0)
				$report_b:=(v_182_016_atxt{$pondefIndx_L}="Y")
			End if 
		End if 
		
		If ($report_b)
			//check if the parent element EPN is a reportable element.
			If ($CurrParKey_L>0)
				$pondefParIndx_L:=Find in array:C230(v_182_004_aL; $CurrParKey_L)
				If ($pondefParIndx_L>0)
					//check if the parent is a subset of another element
					If (v_182_013_aL{$pondefParIndx_L}>0)
						$CurrParKey_L:=v_182_013_aL{$pondefParIndx_L}  // use the subsetkey
					End if 
				End if 
				//now check if the active parent key is reportable
				$pondefParIndx_L:=Find in array:C230(v_182_004_aL; $CurrParKey_L)
				
				If ($pondefParIndx_L>0)
					$report_b:=$report_b & (v_182_016_atxt{$pondefParIndx_L}="Y")  //parent must also be reportable
				Else 
					$report_b:=False:C215
				End if 
				
			End if 
			
		End if 
		
		If ($report_b)
			$myParAndKey_txt:=""
			
			$myParAndKey_txt:=String:C10($CurrParKey_L; "00000000")+String:C10($CurrElemKey_L; "00000000")
			
			$Elemindx_L:=Find in array:C230($NTI_SUMParentAndKEY_atxt; $myParAndKey_txt)
			If ($Elemindx_L<=0)
				$Elemindx_L:=Find in array:C230($NTI_SUMParentAndKEY_atxt; "")  // get the first blank 
				$NTI_SUMParentAndKEY_atxt{$Elemindx_L}:=$myParAndKey_txt
				PON_SUMEn_AL{$Elemindx_L}:=$CurrElemKey_L
				PON_SUMEPN_AL{$Elemindx_L}:=$CurrParKey_L
			End if 
			//now sum quantities
			PON_SUMTotQ_Ar{$Elemindx_L}:=PON_SUMTotQ_Ar{$Elemindx_L}+$TotQ_Ar{$ElemLoop_L}
			PON_SUMCS1_Ar{$Elemindx_L}:=PON_SUMCS1_Ar{$Elemindx_L}+$CS1_Ar{$ElemLoop_L}
			PON_SUMCS2_Ar{$Elemindx_L}:=PON_SUMCS2_Ar{$Elemindx_L}+$CS2_Ar{$ElemLoop_L}
			PON_SUMCS3_Ar{$Elemindx_L}:=PON_SUMCS3_Ar{$Elemindx_L}+$CS3_Ar{$ElemLoop_L}
			PON_SUMCS4_Ar{$Elemindx_L}:=PON_SUMCS4_Ar{$Elemindx_L}+$CS4_Ar{$ElemLoop_L}
			
		End if 
		
	End for 
	
	//Find last blank in summ array 
	C_LONGINT:C283($TrimTo_L)
	$TrimTo_L:=Find in array:C230($NTI_SUMParentAndKEY_atxt; "")
	If ($TrimTo_L>0)
		ARRAY TEXT:C222($NTI_SUMParentAndKEY_atxt; ($TrimTo_L-1))  // resize the array 
		ARRAY LONGINT:C221(PON_SUMEn_AL; Size of array:C274($NTI_SUMParentAndKEY_atxt))
	End if 
	//now loop and fix quantities to round to zero 
	For ($Elemindx_L; 1; Size of array:C274($NTI_SUMParentAndKEY_atxt))
		PON_SUMTotQ_Ar{$Elemindx_L}:=Round:C94(PON_SUMTotQ_Ar{$Elemindx_L}; 0)
		PON_SUMCS4_Ar{$Elemindx_L}:=Round:C94(PON_SUMCS4_Ar{$Elemindx_L}; 0)
		PON_SUMCS3_Ar{$Elemindx_L}:=Round:C94(PON_SUMCS3_Ar{$Elemindx_L}; 0)
		PON_SUMCS2_Ar{$Elemindx_L}:=Round:C94(PON_SUMCS2_Ar{$Elemindx_L}; 0)
		
		If ((PON_SUMTotQ_Ar{$Elemindx_L}-(PON_SUMCS4_Ar{$Elemindx_L}+PON_SUMCS3_Ar{$Elemindx_L}+PON_SUMCS2_Ar{$Elemindx_L}))>=0)
			PON_SUMCS1_Ar{$Elemindx_L}:=PON_SUMTotQ_Ar{$Elemindx_L}-(PON_SUMCS4_Ar{$Elemindx_L}+PON_SUMCS3_Ar{$Elemindx_L}+PON_SUMCS2_Ar{$Elemindx_L})
		Else 
			PON_SUMCS1_Ar{$Elemindx_L}:=0
			If ((PON_SUMTotQ_Ar{$Elemindx_L}-(PON_SUMCS4_Ar{$Elemindx_L}+PON_SUMCS3_Ar{$Elemindx_L}))>=0)
				PON_SUMCS2_Ar{$Elemindx_L}:=PON_SUMTotQ_Ar{$Elemindx_L}-(PON_SUMCS4_Ar{$Elemindx_L}+PON_SUMCS3_Ar{$Elemindx_L})
			Else 
				PON_SUMCS2_Ar{$Elemindx_L}:=0
				If ((PON_SUMTotQ_Ar{$Elemindx_L}-PON_SUMCS4_Ar{$Elemindx_L})>=0)
					PON_SUMCS3_Ar{$Elemindx_L}:=PON_SUMTotQ_Ar{$Elemindx_L}-PON_SUMCS4_Ar{$Elemindx_L}
				Else 
					PON_SUMCS3_Ar{$Elemindx_L}:=0
					PON_SUMCS4_Ar{$Elemindx_L}:=PON_SUMTotQ_Ar{$Elemindx_L}
				End if 
			End if 
			
		End if 
	End for 
	
End if 

//End NTI_LoadExportArrays