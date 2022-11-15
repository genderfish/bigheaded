This readme.txt file was generated on 20221108 by Jackie Culotta
Recommended citation for the data: XXX


-------------------
GENERAL INFORMATION
-------------------


1. Data in support of "Acoustic and chemical conditioning and retention for behavioral deterrence in invasive bigheaded carps (Hypophthalmichthys molitrix and H. nobilis)"


2. Author Information


  Principal Investigator Contact Information
        Name: Allen Mensinger
           Institution: University of Minnesota Duluth
           Address: 1035 Kirby Drive, 13 Swenson Science Building, Duluth, MN 55812
           Email: amensing@d.umn.edu

  Associate or Co-investigator Contact Information
        Name: Jackie Culotta
           Institution: University of Minnesota Duluth
           Email: jackieculotta@pm.me
	   ORCID: 0000-0002-2533-0802

3. Date published or finalized for release: XXX

4. Date of data collection (approximate range): 20210601 - 20220831

5. Geographic location of data collection (where was data collected?):  MAISRC Containment Lab, 1995 Fitch Ave, Falcon Heights, MN 55108

6. Information about funding sources that supported the collection of the data: Funding for this project was provided by the Minnesota Environment and Natural Resources Trust Fund as recommended by the Minnesota Aquatic Invasive Species Research Center (MAISRC) and the Legislative-Citizen Commission on Minnesota Resources (LCCMR).

7. Overview of the data (abstract): XXX


--------------------------
SHARING/ACCESS INFORMATION
-------------------------- 


1. Licenses/restrictions placed on the data: Attribution-NonCommercial 4.0 International (CC BY-NC 4.0) https://creativecommons.org/licenses/by-nc/4.0/

2. Links to publications that cite or use the data: XXX

3. Was data derived from another source? No
           If yes, list source(s):

4. Terms of Use: Data Repository for the U of Minnesota (DRUM) By using these files, users agree to the Terms of Use. https://conservancy.umn.edu/pages/drum/policies/#terms-of-use




---------------------
DATA & FILE OVERVIEW
---------------------


1. File List
   A. Filename: CO2_Avoidance.Rmd
      Short description: Calculates pCO2 avoidance thresholds in the small and large tank.     

   B. Filename: LargeTank.Rmd
      Short description: Mixed ANOVAs for first return and exit in the large tank. Paired t-tests computed for tracking metrics.          
        
   C. Filename: SmallTank.Rmd
      Short description: Mixed ANOVAs for first return and exit in the small tank. 


2. Relationship between files: Behavioral data from each tank is separate. 



--------------------------
METHODOLOGICAL INFORMATION
--------------------------

1. Description of methods used for collection/generation of data: See article associated with this dataset. 

2. Methods for processing the data: See Rmd files. 

3. Instrument- or software-specific information needed to interpret the data: R & R studio. Soundmaps require MatLab & signal processing toolbox. 

4. Standards and calibration information, if appropriate: NA

5. Environmental/experimental conditions: NA

6. Describe any quality-assurance procedures performed on the data: NA

7. People involved with sample collection, processing, analysis and/or submission: Jackie Culotta



--------------------------
DATA-SPECIFIC INFORMATION
--------------------------

1. Missing data codes:
        NA Not applicable
        NR Not recorded


2. Variable List
                  
    A. Name: VID_ID
       Description: Identifier for each video file. 

    L. Name: Fish_ID or School_ID
       Description: Identifier for each fish or school of five fish. 

    A. Name: Sound
       Description: Whether sound was playing or not.
                    Sound, Acclimation

    B. Name: Speaker
       Description: Whether the active speaker was placed in the right or left chamber. 
                    Right, Left

    C. Name: TrainedWith
       Description: Conditioning treatment assignment in the large tank. 
                    CO2, Air

    D. Name: Trained
       Description: Conditioning treatment assignment in the small tank.  
                    0 days, 2 days

    E. Name: Days_Since_Train
       Description: The number of days since the fish or school underwent conditioning. 

    J. Name: pH
       Description: Ambient water pH at trial onset, unless otherwise noted. 
                    
    K. Name: Temp_C
       Description: Ambient water temperature in celsius at trial onset. 

    M. Name: Time
       Description: Approximate time of trial. Rounded to the nearest 15 minute mark. 

    N. Name: Fish_TrialNum
       Description: The trial number for that fish or school of fish. 

    O. Name: Species
       Description: Species of the experimental animal(s).
	Silver, Bighead

    P. Name: Stopped_Sound_On_Return
       Description: Whether sound was stopped after fish returned to speaker side or continued for trial duration.
	FALSE, TRUE


Response vars

 

    F. Name: Exit_N
       Description: Number of shuttles away from the active speaker side.
                    
    G. Name: Return_N
       Description: Number of shuttles towards the active speaker side.

    H. Name: Exit_s  
       Description: Seconds until first shuttle away from the active speaker side.
                    
    I. Name: Return_s
       Description: Seconds in opposite chamber until first shuttle towards the active speaker side.




specific to certain files 

    Q. Name: Angle
       Description: Angle of between the fish, speaker, and exit in small tank. 


	
