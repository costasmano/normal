//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/06/05, 09:36:32
	// ----------------------------------------------------
	// Method: WKHR_Temp_LoadDescr
	// Description
	//Reads a tab-delim text file in the format of a series like :
	//SECTION XX1\r
	//SECTION TITLE)\r
	//(ITEMNO1)\t(ITEM DESC1)\r
	//(ITEMNO2)\t(ITEM DESC2)\r
	//....
	//SECTION XX2\r
	//SECTION TITLE)\r
	//(ITEMNO1)\t(ITEM DESC1)\r
	//(ITEMNO2)\t(ITEM DESC2)\r
	//....
	
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(3/12/09 11:27:59)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 11:59:48  ` ("WKHRMODS")
	//  `Use the f_trimStr function to trim the lines read, and better handle item titl  `es etc.
	//  `Add code to create the WKHR_ItemsNos_V1 list which will be used as a cross-ref  `erence tool
	// Modified by: costasmanousakis-(Designer)-(4/2/09 13:57:44)
	Mods_2009_04
	//  `Removed the addition of two blank lines at the end of each major list section
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
If (False:C215)
	C_LONGINT:C283($tabPos)
	C_TEXT:C284($ListName; $ListNosName)
	CONFIRM:C162("Do for list V0 or V1?"; "V0"; "V1")
	If (OK=1)
		$ListName:="WKHR_Items"
		$ListNosName:="WKHR_ItemsNos"
	Else 
		$ListName:="WKHR_Items_V1"
		$ListNosName:="WKHR_ItemsNos_V1"
	End if 
	
	C_TIME:C306($docREf)
	$docREf:=Open document:C264(""; Read mode:K24:5)
	If (OK=1)
		C_BLOB:C604($docblob)
		DOCUMENT TO BLOB:C525(document; $docblob)
		C_TEXT:C284($DocText; $LineText; $SecTitle; $SecItemTitle)
		C_LONGINT:C283($mode; $SectNum; $SectItmNo)  //Command Replaced was o_C_INTEGER
		$mode:=0
		$DocText:=BLOB to text:C555($docblob; $mode)
		C_BOOLEAN:C305($donewithText)
		$donewithText:=False:C215
		C_LONGINT:C283($startoffset; $NextLine)
		C_LONGINT:C283($Descr_list; $Sub_list)
		$Descr_list:=New list:C375
		Repeat 
			$Nextline:=Position:C15(<>sCR; $DocText)
			If ($Nextline>0)
				$LineText:=Substring:C12($DocText; 1; ($Nextline-1))
				$LineText:=Replace string:C233(f_TrimStr($LineText; True:C214; True:C214); <>sQU; "")
				$DocText:=Substring:C12($DocText; ($Nextline+1))
				Case of 
					: (Substring:C12($LineText; 1; 7)="SECTION")
						If (Is a list:C621($Sub_list))
							//Add two blank lines
							//APPEND TO LIST($Sub_list;(String($SectItmNo+1)+"A");($SectItmNo+1);0;True)
							//APPEND TO LIST($Sub_list;(String($SectItmNo+2)+"A");($SectItmNo+2);0;True)
							APPEND TO LIST:C376($Descr_list; $SecTitle; $SectNum; $Sub_list; True:C214)
							//CLEAR LIST($Sub_list;*)
						End if 
						$SectNum:=Num:C11(Substring:C12($Linetext; 8))
						$Nextline:=Position:C15(<>sCR; $DocText)
						$SecTitle:=Substring:C12($DocText; 1; ($Nextline-1))
						$SecTitle:=Replace string:C233(f_TrimStr($SecTitle; True:C214; True:C214); <>sQU; "")
						$DocText:=Substring:C12($DocText; ($Nextline+1))
						$Sub_list:=New list:C375
					: (Position:C15(<>sTab; $LineText)>0)
						$tabPos:=Position:C15(<>sTab; $LineText)
						$SectItmNo:=Num:C11(Substring:C12($LineText; 1; ($tabPos-1)))
						$SecItemTitle:=Substring:C12($LineText; ($tabPos+1))
						$SecItemTitle:=Replace string:C233(f_TrimStr($SecItemTitle; True:C214; True:C214); <>sQU; "")
						APPEND TO LIST:C376($Sub_list; $SecItemTitle; $SectItmNo; 0; True:C214)
						
				End case 
				
			Else 
				$donewithText:=True:C214
			End if 
			
		Until ($donewithText)
		
		If (Is a list:C621($Sub_list))
			//Add two blank lines
			//APPEND TO LIST($Sub_list;(String($SectItmNo+1)+"A");($SectItmNo+1);0;True)
			//APPEND TO LIST($Sub_list;(String($SectItmNo+2)+"A");($SectItmNo+2);0;True)
			APPEND TO LIST:C376($Descr_list; $SecTitle; $SectNum; $Sub_list; True:C214)
			//CLEAR LIST($Sub_list;*)
		End if 
		
		SAVE LIST:C384($Descr_list; $ListName)
		CLEAR LIST:C377($Descr_list; *)
		CLOSE DOCUMENT:C267($docREf)
		
	End if 
	CONFIRM:C162("Update Items-Numbers list?")
	If (OK=1)
		C_LONGINT:C283($NumRestrCat_L; $NumRestrSubItm_L; $NumRestrTot_L; $ItemStyle; $ItemIcon_L; $ItemRef_L)
		C_LONGINT:C283(AllCategories_HL; $SubList_HL)
		C_TEXT:C284($ItemTxt_txt)
		AllCategories_HL:=Load list:C383($ListName)
		C_LONGINT:C283($i; $ic)
		GET LIST PROPERTIES:C632(AllCategories_HL; $ListApp_L; $ListIcon_L; $ListHt_L; $DblClick_L)
		For ($i; 1; Count list items:C380(AllCategories_HL))
			GET LIST ITEM:C378(AllCategories_HL; $i; $ItemRef_L; $ItemTxt_txt; $SubList_HL)
			SET LIST ITEM:C385(AllCategories_HL; $ItemRef_L; String:C10($ItemRef_L); $ItemRef_L)
			//SET LIST ITEM PROPERTIES(AllCategories_HL;$ItemRef_L;False;(Bold +Italic );0)  `n  `on-enterable, boldItal; no icon
			For ($ic; 1; Count list items:C380($SubList_HL))
				GET LIST ITEM:C378($SubList_HL; $ic; $ItemRef_L; $ItemTxt_txt)
				SET LIST ITEM:C385($SubList_HL; $ItemRef_L; String:C10($ItemRef_L); $ItemRef_L)
			End for 
		End for 
		SAVE LIST:C384(AllCategories_HL; $ListNosName)
		CLEAR LIST:C377(AllCategories_HL; *)
		
	End if 
End if 
