//+------------------------------------------------------------------+
//|                                                          box.mq4 |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "By Daemonx Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+

input int m15period = 8;
input int H1period = 8;
input int H4period = 8;
input int D1period = 8;
input int W1period = 8;
input int M1period = 8;

enum fractals
  {
   THREE_BAR, //Three Bar Fractals
   FIVE_BAR,   //Five Bar Fractals

};

input fractals fractaltype = THREE_BAR;
input color           m5upperfractal_color=clrRed;
input color           m5lowefractal_color=clrRed;
input int m5fractal_width = 1;

input color           m15upperfractal_color=clrRed;
input color           m15lowefractal_color=clrRed;
input int m15fractal_width = 1;

input color           h1upperfractal_color=clrRed;
input color           h1lowefractal_color=clrRed;
input int h1fractal_width = 1;

input color           h4upperfractal_color=clrRed;
input color           h4lowefractal_color=clrRed;
input int h4fractal_width = 1;

input color           d1upperfractal_color=clrRed;
input color           d1lowefractal_color=clrRed;
input int d1fractal_width = 1; 


input color           w1upperfractal_color=clrRed;
input color           w1lowefractal_color=clrRed;
input int w1fractal_width = 1;   
  
input color           M1upperfractal_color=clrRed;
input color           M1lowefractal_color=clrRed;
input int M1fractal_width = 1; 
  
input int past_days = 24;
input ENUM_LINE_STYLE InpStyle=STYLE_SOLID; // Line style
input int             InpWidth=1;          // Line width




extern string             button_note1          = "------------------------------";
extern int                btn_Subwindow         = 0;
 ENUM_BASE_CORNER   btn_corner            = CORNER_LEFT_UPPER;
extern string             btn_text              = "5min Fractals";
extern string             btn_Font              = "Arial";
extern int                btn_FontSize          = 10;
extern color              btn_text_ON_color     = clrLime;
extern color              btn_text_OFF_color    = clrRed;
extern color              btn_background_color  = clrDimGray;
extern color              btn_border_color      = clrBlack;
extern int                button_x              = 20;
extern int                button_y              = 13;
extern int                btn_Width             = 60;
extern int                btn_Height            = 20;
extern string             UniqueButtonID        = "Fractals";
extern string             button_note2          = "------------------------------";


 string             UniqueButtonID1        = "OOpen";
 string             UniqueButtonID2        = "Woopen";
 string             UniqueButtonID3        = "Woopen1";
 string             UniqueButtonID4        = "Woopen2";
 string             UniqueButtonID5        = "Woopen5";
 string             UniqueButtonID6        = "Woopen6";

bool show_data = true, recalc    = true, show_data1 = true, recalc1    = true;
bool show_data2 = true, recalc2    = true, show_data3 = true, recalc3    = true;
bool show_data4 = true, recalc4    = true, show_data5 = true, recalc5    = true;
bool show_data6 = true, recalc6    = true, show_data7 = true, recalc7    = true;
bool show_data8 = true, recalc8    = true;

string indicatorFileName, IndicatorName, IndicatorName1, IndicatorObjPrefix,buttonId, buttonId1, buttonId2, buttonId3, buttonId4, buttonId5, buttonId6,buttonId7, buttonId8;
//button template end1; copy and paste
string IndicatorName2;
string IndicatorName3;
string IndicatorName4;
string IndicatorName5;
string IndicatorName6;
string IndicatorName7;
string IndicatorName8;



double opens[10000];
double highs[10000];
double lows[10000];
double closs[10000];

  string GenerateIndicatorName(const string target)
  {
   string name = target;
   int try
         = 2;
   while(WindowFind(name) != -1)
     {
      name = target + " #" + IntegerToString(try
                                                ++);
     }
   return name;
  }
   
   
int OnInit()
  {
   

   IndicatorName = GenerateIndicatorName(btn_text);
   IndicatorName1 = GenerateIndicatorName("Dopen");
   IndicatorName2 = GenerateIndicatorName("WEEKLY");
   IndicatorObjPrefix = "__" + IndicatorName + "__";
   IndicatorShortName(IndicatorName);
   IndicatorDigits(Digits);

   double val;
   double val1;
   double val2;
   double val3;
   double val4;
   double val5;
   double val6;
   double val7;
   double val8;
    
   


 
   if(GlobalVariableGet(IndicatorName + "_visibility", val))
      show_data =  0;
      
   if(GlobalVariableGet(IndicatorName1 + "_visibility", val1))
      show_data1 =  0; 
      
   if(GlobalVariableGet(IndicatorName2 + "_visibility", val2))
      show_data2 =  0;  
   
    if(GlobalVariableGet(IndicatorName3 + "_visibility", val3))
      show_data3 = 0;
      
     if(GlobalVariableGet(IndicatorName4 + "_visibility", val4))
      show_data4 = 0;
             
     if(GlobalVariableGet(IndicatorName5 + "_visibility", val5))
      show_data5 = 0;  
      
      if(GlobalVariableGet(IndicatorName6 + "_visibility", val6))
      show_data6 = 0; 
      
     indicatorFileName = WindowExpertName();

  /* ChartSetInteger(0, CHART_EVENT_MOUSE_MOVE, 1);
   buttonId = IndicatorObjPrefix + UniqueButtonID+(btn_text);
   createButton(buttonId, btn_text, btn_Width, btn_Height, btn_Font, btn_FontSize, btn_background_color, btn_border_color, btn_text_ON_color);
   ObjectSetInteger(0, buttonId, OBJPROP_YDISTANCE, button_y);
   ObjectSetInteger(0, buttonId, OBJPROP_XDISTANCE, button_x);
  */

   buttonId1 = MathRand()+IndicatorObjPrefix + UniqueButtonID1+("opbtn");
   createButton(buttonId1, "15min Fractals", 150, btn_Height, btn_Font, btn_FontSize, btn_background_color, btn_border_color, btn_text_ON_color);
   ObjectSetInteger(0, buttonId1, OBJPROP_YDISTANCE, button_y);
   ObjectSetInteger(0, buttonId1, OBJPROP_XDISTANCE, 40);

   buttonId2 = MathRand()+IndicatorObjPrefix + UniqueButtonID2+("wopbtn");
   createButton(buttonId2, "1Hr Fractals", 150, btn_Height, btn_Font, btn_FontSize, btn_background_color, btn_border_color, btn_text_ON_color);
   ObjectSetInteger(0, buttonId2, OBJPROP_YDISTANCE, button_y);
   ObjectSetInteger(0, buttonId2, OBJPROP_XDISTANCE, 190);
   
    buttonId3 = MathRand()+IndicatorObjPrefix + UniqueButtonID3+("wopbtn1");
   createButton(buttonId3, "4Hr Fractals", 150, btn_Height, btn_Font, btn_FontSize, btn_background_color, btn_border_color, btn_text_ON_color);
   ObjectSetInteger(0, buttonId3, OBJPROP_YDISTANCE, button_y);
   ObjectSetInteger(0, buttonId3, OBJPROP_XDISTANCE, 340);
  
   buttonId4 = MathRand()+IndicatorObjPrefix + UniqueButtonID4+("wopbtn2");
   createButton(buttonId4, "Daily Fractals", 150, btn_Height, btn_Font, btn_FontSize, btn_background_color, btn_border_color, btn_text_ON_color);
   ObjectSetInteger(0, buttonId4, OBJPROP_YDISTANCE, button_y);
   ObjectSetInteger(0, buttonId4, OBJPROP_XDISTANCE, 490);   
 
   buttonId5 = MathRand()+IndicatorObjPrefix + UniqueButtonID5+("wopbtn3");
   createButton(buttonId5, "Weekly Fractals", 150, btn_Height, btn_Font, btn_FontSize, btn_background_color, btn_border_color, btn_text_ON_color);
   ObjectSetInteger(0, buttonId5, OBJPROP_YDISTANCE, button_y);
   ObjectSetInteger(0, buttonId5, OBJPROP_XDISTANCE, 640); 
   
   buttonId6 = MathRand()+IndicatorObjPrefix + UniqueButtonID6+("wopbtn4");
   createButton(buttonId6, "Monthly Fractals", 150, btn_Height, btn_Font, btn_FontSize, btn_background_color, btn_border_color, btn_text_ON_color);
   ObjectSetInteger(0, buttonId6, OBJPROP_YDISTANCE, button_y);
   ObjectSetInteger(0, buttonId6, OBJPROP_XDISTANCE, 790); 
   
   return(INIT_SUCCEEDED);
  }
  
  
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
   
   
 

   if(id==CHARTEVENT_OBJECT_CLICK && ObjectGet(sparam,OBJPROP_TYPE)==OBJ_BUTTON){
     handleButtonClicks();
      if(show_data)
        {
         ObjectSetInteger(ChartID(),buttonId,OBJPROP_COLOR,btn_text_ON_color);
        // start();
        }
      else
        {
         ObjectSetInteger(ChartID(),buttonId,OBJPROP_COLOR,btn_text_OFF_color);
       //  deinit2();
        }
     



   handleButtonClicks1();
      if(show_data1)
        {
         ObjectSetInteger(ChartID(),buttonId1,OBJPROP_COLOR,btn_text_ON_color);
         
        fractalleves(PERIOD_M15,"m15", m15fractal_width, m15upperfractal_color, m15lowefractal_color, m15period);
     
        }
       else if(!show_data1)
        {
         ObjectSetInteger(ChartID(),buttonId1,OBJPROP_COLOR,btn_text_OFF_color);
         deinitfractals("m15high");
         deinitfractals("m15low");
          
        }


      handleButtonClicks2();
      if(show_data2)
        {
         ObjectSetInteger(ChartID(),buttonId2,OBJPROP_COLOR,btn_text_ON_color);
        fractalleves(PERIOD_H1,"h1", h1fractal_width, h1upperfractal_color, h1lowefractal_color, H1period);
        }
      else if(!show_data2)
        {
         ObjectSetInteger(ChartID(),buttonId2,OBJPROP_COLOR,btn_text_OFF_color);
         deinitfractals("h1high");
         deinitfractals("h1low");
        }
        
        
        handleButtonClicks3();
      if(show_data3)
        {
         ObjectSetInteger(ChartID(),buttonId3,OBJPROP_COLOR,btn_text_ON_color);
        fractalleves(PERIOD_H4,"h4", h4fractal_width, h4upperfractal_color, h4lowefractal_color, H4period);
        }
      else if(!show_data3)
        {
         ObjectSetInteger(ChartID(),buttonId3,OBJPROP_COLOR,btn_text_OFF_color);
         deinitfractals("h4high");
         deinitfractals("h4low");
        }
        
        
        
     handleButtonClicks4();
      if(show_data4)
        {
         ObjectSetInteger(ChartID(),buttonId4,OBJPROP_COLOR,btn_text_ON_color);
        fractalleves(PERIOD_D1,"D1", d1fractal_width, d1upperfractal_color, d1lowefractal_color, D1period);
        }
      else if(!show_data4)
        {
         ObjectSetInteger(ChartID(),buttonId4,OBJPROP_COLOR,btn_text_OFF_color);
         deinitfractals("D1high");
         deinitfractals("D1low");
        }
        
     
        
     handleButtonClicks5();
      if(show_data5)
        {
         ObjectSetInteger(ChartID(),buttonId5,OBJPROP_COLOR,btn_text_ON_color);
        fractalleves(PERIOD_W1,"W", w1fractal_width, w1upperfractal_color, w1lowefractal_color, W1period);
        }
      else if(!show_data5)
        {
         ObjectSetInteger(ChartID(),buttonId5,OBJPROP_COLOR,btn_text_OFF_color);
         deinitfractals("Whigh");
         deinitfractals("Wlow");
        }
        
        
       handleButtonClicks6();
      if(show_data6)
        {
         ObjectSetInteger(ChartID(),buttonId6,OBJPROP_COLOR,btn_text_ON_color);
        fractalleves(PERIOD_MN1,"M", M1fractal_width, M1upperfractal_color, M1lowefractal_color, M1period);
        }
      else if(!show_data6)
        {
         ObjectSetInteger(ChartID(),buttonId6,OBJPROP_COLOR,btn_text_OFF_color);
         deinitfractals("Mhigh");
         deinitfractals("Mlow");
        }            
     
     
      
}


  }  
  
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   
//Comment(show_data1);

   return(rates_total);
  }
//+------------------------------------------------------------------+

double points_to_change(int n) { return n * _Point; }

int change_to_points(double c) { return int(c / _Point + 0.5); }

double pips_to_change(double n) { return points_to_change(pips_to_points(n)); }

double change_to_pips(double c) { return points_to_pips(change_to_points(c)); }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int pips_to_points(double n)
  {
   if((Digits() & 1) == 1)
      n *= 10.0;
   return int(n);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double points_to_pips(int n)
  {
   double p = NormalizeDouble(n, Digits());
   if((Digits() & 1) == 1)
     {
      p /= 10.0;
     }
   return p;
  }
  
  
  
  
  void OnDeinit(const int reason)
  {
    
   ObjectsDeleteAll(ChartID(), IndicatorObjPrefix);
   ObjectsDeleteAll(ChartID(), buttonId1);
   ObjectsDeleteAll(ChartID(), buttonId2);
   ObjectsDeleteAll(ChartID(), buttonId3);
   ObjectsDeleteAll(ChartID(), buttonId4);
   ObjectsDeleteAll(ChartID(), buttonId5);
   ObjectsDeleteAll(ChartID(), buttonId6);
   
   for(int i = ObjectsTotal() -1; i >=0; i--) {
   ObjectDelete(ObjectName(i));
}



   for(int iObj=ObjectsTotal()-1; iObj >= 0; iObj--)
     {
      string on = ObjectName(iObj);
      if(StringFind(on, "open") == 0)
         ObjectDelete(on);




     }
   ObjectDelete(0,
                "open"  // object name
               );






   for(int iObj=ObjectsTotal()-1; iObj >= 0; iObj--)
     {
      string on = ObjectName(iObj);
      if(StringFind(on, "high") == 0)
         ObjectDelete(on);
      if(StringFind(on, "low") == 0)
         ObjectDelete(on);
      if(StringFind(on, "Zone") == 0)
         ObjectDelete(on);
      if(StringFind(on, "ZoneA") == 0)
         ObjectDelete(on);
      if(StringFind(on, "ZoneB") == 0)
         ObjectDelete(on);
      if(StringFind(on, "ZoneC") == 0)
         ObjectDelete(on);
      if(StringFind(on, "ZoneD") == 0)
         ObjectDelete(on);
      if(StringFind(on, "ZoneE") == 0)
         ObjectDelete(on);
      if(StringFind(on, "ZoneF") == 0)
         ObjectDelete(on);
      if(StringFind(on, "ZoneG") == 0)
         ObjectDelete(on);

      if(StringFind(on, "ZoneH") == 0)
         ObjectDelete(on);

      if(StringFind(on, "ZoneI") == 0)
         ObjectDelete(on);

      if(StringFind(on, "ZoneJ") == 0)
         ObjectDelete(on);




     }
   ObjectDelete(0,
                "high"  // object name
               );
   ObjectDelete(0,
                "low"
               );
   ObjectDelete(
      "ZoneA"  // object name
   );
   ObjectDelete(0,
                "ZoneB"
               );
   ObjectDelete(0,
                "ZoneC"  // object name
               );
   ObjectDelete(0,
                "ZoneD"
               );

   ObjectDelete(0,
                "ZoneE"
               );

   ObjectDelete(0,
                "ZoneF"
               );

   ObjectDelete(0,
                "ZoneG"
               );

   ObjectDelete(0,
                "ZoneH"
               );

   ObjectDelete(0,
                "ZoneI"
               );

   ObjectDelete(0,
                "ZoneJ"
               );



  }
  
  
  void fractalleves(int tfr,string tfrstr, int linewidth,color paintclrs, color paintclrb, int period){
  
       int bars=(int)ChartGetInteger(0,CHART_VISIBLE_BARS);
   for(int i=2; i<=period; i++)
     {
      double open = iOpen(Symbol(), tfr, i);
      double high = iHigh(Symbol(), tfr, i);
      double low = iLow(Symbol(), tfr, i);
      double close = iClose(Symbol(), tfr, i);
      
      double prev_open = iOpen(Symbol(), tfr, i+1);
      double prev_high = iHigh(Symbol(), tfr, i+1);
      double prev_low = iLow(Symbol(), tfr, i+1);
      double prev_close = iClose(Symbol(), tfr, i+1);
       double pprev_low = iLow(Symbol(), tfr, i+2);
        double pprev_high = iHigh(Symbol(), tfr, i+2);
      
      double after_open = iOpen(Symbol(), tfr, i-1);
      double after_high = iHigh(Symbol(), tfr, i-1);
      double after_low = iLow(Symbol(), tfr, i-1);
      double after_close = iClose(Symbol(), tfr, i-1);
       double aafter_low = iLow(Symbol(), tfr, i-2);
          double aafter_high = iHigh(Symbol(), tfr, i-2);
      // Comment(openq2[1]);
 
 
 //sell
   if(fractaltype == THREE_BAR){    
       if(high>prev_high && high>after_high && high>aafter_high && high>pprev_high)
      {
        
        int secondsPerBar = PeriodSeconds();
       // datetime endTime = Time[i] + 10 * secondsPerBar;


      //  Comment(Time[i]);
   
        
      datetime  tc = iTime(Symbol(), tfr, i) + 240*60;
        
    datetime tomorrows_time = iTime(NULL,PERIOD_D1,0) + 172799;
   if (TimeDayOfWeek(iTime(NULL,PERIOD_D1,0)) == 5)
   tomorrows_time = iTime(NULL,PERIOD_D1,0) + 259199;
   
   
         ObjectCreate(0,tfrstr+"high"+i,OBJ_TREND,0, iTime(Symbol(),tfr,i),high,tomorrows_time,high);
         ObjectSet(tfrstr+"high"+i,OBJPROP_RAY, False);
         ObjectSetInteger(0,tfrstr+"high"+i,OBJPROP_COLOR,paintclrs);
         //--- set line display style
        ObjectSetInteger(0,tfrstr+"high"+i,OBJPROP_STYLE,InpStyle);
         //--- set line width
        ObjectSetInteger(0,tfrstr+"high"+i,OBJPROP_WIDTH,linewidth);
   
  
     }
     
 
      if(low<prev_low && low<after_low && low<pprev_low && low<aafter_low)
      {
        
        int secondsPerBar = PeriodSeconds();
       // datetime endTime = Time[i] + 10 * secondsPerBar;


       // Comment(Time[i]);
   
        
      datetime  tc = iTime(Symbol(), PERIOD_CURRENT, i) + 240*60;
        
    datetime tomorrows_time = iTime(NULL,PERIOD_D1,0) + 172799;
   if (TimeDayOfWeek(iTime(NULL,PERIOD_D1,0)) == 5)
   tomorrows_time = iTime(NULL,PERIOD_D1,0) + 259199;
     
         ObjectCreate(0,tfrstr+"low"+i,OBJ_TREND,0, iTime(Symbol(),tfr,i),low,tomorrows_time,low);
         ObjectSetInteger(0,tfrstr+"low"+i,OBJPROP_COLOR,paintclrb);
         //--- set line display style
         ObjectSetInteger(0,tfrstr+"low"+i,OBJPROP_STYLE,InpStyle);
         //--- set line width
         ObjectSetInteger(0,tfrstr+"low"+i,OBJPROP_WIDTH,linewidth);
         ObjectSet("low"+i,OBJPROP_RAY, False);
 
     }
 
      
     }
     
     
     
 
 //sell
   if(fractaltype == FIVE_BAR){    
     if(high>prev_high && high>after_high)
      {
        
        int secondsPerBar = PeriodSeconds();
       // datetime endTime = Time[i] + 10 * secondsPerBar;


      //  Comment(Time[i]);
   
        
      datetime  tc = iTime(Symbol(), tfr, i) + 240*60;
        
    datetime tomorrows_time = iTime(NULL,PERIOD_D1,0) + 172799;
   if (TimeDayOfWeek(iTime(NULL,PERIOD_D1,0)) == 5)
   tomorrows_time = iTime(NULL,PERIOD_D1,0) + 259199;
   
   
         ObjectCreate(0,tfrstr+"high"+i,OBJ_TREND,0, iTime(Symbol(),tfr,i),high,tomorrows_time,high);
         ObjectSet(tfrstr+"high"+i,OBJPROP_RAY, False);
         ObjectSetInteger(0,tfrstr+"high"+i,OBJPROP_COLOR,paintclrs);
         //--- set line display style
        ObjectSetInteger(0,tfrstr+"high"+i,OBJPROP_STYLE,InpStyle);
         //--- set line width
        ObjectSetInteger(0,tfrstr+"high"+i,OBJPROP_WIDTH,linewidth);
   
  
     }
     
 
     if(low<prev_low && low<after_low)
      {
        
        int secondsPerBar = PeriodSeconds();
       // datetime endTime = Time[i] + 10 * secondsPerBar;


       // Comment(Time[i]);
   
        
      datetime  tc = iTime(Symbol(), PERIOD_CURRENT, i) + 240*60;
        
    datetime tomorrows_time = iTime(NULL,PERIOD_D1,0) + 172799;
   if (TimeDayOfWeek(iTime(NULL,PERIOD_D1,0)) == 5)
   tomorrows_time = iTime(NULL,PERIOD_D1,0) + 259199;
     
         ObjectCreate(0,tfrstr+"low"+i,OBJ_TREND,0, iTime(Symbol(),tfr,i),low,tomorrows_time,low);
         ObjectSetInteger(0,tfrstr+"low"+i,OBJPROP_COLOR,paintclrb);
         //--- set line display style
         ObjectSetInteger(0,tfrstr+"low"+i,OBJPROP_STYLE,InpStyle);
         //--- set line width
         ObjectSetInteger(0,tfrstr+"low"+i,OBJPROP_WIDTH,linewidth);
         ObjectSet("low"+i,OBJPROP_RAY, False);
 
     }
 
      
     }
     
     
         
     
     
     
     
     
     
     
     
     
     
     
  }
  
  
  }
  
  
  
  void createButton(string buttonID,string buttonText,int width2,int height,string font,int fontSize,color bgColor,color borderColor,color txtColor)
  {
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,btn_Subwindow,0,0);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,txtColor);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,bgColor);
   ObjectSetInteger(0,buttonID,OBJPROP_BORDER_COLOR,borderColor);
   ObjectSetInteger(0,buttonID,OBJPROP_BORDER_TYPE,BORDER_RAISED);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,width2);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,height);
   ObjectSetString(0,buttonID,OBJPROP_FONT,font);
   ObjectSetString(0,buttonID,OBJPROP_TEXT,buttonText);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,fontSize);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,btn_corner);
   ObjectSetInteger(0,buttonID,OBJPROP_HIDDEN,1);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,9999);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,9999);
  }
  
  
  void handleButtonClicks()
  {
   if(ObjectGetInteger(0, buttonId, OBJPROP_STATE))
     {
      ObjectSetInteger(0, buttonId, OBJPROP_STATE, false);
      show_data = !show_data;
      GlobalVariableSet(IndicatorName + "_visibility", show_data ? 1.0 : 0.0);
      recalc = true;
     }
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void handleButtonClicks1()
  {
   if(ObjectGetInteger(0, buttonId1, OBJPROP_STATE))
     {
      ObjectSetInteger(0, buttonId1, OBJPROP_STATE, false);
      show_data1 = !show_data1;
     
      GlobalVariableSet(IndicatorName1 + "_visibility", show_data1 ? 1.0 : 0.0);
      recalc1 = true;
     }
  }


void handleButtonClicks2()
  {
   if(ObjectGetInteger(0, buttonId2, OBJPROP_STATE))
     {
      ObjectSetInteger(0, buttonId2, OBJPROP_STATE, false);
      show_data2 = !show_data2;
      
      GlobalVariableSet(IndicatorName2 + "_visibility", show_data2 ? 1.0 : 0.0);
      recalc2 = true;
     }
  }
  
  
void handleButtonClicks3()
  {
   if(ObjectGetInteger(0, buttonId3, OBJPROP_STATE))
     {
      ObjectSetInteger(0, buttonId3, OBJPROP_STATE, false);
      show_data3 = !show_data3;
      
      GlobalVariableSet(IndicatorName3 + "_visibility", show_data3 ? 1.0 : 0.0);
      recalc3 = true;
     }
  }
  

void handleButtonClicks4()
  {
   if(ObjectGetInteger(0, buttonId4, OBJPROP_STATE))
     {
      ObjectSetInteger(0, buttonId4, OBJPROP_STATE, false);
      show_data4 = !show_data4;
      
      GlobalVariableSet(IndicatorName4 + "_visibility", show_data4 ? 1.0 : 0.0);
      recalc4 = true;
     }
  }
 
 
void handleButtonClicks5()
  {
   if(ObjectGetInteger(0, buttonId5, OBJPROP_STATE))
     {
      ObjectSetInteger(0, buttonId5, OBJPROP_STATE, false);
      show_data5 = !show_data5;
      
      GlobalVariableSet(IndicatorName5 + "_visibility", show_data5 ? 1.0 : 0.0);
      recalc5 = true;
     }
  }
  

void handleButtonClicks6()
  {
   if(ObjectGetInteger(0, buttonId6, OBJPROP_STATE))
     {
      ObjectSetInteger(0, buttonId6, OBJPROP_STATE, false);
      show_data6 = !show_data6;
      
      GlobalVariableSet(IndicatorName6 + "_visibility", show_data6 ? 1.0 : 0.0);
      recalc6 = true;
     }
  }  
  



int deinitfractals(string name)
  {
   ObDeleteObjectsByPrefix(name);
   ObDeleteObjectsByPrefix(name);
   Comment("");
   return(0);
 }
 
 
  void ObDeleteObjectsByPrefix(string Prefix)
  {
   int L = StringLen(Prefix);
   int i = 0;
   while(i < ObjectsTotal())
     {
      string ObjName = ObjectName(i);
      if(StringSubstr(ObjName, 0, L) != Prefix)
        {
         i++;
         continue;
        }
      ObjectDelete(ObjName);
     }
  }
  
