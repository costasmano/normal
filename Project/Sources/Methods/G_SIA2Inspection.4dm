//%attributes = {"invisible":true}
//  G_SIA2Inspection 
//Load info from SIA fields to Inspection fields

If (False:C215)
	
	Mods_2005_CM05
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(10/20/2005 14:12:32)
	Mods_2005_CM17
	// Modified by: costasmanousakis-(Designer)-(11/1/06 11:43:02)
	Mods_2006_CM07
	// Modified by: costasmanousakis-(Designer)-(2/24/09 22:14:50)
	Mods_2009_CM_5404  // --- "FREEZETHAW"
	// Modified by: Costas Manousakis-(Designer)-(5/3/13 09:34:05)
	Mods_2013_05
	//  `Added [Inspections]ConfinedSp
	// Modified by: Costas Manousakis-(Designer)-(10/24/13 10:29:23)
	Mods_2013_10
	//  `use  method  INSP_IsInspRoutine_b to check if inspection is a routine one
	// Modified by: Costas Manousakis-(Designer)-(11/21/16 15:35:01)
	Mods_2016_11
	//  `update Culvert items also
	Mods_2018_10  //Add code and fields to allow for entry and reporting of single posting
	// also zero out H, 3, 3S2 values when Actual posting Single is > 0
	//Modified by: Chuck Miller (10/18/18 14:59:31)
	// Modified by: Costas Manousakis-(Designer)-(5/11/20 19:13:33)
	Mods_2020_05
	//  `adjustments made to comparing culvert ht, wdth to account for the transition from integer to real for the SIA values.
End if 

[Inspections:27]Item 90:142:=[Bridge MHD NBIS:1]Item90:161
PushChange(1; ->[Inspections:27]Item 90:142)
If (INSP_IsInspRoutine_b)
	//for Routine and Culvert inspections set I90 to current date also    
	[Inspections:27]Item 90:142:=Current date:C33(*)
	PushChange(1; ->[Inspections:27]Item 90:142)
End if 

If ([Inspections:27]Insp Type:6#"DV@")
	//Get UW date only if there is a UW frequency in the SIA
	If ([Bridge MHD NBIS:1]Item92BB:166>0)
		[Inspections:27]Item 93b:67:=[Bridge MHD NBIS:1]Item93B:170
		PushChange(1; ->[Inspections:27]Item 93b:67)
	Else 
		[Inspections:27]Item 93b:67:=!00-00-00!
		PushChange(1; ->[Inspections:27]Item 93b:67)
	End if 
Else 
	If (([Inspections:27]Insp Type:6="DVE") | ([Inspections:27]Insp Type:6="DVL"))
		[Inspections:27]Item 93b:67:=Current date:C33(*)
	Else 
		[Inspections:27]Item 93b:67:=[Bridge MHD NBIS:1]Item93B:170
	End if 
	PushChange(1; ->[Inspections:27]Item 93b:67)
End if 
[Inspections:27]Item 43:140:=[Bridge MHD NBIS:1]Item43:75
PushChange(1; ->[Inspections:27]Item 43:140)
[Inspections:27]Item 107:141:=[Bridge MHD NBIS:1]Item107:79
PushChange(1; ->[Inspections:27]Item 107:141)
[Inspections:27]Railing36:22:=[Bridge MHD NBIS:1]Item36A:147
PushChange(1; ->[Inspections:27]Railing36:22)
[Inspections:27]Transitions36:23:=[Bridge MHD NBIS:1]Item36B:148
PushChange(1; ->[Inspections:27]Transitions36:23)
[Inspections:27]ApprGrdRail36:24:=[Bridge MHD NBIS:1]Item36C:149
PushChange(1; ->[Inspections:27]ApprGrdRail36:24)
[Inspections:27]ApprGdRailEnd36:25:=[Bridge MHD NBIS:1]Item36D:150
PushChange(1; ->[Inspections:27]ApprGdRailEnd36:25)
[Inspections:27]Item 41:77:=[Bridge MHD NBIS:1]Item41:141
PushChange(1; ->[Inspections:27]Item 41:77)
[Inspections:27]Item21:166:=[Bridge MHD NBIS:1]Item21:127
PushChange(1; ->[Inspections:27]Item21:166)
[Inspections:27]Item22:197:=[Bridge MHD NBIS:1]Item22:128
PushChange(1; ->[Inspections:27]Item22:197)
[Inspections:27]Item26:200:=[Bridge MHD NBIS:1]Item26:120
PushChange(1; ->[Inspections:27]Item26:200)
[Inspections:27]Item106:198:=[Bridge MHD NBIS:1]Item106:84
PushChange(1; ->[Inspections:27]Item106:198)
[Inspections:27]Item 58:79:=G_Insp_VerifyItem([Bridge MHD NBIS:1]Item58:130)
PushChange(1; ->[Inspections:27]Item 58:79)
[Inspections:27]Item 59:80:=G_Insp_VerifyItem([Bridge MHD NBIS:1]Item59:131)
PushChange(1; ->[Inspections:27]Item 59:80)
[Inspections:27]Item 60:81:=G_Insp_VerifyItem([Bridge MHD NBIS:1]Item60:132)
PushChange(1; ->[Inspections:27]Item 60:81)
[Inspections:27]Item 61:82:=G_Insp_VerifyItem([Bridge MHD NBIS:1]Item61:133)
PushChange(1; ->[Inspections:27]Item 61:82)
[Inspections:27]Agency:156:="MHD Underwater Oper."
PushChange(1; ->[Inspections:27]Agency:156)
If ([Inspections:27]Insp Type:6#"DV@")
	//[Inspections]Agency:="Mass. Highway Dept."
	[Inspections:27]Agency:156:=INSP_GetUserAgency
	If ([Inspections:27]Agency:156="")
		[Inspections:27]Agency:156:="Mass. Highway Dept."
	End if 
	PushChange(1; ->[Inspections:27]Agency:156)
	[Inspections:27]WeightPosting:30:=([Bridge MHD NBIS:1]PostingStatus:8="POSTED")
	PushChange(1; ->[Inspections:27]WeightPosting:30)
	
	If ([Inspections:27]WeightPosting:30)
		[Inspections:27]ActualPostH:26:=[Bridge MHD NBIS:1]Posting2Axle:9
		[Inspections:27]ActualPost3:27:=[Bridge MHD NBIS:1]Posting3Axle:10
		[Inspections:27]ActualPost3S2:28:=[Bridge MHD NBIS:1]Posting5Axle:11
		If ([Bridge MHD NBIS:1]PostingSingle:231>0)
			[Inspections:27]ActualPostSgl:29:=[Bridge MHD NBIS:1]PostingSingle:231
			[Inspections:27]ActualPostH:26:=0
			[Inspections:27]ActualPost3:27:=0
			[Inspections:27]ActualPost3S2:28:=0
			
		Else 
			If (([Bridge MHD NBIS:1]Posting2Axle:9=[Bridge MHD NBIS:1]Posting3Axle:10) & ([Bridge MHD NBIS:1]Posting2Axle:9=[Bridge MHD NBIS:1]Posting5Axle:11))
				[Inspections:27]ActualPostSgl:29:=[Bridge MHD NBIS:1]Posting2Axle:9
				[Inspections:27]ActualPostH:26:=0
				[Inspections:27]ActualPost3:27:=0
				[Inspections:27]ActualPost3S2:28:=0
			Else 
				[Inspections:27]ActualPostSgl:29:=0
			End if 
		End if 
		
		PushChange(1; ->[Inspections:27]ActualPostH:26)
		PushChange(1; ->[Inspections:27]ActualPost3:27)
		PushChange(1; ->[Inspections:27]ActualPost3S2:28)
		PushChange(1; ->[Inspections:27]ActualPostSgl:29)
		
	End if 
	
	[Inspections:27]ClrPosting:49:=True:C214
	PushChange(1; ->[Inspections:27]ClrPosting:49)
	[Inspections:27]LiftBucket:86:=[Bridge MHD NBIS:1]LiftBucket:30
	PushChange(1; ->[Inspections:27]LiftBucket:86)
	[Inspections:27]Boat:88:=[Bridge MHD NBIS:1]Boat:32
	PushChange(1; ->[Inspections:27]Boat:88)
	[Inspections:27]Wader:89:=[Bridge MHD NBIS:1]Wader:33
	PushChange(1; ->[Inspections:27]Wader:89)
	[Inspections:27]Ladder:87:=[Bridge MHD NBIS:1]Ladder:31
	PushChange(1; ->[Inspections:27]Ladder:87)
	[Inspections:27]Inspector50:90:=[Bridge MHD NBIS:1]Inspector50:34
	PushChange(1; ->[Inspections:27]Inspector50:90)
	[Inspections:27]Rigging:91:=[Bridge MHD NBIS:1]Rigging:35
	PushChange(1; ->[Inspections:27]Rigging:91)
	[Inspections:27]Staging:92:=[Bridge MHD NBIS:1]Staging:36
	PushChange(1; ->[Inspections:27]Staging:92)
	[Inspections:27]Traffic Control:93:=[Bridge MHD NBIS:1]Traffic Control:37
	PushChange(1; ->[Inspections:27]Traffic Control:93)
	[Inspections:27]RR Flagman:94:=[Bridge MHD NBIS:1]RR Flagman:38
	PushChange(1; ->[Inspections:27]RR Flagman:94)
	[Inspections:27]Police:95:=[Bridge MHD NBIS:1]Police:39
	PushChange(1; ->[Inspections:27]Police:95)
	[Inspections:27]ConfinedSp:182:=[Bridge MHD NBIS:1]ConfinedSp:217
	PushChange(1; ->[Inspections:27]ConfinedSp:182)
	[Inspections:27]AccessOther:96:=[Bridge MHD NBIS:1]AccessOther:180
	PushChange(1; ->[Inspections:27]AccessOther:96)
	[Inspections:27]OtherAccBool:97:=[Bridge MHD NBIS:1]OtherAccBool:181
	PushChange(1; ->[Inspections:27]OtherAccBool:97)
	[Inspections:27]ClsdRoutine:145:=True:C214
	PushChange(1; ->[Inspections:27]ClsdRoutine:145)
	[Inspections:27]Item 60 Cur:155:=G_Insp_VerifyItem([Bridge MHD NBIS:1]Item60:132)
	PushChange(1; ->[Inspections:27]Item 60 Cur:155)
	[Inspections:27]Item 61 Cur:159:=G_Insp_VerifyItem([Bridge MHD NBIS:1]Item61:133)
	PushChange(1; ->[Inspections:27]Item 61 Cur:159)
	//Add Check for Posting info dates.
	If ([Bridge MHD NBIS:1]PostingStatus:8="EJDMNT")
		[Inspections:27]EDJMT Date:36:=[Bridge MHD NBIS:1]PostingDate:7
		PushChange(1; ->[Inspections:27]EDJMT Date:36)
	End if 
	If ([Bridge MHD NBIS:1]PostingStatus:8="WAIVED")
		[Inspections:27]WaivedDate:35:=[Bridge MHD NBIS:1]PostingDate:7
		PushChange(1; ->[Inspections:27]WaivedDate:35)
	End if 
	G_InspGetRatings(False:C215)  //get Rating info w/out alerts.
	
	If ([Bridge MHD NBIS:1]BarrelsHeight:189#0)
		
		If ([Bridge MHD NBIS:1]BarrelsHeight:189#[Inspections:27]BarrelsHeight:180)
			//does SIA value have decimals?
			If (Position:C15("."; String:C10(Round:C94([Bridge MHD NBIS:1]BarrelsHeight:189; 3)))>0)
				//if there is a . then it has decimals so it could be a valid value
				//compare the values to 3 decimals
				If (Round:C94([Bridge MHD NBIS:1]BarrelsHeight:189; 3)#Round:C94([Bridge MHD NBIS:1]BarrelsHeight:189; 3))
					[Inspections:27]BarrelsHeight:180:=[Bridge MHD NBIS:1]BarrelsHeight:189
					PushChange(1; ->[Inspections:27]BarrelsHeight:180)
				End if 
			Else 
				//could be integer value from before conversion of SIA to real
				//check if the integer values don't match
				C_LONGINT:C283($SIA_L; $Insp_L)
				$SIA_L:=[Bridge MHD NBIS:1]BarrelsHeight:189
				$Insp_L:=[Inspections:27]BarrelsHeight:180
				If ($SIA_L#$Insp_L)
					[Inspections:27]BarrelsHeight:180:=[Bridge MHD NBIS:1]BarrelsHeight:189
					PushChange(1; ->[Inspections:27]BarrelsHeight:180)
				End if 
			End if 
		End if 
		
	End if 
	If ([Bridge MHD NBIS:1]BarrelsNumber:188#0)
		If ([Bridge MHD NBIS:1]BarrelsNumber:188#[Inspections:27]BarrelsNumber:175)
			[Inspections:27]BarrelsNumber:175:=[Bridge MHD NBIS:1]BarrelsNumber:188
			PushChange(1; ->[Inspections:27]BarrelsNumber:175)
		End if 
	End if 
	If ([Bridge MHD NBIS:1]BarrelsWidth:190#0)
		
		If ([Bridge MHD NBIS:1]BarrelsWidth:190#[Inspections:27]BarrelsWidth:179)
			//does SIA value have decimals?
			If (Position:C15("."; String:C10(Round:C94([Bridge MHD NBIS:1]BarrelsWidth:190; 3)))>0)
				//if there is a . then it has decimals so it could be a valid value
				//compare the values to 3 decimals
				If (Round:C94([Bridge MHD NBIS:1]BarrelsWidth:190; 3)#Round:C94([Inspections:27]BarrelsWidth:179; 3))
					[Inspections:27]BarrelsWidth:179:=[Bridge MHD NBIS:1]BarrelsWidth:190
					PushChange(1; ->[Inspections:27]BarrelsWidth:179)
				End if 
			Else 
				//could be integer value from before conversion of SIA to real
				//check if the integer values don't match
				C_LONGINT:C283($SIA_L; $Insp_L)
				$SIA_L:=[Bridge MHD NBIS:1]BarrelsWidth:190
				$Insp_L:=[Inspections:27]BarrelsWidth:179
				If ($SIA_L#$Insp_L)
					[Inspections:27]BarrelsWidth:179:=[Bridge MHD NBIS:1]BarrelsWidth:190
					PushChange(1; ->[Inspections:27]BarrelsWidth:179)
				End if 
			End if 
		End if 
		
	End if 
	If ([Bridge MHD NBIS:1]CulvertCoating:187#"")
		If ([Bridge MHD NBIS:1]CulvertCoating:187#[Inspections:27]CulvertCoating:176)
			[Inspections:27]CulvertCoating:176:=[Bridge MHD NBIS:1]CulvertCoating:187
			PushChange(1; ->[Inspections:27]CulvertCoating:176)
		End if 
	End if 
	If ([Bridge MHD NBIS:1]CulvertMaterial:186#"")
		If ([Bridge MHD NBIS:1]CulvertMaterial:186#[Inspections:27]CulvertMaterial:177)
			[Inspections:27]CulvertMaterial:177:=[Bridge MHD NBIS:1]CulvertMaterial:186
			PushChange(1; ->[Inspections:27]CulvertMaterial:177)
		End if 
	End if 
	If ([Bridge MHD NBIS:1]CulvertShape:185#"")
		If ([Bridge MHD NBIS:1]CulvertShape:185#[Inspections:27]CulvertShape:178)
			[Inspections:27]CulvertShape:178:=[Bridge MHD NBIS:1]CulvertShape:185
			PushChange(1; ->[Inspections:27]CulvertShape:178)
		End if 
	End if 
	
End if   //if Not a Dive Inspection
[Inspections:27]Item 62:113:=G_Insp_VerifyItem([Bridge MHD NBIS:1]Item62:134)
PushChange(1; ->[Inspections:27]Item 62:113)
If ([Inspections:27]Insp Type:6="CUL")
	[Inspections:27]Item 62 Cur:172:=G_Insp_VerifyItem([Bridge MHD NBIS:1]Item62:134)
	PushChange(1; ->[Inspections:27]Item 62 Cur:172)
End if 
[Inspections:27]Item58_i:151:=G_Insp_VerifyItem([Bridge MHD NBIS:1]Item58:130)
PushChange(1; ->[Inspections:27]Item58_i:151)
[Inspections:27]Item59_i:143:=G_Insp_VerifyItem([Bridge MHD NBIS:1]Item59:131)
PushChange(1; ->[Inspections:27]Item59_i:143)
[Inspections:27]Item60_i:144:=G_Insp_VerifyItem([Bridge MHD NBIS:1]Item60:132)
PushChange(1; ->[Inspections:27]Item60_i:144)
[Inspections:27]Item61_i:173:=G_Insp_VerifyItem([Bridge MHD NBIS:1]Item61:133)
PushChange(1; ->[Inspections:27]Item61_i:173)
[Inspections:27]Item62_i:174:=G_Insp_VerifyItem([Bridge MHD NBIS:1]Item62:134)
PushChange(1; ->[Inspections:27]Item62_i:174)
[Inspections:27]LevelofInsp:105:=2  //added aug-2002
PushChange(1; ->[Inspections:27]LevelofInsp:105)
If ([Inspections:27]Insp Type:6="DV@")  //added Sep-2003 v3.3f3
	[Inspections:27]Item60UW_i:152:=G_Insp_VerifyItem([Bridge MHD NBIS:1]Item60:132)
	PushChange(1; ->[Inspections:27]Item60UW_i:152)
	[Inspections:27]Item 60 UW:66:=G_Insp_VerifyItem([Bridge MHD NBIS:1]Item60:132)
	PushChange(1; ->[Inspections:27]Item 60 UW:66)
	[Inspections:27]Item61UW_i:153:=G_Insp_VerifyItem([Bridge MHD NBIS:1]Item61:133)
	PushChange(1; ->[Inspections:27]Item61UW_i:153)
	[Inspections:27]Item 61 UW:72:=G_Insp_VerifyItem([Bridge MHD NBIS:1]Item61:133)
	PushChange(1; ->[Inspections:27]Item 61 UW:72)
	[Inspections:27]Item62UW_i:154:=G_Insp_VerifyItem([Bridge MHD NBIS:1]Item62:134)
	PushChange(1; ->[Inspections:27]Item62UW_i:154)
	[Inspections:27]Item 62 UW:165:=G_Insp_VerifyItem([Bridge MHD NBIS:1]Item62:134)
	PushChange(1; ->[Inspections:27]Item 62 UW:165)
End if 
If ([Inspections:27]Insp Type:6="FRZ")
	[Inspections:27]Cld_Schedule:194:=[Bridge MHD NBIS:1]FreezeThaw:225
	PushChange(1; ->[Inspections:27]Cld_Schedule:194)
End if 