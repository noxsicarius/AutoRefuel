AutoRefuel
==========

This script is written by AxeCop and only placed here for an easy download in my tutorials.

1. Click ***[Download Zip](https://github.com/noxsicarius/AutoRefuel/archive/master.zip)*** on the right sidebar of this Github page.
1. Log into your server via FTP or your host's File Manager. Locate, download, and unpack (using PBO Manager or a similar PBO editor) your ***MPMissions/Your_Mission.pbo***, and open the resulting folder.
 
	> Note: "Your_Mission.pbo" is a placeholder name. Your mission might be called "DayZ_Epoch_11.Chernarus", "DayZ_Epoch_13.Tavi", or "dayz_mission" depending on hosting and chosen map.

1. Extract the downloaded folder and copy the ***service_point*** folder into the root of your mission folder.
1. Open the ***init.sqf*** in the root of your mission folder and paste the following at the bottom of the if(!isDedicated) code block:

	~~~~java
  //Tow and lift
  execVM “service_point\service_point.sqf”;
	~~~~
