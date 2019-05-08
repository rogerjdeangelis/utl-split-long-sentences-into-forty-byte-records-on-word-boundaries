Split long sentences into forty byte records on word boundaries                                                             
                                                                                                                            
Fixed a typo.                                                                                                               
                                                                                                                            
  Changed 'length line $40' to 'length line $80' report keeps the last workr that might be slightly longer than 40 bytes.   
                                                                                                                            
Addded  'proc template' solution                                                                                            
                                                                                                                            
      Two Solutions                                                                                                         
                                                                                                                            
          1. Proc report                                                                                                    
          2, Proc template then proc report                                                                                 
                                                                                                                            
                                                                                                                            
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
                                                                                                                            
                                                                                                                            
*          _       _   _                                                                                                    
 ___  ___ | |_   _| |_(_) ___  _ __  ___                                                                                    
/ __|/ _ \| | | | | __| |/ _ \| '_ \/ __|                                                                                   
\__ \ (_) | | |_| | |_| | (_) | | | \__ \                                                                                   
|___/\___/|_|\__,_|\__|_|\___/|_| |_|___/                                                                                   
                                                                                                                            
;                                                                                                                           
                                                                                                                            
*****************                                                                                                           
1. Proc report  *                                                                                                           
*****************                                                                                                           
                                                                                                                            
%utlfkil(d:/txt/line.txt);                                                                                                  
                                                                                                                            
data want;                                                                                                                  
                                                                                                                            
  if _n_=0 then do; %let rc=%sysfunc(dosubl('                                                                               
     proc printto print="d:/txt/line.txt" new;                                                                              
     proc report data=have missing;                                                                                         
     col line;                                                                                                              
     define line / display width=44 flow;                                                                                   
     run;quit;                                                                                                              
     proc printto;                                                                                                          
     '));                                                                                                                   
  end;                                                                                                                      
                                                                                                                            
 length line $80;                                                                                                           
 infile "d:/txt/line.txt";                                                                                                  
 input;                                                                                                                     
 line=_infile_;                                                                                                             
                                                                                                                            
run;quit;                                                                                                                   
                                                                                                                            
                                                                                                                            
***********************************                                                                                         
2. Proc template then proc report *                                                                                         
***********************************                                                                                         
                                                                                                                            
%utlfkil(d:/txt/line.txt);                                                                                                  
                                                                                                                            
libname odslib v9 "%sysfunc(pathname(work))";                                                                               
ods path odslib.templates sashelp.tmplmst work.templates(update);                                                           
/* put the template in work.templates */                                                                                    
proc template;                                                                                                              
    define table rolchr;                                                                                                    
    classlevels=on;                                                                                                         
    order_data=on;                                                                                                          
    col_space_max=1;                                                                                                        
    col_space_min=1;                                                                                                        
    define column rol;                                                                                                      
    generic=on;                                                                                                             
    blank_dups=on;                                                                                                          
    flow=on;                                                                                                                
    width=40;   * this is where we set length;                                                                              
    just=l;                                                                                                                 
    header=' ';                                                                                                             
    end;                                                                                                                    
    end;                                                                                                                    
run;quit;                                                                                                                   
                                                                                                                            
options nodate nonumber ps=5000 ls=284;                                                                                     
title;footnote;                                                                                                             
ods listing file="d:/txt/line.txt" style=minimal;                                                                           
data _null_;                                                                                                                
    retain cnt -1;                                                                                                          
    set have end=dne;                                                                                                       
    file print ods=(template='rolchr' columns=(rol=line (generic=on)));                                                     
    put _ods_;                                                                                                              
run;                                                                                                                        
quit;                                                                                                                       
ods path close;                                                                                                             
ods listing close;                                                                                                          
ods listing;                                                                                                                
                                                                                                                            
data want;                                                                                                                  
 informat line $80.;                                                                                                        
 infile "d:/txt/line.txt" length=len;                                                                                       
 input line $varying171. len;                                                                                               
 if line ne "" then output;                                                                                                 
run;                                                                                                                        
ods path reset;                                                                                                             
                                                                                                                            
                                                                                                                            
