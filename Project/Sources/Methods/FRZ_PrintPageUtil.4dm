//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/20/09, 16:23:41
	// ----------------------------------------------------
	// Method: Method: FRZ_PrintPageUtil
	// Description
	// Fill the print variables for page 1 of the Freeze thaw inspection
	// 
	// Parameters
	// $1: $RecNum_L record number in the elements safety selection
	
	// ----------------------------------------------------
	
	Mods_2009_CM_5404  // --- "FREEZETHAW"
End if 
C_LONGINT:C283($1)
C_LONGINT:C283($RecNum_L; $Arraindx_L)
C_POINTER:C301($FRZProb_ptr; $FRZProb_L_ptr; $FRZAction_ptr; $FRZActionL_ptr; $FRZNA_L_ptr)
C_POINTER:C301($FRZNoProb_L_ptr; $FRZNoAction_L_ptr; $FRZDesc_ptr)

$RecNum_L:=$1
$Arraindx_L:=($RecNum_L*2)-1
If (($RecNum_L>0) & ($RecNum_L<=Records in selection:C76([ElementsSafety:29])))
	
	GOTO SELECTED RECORD:C245([ElementsSafety:29]; $RecNum_L)
	LOAD RECORD:C52([ElementsSafety:29])
	
	$FRZProb_ptr:=Get pointer:C304("FRZProb_"+String:C10($RecNum_L)+"_txt")
	$FRZAction_ptr:=Get pointer:C304("FRZAction_"+String:C10($RecNum_L)+"_txt")
	$FRZProb_L_ptr:=Get pointer:C304("FRZProb_"+String:C10($RecNum_L)+"_L")
	$FRZActionL_ptr:=Get pointer:C304("FRZAction_"+String:C10($RecNum_L)+"_L")
	$FRZNA_L_ptr:=Get pointer:C304("FRZNA_"+String:C10($RecNum_L)+"_L")
	$FRZNoProb_L_ptr:=Get pointer:C304("FRZNoProb_"+String:C10($RecNum_L)+"_L")
	$FRZNoAction_L_ptr:=Get pointer:C304("FRZNoAction_"+String:C10($RecNum_L)+"_L")
	$FRZDesc_ptr:=Get pointer:C304("FRZDesc_"+String:C10($RecNum_L)+"_txt")
	
	If (BLOB size:C605([ElementsSafety:29]ElmComments:23)>0)
		BLOB TO VARIABLE:C533([ElementsSafety:29]ElmComments:23; $FRZProb_ptr->)
		FRZ_CommentsFit_b{$Arraindx_L}:=ut_FitPrintFormObject($FRZProb_ptr; 10; 9)
		If ((FRZ_CommentsFit_b{$Arraindx_L}))
			$FRZProb_ptr->:="See Description in Remarks Section."
			OBJECT SET FONT SIZE:C165($FRZProb_ptr->; 10)
		End if 
	Else 
		$FRZProb_ptr->:=""
	End if 
	If ([ElementsSafety:29]Comments:5="")
		$FRZAction_ptr->:=""
		$FRZActionL_ptr->:=0
	Else 
		$FRZAction_ptr->:=[ElementsSafety:29]Comments:5
		FRZ_CommentsFit_b{($Arraindx_L+1)}:=ut_FitPrintFormObject($FRZAction_ptr; 10; 9)
		If ((FRZ_CommentsFit_b{$Arraindx_L+1}))
			$FRZAction_ptr->:="See Description in Remarks Section."
			OBJECT SET FONT SIZE:C165($FRZAction_ptr->; 10)
		End if 
		$FRZActionL_ptr->:=1
	End if 
	$FRZDesc_ptr->:=[ElementsSafety:29]Description:22
	C_BOOLEAN:C305($Fit_b)
	$Fit_b:=ut_FitPrintFormObject($FRZDesc_ptr; 10; 8)
	$FRZNA_L_ptr->:=Num:C11(f_Boolean2String([ElementsSafety:29]Crack:9; "10"))
	$FRZProb_L_ptr->:=0
	$FRZNoProb_L_ptr->:=0
	
	Case of 
		: ([ElementsSafety:29]Rating:2="1")
			$FRZNoProb_L_ptr->:=1
		: ([ElementsSafety:29]Rating:2="2")
			$FRZProb_L_ptr->:=1
	End case 
	
	$FRZNoAction_L_ptr->:=Num:C11([ElementsSafety:29]Deficiency:3)
End if 