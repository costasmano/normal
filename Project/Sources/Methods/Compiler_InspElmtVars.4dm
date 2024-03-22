//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/26/10, 10:13:18
	// ----------------------------------------------------
	// Method: COMPILER_InspElmtVars
	// Description
	//  `Method containing var defs for all Element variables used in Inspection forms which are based on the
	//  ` Element number
	//  `  See method ut_GenerateInspVarCompiler for generation of the code - verify that all var categories are correct in this method
	//
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_07
	// Modified by: costasmanousakis-(Designer)-(12/23/10 15:42:51)
	Mods_2010_12
	//Updated 
	// Modified by: costasmanousakis-(Designer)-(1/27/11 14:02:59)
	Mods_2011_01
	//` Upodated for RR elements
	// Modified by: Costas Manousakis-(Designer)-(12/7/12 12:17:16)
	Mods_2012_12
	//  `Updated for new method of selecting inspection type.
	// Modified by: Costas Manousakis-(Designer)-(2/21/14 17:36:11)
	Mods_2014_02
	//  `added Commuter rail load ratings
	// Modified by: Costas Manousakis-(Designer)-(4/25/14 11:31:38)
	Mods_2014_04
	//  `added Bus load and transit load ratings
	// Modified by: Costas Manousakis-(Designer)-(10/28/14 16:51:32)
	Mods_2014_10
	//  `Increased size of Prev Rating for Eval forms to include deficiency and prio; 
	//  ` added new vars for Curr Rating+def+prio for Eval Forms
	// Modified by: Costas Manousakis-(Designer)-(3/6/17 17:09:53)
	Mods_2017_03
	//  ` added all vHSP46_1-_22 vars
End if 
// Element Ratings
C_TEXT:C284(vR10; vR11; vR12; vR13; vR20; vR21; vR22; vR30; vR31; vR32; vR33; vR41; vR42)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vR43; vR44; vR100; vR101; vR102; vR103; vR104; vR105; vR106; vR107; vR108; vR109; vR110)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vR111; vR112; vR113; vR114; vR115; vR116; vR200; vR201; vR202; vR203; vR204; vR205; vR206)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vR207; vR208; vR209; vR210; vR211; vR212; vR213; vR214; vR215; vR216; vR217; vR218; vR219)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vR220; vR221; vR222; vR223; vR224; vR225; vR226; vR227; vR228; vR300; vR301; vR302; vR303)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vR304; vR305; vR306; vR307; vR308; vR309; vR310; vR311; vR312; vR313; vR314; vR315; vR316)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vR317; vR318; vR319; vR320; vR321; vR322; vR323; vR324; vR325; vR326; vR327; vR328; vR329)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vR330; vR331; vR400; vR401; vR402; vR403; vR404; vR405; vR406; vR407; vR408; vR409; vR410)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vR411; vR412; vR413; vR414; vR415; vR416; vR500; vR501; vR502; vR503; vR504; vR505; vR506)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vR507; vR508; vR509; vR510; vR511; vR512; vR513; vR514; vR515; vR516; vR517; vR2100; vR2101)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vR2102; vR2103; vR2104; vR2105; vR2106; vR2107; vR2108; vR2109; vR2110; vR2200; vR2201; vR2202; vR2203)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vR2204; vR2205; vR2206; vR2207; vR2208; vR2209; vR2210; vR2211; vR2212; vR2213; vR2214; vR2215; vR2216)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vR2217; vR2218; vR2225; vR2226; vR2227; vR2228; vR2229; vR2230; vR2231; vR2232; vR2233; vR2240; vR2241)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vR2242; vR2243; vR2244; vR2245; vR2246; vR2247; vR2248; vR2249; vR2260; vR2261; vR2262; vR2263; vR2264)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vR2265; vR2300; vR2301; vR2302; vR2303; vR2304; vR2305; vR2306; vR2307; vR2308; vR2309; vR2310; vR2313)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vR2314; vR2315; vR2316; vR2317; vR2318; vR2319; vR2320; vR2321; vR2322; vR2323; vR2324; vR2325; vR2400)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vR2401; vR2402; vR2403; vR2404; vR2405; vR2406; vR2407; vR2408; vR2500; vR2501; vR2502; vR2503; vR2504)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vR2505; vR2506; vR2507; vR2550; vR2551; vR2552; vR2553; vR2554; vR2555; vR2556; vR2557; vR2558; vR2559)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vR2560; vR2561)  // Command Replaced was o_C_STRING length was 1

// Previous Insp Rating + deficiency for Inspection Evaluation form
C_TEXT:C284(vPR10; vPR11; vPR12; vPR13; vPR20; vPR21; vPR22; vPR30; vPR31; vPR32; vPR33; vPR41; vPR42)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vPR43; vPR44; vPR100; vPR101; vPR102; vPR103; vPR104; vPR105; vPR106; vPR107; vPR108; vPR109; vPR110)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vPR111; vPR112; vPR113; vPR114; vPR115; vPR116; vPR200; vPR201; vPR202; vPR203; vPR204; vPR205; vPR206)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vPR207; vPR208; vPR209; vPR210; vPR211; vPR212; vPR213; vPR214; vPR215; vPR216; vPR217; vPR218; vPR219)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vPR220; vPR221; vPR222; vPR223; vPR224; vPR225; vPR226; vPR227; vPR228; vPR300; vPR301; vPR302; vPR303)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vPR304; vPR305; vPR306; vPR307; vPR308; vPR309; vPR310; vPR311; vPR312; vPR313; vPR314; vPR315; vPR316)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vPR317; vPR318; vPR319; vPR320; vPR321; vPR322; vPR323; vPR324; vPR325; vPR326; vPR327; vPR328; vPR329)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vPR330; vPR331; vPR400; vPR401; vPR402; vPR403; vPR404; vPR405; vPR406; vPR407; vPR408; vPR409; vPR410)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vPR411; vPR412; vPR413; vPR414; vPR415; vPR416; vPR500; vPR501; vPR502; vPR503; vPR504; vPR505; vPR506)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vPR507; vPR508; vPR509; vPR510; vPR511; vPR512; vPR513; vPR514; vPR515; vPR516; vPR517; vPR2100; vPR2101)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vPR2102; vPR2103; vPR2104; vPR2105; vPR2106; vPR2107; vPR2108; vPR2109; vPR2110; vPR2200; vPR2201; vPR2202; vPR2203)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vPR2204; vPR2205; vPR2206; vPR2207; vPR2208; vPR2209; vPR2210; vPR2211; vPR2212; vPR2213; vPR2214; vPR2215; vPR2216)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vPR2217; vPR2218; vPR2225; vPR2226; vPR2227; vPR2228; vPR2229; vPR2230; vPR2231; vPR2232; vPR2233; vPR2240; vPR2241)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vPR2242; vPR2243; vPR2244; vPR2245; vPR2246; vPR2247; vPR2248; vPR2249; vPR2260; vPR2261; vPR2262; vPR2263; vPR2264)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vPR2265; vPR2300; vPR2301; vPR2302; vPR2303; vPR2304; vPR2305; vPR2306; vPR2307; vPR2308; vPR2309; vPR2310; vPR2313)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vPR2314; vPR2315; vPR2316; vPR2317; vPR2318; vPR2319; vPR2320; vPR2321; vPR2322; vPR2323; vPR2324; vPR2325; vPR2400)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vPR2401; vPR2402; vPR2403; vPR2404; vPR2405; vPR2406; vPR2407; vPR2408; vPR2500; vPR2501; vPR2502; vPR2503; vPR2504)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vPR2505; vPR2506; vPR2507; vPR2550; vPR2551; vPR2552; vPR2553; vPR2554; vPR2555; vPR2556; vPR2557; vPR2558; vPR2559)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vPR2560; vPR2561)  // Command Replaced was o_C_STRING length was 8

// Current Insp Rating + deficiency for Inspection Evaluation form
C_TEXT:C284(vCR10; vCR11; vCR12; vCR13; vCR20; vCR21; vCR22; vCR30; vCR31; vCR32; vCR33; vCR41; vCR42)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vCR43; vCR44; vCR100; vCR101; vCR102; vCR103; vCR104; vCR105; vCR106; vCR107; vCR108; vCR109; vCR110)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vCR111; vCR112; vCR113; vCR114; vCR115; vCR116; vCR200; vCR201; vCR202; vCR203; vCR204; vCR205; vCR206)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vCR207; vCR208; vCR209; vCR210; vCR211; vCR212; vCR213; vCR214; vCR215; vCR216; vCR217; vCR218; vCR219)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vCR220; vCR221; vCR222; vCR223; vCR224; vCR225; vCR226; vCR227; vCR228; vCR300; vCR301; vCR302; vCR303)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vCR304; vCR305; vCR306; vCR307; vCR308; vCR309; vCR310; vCR311; vCR312; vCR313; vCR314; vCR315; vCR316)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vCR317; vCR318; vCR319; vCR320; vCR321; vCR322; vCR323; vCR324; vCR325; vCR326; vCR327; vCR328; vCR329)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vCR330; vCR331; vCR400; vCR401; vCR402; vCR403; vCR404; vCR405; vCR406; vCR407; vCR408; vCR409; vCR410)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vCR411; vCR412; vCR413; vCR414; vCR415; vCR416; vCR500; vCR501; vCR502; vCR503; vCR504; vCR505; vCR506)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vCR507; vCR508; vCR509; vCR510; vCR511; vCR512; vCR513; vCR514; vCR515; vCR516; vCR517; vCR2100; vCR2101)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vCR2102; vCR2103; vCR2104; vCR2105; vCR2106; vCR2107; vCR2108; vCR2109; vCR2110; vCR2200; vCR2201; vCR2202; vCR2203)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vCR2204; vCR2205; vCR2206; vCR2207; vCR2208; vCR2209; vCR2210; vCR2211; vCR2212; vCR2213; vCR2214; vCR2215; vCR2216)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vCR2217; vCR2218; vCR2225; vCR2226; vCR2227; vCR2228; vCR2229; vCR2230; vCR2231; vCR2232; vCR2233; vCR2240; vCR2241)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vCR2242; vCR2243; vCR2244; vCR2245; vCR2246; vCR2247; vCR2248; vCR2249; vCR2260; vCR2261; vCR2262; vCR2263; vCR2264)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vCR2265; vCR2300; vCR2301; vCR2302; vCR2303; vCR2304; vCR2305; vCR2306; vCR2307; vCR2308; vCR2309; vCR2310; vCR2313)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vCR2314; vCR2315; vCR2316; vCR2317; vCR2318; vCR2319; vCR2320; vCR2321; vCR2322; vCR2323; vCR2324; vCR2325; vCR2400)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vCR2401; vCR2402; vCR2403; vCR2404; vCR2405; vCR2406; vCR2407; vCR2408; vCR2500; vCR2501; vCR2502; vCR2503; vCR2504)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vCR2505; vCR2506; vCR2507; vCR2550; vCR2551; vCR2552; vCR2553; vCR2554; vCR2555; vCR2556; vCR2557; vCR2558; vCR2559)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(vCR2560; vCR2561)  // Command Replaced was o_C_STRING length was 8

// Element UW Ratings
C_TEXT:C284(vRd10; vRd11; vRd12; vRd13; vRd20; vRd21; vRd22; vRd30; vRd31; vRd32; vRd33; vRd41; vRd42)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vRd43; vRd44; vRd100; vRd101; vRd102; vRd103; vRd104; vRd105; vRd106; vRd107; vRd108; vRd109; vRd110)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vRd111; vRd112; vRd113; vRd114; vRd115; vRd116; vRd200; vRd201; vRd202; vRd203; vRd204; vRd205; vRd206)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vRd207; vRd208; vRd209; vRd210; vRd211; vRd212; vRd213; vRd214; vRd215; vRd216; vRd217; vRd218; vRd219)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vRd220; vRd221; vRd222; vRd223; vRd224; vRd225; vRd226; vRd227; vRd228; vRd300; vRd301; vRd302; vRd303)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vRd304; vRd305; vRd306; vRd307; vRd308; vRd309; vRd310; vRd311; vRd312; vRd313; vRd314; vRd315; vRd316)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vRd317; vRd318; vRd319; vRd320; vRd321; vRd322; vRd323; vRd324; vRd325; vRd326; vRd327; vRd328; vRd329)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vRd330; vRd331; vRd400; vRd401; vRd402; vRd403; vRd404; vRd405; vRd406; vRd407; vRd408; vRd409; vRd410)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vRd411; vRd412; vRd413; vRd414; vRd415; vRd416; vRd500; vRd501; vRd502; vRd503; vRd504; vRd505; vRd506)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vRd507; vRd508; vRd509; vRd510; vRd511; vRd512; vRd513; vRd514; vRd515; vRd516; vRd517; vRd2100; vRd2101)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vRd2102; vRd2103; vRd2104; vRd2105; vRd2106; vRd2107; vRd2108; vRd2109; vRd2110; vRd2200; vRd2201; vRd2202; vRd2203)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vRd2204; vRd2205; vRd2206; vRd2207; vRd2208; vRd2209; vRd2210; vRd2211; vRd2212; vRd2213; vRd2214; vRd2215; vRd2216)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vRd2217; vRd2218; vRd2225; vRd2226; vRd2227; vRd2228; vRd2229; vRd2230; vRd2231; vRd2232; vRd2233; vRd2240; vRd2241)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vRd2242; vRd2243; vRd2244; vRd2245; vRd2246; vRd2247; vRd2248; vRd2249; vRd2260; vRd2261; vRd2262; vRd2263; vRd2264)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vRd2265; vRd2300; vRd2301; vRd2302; vRd2303; vRd2304; vRd2305; vRd2306; vRd2307; vRd2308; vRd2309; vRd2310; vRd2313)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vRd2314; vRd2315; vRd2316; vRd2317; vRd2318; vRd2319; vRd2320; vRd2321; vRd2322; vRd2323; vRd2324; vRd2325; vRd2400)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vRd2401; vRd2402; vRd2403; vRd2404; vRd2405; vRd2406; vRd2407; vRd2408; vRd2500; vRd2501; vRd2502; vRd2503; vRd2504)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vRd2505; vRd2506; vRd2507; vRd2550; vRd2551; vRd2552; vRd2553; vRd2554; vRd2555; vRd2556; vRd2557; vRd2558; vRd2559)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vRd2560; vRd2561)  // Command Replaced was o_C_STRING length was 1

// Element Deficiencies
C_TEXT:C284(vD10; vD11; vD12; vD13; vD20; vD21; vD22; vD30; vD31; vD32; vD33; vD41; vD42)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(vD43; vD44; vD100; vD101; vD102; vD103; vD104; vD105; vD106; vD107; vD108; vD109; vD110)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(vD111; vD112; vD113; vD114; vD115; vD116; vD200; vD201; vD202; vD203; vD204; vD205; vD206)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(vD207; vD208; vD209; vD210; vD211; vD212; vD213; vD214; vD215; vD216; vD217; vD218; vD219)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(vD220; vD221; vD222; vD223; vD224; vD225; vD226; vD227; vD228; vD300; vD301; vD302; vD303)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(vD304; vD305; vD306; vD307; vD308; vD309; vD310; vD311; vD312; vD313; vD314; vD315; vD316)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(vD317; vD318; vD319; vD320; vD321; vD322; vD323; vD324; vD325; vD326; vD327; vD328; vD329)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(vD330; vD331; vD400; vD401; vD402; vD403; vD404; vD405; vD406; vD407; vD408; vD409; vD410)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(vD411; vD412; vD413; vD414; vD415; vD416; vD500; vD501; vD502; vD503; vD504; vD505; vD506)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(vD507; vD508; vD509; vD510; vD511; vD512; vD513; vD514; vD515; vD516; vD517; vD2100; vD2101)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(vD2102; vD2103; vD2104; vD2105; vD2106; vD2107; vD2108; vD2109; vD2110; vD2200; vD2201; vD2202; vD2203)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(vD2204; vD2205; vD2206; vD2207; vD2208; vD2209; vD2210; vD2211; vD2212; vD2213; vD2214; vD2215; vD2216)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(vD2217; vD2218; vD2225; vD2226; vD2227; vD2228; vD2229; vD2230; vD2231; vD2232; vD2233; vD2240; vD2241)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(vD2242; vD2243; vD2244; vD2245; vD2246; vD2247; vD2248; vD2249; vD2260; vD2261; vD2262; vD2263; vD2264)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(vD2265; vD2300; vD2301; vD2302; vD2303; vD2304; vD2305; vD2306; vD2307; vD2308; vD2309; vD2310; vD2313)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(vD2314; vD2315; vD2316; vD2317; vD2318; vD2319; vD2320; vD2321; vD2322; vD2323; vD2324; vD2325; vD2400)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(vD2401; vD2402; vD2403; vD2404; vD2405; vD2406; vD2407; vD2408; vD2500; vD2501; vD2502; vD2503; vD2504)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(vD2505; vD2506; vD2507; vD2550; vD2551; vD2552; vD2553; vD2554; vD2555; vD2556; vD2557; vD2558; vD2559)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(vD2560; vD2561)  // Command Replaced was o_C_STRING length was 6

// Element Description
C_TEXT:C284(vT10; vT11; vT12; vT13; vT20; vT21; vT22; vT30; vT31; vT32; vT33; vT41; vT42)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vT43; vT44; vT100; vT101; vT102; vT103; vT104; vT105; vT106; vT107; vT108; vT109; vT110)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vT111; vT112; vT113; vT114; vT115; vT116; vT200; vT201; vT202; vT203; vT204; vT205; vT206)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vT207; vT208; vT209; vT210; vT211; vT212; vT213; vT214; vT215; vT216; vT217; vT218; vT219)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vT220; vT221; vT222; vT223; vT224; vT225; vT226; vT227; vT228; vT300; vT301; vT302; vT303)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vT304; vT305; vT306; vT307; vT308; vT309; vT310; vT311; vT312; vT313; vT314; vT315; vT316)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vT317; vT318; vT319; vT320; vT321; vT322; vT323; vT324; vT325; vT326; vT327; vT328; vT329)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vT330; vT331; vT400; vT401; vT402; vT403; vT404; vT405; vT406; vT407; vT408; vT409; vT410)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vT411; vT412; vT413; vT414; vT415; vT416; vT500; vT501; vT502; vT503; vT504; vT505; vT506)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vT507; vT508; vT509; vT510; vT511; vT512; vT513; vT514; vT515; vT516; vT517; vT2100; vT2101)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vT2102; vT2103; vT2104; vT2105; vT2106; vT2107; vT2108; vT2109; vT2110; vT2200; vT2201; vT2202; vT2203)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vT2204; vT2205; vT2206; vT2207; vT2208; vT2209; vT2210; vT2211; vT2212; vT2213; vT2214; vT2215; vT2216)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vT2217; vT2218; vT2225; vT2226; vT2227; vT2228; vT2229; vT2230; vT2231; vT2232; vT2233; vT2240; vT2241)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vT2242; vT2243; vT2244; vT2245; vT2246; vT2247; vT2248; vT2249; vT2260; vT2261; vT2262; vT2263; vT2264)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vT2265; vT2300; vT2301; vT2302; vT2303; vT2304; vT2305; vT2306; vT2307; vT2308; vT2309; vT2310; vT2313)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vT2314; vT2315; vT2316; vT2317; vT2318; vT2319; vT2320; vT2321; vT2322; vT2323; vT2324; vT2325; vT2400)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vT2401; vT2402; vT2403; vT2404; vT2405; vT2406; vT2407; vT2408; vT2500; vT2501; vT2502; vT2503; vT2504)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vT2505; vT2506; vT2507; vT2550; vT2551; vT2552; vT2553; vT2554; vT2555; vT2556; vT2557; vT2558; vT2559)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vT2560; vT2561)  // Command Replaced was o_C_STRING length was 50

// Item numbers  --  UW Spec memb page
C_TEXT:C284(vItem01; vItem02; vItem03; vItem04; vItem05; vItem06)

// Member Description
C_TEXT:C284(vMember01; vMember02; vMember03; vMember04; vMember05; vMember06)

// Item Comments
C_TEXT:C284(vRemarks01; vRemarks02; vRemarks03; vRemarks04; vRemarks05; vRemarks06)

// Prev Rating
C_TEXT:C284(vprevR01; vprevR02; vprevR03; vprevR04; vprevR05; vprevR06)  // Command Replaced was o_C_STRING length was 1

// Current Rating
C_TEXT:C284(vR01; vR02; vR03; vR04; vR05; vR06)  // Command Replaced was o_C_STRING length was 1

// Deficiency
C_TEXT:C284(vDEF01; vDEF02; vDEF03; vDEF04; vDEF05; vDEF06)  // Command Replaced was o_C_STRING length was 6

// Item letter -- Second Special Member page
C_TEXT:C284(vLetter1; vLetter2; vLetter3; vLetter4; vLetter5; vLetter6; vLetter7; vLetter8; vLetter9; vLetter10; vLetter11; vLetter12; vLetter13)
C_TEXT:C284(vLetter14; vLetter15; vLetter16; vLetter17; vLetter18; vLetter19; vLetter20; vLetter21; vLetter22)

// Member Description
C_TEXT:C284(vMember1; vMember2; vMember3; vMember4; vMember5; vMember6; vMember7; vMember8; vMember9; vMember10; vMember11; vMember12; vMember13)
C_TEXT:C284(vMember14; vMember15; vMember16; vMember17; vMember18; vMember19; vMember20; vMember21; vMember22)

// Item Comments
C_TEXT:C284(vRemarks1; vRemarks2; vRemarks3; vRemarks4; vRemarks5; vRemarks6; vRemarks7; vRemarks8; vRemarks9; vRemarks10; vRemarks11; vRemarks12; vRemarks13)
C_TEXT:C284(vRemarks14; vRemarks15; vRemarks16; vRemarks17; vRemarks18; vRemarks19; vRemarks20; vRemarks21; vRemarks22)

// Prev Rating
C_TEXT:C284(vprevR1; vprevR2; vprevR3; vprevR4; vprevR5; vprevR6; vprevR7; vprevR8; vprevR9; vprevR10; vprevR11; vprevR12; vprevR13)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vprevR14; vprevR15; vprevR16; vprevR17; vprevR18; vprevR19; vprevR20; vprevR21; vprevR22)  // Command Replaced was o_C_STRING length was 1

// Current Rating
C_TEXT:C284(vR1; vR2; vR3; vR4; vR5; vR6; vR7; vR8; vR9; vR10; vR11; vR12; vR13)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vR14; vR15; vR16; vR17; vR18; vR19; vR20; vR21; vR22)  // Command Replaced was o_C_STRING length was 1

// Deficiency
C_TEXT:C284(vDEF1; vDEF2; vDEF3; vDEF4; vDEF5; vDEF6; vDEF7; vDEF8; vDEF9; vDEF10; vDEF11; vDEF12; vDEF13)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(vDEF14; vDEF15; vDEF16; vDEF17; vDEF18; vDEF19; vDEF20; vDEF21; vDEF22)  // Command Replaced was o_C_STRING length was 6

// Crack condition
C_TEXT:C284(vCrack1; vCrack2; vCrack3; vCrack4; vCrack5; vCrack6; vCrack7; vCrack8; vCrack9; vCrack10; vCrack11; vCrack12; vCrack13)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vCrack14; vCrack15; vCrack16; vCrack17; vCrack18; vCrack19; vCrack20; vCrack21; vCrack22)  // Command Replaced was o_C_STRING length was 1

// Weld Condition
C_TEXT:C284(vWeld1; vWeld2; vWeld3; vWeld4; vWeld5; vWeld6; vWeld7; vWeld8; vWeld9; vWeld10; vWeld11; vWeld12; vWeld13)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vWeld14; vWeld15; vWeld16; vWeld17; vWeld18; vWeld19; vWeld20; vWeld21; vWeld22)  // Command Replaced was o_C_STRING length was 1

// Not Rated Text
C_TEXT:C284(vNotRated_1; vNotRated_2; vNotRated_3; vNotRated_4; vNotRated_5; vNotRated_6; vNotRated_7; vNotRated_8; vNotRated_9; vNotRated_10; vNotRated_11; vNotRated_12; vNotRated_13)  // Command Replaced was o_C_STRING length was 44
C_TEXT:C284(vNotRated_14; vNotRated_15; vNotRated_16; vNotRated_17; vNotRated_18; vNotRated_19; vNotRated_20; vNotRated_21; vNotRated_22)  // Command Replaced was o_C_STRING length was 44

// H20 Rating
C_TEXT:C284(vH20_1; vH20_2; vH20_3; vH20_4; vH20_5; vH20_6; vH20_7; vH20_8; vH20_9; vH20_10; vH20_11; vH20_12; vH20_13)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284(vH20_14; vH20_15; vH20_16; vH20_17; vH20_18; vH20_19; vH20_20; vH20_21; vH20_22)  // Command Replaced was o_C_STRING length was 3

// Typ3 Rating
C_TEXT:C284(vTyp3_1; vTyp3_2; vTyp3_3; vTyp3_4; vTyp3_5; vTyp3_6; vTyp3_7; vTyp3_8; vTyp3_9; vTyp3_10; vTyp3_11; vTyp3_12; vTyp3_13)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284(vTyp3_14; vTyp3_15; vTyp3_16; vTyp3_17; vTyp3_18; vTyp3_19; vTyp3_20; vTyp3_21; vTyp3_22)  // Command Replaced was o_C_STRING length was 3

// 3S2 Rating
C_TEXT:C284(v3S2_1; v3S2_2; v3S2_3; v3S2_4; v3S2_5; v3S2_6; v3S2_7; v3S2_8; v3S2_9; v3S2_10; v3S2_11; v3S2_12; v3S2_13)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284(v3S2_14; v3S2_15; v3S2_16; v3S2_17; v3S2_18; v3S2_19; v3S2_20; v3S2_21; v3S2_22)  // Command Replaced was o_C_STRING length was 3

//Commuter Rail Ratings
C_TEXT:C284(vR286K_1; vR286K_2; vR286K_3; vR286K_4; vR286K_5; vR286K_6; vR286K_7; vR286K_8; vR286K_9; vR286K_10; vR286K_11; vR286K_12; vR286K_13; vR286K_14; vR286K_15)
C_TEXT:C284(vR286K_16; vR286K_17; vR286K_18; vR286K_19; vR286K_20; vR286K_21; vR286K_22)

C_TEXT:C284(vR263K_1; vR263K_2; vR263K_3; vR263K_4; vR263K_5; vR263K_6; vR263K_7; vR263K_8; vR263K_9; vR263K_10; vR263K_11; vR263K_12; vR263K_13; vR263K_14; vR263K_15)
C_TEXT:C284(vR263K_16; vR263K_17; vR263K_18; vR263K_19; vR263K_20; vR263K_21; vR263K_22)

C_TEXT:C284(vR315K_1; vR315K_2; vR315K_3; vR315K_4; vR315K_5; vR315K_6; vR315K_7; vR315K_8; vR315K_9; vR315K_10; vR315K_11; vR315K_12; vR315K_13; vR315K_14; vR315K_15)
C_TEXT:C284(vR315K_16; vR315K_17; vR315K_18; vR315K_19; vR315K_20; vR315K_21; vR315K_22)

C_TEXT:C284(vF40_1; vF40_2; vF40_3; vF40_4; vF40_5; vF40_6; vF40_7; vF40_8; vF40_9; vF40_10; vF40_11; vF40_12; vF40_13; vF40_14; vF40_15)
C_TEXT:C284(vF40_16; vF40_17; vF40_18; vF40_19; vF40_20; vF40_21; vF40_22)

C_TEXT:C284(vE80_1; vE80_2; vE80_3; vE80_4; vE80_5; vE80_6; vE80_7; vE80_8; vE80_9; vE80_10; vE80_11; vE80_12; vE80_13; vE80_14; vE80_15)
C_TEXT:C284(vE80_16; vE80_17; vE80_18; vE80_19; vE80_20; vE80_21; vE80_22)

C_TEXT:C284(vHSP46_1; vHSP46_2; vHSP46_3; vHSP46_4; vHSP46_5; vHSP46_6; vHSP46_7; vHSP46_8; vHSP46_9; vHSP46_10; vHSP46_11; vHSP46_12; vHSP46_13; vHSP46_14; vHSP46_15)
C_TEXT:C284(vHSP46_16; vHSP46_17; vHSP46_18; vHSP46_19; vHSP46_20; vHSP46_21; vHSP46_22)

C_TEXT:C284(vNEOPLAN_1; vNEOPLAN_2; vNEOPLAN_3; vNEOPLAN_4; vNEOPLAN_5; vNEOPLAN_6; vNEOPLAN_7; vNEOPLAN_8; vNEOPLAN_9; vNEOPLAN_10; vNEOPLAN_11; vNEOPLAN_12; vNEOPLAN_13; vNEOPLAN_14; vNEOPLAN_15)
C_TEXT:C284(vNEOPLAN_16; vNEOPLAN_17; vNEOPLAN_18; vNEOPLAN_19; vNEOPLAN_20; vNEOPLAN_21; vNEOPLAN_22)

C_TEXT:C284(vNABI_1; vNABI_2; vNABI_3; vNABI_4; vNABI_5; vNABI_6; vNABI_7; vNABI_8; vNABI_9; vNABI_10; vNABI_11; vNABI_12; vNABI_13; vNABI_14; vNABI_15)
C_TEXT:C284(vNABI_16; vNABI_17; vNABI_18; vNABI_19; vNABI_20; vNABI_21; vNABI_22)

C_TEXT:C284(vHA_1; vHA_2; vHA_3; vHA_4; vHA_5; vHA_6; vHA_7; vHA_8; vHA_9; vHA_10; vHA_11; vHA_12; vHA_13; vHA_14; vHA_15)
C_TEXT:C284(vHA_16; vHA_17; vHA_18; vHA_19; vHA_20; vHA_21; vHA_22)

C_TEXT:C284(vRevenue_1; vRevenue_2; vRevenue_3; vRevenue_4; vRevenue_5; vRevenue_6; vRevenue_7; vRevenue_8; vRevenue_9; vRevenue_10; vRevenue_11; vRevenue_12; vRevenue_13; vRevenue_14; vRevenue_15)
C_TEXT:C284(vRevenue_16; vRevenue_17; vRevenue_18; vRevenue_19; vRevenue_20; vRevenue_21; vRevenue_22)

C_TEXT:C284(vWorkCar_1; vWorkCar_2; vWorkCar_3; vWorkCar_4; vWorkCar_5; vWorkCar_6; vWorkCar_7; vWorkCar_8; vWorkCar_9; vWorkCar_10; vWorkCar_11; vWorkCar_12; vWorkCar_13; vWorkCar_14; vWorkCar_15)
C_TEXT:C284(vWorkCar_16; vWorkCar_17; vWorkCar_18; vWorkCar_19; vWorkCar_20; vWorkCar_21; vWorkCar_22)


//Added Inspection report function vars
ARRAY DATE:C224(TTTTINSPDATEs_ad; 0)
ARRAY DATE:C224(SIAItem90_ad; 0)
ARRAY TEXT:C222(TTTTINSPTYPE_atxt; 0)
ARRAY TEXT:C222(TTTTBINs_atxt; 0)
ARRAY TEXT:C222(TTTTBDEPTS_atxt; 0)
ARRAY DATE:C224(TTTTPASTINSPDATEs_ad; 0)
ARRAY TEXT:C222(TTTTPASTINSPTYPE_atxt; 0)
ARRAY TEXT:C222(TTTTPASTBINs_atxt; 0)
ARRAY LONGINT:C221(BRIDGEITEM91_aL; 0)
C_DATE:C307(LimitDate1_d; LimitDate2_d)

C_TEXT:C284(INSP_INSPTYPESBYRESPTREE_txt)
C_TEXT:C284(INSP_SelectedNewInspType_txt)
ARRAY TEXT:C222(INSP_SelType_atxt; 0)
ARRAY TEXT:C222(INSP_SelTypeCode_atxt; 0)

C_BOOLEAN:C305(NewRecord_b)

C_LONGINT:C283(bFIRSTPAGE; BLASTPAGE)