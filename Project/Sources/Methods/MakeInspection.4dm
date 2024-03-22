//%attributes = {"invisible":true}
If (False:C215)
	//procedure: MakeInspection
	//by: Albert Leung
	//created: 4/28/2001
	//purpose: use a hierarchical list to create an inspection form
	//Copyright © 1995-2001,  Albert S. Leung, All Rights Reserved.
	//parameters:
	//$1
	
	//modified:
	// Dec-2001 : moved setting of InspType field right after the display of 
	//  form [dialogs]inspectconfig
	//Jun-2002 : removed setting Insp Type here. It is done in ADD_INSPECT method.
	
	Mods_2005_CM01
	Mods_2005_CM03
	Mods_2005_CM04
	Mods_2005_VN01
	// Modified by: costasmanousakis-(Designer)-(12/6/07 14:39:28)
	Mods_2007_CM_5401
	Mods_2009_03  //CJM  r001   `03/06/09, 13:05:14`Upgrade from open form window to open window
	// Modified by: costasmanousakis-(Designer)-(1/19/11 09:26:32)
	Mods_2011_01
	//` Additions for Rail bridges
	Mods_2012_12  //r001 ` Add code for new inspection types
	//Modified by: Charles Miller (12/13/12 14:04:07)
	// Modified by: Costas Manousakis-(Designer)-(1/2/13 13:04:43)
	Mods_2013_01
	//  `Use the new field [Inspections]BaseType_s for RRS, RRF inspecitons. If it is not defined ask user to select it.
	//  `Also allow user to change base type if there are no elements already selected.
	//  `And if a blank hList is generated, show Alert and don't go to the Configure dialog
	Mods_2013_05  //r001 ` Add new Inspection types to allow for confiuring (TAL,TOV,TSP) 
	//Modified by: Charles Miller (5/2/13 11:27:56)
End if 

C_LONGINT:C283($FormWindow)

//create a local array that contains the list of existing elements
SET CURSOR:C469(4)
G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4)

ARRAY INTEGER:C220($vaSafetyElem; 0)
ARRAY LONGINT:C221($vaSafetyElemId; 0)
C_LONGINT:C283(hList1; hList2)
SELECTION TO ARRAY:C260([ElementsSafety:29]ElementNo:1; $vaSafetyElem)
SELECTION TO ARRAY:C260([ElementsSafety:29]ElmSafetyID:7; $vaSafetyElemId)

Case of 
	: ([Inspections:27]Insp Type:6="RTN")
		//hList1:=insp_NewCreateElementDictHlist 
		hList1:=CreateElemDictHlist("N58"; "N59"; "N60"; "N61"; "APP"; "OVR"; "TRA")
	: ([Inspections:27]Insp Type:6="RTA")
		hList1:=CreateElemDictHlist("N58"; "N59"; "N60"; "N61"; "APP"; "OVR"; "TRA")
	: ([Inspections:27]Insp Type:6="FCR")
		hList1:=CreateElemDictHlist("N58"; "N59"; "N60"; "N61"; "APP"; "OVR"; "TRA")
	: ([Inspections:27]Insp Type:6="CMI")
		hList1:=CreateElemDictHlist("N58"; "N59"; "N60"; "N61"; "N62"; "APP"; "OVR"; "TRA")
	: ([Inspections:27]Insp Type:6="OTH")
		hList1:=CreateElemDictHlist("N58"; "N59"; "N60"; "N61"; "N62"; "APP"; "OVR"; "TRA")
	: ([Inspections:27]Insp Type:6="CUL")
		hList1:=CreateElemDictHlist("N61"; "N62"; "APP"; "TRA")
	: ([Inspections:27]Insp Type:6="CLD")
		hList1:=CreateElemDictHlist("TRA")
	: ([Inspections:27]Insp Type:6="DAM")
		hList1:=CreateElemDictHlist("N58"; "N59"; "N60"; "N61"; "N62")
	: ([Inspections:27]Insp Type:6="DVE")
		hList1:=CreateElemDictHlist("N59"; "N60"; "N61"; "N62")
	: ([Inspections:27]Insp Type:6="DVS")
		hList1:=CreateElemDictHlist("N59"; "N60"; "N61"; "N62")
	: ([Inspections:27]Insp Type:6="DVL")
		hList1:=CreateElemDictHlist("N58"; "N59"; "N60"; "N61")
	: ([Inspections:27]Insp Type:6="RRR")
		hList1:=INSP_NewCreateElementDictHlist
		//hList1:=CreateElemDictHlist ("N58";"N59";"N60";"N61";"N62";"APP";"OVR";"GEN")
	: ([Inspections:27]Insp Type:6="RRA")
		hList1:=INSP_NewCreateElementDictHlist
	: ([Inspections:27]Insp Type:6="PED")
		hList1:=INSP_NewCreateElementDictHlist
	: ([Inspections:27]Insp Type:6="RRC")
		hList1:=INSP_NewCreateElementDictHlist
	: ([Inspections:27]Insp Type:6="TAL")
		hList1:=INSP_NewCreateElementDictHlist
	: ([Inspections:27]Insp Type:6="TOV")
		hList1:=INSP_NewCreateElementDictHlist
	: (([Inspections:27]Insp Type:6="TSP") | ([Inspections:27]Insp Type:6="TDA") | ([Inspections:27]Insp Type:6="TOT"))
		$Inspections_BaseType:="TAL"
		INSP_LoadElmLabelsforReport($Inspections_BaseType)
		READ ONLY:C145([Inspection Type:31])
		QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=$Inspections_BaseType)
		hList1:=INSP_NewCreateElementDictHlist
		QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=[Inspections:27]Insp Type:6)
		
	: (([Inspections:27]Insp Type:6="RRS") | ([Inspections:27]Insp Type:6="RRF") | ([Inspections:27]Insp Type:6="RRO") | ([Inspections:27]Insp Type:6="RRD"))
		C_TEXT:C284($Inspections_BaseType)
		C_BOOLEAN:C305($SelectType_b)
		$Inspections_BaseType:=[Inspections:27]BaseType_s:215
		
		Case of 
			: ($Inspections_BaseType="")
				ALERT:C41("You must Select an Inspection Type to base the elements of this inspection")
				$SelectType_b:=True:C214
			: ((Records in selection:C76([ElementsSafety:29])=0) & ($Inspections_BaseType#""))
				//Allow switching base type
				C_TEXT:C284($msg_txt)
				READ ONLY:C145([Inspection Type:31])
				QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=$Inspections_BaseType)
				$msg_txt:="The Current Inspection Type on which Elements for this Inspection are based is "+[Inspection Type:31]Description:2
				$msg_txt:=$msg_txt+". Do you wish to select a new type?"
				CONFIRM:C162($msg_txt; "Select New"; "Continue")
				$SelectType_b:=(OK=1)
				
		End case 
		
		If ($SelectType_b)
			
			C_LONGINT:C283($Option_L)
			ARRAY TEXT:C222($InspTypeDesc_atxt; 3)
			$InspTypeDesc_atxt{1}:="Routine Rail/Transit"
			$InspTypeDesc_atxt{2}:="Routine Rail Arch"
			$InspTypeDesc_atxt{3}:="Routine Rail Culvert"
			ARRAY TEXT:C222($InspType_atxt; 3)
			$InspType_atxt{1}:="RRR"
			$InspType_atxt{2}:="RRA"
			$InspType_atxt{3}:="RRC"
			
			$Option_L:=G_PickFromList(->$InspTypeDesc_atxt; "Select Base Inspection Type")
			
			If ($Option_L>0)
				$Inspections_BaseType:=$InspType_atxt{$Option_L}
				[Inspections:27]BaseType_s:215:=$Inspections_BaseType
				PushChange(1; ->[Inspections:27]BaseType_s:215)
				
			End if 
			
			ARRAY TEXT:C222($InspTypeList_atxt; 0)
			ARRAY TEXT:C222($InspType_atxt; 0)
		End if 
		
		If ($Inspections_BaseType#"")
			INSP_LoadElmLabelsforReport($Inspections_BaseType)
			
			READ ONLY:C145([Inspection Type:31])
			QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=$Inspections_BaseType)
			hList1:=INSP_NewCreateElementDictHlist
			QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=[Inspections:27]Insp Type:6)
		Else 
			hList1:=New list:C375
		End if 
		
	Else 
		//otherwise make a blank list    
		hList1:=New list:C375
End case 
If (Count list items:C380(hList1)>0)
	SET CURSOR:C469(0)
	RELATE ONE:C42([Inspections:27]Insp Type:6)
	vInspTitle:=[Inspection Type:31]Description:2+" Inspection"
	//Configure elements of this inspection
	
	C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
	C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
	C_TEXT:C284($Title_txt)
	FORM GET PROPERTIES:C674([Dialogs:21]; "Inspection"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
	$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain no zoom box window:K34:1; $Title_txt; "ut_CloseCancel")
	//$FormWindow:=Open form window([Dialogs];"Inspection";(Plain no zoom box window ))
	DIALOG:C40([Dialogs:21]; "Inspection")
	CLOSE WINDOW:C154
	If (OK=1)
		
		//Reconfigure the inspection form    
		C_LONGINT:C283($i)
		SHORT_MESSAGE("Configuring Items for Inspection ....")
		If (Count list items:C380(hList2)>0)
			For ($i; 1; Size of array:C274(<>ELMTDICT_ELNum_ai))
				//Add records found on the list      
				MESSAGE:C88(Char:C90(13)+"Checking Elmt "+String:C10($i)+" of "+String:C10(Size of array:C274(<>ELMTDICT_ELNum_ai))+" ...")
				If ((List item position:C629(hList2; <>ELMTDICT_ELNum_ai{$i})#0) & (Find in array:C230($vaSafetyElem; <>ELMTDICT_ELNum_ai{$i})<0))
					MESSAGE:C88("Adding..")
					CREATE RECORD:C68([ElementsSafety:29])
					Inc_Sequence("ElementsSafety"; ->[ElementsSafety:29]ElmSafetyID:7)
					[ElementsSafety:29]InspID:4:=[Inspections:27]InspID:2
					[ElementsSafety:29]ElementNo:1:=<>ELMTDICT_ELNum_ai{$i}
					[ElementsSafety:29]Rating:2:="N"
					[ElementsSafety:29]AltRating:21:="N"  //Sep-2001 : made this default to 9 same as above ground rating
					[ElementsSafety:29]Deficiency:3:="N"
					[ElementsSafety:29]Weld Condition:10:="N"
					[ElementsSafety:29]Description:22:=<>ELMTDICT_Txt_as{$i}  //Copy the standard definition over ASL 11/13/2001
					LogNewRecord(->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2; "ElementsSafety")
					InitChangeStack(2)
					PushChange(2; ->[ElementsSafety:29]ElementNo:1)
					If ([Inspections:27]Insp Type:6#"DV@")
						//not needed for UW inspections            
						PushChange(2; ->[ElementsSafety:29]Rating:2)
					End if 
					PushChange(2; ->[ElementsSafety:29]AltRating:21)
					PushChange(2; ->[ElementsSafety:29]Deficiency:3)
					PushChange(2; ->[ElementsSafety:29]Description:22)
					PushChange(2; ->[ElementsSafety:29]Weld Condition:10)
					FlushGrpChgs(2; ->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2)
					SAVE RECORD:C53([ElementsSafety:29])
				End if 
			End for 
		End if   //if count list items >0
		//Delete records not found on the list
		InitGrpDelete
		For ($i; 1; Size of array:C274($vaSafetyElem))
			MESSAGE:C88(Char:C90(13)+"Checking old Elmt "+String:C10($i)+" of "+String:C10(Size of array:C274($vaSafetyElem))+" ...")
			If (List item position:C629(hList2; $vaSafetyElem{$i})=0)
				QUERY:C277([ElementsSafety:29]; [ElementsSafety:29]ElmSafetyID:7=$vaSafetyElemId{$i})
				If (Records in selection:C76([ElementsSafety:29])>0)
					MESSAGE:C88("Deleting..")
					PushGrpDelete(->[ElementsSafety:29]ElmSafetyID:7)
					DELETE RECORD:C58([ElementsSafety:29])
				End if 
			End if 
		End for 
		FlushGrpDeletions(->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2)
		CLOSE WINDOW:C154
		
	End if 
Else 
	ALERT:C41("Could not load a defined list of configurable Inspection Elements for current Inspection Type "+[Inspection Type:31]Description:2+" !!")
End if 

//Clear the hlists
CLEAR LIST:C377(hList1; *)
If (Is a list:C621(hList2))
	CLEAR LIST:C377(hList2; *)
End if 