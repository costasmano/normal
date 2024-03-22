//%attributes = {"invisible":true}
// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 05/06/10, 11:58:58
// ----------------------------------------------------
// Method: Clone_ArrayToSelection
// Description
//This method is used to do array to selection during clone of tables
If (False:C215)
	// recreated on 09/19/2023
End if 
C_LONGINT:C283($1)
C_POINTER:C301($Array_Ptr)
Case of 
	: ($1=1)  //Bridge MHD NBIS
		$Array_Ptr:=->v_1_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_1_230_atxt; [Bridge MHD NBIS:1]Bridge_MHD_NBIS_UUIDKey_s:230; *)  //Bridge_MHD_NBIS_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_1_003_atxt; [Bridge MHD NBIS:1]BIN:3; v_1_206_atxt; [Bridge MHD NBIS:1]Item8:206; *)
			
			ARRAY TO SELECTION:C261(v_1_001_atxt; [Bridge MHD NBIS:1]BDEPT:1; v_1_002_atxt; [Bridge MHD NBIS:1]Bridge Key:2; v_1_008_atxt; [Bridge MHD NBIS:1]PostingStatus:8; *)
			ARRAY TO SELECTION:C261(v_1_012_atxt; [Bridge MHD NBIS:1]Foundation Type:12; v_1_023_atxt; [Bridge MHD NBIS:1]FC Under:23; v_1_024_atxt; [Bridge MHD NBIS:1]Quad:24; *)
			ARRAY TO SELECTION:C261(v_1_025_atxt; [Bridge MHD NBIS:1]SelectionText:25; v_1_027_atxt; [Bridge MHD NBIS:1]ParallelBIN:27; v_1_029_atxt; [Bridge MHD NBIS:1]Bridge Name:29; *)
			ARRAY TO SELECTION:C261(v_1_030_atxt; [Bridge MHD NBIS:1]LiftBucket:30; v_1_031_atxt; [Bridge MHD NBIS:1]Ladder:31; v_1_032_atxt; [Bridge MHD NBIS:1]Boat:32; *)
			ARRAY TO SELECTION:C261(v_1_033_atxt; [Bridge MHD NBIS:1]Wader:33; v_1_034_atxt; [Bridge MHD NBIS:1]Inspector50:34; v_1_035_atxt; [Bridge MHD NBIS:1]Rigging:35; *)
			ARRAY TO SELECTION:C261(v_1_036_atxt; [Bridge MHD NBIS:1]Staging:36; v_1_037_atxt; [Bridge MHD NBIS:1]Traffic Control:37; v_1_038_atxt; [Bridge MHD NBIS:1]RR Flagman:38; *)
			ARRAY TO SELECTION:C261(v_1_039_atxt; [Bridge MHD NBIS:1]Police:39; v_1_049_atxt; [Bridge MHD NBIS:1]InspWaiverText:49; v_1_050_atxt; [Bridge MHD NBIS:1]RoadInvSNC:50; *)
			ARRAY TO SELECTION:C261(v_1_051_atxt; [Bridge MHD NBIS:1]RoadInvSNI:51; v_1_052_atxt; [Bridge MHD NBIS:1]MaintCat:52; v_1_053_atxt; [Bridge MHD NBIS:1]MaintPriority:53; *)
			ARRAY TO SELECTION:C261(v_1_054_atxt; [Bridge MHD NBIS:1]MaintTxtDist:54; v_1_055_atxt; [Bridge MHD NBIS:1]MaintTxtBoston:55; v_1_058_atxt; [Bridge MHD NBIS:1]SeismicClass:58; *)
			ARRAY TO SELECTION:C261(v_1_059_atxt; [Bridge MHD NBIS:1]Item5:59; v_1_060_atxt; [Bridge MHD NBIS:1]Item2:60; v_1_061_atxt; [Bridge MHD NBIS:1]Item3:61; *)
			ARRAY TO SELECTION:C261(v_1_062_atxt; [Bridge MHD NBIS:1]Item4:62; v_1_063_atxt; [Bridge MHD NBIS:1]Item6A:63; v_1_065_atxt; [Bridge MHD NBIS:1]Item7:65; *)
			ARRAY TO SELECTION:C261(v_1_066_atxt; [Bridge MHD NBIS:1]Item9:66; v_1_072_atxt; [Bridge MHD NBIS:1]Item98A:72; v_1_073_atxt; [Bridge MHD NBIS:1]Item98B:73; *)
			ARRAY TO SELECTION:C261(v_1_074_atxt; [Bridge MHD NBIS:1]Item99:74; v_1_075_atxt; [Bridge MHD NBIS:1]Item43:75; v_1_076_atxt; [Bridge MHD NBIS:1]Item44:76; *)
			ARRAY TO SELECTION:C261(v_1_079_atxt; [Bridge MHD NBIS:1]Item107:79; v_1_080_atxt; [Bridge MHD NBIS:1]Item108A:80; v_1_081_atxt; [Bridge MHD NBIS:1]Item108B:81; *)
			ARRAY TO SELECTION:C261(v_1_082_atxt; [Bridge MHD NBIS:1]Item108C:82; v_1_085_atxt; [Bridge MHD NBIS:1]Item42:85; v_1_099_atxt; [Bridge MHD NBIS:1]Item33:99; *)
			ARRAY TO SELECTION:C261(v_1_107_atxt; [Bridge MHD NBIS:1]Item54A:107; v_1_110_atxt; [Bridge MHD NBIS:1]Item55A:110; v_1_113_atxt; [Bridge MHD NBIS:1]Item38:113; *)
			ARRAY TO SELECTION:C261(v_1_114_atxt; [Bridge MHD NBIS:1]Item111:114; v_1_120_atxt; [Bridge MHD NBIS:1]Item26:120; v_1_121_atxt; [Bridge MHD NBIS:1]Item100:121; *)
			ARRAY TO SELECTION:C261(v_1_122_atxt; [Bridge MHD NBIS:1]Item101:122; v_1_123_atxt; [Bridge MHD NBIS:1]Item102:123; v_1_126_atxt; [Bridge MHD NBIS:1]Item20:126; *)
			ARRAY TO SELECTION:C261(v_1_127_atxt; [Bridge MHD NBIS:1]Item21:127; v_1_128_atxt; [Bridge MHD NBIS:1]Item22:128; v_1_129_atxt; [Bridge MHD NBIS:1]Item37:129; *)
			ARRAY TO SELECTION:C261(v_1_130_atxt; [Bridge MHD NBIS:1]Item58:130; v_1_131_atxt; [Bridge MHD NBIS:1]Item59:131; v_1_132_atxt; [Bridge MHD NBIS:1]Item60:132; *)
			ARRAY TO SELECTION:C261(v_1_133_atxt; [Bridge MHD NBIS:1]Item61:133; v_1_134_atxt; [Bridge MHD NBIS:1]Item62:134; v_1_135_atxt; [Bridge MHD NBIS:1]Item31:135; *)
			ARRAY TO SELECTION:C261(v_1_140_atxt; [Bridge MHD NBIS:1]Item70:140; v_1_141_atxt; [Bridge MHD NBIS:1]Item41:141; v_1_142_atxt; [Bridge MHD NBIS:1]Item67:142; *)
			ARRAY TO SELECTION:C261(v_1_143_atxt; [Bridge MHD NBIS:1]Item68:143; v_1_144_atxt; [Bridge MHD NBIS:1]Item69:144; v_1_145_atxt; [Bridge MHD NBIS:1]Item71:145; *)
			ARRAY TO SELECTION:C261(v_1_146_atxt; [Bridge MHD NBIS:1]Item72:146; v_1_147_atxt; [Bridge MHD NBIS:1]Item36A:147; v_1_148_atxt; [Bridge MHD NBIS:1]Item36B:148; *)
			ARRAY TO SELECTION:C261(v_1_149_atxt; [Bridge MHD NBIS:1]Item36C:149; v_1_150_atxt; [Bridge MHD NBIS:1]Item36D:150; v_1_151_atxt; [Bridge MHD NBIS:1]Item113:151; *)
			ARRAY TO SELECTION:C261(v_1_152_atxt; [Bridge MHD NBIS:1]Item75A:152; v_1_153_atxt; [Bridge MHD NBIS:1]Item75B:153; v_1_172_atxt; [Bridge MHD NBIS:1]General Comment:172; *)
			ARRAY TO SELECTION:C261(v_1_173_atxt; [Bridge MHD NBIS:1]InspResp:173; v_1_175_atxt; [Bridge MHD NBIS:1]Town Name:175; v_1_180_atxt; [Bridge MHD NBIS:1]AccessOther:180; *)
			ARRAY TO SELECTION:C261(v_1_181_atxt; [Bridge MHD NBIS:1]OtherAccBool:181; v_1_183_atxt; [Bridge MHD NBIS:1]RPC_Codes:183; v_1_185_atxt; [Bridge MHD NBIS:1]CulvertShape:185; *)
			ARRAY TO SELECTION:C261(v_1_186_atxt; [Bridge MHD NBIS:1]CulvertMaterial:186; v_1_187_atxt; [Bridge MHD NBIS:1]CulvertCoating:187; v_1_191_atxt; [Bridge MHD NBIS:1]Modified By:191; *)
			ARRAY TO SELECTION:C261(v_1_197_atxt; [Bridge MHD NBIS:1]Item 13A:197; v_1_198_atxt; [Bridge MHD NBIS:1]Item 13B:198; v_1_199_atxt; [Bridge MHD NBIS:1]Item 63:199; *)
			ARRAY TO SELECTION:C261(v_1_200_atxt; [Bridge MHD NBIS:1]Item 65:200; v_1_201_atxt; [Bridge MHD NBIS:1]Item 105:201; v_1_202_atxt; [Bridge MHD NBIS:1]JointlessType:202; *)
			ARRAY TO SELECTION:C261(v_1_207_atxt; [Bridge MHD NBIS:1]Item8 BridgeCat:207; v_1_208_atxt; [Bridge MHD NBIS:1]Item8 Owner:208; v_1_209_atxt; [Bridge MHD NBIS:1]AgencyBrNo:209; *)
			ARRAY TO SELECTION:C261(v_1_210_atxt; [Bridge MHD NBIS:1]RRBranch:210; v_1_215_atxt; [Bridge MHD NBIS:1]OtherInspType:215; v_1_216_atxt; [Bridge MHD NBIS:1]ClassAEmp:216; *)
			ARRAY TO SELECTION:C261(v_1_217_atxt; [Bridge MHD NBIS:1]ConfinedSp:217; v_1_218_atxt; [Bridge MHD NBIS:1]OffHrsWork:218; v_1_224_atxt; [Bridge MHD NBIS:1]MissSignsDesc:224; *)
			ARRAY TO SELECTION:C261(v_1_225_atxt; [Bridge MHD NBIS:1]FreezeThaw:225; v_1_226_atxt; [Bridge MHD NBIS:1]LegacyOwner:226; v_1_228_atxt; [Bridge MHD NBIS:1]FundingSource:228; *)
			ARRAY TO SELECTION:C261(v_1_229_atxt; [Bridge MHD NBIS:1]FHWAItem8:229; *)
			ARRAY TO SELECTION:C261(v_1_005_ar; [Bridge MHD NBIS:1]AASHTO:5; v_1_015_ar; [Bridge MHD NBIS:1]OprH20:15; v_1_016_ar; [Bridge MHD NBIS:1]OprType3:16; *)
			ARRAY TO SELECTION:C261(v_1_017_ar; [Bridge MHD NBIS:1]Opr3S2:17; v_1_018_ar; [Bridge MHD NBIS:1]OprHS:18; v_1_019_ar; [Bridge MHD NBIS:1]InvH20:19; *)
			ARRAY TO SELECTION:C261(v_1_020_ar; [Bridge MHD NBIS:1]InvType3:20; v_1_021_ar; [Bridge MHD NBIS:1]Inv3S2:21; v_1_022_ar; [Bridge MHD NBIS:1]InvHS:22; *)
			ARRAY TO SELECTION:C261(v_1_057_ar; [Bridge MHD NBIS:1]SeismicRank:57; v_1_067_ar; [Bridge MHD NBIS:1]Item11:67; v_1_092_ar; [Bridge MHD NBIS:1]Item48:92; *)
			ARRAY TO SELECTION:C261(v_1_093_ar; [Bridge MHD NBIS:1]Item49:93; v_1_094_ar; [Bridge MHD NBIS:1]Item50A:94; v_1_095_ar; [Bridge MHD NBIS:1]Item50B:95; *)
			ARRAY TO SELECTION:C261(v_1_096_ar; [Bridge MHD NBIS:1]Item51:96; v_1_097_ar; [Bridge MHD NBIS:1]Item52:97; v_1_098_ar; [Bridge MHD NBIS:1]Item32:98; *)
			ARRAY TO SELECTION:C261(v_1_102_ar; [Bridge MHD NBIS:1]Item10:102; v_1_104_ar; [Bridge MHD NBIS:1]Item47:104; v_1_105_ar; [Bridge MHD NBIS:1]Item53:105; *)
			ARRAY TO SELECTION:C261(v_1_108_ar; [Bridge MHD NBIS:1]Item54B:108; v_1_109_ar; [Bridge MHD NBIS:1]Item16C:109; v_1_111_ar; [Bridge MHD NBIS:1]Item55B:111; *)
			ARRAY TO SELECTION:C261(v_1_112_ar; [Bridge MHD NBIS:1]Item56:112; v_1_115_ar; [Bridge MHD NBIS:1]Item39:115; v_1_116_ar; [Bridge MHD NBIS:1]Item116:116; *)
			ARRAY TO SELECTION:C261(v_1_117_ar; [Bridge MHD NBIS:1]Item40:117; v_1_136_ar; [Bridge MHD NBIS:1]Item17C:136; v_1_137_ar; [Bridge MHD NBIS:1]Item64:137; *)
			ARRAY TO SELECTION:C261(v_1_139_ar; [Bridge MHD NBIS:1]Item66:139; v_1_154_ar; [Bridge MHD NBIS:1]Item76:154; v_1_189_ar; [Bridge MHD NBIS:1]BarrelsHeight:189; *)
			ARRAY TO SELECTION:C261(v_1_190_ar; [Bridge MHD NBIS:1]BarrelsWidth:190; v_1_203_ar; [Bridge MHD NBIS:1]InvMS:203; v_1_204_ar; [Bridge MHD NBIS:1]OprMS:204; *)
			ARRAY TO SELECTION:C261(v_1_211_ar; [Bridge MHD NBIS:1]RRBridgeNo:211; v_1_220_ar; [Bridge MHD NBIS:1]HI_Total_Elmt_Cost:220; v_1_221_ar; [Bridge MHD NBIS:1]HI_Current_Elmt_Cost:221; *)
			ARRAY TO SELECTION:C261(v_1_222_ar; [Bridge MHD NBIS:1]HealthIndex:222; *)
			ARRAY TO SELECTION:C261(v_1_006_ai; [Bridge MHD NBIS:1]Rank:6; v_1_009_ai; [Bridge MHD NBIS:1]Posting2Axle:9; v_1_010_ai; [Bridge MHD NBIS:1]Posting3Axle:10; *)
			ARRAY TO SELECTION:C261(v_1_011_ai; [Bridge MHD NBIS:1]Posting5Axle:11; v_1_040_ai; [Bridge MHD NBIS:1]InspectionHRS:40; v_1_043_ai; [Bridge MHD NBIS:1]OtherIFreq:43; *)
			ARRAY TO SELECTION:C261(v_1_046_ai; [Bridge MHD NBIS:1]ClosedIFreq:46; v_1_068_ai; [Bridge MHD NBIS:1]Item16A:68; v_1_069_ai; [Bridge MHD NBIS:1]Item16B:69; *)
			ARRAY TO SELECTION:C261(v_1_070_ai; [Bridge MHD NBIS:1]Item17A:70; v_1_071_ai; [Bridge MHD NBIS:1]Item17B:71; v_1_077_ai; [Bridge MHD NBIS:1]Item45:77; *)
			ARRAY TO SELECTION:C261(v_1_078_ai; [Bridge MHD NBIS:1]Item46:78; v_1_083_ai; [Bridge MHD NBIS:1]Item27:83; v_1_084_ai; [Bridge MHD NBIS:1]Item106:84; *)
			ARRAY TO SELECTION:C261(v_1_086_ai; [Bridge MHD NBIS:1]Item28A:86; v_1_087_ai; [Bridge MHD NBIS:1]Item28B:87; v_1_089_ai; [Bridge MHD NBIS:1]Item30:89; *)
			ARRAY TO SELECTION:C261(v_1_090_ai; [Bridge MHD NBIS:1]Item109:90; v_1_091_ai; [Bridge MHD NBIS:1]Item19:91; v_1_100_ai; [Bridge MHD NBIS:1]Item34:100; *)
			ARRAY TO SELECTION:C261(v_1_158_ai; [Bridge MHD NBIS:1]Item97:158; v_1_160_ai; [Bridge MHD NBIS:1]Item115:160; v_1_162_ai; [Bridge MHD NBIS:1]Item91:162; *)
			ARRAY TO SELECTION:C261(v_1_164_ai; [Bridge MHD NBIS:1]Item92AB:164; v_1_166_ai; [Bridge MHD NBIS:1]Item92BB:166; v_1_168_ai; [Bridge MHD NBIS:1]Item92CB:168; *)
			ARRAY TO SELECTION:C261(v_1_188_ai; [Bridge MHD NBIS:1]BarrelsNumber:188; v_1_213_ai; [Bridge MHD NBIS:1]UWSpInspFreq:213; *)
			ARRAY TO SELECTION:C261(v_1_056_aL; [Bridge MHD NBIS:1]TownLineBDEPT:56; v_1_088_aL; [Bridge MHD NBIS:1]Item29:88; v_1_155_aL; [Bridge MHD NBIS:1]Item94:155; *)
			ARRAY TO SELECTION:C261(v_1_156_aL; [Bridge MHD NBIS:1]Item95:156; v_1_157_aL; [Bridge MHD NBIS:1]Item96:157; v_1_159_aL; [Bridge MHD NBIS:1]Item114:159; *)
			ARRAY TO SELECTION:C261(v_1_179_aL; [Bridge MHD NBIS:1]Year Rehab:179; v_1_182_aL; [Bridge MHD NBIS:1]Year Painted:182; v_1_231_aL; [Bridge MHD NBIS:1]PostingSingle:231; *)
			ARRAY TO SELECTION:C261(v_1_007_ad; [Bridge MHD NBIS:1]PostingDate:7; v_1_041_ad; [Bridge MHD NBIS:1]OtherIDate:41; v_1_044_ad; [Bridge MHD NBIS:1]ClosedIDate:44; *)
			ARRAY TO SELECTION:C261(v_1_047_ad; [Bridge MHD NBIS:1]DamageInsp:47; v_1_161_ad; [Bridge MHD NBIS:1]Item90:161; v_1_169_ad; [Bridge MHD NBIS:1]Item93A:169; *)
			ARRAY TO SELECTION:C261(v_1_170_ad; [Bridge MHD NBIS:1]Item93B:170; v_1_171_ad; [Bridge MHD NBIS:1]Item93C:171; v_1_192_ad; [Bridge MHD NBIS:1]DateCreated:192; *)
			ARRAY TO SELECTION:C261(v_1_194_ad; [Bridge MHD NBIS:1]DateModified:194; v_1_205_ad; [Bridge MHD NBIS:1]DateRatReport:205; v_1_214_ad; [Bridge MHD NBIS:1]UWSpInspDate:214; *)
			ARRAY TO SELECTION:C261(v_1_193_atm; [Bridge MHD NBIS:1]TimeCreated:193; v_1_195_atm; [Bridge MHD NBIS:1]TimeModified:195; *)
			ARRAY TO SELECTION:C261(v_1_004_ab; [Bridge MHD NBIS:1]FHWA Select:4; v_1_013_ab; [Bridge MHD NBIS:1]AreaEngVal:13; v_1_014_ab; [Bridge MHD NBIS:1]BrgInspEngVal:14; *)
			ARRAY TO SELECTION:C261(v_1_026_ab; [Bridge MHD NBIS:1]AntiMissile:26; v_1_028_ab; [Bridge MHD NBIS:1]Acrow Panel:28; v_1_042_ab; [Bridge MHD NBIS:1]OtherInsp:42; *)
			ARRAY TO SELECTION:C261(v_1_045_ab; [Bridge MHD NBIS:1]ClosedInsp:45; v_1_048_ab; [Bridge MHD NBIS:1]InspWaiver:48; v_1_064_ab; [Bridge MHD NBIS:1]Item6B:64; *)
			ARRAY TO SELECTION:C261(v_1_101_ab; [Bridge MHD NBIS:1]Item35:101; v_1_103_ab; [Bridge MHD NBIS:1]StructDef:103; v_1_106_ab; [Bridge MHD NBIS:1]FunctObs:106; *)
			ARRAY TO SELECTION:C261(v_1_118_ab; [Bridge MHD NBIS:1]Item112:118; v_1_119_ab; [Bridge MHD NBIS:1]Item104:119; v_1_124_ab; [Bridge MHD NBIS:1]Item103:124; *)
			ARRAY TO SELECTION:C261(v_1_125_ab; [Bridge MHD NBIS:1]Item110:125; v_1_138_ab; [Bridge MHD NBIS:1]OnSystem:138; v_1_163_ab; [Bridge MHD NBIS:1]Item92AA:163; *)
			ARRAY TO SELECTION:C261(v_1_165_ab; [Bridge MHD NBIS:1]Item92BA:165; v_1_167_ab; [Bridge MHD NBIS:1]Item92CA:167; v_1_174_ab; [Bridge MHD NBIS:1]FHWARecord:174; *)
			ARRAY TO SELECTION:C261(v_1_176_ab; [Bridge MHD NBIS:1]JointlessBridge:176; v_1_177_ab; [Bridge MHD NBIS:1]OnTwnLine:177; v_1_178_ab; [Bridge MHD NBIS:1]Complex Bridge:178; *)
			ARRAY TO SELECTION:C261(v_1_184_ab; [Bridge MHD NBIS:1]OvrHeadSigns:184; v_1_196_ab; [Bridge MHD NBIS:1]Item12:196; v_1_212_ab; [Bridge MHD NBIS:1]UWSpInsp:212; *)
			ARRAY TO SELECTION:C261(v_1_219_ab; [Bridge MHD NBIS:1]Complex Rating:219; v_1_223_ab; [Bridge MHD NBIS:1]MissSigns:223; v_1_227_ab; [Bridge MHD NBIS:1]InspRequired:227)
		End if 
	: ($1=2)  //Town Data
		$Array_Ptr:=->v_2_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_2_013_atxt; [Town Data:2]Town_Data_UUIDKey_s:13; *)  //Town_Data_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_2_001_atxt; [Town Data:2]Town Name:1; v_2_002_atxt; [Town Data:2]BDEPT Prefix:2; *)
			
			ARRAY TO SELECTION:C261(v_2_003_atxt; [Town Data:2]OldDistrictNo1:3; v_2_004_atxt; [Town Data:2]OldDistrictNo2:4; v_2_005_atxt; [Town Data:2]Place_Code:5; *)
			ARRAY TO SELECTION:C261(v_2_006_atxt; [Town Data:2]District:6; v_2_007_atxt; [Town Data:2]RPC_1:7; v_2_008_atxt; [Town Data:2]RPC_2:8; *)
			ARRAY TO SELECTION:C261(v_2_010_atxt; [Town Data:2]County Code:10; v_2_011_atxt; [Town Data:2]Town Dist Code:11; v_2_012_atxt; [Town Data:2]OldDistrictNo3:12; *)
			ARRAY TO SELECTION:C261(v_2_009_ar; [Town Data:2]Seismic_Acc:9)
		End if 
	: ($1=3)  //NBIS Secondary
		$Array_Ptr:=->v_3_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_3_040_atxt; [NBIS Secondary:3]NBIS_Secondary_UUIDKey_s:40; *)  //NBIS_Secondary_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_3_039_aL; [NBIS Secondary:3]NBISSecondaryKey_l:39; *)
			
			ARRAY TO SELECTION:C261(v_3_001_atxt; [NBIS Secondary:3]BIN:1; v_3_002_atxt; [NBIS Secondary:3]Item3:2; v_3_003_atxt; [NBIS Secondary:3]Item4:3; *)
			ARRAY TO SELECTION:C261(v_3_004_atxt; [NBIS Secondary:3]Item5:4; v_3_005_atxt; [NBIS Secondary:3]Item6A:5; v_3_007_atxt; [NBIS Secondary:3]Item7:7; *)
			ARRAY TO SELECTION:C261(v_3_008_atxt; [NBIS Secondary:3]Item9:8; v_3_017_atxt; [NBIS Secondary:3]Item20:17; v_3_018_atxt; [NBIS Secondary:3]Item26:18; *)
			ARRAY TO SELECTION:C261(v_3_023_atxt; [NBIS Secondary:3]Item42:23; v_3_024_atxt; [NBIS Secondary:3]Item43:24; v_3_028_atxt; [NBIS Secondary:3]Item100:28; *)
			ARRAY TO SELECTION:C261(v_3_029_atxt; [NBIS Secondary:3]Item101:29; v_3_030_atxt; [NBIS Secondary:3]Item102:30; v_3_034_atxt; [NBIS Secondary:3]Bridge Key:34; *)
			ARRAY TO SELECTION:C261(v_3_038_atxt; [NBIS Secondary:3]Item8:38; *)
			ARRAY TO SELECTION:C261(v_3_009_ar; [NBIS Secondary:3]Item10:9; v_3_011_ar; [NBIS Secondary:3]Item11:11; v_3_025_ar; [NBIS Secondary:3]Item47:25; *)
			ARRAY TO SELECTION:C261(v_3_026_ar; [NBIS Secondary:3]Item48:26; v_3_027_ar; [NBIS Secondary:3]Item49:27; v_3_035_ar; [NBIS Secondary:3]Item16C:35; *)
			ARRAY TO SELECTION:C261(v_3_036_ar; [NBIS Secondary:3]Item17C:36; *)
			ARRAY TO SELECTION:C261(v_3_010_ai; [NBIS Secondary:3]Item109:10; v_3_012_ai; [NBIS Secondary:3]Item16A:12; v_3_013_ai; [NBIS Secondary:3]Item16B:13; *)
			ARRAY TO SELECTION:C261(v_3_014_ai; [NBIS Secondary:3]Item17A:14; v_3_015_ai; [NBIS Secondary:3]Item17B:15; v_3_016_ai; [NBIS Secondary:3]Item19:16; *)
			ARRAY TO SELECTION:C261(v_3_019_ai; [NBIS Secondary:3]Item27:19; v_3_020_ai; [NBIS Secondary:3]Item28A:20; v_3_021_ai; [NBIS Secondary:3]Item28B:21; *)
			ARRAY TO SELECTION:C261(v_3_037_ai; [NBIS Secondary:3]Item30:37; *)
			ARRAY TO SELECTION:C261(v_3_022_aL; [NBIS Secondary:3]Item29:22; *)
			ARRAY TO SELECTION:C261(v_3_006_ab; [NBIS Secondary:3]Item6B:6; v_3_031_ab; [NBIS Secondary:3]Item103:31; v_3_032_ab; [NBIS Secondary:3]Item104:32; *)
			ARRAY TO SELECTION:C261(v_3_033_ab; [NBIS Secondary:3]Item110:33)
		End if 
	: ($1=4)  //MaintOwnerCode
		$Array_Ptr:=->v_4_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_4_003_atxt; [MaintOwnerCode:4]MaintOwnerCode_UUIDKey_s:3; *)  //MaintOwnerCode_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_4_001_atxt; [MaintOwnerCode:4]Code:1; v_4_002_atxt; [MaintOwnerCode:4]Description:2)
		End if 
	: ($1=5)  //FunctionalClass
		$Array_Ptr:=->v_5_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_5_003_atxt; [FunctionalClass:5]FunctionalClass_UUIDKey_s:3; *)  //FunctionalClass_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_5_001_atxt; [FunctionalClass:5]Code:1; v_5_002_atxt; [FunctionalClass:5]Description:2)
		End if 
	: ($1=6)  //Design Load
		$Array_Ptr:=->v_6_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_6_003_atxt; [Design Load:6]Design_Load_UUIDKey_s:3; *)  //Design_Load_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_6_001_atxt; [Design Load:6]Code:1; v_6_002_atxt; [Design Load:6]Description:2)
		End if 
	: ($1=7)  //Posting Code
		$Array_Ptr:=->v_7_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_7_003_atxt; [Posting Code:7]Posting_Code_UUIDKey_s:3; *)  //Posting_Code_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_7_001_atxt; [Posting Code:7]Code:1; v_7_002_atxt; [Posting Code:7]Description:2)
		End if 
	: ($1=8)  //Service Over
		$Array_Ptr:=->v_8_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_8_003_atxt; [Service Over:8]Service_Over_UUIDKey_s:3; *)  //Service_Over_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_8_001_atxt; [Service Over:8]Code:1; v_8_002_atxt; [Service Over:8]Description:2)
		End if 
	: ($1=9)  //Service Under
		$Array_Ptr:=->v_9_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_9_003_atxt; [Service Under:9]Service_Under_UUIDKey_s:3; *)  //Service_Under_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_9_001_atxt; [Service Under:9]Code:1; v_9_002_atxt; [Service Under:9]Description:2)
		End if 
	: ($1=10)  //Material
		$Array_Ptr:=->v_10_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_10_003_atxt; [Material:10]Material_UUIDKey_s:3; *)  //Material_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_10_001_atxt; [Material:10]Code:1; v_10_002_atxt; [Material:10]Description:2)
		End if 
	: ($1=11)  //Design
		$Array_Ptr:=->v_11_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_11_003_atxt; [Design:11]Design_UUIDKey_s:3; *)  //Design_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_11_001_atxt; [Design:11]Code:1; v_11_002_atxt; [Design:11]Description:2)
		End if 
	: ($1=12)  //Truck Code
		$Array_Ptr:=->v_12_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_12_003_atxt; [Truck Code:12]Truck_Code_UUIDKey_s:3; *)  //Truck_Code_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_12_001_atxt; [Truck Code:12]Code:1; v_12_002_atxt; [Truck Code:12]Description:2)
		End if 
	: ($1=13)  //Direction
		$Array_Ptr:=->v_13_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_13_003_atxt; [Direction:13]Direction_UUIDKey_s:3; *)  //Direction_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_13_001_atxt; [Direction:13]Code:1; v_13_002_atxt; [Direction:13]Description:2)
		End if 
	: ($1=14)  //Deck Structure
		$Array_Ptr:=->v_14_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_14_003_atxt; [Deck Structure:14]Deck_Structure_UUIDKey_s:3; *)  //Deck_Structure_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_14_001_atxt; [Deck Structure:14]Code:1; v_14_002_atxt; [Deck Structure:14]Description:2)
		End if 
	: ($1=15)  //Wearing Surface
		$Array_Ptr:=->v_15_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_15_003_atxt; [Wearing Surface:15]Wearing_Surface_UUIDKey_s:3; *)  //Wearing_Surface_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_15_001_atxt; [Wearing Surface:15]Code:1; v_15_002_atxt; [Wearing Surface:15]Description:2)
		End if 
	: ($1=16)  //Membrane
		$Array_Ptr:=->v_16_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_16_003_atxt; [Membrane:16]Membrane_UUIDKey_s:3; *)  //Membrane_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_16_001_atxt; [Membrane:16]Code:1; v_16_002_atxt; [Membrane:16]Description:2)
		End if 
	: ($1=17)  //Deck Protection
		$Array_Ptr:=->v_17_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_17_003_atxt; [Deck Protection:17]Deck_Protection_UUIDKey_s:3; *)  //Deck_Protection_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_17_001_atxt; [Deck Protection:17]Code:1; v_17_002_atxt; [Deck Protection:17]Description:2)
		End if 
	: ($1=18)  //Type of Work
		$Array_Ptr:=->v_18_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_18_003_atxt; [Type of Work:18]Type_of_Work_UUIDKey_s:3; *)  //Type_of_Work_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_18_001_atxt; [Type of Work:18]Code:1; v_18_002_atxt; [Type of Work:18]Description:2)
		End if 
	: ($1=19)  //Work Done By
		$Array_Ptr:=->v_19_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_19_003_atxt; [Work Done By:19]Work_Done_By_UUIDKey_s:3; *)  //Work_Done_By_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_19_001_atxt; [Work Done By:19]Code:1; v_19_002_atxt; [Work Done By:19]Description:2)
		End if 
	: ($1=20)  //Insp Resp
		$Array_Ptr:=->v_20_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_20_003_atxt; [Insp Resp:20]Insp_Resp_UUIDKey_s:3; *)  //Insp_Resp_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_20_001_atxt; [Insp Resp:20]Code:1; v_20_002_atxt; [Insp Resp:20]Description:2)
		End if 
	: ($1=21)  //Dialogs
		$Array_Ptr:=->v_21_001_ab
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_21_002_atxt; [Dialogs:21]Dialogs_UUIDKey_s:2; *)  //Dialogs_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_21_001_ab; [Dialogs:21]Reserved:1)
		End if 
	: ($1=22)  //Item 20 Tolls
		$Array_Ptr:=->v_22_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_22_003_atxt; [Item 20 Tolls:22]Item_20_Tolls_UUIDKey_s:3; *)  //Item_20_Tolls_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_22_001_atxt; [Item 20 Tolls:22]Code:1; v_22_002_atxt; [Item 20 Tolls:22]Description:2)
		End if 
	: ($1=23)  //Item 33 Median
		$Array_Ptr:=->v_23_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_23_003_atxt; [Item 33 Median:23]Item_33_Median_UUIDKey_s:3; *)  //Item_33_Median_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_23_001_atxt; [Item 33 Median:23]Code:1; v_23_002_atxt; [Item 33 Median:23]Description:2)
		End if 
	: ($1=24)  //Item 38
		$Array_Ptr:=->v_24_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_24_003_atxt; [Item 38:24]Item_38_UUIDKey_s:3; *)  //Item_38_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_24_001_atxt; [Item 38:24]Code:1; v_24_002_atxt; [Item 38:24]Description:2)
		End if 
	: ($1=25)  //HistSig
		$Array_Ptr:=->v_25_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_25_003_atxt; [HistSig:25]HistSig_UUIDKey_s:3; *)  //HistSig_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_25_001_atxt; [HistSig:25]Code:1; v_25_002_atxt; [HistSig:25]Description:2)
		End if 
	: ($1=26)  //Months
		$Array_Ptr:=->v_26_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_26_003_atxt; [Months:26]Months_UUIDKey_s:3; *)  //Months_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_26_002_atxt; [Months:26]Description:2; *)
			ARRAY TO SELECTION:C261(v_26_001_ai; [Months:26]Code:1)
		End if 
	: ($1=27)  //Inspections
		$Array_Ptr:=->v_27_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_27_226_atxt; [Inspections:27]Inspections_UUIDKey_s:226; *)  //Inspections_UUIDKey_s
			End if 
			If (clone_UseBlobArrays_B)
				ARRAY TO SELECTION:C261(v_27_171_ablb; [Inspections:27]InspComments:171; v_27_204_ablb; [Inspections:27]OrientationText:204; *)
			Else 
				clone_GetBlobs($1)
			End if 
			ARRAY TO SELECTION:C261(v_27_002_aL; [Inspections:27]InspID:2; *)
			
			ARRAY TO SELECTION:C261(v_27_001_atxt; [Inspections:27]BIN:1; *)
			ARRAY TO SELECTION:C261(v_27_006_atxt; [Inspections:27]Insp Type:6; v_27_007_atxt; [Inspections:27]Weather:7; v_27_013_atxt; [Inspections:27]CollisionDamSup:13; *)
			ARRAY TO SELECTION:C261(v_27_014_atxt; [Inspections:27]LoadDeflection:14; v_27_015_atxt; [Inspections:27]LoadVibration:15; v_27_018_atxt; [Inspections:27]CollisionDamSub:18; *)
			ARRAY TO SELECTION:C261(v_27_020_atxt; [Inspections:27]Scour:20; v_27_021_atxt; [Inspections:27]StreamFlowV:21; v_27_022_atxt; [Inspections:27]Railing36:22; *)
			ARRAY TO SELECTION:C261(v_27_023_atxt; [Inspections:27]Transitions36:23; v_27_024_atxt; [Inspections:27]ApprGrdRail36:24; v_27_025_atxt; [Inspections:27]ApprGdRailEnd36:25; *)
			ARRAY TO SELECTION:C261(v_27_037_atxt; [Inspections:27]BrPostSignsNE:37; v_27_038_atxt; [Inspections:27]BrPostSignsSW:38; v_27_039_atxt; [Inspections:27]AdPostSignNE:39; *)
			ARRAY TO SELECTION:C261(v_27_040_atxt; [Inspections:27]AdPostSignSW:40; v_27_054_atxt; [Inspections:27]BrClrSignsNE:54; v_27_055_atxt; [Inspections:27]BrClrSignsSW:55; *)
			ARRAY TO SELECTION:C261(v_27_056_atxt; [Inspections:27]AdClrSignNE:56; v_27_057_atxt; [Inspections:27]AdClrSignSW:57; v_27_066_atxt; [Inspections:27]Item 60 UW:66; *)
			ARRAY TO SELECTION:C261(v_27_071_atxt; [Inspections:27]VCR Tape No:71; v_27_072_atxt; [Inspections:27]Item 61 UW:72; v_27_076_atxt; [Inspections:27]RatingTxt:76; *)
			ARRAY TO SELECTION:C261(v_27_077_atxt; [Inspections:27]Item 41:77; v_27_079_atxt; [Inspections:27]Item 58:79; v_27_080_atxt; [Inspections:27]Item 59:80; *)
			ARRAY TO SELECTION:C261(v_27_081_atxt; [Inspections:27]Item 60:81; v_27_082_atxt; [Inspections:27]Item 61:82; v_27_083_atxt; [Inspections:27]PedBarricadesNE:83; *)
			ARRAY TO SELECTION:C261(v_27_084_atxt; [Inspections:27]PedBarricadesSW:84; v_27_085_atxt; [Inspections:27]RatingPriority:85; v_27_086_atxt; [Inspections:27]LiftBucket:86; *)
			ARRAY TO SELECTION:C261(v_27_087_atxt; [Inspections:27]Ladder:87; v_27_088_atxt; [Inspections:27]Boat:88; v_27_089_atxt; [Inspections:27]Wader:89; *)
			ARRAY TO SELECTION:C261(v_27_090_atxt; [Inspections:27]Inspector50:90; v_27_091_atxt; [Inspections:27]Rigging:91; v_27_092_atxt; [Inspections:27]Staging:92; *)
			ARRAY TO SELECTION:C261(v_27_093_atxt; [Inspections:27]Traffic Control:93; v_27_094_atxt; [Inspections:27]RR Flagman:94; v_27_095_atxt; [Inspections:27]Police:95; *)
			ARRAY TO SELECTION:C261(v_27_096_atxt; [Inspections:27]AccessOther:96; v_27_097_atxt; [Inspections:27]OtherAccBool:97; v_27_098_atxt; [Inspections:27]CollisionSuper:98; *)
			ARRAY TO SELECTION:C261(v_27_099_atxt; [Inspections:27]LoadDeflSuper:99; v_27_100_atxt; [Inspections:27]LoadVibSuper:100; v_27_101_atxt; [Inspections:27]CollisionSub:101; *)
			ARRAY TO SELECTION:C261(v_27_102_atxt; [Inspections:27]UnderminingTxt:102; v_27_103_atxt; [Inspections:27]ScourTxt:103; v_27_104_atxt; [Inspections:27]FieldTests:104; *)
			ARRAY TO SELECTION:C261(v_27_106_atxt; [Inspections:27]BotCondition:106; v_27_107_atxt; [Inspections:27]UW BrgAccess:107; v_27_110_atxt; [Inspections:27]Current:110; *)
			ARRAY TO SELECTION:C261(v_27_113_atxt; [Inspections:27]Item 62:113; v_27_117_atxt; [Inspections:27]Barrier Type:117; v_27_119_atxt; [Inspections:27]BrCldSignsNE:119; *)
			ARRAY TO SELECTION:C261(v_27_120_atxt; [Inspections:27]BrCldSignsSW:120; v_27_121_atxt; [Inspections:27]AdCldSignsNE:121; v_27_122_atxt; [Inspections:27]AdCldSignsSW:122; *)
			ARRAY TO SELECTION:C261(v_27_131_atxt; [Inspections:27]CldSignLegend:131; v_27_132_atxt; [Inspections:27]DamageCmtsPg1:132; v_27_134_atxt; [Inspections:27]Modified By:134; *)
			ARRAY TO SELECTION:C261(v_27_140_atxt; [Inspections:27]Item 43:140; v_27_141_atxt; [Inspections:27]Item 107:141; v_27_143_atxt; [Inspections:27]Item59_i:143; *)
			ARRAY TO SELECTION:C261(v_27_144_atxt; [Inspections:27]Item60_i:144; v_27_146_atxt; [Inspections:27]CauDamage:146; v_27_148_atxt; [Inspections:27]DamageBy:148; *)
			ARRAY TO SELECTION:C261(v_27_150_atxt; [Inspections:27]ReimburseNo:150; v_27_151_atxt; [Inspections:27]Item58_i:151; v_27_152_atxt; [Inspections:27]Item60UW_i:152; *)
			ARRAY TO SELECTION:C261(v_27_153_atxt; [Inspections:27]Item61UW_i:153; v_27_154_atxt; [Inspections:27]Item62UW_i:154; v_27_155_atxt; [Inspections:27]Item 60 Cur:155; *)
			ARRAY TO SELECTION:C261(v_27_156_atxt; [Inspections:27]Agency:156; v_27_159_atxt; [Inspections:27]Item 61 Cur:159; v_27_165_atxt; [Inspections:27]Item 62 UW:165; *)
			ARRAY TO SELECTION:C261(v_27_166_atxt; [Inspections:27]Item21:166; v_27_169_atxt; [Inspections:27]InspApprCmts:169; v_27_170_atxt; [Inspections:27]InspRevCmts:170; *)
			ARRAY TO SELECTION:C261(v_27_172_atxt; [Inspections:27]Item 62 Cur:172; v_27_173_atxt; [Inspections:27]Item61_i:173; v_27_174_atxt; [Inspections:27]Item62_i:174; *)
			ARRAY TO SELECTION:C261(v_27_176_atxt; [Inspections:27]CulvertCoating:176; v_27_177_atxt; [Inspections:27]CulvertMaterial:177; v_27_178_atxt; [Inspections:27]CulvertShape:178; *)
			ARRAY TO SELECTION:C261(v_27_181_atxt; [Inspections:27]ClassAEmp:181; v_27_182_atxt; [Inspections:27]ConfinedSp:182; v_27_183_atxt; [Inspections:27]OffHrsWork:183; *)
			ARRAY TO SELECTION:C261(v_27_185_atxt; [Inspections:27]Dam_Boston_Office_Fwd:185; v_27_186_atxt; [Inspections:27]Dam_Boston_Office_Remarks:186; v_27_189_atxt; [Inspections:27]Cld_Contractor:189; *)
			ARRAY TO SELECTION:C261(v_27_190_atxt; [Inspections:27]Cld_Contract_Number:190; v_27_191_atxt; [Inspections:27]Cld_Remarks:191; v_27_192_atxt; [Inspections:27]Cld_Resident_Engineer:192; *)
			ARRAY TO SELECTION:C261(v_27_193_atxt; [Inspections:27]Cld_Scope_of_Work:193; v_27_194_atxt; [Inspections:27]Cld_Schedule:194; v_27_197_atxt; [Inspections:27]Item22:197; *)
			ARRAY TO SELECTION:C261(v_27_200_atxt; [Inspections:27]Item26:200; v_27_203_atxt; [Inspections:27]RatingFeedBack:203; v_27_208_atxt; [Inspections:27]ConsScoreCmts:208; *)
			ARRAY TO SELECTION:C261(v_27_210_atxt; [Inspections:27]Item58_r:210; v_27_211_atxt; [Inspections:27]Item59_r:211; v_27_212_atxt; [Inspections:27]Item60_r:212; *)
			ARRAY TO SELECTION:C261(v_27_213_atxt; [Inspections:27]Item62_r:213; v_27_215_atxt; [Inspections:27]BaseType_s:215; v_27_219_atxt; [Inspections:27]Rating_WorkCar_desc_s:219; *)
			ARRAY TO SELECTION:C261(v_27_220_atxt; [Inspections:27]Rating_RevCar_desc_s:220; v_27_229_atxt; [Inspections:27]Item113:229; *)
			ARRAY TO SELECTION:C261(v_27_108_ar; [Inspections:27]WaterDepth:108; v_27_109_ar; [Inspections:27]WaterVisibility:109; v_27_111_ar; [Inspections:27]DepthofCovNE:111; *)
			ARRAY TO SELECTION:C261(v_27_112_ar; [Inspections:27]DepthofCovSW:112; v_27_164_ar; [Inspections:27]ClrMinM:164; v_27_179_ar; [Inspections:27]BarrelsWidth:179; *)
			ARRAY TO SELECTION:C261(v_27_180_ar; [Inspections:27]BarrelsHeight:180; v_27_187_ar; [Inspections:27]Cld_Amount:187; *)
			ARRAY TO SELECTION:C261(v_27_003_ai; [Inspections:27]DBrInspEngr:3; v_27_004_ai; [Inspections:27]TeamLeader:4; v_27_008_ai; [Inspections:27]TempA:8; *)
			ARRAY TO SELECTION:C261(v_27_010_ai; [Inspections:27]CurbRevealNE:10; v_27_011_ai; [Inspections:27]CurbRevealSW:11; v_27_012_ai; [Inspections:27]InspReviewed:12; *)
			ARRAY TO SELECTION:C261(v_27_026_ai; [Inspections:27]ActualPostH:26; v_27_027_ai; [Inspections:27]ActualPost3:27; v_27_028_ai; [Inspections:27]ActualPost3S2:28; *)
			ARRAY TO SELECTION:C261(v_27_029_ai; [Inspections:27]ActualPostSgl:29; v_27_031_ai; [Inspections:27]RecomPostingH:31; v_27_032_ai; [Inspections:27]RecomPosting3:32; *)
			ARRAY TO SELECTION:C261(v_27_033_ai; [Inspections:27]RecomPosting3S2:33; v_27_034_ai; [Inspections:27]RecomPostingSgl:34; v_27_041_ai; [Inspections:27]BrPostNELeg:41; *)
			ARRAY TO SELECTION:C261(v_27_042_ai; [Inspections:27]BrPostNEVis:42; v_27_043_ai; [Inspections:27]BrPostSWLeg:43; v_27_044_ai; [Inspections:27]BrPostSWVis:44; *)
			ARRAY TO SELECTION:C261(v_27_045_ai; [Inspections:27]AdPostNELeg:45; v_27_046_ai; [Inspections:27]AdPostNEVis:46; v_27_047_ai; [Inspections:27]AdPostSWLeg:47; *)
			ARRAY TO SELECTION:C261(v_27_048_ai; [Inspections:27]AdPostSWVis:48; v_27_050_ai; [Inspections:27]NEClrFldFT:50; v_27_051_ai; [Inspections:27]NEClrFldIN:51; *)
			ARRAY TO SELECTION:C261(v_27_052_ai; [Inspections:27]NEClrPostedFT:52; v_27_053_ai; [Inspections:27]NEClrPostedIN:53; v_27_058_ai; [Inspections:27]BrClrSignNELeg:58; *)
			ARRAY TO SELECTION:C261(v_27_059_ai; [Inspections:27]BrClrSignNEVis:59; v_27_060_ai; [Inspections:27]BrClrSignSWLeg:60; v_27_061_ai; [Inspections:27]BrClrSignSWVis:61; *)
			ARRAY TO SELECTION:C261(v_27_062_ai; [Inspections:27]AdClrSignNELeg:62; v_27_063_ai; [Inspections:27]AdClrSignNEVis:63; v_27_064_ai; [Inspections:27]AdClrSignSWLeg:64; *)
			ARRAY TO SELECTION:C261(v_27_065_ai; [Inspections:27]AdClrSignSWVis:65; v_27_068_ai; [Inspections:27]Total HRS:68; v_27_105_ai; [Inspections:27]LevelofInsp:105; *)
			ARRAY TO SELECTION:C261(v_27_123_ai; [Inspections:27]BrCldSignNELeg:123; v_27_124_ai; [Inspections:27]BrCldSignNEVis:124; v_27_125_ai; [Inspections:27]BrCldSignSWLeg:125; *)
			ARRAY TO SELECTION:C261(v_27_126_ai; [Inspections:27]BrCldSignSWVis:126; v_27_127_ai; [Inspections:27]AdCldSignNELeg:127; v_27_128_ai; [Inspections:27]AdCldSignNEVis:128; *)
			ARRAY TO SELECTION:C261(v_27_129_ai; [Inspections:27]AdCldSignSWLeg:129; v_27_130_ai; [Inspections:27]AdCldSignSWVis:130; v_27_157_ai; [Inspections:27]YrPainted:157; *)
			ARRAY TO SELECTION:C261(v_27_158_ai; [Inspections:27]YrRehab:158; v_27_160_ai; [Inspections:27]SWClrFldFT:160; v_27_161_ai; [Inspections:27]SWClrFldIN:161; *)
			ARRAY TO SELECTION:C261(v_27_162_ai; [Inspections:27]SWClrPostedFT:162; v_27_163_ai; [Inspections:27]SWClrPostedIN:163; v_27_167_ai; [Inspections:27]InspApproved:167; *)
			ARRAY TO SELECTION:C261(v_27_175_ai; [Inspections:27]BarrelsNumber:175; v_27_198_ai; [Inspections:27]Item106:198; v_27_201_ai; [Inspections:27]ConsScoring:201; *)
			ARRAY TO SELECTION:C261(v_27_205_ai; [Inspections:27]ConsQCEngrID:205; *)
			ARRAY TO SELECTION:C261(v_27_005_aL; [Inspections:27]InDepthReview:5; v_27_217_aL; [Inspections:27]UpdateMaximo_L:217; v_27_227_aL; [Inspections:27]InvPhotoApproach_L:227; *)
			ARRAY TO SELECTION:C261(v_27_228_aL; [Inspections:27]InvPhotoElevation_L:228; *)
			ARRAY TO SELECTION:C261(v_27_035_ad; [Inspections:27]WaivedDate:35; v_27_036_ad; [Inspections:27]EDJMT Date:36; v_27_067_ad; [Inspections:27]Item 93b:67; *)
			ARRAY TO SELECTION:C261(v_27_074_ad; [Inspections:27]Rating Date:74; v_27_078_ad; [Inspections:27]Insp Date:78; v_27_114_ad; [Inspections:27]PostingDate:114; *)
			ARRAY TO SELECTION:C261(v_27_135_ad; [Inspections:27]DateCreated:135; v_27_137_ad; [Inspections:27]DateModified:137; v_27_142_ad; [Inspections:27]Item 90:142; *)
			ARRAY TO SELECTION:C261(v_27_147_ad; [Inspections:27]D_Damage:147; v_27_184_ad; [Inspections:27]Dam_Boston_Office_Date:184; v_27_188_ad; [Inspections:27]Cld_Completion_Date:188; *)
			ARRAY TO SELECTION:C261(v_27_202_ad; [Inspections:27]ConsAcceptanceDate:202; v_27_206_ad; [Inspections:27]InspDBIEApprDate:206; v_27_207_ad; [Inspections:27]InspAreaEngApprDate:207; *)
			ARRAY TO SELECTION:C261(v_27_214_ad; [Inspections:27]InspDate_r:214; v_27_218_ad; [Inspections:27]CreateApprovedPDF_d:218; v_27_221_ad; [Inspections:27]InspCompleteDate:221; *)
			ARRAY TO SELECTION:C261(v_27_222_ad; [Inspections:27]InspDBIEReviewDate:222; v_27_223_ad; [Inspections:27]InspAIEReviewDate:223; v_27_224_ad; [Inspections:27]InspFldWorkComplDate:224; *)
			ARRAY TO SELECTION:C261(v_27_225_ad; [Inspections:27]InspDBIE1stApprDate:225; *)
			ARRAY TO SELECTION:C261(v_27_136_atm; [Inspections:27]TimeCreated:136; v_27_138_atm; [Inspections:27]TimeModified:138; *)
			ARRAY TO SELECTION:C261(v_27_009_ab; [Inspections:27]InitialInsp:9; v_27_016_ab; [Inspections:27]FractureCrit:16; v_27_017_ab; [Inspections:27]Cracks:17; *)
			ARRAY TO SELECTION:C261(v_27_019_ab; [Inspections:27]UnderMining:19; v_27_030_ab; [Inspections:27]WeightPosting:30; v_27_049_ab; [Inspections:27]ClrPosting:49; *)
			ARRAY TO SELECTION:C261(v_27_069_ab; [Inspections:27]Plans:69; v_27_070_ab; [Inspections:27]VCR:70; v_27_073_ab; [Inspections:27]Rating Report:73; *)
			ARRAY TO SELECTION:C261(v_27_075_ab; [Inspections:27]Rerating:75; v_27_115_ab; [Inspections:27]BarriersIP:115; v_27_116_ab; [Inspections:27]RoadWayAbandon:116; *)
			ARRAY TO SELECTION:C261(v_27_118_ab; [Inspections:27]ClosedSigns:118; v_27_133_ab; [Inspections:27]OrientationNS:133; v_27_139_ab; [Inspections:27]UWInspReqd:139; *)
			ARRAY TO SELECTION:C261(v_27_145_ab; [Inspections:27]ClsdRoutine:145; v_27_149_ab; [Inspections:27]AccidentRep:149; v_27_168_ab; [Inspections:27]InspComplete:168; *)
			ARRAY TO SELECTION:C261(v_27_195_ab; [Inspections:27]Cld_UnderConstruction:195; v_27_196_ab; [Inspections:27]DoNotShowDialogDependency:196; v_27_199_ab; [Inspections:27]TeamMembrAddl:199; *)
			ARRAY TO SELECTION:C261(v_27_209_ab; [Inspections:27]InspRtnSpcMemFlag:209; v_27_216_ab; [Inspections:27]ADA_Accessible_b:216)
		End if 
	: ($1=28)  //Sequences
		$Array_Ptr:=->v_28_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_28_004_atxt; [Sequences:28]Sequences_UUIDKey_s:4; *)  //Sequences_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_28_001_atxt; [Sequences:28]Name:1; *)
			
			ARRAY TO SELECTION:C261(v_28_002_aL; [Sequences:28]Value:2; *)
			ARRAY TO SELECTION:C261(v_28_003_ab; [Sequences:28]Increment:3)
		End if 
	: ($1=29)  //ElementsSafety
		$Array_Ptr:=->v_29_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_29_027_atxt; [ElementsSafety:29]ElementsSafety_UUIDKey_s:27; *)  //ElementsSafety_UUIDKey_s
			End if 
			If (clone_UseBlobArrays_B)
				ARRAY TO SELECTION:C261(v_29_023_ablb; [ElementsSafety:29]ElmComments:23; *)
			Else 
				clone_GetBlobs($1)
			End if 
			ARRAY TO SELECTION:C261(v_29_007_aL; [ElementsSafety:29]ElmSafetyID:7; *)
			
			ARRAY TO SELECTION:C261(v_29_002_atxt; [ElementsSafety:29]Rating:2; v_29_003_atxt; [ElementsSafety:29]Deficiency:3; *)
			ARRAY TO SELECTION:C261(v_29_005_atxt; [ElementsSafety:29]Comments:5; v_29_010_atxt; [ElementsSafety:29]Weld Condition:10; v_29_014_atxt; [ElementsSafety:29]Modified By:14; *)
			ARRAY TO SELECTION:C261(v_29_015_atxt; [ElementsSafety:29]Rating_i:15; v_29_020_atxt; [ElementsSafety:29]Priority:20; v_29_021_atxt; [ElementsSafety:29]AltRating:21; *)
			ARRAY TO SELECTION:C261(v_29_022_atxt; [ElementsSafety:29]Description:22; v_29_024_atxt; [ElementsSafety:29]AltRating_i:24; v_29_025_atxt; [ElementsSafety:29]ModTimeStamp_s:25; *)
			ARRAY TO SELECTION:C261(v_29_026_atxt; [ElementsSafety:29]maximo_UpdateTimeStamp_s:26; *)
			ARRAY TO SELECTION:C261(v_29_001_ai; [ElementsSafety:29]ElementNo:1; v_29_011_ai; [ElementsSafety:29]Inv H20:11; v_29_012_ai; [ElementsSafety:29]Inv Type 3:12; *)
			ARRAY TO SELECTION:C261(v_29_013_ai; [ElementsSafety:29]Inv 3S2:13; *)
			ARRAY TO SELECTION:C261(v_29_004_aL; [ElementsSafety:29]InspID:4; *)
			ARRAY TO SELECTION:C261(v_29_016_ad; [ElementsSafety:29]DateCreated:16; v_29_018_ad; [ElementsSafety:29]DateModified:18; *)
			ARRAY TO SELECTION:C261(v_29_017_atm; [ElementsSafety:29]TimeCreated:17; v_29_019_atm; [ElementsSafety:29]TimeModified:19; *)
			ARRAY TO SELECTION:C261(v_29_006_ab; [ElementsSafety:29]Comment Flag:6; v_29_008_ab; [ElementsSafety:29]SpecMemb Flag:8; v_29_009_ab; [ElementsSafety:29]Crack:9)
		End if 
	: ($1=30)  //ElementDict
		$Array_Ptr:=->v_30_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_30_015_atxt; [ElementDict:30]ElementDict_UUIDKey_s:15; *)  //ElementDict_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_30_001_ai; [ElementDict:30]ElementNo:1; *)
			
			ARRAY TO SELECTION:C261(v_30_002_atxt; [ElementDict:30]Description:2; v_30_003_atxt; [ElementDict:30]Category:3; v_30_010_atxt; [ElementDict:30]ModifiedBy:10; *)
			ARRAY TO SELECTION:C261(v_30_011_atxt; [ElementDict:30]Prefix:11; v_30_012_atxt; [ElementDict:30]Part:12; v_30_013_atxt; [ElementDict:30]FullLabel:13; *)
			ARRAY TO SELECTION:C261(v_30_014_atxt; [ElementDict:30]FullLabelArch:14; *)
			ARRAY TO SELECTION:C261(v_30_004_ai; [ElementDict:30]Parent:4; *)
			ARRAY TO SELECTION:C261(v_30_006_ad; [ElementDict:30]DateCreated:6; v_30_008_ad; [ElementDict:30]DateModified:8; *)
			ARRAY TO SELECTION:C261(v_30_007_atm; [ElementDict:30]TimeCreated:7; v_30_009_atm; [ElementDict:30]TimeModified:9; *)
			ARRAY TO SELECTION:C261(v_30_005_ab; [ElementDict:30]IsParent:5)
		End if 
	: ($1=31)  //Inspection Type
		$Array_Ptr:=->v_31_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_31_003_atxt; [Inspection Type:31]Inspection_Type_UUIDKey_s:3; *)  //Inspection_Type_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_31_001_atxt; [Inspection Type:31]Code:1; *)
			
			ARRAY TO SELECTION:C261(v_31_002_atxt; [Inspection Type:31]Description:2; v_31_004_atxt; [Inspection Type:31]ElementNumbers_txt:4)
		End if 
	: ($1=32)  //Element Cat
		$Array_Ptr:=->v_32_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_32_005_atxt; [Element Cat:32]Element_Cat_UUIDKey_s:5; *)  //Element_Cat_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_32_001_atxt; [Element Cat:32]Code:1; *)
			
			ARRAY TO SELECTION:C261(v_32_002_atxt; [Element Cat:32]Description:2; *)
			ARRAY TO SELECTION:C261(v_32_003_ab; [Element Cat:32]CulvertElement:3; v_32_004_ab; [Element Cat:32]RegularElement:4)
		End if 
	: ($1=33)  //Item 100
		$Array_Ptr:=->v_33_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_33_003_atxt; [Item 100:33]Item_100_UUIDKey_s:3; *)  //Item_100_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_33_001_atxt; [Item 100:33]Code:1; v_33_002_atxt; [Item 100:33]Description:2)
		End if 
	: ($1=34)  //Item 101
		$Array_Ptr:=->v_34_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_34_003_atxt; [Item 101:34]Item_101_UUIDKey_s:3; *)  //Item_101_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_34_001_atxt; [Item 101:34]Code:1; v_34_002_atxt; [Item 101:34]Description:2)
		End if 
	: ($1=35)  //Item 111
		$Array_Ptr:=->v_35_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_35_003_atxt; [Item 111:35]Item_111_UUIDKey_s:3; *)  //Item_111_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_35_001_atxt; [Item 111:35]Code:1; v_35_002_atxt; [Item 111:35]Description:2)
		End if 
	: ($1=36)  //Standard Photos
		$Array_Ptr:=->v_36_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_36_010_atxt; [Standard Photos:36]Standard_Photos_UUIDKey_s:10; *)  //Standard_Photos_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_36_007_aL; [Standard Photos:36]StdPhotoID:7; *)
			
			ARRAY TO SELECTION:C261(v_36_002_atxt; [Standard Photos:36]Description:2; v_36_005_atxt; [Standard Photos:36]PictType:5; v_36_008_atxt; [Standard Photos:36]ModTimeStamp_s:8; *)
			ARRAY TO SELECTION:C261(v_36_009_atxt; [Standard Photos:36]maximo_UpdateTimeStamp_s:9; *)
			ARRAY TO SELECTION:C261(v_36_006_ai; [Standard Photos:36]SeqNum:6; *)
			ARRAY TO SELECTION:C261(v_36_001_aL; [Standard Photos:36]InspID:1; *)
			ARRAY TO SELECTION:C261(v_36_004_ab; [Standard Photos:36]Portrait:4; *)
			ARRAY TO SELECTION:C261(v_36_003_ap; [Standard Photos:36]Std Photo:3)
		End if 
	: ($1=37)  //RAILBridgeInfo
		$Array_Ptr:=->v_37_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_37_046_atxt; [RAILBridgeInfo:37]RAILBridgeInfo_UUIDKey_s:46; *)  //RAILBridgeInfo_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_37_001_atxt; [RAILBridgeInfo:37]BIN:1; *)
			
			ARRAY TO SELECTION:C261(v_37_004_atxt; [RAILBridgeInfo:37]TypeOfTies:4; v_37_005_atxt; [RAILBridgeInfo:37]Ballast:5; v_37_006_atxt; [RAILBridgeInfo:37]LineName:6; *)
			ARRAY TO SELECTION:C261(v_37_017_atxt; [RAILBridgeInfo:37]CreatedBy_s:17; v_37_020_atxt; [RAILBridgeInfo:37]ModifiedBy_s:20; v_37_030_atxt; [RAILBridgeInfo:37]Rating_RevCar_desc_s:30; *)
			ARRAY TO SELECTION:C261(v_37_040_atxt; [RAILBridgeInfo:37]Rating_WorkCar_desc_s:40; v_37_056_atxt; [RAILBridgeInfo:37]Rating_RevCar2_desc_s:56; v_37_060_atxt; [RAILBridgeInfo:37]Rating_RevCar3_desc_s:60; *)
			ARRAY TO SELECTION:C261(v_37_002_ar; [RAILBridgeInfo:37]MilePt:2; v_37_008_ar; [RAILBridgeInfo:37]Rating_E80:8; v_37_009_ar; [RAILBridgeInfo:37]Rating_F40PH:9; *)
			ARRAY TO SELECTION:C261(v_37_010_ar; [RAILBridgeInfo:37]Rating_286K:10; v_37_011_ar; [RAILBridgeInfo:37]Rating_263K:11; v_37_012_ar; [RAILBridgeInfo:37]Rating_E80_Max:12; *)
			ARRAY TO SELECTION:C261(v_37_013_ar; [RAILBridgeInfo:37]Rating_F40PH_Max:13; v_37_014_ar; [RAILBridgeInfo:37]Rating_286K_Max:14; v_37_015_ar; [RAILBridgeInfo:37]Rating_263K_Max:15; *)
			ARRAY TO SELECTION:C261(v_37_023_ar; [RAILBridgeInfo:37]Rating_E80_fatigue_r:23; v_37_024_ar; [RAILBridgeInfo:37]Rating_F40PH_fatigue_r:24; v_37_025_ar; [RAILBridgeInfo:37]Rating_286K_fatigue_r:25; *)
			ARRAY TO SELECTION:C261(v_37_026_ar; [RAILBridgeInfo:37]Rating_263K_fatigue_r:26; v_37_027_ar; [RAILBridgeInfo:37]Rating_RevCar_inv_r:27; v_37_028_ar; [RAILBridgeInfo:37]Rating_RevCar_oper_r:28; *)
			ARRAY TO SELECTION:C261(v_37_029_ar; [RAILBridgeInfo:37]Rating_RevCar_fatigue_r:29; v_37_031_ar; [RAILBridgeInfo:37]Rating_NEOPLAN_inv_r:31; v_37_032_ar; [RAILBridgeInfo:37]Rating_NEOPLAN_oper_r:32; *)
			ARRAY TO SELECTION:C261(v_37_033_ar; [RAILBridgeInfo:37]Rating_NEOPLAN_fatigue_r:33; v_37_034_ar; [RAILBridgeInfo:37]Rating_NABI_inv_r:34; v_37_035_ar; [RAILBridgeInfo:37]Rating_NABI_oper_r:35; *)
			ARRAY TO SELECTION:C261(v_37_036_ar; [RAILBridgeInfo:37]Rating_NABI_fatigue_r:36; v_37_037_ar; [RAILBridgeInfo:37]Rating_WorkCar_inv_r:37; v_37_038_ar; [RAILBridgeInfo:37]Rating_WorkCar_oper_r:38; *)
			ARRAY TO SELECTION:C261(v_37_039_ar; [RAILBridgeInfo:37]Rating_WorkCar_fatigue_r:39; v_37_041_ar; [RAILBridgeInfo:37]Rating_315K:41; v_37_042_ar; [RAILBridgeInfo:37]Rating_315K_Max:42; *)
			ARRAY TO SELECTION:C261(v_37_043_ar; [RAILBridgeInfo:37]Rating_315K_fatigue_R:43; v_37_044_ar; [RAILBridgeInfo:37]Rating_HybridArtic_inv_r:44; v_37_045_ar; [RAILBridgeInfo:37]Rating_HybridArtic_oper_r:45; *)
			ARRAY TO SELECTION:C261(v_37_047_ar; [RAILBridgeInfo:37]Rating_HSP46:47; v_37_048_ar; [RAILBridgeInfo:37]Rating_HSP46_Max:48; v_37_049_ar; [RAILBridgeInfo:37]Rating_HSP46_fatigue_r:49; *)
			ARRAY TO SELECTION:C261(v_37_050_ar; [RAILBridgeInfo:37]Rating_ES44AC:50; v_37_051_ar; [RAILBridgeInfo:37]Rating_ES44AC_Max:51; v_37_052_ar; [RAILBridgeInfo:37]Rating_ES44AC_fatigue_r:52; *)
			ARRAY TO SELECTION:C261(v_37_053_ar; [RAILBridgeInfo:37]Rating_RevCar2_inv_r:53; v_37_054_ar; [RAILBridgeInfo:37]Rating_RevCar2_oper_r:54; v_37_055_ar; [RAILBridgeInfo:37]Rating_RevCar2_fatigue_r:55; *)
			ARRAY TO SELECTION:C261(v_37_057_ar; [RAILBridgeInfo:37]Rating_RevCar3_inv_r:57; v_37_058_ar; [RAILBridgeInfo:37]Rating_RevCar3_oper_r:58; v_37_059_ar; [RAILBridgeInfo:37]Rating_RevCar3_fatigue_r:59; *)
			ARRAY TO SELECTION:C261(v_37_003_aL; [RAILBridgeInfo:37]NoTracksOn:3; v_37_007_aL; [RAILBridgeInfo:37]NoTracksUnder:7; *)
			ARRAY TO SELECTION:C261(v_37_016_ad; [RAILBridgeInfo:37]RatingDate:16; v_37_018_ad; [RAILBridgeInfo:37]Created_Date_d:18; v_37_021_ad; [RAILBridgeInfo:37]Modified_Date_d:21; *)
			ARRAY TO SELECTION:C261(v_37_019_atm; [RAILBridgeInfo:37]Created_Time_t:19; v_37_022_atm; [RAILBridgeInfo:37]Modified_Time_t:22)
		End if 
	: ($1=38)  //Foundation Type
		$Array_Ptr:=->v_38_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_38_003_atxt; [Foundation Type:38]Foundation_Type_UUIDKey_s:3; *)  //Foundation_Type_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_38_001_atxt; [Foundation Type:38]Code:1; v_38_002_atxt; [Foundation Type:38]Description:2)
		End if 
	: ($1=39)  //Bed Material
		$Array_Ptr:=->v_39_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_39_003_atxt; [Bed Material:39]Bed_Material_UUIDKey_s:3; *)  //Bed_Material_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_39_001_atxt; [Bed Material:39]Code:1; v_39_002_atxt; [Bed Material:39]Description:2)
		End if 
	: ($1=40)  //Pontis_Metric_Data
		$Array_Ptr:=->v_40_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_40_011_atxt; [Pontis_Metric_Data:40]Pontis_Metric_Data_UUIDKey_s:11; *)  //Pontis_Metric_Data_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_40_001_atxt; [Pontis_Metric_Data:40]PM_UNiqueKey_s:1; *)
			ARRAY TO SELECTION:C261(v_40_003_ar; [Pontis_Metric_Data:40]PMD_Hindex_r:3; v_40_005_ar; [Pontis_Metric_Data:40]PMD_PTIndex_r:5; v_40_006_ar; [Pontis_Metric_Data:40]PMD_CIX_Supr_r:6; *)
			ARRAY TO SELECTION:C261(v_40_007_ar; [Pontis_Metric_Data:40]PMD_CIX_Sub_r:7; v_40_008_ar; [Pontis_Metric_Data:40]PMD_CIX_Joint_r:8; v_40_009_ar; [Pontis_Metric_Data:40]PMD_CIX_Bear_r:9; *)
			ARRAY TO SELECTION:C261(v_40_010_ar; [Pontis_Metric_Data:40]PMD_CIX_Deck_r:10; *)
			ARRAY TO SELECTION:C261(v_40_002_aL; [Pontis_Metric_Data:40]PMD_YKey_l:2; v_40_004_aL; [Pontis_Metric_Data:40]PMD_ADT_l:4)
		End if 
	: ($1=41)  //Pontis_Metrics
		$Array_Ptr:=->v_41_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_41_007_atxt; [Pontis_Metrics:41]Pontis_Metrics_UUIDKey_s:7; *)  //Pontis_Metrics_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_41_002_atxt; [Pontis_Metrics:41]PM_UniqueKey_s:2; *)
			
			ARRAY TO SELECTION:C261(v_41_003_atxt; [Pontis_Metrics:41]PM_Bin_s:3; v_41_005_atxt; [Pontis_Metrics:41]PM_SCKey_s:5; *)
			ARRAY TO SELECTION:C261(v_41_006_ar; [Pontis_Metrics:41]PM_Tev_r:6; *)
			ARRAY TO SELECTION:C261(v_41_001_aL; [Pontis_Metrics:41]PM_RunKey_l:1; *)
			ARRAY TO SELECTION:C261(v_41_004_ad; [Pontis_Metrics:41]PM_ImportDate_d:4)
		End if 
	: ($1=42)  //Personnel
		$Array_Ptr:=->v_42_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_42_019_atxt; [Personnel:42]Personnel_UUIDKey_s:19; *)  //Personnel_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_42_001_ai; [Personnel:42]Person ID:1; *)
			
			ARRAY TO SELECTION:C261(v_42_002_atxt; [Personnel:42]Prefix:2; v_42_003_atxt; [Personnel:42]First Name:3; v_42_004_atxt; [Personnel:42]Middle Name:4; *)
			ARRAY TO SELECTION:C261(v_42_005_atxt; [Personnel:42]Last Name:5; v_42_006_atxt; [Personnel:42]Suffix:6; v_42_007_atxt; [Personnel:42]Division No:7; *)
			ARRAY TO SELECTION:C261(v_42_009_atxt; [Personnel:42]Employer:9; v_42_013_atxt; [Personnel:42]Phone_s:13; v_42_014_atxt; [Personnel:42]EmailAddress_s:14; *)
			ARRAY TO SELECTION:C261(v_42_015_atxt; [Personnel:42]CellPhone_s:15; v_42_016_atxt; [Personnel:42]PagerNo_s:16; v_42_017_atxt; [Personnel:42]HomePhone_s:17; *)
			ARRAY TO SELECTION:C261(v_42_018_atxt; [Personnel:42]MachineName_txt:18; *)
			ARRAY TO SELECTION:C261(v_42_008_ai; [Personnel:42]Job Code:8; *)
			ARRAY TO SELECTION:C261(v_42_012_aL; [Personnel:42]UserID_4D:12; *)
			ARRAY TO SELECTION:C261(v_42_010_ab; [Personnel:42]DiveTeam:10; v_42_011_ab; [Personnel:42]Active:11)
		End if 
	: ($1=43)  //Field Trip
		$Array_Ptr:=->v_43_002_ai
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_43_003_atxt; [Field Trip:43]Field_Trip_UUIDKey_s:3; *)  //Field_Trip_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_43_002_ai; [Field Trip:43]Person ID:2; *)
			ARRAY TO SELECTION:C261(v_43_001_aL; [Field Trip:43]InspID:1)
		End if 
	: ($1=44)  //BMS Inspections
		$Array_Ptr:=->v_44_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_44_018_atxt; [BMS Inspections:44]BMS_Inspections_UUIDKey_s:18; *)  //BMS_Inspections_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_44_001_aL; [BMS Inspections:44]Inspection ID:1; *)
			
			ARRAY TO SELECTION:C261(v_44_002_atxt; [BMS Inspections:44]BIN:2; v_44_007_atxt; [BMS Inspections:44]Modified By:7; v_44_013_atxt; [BMS Inspections:44]Agency:13; *)
			ARRAY TO SELECTION:C261(v_44_015_ar; [BMS Inspections:44]INSP_HI:15; v_44_016_ar; [BMS Inspections:44]INSP_TotV:16; v_44_017_ar; [BMS Inspections:44]INSP_CurrV:17; *)
			ARRAY TO SELECTION:C261(v_44_003_ai; [BMS Inspections:44]Span Group No:3; v_44_005_ai; [BMS Inspections:44]DBrInspEngr:5; v_44_006_ai; [BMS Inspections:44]TeamLeader:6; *)
			ARRAY TO SELECTION:C261(v_44_012_ai; [BMS Inspections:44]ImportErrorCode:12; *)
			ARRAY TO SELECTION:C261(v_44_004_ad; [BMS Inspections:44]Insp Date:4; v_44_008_ad; [BMS Inspections:44]DateCreated:8; v_44_010_ad; [BMS Inspections:44]DateModified:10; *)
			ARRAY TO SELECTION:C261(v_44_009_atm; [BMS Inspections:44]TimeCreated:9; v_44_011_atm; [BMS Inspections:44]TimeModified:11; *)
			ARRAY TO SELECTION:C261(v_44_014_ab; [BMS Inspections:44]Metric:14)
		End if 
	: ($1=45)  //Cond Units
		$Array_Ptr:=->v_45_007_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_45_017_atxt; [Cond Units:45]Cond_Units_UUIDKey_s:17; *)  //Cond_Units_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_45_001_aL; [Cond Units:45]Cond Unit ID:1; *)
			
			ARRAY TO SELECTION:C261(v_45_007_atxt; [Cond Units:45]Comment:7; *)
			ARRAY TO SELECTION:C261(v_45_005_ar; [Cond Units:45]Total Quantity:5; v_45_010_ar; [Cond Units:45]CondState1:10; v_45_011_ar; [Cond Units:45]CondState2:11; *)
			ARRAY TO SELECTION:C261(v_45_012_ar; [Cond Units:45]CondState3:12; v_45_013_ar; [Cond Units:45]CondState4:13; v_45_014_ar; [Cond Units:45]CondState5:14; *)
			ARRAY TO SELECTION:C261(v_45_016_ar; [Cond Units:45]ScaleFactor:16; *)
			ARRAY TO SELECTION:C261(v_45_003_ai; [Cond Units:45]Element ID:3; v_45_004_ai; [Cond Units:45]Environment:4; v_45_008_ai; [Cond Units:45]ImportErrorCode:8; *)
			ARRAY TO SELECTION:C261(v_45_002_aL; [Cond Units:45]Inspection ID:2; *)
			ARRAY TO SELECTION:C261(v_45_015_ad; [Cond Units:45]DateModified_d:15; *)
			ARRAY TO SELECTION:C261(v_45_006_ab; [Cond Units:45]Percent:6; v_45_009_ab; [Cond Units:45]Metric:9)
		End if 
	: ($1=46)  //Cond State Insp
		$Array_Ptr:=->v_46_004_ar
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_46_006_atxt; [Cond State Insp:46]Cond_State_Insp_UUIDKey_s:6; *)  //Cond_State_Insp_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_46_004_ar; [Cond State Insp:46]Amount:4; *)
			ARRAY TO SELECTION:C261(v_46_003_ai; [Cond State Insp:46]Cond State No:3; *)
			ARRAY TO SELECTION:C261(v_46_002_aL; [Cond State Insp:46]Cond Unit ID:2; *)
			ARRAY TO SELECTION:C261(v_46_001_ab; [Cond State Insp:46]New:1; v_46_005_ab; [Cond State Insp:46]future use:5)
		End if 
	: ($1=47)  //BMS Elements
		$Array_Ptr:=->v_47_003_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_47_010_atxt; [BMS Elements:47]BMS_Elements_UUIDKey_s:10; *)  //BMS_Elements_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_47_001_ai; [BMS Elements:47]Element ID:1; v_47_002_ai; [BMS Elements:47]Element No:2; *)
			
			ARRAY TO SELECTION:C261(v_47_003_atxt; [BMS Elements:47]Element Name:3; v_47_004_atxt; [BMS Elements:47]Element Type:4; v_47_005_atxt; [BMS Elements:47]Elem Descript:5; *)
			ARRAY TO SELECTION:C261(v_47_006_atxt; [BMS Elements:47]Units:6; *)
			ARRAY TO SELECTION:C261(v_47_007_ai; [BMS Elements:47]Common Note ID:7; v_47_008_ai; [BMS Elements:47]Category ID:8; *)
			ARRAY TO SELECTION:C261(v_47_009_ab; [BMS Elements:47]future use:9)
		End if 
	: ($1=48)  //Environments
		$Array_Ptr:=->v_48_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_48_004_atxt; [Environments:48]Environments_UUIDKey_s:4; *)  //Environments_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_48_001_ai; [Environments:48]Envir No:1; *)
			
			ARRAY TO SELECTION:C261(v_48_002_atxt; [Environments:48]Envir Name:2; v_48_003_atxt; [Environments:48]Envir Descr:3)
		End if 
	: ($1=49)  //BMS Categories
		$Array_Ptr:=->v_49_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_49_008_atxt; [BMS Categories:49]BMS_Categories_UUIDKey_s:8; *)  //BMS_Categories_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_49_001_ai; [BMS Categories:49]Category ID:1; *)
			
			ARRAY TO SELECTION:C261(v_49_002_atxt; [BMS Categories:49]General Cat:2; v_49_003_atxt; [BMS Categories:49]Subcategory:3; v_49_004_atxt; [BMS Categories:49]Cat Note:4; *)
			ARRAY TO SELECTION:C261(v_49_007_ai; [BMS Categories:49]Num of CSs:7; *)
			ARRAY TO SELECTION:C261(v_49_005_ab; [BMS Categories:49]Smart Flag:5; v_49_006_ab; [BMS Categories:49]Record as Each:6)
		End if 
	: ($1=50)  //Element Costs
		$Array_Ptr:=->v_50_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_50_006_atxt; [Element Costs:50]Element_Costs_UUIDKey_s:6; *)  //Element_Costs_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_50_002_atxt; [Element Costs:50]Cond State No:2; v_50_003_atxt; [Element Costs:50]Action No:3; *)
			ARRAY TO SELECTION:C261(v_50_004_ar; [Element Costs:50]Cost:4; *)
			ARRAY TO SELECTION:C261(v_50_001_ai; [Element Costs:50]Element ID:1; v_50_005_ai; [Element Costs:50]Environment:5)
		End if 
	: ($1=51)  //Cond States
		$Array_Ptr:=->v_51_003_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_51_007_atxt; [Cond States:51]Cond_States_UUIDKey_s:7; *)  //Cond_States_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_51_001_ai; [Cond States:51]Cond State ID:1; *)
			
			ARRAY TO SELECTION:C261(v_51_003_atxt; [Cond States:51]Cond State No:3; v_51_004_atxt; [Cond States:51]Cond State Desc:4; v_51_005_atxt; [Cond States:51]CS Short Desc:5; *)
			ARRAY TO SELECTION:C261(v_51_002_ai; [Cond States:51]Category ID:2; v_51_006_ai; [Cond States:51]Num of Actions:6)
		End if 
	: ($1=52)  //CS Actions
		$Array_Ptr:=->v_52_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_52_005_atxt; [CS Actions:52]CS_Actions_UUIDKey_s:5; *)  //CS_Actions_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_52_002_atxt; [CS Actions:52]Action No:2; v_52_003_atxt; [CS Actions:52]Action Descript:3; v_52_004_atxt; [CS Actions:52]Act Short Desc:4; *)
			ARRAY TO SELECTION:C261(v_52_001_ai; [CS Actions:52]Cond State ID:1)
		End if 
	: ($1=53)  //CS Notes
		$Array_Ptr:=->v_53_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_53_003_atxt; [CS Notes:53]CS_Notes_UUIDKey_s:3; *)  //CS_Notes_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_53_001_ai; [CS Notes:53]CS Note ID:1; *)
			
			ARRAY TO SELECTION:C261(v_53_002_atxt; [CS Notes:53]CS Note:2)
		End if 
	: ($1=54)  //Common Notes
		$Array_Ptr:=->v_54_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_54_003_atxt; [Common Notes:54]Common_Notes_UUIDKey_s:3; *)  //Common_Notes_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_54_001_ai; [Common Notes:54]Common Note ID:1; *)
			
			ARRAY TO SELECTION:C261(v_54_002_atxt; [Common Notes:54]Common Note:2)
		End if 
	: ($1=55)  //Cat CS Notes
		$Array_Ptr:=->v_55_001_ai
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_55_003_atxt; [Cat CS Notes:55]Cat_CS_Notes_UUIDKey_s:3; *)  //Cat_CS_Notes_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_55_001_ai; [Cat CS Notes:55]Category ID:1; v_55_002_ai; [Cat CS Notes:55]CS Note ID:2)
		End if 
	: ($1=56)  //BMS Field Trip
		$Array_Ptr:=->v_56_002_ai
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_56_003_atxt; [BMS Field Trip:56]BMS_Field_Trip_UUIDKey_s:3; *)  //BMS_Field_Trip_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_56_002_ai; [BMS Field Trip:56]Person ID:2; *)
			ARRAY TO SELECTION:C261(v_56_001_aL; [BMS Field Trip:56]Inspection ID:1)
		End if 
	: ($1=57)  //Preferences
		$Array_Ptr:=->v_57_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_57_019_atxt; [Preferences:57]Preferences_UUIDKey_s:19; *)  //Preferences_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_57_001_atxt; [Preferences:57]Destination:1; v_57_003_atxt; [Preferences:57]Forward:3; v_57_004_atxt; [Preferences:57]DistrictInformation_s:4; *)
			ARRAY TO SELECTION:C261(v_57_009_atxt; [Preferences:57]DestIP:9; v_57_010_atxt; [Preferences:57]ForwardIP:10; v_57_012_atxt; [Preferences:57]TxUserName:12; *)
			ARRAY TO SELECTION:C261(v_57_014_atxt; [Preferences:57]DataFileKEY_s:14; v_57_015_atxt; [Preferences:57]Pontis_Password_s:15; v_57_016_atxt; [Preferences:57]Pontis_DatabaseName_txt:16; *)
			ARRAY TO SELECTION:C261(v_57_017_atxt; [Preferences:57]Pontis_ODBCName_txt:17; *)
			ARRAY TO SELECTION:C261(v_57_002_aL; [Preferences:57]Transfer Type:2; v_57_008_aL; [Preferences:57]LastRefID_L:8; *)
			ARRAY TO SELECTION:C261(v_57_007_ad; [Preferences:57]dbDate:7; v_57_018_ad; [Preferences:57]Pontis_LastUpdate_d:18; *)
			ARRAY TO SELECTION:C261(v_57_005_ab; [Preferences:57]ManualCon:5; v_57_006_ab; [Preferences:57]ShowPrintDialog:6; v_57_011_ab; [Preferences:57]LockUserTx:11; *)
			ARRAY TO SELECTION:C261(v_57_013_ab; [Preferences:57]AllowTxRx:13)
		End if 
	: ($1=58)  //Error Codes
		$Array_Ptr:=->v_58_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_58_005_atxt; [Error Codes:58]Error_Codes_UUIDKey_s:5; *)  //Error_Codes_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_58_001_atxt; [Error Codes:58]Err Group Name:1; v_58_003_atxt; [Error Codes:58]Err Description:3; v_58_004_atxt; [Error Codes:58]Err Level:4; *)
			ARRAY TO SELECTION:C261(v_58_002_ai; [Error Codes:58]Err Bit:2)
		End if 
	: ($1=59)  //Activity Log
		$Array_Ptr:=->v_59_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_59_029_atxt; [Activity Log:59]Activity_Log_UUIDKey_s:29; *)  //Activity_Log_UUIDKey_s
			End if 
			If (clone_UseBlobArrays_B)
				ARRAY TO SELECTION:C261(v_59_010_ablb; [Activity Log:59]Data:10; v_59_027_ablb; [Activity Log:59]Old Data:27; *)
			Else 
				clone_GetBlobs($1)
			End if 
			ARRAY TO SELECTION:C261(v_59_028_aL; [Activity Log:59]RefID:28; *)
			
			ARRAY TO SELECTION:C261(v_59_001_atxt; [Activity Log:59]Destination:1; *)
			ARRAY TO SELECTION:C261(v_59_002_atxt; [Activity Log:59]Source:2; v_59_003_atxt; [Activity Log:59]Activity Type:3; v_59_004_atxt; [Activity Log:59]User Name:4; *)
			ARRAY TO SELECTION:C261(v_59_013_atxt; [Activity Log:59]Forward:13; v_59_014_atxt; [Activity Log:59]Parent ID:14; v_59_015_atxt; [Activity Log:59]Local ID:15; *)
			ARRAY TO SELECTION:C261(v_59_016_atxt; [Activity Log:59]Dest ID parent:16; v_59_019_atxt; [Activity Log:59]Dest ID local:19; v_59_020_atxt; [Activity Log:59]ActField Name:20; *)
			ARRAY TO SELECTION:C261(v_59_021_atxt; [Activity Log:59]FinalDestination:21; *)
			ARRAY TO SELECTION:C261(v_59_026_ai; [Activity Log:59]RefIDType:26; *)
			ARRAY TO SELECTION:C261(v_59_007_aL; [Activity Log:59]File Number:7; v_59_008_aL; [Activity Log:59]Field Number:8; v_59_009_aL; [Activity Log:59]Status:9; *)
			ARRAY TO SELECTION:C261(v_59_011_aL; [Activity Log:59]Data Type:11; v_59_012_aL; [Activity Log:59]Transfer:12; v_59_017_aL; [Activity Log:59]Type Parent:17; *)
			ARRAY TO SELECTION:C261(v_59_018_aL; [Activity Log:59]Local Type:18; v_59_022_aL; [Activity Log:59]FileID Parent:22; v_59_023_aL; [Activity Log:59]FieldID Parent:23; *)
			ARRAY TO SELECTION:C261(v_59_024_aL; [Activity Log:59]FileID Local:24; v_59_025_aL; [Activity Log:59]FieldID Local:25; *)
			ARRAY TO SELECTION:C261(v_59_005_ad; [Activity Log:59]dDate:5; *)
			ARRAY TO SELECTION:C261(v_59_006_atm; [Activity Log:59]tTime:6)
		End if 
	: ($1=60)  //FileIDRes Table
		$Array_Ptr:=->v_60_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_60_005_atxt; [FileIDRes Table:60]FileIDRes_Table_UUIDKey_s:5; *)  //FileIDRes_Table_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_60_002_atxt; [FileIDRes Table:60]Local ID:2; v_60_003_atxt; [FileIDRes Table:60]Destination ID:3; v_60_004_atxt; [FileIDRes Table:60]Destination:4; *)
			ARRAY TO SELECTION:C261(v_60_001_aL; [FileIDRes Table:60]File Number:1)
		End if 
	: ($1=61)  //PostingStatus
		$Array_Ptr:=->v_61_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_61_003_atxt; [PostingStatus:61]PostingStatus_UUIDKey_s:3; *)  //PostingStatus_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_61_001_atxt; [PostingStatus:61]Code:1; v_61_002_atxt; [PostingStatus:61]Description:2)
		End if 
	: ($1=62)  //Owners of Data
		$Array_Ptr:=->v_62_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_62_003_atxt; [Owners of Data:62]Owners_of_Data_UUIDKey_s:3; *)  //Owners_of_Data_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_62_002_atxt; [Owners of Data:62]Owner Name:2; *)
			ARRAY TO SELECTION:C261(v_62_001_aL; [Owners of Data:62]RefID:1)
		End if 
	: ($1=63)  //Conslt Rating
		$Array_Ptr:=->v_63_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_63_077_atxt; [Conslt Rating:63]Conslt_Rating_UUIDKey_s:77; *)  //Conslt_Rating_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_63_042_aL; [Conslt Rating:63]ConsltRatingID:42; *)
			
			ARRAY TO SELECTION:C261(v_63_001_atxt; [Conslt Rating:63]BIN:1; v_63_003_atxt; [Conslt Rating:63]PriorityColorFlag:3; v_63_005_atxt; [Conslt Rating:63]AssignRatCons:5; *)
			ARRAY TO SELECTION:C261(v_63_008_atxt; [Conslt Rating:63]ReviewRtgWho1:8; v_63_013_atxt; [Conslt Rating:63]RemarksRat:13; v_63_014_atxt; [Conslt Rating:63]ContractNoRat:14; *)
			ARRAY TO SELECTION:C261(v_63_016_atxt; [Conslt Rating:63]Disposition1:16; v_63_027_atxt; [Conslt Rating:63]ProjManager:27; v_63_039_atxt; [Conslt Rating:63]CRtgStatus:39; *)
			ARRAY TO SELECTION:C261(v_63_043_atxt; [Conslt Rating:63]AssignStatus:43; v_63_044_atxt; [Conslt Rating:63]Priority:44; v_63_045_atxt; [Conslt Rating:63]CRtgLevel:45; *)
			ARRAY TO SELECTION:C261(v_63_046_atxt; [Conslt Rating:63]CRtgColor:46; v_63_047_atxt; [Conslt Rating:63]CRtgSource:47; v_63_048_atxt; [Conslt Rating:63]ContractType:48; *)
			ARRAY TO SELECTION:C261(v_63_051_atxt; [Conslt Rating:63]AssignPhase:51; v_63_054_atxt; [Conslt Rating:63]ReviewRtgWho2:54; v_63_055_atxt; [Conslt Rating:63]ReviewRtgWho3:55; *)
			ARRAY TO SELECTION:C261(v_63_056_atxt; [Conslt Rating:63]ReviewRtgWho4:56; v_63_059_atxt; [Conslt Rating:63]Disposition2:59; v_63_060_atxt; [Conslt Rating:63]Disposition3:60; *)
			ARRAY TO SELECTION:C261(v_63_061_atxt; [Conslt Rating:63]Disposition4:61; v_63_063_atxt; [Conslt Rating:63]BridgeType:63; v_63_069_atxt; [Conslt Rating:63]ReportPreparedBy:69; *)
			ARRAY TO SELECTION:C261(v_63_070_atxt; [Conslt Rating:63]IsRtgHere:70; v_63_076_atxt; [Conslt Rating:63]NBISLetterPostStatus_s:76; *)
			ARRAY TO SELECTION:C261(v_63_015_ar; [Conslt Rating:63]ConsltScore:15; *)
			ARRAY TO SELECTION:C261(v_63_012_ai; [Conslt Rating:63]AssignNoRat:12; *)
			ARRAY TO SELECTION:C261(v_63_002_ad; [Conslt Rating:63]FirstExpctSubmDate:2; v_63_004_ad; [Conslt Rating:63]AssignRtgDate1:4; v_63_006_ad; [Conslt Rating:63]AssignRtgDate2:6; *)
			ARRAY TO SELECTION:C261(v_63_007_ad; [Conslt Rating:63]AssignRtgDate3:7; v_63_009_ad; [Conslt Rating:63]ApprovedRat:9; v_63_010_ad; [Conslt Rating:63]ProceedRat:10; *)
			ARRAY TO SELECTION:C261(v_63_011_ad; [Conslt Rating:63]AssignRtgDate4:11; v_63_017_ad; [Conslt Rating:63]BoardApproval:17; v_63_018_ad; [Conslt Rating:63]CmntsRecvd1:18; *)
			ARRAY TO SELECTION:C261(v_63_019_ad; [Conslt Rating:63]CmntsRecvd2:19; v_63_020_ad; [Conslt Rating:63]DateReqbyBIE:20; v_63_021_ad; [Conslt Rating:63]DateReqbyDistrictBIE:21; *)
			ARRAY TO SELECTION:C261(v_63_022_ad; [Conslt Rating:63]FeeProposalRecvd:22; v_63_023_ad; [Conslt Rating:63]RepSubmit1:23; v_63_024_ad; [Conslt Rating:63]ApprovedRtgToAreaEngr:24; *)
			ARRAY TO SELECTION:C261(v_63_025_ad; [Conslt Rating:63]LetterToDistrict:25; v_63_026_ad; [Conslt Rating:63]NBISLetter:26; v_63_030_ad; [Conslt Rating:63]ReqFeeProposal:30; *)
			ARRAY TO SELECTION:C261(v_63_031_ad; [Conslt Rating:63]RepSubmit2:31; v_63_032_ad; [Conslt Rating:63]LetterToCityTown:32; v_63_033_ad; [Conslt Rating:63]SentBackToConslt1:33; *)
			ARRAY TO SELECTION:C261(v_63_034_ad; [Conslt Rating:63]SentBackToConslt2:34; v_63_035_ad; [Conslt Rating:63]SentBackToConslt3:35; v_63_036_ad; [Conslt Rating:63]SentInHouseRev1:36; *)
			ARRAY TO SELECTION:C261(v_63_037_ad; [Conslt Rating:63]SentInHouseRev2:37; v_63_038_ad; [Conslt Rating:63]SentInHouseRev3:38; v_63_041_ad; [Conslt Rating:63]RepSubmit3:41; *)
			ARRAY TO SELECTION:C261(v_63_049_ad; [Conslt Rating:63]MostRecentSub:49; v_63_050_ad; [Conslt Rating:63]NTPdate_verbal:50; v_63_052_ad; [Conslt Rating:63]RepSubmit4:52; *)
			ARRAY TO SELECTION:C261(v_63_053_ad; [Conslt Rating:63]SentInHouseRev4:53; v_63_057_ad; [Conslt Rating:63]CmntsRecvd3:57; v_63_058_ad; [Conslt Rating:63]CmntsRecvd4:58; *)
			ARRAY TO SELECTION:C261(v_63_062_ad; [Conslt Rating:63]SentBackToConslt4:62; v_63_064_ad; [Conslt Rating:63]ReportDate:64; v_63_065_ad; [Conslt Rating:63]SentBackToBIE1:65; *)
			ARRAY TO SELECTION:C261(v_63_066_ad; [Conslt Rating:63]SentBackToBIE2:66; v_63_067_ad; [Conslt Rating:63]SentBackToBIE3:67; v_63_068_ad; [Conslt Rating:63]SentBackToBIE4:68; *)
			ARRAY TO SELECTION:C261(v_63_071_ad; [Conslt Rating:63]RecentAction:71; v_63_072_ad; [Conslt Rating:63]DateReceivedByROUnit1:72; v_63_073_ad; [Conslt Rating:63]DateReceivedByROUnit2:73; *)
			ARRAY TO SELECTION:C261(v_63_074_ad; [Conslt Rating:63]DateReceivedByROUnit3:74; v_63_075_ad; [Conslt Rating:63]DateReceivedByROUnit4:75; *)
			ARRAY TO SELECTION:C261(v_63_028_ab; [Conslt Rating:63]Rate:28; v_63_029_ab; [Conslt Rating:63]Re_Rate:29; v_63_040_ab; [Conslt Rating:63]StrReport:40)
		End if 
	: ($1=64)  //Cons Inspection
		$Array_Ptr:=->v_64_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_64_039_atxt; [Cons Inspection:64]Cons_Inspection_UUIDKey_s:39; *)  //Cons_Inspection_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_64_032_aL; [Cons Inspection:64]ConsInspectionID:32; *)
			
			ARRAY TO SELECTION:C261(v_64_001_atxt; [Cons Inspection:64]BIN:1; v_64_003_atxt; [Cons Inspection:64]RequestConWho:3; v_64_005_atxt; [Cons Inspection:64]AssignConName:5; *)
			ARRAY TO SELECTION:C261(v_64_007_atxt; [Cons Inspection:64]ConContractNo:7; v_64_010_atxt; [Cons Inspection:64]ConInspRemarks:10; v_64_024_atxt; [Cons Inspection:64]AssignStatus:24; *)
			ARRAY TO SELECTION:C261(v_64_026_atxt; [Cons Inspection:64]ProjManager:26; v_64_028_atxt; [Cons Inspection:64]InspectionDate:28; v_64_033_atxt; [Cons Inspection:64]InspType:33; *)
			ARRAY TO SELECTION:C261(v_64_036_atxt; [Cons Inspection:64]ContractType:36; v_64_038_atxt; [Cons Inspection:64]AssignPhase:38; *)
			ARRAY TO SELECTION:C261(v_64_013_ar; [Cons Inspection:64]QC Eng HR Est:13; v_64_014_ar; [Cons Inspection:64]TeamLdr HR Est:14; v_64_015_ar; [Cons Inspection:64]TeamMbr HR Est:15; *)
			ARRAY TO SELECTION:C261(v_64_016_ar; [Cons Inspection:64]PE HR Act:16; v_64_017_ar; [Cons Inspection:64]QC Eng HR Act:17; v_64_018_ar; [Cons Inspection:64]TeamLdr HR Act:18; *)
			ARRAY TO SELECTION:C261(v_64_019_ar; [Cons Inspection:64]TeamMbr HR Act:19; v_64_020_ar; [Cons Inspection:64]Direct Expenses:20; v_64_021_ar; [Cons Inspection:64]AvgHourlyRate:21; *)
			ARRAY TO SELECTION:C261(v_64_030_ar; [Cons Inspection:64]ConsltScore:30; *)
			ARRAY TO SELECTION:C261(v_64_006_ai; [Cons Inspection:64]AssignConNumber:6; v_64_011_ai; [Cons Inspection:64]InspCategory:11; *)
			ARRAY TO SELECTION:C261(v_64_002_ad; [Cons Inspection:64]RequestConDate:2; v_64_004_ad; [Cons Inspection:64]AssignConDate:4; v_64_008_ad; [Cons Inspection:64]ProceedConDate:8; *)
			ARRAY TO SELECTION:C261(v_64_009_ad; [Cons Inspection:64]CompleteConDate:9; v_64_022_ad; [Cons Inspection:64]ReqByDBIE:22; v_64_023_ad; [Cons Inspection:64]ReqByBIE:23; *)
			ARRAY TO SELECTION:C261(v_64_025_ad; [Cons Inspection:64]ReqFeeProposal:25; v_64_027_ad; [Cons Inspection:64]FeeProposalRecvd:27; v_64_029_ad; [Cons Inspection:64]InspectionRecvd:29; *)
			ARRAY TO SELECTION:C261(v_64_031_ad; [Cons Inspection:64]ReportToDBIE:31; v_64_034_ad; [Cons Inspection:64]InspMonth:34; v_64_035_ad; [Cons Inspection:64]NTPdate_verbal:35; *)
			ARRAY TO SELECTION:C261(v_64_037_ad; [Cons Inspection:64]InspRecvd_ME:37; *)
			ARRAY TO SELECTION:C261(v_64_012_ab; [Cons Inspection:64]LoadRatingInfo:12)
		End if 
	: ($1=65)  //RatingReports
		$Array_Ptr:=->v_65_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_65_035_atxt; [RatingReports:65]RatingReports_UUIDKey_s:35; *)  //RatingReports_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_65_021_aL; [RatingReports:65]RatingID:21; *)
			
			ARRAY TO SELECTION:C261(v_65_001_atxt; [RatingReports:65]BIN:1; v_65_005_atxt; [RatingReports:65]Consultant:5; v_65_017_atxt; [RatingReports:65]Item43inRating:17; *)
			ARRAY TO SELECTION:C261(v_65_018_atxt; [RatingReports:65]Item58:18; v_65_019_atxt; [RatingReports:65]Item59:19; v_65_020_atxt; [RatingReports:65]RatingInfo:20; *)
			ARRAY TO SELECTION:C261(v_65_028_atxt; [RatingReports:65]Item63:28; v_65_030_atxt; [RatingReports:65]Item65:30; v_65_032_atxt; [RatingReports:65]DataFileType:32; *)
			ARRAY TO SELECTION:C261(v_65_006_ar; [RatingReports:65]InvH20:6; v_65_007_ar; [RatingReports:65]InvType3:7; v_65_008_ar; [RatingReports:65]Inv3S2:8; *)
			ARRAY TO SELECTION:C261(v_65_009_ar; [RatingReports:65]InvHS2044:9; v_65_010_ar; [RatingReports:65]OprH20:10; v_65_011_ar; [RatingReports:65]OprType3:11; *)
			ARRAY TO SELECTION:C261(v_65_012_ar; [RatingReports:65]Opr3S2:12; v_65_013_ar; [RatingReports:65]OprHS2044:13; v_65_022_ar; [RatingReports:65]InvMS18:22; *)
			ARRAY TO SELECTION:C261(v_65_023_ar; [RatingReports:65]OprMS18:23; v_65_029_ar; [RatingReports:65]Item64:29; v_65_031_ar; [RatingReports:65]Item66:31; *)
			ARRAY TO SELECTION:C261(v_65_014_ai; [RatingReports:65]RecPostingH:14; v_65_015_ai; [RatingReports:65]RecPost3:15; v_65_016_ai; [RatingReports:65]RecPost3S2:16; *)
			ARRAY TO SELECTION:C261(v_65_039_aL; [RatingReports:65]RecSinglePosting_L:39; *)
			ARRAY TO SELECTION:C261(v_65_004_ad; [RatingReports:65]ReportDate:4; v_65_036_ad; [RatingReports:65]NBIS_Letter_d:36; *)
			ARRAY TO SELECTION:C261(v_65_002_ab; [RatingReports:65]RatingReport:2; v_65_003_ab; [RatingReports:65]EngrJudgment:3; v_65_024_ab; [RatingReports:65]NoPosting:24; *)
			ARRAY TO SELECTION:C261(v_65_025_ab; [RatingReports:65]BridgeClosed:25; v_65_026_ab; [RatingReports:65]PostingWaived:26; v_65_027_ab; [RatingReports:65]DataFile:27; *)
			ARRAY TO SELECTION:C261(v_65_033_ab; [RatingReports:65]StructRpt:33; v_65_034_ab; [RatingReports:65]RemainPosted:34; v_65_037_ab; [RatingReports:65]WithRestrictions_b:37; *)
			ARRAY TO SELECTION:C261(v_65_038_ab; [RatingReports:65]WithPedestrianAccess_b:38; v_65_040_ab; [RatingReports:65]ScannedStored:40)
		End if 
	: ($1=66)  //RatingMember
		$Array_Ptr:=->v_66_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_66_018_atxt; [RatingMember:66]RatingMember_UUIDKey_s:18; *)  //RatingMember_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_66_002_atxt; [RatingMember:66]SpanType:2; v_66_003_atxt; [RatingMember:66]MemberType:3; v_66_004_atxt; [RatingMember:66]Description:4; *)
			ARRAY TO SELECTION:C261(v_66_005_ar; [RatingMember:66]SpanLength:5; v_66_006_ar; [RatingMember:66]LocationCM:6; v_66_007_ar; [RatingMember:66]InvH20:7; *)
			ARRAY TO SELECTION:C261(v_66_008_ar; [RatingMember:66]InvType3:8; v_66_009_ar; [RatingMember:66]Inv3S2:9; v_66_010_ar; [RatingMember:66]InvHS2044:10; *)
			ARRAY TO SELECTION:C261(v_66_011_ar; [RatingMember:66]OprH20:11; v_66_012_ar; [RatingMember:66]OprType3:12; v_66_013_ar; [RatingMember:66]Opr3S2:13; *)
			ARRAY TO SELECTION:C261(v_66_014_ar; [RatingMember:66]OprHS2044:14; v_66_015_ar; [RatingMember:66]FloorBeamSp:15; v_66_016_ar; [RatingMember:66]InvMS18:16; *)
			ARRAY TO SELECTION:C261(v_66_017_ar; [RatingMember:66]OprMS18:17; *)
			ARRAY TO SELECTION:C261(v_66_001_aL; [RatingMember:66]RatingID:1)
		End if 
	: ($1=67)  //Rating Method
		$Array_Ptr:=->v_67_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_67_003_atxt; [Rating Method:67]Rating_Method_UUIDKey_s:3; *)  //Rating_Method_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_67_001_atxt; [Rating Method:67]Code:1; v_67_002_atxt; [Rating Method:67]Description:2)
		End if 
	: ($1=68)  //zDialogs
		$Array_Ptr:=->v_68_001_ab
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_68_002_atxt; [zDialogs:68]zDialogs_UUIDKey_s:2; *)  //zDialogs_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_68_001_ab; [zDialogs:68]Reserved:1)
		End if 
	: ($1=69)  //Status Report
		$Array_Ptr:=->v_69_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_69_264_atxt; [Status Report:69]Status_Report_UUIDKey_s:264; *)  //Status_Report_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_69_002_atxt; [Status Report:69]Owner:2; v_69_135_atxt; [Status Report:69]Comments:135; *)
			ARRAY TO SELECTION:C261(v_69_122_ar; [Status Report:69]S_58:122; v_69_123_ar; [Status Report:69]S_59:123; v_69_124_ar; [Status Report:69]S_60:124; *)
			ARRAY TO SELECTION:C261(v_69_125_ar; [Status Report:69]T_58:125; v_69_126_ar; [Status Report:69]T_59:126; v_69_127_ar; [Status Report:69]T_60:127; *)
			ARRAY TO SELECTION:C261(v_69_128_ar; [Status Report:69]ST_58:128; v_69_129_ar; [Status Report:69]ST_59:129; v_69_130_ar; [Status Report:69]ST_60:130; *)
			ARRAY TO SELECTION:C261(v_69_131_ar; [Status Report:69]A_58:131; v_69_132_ar; [Status Report:69]A_59:132; v_69_133_ar; [Status Report:69]A_60:133; *)
			ARRAY TO SELECTION:C261(v_69_136_ar; [Status Report:69]S_D1_HI:136; v_69_137_ar; [Status Report:69]S_D2_HI:137; v_69_138_ar; [Status Report:69]S_D3_HI:138; *)
			ARRAY TO SELECTION:C261(v_69_139_ar; [Status Report:69]S_D4_HI:139; v_69_140_ar; [Status Report:69]S_D5_HI:140; v_69_141_ar; [Status Report:69]S_Tot_HI:141; *)
			ARRAY TO SELECTION:C261(v_69_142_ar; [Status Report:69]T_D1_HI:142; v_69_143_ar; [Status Report:69]T_D2_HI:143; v_69_144_ar; [Status Report:69]T_D3_HI:144; *)
			ARRAY TO SELECTION:C261(v_69_145_ar; [Status Report:69]T_D4_HI:145; v_69_146_ar; [Status Report:69]T_D5_HI:146; v_69_147_ar; [Status Report:69]T_Tot_HI:147; *)
			ARRAY TO SELECTION:C261(v_69_148_ar; [Status Report:69]S_T_D1_HI:148; v_69_149_ar; [Status Report:69]S_T_D2_HI:149; v_69_150_ar; [Status Report:69]S_T_D3_HI:150; *)
			ARRAY TO SELECTION:C261(v_69_151_ar; [Status Report:69]S_T_D4_HI:151; v_69_152_ar; [Status Report:69]S_T_D5_HI:152; v_69_153_ar; [Status Report:69]S_T_Tot_HI:153; *)
			ARRAY TO SELECTION:C261(v_69_154_ar; [Status Report:69]MBTA_HI:154; v_69_155_ar; [Status Report:69]MDC_HI:155; v_69_156_ar; [Status Report:69]MTA_HI:156; *)
			ARRAY TO SELECTION:C261(v_69_157_ar; [Status Report:69]MPA_HI:157; v_69_158_ar; [Status Report:69]DEM_HI:158; v_69_159_ar; [Status Report:69]OTHER_HI:159; *)
			ARRAY TO SELECTION:C261(v_69_160_ar; [Status Report:69]ALLBR_HI:160; v_69_161_ar; [Status Report:69]INT_D1_HI:161; v_69_162_ar; [Status Report:69]INT_D2_HI:162; *)
			ARRAY TO SELECTION:C261(v_69_163_ar; [Status Report:69]INT_D3_HI:163; v_69_164_ar; [Status Report:69]INT_D4_HI:164; v_69_165_ar; [Status Report:69]INT_D5_HI:165; *)
			ARRAY TO SELECTION:C261(v_69_166_ar; [Status Report:69]INT_Tot_HI:166; v_69_167_ar; [Status Report:69]SU_D1_HI:167; v_69_168_ar; [Status Report:69]SU_D2_HI:168; *)
			ARRAY TO SELECTION:C261(v_69_169_ar; [Status Report:69]SU_D3_HI:169; v_69_170_ar; [Status Report:69]SU_D4_HI:170; v_69_171_ar; [Status Report:69]SU_D5_HI:171; *)
			ARRAY TO SELECTION:C261(v_69_172_ar; [Status Report:69]SU_Tot_HI:172; v_69_173_ar; [Status Report:69]Loc_D1_HI:173; v_69_174_ar; [Status Report:69]Loc_D2_HI:174; *)
			ARRAY TO SELECTION:C261(v_69_175_ar; [Status Report:69]Loc_D3_HI:175; v_69_176_ar; [Status Report:69]Loc_D4_HI:176; v_69_177_ar; [Status Report:69]Loc_D5_HI:177; *)
			ARRAY TO SELECTION:C261(v_69_178_ar; [Status Report:69]Loc_Tot_HI:178; v_69_179_ar; [Status Report:69]INT_D6_HI:179; v_69_180_ar; [Status Report:69]LOC_D6_HI:180; *)
			ARRAY TO SELECTION:C261(v_69_181_ar; [Status Report:69]S_T_D6_HI:181; v_69_182_ar; [Status Report:69]SU_D6_HI:182; v_69_183_ar; [Status Report:69]S_D6_HI:183; *)
			ARRAY TO SELECTION:C261(v_69_184_ar; [Status Report:69]T_D6_HI:184; v_69_192_ar; [Status Report:69]S_D1_Area:192; v_69_193_ar; [Status Report:69]S_D1_SD_Area:193; *)
			ARRAY TO SELECTION:C261(v_69_194_ar; [Status Report:69]S_D1_NHS_Area:194; v_69_195_ar; [Status Report:69]S_D1_NHS_SD_Area:195; v_69_196_ar; [Status Report:69]S_D2_Area:196; *)
			ARRAY TO SELECTION:C261(v_69_197_ar; [Status Report:69]S_D2_SD_Area:197; v_69_198_ar; [Status Report:69]S_D2_NHS_Area:198; v_69_199_ar; [Status Report:69]S_D2_NHS_SD_Area:199; *)
			ARRAY TO SELECTION:C261(v_69_200_ar; [Status Report:69]S_D3_Area:200; v_69_201_ar; [Status Report:69]S_D3_SD_Area:201; v_69_202_ar; [Status Report:69]S_D3_NHS_Area:202; *)
			ARRAY TO SELECTION:C261(v_69_203_ar; [Status Report:69]S_D3_NHS_SD_Area:203; v_69_204_ar; [Status Report:69]S_D4_Area:204; v_69_205_ar; [Status Report:69]S_D4_SD_Area:205; *)
			ARRAY TO SELECTION:C261(v_69_206_ar; [Status Report:69]S_D4_NHS_Area:206; v_69_207_ar; [Status Report:69]S_D4_NHS_SD_Area:207; v_69_208_ar; [Status Report:69]S_D5_Area:208; *)
			ARRAY TO SELECTION:C261(v_69_209_ar; [Status Report:69]S_D5_SD_Area:209; v_69_210_ar; [Status Report:69]S_D5_NHS_Area:210; v_69_211_ar; [Status Report:69]S_D5_NHS_SD_Area:211; *)
			ARRAY TO SELECTION:C261(v_69_212_ar; [Status Report:69]S_D6_Area:212; v_69_213_ar; [Status Report:69]S_D6_SD_Area:213; v_69_214_ar; [Status Report:69]S_D6_NHS_Area:214; *)
			ARRAY TO SELECTION:C261(v_69_215_ar; [Status Report:69]S_D6_NHS_SD_Area:215; v_69_216_ar; [Status Report:69]T_D1_Area:216; v_69_217_ar; [Status Report:69]T_D1_SD_Area:217; *)
			ARRAY TO SELECTION:C261(v_69_218_ar; [Status Report:69]T_D1_NHS_Area:218; v_69_219_ar; [Status Report:69]T_D1_NHS_SD_Area:219; v_69_220_ar; [Status Report:69]T_D2_Area:220; *)
			ARRAY TO SELECTION:C261(v_69_221_ar; [Status Report:69]T_D2_SD_Area:221; v_69_222_ar; [Status Report:69]T_D2_NHS_Area:222; v_69_223_ar; [Status Report:69]T_D2_NHS_SD_Area:223; *)
			ARRAY TO SELECTION:C261(v_69_224_ar; [Status Report:69]T_D3_Area:224; v_69_225_ar; [Status Report:69]T_D3_SD_Area:225; v_69_226_ar; [Status Report:69]T_D3_NHS_Area:226; *)
			ARRAY TO SELECTION:C261(v_69_227_ar; [Status Report:69]T_D3_NHS_SD_Area:227; v_69_228_ar; [Status Report:69]T_D4_Area:228; v_69_229_ar; [Status Report:69]T_D4_SD_Area:229; *)
			ARRAY TO SELECTION:C261(v_69_230_ar; [Status Report:69]T_D4_NHS_Area:230; v_69_231_ar; [Status Report:69]T_D4_NHS_SD_Area:231; v_69_232_ar; [Status Report:69]T_D5_Area:232; *)
			ARRAY TO SELECTION:C261(v_69_233_ar; [Status Report:69]T_D5_SD_Area:233; v_69_234_ar; [Status Report:69]T_D5_NHS_Area:234; v_69_235_ar; [Status Report:69]T_D5_NHS_SD_Area:235; *)
			ARRAY TO SELECTION:C261(v_69_236_ar; [Status Report:69]T_D6_Area:236; v_69_237_ar; [Status Report:69]T_D6_SD_Area:237; v_69_238_ar; [Status Report:69]T_D6_NHS_Area:238; *)
			ARRAY TO SELECTION:C261(v_69_239_ar; [Status Report:69]T_D6_NHS_SD_Area:239; v_69_240_ar; [Status Report:69]MDC_Area:240; v_69_241_ar; [Status Report:69]MDC_SD_Area:241; *)
			ARRAY TO SELECTION:C261(v_69_242_ar; [Status Report:69]MDC_NHS_Area:242; v_69_243_ar; [Status Report:69]MDC_NHS_SD_Area:243; v_69_244_ar; [Status Report:69]DEM_Area:244; *)
			ARRAY TO SELECTION:C261(v_69_245_ar; [Status Report:69]DEM_SD_Area:245; v_69_246_ar; [Status Report:69]DEM_NHS_Area:246; v_69_247_ar; [Status Report:69]DEM_NHS_SD_Area:247; *)
			ARRAY TO SELECTION:C261(v_69_248_ar; [Status Report:69]MBTA_Area:248; v_69_249_ar; [Status Report:69]MBTA_SD_Area:249; v_69_250_ar; [Status Report:69]MBTA_NHS_Area:250; *)
			ARRAY TO SELECTION:C261(v_69_251_ar; [Status Report:69]MBTA_NHS_SD_Area:251; v_69_252_ar; [Status Report:69]MTA_Area:252; v_69_253_ar; [Status Report:69]MTA_SD_Area:253; *)
			ARRAY TO SELECTION:C261(v_69_254_ar; [Status Report:69]MTA_NHS_Area:254; v_69_255_ar; [Status Report:69]MTA_NHS_SD_Area:255; v_69_256_ar; [Status Report:69]MPA_Area:256; *)
			ARRAY TO SELECTION:C261(v_69_257_ar; [Status Report:69]MPA_SD_Area:257; v_69_258_ar; [Status Report:69]MPA_NHS_Area:258; v_69_259_ar; [Status Report:69]MPA_NHS_SD_Area:259; *)
			ARRAY TO SELECTION:C261(v_69_260_ar; [Status Report:69]DNR_Area:260; v_69_261_ar; [Status Report:69]DNR_SD_Area:261; v_69_262_ar; [Status Report:69]DNR_NHS_Area:262; *)
			ARRAY TO SELECTION:C261(v_69_263_ar; [Status Report:69]DNR_NHS_SD_Area:263; *)
			ARRAY TO SELECTION:C261(v_69_003_ai; [Status Report:69]S_D1total:3; v_69_004_ai; [Status Report:69]S_D2total:4; v_69_005_ai; [Status Report:69]S_D3total:5; *)
			ARRAY TO SELECTION:C261(v_69_006_ai; [Status Report:69]S_D4total:6; v_69_007_ai; [Status Report:69]S_D5total:7; v_69_008_ai; [Status Report:69]T_D1total:8; *)
			ARRAY TO SELECTION:C261(v_69_009_ai; [Status Report:69]T_D2total:9; v_69_010_ai; [Status Report:69]T_D3total:10; v_69_011_ai; [Status Report:69]T_D4total:11; *)
			ARRAY TO SELECTION:C261(v_69_012_ai; [Status Report:69]T_D5total:12; v_69_013_ai; [Status Report:69]MBTA_total:13; v_69_014_ai; [Status Report:69]MDC_total:14; *)
			ARRAY TO SELECTION:C261(v_69_015_ai; [Status Report:69]MTA_total:15; v_69_016_ai; [Status Report:69]MPA_total:16; v_69_017_ai; [Status Report:69]DEM_total:17; *)
			ARRAY TO SELECTION:C261(v_69_018_ai; [Status Report:69]DNR_total:18; v_69_019_ai; [Status Report:69]S_D6total:19; v_69_020_ai; [Status Report:69]S_D1sd:20; *)
			ARRAY TO SELECTION:C261(v_69_021_ai; [Status Report:69]S_D2sd:21; v_69_022_ai; [Status Report:69]S_D3sd:22; v_69_023_ai; [Status Report:69]S_D4sd:23; *)
			ARRAY TO SELECTION:C261(v_69_024_ai; [Status Report:69]S_D5sd:24; v_69_025_ai; [Status Report:69]T_D1sd:25; v_69_026_ai; [Status Report:69]T_D2sd:26; *)
			ARRAY TO SELECTION:C261(v_69_027_ai; [Status Report:69]T_D3sd:27; v_69_028_ai; [Status Report:69]T_D4sd:28; v_69_029_ai; [Status Report:69]T_D5sd:29; *)
			ARRAY TO SELECTION:C261(v_69_030_ai; [Status Report:69]MBTA_sd:30; v_69_031_ai; [Status Report:69]MDC_sd:31; v_69_032_ai; [Status Report:69]MTA_sd:32; *)
			ARRAY TO SELECTION:C261(v_69_033_ai; [Status Report:69]MPA_sd:33; v_69_034_ai; [Status Report:69]DEM_sd:34; v_69_035_ai; [Status Report:69]DNR_sd:35; *)
			ARRAY TO SELECTION:C261(v_69_036_ai; [Status Report:69]S_D6sd:36; v_69_037_ai; [Status Report:69]S_D1fo:37; v_69_038_ai; [Status Report:69]S_D2fo:38; *)
			ARRAY TO SELECTION:C261(v_69_039_ai; [Status Report:69]S_D3fo:39; v_69_040_ai; [Status Report:69]S_D4fo:40; v_69_041_ai; [Status Report:69]S_D5fo:41; *)
			ARRAY TO SELECTION:C261(v_69_042_ai; [Status Report:69]T_D1fo:42; v_69_043_ai; [Status Report:69]T_D2fo:43; v_69_044_ai; [Status Report:69]T_D3fo:44; *)
			ARRAY TO SELECTION:C261(v_69_045_ai; [Status Report:69]T_D4fo:45; v_69_046_ai; [Status Report:69]T_D5fo:46; v_69_047_ai; [Status Report:69]MBTA_fo:47; *)
			ARRAY TO SELECTION:C261(v_69_048_ai; [Status Report:69]MDC_fo:48; v_69_049_ai; [Status Report:69]MTA_fo:49; v_69_050_ai; [Status Report:69]MPA_fo:50; *)
			ARRAY TO SELECTION:C261(v_69_051_ai; [Status Report:69]DEM_fo:51; v_69_052_ai; [Status Report:69]DNR_fo:52; v_69_053_ai; [Status Report:69]S_D6fo:53; *)
			ARRAY TO SELECTION:C261(v_69_054_ai; [Status Report:69]S_D1p:54; v_69_055_ai; [Status Report:69]S_D2p:55; v_69_056_ai; [Status Report:69]S_D3p:56; *)
			ARRAY TO SELECTION:C261(v_69_057_ai; [Status Report:69]S_D4p:57; v_69_058_ai; [Status Report:69]S_D5p:58; v_69_059_ai; [Status Report:69]T_D1p:59; *)
			ARRAY TO SELECTION:C261(v_69_060_ai; [Status Report:69]T_D2p:60; v_69_061_ai; [Status Report:69]T_D3p:61; v_69_062_ai; [Status Report:69]T_D4p:62; *)
			ARRAY TO SELECTION:C261(v_69_063_ai; [Status Report:69]T_D5p:63; v_69_064_ai; [Status Report:69]MBTA_p:64; v_69_065_ai; [Status Report:69]MDC_p:65; *)
			ARRAY TO SELECTION:C261(v_69_066_ai; [Status Report:69]MTA_p:66; v_69_067_ai; [Status Report:69]MPA_p:67; v_69_068_ai; [Status Report:69]DEM_p:68; *)
			ARRAY TO SELECTION:C261(v_69_069_ai; [Status Report:69]DNR_p:69; v_69_070_ai; [Status Report:69]S_D6p:70; v_69_071_ai; [Status Report:69]S_D1k:71; *)
			ARRAY TO SELECTION:C261(v_69_072_ai; [Status Report:69]S_D2k:72; v_69_073_ai; [Status Report:69]S_D3k:73; v_69_074_ai; [Status Report:69]S_D4k:74; *)
			ARRAY TO SELECTION:C261(v_69_075_ai; [Status Report:69]S_D5k:75; v_69_076_ai; [Status Report:69]T_D1k:76; v_69_077_ai; [Status Report:69]T_D2k:77; *)
			ARRAY TO SELECTION:C261(v_69_078_ai; [Status Report:69]T_D3k:78; v_69_079_ai; [Status Report:69]T_D4k:79; v_69_080_ai; [Status Report:69]T_D5k:80; *)
			ARRAY TO SELECTION:C261(v_69_081_ai; [Status Report:69]MBTA_k:81; v_69_082_ai; [Status Report:69]MDC_k:82; v_69_083_ai; [Status Report:69]MTA_k:83; *)
			ARRAY TO SELECTION:C261(v_69_084_ai; [Status Report:69]MPA_k:84; v_69_085_ai; [Status Report:69]DEM_k:85; v_69_086_ai; [Status Report:69]DNR_k:86; *)
			ARRAY TO SELECTION:C261(v_69_087_ai; [Status Report:69]S_D6k:87; v_69_088_ai; [Status Report:69]S_D1t:88; v_69_089_ai; [Status Report:69]S_D2t:89; *)
			ARRAY TO SELECTION:C261(v_69_090_ai; [Status Report:69]S_D3t:90; v_69_091_ai; [Status Report:69]S_D4t:91; v_69_092_ai; [Status Report:69]S_D5t:92; *)
			ARRAY TO SELECTION:C261(v_69_093_ai; [Status Report:69]T_D1t:93; v_69_094_ai; [Status Report:69]T_D2t:94; v_69_095_ai; [Status Report:69]T_D3t:95; *)
			ARRAY TO SELECTION:C261(v_69_096_ai; [Status Report:69]T_D4t:96; v_69_097_ai; [Status Report:69]T_D5t:97; v_69_098_ai; [Status Report:69]MBTA_t:98; *)
			ARRAY TO SELECTION:C261(v_69_099_ai; [Status Report:69]MDC_t:99; v_69_100_ai; [Status Report:69]MTA_t:100; v_69_101_ai; [Status Report:69]MPA_t:101; *)
			ARRAY TO SELECTION:C261(v_69_102_ai; [Status Report:69]DEM_t:102; v_69_103_ai; [Status Report:69]DNR_t:103; v_69_104_ai; [Status Report:69]S_D6t:104; *)
			ARRAY TO SELECTION:C261(v_69_105_ai; [Status Report:69]S_D1a50:105; v_69_106_ai; [Status Report:69]S_D2a50:106; v_69_107_ai; [Status Report:69]S_D3a50:107; *)
			ARRAY TO SELECTION:C261(v_69_108_ai; [Status Report:69]S_D4a50:108; v_69_109_ai; [Status Report:69]S_D5a50:109; v_69_110_ai; [Status Report:69]T_D1a50:110; *)
			ARRAY TO SELECTION:C261(v_69_111_ai; [Status Report:69]T_D2a50:111; v_69_112_ai; [Status Report:69]T_D3a50:112; v_69_113_ai; [Status Report:69]T_D4a50:113; *)
			ARRAY TO SELECTION:C261(v_69_114_ai; [Status Report:69]T_D5a50:114; v_69_115_ai; [Status Report:69]MBTA_a50:115; v_69_116_ai; [Status Report:69]MDC_a50:116; *)
			ARRAY TO SELECTION:C261(v_69_117_ai; [Status Report:69]MTA_a50:117; v_69_118_ai; [Status Report:69]MPA_a50:118; v_69_119_ai; [Status Report:69]DEM_a50:119; *)
			ARRAY TO SELECTION:C261(v_69_120_ai; [Status Report:69]DNR_a50:120; v_69_121_ai; [Status Report:69]S_D6a50:121; v_69_185_ai; [Status Report:69]T_D6a50:185; *)
			ARRAY TO SELECTION:C261(v_69_186_ai; [Status Report:69]T_D6fo:186; v_69_187_ai; [Status Report:69]T_D6k:187; v_69_188_ai; [Status Report:69]T_D6p:188; *)
			ARRAY TO SELECTION:C261(v_69_189_ai; [Status Report:69]T_D6sd:189; v_69_190_ai; [Status Report:69]T_D6t:190; v_69_191_ai; [Status Report:69]T_D6total:191; *)
			ARRAY TO SELECTION:C261(v_69_267_aL; [Status Report:69]DistrictMethod_L:267; *)
			ARRAY TO SELECTION:C261(v_69_001_ad; [Status Report:69]Date_Created:1; *)
			ARRAY TO SELECTION:C261(v_69_134_atm; [Status Report:69]Time_Created:134; *)
			ARRAY TO SELECTION:C261(v_69_265_ab; [Status Report:69]SD_Calc_New_b:265; v_69_266_ab; [Status Report:69]UseLegacyOwner_b:266)
		End if 
	: ($1=70)  //Out of Freq
		$Array_Ptr:=->v_70_003_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_70_065_atxt; [Out of Freq:70]Out_of_Freq_UUIDKey_s:65; *)  //Out_of_Freq_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_70_003_atxt; [Out of Freq:70]Owner:3; v_70_004_atxt; [Out of Freq:70]Comments:4; *)
			ARRAY TO SELECTION:C261(v_70_005_ai; [Out of Freq:70]D1_reqd:5; v_70_006_ai; [Out of Freq:70]D2_reqd:6; v_70_007_ai; [Out of Freq:70]D3_reqd:7; *)
			ARRAY TO SELECTION:C261(v_70_008_ai; [Out of Freq:70]D4_reqd:8; v_70_009_ai; [Out of Freq:70]D5_reqd:9; v_70_010_ai; [Out of Freq:70]MBTA_reqd:10; *)
			ARRAY TO SELECTION:C261(v_70_011_ai; [Out of Freq:70]MDC_reqd:11; v_70_012_ai; [Out of Freq:70]MTA_reqd:12; v_70_013_ai; [Out of Freq:70]MPA_reqd:13; *)
			ARRAY TO SELECTION:C261(v_70_014_ai; [Out of Freq:70]DEM_reqd:14; v_70_015_ai; [Out of Freq:70]DNR_reqd:15; v_70_016_ai; [Out of Freq:70]Dive_reqd:16; *)
			ARRAY TO SELECTION:C261(v_70_017_ai; [Out of Freq:70]D1_made:17; v_70_018_ai; [Out of Freq:70]D2_made:18; v_70_019_ai; [Out of Freq:70]D3_made:19; *)
			ARRAY TO SELECTION:C261(v_70_020_ai; [Out of Freq:70]D4_made:20; v_70_021_ai; [Out of Freq:70]D5_made:21; v_70_022_ai; [Out of Freq:70]MBTA_made:22; *)
			ARRAY TO SELECTION:C261(v_70_023_ai; [Out of Freq:70]MDC_made:23; v_70_024_ai; [Out of Freq:70]MTA_made:24; v_70_025_ai; [Out of Freq:70]MPA_made:25; *)
			ARRAY TO SELECTION:C261(v_70_026_ai; [Out of Freq:70]DEM_made:26; v_70_027_ai; [Out of Freq:70]DNR_made:27; v_70_028_ai; [Out of Freq:70]Dive_made:28; *)
			ARRAY TO SELECTION:C261(v_70_029_ai; [Out of Freq:70]D1_1ytd:29; v_70_030_ai; [Out of Freq:70]D2_1ytd:30; v_70_031_ai; [Out of Freq:70]D3_1ytd:31; *)
			ARRAY TO SELECTION:C261(v_70_032_ai; [Out of Freq:70]D4_1ytd:32; v_70_033_ai; [Out of Freq:70]D5_1ytd:33; v_70_034_ai; [Out of Freq:70]MBTA_1ytd:34; *)
			ARRAY TO SELECTION:C261(v_70_035_ai; [Out of Freq:70]MDC_1ytd:35; v_70_036_ai; [Out of Freq:70]MTA_1ytd:36; v_70_037_ai; [Out of Freq:70]MPA_1ytd:37; *)
			ARRAY TO SELECTION:C261(v_70_038_ai; [Out of Freq:70]DEM_1ytd:38; v_70_039_ai; [Out of Freq:70]DNR_1ytd:39; v_70_040_ai; [Out of Freq:70]Dive_1ytd:40; *)
			ARRAY TO SELECTION:C261(v_70_041_ai; [Out of Freq:70]D1_2ytd:41; v_70_042_ai; [Out of Freq:70]D2_2ytd:42; v_70_043_ai; [Out of Freq:70]D3_2ytd:43; *)
			ARRAY TO SELECTION:C261(v_70_044_ai; [Out of Freq:70]D4_2ytd:44; v_70_045_ai; [Out of Freq:70]D5_2ytd:45; v_70_046_ai; [Out of Freq:70]MBTA_2ytd:46; *)
			ARRAY TO SELECTION:C261(v_70_047_ai; [Out of Freq:70]MDC_2ytd:47; v_70_048_ai; [Out of Freq:70]MTA_2ytd:48; v_70_049_ai; [Out of Freq:70]MPA_2ytd:49; *)
			ARRAY TO SELECTION:C261(v_70_050_ai; [Out of Freq:70]DEM_2ytd:50; v_70_051_ai; [Out of Freq:70]DNR_2ytd:51; v_70_052_ai; [Out of Freq:70]Dive_2ytd:52; *)
			ARRAY TO SELECTION:C261(v_70_053_ai; [Out of Freq:70]D1_3ytd:53; v_70_054_ai; [Out of Freq:70]D2_3ytd:54; v_70_055_ai; [Out of Freq:70]D3_3ytd:55; *)
			ARRAY TO SELECTION:C261(v_70_056_ai; [Out of Freq:70]D4_3ytd:56; v_70_057_ai; [Out of Freq:70]D5_3ytd:57; v_70_058_ai; [Out of Freq:70]MBTA_3ytd:58; *)
			ARRAY TO SELECTION:C261(v_70_059_ai; [Out of Freq:70]MDC_3ytd:59; v_70_060_ai; [Out of Freq:70]MTA_3ytd:60; v_70_061_ai; [Out of Freq:70]MPA_3ytd:61; *)
			ARRAY TO SELECTION:C261(v_70_062_ai; [Out of Freq:70]DEM_3ytd:62; v_70_063_ai; [Out of Freq:70]DNR_3ytd:63; v_70_064_ai; [Out of Freq:70]Dive_3ytd:64; *)
			ARRAY TO SELECTION:C261(v_70_001_ad; [Out of Freq:70]Date_Created:1; *)
			ARRAY TO SELECTION:C261(v_70_002_atm; [Out of Freq:70]Time_Created:2)
		End if 
	: ($1=71)  //Integral Bridge
		$Array_Ptr:=->v_71_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_71_003_atxt; [Integral Bridge:71]Integral_Bridge_UUIDKey_s:3; *)  //Integral_Bridge_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_71_001_atxt; [Integral Bridge:71]Code:1; v_71_002_atxt; [Integral Bridge:71]Description:2)
		End if 
	: ($1=72)  //RPCs
		$Array_Ptr:=->v_72_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_72_004_atxt; [RPCs:72]RPCs_UUIDKey_s:4; *)  //RPCs_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_72_001_atxt; [RPCs:72]Code:1; v_72_002_atxt; [RPCs:72]RPC Name:2; v_72_003_atxt; [RPCs:72]Short Name:3)
		End if 
	: ($1=73)  //TownLineInfo
		$Array_Ptr:=->v_73_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_73_004_atxt; [TownLineInfo:73]TownLineInfo_UUIDKey_s:4; *)  //TownLineInfo_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_73_003_aL; [TownLineInfo:73]RefID:3; *)
			
			ARRAY TO SELECTION:C261(v_73_001_atxt; [TownLineInfo:73]BIN:1; v_73_002_atxt; [TownLineInfo:73]BDEPT:2)
		End if 
	: ($1=74)  //Conslt Rating Cost
		$Array_Ptr:=->v_74_019_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_74_050_atxt; [Conslt Rating Cost:74]Conslt_Rating_Cost_UUIDKey_s:50; *)  //Conslt_Rating_Cost_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_74_019_atxt; [Conslt Rating Cost:74]Neg Comments:19; v_74_036_atxt; [Conslt Rating Cost:74]Act Comments:36; *)
			ARRAY TO SELECTION:C261(v_74_002_ar; [Conslt Rating Cost:74]Neg WorkHours:2; v_74_003_ar; [Conslt Rating Cost:74]Neg Salary:3; v_74_004_ar; [Conslt Rating Cost:74]Neg IndirectCost:4; *)
			ARRAY TO SELECTION:C261(v_74_005_ar; [Conslt Rating Cost:74]Neg NetFee:5; v_74_006_ar; [Conslt Rating Cost:74]Neg TotalLimitFee:6; v_74_007_ar; [Conslt Rating Cost:74]Neg Flagging:7; *)
			ARRAY TO SELECTION:C261(v_74_008_ar; [Conslt Rating Cost:74]Neg Rigging:8; v_74_009_ar; [Conslt Rating Cost:74]Neg Lifts:9; v_74_010_ar; [Conslt Rating Cost:74]Neg TrafficControl:10; *)
			ARRAY TO SELECTION:C261(v_74_011_ar; [Conslt Rating Cost:74]Neg Police:11; v_74_012_ar; [Conslt Rating Cost:74]Neg Printing:12; v_74_013_ar; [Conslt Rating Cost:74]Neg Mileage:13; *)
			ARRAY TO SELECTION:C261(v_74_014_ar; [Conslt Rating Cost:74]Neg Lodging:14; v_74_015_ar; [Conslt Rating Cost:74]Neg Postage:15; v_74_016_ar; [Conslt Rating Cost:74]Neg Meals:16; *)
			ARRAY TO SELECTION:C261(v_74_017_ar; [Conslt Rating Cost:74]Neg TotalDirectCost:17; v_74_018_ar; [Conslt Rating Cost:74]Neg TotalCost:18; v_74_020_ar; [Conslt Rating Cost:74]Act WorkHours:20; *)
			ARRAY TO SELECTION:C261(v_74_021_ar; [Conslt Rating Cost:74]Act Salary:21; v_74_022_ar; [Conslt Rating Cost:74]Act NetFee:22; v_74_023_ar; [Conslt Rating Cost:74]Act TotalLimitFee:23; *)
			ARRAY TO SELECTION:C261(v_74_024_ar; [Conslt Rating Cost:74]Act Flagging:24; v_74_025_ar; [Conslt Rating Cost:74]Act Rigging:25; v_74_026_ar; [Conslt Rating Cost:74]Act Lifts:26; *)
			ARRAY TO SELECTION:C261(v_74_027_ar; [Conslt Rating Cost:74]Act TrafficControl:27; v_74_028_ar; [Conslt Rating Cost:74]Act Police:28; v_74_029_ar; [Conslt Rating Cost:74]Act Printing:29; *)
			ARRAY TO SELECTION:C261(v_74_030_ar; [Conslt Rating Cost:74]Act Mileage:30; v_74_031_ar; [Conslt Rating Cost:74]Act Lodging:31; v_74_032_ar; [Conslt Rating Cost:74]Act Postage:32; *)
			ARRAY TO SELECTION:C261(v_74_033_ar; [Conslt Rating Cost:74]Act Meals:33; v_74_034_ar; [Conslt Rating Cost:74]Act TotalDirectCost:34; v_74_035_ar; [Conslt Rating Cost:74]Act TotalCost:35; *)
			ARRAY TO SELECTION:C261(v_74_037_ar; [Conslt Rating Cost:74]Neg Misc:37; v_74_038_ar; [Conslt Rating Cost:74]Act Misc:38; v_74_039_ar; [Conslt Rating Cost:74]Act IndirectCost:39; *)
			ARRAY TO SELECTION:C261(v_74_040_ar; [Conslt Rating Cost:74]OverheadRate:40; v_74_042_ar; [Conslt Rating Cost:74]Neg Barge:42; v_74_043_ar; [Conslt Rating Cost:74]Neg SafetyBoat:43; *)
			ARRAY TO SELECTION:C261(v_74_044_ar; [Conslt Rating Cost:74]Neg Snooper:44; v_74_045_ar; [Conslt Rating Cost:74]Neg RRflagging:45; v_74_046_ar; [Conslt Rating Cost:74]Act Barge:46; *)
			ARRAY TO SELECTION:C261(v_74_047_ar; [Conslt Rating Cost:74]Act SafetyBoat:47; v_74_048_ar; [Conslt Rating Cost:74]Act Snooper:48; v_74_049_ar; [Conslt Rating Cost:74]Act RRflagging:49; *)
			ARRAY TO SELECTION:C261(v_74_001_aL; [Conslt Rating Cost:74]ConsltRatingID:1; *)
			ARRAY TO SELECTION:C261(v_74_041_ab; [Conslt Rating Cost:74]FinalCost_B:41)
		End if 
	: ($1=75)  //Bridge Design
		$Array_Ptr:=->v_75_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_75_053_atxt; [Bridge Design:75]Bridge_Design_UUIDKey_s:53; *)  //Bridge_Design_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_75_035_aL; [Bridge Design:75]BridgeDesignID:35; *)
			
			ARRAY TO SELECTION:C261(v_75_001_atxt; [Bridge Design:75]BIN:1; v_75_002_atxt; [Bridge Design:75]PROJIS:2; v_75_003_atxt; [Bridge Design:75]FAPNumber:3; *)
			ARRAY TO SELECTION:C261(v_75_005_atxt; [Bridge Design:75]Designer:5; v_75_007_atxt; [Bridge Design:75]ProjectType:7; v_75_008_atxt; [Bridge Design:75]Abutment:8; *)
			ARRAY TO SELECTION:C261(v_75_009_atxt; [Bridge Design:75]AbutmentComment:9; v_75_010_atxt; [Bridge Design:75]SeismicRetrofit:10; v_75_011_atxt; [Bridge Design:75]SuperStruct:11; *)
			ARRAY TO SELECTION:C261(v_75_012_atxt; [Bridge Design:75]SuperStructComment:12; v_75_013_atxt; [Bridge Design:75]Deck:13; v_75_014_atxt; [Bridge Design:75]DeckComment:14; *)
			ARRAY TO SELECTION:C261(v_75_015_atxt; [Bridge Design:75]Pier:15; v_75_016_atxt; [Bridge Design:75]PierComment:16; v_75_017_atxt; [Bridge Design:75]Scour:17; *)
			ARRAY TO SELECTION:C261(v_75_018_atxt; [Bridge Design:75]Barrier:18; v_75_019_atxt; [Bridge Design:75]Bearing:19; v_75_020_atxt; [Bridge Design:75]Joint:20; *)
			ARRAY TO SELECTION:C261(v_75_021_atxt; [Bridge Design:75]ScreenType:21; v_75_022_atxt; [Bridge Design:75]CurbRail:22; v_75_030_atxt; [Bridge Design:75]StageConstruction:30; *)
			ARRAY TO SELECTION:C261(v_75_031_atxt; [Bridge Design:75]PreEngineered:31; v_75_033_atxt; [Bridge Design:75]ContractNumber:33; v_75_036_atxt; [Bridge Design:75]DesignLoad:36; *)
			ARRAY TO SELECTION:C261(v_75_048_atxt; [Bridge Design:75]MinVertUcCode:48; v_75_049_atxt; [Bridge Design:75]MinLatUcCode:49; *)
			ARRAY TO SELECTION:C261(v_75_006_ar; [Bridge Design:75]TotalOfficeEstimate:6; v_75_023_ar; [Bridge Design:75]SidewalkLeft:23; v_75_024_ar; [Bridge Design:75]SidewalkRight:24; *)
			ARRAY TO SELECTION:C261(v_75_025_ar; [Bridge Design:75]TotalSpanLength:25; v_75_026_ar; [Bridge Design:75]WideOutToOut:26; v_75_028_ar; [Bridge Design:75]SkewAngle:28; *)
			ARRAY TO SELECTION:C261(v_75_029_ar; [Bridge Design:75]RadiusCurvedGirder:29; v_75_032_ar; [Bridge Design:75]ApproachSlabVolume:32; v_75_037_ar; [Bridge Design:75]CostPerSQM:37; *)
			ARRAY TO SELECTION:C261(v_75_043_ar; [Bridge Design:75]StructLength:43; v_75_044_ar; [Bridge Design:75]WidthCurbToCurb:44; v_75_045_ar; [Bridge Design:75]MinVertUnderclear:45; *)
			ARRAY TO SELECTION:C261(v_75_046_ar; [Bridge Design:75]MinLatUnderclearRT:46; v_75_047_ar; [Bridge Design:75]MinLatUnderclearLT:47; v_75_050_ar; [Bridge Design:75]HI_Total_Elmt_Cost:50; *)
			ARRAY TO SELECTION:C261(v_75_051_ar; [Bridge Design:75]HI_Current_Elmt_Cost:51; v_75_052_ar; [Bridge Design:75]HealthIndex:52; *)
			ARRAY TO SELECTION:C261(v_75_027_ai; [Bridge Design:75]NumSpans:27; v_75_039_ai; [Bridge Design:75]LanesOnStruct:39; v_75_040_ai; [Bridge Design:75]LanesUnderStruct:40; *)
			ARRAY TO SELECTION:C261(v_75_042_ai; [Bridge Design:75]YearADT:42; *)
			ARRAY TO SELECTION:C261(v_75_041_aL; [Bridge Design:75]AvgDailyTraffic:41; *)
			ARRAY TO SELECTION:C261(v_75_004_ad; [Bridge Design:75]ADVDate:4; *)
			ARRAY TO SELECTION:C261(v_75_034_ab; [Bridge Design:75]PlansOnFile:34; v_75_038_ab; [Bridge Design:75]MetricUnit:38)
		End if 
	: ($1=76)  //Cons Inspection Cost
		$Array_Ptr:=->v_76_020_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_76_050_atxt; [Cons Inspection Cost:76]Cons_Inspection_Cost_UUIDKey_s:50; *)  //Cons_Inspection_Cost_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_76_020_atxt; [Cons Inspection Cost:76]Neg Comments:20; v_76_039_atxt; [Cons Inspection Cost:76]Act Comments:39; *)
			ARRAY TO SELECTION:C261(v_76_002_ar; [Cons Inspection Cost:76]Neg WorkHours:2; v_76_003_ar; [Cons Inspection Cost:76]Neg Salary:3; v_76_004_ar; [Cons Inspection Cost:76]Neg IndirectCost:4; *)
			ARRAY TO SELECTION:C261(v_76_005_ar; [Cons Inspection Cost:76]Neg NetFee:5; v_76_006_ar; [Cons Inspection Cost:76]Neg TotalLimitFee:6; v_76_007_ar; [Cons Inspection Cost:76]Neg Flagging:7; *)
			ARRAY TO SELECTION:C261(v_76_008_ar; [Cons Inspection Cost:76]Neg Rigging:8; v_76_009_ar; [Cons Inspection Cost:76]Neg Lifts:9; v_76_010_ar; [Cons Inspection Cost:76]Neg TrafficControl:10; *)
			ARRAY TO SELECTION:C261(v_76_011_ar; [Cons Inspection Cost:76]Neg Police:11; v_76_012_ar; [Cons Inspection Cost:76]Neg Printing:12; v_76_013_ar; [Cons Inspection Cost:76]Neg Mileage:13; *)
			ARRAY TO SELECTION:C261(v_76_014_ar; [Cons Inspection Cost:76]Neg Lodging:14; v_76_015_ar; [Cons Inspection Cost:76]Neg Postage:15; v_76_016_ar; [Cons Inspection Cost:76]Neg Meals:16; *)
			ARRAY TO SELECTION:C261(v_76_017_ar; [Cons Inspection Cost:76]Neg Misc:17; v_76_018_ar; [Cons Inspection Cost:76]Neg TotalDirectCost:18; v_76_019_ar; [Cons Inspection Cost:76]Neg TotalCost:19; *)
			ARRAY TO SELECTION:C261(v_76_021_ar; [Cons Inspection Cost:76]Act WorkHours:21; v_76_022_ar; [Cons Inspection Cost:76]Act Salary:22; v_76_023_ar; [Cons Inspection Cost:76]Act IndirectCost:23; *)
			ARRAY TO SELECTION:C261(v_76_024_ar; [Cons Inspection Cost:76]Act NetFee:24; v_76_025_ar; [Cons Inspection Cost:76]Act TotalLimitFee:25; v_76_026_ar; [Cons Inspection Cost:76]Act Flagging:26; *)
			ARRAY TO SELECTION:C261(v_76_027_ar; [Cons Inspection Cost:76]Act Rigging:27; v_76_028_ar; [Cons Inspection Cost:76]Act Lifts:28; v_76_029_ar; [Cons Inspection Cost:76]Act TrafficControl:29; *)
			ARRAY TO SELECTION:C261(v_76_030_ar; [Cons Inspection Cost:76]Act Police:30; v_76_031_ar; [Cons Inspection Cost:76]Act Printing:31; v_76_032_ar; [Cons Inspection Cost:76]Act Mileage:32; *)
			ARRAY TO SELECTION:C261(v_76_033_ar; [Cons Inspection Cost:76]Act Lodging:33; v_76_034_ar; [Cons Inspection Cost:76]Act Postage:34; v_76_035_ar; [Cons Inspection Cost:76]Act Meals:35; *)
			ARRAY TO SELECTION:C261(v_76_036_ar; [Cons Inspection Cost:76]Act Misc:36; v_76_037_ar; [Cons Inspection Cost:76]Act TotalDirectCost:37; v_76_038_ar; [Cons Inspection Cost:76]Act TotalCost:38; *)
			ARRAY TO SELECTION:C261(v_76_040_ar; [Cons Inspection Cost:76]OverheadRate:40; v_76_041_ar; [Cons Inspection Cost:76]Neg Barge:41; v_76_042_ar; [Cons Inspection Cost:76]Neg SafetyBoat:42; *)
			ARRAY TO SELECTION:C261(v_76_043_ar; [Cons Inspection Cost:76]Neg Snooper:43; v_76_044_ar; [Cons Inspection Cost:76]Neg RRflagging:44; v_76_045_ar; [Cons Inspection Cost:76]Act Barge:45; *)
			ARRAY TO SELECTION:C261(v_76_046_ar; [Cons Inspection Cost:76]Act SafetyBoat:46; v_76_047_ar; [Cons Inspection Cost:76]Act Snooper:47; v_76_048_ar; [Cons Inspection Cost:76]Act RRflagging:48; *)
			ARRAY TO SELECTION:C261(v_76_001_aL; [Cons Inspection Cost:76]ConsInspectionID:1; *)
			ARRAY TO SELECTION:C261(v_76_049_ab; [Cons Inspection Cost:76]FinalCost_B:49)
		End if 
	: ($1=77)  //Conslt Address
		$Array_Ptr:=->v_77_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_77_023_atxt; [Conslt Address:77]Conslt_Address_UUIDKey_s:23; *)  //Conslt_Address_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_77_001_aL; [Conslt Address:77]ConsltAddressID:1; *)
			
			ARRAY TO SELECTION:C261(v_77_002_atxt; [Conslt Address:77]ConsltName:2; v_77_003_atxt; [Conslt Address:77]ContactFName:3; v_77_004_atxt; [Conslt Address:77]ContactLName:4; *)
			ARRAY TO SELECTION:C261(v_77_005_atxt; [Conslt Address:77]ContactMName:5; v_77_006_atxt; [Conslt Address:77]ContactPrefix:6; v_77_007_atxt; [Conslt Address:77]ContactTitle:7; *)
			ARRAY TO SELECTION:C261(v_77_008_atxt; [Conslt Address:77]Street1:8; v_77_009_atxt; [Conslt Address:77]Street2:9; v_77_010_atxt; [Conslt Address:77]City:10; *)
			ARRAY TO SELECTION:C261(v_77_011_atxt; [Conslt Address:77]State:11; v_77_012_atxt; [Conslt Address:77]Zip:12; v_77_013_atxt; [Conslt Address:77]PhoneNo1:13; *)
			ARRAY TO SELECTION:C261(v_77_014_atxt; [Conslt Address:77]PhoneNo2:14; v_77_015_atxt; [Conslt Address:77]PhoneNo3:15; v_77_016_atxt; [Conslt Address:77]FaxNo1:16; *)
			ARRAY TO SELECTION:C261(v_77_017_atxt; [Conslt Address:77]FaxNo2:17; v_77_018_atxt; [Conslt Address:77]Email:18; *)
			ARRAY TO SELECTION:C261(v_77_022_aL; [Conslt Address:77]ConsultantNameID_l:22; *)
			ARRAY TO SELECTION:C261(v_77_019_ab; [Conslt Address:77]Func_Rating:19; v_77_020_ab; [Conslt Address:77]Func_Insp:20; v_77_021_ab; [Conslt Address:77]Func_Design:21)
		End if 
	: ($1=78)  //Town Address
		$Array_Ptr:=->v_78_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_78_016_atxt; [Town Address:78]Town_Address_UUIDKey_s:16; *)  //Town_Address_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_78_001_aL; [Town Address:78]TownAddressID:1; *)
			
			ARRAY TO SELECTION:C261(v_78_002_atxt; [Town Address:78]TownName:2; v_78_003_atxt; [Town Address:78]AddressedTo:3; v_78_004_atxt; [Town Address:78]OfficialTownName:4; *)
			ARRAY TO SELECTION:C261(v_78_005_atxt; [Town Address:78]Street:5; v_78_006_atxt; [Town Address:78]State:6; v_78_007_atxt; [Town Address:78]Zip:7; *)
			ARRAY TO SELECTION:C261(v_78_008_atxt; [Town Address:78]ContactFName:8; v_78_009_atxt; [Town Address:78]ContactLName:9; v_78_010_atxt; [Town Address:78]ContactMName:10; *)
			ARRAY TO SELECTION:C261(v_78_011_atxt; [Town Address:78]ContactTitle:11; v_78_012_atxt; [Town Address:78]ContactPrefix:12; v_78_013_atxt; [Town Address:78]ContactPhone:13; *)
			ARRAY TO SELECTION:C261(v_78_014_atxt; [Town Address:78]ContactFax:14; v_78_015_atxt; [Town Address:78]ContactEmail:15; v_78_017_atxt; [Town Address:78]TownBDEPTPrefix:17)
		End if 
	: ($1=79)  //Contracts
		$Array_Ptr:=->v_79_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_79_031_atxt; [Contracts:79]Contracts_UUIDKey_s:31; *)  //Contracts_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_79_001_atxt; [Contracts:79]ContractNo:1; v_79_029_aL; [Contracts:79]ContractID:29; *)
			
			ARRAY TO SELECTION:C261(v_79_002_atxt; [Contracts:79]ContractType:2; v_79_003_atxt; [Contracts:79]ConsltName:3; v_79_007_atxt; [Contracts:79]ContractStatus:7; *)
			ARRAY TO SELECTION:C261(v_79_009_atxt; [Contracts:79]FederalAidNo:9; v_79_022_atxt; [Contracts:79]CheckWithAuditComment:22; v_79_024_atxt; [Contracts:79]CertificateOfCompletionCmnt:24; *)
			ARRAY TO SELECTION:C261(v_79_026_atxt; [Contracts:79]ReincumbrancesComment:26; v_79_028_atxt; [Contracts:79]ProcessRetainageComment:28; *)
			ARRAY TO SELECTION:C261(v_79_010_ar; [Contracts:79]OverheadRate:10; v_79_011_ar; [Contracts:79]NetFeeRate:11; v_79_012_ar; [Contracts:79]InitContractTotal:12; *)
			ARRAY TO SELECTION:C261(v_79_013_ar; [Contracts:79]InitContractSalary:13; v_79_014_ar; [Contracts:79]InitContractTotalLimitFee:14; v_79_015_ar; [Contracts:79]InitContractTotDirctExpense:15; *)
			ARRAY TO SELECTION:C261(v_79_016_ar; [Contracts:79]TotalEncumbered:16; v_79_017_ar; [Contracts:79]ApproxSpent:17; v_79_018_ar; [Contracts:79]ActualSpent:18; *)
			ARRAY TO SELECTION:C261(v_79_019_ar; [Contracts:79]ApproxRemainingFund:19; v_79_020_ar; [Contracts:79]ActualRemainingFund:20; v_79_030_ar; [Contracts:79]MaxHourlyRate:30; *)
			ARRAY TO SELECTION:C261(v_79_004_ad; [Contracts:79]AwardContractDate:4; v_79_005_ad; [Contracts:79]InitialCompleteDate:5; v_79_006_ad; [Contracts:79]ExtendedCompleteDate:6; *)
			ARRAY TO SELECTION:C261(v_79_008_ab; [Contracts:79]FederalFund:8; v_79_021_ab; [Contracts:79]CheckWithAudit:21; v_79_023_ab; [Contracts:79]CertificateOfCompletion:23; *)
			ARRAY TO SELECTION:C261(v_79_025_ab; [Contracts:79]Reincumbrances:25; v_79_027_ab; [Contracts:79]ProcessRetainage:27)
		End if 
	: ($1=80)  //Contract FundTransfer
		$Array_Ptr:=->v_80_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_80_009_atxt; [Contract FundTransfer:80]Contract_FundTransfer_UUIDKey_s:9; *)  //Contract_FundTransfer_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_80_002_aL; [Contract FundTransfer:80]TOF_ID:2; *)
			
			ARRAY TO SELECTION:C261(v_80_001_atxt; [Contract FundTransfer:80]ContractNo:1; v_80_006_atxt; [Contract FundTransfer:80]TransferDirection:6; *)
			ARRAY TO SELECTION:C261(v_80_007_ar; [Contract FundTransfer:80]TransferAmount:7; *)
			ARRAY TO SELECTION:C261(v_80_003_ad; [Contract FundTransfer:80]DateCsltLetter:3; v_80_004_ad; [Contract FundTransfer:80]DateDocSentToContracts:4; v_80_005_ad; [Contract FundTransfer:80]DateApproval:5; *)
			ARRAY TO SELECTION:C261(v_80_008_ab; [Contract FundTransfer:80]DeleteMe:8)
		End if 
	: ($1=81)  //Contract ExtendTime
		$Array_Ptr:=->v_81_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_81_008_atxt; [Contract ExtendTime:81]Contract_ExtendTime_UUIDKey_s:8; *)  //Contract_ExtendTime_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_81_002_aL; [Contract ExtendTime:81]EOT_ID:2; *)
			
			ARRAY TO SELECTION:C261(v_81_001_atxt; [Contract ExtendTime:81]ContractNo:1; *)
			ARRAY TO SELECTION:C261(v_81_003_ad; [Contract ExtendTime:81]DateCsltLetter:3; v_81_004_ad; [Contract ExtendTime:81]DateDocSentToContracts:4; v_81_005_ad; [Contract ExtendTime:81]DateBoardAction:5; *)
			ARRAY TO SELECTION:C261(v_81_006_ad; [Contract ExtendTime:81]InitialDate:6; v_81_007_ad; [Contract ExtendTime:81]ExtendedDate:7)
		End if 
	: ($1=82)  //Contract AddFund
		$Array_Ptr:=->v_82_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_82_009_atxt; [Contract AddFund:82]Contract_AddFund_UUIDKey_s:9; *)  //Contract_AddFund_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_82_002_aL; [Contract AddFund:82]AddFund_ID:2; *)
			
			ARRAY TO SELECTION:C261(v_82_001_atxt; [Contract AddFund:82]ContractNo:1; *)
			ARRAY TO SELECTION:C261(v_82_006_ar; [Contract AddFund:82]TotalLimitFee:6; v_82_007_ar; [Contract AddFund:82]DirectExpense:7; v_82_008_ar; [Contract AddFund:82]Total:8; *)
			ARRAY TO SELECTION:C261(v_82_003_ad; [Contract AddFund:82]DateCsltLetter:3; v_82_004_ad; [Contract AddFund:82]DateDocSentToContracts:4; v_82_005_ad; [Contract AddFund:82]DateApproval:5)
		End if 
	: ($1=83)  //Contract Assignments
		$Array_Ptr:=->v_83_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_83_024_atxt; [Contract Assignments:83]Contract_Assignments_UUIDKey_s:24; *)  //Contract_Assignments_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_83_003_aL; [Contract Assignments:83]AssignID:3; *)
			
			ARRAY TO SELECTION:C261(v_83_001_atxt; [Contract Assignments:83]ContractNo:1; v_83_019_atxt; [Contract Assignments:83]Comments:19; v_83_020_atxt; [Contract Assignments:83]AcutalOrEstimate:20; *)
			ARRAY TO SELECTION:C261(v_83_004_ar; [Contract Assignments:83]Actual_Salary:4; v_83_005_ar; [Contract Assignments:83]Actual_IndirectCost:5; v_83_006_ar; [Contract Assignments:83]Actual_NetFee:6; *)
			ARRAY TO SELECTION:C261(v_83_007_ar; [Contract Assignments:83]Actual_TotalLimitFee:7; v_83_008_ar; [Contract Assignments:83]Actual_DirectExpense:8; v_83_009_ar; [Contract Assignments:83]Actual_Total:9; *)
			ARRAY TO SELECTION:C261(v_83_010_ar; [Contract Assignments:83]Est_Salary:10; v_83_011_ar; [Contract Assignments:83]Est_IndirectCost:11; v_83_012_ar; [Contract Assignments:83]Est_NetFee:12; *)
			ARRAY TO SELECTION:C261(v_83_013_ar; [Contract Assignments:83]Est_TotalLimitFee:13; v_83_014_ar; [Contract Assignments:83]Est_DirectExpense:14; v_83_015_ar; [Contract Assignments:83]Est_Total:15; *)
			ARRAY TO SELECTION:C261(v_83_022_ar; [Contract Assignments:83]NetFeeRate:22; v_83_023_ar; [Contract Assignments:83]OverHeadRate:23; *)
			ARRAY TO SELECTION:C261(v_83_002_ai; [Contract Assignments:83]AssignNo:2; *)
			ARRAY TO SELECTION:C261(v_83_016_ad; [Contract Assignments:83]ReqFeeProposalDate:16; v_83_017_ad; [Contract Assignments:83]NTPdate_written:17; v_83_018_ad; [Contract Assignments:83]NTPdate_verbal:18; *)
			ARRAY TO SELECTION:C261(v_83_021_ab; [Contract Assignments:83]SpecialAssignment:21)
		End if 
	: ($1=84)  //Contract Invoice
		$Array_Ptr:=->v_84_003_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_84_014_atxt; [Contract Invoice:84]Contract_Invoice_UUIDKey_s:14; *)  //Contract_Invoice_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_84_001_aL; [Contract Invoice:84]InvoiceID:1; *)
			
			ARRAY TO SELECTION:C261(v_84_003_atxt; [Contract Invoice:84]ContractNo:3; v_84_013_atxt; [Contract Invoice:84]Comments:13; *)
			ARRAY TO SELECTION:C261(v_84_008_ar; [Contract Invoice:84]AssignPercentage:8; v_84_011_ar; [Contract Invoice:84]TotalAmount:11; *)
			ARRAY TO SELECTION:C261(v_84_007_ai; [Contract Invoice:84]AssignNo:7; *)
			ARRAY TO SELECTION:C261(v_84_002_aL; [Contract Invoice:84]InvoiceNo:2; *)
			ARRAY TO SELECTION:C261(v_84_004_ad; [Contract Invoice:84]DateReceived:4; v_84_005_ad; [Contract Invoice:84]DateServiceFrom:5; v_84_006_ad; [Contract Invoice:84]DateServiceTo:6; *)
			ARRAY TO SELECTION:C261(v_84_009_ad; [Contract Invoice:84]DateProcessFoward:9; v_84_010_ad; [Contract Invoice:84]DateSentBackToConslt:10; *)
			ARRAY TO SELECTION:C261(v_84_012_ab; [Contract Invoice:84]Accepted:12)
		End if 
	: ($1=85)  //Contract Invoice AssignNo
		$Array_Ptr:=->v_85_003_ar
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_85_004_atxt; [Contract Invoice AssignNo:85]Contract_Invoice_Assi_UUIDKey_s:4; *)  //Contract_Invoice_Assi_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_85_003_ar; [Contract Invoice AssignNo:85]Percent:3; *)
			ARRAY TO SELECTION:C261(v_85_002_ai; [Contract Invoice AssignNo:85]AssignNo:2; *)
			ARRAY TO SELECTION:C261(v_85_001_aL; [Contract Invoice AssignNo:85]InvoiceID:1)
		End if 
	: ($1=86)  //Templates
		$Array_Ptr:=->v_86_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_86_007_atxt; [Templates:86]Templates_UUIDKey_s:7; *)  //Templates_UUIDKey_s
			End if 
			If (clone_UseBlobArrays_B)
				ARRAY TO SELECTION:C261(v_86_003_ablb; [Templates:86]Template_:3; *)
			Else 
				clone_GetBlobs($1)
			End if 
			ARRAY TO SELECTION:C261(v_86_001_aL; [Templates:86]TemplateID:1; *)
			
			ARRAY TO SELECTION:C261(v_86_002_atxt; [Templates:86]TemplateName:2; v_86_004_atxt; [Templates:86]TemplateDesc:4; *)
			ARRAY TO SELECTION:C261(v_86_005_ab; [Templates:86]Field5:5; v_86_006_ab; [Templates:86]Field6:6)
		End if 
	: ($1=87)  //ServerProcesses
		$Array_Ptr:=->v_87_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_87_007_atxt; [ServerProcesses:87]ServerProcesses_UUIDKey_s:7; *)  //ServerProcesses_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_87_001_atxt; [ServerProcesses:87]ProcessName_s:1; v_87_002_atxt; [ServerProcesses:87]ProcessRunSchedule_s:2; v_87_003_atxt; [ServerProcesses:87]LastRunTimeStamp_s:3; *)
			ARRAY TO SELECTION:C261(v_87_004_atxt; [ServerProcesses:87]NextRunTimeStamp_s:4; *)
			ARRAY TO SELECTION:C261(v_87_006_aL; [ServerProcesses:87]ControlProcessDelay_l:6; *)
			ARRAY TO SELECTION:C261(v_87_005_ab; [ServerProcesses:87]ProcessRunning_b:5)
		End if 
	: ($1=88)  //ClientAccess
		$Array_Ptr:=->v_88_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_88_006_atxt; [ClientAccess:88]ClientAccess_UUIDKey_s:6; *)  //ClientAccess_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_88_001_atxt; [ClientAccess:88]CA_Message_txt:1; v_88_002_atxt; [ClientAccess:88]CA_MessageStart_s:2; v_88_003_atxt; [ClientAccess:88]CA_LimitAccess_s:3; *)
			ARRAY TO SELECTION:C261(v_88_004_ab; [ClientAccess:88]CA_DisableLogins_b:4; v_88_005_ab; [ClientAccess:88]CA_Completed_b:5)
		End if 
	: ($1=89)  //SD_History
		$Array_Ptr:=->v_89_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_89_020_atxt; [SD_History:89]SD_History_UUIDKey_s:20; *)  //SD_History_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_89_001_atxt; [SD_History:89]Bin:1; v_89_002_atxt; [SD_History:89]SD_Year:2; v_89_003_atxt; [SD_History:89]SD_Month:3; *)
			ARRAY TO SELECTION:C261(v_89_004_atxt; [SD_History:89]BDEPT:4; v_89_005_atxt; [SD_History:89]Town Name:5; v_89_006_atxt; [SD_History:89]Item8:6; *)
			ARRAY TO SELECTION:C261(v_89_007_atxt; [SD_History:89]Item7:7; v_89_008_atxt; [SD_History:89]Item6A:8; v_89_009_atxt; [SD_History:89]Item58:9; *)
			ARRAY TO SELECTION:C261(v_89_010_atxt; [SD_History:89]Item59:10; v_89_011_atxt; [SD_History:89]Item60:11; v_89_012_atxt; [SD_History:89]Item2:12; *)
			ARRAY TO SELECTION:C261(v_89_014_atxt; [SD_History:89]Item21:14; v_89_015_atxt; [SD_History:89]Item41:15; v_89_016_atxt; [SD_History:89]SD_DefectAddRemoveStatus_s:16; *)
			ARRAY TO SELECTION:C261(v_89_017_atxt; [SD_History:89]SD_Owner_s:17; v_89_018_atxt; [SD_History:89]SD_PostedAddRemoveStatus_s:18; v_89_019_atxt; [SD_History:89]SD_PreviousOwner_s:19; *)
			ARRAY TO SELECTION:C261(v_89_013_ar; [SD_History:89]AASHTO:13)
		End if 
	: ($1=90)  //Combined Inspections
		$Array_Ptr:=->v_90_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_90_007_atxt; [Combined Inspections:90]Combined_Inspections_UUIDKey_s:7; *)  //Combined_Inspections_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_90_006_aL; [Combined Inspections:90]ID:6; *)
			
			ARRAY TO SELECTION:C261(v_90_001_atxt; [Combined Inspections:90]BIN:1; v_90_005_atxt; [Combined Inspections:90]InspType:5; *)
			ARRAY TO SELECTION:C261(v_90_002_aL; [Combined Inspections:90]NBISInspID:2; v_90_003_aL; [Combined Inspections:90]BMSInspID:3; *)
			ARRAY TO SELECTION:C261(v_90_004_ad; [Combined Inspections:90]InspDate:4)
		End if 
	: ($1=91)  //ACTMODLS
		$Array_Ptr:=->v_91_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_91_017_atxt; [ACTMODLS:91]ACTMODLS_UUIDKey_s:17; *)  //ACTMODLS_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_91_001_atxt; [ACTMODLS:91]MOKEY:1; *)
			ARRAY TO SELECTION:C261(v_91_006_ar; [ACTMODLS:91]DETWEIGHT:6; v_91_007_ar; [ACTMODLS:91]COSTWEIGHT:7; v_91_008_ar; [ACTMODLS:91]PROB1:8; *)
			ARRAY TO SELECTION:C261(v_91_009_ar; [ACTMODLS:91]PROB2:9; v_91_010_ar; [ACTMODLS:91]PROB3:10; v_91_011_ar; [ACTMODLS:91]PROB4:11; *)
			ARRAY TO SELECTION:C261(v_91_012_ar; [ACTMODLS:91]PROB5:12; v_91_013_ar; [ACTMODLS:91]VARUNITCO:13; v_91_014_ar; [ACTMODLS:91]FIXUNITCO:14; *)
			ARRAY TO SELECTION:C261(v_91_015_ar; [ACTMODLS:91]OPTFRAC:15; v_91_016_ar; [ACTMODLS:91]LTCOST:16; *)
			ARRAY TO SELECTION:C261(v_91_002_ai; [ACTMODLS:91]ELEMKEY:2; v_91_003_ai; [ACTMODLS:91]SKEY:3; v_91_004_ai; [ACTMODLS:91]AKEY:4; *)
			ARRAY TO SELECTION:C261(v_91_005_ai; [ACTMODLS:91]ENVKEY:5)
		End if 
	: ($1=92)  //ELEMDEFS
		$Array_Ptr:=->v_92_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_92_022_atxt; [ELEMDEFS:92]ELEMDEFS_UUIDKey_s:22; *)  //ELEMDEFS_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_92_002_atxt; [ELEMDEFS:92]ECATKEY:2; v_92_003_atxt; [ELEMDEFS:92]ETYPKEY:3; v_92_004_atxt; [ELEMDEFS:92]MATLKEY:4; *)
			ARRAY TO SELECTION:C261(v_92_007_atxt; [ELEMDEFS:92]COREFLAG:7; v_92_008_atxt; [ELEMDEFS:92]SMARTFLAG:8; v_92_010_atxt; [ELEMDEFS:92]USEPARMDLS:10; *)
			ARRAY TO SELECTION:C261(v_92_011_atxt; [ELEMDEFS:92]ELEMSHORT:11; v_92_012_atxt; [ELEMDEFS:92]ELEMLONG:12; v_92_014_atxt; [ELEMDEFS:92]EACHFLAG:14; *)
			ARRAY TO SELECTION:C261(v_92_015_atxt; [ELEMDEFS:92]PAINTFLAG:15; v_92_016_atxt; [ELEMDEFS:92]SCALESHORT:16; v_92_017_atxt; [ELEMDEFS:92]SCALEUNIT:17; *)
			ARRAY TO SELECTION:C261(v_92_019_atxt; [ELEMDEFS:92]SCALEMET:19; v_92_020_atxt; [ELEMDEFS:92]DOCREFKEY:20; v_92_021_atxt; [ELEMDEFS:92]NOTES:21; *)
			ARRAY TO SELECTION:C261(v_92_005_ar; [ELEMDEFS:92]PAIRCODE:5; v_92_009_ar; [ELEMDEFS:92]PARENT:9; v_92_018_ar; [ELEMDEFS:92]ELEMWEIGHT:18; *)
			ARRAY TO SELECTION:C261(v_92_001_ai; [ELEMDEFS:92]ELEMKEY:1; v_92_006_ai; [ELEMDEFS:92]ELEMNUM:6; v_92_013_ai; [ELEMDEFS:92]STATECNT:13)
		End if 
	: ($1=93)  //CONDUMDL
		$Array_Ptr:=->v_93_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_93_009_atxt; [CONDUMDL:93]CONDUMDL_UUIDKey_s:9; *)  //CONDUMDL_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_93_001_atxt; [CONDUMDL:93]MOKEY:1; v_93_008_atxt; [CONDUMDL:93]OPTRUNSTATUS:8; *)
			ARRAY TO SELECTION:C261(v_93_004_ar; [CONDUMDL:93]FAILPROB:4; v_93_005_ar; [CONDUMDL:93]FAILAGCYCO:5; v_93_006_ar; [CONDUMDL:93]FAILUSERCO:6; *)
			ARRAY TO SELECTION:C261(v_93_007_ar; [CONDUMDL:93]OPTYRCOST:7; *)
			ARRAY TO SELECTION:C261(v_93_002_ai; [CONDUMDL:93]ELEMKEY:2; v_93_003_ai; [CONDUMDL:93]ENVKEY:3)
		End if 
	: ($1=94)  //Invoice_AssignNo_Maintenance
		$Array_Ptr:=->v_94_003_ar
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_94_007_atxt; [Invoice_AssignNo_Maintenance:94]Invoice_AssignNo_Main_UUIDKey_s:7; *)  //Invoice_AssignNo_Main_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_94_006_aL; [Invoice_AssignNo_Maintenance:94]ID:6; *)
			
			ARRAY TO SELECTION:C261(v_94_003_ar; [Invoice_AssignNo_Maintenance:94]TotalLimFeeDes:3; v_94_004_ar; [Invoice_AssignNo_Maintenance:94]TotalLimFeeConstr:4; v_94_005_ar; [Invoice_AssignNo_Maintenance:94]DirectExpense:5; *)
			ARRAY TO SELECTION:C261(v_94_002_ai; [Invoice_AssignNo_Maintenance:94]AssignNo:2; *)
			ARRAY TO SELECTION:C261(v_94_001_aL; [Invoice_AssignNo_Maintenance:94]InvoiceID:1)
		End if 
	: ($1=95)  //Invoice_Maintenance
		$Array_Ptr:=->v_95_003_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_95_021_atxt; [Invoice_Maintenance:95]Invoice_Maintenance_UUIDKey_s:21; *)  //Invoice_Maintenance_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_95_001_aL; [Invoice_Maintenance:95]InvoiceID:1; *)
			
			ARRAY TO SELECTION:C261(v_95_003_atxt; [Invoice_Maintenance:95]ContractNo:3; v_95_013_atxt; [Invoice_Maintenance:95]Comments:13; *)
			ARRAY TO SELECTION:C261(v_95_008_ar; [Invoice_Maintenance:95]TotalLimFeeDes:8; v_95_011_ar; [Invoice_Maintenance:95]TotalAmount:11; v_95_014_ar; [Invoice_Maintenance:95]TotalLimFeeConstr:14; *)
			ARRAY TO SELECTION:C261(v_95_015_ar; [Invoice_Maintenance:95]DirectExpenses:15; v_95_016_ar; [Invoice_Maintenance:95]Retainage:16; v_95_017_ar; [Invoice_Maintenance:95]CostRecovery:17; *)
			ARRAY TO SELECTION:C261(v_95_018_ar; [Invoice_Maintenance:95]TotalHRS_r:18; *)
			ARRAY TO SELECTION:C261(v_95_007_ai; [Invoice_Maintenance:95]AssignNo:7; *)
			ARRAY TO SELECTION:C261(v_95_002_aL; [Invoice_Maintenance:95]InvoiceNo:2; v_95_020_aL; [Invoice_Maintenance:95]AssignID_L:20; *)
			ARRAY TO SELECTION:C261(v_95_004_ad; [Invoice_Maintenance:95]DateReceived:4; v_95_005_ad; [Invoice_Maintenance:95]DateServiceFrom:5; v_95_006_ad; [Invoice_Maintenance:95]DateServiceTo:6; *)
			ARRAY TO SELECTION:C261(v_95_009_ad; [Invoice_Maintenance:95]DateProcessFoward:9; v_95_010_ad; [Invoice_Maintenance:95]DateSentBackToConslt:10; v_95_019_ad; [Invoice_Maintenance:95]InvoiceDate_d:19; *)
			ARRAY TO SELECTION:C261(v_95_012_ab; [Invoice_Maintenance:95]Accepted:12)
		End if 
	: ($1=96)  //FundTransfer_Maintenance
		$Array_Ptr:=->v_96_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_96_009_atxt; [FundTransfer_Maintenance:96]FundTransfer_Maintena_UUIDKey_s:9; *)  //FundTransfer_Maintena_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_96_002_aL; [FundTransfer_Maintenance:96]TOF_ID:2; *)
			
			ARRAY TO SELECTION:C261(v_96_001_atxt; [FundTransfer_Maintenance:96]ContractNo:1; v_96_006_atxt; [FundTransfer_Maintenance:96]TransferDirection:6; *)
			ARRAY TO SELECTION:C261(v_96_007_ar; [FundTransfer_Maintenance:96]TransferAmount:7; *)
			ARRAY TO SELECTION:C261(v_96_003_ad; [FundTransfer_Maintenance:96]DateCsltLetter:3; v_96_004_ad; [FundTransfer_Maintenance:96]DateDocSentToContracts:4; v_96_005_ad; [FundTransfer_Maintenance:96]DateApproval:5; *)
			ARRAY TO SELECTION:C261(v_96_008_ab; [FundTransfer_Maintenance:96]DeleteMe:8)
		End if 
	: ($1=97)  //Contract_Maintenance
		$Array_Ptr:=->v_97_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_97_034_atxt; [Contract_Maintenance:97]Contract_Maintenance_UUIDKey_s:34; *)  //Contract_Maintenance_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_97_001_atxt; [Contract_Maintenance:97]ContractNo:1; v_97_002_aL; [Contract_Maintenance:97]ContractID:2; *)
			
			ARRAY TO SELECTION:C261(v_97_003_atxt; [Contract_Maintenance:97]ConsultantName:3; v_97_007_atxt; [Contract_Maintenance:97]ContractStatus:7; v_97_008_atxt; [Contract_Maintenance:97]ContractType:8; *)
			ARRAY TO SELECTION:C261(v_97_009_atxt; [Contract_Maintenance:97]FederalAidNo:9; v_97_022_atxt; [Contract_Maintenance:97]CheckWithAuditComment:22; v_97_024_atxt; [Contract_Maintenance:97]CertificateOfCompletionCmnt:24; *)
			ARRAY TO SELECTION:C261(v_97_026_atxt; [Contract_Maintenance:97]ReincumbrancesComment:26; v_97_028_atxt; [Contract_Maintenance:97]ProcessRetainageComment:28; v_97_033_atxt; [Contract_Maintenance:97]BridgePrjMgr:33; *)
			ARRAY TO SELECTION:C261(v_97_010_ar; [Contract_Maintenance:97]OverheadRate:10; v_97_011_ar; [Contract_Maintenance:97]NetFeeRate:11; v_97_012_ar; [Contract_Maintenance:97]InitContractTotal:12; *)
			ARRAY TO SELECTION:C261(v_97_013_ar; [Contract_Maintenance:97]InitContractSalary:13; v_97_014_ar; [Contract_Maintenance:97]InitContractTotalLimitFee:14; v_97_015_ar; [Contract_Maintenance:97]InitContractTotDirctExpense:15; *)
			ARRAY TO SELECTION:C261(v_97_016_ar; [Contract_Maintenance:97]TotalEncumbered:16; v_97_017_ar; [Contract_Maintenance:97]ApproxSpent:17; v_97_018_ar; [Contract_Maintenance:97]ActualSpent:18; *)
			ARRAY TO SELECTION:C261(v_97_019_ar; [Contract_Maintenance:97]ApproxRemainingFund:19; v_97_020_ar; [Contract_Maintenance:97]ActualRemainingFund:20; v_97_030_ar; [Contract_Maintenance:97]RetainageAmtInit:30; *)
			ARRAY TO SELECTION:C261(v_97_031_ar; [Contract_Maintenance:97]RetainagePct:31; v_97_032_ar; [Contract_Maintenance:97]MaxHourlyRate:32; *)
			ARRAY TO SELECTION:C261(v_97_004_ad; [Contract_Maintenance:97]AwardContractDate:4; v_97_005_ad; [Contract_Maintenance:97]InitialCompleteDate:5; v_97_006_ad; [Contract_Maintenance:97]ExtendedCompleteDate:6; *)
			ARRAY TO SELECTION:C261(v_97_021_ab; [Contract_Maintenance:97]CheckWithAudit:21; v_97_023_ab; [Contract_Maintenance:97]CertificateOfCompletion:23; v_97_025_ab; [Contract_Maintenance:97]Reincumbrances:25; *)
			ARRAY TO SELECTION:C261(v_97_027_ab; [Contract_Maintenance:97]ProcessRetainage:27; v_97_029_ab; [Contract_Maintenance:97]FederalFund:29)
		End if 
	: ($1=98)  //ExtendTime_Maintenance
		$Array_Ptr:=->v_98_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_98_008_atxt; [ExtendTime_Maintenance:98]ExtendTime_Maintenanc_UUIDKey_s:8; *)  //ExtendTime_Maintenanc_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_98_002_aL; [ExtendTime_Maintenance:98]EOT_ID:2; *)
			
			ARRAY TO SELECTION:C261(v_98_001_atxt; [ExtendTime_Maintenance:98]ContractNo:1; *)
			ARRAY TO SELECTION:C261(v_98_003_ad; [ExtendTime_Maintenance:98]DateCsltLetter:3; v_98_004_ad; [ExtendTime_Maintenance:98]DateDocSentToContracts:4; v_98_005_ad; [ExtendTime_Maintenance:98]DateBoardAction:5; *)
			ARRAY TO SELECTION:C261(v_98_006_ad; [ExtendTime_Maintenance:98]InitialDate:6; v_98_007_ad; [ExtendTime_Maintenance:98]ExtendedDate:7)
		End if 
	: ($1=99)  //AddFund_Maintenance
		$Array_Ptr:=->v_99_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_99_010_atxt; [AddFund_Maintenance:99]AddFund_Maintenance_UUIDKey_s:10; *)  //AddFund_Maintenance_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_99_002_aL; [AddFund_Maintenance:99]AddFund_ID:2; *)
			
			ARRAY TO SELECTION:C261(v_99_001_atxt; [AddFund_Maintenance:99]ContractNo:1; *)
			ARRAY TO SELECTION:C261(v_99_006_ar; [AddFund_Maintenance:99]TotalLimitFee:6; v_99_007_ar; [AddFund_Maintenance:99]DirectExpense:7; v_99_008_ar; [AddFund_Maintenance:99]Total:8; *)
			ARRAY TO SELECTION:C261(v_99_009_aL; [AddFund_Maintenance:99]FiscalYear:9; *)
			ARRAY TO SELECTION:C261(v_99_003_ad; [AddFund_Maintenance:99]DateCsltLetter:3; v_99_004_ad; [AddFund_Maintenance:99]DateDocSentToContracts:4; v_99_005_ad; [AddFund_Maintenance:99]DateApproval:5)
		End if 
	: ($1=100)  //Contract_Project_Maintenance
		$Array_Ptr:=->v_100_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_100_038_atxt; [Contract_Project_Maintenance:100]Contract_Project_Main_UUIDKey_s:38; *)  //Contract_Project_Main_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_100_001_aL; [Contract_Project_Maintenance:100]ProjectID:1; *)
			
			ARRAY TO SELECTION:C261(v_100_002_atxt; [Contract_Project_Maintenance:100]ContractNo:2; v_100_003_atxt; [Contract_Project_Maintenance:100]Project Type:3; v_100_004_atxt; [Contract_Project_Maintenance:100]BridgeNo:4; *)
			ARRAY TO SELECTION:C261(v_100_005_atxt; [Contract_Project_Maintenance:100]BIN:5; v_100_006_atxt; [Contract_Project_Maintenance:100]Location:6; v_100_007_atxt; [Contract_Project_Maintenance:100]Town:7; *)
			ARRAY TO SELECTION:C261(v_100_008_atxt; [Contract_Project_Maintenance:100]District:8; v_100_018_atxt; [Contract_Project_Maintenance:100]Classification_s:18; v_100_036_atxt; [Contract_Project_Maintenance:100]RecommConstr_txt:36; *)
			ARRAY TO SELECTION:C261(v_100_010_ar; [Contract_Project_Maintenance:100]Salary:10; v_100_011_ar; [Contract_Project_Maintenance:100]Overhead:11; v_100_012_ar; [Contract_Project_Maintenance:100]Fee:12; *)
			ARRAY TO SELECTION:C261(v_100_020_ar; [Contract_Project_Maintenance:100]HWYEvalValue_r:20; v_100_027_ar; [Contract_Project_Maintenance:100]OtherFactorsValue_r:27; v_100_028_ar; [Contract_Project_Maintenance:100]PrelimDecisValue_r:28; *)
			ARRAY TO SELECTION:C261(v_100_009_ai; [Contract_Project_Maintenance:100]AssignNo:9; *)
			ARRAY TO SELECTION:C261(v_100_013_aL; [Contract_Project_Maintenance:100]AssignID:13; v_100_014_aL; [Contract_Project_Maintenance:100]ADT_L:14; v_100_015_aL; [Contract_Project_Maintenance:100]ADTValue_L:15; *)
			ARRAY TO SELECTION:C261(v_100_016_aL; [Contract_Project_Maintenance:100]Detour_L:16; v_100_017_aL; [Contract_Project_Maintenance:100]DetourValue_L:17; v_100_019_aL; [Contract_Project_Maintenance:100]ClassificationValue_L:19; *)
			ARRAY TO SELECTION:C261(v_100_022_aL; [Contract_Project_Maintenance:100]EmergReplPts_L:22; v_100_024_aL; [Contract_Project_Maintenance:100]ActiveRRPts_L:24; v_100_026_aL; [Contract_Project_Maintenance:100]EvacRoutePts_L:26; *)
			ARRAY TO SELECTION:C261(v_100_021_ab; [Contract_Project_Maintenance:100]EmergRepl_b:21; v_100_023_ab; [Contract_Project_Maintenance:100]ActiveRR_b:23; v_100_025_ab; [Contract_Project_Maintenance:100]EvacRoute_b:25; *)
			ARRAY TO SELECTION:C261(v_100_029_ab; [Contract_Project_Maintenance:100]StagingAvail_b:29; v_100_030_ab; [Contract_Project_Maintenance:100]UtilRelocate_b:30; v_100_031_ab; [Contract_Project_Maintenance:100]BridgeClose_b:31; *)
			ARRAY TO SELECTION:C261(v_100_032_ab; [Contract_Project_Maintenance:100]ABCOver30_b:32; v_100_033_ab; [Contract_Project_Maintenance:100]PrefabDeliv_b:33; v_100_034_ab; [Contract_Project_Maintenance:100]PrefabJustif_b:34; *)
			ARRAY TO SELECTION:C261(v_100_035_ab; [Contract_Project_Maintenance:100]PrefabCostLess_b:35; v_100_037_ab; [Contract_Project_Maintenance:100]NeedSnowFence_b:37)
		End if 
	: ($1=101)  //Contract_Assignment_Maintenance
		$Array_Ptr:=->v_101_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_101_085_atxt; [Contract_Assignment_Maintenance:101]Contract_Assignment_M_UUIDKey_s:85; *)  //Contract_Assignment_M_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_101_003_aL; [Contract_Assignment_Maintenance:101]AssignID:3; *)
			
			ARRAY TO SELECTION:C261(v_101_001_atxt; [Contract_Assignment_Maintenance:101]ContractNo:1; v_101_004_atxt; [Contract_Assignment_Maintenance:101]ProjectIS:4; v_101_008_atxt; [Contract_Assignment_Maintenance:101]Consultant:8; *)
			ARRAY TO SELECTION:C261(v_101_019_atxt; [Contract_Assignment_Maintenance:101]Comments:19; v_101_020_atxt; [Contract_Assignment_Maintenance:101]AcutalOrEstimate:20; v_101_035_atxt; [Contract_Assignment_Maintenance:101]Description:35; *)
			ARRAY TO SELECTION:C261(v_101_036_atxt; [Contract_Assignment_Maintenance:101]ProjectType:36; v_101_037_atxt; [Contract_Assignment_Maintenance:101]ExtendedDesc_txt:37; v_101_041_atxt; [Contract_Assignment_Maintenance:101]InitialScope_d:41; *)
			ARRAY TO SELECTION:C261(v_101_052_atxt; [Contract_Assignment_Maintenance:101]ProjectStatus_s:52; v_101_053_atxt; [Contract_Assignment_Maintenance:101]Funding_s:53; v_101_060_atxt; [Contract_Assignment_Maintenance:101]SurveyBy_s:60; *)
			ARRAY TO SELECTION:C261(v_101_065_atxt; [Contract_Assignment_Maintenance:101]SubConsultants_txt:65; v_101_067_atxt; [Contract_Assignment_Maintenance:101]ConsultantScore_s:67; v_101_071_atxt; [Contract_Assignment_Maintenance:101]Comments_25_txt:71; *)
			ARRAY TO SELECTION:C261(v_101_072_atxt; [Contract_Assignment_Maintenance:101]Comments_90_txt:72; v_101_073_atxt; [Contract_Assignment_Maintenance:101]Comments_PSE_txt:73; v_101_075_atxt; [Contract_Assignment_Maintenance:101]ProjectColor_s:75; *)
			ARRAY TO SELECTION:C261(v_101_076_atxt; [Contract_Assignment_Maintenance:101]DesignerDesignation_s:76; v_101_077_atxt; [Contract_Assignment_Maintenance:101]DistrictPM_s:77; v_101_079_atxt; [Contract_Assignment_Maintenance:101]LateAction_s:79; *)
			ARRAY TO SELECTION:C261(v_101_083_atxt; [Contract_Assignment_Maintenance:101]ShopDwgComments_txt:83; *)
			ARRAY TO SELECTION:C261(v_101_005_ar; [Contract_Assignment_Maintenance:101]Overhead:5; v_101_006_ar; [Contract_Assignment_Maintenance:101]Fee:6; v_101_007_ar; [Contract_Assignment_Maintenance:101]Salary:7; *)
			ARRAY TO SELECTION:C261(v_101_009_ar; [Contract_Assignment_Maintenance:101]Actual_Total:9; v_101_010_ar; [Contract_Assignment_Maintenance:101]Est_Salary:10; v_101_011_ar; [Contract_Assignment_Maintenance:101]Est_IndirectCost:11; *)
			ARRAY TO SELECTION:C261(v_101_012_ar; [Contract_Assignment_Maintenance:101]Est_NetFee:12; v_101_013_ar; [Contract_Assignment_Maintenance:101]Est_TotalLimitFee:13; v_101_014_ar; [Contract_Assignment_Maintenance:101]Est_DirectExpense:14; *)
			ARRAY TO SELECTION:C261(v_101_015_ar; [Contract_Assignment_Maintenance:101]Est_Total:15; v_101_022_ar; [Contract_Assignment_Maintenance:101]Actual_Salary:22; v_101_023_ar; [Contract_Assignment_Maintenance:101]Actual_IndirectCost:23; *)
			ARRAY TO SELECTION:C261(v_101_024_ar; [Contract_Assignment_Maintenance:101]Actual_NetFee:24; v_101_025_ar; [Contract_Assignment_Maintenance:101]Actual_TotalLimitFee:25; v_101_026_ar; [Contract_Assignment_Maintenance:101]Actual_DirectExpense:26; *)
			ARRAY TO SELECTION:C261(v_101_027_ar; [Contract_Assignment_Maintenance:101]Est_ConstrSalary:27; v_101_028_ar; [Contract_Assignment_Maintenance:101]Est_ConstrIndirectCost:28; v_101_029_ar; [Contract_Assignment_Maintenance:101]Est_ConstrNetFee:29; *)
			ARRAY TO SELECTION:C261(v_101_030_ar; [Contract_Assignment_Maintenance:101]Est_ConstrTotalLimitFee:30; v_101_031_ar; [Contract_Assignment_Maintenance:101]Actual_ConstrSalary:31; v_101_032_ar; [Contract_Assignment_Maintenance:101]Actual_ConstrIndirectCost:32; *)
			ARRAY TO SELECTION:C261(v_101_033_ar; [Contract_Assignment_Maintenance:101]Actual_ConstrNetFee:33; v_101_034_ar; [Contract_Assignment_Maintenance:101]Actual_ConstrTotalLimitFee:34; v_101_045_ar; [Contract_Assignment_Maintenance:101]Est_TotalHRS_r:45; *)
			ARRAY TO SELECTION:C261(v_101_046_ar; [Contract_Assignment_Maintenance:101]AgreedTotalHRS_r:46; v_101_047_ar; [Contract_Assignment_Maintenance:101]AgreedTotalCost_r:47; v_101_048_ar; [Contract_Assignment_Maintenance:101]Est_ConstrCost_r:48; *)
			ARRAY TO SELECTION:C261(v_101_068_ar; [Contract_Assignment_Maintenance:101]OrigSub_HRS_r:68; v_101_069_ar; [Contract_Assignment_Maintenance:101]OrigSub_TotalLimFee_r:69; v_101_070_ar; [Contract_Assignment_Maintenance:101]OrigSub_DirectCost_r:70; *)
			ARRAY TO SELECTION:C261(v_101_002_ai; [Contract_Assignment_Maintenance:101]AssignNo:2; *)
			ARRAY TO SELECTION:C261(v_101_038_aL; [Contract_Assignment_Maintenance:101]ABPFlag_L:38; v_101_039_aL; [Contract_Assignment_Maintenance:101]ProjectManagerID_L:39; v_101_054_aL; [Contract_Assignment_Maintenance:101]Completed_L:54; *)
			ARRAY TO SELECTION:C261(v_101_016_ad; [Contract_Assignment_Maintenance:101]ReqFeeProposalDate:16; v_101_017_ad; [Contract_Assignment_Maintenance:101]NTPdate_written:17; v_101_018_ad; [Contract_Assignment_Maintenance:101]NTPdate_verbal:18; *)
			ARRAY TO SELECTION:C261(v_101_040_ad; [Contract_Assignment_Maintenance:101]InitialFieldVisit_d:40; v_101_042_ad; [Contract_Assignment_Maintenance:101]FieldVisitWConsult_d:42; v_101_043_ad; [Contract_Assignment_Maintenance:101]FinalScope_d:43; *)
			ARRAY TO SELECTION:C261(v_101_044_ad; [Contract_Assignment_Maintenance:101]FeeProposalRecd_d:44; v_101_049_ad; [Contract_Assignment_Maintenance:101]DocsSentToFAPO_d:49; v_101_050_ad; [Contract_Assignment_Maintenance:101]ExpectFirst25_d:50; *)
			ARRAY TO SELECTION:C261(v_101_051_ad; [Contract_Assignment_Maintenance:101]ExpectFirst90_d:51; v_101_056_ad; [Contract_Assignment_Maintenance:101]ScopeApprovedDistr_d:56; v_101_057_ad; [Contract_Assignment_Maintenance:101]ScopeApprovedPEng_d:57; *)
			ARRAY TO SELECTION:C261(v_101_058_ad; [Contract_Assignment_Maintenance:101]ExpectScope_d:58; v_101_061_ad; [Contract_Assignment_Maintenance:101]FeeProposalApprvd_d:61; v_101_062_ad; [Contract_Assignment_Maintenance:101]ExpectFirstPSE_d:62; *)
			ARRAY TO SELECTION:C261(v_101_064_ad; [Contract_Assignment_Maintenance:101]MylarSignedDate_d:64; v_101_066_ad; [Contract_Assignment_Maintenance:101]InspRptToCons_d:66; v_101_078_ad; [Contract_Assignment_Maintenance:101]DeadLine_d:78; *)
			ARRAY TO SELECTION:C261(v_101_080_ad; [Contract_Assignment_Maintenance:101]LateActionDate_d:80; v_101_081_ad; [Contract_Assignment_Maintenance:101]RatgRptReceived_d:81; v_101_082_ad; [Contract_Assignment_Maintenance:101]RatgRptToBIE_d:82; *)
			ARRAY TO SELECTION:C261(v_101_021_ab; [Contract_Assignment_Maintenance:101]SpecialAssignment:21; v_101_055_ab; [Contract_Assignment_Maintenance:101]FHWAOverSight_b:55; v_101_059_ab; [Contract_Assignment_Maintenance:101]SurveyNeeded_b:59; *)
			ARRAY TO SELECTION:C261(v_101_063_ab; [Contract_Assignment_Maintenance:101]MylarSigned_b:63; v_101_074_ab; [Contract_Assignment_Maintenance:101]PublicMtgNeeded_b:74; v_101_084_ab; [Contract_Assignment_Maintenance:101]Hidden_b:84)
		End if 
	: ($1=102)  //Addendum_Maintenance
		$Array_Ptr:=->v_102_005_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_102_026_atxt; [Addendum_Maintenance:102]Addendum_Maintenance_UUIDKey_s:26; *)  //Addendum_Maintenance_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_102_001_aL; [Addendum_Maintenance:102]AddendumID:1; *)
			
			ARRAY TO SELECTION:C261(v_102_005_atxt; [Addendum_Maintenance:102]ContractNo:5; v_102_019_atxt; [Addendum_Maintenance:102]Description:19; *)
			ARRAY TO SELECTION:C261(v_102_007_ar; [Addendum_Maintenance:102]Est_ConstrIndirectCost:7; v_102_008_ar; [Addendum_Maintenance:102]Est_ConstrNetFee:8; v_102_009_ar; [Addendum_Maintenance:102]Est_ConstrSalary:9; *)
			ARRAY TO SELECTION:C261(v_102_010_ar; [Addendum_Maintenance:102]Est_ConstrTotalLimitFee:10; v_102_011_ar; [Addendum_Maintenance:102]Est_DirectExpense:11; v_102_012_ar; [Addendum_Maintenance:102]Est_IndirectCost:12; *)
			ARRAY TO SELECTION:C261(v_102_013_ar; [Addendum_Maintenance:102]Est_NetFee:13; v_102_014_ar; [Addendum_Maintenance:102]Est_Salary:14; v_102_015_ar; [Addendum_Maintenance:102]Est_Total:15; *)
			ARRAY TO SELECTION:C261(v_102_016_ar; [Addendum_Maintenance:102]Est_TotalLimitFee:16; v_102_017_ar; [Addendum_Maintenance:102]Fee:17; v_102_018_ar; [Addendum_Maintenance:102]Overhead:18; *)
			ARRAY TO SELECTION:C261(v_102_020_ar; [Addendum_Maintenance:102]Est_HRS_r:20; v_102_021_ar; [Addendum_Maintenance:102]Appr_HRS_r:21; v_102_022_ar; [Addendum_Maintenance:102]Appr_TotalLimmitFee_r:22; *)
			ARRAY TO SELECTION:C261(v_102_023_ar; [Addendum_Maintenance:102]Appr_DirectExpense_r:23; *)
			ARRAY TO SELECTION:C261(v_102_002_ai; [Addendum_Maintenance:102]AddendumNo:2; v_102_004_ai; [Addendum_Maintenance:102]AssignNo:4; *)
			ARRAY TO SELECTION:C261(v_102_003_aL; [Addendum_Maintenance:102]AssignID:3; *)
			ARRAY TO SELECTION:C261(v_102_006_ad; [Addendum_Maintenance:102]DateCreated:6; v_102_024_ad; [Addendum_Maintenance:102]Submitted_d:24; v_102_025_ad; [Addendum_Maintenance:102]Approved_d:25)
		End if 
	: ($1=103)  //Work_Estimate
		$Array_Ptr:=->v_103_003_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_103_048_atxt; [Work_Estimate:103]Work_Estimate_UUIDKey_s:48; *)  //Work_Estimate_UUIDKey_s
			End if 
			If (clone_UseBlobArrays_B)
				ARRAY TO SELECTION:C261(v_103_005_ablb; [Work_Estimate:103]WkEstValues:5; v_103_032_ablb; [Work_Estimate:103]RestrictedItemList:32; v_103_039_ablb; [Work_Estimate:103]WkOrigEngEstVal_x:39; *)
				
			Else 
				clone_GetBlobs($1)
			End if 
			ARRAY TO SELECTION:C261(v_103_001_aL; [Work_Estimate:103]WKID:1; *)
			
			ARRAY TO SELECTION:C261(v_103_003_atxt; [Work_Estimate:103]ContractNo:3; v_103_004_atxt; [Work_Estimate:103]AssignDesc:4; v_103_006_atxt; [Work_Estimate:103]Consultant:6; *)
			ARRAY TO SELECTION:C261(v_103_021_atxt; [Work_Estimate:103]CompletedBy:21; v_103_022_atxt; [Work_Estimate:103]ApprovedBy:22; v_103_023_atxt; [Work_Estimate:103]Location:23; *)
			ARRAY TO SELECTION:C261(v_103_024_atxt; [Work_Estimate:103]CityTown:24; v_103_025_atxt; [Work_Estimate:103]BridgeNo:25; v_103_026_atxt; [Work_Estimate:103]ProjInfoNo:26; *)
			ARRAY TO SELECTION:C261(v_103_030_atxt; [Work_Estimate:103]ApproveCmts:30; v_103_031_atxt; [Work_Estimate:103]CompleteCmts:31; v_103_034_atxt; [Work_Estimate:103]ReviewedBy:34; *)
			ARRAY TO SELECTION:C261(v_103_035_atxt; [Work_Estimate:103]ReviewCmts:35; v_103_037_atxt; [Work_Estimate:103]CreatedBy:37; *)
			ARRAY TO SELECTION:C261(v_103_007_ar; [Work_Estimate:103]Cat1Rate:7; v_103_008_ar; [Work_Estimate:103]Cat2Rate:8; v_103_009_ar; [Work_Estimate:103]Cat3Rate:9; *)
			ARRAY TO SELECTION:C261(v_103_010_ar; [Work_Estimate:103]Cate4Rate:10; v_103_011_ar; [Work_Estimate:103]Cat5Rate:11; v_103_012_ar; [Work_Estimate:103]IndirectCostPct:12; *)
			ARRAY TO SELECTION:C261(v_103_013_ar; [Work_Estimate:103]NetFeePct:13; v_103_014_ar; [Work_Estimate:103]DirectExpenseD:14; v_103_015_ar; [Work_Estimate:103]SpecEngineeringD:15; *)
			ARRAY TO SELECTION:C261(v_103_027_ar; [Work_Estimate:103]DirectExpenseC:27; v_103_028_ar; [Work_Estimate:103]SpecEngineeringC:28; v_103_040_ar; [Work_Estimate:103]ConstCat1Rate:40; *)
			ARRAY TO SELECTION:C261(v_103_041_ar; [Work_Estimate:103]ConstCat2Rate:41; v_103_042_ar; [Work_Estimate:103]ConstCat3Rate:42; v_103_043_ar; [Work_Estimate:103]ConstCat4Rate:43; *)
			ARRAY TO SELECTION:C261(v_103_044_ar; [Work_Estimate:103]ConstCat5Rate:44; v_103_045_ar; [Work_Estimate:103]Cat6Rate:45; v_103_046_ar; [Work_Estimate:103]ConstCat6Rate:46; *)
			ARRAY TO SELECTION:C261(v_103_016_ai; [Work_Estimate:103]AssignNo:16; v_103_018_ai; [Work_Estimate:103]WkHrEstApproved:18; v_103_029_ai; [Work_Estimate:103]AddendumNo:29; *)
			ARRAY TO SELECTION:C261(v_103_033_ai; [Work_Estimate:103]WkHrEstReviewed:33; *)
			ARRAY TO SELECTION:C261(v_103_002_aL; [Work_Estimate:103]AssignID:2; v_103_047_aL; [Work_Estimate:103]Version_L:47; *)
			ARRAY TO SELECTION:C261(v_103_019_ad; [Work_Estimate:103]ApprovedDate:19; v_103_020_ad; [Work_Estimate:103]CompleteDate:20; v_103_036_ad; [Work_Estimate:103]ReviewDate:36; *)
			ARRAY TO SELECTION:C261(v_103_038_ad; [Work_Estimate:103]CreatedDate:38; *)
			ARRAY TO SELECTION:C261(v_103_017_ab; [Work_Estimate:103]WkHrEstComplete:17)
		End if 
	: ($1=104)  //WorkHour_Config
		$Array_Ptr:=->v_104_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_104_003_atxt; [WorkHour_Config:104]WorkHour_Config_UUIDKey_s:3; *)  //WorkHour_Config_UUIDKey_s
			End if 
			If (clone_UseBlobArrays_B)
				ARRAY TO SELECTION:C261(v_104_001_ablb; [WorkHour_Config:104]ConfigArrays:1; *)
			Else 
				clone_GetBlobs($1)
			End if 
			ARRAY TO SELECTION:C261(v_104_002_atxt; [WorkHour_Config:104]AssignType:2)
			
			
		End if 
	: ($1=105)  //WorkHour_Summary
		$Array_Ptr:=->v_105_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_105_011_atxt; [WorkHour_Summary:105]WorkHour_Summary_UUIDKey_s:11; *)  //WorkHour_Summary_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_105_001_atxt; [WorkHour_Summary:105]ProjType:1; *)
			ARRAY TO SELECTION:C261(v_105_002_ai; [WorkHour_Summary:105]ItemID:2; *)
			ARRAY TO SELECTION:C261(v_105_003_aL; [WorkHour_Summary:105]AvgCol1:3; v_105_004_aL; [WorkHour_Summary:105]AvgCol2:4; v_105_005_aL; [WorkHour_Summary:105]AvgCol3:5; *)
			ARRAY TO SELECTION:C261(v_105_006_aL; [WorkHour_Summary:105]AvgCol4:6; v_105_007_aL; [WorkHour_Summary:105]AvgCol5:7; v_105_008_aL; [WorkHour_Summary:105]AvgSum:8; *)
			ARRAY TO SELECTION:C261(v_105_009_aL; [WorkHour_Summary:105]AvgCol6:9; v_105_010_aL; [WorkHour_Summary:105]Field10:10)
		End if 
	: ($1=106)  //zSpecialReports
		$Array_Ptr:=->v_106_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_106_008_atxt; [zSpecialReports:106]zSpecialReports_UUIDKey_s:8; *)  //zSpecialReports_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_106_007_aL; [zSpecialReports:106]Record_ID:7; *)
			
			ARRAY TO SELECTION:C261(v_106_001_atxt; [zSpecialReports:106]Purpose:1; v_106_002_atxt; [zSpecialReports:106]ReportName:2; v_106_003_atxt; [zSpecialReports:106]MethodName:3; *)
			ARRAY TO SELECTION:C261(v_106_004_atxt; [zSpecialReports:106]LongDescription:4; v_106_005_atxt; [zSpecialReports:106]SubCategory:5; v_106_006_atxt; [zSpecialReports:106]CreatedBy:6)
		End if 
	: ($1=107)  //Parameters
		$Array_Ptr:=->v_107_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_107_005_atxt; [Parameters:107]Parameters_UUIDKey_s:5; *)  //Parameters_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_107_001_atxt; [Parameters:107]ParamCode:1; *)
			
			ARRAY TO SELECTION:C261(v_107_002_atxt; [Parameters:107]Description:2; v_107_003_atxt; [Parameters:107]Value:3; *)
			ARRAY TO SELECTION:C261(v_107_004_ai; [Parameters:107]ParamType:4)
		End if 
	: ($1=108)  //ScourPriorityRank
		$Array_Ptr:=->v_108_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_108_007_atxt; [ScourPriorityRank:108]ScourPriorityRank_UUIDKey_s:7; *)  //ScourPriorityRank_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_108_001_atxt; [ScourPriorityRank:108]BIN:1; *)
			
			ARRAY TO SELECTION:C261(v_108_005_atxt; [ScourPriorityRank:108]Category:5; *)
			ARRAY TO SELECTION:C261(v_108_002_ar; [ScourPriorityRank:108]FailureProb:2; v_108_003_ar; [ScourPriorityRank:108]FailureCost:3; v_108_004_ar; [ScourPriorityRank:108]LifeTimeRisk:4; *)
			ARRAY TO SELECTION:C261(v_108_006_aL; [ScourPriorityRank:108]Rank:6)
		End if 
	: ($1=109)  //PERS_Groups
		$Array_Ptr:=->v_109_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_109_005_atxt; [PERS_Groups:109]PERS_Groups_UUIDKey_s:5; *)  //PERS_Groups_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_109_002_atxt; [PERS_Groups:109]PERS_GroupName_s:2; v_109_001_ai; [PERS_Groups:109]PERS_GroupID_I:1; *)
			
			ARRAY TO SELECTION:C261(v_109_006_atxt; [PERS_Groups:109]PERS_ActingTitle:6; *)
			ARRAY TO SELECTION:C261(v_109_003_ai; [PERS_Groups:109]PERS_Acting:3; v_109_004_ai; [PERS_Groups:109]PERS_Primary:4)
		End if 
	: ($1=110)  //PERS_GroupMembers
		$Array_Ptr:=->v_110_001_ai
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_110_003_atxt; [PERS_GroupMembers:110]PERS_GroupMembers_UUIDKey_s:3; *)  //PERS_GroupMembers_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_110_001_ai; [PERS_GroupMembers:110]GroupID_I:1; v_110_002_ai; [PERS_GroupMembers:110]PersonID_I:2)
		End if 
	: ($1=111)  //CM_ExtTimeFYAlloc
		$Array_Ptr:=->v_111_003_ar
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_111_005_atxt; [CM_ExtTimeFYAlloc:111]CM_ExtTimeFYAlloc_UUIDKey_s:5; *)  //CM_ExtTimeFYAlloc_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_111_001_aL; [CM_ExtTimeFYAlloc:111]ExtTimeFYAllocID_L:1; *)
			
			ARRAY TO SELECTION:C261(v_111_003_ar; [CM_ExtTimeFYAlloc:111]FYAmmount_R:3; *)
			ARRAY TO SELECTION:C261(v_111_004_ai; [CM_ExtTimeFYAlloc:111]FYear_I:4; *)
			ARRAY TO SELECTION:C261(v_111_002_aL; [CM_ExtTimeFYAlloc:111]EOT_ID_L:2)
		End if 
	: ($1=112)  //InventoryPhotoInsp
		$Array_Ptr:=->v_112_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_112_011_atxt; [InventoryPhotoInsp:112]InventoryPhotoInsp_UUIDKey_s:11; *)  //InventoryPhotoInsp_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_112_001_aL; [InventoryPhotoInsp:112]InvPhotoInspID_L:1; *)
			
			ARRAY TO SELECTION:C261(v_112_002_atxt; [InventoryPhotoInsp:112]BIN:2; v_112_007_atxt; [InventoryPhotoInsp:112]ApproveComments_txt:7; *)
			ARRAY TO SELECTION:C261(v_112_005_ai; [InventoryPhotoInsp:112]TeamLeader_I:5; v_112_006_ai; [InventoryPhotoInsp:112]Approved_I:6; v_112_010_ai; [InventoryPhotoInsp:112]TeamMember_I:10; *)
			ARRAY TO SELECTION:C261(v_112_003_ad; [InventoryPhotoInsp:112]InvPhotoDate_D:3; v_112_008_ad; [InventoryPhotoInsp:112]ApproveDate_D:8; *)
			ARRAY TO SELECTION:C261(v_112_004_ab; [InventoryPhotoInsp:112]OrientationNS_b:4; v_112_009_ab; [InventoryPhotoInsp:112]Complete_B:9)
		End if 
	: ($1=113)  //InventoryPhotos
		$Array_Ptr:=->v_113_003_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_113_006_atxt; [InventoryPhotos:113]InventoryPhotos_UUIDKey_s:6; *)  //InventoryPhotos_UUIDKey_s
			End if 
			If (clone_UseBlobArrays_B)
				ARRAY TO SELECTION:C261(v_113_004_ablb; [InventoryPhotos:113]InvPhoto_X:4; *)
			Else 
				clone_GetBlobs($1)
			End if 
			ARRAY TO SELECTION:C261(v_113_001_aL; [InventoryPhotos:113]InvPhoto_ID:1; *)
			
			ARRAY TO SELECTION:C261(v_113_003_atxt; [InventoryPhotos:113]PhotoDescr_txt:3; *)
			ARRAY TO SELECTION:C261(v_113_005_ai; [InventoryPhotos:113]Sequence_I:5; *)
			ARRAY TO SELECTION:C261(v_113_002_aL; [InventoryPhotos:113]InvPhotoInsp_ID:2)
		End if 
	: ($1=114)  //PRJ_Contractor
		$Array_Ptr:=->v_114_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_114_004_atxt; [PRJ_Contractor:114]PRJ_Contractor_UUIDKey_s:4; *)  //PRJ_Contractor_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_114_001_aL; [PRJ_Contractor:114]CTR_ContractorID_l:1; *)
			
			ARRAY TO SELECTION:C261(v_114_002_atxt; [PRJ_Contractor:114]CTR_CompanyName_s:2; v_114_003_atxt; [PRJ_Contractor:114]CTR_VendorCode_s:3)
		End if 
	: ($1=115)  //PRJ_ProjectDetails
		$Array_Ptr:=->v_115_004_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_115_055_atxt; [PRJ_ProjectDetails:115]PRJ_ProjectDetails_UUIDKey_s:55; *)  //PRJ_ProjectDetails_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_115_001_aL; [PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; *)
			
			ARRAY TO SELECTION:C261(v_115_004_atxt; [PRJ_ProjectDetails:115]PRJ_ProjectType_s:4; v_115_005_atxt; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; v_115_007_atxt; [PRJ_ProjectDetails:115]PRJ_NonBridge_s:7; *)
			ARRAY TO SELECTION:C261(v_115_008_atxt; [PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; v_115_009_atxt; [PRJ_ProjectDetails:115]PRJ_LastActionDescription_txt:9; v_115_010_atxt; [PRJ_ProjectDetails:115]PRJ_Comments_txt:10; *)
			ARRAY TO SELECTION:C261(v_115_013_atxt; [PRJ_ProjectDetails:115]PRJ_BridgeDataSheetComplete_s:13; v_115_023_atxt; [PRJ_ProjectDetails:115]PRJ_Program_s:23; v_115_025_atxt; [PRJ_ProjectDetails:115]PRJ_FederalAid_s:25; *)
			ARRAY TO SELECTION:C261(v_115_026_atxt; [PRJ_ProjectDetails:115]PRJ_BinUpdateRequest_s:26; v_115_030_atxt; [PRJ_ProjectDetails:115]PRJ_ApprovedType_s:30; v_115_031_atxt; [PRJ_ProjectDetails:115]PRJ_EnteredConstructionEWO_s:31; *)
			ARRAY TO SELECTION:C261(v_115_032_atxt; [PRJ_ProjectDetails:115]PRJ_GroupBy_s:32; v_115_033_atxt; [PRJ_ProjectDetails:115]PRJ_Slot_s:33; v_115_034_atxt; [PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34; *)
			ARRAY TO SELECTION:C261(v_115_035_atxt; [PRJ_ProjectDetails:115]PRJ_Status_s:35; v_115_036_atxt; [PRJ_ProjectDetails:115]PRJ_BeamUnitType_s:36; v_115_040_atxt; [PRJ_ProjectDetails:115]PRJ_NonBridgeNotes_txt:40; *)
			ARRAY TO SELECTION:C261(v_115_043_atxt; [PRJ_ProjectDetails:115]PRJ_EnteredDesignEWO_s:43; v_115_044_atxt; [PRJ_ProjectDetails:115]PRJ_BridgeSectResp_s:44; v_115_046_atxt; [PRJ_ProjectDetails:115]PRJ_ModifiedBy_s:46; *)
			ARRAY TO SELECTION:C261(v_115_047_atxt; [PRJ_ProjectDetails:115]PRJ_ModifiedTimeStamp_s:47; *)
			ARRAY TO SELECTION:C261(v_115_027_ar; [PRJ_ProjectDetails:115]PRJ_BeamCost_r:27; v_115_029_ar; [PRJ_ProjectDetails:115]PRJ_Item995_r:29; *)
			ARRAY TO SELECTION:C261(v_115_002_aL; [PRJ_ProjectDetails:115]CP_ConstructionProjectID_l:2; v_115_003_aL; [PRJ_ProjectDetails:115]PF_FileID_l:3; v_115_028_aL; [PRJ_ProjectDetails:115]PRJ_BeamUnit_l:28; *)
			ARRAY TO SELECTION:C261(v_115_039_aL; [PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39; v_115_045_aL; [PRJ_ProjectDetails:115]PRJ_MeetingPageNo_l:45; v_115_053_aL; [PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53; *)
			ARRAY TO SELECTION:C261(v_115_054_aL; [PRJ_ProjectDetails:115]DC_DesignContractID_l:54; *)
			ARRAY TO SELECTION:C261(v_115_012_ad; [PRJ_ProjectDetails:115]PRJ_DesignApproval_d:12; v_115_014_ad; [PRJ_ProjectDetails:115]PRJ_RequestFinalPrints_d:14; v_115_016_ad; [PRJ_ProjectDetails:115]PRJ_RequestForMylars_d:16; *)
			ARRAY TO SELECTION:C261(v_115_018_ad; [PRJ_ProjectDetails:115]PRJ_BridgeMylarSigned_d:18; v_115_019_ad; [PRJ_ProjectDetails:115]PRJ_SpecsRecAtBlueprint_d:19; v_115_020_ad; [PRJ_ProjectDetails:115]PRJ_SentToExpediting_d:20; *)
			ARRAY TO SELECTION:C261(v_115_021_ad; [PRJ_ProjectDetails:115]PRJ_ConstructionCompletion_d:21; v_115_022_ad; [PRJ_ProjectDetails:115]PRJ_LumpSumBreakDown_d:22; v_115_024_ad; [PRJ_ProjectDetails:115]PRJ_NTP_d:24; *)
			ARRAY TO SELECTION:C261(v_115_037_ad; [PRJ_ProjectDetails:115]PRJ_Completion_d:37; v_115_038_ad; [PRJ_ProjectDetails:115]PRJ_RatingRequest_d:38; v_115_041_ad; [PRJ_ProjectDetails:115]PRJ_ScopeReceived_d:41; *)
			ARRAY TO SELECTION:C261(v_115_048_ad; [PRJ_ProjectDetails:115]PRJ_FHWASketchSubmit_d:48; v_115_049_ad; [PRJ_ProjectDetails:115]PRJ_FHWASketchApproved_d:49; v_115_050_ad; [PRJ_ProjectDetails:115]PRJ_FHWAPSESubmit_d:50; *)
			ARRAY TO SELECTION:C261(v_115_051_ad; [PRJ_ProjectDetails:115]PRJ_FHWAPSEApproved_d:51; *)
			ARRAY TO SELECTION:C261(v_115_006_ab; [PRJ_ProjectDetails:115]PRJ_TemporaryBridge_b:6; v_115_011_ab; [PRJ_ProjectDetails:115]PRJ_DesignApproved_b:11; v_115_015_ab; [PRJ_ProjectDetails:115]PRJ_ReviewByBridgeEng_b:15; *)
			ARRAY TO SELECTION:C261(v_115_017_ab; [PRJ_ProjectDetails:115]PRJ_BridgeMylarSigned_b:17; v_115_042_ab; [PRJ_ProjectDetails:115]PRJ_FederalReviewRequired_b:42; v_115_052_ab; [PRJ_ProjectDetails:115]PRJ_Chapter85_b:52)
		End if 
	: ($1=116)  //PRJ_ConstructionProject
		$Array_Ptr:=->v_116_005_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_116_029_atxt; [PRJ_ConstructionProject:116]PRJ_ConstructionProje_UUIDKey_s:29; *)  //PRJ_ConstructionProje_UUIDKey_s
			End if 
			If (clone_UseBlobArrays_B)
				ARRAY TO SELECTION:C261(v_116_021_ablb; [PRJ_ConstructionProject:116]CP_AEData_blb:21; *)
			Else 
				clone_GetBlobs($1)
			End if 
			ARRAY TO SELECTION:C261(v_116_001_aL; [PRJ_ConstructionProject:116]CP_ConstructionProjectID_l:1; *)
			
			ARRAY TO SELECTION:C261(v_116_005_atxt; [PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5; v_116_009_atxt; [PRJ_ConstructionProject:116]CP_EWO_s:9; *)
			ARRAY TO SELECTION:C261(v_116_022_atxt; [PRJ_ConstructionProject:116]CP_AEDescription_txt:22; v_116_023_atxt; [PRJ_ConstructionProject:116]CP_AELocation_s:23; v_116_024_atxt; [PRJ_ConstructionProject:116]CP_FederalAidNo_s:24; *)
			ARRAY TO SELECTION:C261(v_116_006_ar; [PRJ_ConstructionProject:116]CP_BidEstimate_r:6; v_116_007_ar; [PRJ_ConstructionProject:116]CP_LowBid_r:7; v_116_019_ar; [PRJ_ConstructionProject:116]CP_LowBid_2_r:19; *)
			ARRAY TO SELECTION:C261(v_116_025_ar; [PRJ_ConstructionProject:116]CP_Encumbered_r:25; v_116_026_ar; [PRJ_ConstructionProject:116]CP_Spent_r:26; v_116_027_ar; [PRJ_ConstructionProject:116]CP_Remaining_r:27; *)
			ARRAY TO SELECTION:C261(v_116_002_aL; [PRJ_ConstructionProject:116]CTR_ContractorID_l:2; v_116_011_aL; [PRJ_ConstructionProject:116]PF_FileID_l:11; v_116_013_aL; [PRJ_ConstructionProject:116]CP_SQLID_l:13; *)
			ARRAY TO SELECTION:C261(v_116_020_aL; [PRJ_ConstructionProject:116]CP_LowBidder_2_l:20; *)
			ARRAY TO SELECTION:C261(v_116_003_ad; [PRJ_ConstructionProject:116]CP_BidOpening_d:3; v_116_004_ad; [PRJ_ConstructionProject:116]CP_Awarded_d:4; v_116_008_ad; [PRJ_ConstructionProject:116]CP_Completion_d:8; *)
			ARRAY TO SELECTION:C261(v_116_012_ad; [PRJ_ConstructionProject:116]CP_NTP_d:12; v_116_014_ad; [PRJ_ConstructionProject:116]CP_SpecsToPrint_d:14; v_116_015_ad; [PRJ_ConstructionProject:116]CP_SpecsFromPrint_d:15; *)
			ARRAY TO SELECTION:C261(v_116_016_ad; [PRJ_ConstructionProject:116]CP_PlansToPrint_d:16; v_116_017_ad; [PRJ_ConstructionProject:116]CP_PlansFromPrint_d:17; v_116_018_ad; [PRJ_ConstructionProject:116]CP_ToCashier_d:18; *)
			ARRAY TO SELECTION:C261(v_116_028_ad; [PRJ_ConstructionProject:116]AEAward_d:28; *)
			ARRAY TO SELECTION:C261(v_116_010_ab; [PRJ_ConstructionProject:116]CP_FromSQL_b:10)
		End if 
	: ($1=117)  //PRJ_ProjectFile
		$Array_Ptr:=->v_117_004_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_117_025_atxt; [PRJ_ProjectFile:117]PRJ_ProjectFile_UUIDKey_s:25; *)  //PRJ_ProjectFile_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_117_001_aL; [PRJ_ProjectFile:117]PF_FileID_l:1; v_117_003_aL; [PRJ_ProjectFile:117]PF_FileNumber_l:3; *)
			
			ARRAY TO SELECTION:C261(v_117_004_atxt; [PRJ_ProjectFile:117]PF_EWO_s:4; v_117_006_atxt; [PRJ_ProjectFile:117]PF_ProjectExpediter_s:6; v_117_007_atxt; [PRJ_ProjectFile:117]PF_TIP_s:7; *)
			ARRAY TO SELECTION:C261(v_117_016_atxt; [PRJ_ProjectFile:117]PF_Description_txt:16; v_117_017_atxt; [PRJ_ProjectFile:117]PF_TypeCode_s:17; v_117_021_atxt; [PRJ_ProjectFile:117]PF_PNFEvent_s:21; *)
			ARRAY TO SELECTION:C261(v_117_022_atxt; [PRJ_ProjectFile:117]PF_PIFEvent_s:22; v_117_023_atxt; [PRJ_ProjectFile:117]PF_PRCEvent_s:23; *)
			ARRAY TO SELECTION:C261(v_117_008_ar; [PRJ_ProjectFile:117]PF_InitialBidEstimate_r:8; v_117_009_ar; [PRJ_ProjectFile:117]PF_CostAd_r:9; v_117_010_ar; [PRJ_ProjectFile:117]PF_EstTotalCost_r:10; *)
			ARRAY TO SELECTION:C261(v_117_013_ar; [PRJ_ProjectFile:117]PF_OfficeEstimate_r:13; *)
			ARRAY TO SELECTION:C261(v_117_002_aL; [PRJ_ProjectFile:117]DC_OLDDesignContractID_l:2; v_117_015_aL; [PRJ_ProjectFile:117]PF_OLDConsultantOverideID_l:15; *)
			ARRAY TO SELECTION:C261(v_117_005_ad; [PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5; v_117_012_ad; [PRJ_ProjectFile:117]PF_BidOpened_d:12; v_117_014_ad; [PRJ_ProjectFile:117]PF_Advertised_d:14; *)
			ARRAY TO SELECTION:C261(v_117_018_ad; [PRJ_ProjectFile:117]PF_PNFDate_d:18; v_117_019_ad; [PRJ_ProjectFile:117]PF_PIFDate_d:19; v_117_020_ad; [PRJ_ProjectFile:117]PF_PRCApprDate_d:20; *)
			ARRAY TO SELECTION:C261(v_117_024_ad; [PRJ_ProjectFile:117]PF_PRCSubmDate_d:24; *)
			ARRAY TO SELECTION:C261(v_117_011_ab; [PRJ_ProjectFile:117]PF_FromSQL_b:11)
		End if 
	: ($1=118)  //PRJ_ReportData
		$Array_Ptr:=->v_118_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_118_010_atxt; [PRJ_ReportData:118]PRJ_ReportData_UUIDKey_s:10; *)  //PRJ_ReportData_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_118_002_atxt; [PRJ_ReportData:118]RPT_ReportType_s:2; v_118_005_atxt; [PRJ_ReportData:118]RPT_ApprovedBy_s:5; v_118_006_atxt; [PRJ_ReportData:118]RPT_Comments_txt:6; *)
			ARRAY TO SELECTION:C261(v_118_007_atxt; [PRJ_ReportData:118]RPT_Source_s:7; v_118_008_atxt; [PRJ_ReportData:118]RPT_ModifiedBy_s:8; v_118_009_atxt; [PRJ_ReportData:118]RPT_ModifiedTimeStamp_s:9; *)
			ARRAY TO SELECTION:C261(v_118_001_aL; [PRJ_ReportData:118]PRJ_ProjectID_l:1; *)
			ARRAY TO SELECTION:C261(v_118_003_ad; [PRJ_ReportData:118]RPT_Received_d:3; v_118_004_ad; [PRJ_ReportData:118]RPT_Approved_d:4)
		End if 
	: ($1=119)  //PRJ_StructuralReview
		$Array_Ptr:=->v_119_005_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_119_011_atxt; [PRJ_StructuralReview:119]PRJ_StructuralReview_UUIDKey_s:11; *)  //PRJ_StructuralReview_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_119_005_atxt; [PRJ_StructuralReview:119]SR_Comments_txt:5; v_119_008_atxt; [PRJ_StructuralReview:119]SR_ModifiedBy_s:8; v_119_009_atxt; [PRJ_StructuralReview:119]SR_ModifiedTimeStamp_s:9; *)
			ARRAY TO SELECTION:C261(v_119_001_aL; [PRJ_StructuralReview:119]PRJ_ProjectID_l:1; v_119_002_aL; [PRJ_StructuralReview:119]RV_ReviewID_l:2; v_119_003_aL; [PRJ_StructuralReview:119]SR_StructureReviewOrder_l:3; *)
			ARRAY TO SELECTION:C261(v_119_010_aL; [PRJ_StructuralReview:119]SR_GradingStatus_l:10; *)
			ARRAY TO SELECTION:C261(v_119_004_ad; [PRJ_StructuralReview:119]SR_CommentsToDesigner_d:4; v_119_006_ad; [PRJ_StructuralReview:119]SR_Assigned_d:6; v_119_007_ad; [PRJ_StructuralReview:119]SR_Received_d:7)
		End if 
	: ($1=120)  //PRJ_SketchPlans
		$Array_Ptr:=->v_120_004_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_120_017_atxt; [PRJ_SketchPlans:120]PRJ_SketchPlans_UUIDKey_s:17; *)  //PRJ_SketchPlans_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_120_004_atxt; [PRJ_SketchPlans:120]SKT_Comments_txt:4; v_120_014_atxt; [PRJ_SketchPlans:120]SKT_ModifiedBy_s:14; v_120_015_atxt; [PRJ_SketchPlans:120]SKT_ModifiedTimeStamp_s:15; *)
			ARRAY TO SELECTION:C261(v_120_001_aL; [PRJ_SketchPlans:120]PRJ_ProjectID_l:1; v_120_002_aL; [PRJ_SketchPlans:120]RV_ReviewID_l:2; v_120_003_aL; [PRJ_SketchPlans:120]SKT_SubmissionNumber_l:3; *)
			ARRAY TO SELECTION:C261(v_120_016_aL; [PRJ_SketchPlans:120]SKT_GradingStatus_l:16; *)
			ARRAY TO SELECTION:C261(v_120_005_ad; [PRJ_SketchPlans:120]SKT_Recieved_d:5; v_120_006_ad; [PRJ_SketchPlans:120]SKT_Assigned_d:6; v_120_007_ad; [PRJ_SketchPlans:120]SKT_AssToGeotech_d:7; *)
			ARRAY TO SELECTION:C261(v_120_008_ad; [PRJ_SketchPlans:120]SKT_AssToHydro_d:8; v_120_009_ad; [PRJ_SketchPlans:120]SKT_ReceivedFromGeotech_d:9; v_120_010_ad; [PRJ_SketchPlans:120]SKT_ReceivedFromHydro_d:10; *)
			ARRAY TO SELECTION:C261(v_120_011_ad; [PRJ_SketchPlans:120]SKT_CommentsToDE_d:11; v_120_012_ad; [PRJ_SketchPlans:120]SKT_DistributionForSignature_d:12; v_120_013_ad; [PRJ_SketchPlans:120]SKT_ChiefEngApproval_d:13)
		End if 
	: ($1=121)  //PRJ_TypeStudy
		$Array_Ptr:=->v_121_003_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_121_016_atxt; [PRJ_TypeStudy:121]PRJ_TypeStudy_UUIDKey_s:16; *)  //PRJ_TypeStudy_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_121_003_atxt; [PRJ_TypeStudy:121]TYP_StudyType_s:3; v_121_004_atxt; [PRJ_TypeStudy:121]TYP_StructureType_s:4; v_121_006_atxt; [PRJ_TypeStudy:121]TYP_Source_s:6; *)
			ARRAY TO SELECTION:C261(v_121_012_atxt; [PRJ_TypeStudy:121]TYP_Comments_txt:12; v_121_013_atxt; [PRJ_TypeStudy:121]TYP_ModifiedBy_s:13; v_121_014_atxt; [PRJ_TypeStudy:121]TYP_ModifiedTimeStamp_s:14; *)
			ARRAY TO SELECTION:C261(v_121_001_aL; [PRJ_TypeStudy:121]PRJ_ProjectID_l:1; v_121_002_aL; [PRJ_TypeStudy:121]RV_ReviewID_l:2; v_121_015_aL; [PRJ_TypeStudy:121]TYP_GradingStatus_l:15; *)
			ARRAY TO SELECTION:C261(v_121_005_ad; [PRJ_TypeStudy:121]TYP_Received_d:5; v_121_007_ad; [PRJ_TypeStudy:121]TYP_Distribution_d:7; v_121_008_ad; [PRJ_TypeStudy:121]TYP_RecFromHydro_d:8; *)
			ARRAY TO SELECTION:C261(v_121_009_ad; [PRJ_TypeStudy:121]TYP_RecFromGeotech_d:9; v_121_010_ad; [PRJ_TypeStudy:121]TYP_Approved_d:10; v_121_011_ad; [PRJ_TypeStudy:121]TYP_CommentsToDE_d:11)
		End if 
	: ($1=122)  //PRJ_ProjectDetailsIncludedBINS
		$Array_Ptr:=->v_122_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_122_007_atxt; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectDetailsInc_UUIDKey_s:7; *)  //PRJ_ProjectDetailsInc_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_122_002_atxt; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; v_122_003_atxt; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BDEPT_s:3; *)
			ARRAY TO SELECTION:C261(v_122_001_aL; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1; v_122_006_aL; [PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6; *)
			ARRAY TO SELECTION:C261(v_122_005_ad; [PRJ_ProjectDetailsIncludedBINS:122]PDB_Date_d:5; *)
			ARRAY TO SELECTION:C261(v_122_004_ab; [PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4)
		End if 
	: ($1=123)  //PRJ_DesignContracts
		$Array_Ptr:=->v_123_004_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_123_018_atxt; [PRJ_DesignContracts:123]PRJ_DesignContracts_UUIDKey_s:18; *)  //PRJ_DesignContracts_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_123_001_aL; [PRJ_DesignContracts:123]DC_DesignContractID_l:1; *)
			
			ARRAY TO SELECTION:C261(v_123_004_atxt; [PRJ_DesignContracts:123]DC_Description_txt:4; v_123_009_atxt; [PRJ_DesignContracts:123]DC_ProgramType_s:9; v_123_013_atxt; [PRJ_DesignContracts:123]DC_ContractManager_s:13; *)
			ARRAY TO SELECTION:C261(v_123_014_atxt; [PRJ_DesignContracts:123]DC_ContrTypeDesc_s:14; v_123_015_atxt; [PRJ_DesignContracts:123]DC_ContrFedAidNos_s:15; v_123_016_atxt; [PRJ_DesignContracts:123]DC_ContractStatus_s:16; *)
			ARRAY TO SELECTION:C261(v_123_005_ar; [PRJ_DesignContracts:123]DC_ProjectInfoAmount_r:5; v_123_006_ar; [PRJ_DesignContracts:123]DC_ActualAmount_r:6; v_123_007_ar; [PRJ_DesignContracts:123]DC_RemainingAmount_r:7; *)
			ARRAY TO SELECTION:C261(v_123_010_ar; [PRJ_DesignContracts:123]DC_ESTContractAmt_r:10; *)
			ARRAY TO SELECTION:C261(v_123_002_aL; [PRJ_DesignContracts:123]ConsultantNameID_l:2; v_123_003_aL; [PRJ_DesignContracts:123]DC_DesignContractNumber_l:3; v_123_017_aL; [PRJ_DesignContracts:123]DC_SQLContractID_l:17; *)
			ARRAY TO SELECTION:C261(v_123_008_ad; [PRJ_DesignContracts:123]DC_Completion_d:8; v_123_011_ad; [PRJ_DesignContracts:123]DC_EstComplete_d:11; *)
			ARRAY TO SELECTION:C261(v_123_012_ab; [PRJ_DesignContracts:123]DC_FromSQL_b:12)
		End if 
	: ($1=124)  //PRJ_ProjectTimeTracking
		$Array_Ptr:=->v_124_005_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_124_012_atxt; [PRJ_ProjectTimeTracking:124]PRJ_ProjectTimeTracki_UUIDKey_s:12; *)  //PRJ_ProjectTimeTracki_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_124_001_aL; [PRJ_ProjectTimeTracking:124]PT_TimeTrackingID_l:1; *)
			
			ARRAY TO SELECTION:C261(v_124_005_atxt; [PRJ_ProjectTimeTracking:124]PT_Coments_txt:5; v_124_008_atxt; [PRJ_ProjectTimeTracking:124]PT_EWO_s:8; v_124_009_atxt; [PRJ_ProjectTimeTracking:124]PT_ModifiedBy_s:9; *)
			ARRAY TO SELECTION:C261(v_124_010_atxt; [PRJ_ProjectTimeTracking:124]PT_ModifiedTimeStamp_s:10; v_124_011_atxt; [PRJ_ProjectTimeTracking:124]PT_Scope_s:11; *)
			ARRAY TO SELECTION:C261(v_124_006_ar; [PRJ_ProjectTimeTracking:124]PT_Hours_r:6; v_124_007_ar; [PRJ_ProjectTimeTracking:124]PT_HourlyRate_r:7; *)
			ARRAY TO SELECTION:C261(v_124_003_ai; [PRJ_ProjectTimeTracking:124]Person ID:3; *)
			ARRAY TO SELECTION:C261(v_124_002_aL; [PRJ_ProjectTimeTracking:124]PRJ_ProjectID_l:2; *)
			ARRAY TO SELECTION:C261(v_124_004_ad; [PRJ_ProjectTimeTracking:124]PT_WeekEnding_d:4)
		End if 
	: ($1=125)  //TableOfLists
		$Array_Ptr:=->v_125_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_125_005_atxt; [TableOfLists:125]TableOfLists_UUIDKey_s:5; *)  //TableOfLists_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_125_004_aL; [TableOfLists:125]ListKeyID_L:4; *)
			
			ARRAY TO SELECTION:C261(v_125_001_atxt; [TableOfLists:125]ListName_s:1; v_125_002_atxt; [TableOfLists:125]ListValue_s:2; *)
			ARRAY TO SELECTION:C261(v_125_003_aL; [TableOfLists:125]ListSequence_l:3)
		End if 
	: ($1=126)  //SQL_Connections
		$Array_Ptr:=->v_126_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_126_007_atxt; [SQL_Connections:126]SQL_Connections_UUIDKey_s:7; *)  //SQL_Connections_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_126_001_atxt; [SQL_Connections:126]SQL_DatabaseName_s:1; v_126_002_atxt; [SQL_Connections:126]SQL_UserName_s:2; v_126_003_atxt; [SQL_Connections:126]SQL_Password_s:3; *)
			ARRAY TO SELECTION:C261(v_126_004_atxt; [SQL_Connections:126]SQL_OBDCName_s:4; v_126_006_atxt; [SQL_Connections:126]SQL_SCHEMA_s:6; *)
			ARRAY TO SELECTION:C261(v_126_005_ad; [SQL_Connections:126]SQL_LastUpdate_d:5)
		End if 
	: ($1=127)  //Conslt_Name
		$Array_Ptr:=->v_127_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_127_005_atxt; [Conslt_Name:127]Conslt_Name_UUIDKey_s:5; *)  //Conslt_Name_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_127_001_aL; [Conslt_Name:127]ConsultantNameID_l:1; *)
			
			ARRAY TO SELECTION:C261(v_127_002_atxt; [Conslt_Name:127]ConsultantName_s:2; *)
			ARRAY TO SELECTION:C261(v_127_003_aL; [Conslt_Name:127]SQL_VendorID_l:3; v_127_004_aL; [Conslt_Name:127]CurrentStructureProjectMgr_l:4)
		End if 
	: ($1=128)  //PRJ_StrPrjManagerHistory
		$Array_Ptr:=->v_128_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_128_004_atxt; [PRJ_StrPrjManagerHistory:128]PRJ_StrPrjManagerHist_UUIDKey_s:4; *)  //PRJ_StrPrjManagerHist_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_128_002_atxt; [PRJ_StrPrjManagerHistory:128]SPMH_StructuralProjManager_txt:2; *)
			ARRAY TO SELECTION:C261(v_128_001_aL; [PRJ_StrPrjManagerHistory:128]PRJ_ProjectID_l:1; *)
			ARRAY TO SELECTION:C261(v_128_003_ad; [PRJ_StrPrjManagerHistory:128]SPMH_Replaced_d:3)
		End if 
	: ($1=129)  //Scour Report
		$Array_Ptr:=->v_129_042_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_129_045_atxt; [Scour Report:129]Scour_Report_UUIDKey_s:45; *)  //Scour_Report_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_129_042_atxt; [Scour Report:129]Owner:42; v_129_044_atxt; [Scour Report:129]Comments:44; *)
			ARRAY TO SELECTION:C261(v_129_002_ar; [Scour Report:129]On_State_LowRiskTotal:2; v_129_003_ar; [Scour Report:129]On_State_ScourSuscept:3; v_129_004_ar; [Scour Report:129]On_State_Unknown:4; *)
			ARRAY TO SELECTION:C261(v_129_005_ar; [Scour Report:129]On_State_Tidal:5; v_129_006_ar; [Scour Report:129]On_State_ScourCrit:6; v_129_007_ar; [Scour Report:129]On_State_Counter:7; *)
			ARRAY TO SELECTION:C261(v_129_008_ar; [Scour Report:129]On_State_Monitor:8; v_129_009_ar; [Scour Report:129]On_State_LRT_Calc:9; v_129_010_ar; [Scour Report:129]On_State_LRT_Screen:10; *)
			ARRAY TO SELECTION:C261(v_129_011_ar; [Scour Report:129]On_State_LRT_Culv:11; v_129_012_ar; [Scour Report:129]Off_State_LowRiskTotal:12; v_129_013_ar; [Scour Report:129]Off_State_ScourSuscept:13; *)
			ARRAY TO SELECTION:C261(v_129_014_ar; [Scour Report:129]Off_State_Unknown:14; v_129_015_ar; [Scour Report:129]Off_State_Tidal:15; v_129_016_ar; [Scour Report:129]Off_State_ScourCrit:16; *)
			ARRAY TO SELECTION:C261(v_129_017_ar; [Scour Report:129]Off_State_Counter:17; v_129_018_ar; [Scour Report:129]Off_State_Monitor:18; v_129_019_ar; [Scour Report:129]Off_State_LRT_Calc:19; *)
			ARRAY TO SELECTION:C261(v_129_020_ar; [Scour Report:129]Off_State_LRT_Screen:20; v_129_021_ar; [Scour Report:129]Off_State_LRT_Culv:21; v_129_022_ar; [Scour Report:129]On_Agency_LowRiskTotal:22; *)
			ARRAY TO SELECTION:C261(v_129_023_ar; [Scour Report:129]On_Agency_ScourSuscept:23; v_129_024_ar; [Scour Report:129]On_Agency_Unknown:24; v_129_025_ar; [Scour Report:129]On_Agency_Tidal:25; *)
			ARRAY TO SELECTION:C261(v_129_026_ar; [Scour Report:129]On_Agency_ScourCrit:26; v_129_027_ar; [Scour Report:129]On_Agency_Counter:27; v_129_028_ar; [Scour Report:129]On_Agency_Monitor:28; *)
			ARRAY TO SELECTION:C261(v_129_029_ar; [Scour Report:129]On_Agency_LRT_Calc:29; v_129_030_ar; [Scour Report:129]On_Agency_LRT_Screen:30; v_129_031_ar; [Scour Report:129]On_Agency_LRT_Culv:31; *)
			ARRAY TO SELECTION:C261(v_129_032_ar; [Scour Report:129]Off_Agency_LowRiskTotal:32; v_129_033_ar; [Scour Report:129]Off_Agency_ScourSuscept:33; v_129_034_ar; [Scour Report:129]Off_Agency_Unknown:34; *)
			ARRAY TO SELECTION:C261(v_129_035_ar; [Scour Report:129]Off_Agency_Tidal:35; v_129_036_ar; [Scour Report:129]Off_Agency_ScourCrit:36; v_129_037_ar; [Scour Report:129]Off_Agency_Counter:37; *)
			ARRAY TO SELECTION:C261(v_129_038_ar; [Scour Report:129]Off_Agency_Monitor:38; v_129_039_ar; [Scour Report:129]Off_Agency_LRT_Calc:39; v_129_040_ar; [Scour Report:129]Off_Agency_LRT_Screen:40; *)
			ARRAY TO SELECTION:C261(v_129_041_ar; [Scour Report:129]Off_Agency_LRT_Culv:41; *)
			ARRAY TO SELECTION:C261(v_129_001_ad; [Scour Report:129]ReportDate:1; *)
			ARRAY TO SELECTION:C261(v_129_043_atm; [Scour Report:129]Time_Created:43)
		End if 
	: ($1=130)  //PRJ_Attributes
		$Array_Ptr:=->v_130_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_130_008_atxt; [PRJ_Attributes:130]PRJ_Attributes_UUIDKey_s:8; *)  //PRJ_Attributes_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_130_001_aL; [PRJ_Attributes:130]ATTR_ID_l:1; *)
			
			ARRAY TO SELECTION:C261(v_130_002_atxt; [PRJ_Attributes:130]ATTR_Name_s:2; v_130_003_atxt; [PRJ_Attributes:130]ATTR_Description_txt:3; v_130_006_atxt; [PRJ_Attributes:130]ATTR_Unused_s:7; *)
			ARRAY TO SELECTION:C261(v_130_007_atxt; [PRJ_Attributes:130]ATTR_Unused_s:7; *)
			ARRAY TO SELECTION:C261(v_130_004_ad; [PRJ_Attributes:130]ATTR_Created_d:4; v_130_005_ad; [PRJ_Attributes:130]ATTR_Modified_d:5)
		End if 
	: ($1=131)  //PRJ_ATTRFileNoXrefs
		$Array_Ptr:=->v_131_001_aL
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_131_004_atxt; [PRJ_ATTRFileNoXrefs:131]PRJ_ATTRFileNoXrefs_UUIDKey_s:4; *)  //PRJ_ATTRFileNoXrefs_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_131_001_aL; [PRJ_ATTRFileNoXrefs:131]ATTR_ID_l:1; v_131_002_aL; [PRJ_ATTRFileNoXrefs:131]PF_FileNumber_l:2; *)
			ARRAY TO SELECTION:C261(v_131_003_ad; [PRJ_ATTRFileNoXrefs:131]ATTFile_Created_d:3)
		End if 
	: ($1=132)  //ScourPOA
		$Array_Ptr:=->v_132_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_132_033_atxt; [ScourPOA:132]ScourPOA_UUIDKey_s:33; *)  //ScourPOA_UUIDKey_s
			End if 
			If (clone_UseBlobArrays_B)
				ARRAY TO SELECTION:C261(v_132_006_ablb; [ScourPOA:132]ScourEvalSummary:6; v_132_007_ablb; [ScourPOA:132]ScourHistory:7; v_132_024_ablb; [ScourPOA:132]StoreBlob_x:24; *)
				
			Else 
				clone_GetBlobs($1)
			End if 
			ARRAY TO SELECTION:C261(v_132_001_aL; [ScourPOA:132]ScourPOAID:1; *)
			
			ARRAY TO SELECTION:C261(v_132_002_atxt; [ScourPOA:132]BIN:2; v_132_009_atxt; [ScourPOA:132]CompletedBy:9; v_132_010_atxt; [ScourPOA:132]ApprovedBy:10; *)
			ARRAY TO SELECTION:C261(v_132_011_atxt; [ScourPOA:132]ScourReviewBy:11; v_132_015_atxt; [ScourPOA:132]StructAssessBy:15; v_132_016_atxt; [ScourPOA:132]GeotechAssessBy:16; *)
			ARRAY TO SELECTION:C261(v_132_019_atxt; [ScourPOA:132]FoundationType:19; v_132_020_atxt; [ScourPOA:132]FoundationMat:20; v_132_022_atxt; [ScourPOA:132]CreatedBy:22; *)
			ARRAY TO SELECTION:C261(v_132_025_atxt; [ScourPOA:132]StreamBedMaterial:25; v_132_026_atxt; [ScourPOA:132]Consultant:26; v_132_027_atxt; [ScourPOA:132]PMReviewBy:27; *)
			ARRAY TO SELECTION:C261(v_132_017_ar; [ScourPOA:132]StructCritElev:17; v_132_018_ar; [ScourPOA:132]GeotechCritEleve:18; *)
			ARRAY TO SELECTION:C261(v_132_023_aL; [ScourPOA:132]Approved:23; v_132_029_aL; [ScourPOA:132]PMReviewed:29; v_132_031_aL; [ScourPOA:132]ChannelInspCurr:31; *)
			ARRAY TO SELECTION:C261(v_132_032_aL; [ScourPOA:132]ChannelInspRec:32; *)
			ARRAY TO SELECTION:C261(v_132_003_ad; [ScourPOA:132]DateCreated:3; v_132_004_ad; [ScourPOA:132]DateModified:4; v_132_005_ad; [ScourPOA:132]DateApproved:5; *)
			ARRAY TO SELECTION:C261(v_132_008_ad; [ScourPOA:132]DateCompleted:8; v_132_012_ad; [ScourPOA:132]ScourReviewDate:12; v_132_013_ad; [ScourPOA:132]StructAssessDate:13; *)
			ARRAY TO SELECTION:C261(v_132_014_ad; [ScourPOA:132]GeotechAssessDate:14; v_132_028_ad; [ScourPOA:132]PMReviewDate:28; v_132_030_ad; [ScourPOA:132]NTP_Date:30; *)
			ARRAY TO SELECTION:C261(v_132_021_ab; [ScourPOA:132]Completed:21)
		End if 
	: ($1=133)  //ScourPOA_DetourBridge
		$Array_Ptr:=->v_133_003_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_133_004_atxt; [ScourPOA_DetourBridge:133]ScourPOA_DetourBridge_UUIDKey_s:4; *)  //ScourPOA_DetourBridge_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_133_001_aL; [ScourPOA_DetourBridge:133]DetourBridgeID_L:1; *)
			
			ARRAY TO SELECTION:C261(v_133_003_atxt; [ScourPOA_DetourBridge:133]DetourBIN:3; *)
			ARRAY TO SELECTION:C261(v_133_002_aL; [ScourPOA_DetourBridge:133]ScourPOAID:2)
		End if 
	: ($1=134)  //ScourPOA_Images
		$Array_Ptr:=->v_134_004_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_134_009_atxt; [ScourPOA_Images:134]ScourPOA_Images_UUIDKey_s:9; *)  //ScourPOA_Images_UUIDKey_s
			End if 
			If (clone_UseBlobArrays_B)
				ARRAY TO SELECTION:C261(v_134_003_ablb; [ScourPOA_Images:134]Image_x:3; *)
			Else 
				clone_GetBlobs($1)
			End if 
			ARRAY TO SELECTION:C261(v_134_001_aL; [ScourPOA_Images:134]ScourPOAImgID:1; *)
			
			ARRAY TO SELECTION:C261(v_134_004_atxt; [ScourPOA_Images:134]ImgDescr_txt:4; v_134_005_atxt; [ScourPOA_Images:134]ImageType:5; *)
			ARRAY TO SELECTION:C261(v_134_002_aL; [ScourPOA_Images:134]ScourPOAID:2; v_134_006_aL; [ScourPOA_Images:134]ImageSeq:6; v_134_007_aL; [ScourPOA_Images:134]OnPage1:7; *)
			ARRAY TO SELECTION:C261(v_134_008_aL; [ScourPOA_Images:134]ImagePart:8)
		End if 
	: ($1=135)  //PRJ_DCPFJoin
		$Array_Ptr:=->v_135_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_135_004_atxt; [PRJ_DCPFJoin:135]PRJ_DCPFJoin_UUIDKey_s:4; *)  //PRJ_DCPFJoin_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_135_001_atxt; [PRJ_DCPFJoin:135]DCPF_Contract_FileNo_s:1; *)
			ARRAY TO SELECTION:C261(v_135_002_aL; [PRJ_DCPFJoin:135]DC_DesignProjectID_l:2; v_135_003_aL; [PRJ_DCPFJoin:135]PF_FileID_l:3)
		End if 
	: ($1=136)  //DCM_Contracts
		$Array_Ptr:=->v_136_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_136_036_atxt; [DCM_Contracts:136]DCM_Contracts_UUIDKey_s:36; *)  //DCM_Contracts_UUIDKey_s
			End if 
			If (clone_UseBlobArrays_B)
				ARRAY TO SELECTION:C261(v_136_034_ablb; [DCM_Contracts:136]ContractRates_x:34; *)
			Else 
				clone_GetBlobs($1)
			End if 
			ARRAY TO SELECTION:C261(v_136_001_atxt; [DCM_Contracts:136]ContractNo:1; v_136_002_aL; [DCM_Contracts:136]ContractID:2; *)
			
			ARRAY TO SELECTION:C261(v_136_003_atxt; [DCM_Contracts:136]ConsultantName:3; v_136_007_atxt; [DCM_Contracts:136]ContractStatus:7; *)
			ARRAY TO SELECTION:C261(v_136_008_atxt; [DCM_Contracts:136]ContractType:8; v_136_009_atxt; [DCM_Contracts:136]FederalAidNo:9; v_136_022_atxt; [DCM_Contracts:136]CheckWithAuditComment:22; *)
			ARRAY TO SELECTION:C261(v_136_024_atxt; [DCM_Contracts:136]CertificateOfCompletionCmnt:24; v_136_026_atxt; [DCM_Contracts:136]ReincumbrancesComment:26; v_136_028_atxt; [DCM_Contracts:136]ProcessRetainageComment:28; *)
			ARRAY TO SELECTION:C261(v_136_033_atxt; [DCM_Contracts:136]BridgePrjMgr:33; v_136_035_atxt; [DCM_Contracts:136]Dummy:35; *)
			ARRAY TO SELECTION:C261(v_136_010_ar; [DCM_Contracts:136]OverheadRate:10; v_136_011_ar; [DCM_Contracts:136]NetFeeRate:11; v_136_012_ar; [DCM_Contracts:136]InitContractTotal:12; *)
			ARRAY TO SELECTION:C261(v_136_013_ar; [DCM_Contracts:136]InitContractSalary:13; v_136_014_ar; [DCM_Contracts:136]InitContractTotalLimitFee:14; v_136_015_ar; [DCM_Contracts:136]InitContractTotDirctExpense:15; *)
			ARRAY TO SELECTION:C261(v_136_016_ar; [DCM_Contracts:136]TotalEncumbered:16; v_136_017_ar; [DCM_Contracts:136]ApproxSpent:17; v_136_018_ar; [DCM_Contracts:136]ActualSpent:18; *)
			ARRAY TO SELECTION:C261(v_136_019_ar; [DCM_Contracts:136]ApproxRemainingFund:19; v_136_020_ar; [DCM_Contracts:136]ActualRemainingFund:20; v_136_030_ar; [DCM_Contracts:136]RetainageAmtInit:30; *)
			ARRAY TO SELECTION:C261(v_136_031_ar; [DCM_Contracts:136]RetainagePct:31; v_136_032_ar; [DCM_Contracts:136]MaxHourlyRate:32; *)
			ARRAY TO SELECTION:C261(v_136_004_ad; [DCM_Contracts:136]AwardContractDate:4; v_136_005_ad; [DCM_Contracts:136]InitialCompleteDate:5; v_136_006_ad; [DCM_Contracts:136]ExtendedCompleteDate:6; *)
			ARRAY TO SELECTION:C261(v_136_021_ab; [DCM_Contracts:136]CheckWithAudit:21; v_136_023_ab; [DCM_Contracts:136]CertificateOfCompletion:23; v_136_025_ab; [DCM_Contracts:136]Reincumbrances:25; *)
			ARRAY TO SELECTION:C261(v_136_027_ab; [DCM_Contracts:136]ProcessRetainage:27; v_136_029_ab; [DCM_Contracts:136]FederalFund:29)
		End if 
	: ($1=137)  //DCM_WorkOrders
		$Array_Ptr:=->v_137_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_137_043_atxt; [DCM_WorkOrders:137]DCM_WorkOrders_UUIDKey_s:43; *)  //DCM_WorkOrders_UUIDKey_s
			End if 
			If (clone_UseBlobArrays_B)
				ARRAY TO SELECTION:C261(v_137_039_ablb; [DCM_WorkOrders:137]WriteBlobs_x:39; *)
			Else 
				clone_GetBlobs($1)
			End if 
			ARRAY TO SELECTION:C261(v_137_003_aL; [DCM_WorkOrders:137]AssignID:3; *)
			
			ARRAY TO SELECTION:C261(v_137_001_atxt; [DCM_WorkOrders:137]ContractNo:1; v_137_004_atxt; [DCM_WorkOrders:137]ProjectIS:4; *)
			ARRAY TO SELECTION:C261(v_137_008_atxt; [DCM_WorkOrders:137]Consultant:8; v_137_019_atxt; [DCM_WorkOrders:137]Comments:19; v_137_020_atxt; [DCM_WorkOrders:137]AcutalOrEstimate:20; *)
			ARRAY TO SELECTION:C261(v_137_035_atxt; [DCM_WorkOrders:137]Description:35; v_137_036_atxt; [DCM_WorkOrders:137]ProjectType:36; v_137_037_atxt; [DCM_WorkOrders:137]ExtendedDesc_txt:37; *)
			ARRAY TO SELECTION:C261(v_137_040_atxt; [DCM_WorkOrders:137]DistrictArea_s:40; v_137_042_atxt; [DCM_WorkOrders:137]Dummy:42; *)
			ARRAY TO SELECTION:C261(v_137_005_ar; [DCM_WorkOrders:137]Overhead:5; v_137_006_ar; [DCM_WorkOrders:137]Fee:6; v_137_007_ar; [DCM_WorkOrders:137]Salary:7; *)
			ARRAY TO SELECTION:C261(v_137_009_ar; [DCM_WorkOrders:137]Actual_Total:9; v_137_010_ar; [DCM_WorkOrders:137]Est_Salary:10; v_137_011_ar; [DCM_WorkOrders:137]Est_IndirectCost:11; *)
			ARRAY TO SELECTION:C261(v_137_012_ar; [DCM_WorkOrders:137]Est_NetFee:12; v_137_013_ar; [DCM_WorkOrders:137]Est_TotalLimitFee:13; v_137_014_ar; [DCM_WorkOrders:137]Est_DirectExpense:14; *)
			ARRAY TO SELECTION:C261(v_137_015_ar; [DCM_WorkOrders:137]Est_Total:15; v_137_022_ar; [DCM_WorkOrders:137]Actual_Salary:22; v_137_023_ar; [DCM_WorkOrders:137]Actual_IndirectCost:23; *)
			ARRAY TO SELECTION:C261(v_137_024_ar; [DCM_WorkOrders:137]Actual_NetFee:24; v_137_025_ar; [DCM_WorkOrders:137]Actual_TotalLimitFee:25; v_137_026_ar; [DCM_WorkOrders:137]Actual_DirectExpense:26; *)
			ARRAY TO SELECTION:C261(v_137_027_ar; [DCM_WorkOrders:137]Est_ConstrSalary:27; v_137_028_ar; [DCM_WorkOrders:137]Est_ConstrIndirectCost:28; v_137_029_ar; [DCM_WorkOrders:137]Est_ConstrNetFee:29; *)
			ARRAY TO SELECTION:C261(v_137_030_ar; [DCM_WorkOrders:137]Est_ConstrTotalLimitFee:30; v_137_031_ar; [DCM_WorkOrders:137]Actual_ConstrSalary:31; v_137_032_ar; [DCM_WorkOrders:137]Actual_ConstrIndirectCost:32; *)
			ARRAY TO SELECTION:C261(v_137_033_ar; [DCM_WorkOrders:137]Actual_ConstrNetFee:33; v_137_034_ar; [DCM_WorkOrders:137]Actual_ConstrTotalLimitFee:34; *)
			ARRAY TO SELECTION:C261(v_137_002_ai; [DCM_WorkOrders:137]AssignNo:2; *)
			ARRAY TO SELECTION:C261(v_137_038_aL; [DCM_WorkOrders:137]ABPFlag_L:38; *)
			ARRAY TO SELECTION:C261(v_137_016_ad; [DCM_WorkOrders:137]ReqFeeProposalDate:16; v_137_017_ad; [DCM_WorkOrders:137]NTPdate_written:17; v_137_018_ad; [DCM_WorkOrders:137]NTPdate_verbal:18; *)
			ARRAY TO SELECTION:C261(v_137_041_ad; [DCM_WorkOrders:137]Date_Issued_d:41; *)
			ARRAY TO SELECTION:C261(v_137_021_ab; [DCM_WorkOrders:137]SpecialAssignment:21)
		End if 
	: ($1=138)  //DCM_Project
		$Array_Ptr:=->v_138_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_138_020_atxt; [DCM_Project:138]DCM_Project_UUIDKey_s:20; *)  //DCM_Project_UUIDKey_s
			End if 
			If (clone_UseBlobArrays_B)
				ARRAY TO SELECTION:C261(v_138_014_ablb; [DCM_Project:138]ProjData_X:14; v_138_016_ablb; [DCM_Project:138]ProjItems_x:16; *)
			Else 
				clone_GetBlobs($1)
			End if 
			ARRAY TO SELECTION:C261(v_138_001_aL; [DCM_Project:138]ProjectID:1; *)
			
			ARRAY TO SELECTION:C261(v_138_002_atxt; [DCM_Project:138]ContractNo:2; *)
			ARRAY TO SELECTION:C261(v_138_003_atxt; [DCM_Project:138]Project Type:3; v_138_004_atxt; [DCM_Project:138]BridgeNo:4; v_138_005_atxt; [DCM_Project:138]BIN:5; *)
			ARRAY TO SELECTION:C261(v_138_006_atxt; [DCM_Project:138]Location:6; v_138_007_atxt; [DCM_Project:138]Town:7; v_138_008_atxt; [DCM_Project:138]District:8; *)
			ARRAY TO SELECTION:C261(v_138_019_atxt; [DCM_Project:138]Dummy:19; *)
			ARRAY TO SELECTION:C261(v_138_010_ar; [DCM_Project:138]EstCost:10; v_138_011_ar; [DCM_Project:138]FinalCost:11; v_138_012_ar; [DCM_Project:138]CurrCost:12; *)
			ARRAY TO SELECTION:C261(v_138_009_ai; [DCM_Project:138]AssignNo:9; *)
			ARRAY TO SELECTION:C261(v_138_013_aL; [DCM_Project:138]AssignID:13; *)
			ARRAY TO SELECTION:C261(v_138_017_ad; [DCM_Project:138]Work_Start_d:17; v_138_018_ad; [DCM_Project:138]Work_End_d:18; *)
			ARRAY TO SELECTION:C261(v_138_015_ab; [DCM_Project:138]SDInfluence:15)
		End if 
	: ($1=139)  //BridgeMHDNBISArchive
		$Array_Ptr:=->v_139_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_139_229_atxt; [BridgeMHDNBISArchive:139]BridgeMHDNBISArchive_UUIDKey_s:229; *)  //BridgeMHDNBISArchive_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_139_001_atxt; [BridgeMHDNBISArchive:139]BDEPT:1; v_139_002_atxt; [BridgeMHDNBISArchive:139]Bridge Key:2; v_139_003_atxt; [BridgeMHDNBISArchive:139]BIN:3; *)
			ARRAY TO SELECTION:C261(v_139_008_atxt; [BridgeMHDNBISArchive:139]PostingStatus:8; v_139_012_atxt; [BridgeMHDNBISArchive:139]Foundation Type:12; v_139_023_atxt; [BridgeMHDNBISArchive:139]FC Under:23; *)
			ARRAY TO SELECTION:C261(v_139_024_atxt; [BridgeMHDNBISArchive:139]Quad:24; v_139_025_atxt; [BridgeMHDNBISArchive:139]SelectionText:25; v_139_027_atxt; [BridgeMHDNBISArchive:139]ParallelBIN:27; *)
			ARRAY TO SELECTION:C261(v_139_029_atxt; [BridgeMHDNBISArchive:139]Bridge Name:29; v_139_030_atxt; [BridgeMHDNBISArchive:139]LiftBucket:30; v_139_031_atxt; [BridgeMHDNBISArchive:139]Ladder:31; *)
			ARRAY TO SELECTION:C261(v_139_032_atxt; [BridgeMHDNBISArchive:139]Boat:32; v_139_033_atxt; [BridgeMHDNBISArchive:139]Wader:33; v_139_034_atxt; [BridgeMHDNBISArchive:139]Inspector50:34; *)
			ARRAY TO SELECTION:C261(v_139_035_atxt; [BridgeMHDNBISArchive:139]Rigging:35; v_139_036_atxt; [BridgeMHDNBISArchive:139]Staging:36; v_139_037_atxt; [BridgeMHDNBISArchive:139]Traffic Control:37; *)
			ARRAY TO SELECTION:C261(v_139_038_atxt; [BridgeMHDNBISArchive:139]RR Flagman:38; v_139_039_atxt; [BridgeMHDNBISArchive:139]Police:39; v_139_049_atxt; [BridgeMHDNBISArchive:139]InspWaiverText:49; *)
			ARRAY TO SELECTION:C261(v_139_050_atxt; [BridgeMHDNBISArchive:139]RoadInvSNC:50; v_139_051_atxt; [BridgeMHDNBISArchive:139]RoadInvSNI:51; v_139_052_atxt; [BridgeMHDNBISArchive:139]MaintCat:52; *)
			ARRAY TO SELECTION:C261(v_139_053_atxt; [BridgeMHDNBISArchive:139]MaintPriority:53; v_139_054_atxt; [BridgeMHDNBISArchive:139]MaintTxtDist:54; v_139_055_atxt; [BridgeMHDNBISArchive:139]MaintTxtBoston:55; *)
			ARRAY TO SELECTION:C261(v_139_057_atxt; [BridgeMHDNBISArchive:139]SeismicClass:57; v_139_058_atxt; [BridgeMHDNBISArchive:139]Item5:58; v_139_059_atxt; [BridgeMHDNBISArchive:139]Item2:59; *)
			ARRAY TO SELECTION:C261(v_139_060_atxt; [BridgeMHDNBISArchive:139]Item3:60; v_139_061_atxt; [BridgeMHDNBISArchive:139]Item4:61; v_139_062_atxt; [BridgeMHDNBISArchive:139]Item6A:62; *)
			ARRAY TO SELECTION:C261(v_139_064_atxt; [BridgeMHDNBISArchive:139]Item7:64; v_139_065_atxt; [BridgeMHDNBISArchive:139]Item9:65; v_139_071_atxt; [BridgeMHDNBISArchive:139]Item98A:71; *)
			ARRAY TO SELECTION:C261(v_139_072_atxt; [BridgeMHDNBISArchive:139]Item98B:72; v_139_073_atxt; [BridgeMHDNBISArchive:139]Item99:73; v_139_074_atxt; [BridgeMHDNBISArchive:139]Item43:74; *)
			ARRAY TO SELECTION:C261(v_139_075_atxt; [BridgeMHDNBISArchive:139]Item44:75; v_139_078_atxt; [BridgeMHDNBISArchive:139]Item107:78; v_139_079_atxt; [BridgeMHDNBISArchive:139]Item108A:79; *)
			ARRAY TO SELECTION:C261(v_139_080_atxt; [BridgeMHDNBISArchive:139]Item108B:80; v_139_081_atxt; [BridgeMHDNBISArchive:139]Item108C:81; v_139_084_atxt; [BridgeMHDNBISArchive:139]Item42:84; *)
			ARRAY TO SELECTION:C261(v_139_098_atxt; [BridgeMHDNBISArchive:139]Item33:98; v_139_106_atxt; [BridgeMHDNBISArchive:139]Item54A:106; v_139_109_atxt; [BridgeMHDNBISArchive:139]Item55A:109; *)
			ARRAY TO SELECTION:C261(v_139_112_atxt; [BridgeMHDNBISArchive:139]Item38:112; v_139_113_atxt; [BridgeMHDNBISArchive:139]Item111:113; v_139_119_atxt; [BridgeMHDNBISArchive:139]Item26:119; *)
			ARRAY TO SELECTION:C261(v_139_120_atxt; [BridgeMHDNBISArchive:139]Item100:120; v_139_121_atxt; [BridgeMHDNBISArchive:139]Item101:121; v_139_122_atxt; [BridgeMHDNBISArchive:139]Item102:122; *)
			ARRAY TO SELECTION:C261(v_139_125_atxt; [BridgeMHDNBISArchive:139]Item20:125; v_139_126_atxt; [BridgeMHDNBISArchive:139]Item21:126; v_139_127_atxt; [BridgeMHDNBISArchive:139]Item22:127; *)
			ARRAY TO SELECTION:C261(v_139_128_atxt; [BridgeMHDNBISArchive:139]Item37:128; v_139_129_atxt; [BridgeMHDNBISArchive:139]Item58:129; v_139_130_atxt; [BridgeMHDNBISArchive:139]Item59:130; *)
			ARRAY TO SELECTION:C261(v_139_131_atxt; [BridgeMHDNBISArchive:139]Item60:131; v_139_132_atxt; [BridgeMHDNBISArchive:139]Item61:132; v_139_133_atxt; [BridgeMHDNBISArchive:139]Item62:133; *)
			ARRAY TO SELECTION:C261(v_139_134_atxt; [BridgeMHDNBISArchive:139]Item31:134; v_139_139_atxt; [BridgeMHDNBISArchive:139]Item70:139; v_139_140_atxt; [BridgeMHDNBISArchive:139]Item41:140; *)
			ARRAY TO SELECTION:C261(v_139_141_atxt; [BridgeMHDNBISArchive:139]Item67:141; v_139_142_atxt; [BridgeMHDNBISArchive:139]Item68:142; v_139_143_atxt; [BridgeMHDNBISArchive:139]Item69:143; *)
			ARRAY TO SELECTION:C261(v_139_144_atxt; [BridgeMHDNBISArchive:139]Item71:144; v_139_145_atxt; [BridgeMHDNBISArchive:139]Item72:145; v_139_146_atxt; [BridgeMHDNBISArchive:139]Item36A:146; *)
			ARRAY TO SELECTION:C261(v_139_147_atxt; [BridgeMHDNBISArchive:139]Item36B:147; v_139_148_atxt; [BridgeMHDNBISArchive:139]Item36C:148; v_139_149_atxt; [BridgeMHDNBISArchive:139]Item36D:149; *)
			ARRAY TO SELECTION:C261(v_139_150_atxt; [BridgeMHDNBISArchive:139]Item113:150; v_139_151_atxt; [BridgeMHDNBISArchive:139]Item75A:151; v_139_152_atxt; [BridgeMHDNBISArchive:139]Item75B:152; *)
			ARRAY TO SELECTION:C261(v_139_171_atxt; [BridgeMHDNBISArchive:139]General Comment:171; v_139_172_atxt; [BridgeMHDNBISArchive:139]InspResp:172; v_139_174_atxt; [BridgeMHDNBISArchive:139]Town Name:174; *)
			ARRAY TO SELECTION:C261(v_139_178_atxt; [BridgeMHDNBISArchive:139]AccessOther:178; v_139_179_atxt; [BridgeMHDNBISArchive:139]OtherAccBool:179; v_139_180_atxt; [BridgeMHDNBISArchive:139]RPC_Codes:180; *)
			ARRAY TO SELECTION:C261(v_139_182_atxt; [BridgeMHDNBISArchive:139]CulvertShape:182; v_139_183_atxt; [BridgeMHDNBISArchive:139]CulvertMaterial:183; v_139_184_atxt; [BridgeMHDNBISArchive:139]CulvertCoating:184; *)
			ARRAY TO SELECTION:C261(v_139_188_atxt; [BridgeMHDNBISArchive:139]Modified By:188; v_139_194_atxt; [BridgeMHDNBISArchive:139]Item 13A:194; v_139_195_atxt; [BridgeMHDNBISArchive:139]Item 13B:195; *)
			ARRAY TO SELECTION:C261(v_139_196_atxt; [BridgeMHDNBISArchive:139]Item 63:196; v_139_197_atxt; [BridgeMHDNBISArchive:139]Item 65:197; v_139_198_atxt; [BridgeMHDNBISArchive:139]Item 105:198; *)
			ARRAY TO SELECTION:C261(v_139_199_atxt; [BridgeMHDNBISArchive:139]JointlessType:199; v_139_203_atxt; [BridgeMHDNBISArchive:139]Item8:203; v_139_204_atxt; [BridgeMHDNBISArchive:139]Item8 BridgeCat:204; *)
			ARRAY TO SELECTION:C261(v_139_205_atxt; [BridgeMHDNBISArchive:139]Item8 Owner:205; v_139_206_atxt; [BridgeMHDNBISArchive:139]AgencyBrNo:206; v_139_207_atxt; [BridgeMHDNBISArchive:139]RRBranch:207; *)
			ARRAY TO SELECTION:C261(v_139_212_atxt; [BridgeMHDNBISArchive:139]OtherInspType:212; v_139_213_atxt; [BridgeMHDNBISArchive:139]ClassAEmp:213; v_139_214_atxt; [BridgeMHDNBISArchive:139]ConfinedSp:214; *)
			ARRAY TO SELECTION:C261(v_139_215_atxt; [BridgeMHDNBISArchive:139]OffHrsWork:215; v_139_221_atxt; [BridgeMHDNBISArchive:139]MissSignsDesc:221; v_139_222_atxt; [BridgeMHDNBISArchive:139]FreezeThaw:222; *)
			ARRAY TO SELECTION:C261(v_139_223_atxt; [BridgeMHDNBISArchive:139]ArchiveReason_s:223; v_139_225_atxt; [BridgeMHDNBISArchive:139]LegacyOwner:225; v_139_227_atxt; [BridgeMHDNBISArchive:139]FundingSource:227; *)
			ARRAY TO SELECTION:C261(v_139_228_atxt; [BridgeMHDNBISArchive:139]FHWAItem8:228; *)
			ARRAY TO SELECTION:C261(v_139_005_ar; [BridgeMHDNBISArchive:139]AASHTO:5; v_139_015_ar; [BridgeMHDNBISArchive:139]OprH20:15; v_139_016_ar; [BridgeMHDNBISArchive:139]OprType3:16; *)
			ARRAY TO SELECTION:C261(v_139_017_ar; [BridgeMHDNBISArchive:139]Opr3S2:17; v_139_018_ar; [BridgeMHDNBISArchive:139]OprHS:18; v_139_019_ar; [BridgeMHDNBISArchive:139]InvH20:19; *)
			ARRAY TO SELECTION:C261(v_139_020_ar; [BridgeMHDNBISArchive:139]InvType3:20; v_139_021_ar; [BridgeMHDNBISArchive:139]Inv3S2:21; v_139_022_ar; [BridgeMHDNBISArchive:139]InvHS:22; *)
			ARRAY TO SELECTION:C261(v_139_056_ar; [BridgeMHDNBISArchive:139]SeismicRank:56; v_139_066_ar; [BridgeMHDNBISArchive:139]Item11:66; v_139_091_ar; [BridgeMHDNBISArchive:139]Item48:91; *)
			ARRAY TO SELECTION:C261(v_139_092_ar; [BridgeMHDNBISArchive:139]Item49:92; v_139_093_ar; [BridgeMHDNBISArchive:139]Item50A:93; v_139_094_ar; [BridgeMHDNBISArchive:139]Item50B:94; *)
			ARRAY TO SELECTION:C261(v_139_095_ar; [BridgeMHDNBISArchive:139]Item51:95; v_139_096_ar; [BridgeMHDNBISArchive:139]Item52:96; v_139_097_ar; [BridgeMHDNBISArchive:139]Item32:97; *)
			ARRAY TO SELECTION:C261(v_139_101_ar; [BridgeMHDNBISArchive:139]Item10:101; v_139_103_ar; [BridgeMHDNBISArchive:139]Item47:103; v_139_104_ar; [BridgeMHDNBISArchive:139]Item53:104; *)
			ARRAY TO SELECTION:C261(v_139_107_ar; [BridgeMHDNBISArchive:139]Item54B:107; v_139_108_ar; [BridgeMHDNBISArchive:139]Item16C:108; v_139_110_ar; [BridgeMHDNBISArchive:139]Item55B:110; *)
			ARRAY TO SELECTION:C261(v_139_111_ar; [BridgeMHDNBISArchive:139]Item56:111; v_139_114_ar; [BridgeMHDNBISArchive:139]Item39:114; v_139_115_ar; [BridgeMHDNBISArchive:139]Item116:115; *)
			ARRAY TO SELECTION:C261(v_139_116_ar; [BridgeMHDNBISArchive:139]Item40:116; v_139_135_ar; [BridgeMHDNBISArchive:139]Item17C:135; v_139_136_ar; [BridgeMHDNBISArchive:139]Item64:136; *)
			ARRAY TO SELECTION:C261(v_139_138_ar; [BridgeMHDNBISArchive:139]Item66:138; v_139_153_ar; [BridgeMHDNBISArchive:139]Item76:153; v_139_186_ar; [BridgeMHDNBISArchive:139]BarrelsHeight:186; *)
			ARRAY TO SELECTION:C261(v_139_187_ar; [BridgeMHDNBISArchive:139]BarrelsWidth:187; v_139_200_ar; [BridgeMHDNBISArchive:139]InvMS:200; v_139_201_ar; [BridgeMHDNBISArchive:139]OprMS:201; *)
			ARRAY TO SELECTION:C261(v_139_208_ar; [BridgeMHDNBISArchive:139]RRBridgeNo:208; v_139_217_ar; [BridgeMHDNBISArchive:139]HI_Total_Elmt_Cost:217; v_139_218_ar; [BridgeMHDNBISArchive:139]HI_Current_Elmt_Cost:218; *)
			ARRAY TO SELECTION:C261(v_139_219_ar; [BridgeMHDNBISArchive:139]HealthIndex:219; *)
			ARRAY TO SELECTION:C261(v_139_006_ai; [BridgeMHDNBISArchive:139]Rank:6; v_139_009_ai; [BridgeMHDNBISArchive:139]Posting2Axle:9; v_139_010_ai; [BridgeMHDNBISArchive:139]Posting3Axle:10; *)
			ARRAY TO SELECTION:C261(v_139_011_ai; [BridgeMHDNBISArchive:139]Posting5Axle:11; v_139_040_ai; [BridgeMHDNBISArchive:139]InspectionHRS:40; v_139_043_ai; [BridgeMHDNBISArchive:139]OtherIFreq:43; *)
			ARRAY TO SELECTION:C261(v_139_046_ai; [BridgeMHDNBISArchive:139]ClosedIFreq:46; v_139_067_ai; [BridgeMHDNBISArchive:139]Item16A:67; v_139_068_ai; [BridgeMHDNBISArchive:139]Item16B:68; *)
			ARRAY TO SELECTION:C261(v_139_069_ai; [BridgeMHDNBISArchive:139]Item17A:69; v_139_070_ai; [BridgeMHDNBISArchive:139]Item17B:70; v_139_076_ai; [BridgeMHDNBISArchive:139]Item45:76; *)
			ARRAY TO SELECTION:C261(v_139_077_ai; [BridgeMHDNBISArchive:139]Item46:77; v_139_082_ai; [BridgeMHDNBISArchive:139]Item27:82; v_139_083_ai; [BridgeMHDNBISArchive:139]Item106:83; *)
			ARRAY TO SELECTION:C261(v_139_085_ai; [BridgeMHDNBISArchive:139]Item28A:85; v_139_086_ai; [BridgeMHDNBISArchive:139]Item28B:86; v_139_088_ai; [BridgeMHDNBISArchive:139]Item30:88; *)
			ARRAY TO SELECTION:C261(v_139_089_ai; [BridgeMHDNBISArchive:139]Item109:89; v_139_090_ai; [BridgeMHDNBISArchive:139]Item19:90; v_139_099_ai; [BridgeMHDNBISArchive:139]Item34:99; *)
			ARRAY TO SELECTION:C261(v_139_157_ai; [BridgeMHDNBISArchive:139]Item97:157; v_139_159_ai; [BridgeMHDNBISArchive:139]Item115:159; v_139_161_ai; [BridgeMHDNBISArchive:139]Item91:161; *)
			ARRAY TO SELECTION:C261(v_139_163_ai; [BridgeMHDNBISArchive:139]Item92AB:163; v_139_165_ai; [BridgeMHDNBISArchive:139]Item92BB:165; v_139_167_ai; [BridgeMHDNBISArchive:139]Item92CB:167; *)
			ARRAY TO SELECTION:C261(v_139_185_ai; [BridgeMHDNBISArchive:139]BarrelsNumber:185; v_139_210_ai; [BridgeMHDNBISArchive:139]UWSpInspFreq:210; *)
			ARRAY TO SELECTION:C261(v_139_087_aL; [BridgeMHDNBISArchive:139]Item29:87; v_139_154_aL; [BridgeMHDNBISArchive:139]Item94:154; v_139_155_aL; [BridgeMHDNBISArchive:139]Item95:155; *)
			ARRAY TO SELECTION:C261(v_139_156_aL; [BridgeMHDNBISArchive:139]Item96:156; v_139_158_aL; [BridgeMHDNBISArchive:139]Item114:158; v_139_230_aL; [BridgeMHDNBISArchive:139]PostingSingle:230; *)
			ARRAY TO SELECTION:C261(v_139_007_ad; [BridgeMHDNBISArchive:139]PostingDate:7; v_139_041_ad; [BridgeMHDNBISArchive:139]OtherIDate:41; v_139_044_ad; [BridgeMHDNBISArchive:139]ClosedIDate:44; *)
			ARRAY TO SELECTION:C261(v_139_047_ad; [BridgeMHDNBISArchive:139]DamageInsp:47; v_139_160_ad; [BridgeMHDNBISArchive:139]Item90:160; v_139_168_ad; [BridgeMHDNBISArchive:139]Item93A:168; *)
			ARRAY TO SELECTION:C261(v_139_169_ad; [BridgeMHDNBISArchive:139]Item93B:169; v_139_170_ad; [BridgeMHDNBISArchive:139]Item93C:170; v_139_189_ad; [BridgeMHDNBISArchive:139]DateCreated:189; *)
			ARRAY TO SELECTION:C261(v_139_191_ad; [BridgeMHDNBISArchive:139]DateModified:191; v_139_202_ad; [BridgeMHDNBISArchive:139]DateRatReport:202; v_139_211_ad; [BridgeMHDNBISArchive:139]UWSpInspDate:211; *)
			ARRAY TO SELECTION:C261(v_139_224_ad; [BridgeMHDNBISArchive:139]ArchiveDate_d:224; *)
			ARRAY TO SELECTION:C261(v_139_190_atm; [BridgeMHDNBISArchive:139]TimeCreated:190; v_139_192_atm; [BridgeMHDNBISArchive:139]TimeModified:192; *)
			ARRAY TO SELECTION:C261(v_139_004_ab; [BridgeMHDNBISArchive:139]FHWA Select:4; v_139_013_ab; [BridgeMHDNBISArchive:139]AreaEngVal:13; v_139_014_ab; [BridgeMHDNBISArchive:139]BrgInspEngVal:14; *)
			ARRAY TO SELECTION:C261(v_139_026_ab; [BridgeMHDNBISArchive:139]AntiMissile:26; v_139_028_ab; [BridgeMHDNBISArchive:139]Acrow Panel:28; v_139_042_ab; [BridgeMHDNBISArchive:139]OtherInsp:42; *)
			ARRAY TO SELECTION:C261(v_139_045_ab; [BridgeMHDNBISArchive:139]ClosedInsp:45; v_139_048_ab; [BridgeMHDNBISArchive:139]InspWaiver:48; v_139_063_ab; [BridgeMHDNBISArchive:139]Item6B:63; *)
			ARRAY TO SELECTION:C261(v_139_100_ab; [BridgeMHDNBISArchive:139]Item35:100; v_139_102_ab; [BridgeMHDNBISArchive:139]StructDef:102; v_139_105_ab; [BridgeMHDNBISArchive:139]FunctObs:105; *)
			ARRAY TO SELECTION:C261(v_139_117_ab; [BridgeMHDNBISArchive:139]Item112:117; v_139_118_ab; [BridgeMHDNBISArchive:139]Item104:118; v_139_123_ab; [BridgeMHDNBISArchive:139]Item103:123; *)
			ARRAY TO SELECTION:C261(v_139_124_ab; [BridgeMHDNBISArchive:139]Item110:124; v_139_137_ab; [BridgeMHDNBISArchive:139]OnSystem:137; v_139_162_ab; [BridgeMHDNBISArchive:139]Item92AA:162; *)
			ARRAY TO SELECTION:C261(v_139_164_ab; [BridgeMHDNBISArchive:139]Item92BA:164; v_139_166_ab; [BridgeMHDNBISArchive:139]Item92CA:166; v_139_173_ab; [BridgeMHDNBISArchive:139]FHWARecord:173; *)
			ARRAY TO SELECTION:C261(v_139_175_ab; [BridgeMHDNBISArchive:139]JointlessBridge:175; v_139_176_ab; [BridgeMHDNBISArchive:139]OnTwnLine:176; v_139_177_ab; [BridgeMHDNBISArchive:139]Complex Bridge:177; *)
			ARRAY TO SELECTION:C261(v_139_181_ab; [BridgeMHDNBISArchive:139]OvrHeadSigns:181; v_139_193_ab; [BridgeMHDNBISArchive:139]Item12:193; v_139_209_ab; [BridgeMHDNBISArchive:139]UWSpInsp:209; *)
			ARRAY TO SELECTION:C261(v_139_216_ab; [BridgeMHDNBISArchive:139]Complex Rating:216; v_139_220_ab; [BridgeMHDNBISArchive:139]MissSigns:220; v_139_226_ab; [BridgeMHDNBISArchive:139]InspRequired:226)
		End if 
	: ($1=140)  //NBISSecondaryArchive
		$Array_Ptr:=->v_140_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_140_042_atxt; [NBISSecondaryArchive:140]NBISSecondaryArchive_UUIDKey_s:42; *)  //NBISSecondaryArchive_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_140_001_atxt; [NBISSecondaryArchive:140]BIN:1; v_140_002_atxt; [NBISSecondaryArchive:140]Item3:2; v_140_003_atxt; [NBISSecondaryArchive:140]Item4:3; *)
			ARRAY TO SELECTION:C261(v_140_004_atxt; [NBISSecondaryArchive:140]Item5:4; v_140_005_atxt; [NBISSecondaryArchive:140]Item6A:5; v_140_007_atxt; [NBISSecondaryArchive:140]Item7:7; *)
			ARRAY TO SELECTION:C261(v_140_008_atxt; [NBISSecondaryArchive:140]Item9:8; v_140_017_atxt; [NBISSecondaryArchive:140]Item20:17; v_140_018_atxt; [NBISSecondaryArchive:140]Item26:18; *)
			ARRAY TO SELECTION:C261(v_140_023_atxt; [NBISSecondaryArchive:140]Item42:23; v_140_024_atxt; [NBISSecondaryArchive:140]Item43:24; v_140_028_atxt; [NBISSecondaryArchive:140]Item100:28; *)
			ARRAY TO SELECTION:C261(v_140_029_atxt; [NBISSecondaryArchive:140]Item101:29; v_140_030_atxt; [NBISSecondaryArchive:140]Item102:30; v_140_034_atxt; [NBISSecondaryArchive:140]Bridge Key:34; *)
			ARRAY TO SELECTION:C261(v_140_038_atxt; [NBISSecondaryArchive:140]Item8:38; v_140_039_atxt; [NBISSecondaryArchive:140]ArchiveReason_s:39; *)
			ARRAY TO SELECTION:C261(v_140_009_ar; [NBISSecondaryArchive:140]Item10:9; v_140_011_ar; [NBISSecondaryArchive:140]Item11:11; v_140_025_ar; [NBISSecondaryArchive:140]Item47:25; *)
			ARRAY TO SELECTION:C261(v_140_026_ar; [NBISSecondaryArchive:140]Item48:26; v_140_027_ar; [NBISSecondaryArchive:140]Item49:27; v_140_035_ar; [NBISSecondaryArchive:140]Item16C:35; *)
			ARRAY TO SELECTION:C261(v_140_036_ar; [NBISSecondaryArchive:140]Item17C:36; *)
			ARRAY TO SELECTION:C261(v_140_010_ai; [NBISSecondaryArchive:140]Item109:10; v_140_012_ai; [NBISSecondaryArchive:140]Item16A:12; v_140_013_ai; [NBISSecondaryArchive:140]Item16B:13; *)
			ARRAY TO SELECTION:C261(v_140_014_ai; [NBISSecondaryArchive:140]Item17A:14; v_140_015_ai; [NBISSecondaryArchive:140]Item17B:15; v_140_016_ai; [NBISSecondaryArchive:140]Item19:16; *)
			ARRAY TO SELECTION:C261(v_140_019_ai; [NBISSecondaryArchive:140]Item27:19; v_140_020_ai; [NBISSecondaryArchive:140]Item28A:20; v_140_021_ai; [NBISSecondaryArchive:140]Item28B:21; *)
			ARRAY TO SELECTION:C261(v_140_037_ai; [NBISSecondaryArchive:140]Item30:37; *)
			ARRAY TO SELECTION:C261(v_140_022_aL; [NBISSecondaryArchive:140]Item29:22; v_140_041_aL; [NBISSecondaryArchive:140]NBISSecondaryKey_l:41; *)
			ARRAY TO SELECTION:C261(v_140_040_ad; [NBISSecondaryArchive:140]ArchiveDate_d:40; *)
			ARRAY TO SELECTION:C261(v_140_006_ab; [NBISSecondaryArchive:140]Item6B:6; v_140_031_ab; [NBISSecondaryArchive:140]Item103:31; v_140_032_ab; [NBISSecondaryArchive:140]Item104:32; *)
			ARRAY TO SELECTION:C261(v_140_033_ab; [NBISSecondaryArchive:140]Item110:33)
		End if 
	: ($1=141)  //PRJ_ProjectTypes
		$Array_Ptr:=->v_141_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_141_005_atxt; [PRJ_ProjectTypes:141]PRJ_ProjectTypes_UUIDKey_s:5; *)  //PRJ_ProjectTypes_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_141_001_atxt; [PRJ_ProjectTypes:141]PRTP_TypeCode_s:1; v_141_002_atxt; [PRJ_ProjectTypes:141]PRTP_Description_txt:2; *)
			ARRAY TO SELECTION:C261(v_141_003_ad; [PRJ_ProjectTypes:141]PRTP_Created_d:3; v_141_004_ad; [PRJ_ProjectTypes:141]PRTP_Modified_d:4)
		End if 
	: ($1=142)  //DCM_ProjDailyHrs
		$Array_Ptr:=->v_142_006_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_142_008_atxt; [DCM_ProjDailyHrs:142]DCM_ProjDailyHrs_UUIDKey_s:8; *)  //DCM_ProjDailyHrs_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_142_006_atxt; [DCM_ProjDailyHrs:142]Comments_txt:6; *)
			ARRAY TO SELECTION:C261(v_142_004_ar; [DCM_ProjDailyHrs:142]RegHrs_r:4; v_142_005_ar; [DCM_ProjDailyHrs:142]OTHrs_r:5; *)
			ARRAY TO SELECTION:C261(v_142_001_aL; [DCM_ProjDailyHrs:142]DailyIItemD_L:1; v_142_003_aL; [DCM_ProjDailyHrs:142]ArtisanNo_L:3; *)
			ARRAY TO SELECTION:C261(v_142_002_ad; [DCM_ProjDailyHrs:142]DailyDate:2; *)
			ARRAY TO SELECTION:C261(v_142_007_ab; [DCM_ProjDailyHrs:142]Dummy:7)
		End if 
	: ($1=143)  //DCM_ProjDailys
		$Array_Ptr:=->v_143_004_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_143_006_atxt; [DCM_ProjDailys:143]DCM_ProjDailys_UUIDKey_s:6; *)  //DCM_ProjDailys_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_143_002_aL; [DCM_ProjDailys:143]DailyID_L:2; *)
			
			ARRAY TO SELECTION:C261(v_143_004_atxt; [DCM_ProjDailys:143]Comments_txt:4; *)
			ARRAY TO SELECTION:C261(v_143_001_aL; [DCM_ProjDailys:143]ProjectID:1; *)
			ARRAY TO SELECTION:C261(v_143_003_ad; [DCM_ProjDailys:143]DailyDate_d:3; *)
			ARRAY TO SELECTION:C261(v_143_005_ab; [DCM_ProjDailys:143]Dummy_b:5)
		End if 
	: ($1=144)  //DCM_ProjDailyItems
		$Array_Ptr:=->v_144_003_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_144_006_atxt; [DCM_ProjDailyItems:144]DCM_ProjDailyItems_UUIDKey_s:6; *)  //DCM_ProjDailyItems_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_144_002_aL; [DCM_ProjDailyItems:144]DailyItemID_L:2; *)
			
			ARRAY TO SELECTION:C261(v_144_003_atxt; [DCM_ProjDailyItems:144]ItemNo_s:3; *)
			ARRAY TO SELECTION:C261(v_144_004_ar; [DCM_ProjDailyItems:144]ItemQuantity_r:4; *)
			ARRAY TO SELECTION:C261(v_144_001_aL; [DCM_ProjDailyItems:144]DailyID_L:1; *)
			ARRAY TO SELECTION:C261(v_144_005_ab; [DCM_ProjDailyItems:144]Dummy_b:5)
		End if 
	: ($1=145)  //Preservation_Reviews
		$Array_Ptr:=->v_145_003_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_145_017_atxt; [Preservation_Reviews:145]Preservation_Reviews_UUIDKey_s:17; *)  //Preservation_Reviews_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_145_001_aL; [Preservation_Reviews:145]Review_ID:1; *)
			
			ARRAY TO SELECTION:C261(v_145_003_atxt; [Preservation_Reviews:145]ReviewTYpe_s:3; v_145_006_atxt; [Preservation_Reviews:145]Reviewer_s:6; v_145_008_atxt; [Preservation_Reviews:145]Action_s:8; *)
			ARRAY TO SELECTION:C261(v_145_010_atxt; [Preservation_Reviews:145]CertificateType_s:10; v_145_011_atxt; [Preservation_Reviews:145]Comments_txt:11; *)
			ARRAY TO SELECTION:C261(v_145_002_aL; [Preservation_Reviews:145]AssignID:2; *)
			ARRAY TO SELECTION:C261(v_145_004_ad; [Preservation_Reviews:145]Received_d:4; v_145_005_ad; [Preservation_Reviews:145]SentToREviewer_d:5; v_145_007_ad; [Preservation_Reviews:145]CommentsRecd_d:7; *)
			ARRAY TO SELECTION:C261(v_145_009_ad; [Preservation_Reviews:145]SentBackToPM_d:9; v_145_012_ad; [Preservation_Reviews:145]Deadline_d:12; v_145_013_ad; [Preservation_Reviews:145]SentToDistr_d:13; *)
			ARRAY TO SELECTION:C261(v_145_014_ad; [Preservation_Reviews:145]ReviewerDeadline_d:14; v_145_015_ad; [Preservation_Reviews:145]DistrCmtsReviewed_d:15; v_145_016_ad; [Preservation_Reviews:145]ReceivedHardCopy_d:16)
		End if 
	: ($1=146)  //ONSQLAuthenticationErrors
		$Array_Ptr:=->v_146_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_146_007_atxt; [ONSQLAuthenticationErrors:146]ONSQLAuthenticationEr_UUIDKey_s:7; *)  //ONSQLAuthenticationEr_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_146_001_atxt; [ONSQLAuthenticationErrors:146]UserName_s:1; v_146_002_atxt; [ONSQLAuthenticationErrors:146]IPAddress_txt:2; v_146_003_atxt; [ONSQLAuthenticationErrors:146]Reason_txt:3; *)
			ARRAY TO SELECTION:C261(v_146_006_aL; [ONSQLAuthenticationErrors:146]NumberofAttempts_l:6; *)
			ARRAY TO SELECTION:C261(v_146_004_ad; [ONSQLAuthenticationErrors:146]LastLogin_d:4; *)
			ARRAY TO SELECTION:C261(v_146_005_atm; [ONSQLAuthenticationErrors:146]LastLogin_tm:5)
		End if 
	: ($1=147)  //LB_QueryTable
		$Array_Ptr:=->v_147_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_147_007_atxt; [LB_QueryTable:147]LB_QueryTable_UUIDKey_s:7; *)  //LB_QueryTable_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_147_006_aL; [LB_QueryTable:147]UniqueKey_l:6; *)
			
			ARRAY TO SELECTION:C261(v_147_001_atxt; [LB_QueryTable:147]QueryName_s:1; v_147_002_atxt; [LB_QueryTable:147]ColumnWidths_txt:2; v_147_004_atxt; [LB_QueryTable:147]TableName_s:4; *)
			ARRAY TO SELECTION:C261(v_147_005_atxt; [LB_QueryTable:147]WindowTitle_s:5; *)
			ARRAY TO SELECTION:C261(v_147_003_aL; [LB_QueryTable:147]TableNumber_l:3)
		End if 
	: ($1=148)  //Preservation_Meetings
		$Array_Ptr:=->v_148_003_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_148_012_atxt; [Preservation_Meetings:148]Preservation_Meetings_UUIDKey_s:12; *)  //Preservation_Meetings_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_148_001_aL; [Preservation_Meetings:148]MeetingID_L:1; *)
			
			ARRAY TO SELECTION:C261(v_148_003_atxt; [Preservation_Meetings:148]MeetingType_s:3; v_148_006_atxt; [Preservation_Meetings:148]Purpose_txt:6; v_148_007_atxt; [Preservation_Meetings:148]Summary_txt:7; *)
			ARRAY TO SELECTION:C261(v_148_008_atxt; [Preservation_Meetings:148]Location_txt:8; v_148_009_atxt; [Preservation_Meetings:148]Attendees_txt:9; *)
			ARRAY TO SELECTION:C261(v_148_010_ar; [Preservation_Meetings:148]Hours_r:10; *)
			ARRAY TO SELECTION:C261(v_148_002_aL; [Preservation_Meetings:148]AssignID:2; *)
			ARRAY TO SELECTION:C261(v_148_004_ad; [Preservation_Meetings:148]MeetingDate_d:4; *)
			ARRAY TO SELECTION:C261(v_148_005_atm; [Preservation_Meetings:148]MeetingTime_t:5; *)
			ARRAY TO SELECTION:C261(v_148_011_ab; [Preservation_Meetings:148]Reserved:11)
		End if 
	: ($1=149)  //BridgeInfoLink
		$Array_Ptr:=->v_149_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_149_011_atxt; [BridgeInfoLink:149]BridgeInfoLink_UUIDKey_s:11; *)  //BridgeInfoLink_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_149_001_atxt; [BridgeInfoLink:149]BIN:1; v_149_002_atxt; [BridgeInfoLink:149]ScourPriorityRankInfoLink_s:2; v_149_003_atxt; [BridgeInfoLink:149]RailInfoLink_s:3; *)
			ARRAY TO SELECTION:C261(v_149_004_atxt; [BridgeInfoLink:149]TunnelInfoLink_s:4; v_149_005_atxt; [BridgeInfoLink:149]ScourCriticalInfoLink_s:5; v_149_006_atxt; [BridgeInfoLink:149]FutureLink1_s:6; *)
			ARRAY TO SELECTION:C261(v_149_007_atxt; [BridgeInfoLink:149]FutureLink2_s:7; v_149_008_atxt; [BridgeInfoLink:149]FutureLink3_s:8; v_149_009_atxt; [BridgeInfoLink:149]FutureLink4_s:9; *)
			ARRAY TO SELECTION:C261(v_149_010_atxt; [BridgeInfoLink:149]FutureLink5_s:10)
		End if 
	: ($1=150)  //ScourCriticalInfo
		$Array_Ptr:=->v_150_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_150_017_atxt; [ScourCriticalInfo:150]ScourCriticalInfo_UUIDKey_s:17; *)  //ScourCriticalInfo_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_150_001_atxt; [ScourCriticalInfo:150]BIN:1; *)
			
			ARRAY TO SELECTION:C261(v_150_009_atxt; [ScourCriticalInfo:150]ProjInfo_s:9; v_150_015_atxt; [ScourCriticalInfo:150]SubItem113_s:15; v_150_016_atxt; [ScourCriticalInfo:150]Comments_txt:16; *)
			ARRAY TO SELECTION:C261(v_150_003_ad; [ScourCriticalInfo:150]POADate_d:3; v_150_010_ad; [ScourCriticalInfo:150]AdDate_d:10; v_150_013_ad; [ScourCriticalInfo:150]CounterMeasInstallDate_d:13; *)
			ARRAY TO SELECTION:C261(v_150_002_ab; [ScourCriticalInfo:150]POAUpToDate_b:2; v_150_004_ab; [ScourCriticalInfo:150]CounterMeasNeeded_b:4; v_150_005_ab; [ScourCriticalInfo:150]MonitoringNeeded_b:5; *)
			ARRAY TO SELECTION:C261(v_150_006_ab; [ScourCriticalInfo:150]VisualMonitoring_b:6; v_150_007_ab; [ScourCriticalInfo:150]InstrumentMonitoring_b:7; v_150_008_ab; [ScourCriticalInfo:150]InstrMonitoringInstalled_b:8; *)
			ARRAY TO SELECTION:C261(v_150_011_ab; [ScourCriticalInfo:150]TotalReplacement_b:11; v_150_012_ab; [ScourCriticalInfo:150]CounterMeasInstalled_b:12; v_150_014_ab; [ScourCriticalInfo:150]CounterMeasOnly_b:14)
		End if 
	: ($1=151)  //TunnelInfo
		$Array_Ptr:=->v_151_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_151_034_atxt; [TunnelInfo:151]TunnelInfo_UUIDKey_s:34; *)  //TunnelInfo_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_151_001_atxt; [TunnelInfo:151]BIN:1; *)
			
			ARRAY TO SELECTION:C261(v_151_002_atxt; [TunnelInfo:151]Contract_s:2; v_151_003_atxt; [TunnelInfo:151]ConstructionType_s:3; v_151_004_atxt; [TunnelInfo:151]StructureType_s:4; *)
			ARRAY TO SELECTION:C261(v_151_006_atxt; [TunnelInfo:151]Structural_Rtg_s:6; v_151_007_atxt; [TunnelInfo:151]Roadway_Rtg_s:7; v_151_008_atxt; [TunnelInfo:151]Ceiling_Rtg_s:8; *)
			ARRAY TO SELECTION:C261(v_151_009_atxt; [TunnelInfo:151]SupplyAirDuct_Rtg_s:9; v_151_010_atxt; [TunnelInfo:151]CrossPassage_Rtg_s:10; v_151_011_atxt; [TunnelInfo:151]Egress_Rtg_s:11; *)
			ARRAY TO SELECTION:C261(v_151_012_atxt; [TunnelInfo:151]UtilityRoom_Rtg_s:12; v_151_013_atxt; [TunnelInfo:151]Wetness_RTG_s:13; v_151_014_atxt; [TunnelInfo:151]Cleanliness_RTG_s:14; *)
			ARRAY TO SELECTION:C261(v_151_015_atxt; [TunnelInfo:151]AirMeter_s:15; v_151_016_atxt; [TunnelInfo:151]EscapeAir_s:16; v_151_017_atxt; [TunnelInfo:151]ScissorLift_s:17; *)
			ARRAY TO SELECTION:C261(v_151_018_atxt; [TunnelInfo:151]CreatedBy_s:18; v_151_019_atxt; [TunnelInfo:151]CreatedTimeStamp_s:19; v_151_020_atxt; [TunnelInfo:151]ModifiedBy_s:20; *)
			ARRAY TO SELECTION:C261(v_151_021_atxt; [TunnelInfo:151]ModifiedTimeStamp_s:21; v_151_030_atxt; [TunnelInfo:151]SpecialInsp1Desc_s:30; v_151_031_atxt; [TunnelInfo:151]SpecialInsp2Desc_s:31; *)
			ARRAY TO SELECTION:C261(v_151_032_atxt; [TunnelInfo:151]SpecialInsp3Desc_s:32; v_151_033_atxt; [TunnelInfo:151]NTI_i1_s:33; *)
			ARRAY TO SELECTION:C261(v_151_023_ai; [TunnelInfo:151]OverHeadInspFreq_i:23; v_151_025_ai; [TunnelInfo:151]SpecialInsp1Freq_i:25; v_151_027_ai; [TunnelInfo:151]SpecialInsp2Freq_i:27; *)
			ARRAY TO SELECTION:C261(v_151_029_ai; [TunnelInfo:151]SpecialInsp3Freq_i:29; *)
			ARRAY TO SELECTION:C261(v_151_022_ad; [TunnelInfo:151]OverHeadInspDate_d:22; v_151_024_ad; [TunnelInfo:151]SpecialInsp1Date_d:24; v_151_026_ad; [TunnelInfo:151]SpecialInsp2Date_d:26; *)
			ARRAY TO SELECTION:C261(v_151_028_ad; [TunnelInfo:151]SpecialInsp3Date_d:28; *)
			ARRAY TO SELECTION:C261(v_151_005_ab; [TunnelInfo:151]ChemicalAnchors_b:5)
		End if 
	: ($1=152)  //TunnelInspection
		$Array_Ptr:=->v_152_003_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_152_031_atxt; [TunnelInspection:152]TunnelInspection_UUIDKey_s:31; *)  //TunnelInspection_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_152_015_aL; [TunnelInspection:152]TunnelInspID_L:15; *)
			
			ARRAY TO SELECTION:C261(v_152_003_atxt; [TunnelInspection:152]Structural_Rtg_s:3; v_152_004_atxt; [TunnelInspection:152]Roadway_Rtg_s:4; v_152_005_atxt; [TunnelInspection:152]Ceiling_Rtg_s:5; *)
			ARRAY TO SELECTION:C261(v_152_006_atxt; [TunnelInspection:152]SupplyAirDuct_Rtg_s:6; v_152_007_atxt; [TunnelInspection:152]CrossPassage_Rtg_s:7; v_152_008_atxt; [TunnelInspection:152]Egress_Rtg_s:8; *)
			ARRAY TO SELECTION:C261(v_152_009_atxt; [TunnelInspection:152]UtilityRoom_Rtg_s:9; v_152_010_atxt; [TunnelInspection:152]Wetness_Rtg_s:10; v_152_011_atxt; [TunnelInspection:152]Cleanliness_Rtg_s:11; *)
			ARRAY TO SELECTION:C261(v_152_012_atxt; [TunnelInspection:152]AirMeter_s:12; v_152_013_atxt; [TunnelInspection:152]EscapeAir_s:13; v_152_014_atxt; [TunnelInspection:152]ScissorLift_s:14; *)
			ARRAY TO SELECTION:C261(v_152_016_atxt; [TunnelInspection:152]Structural_Prev_Rtg_s:16; v_152_017_atxt; [TunnelInspection:152]Roadway_Prev_Rtg_s:17; v_152_018_atxt; [TunnelInspection:152]Ceiling_Prev_Rtg_s:18; *)
			ARRAY TO SELECTION:C261(v_152_019_atxt; [TunnelInspection:152]SupplyAirDuct_Prev_Rtg_s:19; v_152_020_atxt; [TunnelInspection:152]CrossPassage_Prev_Rtg_s:20; v_152_021_atxt; [TunnelInspection:152]Egress_Prev_Rtg_s:21; *)
			ARRAY TO SELECTION:C261(v_152_022_atxt; [TunnelInspection:152]UtilityRoom_Prev_Rtg_s:22; v_152_023_atxt; [TunnelInspection:152]Wetness_Prev_Rtg_s:23; v_152_024_atxt; [TunnelInspection:152]Cleanliness_Prev_Rtg_s:24; *)
			ARRAY TO SELECTION:C261(v_152_027_atxt; [TunnelInspection:152]StructuralCollisionValue_s:27; v_152_028_atxt; [TunnelInspection:152]StructuralCollisionComments_txt:28; v_152_029_atxt; [TunnelInspection:152]RoadwayCollisionValue_s:29; *)
			ARRAY TO SELECTION:C261(v_152_030_atxt; [TunnelInspection:152]RoadwayCollisionComments_txt:30; *)
			ARRAY TO SELECTION:C261(v_152_001_aL; [TunnelInspection:152]InspID:1; v_152_002_aL; [TunnelInspection:152]QA_QC_L:2; *)
			ARRAY TO SELECTION:C261(v_152_026_ad; [TunnelInspection:152]OverHeadInspDate_d:26; *)
			ARRAY TO SELECTION:C261(v_152_025_ab; [TunnelInspection:152]ChemicalAnchors_b:25)
		End if 
	: ($1=153)  //IS_ControlProcess
		$Array_Ptr:=->v_153_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_153_024_atxt; [IS_ControlProcess:153]IS_ControlProcess_UUIDKey_s:24; *)  //IS_ControlProcess_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_153_001_atxt; [IS_ControlProcess:153]CP_MethodName_s:1; v_153_002_atxt; [IS_ControlProcess:153]CP_ProcessRunSchedule_s:2; *)
			ARRAY TO SELECTION:C261(v_153_003_atxt; [IS_ControlProcess:153]CP_LastRunStartTimeStamp_s:3; v_153_004_atxt; [IS_ControlProcess:153]CP_NextRunTimeStamp_s:4; v_153_008_atxt; [IS_ControlProcess:153]CP_ClientName_s:8; *)
			ARRAY TO SELECTION:C261(v_153_011_atxt; [IS_ControlProcess:153]CP_Email_s:11; v_153_012_atxt; [IS_ControlProcess:153]CP_Error_s:12; v_153_014_atxt; [IS_ControlProcess:153]CP_LastRunEndTimeStamp_s:14; *)
			ARRAY TO SELECTION:C261(v_153_018_atxt; [IS_ControlProcess:153]CP_WeekToUse_s:18; v_153_022_atxt; [IS_ControlProcess:153]CP_ProcessName_s:22; *)
			ARRAY TO SELECTION:C261(v_153_006_aL; [IS_ControlProcess:153]CP_ControlProcessdelay_l:6; v_153_007_aL; [IS_ControlProcess:153]CP_WhereToRun_l:7; v_153_009_aL; [IS_ControlProcess:153]CP_ProcessNumber_l:9; *)
			ARRAY TO SELECTION:C261(v_153_010_aL; [IS_ControlProcess:153]CP_StackSize_l:10; v_153_016_aL; [IS_ControlProcess:153]CP_DayOfWeek_l:16; v_153_017_aL; [IS_ControlProcess:153]CP_NumberOfHistories_l:17; *)
			ARRAY TO SELECTION:C261(v_153_019_aL; [IS_ControlProcess:153]CP_BeginSkipTime_l:19; v_153_020_aL; [IS_ControlProcess:153]CP_EndSkipTime_l:20; v_153_021_aL; [IS_ControlProcess:153]CP_PrimaryKey_l:21; *)
			ARRAY TO SELECTION:C261(v_153_005_ab; [IS_ControlProcess:153]CP_ProcessRunning_b:5; v_153_015_ab; [IS_ControlProcess:153]CP_MustRunLastDay_b:15; v_153_023_ab; [IS_ControlProcess:153]CP_AllowMultipleClients_b:23)
		End if 
	: ($1=154)  //RatingRequests
		$Array_Ptr:=->v_154_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_154_019_atxt; [RatingRequests:154]RatingRequests_UUIDKey_s:19; *)  //RatingRequests_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_154_002_aL; [RatingRequests:154]RatingRequestID_L:2; *)
			
			ARRAY TO SELECTION:C261(v_154_001_atxt; [RatingRequests:154]BIN:1; v_154_005_atxt; [RatingRequests:154]Priority_s:5; v_154_006_atxt; [RatingRequests:154]ActionByAreaEng_s:6; *)
			ARRAY TO SELECTION:C261(v_154_008_atxt; [RatingRequests:154]CommentsByAreaEng_txt:8; v_154_009_atxt; [RatingRequests:154]ActionByBrgInspEng_s:9; v_154_011_atxt; [RatingRequests:154]CommentsbyBrgInspEng_txt:11; *)
			ARRAY TO SELECTION:C261(v_154_012_atxt; [RatingRequests:154]ActionByStateBridgeEng_s:12; v_154_014_atxt; [RatingRequests:154]CommentsByStateBridgeEng_txt:14; v_154_015_atxt; [RatingRequests:154]Status_s:15; *)
			ARRAY TO SELECTION:C261(v_154_017_aL; [RatingRequests:154]ContractNo_L:17; v_154_018_aL; [RatingRequests:154]AssignmentNo_L:18; *)
			ARRAY TO SELECTION:C261(v_154_003_ad; [RatingRequests:154]DateOfRequest_d:3; v_154_004_ad; [RatingRequests:154]DateOfInspReport_d:4; v_154_007_ad; [RatingRequests:154]ActionByAreaEngDate_d:7; *)
			ARRAY TO SELECTION:C261(v_154_010_ad; [RatingRequests:154]ActionByBrgInspEngDate_d:10; v_154_013_ad; [RatingRequests:154]ActionByStateBridgeEngDate_d:13; v_154_016_ad; [RatingRequests:154]StatusDate_d:16)
		End if 
	: ($1=155)  //AddtlRatingRequests
		$Array_Ptr:=->v_155_004_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_155_005_atxt; [AddtlRatingRequests:155]AddtlRatingRequests_UUIDKey_s:5; *)  //AddtlRatingRequests_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_155_002_aL; [AddtlRatingRequests:155]AddtlRequestID_L:2; *)
			
			ARRAY TO SELECTION:C261(v_155_004_atxt; [AddtlRatingRequests:155]Comments_txt:4; *)
			ARRAY TO SELECTION:C261(v_155_001_aL; [AddtlRatingRequests:155]RatingRequestID_L:1; *)
			ARRAY TO SELECTION:C261(v_155_003_ad; [AddtlRatingRequests:155]NewRequestDate_d:3)
		End if 
	: ($1=156)  //BridgeRankCalc
		$Array_Ptr:=->v_156_003_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_156_009_atxt; [BridgeRankCalc:156]BridgeRankCalc_UUIDKey_s:9; *)  //BridgeRankCalc_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_156_001_aL; [BridgeRankCalc:156]RunID_L:1; *)
			
			ARRAY TO SELECTION:C261(v_156_003_atxt; [BridgeRankCalc:156]DataSource_s:3; v_156_005_atxt; [BridgeRankCalc:156]ArchivePurpose_s:5; v_156_007_atxt; [BridgeRankCalc:156]Comments_txt:7; *)
			ARRAY TO SELECTION:C261(v_156_002_ad; [BridgeRankCalc:156]RunDate_d:2; v_156_004_ad; [BridgeRankCalc:156]ArchiveDate_d:4; v_156_006_ad; [BridgeRankCalc:156]PontisMetricDate_d:6; *)
			ARRAY TO SELECTION:C261(v_156_008_ab; [BridgeRankCalc:156]Hidden_b:8)
		End if 
	: ($1=157)  //BridgeRankResult
		$Array_Ptr:=->v_157_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_157_021_atxt; [BridgeRankResult:157]BridgeRankResult_UUIDKey_s:21; *)  //BridgeRankResult_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_157_002_atxt; [BridgeRankResult:157]UniqueKey_s:2; *)
			
			ARRAY TO SELECTION:C261(v_157_003_atxt; [BridgeRankResult:157]BIN:3; v_157_016_atxt; [BridgeRankResult:157]ScourCritical_s:16; *)
			ARRAY TO SELECTION:C261(v_157_005_ar; [BridgeRankResult:157]RankFactor_r:5; v_157_006_ar; [BridgeRankResult:157]HIChangePct_r:6; v_157_007_ar; [BridgeRankResult:157]HWYEvalFactor_r:7; *)
			ARRAY TO SELECTION:C261(v_157_008_ar; [BridgeRankResult:157]BridgeEvalFactor_r:8; v_157_009_ar; [BridgeRankResult:157]ConditionLost_r:9; v_157_010_ar; [BridgeRankResult:157]AdjHIChange_r:10; *)
			ARRAY TO SELECTION:C261(v_157_011_ar; [BridgeRankResult:157]ADTValue_r:11; v_157_012_ar; [BridgeRankResult:157]DetourValue_r:12; v_157_013_ar; [BridgeRankResult:157]ClassValue_r:13; *)
			ARRAY TO SELECTION:C261(v_157_014_ar; [BridgeRankResult:157]StructEvalValue_r:14; v_157_015_ar; [BridgeRankResult:157]DeckValue_r:15; v_157_017_ar; [BridgeRankResult:157]AvgCondition_r:17; *)
			ARRAY TO SELECTION:C261(v_157_001_aL; [BridgeRankResult:157]RunID_L:1; v_157_004_aL; [BridgeRankResult:157]Rank_L:4; v_157_018_aL; [BridgeRankResult:157]FinalRank_L:18; *)
			ARRAY TO SELECTION:C261(v_157_019_aL; [BridgeRankResult:157]DistrictRank_L:19; *)
			ARRAY TO SELECTION:C261(v_157_020_ab; [BridgeRankResult:157]Excluded_b:20)
		End if 
	: ($1=158)  //ElmtRatingLoads
		$Array_Ptr:=->v_158_013_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_158_015_atxt; [ElmtRatingLoads:158]ElmtRatingLoads_UUIDKey_s:15; *)  //ElmtRatingLoads_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_158_001_aL; [ElmtRatingLoads:158]ElmtRtgLoadID_L:1; *)
			
			ARRAY TO SELECTION:C261(v_158_013_atxt; [ElmtRatingLoads:158]Dummy2_s:13; *)
			ARRAY TO SELECTION:C261(v_158_003_ar; [ElmtRatingLoads:158]R_E80_r:3; v_158_004_ar; [ElmtRatingLoads:158]R_F40PH_r:4; v_158_005_ar; [ElmtRatingLoads:158]R_286K_r:5; *)
			ARRAY TO SELECTION:C261(v_158_006_ar; [ElmtRatingLoads:158]R_263K_r:6; v_158_007_ar; [ElmtRatingLoads:158]R_315K_r:7; v_158_008_ar; [ElmtRatingLoads:158]R_Neoplan_r:8; *)
			ARRAY TO SELECTION:C261(v_158_009_ar; [ElmtRatingLoads:158]R_NABI_r:9; v_158_010_ar; [ElmtRatingLoads:158]R_Revenue_r:10; v_158_011_ar; [ElmtRatingLoads:158]R_HSP46_r:11; *)
			ARRAY TO SELECTION:C261(v_158_012_ar; [ElmtRatingLoads:158]R_WorkCar_r:12; v_158_014_ar; [ElmtRatingLoads:158]R_HybridArtic_r:14; *)
			ARRAY TO SELECTION:C261(v_158_002_aL; [ElmtRatingLoads:158]ElmSafetyID:2)
		End if 
	: ($1=159)  //LSS_Accessibility
		$Array_Ptr:=->v_159_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_159_007_atxt; [LSS_Accessibility:159]LSS_Accessibility_UUIDKey_s:7; *)  //LSS_Accessibility_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_159_001_atxt; [LSS_Accessibility:159]LSS_AccessibilityId_s:1; *)
			
			ARRAY TO SELECTION:C261(v_159_003_atxt; [LSS_Accessibility:159]LSS_InspectionId_s:3; v_159_004_atxt; [LSS_Accessibility:159]LSS_Needed_s:4; v_159_005_atxt; [LSS_Accessibility:159]LSS_Used_s:5; *)
			ARRAY TO SELECTION:C261(v_159_006_atxt; [LSS_Accessibility:159]LSS_AccessibilityDescription_s:6; *)
			ARRAY TO SELECTION:C261(v_159_002_aL; [LSS_Accessibility:159]LSS_AccessibilityElementId_L:2)
		End if 
	: ($1=160)  //LSS_AccessibilityElement
		$Array_Ptr:=->v_160_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_160_003_atxt; [LSS_AccessibilityElement:160]LSS_AccessibilityElem_UUIDKey_s:3; *)  //LSS_AccessibilityElem_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_160_001_aL; [LSS_AccessibilityElement:160]LSS_AccessibilityElementId_L:1; *)
			
			ARRAY TO SELECTION:C261(v_160_002_atxt; [LSS_AccessibilityElement:160]LSS_Description_txt:2)
		End if 
	: ($1=161)  //LSS_DMeter
		$Array_Ptr:=->v_161_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_161_010_atxt; [LSS_DMeter:161]LSS_DMeter_UUIDKey_s:10; *)  //LSS_DMeter_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_161_001_atxt; [LSS_DMeter:161]LSS_DMeterId_s:1; *)
			
			ARRAY TO SELECTION:C261(v_161_002_atxt; [LSS_DMeter:161]LSS_InspectionId_s:2; v_161_003_atxt; [LSS_DMeter:161]LSS_Location_s:3; v_161_004_atxt; [LSS_DMeter:161]LSS_A_s:4; *)
			ARRAY TO SELECTION:C261(v_161_005_atxt; [LSS_DMeter:161]LSS_B_s:5; v_161_006_atxt; [LSS_DMeter:161]LSS_C_s:6; v_161_007_atxt; [LSS_DMeter:161]LSS_D_s:7; *)
			ARRAY TO SELECTION:C261(v_161_008_atxt; [LSS_DMeter:161]LSS_Reference_s:8; *)
			ARRAY TO SELECTION:C261(v_161_009_ad; [LSS_DMeter:161]LSS_DMeterDate_d:9)
		End if 
	: ($1=162)  //LSS_Element
		$Array_Ptr:=->v_162_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_162_005_atxt; [LSS_Element:162]LSS_Element_UUIDKey_s:5; *)  //LSS_Element_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_162_001_aL; [LSS_Element:162]LSS_ElementId_L:1; *)
			
			ARRAY TO SELECTION:C261(v_162_002_atxt; [LSS_Element:162]LSS_ElementDescription_s:2; *)
			ARRAY TO SELECTION:C261(v_162_003_ab; [LSS_Element:162]LSS_ElementHeader_b:3; v_162_004_ab; [LSS_Element:162]LSS_CustomElement_b:4)
		End if 
	: ($1=163)  //LSS_ElementInspection
		$Array_Ptr:=->v_163_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_163_010_atxt; [LSS_ElementInspection:163]LSS_ElementInspection_UUIDKey_s:10; *)  //LSS_ElementInspection_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_163_001_atxt; [LSS_ElementInspection:163]LSS_ElementInspectionId_s:1; *)
			
			ARRAY TO SELECTION:C261(v_163_003_atxt; [LSS_ElementInspection:163]LSS_InspectionId_s:3; v_163_004_atxt; [LSS_ElementInspection:163]LSS_Rating_s:4; v_163_005_atxt; [LSS_ElementInspection:163]LSS_Deficiency_s:5; *)
			ARRAY TO SELECTION:C261(v_163_006_atxt; [LSS_ElementInspection:163]LSS_Urgency_s:6; v_163_007_atxt; [LSS_ElementInspection:163]LSS_Description_txt:7; v_163_008_atxt; [LSS_ElementInspection:163]LSS_Remarks_txt:8; *)
			ARRAY TO SELECTION:C261(v_163_012_atxt; [LSS_ElementInspection:163]LSS_DamageCurrentCondition_s:12; v_163_013_atxt; [LSS_ElementInspection:163]LSS_DamagePreviousCondition_s:13; v_163_014_atxt; [LSS_ElementInspection:163]LSS_DamageWeldCondition_s:14; *)
			ARRAY TO SELECTION:C261(v_163_002_aL; [LSS_ElementInspection:163]LSS_ElementId_L:2; v_163_009_aL; [LSS_ElementInspection:163]LSS_SectionID_L:9; *)
			ARRAY TO SELECTION:C261(v_163_011_ab; [LSS_ElementInspection:163]LSS_DamageCrack_B:11)
		End if 
	: ($1=164)  //LSS_Inspection
		$Array_Ptr:=->v_164_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_164_051_atxt; [LSS_Inspection:164]LSS_Inspection_UUIDKey_s:51; *)  //LSS_Inspection_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_164_001_atxt; [LSS_Inspection:164]LSS_InspectionId_s:1; *)
			
			ARRAY TO SELECTION:C261(v_164_002_atxt; [LSS_Inspection:164]LSS_InventoryId_s:2; v_164_003_atxt; [LSS_Inspection:164]LSS_InspectionTypeId_s:3; v_164_006_atxt; [LSS_Inspection:164]LSS_Weather_s:6; *)
			ARRAY TO SELECTION:C261(v_164_007_atxt; [LSS_Inspection:164]LSS_AirTempF_s:7; v_164_010_atxt; [LSS_Inspection:164]LSS_ConsultantName_txt:10; v_164_012_atxt; [LSS_Inspection:164]LSS_CondFoundationCurr_s:12; *)
			ARRAY TO SELECTION:C261(v_164_013_atxt; [LSS_Inspection:164]LSS_CondFoundationPrev_s:13; v_164_014_atxt; [LSS_Inspection:164]LSS_CondStructureCurr_s:14; v_164_015_atxt; [LSS_Inspection:164]LSS_CondStructurePrev_s:15; *)
			ARRAY TO SELECTION:C261(v_164_016_atxt; [LSS_Inspection:164]LSS_StructAttachmentsCurr_s:16; v_164_017_atxt; [LSS_Inspection:164]LSS_StructAttachmentsPrev_s:17; v_164_018_atxt; [LSS_Inspection:164]LSS_CondSignPanelsCurr_s:18; *)
			ARRAY TO SELECTION:C261(v_164_019_atxt; [LSS_Inspection:164]LSS_CondSignPanelsPrev_s:19; v_164_020_atxt; [LSS_Inspection:164]LSS_CondTrafficSafetyCurr_s:20; v_164_021_atxt; [LSS_Inspection:164]LSS_CondTrafficSafetyPrev_s:21; *)
			ARRAY TO SELECTION:C261(v_164_022_atxt; [LSS_Inspection:164]LSS_CondLuminaireCurr_s:22; v_164_023_atxt; [LSS_Inspection:164]LSS_CondLuminairePrev_s:23; v_164_024_atxt; [LSS_Inspection:164]LSS_CondOverallCurr_s:24; *)
			ARRAY TO SELECTION:C261(v_164_025_atxt; [LSS_Inspection:164]LSS_CondOverallPrev_s:25; v_164_026_atxt; [LSS_Inspection:164]LSS_Recommendations_txt:26; v_164_031_atxt; [LSS_Inspection:164]LSS_FieldTestPerformed_txt:31; *)
			ARRAY TO SELECTION:C261(v_164_032_atxt; [LSS_Inspection:164]LSS_GeneralComments_txt:32; v_164_033_atxt; [LSS_Inspection:164]LSS_CsrRating_txt:33; v_164_034_atxt; [LSS_Inspection:164]LSS_CsrRatingYear_txt:34; *)
			ARRAY TO SELECTION:C261(v_164_035_atxt; [LSS_Inspection:164]LSS_LanesUnderStructure_txt:35; v_164_036_atxt; [LSS_Inspection:164]LSS_ADT_s:36; v_164_037_atxt; [LSS_Inspection:164]LSS_ADTYear_s:37; *)
			ARRAY TO SELECTION:C261(v_164_038_atxt; [LSS_Inspection:164]LSS_AdditionalComments_txt:38; v_164_045_atxt; [LSS_Inspection:164]LSS_CreatedBy_s:45; v_164_046_atxt; [LSS_Inspection:164]LSS_CreatedISODate_s:46; *)
			ARRAY TO SELECTION:C261(v_164_047_atxt; [LSS_Inspection:164]LSS_ModifiedBy_s:47; v_164_048_atxt; [LSS_Inspection:164]LSS_ModifiedISODate_s:48; v_164_049_atxt; [LSS_Inspection:164]LSS_ApprovalComments_txt:49; *)
			ARRAY TO SELECTION:C261(v_164_050_atxt; [LSS_Inspection:164]LSS_DMeterNotes_txt:50; v_164_053_atxt; [LSS_Inspection:164]LSS_DamageBy_s:53; v_164_055_atxt; [LSS_Inspection:164]LSS_DamageReimbursementNo_s:55; *)
			ARRAY TO SELECTION:C261(v_164_056_atxt; [LSS_Inspection:164]LSS_DamageCause_txt:56; v_164_057_atxt; [LSS_Inspection:164]LSS_DamBostonCopyForwardTo_s:57; v_164_059_atxt; [LSS_Inspection:164]LSS_DamBostonOfficeRemarks_txt:59; *)
			ARRAY TO SELECTION:C261(v_164_027_ar; [LSS_Inspection:164]LSS_TotalAccessibilityHours_r:27; *)
			ARRAY TO SELECTION:C261(v_164_005_aL; [LSS_Inspection:164]LSS_DistHWYEngineerId_L:5; v_164_008_aL; [LSS_Inspection:164]LSS_TeamLeaderId_L:8; v_164_009_aL; [LSS_Inspection:164]LSS_ProjectManagerId_L:9; *)
			ARRAY TO SELECTION:C261(v_164_041_aL; [LSS_Inspection:164]LSS_Reviewed_L:41; v_164_043_aL; [LSS_Inspection:164]LSS_Approved_L:43; *)
			ARRAY TO SELECTION:C261(v_164_004_ad; [LSS_Inspection:164]LSS_InspectionDate_d:4; v_164_030_ad; [LSS_Inspection:164]LSS_DateOfPhotos_d:30; v_164_040_ad; [LSS_Inspection:164]LSS_CompleteDate_d:40; *)
			ARRAY TO SELECTION:C261(v_164_042_ad; [LSS_Inspection:164]LSS_ReviewDate_d:42; v_164_044_ad; [LSS_Inspection:164]LSS_ApprovedDate_d:44; v_164_052_ad; [LSS_Inspection:164]LSS_Damage_d:52; *)
			ARRAY TO SELECTION:C261(v_164_058_ad; [LSS_Inspection:164]LSS_DamBostonOffice_d:58; *)
			ARRAY TO SELECTION:C261(v_164_011_ab; [LSS_Inspection:164]LSS_Cracks_b:11; v_164_028_ab; [LSS_Inspection:164]LSS_Plans_b:28; v_164_029_ab; [LSS_Inspection:164]LSS_Photos_b:29; *)
			ARRAY TO SELECTION:C261(v_164_039_ab; [LSS_Inspection:164]LSS_Complete_b:39; v_164_054_ab; [LSS_Inspection:164]LSS_DamageAccidentReport_B:54)
		End if 
	: ($1=165)  //LSS_Inventory
		$Array_Ptr:=->v_165_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_165_033_atxt; [LSS_Inventory:165]LSS_Inventory_UUIDKey_s:33; *)  //LSS_Inventory_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_165_001_atxt; [LSS_Inventory:165]LSS_InventoryId_s:1; *)
			
			ARRAY TO SELECTION:C261(v_165_002_atxt; [LSS_Inventory:165]LSS_Category_s:2; v_165_004_atxt; [LSS_Inventory:165]LSS_Town_s:4; v_165_006_atxt; [LSS_Inventory:165]LSS_StructureNumber_s:6; *)
			ARRAY TO SELECTION:C261(v_165_009_atxt; [LSS_Inventory:165]LSS_Route_s:9; v_165_010_atxt; [LSS_Inventory:165]LSS_StructureLocation_txt:10; v_165_011_atxt; [LSS_Inventory:165]LSS_YearBuilt_s:11; *)
			ARRAY TO SELECTION:C261(v_165_012_atxt; [LSS_Inventory:165]LSS_YearRemoved_s:12; v_165_013_atxt; [LSS_Inventory:165]LSS_YearRehabbed_s:13; v_165_014_atxt; [LSS_Inventory:165]LSS_RouteDirection_s:14; *)
			ARRAY TO SELECTION:C261(v_165_015_atxt; [LSS_Inventory:165]LSS_StructureMaterialId_s:15; v_165_016_atxt; [LSS_Inventory:165]LSS_StructureCoatingId_s:16; v_165_017_atxt; [LSS_Inventory:165]LSS_AssetNo_txt:17; *)
			ARRAY TO SELECTION:C261(v_165_021_atxt; [LSS_Inventory:165]LSS_SpanArmLength1_txt:21; v_165_022_atxt; [LSS_Inventory:165]LSS_SpanArmLength2_txt:22; v_165_023_atxt; [LSS_Inventory:165]LSS_IntersectionNo_txt:23; *)
			ARRAY TO SELECTION:C261(v_165_024_atxt; [LSS_Inventory:165]LSS_DistFRMBasePlateToArm_txt:24; v_165_025_atxt; [LSS_Inventory:165]LSS_StructureTypeId_s:25; v_165_026_atxt; [LSS_Inventory:165]LSS_DistFRMBasePlateToArm2_txt:26; *)
			ARRAY TO SELECTION:C261(v_165_027_atxt; [LSS_Inventory:165]LSS_CreatedBy_s:27; v_165_028_atxt; [LSS_Inventory:165]LSS_InventoryType_s:28; v_165_029_atxt; [LSS_Inventory:165]LSS_CreatedISODate_s:29; *)
			ARRAY TO SELECTION:C261(v_165_030_atxt; [LSS_Inventory:165]LSS_ModifiedBy_s:30; v_165_031_atxt; [LSS_Inventory:165]LSS_ModifiedISODate_s:31; v_165_034_atxt; [LSS_Inventory:165]LSS_Owner_s:34; *)
			ARRAY TO SELECTION:C261(v_165_035_atxt; [LSS_Inventory:165]LSS_Status_s:35; v_165_036_atxt; [LSS_Inventory:165]LSS_StatusDate_s:36; *)
			ARRAY TO SELECTION:C261(v_165_007_ar; [LSS_Inventory:165]LSS_KiloPoint_r:7; v_165_008_ar; [LSS_Inventory:165]LSS_MilePoint_r:8; v_165_018_ar; [LSS_Inventory:165]LSS_Longitude_r:18; *)
			ARRAY TO SELECTION:C261(v_165_019_ar; [LSS_Inventory:165]LSS_Latitude_r:19; v_165_032_ar; [LSS_Inventory:165]LSS_Elevation_r:32; *)
			ARRAY TO SELECTION:C261(v_165_003_aL; [LSS_Inventory:165]LSS_District_L:3; v_165_005_aL; [LSS_Inventory:165]LSS_IdentificationNumber_L:5; v_165_020_aL; [LSS_Inventory:165]LSS_NumberOfSpansArms_L:20; *)
			ARRAY TO SELECTION:C261(v_165_037_aL; [LSS_Inventory:165]LSS_ProjNoBuilt_L:37; v_165_038_aL; [LSS_Inventory:165]LSS_ProjNoRemoved_L:38)
		End if 
	: ($1=166)  //LSS_Photos
		$Array_Ptr:=->v_166_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_166_007_atxt; [LSS_Photos:166]LSS_Photos_UUIDKey_s:7; *)  //LSS_Photos_UUIDKey_s
			End if 
			If (clone_UseBlobArrays_B)
				ARRAY TO SELECTION:C261(v_166_005_ablb; [LSS_Photos:166]LSS_Photo_blb:5; *)
			Else 
				clone_GetBlobs($1)
			End if 
			ARRAY TO SELECTION:C261(v_166_001_atxt; [LSS_Photos:166]LSS_PhotoId_s:1; *)
			
			ARRAY TO SELECTION:C261(v_166_002_atxt; [LSS_Photos:166]LSS_InspectionId_s:2; v_166_003_atxt; [LSS_Photos:166]LSS_PhotoType_s:3; *)
			ARRAY TO SELECTION:C261(v_166_004_atxt; [LSS_Photos:166]LSS_Photo_txt:4; *)
			ARRAY TO SELECTION:C261(v_166_006_aL; [LSS_Photos:166]LSS_PhotoSequence_L:6)
		End if 
	: ($1=167)  //LSS_refInspectionType
		$Array_Ptr:=->v_167_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_167_004_atxt; [LSS_refInspectionType:167]LSS_refInspectionType_UUIDKey_s:4; *)  //LSS_refInspectionType_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_167_001_atxt; [LSS_refInspectionType:167]LSS_InspectionTypeId_s:1; *)
			
			ARRAY TO SELECTION:C261(v_167_002_atxt; [LSS_refInspectionType:167]LSS_Description_txt:2; v_167_003_atxt; [LSS_refInspectionType:167]LSS_AllowedElements_txt:3)
		End if 
	: ($1=168)  //LSS_refRouteDirection
		$Array_Ptr:=->v_168_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_168_003_atxt; [LSS_refRouteDirection:168]LSS_refRouteDirection_UUIDKey_s:3; *)  //LSS_refRouteDirection_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_168_001_atxt; [LSS_refRouteDirection:168]LSS_RouteDirectionId_s:1; *)
			
			ARRAY TO SELECTION:C261(v_168_002_atxt; [LSS_refRouteDirection:168]LSS_Description_txt:2)
		End if 
	: ($1=169)  //LSS_refStructureCoating
		$Array_Ptr:=->v_169_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_169_003_atxt; [LSS_refStructureCoating:169]LSS_refStructureCoati_UUIDKey_s:3; *)  //LSS_refStructureCoati_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_169_001_atxt; [LSS_refStructureCoating:169]LSS_StructureCoatingId_s:1; *)
			
			ARRAY TO SELECTION:C261(v_169_002_atxt; [LSS_refStructureCoating:169]LSS_Description_txt:2)
		End if 
	: ($1=170)  //LSS_refStructureMaterial
		$Array_Ptr:=->v_170_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_170_003_atxt; [LSS_refStructureMaterial:170]LSS_refStructureMater_UUIDKey_s:3; *)  //LSS_refStructureMater_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_170_001_atxt; [LSS_refStructureMaterial:170]LSS_StructureMaterialId_s:1; *)
			
			ARRAY TO SELECTION:C261(v_170_002_atxt; [LSS_refStructureMaterial:170]LSS_Description_txt:2)
		End if 
	: ($1=171)  //LSS_refStructureTypes
		$Array_Ptr:=->v_171_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_171_004_atxt; [LSS_refStructureTypes:171]LSS_refStructureTypes_UUIDKey_s:4; *)  //LSS_refStructureTypes_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_171_001_atxt; [LSS_refStructureTypes:171]LSS_StructureTypeId_s:1; *)
			
			ARRAY TO SELECTION:C261(v_171_002_atxt; [LSS_refStructureTypes:171]LSS_Category_s:2; v_171_003_atxt; [LSS_refStructureTypes:171]LSS_Description_txt:3)
		End if 
	: ($1=172)  //LSS_SignPanel
		$Array_Ptr:=->v_172_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_172_009_atxt; [LSS_SignPanel:172]LSS_SignPanel_UUIDKey_s:9; *)  //LSS_SignPanel_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_172_001_atxt; [LSS_SignPanel:172]LSS_SignPanelId_s:1; *)
			
			ARRAY TO SELECTION:C261(v_172_002_atxt; [LSS_SignPanel:172]LSS_InspectionId_s:2; v_172_003_atxt; [LSS_SignPanel:172]LSS_Panel_s:3; v_172_004_atxt; [LSS_SignPanel:172]LSS_Width_s:4; *)
			ARRAY TO SELECTION:C261(v_172_005_atxt; [LSS_SignPanel:172]LSS_Height_s:5; v_172_006_atxt; [LSS_SignPanel:172]LSS_PanelMessage_txt:6; v_172_007_atxt; [LSS_SignPanel:172]LSS_PanelType_s:7; *)
			ARRAY TO SELECTION:C261(v_172_008_atxt; [LSS_SignPanel:172]LSS_LanesPanelOver_txt:8)
		End if 
	: ($1=173)  //LSS_TeamMembers
		$Array_Ptr:=->v_173_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_173_003_atxt; [LSS_TeamMembers:173]LSS_TeamMembers_UUIDKey_s:3; *)  //LSS_TeamMembers_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_173_001_atxt; [LSS_TeamMembers:173]LSS_InspectionId_s:1; *)
			ARRAY TO SELECTION:C261(v_173_002_aL; [LSS_TeamMembers:173]LSS_TeamMemberId_L:2)
		End if 
	: ($1=174)  //LSS_TowerDistance
		$Array_Ptr:=->v_174_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_174_006_atxt; [LSS_TowerDistance:174]LSS_TowerDistance_UUIDKey_s:6; *)  //LSS_TowerDistance_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_174_001_atxt; [LSS_TowerDistance:174]LSS_TowerDistanceId_s:1; *)
			
			ARRAY TO SELECTION:C261(v_174_002_atxt; [LSS_TowerDistance:174]LSS_InspectionId_s:2; v_174_003_atxt; [LSS_TowerDistance:174]LSS_TowerOrPost_txt:3; v_174_004_atxt; [LSS_TowerDistance:174]LSS_SignPanel_s:4; *)
			ARRAY TO SELECTION:C261(v_174_005_atxt; [LSS_TowerDistance:174]LSS_Distance_txt:5)
		End if 
	: ($1=175)  //LSS_UT
		$Array_Ptr:=->v_175_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_175_015_atxt; [LSS_UT:175]LSS_UT_UUIDKey_s:15; *)  //LSS_UT_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_175_001_atxt; [LSS_UT:175]LSS_UTId_s:1; *)
			
			ARRAY TO SELECTION:C261(v_175_002_atxt; [LSS_UT:175]LSS_InspectionId_s:2; v_175_003_atxt; [LSS_UT:175]LSS_TechnicianName_s:3; v_175_004_atxt; [LSS_UT:175]LSS_ASNTLevel_s:4; *)
			ARRAY TO SELECTION:C261(v_175_005_atxt; [LSS_UT:175]LSS_AnchorRodDiameter_s:5; v_175_006_atxt; [LSS_UT:175]LSS_AnchorRodLength_s:6; v_175_007_atxt; [LSS_UT:175]LSS_StructureTypeId_s:7; *)
			ARRAY TO SELECTION:C261(v_175_008_atxt; [LSS_UT:175]LSS_MachineTypeSerialNo_s:8; v_175_009_atxt; [LSS_UT:175]LSS_SearchUnitNearZone_s:9; v_175_010_atxt; [LSS_UT:175]LSS_SmallestDetectableDef_s:10; *)
			ARRAY TO SELECTION:C261(v_175_011_atxt; [LSS_UT:175]LSS_SearchUnitBeamSpread_s:11; v_175_012_atxt; [LSS_UT:175]LSS_SearchUnitMfgr_s:12; v_175_013_atxt; [LSS_UT:175]LSS_SRCHUnitDiameterFreq_s:13; *)
			ARRAY TO SELECTION:C261(v_175_014_atxt; [LSS_UT:175]LSS_CouplantMfgrAndGrade_s:14)
		End if 
	: ($1=176)  //LSS_UtResult
		$Array_Ptr:=->v_176_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_176_009_atxt; [LSS_UtResult:176]LSS_UtResult_UUIDKey_s:9; *)  //LSS_UtResult_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_176_001_atxt; [LSS_UtResult:176]LSS_UTResultId_s:1; *)
			
			ARRAY TO SELECTION:C261(v_176_002_atxt; [LSS_UtResult:176]LSS_UTId_s:2; v_176_004_atxt; [LSS_UtResult:176]LSS_IndicationAndLocation_txt:4; v_176_005_atxt; [LSS_UtResult:176]LSS_Location_txt:5; *)
			ARRAY TO SELECTION:C261(v_176_008_atxt; [LSS_UtResult:176]LSS_Remarks_txt:8; *)
			ARRAY TO SELECTION:C261(v_176_003_aL; [LSS_UtResult:176]LSS_RodNo_L:3; *)
			ARRAY TO SELECTION:C261(v_176_006_ab; [LSS_UtResult:176]LSS_Accept_b:6; v_176_007_ab; [LSS_UtResult:176]LSS_Reject_b:7)
		End if 
	: ($1=177)  //LSS_VerticalClearance
		$Array_Ptr:=->v_177_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_177_007_atxt; [LSS_VerticalClearance:177]LSS_VerticalClearance_UUIDKey_s:7; *)  //LSS_VerticalClearance_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_177_001_atxt; [LSS_VerticalClearance:177]LSS_VerticalClearanceId_s:1; *)
			
			ARRAY TO SELECTION:C261(v_177_002_atxt; [LSS_VerticalClearance:177]LSS_InspectionId_s:2; v_177_003_atxt; [LSS_VerticalClearance:177]LSS_Panel_txt:3; *)
			ARRAY TO SELECTION:C261(v_177_006_ar; [LSS_VerticalClearance:177]LSS_Meters_r:6; *)
			ARRAY TO SELECTION:C261(v_177_004_aL; [LSS_VerticalClearance:177]LSS_Feet_L:4; v_177_005_aL; [LSS_VerticalClearance:177]LSS_Inches_L:5)
		End if 
	: ($1=178)  //PON_ELEM_DEFS
		$Array_Ptr:=->v_178_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_178_023_atxt; [PON_ELEM_DEFS:178]PON_ELEM_DEFS_UUIDKey_s:23; *)  //PON_ELEM_DEFS_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_178_001_aL; [PON_ELEM_DEFS:178]ELEM_KEY:1; *)
			
			ARRAY TO SELECTION:C261(v_178_002_atxt; [PON_ELEM_DEFS:178]ELEM_NBE_STAT:2; v_178_003_atxt; [PON_ELEM_DEFS:178]ELEM_PROTECT_SYS:3; v_178_004_atxt; [PON_ELEM_DEFS:178]ELEM_SMART_FLAG:4; *)
			ARRAY TO SELECTION:C261(v_178_005_atxt; [PON_ELEM_DEFS:178]ELEM_CAT_KEY:5; v_178_006_atxt; [PON_ELEM_DEFS:178]ELEM_TYPE_KEY:6; v_178_007_atxt; [PON_ELEM_DEFS:178]ELEM_MAT_KEY:7; *)
			ARRAY TO SELECTION:C261(v_178_009_atxt; [PON_ELEM_DEFS:178]ELEM_MODEL:9; v_178_010_atxt; [PON_ELEM_DEFS:178]ELEM_SHORTNAME:10; v_178_011_atxt; [PON_ELEM_DEFS:178]ELEM_LONGNAME:11; *)
			ARRAY TO SELECTION:C261(v_178_012_atxt; [PON_ELEM_DEFS:178]ELEM_SCALESHORT:12; v_178_013_atxt; [PON_ELEM_DEFS:178]ELEM_SCALEUNIT:13; v_178_015_atxt; [PON_ELEM_DEFS:178]ELEM_CREATEDATETIME:15; *)
			ARRAY TO SELECTION:C261(v_178_016_atxt; [PON_ELEM_DEFS:178]ELEM_CREATEUSERKEY:16; v_178_017_atxt; [PON_ELEM_DEFS:178]ELEM_MODTIME:17; v_178_018_atxt; [PON_ELEM_DEFS:178]ELEM_MODUSERKEY:18; *)
			ARRAY TO SELECTION:C261(v_178_019_atxt; [PON_ELEM_DEFS:178]ELEM_NOTES:19; v_178_021_atxt; [PON_ELEM_DEFS:178]FHWA_REPORTED:21; *)
			ARRAY TO SELECTION:C261(v_178_014_ar; [PON_ELEM_DEFS:178]ELEM_WEIGHT:14; v_178_020_ar; [PON_ELEM_DEFS:178]ELEM_REL_WEIGHT:20; *)
			ARRAY TO SELECTION:C261(v_178_008_ai; [PON_ELEM_DEFS:178]ELEM_PAIRCODE:8; *)
			ARRAY TO SELECTION:C261(v_178_022_aL; [PON_ELEM_DEFS:178]ELEM_SUBSET_KEY:22)
		End if 
	: ($1=179)  //PON_ELEM_INSP
		$Array_Ptr:=->v_179_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_179_030_atxt; [PON_ELEM_INSP:179]PON_ELEM_INSP_UUIDKey_s:30; *)  //PON_ELEM_INSP_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_179_022_aL; [PON_ELEM_INSP:179]ELEMID:22; *)
			
			ARRAY TO SELECTION:C261(v_179_001_atxt; [PON_ELEM_INSP:179]BRKEY:1; v_179_002_atxt; [PON_ELEM_INSP:179]INSPKEY:2; v_179_017_atxt; [PON_ELEM_INSP:179]ELEM_CREATEDATETIME:17; *)
			ARRAY TO SELECTION:C261(v_179_018_atxt; [PON_ELEM_INSP:179]ELEM_MODTIME:18; v_179_020_atxt; [PON_ELEM_INSP:179]ELEM_NOTES:20; v_179_023_atxt; [PON_ELEM_INSP:179]ELEM_DESC:23; *)
			ARRAY TO SELECTION:C261(v_179_024_atxt; [PON_ELEM_INSP:179]ELEM_CREATEUSERKEY:24; v_179_025_atxt; [PON_ELEM_INSP:179]ELEM_MODUSERKEY:25; v_179_026_atxt; [PON_ELEM_INSP:179]ELEM_DOCREFKEY:26; *)
			ARRAY TO SELECTION:C261(v_179_007_ar; [PON_ELEM_INSP:179]ELEM_QUANTITY:7; v_179_008_ar; [PON_ELEM_INSP:179]ELEM_SCALE_FACTOR:8; v_179_009_ar; [PON_ELEM_INSP:179]ELEM_PCTSTATE1:9; *)
			ARRAY TO SELECTION:C261(v_179_010_ar; [PON_ELEM_INSP:179]ELEM_PCTSTATE2:10; v_179_011_ar; [PON_ELEM_INSP:179]ELEM_PCTSTATE3:11; v_179_012_ar; [PON_ELEM_INSP:179]ELEM_PCTSTATE4:12; *)
			ARRAY TO SELECTION:C261(v_179_013_ar; [PON_ELEM_INSP:179]ELEM_QTYSTATE1:13; v_179_014_ar; [PON_ELEM_INSP:179]ELEM_QTYSTATE2:14; v_179_015_ar; [PON_ELEM_INSP:179]ELEM_QTYSTATE3:15; *)
			ARRAY TO SELECTION:C261(v_179_016_ar; [PON_ELEM_INSP:179]ELEM_QTYSTATE4:16; *)
			ARRAY TO SELECTION:C261(v_179_003_aL; [PON_ELEM_INSP:179]ELEM_KEY:3; v_179_004_aL; [PON_ELEM_INSP:179]ELEM_PARENT_KEY:4; v_179_005_aL; [PON_ELEM_INSP:179]ENVKEY:5; *)
			ARRAY TO SELECTION:C261(v_179_006_aL; [PON_ELEM_INSP:179]STRUNITKEY:6; v_179_019_aL; [PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19; v_179_021_aL; [PON_ELEM_INSP:179]INSPID:21; *)
			ARRAY TO SELECTION:C261(v_179_027_aL; [PON_ELEM_INSP:179]ELEM_PARENTID:27; v_179_028_aL; [PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; *)
			ARRAY TO SELECTION:C261(v_179_029_ab; [PON_ELEM_INSP:179]ELEM_QorP:29)
		End if 
	: ($1=180)  //PON_ELEM_COSTS
		$Array_Ptr:=->v_180_003_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_180_006_atxt; [PON_ELEM_COSTS:180]PON_ELEM_COSTS_UUIDKey_s:6; *)  //PON_ELEM_COSTS_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_180_005_aL; [PON_ELEM_COSTS:180]COSTID_L:5; *)
			
			ARRAY TO SELECTION:C261(v_180_003_atxt; [PON_ELEM_COSTS:180]ELEM_ACTION:3; *)
			ARRAY TO SELECTION:C261(v_180_004_ar; [PON_ELEM_COSTS:180]ELEM_COST:4; *)
			ARRAY TO SELECTION:C261(v_180_001_aL; [PON_ELEM_COSTS:180]ELEM_KEY:1; v_180_002_aL; [PON_ELEM_COSTS:180]ENVKEY:2)
		End if 
	: ($1=181)  //NTI_TunnelInfo
		$Array_Ptr:=->v_181_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_181_072_atxt; [NTI_TunnelInfo:181]NTI_TunnelInfo_UUIDKey_s:72; *)  //NTI_TunnelInfo_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_181_006_atxt; [NTI_TunnelInfo:181]NTI_i1_s:6; *)
			
			ARRAY TO SELECTION:C261(v_181_002_atxt; [NTI_TunnelInfo:181]NTI_CreatedBy_s:2; v_181_003_atxt; [NTI_TunnelInfo:181]NTI_ModifiedBy_s:3; v_181_004_atxt; [NTI_TunnelInfo:181]NTI_CreatedTimeStamp_s:4; *)
			ARRAY TO SELECTION:C261(v_181_005_atxt; [NTI_TunnelInfo:181]NTI_ModifiedTimeStamp_s:5; v_181_007_atxt; [NTI_TunnelInfo:181]NTI_i2_s:7; v_181_011_atxt; [NTI_TunnelInfo:181]NTI_i6_s:11; *)
			ARRAY TO SELECTION:C261(v_181_012_atxt; [NTI_TunnelInfo:181]NTI_i7_s:12; v_181_013_atxt; [NTI_TunnelInfo:181]NTI_i8_s:13; v_181_015_atxt; [NTI_TunnelInfo:181]NTI_i10_s:15; *)
			ARRAY TO SELECTION:C261(v_181_016_atxt; [NTI_TunnelInfo:181]NTI_i11_s:16; v_181_020_atxt; [NTI_TunnelInfo:181]NTI_i15_s:20; v_181_022_atxt; [NTI_TunnelInfo:181]NTI_i17_s:22; *)
			ARRAY TO SELECTION:C261(v_181_032_atxt; [NTI_TunnelInfo:181]NTI_C1_s:32; v_181_033_atxt; [NTI_TunnelInfo:181]NTI_C2_s:33; v_181_034_atxt; [NTI_TunnelInfo:181]NTI_C3_s:34; *)
			ARRAY TO SELECTION:C261(v_181_035_atxt; [NTI_TunnelInfo:181]NTI_C4_s:35; v_181_036_atxt; [NTI_TunnelInfo:181]NTI_C5_s:36; v_181_037_atxt; [NTI_TunnelInfo:181]NTI_C6_s:37; *)
			ARRAY TO SELECTION:C261(v_181_039_atxt; [NTI_TunnelInfo:181]NTI_C8_s:39; v_181_045_atxt; [NTI_TunnelInfo:181]NTI_N1_s:45; v_181_047_atxt; [NTI_TunnelInfo:181]NTI_N3_s:47; *)
			ARRAY TO SELECTION:C261(v_181_052_atxt; [NTI_TunnelInfo:181]NTI_S5_s:52; v_181_056_atxt; [NTI_TunnelInfo:181]NTI_D4_s:56; v_181_057_atxt; [NTI_TunnelInfo:181]NTI_D5_s:57; *)
			ARRAY TO SELECTION:C261(v_181_058_atxt; [NTI_TunnelInfo:181]NTI_D6_s:58; v_181_059_atxt; [NTI_TunnelInfo:181]NTI_L1_s:59; v_181_062_atxt; [NTI_TunnelInfo:181]NTI_L4_s:62; *)
			ARRAY TO SELECTION:C261(v_181_068_atxt; [NTI_TunnelInfo:181]NTI_L10_s:68; v_181_069_atxt; [NTI_TunnelInfo:181]NTI_L11_s:69; v_181_070_atxt; [NTI_TunnelInfo:181]NTI_L12_s:70; *)
			ARRAY TO SELECTION:C261(v_181_071_atxt; [NTI_TunnelInfo:181]NTI_TownName_s:71; v_181_073_atxt; [NTI_TunnelInfo:181]NTI_InspResp:73; v_181_074_atxt; [NTI_TunnelInfo:181]NTI_Segment_s:74; *)
			ARRAY TO SELECTION:C261(v_181_075_atxt; [NTI_TunnelInfo:181]NTI_Contracts_s:75; *)
			ARRAY TO SELECTION:C261(v_181_017_ar; [NTI_TunnelInfo:181]NTI_i12_r:17; v_181_018_ar; [NTI_TunnelInfo:181]NTI_i13_r:18; v_181_019_ar; [NTI_TunnelInfo:181]NTI_i14_r:19; *)
			ARRAY TO SELECTION:C261(v_181_041_ar; [NTI_TunnelInfo:181]NTI_G2_r:41; v_181_042_ar; [NTI_TunnelInfo:181]NTI_G3_r:42; v_181_043_ar; [NTI_TunnelInfo:181]NTI_G4_r:43; *)
			ARRAY TO SELECTION:C261(v_181_044_ar; [NTI_TunnelInfo:181]NTI_G5_r:44; v_181_046_ar; [NTI_TunnelInfo:181]NTI_N2_r:46; v_181_060_ar; [NTI_TunnelInfo:181]NTI_L2_r:60; *)
			ARRAY TO SELECTION:C261(v_181_061_ar; [NTI_TunnelInfo:181]NTI_L3_r:61; *)
			ARRAY TO SELECTION:C261(v_181_008_aL; [NTI_TunnelInfo:181]NTI_i3_L:8; v_181_009_aL; [NTI_TunnelInfo:181]NTI_i4_L:9; v_181_010_aL; [NTI_TunnelInfo:181]NTI_i5_L:10; *)
			ARRAY TO SELECTION:C261(v_181_014_aL; [NTI_TunnelInfo:181]NTI_i9_L:14; v_181_021_aL; [NTI_TunnelInfo:181]NTI_i16_L:21; v_181_023_aL; [NTI_TunnelInfo:181]NTI_i18_L:23; *)
			ARRAY TO SELECTION:C261(v_181_024_aL; [NTI_TunnelInfo:181]NTI_A1_L:24; v_181_025_aL; [NTI_TunnelInfo:181]NTI_A2_L:25; v_181_026_aL; [NTI_TunnelInfo:181]NTI_A3_L:26; *)
			ARRAY TO SELECTION:C261(v_181_027_aL; [NTI_TunnelInfo:181]NTI_A4_L:27; v_181_028_aL; [NTI_TunnelInfo:181]NTI_A5_L:28; v_181_029_aL; [NTI_TunnelInfo:181]NTI_A6_L:29; *)
			ARRAY TO SELECTION:C261(v_181_030_aL; [NTI_TunnelInfo:181]NTI_A7_L:30; v_181_031_aL; [NTI_TunnelInfo:181]NTI_A8_L:31; v_181_038_aL; [NTI_TunnelInfo:181]NTI_C7_L:38; *)
			ARRAY TO SELECTION:C261(v_181_040_aL; [NTI_TunnelInfo:181]NTI_G1_L:40; v_181_048_aL; [NTI_TunnelInfo:181]NTI_S1_L:48; v_181_049_aL; [NTI_TunnelInfo:181]NTI_S2_L:49; *)
			ARRAY TO SELECTION:C261(v_181_050_aL; [NTI_TunnelInfo:181]NTI_S3_L:50; v_181_051_aL; [NTI_TunnelInfo:181]NTI_S4_L:51; v_181_055_aL; [NTI_TunnelInfo:181]NTI_D3_L:55; *)
			ARRAY TO SELECTION:C261(v_181_063_aL; [NTI_TunnelInfo:181]NTI_L5_L:63; v_181_064_aL; [NTI_TunnelInfo:181]NTI_L6_L:64; v_181_065_aL; [NTI_TunnelInfo:181]NTI_L7_L:65; *)
			ARRAY TO SELECTION:C261(v_181_066_aL; [NTI_TunnelInfo:181]NTI_L8_L:66; v_181_067_aL; [NTI_TunnelInfo:181]NTI_L9_L:67; v_181_078_aL; [NTI_TunnelInfo:181]NTI_Overhead_Interval_L:78; *)
			ARRAY TO SELECTION:C261(v_181_081_aL; [NTI_TunnelInfo:181]NTI_SpecMemb_Interval_L:81; *)
			ARRAY TO SELECTION:C261(v_181_053_ad; [NTI_TunnelInfo:181]NTI_D1_d:53; v_181_054_ad; [NTI_TunnelInfo:181]NTI_D2_d:54; v_181_076_ad; [NTI_TunnelInfo:181]NTI_Overhead_Actual_d:76; *)
			ARRAY TO SELECTION:C261(v_181_077_ad; [NTI_TunnelInfo:181]NTI_Overhead_Target_d:77; v_181_079_ad; [NTI_TunnelInfo:181]NTI_SpecMemb_Actual_d:79; v_181_080_ad; [NTI_TunnelInfo:181]NTI_SpecMemb_Target_d:80; *)
			ARRAY TO SELECTION:C261(v_181_082_ad; [NTI_TunnelInfo:181]NTI_Damage_d:82; v_181_083_ad; [NTI_TunnelInfo:181]NTI_Damage_Actual_d:83; *)
			ARRAY TO SELECTION:C261(v_181_001_ab; [NTI_TunnelInfo:181]NTI_Future_b:1)
		End if 
	: ($1=182)  //NTI_ELEM_DEFS
		$Array_Ptr:=->v_182_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_182_020_atxt; [NTI_ELEM_DEFS:182]NTI_ELEM_DEFS_UUIDKey_s:20; *)  //NTI_ELEM_DEFS_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_182_004_aL; [NTI_ELEM_DEFS:182]ELEM_KEY:4; *)
			
			ARRAY TO SELECTION:C261(v_182_001_atxt; [NTI_ELEM_DEFS:182]ELEM_CATEGORY:1; v_182_002_atxt; [NTI_ELEM_DEFS:182]CREATEDATETIME:2; v_182_003_atxt; [NTI_ELEM_DEFS:182]CREATEUSER:3; *)
			ARRAY TO SELECTION:C261(v_182_005_atxt; [NTI_ELEM_DEFS:182]ELEM_LONGNAME:5; v_182_006_atxt; [NTI_ELEM_DEFS:182]ELEM_MAT_KEY:6; v_182_007_atxt; [NTI_ELEM_DEFS:182]MODEL:7; *)
			ARRAY TO SELECTION:C261(v_182_008_atxt; [NTI_ELEM_DEFS:182]MODDATETIME:8; v_182_009_atxt; [NTI_ELEM_DEFS:182]MODUSER:9; v_182_010_atxt; [NTI_ELEM_DEFS:182]DEFECTFLAG:10; *)
			ARRAY TO SELECTION:C261(v_182_011_atxt; [NTI_ELEM_DEFS:182]ELEM_SHORTNAME:11; v_182_012_atxt; [NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12; v_182_015_atxt; [NTI_ELEM_DEFS:182]TYPE:15; *)
			ARRAY TO SELECTION:C261(v_182_016_atxt; [NTI_ELEM_DEFS:182]REPORTED:16; v_182_017_atxt; [NTI_ELEM_DEFS:182]NOTES:17; v_182_018_atxt; [NTI_ELEM_DEFS:182]ELEM_BINONLY:18; *)
			ARRAY TO SELECTION:C261(v_182_019_atxt; [NTI_ELEM_DEFS:182]ELEM_TIN_ONLY:19; v_182_021_atxt; [NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21; *)
			ARRAY TO SELECTION:C261(v_182_014_ar; [NTI_ELEM_DEFS:182]ELEM_REL_WEIGHT:14; *)
			ARRAY TO SELECTION:C261(v_182_013_aL; [NTI_ELEM_DEFS:182]ELEM_SUBSET_KEY:13)
		End if 
	: ($1=183)  //NTI_ELEM_BIN_INSP
		$Array_Ptr:=->v_183_004_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_183_023_atxt; [NTI_ELEM_BIN_INSP:183]NTI_ELEM_BIN_INSP_UUIDKey_s:23; *)  //NTI_ELEM_BIN_INSP_UUIDKey_s
			End if 
			If (clone_UseBlobArrays_B)
				ARRAY TO SELECTION:C261(v_183_009_ablb; [NTI_ELEM_BIN_INSP:183]ELEM_NOTES:9; *)
			Else 
				clone_GetBlobs($1)
			End if 
			ARRAY TO SELECTION:C261(v_183_002_aL; [NTI_ELEM_BIN_INSP:183]ELEMID:2; *)
			
			ARRAY TO SELECTION:C261(v_183_004_atxt; [NTI_ELEM_BIN_INSP:183]ELEM_CREATEDATETIME:4; v_183_005_atxt; [NTI_ELEM_BIN_INSP:183]ELEM_CREATEUSER:5; *)
			ARRAY TO SELECTION:C261(v_183_006_atxt; [NTI_ELEM_BIN_INSP:183]ELEM_DESC:6; v_183_010_atxt; [NTI_ELEM_BIN_INSP:183]ELEM_MODDATETIME:10; v_183_011_atxt; [NTI_ELEM_BIN_INSP:183]ELEM_MODUSER:11; *)
			ARRAY TO SELECTION:C261(v_183_012_ar; [NTI_ELEM_BIN_INSP:183]ELEM_PCTSTATE1:12; v_183_013_ar; [NTI_ELEM_BIN_INSP:183]ELEM_PCTSTATE2:13; v_183_014_ar; [NTI_ELEM_BIN_INSP:183]ELEM_PCTSTATE3:14; *)
			ARRAY TO SELECTION:C261(v_183_015_ar; [NTI_ELEM_BIN_INSP:183]ELEM_PCTSTATE4:15; v_183_017_ar; [NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE1:17; v_183_018_ar; [NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE2:18; *)
			ARRAY TO SELECTION:C261(v_183_019_ar; [NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE3:19; v_183_020_ar; [NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE4:20; v_183_021_ar; [NTI_ELEM_BIN_INSP:183]ELEM_QUANTITY:21; *)
			ARRAY TO SELECTION:C261(v_183_022_ar; [NTI_ELEM_BIN_INSP:183]ELEM_SCALE_FACTOR:22; *)
			ARRAY TO SELECTION:C261(v_183_024_ai; [NTI_ELEM_BIN_INSP:183]ELEM_RATING:24; *)
			ARRAY TO SELECTION:C261(v_183_001_aL; [NTI_ELEM_BIN_INSP:183]INSPID:1; v_183_003_aL; [NTI_ELEM_BIN_INSP:183]ELEM_KEY:3; v_183_007_aL; [NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7; *)
			ARRAY TO SELECTION:C261(v_183_008_aL; [NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8; v_183_025_aL; [NTI_ELEM_BIN_INSP:183]ELEM_GRANDPARENT_KEY:25; v_183_026_aL; [NTI_ELEM_BIN_INSP:183]ELEM_GRANDPARENT_ID:26; *)
			ARRAY TO SELECTION:C261(v_183_016_ab; [NTI_ELEM_BIN_INSP:183]ELEM_QorP:16)
		End if 
	: ($1=184)  //TIN_Inspections
		$Array_Ptr:=->v_184_001_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_184_025_atxt; [TIN_Inspections:184]TIN_Inspections_UUIDKey_s:25; *)  //TIN_Inspections_UUIDKey_s
			End if 
			If (clone_UseBlobArrays_B)
				ARRAY TO SELECTION:C261(v_184_023_ablb; [TIN_Inspections:184]Comments:23; *)
			Else 
				clone_GetBlobs($1)
			End if 
			ARRAY TO SELECTION:C261(v_184_002_aL; [TIN_Inspections:184]InspectionID:2; *)
			
			ARRAY TO SELECTION:C261(v_184_001_atxt; [TIN_Inspections:184]NTI_i1_S:1; v_184_007_atxt; [TIN_Inspections:184]CreatedDateTimeStamp:7; *)
			ARRAY TO SELECTION:C261(v_184_008_atxt; [TIN_Inspections:184]CreatedBy:8; v_184_009_atxt; [TIN_Inspections:184]ModifiedTimeStamp:9; v_184_010_atxt; [TIN_Inspections:184]ModifiedBy:10; *)
			ARRAY TO SELECTION:C261(v_184_013_atxt; [TIN_Inspections:184]Agency:13; v_184_016_atxt; [TIN_Inspections:184]InspApproveComments:16; v_184_017_atxt; [TIN_Inspections:184]InspReviewComments:17; *)
			ARRAY TO SELECTION:C261(v_184_020_atxt; [TIN_Inspections:184]RelatedBINInsp:20; v_184_021_atxt; [TIN_Inspections:184]InspType:21; v_184_028_atxt; [TIN_Inspections:184]SigninPlaceAtTunnel_s:28; *)
			ARRAY TO SELECTION:C261(v_184_029_atxt; [TIN_Inspections:184]SigninPlaceAdvance_s:29; v_184_033_atxt; [TIN_Inspections:184]RatingReportRoofGirder_s:33; v_184_034_atxt; [TIN_Inspections:184]RatingReportInvertSlab_s:34; *)
			ARRAY TO SELECTION:C261(v_184_035_atxt; [TIN_Inspections:184]RatingReportInvertGirder_s:35; v_184_045_atxt; [TIN_Inspections:184]WeightPostingSignAtTunnel_s:45; v_184_046_atxt; [TIN_Inspections:184]WeightPostingSignAdvance_s:46; *)
			ARRAY TO SELECTION:C261(v_184_047_atxt; [TIN_Inspections:184]DamageBy_s:47; v_184_049_atxt; [TIN_Inspections:184]Weather:49; *)
			ARRAY TO SELECTION:C261(v_184_037_ar; [TIN_Inspections:184]WeightPostingActualH_r:37; v_184_038_ar; [TIN_Inspections:184]WeightPostingActual3_r:38; v_184_039_ar; [TIN_Inspections:184]WeightPostingActual3S2_r:39; *)
			ARRAY TO SELECTION:C261(v_184_040_ar; [TIN_Inspections:184]WeightPostingActualSingle_r:40; v_184_041_ar; [TIN_Inspections:184]WeightPostingRecH_r:41; v_184_042_ar; [TIN_Inspections:184]WeightPostingRec3_r:42; *)
			ARRAY TO SELECTION:C261(v_184_043_ar; [TIN_Inspections:184]WeightPostingRec3S2_r:43; v_184_044_ar; [TIN_Inspections:184]WeightPostingRecSingle_r:44; v_184_050_ar; [TIN_Inspections:184]Temperature:50; *)
			ARRAY TO SELECTION:C261(v_184_005_ai; [TIN_Inspections:184]InspReview:5; v_184_006_ai; [TIN_Inspections:184]InspApproval:6; v_184_011_ai; [TIN_Inspections:184]TeamLeader:11; *)
			ARRAY TO SELECTION:C261(v_184_012_ai; [TIN_Inspections:184]DistrInspEng:12; v_184_022_ai; [TIN_Inspections:184]DistrTnlInspEng:22; *)
			ARRAY TO SELECTION:C261(v_184_014_aL; [TIN_Inspections:184]ProjManager:14; v_184_026_aL; [TIN_Inspections:184]ActualFieldMeasure_L:26; v_184_027_aL; [TIN_Inspections:184]PostedClearance_L:27; *)
			ARRAY TO SELECTION:C261(v_184_003_ad; [TIN_Inspections:184]InspDate:3; v_184_015_ad; [TIN_Inspections:184]InspCompleteDate:15; v_184_018_ad; [TIN_Inspections:184]InspApproveDate:18; *)
			ARRAY TO SELECTION:C261(v_184_019_ad; [TIN_Inspections:184]InspReviewDate:19; v_184_031_ad; [TIN_Inspections:184]RatingReport_d:31; v_184_032_ad; [TIN_Inspections:184]RatingReportDateofInsp_d:32; *)
			ARRAY TO SELECTION:C261(v_184_048_ad; [TIN_Inspections:184]DamageDate_d:48; v_184_051_ad; [TIN_Inspections:184]InspReportComplete_d:51; *)
			ARRAY TO SELECTION:C261(v_184_004_ab; [TIN_Inspections:184]Complete:4; v_184_024_ab; [TIN_Inspections:184]Future:24; v_184_030_ab; [TIN_Inspections:184]RatingReportYN_B:30; *)
			ARRAY TO SELECTION:C261(v_184_036_ab; [TIN_Inspections:184]WeightPostingNA_B:36)
		End if 
	: ($1=185)  //NTI_ELEM_TIN_INSP
		$Array_Ptr:=->v_185_004_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_185_023_atxt; [NTI_ELEM_TIN_INSP:185]NTI_ELEM_TIN_INSP_UUIDKey_s:23; *)  //NTI_ELEM_TIN_INSP_UUIDKey_s
			End if 
			If (clone_UseBlobArrays_B)
				ARRAY TO SELECTION:C261(v_185_009_ablb; [NTI_ELEM_TIN_INSP:185]ELEM_NOTES:9; *)
			Else 
				clone_GetBlobs($1)
			End if 
			ARRAY TO SELECTION:C261(v_185_002_aL; [NTI_ELEM_TIN_INSP:185]ELEMID:2; *)
			
			ARRAY TO SELECTION:C261(v_185_004_atxt; [NTI_ELEM_TIN_INSP:185]ELEM_CREATEDATETIME:4; v_185_005_atxt; [NTI_ELEM_TIN_INSP:185]ELEM_CREATEUSER:5; *)
			ARRAY TO SELECTION:C261(v_185_006_atxt; [NTI_ELEM_TIN_INSP:185]ELEM_DESC:6; v_185_010_atxt; [NTI_ELEM_TIN_INSP:185]ELEM_MODDATETIME:10; v_185_011_atxt; [NTI_ELEM_TIN_INSP:185]ELEM_MODUSER:11; *)
			ARRAY TO SELECTION:C261(v_185_012_ar; [NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE1:12; v_185_013_ar; [NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13; v_185_014_ar; [NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14; *)
			ARRAY TO SELECTION:C261(v_185_015_ar; [NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15; v_185_017_ar; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; v_185_018_ar; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18; *)
			ARRAY TO SELECTION:C261(v_185_019_ar; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19; v_185_020_ar; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20; v_185_021_ar; [NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; *)
			ARRAY TO SELECTION:C261(v_185_022_ar; [NTI_ELEM_TIN_INSP:185]ELEM_SCALE_FACTOR:22; *)
			ARRAY TO SELECTION:C261(v_185_024_ai; [NTI_ELEM_TIN_INSP:185]ELEM_RATING:24; *)
			ARRAY TO SELECTION:C261(v_185_001_aL; [NTI_ELEM_TIN_INSP:185]InspectionID:1; v_185_003_aL; [NTI_ELEM_TIN_INSP:185]ELEM_KEY:3; v_185_007_aL; [NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7; *)
			ARRAY TO SELECTION:C261(v_185_008_aL; [NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8; v_185_025_aL; [NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_KEY:25; v_185_026_aL; [NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_ID:26; *)
			ARRAY TO SELECTION:C261(v_185_016_ab; [NTI_ELEM_TIN_INSP:185]ELEM_QorP:16)
		End if 
	: ($1=186)  //TIN_Insp_Images
		$Array_Ptr:=->v_186_004_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_186_008_atxt; [TIN_Insp_Images:186]TIN_Insp_Images_UUIDKey_s:8; *)  //TIN_Insp_Images_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_186_002_aL; [TIN_Insp_Images:186]ImageID:2; *)
			
			ARRAY TO SELECTION:C261(v_186_004_atxt; [TIN_Insp_Images:186]ImageDescr:4; v_186_005_atxt; [TIN_Insp_Images:186]ImageType:5; *)
			ARRAY TO SELECTION:C261(v_186_006_ai; [TIN_Insp_Images:186]SequenceNum:6; *)
			ARRAY TO SELECTION:C261(v_186_001_aL; [TIN_Insp_Images:186]InspectionID:1; *)
			ARRAY TO SELECTION:C261(v_186_007_ab; [TIN_Insp_Images:186]Portrait:7; *)
			ARRAY TO SELECTION:C261(v_186_003_ap; [TIN_Insp_Images:186]ImagePic:3)
		End if 
	: ($1=187)  //TIN_Insp_TmMembers
		$Array_Ptr:=->v_187_002_ai
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_187_003_atxt; [TIN_Insp_TmMembers:187]TIN_Insp_TmMembers_UUIDKey_s:3; *)  //TIN_Insp_TmMembers_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_187_002_ai; [TIN_Insp_TmMembers:187]PersonID:2; *)
			ARRAY TO SELECTION:C261(v_187_001_aL; [TIN_Insp_TmMembers:187]InspectionID:1)
		End if 
	: ($1=188)  //TIN_Insp_Comments
		$Array_Ptr:=->v_188_004_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_188_002_atxt; [TIN_Insp_Comments:188]TIN_INSP_CommentsUUIDKey_S:2; *)  //TIN_INSP_CommentsUUIDKey_S
			End if 
			If (clone_UseBlobArrays_B)
				ARRAY TO SELECTION:C261(v_188_009_ablb; [TIN_Insp_Comments:188]Comment_blb:9; *)
			Else 
				clone_GetBlobs($1)
			End if 
			ARRAY TO SELECTION:C261(v_188_003_aL; [TIN_Insp_Comments:188]TIN_InspCommentID_L:3; *)
			
			ARRAY TO SELECTION:C261(v_188_004_atxt; [TIN_Insp_Comments:188]ISOCreatedDate_s:4; v_188_005_atxt; [TIN_Insp_Comments:188]CreatedBy_s:5; *)
			ARRAY TO SELECTION:C261(v_188_006_atxt; [TIN_Insp_Comments:188]ISOModifiedDate_s:6; v_188_007_atxt; [TIN_Insp_Comments:188]ModifiedBy_s:7; v_188_008_atxt; [TIN_Insp_Comments:188]CommentType_s:8; *)
			ARRAY TO SELECTION:C261(v_188_001_aL; [TIN_Insp_Comments:188]InspectionID:1)
		End if 
	: ($1=189)  //NTI_TunnelRatings
		$Array_Ptr:=->v_189_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_189_001_atxt; [NTI_TunnelRatings:189]NTI_TunnelRatings_UUID_s:1; *)  //NTI_TunnelRatings_UUID_s
			End if 
			ARRAY TO SELECTION:C261(v_189_011_aL; [NTI_TunnelRatings:189]RatingID_L:11; *)
			
			ARRAY TO SELECTION:C261(v_189_002_atxt; [NTI_TunnelRatings:189]NTI_i1_s:2; v_189_004_atxt; [NTI_TunnelRatings:189]RatingReportRoofGirder_s:4; v_189_005_atxt; [NTI_TunnelRatings:189]RatingReportInvertSlab_s:5; *)
			ARRAY TO SELECTION:C261(v_189_006_atxt; [NTI_TunnelRatings:189]RatingReportInvertGirder_s:6; v_189_007_atxt; [NTI_TunnelRatings:189]ISO_CreatedDate_s:7; v_189_008_atxt; [NTI_TunnelRatings:189]ISO_ModifedDate_s:8; *)
			ARRAY TO SELECTION:C261(v_189_009_atxt; [NTI_TunnelRatings:189]CreatedBy_s:9; v_189_010_atxt; [NTI_TunnelRatings:189]ModifiedBy_s:10; *)
			ARRAY TO SELECTION:C261(v_189_003_ad; [NTI_TunnelRatings:189]RatingReport_d:3; v_189_012_ad; [NTI_TunnelRatings:189]Inspection_d:12)
		End if 
	: ($1=190)  //RatingVehicleTypes
		$Array_Ptr:=->v_190_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_190_004_atxt; [RatingVehicleTypes:190]RatingVehicleTypes_UUIDKey_s:4; *)  //RatingVehicleTypes_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_190_002_atxt; [RatingVehicleTypes:190]VehicleName_s:2; v_190_001_aL; [RatingVehicleTypes:190]VehicleID:1; *)
			
			ARRAY TO SELECTION:C261(v_190_008_aL; [RatingVehicleTypes:190]Sequence:8; v_190_009_aL; [RatingVehicleTypes:190]LegacyInvFieldNo_L:9; v_190_010_aL; [RatingVehicleTypes:190]LegacyOprFieldNo_L:10; *)
			ARRAY TO SELECTION:C261(v_190_003_ab; [RatingVehicleTypes:190]PostingVehicle_b:3; v_190_005_ab; [RatingVehicleTypes:190]InvRating:5; v_190_006_ab; [RatingVehicleTypes:190]OperRating:6; *)
			ARRAY TO SELECTION:C261(v_190_007_ab; [RatingVehicleTypes:190]Legacy:7)
		End if 
	: ($1=191)  //RatingReportVehicles
		$Array_Ptr:=->v_191_003_ar
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_191_006_atxt; [RatingReportVehicles:191]RatingReportVehicles_UUIDKey_s:6; *)  //RatingReportVehicles_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_191_001_aL; [RatingReportVehicles:191]RatingVehicleID:1; *)
			
			ARRAY TO SELECTION:C261(v_191_003_ar; [RatingReportVehicles:191]InvRating:3; v_191_004_ar; [RatingReportVehicles:191]OperRating:4; v_191_005_ar; [RatingReportVehicles:191]Posting:5; *)
			ARRAY TO SELECTION:C261(v_191_002_aL; [RatingReportVehicles:191]RatingID:2; v_191_007_aL; [RatingReportVehicles:191]VehicleID:7)
		End if 
	: ($1=192)  //BridgeStairs
		$Array_Ptr:=->v_192_002_atxt
		If (Size of array:C274($Array_Ptr->)>0)
			If (clone_IncludeUUIDS_B)
				ARRAY TO SELECTION:C261(v_192_011_atxt; [BridgeStairs:192]BridgeStairs_UUIDKey_s:11; *)  //BridgeStairs_UUIDKey_s
			End if 
			ARRAY TO SELECTION:C261(v_192_001_aL; [BridgeStairs:192]BridgeStairsID:1; *)
			
			ARRAY TO SELECTION:C261(v_192_002_atxt; [BridgeStairs:192]BIN:2; v_192_003_atxt; [BridgeStairs:192]Material_s:3; v_192_004_atxt; [BridgeStairs:192]OwnerCode_s:4; *)
			ARRAY TO SELECTION:C261(v_192_005_atxt; [BridgeStairs:192]StairsTo_txt:5; v_192_006_atxt; [BridgeStairs:192]Description_txt:6; v_192_007_atxt; [BridgeStairs:192]CreatedBy:7; *)
			ARRAY TO SELECTION:C261(v_192_008_atxt; [BridgeStairs:192]CreatedStamp:8; v_192_009_atxt; [BridgeStairs:192]ModifiedBy:9; v_192_010_atxt; [BridgeStairs:192]ModifiedStamp:10)
		End if 
		
End case 
If (Size of array:C274($Array_Ptr->)#SQL_Limit_L)
	Offset_l:=Count_l
Else 
	Offset_l:=Offset_l+SQL_Limit_L
End if 
