If (False:C215)
	//LP [Bridge MHD NBIS];"NBIS Stack Info"
	
	Mods_2005_CM03
	// Modified by: costasmanousakis-(Designer)-(11/18/05 14:25:03)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(4/2/08 12:19:15)
	Mods_2008_CM_5403
	// Modified by: costasmanousakis-(Designer)-(6/6/11 14:13:09)
	Mods_2011_06
	//  `Made adjustments to the size of the window so width is 599<=2<=830 
	// Modified by: Costas Manousakis-(Designer)-(5/9/12 11:18:20)
	Mods_2012_05
	//  `Changed method of adjusting window size. Now the size is adjusted in the on  load form method of the input form.
	//  `sized back to the original in the close detail of this form. keep track by setting a variable in the On Open Detail of the 
	//  `Output form
	Mods_2012_12  //r001 ` Make following tables read only as we will never update from this process
	//[Element Cat]
	//[ElementDict]
	//[Inspection Type]
	//Modified by: Charles Miller (12/13/12 11:45:59)
	
	Mods_2013_02  //r001 ` Created so that we can have two nbis stack info forms
	//NBIS Stack Info
	//NBIS Stack Info MBTA
	//Modified by: Charles Miller (2/14/13 12:09:01)
	// Modified by: Costas Manousakis-(Designer)-(5/23/18 16:41:33)
	Mods_2018_05
	//  `removed the query by formula button for designer - can now use alt-click + button to add a formula. also the trash button
End if 
NBISStackInfo_FM