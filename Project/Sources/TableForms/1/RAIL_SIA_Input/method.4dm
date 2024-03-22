If (False:C215)
	//Form Method: [Bridge MHD NBIS];"RAIL_SIA_Input "
	// Modified by: Costas Manousakis-(Designer)-(2/28/14 17:25:26)
	Mods_2014_02
	//  `Form copied from [Bridge MHD NBIS];"SI & A Input"
	// Modified by: Costas Manousakis-(Designer)-(4/22/14 14:39:54)
	Mods_2014_04
	//  `added Hybrid Artic loads under HWYRtg bridge loads
	// Modified by: Costas Manousakis-(Designer)-(12/2/19 15:23:28)
	Mods_2019_12
	//  `Added ES44AC label and fields in "CommutRtg_@" group on page 7
	// Modified by: Costas Manousakis-(Designer)-(5/18/20 11:42:22)
	Mods_2020_05
	//  `adjusted tab order in geometry tab
	// Modified by: Costas Manousakis-(Designer)-(7/7/20 16:06:54)
	Mods_2020_07_bug
	//  `Replaced 263K lalbels and ratings on page 7 with HSP-46 data
	// Modified by: Costas Manousakis-(Designer)-(2021-10-29T00:00:00 10:37:19)
	Mods_2021_10_bug
	//  `changed labels for HWYRTGs to TBusA, TBusB, TBusC - reuquested by D. NG 10/19/2021
	// Modified by: Costas Manousakis-(Designer)-(2022-0319:33:53)
	Mods_2022_03
	//  `added two revenue cars
End if 

If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 

SIA_RAILINPUT_FM