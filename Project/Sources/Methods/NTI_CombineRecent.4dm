//%attributes = {"invisible":true}
//Method: NTI_CombineRecent
//Description
//
// Parameters
// Combine NTE elements from the previous inspections starting from the last routine inspection
// return an object containing the element tree.
// object can be used to create a new set of elements for a new inspection, or
// to export for FHWA submittal
// Parameters
// $0 : $NTEElements_o
// $1 : $completed_b
// $2 : $Dbieapproved_b
// $3 : $startdate_d
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/07/19, 17:07:24
	// ----------------------------------------------------
	//Created : 
	Mods_2019_02_bug
	
	C_OBJECT:C1216(NTI_CombineRecent; $0)
	C_BOOLEAN:C305(NTI_CombineRecent; $1)
	C_BOOLEAN:C305(NTI_CombineRecent; $2)
	C_DATE:C307(NTI_CombineRecent; $3)
	
End if 
//

C_OBJECT:C1216($0; $NBEElements_o)

C_BLOB:C604($SaveROState_x)
$SaveROState_x:=ut_db_SaveROState
READ ONLY:C145(*)

//which BIN
C_TEXT:C284($BIN_)
$BIN_:=[NTI_TunnelInfo:181]NTI_i1_s:6
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

//start the bar
C_OBJECT:C1216($progress_o)
$progress_o:=ProgressNew("Combining NTEs from previous inspections-TIN "+Substring:C12($BIN_; 4; 3); 4; False:C215; ""; 0)  // 4 steps
C_LONGINT:C283($progressID_L)
$progressID_L:=OB Get:C1224($progress_o; "progress"; Is longint:K8:6)

ARRAY LONGINT:C221(InspIDS_aL; 0)
ARRAY DATE:C224(InspDates_ad; 0)
ARRAY TEXT:C222(InspTypes_atxt; 0)

C_TEXT:C284($sqlSelect_txt)

$sqlSelect_txt:="Select [TIN_Inspections].[InspectionID], [TIN_Inspections].[InspDate], [TIN_Inspections].[InspType] "+\
"from [TIN_Inspections] "+\
"Where [TIN_Inspections].[NTI_i1_S] = '"+$BIN_+"' and "+\
"[TIN_Inspections].[InspDate] < '"+String:C10($StartDate_d)+"'  "

If ($Completed_b)
	$sqlSelect_txt:=$sqlSelect_txt+" and ( "+\
		"cast([TIN_Inspections].[Complete] as INT) = 1 OR "+\
		"[TIN_Inspections].[InspCompleteDate] > '01/01/1900' ) "
End if 

If ($DBIEApproved_b)
	$sqlSelect_txt:=$sqlSelect_txt+" and ( "+\
		" [TIN_Inspections].[InspReview] = 2 OR "+\
		" [TIN_Inspections].[InspReviewDate] > '01/01/1900' ) "
End if 

$sqlSelect_txt:=$sqlSelect_txt+" order by [TIN_Inspections].[InspDate] DESC into :InspIDS_aL, :InspDates_ad, :InspTypes_atxt ;"
Begin SQL
	
	execute IMMEDIATE :$sqlSelect_txt
	
End SQL

If (Size of array:C274(InspIDS_aL)=0)
	OB SET:C1220($NBEElements_o; "error"; "No inspections with NTEs for TIN "+$BIN_+\
		" starting from date "+String:C10($StartDate_d)+\
		" Inspection completed = "+Choose:C955($Completed_b; "Required"; "Not Required")+\
		" DBIE Approved  "+Choose:C955($DBIEApproved_b; "Required"; "Not Required")\
		)
	
Else 
	//find last routine inspection
	C_LONGINT:C283($loop_L; $LastRoutineID_)
	$LastRoutineID_:=0
	For ($loop_L; 1; Size of array:C274(InspTypes_atxt))
		If ((InspTypes_atxt{$loop_L}="ZR@"))
			//Routine
			//check if it has any NTEs
			C_LONGINT:C283($NBECount_L; $InspID_L)
			$InspID_L:=InspIDS_aL{$loop_L}
			Begin SQL
				select count(*) from [NTI_ELEM_TIN_INSP]
				where [NTI_ELEM_TIN_INSP].[InspectionID] = :$InspID_L
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
	
	Begin SQL
		select 
		[NTI_ELEM_DEFS].[ELEM_KEY] ,
		[NTI_ELEM_DEFS].[ELEM_PROTECT_SYS],
		[NTI_ELEM_DEFS].[DEFECTFLAG]
		from
		[NTI_ELEM_DEFS]
		into
		:$elemDefKey_aL ,
		:$elemDef_Prot_atxt ,
		:$elemDef_defect_atxt ;
	End SQL
	
	C_LONGINT:C283($inspLoop_L; $InspNBE_L; $elemIndx_L; $elemIndxInSum_L)
	
	C_TEXT:C284($strUFmt_txt; $keyFmt_txt; $envfmt_txt)
	$strUFmt_txt:="000"
	$keyFmt_txt:="000000"
	$envfmt_txt:="000"
	
	ARRAY LONGINT:C221($NBEID_aL; 0)
	ARRAY TEXT:C222($NBECombineIndex_atxt; 0)  // combination SSSKKKKKKEEE (Struct unit, Key, Env)
	C_TEXT:C284($NBECombineIndex_txt)  // combination SSSKKKKKKEEE (Struct unit, Key, Env)
	ARRAY LONGINT:C221($InspNBEID_aL; 0)
	ARRAY LONGINT:C221($InspNBEKey_aL; 0)
	ARRAY LONGINT:C221($InspNBEStrUnit_aL; 0)
	ARRAY LONGINT:C221($InspNBEEnv_aL; 0)
	
	
	//start from the oldest insp - and start collecting major elements by str unit, key, env
	C_TEXT:C284($inspVerification_txt; $verificationErrors_txt)
	$inspVerification_txt:=""
	$verificationErrors_txt:=""
	C_BOOLEAN:C305($one_b; $many_b)
	GET AUTOMATIC RELATIONS:C899($one_b; $many_b)
	SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	
	For ($inspLoop_L; $LastRoutineID_; 1; -1)
		//first verify inspection
		Progress SET MESSAGE($progressID_L; "Inspection type "+InspTypes_atxt{$inspLoop_L}+" "+String:C10(InspDates_ad{$inspLoop_L})+" .. Verification step.")
		//$inspVerification_txt:=PON_VerifyNBELinks (InspIDS_aL{$inspLoop_L})
		
		If ($inspVerification_txt="")
			//no errors
			C_LONGINT:C283($CurrInspID_L)
			$CurrInspID_L:=InspIDS_aL{$inspLoop_L}
			
			Begin SQL
				select [NTI_ELEM_TIN_INSP].[ELEMID]
				, [NTI_ELEM_TIN_INSP].[ELEM_KEY]
				from [NTI_ELEM_TIN_INSP]
				where
				[NTI_ELEM_TIN_INSP].[InspectionID] = :$CurrInspID_L
				into 
				:$InspNBEID_aL ,
				:$InspNBEKey_aL ;
				
			End SQL
			//size the other arrays the same size for the rest of the code to work
			ARRAY LONGINT:C221($InspNBEStrUnit_aL; Size of array:C274($InspNBEKey_aL))
			ARRAY LONGINT:C221($InspNBEEnv_aL; Size of array:C274($InspNBEKey_aL))
			
			
			Progress SET MESSAGE($progressID_L; "Inspection type "+InspTypes_atxt{$inspLoop_L}+" "+String:C10(InspDates_ad{$inspLoop_L})+" .. Scanning "+String:C10(Size of array:C274($InspNBEKey_aL))+" NTEs")
			
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
		ARRAY BLOB:C1222($NBENotes_ablb; 0)
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
		
		Progress SET MESSAGE($progressID_L; "Compiling "+String:C10(Size of array:C274($NBEID_aL))+" primary NTEs")
		//first do the primary elements
		QUERY WITH ARRAY:C644([NTI_ELEM_TIN_INSP:185]ELEMID:2; $NBEID_aL)
		SELECTION TO ARRAY:C260([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3; $NBEKey_aL; \
			[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7; $NBEParentKey_aL; \
			[NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_KEY:25; $NBEGrandParentKey_aL; \
			[NTI_ELEM_TIN_INSP:185]ELEM_NOTES:9; $NBENotes_ablb; \
			[NTI_ELEM_TIN_INSP:185]ELEM_QorP:16; $NBEQorP; \
			[NTI_ELEM_TIN_INSP:185]ELEM_SCALE_FACTOR:22; $NBEScaleF_ar; \
			[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; $NBEQ_ar; \
			[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; $NBEQ1_ar; \
			[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18; $NBEQ2_ar; \
			[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19; $NBEQ3_ar; \
			[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20; $NBEQ4_ar; \
			[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8; $NBEParID_aL; \
			[NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_ID:26; $NBEGParID_aL; \
			[NTI_ELEM_TIN_INSP:185]ELEMID:2; $NBEElmID_aL\
			)
		
		ARRAY LONGINT:C221($NBEEnv_al; Size of array:C274($NBEKey_aL))
		ARRAY LONGINT:C221($NBStrUnit_aL; Size of array:C274($NBEKey_aL))
		
		C_LONGINT:C283($PrimaryNBE_L)
		//loop through primary NTEs and get children and grand children
		Progress SET MESSAGE($progressID_L; "Getting related elements for "+String:C10(Size of array:C274($NBEID_aL))+" primary NTEs")
		
		For ($PrimaryNBE_L; 1; Size of array:C274($NBEElmID_aL))
			Progress SET MESSAGE($progressID_L; "Getting related elements for "+String:C10($PrimaryNBE_L)+" of "+String:C10(Size of array:C274($NBEID_aL))+" primary NBEs")
			
			C_LONGINT:C283($childLoop_L)
			
			//find children
			QUERY:C277([NTI_ELEM_TIN_INSP:185]; [NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8=$NBEElmID_aL{$PrimaryNBE_L})
			
			If (Records in selection:C76([NTI_ELEM_TIN_INSP:185])>0)
				//build the arrays of the NBE element data
				ARRAY LONGINT:C221($ChildNBEKey_aL; 0)
				ARRAY LONGINT:C221($ChildNBEEnv_al; 0)
				ARRAY LONGINT:C221($ChildNBStrUnit_aL; 0)
				ARRAY LONGINT:C221($ChildNBEParentKey_aL; 0)
				ARRAY LONGINT:C221($ChildNBEGrandParentKey_aL; 0)
				ARRAY BLOB:C1222($ChildNBENotes_ablb; 0)
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
				
				SELECTION TO ARRAY:C260([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3; $ChildNBEKey_aL; \
					[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7; $ChildNBEParentKey_aL; \
					[NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_KEY:25; $ChildNBEGrandParentKey_aL; \
					[NTI_ELEM_TIN_INSP:185]ELEM_NOTES:9; $ChildNBENotes_ablb; \
					[NTI_ELEM_TIN_INSP:185]ELEM_QorP:16; $ChildNBEQorP; \
					[NTI_ELEM_TIN_INSP:185]ELEM_SCALE_FACTOR:22; $ChildNBEScaleF_ar; \
					[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; $ChildNBEQ_ar; \
					[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; $ChildNBEQ1_ar; \
					[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18; $ChildNBEQ2_ar; \
					[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19; $ChildNBEQ3_ar; \
					[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20; $ChildNBEQ4_ar; \
					[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8; $ChildParID_aL; \
					[NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_ID:26; $ChildGParID_aL; \
					[NTI_ELEM_TIN_INSP:185]ELEMID:2; $ChildElmID_aL\
					)
				ARRAY LONGINT:C221($ChildNBEEnv_al; Size of array:C274($ChildNBEKey_aL))
				ARRAY LONGINT:C221($ChildNBStrUnit_aL; Size of array:C274($ChildNBEKey_aL))
				
				//append to arrays
				
				For ($childLoop_L; 1; Size of array:C274($ChildNBEKey_aL))
					APPEND TO ARRAY:C911($NBEKey_aL; $ChildNBEKey_aL{$childLoop_L})
					APPEND TO ARRAY:C911($NBEEnv_al; $ChildNBEEnv_al{$childLoop_L})
					APPEND TO ARRAY:C911($NBStrUnit_aL; $ChildNBStrUnit_aL{$childLoop_L})
					APPEND TO ARRAY:C911($NBEParentKey_aL; $ChildNBEParentKey_aL{$childLoop_L})
					APPEND TO ARRAY:C911($NBEGrandParentKey_aL; $ChildNBEGrandParentKey_aL{$childLoop_L})
					APPEND TO ARRAY:C911($NBENotes_ablb; $ChildNBENotes_ablb{$childLoop_L})
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
			QUERY:C277([NTI_ELEM_TIN_INSP:185]; [NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_ID:26=$NBEElmID_aL{$PrimaryNBE_L})
			If (Records in selection:C76([NTI_ELEM_TIN_INSP:185])>0)
				//build the arrays of the NBE element data
				ARRAY LONGINT:C221($ChildNBEKey_aL; 0)
				ARRAY LONGINT:C221($ChildNBEEnv_al; 0)
				ARRAY LONGINT:C221($ChildNBStrUnit_aL; 0)
				ARRAY LONGINT:C221($ChildNBEParentKey_aL; 0)
				ARRAY LONGINT:C221($ChildNBEGrandParentKey_aL; 0)
				ARRAY BLOB:C1222($ChildNBENotes_ablb; 0)
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
				
				SELECTION TO ARRAY:C260([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3; $ChildNBEKey_aL; \
					[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7; $ChildNBEParentKey_aL; \
					[NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_KEY:25; $ChildNBEGrandParentKey_aL; \
					[NTI_ELEM_TIN_INSP:185]ELEM_NOTES:9; $ChildNBENotes_ablb; \
					[NTI_ELEM_TIN_INSP:185]ELEM_QorP:16; $ChildNBEQorP; \
					[NTI_ELEM_TIN_INSP:185]ELEM_SCALE_FACTOR:22; $ChildNBEScaleF_ar; \
					[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; $ChildNBEQ_ar; \
					[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; $ChildNBEQ1_ar; \
					[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18; $ChildNBEQ2_ar; \
					[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19; $ChildNBEQ3_ar; \
					[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20; $ChildNBEQ4_ar; \
					[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8; $ChildParID_aL; \
					[NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_ID:26; $ChildGParID_aL; \
					[NTI_ELEM_TIN_INSP:185]ELEMID:2; $ChildElmID_aL\
					)
				ARRAY LONGINT:C221($ChildNBEEnv_al; Size of array:C274($ChildNBEKey_aL))
				ARRAY LONGINT:C221($ChildNBStrUnit_aL; Size of array:C274($ChildNBEKey_aL))
				
				//append to arrays
				For ($childLoop_L; 1; Size of array:C274($ChildNBEKey_aL))
					APPEND TO ARRAY:C911($NBEKey_aL; $ChildNBEKey_aL{$childLoop_L})
					APPEND TO ARRAY:C911($NBEEnv_al; $ChildNBEEnv_al{$childLoop_L})
					APPEND TO ARRAY:C911($NBStrUnit_aL; $ChildNBStrUnit_aL{$childLoop_L})
					APPEND TO ARRAY:C911($NBEParentKey_aL; $ChildNBEParentKey_aL{$childLoop_L})
					APPEND TO ARRAY:C911($NBEGrandParentKey_aL; $ChildNBEGrandParentKey_aL{$childLoop_L})
					APPEND TO ARRAY:C911($NBENotes_ablb; $ChildNBENotes_ablb{$childLoop_L})
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
		//need to convert the blob array to text
		ARRAY TEXT:C222($NBEBlob_atxt; Size of array:C274($NBENotes_ablb))
		C_LONGINT:C283($array_L)
		For ($array_L; 1; Size of array:C274($NBENotes_ablb))
			BASE64 ENCODE:C895($NBENotes_ablb{$array_L}; $NBEBlob_atxt{$array_L})
		End for 
		
		OB SET ARRAY:C1227($NBEElements_o; "keys"; $NBEKey_aL)
		OB SET ARRAY:C1227($NBEElements_o; "env"; $NBEEnv_al)
		OB SET ARRAY:C1227($NBEElements_o; "strunit"; $NBStrUnit_aL)
		OB SET ARRAY:C1227($NBEElements_o; "parent"; $NBEParentKey_aL)
		OB SET ARRAY:C1227($NBEElements_o; "grandparent"; $NBEGrandParentKey_aL)
		OB SET ARRAY:C1227($NBEElements_o; "notes"; $NBEBlob_atxt)  // save the base64 encoded blob
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
	End if 
	
	SET AUTOMATIC RELATIONS:C310($one_b; $many_b)
	
End if 

ut_db_RestoreROState($SaveROState_x)

//quit progress
Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))

$0:=$NBEElements_o
//End NTI_CombineRecent