//%attributes = {"invisible":true}

//comparison ORDA vs SQL
//  SQL WINS!
C_LONGINT:C283($s; $e; $e1; $e2)
$s:=Tickcount:C458
C_OBJECT:C1216($es_)
$es_:=ds:C1482.Personnel.all()
C_COLLECTION:C1488($esCollection_)
$esCollection_:=New collection:C1472
$esCollection_:=$es_.toCollection("EmailAddress_s,Person ID,First Name,Last Name")
$e1:=Tickcount:C458
ARRAY TEXT:C222($Emails_atxt; 0)
ARRAY TEXT:C222($first_; 0)
ARRAY TEXT:C222($last_; 0)

ARRAY LONGINT:C221($peopleID; 0)
COLLECTION TO ARRAY:C1562($esCollection_; $Emails_atxt; "EmailAddress_s"; $peopleID; "Person ID"; $first_; "First Name"; $last_; "Last Name")
$e2:=Tickcount:C458
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($last_))
	$last_{$loop_L}:=$first_{$loop_L}+" "+$last_{$loop_L}
End for 

$e:=Tickcount:C458
ALERT:C41("tick 1 "+String:C10($e1-$s)+"\ntick 2 "+String:C10($e2-$s)+"\ntotal "+String:C10($e-$s))

$s:=Tickcount:C458
Begin SQL
	select
	[Personnel].[EmailAddress_s],
	[Personnel].[Person ID],
	CONCAT(CONCAT([Personnel].[First Name],' '),[Personnel].[Last Name]),
	[Personnel].[Employer]
	from
	[Personnel]
	into
	:$Emails_atxt, 
	:$peopleID,
	:$last_;
	
End SQL
$e:=Tickcount:C458
ALERT:C41("ticks "+String:C10($e-$s))


If (False:C215)
	
	//report on relation names
	
	C_LONGINT:C283($correctLink; $incorrectLink)
	C_OBJECT:C1216($dataClass)
	$correctLink:=0
	$incorrectLink:=0
	C_COLLECTION:C1488($dataClasses; $Links_)
	$dataClasses:=New collection:C1472()
	$Links_:=New collection:C1472()
	C_TEXT:C284($dataClass_name; $attribut; $text)
	C_BOOLEAN:C305($add)
	
	For each ($dataClass_name; ds:C1482)
		$dataClass:=ds:C1482[$dataClass_name]
		For each ($attribut; $dataClass)
			$add:=($dataClass[$attribut].kind="relatedEntit@")
			$correctLink:=$correctLink+Num:C11($add)
			If ($add)
				$Links_.push(New object:C1471("table"; $dataClass_name; \
					"link"; $attribut; \
					"Linkto"; $dataClass[$attribut].relatedDataClass; \
					"inverse"; $dataClass[$attribut].inverseName; \
					"kind"; $dataClass[$attribut].kind))
			End if 
			Case of 
				: (Not:C34($add))
				: ($dataClass[$attribut].name="Link_@")
				: ($dataClass[$attribut].name="Lien_@")
				: ($dataClass[$attribut].name="Verknüpfung_@")
				: (String:C10($dataClass[$attribut].inverseName)="Link_@")
				: (String:C10($dataClass[$attribut].inverseName)="Lien_@")
				: (String:C10($dataClass[$attribut].inverseName)="Verknüpfung_@")
				Else 
					$add:=False:C215
			End case 
			If ($add)
				$incorrectLink:=$incorrectLink+1
				$dataClasses.push($dataClass_name)
			End if 
		End for each 
	End for each 
	$text:=String:C10($incorrectLink)+"/"+String:C10($correctLink)+"\r"+\
		$dataClasses.distinct().join("\r")
	SET TEXT TO PASTEBOARD:C523($text)
	ALERT:C41($text)
	ARRAY TEXT:C222($tbls_atxt; 0)
	ARRAY TEXT:C222($links_atxt; 0)
	ARRAY TEXT:C222($linkto_atxt; 0)
	ARRAY TEXT:C222($inverse_atxt; 0)
	ARRAY TEXT:C222($kind_atxt; 0)
	COLLECTION TO ARRAY:C1562($Links_; $tbls_atxt; "table"; $links_atxt; "link"; $linkto_atxt; "Linkto"; $inverse_atxt; "inverse"; $kind_atxt; "kind")
	$text:=ut_ArrayToText_CSV(","; ->$tbls_atxt; ->$links_atxt; ->$linkto_atxt; ->$inverse_atxt; ->$kind_atxt)
	ALERT:C41($text)
	C_TEXT:C284($file_)
	$file_:=Select document:C905(""; ".csv"; "select file"; File name entry:K24:17)
	C_OBJECT:C1216($file_o)
	$file_o:=File:C1566(Document; fk platform path:K87:2)
	$file_o.setText($text)
	SHOW ON DISK:C922(Document)
	
	
End if 


If (False:C215)
	C_LONGINT:C283($l_; $t_; $r_; $b_)
	SCREEN COORDINATES:C438($l_; $t_; $r_; $b_; 0; Screen work area:K27:10)
	SCREEN COORDINATES:C438($l_; $t_; $r_; $b_; 1; Screen work area:K27:10)
	SCREEN COORDINATES:C438($l_; $t_; $r_; $b_; 2; Screen work area:K27:10)
	SCREEN COORDINATES:C438($l_; $t_; $r_; $b_; 3; Screen work area:K27:10)
	
	C_OBJECT:C1216($sys_)
	$sys_:=Get system info:C1571
	
	C_OBJECT:C1216($wptemplates)
	
	$wptemplates:=ds:C1482.Templates.query("TemplateName = :1"; "WP@")
	
	ALERT:C41(Choose:C955(Get application info:C1599.headless; "headless"; "headed")+" "+\
		Choose:C955(Get application info:C1599.launchedAsService; "as service"; "no service"))
	
End if 


If (False:C215)
	INSP_GetConsProjMgr
	
	C_OBJECT:C1216($datafromdlg_o)
	$datafromdlg_o:=New object:C1471
	C_LONGINT:C283($dlg_L)
	$dlg_L:=Open form window:C675("BridgeCriticalFindSearch"; Plain form window:K39:10)
	DIALOG:C40("BridgeCriticalFindSearch"; New object:C1471("returnobject"; $datafromdlg_o))
	CLOSE WINDOW:C154($dlg_L)
	C_DATE:C307($start_d; $end_d)
	$start_d:=OB Get:C1224($datafromdlg_o; "startDate"; Is date:K8:7)
	$end_d:=OB Get:C1224($datafromdlg_o; "endDate"; Is date:K8:7)
	$start_d:=$datafromdlg_o.startDate
	$end_d:=$datafromdlg_o.endDate
	
End if 

If (False:C215)
	C_COLLECTION:C1488($grps_c; $mygrps_c)
	$grps_c:=ds:C1482.PERS_Groups.all().orderBy("PERS_GroupName_s asc").toCollection("PERS_GroupName_s, PERS_GroupID_I")
	$mygrps_c:=ds:C1482.PERS_Groups.query("PERS_GroupID_I_54_GroupID_I.PersonID_I = :1"; 1081).orderBy("PERS_GroupName_s asc").toCollection("PERS_GroupName_s, PERS_GroupID_I")
	PERS_ExpandGroups($mygrps_c)
	C_LONGINT:C283($dlg_L)
	$dlg_L:=Open form window:C675("twolistmove_c"; Plain form window:K39:10)
	
	DIALOG:C40("twolistmove_c"; New object:C1471("return"; $datafromdlg_o; \
		"UseC"; $grps_c; \
		"OmitC"; $mygrps_c; \
		"col1"; "PERS_GroupName_s"; \
		"useheader"; "Available groups"; \
		"equalattr"; "PERS_GroupID_I"; \
		"orderbycriteria"; "PERS_GroupName_s asc"; \
		"omitheader"; "Person groups"; \
		"cancelbtn"; New object:C1471("label"; "forget it")))
	CLOSE WINDOW:C154($dlg_L)
	
	
End if 
//$n_o.length

If (False:C215)
	//[PERS_GroupMembers]GroupID_I
	ALL RECORDS:C47([Inspections:27])
	ARRAY INTEGER:C220($TLS_aL; 0)
	SELECTION TO ARRAY:C260([Inspections:27]TeamLeader:4; $TLS_aL)
	C_TEXT:C284($names_txt)
	C_LONGINT:C283($st; $end; $i)
	$st:=Tickcount:C458
	For ($i; 1; 5000)
		$names_txt:=PERS_GetName($TLS_aL{$i})
	End for 
	$end:=Tickcount:C458
	ALERT:C41(" ticks"+String:C10($end-$st))
	
	C_OBJECT:C1216($pers_o)
	$pers_o:=ds:C1482.Personnel.all()
	$pers_o:=ds:C1482.Personnel.query("\"Person ID\" = :1"; 568978)
	ALERT:C41($pers_o[0]["First Name"]+" <"+$pers_o[0]["Middle Name"]+"> "+$pers_o[0]["Last Name"])
	
End if 

If (False:C215)
	C_OBJECT:C1216($stairs_o)
	C_COLLECTION:C1488($owners_c)
	C_TEXT:C284($owners_txt)
	$stairs_o:=ds:C1482["BridgeStairs"].query("BIN = :1"; "28K")
	
	If ($stairs_o.length>0)
		$owners_c:=$stairs_o.toCollection("OwnerCode_s")
		C_OBJECT:C1216($stair_o)
		$owners_txt:=$stairs_o[0].OwnerCode_s
		C_LONGINT:C283($i)
		For ($i; 1; ($stairs_o.length-1))
			$owners_txt:=$owners_txt+", "+$stairs_o[$i].OwnerCode_s
		End for 
		
	End if 
	ALERT:C41($owners_txt)
	
End if 


If (False:C215)
	C_REAL:C285($i16c)
	
	$i16c:=28.9872
	
	SIA_UpdateRealField(->$i16c; "2898"; 2)
	
	
End if 

If (False:C215)
	C_OBJECT:C1216($mod_o)
	ALL RECORDS:C47([LSS_Photos:166])
	C_LONGINT:C283($byte20)
	$byte20:=[LSS_Photos:166]LSS_Photo_blb:5{20}
	[LSS_Photos:166]LSS_Photo_blb:5{20}:=$byte20+1
	[LSS_Photos:166]LSS_Photo_txt:4:=[LSS_Photos:166]LSS_Photo_txt:4
	$mod_o:=DB_ModifiedRecord(->[LSS_Photos:166])
	UNLOAD RECORD:C212([LSS_Photos:166])
	ALL RECORDS:C47([LSS_ElementInspection:163])
	[LSS_ElementInspection:163]LSS_DamageCurrentCondition_s:12:="7"
	[LSS_ElementInspection:163]LSS_Deficiency_s:5:="bad"
	[LSS_ElementInspection:163]LSS_Description_txt:7:=[LSS_ElementInspection:163]LSS_Description_txt:7
	[LSS_ElementInspection:163]LSS_Remarks_txt:8:=(1029*("Some text in here. "))
	[LSS_ElementInspection:163]LSS_SectionID_L:9:=58
	[LSS_ElementInspection:163]LSS_DamageCrack_B:11:=Not:C34([LSS_ElementInspection:163]LSS_DamageCrack_B:11)
	
	$mod_o:=DB_ModifiedRecord(->[LSS_ElementInspection:163])
	ut_BigAlert($mod_o.AllFieldNames)
	UNLOAD RECORD:C212([LSS_ElementInspection:163])
	$mod_o:=DB_ModifiedRecord(->[LSS_ElementInspection:163])
	ALL RECORDS:C47([Standard Photos:36])
	[Standard Photos:36]InspID:1:=[Standard Photos:36]InspID:1
	[Standard Photos:36]SeqNum:6:=[Standard Photos:36]SeqNum:6+40
	[Standard Photos:36]Std Photo:3:=([Standard Photos:36]Std Photo:3*0)
	$mod_o:=DB_ModifiedRecord(->[Standard Photos:36])
	
End if 

If (False:C215)
	
	Progress QUIT(1)
	$r:=Progress Get Progress(1)
	
	C_LONGINT:C283($n)
	$n:=Progress New
	C_REAL:C285($r)
	$r:=Progress Get Progress($n)
	
	C_TEXT:C284($sr)
	$sr:="tell application \"Microsoft Word\" \n"+\
		"activate\n"+\
		"open file \"Macintosh HD:Users:costasmanousakis:Documents:Untitled9.docx\" \n"+\
		"set body to text object of active document\n"+\
		"set font size of font object of body to 12\n"+\
		"save active document\n"+\
		"end tell"
	
	
	ut_RunScript($sr)
	
	
	C_LONGINT:C283($pid)
	$pid:=1466
	ut_BigAlert("<"+"LN, FI."+">"+" <"+PERS_GetName($pid; "LN, FI.")+">\n"+\
		"<"+""+">"+"<"+PERS_GetName($pid)+">\n"+\
		"<"+"   "+">"+"<"+PERS_GetName($pid; "   ")+">\n"+\
		"<"+"PRE LN fg MI. FN  SUF   "+">"+"<"+PERS_GetName($pid; "PRE LN fg MI. FN  SUF   ")+">\n"+\
		"<"+"FIMILI"+">"+"<"+PERS_GetName($pid; "FIMILI")+">\n"+\
		"<"+"PRE FN MI LNSUF"+">"+"<"+PERS_GetName($pid; "PRE FN MI LNSUF")+">\n"+\
		"<PREFN MI. LNSUF>"+"<"+PERS_GetName($pid; "PREFN MI. LNSUF")+">"\
		)
	
	ARRAY TEXT:C222($people; 0)
	ARRAY LONGINT:C221($peopleID; 0)
	Begin SQL
		select concat(concat(concat(concat(concat(CONCAT([personnel].[first name],' ') 
		,[personnel].[last name]),' - ')
		,[Personnel].[Employer]),' - ')
		,substring('IA',1+cast([personnel].[active] as int),1)),
		[Personnel].[Person ID]
		from [personnel]
		where
		[personnel].[userid_4d] <> 0
		into :$people, :$peopleID ;
		
	End SQL
	
	
	ARRAY TEXT:C222($groupNames; 0)
	ARRAY LONGINT:C221($groupnumbers; 0)
	GET GROUP LIST:C610($groupNames; $groupnumbers)
	
	C_COLLECTION:C1488($ccc)
	$ccc:=USR_GetUserGroupMemberships(-84)
	
	ARRAY TEXT:C222($names; 0)
	ARRAY TEXT:C222($main; 0)
	COLLECTION TO ARRAY:C1562($ccc; $names; "groupname"; $main; "main")
	
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($names))
		If ($main{$loop_L}#"m")
			$names{$loop_L}:=" --"+$names{$loop_L}
		End if 
		
	End for 
	
	C_TEXT:C284($clip; $delim)
	$clip:=Get text from pasteboard:C524
	ARRAY TEXT:C222($ids; 0)
	
	Case of 
		: (Position:C15("\r\n"; $clip)>0)
			$delim:="\r\n"
		: (Position:C15("\r"; $clip)>0)
			$delim:="\r"
		: (Position:C15("\n"; $clip)>0)
			$delim:="\n"
			
	End case 
	
	ut_NewTextToArray($clip; ->$ids; $delim)
	C_TEXT:C284($InList)
	C_LONGINT:C283($split)
	$split:=5000
	ARRAY TEXT:C222($ids; $split)
	$InList:=ut_ArrayToText(->$ids; ";")
	
	SET TEXT TO PASTEBOARD:C523($InList)
	
	QUERY:C277([Standard Photos:36]; [Standard Photos:36]StdPhotoID:7=1311293)
	ARRAY TEXT:C222($types; 0)
	GET PICTURE FORMATS:C1406([Standard Photos:36]Std Photo:3; $types)
	C_PICTURE:C286($new)
	$new:=[Standard Photos:36]Std Photo:3
	CONVERT PICTURE:C1002($new; ".jpg"; 0.6)
	
	
	C_LONGINT:C283($Win_L)
	
	$Win_L:=Open form window:C675("ChangePassword"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
	DIALOG:C40("ChangePassword")
	CLOSE WINDOW:C154($Win_L)
	
	
	//Get 4D folder(Active 4D Folder)
	If (False:C215)
		
		
		
		C_BOOLEAN:C305($Priority_B)
		$Priority_B:=False:C215
		SET PRINT OPTION:C733(Paper option:K47:1; "US Letter")
		SET PRINT OPTION:C733(Orientation option:K47:2; 1)
		//SET PRINT OPTION(_o_Hide printing progress option; 1)
		SET PRINT OPTION:C733(Scale option:K47:3; 100)
		InitProcessVar
		C_TEXT:C284($Path_txt)
		$Path_txt:=System folder:C487(Documents folder:K41:18)
		$Path_txt:=$Path_txt+"Auto Insp PDFs"
		If (Test path name:C476($Path_txt)=Is a folder:K24:2)
		Else 
			CREATE FOLDER:C475($Path_txt)
		End if 
		$Path_txt:=$Path_txt+Folder separator:K24:12
		
		ARRAY LONGINT:C221($ValidRecords_aL; 0)
		C_TEXT:C284($MonthYear_txt)
		$MonthYear_txt:=String:C10(Year of:C25(Current date:C33); "0000")+"_"+String:C10(Month of:C24(Current date:C33); "00")+"_"+String:C10(Day of:C23(Current date:C33); "00")
		
		QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=119391; *)
		QUERY:C277([Inspections:27];  | ; [Inspections:27]InspID:2=119321; *)
		QUERY:C277([Inspections:27];  | ; [Inspections:27]InspID:2=119394)
		SELECTION TO ARRAY:C260([Inspections:27]; $ValidRecords_aL)
		INSP_PrintToPDF(True:C214; ->$Path_txt; ->$ValidRecords_aL; $MonthYear_txt; Current method name:C684)
		
	End if 
	
	
	ON ERR CALL:C155("4D_Errors")
	EXECUTE FORMULA:C63("QR_RunStoredQRtoExcel (->[inspections]insp date;\"WPtemplate_BrClosure_IOM\")")
	
	ON ERR CALL:C155("")
	//BMS Cons QA form
	//BMS Cons Transmittal
	//BMS Page1
	//BMS SIA
	//BMS SIA Markup
	
	QUERY:C277([Inspections:27]; [Inspections:27]InspApproved:167#BMS Approved; *)
	QUERY:C277([Inspections:27];  & ; [Bridge MHD NBIS:1]InspResp:173="Dist5")
	QR_RunReportToExcel(->[Inspections:27])
	
	FORM LOAD:C1103([Contract_Maintenance:97]; "Contract Maintenance IN")
	
	C_OBJECT:C1216($myObject)
	
	DEV_GetFormObjects("Contract Maintenance IN"; Table:C252(->[Contract_Maintenance:97]); ->$myObject)
	C_TEXT:C284($myText)
	$myText:=JSON Stringify:C1217($myObject)
	SET TEXT TO PASTEBOARD:C523($mytext)
	jsonEditor(->$myObject)
	
	
	
	//R_dev _getfoaunchInNewProcess
	//MODIFY SELECTION(
	
	ARRAY TEXT:C222($DPersonnelGroups_atxt; 0)
	FORM GET NAMES:C1167([Personnel:42]; $DPersonnelGroups_atxt)
	C_TEXT:C284($menu)
	$menu:=ut_ArrayToPopupMenu(->$DPersonnelGroups_atxt)
	C_LONGINT:C283($choice)
	$choice:=Pop up menu:C542($menu)
	ALERT:C41($DPersonnelGroups_atxt{$choice})
	
	GRP_GetPersonGroups(New object:C1471("grpNamesPtr"; ->$DPersonnelGroups_atxt; \
		"personID"; 85; \
		"getParents"; True:C214; \
		"showlevel"; True:C214))
	
	ut_ControlUserPrefs("init")
	
	
	
	GenericEditPreferences
	ARRAY TEXT:C222($Filesin_atxt; 0)
	ARRAY TEXT:C222($Filesout_atxt; 0)
	C_TEXT:C284($result_txt)
	$result_txt:=Select document:C905(""; ".pdf"; "Choose pdf files to combine"; Multiple files:K24:7; $Filesin_atxt)
	
	$result_txt:=Select document:C905(""; ".pdf"; "Choose output pdf file"; File name entry:K24:17; $Filesout_atxt)
	PDF_CombinePdfs(->$Filesin_atxt; $Filesout_atxt{1})
	
	SHOW ON DISK:C922($Filesout_atxt{1})
	
	C_DATE:C307($AttachmentsOn_date)
	$AttachmentsOn_date:=Date:C102(ut_GetSysParameter("INSP_Attachments_on"))
	
	
	ALERT:C41(String:C10(Table:C252(->[TIN_Inspections:184]))+" - "+\
		String:C10(Table:C252(->[TIN_Insp_Comments:188]))+" - "+\
		String:C10(Table:C252(->[TIN_Insp_Images:186]))+" - "+\
		String:C10(Table:C252(->[TIN_Insp_TmMembers:187]))+" - "+\
		String:C10(Table:C252(->[NTI_ELEM_TIN_INSP:185]))+" - ")
	
	//[Inspections];"CustomInput".bValidate after line 35 C_TEXT(VSFORWARD) 
	//I found the methods where the call to change vsForward.
	//For bridge inspection review in G_Insp_ApproveReject  near line 97.
	//I think you have the other places where it needs to be inserted for Bridge inspe.
	//**********`Modified by: Costas Manousakis-(Designer)-(2022-03-21T00:00:00)
	
	//For Tunnels
	//In method NTI_OpenInspection at line 52 right before the MODIFY RECORD Command
	//NTI_AddTIN_Inspection  at line 82 right before the ADD RECORD command.
	//NTI_DoReviewInspection  at line 109
	//NTI_DuplicateInspection  after line 73 after the START TRANSACTION command.
	//NTI_ImportInspection after line 29 the RECEIVE RECORD([TIN_Inspections])command.
	
	
	//Method: Object Method: [Inspections].CustomInput.bValidate
	G_Insp_ApproveReject
	NTI_OpenInspection  //do we ant to change vsforward - as below
	//If (Structure file="MHD BMS External@")
	//If (Num([NTI_TunnelInfo]NTI_i6_s)#0)
	//vsForward:="District "+String(Num([NTI_TunnelInfo]NTI_i6_s))+" BMS"
	//End if 
	//End if 
	NTI_AddTIN_Inspection  //do we ant to change vsforward - as below
	//If (Structure file="MHD BMS External@")
	//If (Num([NTI_TunnelInfo]NTI_i6_s)#0)
	//vsForward:="District "+String(Num([NTI_TunnelInfo]NTI_i6_s))+" BMS"
	//End if 
	//End if 
	NTI_DoReviewInspection
	NTI_DuplicateInspection  // needed to be done in two places
	NTI_ImportInspection
	
	//Method: [Inspections];"InspectionReview_LB".InspectionReview
	
	
	//what about
	// PON_ut_RelogPON_INSP_records
	
	
	//Do we use I don't think so
	//ADD_INSPECT
	
	
	//INSP_SpellCheckAll 
	//INSP_PreviewBtn_OM 
	//[Inspections];"AboveWater Template" 
	//[Inspections];"Closed Bridge"
	//[Inspections];"Culvert Combined"
	//[Inspections];"Damage Form"
	//[Inspections];"Dive Template"
	//[Inspections];"PedestrianInspection-PED"
	//[Inspections];"RailCulvertCombined-RRC"
	//[Inspections];"RailRoutineInput"
	//[Inspections];"Routine Combined"
	//[Inspections];"Tunnel Template"
	//[Inspections];"TunnelDamageForm"
	//[Inspections];"TunnelInspection"
	//[Inspections];"TunnelOverheadInspection"
	//[Inspections];"TunnelSpecial"
	
	ControlServerProcesses
	ut_MountVolume
	//ARRAY TEXT($types;0)
	//QUERY([Status Report];
	//GET PICTURE FORMATS)
	READ ONLY:C145(*)
	ALL RECORDS:C47([ElementsSafety:29])
	CREATE SET:C116([ElementsSafety:29]; "$All")
	QUERY:C277([ElementsSafety:29]; [Inspections:27]InspID:2>0)
	CREATE SET:C116([ElementsSafety:29]; "$withID")
	DIFFERENCE:C122("$all"; "$withID"; "$noID")
	SAVE SET:C184("$noID"; "")
	CLEAR SET:C117("$all")
	CLEAR SET:C117("$withID")
	CLEAR SET:C117("$noid")
	LOAD SET:C185([ElementsSafety:29]; "new"; "")
	USE SET:C118("New")
	CLEAR SET:C117("new")
	
	ALL RECORDS:C47([Inspections:27])
	QUERY:C277([Inspections:27]; [Inspections:27]Insp Type:6="CUL@"; *)
	QUERY:C277([Inspections:27];  & ; [Inspections:27]InspRtnSpcMemFlag:209=True:C214)
	ORDER BY:C49([Inspections:27]; [Inspections:27]Insp Date:78; <)
	C_OBJECT:C1216($QC_o; $TL_o; $DBIE_o; $AE_o)
	C_TEXT:C284($qc_txt; sBDEPT)
	C_LONGINT:C283($ID_L; $days)
	FIRST RECORD:C50([Inspections:27])
	$ID_L:=[Inspections:27]InspID:2
	sBDEPT:=""
	$days:=12
	//TL complete
	C_OBJECT:C1216($param_o)
	OB SET:C1220($param_o; "type"; "tl"; \
		"fieldptr"; ->[Inspections:27]RatingFeedBack:203; \
		"name"; "TheTL Name"; \
		"osname"; "Sylviab"; \
		"wkst"; "Dot-eng-6783"; \
		"stack"; 1; \
		"date"; Add to date:C393(Current date:C33; 0; 0; $days))
	INSP_QCSaveApprovalInfo($param_o)
	SAVE RECORD:C53([Inspections:27])
	UNLOAD RECORD:C212([Inspections:27])
	
	//tl complete again
	QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=$ID_L)
	$days:=$days+3
	
	OB SET:C1220($param_o; "type"; "tl"; \
		"fieldptr"; ->[Inspections:27]RatingFeedBack:203; \
		"name"; "TheTL Name"; \
		"osname"; "Thomas Predergast"; \
		"wkst"; "TprendrergastMcbk"; \
		"stack"; 1; \
		"date"; Add to date:C393(Current date:C33; 0; 0; $days))
	INSP_QCSaveApprovalInfo($param_o)
	
	SAVE RECORD:C53([Inspections:27])
	UNLOAD RECORD:C212([Inspections:27])
	
	$days:=$days+15
	
	//DBIE approve
	QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=$ID_L)
	
	OB SET:C1220($param_o; "type"; "dbie"; \
		"fieldptr"; ->[Inspections:27]RatingFeedBack:203; \
		"name"; "Thedbie Name"; \
		"osname"; "Grant Simpson"; \
		"wkst"; "GSimpsonMacbook"; \
		"stack"; 1; \
		"date"; Add to date:C393(Current date:C33; 0; 0; $days))
	INSP_QCSaveApprovalInfo($param_o)
	
	SAVE RECORD:C53([Inspections:27])
	UNLOAD RECORD:C212([Inspections:27])
	
	//tl complete again
	$days:=$days+24
	
	QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=$ID_L)
	
	OB SET:C1220($param_o; "type"; "tl"; \
		"fieldptr"; ->[Inspections:27]RatingFeedBack:203; \
		"name"; "TheTL Name"; \
		"osname"; "Thomas Predergast"; \
		"wkst"; "TprendrergastMcbk"; \
		"stack"; 1; \
		"date"; Add to date:C393(Current date:C33; 0; 0; $days))
	INSP_QCSaveApprovalInfo($param_o)
	SAVE RECORD:C53([Inspections:27])
	UNLOAD RECORD:C212([Inspections:27])
	
	
	//DBIE approve again
	$days:=$days+2
	
	QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=$ID_L)
	
	OB SET:C1220($param_o; "type"; "dbie"; \
		"fieldptr"; ->[Inspections:27]RatingFeedBack:203; \
		"name"; "Constantine Manousakis"; \
		"osname"; "Constantine Manousakis"; \
		"wkst"; "GSimpsonMacbook"; \
		"stack"; 1; \
		"date"; Add to date:C393(Current date:C33; 0; 0; $days))
	INSP_QCSaveApprovalInfo($param_o)
	SAVE RECORD:C53([Inspections:27])
	UNLOAD RECORD:C212([Inspections:27])
	
	//AE approve 
	$days:=$days+18
	
	QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=$ID_L)
	
	OB SET:C1220($param_o; "type"; "ae"; \
		"fieldptr"; ->[Inspections:27]RatingFeedBack:203; \
		"name"; "Jean Marauszwski"; \
		"osname"; "Jean Marauszwski"; \
		"wkst"; "Jean Marauszwski MacBook Pro"; \
		"stack"; 1; \
		"date"; Add to date:C393(Current date:C33; 0; 0; $days))
	INSP_QCSaveApprovalInfo($param_o)
	SAVE RECORD:C53([Inspections:27])
	UNLOAD RECORD:C212([Inspections:27])
	
	
	QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=$ID_L)
	SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Inspections:27]BIN:1)
	QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=[Inspections:27]Insp Type:6)
	G_SIA_BuildTownLine
	SET PRINT OPTION:C733(Paper option:K47:1; "US letter")
	PRINT SETTINGS:C106
	Print form:C5([Inspections:27]; "qcqaprint")
	PAGE BREAK:C6
	
	OB SET:C1220($QC_o; "tl"; $TL_o; "dbie"; $DBIE_o; "ae"; $AE_o)
	
	OB SET:C1220($TL_o; "name"; "TheTL Name"; \
		"date"; String:C10(Current date:C33; ISO date:K1:8; Current time:C178); \
		"osname"; "Sylviab"; \
		"wkst"; "Dot-eng-6783")
	OB SET:C1220($DBIE_o; "name"; "Thedbie Name"; \
		"date"; String:C10(Add to date:C393(Current date:C33; 0; 0; 15); ISO date:K1:8; Current time:C178); \
		"osname"; "Grant Simpson"; \
		"wkst"; "GSimpsonMacbook")
	OB SET:C1220($AE_o; "name"; "TheAE Name"; \
		"date"; String:C10(Add to date:C393(Current date:C33; 0; 0; 20); ISO date:K1:8; Current time:C178); \
		"osname"; "Sylviab"; \
		"wkst"; "dot-eng-8946")
	
	OB SET:C1220($QC_o; "tl"; $TL_o; "dbie"; $DBIE_o; "ae"; $AE_o)
	$qc_txt:=JSON Stringify:C1217($qc_o)
	
	$qc_txt:=EncryptDecryptString($qc_txt)
	
	
	C_TEXT:C284($ItemsToUpdate_txt)
	$ItemsToUpdate_txt:="NBI Items 41, 58, 59, 60, 62, 93C"
	msg:="!!! CAUTION !!!"+Char:C90(13)
	msg:=msg+"MADOT BMS user "+Current user:C182+" connected from OS user "+Current system user:C484+" on "+Current machine:C483
	msg:=msg+Char:C90(13)+"Marking this Inspection Report as Completed will update the SI&A with "+$ItemsToUpdate_txt+" from this report!"
	msg:=msg+Char:C90(13)+"This automatic action will only be performed the first time this report is marked as complete!"
	msg:=msg+Char:C90(13)+"Is this Inspection ready to be reviewed?"
	CONFIRM:C162(msg; "Not Yet"; "Ready")
	ST SET ATTRIBUTES:C1093(msg; \
		Position:C15(Current user:C182; ST Get plain text:C1092(msg)); \
		Position:C15(Current user:C182; ST Get plain text:C1092(msg))+Length:C16(Current user:C182); \
		Attribute bold style:K65:1; 1; Attribute underline style:K65:4; 1)
	
	ST SET ATTRIBUTES:C1093(msg; \
		Position:C15(Current system user:C484; ST Get plain text:C1092(msg)); \
		Position:C15(Current system user:C484; ST Get plain text:C1092(msg))+Length:C16(Current system user:C484); \
		Attribute bold style:K65:1; 1; Attribute underline style:K65:4; 1)
	ST SET ATTRIBUTES:C1093(msg; \
		Position:C15(Current machine:C483; ST Get plain text:C1092(msg)); \
		Position:C15(Current machine:C483; ST Get plain text:C1092(msg))+Length:C16(Current machine:C483); \
		Attribute bold style:K65:1; 1; Attribute underline style:K65:4; 1)
	G_MyConfirm(msg; "Not Yet"; "Ready")
	
	
	ut_LoadPrefRecord
	
	
	
	C_TEXT:C284($file)
	ARRAY TEXT:C222($textfiles_; 0)
	$file:=Select document:C905(""; ".pdf"; "Pick a pdf file"; 0; $textfiles_)
	ut_OpenDocument($textfiles_{1})
	
	ARRAY LONGINT:C221($Ids_aL; 0)
	ARRAY TEXT:C222($Emails_atxt; 0)
	C_TEXT:C284($agency)
	$agency:="AI Engineers, Inc."
	Begin SQL
		select 
		[Personnel].[Person ID] ,
		[Personnel].[EmailAddress_s]
		from [Personnel]
		where [Personnel].[Employer] = :$agency
		and [Personnel].[EmailAddress_s] <> ''
		and [Personnel].[Person ID] IN 
		( Select [PERS_GroupMembers].[PersonID_I] 
		from [PERS_GroupMembers], [PERS_Groups]
		where 
		[PERS_GroupMembers].[GroupID_I] = [PERS_Groups].PERS_GroupID_I and
		[PERS_Groups].[PERS_GroupName_s]= 'ConsInspProjMgrs' )
		into :$Ids_aL , :$Emails_atxt ;
		
	End SQL
	
	
	C_LONGINT:C283($ID)
	$ID:=109638
	READ ONLY:C145(*)
	SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=$ID)
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Inspections:27]BIN:1)
	Mail_SendInspRevuNotif
	
	
	C_PICTURE:C286($test)
	C_TEXT:C284($testPDf_file)
	C_BLOB:C604($testFile; $testout)
	ARRAY TEXT:C222($Files_atxt; 0)
	$testPDf_file:=Select document:C905(""; ".pdf"; "Pick a pdf"; 0; $Files_atxt)
	
	DOCUMENT TO BLOB:C525($Files_atxt{1}; $testFile)
	QUERY:C277([Standard Photos:36]; [Standard Photos:36]StdPhotoID:7=789407)
	LOAD RECORD:C52([Standard Photos:36])
	
	BLOB TO PICTURE:C682($testFile; [Standard Photos:36]Std Photo:3; "madotpdf")
	SAVE RECORD:C53([Standard Photos:36])
	UNLOAD RECORD:C212([Standard Photos:36])
	
	PICTURE TO BLOB:C692([Standard Photos:36]Std Photo:3; $testout; "madotpdf")
	$testPDf_file:=Select document:C905(""; ".pdf"; "Save a new pdf"; File name entry:K24:17; $Files_atxt)
	BLOB TO DOCUMENT:C526($Files_atxt{1}; $testout)
	
	C_TEXT:C284($BINMapOptions)
	$BINMapOptions:=ut_GetSysParameter("MAP_BINSiteOptions")
	C_OBJECT:C1216($BinOptions_o)
	$BinOptions_o:=JSON Parse:C1218($BINMapOptions)
	ARRAY OBJECT:C1221($sites_ao; 0)
	OB GET ARRAY:C1229($BinOptions_o; "Sites"; $sites_ao)
	C_LONGINT:C283($loop_L)
	C_TEXT:C284($menu_txt)
	$menu_txt:="<I Select a map option..."
	For ($loop_L; 1; Size of array:C274($sites_ao))
		$menu_txt:=$menu_txt+";"+OB Get:C1224($sites_ao{$loop_L}; "name"; Is text:K8:3)
	End for 
	C_LONGINT:C283($Choice_L)
	$Choice_L:=Pop up menu:C542($menu_txt)
	If ($Choice_L>1)
		ALERT:C41("Use map for "+OB Get:C1224($sites_ao{$Choice_L-1}; "name")+" and url param "+OB Get:C1224($sites_ao{$Choice_L-1}; "urlparam"))
	End if 
End if 
