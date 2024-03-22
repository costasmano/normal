//%attributes = {"invisible":true}
// Method: NTI_TINCopyElements
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 05/20/16, 17:24:02
	// ----------------------------------------------------
	// First Release
	Mods_2016_NTE
End if 

//
If (Records in selection:C76([NTI_ELEM_TIN_INSP:185])>0)
	ALERT:C41("NTEs already exist for this inspection! Cannot copy elements from another inspection!")
Else 
	C_LONGINT:C283($vCurrCombID; $vCurrBMSInspID)
	//Save current inspection  
	$vCurrBMSInspID:=[TIN_Inspections:184]InspectionID:2
	
	C_BOOLEAN:C305($AutoOne_b; $AutoMany_b)
	GET AUTOMATIC RELATIONS:C899($AutoOne_b; $AutoMany_b)
	C_LONGINT:C283($NumCUs_L)
	ARRAY DATE:C224(aSelBMSInsp; 0)
	ARRAY LONGINT:C221(v_27_002_aL; 0)  //InspID
	ARRAY TEXT:C222(v_27_006_atxt; 0)  //Insp Type
	v_1_003_txt:=[TIN_Inspections:184]NTI_i1_S:1
	Begin SQL
		select [TIN_Inspections].[Insp Date],  [TIN_Inspections].InspectionID, [Inspection Type].[Description] from
		[TIN_Inspections], [Inspection Type]
		where [TIN_Inspections].[NTI_i1_S] = :v_1_003_txt
		and [TIN_Inspections].InspectionID <> :$vCurrBMSInspID
		and [Inspection Type].[Code] = [TIN_Inspections].[InspType]
		into :aSelBMSInsp , :v_27_002_aL , :v_27_006_atxt ;
	End SQL
	
	C_LONGINT:C283($loop_L)
	For ($loop_L; Size of array:C274(aSelBMSInsp); 1; -1)
		v_27_002_L:=v_27_002_aL{$loop_L}
		Begin SQL
			select count(*) from [NTI_ELEM_TIN_INSP]
			where 
			[NTI_ELEM_TIN_INSP].InspectionID = :v_27_002_L
			into :v_27_002_L
		End SQL
		
		Case of 
			: (v_27_002_L=0)
				DELETE FROM ARRAY:C228(v_27_002_aL; $loop_L; 1)
				DELETE FROM ARRAY:C228(aSelBMSInsp; $loop_L; 1)
				DELETE FROM ARRAY:C228(v_27_006_atxt; $loop_L; 1)
				
			: (v_27_002_aL{$loop_L}=[TIN_Inspections:184]InspectionID:2)
				DELETE FROM ARRAY:C228(v_27_002_aL; $loop_L; 1)
				DELETE FROM ARRAY:C228(aSelBMSInsp; $loop_L; 1)
				DELETE FROM ARRAY:C228(v_27_006_atxt; $loop_L; 1)
				
		End case 
		
	End for 
	
	If (Size of array:C274(v_27_002_aL)<1)
		ALERT:C41("No other NTI inspections to copy NTIs from for current BIN <"+[Bridge MHD NBIS:1]BIN:3+"> !")
	Else 
		SORT ARRAY:C229(aSelBMSInsp; v_27_002_aL; v_27_006_atxt; <)
		C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
		C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
		C_TEXT:C284($Title_txt)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(v_27_006_atxt))
			v_27_006_atxt{$loop_L}:=String:C10(aSelBMSInsp{$loop_L})+" "+v_27_006_atxt{$loop_L}
		End for 
		C_LONGINT:C283($NewSelect_L)
		
		If (False:C215)
			
			FORM GET PROPERTIES:C674([Dialogs:21]; "SelectPontisInsp"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
			$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
			aSelBMSInsp:=0
			DIALOG:C40([Dialogs:21]; "SelectPontisInsp")
			CLOSE WINDOW:C154($Win_l)
			$NewSelect_L:=aSelBMSInsp
			
		Else 
			$NewSelect_L:=G_PickFromList(->v_27_006_atxt; "Select Inspection to Copy")
		End if 
		
		If ((OK=1) & ($NewSelect_L>0))
			
			SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
			
			SET CURSOR:C469(4)
			C_LONGINT:C283($NoCUs; $i; $j)
			vInspToCopy:=v_27_002_aL{$NewSelect_L}  // save the id to copy
			QUERY:C277([NTI_ELEM_TIN_INSP:185]; [NTI_ELEM_TIN_INSP:185]InspectionID:1=vInspToCopy)
			$NoCUs:=Records in selection:C76([NTI_ELEM_TIN_INSP:185])
			If ($NoCUs>0)
				ARRAY LONGINT:C221($oldElemIDs_aL; 0)
				SELECTION TO ARRAY:C260([NTI_ELEM_TIN_INSP:185]ELEMID:2; $oldElemIDs_aL)
				ARRAY LONGINT:C221($NewElemIDS_aL; Size of array:C274($oldElemIDs_aL))
				C_LONGINT:C283($loop_L; $newID_L)
				SHORT_MESSAGE("Preparing...")
				
				For ($loop_L; 1; Size of array:C274($NewElemIDS_aL))
					Inc_Sequence("NTI_ELEM_BIN_INSP"; ->$newID_L)
					$NewElemIDS_aL{$loop_L}:=$newID_L
				End for 
				
				InitChangeStack(PON_ChangeStackLvl_L)
				
				FIRST RECORD:C50([NTI_ELEM_TIN_INSP:185])
				COPY NAMED SELECTION:C331([NTI_ELEM_TIN_INSP:185]; "Cond Units")
				MESSAGE:C88(<>sCR+"Copying "+String:C10($NoCUs)+" NTIs..")
				For ($i; 1; $NoCUs)
					MESSAGE:C88(" .."+String:C10($i)+" of "+String:C10($NoCUs))
					DUPLICATE RECORD:C225([NTI_ELEM_TIN_INSP:185])
					$loop_L:=Find in array:C230($oldElemIDs_aL; [NTI_ELEM_TIN_INSP:185]ELEMID:2)
					[NTI_ELEM_TIN_INSP:185]ELEMID:2:=$NewElemIDS_aL{$loop_L}
					[NTI_ELEM_TIN_INSP:185]InspectionID:1:=$vCurrBMSInspID
					[NTI_ELEM_TIN_INSP:185]ELEM_MODDATETIME:10:=""
					[NTI_ELEM_TIN_INSP:185]ELEM_MODUSER:11:=""
					[NTI_ELEM_TIN_INSP:185]ELEM_CREATEDATETIME:4:=ISODateTime(Current date:C33(*); Current time:C178(*))
					[NTI_ELEM_TIN_INSP:185]ELEM_CREATEUSER:5:=Current user:C182
					[NTI_ELEM_TIN_INSP:185]NTI_ELEM_TIN_INSP_UUIDKey_s:23:=Generate UUID:C1066
					
					If ([NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8>0)
						$loop_L:=Find in array:C230($oldElemIDs_aL; [NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8)
						[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8:=$NewElemIDS_aL{$loop_L}
					End if 
					If ([NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_ID:26>0)
						$loop_L:=Find in array:C230($oldElemIDs_aL; [NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_ID:26)
						[NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_ID:26:=$NewElemIDS_aL{$loop_L}
					End if 
					
					LogNewRecordChanges(->[TIN_Inspections:184]InspectionID:2; ->[NTI_ELEM_TIN_INSP:185]InspectionID:1; ->[NTI_ELEM_TIN_INSP:185]ELEMID:2; 2; \
						"NTI_ELEM_BIN_INSP"; PON_ChangeStackLvl_L; ->[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8; ->[NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_ID:26)
					If ([NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8>0)
						LogLink(->[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8; ->[TIN_Inspections:184]InspectionID:2; ->[NTI_ELEM_TIN_INSP:185]InspectionID:1; ->[NTI_ELEM_TIN_INSP:185]ELEMID:2; 2; ->[NTI_ELEM_TIN_INSP:185]ELEMID:2)
					End if 
					If ([NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_ID:26>0)
						LogLink(->[NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_ID:26; ->[TIN_Inspections:184]InspectionID:2; ->[NTI_ELEM_TIN_INSP:185]InspectionID:1; ->[NTI_ELEM_TIN_INSP:185]ELEMID:2; 2; ->[NTI_ELEM_TIN_INSP:185]ELEMID:2)
					End if 
					SAVE RECORD:C53([NTI_ELEM_TIN_INSP:185])
					USE NAMED SELECTION:C332("Cond Units")
					NEXT RECORD:C51([NTI_ELEM_TIN_INSP:185])
					COPY NAMED SELECTION:C331([NTI_ELEM_TIN_INSP:185]; "Cond Units")
				End for 
				CLEAR NAMED SELECTION:C333("Cond Units")
				CLOSE WINDOW:C154
			Else 
				ALERT:C41("There were no Elements found to be copied!!!")
			End if 
			
			SET CURSOR:C469(0)
		End if   // if OK to copy
		
	End if 
	
	SET AUTOMATIC RELATIONS:C310($AutoOne_b; $AutoMany_b)
	
	NTI_ListElements
	
End if 

//End NTI_CopyElements