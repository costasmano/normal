//%attributes = {"invisible":true}
//Method: PON_CopyElements
//Description
//  ` Copy NBEs from a prvious inspecion
// Parameters
// $1 : $UpdateHI_b (Optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/23/15, 16:54:53
	// ----------------------------------------------------
	//Created : 
	Mods_2015_03
	// Modified by: Costas Manousakis-(Designer)-(1/14/19 16:21:37)
	Mods_2019_01
	//  `trying method of combining previous elements
	// Modified by: Costas Manousakis-(Designer)-(6/12/19 15:22:33)
	Mods_2019_06
	//  `added option to skip HI calculations at the end. this used when duplicating inspectons
	
	C_BOOLEAN:C305(PON_CopyElements; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(4/21/21 13:05:32)
	Mods_2021_04
	//  `force ob get to return correct type
End if 
//

If (Records in selection:C76([PON_ELEM_INSP:179])>0)
	ALERT:C41("NBEs already exist for this inspection! Cannot copy elements from another inspection!")
Else 
	C_BOOLEAN:C305($UpdateHI_b)
	$UpdateHI_b:=True:C214  //default is to do the update of HI
	If (Count parameters:C259>0)
		C_BOOLEAN:C305($1)
		$UpdateHI_b:=$1
	End if 
	
	C_LONGINT:C283($vCurrCombID; $vCurrBMSInspID)
	//Save current inspection  
	$vCurrBMSInspID:=[Inspections:27]InspID:2
	C_BOOLEAN:C305($AutoOne_b; $AutoMany_b)
	GET AUTOMATIC RELATIONS:C899($AutoOne_b; $AutoMany_b)
	C_BOOLEAN:C305($OldWay_b)
	$OldWay_b:=False:C215
	
	If ($OldWay_b)
		C_LONGINT:C283($NumCUs_L)
		ARRAY DATE:C224(aSelBMSInsp; 0)
		ARRAY LONGINT:C221(v_27_002_aL; 0)  //InspID
		ARRAY TEXT:C222(v_27_006_atxt; 0)  //Insp Type
		v_1_003_txt:=[Bridge MHD NBIS:1]BIN:3
		Begin SQL
			select [Inspections].[Insp Date],  [Inspections].inspid, [Inspection Type].[Description] from
			[Inspections], [Inspection Type]
			where [Inspections].bin = :v_1_003_txt
			and [Inspection Type].[Code] = [Inspections].[Insp Type]
			into :aSelBMSInsp , :v_27_002_aL , :v_27_006_atxt ;
		End SQL
		C_LONGINT:C283($loop_L)
		For ($loop_L; Size of array:C274(aSelBMSInsp); 1; -1)
			v_27_002_L:=v_27_002_aL{$loop_L}
			Begin SQL
				select count(*) from [PON_ELEM_INSP]
				where 
				[PON_ELEM_INSP].INSPID = :v_27_002_L
				into :v_27_002_L
			End SQL
			
			Case of 
				: (v_27_002_L=0)
					DELETE FROM ARRAY:C228(v_27_002_aL; $loop_L; 1)
					DELETE FROM ARRAY:C228(aSelBMSInsp; $loop_L; 1)
					DELETE FROM ARRAY:C228(v_27_006_atxt; $loop_L; 1)
					
				: (v_27_002_aL{$loop_L}=[Inspections:27]InspID:2)
					DELETE FROM ARRAY:C228(v_27_002_aL; $loop_L; 1)
					DELETE FROM ARRAY:C228(aSelBMSInsp; $loop_L; 1)
					DELETE FROM ARRAY:C228(v_27_006_atxt; $loop_L; 1)
					
			End case 
			
		End for 
		
		If (Size of array:C274(v_27_002_aL)<1)
			ALERT:C41("No other BrM NBE inspections to copy NBEs from for current BIN <"+[Bridge MHD NBIS:1]BIN:3+"> !")
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
				
				If ([Combined Inspections:90]BMSInspID:3<=0)
					//first add a bms inspection record - is needed to store HI results
					G_AddPontisToCombined
				End if 
				
				SET CURSOR:C469(4)
				C_LONGINT:C283($NoCUs; $i; $j)
				vInspToCopy:=v_27_002_aL{$NewSelect_L}  // save the id to copy
				QUERY:C277([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]INSPID:21=vInspToCopy)
				$NoCUs:=Records in selection:C76([PON_ELEM_INSP:179])
				If ($NoCUs>0)
					ARRAY LONGINT:C221($oldElemIDs_aL; 0)
					SELECTION TO ARRAY:C260([PON_ELEM_INSP:179]ELEMID:22; $oldElemIDs_aL)
					ARRAY LONGINT:C221($NewElemIDS_aL; Size of array:C274($oldElemIDs_aL))
					C_LONGINT:C283($loop_L; $newID_L)
					SHORT_MESSAGE("Preparing...")
					
					For ($loop_L; 1; Size of array:C274($NewElemIDS_aL))
						Inc_Sequence("PON_ELEM_INSP"; ->$newID_L)
						$NewElemIDS_aL{$loop_L}:=$newID_L
					End for 
					
					InitChangeStack(PON_ChangeStackLvl_L)
					
					FIRST RECORD:C50([PON_ELEM_INSP:179])
					COPY NAMED SELECTION:C331([PON_ELEM_INSP:179]; "Cond Units")
					MESSAGE:C88(<>sCR+"Copying "+String:C10($NoCUs)+" NBEs..")
					For ($i; 1; $NoCUs)
						MESSAGE:C88(" .."+String:C10($i)+" of "+String:C10($NoCUs))
						DUPLICATE RECORD:C225([PON_ELEM_INSP:179])
						$loop_L:=Find in array:C230($oldElemIDs_aL; [PON_ELEM_INSP:179]ELEMID:22)
						[PON_ELEM_INSP:179]ELEMID:22:=$NewElemIDS_aL{$loop_L}
						[PON_ELEM_INSP:179]INSPID:21:=$vCurrBMSInspID
						[PON_ELEM_INSP:179]ELEM_MODTIME:18:=""
						[PON_ELEM_INSP:179]ELEM_MODUSERKEY:25:=""
						[PON_ELEM_INSP:179]ELEM_CREATEDATETIME:17:=ISODateTime(Current date:C33(*); Current time:C178(*))
						[PON_ELEM_INSP:179]ELEM_CREATEUSERKEY:24:=Current user:C182
						
						If ([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28>0)
							$loop_L:=Find in array:C230($oldElemIDs_aL; [PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28)
							[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28:=$NewElemIDS_aL{$loop_L}
						End if 
						If ([PON_ELEM_INSP:179]ELEM_PARENTID:27>0)
							$loop_L:=Find in array:C230($oldElemIDs_aL; [PON_ELEM_INSP:179]ELEM_PARENTID:27)
							[PON_ELEM_INSP:179]ELEM_PARENTID:27:=$NewElemIDS_aL{$loop_L}
						End if 
						LogNewRecordChanges(->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; "PON_ELEM_INSP"; PON_ChangeStackLvl_L; ->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; ->[PON_ELEM_INSP:179]ELEM_PARENTID:27)
						If ([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28>0)
							LogLink(->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179]ELEMID:22)
						End if 
						If ([PON_ELEM_INSP:179]ELEM_PARENTID:27>0)
							LogLink(->[PON_ELEM_INSP:179]ELEM_PARENTID:27; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179]ELEMID:22)
						End if 
						SAVE RECORD:C53([PON_ELEM_INSP:179])
						USE NAMED SELECTION:C332("Cond Units")
						NEXT RECORD:C51([PON_ELEM_INSP:179])
						COPY NAMED SELECTION:C331([PON_ELEM_INSP:179]; "Cond Units")
					End for 
					CLEAR NAMED SELECTION:C333("Cond Units")
					CLOSE WINDOW:C154
				Else 
					ALERT:C41("There were no Elements found to be copied!!!")
				End if 
				
				SET CURSOR:C469(0)
			End if   // if OK to copy
			
		End if 
		
	Else   //New way combine elements
		
		C_OBJECT:C1216($progress_o; $combination_o)
		$progress_o:=ProgressNew("Copying NBEs"; 2; False:C215; ""; 0)
		//*** Need To Save current selection of [inspection] and current [inspection] record
		Progress SET MESSAGE(OB Get:C1224($progress_o; "progress"; Is longint:K8:6); "Combining NBEs from previous inspections")
		$combination_o:=PON_CombineRecent(True:C214; True:C214; [Inspections:27]Insp Date:78)
		
		If (OB Get:C1224($combination_o; "error"; Is text:K8:3)="")
			Progress SET MESSAGE(OB Get:C1224($progress_o; "progress"; Is longint:K8:6); "Creating new NBEs")
			PON_CreateElements($combination_o)
			Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
			ALERT:C41("Copied Elements from Inspection(s) :"+OB Get:C1224($combination_o; "usedInspInfo"; Is text:K8:3))
		Else 
			Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
			ut_BigAlert("Encountered errors while compiling elements from previous inspection reports : \n"+\
				OB Get:C1224($combination_o; "error"; Is text:K8:3); "Error Compiling NBEs")
		End if 
		
	End if 
	
	SET AUTOMATIC RELATIONS:C310($AutoOne_b; $AutoMany_b)
	
	If ($UpdateHI_b)
		//restore current selections
		RememberCombined
		
		INSP_HICalcControl("INIT")
		INSP_HICalcControl("CALC")
		INSP_HICalcControl("TODB")
		
		
	End if 
	
	PON_ListElements
	
End if 
//End PON_CopyElements