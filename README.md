# QGEM-Dry-Lab

This summer QGEM worked to build a ratiometric biofilm program. This program reads upser inputs of designated protein ratio found in the biofilm, as well as other contstraints designated by the user - such as organism. The program then works to produce the neccessary components, such as promoters and RBS sequences, required to produce such a biofilm. All scripts and files associated with QGEM's ratiometric program are to be run in Python 2.7. 

To run this program, the user needs to intially run the file "RB1". This program determines, the promoter library to be used, as well as the desired protein ratio output. Thanks to the generosity of Dr. Howard Salis at Penn State University, QGEM had the ability to directly integrate the pre-existing, largly supported, RBS Calculator directly into our program. Thus, accuracy in results is very high, as many papers exist surrounding and supporting the testing of the Salis Lab RBS Calculator. Dr. Salis provided QGEM with the Python helper script necessary to access the web-based API. Given the nature of the system, QGEM was given an authentication token for the file. Thus, it is not accessible to be run externally without contacting Dr. Salis.

In running the RB1 code, it should be noted the user is required to input desired protein strengths to run the simulation with. These promoter stengths should be pulled from the Anderson Promoter Library - as detailed in the code. If a user wishes to use an external promoter, not existing in the Anderson Library, the can determine the association Relative Promoter Strength Unit (RPU) of the promoter, through the use of iGEM's readily availible RPU Measurement Kit. 

Upon completed running of 'RB1', the user should then run 'Ratiometrics' in an eviornment allowing variable communciation - for example, QGEM utilized the Anaconda2 and Spyder platform. This script should output the neccesary contraints for the user to produce their desired biofilm. 
 
