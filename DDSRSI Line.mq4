/*
   This indicator was created by Kalenzo
   email: bartlomiej.gorski@gmail.com
   web: http://www.fxservice.eu
   
   The base for this indicator was orginal RSI attached with Metatrader.
*/
#property copyright "Copyright © 2004, MetaQuotes Software Corp. Modded by DaemonX"
#property link      "http://www.metaquotes.net/"

#property indicator_separate_window

#property indicator_level1 20
#property indicator_level2 80
#property indicator_level3 50
#property indicator_minimum 0
#property indicator_maximum 100
#property indicator_buffers 2

#property indicator_color1 clrWhite
#property indicator_style1 STYLE_SOLID
#property indicator_type1 DRAW_NONE

#property indicator_color2 clrRed
#property indicator_style2 STYLE_SOLID
#property indicator_type2 DRAW_LINE
#property indicator_width2 4


#property indicator_color3 clrSlateBlue
#property indicator_style3 STYLE_SOLID
#property indicator_type3 DRAW_LINE
#property indicator_width3 3



enum MY_TIMEFRAME {
    M1      =PERIOD_M1,            // One minute
    M5      =PERIOD_M5,            // Five minute
    M15     =PERIOD_M15,           // Fifteen minute
    M30     =PERIOD_M30,           // Thirty minute
    H1      =PERIOD_H1,            // One hour
    H4      =PERIOD_H4,            // Four hour
    CURRENT =PERIOD_CURRENT        // Use current timeframe, or double-click to change
}; 





//---- input parameters
extern int RSIOMA          = 14;
extern int RSIOMA_MODE     = MODE_EMA;
extern int RSIOMA_PRICE    = PRICE_CLOSE;

extern int Ma_RSIOMA       = 21,
           Ma_RSIOMA_MODE  = MODE_EMA;
           
           
sinput string text_03 = "====== DDS settings ======";                // DDS settings
sinput double        Slw = 5;
sinput double        Pds = 10;
sinput double        Slwsignal = 7;
sinput int                  Barcount = 2000;

input MY_TIMEFRAME tfr = CURRENT;


sinput int FreeZe = 1;
           

//---- buffers
double RSIBuffer[];
double PosBuffer[];
double NegBuffer[];
double marsioma[];


string short_name;
double rsioma[];
double freeze[];
double nofreeze[];


double buff[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   short_name = StringConcatenate("DDSRSI(",RSIOMA,")");   
   IndicatorBuffers(4);
   
   SetIndexBuffer(0,rsioma);
   SetIndexBuffer(1,freeze);
   SetIndexBuffer(2,nofreeze);
   
   
   SetIndexStyle(0,DRAW_LINE,STYLE_SOLID,3,clrSlateBlue);
   SetIndexStyle(1,DRAW_LINE,STYLE_SOLID,3);
   
   SetIndexBuffer(2,PosBuffer);
   SetIndexBuffer(3,NegBuffer);
      
   IndicatorShortName("DDSRSI Line");
 

//----

   return(0);
  }
//+------------------------------------------------------------------+
//| Relative Strength Index                                          |
//+------------------------------------------------------------------+
int start()
  {
  
   for(int i=0; i<=Barcount;i++){
   
   nofreeze[i]=EMPTY_VALUE;
   freeze[i]=EMPTY_VALUE;
   rsioma[i] = (iCustom(Symbol(), tfr, "Rsioma Light", RSIOMA, RSIOMA_MODE, RSIOMA_PRICE, 
                           Ma_RSIOMA, Ma_RSIOMA_MODE, 0, i)+iCustom(Symbol(), tfr, "Drake Delay Stochastic",
                        Slw,Pds, Slwsignal, Barcount, 0, i))/2;
    if(rsioma[i] == 0)
       rsioma[i] = rsioma[i]+0.1; 
                       
   if((MathAbs(rsioma[i]-rsioma[i+1])<=FreeZe) || (MathAbs(rsioma[i]-rsioma[i+2])<=FreeZe)){
   
     freeze[i] = rsioma[i];
   
   }else{
    nofreeze[i] = rsioma[i];
   
   } 
                
   
   }
   
   
//----
   return(0);
  }
//+------------------------------------------------------------------+

