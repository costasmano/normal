//%attributes = {"invisible":true}
If (False:C215)
	//G_CulverttoBMS
	//Transfer  Inspection data from [Inspections] table to [Bridge MHD NBIS]
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(2/27/2006 13:55:43)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(2/14/2007 09:59:30)
	Mods_2007_CM06
	Mods_2018_10  //Add code and fields to allow for entry and reporting of single posting
	//Modified by: Chuck Miller (10/18/18 14:59:31)
End if 
C_BOOLEAN:C305($RecordLoaded_b)
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
	
	G_Accesibility2SIA
	
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
	UNLOAD RECORD:C212([Bridge MHD NBIS:1])
Else 
	ALERT:C41("COULD NOT LOAD BRIDGE RECORD!!!"+<>SCR+"ANY CHANGES WERE NOT TRANSFERED AND HAVE TO BE DO"+"NE MANUALLY!!")
End if 