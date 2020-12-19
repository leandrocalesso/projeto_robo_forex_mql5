//+------------------------------------------------------------------+
//|                                         funcoes_fecha_ordens.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
// #define MacrosHello   "Hello, world!"
// #define MacrosYear    2010
//+------------------------------------------------------------------+
//| DLL imports                                                      |
//+------------------------------------------------------------------+
// #import "user32.dll"
//   int      SendMessageA(int hWnd,int Msg,int wParam,int lParam);
// #import "my_expert.dll"
//   int      ExpertRecalculate(int wParam,int lParam);
// #import
//+------------------------------------------------------------------+
//| EX5 imports                                                      |
//+------------------------------------------------------------------+
// #import "stdlib.ex5"
//   string ErrorDescription(int error_code);
// #import
//+------------------------------------------------------------------+

/*
func_fecha_todas_ordens()
func_fecha_todas_positivas()
func_fecha_todas_negativas()

*/

void func_fecha_todas_ordens()
{
  long ticket = 0;
   
  for ( int i = PositionsTotal() - 1; i >=0 ; i-- )
  {  
    ticket = PositionGetTicket( i );
    while( !ticket )
    {
     Sleep(2000);
     ticket = PositionGetTicket( i );
    }
    if ( ticket > 0 )
    {
        PositionSelectByTicket( ticket );
        ctrade.PositionClose( ticket, 10 );
    }
  }
}       

void func_fecha_todas_positivas()
{
  
  long   ticket  = 0;
  double profit = 0.0;
    
  for ( int i = PositionsTotal() - 1; i >=0; i-- )
  {  
    ticket = PositionGetTicket( i );
    while( !ticket )
    {
     Sleep(2000);
     ticket = PositionGetTicket( i );
    }
    if ( ticket > 0 )
    {
        PositionGetSymbol( i );
        PositionGetDouble( POSITION_PROFIT, profit );
        if ( profit > 0 )
           ctrade.PositionClose( ticket, 10 );
    }
  }    
}

void func_fecha_todas_negativas()
{
  long   ticket  = 0;
  double profit = 0.0;
    
  for ( int i = PositionsTotal() - 1; i >=0; i-- )
  {  
    ticket = PositionGetTicket( i );
    while( !ticket )
    {
     Sleep(2000);
     ticket = PositionGetTicket( i );
    }
    if ( ticket > 0 )
    {
        PositionGetSymbol( i );
        PositionGetDouble( POSITION_PROFIT, profit );
        if ( profit < 0 )
           ctrade.PositionClose( ticket, 10 );
    }
  }
}

