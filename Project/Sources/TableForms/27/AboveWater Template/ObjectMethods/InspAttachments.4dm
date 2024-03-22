//Method: [Inspections];"Routine Combined".InspAttachments
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/20/21, 18:51:07
	// ----------------------------------------------------
	//Created : 
	Mods_2021_04
	// Modified by: designer (7/12/21)
	Mods_2021_07
	//  //use constants BMS Cons Transmittal and BMS Cons QA form
	// Modified by: Costas Manousakis-(Designer)-(2021-12-20)
	Mods_2021_12_bug
	//  `added help text on load
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET HELP TIP:C1181(*; OBJECT Get name:C1087(Object current:K67:2); "Manage Inspection Attachments")
	: (Form event code:C388=On Mouse Enter:K2:33)
		
	: (Form event code:C388=On Clicked:K2:4)
		COPY NAMED SELECTION:C331([Standard Photos:36]; "Standard_Photos")
		C_LONGINT:C283($l; $t; $r; $b)
		OBJECT GET COORDINATES:C663(*; OBJECT Get name:C1087(Object current:K67:2); $l; $t; $r; $b)
		
		ARRAY TEXT:C222($MenuDescriptor_atxt; 0)
		ARRAY TEXT:C222($MenuSelected_atxt; 0)
		C_TEXT:C284($menuref_txt; $Result_txt)
		
		
		C_LONGINT:C283($Count_L)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
		QUERY:C277([Standard Photos:36]; [Standard Photos:36]InspID:1=[Inspections:27]InspID:2; *)
		QUERY:C277([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS SIA)  // BMS SI&A
		
		If ($Count_L=0)
			APPEND TO ARRAY:C911($MenuDescriptor_atxt; "Load SIA Original")
			APPEND TO ARRAY:C911($MenuSelected_atxt; "Load SIA Original")
			
		Else 
			APPEND TO ARRAY:C911($MenuDescriptor_atxt; "Replace SIA Original")
			APPEND TO ARRAY:C911($MenuSelected_atxt; "Replace SIA Original")
			APPEND TO ARRAY:C911($MenuDescriptor_atxt; "View SIA Original")
			APPEND TO ARRAY:C911($MenuSelected_atxt; "View SIA Original")
			APPEND TO ARRAY:C911($MenuDescriptor_atxt; "Delete SIA Original")
			APPEND TO ARRAY:C911($MenuSelected_atxt; "Delete SIA Original")
		End if 
		QUERY:C277([Standard Photos:36]; [Standard Photos:36]InspID:1=[Inspections:27]InspID:2; *)
		QUERY:C277([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS SIA Markup)  // BMS SI&A Markup
		If ($Count_L=0)
			APPEND TO ARRAY:C911($MenuDescriptor_atxt; "Load SIA Markup")
			APPEND TO ARRAY:C911($MenuSelected_atxt; "Load SIA Markup")
			
		Else 
			APPEND TO ARRAY:C911($MenuDescriptor_atxt; "Replace SIA Markup")
			APPEND TO ARRAY:C911($MenuSelected_atxt; "Replace SIA Markup")
			APPEND TO ARRAY:C911($MenuDescriptor_atxt; "View SIA Markup")
			APPEND TO ARRAY:C911($MenuSelected_atxt; "View SIA Markup")
			APPEND TO ARRAY:C911($MenuDescriptor_atxt; "Delete SIA Markup")
			APPEND TO ARRAY:C911($MenuSelected_atxt; "Delete SIA Markup")
			
		End if 
		
		
		Case of 
				
			: ([Inspections:27]Agency:156="Mass. Highway Dept.")
			: ([Inspections:27]Agency:156="Mass. Turnpike Auth.")
			: ([Inspections:27]Agency:156="MassPort")
			: ([Inspections:27]Agency:156="MBTA")
			: ([Inspections:27]Agency:156="DCR")
			: ([Inspections:27]Agency:156="MHD Underwater Oper.")
			: ([Inspections:27]Agency:156="")
				
			Else 
				
				QUERY:C277([Standard Photos:36]; [Standard Photos:36]InspID:1=[Inspections:27]InspID:2; *)
				QUERY:C277([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Cons Transmittal)
				If ($Count_L=0)
					APPEND TO ARRAY:C911($MenuDescriptor_atxt; "Load Consultant Transmittal")
					APPEND TO ARRAY:C911($MenuSelected_atxt; "Load Consultant Transmittal")
					
				Else 
					APPEND TO ARRAY:C911($MenuDescriptor_atxt; "Replace Consultant Transmittal")
					APPEND TO ARRAY:C911($MenuSelected_atxt; "Replace Consultant Transmittal")
					APPEND TO ARRAY:C911($MenuDescriptor_atxt; "View Consultant Transmittal")
					APPEND TO ARRAY:C911($MenuSelected_atxt; "View Transmittal")
					APPEND TO ARRAY:C911($MenuDescriptor_atxt; "Delete Consultant Transmittal")
					APPEND TO ARRAY:C911($MenuSelected_atxt; "Delete Transmittal")
					
				End if 
				
				
				
				QUERY:C277([Standard Photos:36]; [Standard Photos:36]InspID:1=[Inspections:27]InspID:2; *)
				QUERY:C277([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Cons QA form)
				If ($Count_L=0)
					APPEND TO ARRAY:C911($MenuDescriptor_atxt; "Load Consultant QA Form")
					APPEND TO ARRAY:C911($MenuSelected_atxt; "Load Consultant QA Form")
					
				Else 
					APPEND TO ARRAY:C911($MenuDescriptor_atxt; "Replace Consultant QA Form")
					APPEND TO ARRAY:C911($MenuSelected_atxt; "Replace Consultant QA Form")
					APPEND TO ARRAY:C911($MenuDescriptor_atxt; "View Consultant QA Form")
					APPEND TO ARRAY:C911($MenuSelected_atxt; "View QA Form")
					APPEND TO ARRAY:C911($MenuDescriptor_atxt; "Delete Consultant QA Form")
					APPEND TO ARRAY:C911($MenuSelected_atxt; "Delete QA Form")
				End if 
				
		End case 
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If (vbInspectionLocked)
			For ($Count_L; Size of array:C274($MenuDescriptor_atxt); 1; -1)
				Case of 
					: (Position:C15("Replace"; $MenuDescriptor_atxt{$Count_L})>0)
						DELETE FROM ARRAY:C228($MenuDescriptor_atxt; $Count_L; 1)
						DELETE FROM ARRAY:C228($MenuSelected_atxt; $Count_L; 1)
						
					: (Position:C15("Delete"; $MenuDescriptor_atxt{$Count_L})>0)
						DELETE FROM ARRAY:C228($MenuDescriptor_atxt; $Count_L; 1)
						DELETE FROM ARRAY:C228($MenuSelected_atxt; $Count_L; 1)
						
					: (Position:C15("Load"; $MenuDescriptor_atxt{$Count_L})>0)
						DELETE FROM ARRAY:C228($MenuDescriptor_atxt; $Count_L; 1)
						DELETE FROM ARRAY:C228($MenuSelected_atxt; $Count_L; 1)
				End case 
			End for 
		End if 
		
		If (Size of array:C274($MenuDescriptor_atxt)>0)
			
			$menuref_txt:=MENU_BuildMenuFromArrays(->$MenuDescriptor_atxt; ->$MenuSelected_atxt; "\\")
			$Result_txt:=Dynamic pop up menu:C1006($menuref_txt; ""; ($l+$r)/2; ($t+$b)/2)
			
			Case of 
				: ($Result_txt="")
				: (Position:C15("View"; $Result_txt)>0)
					PHOTO_ViewSIAorConsultantPages($Result_txt)
				: (Position:C15("Delete"; $Result_txt)>0)
					PHOTO_DelSIAorConsultantPages($Result_txt)
					
				Else 
					PHOTO_LoadSIAorConsultantPages($Result_txt)
			End case 
			
			RELEASE MENU:C978($menuref_txt)
			
		End if 
		USE NAMED SELECTION:C332("Standard_Photos")
		CLEAR NAMED SELECTION:C333("Standard_Photos")
End case 
