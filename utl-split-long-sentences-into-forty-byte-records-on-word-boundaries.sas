Split long sentences into forty byte records on word boundaries                                                       
                                                                                                                      
github                                                                                                                
https://tinyurl.com/y6ys7evq                                                                                          
https://github.com/rogerjdeangelis/utl-split-long-sentences-into-forty-byte-records-on-word-boundaries                
                                                                                                                      
relate to                                                                                                             
https://tinyurl.com/y26n4vpm                                                                                          
https://communities.sas.com/t5/ODS-and-Base-Reporting/How-to-avoid-splitting/m-p/554962                               
                                                                                                                      
*_                   _                                                                                                
(_)_ __  _ __  _   _| |_                                                                                              
| | '_ \| '_ \| | | | __|                                                                                             
| | | | | |_) | |_| | |_                                                                                              
|_|_| |_| .__/ \__,_|\__|                                                                                             
        |_|                                                                                                           
;                                                                                                                     
                                                                                                                      
data have;                                                                                                            
length line $110;                                                                                                     
input;                                                                                                                
line=_infile_;                                                                                                        
cards4;                                                                                                               
The quick brown fox jumped over the lazy dog. Today is the first day of the rest of your life.                        
Mary had a little lamb it fleece was white as snow and every where that may went the lamb was sure to go.             
;;;;                                                                                                                  
run;quit;                                                                                                             
                                                                                                                      
                                                                                                                      
WORK.HAVE total obs=2                                                                                                 
                                                                                                                      
Obs                                                   LINE                                                            
                                                                                                                      
 1  The quick brown fox jumped over the lazy dog. Today is the first day of the rest of your life.                    
 2  Mary had a little lamb it fleece was white as snow and every where that may went the lamb was sure to go.         
                                                                                                                      
                                                                                                                      
RULES                                                                                                                 
                                                                                                                      
Split into 40 byte records on word boundaries                                                                         
                                                                                                                      
The quick brown fox jumped over the lazy dog. Today is the first day of the rest of your life.                        
                                                                                                                      
LINE                                                                                                                  
1        10        20       30        40                                                                              
+--------+---------+---------+---------+                                                                              
                                                                                                                      
1234567890123456789012345678901234567890                                                                              
                                                                                                                      
The quick brown fox jumped over the                                                                                   
lazy dog. Today is the forst day of the                                                                               
rest of your life.                                                                                                    
                                                                                                                      
*            _               _                                                                                        
  ___  _   _| |_ _ __  _   _| |_                                                                                      
 / _ \| | | | __| '_ \| | | | __|                                                                                     
| (_) | |_| | |_| |_) | |_| | |_                                                                                      
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                     
                |_|                                                                                                   
;                                                                                                                     
                                                                                                                      
WANT total obs=6                                                                                                      
                                                                                                                      
Obs    LINE                                                                                                           
                                                                                                                      
 1     The quick brown fox jumped over the                                                                            
 2     lazy dog. Today is the forst day of the                                                                        
 3     rest of your life.                                                                                             
                                                                                                                      
 4     Mary had a little lamb it fleece was                                                                           
 5     white as snow and every where that may                                                                         
 6     went the lamb was sure to go.                                                                                  
                                                                                                                      
*                                                                                                                     
 _ __  _ __ ___   ___ ___  ___ ___                                                                                    
| '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                                   
| |_) | | | (_) | (_|  __/\__ \__ \                                                                                   
| .__/|_|  \___/ \___\___||___/___/                                                                                   
|_|                                                                                                                   
;                                                                                                                     
                                                                                                                      
%utlfkil(d:/txt/line.txt);                                                                                            
                                                                                                                      
data want;                                                                                                            
                                                                                                                      
  if _n_=0 then do; %let rc=%sysfunc(dosubl('                                                                         
     proc printto print="d:/txt/line.txt" new;                                                                        
     proc report data=have missing;                                                                                   
     col line;                                                                                                        
     define line / display width=40 flow;                                                                             
     run;quit;                                                                                                        
     proc printto;                                                                                                    
     '));                                                                                                             
  end;                                                                                                                
                                                                                                                      
 length line $42;                                                                                                     
 infile "d:/txt/line.txt";                                                                                            
 input;                                                                                                               
 line=_infile_;                                                                                                       
                                                                                                                      
run;quit;                                                                                                             
