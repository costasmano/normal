//%attributes = {"invisible":true}
// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 05/06/10, 11:58:58
// ----------------------------------------------------
// Method: Compiler_FieldVariables
// Description
//This method is used to define variables in a non compiled db
//It should be recreated any time a new table or field is added or a type is changed
//Remember to keep the following as a wrapper
//If (Not(Is compiled mode))
//If (Count parameters=0)
//C_LONGINT($Loop_l)
//For ($Loop_l;1;Get last table number)
//If (Is table number valid($Loop_l))
//Compiler_FieldVariables ($Loop_l)
//end if
//End for 
//
//Else 
//C_LONGINT($1)
//End if 

// Parameters
// ----------------------------------------------------
//$1 table number

// Modified by: Charles Miller (5/6/10)
If (False:C215)
	//Modified by: Charles Miller (8/11/10 11:06:44) 
	// Updated by clone_NewCreateSQLVariables on 5/9/24 - 09:49:24
End if 
// 
If (Count parameters:C259=0)
	C_LONGINT:C283($Loop_l)
	For ($Loop_l; 1; Get last table number:C254)
		If (Is table number valid:C999($Loop_l))
			Compiler_FieldVariables($Loop_l)
		End if 
	End for 
Else 
	C_LONGINT:C283($1)
	Case of 
		: ($1=1)  //Bridge MHD NBIS
			C_TEXT:C284(v_1_230_txt)  //Bridge_MHD_NBIS_UUIDKey_s
			ARRAY TEXT:C222(v_1_230_atxt; 0)  //Bridge_MHD_NBIS_UUIDKey_s
			C_TEXT:C284(v_1_001_txt)  //BDEPT
			ARRAY TEXT:C222(v_1_001_atxt; 0)  //BDEPT
			C_TEXT:C284(v_1_002_txt)  //Bridge Key
			ARRAY TEXT:C222(v_1_002_atxt; 0)  //Bridge Key
			C_TEXT:C284(v_1_003_txt)  //BIN
			ARRAY TEXT:C222(v_1_003_atxt; 0)  //BIN
			C_TEXT:C284(v_1_008_txt)  //PostingStatus
			ARRAY TEXT:C222(v_1_008_atxt; 0)  //PostingStatus
			C_TEXT:C284(v_1_012_txt)  //Foundation Type
			ARRAY TEXT:C222(v_1_012_atxt; 0)  //Foundation Type
			C_TEXT:C284(v_1_023_txt)  //FC Under
			ARRAY TEXT:C222(v_1_023_atxt; 0)  //FC Under
			C_TEXT:C284(v_1_024_txt)  //Quad
			ARRAY TEXT:C222(v_1_024_atxt; 0)  //Quad
			C_TEXT:C284(v_1_025_txt)  //SelectionText
			ARRAY TEXT:C222(v_1_025_atxt; 0)  //SelectionText
			C_TEXT:C284(v_1_027_txt)  //ParallelBIN
			ARRAY TEXT:C222(v_1_027_atxt; 0)  //ParallelBIN
			C_TEXT:C284(v_1_029_txt)  //Bridge Name
			ARRAY TEXT:C222(v_1_029_atxt; 0)  //Bridge Name
			C_TEXT:C284(v_1_030_txt)  //LiftBucket
			ARRAY TEXT:C222(v_1_030_atxt; 0)  //LiftBucket
			C_TEXT:C284(v_1_031_txt)  //Ladder
			ARRAY TEXT:C222(v_1_031_atxt; 0)  //Ladder
			C_TEXT:C284(v_1_032_txt)  //Boat
			ARRAY TEXT:C222(v_1_032_atxt; 0)  //Boat
			C_TEXT:C284(v_1_033_txt)  //Wader
			ARRAY TEXT:C222(v_1_033_atxt; 0)  //Wader
			C_TEXT:C284(v_1_034_txt)  //Inspector50
			ARRAY TEXT:C222(v_1_034_atxt; 0)  //Inspector50
			C_TEXT:C284(v_1_035_txt)  //Rigging
			ARRAY TEXT:C222(v_1_035_atxt; 0)  //Rigging
			C_TEXT:C284(v_1_036_txt)  //Staging
			ARRAY TEXT:C222(v_1_036_atxt; 0)  //Staging
			C_TEXT:C284(v_1_037_txt)  //Traffic Control
			ARRAY TEXT:C222(v_1_037_atxt; 0)  //Traffic Control
			C_TEXT:C284(v_1_038_txt)  //RR Flagman
			ARRAY TEXT:C222(v_1_038_atxt; 0)  //RR Flagman
			C_TEXT:C284(v_1_039_txt)  //Police
			ARRAY TEXT:C222(v_1_039_atxt; 0)  //Police
			C_TEXT:C284(v_1_049_txt)  //InspWaiverText
			ARRAY TEXT:C222(v_1_049_atxt; 0)  //InspWaiverText
			C_TEXT:C284(v_1_050_txt)  //RoadInvSNC
			ARRAY TEXT:C222(v_1_050_atxt; 0)  //RoadInvSNC
			C_TEXT:C284(v_1_051_txt)  //RoadInvSNI
			ARRAY TEXT:C222(v_1_051_atxt; 0)  //RoadInvSNI
			C_TEXT:C284(v_1_052_txt)  //MaintCat
			ARRAY TEXT:C222(v_1_052_atxt; 0)  //MaintCat
			C_TEXT:C284(v_1_053_txt)  //MaintPriority
			ARRAY TEXT:C222(v_1_053_atxt; 0)  //MaintPriority
			C_TEXT:C284(v_1_054_txt)  //MaintTxtDist
			ARRAY TEXT:C222(v_1_054_atxt; 0)  //MaintTxtDist
			C_TEXT:C284(v_1_055_txt)  //MaintTxtBoston
			ARRAY TEXT:C222(v_1_055_atxt; 0)  //MaintTxtBoston
			C_TEXT:C284(v_1_058_txt)  //SeismicClass
			ARRAY TEXT:C222(v_1_058_atxt; 0)  //SeismicClass
			C_TEXT:C284(v_1_059_txt)  //Item5
			ARRAY TEXT:C222(v_1_059_atxt; 0)  //Item5
			C_TEXT:C284(v_1_060_txt)  //Item2
			ARRAY TEXT:C222(v_1_060_atxt; 0)  //Item2
			C_TEXT:C284(v_1_061_txt)  //Item3
			ARRAY TEXT:C222(v_1_061_atxt; 0)  //Item3
			C_TEXT:C284(v_1_062_txt)  //Item4
			ARRAY TEXT:C222(v_1_062_atxt; 0)  //Item4
			C_TEXT:C284(v_1_063_txt)  //Item6A
			ARRAY TEXT:C222(v_1_063_atxt; 0)  //Item6A
			C_TEXT:C284(v_1_065_txt)  //Item7
			ARRAY TEXT:C222(v_1_065_atxt; 0)  //Item7
			C_TEXT:C284(v_1_066_txt)  //Item9
			ARRAY TEXT:C222(v_1_066_atxt; 0)  //Item9
			C_TEXT:C284(v_1_072_txt)  //Item98A
			ARRAY TEXT:C222(v_1_072_atxt; 0)  //Item98A
			C_TEXT:C284(v_1_073_txt)  //Item98B
			ARRAY TEXT:C222(v_1_073_atxt; 0)  //Item98B
			C_TEXT:C284(v_1_074_txt)  //Item99
			ARRAY TEXT:C222(v_1_074_atxt; 0)  //Item99
			C_TEXT:C284(v_1_075_txt)  //Item43
			ARRAY TEXT:C222(v_1_075_atxt; 0)  //Item43
			C_TEXT:C284(v_1_076_txt)  //Item44
			ARRAY TEXT:C222(v_1_076_atxt; 0)  //Item44
			C_TEXT:C284(v_1_079_txt)  //Item107
			ARRAY TEXT:C222(v_1_079_atxt; 0)  //Item107
			C_TEXT:C284(v_1_080_txt)  //Item108A
			ARRAY TEXT:C222(v_1_080_atxt; 0)  //Item108A
			C_TEXT:C284(v_1_081_txt)  //Item108B
			ARRAY TEXT:C222(v_1_081_atxt; 0)  //Item108B
			C_TEXT:C284(v_1_082_txt)  //Item108C
			ARRAY TEXT:C222(v_1_082_atxt; 0)  //Item108C
			C_TEXT:C284(v_1_085_txt)  //Item42
			ARRAY TEXT:C222(v_1_085_atxt; 0)  //Item42
			C_TEXT:C284(v_1_099_txt)  //Item33
			ARRAY TEXT:C222(v_1_099_atxt; 0)  //Item33
			C_TEXT:C284(v_1_107_txt)  //Item54A
			ARRAY TEXT:C222(v_1_107_atxt; 0)  //Item54A
			C_TEXT:C284(v_1_110_txt)  //Item55A
			ARRAY TEXT:C222(v_1_110_atxt; 0)  //Item55A
			C_TEXT:C284(v_1_113_txt)  //Item38
			ARRAY TEXT:C222(v_1_113_atxt; 0)  //Item38
			C_TEXT:C284(v_1_114_txt)  //Item111
			ARRAY TEXT:C222(v_1_114_atxt; 0)  //Item111
			C_TEXT:C284(v_1_120_txt)  //Item26
			ARRAY TEXT:C222(v_1_120_atxt; 0)  //Item26
			C_TEXT:C284(v_1_121_txt)  //Item100
			ARRAY TEXT:C222(v_1_121_atxt; 0)  //Item100
			C_TEXT:C284(v_1_122_txt)  //Item101
			ARRAY TEXT:C222(v_1_122_atxt; 0)  //Item101
			C_TEXT:C284(v_1_123_txt)  //Item102
			ARRAY TEXT:C222(v_1_123_atxt; 0)  //Item102
			C_TEXT:C284(v_1_126_txt)  //Item20
			ARRAY TEXT:C222(v_1_126_atxt; 0)  //Item20
			C_TEXT:C284(v_1_127_txt)  //Item21
			ARRAY TEXT:C222(v_1_127_atxt; 0)  //Item21
			C_TEXT:C284(v_1_128_txt)  //Item22
			ARRAY TEXT:C222(v_1_128_atxt; 0)  //Item22
			C_TEXT:C284(v_1_129_txt)  //Item37
			ARRAY TEXT:C222(v_1_129_atxt; 0)  //Item37
			C_TEXT:C284(v_1_130_txt)  //Item58
			ARRAY TEXT:C222(v_1_130_atxt; 0)  //Item58
			C_TEXT:C284(v_1_131_txt)  //Item59
			ARRAY TEXT:C222(v_1_131_atxt; 0)  //Item59
			C_TEXT:C284(v_1_132_txt)  //Item60
			ARRAY TEXT:C222(v_1_132_atxt; 0)  //Item60
			C_TEXT:C284(v_1_133_txt)  //Item61
			ARRAY TEXT:C222(v_1_133_atxt; 0)  //Item61
			C_TEXT:C284(v_1_134_txt)  //Item62
			ARRAY TEXT:C222(v_1_134_atxt; 0)  //Item62
			C_TEXT:C284(v_1_135_txt)  //Item31
			ARRAY TEXT:C222(v_1_135_atxt; 0)  //Item31
			C_TEXT:C284(v_1_140_txt)  //Item70
			ARRAY TEXT:C222(v_1_140_atxt; 0)  //Item70
			C_TEXT:C284(v_1_141_txt)  //Item41
			ARRAY TEXT:C222(v_1_141_atxt; 0)  //Item41
			C_TEXT:C284(v_1_142_txt)  //Item67
			ARRAY TEXT:C222(v_1_142_atxt; 0)  //Item67
			C_TEXT:C284(v_1_143_txt)  //Item68
			ARRAY TEXT:C222(v_1_143_atxt; 0)  //Item68
			C_TEXT:C284(v_1_144_txt)  //Item69
			ARRAY TEXT:C222(v_1_144_atxt; 0)  //Item69
			C_TEXT:C284(v_1_145_txt)  //Item71
			ARRAY TEXT:C222(v_1_145_atxt; 0)  //Item71
			C_TEXT:C284(v_1_146_txt)  //Item72
			ARRAY TEXT:C222(v_1_146_atxt; 0)  //Item72
			C_TEXT:C284(v_1_147_txt)  //Item36A
			ARRAY TEXT:C222(v_1_147_atxt; 0)  //Item36A
			C_TEXT:C284(v_1_148_txt)  //Item36B
			ARRAY TEXT:C222(v_1_148_atxt; 0)  //Item36B
			C_TEXT:C284(v_1_149_txt)  //Item36C
			ARRAY TEXT:C222(v_1_149_atxt; 0)  //Item36C
			C_TEXT:C284(v_1_150_txt)  //Item36D
			ARRAY TEXT:C222(v_1_150_atxt; 0)  //Item36D
			C_TEXT:C284(v_1_151_txt)  //Item113
			ARRAY TEXT:C222(v_1_151_atxt; 0)  //Item113
			C_TEXT:C284(v_1_152_txt)  //Item75A
			ARRAY TEXT:C222(v_1_152_atxt; 0)  //Item75A
			C_TEXT:C284(v_1_153_txt)  //Item75B
			ARRAY TEXT:C222(v_1_153_atxt; 0)  //Item75B
			C_TEXT:C284(v_1_172_txt)  //General Comment
			ARRAY TEXT:C222(v_1_172_atxt; 0)  //General Comment
			C_TEXT:C284(v_1_173_txt)  //InspResp
			ARRAY TEXT:C222(v_1_173_atxt; 0)  //InspResp
			C_TEXT:C284(v_1_175_txt)  //Town Name
			ARRAY TEXT:C222(v_1_175_atxt; 0)  //Town Name
			C_TEXT:C284(v_1_180_txt)  //AccessOther
			ARRAY TEXT:C222(v_1_180_atxt; 0)  //AccessOther
			C_TEXT:C284(v_1_181_txt)  //OtherAccBool
			ARRAY TEXT:C222(v_1_181_atxt; 0)  //OtherAccBool
			C_TEXT:C284(v_1_183_txt)  //RPC_Codes
			ARRAY TEXT:C222(v_1_183_atxt; 0)  //RPC_Codes
			C_TEXT:C284(v_1_185_txt)  //CulvertShape
			ARRAY TEXT:C222(v_1_185_atxt; 0)  //CulvertShape
			C_TEXT:C284(v_1_186_txt)  //CulvertMaterial
			ARRAY TEXT:C222(v_1_186_atxt; 0)  //CulvertMaterial
			C_TEXT:C284(v_1_187_txt)  //CulvertCoating
			ARRAY TEXT:C222(v_1_187_atxt; 0)  //CulvertCoating
			C_TEXT:C284(v_1_191_txt)  //Modified By
			ARRAY TEXT:C222(v_1_191_atxt; 0)  //Modified By
			C_TEXT:C284(v_1_197_txt)  //Item 13A
			ARRAY TEXT:C222(v_1_197_atxt; 0)  //Item 13A
			C_TEXT:C284(v_1_198_txt)  //Item 13B
			ARRAY TEXT:C222(v_1_198_atxt; 0)  //Item 13B
			C_TEXT:C284(v_1_199_txt)  //Item 63
			ARRAY TEXT:C222(v_1_199_atxt; 0)  //Item 63
			C_TEXT:C284(v_1_200_txt)  //Item 65
			ARRAY TEXT:C222(v_1_200_atxt; 0)  //Item 65
			C_TEXT:C284(v_1_201_txt)  //Item 105
			ARRAY TEXT:C222(v_1_201_atxt; 0)  //Item 105
			C_TEXT:C284(v_1_202_txt)  //JointlessType
			ARRAY TEXT:C222(v_1_202_atxt; 0)  //JointlessType
			C_TEXT:C284(v_1_206_txt)  //Item8
			ARRAY TEXT:C222(v_1_206_atxt; 0)  //Item8
			C_TEXT:C284(v_1_207_txt)  //Item8 BridgeCat
			ARRAY TEXT:C222(v_1_207_atxt; 0)  //Item8 BridgeCat
			C_TEXT:C284(v_1_208_txt)  //Item8 Owner
			ARRAY TEXT:C222(v_1_208_atxt; 0)  //Item8 Owner
			C_TEXT:C284(v_1_209_txt)  //AgencyBrNo
			ARRAY TEXT:C222(v_1_209_atxt; 0)  //AgencyBrNo
			C_TEXT:C284(v_1_210_txt)  //RRBranch
			ARRAY TEXT:C222(v_1_210_atxt; 0)  //RRBranch
			C_TEXT:C284(v_1_215_txt)  //OtherInspType
			ARRAY TEXT:C222(v_1_215_atxt; 0)  //OtherInspType
			C_TEXT:C284(v_1_216_txt)  //ClassAEmp
			ARRAY TEXT:C222(v_1_216_atxt; 0)  //ClassAEmp
			C_TEXT:C284(v_1_217_txt)  //ConfinedSp
			ARRAY TEXT:C222(v_1_217_atxt; 0)  //ConfinedSp
			C_TEXT:C284(v_1_218_txt)  //OffHrsWork
			ARRAY TEXT:C222(v_1_218_atxt; 0)  //OffHrsWork
			C_TEXT:C284(v_1_224_txt)  //MissSignsDesc
			ARRAY TEXT:C222(v_1_224_atxt; 0)  //MissSignsDesc
			C_TEXT:C284(v_1_225_txt)  //FreezeThaw
			ARRAY TEXT:C222(v_1_225_atxt; 0)  //FreezeThaw
			C_TEXT:C284(v_1_226_txt)  //LegacyOwner
			ARRAY TEXT:C222(v_1_226_atxt; 0)  //LegacyOwner
			C_TEXT:C284(v_1_228_txt)  //FundingSource
			ARRAY TEXT:C222(v_1_228_atxt; 0)  //FundingSource
			C_TEXT:C284(v_1_229_txt)  //FHWAItem8
			ARRAY TEXT:C222(v_1_229_atxt; 0)  //FHWAItem8
			C_REAL:C285(v_1_005_r)  //AASHTO
			ARRAY REAL:C219(v_1_005_ar; 0)  //AASHTO
			C_REAL:C285(v_1_015_r)  //OprH20
			ARRAY REAL:C219(v_1_015_ar; 0)  //OprH20
			C_REAL:C285(v_1_016_r)  //OprType3
			ARRAY REAL:C219(v_1_016_ar; 0)  //OprType3
			C_REAL:C285(v_1_017_r)  //Opr3S2
			ARRAY REAL:C219(v_1_017_ar; 0)  //Opr3S2
			C_REAL:C285(v_1_018_r)  //OprHS
			ARRAY REAL:C219(v_1_018_ar; 0)  //OprHS
			C_REAL:C285(v_1_019_r)  //InvH20
			ARRAY REAL:C219(v_1_019_ar; 0)  //InvH20
			C_REAL:C285(v_1_020_r)  //InvType3
			ARRAY REAL:C219(v_1_020_ar; 0)  //InvType3
			C_REAL:C285(v_1_021_r)  //Inv3S2
			ARRAY REAL:C219(v_1_021_ar; 0)  //Inv3S2
			C_REAL:C285(v_1_022_r)  //InvHS
			ARRAY REAL:C219(v_1_022_ar; 0)  //InvHS
			C_REAL:C285(v_1_057_r)  //SeismicRank
			ARRAY REAL:C219(v_1_057_ar; 0)  //SeismicRank
			C_REAL:C285(v_1_067_r)  //Item11
			ARRAY REAL:C219(v_1_067_ar; 0)  //Item11
			C_REAL:C285(v_1_092_r)  //Item48
			ARRAY REAL:C219(v_1_092_ar; 0)  //Item48
			C_REAL:C285(v_1_093_r)  //Item49
			ARRAY REAL:C219(v_1_093_ar; 0)  //Item49
			C_REAL:C285(v_1_094_r)  //Item50A
			ARRAY REAL:C219(v_1_094_ar; 0)  //Item50A
			C_REAL:C285(v_1_095_r)  //Item50B
			ARRAY REAL:C219(v_1_095_ar; 0)  //Item50B
			C_REAL:C285(v_1_096_r)  //Item51
			ARRAY REAL:C219(v_1_096_ar; 0)  //Item51
			C_REAL:C285(v_1_097_r)  //Item52
			ARRAY REAL:C219(v_1_097_ar; 0)  //Item52
			C_REAL:C285(v_1_098_r)  //Item32
			ARRAY REAL:C219(v_1_098_ar; 0)  //Item32
			C_REAL:C285(v_1_102_r)  //Item10
			ARRAY REAL:C219(v_1_102_ar; 0)  //Item10
			C_REAL:C285(v_1_104_r)  //Item47
			ARRAY REAL:C219(v_1_104_ar; 0)  //Item47
			C_REAL:C285(v_1_105_r)  //Item53
			ARRAY REAL:C219(v_1_105_ar; 0)  //Item53
			C_REAL:C285(v_1_108_r)  //Item54B
			ARRAY REAL:C219(v_1_108_ar; 0)  //Item54B
			C_REAL:C285(v_1_109_r)  //Item16C
			ARRAY REAL:C219(v_1_109_ar; 0)  //Item16C
			C_REAL:C285(v_1_111_r)  //Item55B
			ARRAY REAL:C219(v_1_111_ar; 0)  //Item55B
			C_REAL:C285(v_1_112_r)  //Item56
			ARRAY REAL:C219(v_1_112_ar; 0)  //Item56
			C_REAL:C285(v_1_115_r)  //Item39
			ARRAY REAL:C219(v_1_115_ar; 0)  //Item39
			C_REAL:C285(v_1_116_r)  //Item116
			ARRAY REAL:C219(v_1_116_ar; 0)  //Item116
			C_REAL:C285(v_1_117_r)  //Item40
			ARRAY REAL:C219(v_1_117_ar; 0)  //Item40
			C_REAL:C285(v_1_136_r)  //Item17C
			ARRAY REAL:C219(v_1_136_ar; 0)  //Item17C
			C_REAL:C285(v_1_137_r)  //Item64
			ARRAY REAL:C219(v_1_137_ar; 0)  //Item64
			C_REAL:C285(v_1_139_r)  //Item66
			ARRAY REAL:C219(v_1_139_ar; 0)  //Item66
			C_REAL:C285(v_1_154_r)  //Item76
			ARRAY REAL:C219(v_1_154_ar; 0)  //Item76
			C_REAL:C285(v_1_189_r)  //BarrelsHeight
			ARRAY REAL:C219(v_1_189_ar; 0)  //BarrelsHeight
			C_REAL:C285(v_1_190_r)  //BarrelsWidth
			ARRAY REAL:C219(v_1_190_ar; 0)  //BarrelsWidth
			C_REAL:C285(v_1_203_r)  //InvMS
			ARRAY REAL:C219(v_1_203_ar; 0)  //InvMS
			C_REAL:C285(v_1_204_r)  //OprMS
			ARRAY REAL:C219(v_1_204_ar; 0)  //OprMS
			C_REAL:C285(v_1_211_r)  //RRBridgeNo
			ARRAY REAL:C219(v_1_211_ar; 0)  //RRBridgeNo
			C_REAL:C285(v_1_220_r)  //HI_Total_Elmt_Cost
			ARRAY REAL:C219(v_1_220_ar; 0)  //HI_Total_Elmt_Cost
			C_REAL:C285(v_1_221_r)  //HI_Current_Elmt_Cost
			ARRAY REAL:C219(v_1_221_ar; 0)  //HI_Current_Elmt_Cost
			C_REAL:C285(v_1_222_r)  //HealthIndex
			ARRAY REAL:C219(v_1_222_ar; 0)  //HealthIndex
			C_LONGINT:C283(v_1_006_L)  //Rank
			ARRAY INTEGER:C220(v_1_006_ai; 0)  //Rank
			C_LONGINT:C283(v_1_009_L)  //Posting2Axle
			ARRAY INTEGER:C220(v_1_009_ai; 0)  //Posting2Axle
			C_LONGINT:C283(v_1_010_L)  //Posting3Axle
			ARRAY INTEGER:C220(v_1_010_ai; 0)  //Posting3Axle
			C_LONGINT:C283(v_1_011_L)  //Posting5Axle
			ARRAY INTEGER:C220(v_1_011_ai; 0)  //Posting5Axle
			C_LONGINT:C283(v_1_040_L)  //InspectionHRS
			ARRAY INTEGER:C220(v_1_040_ai; 0)  //InspectionHRS
			C_LONGINT:C283(v_1_043_L)  //OtherIFreq
			ARRAY INTEGER:C220(v_1_043_ai; 0)  //OtherIFreq
			C_LONGINT:C283(v_1_046_L)  //ClosedIFreq
			ARRAY INTEGER:C220(v_1_046_ai; 0)  //ClosedIFreq
			C_LONGINT:C283(v_1_068_L)  //Item16A
			ARRAY INTEGER:C220(v_1_068_ai; 0)  //Item16A
			C_LONGINT:C283(v_1_069_L)  //Item16B
			ARRAY INTEGER:C220(v_1_069_ai; 0)  //Item16B
			C_LONGINT:C283(v_1_070_L)  //Item17A
			ARRAY INTEGER:C220(v_1_070_ai; 0)  //Item17A
			C_LONGINT:C283(v_1_071_L)  //Item17B
			ARRAY INTEGER:C220(v_1_071_ai; 0)  //Item17B
			C_LONGINT:C283(v_1_077_L)  //Item45
			ARRAY INTEGER:C220(v_1_077_ai; 0)  //Item45
			C_LONGINT:C283(v_1_078_L)  //Item46
			ARRAY INTEGER:C220(v_1_078_ai; 0)  //Item46
			C_LONGINT:C283(v_1_083_L)  //Item27
			ARRAY INTEGER:C220(v_1_083_ai; 0)  //Item27
			C_LONGINT:C283(v_1_084_L)  //Item106
			ARRAY INTEGER:C220(v_1_084_ai; 0)  //Item106
			C_LONGINT:C283(v_1_086_L)  //Item28A
			ARRAY INTEGER:C220(v_1_086_ai; 0)  //Item28A
			C_LONGINT:C283(v_1_087_L)  //Item28B
			ARRAY INTEGER:C220(v_1_087_ai; 0)  //Item28B
			C_LONGINT:C283(v_1_089_L)  //Item30
			ARRAY INTEGER:C220(v_1_089_ai; 0)  //Item30
			C_LONGINT:C283(v_1_090_L)  //Item109
			ARRAY INTEGER:C220(v_1_090_ai; 0)  //Item109
			C_LONGINT:C283(v_1_091_L)  //Item19
			ARRAY INTEGER:C220(v_1_091_ai; 0)  //Item19
			C_LONGINT:C283(v_1_100_L)  //Item34
			ARRAY INTEGER:C220(v_1_100_ai; 0)  //Item34
			C_LONGINT:C283(v_1_158_L)  //Item97
			ARRAY INTEGER:C220(v_1_158_ai; 0)  //Item97
			C_LONGINT:C283(v_1_160_L)  //Item115
			ARRAY INTEGER:C220(v_1_160_ai; 0)  //Item115
			C_LONGINT:C283(v_1_162_L)  //Item91
			ARRAY INTEGER:C220(v_1_162_ai; 0)  //Item91
			C_LONGINT:C283(v_1_164_L)  //Item92AB
			ARRAY INTEGER:C220(v_1_164_ai; 0)  //Item92AB
			C_LONGINT:C283(v_1_166_L)  //Item92BB
			ARRAY INTEGER:C220(v_1_166_ai; 0)  //Item92BB
			C_LONGINT:C283(v_1_168_L)  //Item92CB
			ARRAY INTEGER:C220(v_1_168_ai; 0)  //Item92CB
			C_LONGINT:C283(v_1_188_L)  //BarrelsNumber
			ARRAY INTEGER:C220(v_1_188_ai; 0)  //BarrelsNumber
			C_LONGINT:C283(v_1_213_L)  //UWSpInspFreq
			ARRAY INTEGER:C220(v_1_213_ai; 0)  //UWSpInspFreq
			C_LONGINT:C283(v_1_056_L)  //TownLineBDEPT
			ARRAY LONGINT:C221(v_1_056_aL; 0)  //TownLineBDEPT
			C_LONGINT:C283(v_1_088_L)  //Item29
			ARRAY LONGINT:C221(v_1_088_aL; 0)  //Item29
			C_LONGINT:C283(v_1_155_L)  //Item94
			ARRAY LONGINT:C221(v_1_155_aL; 0)  //Item94
			C_LONGINT:C283(v_1_156_L)  //Item95
			ARRAY LONGINT:C221(v_1_156_aL; 0)  //Item95
			C_LONGINT:C283(v_1_157_L)  //Item96
			ARRAY LONGINT:C221(v_1_157_aL; 0)  //Item96
			C_LONGINT:C283(v_1_159_L)  //Item114
			ARRAY LONGINT:C221(v_1_159_aL; 0)  //Item114
			C_LONGINT:C283(v_1_179_L)  //Year Rehab
			ARRAY LONGINT:C221(v_1_179_aL; 0)  //Year Rehab
			C_LONGINT:C283(v_1_182_L)  //Year Painted
			ARRAY LONGINT:C221(v_1_182_aL; 0)  //Year Painted
			C_LONGINT:C283(v_1_231_L)  //PostingSingle
			ARRAY LONGINT:C221(v_1_231_aL; 0)  //PostingSingle
			C_DATE:C307(v_1_007_d)  //PostingDate
			ARRAY DATE:C224(v_1_007_ad; 0)  //PostingDate
			C_DATE:C307(v_1_041_d)  //OtherIDate
			ARRAY DATE:C224(v_1_041_ad; 0)  //OtherIDate
			C_DATE:C307(v_1_044_d)  //ClosedIDate
			ARRAY DATE:C224(v_1_044_ad; 0)  //ClosedIDate
			C_DATE:C307(v_1_047_d)  //DamageInsp
			ARRAY DATE:C224(v_1_047_ad; 0)  //DamageInsp
			C_DATE:C307(v_1_161_d)  //Item90
			ARRAY DATE:C224(v_1_161_ad; 0)  //Item90
			C_DATE:C307(v_1_169_d)  //Item93A
			ARRAY DATE:C224(v_1_169_ad; 0)  //Item93A
			C_DATE:C307(v_1_170_d)  //Item93B
			ARRAY DATE:C224(v_1_170_ad; 0)  //Item93B
			C_DATE:C307(v_1_171_d)  //Item93C
			ARRAY DATE:C224(v_1_171_ad; 0)  //Item93C
			C_DATE:C307(v_1_192_d)  //DateCreated
			ARRAY DATE:C224(v_1_192_ad; 0)  //DateCreated
			C_DATE:C307(v_1_194_d)  //DateModified
			ARRAY DATE:C224(v_1_194_ad; 0)  //DateModified
			C_DATE:C307(v_1_205_d)  //DateRatReport
			ARRAY DATE:C224(v_1_205_ad; 0)  //DateRatReport
			C_DATE:C307(v_1_214_d)  //UWSpInspDate
			ARRAY DATE:C224(v_1_214_ad; 0)  //UWSpInspDate
			C_TIME:C306(v_1_193_tm)  //TimeCreated
			ARRAY TIME:C1223(v_1_193_atm; 0)  //TimeCreated
			C_TIME:C306(v_1_195_tm)  //TimeModified
			ARRAY TIME:C1223(v_1_195_atm; 0)  //TimeModified
			C_BOOLEAN:C305(v_1_004_b)  //FHWA Select
			ARRAY BOOLEAN:C223(v_1_004_ab; 0)  //FHWA Select
			C_BOOLEAN:C305(v_1_013_b)  //AreaEngVal
			ARRAY BOOLEAN:C223(v_1_013_ab; 0)  //AreaEngVal
			C_BOOLEAN:C305(v_1_014_b)  //BrgInspEngVal
			ARRAY BOOLEAN:C223(v_1_014_ab; 0)  //BrgInspEngVal
			C_BOOLEAN:C305(v_1_026_b)  //AntiMissile
			ARRAY BOOLEAN:C223(v_1_026_ab; 0)  //AntiMissile
			C_BOOLEAN:C305(v_1_028_b)  //Acrow Panel
			ARRAY BOOLEAN:C223(v_1_028_ab; 0)  //Acrow Panel
			C_BOOLEAN:C305(v_1_042_b)  //OtherInsp
			ARRAY BOOLEAN:C223(v_1_042_ab; 0)  //OtherInsp
			C_BOOLEAN:C305(v_1_045_b)  //ClosedInsp
			ARRAY BOOLEAN:C223(v_1_045_ab; 0)  //ClosedInsp
			C_BOOLEAN:C305(v_1_048_b)  //InspWaiver
			ARRAY BOOLEAN:C223(v_1_048_ab; 0)  //InspWaiver
			C_BOOLEAN:C305(v_1_064_b)  //Item6B
			ARRAY BOOLEAN:C223(v_1_064_ab; 0)  //Item6B
			C_BOOLEAN:C305(v_1_101_b)  //Item35
			ARRAY BOOLEAN:C223(v_1_101_ab; 0)  //Item35
			C_BOOLEAN:C305(v_1_103_b)  //StructDef
			ARRAY BOOLEAN:C223(v_1_103_ab; 0)  //StructDef
			C_BOOLEAN:C305(v_1_106_b)  //FunctObs
			ARRAY BOOLEAN:C223(v_1_106_ab; 0)  //FunctObs
			C_BOOLEAN:C305(v_1_118_b)  //Item112
			ARRAY BOOLEAN:C223(v_1_118_ab; 0)  //Item112
			C_BOOLEAN:C305(v_1_119_b)  //Item104
			ARRAY BOOLEAN:C223(v_1_119_ab; 0)  //Item104
			C_BOOLEAN:C305(v_1_124_b)  //Item103
			ARRAY BOOLEAN:C223(v_1_124_ab; 0)  //Item103
			C_BOOLEAN:C305(v_1_125_b)  //Item110
			ARRAY BOOLEAN:C223(v_1_125_ab; 0)  //Item110
			C_BOOLEAN:C305(v_1_138_b)  //OnSystem
			ARRAY BOOLEAN:C223(v_1_138_ab; 0)  //OnSystem
			C_BOOLEAN:C305(v_1_163_b)  //Item92AA
			ARRAY BOOLEAN:C223(v_1_163_ab; 0)  //Item92AA
			C_BOOLEAN:C305(v_1_165_b)  //Item92BA
			ARRAY BOOLEAN:C223(v_1_165_ab; 0)  //Item92BA
			C_BOOLEAN:C305(v_1_167_b)  //Item92CA
			ARRAY BOOLEAN:C223(v_1_167_ab; 0)  //Item92CA
			C_BOOLEAN:C305(v_1_174_b)  //FHWARecord
			ARRAY BOOLEAN:C223(v_1_174_ab; 0)  //FHWARecord
			C_BOOLEAN:C305(v_1_176_b)  //JointlessBridge
			ARRAY BOOLEAN:C223(v_1_176_ab; 0)  //JointlessBridge
			C_BOOLEAN:C305(v_1_177_b)  //OnTwnLine
			ARRAY BOOLEAN:C223(v_1_177_ab; 0)  //OnTwnLine
			C_BOOLEAN:C305(v_1_178_b)  //Complex Bridge
			ARRAY BOOLEAN:C223(v_1_178_ab; 0)  //Complex Bridge
			C_BOOLEAN:C305(v_1_184_b)  //OvrHeadSigns
			ARRAY BOOLEAN:C223(v_1_184_ab; 0)  //OvrHeadSigns
			C_BOOLEAN:C305(v_1_196_b)  //Item12
			ARRAY BOOLEAN:C223(v_1_196_ab; 0)  //Item12
			C_BOOLEAN:C305(v_1_212_b)  //UWSpInsp
			ARRAY BOOLEAN:C223(v_1_212_ab; 0)  //UWSpInsp
			C_BOOLEAN:C305(v_1_219_b)  //Complex Rating
			ARRAY BOOLEAN:C223(v_1_219_ab; 0)  //Complex Rating
			C_BOOLEAN:C305(v_1_223_b)  //MissSigns
			ARRAY BOOLEAN:C223(v_1_223_ab; 0)  //MissSigns
			C_BOOLEAN:C305(v_1_227_b)  //InspRequired
			ARRAY BOOLEAN:C223(v_1_227_ab; 0)  //InspRequired
		: ($1=2)  //Town Data
			C_TEXT:C284(v_2_013_txt)  //Town_Data_UUIDKey_s
			ARRAY TEXT:C222(v_2_013_atxt; 0)  //Town_Data_UUIDKey_s
			C_TEXT:C284(v_2_001_txt)  //Town Name
			ARRAY TEXT:C222(v_2_001_atxt; 0)  //Town Name
			C_TEXT:C284(v_2_002_txt)  //BDEPT Prefix
			ARRAY TEXT:C222(v_2_002_atxt; 0)  //BDEPT Prefix
			C_TEXT:C284(v_2_003_txt)  //OldDistrictNo1
			ARRAY TEXT:C222(v_2_003_atxt; 0)  //OldDistrictNo1
			C_TEXT:C284(v_2_004_txt)  //OldDistrictNo2
			ARRAY TEXT:C222(v_2_004_atxt; 0)  //OldDistrictNo2
			C_TEXT:C284(v_2_005_txt)  //Place_Code
			ARRAY TEXT:C222(v_2_005_atxt; 0)  //Place_Code
			C_TEXT:C284(v_2_006_txt)  //District
			ARRAY TEXT:C222(v_2_006_atxt; 0)  //District
			C_TEXT:C284(v_2_007_txt)  //RPC_1
			ARRAY TEXT:C222(v_2_007_atxt; 0)  //RPC_1
			C_TEXT:C284(v_2_008_txt)  //RPC_2
			ARRAY TEXT:C222(v_2_008_atxt; 0)  //RPC_2
			C_TEXT:C284(v_2_010_txt)  //County Code
			ARRAY TEXT:C222(v_2_010_atxt; 0)  //County Code
			C_TEXT:C284(v_2_011_txt)  //Town Dist Code
			ARRAY TEXT:C222(v_2_011_atxt; 0)  //Town Dist Code
			C_TEXT:C284(v_2_012_txt)  //OldDistrictNo3
			ARRAY TEXT:C222(v_2_012_atxt; 0)  //OldDistrictNo3
			C_REAL:C285(v_2_009_r)  //Seismic_Acc
			ARRAY REAL:C219(v_2_009_ar; 0)  //Seismic_Acc
		: ($1=3)  //NBIS Secondary
			C_TEXT:C284(v_3_040_txt)  //NBIS_Secondary_UUIDKey_s
			ARRAY TEXT:C222(v_3_040_atxt; 0)  //NBIS_Secondary_UUIDKey_s
			C_TEXT:C284(v_3_001_txt)  //BIN
			ARRAY TEXT:C222(v_3_001_atxt; 0)  //BIN
			C_TEXT:C284(v_3_002_txt)  //Item3
			ARRAY TEXT:C222(v_3_002_atxt; 0)  //Item3
			C_TEXT:C284(v_3_003_txt)  //Item4
			ARRAY TEXT:C222(v_3_003_atxt; 0)  //Item4
			C_TEXT:C284(v_3_004_txt)  //Item5
			ARRAY TEXT:C222(v_3_004_atxt; 0)  //Item5
			C_TEXT:C284(v_3_005_txt)  //Item6A
			ARRAY TEXT:C222(v_3_005_atxt; 0)  //Item6A
			C_TEXT:C284(v_3_007_txt)  //Item7
			ARRAY TEXT:C222(v_3_007_atxt; 0)  //Item7
			C_TEXT:C284(v_3_008_txt)  //Item9
			ARRAY TEXT:C222(v_3_008_atxt; 0)  //Item9
			C_TEXT:C284(v_3_017_txt)  //Item20
			ARRAY TEXT:C222(v_3_017_atxt; 0)  //Item20
			C_TEXT:C284(v_3_018_txt)  //Item26
			ARRAY TEXT:C222(v_3_018_atxt; 0)  //Item26
			C_TEXT:C284(v_3_023_txt)  //Item42
			ARRAY TEXT:C222(v_3_023_atxt; 0)  //Item42
			C_TEXT:C284(v_3_024_txt)  //Item43
			ARRAY TEXT:C222(v_3_024_atxt; 0)  //Item43
			C_TEXT:C284(v_3_028_txt)  //Item100
			ARRAY TEXT:C222(v_3_028_atxt; 0)  //Item100
			C_TEXT:C284(v_3_029_txt)  //Item101
			ARRAY TEXT:C222(v_3_029_atxt; 0)  //Item101
			C_TEXT:C284(v_3_030_txt)  //Item102
			ARRAY TEXT:C222(v_3_030_atxt; 0)  //Item102
			C_TEXT:C284(v_3_034_txt)  //Bridge Key
			ARRAY TEXT:C222(v_3_034_atxt; 0)  //Bridge Key
			C_TEXT:C284(v_3_038_txt)  //Item8
			ARRAY TEXT:C222(v_3_038_atxt; 0)  //Item8
			C_REAL:C285(v_3_009_r)  //Item10
			ARRAY REAL:C219(v_3_009_ar; 0)  //Item10
			C_REAL:C285(v_3_011_r)  //Item11
			ARRAY REAL:C219(v_3_011_ar; 0)  //Item11
			C_REAL:C285(v_3_025_r)  //Item47
			ARRAY REAL:C219(v_3_025_ar; 0)  //Item47
			C_REAL:C285(v_3_026_r)  //Item48
			ARRAY REAL:C219(v_3_026_ar; 0)  //Item48
			C_REAL:C285(v_3_027_r)  //Item49
			ARRAY REAL:C219(v_3_027_ar; 0)  //Item49
			C_REAL:C285(v_3_035_r)  //Item16C
			ARRAY REAL:C219(v_3_035_ar; 0)  //Item16C
			C_REAL:C285(v_3_036_r)  //Item17C
			ARRAY REAL:C219(v_3_036_ar; 0)  //Item17C
			C_LONGINT:C283(v_3_010_L)  //Item109
			ARRAY INTEGER:C220(v_3_010_ai; 0)  //Item109
			C_LONGINT:C283(v_3_012_L)  //Item16A
			ARRAY INTEGER:C220(v_3_012_ai; 0)  //Item16A
			C_LONGINT:C283(v_3_013_L)  //Item16B
			ARRAY INTEGER:C220(v_3_013_ai; 0)  //Item16B
			C_LONGINT:C283(v_3_014_L)  //Item17A
			ARRAY INTEGER:C220(v_3_014_ai; 0)  //Item17A
			C_LONGINT:C283(v_3_015_L)  //Item17B
			ARRAY INTEGER:C220(v_3_015_ai; 0)  //Item17B
			C_LONGINT:C283(v_3_016_L)  //Item19
			ARRAY INTEGER:C220(v_3_016_ai; 0)  //Item19
			C_LONGINT:C283(v_3_019_L)  //Item27
			ARRAY INTEGER:C220(v_3_019_ai; 0)  //Item27
			C_LONGINT:C283(v_3_020_L)  //Item28A
			ARRAY INTEGER:C220(v_3_020_ai; 0)  //Item28A
			C_LONGINT:C283(v_3_021_L)  //Item28B
			ARRAY INTEGER:C220(v_3_021_ai; 0)  //Item28B
			C_LONGINT:C283(v_3_037_L)  //Item30
			ARRAY INTEGER:C220(v_3_037_ai; 0)  //Item30
			C_LONGINT:C283(v_3_022_L)  //Item29
			ARRAY LONGINT:C221(v_3_022_aL; 0)  //Item29
			C_LONGINT:C283(v_3_039_L)  //NBISSecondaryKey_l
			ARRAY LONGINT:C221(v_3_039_aL; 0)  //NBISSecondaryKey_l
			C_BOOLEAN:C305(v_3_006_b)  //Item6B
			ARRAY BOOLEAN:C223(v_3_006_ab; 0)  //Item6B
			C_BOOLEAN:C305(v_3_031_b)  //Item103
			ARRAY BOOLEAN:C223(v_3_031_ab; 0)  //Item103
			C_BOOLEAN:C305(v_3_032_b)  //Item104
			ARRAY BOOLEAN:C223(v_3_032_ab; 0)  //Item104
			C_BOOLEAN:C305(v_3_033_b)  //Item110
			ARRAY BOOLEAN:C223(v_3_033_ab; 0)  //Item110
		: ($1=4)  //MaintOwnerCode
			C_TEXT:C284(v_4_003_txt)  //MaintOwnerCode_UUIDKey_s
			ARRAY TEXT:C222(v_4_003_atxt; 0)  //MaintOwnerCode_UUIDKey_s
			C_TEXT:C284(v_4_001_txt)  //Code
			ARRAY TEXT:C222(v_4_001_atxt; 0)  //Code
			C_TEXT:C284(v_4_002_txt)  //Description
			ARRAY TEXT:C222(v_4_002_atxt; 0)  //Description
		: ($1=5)  //FunctionalClass
			C_TEXT:C284(v_5_003_txt)  //FunctionalClass_UUIDKey_s
			ARRAY TEXT:C222(v_5_003_atxt; 0)  //FunctionalClass_UUIDKey_s
			C_TEXT:C284(v_5_001_txt)  //Code
			ARRAY TEXT:C222(v_5_001_atxt; 0)  //Code
			C_TEXT:C284(v_5_002_txt)  //Description
			ARRAY TEXT:C222(v_5_002_atxt; 0)  //Description
		: ($1=6)  //Design Load
			C_TEXT:C284(v_6_003_txt)  //Design_Load_UUIDKey_s
			ARRAY TEXT:C222(v_6_003_atxt; 0)  //Design_Load_UUIDKey_s
			C_TEXT:C284(v_6_001_txt)  //Code
			ARRAY TEXT:C222(v_6_001_atxt; 0)  //Code
			C_TEXT:C284(v_6_002_txt)  //Description
			ARRAY TEXT:C222(v_6_002_atxt; 0)  //Description
		: ($1=7)  //Posting Code
			C_TEXT:C284(v_7_003_txt)  //Posting_Code_UUIDKey_s
			ARRAY TEXT:C222(v_7_003_atxt; 0)  //Posting_Code_UUIDKey_s
			C_TEXT:C284(v_7_001_txt)  //Code
			ARRAY TEXT:C222(v_7_001_atxt; 0)  //Code
			C_TEXT:C284(v_7_002_txt)  //Description
			ARRAY TEXT:C222(v_7_002_atxt; 0)  //Description
		: ($1=8)  //Service Over
			C_TEXT:C284(v_8_003_txt)  //Service_Over_UUIDKey_s
			ARRAY TEXT:C222(v_8_003_atxt; 0)  //Service_Over_UUIDKey_s
			C_TEXT:C284(v_8_001_txt)  //Code
			ARRAY TEXT:C222(v_8_001_atxt; 0)  //Code
			C_TEXT:C284(v_8_002_txt)  //Description
			ARRAY TEXT:C222(v_8_002_atxt; 0)  //Description
		: ($1=9)  //Service Under
			C_TEXT:C284(v_9_003_txt)  //Service_Under_UUIDKey_s
			ARRAY TEXT:C222(v_9_003_atxt; 0)  //Service_Under_UUIDKey_s
			C_TEXT:C284(v_9_001_txt)  //Code
			ARRAY TEXT:C222(v_9_001_atxt; 0)  //Code
			C_TEXT:C284(v_9_002_txt)  //Description
			ARRAY TEXT:C222(v_9_002_atxt; 0)  //Description
		: ($1=10)  //Material
			C_TEXT:C284(v_10_003_txt)  //Material_UUIDKey_s
			ARRAY TEXT:C222(v_10_003_atxt; 0)  //Material_UUIDKey_s
			C_TEXT:C284(v_10_001_txt)  //Code
			ARRAY TEXT:C222(v_10_001_atxt; 0)  //Code
			C_TEXT:C284(v_10_002_txt)  //Description
			ARRAY TEXT:C222(v_10_002_atxt; 0)  //Description
		: ($1=11)  //Design
			C_TEXT:C284(v_11_003_txt)  //Design_UUIDKey_s
			ARRAY TEXT:C222(v_11_003_atxt; 0)  //Design_UUIDKey_s
			C_TEXT:C284(v_11_001_txt)  //Code
			ARRAY TEXT:C222(v_11_001_atxt; 0)  //Code
			C_TEXT:C284(v_11_002_txt)  //Description
			ARRAY TEXT:C222(v_11_002_atxt; 0)  //Description
		: ($1=12)  //Truck Code
			C_TEXT:C284(v_12_003_txt)  //Truck_Code_UUIDKey_s
			ARRAY TEXT:C222(v_12_003_atxt; 0)  //Truck_Code_UUIDKey_s
			C_TEXT:C284(v_12_001_txt)  //Code
			ARRAY TEXT:C222(v_12_001_atxt; 0)  //Code
			C_TEXT:C284(v_12_002_txt)  //Description
			ARRAY TEXT:C222(v_12_002_atxt; 0)  //Description
		: ($1=13)  //Direction
			C_TEXT:C284(v_13_003_txt)  //Direction_UUIDKey_s
			ARRAY TEXT:C222(v_13_003_atxt; 0)  //Direction_UUIDKey_s
			C_TEXT:C284(v_13_001_txt)  //Code
			ARRAY TEXT:C222(v_13_001_atxt; 0)  //Code
			C_TEXT:C284(v_13_002_txt)  //Description
			ARRAY TEXT:C222(v_13_002_atxt; 0)  //Description
		: ($1=14)  //Deck Structure
			C_TEXT:C284(v_14_003_txt)  //Deck_Structure_UUIDKey_s
			ARRAY TEXT:C222(v_14_003_atxt; 0)  //Deck_Structure_UUIDKey_s
			C_TEXT:C284(v_14_001_txt)  //Code
			ARRAY TEXT:C222(v_14_001_atxt; 0)  //Code
			C_TEXT:C284(v_14_002_txt)  //Description
			ARRAY TEXT:C222(v_14_002_atxt; 0)  //Description
		: ($1=15)  //Wearing Surface
			C_TEXT:C284(v_15_003_txt)  //Wearing_Surface_UUIDKey_s
			ARRAY TEXT:C222(v_15_003_atxt; 0)  //Wearing_Surface_UUIDKey_s
			C_TEXT:C284(v_15_001_txt)  //Code
			ARRAY TEXT:C222(v_15_001_atxt; 0)  //Code
			C_TEXT:C284(v_15_002_txt)  //Description
			ARRAY TEXT:C222(v_15_002_atxt; 0)  //Description
		: ($1=16)  //Membrane
			C_TEXT:C284(v_16_003_txt)  //Membrane_UUIDKey_s
			ARRAY TEXT:C222(v_16_003_atxt; 0)  //Membrane_UUIDKey_s
			C_TEXT:C284(v_16_001_txt)  //Code
			ARRAY TEXT:C222(v_16_001_atxt; 0)  //Code
			C_TEXT:C284(v_16_002_txt)  //Description
			ARRAY TEXT:C222(v_16_002_atxt; 0)  //Description
		: ($1=17)  //Deck Protection
			C_TEXT:C284(v_17_003_txt)  //Deck_Protection_UUIDKey_s
			ARRAY TEXT:C222(v_17_003_atxt; 0)  //Deck_Protection_UUIDKey_s
			C_TEXT:C284(v_17_001_txt)  //Code
			ARRAY TEXT:C222(v_17_001_atxt; 0)  //Code
			C_TEXT:C284(v_17_002_txt)  //Description
			ARRAY TEXT:C222(v_17_002_atxt; 0)  //Description
		: ($1=18)  //Type of Work
			C_TEXT:C284(v_18_003_txt)  //Type_of_Work_UUIDKey_s
			ARRAY TEXT:C222(v_18_003_atxt; 0)  //Type_of_Work_UUIDKey_s
			C_TEXT:C284(v_18_001_txt)  //Code
			ARRAY TEXT:C222(v_18_001_atxt; 0)  //Code
			C_TEXT:C284(v_18_002_txt)  //Description
			ARRAY TEXT:C222(v_18_002_atxt; 0)  //Description
		: ($1=19)  //Work Done By
			C_TEXT:C284(v_19_003_txt)  //Work_Done_By_UUIDKey_s
			ARRAY TEXT:C222(v_19_003_atxt; 0)  //Work_Done_By_UUIDKey_s
			C_TEXT:C284(v_19_001_txt)  //Code
			ARRAY TEXT:C222(v_19_001_atxt; 0)  //Code
			C_TEXT:C284(v_19_002_txt)  //Description
			ARRAY TEXT:C222(v_19_002_atxt; 0)  //Description
		: ($1=20)  //Insp Resp
			C_TEXT:C284(v_20_003_txt)  //Insp_Resp_UUIDKey_s
			ARRAY TEXT:C222(v_20_003_atxt; 0)  //Insp_Resp_UUIDKey_s
			C_TEXT:C284(v_20_001_txt)  //Code
			ARRAY TEXT:C222(v_20_001_atxt; 0)  //Code
			C_TEXT:C284(v_20_002_txt)  //Description
			ARRAY TEXT:C222(v_20_002_atxt; 0)  //Description
		: ($1=21)  //Dialogs
			C_TEXT:C284(v_21_002_txt)  //Dialogs_UUIDKey_s
			ARRAY TEXT:C222(v_21_002_atxt; 0)  //Dialogs_UUIDKey_s
			C_BOOLEAN:C305(v_21_001_b)  //Reserved
			ARRAY BOOLEAN:C223(v_21_001_ab; 0)  //Reserved
		: ($1=22)  //Item 20 Tolls
			C_TEXT:C284(v_22_003_txt)  //Item_20_Tolls_UUIDKey_s
			ARRAY TEXT:C222(v_22_003_atxt; 0)  //Item_20_Tolls_UUIDKey_s
			C_TEXT:C284(v_22_001_txt)  //Code
			ARRAY TEXT:C222(v_22_001_atxt; 0)  //Code
			C_TEXT:C284(v_22_002_txt)  //Description
			ARRAY TEXT:C222(v_22_002_atxt; 0)  //Description
		: ($1=23)  //Item 33 Median
			C_TEXT:C284(v_23_003_txt)  //Item_33_Median_UUIDKey_s
			ARRAY TEXT:C222(v_23_003_atxt; 0)  //Item_33_Median_UUIDKey_s
			C_TEXT:C284(v_23_001_txt)  //Code
			ARRAY TEXT:C222(v_23_001_atxt; 0)  //Code
			C_TEXT:C284(v_23_002_txt)  //Description
			ARRAY TEXT:C222(v_23_002_atxt; 0)  //Description
		: ($1=24)  //Item 38
			C_TEXT:C284(v_24_003_txt)  //Item_38_UUIDKey_s
			ARRAY TEXT:C222(v_24_003_atxt; 0)  //Item_38_UUIDKey_s
			C_TEXT:C284(v_24_001_txt)  //Code
			ARRAY TEXT:C222(v_24_001_atxt; 0)  //Code
			C_TEXT:C284(v_24_002_txt)  //Description
			ARRAY TEXT:C222(v_24_002_atxt; 0)  //Description
		: ($1=25)  //HistSig
			C_TEXT:C284(v_25_003_txt)  //HistSig_UUIDKey_s
			ARRAY TEXT:C222(v_25_003_atxt; 0)  //HistSig_UUIDKey_s
			C_TEXT:C284(v_25_001_txt)  //Code
			ARRAY TEXT:C222(v_25_001_atxt; 0)  //Code
			C_TEXT:C284(v_25_002_txt)  //Description
			ARRAY TEXT:C222(v_25_002_atxt; 0)  //Description
		: ($1=26)  //Months
			C_TEXT:C284(v_26_003_txt)  //Months_UUIDKey_s
			ARRAY TEXT:C222(v_26_003_atxt; 0)  //Months_UUIDKey_s
			C_TEXT:C284(v_26_002_txt)  //Description
			ARRAY TEXT:C222(v_26_002_atxt; 0)  //Description
			C_LONGINT:C283(v_26_001_L)  //Code
			ARRAY INTEGER:C220(v_26_001_ai; 0)  //Code
		: ($1=27)  //Inspections
			C_BLOB:C604(v_27_171_blb)  //InspComments
			ARRAY BLOB:C1222(v_27_171_ablb; 0)  //InspComments
			C_BLOB:C604(v_27_204_blb)  //OrientationText
			ARRAY BLOB:C1222(v_27_204_ablb; 0)  //OrientationText
			C_TEXT:C284(v_27_226_txt)  //Inspections_UUIDKey_s
			ARRAY TEXT:C222(v_27_226_atxt; 0)  //Inspections_UUIDKey_s
			C_TEXT:C284(v_27_001_txt)  //BIN
			ARRAY TEXT:C222(v_27_001_atxt; 0)  //BIN
			C_TEXT:C284(v_27_006_txt)  //Insp Type
			ARRAY TEXT:C222(v_27_006_atxt; 0)  //Insp Type
			C_TEXT:C284(v_27_007_txt)  //Weather
			ARRAY TEXT:C222(v_27_007_atxt; 0)  //Weather
			C_TEXT:C284(v_27_013_txt)  //CollisionDamSup
			ARRAY TEXT:C222(v_27_013_atxt; 0)  //CollisionDamSup
			C_TEXT:C284(v_27_014_txt)  //LoadDeflection
			ARRAY TEXT:C222(v_27_014_atxt; 0)  //LoadDeflection
			C_TEXT:C284(v_27_015_txt)  //LoadVibration
			ARRAY TEXT:C222(v_27_015_atxt; 0)  //LoadVibration
			C_TEXT:C284(v_27_018_txt)  //CollisionDamSub
			ARRAY TEXT:C222(v_27_018_atxt; 0)  //CollisionDamSub
			C_TEXT:C284(v_27_020_txt)  //Scour
			ARRAY TEXT:C222(v_27_020_atxt; 0)  //Scour
			C_TEXT:C284(v_27_021_txt)  //StreamFlowV
			ARRAY TEXT:C222(v_27_021_atxt; 0)  //StreamFlowV
			C_TEXT:C284(v_27_022_txt)  //Railing36
			ARRAY TEXT:C222(v_27_022_atxt; 0)  //Railing36
			C_TEXT:C284(v_27_023_txt)  //Transitions36
			ARRAY TEXT:C222(v_27_023_atxt; 0)  //Transitions36
			C_TEXT:C284(v_27_024_txt)  //ApprGrdRail36
			ARRAY TEXT:C222(v_27_024_atxt; 0)  //ApprGrdRail36
			C_TEXT:C284(v_27_025_txt)  //ApprGdRailEnd36
			ARRAY TEXT:C222(v_27_025_atxt; 0)  //ApprGdRailEnd36
			C_TEXT:C284(v_27_037_txt)  //BrPostSignsNE
			ARRAY TEXT:C222(v_27_037_atxt; 0)  //BrPostSignsNE
			C_TEXT:C284(v_27_038_txt)  //BrPostSignsSW
			ARRAY TEXT:C222(v_27_038_atxt; 0)  //BrPostSignsSW
			C_TEXT:C284(v_27_039_txt)  //AdPostSignNE
			ARRAY TEXT:C222(v_27_039_atxt; 0)  //AdPostSignNE
			C_TEXT:C284(v_27_040_txt)  //AdPostSignSW
			ARRAY TEXT:C222(v_27_040_atxt; 0)  //AdPostSignSW
			C_TEXT:C284(v_27_054_txt)  //BrClrSignsNE
			ARRAY TEXT:C222(v_27_054_atxt; 0)  //BrClrSignsNE
			C_TEXT:C284(v_27_055_txt)  //BrClrSignsSW
			ARRAY TEXT:C222(v_27_055_atxt; 0)  //BrClrSignsSW
			C_TEXT:C284(v_27_056_txt)  //AdClrSignNE
			ARRAY TEXT:C222(v_27_056_atxt; 0)  //AdClrSignNE
			C_TEXT:C284(v_27_057_txt)  //AdClrSignSW
			ARRAY TEXT:C222(v_27_057_atxt; 0)  //AdClrSignSW
			C_TEXT:C284(v_27_066_txt)  //Item 60 UW
			ARRAY TEXT:C222(v_27_066_atxt; 0)  //Item 60 UW
			C_TEXT:C284(v_27_071_txt)  //VCR Tape No
			ARRAY TEXT:C222(v_27_071_atxt; 0)  //VCR Tape No
			C_TEXT:C284(v_27_072_txt)  //Item 61 UW
			ARRAY TEXT:C222(v_27_072_atxt; 0)  //Item 61 UW
			C_TEXT:C284(v_27_076_txt)  //RatingTxt
			ARRAY TEXT:C222(v_27_076_atxt; 0)  //RatingTxt
			C_TEXT:C284(v_27_077_txt)  //Item 41
			ARRAY TEXT:C222(v_27_077_atxt; 0)  //Item 41
			C_TEXT:C284(v_27_079_txt)  //Item 58
			ARRAY TEXT:C222(v_27_079_atxt; 0)  //Item 58
			C_TEXT:C284(v_27_080_txt)  //Item 59
			ARRAY TEXT:C222(v_27_080_atxt; 0)  //Item 59
			C_TEXT:C284(v_27_081_txt)  //Item 60
			ARRAY TEXT:C222(v_27_081_atxt; 0)  //Item 60
			C_TEXT:C284(v_27_082_txt)  //Item 61
			ARRAY TEXT:C222(v_27_082_atxt; 0)  //Item 61
			C_TEXT:C284(v_27_083_txt)  //PedBarricadesNE
			ARRAY TEXT:C222(v_27_083_atxt; 0)  //PedBarricadesNE
			C_TEXT:C284(v_27_084_txt)  //PedBarricadesSW
			ARRAY TEXT:C222(v_27_084_atxt; 0)  //PedBarricadesSW
			C_TEXT:C284(v_27_085_txt)  //RatingPriority
			ARRAY TEXT:C222(v_27_085_atxt; 0)  //RatingPriority
			C_TEXT:C284(v_27_086_txt)  //LiftBucket
			ARRAY TEXT:C222(v_27_086_atxt; 0)  //LiftBucket
			C_TEXT:C284(v_27_087_txt)  //Ladder
			ARRAY TEXT:C222(v_27_087_atxt; 0)  //Ladder
			C_TEXT:C284(v_27_088_txt)  //Boat
			ARRAY TEXT:C222(v_27_088_atxt; 0)  //Boat
			C_TEXT:C284(v_27_089_txt)  //Wader
			ARRAY TEXT:C222(v_27_089_atxt; 0)  //Wader
			C_TEXT:C284(v_27_090_txt)  //Inspector50
			ARRAY TEXT:C222(v_27_090_atxt; 0)  //Inspector50
			C_TEXT:C284(v_27_091_txt)  //Rigging
			ARRAY TEXT:C222(v_27_091_atxt; 0)  //Rigging
			C_TEXT:C284(v_27_092_txt)  //Staging
			ARRAY TEXT:C222(v_27_092_atxt; 0)  //Staging
			C_TEXT:C284(v_27_093_txt)  //Traffic Control
			ARRAY TEXT:C222(v_27_093_atxt; 0)  //Traffic Control
			C_TEXT:C284(v_27_094_txt)  //RR Flagman
			ARRAY TEXT:C222(v_27_094_atxt; 0)  //RR Flagman
			C_TEXT:C284(v_27_095_txt)  //Police
			ARRAY TEXT:C222(v_27_095_atxt; 0)  //Police
			C_TEXT:C284(v_27_096_txt)  //AccessOther
			ARRAY TEXT:C222(v_27_096_atxt; 0)  //AccessOther
			C_TEXT:C284(v_27_097_txt)  //OtherAccBool
			ARRAY TEXT:C222(v_27_097_atxt; 0)  //OtherAccBool
			C_TEXT:C284(v_27_098_txt)  //CollisionSuper
			ARRAY TEXT:C222(v_27_098_atxt; 0)  //CollisionSuper
			C_TEXT:C284(v_27_099_txt)  //LoadDeflSuper
			ARRAY TEXT:C222(v_27_099_atxt; 0)  //LoadDeflSuper
			C_TEXT:C284(v_27_100_txt)  //LoadVibSuper
			ARRAY TEXT:C222(v_27_100_atxt; 0)  //LoadVibSuper
			C_TEXT:C284(v_27_101_txt)  //CollisionSub
			ARRAY TEXT:C222(v_27_101_atxt; 0)  //CollisionSub
			C_TEXT:C284(v_27_102_txt)  //UnderminingTxt
			ARRAY TEXT:C222(v_27_102_atxt; 0)  //UnderminingTxt
			C_TEXT:C284(v_27_103_txt)  //ScourTxt
			ARRAY TEXT:C222(v_27_103_atxt; 0)  //ScourTxt
			C_TEXT:C284(v_27_104_txt)  //FieldTests
			ARRAY TEXT:C222(v_27_104_atxt; 0)  //FieldTests
			C_TEXT:C284(v_27_106_txt)  //BotCondition
			ARRAY TEXT:C222(v_27_106_atxt; 0)  //BotCondition
			C_TEXT:C284(v_27_107_txt)  //UW BrgAccess
			ARRAY TEXT:C222(v_27_107_atxt; 0)  //UW BrgAccess
			C_TEXT:C284(v_27_110_txt)  //Current
			ARRAY TEXT:C222(v_27_110_atxt; 0)  //Current
			C_TEXT:C284(v_27_113_txt)  //Item 62
			ARRAY TEXT:C222(v_27_113_atxt; 0)  //Item 62
			C_TEXT:C284(v_27_117_txt)  //Barrier Type
			ARRAY TEXT:C222(v_27_117_atxt; 0)  //Barrier Type
			C_TEXT:C284(v_27_119_txt)  //BrCldSignsNE
			ARRAY TEXT:C222(v_27_119_atxt; 0)  //BrCldSignsNE
			C_TEXT:C284(v_27_120_txt)  //BrCldSignsSW
			ARRAY TEXT:C222(v_27_120_atxt; 0)  //BrCldSignsSW
			C_TEXT:C284(v_27_121_txt)  //AdCldSignsNE
			ARRAY TEXT:C222(v_27_121_atxt; 0)  //AdCldSignsNE
			C_TEXT:C284(v_27_122_txt)  //AdCldSignsSW
			ARRAY TEXT:C222(v_27_122_atxt; 0)  //AdCldSignsSW
			C_TEXT:C284(v_27_131_txt)  //CldSignLegend
			ARRAY TEXT:C222(v_27_131_atxt; 0)  //CldSignLegend
			C_TEXT:C284(v_27_132_txt)  //DamageCmtsPg1
			ARRAY TEXT:C222(v_27_132_atxt; 0)  //DamageCmtsPg1
			C_TEXT:C284(v_27_134_txt)  //Modified By
			ARRAY TEXT:C222(v_27_134_atxt; 0)  //Modified By
			C_TEXT:C284(v_27_140_txt)  //Item 43
			ARRAY TEXT:C222(v_27_140_atxt; 0)  //Item 43
			C_TEXT:C284(v_27_141_txt)  //Item 107
			ARRAY TEXT:C222(v_27_141_atxt; 0)  //Item 107
			C_TEXT:C284(v_27_143_txt)  //Item59_i
			ARRAY TEXT:C222(v_27_143_atxt; 0)  //Item59_i
			C_TEXT:C284(v_27_144_txt)  //Item60_i
			ARRAY TEXT:C222(v_27_144_atxt; 0)  //Item60_i
			C_TEXT:C284(v_27_146_txt)  //CauDamage
			ARRAY TEXT:C222(v_27_146_atxt; 0)  //CauDamage
			C_TEXT:C284(v_27_148_txt)  //DamageBy
			ARRAY TEXT:C222(v_27_148_atxt; 0)  //DamageBy
			C_TEXT:C284(v_27_150_txt)  //ReimburseNo
			ARRAY TEXT:C222(v_27_150_atxt; 0)  //ReimburseNo
			C_TEXT:C284(v_27_151_txt)  //Item58_i
			ARRAY TEXT:C222(v_27_151_atxt; 0)  //Item58_i
			C_TEXT:C284(v_27_152_txt)  //Item60UW_i
			ARRAY TEXT:C222(v_27_152_atxt; 0)  //Item60UW_i
			C_TEXT:C284(v_27_153_txt)  //Item61UW_i
			ARRAY TEXT:C222(v_27_153_atxt; 0)  //Item61UW_i
			C_TEXT:C284(v_27_154_txt)  //Item62UW_i
			ARRAY TEXT:C222(v_27_154_atxt; 0)  //Item62UW_i
			C_TEXT:C284(v_27_155_txt)  //Item 60 Cur
			ARRAY TEXT:C222(v_27_155_atxt; 0)  //Item 60 Cur
			C_TEXT:C284(v_27_156_txt)  //Agency
			ARRAY TEXT:C222(v_27_156_atxt; 0)  //Agency
			C_TEXT:C284(v_27_159_txt)  //Item 61 Cur
			ARRAY TEXT:C222(v_27_159_atxt; 0)  //Item 61 Cur
			C_TEXT:C284(v_27_165_txt)  //Item 62 UW
			ARRAY TEXT:C222(v_27_165_atxt; 0)  //Item 62 UW
			C_TEXT:C284(v_27_166_txt)  //Item21
			ARRAY TEXT:C222(v_27_166_atxt; 0)  //Item21
			C_TEXT:C284(v_27_169_txt)  //InspApprCmts
			ARRAY TEXT:C222(v_27_169_atxt; 0)  //InspApprCmts
			C_TEXT:C284(v_27_170_txt)  //InspRevCmts
			ARRAY TEXT:C222(v_27_170_atxt; 0)  //InspRevCmts
			C_TEXT:C284(v_27_172_txt)  //Item 62 Cur
			ARRAY TEXT:C222(v_27_172_atxt; 0)  //Item 62 Cur
			C_TEXT:C284(v_27_173_txt)  //Item61_i
			ARRAY TEXT:C222(v_27_173_atxt; 0)  //Item61_i
			C_TEXT:C284(v_27_174_txt)  //Item62_i
			ARRAY TEXT:C222(v_27_174_atxt; 0)  //Item62_i
			C_TEXT:C284(v_27_176_txt)  //CulvertCoating
			ARRAY TEXT:C222(v_27_176_atxt; 0)  //CulvertCoating
			C_TEXT:C284(v_27_177_txt)  //CulvertMaterial
			ARRAY TEXT:C222(v_27_177_atxt; 0)  //CulvertMaterial
			C_TEXT:C284(v_27_178_txt)  //CulvertShape
			ARRAY TEXT:C222(v_27_178_atxt; 0)  //CulvertShape
			C_TEXT:C284(v_27_181_txt)  //ClassAEmp
			ARRAY TEXT:C222(v_27_181_atxt; 0)  //ClassAEmp
			C_TEXT:C284(v_27_182_txt)  //ConfinedSp
			ARRAY TEXT:C222(v_27_182_atxt; 0)  //ConfinedSp
			C_TEXT:C284(v_27_183_txt)  //OffHrsWork
			ARRAY TEXT:C222(v_27_183_atxt; 0)  //OffHrsWork
			C_TEXT:C284(v_27_185_txt)  //Dam_Boston_Office_Fwd
			ARRAY TEXT:C222(v_27_185_atxt; 0)  //Dam_Boston_Office_Fwd
			C_TEXT:C284(v_27_186_txt)  //Dam_Boston_Office_Remarks
			ARRAY TEXT:C222(v_27_186_atxt; 0)  //Dam_Boston_Office_Remarks
			C_TEXT:C284(v_27_189_txt)  //Cld_Contractor
			ARRAY TEXT:C222(v_27_189_atxt; 0)  //Cld_Contractor
			C_TEXT:C284(v_27_190_txt)  //Cld_Contract_Number
			ARRAY TEXT:C222(v_27_190_atxt; 0)  //Cld_Contract_Number
			C_TEXT:C284(v_27_191_txt)  //Cld_Remarks
			ARRAY TEXT:C222(v_27_191_atxt; 0)  //Cld_Remarks
			C_TEXT:C284(v_27_192_txt)  //Cld_Resident_Engineer
			ARRAY TEXT:C222(v_27_192_atxt; 0)  //Cld_Resident_Engineer
			C_TEXT:C284(v_27_193_txt)  //Cld_Scope_of_Work
			ARRAY TEXT:C222(v_27_193_atxt; 0)  //Cld_Scope_of_Work
			C_TEXT:C284(v_27_194_txt)  //Cld_Schedule
			ARRAY TEXT:C222(v_27_194_atxt; 0)  //Cld_Schedule
			C_TEXT:C284(v_27_197_txt)  //Item22
			ARRAY TEXT:C222(v_27_197_atxt; 0)  //Item22
			C_TEXT:C284(v_27_200_txt)  //Item26
			ARRAY TEXT:C222(v_27_200_atxt; 0)  //Item26
			C_TEXT:C284(v_27_203_txt)  //RatingFeedBack
			ARRAY TEXT:C222(v_27_203_atxt; 0)  //RatingFeedBack
			C_TEXT:C284(v_27_208_txt)  //ConsScoreCmts
			ARRAY TEXT:C222(v_27_208_atxt; 0)  //ConsScoreCmts
			C_TEXT:C284(v_27_210_txt)  //Item58_r
			ARRAY TEXT:C222(v_27_210_atxt; 0)  //Item58_r
			C_TEXT:C284(v_27_211_txt)  //Item59_r
			ARRAY TEXT:C222(v_27_211_atxt; 0)  //Item59_r
			C_TEXT:C284(v_27_212_txt)  //Item60_r
			ARRAY TEXT:C222(v_27_212_atxt; 0)  //Item60_r
			C_TEXT:C284(v_27_213_txt)  //Item62_r
			ARRAY TEXT:C222(v_27_213_atxt; 0)  //Item62_r
			C_TEXT:C284(v_27_215_txt)  //BaseType_s
			ARRAY TEXT:C222(v_27_215_atxt; 0)  //BaseType_s
			C_TEXT:C284(v_27_219_txt)  //Rating_WorkCar_desc_s
			ARRAY TEXT:C222(v_27_219_atxt; 0)  //Rating_WorkCar_desc_s
			C_TEXT:C284(v_27_220_txt)  //Rating_RevCar_desc_s
			ARRAY TEXT:C222(v_27_220_atxt; 0)  //Rating_RevCar_desc_s
			C_TEXT:C284(v_27_229_txt)  //Item113
			ARRAY TEXT:C222(v_27_229_atxt; 0)  //Item113
			C_REAL:C285(v_27_108_r)  //WaterDepth
			ARRAY REAL:C219(v_27_108_ar; 0)  //WaterDepth
			C_REAL:C285(v_27_109_r)  //WaterVisibility
			ARRAY REAL:C219(v_27_109_ar; 0)  //WaterVisibility
			C_REAL:C285(v_27_111_r)  //DepthofCovNE
			ARRAY REAL:C219(v_27_111_ar; 0)  //DepthofCovNE
			C_REAL:C285(v_27_112_r)  //DepthofCovSW
			ARRAY REAL:C219(v_27_112_ar; 0)  //DepthofCovSW
			C_REAL:C285(v_27_164_r)  //ClrMinM
			ARRAY REAL:C219(v_27_164_ar; 0)  //ClrMinM
			C_REAL:C285(v_27_179_r)  //BarrelsWidth
			ARRAY REAL:C219(v_27_179_ar; 0)  //BarrelsWidth
			C_REAL:C285(v_27_180_r)  //BarrelsHeight
			ARRAY REAL:C219(v_27_180_ar; 0)  //BarrelsHeight
			C_REAL:C285(v_27_187_r)  //Cld_Amount
			ARRAY REAL:C219(v_27_187_ar; 0)  //Cld_Amount
			C_LONGINT:C283(v_27_003_L)  //DBrInspEngr
			ARRAY INTEGER:C220(v_27_003_ai; 0)  //DBrInspEngr
			C_LONGINT:C283(v_27_004_L)  //TeamLeader
			ARRAY INTEGER:C220(v_27_004_ai; 0)  //TeamLeader
			C_LONGINT:C283(v_27_008_L)  //TempA
			ARRAY INTEGER:C220(v_27_008_ai; 0)  //TempA
			C_LONGINT:C283(v_27_010_L)  //CurbRevealNE
			ARRAY INTEGER:C220(v_27_010_ai; 0)  //CurbRevealNE
			C_LONGINT:C283(v_27_011_L)  //CurbRevealSW
			ARRAY INTEGER:C220(v_27_011_ai; 0)  //CurbRevealSW
			C_LONGINT:C283(v_27_012_L)  //InspReviewed
			ARRAY INTEGER:C220(v_27_012_ai; 0)  //InspReviewed
			C_LONGINT:C283(v_27_026_L)  //ActualPostH
			ARRAY INTEGER:C220(v_27_026_ai; 0)  //ActualPostH
			C_LONGINT:C283(v_27_027_L)  //ActualPost3
			ARRAY INTEGER:C220(v_27_027_ai; 0)  //ActualPost3
			C_LONGINT:C283(v_27_028_L)  //ActualPost3S2
			ARRAY INTEGER:C220(v_27_028_ai; 0)  //ActualPost3S2
			C_LONGINT:C283(v_27_029_L)  //ActualPostSgl
			ARRAY INTEGER:C220(v_27_029_ai; 0)  //ActualPostSgl
			C_LONGINT:C283(v_27_031_L)  //RecomPostingH
			ARRAY INTEGER:C220(v_27_031_ai; 0)  //RecomPostingH
			C_LONGINT:C283(v_27_032_L)  //RecomPosting3
			ARRAY INTEGER:C220(v_27_032_ai; 0)  //RecomPosting3
			C_LONGINT:C283(v_27_033_L)  //RecomPosting3S2
			ARRAY INTEGER:C220(v_27_033_ai; 0)  //RecomPosting3S2
			C_LONGINT:C283(v_27_034_L)  //RecomPostingSgl
			ARRAY INTEGER:C220(v_27_034_ai; 0)  //RecomPostingSgl
			C_LONGINT:C283(v_27_041_L)  //BrPostNELeg
			ARRAY INTEGER:C220(v_27_041_ai; 0)  //BrPostNELeg
			C_LONGINT:C283(v_27_042_L)  //BrPostNEVis
			ARRAY INTEGER:C220(v_27_042_ai; 0)  //BrPostNEVis
			C_LONGINT:C283(v_27_043_L)  //BrPostSWLeg
			ARRAY INTEGER:C220(v_27_043_ai; 0)  //BrPostSWLeg
			C_LONGINT:C283(v_27_044_L)  //BrPostSWVis
			ARRAY INTEGER:C220(v_27_044_ai; 0)  //BrPostSWVis
			C_LONGINT:C283(v_27_045_L)  //AdPostNELeg
			ARRAY INTEGER:C220(v_27_045_ai; 0)  //AdPostNELeg
			C_LONGINT:C283(v_27_046_L)  //AdPostNEVis
			ARRAY INTEGER:C220(v_27_046_ai; 0)  //AdPostNEVis
			C_LONGINT:C283(v_27_047_L)  //AdPostSWLeg
			ARRAY INTEGER:C220(v_27_047_ai; 0)  //AdPostSWLeg
			C_LONGINT:C283(v_27_048_L)  //AdPostSWVis
			ARRAY INTEGER:C220(v_27_048_ai; 0)  //AdPostSWVis
			C_LONGINT:C283(v_27_050_L)  //NEClrFldFT
			ARRAY INTEGER:C220(v_27_050_ai; 0)  //NEClrFldFT
			C_LONGINT:C283(v_27_051_L)  //NEClrFldIN
			ARRAY INTEGER:C220(v_27_051_ai; 0)  //NEClrFldIN
			C_LONGINT:C283(v_27_052_L)  //NEClrPostedFT
			ARRAY INTEGER:C220(v_27_052_ai; 0)  //NEClrPostedFT
			C_LONGINT:C283(v_27_053_L)  //NEClrPostedIN
			ARRAY INTEGER:C220(v_27_053_ai; 0)  //NEClrPostedIN
			C_LONGINT:C283(v_27_058_L)  //BrClrSignNELeg
			ARRAY INTEGER:C220(v_27_058_ai; 0)  //BrClrSignNELeg
			C_LONGINT:C283(v_27_059_L)  //BrClrSignNEVis
			ARRAY INTEGER:C220(v_27_059_ai; 0)  //BrClrSignNEVis
			C_LONGINT:C283(v_27_060_L)  //BrClrSignSWLeg
			ARRAY INTEGER:C220(v_27_060_ai; 0)  //BrClrSignSWLeg
			C_LONGINT:C283(v_27_061_L)  //BrClrSignSWVis
			ARRAY INTEGER:C220(v_27_061_ai; 0)  //BrClrSignSWVis
			C_LONGINT:C283(v_27_062_L)  //AdClrSignNELeg
			ARRAY INTEGER:C220(v_27_062_ai; 0)  //AdClrSignNELeg
			C_LONGINT:C283(v_27_063_L)  //AdClrSignNEVis
			ARRAY INTEGER:C220(v_27_063_ai; 0)  //AdClrSignNEVis
			C_LONGINT:C283(v_27_064_L)  //AdClrSignSWLeg
			ARRAY INTEGER:C220(v_27_064_ai; 0)  //AdClrSignSWLeg
			C_LONGINT:C283(v_27_065_L)  //AdClrSignSWVis
			ARRAY INTEGER:C220(v_27_065_ai; 0)  //AdClrSignSWVis
			C_LONGINT:C283(v_27_068_L)  //Total HRS
			ARRAY INTEGER:C220(v_27_068_ai; 0)  //Total HRS
			C_LONGINT:C283(v_27_105_L)  //LevelofInsp
			ARRAY INTEGER:C220(v_27_105_ai; 0)  //LevelofInsp
			C_LONGINT:C283(v_27_123_L)  //BrCldSignNELeg
			ARRAY INTEGER:C220(v_27_123_ai; 0)  //BrCldSignNELeg
			C_LONGINT:C283(v_27_124_L)  //BrCldSignNEVis
			ARRAY INTEGER:C220(v_27_124_ai; 0)  //BrCldSignNEVis
			C_LONGINT:C283(v_27_125_L)  //BrCldSignSWLeg
			ARRAY INTEGER:C220(v_27_125_ai; 0)  //BrCldSignSWLeg
			C_LONGINT:C283(v_27_126_L)  //BrCldSignSWVis
			ARRAY INTEGER:C220(v_27_126_ai; 0)  //BrCldSignSWVis
			C_LONGINT:C283(v_27_127_L)  //AdCldSignNELeg
			ARRAY INTEGER:C220(v_27_127_ai; 0)  //AdCldSignNELeg
			C_LONGINT:C283(v_27_128_L)  //AdCldSignNEVis
			ARRAY INTEGER:C220(v_27_128_ai; 0)  //AdCldSignNEVis
			C_LONGINT:C283(v_27_129_L)  //AdCldSignSWLeg
			ARRAY INTEGER:C220(v_27_129_ai; 0)  //AdCldSignSWLeg
			C_LONGINT:C283(v_27_130_L)  //AdCldSignSWVis
			ARRAY INTEGER:C220(v_27_130_ai; 0)  //AdCldSignSWVis
			C_LONGINT:C283(v_27_157_L)  //YrPainted
			ARRAY INTEGER:C220(v_27_157_ai; 0)  //YrPainted
			C_LONGINT:C283(v_27_158_L)  //YrRehab
			ARRAY INTEGER:C220(v_27_158_ai; 0)  //YrRehab
			C_LONGINT:C283(v_27_160_L)  //SWClrFldFT
			ARRAY INTEGER:C220(v_27_160_ai; 0)  //SWClrFldFT
			C_LONGINT:C283(v_27_161_L)  //SWClrFldIN
			ARRAY INTEGER:C220(v_27_161_ai; 0)  //SWClrFldIN
			C_LONGINT:C283(v_27_162_L)  //SWClrPostedFT
			ARRAY INTEGER:C220(v_27_162_ai; 0)  //SWClrPostedFT
			C_LONGINT:C283(v_27_163_L)  //SWClrPostedIN
			ARRAY INTEGER:C220(v_27_163_ai; 0)  //SWClrPostedIN
			C_LONGINT:C283(v_27_167_L)  //InspApproved
			ARRAY INTEGER:C220(v_27_167_ai; 0)  //InspApproved
			C_LONGINT:C283(v_27_175_L)  //BarrelsNumber
			ARRAY INTEGER:C220(v_27_175_ai; 0)  //BarrelsNumber
			C_LONGINT:C283(v_27_198_L)  //Item106
			ARRAY INTEGER:C220(v_27_198_ai; 0)  //Item106
			C_LONGINT:C283(v_27_201_L)  //ConsScoring
			ARRAY INTEGER:C220(v_27_201_ai; 0)  //ConsScoring
			C_LONGINT:C283(v_27_205_L)  //ConsQCEngrID
			ARRAY INTEGER:C220(v_27_205_ai; 0)  //ConsQCEngrID
			C_LONGINT:C283(v_27_002_L)  //InspID
			ARRAY LONGINT:C221(v_27_002_aL; 0)  //InspID
			C_LONGINT:C283(v_27_005_L)  //InDepthReview
			ARRAY LONGINT:C221(v_27_005_aL; 0)  //InDepthReview
			C_LONGINT:C283(v_27_217_L)  //UpdateMaximo_L
			ARRAY LONGINT:C221(v_27_217_aL; 0)  //UpdateMaximo_L
			C_LONGINT:C283(v_27_227_L)  //InvPhotoApproach_L
			ARRAY LONGINT:C221(v_27_227_aL; 0)  //InvPhotoApproach_L
			C_LONGINT:C283(v_27_228_L)  //InvPhotoElevation_L
			ARRAY LONGINT:C221(v_27_228_aL; 0)  //InvPhotoElevation_L
			C_DATE:C307(v_27_035_d)  //WaivedDate
			ARRAY DATE:C224(v_27_035_ad; 0)  //WaivedDate
			C_DATE:C307(v_27_036_d)  //EDJMT Date
			ARRAY DATE:C224(v_27_036_ad; 0)  //EDJMT Date
			C_DATE:C307(v_27_067_d)  //Item 93b
			ARRAY DATE:C224(v_27_067_ad; 0)  //Item 93b
			C_DATE:C307(v_27_074_d)  //Rating Date
			ARRAY DATE:C224(v_27_074_ad; 0)  //Rating Date
			C_DATE:C307(v_27_078_d)  //Insp Date
			ARRAY DATE:C224(v_27_078_ad; 0)  //Insp Date
			C_DATE:C307(v_27_114_d)  //PostingDate
			ARRAY DATE:C224(v_27_114_ad; 0)  //PostingDate
			C_DATE:C307(v_27_135_d)  //DateCreated
			ARRAY DATE:C224(v_27_135_ad; 0)  //DateCreated
			C_DATE:C307(v_27_137_d)  //DateModified
			ARRAY DATE:C224(v_27_137_ad; 0)  //DateModified
			C_DATE:C307(v_27_142_d)  //Item 90
			ARRAY DATE:C224(v_27_142_ad; 0)  //Item 90
			C_DATE:C307(v_27_147_d)  //D_Damage
			ARRAY DATE:C224(v_27_147_ad; 0)  //D_Damage
			C_DATE:C307(v_27_184_d)  //Dam_Boston_Office_Date
			ARRAY DATE:C224(v_27_184_ad; 0)  //Dam_Boston_Office_Date
			C_DATE:C307(v_27_188_d)  //Cld_Completion_Date
			ARRAY DATE:C224(v_27_188_ad; 0)  //Cld_Completion_Date
			C_DATE:C307(v_27_202_d)  //ConsAcceptanceDate
			ARRAY DATE:C224(v_27_202_ad; 0)  //ConsAcceptanceDate
			C_DATE:C307(v_27_206_d)  //InspDBIEApprDate
			ARRAY DATE:C224(v_27_206_ad; 0)  //InspDBIEApprDate
			C_DATE:C307(v_27_207_d)  //InspAreaEngApprDate
			ARRAY DATE:C224(v_27_207_ad; 0)  //InspAreaEngApprDate
			C_DATE:C307(v_27_214_d)  //InspDate_r
			ARRAY DATE:C224(v_27_214_ad; 0)  //InspDate_r
			C_DATE:C307(v_27_218_d)  //CreateApprovedPDF_d
			ARRAY DATE:C224(v_27_218_ad; 0)  //CreateApprovedPDF_d
			C_DATE:C307(v_27_221_d)  //InspCompleteDate
			ARRAY DATE:C224(v_27_221_ad; 0)  //InspCompleteDate
			C_DATE:C307(v_27_222_d)  //InspDBIEReviewDate
			ARRAY DATE:C224(v_27_222_ad; 0)  //InspDBIEReviewDate
			C_DATE:C307(v_27_223_d)  //InspAIEReviewDate
			ARRAY DATE:C224(v_27_223_ad; 0)  //InspAIEReviewDate
			C_DATE:C307(v_27_224_d)  //InspFldWorkComplDate
			ARRAY DATE:C224(v_27_224_ad; 0)  //InspFldWorkComplDate
			C_DATE:C307(v_27_225_d)  //InspDBIE1stApprDate
			ARRAY DATE:C224(v_27_225_ad; 0)  //InspDBIE1stApprDate
			C_TIME:C306(v_27_136_tm)  //TimeCreated
			ARRAY TIME:C1223(v_27_136_atm; 0)  //TimeCreated
			C_TIME:C306(v_27_138_tm)  //TimeModified
			ARRAY TIME:C1223(v_27_138_atm; 0)  //TimeModified
			C_BOOLEAN:C305(v_27_009_b)  //InitialInsp
			ARRAY BOOLEAN:C223(v_27_009_ab; 0)  //InitialInsp
			C_BOOLEAN:C305(v_27_016_b)  //FractureCrit
			ARRAY BOOLEAN:C223(v_27_016_ab; 0)  //FractureCrit
			C_BOOLEAN:C305(v_27_017_b)  //Cracks
			ARRAY BOOLEAN:C223(v_27_017_ab; 0)  //Cracks
			C_BOOLEAN:C305(v_27_019_b)  //UnderMining
			ARRAY BOOLEAN:C223(v_27_019_ab; 0)  //UnderMining
			C_BOOLEAN:C305(v_27_030_b)  //WeightPosting
			ARRAY BOOLEAN:C223(v_27_030_ab; 0)  //WeightPosting
			C_BOOLEAN:C305(v_27_049_b)  //ClrPosting
			ARRAY BOOLEAN:C223(v_27_049_ab; 0)  //ClrPosting
			C_BOOLEAN:C305(v_27_069_b)  //Plans
			ARRAY BOOLEAN:C223(v_27_069_ab; 0)  //Plans
			C_BOOLEAN:C305(v_27_070_b)  //VCR
			ARRAY BOOLEAN:C223(v_27_070_ab; 0)  //VCR
			C_BOOLEAN:C305(v_27_073_b)  //Rating Report
			ARRAY BOOLEAN:C223(v_27_073_ab; 0)  //Rating Report
			C_BOOLEAN:C305(v_27_075_b)  //Rerating
			ARRAY BOOLEAN:C223(v_27_075_ab; 0)  //Rerating
			C_BOOLEAN:C305(v_27_115_b)  //BarriersIP
			ARRAY BOOLEAN:C223(v_27_115_ab; 0)  //BarriersIP
			C_BOOLEAN:C305(v_27_116_b)  //RoadWayAbandon
			ARRAY BOOLEAN:C223(v_27_116_ab; 0)  //RoadWayAbandon
			C_BOOLEAN:C305(v_27_118_b)  //ClosedSigns
			ARRAY BOOLEAN:C223(v_27_118_ab; 0)  //ClosedSigns
			C_BOOLEAN:C305(v_27_133_b)  //OrientationNS
			ARRAY BOOLEAN:C223(v_27_133_ab; 0)  //OrientationNS
			C_BOOLEAN:C305(v_27_139_b)  //UWInspReqd
			ARRAY BOOLEAN:C223(v_27_139_ab; 0)  //UWInspReqd
			C_BOOLEAN:C305(v_27_145_b)  //ClsdRoutine
			ARRAY BOOLEAN:C223(v_27_145_ab; 0)  //ClsdRoutine
			C_BOOLEAN:C305(v_27_149_b)  //AccidentRep
			ARRAY BOOLEAN:C223(v_27_149_ab; 0)  //AccidentRep
			C_BOOLEAN:C305(v_27_168_b)  //InspComplete
			ARRAY BOOLEAN:C223(v_27_168_ab; 0)  //InspComplete
			C_BOOLEAN:C305(v_27_195_b)  //Cld_UnderConstruction
			ARRAY BOOLEAN:C223(v_27_195_ab; 0)  //Cld_UnderConstruction
			C_BOOLEAN:C305(v_27_196_b)  //DoNotShowDialogDependency
			ARRAY BOOLEAN:C223(v_27_196_ab; 0)  //DoNotShowDialogDependency
			C_BOOLEAN:C305(v_27_199_b)  //TeamMembrAddl
			ARRAY BOOLEAN:C223(v_27_199_ab; 0)  //TeamMembrAddl
			C_BOOLEAN:C305(v_27_209_b)  //InspRtnSpcMemFlag
			ARRAY BOOLEAN:C223(v_27_209_ab; 0)  //InspRtnSpcMemFlag
			C_BOOLEAN:C305(v_27_216_b)  //ADA_Accessible_b
			ARRAY BOOLEAN:C223(v_27_216_ab; 0)  //ADA_Accessible_b
		: ($1=28)  //Sequences
			C_TEXT:C284(v_28_004_txt)  //Sequences_UUIDKey_s
			ARRAY TEXT:C222(v_28_004_atxt; 0)  //Sequences_UUIDKey_s
			C_TEXT:C284(v_28_001_txt)  //Name
			ARRAY TEXT:C222(v_28_001_atxt; 0)  //Name
			C_LONGINT:C283(v_28_002_L)  //Value
			ARRAY LONGINT:C221(v_28_002_aL; 0)  //Value
			C_BOOLEAN:C305(v_28_003_b)  //Increment
			ARRAY BOOLEAN:C223(v_28_003_ab; 0)  //Increment
		: ($1=29)  //ElementsSafety
			C_BLOB:C604(v_29_023_blb)  //ElmComments
			ARRAY BLOB:C1222(v_29_023_ablb; 0)  //ElmComments
			C_TEXT:C284(v_29_027_txt)  //ElementsSafety_UUIDKey_s
			ARRAY TEXT:C222(v_29_027_atxt; 0)  //ElementsSafety_UUIDKey_s
			C_TEXT:C284(v_29_002_txt)  //Rating
			ARRAY TEXT:C222(v_29_002_atxt; 0)  //Rating
			C_TEXT:C284(v_29_003_txt)  //Deficiency
			ARRAY TEXT:C222(v_29_003_atxt; 0)  //Deficiency
			C_TEXT:C284(v_29_005_txt)  //Comments
			ARRAY TEXT:C222(v_29_005_atxt; 0)  //Comments
			C_TEXT:C284(v_29_010_txt)  //Weld Condition
			ARRAY TEXT:C222(v_29_010_atxt; 0)  //Weld Condition
			C_TEXT:C284(v_29_014_txt)  //Modified By
			ARRAY TEXT:C222(v_29_014_atxt; 0)  //Modified By
			C_TEXT:C284(v_29_015_txt)  //Rating_i
			ARRAY TEXT:C222(v_29_015_atxt; 0)  //Rating_i
			C_TEXT:C284(v_29_020_txt)  //Priority
			ARRAY TEXT:C222(v_29_020_atxt; 0)  //Priority
			C_TEXT:C284(v_29_021_txt)  //AltRating
			ARRAY TEXT:C222(v_29_021_atxt; 0)  //AltRating
			C_TEXT:C284(v_29_022_txt)  //Description
			ARRAY TEXT:C222(v_29_022_atxt; 0)  //Description
			C_TEXT:C284(v_29_024_txt)  //AltRating_i
			ARRAY TEXT:C222(v_29_024_atxt; 0)  //AltRating_i
			C_TEXT:C284(v_29_025_txt)  //ModTimeStamp_s
			ARRAY TEXT:C222(v_29_025_atxt; 0)  //ModTimeStamp_s
			C_TEXT:C284(v_29_026_txt)  //maximo_UpdateTimeStamp_s
			ARRAY TEXT:C222(v_29_026_atxt; 0)  //maximo_UpdateTimeStamp_s
			C_LONGINT:C283(v_29_001_L)  //ElementNo
			ARRAY INTEGER:C220(v_29_001_ai; 0)  //ElementNo
			C_LONGINT:C283(v_29_011_L)  //Inv H20
			ARRAY INTEGER:C220(v_29_011_ai; 0)  //Inv H20
			C_LONGINT:C283(v_29_012_L)  //Inv Type 3
			ARRAY INTEGER:C220(v_29_012_ai; 0)  //Inv Type 3
			C_LONGINT:C283(v_29_013_L)  //Inv 3S2
			ARRAY INTEGER:C220(v_29_013_ai; 0)  //Inv 3S2
			C_LONGINT:C283(v_29_004_L)  //InspID
			ARRAY LONGINT:C221(v_29_004_aL; 0)  //InspID
			C_LONGINT:C283(v_29_007_L)  //ElmSafetyID
			ARRAY LONGINT:C221(v_29_007_aL; 0)  //ElmSafetyID
			C_DATE:C307(v_29_016_d)  //DateCreated
			ARRAY DATE:C224(v_29_016_ad; 0)  //DateCreated
			C_DATE:C307(v_29_018_d)  //DateModified
			ARRAY DATE:C224(v_29_018_ad; 0)  //DateModified
			C_TIME:C306(v_29_017_tm)  //TimeCreated
			ARRAY TIME:C1223(v_29_017_atm; 0)  //TimeCreated
			C_TIME:C306(v_29_019_tm)  //TimeModified
			ARRAY TIME:C1223(v_29_019_atm; 0)  //TimeModified
			C_BOOLEAN:C305(v_29_006_b)  //Comment Flag
			ARRAY BOOLEAN:C223(v_29_006_ab; 0)  //Comment Flag
			C_BOOLEAN:C305(v_29_008_b)  //SpecMemb Flag
			ARRAY BOOLEAN:C223(v_29_008_ab; 0)  //SpecMemb Flag
			C_BOOLEAN:C305(v_29_009_b)  //Crack
			ARRAY BOOLEAN:C223(v_29_009_ab; 0)  //Crack
		: ($1=30)  //ElementDict
			C_TEXT:C284(v_30_015_txt)  //ElementDict_UUIDKey_s
			ARRAY TEXT:C222(v_30_015_atxt; 0)  //ElementDict_UUIDKey_s
			C_TEXT:C284(v_30_002_txt)  //Description
			ARRAY TEXT:C222(v_30_002_atxt; 0)  //Description
			C_TEXT:C284(v_30_003_txt)  //Category
			ARRAY TEXT:C222(v_30_003_atxt; 0)  //Category
			C_TEXT:C284(v_30_010_txt)  //ModifiedBy
			ARRAY TEXT:C222(v_30_010_atxt; 0)  //ModifiedBy
			C_TEXT:C284(v_30_011_txt)  //Prefix
			ARRAY TEXT:C222(v_30_011_atxt; 0)  //Prefix
			C_TEXT:C284(v_30_012_txt)  //Part
			ARRAY TEXT:C222(v_30_012_atxt; 0)  //Part
			C_TEXT:C284(v_30_013_txt)  //FullLabel
			ARRAY TEXT:C222(v_30_013_atxt; 0)  //FullLabel
			C_TEXT:C284(v_30_014_txt)  //FullLabelArch
			ARRAY TEXT:C222(v_30_014_atxt; 0)  //FullLabelArch
			C_LONGINT:C283(v_30_001_L)  //ElementNo
			ARRAY INTEGER:C220(v_30_001_ai; 0)  //ElementNo
			C_LONGINT:C283(v_30_004_L)  //Parent
			ARRAY INTEGER:C220(v_30_004_ai; 0)  //Parent
			C_DATE:C307(v_30_006_d)  //DateCreated
			ARRAY DATE:C224(v_30_006_ad; 0)  //DateCreated
			C_DATE:C307(v_30_008_d)  //DateModified
			ARRAY DATE:C224(v_30_008_ad; 0)  //DateModified
			C_TIME:C306(v_30_007_tm)  //TimeCreated
			ARRAY TIME:C1223(v_30_007_atm; 0)  //TimeCreated
			C_TIME:C306(v_30_009_tm)  //TimeModified
			ARRAY TIME:C1223(v_30_009_atm; 0)  //TimeModified
			C_BOOLEAN:C305(v_30_005_b)  //IsParent
			ARRAY BOOLEAN:C223(v_30_005_ab; 0)  //IsParent
		: ($1=31)  //Inspection Type
			C_TEXT:C284(v_31_003_txt)  //Inspection_Type_UUIDKey_s
			ARRAY TEXT:C222(v_31_003_atxt; 0)  //Inspection_Type_UUIDKey_s
			C_TEXT:C284(v_31_001_txt)  //Code
			ARRAY TEXT:C222(v_31_001_atxt; 0)  //Code
			C_TEXT:C284(v_31_002_txt)  //Description
			ARRAY TEXT:C222(v_31_002_atxt; 0)  //Description
			C_TEXT:C284(v_31_004_txt)  //ElementNumbers_txt
			ARRAY TEXT:C222(v_31_004_atxt; 0)  //ElementNumbers_txt
		: ($1=32)  //Element Cat
			C_TEXT:C284(v_32_005_txt)  //Element_Cat_UUIDKey_s
			ARRAY TEXT:C222(v_32_005_atxt; 0)  //Element_Cat_UUIDKey_s
			C_TEXT:C284(v_32_001_txt)  //Code
			ARRAY TEXT:C222(v_32_001_atxt; 0)  //Code
			C_TEXT:C284(v_32_002_txt)  //Description
			ARRAY TEXT:C222(v_32_002_atxt; 0)  //Description
			C_BOOLEAN:C305(v_32_003_b)  //CulvertElement
			ARRAY BOOLEAN:C223(v_32_003_ab; 0)  //CulvertElement
			C_BOOLEAN:C305(v_32_004_b)  //RegularElement
			ARRAY BOOLEAN:C223(v_32_004_ab; 0)  //RegularElement
		: ($1=33)  //Item 100
			C_TEXT:C284(v_33_003_txt)  //Item_100_UUIDKey_s
			ARRAY TEXT:C222(v_33_003_atxt; 0)  //Item_100_UUIDKey_s
			C_TEXT:C284(v_33_001_txt)  //Code
			ARRAY TEXT:C222(v_33_001_atxt; 0)  //Code
			C_TEXT:C284(v_33_002_txt)  //Description
			ARRAY TEXT:C222(v_33_002_atxt; 0)  //Description
		: ($1=34)  //Item 101
			C_TEXT:C284(v_34_003_txt)  //Item_101_UUIDKey_s
			ARRAY TEXT:C222(v_34_003_atxt; 0)  //Item_101_UUIDKey_s
			C_TEXT:C284(v_34_001_txt)  //Code
			ARRAY TEXT:C222(v_34_001_atxt; 0)  //Code
			C_TEXT:C284(v_34_002_txt)  //Description
			ARRAY TEXT:C222(v_34_002_atxt; 0)  //Description
		: ($1=35)  //Item 111
			C_TEXT:C284(v_35_003_txt)  //Item_111_UUIDKey_s
			ARRAY TEXT:C222(v_35_003_atxt; 0)  //Item_111_UUIDKey_s
			C_TEXT:C284(v_35_001_txt)  //Code
			ARRAY TEXT:C222(v_35_001_atxt; 0)  //Code
			C_TEXT:C284(v_35_002_txt)  //Description
			ARRAY TEXT:C222(v_35_002_atxt; 0)  //Description
		: ($1=36)  //Standard Photos
			C_TEXT:C284(v_36_010_txt)  //Standard_Photos_UUIDKey_s
			ARRAY TEXT:C222(v_36_010_atxt; 0)  //Standard_Photos_UUIDKey_s
			C_TEXT:C284(v_36_002_txt)  //Description
			ARRAY TEXT:C222(v_36_002_atxt; 0)  //Description
			C_TEXT:C284(v_36_005_txt)  //PictType
			ARRAY TEXT:C222(v_36_005_atxt; 0)  //PictType
			C_TEXT:C284(v_36_008_txt)  //ModTimeStamp_s
			ARRAY TEXT:C222(v_36_008_atxt; 0)  //ModTimeStamp_s
			C_TEXT:C284(v_36_009_txt)  //maximo_UpdateTimeStamp_s
			ARRAY TEXT:C222(v_36_009_atxt; 0)  //maximo_UpdateTimeStamp_s
			C_LONGINT:C283(v_36_006_L)  //SeqNum
			ARRAY INTEGER:C220(v_36_006_ai; 0)  //SeqNum
			C_LONGINT:C283(v_36_001_L)  //InspID
			ARRAY LONGINT:C221(v_36_001_aL; 0)  //InspID
			C_LONGINT:C283(v_36_007_L)  //StdPhotoID
			ARRAY LONGINT:C221(v_36_007_aL; 0)  //StdPhotoID
			C_BOOLEAN:C305(v_36_004_b)  //Portrait
			ARRAY BOOLEAN:C223(v_36_004_ab; 0)  //Portrait
			C_PICTURE:C286(v_36_003_p)  //Std Photo
			ARRAY PICTURE:C279(v_36_003_ap; 0)  //Std Photo
		: ($1=37)  //RAILBridgeInfo
			C_TEXT:C284(v_37_046_txt)  //RAILBridgeInfo_UUIDKey_s
			ARRAY TEXT:C222(v_37_046_atxt; 0)  //RAILBridgeInfo_UUIDKey_s
			C_TEXT:C284(v_37_001_txt)  //BIN
			ARRAY TEXT:C222(v_37_001_atxt; 0)  //BIN
			C_TEXT:C284(v_37_004_txt)  //TypeOfTies
			ARRAY TEXT:C222(v_37_004_atxt; 0)  //TypeOfTies
			C_TEXT:C284(v_37_005_txt)  //Ballast
			ARRAY TEXT:C222(v_37_005_atxt; 0)  //Ballast
			C_TEXT:C284(v_37_006_txt)  //LineName
			ARRAY TEXT:C222(v_37_006_atxt; 0)  //LineName
			C_TEXT:C284(v_37_017_txt)  //CreatedBy_s
			ARRAY TEXT:C222(v_37_017_atxt; 0)  //CreatedBy_s
			C_TEXT:C284(v_37_020_txt)  //ModifiedBy_s
			ARRAY TEXT:C222(v_37_020_atxt; 0)  //ModifiedBy_s
			C_TEXT:C284(v_37_030_txt)  //Rating_RevCar_desc_s
			ARRAY TEXT:C222(v_37_030_atxt; 0)  //Rating_RevCar_desc_s
			C_TEXT:C284(v_37_040_txt)  //Rating_WorkCar_desc_s
			ARRAY TEXT:C222(v_37_040_atxt; 0)  //Rating_WorkCar_desc_s
			C_TEXT:C284(v_37_056_txt)  //Rating_RevCar2_desc_s
			ARRAY TEXT:C222(v_37_056_atxt; 0)  //Rating_RevCar2_desc_s
			C_TEXT:C284(v_37_060_txt)  //Rating_RevCar3_desc_s
			ARRAY TEXT:C222(v_37_060_atxt; 0)  //Rating_RevCar3_desc_s
			C_REAL:C285(v_37_002_r)  //MilePt
			ARRAY REAL:C219(v_37_002_ar; 0)  //MilePt
			C_REAL:C285(v_37_008_r)  //Rating_E80
			ARRAY REAL:C219(v_37_008_ar; 0)  //Rating_E80
			C_REAL:C285(v_37_009_r)  //Rating_F40PH
			ARRAY REAL:C219(v_37_009_ar; 0)  //Rating_F40PH
			C_REAL:C285(v_37_010_r)  //Rating_286K
			ARRAY REAL:C219(v_37_010_ar; 0)  //Rating_286K
			C_REAL:C285(v_37_011_r)  //Rating_263K
			ARRAY REAL:C219(v_37_011_ar; 0)  //Rating_263K
			C_REAL:C285(v_37_012_r)  //Rating_E80_Max
			ARRAY REAL:C219(v_37_012_ar; 0)  //Rating_E80_Max
			C_REAL:C285(v_37_013_r)  //Rating_F40PH_Max
			ARRAY REAL:C219(v_37_013_ar; 0)  //Rating_F40PH_Max
			C_REAL:C285(v_37_014_r)  //Rating_286K_Max
			ARRAY REAL:C219(v_37_014_ar; 0)  //Rating_286K_Max
			C_REAL:C285(v_37_015_r)  //Rating_263K_Max
			ARRAY REAL:C219(v_37_015_ar; 0)  //Rating_263K_Max
			C_REAL:C285(v_37_023_r)  //Rating_E80_fatigue_r
			ARRAY REAL:C219(v_37_023_ar; 0)  //Rating_E80_fatigue_r
			C_REAL:C285(v_37_024_r)  //Rating_F40PH_fatigue_r
			ARRAY REAL:C219(v_37_024_ar; 0)  //Rating_F40PH_fatigue_r
			C_REAL:C285(v_37_025_r)  //Rating_286K_fatigue_r
			ARRAY REAL:C219(v_37_025_ar; 0)  //Rating_286K_fatigue_r
			C_REAL:C285(v_37_026_r)  //Rating_263K_fatigue_r
			ARRAY REAL:C219(v_37_026_ar; 0)  //Rating_263K_fatigue_r
			C_REAL:C285(v_37_027_r)  //Rating_RevCar_inv_r
			ARRAY REAL:C219(v_37_027_ar; 0)  //Rating_RevCar_inv_r
			C_REAL:C285(v_37_028_r)  //Rating_RevCar_oper_r
			ARRAY REAL:C219(v_37_028_ar; 0)  //Rating_RevCar_oper_r
			C_REAL:C285(v_37_029_r)  //Rating_RevCar_fatigue_r
			ARRAY REAL:C219(v_37_029_ar; 0)  //Rating_RevCar_fatigue_r
			C_REAL:C285(v_37_031_r)  //Rating_NEOPLAN_inv_r
			ARRAY REAL:C219(v_37_031_ar; 0)  //Rating_NEOPLAN_inv_r
			C_REAL:C285(v_37_032_r)  //Rating_NEOPLAN_oper_r
			ARRAY REAL:C219(v_37_032_ar; 0)  //Rating_NEOPLAN_oper_r
			C_REAL:C285(v_37_033_r)  //Rating_NEOPLAN_fatigue_r
			ARRAY REAL:C219(v_37_033_ar; 0)  //Rating_NEOPLAN_fatigue_r
			C_REAL:C285(v_37_034_r)  //Rating_NABI_inv_r
			ARRAY REAL:C219(v_37_034_ar; 0)  //Rating_NABI_inv_r
			C_REAL:C285(v_37_035_r)  //Rating_NABI_oper_r
			ARRAY REAL:C219(v_37_035_ar; 0)  //Rating_NABI_oper_r
			C_REAL:C285(v_37_036_r)  //Rating_NABI_fatigue_r
			ARRAY REAL:C219(v_37_036_ar; 0)  //Rating_NABI_fatigue_r
			C_REAL:C285(v_37_037_r)  //Rating_WorkCar_inv_r
			ARRAY REAL:C219(v_37_037_ar; 0)  //Rating_WorkCar_inv_r
			C_REAL:C285(v_37_038_r)  //Rating_WorkCar_oper_r
			ARRAY REAL:C219(v_37_038_ar; 0)  //Rating_WorkCar_oper_r
			C_REAL:C285(v_37_039_r)  //Rating_WorkCar_fatigue_r
			ARRAY REAL:C219(v_37_039_ar; 0)  //Rating_WorkCar_fatigue_r
			C_REAL:C285(v_37_041_r)  //Rating_315K
			ARRAY REAL:C219(v_37_041_ar; 0)  //Rating_315K
			C_REAL:C285(v_37_042_r)  //Rating_315K_Max
			ARRAY REAL:C219(v_37_042_ar; 0)  //Rating_315K_Max
			C_REAL:C285(v_37_043_r)  //Rating_315K_fatigue_R
			ARRAY REAL:C219(v_37_043_ar; 0)  //Rating_315K_fatigue_R
			C_REAL:C285(v_37_044_r)  //Rating_HybridArtic_inv_r
			ARRAY REAL:C219(v_37_044_ar; 0)  //Rating_HybridArtic_inv_r
			C_REAL:C285(v_37_045_r)  //Rating_HybridArtic_oper_r
			ARRAY REAL:C219(v_37_045_ar; 0)  //Rating_HybridArtic_oper_r
			C_REAL:C285(v_37_047_r)  //Rating_HSP46
			ARRAY REAL:C219(v_37_047_ar; 0)  //Rating_HSP46
			C_REAL:C285(v_37_048_r)  //Rating_HSP46_Max
			ARRAY REAL:C219(v_37_048_ar; 0)  //Rating_HSP46_Max
			C_REAL:C285(v_37_049_r)  //Rating_HSP46_fatigue_r
			ARRAY REAL:C219(v_37_049_ar; 0)  //Rating_HSP46_fatigue_r
			C_REAL:C285(v_37_050_r)  //Rating_ES44AC
			ARRAY REAL:C219(v_37_050_ar; 0)  //Rating_ES44AC
			C_REAL:C285(v_37_051_r)  //Rating_ES44AC_Max
			ARRAY REAL:C219(v_37_051_ar; 0)  //Rating_ES44AC_Max
			C_REAL:C285(v_37_052_r)  //Rating_ES44AC_fatigue_r
			ARRAY REAL:C219(v_37_052_ar; 0)  //Rating_ES44AC_fatigue_r
			C_REAL:C285(v_37_053_r)  //Rating_RevCar2_inv_r
			ARRAY REAL:C219(v_37_053_ar; 0)  //Rating_RevCar2_inv_r
			C_REAL:C285(v_37_054_r)  //Rating_RevCar2_oper_r
			ARRAY REAL:C219(v_37_054_ar; 0)  //Rating_RevCar2_oper_r
			C_REAL:C285(v_37_055_r)  //Rating_RevCar2_fatigue_r
			ARRAY REAL:C219(v_37_055_ar; 0)  //Rating_RevCar2_fatigue_r
			C_REAL:C285(v_37_057_r)  //Rating_RevCar3_inv_r
			ARRAY REAL:C219(v_37_057_ar; 0)  //Rating_RevCar3_inv_r
			C_REAL:C285(v_37_058_r)  //Rating_RevCar3_oper_r
			ARRAY REAL:C219(v_37_058_ar; 0)  //Rating_RevCar3_oper_r
			C_REAL:C285(v_37_059_r)  //Rating_RevCar3_fatigue_r
			ARRAY REAL:C219(v_37_059_ar; 0)  //Rating_RevCar3_fatigue_r
			C_LONGINT:C283(v_37_003_L)  //NoTracksOn
			ARRAY LONGINT:C221(v_37_003_aL; 0)  //NoTracksOn
			C_LONGINT:C283(v_37_007_L)  //NoTracksUnder
			ARRAY LONGINT:C221(v_37_007_aL; 0)  //NoTracksUnder
			C_DATE:C307(v_37_016_d)  //RatingDate
			ARRAY DATE:C224(v_37_016_ad; 0)  //RatingDate
			C_DATE:C307(v_37_018_d)  //Created_Date_d
			ARRAY DATE:C224(v_37_018_ad; 0)  //Created_Date_d
			C_DATE:C307(v_37_021_d)  //Modified_Date_d
			ARRAY DATE:C224(v_37_021_ad; 0)  //Modified_Date_d
			C_TIME:C306(v_37_019_tm)  //Created_Time_t
			ARRAY TIME:C1223(v_37_019_atm; 0)  //Created_Time_t
			C_TIME:C306(v_37_022_tm)  //Modified_Time_t
			ARRAY TIME:C1223(v_37_022_atm; 0)  //Modified_Time_t
		: ($1=38)  //Foundation Type
			C_TEXT:C284(v_38_003_txt)  //Foundation_Type_UUIDKey_s
			ARRAY TEXT:C222(v_38_003_atxt; 0)  //Foundation_Type_UUIDKey_s
			C_TEXT:C284(v_38_001_txt)  //Code
			ARRAY TEXT:C222(v_38_001_atxt; 0)  //Code
			C_TEXT:C284(v_38_002_txt)  //Description
			ARRAY TEXT:C222(v_38_002_atxt; 0)  //Description
		: ($1=39)  //Bed Material
			C_TEXT:C284(v_39_003_txt)  //Bed_Material_UUIDKey_s
			ARRAY TEXT:C222(v_39_003_atxt; 0)  //Bed_Material_UUIDKey_s
			C_TEXT:C284(v_39_001_txt)  //Code
			ARRAY TEXT:C222(v_39_001_atxt; 0)  //Code
			C_TEXT:C284(v_39_002_txt)  //Description
			ARRAY TEXT:C222(v_39_002_atxt; 0)  //Description
		: ($1=40)  //Pontis_Metric_Data
			C_TEXT:C284(v_40_011_txt)  //Pontis_Metric_Data_UUIDKey_s
			ARRAY TEXT:C222(v_40_011_atxt; 0)  //Pontis_Metric_Data_UUIDKey_s
			C_TEXT:C284(v_40_001_txt)  //PM_UNiqueKey_s
			ARRAY TEXT:C222(v_40_001_atxt; 0)  //PM_UNiqueKey_s
			C_REAL:C285(v_40_003_r)  //PMD_Hindex_r
			ARRAY REAL:C219(v_40_003_ar; 0)  //PMD_Hindex_r
			C_REAL:C285(v_40_005_r)  //PMD_PTIndex_r
			ARRAY REAL:C219(v_40_005_ar; 0)  //PMD_PTIndex_r
			C_REAL:C285(v_40_006_r)  //PMD_CIX_Supr_r
			ARRAY REAL:C219(v_40_006_ar; 0)  //PMD_CIX_Supr_r
			C_REAL:C285(v_40_007_r)  //PMD_CIX_Sub_r
			ARRAY REAL:C219(v_40_007_ar; 0)  //PMD_CIX_Sub_r
			C_REAL:C285(v_40_008_r)  //PMD_CIX_Joint_r
			ARRAY REAL:C219(v_40_008_ar; 0)  //PMD_CIX_Joint_r
			C_REAL:C285(v_40_009_r)  //PMD_CIX_Bear_r
			ARRAY REAL:C219(v_40_009_ar; 0)  //PMD_CIX_Bear_r
			C_REAL:C285(v_40_010_r)  //PMD_CIX_Deck_r
			ARRAY REAL:C219(v_40_010_ar; 0)  //PMD_CIX_Deck_r
			C_LONGINT:C283(v_40_002_L)  //PMD_YKey_l
			ARRAY LONGINT:C221(v_40_002_aL; 0)  //PMD_YKey_l
			C_LONGINT:C283(v_40_004_L)  //PMD_ADT_l
			ARRAY LONGINT:C221(v_40_004_aL; 0)  //PMD_ADT_l
		: ($1=41)  //Pontis_Metrics
			C_TEXT:C284(v_41_007_txt)  //Pontis_Metrics_UUIDKey_s
			ARRAY TEXT:C222(v_41_007_atxt; 0)  //Pontis_Metrics_UUIDKey_s
			C_TEXT:C284(v_41_002_txt)  //PM_UniqueKey_s
			ARRAY TEXT:C222(v_41_002_atxt; 0)  //PM_UniqueKey_s
			C_TEXT:C284(v_41_003_txt)  //PM_Bin_s
			ARRAY TEXT:C222(v_41_003_atxt; 0)  //PM_Bin_s
			C_TEXT:C284(v_41_005_txt)  //PM_SCKey_s
			ARRAY TEXT:C222(v_41_005_atxt; 0)  //PM_SCKey_s
			C_REAL:C285(v_41_006_r)  //PM_Tev_r
			ARRAY REAL:C219(v_41_006_ar; 0)  //PM_Tev_r
			C_LONGINT:C283(v_41_001_L)  //PM_RunKey_l
			ARRAY LONGINT:C221(v_41_001_aL; 0)  //PM_RunKey_l
			C_DATE:C307(v_41_004_d)  //PM_ImportDate_d
			ARRAY DATE:C224(v_41_004_ad; 0)  //PM_ImportDate_d
		: ($1=42)  //Personnel
			C_TEXT:C284(v_42_019_txt)  //Personnel_UUIDKey_s
			ARRAY TEXT:C222(v_42_019_atxt; 0)  //Personnel_UUIDKey_s
			C_TEXT:C284(v_42_002_txt)  //Prefix
			ARRAY TEXT:C222(v_42_002_atxt; 0)  //Prefix
			C_TEXT:C284(v_42_003_txt)  //First Name
			ARRAY TEXT:C222(v_42_003_atxt; 0)  //First Name
			C_TEXT:C284(v_42_004_txt)  //Middle Name
			ARRAY TEXT:C222(v_42_004_atxt; 0)  //Middle Name
			C_TEXT:C284(v_42_005_txt)  //Last Name
			ARRAY TEXT:C222(v_42_005_atxt; 0)  //Last Name
			C_TEXT:C284(v_42_006_txt)  //Suffix
			ARRAY TEXT:C222(v_42_006_atxt; 0)  //Suffix
			C_TEXT:C284(v_42_007_txt)  //Division No
			ARRAY TEXT:C222(v_42_007_atxt; 0)  //Division No
			C_TEXT:C284(v_42_009_txt)  //Employer
			ARRAY TEXT:C222(v_42_009_atxt; 0)  //Employer
			C_TEXT:C284(v_42_013_txt)  //Phone_s
			ARRAY TEXT:C222(v_42_013_atxt; 0)  //Phone_s
			C_TEXT:C284(v_42_014_txt)  //EmailAddress_s
			ARRAY TEXT:C222(v_42_014_atxt; 0)  //EmailAddress_s
			C_TEXT:C284(v_42_015_txt)  //CellPhone_s
			ARRAY TEXT:C222(v_42_015_atxt; 0)  //CellPhone_s
			C_TEXT:C284(v_42_016_txt)  //PagerNo_s
			ARRAY TEXT:C222(v_42_016_atxt; 0)  //PagerNo_s
			C_TEXT:C284(v_42_017_txt)  //HomePhone_s
			ARRAY TEXT:C222(v_42_017_atxt; 0)  //HomePhone_s
			C_TEXT:C284(v_42_018_txt)  //MachineName_txt
			ARRAY TEXT:C222(v_42_018_atxt; 0)  //MachineName_txt
			C_LONGINT:C283(v_42_001_L)  //Person ID
			ARRAY INTEGER:C220(v_42_001_ai; 0)  //Person ID
			C_LONGINT:C283(v_42_008_L)  //Job Code
			ARRAY INTEGER:C220(v_42_008_ai; 0)  //Job Code
			C_LONGINT:C283(v_42_012_L)  //UserID_4D
			ARRAY LONGINT:C221(v_42_012_aL; 0)  //UserID_4D
			C_BOOLEAN:C305(v_42_010_b)  //DiveTeam
			ARRAY BOOLEAN:C223(v_42_010_ab; 0)  //DiveTeam
			C_BOOLEAN:C305(v_42_011_b)  //Active
			ARRAY BOOLEAN:C223(v_42_011_ab; 0)  //Active
		: ($1=43)  //Field Trip
			C_TEXT:C284(v_43_003_txt)  //Field_Trip_UUIDKey_s
			ARRAY TEXT:C222(v_43_003_atxt; 0)  //Field_Trip_UUIDKey_s
			C_LONGINT:C283(v_43_002_L)  //Person ID
			ARRAY INTEGER:C220(v_43_002_ai; 0)  //Person ID
			C_LONGINT:C283(v_43_001_L)  //InspID
			ARRAY LONGINT:C221(v_43_001_aL; 0)  //InspID
		: ($1=44)  //BMS Inspections
			C_TEXT:C284(v_44_018_txt)  //BMS_Inspections_UUIDKey_s
			ARRAY TEXT:C222(v_44_018_atxt; 0)  //BMS_Inspections_UUIDKey_s
			C_TEXT:C284(v_44_002_txt)  //BIN
			ARRAY TEXT:C222(v_44_002_atxt; 0)  //BIN
			C_TEXT:C284(v_44_007_txt)  //Modified By
			ARRAY TEXT:C222(v_44_007_atxt; 0)  //Modified By
			C_TEXT:C284(v_44_013_txt)  //Agency
			ARRAY TEXT:C222(v_44_013_atxt; 0)  //Agency
			C_REAL:C285(v_44_015_r)  //INSP_HI
			ARRAY REAL:C219(v_44_015_ar; 0)  //INSP_HI
			C_REAL:C285(v_44_016_r)  //INSP_TotV
			ARRAY REAL:C219(v_44_016_ar; 0)  //INSP_TotV
			C_REAL:C285(v_44_017_r)  //INSP_CurrV
			ARRAY REAL:C219(v_44_017_ar; 0)  //INSP_CurrV
			C_LONGINT:C283(v_44_003_L)  //Span Group No
			ARRAY INTEGER:C220(v_44_003_ai; 0)  //Span Group No
			C_LONGINT:C283(v_44_005_L)  //DBrInspEngr
			ARRAY INTEGER:C220(v_44_005_ai; 0)  //DBrInspEngr
			C_LONGINT:C283(v_44_006_L)  //TeamLeader
			ARRAY INTEGER:C220(v_44_006_ai; 0)  //TeamLeader
			C_LONGINT:C283(v_44_012_L)  //ImportErrorCode
			ARRAY INTEGER:C220(v_44_012_ai; 0)  //ImportErrorCode
			C_LONGINT:C283(v_44_001_L)  //Inspection ID
			ARRAY LONGINT:C221(v_44_001_aL; 0)  //Inspection ID
			C_DATE:C307(v_44_004_d)  //Insp Date
			ARRAY DATE:C224(v_44_004_ad; 0)  //Insp Date
			C_DATE:C307(v_44_008_d)  //DateCreated
			ARRAY DATE:C224(v_44_008_ad; 0)  //DateCreated
			C_DATE:C307(v_44_010_d)  //DateModified
			ARRAY DATE:C224(v_44_010_ad; 0)  //DateModified
			C_TIME:C306(v_44_009_tm)  //TimeCreated
			ARRAY TIME:C1223(v_44_009_atm; 0)  //TimeCreated
			C_TIME:C306(v_44_011_tm)  //TimeModified
			ARRAY TIME:C1223(v_44_011_atm; 0)  //TimeModified
			C_BOOLEAN:C305(v_44_014_b)  //Metric
			ARRAY BOOLEAN:C223(v_44_014_ab; 0)  //Metric
		: ($1=45)  //Cond Units
			C_TEXT:C284(v_45_017_txt)  //Cond_Units_UUIDKey_s
			ARRAY TEXT:C222(v_45_017_atxt; 0)  //Cond_Units_UUIDKey_s
			C_TEXT:C284(v_45_007_txt)  //Comment
			ARRAY TEXT:C222(v_45_007_atxt; 0)  //Comment
			C_REAL:C285(v_45_005_r)  //Total Quantity
			ARRAY REAL:C219(v_45_005_ar; 0)  //Total Quantity
			C_REAL:C285(v_45_010_r)  //CondState1
			ARRAY REAL:C219(v_45_010_ar; 0)  //CondState1
			C_REAL:C285(v_45_011_r)  //CondState2
			ARRAY REAL:C219(v_45_011_ar; 0)  //CondState2
			C_REAL:C285(v_45_012_r)  //CondState3
			ARRAY REAL:C219(v_45_012_ar; 0)  //CondState3
			C_REAL:C285(v_45_013_r)  //CondState4
			ARRAY REAL:C219(v_45_013_ar; 0)  //CondState4
			C_REAL:C285(v_45_014_r)  //CondState5
			ARRAY REAL:C219(v_45_014_ar; 0)  //CondState5
			C_REAL:C285(v_45_016_r)  //ScaleFactor
			ARRAY REAL:C219(v_45_016_ar; 0)  //ScaleFactor
			C_LONGINT:C283(v_45_003_L)  //Element ID
			ARRAY INTEGER:C220(v_45_003_ai; 0)  //Element ID
			C_LONGINT:C283(v_45_004_L)  //Environment
			ARRAY INTEGER:C220(v_45_004_ai; 0)  //Environment
			C_LONGINT:C283(v_45_008_L)  //ImportErrorCode
			ARRAY INTEGER:C220(v_45_008_ai; 0)  //ImportErrorCode
			C_LONGINT:C283(v_45_001_L)  //Cond Unit ID
			ARRAY LONGINT:C221(v_45_001_aL; 0)  //Cond Unit ID
			C_LONGINT:C283(v_45_002_L)  //Inspection ID
			ARRAY LONGINT:C221(v_45_002_aL; 0)  //Inspection ID
			C_DATE:C307(v_45_015_d)  //DateModified_d
			ARRAY DATE:C224(v_45_015_ad; 0)  //DateModified_d
			C_BOOLEAN:C305(v_45_006_b)  //Percent
			ARRAY BOOLEAN:C223(v_45_006_ab; 0)  //Percent
			C_BOOLEAN:C305(v_45_009_b)  //Metric
			ARRAY BOOLEAN:C223(v_45_009_ab; 0)  //Metric
		: ($1=46)  //Cond State Insp
			C_TEXT:C284(v_46_006_txt)  //Cond_State_Insp_UUIDKey_s
			ARRAY TEXT:C222(v_46_006_atxt; 0)  //Cond_State_Insp_UUIDKey_s
			C_REAL:C285(v_46_004_r)  //Amount
			ARRAY REAL:C219(v_46_004_ar; 0)  //Amount
			C_LONGINT:C283(v_46_003_L)  //Cond State No
			ARRAY INTEGER:C220(v_46_003_ai; 0)  //Cond State No
			C_LONGINT:C283(v_46_002_L)  //Cond Unit ID
			ARRAY LONGINT:C221(v_46_002_aL; 0)  //Cond Unit ID
			C_BOOLEAN:C305(v_46_001_b)  //New
			ARRAY BOOLEAN:C223(v_46_001_ab; 0)  //New
			C_BOOLEAN:C305(v_46_005_b)  //future use
			ARRAY BOOLEAN:C223(v_46_005_ab; 0)  //future use
		: ($1=47)  //BMS Elements
			C_TEXT:C284(v_47_010_txt)  //BMS_Elements_UUIDKey_s
			ARRAY TEXT:C222(v_47_010_atxt; 0)  //BMS_Elements_UUIDKey_s
			C_TEXT:C284(v_47_003_txt)  //Element Name
			ARRAY TEXT:C222(v_47_003_atxt; 0)  //Element Name
			C_TEXT:C284(v_47_004_txt)  //Element Type
			ARRAY TEXT:C222(v_47_004_atxt; 0)  //Element Type
			C_TEXT:C284(v_47_005_txt)  //Elem Descript
			ARRAY TEXT:C222(v_47_005_atxt; 0)  //Elem Descript
			C_TEXT:C284(v_47_006_txt)  //Units
			ARRAY TEXT:C222(v_47_006_atxt; 0)  //Units
			C_LONGINT:C283(v_47_001_L)  //Element ID
			ARRAY INTEGER:C220(v_47_001_ai; 0)  //Element ID
			C_LONGINT:C283(v_47_002_L)  //Element No
			ARRAY INTEGER:C220(v_47_002_ai; 0)  //Element No
			C_LONGINT:C283(v_47_007_L)  //Common Note ID
			ARRAY INTEGER:C220(v_47_007_ai; 0)  //Common Note ID
			C_LONGINT:C283(v_47_008_L)  //Category ID
			ARRAY INTEGER:C220(v_47_008_ai; 0)  //Category ID
			C_BOOLEAN:C305(v_47_009_b)  //future use
			ARRAY BOOLEAN:C223(v_47_009_ab; 0)  //future use
		: ($1=48)  //Environments
			C_TEXT:C284(v_48_004_txt)  //Environments_UUIDKey_s
			ARRAY TEXT:C222(v_48_004_atxt; 0)  //Environments_UUIDKey_s
			C_TEXT:C284(v_48_002_txt)  //Envir Name
			ARRAY TEXT:C222(v_48_002_atxt; 0)  //Envir Name
			C_TEXT:C284(v_48_003_txt)  //Envir Descr
			ARRAY TEXT:C222(v_48_003_atxt; 0)  //Envir Descr
			C_LONGINT:C283(v_48_001_L)  //Envir No
			ARRAY INTEGER:C220(v_48_001_ai; 0)  //Envir No
		: ($1=49)  //BMS Categories
			C_TEXT:C284(v_49_008_txt)  //BMS_Categories_UUIDKey_s
			ARRAY TEXT:C222(v_49_008_atxt; 0)  //BMS_Categories_UUIDKey_s
			C_TEXT:C284(v_49_002_txt)  //General Cat
			ARRAY TEXT:C222(v_49_002_atxt; 0)  //General Cat
			C_TEXT:C284(v_49_003_txt)  //Subcategory
			ARRAY TEXT:C222(v_49_003_atxt; 0)  //Subcategory
			C_TEXT:C284(v_49_004_txt)  //Cat Note
			ARRAY TEXT:C222(v_49_004_atxt; 0)  //Cat Note
			C_LONGINT:C283(v_49_001_L)  //Category ID
			ARRAY INTEGER:C220(v_49_001_ai; 0)  //Category ID
			C_LONGINT:C283(v_49_007_L)  //Num of CSs
			ARRAY INTEGER:C220(v_49_007_ai; 0)  //Num of CSs
			C_BOOLEAN:C305(v_49_005_b)  //Smart Flag
			ARRAY BOOLEAN:C223(v_49_005_ab; 0)  //Smart Flag
			C_BOOLEAN:C305(v_49_006_b)  //Record as Each
			ARRAY BOOLEAN:C223(v_49_006_ab; 0)  //Record as Each
		: ($1=50)  //Element Costs
			C_TEXT:C284(v_50_006_txt)  //Element_Costs_UUIDKey_s
			ARRAY TEXT:C222(v_50_006_atxt; 0)  //Element_Costs_UUIDKey_s
			C_TEXT:C284(v_50_002_txt)  //Cond State No
			ARRAY TEXT:C222(v_50_002_atxt; 0)  //Cond State No
			C_TEXT:C284(v_50_003_txt)  //Action No
			ARRAY TEXT:C222(v_50_003_atxt; 0)  //Action No
			C_REAL:C285(v_50_004_r)  //Cost
			ARRAY REAL:C219(v_50_004_ar; 0)  //Cost
			C_LONGINT:C283(v_50_001_L)  //Element ID
			ARRAY INTEGER:C220(v_50_001_ai; 0)  //Element ID
			C_LONGINT:C283(v_50_005_L)  //Environment
			ARRAY INTEGER:C220(v_50_005_ai; 0)  //Environment
		: ($1=51)  //Cond States
			C_TEXT:C284(v_51_007_txt)  //Cond_States_UUIDKey_s
			ARRAY TEXT:C222(v_51_007_atxt; 0)  //Cond_States_UUIDKey_s
			C_TEXT:C284(v_51_003_txt)  //Cond State No
			ARRAY TEXT:C222(v_51_003_atxt; 0)  //Cond State No
			C_TEXT:C284(v_51_004_txt)  //Cond State Desc
			ARRAY TEXT:C222(v_51_004_atxt; 0)  //Cond State Desc
			C_TEXT:C284(v_51_005_txt)  //CS Short Desc
			ARRAY TEXT:C222(v_51_005_atxt; 0)  //CS Short Desc
			C_LONGINT:C283(v_51_001_L)  //Cond State ID
			ARRAY INTEGER:C220(v_51_001_ai; 0)  //Cond State ID
			C_LONGINT:C283(v_51_002_L)  //Category ID
			ARRAY INTEGER:C220(v_51_002_ai; 0)  //Category ID
			C_LONGINT:C283(v_51_006_L)  //Num of Actions
			ARRAY INTEGER:C220(v_51_006_ai; 0)  //Num of Actions
		: ($1=52)  //CS Actions
			C_TEXT:C284(v_52_005_txt)  //CS_Actions_UUIDKey_s
			ARRAY TEXT:C222(v_52_005_atxt; 0)  //CS_Actions_UUIDKey_s
			C_TEXT:C284(v_52_002_txt)  //Action No
			ARRAY TEXT:C222(v_52_002_atxt; 0)  //Action No
			C_TEXT:C284(v_52_003_txt)  //Action Descript
			ARRAY TEXT:C222(v_52_003_atxt; 0)  //Action Descript
			C_TEXT:C284(v_52_004_txt)  //Act Short Desc
			ARRAY TEXT:C222(v_52_004_atxt; 0)  //Act Short Desc
			C_LONGINT:C283(v_52_001_L)  //Cond State ID
			ARRAY INTEGER:C220(v_52_001_ai; 0)  //Cond State ID
		: ($1=53)  //CS Notes
			C_TEXT:C284(v_53_003_txt)  //CS_Notes_UUIDKey_s
			ARRAY TEXT:C222(v_53_003_atxt; 0)  //CS_Notes_UUIDKey_s
			C_TEXT:C284(v_53_002_txt)  //CS Note
			ARRAY TEXT:C222(v_53_002_atxt; 0)  //CS Note
			C_LONGINT:C283(v_53_001_L)  //CS Note ID
			ARRAY INTEGER:C220(v_53_001_ai; 0)  //CS Note ID
		: ($1=54)  //Common Notes
			C_TEXT:C284(v_54_003_txt)  //Common_Notes_UUIDKey_s
			ARRAY TEXT:C222(v_54_003_atxt; 0)  //Common_Notes_UUIDKey_s
			C_TEXT:C284(v_54_002_txt)  //Common Note
			ARRAY TEXT:C222(v_54_002_atxt; 0)  //Common Note
			C_LONGINT:C283(v_54_001_L)  //Common Note ID
			ARRAY INTEGER:C220(v_54_001_ai; 0)  //Common Note ID
		: ($1=55)  //Cat CS Notes
			C_TEXT:C284(v_55_003_txt)  //Cat_CS_Notes_UUIDKey_s
			ARRAY TEXT:C222(v_55_003_atxt; 0)  //Cat_CS_Notes_UUIDKey_s
			C_LONGINT:C283(v_55_001_L)  //Category ID
			ARRAY INTEGER:C220(v_55_001_ai; 0)  //Category ID
			C_LONGINT:C283(v_55_002_L)  //CS Note ID
			ARRAY INTEGER:C220(v_55_002_ai; 0)  //CS Note ID
		: ($1=56)  //BMS Field Trip
			C_TEXT:C284(v_56_003_txt)  //BMS_Field_Trip_UUIDKey_s
			ARRAY TEXT:C222(v_56_003_atxt; 0)  //BMS_Field_Trip_UUIDKey_s
			C_LONGINT:C283(v_56_002_L)  //Person ID
			ARRAY INTEGER:C220(v_56_002_ai; 0)  //Person ID
			C_LONGINT:C283(v_56_001_L)  //Inspection ID
			ARRAY LONGINT:C221(v_56_001_aL; 0)  //Inspection ID
		: ($1=57)  //Preferences
			C_TEXT:C284(v_57_019_txt)  //Preferences_UUIDKey_s
			ARRAY TEXT:C222(v_57_019_atxt; 0)  //Preferences_UUIDKey_s
			C_TEXT:C284(v_57_001_txt)  //Destination
			ARRAY TEXT:C222(v_57_001_atxt; 0)  //Destination
			C_TEXT:C284(v_57_003_txt)  //Forward
			ARRAY TEXT:C222(v_57_003_atxt; 0)  //Forward
			C_TEXT:C284(v_57_004_txt)  //DistrictInformation_s
			ARRAY TEXT:C222(v_57_004_atxt; 0)  //DistrictInformation_s
			C_TEXT:C284(v_57_009_txt)  //DestIP
			ARRAY TEXT:C222(v_57_009_atxt; 0)  //DestIP
			C_TEXT:C284(v_57_010_txt)  //ForwardIP
			ARRAY TEXT:C222(v_57_010_atxt; 0)  //ForwardIP
			C_TEXT:C284(v_57_012_txt)  //TxUserName
			ARRAY TEXT:C222(v_57_012_atxt; 0)  //TxUserName
			C_TEXT:C284(v_57_014_txt)  //DataFileKEY_s
			ARRAY TEXT:C222(v_57_014_atxt; 0)  //DataFileKEY_s
			C_TEXT:C284(v_57_015_txt)  //Pontis_Password_s
			ARRAY TEXT:C222(v_57_015_atxt; 0)  //Pontis_Password_s
			C_TEXT:C284(v_57_016_txt)  //Pontis_DatabaseName_txt
			ARRAY TEXT:C222(v_57_016_atxt; 0)  //Pontis_DatabaseName_txt
			C_TEXT:C284(v_57_017_txt)  //Pontis_ODBCName_txt
			ARRAY TEXT:C222(v_57_017_atxt; 0)  //Pontis_ODBCName_txt
			C_LONGINT:C283(v_57_002_L)  //Transfer Type
			ARRAY LONGINT:C221(v_57_002_aL; 0)  //Transfer Type
			C_LONGINT:C283(v_57_008_L)  //LastRefID_L
			ARRAY LONGINT:C221(v_57_008_aL; 0)  //LastRefID_L
			C_DATE:C307(v_57_007_d)  //dbDate
			ARRAY DATE:C224(v_57_007_ad; 0)  //dbDate
			C_DATE:C307(v_57_018_d)  //Pontis_LastUpdate_d
			ARRAY DATE:C224(v_57_018_ad; 0)  //Pontis_LastUpdate_d
			C_BOOLEAN:C305(v_57_005_b)  //ManualCon
			ARRAY BOOLEAN:C223(v_57_005_ab; 0)  //ManualCon
			C_BOOLEAN:C305(v_57_006_b)  //ShowPrintDialog
			ARRAY BOOLEAN:C223(v_57_006_ab; 0)  //ShowPrintDialog
			C_BOOLEAN:C305(v_57_011_b)  //LockUserTx
			ARRAY BOOLEAN:C223(v_57_011_ab; 0)  //LockUserTx
			C_BOOLEAN:C305(v_57_013_b)  //AllowTxRx
			ARRAY BOOLEAN:C223(v_57_013_ab; 0)  //AllowTxRx
		: ($1=58)  //Error Codes
			C_TEXT:C284(v_58_005_txt)  //Error_Codes_UUIDKey_s
			ARRAY TEXT:C222(v_58_005_atxt; 0)  //Error_Codes_UUIDKey_s
			C_TEXT:C284(v_58_001_txt)  //Err Group Name
			ARRAY TEXT:C222(v_58_001_atxt; 0)  //Err Group Name
			C_TEXT:C284(v_58_003_txt)  //Err Description
			ARRAY TEXT:C222(v_58_003_atxt; 0)  //Err Description
			C_TEXT:C284(v_58_004_txt)  //Err Level
			ARRAY TEXT:C222(v_58_004_atxt; 0)  //Err Level
			C_LONGINT:C283(v_58_002_L)  //Err Bit
			ARRAY INTEGER:C220(v_58_002_ai; 0)  //Err Bit
		: ($1=59)  //Activity Log
			C_BLOB:C604(v_59_010_blb)  //Data
			ARRAY BLOB:C1222(v_59_010_ablb; 0)  //Data
			C_BLOB:C604(v_59_027_blb)  //Old Data
			ARRAY BLOB:C1222(v_59_027_ablb; 0)  //Old Data
			C_TEXT:C284(v_59_029_txt)  //Activity_Log_UUIDKey_s
			ARRAY TEXT:C222(v_59_029_atxt; 0)  //Activity_Log_UUIDKey_s
			C_TEXT:C284(v_59_001_txt)  //Destination
			ARRAY TEXT:C222(v_59_001_atxt; 0)  //Destination
			C_TEXT:C284(v_59_002_txt)  //Source
			ARRAY TEXT:C222(v_59_002_atxt; 0)  //Source
			C_TEXT:C284(v_59_003_txt)  //Activity Type
			ARRAY TEXT:C222(v_59_003_atxt; 0)  //Activity Type
			C_TEXT:C284(v_59_004_txt)  //User Name
			ARRAY TEXT:C222(v_59_004_atxt; 0)  //User Name
			C_TEXT:C284(v_59_013_txt)  //Forward
			ARRAY TEXT:C222(v_59_013_atxt; 0)  //Forward
			C_TEXT:C284(v_59_014_txt)  //Parent ID
			ARRAY TEXT:C222(v_59_014_atxt; 0)  //Parent ID
			C_TEXT:C284(v_59_015_txt)  //Local ID
			ARRAY TEXT:C222(v_59_015_atxt; 0)  //Local ID
			C_TEXT:C284(v_59_016_txt)  //Dest ID parent
			ARRAY TEXT:C222(v_59_016_atxt; 0)  //Dest ID parent
			C_TEXT:C284(v_59_019_txt)  //Dest ID local
			ARRAY TEXT:C222(v_59_019_atxt; 0)  //Dest ID local
			C_TEXT:C284(v_59_020_txt)  //ActField Name
			ARRAY TEXT:C222(v_59_020_atxt; 0)  //ActField Name
			C_TEXT:C284(v_59_021_txt)  //FinalDestination
			ARRAY TEXT:C222(v_59_021_atxt; 0)  //FinalDestination
			C_LONGINT:C283(v_59_026_L)  //RefIDType
			ARRAY INTEGER:C220(v_59_026_ai; 0)  //RefIDType
			C_LONGINT:C283(v_59_007_L)  //File Number
			ARRAY LONGINT:C221(v_59_007_aL; 0)  //File Number
			C_LONGINT:C283(v_59_008_L)  //Field Number
			ARRAY LONGINT:C221(v_59_008_aL; 0)  //Field Number
			C_LONGINT:C283(v_59_009_L)  //Status
			ARRAY LONGINT:C221(v_59_009_aL; 0)  //Status
			C_LONGINT:C283(v_59_011_L)  //Data Type
			ARRAY LONGINT:C221(v_59_011_aL; 0)  //Data Type
			C_LONGINT:C283(v_59_012_L)  //Transfer
			ARRAY LONGINT:C221(v_59_012_aL; 0)  //Transfer
			C_LONGINT:C283(v_59_017_L)  //Type Parent
			ARRAY LONGINT:C221(v_59_017_aL; 0)  //Type Parent
			C_LONGINT:C283(v_59_018_L)  //Local Type
			ARRAY LONGINT:C221(v_59_018_aL; 0)  //Local Type
			C_LONGINT:C283(v_59_022_L)  //FileID Parent
			ARRAY LONGINT:C221(v_59_022_aL; 0)  //FileID Parent
			C_LONGINT:C283(v_59_023_L)  //FieldID Parent
			ARRAY LONGINT:C221(v_59_023_aL; 0)  //FieldID Parent
			C_LONGINT:C283(v_59_024_L)  //FileID Local
			ARRAY LONGINT:C221(v_59_024_aL; 0)  //FileID Local
			C_LONGINT:C283(v_59_025_L)  //FieldID Local
			ARRAY LONGINT:C221(v_59_025_aL; 0)  //FieldID Local
			C_LONGINT:C283(v_59_028_L)  //RefID
			ARRAY LONGINT:C221(v_59_028_aL; 0)  //RefID
			C_DATE:C307(v_59_005_d)  //dDate
			ARRAY DATE:C224(v_59_005_ad; 0)  //dDate
			C_TIME:C306(v_59_006_tm)  //tTime
			ARRAY TIME:C1223(v_59_006_atm; 0)  //tTime
		: ($1=60)  //FileIDRes Table
			C_TEXT:C284(v_60_005_txt)  //FileIDRes_Table_UUIDKey_s
			ARRAY TEXT:C222(v_60_005_atxt; 0)  //FileIDRes_Table_UUIDKey_s
			C_TEXT:C284(v_60_002_txt)  //Local ID
			ARRAY TEXT:C222(v_60_002_atxt; 0)  //Local ID
			C_TEXT:C284(v_60_003_txt)  //Destination ID
			ARRAY TEXT:C222(v_60_003_atxt; 0)  //Destination ID
			C_TEXT:C284(v_60_004_txt)  //Destination
			ARRAY TEXT:C222(v_60_004_atxt; 0)  //Destination
			C_LONGINT:C283(v_60_001_L)  //File Number
			ARRAY LONGINT:C221(v_60_001_aL; 0)  //File Number
		: ($1=61)  //PostingStatus
			C_TEXT:C284(v_61_003_txt)  //PostingStatus_UUIDKey_s
			ARRAY TEXT:C222(v_61_003_atxt; 0)  //PostingStatus_UUIDKey_s
			C_TEXT:C284(v_61_001_txt)  //Code
			ARRAY TEXT:C222(v_61_001_atxt; 0)  //Code
			C_TEXT:C284(v_61_002_txt)  //Description
			ARRAY TEXT:C222(v_61_002_atxt; 0)  //Description
		: ($1=62)  //Owners of Data
			C_TEXT:C284(v_62_003_txt)  //Owners_of_Data_UUIDKey_s
			ARRAY TEXT:C222(v_62_003_atxt; 0)  //Owners_of_Data_UUIDKey_s
			C_TEXT:C284(v_62_002_txt)  //Owner Name
			ARRAY TEXT:C222(v_62_002_atxt; 0)  //Owner Name
			C_LONGINT:C283(v_62_001_L)  //RefID
			ARRAY LONGINT:C221(v_62_001_aL; 0)  //RefID
		: ($1=63)  //Conslt Rating
			C_TEXT:C284(v_63_077_txt)  //Conslt_Rating_UUIDKey_s
			ARRAY TEXT:C222(v_63_077_atxt; 0)  //Conslt_Rating_UUIDKey_s
			C_TEXT:C284(v_63_001_txt)  //BIN
			ARRAY TEXT:C222(v_63_001_atxt; 0)  //BIN
			C_TEXT:C284(v_63_003_txt)  //PriorityColorFlag
			ARRAY TEXT:C222(v_63_003_atxt; 0)  //PriorityColorFlag
			C_TEXT:C284(v_63_005_txt)  //AssignRatCons
			ARRAY TEXT:C222(v_63_005_atxt; 0)  //AssignRatCons
			C_TEXT:C284(v_63_008_txt)  //ReviewRtgWho1
			ARRAY TEXT:C222(v_63_008_atxt; 0)  //ReviewRtgWho1
			C_TEXT:C284(v_63_013_txt)  //RemarksRat
			ARRAY TEXT:C222(v_63_013_atxt; 0)  //RemarksRat
			C_TEXT:C284(v_63_014_txt)  //ContractNoRat
			ARRAY TEXT:C222(v_63_014_atxt; 0)  //ContractNoRat
			C_TEXT:C284(v_63_016_txt)  //Disposition1
			ARRAY TEXT:C222(v_63_016_atxt; 0)  //Disposition1
			C_TEXT:C284(v_63_027_txt)  //ProjManager
			ARRAY TEXT:C222(v_63_027_atxt; 0)  //ProjManager
			C_TEXT:C284(v_63_039_txt)  //CRtgStatus
			ARRAY TEXT:C222(v_63_039_atxt; 0)  //CRtgStatus
			C_TEXT:C284(v_63_043_txt)  //AssignStatus
			ARRAY TEXT:C222(v_63_043_atxt; 0)  //AssignStatus
			C_TEXT:C284(v_63_044_txt)  //Priority
			ARRAY TEXT:C222(v_63_044_atxt; 0)  //Priority
			C_TEXT:C284(v_63_045_txt)  //CRtgLevel
			ARRAY TEXT:C222(v_63_045_atxt; 0)  //CRtgLevel
			C_TEXT:C284(v_63_046_txt)  //CRtgColor
			ARRAY TEXT:C222(v_63_046_atxt; 0)  //CRtgColor
			C_TEXT:C284(v_63_047_txt)  //CRtgSource
			ARRAY TEXT:C222(v_63_047_atxt; 0)  //CRtgSource
			C_TEXT:C284(v_63_048_txt)  //ContractType
			ARRAY TEXT:C222(v_63_048_atxt; 0)  //ContractType
			C_TEXT:C284(v_63_051_txt)  //AssignPhase
			ARRAY TEXT:C222(v_63_051_atxt; 0)  //AssignPhase
			C_TEXT:C284(v_63_054_txt)  //ReviewRtgWho2
			ARRAY TEXT:C222(v_63_054_atxt; 0)  //ReviewRtgWho2
			C_TEXT:C284(v_63_055_txt)  //ReviewRtgWho3
			ARRAY TEXT:C222(v_63_055_atxt; 0)  //ReviewRtgWho3
			C_TEXT:C284(v_63_056_txt)  //ReviewRtgWho4
			ARRAY TEXT:C222(v_63_056_atxt; 0)  //ReviewRtgWho4
			C_TEXT:C284(v_63_059_txt)  //Disposition2
			ARRAY TEXT:C222(v_63_059_atxt; 0)  //Disposition2
			C_TEXT:C284(v_63_060_txt)  //Disposition3
			ARRAY TEXT:C222(v_63_060_atxt; 0)  //Disposition3
			C_TEXT:C284(v_63_061_txt)  //Disposition4
			ARRAY TEXT:C222(v_63_061_atxt; 0)  //Disposition4
			C_TEXT:C284(v_63_063_txt)  //BridgeType
			ARRAY TEXT:C222(v_63_063_atxt; 0)  //BridgeType
			C_TEXT:C284(v_63_069_txt)  //ReportPreparedBy
			ARRAY TEXT:C222(v_63_069_atxt; 0)  //ReportPreparedBy
			C_TEXT:C284(v_63_070_txt)  //IsRtgHere
			ARRAY TEXT:C222(v_63_070_atxt; 0)  //IsRtgHere
			C_TEXT:C284(v_63_076_txt)  //NBISLetterPostStatus_s
			ARRAY TEXT:C222(v_63_076_atxt; 0)  //NBISLetterPostStatus_s
			C_REAL:C285(v_63_015_r)  //ConsltScore
			ARRAY REAL:C219(v_63_015_ar; 0)  //ConsltScore
			C_LONGINT:C283(v_63_012_L)  //AssignNoRat
			ARRAY INTEGER:C220(v_63_012_ai; 0)  //AssignNoRat
			C_LONGINT:C283(v_63_042_L)  //ConsltRatingID
			ARRAY LONGINT:C221(v_63_042_aL; 0)  //ConsltRatingID
			C_DATE:C307(v_63_002_d)  //FirstExpctSubmDate
			ARRAY DATE:C224(v_63_002_ad; 0)  //FirstExpctSubmDate
			C_DATE:C307(v_63_004_d)  //AssignRtgDate1
			ARRAY DATE:C224(v_63_004_ad; 0)  //AssignRtgDate1
			C_DATE:C307(v_63_006_d)  //AssignRtgDate2
			ARRAY DATE:C224(v_63_006_ad; 0)  //AssignRtgDate2
			C_DATE:C307(v_63_007_d)  //AssignRtgDate3
			ARRAY DATE:C224(v_63_007_ad; 0)  //AssignRtgDate3
			C_DATE:C307(v_63_009_d)  //ApprovedRat
			ARRAY DATE:C224(v_63_009_ad; 0)  //ApprovedRat
			C_DATE:C307(v_63_010_d)  //ProceedRat
			ARRAY DATE:C224(v_63_010_ad; 0)  //ProceedRat
			C_DATE:C307(v_63_011_d)  //AssignRtgDate4
			ARRAY DATE:C224(v_63_011_ad; 0)  //AssignRtgDate4
			C_DATE:C307(v_63_017_d)  //BoardApproval
			ARRAY DATE:C224(v_63_017_ad; 0)  //BoardApproval
			C_DATE:C307(v_63_018_d)  //CmntsRecvd1
			ARRAY DATE:C224(v_63_018_ad; 0)  //CmntsRecvd1
			C_DATE:C307(v_63_019_d)  //CmntsRecvd2
			ARRAY DATE:C224(v_63_019_ad; 0)  //CmntsRecvd2
			C_DATE:C307(v_63_020_d)  //DateReqbyBIE
			ARRAY DATE:C224(v_63_020_ad; 0)  //DateReqbyBIE
			C_DATE:C307(v_63_021_d)  //DateReqbyDistrictBIE
			ARRAY DATE:C224(v_63_021_ad; 0)  //DateReqbyDistrictBIE
			C_DATE:C307(v_63_022_d)  //FeeProposalRecvd
			ARRAY DATE:C224(v_63_022_ad; 0)  //FeeProposalRecvd
			C_DATE:C307(v_63_023_d)  //RepSubmit1
			ARRAY DATE:C224(v_63_023_ad; 0)  //RepSubmit1
			C_DATE:C307(v_63_024_d)  //ApprovedRtgToAreaEngr
			ARRAY DATE:C224(v_63_024_ad; 0)  //ApprovedRtgToAreaEngr
			C_DATE:C307(v_63_025_d)  //LetterToDistrict
			ARRAY DATE:C224(v_63_025_ad; 0)  //LetterToDistrict
			C_DATE:C307(v_63_026_d)  //NBISLetter
			ARRAY DATE:C224(v_63_026_ad; 0)  //NBISLetter
			C_DATE:C307(v_63_030_d)  //ReqFeeProposal
			ARRAY DATE:C224(v_63_030_ad; 0)  //ReqFeeProposal
			C_DATE:C307(v_63_031_d)  //RepSubmit2
			ARRAY DATE:C224(v_63_031_ad; 0)  //RepSubmit2
			C_DATE:C307(v_63_032_d)  //LetterToCityTown
			ARRAY DATE:C224(v_63_032_ad; 0)  //LetterToCityTown
			C_DATE:C307(v_63_033_d)  //SentBackToConslt1
			ARRAY DATE:C224(v_63_033_ad; 0)  //SentBackToConslt1
			C_DATE:C307(v_63_034_d)  //SentBackToConslt2
			ARRAY DATE:C224(v_63_034_ad; 0)  //SentBackToConslt2
			C_DATE:C307(v_63_035_d)  //SentBackToConslt3
			ARRAY DATE:C224(v_63_035_ad; 0)  //SentBackToConslt3
			C_DATE:C307(v_63_036_d)  //SentInHouseRev1
			ARRAY DATE:C224(v_63_036_ad; 0)  //SentInHouseRev1
			C_DATE:C307(v_63_037_d)  //SentInHouseRev2
			ARRAY DATE:C224(v_63_037_ad; 0)  //SentInHouseRev2
			C_DATE:C307(v_63_038_d)  //SentInHouseRev3
			ARRAY DATE:C224(v_63_038_ad; 0)  //SentInHouseRev3
			C_DATE:C307(v_63_041_d)  //RepSubmit3
			ARRAY DATE:C224(v_63_041_ad; 0)  //RepSubmit3
			C_DATE:C307(v_63_049_d)  //MostRecentSub
			ARRAY DATE:C224(v_63_049_ad; 0)  //MostRecentSub
			C_DATE:C307(v_63_050_d)  //NTPdate_verbal
			ARRAY DATE:C224(v_63_050_ad; 0)  //NTPdate_verbal
			C_DATE:C307(v_63_052_d)  //RepSubmit4
			ARRAY DATE:C224(v_63_052_ad; 0)  //RepSubmit4
			C_DATE:C307(v_63_053_d)  //SentInHouseRev4
			ARRAY DATE:C224(v_63_053_ad; 0)  //SentInHouseRev4
			C_DATE:C307(v_63_057_d)  //CmntsRecvd3
			ARRAY DATE:C224(v_63_057_ad; 0)  //CmntsRecvd3
			C_DATE:C307(v_63_058_d)  //CmntsRecvd4
			ARRAY DATE:C224(v_63_058_ad; 0)  //CmntsRecvd4
			C_DATE:C307(v_63_062_d)  //SentBackToConslt4
			ARRAY DATE:C224(v_63_062_ad; 0)  //SentBackToConslt4
			C_DATE:C307(v_63_064_d)  //ReportDate
			ARRAY DATE:C224(v_63_064_ad; 0)  //ReportDate
			C_DATE:C307(v_63_065_d)  //SentBackToBIE1
			ARRAY DATE:C224(v_63_065_ad; 0)  //SentBackToBIE1
			C_DATE:C307(v_63_066_d)  //SentBackToBIE2
			ARRAY DATE:C224(v_63_066_ad; 0)  //SentBackToBIE2
			C_DATE:C307(v_63_067_d)  //SentBackToBIE3
			ARRAY DATE:C224(v_63_067_ad; 0)  //SentBackToBIE3
			C_DATE:C307(v_63_068_d)  //SentBackToBIE4
			ARRAY DATE:C224(v_63_068_ad; 0)  //SentBackToBIE4
			C_DATE:C307(v_63_071_d)  //RecentAction
			ARRAY DATE:C224(v_63_071_ad; 0)  //RecentAction
			C_DATE:C307(v_63_072_d)  //DateReceivedByROUnit1
			ARRAY DATE:C224(v_63_072_ad; 0)  //DateReceivedByROUnit1
			C_DATE:C307(v_63_073_d)  //DateReceivedByROUnit2
			ARRAY DATE:C224(v_63_073_ad; 0)  //DateReceivedByROUnit2
			C_DATE:C307(v_63_074_d)  //DateReceivedByROUnit3
			ARRAY DATE:C224(v_63_074_ad; 0)  //DateReceivedByROUnit3
			C_DATE:C307(v_63_075_d)  //DateReceivedByROUnit4
			ARRAY DATE:C224(v_63_075_ad; 0)  //DateReceivedByROUnit4
			C_BOOLEAN:C305(v_63_028_b)  //Rate
			ARRAY BOOLEAN:C223(v_63_028_ab; 0)  //Rate
			C_BOOLEAN:C305(v_63_029_b)  //Re_Rate
			ARRAY BOOLEAN:C223(v_63_029_ab; 0)  //Re_Rate
			C_BOOLEAN:C305(v_63_040_b)  //StrReport
			ARRAY BOOLEAN:C223(v_63_040_ab; 0)  //StrReport
		: ($1=64)  //Cons Inspection
			C_TEXT:C284(v_64_039_txt)  //Cons_Inspection_UUIDKey_s
			ARRAY TEXT:C222(v_64_039_atxt; 0)  //Cons_Inspection_UUIDKey_s
			C_TEXT:C284(v_64_001_txt)  //BIN
			ARRAY TEXT:C222(v_64_001_atxt; 0)  //BIN
			C_TEXT:C284(v_64_003_txt)  //RequestConWho
			ARRAY TEXT:C222(v_64_003_atxt; 0)  //RequestConWho
			C_TEXT:C284(v_64_005_txt)  //AssignConName
			ARRAY TEXT:C222(v_64_005_atxt; 0)  //AssignConName
			C_TEXT:C284(v_64_007_txt)  //ConContractNo
			ARRAY TEXT:C222(v_64_007_atxt; 0)  //ConContractNo
			C_TEXT:C284(v_64_010_txt)  //ConInspRemarks
			ARRAY TEXT:C222(v_64_010_atxt; 0)  //ConInspRemarks
			C_TEXT:C284(v_64_024_txt)  //AssignStatus
			ARRAY TEXT:C222(v_64_024_atxt; 0)  //AssignStatus
			C_TEXT:C284(v_64_026_txt)  //ProjManager
			ARRAY TEXT:C222(v_64_026_atxt; 0)  //ProjManager
			C_TEXT:C284(v_64_028_txt)  //InspectionDate
			ARRAY TEXT:C222(v_64_028_atxt; 0)  //InspectionDate
			C_TEXT:C284(v_64_033_txt)  //InspType
			ARRAY TEXT:C222(v_64_033_atxt; 0)  //InspType
			C_TEXT:C284(v_64_036_txt)  //ContractType
			ARRAY TEXT:C222(v_64_036_atxt; 0)  //ContractType
			C_TEXT:C284(v_64_038_txt)  //AssignPhase
			ARRAY TEXT:C222(v_64_038_atxt; 0)  //AssignPhase
			C_REAL:C285(v_64_013_r)  //QC Eng HR Est
			ARRAY REAL:C219(v_64_013_ar; 0)  //QC Eng HR Est
			C_REAL:C285(v_64_014_r)  //TeamLdr HR Est
			ARRAY REAL:C219(v_64_014_ar; 0)  //TeamLdr HR Est
			C_REAL:C285(v_64_015_r)  //TeamMbr HR Est
			ARRAY REAL:C219(v_64_015_ar; 0)  //TeamMbr HR Est
			C_REAL:C285(v_64_016_r)  //PE HR Act
			ARRAY REAL:C219(v_64_016_ar; 0)  //PE HR Act
			C_REAL:C285(v_64_017_r)  //QC Eng HR Act
			ARRAY REAL:C219(v_64_017_ar; 0)  //QC Eng HR Act
			C_REAL:C285(v_64_018_r)  //TeamLdr HR Act
			ARRAY REAL:C219(v_64_018_ar; 0)  //TeamLdr HR Act
			C_REAL:C285(v_64_019_r)  //TeamMbr HR Act
			ARRAY REAL:C219(v_64_019_ar; 0)  //TeamMbr HR Act
			C_REAL:C285(v_64_020_r)  //Direct Expenses
			ARRAY REAL:C219(v_64_020_ar; 0)  //Direct Expenses
			C_REAL:C285(v_64_021_r)  //AvgHourlyRate
			ARRAY REAL:C219(v_64_021_ar; 0)  //AvgHourlyRate
			C_REAL:C285(v_64_030_r)  //ConsltScore
			ARRAY REAL:C219(v_64_030_ar; 0)  //ConsltScore
			C_LONGINT:C283(v_64_006_L)  //AssignConNumber
			ARRAY INTEGER:C220(v_64_006_ai; 0)  //AssignConNumber
			C_LONGINT:C283(v_64_011_L)  //InspCategory
			ARRAY INTEGER:C220(v_64_011_ai; 0)  //InspCategory
			C_LONGINT:C283(v_64_032_L)  //ConsInspectionID
			ARRAY LONGINT:C221(v_64_032_aL; 0)  //ConsInspectionID
			C_DATE:C307(v_64_002_d)  //RequestConDate
			ARRAY DATE:C224(v_64_002_ad; 0)  //RequestConDate
			C_DATE:C307(v_64_004_d)  //AssignConDate
			ARRAY DATE:C224(v_64_004_ad; 0)  //AssignConDate
			C_DATE:C307(v_64_008_d)  //ProceedConDate
			ARRAY DATE:C224(v_64_008_ad; 0)  //ProceedConDate
			C_DATE:C307(v_64_009_d)  //CompleteConDate
			ARRAY DATE:C224(v_64_009_ad; 0)  //CompleteConDate
			C_DATE:C307(v_64_022_d)  //ReqByDBIE
			ARRAY DATE:C224(v_64_022_ad; 0)  //ReqByDBIE
			C_DATE:C307(v_64_023_d)  //ReqByBIE
			ARRAY DATE:C224(v_64_023_ad; 0)  //ReqByBIE
			C_DATE:C307(v_64_025_d)  //ReqFeeProposal
			ARRAY DATE:C224(v_64_025_ad; 0)  //ReqFeeProposal
			C_DATE:C307(v_64_027_d)  //FeeProposalRecvd
			ARRAY DATE:C224(v_64_027_ad; 0)  //FeeProposalRecvd
			C_DATE:C307(v_64_029_d)  //InspectionRecvd
			ARRAY DATE:C224(v_64_029_ad; 0)  //InspectionRecvd
			C_DATE:C307(v_64_031_d)  //ReportToDBIE
			ARRAY DATE:C224(v_64_031_ad; 0)  //ReportToDBIE
			C_DATE:C307(v_64_034_d)  //InspMonth
			ARRAY DATE:C224(v_64_034_ad; 0)  //InspMonth
			C_DATE:C307(v_64_035_d)  //NTPdate_verbal
			ARRAY DATE:C224(v_64_035_ad; 0)  //NTPdate_verbal
			C_DATE:C307(v_64_037_d)  //InspRecvd_ME
			ARRAY DATE:C224(v_64_037_ad; 0)  //InspRecvd_ME
			C_BOOLEAN:C305(v_64_012_b)  //LoadRatingInfo
			ARRAY BOOLEAN:C223(v_64_012_ab; 0)  //LoadRatingInfo
		: ($1=65)  //RatingReports
			C_TEXT:C284(v_65_035_txt)  //RatingReports_UUIDKey_s
			ARRAY TEXT:C222(v_65_035_atxt; 0)  //RatingReports_UUIDKey_s
			C_TEXT:C284(v_65_001_txt)  //BIN
			ARRAY TEXT:C222(v_65_001_atxt; 0)  //BIN
			C_TEXT:C284(v_65_005_txt)  //Consultant
			ARRAY TEXT:C222(v_65_005_atxt; 0)  //Consultant
			C_TEXT:C284(v_65_017_txt)  //Item43inRating
			ARRAY TEXT:C222(v_65_017_atxt; 0)  //Item43inRating
			C_TEXT:C284(v_65_018_txt)  //Item58
			ARRAY TEXT:C222(v_65_018_atxt; 0)  //Item58
			C_TEXT:C284(v_65_019_txt)  //Item59
			ARRAY TEXT:C222(v_65_019_atxt; 0)  //Item59
			C_TEXT:C284(v_65_020_txt)  //RatingInfo
			ARRAY TEXT:C222(v_65_020_atxt; 0)  //RatingInfo
			C_TEXT:C284(v_65_028_txt)  //Item63
			ARRAY TEXT:C222(v_65_028_atxt; 0)  //Item63
			C_TEXT:C284(v_65_030_txt)  //Item65
			ARRAY TEXT:C222(v_65_030_atxt; 0)  //Item65
			C_TEXT:C284(v_65_032_txt)  //DataFileType
			ARRAY TEXT:C222(v_65_032_atxt; 0)  //DataFileType
			C_REAL:C285(v_65_006_r)  //InvH20
			ARRAY REAL:C219(v_65_006_ar; 0)  //InvH20
			C_REAL:C285(v_65_007_r)  //InvType3
			ARRAY REAL:C219(v_65_007_ar; 0)  //InvType3
			C_REAL:C285(v_65_008_r)  //Inv3S2
			ARRAY REAL:C219(v_65_008_ar; 0)  //Inv3S2
			C_REAL:C285(v_65_009_r)  //InvHS2044
			ARRAY REAL:C219(v_65_009_ar; 0)  //InvHS2044
			C_REAL:C285(v_65_010_r)  //OprH20
			ARRAY REAL:C219(v_65_010_ar; 0)  //OprH20
			C_REAL:C285(v_65_011_r)  //OprType3
			ARRAY REAL:C219(v_65_011_ar; 0)  //OprType3
			C_REAL:C285(v_65_012_r)  //Opr3S2
			ARRAY REAL:C219(v_65_012_ar; 0)  //Opr3S2
			C_REAL:C285(v_65_013_r)  //OprHS2044
			ARRAY REAL:C219(v_65_013_ar; 0)  //OprHS2044
			C_REAL:C285(v_65_022_r)  //InvMS18
			ARRAY REAL:C219(v_65_022_ar; 0)  //InvMS18
			C_REAL:C285(v_65_023_r)  //OprMS18
			ARRAY REAL:C219(v_65_023_ar; 0)  //OprMS18
			C_REAL:C285(v_65_029_r)  //Item64
			ARRAY REAL:C219(v_65_029_ar; 0)  //Item64
			C_REAL:C285(v_65_031_r)  //Item66
			ARRAY REAL:C219(v_65_031_ar; 0)  //Item66
			C_LONGINT:C283(v_65_014_L)  //RecPostingH
			ARRAY INTEGER:C220(v_65_014_ai; 0)  //RecPostingH
			C_LONGINT:C283(v_65_015_L)  //RecPost3
			ARRAY INTEGER:C220(v_65_015_ai; 0)  //RecPost3
			C_LONGINT:C283(v_65_016_L)  //RecPost3S2
			ARRAY INTEGER:C220(v_65_016_ai; 0)  //RecPost3S2
			C_LONGINT:C283(v_65_021_L)  //RatingID
			ARRAY LONGINT:C221(v_65_021_aL; 0)  //RatingID
			C_LONGINT:C283(v_65_039_L)  //RecSinglePosting_L
			ARRAY LONGINT:C221(v_65_039_aL; 0)  //RecSinglePosting_L
			C_DATE:C307(v_65_004_d)  //ReportDate
			ARRAY DATE:C224(v_65_004_ad; 0)  //ReportDate
			C_DATE:C307(v_65_036_d)  //NBIS_Letter_d
			ARRAY DATE:C224(v_65_036_ad; 0)  //NBIS_Letter_d
			C_BOOLEAN:C305(v_65_002_b)  //RatingReport
			ARRAY BOOLEAN:C223(v_65_002_ab; 0)  //RatingReport
			C_BOOLEAN:C305(v_65_003_b)  //EngrJudgment
			ARRAY BOOLEAN:C223(v_65_003_ab; 0)  //EngrJudgment
			C_BOOLEAN:C305(v_65_024_b)  //NoPosting
			ARRAY BOOLEAN:C223(v_65_024_ab; 0)  //NoPosting
			C_BOOLEAN:C305(v_65_025_b)  //BridgeClosed
			ARRAY BOOLEAN:C223(v_65_025_ab; 0)  //BridgeClosed
			C_BOOLEAN:C305(v_65_026_b)  //PostingWaived
			ARRAY BOOLEAN:C223(v_65_026_ab; 0)  //PostingWaived
			C_BOOLEAN:C305(v_65_027_b)  //DataFile
			ARRAY BOOLEAN:C223(v_65_027_ab; 0)  //DataFile
			C_BOOLEAN:C305(v_65_033_b)  //StructRpt
			ARRAY BOOLEAN:C223(v_65_033_ab; 0)  //StructRpt
			C_BOOLEAN:C305(v_65_034_b)  //RemainPosted
			ARRAY BOOLEAN:C223(v_65_034_ab; 0)  //RemainPosted
			C_BOOLEAN:C305(v_65_037_b)  //WithRestrictions_b
			ARRAY BOOLEAN:C223(v_65_037_ab; 0)  //WithRestrictions_b
			C_BOOLEAN:C305(v_65_038_b)  //WithPedestrianAccess_b
			ARRAY BOOLEAN:C223(v_65_038_ab; 0)  //WithPedestrianAccess_b
			C_BOOLEAN:C305(v_65_040_b)  //ScannedStored
			ARRAY BOOLEAN:C223(v_65_040_ab; 0)  //ScannedStored
		: ($1=66)  //RatingMember
			C_TEXT:C284(v_66_018_txt)  //RatingMember_UUIDKey_s
			ARRAY TEXT:C222(v_66_018_atxt; 0)  //RatingMember_UUIDKey_s
			C_TEXT:C284(v_66_002_txt)  //SpanType
			ARRAY TEXT:C222(v_66_002_atxt; 0)  //SpanType
			C_TEXT:C284(v_66_003_txt)  //MemberType
			ARRAY TEXT:C222(v_66_003_atxt; 0)  //MemberType
			C_TEXT:C284(v_66_004_txt)  //Description
			ARRAY TEXT:C222(v_66_004_atxt; 0)  //Description
			C_REAL:C285(v_66_005_r)  //SpanLength
			ARRAY REAL:C219(v_66_005_ar; 0)  //SpanLength
			C_REAL:C285(v_66_006_r)  //LocationCM
			ARRAY REAL:C219(v_66_006_ar; 0)  //LocationCM
			C_REAL:C285(v_66_007_r)  //InvH20
			ARRAY REAL:C219(v_66_007_ar; 0)  //InvH20
			C_REAL:C285(v_66_008_r)  //InvType3
			ARRAY REAL:C219(v_66_008_ar; 0)  //InvType3
			C_REAL:C285(v_66_009_r)  //Inv3S2
			ARRAY REAL:C219(v_66_009_ar; 0)  //Inv3S2
			C_REAL:C285(v_66_010_r)  //InvHS2044
			ARRAY REAL:C219(v_66_010_ar; 0)  //InvHS2044
			C_REAL:C285(v_66_011_r)  //OprH20
			ARRAY REAL:C219(v_66_011_ar; 0)  //OprH20
			C_REAL:C285(v_66_012_r)  //OprType3
			ARRAY REAL:C219(v_66_012_ar; 0)  //OprType3
			C_REAL:C285(v_66_013_r)  //Opr3S2
			ARRAY REAL:C219(v_66_013_ar; 0)  //Opr3S2
			C_REAL:C285(v_66_014_r)  //OprHS2044
			ARRAY REAL:C219(v_66_014_ar; 0)  //OprHS2044
			C_REAL:C285(v_66_015_r)  //FloorBeamSp
			ARRAY REAL:C219(v_66_015_ar; 0)  //FloorBeamSp
			C_REAL:C285(v_66_016_r)  //InvMS18
			ARRAY REAL:C219(v_66_016_ar; 0)  //InvMS18
			C_REAL:C285(v_66_017_r)  //OprMS18
			ARRAY REAL:C219(v_66_017_ar; 0)  //OprMS18
			C_LONGINT:C283(v_66_001_L)  //RatingID
			ARRAY LONGINT:C221(v_66_001_aL; 0)  //RatingID
		: ($1=67)  //Rating Method
			C_TEXT:C284(v_67_003_txt)  //Rating_Method_UUIDKey_s
			ARRAY TEXT:C222(v_67_003_atxt; 0)  //Rating_Method_UUIDKey_s
			C_TEXT:C284(v_67_001_txt)  //Code
			ARRAY TEXT:C222(v_67_001_atxt; 0)  //Code
			C_TEXT:C284(v_67_002_txt)  //Description
			ARRAY TEXT:C222(v_67_002_atxt; 0)  //Description
		: ($1=68)  //zDialogs
			C_TEXT:C284(v_68_002_txt)  //zDialogs_UUIDKey_s
			ARRAY TEXT:C222(v_68_002_atxt; 0)  //zDialogs_UUIDKey_s
			C_BOOLEAN:C305(v_68_001_b)  //Reserved
			ARRAY BOOLEAN:C223(v_68_001_ab; 0)  //Reserved
		: ($1=69)  //Status Report
			C_TEXT:C284(v_69_264_txt)  //Status_Report_UUIDKey_s
			ARRAY TEXT:C222(v_69_264_atxt; 0)  //Status_Report_UUIDKey_s
			C_TEXT:C284(v_69_002_txt)  //Owner
			ARRAY TEXT:C222(v_69_002_atxt; 0)  //Owner
			C_TEXT:C284(v_69_135_txt)  //Comments
			ARRAY TEXT:C222(v_69_135_atxt; 0)  //Comments
			C_REAL:C285(v_69_122_r)  //S_58
			ARRAY REAL:C219(v_69_122_ar; 0)  //S_58
			C_REAL:C285(v_69_123_r)  //S_59
			ARRAY REAL:C219(v_69_123_ar; 0)  //S_59
			C_REAL:C285(v_69_124_r)  //S_60
			ARRAY REAL:C219(v_69_124_ar; 0)  //S_60
			C_REAL:C285(v_69_125_r)  //T_58
			ARRAY REAL:C219(v_69_125_ar; 0)  //T_58
			C_REAL:C285(v_69_126_r)  //T_59
			ARRAY REAL:C219(v_69_126_ar; 0)  //T_59
			C_REAL:C285(v_69_127_r)  //T_60
			ARRAY REAL:C219(v_69_127_ar; 0)  //T_60
			C_REAL:C285(v_69_128_r)  //ST_58
			ARRAY REAL:C219(v_69_128_ar; 0)  //ST_58
			C_REAL:C285(v_69_129_r)  //ST_59
			ARRAY REAL:C219(v_69_129_ar; 0)  //ST_59
			C_REAL:C285(v_69_130_r)  //ST_60
			ARRAY REAL:C219(v_69_130_ar; 0)  //ST_60
			C_REAL:C285(v_69_131_r)  //A_58
			ARRAY REAL:C219(v_69_131_ar; 0)  //A_58
			C_REAL:C285(v_69_132_r)  //A_59
			ARRAY REAL:C219(v_69_132_ar; 0)  //A_59
			C_REAL:C285(v_69_133_r)  //A_60
			ARRAY REAL:C219(v_69_133_ar; 0)  //A_60
			C_REAL:C285(v_69_136_r)  //S_D1_HI
			ARRAY REAL:C219(v_69_136_ar; 0)  //S_D1_HI
			C_REAL:C285(v_69_137_r)  //S_D2_HI
			ARRAY REAL:C219(v_69_137_ar; 0)  //S_D2_HI
			C_REAL:C285(v_69_138_r)  //S_D3_HI
			ARRAY REAL:C219(v_69_138_ar; 0)  //S_D3_HI
			C_REAL:C285(v_69_139_r)  //S_D4_HI
			ARRAY REAL:C219(v_69_139_ar; 0)  //S_D4_HI
			C_REAL:C285(v_69_140_r)  //S_D5_HI
			ARRAY REAL:C219(v_69_140_ar; 0)  //S_D5_HI
			C_REAL:C285(v_69_141_r)  //S_Tot_HI
			ARRAY REAL:C219(v_69_141_ar; 0)  //S_Tot_HI
			C_REAL:C285(v_69_142_r)  //T_D1_HI
			ARRAY REAL:C219(v_69_142_ar; 0)  //T_D1_HI
			C_REAL:C285(v_69_143_r)  //T_D2_HI
			ARRAY REAL:C219(v_69_143_ar; 0)  //T_D2_HI
			C_REAL:C285(v_69_144_r)  //T_D3_HI
			ARRAY REAL:C219(v_69_144_ar; 0)  //T_D3_HI
			C_REAL:C285(v_69_145_r)  //T_D4_HI
			ARRAY REAL:C219(v_69_145_ar; 0)  //T_D4_HI
			C_REAL:C285(v_69_146_r)  //T_D5_HI
			ARRAY REAL:C219(v_69_146_ar; 0)  //T_D5_HI
			C_REAL:C285(v_69_147_r)  //T_Tot_HI
			ARRAY REAL:C219(v_69_147_ar; 0)  //T_Tot_HI
			C_REAL:C285(v_69_148_r)  //S_T_D1_HI
			ARRAY REAL:C219(v_69_148_ar; 0)  //S_T_D1_HI
			C_REAL:C285(v_69_149_r)  //S_T_D2_HI
			ARRAY REAL:C219(v_69_149_ar; 0)  //S_T_D2_HI
			C_REAL:C285(v_69_150_r)  //S_T_D3_HI
			ARRAY REAL:C219(v_69_150_ar; 0)  //S_T_D3_HI
			C_REAL:C285(v_69_151_r)  //S_T_D4_HI
			ARRAY REAL:C219(v_69_151_ar; 0)  //S_T_D4_HI
			C_REAL:C285(v_69_152_r)  //S_T_D5_HI
			ARRAY REAL:C219(v_69_152_ar; 0)  //S_T_D5_HI
			C_REAL:C285(v_69_153_r)  //S_T_Tot_HI
			ARRAY REAL:C219(v_69_153_ar; 0)  //S_T_Tot_HI
			C_REAL:C285(v_69_154_r)  //MBTA_HI
			ARRAY REAL:C219(v_69_154_ar; 0)  //MBTA_HI
			C_REAL:C285(v_69_155_r)  //MDC_HI
			ARRAY REAL:C219(v_69_155_ar; 0)  //MDC_HI
			C_REAL:C285(v_69_156_r)  //MTA_HI
			ARRAY REAL:C219(v_69_156_ar; 0)  //MTA_HI
			C_REAL:C285(v_69_157_r)  //MPA_HI
			ARRAY REAL:C219(v_69_157_ar; 0)  //MPA_HI
			C_REAL:C285(v_69_158_r)  //DEM_HI
			ARRAY REAL:C219(v_69_158_ar; 0)  //DEM_HI
			C_REAL:C285(v_69_159_r)  //OTHER_HI
			ARRAY REAL:C219(v_69_159_ar; 0)  //OTHER_HI
			C_REAL:C285(v_69_160_r)  //ALLBR_HI
			ARRAY REAL:C219(v_69_160_ar; 0)  //ALLBR_HI
			C_REAL:C285(v_69_161_r)  //INT_D1_HI
			ARRAY REAL:C219(v_69_161_ar; 0)  //INT_D1_HI
			C_REAL:C285(v_69_162_r)  //INT_D2_HI
			ARRAY REAL:C219(v_69_162_ar; 0)  //INT_D2_HI
			C_REAL:C285(v_69_163_r)  //INT_D3_HI
			ARRAY REAL:C219(v_69_163_ar; 0)  //INT_D3_HI
			C_REAL:C285(v_69_164_r)  //INT_D4_HI
			ARRAY REAL:C219(v_69_164_ar; 0)  //INT_D4_HI
			C_REAL:C285(v_69_165_r)  //INT_D5_HI
			ARRAY REAL:C219(v_69_165_ar; 0)  //INT_D5_HI
			C_REAL:C285(v_69_166_r)  //INT_Tot_HI
			ARRAY REAL:C219(v_69_166_ar; 0)  //INT_Tot_HI
			C_REAL:C285(v_69_167_r)  //SU_D1_HI
			ARRAY REAL:C219(v_69_167_ar; 0)  //SU_D1_HI
			C_REAL:C285(v_69_168_r)  //SU_D2_HI
			ARRAY REAL:C219(v_69_168_ar; 0)  //SU_D2_HI
			C_REAL:C285(v_69_169_r)  //SU_D3_HI
			ARRAY REAL:C219(v_69_169_ar; 0)  //SU_D3_HI
			C_REAL:C285(v_69_170_r)  //SU_D4_HI
			ARRAY REAL:C219(v_69_170_ar; 0)  //SU_D4_HI
			C_REAL:C285(v_69_171_r)  //SU_D5_HI
			ARRAY REAL:C219(v_69_171_ar; 0)  //SU_D5_HI
			C_REAL:C285(v_69_172_r)  //SU_Tot_HI
			ARRAY REAL:C219(v_69_172_ar; 0)  //SU_Tot_HI
			C_REAL:C285(v_69_173_r)  //Loc_D1_HI
			ARRAY REAL:C219(v_69_173_ar; 0)  //Loc_D1_HI
			C_REAL:C285(v_69_174_r)  //Loc_D2_HI
			ARRAY REAL:C219(v_69_174_ar; 0)  //Loc_D2_HI
			C_REAL:C285(v_69_175_r)  //Loc_D3_HI
			ARRAY REAL:C219(v_69_175_ar; 0)  //Loc_D3_HI
			C_REAL:C285(v_69_176_r)  //Loc_D4_HI
			ARRAY REAL:C219(v_69_176_ar; 0)  //Loc_D4_HI
			C_REAL:C285(v_69_177_r)  //Loc_D5_HI
			ARRAY REAL:C219(v_69_177_ar; 0)  //Loc_D5_HI
			C_REAL:C285(v_69_178_r)  //Loc_Tot_HI
			ARRAY REAL:C219(v_69_178_ar; 0)  //Loc_Tot_HI
			C_REAL:C285(v_69_179_r)  //INT_D6_HI
			ARRAY REAL:C219(v_69_179_ar; 0)  //INT_D6_HI
			C_REAL:C285(v_69_180_r)  //LOC_D6_HI
			ARRAY REAL:C219(v_69_180_ar; 0)  //LOC_D6_HI
			C_REAL:C285(v_69_181_r)  //S_T_D6_HI
			ARRAY REAL:C219(v_69_181_ar; 0)  //S_T_D6_HI
			C_REAL:C285(v_69_182_r)  //SU_D6_HI
			ARRAY REAL:C219(v_69_182_ar; 0)  //SU_D6_HI
			C_REAL:C285(v_69_183_r)  //S_D6_HI
			ARRAY REAL:C219(v_69_183_ar; 0)  //S_D6_HI
			C_REAL:C285(v_69_184_r)  //T_D6_HI
			ARRAY REAL:C219(v_69_184_ar; 0)  //T_D6_HI
			C_REAL:C285(v_69_192_r)  //S_D1_Area
			ARRAY REAL:C219(v_69_192_ar; 0)  //S_D1_Area
			C_REAL:C285(v_69_193_r)  //S_D1_SD_Area
			ARRAY REAL:C219(v_69_193_ar; 0)  //S_D1_SD_Area
			C_REAL:C285(v_69_194_r)  //S_D1_NHS_Area
			ARRAY REAL:C219(v_69_194_ar; 0)  //S_D1_NHS_Area
			C_REAL:C285(v_69_195_r)  //S_D1_NHS_SD_Area
			ARRAY REAL:C219(v_69_195_ar; 0)  //S_D1_NHS_SD_Area
			C_REAL:C285(v_69_196_r)  //S_D2_Area
			ARRAY REAL:C219(v_69_196_ar; 0)  //S_D2_Area
			C_REAL:C285(v_69_197_r)  //S_D2_SD_Area
			ARRAY REAL:C219(v_69_197_ar; 0)  //S_D2_SD_Area
			C_REAL:C285(v_69_198_r)  //S_D2_NHS_Area
			ARRAY REAL:C219(v_69_198_ar; 0)  //S_D2_NHS_Area
			C_REAL:C285(v_69_199_r)  //S_D2_NHS_SD_Area
			ARRAY REAL:C219(v_69_199_ar; 0)  //S_D2_NHS_SD_Area
			C_REAL:C285(v_69_200_r)  //S_D3_Area
			ARRAY REAL:C219(v_69_200_ar; 0)  //S_D3_Area
			C_REAL:C285(v_69_201_r)  //S_D3_SD_Area
			ARRAY REAL:C219(v_69_201_ar; 0)  //S_D3_SD_Area
			C_REAL:C285(v_69_202_r)  //S_D3_NHS_Area
			ARRAY REAL:C219(v_69_202_ar; 0)  //S_D3_NHS_Area
			C_REAL:C285(v_69_203_r)  //S_D3_NHS_SD_Area
			ARRAY REAL:C219(v_69_203_ar; 0)  //S_D3_NHS_SD_Area
			C_REAL:C285(v_69_204_r)  //S_D4_Area
			ARRAY REAL:C219(v_69_204_ar; 0)  //S_D4_Area
			C_REAL:C285(v_69_205_r)  //S_D4_SD_Area
			ARRAY REAL:C219(v_69_205_ar; 0)  //S_D4_SD_Area
			C_REAL:C285(v_69_206_r)  //S_D4_NHS_Area
			ARRAY REAL:C219(v_69_206_ar; 0)  //S_D4_NHS_Area
			C_REAL:C285(v_69_207_r)  //S_D4_NHS_SD_Area
			ARRAY REAL:C219(v_69_207_ar; 0)  //S_D4_NHS_SD_Area
			C_REAL:C285(v_69_208_r)  //S_D5_Area
			ARRAY REAL:C219(v_69_208_ar; 0)  //S_D5_Area
			C_REAL:C285(v_69_209_r)  //S_D5_SD_Area
			ARRAY REAL:C219(v_69_209_ar; 0)  //S_D5_SD_Area
			C_REAL:C285(v_69_210_r)  //S_D5_NHS_Area
			ARRAY REAL:C219(v_69_210_ar; 0)  //S_D5_NHS_Area
			C_REAL:C285(v_69_211_r)  //S_D5_NHS_SD_Area
			ARRAY REAL:C219(v_69_211_ar; 0)  //S_D5_NHS_SD_Area
			C_REAL:C285(v_69_212_r)  //S_D6_Area
			ARRAY REAL:C219(v_69_212_ar; 0)  //S_D6_Area
			C_REAL:C285(v_69_213_r)  //S_D6_SD_Area
			ARRAY REAL:C219(v_69_213_ar; 0)  //S_D6_SD_Area
			C_REAL:C285(v_69_214_r)  //S_D6_NHS_Area
			ARRAY REAL:C219(v_69_214_ar; 0)  //S_D6_NHS_Area
			C_REAL:C285(v_69_215_r)  //S_D6_NHS_SD_Area
			ARRAY REAL:C219(v_69_215_ar; 0)  //S_D6_NHS_SD_Area
			C_REAL:C285(v_69_216_r)  //T_D1_Area
			ARRAY REAL:C219(v_69_216_ar; 0)  //T_D1_Area
			C_REAL:C285(v_69_217_r)  //T_D1_SD_Area
			ARRAY REAL:C219(v_69_217_ar; 0)  //T_D1_SD_Area
			C_REAL:C285(v_69_218_r)  //T_D1_NHS_Area
			ARRAY REAL:C219(v_69_218_ar; 0)  //T_D1_NHS_Area
			C_REAL:C285(v_69_219_r)  //T_D1_NHS_SD_Area
			ARRAY REAL:C219(v_69_219_ar; 0)  //T_D1_NHS_SD_Area
			C_REAL:C285(v_69_220_r)  //T_D2_Area
			ARRAY REAL:C219(v_69_220_ar; 0)  //T_D2_Area
			C_REAL:C285(v_69_221_r)  //T_D2_SD_Area
			ARRAY REAL:C219(v_69_221_ar; 0)  //T_D2_SD_Area
			C_REAL:C285(v_69_222_r)  //T_D2_NHS_Area
			ARRAY REAL:C219(v_69_222_ar; 0)  //T_D2_NHS_Area
			C_REAL:C285(v_69_223_r)  //T_D2_NHS_SD_Area
			ARRAY REAL:C219(v_69_223_ar; 0)  //T_D2_NHS_SD_Area
			C_REAL:C285(v_69_224_r)  //T_D3_Area
			ARRAY REAL:C219(v_69_224_ar; 0)  //T_D3_Area
			C_REAL:C285(v_69_225_r)  //T_D3_SD_Area
			ARRAY REAL:C219(v_69_225_ar; 0)  //T_D3_SD_Area
			C_REAL:C285(v_69_226_r)  //T_D3_NHS_Area
			ARRAY REAL:C219(v_69_226_ar; 0)  //T_D3_NHS_Area
			C_REAL:C285(v_69_227_r)  //T_D3_NHS_SD_Area
			ARRAY REAL:C219(v_69_227_ar; 0)  //T_D3_NHS_SD_Area
			C_REAL:C285(v_69_228_r)  //T_D4_Area
			ARRAY REAL:C219(v_69_228_ar; 0)  //T_D4_Area
			C_REAL:C285(v_69_229_r)  //T_D4_SD_Area
			ARRAY REAL:C219(v_69_229_ar; 0)  //T_D4_SD_Area
			C_REAL:C285(v_69_230_r)  //T_D4_NHS_Area
			ARRAY REAL:C219(v_69_230_ar; 0)  //T_D4_NHS_Area
			C_REAL:C285(v_69_231_r)  //T_D4_NHS_SD_Area
			ARRAY REAL:C219(v_69_231_ar; 0)  //T_D4_NHS_SD_Area
			C_REAL:C285(v_69_232_r)  //T_D5_Area
			ARRAY REAL:C219(v_69_232_ar; 0)  //T_D5_Area
			C_REAL:C285(v_69_233_r)  //T_D5_SD_Area
			ARRAY REAL:C219(v_69_233_ar; 0)  //T_D5_SD_Area
			C_REAL:C285(v_69_234_r)  //T_D5_NHS_Area
			ARRAY REAL:C219(v_69_234_ar; 0)  //T_D5_NHS_Area
			C_REAL:C285(v_69_235_r)  //T_D5_NHS_SD_Area
			ARRAY REAL:C219(v_69_235_ar; 0)  //T_D5_NHS_SD_Area
			C_REAL:C285(v_69_236_r)  //T_D6_Area
			ARRAY REAL:C219(v_69_236_ar; 0)  //T_D6_Area
			C_REAL:C285(v_69_237_r)  //T_D6_SD_Area
			ARRAY REAL:C219(v_69_237_ar; 0)  //T_D6_SD_Area
			C_REAL:C285(v_69_238_r)  //T_D6_NHS_Area
			ARRAY REAL:C219(v_69_238_ar; 0)  //T_D6_NHS_Area
			C_REAL:C285(v_69_239_r)  //T_D6_NHS_SD_Area
			ARRAY REAL:C219(v_69_239_ar; 0)  //T_D6_NHS_SD_Area
			C_REAL:C285(v_69_240_r)  //MDC_Area
			ARRAY REAL:C219(v_69_240_ar; 0)  //MDC_Area
			C_REAL:C285(v_69_241_r)  //MDC_SD_Area
			ARRAY REAL:C219(v_69_241_ar; 0)  //MDC_SD_Area
			C_REAL:C285(v_69_242_r)  //MDC_NHS_Area
			ARRAY REAL:C219(v_69_242_ar; 0)  //MDC_NHS_Area
			C_REAL:C285(v_69_243_r)  //MDC_NHS_SD_Area
			ARRAY REAL:C219(v_69_243_ar; 0)  //MDC_NHS_SD_Area
			C_REAL:C285(v_69_244_r)  //DEM_Area
			ARRAY REAL:C219(v_69_244_ar; 0)  //DEM_Area
			C_REAL:C285(v_69_245_r)  //DEM_SD_Area
			ARRAY REAL:C219(v_69_245_ar; 0)  //DEM_SD_Area
			C_REAL:C285(v_69_246_r)  //DEM_NHS_Area
			ARRAY REAL:C219(v_69_246_ar; 0)  //DEM_NHS_Area
			C_REAL:C285(v_69_247_r)  //DEM_NHS_SD_Area
			ARRAY REAL:C219(v_69_247_ar; 0)  //DEM_NHS_SD_Area
			C_REAL:C285(v_69_248_r)  //MBTA_Area
			ARRAY REAL:C219(v_69_248_ar; 0)  //MBTA_Area
			C_REAL:C285(v_69_249_r)  //MBTA_SD_Area
			ARRAY REAL:C219(v_69_249_ar; 0)  //MBTA_SD_Area
			C_REAL:C285(v_69_250_r)  //MBTA_NHS_Area
			ARRAY REAL:C219(v_69_250_ar; 0)  //MBTA_NHS_Area
			C_REAL:C285(v_69_251_r)  //MBTA_NHS_SD_Area
			ARRAY REAL:C219(v_69_251_ar; 0)  //MBTA_NHS_SD_Area
			C_REAL:C285(v_69_252_r)  //MTA_Area
			ARRAY REAL:C219(v_69_252_ar; 0)  //MTA_Area
			C_REAL:C285(v_69_253_r)  //MTA_SD_Area
			ARRAY REAL:C219(v_69_253_ar; 0)  //MTA_SD_Area
			C_REAL:C285(v_69_254_r)  //MTA_NHS_Area
			ARRAY REAL:C219(v_69_254_ar; 0)  //MTA_NHS_Area
			C_REAL:C285(v_69_255_r)  //MTA_NHS_SD_Area
			ARRAY REAL:C219(v_69_255_ar; 0)  //MTA_NHS_SD_Area
			C_REAL:C285(v_69_256_r)  //MPA_Area
			ARRAY REAL:C219(v_69_256_ar; 0)  //MPA_Area
			C_REAL:C285(v_69_257_r)  //MPA_SD_Area
			ARRAY REAL:C219(v_69_257_ar; 0)  //MPA_SD_Area
			C_REAL:C285(v_69_258_r)  //MPA_NHS_Area
			ARRAY REAL:C219(v_69_258_ar; 0)  //MPA_NHS_Area
			C_REAL:C285(v_69_259_r)  //MPA_NHS_SD_Area
			ARRAY REAL:C219(v_69_259_ar; 0)  //MPA_NHS_SD_Area
			C_REAL:C285(v_69_260_r)  //DNR_Area
			ARRAY REAL:C219(v_69_260_ar; 0)  //DNR_Area
			C_REAL:C285(v_69_261_r)  //DNR_SD_Area
			ARRAY REAL:C219(v_69_261_ar; 0)  //DNR_SD_Area
			C_REAL:C285(v_69_262_r)  //DNR_NHS_Area
			ARRAY REAL:C219(v_69_262_ar; 0)  //DNR_NHS_Area
			C_REAL:C285(v_69_263_r)  //DNR_NHS_SD_Area
			ARRAY REAL:C219(v_69_263_ar; 0)  //DNR_NHS_SD_Area
			C_LONGINT:C283(v_69_003_L)  //S_D1total
			ARRAY INTEGER:C220(v_69_003_ai; 0)  //S_D1total
			C_LONGINT:C283(v_69_004_L)  //S_D2total
			ARRAY INTEGER:C220(v_69_004_ai; 0)  //S_D2total
			C_LONGINT:C283(v_69_005_L)  //S_D3total
			ARRAY INTEGER:C220(v_69_005_ai; 0)  //S_D3total
			C_LONGINT:C283(v_69_006_L)  //S_D4total
			ARRAY INTEGER:C220(v_69_006_ai; 0)  //S_D4total
			C_LONGINT:C283(v_69_007_L)  //S_D5total
			ARRAY INTEGER:C220(v_69_007_ai; 0)  //S_D5total
			C_LONGINT:C283(v_69_008_L)  //T_D1total
			ARRAY INTEGER:C220(v_69_008_ai; 0)  //T_D1total
			C_LONGINT:C283(v_69_009_L)  //T_D2total
			ARRAY INTEGER:C220(v_69_009_ai; 0)  //T_D2total
			C_LONGINT:C283(v_69_010_L)  //T_D3total
			ARRAY INTEGER:C220(v_69_010_ai; 0)  //T_D3total
			C_LONGINT:C283(v_69_011_L)  //T_D4total
			ARRAY INTEGER:C220(v_69_011_ai; 0)  //T_D4total
			C_LONGINT:C283(v_69_012_L)  //T_D5total
			ARRAY INTEGER:C220(v_69_012_ai; 0)  //T_D5total
			C_LONGINT:C283(v_69_013_L)  //MBTA_total
			ARRAY INTEGER:C220(v_69_013_ai; 0)  //MBTA_total
			C_LONGINT:C283(v_69_014_L)  //MDC_total
			ARRAY INTEGER:C220(v_69_014_ai; 0)  //MDC_total
			C_LONGINT:C283(v_69_015_L)  //MTA_total
			ARRAY INTEGER:C220(v_69_015_ai; 0)  //MTA_total
			C_LONGINT:C283(v_69_016_L)  //MPA_total
			ARRAY INTEGER:C220(v_69_016_ai; 0)  //MPA_total
			C_LONGINT:C283(v_69_017_L)  //DEM_total
			ARRAY INTEGER:C220(v_69_017_ai; 0)  //DEM_total
			C_LONGINT:C283(v_69_018_L)  //DNR_total
			ARRAY INTEGER:C220(v_69_018_ai; 0)  //DNR_total
			C_LONGINT:C283(v_69_019_L)  //S_D6total
			ARRAY INTEGER:C220(v_69_019_ai; 0)  //S_D6total
			C_LONGINT:C283(v_69_020_L)  //S_D1sd
			ARRAY INTEGER:C220(v_69_020_ai; 0)  //S_D1sd
			C_LONGINT:C283(v_69_021_L)  //S_D2sd
			ARRAY INTEGER:C220(v_69_021_ai; 0)  //S_D2sd
			C_LONGINT:C283(v_69_022_L)  //S_D3sd
			ARRAY INTEGER:C220(v_69_022_ai; 0)  //S_D3sd
			C_LONGINT:C283(v_69_023_L)  //S_D4sd
			ARRAY INTEGER:C220(v_69_023_ai; 0)  //S_D4sd
			C_LONGINT:C283(v_69_024_L)  //S_D5sd
			ARRAY INTEGER:C220(v_69_024_ai; 0)  //S_D5sd
			C_LONGINT:C283(v_69_025_L)  //T_D1sd
			ARRAY INTEGER:C220(v_69_025_ai; 0)  //T_D1sd
			C_LONGINT:C283(v_69_026_L)  //T_D2sd
			ARRAY INTEGER:C220(v_69_026_ai; 0)  //T_D2sd
			C_LONGINT:C283(v_69_027_L)  //T_D3sd
			ARRAY INTEGER:C220(v_69_027_ai; 0)  //T_D3sd
			C_LONGINT:C283(v_69_028_L)  //T_D4sd
			ARRAY INTEGER:C220(v_69_028_ai; 0)  //T_D4sd
			C_LONGINT:C283(v_69_029_L)  //T_D5sd
			ARRAY INTEGER:C220(v_69_029_ai; 0)  //T_D5sd
			C_LONGINT:C283(v_69_030_L)  //MBTA_sd
			ARRAY INTEGER:C220(v_69_030_ai; 0)  //MBTA_sd
			C_LONGINT:C283(v_69_031_L)  //MDC_sd
			ARRAY INTEGER:C220(v_69_031_ai; 0)  //MDC_sd
			C_LONGINT:C283(v_69_032_L)  //MTA_sd
			ARRAY INTEGER:C220(v_69_032_ai; 0)  //MTA_sd
			C_LONGINT:C283(v_69_033_L)  //MPA_sd
			ARRAY INTEGER:C220(v_69_033_ai; 0)  //MPA_sd
			C_LONGINT:C283(v_69_034_L)  //DEM_sd
			ARRAY INTEGER:C220(v_69_034_ai; 0)  //DEM_sd
			C_LONGINT:C283(v_69_035_L)  //DNR_sd
			ARRAY INTEGER:C220(v_69_035_ai; 0)  //DNR_sd
			C_LONGINT:C283(v_69_036_L)  //S_D6sd
			ARRAY INTEGER:C220(v_69_036_ai; 0)  //S_D6sd
			C_LONGINT:C283(v_69_037_L)  //S_D1fo
			ARRAY INTEGER:C220(v_69_037_ai; 0)  //S_D1fo
			C_LONGINT:C283(v_69_038_L)  //S_D2fo
			ARRAY INTEGER:C220(v_69_038_ai; 0)  //S_D2fo
			C_LONGINT:C283(v_69_039_L)  //S_D3fo
			ARRAY INTEGER:C220(v_69_039_ai; 0)  //S_D3fo
			C_LONGINT:C283(v_69_040_L)  //S_D4fo
			ARRAY INTEGER:C220(v_69_040_ai; 0)  //S_D4fo
			C_LONGINT:C283(v_69_041_L)  //S_D5fo
			ARRAY INTEGER:C220(v_69_041_ai; 0)  //S_D5fo
			C_LONGINT:C283(v_69_042_L)  //T_D1fo
			ARRAY INTEGER:C220(v_69_042_ai; 0)  //T_D1fo
			C_LONGINT:C283(v_69_043_L)  //T_D2fo
			ARRAY INTEGER:C220(v_69_043_ai; 0)  //T_D2fo
			C_LONGINT:C283(v_69_044_L)  //T_D3fo
			ARRAY INTEGER:C220(v_69_044_ai; 0)  //T_D3fo
			C_LONGINT:C283(v_69_045_L)  //T_D4fo
			ARRAY INTEGER:C220(v_69_045_ai; 0)  //T_D4fo
			C_LONGINT:C283(v_69_046_L)  //T_D5fo
			ARRAY INTEGER:C220(v_69_046_ai; 0)  //T_D5fo
			C_LONGINT:C283(v_69_047_L)  //MBTA_fo
			ARRAY INTEGER:C220(v_69_047_ai; 0)  //MBTA_fo
			C_LONGINT:C283(v_69_048_L)  //MDC_fo
			ARRAY INTEGER:C220(v_69_048_ai; 0)  //MDC_fo
			C_LONGINT:C283(v_69_049_L)  //MTA_fo
			ARRAY INTEGER:C220(v_69_049_ai; 0)  //MTA_fo
			C_LONGINT:C283(v_69_050_L)  //MPA_fo
			ARRAY INTEGER:C220(v_69_050_ai; 0)  //MPA_fo
			C_LONGINT:C283(v_69_051_L)  //DEM_fo
			ARRAY INTEGER:C220(v_69_051_ai; 0)  //DEM_fo
			C_LONGINT:C283(v_69_052_L)  //DNR_fo
			ARRAY INTEGER:C220(v_69_052_ai; 0)  //DNR_fo
			C_LONGINT:C283(v_69_053_L)  //S_D6fo
			ARRAY INTEGER:C220(v_69_053_ai; 0)  //S_D6fo
			C_LONGINT:C283(v_69_054_L)  //S_D1p
			ARRAY INTEGER:C220(v_69_054_ai; 0)  //S_D1p
			C_LONGINT:C283(v_69_055_L)  //S_D2p
			ARRAY INTEGER:C220(v_69_055_ai; 0)  //S_D2p
			C_LONGINT:C283(v_69_056_L)  //S_D3p
			ARRAY INTEGER:C220(v_69_056_ai; 0)  //S_D3p
			C_LONGINT:C283(v_69_057_L)  //S_D4p
			ARRAY INTEGER:C220(v_69_057_ai; 0)  //S_D4p
			C_LONGINT:C283(v_69_058_L)  //S_D5p
			ARRAY INTEGER:C220(v_69_058_ai; 0)  //S_D5p
			C_LONGINT:C283(v_69_059_L)  //T_D1p
			ARRAY INTEGER:C220(v_69_059_ai; 0)  //T_D1p
			C_LONGINT:C283(v_69_060_L)  //T_D2p
			ARRAY INTEGER:C220(v_69_060_ai; 0)  //T_D2p
			C_LONGINT:C283(v_69_061_L)  //T_D3p
			ARRAY INTEGER:C220(v_69_061_ai; 0)  //T_D3p
			C_LONGINT:C283(v_69_062_L)  //T_D4p
			ARRAY INTEGER:C220(v_69_062_ai; 0)  //T_D4p
			C_LONGINT:C283(v_69_063_L)  //T_D5p
			ARRAY INTEGER:C220(v_69_063_ai; 0)  //T_D5p
			C_LONGINT:C283(v_69_064_L)  //MBTA_p
			ARRAY INTEGER:C220(v_69_064_ai; 0)  //MBTA_p
			C_LONGINT:C283(v_69_065_L)  //MDC_p
			ARRAY INTEGER:C220(v_69_065_ai; 0)  //MDC_p
			C_LONGINT:C283(v_69_066_L)  //MTA_p
			ARRAY INTEGER:C220(v_69_066_ai; 0)  //MTA_p
			C_LONGINT:C283(v_69_067_L)  //MPA_p
			ARRAY INTEGER:C220(v_69_067_ai; 0)  //MPA_p
			C_LONGINT:C283(v_69_068_L)  //DEM_p
			ARRAY INTEGER:C220(v_69_068_ai; 0)  //DEM_p
			C_LONGINT:C283(v_69_069_L)  //DNR_p
			ARRAY INTEGER:C220(v_69_069_ai; 0)  //DNR_p
			C_LONGINT:C283(v_69_070_L)  //S_D6p
			ARRAY INTEGER:C220(v_69_070_ai; 0)  //S_D6p
			C_LONGINT:C283(v_69_071_L)  //S_D1k
			ARRAY INTEGER:C220(v_69_071_ai; 0)  //S_D1k
			C_LONGINT:C283(v_69_072_L)  //S_D2k
			ARRAY INTEGER:C220(v_69_072_ai; 0)  //S_D2k
			C_LONGINT:C283(v_69_073_L)  //S_D3k
			ARRAY INTEGER:C220(v_69_073_ai; 0)  //S_D3k
			C_LONGINT:C283(v_69_074_L)  //S_D4k
			ARRAY INTEGER:C220(v_69_074_ai; 0)  //S_D4k
			C_LONGINT:C283(v_69_075_L)  //S_D5k
			ARRAY INTEGER:C220(v_69_075_ai; 0)  //S_D5k
			C_LONGINT:C283(v_69_076_L)  //T_D1k
			ARRAY INTEGER:C220(v_69_076_ai; 0)  //T_D1k
			C_LONGINT:C283(v_69_077_L)  //T_D2k
			ARRAY INTEGER:C220(v_69_077_ai; 0)  //T_D2k
			C_LONGINT:C283(v_69_078_L)  //T_D3k
			ARRAY INTEGER:C220(v_69_078_ai; 0)  //T_D3k
			C_LONGINT:C283(v_69_079_L)  //T_D4k
			ARRAY INTEGER:C220(v_69_079_ai; 0)  //T_D4k
			C_LONGINT:C283(v_69_080_L)  //T_D5k
			ARRAY INTEGER:C220(v_69_080_ai; 0)  //T_D5k
			C_LONGINT:C283(v_69_081_L)  //MBTA_k
			ARRAY INTEGER:C220(v_69_081_ai; 0)  //MBTA_k
			C_LONGINT:C283(v_69_082_L)  //MDC_k
			ARRAY INTEGER:C220(v_69_082_ai; 0)  //MDC_k
			C_LONGINT:C283(v_69_083_L)  //MTA_k
			ARRAY INTEGER:C220(v_69_083_ai; 0)  //MTA_k
			C_LONGINT:C283(v_69_084_L)  //MPA_k
			ARRAY INTEGER:C220(v_69_084_ai; 0)  //MPA_k
			C_LONGINT:C283(v_69_085_L)  //DEM_k
			ARRAY INTEGER:C220(v_69_085_ai; 0)  //DEM_k
			C_LONGINT:C283(v_69_086_L)  //DNR_k
			ARRAY INTEGER:C220(v_69_086_ai; 0)  //DNR_k
			C_LONGINT:C283(v_69_087_L)  //S_D6k
			ARRAY INTEGER:C220(v_69_087_ai; 0)  //S_D6k
			C_LONGINT:C283(v_69_088_L)  //S_D1t
			ARRAY INTEGER:C220(v_69_088_ai; 0)  //S_D1t
			C_LONGINT:C283(v_69_089_L)  //S_D2t
			ARRAY INTEGER:C220(v_69_089_ai; 0)  //S_D2t
			C_LONGINT:C283(v_69_090_L)  //S_D3t
			ARRAY INTEGER:C220(v_69_090_ai; 0)  //S_D3t
			C_LONGINT:C283(v_69_091_L)  //S_D4t
			ARRAY INTEGER:C220(v_69_091_ai; 0)  //S_D4t
			C_LONGINT:C283(v_69_092_L)  //S_D5t
			ARRAY INTEGER:C220(v_69_092_ai; 0)  //S_D5t
			C_LONGINT:C283(v_69_093_L)  //T_D1t
			ARRAY INTEGER:C220(v_69_093_ai; 0)  //T_D1t
			C_LONGINT:C283(v_69_094_L)  //T_D2t
			ARRAY INTEGER:C220(v_69_094_ai; 0)  //T_D2t
			C_LONGINT:C283(v_69_095_L)  //T_D3t
			ARRAY INTEGER:C220(v_69_095_ai; 0)  //T_D3t
			C_LONGINT:C283(v_69_096_L)  //T_D4t
			ARRAY INTEGER:C220(v_69_096_ai; 0)  //T_D4t
			C_LONGINT:C283(v_69_097_L)  //T_D5t
			ARRAY INTEGER:C220(v_69_097_ai; 0)  //T_D5t
			C_LONGINT:C283(v_69_098_L)  //MBTA_t
			ARRAY INTEGER:C220(v_69_098_ai; 0)  //MBTA_t
			C_LONGINT:C283(v_69_099_L)  //MDC_t
			ARRAY INTEGER:C220(v_69_099_ai; 0)  //MDC_t
			C_LONGINT:C283(v_69_100_L)  //MTA_t
			ARRAY INTEGER:C220(v_69_100_ai; 0)  //MTA_t
			C_LONGINT:C283(v_69_101_L)  //MPA_t
			ARRAY INTEGER:C220(v_69_101_ai; 0)  //MPA_t
			C_LONGINT:C283(v_69_102_L)  //DEM_t
			ARRAY INTEGER:C220(v_69_102_ai; 0)  //DEM_t
			C_LONGINT:C283(v_69_103_L)  //DNR_t
			ARRAY INTEGER:C220(v_69_103_ai; 0)  //DNR_t
			C_LONGINT:C283(v_69_104_L)  //S_D6t
			ARRAY INTEGER:C220(v_69_104_ai; 0)  //S_D6t
			C_LONGINT:C283(v_69_105_L)  //S_D1a50
			ARRAY INTEGER:C220(v_69_105_ai; 0)  //S_D1a50
			C_LONGINT:C283(v_69_106_L)  //S_D2a50
			ARRAY INTEGER:C220(v_69_106_ai; 0)  //S_D2a50
			C_LONGINT:C283(v_69_107_L)  //S_D3a50
			ARRAY INTEGER:C220(v_69_107_ai; 0)  //S_D3a50
			C_LONGINT:C283(v_69_108_L)  //S_D4a50
			ARRAY INTEGER:C220(v_69_108_ai; 0)  //S_D4a50
			C_LONGINT:C283(v_69_109_L)  //S_D5a50
			ARRAY INTEGER:C220(v_69_109_ai; 0)  //S_D5a50
			C_LONGINT:C283(v_69_110_L)  //T_D1a50
			ARRAY INTEGER:C220(v_69_110_ai; 0)  //T_D1a50
			C_LONGINT:C283(v_69_111_L)  //T_D2a50
			ARRAY INTEGER:C220(v_69_111_ai; 0)  //T_D2a50
			C_LONGINT:C283(v_69_112_L)  //T_D3a50
			ARRAY INTEGER:C220(v_69_112_ai; 0)  //T_D3a50
			C_LONGINT:C283(v_69_113_L)  //T_D4a50
			ARRAY INTEGER:C220(v_69_113_ai; 0)  //T_D4a50
			C_LONGINT:C283(v_69_114_L)  //T_D5a50
			ARRAY INTEGER:C220(v_69_114_ai; 0)  //T_D5a50
			C_LONGINT:C283(v_69_115_L)  //MBTA_a50
			ARRAY INTEGER:C220(v_69_115_ai; 0)  //MBTA_a50
			C_LONGINT:C283(v_69_116_L)  //MDC_a50
			ARRAY INTEGER:C220(v_69_116_ai; 0)  //MDC_a50
			C_LONGINT:C283(v_69_117_L)  //MTA_a50
			ARRAY INTEGER:C220(v_69_117_ai; 0)  //MTA_a50
			C_LONGINT:C283(v_69_118_L)  //MPA_a50
			ARRAY INTEGER:C220(v_69_118_ai; 0)  //MPA_a50
			C_LONGINT:C283(v_69_119_L)  //DEM_a50
			ARRAY INTEGER:C220(v_69_119_ai; 0)  //DEM_a50
			C_LONGINT:C283(v_69_120_L)  //DNR_a50
			ARRAY INTEGER:C220(v_69_120_ai; 0)  //DNR_a50
			C_LONGINT:C283(v_69_121_L)  //S_D6a50
			ARRAY INTEGER:C220(v_69_121_ai; 0)  //S_D6a50
			C_LONGINT:C283(v_69_185_L)  //T_D6a50
			ARRAY INTEGER:C220(v_69_185_ai; 0)  //T_D6a50
			C_LONGINT:C283(v_69_186_L)  //T_D6fo
			ARRAY INTEGER:C220(v_69_186_ai; 0)  //T_D6fo
			C_LONGINT:C283(v_69_187_L)  //T_D6k
			ARRAY INTEGER:C220(v_69_187_ai; 0)  //T_D6k
			C_LONGINT:C283(v_69_188_L)  //T_D6p
			ARRAY INTEGER:C220(v_69_188_ai; 0)  //T_D6p
			C_LONGINT:C283(v_69_189_L)  //T_D6sd
			ARRAY INTEGER:C220(v_69_189_ai; 0)  //T_D6sd
			C_LONGINT:C283(v_69_190_L)  //T_D6t
			ARRAY INTEGER:C220(v_69_190_ai; 0)  //T_D6t
			C_LONGINT:C283(v_69_191_L)  //T_D6total
			ARRAY INTEGER:C220(v_69_191_ai; 0)  //T_D6total
			C_LONGINT:C283(v_69_267_L)  //DistrictMethod_L
			ARRAY LONGINT:C221(v_69_267_aL; 0)  //DistrictMethod_L
			C_DATE:C307(v_69_001_d)  //Date_Created
			ARRAY DATE:C224(v_69_001_ad; 0)  //Date_Created
			C_TIME:C306(v_69_134_tm)  //Time_Created
			ARRAY TIME:C1223(v_69_134_atm; 0)  //Time_Created
			C_BOOLEAN:C305(v_69_265_b)  //SD_Calc_New_b
			ARRAY BOOLEAN:C223(v_69_265_ab; 0)  //SD_Calc_New_b
			C_BOOLEAN:C305(v_69_266_b)  //UseLegacyOwner_b
			ARRAY BOOLEAN:C223(v_69_266_ab; 0)  //UseLegacyOwner_b
		: ($1=70)  //Out of Freq
			C_TEXT:C284(v_70_065_txt)  //Out_of_Freq_UUIDKey_s
			ARRAY TEXT:C222(v_70_065_atxt; 0)  //Out_of_Freq_UUIDKey_s
			C_TEXT:C284(v_70_003_txt)  //Owner
			ARRAY TEXT:C222(v_70_003_atxt; 0)  //Owner
			C_TEXT:C284(v_70_004_txt)  //Comments
			ARRAY TEXT:C222(v_70_004_atxt; 0)  //Comments
			C_LONGINT:C283(v_70_005_L)  //D1_reqd
			ARRAY INTEGER:C220(v_70_005_ai; 0)  //D1_reqd
			C_LONGINT:C283(v_70_006_L)  //D2_reqd
			ARRAY INTEGER:C220(v_70_006_ai; 0)  //D2_reqd
			C_LONGINT:C283(v_70_007_L)  //D3_reqd
			ARRAY INTEGER:C220(v_70_007_ai; 0)  //D3_reqd
			C_LONGINT:C283(v_70_008_L)  //D4_reqd
			ARRAY INTEGER:C220(v_70_008_ai; 0)  //D4_reqd
			C_LONGINT:C283(v_70_009_L)  //D5_reqd
			ARRAY INTEGER:C220(v_70_009_ai; 0)  //D5_reqd
			C_LONGINT:C283(v_70_010_L)  //MBTA_reqd
			ARRAY INTEGER:C220(v_70_010_ai; 0)  //MBTA_reqd
			C_LONGINT:C283(v_70_011_L)  //MDC_reqd
			ARRAY INTEGER:C220(v_70_011_ai; 0)  //MDC_reqd
			C_LONGINT:C283(v_70_012_L)  //MTA_reqd
			ARRAY INTEGER:C220(v_70_012_ai; 0)  //MTA_reqd
			C_LONGINT:C283(v_70_013_L)  //MPA_reqd
			ARRAY INTEGER:C220(v_70_013_ai; 0)  //MPA_reqd
			C_LONGINT:C283(v_70_014_L)  //DEM_reqd
			ARRAY INTEGER:C220(v_70_014_ai; 0)  //DEM_reqd
			C_LONGINT:C283(v_70_015_L)  //DNR_reqd
			ARRAY INTEGER:C220(v_70_015_ai; 0)  //DNR_reqd
			C_LONGINT:C283(v_70_016_L)  //Dive_reqd
			ARRAY INTEGER:C220(v_70_016_ai; 0)  //Dive_reqd
			C_LONGINT:C283(v_70_017_L)  //D1_made
			ARRAY INTEGER:C220(v_70_017_ai; 0)  //D1_made
			C_LONGINT:C283(v_70_018_L)  //D2_made
			ARRAY INTEGER:C220(v_70_018_ai; 0)  //D2_made
			C_LONGINT:C283(v_70_019_L)  //D3_made
			ARRAY INTEGER:C220(v_70_019_ai; 0)  //D3_made
			C_LONGINT:C283(v_70_020_L)  //D4_made
			ARRAY INTEGER:C220(v_70_020_ai; 0)  //D4_made
			C_LONGINT:C283(v_70_021_L)  //D5_made
			ARRAY INTEGER:C220(v_70_021_ai; 0)  //D5_made
			C_LONGINT:C283(v_70_022_L)  //MBTA_made
			ARRAY INTEGER:C220(v_70_022_ai; 0)  //MBTA_made
			C_LONGINT:C283(v_70_023_L)  //MDC_made
			ARRAY INTEGER:C220(v_70_023_ai; 0)  //MDC_made
			C_LONGINT:C283(v_70_024_L)  //MTA_made
			ARRAY INTEGER:C220(v_70_024_ai; 0)  //MTA_made
			C_LONGINT:C283(v_70_025_L)  //MPA_made
			ARRAY INTEGER:C220(v_70_025_ai; 0)  //MPA_made
			C_LONGINT:C283(v_70_026_L)  //DEM_made
			ARRAY INTEGER:C220(v_70_026_ai; 0)  //DEM_made
			C_LONGINT:C283(v_70_027_L)  //DNR_made
			ARRAY INTEGER:C220(v_70_027_ai; 0)  //DNR_made
			C_LONGINT:C283(v_70_028_L)  //Dive_made
			ARRAY INTEGER:C220(v_70_028_ai; 0)  //Dive_made
			C_LONGINT:C283(v_70_029_L)  //D1_1ytd
			ARRAY INTEGER:C220(v_70_029_ai; 0)  //D1_1ytd
			C_LONGINT:C283(v_70_030_L)  //D2_1ytd
			ARRAY INTEGER:C220(v_70_030_ai; 0)  //D2_1ytd
			C_LONGINT:C283(v_70_031_L)  //D3_1ytd
			ARRAY INTEGER:C220(v_70_031_ai; 0)  //D3_1ytd
			C_LONGINT:C283(v_70_032_L)  //D4_1ytd
			ARRAY INTEGER:C220(v_70_032_ai; 0)  //D4_1ytd
			C_LONGINT:C283(v_70_033_L)  //D5_1ytd
			ARRAY INTEGER:C220(v_70_033_ai; 0)  //D5_1ytd
			C_LONGINT:C283(v_70_034_L)  //MBTA_1ytd
			ARRAY INTEGER:C220(v_70_034_ai; 0)  //MBTA_1ytd
			C_LONGINT:C283(v_70_035_L)  //MDC_1ytd
			ARRAY INTEGER:C220(v_70_035_ai; 0)  //MDC_1ytd
			C_LONGINT:C283(v_70_036_L)  //MTA_1ytd
			ARRAY INTEGER:C220(v_70_036_ai; 0)  //MTA_1ytd
			C_LONGINT:C283(v_70_037_L)  //MPA_1ytd
			ARRAY INTEGER:C220(v_70_037_ai; 0)  //MPA_1ytd
			C_LONGINT:C283(v_70_038_L)  //DEM_1ytd
			ARRAY INTEGER:C220(v_70_038_ai; 0)  //DEM_1ytd
			C_LONGINT:C283(v_70_039_L)  //DNR_1ytd
			ARRAY INTEGER:C220(v_70_039_ai; 0)  //DNR_1ytd
			C_LONGINT:C283(v_70_040_L)  //Dive_1ytd
			ARRAY INTEGER:C220(v_70_040_ai; 0)  //Dive_1ytd
			C_LONGINT:C283(v_70_041_L)  //D1_2ytd
			ARRAY INTEGER:C220(v_70_041_ai; 0)  //D1_2ytd
			C_LONGINT:C283(v_70_042_L)  //D2_2ytd
			ARRAY INTEGER:C220(v_70_042_ai; 0)  //D2_2ytd
			C_LONGINT:C283(v_70_043_L)  //D3_2ytd
			ARRAY INTEGER:C220(v_70_043_ai; 0)  //D3_2ytd
			C_LONGINT:C283(v_70_044_L)  //D4_2ytd
			ARRAY INTEGER:C220(v_70_044_ai; 0)  //D4_2ytd
			C_LONGINT:C283(v_70_045_L)  //D5_2ytd
			ARRAY INTEGER:C220(v_70_045_ai; 0)  //D5_2ytd
			C_LONGINT:C283(v_70_046_L)  //MBTA_2ytd
			ARRAY INTEGER:C220(v_70_046_ai; 0)  //MBTA_2ytd
			C_LONGINT:C283(v_70_047_L)  //MDC_2ytd
			ARRAY INTEGER:C220(v_70_047_ai; 0)  //MDC_2ytd
			C_LONGINT:C283(v_70_048_L)  //MTA_2ytd
			ARRAY INTEGER:C220(v_70_048_ai; 0)  //MTA_2ytd
			C_LONGINT:C283(v_70_049_L)  //MPA_2ytd
			ARRAY INTEGER:C220(v_70_049_ai; 0)  //MPA_2ytd
			C_LONGINT:C283(v_70_050_L)  //DEM_2ytd
			ARRAY INTEGER:C220(v_70_050_ai; 0)  //DEM_2ytd
			C_LONGINT:C283(v_70_051_L)  //DNR_2ytd
			ARRAY INTEGER:C220(v_70_051_ai; 0)  //DNR_2ytd
			C_LONGINT:C283(v_70_052_L)  //Dive_2ytd
			ARRAY INTEGER:C220(v_70_052_ai; 0)  //Dive_2ytd
			C_LONGINT:C283(v_70_053_L)  //D1_3ytd
			ARRAY INTEGER:C220(v_70_053_ai; 0)  //D1_3ytd
			C_LONGINT:C283(v_70_054_L)  //D2_3ytd
			ARRAY INTEGER:C220(v_70_054_ai; 0)  //D2_3ytd
			C_LONGINT:C283(v_70_055_L)  //D3_3ytd
			ARRAY INTEGER:C220(v_70_055_ai; 0)  //D3_3ytd
			C_LONGINT:C283(v_70_056_L)  //D4_3ytd
			ARRAY INTEGER:C220(v_70_056_ai; 0)  //D4_3ytd
			C_LONGINT:C283(v_70_057_L)  //D5_3ytd
			ARRAY INTEGER:C220(v_70_057_ai; 0)  //D5_3ytd
			C_LONGINT:C283(v_70_058_L)  //MBTA_3ytd
			ARRAY INTEGER:C220(v_70_058_ai; 0)  //MBTA_3ytd
			C_LONGINT:C283(v_70_059_L)  //MDC_3ytd
			ARRAY INTEGER:C220(v_70_059_ai; 0)  //MDC_3ytd
			C_LONGINT:C283(v_70_060_L)  //MTA_3ytd
			ARRAY INTEGER:C220(v_70_060_ai; 0)  //MTA_3ytd
			C_LONGINT:C283(v_70_061_L)  //MPA_3ytd
			ARRAY INTEGER:C220(v_70_061_ai; 0)  //MPA_3ytd
			C_LONGINT:C283(v_70_062_L)  //DEM_3ytd
			ARRAY INTEGER:C220(v_70_062_ai; 0)  //DEM_3ytd
			C_LONGINT:C283(v_70_063_L)  //DNR_3ytd
			ARRAY INTEGER:C220(v_70_063_ai; 0)  //DNR_3ytd
			C_LONGINT:C283(v_70_064_L)  //Dive_3ytd
			ARRAY INTEGER:C220(v_70_064_ai; 0)  //Dive_3ytd
			C_DATE:C307(v_70_001_d)  //Date_Created
			ARRAY DATE:C224(v_70_001_ad; 0)  //Date_Created
			C_TIME:C306(v_70_002_tm)  //Time_Created
			ARRAY TIME:C1223(v_70_002_atm; 0)  //Time_Created
		: ($1=71)  //Integral Bridge
			C_TEXT:C284(v_71_003_txt)  //Integral_Bridge_UUIDKey_s
			ARRAY TEXT:C222(v_71_003_atxt; 0)  //Integral_Bridge_UUIDKey_s
			C_TEXT:C284(v_71_001_txt)  //Code
			ARRAY TEXT:C222(v_71_001_atxt; 0)  //Code
			C_TEXT:C284(v_71_002_txt)  //Description
			ARRAY TEXT:C222(v_71_002_atxt; 0)  //Description
		: ($1=72)  //RPCs
			C_TEXT:C284(v_72_004_txt)  //RPCs_UUIDKey_s
			ARRAY TEXT:C222(v_72_004_atxt; 0)  //RPCs_UUIDKey_s
			C_TEXT:C284(v_72_001_txt)  //Code
			ARRAY TEXT:C222(v_72_001_atxt; 0)  //Code
			C_TEXT:C284(v_72_002_txt)  //RPC Name
			ARRAY TEXT:C222(v_72_002_atxt; 0)  //RPC Name
			C_TEXT:C284(v_72_003_txt)  //Short Name
			ARRAY TEXT:C222(v_72_003_atxt; 0)  //Short Name
		: ($1=73)  //TownLineInfo
			C_TEXT:C284(v_73_004_txt)  //TownLineInfo_UUIDKey_s
			ARRAY TEXT:C222(v_73_004_atxt; 0)  //TownLineInfo_UUIDKey_s
			C_TEXT:C284(v_73_001_txt)  //BIN
			ARRAY TEXT:C222(v_73_001_atxt; 0)  //BIN
			C_TEXT:C284(v_73_002_txt)  //BDEPT
			ARRAY TEXT:C222(v_73_002_atxt; 0)  //BDEPT
			C_LONGINT:C283(v_73_003_L)  //RefID
			ARRAY LONGINT:C221(v_73_003_aL; 0)  //RefID
		: ($1=74)  //Conslt Rating Cost
			C_TEXT:C284(v_74_050_txt)  //Conslt_Rating_Cost_UUIDKey_s
			ARRAY TEXT:C222(v_74_050_atxt; 0)  //Conslt_Rating_Cost_UUIDKey_s
			C_TEXT:C284(v_74_019_txt)  //Neg Comments
			ARRAY TEXT:C222(v_74_019_atxt; 0)  //Neg Comments
			C_TEXT:C284(v_74_036_txt)  //Act Comments
			ARRAY TEXT:C222(v_74_036_atxt; 0)  //Act Comments
			C_REAL:C285(v_74_002_r)  //Neg WorkHours
			ARRAY REAL:C219(v_74_002_ar; 0)  //Neg WorkHours
			C_REAL:C285(v_74_003_r)  //Neg Salary
			ARRAY REAL:C219(v_74_003_ar; 0)  //Neg Salary
			C_REAL:C285(v_74_004_r)  //Neg IndirectCost
			ARRAY REAL:C219(v_74_004_ar; 0)  //Neg IndirectCost
			C_REAL:C285(v_74_005_r)  //Neg NetFee
			ARRAY REAL:C219(v_74_005_ar; 0)  //Neg NetFee
			C_REAL:C285(v_74_006_r)  //Neg TotalLimitFee
			ARRAY REAL:C219(v_74_006_ar; 0)  //Neg TotalLimitFee
			C_REAL:C285(v_74_007_r)  //Neg Flagging
			ARRAY REAL:C219(v_74_007_ar; 0)  //Neg Flagging
			C_REAL:C285(v_74_008_r)  //Neg Rigging
			ARRAY REAL:C219(v_74_008_ar; 0)  //Neg Rigging
			C_REAL:C285(v_74_009_r)  //Neg Lifts
			ARRAY REAL:C219(v_74_009_ar; 0)  //Neg Lifts
			C_REAL:C285(v_74_010_r)  //Neg TrafficControl
			ARRAY REAL:C219(v_74_010_ar; 0)  //Neg TrafficControl
			C_REAL:C285(v_74_011_r)  //Neg Police
			ARRAY REAL:C219(v_74_011_ar; 0)  //Neg Police
			C_REAL:C285(v_74_012_r)  //Neg Printing
			ARRAY REAL:C219(v_74_012_ar; 0)  //Neg Printing
			C_REAL:C285(v_74_013_r)  //Neg Mileage
			ARRAY REAL:C219(v_74_013_ar; 0)  //Neg Mileage
			C_REAL:C285(v_74_014_r)  //Neg Lodging
			ARRAY REAL:C219(v_74_014_ar; 0)  //Neg Lodging
			C_REAL:C285(v_74_015_r)  //Neg Postage
			ARRAY REAL:C219(v_74_015_ar; 0)  //Neg Postage
			C_REAL:C285(v_74_016_r)  //Neg Meals
			ARRAY REAL:C219(v_74_016_ar; 0)  //Neg Meals
			C_REAL:C285(v_74_017_r)  //Neg TotalDirectCost
			ARRAY REAL:C219(v_74_017_ar; 0)  //Neg TotalDirectCost
			C_REAL:C285(v_74_018_r)  //Neg TotalCost
			ARRAY REAL:C219(v_74_018_ar; 0)  //Neg TotalCost
			C_REAL:C285(v_74_020_r)  //Act WorkHours
			ARRAY REAL:C219(v_74_020_ar; 0)  //Act WorkHours
			C_REAL:C285(v_74_021_r)  //Act Salary
			ARRAY REAL:C219(v_74_021_ar; 0)  //Act Salary
			C_REAL:C285(v_74_022_r)  //Act NetFee
			ARRAY REAL:C219(v_74_022_ar; 0)  //Act NetFee
			C_REAL:C285(v_74_023_r)  //Act TotalLimitFee
			ARRAY REAL:C219(v_74_023_ar; 0)  //Act TotalLimitFee
			C_REAL:C285(v_74_024_r)  //Act Flagging
			ARRAY REAL:C219(v_74_024_ar; 0)  //Act Flagging
			C_REAL:C285(v_74_025_r)  //Act Rigging
			ARRAY REAL:C219(v_74_025_ar; 0)  //Act Rigging
			C_REAL:C285(v_74_026_r)  //Act Lifts
			ARRAY REAL:C219(v_74_026_ar; 0)  //Act Lifts
			C_REAL:C285(v_74_027_r)  //Act TrafficControl
			ARRAY REAL:C219(v_74_027_ar; 0)  //Act TrafficControl
			C_REAL:C285(v_74_028_r)  //Act Police
			ARRAY REAL:C219(v_74_028_ar; 0)  //Act Police
			C_REAL:C285(v_74_029_r)  //Act Printing
			ARRAY REAL:C219(v_74_029_ar; 0)  //Act Printing
			C_REAL:C285(v_74_030_r)  //Act Mileage
			ARRAY REAL:C219(v_74_030_ar; 0)  //Act Mileage
			C_REAL:C285(v_74_031_r)  //Act Lodging
			ARRAY REAL:C219(v_74_031_ar; 0)  //Act Lodging
			C_REAL:C285(v_74_032_r)  //Act Postage
			ARRAY REAL:C219(v_74_032_ar; 0)  //Act Postage
			C_REAL:C285(v_74_033_r)  //Act Meals
			ARRAY REAL:C219(v_74_033_ar; 0)  //Act Meals
			C_REAL:C285(v_74_034_r)  //Act TotalDirectCost
			ARRAY REAL:C219(v_74_034_ar; 0)  //Act TotalDirectCost
			C_REAL:C285(v_74_035_r)  //Act TotalCost
			ARRAY REAL:C219(v_74_035_ar; 0)  //Act TotalCost
			C_REAL:C285(v_74_037_r)  //Neg Misc
			ARRAY REAL:C219(v_74_037_ar; 0)  //Neg Misc
			C_REAL:C285(v_74_038_r)  //Act Misc
			ARRAY REAL:C219(v_74_038_ar; 0)  //Act Misc
			C_REAL:C285(v_74_039_r)  //Act IndirectCost
			ARRAY REAL:C219(v_74_039_ar; 0)  //Act IndirectCost
			C_REAL:C285(v_74_040_r)  //OverheadRate
			ARRAY REAL:C219(v_74_040_ar; 0)  //OverheadRate
			C_REAL:C285(v_74_042_r)  //Neg Barge
			ARRAY REAL:C219(v_74_042_ar; 0)  //Neg Barge
			C_REAL:C285(v_74_043_r)  //Neg SafetyBoat
			ARRAY REAL:C219(v_74_043_ar; 0)  //Neg SafetyBoat
			C_REAL:C285(v_74_044_r)  //Neg Snooper
			ARRAY REAL:C219(v_74_044_ar; 0)  //Neg Snooper
			C_REAL:C285(v_74_045_r)  //Neg RRflagging
			ARRAY REAL:C219(v_74_045_ar; 0)  //Neg RRflagging
			C_REAL:C285(v_74_046_r)  //Act Barge
			ARRAY REAL:C219(v_74_046_ar; 0)  //Act Barge
			C_REAL:C285(v_74_047_r)  //Act SafetyBoat
			ARRAY REAL:C219(v_74_047_ar; 0)  //Act SafetyBoat
			C_REAL:C285(v_74_048_r)  //Act Snooper
			ARRAY REAL:C219(v_74_048_ar; 0)  //Act Snooper
			C_REAL:C285(v_74_049_r)  //Act RRflagging
			ARRAY REAL:C219(v_74_049_ar; 0)  //Act RRflagging
			C_LONGINT:C283(v_74_001_L)  //ConsltRatingID
			ARRAY LONGINT:C221(v_74_001_aL; 0)  //ConsltRatingID
			C_BOOLEAN:C305(v_74_041_b)  //FinalCost_B
			ARRAY BOOLEAN:C223(v_74_041_ab; 0)  //FinalCost_B
		: ($1=75)  //Bridge Design
			C_TEXT:C284(v_75_053_txt)  //Bridge_Design_UUIDKey_s
			ARRAY TEXT:C222(v_75_053_atxt; 0)  //Bridge_Design_UUIDKey_s
			C_TEXT:C284(v_75_001_txt)  //BIN
			ARRAY TEXT:C222(v_75_001_atxt; 0)  //BIN
			C_TEXT:C284(v_75_002_txt)  //PROJIS
			ARRAY TEXT:C222(v_75_002_atxt; 0)  //PROJIS
			C_TEXT:C284(v_75_003_txt)  //FAPNumber
			ARRAY TEXT:C222(v_75_003_atxt; 0)  //FAPNumber
			C_TEXT:C284(v_75_005_txt)  //Designer
			ARRAY TEXT:C222(v_75_005_atxt; 0)  //Designer
			C_TEXT:C284(v_75_007_txt)  //ProjectType
			ARRAY TEXT:C222(v_75_007_atxt; 0)  //ProjectType
			C_TEXT:C284(v_75_008_txt)  //Abutment
			ARRAY TEXT:C222(v_75_008_atxt; 0)  //Abutment
			C_TEXT:C284(v_75_009_txt)  //AbutmentComment
			ARRAY TEXT:C222(v_75_009_atxt; 0)  //AbutmentComment
			C_TEXT:C284(v_75_010_txt)  //SeismicRetrofit
			ARRAY TEXT:C222(v_75_010_atxt; 0)  //SeismicRetrofit
			C_TEXT:C284(v_75_011_txt)  //SuperStruct
			ARRAY TEXT:C222(v_75_011_atxt; 0)  //SuperStruct
			C_TEXT:C284(v_75_012_txt)  //SuperStructComment
			ARRAY TEXT:C222(v_75_012_atxt; 0)  //SuperStructComment
			C_TEXT:C284(v_75_013_txt)  //Deck
			ARRAY TEXT:C222(v_75_013_atxt; 0)  //Deck
			C_TEXT:C284(v_75_014_txt)  //DeckComment
			ARRAY TEXT:C222(v_75_014_atxt; 0)  //DeckComment
			C_TEXT:C284(v_75_015_txt)  //Pier
			ARRAY TEXT:C222(v_75_015_atxt; 0)  //Pier
			C_TEXT:C284(v_75_016_txt)  //PierComment
			ARRAY TEXT:C222(v_75_016_atxt; 0)  //PierComment
			C_TEXT:C284(v_75_017_txt)  //Scour
			ARRAY TEXT:C222(v_75_017_atxt; 0)  //Scour
			C_TEXT:C284(v_75_018_txt)  //Barrier
			ARRAY TEXT:C222(v_75_018_atxt; 0)  //Barrier
			C_TEXT:C284(v_75_019_txt)  //Bearing
			ARRAY TEXT:C222(v_75_019_atxt; 0)  //Bearing
			C_TEXT:C284(v_75_020_txt)  //Joint
			ARRAY TEXT:C222(v_75_020_atxt; 0)  //Joint
			C_TEXT:C284(v_75_021_txt)  //ScreenType
			ARRAY TEXT:C222(v_75_021_atxt; 0)  //ScreenType
			C_TEXT:C284(v_75_022_txt)  //CurbRail
			ARRAY TEXT:C222(v_75_022_atxt; 0)  //CurbRail
			C_TEXT:C284(v_75_030_txt)  //StageConstruction
			ARRAY TEXT:C222(v_75_030_atxt; 0)  //StageConstruction
			C_TEXT:C284(v_75_031_txt)  //PreEngineered
			ARRAY TEXT:C222(v_75_031_atxt; 0)  //PreEngineered
			C_TEXT:C284(v_75_033_txt)  //ContractNumber
			ARRAY TEXT:C222(v_75_033_atxt; 0)  //ContractNumber
			C_TEXT:C284(v_75_036_txt)  //DesignLoad
			ARRAY TEXT:C222(v_75_036_atxt; 0)  //DesignLoad
			C_TEXT:C284(v_75_048_txt)  //MinVertUcCode
			ARRAY TEXT:C222(v_75_048_atxt; 0)  //MinVertUcCode
			C_TEXT:C284(v_75_049_txt)  //MinLatUcCode
			ARRAY TEXT:C222(v_75_049_atxt; 0)  //MinLatUcCode
			C_REAL:C285(v_75_006_r)  //TotalOfficeEstimate
			ARRAY REAL:C219(v_75_006_ar; 0)  //TotalOfficeEstimate
			C_REAL:C285(v_75_023_r)  //SidewalkLeft
			ARRAY REAL:C219(v_75_023_ar; 0)  //SidewalkLeft
			C_REAL:C285(v_75_024_r)  //SidewalkRight
			ARRAY REAL:C219(v_75_024_ar; 0)  //SidewalkRight
			C_REAL:C285(v_75_025_r)  //TotalSpanLength
			ARRAY REAL:C219(v_75_025_ar; 0)  //TotalSpanLength
			C_REAL:C285(v_75_026_r)  //WideOutToOut
			ARRAY REAL:C219(v_75_026_ar; 0)  //WideOutToOut
			C_REAL:C285(v_75_028_r)  //SkewAngle
			ARRAY REAL:C219(v_75_028_ar; 0)  //SkewAngle
			C_REAL:C285(v_75_029_r)  //RadiusCurvedGirder
			ARRAY REAL:C219(v_75_029_ar; 0)  //RadiusCurvedGirder
			C_REAL:C285(v_75_032_r)  //ApproachSlabVolume
			ARRAY REAL:C219(v_75_032_ar; 0)  //ApproachSlabVolume
			C_REAL:C285(v_75_037_r)  //CostPerSQM
			ARRAY REAL:C219(v_75_037_ar; 0)  //CostPerSQM
			C_REAL:C285(v_75_043_r)  //StructLength
			ARRAY REAL:C219(v_75_043_ar; 0)  //StructLength
			C_REAL:C285(v_75_044_r)  //WidthCurbToCurb
			ARRAY REAL:C219(v_75_044_ar; 0)  //WidthCurbToCurb
			C_REAL:C285(v_75_045_r)  //MinVertUnderclear
			ARRAY REAL:C219(v_75_045_ar; 0)  //MinVertUnderclear
			C_REAL:C285(v_75_046_r)  //MinLatUnderclearRT
			ARRAY REAL:C219(v_75_046_ar; 0)  //MinLatUnderclearRT
			C_REAL:C285(v_75_047_r)  //MinLatUnderclearLT
			ARRAY REAL:C219(v_75_047_ar; 0)  //MinLatUnderclearLT
			C_REAL:C285(v_75_050_r)  //HI_Total_Elmt_Cost
			ARRAY REAL:C219(v_75_050_ar; 0)  //HI_Total_Elmt_Cost
			C_REAL:C285(v_75_051_r)  //HI_Current_Elmt_Cost
			ARRAY REAL:C219(v_75_051_ar; 0)  //HI_Current_Elmt_Cost
			C_REAL:C285(v_75_052_r)  //HealthIndex
			ARRAY REAL:C219(v_75_052_ar; 0)  //HealthIndex
			C_LONGINT:C283(v_75_027_L)  //NumSpans
			ARRAY INTEGER:C220(v_75_027_ai; 0)  //NumSpans
			C_LONGINT:C283(v_75_039_L)  //LanesOnStruct
			ARRAY INTEGER:C220(v_75_039_ai; 0)  //LanesOnStruct
			C_LONGINT:C283(v_75_040_L)  //LanesUnderStruct
			ARRAY INTEGER:C220(v_75_040_ai; 0)  //LanesUnderStruct
			C_LONGINT:C283(v_75_042_L)  //YearADT
			ARRAY INTEGER:C220(v_75_042_ai; 0)  //YearADT
			C_LONGINT:C283(v_75_035_L)  //BridgeDesignID
			ARRAY LONGINT:C221(v_75_035_aL; 0)  //BridgeDesignID
			C_LONGINT:C283(v_75_041_L)  //AvgDailyTraffic
			ARRAY LONGINT:C221(v_75_041_aL; 0)  //AvgDailyTraffic
			C_DATE:C307(v_75_004_d)  //ADVDate
			ARRAY DATE:C224(v_75_004_ad; 0)  //ADVDate
			C_BOOLEAN:C305(v_75_034_b)  //PlansOnFile
			ARRAY BOOLEAN:C223(v_75_034_ab; 0)  //PlansOnFile
			C_BOOLEAN:C305(v_75_038_b)  //MetricUnit
			ARRAY BOOLEAN:C223(v_75_038_ab; 0)  //MetricUnit
		: ($1=76)  //Cons Inspection Cost
			C_TEXT:C284(v_76_050_txt)  //Cons_Inspection_Cost_UUIDKey_s
			ARRAY TEXT:C222(v_76_050_atxt; 0)  //Cons_Inspection_Cost_UUIDKey_s
			C_TEXT:C284(v_76_020_txt)  //Neg Comments
			ARRAY TEXT:C222(v_76_020_atxt; 0)  //Neg Comments
			C_TEXT:C284(v_76_039_txt)  //Act Comments
			ARRAY TEXT:C222(v_76_039_atxt; 0)  //Act Comments
			C_REAL:C285(v_76_002_r)  //Neg WorkHours
			ARRAY REAL:C219(v_76_002_ar; 0)  //Neg WorkHours
			C_REAL:C285(v_76_003_r)  //Neg Salary
			ARRAY REAL:C219(v_76_003_ar; 0)  //Neg Salary
			C_REAL:C285(v_76_004_r)  //Neg IndirectCost
			ARRAY REAL:C219(v_76_004_ar; 0)  //Neg IndirectCost
			C_REAL:C285(v_76_005_r)  //Neg NetFee
			ARRAY REAL:C219(v_76_005_ar; 0)  //Neg NetFee
			C_REAL:C285(v_76_006_r)  //Neg TotalLimitFee
			ARRAY REAL:C219(v_76_006_ar; 0)  //Neg TotalLimitFee
			C_REAL:C285(v_76_007_r)  //Neg Flagging
			ARRAY REAL:C219(v_76_007_ar; 0)  //Neg Flagging
			C_REAL:C285(v_76_008_r)  //Neg Rigging
			ARRAY REAL:C219(v_76_008_ar; 0)  //Neg Rigging
			C_REAL:C285(v_76_009_r)  //Neg Lifts
			ARRAY REAL:C219(v_76_009_ar; 0)  //Neg Lifts
			C_REAL:C285(v_76_010_r)  //Neg TrafficControl
			ARRAY REAL:C219(v_76_010_ar; 0)  //Neg TrafficControl
			C_REAL:C285(v_76_011_r)  //Neg Police
			ARRAY REAL:C219(v_76_011_ar; 0)  //Neg Police
			C_REAL:C285(v_76_012_r)  //Neg Printing
			ARRAY REAL:C219(v_76_012_ar; 0)  //Neg Printing
			C_REAL:C285(v_76_013_r)  //Neg Mileage
			ARRAY REAL:C219(v_76_013_ar; 0)  //Neg Mileage
			C_REAL:C285(v_76_014_r)  //Neg Lodging
			ARRAY REAL:C219(v_76_014_ar; 0)  //Neg Lodging
			C_REAL:C285(v_76_015_r)  //Neg Postage
			ARRAY REAL:C219(v_76_015_ar; 0)  //Neg Postage
			C_REAL:C285(v_76_016_r)  //Neg Meals
			ARRAY REAL:C219(v_76_016_ar; 0)  //Neg Meals
			C_REAL:C285(v_76_017_r)  //Neg Misc
			ARRAY REAL:C219(v_76_017_ar; 0)  //Neg Misc
			C_REAL:C285(v_76_018_r)  //Neg TotalDirectCost
			ARRAY REAL:C219(v_76_018_ar; 0)  //Neg TotalDirectCost
			C_REAL:C285(v_76_019_r)  //Neg TotalCost
			ARRAY REAL:C219(v_76_019_ar; 0)  //Neg TotalCost
			C_REAL:C285(v_76_021_r)  //Act WorkHours
			ARRAY REAL:C219(v_76_021_ar; 0)  //Act WorkHours
			C_REAL:C285(v_76_022_r)  //Act Salary
			ARRAY REAL:C219(v_76_022_ar; 0)  //Act Salary
			C_REAL:C285(v_76_023_r)  //Act IndirectCost
			ARRAY REAL:C219(v_76_023_ar; 0)  //Act IndirectCost
			C_REAL:C285(v_76_024_r)  //Act NetFee
			ARRAY REAL:C219(v_76_024_ar; 0)  //Act NetFee
			C_REAL:C285(v_76_025_r)  //Act TotalLimitFee
			ARRAY REAL:C219(v_76_025_ar; 0)  //Act TotalLimitFee
			C_REAL:C285(v_76_026_r)  //Act Flagging
			ARRAY REAL:C219(v_76_026_ar; 0)  //Act Flagging
			C_REAL:C285(v_76_027_r)  //Act Rigging
			ARRAY REAL:C219(v_76_027_ar; 0)  //Act Rigging
			C_REAL:C285(v_76_028_r)  //Act Lifts
			ARRAY REAL:C219(v_76_028_ar; 0)  //Act Lifts
			C_REAL:C285(v_76_029_r)  //Act TrafficControl
			ARRAY REAL:C219(v_76_029_ar; 0)  //Act TrafficControl
			C_REAL:C285(v_76_030_r)  //Act Police
			ARRAY REAL:C219(v_76_030_ar; 0)  //Act Police
			C_REAL:C285(v_76_031_r)  //Act Printing
			ARRAY REAL:C219(v_76_031_ar; 0)  //Act Printing
			C_REAL:C285(v_76_032_r)  //Act Mileage
			ARRAY REAL:C219(v_76_032_ar; 0)  //Act Mileage
			C_REAL:C285(v_76_033_r)  //Act Lodging
			ARRAY REAL:C219(v_76_033_ar; 0)  //Act Lodging
			C_REAL:C285(v_76_034_r)  //Act Postage
			ARRAY REAL:C219(v_76_034_ar; 0)  //Act Postage
			C_REAL:C285(v_76_035_r)  //Act Meals
			ARRAY REAL:C219(v_76_035_ar; 0)  //Act Meals
			C_REAL:C285(v_76_036_r)  //Act Misc
			ARRAY REAL:C219(v_76_036_ar; 0)  //Act Misc
			C_REAL:C285(v_76_037_r)  //Act TotalDirectCost
			ARRAY REAL:C219(v_76_037_ar; 0)  //Act TotalDirectCost
			C_REAL:C285(v_76_038_r)  //Act TotalCost
			ARRAY REAL:C219(v_76_038_ar; 0)  //Act TotalCost
			C_REAL:C285(v_76_040_r)  //OverheadRate
			ARRAY REAL:C219(v_76_040_ar; 0)  //OverheadRate
			C_REAL:C285(v_76_041_r)  //Neg Barge
			ARRAY REAL:C219(v_76_041_ar; 0)  //Neg Barge
			C_REAL:C285(v_76_042_r)  //Neg SafetyBoat
			ARRAY REAL:C219(v_76_042_ar; 0)  //Neg SafetyBoat
			C_REAL:C285(v_76_043_r)  //Neg Snooper
			ARRAY REAL:C219(v_76_043_ar; 0)  //Neg Snooper
			C_REAL:C285(v_76_044_r)  //Neg RRflagging
			ARRAY REAL:C219(v_76_044_ar; 0)  //Neg RRflagging
			C_REAL:C285(v_76_045_r)  //Act Barge
			ARRAY REAL:C219(v_76_045_ar; 0)  //Act Barge
			C_REAL:C285(v_76_046_r)  //Act SafetyBoat
			ARRAY REAL:C219(v_76_046_ar; 0)  //Act SafetyBoat
			C_REAL:C285(v_76_047_r)  //Act Snooper
			ARRAY REAL:C219(v_76_047_ar; 0)  //Act Snooper
			C_REAL:C285(v_76_048_r)  //Act RRflagging
			ARRAY REAL:C219(v_76_048_ar; 0)  //Act RRflagging
			C_LONGINT:C283(v_76_001_L)  //ConsInspectionID
			ARRAY LONGINT:C221(v_76_001_aL; 0)  //ConsInspectionID
			C_BOOLEAN:C305(v_76_049_b)  //FinalCost_B
			ARRAY BOOLEAN:C223(v_76_049_ab; 0)  //FinalCost_B
		: ($1=77)  //Conslt Address
			C_TEXT:C284(v_77_023_txt)  //Conslt_Address_UUIDKey_s
			ARRAY TEXT:C222(v_77_023_atxt; 0)  //Conslt_Address_UUIDKey_s
			C_TEXT:C284(v_77_002_txt)  //ConsltName
			ARRAY TEXT:C222(v_77_002_atxt; 0)  //ConsltName
			C_TEXT:C284(v_77_003_txt)  //ContactFName
			ARRAY TEXT:C222(v_77_003_atxt; 0)  //ContactFName
			C_TEXT:C284(v_77_004_txt)  //ContactLName
			ARRAY TEXT:C222(v_77_004_atxt; 0)  //ContactLName
			C_TEXT:C284(v_77_005_txt)  //ContactMName
			ARRAY TEXT:C222(v_77_005_atxt; 0)  //ContactMName
			C_TEXT:C284(v_77_006_txt)  //ContactPrefix
			ARRAY TEXT:C222(v_77_006_atxt; 0)  //ContactPrefix
			C_TEXT:C284(v_77_007_txt)  //ContactTitle
			ARRAY TEXT:C222(v_77_007_atxt; 0)  //ContactTitle
			C_TEXT:C284(v_77_008_txt)  //Street1
			ARRAY TEXT:C222(v_77_008_atxt; 0)  //Street1
			C_TEXT:C284(v_77_009_txt)  //Street2
			ARRAY TEXT:C222(v_77_009_atxt; 0)  //Street2
			C_TEXT:C284(v_77_010_txt)  //City
			ARRAY TEXT:C222(v_77_010_atxt; 0)  //City
			C_TEXT:C284(v_77_011_txt)  //State
			ARRAY TEXT:C222(v_77_011_atxt; 0)  //State
			C_TEXT:C284(v_77_012_txt)  //Zip
			ARRAY TEXT:C222(v_77_012_atxt; 0)  //Zip
			C_TEXT:C284(v_77_013_txt)  //PhoneNo1
			ARRAY TEXT:C222(v_77_013_atxt; 0)  //PhoneNo1
			C_TEXT:C284(v_77_014_txt)  //PhoneNo2
			ARRAY TEXT:C222(v_77_014_atxt; 0)  //PhoneNo2
			C_TEXT:C284(v_77_015_txt)  //PhoneNo3
			ARRAY TEXT:C222(v_77_015_atxt; 0)  //PhoneNo3
			C_TEXT:C284(v_77_016_txt)  //FaxNo1
			ARRAY TEXT:C222(v_77_016_atxt; 0)  //FaxNo1
			C_TEXT:C284(v_77_017_txt)  //FaxNo2
			ARRAY TEXT:C222(v_77_017_atxt; 0)  //FaxNo2
			C_TEXT:C284(v_77_018_txt)  //Email
			ARRAY TEXT:C222(v_77_018_atxt; 0)  //Email
			C_LONGINT:C283(v_77_001_L)  //ConsltAddressID
			ARRAY LONGINT:C221(v_77_001_aL; 0)  //ConsltAddressID
			C_LONGINT:C283(v_77_022_L)  //ConsultantNameID_l
			ARRAY LONGINT:C221(v_77_022_aL; 0)  //ConsultantNameID_l
			C_BOOLEAN:C305(v_77_019_b)  //Func_Rating
			ARRAY BOOLEAN:C223(v_77_019_ab; 0)  //Func_Rating
			C_BOOLEAN:C305(v_77_020_b)  //Func_Insp
			ARRAY BOOLEAN:C223(v_77_020_ab; 0)  //Func_Insp
			C_BOOLEAN:C305(v_77_021_b)  //Func_Design
			ARRAY BOOLEAN:C223(v_77_021_ab; 0)  //Func_Design
		: ($1=78)  //Town Address
			C_TEXT:C284(v_78_016_txt)  //Town_Address_UUIDKey_s
			ARRAY TEXT:C222(v_78_016_atxt; 0)  //Town_Address_UUIDKey_s
			C_TEXT:C284(v_78_002_txt)  //TownName
			ARRAY TEXT:C222(v_78_002_atxt; 0)  //TownName
			C_TEXT:C284(v_78_003_txt)  //AddressedTo
			ARRAY TEXT:C222(v_78_003_atxt; 0)  //AddressedTo
			C_TEXT:C284(v_78_004_txt)  //OfficialTownName
			ARRAY TEXT:C222(v_78_004_atxt; 0)  //OfficialTownName
			C_TEXT:C284(v_78_005_txt)  //Street
			ARRAY TEXT:C222(v_78_005_atxt; 0)  //Street
			C_TEXT:C284(v_78_006_txt)  //State
			ARRAY TEXT:C222(v_78_006_atxt; 0)  //State
			C_TEXT:C284(v_78_007_txt)  //Zip
			ARRAY TEXT:C222(v_78_007_atxt; 0)  //Zip
			C_TEXT:C284(v_78_008_txt)  //ContactFName
			ARRAY TEXT:C222(v_78_008_atxt; 0)  //ContactFName
			C_TEXT:C284(v_78_009_txt)  //ContactLName
			ARRAY TEXT:C222(v_78_009_atxt; 0)  //ContactLName
			C_TEXT:C284(v_78_010_txt)  //ContactMName
			ARRAY TEXT:C222(v_78_010_atxt; 0)  //ContactMName
			C_TEXT:C284(v_78_011_txt)  //ContactTitle
			ARRAY TEXT:C222(v_78_011_atxt; 0)  //ContactTitle
			C_TEXT:C284(v_78_012_txt)  //ContactPrefix
			ARRAY TEXT:C222(v_78_012_atxt; 0)  //ContactPrefix
			C_TEXT:C284(v_78_013_txt)  //ContactPhone
			ARRAY TEXT:C222(v_78_013_atxt; 0)  //ContactPhone
			C_TEXT:C284(v_78_014_txt)  //ContactFax
			ARRAY TEXT:C222(v_78_014_atxt; 0)  //ContactFax
			C_TEXT:C284(v_78_015_txt)  //ContactEmail
			ARRAY TEXT:C222(v_78_015_atxt; 0)  //ContactEmail
			C_TEXT:C284(v_78_017_txt)  //TownBDEPTPrefix
			ARRAY TEXT:C222(v_78_017_atxt; 0)  //TownBDEPTPrefix
			C_LONGINT:C283(v_78_001_L)  //TownAddressID
			ARRAY LONGINT:C221(v_78_001_aL; 0)  //TownAddressID
		: ($1=79)  //Contracts
			C_TEXT:C284(v_79_031_txt)  //Contracts_UUIDKey_s
			ARRAY TEXT:C222(v_79_031_atxt; 0)  //Contracts_UUIDKey_s
			C_TEXT:C284(v_79_001_txt)  //ContractNo
			ARRAY TEXT:C222(v_79_001_atxt; 0)  //ContractNo
			C_TEXT:C284(v_79_002_txt)  //ContractType
			ARRAY TEXT:C222(v_79_002_atxt; 0)  //ContractType
			C_TEXT:C284(v_79_003_txt)  //ConsltName
			ARRAY TEXT:C222(v_79_003_atxt; 0)  //ConsltName
			C_TEXT:C284(v_79_007_txt)  //ContractStatus
			ARRAY TEXT:C222(v_79_007_atxt; 0)  //ContractStatus
			C_TEXT:C284(v_79_009_txt)  //FederalAidNo
			ARRAY TEXT:C222(v_79_009_atxt; 0)  //FederalAidNo
			C_TEXT:C284(v_79_022_txt)  //CheckWithAuditComment
			ARRAY TEXT:C222(v_79_022_atxt; 0)  //CheckWithAuditComment
			C_TEXT:C284(v_79_024_txt)  //CertificateOfCompletionCmnt
			ARRAY TEXT:C222(v_79_024_atxt; 0)  //CertificateOfCompletionCmnt
			C_TEXT:C284(v_79_026_txt)  //ReincumbrancesComment
			ARRAY TEXT:C222(v_79_026_atxt; 0)  //ReincumbrancesComment
			C_TEXT:C284(v_79_028_txt)  //ProcessRetainageComment
			ARRAY TEXT:C222(v_79_028_atxt; 0)  //ProcessRetainageComment
			C_REAL:C285(v_79_010_r)  //OverheadRate
			ARRAY REAL:C219(v_79_010_ar; 0)  //OverheadRate
			C_REAL:C285(v_79_011_r)  //NetFeeRate
			ARRAY REAL:C219(v_79_011_ar; 0)  //NetFeeRate
			C_REAL:C285(v_79_012_r)  //InitContractTotal
			ARRAY REAL:C219(v_79_012_ar; 0)  //InitContractTotal
			C_REAL:C285(v_79_013_r)  //InitContractSalary
			ARRAY REAL:C219(v_79_013_ar; 0)  //InitContractSalary
			C_REAL:C285(v_79_014_r)  //InitContractTotalLimitFee
			ARRAY REAL:C219(v_79_014_ar; 0)  //InitContractTotalLimitFee
			C_REAL:C285(v_79_015_r)  //InitContractTotDirctExpense
			ARRAY REAL:C219(v_79_015_ar; 0)  //InitContractTotDirctExpense
			C_REAL:C285(v_79_016_r)  //TotalEncumbered
			ARRAY REAL:C219(v_79_016_ar; 0)  //TotalEncumbered
			C_REAL:C285(v_79_017_r)  //ApproxSpent
			ARRAY REAL:C219(v_79_017_ar; 0)  //ApproxSpent
			C_REAL:C285(v_79_018_r)  //ActualSpent
			ARRAY REAL:C219(v_79_018_ar; 0)  //ActualSpent
			C_REAL:C285(v_79_019_r)  //ApproxRemainingFund
			ARRAY REAL:C219(v_79_019_ar; 0)  //ApproxRemainingFund
			C_REAL:C285(v_79_020_r)  //ActualRemainingFund
			ARRAY REAL:C219(v_79_020_ar; 0)  //ActualRemainingFund
			C_REAL:C285(v_79_030_r)  //MaxHourlyRate
			ARRAY REAL:C219(v_79_030_ar; 0)  //MaxHourlyRate
			C_LONGINT:C283(v_79_029_L)  //ContractID
			ARRAY LONGINT:C221(v_79_029_aL; 0)  //ContractID
			C_DATE:C307(v_79_004_d)  //AwardContractDate
			ARRAY DATE:C224(v_79_004_ad; 0)  //AwardContractDate
			C_DATE:C307(v_79_005_d)  //InitialCompleteDate
			ARRAY DATE:C224(v_79_005_ad; 0)  //InitialCompleteDate
			C_DATE:C307(v_79_006_d)  //ExtendedCompleteDate
			ARRAY DATE:C224(v_79_006_ad; 0)  //ExtendedCompleteDate
			C_BOOLEAN:C305(v_79_008_b)  //FederalFund
			ARRAY BOOLEAN:C223(v_79_008_ab; 0)  //FederalFund
			C_BOOLEAN:C305(v_79_021_b)  //CheckWithAudit
			ARRAY BOOLEAN:C223(v_79_021_ab; 0)  //CheckWithAudit
			C_BOOLEAN:C305(v_79_023_b)  //CertificateOfCompletion
			ARRAY BOOLEAN:C223(v_79_023_ab; 0)  //CertificateOfCompletion
			C_BOOLEAN:C305(v_79_025_b)  //Reincumbrances
			ARRAY BOOLEAN:C223(v_79_025_ab; 0)  //Reincumbrances
			C_BOOLEAN:C305(v_79_027_b)  //ProcessRetainage
			ARRAY BOOLEAN:C223(v_79_027_ab; 0)  //ProcessRetainage
		: ($1=80)  //Contract FundTransfer
			C_TEXT:C284(v_80_009_txt)  //Contract_FundTransfer_UUIDKey_s
			ARRAY TEXT:C222(v_80_009_atxt; 0)  //Contract_FundTransfer_UUIDKey_s
			C_TEXT:C284(v_80_001_txt)  //ContractNo
			ARRAY TEXT:C222(v_80_001_atxt; 0)  //ContractNo
			C_TEXT:C284(v_80_006_txt)  //TransferDirection
			ARRAY TEXT:C222(v_80_006_atxt; 0)  //TransferDirection
			C_REAL:C285(v_80_007_r)  //TransferAmount
			ARRAY REAL:C219(v_80_007_ar; 0)  //TransferAmount
			C_LONGINT:C283(v_80_002_L)  //TOF_ID
			ARRAY LONGINT:C221(v_80_002_aL; 0)  //TOF_ID
			C_DATE:C307(v_80_003_d)  //DateCsltLetter
			ARRAY DATE:C224(v_80_003_ad; 0)  //DateCsltLetter
			C_DATE:C307(v_80_004_d)  //DateDocSentToContracts
			ARRAY DATE:C224(v_80_004_ad; 0)  //DateDocSentToContracts
			C_DATE:C307(v_80_005_d)  //DateApproval
			ARRAY DATE:C224(v_80_005_ad; 0)  //DateApproval
			C_BOOLEAN:C305(v_80_008_b)  //DeleteMe
			ARRAY BOOLEAN:C223(v_80_008_ab; 0)  //DeleteMe
		: ($1=81)  //Contract ExtendTime
			C_TEXT:C284(v_81_008_txt)  //Contract_ExtendTime_UUIDKey_s
			ARRAY TEXT:C222(v_81_008_atxt; 0)  //Contract_ExtendTime_UUIDKey_s
			C_TEXT:C284(v_81_001_txt)  //ContractNo
			ARRAY TEXT:C222(v_81_001_atxt; 0)  //ContractNo
			C_LONGINT:C283(v_81_002_L)  //EOT_ID
			ARRAY LONGINT:C221(v_81_002_aL; 0)  //EOT_ID
			C_DATE:C307(v_81_003_d)  //DateCsltLetter
			ARRAY DATE:C224(v_81_003_ad; 0)  //DateCsltLetter
			C_DATE:C307(v_81_004_d)  //DateDocSentToContracts
			ARRAY DATE:C224(v_81_004_ad; 0)  //DateDocSentToContracts
			C_DATE:C307(v_81_005_d)  //DateBoardAction
			ARRAY DATE:C224(v_81_005_ad; 0)  //DateBoardAction
			C_DATE:C307(v_81_006_d)  //InitialDate
			ARRAY DATE:C224(v_81_006_ad; 0)  //InitialDate
			C_DATE:C307(v_81_007_d)  //ExtendedDate
			ARRAY DATE:C224(v_81_007_ad; 0)  //ExtendedDate
		: ($1=82)  //Contract AddFund
			C_TEXT:C284(v_82_009_txt)  //Contract_AddFund_UUIDKey_s
			ARRAY TEXT:C222(v_82_009_atxt; 0)  //Contract_AddFund_UUIDKey_s
			C_TEXT:C284(v_82_001_txt)  //ContractNo
			ARRAY TEXT:C222(v_82_001_atxt; 0)  //ContractNo
			C_REAL:C285(v_82_006_r)  //TotalLimitFee
			ARRAY REAL:C219(v_82_006_ar; 0)  //TotalLimitFee
			C_REAL:C285(v_82_007_r)  //DirectExpense
			ARRAY REAL:C219(v_82_007_ar; 0)  //DirectExpense
			C_REAL:C285(v_82_008_r)  //Total
			ARRAY REAL:C219(v_82_008_ar; 0)  //Total
			C_LONGINT:C283(v_82_002_L)  //AddFund_ID
			ARRAY LONGINT:C221(v_82_002_aL; 0)  //AddFund_ID
			C_DATE:C307(v_82_003_d)  //DateCsltLetter
			ARRAY DATE:C224(v_82_003_ad; 0)  //DateCsltLetter
			C_DATE:C307(v_82_004_d)  //DateDocSentToContracts
			ARRAY DATE:C224(v_82_004_ad; 0)  //DateDocSentToContracts
			C_DATE:C307(v_82_005_d)  //DateApproval
			ARRAY DATE:C224(v_82_005_ad; 0)  //DateApproval
		: ($1=83)  //Contract Assignments
			C_TEXT:C284(v_83_024_txt)  //Contract_Assignments_UUIDKey_s
			ARRAY TEXT:C222(v_83_024_atxt; 0)  //Contract_Assignments_UUIDKey_s
			C_TEXT:C284(v_83_001_txt)  //ContractNo
			ARRAY TEXT:C222(v_83_001_atxt; 0)  //ContractNo
			C_TEXT:C284(v_83_019_txt)  //Comments
			ARRAY TEXT:C222(v_83_019_atxt; 0)  //Comments
			C_TEXT:C284(v_83_020_txt)  //AcutalOrEstimate
			ARRAY TEXT:C222(v_83_020_atxt; 0)  //AcutalOrEstimate
			C_REAL:C285(v_83_004_r)  //Actual_Salary
			ARRAY REAL:C219(v_83_004_ar; 0)  //Actual_Salary
			C_REAL:C285(v_83_005_r)  //Actual_IndirectCost
			ARRAY REAL:C219(v_83_005_ar; 0)  //Actual_IndirectCost
			C_REAL:C285(v_83_006_r)  //Actual_NetFee
			ARRAY REAL:C219(v_83_006_ar; 0)  //Actual_NetFee
			C_REAL:C285(v_83_007_r)  //Actual_TotalLimitFee
			ARRAY REAL:C219(v_83_007_ar; 0)  //Actual_TotalLimitFee
			C_REAL:C285(v_83_008_r)  //Actual_DirectExpense
			ARRAY REAL:C219(v_83_008_ar; 0)  //Actual_DirectExpense
			C_REAL:C285(v_83_009_r)  //Actual_Total
			ARRAY REAL:C219(v_83_009_ar; 0)  //Actual_Total
			C_REAL:C285(v_83_010_r)  //Est_Salary
			ARRAY REAL:C219(v_83_010_ar; 0)  //Est_Salary
			C_REAL:C285(v_83_011_r)  //Est_IndirectCost
			ARRAY REAL:C219(v_83_011_ar; 0)  //Est_IndirectCost
			C_REAL:C285(v_83_012_r)  //Est_NetFee
			ARRAY REAL:C219(v_83_012_ar; 0)  //Est_NetFee
			C_REAL:C285(v_83_013_r)  //Est_TotalLimitFee
			ARRAY REAL:C219(v_83_013_ar; 0)  //Est_TotalLimitFee
			C_REAL:C285(v_83_014_r)  //Est_DirectExpense
			ARRAY REAL:C219(v_83_014_ar; 0)  //Est_DirectExpense
			C_REAL:C285(v_83_015_r)  //Est_Total
			ARRAY REAL:C219(v_83_015_ar; 0)  //Est_Total
			C_REAL:C285(v_83_022_r)  //NetFeeRate
			ARRAY REAL:C219(v_83_022_ar; 0)  //NetFeeRate
			C_REAL:C285(v_83_023_r)  //OverHeadRate
			ARRAY REAL:C219(v_83_023_ar; 0)  //OverHeadRate
			C_LONGINT:C283(v_83_002_L)  //AssignNo
			ARRAY INTEGER:C220(v_83_002_ai; 0)  //AssignNo
			C_LONGINT:C283(v_83_003_L)  //AssignID
			ARRAY LONGINT:C221(v_83_003_aL; 0)  //AssignID
			C_DATE:C307(v_83_016_d)  //ReqFeeProposalDate
			ARRAY DATE:C224(v_83_016_ad; 0)  //ReqFeeProposalDate
			C_DATE:C307(v_83_017_d)  //NTPdate_written
			ARRAY DATE:C224(v_83_017_ad; 0)  //NTPdate_written
			C_DATE:C307(v_83_018_d)  //NTPdate_verbal
			ARRAY DATE:C224(v_83_018_ad; 0)  //NTPdate_verbal
			C_DATE:C307(v_83_025_d)  //ReqFeeProposalRcd
			ARRAY DATE:C224(v_83_025_ad; 0)  //ReqFeeProposalRcd
			C_BOOLEAN:C305(v_83_021_b)  //SpecialAssignment
			ARRAY BOOLEAN:C223(v_83_021_ab; 0)  //SpecialAssignment
		: ($1=84)  //Contract Invoice
			C_TEXT:C284(v_84_014_txt)  //Contract_Invoice_UUIDKey_s
			ARRAY TEXT:C222(v_84_014_atxt; 0)  //Contract_Invoice_UUIDKey_s
			C_TEXT:C284(v_84_003_txt)  //ContractNo
			ARRAY TEXT:C222(v_84_003_atxt; 0)  //ContractNo
			C_TEXT:C284(v_84_013_txt)  //Comments
			ARRAY TEXT:C222(v_84_013_atxt; 0)  //Comments
			C_REAL:C285(v_84_008_r)  //AssignPercentage
			ARRAY REAL:C219(v_84_008_ar; 0)  //AssignPercentage
			C_REAL:C285(v_84_011_r)  //TotalAmount
			ARRAY REAL:C219(v_84_011_ar; 0)  //TotalAmount
			C_LONGINT:C283(v_84_007_L)  //AssignNo
			ARRAY INTEGER:C220(v_84_007_ai; 0)  //AssignNo
			C_LONGINT:C283(v_84_001_L)  //InvoiceID
			ARRAY LONGINT:C221(v_84_001_aL; 0)  //InvoiceID
			C_LONGINT:C283(v_84_002_L)  //InvoiceNo
			ARRAY LONGINT:C221(v_84_002_aL; 0)  //InvoiceNo
			C_DATE:C307(v_84_004_d)  //DateReceived
			ARRAY DATE:C224(v_84_004_ad; 0)  //DateReceived
			C_DATE:C307(v_84_005_d)  //DateServiceFrom
			ARRAY DATE:C224(v_84_005_ad; 0)  //DateServiceFrom
			C_DATE:C307(v_84_006_d)  //DateServiceTo
			ARRAY DATE:C224(v_84_006_ad; 0)  //DateServiceTo
			C_DATE:C307(v_84_009_d)  //DateProcessFoward
			ARRAY DATE:C224(v_84_009_ad; 0)  //DateProcessFoward
			C_DATE:C307(v_84_010_d)  //DateSentBackToConslt
			ARRAY DATE:C224(v_84_010_ad; 0)  //DateSentBackToConslt
			C_BOOLEAN:C305(v_84_012_b)  //Accepted
			ARRAY BOOLEAN:C223(v_84_012_ab; 0)  //Accepted
		: ($1=85)  //Contract Invoice AssignNo
			C_TEXT:C284(v_85_004_txt)  //Contract_Invoice_Assi_UUIDKey_s
			ARRAY TEXT:C222(v_85_004_atxt; 0)  //Contract_Invoice_Assi_UUIDKey_s
			C_REAL:C285(v_85_003_r)  //Percent
			ARRAY REAL:C219(v_85_003_ar; 0)  //Percent
			C_LONGINT:C283(v_85_002_L)  //AssignNo
			ARRAY INTEGER:C220(v_85_002_ai; 0)  //AssignNo
			C_LONGINT:C283(v_85_001_L)  //InvoiceID
			ARRAY LONGINT:C221(v_85_001_aL; 0)  //InvoiceID
		: ($1=86)  //Templates
			C_BLOB:C604(v_86_003_blb)  //Template_
			ARRAY BLOB:C1222(v_86_003_ablb; 0)  //Template_
			C_TEXT:C284(v_86_007_txt)  //Templates_UUIDKey_s
			ARRAY TEXT:C222(v_86_007_atxt; 0)  //Templates_UUIDKey_s
			C_TEXT:C284(v_86_002_txt)  //TemplateName
			ARRAY TEXT:C222(v_86_002_atxt; 0)  //TemplateName
			C_TEXT:C284(v_86_004_txt)  //TemplateDesc
			ARRAY TEXT:C222(v_86_004_atxt; 0)  //TemplateDesc
			C_LONGINT:C283(v_86_001_L)  //TemplateID
			ARRAY LONGINT:C221(v_86_001_aL; 0)  //TemplateID
			C_BOOLEAN:C305(v_86_005_b)  //Field5
			ARRAY BOOLEAN:C223(v_86_005_ab; 0)  //Field5
			C_BOOLEAN:C305(v_86_006_b)  //Field6
			ARRAY BOOLEAN:C223(v_86_006_ab; 0)  //Field6
		: ($1=87)  //ServerProcesses
			C_TEXT:C284(v_87_007_txt)  //ServerProcesses_UUIDKey_s
			ARRAY TEXT:C222(v_87_007_atxt; 0)  //ServerProcesses_UUIDKey_s
			C_TEXT:C284(v_87_001_txt)  //ProcessName_s
			ARRAY TEXT:C222(v_87_001_atxt; 0)  //ProcessName_s
			C_TEXT:C284(v_87_002_txt)  //ProcessRunSchedule_s
			ARRAY TEXT:C222(v_87_002_atxt; 0)  //ProcessRunSchedule_s
			C_TEXT:C284(v_87_003_txt)  //LastRunTimeStamp_s
			ARRAY TEXT:C222(v_87_003_atxt; 0)  //LastRunTimeStamp_s
			C_TEXT:C284(v_87_004_txt)  //NextRunTimeStamp_s
			ARRAY TEXT:C222(v_87_004_atxt; 0)  //NextRunTimeStamp_s
			C_LONGINT:C283(v_87_006_L)  //ControlProcessDelay_l
			ARRAY LONGINT:C221(v_87_006_aL; 0)  //ControlProcessDelay_l
			C_BOOLEAN:C305(v_87_005_b)  //ProcessRunning_b
			ARRAY BOOLEAN:C223(v_87_005_ab; 0)  //ProcessRunning_b
		: ($1=88)  //ClientAccess
			C_TEXT:C284(v_88_006_txt)  //ClientAccess_UUIDKey_s
			ARRAY TEXT:C222(v_88_006_atxt; 0)  //ClientAccess_UUIDKey_s
			C_TEXT:C284(v_88_001_txt)  //CA_Message_txt
			ARRAY TEXT:C222(v_88_001_atxt; 0)  //CA_Message_txt
			C_TEXT:C284(v_88_002_txt)  //CA_MessageStart_s
			ARRAY TEXT:C222(v_88_002_atxt; 0)  //CA_MessageStart_s
			C_TEXT:C284(v_88_003_txt)  //CA_LimitAccess_s
			ARRAY TEXT:C222(v_88_003_atxt; 0)  //CA_LimitAccess_s
			C_BOOLEAN:C305(v_88_004_b)  //CA_DisableLogins_b
			ARRAY BOOLEAN:C223(v_88_004_ab; 0)  //CA_DisableLogins_b
			C_BOOLEAN:C305(v_88_005_b)  //CA_Completed_b
			ARRAY BOOLEAN:C223(v_88_005_ab; 0)  //CA_Completed_b
		: ($1=89)  //SD_History
			C_TEXT:C284(v_89_020_txt)  //SD_History_UUIDKey_s
			ARRAY TEXT:C222(v_89_020_atxt; 0)  //SD_History_UUIDKey_s
			C_TEXT:C284(v_89_001_txt)  //Bin
			ARRAY TEXT:C222(v_89_001_atxt; 0)  //Bin
			C_TEXT:C284(v_89_002_txt)  //SD_Year
			ARRAY TEXT:C222(v_89_002_atxt; 0)  //SD_Year
			C_TEXT:C284(v_89_003_txt)  //SD_Month
			ARRAY TEXT:C222(v_89_003_atxt; 0)  //SD_Month
			C_TEXT:C284(v_89_004_txt)  //BDEPT
			ARRAY TEXT:C222(v_89_004_atxt; 0)  //BDEPT
			C_TEXT:C284(v_89_005_txt)  //Town Name
			ARRAY TEXT:C222(v_89_005_atxt; 0)  //Town Name
			C_TEXT:C284(v_89_006_txt)  //Item8
			ARRAY TEXT:C222(v_89_006_atxt; 0)  //Item8
			C_TEXT:C284(v_89_007_txt)  //Item7
			ARRAY TEXT:C222(v_89_007_atxt; 0)  //Item7
			C_TEXT:C284(v_89_008_txt)  //Item6A
			ARRAY TEXT:C222(v_89_008_atxt; 0)  //Item6A
			C_TEXT:C284(v_89_009_txt)  //Item58
			ARRAY TEXT:C222(v_89_009_atxt; 0)  //Item58
			C_TEXT:C284(v_89_010_txt)  //Item59
			ARRAY TEXT:C222(v_89_010_atxt; 0)  //Item59
			C_TEXT:C284(v_89_011_txt)  //Item60
			ARRAY TEXT:C222(v_89_011_atxt; 0)  //Item60
			C_TEXT:C284(v_89_012_txt)  //Item2
			ARRAY TEXT:C222(v_89_012_atxt; 0)  //Item2
			C_TEXT:C284(v_89_014_txt)  //Item21
			ARRAY TEXT:C222(v_89_014_atxt; 0)  //Item21
			C_TEXT:C284(v_89_015_txt)  //Item41
			ARRAY TEXT:C222(v_89_015_atxt; 0)  //Item41
			C_TEXT:C284(v_89_016_txt)  //SD_DefectAddRemoveStatus_s
			ARRAY TEXT:C222(v_89_016_atxt; 0)  //SD_DefectAddRemoveStatus_s
			C_TEXT:C284(v_89_017_txt)  //SD_Owner_s
			ARRAY TEXT:C222(v_89_017_atxt; 0)  //SD_Owner_s
			C_TEXT:C284(v_89_018_txt)  //SD_PostedAddRemoveStatus_s
			ARRAY TEXT:C222(v_89_018_atxt; 0)  //SD_PostedAddRemoveStatus_s
			C_TEXT:C284(v_89_019_txt)  //SD_PreviousOwner_s
			ARRAY TEXT:C222(v_89_019_atxt; 0)  //SD_PreviousOwner_s
			C_REAL:C285(v_89_013_r)  //AASHTO
			ARRAY REAL:C219(v_89_013_ar; 0)  //AASHTO
		: ($1=90)  //Combined Inspections
			C_TEXT:C284(v_90_007_txt)  //Combined_Inspections_UUIDKey_s
			ARRAY TEXT:C222(v_90_007_atxt; 0)  //Combined_Inspections_UUIDKey_s
			C_TEXT:C284(v_90_001_txt)  //BIN
			ARRAY TEXT:C222(v_90_001_atxt; 0)  //BIN
			C_TEXT:C284(v_90_005_txt)  //InspType
			ARRAY TEXT:C222(v_90_005_atxt; 0)  //InspType
			C_LONGINT:C283(v_90_002_L)  //NBISInspID
			ARRAY LONGINT:C221(v_90_002_aL; 0)  //NBISInspID
			C_LONGINT:C283(v_90_003_L)  //BMSInspID
			ARRAY LONGINT:C221(v_90_003_aL; 0)  //BMSInspID
			C_LONGINT:C283(v_90_006_L)  //ID
			ARRAY LONGINT:C221(v_90_006_aL; 0)  //ID
			C_DATE:C307(v_90_004_d)  //InspDate
			ARRAY DATE:C224(v_90_004_ad; 0)  //InspDate
		: ($1=91)  //ACTMODLS
			C_TEXT:C284(v_91_017_txt)  //ACTMODLS_UUIDKey_s
			ARRAY TEXT:C222(v_91_017_atxt; 0)  //ACTMODLS_UUIDKey_s
			C_TEXT:C284(v_91_001_txt)  //MOKEY
			ARRAY TEXT:C222(v_91_001_atxt; 0)  //MOKEY
			C_REAL:C285(v_91_006_r)  //DETWEIGHT
			ARRAY REAL:C219(v_91_006_ar; 0)  //DETWEIGHT
			C_REAL:C285(v_91_007_r)  //COSTWEIGHT
			ARRAY REAL:C219(v_91_007_ar; 0)  //COSTWEIGHT
			C_REAL:C285(v_91_008_r)  //PROB1
			ARRAY REAL:C219(v_91_008_ar; 0)  //PROB1
			C_REAL:C285(v_91_009_r)  //PROB2
			ARRAY REAL:C219(v_91_009_ar; 0)  //PROB2
			C_REAL:C285(v_91_010_r)  //PROB3
			ARRAY REAL:C219(v_91_010_ar; 0)  //PROB3
			C_REAL:C285(v_91_011_r)  //PROB4
			ARRAY REAL:C219(v_91_011_ar; 0)  //PROB4
			C_REAL:C285(v_91_012_r)  //PROB5
			ARRAY REAL:C219(v_91_012_ar; 0)  //PROB5
			C_REAL:C285(v_91_013_r)  //VARUNITCO
			ARRAY REAL:C219(v_91_013_ar; 0)  //VARUNITCO
			C_REAL:C285(v_91_014_r)  //FIXUNITCO
			ARRAY REAL:C219(v_91_014_ar; 0)  //FIXUNITCO
			C_REAL:C285(v_91_015_r)  //OPTFRAC
			ARRAY REAL:C219(v_91_015_ar; 0)  //OPTFRAC
			C_REAL:C285(v_91_016_r)  //LTCOST
			ARRAY REAL:C219(v_91_016_ar; 0)  //LTCOST
			C_LONGINT:C283(v_91_002_L)  //ELEMKEY
			ARRAY INTEGER:C220(v_91_002_ai; 0)  //ELEMKEY
			C_LONGINT:C283(v_91_003_L)  //SKEY
			ARRAY INTEGER:C220(v_91_003_ai; 0)  //SKEY
			C_LONGINT:C283(v_91_004_L)  //AKEY
			ARRAY INTEGER:C220(v_91_004_ai; 0)  //AKEY
			C_LONGINT:C283(v_91_005_L)  //ENVKEY
			ARRAY INTEGER:C220(v_91_005_ai; 0)  //ENVKEY
		: ($1=92)  //ELEMDEFS
			C_TEXT:C284(v_92_022_txt)  //ELEMDEFS_UUIDKey_s
			ARRAY TEXT:C222(v_92_022_atxt; 0)  //ELEMDEFS_UUIDKey_s
			C_TEXT:C284(v_92_002_txt)  //ECATKEY
			ARRAY TEXT:C222(v_92_002_atxt; 0)  //ECATKEY
			C_TEXT:C284(v_92_003_txt)  //ETYPKEY
			ARRAY TEXT:C222(v_92_003_atxt; 0)  //ETYPKEY
			C_TEXT:C284(v_92_004_txt)  //MATLKEY
			ARRAY TEXT:C222(v_92_004_atxt; 0)  //MATLKEY
			C_TEXT:C284(v_92_007_txt)  //COREFLAG
			ARRAY TEXT:C222(v_92_007_atxt; 0)  //COREFLAG
			C_TEXT:C284(v_92_008_txt)  //SMARTFLAG
			ARRAY TEXT:C222(v_92_008_atxt; 0)  //SMARTFLAG
			C_TEXT:C284(v_92_010_txt)  //USEPARMDLS
			ARRAY TEXT:C222(v_92_010_atxt; 0)  //USEPARMDLS
			C_TEXT:C284(v_92_011_txt)  //ELEMSHORT
			ARRAY TEXT:C222(v_92_011_atxt; 0)  //ELEMSHORT
			C_TEXT:C284(v_92_012_txt)  //ELEMLONG
			ARRAY TEXT:C222(v_92_012_atxt; 0)  //ELEMLONG
			C_TEXT:C284(v_92_014_txt)  //EACHFLAG
			ARRAY TEXT:C222(v_92_014_atxt; 0)  //EACHFLAG
			C_TEXT:C284(v_92_015_txt)  //PAINTFLAG
			ARRAY TEXT:C222(v_92_015_atxt; 0)  //PAINTFLAG
			C_TEXT:C284(v_92_016_txt)  //SCALESHORT
			ARRAY TEXT:C222(v_92_016_atxt; 0)  //SCALESHORT
			C_TEXT:C284(v_92_017_txt)  //SCALEUNIT
			ARRAY TEXT:C222(v_92_017_atxt; 0)  //SCALEUNIT
			C_TEXT:C284(v_92_019_txt)  //SCALEMET
			ARRAY TEXT:C222(v_92_019_atxt; 0)  //SCALEMET
			C_TEXT:C284(v_92_020_txt)  //DOCREFKEY
			ARRAY TEXT:C222(v_92_020_atxt; 0)  //DOCREFKEY
			C_TEXT:C284(v_92_021_txt)  //NOTES
			ARRAY TEXT:C222(v_92_021_atxt; 0)  //NOTES
			C_REAL:C285(v_92_005_r)  //PAIRCODE
			ARRAY REAL:C219(v_92_005_ar; 0)  //PAIRCODE
			C_REAL:C285(v_92_009_r)  //PARENT
			ARRAY REAL:C219(v_92_009_ar; 0)  //PARENT
			C_REAL:C285(v_92_018_r)  //ELEMWEIGHT
			ARRAY REAL:C219(v_92_018_ar; 0)  //ELEMWEIGHT
			C_LONGINT:C283(v_92_001_L)  //ELEMKEY
			ARRAY INTEGER:C220(v_92_001_ai; 0)  //ELEMKEY
			C_LONGINT:C283(v_92_006_L)  //ELEMNUM
			ARRAY INTEGER:C220(v_92_006_ai; 0)  //ELEMNUM
			C_LONGINT:C283(v_92_013_L)  //STATECNT
			ARRAY INTEGER:C220(v_92_013_ai; 0)  //STATECNT
		: ($1=93)  //CONDUMDL
			C_TEXT:C284(v_93_009_txt)  //CONDUMDL_UUIDKey_s
			ARRAY TEXT:C222(v_93_009_atxt; 0)  //CONDUMDL_UUIDKey_s
			C_TEXT:C284(v_93_001_txt)  //MOKEY
			ARRAY TEXT:C222(v_93_001_atxt; 0)  //MOKEY
			C_TEXT:C284(v_93_008_txt)  //OPTRUNSTATUS
			ARRAY TEXT:C222(v_93_008_atxt; 0)  //OPTRUNSTATUS
			C_REAL:C285(v_93_004_r)  //FAILPROB
			ARRAY REAL:C219(v_93_004_ar; 0)  //FAILPROB
			C_REAL:C285(v_93_005_r)  //FAILAGCYCO
			ARRAY REAL:C219(v_93_005_ar; 0)  //FAILAGCYCO
			C_REAL:C285(v_93_006_r)  //FAILUSERCO
			ARRAY REAL:C219(v_93_006_ar; 0)  //FAILUSERCO
			C_REAL:C285(v_93_007_r)  //OPTYRCOST
			ARRAY REAL:C219(v_93_007_ar; 0)  //OPTYRCOST
			C_LONGINT:C283(v_93_002_L)  //ELEMKEY
			ARRAY INTEGER:C220(v_93_002_ai; 0)  //ELEMKEY
			C_LONGINT:C283(v_93_003_L)  //ENVKEY
			ARRAY INTEGER:C220(v_93_003_ai; 0)  //ENVKEY
		: ($1=94)  //Invoice_AssignNo_Maintenance
			C_TEXT:C284(v_94_007_txt)  //Invoice_AssignNo_Main_UUIDKey_s
			ARRAY TEXT:C222(v_94_007_atxt; 0)  //Invoice_AssignNo_Main_UUIDKey_s
			C_REAL:C285(v_94_003_r)  //TotalLimFeeDes
			ARRAY REAL:C219(v_94_003_ar; 0)  //TotalLimFeeDes
			C_REAL:C285(v_94_004_r)  //TotalLimFeeConstr
			ARRAY REAL:C219(v_94_004_ar; 0)  //TotalLimFeeConstr
			C_REAL:C285(v_94_005_r)  //DirectExpense
			ARRAY REAL:C219(v_94_005_ar; 0)  //DirectExpense
			C_LONGINT:C283(v_94_002_L)  //AssignNo
			ARRAY INTEGER:C220(v_94_002_ai; 0)  //AssignNo
			C_LONGINT:C283(v_94_001_L)  //InvoiceID
			ARRAY LONGINT:C221(v_94_001_aL; 0)  //InvoiceID
			C_LONGINT:C283(v_94_006_L)  //ID
			ARRAY LONGINT:C221(v_94_006_aL; 0)  //ID
		: ($1=95)  //Invoice_Maintenance
			C_TEXT:C284(v_95_021_txt)  //Invoice_Maintenance_UUIDKey_s
			ARRAY TEXT:C222(v_95_021_atxt; 0)  //Invoice_Maintenance_UUIDKey_s
			C_TEXT:C284(v_95_003_txt)  //ContractNo
			ARRAY TEXT:C222(v_95_003_atxt; 0)  //ContractNo
			C_TEXT:C284(v_95_013_txt)  //Comments
			ARRAY TEXT:C222(v_95_013_atxt; 0)  //Comments
			C_REAL:C285(v_95_008_r)  //TotalLimFeeDes
			ARRAY REAL:C219(v_95_008_ar; 0)  //TotalLimFeeDes
			C_REAL:C285(v_95_011_r)  //TotalAmount
			ARRAY REAL:C219(v_95_011_ar; 0)  //TotalAmount
			C_REAL:C285(v_95_014_r)  //TotalLimFeeConstr
			ARRAY REAL:C219(v_95_014_ar; 0)  //TotalLimFeeConstr
			C_REAL:C285(v_95_015_r)  //DirectExpenses
			ARRAY REAL:C219(v_95_015_ar; 0)  //DirectExpenses
			C_REAL:C285(v_95_016_r)  //Retainage
			ARRAY REAL:C219(v_95_016_ar; 0)  //Retainage
			C_REAL:C285(v_95_017_r)  //CostRecovery
			ARRAY REAL:C219(v_95_017_ar; 0)  //CostRecovery
			C_REAL:C285(v_95_018_r)  //TotalHRS_r
			ARRAY REAL:C219(v_95_018_ar; 0)  //TotalHRS_r
			C_LONGINT:C283(v_95_007_L)  //AssignNo
			ARRAY INTEGER:C220(v_95_007_ai; 0)  //AssignNo
			C_LONGINT:C283(v_95_001_L)  //InvoiceID
			ARRAY LONGINT:C221(v_95_001_aL; 0)  //InvoiceID
			C_LONGINT:C283(v_95_002_L)  //InvoiceNo
			ARRAY LONGINT:C221(v_95_002_aL; 0)  //InvoiceNo
			C_LONGINT:C283(v_95_020_L)  //AssignID_L
			ARRAY LONGINT:C221(v_95_020_aL; 0)  //AssignID_L
			C_DATE:C307(v_95_004_d)  //DateReceived
			ARRAY DATE:C224(v_95_004_ad; 0)  //DateReceived
			C_DATE:C307(v_95_005_d)  //DateServiceFrom
			ARRAY DATE:C224(v_95_005_ad; 0)  //DateServiceFrom
			C_DATE:C307(v_95_006_d)  //DateServiceTo
			ARRAY DATE:C224(v_95_006_ad; 0)  //DateServiceTo
			C_DATE:C307(v_95_009_d)  //DateProcessFoward
			ARRAY DATE:C224(v_95_009_ad; 0)  //DateProcessFoward
			C_DATE:C307(v_95_010_d)  //DateSentBackToConslt
			ARRAY DATE:C224(v_95_010_ad; 0)  //DateSentBackToConslt
			C_DATE:C307(v_95_019_d)  //InvoiceDate_d
			ARRAY DATE:C224(v_95_019_ad; 0)  //InvoiceDate_d
			C_BOOLEAN:C305(v_95_012_b)  //Accepted
			ARRAY BOOLEAN:C223(v_95_012_ab; 0)  //Accepted
		: ($1=96)  //FundTransfer_Maintenance
			C_TEXT:C284(v_96_009_txt)  //FundTransfer_Maintena_UUIDKey_s
			ARRAY TEXT:C222(v_96_009_atxt; 0)  //FundTransfer_Maintena_UUIDKey_s
			C_TEXT:C284(v_96_001_txt)  //ContractNo
			ARRAY TEXT:C222(v_96_001_atxt; 0)  //ContractNo
			C_TEXT:C284(v_96_006_txt)  //TransferDirection
			ARRAY TEXT:C222(v_96_006_atxt; 0)  //TransferDirection
			C_REAL:C285(v_96_007_r)  //TransferAmount
			ARRAY REAL:C219(v_96_007_ar; 0)  //TransferAmount
			C_LONGINT:C283(v_96_002_L)  //TOF_ID
			ARRAY LONGINT:C221(v_96_002_aL; 0)  //TOF_ID
			C_DATE:C307(v_96_003_d)  //DateCsltLetter
			ARRAY DATE:C224(v_96_003_ad; 0)  //DateCsltLetter
			C_DATE:C307(v_96_004_d)  //DateDocSentToContracts
			ARRAY DATE:C224(v_96_004_ad; 0)  //DateDocSentToContracts
			C_DATE:C307(v_96_005_d)  //DateApproval
			ARRAY DATE:C224(v_96_005_ad; 0)  //DateApproval
			C_BOOLEAN:C305(v_96_008_b)  //DeleteMe
			ARRAY BOOLEAN:C223(v_96_008_ab; 0)  //DeleteMe
		: ($1=97)  //Contract_Maintenance
			C_TEXT:C284(v_97_034_txt)  //Contract_Maintenance_UUIDKey_s
			ARRAY TEXT:C222(v_97_034_atxt; 0)  //Contract_Maintenance_UUIDKey_s
			C_TEXT:C284(v_97_001_txt)  //ContractNo
			ARRAY TEXT:C222(v_97_001_atxt; 0)  //ContractNo
			C_TEXT:C284(v_97_003_txt)  //ConsultantName
			ARRAY TEXT:C222(v_97_003_atxt; 0)  //ConsultantName
			C_TEXT:C284(v_97_007_txt)  //ContractStatus
			ARRAY TEXT:C222(v_97_007_atxt; 0)  //ContractStatus
			C_TEXT:C284(v_97_008_txt)  //ContractType
			ARRAY TEXT:C222(v_97_008_atxt; 0)  //ContractType
			C_TEXT:C284(v_97_009_txt)  //FederalAidNo
			ARRAY TEXT:C222(v_97_009_atxt; 0)  //FederalAidNo
			C_TEXT:C284(v_97_022_txt)  //CheckWithAuditComment
			ARRAY TEXT:C222(v_97_022_atxt; 0)  //CheckWithAuditComment
			C_TEXT:C284(v_97_024_txt)  //CertificateOfCompletionCmnt
			ARRAY TEXT:C222(v_97_024_atxt; 0)  //CertificateOfCompletionCmnt
			C_TEXT:C284(v_97_026_txt)  //ReincumbrancesComment
			ARRAY TEXT:C222(v_97_026_atxt; 0)  //ReincumbrancesComment
			C_TEXT:C284(v_97_028_txt)  //ProcessRetainageComment
			ARRAY TEXT:C222(v_97_028_atxt; 0)  //ProcessRetainageComment
			C_TEXT:C284(v_97_033_txt)  //BridgePrjMgr
			ARRAY TEXT:C222(v_97_033_atxt; 0)  //BridgePrjMgr
			C_REAL:C285(v_97_010_r)  //OverheadRate
			ARRAY REAL:C219(v_97_010_ar; 0)  //OverheadRate
			C_REAL:C285(v_97_011_r)  //NetFeeRate
			ARRAY REAL:C219(v_97_011_ar; 0)  //NetFeeRate
			C_REAL:C285(v_97_012_r)  //InitContractTotal
			ARRAY REAL:C219(v_97_012_ar; 0)  //InitContractTotal
			C_REAL:C285(v_97_013_r)  //InitContractSalary
			ARRAY REAL:C219(v_97_013_ar; 0)  //InitContractSalary
			C_REAL:C285(v_97_014_r)  //InitContractTotalLimitFee
			ARRAY REAL:C219(v_97_014_ar; 0)  //InitContractTotalLimitFee
			C_REAL:C285(v_97_015_r)  //InitContractTotDirctExpense
			ARRAY REAL:C219(v_97_015_ar; 0)  //InitContractTotDirctExpense
			C_REAL:C285(v_97_016_r)  //TotalEncumbered
			ARRAY REAL:C219(v_97_016_ar; 0)  //TotalEncumbered
			C_REAL:C285(v_97_017_r)  //ApproxSpent
			ARRAY REAL:C219(v_97_017_ar; 0)  //ApproxSpent
			C_REAL:C285(v_97_018_r)  //ActualSpent
			ARRAY REAL:C219(v_97_018_ar; 0)  //ActualSpent
			C_REAL:C285(v_97_019_r)  //ApproxRemainingFund
			ARRAY REAL:C219(v_97_019_ar; 0)  //ApproxRemainingFund
			C_REAL:C285(v_97_020_r)  //ActualRemainingFund
			ARRAY REAL:C219(v_97_020_ar; 0)  //ActualRemainingFund
			C_REAL:C285(v_97_030_r)  //RetainageAmtInit
			ARRAY REAL:C219(v_97_030_ar; 0)  //RetainageAmtInit
			C_REAL:C285(v_97_031_r)  //RetainagePct
			ARRAY REAL:C219(v_97_031_ar; 0)  //RetainagePct
			C_REAL:C285(v_97_032_r)  //MaxHourlyRate
			ARRAY REAL:C219(v_97_032_ar; 0)  //MaxHourlyRate
			C_LONGINT:C283(v_97_002_L)  //ContractID
			ARRAY LONGINT:C221(v_97_002_aL; 0)  //ContractID
			C_DATE:C307(v_97_004_d)  //AwardContractDate
			ARRAY DATE:C224(v_97_004_ad; 0)  //AwardContractDate
			C_DATE:C307(v_97_005_d)  //InitialCompleteDate
			ARRAY DATE:C224(v_97_005_ad; 0)  //InitialCompleteDate
			C_DATE:C307(v_97_006_d)  //ExtendedCompleteDate
			ARRAY DATE:C224(v_97_006_ad; 0)  //ExtendedCompleteDate
			C_BOOLEAN:C305(v_97_021_b)  //CheckWithAudit
			ARRAY BOOLEAN:C223(v_97_021_ab; 0)  //CheckWithAudit
			C_BOOLEAN:C305(v_97_023_b)  //CertificateOfCompletion
			ARRAY BOOLEAN:C223(v_97_023_ab; 0)  //CertificateOfCompletion
			C_BOOLEAN:C305(v_97_025_b)  //Reincumbrances
			ARRAY BOOLEAN:C223(v_97_025_ab; 0)  //Reincumbrances
			C_BOOLEAN:C305(v_97_027_b)  //ProcessRetainage
			ARRAY BOOLEAN:C223(v_97_027_ab; 0)  //ProcessRetainage
			C_BOOLEAN:C305(v_97_029_b)  //FederalFund
			ARRAY BOOLEAN:C223(v_97_029_ab; 0)  //FederalFund
		: ($1=98)  //ExtendTime_Maintenance
			C_TEXT:C284(v_98_008_txt)  //ExtendTime_Maintenanc_UUIDKey_s
			ARRAY TEXT:C222(v_98_008_atxt; 0)  //ExtendTime_Maintenanc_UUIDKey_s
			C_TEXT:C284(v_98_001_txt)  //ContractNo
			ARRAY TEXT:C222(v_98_001_atxt; 0)  //ContractNo
			C_LONGINT:C283(v_98_002_L)  //EOT_ID
			ARRAY LONGINT:C221(v_98_002_aL; 0)  //EOT_ID
			C_DATE:C307(v_98_003_d)  //DateCsltLetter
			ARRAY DATE:C224(v_98_003_ad; 0)  //DateCsltLetter
			C_DATE:C307(v_98_004_d)  //DateDocSentToContracts
			ARRAY DATE:C224(v_98_004_ad; 0)  //DateDocSentToContracts
			C_DATE:C307(v_98_005_d)  //DateBoardAction
			ARRAY DATE:C224(v_98_005_ad; 0)  //DateBoardAction
			C_DATE:C307(v_98_006_d)  //InitialDate
			ARRAY DATE:C224(v_98_006_ad; 0)  //InitialDate
			C_DATE:C307(v_98_007_d)  //ExtendedDate
			ARRAY DATE:C224(v_98_007_ad; 0)  //ExtendedDate
		: ($1=99)  //AddFund_Maintenance
			C_TEXT:C284(v_99_010_txt)  //AddFund_Maintenance_UUIDKey_s
			ARRAY TEXT:C222(v_99_010_atxt; 0)  //AddFund_Maintenance_UUIDKey_s
			C_TEXT:C284(v_99_001_txt)  //ContractNo
			ARRAY TEXT:C222(v_99_001_atxt; 0)  //ContractNo
			C_REAL:C285(v_99_006_r)  //TotalLimitFee
			ARRAY REAL:C219(v_99_006_ar; 0)  //TotalLimitFee
			C_REAL:C285(v_99_007_r)  //DirectExpense
			ARRAY REAL:C219(v_99_007_ar; 0)  //DirectExpense
			C_REAL:C285(v_99_008_r)  //Total
			ARRAY REAL:C219(v_99_008_ar; 0)  //Total
			C_LONGINT:C283(v_99_002_L)  //AddFund_ID
			ARRAY LONGINT:C221(v_99_002_aL; 0)  //AddFund_ID
			C_LONGINT:C283(v_99_009_L)  //FiscalYear
			ARRAY LONGINT:C221(v_99_009_aL; 0)  //FiscalYear
			C_DATE:C307(v_99_003_d)  //DateCsltLetter
			ARRAY DATE:C224(v_99_003_ad; 0)  //DateCsltLetter
			C_DATE:C307(v_99_004_d)  //DateDocSentToContracts
			ARRAY DATE:C224(v_99_004_ad; 0)  //DateDocSentToContracts
			C_DATE:C307(v_99_005_d)  //DateApproval
			ARRAY DATE:C224(v_99_005_ad; 0)  //DateApproval
		: ($1=100)  //Contract_Project_Maintenance
			C_TEXT:C284(v_100_038_txt)  //Contract_Project_Main_UUIDKey_s
			ARRAY TEXT:C222(v_100_038_atxt; 0)  //Contract_Project_Main_UUIDKey_s
			C_TEXT:C284(v_100_002_txt)  //ContractNo
			ARRAY TEXT:C222(v_100_002_atxt; 0)  //ContractNo
			C_TEXT:C284(v_100_003_txt)  //Project Type
			ARRAY TEXT:C222(v_100_003_atxt; 0)  //Project Type
			C_TEXT:C284(v_100_004_txt)  //BridgeNo
			ARRAY TEXT:C222(v_100_004_atxt; 0)  //BridgeNo
			C_TEXT:C284(v_100_005_txt)  //BIN
			ARRAY TEXT:C222(v_100_005_atxt; 0)  //BIN
			C_TEXT:C284(v_100_006_txt)  //Location
			ARRAY TEXT:C222(v_100_006_atxt; 0)  //Location
			C_TEXT:C284(v_100_007_txt)  //Town
			ARRAY TEXT:C222(v_100_007_atxt; 0)  //Town
			C_TEXT:C284(v_100_008_txt)  //District
			ARRAY TEXT:C222(v_100_008_atxt; 0)  //District
			C_TEXT:C284(v_100_018_txt)  //Classification_s
			ARRAY TEXT:C222(v_100_018_atxt; 0)  //Classification_s
			C_TEXT:C284(v_100_036_txt)  //RecommConstr_txt
			ARRAY TEXT:C222(v_100_036_atxt; 0)  //RecommConstr_txt
			C_REAL:C285(v_100_010_r)  //Salary
			ARRAY REAL:C219(v_100_010_ar; 0)  //Salary
			C_REAL:C285(v_100_011_r)  //Overhead
			ARRAY REAL:C219(v_100_011_ar; 0)  //Overhead
			C_REAL:C285(v_100_012_r)  //Fee
			ARRAY REAL:C219(v_100_012_ar; 0)  //Fee
			C_REAL:C285(v_100_020_r)  //HWYEvalValue_r
			ARRAY REAL:C219(v_100_020_ar; 0)  //HWYEvalValue_r
			C_REAL:C285(v_100_027_r)  //OtherFactorsValue_r
			ARRAY REAL:C219(v_100_027_ar; 0)  //OtherFactorsValue_r
			C_REAL:C285(v_100_028_r)  //PrelimDecisValue_r
			ARRAY REAL:C219(v_100_028_ar; 0)  //PrelimDecisValue_r
			C_LONGINT:C283(v_100_009_L)  //AssignNo
			ARRAY INTEGER:C220(v_100_009_ai; 0)  //AssignNo
			C_LONGINT:C283(v_100_001_L)  //ProjectID
			ARRAY LONGINT:C221(v_100_001_aL; 0)  //ProjectID
			C_LONGINT:C283(v_100_013_L)  //AssignID
			ARRAY LONGINT:C221(v_100_013_aL; 0)  //AssignID
			C_LONGINT:C283(v_100_014_L)  //ADT_L
			ARRAY LONGINT:C221(v_100_014_aL; 0)  //ADT_L
			C_LONGINT:C283(v_100_015_L)  //ADTValue_L
			ARRAY LONGINT:C221(v_100_015_aL; 0)  //ADTValue_L
			C_LONGINT:C283(v_100_016_L)  //Detour_L
			ARRAY LONGINT:C221(v_100_016_aL; 0)  //Detour_L
			C_LONGINT:C283(v_100_017_L)  //DetourValue_L
			ARRAY LONGINT:C221(v_100_017_aL; 0)  //DetourValue_L
			C_LONGINT:C283(v_100_019_L)  //ClassificationValue_L
			ARRAY LONGINT:C221(v_100_019_aL; 0)  //ClassificationValue_L
			C_LONGINT:C283(v_100_022_L)  //EmergReplPts_L
			ARRAY LONGINT:C221(v_100_022_aL; 0)  //EmergReplPts_L
			C_LONGINT:C283(v_100_024_L)  //ActiveRRPts_L
			ARRAY LONGINT:C221(v_100_024_aL; 0)  //ActiveRRPts_L
			C_LONGINT:C283(v_100_026_L)  //EvacRoutePts_L
			ARRAY LONGINT:C221(v_100_026_aL; 0)  //EvacRoutePts_L
			C_BOOLEAN:C305(v_100_021_b)  //EmergRepl_b
			ARRAY BOOLEAN:C223(v_100_021_ab; 0)  //EmergRepl_b
			C_BOOLEAN:C305(v_100_023_b)  //ActiveRR_b
			ARRAY BOOLEAN:C223(v_100_023_ab; 0)  //ActiveRR_b
			C_BOOLEAN:C305(v_100_025_b)  //EvacRoute_b
			ARRAY BOOLEAN:C223(v_100_025_ab; 0)  //EvacRoute_b
			C_BOOLEAN:C305(v_100_029_b)  //StagingAvail_b
			ARRAY BOOLEAN:C223(v_100_029_ab; 0)  //StagingAvail_b
			C_BOOLEAN:C305(v_100_030_b)  //UtilRelocate_b
			ARRAY BOOLEAN:C223(v_100_030_ab; 0)  //UtilRelocate_b
			C_BOOLEAN:C305(v_100_031_b)  //BridgeClose_b
			ARRAY BOOLEAN:C223(v_100_031_ab; 0)  //BridgeClose_b
			C_BOOLEAN:C305(v_100_032_b)  //ABCOver30_b
			ARRAY BOOLEAN:C223(v_100_032_ab; 0)  //ABCOver30_b
			C_BOOLEAN:C305(v_100_033_b)  //PrefabDeliv_b
			ARRAY BOOLEAN:C223(v_100_033_ab; 0)  //PrefabDeliv_b
			C_BOOLEAN:C305(v_100_034_b)  //PrefabJustif_b
			ARRAY BOOLEAN:C223(v_100_034_ab; 0)  //PrefabJustif_b
			C_BOOLEAN:C305(v_100_035_b)  //PrefabCostLess_b
			ARRAY BOOLEAN:C223(v_100_035_ab; 0)  //PrefabCostLess_b
			C_BOOLEAN:C305(v_100_037_b)  //NeedSnowFence_b
			ARRAY BOOLEAN:C223(v_100_037_ab; 0)  //NeedSnowFence_b
		: ($1=101)  //Contract_Assignment_Maintenance
			C_TEXT:C284(v_101_085_txt)  //Contract_Assignment_M_UUIDKey_s
			ARRAY TEXT:C222(v_101_085_atxt; 0)  //Contract_Assignment_M_UUIDKey_s
			C_TEXT:C284(v_101_001_txt)  //ContractNo
			ARRAY TEXT:C222(v_101_001_atxt; 0)  //ContractNo
			C_TEXT:C284(v_101_004_txt)  //ProjectIS
			ARRAY TEXT:C222(v_101_004_atxt; 0)  //ProjectIS
			C_TEXT:C284(v_101_008_txt)  //Consultant
			ARRAY TEXT:C222(v_101_008_atxt; 0)  //Consultant
			C_TEXT:C284(v_101_019_txt)  //Comments
			ARRAY TEXT:C222(v_101_019_atxt; 0)  //Comments
			C_TEXT:C284(v_101_020_txt)  //AcutalOrEstimate
			ARRAY TEXT:C222(v_101_020_atxt; 0)  //AcutalOrEstimate
			C_TEXT:C284(v_101_035_txt)  //Description
			ARRAY TEXT:C222(v_101_035_atxt; 0)  //Description
			C_TEXT:C284(v_101_036_txt)  //ProjectType
			ARRAY TEXT:C222(v_101_036_atxt; 0)  //ProjectType
			C_TEXT:C284(v_101_037_txt)  //ExtendedDesc_txt
			ARRAY TEXT:C222(v_101_037_atxt; 0)  //ExtendedDesc_txt
			C_TEXT:C284(v_101_041_txt)  //InitialScope_d
			ARRAY TEXT:C222(v_101_041_atxt; 0)  //InitialScope_d
			C_TEXT:C284(v_101_052_txt)  //ProjectStatus_s
			ARRAY TEXT:C222(v_101_052_atxt; 0)  //ProjectStatus_s
			C_TEXT:C284(v_101_053_txt)  //Funding_s
			ARRAY TEXT:C222(v_101_053_atxt; 0)  //Funding_s
			C_TEXT:C284(v_101_060_txt)  //SurveyBy_s
			ARRAY TEXT:C222(v_101_060_atxt; 0)  //SurveyBy_s
			C_TEXT:C284(v_101_065_txt)  //SubConsultants_txt
			ARRAY TEXT:C222(v_101_065_atxt; 0)  //SubConsultants_txt
			C_TEXT:C284(v_101_067_txt)  //ConsultantScore_s
			ARRAY TEXT:C222(v_101_067_atxt; 0)  //ConsultantScore_s
			C_TEXT:C284(v_101_071_txt)  //Comments_25_txt
			ARRAY TEXT:C222(v_101_071_atxt; 0)  //Comments_25_txt
			C_TEXT:C284(v_101_072_txt)  //Comments_90_txt
			ARRAY TEXT:C222(v_101_072_atxt; 0)  //Comments_90_txt
			C_TEXT:C284(v_101_073_txt)  //Comments_PSE_txt
			ARRAY TEXT:C222(v_101_073_atxt; 0)  //Comments_PSE_txt
			C_TEXT:C284(v_101_075_txt)  //ProjectColor_s
			ARRAY TEXT:C222(v_101_075_atxt; 0)  //ProjectColor_s
			C_TEXT:C284(v_101_076_txt)  //DesignerDesignation_s
			ARRAY TEXT:C222(v_101_076_atxt; 0)  //DesignerDesignation_s
			C_TEXT:C284(v_101_077_txt)  //DistrictPM_s
			ARRAY TEXT:C222(v_101_077_atxt; 0)  //DistrictPM_s
			C_TEXT:C284(v_101_079_txt)  //LateAction_s
			ARRAY TEXT:C222(v_101_079_atxt; 0)  //LateAction_s
			C_TEXT:C284(v_101_083_txt)  //ShopDwgComments_txt
			ARRAY TEXT:C222(v_101_083_atxt; 0)  //ShopDwgComments_txt
			C_REAL:C285(v_101_005_r)  //Overhead
			ARRAY REAL:C219(v_101_005_ar; 0)  //Overhead
			C_REAL:C285(v_101_006_r)  //Fee
			ARRAY REAL:C219(v_101_006_ar; 0)  //Fee
			C_REAL:C285(v_101_007_r)  //Salary
			ARRAY REAL:C219(v_101_007_ar; 0)  //Salary
			C_REAL:C285(v_101_009_r)  //Actual_Total
			ARRAY REAL:C219(v_101_009_ar; 0)  //Actual_Total
			C_REAL:C285(v_101_010_r)  //Est_Salary
			ARRAY REAL:C219(v_101_010_ar; 0)  //Est_Salary
			C_REAL:C285(v_101_011_r)  //Est_IndirectCost
			ARRAY REAL:C219(v_101_011_ar; 0)  //Est_IndirectCost
			C_REAL:C285(v_101_012_r)  //Est_NetFee
			ARRAY REAL:C219(v_101_012_ar; 0)  //Est_NetFee
			C_REAL:C285(v_101_013_r)  //Est_TotalLimitFee
			ARRAY REAL:C219(v_101_013_ar; 0)  //Est_TotalLimitFee
			C_REAL:C285(v_101_014_r)  //Est_DirectExpense
			ARRAY REAL:C219(v_101_014_ar; 0)  //Est_DirectExpense
			C_REAL:C285(v_101_015_r)  //Est_Total
			ARRAY REAL:C219(v_101_015_ar; 0)  //Est_Total
			C_REAL:C285(v_101_022_r)  //Actual_Salary
			ARRAY REAL:C219(v_101_022_ar; 0)  //Actual_Salary
			C_REAL:C285(v_101_023_r)  //Actual_IndirectCost
			ARRAY REAL:C219(v_101_023_ar; 0)  //Actual_IndirectCost
			C_REAL:C285(v_101_024_r)  //Actual_NetFee
			ARRAY REAL:C219(v_101_024_ar; 0)  //Actual_NetFee
			C_REAL:C285(v_101_025_r)  //Actual_TotalLimitFee
			ARRAY REAL:C219(v_101_025_ar; 0)  //Actual_TotalLimitFee
			C_REAL:C285(v_101_026_r)  //Actual_DirectExpense
			ARRAY REAL:C219(v_101_026_ar; 0)  //Actual_DirectExpense
			C_REAL:C285(v_101_027_r)  //Est_ConstrSalary
			ARRAY REAL:C219(v_101_027_ar; 0)  //Est_ConstrSalary
			C_REAL:C285(v_101_028_r)  //Est_ConstrIndirectCost
			ARRAY REAL:C219(v_101_028_ar; 0)  //Est_ConstrIndirectCost
			C_REAL:C285(v_101_029_r)  //Est_ConstrNetFee
			ARRAY REAL:C219(v_101_029_ar; 0)  //Est_ConstrNetFee
			C_REAL:C285(v_101_030_r)  //Est_ConstrTotalLimitFee
			ARRAY REAL:C219(v_101_030_ar; 0)  //Est_ConstrTotalLimitFee
			C_REAL:C285(v_101_031_r)  //Actual_ConstrSalary
			ARRAY REAL:C219(v_101_031_ar; 0)  //Actual_ConstrSalary
			C_REAL:C285(v_101_032_r)  //Actual_ConstrIndirectCost
			ARRAY REAL:C219(v_101_032_ar; 0)  //Actual_ConstrIndirectCost
			C_REAL:C285(v_101_033_r)  //Actual_ConstrNetFee
			ARRAY REAL:C219(v_101_033_ar; 0)  //Actual_ConstrNetFee
			C_REAL:C285(v_101_034_r)  //Actual_ConstrTotalLimitFee
			ARRAY REAL:C219(v_101_034_ar; 0)  //Actual_ConstrTotalLimitFee
			C_REAL:C285(v_101_045_r)  //Est_TotalHRS_r
			ARRAY REAL:C219(v_101_045_ar; 0)  //Est_TotalHRS_r
			C_REAL:C285(v_101_046_r)  //AgreedTotalHRS_r
			ARRAY REAL:C219(v_101_046_ar; 0)  //AgreedTotalHRS_r
			C_REAL:C285(v_101_047_r)  //AgreedTotalCost_r
			ARRAY REAL:C219(v_101_047_ar; 0)  //AgreedTotalCost_r
			C_REAL:C285(v_101_048_r)  //Est_ConstrCost_r
			ARRAY REAL:C219(v_101_048_ar; 0)  //Est_ConstrCost_r
			C_REAL:C285(v_101_068_r)  //OrigSub_HRS_r
			ARRAY REAL:C219(v_101_068_ar; 0)  //OrigSub_HRS_r
			C_REAL:C285(v_101_069_r)  //OrigSub_TotalLimFee_r
			ARRAY REAL:C219(v_101_069_ar; 0)  //OrigSub_TotalLimFee_r
			C_REAL:C285(v_101_070_r)  //OrigSub_DirectCost_r
			ARRAY REAL:C219(v_101_070_ar; 0)  //OrigSub_DirectCost_r
			C_LONGINT:C283(v_101_002_L)  //AssignNo
			ARRAY INTEGER:C220(v_101_002_ai; 0)  //AssignNo
			C_LONGINT:C283(v_101_003_L)  //AssignID
			ARRAY LONGINT:C221(v_101_003_aL; 0)  //AssignID
			C_LONGINT:C283(v_101_038_L)  //ABPFlag_L
			ARRAY LONGINT:C221(v_101_038_aL; 0)  //ABPFlag_L
			C_LONGINT:C283(v_101_039_L)  //ProjectManagerID_L
			ARRAY LONGINT:C221(v_101_039_aL; 0)  //ProjectManagerID_L
			C_LONGINT:C283(v_101_054_L)  //Completed_L
			ARRAY LONGINT:C221(v_101_054_aL; 0)  //Completed_L
			C_DATE:C307(v_101_016_d)  //ReqFeeProposalDate
			ARRAY DATE:C224(v_101_016_ad; 0)  //ReqFeeProposalDate
			C_DATE:C307(v_101_017_d)  //NTPdate_written
			ARRAY DATE:C224(v_101_017_ad; 0)  //NTPdate_written
			C_DATE:C307(v_101_018_d)  //NTPdate_verbal
			ARRAY DATE:C224(v_101_018_ad; 0)  //NTPdate_verbal
			C_DATE:C307(v_101_040_d)  //InitialFieldVisit_d
			ARRAY DATE:C224(v_101_040_ad; 0)  //InitialFieldVisit_d
			C_DATE:C307(v_101_042_d)  //FieldVisitWConsult_d
			ARRAY DATE:C224(v_101_042_ad; 0)  //FieldVisitWConsult_d
			C_DATE:C307(v_101_043_d)  //FinalScope_d
			ARRAY DATE:C224(v_101_043_ad; 0)  //FinalScope_d
			C_DATE:C307(v_101_044_d)  //FeeProposalRecd_d
			ARRAY DATE:C224(v_101_044_ad; 0)  //FeeProposalRecd_d
			C_DATE:C307(v_101_049_d)  //DocsSentToFAPO_d
			ARRAY DATE:C224(v_101_049_ad; 0)  //DocsSentToFAPO_d
			C_DATE:C307(v_101_050_d)  //ExpectFirst25_d
			ARRAY DATE:C224(v_101_050_ad; 0)  //ExpectFirst25_d
			C_DATE:C307(v_101_051_d)  //ExpectFirst90_d
			ARRAY DATE:C224(v_101_051_ad; 0)  //ExpectFirst90_d
			C_DATE:C307(v_101_056_d)  //ScopeApprovedDistr_d
			ARRAY DATE:C224(v_101_056_ad; 0)  //ScopeApprovedDistr_d
			C_DATE:C307(v_101_057_d)  //ScopeApprovedPEng_d
			ARRAY DATE:C224(v_101_057_ad; 0)  //ScopeApprovedPEng_d
			C_DATE:C307(v_101_058_d)  //ExpectScope_d
			ARRAY DATE:C224(v_101_058_ad; 0)  //ExpectScope_d
			C_DATE:C307(v_101_061_d)  //FeeProposalApprvd_d
			ARRAY DATE:C224(v_101_061_ad; 0)  //FeeProposalApprvd_d
			C_DATE:C307(v_101_062_d)  //ExpectFirstPSE_d
			ARRAY DATE:C224(v_101_062_ad; 0)  //ExpectFirstPSE_d
			C_DATE:C307(v_101_064_d)  //MylarSignedDate_d
			ARRAY DATE:C224(v_101_064_ad; 0)  //MylarSignedDate_d
			C_DATE:C307(v_101_066_d)  //InspRptToCons_d
			ARRAY DATE:C224(v_101_066_ad; 0)  //InspRptToCons_d
			C_DATE:C307(v_101_078_d)  //DeadLine_d
			ARRAY DATE:C224(v_101_078_ad; 0)  //DeadLine_d
			C_DATE:C307(v_101_080_d)  //LateActionDate_d
			ARRAY DATE:C224(v_101_080_ad; 0)  //LateActionDate_d
			C_DATE:C307(v_101_081_d)  //RatgRptReceived_d
			ARRAY DATE:C224(v_101_081_ad; 0)  //RatgRptReceived_d
			C_DATE:C307(v_101_082_d)  //RatgRptToBIE_d
			ARRAY DATE:C224(v_101_082_ad; 0)  //RatgRptToBIE_d
			C_BOOLEAN:C305(v_101_021_b)  //SpecialAssignment
			ARRAY BOOLEAN:C223(v_101_021_ab; 0)  //SpecialAssignment
			C_BOOLEAN:C305(v_101_055_b)  //FHWAOverSight_b
			ARRAY BOOLEAN:C223(v_101_055_ab; 0)  //FHWAOverSight_b
			C_BOOLEAN:C305(v_101_059_b)  //SurveyNeeded_b
			ARRAY BOOLEAN:C223(v_101_059_ab; 0)  //SurveyNeeded_b
			C_BOOLEAN:C305(v_101_063_b)  //MylarSigned_b
			ARRAY BOOLEAN:C223(v_101_063_ab; 0)  //MylarSigned_b
			C_BOOLEAN:C305(v_101_074_b)  //PublicMtgNeeded_b
			ARRAY BOOLEAN:C223(v_101_074_ab; 0)  //PublicMtgNeeded_b
			C_BOOLEAN:C305(v_101_084_b)  //Hidden_b
			ARRAY BOOLEAN:C223(v_101_084_ab; 0)  //Hidden_b
		: ($1=102)  //Addendum_Maintenance
			C_TEXT:C284(v_102_026_txt)  //Addendum_Maintenance_UUIDKey_s
			ARRAY TEXT:C222(v_102_026_atxt; 0)  //Addendum_Maintenance_UUIDKey_s
			C_TEXT:C284(v_102_005_txt)  //ContractNo
			ARRAY TEXT:C222(v_102_005_atxt; 0)  //ContractNo
			C_TEXT:C284(v_102_019_txt)  //Description
			ARRAY TEXT:C222(v_102_019_atxt; 0)  //Description
			C_REAL:C285(v_102_007_r)  //Est_ConstrIndirectCost
			ARRAY REAL:C219(v_102_007_ar; 0)  //Est_ConstrIndirectCost
			C_REAL:C285(v_102_008_r)  //Est_ConstrNetFee
			ARRAY REAL:C219(v_102_008_ar; 0)  //Est_ConstrNetFee
			C_REAL:C285(v_102_009_r)  //Est_ConstrSalary
			ARRAY REAL:C219(v_102_009_ar; 0)  //Est_ConstrSalary
			C_REAL:C285(v_102_010_r)  //Est_ConstrTotalLimitFee
			ARRAY REAL:C219(v_102_010_ar; 0)  //Est_ConstrTotalLimitFee
			C_REAL:C285(v_102_011_r)  //Est_DirectExpense
			ARRAY REAL:C219(v_102_011_ar; 0)  //Est_DirectExpense
			C_REAL:C285(v_102_012_r)  //Est_IndirectCost
			ARRAY REAL:C219(v_102_012_ar; 0)  //Est_IndirectCost
			C_REAL:C285(v_102_013_r)  //Est_NetFee
			ARRAY REAL:C219(v_102_013_ar; 0)  //Est_NetFee
			C_REAL:C285(v_102_014_r)  //Est_Salary
			ARRAY REAL:C219(v_102_014_ar; 0)  //Est_Salary
			C_REAL:C285(v_102_015_r)  //Est_Total
			ARRAY REAL:C219(v_102_015_ar; 0)  //Est_Total
			C_REAL:C285(v_102_016_r)  //Est_TotalLimitFee
			ARRAY REAL:C219(v_102_016_ar; 0)  //Est_TotalLimitFee
			C_REAL:C285(v_102_017_r)  //Fee
			ARRAY REAL:C219(v_102_017_ar; 0)  //Fee
			C_REAL:C285(v_102_018_r)  //Overhead
			ARRAY REAL:C219(v_102_018_ar; 0)  //Overhead
			C_REAL:C285(v_102_020_r)  //Est_HRS_r
			ARRAY REAL:C219(v_102_020_ar; 0)  //Est_HRS_r
			C_REAL:C285(v_102_021_r)  //Appr_HRS_r
			ARRAY REAL:C219(v_102_021_ar; 0)  //Appr_HRS_r
			C_REAL:C285(v_102_022_r)  //Appr_TotalLimmitFee_r
			ARRAY REAL:C219(v_102_022_ar; 0)  //Appr_TotalLimmitFee_r
			C_REAL:C285(v_102_023_r)  //Appr_DirectExpense_r
			ARRAY REAL:C219(v_102_023_ar; 0)  //Appr_DirectExpense_r
			C_LONGINT:C283(v_102_002_L)  //AddendumNo
			ARRAY INTEGER:C220(v_102_002_ai; 0)  //AddendumNo
			C_LONGINT:C283(v_102_004_L)  //AssignNo
			ARRAY INTEGER:C220(v_102_004_ai; 0)  //AssignNo
			C_LONGINT:C283(v_102_001_L)  //AddendumID
			ARRAY LONGINT:C221(v_102_001_aL; 0)  //AddendumID
			C_LONGINT:C283(v_102_003_L)  //AssignID
			ARRAY LONGINT:C221(v_102_003_aL; 0)  //AssignID
			C_DATE:C307(v_102_006_d)  //DateCreated
			ARRAY DATE:C224(v_102_006_ad; 0)  //DateCreated
			C_DATE:C307(v_102_024_d)  //Submitted_d
			ARRAY DATE:C224(v_102_024_ad; 0)  //Submitted_d
			C_DATE:C307(v_102_025_d)  //Approved_d
			ARRAY DATE:C224(v_102_025_ad; 0)  //Approved_d
		: ($1=103)  //Work_Estimate
			C_BLOB:C604(v_103_005_blb)  //WkEstValues
			ARRAY BLOB:C1222(v_103_005_ablb; 0)  //WkEstValues
			C_BLOB:C604(v_103_032_blb)  //RestrictedItemList
			ARRAY BLOB:C1222(v_103_032_ablb; 0)  //RestrictedItemList
			C_BLOB:C604(v_103_039_blb)  //WkOrigEngEstVal_x
			ARRAY BLOB:C1222(v_103_039_ablb; 0)  //WkOrigEngEstVal_x
			C_TEXT:C284(v_103_048_txt)  //Work_Estimate_UUIDKey_s
			ARRAY TEXT:C222(v_103_048_atxt; 0)  //Work_Estimate_UUIDKey_s
			C_TEXT:C284(v_103_003_txt)  //ContractNo
			ARRAY TEXT:C222(v_103_003_atxt; 0)  //ContractNo
			C_TEXT:C284(v_103_004_txt)  //AssignDesc
			ARRAY TEXT:C222(v_103_004_atxt; 0)  //AssignDesc
			C_TEXT:C284(v_103_006_txt)  //Consultant
			ARRAY TEXT:C222(v_103_006_atxt; 0)  //Consultant
			C_TEXT:C284(v_103_021_txt)  //CompletedBy
			ARRAY TEXT:C222(v_103_021_atxt; 0)  //CompletedBy
			C_TEXT:C284(v_103_022_txt)  //ApprovedBy
			ARRAY TEXT:C222(v_103_022_atxt; 0)  //ApprovedBy
			C_TEXT:C284(v_103_023_txt)  //Location
			ARRAY TEXT:C222(v_103_023_atxt; 0)  //Location
			C_TEXT:C284(v_103_024_txt)  //CityTown
			ARRAY TEXT:C222(v_103_024_atxt; 0)  //CityTown
			C_TEXT:C284(v_103_025_txt)  //BridgeNo
			ARRAY TEXT:C222(v_103_025_atxt; 0)  //BridgeNo
			C_TEXT:C284(v_103_026_txt)  //ProjInfoNo
			ARRAY TEXT:C222(v_103_026_atxt; 0)  //ProjInfoNo
			C_TEXT:C284(v_103_030_txt)  //ApproveCmts
			ARRAY TEXT:C222(v_103_030_atxt; 0)  //ApproveCmts
			C_TEXT:C284(v_103_031_txt)  //CompleteCmts
			ARRAY TEXT:C222(v_103_031_atxt; 0)  //CompleteCmts
			C_TEXT:C284(v_103_034_txt)  //ReviewedBy
			ARRAY TEXT:C222(v_103_034_atxt; 0)  //ReviewedBy
			C_TEXT:C284(v_103_035_txt)  //ReviewCmts
			ARRAY TEXT:C222(v_103_035_atxt; 0)  //ReviewCmts
			C_TEXT:C284(v_103_037_txt)  //CreatedBy
			ARRAY TEXT:C222(v_103_037_atxt; 0)  //CreatedBy
			C_REAL:C285(v_103_007_r)  //Cat1Rate
			ARRAY REAL:C219(v_103_007_ar; 0)  //Cat1Rate
			C_REAL:C285(v_103_008_r)  //Cat2Rate
			ARRAY REAL:C219(v_103_008_ar; 0)  //Cat2Rate
			C_REAL:C285(v_103_009_r)  //Cat3Rate
			ARRAY REAL:C219(v_103_009_ar; 0)  //Cat3Rate
			C_REAL:C285(v_103_010_r)  //Cate4Rate
			ARRAY REAL:C219(v_103_010_ar; 0)  //Cate4Rate
			C_REAL:C285(v_103_011_r)  //Cat5Rate
			ARRAY REAL:C219(v_103_011_ar; 0)  //Cat5Rate
			C_REAL:C285(v_103_012_r)  //IndirectCostPct
			ARRAY REAL:C219(v_103_012_ar; 0)  //IndirectCostPct
			C_REAL:C285(v_103_013_r)  //NetFeePct
			ARRAY REAL:C219(v_103_013_ar; 0)  //NetFeePct
			C_REAL:C285(v_103_014_r)  //DirectExpenseD
			ARRAY REAL:C219(v_103_014_ar; 0)  //DirectExpenseD
			C_REAL:C285(v_103_015_r)  //SpecEngineeringD
			ARRAY REAL:C219(v_103_015_ar; 0)  //SpecEngineeringD
			C_REAL:C285(v_103_027_r)  //DirectExpenseC
			ARRAY REAL:C219(v_103_027_ar; 0)  //DirectExpenseC
			C_REAL:C285(v_103_028_r)  //SpecEngineeringC
			ARRAY REAL:C219(v_103_028_ar; 0)  //SpecEngineeringC
			C_REAL:C285(v_103_040_r)  //ConstCat1Rate
			ARRAY REAL:C219(v_103_040_ar; 0)  //ConstCat1Rate
			C_REAL:C285(v_103_041_r)  //ConstCat2Rate
			ARRAY REAL:C219(v_103_041_ar; 0)  //ConstCat2Rate
			C_REAL:C285(v_103_042_r)  //ConstCat3Rate
			ARRAY REAL:C219(v_103_042_ar; 0)  //ConstCat3Rate
			C_REAL:C285(v_103_043_r)  //ConstCat4Rate
			ARRAY REAL:C219(v_103_043_ar; 0)  //ConstCat4Rate
			C_REAL:C285(v_103_044_r)  //ConstCat5Rate
			ARRAY REAL:C219(v_103_044_ar; 0)  //ConstCat5Rate
			C_REAL:C285(v_103_045_r)  //Cat6Rate
			ARRAY REAL:C219(v_103_045_ar; 0)  //Cat6Rate
			C_REAL:C285(v_103_046_r)  //ConstCat6Rate
			ARRAY REAL:C219(v_103_046_ar; 0)  //ConstCat6Rate
			C_LONGINT:C283(v_103_016_L)  //AssignNo
			ARRAY INTEGER:C220(v_103_016_ai; 0)  //AssignNo
			C_LONGINT:C283(v_103_018_L)  //WkHrEstApproved
			ARRAY INTEGER:C220(v_103_018_ai; 0)  //WkHrEstApproved
			C_LONGINT:C283(v_103_029_L)  //AddendumNo
			ARRAY INTEGER:C220(v_103_029_ai; 0)  //AddendumNo
			C_LONGINT:C283(v_103_033_L)  //WkHrEstReviewed
			ARRAY INTEGER:C220(v_103_033_ai; 0)  //WkHrEstReviewed
			C_LONGINT:C283(v_103_001_L)  //WKID
			ARRAY LONGINT:C221(v_103_001_aL; 0)  //WKID
			C_LONGINT:C283(v_103_002_L)  //AssignID
			ARRAY LONGINT:C221(v_103_002_aL; 0)  //AssignID
			C_LONGINT:C283(v_103_047_L)  //Version_L
			ARRAY LONGINT:C221(v_103_047_aL; 0)  //Version_L
			C_DATE:C307(v_103_019_d)  //ApprovedDate
			ARRAY DATE:C224(v_103_019_ad; 0)  //ApprovedDate
			C_DATE:C307(v_103_020_d)  //CompleteDate
			ARRAY DATE:C224(v_103_020_ad; 0)  //CompleteDate
			C_DATE:C307(v_103_036_d)  //ReviewDate
			ARRAY DATE:C224(v_103_036_ad; 0)  //ReviewDate
			C_DATE:C307(v_103_038_d)  //CreatedDate
			ARRAY DATE:C224(v_103_038_ad; 0)  //CreatedDate
			C_BOOLEAN:C305(v_103_017_b)  //WkHrEstComplete
			ARRAY BOOLEAN:C223(v_103_017_ab; 0)  //WkHrEstComplete
		: ($1=104)  //WorkHour_Config
			C_BLOB:C604(v_104_001_blb)  //ConfigArrays
			ARRAY BLOB:C1222(v_104_001_ablb; 0)  //ConfigArrays
			C_TEXT:C284(v_104_003_txt)  //WorkHour_Config_UUIDKey_s
			ARRAY TEXT:C222(v_104_003_atxt; 0)  //WorkHour_Config_UUIDKey_s
			C_TEXT:C284(v_104_002_txt)  //AssignType
			ARRAY TEXT:C222(v_104_002_atxt; 0)  //AssignType
		: ($1=105)  //WorkHour_Summary
			C_TEXT:C284(v_105_011_txt)  //WorkHour_Summary_UUIDKey_s
			ARRAY TEXT:C222(v_105_011_atxt; 0)  //WorkHour_Summary_UUIDKey_s
			C_TEXT:C284(v_105_001_txt)  //ProjType
			ARRAY TEXT:C222(v_105_001_atxt; 0)  //ProjType
			C_LONGINT:C283(v_105_002_L)  //ItemID
			ARRAY INTEGER:C220(v_105_002_ai; 0)  //ItemID
			C_LONGINT:C283(v_105_003_L)  //AvgCol1
			ARRAY LONGINT:C221(v_105_003_aL; 0)  //AvgCol1
			C_LONGINT:C283(v_105_004_L)  //AvgCol2
			ARRAY LONGINT:C221(v_105_004_aL; 0)  //AvgCol2
			C_LONGINT:C283(v_105_005_L)  //AvgCol3
			ARRAY LONGINT:C221(v_105_005_aL; 0)  //AvgCol3
			C_LONGINT:C283(v_105_006_L)  //AvgCol4
			ARRAY LONGINT:C221(v_105_006_aL; 0)  //AvgCol4
			C_LONGINT:C283(v_105_007_L)  //AvgCol5
			ARRAY LONGINT:C221(v_105_007_aL; 0)  //AvgCol5
			C_LONGINT:C283(v_105_008_L)  //AvgSum
			ARRAY LONGINT:C221(v_105_008_aL; 0)  //AvgSum
			C_LONGINT:C283(v_105_009_L)  //AvgCol6
			ARRAY LONGINT:C221(v_105_009_aL; 0)  //AvgCol6
			C_LONGINT:C283(v_105_010_L)  //Field10
			ARRAY LONGINT:C221(v_105_010_aL; 0)  //Field10
		: ($1=106)  //zSpecialReports
			C_TEXT:C284(v_106_008_txt)  //zSpecialReports_UUIDKey_s
			ARRAY TEXT:C222(v_106_008_atxt; 0)  //zSpecialReports_UUIDKey_s
			C_TEXT:C284(v_106_001_txt)  //Purpose
			ARRAY TEXT:C222(v_106_001_atxt; 0)  //Purpose
			C_TEXT:C284(v_106_002_txt)  //ReportName
			ARRAY TEXT:C222(v_106_002_atxt; 0)  //ReportName
			C_TEXT:C284(v_106_003_txt)  //MethodName
			ARRAY TEXT:C222(v_106_003_atxt; 0)  //MethodName
			C_TEXT:C284(v_106_004_txt)  //LongDescription
			ARRAY TEXT:C222(v_106_004_atxt; 0)  //LongDescription
			C_TEXT:C284(v_106_005_txt)  //SubCategory
			ARRAY TEXT:C222(v_106_005_atxt; 0)  //SubCategory
			C_TEXT:C284(v_106_006_txt)  //CreatedBy
			ARRAY TEXT:C222(v_106_006_atxt; 0)  //CreatedBy
			C_LONGINT:C283(v_106_007_L)  //Record_ID
			ARRAY LONGINT:C221(v_106_007_aL; 0)  //Record_ID
		: ($1=107)  //Parameters
			C_TEXT:C284(v_107_005_txt)  //Parameters_UUIDKey_s
			ARRAY TEXT:C222(v_107_005_atxt; 0)  //Parameters_UUIDKey_s
			C_TEXT:C284(v_107_001_txt)  //ParamCode
			ARRAY TEXT:C222(v_107_001_atxt; 0)  //ParamCode
			C_TEXT:C284(v_107_002_txt)  //Description
			ARRAY TEXT:C222(v_107_002_atxt; 0)  //Description
			C_TEXT:C284(v_107_003_txt)  //Value
			ARRAY TEXT:C222(v_107_003_atxt; 0)  //Value
			C_LONGINT:C283(v_107_004_L)  //ParamType
			ARRAY INTEGER:C220(v_107_004_ai; 0)  //ParamType
		: ($1=108)  //ScourPriorityRank
			C_TEXT:C284(v_108_007_txt)  //ScourPriorityRank_UUIDKey_s
			ARRAY TEXT:C222(v_108_007_atxt; 0)  //ScourPriorityRank_UUIDKey_s
			C_TEXT:C284(v_108_001_txt)  //BIN
			ARRAY TEXT:C222(v_108_001_atxt; 0)  //BIN
			C_TEXT:C284(v_108_005_txt)  //Category
			ARRAY TEXT:C222(v_108_005_atxt; 0)  //Category
			C_REAL:C285(v_108_002_r)  //FailureProb
			ARRAY REAL:C219(v_108_002_ar; 0)  //FailureProb
			C_REAL:C285(v_108_003_r)  //FailureCost
			ARRAY REAL:C219(v_108_003_ar; 0)  //FailureCost
			C_REAL:C285(v_108_004_r)  //LifeTimeRisk
			ARRAY REAL:C219(v_108_004_ar; 0)  //LifeTimeRisk
			C_LONGINT:C283(v_108_006_L)  //Rank
			ARRAY LONGINT:C221(v_108_006_aL; 0)  //Rank
		: ($1=109)  //PERS_Groups
			C_TEXT:C284(v_109_005_txt)  //PERS_Groups_UUIDKey_s
			ARRAY TEXT:C222(v_109_005_atxt; 0)  //PERS_Groups_UUIDKey_s
			C_TEXT:C284(v_109_002_txt)  //PERS_GroupName_s
			ARRAY TEXT:C222(v_109_002_atxt; 0)  //PERS_GroupName_s
			C_TEXT:C284(v_109_006_txt)  //PERS_ActingTitle
			ARRAY TEXT:C222(v_109_006_atxt; 0)  //PERS_ActingTitle
			C_LONGINT:C283(v_109_001_L)  //PERS_GroupID_I
			ARRAY INTEGER:C220(v_109_001_ai; 0)  //PERS_GroupID_I
			C_LONGINT:C283(v_109_003_L)  //PERS_Acting
			ARRAY INTEGER:C220(v_109_003_ai; 0)  //PERS_Acting
			C_LONGINT:C283(v_109_004_L)  //PERS_Primary
			ARRAY INTEGER:C220(v_109_004_ai; 0)  //PERS_Primary
		: ($1=110)  //PERS_GroupMembers
			C_TEXT:C284(v_110_003_txt)  //PERS_GroupMembers_UUIDKey_s
			ARRAY TEXT:C222(v_110_003_atxt; 0)  //PERS_GroupMembers_UUIDKey_s
			C_LONGINT:C283(v_110_001_L)  //GroupID_I
			ARRAY INTEGER:C220(v_110_001_ai; 0)  //GroupID_I
			C_LONGINT:C283(v_110_002_L)  //PersonID_I
			ARRAY INTEGER:C220(v_110_002_ai; 0)  //PersonID_I
		: ($1=111)  //CM_ExtTimeFYAlloc
			C_TEXT:C284(v_111_005_txt)  //CM_ExtTimeFYAlloc_UUIDKey_s
			ARRAY TEXT:C222(v_111_005_atxt; 0)  //CM_ExtTimeFYAlloc_UUIDKey_s
			C_REAL:C285(v_111_003_r)  //FYAmmount_R
			ARRAY REAL:C219(v_111_003_ar; 0)  //FYAmmount_R
			C_LONGINT:C283(v_111_004_L)  //FYear_I
			ARRAY INTEGER:C220(v_111_004_ai; 0)  //FYear_I
			C_LONGINT:C283(v_111_001_L)  //ExtTimeFYAllocID_L
			ARRAY LONGINT:C221(v_111_001_aL; 0)  //ExtTimeFYAllocID_L
			C_LONGINT:C283(v_111_002_L)  //EOT_ID_L
			ARRAY LONGINT:C221(v_111_002_aL; 0)  //EOT_ID_L
		: ($1=112)  //InventoryPhotoInsp
			C_TEXT:C284(v_112_011_txt)  //InventoryPhotoInsp_UUIDKey_s
			ARRAY TEXT:C222(v_112_011_atxt; 0)  //InventoryPhotoInsp_UUIDKey_s
			C_TEXT:C284(v_112_002_txt)  //BIN
			ARRAY TEXT:C222(v_112_002_atxt; 0)  //BIN
			C_TEXT:C284(v_112_007_txt)  //ApproveComments_txt
			ARRAY TEXT:C222(v_112_007_atxt; 0)  //ApproveComments_txt
			C_LONGINT:C283(v_112_005_L)  //TeamLeader_I
			ARRAY INTEGER:C220(v_112_005_ai; 0)  //TeamLeader_I
			C_LONGINT:C283(v_112_006_L)  //Approved_I
			ARRAY INTEGER:C220(v_112_006_ai; 0)  //Approved_I
			C_LONGINT:C283(v_112_010_L)  //TeamMember_I
			ARRAY INTEGER:C220(v_112_010_ai; 0)  //TeamMember_I
			C_LONGINT:C283(v_112_001_L)  //InvPhotoInspID_L
			ARRAY LONGINT:C221(v_112_001_aL; 0)  //InvPhotoInspID_L
			C_DATE:C307(v_112_003_d)  //InvPhotoDate_D
			ARRAY DATE:C224(v_112_003_ad; 0)  //InvPhotoDate_D
			C_DATE:C307(v_112_008_d)  //ApproveDate_D
			ARRAY DATE:C224(v_112_008_ad; 0)  //ApproveDate_D
			C_BOOLEAN:C305(v_112_004_b)  //OrientationNS_b
			ARRAY BOOLEAN:C223(v_112_004_ab; 0)  //OrientationNS_b
			C_BOOLEAN:C305(v_112_009_b)  //Complete_B
			ARRAY BOOLEAN:C223(v_112_009_ab; 0)  //Complete_B
		: ($1=113)  //InventoryPhotos
			C_BLOB:C604(v_113_004_blb)  //InvPhoto_X
			ARRAY BLOB:C1222(v_113_004_ablb; 0)  //InvPhoto_X
			C_TEXT:C284(v_113_006_txt)  //InventoryPhotos_UUIDKey_s
			ARRAY TEXT:C222(v_113_006_atxt; 0)  //InventoryPhotos_UUIDKey_s
			C_TEXT:C284(v_113_003_txt)  //PhotoDescr_txt
			ARRAY TEXT:C222(v_113_003_atxt; 0)  //PhotoDescr_txt
			C_LONGINT:C283(v_113_005_L)  //Sequence_I
			ARRAY INTEGER:C220(v_113_005_ai; 0)  //Sequence_I
			C_LONGINT:C283(v_113_001_L)  //InvPhoto_ID
			ARRAY LONGINT:C221(v_113_001_aL; 0)  //InvPhoto_ID
			C_LONGINT:C283(v_113_002_L)  //InvPhotoInsp_ID
			ARRAY LONGINT:C221(v_113_002_aL; 0)  //InvPhotoInsp_ID
		: ($1=114)  //PRJ_Contractor
			C_TEXT:C284(v_114_004_txt)  //PRJ_Contractor_UUIDKey_s
			ARRAY TEXT:C222(v_114_004_atxt; 0)  //PRJ_Contractor_UUIDKey_s
			C_TEXT:C284(v_114_002_txt)  //CTR_CompanyName_s
			ARRAY TEXT:C222(v_114_002_atxt; 0)  //CTR_CompanyName_s
			C_TEXT:C284(v_114_003_txt)  //CTR_VendorCode_s
			ARRAY TEXT:C222(v_114_003_atxt; 0)  //CTR_VendorCode_s
			C_LONGINT:C283(v_114_001_L)  //CTR_ContractorID_l
			ARRAY LONGINT:C221(v_114_001_aL; 0)  //CTR_ContractorID_l
		: ($1=115)  //PRJ_ProjectDetails
			C_TEXT:C284(v_115_055_txt)  //PRJ_ProjectDetails_UUIDKey_s
			ARRAY TEXT:C222(v_115_055_atxt; 0)  //PRJ_ProjectDetails_UUIDKey_s
			C_TEXT:C284(v_115_004_txt)  //PRJ_ProjectType_s
			ARRAY TEXT:C222(v_115_004_atxt; 0)  //PRJ_ProjectType_s
			C_TEXT:C284(v_115_005_txt)  //PRJ_BridgeNo_s
			ARRAY TEXT:C222(v_115_005_atxt; 0)  //PRJ_BridgeNo_s
			C_TEXT:C284(v_115_007_txt)  //PRJ_NonBridge_s
			ARRAY TEXT:C222(v_115_007_atxt; 0)  //PRJ_NonBridge_s
			C_TEXT:C284(v_115_008_txt)  //PRJ_CityOrTown_s
			ARRAY TEXT:C222(v_115_008_atxt; 0)  //PRJ_CityOrTown_s
			C_TEXT:C284(v_115_009_txt)  //PRJ_LastActionDescription_txt
			ARRAY TEXT:C222(v_115_009_atxt; 0)  //PRJ_LastActionDescription_txt
			C_TEXT:C284(v_115_010_txt)  //PRJ_Comments_txt
			ARRAY TEXT:C222(v_115_010_atxt; 0)  //PRJ_Comments_txt
			C_TEXT:C284(v_115_013_txt)  //PRJ_BridgeDataSheetComplete_s
			ARRAY TEXT:C222(v_115_013_atxt; 0)  //PRJ_BridgeDataSheetComplete_s
			C_TEXT:C284(v_115_023_txt)  //PRJ_Program_s
			ARRAY TEXT:C222(v_115_023_atxt; 0)  //PRJ_Program_s
			C_TEXT:C284(v_115_025_txt)  //PRJ_FederalAid_s
			ARRAY TEXT:C222(v_115_025_atxt; 0)  //PRJ_FederalAid_s
			C_TEXT:C284(v_115_026_txt)  //PRJ_BinUpdateRequest_s
			ARRAY TEXT:C222(v_115_026_atxt; 0)  //PRJ_BinUpdateRequest_s
			C_TEXT:C284(v_115_030_txt)  //PRJ_ApprovedType_s
			ARRAY TEXT:C222(v_115_030_atxt; 0)  //PRJ_ApprovedType_s
			C_TEXT:C284(v_115_031_txt)  //PRJ_EnteredConstructionEWO_s
			ARRAY TEXT:C222(v_115_031_atxt; 0)  //PRJ_EnteredConstructionEWO_s
			C_TEXT:C284(v_115_032_txt)  //PRJ_GroupBy_s
			ARRAY TEXT:C222(v_115_032_atxt; 0)  //PRJ_GroupBy_s
			C_TEXT:C284(v_115_033_txt)  //PRJ_Slot_s
			ARRAY TEXT:C222(v_115_033_atxt; 0)  //PRJ_Slot_s
			C_TEXT:C284(v_115_034_txt)  //PRJ_PrimaryBin_s
			ARRAY TEXT:C222(v_115_034_atxt; 0)  //PRJ_PrimaryBin_s
			C_TEXT:C284(v_115_035_txt)  //PRJ_Status_s
			ARRAY TEXT:C222(v_115_035_atxt; 0)  //PRJ_Status_s
			C_TEXT:C284(v_115_036_txt)  //PRJ_BeamUnitType_s
			ARRAY TEXT:C222(v_115_036_atxt; 0)  //PRJ_BeamUnitType_s
			C_TEXT:C284(v_115_040_txt)  //PRJ_NonBridgeNotes_txt
			ARRAY TEXT:C222(v_115_040_atxt; 0)  //PRJ_NonBridgeNotes_txt
			C_TEXT:C284(v_115_043_txt)  //PRJ_EnteredDesignEWO_s
			ARRAY TEXT:C222(v_115_043_atxt; 0)  //PRJ_EnteredDesignEWO_s
			C_TEXT:C284(v_115_044_txt)  //PRJ_BridgeSectResp_s
			ARRAY TEXT:C222(v_115_044_atxt; 0)  //PRJ_BridgeSectResp_s
			C_TEXT:C284(v_115_046_txt)  //PRJ_ModifiedBy_s
			ARRAY TEXT:C222(v_115_046_atxt; 0)  //PRJ_ModifiedBy_s
			C_TEXT:C284(v_115_047_txt)  //PRJ_ModifiedTimeStamp_s
			ARRAY TEXT:C222(v_115_047_atxt; 0)  //PRJ_ModifiedTimeStamp_s
			C_REAL:C285(v_115_027_r)  //PRJ_BeamCost_r
			ARRAY REAL:C219(v_115_027_ar; 0)  //PRJ_BeamCost_r
			C_REAL:C285(v_115_029_r)  //PRJ_Item995_r
			ARRAY REAL:C219(v_115_029_ar; 0)  //PRJ_Item995_r
			C_LONGINT:C283(v_115_001_L)  //PRJ_ProjectID_l
			ARRAY LONGINT:C221(v_115_001_aL; 0)  //PRJ_ProjectID_l
			C_LONGINT:C283(v_115_002_L)  //CP_ConstructionProjectID_l
			ARRAY LONGINT:C221(v_115_002_aL; 0)  //CP_ConstructionProjectID_l
			C_LONGINT:C283(v_115_003_L)  //PF_FileID_l
			ARRAY LONGINT:C221(v_115_003_aL; 0)  //PF_FileID_l
			C_LONGINT:C283(v_115_028_L)  //PRJ_BeamUnit_l
			ARRAY LONGINT:C221(v_115_028_aL; 0)  //PRJ_BeamUnit_l
			C_LONGINT:C283(v_115_039_L)  //PRJ_CurrentStructutalPrjMgrID_l
			ARRAY LONGINT:C221(v_115_039_aL; 0)  //PRJ_CurrentStructutalPrjMgrID_l
			C_LONGINT:C283(v_115_045_L)  //PRJ_MeetingPageNo_l
			ARRAY LONGINT:C221(v_115_045_aL; 0)  //PRJ_MeetingPageNo_l
			C_LONGINT:C283(v_115_053_L)  //PRJ_ConsultantOverideID_l
			ARRAY LONGINT:C221(v_115_053_aL; 0)  //PRJ_ConsultantOverideID_l
			C_LONGINT:C283(v_115_054_L)  //DC_DesignContractID_l
			ARRAY LONGINT:C221(v_115_054_aL; 0)  //DC_DesignContractID_l
			C_DATE:C307(v_115_012_d)  //PRJ_DesignApproval_d
			ARRAY DATE:C224(v_115_012_ad; 0)  //PRJ_DesignApproval_d
			C_DATE:C307(v_115_014_d)  //PRJ_RequestFinalPrints_d
			ARRAY DATE:C224(v_115_014_ad; 0)  //PRJ_RequestFinalPrints_d
			C_DATE:C307(v_115_016_d)  //PRJ_RequestForMylars_d
			ARRAY DATE:C224(v_115_016_ad; 0)  //PRJ_RequestForMylars_d
			C_DATE:C307(v_115_018_d)  //PRJ_BridgeMylarSigned_d
			ARRAY DATE:C224(v_115_018_ad; 0)  //PRJ_BridgeMylarSigned_d
			C_DATE:C307(v_115_019_d)  //PRJ_SpecsRecAtBlueprint_d
			ARRAY DATE:C224(v_115_019_ad; 0)  //PRJ_SpecsRecAtBlueprint_d
			C_DATE:C307(v_115_020_d)  //PRJ_SentToExpediting_d
			ARRAY DATE:C224(v_115_020_ad; 0)  //PRJ_SentToExpediting_d
			C_DATE:C307(v_115_021_d)  //PRJ_ConstructionCompletion_d
			ARRAY DATE:C224(v_115_021_ad; 0)  //PRJ_ConstructionCompletion_d
			C_DATE:C307(v_115_022_d)  //PRJ_LumpSumBreakDown_d
			ARRAY DATE:C224(v_115_022_ad; 0)  //PRJ_LumpSumBreakDown_d
			C_DATE:C307(v_115_024_d)  //PRJ_NTP_d
			ARRAY DATE:C224(v_115_024_ad; 0)  //PRJ_NTP_d
			C_DATE:C307(v_115_037_d)  //PRJ_Completion_d
			ARRAY DATE:C224(v_115_037_ad; 0)  //PRJ_Completion_d
			C_DATE:C307(v_115_038_d)  //PRJ_RatingRequest_d
			ARRAY DATE:C224(v_115_038_ad; 0)  //PRJ_RatingRequest_d
			C_DATE:C307(v_115_041_d)  //PRJ_ScopeReceived_d
			ARRAY DATE:C224(v_115_041_ad; 0)  //PRJ_ScopeReceived_d
			C_DATE:C307(v_115_048_d)  //PRJ_FHWASketchSubmit_d
			ARRAY DATE:C224(v_115_048_ad; 0)  //PRJ_FHWASketchSubmit_d
			C_DATE:C307(v_115_049_d)  //PRJ_FHWASketchApproved_d
			ARRAY DATE:C224(v_115_049_ad; 0)  //PRJ_FHWASketchApproved_d
			C_DATE:C307(v_115_050_d)  //PRJ_FHWAPSESubmit_d
			ARRAY DATE:C224(v_115_050_ad; 0)  //PRJ_FHWAPSESubmit_d
			C_DATE:C307(v_115_051_d)  //PRJ_FHWAPSEApproved_d
			ARRAY DATE:C224(v_115_051_ad; 0)  //PRJ_FHWAPSEApproved_d
			C_BOOLEAN:C305(v_115_006_b)  //PRJ_TemporaryBridge_b
			ARRAY BOOLEAN:C223(v_115_006_ab; 0)  //PRJ_TemporaryBridge_b
			C_BOOLEAN:C305(v_115_011_b)  //PRJ_DesignApproved_b
			ARRAY BOOLEAN:C223(v_115_011_ab; 0)  //PRJ_DesignApproved_b
			C_BOOLEAN:C305(v_115_015_b)  //PRJ_ReviewByBridgeEng_b
			ARRAY BOOLEAN:C223(v_115_015_ab; 0)  //PRJ_ReviewByBridgeEng_b
			C_BOOLEAN:C305(v_115_017_b)  //PRJ_BridgeMylarSigned_b
			ARRAY BOOLEAN:C223(v_115_017_ab; 0)  //PRJ_BridgeMylarSigned_b
			C_BOOLEAN:C305(v_115_042_b)  //PRJ_FederalReviewRequired_b
			ARRAY BOOLEAN:C223(v_115_042_ab; 0)  //PRJ_FederalReviewRequired_b
			C_BOOLEAN:C305(v_115_052_b)  //PRJ_Chapter85_b
			ARRAY BOOLEAN:C223(v_115_052_ab; 0)  //PRJ_Chapter85_b
		: ($1=116)  //PRJ_ConstructionProject
			C_BLOB:C604(v_116_021_blb)  //CP_AEData_blb
			ARRAY BLOB:C1222(v_116_021_ablb; 0)  //CP_AEData_blb
			C_TEXT:C284(v_116_029_txt)  //PRJ_ConstructionProje_UUIDKey_s
			ARRAY TEXT:C222(v_116_029_atxt; 0)  //PRJ_ConstructionProje_UUIDKey_s
			C_TEXT:C284(v_116_005_txt)  //CP_ConstructionContractNo_s
			ARRAY TEXT:C222(v_116_005_atxt; 0)  //CP_ConstructionContractNo_s
			C_TEXT:C284(v_116_009_txt)  //CP_EWO_s
			ARRAY TEXT:C222(v_116_009_atxt; 0)  //CP_EWO_s
			C_TEXT:C284(v_116_022_txt)  //CP_AEDescription_txt
			ARRAY TEXT:C222(v_116_022_atxt; 0)  //CP_AEDescription_txt
			C_TEXT:C284(v_116_023_txt)  //CP_AELocation_s
			ARRAY TEXT:C222(v_116_023_atxt; 0)  //CP_AELocation_s
			C_TEXT:C284(v_116_024_txt)  //CP_FederalAidNo_s
			ARRAY TEXT:C222(v_116_024_atxt; 0)  //CP_FederalAidNo_s
			C_REAL:C285(v_116_006_r)  //CP_BidEstimate_r
			ARRAY REAL:C219(v_116_006_ar; 0)  //CP_BidEstimate_r
			C_REAL:C285(v_116_007_r)  //CP_LowBid_r
			ARRAY REAL:C219(v_116_007_ar; 0)  //CP_LowBid_r
			C_REAL:C285(v_116_019_r)  //CP_LowBid_2_r
			ARRAY REAL:C219(v_116_019_ar; 0)  //CP_LowBid_2_r
			C_REAL:C285(v_116_025_r)  //CP_Encumbered_r
			ARRAY REAL:C219(v_116_025_ar; 0)  //CP_Encumbered_r
			C_REAL:C285(v_116_026_r)  //CP_Spent_r
			ARRAY REAL:C219(v_116_026_ar; 0)  //CP_Spent_r
			C_REAL:C285(v_116_027_r)  //CP_Remaining_r
			ARRAY REAL:C219(v_116_027_ar; 0)  //CP_Remaining_r
			C_LONGINT:C283(v_116_001_L)  //CP_ConstructionProjectID_l
			ARRAY LONGINT:C221(v_116_001_aL; 0)  //CP_ConstructionProjectID_l
			C_LONGINT:C283(v_116_002_L)  //CTR_ContractorID_l
			ARRAY LONGINT:C221(v_116_002_aL; 0)  //CTR_ContractorID_l
			C_LONGINT:C283(v_116_011_L)  //PF_FileID_l
			ARRAY LONGINT:C221(v_116_011_aL; 0)  //PF_FileID_l
			C_LONGINT:C283(v_116_013_L)  //CP_SQLID_l
			ARRAY LONGINT:C221(v_116_013_aL; 0)  //CP_SQLID_l
			C_LONGINT:C283(v_116_020_L)  //CP_LowBidder_2_l
			ARRAY LONGINT:C221(v_116_020_aL; 0)  //CP_LowBidder_2_l
			C_DATE:C307(v_116_003_d)  //CP_BidOpening_d
			ARRAY DATE:C224(v_116_003_ad; 0)  //CP_BidOpening_d
			C_DATE:C307(v_116_004_d)  //CP_Awarded_d
			ARRAY DATE:C224(v_116_004_ad; 0)  //CP_Awarded_d
			C_DATE:C307(v_116_008_d)  //CP_Completion_d
			ARRAY DATE:C224(v_116_008_ad; 0)  //CP_Completion_d
			C_DATE:C307(v_116_012_d)  //CP_NTP_d
			ARRAY DATE:C224(v_116_012_ad; 0)  //CP_NTP_d
			C_DATE:C307(v_116_014_d)  //CP_SpecsToPrint_d
			ARRAY DATE:C224(v_116_014_ad; 0)  //CP_SpecsToPrint_d
			C_DATE:C307(v_116_015_d)  //CP_SpecsFromPrint_d
			ARRAY DATE:C224(v_116_015_ad; 0)  //CP_SpecsFromPrint_d
			C_DATE:C307(v_116_016_d)  //CP_PlansToPrint_d
			ARRAY DATE:C224(v_116_016_ad; 0)  //CP_PlansToPrint_d
			C_DATE:C307(v_116_017_d)  //CP_PlansFromPrint_d
			ARRAY DATE:C224(v_116_017_ad; 0)  //CP_PlansFromPrint_d
			C_DATE:C307(v_116_018_d)  //CP_ToCashier_d
			ARRAY DATE:C224(v_116_018_ad; 0)  //CP_ToCashier_d
			C_DATE:C307(v_116_028_d)  //AEAward_d
			ARRAY DATE:C224(v_116_028_ad; 0)  //AEAward_d
			C_BOOLEAN:C305(v_116_010_b)  //CP_FromSQL_b
			ARRAY BOOLEAN:C223(v_116_010_ab; 0)  //CP_FromSQL_b
		: ($1=117)  //PRJ_ProjectFile
			C_TEXT:C284(v_117_025_txt)  //PRJ_ProjectFile_UUIDKey_s
			ARRAY TEXT:C222(v_117_025_atxt; 0)  //PRJ_ProjectFile_UUIDKey_s
			C_TEXT:C284(v_117_004_txt)  //PF_EWO_s
			ARRAY TEXT:C222(v_117_004_atxt; 0)  //PF_EWO_s
			C_TEXT:C284(v_117_006_txt)  //PF_ProjectExpediter_s
			ARRAY TEXT:C222(v_117_006_atxt; 0)  //PF_ProjectExpediter_s
			C_TEXT:C284(v_117_007_txt)  //PF_TIP_s
			ARRAY TEXT:C222(v_117_007_atxt; 0)  //PF_TIP_s
			C_TEXT:C284(v_117_016_txt)  //PF_Description_txt
			ARRAY TEXT:C222(v_117_016_atxt; 0)  //PF_Description_txt
			C_TEXT:C284(v_117_017_txt)  //PF_TypeCode_s
			ARRAY TEXT:C222(v_117_017_atxt; 0)  //PF_TypeCode_s
			C_TEXT:C284(v_117_021_txt)  //PF_PNFEvent_s
			ARRAY TEXT:C222(v_117_021_atxt; 0)  //PF_PNFEvent_s
			C_TEXT:C284(v_117_022_txt)  //PF_PIFEvent_s
			ARRAY TEXT:C222(v_117_022_atxt; 0)  //PF_PIFEvent_s
			C_TEXT:C284(v_117_023_txt)  //PF_PRCEvent_s
			ARRAY TEXT:C222(v_117_023_atxt; 0)  //PF_PRCEvent_s
			C_REAL:C285(v_117_008_r)  //PF_InitialBidEstimate_r
			ARRAY REAL:C219(v_117_008_ar; 0)  //PF_InitialBidEstimate_r
			C_REAL:C285(v_117_009_r)  //PF_CostAd_r
			ARRAY REAL:C219(v_117_009_ar; 0)  //PF_CostAd_r
			C_REAL:C285(v_117_010_r)  //PF_EstTotalCost_r
			ARRAY REAL:C219(v_117_010_ar; 0)  //PF_EstTotalCost_r
			C_REAL:C285(v_117_013_r)  //PF_OfficeEstimate_r
			ARRAY REAL:C219(v_117_013_ar; 0)  //PF_OfficeEstimate_r
			C_LONGINT:C283(v_117_001_L)  //PF_FileID_l
			ARRAY LONGINT:C221(v_117_001_aL; 0)  //PF_FileID_l
			C_LONGINT:C283(v_117_002_L)  //DC_OLDDesignContractID_l
			ARRAY LONGINT:C221(v_117_002_aL; 0)  //DC_OLDDesignContractID_l
			C_LONGINT:C283(v_117_003_L)  //PF_FileNumber_l
			ARRAY LONGINT:C221(v_117_003_aL; 0)  //PF_FileNumber_l
			C_LONGINT:C283(v_117_015_L)  //PF_OLDConsultantOverideID_l
			ARRAY LONGINT:C221(v_117_015_aL; 0)  //PF_OLDConsultantOverideID_l
			C_DATE:C307(v_117_005_d)  //PF_ScheduledAdvertising_d
			ARRAY DATE:C224(v_117_005_ad; 0)  //PF_ScheduledAdvertising_d
			C_DATE:C307(v_117_012_d)  //PF_BidOpened_d
			ARRAY DATE:C224(v_117_012_ad; 0)  //PF_BidOpened_d
			C_DATE:C307(v_117_014_d)  //PF_Advertised_d
			ARRAY DATE:C224(v_117_014_ad; 0)  //PF_Advertised_d
			C_DATE:C307(v_117_018_d)  //PF_PNFDate_d
			ARRAY DATE:C224(v_117_018_ad; 0)  //PF_PNFDate_d
			C_DATE:C307(v_117_019_d)  //PF_PIFDate_d
			ARRAY DATE:C224(v_117_019_ad; 0)  //PF_PIFDate_d
			C_DATE:C307(v_117_020_d)  //PF_PRCApprDate_d
			ARRAY DATE:C224(v_117_020_ad; 0)  //PF_PRCApprDate_d
			C_DATE:C307(v_117_024_d)  //PF_PRCSubmDate_d
			ARRAY DATE:C224(v_117_024_ad; 0)  //PF_PRCSubmDate_d
			C_BOOLEAN:C305(v_117_011_b)  //PF_FromSQL_b
			ARRAY BOOLEAN:C223(v_117_011_ab; 0)  //PF_FromSQL_b
		: ($1=118)  //PRJ_ReportData
			C_TEXT:C284(v_118_010_txt)  //PRJ_ReportData_UUIDKey_s
			ARRAY TEXT:C222(v_118_010_atxt; 0)  //PRJ_ReportData_UUIDKey_s
			C_TEXT:C284(v_118_002_txt)  //RPT_ReportType_s
			ARRAY TEXT:C222(v_118_002_atxt; 0)  //RPT_ReportType_s
			C_TEXT:C284(v_118_005_txt)  //RPT_ApprovedBy_s
			ARRAY TEXT:C222(v_118_005_atxt; 0)  //RPT_ApprovedBy_s
			C_TEXT:C284(v_118_006_txt)  //RPT_Comments_txt
			ARRAY TEXT:C222(v_118_006_atxt; 0)  //RPT_Comments_txt
			C_TEXT:C284(v_118_007_txt)  //RPT_Source_s
			ARRAY TEXT:C222(v_118_007_atxt; 0)  //RPT_Source_s
			C_TEXT:C284(v_118_008_txt)  //RPT_ModifiedBy_s
			ARRAY TEXT:C222(v_118_008_atxt; 0)  //RPT_ModifiedBy_s
			C_TEXT:C284(v_118_009_txt)  //RPT_ModifiedTimeStamp_s
			ARRAY TEXT:C222(v_118_009_atxt; 0)  //RPT_ModifiedTimeStamp_s
			C_LONGINT:C283(v_118_001_L)  //PRJ_ProjectID_l
			ARRAY LONGINT:C221(v_118_001_aL; 0)  //PRJ_ProjectID_l
			C_DATE:C307(v_118_003_d)  //RPT_Received_d
			ARRAY DATE:C224(v_118_003_ad; 0)  //RPT_Received_d
			C_DATE:C307(v_118_004_d)  //RPT_Approved_d
			ARRAY DATE:C224(v_118_004_ad; 0)  //RPT_Approved_d
		: ($1=119)  //PRJ_StructuralReview
			C_TEXT:C284(v_119_011_txt)  //PRJ_StructuralReview_UUIDKey_s
			ARRAY TEXT:C222(v_119_011_atxt; 0)  //PRJ_StructuralReview_UUIDKey_s
			C_TEXT:C284(v_119_005_txt)  //SR_Comments_txt
			ARRAY TEXT:C222(v_119_005_atxt; 0)  //SR_Comments_txt
			C_TEXT:C284(v_119_008_txt)  //SR_ModifiedBy_s
			ARRAY TEXT:C222(v_119_008_atxt; 0)  //SR_ModifiedBy_s
			C_TEXT:C284(v_119_009_txt)  //SR_ModifiedTimeStamp_s
			ARRAY TEXT:C222(v_119_009_atxt; 0)  //SR_ModifiedTimeStamp_s
			C_LONGINT:C283(v_119_001_L)  //PRJ_ProjectID_l
			ARRAY LONGINT:C221(v_119_001_aL; 0)  //PRJ_ProjectID_l
			C_LONGINT:C283(v_119_002_L)  //RV_ReviewID_l
			ARRAY LONGINT:C221(v_119_002_aL; 0)  //RV_ReviewID_l
			C_LONGINT:C283(v_119_003_L)  //SR_StructureReviewOrder_l
			ARRAY LONGINT:C221(v_119_003_aL; 0)  //SR_StructureReviewOrder_l
			C_LONGINT:C283(v_119_010_L)  //SR_GradingStatus_l
			ARRAY LONGINT:C221(v_119_010_aL; 0)  //SR_GradingStatus_l
			C_DATE:C307(v_119_004_d)  //SR_CommentsToDesigner_d
			ARRAY DATE:C224(v_119_004_ad; 0)  //SR_CommentsToDesigner_d
			C_DATE:C307(v_119_006_d)  //SR_Assigned_d
			ARRAY DATE:C224(v_119_006_ad; 0)  //SR_Assigned_d
			C_DATE:C307(v_119_007_d)  //SR_Received_d
			ARRAY DATE:C224(v_119_007_ad; 0)  //SR_Received_d
		: ($1=120)  //PRJ_SketchPlans
			C_TEXT:C284(v_120_017_txt)  //PRJ_SketchPlans_UUIDKey_s
			ARRAY TEXT:C222(v_120_017_atxt; 0)  //PRJ_SketchPlans_UUIDKey_s
			C_TEXT:C284(v_120_004_txt)  //SKT_Comments_txt
			ARRAY TEXT:C222(v_120_004_atxt; 0)  //SKT_Comments_txt
			C_TEXT:C284(v_120_014_txt)  //SKT_ModifiedBy_s
			ARRAY TEXT:C222(v_120_014_atxt; 0)  //SKT_ModifiedBy_s
			C_TEXT:C284(v_120_015_txt)  //SKT_ModifiedTimeStamp_s
			ARRAY TEXT:C222(v_120_015_atxt; 0)  //SKT_ModifiedTimeStamp_s
			C_LONGINT:C283(v_120_001_L)  //PRJ_ProjectID_l
			ARRAY LONGINT:C221(v_120_001_aL; 0)  //PRJ_ProjectID_l
			C_LONGINT:C283(v_120_002_L)  //RV_ReviewID_l
			ARRAY LONGINT:C221(v_120_002_aL; 0)  //RV_ReviewID_l
			C_LONGINT:C283(v_120_003_L)  //SKT_SubmissionNumber_l
			ARRAY LONGINT:C221(v_120_003_aL; 0)  //SKT_SubmissionNumber_l
			C_LONGINT:C283(v_120_016_L)  //SKT_GradingStatus_l
			ARRAY LONGINT:C221(v_120_016_aL; 0)  //SKT_GradingStatus_l
			C_DATE:C307(v_120_005_d)  //SKT_Recieved_d
			ARRAY DATE:C224(v_120_005_ad; 0)  //SKT_Recieved_d
			C_DATE:C307(v_120_006_d)  //SKT_Assigned_d
			ARRAY DATE:C224(v_120_006_ad; 0)  //SKT_Assigned_d
			C_DATE:C307(v_120_007_d)  //SKT_AssToGeotech_d
			ARRAY DATE:C224(v_120_007_ad; 0)  //SKT_AssToGeotech_d
			C_DATE:C307(v_120_008_d)  //SKT_AssToHydro_d
			ARRAY DATE:C224(v_120_008_ad; 0)  //SKT_AssToHydro_d
			C_DATE:C307(v_120_009_d)  //SKT_ReceivedFromGeotech_d
			ARRAY DATE:C224(v_120_009_ad; 0)  //SKT_ReceivedFromGeotech_d
			C_DATE:C307(v_120_010_d)  //SKT_ReceivedFromHydro_d
			ARRAY DATE:C224(v_120_010_ad; 0)  //SKT_ReceivedFromHydro_d
			C_DATE:C307(v_120_011_d)  //SKT_CommentsToDE_d
			ARRAY DATE:C224(v_120_011_ad; 0)  //SKT_CommentsToDE_d
			C_DATE:C307(v_120_012_d)  //SKT_DistributionForSignature_d
			ARRAY DATE:C224(v_120_012_ad; 0)  //SKT_DistributionForSignature_d
			C_DATE:C307(v_120_013_d)  //SKT_ChiefEngApproval_d
			ARRAY DATE:C224(v_120_013_ad; 0)  //SKT_ChiefEngApproval_d
		: ($1=121)  //PRJ_TypeStudy
			C_TEXT:C284(v_121_016_txt)  //PRJ_TypeStudy_UUIDKey_s
			ARRAY TEXT:C222(v_121_016_atxt; 0)  //PRJ_TypeStudy_UUIDKey_s
			C_TEXT:C284(v_121_003_txt)  //TYP_StudyType_s
			ARRAY TEXT:C222(v_121_003_atxt; 0)  //TYP_StudyType_s
			C_TEXT:C284(v_121_004_txt)  //TYP_StructureType_s
			ARRAY TEXT:C222(v_121_004_atxt; 0)  //TYP_StructureType_s
			C_TEXT:C284(v_121_006_txt)  //TYP_Source_s
			ARRAY TEXT:C222(v_121_006_atxt; 0)  //TYP_Source_s
			C_TEXT:C284(v_121_012_txt)  //TYP_Comments_txt
			ARRAY TEXT:C222(v_121_012_atxt; 0)  //TYP_Comments_txt
			C_TEXT:C284(v_121_013_txt)  //TYP_ModifiedBy_s
			ARRAY TEXT:C222(v_121_013_atxt; 0)  //TYP_ModifiedBy_s
			C_TEXT:C284(v_121_014_txt)  //TYP_ModifiedTimeStamp_s
			ARRAY TEXT:C222(v_121_014_atxt; 0)  //TYP_ModifiedTimeStamp_s
			C_LONGINT:C283(v_121_001_L)  //PRJ_ProjectID_l
			ARRAY LONGINT:C221(v_121_001_aL; 0)  //PRJ_ProjectID_l
			C_LONGINT:C283(v_121_002_L)  //RV_ReviewID_l
			ARRAY LONGINT:C221(v_121_002_aL; 0)  //RV_ReviewID_l
			C_LONGINT:C283(v_121_015_L)  //TYP_GradingStatus_l
			ARRAY LONGINT:C221(v_121_015_aL; 0)  //TYP_GradingStatus_l
			C_DATE:C307(v_121_005_d)  //TYP_Received_d
			ARRAY DATE:C224(v_121_005_ad; 0)  //TYP_Received_d
			C_DATE:C307(v_121_007_d)  //TYP_Distribution_d
			ARRAY DATE:C224(v_121_007_ad; 0)  //TYP_Distribution_d
			C_DATE:C307(v_121_008_d)  //TYP_RecFromHydro_d
			ARRAY DATE:C224(v_121_008_ad; 0)  //TYP_RecFromHydro_d
			C_DATE:C307(v_121_009_d)  //TYP_RecFromGeotech_d
			ARRAY DATE:C224(v_121_009_ad; 0)  //TYP_RecFromGeotech_d
			C_DATE:C307(v_121_010_d)  //TYP_Approved_d
			ARRAY DATE:C224(v_121_010_ad; 0)  //TYP_Approved_d
			C_DATE:C307(v_121_011_d)  //TYP_CommentsToDE_d
			ARRAY DATE:C224(v_121_011_ad; 0)  //TYP_CommentsToDE_d
		: ($1=122)  //PRJ_ProjectDetailsIncludedBINS
			C_TEXT:C284(v_122_007_txt)  //PRJ_ProjectDetailsInc_UUIDKey_s
			ARRAY TEXT:C222(v_122_007_atxt; 0)  //PRJ_ProjectDetailsInc_UUIDKey_s
			C_TEXT:C284(v_122_002_txt)  //PDB_BIN_s
			ARRAY TEXT:C222(v_122_002_atxt; 0)  //PDB_BIN_s
			C_TEXT:C284(v_122_003_txt)  //PDB_BDEPT_s
			ARRAY TEXT:C222(v_122_003_atxt; 0)  //PDB_BDEPT_s
			C_LONGINT:C283(v_122_001_L)  //PRJ_ProjectID_l
			ARRAY LONGINT:C221(v_122_001_aL; 0)  //PRJ_ProjectID_l
			C_LONGINT:C283(v_122_006_L)  //PDB_GroupNumber_l
			ARRAY LONGINT:C221(v_122_006_aL; 0)  //PDB_GroupNumber_l
			C_DATE:C307(v_122_005_d)  //PDB_Date_d
			ARRAY DATE:C224(v_122_005_ad; 0)  //PDB_Date_d
			C_BOOLEAN:C305(v_122_004_b)  //PDB_NewBIN_b
			ARRAY BOOLEAN:C223(v_122_004_ab; 0)  //PDB_NewBIN_b
		: ($1=123)  //PRJ_DesignContracts
			C_TEXT:C284(v_123_018_txt)  //PRJ_DesignContracts_UUIDKey_s
			ARRAY TEXT:C222(v_123_018_atxt; 0)  //PRJ_DesignContracts_UUIDKey_s
			C_TEXT:C284(v_123_004_txt)  //DC_Description_txt
			ARRAY TEXT:C222(v_123_004_atxt; 0)  //DC_Description_txt
			C_TEXT:C284(v_123_009_txt)  //DC_ProgramType_s
			ARRAY TEXT:C222(v_123_009_atxt; 0)  //DC_ProgramType_s
			C_TEXT:C284(v_123_013_txt)  //DC_ContractManager_s
			ARRAY TEXT:C222(v_123_013_atxt; 0)  //DC_ContractManager_s
			C_TEXT:C284(v_123_014_txt)  //DC_ContrTypeDesc_s
			ARRAY TEXT:C222(v_123_014_atxt; 0)  //DC_ContrTypeDesc_s
			C_TEXT:C284(v_123_015_txt)  //DC_ContrFedAidNos_s
			ARRAY TEXT:C222(v_123_015_atxt; 0)  //DC_ContrFedAidNos_s
			C_TEXT:C284(v_123_016_txt)  //DC_ContractStatus_s
			ARRAY TEXT:C222(v_123_016_atxt; 0)  //DC_ContractStatus_s
			C_REAL:C285(v_123_005_r)  //DC_ProjectInfoAmount_r
			ARRAY REAL:C219(v_123_005_ar; 0)  //DC_ProjectInfoAmount_r
			C_REAL:C285(v_123_006_r)  //DC_ActualAmount_r
			ARRAY REAL:C219(v_123_006_ar; 0)  //DC_ActualAmount_r
			C_REAL:C285(v_123_007_r)  //DC_RemainingAmount_r
			ARRAY REAL:C219(v_123_007_ar; 0)  //DC_RemainingAmount_r
			C_REAL:C285(v_123_010_r)  //DC_ESTContractAmt_r
			ARRAY REAL:C219(v_123_010_ar; 0)  //DC_ESTContractAmt_r
			C_LONGINT:C283(v_123_001_L)  //DC_DesignContractID_l
			ARRAY LONGINT:C221(v_123_001_aL; 0)  //DC_DesignContractID_l
			C_LONGINT:C283(v_123_002_L)  //ConsultantNameID_l
			ARRAY LONGINT:C221(v_123_002_aL; 0)  //ConsultantNameID_l
			C_LONGINT:C283(v_123_003_L)  //DC_DesignContractNumber_l
			ARRAY LONGINT:C221(v_123_003_aL; 0)  //DC_DesignContractNumber_l
			C_LONGINT:C283(v_123_017_L)  //DC_SQLContractID_l
			ARRAY LONGINT:C221(v_123_017_aL; 0)  //DC_SQLContractID_l
			C_DATE:C307(v_123_008_d)  //DC_Completion_d
			ARRAY DATE:C224(v_123_008_ad; 0)  //DC_Completion_d
			C_DATE:C307(v_123_011_d)  //DC_EstComplete_d
			ARRAY DATE:C224(v_123_011_ad; 0)  //DC_EstComplete_d
			C_BOOLEAN:C305(v_123_012_b)  //DC_FromSQL_b
			ARRAY BOOLEAN:C223(v_123_012_ab; 0)  //DC_FromSQL_b
		: ($1=124)  //PRJ_ProjectTimeTracking
			C_TEXT:C284(v_124_012_txt)  //PRJ_ProjectTimeTracki_UUIDKey_s
			ARRAY TEXT:C222(v_124_012_atxt; 0)  //PRJ_ProjectTimeTracki_UUIDKey_s
			C_TEXT:C284(v_124_005_txt)  //PT_Coments_txt
			ARRAY TEXT:C222(v_124_005_atxt; 0)  //PT_Coments_txt
			C_TEXT:C284(v_124_008_txt)  //PT_EWO_s
			ARRAY TEXT:C222(v_124_008_atxt; 0)  //PT_EWO_s
			C_TEXT:C284(v_124_009_txt)  //PT_ModifiedBy_s
			ARRAY TEXT:C222(v_124_009_atxt; 0)  //PT_ModifiedBy_s
			C_TEXT:C284(v_124_010_txt)  //PT_ModifiedTimeStamp_s
			ARRAY TEXT:C222(v_124_010_atxt; 0)  //PT_ModifiedTimeStamp_s
			C_TEXT:C284(v_124_011_txt)  //PT_Scope_s
			ARRAY TEXT:C222(v_124_011_atxt; 0)  //PT_Scope_s
			C_REAL:C285(v_124_006_r)  //PT_Hours_r
			ARRAY REAL:C219(v_124_006_ar; 0)  //PT_Hours_r
			C_REAL:C285(v_124_007_r)  //PT_HourlyRate_r
			ARRAY REAL:C219(v_124_007_ar; 0)  //PT_HourlyRate_r
			C_LONGINT:C283(v_124_003_L)  //Person ID
			ARRAY INTEGER:C220(v_124_003_ai; 0)  //Person ID
			C_LONGINT:C283(v_124_001_L)  //PT_TimeTrackingID_l
			ARRAY LONGINT:C221(v_124_001_aL; 0)  //PT_TimeTrackingID_l
			C_LONGINT:C283(v_124_002_L)  //PRJ_ProjectID_l
			ARRAY LONGINT:C221(v_124_002_aL; 0)  //PRJ_ProjectID_l
			C_DATE:C307(v_124_004_d)  //PT_WeekEnding_d
			ARRAY DATE:C224(v_124_004_ad; 0)  //PT_WeekEnding_d
		: ($1=125)  //TableOfLists
			C_TEXT:C284(v_125_005_txt)  //TableOfLists_UUIDKey_s
			ARRAY TEXT:C222(v_125_005_atxt; 0)  //TableOfLists_UUIDKey_s
			C_TEXT:C284(v_125_001_txt)  //ListName_s
			ARRAY TEXT:C222(v_125_001_atxt; 0)  //ListName_s
			C_TEXT:C284(v_125_002_txt)  //ListValue_s
			ARRAY TEXT:C222(v_125_002_atxt; 0)  //ListValue_s
			C_LONGINT:C283(v_125_003_L)  //ListSequence_l
			ARRAY LONGINT:C221(v_125_003_aL; 0)  //ListSequence_l
			C_LONGINT:C283(v_125_004_L)  //ListKeyID_L
			ARRAY LONGINT:C221(v_125_004_aL; 0)  //ListKeyID_L
		: ($1=126)  //SQL_Connections
			C_TEXT:C284(v_126_007_txt)  //SQL_Connections_UUIDKey_s
			ARRAY TEXT:C222(v_126_007_atxt; 0)  //SQL_Connections_UUIDKey_s
			C_TEXT:C284(v_126_001_txt)  //SQL_DatabaseName_s
			ARRAY TEXT:C222(v_126_001_atxt; 0)  //SQL_DatabaseName_s
			C_TEXT:C284(v_126_002_txt)  //SQL_UserName_s
			ARRAY TEXT:C222(v_126_002_atxt; 0)  //SQL_UserName_s
			C_TEXT:C284(v_126_003_txt)  //SQL_Password_s
			ARRAY TEXT:C222(v_126_003_atxt; 0)  //SQL_Password_s
			C_TEXT:C284(v_126_004_txt)  //SQL_OBDCName_s
			ARRAY TEXT:C222(v_126_004_atxt; 0)  //SQL_OBDCName_s
			C_TEXT:C284(v_126_006_txt)  //SQL_SCHEMA_s
			ARRAY TEXT:C222(v_126_006_atxt; 0)  //SQL_SCHEMA_s
			C_DATE:C307(v_126_005_d)  //SQL_LastUpdate_d
			ARRAY DATE:C224(v_126_005_ad; 0)  //SQL_LastUpdate_d
		: ($1=127)  //Conslt_Name
			C_TEXT:C284(v_127_005_txt)  //Conslt_Name_UUIDKey_s
			ARRAY TEXT:C222(v_127_005_atxt; 0)  //Conslt_Name_UUIDKey_s
			C_TEXT:C284(v_127_002_txt)  //ConsultantName_s
			ARRAY TEXT:C222(v_127_002_atxt; 0)  //ConsultantName_s
			C_LONGINT:C283(v_127_001_L)  //ConsultantNameID_l
			ARRAY LONGINT:C221(v_127_001_aL; 0)  //ConsultantNameID_l
			C_LONGINT:C283(v_127_003_L)  //SQL_VendorID_l
			ARRAY LONGINT:C221(v_127_003_aL; 0)  //SQL_VendorID_l
			C_LONGINT:C283(v_127_004_L)  //CurrentStructureProjectMgr_l
			ARRAY LONGINT:C221(v_127_004_aL; 0)  //CurrentStructureProjectMgr_l
		: ($1=128)  //PRJ_StrPrjManagerHistory
			C_TEXT:C284(v_128_004_txt)  //PRJ_StrPrjManagerHist_UUIDKey_s
			ARRAY TEXT:C222(v_128_004_atxt; 0)  //PRJ_StrPrjManagerHist_UUIDKey_s
			C_TEXT:C284(v_128_002_txt)  //SPMH_StructuralProjManager_txt
			ARRAY TEXT:C222(v_128_002_atxt; 0)  //SPMH_StructuralProjManager_txt
			C_LONGINT:C283(v_128_001_L)  //PRJ_ProjectID_l
			ARRAY LONGINT:C221(v_128_001_aL; 0)  //PRJ_ProjectID_l
			C_DATE:C307(v_128_003_d)  //SPMH_Replaced_d
			ARRAY DATE:C224(v_128_003_ad; 0)  //SPMH_Replaced_d
		: ($1=129)  //Scour Report
			C_TEXT:C284(v_129_045_txt)  //Scour_Report_UUIDKey_s
			ARRAY TEXT:C222(v_129_045_atxt; 0)  //Scour_Report_UUIDKey_s
			C_TEXT:C284(v_129_042_txt)  //Owner
			ARRAY TEXT:C222(v_129_042_atxt; 0)  //Owner
			C_TEXT:C284(v_129_044_txt)  //Comments
			ARRAY TEXT:C222(v_129_044_atxt; 0)  //Comments
			C_REAL:C285(v_129_002_r)  //On_State_LowRiskTotal
			ARRAY REAL:C219(v_129_002_ar; 0)  //On_State_LowRiskTotal
			C_REAL:C285(v_129_003_r)  //On_State_ScourSuscept
			ARRAY REAL:C219(v_129_003_ar; 0)  //On_State_ScourSuscept
			C_REAL:C285(v_129_004_r)  //On_State_Unknown
			ARRAY REAL:C219(v_129_004_ar; 0)  //On_State_Unknown
			C_REAL:C285(v_129_005_r)  //On_State_Tidal
			ARRAY REAL:C219(v_129_005_ar; 0)  //On_State_Tidal
			C_REAL:C285(v_129_006_r)  //On_State_ScourCrit
			ARRAY REAL:C219(v_129_006_ar; 0)  //On_State_ScourCrit
			C_REAL:C285(v_129_007_r)  //On_State_Counter
			ARRAY REAL:C219(v_129_007_ar; 0)  //On_State_Counter
			C_REAL:C285(v_129_008_r)  //On_State_Monitor
			ARRAY REAL:C219(v_129_008_ar; 0)  //On_State_Monitor
			C_REAL:C285(v_129_009_r)  //On_State_LRT_Calc
			ARRAY REAL:C219(v_129_009_ar; 0)  //On_State_LRT_Calc
			C_REAL:C285(v_129_010_r)  //On_State_LRT_Screen
			ARRAY REAL:C219(v_129_010_ar; 0)  //On_State_LRT_Screen
			C_REAL:C285(v_129_011_r)  //On_State_LRT_Culv
			ARRAY REAL:C219(v_129_011_ar; 0)  //On_State_LRT_Culv
			C_REAL:C285(v_129_012_r)  //Off_State_LowRiskTotal
			ARRAY REAL:C219(v_129_012_ar; 0)  //Off_State_LowRiskTotal
			C_REAL:C285(v_129_013_r)  //Off_State_ScourSuscept
			ARRAY REAL:C219(v_129_013_ar; 0)  //Off_State_ScourSuscept
			C_REAL:C285(v_129_014_r)  //Off_State_Unknown
			ARRAY REAL:C219(v_129_014_ar; 0)  //Off_State_Unknown
			C_REAL:C285(v_129_015_r)  //Off_State_Tidal
			ARRAY REAL:C219(v_129_015_ar; 0)  //Off_State_Tidal
			C_REAL:C285(v_129_016_r)  //Off_State_ScourCrit
			ARRAY REAL:C219(v_129_016_ar; 0)  //Off_State_ScourCrit
			C_REAL:C285(v_129_017_r)  //Off_State_Counter
			ARRAY REAL:C219(v_129_017_ar; 0)  //Off_State_Counter
			C_REAL:C285(v_129_018_r)  //Off_State_Monitor
			ARRAY REAL:C219(v_129_018_ar; 0)  //Off_State_Monitor
			C_REAL:C285(v_129_019_r)  //Off_State_LRT_Calc
			ARRAY REAL:C219(v_129_019_ar; 0)  //Off_State_LRT_Calc
			C_REAL:C285(v_129_020_r)  //Off_State_LRT_Screen
			ARRAY REAL:C219(v_129_020_ar; 0)  //Off_State_LRT_Screen
			C_REAL:C285(v_129_021_r)  //Off_State_LRT_Culv
			ARRAY REAL:C219(v_129_021_ar; 0)  //Off_State_LRT_Culv
			C_REAL:C285(v_129_022_r)  //On_Agency_LowRiskTotal
			ARRAY REAL:C219(v_129_022_ar; 0)  //On_Agency_LowRiskTotal
			C_REAL:C285(v_129_023_r)  //On_Agency_ScourSuscept
			ARRAY REAL:C219(v_129_023_ar; 0)  //On_Agency_ScourSuscept
			C_REAL:C285(v_129_024_r)  //On_Agency_Unknown
			ARRAY REAL:C219(v_129_024_ar; 0)  //On_Agency_Unknown
			C_REAL:C285(v_129_025_r)  //On_Agency_Tidal
			ARRAY REAL:C219(v_129_025_ar; 0)  //On_Agency_Tidal
			C_REAL:C285(v_129_026_r)  //On_Agency_ScourCrit
			ARRAY REAL:C219(v_129_026_ar; 0)  //On_Agency_ScourCrit
			C_REAL:C285(v_129_027_r)  //On_Agency_Counter
			ARRAY REAL:C219(v_129_027_ar; 0)  //On_Agency_Counter
			C_REAL:C285(v_129_028_r)  //On_Agency_Monitor
			ARRAY REAL:C219(v_129_028_ar; 0)  //On_Agency_Monitor
			C_REAL:C285(v_129_029_r)  //On_Agency_LRT_Calc
			ARRAY REAL:C219(v_129_029_ar; 0)  //On_Agency_LRT_Calc
			C_REAL:C285(v_129_030_r)  //On_Agency_LRT_Screen
			ARRAY REAL:C219(v_129_030_ar; 0)  //On_Agency_LRT_Screen
			C_REAL:C285(v_129_031_r)  //On_Agency_LRT_Culv
			ARRAY REAL:C219(v_129_031_ar; 0)  //On_Agency_LRT_Culv
			C_REAL:C285(v_129_032_r)  //Off_Agency_LowRiskTotal
			ARRAY REAL:C219(v_129_032_ar; 0)  //Off_Agency_LowRiskTotal
			C_REAL:C285(v_129_033_r)  //Off_Agency_ScourSuscept
			ARRAY REAL:C219(v_129_033_ar; 0)  //Off_Agency_ScourSuscept
			C_REAL:C285(v_129_034_r)  //Off_Agency_Unknown
			ARRAY REAL:C219(v_129_034_ar; 0)  //Off_Agency_Unknown
			C_REAL:C285(v_129_035_r)  //Off_Agency_Tidal
			ARRAY REAL:C219(v_129_035_ar; 0)  //Off_Agency_Tidal
			C_REAL:C285(v_129_036_r)  //Off_Agency_ScourCrit
			ARRAY REAL:C219(v_129_036_ar; 0)  //Off_Agency_ScourCrit
			C_REAL:C285(v_129_037_r)  //Off_Agency_Counter
			ARRAY REAL:C219(v_129_037_ar; 0)  //Off_Agency_Counter
			C_REAL:C285(v_129_038_r)  //Off_Agency_Monitor
			ARRAY REAL:C219(v_129_038_ar; 0)  //Off_Agency_Monitor
			C_REAL:C285(v_129_039_r)  //Off_Agency_LRT_Calc
			ARRAY REAL:C219(v_129_039_ar; 0)  //Off_Agency_LRT_Calc
			C_REAL:C285(v_129_040_r)  //Off_Agency_LRT_Screen
			ARRAY REAL:C219(v_129_040_ar; 0)  //Off_Agency_LRT_Screen
			C_REAL:C285(v_129_041_r)  //Off_Agency_LRT_Culv
			ARRAY REAL:C219(v_129_041_ar; 0)  //Off_Agency_LRT_Culv
			C_DATE:C307(v_129_001_d)  //ReportDate
			ARRAY DATE:C224(v_129_001_ad; 0)  //ReportDate
			C_TIME:C306(v_129_043_tm)  //Time_Created
			ARRAY TIME:C1223(v_129_043_atm; 0)  //Time_Created
		: ($1=130)  //PRJ_Attributes
			C_TEXT:C284(v_130_008_txt)  //PRJ_Attributes_UUIDKey_s
			ARRAY TEXT:C222(v_130_008_atxt; 0)  //PRJ_Attributes_UUIDKey_s
			C_TEXT:C284(v_130_002_txt)  //ATTR_Name_s
			ARRAY TEXT:C222(v_130_002_atxt; 0)  //ATTR_Name_s
			C_TEXT:C284(v_130_003_txt)  //ATTR_Description_txt
			ARRAY TEXT:C222(v_130_003_atxt; 0)  //ATTR_Description_txt
			C_TEXT:C284(v_130_006_txt)  //ATTR_Unused_s
			ARRAY TEXT:C222(v_130_006_atxt; 0)  //ATTR_Unused_s
			C_TEXT:C284(v_130_007_txt)  //ATTR_Unused_s
			ARRAY TEXT:C222(v_130_007_atxt; 0)  //ATTR_Unused_s
			C_LONGINT:C283(v_130_001_L)  //ATTR_ID_l
			ARRAY LONGINT:C221(v_130_001_aL; 0)  //ATTR_ID_l
			C_DATE:C307(v_130_004_d)  //ATTR_Created_d
			ARRAY DATE:C224(v_130_004_ad; 0)  //ATTR_Created_d
			C_DATE:C307(v_130_005_d)  //ATTR_Modified_d
			ARRAY DATE:C224(v_130_005_ad; 0)  //ATTR_Modified_d
		: ($1=131)  //PRJ_ATTRFileNoXrefs
			C_TEXT:C284(v_131_004_txt)  //PRJ_ATTRFileNoXrefs_UUIDKey_s
			ARRAY TEXT:C222(v_131_004_atxt; 0)  //PRJ_ATTRFileNoXrefs_UUIDKey_s
			C_LONGINT:C283(v_131_001_L)  //ATTR_ID_l
			ARRAY LONGINT:C221(v_131_001_aL; 0)  //ATTR_ID_l
			C_LONGINT:C283(v_131_002_L)  //PF_FileNumber_l
			ARRAY LONGINT:C221(v_131_002_aL; 0)  //PF_FileNumber_l
			C_DATE:C307(v_131_003_d)  //ATTFile_Created_d
			ARRAY DATE:C224(v_131_003_ad; 0)  //ATTFile_Created_d
		: ($1=132)  //ScourPOA
			C_BLOB:C604(v_132_006_blb)  //ScourEvalSummary
			ARRAY BLOB:C1222(v_132_006_ablb; 0)  //ScourEvalSummary
			C_BLOB:C604(v_132_007_blb)  //ScourHistory
			ARRAY BLOB:C1222(v_132_007_ablb; 0)  //ScourHistory
			C_BLOB:C604(v_132_024_blb)  //StoreBlob_x
			ARRAY BLOB:C1222(v_132_024_ablb; 0)  //StoreBlob_x
			C_TEXT:C284(v_132_033_txt)  //ScourPOA_UUIDKey_s
			ARRAY TEXT:C222(v_132_033_atxt; 0)  //ScourPOA_UUIDKey_s
			C_TEXT:C284(v_132_002_txt)  //BIN
			ARRAY TEXT:C222(v_132_002_atxt; 0)  //BIN
			C_TEXT:C284(v_132_009_txt)  //CompletedBy
			ARRAY TEXT:C222(v_132_009_atxt; 0)  //CompletedBy
			C_TEXT:C284(v_132_010_txt)  //ApprovedBy
			ARRAY TEXT:C222(v_132_010_atxt; 0)  //ApprovedBy
			C_TEXT:C284(v_132_011_txt)  //ScourReviewBy
			ARRAY TEXT:C222(v_132_011_atxt; 0)  //ScourReviewBy
			C_TEXT:C284(v_132_015_txt)  //StructAssessBy
			ARRAY TEXT:C222(v_132_015_atxt; 0)  //StructAssessBy
			C_TEXT:C284(v_132_016_txt)  //GeotechAssessBy
			ARRAY TEXT:C222(v_132_016_atxt; 0)  //GeotechAssessBy
			C_TEXT:C284(v_132_019_txt)  //FoundationType
			ARRAY TEXT:C222(v_132_019_atxt; 0)  //FoundationType
			C_TEXT:C284(v_132_020_txt)  //FoundationMat
			ARRAY TEXT:C222(v_132_020_atxt; 0)  //FoundationMat
			C_TEXT:C284(v_132_022_txt)  //CreatedBy
			ARRAY TEXT:C222(v_132_022_atxt; 0)  //CreatedBy
			C_TEXT:C284(v_132_025_txt)  //StreamBedMaterial
			ARRAY TEXT:C222(v_132_025_atxt; 0)  //StreamBedMaterial
			C_TEXT:C284(v_132_026_txt)  //Consultant
			ARRAY TEXT:C222(v_132_026_atxt; 0)  //Consultant
			C_TEXT:C284(v_132_027_txt)  //PMReviewBy
			ARRAY TEXT:C222(v_132_027_atxt; 0)  //PMReviewBy
			C_REAL:C285(v_132_017_r)  //StructCritElev
			ARRAY REAL:C219(v_132_017_ar; 0)  //StructCritElev
			C_REAL:C285(v_132_018_r)  //GeotechCritEleve
			ARRAY REAL:C219(v_132_018_ar; 0)  //GeotechCritEleve
			C_LONGINT:C283(v_132_001_L)  //ScourPOAID
			ARRAY LONGINT:C221(v_132_001_aL; 0)  //ScourPOAID
			C_LONGINT:C283(v_132_023_L)  //Approved
			ARRAY LONGINT:C221(v_132_023_aL; 0)  //Approved
			C_LONGINT:C283(v_132_029_L)  //PMReviewed
			ARRAY LONGINT:C221(v_132_029_aL; 0)  //PMReviewed
			C_LONGINT:C283(v_132_031_L)  //ChannelInspCurr
			ARRAY LONGINT:C221(v_132_031_aL; 0)  //ChannelInspCurr
			C_LONGINT:C283(v_132_032_L)  //ChannelInspRec
			ARRAY LONGINT:C221(v_132_032_aL; 0)  //ChannelInspRec
			C_DATE:C307(v_132_003_d)  //DateCreated
			ARRAY DATE:C224(v_132_003_ad; 0)  //DateCreated
			C_DATE:C307(v_132_004_d)  //DateModified
			ARRAY DATE:C224(v_132_004_ad; 0)  //DateModified
			C_DATE:C307(v_132_005_d)  //DateApproved
			ARRAY DATE:C224(v_132_005_ad; 0)  //DateApproved
			C_DATE:C307(v_132_008_d)  //DateCompleted
			ARRAY DATE:C224(v_132_008_ad; 0)  //DateCompleted
			C_DATE:C307(v_132_012_d)  //ScourReviewDate
			ARRAY DATE:C224(v_132_012_ad; 0)  //ScourReviewDate
			C_DATE:C307(v_132_013_d)  //StructAssessDate
			ARRAY DATE:C224(v_132_013_ad; 0)  //StructAssessDate
			C_DATE:C307(v_132_014_d)  //GeotechAssessDate
			ARRAY DATE:C224(v_132_014_ad; 0)  //GeotechAssessDate
			C_DATE:C307(v_132_028_d)  //PMReviewDate
			ARRAY DATE:C224(v_132_028_ad; 0)  //PMReviewDate
			C_DATE:C307(v_132_030_d)  //NTP_Date
			ARRAY DATE:C224(v_132_030_ad; 0)  //NTP_Date
			C_BOOLEAN:C305(v_132_021_b)  //Completed
			ARRAY BOOLEAN:C223(v_132_021_ab; 0)  //Completed
		: ($1=133)  //ScourPOA_DetourBridge
			C_TEXT:C284(v_133_004_txt)  //ScourPOA_DetourBridge_UUIDKey_s
			ARRAY TEXT:C222(v_133_004_atxt; 0)  //ScourPOA_DetourBridge_UUIDKey_s
			C_TEXT:C284(v_133_003_txt)  //DetourBIN
			ARRAY TEXT:C222(v_133_003_atxt; 0)  //DetourBIN
			C_LONGINT:C283(v_133_001_L)  //DetourBridgeID_L
			ARRAY LONGINT:C221(v_133_001_aL; 0)  //DetourBridgeID_L
			C_LONGINT:C283(v_133_002_L)  //ScourPOAID
			ARRAY LONGINT:C221(v_133_002_aL; 0)  //ScourPOAID
		: ($1=134)  //ScourPOA_Images
			C_BLOB:C604(v_134_003_blb)  //Image_x
			ARRAY BLOB:C1222(v_134_003_ablb; 0)  //Image_x
			C_TEXT:C284(v_134_009_txt)  //ScourPOA_Images_UUIDKey_s
			ARRAY TEXT:C222(v_134_009_atxt; 0)  //ScourPOA_Images_UUIDKey_s
			C_TEXT:C284(v_134_004_txt)  //ImgDescr_txt
			ARRAY TEXT:C222(v_134_004_atxt; 0)  //ImgDescr_txt
			C_TEXT:C284(v_134_005_txt)  //ImageType
			ARRAY TEXT:C222(v_134_005_atxt; 0)  //ImageType
			C_LONGINT:C283(v_134_001_L)  //ScourPOAImgID
			ARRAY LONGINT:C221(v_134_001_aL; 0)  //ScourPOAImgID
			C_LONGINT:C283(v_134_002_L)  //ScourPOAID
			ARRAY LONGINT:C221(v_134_002_aL; 0)  //ScourPOAID
			C_LONGINT:C283(v_134_006_L)  //ImageSeq
			ARRAY LONGINT:C221(v_134_006_aL; 0)  //ImageSeq
			C_LONGINT:C283(v_134_007_L)  //OnPage1
			ARRAY LONGINT:C221(v_134_007_aL; 0)  //OnPage1
			C_LONGINT:C283(v_134_008_L)  //ImagePart
			ARRAY LONGINT:C221(v_134_008_aL; 0)  //ImagePart
		: ($1=135)  //PRJ_DCPFJoin
			C_TEXT:C284(v_135_004_txt)  //PRJ_DCPFJoin_UUIDKey_s
			ARRAY TEXT:C222(v_135_004_atxt; 0)  //PRJ_DCPFJoin_UUIDKey_s
			C_TEXT:C284(v_135_001_txt)  //DCPF_Contract_FileNo_s
			ARRAY TEXT:C222(v_135_001_atxt; 0)  //DCPF_Contract_FileNo_s
			C_LONGINT:C283(v_135_002_L)  //DC_DesignProjectID_l
			ARRAY LONGINT:C221(v_135_002_aL; 0)  //DC_DesignProjectID_l
			C_LONGINT:C283(v_135_003_L)  //PF_FileID_l
			ARRAY LONGINT:C221(v_135_003_aL; 0)  //PF_FileID_l
		: ($1=136)  //DCM_Contracts
			C_BLOB:C604(v_136_034_blb)  //ContractRates_x
			ARRAY BLOB:C1222(v_136_034_ablb; 0)  //ContractRates_x
			C_TEXT:C284(v_136_036_txt)  //DCM_Contracts_UUIDKey_s
			ARRAY TEXT:C222(v_136_036_atxt; 0)  //DCM_Contracts_UUIDKey_s
			C_TEXT:C284(v_136_001_txt)  //ContractNo
			ARRAY TEXT:C222(v_136_001_atxt; 0)  //ContractNo
			C_TEXT:C284(v_136_003_txt)  //ConsultantName
			ARRAY TEXT:C222(v_136_003_atxt; 0)  //ConsultantName
			C_TEXT:C284(v_136_007_txt)  //ContractStatus
			ARRAY TEXT:C222(v_136_007_atxt; 0)  //ContractStatus
			C_TEXT:C284(v_136_008_txt)  //ContractType
			ARRAY TEXT:C222(v_136_008_atxt; 0)  //ContractType
			C_TEXT:C284(v_136_009_txt)  //FederalAidNo
			ARRAY TEXT:C222(v_136_009_atxt; 0)  //FederalAidNo
			C_TEXT:C284(v_136_022_txt)  //CheckWithAuditComment
			ARRAY TEXT:C222(v_136_022_atxt; 0)  //CheckWithAuditComment
			C_TEXT:C284(v_136_024_txt)  //CertificateOfCompletionCmnt
			ARRAY TEXT:C222(v_136_024_atxt; 0)  //CertificateOfCompletionCmnt
			C_TEXT:C284(v_136_026_txt)  //ReincumbrancesComment
			ARRAY TEXT:C222(v_136_026_atxt; 0)  //ReincumbrancesComment
			C_TEXT:C284(v_136_028_txt)  //ProcessRetainageComment
			ARRAY TEXT:C222(v_136_028_atxt; 0)  //ProcessRetainageComment
			C_TEXT:C284(v_136_033_txt)  //BridgePrjMgr
			ARRAY TEXT:C222(v_136_033_atxt; 0)  //BridgePrjMgr
			C_TEXT:C284(v_136_035_txt)  //Dummy
			ARRAY TEXT:C222(v_136_035_atxt; 0)  //Dummy
			C_REAL:C285(v_136_010_r)  //OverheadRate
			ARRAY REAL:C219(v_136_010_ar; 0)  //OverheadRate
			C_REAL:C285(v_136_011_r)  //NetFeeRate
			ARRAY REAL:C219(v_136_011_ar; 0)  //NetFeeRate
			C_REAL:C285(v_136_012_r)  //InitContractTotal
			ARRAY REAL:C219(v_136_012_ar; 0)  //InitContractTotal
			C_REAL:C285(v_136_013_r)  //InitContractSalary
			ARRAY REAL:C219(v_136_013_ar; 0)  //InitContractSalary
			C_REAL:C285(v_136_014_r)  //InitContractTotalLimitFee
			ARRAY REAL:C219(v_136_014_ar; 0)  //InitContractTotalLimitFee
			C_REAL:C285(v_136_015_r)  //InitContractTotDirctExpense
			ARRAY REAL:C219(v_136_015_ar; 0)  //InitContractTotDirctExpense
			C_REAL:C285(v_136_016_r)  //TotalEncumbered
			ARRAY REAL:C219(v_136_016_ar; 0)  //TotalEncumbered
			C_REAL:C285(v_136_017_r)  //ApproxSpent
			ARRAY REAL:C219(v_136_017_ar; 0)  //ApproxSpent
			C_REAL:C285(v_136_018_r)  //ActualSpent
			ARRAY REAL:C219(v_136_018_ar; 0)  //ActualSpent
			C_REAL:C285(v_136_019_r)  //ApproxRemainingFund
			ARRAY REAL:C219(v_136_019_ar; 0)  //ApproxRemainingFund
			C_REAL:C285(v_136_020_r)  //ActualRemainingFund
			ARRAY REAL:C219(v_136_020_ar; 0)  //ActualRemainingFund
			C_REAL:C285(v_136_030_r)  //RetainageAmtInit
			ARRAY REAL:C219(v_136_030_ar; 0)  //RetainageAmtInit
			C_REAL:C285(v_136_031_r)  //RetainagePct
			ARRAY REAL:C219(v_136_031_ar; 0)  //RetainagePct
			C_REAL:C285(v_136_032_r)  //MaxHourlyRate
			ARRAY REAL:C219(v_136_032_ar; 0)  //MaxHourlyRate
			C_LONGINT:C283(v_136_002_L)  //ContractID
			ARRAY LONGINT:C221(v_136_002_aL; 0)  //ContractID
			C_DATE:C307(v_136_004_d)  //AwardContractDate
			ARRAY DATE:C224(v_136_004_ad; 0)  //AwardContractDate
			C_DATE:C307(v_136_005_d)  //InitialCompleteDate
			ARRAY DATE:C224(v_136_005_ad; 0)  //InitialCompleteDate
			C_DATE:C307(v_136_006_d)  //ExtendedCompleteDate
			ARRAY DATE:C224(v_136_006_ad; 0)  //ExtendedCompleteDate
			C_BOOLEAN:C305(v_136_021_b)  //CheckWithAudit
			ARRAY BOOLEAN:C223(v_136_021_ab; 0)  //CheckWithAudit
			C_BOOLEAN:C305(v_136_023_b)  //CertificateOfCompletion
			ARRAY BOOLEAN:C223(v_136_023_ab; 0)  //CertificateOfCompletion
			C_BOOLEAN:C305(v_136_025_b)  //Reincumbrances
			ARRAY BOOLEAN:C223(v_136_025_ab; 0)  //Reincumbrances
			C_BOOLEAN:C305(v_136_027_b)  //ProcessRetainage
			ARRAY BOOLEAN:C223(v_136_027_ab; 0)  //ProcessRetainage
			C_BOOLEAN:C305(v_136_029_b)  //FederalFund
			ARRAY BOOLEAN:C223(v_136_029_ab; 0)  //FederalFund
		: ($1=137)  //DCM_WorkOrders
			C_BLOB:C604(v_137_039_blb)  //WriteBlobs_x
			ARRAY BLOB:C1222(v_137_039_ablb; 0)  //WriteBlobs_x
			C_TEXT:C284(v_137_043_txt)  //DCM_WorkOrders_UUIDKey_s
			ARRAY TEXT:C222(v_137_043_atxt; 0)  //DCM_WorkOrders_UUIDKey_s
			C_TEXT:C284(v_137_001_txt)  //ContractNo
			ARRAY TEXT:C222(v_137_001_atxt; 0)  //ContractNo
			C_TEXT:C284(v_137_004_txt)  //ProjectIS
			ARRAY TEXT:C222(v_137_004_atxt; 0)  //ProjectIS
			C_TEXT:C284(v_137_008_txt)  //Consultant
			ARRAY TEXT:C222(v_137_008_atxt; 0)  //Consultant
			C_TEXT:C284(v_137_019_txt)  //Comments
			ARRAY TEXT:C222(v_137_019_atxt; 0)  //Comments
			C_TEXT:C284(v_137_020_txt)  //AcutalOrEstimate
			ARRAY TEXT:C222(v_137_020_atxt; 0)  //AcutalOrEstimate
			C_TEXT:C284(v_137_035_txt)  //Description
			ARRAY TEXT:C222(v_137_035_atxt; 0)  //Description
			C_TEXT:C284(v_137_036_txt)  //ProjectType
			ARRAY TEXT:C222(v_137_036_atxt; 0)  //ProjectType
			C_TEXT:C284(v_137_037_txt)  //ExtendedDesc_txt
			ARRAY TEXT:C222(v_137_037_atxt; 0)  //ExtendedDesc_txt
			C_TEXT:C284(v_137_040_txt)  //DistrictArea_s
			ARRAY TEXT:C222(v_137_040_atxt; 0)  //DistrictArea_s
			C_TEXT:C284(v_137_042_txt)  //Dummy
			ARRAY TEXT:C222(v_137_042_atxt; 0)  //Dummy
			C_REAL:C285(v_137_005_r)  //Overhead
			ARRAY REAL:C219(v_137_005_ar; 0)  //Overhead
			C_REAL:C285(v_137_006_r)  //Fee
			ARRAY REAL:C219(v_137_006_ar; 0)  //Fee
			C_REAL:C285(v_137_007_r)  //Salary
			ARRAY REAL:C219(v_137_007_ar; 0)  //Salary
			C_REAL:C285(v_137_009_r)  //Actual_Total
			ARRAY REAL:C219(v_137_009_ar; 0)  //Actual_Total
			C_REAL:C285(v_137_010_r)  //Est_Salary
			ARRAY REAL:C219(v_137_010_ar; 0)  //Est_Salary
			C_REAL:C285(v_137_011_r)  //Est_IndirectCost
			ARRAY REAL:C219(v_137_011_ar; 0)  //Est_IndirectCost
			C_REAL:C285(v_137_012_r)  //Est_NetFee
			ARRAY REAL:C219(v_137_012_ar; 0)  //Est_NetFee
			C_REAL:C285(v_137_013_r)  //Est_TotalLimitFee
			ARRAY REAL:C219(v_137_013_ar; 0)  //Est_TotalLimitFee
			C_REAL:C285(v_137_014_r)  //Est_DirectExpense
			ARRAY REAL:C219(v_137_014_ar; 0)  //Est_DirectExpense
			C_REAL:C285(v_137_015_r)  //Est_Total
			ARRAY REAL:C219(v_137_015_ar; 0)  //Est_Total
			C_REAL:C285(v_137_022_r)  //Actual_Salary
			ARRAY REAL:C219(v_137_022_ar; 0)  //Actual_Salary
			C_REAL:C285(v_137_023_r)  //Actual_IndirectCost
			ARRAY REAL:C219(v_137_023_ar; 0)  //Actual_IndirectCost
			C_REAL:C285(v_137_024_r)  //Actual_NetFee
			ARRAY REAL:C219(v_137_024_ar; 0)  //Actual_NetFee
			C_REAL:C285(v_137_025_r)  //Actual_TotalLimitFee
			ARRAY REAL:C219(v_137_025_ar; 0)  //Actual_TotalLimitFee
			C_REAL:C285(v_137_026_r)  //Actual_DirectExpense
			ARRAY REAL:C219(v_137_026_ar; 0)  //Actual_DirectExpense
			C_REAL:C285(v_137_027_r)  //Est_ConstrSalary
			ARRAY REAL:C219(v_137_027_ar; 0)  //Est_ConstrSalary
			C_REAL:C285(v_137_028_r)  //Est_ConstrIndirectCost
			ARRAY REAL:C219(v_137_028_ar; 0)  //Est_ConstrIndirectCost
			C_REAL:C285(v_137_029_r)  //Est_ConstrNetFee
			ARRAY REAL:C219(v_137_029_ar; 0)  //Est_ConstrNetFee
			C_REAL:C285(v_137_030_r)  //Est_ConstrTotalLimitFee
			ARRAY REAL:C219(v_137_030_ar; 0)  //Est_ConstrTotalLimitFee
			C_REAL:C285(v_137_031_r)  //Actual_ConstrSalary
			ARRAY REAL:C219(v_137_031_ar; 0)  //Actual_ConstrSalary
			C_REAL:C285(v_137_032_r)  //Actual_ConstrIndirectCost
			ARRAY REAL:C219(v_137_032_ar; 0)  //Actual_ConstrIndirectCost
			C_REAL:C285(v_137_033_r)  //Actual_ConstrNetFee
			ARRAY REAL:C219(v_137_033_ar; 0)  //Actual_ConstrNetFee
			C_REAL:C285(v_137_034_r)  //Actual_ConstrTotalLimitFee
			ARRAY REAL:C219(v_137_034_ar; 0)  //Actual_ConstrTotalLimitFee
			C_LONGINT:C283(v_137_002_L)  //AssignNo
			ARRAY INTEGER:C220(v_137_002_ai; 0)  //AssignNo
			C_LONGINT:C283(v_137_003_L)  //AssignID
			ARRAY LONGINT:C221(v_137_003_aL; 0)  //AssignID
			C_LONGINT:C283(v_137_038_L)  //ABPFlag_L
			ARRAY LONGINT:C221(v_137_038_aL; 0)  //ABPFlag_L
			C_DATE:C307(v_137_016_d)  //ReqFeeProposalDate
			ARRAY DATE:C224(v_137_016_ad; 0)  //ReqFeeProposalDate
			C_DATE:C307(v_137_017_d)  //NTPdate_written
			ARRAY DATE:C224(v_137_017_ad; 0)  //NTPdate_written
			C_DATE:C307(v_137_018_d)  //NTPdate_verbal
			ARRAY DATE:C224(v_137_018_ad; 0)  //NTPdate_verbal
			C_DATE:C307(v_137_041_d)  //Date_Issued_d
			ARRAY DATE:C224(v_137_041_ad; 0)  //Date_Issued_d
			C_BOOLEAN:C305(v_137_021_b)  //SpecialAssignment
			ARRAY BOOLEAN:C223(v_137_021_ab; 0)  //SpecialAssignment
		: ($1=138)  //DCM_Project
			C_BLOB:C604(v_138_014_blb)  //ProjData_X
			ARRAY BLOB:C1222(v_138_014_ablb; 0)  //ProjData_X
			C_BLOB:C604(v_138_016_blb)  //ProjItems_x
			ARRAY BLOB:C1222(v_138_016_ablb; 0)  //ProjItems_x
			C_TEXT:C284(v_138_020_txt)  //DCM_Project_UUIDKey_s
			ARRAY TEXT:C222(v_138_020_atxt; 0)  //DCM_Project_UUIDKey_s
			C_TEXT:C284(v_138_002_txt)  //ContractNo
			ARRAY TEXT:C222(v_138_002_atxt; 0)  //ContractNo
			C_TEXT:C284(v_138_003_txt)  //Project Type
			ARRAY TEXT:C222(v_138_003_atxt; 0)  //Project Type
			C_TEXT:C284(v_138_004_txt)  //BridgeNo
			ARRAY TEXT:C222(v_138_004_atxt; 0)  //BridgeNo
			C_TEXT:C284(v_138_005_txt)  //BIN
			ARRAY TEXT:C222(v_138_005_atxt; 0)  //BIN
			C_TEXT:C284(v_138_006_txt)  //Location
			ARRAY TEXT:C222(v_138_006_atxt; 0)  //Location
			C_TEXT:C284(v_138_007_txt)  //Town
			ARRAY TEXT:C222(v_138_007_atxt; 0)  //Town
			C_TEXT:C284(v_138_008_txt)  //District
			ARRAY TEXT:C222(v_138_008_atxt; 0)  //District
			C_TEXT:C284(v_138_019_txt)  //Dummy
			ARRAY TEXT:C222(v_138_019_atxt; 0)  //Dummy
			C_REAL:C285(v_138_010_r)  //EstCost
			ARRAY REAL:C219(v_138_010_ar; 0)  //EstCost
			C_REAL:C285(v_138_011_r)  //FinalCost
			ARRAY REAL:C219(v_138_011_ar; 0)  //FinalCost
			C_REAL:C285(v_138_012_r)  //CurrCost
			ARRAY REAL:C219(v_138_012_ar; 0)  //CurrCost
			C_LONGINT:C283(v_138_009_L)  //AssignNo
			ARRAY INTEGER:C220(v_138_009_ai; 0)  //AssignNo
			C_LONGINT:C283(v_138_001_L)  //ProjectID
			ARRAY LONGINT:C221(v_138_001_aL; 0)  //ProjectID
			C_LONGINT:C283(v_138_013_L)  //AssignID
			ARRAY LONGINT:C221(v_138_013_aL; 0)  //AssignID
			C_DATE:C307(v_138_017_d)  //Work_Start_d
			ARRAY DATE:C224(v_138_017_ad; 0)  //Work_Start_d
			C_DATE:C307(v_138_018_d)  //Work_End_d
			ARRAY DATE:C224(v_138_018_ad; 0)  //Work_End_d
			C_BOOLEAN:C305(v_138_015_b)  //SDInfluence
			ARRAY BOOLEAN:C223(v_138_015_ab; 0)  //SDInfluence
		: ($1=139)  //BridgeMHDNBISArchive
			C_TEXT:C284(v_139_229_txt)  //BridgeMHDNBISArchive_UUIDKey_s
			ARRAY TEXT:C222(v_139_229_atxt; 0)  //BridgeMHDNBISArchive_UUIDKey_s
			C_TEXT:C284(v_139_001_txt)  //BDEPT
			ARRAY TEXT:C222(v_139_001_atxt; 0)  //BDEPT
			C_TEXT:C284(v_139_002_txt)  //Bridge Key
			ARRAY TEXT:C222(v_139_002_atxt; 0)  //Bridge Key
			C_TEXT:C284(v_139_003_txt)  //BIN
			ARRAY TEXT:C222(v_139_003_atxt; 0)  //BIN
			C_TEXT:C284(v_139_008_txt)  //PostingStatus
			ARRAY TEXT:C222(v_139_008_atxt; 0)  //PostingStatus
			C_TEXT:C284(v_139_012_txt)  //Foundation Type
			ARRAY TEXT:C222(v_139_012_atxt; 0)  //Foundation Type
			C_TEXT:C284(v_139_023_txt)  //FC Under
			ARRAY TEXT:C222(v_139_023_atxt; 0)  //FC Under
			C_TEXT:C284(v_139_024_txt)  //Quad
			ARRAY TEXT:C222(v_139_024_atxt; 0)  //Quad
			C_TEXT:C284(v_139_025_txt)  //SelectionText
			ARRAY TEXT:C222(v_139_025_atxt; 0)  //SelectionText
			C_TEXT:C284(v_139_027_txt)  //ParallelBIN
			ARRAY TEXT:C222(v_139_027_atxt; 0)  //ParallelBIN
			C_TEXT:C284(v_139_029_txt)  //Bridge Name
			ARRAY TEXT:C222(v_139_029_atxt; 0)  //Bridge Name
			C_TEXT:C284(v_139_030_txt)  //LiftBucket
			ARRAY TEXT:C222(v_139_030_atxt; 0)  //LiftBucket
			C_TEXT:C284(v_139_031_txt)  //Ladder
			ARRAY TEXT:C222(v_139_031_atxt; 0)  //Ladder
			C_TEXT:C284(v_139_032_txt)  //Boat
			ARRAY TEXT:C222(v_139_032_atxt; 0)  //Boat
			C_TEXT:C284(v_139_033_txt)  //Wader
			ARRAY TEXT:C222(v_139_033_atxt; 0)  //Wader
			C_TEXT:C284(v_139_034_txt)  //Inspector50
			ARRAY TEXT:C222(v_139_034_atxt; 0)  //Inspector50
			C_TEXT:C284(v_139_035_txt)  //Rigging
			ARRAY TEXT:C222(v_139_035_atxt; 0)  //Rigging
			C_TEXT:C284(v_139_036_txt)  //Staging
			ARRAY TEXT:C222(v_139_036_atxt; 0)  //Staging
			C_TEXT:C284(v_139_037_txt)  //Traffic Control
			ARRAY TEXT:C222(v_139_037_atxt; 0)  //Traffic Control
			C_TEXT:C284(v_139_038_txt)  //RR Flagman
			ARRAY TEXT:C222(v_139_038_atxt; 0)  //RR Flagman
			C_TEXT:C284(v_139_039_txt)  //Police
			ARRAY TEXT:C222(v_139_039_atxt; 0)  //Police
			C_TEXT:C284(v_139_049_txt)  //InspWaiverText
			ARRAY TEXT:C222(v_139_049_atxt; 0)  //InspWaiverText
			C_TEXT:C284(v_139_050_txt)  //RoadInvSNC
			ARRAY TEXT:C222(v_139_050_atxt; 0)  //RoadInvSNC
			C_TEXT:C284(v_139_051_txt)  //RoadInvSNI
			ARRAY TEXT:C222(v_139_051_atxt; 0)  //RoadInvSNI
			C_TEXT:C284(v_139_052_txt)  //MaintCat
			ARRAY TEXT:C222(v_139_052_atxt; 0)  //MaintCat
			C_TEXT:C284(v_139_053_txt)  //MaintPriority
			ARRAY TEXT:C222(v_139_053_atxt; 0)  //MaintPriority
			C_TEXT:C284(v_139_054_txt)  //MaintTxtDist
			ARRAY TEXT:C222(v_139_054_atxt; 0)  //MaintTxtDist
			C_TEXT:C284(v_139_055_txt)  //MaintTxtBoston
			ARRAY TEXT:C222(v_139_055_atxt; 0)  //MaintTxtBoston
			C_TEXT:C284(v_139_057_txt)  //SeismicClass
			ARRAY TEXT:C222(v_139_057_atxt; 0)  //SeismicClass
			C_TEXT:C284(v_139_058_txt)  //Item5
			ARRAY TEXT:C222(v_139_058_atxt; 0)  //Item5
			C_TEXT:C284(v_139_059_txt)  //Item2
			ARRAY TEXT:C222(v_139_059_atxt; 0)  //Item2
			C_TEXT:C284(v_139_060_txt)  //Item3
			ARRAY TEXT:C222(v_139_060_atxt; 0)  //Item3
			C_TEXT:C284(v_139_061_txt)  //Item4
			ARRAY TEXT:C222(v_139_061_atxt; 0)  //Item4
			C_TEXT:C284(v_139_062_txt)  //Item6A
			ARRAY TEXT:C222(v_139_062_atxt; 0)  //Item6A
			C_TEXT:C284(v_139_064_txt)  //Item7
			ARRAY TEXT:C222(v_139_064_atxt; 0)  //Item7
			C_TEXT:C284(v_139_065_txt)  //Item9
			ARRAY TEXT:C222(v_139_065_atxt; 0)  //Item9
			C_TEXT:C284(v_139_071_txt)  //Item98A
			ARRAY TEXT:C222(v_139_071_atxt; 0)  //Item98A
			C_TEXT:C284(v_139_072_txt)  //Item98B
			ARRAY TEXT:C222(v_139_072_atxt; 0)  //Item98B
			C_TEXT:C284(v_139_073_txt)  //Item99
			ARRAY TEXT:C222(v_139_073_atxt; 0)  //Item99
			C_TEXT:C284(v_139_074_txt)  //Item43
			ARRAY TEXT:C222(v_139_074_atxt; 0)  //Item43
			C_TEXT:C284(v_139_075_txt)  //Item44
			ARRAY TEXT:C222(v_139_075_atxt; 0)  //Item44
			C_TEXT:C284(v_139_078_txt)  //Item107
			ARRAY TEXT:C222(v_139_078_atxt; 0)  //Item107
			C_TEXT:C284(v_139_079_txt)  //Item108A
			ARRAY TEXT:C222(v_139_079_atxt; 0)  //Item108A
			C_TEXT:C284(v_139_080_txt)  //Item108B
			ARRAY TEXT:C222(v_139_080_atxt; 0)  //Item108B
			C_TEXT:C284(v_139_081_txt)  //Item108C
			ARRAY TEXT:C222(v_139_081_atxt; 0)  //Item108C
			C_TEXT:C284(v_139_084_txt)  //Item42
			ARRAY TEXT:C222(v_139_084_atxt; 0)  //Item42
			C_TEXT:C284(v_139_098_txt)  //Item33
			ARRAY TEXT:C222(v_139_098_atxt; 0)  //Item33
			C_TEXT:C284(v_139_106_txt)  //Item54A
			ARRAY TEXT:C222(v_139_106_atxt; 0)  //Item54A
			C_TEXT:C284(v_139_109_txt)  //Item55A
			ARRAY TEXT:C222(v_139_109_atxt; 0)  //Item55A
			C_TEXT:C284(v_139_112_txt)  //Item38
			ARRAY TEXT:C222(v_139_112_atxt; 0)  //Item38
			C_TEXT:C284(v_139_113_txt)  //Item111
			ARRAY TEXT:C222(v_139_113_atxt; 0)  //Item111
			C_TEXT:C284(v_139_119_txt)  //Item26
			ARRAY TEXT:C222(v_139_119_atxt; 0)  //Item26
			C_TEXT:C284(v_139_120_txt)  //Item100
			ARRAY TEXT:C222(v_139_120_atxt; 0)  //Item100
			C_TEXT:C284(v_139_121_txt)  //Item101
			ARRAY TEXT:C222(v_139_121_atxt; 0)  //Item101
			C_TEXT:C284(v_139_122_txt)  //Item102
			ARRAY TEXT:C222(v_139_122_atxt; 0)  //Item102
			C_TEXT:C284(v_139_125_txt)  //Item20
			ARRAY TEXT:C222(v_139_125_atxt; 0)  //Item20
			C_TEXT:C284(v_139_126_txt)  //Item21
			ARRAY TEXT:C222(v_139_126_atxt; 0)  //Item21
			C_TEXT:C284(v_139_127_txt)  //Item22
			ARRAY TEXT:C222(v_139_127_atxt; 0)  //Item22
			C_TEXT:C284(v_139_128_txt)  //Item37
			ARRAY TEXT:C222(v_139_128_atxt; 0)  //Item37
			C_TEXT:C284(v_139_129_txt)  //Item58
			ARRAY TEXT:C222(v_139_129_atxt; 0)  //Item58
			C_TEXT:C284(v_139_130_txt)  //Item59
			ARRAY TEXT:C222(v_139_130_atxt; 0)  //Item59
			C_TEXT:C284(v_139_131_txt)  //Item60
			ARRAY TEXT:C222(v_139_131_atxt; 0)  //Item60
			C_TEXT:C284(v_139_132_txt)  //Item61
			ARRAY TEXT:C222(v_139_132_atxt; 0)  //Item61
			C_TEXT:C284(v_139_133_txt)  //Item62
			ARRAY TEXT:C222(v_139_133_atxt; 0)  //Item62
			C_TEXT:C284(v_139_134_txt)  //Item31
			ARRAY TEXT:C222(v_139_134_atxt; 0)  //Item31
			C_TEXT:C284(v_139_139_txt)  //Item70
			ARRAY TEXT:C222(v_139_139_atxt; 0)  //Item70
			C_TEXT:C284(v_139_140_txt)  //Item41
			ARRAY TEXT:C222(v_139_140_atxt; 0)  //Item41
			C_TEXT:C284(v_139_141_txt)  //Item67
			ARRAY TEXT:C222(v_139_141_atxt; 0)  //Item67
			C_TEXT:C284(v_139_142_txt)  //Item68
			ARRAY TEXT:C222(v_139_142_atxt; 0)  //Item68
			C_TEXT:C284(v_139_143_txt)  //Item69
			ARRAY TEXT:C222(v_139_143_atxt; 0)  //Item69
			C_TEXT:C284(v_139_144_txt)  //Item71
			ARRAY TEXT:C222(v_139_144_atxt; 0)  //Item71
			C_TEXT:C284(v_139_145_txt)  //Item72
			ARRAY TEXT:C222(v_139_145_atxt; 0)  //Item72
			C_TEXT:C284(v_139_146_txt)  //Item36A
			ARRAY TEXT:C222(v_139_146_atxt; 0)  //Item36A
			C_TEXT:C284(v_139_147_txt)  //Item36B
			ARRAY TEXT:C222(v_139_147_atxt; 0)  //Item36B
			C_TEXT:C284(v_139_148_txt)  //Item36C
			ARRAY TEXT:C222(v_139_148_atxt; 0)  //Item36C
			C_TEXT:C284(v_139_149_txt)  //Item36D
			ARRAY TEXT:C222(v_139_149_atxt; 0)  //Item36D
			C_TEXT:C284(v_139_150_txt)  //Item113
			ARRAY TEXT:C222(v_139_150_atxt; 0)  //Item113
			C_TEXT:C284(v_139_151_txt)  //Item75A
			ARRAY TEXT:C222(v_139_151_atxt; 0)  //Item75A
			C_TEXT:C284(v_139_152_txt)  //Item75B
			ARRAY TEXT:C222(v_139_152_atxt; 0)  //Item75B
			C_TEXT:C284(v_139_171_txt)  //General Comment
			ARRAY TEXT:C222(v_139_171_atxt; 0)  //General Comment
			C_TEXT:C284(v_139_172_txt)  //InspResp
			ARRAY TEXT:C222(v_139_172_atxt; 0)  //InspResp
			C_TEXT:C284(v_139_174_txt)  //Town Name
			ARRAY TEXT:C222(v_139_174_atxt; 0)  //Town Name
			C_TEXT:C284(v_139_178_txt)  //AccessOther
			ARRAY TEXT:C222(v_139_178_atxt; 0)  //AccessOther
			C_TEXT:C284(v_139_179_txt)  //OtherAccBool
			ARRAY TEXT:C222(v_139_179_atxt; 0)  //OtherAccBool
			C_TEXT:C284(v_139_180_txt)  //RPC_Codes
			ARRAY TEXT:C222(v_139_180_atxt; 0)  //RPC_Codes
			C_TEXT:C284(v_139_182_txt)  //CulvertShape
			ARRAY TEXT:C222(v_139_182_atxt; 0)  //CulvertShape
			C_TEXT:C284(v_139_183_txt)  //CulvertMaterial
			ARRAY TEXT:C222(v_139_183_atxt; 0)  //CulvertMaterial
			C_TEXT:C284(v_139_184_txt)  //CulvertCoating
			ARRAY TEXT:C222(v_139_184_atxt; 0)  //CulvertCoating
			C_TEXT:C284(v_139_188_txt)  //Modified By
			ARRAY TEXT:C222(v_139_188_atxt; 0)  //Modified By
			C_TEXT:C284(v_139_194_txt)  //Item 13A
			ARRAY TEXT:C222(v_139_194_atxt; 0)  //Item 13A
			C_TEXT:C284(v_139_195_txt)  //Item 13B
			ARRAY TEXT:C222(v_139_195_atxt; 0)  //Item 13B
			C_TEXT:C284(v_139_196_txt)  //Item 63
			ARRAY TEXT:C222(v_139_196_atxt; 0)  //Item 63
			C_TEXT:C284(v_139_197_txt)  //Item 65
			ARRAY TEXT:C222(v_139_197_atxt; 0)  //Item 65
			C_TEXT:C284(v_139_198_txt)  //Item 105
			ARRAY TEXT:C222(v_139_198_atxt; 0)  //Item 105
			C_TEXT:C284(v_139_199_txt)  //JointlessType
			ARRAY TEXT:C222(v_139_199_atxt; 0)  //JointlessType
			C_TEXT:C284(v_139_203_txt)  //Item8
			ARRAY TEXT:C222(v_139_203_atxt; 0)  //Item8
			C_TEXT:C284(v_139_204_txt)  //Item8 BridgeCat
			ARRAY TEXT:C222(v_139_204_atxt; 0)  //Item8 BridgeCat
			C_TEXT:C284(v_139_205_txt)  //Item8 Owner
			ARRAY TEXT:C222(v_139_205_atxt; 0)  //Item8 Owner
			C_TEXT:C284(v_139_206_txt)  //AgencyBrNo
			ARRAY TEXT:C222(v_139_206_atxt; 0)  //AgencyBrNo
			C_TEXT:C284(v_139_207_txt)  //RRBranch
			ARRAY TEXT:C222(v_139_207_atxt; 0)  //RRBranch
			C_TEXT:C284(v_139_212_txt)  //OtherInspType
			ARRAY TEXT:C222(v_139_212_atxt; 0)  //OtherInspType
			C_TEXT:C284(v_139_213_txt)  //ClassAEmp
			ARRAY TEXT:C222(v_139_213_atxt; 0)  //ClassAEmp
			C_TEXT:C284(v_139_214_txt)  //ConfinedSp
			ARRAY TEXT:C222(v_139_214_atxt; 0)  //ConfinedSp
			C_TEXT:C284(v_139_215_txt)  //OffHrsWork
			ARRAY TEXT:C222(v_139_215_atxt; 0)  //OffHrsWork
			C_TEXT:C284(v_139_221_txt)  //MissSignsDesc
			ARRAY TEXT:C222(v_139_221_atxt; 0)  //MissSignsDesc
			C_TEXT:C284(v_139_222_txt)  //FreezeThaw
			ARRAY TEXT:C222(v_139_222_atxt; 0)  //FreezeThaw
			C_TEXT:C284(v_139_223_txt)  //ArchiveReason_s
			ARRAY TEXT:C222(v_139_223_atxt; 0)  //ArchiveReason_s
			C_TEXT:C284(v_139_225_txt)  //LegacyOwner
			ARRAY TEXT:C222(v_139_225_atxt; 0)  //LegacyOwner
			C_TEXT:C284(v_139_227_txt)  //FundingSource
			ARRAY TEXT:C222(v_139_227_atxt; 0)  //FundingSource
			C_TEXT:C284(v_139_228_txt)  //FHWAItem8
			ARRAY TEXT:C222(v_139_228_atxt; 0)  //FHWAItem8
			C_REAL:C285(v_139_005_r)  //AASHTO
			ARRAY REAL:C219(v_139_005_ar; 0)  //AASHTO
			C_REAL:C285(v_139_015_r)  //OprH20
			ARRAY REAL:C219(v_139_015_ar; 0)  //OprH20
			C_REAL:C285(v_139_016_r)  //OprType3
			ARRAY REAL:C219(v_139_016_ar; 0)  //OprType3
			C_REAL:C285(v_139_017_r)  //Opr3S2
			ARRAY REAL:C219(v_139_017_ar; 0)  //Opr3S2
			C_REAL:C285(v_139_018_r)  //OprHS
			ARRAY REAL:C219(v_139_018_ar; 0)  //OprHS
			C_REAL:C285(v_139_019_r)  //InvH20
			ARRAY REAL:C219(v_139_019_ar; 0)  //InvH20
			C_REAL:C285(v_139_020_r)  //InvType3
			ARRAY REAL:C219(v_139_020_ar; 0)  //InvType3
			C_REAL:C285(v_139_021_r)  //Inv3S2
			ARRAY REAL:C219(v_139_021_ar; 0)  //Inv3S2
			C_REAL:C285(v_139_022_r)  //InvHS
			ARRAY REAL:C219(v_139_022_ar; 0)  //InvHS
			C_REAL:C285(v_139_056_r)  //SeismicRank
			ARRAY REAL:C219(v_139_056_ar; 0)  //SeismicRank
			C_REAL:C285(v_139_066_r)  //Item11
			ARRAY REAL:C219(v_139_066_ar; 0)  //Item11
			C_REAL:C285(v_139_091_r)  //Item48
			ARRAY REAL:C219(v_139_091_ar; 0)  //Item48
			C_REAL:C285(v_139_092_r)  //Item49
			ARRAY REAL:C219(v_139_092_ar; 0)  //Item49
			C_REAL:C285(v_139_093_r)  //Item50A
			ARRAY REAL:C219(v_139_093_ar; 0)  //Item50A
			C_REAL:C285(v_139_094_r)  //Item50B
			ARRAY REAL:C219(v_139_094_ar; 0)  //Item50B
			C_REAL:C285(v_139_095_r)  //Item51
			ARRAY REAL:C219(v_139_095_ar; 0)  //Item51
			C_REAL:C285(v_139_096_r)  //Item52
			ARRAY REAL:C219(v_139_096_ar; 0)  //Item52
			C_REAL:C285(v_139_097_r)  //Item32
			ARRAY REAL:C219(v_139_097_ar; 0)  //Item32
			C_REAL:C285(v_139_101_r)  //Item10
			ARRAY REAL:C219(v_139_101_ar; 0)  //Item10
			C_REAL:C285(v_139_103_r)  //Item47
			ARRAY REAL:C219(v_139_103_ar; 0)  //Item47
			C_REAL:C285(v_139_104_r)  //Item53
			ARRAY REAL:C219(v_139_104_ar; 0)  //Item53
			C_REAL:C285(v_139_107_r)  //Item54B
			ARRAY REAL:C219(v_139_107_ar; 0)  //Item54B
			C_REAL:C285(v_139_108_r)  //Item16C
			ARRAY REAL:C219(v_139_108_ar; 0)  //Item16C
			C_REAL:C285(v_139_110_r)  //Item55B
			ARRAY REAL:C219(v_139_110_ar; 0)  //Item55B
			C_REAL:C285(v_139_111_r)  //Item56
			ARRAY REAL:C219(v_139_111_ar; 0)  //Item56
			C_REAL:C285(v_139_114_r)  //Item39
			ARRAY REAL:C219(v_139_114_ar; 0)  //Item39
			C_REAL:C285(v_139_115_r)  //Item116
			ARRAY REAL:C219(v_139_115_ar; 0)  //Item116
			C_REAL:C285(v_139_116_r)  //Item40
			ARRAY REAL:C219(v_139_116_ar; 0)  //Item40
			C_REAL:C285(v_139_135_r)  //Item17C
			ARRAY REAL:C219(v_139_135_ar; 0)  //Item17C
			C_REAL:C285(v_139_136_r)  //Item64
			ARRAY REAL:C219(v_139_136_ar; 0)  //Item64
			C_REAL:C285(v_139_138_r)  //Item66
			ARRAY REAL:C219(v_139_138_ar; 0)  //Item66
			C_REAL:C285(v_139_153_r)  //Item76
			ARRAY REAL:C219(v_139_153_ar; 0)  //Item76
			C_REAL:C285(v_139_186_r)  //BarrelsHeight
			ARRAY REAL:C219(v_139_186_ar; 0)  //BarrelsHeight
			C_REAL:C285(v_139_187_r)  //BarrelsWidth
			ARRAY REAL:C219(v_139_187_ar; 0)  //BarrelsWidth
			C_REAL:C285(v_139_200_r)  //InvMS
			ARRAY REAL:C219(v_139_200_ar; 0)  //InvMS
			C_REAL:C285(v_139_201_r)  //OprMS
			ARRAY REAL:C219(v_139_201_ar; 0)  //OprMS
			C_REAL:C285(v_139_208_r)  //RRBridgeNo
			ARRAY REAL:C219(v_139_208_ar; 0)  //RRBridgeNo
			C_REAL:C285(v_139_217_r)  //HI_Total_Elmt_Cost
			ARRAY REAL:C219(v_139_217_ar; 0)  //HI_Total_Elmt_Cost
			C_REAL:C285(v_139_218_r)  //HI_Current_Elmt_Cost
			ARRAY REAL:C219(v_139_218_ar; 0)  //HI_Current_Elmt_Cost
			C_REAL:C285(v_139_219_r)  //HealthIndex
			ARRAY REAL:C219(v_139_219_ar; 0)  //HealthIndex
			C_LONGINT:C283(v_139_006_L)  //Rank
			ARRAY INTEGER:C220(v_139_006_ai; 0)  //Rank
			C_LONGINT:C283(v_139_009_L)  //Posting2Axle
			ARRAY INTEGER:C220(v_139_009_ai; 0)  //Posting2Axle
			C_LONGINT:C283(v_139_010_L)  //Posting3Axle
			ARRAY INTEGER:C220(v_139_010_ai; 0)  //Posting3Axle
			C_LONGINT:C283(v_139_011_L)  //Posting5Axle
			ARRAY INTEGER:C220(v_139_011_ai; 0)  //Posting5Axle
			C_LONGINT:C283(v_139_040_L)  //InspectionHRS
			ARRAY INTEGER:C220(v_139_040_ai; 0)  //InspectionHRS
			C_LONGINT:C283(v_139_043_L)  //OtherIFreq
			ARRAY INTEGER:C220(v_139_043_ai; 0)  //OtherIFreq
			C_LONGINT:C283(v_139_046_L)  //ClosedIFreq
			ARRAY INTEGER:C220(v_139_046_ai; 0)  //ClosedIFreq
			C_LONGINT:C283(v_139_067_L)  //Item16A
			ARRAY INTEGER:C220(v_139_067_ai; 0)  //Item16A
			C_LONGINT:C283(v_139_068_L)  //Item16B
			ARRAY INTEGER:C220(v_139_068_ai; 0)  //Item16B
			C_LONGINT:C283(v_139_069_L)  //Item17A
			ARRAY INTEGER:C220(v_139_069_ai; 0)  //Item17A
			C_LONGINT:C283(v_139_070_L)  //Item17B
			ARRAY INTEGER:C220(v_139_070_ai; 0)  //Item17B
			C_LONGINT:C283(v_139_076_L)  //Item45
			ARRAY INTEGER:C220(v_139_076_ai; 0)  //Item45
			C_LONGINT:C283(v_139_077_L)  //Item46
			ARRAY INTEGER:C220(v_139_077_ai; 0)  //Item46
			C_LONGINT:C283(v_139_082_L)  //Item27
			ARRAY INTEGER:C220(v_139_082_ai; 0)  //Item27
			C_LONGINT:C283(v_139_083_L)  //Item106
			ARRAY INTEGER:C220(v_139_083_ai; 0)  //Item106
			C_LONGINT:C283(v_139_085_L)  //Item28A
			ARRAY INTEGER:C220(v_139_085_ai; 0)  //Item28A
			C_LONGINT:C283(v_139_086_L)  //Item28B
			ARRAY INTEGER:C220(v_139_086_ai; 0)  //Item28B
			C_LONGINT:C283(v_139_088_L)  //Item30
			ARRAY INTEGER:C220(v_139_088_ai; 0)  //Item30
			C_LONGINT:C283(v_139_089_L)  //Item109
			ARRAY INTEGER:C220(v_139_089_ai; 0)  //Item109
			C_LONGINT:C283(v_139_090_L)  //Item19
			ARRAY INTEGER:C220(v_139_090_ai; 0)  //Item19
			C_LONGINT:C283(v_139_099_L)  //Item34
			ARRAY INTEGER:C220(v_139_099_ai; 0)  //Item34
			C_LONGINT:C283(v_139_157_L)  //Item97
			ARRAY INTEGER:C220(v_139_157_ai; 0)  //Item97
			C_LONGINT:C283(v_139_159_L)  //Item115
			ARRAY INTEGER:C220(v_139_159_ai; 0)  //Item115
			C_LONGINT:C283(v_139_161_L)  //Item91
			ARRAY INTEGER:C220(v_139_161_ai; 0)  //Item91
			C_LONGINT:C283(v_139_163_L)  //Item92AB
			ARRAY INTEGER:C220(v_139_163_ai; 0)  //Item92AB
			C_LONGINT:C283(v_139_165_L)  //Item92BB
			ARRAY INTEGER:C220(v_139_165_ai; 0)  //Item92BB
			C_LONGINT:C283(v_139_167_L)  //Item92CB
			ARRAY INTEGER:C220(v_139_167_ai; 0)  //Item92CB
			C_LONGINT:C283(v_139_185_L)  //BarrelsNumber
			ARRAY INTEGER:C220(v_139_185_ai; 0)  //BarrelsNumber
			C_LONGINT:C283(v_139_210_L)  //UWSpInspFreq
			ARRAY INTEGER:C220(v_139_210_ai; 0)  //UWSpInspFreq
			C_LONGINT:C283(v_139_087_L)  //Item29
			ARRAY LONGINT:C221(v_139_087_aL; 0)  //Item29
			C_LONGINT:C283(v_139_154_L)  //Item94
			ARRAY LONGINT:C221(v_139_154_aL; 0)  //Item94
			C_LONGINT:C283(v_139_155_L)  //Item95
			ARRAY LONGINT:C221(v_139_155_aL; 0)  //Item95
			C_LONGINT:C283(v_139_156_L)  //Item96
			ARRAY LONGINT:C221(v_139_156_aL; 0)  //Item96
			C_LONGINT:C283(v_139_158_L)  //Item114
			ARRAY LONGINT:C221(v_139_158_aL; 0)  //Item114
			C_LONGINT:C283(v_139_230_L)  //PostingSingle
			ARRAY LONGINT:C221(v_139_230_aL; 0)  //PostingSingle
			C_DATE:C307(v_139_007_d)  //PostingDate
			ARRAY DATE:C224(v_139_007_ad; 0)  //PostingDate
			C_DATE:C307(v_139_041_d)  //OtherIDate
			ARRAY DATE:C224(v_139_041_ad; 0)  //OtherIDate
			C_DATE:C307(v_139_044_d)  //ClosedIDate
			ARRAY DATE:C224(v_139_044_ad; 0)  //ClosedIDate
			C_DATE:C307(v_139_047_d)  //DamageInsp
			ARRAY DATE:C224(v_139_047_ad; 0)  //DamageInsp
			C_DATE:C307(v_139_160_d)  //Item90
			ARRAY DATE:C224(v_139_160_ad; 0)  //Item90
			C_DATE:C307(v_139_168_d)  //Item93A
			ARRAY DATE:C224(v_139_168_ad; 0)  //Item93A
			C_DATE:C307(v_139_169_d)  //Item93B
			ARRAY DATE:C224(v_139_169_ad; 0)  //Item93B
			C_DATE:C307(v_139_170_d)  //Item93C
			ARRAY DATE:C224(v_139_170_ad; 0)  //Item93C
			C_DATE:C307(v_139_189_d)  //DateCreated
			ARRAY DATE:C224(v_139_189_ad; 0)  //DateCreated
			C_DATE:C307(v_139_191_d)  //DateModified
			ARRAY DATE:C224(v_139_191_ad; 0)  //DateModified
			C_DATE:C307(v_139_202_d)  //DateRatReport
			ARRAY DATE:C224(v_139_202_ad; 0)  //DateRatReport
			C_DATE:C307(v_139_211_d)  //UWSpInspDate
			ARRAY DATE:C224(v_139_211_ad; 0)  //UWSpInspDate
			C_DATE:C307(v_139_224_d)  //ArchiveDate_d
			ARRAY DATE:C224(v_139_224_ad; 0)  //ArchiveDate_d
			C_TIME:C306(v_139_190_tm)  //TimeCreated
			ARRAY TIME:C1223(v_139_190_atm; 0)  //TimeCreated
			C_TIME:C306(v_139_192_tm)  //TimeModified
			ARRAY TIME:C1223(v_139_192_atm; 0)  //TimeModified
			C_BOOLEAN:C305(v_139_004_b)  //FHWA Select
			ARRAY BOOLEAN:C223(v_139_004_ab; 0)  //FHWA Select
			C_BOOLEAN:C305(v_139_013_b)  //AreaEngVal
			ARRAY BOOLEAN:C223(v_139_013_ab; 0)  //AreaEngVal
			C_BOOLEAN:C305(v_139_014_b)  //BrgInspEngVal
			ARRAY BOOLEAN:C223(v_139_014_ab; 0)  //BrgInspEngVal
			C_BOOLEAN:C305(v_139_026_b)  //AntiMissile
			ARRAY BOOLEAN:C223(v_139_026_ab; 0)  //AntiMissile
			C_BOOLEAN:C305(v_139_028_b)  //Acrow Panel
			ARRAY BOOLEAN:C223(v_139_028_ab; 0)  //Acrow Panel
			C_BOOLEAN:C305(v_139_042_b)  //OtherInsp
			ARRAY BOOLEAN:C223(v_139_042_ab; 0)  //OtherInsp
			C_BOOLEAN:C305(v_139_045_b)  //ClosedInsp
			ARRAY BOOLEAN:C223(v_139_045_ab; 0)  //ClosedInsp
			C_BOOLEAN:C305(v_139_048_b)  //InspWaiver
			ARRAY BOOLEAN:C223(v_139_048_ab; 0)  //InspWaiver
			C_BOOLEAN:C305(v_139_063_b)  //Item6B
			ARRAY BOOLEAN:C223(v_139_063_ab; 0)  //Item6B
			C_BOOLEAN:C305(v_139_100_b)  //Item35
			ARRAY BOOLEAN:C223(v_139_100_ab; 0)  //Item35
			C_BOOLEAN:C305(v_139_102_b)  //StructDef
			ARRAY BOOLEAN:C223(v_139_102_ab; 0)  //StructDef
			C_BOOLEAN:C305(v_139_105_b)  //FunctObs
			ARRAY BOOLEAN:C223(v_139_105_ab; 0)  //FunctObs
			C_BOOLEAN:C305(v_139_117_b)  //Item112
			ARRAY BOOLEAN:C223(v_139_117_ab; 0)  //Item112
			C_BOOLEAN:C305(v_139_118_b)  //Item104
			ARRAY BOOLEAN:C223(v_139_118_ab; 0)  //Item104
			C_BOOLEAN:C305(v_139_123_b)  //Item103
			ARRAY BOOLEAN:C223(v_139_123_ab; 0)  //Item103
			C_BOOLEAN:C305(v_139_124_b)  //Item110
			ARRAY BOOLEAN:C223(v_139_124_ab; 0)  //Item110
			C_BOOLEAN:C305(v_139_137_b)  //OnSystem
			ARRAY BOOLEAN:C223(v_139_137_ab; 0)  //OnSystem
			C_BOOLEAN:C305(v_139_162_b)  //Item92AA
			ARRAY BOOLEAN:C223(v_139_162_ab; 0)  //Item92AA
			C_BOOLEAN:C305(v_139_164_b)  //Item92BA
			ARRAY BOOLEAN:C223(v_139_164_ab; 0)  //Item92BA
			C_BOOLEAN:C305(v_139_166_b)  //Item92CA
			ARRAY BOOLEAN:C223(v_139_166_ab; 0)  //Item92CA
			C_BOOLEAN:C305(v_139_173_b)  //FHWARecord
			ARRAY BOOLEAN:C223(v_139_173_ab; 0)  //FHWARecord
			C_BOOLEAN:C305(v_139_175_b)  //JointlessBridge
			ARRAY BOOLEAN:C223(v_139_175_ab; 0)  //JointlessBridge
			C_BOOLEAN:C305(v_139_176_b)  //OnTwnLine
			ARRAY BOOLEAN:C223(v_139_176_ab; 0)  //OnTwnLine
			C_BOOLEAN:C305(v_139_177_b)  //Complex Bridge
			ARRAY BOOLEAN:C223(v_139_177_ab; 0)  //Complex Bridge
			C_BOOLEAN:C305(v_139_181_b)  //OvrHeadSigns
			ARRAY BOOLEAN:C223(v_139_181_ab; 0)  //OvrHeadSigns
			C_BOOLEAN:C305(v_139_193_b)  //Item12
			ARRAY BOOLEAN:C223(v_139_193_ab; 0)  //Item12
			C_BOOLEAN:C305(v_139_209_b)  //UWSpInsp
			ARRAY BOOLEAN:C223(v_139_209_ab; 0)  //UWSpInsp
			C_BOOLEAN:C305(v_139_216_b)  //Complex Rating
			ARRAY BOOLEAN:C223(v_139_216_ab; 0)  //Complex Rating
			C_BOOLEAN:C305(v_139_220_b)  //MissSigns
			ARRAY BOOLEAN:C223(v_139_220_ab; 0)  //MissSigns
			C_BOOLEAN:C305(v_139_226_b)  //InspRequired
			ARRAY BOOLEAN:C223(v_139_226_ab; 0)  //InspRequired
		: ($1=140)  //NBISSecondaryArchive
			C_TEXT:C284(v_140_042_txt)  //NBISSecondaryArchive_UUIDKey_s
			ARRAY TEXT:C222(v_140_042_atxt; 0)  //NBISSecondaryArchive_UUIDKey_s
			C_TEXT:C284(v_140_001_txt)  //BIN
			ARRAY TEXT:C222(v_140_001_atxt; 0)  //BIN
			C_TEXT:C284(v_140_002_txt)  //Item3
			ARRAY TEXT:C222(v_140_002_atxt; 0)  //Item3
			C_TEXT:C284(v_140_003_txt)  //Item4
			ARRAY TEXT:C222(v_140_003_atxt; 0)  //Item4
			C_TEXT:C284(v_140_004_txt)  //Item5
			ARRAY TEXT:C222(v_140_004_atxt; 0)  //Item5
			C_TEXT:C284(v_140_005_txt)  //Item6A
			ARRAY TEXT:C222(v_140_005_atxt; 0)  //Item6A
			C_TEXT:C284(v_140_007_txt)  //Item7
			ARRAY TEXT:C222(v_140_007_atxt; 0)  //Item7
			C_TEXT:C284(v_140_008_txt)  //Item9
			ARRAY TEXT:C222(v_140_008_atxt; 0)  //Item9
			C_TEXT:C284(v_140_017_txt)  //Item20
			ARRAY TEXT:C222(v_140_017_atxt; 0)  //Item20
			C_TEXT:C284(v_140_018_txt)  //Item26
			ARRAY TEXT:C222(v_140_018_atxt; 0)  //Item26
			C_TEXT:C284(v_140_023_txt)  //Item42
			ARRAY TEXT:C222(v_140_023_atxt; 0)  //Item42
			C_TEXT:C284(v_140_024_txt)  //Item43
			ARRAY TEXT:C222(v_140_024_atxt; 0)  //Item43
			C_TEXT:C284(v_140_028_txt)  //Item100
			ARRAY TEXT:C222(v_140_028_atxt; 0)  //Item100
			C_TEXT:C284(v_140_029_txt)  //Item101
			ARRAY TEXT:C222(v_140_029_atxt; 0)  //Item101
			C_TEXT:C284(v_140_030_txt)  //Item102
			ARRAY TEXT:C222(v_140_030_atxt; 0)  //Item102
			C_TEXT:C284(v_140_034_txt)  //Bridge Key
			ARRAY TEXT:C222(v_140_034_atxt; 0)  //Bridge Key
			C_TEXT:C284(v_140_038_txt)  //Item8
			ARRAY TEXT:C222(v_140_038_atxt; 0)  //Item8
			C_TEXT:C284(v_140_039_txt)  //ArchiveReason_s
			ARRAY TEXT:C222(v_140_039_atxt; 0)  //ArchiveReason_s
			C_REAL:C285(v_140_009_r)  //Item10
			ARRAY REAL:C219(v_140_009_ar; 0)  //Item10
			C_REAL:C285(v_140_011_r)  //Item11
			ARRAY REAL:C219(v_140_011_ar; 0)  //Item11
			C_REAL:C285(v_140_025_r)  //Item47
			ARRAY REAL:C219(v_140_025_ar; 0)  //Item47
			C_REAL:C285(v_140_026_r)  //Item48
			ARRAY REAL:C219(v_140_026_ar; 0)  //Item48
			C_REAL:C285(v_140_027_r)  //Item49
			ARRAY REAL:C219(v_140_027_ar; 0)  //Item49
			C_REAL:C285(v_140_035_r)  //Item16C
			ARRAY REAL:C219(v_140_035_ar; 0)  //Item16C
			C_REAL:C285(v_140_036_r)  //Item17C
			ARRAY REAL:C219(v_140_036_ar; 0)  //Item17C
			C_LONGINT:C283(v_140_010_L)  //Item109
			ARRAY INTEGER:C220(v_140_010_ai; 0)  //Item109
			C_LONGINT:C283(v_140_012_L)  //Item16A
			ARRAY INTEGER:C220(v_140_012_ai; 0)  //Item16A
			C_LONGINT:C283(v_140_013_L)  //Item16B
			ARRAY INTEGER:C220(v_140_013_ai; 0)  //Item16B
			C_LONGINT:C283(v_140_014_L)  //Item17A
			ARRAY INTEGER:C220(v_140_014_ai; 0)  //Item17A
			C_LONGINT:C283(v_140_015_L)  //Item17B
			ARRAY INTEGER:C220(v_140_015_ai; 0)  //Item17B
			C_LONGINT:C283(v_140_016_L)  //Item19
			ARRAY INTEGER:C220(v_140_016_ai; 0)  //Item19
			C_LONGINT:C283(v_140_019_L)  //Item27
			ARRAY INTEGER:C220(v_140_019_ai; 0)  //Item27
			C_LONGINT:C283(v_140_020_L)  //Item28A
			ARRAY INTEGER:C220(v_140_020_ai; 0)  //Item28A
			C_LONGINT:C283(v_140_021_L)  //Item28B
			ARRAY INTEGER:C220(v_140_021_ai; 0)  //Item28B
			C_LONGINT:C283(v_140_037_L)  //Item30
			ARRAY INTEGER:C220(v_140_037_ai; 0)  //Item30
			C_LONGINT:C283(v_140_022_L)  //Item29
			ARRAY LONGINT:C221(v_140_022_aL; 0)  //Item29
			C_LONGINT:C283(v_140_041_L)  //NBISSecondaryKey_l
			ARRAY LONGINT:C221(v_140_041_aL; 0)  //NBISSecondaryKey_l
			C_DATE:C307(v_140_040_d)  //ArchiveDate_d
			ARRAY DATE:C224(v_140_040_ad; 0)  //ArchiveDate_d
			C_BOOLEAN:C305(v_140_006_b)  //Item6B
			ARRAY BOOLEAN:C223(v_140_006_ab; 0)  //Item6B
			C_BOOLEAN:C305(v_140_031_b)  //Item103
			ARRAY BOOLEAN:C223(v_140_031_ab; 0)  //Item103
			C_BOOLEAN:C305(v_140_032_b)  //Item104
			ARRAY BOOLEAN:C223(v_140_032_ab; 0)  //Item104
			C_BOOLEAN:C305(v_140_033_b)  //Item110
			ARRAY BOOLEAN:C223(v_140_033_ab; 0)  //Item110
		: ($1=141)  //PRJ_ProjectTypes
			C_TEXT:C284(v_141_005_txt)  //PRJ_ProjectTypes_UUIDKey_s
			ARRAY TEXT:C222(v_141_005_atxt; 0)  //PRJ_ProjectTypes_UUIDKey_s
			C_TEXT:C284(v_141_001_txt)  //PRTP_TypeCode_s
			ARRAY TEXT:C222(v_141_001_atxt; 0)  //PRTP_TypeCode_s
			C_TEXT:C284(v_141_002_txt)  //PRTP_Description_txt
			ARRAY TEXT:C222(v_141_002_atxt; 0)  //PRTP_Description_txt
			C_DATE:C307(v_141_003_d)  //PRTP_Created_d
			ARRAY DATE:C224(v_141_003_ad; 0)  //PRTP_Created_d
			C_DATE:C307(v_141_004_d)  //PRTP_Modified_d
			ARRAY DATE:C224(v_141_004_ad; 0)  //PRTP_Modified_d
		: ($1=142)  //DCM_ProjDailyHrs
			C_TEXT:C284(v_142_008_txt)  //DCM_ProjDailyHrs_UUIDKey_s
			ARRAY TEXT:C222(v_142_008_atxt; 0)  //DCM_ProjDailyHrs_UUIDKey_s
			C_TEXT:C284(v_142_006_txt)  //Comments_txt
			ARRAY TEXT:C222(v_142_006_atxt; 0)  //Comments_txt
			C_REAL:C285(v_142_004_r)  //RegHrs_r
			ARRAY REAL:C219(v_142_004_ar; 0)  //RegHrs_r
			C_REAL:C285(v_142_005_r)  //OTHrs_r
			ARRAY REAL:C219(v_142_005_ar; 0)  //OTHrs_r
			C_LONGINT:C283(v_142_001_L)  //DailyIItemD_L
			ARRAY LONGINT:C221(v_142_001_aL; 0)  //DailyIItemD_L
			C_LONGINT:C283(v_142_003_L)  //ArtisanNo_L
			ARRAY LONGINT:C221(v_142_003_aL; 0)  //ArtisanNo_L
			C_DATE:C307(v_142_002_d)  //DailyDate
			ARRAY DATE:C224(v_142_002_ad; 0)  //DailyDate
			C_BOOLEAN:C305(v_142_007_b)  //Dummy
			ARRAY BOOLEAN:C223(v_142_007_ab; 0)  //Dummy
		: ($1=143)  //DCM_ProjDailys
			C_TEXT:C284(v_143_006_txt)  //DCM_ProjDailys_UUIDKey_s
			ARRAY TEXT:C222(v_143_006_atxt; 0)  //DCM_ProjDailys_UUIDKey_s
			C_TEXT:C284(v_143_004_txt)  //Comments_txt
			ARRAY TEXT:C222(v_143_004_atxt; 0)  //Comments_txt
			C_LONGINT:C283(v_143_001_L)  //ProjectID
			ARRAY LONGINT:C221(v_143_001_aL; 0)  //ProjectID
			C_LONGINT:C283(v_143_002_L)  //DailyID_L
			ARRAY LONGINT:C221(v_143_002_aL; 0)  //DailyID_L
			C_DATE:C307(v_143_003_d)  //DailyDate_d
			ARRAY DATE:C224(v_143_003_ad; 0)  //DailyDate_d
			C_BOOLEAN:C305(v_143_005_b)  //Dummy_b
			ARRAY BOOLEAN:C223(v_143_005_ab; 0)  //Dummy_b
		: ($1=144)  //DCM_ProjDailyItems
			C_TEXT:C284(v_144_006_txt)  //DCM_ProjDailyItems_UUIDKey_s
			ARRAY TEXT:C222(v_144_006_atxt; 0)  //DCM_ProjDailyItems_UUIDKey_s
			C_TEXT:C284(v_144_003_txt)  //ItemNo_s
			ARRAY TEXT:C222(v_144_003_atxt; 0)  //ItemNo_s
			C_REAL:C285(v_144_004_r)  //ItemQuantity_r
			ARRAY REAL:C219(v_144_004_ar; 0)  //ItemQuantity_r
			C_LONGINT:C283(v_144_001_L)  //DailyID_L
			ARRAY LONGINT:C221(v_144_001_aL; 0)  //DailyID_L
			C_LONGINT:C283(v_144_002_L)  //DailyItemID_L
			ARRAY LONGINT:C221(v_144_002_aL; 0)  //DailyItemID_L
			C_BOOLEAN:C305(v_144_005_b)  //Dummy_b
			ARRAY BOOLEAN:C223(v_144_005_ab; 0)  //Dummy_b
		: ($1=145)  //Preservation_Reviews
			C_TEXT:C284(v_145_017_txt)  //Preservation_Reviews_UUIDKey_s
			ARRAY TEXT:C222(v_145_017_atxt; 0)  //Preservation_Reviews_UUIDKey_s
			C_TEXT:C284(v_145_003_txt)  //ReviewTYpe_s
			ARRAY TEXT:C222(v_145_003_atxt; 0)  //ReviewTYpe_s
			C_TEXT:C284(v_145_006_txt)  //Reviewer_s
			ARRAY TEXT:C222(v_145_006_atxt; 0)  //Reviewer_s
			C_TEXT:C284(v_145_008_txt)  //Action_s
			ARRAY TEXT:C222(v_145_008_atxt; 0)  //Action_s
			C_TEXT:C284(v_145_010_txt)  //CertificateType_s
			ARRAY TEXT:C222(v_145_010_atxt; 0)  //CertificateType_s
			C_TEXT:C284(v_145_011_txt)  //Comments_txt
			ARRAY TEXT:C222(v_145_011_atxt; 0)  //Comments_txt
			C_LONGINT:C283(v_145_001_L)  //Review_ID
			ARRAY LONGINT:C221(v_145_001_aL; 0)  //Review_ID
			C_LONGINT:C283(v_145_002_L)  //AssignID
			ARRAY LONGINT:C221(v_145_002_aL; 0)  //AssignID
			C_DATE:C307(v_145_004_d)  //Received_d
			ARRAY DATE:C224(v_145_004_ad; 0)  //Received_d
			C_DATE:C307(v_145_005_d)  //SentToREviewer_d
			ARRAY DATE:C224(v_145_005_ad; 0)  //SentToREviewer_d
			C_DATE:C307(v_145_007_d)  //CommentsRecd_d
			ARRAY DATE:C224(v_145_007_ad; 0)  //CommentsRecd_d
			C_DATE:C307(v_145_009_d)  //SentBackToPM_d
			ARRAY DATE:C224(v_145_009_ad; 0)  //SentBackToPM_d
			C_DATE:C307(v_145_012_d)  //Deadline_d
			ARRAY DATE:C224(v_145_012_ad; 0)  //Deadline_d
			C_DATE:C307(v_145_013_d)  //SentToDistr_d
			ARRAY DATE:C224(v_145_013_ad; 0)  //SentToDistr_d
			C_DATE:C307(v_145_014_d)  //ReviewerDeadline_d
			ARRAY DATE:C224(v_145_014_ad; 0)  //ReviewerDeadline_d
			C_DATE:C307(v_145_015_d)  //DistrCmtsReviewed_d
			ARRAY DATE:C224(v_145_015_ad; 0)  //DistrCmtsReviewed_d
			C_DATE:C307(v_145_016_d)  //ReceivedHardCopy_d
			ARRAY DATE:C224(v_145_016_ad; 0)  //ReceivedHardCopy_d
		: ($1=146)  //ONSQLAuthenticationErrors
			C_TEXT:C284(v_146_007_txt)  //ONSQLAuthenticationEr_UUIDKey_s
			ARRAY TEXT:C222(v_146_007_atxt; 0)  //ONSQLAuthenticationEr_UUIDKey_s
			C_TEXT:C284(v_146_001_txt)  //UserName_s
			ARRAY TEXT:C222(v_146_001_atxt; 0)  //UserName_s
			C_TEXT:C284(v_146_002_txt)  //IPAddress_txt
			ARRAY TEXT:C222(v_146_002_atxt; 0)  //IPAddress_txt
			C_TEXT:C284(v_146_003_txt)  //Reason_txt
			ARRAY TEXT:C222(v_146_003_atxt; 0)  //Reason_txt
			C_LONGINT:C283(v_146_006_L)  //NumberofAttempts_l
			ARRAY LONGINT:C221(v_146_006_aL; 0)  //NumberofAttempts_l
			C_DATE:C307(v_146_004_d)  //LastLogin_d
			ARRAY DATE:C224(v_146_004_ad; 0)  //LastLogin_d
			C_TIME:C306(v_146_005_tm)  //LastLogin_tm
			ARRAY TIME:C1223(v_146_005_atm; 0)  //LastLogin_tm
		: ($1=147)  //LB_QueryTable
			C_TEXT:C284(v_147_007_txt)  //LB_QueryTable_UUIDKey_s
			ARRAY TEXT:C222(v_147_007_atxt; 0)  //LB_QueryTable_UUIDKey_s
			C_TEXT:C284(v_147_001_txt)  //QueryName_s
			ARRAY TEXT:C222(v_147_001_atxt; 0)  //QueryName_s
			C_TEXT:C284(v_147_002_txt)  //ColumnWidths_txt
			ARRAY TEXT:C222(v_147_002_atxt; 0)  //ColumnWidths_txt
			C_TEXT:C284(v_147_004_txt)  //TableName_s
			ARRAY TEXT:C222(v_147_004_atxt; 0)  //TableName_s
			C_TEXT:C284(v_147_005_txt)  //WindowTitle_s
			ARRAY TEXT:C222(v_147_005_atxt; 0)  //WindowTitle_s
			C_LONGINT:C283(v_147_003_L)  //TableNumber_l
			ARRAY LONGINT:C221(v_147_003_aL; 0)  //TableNumber_l
			C_LONGINT:C283(v_147_006_L)  //UniqueKey_l
			ARRAY LONGINT:C221(v_147_006_aL; 0)  //UniqueKey_l
		: ($1=148)  //Preservation_Meetings
			C_TEXT:C284(v_148_012_txt)  //Preservation_Meetings_UUIDKey_s
			ARRAY TEXT:C222(v_148_012_atxt; 0)  //Preservation_Meetings_UUIDKey_s
			C_TEXT:C284(v_148_003_txt)  //MeetingType_s
			ARRAY TEXT:C222(v_148_003_atxt; 0)  //MeetingType_s
			C_TEXT:C284(v_148_006_txt)  //Purpose_txt
			ARRAY TEXT:C222(v_148_006_atxt; 0)  //Purpose_txt
			C_TEXT:C284(v_148_007_txt)  //Summary_txt
			ARRAY TEXT:C222(v_148_007_atxt; 0)  //Summary_txt
			C_TEXT:C284(v_148_008_txt)  //Location_txt
			ARRAY TEXT:C222(v_148_008_atxt; 0)  //Location_txt
			C_TEXT:C284(v_148_009_txt)  //Attendees_txt
			ARRAY TEXT:C222(v_148_009_atxt; 0)  //Attendees_txt
			C_REAL:C285(v_148_010_r)  //Hours_r
			ARRAY REAL:C219(v_148_010_ar; 0)  //Hours_r
			C_LONGINT:C283(v_148_001_L)  //MeetingID_L
			ARRAY LONGINT:C221(v_148_001_aL; 0)  //MeetingID_L
			C_LONGINT:C283(v_148_002_L)  //AssignID
			ARRAY LONGINT:C221(v_148_002_aL; 0)  //AssignID
			C_DATE:C307(v_148_004_d)  //MeetingDate_d
			ARRAY DATE:C224(v_148_004_ad; 0)  //MeetingDate_d
			C_TIME:C306(v_148_005_tm)  //MeetingTime_t
			ARRAY TIME:C1223(v_148_005_atm; 0)  //MeetingTime_t
			C_BOOLEAN:C305(v_148_011_b)  //Reserved
			ARRAY BOOLEAN:C223(v_148_011_ab; 0)  //Reserved
		: ($1=149)  //BridgeInfoLink
			C_TEXT:C284(v_149_011_txt)  //BridgeInfoLink_UUIDKey_s
			ARRAY TEXT:C222(v_149_011_atxt; 0)  //BridgeInfoLink_UUIDKey_s
			C_TEXT:C284(v_149_001_txt)  //BIN
			ARRAY TEXT:C222(v_149_001_atxt; 0)  //BIN
			C_TEXT:C284(v_149_002_txt)  //ScourPriorityRankInfoLink_s
			ARRAY TEXT:C222(v_149_002_atxt; 0)  //ScourPriorityRankInfoLink_s
			C_TEXT:C284(v_149_003_txt)  //RailInfoLink_s
			ARRAY TEXT:C222(v_149_003_atxt; 0)  //RailInfoLink_s
			C_TEXT:C284(v_149_004_txt)  //TunnelInfoLink_s
			ARRAY TEXT:C222(v_149_004_atxt; 0)  //TunnelInfoLink_s
			C_TEXT:C284(v_149_005_txt)  //ScourCriticalInfoLink_s
			ARRAY TEXT:C222(v_149_005_atxt; 0)  //ScourCriticalInfoLink_s
			C_TEXT:C284(v_149_006_txt)  //FutureLink1_s
			ARRAY TEXT:C222(v_149_006_atxt; 0)  //FutureLink1_s
			C_TEXT:C284(v_149_007_txt)  //FutureLink2_s
			ARRAY TEXT:C222(v_149_007_atxt; 0)  //FutureLink2_s
			C_TEXT:C284(v_149_008_txt)  //FutureLink3_s
			ARRAY TEXT:C222(v_149_008_atxt; 0)  //FutureLink3_s
			C_TEXT:C284(v_149_009_txt)  //FutureLink4_s
			ARRAY TEXT:C222(v_149_009_atxt; 0)  //FutureLink4_s
			C_TEXT:C284(v_149_010_txt)  //FutureLink5_s
			ARRAY TEXT:C222(v_149_010_atxt; 0)  //FutureLink5_s
		: ($1=150)  //ScourCriticalInfo
			C_TEXT:C284(v_150_017_txt)  //ScourCriticalInfo_UUIDKey_s
			ARRAY TEXT:C222(v_150_017_atxt; 0)  //ScourCriticalInfo_UUIDKey_s
			C_TEXT:C284(v_150_001_txt)  //BIN
			ARRAY TEXT:C222(v_150_001_atxt; 0)  //BIN
			C_TEXT:C284(v_150_009_txt)  //ProjInfo_s
			ARRAY TEXT:C222(v_150_009_atxt; 0)  //ProjInfo_s
			C_TEXT:C284(v_150_015_txt)  //SubItem113_s
			ARRAY TEXT:C222(v_150_015_atxt; 0)  //SubItem113_s
			C_TEXT:C284(v_150_016_txt)  //Comments_txt
			ARRAY TEXT:C222(v_150_016_atxt; 0)  //Comments_txt
			C_DATE:C307(v_150_003_d)  //POADate_d
			ARRAY DATE:C224(v_150_003_ad; 0)  //POADate_d
			C_DATE:C307(v_150_010_d)  //AdDate_d
			ARRAY DATE:C224(v_150_010_ad; 0)  //AdDate_d
			C_DATE:C307(v_150_013_d)  //CounterMeasInstallDate_d
			ARRAY DATE:C224(v_150_013_ad; 0)  //CounterMeasInstallDate_d
			C_BOOLEAN:C305(v_150_002_b)  //POAUpToDate_b
			ARRAY BOOLEAN:C223(v_150_002_ab; 0)  //POAUpToDate_b
			C_BOOLEAN:C305(v_150_004_b)  //CounterMeasNeeded_b
			ARRAY BOOLEAN:C223(v_150_004_ab; 0)  //CounterMeasNeeded_b
			C_BOOLEAN:C305(v_150_005_b)  //MonitoringNeeded_b
			ARRAY BOOLEAN:C223(v_150_005_ab; 0)  //MonitoringNeeded_b
			C_BOOLEAN:C305(v_150_006_b)  //VisualMonitoring_b
			ARRAY BOOLEAN:C223(v_150_006_ab; 0)  //VisualMonitoring_b
			C_BOOLEAN:C305(v_150_007_b)  //InstrumentMonitoring_b
			ARRAY BOOLEAN:C223(v_150_007_ab; 0)  //InstrumentMonitoring_b
			C_BOOLEAN:C305(v_150_008_b)  //InstrMonitoringInstalled_b
			ARRAY BOOLEAN:C223(v_150_008_ab; 0)  //InstrMonitoringInstalled_b
			C_BOOLEAN:C305(v_150_011_b)  //TotalReplacement_b
			ARRAY BOOLEAN:C223(v_150_011_ab; 0)  //TotalReplacement_b
			C_BOOLEAN:C305(v_150_012_b)  //CounterMeasInstalled_b
			ARRAY BOOLEAN:C223(v_150_012_ab; 0)  //CounterMeasInstalled_b
			C_BOOLEAN:C305(v_150_014_b)  //CounterMeasOnly_b
			ARRAY BOOLEAN:C223(v_150_014_ab; 0)  //CounterMeasOnly_b
		: ($1=151)  //TunnelInfo
			C_TEXT:C284(v_151_034_txt)  //TunnelInfo_UUIDKey_s
			ARRAY TEXT:C222(v_151_034_atxt; 0)  //TunnelInfo_UUIDKey_s
			C_TEXT:C284(v_151_001_txt)  //BIN
			ARRAY TEXT:C222(v_151_001_atxt; 0)  //BIN
			C_TEXT:C284(v_151_002_txt)  //Contract_s
			ARRAY TEXT:C222(v_151_002_atxt; 0)  //Contract_s
			C_TEXT:C284(v_151_003_txt)  //ConstructionType_s
			ARRAY TEXT:C222(v_151_003_atxt; 0)  //ConstructionType_s
			C_TEXT:C284(v_151_004_txt)  //StructureType_s
			ARRAY TEXT:C222(v_151_004_atxt; 0)  //StructureType_s
			C_TEXT:C284(v_151_006_txt)  //Structural_Rtg_s
			ARRAY TEXT:C222(v_151_006_atxt; 0)  //Structural_Rtg_s
			C_TEXT:C284(v_151_007_txt)  //Roadway_Rtg_s
			ARRAY TEXT:C222(v_151_007_atxt; 0)  //Roadway_Rtg_s
			C_TEXT:C284(v_151_008_txt)  //Ceiling_Rtg_s
			ARRAY TEXT:C222(v_151_008_atxt; 0)  //Ceiling_Rtg_s
			C_TEXT:C284(v_151_009_txt)  //SupplyAirDuct_Rtg_s
			ARRAY TEXT:C222(v_151_009_atxt; 0)  //SupplyAirDuct_Rtg_s
			C_TEXT:C284(v_151_010_txt)  //CrossPassage_Rtg_s
			ARRAY TEXT:C222(v_151_010_atxt; 0)  //CrossPassage_Rtg_s
			C_TEXT:C284(v_151_011_txt)  //Egress_Rtg_s
			ARRAY TEXT:C222(v_151_011_atxt; 0)  //Egress_Rtg_s
			C_TEXT:C284(v_151_012_txt)  //UtilityRoom_Rtg_s
			ARRAY TEXT:C222(v_151_012_atxt; 0)  //UtilityRoom_Rtg_s
			C_TEXT:C284(v_151_013_txt)  //Wetness_RTG_s
			ARRAY TEXT:C222(v_151_013_atxt; 0)  //Wetness_RTG_s
			C_TEXT:C284(v_151_014_txt)  //Cleanliness_RTG_s
			ARRAY TEXT:C222(v_151_014_atxt; 0)  //Cleanliness_RTG_s
			C_TEXT:C284(v_151_015_txt)  //AirMeter_s
			ARRAY TEXT:C222(v_151_015_atxt; 0)  //AirMeter_s
			C_TEXT:C284(v_151_016_txt)  //EscapeAir_s
			ARRAY TEXT:C222(v_151_016_atxt; 0)  //EscapeAir_s
			C_TEXT:C284(v_151_017_txt)  //ScissorLift_s
			ARRAY TEXT:C222(v_151_017_atxt; 0)  //ScissorLift_s
			C_TEXT:C284(v_151_018_txt)  //CreatedBy_s
			ARRAY TEXT:C222(v_151_018_atxt; 0)  //CreatedBy_s
			C_TEXT:C284(v_151_019_txt)  //CreatedTimeStamp_s
			ARRAY TEXT:C222(v_151_019_atxt; 0)  //CreatedTimeStamp_s
			C_TEXT:C284(v_151_020_txt)  //ModifiedBy_s
			ARRAY TEXT:C222(v_151_020_atxt; 0)  //ModifiedBy_s
			C_TEXT:C284(v_151_021_txt)  //ModifiedTimeStamp_s
			ARRAY TEXT:C222(v_151_021_atxt; 0)  //ModifiedTimeStamp_s
			C_TEXT:C284(v_151_030_txt)  //SpecialInsp1Desc_s
			ARRAY TEXT:C222(v_151_030_atxt; 0)  //SpecialInsp1Desc_s
			C_TEXT:C284(v_151_031_txt)  //SpecialInsp2Desc_s
			ARRAY TEXT:C222(v_151_031_atxt; 0)  //SpecialInsp2Desc_s
			C_TEXT:C284(v_151_032_txt)  //SpecialInsp3Desc_s
			ARRAY TEXT:C222(v_151_032_atxt; 0)  //SpecialInsp3Desc_s
			C_TEXT:C284(v_151_033_txt)  //NTI_i1_s
			ARRAY TEXT:C222(v_151_033_atxt; 0)  //NTI_i1_s
			C_LONGINT:C283(v_151_023_L)  //OverHeadInspFreq_i
			ARRAY INTEGER:C220(v_151_023_ai; 0)  //OverHeadInspFreq_i
			C_LONGINT:C283(v_151_025_L)  //SpecialInsp1Freq_i
			ARRAY INTEGER:C220(v_151_025_ai; 0)  //SpecialInsp1Freq_i
			C_LONGINT:C283(v_151_027_L)  //SpecialInsp2Freq_i
			ARRAY INTEGER:C220(v_151_027_ai; 0)  //SpecialInsp2Freq_i
			C_LONGINT:C283(v_151_029_L)  //SpecialInsp3Freq_i
			ARRAY INTEGER:C220(v_151_029_ai; 0)  //SpecialInsp3Freq_i
			C_DATE:C307(v_151_022_d)  //OverHeadInspDate_d
			ARRAY DATE:C224(v_151_022_ad; 0)  //OverHeadInspDate_d
			C_DATE:C307(v_151_024_d)  //SpecialInsp1Date_d
			ARRAY DATE:C224(v_151_024_ad; 0)  //SpecialInsp1Date_d
			C_DATE:C307(v_151_026_d)  //SpecialInsp2Date_d
			ARRAY DATE:C224(v_151_026_ad; 0)  //SpecialInsp2Date_d
			C_DATE:C307(v_151_028_d)  //SpecialInsp3Date_d
			ARRAY DATE:C224(v_151_028_ad; 0)  //SpecialInsp3Date_d
			C_BOOLEAN:C305(v_151_005_b)  //ChemicalAnchors_b
			ARRAY BOOLEAN:C223(v_151_005_ab; 0)  //ChemicalAnchors_b
		: ($1=152)  //TunnelInspection
			C_TEXT:C284(v_152_031_txt)  //TunnelInspection_UUIDKey_s
			ARRAY TEXT:C222(v_152_031_atxt; 0)  //TunnelInspection_UUIDKey_s
			C_TEXT:C284(v_152_003_txt)  //Structural_Rtg_s
			ARRAY TEXT:C222(v_152_003_atxt; 0)  //Structural_Rtg_s
			C_TEXT:C284(v_152_004_txt)  //Roadway_Rtg_s
			ARRAY TEXT:C222(v_152_004_atxt; 0)  //Roadway_Rtg_s
			C_TEXT:C284(v_152_005_txt)  //Ceiling_Rtg_s
			ARRAY TEXT:C222(v_152_005_atxt; 0)  //Ceiling_Rtg_s
			C_TEXT:C284(v_152_006_txt)  //SupplyAirDuct_Rtg_s
			ARRAY TEXT:C222(v_152_006_atxt; 0)  //SupplyAirDuct_Rtg_s
			C_TEXT:C284(v_152_007_txt)  //CrossPassage_Rtg_s
			ARRAY TEXT:C222(v_152_007_atxt; 0)  //CrossPassage_Rtg_s
			C_TEXT:C284(v_152_008_txt)  //Egress_Rtg_s
			ARRAY TEXT:C222(v_152_008_atxt; 0)  //Egress_Rtg_s
			C_TEXT:C284(v_152_009_txt)  //UtilityRoom_Rtg_s
			ARRAY TEXT:C222(v_152_009_atxt; 0)  //UtilityRoom_Rtg_s
			C_TEXT:C284(v_152_010_txt)  //Wetness_Rtg_s
			ARRAY TEXT:C222(v_152_010_atxt; 0)  //Wetness_Rtg_s
			C_TEXT:C284(v_152_011_txt)  //Cleanliness_Rtg_s
			ARRAY TEXT:C222(v_152_011_atxt; 0)  //Cleanliness_Rtg_s
			C_TEXT:C284(v_152_012_txt)  //AirMeter_s
			ARRAY TEXT:C222(v_152_012_atxt; 0)  //AirMeter_s
			C_TEXT:C284(v_152_013_txt)  //EscapeAir_s
			ARRAY TEXT:C222(v_152_013_atxt; 0)  //EscapeAir_s
			C_TEXT:C284(v_152_014_txt)  //ScissorLift_s
			ARRAY TEXT:C222(v_152_014_atxt; 0)  //ScissorLift_s
			C_TEXT:C284(v_152_016_txt)  //Structural_Prev_Rtg_s
			ARRAY TEXT:C222(v_152_016_atxt; 0)  //Structural_Prev_Rtg_s
			C_TEXT:C284(v_152_017_txt)  //Roadway_Prev_Rtg_s
			ARRAY TEXT:C222(v_152_017_atxt; 0)  //Roadway_Prev_Rtg_s
			C_TEXT:C284(v_152_018_txt)  //Ceiling_Prev_Rtg_s
			ARRAY TEXT:C222(v_152_018_atxt; 0)  //Ceiling_Prev_Rtg_s
			C_TEXT:C284(v_152_019_txt)  //SupplyAirDuct_Prev_Rtg_s
			ARRAY TEXT:C222(v_152_019_atxt; 0)  //SupplyAirDuct_Prev_Rtg_s
			C_TEXT:C284(v_152_020_txt)  //CrossPassage_Prev_Rtg_s
			ARRAY TEXT:C222(v_152_020_atxt; 0)  //CrossPassage_Prev_Rtg_s
			C_TEXT:C284(v_152_021_txt)  //Egress_Prev_Rtg_s
			ARRAY TEXT:C222(v_152_021_atxt; 0)  //Egress_Prev_Rtg_s
			C_TEXT:C284(v_152_022_txt)  //UtilityRoom_Prev_Rtg_s
			ARRAY TEXT:C222(v_152_022_atxt; 0)  //UtilityRoom_Prev_Rtg_s
			C_TEXT:C284(v_152_023_txt)  //Wetness_Prev_Rtg_s
			ARRAY TEXT:C222(v_152_023_atxt; 0)  //Wetness_Prev_Rtg_s
			C_TEXT:C284(v_152_024_txt)  //Cleanliness_Prev_Rtg_s
			ARRAY TEXT:C222(v_152_024_atxt; 0)  //Cleanliness_Prev_Rtg_s
			C_TEXT:C284(v_152_027_txt)  //StructuralCollisionValue_s
			ARRAY TEXT:C222(v_152_027_atxt; 0)  //StructuralCollisionValue_s
			C_TEXT:C284(v_152_028_txt)  //StructuralCollisionComments_txt
			ARRAY TEXT:C222(v_152_028_atxt; 0)  //StructuralCollisionComments_txt
			C_TEXT:C284(v_152_029_txt)  //RoadwayCollisionValue_s
			ARRAY TEXT:C222(v_152_029_atxt; 0)  //RoadwayCollisionValue_s
			C_TEXT:C284(v_152_030_txt)  //RoadwayCollisionComments_txt
			ARRAY TEXT:C222(v_152_030_atxt; 0)  //RoadwayCollisionComments_txt
			C_LONGINT:C283(v_152_001_L)  //InspID
			ARRAY LONGINT:C221(v_152_001_aL; 0)  //InspID
			C_LONGINT:C283(v_152_002_L)  //QA_QC_L
			ARRAY LONGINT:C221(v_152_002_aL; 0)  //QA_QC_L
			C_LONGINT:C283(v_152_015_L)  //TunnelInspID_L
			ARRAY LONGINT:C221(v_152_015_aL; 0)  //TunnelInspID_L
			C_DATE:C307(v_152_026_d)  //OverHeadInspDate_d
			ARRAY DATE:C224(v_152_026_ad; 0)  //OverHeadInspDate_d
			C_BOOLEAN:C305(v_152_025_b)  //ChemicalAnchors_b
			ARRAY BOOLEAN:C223(v_152_025_ab; 0)  //ChemicalAnchors_b
		: ($1=153)  //IS_ControlProcess
			C_BLOB:C604(v_153_013_blb)  //CP_History_blb
			ARRAY BLOB:C1222(v_153_013_ablb; 0)  //CP_History_blb
			C_TEXT:C284(v_153_024_txt)  //IS_ControlProcess_UUIDKey_s
			ARRAY TEXT:C222(v_153_024_atxt; 0)  //IS_ControlProcess_UUIDKey_s
			C_TEXT:C284(v_153_001_txt)  //CP_MethodName_s
			ARRAY TEXT:C222(v_153_001_atxt; 0)  //CP_MethodName_s
			C_TEXT:C284(v_153_002_txt)  //CP_ProcessRunSchedule_s
			ARRAY TEXT:C222(v_153_002_atxt; 0)  //CP_ProcessRunSchedule_s
			C_TEXT:C284(v_153_003_txt)  //CP_LastRunStartTimeStamp_s
			ARRAY TEXT:C222(v_153_003_atxt; 0)  //CP_LastRunStartTimeStamp_s
			C_TEXT:C284(v_153_004_txt)  //CP_NextRunTimeStamp_s
			ARRAY TEXT:C222(v_153_004_atxt; 0)  //CP_NextRunTimeStamp_s
			C_TEXT:C284(v_153_008_txt)  //CP_ClientName_s
			ARRAY TEXT:C222(v_153_008_atxt; 0)  //CP_ClientName_s
			C_TEXT:C284(v_153_011_txt)  //CP_Email_s
			ARRAY TEXT:C222(v_153_011_atxt; 0)  //CP_Email_s
			C_TEXT:C284(v_153_012_txt)  //CP_Error_s
			ARRAY TEXT:C222(v_153_012_atxt; 0)  //CP_Error_s
			C_TEXT:C284(v_153_014_txt)  //CP_LastRunEndTimeStamp_s
			ARRAY TEXT:C222(v_153_014_atxt; 0)  //CP_LastRunEndTimeStamp_s
			C_TEXT:C284(v_153_018_txt)  //CP_WeekToUse_s
			ARRAY TEXT:C222(v_153_018_atxt; 0)  //CP_WeekToUse_s
			C_TEXT:C284(v_153_022_txt)  //CP_ProcessName_s
			ARRAY TEXT:C222(v_153_022_atxt; 0)  //CP_ProcessName_s
			C_LONGINT:C283(v_153_006_L)  //CP_ControlProcessdelay_l
			ARRAY LONGINT:C221(v_153_006_aL; 0)  //CP_ControlProcessdelay_l
			C_LONGINT:C283(v_153_007_L)  //CP_WhereToRun_l
			ARRAY LONGINT:C221(v_153_007_aL; 0)  //CP_WhereToRun_l
			C_LONGINT:C283(v_153_009_L)  //CP_ProcessNumber_l
			ARRAY LONGINT:C221(v_153_009_aL; 0)  //CP_ProcessNumber_l
			C_LONGINT:C283(v_153_010_L)  //CP_StackSize_l
			ARRAY LONGINT:C221(v_153_010_aL; 0)  //CP_StackSize_l
			C_LONGINT:C283(v_153_016_L)  //CP_DayOfWeek_l
			ARRAY LONGINT:C221(v_153_016_aL; 0)  //CP_DayOfWeek_l
			C_LONGINT:C283(v_153_017_L)  //CP_NumberOfHistories_l
			ARRAY LONGINT:C221(v_153_017_aL; 0)  //CP_NumberOfHistories_l
			C_LONGINT:C283(v_153_019_L)  //CP_BeginSkipTime_l
			ARRAY LONGINT:C221(v_153_019_aL; 0)  //CP_BeginSkipTime_l
			C_LONGINT:C283(v_153_020_L)  //CP_EndSkipTime_l
			ARRAY LONGINT:C221(v_153_020_aL; 0)  //CP_EndSkipTime_l
			C_LONGINT:C283(v_153_021_L)  //CP_PrimaryKey_l
			ARRAY LONGINT:C221(v_153_021_aL; 0)  //CP_PrimaryKey_l
			C_BOOLEAN:C305(v_153_005_b)  //CP_ProcessRunning_b
			ARRAY BOOLEAN:C223(v_153_005_ab; 0)  //CP_ProcessRunning_b
			C_BOOLEAN:C305(v_153_015_b)  //CP_MustRunLastDay_b
			ARRAY BOOLEAN:C223(v_153_015_ab; 0)  //CP_MustRunLastDay_b
			C_BOOLEAN:C305(v_153_023_b)  //CP_AllowMultipleClients_b
			ARRAY BOOLEAN:C223(v_153_023_ab; 0)  //CP_AllowMultipleClients_b
		: ($1=154)  //RatingRequests
			C_TEXT:C284(v_154_019_txt)  //RatingRequests_UUIDKey_s
			ARRAY TEXT:C222(v_154_019_atxt; 0)  //RatingRequests_UUIDKey_s
			C_TEXT:C284(v_154_001_txt)  //BIN
			ARRAY TEXT:C222(v_154_001_atxt; 0)  //BIN
			C_TEXT:C284(v_154_005_txt)  //Priority_s
			ARRAY TEXT:C222(v_154_005_atxt; 0)  //Priority_s
			C_TEXT:C284(v_154_006_txt)  //ActionByAreaEng_s
			ARRAY TEXT:C222(v_154_006_atxt; 0)  //ActionByAreaEng_s
			C_TEXT:C284(v_154_008_txt)  //CommentsByAreaEng_txt
			ARRAY TEXT:C222(v_154_008_atxt; 0)  //CommentsByAreaEng_txt
			C_TEXT:C284(v_154_009_txt)  //ActionByBrgInspEng_s
			ARRAY TEXT:C222(v_154_009_atxt; 0)  //ActionByBrgInspEng_s
			C_TEXT:C284(v_154_011_txt)  //CommentsbyBrgInspEng_txt
			ARRAY TEXT:C222(v_154_011_atxt; 0)  //CommentsbyBrgInspEng_txt
			C_TEXT:C284(v_154_012_txt)  //ActionByStateBridgeEng_s
			ARRAY TEXT:C222(v_154_012_atxt; 0)  //ActionByStateBridgeEng_s
			C_TEXT:C284(v_154_014_txt)  //CommentsByStateBridgeEng_txt
			ARRAY TEXT:C222(v_154_014_atxt; 0)  //CommentsByStateBridgeEng_txt
			C_TEXT:C284(v_154_015_txt)  //Status_s
			ARRAY TEXT:C222(v_154_015_atxt; 0)  //Status_s
			C_LONGINT:C283(v_154_002_L)  //RatingRequestID_L
			ARRAY LONGINT:C221(v_154_002_aL; 0)  //RatingRequestID_L
			C_LONGINT:C283(v_154_017_L)  //ContractNo_L
			ARRAY LONGINT:C221(v_154_017_aL; 0)  //ContractNo_L
			C_LONGINT:C283(v_154_018_L)  //AssignmentNo_L
			ARRAY LONGINT:C221(v_154_018_aL; 0)  //AssignmentNo_L
			C_DATE:C307(v_154_003_d)  //DateOfRequest_d
			ARRAY DATE:C224(v_154_003_ad; 0)  //DateOfRequest_d
			C_DATE:C307(v_154_004_d)  //DateOfInspReport_d
			ARRAY DATE:C224(v_154_004_ad; 0)  //DateOfInspReport_d
			C_DATE:C307(v_154_007_d)  //ActionByAreaEngDate_d
			ARRAY DATE:C224(v_154_007_ad; 0)  //ActionByAreaEngDate_d
			C_DATE:C307(v_154_010_d)  //ActionByBrgInspEngDate_d
			ARRAY DATE:C224(v_154_010_ad; 0)  //ActionByBrgInspEngDate_d
			C_DATE:C307(v_154_013_d)  //ActionByStateBridgeEngDate_d
			ARRAY DATE:C224(v_154_013_ad; 0)  //ActionByStateBridgeEngDate_d
			C_DATE:C307(v_154_016_d)  //StatusDate_d
			ARRAY DATE:C224(v_154_016_ad; 0)  //StatusDate_d
		: ($1=155)  //AddtlRatingRequests
			C_TEXT:C284(v_155_005_txt)  //AddtlRatingRequests_UUIDKey_s
			ARRAY TEXT:C222(v_155_005_atxt; 0)  //AddtlRatingRequests_UUIDKey_s
			C_TEXT:C284(v_155_004_txt)  //Comments_txt
			ARRAY TEXT:C222(v_155_004_atxt; 0)  //Comments_txt
			C_LONGINT:C283(v_155_001_L)  //RatingRequestID_L
			ARRAY LONGINT:C221(v_155_001_aL; 0)  //RatingRequestID_L
			C_LONGINT:C283(v_155_002_L)  //AddtlRequestID_L
			ARRAY LONGINT:C221(v_155_002_aL; 0)  //AddtlRequestID_L
			C_DATE:C307(v_155_003_d)  //NewRequestDate_d
			ARRAY DATE:C224(v_155_003_ad; 0)  //NewRequestDate_d
		: ($1=156)  //BridgeRankCalc
			C_TEXT:C284(v_156_009_txt)  //BridgeRankCalc_UUIDKey_s
			ARRAY TEXT:C222(v_156_009_atxt; 0)  //BridgeRankCalc_UUIDKey_s
			C_TEXT:C284(v_156_003_txt)  //DataSource_s
			ARRAY TEXT:C222(v_156_003_atxt; 0)  //DataSource_s
			C_TEXT:C284(v_156_005_txt)  //ArchivePurpose_s
			ARRAY TEXT:C222(v_156_005_atxt; 0)  //ArchivePurpose_s
			C_TEXT:C284(v_156_007_txt)  //Comments_txt
			ARRAY TEXT:C222(v_156_007_atxt; 0)  //Comments_txt
			C_LONGINT:C283(v_156_001_L)  //RunID_L
			ARRAY LONGINT:C221(v_156_001_aL; 0)  //RunID_L
			C_DATE:C307(v_156_002_d)  //RunDate_d
			ARRAY DATE:C224(v_156_002_ad; 0)  //RunDate_d
			C_DATE:C307(v_156_004_d)  //ArchiveDate_d
			ARRAY DATE:C224(v_156_004_ad; 0)  //ArchiveDate_d
			C_DATE:C307(v_156_006_d)  //PontisMetricDate_d
			ARRAY DATE:C224(v_156_006_ad; 0)  //PontisMetricDate_d
			C_BOOLEAN:C305(v_156_008_b)  //Hidden_b
			ARRAY BOOLEAN:C223(v_156_008_ab; 0)  //Hidden_b
		: ($1=157)  //BridgeRankResult
			C_TEXT:C284(v_157_021_txt)  //BridgeRankResult_UUIDKey_s
			ARRAY TEXT:C222(v_157_021_atxt; 0)  //BridgeRankResult_UUIDKey_s
			C_TEXT:C284(v_157_002_txt)  //UniqueKey_s
			ARRAY TEXT:C222(v_157_002_atxt; 0)  //UniqueKey_s
			C_TEXT:C284(v_157_003_txt)  //BIN
			ARRAY TEXT:C222(v_157_003_atxt; 0)  //BIN
			C_TEXT:C284(v_157_016_txt)  //ScourCritical_s
			ARRAY TEXT:C222(v_157_016_atxt; 0)  //ScourCritical_s
			C_REAL:C285(v_157_005_r)  //RankFactor_r
			ARRAY REAL:C219(v_157_005_ar; 0)  //RankFactor_r
			C_REAL:C285(v_157_006_r)  //HIChangePct_r
			ARRAY REAL:C219(v_157_006_ar; 0)  //HIChangePct_r
			C_REAL:C285(v_157_007_r)  //HWYEvalFactor_r
			ARRAY REAL:C219(v_157_007_ar; 0)  //HWYEvalFactor_r
			C_REAL:C285(v_157_008_r)  //BridgeEvalFactor_r
			ARRAY REAL:C219(v_157_008_ar; 0)  //BridgeEvalFactor_r
			C_REAL:C285(v_157_009_r)  //ConditionLost_r
			ARRAY REAL:C219(v_157_009_ar; 0)  //ConditionLost_r
			C_REAL:C285(v_157_010_r)  //AdjHIChange_r
			ARRAY REAL:C219(v_157_010_ar; 0)  //AdjHIChange_r
			C_REAL:C285(v_157_011_r)  //ADTValue_r
			ARRAY REAL:C219(v_157_011_ar; 0)  //ADTValue_r
			C_REAL:C285(v_157_012_r)  //DetourValue_r
			ARRAY REAL:C219(v_157_012_ar; 0)  //DetourValue_r
			C_REAL:C285(v_157_013_r)  //ClassValue_r
			ARRAY REAL:C219(v_157_013_ar; 0)  //ClassValue_r
			C_REAL:C285(v_157_014_r)  //StructEvalValue_r
			ARRAY REAL:C219(v_157_014_ar; 0)  //StructEvalValue_r
			C_REAL:C285(v_157_015_r)  //DeckValue_r
			ARRAY REAL:C219(v_157_015_ar; 0)  //DeckValue_r
			C_REAL:C285(v_157_017_r)  //AvgCondition_r
			ARRAY REAL:C219(v_157_017_ar; 0)  //AvgCondition_r
			C_LONGINT:C283(v_157_001_L)  //RunID_L
			ARRAY LONGINT:C221(v_157_001_aL; 0)  //RunID_L
			C_LONGINT:C283(v_157_004_L)  //Rank_L
			ARRAY LONGINT:C221(v_157_004_aL; 0)  //Rank_L
			C_LONGINT:C283(v_157_018_L)  //FinalRank_L
			ARRAY LONGINT:C221(v_157_018_aL; 0)  //FinalRank_L
			C_LONGINT:C283(v_157_019_L)  //DistrictRank_L
			ARRAY LONGINT:C221(v_157_019_aL; 0)  //DistrictRank_L
			C_BOOLEAN:C305(v_157_020_b)  //Excluded_b
			ARRAY BOOLEAN:C223(v_157_020_ab; 0)  //Excluded_b
		: ($1=158)  //ElmtRatingLoads
			C_TEXT:C284(v_158_015_txt)  //ElmtRatingLoads_UUIDKey_s
			ARRAY TEXT:C222(v_158_015_atxt; 0)  //ElmtRatingLoads_UUIDKey_s
			C_TEXT:C284(v_158_013_txt)  //Dummy2_s
			ARRAY TEXT:C222(v_158_013_atxt; 0)  //Dummy2_s
			C_REAL:C285(v_158_003_r)  //R_E80_r
			ARRAY REAL:C219(v_158_003_ar; 0)  //R_E80_r
			C_REAL:C285(v_158_004_r)  //R_F40PH_r
			ARRAY REAL:C219(v_158_004_ar; 0)  //R_F40PH_r
			C_REAL:C285(v_158_005_r)  //R_286K_r
			ARRAY REAL:C219(v_158_005_ar; 0)  //R_286K_r
			C_REAL:C285(v_158_006_r)  //R_263K_r
			ARRAY REAL:C219(v_158_006_ar; 0)  //R_263K_r
			C_REAL:C285(v_158_007_r)  //R_315K_r
			ARRAY REAL:C219(v_158_007_ar; 0)  //R_315K_r
			C_REAL:C285(v_158_008_r)  //R_Neoplan_r
			ARRAY REAL:C219(v_158_008_ar; 0)  //R_Neoplan_r
			C_REAL:C285(v_158_009_r)  //R_NABI_r
			ARRAY REAL:C219(v_158_009_ar; 0)  //R_NABI_r
			C_REAL:C285(v_158_010_r)  //R_Revenue_r
			ARRAY REAL:C219(v_158_010_ar; 0)  //R_Revenue_r
			C_REAL:C285(v_158_011_r)  //R_HSP46_r
			ARRAY REAL:C219(v_158_011_ar; 0)  //R_HSP46_r
			C_REAL:C285(v_158_012_r)  //R_WorkCar_r
			ARRAY REAL:C219(v_158_012_ar; 0)  //R_WorkCar_r
			C_REAL:C285(v_158_014_r)  //R_HybridArtic_r
			ARRAY REAL:C219(v_158_014_ar; 0)  //R_HybridArtic_r
			C_LONGINT:C283(v_158_001_L)  //ElmtRtgLoadID_L
			ARRAY LONGINT:C221(v_158_001_aL; 0)  //ElmtRtgLoadID_L
			C_LONGINT:C283(v_158_002_L)  //ElmSafetyID
			ARRAY LONGINT:C221(v_158_002_aL; 0)  //ElmSafetyID
		: ($1=159)  //LSS_Accessibility
			C_TEXT:C284(v_159_007_txt)  //LSS_Accessibility_UUIDKey_s
			ARRAY TEXT:C222(v_159_007_atxt; 0)  //LSS_Accessibility_UUIDKey_s
			C_TEXT:C284(v_159_001_txt)  //LSS_AccessibilityId_s
			ARRAY TEXT:C222(v_159_001_atxt; 0)  //LSS_AccessibilityId_s
			C_TEXT:C284(v_159_003_txt)  //LSS_InspectionId_s
			ARRAY TEXT:C222(v_159_003_atxt; 0)  //LSS_InspectionId_s
			C_TEXT:C284(v_159_004_txt)  //LSS_Needed_s
			ARRAY TEXT:C222(v_159_004_atxt; 0)  //LSS_Needed_s
			C_TEXT:C284(v_159_005_txt)  //LSS_Used_s
			ARRAY TEXT:C222(v_159_005_atxt; 0)  //LSS_Used_s
			C_TEXT:C284(v_159_006_txt)  //LSS_AccessibilityDescription_s
			ARRAY TEXT:C222(v_159_006_atxt; 0)  //LSS_AccessibilityDescription_s
			C_LONGINT:C283(v_159_002_L)  //LSS_AccessibilityElementId_L
			ARRAY LONGINT:C221(v_159_002_aL; 0)  //LSS_AccessibilityElementId_L
		: ($1=160)  //LSS_AccessibilityElement
			C_TEXT:C284(v_160_003_txt)  //LSS_AccessibilityElem_UUIDKey_s
			ARRAY TEXT:C222(v_160_003_atxt; 0)  //LSS_AccessibilityElem_UUIDKey_s
			C_TEXT:C284(v_160_002_txt)  //LSS_Description_txt
			ARRAY TEXT:C222(v_160_002_atxt; 0)  //LSS_Description_txt
			C_LONGINT:C283(v_160_001_L)  //LSS_AccessibilityElementId_L
			ARRAY LONGINT:C221(v_160_001_aL; 0)  //LSS_AccessibilityElementId_L
		: ($1=161)  //LSS_DMeter
			C_TEXT:C284(v_161_010_txt)  //LSS_DMeter_UUIDKey_s
			ARRAY TEXT:C222(v_161_010_atxt; 0)  //LSS_DMeter_UUIDKey_s
			C_TEXT:C284(v_161_001_txt)  //LSS_DMeterId_s
			ARRAY TEXT:C222(v_161_001_atxt; 0)  //LSS_DMeterId_s
			C_TEXT:C284(v_161_002_txt)  //LSS_InspectionId_s
			ARRAY TEXT:C222(v_161_002_atxt; 0)  //LSS_InspectionId_s
			C_TEXT:C284(v_161_003_txt)  //LSS_Location_s
			ARRAY TEXT:C222(v_161_003_atxt; 0)  //LSS_Location_s
			C_TEXT:C284(v_161_004_txt)  //LSS_A_s
			ARRAY TEXT:C222(v_161_004_atxt; 0)  //LSS_A_s
			C_TEXT:C284(v_161_005_txt)  //LSS_B_s
			ARRAY TEXT:C222(v_161_005_atxt; 0)  //LSS_B_s
			C_TEXT:C284(v_161_006_txt)  //LSS_C_s
			ARRAY TEXT:C222(v_161_006_atxt; 0)  //LSS_C_s
			C_TEXT:C284(v_161_007_txt)  //LSS_D_s
			ARRAY TEXT:C222(v_161_007_atxt; 0)  //LSS_D_s
			C_TEXT:C284(v_161_008_txt)  //LSS_Reference_s
			ARRAY TEXT:C222(v_161_008_atxt; 0)  //LSS_Reference_s
			C_DATE:C307(v_161_009_d)  //LSS_DMeterDate_d
			ARRAY DATE:C224(v_161_009_ad; 0)  //LSS_DMeterDate_d
		: ($1=162)  //LSS_Element
			C_TEXT:C284(v_162_005_txt)  //LSS_Element_UUIDKey_s
			ARRAY TEXT:C222(v_162_005_atxt; 0)  //LSS_Element_UUIDKey_s
			C_TEXT:C284(v_162_002_txt)  //LSS_ElementDescription_s
			ARRAY TEXT:C222(v_162_002_atxt; 0)  //LSS_ElementDescription_s
			C_LONGINT:C283(v_162_001_L)  //LSS_ElementId_L
			ARRAY LONGINT:C221(v_162_001_aL; 0)  //LSS_ElementId_L
			C_BOOLEAN:C305(v_162_003_b)  //LSS_ElementHeader_b
			ARRAY BOOLEAN:C223(v_162_003_ab; 0)  //LSS_ElementHeader_b
			C_BOOLEAN:C305(v_162_004_b)  //LSS_CustomElement_b
			ARRAY BOOLEAN:C223(v_162_004_ab; 0)  //LSS_CustomElement_b
		: ($1=163)  //LSS_ElementInspection
			C_TEXT:C284(v_163_010_txt)  //LSS_ElementInspection_UUIDKey_s
			ARRAY TEXT:C222(v_163_010_atxt; 0)  //LSS_ElementInspection_UUIDKey_s
			C_TEXT:C284(v_163_001_txt)  //LSS_ElementInspectionId_s
			ARRAY TEXT:C222(v_163_001_atxt; 0)  //LSS_ElementInspectionId_s
			C_TEXT:C284(v_163_003_txt)  //LSS_InspectionId_s
			ARRAY TEXT:C222(v_163_003_atxt; 0)  //LSS_InspectionId_s
			C_TEXT:C284(v_163_004_txt)  //LSS_Rating_s
			ARRAY TEXT:C222(v_163_004_atxt; 0)  //LSS_Rating_s
			C_TEXT:C284(v_163_005_txt)  //LSS_Deficiency_s
			ARRAY TEXT:C222(v_163_005_atxt; 0)  //LSS_Deficiency_s
			C_TEXT:C284(v_163_006_txt)  //LSS_Urgency_s
			ARRAY TEXT:C222(v_163_006_atxt; 0)  //LSS_Urgency_s
			C_TEXT:C284(v_163_007_txt)  //LSS_Description_txt
			ARRAY TEXT:C222(v_163_007_atxt; 0)  //LSS_Description_txt
			C_TEXT:C284(v_163_008_txt)  //LSS_Remarks_txt
			ARRAY TEXT:C222(v_163_008_atxt; 0)  //LSS_Remarks_txt
			C_TEXT:C284(v_163_012_txt)  //LSS_DamageCurrentCondition_s
			ARRAY TEXT:C222(v_163_012_atxt; 0)  //LSS_DamageCurrentCondition_s
			C_TEXT:C284(v_163_013_txt)  //LSS_DamagePreviousCondition_s
			ARRAY TEXT:C222(v_163_013_atxt; 0)  //LSS_DamagePreviousCondition_s
			C_TEXT:C284(v_163_014_txt)  //LSS_DamageWeldCondition_s
			ARRAY TEXT:C222(v_163_014_atxt; 0)  //LSS_DamageWeldCondition_s
			C_LONGINT:C283(v_163_002_L)  //LSS_ElementId_L
			ARRAY LONGINT:C221(v_163_002_aL; 0)  //LSS_ElementId_L
			C_LONGINT:C283(v_163_009_L)  //LSS_SectionID_L
			ARRAY LONGINT:C221(v_163_009_aL; 0)  //LSS_SectionID_L
			C_BOOLEAN:C305(v_163_011_b)  //LSS_DamageCrack_B
			ARRAY BOOLEAN:C223(v_163_011_ab; 0)  //LSS_DamageCrack_B
		: ($1=164)  //LSS_Inspection
			C_TEXT:C284(v_164_051_txt)  //LSS_Inspection_UUIDKey_s
			ARRAY TEXT:C222(v_164_051_atxt; 0)  //LSS_Inspection_UUIDKey_s
			C_TEXT:C284(v_164_001_txt)  //LSS_InspectionId_s
			ARRAY TEXT:C222(v_164_001_atxt; 0)  //LSS_InspectionId_s
			C_TEXT:C284(v_164_002_txt)  //LSS_InventoryId_s
			ARRAY TEXT:C222(v_164_002_atxt; 0)  //LSS_InventoryId_s
			C_TEXT:C284(v_164_003_txt)  //LSS_InspectionTypeId_s
			ARRAY TEXT:C222(v_164_003_atxt; 0)  //LSS_InspectionTypeId_s
			C_TEXT:C284(v_164_006_txt)  //LSS_Weather_s
			ARRAY TEXT:C222(v_164_006_atxt; 0)  //LSS_Weather_s
			C_TEXT:C284(v_164_007_txt)  //LSS_AirTempF_s
			ARRAY TEXT:C222(v_164_007_atxt; 0)  //LSS_AirTempF_s
			C_TEXT:C284(v_164_010_txt)  //LSS_ConsultantName_txt
			ARRAY TEXT:C222(v_164_010_atxt; 0)  //LSS_ConsultantName_txt
			C_TEXT:C284(v_164_012_txt)  //LSS_CondFoundationCurr_s
			ARRAY TEXT:C222(v_164_012_atxt; 0)  //LSS_CondFoundationCurr_s
			C_TEXT:C284(v_164_013_txt)  //LSS_CondFoundationPrev_s
			ARRAY TEXT:C222(v_164_013_atxt; 0)  //LSS_CondFoundationPrev_s
			C_TEXT:C284(v_164_014_txt)  //LSS_CondStructureCurr_s
			ARRAY TEXT:C222(v_164_014_atxt; 0)  //LSS_CondStructureCurr_s
			C_TEXT:C284(v_164_015_txt)  //LSS_CondStructurePrev_s
			ARRAY TEXT:C222(v_164_015_atxt; 0)  //LSS_CondStructurePrev_s
			C_TEXT:C284(v_164_016_txt)  //LSS_StructAttachmentsCurr_s
			ARRAY TEXT:C222(v_164_016_atxt; 0)  //LSS_StructAttachmentsCurr_s
			C_TEXT:C284(v_164_017_txt)  //LSS_StructAttachmentsPrev_s
			ARRAY TEXT:C222(v_164_017_atxt; 0)  //LSS_StructAttachmentsPrev_s
			C_TEXT:C284(v_164_018_txt)  //LSS_CondSignPanelsCurr_s
			ARRAY TEXT:C222(v_164_018_atxt; 0)  //LSS_CondSignPanelsCurr_s
			C_TEXT:C284(v_164_019_txt)  //LSS_CondSignPanelsPrev_s
			ARRAY TEXT:C222(v_164_019_atxt; 0)  //LSS_CondSignPanelsPrev_s
			C_TEXT:C284(v_164_020_txt)  //LSS_CondTrafficSafetyCurr_s
			ARRAY TEXT:C222(v_164_020_atxt; 0)  //LSS_CondTrafficSafetyCurr_s
			C_TEXT:C284(v_164_021_txt)  //LSS_CondTrafficSafetyPrev_s
			ARRAY TEXT:C222(v_164_021_atxt; 0)  //LSS_CondTrafficSafetyPrev_s
			C_TEXT:C284(v_164_022_txt)  //LSS_CondLuminaireCurr_s
			ARRAY TEXT:C222(v_164_022_atxt; 0)  //LSS_CondLuminaireCurr_s
			C_TEXT:C284(v_164_023_txt)  //LSS_CondLuminairePrev_s
			ARRAY TEXT:C222(v_164_023_atxt; 0)  //LSS_CondLuminairePrev_s
			C_TEXT:C284(v_164_024_txt)  //LSS_CondOverallCurr_s
			ARRAY TEXT:C222(v_164_024_atxt; 0)  //LSS_CondOverallCurr_s
			C_TEXT:C284(v_164_025_txt)  //LSS_CondOverallPrev_s
			ARRAY TEXT:C222(v_164_025_atxt; 0)  //LSS_CondOverallPrev_s
			C_TEXT:C284(v_164_026_txt)  //LSS_Recommendations_txt
			ARRAY TEXT:C222(v_164_026_atxt; 0)  //LSS_Recommendations_txt
			C_TEXT:C284(v_164_031_txt)  //LSS_FieldTestPerformed_txt
			ARRAY TEXT:C222(v_164_031_atxt; 0)  //LSS_FieldTestPerformed_txt
			C_TEXT:C284(v_164_032_txt)  //LSS_GeneralComments_txt
			ARRAY TEXT:C222(v_164_032_atxt; 0)  //LSS_GeneralComments_txt
			C_TEXT:C284(v_164_033_txt)  //LSS_CsrRating_txt
			ARRAY TEXT:C222(v_164_033_atxt; 0)  //LSS_CsrRating_txt
			C_TEXT:C284(v_164_034_txt)  //LSS_CsrRatingYear_txt
			ARRAY TEXT:C222(v_164_034_atxt; 0)  //LSS_CsrRatingYear_txt
			C_TEXT:C284(v_164_035_txt)  //LSS_LanesUnderStructure_txt
			ARRAY TEXT:C222(v_164_035_atxt; 0)  //LSS_LanesUnderStructure_txt
			C_TEXT:C284(v_164_036_txt)  //LSS_ADT_s
			ARRAY TEXT:C222(v_164_036_atxt; 0)  //LSS_ADT_s
			C_TEXT:C284(v_164_037_txt)  //LSS_ADTYear_s
			ARRAY TEXT:C222(v_164_037_atxt; 0)  //LSS_ADTYear_s
			C_TEXT:C284(v_164_038_txt)  //LSS_AdditionalComments_txt
			ARRAY TEXT:C222(v_164_038_atxt; 0)  //LSS_AdditionalComments_txt
			C_TEXT:C284(v_164_045_txt)  //LSS_CreatedBy_s
			ARRAY TEXT:C222(v_164_045_atxt; 0)  //LSS_CreatedBy_s
			C_TEXT:C284(v_164_046_txt)  //LSS_CreatedISODate_s
			ARRAY TEXT:C222(v_164_046_atxt; 0)  //LSS_CreatedISODate_s
			C_TEXT:C284(v_164_047_txt)  //LSS_ModifiedBy_s
			ARRAY TEXT:C222(v_164_047_atxt; 0)  //LSS_ModifiedBy_s
			C_TEXT:C284(v_164_048_txt)  //LSS_ModifiedISODate_s
			ARRAY TEXT:C222(v_164_048_atxt; 0)  //LSS_ModifiedISODate_s
			C_TEXT:C284(v_164_049_txt)  //LSS_ApprovalComments_txt
			ARRAY TEXT:C222(v_164_049_atxt; 0)  //LSS_ApprovalComments_txt
			C_TEXT:C284(v_164_050_txt)  //LSS_DMeterNotes_txt
			ARRAY TEXT:C222(v_164_050_atxt; 0)  //LSS_DMeterNotes_txt
			C_TEXT:C284(v_164_053_txt)  //LSS_DamageBy_s
			ARRAY TEXT:C222(v_164_053_atxt; 0)  //LSS_DamageBy_s
			C_TEXT:C284(v_164_055_txt)  //LSS_DamageReimbursementNo_s
			ARRAY TEXT:C222(v_164_055_atxt; 0)  //LSS_DamageReimbursementNo_s
			C_TEXT:C284(v_164_056_txt)  //LSS_DamageCause_txt
			ARRAY TEXT:C222(v_164_056_atxt; 0)  //LSS_DamageCause_txt
			C_TEXT:C284(v_164_057_txt)  //LSS_DamBostonCopyForwardTo_s
			ARRAY TEXT:C222(v_164_057_atxt; 0)  //LSS_DamBostonCopyForwardTo_s
			C_TEXT:C284(v_164_059_txt)  //LSS_DamBostonOfficeRemarks_txt
			ARRAY TEXT:C222(v_164_059_atxt; 0)  //LSS_DamBostonOfficeRemarks_txt
			C_REAL:C285(v_164_027_r)  //LSS_TotalAccessibilityHours_r
			ARRAY REAL:C219(v_164_027_ar; 0)  //LSS_TotalAccessibilityHours_r
			C_LONGINT:C283(v_164_005_L)  //LSS_DistHWYEngineerId_L
			ARRAY LONGINT:C221(v_164_005_aL; 0)  //LSS_DistHWYEngineerId_L
			C_LONGINT:C283(v_164_008_L)  //LSS_TeamLeaderId_L
			ARRAY LONGINT:C221(v_164_008_aL; 0)  //LSS_TeamLeaderId_L
			C_LONGINT:C283(v_164_009_L)  //LSS_ProjectManagerId_L
			ARRAY LONGINT:C221(v_164_009_aL; 0)  //LSS_ProjectManagerId_L
			C_LONGINT:C283(v_164_041_L)  //LSS_Reviewed_L
			ARRAY LONGINT:C221(v_164_041_aL; 0)  //LSS_Reviewed_L
			C_LONGINT:C283(v_164_043_L)  //LSS_Approved_L
			ARRAY LONGINT:C221(v_164_043_aL; 0)  //LSS_Approved_L
			C_LONGINT:C283(v_164_060_L)  //LSS_ContractNo_L
			ARRAY LONGINT:C221(v_164_060_aL; 0)  //LSS_ContractNo_L
			C_LONGINT:C283(v_164_061_L)  //LSS_AssignmentNo_L
			ARRAY LONGINT:C221(v_164_061_aL; 0)  //LSS_AssignmentNo_L
			C_DATE:C307(v_164_004_d)  //LSS_InspectionDate_d
			ARRAY DATE:C224(v_164_004_ad; 0)  //LSS_InspectionDate_d
			C_DATE:C307(v_164_030_d)  //LSS_DateOfPhotos_d
			ARRAY DATE:C224(v_164_030_ad; 0)  //LSS_DateOfPhotos_d
			C_DATE:C307(v_164_040_d)  //LSS_CompleteDate_d
			ARRAY DATE:C224(v_164_040_ad; 0)  //LSS_CompleteDate_d
			C_DATE:C307(v_164_042_d)  //LSS_ReviewDate_d
			ARRAY DATE:C224(v_164_042_ad; 0)  //LSS_ReviewDate_d
			C_DATE:C307(v_164_044_d)  //LSS_ApprovedDate_d
			ARRAY DATE:C224(v_164_044_ad; 0)  //LSS_ApprovedDate_d
			C_DATE:C307(v_164_052_d)  //LSS_Damage_d
			ARRAY DATE:C224(v_164_052_ad; 0)  //LSS_Damage_d
			C_DATE:C307(v_164_058_d)  //LSS_DamBostonOffice_d
			ARRAY DATE:C224(v_164_058_ad; 0)  //LSS_DamBostonOffice_d
			C_BOOLEAN:C305(v_164_011_b)  //LSS_Cracks_b
			ARRAY BOOLEAN:C223(v_164_011_ab; 0)  //LSS_Cracks_b
			C_BOOLEAN:C305(v_164_028_b)  //LSS_Plans_b
			ARRAY BOOLEAN:C223(v_164_028_ab; 0)  //LSS_Plans_b
			C_BOOLEAN:C305(v_164_029_b)  //LSS_Photos_b
			ARRAY BOOLEAN:C223(v_164_029_ab; 0)  //LSS_Photos_b
			C_BOOLEAN:C305(v_164_039_b)  //LSS_Complete_b
			ARRAY BOOLEAN:C223(v_164_039_ab; 0)  //LSS_Complete_b
			C_BOOLEAN:C305(v_164_054_b)  //LSS_DamageAccidentReport_B
			ARRAY BOOLEAN:C223(v_164_054_ab; 0)  //LSS_DamageAccidentReport_B
		: ($1=165)  //LSS_Inventory
			C_TEXT:C284(v_165_033_txt)  //LSS_Inventory_UUIDKey_s
			ARRAY TEXT:C222(v_165_033_atxt; 0)  //LSS_Inventory_UUIDKey_s
			C_TEXT:C284(v_165_001_txt)  //LSS_InventoryId_s
			ARRAY TEXT:C222(v_165_001_atxt; 0)  //LSS_InventoryId_s
			C_TEXT:C284(v_165_002_txt)  //LSS_Category_s
			ARRAY TEXT:C222(v_165_002_atxt; 0)  //LSS_Category_s
			C_TEXT:C284(v_165_004_txt)  //LSS_Town_s
			ARRAY TEXT:C222(v_165_004_atxt; 0)  //LSS_Town_s
			C_TEXT:C284(v_165_006_txt)  //LSS_StructureNumber_s
			ARRAY TEXT:C222(v_165_006_atxt; 0)  //LSS_StructureNumber_s
			C_TEXT:C284(v_165_009_txt)  //LSS_Route_s
			ARRAY TEXT:C222(v_165_009_atxt; 0)  //LSS_Route_s
			C_TEXT:C284(v_165_010_txt)  //LSS_StructureLocation_txt
			ARRAY TEXT:C222(v_165_010_atxt; 0)  //LSS_StructureLocation_txt
			C_TEXT:C284(v_165_011_txt)  //LSS_YearBuilt_s
			ARRAY TEXT:C222(v_165_011_atxt; 0)  //LSS_YearBuilt_s
			C_TEXT:C284(v_165_012_txt)  //LSS_YearRemoved_s
			ARRAY TEXT:C222(v_165_012_atxt; 0)  //LSS_YearRemoved_s
			C_TEXT:C284(v_165_013_txt)  //LSS_YearRehabbed_s
			ARRAY TEXT:C222(v_165_013_atxt; 0)  //LSS_YearRehabbed_s
			C_TEXT:C284(v_165_014_txt)  //LSS_RouteDirection_s
			ARRAY TEXT:C222(v_165_014_atxt; 0)  //LSS_RouteDirection_s
			C_TEXT:C284(v_165_015_txt)  //LSS_StructureMaterialId_s
			ARRAY TEXT:C222(v_165_015_atxt; 0)  //LSS_StructureMaterialId_s
			C_TEXT:C284(v_165_016_txt)  //LSS_StructureCoatingId_s
			ARRAY TEXT:C222(v_165_016_atxt; 0)  //LSS_StructureCoatingId_s
			C_TEXT:C284(v_165_017_txt)  //LSS_AssetNo_txt
			ARRAY TEXT:C222(v_165_017_atxt; 0)  //LSS_AssetNo_txt
			C_TEXT:C284(v_165_021_txt)  //LSS_SpanArmLength1_txt
			ARRAY TEXT:C222(v_165_021_atxt; 0)  //LSS_SpanArmLength1_txt
			C_TEXT:C284(v_165_022_txt)  //LSS_SpanArmLength2_txt
			ARRAY TEXT:C222(v_165_022_atxt; 0)  //LSS_SpanArmLength2_txt
			C_TEXT:C284(v_165_023_txt)  //LSS_IntersectionNo_txt
			ARRAY TEXT:C222(v_165_023_atxt; 0)  //LSS_IntersectionNo_txt
			C_TEXT:C284(v_165_024_txt)  //LSS_DistFRMBasePlateToArm_txt
			ARRAY TEXT:C222(v_165_024_atxt; 0)  //LSS_DistFRMBasePlateToArm_txt
			C_TEXT:C284(v_165_025_txt)  //LSS_StructureTypeId_s
			ARRAY TEXT:C222(v_165_025_atxt; 0)  //LSS_StructureTypeId_s
			C_TEXT:C284(v_165_026_txt)  //LSS_DistFRMBasePlateToArm2_txt
			ARRAY TEXT:C222(v_165_026_atxt; 0)  //LSS_DistFRMBasePlateToArm2_txt
			C_TEXT:C284(v_165_027_txt)  //LSS_CreatedBy_s
			ARRAY TEXT:C222(v_165_027_atxt; 0)  //LSS_CreatedBy_s
			C_TEXT:C284(v_165_028_txt)  //LSS_InventoryType_s
			ARRAY TEXT:C222(v_165_028_atxt; 0)  //LSS_InventoryType_s
			C_TEXT:C284(v_165_029_txt)  //LSS_CreatedISODate_s
			ARRAY TEXT:C222(v_165_029_atxt; 0)  //LSS_CreatedISODate_s
			C_TEXT:C284(v_165_030_txt)  //LSS_ModifiedBy_s
			ARRAY TEXT:C222(v_165_030_atxt; 0)  //LSS_ModifiedBy_s
			C_TEXT:C284(v_165_031_txt)  //LSS_ModifiedISODate_s
			ARRAY TEXT:C222(v_165_031_atxt; 0)  //LSS_ModifiedISODate_s
			C_TEXT:C284(v_165_034_txt)  //LSS_Owner_s
			ARRAY TEXT:C222(v_165_034_atxt; 0)  //LSS_Owner_s
			C_TEXT:C284(v_165_035_txt)  //LSS_Status_s
			ARRAY TEXT:C222(v_165_035_atxt; 0)  //LSS_Status_s
			C_TEXT:C284(v_165_036_txt)  //LSS_StatusDate_s
			ARRAY TEXT:C222(v_165_036_atxt; 0)  //LSS_StatusDate_s
			C_REAL:C285(v_165_007_r)  //LSS_KiloPoint_r
			ARRAY REAL:C219(v_165_007_ar; 0)  //LSS_KiloPoint_r
			C_REAL:C285(v_165_008_r)  //LSS_MilePoint_r
			ARRAY REAL:C219(v_165_008_ar; 0)  //LSS_MilePoint_r
			C_REAL:C285(v_165_018_r)  //LSS_Longitude_r
			ARRAY REAL:C219(v_165_018_ar; 0)  //LSS_Longitude_r
			C_REAL:C285(v_165_019_r)  //LSS_Latitude_r
			ARRAY REAL:C219(v_165_019_ar; 0)  //LSS_Latitude_r
			C_REAL:C285(v_165_032_r)  //LSS_Elevation_r
			ARRAY REAL:C219(v_165_032_ar; 0)  //LSS_Elevation_r
			C_LONGINT:C283(v_165_003_L)  //LSS_District_L
			ARRAY LONGINT:C221(v_165_003_aL; 0)  //LSS_District_L
			C_LONGINT:C283(v_165_005_L)  //LSS_IdentificationNumber_L
			ARRAY LONGINT:C221(v_165_005_aL; 0)  //LSS_IdentificationNumber_L
			C_LONGINT:C283(v_165_020_L)  //LSS_NumberOfSpansArms_L
			ARRAY LONGINT:C221(v_165_020_aL; 0)  //LSS_NumberOfSpansArms_L
			C_LONGINT:C283(v_165_037_L)  //LSS_ProjNoBuilt_L
			ARRAY LONGINT:C221(v_165_037_aL; 0)  //LSS_ProjNoBuilt_L
			C_LONGINT:C283(v_165_038_L)  //LSS_ProjNoRemoved_L
			ARRAY LONGINT:C221(v_165_038_aL; 0)  //LSS_ProjNoRemoved_L
			C_LONGINT:C283(v_165_039_L)  //LSS_Cycle_L
			ARRAY LONGINT:C221(v_165_039_aL; 0)  //LSS_Cycle_L
			C_DATE:C307(v_165_040_d)  //LSS_NextSchedInsp_d
			ARRAY DATE:C224(v_165_040_ad; 0)  //LSS_NextSchedInsp_d
		: ($1=166)  //LSS_Photos
			C_BLOB:C604(v_166_005_blb)  //LSS_Photo_blb
			ARRAY BLOB:C1222(v_166_005_ablb; 0)  //LSS_Photo_blb
			C_TEXT:C284(v_166_007_txt)  //LSS_Photos_UUIDKey_s
			ARRAY TEXT:C222(v_166_007_atxt; 0)  //LSS_Photos_UUIDKey_s
			C_TEXT:C284(v_166_001_txt)  //LSS_PhotoId_s
			ARRAY TEXT:C222(v_166_001_atxt; 0)  //LSS_PhotoId_s
			C_TEXT:C284(v_166_002_txt)  //LSS_InspectionId_s
			ARRAY TEXT:C222(v_166_002_atxt; 0)  //LSS_InspectionId_s
			C_TEXT:C284(v_166_003_txt)  //LSS_PhotoType_s
			ARRAY TEXT:C222(v_166_003_atxt; 0)  //LSS_PhotoType_s
			C_TEXT:C284(v_166_004_txt)  //LSS_Photo_txt
			ARRAY TEXT:C222(v_166_004_atxt; 0)  //LSS_Photo_txt
			C_LONGINT:C283(v_166_006_L)  //LSS_PhotoSequence_L
			ARRAY LONGINT:C221(v_166_006_aL; 0)  //LSS_PhotoSequence_L
		: ($1=167)  //LSS_refInspectionType
			C_TEXT:C284(v_167_004_txt)  //LSS_refInspectionType_UUIDKey_s
			ARRAY TEXT:C222(v_167_004_atxt; 0)  //LSS_refInspectionType_UUIDKey_s
			C_TEXT:C284(v_167_001_txt)  //LSS_InspectionTypeId_s
			ARRAY TEXT:C222(v_167_001_atxt; 0)  //LSS_InspectionTypeId_s
			C_TEXT:C284(v_167_002_txt)  //LSS_Description_txt
			ARRAY TEXT:C222(v_167_002_atxt; 0)  //LSS_Description_txt
			C_TEXT:C284(v_167_003_txt)  //LSS_AllowedElements_txt
			ARRAY TEXT:C222(v_167_003_atxt; 0)  //LSS_AllowedElements_txt
		: ($1=168)  //LSS_refRouteDirection
			C_TEXT:C284(v_168_003_txt)  //LSS_refRouteDirection_UUIDKey_s
			ARRAY TEXT:C222(v_168_003_atxt; 0)  //LSS_refRouteDirection_UUIDKey_s
			C_TEXT:C284(v_168_001_txt)  //LSS_RouteDirectionId_s
			ARRAY TEXT:C222(v_168_001_atxt; 0)  //LSS_RouteDirectionId_s
			C_TEXT:C284(v_168_002_txt)  //LSS_Description_txt
			ARRAY TEXT:C222(v_168_002_atxt; 0)  //LSS_Description_txt
		: ($1=169)  //LSS_refStructureCoating
			C_TEXT:C284(v_169_003_txt)  //LSS_refStructureCoati_UUIDKey_s
			ARRAY TEXT:C222(v_169_003_atxt; 0)  //LSS_refStructureCoati_UUIDKey_s
			C_TEXT:C284(v_169_001_txt)  //LSS_StructureCoatingId_s
			ARRAY TEXT:C222(v_169_001_atxt; 0)  //LSS_StructureCoatingId_s
			C_TEXT:C284(v_169_002_txt)  //LSS_Description_txt
			ARRAY TEXT:C222(v_169_002_atxt; 0)  //LSS_Description_txt
		: ($1=170)  //LSS_refStructureMaterial
			C_TEXT:C284(v_170_003_txt)  //LSS_refStructureMater_UUIDKey_s
			ARRAY TEXT:C222(v_170_003_atxt; 0)  //LSS_refStructureMater_UUIDKey_s
			C_TEXT:C284(v_170_001_txt)  //LSS_StructureMaterialId_s
			ARRAY TEXT:C222(v_170_001_atxt; 0)  //LSS_StructureMaterialId_s
			C_TEXT:C284(v_170_002_txt)  //LSS_Description_txt
			ARRAY TEXT:C222(v_170_002_atxt; 0)  //LSS_Description_txt
		: ($1=171)  //LSS_refStructureTypes
			C_TEXT:C284(v_171_004_txt)  //LSS_refStructureTypes_UUIDKey_s
			ARRAY TEXT:C222(v_171_004_atxt; 0)  //LSS_refStructureTypes_UUIDKey_s
			C_TEXT:C284(v_171_001_txt)  //LSS_StructureTypeId_s
			ARRAY TEXT:C222(v_171_001_atxt; 0)  //LSS_StructureTypeId_s
			C_TEXT:C284(v_171_002_txt)  //LSS_Category_s
			ARRAY TEXT:C222(v_171_002_atxt; 0)  //LSS_Category_s
			C_TEXT:C284(v_171_003_txt)  //LSS_Description_txt
			ARRAY TEXT:C222(v_171_003_atxt; 0)  //LSS_Description_txt
		: ($1=172)  //LSS_SignPanel
			C_TEXT:C284(v_172_009_txt)  //LSS_SignPanel_UUIDKey_s
			ARRAY TEXT:C222(v_172_009_atxt; 0)  //LSS_SignPanel_UUIDKey_s
			C_TEXT:C284(v_172_001_txt)  //LSS_SignPanelId_s
			ARRAY TEXT:C222(v_172_001_atxt; 0)  //LSS_SignPanelId_s
			C_TEXT:C284(v_172_002_txt)  //LSS_InspectionId_s
			ARRAY TEXT:C222(v_172_002_atxt; 0)  //LSS_InspectionId_s
			C_TEXT:C284(v_172_003_txt)  //LSS_Panel_s
			ARRAY TEXT:C222(v_172_003_atxt; 0)  //LSS_Panel_s
			C_TEXT:C284(v_172_004_txt)  //LSS_Width_s
			ARRAY TEXT:C222(v_172_004_atxt; 0)  //LSS_Width_s
			C_TEXT:C284(v_172_005_txt)  //LSS_Height_s
			ARRAY TEXT:C222(v_172_005_atxt; 0)  //LSS_Height_s
			C_TEXT:C284(v_172_006_txt)  //LSS_PanelMessage_txt
			ARRAY TEXT:C222(v_172_006_atxt; 0)  //LSS_PanelMessage_txt
			C_TEXT:C284(v_172_007_txt)  //LSS_PanelType_s
			ARRAY TEXT:C222(v_172_007_atxt; 0)  //LSS_PanelType_s
			C_TEXT:C284(v_172_008_txt)  //LSS_LanesPanelOver_txt
			ARRAY TEXT:C222(v_172_008_atxt; 0)  //LSS_LanesPanelOver_txt
		: ($1=173)  //LSS_TeamMembers
			C_TEXT:C284(v_173_003_txt)  //LSS_TeamMembers_UUIDKey_s
			ARRAY TEXT:C222(v_173_003_atxt; 0)  //LSS_TeamMembers_UUIDKey_s
			C_TEXT:C284(v_173_001_txt)  //LSS_InspectionId_s
			ARRAY TEXT:C222(v_173_001_atxt; 0)  //LSS_InspectionId_s
			C_LONGINT:C283(v_173_002_L)  //LSS_TeamMemberId_L
			ARRAY LONGINT:C221(v_173_002_aL; 0)  //LSS_TeamMemberId_L
		: ($1=174)  //LSS_TowerDistance
			C_TEXT:C284(v_174_006_txt)  //LSS_TowerDistance_UUIDKey_s
			ARRAY TEXT:C222(v_174_006_atxt; 0)  //LSS_TowerDistance_UUIDKey_s
			C_TEXT:C284(v_174_001_txt)  //LSS_TowerDistanceId_s
			ARRAY TEXT:C222(v_174_001_atxt; 0)  //LSS_TowerDistanceId_s
			C_TEXT:C284(v_174_002_txt)  //LSS_InspectionId_s
			ARRAY TEXT:C222(v_174_002_atxt; 0)  //LSS_InspectionId_s
			C_TEXT:C284(v_174_003_txt)  //LSS_TowerOrPost_txt
			ARRAY TEXT:C222(v_174_003_atxt; 0)  //LSS_TowerOrPost_txt
			C_TEXT:C284(v_174_004_txt)  //LSS_SignPanel_s
			ARRAY TEXT:C222(v_174_004_atxt; 0)  //LSS_SignPanel_s
			C_TEXT:C284(v_174_005_txt)  //LSS_Distance_txt
			ARRAY TEXT:C222(v_174_005_atxt; 0)  //LSS_Distance_txt
		: ($1=175)  //LSS_UT
			C_TEXT:C284(v_175_015_txt)  //LSS_UT_UUIDKey_s
			ARRAY TEXT:C222(v_175_015_atxt; 0)  //LSS_UT_UUIDKey_s
			C_TEXT:C284(v_175_001_txt)  //LSS_UTId_s
			ARRAY TEXT:C222(v_175_001_atxt; 0)  //LSS_UTId_s
			C_TEXT:C284(v_175_002_txt)  //LSS_InspectionId_s
			ARRAY TEXT:C222(v_175_002_atxt; 0)  //LSS_InspectionId_s
			C_TEXT:C284(v_175_003_txt)  //LSS_TechnicianName_s
			ARRAY TEXT:C222(v_175_003_atxt; 0)  //LSS_TechnicianName_s
			C_TEXT:C284(v_175_004_txt)  //LSS_ASNTLevel_s
			ARRAY TEXT:C222(v_175_004_atxt; 0)  //LSS_ASNTLevel_s
			C_TEXT:C284(v_175_005_txt)  //LSS_AnchorRodDiameter_s
			ARRAY TEXT:C222(v_175_005_atxt; 0)  //LSS_AnchorRodDiameter_s
			C_TEXT:C284(v_175_006_txt)  //LSS_AnchorRodLength_s
			ARRAY TEXT:C222(v_175_006_atxt; 0)  //LSS_AnchorRodLength_s
			C_TEXT:C284(v_175_007_txt)  //LSS_StructureTypeId_s
			ARRAY TEXT:C222(v_175_007_atxt; 0)  //LSS_StructureTypeId_s
			C_TEXT:C284(v_175_008_txt)  //LSS_MachineTypeSerialNo_s
			ARRAY TEXT:C222(v_175_008_atxt; 0)  //LSS_MachineTypeSerialNo_s
			C_TEXT:C284(v_175_009_txt)  //LSS_SearchUnitNearZone_s
			ARRAY TEXT:C222(v_175_009_atxt; 0)  //LSS_SearchUnitNearZone_s
			C_TEXT:C284(v_175_010_txt)  //LSS_SmallestDetectableDef_s
			ARRAY TEXT:C222(v_175_010_atxt; 0)  //LSS_SmallestDetectableDef_s
			C_TEXT:C284(v_175_011_txt)  //LSS_SearchUnitBeamSpread_s
			ARRAY TEXT:C222(v_175_011_atxt; 0)  //LSS_SearchUnitBeamSpread_s
			C_TEXT:C284(v_175_012_txt)  //LSS_SearchUnitMfgr_s
			ARRAY TEXT:C222(v_175_012_atxt; 0)  //LSS_SearchUnitMfgr_s
			C_TEXT:C284(v_175_013_txt)  //LSS_SRCHUnitDiameterFreq_s
			ARRAY TEXT:C222(v_175_013_atxt; 0)  //LSS_SRCHUnitDiameterFreq_s
			C_TEXT:C284(v_175_014_txt)  //LSS_CouplantMfgrAndGrade_s
			ARRAY TEXT:C222(v_175_014_atxt; 0)  //LSS_CouplantMfgrAndGrade_s
		: ($1=176)  //LSS_UtResult
			C_TEXT:C284(v_176_009_txt)  //LSS_UtResult_UUIDKey_s
			ARRAY TEXT:C222(v_176_009_atxt; 0)  //LSS_UtResult_UUIDKey_s
			C_TEXT:C284(v_176_001_txt)  //LSS_UTResultId_s
			ARRAY TEXT:C222(v_176_001_atxt; 0)  //LSS_UTResultId_s
			C_TEXT:C284(v_176_002_txt)  //LSS_UTId_s
			ARRAY TEXT:C222(v_176_002_atxt; 0)  //LSS_UTId_s
			C_TEXT:C284(v_176_004_txt)  //LSS_IndicationAndLocation_txt
			ARRAY TEXT:C222(v_176_004_atxt; 0)  //LSS_IndicationAndLocation_txt
			C_TEXT:C284(v_176_005_txt)  //LSS_Location_txt
			ARRAY TEXT:C222(v_176_005_atxt; 0)  //LSS_Location_txt
			C_TEXT:C284(v_176_008_txt)  //LSS_Remarks_txt
			ARRAY TEXT:C222(v_176_008_atxt; 0)  //LSS_Remarks_txt
			C_LONGINT:C283(v_176_003_L)  //LSS_RodNo_L
			ARRAY LONGINT:C221(v_176_003_aL; 0)  //LSS_RodNo_L
			C_BOOLEAN:C305(v_176_006_b)  //LSS_Accept_b
			ARRAY BOOLEAN:C223(v_176_006_ab; 0)  //LSS_Accept_b
			C_BOOLEAN:C305(v_176_007_b)  //LSS_Reject_b
			ARRAY BOOLEAN:C223(v_176_007_ab; 0)  //LSS_Reject_b
		: ($1=177)  //LSS_VerticalClearance
			C_TEXT:C284(v_177_007_txt)  //LSS_VerticalClearance_UUIDKey_s
			ARRAY TEXT:C222(v_177_007_atxt; 0)  //LSS_VerticalClearance_UUIDKey_s
			C_TEXT:C284(v_177_001_txt)  //LSS_VerticalClearanceId_s
			ARRAY TEXT:C222(v_177_001_atxt; 0)  //LSS_VerticalClearanceId_s
			C_TEXT:C284(v_177_002_txt)  //LSS_InspectionId_s
			ARRAY TEXT:C222(v_177_002_atxt; 0)  //LSS_InspectionId_s
			C_TEXT:C284(v_177_003_txt)  //LSS_Panel_txt
			ARRAY TEXT:C222(v_177_003_atxt; 0)  //LSS_Panel_txt
			C_REAL:C285(v_177_006_r)  //LSS_Meters_r
			ARRAY REAL:C219(v_177_006_ar; 0)  //LSS_Meters_r
			C_LONGINT:C283(v_177_004_L)  //LSS_Feet_L
			ARRAY LONGINT:C221(v_177_004_aL; 0)  //LSS_Feet_L
			C_LONGINT:C283(v_177_005_L)  //LSS_Inches_L
			ARRAY LONGINT:C221(v_177_005_aL; 0)  //LSS_Inches_L
		: ($1=178)  //PON_ELEM_DEFS
			C_TEXT:C284(v_178_023_txt)  //PON_ELEM_DEFS_UUIDKey_s
			ARRAY TEXT:C222(v_178_023_atxt; 0)  //PON_ELEM_DEFS_UUIDKey_s
			C_TEXT:C284(v_178_002_txt)  //ELEM_NBE_STAT
			ARRAY TEXT:C222(v_178_002_atxt; 0)  //ELEM_NBE_STAT
			C_TEXT:C284(v_178_003_txt)  //ELEM_PROTECT_SYS
			ARRAY TEXT:C222(v_178_003_atxt; 0)  //ELEM_PROTECT_SYS
			C_TEXT:C284(v_178_004_txt)  //ELEM_SMART_FLAG
			ARRAY TEXT:C222(v_178_004_atxt; 0)  //ELEM_SMART_FLAG
			C_TEXT:C284(v_178_005_txt)  //ELEM_CAT_KEY
			ARRAY TEXT:C222(v_178_005_atxt; 0)  //ELEM_CAT_KEY
			C_TEXT:C284(v_178_006_txt)  //ELEM_TYPE_KEY
			ARRAY TEXT:C222(v_178_006_atxt; 0)  //ELEM_TYPE_KEY
			C_TEXT:C284(v_178_007_txt)  //ELEM_MAT_KEY
			ARRAY TEXT:C222(v_178_007_atxt; 0)  //ELEM_MAT_KEY
			C_TEXT:C284(v_178_009_txt)  //ELEM_MODEL
			ARRAY TEXT:C222(v_178_009_atxt; 0)  //ELEM_MODEL
			C_TEXT:C284(v_178_010_txt)  //ELEM_SHORTNAME
			ARRAY TEXT:C222(v_178_010_atxt; 0)  //ELEM_SHORTNAME
			C_TEXT:C284(v_178_011_txt)  //ELEM_LONGNAME
			ARRAY TEXT:C222(v_178_011_atxt; 0)  //ELEM_LONGNAME
			C_TEXT:C284(v_178_012_txt)  //ELEM_SCALESHORT
			ARRAY TEXT:C222(v_178_012_atxt; 0)  //ELEM_SCALESHORT
			C_TEXT:C284(v_178_013_txt)  //ELEM_SCALEUNIT
			ARRAY TEXT:C222(v_178_013_atxt; 0)  //ELEM_SCALEUNIT
			C_TEXT:C284(v_178_015_txt)  //ELEM_CREATEDATETIME
			ARRAY TEXT:C222(v_178_015_atxt; 0)  //ELEM_CREATEDATETIME
			C_TEXT:C284(v_178_016_txt)  //ELEM_CREATEUSERKEY
			ARRAY TEXT:C222(v_178_016_atxt; 0)  //ELEM_CREATEUSERKEY
			C_TEXT:C284(v_178_017_txt)  //ELEM_MODTIME
			ARRAY TEXT:C222(v_178_017_atxt; 0)  //ELEM_MODTIME
			C_TEXT:C284(v_178_018_txt)  //ELEM_MODUSERKEY
			ARRAY TEXT:C222(v_178_018_atxt; 0)  //ELEM_MODUSERKEY
			C_TEXT:C284(v_178_019_txt)  //ELEM_NOTES
			ARRAY TEXT:C222(v_178_019_atxt; 0)  //ELEM_NOTES
			C_TEXT:C284(v_178_021_txt)  //FHWA_REPORTED
			ARRAY TEXT:C222(v_178_021_atxt; 0)  //FHWA_REPORTED
			C_REAL:C285(v_178_014_r)  //ELEM_WEIGHT
			ARRAY REAL:C219(v_178_014_ar; 0)  //ELEM_WEIGHT
			C_REAL:C285(v_178_020_r)  //ELEM_REL_WEIGHT
			ARRAY REAL:C219(v_178_020_ar; 0)  //ELEM_REL_WEIGHT
			C_LONGINT:C283(v_178_008_L)  //ELEM_PAIRCODE
			ARRAY INTEGER:C220(v_178_008_ai; 0)  //ELEM_PAIRCODE
			C_LONGINT:C283(v_178_001_L)  //ELEM_KEY
			ARRAY LONGINT:C221(v_178_001_aL; 0)  //ELEM_KEY
			C_LONGINT:C283(v_178_022_L)  //ELEM_SUBSET_KEY
			ARRAY LONGINT:C221(v_178_022_aL; 0)  //ELEM_SUBSET_KEY
		: ($1=179)  //PON_ELEM_INSP
			C_TEXT:C284(v_179_030_txt)  //PON_ELEM_INSP_UUIDKey_s
			ARRAY TEXT:C222(v_179_030_atxt; 0)  //PON_ELEM_INSP_UUIDKey_s
			C_TEXT:C284(v_179_001_txt)  //BRKEY
			ARRAY TEXT:C222(v_179_001_atxt; 0)  //BRKEY
			C_TEXT:C284(v_179_002_txt)  //INSPKEY
			ARRAY TEXT:C222(v_179_002_atxt; 0)  //INSPKEY
			C_TEXT:C284(v_179_017_txt)  //ELEM_CREATEDATETIME
			ARRAY TEXT:C222(v_179_017_atxt; 0)  //ELEM_CREATEDATETIME
			C_TEXT:C284(v_179_018_txt)  //ELEM_MODTIME
			ARRAY TEXT:C222(v_179_018_atxt; 0)  //ELEM_MODTIME
			C_TEXT:C284(v_179_020_txt)  //ELEM_NOTES
			ARRAY TEXT:C222(v_179_020_atxt; 0)  //ELEM_NOTES
			C_TEXT:C284(v_179_023_txt)  //ELEM_DESC
			ARRAY TEXT:C222(v_179_023_atxt; 0)  //ELEM_DESC
			C_TEXT:C284(v_179_024_txt)  //ELEM_CREATEUSERKEY
			ARRAY TEXT:C222(v_179_024_atxt; 0)  //ELEM_CREATEUSERKEY
			C_TEXT:C284(v_179_025_txt)  //ELEM_MODUSERKEY
			ARRAY TEXT:C222(v_179_025_atxt; 0)  //ELEM_MODUSERKEY
			C_TEXT:C284(v_179_026_txt)  //ELEM_DOCREFKEY
			ARRAY TEXT:C222(v_179_026_atxt; 0)  //ELEM_DOCREFKEY
			C_REAL:C285(v_179_007_r)  //ELEM_QUANTITY
			ARRAY REAL:C219(v_179_007_ar; 0)  //ELEM_QUANTITY
			C_REAL:C285(v_179_008_r)  //ELEM_SCALE_FACTOR
			ARRAY REAL:C219(v_179_008_ar; 0)  //ELEM_SCALE_FACTOR
			C_REAL:C285(v_179_009_r)  //ELEM_PCTSTATE1
			ARRAY REAL:C219(v_179_009_ar; 0)  //ELEM_PCTSTATE1
			C_REAL:C285(v_179_010_r)  //ELEM_PCTSTATE2
			ARRAY REAL:C219(v_179_010_ar; 0)  //ELEM_PCTSTATE2
			C_REAL:C285(v_179_011_r)  //ELEM_PCTSTATE3
			ARRAY REAL:C219(v_179_011_ar; 0)  //ELEM_PCTSTATE3
			C_REAL:C285(v_179_012_r)  //ELEM_PCTSTATE4
			ARRAY REAL:C219(v_179_012_ar; 0)  //ELEM_PCTSTATE4
			C_REAL:C285(v_179_013_r)  //ELEM_QTYSTATE1
			ARRAY REAL:C219(v_179_013_ar; 0)  //ELEM_QTYSTATE1
			C_REAL:C285(v_179_014_r)  //ELEM_QTYSTATE2
			ARRAY REAL:C219(v_179_014_ar; 0)  //ELEM_QTYSTATE2
			C_REAL:C285(v_179_015_r)  //ELEM_QTYSTATE3
			ARRAY REAL:C219(v_179_015_ar; 0)  //ELEM_QTYSTATE3
			C_REAL:C285(v_179_016_r)  //ELEM_QTYSTATE4
			ARRAY REAL:C219(v_179_016_ar; 0)  //ELEM_QTYSTATE4
			C_LONGINT:C283(v_179_003_L)  //ELEM_KEY
			ARRAY LONGINT:C221(v_179_003_aL; 0)  //ELEM_KEY
			C_LONGINT:C283(v_179_004_L)  //ELEM_PARENT_KEY
			ARRAY LONGINT:C221(v_179_004_aL; 0)  //ELEM_PARENT_KEY
			C_LONGINT:C283(v_179_005_L)  //ENVKEY
			ARRAY LONGINT:C221(v_179_005_aL; 0)  //ENVKEY
			C_LONGINT:C283(v_179_006_L)  //STRUNITKEY
			ARRAY LONGINT:C221(v_179_006_aL; 0)  //STRUNITKEY
			C_LONGINT:C283(v_179_019_L)  //ELEM_GRANDPARENT_KEY
			ARRAY LONGINT:C221(v_179_019_aL; 0)  //ELEM_GRANDPARENT_KEY
			C_LONGINT:C283(v_179_021_L)  //INSPID
			ARRAY LONGINT:C221(v_179_021_aL; 0)  //INSPID
			C_LONGINT:C283(v_179_022_L)  //ELEMID
			ARRAY LONGINT:C221(v_179_022_aL; 0)  //ELEMID
			C_LONGINT:C283(v_179_027_L)  //ELEM_PARENTID
			ARRAY LONGINT:C221(v_179_027_aL; 0)  //ELEM_PARENTID
			C_LONGINT:C283(v_179_028_L)  //ELEM_GRANDPARENTID
			ARRAY LONGINT:C221(v_179_028_aL; 0)  //ELEM_GRANDPARENTID
			C_BOOLEAN:C305(v_179_029_b)  //ELEM_QorP
			ARRAY BOOLEAN:C223(v_179_029_ab; 0)  //ELEM_QorP
		: ($1=180)  //PON_ELEM_COSTS
			C_TEXT:C284(v_180_006_txt)  //PON_ELEM_COSTS_UUIDKey_s
			ARRAY TEXT:C222(v_180_006_atxt; 0)  //PON_ELEM_COSTS_UUIDKey_s
			C_TEXT:C284(v_180_003_txt)  //ELEM_ACTION
			ARRAY TEXT:C222(v_180_003_atxt; 0)  //ELEM_ACTION
			C_REAL:C285(v_180_004_r)  //ELEM_COST
			ARRAY REAL:C219(v_180_004_ar; 0)  //ELEM_COST
			C_LONGINT:C283(v_180_001_L)  //ELEM_KEY
			ARRAY LONGINT:C221(v_180_001_aL; 0)  //ELEM_KEY
			C_LONGINT:C283(v_180_002_L)  //ENVKEY
			ARRAY LONGINT:C221(v_180_002_aL; 0)  //ENVKEY
			C_LONGINT:C283(v_180_005_L)  //COSTID_L
			ARRAY LONGINT:C221(v_180_005_aL; 0)  //COSTID_L
		: ($1=181)  //NTI_TunnelInfo
			C_TEXT:C284(v_181_072_txt)  //NTI_TunnelInfo_UUIDKey_s
			ARRAY TEXT:C222(v_181_072_atxt; 0)  //NTI_TunnelInfo_UUIDKey_s
			C_TEXT:C284(v_181_002_txt)  //NTI_CreatedBy_s
			ARRAY TEXT:C222(v_181_002_atxt; 0)  //NTI_CreatedBy_s
			C_TEXT:C284(v_181_003_txt)  //NTI_ModifiedBy_s
			ARRAY TEXT:C222(v_181_003_atxt; 0)  //NTI_ModifiedBy_s
			C_TEXT:C284(v_181_004_txt)  //NTI_CreatedTimeStamp_s
			ARRAY TEXT:C222(v_181_004_atxt; 0)  //NTI_CreatedTimeStamp_s
			C_TEXT:C284(v_181_005_txt)  //NTI_ModifiedTimeStamp_s
			ARRAY TEXT:C222(v_181_005_atxt; 0)  //NTI_ModifiedTimeStamp_s
			C_TEXT:C284(v_181_006_txt)  //NTI_i1_s
			ARRAY TEXT:C222(v_181_006_atxt; 0)  //NTI_i1_s
			C_TEXT:C284(v_181_007_txt)  //NTI_i2_s
			ARRAY TEXT:C222(v_181_007_atxt; 0)  //NTI_i2_s
			C_TEXT:C284(v_181_011_txt)  //NTI_i6_s
			ARRAY TEXT:C222(v_181_011_atxt; 0)  //NTI_i6_s
			C_TEXT:C284(v_181_012_txt)  //NTI_i7_s
			ARRAY TEXT:C222(v_181_012_atxt; 0)  //NTI_i7_s
			C_TEXT:C284(v_181_013_txt)  //NTI_i8_s
			ARRAY TEXT:C222(v_181_013_atxt; 0)  //NTI_i8_s
			C_TEXT:C284(v_181_015_txt)  //NTI_i10_s
			ARRAY TEXT:C222(v_181_015_atxt; 0)  //NTI_i10_s
			C_TEXT:C284(v_181_016_txt)  //NTI_i11_s
			ARRAY TEXT:C222(v_181_016_atxt; 0)  //NTI_i11_s
			C_TEXT:C284(v_181_020_txt)  //NTI_i15_s
			ARRAY TEXT:C222(v_181_020_atxt; 0)  //NTI_i15_s
			C_TEXT:C284(v_181_022_txt)  //NTI_i17_s
			ARRAY TEXT:C222(v_181_022_atxt; 0)  //NTI_i17_s
			C_TEXT:C284(v_181_032_txt)  //NTI_C1_s
			ARRAY TEXT:C222(v_181_032_atxt; 0)  //NTI_C1_s
			C_TEXT:C284(v_181_033_txt)  //NTI_C2_s
			ARRAY TEXT:C222(v_181_033_atxt; 0)  //NTI_C2_s
			C_TEXT:C284(v_181_034_txt)  //NTI_C3_s
			ARRAY TEXT:C222(v_181_034_atxt; 0)  //NTI_C3_s
			C_TEXT:C284(v_181_035_txt)  //NTI_C4_s
			ARRAY TEXT:C222(v_181_035_atxt; 0)  //NTI_C4_s
			C_TEXT:C284(v_181_036_txt)  //NTI_C5_s
			ARRAY TEXT:C222(v_181_036_atxt; 0)  //NTI_C5_s
			C_TEXT:C284(v_181_037_txt)  //NTI_C6_s
			ARRAY TEXT:C222(v_181_037_atxt; 0)  //NTI_C6_s
			C_TEXT:C284(v_181_039_txt)  //NTI_C8_s
			ARRAY TEXT:C222(v_181_039_atxt; 0)  //NTI_C8_s
			C_TEXT:C284(v_181_045_txt)  //NTI_N1_s
			ARRAY TEXT:C222(v_181_045_atxt; 0)  //NTI_N1_s
			C_TEXT:C284(v_181_047_txt)  //NTI_N3_s
			ARRAY TEXT:C222(v_181_047_atxt; 0)  //NTI_N3_s
			C_TEXT:C284(v_181_052_txt)  //NTI_S5_s
			ARRAY TEXT:C222(v_181_052_atxt; 0)  //NTI_S5_s
			C_TEXT:C284(v_181_056_txt)  //NTI_D4_s
			ARRAY TEXT:C222(v_181_056_atxt; 0)  //NTI_D4_s
			C_TEXT:C284(v_181_057_txt)  //NTI_D5_s
			ARRAY TEXT:C222(v_181_057_atxt; 0)  //NTI_D5_s
			C_TEXT:C284(v_181_058_txt)  //NTI_D6_s
			ARRAY TEXT:C222(v_181_058_atxt; 0)  //NTI_D6_s
			C_TEXT:C284(v_181_059_txt)  //NTI_L1_s
			ARRAY TEXT:C222(v_181_059_atxt; 0)  //NTI_L1_s
			C_TEXT:C284(v_181_062_txt)  //NTI_L4_s
			ARRAY TEXT:C222(v_181_062_atxt; 0)  //NTI_L4_s
			C_TEXT:C284(v_181_068_txt)  //NTI_L10_s
			ARRAY TEXT:C222(v_181_068_atxt; 0)  //NTI_L10_s
			C_TEXT:C284(v_181_069_txt)  //NTI_L11_s
			ARRAY TEXT:C222(v_181_069_atxt; 0)  //NTI_L11_s
			C_TEXT:C284(v_181_070_txt)  //NTI_L12_s
			ARRAY TEXT:C222(v_181_070_atxt; 0)  //NTI_L12_s
			C_TEXT:C284(v_181_071_txt)  //NTI_TownName_s
			ARRAY TEXT:C222(v_181_071_atxt; 0)  //NTI_TownName_s
			C_TEXT:C284(v_181_073_txt)  //NTI_InspResp
			ARRAY TEXT:C222(v_181_073_atxt; 0)  //NTI_InspResp
			C_TEXT:C284(v_181_074_txt)  //NTI_Segment_s
			ARRAY TEXT:C222(v_181_074_atxt; 0)  //NTI_Segment_s
			C_TEXT:C284(v_181_075_txt)  //NTI_Contracts_s
			ARRAY TEXT:C222(v_181_075_atxt; 0)  //NTI_Contracts_s
			C_REAL:C285(v_181_017_r)  //NTI_i12_r
			ARRAY REAL:C219(v_181_017_ar; 0)  //NTI_i12_r
			C_REAL:C285(v_181_018_r)  //NTI_i13_r
			ARRAY REAL:C219(v_181_018_ar; 0)  //NTI_i13_r
			C_REAL:C285(v_181_019_r)  //NTI_i14_r
			ARRAY REAL:C219(v_181_019_ar; 0)  //NTI_i14_r
			C_REAL:C285(v_181_041_r)  //NTI_G2_r
			ARRAY REAL:C219(v_181_041_ar; 0)  //NTI_G2_r
			C_REAL:C285(v_181_042_r)  //NTI_G3_r
			ARRAY REAL:C219(v_181_042_ar; 0)  //NTI_G3_r
			C_REAL:C285(v_181_043_r)  //NTI_G4_r
			ARRAY REAL:C219(v_181_043_ar; 0)  //NTI_G4_r
			C_REAL:C285(v_181_044_r)  //NTI_G5_r
			ARRAY REAL:C219(v_181_044_ar; 0)  //NTI_G5_r
			C_REAL:C285(v_181_046_r)  //NTI_N2_r
			ARRAY REAL:C219(v_181_046_ar; 0)  //NTI_N2_r
			C_REAL:C285(v_181_060_r)  //NTI_L2_r
			ARRAY REAL:C219(v_181_060_ar; 0)  //NTI_L2_r
			C_REAL:C285(v_181_061_r)  //NTI_L3_r
			ARRAY REAL:C219(v_181_061_ar; 0)  //NTI_L3_r
			C_LONGINT:C283(v_181_008_L)  //NTI_i3_L
			ARRAY LONGINT:C221(v_181_008_aL; 0)  //NTI_i3_L
			C_LONGINT:C283(v_181_009_L)  //NTI_i4_L
			ARRAY LONGINT:C221(v_181_009_aL; 0)  //NTI_i4_L
			C_LONGINT:C283(v_181_010_L)  //NTI_i5_L
			ARRAY LONGINT:C221(v_181_010_aL; 0)  //NTI_i5_L
			C_LONGINT:C283(v_181_014_L)  //NTI_i9_L
			ARRAY LONGINT:C221(v_181_014_aL; 0)  //NTI_i9_L
			C_LONGINT:C283(v_181_021_L)  //NTI_i16_L
			ARRAY LONGINT:C221(v_181_021_aL; 0)  //NTI_i16_L
			C_LONGINT:C283(v_181_023_L)  //NTI_i18_L
			ARRAY LONGINT:C221(v_181_023_aL; 0)  //NTI_i18_L
			C_LONGINT:C283(v_181_024_L)  //NTI_A1_L
			ARRAY LONGINT:C221(v_181_024_aL; 0)  //NTI_A1_L
			C_LONGINT:C283(v_181_025_L)  //NTI_A2_L
			ARRAY LONGINT:C221(v_181_025_aL; 0)  //NTI_A2_L
			C_LONGINT:C283(v_181_026_L)  //NTI_A3_L
			ARRAY LONGINT:C221(v_181_026_aL; 0)  //NTI_A3_L
			C_LONGINT:C283(v_181_027_L)  //NTI_A4_L
			ARRAY LONGINT:C221(v_181_027_aL; 0)  //NTI_A4_L
			C_LONGINT:C283(v_181_028_L)  //NTI_A5_L
			ARRAY LONGINT:C221(v_181_028_aL; 0)  //NTI_A5_L
			C_LONGINT:C283(v_181_029_L)  //NTI_A6_L
			ARRAY LONGINT:C221(v_181_029_aL; 0)  //NTI_A6_L
			C_LONGINT:C283(v_181_030_L)  //NTI_A7_L
			ARRAY LONGINT:C221(v_181_030_aL; 0)  //NTI_A7_L
			C_LONGINT:C283(v_181_031_L)  //NTI_A8_L
			ARRAY LONGINT:C221(v_181_031_aL; 0)  //NTI_A8_L
			C_LONGINT:C283(v_181_038_L)  //NTI_C7_L
			ARRAY LONGINT:C221(v_181_038_aL; 0)  //NTI_C7_L
			C_LONGINT:C283(v_181_040_L)  //NTI_G1_L
			ARRAY LONGINT:C221(v_181_040_aL; 0)  //NTI_G1_L
			C_LONGINT:C283(v_181_048_L)  //NTI_S1_L
			ARRAY LONGINT:C221(v_181_048_aL; 0)  //NTI_S1_L
			C_LONGINT:C283(v_181_049_L)  //NTI_S2_L
			ARRAY LONGINT:C221(v_181_049_aL; 0)  //NTI_S2_L
			C_LONGINT:C283(v_181_050_L)  //NTI_S3_L
			ARRAY LONGINT:C221(v_181_050_aL; 0)  //NTI_S3_L
			C_LONGINT:C283(v_181_051_L)  //NTI_S4_L
			ARRAY LONGINT:C221(v_181_051_aL; 0)  //NTI_S4_L
			C_LONGINT:C283(v_181_055_L)  //NTI_D3_L
			ARRAY LONGINT:C221(v_181_055_aL; 0)  //NTI_D3_L
			C_LONGINT:C283(v_181_063_L)  //NTI_L5_L
			ARRAY LONGINT:C221(v_181_063_aL; 0)  //NTI_L5_L
			C_LONGINT:C283(v_181_064_L)  //NTI_L6_L
			ARRAY LONGINT:C221(v_181_064_aL; 0)  //NTI_L6_L
			C_LONGINT:C283(v_181_065_L)  //NTI_L7_L
			ARRAY LONGINT:C221(v_181_065_aL; 0)  //NTI_L7_L
			C_LONGINT:C283(v_181_066_L)  //NTI_L8_L
			ARRAY LONGINT:C221(v_181_066_aL; 0)  //NTI_L8_L
			C_LONGINT:C283(v_181_067_L)  //NTI_L9_L
			ARRAY LONGINT:C221(v_181_067_aL; 0)  //NTI_L9_L
			C_LONGINT:C283(v_181_078_L)  //NTI_Overhead_Interval_L
			ARRAY LONGINT:C221(v_181_078_aL; 0)  //NTI_Overhead_Interval_L
			C_LONGINT:C283(v_181_081_L)  //NTI_SpecMemb_Interval_L
			ARRAY LONGINT:C221(v_181_081_aL; 0)  //NTI_SpecMemb_Interval_L
			C_DATE:C307(v_181_053_d)  //NTI_D1_d
			ARRAY DATE:C224(v_181_053_ad; 0)  //NTI_D1_d
			C_DATE:C307(v_181_054_d)  //NTI_D2_d
			ARRAY DATE:C224(v_181_054_ad; 0)  //NTI_D2_d
			C_DATE:C307(v_181_076_d)  //NTI_Overhead_Actual_d
			ARRAY DATE:C224(v_181_076_ad; 0)  //NTI_Overhead_Actual_d
			C_DATE:C307(v_181_077_d)  //NTI_Overhead_Target_d
			ARRAY DATE:C224(v_181_077_ad; 0)  //NTI_Overhead_Target_d
			C_DATE:C307(v_181_079_d)  //NTI_SpecMemb_Actual_d
			ARRAY DATE:C224(v_181_079_ad; 0)  //NTI_SpecMemb_Actual_d
			C_DATE:C307(v_181_080_d)  //NTI_SpecMemb_Target_d
			ARRAY DATE:C224(v_181_080_ad; 0)  //NTI_SpecMemb_Target_d
			C_DATE:C307(v_181_082_d)  //NTI_Damage_d
			ARRAY DATE:C224(v_181_082_ad; 0)  //NTI_Damage_d
			C_DATE:C307(v_181_083_d)  //NTI_Damage_Actual_d
			ARRAY DATE:C224(v_181_083_ad; 0)  //NTI_Damage_Actual_d
			C_BOOLEAN:C305(v_181_001_b)  //NTI_Future_b
			ARRAY BOOLEAN:C223(v_181_001_ab; 0)  //NTI_Future_b
		: ($1=182)  //NTI_ELEM_DEFS
			C_TEXT:C284(v_182_020_txt)  //NTI_ELEM_DEFS_UUIDKey_s
			ARRAY TEXT:C222(v_182_020_atxt; 0)  //NTI_ELEM_DEFS_UUIDKey_s
			C_TEXT:C284(v_182_001_txt)  //ELEM_CATEGORY
			ARRAY TEXT:C222(v_182_001_atxt; 0)  //ELEM_CATEGORY
			C_TEXT:C284(v_182_002_txt)  //CREATEDATETIME
			ARRAY TEXT:C222(v_182_002_atxt; 0)  //CREATEDATETIME
			C_TEXT:C284(v_182_003_txt)  //CREATEUSER
			ARRAY TEXT:C222(v_182_003_atxt; 0)  //CREATEUSER
			C_TEXT:C284(v_182_005_txt)  //ELEM_LONGNAME
			ARRAY TEXT:C222(v_182_005_atxt; 0)  //ELEM_LONGNAME
			C_TEXT:C284(v_182_006_txt)  //ELEM_MAT_KEY
			ARRAY TEXT:C222(v_182_006_atxt; 0)  //ELEM_MAT_KEY
			C_TEXT:C284(v_182_007_txt)  //MODEL
			ARRAY TEXT:C222(v_182_007_atxt; 0)  //MODEL
			C_TEXT:C284(v_182_008_txt)  //MODDATETIME
			ARRAY TEXT:C222(v_182_008_atxt; 0)  //MODDATETIME
			C_TEXT:C284(v_182_009_txt)  //MODUSER
			ARRAY TEXT:C222(v_182_009_atxt; 0)  //MODUSER
			C_TEXT:C284(v_182_010_txt)  //DEFECTFLAG
			ARRAY TEXT:C222(v_182_010_atxt; 0)  //DEFECTFLAG
			C_TEXT:C284(v_182_011_txt)  //ELEM_SHORTNAME
			ARRAY TEXT:C222(v_182_011_atxt; 0)  //ELEM_SHORTNAME
			C_TEXT:C284(v_182_012_txt)  //ELEM_SCALEUNIT
			ARRAY TEXT:C222(v_182_012_atxt; 0)  //ELEM_SCALEUNIT
			C_TEXT:C284(v_182_015_txt)  //TYPE
			ARRAY TEXT:C222(v_182_015_atxt; 0)  //TYPE
			C_TEXT:C284(v_182_016_txt)  //REPORTED
			ARRAY TEXT:C222(v_182_016_atxt; 0)  //REPORTED
			C_TEXT:C284(v_182_017_txt)  //NOTES
			ARRAY TEXT:C222(v_182_017_atxt; 0)  //NOTES
			C_TEXT:C284(v_182_018_txt)  //ELEM_BINONLY
			ARRAY TEXT:C222(v_182_018_atxt; 0)  //ELEM_BINONLY
			C_TEXT:C284(v_182_019_txt)  //ELEM_TIN_ONLY
			ARRAY TEXT:C222(v_182_019_atxt; 0)  //ELEM_TIN_ONLY
			C_TEXT:C284(v_182_021_txt)  //ELEM_PROTECT_SYS
			ARRAY TEXT:C222(v_182_021_atxt; 0)  //ELEM_PROTECT_SYS
			C_REAL:C285(v_182_014_r)  //ELEM_REL_WEIGHT
			ARRAY REAL:C219(v_182_014_ar; 0)  //ELEM_REL_WEIGHT
			C_LONGINT:C283(v_182_004_L)  //ELEM_KEY
			ARRAY LONGINT:C221(v_182_004_aL; 0)  //ELEM_KEY
			C_LONGINT:C283(v_182_013_L)  //ELEM_SUBSET_KEY
			ARRAY LONGINT:C221(v_182_013_aL; 0)  //ELEM_SUBSET_KEY
		: ($1=183)  //NTI_ELEM_BIN_INSP
			C_BLOB:C604(v_183_009_blb)  //ELEM_NOTES
			ARRAY BLOB:C1222(v_183_009_ablb; 0)  //ELEM_NOTES
			C_TEXT:C284(v_183_023_txt)  //NTI_ELEM_BIN_INSP_UUIDKey_s
			ARRAY TEXT:C222(v_183_023_atxt; 0)  //NTI_ELEM_BIN_INSP_UUIDKey_s
			C_TEXT:C284(v_183_004_txt)  //ELEM_CREATEDATETIME
			ARRAY TEXT:C222(v_183_004_atxt; 0)  //ELEM_CREATEDATETIME
			C_TEXT:C284(v_183_005_txt)  //ELEM_CREATEUSER
			ARRAY TEXT:C222(v_183_005_atxt; 0)  //ELEM_CREATEUSER
			C_TEXT:C284(v_183_006_txt)  //ELEM_DESC
			ARRAY TEXT:C222(v_183_006_atxt; 0)  //ELEM_DESC
			C_TEXT:C284(v_183_010_txt)  //ELEM_MODDATETIME
			ARRAY TEXT:C222(v_183_010_atxt; 0)  //ELEM_MODDATETIME
			C_TEXT:C284(v_183_011_txt)  //ELEM_MODUSER
			ARRAY TEXT:C222(v_183_011_atxt; 0)  //ELEM_MODUSER
			C_REAL:C285(v_183_012_r)  //ELEM_PCTSTATE1
			ARRAY REAL:C219(v_183_012_ar; 0)  //ELEM_PCTSTATE1
			C_REAL:C285(v_183_013_r)  //ELEM_PCTSTATE2
			ARRAY REAL:C219(v_183_013_ar; 0)  //ELEM_PCTSTATE2
			C_REAL:C285(v_183_014_r)  //ELEM_PCTSTATE3
			ARRAY REAL:C219(v_183_014_ar; 0)  //ELEM_PCTSTATE3
			C_REAL:C285(v_183_015_r)  //ELEM_PCTSTATE4
			ARRAY REAL:C219(v_183_015_ar; 0)  //ELEM_PCTSTATE4
			C_REAL:C285(v_183_017_r)  //ELEM_QTYSTATE1
			ARRAY REAL:C219(v_183_017_ar; 0)  //ELEM_QTYSTATE1
			C_REAL:C285(v_183_018_r)  //ELEM_QTYSTATE2
			ARRAY REAL:C219(v_183_018_ar; 0)  //ELEM_QTYSTATE2
			C_REAL:C285(v_183_019_r)  //ELEM_QTYSTATE3
			ARRAY REAL:C219(v_183_019_ar; 0)  //ELEM_QTYSTATE3
			C_REAL:C285(v_183_020_r)  //ELEM_QTYSTATE4
			ARRAY REAL:C219(v_183_020_ar; 0)  //ELEM_QTYSTATE4
			C_REAL:C285(v_183_021_r)  //ELEM_QUANTITY
			ARRAY REAL:C219(v_183_021_ar; 0)  //ELEM_QUANTITY
			C_REAL:C285(v_183_022_r)  //ELEM_SCALE_FACTOR
			ARRAY REAL:C219(v_183_022_ar; 0)  //ELEM_SCALE_FACTOR
			C_LONGINT:C283(v_183_024_L)  //ELEM_RATING
			ARRAY INTEGER:C220(v_183_024_ai; 0)  //ELEM_RATING
			C_LONGINT:C283(v_183_001_L)  //INSPID
			ARRAY LONGINT:C221(v_183_001_aL; 0)  //INSPID
			C_LONGINT:C283(v_183_002_L)  //ELEMID
			ARRAY LONGINT:C221(v_183_002_aL; 0)  //ELEMID
			C_LONGINT:C283(v_183_003_L)  //ELEM_KEY
			ARRAY LONGINT:C221(v_183_003_aL; 0)  //ELEM_KEY
			C_LONGINT:C283(v_183_007_L)  //ELEM_PARENT_KEY
			ARRAY LONGINT:C221(v_183_007_aL; 0)  //ELEM_PARENT_KEY
			C_LONGINT:C283(v_183_008_L)  //ELEM_PARENT_ID
			ARRAY LONGINT:C221(v_183_008_aL; 0)  //ELEM_PARENT_ID
			C_LONGINT:C283(v_183_025_L)  //ELEM_GRANDPARENT_KEY
			ARRAY LONGINT:C221(v_183_025_aL; 0)  //ELEM_GRANDPARENT_KEY
			C_LONGINT:C283(v_183_026_L)  //ELEM_GRANDPARENT_ID
			ARRAY LONGINT:C221(v_183_026_aL; 0)  //ELEM_GRANDPARENT_ID
			C_BOOLEAN:C305(v_183_016_b)  //ELEM_QorP
			ARRAY BOOLEAN:C223(v_183_016_ab; 0)  //ELEM_QorP
		: ($1=184)  //TIN_Inspections
			C_BLOB:C604(v_184_023_blb)  //Comments
			ARRAY BLOB:C1222(v_184_023_ablb; 0)  //Comments
			C_TEXT:C284(v_184_025_txt)  //TIN_Inspections_UUIDKey_s
			ARRAY TEXT:C222(v_184_025_atxt; 0)  //TIN_Inspections_UUIDKey_s
			C_TEXT:C284(v_184_001_txt)  //NTI_i1_S
			ARRAY TEXT:C222(v_184_001_atxt; 0)  //NTI_i1_S
			C_TEXT:C284(v_184_007_txt)  //CreatedDateTimeStamp
			ARRAY TEXT:C222(v_184_007_atxt; 0)  //CreatedDateTimeStamp
			C_TEXT:C284(v_184_008_txt)  //CreatedBy
			ARRAY TEXT:C222(v_184_008_atxt; 0)  //CreatedBy
			C_TEXT:C284(v_184_009_txt)  //ModifiedTimeStamp
			ARRAY TEXT:C222(v_184_009_atxt; 0)  //ModifiedTimeStamp
			C_TEXT:C284(v_184_010_txt)  //ModifiedBy
			ARRAY TEXT:C222(v_184_010_atxt; 0)  //ModifiedBy
			C_TEXT:C284(v_184_013_txt)  //Agency
			ARRAY TEXT:C222(v_184_013_atxt; 0)  //Agency
			C_TEXT:C284(v_184_016_txt)  //InspApproveComments
			ARRAY TEXT:C222(v_184_016_atxt; 0)  //InspApproveComments
			C_TEXT:C284(v_184_017_txt)  //InspReviewComments
			ARRAY TEXT:C222(v_184_017_atxt; 0)  //InspReviewComments
			C_TEXT:C284(v_184_020_txt)  //RelatedBINInsp
			ARRAY TEXT:C222(v_184_020_atxt; 0)  //RelatedBINInsp
			C_TEXT:C284(v_184_021_txt)  //InspType
			ARRAY TEXT:C222(v_184_021_atxt; 0)  //InspType
			C_TEXT:C284(v_184_028_txt)  //SigninPlaceAtTunnel_s
			ARRAY TEXT:C222(v_184_028_atxt; 0)  //SigninPlaceAtTunnel_s
			C_TEXT:C284(v_184_029_txt)  //SigninPlaceAdvance_s
			ARRAY TEXT:C222(v_184_029_atxt; 0)  //SigninPlaceAdvance_s
			C_TEXT:C284(v_184_033_txt)  //RatingReportRoofGirder_s
			ARRAY TEXT:C222(v_184_033_atxt; 0)  //RatingReportRoofGirder_s
			C_TEXT:C284(v_184_034_txt)  //RatingReportInvertSlab_s
			ARRAY TEXT:C222(v_184_034_atxt; 0)  //RatingReportInvertSlab_s
			C_TEXT:C284(v_184_035_txt)  //RatingReportInvertGirder_s
			ARRAY TEXT:C222(v_184_035_atxt; 0)  //RatingReportInvertGirder_s
			C_TEXT:C284(v_184_045_txt)  //WeightPostingSignAtTunnel_s
			ARRAY TEXT:C222(v_184_045_atxt; 0)  //WeightPostingSignAtTunnel_s
			C_TEXT:C284(v_184_046_txt)  //WeightPostingSignAdvance_s
			ARRAY TEXT:C222(v_184_046_atxt; 0)  //WeightPostingSignAdvance_s
			C_TEXT:C284(v_184_047_txt)  //DamageBy_s
			ARRAY TEXT:C222(v_184_047_atxt; 0)  //DamageBy_s
			C_TEXT:C284(v_184_049_txt)  //Weather
			ARRAY TEXT:C222(v_184_049_atxt; 0)  //Weather
			C_REAL:C285(v_184_037_r)  //WeightPostingActualH_r
			ARRAY REAL:C219(v_184_037_ar; 0)  //WeightPostingActualH_r
			C_REAL:C285(v_184_038_r)  //WeightPostingActual3_r
			ARRAY REAL:C219(v_184_038_ar; 0)  //WeightPostingActual3_r
			C_REAL:C285(v_184_039_r)  //WeightPostingActual3S2_r
			ARRAY REAL:C219(v_184_039_ar; 0)  //WeightPostingActual3S2_r
			C_REAL:C285(v_184_040_r)  //WeightPostingActualSingle_r
			ARRAY REAL:C219(v_184_040_ar; 0)  //WeightPostingActualSingle_r
			C_REAL:C285(v_184_041_r)  //WeightPostingRecH_r
			ARRAY REAL:C219(v_184_041_ar; 0)  //WeightPostingRecH_r
			C_REAL:C285(v_184_042_r)  //WeightPostingRec3_r
			ARRAY REAL:C219(v_184_042_ar; 0)  //WeightPostingRec3_r
			C_REAL:C285(v_184_043_r)  //WeightPostingRec3S2_r
			ARRAY REAL:C219(v_184_043_ar; 0)  //WeightPostingRec3S2_r
			C_REAL:C285(v_184_044_r)  //WeightPostingRecSingle_r
			ARRAY REAL:C219(v_184_044_ar; 0)  //WeightPostingRecSingle_r
			C_REAL:C285(v_184_050_r)  //Temperature
			ARRAY REAL:C219(v_184_050_ar; 0)  //Temperature
			C_LONGINT:C283(v_184_005_L)  //InspReview
			ARRAY INTEGER:C220(v_184_005_ai; 0)  //InspReview
			C_LONGINT:C283(v_184_006_L)  //InspApproval
			ARRAY INTEGER:C220(v_184_006_ai; 0)  //InspApproval
			C_LONGINT:C283(v_184_011_L)  //TeamLeader
			ARRAY INTEGER:C220(v_184_011_ai; 0)  //TeamLeader
			C_LONGINT:C283(v_184_012_L)  //DistrInspEng
			ARRAY INTEGER:C220(v_184_012_ai; 0)  //DistrInspEng
			C_LONGINT:C283(v_184_022_L)  //DistrTnlInspEng
			ARRAY INTEGER:C220(v_184_022_ai; 0)  //DistrTnlInspEng
			C_LONGINT:C283(v_184_002_L)  //InspectionID
			ARRAY LONGINT:C221(v_184_002_aL; 0)  //InspectionID
			C_LONGINT:C283(v_184_014_L)  //ProjManager
			ARRAY LONGINT:C221(v_184_014_aL; 0)  //ProjManager
			C_LONGINT:C283(v_184_026_L)  //ActualFieldMeasure_L
			ARRAY LONGINT:C221(v_184_026_aL; 0)  //ActualFieldMeasure_L
			C_LONGINT:C283(v_184_027_L)  //PostedClearance_L
			ARRAY LONGINT:C221(v_184_027_aL; 0)  //PostedClearance_L
			C_DATE:C307(v_184_003_d)  //InspDate
			ARRAY DATE:C224(v_184_003_ad; 0)  //InspDate
			C_DATE:C307(v_184_015_d)  //InspCompleteDate
			ARRAY DATE:C224(v_184_015_ad; 0)  //InspCompleteDate
			C_DATE:C307(v_184_018_d)  //InspApproveDate
			ARRAY DATE:C224(v_184_018_ad; 0)  //InspApproveDate
			C_DATE:C307(v_184_019_d)  //InspReviewDate
			ARRAY DATE:C224(v_184_019_ad; 0)  //InspReviewDate
			C_DATE:C307(v_184_031_d)  //RatingReport_d
			ARRAY DATE:C224(v_184_031_ad; 0)  //RatingReport_d
			C_DATE:C307(v_184_032_d)  //RatingReportDateofInsp_d
			ARRAY DATE:C224(v_184_032_ad; 0)  //RatingReportDateofInsp_d
			C_DATE:C307(v_184_048_d)  //DamageDate_d
			ARRAY DATE:C224(v_184_048_ad; 0)  //DamageDate_d
			C_DATE:C307(v_184_051_d)  //InspReportComplete_d
			ARRAY DATE:C224(v_184_051_ad; 0)  //InspReportComplete_d
			C_BOOLEAN:C305(v_184_004_b)  //Complete
			ARRAY BOOLEAN:C223(v_184_004_ab; 0)  //Complete
			C_BOOLEAN:C305(v_184_024_b)  //Future
			ARRAY BOOLEAN:C223(v_184_024_ab; 0)  //Future
			C_BOOLEAN:C305(v_184_030_b)  //RatingReportYN_B
			ARRAY BOOLEAN:C223(v_184_030_ab; 0)  //RatingReportYN_B
			C_BOOLEAN:C305(v_184_036_b)  //WeightPostingNA_B
			ARRAY BOOLEAN:C223(v_184_036_ab; 0)  //WeightPostingNA_B
		: ($1=185)  //NTI_ELEM_TIN_INSP
			C_BLOB:C604(v_185_009_blb)  //ELEM_NOTES
			ARRAY BLOB:C1222(v_185_009_ablb; 0)  //ELEM_NOTES
			C_TEXT:C284(v_185_023_txt)  //NTI_ELEM_TIN_INSP_UUIDKey_s
			ARRAY TEXT:C222(v_185_023_atxt; 0)  //NTI_ELEM_TIN_INSP_UUIDKey_s
			C_TEXT:C284(v_185_004_txt)  //ELEM_CREATEDATETIME
			ARRAY TEXT:C222(v_185_004_atxt; 0)  //ELEM_CREATEDATETIME
			C_TEXT:C284(v_185_005_txt)  //ELEM_CREATEUSER
			ARRAY TEXT:C222(v_185_005_atxt; 0)  //ELEM_CREATEUSER
			C_TEXT:C284(v_185_006_txt)  //ELEM_DESC
			ARRAY TEXT:C222(v_185_006_atxt; 0)  //ELEM_DESC
			C_TEXT:C284(v_185_010_txt)  //ELEM_MODDATETIME
			ARRAY TEXT:C222(v_185_010_atxt; 0)  //ELEM_MODDATETIME
			C_TEXT:C284(v_185_011_txt)  //ELEM_MODUSER
			ARRAY TEXT:C222(v_185_011_atxt; 0)  //ELEM_MODUSER
			C_REAL:C285(v_185_012_r)  //ELEM_PCTSTATE1
			ARRAY REAL:C219(v_185_012_ar; 0)  //ELEM_PCTSTATE1
			C_REAL:C285(v_185_013_r)  //ELEM_PCTSTATE2
			ARRAY REAL:C219(v_185_013_ar; 0)  //ELEM_PCTSTATE2
			C_REAL:C285(v_185_014_r)  //ELEM_PCTSTATE3
			ARRAY REAL:C219(v_185_014_ar; 0)  //ELEM_PCTSTATE3
			C_REAL:C285(v_185_015_r)  //ELEM_PCTSTATE4
			ARRAY REAL:C219(v_185_015_ar; 0)  //ELEM_PCTSTATE4
			C_REAL:C285(v_185_017_r)  //ELEM_QTYSTATE1
			ARRAY REAL:C219(v_185_017_ar; 0)  //ELEM_QTYSTATE1
			C_REAL:C285(v_185_018_r)  //ELEM_QTYSTATE2
			ARRAY REAL:C219(v_185_018_ar; 0)  //ELEM_QTYSTATE2
			C_REAL:C285(v_185_019_r)  //ELEM_QTYSTATE3
			ARRAY REAL:C219(v_185_019_ar; 0)  //ELEM_QTYSTATE3
			C_REAL:C285(v_185_020_r)  //ELEM_QTYSTATE4
			ARRAY REAL:C219(v_185_020_ar; 0)  //ELEM_QTYSTATE4
			C_REAL:C285(v_185_021_r)  //ELEM_QUANTITY
			ARRAY REAL:C219(v_185_021_ar; 0)  //ELEM_QUANTITY
			C_REAL:C285(v_185_022_r)  //ELEM_SCALE_FACTOR
			ARRAY REAL:C219(v_185_022_ar; 0)  //ELEM_SCALE_FACTOR
			C_LONGINT:C283(v_185_024_L)  //ELEM_RATING
			ARRAY INTEGER:C220(v_185_024_ai; 0)  //ELEM_RATING
			C_LONGINT:C283(v_185_001_L)  //InspectionID
			ARRAY LONGINT:C221(v_185_001_aL; 0)  //InspectionID
			C_LONGINT:C283(v_185_002_L)  //ELEMID
			ARRAY LONGINT:C221(v_185_002_aL; 0)  //ELEMID
			C_LONGINT:C283(v_185_003_L)  //ELEM_KEY
			ARRAY LONGINT:C221(v_185_003_aL; 0)  //ELEM_KEY
			C_LONGINT:C283(v_185_007_L)  //ELEM_PARENT_KEY
			ARRAY LONGINT:C221(v_185_007_aL; 0)  //ELEM_PARENT_KEY
			C_LONGINT:C283(v_185_008_L)  //ELEM_PARENT_ID
			ARRAY LONGINT:C221(v_185_008_aL; 0)  //ELEM_PARENT_ID
			C_LONGINT:C283(v_185_025_L)  //ELEM_GRANDPARENT_KEY
			ARRAY LONGINT:C221(v_185_025_aL; 0)  //ELEM_GRANDPARENT_KEY
			C_LONGINT:C283(v_185_026_L)  //ELEM_GRANDPARENT_ID
			ARRAY LONGINT:C221(v_185_026_aL; 0)  //ELEM_GRANDPARENT_ID
			C_BOOLEAN:C305(v_185_016_b)  //ELEM_QorP
			ARRAY BOOLEAN:C223(v_185_016_ab; 0)  //ELEM_QorP
		: ($1=186)  //TIN_Insp_Images
			C_TEXT:C284(v_186_008_txt)  //TIN_Insp_Images_UUIDKey_s
			ARRAY TEXT:C222(v_186_008_atxt; 0)  //TIN_Insp_Images_UUIDKey_s
			C_TEXT:C284(v_186_004_txt)  //ImageDescr
			ARRAY TEXT:C222(v_186_004_atxt; 0)  //ImageDescr
			C_TEXT:C284(v_186_005_txt)  //ImageType
			ARRAY TEXT:C222(v_186_005_atxt; 0)  //ImageType
			C_LONGINT:C283(v_186_006_L)  //SequenceNum
			ARRAY INTEGER:C220(v_186_006_ai; 0)  //SequenceNum
			C_LONGINT:C283(v_186_001_L)  //InspectionID
			ARRAY LONGINT:C221(v_186_001_aL; 0)  //InspectionID
			C_LONGINT:C283(v_186_002_L)  //ImageID
			ARRAY LONGINT:C221(v_186_002_aL; 0)  //ImageID
			C_BOOLEAN:C305(v_186_007_b)  //Portrait
			ARRAY BOOLEAN:C223(v_186_007_ab; 0)  //Portrait
			C_PICTURE:C286(v_186_003_p)  //ImagePic
			ARRAY PICTURE:C279(v_186_003_ap; 0)  //ImagePic
		: ($1=187)  //TIN_Insp_TmMembers
			C_TEXT:C284(v_187_003_txt)  //TIN_Insp_TmMembers_UUIDKey_s
			ARRAY TEXT:C222(v_187_003_atxt; 0)  //TIN_Insp_TmMembers_UUIDKey_s
			C_LONGINT:C283(v_187_002_L)  //PersonID
			ARRAY INTEGER:C220(v_187_002_ai; 0)  //PersonID
			C_LONGINT:C283(v_187_001_L)  //InspectionID
			ARRAY LONGINT:C221(v_187_001_aL; 0)  //InspectionID
		: ($1=188)  //TIN_Insp_Comments
			C_BLOB:C604(v_188_009_blb)  //Comment_blb
			ARRAY BLOB:C1222(v_188_009_ablb; 0)  //Comment_blb
			C_TEXT:C284(v_188_002_txt)  //TIN_INSP_CommentsUUIDKey_S
			ARRAY TEXT:C222(v_188_002_atxt; 0)  //TIN_INSP_CommentsUUIDKey_S
			C_TEXT:C284(v_188_004_txt)  //ISOCreatedDate_s
			ARRAY TEXT:C222(v_188_004_atxt; 0)  //ISOCreatedDate_s
			C_TEXT:C284(v_188_005_txt)  //CreatedBy_s
			ARRAY TEXT:C222(v_188_005_atxt; 0)  //CreatedBy_s
			C_TEXT:C284(v_188_006_txt)  //ISOModifiedDate_s
			ARRAY TEXT:C222(v_188_006_atxt; 0)  //ISOModifiedDate_s
			C_TEXT:C284(v_188_007_txt)  //ModifiedBy_s
			ARRAY TEXT:C222(v_188_007_atxt; 0)  //ModifiedBy_s
			C_TEXT:C284(v_188_008_txt)  //CommentType_s
			ARRAY TEXT:C222(v_188_008_atxt; 0)  //CommentType_s
			C_LONGINT:C283(v_188_001_L)  //InspectionID
			ARRAY LONGINT:C221(v_188_001_aL; 0)  //InspectionID
			C_LONGINT:C283(v_188_003_L)  //TIN_InspCommentID_L
			ARRAY LONGINT:C221(v_188_003_aL; 0)  //TIN_InspCommentID_L
		: ($1=189)  //NTI_TunnelRatings
			C_TEXT:C284(v_189_001_txt)  //NTI_TunnelRatings_UUID_s
			ARRAY TEXT:C222(v_189_001_atxt; 0)  //NTI_TunnelRatings_UUID_s
			C_TEXT:C284(v_189_002_txt)  //NTI_i1_s
			ARRAY TEXT:C222(v_189_002_atxt; 0)  //NTI_i1_s
			C_TEXT:C284(v_189_004_txt)  //RatingReportRoofGirder_s
			ARRAY TEXT:C222(v_189_004_atxt; 0)  //RatingReportRoofGirder_s
			C_TEXT:C284(v_189_005_txt)  //RatingReportInvertSlab_s
			ARRAY TEXT:C222(v_189_005_atxt; 0)  //RatingReportInvertSlab_s
			C_TEXT:C284(v_189_006_txt)  //RatingReportInvertGirder_s
			ARRAY TEXT:C222(v_189_006_atxt; 0)  //RatingReportInvertGirder_s
			C_TEXT:C284(v_189_007_txt)  //ISO_CreatedDate_s
			ARRAY TEXT:C222(v_189_007_atxt; 0)  //ISO_CreatedDate_s
			C_TEXT:C284(v_189_008_txt)  //ISO_ModifedDate_s
			ARRAY TEXT:C222(v_189_008_atxt; 0)  //ISO_ModifedDate_s
			C_TEXT:C284(v_189_009_txt)  //CreatedBy_s
			ARRAY TEXT:C222(v_189_009_atxt; 0)  //CreatedBy_s
			C_TEXT:C284(v_189_010_txt)  //ModifiedBy_s
			ARRAY TEXT:C222(v_189_010_atxt; 0)  //ModifiedBy_s
			C_LONGINT:C283(v_189_011_L)  //RatingID_L
			ARRAY LONGINT:C221(v_189_011_aL; 0)  //RatingID_L
			C_DATE:C307(v_189_003_d)  //RatingReport_d
			ARRAY DATE:C224(v_189_003_ad; 0)  //RatingReport_d
			C_DATE:C307(v_189_012_d)  //Inspection_d
			ARRAY DATE:C224(v_189_012_ad; 0)  //Inspection_d
		: ($1=190)  //RatingVehicleTypes
			C_TEXT:C284(v_190_004_txt)  //RatingVehicleTypes_UUIDKey_s
			ARRAY TEXT:C222(v_190_004_atxt; 0)  //RatingVehicleTypes_UUIDKey_s
			C_TEXT:C284(v_190_002_txt)  //VehicleName_s
			ARRAY TEXT:C222(v_190_002_atxt; 0)  //VehicleName_s
			C_LONGINT:C283(v_190_001_L)  //VehicleID
			ARRAY LONGINT:C221(v_190_001_aL; 0)  //VehicleID
			C_LONGINT:C283(v_190_008_L)  //Sequence
			ARRAY LONGINT:C221(v_190_008_aL; 0)  //Sequence
			C_LONGINT:C283(v_190_009_L)  //LegacyInvFieldNo_L
			ARRAY LONGINT:C221(v_190_009_aL; 0)  //LegacyInvFieldNo_L
			C_LONGINT:C283(v_190_010_L)  //LegacyOprFieldNo_L
			ARRAY LONGINT:C221(v_190_010_aL; 0)  //LegacyOprFieldNo_L
			C_BOOLEAN:C305(v_190_003_b)  //PostingVehicle_b
			ARRAY BOOLEAN:C223(v_190_003_ab; 0)  //PostingVehicle_b
			C_BOOLEAN:C305(v_190_005_b)  //InvRating
			ARRAY BOOLEAN:C223(v_190_005_ab; 0)  //InvRating
			C_BOOLEAN:C305(v_190_006_b)  //OperRating
			ARRAY BOOLEAN:C223(v_190_006_ab; 0)  //OperRating
			C_BOOLEAN:C305(v_190_007_b)  //Legacy
			ARRAY BOOLEAN:C223(v_190_007_ab; 0)  //Legacy
		: ($1=191)  //RatingReportVehicles
			C_TEXT:C284(v_191_006_txt)  //RatingReportVehicles_UUIDKey_s
			ARRAY TEXT:C222(v_191_006_atxt; 0)  //RatingReportVehicles_UUIDKey_s
			C_REAL:C285(v_191_003_r)  //InvRating
			ARRAY REAL:C219(v_191_003_ar; 0)  //InvRating
			C_REAL:C285(v_191_004_r)  //OperRating
			ARRAY REAL:C219(v_191_004_ar; 0)  //OperRating
			C_REAL:C285(v_191_005_r)  //Posting
			ARRAY REAL:C219(v_191_005_ar; 0)  //Posting
			C_LONGINT:C283(v_191_001_L)  //RatingVehicleID
			ARRAY LONGINT:C221(v_191_001_aL; 0)  //RatingVehicleID
			C_LONGINT:C283(v_191_002_L)  //RatingID
			ARRAY LONGINT:C221(v_191_002_aL; 0)  //RatingID
			C_LONGINT:C283(v_191_007_L)  //VehicleID
			ARRAY LONGINT:C221(v_191_007_aL; 0)  //VehicleID
		: ($1=192)  //BridgeStairs
			C_TEXT:C284(v_192_011_txt)  //BridgeStairs_UUIDKey_s
			ARRAY TEXT:C222(v_192_011_atxt; 0)  //BridgeStairs_UUIDKey_s
			C_TEXT:C284(v_192_002_txt)  //BIN
			ARRAY TEXT:C222(v_192_002_atxt; 0)  //BIN
			C_TEXT:C284(v_192_003_txt)  //Material_s
			ARRAY TEXT:C222(v_192_003_atxt; 0)  //Material_s
			C_TEXT:C284(v_192_004_txt)  //OwnerCode_s
			ARRAY TEXT:C222(v_192_004_atxt; 0)  //OwnerCode_s
			C_TEXT:C284(v_192_005_txt)  //StairsTo_txt
			ARRAY TEXT:C222(v_192_005_atxt; 0)  //StairsTo_txt
			C_TEXT:C284(v_192_006_txt)  //Description_txt
			ARRAY TEXT:C222(v_192_006_atxt; 0)  //Description_txt
			C_TEXT:C284(v_192_007_txt)  //CreatedBy
			ARRAY TEXT:C222(v_192_007_atxt; 0)  //CreatedBy
			C_TEXT:C284(v_192_008_txt)  //CreatedStamp
			ARRAY TEXT:C222(v_192_008_atxt; 0)  //CreatedStamp
			C_TEXT:C284(v_192_009_txt)  //ModifiedBy
			ARRAY TEXT:C222(v_192_009_atxt; 0)  //ModifiedBy
			C_TEXT:C284(v_192_010_txt)  //ModifiedStamp
			ARRAY TEXT:C222(v_192_010_atxt; 0)  //ModifiedStamp
			C_LONGINT:C283(v_192_001_L)  //BridgeStairsID
			ARRAY LONGINT:C221(v_192_001_aL; 0)  //BridgeStairsID
			
	End case 
	
End if 