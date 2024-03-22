//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/23/10, 15:57:39
	// ----------------------------------------------------
	// Method: CRTG_ReviewLBControl
	// Description
	//  ` method to control the listbox  shown by the CRTG_ShowListbox method
	// 
	// Parameters
	// $1 : $Task_txt ("LOAD" | "SAVE" | "INIT" | "CLEAR" )
	// ----------------------------------------------------
	
	Mods_2010_09
End if 

C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
Case of 
	: ($Task_txt="INIT")
		C_LONGINT:C283($ArraySize)
		If (Count parameters:C259>1)
			C_LONGINT:C283($2)
			$ArraySize:=$2
		End if 
		
		ARRAY BOOLEAN:C223(CRTG_Listbox_LB; 0)
		ARRAY LONGINT:C221(CRTG_Here_aL; $ArraySize)  //
		ARRAY LONGINT:C221(CRTG_RecID_aL; $ArraySize)
		ARRAY LONGINT:C221(CRTG_RecNumbers_aL; $ArraySize)
		//Data arrays
		ARRAY TEXT:C222(CRTG_Consult_atxt; $ArraySize)  //
		ARRAY TEXT:C222(CRTG_Here_atxt; $ArraySize)  //
		ARRAY TEXT:C222(CRTG_BridgeNoBIN_atxt; $ArraySize)  //
		ARRAY TEXT:C222(CRTG_BridgeNo_atxt; $ArraySize)  //
		ARRAY TEXT:C222(CRTG_Color_1_atxt; $ArraySize)  //
		ARRAY TEXT:C222(CRTG_BridgeType_atxt; $ArraySize)  //
		ARRAY DATE:C224(CRTG_MostRecent_ad; $ArraySize)  //
		ARRAY DATE:C224(CRTG_Recv1_ad; $ArraySize)  //
		ARRAY DATE:C224(CRTG_Ret1_ad; $ArraySize)  //
		ARRAY DATE:C224(CRTG_Recv2_ad; $ArraySize)  //
		ARRAY DATE:C224(CRTG_Ret2_ad; $ArraySize)  //
		ARRAY DATE:C224(CRTG_Recv3_ad; $ArraySize)  //
		ARRAY DATE:C224(CRTG_Ret3_ad; $ArraySize)  //
		ARRAY DATE:C224(CRTG_Recv4_ad; $ArraySize)  //
		ARRAY DATE:C224(CRTG_Ret4_ad; $ArraySize)  //
		ARRAY DATE:C224(CRTG_Processed_ad; $ArraySize)  //
		ARRAY DATE:C224(CRTG_ReportDate_ad; $ArraySize)  //
		//Display arrays
		ARRAY TEXT:C222(CRTG_MostRecent_atxt; $ArraySize)
		ARRAY TEXT:C222(CRTG_Recv1_atxt; $ArraySize)
		ARRAY TEXT:C222(CRTG_Ret1_atxt; $ArraySize)
		ARRAY TEXT:C222(CRTG_Recv2_atxt; $ArraySize)
		ARRAY TEXT:C222(CRTG_Ret2_atxt; $ArraySize)
		ARRAY TEXT:C222(CRTG_Recv3_atxt; $ArraySize)
		ARRAY TEXT:C222(CRTG_Ret3_atxt; $ArraySize)
		ARRAY TEXT:C222(CRTG_Recv4_atxt; $ArraySize)
		ARRAY TEXT:C222(CRTG_Ret4_atxt; $ArraySize)
		ARRAY TEXT:C222(CRTG_Processed_atxt; $ArraySize)
		ARRAY TEXT:C222(CRTG_ReportDate_atxt; $ArraySize)
		
		ARRAY POINTER:C280(CRTG_FLDS_aptr; 20)
		ARRAY POINTER:C280(CRTG_Arrays_aptr; 20)
		C_LONGINT:C283($L)
		$L:=1
		CRTG_FLDS_aptr{1}:=->[Conslt Rating:63]ConsltRatingID:42
		CRTG_Arrays_aptr{1}:=->CRTG_RecID_aL
		$L:=$L+1
		CRTG_FLDS_aptr{$L}:=->[Conslt Rating:63]BIN:1
		CRTG_Arrays_aptr{$L}:=->CRTG_BridgeNoBIN_atxt
		$L:=$L+1
		CRTG_FLDS_aptr{$L}:=->[Conslt Rating:63]BridgeType:63
		CRTG_Arrays_aptr{$L}:=->CRTG_BridgeType_atxt
		$L:=$L+1
		CRTG_FLDS_aptr{$L}:=->[Conslt Rating:63]ReportDate:64
		CRTG_Arrays_aptr{$L}:=->CRTG_ReportDate_ad
		$L:=$L+1
		CRTG_FLDS_aptr{$L}:=->[Conslt Rating:63]NBISLetter:26
		CRTG_Arrays_aptr{$L}:=->CRTG_Processed_ad
		$L:=$L+1
		CRTG_FLDS_aptr{$L}:=->[Conslt Rating:63]AssignRatCons:5
		CRTG_Arrays_aptr{$L}:=->CRTG_Consult_atxt
		$L:=$L+1
		CRTG_FLDS_aptr{$L}:=->[Conslt Rating:63]CRtgColor:46
		CRTG_Arrays_aptr{$L}:=->CRTG_Color_1_atxt
		$L:=$L+1
		CRTG_FLDS_aptr{$L}:=->[Conslt Rating:63]SentInHouseRev1:36
		CRTG_Arrays_aptr{$L}:=->CRTG_Recv1_ad
		$L:=$L+1
		CRTG_FLDS_aptr{$L}:=->[Conslt Rating:63]SentBackToConslt1:33
		CRTG_Arrays_aptr{$L}:=->CRTG_Ret1_ad
		$L:=$L+1
		CRTG_FLDS_aptr{$L}:=->[Conslt Rating:63]SentInHouseRev2:37
		CRTG_Arrays_aptr{$L}:=->CRTG_Recv2_ad
		$L:=$L+1
		CRTG_FLDS_aptr{$L}:=->[Conslt Rating:63]SentBackToConslt2:34
		CRTG_Arrays_aptr{$L}:=->CRTG_Ret2_ad
		$L:=$L+1
		CRTG_FLDS_aptr{$L}:=->[Conslt Rating:63]SentInHouseRev3:38
		CRTG_Arrays_aptr{$L}:=->CRTG_Recv3_ad
		$L:=$L+1
		CRTG_FLDS_aptr{$L}:=->[Conslt Rating:63]SentBackToConslt3:35
		CRTG_Arrays_aptr{$L}:=->CRTG_Ret3_ad
		$L:=$L+1
		CRTG_FLDS_aptr{$L}:=->[Conslt Rating:63]SentInHouseRev4:53
		CRTG_Arrays_aptr{$L}:=->CRTG_Recv4_ad
		$L:=$L+1
		CRTG_FLDS_aptr{$L}:=->[Conslt Rating:63]SentBackToConslt4:62
		CRTG_Arrays_aptr{$L}:=->CRTG_Ret4_ad
		$L:=$L+1
		CRTG_FLDS_aptr{$L}:=->[Conslt Rating:63]
		CRTG_Arrays_aptr{$L}:=->CRTG_RecNumbers_aL
		
		ARRAY POINTER:C280(CRTG_FLDS_aptr; $L)
		ARRAY POINTER:C280(CRTG_Arrays_aptr; $L)
		
		ARRAY POINTER:C280(CRTG_SortArrays_aptr; 50)
		$L:=1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Here_aL
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_MostRecent_ad
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_BridgeNoBIN_atxt
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Consult_atxt
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_BridgeType_atxt
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Color_1_atxt
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_ReportDate_ad
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Processed_ad
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Recv1_ad
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Ret1_ad
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Recv2_ad
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Ret2_ad
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Recv3_ad
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Ret3_ad
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Recv4_ad
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Ret4_ad
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Here_atxt
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_MostRecent_atxt
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Recv1_atxt
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Ret1_atxt
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Recv2_atxt
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Ret2_atxt
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Recv3_atxt
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Ret3_atxt
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Recv4_atxt
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Ret4_atxt
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_Processed_atxt
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_ReportDate_atxt
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_RecNumbers_aL
		$L:=$L+1
		CRTG_SortArrays_aptr{$L}:=->CRTG_RecID_aL
		ARRAY POINTER:C280(CRTG_SortArrays_aptr; $L)
		ARRAY LONGINT:C221(CRTG_SortOrder_aL; $L)
		
	: ($Task_txt="LOAD")
		C_LONGINT:C283(CRTG_NumberofRecs_L)
		CRTG_NumberofRecs_L:=Records in selection:C76([Conslt Rating:63])
		CRTG_ReviewLBControl("INIT"; CRTG_NumberofRecs_L)
		C_LONGINT:C283($loop_L)
		SHORT_MESSAGE("Please Wait.. Loading...")
		SELECTION TO ARRAY:C260([Conslt Rating:63]BIN:1; CRTG_BridgeNoBIN_atxt; [Bridge MHD NBIS:1]BDEPT:1; CRTG_BridgeNo_atxt)
		For ($loop_L; 1; Size of array:C274(CRTG_Arrays_aptr))
			SELECTION TO ARRAY:C260(CRTG_FLDS_aptr{$loop_L}->; CRTG_Arrays_aptr{$loop_L}->)
		End for 
		MESSAGE:C88(<>sCR+"Please Wait.. Calculating...")
		READ ONLY:C145([Bridge MHD NBIS:1])
		For ($loop_L; 1; Size of array:C274(CRTG_BridgeNoBIN_atxt))
			CRTG_ReviewLBControl("MAKETOTEXT"; $loop_L)
		End for 
		CLOSE WINDOW:C154
		SET WINDOW TITLE:C213("Rating Report Review Screen ["+String:C10(CRTG_NumberofRecs_L)+" Reports]")
		
	: ($Task_txt="SORT")
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(CRTG_SortOrder_aL))
			CRTG_SortOrder_aL{$loop_L}:=0
		End for 
		
		CRTG_SortOrder_aL{1}:=1
		CRTG_SortOrder_aL{2}:=-1
		CRTG_SortOrder_aL{3}:=1
		MULTI SORT ARRAY:C718(CRTG_SortArrays_aptr; CRTG_SortOrder_aL)
		CREATE SELECTION FROM ARRAY:C640([Conslt Rating:63]; CRTG_RecNumbers_aL)
		
	: ($Task_txt="SAVE")
	: ($Task_txt="OPENRTG")
		
		C_LONGINT:C283($Column_L; $RecToOpen_L)
		LISTBOX GET CELL POSITION:C971(*; "CRTG_Listbox_LB"; $Column_L; $RecToOpen_L)
		//$RecToOpen_L:=Find in array(CRTG_Listbox_LB;True)
		If ($RecToOpen_L>0) & ($RecToOpen_L<=CRTG_RecNumbers_aL)
			READ WRITE:C146([Conslt Rating:63])
			READ WRITE:C146([Conslt Rating Cost:74])
			GOTO RECORD:C242([Conslt Rating:63]; CRTG_RecNumbers_aL{$RecToOpen_L})
			If (ut_LoadRecordInteractive(->[Conslt Rating:63]))
				FORM SET INPUT:C55([Conslt Rating:63]; "Cslt Rating In")
				MODIFY RECORD:C57([Conslt Rating:63])
				CRTG_ReviewLBControl("UPDATERECDISPLAY"; $RecToOpen_L)
			Else 
				UNLOAD RECORD:C212([Conslt Rating:63])
				READ ONLY:C145([Conslt Rating:63])
				READ ONLY:C145([Conslt Rating Cost:74])
				LOAD RECORD:C52([Conslt Rating:63])
				DIALOG:C40([Conslt Rating:63]; "Cslt Rating In")
				//MODIFY RECORD([Conslt Rating])
			End if 
			
			UNLOAD RECORD:C212([Conslt Rating:63])
			UNLOAD RECORD:C212([Conslt Rating Cost:74])
			
		End if 
		
	: ($Task_txt="UPDATERECDISPLAY")
		C_LONGINT:C283($2; $RecToOpen_L; $TblNum_L; $FldNum_L)
		C_TEXT:C284($vname_txt)
		$RecToOpen_L:=$2
		C_POINTER:C301($Fld_ptr; $Arr_ptr)
		For ($loop_L; 1; Size of array:C274(CRTG_Arrays_aptr))
			$Fld_ptr:=CRTG_FLDS_aptr{$loop_L}
			$Arr_ptr:=CRTG_Arrays_aptr{$loop_L}
			RESOLVE POINTER:C394(CRTG_FLDS_aptr{$loop_L}; $vname_txt; $TblNum_L; $FldNum_L)
			If ($FldNum_L>0)
				$Arr_ptr->{$RecToOpen_L}:=$Fld_ptr->
			End if 
			
		End for 
		CRTG_ReviewLBControl("MAKETOTEXT"; $RecToOpen_L)
		
	: ($Task_txt="MAKETOTEXT")
		C_LONGINT:C283($2; $loop_L)
		$loop_L:=$2
		//QUERY([Bridge MHD NBIS];[Bridge MHD NBIS]BIN=CRTG_BridgeNoBIN_atxt{$loop_L})
		//CRTG_BridgeNoBIN_atxt{$loop_L}:=[Bridge MHD NBIS]BDEPT+CRTG_BridgeNoBIN_atxt{$loop_L}
		CRTG_BridgeNoBIN_atxt{$loop_L}:=CRTG_BridgeNo_atxt{$loop_L}+CRTG_BridgeNoBIN_atxt{$loop_L}
		CRTG_Color_1_atxt{$loop_L}:=Substring:C12(CRTG_Color_1_atxt{$loop_L}; 1; 1)
		
		//CRTG_Recv1_atxt{$loop_L}:=f_Date2String (CRTG_Recv1_ad{$loop_L};Internal date short ;"")
		//CRTG_Ret1_atxt{$loop_L}:=f_Date2String (CRTG_Ret1_ad{$loop_L};Internal date short ;"")
		//CRTG_Recv2_atxt{$loop_L}:=f_Date2String (CRTG_Recv2_ad{$loop_L};Internal date short ;"")
		//CRTG_Ret2_atxt{$loop_L}:=f_Date2String (CRTG_Ret2_ad{$loop_L};Internal date short ;"")
		//CRTG_Recv3_atxt{$loop_L}:=f_Date2String (CRTG_Recv3_ad{$loop_L};Internal date short ;"")
		//CRTG_Ret3_atxt{$loop_L}:=f_Date2String (CRTG_Ret3_ad{$loop_L};Internal date short ;"")
		//CRTG_Recv4_atxt{$loop_L}:=f_Date2String (CRTG_Recv4_ad{$loop_L};Internal date short ;"")
		//CRTG_Ret4_atxt{$loop_L}:=f_Date2String (CRTG_Ret4_ad{$loop_L};Internal date short ;"")
		//
		//CRTG_Processed_atxt{$loop_L}:=f_Date2String (CRTG_Processed_ad{$loop_L};Internal date short ;"")
		//CRTG_ReportDate_atxt{$loop_L}:=f_Date2String (CRTG_ReportDate_ad{$loop_L};Internal date short ;"")
		
		If (True:C214)
			CRTG_MostRecent_ad{$loop_L}:=!00-00-00!
			CRTG_Here_atxt{$loop_L}:="?"
			CRTG_Here_aL{$loop_L}:=4
			Case of 
				: (CRTG_Processed_ad{$loop_L}>!00-00-00!)
					CRTG_MostRecent_ad{$loop_L}:=CRTG_Processed_ad{$loop_L}
					CRTG_Here_atxt{$loop_L}:="A"
				: (CRTG_Ret4_ad{$loop_L}>!00-00-00!)
					CRTG_MostRecent_ad{$loop_L}:=CRTG_Ret4_ad{$loop_L}
					CRTG_Here_atxt{$loop_L}:="N"
				: (CRTG_Recv4_ad{$loop_L}>!00-00-00!)
					CRTG_MostRecent_ad{$loop_L}:=CRTG_Recv4_ad{$loop_L}
					CRTG_Here_atxt{$loop_L}:="Y"
				: (CRTG_Ret3_ad{$loop_L}>!00-00-00!)
					CRTG_MostRecent_ad{$loop_L}:=CRTG_Ret3_ad{$loop_L}
					CRTG_Here_atxt{$loop_L}:="N"
				: (CRTG_Recv3_ad{$loop_L}>!00-00-00!)
					CRTG_MostRecent_ad{$loop_L}:=CRTG_Recv3_ad{$loop_L}
					CRTG_Here_atxt{$loop_L}:="Y"
				: (CRTG_Ret2_ad{$loop_L}>!00-00-00!)
					CRTG_MostRecent_ad{$loop_L}:=CRTG_Ret2_ad{$loop_L}
					CRTG_Here_atxt{$loop_L}:="N"
				: (CRTG_Recv2_ad{$loop_L}>!00-00-00!)
					CRTG_MostRecent_ad{$loop_L}:=CRTG_Recv2_ad{$loop_L}
					CRTG_Here_atxt{$loop_L}:="Y"
				: (CRTG_Ret1_ad{$loop_L}>!00-00-00!)
					CRTG_MostRecent_ad{$loop_L}:=CRTG_Ret1_ad{$loop_L}
					CRTG_Here_atxt{$loop_L}:="N"
				: (CRTG_Recv1_ad{$loop_L}>!00-00-00!)
					CRTG_MostRecent_ad{$loop_L}:=CRTG_Recv1_ad{$loop_L}
					CRTG_Here_atxt{$loop_L}:="Y"
					
			End case 
			CRTG_Here_aL{$loop_L}:=Position:C15(CRTG_Here_atxt{$loop_L}; "YNA?")
			//CRTG_MostRecent_atxt{$loop_L}:=f_Date2String (CRTG_MostRecent_ad{$loop_L};Internal date short ;"")
			
		End if 
		
	: ($Task_txt="SHOWALL")
		QUERY:C277([Conslt Rating:63]; [Conslt Rating:63]RepSubmit1:23>!00-00-00!)
		CRTG_ReviewLBControl("LOAD")
		CRTG_ReviewLBControl("SORT")
		
	: ($Task_txt="USESET")
		C_LONGINT:C283($NumSelected_L; $Counter_L)
		C_LONGINT:C283($loop_L)
		$Counter_L:=0
		ARRAY LONGINT:C221($UserSEtIDs_aL; Size of array:C274(CRTG_Listbox_LB))
		For ($loop_L; 1; Size of array:C274(CRTG_Listbox_LB))
			
			If (CRTG_Listbox_LB{$loop_L})
				$Counter_L:=$Counter_L+1
				$UserSEtIDs_aL{$Counter_L}:=CRTG_RecID_aL{$loop_L}
			End if 
		End for 
		If ($Counter_L>0)
			ARRAY LONGINT:C221($UserSEtIDs_aL; $Counter_L)
			QUERY WITH ARRAY:C644([Conslt Rating:63]ConsltRatingID:42; $UserSEtIDs_aL)
			CRTG_ReviewLBControl("LOAD")
			CRTG_ReviewLBControl("SORT")
			
		Else 
			ALERT:C41("You have not selected any records!")
		End if 
		
	: ($Task_txt="CLEAR")
		CRTG_ReviewLBControl("INIT"; 0)
	Else 
		ALERT:C41("ERROR ! : Unknown Task passed to method "+Current method name:C684+" : "+$Task_txt)
End case 