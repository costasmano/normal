//%attributes = {"invisible":true}
//Mods_2004_CM05 
//13-Sep-2004

//Fixed code in G_InspGetRatings - Eng Judgment Code was incorrect.

//Method XDownLoadServer 
//  `Replaced missed var vtMessage with $vtDwnloadMsg
//  `Adjusted handling of parameters. 
//  `Added Checks to avoid showing Alerts when not showing on screen.
//  `Write closing messages to file also.
//  `Fix call writing end messages to file; 
//  `Added call to write to file some abort errors at the start of routine.

//User Accesses
//  `Added user FHWA to ExternalInternal group.
//  `Allowed acces to ReviewPending and ReviewSent to ReadWrite group only.

//Database Properties
//  `Changed Max Cache to 256000kb
//  `Changed Block memory allocation to 5x49152kb.

//20-Sep-2004
//Modified Form method of [Bridge MHD NBIS];"Bridge Input" to change
//  `vsForward var based on the structure file name.
//Modified Form method of [Inspections];"BlankStarter" to change
//  `vsForward var based on the structure file name instead of the current
//  `user group.

//21-Sep-2004
//Modified forms [Bridge MHD NBIS];"Ratings",  [Bridge MHD NBIS];"2nd Records",
//  `to make included sub form Selectable instead of Enterable.
//Modified form [Inspections];"Closed Bridge" : Fix wrong name of Item36-4,
//  `Changed included subforms to Selectable instead of Enterable.
//Modified forms [Inspections];"Closed Bridge", [Inspections];"Critical Member", 
//  `[Inspections];"Culvert Form", 
//  `[Inspections];"Damage Form", [Inspections];"Routine Form" :
//  `Changed included subforms to Selectable instead of Enterable.

//28-Sep-2004
//Modified forms [Inspections];"Closed Bridge", [Inspections];"Critical Member", 
//  `[Inspections];"Culvert Form", 
//  `[Inspections];"Damage Form", [Inspections];"Routine Form" :
//  `Made two copies of the included subforms one Selectable, one Enterable;
//  `Added code in the form method to make one or the other visible,
//  `depending on whether the user belongs to the 'ReadOnly" group.