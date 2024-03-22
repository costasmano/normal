//%attributes = {"invisible":true}
//G_RoutinetoBMS
//Transfer  Inspection data from [Inspections] table to [Bridge MHD NBIS]
If (False:C215)
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(2/14/2007 09:57:33)
	Mods_2007_CM06
	// Modified by: costasmanousakis-(Designer)-(8/29/2007 11:38:58)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(11/18/07 19:49:18)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(11/20/07 12:46:27)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(12/20/07 15:05:24)
	Mods_2007_CM_5401
	//  `Use the single axle posting if it is not zero and apply equal to the SIA record 2,3,5 axle
	// Modified by: Costas Manousakis-(Designer)-(10/2/13 14:01:56)
	Mods_2013_10
	//  `Don't check spec mem frequencies for Tunnel inspections (type= T@)
	// Modified by: Costas Manousakis-(Designer)-(11/21/16 15:20:33)
	Mods_2016_11
	//  `added Culvert items in the list to be transferred to SIA
	Mods_2018_10  //Add code and fields to allow for entry and reporting of single posting
	//Modified by: Chuck Miller (10/23/18 12:49:39)
	// Modified by: Costas Manousakis-(Designer)-(1/23/19 13:38:36)
	Mods_2019_01_bug
	//  `added pushchange for Item91 when checking spec memb frequency
End if 
C_BOOLEAN:C305($RecordLoaded_b; $one_b; $many_b)
GET AUTOMATIC RELATIONS:C899($one_b; $many_b)
SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
$RecordLoaded_b:=ut_LoadRecordInteractive(->[Bridge MHD NBIS:1])
If ($RecordLoaded_b)
	[Bridge MHD NBIS:1]Item90:161:=[Inspections:27]Insp Date:78
	InitChangeStack(1)
	PushChange(1; ->[Bridge MHD NBIS:1]Item90:161)
	If ([Bridge MHD NBIS:1]DateModified:194#Current date:C33(*))
		[Bridge MHD NBIS:1]DateModified:194:=Current date:C33(*)
		PushChange(1; ->[Bridge MHD NBIS:1]DateModified:194)
	End if 
	[Bridge MHD NBIS:1]TimeModified:195:=Current time:C178(*)
	PushChange(1; ->[Bridge MHD NBIS:1]TimeModified:195)
	If ([Bridge MHD NBIS:1]Modified By:191#Current user:C182)
		[Bridge MHD NBIS:1]Modified By:191:=Current user:C182
		PushChange(1; ->[Bridge MHD NBIS:1]Modified By:191)
	End if 
	
	If (G_Insp_CountSpMs>0)
		[Bridge MHD NBIS:1]Item93C:171:=[Inspections:27]Insp Date:78
		PushChange(1; ->[Bridge MHD NBIS:1]Item93C:171)
	End if 
	If ([Bridge MHD NBIS:1]Item36A:147#[Inspections:27]Railing36:22)
		[Bridge MHD NBIS:1]Item36A:147:=[Inspections:27]Railing36:22
		PushChange(1; ->[Bridge MHD NBIS:1]Item36A:147)
	End if 
	If ([Bridge MHD NBIS:1]Item36B:148#[Inspections:27]Transitions36:23)
		[Bridge MHD NBIS:1]Item36B:148:=[Inspections:27]Transitions36:23
		PushChange(1; ->[Bridge MHD NBIS:1]Item36B:148)
	End if 
	If ([Bridge MHD NBIS:1]Item36C:149#[Inspections:27]ApprGrdRail36:24)
		[Bridge MHD NBIS:1]Item36C:149:=[Inspections:27]ApprGrdRail36:24
		PushChange(1; ->[Bridge MHD NBIS:1]Item36C:149)
	End if 
	If ([Bridge MHD NBIS:1]Item36D:150#[Inspections:27]ApprGdRailEnd36:25)
		[Bridge MHD NBIS:1]Item36D:150:=[Inspections:27]ApprGdRailEnd36:25
		PushChange(1; ->[Bridge MHD NBIS:1]Item36D:150)
	End if 
	If ([Bridge MHD NBIS:1]Item41:141#[Inspections:27]Item 41:77)
		[Bridge MHD NBIS:1]Item41:141:=[Inspections:27]Item 41:77
		PushChange(1; ->[Bridge MHD NBIS:1]Item41:141)
	End if 
	
	If ([Inspections:27]Insp Type:6="RT@")
		If ([Bridge MHD NBIS:1]Item58:130#G_Insp_VerifyItem([Inspections:27]Item 58:79))
			[Bridge MHD NBIS:1]Item58:130:=G_Insp_VerifyItem([Inspections:27]Item 58:79)
			PushChange(1; ->[Bridge MHD NBIS:1]Item58:130)
		End if 
		If ([Bridge MHD NBIS:1]Item59:131#G_Insp_VerifyItem([Inspections:27]Item 59:80))
			[Bridge MHD NBIS:1]Item59:131:=G_Insp_VerifyItem([Inspections:27]Item 59:80)
			PushChange(1; ->[Bridge MHD NBIS:1]Item59:131)
		End if 
		If ([Bridge MHD NBIS:1]Item60:132#G_Insp_VerifyItem([Inspections:27]Item 60:81))
			[Bridge MHD NBIS:1]Item60:132:=G_Insp_VerifyItem([Inspections:27]Item 60:81)
			PushChange(1; ->[Bridge MHD NBIS:1]Item60:132)
		End if 
	End if 
	
	If ([Bridge MHD NBIS:1]Item61:133#G_Insp_VerifyItem([Inspections:27]Item 61:82))
		[Bridge MHD NBIS:1]Item61:133:=G_Insp_VerifyItem([Inspections:27]Item 61:82)
		PushChange(1; ->[Bridge MHD NBIS:1]Item61:133)
	End if 
	If ([Bridge MHD NBIS:1]Item62:134#G_Insp_VerifyItem([Inspections:27]Item 62:113))
		[Bridge MHD NBIS:1]Item62:134:=G_Insp_VerifyItem([Inspections:27]Item 62:113)
		PushChange(1; ->[Bridge MHD NBIS:1]Item62:134)
	End if 
	If ([Bridge MHD NBIS:1]InspectionHRS:40#[Inspections:27]Total HRS:68)
		[Bridge MHD NBIS:1]InspectionHRS:40:=[Inspections:27]Total HRS:68
		PushChange(1; ->[Bridge MHD NBIS:1]InspectionHRS:40)
	End if 
	
	If ([Bridge MHD NBIS:1]Posting2Axle:9#[Inspections:27]ActualPostH:26)
		[Bridge MHD NBIS:1]Posting2Axle:9:=[Inspections:27]ActualPostH:26
		PushChange(1; ->[Bridge MHD NBIS:1]Posting2Axle:9)
	End if 
	If ([Bridge MHD NBIS:1]Posting3Axle:10#[Inspections:27]ActualPost3:27)
		[Bridge MHD NBIS:1]Posting3Axle:10:=[Inspections:27]ActualPost3:27
		PushChange(1; ->[Bridge MHD NBIS:1]Posting3Axle:10)
	End if 
	If ([Bridge MHD NBIS:1]Posting5Axle:11#[Inspections:27]ActualPost3S2:28)
		[Bridge MHD NBIS:1]Posting5Axle:11:=[Inspections:27]ActualPost3S2:28
		PushChange(1; ->[Bridge MHD NBIS:1]Posting5Axle:11)
	End if 
	If ([Bridge MHD NBIS:1]PostingSingle:231#[Inspections:27]ActualPostSgl:29)
		[Bridge MHD NBIS:1]PostingSingle:231:=[Inspections:27]ActualPostSgl:29
		PushChange(1; ->[Bridge MHD NBIS:1]PostingSingle:231)
	End if 
	
	If ([Inspections:27]Insp Type:6#"T@")
		If (INSP_CheckSpcMfrFreq)
			PushChange(1; ->[Bridge MHD NBIS:1]Item92CA:167)
			PushChange(1; ->[Bridge MHD NBIS:1]Item92CB:168)
			PushChange(1; ->[Bridge MHD NBIS:1]Item91:162)
		End if 
	End if 
	If ([Inspections:27]BarrelsHeight:180>0)
		
		If ([Bridge MHD NBIS:1]BarrelsHeight:189#[Inspections:27]BarrelsHeight:180)
			[Bridge MHD NBIS:1]BarrelsHeight:189:=[Inspections:27]BarrelsHeight:180
			PushChange(1; ->[Bridge MHD NBIS:1]BarrelsHeight:189)
		End if 
	End if 
	If ([Inspections:27]BarrelsNumber:175>0)
		
		If ([Bridge MHD NBIS:1]BarrelsNumber:188#[Inspections:27]BarrelsNumber:175)
			[Bridge MHD NBIS:1]BarrelsNumber:188:=[Inspections:27]BarrelsNumber:175
			PushChange(1; ->[Bridge MHD NBIS:1]BarrelsNumber:188)
		End if 
	End if 
	If ([Inspections:27]BarrelsWidth:179>0)
		
		If ([Bridge MHD NBIS:1]BarrelsWidth:190#[Inspections:27]BarrelsWidth:179)
			[Bridge MHD NBIS:1]BarrelsWidth:190:=[Inspections:27]BarrelsWidth:179
			PushChange(1; ->[Bridge MHD NBIS:1]BarrelsWidth:190)
		End if 
	End if 
	If ([Inspections:27]CulvertCoating:176>"")
		
		If ([Bridge MHD NBIS:1]CulvertCoating:187#[Inspections:27]CulvertCoating:176)
			[Bridge MHD NBIS:1]CulvertCoating:187:=[Inspections:27]CulvertCoating:176
			PushChange(1; ->[Bridge MHD NBIS:1]CulvertCoating:187)
		End if 
	End if 
	If ([Inspections:27]CulvertMaterial:177>"")
		
		If ([Bridge MHD NBIS:1]CulvertMaterial:186#[Inspections:27]CulvertMaterial:177)
			[Bridge MHD NBIS:1]CulvertMaterial:186:=[Inspections:27]CulvertMaterial:177
			PushChange(1; ->[Bridge MHD NBIS:1]CulvertMaterial:186)
		End if 
	End if 
	If ([Inspections:27]CulvertShape:178>"")
		If ([Bridge MHD NBIS:1]CulvertShape:185#[Inspections:27]CulvertShape:178)
			[Bridge MHD NBIS:1]CulvertShape:185:=[Inspections:27]CulvertShape:178
			PushChange(1; ->[Bridge MHD NBIS:1]CulvertShape:185)
		End if 
	End if 
	G_Accesibility2SIA
	C_BOOLEAN:C305($Continue_B)
	$Continue_B:=(INSP_VerifySIAChanges(1))
	If ($Continue_B)
		[Bridge MHD NBIS:1]AASHTO:5:=AASHTO_SuffRat
		If ([Bridge MHD NBIS:1]AASHTO:5#Old:C35([Bridge MHD NBIS:1]AASHTO:5))
			PushChange(1; ->[Bridge MHD NBIS:1]AASHTO:5)  //This should be recalculated at the remote!
		End if 
		If ([Bridge MHD NBIS:1]Item67:142#Old:C35([Bridge MHD NBIS:1]Item67:142))
			PushChange(1; ->[Bridge MHD NBIS:1]Item67:142)
		End if 
		If ([Bridge MHD NBIS:1]Item68:143#Old:C35([Bridge MHD NBIS:1]Item68:143))
			PushChange(1; ->[Bridge MHD NBIS:1]Item68:143)
		End if 
		If ([Bridge MHD NBIS:1]Item69:144#Old:C35([Bridge MHD NBIS:1]Item69:144))
			PushChange(1; ->[Bridge MHD NBIS:1]Item69:144)
		End if 
		If ([Bridge MHD NBIS:1]Item70:140#Old:C35([Bridge MHD NBIS:1]Item70:140))
			PushChange(1; ->[Bridge MHD NBIS:1]Item70:140)
		End if 
		If ([Bridge MHD NBIS:1]Item91:162#Old:C35([Bridge MHD NBIS:1]Item91:162))
			PushChange(1; ->[Bridge MHD NBIS:1]Item91:162)
		End if 
		
		FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
		
		SAVE RECORD:C53([Bridge MHD NBIS:1])
	End if 
	UNLOAD RECORD:C212([Bridge MHD NBIS:1])
Else 
	C_TEXT:C284($MSG_TXT)
	$MSG_TXT:="COULD NOT LOAD BRIDGE RECORD WITH WRITE ACCESS !!!"+<>SCR
	$MSG_TXT:=$MSG_TXT+"CHANGES WERE NOT TRANSFERED AND HAVE TO BE DO"+"NE MANUALLY!!"
	ALERT:C41($MSG_TXT)
End if 
SET AUTOMATIC RELATIONS:C310($one_b; $many_b)
