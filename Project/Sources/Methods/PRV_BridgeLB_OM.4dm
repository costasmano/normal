//%attributes = {"invisible":true}
//Method: PRV_BridgeLB_OM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/05/12, 09:27:06
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
	// Modified by: Costas Manousakis-(Designer)-(10/24/13 11:19:39)
	Mods_2013_10
	//  `use  method  INSP_IsInspRoutine_b to check if inspection is a routine one
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
End if 
//
C_LONGINT:C283($FormEvent_L)
C_TEXT:C284($LBName_txt)
C_LONGINT:C283($1)
$FormEvent_L:=$1
C_TEXT:C284($2)
$LBName_txt:=$2

Case of 
	: ($FormEvent_L=On Load:K2:1)
		InDoubleClick_B:=False:C215
	: ($FormEvent_L=On Display Detail:K2:22)
		
		Case of 
			: ($LBName_txt="BRIDGES")
				//Variable LB_Detail6_txt SD/FO
				LB_BRIDGES_Det06_txt:=""
				QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Contract_Project_Maintenance:100]BIN:5)
				Case of 
					: ([Bridge MHD NBIS:1]StructDef:103)
						LB_BRIDGES_Det06_txt:="SD"
					: ([Bridge MHD NBIS:1]FunctObs:106)
						LB_BRIDGES_Det06_txt:="FO"
				End case 
				LB_BRIDGES_Det07_txt:=QR_Item26OnOff
				LB_BRIDGES_Det08_txt:=[Bridge MHD NBIS:1]Item8:206
				
			: ($LBName_txt="BRIDGESDEC")
				QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Contract_Project_Maintenance:100]BIN:5)
				//LB_Detail2_txt:=String([Bridge MHD NBIS]Item27)
				//LB_Detail3_txt:=String([Bridge MHD NBIS]Item106)
				//LB_Detail4_txt:=[Bridge MHD NBIS]Item58
				//LB_Detail5_txt:=[Bridge MHD NBIS]Item59
				//LB_Detail6_txt:=[Bridge MHD NBIS]Item60
				//LB_Detail7_txt:=[Bridge MHD NBIS]Item62
				//LB_Detail8_txt:=[Bridge MHD NBIS]Item67
				//LB_Detail9_txt:=[Bridge MHD NBIS]Item71
				//LB_Detail10_txt:=[Bridge MHD NBIS]Item113
				LB_BRIDGESDEC_Det11_txt:=[Bridge MHD NBIS:1]Item58:130  //paint
				LB_BRIDGESDEC_Det12_txt:=[Bridge MHD NBIS:1]Item36A:147+[Bridge MHD NBIS:1]Item36B:148+[Bridge MHD NBIS:1]Item36C:149+[Bridge MHD NBIS:1]Item36D:150
				LB_BRIDGESDEC_Det13_txt:=String:C10(10.7639104*QR_BridgeArea_r; "###,###.0")
				LB_BRIDGESDEC_Det14_txt:=String:C10(3.280839895*[Bridge MHD NBIS:1]Item54B:108; "###,###.0")  //vert CL in ft
				LB_BRIDGESDEC_Det15_txt:=String:C10(100*[Bridge MHD NBIS:1]HealthIndex:222; "###.00;;0")  //HI
				LB_BRIDGESDEC_Det16_txt:=String:C10([Bridge MHD NBIS:1]Item29:88; "###,###,###")  //ADT
				LB_BRIDGESDEC_Det17_txt:=String:C10(0.621371192*[Bridge MHD NBIS:1]Item19:91; "###.0")  //Detour in miles
				LB_BRIDGESDEC_Det18_txt:=QR_Item26
				
			: ($LBName_txt="STR25")
				
			: ($LBName_txt="HWY25")
				
			: ($LBName_txt="INSPECT")
				
				LB_INSPECT_Det01_txt:=[Inspection Type:31]Description:2
				QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[Combined Inspections:90]NBISInspID:2)
				If (INSP_IsInspRoutine_b)
					C_BOOLEAN:C305($vbCombined)
					If (Substring:C12(<>Version; 1; (Position:C15(" "; <>Version)-1))>="5.0")
						$vbCombined:=[Inspections:27]InspRtnSpcMemFlag:209
					Else 
						$vbCombined:=(G_Insp_CountSpMs>0)
					End if 
					If ($vbCombined)
						LB_INSPECT_Det01_txt:=LB_INSPECT_Det01_txt+" & Spec.Mem."
					End if 
					
				End if 
				
				Case of 
					: ([Inspections:27]InspReviewed:12=0)
						LB_INSPECT_Det10_pct:=LB_INSPECT_Det10_pct*0
					: ([Inspections:27]InspReviewed:12=1)
						GET PICTURE FROM LIBRARY:C565("BMS RejectIcon"; LB_INSPECT_Det10_pct)
					: ([Inspections:27]InspReviewed:12=2)
						GET PICTURE FROM LIBRARY:C565("BMS ApproveIcon"; LB_INSPECT_Det10_pct)
						
				End case 
				
				Case of 
					: ([Inspections:27]InspApproved:167=0)
						LB_INSPECT_Det11_pct:=LB_INSPECT_Det11_pct*0
					: ([Inspections:27]InspApproved:167=1)
						GET PICTURE FROM LIBRARY:C565("BMS RejectIcon"; LB_INSPECT_Det11_pct)
					: ([Inspections:27]InspApproved:167=2)
						GET PICTURE FROM LIBRARY:C565("BMS ApproveIcon"; LB_INSPECT_Det11_pct)
						
				End case 
				
				
				LB_INSPECT_Det03_txt:=[Inspections:27]Item 58:79
				//vsInc_Insp_I59:=[Inspections]Item 59
				//
				If ([Inspections:27]Insp Type:6="DV@")
					LB_INSPECT_Det05_txt:=[Inspections:27]Item 60 UW:66
					LB_INSPECT_Det06_txt:=[Inspections:27]Item 61 UW:72
					LB_INSPECT_Det07_txt:=[Inspections:27]Item 62 UW:165
				Else 
					LB_INSPECT_Det05_txt:=[Inspections:27]Item 60:81
					LB_INSPECT_Det06_txt:=[Inspections:27]Item 61:82
					LB_INSPECT_Det07_txt:=[Inspections:27]Item 62:113
				End if 
				Case of 
					: ([Inspections:27]Insp Type:6="FCR")
						LB_INSPECT_Det03_txt:=""
						LB_INSPECT_Det06_txt:=""
						LB_INSPECT_Det07_txt:=""
					: ([Inspections:27]Insp Type:6="CMI")
						LB_INSPECT_Det06_txt:=""
				End case 
				
				If ([Inspections:27]InspComplete:168)
					GET PICTURE FROM LIBRARY:C565("Mark_on"; LB_INSPECT_Det09_pct)
				Else 
					GET PICTURE FROM LIBRARY:C565("Mark_Off"; LB_INSPECT_Det09_pct)
				End if 
				
		End case 
		
	: ($FormEvent_L=On Data Change:K2:15)
		
	: ($FormEvent_L=On Clicked:K2:4)
		
	: ($FormEvent_L=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			
			C_POINTER:C301($3; $Table_ptr)
			$Table_ptr:=$3
			C_TEXT:C284($4; $FormName_txt)
			$FormName_txt:=$4
			C_TEXT:C284($LBName_txt; $SetName_txt; PRV_NEWREVIEWTYPE_s; $LBSelection_txt)
			C_LONGINT:C283($Dumm_L; $LBCol_L; $LBRow_L; $LbTableNum_L)
			//ALERT("doubleClicked on "+$LBName_txt)
			PRV_NEWREVIEWTYPE_s:=$LBName_txt
			$SetName_txt:="PRV_"+$LBName_txt+"_HS"
			$LBName_txt:="PRV_"+$LBName_txt+"_LB"
			
			If (Records in set:C195($SetName_txt)>0)
				LISTBOX GET TABLE SOURCE:C1014(*; $LBName_txt; $LbTableNum_L; $LBSelection_txt)
				If ($LBSelection_txt#"")
					USE NAMED SELECTION:C332($LBSelection_txt)
				End if 
				LISTBOX GET CELL POSITION:C971(*; $LBName_txt; $LBCol_L; $LBRow_L)
				If ($LBRow_L>0)
					Case of 
						: ($LBName_txt="PRV_INSPECT_LB")
							READ ONLY:C145([Bridge MHD NBIS:1])
							READ ONLY:C145([Combined Inspections:90])
							READ ONLY:C145([Inspections:27])
							READ ONLY:C145([Inspection Type:31])
							SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
							LOAD RECORD:C52([Combined Inspections:90])
							QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Combined Inspections:90]BIN:1)
							
							SET CURSOR:C469(4)
							RELATE ONE:C42([Combined Inspections:90]NBISInspID:2)
							RELATE ONE:C42([Combined Inspections:90]BMSInspID:3)
							C_LONGINT:C283(vCurrentPontisID_L; vCurrentCombID_L)
							C_BOOLEAN:C305(vAllRelationsOK_B)
							vCurrentPontisID_L:=[BMS Inspections:44]Inspection ID:1
							vCurrentCombID_L:=[Combined Inspections:90]ID:6
							vAllRelationsOK_B:=True:C214
							If ([Combined Inspections:90]BMSInspID:3>0)
								If (vCurrentPontisID_L#[Combined Inspections:90]BMSInspID:3)
									vAllRelationsOK_B:=False:C215
								End if 
								If ([BMS Inspections:44]BIN:2#[Combined Inspections:90]BIN:1)
									vAllRelationsOK_B:=False:C215
								End if 
							End if 
							If (vAllRelationsOK_B)
								READ ONLY:C145([Combined Inspections:90])
								QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=[Inspections:27]Insp Type:6)
								DIALOG:C40([Inspections:27]; "BlankCombinedStarter")
								
								If (In transaction:C397)
									CANCEL TRANSACTION:C241
								End if 
								
							Else 
								ALERT:C41("There are database link problems with this inspection record!! Record cannot be l"+"oaded!!")
							End if 
							READ ONLY:C145([Bridge MHD NBIS:1])
							QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Contract_Project_Maintenance:100]BIN:5)
							INSP_UpdateInspList
							
							
							
						: ($LBName_txt="PRV_BRIDGES_LB")
							FORM SET INPUT:C55($Table_ptr->; $FormName_txt)
							
							If (Read only state:C362([Contract_Assignment_Maintenance:101]))
								READ ONLY:C145($Table_ptr->)
								LOAD RECORD:C52($Table_ptr->)
								DIALOG:C40($Table_ptr->; $FormName_txt)
							Else 
								C_LONGINT:C283($LoadRecResult_L)
								$LoadRecResult_L:=ut_LoadRecordInteractiveV2($Table_ptr)
								
								Case of 
									: ($LoadRecResult_L=1)
										MODIFY RECORD:C57($Table_ptr->)
										PRV_Variables("RELATEBRIDGEINFO")
										PRV_CTRLSelections(PRV_NEWREVIEWTYPE_s)
									: ($LoadRecResult_L=2)
										READ ONLY:C145($Table_ptr->)
										LOAD RECORD:C52($Table_ptr->)
										DIALOG:C40($Table_ptr->; $FormName_txt)
								End case 
								
							End if 
							
						: ($LBName_txt="PRV_BRIDGESDEC_LB")
							READ ONLY:C145($Table_ptr->)
							LOAD RECORD:C52($Table_ptr->)
							DIALOG:C40($Table_ptr->; $FormName_txt)
							
					End case 
					
				End if 
				
			Else 
				//ALERT("Nothing")
			End if 
			InDoubleClick_B:=False:C215
		End if 
		
End case 

//End PRV_BridgeLB_OM