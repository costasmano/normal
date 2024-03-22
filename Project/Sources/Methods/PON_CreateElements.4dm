//%attributes = {"invisible":true}
//Method: PON_CreateElements
//Description
// create new NBE elements for the current inspection record based on an nbe object
// Parameters
// $1 : $NBEobject_o : object containing arrays of NBEs . it can be the output from PON_CombineRecent method
// $2 : change stack level - default is PON_ChangeStackLvl_L

// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/08/19, 14:28:43
	// ----------------------------------------------------
	//Created : 
	Mods_2019_01
	
	
	C_OBJECT:C1216(PON_CreateElements; $1)
	C_LONGINT:C283(PON_CreateElements; $2)
End if 
//

If ([Inspections:27]InspID:2=0)
Else 
	
	C_OBJECT:C1216($1; $NBEElements_o)
	
	$NBEElements_o:=$1
	
	C_LONGINT:C283($changeStack_L)
	$changeStack_L:=PON_ChangeStackLvl_L
	If (Count parameters:C259>1)
		C_LONGINT:C283($2)
		$changeStack_L:=$2
	End if 
	
	//start the bar
	C_OBJECT:C1216($progress_o)
	
	
	C_TEXT:C284($NewInspKey_txt)
	$NewInspKey_txt:=PON_INSPID2INSPKEY([Inspections:27]InspID:2)
	
	
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
	
	//get the arrays from the object
	OB GET ARRAY:C1229($NBEElements_o; "keys"; $NBEKey_aL)
	OB GET ARRAY:C1229($NBEElements_o; "env"; $NBEEnv_al)
	OB GET ARRAY:C1229($NBEElements_o; "strunit"; $NBStrUnit_aL)
	OB GET ARRAY:C1229($NBEElements_o; "parent"; $NBEParentKey_aL)
	OB GET ARRAY:C1229($NBEElements_o; "grandparent"; $NBEGrandParentKey_aL)
	OB GET ARRAY:C1229($NBEElements_o; "notes"; $NBENotes_atxt)
	OB GET ARRAY:C1229($NBEElements_o; "qorp"; $NBEQorP)
	OB GET ARRAY:C1229($NBEElements_o; "scalef"; $NBEScaleF_ar)
	OB GET ARRAY:C1229($NBEElements_o; "totq"; $NBEQ_ar)
	OB GET ARRAY:C1229($NBEElements_o; "q1"; $NBEQ1_ar)
	OB GET ARRAY:C1229($NBEElements_o; "q2"; $NBEQ2_ar)
	OB GET ARRAY:C1229($NBEElements_o; "q3"; $NBEQ3_ar)
	OB GET ARRAY:C1229($NBEElements_o; "q4"; $NBEQ4_ar)
	OB GET ARRAY:C1229($NBEElements_o; "elemID"; $NBEElmID_aL)
	OB GET ARRAY:C1229($NBEElements_o; "parID"; $NBEParID_aL)
	OB GET ARRAY:C1229($NBEElements_o; "gparID"; $NBEGParID_aL)
	
	ARRAY LONGINT:C221($NewNBEIDs_aL; Size of array:C274($NBEKey_aL))  //array to hold the IDs of the new elements created
	ARRAY TEXT:C222($lookup_atxt; Size of array:C274($NBEKey_aL))  // array for easy lookup  SSSEEEKKKKKK
	C_TEXT:C284($StrUFmt_txt; $envFmt_txt; $keyFmt_txt)
	$StrUFmt_txt:="000"
	$envFmt_txt:="000"
	$keyFmt_txt:="000000"
	
	For ($elemLoop_L; 1; Size of array:C274($NBEKey_aL))
		$lookup_atxt{$elemLoop_L}:=String:C10($NBStrUnit_aL{$elemLoop_L}; $StrUFmt_txt)+String:C10($NBEEnv_al{$elemLoop_L}; $envFmt_txt)
		
		Case of 
			: ($NBEGrandParentKey_aL{$elemLoop_L}>0)
				$lookup_atxt{$elemLoop_L}:=$lookup_atxt{$elemLoop_L}+\
					String:C10($NBEGrandParentKey_aL{$elemLoop_L}; $keyFmt_txt)+\
					String:C10($NBEParentKey_aL{$elemLoop_L}; $keyFmt_txt)+\
					String:C10($NBEKey_aL{$elemLoop_L}; $keyFmt_txt)
			: ($NBEParentKey_aL{$elemLoop_L}>0)
				$lookup_atxt{$elemLoop_L}:=$lookup_atxt{$elemLoop_L}+\
					String:C10($NBEParentKey_aL{$elemLoop_L}; $keyFmt_txt)+\
					String:C10($NBEKey_aL{$elemLoop_L}; $keyFmt_txt)+\
					String:C10(0; $keyFmt_txt)
			Else 
				$lookup_atxt{$elemLoop_L}:=$lookup_atxt{$elemLoop_L}+\
					String:C10($NBEKey_aL{$elemLoop_L}; $keyFmt_txt)+\
					String:C10(0; $keyFmt_txt)+String:C10(0; $keyFmt_txt)
				
		End case 
		
	End for 
	
	PON_SETARRAYS  // initialize dictionary arrays
	
	InitChangeStack($changeStack_L)
	ARRAY LONGINT:C221($PrimaryIDs_aL; 0)
	ARRAY LONGINT:C221($ProtSysIDS_aL; 0)
	ARRAY LONGINT:C221($defectIDs_aL; 0)
	C_LONGINT:C283($loop_L)
	For ($elemLoop_L; 1; Size of array:C274($NBEKey_aL))
		
		Case of 
			: (Find in array:C230(PON_MASTERELEM_KEY_aL; $NBEKey_aL{$elemLoop_L})>0)
				APPEND TO ARRAY:C911($PrimaryIDs_aL; $NBEElmID_aL{$elemLoop_L})
			: (Find in array:C230(PON_PROTSYSELEM_KEY_aL; $NBEKey_aL{$elemLoop_L})>0)
				APPEND TO ARRAY:C911($ProtSysIDS_aL; $NBEElmID_aL{$elemLoop_L})
			: (Find in array:C230(PON_SFLAGSELEM_KEY_aL; $NBEKey_aL{$elemLoop_L})>0)
				APPEND TO ARRAY:C911($defectIDs_aL; $NBEElmID_aL{$elemLoop_L})
		End case 
		
	End for 
	
	$progress_o:=ProgressNew("Creating NBEs"; Size of array:C274($NBEKey_aL); False:C215; ""; 0)
	
	//update progress
	UpdateProgressNew($progress_o; 0)
	
	OB SET:C1220($progress_o; "timeOpt"; 3)  // change the time option display
	
	C_LONGINT:C283($elemLoop_L; $elemIndx_L)
	
	//pass 1 - do only master elements
	OB SET:C1220($progress_o; "msgtempl"; " primary element"; "total"; Size of array:C274($PrimaryIDs_aL))
	Progress SET TITLE(OB Get:C1224($progress_o; "progress"; Is longint:K8:6); "Creating Primary Elements..")
	
	For ($elemLoop_L; 1; Size of array:C274($PrimaryIDs_aL))
		UpdateProgressNew($progress_o; $elemLoop_L)
		$elemIndx_L:=Find in array:C230($NBEElmID_aL; $PrimaryIDs_aL{$elemLoop_L})
		
		CREATE RECORD:C68([PON_ELEM_INSP:179])
		Inc_Sequence("PON_ELEM_INSP"; ->[PON_ELEM_INSP:179]ELEMID:22)
		$NewNBEIDs_aL{$elemIndx_L}:=[PON_ELEM_INSP:179]ELEMID:22  //save the ID created
		
		[PON_ELEM_INSP:179]ELEM_KEY:3:=$NBEKey_aL{$elemIndx_L}
		[PON_ELEM_INSP:179]ENVKEY:5:=$NBEEnv_al{$elemIndx_L}
		[PON_ELEM_INSP:179]STRUNITKEY:6:=$NBStrUnit_aL{$elemIndx_L}
		[PON_ELEM_INSP:179]ELEM_QorP:29:=$NBEQorP{$elemIndx_L}
		[PON_ELEM_INSP:179]ELEM_NOTES:20:=$NBENotes_atxt{$elemIndx_L}
		[PON_ELEM_INSP:179]BRKEY:1:=[Inspections:27]BIN:1
		[PON_ELEM_INSP:179]INSPID:21:=[Inspections:27]InspID:2
		[PON_ELEM_INSP:179]INSPKEY:2:=$NewInspKey_txt
		[PON_ELEM_INSP:179]ELEM_CREATEDATETIME:17:=ISODateTime(Current date:C33(*); Current time:C178(*))
		[PON_ELEM_INSP:179]ELEM_CREATEUSERKEY:24:=Current user:C182
		
		[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4:=0
		[PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19:=0
		[PON_ELEM_INSP:179]ELEM_PARENTID:27:=0
		[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28:=0
		[PON_ELEM_INSP:179]ELEM_SCALE_FACTOR:8:=$NBEScaleF_ar{$elemIndx_L}
		If ([PON_ELEM_INSP:179]ELEM_SCALE_FACTOR:8=0)
			[PON_ELEM_INSP:179]ELEM_SCALE_FACTOR:8:=1  //default scale factor to 1
		End if 
		[PON_ELEM_INSP:179]ELEM_QUANTITY:7:=$NBEQ_ar{$elemIndx_L}
		[PON_ELEM_INSP:179]ELEM_QTYSTATE1:13:=$NBEQ1_ar{$elemIndx_L}
		[PON_ELEM_INSP:179]ELEM_QTYSTATE2:14:=$NBEQ2_ar{$elemIndx_L}
		[PON_ELEM_INSP:179]ELEM_QTYSTATE3:15:=$NBEQ3_ar{$elemIndx_L}
		[PON_ELEM_INSP:179]ELEM_QTYSTATE4:16:=$NBEQ4_ar{$elemIndx_L}
		//calculate percentages
		[PON_ELEM_INSP:179]ELEM_PCTSTATE2:10:=Round:C94(100*[PON_ELEM_INSP:179]ELEM_QTYSTATE2:14/[PON_ELEM_INSP:179]ELEM_QUANTITY:7; PON_RoundP_L)
		[PON_ELEM_INSP:179]ELEM_PCTSTATE3:11:=Round:C94(100*[PON_ELEM_INSP:179]ELEM_QTYSTATE3:15/[PON_ELEM_INSP:179]ELEM_QUANTITY:7; PON_RoundP_L)
		[PON_ELEM_INSP:179]ELEM_PCTSTATE4:12:=Round:C94(100*[PON_ELEM_INSP:179]ELEM_QTYSTATE4:16/[PON_ELEM_INSP:179]ELEM_QUANTITY:7; PON_RoundP_L)
		[PON_ELEM_INSP:179]ELEM_PCTSTATE1:9:=100-[PON_ELEM_INSP:179]ELEM_PCTSTATE2:10-[PON_ELEM_INSP:179]ELEM_PCTSTATE3:11-[PON_ELEM_INSP:179]ELEM_PCTSTATE4:12
		
		LogNewRecordChanges(->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; "PON_ELEM_INSP"; $changeStack_L; ->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; ->[PON_ELEM_INSP:179]ELEM_PARENTID:27)
		If ([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28>0)
			LogLink(->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179]ELEMID:22)
		End if 
		If ([PON_ELEM_INSP:179]ELEM_PARENTID:27>0)
			LogLink(->[PON_ELEM_INSP:179]ELEM_PARENTID:27; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179]ELEMID:22)
		End if 
		SAVE RECORD:C53([PON_ELEM_INSP:179])
		
	End for 
	
	C_TEXT:C284($parentlookup_txt)
	
	// pass 2 - do only prot sys
	OB SET:C1220($progress_o; "msgtempl"; " protective system"; "total"; Size of array:C274($ProtSysIDS_aL))
	Progress SET TITLE(OB Get:C1224($progress_o; "progress"; Is longint:K8:6); "Creating Protective Systems..")
	
	For ($elemLoop_L; 1; Size of array:C274($ProtSysIDS_aL))
		UpdateProgressNew($progress_o; $elemLoop_L)
		$elemIndx_L:=Find in array:C230($NBEElmID_aL; $ProtSysIDS_aL{$elemLoop_L})
		
		CREATE RECORD:C68([PON_ELEM_INSP:179])
		Inc_Sequence("PON_ELEM_INSP"; ->[PON_ELEM_INSP:179]ELEMID:22)
		$NewNBEIDs_aL{$elemIndx_L}:=[PON_ELEM_INSP:179]ELEMID:22  //save the ID created
		
		[PON_ELEM_INSP:179]ELEM_KEY:3:=$NBEKey_aL{$elemIndx_L}
		[PON_ELEM_INSP:179]ENVKEY:5:=$NBEEnv_al{$elemIndx_L}
		[PON_ELEM_INSP:179]STRUNITKEY:6:=$NBStrUnit_aL{$elemIndx_L}
		[PON_ELEM_INSP:179]ELEM_QorP:29:=$NBEQorP{$elemIndx_L}
		[PON_ELEM_INSP:179]ELEM_NOTES:20:=$NBENotes_atxt{$elemIndx_L}
		[PON_ELEM_INSP:179]BRKEY:1:=[Inspections:27]BIN:1
		[PON_ELEM_INSP:179]INSPID:21:=[Inspections:27]InspID:2
		[PON_ELEM_INSP:179]INSPKEY:2:=$NewInspKey_txt
		[PON_ELEM_INSP:179]ELEM_CREATEDATETIME:17:=ISODateTime(Current date:C33(*); Current time:C178(*))
		[PON_ELEM_INSP:179]ELEM_CREATEUSERKEY:24:=Current user:C182
		
		[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4:=$NBEParentKey_aL{$elemIndx_L}
		[PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19:=0
		$parentlookup_txt:=String:C10($NBStrUnit_aL{$elemIndx_L}; $StrUFmt_txt)+String:C10($NBEEnv_al{$elemIndx_L}; $envFmt_txt)+\
			String:C10($NBEParentKey_aL{$elemIndx_L}; $keyFmt_txt)+String:C10(0; $keyFmt_txt)+String:C10(0; $keyFmt_txt)
		
		[PON_ELEM_INSP:179]ELEM_PARENTID:27:=$NewNBEIDs_aL{Find in array:C230($lookup_atxt; $parentlookup_txt)}
		[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28:=0
		[PON_ELEM_INSP:179]ELEM_SCALE_FACTOR:8:=$NBEScaleF_ar{$elemIndx_L}
		If ([PON_ELEM_INSP:179]ELEM_SCALE_FACTOR:8=0)
			[PON_ELEM_INSP:179]ELEM_SCALE_FACTOR:8:=1  //default scale factor to 1
		End if 
		[PON_ELEM_INSP:179]ELEM_QUANTITY:7:=$NBEQ_ar{$elemIndx_L}
		[PON_ELEM_INSP:179]ELEM_QTYSTATE1:13:=$NBEQ1_ar{$elemIndx_L}
		[PON_ELEM_INSP:179]ELEM_QTYSTATE2:14:=$NBEQ2_ar{$elemIndx_L}
		[PON_ELEM_INSP:179]ELEM_QTYSTATE3:15:=$NBEQ3_ar{$elemIndx_L}
		[PON_ELEM_INSP:179]ELEM_QTYSTATE4:16:=$NBEQ4_ar{$elemIndx_L}
		//calculate percentages
		[PON_ELEM_INSP:179]ELEM_PCTSTATE2:10:=Round:C94(100*[PON_ELEM_INSP:179]ELEM_QTYSTATE2:14/[PON_ELEM_INSP:179]ELEM_QUANTITY:7; PON_RoundP_L)
		[PON_ELEM_INSP:179]ELEM_PCTSTATE3:11:=Round:C94(100*[PON_ELEM_INSP:179]ELEM_QTYSTATE3:15/[PON_ELEM_INSP:179]ELEM_QUANTITY:7; PON_RoundP_L)
		[PON_ELEM_INSP:179]ELEM_PCTSTATE4:12:=Round:C94(100*[PON_ELEM_INSP:179]ELEM_QTYSTATE4:16/[PON_ELEM_INSP:179]ELEM_QUANTITY:7; PON_RoundP_L)
		[PON_ELEM_INSP:179]ELEM_PCTSTATE1:9:=100-[PON_ELEM_INSP:179]ELEM_PCTSTATE2:10-[PON_ELEM_INSP:179]ELEM_PCTSTATE3:11-[PON_ELEM_INSP:179]ELEM_PCTSTATE4:12
		
		LogNewRecordChanges(->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; "PON_ELEM_INSP"; $changeStack_L; ->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; ->[PON_ELEM_INSP:179]ELEM_PARENTID:27)
		If ([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28>0)
			LogLink(->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179]ELEMID:22)
		End if 
		If ([PON_ELEM_INSP:179]ELEM_PARENTID:27>0)
			LogLink(->[PON_ELEM_INSP:179]ELEM_PARENTID:27; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179]ELEMID:22)
		End if 
		SAVE RECORD:C53([PON_ELEM_INSP:179])
		
		
	End for 
	
	// pass 3 - do the defects
	OB SET:C1220($progress_o; "msgtempl"; " defect"; "total"; Size of array:C274($defectIDs_aL))
	Progress SET TITLE(OB Get:C1224($progress_o; "progress"; Is longint:K8:6); "Creating Defects..")
	For ($elemLoop_L; 1; Size of array:C274($defectIDs_aL))
		UpdateProgressNew($progress_o; $elemLoop_L)
		$elemIndx_L:=Find in array:C230($NBEElmID_aL; $defectIDs_aL{$elemLoop_L})
		
		CREATE RECORD:C68([PON_ELEM_INSP:179])
		Inc_Sequence("PON_ELEM_INSP"; ->[PON_ELEM_INSP:179]ELEMID:22)
		$NewNBEIDs_aL{$elemIndx_L}:=[PON_ELEM_INSP:179]ELEMID:22  //save the ID created
		
		[PON_ELEM_INSP:179]ELEM_KEY:3:=$NBEKey_aL{$elemIndx_L}
		[PON_ELEM_INSP:179]ENVKEY:5:=$NBEEnv_al{$elemIndx_L}
		[PON_ELEM_INSP:179]STRUNITKEY:6:=$NBStrUnit_aL{$elemIndx_L}
		[PON_ELEM_INSP:179]ELEM_QorP:29:=$NBEQorP{$elemIndx_L}
		[PON_ELEM_INSP:179]ELEM_NOTES:20:=$NBENotes_atxt{$elemIndx_L}
		[PON_ELEM_INSP:179]BRKEY:1:=[Inspections:27]BIN:1
		[PON_ELEM_INSP:179]INSPID:21:=[Inspections:27]InspID:2
		[PON_ELEM_INSP:179]INSPKEY:2:=$NewInspKey_txt
		[PON_ELEM_INSP:179]ELEM_CREATEDATETIME:17:=ISODateTime(Current date:C33(*); Current time:C178(*))
		[PON_ELEM_INSP:179]ELEM_CREATEUSERKEY:24:=Current user:C182
		
		[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4:=$NBEParentKey_aL{$elemIndx_L}
		[PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19:=$NBEGrandParentKey_aL{$elemIndx_L}
		
		If ([PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19>0)
			$parentlookup_txt:=String:C10($NBStrUnit_aL{$elemIndx_L}; $StrUFmt_txt)+String:C10($NBEEnv_al{$elemIndx_L}; $envFmt_txt)+\
				String:C10($NBEGrandParentKey_aL{$elemIndx_L}; $keyFmt_txt)+String:C10(0; $keyFmt_txt)+String:C10(0; $keyFmt_txt)
			[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28:=$NewNBEIDs_aL{Find in array:C230($lookup_atxt; $parentlookup_txt)}
			
			$parentlookup_txt:=String:C10($NBStrUnit_aL{$elemIndx_L}; $StrUFmt_txt)+String:C10($NBEEnv_al{$elemIndx_L}; $envFmt_txt)+\
				String:C10($NBEGrandParentKey_aL{$elemIndx_L}; $keyFmt_txt)+String:C10($NBEParentKey_aL{$elemIndx_L}; $keyFmt_txt)+String:C10(0; $keyFmt_txt)
			[PON_ELEM_INSP:179]ELEM_PARENTID:27:=$NewNBEIDs_aL{Find in array:C230($lookup_atxt; $parentlookup_txt)}
			
		Else 
			$parentlookup_txt:=String:C10($NBStrUnit_aL{$elemIndx_L}; $StrUFmt_txt)+String:C10($NBEEnv_al{$elemIndx_L}; $envFmt_txt)+\
				String:C10($NBEParentKey_aL{$elemIndx_L}; $keyFmt_txt)+String:C10(0; $keyFmt_txt)+String:C10(0; $keyFmt_txt)
			[PON_ELEM_INSP:179]ELEM_PARENTID:27:=$NewNBEIDs_aL{Find in array:C230($lookup_atxt; $parentlookup_txt)}
			[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28:=0
			
		End if 
		[PON_ELEM_INSP:179]ELEM_SCALE_FACTOR:8:=$NBEScaleF_ar{$elemIndx_L}
		If ([PON_ELEM_INSP:179]ELEM_SCALE_FACTOR:8=0)
			[PON_ELEM_INSP:179]ELEM_SCALE_FACTOR:8:=1  //default scale factor to 1
		End if 
		[PON_ELEM_INSP:179]ELEM_QUANTITY:7:=$NBEQ_ar{$elemIndx_L}
		[PON_ELEM_INSP:179]ELEM_QTYSTATE1:13:=$NBEQ1_ar{$elemIndx_L}
		[PON_ELEM_INSP:179]ELEM_QTYSTATE2:14:=$NBEQ2_ar{$elemIndx_L}
		[PON_ELEM_INSP:179]ELEM_QTYSTATE3:15:=$NBEQ3_ar{$elemIndx_L}
		[PON_ELEM_INSP:179]ELEM_QTYSTATE4:16:=$NBEQ4_ar{$elemIndx_L}
		//calculate percentages
		[PON_ELEM_INSP:179]ELEM_PCTSTATE2:10:=Round:C94(100*[PON_ELEM_INSP:179]ELEM_QTYSTATE2:14/[PON_ELEM_INSP:179]ELEM_QUANTITY:7; PON_RoundP_L)
		[PON_ELEM_INSP:179]ELEM_PCTSTATE3:11:=Round:C94(100*[PON_ELEM_INSP:179]ELEM_QTYSTATE3:15/[PON_ELEM_INSP:179]ELEM_QUANTITY:7; PON_RoundP_L)
		[PON_ELEM_INSP:179]ELEM_PCTSTATE4:12:=Round:C94(100*[PON_ELEM_INSP:179]ELEM_QTYSTATE4:16/[PON_ELEM_INSP:179]ELEM_QUANTITY:7; PON_RoundP_L)
		[PON_ELEM_INSP:179]ELEM_PCTSTATE1:9:=100-[PON_ELEM_INSP:179]ELEM_PCTSTATE2:10-[PON_ELEM_INSP:179]ELEM_PCTSTATE3:11-[PON_ELEM_INSP:179]ELEM_PCTSTATE4:12
		
		LogNewRecordChanges(->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; "PON_ELEM_INSP"; $changeStack_L; ->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; ->[PON_ELEM_INSP:179]ELEM_PARENTID:27)
		If ([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28>0)
			LogLink(->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179]ELEMID:22)
		End if 
		If ([PON_ELEM_INSP:179]ELEM_PARENTID:27>0)
			LogLink(->[PON_ELEM_INSP:179]ELEM_PARENTID:27; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179]ELEMID:22)
		End if 
		SAVE RECORD:C53([PON_ELEM_INSP:179])
		
	End for 
	
	UNLOAD RECORD:C212([PON_ELEM_INSP:179])
	//quit progress
	Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
	
End if   //end of inspid#0

//End PON_CreateElements