//%attributes = {"invisible":true}
//Duplicate_Inspection
//Duplicate the Inspection with its Elements and Images
If (False:C215)
	//Created January-2005
	Mods_2004_VN03
	Mods_2005_CM03
	Mods_2005_CM06
	Mods_2005_CM15
	Mods_2005_CM17
	// Modified by: costasmanousakis-(Designer)-(1/4/2006 11:58:01)
	Mods_2006_CM01
	// Modified by: costasmanousakis-(Designer)-(2/17/2006 13:37:19)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(2/21/2006 09:13:52)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(4/19/2006 15:01:56)
	Mods_2006_CMy2
	// Modified by: costasmanousakis-(Designer)-(5/18/2006 16:03:47)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(5/21/2007 10:26:58)
	Mods_2007_CM10
	// Modified by: costasmanousakis-(Designer)-(4/22/08 15:05:16)
	Mods_2008_CM_5403  //Adjust create/modify timestamps ; clear review dates
	// Modified by: costasmanousakis-(Designer)-(10/2/08 16:51:16)
	Mods_2008_CM_5404
	//Don't clear the [inspections]agency; it is set in the call to G_SIA2Inspection
	// Modified by: costasmanousakis-(Designer)-(3/10/09 14:27:37)
	Mods_2009_03
	//  `Use the current user as the default team leader
	// Modified by: costasmanousakis-(Designer)-(2/26/10 17:01:00)
	Mods_2010_02
	//  `Mods for Bridge Inspection  HI
	Mods_2011_06  // CJ Miller`06/14/11, 10:44:47      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(11/2/12 14:25:45)
	Mods_2012_11
	//  `Clear all review comments
	// Modified by: Costas Manousakis-(Designer)-(2/12/13 10:52:50)
	Mods_2013_02
	//  `Clear the in-depth review flag also
	// Modified by: Costas Manousakis-(Designer)-(4/29/13 16:58:00)
	Mods_2013_04
	//  `Added copying of TunnelInspection record if any; Also use loglink only if the link field is not 0
	// Modified by: Costas Manousakis-(Designer)-(10/24/13 11:19:39)
	Mods_2013_10
	//  `use  method  INSP_IsInspRoutine_b to check if inspection is a routine one
	// Modified by: Costas Manousakis-(Designer)-(4/1/14 13:07:16)
	Mods_2014_04_bug
	//  `fix typo in inc_sequence for "TunnelInspection
	// Modified by: Costas Manousakis-(Designer)-(4/9/14 09:54:34)
	Mods_2014_04_bug
	//  `fixed call to TNL_QAQCEngr_L - added the distr number
	//  `fixed call to LogNewRecord - fixed the seq name
	// Modified by: Costas Manousakis-(Designer)-(4/10/14 17:32:37)
	Mods_2014_04
	//  `for Freeze thaw inspections, if  there is a text in the blob comments , move it to top of Comments and set the  blob to zero
	// Modified by: Costas Manousakis-(Designer)-(4/15/14 16:57:55)
	Mods_2014_04
	//  `added table [ElmtRatingLoads] in the duplications sequence
	// Modified by: Costas Manousakis-(Designer)-(1/15/15 14:32:59)
	Mods_2015_01
	//  `added  initializing of new date tracking fields 
	// Modified by: Costas Manousakis-(Designer)-(3/16/15 13:08:58)
	Mods_2015_03
	//  `added copying of NBEs
	// Modified by: Costas Manousakis-(Designer)-(4/13/15 15:57:30)
	Mods_2015_04
	//  `added case statement to account for non-highway routine & special memb inspections copied into respective special member isnpections
	//  `default is a CMI (Highway spec memb)
	// Modified by: Costas Manousakis-(Designer)-(1/11/17 16:08:11)
	Mods_2017_01
	//  `make current user TL only if they are TL or DBIE
	// Modified by: Costas Manousakis-(Designer)-(1/16/17 10:24:56)
	Mods_2017_01
	//  `fix select SQL to use [] around  <>CurrentUser_PID
	// Modified by: Costas Manousakis-(Designer)-(1/16/19 16:19:04)
	Mods_2019_01_bug
	//  `fixed IF statement when : need to check if now there is a BMS Inspection record if we have NBES 
	//  `also added the calc of HI when creating a BMS insp record
	//  `for CallReference #595
	// Modified by: Costas Manousakis-(Designer)-(6/12/19 15:28:19)
	Mods_2019_06
	//  `Use PON_CopyElements to create the NBEs for a normal inspection. + Other adjustments to code
	// Modified by: Costas Manousakis-(Designer)-(4/20/21 16:02:48)
	Mods_2021_WP
	//  `removed setting of default font and size in comments
	// Modified by: Costas Manousakis-(Designer)-(2021-10-20)
	Mods_2021_10
	//  `when duplicating copy only Sketches / charts / Photos - unless doing a full copy
	// Modified by: Costas Manousakis-(Designer)-(2021-12-09T00:00:00 12:18:57)
	Mods_2021_12_bug
	//  `Copy/Merge NBEs only for inspection types defined in system parameter INSPTYPESWNBES default "RTN,RTA,CUL,CMI,OTH"
	// Modified by: Costas Manousakis-(Designer)-(2022-03-18 15:32:40)
	Mods_2022_03
	//Add call to Synch_ReturnForward to reset new style vsForward
End if 

C_LONGINT:C283($oldInspID; $NoElmts; $NoImgs; $i; $j)
C_LONGINT:C283($InspTable; $ElmtTable; $ImgTable)
C_LONGINT:C283($Num_I_Fields; $Num_El_Fields; $Num_Img_Fields)
C_TEXT:C284($msg)
C_TEXT:C284($FieldName)  // Command Replaced was o_C_STRING length was 40
C_BOOLEAN:C305($1; $vbSpecialInspFlag)
C_LONGINT:C283($vlNBISInspectionID; $vlBMSInspectionID; $vlCombInspectionID)
C_LONGINT:C283(vInsptoCopy)  //used for [BMS Inspections] id

//Special Inspection Flag duplicated from Combined Inspection
$vbSpecialInspFlag:=$1

C_BOOLEAN:C305($vbNormalCopy)
$vbNormalCopy:=True:C214
$vbNormalCopy:=Not:C34(DupInsp_CopyAsIS_L=1)

SET CURSOR:C469(4)
SHORT_MESSAGE("Starting duplication of inspection...")

//Get the Table Number of [Inspections] table
$InspTable:=Table:C252(->[Inspections:27])
$Num_I_Fields:=Get last field number:C255($InspTable)
ARRAY POINTER:C280($a_Ptr_InspFields; $Num_I_Fields)
For ($i; 1; $Num_I_Fields)
	$a_Ptr_InspFields{$i}:=Field:C253($InspTable; $i)
End for 
$ElmtTable:=Table:C252(->[ElementsSafety:29])
$Num_El_Fields:=Get last field number:C255(->[ElementsSafety:29])
ARRAY POINTER:C280($a_Ptr_ElFields; $Num_El_Fields)
For ($i; 1; $Num_El_Fields)
	$a_Ptr_ElFields{$i}:=Field:C253($ElmtTable; $i)
End for 
$ImgTable:=Table:C252(->[Standard Photos:36])
$Num_Img_Fields:=Get last field number:C255(->[Standard Photos:36])
ARRAY POINTER:C280($a_Ptr_ImgFields; $Num_Img_Fields)
For ($i; 1; $Num_Img_Fields)
	$a_Ptr_ImgFields{$i}:=Field:C253($ImgTable; $i)
End for 
C_LONGINT:C283($Num_Tinsp_Fields)

$ImgTable:=Table:C252(->[TunnelInspection:152])
$Num_Tinsp_Fields:=Get last field number:C255(->[TunnelInspection:152])
ARRAY POINTER:C280($a_Ptr_TinspFields; $Num_Tinsp_Fields)
For ($i; 1; $Num_Tinsp_Fields)
	$a_Ptr_TinspFields{$i}:=Field:C253($ImgTable; $i)
End for 

MESSAGE:C88(<>sCR+"   Copying Inspection ...")

RELATE ONE:C42([Combined Inspections:90]NBISInspID:2)
RELATE ONE:C42([Combined Inspections:90]BMSInspID:3)
vInsptoCopy:=[Combined Inspections:90]BMSInspID:3  // save the BMS id to copy before dup
If (vInsptoCopy=0)
	vInsptoCopy:=-1  //make sure it is -1
End if 

//Save the Current inspection selection
//COPY NAMED SELECTION([Inspections];"OldInspections")
$oldInspID:=[Inspections:27]InspID:2
DUPLICATE RECORD:C225([Inspections:27])
[Inspections:27]InspID:2:=0
Inc_Sequence("Inspections"; ->[Inspections:27]InspID:2)

//Duplicate Special Inspection from Combined Inspection
//Added on 01/12/05
If ($vbSpecialInspFlag)
	Case of 
		: (([Inspections:27]Insp Type:6="RT@") | ([Inspections:27]Insp Type:6="CUL"))  //highway
			[Inspections:27]Insp Type:6:="CMI"
		: ([Inspections:27]Insp Type:6="T@")  //Tunnel
			[Inspections:27]Insp Type:6:="TSP"
		: ([Inspections:27]Insp Type:6="RR@")  //Rail
			[Inspections:27]Insp Type:6:="RRS"
		Else 
			[Inspections:27]Insp Type:6:="CMI"
	End case 
	
End if 

If ($vbNormalCopy)
	MESSAGE:C88(<>sCR+"   Configuring Inspection...")
	
	//add this to avoid errors in G_SIA2Inspection from PushChange calls 
	//- stack is reinited later for all fields
	InitChangeStack(1)
	
	//SJH 04/22/2004 Apply new default font style to Inspection Comments     
	C_TEXT:C284(vInspFontName)  // Command Replaced was o_C_STRING length was 132
	C_LONGINT:C283(vInspFontSize)  //Command Replaced was o_C_INTEGER
	vInspFontName:="Arial"
	vInspFontSize:=11
	//removed setting of default font and size
	
	//Update Dates  and info from [Bridge MHD NBIS] table
	G_SIA2Inspection
	
	TimeStamp_ut(->[Inspections:27]; ->[Inspections:27]DateCreated:135; ->[Inspections:27]TimeCreated:136; ->[Inspections:27]DateModified:137; ->[Inspections:27]TimeModified:138)
	[Inspections:27]Insp Date:78:=Current date:C33(*)
	[Inspections:27]Modified By:134:=Current user:C182
	[Inspections:27]DateCreated:135:=Current date:C33(*)
	[Inspections:27]TimeCreated:136:=Current time:C178(*)
	[Inspections:27]DateModified:137:=Current date:C33(*)
	[Inspections:27]TimeModified:138:=Current time:C178(*)
	//Now mark inspection as incomplete and not approved
	[Inspections:27]InspComplete:168:=False:C215
	[Inspections:27]InspFldWorkComplDate:224:=!00-00-00!
	[Inspections:27]InspCompleteDate:221:=!00-00-00!
	
	[Inspections:27]InspReviewed:12:=BMS Not Reviewed
	[Inspections:27]InspDBIEReviewDate:222:=!00-00-00!
	[Inspections:27]InspDBIE1stApprDate:225:=!00-00-00!
	[Inspections:27]InspDBIEApprDate:206:=!00-00-00!
	[Inspections:27]InspRevCmts:170:=""
	
	[Inspections:27]InspApproved:167:=BMS Not Reviewed
	[Inspections:27]InspAIEReviewDate:223:=!00-00-00!
	[Inspections:27]InspAreaEngApprDate:207:=!00-00-00!
	[Inspections:27]InspApprCmts:169:=""
	[Inspections:27]InDepthReview:5:=0
	
	[Inspections:27]ConsScoring:201:=0
	[Inspections:27]ConsScoreCmts:208:=""
	[Inspections:27]ConsAcceptanceDate:202:=!00-00-00!
	
	[Inspections:27]TeamLeader:4:=0
	[Inspections:27]DBrInspEngr:3:=0
	[Inspections:27]ConsQCEngrID:205:=0
	//[Inspections]Agency:=""
	[Inspections:27]RatingFeedBack:203:=""
	[Inspections:27]Rerating:75:=False:C215
	[Inspections:27]RatingPriority:85:=""
	[Inspections:27]RatingTxt:76:=""
	[Inspections:27]InitialInsp:9:=False:C215
	
	If (<>CurrentUser_PID>0)
		C_LONGINT:C283($JobCode_L)
		Begin SQL
			select [Personnel].[Job Code] from [Personnel] where [Personnel].[Person ID] = :[<>CurrentUser_PID] into :$JobCode_L ;
		End SQL
		If ($JobCode_L=2) | ($JobCode_L=1)  //TL or DBIE
			[Inspections:27]TeamLeader:4:=<>CurrentUser_PID
		End if 
	End if 
	//save the record
End if   //IF Normal Copy

SAVE RECORD:C53([Inspections:27])
$vlNBISInspectionID:=[Inspections:27]InspID:2
//set the Forward 

If ([Inspections:27]TeamLeader:4>0)
	vsForward:=Synch_ReturnForward([Bridge MHD NBIS:1]Item2:60; [Bridge MHD NBIS:1]InspResp:173; [Inspections:27]Insp Type:6; [Inspections:27]TeamLeader:4)
Else 
	vsForward:=Synch_ReturnForward([Bridge MHD NBIS:1]Item2:60; [Bridge MHD NBIS:1]InspResp:173; [Inspections:27]Insp Type:6; <>CurrentUser_PID)
End if 


//Log record of new inspection here
LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; "Inspections")
//Log stuff for all the fields in the Insp record.
InitChangeStack(1)
C_LONGINT:C283($viFldType)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($vtSkipFields)
$vtSkipFields:=";InspID;BIN;"
If (Substring:C12(<>Version; 1; (Position:C15(" "; <>Version)-1))<"5.0")
	$vtSkipFields:=$vtSkipFields+"InspRtnSpcMemFlag"+";"
End if 

For ($i; 1; $Num_I_Fields)
	$FieldName:=Field name:C257($a_Ptr_InspFields{$i})
	If (Position:C15((";"+$FieldName+";"); $vtSkipFields)=0)  //Skip BIN and INSPID
		GET FIELD PROPERTIES:C258($a_Ptr_InspFields{$i}; $viFldType)
		If ($viFldType#Is subtable:K8:11)  //AND subtables
			PushChange(1; $a_Ptr_InspFields{$i})
		End if 
	End if 
End for 

FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
If ([Inspections:27]TeamLeader:4#0)
	LogLink(->[Inspections:27]TeamLeader:4; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[Personnel:42]Person ID:1)
Else 
	LogChanges(->[Inspections:27]TeamLeader:4; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
End if 
If ([Inspections:27]ConsQCEngrID:205#0)
	LogLink(->[Inspections:27]ConsQCEngrID:205; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[Personnel:42]Person ID:1)
Else 
	LogChanges(->[Inspections:27]ConsQCEngrID:205; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
End if 
If ([Inspections:27]DBrInspEngr:3#0)
	LogLink(->[Inspections:27]DBrInspEngr:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[Personnel:42]Person ID:1)
Else 
	LogChanges(->[Inspections:27]DBrInspEngr:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
End if 

//CLEAR NAMED SELECTION("OldInspections")

//do the tunnelinsp record if any
QUERY:C277([TunnelInspection:152]; [TunnelInspection:152]InspID:1=$oldInspID)
If (Records in selection:C76([TunnelInspection:152])=1)
	LOAD RECORD:C52([TunnelInspection:152])
	DUPLICATE RECORD:C225([TunnelInspection:152])
	[TunnelInspection:152]TunnelInspID_L:15:=0
	Inc_Sequence("TunnelInspection"; ->[TunnelInspection:152]TunnelInspID_L:15)
	$vtSkipFields:=";TunnelInspID_L;InspID;"
	[TunnelInspection:152]InspID:1:=$vlNBISInspectionID
	
	If ($vbNormalCopy)
		MESSAGE:C88(<>sCR+"   Configuring Tunnel Inspection info...")
		
		[TunnelInspection:152]QA_QC_L:2:=TNL_QAQCEngr_L(String:C10(Num:C11([Bridge MHD NBIS:1]Item2:60)))
		
		TNL_SIA_Insp("SIA2INSP")
		
	End if   //IF Normal Copy
	SAVE RECORD:C53([TunnelInspection:152])
	LogNewRecord(->[Inspections:27]InspID:2; ->[TunnelInspection:152]InspID:1; ->[TunnelInspection:152]TunnelInspID_L:15; 2; "TunnelInspection")
	InitChangeStack(1)
	For ($j; 1; $Num_Tinsp_Fields)
		$FieldName:=Field name:C257($a_Ptr_TinspFields{$j})
		If (Position:C15((";"+$FieldName+";"); $vtSkipFields)=0)  //Skip  Ids
			PushChange(1; $a_Ptr_TinspFields{$j})
		End if 
	End for 
	FlushGrpChgs(1; ->[Inspections:27]InspID:2; ->[TunnelInspection:152]InspID:1; ->[TunnelInspection:152]TunnelInspID_L:15; 2)
	
	If ([TunnelInspection:152]QA_QC_L:2#0)
		LogLink(->[TunnelInspection:152]QA_QC_L:2; ->[Inspections:27]InspID:2; ->[TunnelInspection:152]InspID:1; ->[TunnelInspection:152]TunnelInspID_L:15; 2; ->[Personnel:42]Person ID:1)
	Else 
		LogChanges(->[TunnelInspection:152]QA_QC_L:2; ->[Inspections:27]InspID:2; ->[TunnelInspection:152]InspID:1; ->[TunnelInspection:152]TunnelInspID_L:15; 2)
	End if 
	
End if 

//Search for elementssafety 

QUERY:C277([ElementsSafety:29]; [ElementsSafety:29]InspID:4=$oldInspID)
//Collect the Safety Elements for the old Inspection
$NoElmts:=Records in selection:C76([ElementsSafety:29])
COPY NAMED SELECTION:C331([ElementsSafety:29]; "OldElements")
MESSAGE:C88(<>sCR+"   Copying "+String:C10($NoElmts)+" Insp Elmts...")

//Modified on 01/12/2005
For ($i; 1; $NoElmts)
	MESSAGE:C88("..."+String:C10($i))
	Case of 
		: (($vbSpecialInspFlag & [ElementsSafety:29]SpecMemb Flag:8) | Not:C34($vbSpecialInspFlag))
			QUERY:C277([ElmtRatingLoads:158]; [ElmtRatingLoads:158]ElmSafetyID:2=[ElementsSafety:29]ElmSafetyID:7)
			DUPLICATE RECORD:C225([ElementsSafety:29])
			[ElementsSafety:29]ElmSafetyID:7:=0
			Inc_Sequence("ElementsSafety"; ->[ElementsSafety:29]ElmSafetyID:7)
			[ElementsSafety:29]InspID:4:=$vlNBISInspectionID
			
			Case of 
				: ([Inspections:27]Insp Type:6="FRZ")
					C_TEXT:C284($var_txt)
					$var_txt:=""
					If (BLOB size:C605([ElementsSafety:29]ElmComments:23)>0)
						BLOB TO VARIABLE:C533([ElementsSafety:29]ElmComments:23; $var_txt)
						SET BLOB SIZE:C606([ElementsSafety:29]ElmComments:23; 0)
					End if 
					
					If ($var_txt#"")
						If ([ElementsSafety:29]Comments:5#"")
							[ElementsSafety:29]Comments:5:=$var_txt+Char:C90(13)+[ElementsSafety:29]Comments:5
						Else 
							[ElementsSafety:29]Comments:5:=$var_txt
						End if 
						
					End if 
					
				Else 
					//remove setting any default font and size - all should be Arial 11 by now
					
			End case 
			
			SAVE RECORD:C53([ElementsSafety:29])
			
			//Log the new record and its data
			LogNewRecord(->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2; "ElementsSafety")
			InitChangeStack(1)
			For ($j; 1; $Num_El_Fields)
				$FieldName:=Field name:C257($a_Ptr_ElFields{$j})
				If (($FieldName#"InspID") & ($FieldName#"ElmSafetyID"))  //Skip Ids
					PushChange(1; $a_Ptr_ElFields{$j})
				End if 
			End for 
			FlushGrpChgs(1; ->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2)
			
			//***************
			If (Is record loaded:C669([ElmtRatingLoads:158]))
				DUPLICATE RECORD:C225([ElmtRatingLoads:158])
				Inc_Sequence("ElmtRatingLoads"; ->[ElmtRatingLoads:158]ElmtRtgLoadID_L:1)
				[ElmtRatingLoads:158]ElmSafetyID:2:=[ElementsSafety:29]ElmSafetyID:7
				SAVE RECORD:C53([ElmtRatingLoads:158])
				LogNewRecord(->[ElementsSafety:29]ElmSafetyID:7; ->[ElmtRatingLoads:158]ElmSafetyID:2; ->[ElmtRatingLoads:158]ElmtRtgLoadID_L:1; 2; "ElmtRatingLoads")
				InitChangeStack(1)
				For ($j; 1; Get last field number:C255(->[ElmtRatingLoads:158]))
					$FieldName:=Field name:C257(Table:C252(->[ElmtRatingLoads:158]); $j)
					If (($FieldName#"ElmtRtgLoadID_L") & ($FieldName#"ElmSafetyID"))  //Skip Ids
						PushChange(1; Field:C253(Table:C252(->[ElmtRatingLoads:158]); $j))
					End if 
				End for 
				FlushGrpChgs(1; ->[ElementsSafety:29]ElmSafetyID:7; ->[ElmtRatingLoads:158]ElmSafetyID:2; ->[ElmtRatingLoads:158]ElmtRtgLoadID_L:1; 2)
			End if 
			//***************
			
			USE NAMED SELECTION:C332("OldElements")
	End case 
	
	NEXT RECORD:C51([ElementsSafety:29])
	COPY NAMED SELECTION:C331([ElementsSafety:29]; "OldElements")  //Dec-2001 : need to do this to keep track of current record  
End for 

CLEAR NAMED SELECTION:C333("OldElements")

QUERY:C277([Standard Photos:36]; [Standard Photos:36]InspID:1=$oldInspID)

If ($vbNormalCopy)
	//if doing a normal copy consider only sketches charts photos
	QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Sketch; *)
	QUERY SELECTION:C341([Standard Photos:36];  | ; [Standard Photos:36]PictType:5=BMS Chart; *)
	QUERY SELECTION:C341([Standard Photos:36];  | ; [Standard Photos:36]PictType:5=BMS Photo)
End if 

$NoImgs:=Records in selection:C76([Standard Photos:36])

If ($vbNormalCopy)
	
	If ((DupInsp_CopyPhotos_L+DupInsp_CopySketches_L+DupInsp_CopyCharts_L)=0)
		$NoImgs:=0
	End if 
	
End if 

If ($NoImgs>0)
	MESSAGE:C88(<>sCR+"   Copying "+String:C10($NoImgs)+" Images...")
	COPY NAMED SELECTION:C331([Standard Photos:36]; "OldImages")
	
	For ($i; 1; $NoImgs)
		Case of 
			: (([Standard Photos:36]PictType:5=BMS Photo) & (DupInsp_CopyPhotos_L=0))
			: (([Standard Photos:36]PictType:5=BMS Sketch) & (DupInsp_CopySketches_L=0))
			: (([Standard Photos:36]PictType:5=BMS Chart) & (DupInsp_CopyCharts_L=0))
			Else 
				MESSAGE:C88("..."+String:C10($i))
				DUPLICATE RECORD:C225([Standard Photos:36])
				[Standard Photos:36]StdPhotoID:7:=0
				Inc_Sequence("StandardPhotos"; ->[Standard Photos:36]StdPhotoID:7)
				[Standard Photos:36]InspID:1:=$vlNBISInspectionID
				SAVE RECORD:C53([Standard Photos:36])
				
				// log the change/duplication here
				LogNewRecord(->[Inspections:27]InspID:2; ->[Standard Photos:36]InspID:1; ->[Standard Photos:36]StdPhotoID:7; 2; "StandardPhotos")
				InitChangeStack(1)
				For ($j; 1; $Num_Img_Fields)
					$FieldName:=Field name:C257($a_Ptr_ImgFields{$j})
					If (($FieldName#"InspID") & ($FieldName#"StdPhotoID"))  //Skip Ids
						PushChange(1; $a_Ptr_ImgFields{$j})
					End if 
				End for 
				FlushGrpChgs(1; ->[Inspections:27]InspID:2; ->[Standard Photos:36]InspID:1; ->[Standard Photos:36]StdPhotoID:7; 2)
				
		End case 
		
		USE NAMED SELECTION:C332("OldImages")
		NEXT RECORD:C51([Standard Photos:36])
		COPY NAMED SELECTION:C331([Standard Photos:36]; "OldImages")  //Dec-2001 : need to do this to keep track of current record
	End for 
	
	CLEAR NAMED SELECTION:C333("OldImages")
End if 

PON_INIT

C_LONGINT:C283($noNBEs_L)

If (Not:C34($vbNormalCopy))
	//copying inspection as is.
	QUERY:C277([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]INSPID:21=$oldInspID)
	$noNBEs_L:=Records in selection:C76([PON_ELEM_INSP:179])
	If ($noNBEs_L>0)
		PON_DuplicateNBEs($vlNBISInspectionID; 1; $vbNormalCopy)  //use change stack # 1
	End if 
	
Else 
	
	//Check which inspections need NBEs
	C_TEXT:C284($NBEInspectionTypes_txt)
	$NBEInspectionTypes_txt:=ut_GetSysParameter("INSPTYPESWNBES"; "RTN,RTA,CUL,CMI,OTH,RRR,RRA,RRC")
	If (Position:C15([Inspections:27]Insp Type:6; $NBEInspectionTypes_txt)>0)
		C_LONGINT:C283($oldstack_L; PON_ChangeStackLvl_L)
		$oldstack_L:=PON_ChangeStackLvl_L
		PON_ChangeStackLvl_L:=1  // set the stack to be used to 1
		PON_CopyElements(False:C215)  // copy but don't update HI - done when the BMS Inspection is created
		$noNBEs_L:=Records in selection:C76([PON_ELEM_INSP:179])  // count how many were created
		PON_ChangeStackLvl_L:=$oldstack_L
		
	End if 
	
End if 


//***************************************************************
//2005-02-28 ASL
//Duplicate the BMS Inspection if it exists.
// have to copy if  there were NBEs
If ((vInsptoCopy#-1) & (Not:C34($vbSpecialInspFlag) | ($noNBEs_L>0)))  //don't copy the BMS record if we are copying from Routine+Spec Memb to Spec Memb
	
	MESSAGE:C88(<>sCR+"   Copying BMS record...")
	
	//2005-02-18 ASL
	//Duplicate the BMS Inspection
	
	If (vInsptoCopy>0)
		QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=vInsptoCopy)
		//Duplicate the Pontis record.
		DUPLICATE RECORD:C225([BMS Inspections:44])
		
	Else 
		// if there is no inspection to copy - we have to create a new one.
		CREATE RECORD:C68([BMS Inspections:44])
	End if 
	
	//This is a new record.    
	Inc_Sequence("Pontis Insp ID"; ->[BMS Inspections:44]Inspection ID:1)
	//Save the BMS Inspection ID for later
	$vlBMSInspectionID:=[BMS Inspections:44]Inspection ID:1
	If ($vbNormalCopy)
		[BMS Inspections:44]BIN:2:=[Bridge MHD NBIS:1]BIN:3
		[BMS Inspections:44]Insp Date:4:=Current date:C33(*)
		[BMS Inspections:44]Span Group No:3:=1
		[BMS Inspections:44]Metric:14:=False:C215  //Change this default after all old inspections are entered.
		[BMS Inspections:44]TeamLeader:6:=[Inspections:27]TeamLeader:4
		[BMS Inspections:44]DBrInspEngr:5:=0
		TimeStamp_ut(->[BMS Inspections:44]; ->[BMS Inspections:44]DateCreated:8; ->[BMS Inspections:44]TimeCreated:9; ->[BMS Inspections:44]DateModified:10; ->[BMS Inspections:44]TimeModified:11)
		[BMS Inspections:44]Modified By:7:=Current user:C182
	End if 
	
	SAVE RECORD:C53([BMS Inspections:44])
	
	//Record the log.
	LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; "Pontis Insp ID")
	//testvar:=ddtwoyearsto-PONEFFECTIVEdate-orsubtracttwo-from-currentdate-Add to date(Current date(*);-2;0;-1)-twoyears-andaday
	If (Not:C34(PON_NBEDateOn_b(Add to date:C393(Current date:C33(*); -2; 0; -1))))
		//do not copy CUs for inspections on or after the NBE start date, or if doing a copy as is *** copy as is does not matter 
		InitChangeStack(1)  //need this for the InitChangeStack(2)'s in DUPLIC_INSP_NEW
		//Duplicate the set of element records for the inspection selected to be copied  
		DUPLIC_INSP_NEW(True:C214)  //True : To enable messages
	Else 
		//the NBES are always copied!!!!
	End if 
	
	INSP_HICalcControl("ALL"; 1)  //Do a complete calculation - use stack 1 for changes
	//The field Metric may have been updated, so save it.
	SAVE RECORD:C53([BMS Inspections:44])
	$InspTable:=Table:C252(->[BMS Inspections:44])
	$Num_I_Fields:=Get last field number:C255($InspTable)
	$vtSkipFields:=";Inspection ID;BIN;"
	For ($i; 1; $Num_I_Fields)
		$FieldName:=Field name:C257($InspTable; $i)
		If (Position:C15((";"+$FieldName+";"); $vtSkipFields)=0)
			GET FIELD PROPERTIES:C258($InspTable; $i; $viFldType)
			If ($viFldType#Is subtable:K8:11)  //AND subtables
				PushChange(1; Field:C253($InspTable; $i))
			End if 
		End if 
	End for 
	FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1)
	If ([BMS Inspections:44]TeamLeader:6>0)
		LogLink(->[BMS Inspections:44]TeamLeader:6; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; ->[Personnel:42]Person ID:1)
	End if 
	
Else 
	$vlBMSInspectionID:=-1
End if 

//need to check if now there is a BMS Inspection record if we have NBES
If ($vbNormalCopy)  //unless we re doing a COPY AS IS
	If ($noNBEs_L>0) & ($vlBMSInspectionID<=0)
		//we have NBEs but no BMSInsp record  ---  MUST CREATE a BMSInsp record
		MESSAGE:C88(<>sCR+"   Creating required BMS record...")
		
		CREATE RECORD:C68([BMS Inspections:44])
		[BMS Inspections:44]Inspection ID:1:=0
		Inc_Sequence("Pontis Insp ID"; ->[BMS Inspections:44]Inspection ID:1)
		//Save the BMS Inspection ID for later
		$vlBMSInspectionID:=[BMS Inspections:44]Inspection ID:1
		[BMS Inspections:44]BIN:2:=[Bridge MHD NBIS:1]BIN:3
		[BMS Inspections:44]Insp Date:4:=[Inspections:27]Insp Date:78
		[BMS Inspections:44]Span Group No:3:=1
		[BMS Inspections:44]Metric:14:=False:C215  //Change this default after all old inspections are entered.
		[BMS Inspections:44]TeamLeader:6:=[Inspections:27]TeamLeader:4
		[BMS Inspections:44]DBrInspEngr:5:=0
		TimeStamp_ut(->[BMS Inspections:44]; ->[BMS Inspections:44]DateCreated:8; ->[BMS Inspections:44]TimeCreated:9; ->[BMS Inspections:44]DateModified:10; ->[BMS Inspections:44]TimeModified:11)
		[BMS Inspections:44]Modified By:7:=Current user:C182
		
		INSP_HICalcControl("ALL"; 1)  //Do a complete calculation - use stack 1 for changes
		
		SAVE RECORD:C53([BMS Inspections:44])
		
		//Record the log.
		LogNewRecordChanges(->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; "Pontis Insp ID"; 1; ->[BMS Inspections:44]TeamLeader:6; ->[BMS Inspections:44]DBrInspEngr:5)
		If ([BMS Inspections:44]TeamLeader:6>0)
			LogLink(->[BMS Inspections:44]TeamLeader:6; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; ->[Personnel:42]Person ID:1)
		End if 
		If ([BMS Inspections:44]DBrInspEngr:5>0)
			LogLink(->[BMS Inspections:44]DBrInspEngr:5; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; ->[Personnel:42]Person ID:1)
		End if 
		
	End if 
	
End if 

If (Not:C34($vbNormalCopy))
	//copy also team members if copying as is
	QUERY:C277([Field Trip:43]; [Field Trip:43]InspID:1=$oldInspID)
	C_LONGINT:C283($NoTeamMbrs)
	ARRAY INTEGER:C220($arTeamMbrs; 0)
	SELECTION TO ARRAY:C260([Field Trip:43]Person ID:2; $arTeamMbrs)
	$NoTeamMbrs:=Size of array:C274($arTeamMbrs)
	If ($NoTeamMbrs>0)
		MESSAGE:C88(<>sCR+"   Copying "+String:C10($NoTeamMbrs)+" Insp Team Members...")
		For ($i; 1; $NoTeamMbrs)
			MESSAGE:C88("..."+String:C10($i))
			CREATE RECORD:C68([Field Trip:43])
			[Field Trip:43]InspID:1:=[Inspections:27]InspID:2
			[Field Trip:43]Person ID:2:=$arTeamMbrs{$i}
			LogNewRecord(->[Inspections:27]InspID:2; ->[Field Trip:43]InspID:1; ->[Field Trip:43]Person ID:2; 3; ""; ->[Personnel:42]Person ID:1)
			SAVE RECORD:C53([Field Trip:43])
		End for 
		If ($vlBMSInspectionID>0)
			MESSAGE:C88(<>sCR+"   Copying "+String:C10($NoTeamMbrs)+" Pontis Team Members...")
			For ($i; 1; $NoTeamMbrs)
				MESSAGE:C88("..."+String:C10($i))
				CREATE RECORD:C68([BMS Field Trip:56])
				[BMS Field Trip:56]Inspection ID:1:=[BMS Inspections:44]Inspection ID:1
				[BMS Field Trip:56]Person ID:2:=$arTeamMbrs{$i}
				LogNewRecord(->[BMS Inspections:44]Inspection ID:1; ->[BMS Field Trip:56]Inspection ID:1; ->[BMS Field Trip:56]Person ID:2; 3; ""; ->[Personnel:42]Person ID:1)
				SAVE RECORD:C53([BMS Field Trip:56])
			End for 
			
		End if 
		
	End if 
	
End if 

MESSAGE:C88(<>sCR+" Linking...")

//Add a record for a new combined inspection  
CREATE RECORD:C68([Combined Inspections:90])
Inc_Sequence("CombinedInspections"; ->[Combined Inspections:90]ID:6)
$vlCombInspectionID:=[Combined Inspections:90]ID:6
[Combined Inspections:90]BIN:1:=[Bridge MHD NBIS:1]BIN:3
//2004-08-03 ASL
//This should be a fixed parent record and relative local record
LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1; "CombinedInspections")
InitChangeStack(1)
[Combined Inspections:90]InspDate:4:=[Inspections:27]Insp Date:78
[Combined Inspections:90]InspType:5:=[Inspections:27]Insp Type:6
PushChange(1; ->[Combined Inspections:90]InspDate:4)
PushChange(1; ->[Combined Inspections:90]InspType:5)
FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
[Combined Inspections:90]NBISInspID:2:=$vlNBISInspectionID
//This is a relative field
LogLink(->[Combined Inspections:90]NBISInspID:2; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
[Combined Inspections:90]BMSInspID:3:=$vlBMSInspectionID
//This is a relative field
LogLink(->[Combined Inspections:90]BMSInspID:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
SAVE RECORD:C53([Combined Inspections:90])

//Load the new record that just duplicated
QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]ID:6=$vlCombInspectionID)

//RELATE ONE([Combined Inspections])
QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[Combined Inspections:90]NBISInspID:2)
QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
COPY NAMED SELECTION:C331([Combined Inspections:90]; "curCombinedInspection")
InitChangeStack(1)
If (INSP_IsInspRoutine_b)
	MESSAGE:C88(<>sCR+" Updating UW values...")
	INSP_GetUWValues_Btn(False:C215)
End if 
MESSAGE:C88(<>sCR+" Updating Rating values...")
G_InspGetRatings(False:C215)
FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
SAVE RECORD:C53([Inspections:27])

USE NAMED SELECTION:C332("curCombinedInspection")
//QUERY([Inspections];[Inspections]InspID=[Combined Inspections]NBISInspID)
//QUERY([BMS Inspections];[BMS Inspections]Inspection ID=[Combined Inspections]BMSInspID)

CLOSE WINDOW:C154
SET CURSOR:C469(0)
FORM SET INPUT:C55([Inspections:27]; "BlankCombinedStarter")
MODIFY RECORD:C57([Inspections:27])