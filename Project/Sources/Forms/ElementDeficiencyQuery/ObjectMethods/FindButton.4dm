//Method: ElementDeficiencyQuery.Variable5
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/13/18, 14:07:43
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12
End if 
//
C_BOOLEAN:C305($PERFORMQUERY_B)
$PERFORMQUERY_B:=Not:C34((cbDeficiency+cbUrgency+cbElmtCond+cbElementCat)=0)
If (Not:C34($PERFORMQUERY_B))
	If (cbElemDescTxt=1) & (SRC_ELEMDESC_txt="")
	Else 
		$PERFORMQUERY_B:=True:C214
		
	End if 
End if 
If (Not:C34($PERFORMQUERY_B))
	ALERT:C41("You have not selected any categories so no query can be performed")
Else 
	C_LONGINT:C283($Progress_L; $Loop_L; $ThisElementID_L)
	$Progress_L:=Progress New
	
	CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "InterimSet")
	USE SET:C118("LSSInspectionSet")
	ARRAY TEXT:C222($InspectionIDs_atxt; 0)
	
	SELECTION TO ARRAY:C260([LSS_Inspection:164]LSS_InspectionId_s:1; $InspectionIDs_atxt)
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "TotalElmtsFound")
	QUERY WITH ARRAY:C644([LSS_ElementInspection:163]LSS_InspectionId_s:3; $InspectionIDs_atxt)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	ARRAY TEXT:C222($TextQuery_atxt; 0)
	ARRAY LONGINT:C221($LongintQuery_aL; 0)
	C_LONGINT:C283($Position_L)
	If (cbDeficiency=1) & (Records in set:C195("TotalElmtsFound")>0)
		Progress SET TITLE($progress_L; "Searching for Deficiency")
		Progress SET PROGRESS($progress_L; 0)
		//M=Minor Deficiency
		//S=Severe/Major Deficiency
		//C-S=Critical Structural Deficiency
		//C-H=Critical Hazard Deficiency
		Case of 
			: (vDefOp="")
				
			: (vDefOp="=")
				APPEND TO ARRAY:C911($TextQuery_atxt; vDef)
				
			: (vDefOp="#")
				Case of 
					: (vDef="M")
						APPEND TO ARRAY:C911($TextQuery_atxt; "S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-H")
						
					: (vDef="S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "M")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-H")
						
					: (vDef="C-S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "M")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-H")
						
					: (vDef="C-H")
						APPEND TO ARRAY:C911($TextQuery_atxt; "M")
						APPEND TO ARRAY:C911($TextQuery_atxt; "S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-S")
						
				End case 
			: (vDefOp="<")
				Case of 
					: (vDef="M")
					: (vDef="S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "M")
					: (vDef="C-S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "M")
						APPEND TO ARRAY:C911($TextQuery_atxt; "S")
					: (vDef="C-H")
						APPEND TO ARRAY:C911($TextQuery_atxt; "M")
						APPEND TO ARRAY:C911($TextQuery_atxt; "S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-S")
						
				End case 
			: (vDefOp="<=")
				Case of 
					: (vDef="M")
						APPEND TO ARRAY:C911($TextQuery_atxt; "M")
					: (vDef="S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "M")
						APPEND TO ARRAY:C911($TextQuery_atxt; "S")
					: (vDef="C-S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "M")
						APPEND TO ARRAY:C911($TextQuery_atxt; "S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-S")
					: (vDef="C-H")
						APPEND TO ARRAY:C911($TextQuery_atxt; "M")
						APPEND TO ARRAY:C911($TextQuery_atxt; "S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-H")
				End case 
			: (vDefOp=">")
				Case of 
					: (vDef="M")
						APPEND TO ARRAY:C911($TextQuery_atxt; "S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-H")
					: (vDef="S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-H")
					: (vDef="C-S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-H")
					: (vDef="C-H")
						
				End case 
			: (vDefOp=">=")
				Case of 
					: (vDef="M")
						APPEND TO ARRAY:C911($TextQuery_atxt; "M")
						APPEND TO ARRAY:C911($TextQuery_atxt; "S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-H")
					: (vDef="S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-H")
					: (vDef="C-S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-S")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-H")
					: (vDef="C-H")
						APPEND TO ARRAY:C911($TextQuery_atxt; "C-H")
				End case 
		End case 
		If (Size of array:C274($TextQuery_atxt)>0)
			USE SET:C118("TotalElmtsFound")
			//USE SET("LSS_StartElementSet")
			SET QUERY DESTINATION:C396(Into set:K19:2; "InterimSet")
			QUERY SELECTION WITH ARRAY:C1050([LSS_ElementInspection:163]LSS_Deficiency_s:5; $TextQuery_atxt)
			
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			LSS_DefQueryRemoveDuplicates
		Else 
			CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "InterimSet")
		End if 
		INTERSECTION:C121("TotalElmtsFound"; "InterimSet"; "TotalElmtsFound")
		
		USE SET:C118("TotalElmtsFound")
		
	End if 
	If (cbUrgency=1) & (Records in set:C195("TotalElmtsFound")>0)
		Progress SET TITLE($progress_L; "Searching for Urgency")
		Progress SET PROGRESS($progress_L; 0)
		
		ARRAY TEXT:C222($TextQuery_atxt; 0)
		CLEAR VARIABLE:C89($TextQuery_atxt)
		
		//I=Immediate
		//A=ASAP
		//P=Prioritize
		Case of 
			: (vUrgOp="")
			: (vUrgOp="=")
				APPEND TO ARRAY:C911($TextQuery_atxt; vUrg)
			: (vUrgOp="#")
				Case of 
					: (vUrg="P")
						APPEND TO ARRAY:C911($TextQuery_atxt; "I")
						APPEND TO ARRAY:C911($TextQuery_atxt; "A")
					: (vUrg="A")
						APPEND TO ARRAY:C911($TextQuery_atxt; "I")
						APPEND TO ARRAY:C911($TextQuery_atxt; "P")
					: (vUrg="I")
						APPEND TO ARRAY:C911($TextQuery_atxt; "P")
						APPEND TO ARRAY:C911($TextQuery_atxt; "A")
						
						
				End case 
			: (vUrgOp="<")
				Case of 
					: (vUrg="P")
						
					: (vUrg="A")
						APPEND TO ARRAY:C911($TextQuery_atxt; "P")
					: (vUrg="I")
						APPEND TO ARRAY:C911($TextQuery_atxt; "P")
						APPEND TO ARRAY:C911($TextQuery_atxt; "A")
				End case 
			: (vUrgOp="<=")
				Case of 
					: (vUrg="P")
						APPEND TO ARRAY:C911($TextQuery_atxt; "P")
						
					: (vUrg="A")
						APPEND TO ARRAY:C911($TextQuery_atxt; "A")
						APPEND TO ARRAY:C911($TextQuery_atxt; "P")
						
					: (vUrg="I")
						APPEND TO ARRAY:C911($TextQuery_atxt; "P")
						APPEND TO ARRAY:C911($TextQuery_atxt; "A")
						APPEND TO ARRAY:C911($TextQuery_atxt; "I")
				End case 
			: (vUrgOp=">")
				Case of 
					: (vUrg="P")
						APPEND TO ARRAY:C911($TextQuery_atxt; "A")
						APPEND TO ARRAY:C911($TextQuery_atxt; "I")
					: (vUrg="A")
						APPEND TO ARRAY:C911($TextQuery_atxt; "I")
						
					: (vUrg="I")
						
				End case 
			: (vUrgOp=">=")
				Case of 
					: (vUrg="P")
						APPEND TO ARRAY:C911($TextQuery_atxt; "P")
						APPEND TO ARRAY:C911($TextQuery_atxt; "A")
						APPEND TO ARRAY:C911($TextQuery_atxt; "I")
					: (vUrg="A")
						APPEND TO ARRAY:C911($TextQuery_atxt; "A")
						APPEND TO ARRAY:C911($TextQuery_atxt; "I")
						
					: (vUrg="I")
						APPEND TO ARRAY:C911($TextQuery_atxt; "I")
				End case 
				
				
		End case 
		If (Size of array:C274($TextQuery_atxt)>0)
			
			
			USE SET:C118("TotalElmtsFound")
			SET QUERY DESTINATION:C396(Into set:K19:2; "InterimSet")
			QUERY SELECTION WITH ARRAY:C1050([LSS_ElementInspection:163]LSS_Urgency_s:6; $TextQuery_atxt)
			
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			LSS_DefQueryRemoveDuplicates
			INTERSECTION:C121("TotalElmtsFound"; "InterimSet"; "TotalElmtsFound")
			
		Else 
			CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "InterimSet")
		End if 
		INTERSECTION:C121("TotalElmtsFound"; "InterimSet"; "TotalElmtsFound")
		
		USE SET:C118("TotalElmtsFound")
		
	End if 
	If (cbElmtCond=1) & (Records in set:C195("TotalElmtsFound")>0)
		Progress SET TITLE($progress_L; "Searching for Element Condition")
		Progress SET PROGRESS($progress_L; 0)
		
		ARRAY TEXT:C222($TextQuery_atxt; 0)
		CLEAR VARIABLE:C89($TextQuery_atxt)
		
		C_TEXT:C284($startPos_txt)
		$startPos_txt:=Substring:C12(cboElmtCond{cboElmtCond}; 1; 1)
		Case of 
			: (vElmtCondOp="")
			: (vElmtCondOp="=")
				APPEND TO ARRAY:C911($TextQuery_atxt; $startPos_txt)
				
			: (vElmtCondOp="#")
				For ($Loop_L; 1; Size of array:C274(cboElmtCond))
					If ($Loop_L=cboElmtCond)
					Else 
						APPEND TO ARRAY:C911($TextQuery_atxt; Substring:C12(cboElmtCond{$Loop_L}; 1; 1))
					End if 
					
					
				End for 
				
			: (vElmtCondOp="<")
				
				Case of 
					: ($startPos_txt="1")
						APPEND TO ARRAY:C911($TextQuery_atxt; "2")
						APPEND TO ARRAY:C911($TextQuery_atxt; "3")
						APPEND TO ARRAY:C911($TextQuery_atxt; "4")
						
					: ($startPos_txt="2")
						APPEND TO ARRAY:C911($TextQuery_atxt; "3")
						APPEND TO ARRAY:C911($TextQuery_atxt; "4")
						
					: ($startPos_txt="3")
						APPEND TO ARRAY:C911($TextQuery_atxt; "4")
						
				End case 
			: (vElmtCondOp="<=")
				Case of 
					: ($startPos_txt="1")
						APPEND TO ARRAY:C911($TextQuery_atxt; "1")
						APPEND TO ARRAY:C911($TextQuery_atxt; "2")
						APPEND TO ARRAY:C911($TextQuery_atxt; "3")
						APPEND TO ARRAY:C911($TextQuery_atxt; "4")
						
					: ($startPos_txt="2")
						APPEND TO ARRAY:C911($TextQuery_atxt; "2")
						APPEND TO ARRAY:C911($TextQuery_atxt; "3")
						APPEND TO ARRAY:C911($TextQuery_atxt; "4")
						
					: ($startPos_txt="3")
						APPEND TO ARRAY:C911($TextQuery_atxt; "3")
						APPEND TO ARRAY:C911($TextQuery_atxt; "4")
						
					: ($startPos_txt="4")
						
						APPEND TO ARRAY:C911($TextQuery_atxt; "4")
				End case 
			: (vElmtCondOp=">")
				Case of 
					: ($startPos_txt="1")
					: ($startPos_txt="2")
						APPEND TO ARRAY:C911($TextQuery_atxt; "1")
						
						
					: ($startPos_txt="3")
						APPEND TO ARRAY:C911($TextQuery_atxt; "1")
						APPEND TO ARRAY:C911($TextQuery_atxt; "2")
						
					: ($startPos_txt="4")
						APPEND TO ARRAY:C911($TextQuery_atxt; "1")
						APPEND TO ARRAY:C911($TextQuery_atxt; "2")
						APPEND TO ARRAY:C911($TextQuery_atxt; "3")
						
				End case 
			: (vElmtCondOp=">=")
				Case of 
					: ($startPos_txt="1")
						APPEND TO ARRAY:C911($TextQuery_atxt; "1")
						
						
					: ($startPos_txt="2")
						APPEND TO ARRAY:C911($TextQuery_atxt; "1")
						APPEND TO ARRAY:C911($TextQuery_atxt; "2")
						
					: ($startPos_txt="3")
						APPEND TO ARRAY:C911($TextQuery_atxt; "1")
						APPEND TO ARRAY:C911($TextQuery_atxt; "2")
						APPEND TO ARRAY:C911($TextQuery_atxt; "3")
						
						
					: ($startPos_txt="4")
						APPEND TO ARRAY:C911($TextQuery_atxt; "1")
						APPEND TO ARRAY:C911($TextQuery_atxt; "2")
						APPEND TO ARRAY:C911($TextQuery_atxt; "3")
						APPEND TO ARRAY:C911($TextQuery_atxt; "4")
						
						
				End case 
				
				
		End case 
		If (Size of array:C274($TextQuery_atxt)>0)
			USE SET:C118("TotalElmtsFound")
			SET QUERY DESTINATION:C396(Into set:K19:2; "InterimSet")
			QUERY SELECTION WITH ARRAY:C1050([LSS_ElementInspection:163]LSS_Rating_s:4; $TextQuery_atxt)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			LSS_DefQueryRemoveDuplicates
			INTERSECTION:C121("TotalElmtsFound"; "InterimSet"; "TotalElmtsFound")
			
		Else 
			CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "InterimSet")
		End if 
		INTERSECTION:C121("TotalElmtsFound"; "InterimSet"; "TotalElmtsFound")
		
		USE SET:C118("TotalElmtsFound")
		
	End if 
	
	If (cbElementCat=1) & (Records in set:C195("TotalElmtsFound")>0)
		Progress SET TITLE($progress_L; "Searching for Element Category")
		Progress SET PROGRESS($progress_L; 0)
		
		ARRAY LONGINT:C221($LongintQuery_aL; 0)
		CLEAR VARIABLE:C89($LongintQuery_aL)
		If (cboElem>0)
			
			APPEND TO ARRAY:C911($LongintQuery_aL; v_163_002_aL{cboElem})
			
		Else 
			If (cboInspType>0)
				If (cboInspType=1)  // all
					COPY ARRAY:C226(v_162_001_aL; $LongintQuery_aL)
				Else 
					C_TEXT:C284($Search_txt)
					$Search_txt:=cboInspType{cboInspType}
					C_LONGINT:C283($Pos_L; $Start_L)
					$Start_L:=1
					Repeat 
						$Pos_L:=Find in array:C230(LSS_Headers_atxt; $Search_txt; $Start_L)
						If ($Pos_L>0)
							APPEND TO ARRAY:C911($LongintQuery_aL; v_162_001_aL{$Pos_L})
							$Start_L:=$Pos_L+1
						End if 
					Until ($Pos_L<1)
				End if 
			End if 
		End if 
		If (Size of array:C274($LongintQuery_aL)>0)
			USE SET:C118("TotalElmtsFound")
			SET QUERY DESTINATION:C396(Into set:K19:2; "InterimSet")
			QUERY SELECTION WITH ARRAY:C1050([LSS_ElementInspection:163]LSS_ElementId_L:2; $LongintQuery_aL)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			LSS_DefQueryRemoveDuplicates
			INTERSECTION:C121("TotalElmtsFound"; "InterimSet"; "TotalElmtsFound")
		Else 
			CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "InterimSet")
		End if 
		INTERSECTION:C121("TotalElmtsFound"; "InterimSet"; "TotalElmtsFound")
		
		USE SET:C118("TotalElmtsFound")
		
	End if 
	
	If (cbElemDescTxt=1) & (Records in set:C195("TotalElmtsFound")>0)
		Progress SET TITLE($progress_L; "Searching for Element Description")
		Progress SET PROGRESS($progress_L; 0)
		
		C_TEXT:C284($Search_txt)
		If (SRC_ELEMDESC_txt#"")
			Case of 
					
				: (cboDescComparison{cboDescComparison}="Contains")
					$Search_txt:="@"+SRC_ELEMDESC_txt+"@"
				: (cboDescComparison{cboDescComparison}="Equals")
					$Search_txt:=SRC_ELEMDESC_txt
				: (cboDescComparison{cboDescComparison}="Begins with")
					$Search_txt:=SRC_ELEMDESC_txt+"@"
				: (cboDescComparison{cboDescComparison}="Ends with")
					$Search_txt:="@"+SRC_ELEMDESC_txt
			End case 
			If ($Search_txt#"")
				USE SET:C118("TotalElmtsFound")
				SET QUERY DESTINATION:C396(Into set:K19:2; "InterimSet")
				QUERY SELECTION:C341([LSS_ElementInspection:163]; [LSS_ElementInspection:163]LSS_Description_txt:7=$Search_txt)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				LSS_DefQueryRemoveDuplicates
				INTERSECTION:C121("TotalElmtsFound"; "InterimSet"; "TotalElmtsFound")
				
			Else 
				CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "InterimSet")
			End if 
			INTERSECTION:C121("TotalElmtsFound"; "InterimSet"; "TotalElmtsFound")
			
			USE SET:C118("TotalElmtsFound")
			
		End if 
		
	End if 
	
	If (vApprovalLevel>0) & (Records in set:C195("TotalElmtsFound")>0)
		Progress SET TITLE($progress_L; "Searching for approval level")
		Progress SET PROGRESS($progress_L; 0)
		
		//Search Any Completed Inspection
		//Search Inspection Approved by DBIE
		//Search Inspection with Final Approval
		USE SET:C118("TotalElmtsFound")
		
		SET QUERY DESTINATION:C396(Into set:K19:2; "InterimSet")
		
		Case of 
			: (vApprovalLevel=1)
				QUERY SELECTION:C341([LSS_ElementInspection:163]; [LSS_Inspection:164]LSS_Complete_b:39=True:C214)
			: (vApprovalLevel=2)
				QUERY SELECTION:C341([LSS_ElementInspection:163]; [LSS_Inspection:164]LSS_Approved_L:43=BMS Approved)
		End case 
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		INTERSECTION:C121("TotalElmtsFound"; "InterimSet"; "TotalElmtsFound")
	End if 
	If (Records in set:C195("TotalElmtsFound")>0)
		If (Records in set:C195("FinalElementSet")>0)
			UNION:C120("TotalElmtsFound"; "FinalElementSet"; "FinalElementSet")
		Else 
			COPY SET:C600("TotalElmtsFound"; "FinalElementSet")
		End if 
	End if 
	CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "TotalElmtsFound")
	CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "InterimSet")
	
	// add code to make sure if element 2 is in twp inspections I remove the older element
	
	USE SET:C118("FinalElementSet")
	
	ARRAY LONGINT:C221($recordsNumbers_aL; 0)
	ARRAY DATE:C224($dates_aD; 0)
	ARRAY TEXT:C222($Numbers_atxt; 0)
	ARRAY LONGINT:C221($ElementNumbers_aL; 0)
	ARRAY TEXT:C222($InventoryIDs_atxt; 0)
	SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
	
	SELECTION TO ARRAY:C260([LSS_ElementInspection:163]; $recordsNumbers_aL; \
		[LSS_ElementInspection:163]LSS_ElementId_L:2; $ElementNumbers_aL; \
		[LSS_Inspection:164]LSS_InspectionDate_d:4; $dates_aD; \
		[LSS_Inventory:165]LSS_StructureNumber_s:6; $Numbers_atxt; \
		[LSS_Inventory:165]LSS_InventoryId_s:1; $InventoryIDs_atxt)
	//MULTI SORT ARRAY($ElementNumbers_aL;>;$Numbers_atxt;>;$dates_aD;<;$InventoryIDs_atxt;$recordsNumbers_aL)
	//C_LONGINT($loop_l)
	//Progress SET TITLE ($progress_L;"Eliminating duplicate elements found")
	//Progress SET PROGRESS ($progress_L;0)
	//C_LONGINT($Count_L)
	//$Count_L:=0
	//For ($loop_l;Size of array($Numbers_atxt);1;-1)
	//$Count_L:=$Count_L+1
	//Progress SET PROGRESS ($progress_L;$Count_L/Size of array($Numbers_atxt))
	//If ($loop_l>1)
	//If ($ElementNumbers_aL{$loop_l}=$ElementNumbers_aL{$loop_l-1})
	
	//If ($Numbers_atxt{$loop_l}=$Numbers_atxt{$loop_l-1})
	//DELETE FROM ARRAY($recordsNumbers_aL;$loop_l;1)
	//DELETE FROM ARRAY($ElementNumbers_aL;$loop_l;1)
	//DELETE FROM ARRAY($dates_aD;$loop_l;1)
	//DELETE FROM ARRAY($Numbers_atxt;$loop_l;1)
	//DELETE FROM ARRAY($InventoryIDs_atxt;$loop_l;1)
	//End if 
	//End if 
	//End if 
	//End for 
	//CREATE SELECTION FROM ARRAY([LSS_ElementInspection];$recordsNumbers_aL)
	//CREATE SET([LSS_ElementInspection];"FinalElementSet")
	//USE SET("FinalElementSet")
	
	//INTERSECTION("LSS_StartElementSet";"FinalElementSet";"FinalElementSet")
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "LSS_InventorySet")
	QUERY WITH ARRAY:C644([LSS_Inventory:165]LSS_InventoryId_s:1; $InventoryIDs_atxt)
	
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	USE SET:C118("LSS_InventorySet")
	COPY NAMED SELECTION:C331([LSS_Inventory:165]; "InventorySet")
	vtSearchResultCnt:="Found "+String:C10(Records in set:C195("LSS_InventorySet"))+" Structure "+Char:C90(Carriage return:K15:38)
	vtSearchResultCnt:=vtSearchResultCnt+"with "+String:C10(Records in set:C195("FinalElementSet"))+" Element"
	If (Records in set:C195("LSS_InventorySet")>1) | (Records in set:C195("LSS_InventorySet")=0)
		vtSearchResultCnt:=Replace string:C233(vtSearchResultCnt; "Structure"; "Structures")
	End if 
	If (Records in set:C195("FinalElementSet")>1) | (Records in set:C195("FinalElementSet")=0)
		vtSearchResultCnt:=Replace string:C233(vtSearchResultCnt; "Element"; "Elements")
	End if 
	Progress QUIT($Progress_L)
End if 


OBJECT SET ENABLED:C1123(*; "PrintNow"; Records in set:C195("FinalElementSet")>0)
OBJECT SET ENABLED:C1123(*; "Results"; Records in set:C195("FinalElementSet")>0)

//End ElementDeficiencyQuery.Variable5