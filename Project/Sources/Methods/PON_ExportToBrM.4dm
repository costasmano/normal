//%attributes = {"invisible":true}
//Method: PON_ExportToBrM
//Description
// Create export file of NBEs for import to BrM. 
// Method should be run in a separate process
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/24/16, 15:32:34
	// ----------------------------------------------------
	//Created : 
	Mods_2016_10
	
	//Added exclusions for inspection types and bridge categories
	//added check for primary key contraints violations : elemkey+envkey+parentkey+grandparentkey must be unique
	
	// Modified by: manousakisc (11/2/2016)
	//Added exclusions for TRO
	
	// Modified by: manousakisc (11/2/2016)
	//added message during export
	
	
	// Modified by: manousakisc (11/9/2016)
	Mods_2016_11
	//  `more changes to catch errors in NBEs
End if 
//
//retrieve inpskey info from Pontis/BrM

READ ONLY:C145(*)

SQL LOGIN:C817(""; "manousakisc"; "mypw"; *)
ARRAY TEXT:C222($Bridgekey; 0)
ARRAY TEXT:C222($BridgeID; 0)
ARRAY TEXT:C222($BridgeStrNum; 0)
ARRAY TEXT:C222($BridgeGroup; 0)
ARRAY TEXT:C222($InspKey; 0)
ARRAY TEXT:C222($InspDateText; 0)
ARRAY DATE:C224($InspDate_ad; 0)
ARRAY TEXT:C222($INSPNAME; 0)
ARRAY LONGINT:C221($NBINSPDONE; 0)
ARRAY LONGINT:C221($ELINSPDONE; 0)
ARRAY LONGINT:C221($UWINSPDONE; 0)
ARRAY LONGINT:C221($FCINSPDONE; 0)
ARRAY LONGINT:C221($OSINSPDONE; 0)
ARRAY LONGINT:C221($PontisCUCount; 0)

//, cast(INSPEVNT.INSPDATE as text)
C_LONGINT:C283($startTick_L; $EndTick_L)
$startTick_L:=Tickcount:C458

Begin SQL
	SELECT BRIDGE.BRKEY
	, BRIDGE.BRIDGE_ID
	, BRIDGE.STRUCT_NUM
	, BRIDGE.BridgeGroup
	, INSPEVNT.InspKey
	, INSPEVNT.INSPDATE
	, (select COUNT(*) from
	[ELEMINSP]
	where [ELEMINSP].InspKey = [INSPEVNT].InspKey
	and [ELEMINSP].BRKEY = [INSPEVNT].BRKEY ) as ThisCount
	
	FROM dbo.BRIDGE BRIDGE, dbo.INSPEVNT INSPEVNT
	WHERE BRIDGE.BRKEY = INSPEVNT.BRKEY
	into :$Bridgekey
	, :$BridgeID
	, :$BridgeStrNum
	, :$BridgeGroup
	, :$InspKey
	, :$InspDate_ad
	, :$PontisCUCount
	;
End SQL
$EndTick_L:=Tickcount:C458

ARRAY LONGINT:C221($PON_ELemKeys_aL; 0)
Begin SQL
	select [pon_elem_defs].[Elem_key]
	from dbo.[pon_elem_defs]
	into :$PON_ELemKeys_aL ;
End SQL

SQL LOGOUT:C872

ALERT:C41("Retrieved "+String:C10(Size of array:C274($InspKey))+" records in "+String:C10($EndTick_L-$startTick_L)+" ticks! ")

//check for multiple $InspKeys with same date

MULTI SORT ARRAY:C718($BridgeID; >; $InspDate_ad; >; $Bridgekey; $BridgeStrNum; $BridgeGroup; $InspKey)
ARRAY BOOLEAN:C223($BR_InspKey_used_ab; Size of array:C274($BridgeID))
C_LONGINT:C283($loop_L)
C_TEXT:C284($MultKeys_txt)
For ($loop_L; 2; Size of array:C274($InspKey))
	
	If (($BridgeID{$loop_L-1}=$BridgeID{$loop_L}) & ($InspDate_ad{$loop_L-1}=$InspDate_ad{$loop_L}))
		$MultKeys_txt:=$MultKeys_txt+"BIN :"+$BridgeID{$loop_L-1}+" Date :"+String:C10($InspDate_ad{$loop_L-1})+"  PrevKey :"+$InspKey{$Loop_L-1}+"  thisKey :"+$InspKey{$loop_L}
		$MultKeys_txt:=$MultKeys_txt+" PrevCount :"+String:C10($PontisCUCount{$loop_L-1})+" ThisCount :"+String:C10($PontisCUCount{$loop_L})+Char:C90(13)
	End if 
	
End for 

ut_BigAlert($MultKeys_txt)

If ($MultKeys_txt="")
	READ ONLY:C145(*)  //This method should be run as a separate process
	//set exportfile and log file
	C_TEXT:C284($ExportFile_txt; $LogFile_txt)
	C_TIME:C306($ExportFile_t; $LogFile_t)
	$ExportFile_t:=Create document:C266(""; ".txt")
	$ExportFile_txt:=Document
	$LogFile_txt:=$ExportFile_txt+"_log.txt"
	$LogFile_t:=Create document:C266($LogFile_txt; ".txt")
	
	//search for inspections completed or in review/approve process
	SET QUERY DESTINATION:C396(Into set:K19:2; "PONEXPCOMPLINSP")
	QUERY:C277([Inspections:27]; [Inspections:27]InspComplete:168=True:C214)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	SET QUERY DESTINATION:C396(Into set:K19:2; "PONEXPREVIEWINSP")
	QUERY:C277([Inspections:27]; [Inspections:27]InspApproved:167>0; *)
	QUERY:C277([Inspections:27];  | ; [Inspections:27]InspReviewed:12>0)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	UNION:C120("PONEXPCOMPLINSP"; "PONEXPREVIEWINSP"; "PONEXPREVIEWINSP")
	USE SET:C118("PONEXPREVIEWINSP")
	CLEAR SET:C117("PONEXPREVIEWINSP")
	CLEAR SET:C117("PONEXPCOMPLINSP")
	QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6#"DAM"; *)
	QUERY SELECTION:C341([Inspections:27];  & ; [Inspections:27]Insp Type:6#"FRZ"; *)
	QUERY SELECTION:C341([Inspections:27];  & ; [Inspections:27]Insp Type:6#"DV@"; *)
	QUERY SELECTION:C341([Inspections:27];  & ; [Inspections:27]Insp Type:6#"RR@"; *)
	QUERY SELECTION:C341([Inspections:27];  & ; [Inspections:27]Insp Type:6#"OTH"; *)
	QUERY SELECTION:C341([Inspections:27];  & ; [Inspections:27]Insp Type:6#"FCR"; *)
	QUERY SELECTION:C341([Inspections:27];  & ; [Inspections:27]Insp Type:6#"T@"; *)
	QUERY SELECTION:C341([Inspections:27];  & ; [Inspections:27]Insp Type:6#"PED"; *)
	QUERY SELECTION:C341([Inspections:27];  & ; [Inspections:27]Insp Type:6#"CLD"; *)
	QUERY SELECTION:C341([Inspections:27])
	
	QUERY SELECTION:C341([Inspections:27]; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"BKY"; *)
	QUERY SELECTION:C341([Inspections:27];  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"BLD"; *)
	QUERY SELECTION:C341([Inspections:27];  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"BRI"; *)
	QUERY SELECTION:C341([Inspections:27];  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"CLO"; *)
	QUERY SELECTION:C341([Inspections:27];  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"CLP"; *)
	QUERY SELECTION:C341([Inspections:27];  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"CUL"; *)
	QUERY SELECTION:C341([Inspections:27];  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"DES"; *)
	QUERY SELECTION:C341([Inspections:27];  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"PED"; *)
	QUERY SELECTION:C341([Inspections:27];  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"REM"; *)
	QUERY SELECTION:C341([Inspections:27];  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"RRO"; *)
	QUERY SELECTION:C341([Inspections:27];  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"TRO"; *)
	QUERY SELECTION:C341([Inspections:27];  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"UTL"; *)
	QUERY SELECTION:C341([Inspections:27])
	
	QUERY SELECTION:C341([Inspections:27]; [PON_ELEM_INSP:179]INSPID:21>0)
	//added to check export with grandparent - can ce removed
	CONFIRM:C162("Search for inspections with NBEs with grandparents?"; "Use GrandParents"; "ALL Inspections")
	If (OK=1)
		QUERY SELECTION:C341([Inspections:27]; [PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19>0)
	End if 
	
	C_LONGINT:C283($InspRecords_L)
	$InspRecords_L:=Records in selection:C76([Inspections:27])
	
	CONFIRM:C162("Export NBEs for "+String:C10($InspRecords_L)+" inspections or Reduce the selection?"; "Export ALL"; "Reduce Selection")
	If (OK=0)
		C_TEXT:C284($numRecsReduce_txt)
		C_LONGINT:C283($numRecsReduce_L)
		$numRecsReduce_txt:=Request:C163("Enter Number to reduce selection to"; String:C10($InspRecords_L))
		$numRecsReduce_L:=Num:C11($numRecsReduce_txt)
		REDUCE SELECTION:C351([Inspections:27]; $numRecsReduce_L)
	Else 
		
	End if 
	ARRAY TEXT:C222($BMSBIN; 0)
	ARRAY LONGINT:C221($BMSInspID; 0)
	ARRAY DATE:C224($BMSInspDate; 0)
	$InspRecords_L:=Records in selection:C76([Inspections:27])
	
	ALERT:C41("Exporting NBEs for "+String:C10($InspRecords_L)+" inspections")
	
	SELECTION TO ARRAY:C260([Inspections:27]BIN:1; $BMSBIN; [Inspections:27]InspID:2; $BMSInspID; [Inspections:27]Insp Date:78; $BMSInspDate)
	C_LONGINT:C283($loop_L; $BInFound_L)
	C_BOOLEAN:C305($Done_b)
	C_TEXT:C284(v_179_002_txt; v_179_001_txt)
	C_REAL:C285(v_179_007_r; v_179_009_r; v_179_010_r; v_179_011_r; v_179_012_r; v_179_013_r; v_179_014_r; v_179_015_r; v_179_016_r)
	C_TEXT:C284(v_179_001_txt)  //BRKEY
	C_TEXT:C284(v_179_002_txt)  //INSPKEY
	C_TEXT:C284($Template_txt; $Header_txt; $Close_txt)
	$Header_txt:=""
	$Template_txt:=""
	$Close_txt:=""
	C_BOOLEAN:C305($XML_b; $InspDateMatch_b; $EndBINSearch_b)
	If ($XML_b)
		$Header_txt:=$Header_txt+"<?xml version=\"1\" encoding=\"utf-8\"?>"
		$Header_txt:=$Header_txt+"<ELEMENT-DATA version=\"2.0\" xsi:noNamespaceSchemaLocation=\"ElementData - 8.xsd\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">"
		$Header_txt:=$Header_txt+"  <DECLARATION>"
		$Header_txt:=$Header_txt+"   <Source>Export From MADOT BMS <!--#4DVAR PON_ExportDateTime_txt--></Source>"
		$Header_txt:=$Header_txt+"    <Format>I</Format>"
		$Header_txt:=$Header_txt+"    <Description> NBE element inspection set of records</Description>"
		$Header_txt:=$Header_txt+"    <Units>E</Units>"
		$Header_txt:=$Header_txt+"  </DECLARATION>"
		$Header_txt:=$Header_txt+"  <DATA>"
		
		$Template_txt:=""
		
		$Close_txt:=$Close_txt+"  </DATA> </ELEMENT-DATA>"
	Else 
		$Header_txt:=$Header_txt+"BRKEY"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"inspkey"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"elem_key"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"elem_parent_key"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"envkey"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"strunitkey"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"elem_quantity"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"elem_pctstate1"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"elem_pctstate2"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"elem_pctstate3"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"elem_pctstate4"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"elem_qtystate1"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"elem_qtystate2"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"elem_qtystate3"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"elem_qtystate4"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"elem_scale_factor"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"elem_DESC"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"Elem_createdatetime"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"elem_createuserkey"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"elem_modtime"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"elem_moduserkey"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"elem_docrefkey"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"elem_notes"+Char:C90(Tab:K15:37)
		$Header_txt:=$Header_txt+"elem_grandparentkey"+Char:C90(Carriage return:K15:38)
		$Template_txt:=$Template_txt+""
		$Close_txt:=""
	End if 
	SEND PACKET:C103($ExportFile_t; $Header_txt)
	SHORT_MESSAGE("Exporting Inspections                                                                            ")
	SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	For ($loop_L; 1; Size of array:C274($BMSInspID))
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BMSBIN{$loop_L})
		QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=$BMSInspID{$loop_L})
		QUERY:C277([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]INSPID:21=$BMSInspID{$loop_L})
		
		v_179_002_txt:=""
		v_179_001_txt:=""
		$BInFound_L:=0
		Repeat 
			$BInFound_L:=Find in array:C230($BridgeID; $BMSBIN{$loop_L}; $BInFound_L+1)
			
			If ($BInFound_L<1)
				//BIN not found!!
				$Done_b:=True:C214  //done with this NBE
				SEND PACKET:C103($LogFile_t; "INSP ID "+String:C10($BMSInspID{$loop_L})+Char:C90(Tab:K15:37)+String:C10($BMSInspDate{$loop_L})+Char:C90(Tab:K15:37)+""+$BMSBIN{$loop_L}+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]BDEPT:1+Char:C90(Tab:K15:37)+"ERROR !! BIN Not Found"+Char:C90(Carriage return:K15:38))
			Else 
				$InspDateMatch_b:=($BMSInspDate{$loop_L}=$InspDate_ad{$BInFound_L})
				$InspDateMatch_b:=$InspDateMatch_b | ((Month of:C24($BMSInspDate{$loop_L})=Month of:C24($InspDate_ad{$BInFound_L})) & (Year of:C25($BMSInspDate{$loop_L})=Year of:C25($InspDate_ad{$BInFound_L})))
				If ($InspDateMatch_b)
					//Found date`
					$Done_b:=True:C214  //done with this NBE
					//check if this brkey-inspkey has been used 
					
					If ($BR_InspKey_used_ab{$BInFound_L})
						SEND PACKET:C103($LogFile_t; "INSP ID "+String:C10($BMSInspID{$loop_L})+Char:C90(Tab:K15:37)+String:C10($BMSInspDate{$loop_L})+Char:C90(Tab:K15:37)+""+$BMSBIN{$loop_L}+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]BDEPT:1+Char:C90(Tab:K15:37)+"ERROR !! Found Already USED INSPKEY="+$InspKey{$BInFound_L}+"  BRKEY="+$Bridgekey{$BInFound_L}+Char:C90(Carriage return:K15:38))
						
					Else 
						$BR_InspKey_used_ab{$BInFound_L}:=True:C214  //mark this one as used
						v_179_002_txt:=$InspKey{$BInFound_L}
						v_179_001_txt:=$Bridgekey{$BInFound_L}
						SEND PACKET:C103($LogFile_t; "INSP ID "+String:C10($BMSInspID{$loop_L})+Char:C90(Tab:K15:37)+String:C10($BMSInspDate{$loop_L})+Char:C90(Tab:K15:37)+""+$BMSBIN{$loop_L}+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]BDEPT:1+Char:C90(Tab:K15:37)+"Found INSPKEY="+v_179_002_txt+"  BRKEY="+v_179_001_txt+Char:C90(Carriage return:K15:38))
						
					End if 
					
				Else 
					//have to search to check all other dates
					$BInFound_L:=Find in array:C230($BridgeID; $BMSBIN{$loop_L}; $BInFound_L+1)
					$EndBINSearch_b:=False:C215
					Repeat 
						
						If ($BInFound_L<1)
							//no more BIN !!
							$EndBINSearch_b:=True:C214
							$Done_b:=True:C214  //done with this NBE
							SEND PACKET:C103($LogFile_t; "INSP ID "+String:C10($BMSInspID{$loop_L})+Char:C90(Tab:K15:37)+String:C10($BMSInspDate{$loop_L})+Char:C90(Tab:K15:37)+""+$BMSBIN{$loop_L}+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]BDEPT:1+Char:C90(Tab:K15:37)+"ERROR !! No matching inspection dates!"+Char:C90(Carriage return:K15:38))
						Else 
							//check date
							$InspDateMatch_b:=($BMSInspDate{$loop_L}=$InspDate_ad{$BInFound_L})
							$InspDateMatch_b:=$InspDateMatch_b | ((Month of:C24($BMSInspDate{$loop_L})=Month of:C24($InspDate_ad{$BInFound_L})) & (Year of:C25($BMSInspDate{$loop_L})=Year of:C25($InspDate_ad{$BInFound_L})))
							
							If ($InspDateMatch_b)
								//found it!
								$EndBINSearch_b:=True:C214
								$Done_b:=True:C214  //done with this NBE
								
								If ($BR_InspKey_used_ab{$BInFound_L})
									SEND PACKET:C103($LogFile_t; "INSP ID "+String:C10($BMSInspID{$loop_L})+Char:C90(Tab:K15:37)+String:C10($BMSInspDate{$loop_L})+Char:C90(Tab:K15:37)+""+$BMSBIN{$loop_L}+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]BDEPT:1+Char:C90(Tab:K15:37)+"ERROR !! Found Already USED INSPKEY="+$InspKey{$BInFound_L}+"  BRKEY="+$Bridgekey{$BInFound_L}+Char:C90(Carriage return:K15:38))
									
								Else 
									$BR_InspKey_used_ab{$BInFound_L}:=True:C214  //mark this one as used
									v_179_002_txt:=$InspKey{$BInFound_L}
									v_179_001_txt:=$Bridgekey{$BInFound_L}
									SEND PACKET:C103($LogFile_t; "INSP ID "+String:C10($BMSInspID{$loop_L})+Char:C90(Tab:K15:37)+String:C10($BMSInspDate{$loop_L})+Char:C90(Tab:K15:37)+""+$BMSBIN{$loop_L}+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]BDEPT:1+Char:C90(Tab:K15:37)+"Found INSPKEY="+v_179_002_txt+"  BRKEY="+v_179_001_txt+Char:C90(Carriage return:K15:38))
									
								End if 
							Else 
								//search again
								$BInFound_L:=Find in array:C230($BridgeID; $BMSBIN{$loop_L}; $BInFound_L+1)
								
							End if 
							
						End if 
						
					Until ($EndBINSearch_b)
					
				End if 
				
			End if 
			
		Until ($done_b)
		If (v_179_002_txt#"")
			//Found a matching INSPKEY
			
			If (Records in selection:C76([PON_ELEM_INSP:179])>0)
				//skip any with key > 7000
				QUERY SELECTION:C341([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_KEY:3<=7000)
				C_TEXT:C284($Check_txt)
				$Check_txt:=PON_VerifyNBEQuantities
				
				If ($Check_txt#"")
					SEND PACKET:C103($LogFile_t; "INSP ID "+String:C10($BMSInspID{$loop_L})+Char:C90(Tab:K15:37)+String:C10($BMSInspDate{$loop_L})+Char:C90(Tab:K15:37)+""+$BMSBIN{$loop_L}+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]BDEPT:1+Char:C90(Tab:K15:37)+"ERROR !!! Quantity Errors for this inspection!"+Char:C90(Tab:K15:37)+Replace string:C233($Check_txt; <>sCR; " ")+Char:C90(Carriage return:K15:38))
				Else 
					If (Records in selection:C76([PON_ELEM_INSP:179])>0)
						//sort them
						SEND PACKET:C103($LogFile_t; "INSP ID "+String:C10($BMSInspID{$loop_L})+Char:C90(Tab:K15:37)+String:C10($BMSInspDate{$loop_L})+Char:C90(Tab:K15:37)+""+$BMSBIN{$loop_L}+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]BDEPT:1+Char:C90(Tab:K15:37)+"Sending "+String:C10(Records in selection:C76([PON_ELEM_INSP:179]))+" NBEs"+Char:C90(Carriage return:K15:38))
						//initialize array to check for duplicates
						ARRAY TEXT:C222($PK_Contraint_atxt; 0)
						C_TEXT:C284($Curr_PK_Constraint_txt)
						ORDER BY FORMULA:C300([PON_ELEM_INSP:179]; PON_ElemSort)  //
						FIRST RECORD:C50([PON_ELEM_INSP:179])
						While (Not:C34(End selection:C36([PON_ELEM_INSP:179])))
							$Curr_PK_Constraint_txt:=String:C10([PON_ELEM_INSP:179]ELEM_KEY:3)+"_"+String:C10([PON_ELEM_INSP:179]ENVKEY:5)+"_"+String:C10([PON_ELEM_INSP:179]ELEM_PARENT_KEY:4)+"_"+String:C10([PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19)
							
							Case of 
								: (Find in array:C230($PK_Contraint_atxt; $Curr_PK_Constraint_txt)>0)
									//Error skip this inspection !!!!!
									SEND PACKET:C103($LogFile_t; "INSP ID "+String:C10($BMSInspID{$loop_L})+Char:C90(Tab:K15:37)+String:C10($BMSInspDate{$loop_L})+Char:C90(Tab:K15:37)+""+$BMSBIN{$loop_L}+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]BDEPT:1+Char:C90(Tab:K15:37)+"ERROR !! Duplicate PK error for PK "+$Curr_PK_Constraint_txt+Char:C90(Carriage return:K15:38))
									LAST RECORD:C200([PON_ELEM_INSP:179])
									NEXT RECORD:C51([PON_ELEM_INSP:179])
								: (Find in array:C230($PON_ELemKeys_aL; [PON_ELEM_INSP:179]ELEM_KEY:3)<=0)
									//this key is not in BrM
									
									SEND PACKET:C103($LogFile_t; "INSP ID "+String:C10($BMSInspID{$loop_L})+Char:C90(Tab:K15:37)+String:C10($BMSInspDate{$loop_L})+Char:C90(Tab:K15:37)+""+$BMSBIN{$loop_L}+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]BDEPT:1+Char:C90(Tab:K15:37)+"ERROR !! Elem Key not in BrM "+String:C10([PON_ELEM_INSP:179]ELEM_KEY:3)+Char:C90(Carriage return:K15:38))
									
									NEXT RECORD:C51([PON_ELEM_INSP:179])
									
								Else 
									APPEND TO ARRAY:C911($PK_Contraint_atxt; $Curr_PK_Constraint_txt)
									
									C_TEXT:C284($NBEData_txt)
									//brkey
									$NBEData_txt:=v_179_001_txt+Char:C90(Tab:K15:37)
									//inspkey
									$NBEData_txt:=$NBEData_txt+v_179_002_txt+Char:C90(Tab:K15:37)
									//elem_key
									$NBEData_txt:=$NBEData_txt+String:C10([PON_ELEM_INSP:179]ELEM_KEY:3)+Char:C90(Tab:K15:37)
									//elem_parent_key
									$NBEData_txt:=$NBEData_txt+String:C10([PON_ELEM_INSP:179]ELEM_PARENT_KEY:4)+Char:C90(Tab:K15:37)
									//envkey
									$NBEData_txt:=$NBEData_txt+String:C10([PON_ELEM_INSP:179]ENVKEY:5)+Char:C90(Tab:K15:37)
									//strunitkey
									$NBEData_txt:=$NBEData_txt+String:C10([PON_ELEM_INSP:179]STRUNITKEY:6)+Char:C90(Tab:K15:37)
									v_179_007_r:=Round:C94([PON_ELEM_INSP:179]ELEM_QUANTITY:7; 3)
									v_179_014_r:=Round:C94([PON_ELEM_INSP:179]ELEM_QTYSTATE2:14; 3)
									v_179_015_r:=Round:C94([PON_ELEM_INSP:179]ELEM_QTYSTATE3:15; 3)
									v_179_016_r:=Round:C94([PON_ELEM_INSP:179]ELEM_QTYSTATE4:16; 3)
									v_179_013_r:=v_179_007_r-(v_179_014_r+v_179_015_r+v_179_016_r)
									v_179_013_r:=Round:C94(v_179_013_r; 3)
									
									If (v_179_013_r=(-0.001))
										
										Case of 
											: (v_179_014_r>0)
												v_179_014_r:=v_179_014_r+0.001
											: (v_179_015_r>0)
												v_179_015_r:=v_179_015_r+0.001
											: (v_179_016_r>0)
												v_179_016_r:=v_179_016_r+0.001
												
										End case 
										v_179_013_r:=0
									End if 
									
									
									v_179_012_r:=Round:C94((v_179_016_r/v_179_007_r); 3)
									v_179_011_r:=Round:C94((v_179_015_r/v_179_007_r); 3)
									v_179_010_r:=Round:C94((v_179_014_r/v_179_007_r); 3)
									v_179_009_r:=Round:C94((1-(v_179_010_r+v_179_011_r+v_179_012_r)); 3)
									
									If (v_179_009_r=(-0.001))
										
										Case of 
											: (v_179_010_r>0)
												v_179_010_r:=v_179_010_r+0.001
											: (v_179_011_r>0)
												v_179_011_r:=v_179_011_r+0.001
											: (v_179_012_r>0)
												v_179_012_r:=v_179_012_r+0.001
												
										End case 
										v_179_009_r:=0
									End if 
									v_179_009_r:=100*v_179_009_r
									v_179_010_r:=100*v_179_010_r
									v_179_011_r:=100*v_179_011_r
									v_179_012_r:=100*v_179_012_r
									
									
									If ([PON_ELEM_INSP:179]ELEM_SCALE_FACTOR:8=0)
										[PON_ELEM_INSP:179]ELEM_SCALE_FACTOR:8:=1  //this is just to make sure it is set to 1
									End if 
									//elem_quantity
									$NBEData_txt:=$NBEData_txt+String:C10(Round:C94(v_179_007_r; 3))+Char:C90(Tab:K15:37)
									//elem_pctstate1
									$NBEData_txt:=$NBEData_txt+String:C10(v_179_009_r)+Char:C90(Tab:K15:37)
									//elem_pctstate2
									$NBEData_txt:=$NBEData_txt+String:C10(v_179_010_r)+Char:C90(Tab:K15:37)
									//elem_pctstate3
									$NBEData_txt:=$NBEData_txt+String:C10(v_179_011_r)+Char:C90(Tab:K15:37)
									//elem_pctstate4
									$NBEData_txt:=$NBEData_txt+String:C10(v_179_012_r)+Char:C90(Tab:K15:37)
									//elem_qtystate1
									$NBEData_txt:=$NBEData_txt+String:C10(v_179_013_r)+Char:C90(Tab:K15:37)
									//elem_qtystate2
									$NBEData_txt:=$NBEData_txt+String:C10(v_179_014_r)+Char:C90(Tab:K15:37)
									//elem_qtystate3
									$NBEData_txt:=$NBEData_txt+String:C10(v_179_015_r)+Char:C90(Tab:K15:37)
									//elem_qtystate4
									$NBEData_txt:=$NBEData_txt+String:C10(v_179_016_r)+Char:C90(Tab:K15:37)
									//elem_scale_factor
									$NBEData_txt:=$NBEData_txt+String:C10([PON_ELEM_INSP:179]ELEM_SCALE_FACTOR:8)+Char:C90(Tab:K15:37)
									//elem_DESC
									$NBEData_txt:=$NBEData_txt+[PON_ELEM_INSP:179]ELEM_DESC:23+Char:C90(Tab:K15:37)
									//Elem_createdatetime
									$NBEData_txt:=$NBEData_txt+""+Char:C90(Tab:K15:37)
									//elem_createuserkey
									$NBEData_txt:=$NBEData_txt+""+Char:C90(Tab:K15:37)
									//elem_modtime
									$NBEData_txt:=$NBEData_txt+""+Char:C90(Tab:K15:37)
									//elem_moduserkey
									$NBEData_txt:=$NBEData_txt+""+Char:C90(Tab:K15:37)
									//elem_docrefkey
									$NBEData_txt:=$NBEData_txt+""+Char:C90(Tab:K15:37)
									//elem_notes
									//$NBEData_txt:=$NBEData_txt+[PON_ELEM_INSP]ELEM_NOTES+Char(Tab )
									$NBEData_txt:=$NBEData_txt+""+Char:C90(Tab:K15:37)
									//elem_grandparentkey
									$NBEData_txt:=$NBEData_txt+String:C10([PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19)+Char:C90(Carriage return:K15:38)
									
									If ((v_179_013_r<0) | (v_179_009_r<0))
										SEND PACKET:C103($LogFile_t; "INSP ID "+String:C10($BMSInspID{$loop_L})+Char:C90(Tab:K15:37)+String:C10($BMSInspDate{$loop_L})+Char:C90(Tab:K15:37)+""+$BMSBIN{$loop_L}+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]BDEPT:1+Char:C90(Tab:K15:37)+"ERROR !! Negative Quantity in State1 "+$NBEData_txt)
									Else 
										SEND PACKET:C103($ExportFile_t; $NBEData_txt)
									End if 
									
									NEXT RECORD:C51([PON_ELEM_INSP:179])
							End case 
						End while 
						
					Else 
						//only smart flags
						SEND PACKET:C103($LogFile_t; "INSP ID "+String:C10($BMSInspID{$loop_L})+Char:C90(Tab:K15:37)+String:C10($BMSInspDate{$loop_L})+Char:C90(Tab:K15:37)+""+$BMSBIN{$loop_L}+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]BDEPT:1+Char:C90(Tab:K15:37)+"Only Smart Flags for this inspection!"+Char:C90(Carriage return:K15:38))
					End if 
					
				End if 
				
				
			Else 
				//No NBEs found for this
				SEND PACKET:C103($LogFile_t; "INSP ID "+String:C10($BMSInspID{$loop_L})+Char:C90(Tab:K15:37)+String:C10($BMSInspDate{$loop_L})+Char:C90(Tab:K15:37)+""+$BMSBIN{$loop_L}+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]BDEPT:1+Char:C90(Tab:K15:37)+"No NBEs for this inspection!"+Char:C90(Carriage return:K15:38))
			End if 
			
		Else 
			//No matching INSPKEY Found
		End if 
		
		If (($loop_L%50)=0)
			MESSAGE:C88(" .."+String:C10($loop_L))
		End if 
		
	End for 
	CLOSE WINDOW:C154
	CLOSE DOCUMENT:C267($ExportFile_t)
	CLOSE DOCUMENT:C267($LogFile_t)
	SHOW ON DISK:C922($LogFile_txt)
Else 
	ALERT:C41("Found multiple INSPKEYS for same BIN / Inspection date. Export cannot proceed")
End if 

//End PON_ExportToBrM