//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/25/07, 20:54:58
	// ----------------------------------------------------
	// Method: PRJ_BD_BrgDSht_OM
	// Description
	// Object method for the Bridge Data Sheet HList Pulldown menu
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_DataSheet
	Mods_2009_03  //CJM  r001   `03/06/09, 14:42:37`Upgrade from open form window to open window
	// Modified by: costasmanousakis-(Designer)-(6/9/11 08:30:54)
	Mods_2011_06
	//  `Changed ut_LoadRecord to ut_LoadRecordInteractive; fixed call to LogNewRecord, the sequence name was missing!!
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($ListItemSelected_L; $ListRef_L; $TempWindow)
		C_TEXT:C284($ListText_txt)
		$ListItemSelected_L:=Selected list items:C379(PRJ_BD_BrgDataSht_hL)
		GET LIST ITEM:C378(PRJ_BD_BrgDataSht_hL; $ListItemSelected_L; $ListRef_L; $ListText_txt)
		Case of 
			: ($ListRef_L>0)
				//Its a data sheet record
				SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
				QUERY:C277([Bridge Design:75]; [Bridge Design:75]BridgeDesignID:35=$ListRef_L)
				If (Records in selection:C76([Bridge Design:75])=1)
					InitProcessVar
					C_BOOLEAN:C305($Proceed_b)
					$Proceed_b:=True:C214
					QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Bridge Design:75]BIN:1)
					If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
						If (ut_LoadRecord(->[Bridge MHD NBIS:1]))
						Else 
							ALERT:C41("Cannot load related Bridge Design (DES) Record. Entries in the data s"+"heet will not"+" be saved!!")
							$Proceed_b:=False:C215
						End if 
					Else 
						UNLOAD RECORD:C212([Bridge MHD NBIS:1])
						READ ONLY:C145([Bridge MHD NBIS:1])
						LOAD RECORD:C52([Bridge MHD NBIS:1])
					End if 
					If ($Proceed_b)
						If (ut_LoadRecord(->[Bridge Design:75]))
							FORM SET INPUT:C55([Bridge Design:75]; "Bridge Design In")
							
							C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
							C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
							C_TEXT:C284($Title_txt)
							FORM GET PROPERTIES:C674([Bridge Design:75]; "Bridge Design In"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
							$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
							//$TempWindow:=Open form window([Bridge Design];"Bridge Design In")
							MODIFY RECORD:C57([Bridge Design:75])
							CLOSE WINDOW:C154($Win_l)
							UNLOAD RECORD:C212([Bridge Design:75])
							UNLOAD RECORD:C212([Bridge MHD NBIS:1])
							READ ONLY:C145([Bridge Design:75])
							READ ONLY:C145([Bridge MHD NBIS:1])
							
						Else 
							ALERT:C41("Cannot load Bridge Data Sheet Record!")
						End if 
					End if 
				Else 
					ALERT:C41("Data Sheet ID :"+String:C10($ListRef_L)+" for BIN: "+$ListText_txt+" not Found!!")
				End if 
				SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
				
			: ($ListRef_L<-100)
				//Add a bridge des record for the selected BIN
				SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
				C_TEXT:C284($BIN)  // Command Replaced was o_C_STRING length was 3
				$BIN:=Substring:C12($ListText_txt; (Length:C16($ListText_txt)-2))  //BIN the last 3 chars of the ref
				QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BIN)
				If (Records in selection:C76([Bridge MHD NBIS:1])=1)
					C_BOOLEAN:C305($Proceed_b)
					$Proceed_b:=True:C214
					If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
						If (ut_LoadRecordInteractive(->[Bridge MHD NBIS:1]))
						Else 
							ALERT:C41("Cannot load related Bridge Design (DES) Record. Entries in the data s"+"heet will not"+" be saved!!")
							$Proceed_b:=False:C215
						End if 
					Else 
						UNLOAD RECORD:C212([Bridge MHD NBIS:1])
						READ ONLY:C145([Bridge MHD NBIS:1])
						LOAD RECORD:C52([Bridge MHD NBIS:1])
					End if 
					If ($Proceed_b)
						CONFIRM:C162("Create Bridge Data Sheet for BIN : "+$BIN+" ?"; "Create"; "Cancel")
						If (OK=1)
							//First store some data
							READ WRITE:C146([Bridge Design:75])
							CREATE RECORD:C68([Bridge Design:75])
							[Bridge Design:75]BIN:1:=$BIN
							[Bridge Design:75]PROJIS:2:=String:C10([PRJ_ProjectFile:117]PF_FileNumber_l:3)
							[Bridge Design:75]Designer:5:=PRJ_ConsultantName_txt
							[Bridge Design:75]ContractNumber:33:=String:C10([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)
							[Bridge Design:75]ADVDate:4:=[PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5
							[Bridge Design:75]FAPNumber:3:=[PRJ_ProjectDetails:115]PRJ_FederalAid_s:25
							Inc_Sequence("BrDesign"; ->[Bridge Design:75]BridgeDesignID:35)
							SAVE RECORD:C53([Bridge Design:75])
							LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[Bridge Design:75]BIN:1; ->[Bridge Design:75]BridgeDesignID:35; 1; "BrDesign")
							InitChangeStack(1)
							PushChange(1; ->[Bridge Design:75]PROJIS:2)
							PushChange(1; ->[Bridge Design:75]Designer:5)
							PushChange(1; ->[Bridge Design:75]ContractNumber:33)
							PushChange(1; ->[Bridge Design:75]ADVDate:4)
							PushChange(1; ->[Bridge Design:75]FAPNumber:3)
							FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge Design:75]BIN:1; ->[Bridge Design:75]BridgeDesignID:35; 1)
							InitProcessVar
							FORM SET INPUT:C55([Bridge Design:75]; "Bridge Design In")
							
							C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
							C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
							C_TEXT:C284($Title_txt)
							FORM GET PROPERTIES:C674([Bridge Design:75]; "Bridge Design In"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
							$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
							//$TempWindow:=Open form window([Bridge Design];"Bridge Design In")
							MODIFY RECORD:C57([Bridge Design:75])
							UNLOAD RECORD:C212([Bridge Design:75])
							UNLOAD RECORD:C212([Bridge MHD NBIS:1])
							CLOSE WINDOW:C154($Win_l)
							PRJ_BD_BuildBrgDataShtList  //redo the list
							
						End if 
					End if 
					
				Else 
					ALERT:C41("BAD BIN :"+$BIN+" !!!!")
				End if 
				
				SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
			Else 
				//nothing
		End case 
		
End case 

