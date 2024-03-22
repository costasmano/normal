//Method: "BinRequestDisplayandMove"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/09/17, 16:06:42
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11  //Add code to allow for moving/copying rating reports to directory structure
	//Modified by: Chuck Miller (11/14/17 16:39:12)
	// Modified by: Costas Manousakis-(Designer)-(4/30/20 19:09:36)
	Mods_2020_04
	//  `add the date and time to $NewName_ instead of using the name of the upload file.
	// Modified by: Costas Manousakis-(Designer)-(5/29/20 17:59:16)
	Mods_2020_05
	//  `enabled on Activate and on Unload events in form events 
	//  `use the PDFJS component to display pdf to avoid problems with OSX 10.13 pdf display in web areas.
	// Modified by: Costas Manousakis-(Designer)-(2022-03-28 19:11:37)
	Mods_2022_03
	//  `check if windows/mac when using ut_ReturnMountIfMounted; trim end of $Volume string 
	//  `when resizing the window use the new Horizontally centerec option of ut_ResizeWindow
	Mods_2022_04  //Change the way we identiify the Server IP address and whether we are in test or not
	//Also changed form using Production_IP to PRODSERVERIP in ut_GetSysParameter call so all use same parameter
	//Modified by: Chuck Miller (4/5/22 12:23:05)
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET TITLE:C194(*; "MatchDocName"; "")
		OBJECT SET TITLE:C194(*; "CopyFrom"; "")
		OBJECT SET TITLE:C194(*; "CopyTo"; "")
		C_TEXT:C284($BinPath_txt; $ProdIP_txt; $Volume_txt; $Path_txt; $ServerIP_txt)
		$BinPath_txt:=ut_GetSysParameter("BIN_Path"; "Boston:B-Admin:Bin Requests")
		If (Folder separator:K24:12=":")
		Else 
			$BinPath_txt:=Replace string:C233($BinPath_txt; ":"; Folder separator:K24:12)
		End if 
		C_LONGINT:C283($fW_; $fH_; $mid_; $maxr_)
		FORM GET PROPERTIES:C674(Current form name:C1298; $fW_; $fH_)
		$maxr_:=$fW_
		$mid_:=$fW_/2
		$ServerIP_txt:=ut_ReturnServerIP
		$ProdIP_txt:=ut_GetSysParameter("PRODSERVERIP"; "146.243.135.242")  //ut_GetSysParameter ("Production_IP";"146.243.135.242")
		
		C_LONGINT:C283($platform; $sysVersion; $majorOSXVer)
		//_O_PLATFORM PROPERTIES($platform; $sysVersion)
		//$majorOSXVer:=($sysVersion-(256*16))
		//$majorOSXVer:=$majorOSXVer\16
		
		$majorOSXVer:=13
		
		If (Folder separator:K24:12=":")
			
			$Volume_txt:=ut_ReturnMountIfMounted("shareddata")
		Else 
			$Volume_txt:=ut_ReturnMountIfMounted("MHD-Shared\\shareddata")
		End if 
		$Volume_txt:=f_TrimStr($Volume_txt; True:C214; True:C214)
		$Path_txt:=$Volume_txt+Folder separator:K24:12+$BinPath_txt
		If (Test path name:C476($Path_txt)=Is a folder:K24:2)
			
		Else 
			CREATE FOLDER:C475($Path_txt)
		End if 
		If ($ServerIP_txt=$ProdIP_txt)
		Else 
			CONFIRM:C162("Connected to a test server. Do you want to copy to a Testing folder or not?"; "DoTest"; "No Testing")
			
			If (Ok=1)
				
				$Path_txt:=$Path_txt+Folder separator:K24:12+"Testing"
			Else 
				
			End if 
			
			If (Test path name:C476($Path_txt)=Is a folder:K24:2)
			Else 
				CREATE FOLDER:C475($Path_txt)
			End if 
		End if 
		
		$Path_txt:=$Path_txt+Folder separator:K24:12+Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 1; 3)
		If (Test path name:C476($Path_txt)=Is a folder:K24:2)
			
		Else 
			CREATE FOLDER:C475($Path_txt)
		End if 
		C_TEXT:C284($SelectedFile_txt; $NewName_txt)
		ARRAY TEXT:C222($Files_atxt; 0)
		$SelectedFile_txt:=Select document:C905(""; ".pdf"; "Select Scanned Bin request"; Multiple files:K24:7; $Files_atxt)
		
		If (OK=1)
			ARRAY TEXT:C222($Documents_atxt; 0)
			ARRAY TEXT:C222(MatchedDocuments_atxt; 0)
			C_LONGINT:C283($Pos_L; $start_L)
			DOCUMENT LIST:C474($Path_txt; $Documents_atxt)
			SORT ARRAY:C229($Documents_atxt; <)
			$NewName_txt:="bin-req-"+Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 1; 1)+"-"+Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 2; 2)+"-"+Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 4; 3)+"-"+[Bridge MHD NBIS:1]BIN:3+"_"
			$start_L:=1
			Repeat 
				$Pos_L:=Find in array:C230($Documents_atxt; $NewName_txt+"@"; $start_L)
				If ($Pos_L>0)
					APPEND TO ARRAY:C911(MatchedDocuments_atxt; $Documents_atxt{$Pos_L})
					$start_L:=$Pos_L+1
				End if 
			Until ($Pos_L<=0)
			
			//$Pos_L:=Find in array($Documents_atxt;$NewName_txt+"@")
			$Path_txt:=$Path_txt+Folder separator:K24:12
			
			WA OPEN URL:C1020(*; "NewBinRequest"; $Files_atxt{1})
			
			OBJECT SET VISIBLE:C603(*; "Existing@"; (Size of array:C274(MatchedDocuments_atxt)>0))
			OBJECT SET TITLE:C194(*; "CopyFrom"; $Files_atxt{1})
			OBJECT SET TITLE:C194(*; "CopyTo"; $Path_txt+$NewName_txt+\
				Replace string:C233(Replace string:C233(Replace string:C233(String:C10(Current date:C33; ISO date:K1:8; Current time:C178); "-"; ""); "T"; ""); ":"; "")+\
				".pdf")
			
			If (Size of array:C274(MatchedDocuments_atxt)>0)
				OBJECT SET TITLE:C194(*; "ExistingDocName"; MatchedDocuments_atxt{1})
				
				ut_ResizeWindow(Current form window:C827; $maxr_; $fH_; Horizontally centered:K39:1)
				
				WA OPEN URL:C1020(*; "ExistingBinRequest"; $Path_txt+MatchedDocuments_atxt{1})
				
				MatchedDocuments_atxt:=1
				MatchedDocuments_atxt{0}:=$Path_txt
			Else 
				
				ut_ResizeWindow(Current form window:C827; $mid_; $fH_; Horizontally centered:K39:1)
				
			End if 
		Else 
			CANCEL:C270
		End if 
		
	: (Form event code:C388=On Activate:K2:9)
		
		If (False:C215)
			C_LONGINT:C283($lWindow)
			$lWindow:=Open form window:C675("PDF_Display_Helper"; Toolbar form window:K39:16)
			DIALOG:C40("PDF_Display_Helper")
			CLOSE WINDOW:C154($lWindow)
			
		End if 
		
	: (Form event code:C388=On Unload:K2:2)
		PDFViewer_CleanAll
End case 

//End RatingReportDisplayandMove