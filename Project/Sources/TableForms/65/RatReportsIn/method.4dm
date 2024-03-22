If (False:C215)
	//LO: [RatingReports];"RatReportsIn"
	//
	// Modified 23-10-2000 :
	//       Update Inv and Oper Loads in the Bridge MHD NBIS table
	// Apr-2002 : 
	//     Add code to alow transfer of rating report data to districts.
	
	// Modified by: costasmanousakis-(Designer)-(4/20/2006 09:15:29)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(8/17/10 13:48:35)
	Mods_2010_08
	//  `ignore Operating Ratings for Masonrty Arch-Deck
	// Modified by: costasmanousakis-(Designer)-(9/1/10 12:13:46)
	Mods_2010_09
	//  `Added Recording of Items 67.68.69.70 when changed by the AASHTO_SuffRat method
	// Modified by: costasmanousakis-(Designer)-(10/6/10 12:35:08)
	Mods_2010_10
	//  `Made sure to check if any of the [bridge mhd nbis] fields have been modified already before
	//  `the on validate event and add them to the message display
	Mods_2011_06  // CJ Miller`06/20/11, 11:13:07      ` Type all local variables for v11
	// Modified by: costasmanousakis-(Designer)-(9/22/11 16:19:07)
	Mods_2011_09
	//  `modified form to allow horizontal growth for the rating member include form.
	Mods_2012_03  //r003 Load record interactive
	//Modified by: Charles Miller (3/27/12 11:55:46)
	// Modified by: Costas Manousakis-(Designer)-(5/20/13 14:48:31)
	Mods_2013_05
	//  `move  popup menu outside if (load) statement
	// Modified by: Costas Manousakis-(Designer)-(1/16/14 15:44:10)
	Mods_2014_01
	//  `Added query on [RatingMember] at the on load event
	// Modified by: CJMiller-(Designer)-(5/21/18 16:32:40)
	Mods_2018_05
	//  `added call to RatRep_SetUpRestrictions
	// Modified by: CJMiller-(Designer)-(10/25/18 16:32:40)
	Mods_2018_10
	//  `added single posting
	// Modified by: Costas Manousakis-(Designer)-(11/6/19 14:54:54)
	Mods_2019_11
	//  `New page 1 for SU and EV vehicles and code in on load and validate to load and save rating vehicles
End if 

Case of 
	: (Form event code:C388=On Close Detail:K2:24)
		RELATE MANY:C262([RatingReports:65])
		If (User in group:C338(Current user:C182; "Ratings and Overloads"))
			OBJECT SET ENABLED:C1123(*; "DeleteRatingBtn"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"DeleteRatingBtn")
			OBJECT SET ENABLED:C1123(*; "RatMb@"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"RatMb@")
		Else 
			OBJECT SET ENABLED:C1123(*; "DeleteRatingBtn"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"DeleteRatingBtn")
			OBJECT SET ENABLED:C1123(*; "RatMb@"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"RatMb@")
		End if 
		
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		If (ut_LoadRecordInteractive(->[Bridge MHD NBIS:1]))
			C_BOOLEAN:C305(vbForce0; vbNewRating)
			
			If (User in group:C338(Current user:C182; "Ratings and Overloads"))
				OBJECT SET ENABLED:C1123(*; "DeleteRatingBtn"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"DeleteRatingBtn")
				OBJECT SET ENABLED:C1123(*; "RatMb@"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"RatMb@")
			Else 
				OBJECT SET ENABLED:C1123(*; "DeleteRatingBtn"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"DeleteRatingBtn")
				OBJECT SET ENABLED:C1123(*; "RatMb@"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"RatMb@")
			End if 
			
			vbForce0:=False:C215
			vbNewRating:=False:C215
			//## Initialize transfer data
			InitChangeStack(1)  //for the Bridge MHD NBIS data
			InitChangeStack(2)  //for the rating report itself
			
			If ([RatingReports:65]RatingID:21=0)  //This is a new record
				If (User in group:C338(Current user:C182; "Ratings and Overloads"))
					vbNewRating:=True:C214
					
					[RatingReports:65]BIN:1:=[Bridge MHD NBIS:1]BIN:3
					Inc_Sequence("RatingReports"; ->[RatingReports:65]RatingID:21)
					LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[RatingReports:65]BIN:1; ->[RatingReports:65]RatingID:21; 1; "RatingReports")
					SAVE RECORD:C53([RatingReports:65])
					[RatingReports:65]Item58:18:=[Bridge MHD NBIS:1]Item58:130
					[RatingReports:65]Item59:19:=[Bridge MHD NBIS:1]Item59:131
					[RatingReports:65]Item64:29:=[Bridge MHD NBIS:1]Item64:137
					[RatingReports:65]Item66:31:=[Bridge MHD NBIS:1]Item66:139
					[RatingReports:65]Item63:28:=[Bridge MHD NBIS:1]Item 63:199
					[RatingReports:65]Item65:30:=[Bridge MHD NBIS:1]Item 65:200
					[RatingReports:65]Item43inRating:17:=[Bridge MHD NBIS:1]Item43:75
					
					PushChange(2; ->[RatingReports:65]Item58:18)
					PushChange(2; ->[RatingReports:65]Item59:19)
					PushChange(2; ->[RatingReports:65]Item64:29)
					PushChange(2; ->[RatingReports:65]Item66:31)
					PushChange(2; ->[RatingReports:65]Item63:28)
					PushChange(2; ->[RatingReports:65]Item65:30)
					PushChange(2; ->[RatingReports:65]Item43inRating:17)
				Else 
					CANCEL:C270  //Don't allow others to create new record
				End if 
				
			End if 
		Else 
			
		End if 
		RatRep_SetUpRestrictions
		item43a:=Substring:C12([RatingReports:65]Item43inRating:17; 1; 1)
		POPUPMENUC(->aItem43aDes; ->aItem43a; ->item43a)
		item43b:=Substring:C12([RatingReports:65]Item43inRating:17; 2; 2)
		POPUPMENUC(->aItem43bDes; ->aItem43b; ->item43b)
		C_TEXT:C284(vsInvRtgUnit)  // old C_STRING length 8
		C_TEXT:C284(vsOprRtgUnit)  // old C_STRING length 8
		
		RtgMethod_OM(Form event code:C388; ->aIRatMethD_; ->aIRatMeth_; ->[RatingReports:65]Item65:30; ->[Bridge MHD NBIS:1]Item 65:200; \
			->[RatingReports:65]Item66:31; ->[Bridge MHD NBIS:1]Item66:139; ->vsInvRtgUnit)
		RtgMethod_OM(Form event code:C388; ->aORatMethD_; ->aORatMeth_; ->[RatingReports:65]Item63:28; ->[Bridge MHD NBIS:1]Item 63:199; \
			->[RatingReports:65]Item64:29; ->[Bridge MHD NBIS:1]Item64:137; ->vsOprRtgUnit)
		
		QUERY:C277([RatingMember:66]; [RatingMember:66]RatingID:1=[RatingReports:65]RatingID:21)
		
		//get rating vehicles
		RatRep_LoadVehFormVariables
		
	: (Form event code:C388=On Validate:K2:3)
		
		//##Save changes made to table
		
		If ([RatingReports:65]Item43inRating:17#"811")  //ignore Operating Ratings for Masonrty Arch-Deck
			If (([RatingReports:65]Item64:29=0) & (vbForce0=False:C215))
				Case of 
					: ([RatingReports:65]OprMS18:23#0)
						[RatingReports:65]Item64:29:=[RatingReports:65]OprMS18:23
						[RatingReports:65]Item63:28:="1"
						PushChange(2; ->[RatingReports:65]Item64:29)
						PushChange(2; ->[RatingReports:65]Item63:28)
					: ([RatingReports:65]OprHS2044:13#0)
						[RatingReports:65]Item64:29:=[RatingReports:65]OprHS2044:13*0.9
						[RatingReports:65]Item63:28:="2"
						PushChange(2; ->[RatingReports:65]Item64:29)
						PushChange(2; ->[RatingReports:65]Item63:28)
					: (([RatingReports:65]OprHS2044:13=0) & ([RatingReports:65]OprMS18:23=0))
						C_REAL:C285($max)
						$max:=MaxNum([RatingReports:65]OprH20:10; [RatingReports:65]OprType3:11; [RatingReports:65]Opr3S2:12)
						Case of 
							: ($max=[RatingReports:65]OprH20:10)
								[RatingReports:65]Item64:29:=$max*1.25*0.9
							: ($max=[RatingReports:65]OprType3:11)
								[RatingReports:65]Item64:29:=$max*1*0.9
							: ($max=[RatingReports:65]Opr3S2:12)
								[RatingReports:65]Item64:29:=$max*0.7*0.9
						End case 
						[RatingReports:65]Item63:28:="2"
						PushChange(2; ->[RatingReports:65]Item64:29)
						PushChange(2; ->[RatingReports:65]Item63:28)
				End case 
			End if 
			
		End if 
		
		If (([RatingReports:65]Item66:31=0) & (vbForce0=False:C215))
			Case of 
				: ([RatingReports:65]InvMS18:22#0)
					[RatingReports:65]Item66:31:=[RatingReports:65]InvMS18:22
					[RatingReports:65]Item65:30:="1"
					PushChange(2; ->[RatingReports:65]Item66:31)
					PushChange(2; ->[RatingReports:65]Item65:30)
				: ([RatingReports:65]InvHS2044:9#0)
					[RatingReports:65]Item66:31:=[RatingReports:65]InvHS2044:9*0.9
					[RatingReports:65]Item65:30:="2"
					PushChange(2; ->[RatingReports:65]Item66:31)
					PushChange(2; ->[RatingReports:65]Item65:30)
				: (([RatingReports:65]InvHS2044:9=0) & ([RatingReports:65]InvMS18:22=0))
					$max:=MaxNum([RatingReports:65]InvH20:6; [RatingReports:65]InvType3:7; [RatingReports:65]Inv3S2:8)
					Case of 
						: ($max=[RatingReports:65]InvH20:6)
							[RatingReports:65]Item66:31:=$max*1.25*0.9
						: ($max=[RatingReports:65]InvType3:7)
							[RatingReports:65]Item66:31:=$max*1*0.9
						: ($max=[RatingReports:65]Inv3S2:8)
							[RatingReports:65]Item66:31:=$max*0.7*0.9
					End case 
					[RatingReports:65]Item65:30:="2"
					PushChange(2; ->[RatingReports:65]Item66:31)
					PushChange(2; ->[RatingReports:65]Item65:30)
			End case 
		End if 
		
		FlushGrpChgs(2; ->[Bridge MHD NBIS:1]BIN:3; ->[RatingReports:65]BIN:1; ->[RatingReports:65]RatingID:21; 1)
		SAVE RECORD:C53([RatingReports:65])  //AASHTO Suff calc destroys changes
		
		//save the vehicle records
		RatRep_SaveVehRecords
		
		C_TEXT:C284($MysMsg)
		C_REAL:C285($vrMax)
		C_BOOLEAN:C305($vbForceupd)
		$vbForceupd:=False:C215
		$MysMsg:=""
		//     **** added minimum to avoid loading more than 99.9 values
		$vrMax:=Round:C94(MinNum([RatingReports:65]Item64:29; 99.9); 1)
		//$vbForceupd:=(Size of array(ptr_changes{1})>0)
		If (([Bridge MHD NBIS:1]Item64:137#$vrMax) | $vbForceupd | ([Bridge MHD NBIS:1]Item64:137#Old:C35([Bridge MHD NBIS:1]Item64:137)))
			[Bridge MHD NBIS:1]Item64:137:=$vrMax
			PushChange(1; ->[Bridge MHD NBIS:1]Item64:137)
			$MysMsg:=$MysMsg+"Item 64 = "+String:C10([Bridge MHD NBIS:1]Item64:137; "##.#;-##.#;0")+<>sCR
		End if 
		If (([Bridge MHD NBIS:1]Item 63:199#[RatingReports:65]Item63:28) | $vbForceupd | ([Bridge MHD NBIS:1]Item 63:199#Old:C35([Bridge MHD NBIS:1]Item 63:199)))
			[Bridge MHD NBIS:1]Item 63:199:=[RatingReports:65]Item63:28
			PushChange(1; ->[Bridge MHD NBIS:1]Item 63:199)
			$MysMsg:=$MysMsg+"Item 63 = "+[Bridge MHD NBIS:1]Item 63:199+<>sCR
		End if 
		$vrMax:=Round:C94(MinNum([RatingReports:65]Item66:31; 99.9); 1)
		
		If (([Bridge MHD NBIS:1]Item66:139#$vrMax) | $vbForceupd | ([Bridge MHD NBIS:1]Item66:139#Old:C35([Bridge MHD NBIS:1]Item66:139)))
			[Bridge MHD NBIS:1]Item66:139:=$vrMax
			PushChange(1; ->[Bridge MHD NBIS:1]Item66:139)
			$MysMsg:=$MysMsg+"Item 66 = "+String:C10([Bridge MHD NBIS:1]Item66:139; "##.#;-##.#;0")+<>sCR
		End if 
		If (([Bridge MHD NBIS:1]Item 65:200#[RatingReports:65]Item65:30) | $vbForceupd | ([Bridge MHD NBIS:1]Item 65:200#Old:C35([Bridge MHD NBIS:1]Item 65:200)))
			[Bridge MHD NBIS:1]Item 65:200:=[RatingReports:65]Item65:30
			PushChange(1; ->[Bridge MHD NBIS:1]Item 65:200)
			$MysMsg:=$MysMsg+"Item 65 = "+[Bridge MHD NBIS:1]Item 65:200+<>sCR
		End if 
		//     **** start of 23-10-2000 modifications
		//           convert to Integer as needed    
		$vrMax:=G_RatingV2NBI([RatingReports:65]OprH20:10)
		If (([Bridge MHD NBIS:1]OprH20:15#$vrMax) | $vbForceupd | ([Bridge MHD NBIS:1]OprH20:15#Old:C35([Bridge MHD NBIS:1]OprH20:15)))
			[Bridge MHD NBIS:1]OprH20:15:=$vrMax
			PushChange(1; ->[Bridge MHD NBIS:1]OprH20:15)
			$MysMsg:=$MysMsg+"OprH20 = "+String:C10([Bridge MHD NBIS:1]OprH20:15)+<>sCR
		End if 
		$vrMax:=G_RatingV2NBI([RatingReports:65]OprType3:11)
		If (([Bridge MHD NBIS:1]OprType3:16#$vrMax) | $vbForceupd | ([Bridge MHD NBIS:1]OprType3:16#Old:C35([Bridge MHD NBIS:1]OprType3:16)))
			[Bridge MHD NBIS:1]OprType3:16:=$vrMax
			PushChange(1; ->[Bridge MHD NBIS:1]OprType3:16)
			$MysMsg:=$MysMsg+"OprType3 = "+String:C10([Bridge MHD NBIS:1]OprType3:16)+<>sCR
		End if 
		$vrMax:=G_RatingV2NBI([RatingReports:65]Opr3S2:12)
		If (([Bridge MHD NBIS:1]Opr3S2:17#$vrMax) | $vbForceupd | ([Bridge MHD NBIS:1]Opr3S2:17#Old:C35([Bridge MHD NBIS:1]Opr3S2:17)))
			[Bridge MHD NBIS:1]Opr3S2:17:=$vrMax
			PushChange(1; ->[Bridge MHD NBIS:1]Opr3S2:17)
			$MysMsg:=$MysMsg+"Opr3S2 = "+String:C10([Bridge MHD NBIS:1]Opr3S2:17)+<>sCR
		End if 
		$vrMax:=G_RatingV2NBI([RatingReports:65]OprHS2044:13)
		If (([Bridge MHD NBIS:1]OprHS:18#$vrMax) | $vbForceupd | ([Bridge MHD NBIS:1]OprHS:18#Old:C35([Bridge MHD NBIS:1]OprHS:18)))
			[Bridge MHD NBIS:1]OprHS:18:=$vrMax
			PushChange(1; ->[Bridge MHD NBIS:1]OprHS:18)
			$MysMsg:=$MysMsg+"OprHS = "+String:C10([Bridge MHD NBIS:1]OprHS:18)+<>sCR
		End if 
		$vrMax:=G_RatingV2NBI([RatingReports:65]OprMS18:23)
		If (([Bridge MHD NBIS:1]OprMS:204#$vrMax) | $vbForceupd | ([Bridge MHD NBIS:1]OprMS:204#Old:C35([Bridge MHD NBIS:1]OprMS:204)))
			[Bridge MHD NBIS:1]OprMS:204:=$vrMax
			PushChange(1; ->[Bridge MHD NBIS:1]OprMS:204)
			$MysMsg:=$MysMsg+"OprMS = "+String:C10([Bridge MHD NBIS:1]OprMS:204)+<>sCR
		End if 
		$vrMax:=G_RatingV2NBI([RatingReports:65]InvH20:6)
		If (([Bridge MHD NBIS:1]InvH20:19#$vrMax) | $vbForceupd | ([Bridge MHD NBIS:1]InvH20:19#Old:C35([Bridge MHD NBIS:1]InvH20:19)))
			[Bridge MHD NBIS:1]InvH20:19:=$vrMax
			PushChange(1; ->[Bridge MHD NBIS:1]InvH20:19)
			$MysMsg:=$MysMsg+"InvH20 = "+String:C10([Bridge MHD NBIS:1]InvH20:19)+<>sCR
		End if 
		$vrMax:=G_RatingV2NBI([RatingReports:65]InvType3:7)
		If (([Bridge MHD NBIS:1]InvType3:20#$vrMax) | $vbForceupd | ([Bridge MHD NBIS:1]InvType3:20#Old:C35([Bridge MHD NBIS:1]InvType3:20)))
			[Bridge MHD NBIS:1]InvType3:20:=$vrMax
			PushChange(1; ->[Bridge MHD NBIS:1]InvType3:20)
			$MysMsg:=$MysMsg+"InvType3 = "+String:C10([Bridge MHD NBIS:1]InvType3:20)+<>sCR
		End if 
		$vrMax:=G_RatingV2NBI([RatingReports:65]Inv3S2:8)
		If (([Bridge MHD NBIS:1]Inv3S2:21#$vrMax) | $vbForceupd | ([Bridge MHD NBIS:1]Inv3S2:21#Old:C35([Bridge MHD NBIS:1]Inv3S2:21)))
			[Bridge MHD NBIS:1]Inv3S2:21:=$vrMax
			PushChange(1; ->[Bridge MHD NBIS:1]Inv3S2:21)
			$MysMsg:=$MysMsg+"Inv3S2 = "+String:C10([Bridge MHD NBIS:1]Inv3S2:21)+<>sCR
		End if 
		$vrMax:=G_RatingV2NBI([RatingReports:65]InvHS2044:9)
		If (([Bridge MHD NBIS:1]InvHS:22#$vrMax) | $vbForceupd | ([Bridge MHD NBIS:1]InvHS:22#Old:C35([Bridge MHD NBIS:1]InvHS:22)))
			[Bridge MHD NBIS:1]InvHS:22:=$vrMax
			PushChange(1; ->[Bridge MHD NBIS:1]InvHS:22)
			$MysMsg:=$MysMsg+"InvHS = "+String:C10([Bridge MHD NBIS:1]InvHS:22)+<>sCR
		End if 
		$vrMax:=G_RatingV2NBI([RatingReports:65]InvMS18:22)
		If (([Bridge MHD NBIS:1]InvMS:203#$vrMax) | $vbForceupd | ([Bridge MHD NBIS:1]InvMS:203#Old:C35([Bridge MHD NBIS:1]InvMS:203)))
			[Bridge MHD NBIS:1]InvMS:203:=$vrMax
			PushChange(1; ->[Bridge MHD NBIS:1]InvMS:203)
			$MysMsg:=$MysMsg+"InvMS = "+String:C10([Bridge MHD NBIS:1]InvMS:203)+<>sCR
		End if 
		If (([Bridge MHD NBIS:1]DateRatReport:205#[RatingReports:65]ReportDate:4) | $vbForceupd)
			[Bridge MHD NBIS:1]DateRatReport:205:=[RatingReports:65]ReportDate:4
			PushChange(1; ->[Bridge MHD NBIS:1]DateRatReport:205)
			$MysMsg:=$MysMsg+"DateRatReport = "+String:C10([Bridge MHD NBIS:1]DateRatReport:205)+<>sCR
		End if 
		//     **** end of 23-10-2000 modifications
		$vrMax:=AASHTO_SuffRat
		If (([Bridge MHD NBIS:1]AASHTO:5#$vrMax) | $vbForceupd)
			[Bridge MHD NBIS:1]AASHTO:5:=$vrMax
			PushChange(1; ->[Bridge MHD NBIS:1]AASHTO:5)
			$MysMsg:=$MysMsg+"AASHTO = "+String:C10([Bridge MHD NBIS:1]AASHTO:5; "##.#;-##.#;0")+<>sCR
		End if 
		If (([Bridge MHD NBIS:1]Item67:142#Old:C35([Bridge MHD NBIS:1]Item67:142)) | $vbForceupd)
			PushChange(1; ->[Bridge MHD NBIS:1]Item67:142)
			$MysMsg:=$MysMsg+"item67 = "+[Bridge MHD NBIS:1]Item67:142+<>sCR
		End if 
		If (([Bridge MHD NBIS:1]Item68:143#Old:C35([Bridge MHD NBIS:1]Item68:143)) | $vbForceupd)
			PushChange(1; ->[Bridge MHD NBIS:1]Item68:143)
			$MysMsg:=$MysMsg+"item68 = "+[Bridge MHD NBIS:1]Item68:143+<>sCR
		End if 
		If (([Bridge MHD NBIS:1]Item69:144#Old:C35([Bridge MHD NBIS:1]Item69:144)) | $vbForceupd)
			PushChange(1; ->[Bridge MHD NBIS:1]Item69:144)
			$MysMsg:=$MysMsg+"item69 = "+[Bridge MHD NBIS:1]Item69:144+<>sCR
		End if 
		If (([Bridge MHD NBIS:1]Item70:140#Old:C35([Bridge MHD NBIS:1]Item70:140)) | $vbForceupd)
			PushChange(1; ->[Bridge MHD NBIS:1]Item70:140)
			$MysMsg:=$MysMsg+"item70 = "+[Bridge MHD NBIS:1]Item70:140+<>sCR
		End if 
		If ($MysMsg#"")
			$MysMsg:="Update the corresponding NBIS record with these values ?"+<>sCR+$MysMsg
			G_MyConfirm($MysMsg)
		End if 
		
		If (OK=1)
			FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
			SAVE RECORD:C53([Bridge MHD NBIS:1])
		Else 
			REJECT:C38
		End if 
		CANCEL:C270
End case 