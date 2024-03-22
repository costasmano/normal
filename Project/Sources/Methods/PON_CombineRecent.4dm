//%attributes = {"invisible":true}
//Method: PON_CombineRecent
//Description
// Combine NBE elements from the previous inspections starting from the last routine inspection
// return an object containing the element tree.
// object can be used to create a new set of elements for a new inspection, or
// to export for FHWA submittal
// Parameters
// $0 : $NBEElements_o
// $1 : $completed_b
// $2 : $Dbieapproved_b
// $3 : $startdate_d
// $4 : $showProgress_b (optional)

// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/02/19, 15:02:14
	// ----------------------------------------------------
	//Created : 
	Mods_2019_01
	
	C_OBJECT:C1216(PON_CombineRecent; $0)
	C_BOOLEAN:C305(PON_CombineRecent; $1)
	C_BOOLEAN:C305(PON_CombineRecent; $2)
	C_DATE:C307(PON_CombineRecent; $3)
	C_BOOLEAN:C305(PON_CombineRecent; $4)
	
	// Modified by: Costas Manousakis-(Designer)-(2/6/19 12:56:28)
	Mods_2019_02_bug
	//  `changed arrays used in SQL exec immediate to interprocess vars CallReference #608
	// Modified by: Costas Manousakis-(Designer)-(6/12/19 14:05:53)
	Mods_2019_06
	//  `added info on inspections used
	// Modified by: Costas Manousakis-(Designer)-(11/19/19 13:43:15)
	Mods_2019_11
	//  `4th optional parameter to show progress or not - default = true
End if 
//

C_OBJECT:C1216($0; $NBEElements_o)

C_BLOB:C604($SaveROState_x)
$SaveROState_x:=ut_db_SaveROState
READ ONLY:C145(*)

//which BIN
C_TEXT:C284($BIN_)
$BIN_:=[Bridge MHD NBIS:1]BIN:3
//starting date
C_DATE:C307($StartDate_d)
$StartDate_d:=Current date:C33(*)  //will search for inspections before this date
C_BOOLEAN:C305($Completed_b)
$Completed_b:=True:C214  //use only completed inspections - or at least completed once
C_BOOLEAN:C305($DBIEApproved_b)
$DBIEApproved_b:=False:C215  //use only DBIE Approved inspections - or at least approved once
If (Count parameters:C259>0)
	C_BOOLEAN:C305($1)
	$Completed_b:=$1
End if 
If (Count parameters:C259>1)
	C_BOOLEAN:C305($2)
	$DBIEApproved_b:=$2
End if 

If (Count parameters:C259>2)
	C_DATE:C307($3)
	If ($3#!00-00-00!)
		$StartDate_d:=$3
	End if 
	
End if 
C_BOOLEAN:C305($showProgress_b)
$showProgress_b:=True:C214
If (Count parameters:C259>3)
	C_BOOLEAN:C305($4)
	$showProgress_b:=$4
End if 

If ($showProgress_b)
	//start the bar
	C_OBJECT:C1216($progress_o)
	$progress_o:=ProgressNew("Combining NBEs from previous inspections for BIN "+$BIN_; 4; False:C215; ""; 0)  // 4 steps
	C_LONGINT:C283($progressID_L)
	$progressID_L:=OB Get:C1224($progress_o; "progress"; Is longint:K8:6)
	
End if 

ARRAY LONGINT:C221(InspIDS_aL; 0)
ARRAY DATE:C224(InspDates_ad; 0)
ARRAY TEXT:C222(InspTypes_atxt; 0)

If (False:C215)
Else 
	
	C_TEXT:C284($sqlSelect_txt)
	
	$sqlSelect_txt:="Select [Inspections].[InspID], [Inspections].[Insp Date], [Inspections].[Insp Type] "+\
		"from [Inspections] "+\
		"Where [Inspections].[BIN] = '"+$BIN_+"' and "+\
		"[Inspections].[Insp Date] < '"+String:C10($StartDate_d)+"'  "
	
	If ($Completed_b)
		$sqlSelect_txt:=$sqlSelect_txt+" and ( "+\
			"cast([Inspections].[InspComplete] as INT) = 1 OR "+\
			"[Inspections].[InspCompleteDate] > '01/01/1900' ) "
	End if 
	
	If ($DBIEApproved_b)
		$sqlSelect_txt:=$sqlSelect_txt+" and ( "+\
			" [Inspections].[InspReviewed] = 2 OR "+\
			" [Inspections].[InspDBIE1stApprDate] > '01/01/1900' ) "
	End if 
	
	$sqlSelect_txt:=$sqlSelect_txt+" order by [Inspections].[Insp Date] DESC into :InspIDS_aL, :InspDates_ad, :InspTypes_atxt ;"
	Begin SQL
		
		execute IMMEDIATE :$sqlSelect_txt
		
	End SQL
	
End if 

If (Size of array:C274(InspIDS_aL)=0)
	OB SET:C1220($NBEElements_o; "error"; "No inspections with NBES for BIN "+$BIN_+\
		" starting from date "+String:C10($StartDate_d)+\
		" Inspection completed = "+Choose:C955($Completed_b; "Required"; "Not Required")+\
		" DBIE Approved  "+Choose:C955($DBIEApproved_b; "Required"; "Not Required")\
		)
	
Else 
	//find last routine inspection
	C_LONGINT:C283($loop_L; $LastRoutineID_)
	$LastRoutineID_:=0
	For ($loop_L; 1; Size of array:C274(InspTypes_atxt))
		If ((InspTypes_atxt{$loop_L}="RT@") | (InspTypes_atxt{$loop_L}="CUL"))
			//Routine
			//check if it has any NBEs
			C_LONGINT:C283($NBECount_L; $InspID_L)
			$InspID_L:=InspIDS_aL{$loop_L}
			Begin SQL
				select count(*) from [pon_elem_insp]
				where [pon_elem_insp].[inspid] = :$InspID_L
				into :$NBECount_L
			End SQL
			If ($NBECount_L>0)
				$LastRoutineID_:=$loop_L
				$loop_L:=Size of array:C274(InspTypes_atxt)+1
				
			End if 
		End if 
		
	End for 
	
	If ($LastRoutineID_=0)
		//there was no previous routine found - use the oldest valid NBE inpsection
		$LastRoutineID_:=Size of array:C274(InspTypes_atxt)
	Else 
		
	End if 
	
	ARRAY LONGINT:C221($elemDefKey_aL; 0)
	ARRAY TEXT:C222($elemDef_Prot_atxt; 0)
	ARRAY TEXT:C222($elemDef_defect_atxt; 0)
	
	If (False:C215)
		
		ALL RECORDS:C47([PON_ELEM_DEFS:178])
		SELECTION TO ARRAY:C260([PON_ELEM_DEFS:178]ELEM_KEY:1; $elemDefKey_aL; \
			[PON_ELEM_DEFS:178]ELEM_PROTECT_SYS:3; $elemDef_Prot_atxt; \
			[PON_ELEM_DEFS:178]ELEM_SMART_FLAG:4; $elemDef_defect_atxt)
	Else 
		
		Begin SQL
			select 
			[PON_ELEM_DEFS].[ELEM_KEY] ,
			[PON_ELEM_DEFS].[ELEM_PROTECT_SYS] ,
			[PON_ELEM_DEFS].[ELEM_SMART_FLAG]
			from
			[PON_ELEM_DEFS]
			into
			:$elemDefKey_aL ,
			:$elemDef_Prot_atxt ,
			:$elemDef_defect_atxt ;
		End SQL
	End if 
	
	C_LONGINT:C283($inspLoop_L; $InspNBE_L; $elemIndx_L; $elemIndxInSum_L)
	
	C_TEXT:C284($strUFmt_txt; $keyFmt_txt; $envfmt_txt)
	$strUFmt_txt:="000"
	$keyFmt_txt:="000000"
	$envfmt_txt:="000"
	
	ARRAY LONGINT:C221($NBEID_aL; 0)
	ARRAY TEXT:C222($NBECombineIndex_atxt; 0)  // combination SSSKKKKKKEEE (Struct unit, Key, Env)
	C_TEXT:C284($NBECombineIndex_txt)  // combination SSSKKKKKKEEE (Struct unit, Key, Env)
	ARRAY LONGINT:C221($InspNBEID_aL; 0)
	ARRAY LONGINT:C221($InspNBEStrUnit_aL; 0)
	ARRAY LONGINT:C221($InspNBEKey_aL; 0)
	ARRAY LONGINT:C221($InspNBEEnv_aL; 0)
	
	
	//start from the oldest insp - and start collecting major elements by str unit, key, env
	C_TEXT:C284($inspVerification_txt; $verificationErrors_txt)
	$inspVerification_txt:=""
	$verificationErrors_txt:=""
	C_BOOLEAN:C305($one_b; $many_b)
	GET AUTOMATIC RELATIONS:C899($one_b; $many_b)
	SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	ARRAY TEXT:C222($UsedInspType_atxt; 0)
	ARRAY DATE:C224($UsedInspDate_ad; 0)
	
	For ($inspLoop_L; $LastRoutineID_; 1; -1)
		//first verify inspection
		If ($showProgress_b)
			Progress SET MESSAGE($progressID_L; "Inspection type "+InspTypes_atxt{$inspLoop_L}+" "+String:C10(InspDates_ad{$inspLoop_L})+" .. Verification step.")
			
		End if 
		$inspVerification_txt:=PON_VerifyNBELinks(InspIDS_aL{$inspLoop_L})
		
		If ($inspVerification_txt="")
			//no errors
			C_LONGINT:C283($CurrInspID_L)
			$CurrInspID_L:=InspIDS_aL{$inspLoop_L}
			
			Begin SQL
				select [PON_ELEM_INSP].[ELEMID]
				, [PON_ELEM_INSP].[STRUNITKEY]
				, [PON_ELEM_INSP].[ENVKEY]
				, [PON_ELEM_INSP].[ELEM_KEY]
				from [PON_ELEM_INSP]
				where
				[PON_ELEM_INSP].[INSPID] = :$CurrInspID_L
				into 
				:$InspNBEID_aL ,
				:$InspNBEStrUnit_aL ,
				:$InspNBEEnv_aL ,
				:$InspNBEKey_aL ;
				
			End SQL
			If ($showProgress_b)
				Progress SET MESSAGE($progressID_L; "Inspection type "+InspTypes_atxt{$inspLoop_L}+" "+String:C10(InspDates_ad{$inspLoop_L})+" .. Scanning "+String:C10(Size of array:C274($InspNBEKey_aL))+" NBEs")
				
			End if 
			
			If (Size of array:C274($InspNBEID_aL)>0)
				APPEND TO ARRAY:C911($UsedInspType_atxt; InspTypes_atxt{$inspLoop_L})
				APPEND TO ARRAY:C911($UsedInspDate_ad; InspDates_ad{$inspLoop_L})
			End if 
			
			For ($InspNBE_L; 1; Size of array:C274($InspNBEKey_aL))
				$elemIndx_L:=Find in array:C230($elemDefKey_aL; $InspNBEKey_aL{$InspNBE_L})
				
				If ($elemIndx_L>0)
					If ($elemDef_Prot_atxt{$elemIndx_L}#"Y") & ($elemDef_defect_atxt{$elemIndx_L}#"Y")
						//not defect or prot sys
						$NBECombineIndex_txt:=String:C10($InspNBEStrUnit_aL{$InspNBE_L}; $strUFmt_txt)+\
							String:C10($InspNBEKey_aL{$InspNBE_L}; $keyFmt_txt)+\
							String:C10($InspNBEEnv_aL{$InspNBE_L}; $envfmt_txt)
						
						$elemIndxInSum_L:=Find in array:C230($NBECombineIndex_atxt; $NBECombineIndex_txt)
						If ($elemIndxInSum_L>0)
							//already have this one - replace the id with the current
							$NBEID_aL{$elemIndxInSum_L}:=$InspNBEID_aL{$InspNBE_L}
						Else 
							//new one - add to the arrays
							APPEND TO ARRAY:C911($NBEID_aL; $InspNBEID_aL{$InspNBE_L})
							APPEND TO ARRAY:C911($NBECombineIndex_atxt; $NBECombineIndex_txt)
						End if 
						
					End if 
					
				Else 
					//if key not in elem Defs - ingnore it???
					//whatdowedohere:=False
				End if 
				
			End for 
			
		Else 
			//inspection has element link errors - skip it?
			$verificationErrors_txt:=$verificationErrors_txt+\
				"Insp type "+InspTypes_atxt{$inspLoop_L}+\
				" Date "+String:C10(InspDates_ad{$inspLoop_L})+\
				" has NBE Element link errors : "+$inspVerification_txt+"\r"
		End if 
		
	End for 
	
	//now we should have a list of primary NBEs
	
	If (Size of array:C274($NBEID_aL)=0)
		//did not find any primary NBES - error
		C_TEXT:C284($errMsg_txt)
		$errMsg_txt:="No primary NBES found for BIN "+$BIN_+\
			" starting from date "+String:C10($StartDate_d)+\
			" Inspection completed = "+Choose:C955($Completed_b; "Required"; "Not Required")+\
			" DBIE Approved  "+Choose:C955($DBIEApproved_b; "Required"; "Not Required")+\
			" Search was starting from inspection  "+InspTypes_atxt{$LastRoutineID_}+\
			" date "+String:C10(InspDates_ad{$LastRoutineID_})
		If ($verificationErrors_txt#"")
			$errMsg_txt:=$errMsg_txt+"\r"+$verificationErrors_txt
		End if 
		OB SET:C1220($NBEElements_o; "error"; $errMsg_txt)
		
	Else 
		
		//build the arrays of the NBE element data
		ARRAY LONGINT:C221($NBEKey_aL; 0)
		ARRAY LONGINT:C221($NBEEnv_al; 0)
		ARRAY LONGINT:C221($NBStrUnit_aL; 0)
		ARRAY LONGINT:C221($NBEParentKey_aL; 0)
		ARRAY LONGINT:C221($NBEGrandParentKey_aL; 0)
		ARRAY TEXT:C222($NBENotes_atxt; 0)
		ARRAY BOOLEAN:C223($NBEQorP; 0)
		ARRAY REAL:C219($NBEScaleF_ar; 0)
		ARRAY REAL:C219($NBEQ_ar; 0)
		ARRAY REAL:C219($NBEQ1_ar; 0)
		ARRAY REAL:C219($NBEQ2_ar; 0)
		ARRAY REAL:C219($NBEQ3_ar; 0)
		ARRAY REAL:C219($NBEQ4_ar; 0)
		ARRAY LONGINT:C221($NBEElmID_aL; 0)
		ARRAY LONGINT:C221($NBEParID_aL; 0)
		ARRAY LONGINT:C221($NBEGParID_aL; 0)
		
		If ($showProgress_b)
			Progress SET MESSAGE($progressID_L; "Compiling "+String:C10(Size of array:C274($NBEID_aL))+" primary NBEs")
			
		End if 
		//first do the primary elements
		QUERY WITH ARRAY:C644([PON_ELEM_INSP:179]ELEMID:22; $NBEID_aL)
		SELECTION TO ARRAY:C260([PON_ELEM_INSP:179]ELEM_KEY:3; $NBEKey_aL; \
			[PON_ELEM_INSP:179]ENVKEY:5; $NBEEnv_al; \
			[PON_ELEM_INSP:179]STRUNITKEY:6; $NBStrUnit_aL; \
			[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4; $NBEParentKey_aL; \
			[PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19; $NBEGrandParentKey_aL; \
			[PON_ELEM_INSP:179]ELEM_NOTES:20; $NBENotes_atxt; \
			[PON_ELEM_INSP:179]ELEM_QorP:29; $NBEQorP; \
			[PON_ELEM_INSP:179]ELEM_SCALE_FACTOR:8; $NBEScaleF_ar; \
			[PON_ELEM_INSP:179]ELEM_QUANTITY:7; $NBEQ_ar; \
			[PON_ELEM_INSP:179]ELEM_QTYSTATE1:13; $NBEQ1_ar; \
			[PON_ELEM_INSP:179]ELEM_QTYSTATE2:14; $NBEQ2_ar; \
			[PON_ELEM_INSP:179]ELEM_QTYSTATE3:15; $NBEQ3_ar; \
			[PON_ELEM_INSP:179]ELEM_QTYSTATE4:16; $NBEQ4_ar; \
			[PON_ELEM_INSP:179]ELEM_PARENTID:27; $NBEParID_aL; \
			[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; $NBEGParID_aL; \
			[PON_ELEM_INSP:179]ELEMID:22; $NBEElmID_aL\
			)
		
		C_LONGINT:C283($PrimaryNBE_L)
		//loop through primary NBEs and get children and grand children
		If ($showProgress_b)
			Progress SET MESSAGE($progressID_L; "Getting related elements for "+String:C10(Size of array:C274($NBEID_aL))+" primary NBEs")
			
		End if 
		
		For ($PrimaryNBE_L; 1; Size of array:C274($NBEElmID_aL))
			If ($showProgress_b)
				Progress SET MESSAGE($progressID_L; "Getting related elements for "+String:C10($PrimaryNBE_L)+" of "+String:C10(Size of array:C274($NBEID_aL))+" primary NBEs")
				
			End if 
			
			C_LONGINT:C283($childLoop_L)
			
			//find children
			QUERY:C277([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_PARENTID:27=$NBEElmID_aL{$PrimaryNBE_L})
			
			If (Records in selection:C76([PON_ELEM_INSP:179])>0)
				//build the arrays of the NBE element data
				ARRAY LONGINT:C221($ChildNBEKey_aL; 0)
				ARRAY LONGINT:C221($ChildNBEEnv_al; 0)
				ARRAY LONGINT:C221($ChildNBStrUnit_aL; 0)
				ARRAY LONGINT:C221($ChildNBEParentKey_aL; 0)
				ARRAY LONGINT:C221($ChildNBEGrandParentKey_aL; 0)
				ARRAY TEXT:C222($ChildNBENotes_atxt; 0)
				ARRAY BOOLEAN:C223($ChildNBEQorP; 0)
				ARRAY REAL:C219($ChildNBEScaleF_ar; 0)
				ARRAY REAL:C219($ChildNBEQ_ar; 0)
				ARRAY REAL:C219($ChildNBEQ1_ar; 0)
				ARRAY REAL:C219($ChildNBEQ2_ar; 0)
				ARRAY REAL:C219($ChildNBEQ3_ar; 0)
				ARRAY REAL:C219($ChildNBEQ4_ar; 0)
				ARRAY LONGINT:C221($ChildElmID_aL; 0)
				ARRAY LONGINT:C221($ChildParID_aL; 0)
				ARRAY LONGINT:C221($ChildGParID_aL; 0)
				
				SELECTION TO ARRAY:C260([PON_ELEM_INSP:179]ELEM_KEY:3; $ChildNBEKey_aL; \
					[PON_ELEM_INSP:179]ENVKEY:5; $ChildNBEEnv_al; \
					[PON_ELEM_INSP:179]STRUNITKEY:6; $ChildNBStrUnit_aL; \
					[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4; $ChildNBEParentKey_aL; \
					[PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19; $ChildNBEGrandParentKey_aL; \
					[PON_ELEM_INSP:179]ELEM_NOTES:20; $ChildNBENotes_atxt; \
					[PON_ELEM_INSP:179]ELEM_QorP:29; $ChildNBEQorP; \
					[PON_ELEM_INSP:179]ELEM_SCALE_FACTOR:8; $ChildNBEScaleF_ar; \
					[PON_ELEM_INSP:179]ELEM_QUANTITY:7; $ChildNBEQ_ar; \
					[PON_ELEM_INSP:179]ELEM_QTYSTATE1:13; $ChildNBEQ1_ar; \
					[PON_ELEM_INSP:179]ELEM_QTYSTATE2:14; $ChildNBEQ2_ar; \
					[PON_ELEM_INSP:179]ELEM_QTYSTATE3:15; $ChildNBEQ3_ar; \
					[PON_ELEM_INSP:179]ELEM_QTYSTATE4:16; $ChildNBEQ4_ar; \
					[PON_ELEM_INSP:179]ELEM_PARENTID:27; $ChildParID_aL; \
					[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; $ChildGParID_aL; \
					[PON_ELEM_INSP:179]ELEMID:22; $ChildElmID_aL\
					)
				
				//append to arrays
				
				For ($childLoop_L; 1; Size of array:C274($ChildNBEKey_aL))
					APPEND TO ARRAY:C911($NBEKey_aL; $ChildNBEKey_aL{$childLoop_L})
					APPEND TO ARRAY:C911($NBEEnv_al; $ChildNBEEnv_al{$childLoop_L})
					APPEND TO ARRAY:C911($NBStrUnit_aL; $ChildNBStrUnit_aL{$childLoop_L})
					APPEND TO ARRAY:C911($NBEParentKey_aL; $ChildNBEParentKey_aL{$childLoop_L})
					APPEND TO ARRAY:C911($NBEGrandParentKey_aL; $ChildNBEGrandParentKey_aL{$childLoop_L})
					APPEND TO ARRAY:C911($NBENotes_atxt; $ChildNBENotes_atxt{$childLoop_L})
					APPEND TO ARRAY:C911($NBEQorP; $ChildNBEQorP{$childLoop_L})
					APPEND TO ARRAY:C911($NBEScaleF_ar; $ChildNBEScaleF_ar{$childLoop_L})
					APPEND TO ARRAY:C911($NBEQ_ar; $ChildNBEQ_ar{$childLoop_L})
					APPEND TO ARRAY:C911($NBEQ1_ar; $ChildNBEQ1_ar{$childLoop_L})
					APPEND TO ARRAY:C911($NBEQ2_ar; $ChildNBEQ2_ar{$childLoop_L})
					APPEND TO ARRAY:C911($NBEQ3_ar; $ChildNBEQ3_ar{$childLoop_L})
					APPEND TO ARRAY:C911($NBEQ4_ar; $ChildNBEQ4_ar{$childLoop_L})
					APPEND TO ARRAY:C911($NBEElmID_aL; $ChildElmID_aL{$childLoop_L})
					APPEND TO ARRAY:C911($NBEParID_aL; $ChildParID_aL{$childLoop_L})
					APPEND TO ARRAY:C911($NBEGParID_aL; $ChildGParID_aL{$childLoop_L})
					
				End for 
				
			End if 
			
			//find grand children
			QUERY:C277([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28=$NBEElmID_aL{$PrimaryNBE_L})
			If (Records in selection:C76([PON_ELEM_INSP:179])>0)
				//build the arrays of the NBE element data
				ARRAY LONGINT:C221($ChildNBEKey_aL; 0)
				ARRAY LONGINT:C221($ChildNBEEnv_al; 0)
				ARRAY LONGINT:C221($ChildNBStrUnit_aL; 0)
				ARRAY LONGINT:C221($ChildNBEParentKey_aL; 0)
				ARRAY LONGINT:C221($ChildNBEGrandParentKey_aL; 0)
				ARRAY TEXT:C222($ChildNBENotes_atxt; 0)
				ARRAY BOOLEAN:C223($ChildNBEQorP; 0)
				ARRAY REAL:C219($ChildNBEScaleF_ar; 0)
				ARRAY REAL:C219($ChildNBEQ_ar; 0)
				ARRAY REAL:C219($ChildNBEQ1_ar; 0)
				ARRAY REAL:C219($ChildNBEQ2_ar; 0)
				ARRAY REAL:C219($ChildNBEQ3_ar; 0)
				ARRAY REAL:C219($ChildNBEQ4_ar; 0)
				ARRAY LONGINT:C221($ChildElmID_aL; 0)
				ARRAY LONGINT:C221($ChildParID_aL; 0)
				ARRAY LONGINT:C221($ChildGParID_aL; 0)
				
				SELECTION TO ARRAY:C260([PON_ELEM_INSP:179]ELEM_KEY:3; $ChildNBEKey_aL; \
					[PON_ELEM_INSP:179]ENVKEY:5; $ChildNBEEnv_al; \
					[PON_ELEM_INSP:179]STRUNITKEY:6; $ChildNBStrUnit_aL; \
					[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4; $ChildNBEParentKey_aL; \
					[PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19; $ChildNBEGrandParentKey_aL; \
					[PON_ELEM_INSP:179]ELEM_NOTES:20; $ChildNBENotes_atxt; \
					[PON_ELEM_INSP:179]ELEM_QorP:29; $ChildNBEQorP; \
					[PON_ELEM_INSP:179]ELEM_SCALE_FACTOR:8; $ChildNBEScaleF_ar; \
					[PON_ELEM_INSP:179]ELEM_QUANTITY:7; $ChildNBEQ_ar; \
					[PON_ELEM_INSP:179]ELEM_QTYSTATE1:13; $ChildNBEQ1_ar; \
					[PON_ELEM_INSP:179]ELEM_QTYSTATE2:14; $ChildNBEQ2_ar; \
					[PON_ELEM_INSP:179]ELEM_QTYSTATE3:15; $ChildNBEQ3_ar; \
					[PON_ELEM_INSP:179]ELEM_QTYSTATE4:16; $ChildNBEQ4_ar; \
					[PON_ELEM_INSP:179]ELEM_PARENTID:27; $ChildParID_aL; \
					[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; $ChildGParID_aL; \
					[PON_ELEM_INSP:179]ELEMID:22; $ChildElmID_aL\
					)
				//append to arrays
				
				For ($childLoop_L; 1; Size of array:C274($ChildNBEKey_aL))
					APPEND TO ARRAY:C911($NBEKey_aL; $ChildNBEKey_aL{$childLoop_L})
					APPEND TO ARRAY:C911($NBEEnv_al; $ChildNBEEnv_al{$childLoop_L})
					APPEND TO ARRAY:C911($NBStrUnit_aL; $ChildNBStrUnit_aL{$childLoop_L})
					APPEND TO ARRAY:C911($NBEParentKey_aL; $ChildNBEParentKey_aL{$childLoop_L})
					APPEND TO ARRAY:C911($NBEGrandParentKey_aL; $ChildNBEGrandParentKey_aL{$childLoop_L})
					APPEND TO ARRAY:C911($NBENotes_atxt; $ChildNBENotes_atxt{$childLoop_L})
					APPEND TO ARRAY:C911($NBEQorP; $ChildNBEQorP{$childLoop_L})
					APPEND TO ARRAY:C911($NBEScaleF_ar; $ChildNBEScaleF_ar{$childLoop_L})
					APPEND TO ARRAY:C911($NBEQ_ar; $ChildNBEQ_ar{$childLoop_L})
					APPEND TO ARRAY:C911($NBEQ1_ar; $ChildNBEQ1_ar{$childLoop_L})
					APPEND TO ARRAY:C911($NBEQ2_ar; $ChildNBEQ2_ar{$childLoop_L})
					APPEND TO ARRAY:C911($NBEQ3_ar; $ChildNBEQ3_ar{$childLoop_L})
					APPEND TO ARRAY:C911($NBEQ4_ar; $ChildNBEQ4_ar{$childLoop_L})
					APPEND TO ARRAY:C911($NBEElmID_aL; $ChildElmID_aL{$childLoop_L})
					APPEND TO ARRAY:C911($NBEParID_aL; $ChildParID_aL{$childLoop_L})
					APPEND TO ARRAY:C911($NBEGParID_aL; $ChildGParID_aL{$childLoop_L})
					
				End for 
				
			End if 
			
		End for 
		
		//put arrays into object
		OB SET ARRAY:C1227($NBEElements_o; "keys"; $NBEKey_aL)
		OB SET ARRAY:C1227($NBEElements_o; "env"; $NBEEnv_al)
		OB SET ARRAY:C1227($NBEElements_o; "strunit"; $NBStrUnit_aL)
		OB SET ARRAY:C1227($NBEElements_o; "parent"; $NBEParentKey_aL)
		OB SET ARRAY:C1227($NBEElements_o; "grandparent"; $NBEGrandParentKey_aL)
		OB SET ARRAY:C1227($NBEElements_o; "notes"; $NBENotes_atxt)
		OB SET ARRAY:C1227($NBEElements_o; "qorp"; $NBEQorP)
		OB SET ARRAY:C1227($NBEElements_o; "scalef"; $NBEScaleF_ar)
		OB SET ARRAY:C1227($NBEElements_o; "totq"; $NBEQ_ar)
		OB SET ARRAY:C1227($NBEElements_o; "q1"; $NBEQ1_ar)
		OB SET ARRAY:C1227($NBEElements_o; "q2"; $NBEQ2_ar)
		OB SET ARRAY:C1227($NBEElements_o; "q3"; $NBEQ3_ar)
		OB SET ARRAY:C1227($NBEElements_o; "q4"; $NBEQ4_ar)
		OB SET ARRAY:C1227($NBEElements_o; "elemID"; $NBEElmID_aL)
		OB SET ARRAY:C1227($NBEElements_o; "parID"; $NBEParID_aL)
		OB SET ARRAY:C1227($NBEElements_o; "gparID"; $NBEGParID_aL)
		
		//add inspection used info
		C_TEXT:C284($UsedInspInfo_txt; $type_txt)
		ARRAY TEXT:C222($InspTypeCodes_atxt; 0)
		ARRAY TEXT:C222($InspTypeDesc_atxt; 0)
		Begin SQL
			select [Inspection Type].[Code],
			[Inspection Type].[Description]
			from
			[Inspection Type]
			into :$InspTypeCodes_atxt, :$InspTypeDesc_atxt ;
		End SQL
		C_LONGINT:C283($loop_L)
		$type_txt:=$UsedInspType_atxt{1}
		$UsedInspInfo_txt:=$UsedInspInfo_txt+Get_Description(->$InspTypeDesc_atxt; ->$InspTypeCodes_atxt; ->$type_txt)+"-"+String:C10($UsedInspDate_ad{1})
		
		For ($loop_L; 2; Size of array:C274($UsedInspType_atxt))
			$type_txt:=$UsedInspType_atxt{$loop_L}
			$UsedInspInfo_txt:=$UsedInspInfo_txt+", "+Get_Description(->$InspTypeDesc_atxt; ->$InspTypeCodes_atxt; ->$type_txt)+"-"+String:C10($UsedInspDate_ad{$loop_L})
		End for 
		
		OB SET:C1220($NBEElements_o; "usedInspInfo"; $UsedInspInfo_txt)
		
	End if 
	
	SET AUTOMATIC RELATIONS:C310($one_b; $many_b)
	
End if 

ut_db_RestoreROState($SaveROState_x)

If ($showProgress_b)
	//quit progress
	Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
	
End if 

$0:=$NBEElements_o
//End PON_CombineRecent