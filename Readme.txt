This readme.txt file was generated on 20221108 by Jackie Culotta
Suggested citation: Culotta, Jackie; Vetter, Brooke, J; Mensinger, Allen, F; Kramer, Cassandra, A; Ervin, Marie, L. (2023). Chemotaxis and phonotaxis in a two-choice shuttle tank by bigheaded carps. Retrieved from the Data Repository for the University of Minnesota, https://hdl.handle.net/11299/252999.

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
           Email: culottajackie@gmail.com
	   ORCID: 0000-0002-2533-0802

	Name:  Brooke Vetter
		Institution: University of Saint Thomas
		Email: brooke.vetter@stthomas.edu

	Name:  Cassandra Kramer
		Institution: University of Saint Thomas
		Email: cassie@kramersonline.org

	Name:  Marie Ervin
		Institution: University of Saint Thomas
		Email: marieervin00@gmail.com


3. Date published or finalized for release: 4/6/2023

4. Date of data collection (approximate range): 20210601 - 20220831

5. Geographic location of data collection (where was data collected?):  MAISRC Containment Lab, 1995 Fitch Ave, Falcon Heights, MN 55108

6. Information about funding sources that supported the collection of the data: Funding for this project was provided by the Minnesota Environment and Natural Resources Trust Fund as recommended by the Minnesota Aquatic Invasive Species Research Center (MAISRC) and the Legislative-Citizen Commission on Minnesota Resources (LCCMR).

7. Overview of the data (abstract): Dissolved carbon dioxide avoidance in silver and bighead carps. Additionally, carp were conditioned to associate broadband sound from outboard boat motors (0.06 – 10 kHz, ~150 dB re 1 μPa) with CO2 application (~35,000 ppm). Phonotaxis trials were conducted over one to four weeks in a both a small (80 L) and large (3475 L) two-choice shuttle tank.


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


2. Relationship between files: Each of the three experiments are analyzed separately. Carbon dioxide avoidance thresholds, and behavioral response data from the small and large tank are separate. 



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


2. Variable List (Predictors)
                  
    A. Name: VID_ID
       Description: Identifier for each video file. 

    B. Name: Fish_ID or School_ID
       Description: Identifier for each fish or school of five fish. 

    C. Name: Sound
       Description: Whether sound was playing (during the trial), or not playing (ambient conditions during acclimation period).
                    Sound, Acclimation

    D. Name: Speaker
       Description: Whether the active speaker was placed in the right or left chamber. 
                    Right, Left

    E. Name: TrainedWith
       Description: Conditioning treatment assignment in the large tank. 
                    CO2, Air

    F. Name: Trained
       Description: Conditioning treatment assignment in the small tank.  
                    0 days, 2 days

    G. Name: Days_Since_Train
       Description: The number of days since the fish or school underwent conditioning. 

    H. Name: pH
       Description: Ambient water pH at trial onset, unless otherwise noted. 
                    
    I. Name: Temp_C
       Description: Ambient water temperature in celsius at trial onset. 

    J. Name: Time
       Description: Approximate time of trial. Rounded to the nearest 15 minute mark. 

    K. Name: Fish_TrialNum
       Description: The trial number for that fish or school of fish. 

    L. Name: Species
       Description: Species of the experimental animal(s).
	Silver, Bighead

    M. Name: Stopped_Sound_On_Return
       Description: Whether sound was stopped after fish returned to speaker side or continued for trial duration.
	FALSE, TRUE

    N. Name: dB
       Description: Sound pressure level (SPL) in decibels. 

    O. Name: RMS
       Description: Mean root mean square voltage to calculate SPL


3. Variable List (Response)

 
    A. Name: Exit_N
       Description: Number of shuttles away from the active speaker side.
                    
    B. Name: Return_N
       Description: Number of shuttles towards the active speaker side.

    C. Name: Exit_s  
       Description: Seconds until first shuttle away from the active speaker side.
                    
    D. Name: Return_s
       Description: Seconds in opposite chamber until first shuttle towards the active speaker side.






	
