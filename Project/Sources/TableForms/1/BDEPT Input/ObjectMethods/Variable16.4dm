If (False:C215)
	//Object Method: [Bridge MHD NBIS].BDEPT Input.RefBINSelector_atxt 
	//Change values based on the selection from this array
	// Modified by: costasmanousakis-(Designer)-(4/30/08 15:59:39)
	Mods_2008_CM_5403  //call the SIA_Feature_OM to calculate the Item 7 , 6A variables and pulldowns
	// Modified by: costasmanousakis-(Designer)-(6/3/10 17:00:32)
	Mods_2010_06
	//Added additional fields from the existing records
	// Modified by: costasmanousakis-(Designer)-(8/27/10 17:01:33)
	Mods_2010_08
	//  `Added Item 8 Owner code
	// Modified by: costasmanousakis-(Designer)-(10/20/10 12:13:28)
	Mods_2010_10
	//  `Added [Bridge MHD NBIS]LegacyOwner
	// Modified by: costasmanousakis-(Designer)-(6/20/11 10:43:47)
	Mods_2011_06
	//  `Added RR info, Agency Bridge no
	// Modified by: costasmanousakis-(Designer)-(12/14/11 09:51:19)
	Mods_2011_12
	//  `Switched from aItem7 to RefBINSelector_atxt
	// Modified by: Costas Manousakis-(Designer)-(8/16/13 15:13:43)
	Mods_2013_08
	//  `added Townline
	// Modified by: Costas Manousakis-(Designer)-(5/29/18 11:38:04)
	Mods_2018_05
	//  `removed reference to vIt8OwnerDes
End if 
C_LONGINT:C283($Selector_L)
$Selector_L:=RefBINSelector_atxt
If ($Selector_L>0)
	[Bridge MHD NBIS:1]Bridge Key:2:=abrkey{$Selector_L}
	[Bridge MHD NBIS:1]Item5:59:=aItem5{$Selector_L}
	[Bridge MHD NBIS:1]Item6A:63:=aItem6{$Selector_L}
	[Bridge MHD NBIS:1]Item6B:64:=aItem6b{$Selector_L}
	[Bridge MHD NBIS:1]Item7:65:=aItem7{$Selector_L}
	[Bridge MHD NBIS:1]Item9:66:=aItem9{$Selector_L}
	[Bridge MHD NBIS:1]Item11:67:=aItem11{$Selector_L}
	[Bridge MHD NBIS:1]Item16A:68:=aItem16a{$Selector_L}
	[Bridge MHD NBIS:1]Item16B:69:=aItem16b{$Selector_L}
	[Bridge MHD NBIS:1]Item16C:109:=aItem16c{$Selector_L}
	[Bridge MHD NBIS:1]Item17A:70:=aItem17a{$Selector_L}
	[Bridge MHD NBIS:1]Item17B:71:=aItem17b{$Selector_L}
	[Bridge MHD NBIS:1]Item17C:136:=aItem17c{$Selector_L}
	[Bridge MHD NBIS:1]Item98A:72:=aItem98a{$Selector_L}
	[Bridge MHD NBIS:1]Item98B:73:=aItem98b{$Selector_L}
	[Bridge MHD NBIS:1]Item99:74:=aItem99{$Selector_L}
	[Bridge MHD NBIS:1]InspResp:173:=aInspResp{$Selector_L}
	[Bridge MHD NBIS:1]Item42:85:=Item42_as{$Selector_L}
	[Bridge MHD NBIS:1]Item29:88:=Item29_aL{$Selector_L}
	[Bridge MHD NBIS:1]Item30:89:=Item30_ai{$Selector_L}
	[Bridge MHD NBIS:1]Item109:90:=Item109_ai{$Selector_L}
	[Bridge MHD NBIS:1]Item19:91:=Item19_ai{$Selector_L}
	[Bridge MHD NBIS:1]Item38:113:=Item38_as{$Selector_L}
	[Bridge MHD NBIS:1]Item104:119:=Item104_ab{$Selector_L}
	[Bridge MHD NBIS:1]Item26:120:=Item26_as{$Selector_L}
	[Bridge MHD NBIS:1]Item100:121:=Item100_as{$Selector_L}
	[Bridge MHD NBIS:1]Item101:122:=Item101_as{$Selector_L}
	[Bridge MHD NBIS:1]Item102:123:=Item102_as{$Selector_L}
	[Bridge MHD NBIS:1]Item 105:201:=Item105_as{$Selector_L}
	[Bridge MHD NBIS:1]Item110:125:=Item110_ab{$Selector_L}
	[Bridge MHD NBIS:1]Item20:126:=Item20_as{$Selector_L}
	[Bridge MHD NBIS:1]Item21:127:=Item21_as{$Selector_L}
	[Bridge MHD NBIS:1]Item22:128:=Item22_as{$Selector_L}
	[Bridge MHD NBIS:1]Bridge Name:29:=BridgeName_as{$Selector_L}
	[Bridge MHD NBIS:1]ParallelBIN:27:=ParBIN_as{$Selector_L}
	[Bridge MHD NBIS:1]Item8 Owner:208:=Item8Owner_as{$Selector_L}
	[Bridge MHD NBIS:1]LegacyOwner:226:=Item8LegacyOwner_as{$Selector_L}
	[Bridge MHD NBIS:1]RRBranch:210:=RRBranch_as{$Selector_L}
	[Bridge MHD NBIS:1]RRBridgeNo:211:=RRBridgeNo_ar{$Selector_L}
	[Bridge MHD NBIS:1]AgencyBrNo:209:=AgencyBrNo_as{$Selector_L}
	[Bridge MHD NBIS:1]OnTwnLine:177:=aTownLineb{$Selector_L}
	
	aIt8OwnerDes_:=Find in array:C230(aIt8OwnerCode_; [Bridge MHD NBIS:1]Item8 Owner:208)
	//vIt8OwnerDes:=aIt8OwnerDes_{aIt8OwnerDes_}
	[Bridge MHD NBIS:1]Item8:206:=Change string:C234([Bridge MHD NBIS:1]Item8:206; aIt8OwnerCode_{aIt8OwnerDes_}; 10)
	
	aInspRdes_:=Find in array:C230(aInspRcod_; [Bridge MHD NBIS:1]InspResp:173)
	PushChange(1; ->[Bridge MHD NBIS:1]Bridge Key:2)
	PushChange(1; ->[Bridge MHD NBIS:1]Item5:59)
	PushChange(1; ->[Bridge MHD NBIS:1]Item6A:63)
	PushChange(1; ->[Bridge MHD NBIS:1]Item6B:64)
	PushChange(1; ->[Bridge MHD NBIS:1]Item7:65)
	PushChange(1; ->[Bridge MHD NBIS:1]Item9:66)
	PushChange(1; ->[Bridge MHD NBIS:1]Item11:67)
	PushChange(1; ->[Bridge MHD NBIS:1]Item16A:68)
	PushChange(1; ->[Bridge MHD NBIS:1]Item16B:69)
	PushChange(1; ->[Bridge MHD NBIS:1]Item16C:109)
	PushChange(1; ->[Bridge MHD NBIS:1]Item17A:70)
	PushChange(1; ->[Bridge MHD NBIS:1]Item17B:71)
	PushChange(1; ->[Bridge MHD NBIS:1]Item17C:136)
	PushChange(1; ->[Bridge MHD NBIS:1]Item98A:72)
	PushChange(1; ->[Bridge MHD NBIS:1]Item98B:73)
	PushChange(1; ->[Bridge MHD NBIS:1]Item99:74)
	PushChange(1; ->[Bridge MHD NBIS:1]InspResp:173)
	PushChange(1; ->[Bridge MHD NBIS:1]Item42:85)
	PushChange(1; ->[Bridge MHD NBIS:1]Item29:88)
	PushChange(1; ->[Bridge MHD NBIS:1]Item30:89)
	PushChange(1; ->[Bridge MHD NBIS:1]Item109:90)
	PushChange(1; ->[Bridge MHD NBIS:1]Item19:91)
	PushChange(1; ->[Bridge MHD NBIS:1]Item38:113)
	PushChange(1; ->[Bridge MHD NBIS:1]Item104:119)
	PushChange(1; ->[Bridge MHD NBIS:1]Item26:120)
	PushChange(1; ->[Bridge MHD NBIS:1]Item100:121)
	PushChange(1; ->[Bridge MHD NBIS:1]Item101:122)
	PushChange(1; ->[Bridge MHD NBIS:1]Item102:123)
	PushChange(1; ->[Bridge MHD NBIS:1]Item 105:201)
	PushChange(1; ->[Bridge MHD NBIS:1]Item110:125)
	PushChange(1; ->[Bridge MHD NBIS:1]Item20:126)
	PushChange(1; ->[Bridge MHD NBIS:1]Item21:127)
	PushChange(1; ->[Bridge MHD NBIS:1]Item22:128)
	PushChange(1; ->[Bridge MHD NBIS:1]Bridge Name:29)
	PushChange(1; ->[Bridge MHD NBIS:1]ParallelBIN:27)
	PushChange(1; ->[Bridge MHD NBIS:1]Item8 Owner:208)
	PushChange(1; ->[Bridge MHD NBIS:1]Item8:206)
	PushChange(1; ->[Bridge MHD NBIS:1]LegacyOwner:226)
	PushChange(1; ->[Bridge MHD NBIS:1]RRBranch:210)
	PushChange(1; ->[Bridge MHD NBIS:1]RRBridgeNo:211)
	PushChange(1; ->[Bridge MHD NBIS:1]AgencyBrNo:209)
	PushChange(1; ->[Bridge MHD NBIS:1]OnTwnLine:177)
	
	SIA_Feature_OM(->[Bridge MHD NBIS:1]Item7:65; ->BINa7FDescr_; ->BINv7FDescr; ->BINa7FCodes_; ->BINv7RteNum; ->BINv7Suffix; ->BINv7Descr; On Load:K2:1)
	SIA_Feature_OM(->[Bridge MHD NBIS:1]Item6A:63; ->BINaFeatDescr_; ->BINvFeatDescr; ->BINaFeatCodes_; ->BINvRteNum; ->BINvsuffix; ->BINv6Descr; On Load:K2:1)
End if 