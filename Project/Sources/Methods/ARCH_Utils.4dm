//%attributes = {"invisible":true}
// Method: Method: ARCH_Utils
// Description
// Utility method to do various tasks for Archive table when printing
// Parameters
// $1 : $Task_txt (TOWNLINE | AccessibilityPrint | RATINGS | RANK | INITRRVARS | LOADRRVARS | FILLPRINTVARIABLES )
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/18/11, 16:02:35
	// ----------------------------------------------------
	
	// First Release
	Mods_2011_10
	// Modified by: Costas Manousakis-(Designer)-(10/30/18 12:50:41)
	Mods_2018_10
	//  `Additions for Single Posting fields
	//  `added two tasks INITRRVARS  LOADRRVARS FILLPRINTVARIABLES
	
End if 
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
Case of 
	: ($Task_txt="TOWNLINE")
		C_TEXT:C284(sBDEPT; sTown)  // Command Replaced was o_C_STRING length was 80
		ARRAY TEXT:C222(aBDEPT_; 0)  //Command Replaced was o_ARRAY string length was 10
		C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
		
		QUERY:C277([TownLineInfo:73]; [TownLineInfo:73]BIN:1=[BridgeMHDNBISArchive:139]BIN:3)
		ORDER BY:C49([TownLineInfo:73]; [TownLineInfo:73]BDEPT:2; >)
		SELECTION TO ARRAY:C260([TownLineInfo:73]BDEPT:2; aBDEPT_)
		sBDEPT:=[BridgeMHDNBISArchive:139]BDEPT:1
		sTown:=[BridgeMHDNBISArchive:139]Town Name:174
		For ($i; 1; Size of array:C274(aBDEPT_))
			sBDEPT:=sBDEPT+"="+aBDEPT_{$i}
			sTown:=sTown+"="+Get_Town_Name(aBDEPT_{$i})
		End for 
		
	: ($Task_txt="AccessibilityPrint")
		C_TEXT:C284(sLift; sLadder; sBoat; sWader; sInsp50; sRigging; sStaging; sTraffic; sRR; sPolice; sAccOth)  // Command Replaced was o_C_STRING length was 1
		C_TEXT:C284(sLiftU; sLadderU; sBoatU; sWaderU; sInsp50U; sRiggingU; sStagingU; sTrafficU; sRRU; sPoliceU; sAccOthU)  // Command Replaced was o_C_STRING length was 1
		
		sLift:=Substring:C12([BridgeMHDNBISArchive:139]LiftBucket:30; 1; 1)
		sLiftU:=Substring:C12([BridgeMHDNBISArchive:139]LiftBucket:30; 2; 1)
		sLadder:=Substring:C12([BridgeMHDNBISArchive:139]Ladder:31; 1; 1)
		sLadderU:=Substring:C12([BridgeMHDNBISArchive:139]Ladder:31; 2; 1)
		sBoat:=Substring:C12([BridgeMHDNBISArchive:139]Boat:32; 1; 1)
		sBoatU:=Substring:C12([BridgeMHDNBISArchive:139]Boat:32; 2; 1)
		sWader:=Substring:C12([BridgeMHDNBISArchive:139]Wader:33; 1; 1)
		sWaderU:=Substring:C12([BridgeMHDNBISArchive:139]Wader:33; 2; 1)
		sInsp50:=Substring:C12([BridgeMHDNBISArchive:139]Inspector50:34; 1; 1)
		sInsp50U:=Substring:C12([BridgeMHDNBISArchive:139]Inspector50:34; 2; 1)
		sRigging:=Substring:C12([BridgeMHDNBISArchive:139]Rigging:35; 1; 1)
		sRiggingU:=Substring:C12([BridgeMHDNBISArchive:139]Rigging:35; 2; 1)
		sStaging:=Substring:C12([BridgeMHDNBISArchive:139]Staging:36; 1; 1)
		sStagingU:=Substring:C12([BridgeMHDNBISArchive:139]Staging:36; 2; 1)
		sTraffic:=Substring:C12([BridgeMHDNBISArchive:139]Traffic Control:37; 1; 1)
		sTrafficU:=Substring:C12([BridgeMHDNBISArchive:139]Traffic Control:37; 2; 1)
		sRR:=Substring:C12([BridgeMHDNBISArchive:139]RR Flagman:38; 1; 1)
		sRRU:=Substring:C12([BridgeMHDNBISArchive:139]RR Flagman:38; 2; 1)
		sPolice:=Substring:C12([BridgeMHDNBISArchive:139]Police:39; 1; 1)
		sPoliceU:=Substring:C12([BridgeMHDNBISArchive:139]Police:39; 2; 1)
		sAccOth:=Substring:C12([BridgeMHDNBISArchive:139]OtherAccBool:179; 1; 1)
		sAccOthU:=Substring:C12([BridgeMHDNBISArchive:139]OtherAccBool:179; 2; 1)
		
	: ($Task_txt="RATINGS")
		READ ONLY:C145([RatingReports:65])
		QUERY:C277([RatingReports:65]; [RatingReports:65]BIN:1=[BridgeMHDNBISArchive:139]BIN:3)
		QUERY SELECTION:C341([RatingReports:65]; [RatingReports:65]ReportDate:4<=[BridgeMHDNBISArchive:139]ArchiveDate_d:224)
		ORDER BY:C49([RatingReports:65]; [RatingReports:65]ReportDate:4; <)
		REDUCE SELECTION:C351([RatingReports:65]; 1)
		
		C_LONGINT:C283(vRecPostingH; vRecPost3; vRecPost3S2; vREcPostSingle)  //Command Replaced was o_C_INTEGER
		
		If (([BridgeMHDNBISArchive:139]PostingStatus:8="DESIGN") | ([BridgeMHDNBISArchive:139]PostingStatus:8="CLOSED"))
			vRecPostingH:=0
			vRecPost3:=0
			vRecPost3S2:=0
			vREcPostSingle:=0
		Else 
			vREcPostSingle:=0
			vRecPostingH:=0
			vRecPost3:=0
			vRecPost3S2:=0
			If ([RatingReports:65]RecSinglePosting_L:39>0)
				vREcPostSingle:=[RatingReports:65]RecSinglePosting_L:39
			Else 
				vRecPostingH:=[RatingReports:65]RecPostingH:14
				vRecPost3:=[RatingReports:65]RecPost3:15
				vRecPost3S2:=[RatingReports:65]RecPost3S2:16
				If ([RatingReports:65]RecSinglePosting_L:39>0)
					vREcPostSingle:=[RatingReports:65]RecSinglePosting_L:39
				Else 
					If ((vRecPostingH=vRecPost3) & (vRecPost3=vRecPost3S2))
						vREcPostSingle:=vRecPostingH
					End if 
				End if 
			End if 
		End if 
		READ WRITE:C146([RatingReports:65])
		
	: ($Task_txt="RANK")
		
		C_LONGINT:C283($FormEvent)
		If (Count parameters:C259>1)
			C_LONGINT:C283($2)
			$FormEvent:=$2
		Else 
			$FormEvent:=Form event code:C388
		End if 
		C_REAL:C285(HealthIndexPct_r)
		
		Case of 
			: (($FormEvent=On Load:K2:1) | ($FormEvent=On Printing Detail:K2:18) | ($FormEvent=On Display Detail:K2:22))
				OBJECT SET VISIBLE:C603(*; "@_Rank@"; (User in group:C338(<>CurrentUser_Name; "BridgeRankDisplay") | (<>CurrentUser_Name="Designer")))
				HealthIndexPct_r:=([BridgeMHDNBISArchive:139]HealthIndex:219*100)
		End case 
		
	: ($Task_txt="INITRRVARS")
		//declare variables
		C_REAL:C285(SIA_RRItem48_r; SIA_RRItem49_r; SIA_RRItem50A_r; SIA_RRItem50B_r; SIA_RRItem51_r; SIA_RRItem52_r; SIA_RRItem34_r)
		C_REAL:C285(SIA_RRItem10Ft_r; SIA_RRItem10In_r; SIA_RRItem47_r; SIA_RRItem53Ft_r; SIA_RRItem53In_r)
		C_REAL:C285(SIA_RRItem54Ft_r; SIA_RRItem54In_r; SIA_RRItem55_r; SIA_RRItem56_r)
		C_REAL:C285(SIA_RRItem39_r; SIA_RRItem116_r; SIA_RRItem40_r)
		C_TEXT:C284(SIA_RRItem54A_s; SIA_RRItem55A_s)  // Command Replaced was o_C_STRING length was 1
		C_LONGINT:C283(SIA_RRItem35_L; SIA_Item10Over30_L; SIA_Item53Over30_L; SIA_Item54Over30_L; SIA_Item55Over30_L; SIA_Item56Over30_L)
		C_LONGINT:C283(SIA_FTRound_L)
		SIA_FTRound_L:=5
		Case of 
			: (FORM Get current page:C276=9)
				SIA_Tabs_atxt:=1
			: (FORM Get current page:C276=10)
				SIA_Tabs_atxt:=2
			Else 
				SIA_Tabs_atxt:=0
		End case 
		
	: ($Task_txt="LOADRRVARS")
		
		If ([BridgeMHDNBISArchive:139]Item35:100)
			SIA_RRItem35_L:=1
		Else 
			SIA_RRItem35_L:=0
		End if 
		
		SIA_RRItem48_r:=Round:C94([BridgeMHDNBISArchive:139]Item48:91/0.3048; SIA_FTRound_L)
		SIA_RRItem49_r:=Round:C94([BridgeMHDNBISArchive:139]Item49:92/0.3048; SIA_FTRound_L)
		SIA_RRItem50A_r:=Round:C94([BridgeMHDNBISArchive:139]Item50A:93/0.3048; SIA_FTRound_L)
		SIA_RRItem50B_r:=Round:C94([BridgeMHDNBISArchive:139]Item50B:94/0.3048; SIA_FTRound_L)
		SIA_RRItem51_r:=Round:C94([BridgeMHDNBISArchive:139]Item51:95/0.3048; SIA_FTRound_L)
		SIA_RRItem52_r:=Round:C94([BridgeMHDNBISArchive:139]Item52:96/0.3048; SIA_FTRound_L)
		SIA_RRItem34_r:=[BridgeMHDNBISArchive:139]Item34:99
		If ([BridgeMHDNBISArchive:139]Item10:101>30)
			SIA_RRItem10Ft_r:=99
			SIA_RRItem10In_r:=99
			SIA_Item10Over30_L:=1
		Else 
			SIA_RRVariableUtil("METERS-FTIN"; ->[BridgeMHDNBISArchive:139]Item10:101; ->SIA_RRItem10Ft_r; ->SIA_RRItem10In_r)
			SIA_Item10Over30_L:=0
		End if 
		
		SIA_RRItem47_r:=Round:C94([BridgeMHDNBISArchive:139]Item47:103/0.3048; SIA_FTRound_L)
		If ([BridgeMHDNBISArchive:139]Item53:104>30)
			SIA_RRItem53Ft_r:=99
			SIA_RRItem53In_r:=99
			SIA_Item53Over30_L:=1
		Else 
			SIA_RRVariableUtil("METERS-FTIN"; ->[BridgeMHDNBISArchive:139]Item53:104; ->SIA_RRItem53Ft_r; ->SIA_RRItem53In_r)
			SIA_Item53Over30_L:=0
		End if 
		
		SIA_RRItem54A_s:=[BridgeMHDNBISArchive:139]Item54A:106
		
		SIA_RRItem55A_s:=[BridgeMHDNBISArchive:139]Item55A:109
		If ([BridgeMHDNBISArchive:139]Item54B:107>30)
			SIA_RRItem54Ft_r:=99
			SIA_RRItem54In_r:=99
			SIA_Item54Over30_L:=1
		Else 
			SIA_RRVariableUtil("METERS-FTIN"; ->[BridgeMHDNBISArchive:139]Item54B:107; ->SIA_RRItem54Ft_r; ->SIA_RRItem54In_r)
			SIA_Item54Over30_L:=0
		End if 
		
		SIA_RRItem55_r:=Round:C94([BridgeMHDNBISArchive:139]Item55B:110/0.3048; SIA_FTRound_L)
		SIA_Item55Over30_L:=0
		If ([BridgeMHDNBISArchive:139]Item55B:110>30)
			SIA_RRItem55_r:=199
			SIA_Item55Over30_L:=1
		End if 
		
		SIA_RRItem56_r:=Round:C94([BridgeMHDNBISArchive:139]Item56:111/0.3048; SIA_FTRound_L)
		SIA_Item56Over30_L:=0
		If ([BridgeMHDNBISArchive:139]Item56:111>30)
			SIA_RRItem56_r:=199
			SIA_Item56Over30_L:=1
		End if 
		
		SIA_RRItem39_r:=Round:C94([BridgeMHDNBISArchive:139]Item39:114/0.3048; SIA_FTRound_L)
		SIA_RRItem116_r:=Round:C94([BridgeMHDNBISArchive:139]Item116:115/0.3048; SIA_FTRound_L)
		SIA_RRItem40_r:=Round:C94([BridgeMHDNBISArchive:139]Item40:116/0.3048; SIA_FTRound_L)
		SIA_RRItem76_r:=Round:C94([BridgeMHDNBISArchive:139]Item76:153/0.3048; SIA_FTRound_L)
		
	: ($Task_txt="FILLPRINTVARIABLES")
		
		C_TEXT:C284(sFHWASelect; sItem12; sItem35; sItem112; sItem104; sItem103; sItem110; sItem92A; sItem92B; sItem92C; sCritInsp; \
			sClosedInsp; sUWSpInsp; sAntiM; sJointLess; sAcrow; sMissingSigns; item43a; item44a; item42a; item42b)  // old C_STRING length 1
		C_TEXT:C284(sPageof)  // old C_STRING length 20
		C_TEXT:C284(sMissingSignstext; vItem107)
		C_TEXT:C284(vItem102)  // old C_STRING length 28
		C_TEXT:C284(vItem20)  // old C_STRING length 65
		C_TEXT:C284(vItem21; vItem22)  // old C_STRING length 27
		C_TEXT:C284(vItem37)  // old C_STRING length 60
		C_TEXT:C284(vItem13)  // old C_STRING length 12
		C_TEXT:C284(vItem43a)  // old C_STRING length 30
		C_TEXT:C284(item43b; item44b)  //This must not be a local variable! ` old C_STRING length 2
		C_TEXT:C284(vItem43b; vIntegral; vItem44a; vItem44b; vItem38)  // old C_STRING length 40
		C_TEXT:C284(vItem108a; vItem108b; vItem108c)  // old C_STRING length 26
		C_TEXT:C284(vItem42a; vItem42b)  // old C_STRING length 24
		C_TEXT:C284(vItem33)  // old C_STRING length 42
		C_TEXT:C284(vItem31)  // old C_STRING length 19
		C_TEXT:C284(vItem63; vItem65)  // old C_STRING length 50
		C_TEXT:C284(vItem41)  // old C_STRING length 32
		C_TEXT:C284(vItem26)  // old C_STRING length 23
		
		If ((vPgs*vPgf)=0)
			sPageof:=""
		Else 
			sPageof:="Page "+String:C10(vPgs)+" of "+String:C10(vPgf)
		End if 
		vDate:=Current date:C33(*)
		
		sFHWASelect:=f_Boolean2String([BridgeMHDNBISArchive:139]FHWA Select:4; "YN")
		sItem12:=f_Boolean2String([BridgeMHDNBISArchive:139]Item12:193; "YN")
		sItem35:=f_Boolean2String([BridgeMHDNBISArchive:139]Item35:100; "YN")
		sItem112:=f_Boolean2String([BridgeMHDNBISArchive:139]Item112:117; "YN")
		sItem104:=f_Boolean2String([BridgeMHDNBISArchive:139]Item104:118; "YN")
		sItem103:=f_Boolean2String([BridgeMHDNBISArchive:139]Item103:123; "YN")
		sItem110:=f_Boolean2String([BridgeMHDNBISArchive:139]Item110:124; "YN")
		sItem92A:=f_Boolean2String([BridgeMHDNBISArchive:139]Item92AA:162; "YN")
		sItem92B:=f_Boolean2String([BridgeMHDNBISArchive:139]Item92BA:164; "YN")
		sItem92C:=f_Boolean2String([BridgeMHDNBISArchive:139]Item92CA:166; "YN")
		sCritInsp:=f_Boolean2String([BridgeMHDNBISArchive:139]OtherInsp:42; "YN")
		sClosedInsp:=f_Boolean2String([BridgeMHDNBISArchive:139]ClosedInsp:45; "YN")
		sUWSpInsp:=f_Boolean2String([BridgeMHDNBISArchive:139]UWSpInsp:209; "YN")
		sAntiM:=f_Boolean2String([BridgeMHDNBISArchive:139]AntiMissile:26; "YN")
		sJointLess:=f_Boolean2String([BridgeMHDNBISArchive:139]JointlessBridge:175; "YN")
		sAcrow:=f_Boolean2String([BridgeMHDNBISArchive:139]Acrow Panel:28; "YN")
		sMissingSignstext:=[BridgeMHDNBISArchive:139]MissSignsDesc:221
		sMissingSigns:=f_Boolean2String([BridgeMHDNBISArchive:139]MissSigns:220; "YN")
		vItem102:=Get_Description(-><>aDirection; -><>aDirCode; ->[BridgeMHDNBISArchive:139]Item102:122)
		vItem20:=Get_Description(-><>aItem20des; -><>aItem20; ->[BridgeMHDNBISArchive:139]Item20:125)
		vItem21:=Get_Description(-><>aMaintOwner; -><>aMaintCod; ->[BridgeMHDNBISArchive:139]Item21:126)
		vItem22:=Get_Description(-><>aMaintOwner; -><>aMaintCod; ->[BridgeMHDNBISArchive:139]Item22:127)
		vItem37:=Get_Description(-><>aItem37des; -><>aItem37; ->[BridgeMHDNBISArchive:139]Item37:128)
		vItem13:=[BridgeMHDNBISArchive:139]Item 13A:194+[BridgeMHDNBISArchive:139]Item 13B:195
		
		item43a:=Substring:C12([BridgeMHDNBISArchive:139]Item43:74; 1; 1)
		vItem43a:=Get_Description(-><>aMaterial; -><>aMatCode; ->item43a)
		item43b:=Substring:C12([BridgeMHDNBISArchive:139]Item43:74; 2; 2)
		vItem43b:=Get_Description(-><>aDesign; -><>aDesignCod; ->item43b)
		
		vIntegral:=Get_Description(-><>aIntegralD; -><>aIntegralC; ->[BridgeMHDNBISArchive:139]JointlessType:199)
		
		item44a:=Substring:C12([BridgeMHDNBISArchive:139]Item44:75; 1; 1)
		vItem44a:=Get_Description(-><>aDesign; -><>aDesignCod; ->item44a)
		item44b:=Substring:C12([BridgeMHDNBISArchive:139]Item44:75; 2; 2)
		vItem44b:=Get_Description(-><>aDesign; -><>aDesignCod; ->item44b)
		
		vItem107:=Get_Description(-><>aDeck; -><>aDeckCod; ->[BridgeMHDNBISArchive:139]Item107:78)
		vItem108a:=Get_Description(-><>aWearing; -><>aWearCod; ->[BridgeMHDNBISArchive:139]Item108A:79)
		vItem108b:=Get_Description(-><>aMembrane; -><>aMembCod; ->[BridgeMHDNBISArchive:139]Item108B:80)
		vItem108c:=Get_Description(-><>aDeckProt; -><>aDeckPCod; ->[BridgeMHDNBISArchive:139]Item108C:81)
		
		item42a:=Substring:C12([BridgeMHDNBISArchive:139]Item42:84; 1; 1)
		vItem42a:=Get_Description(-><>aServiceOvr; -><>aSerOvrCode; ->item42a)
		item42b:=Substring:C12([BridgeMHDNBISArchive:139]Item42:84; 2; 1)
		vItem42b:=Get_Description(-><>aServUndr; -><>aSerUndrCod; ->item42b)
		
		vItem33:=Get_Description(-><>aItem33des; -><>aItem33; ->[BridgeMHDNBISArchive:139]Item33:98)
		vItem38:=Get_Description(-><>aItem38des; -><>aItem38; ->[BridgeMHDNBISArchive:139]Item38:112)
		vItem31:=Get_Description(-><>aDesignLoad; -><>aDesLoadCod; ->[BridgeMHDNBISArchive:139]Item31:134)
		
		vItem63:=Get_Description(-><>aRatMethDes; -><>aRatingMeth; ->[BridgeMHDNBISArchive:139]Item 63:196)
		vItem63:=Replace string:C233(vItem63; " Loading"; "")
		G_FormatItm6466(->[BridgeMHDNBISArchive:139]Item 63:196; ->[BridgeMHDNBISArchive:139]Item64:136)
		vItem65:=Get_Description(-><>aRatMethDes; -><>aRatingMeth; ->[BridgeMHDNBISArchive:139]Item 65:197)
		vItem65:=Replace string:C233(vItem65; " Loading"; "")
		G_FormatItm6466(->[BridgeMHDNBISArchive:139]Item 65:197; ->[BridgeMHDNBISArchive:139]Item66:138)
		
		vItem41:=Get_Description(-><>aPosting; -><>aPostCode; ->[BridgeMHDNBISArchive:139]Item41:140)
		vItem26:=Get_Description(-><>aFC; -><>aFC_Cod; ->[BridgeMHDNBISArchive:139]Item26:119)
		
End case 
