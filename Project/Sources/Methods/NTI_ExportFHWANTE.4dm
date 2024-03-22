//%attributes = {"invisible":true}
//Method: NTI_ExportFHWANTE
//Description
//Export NTE Elements in XML format to submit to FHWA
//Works with current list of [NTI_TunnelInfo] records
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/04/16, 14:28:35
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(3/23/17 13:16:23)
	Mods_2017_03
	//  `changes for newly supplied xsd and fixes in the code. use process v_182_@ vars for the [NTI_ELEM_DEFS] arrays
	// Modified by: Costas Manousakis-(Designer)-(2023-04-07 16:37:20)
	Mods_2023_04
	//  `replaced old progress with new 
End if 
//
//
ARRAY LONGINT:C221(v_182_004_aL; 0)
ARRAY LONGINT:C221(v_182_013_aL; 0)
ARRAY TEXT:C222(v_182_016_atxt; 0)
READ ONLY:C145([NTI_ELEM_DEFS:182])
READ ONLY:C145([NTI_ELEM_TIN_INSP:185])
READ ONLY:C145([TIN_Inspections:184])
READ ONLY:C145([NTI_TunnelInfo:181])
NTI_INIT
ALL RECORDS:C47([NTI_ELEM_DEFS:182])

SELECTION TO ARRAY:C260([NTI_ELEM_DEFS:182]ELEM_KEY:4; v_182_004_aL; [NTI_ELEM_DEFS:182]REPORTED:16; v_182_016_atxt; [NTI_ELEM_DEFS:182]ELEM_SUBSET_KEY:13; v_182_013_aL)

ARRAY TEXT:C222($AllBINs_atxt; 0)
ARRAY LONGINT:C221($InspIDs_aL; 0)

If (False:C215)
	//test to get a set of records
	
End if 

C_TEXT:C284($FHWAEDTemplate_txt; $Process_txt; $crLF)
C_BLOB:C604($Result_blb)
$crLF:=Char:C90(13)+Char:C90(10)

If (Application version:C493<="1199")
	//v11 code
	$FHWAEDTemplate_txt:="<!--#4DLOOP PON_SUMEN_AL--><FHWAED>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<I1><!--#4DVAR FHWAITEM8_txt--></I1>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<I3>25</I3>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<EN><!--#4DVAR PON_SUMEN_AL{PON_SUMEN_AL}--></EN>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<!--#4DIF (PON_SUMEPN_AL{PON_SUMEN_AL} >0)-->"
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<EPN><!--#4DVAR PON_SUMEPN_AL{PON_SUMEN_AL}--></EPN>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<!--#4DENDIF-->"
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<TOTALQTY><!--#4DVAR PON_SUMTotQ_Ar{PON_SUMEN_AL}--></TOTALQTY>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<CS1><!--#4DVAR PON_SUMCS1_Ar{PON_SUMEN_AL}--></CS1>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<CS2><!--#4DVAR PON_SUMCS2_Ar{PON_SUMEN_AL}--></CS2>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<CS3><!--#4DVAR PON_SUMCS3_Ar{PON_SUMEN_AL}--></CS3>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<CS4><!--#4DVAR PON_SUMCS4_Ar{PON_SUMEN_AL}--></CS4>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"</FHWAED>"+$crLF+"<!--#4DENDLOOP-->"
Else 
	
	// v15 Code
	$FHWAEDTemplate_txt:="<!--#4DLOOP PON_SUMEN_AL--><FHWAED>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<I1><!--#4DTEXT FHWAITEM8_txt--></I1>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<I3>25</I3>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<EN><!--#4DTEXT PON_SUMEN_AL{PON_SUMEN_AL}--></EN>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<!--#4DIF (PON_SUMEPN_AL{PON_SUMEN_AL} >0)-->"
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<EPN><!--#4DTEXT PON_SUMEPN_AL{PON_SUMEN_AL}--></EPN>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<!--#4DENDIF-->"
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<TOTALQTY><!--#4DTEXT PON_SUMTotQ_Ar{PON_SUMEN_AL}--></TOTALQTY>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<CS1><!--#4DTEXT PON_SUMCS1_Ar{PON_SUMEN_AL}--></CS1>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<CS2><!--#4DTEXT PON_SUMCS2_Ar{PON_SUMEN_AL}--></CS2>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<CS3><!--#4DTEXT PON_SUMCS3_Ar{PON_SUMEN_AL}--></CS3>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<CS4><!--#4DTEXT PON_SUMCS4_Ar{PON_SUMEN_AL}--></CS4>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"</FHWAED>"+$crLF+"<!--#4DENDLOOP-->"
	
End if 

$Process_txt:="<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+Char:C90(13)+Char:C90(10)+"<FHWAElements>"

TEXT TO BLOB:C554($Process_txt; $Result_blb; Mac text without length:K22:10; *)  //start the xml 
C_LONGINT:C283($progressID_L)
C_BOOLEAN:C305($ExportComplete_b)
//v15 progress bar code
//$progressID_L:=Progress New
//Progress SET BUTTON ENABLED($progressID_L;True)
//Progress SET TITLE($progressID_L;"Export NBE to FHWA for "+String(Size of array($AllBINs_atxt))+" BINs")


CUT NAMED SELECTION:C334([NTI_TunnelInfo:181]; "PRENBEXPORTBINS")
SELECTION TO ARRAY:C260([NTI_TunnelInfo:181]NTI_i1_s:6; $AllBINs_atxt)

C_BOOLEAN:C305($GotBINs_b)
$GotBINs_b:=(Size of array:C274($AllBINs_atxt)>0)
If (Not:C34($GotBINs_b) & (User in group:C338(Current user:C182; "Design Access Group")))
	CONFIRM:C162("No TIN Records selected! Do you want to do a custom search?"; "Search"; "Cancel")
	If (OK=1)
		C_BOOLEAN:C305($SearchDone_b)
		$SearchDone_b:=False:C215
		
		Repeat 
			QUERY:C277([NTI_TunnelInfo:181])
			If (OK=1)
				SELECTION TO ARRAY:C260([NTI_TunnelInfo:181]NTI_i1_s:6; $AllBINs_atxt)
				If (Size of array:C274($AllBINs_atxt)>0)
					CONFIRM:C162("Found "+String:C10(Size of array:C274($AllBINs_atxt))+" TIN records. Continue with export?"; "Continue"; "Try again")
					If (OK=1)
						$GotBINs_b:=(Size of array:C274($AllBINs_atxt)>0)
						$SearchDone_b:=True:C214
					End if 
					
				Else 
					CONFIRM:C162("No NBI records found in selection! Try again?"; "Yes"; "No")
					If (OK=1)
						
					Else 
						$SearchDone_b:=True:C214
					End if 
					
				End if 
				
			Else 
				CONFIRM:C162("Try Search again?"; "Yes"; "No")
				If (OK=1)
				Else 
					$SearchDone_b:=True:C214
				End if 
				
			End if 
			
		Until ($SearchDone_b)
		
	End if 
	
End if 

If ($GotBINs_b)
	//check options for selecting inspection reports - only for designer
	If (User in group:C338(Current user:C182; "Design Access Group"))
		C_TEXT:C284($InspSelector_txt)
		$InspSelector_txt:="APPROVED"
		$InspSelector_txt:=Request:C163("InspStatus ; APPROVED/COMPLETE/ANY"; "APPROVED"; "OK"; "Use Approved")
		If (OK=1)
			
			Case of 
				: ($InspSelector_txt="APP@")
					$InspSelector_txt:="APPROVED"
				: ($InspSelector_txt="COM@")
					$InspSelector_txt:="COMPLETE"
				: ($InspSelector_txt="ANY@")
					$InspSelector_txt:="ANY"
				Else 
					ALERT:C41("Un recognized response <"+$InspSelector_txt+"> ! Using APPROVED")
					$InspSelector_txt:="APPROVED"
			End case 
			
		End if 
		
	End if 
	//start the bar
	C_OBJECT:C1216($progress_o)
	$progress_o:=ProgressNew("NTE to FHWA export"; Size of array:C274($AllBINs_atxt); True:C214; " TIN record"; 3)
	
	//update progress
	UpdateProgressNew($progress_o; 0)
	
	$ExportComplete_b:=True:C214
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($AllBINs_atxt))
		
		If (Not:C34(Progress Stopped(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))))
			
			UpdateProgressNew($progress_o; $loop_L)
			
			ARRAY LONGINT:C221($InspIDs_aL; 0)  //clear inspids_AL 
			QUERY:C277([NTI_TunnelInfo:181]; [NTI_TunnelInfo:181]NTI_i1_s:6=$AllBINs_atxt{$loop_L})
			
			C_TEXT:C284(FHWAITEM8_txt)
			ARRAY LONGINT:C221(PON_SUMEn_AL; 0)
			ARRAY LONGINT:C221(PON_SUMEPN_AL; 0)
			ARRAY TEXT:C222($NTI_SUMParentAndKEY_atxt; 0)
			ARRAY REAL:C219(PON_SUMTotQ_Ar; 0)
			ARRAY REAL:C219(PON_SUMCS1_Ar; 0)
			ARRAY REAL:C219(PON_SUMCS2_Ar; 0)
			ARRAY REAL:C219(PON_SUMCS3_Ar; 0)
			ARRAY REAL:C219(PON_SUMCS4_Ar; 0)
			
			QUERY:C277([TIN_Inspections:184]; [TIN_Inspections:184]NTI_i1_S:1=[NTI_TunnelInfo:181]NTI_i1_s:6)
			Case of 
				: ($InspSelector_txt="APP@")
					QUERY SELECTION:C341([TIN_Inspections:184]; [TIN_Inspections:184]InspReview:5=BMS Approved)
				: ($InspSelector_txt="COM@")
					QUERY SELECTION:C341([TIN_Inspections:184]; [TIN_Inspections:184]Complete:4=True:C214)
			End case 
			QUERY SELECTION:C341([TIN_Inspections:184]; [NTI_ELEM_TIN_INSP:185]InspectionID:1>0)
			ORDER BY:C49([TIN_Inspections:184]; [TIN_Inspections:184]InspDate:3; <)
			SELECTION TO ARRAY:C260([TIN_Inspections:184]InspectionID:2; $InspIDs_aL)
			
			If (Size of array:C274($InspIDs_aL)>0)
				//get the latest inspection - should be the latest approved inspection in the final code
				QUERY:C277([NTI_ELEM_TIN_INSP:185]; [NTI_ELEM_TIN_INSP:185]InspectionID:1=$InspIDs_aL{1})
				
				ARRAY LONGINT:C221($En_AL; 0)
				ARRAY LONGINT:C221($EPN_AL; 0)
				ARRAY TEXT:C222($ParentAndKEY_atxt; 0)
				ARRAY REAL:C219($TotQ_Ar; 0)
				ARRAY REAL:C219($CS1_Ar; 0)
				ARRAY REAL:C219($CS2_Ar; 0)
				ARRAY REAL:C219($CS3_Ar; 0)
				ARRAY REAL:C219($CS4_Ar; 0)
				
				FHWAITEM8_txt:=[TIN_Inspections:184]NTI_i1_S:1
				
				//sort them in right order
				ORDER BY FORMULA:C300([NTI_ELEM_TIN_INSP:185]; NTI_ElemSort_TIN)
				
				SELECTION TO ARRAY:C260([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3; $En_AL; [NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7; $EPN_AL; [NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; $TotQ_Ar; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; $CS1_Ar)
				SELECTION TO ARRAY:C260([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18; $CS2_Ar; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19; $CS3_Ar; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20; $CS4_Ar)
				
				ARRAY TEXT:C222($ParentAndKEY_atxt; Size of array:C274($En_AL))
				
				ARRAY LONGINT:C221(PON_SUMEn_AL; Size of array:C274($En_AL))
				ARRAY LONGINT:C221(PON_SUMEPN_AL; Size of array:C274($En_AL))
				ARRAY TEXT:C222($NTI_SUMParentAndKEY_atxt; Size of array:C274($En_AL))
				ARRAY REAL:C219(PON_SUMTotQ_Ar; Size of array:C274($En_AL))
				ARRAY REAL:C219(PON_SUMCS1_Ar; Size of array:C274($En_AL))
				ARRAY REAL:C219(PON_SUMCS2_Ar; Size of array:C274($En_AL))
				ARRAY REAL:C219(PON_SUMCS3_Ar; Size of array:C274($En_AL))
				ARRAY REAL:C219(PON_SUMCS4_Ar; Size of array:C274($En_AL))
				
				//calc combination of Key and parentkey  
				C_LONGINT:C283($ElemLoop_L)
				For ($ElemLoop_L; 1; Size of array:C274($En_AL))
					$ParentAndKEY_atxt{$ElemLoop_L}:=String:C10($EPN_AL{$ElemLoop_L}; "00000000")+String:C10($EN_AL{$ElemLoop_L}; "00000000")
				End for 
				
				//loop to sum the quantities
				C_LONGINT:C283($Elemindx_L; $pondefIndx_L; $CurrElemKey_L; $CurrParKey_L)
				C_TEXT:C284($myParAndKey_txt)
				C_BOOLEAN:C305($report_b)
				For ($ElemLoop_L; 1; Size of array:C274($En_AL))
					$report_b:=False:C215
					$pondefIndx_L:=Find in array:C230(v_182_004_aL; $En_AL{$ElemLoop_L})
					If ($pondefIndx_L>0)
						$report_b:=(v_182_016_atxt{$pondefIndx_L}="Y")
						$CurrElemKey_L:=$EN_AL{$ElemLoop_L}
						If (v_182_013_aL{$pondefIndx_L}>0)
							$CurrElemKey_L:=v_182_013_aL{$pondefIndx_L}
						End if 
						
					End if 
					If ($report_b)
						$myParAndKey_txt:=""
						$CurrParKey_L:=$EPN_AL{$ElemLoop_L}
						$pondefIndx_L:=Find in array:C230(v_182_004_aL; $CurrParKey_L)
						If ($pondefIndx_L>0)
							If (v_182_013_aL{$pondefIndx_L}>0)
								$CurrParKey_L:=v_182_013_aL{$pondefIndx_L}
							End if 
							
						End if 
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
				
				PROCESS 4D TAGS:C816($FHWAEDTemplate_txt; $Process_txt)
				TEXT TO BLOB:C554($Process_txt; $Result_blb; Mac text without length:K22:10; *)
			End if 
			UNLOAD RECORD:C212([NTI_TunnelInfo:181])
		Else 
			$loop_L:=Size of array:C274($AllBINs_atxt)+1  //exit loop
			$ExportComplete_b:=False:C215
		End if 
		
	End for 
	//Progress QUIT($progressID_L)
	//stop the progress bar
	//quit progress
	Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
	
	If (Not:C34($ExportComplete_b))
		CONFIRM:C162("User Aborted processing! Save results to file?"; "Save"; "Don't Save")
		$ExportComplete_b:=(OK=1)
	End if 
	If ($ExportComplete_b)
		TEXT TO BLOB:C554("</FHWAElements>"; $Result_blb; Mac text without length:K22:10; *)  //close the xml 
		C_TIME:C306($ExportFile_t)
		C_TEXT:C284($ExportFile_txt)
		$ExportFile_t:=Create document:C266(""; ".xml")
		If (OK=1)
			$ExportFile_txt:=Document
			CLOSE DOCUMENT:C267($ExportFile_t)
			BLOB TO DOCUMENT:C526($ExportFile_txt; $Result_blb)
			SHOW ON DISK:C922($ExportFile_txt)
			
		End if 
		
	End if 
	
Else 
	ALERT:C41("There are no TIN Records to do the export!")
End if 

SET BLOB SIZE:C606($Result_blb; 0)

//reset the TIN list
USE NAMED SELECTION:C332("PRENBEXPORTBINS")

//End NTI_ExportFHWANTE