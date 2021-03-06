//+------------------------------------------------------------------+
//|                                             todas_as_funcoes.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"

/*

   retorna_dias_passaram        ()
   retorna_dados_conta          ()
   func_retorna_dados_ordem     ()
   func_lucro_preju_menssal     ()
   func_retorno_swap            ()
   func_total_resgate           ()
   func_total_depositado        ()
   func_ultimo_deposito         ()
   retorna_valor_pip            ()
   func_preservar_capital       ()
   func_trailling_stop          ()
   func_abrir_ordem             ()
   func_calculo_lote            ()
   func_lucro_preju_diario      ()
   func_lucro_preju_semanal     ()
   func_ordens_positivas_atual  ()
   func_ordens_negativas_atual  ()
   func_atualiza_take_diario    ()
   func_retorno_lucro_preju_and ()
   retorna_tipo_conta           ()
   analize_regras_abrir_ordem   ()
   inicializa_estrutura_abertura()
   retorna_valor_monetario_sl_tp()
   converte_take_stop_preco     ()
   setando_take_stop_ordens_externas()
   func_retorna_indice_array    ()
*/

// Função que retorna quantos dias se passaram apartir
// de uma data especificada.( Fazendo as converções p/ horário local ).
int retorna_dias_passaram ( datetime data )
{
 
    datetime     data_atual     = TimeLocal();
    MqlDateTime  str_data_atual;
    TimeToStruct ( data_atual, str_data_atual );
    
    // convertendo o parâmetro de data p/ data/hora local.
    MqlDateTime  str_param_data;
    TimeToStruct ( data, str_param_data );
    datetime     param_data_convertida = TimeLocal( str_param_data );
    TimeToStruct ( param_data_convertida, str_param_data );
    
    /* Cálculos.
       - que retorne núm dias se passaram.
       - quantas horas passaram.
       - quantos minutos.
       - quantos segundos.     
                          
       Como Fazer ?    */
    return 0;
}

// 1 - retorna soma total Profit.
// 2 - retorna soma Profit negativo.
// 3 - retorna soma Profit positivo.
double retorna_dados_conta( int param )
{

     ulong  ticket     = 0;
     int    tipo       = 0;
     double profit     = 0.0;
     
     double soma_total = 0.0;
     double soma_negat = 0.0;
     double soma_posit = 0.0;
      
     HistorySelect( 0, TimeCurrent() );

     for ( int i = 0; i <= HistoryDealsTotal() - 1; i++ )
     {
          ticket  = HistoryDealGetTicket( i );
          tipo    = HistoryDealGetInteger( ticket, DEAL_TYPE );
          profit  = HistoryDealGetDouble ( ticket, DEAL_PROFIT );
             
          if ( tipo == DEAL_TYPE_BUY || tipo == DEAL_TYPE_SELL )
          {  
             if ( profit > 0 ) soma_posit += profit; 
             if ( profit < 0 ) soma_negat += profit;
             soma_total += profit;
          }     
     }

     if ( param == 1 ) return NormalizeDouble ( soma_total, 2 );
     if ( param == 2 ) return NormalizeDouble ( soma_negat, 2 );
     if ( param == 3 ) return NormalizeDouble ( soma_posit, 2 );
     
     return 0.0;
}

// Retorna Stop/Take da última entrada do gráfico.
// 0 - stop, 1 - take.
double func_retorna_dados_ordem( int stop_take, int magic_number )
{
    double retorno          = 0.0;
    double ticket           = 0.0;
    string simbolo          = NULL;
    double preco_entrada    = 0.0;
    double lote             = 0.0;
    int    tipo             = 0.0;
    double soma_take_compra = 0.0;
    double soma_take_venda  = 0.0;
    double soma_stop_compra = 0.0;
    double soma_stop_venda  = 0.0;
    
    for ( int i = 0; i < PositionsTotal(); i++ )
    {
         double ticket        = PositionGetTicket ( i );
         string simbolo       = PositionGetString ( POSITION_SYMBOL );
         double preco_entrada = PositionGetDouble ( POSITION_PRICE_OPEN );
         double lote          = PositionGetDouble ( POSITION_VOLUME );
         int    tipo          = PositionGetInteger( POSITION_TYPE );
         
         if ( PositionGetInteger( POSITION_MAGIC ) != magic_number )
         continue;
         
         if ( tipo == POSITION_TYPE_BUY )
         {
            if ( stop_take == 0 ) // Quero o valor do StopLoss da compra.
            {
                   retorno = preco_entrada - PositionGetDouble( POSITION_SL );
                   retorno = int( ( retorno / _Point ) );
                   
                   retorno = NormalizeDouble( retorno * retorna_valor_pip( lote ), 2 );
                   soma_stop_compra += retorno;
                   soma_stop_compra = soma_stop_compra * ( -1 );             
            }
            else if ( stop_take == 1 ) // Quero o valor do TakeProfit da compra.
            {
                   retorno =  preco_entrada - PositionGetDouble( POSITION_TP );
                   retorno = int( ( retorno / _Point ) );
                   retorno = NormalizeDouble( retorno * retorna_valor_pip( lote ), 2 );
                   soma_take_compra += retorno;
                   soma_take_compra = soma_take_compra * ( -1 );             
            }
        }
        if ( tipo == POSITION_TYPE_SELL )
        {
                if ( stop_take == 0 ) // Eu quero o valor do StopLoss da venda.
               {
                   retorno = preco_entrada - PositionGetDouble( POSITION_SL );
                   retorno = int( retorno / _Point );
                   retorno = NormalizeDouble( retorno * retorna_valor_pip( lote ), 2 );
                   soma_stop_venda += retorno;
                   soma_stop_venda = soma_stop_venda * ( -1 );             
               }
               else if ( stop_take == 1 ) // Quero o valor do TakeProfit da venda.
               {
                   retorno =  preco_entrada - PositionGetDouble( POSITION_TP );
                   retorno = int( retorno / _Point );
                   retorno = NormalizeDouble( retorno * retorna_valor_pip( lote ), 2 );             
                   soma_take_venda += retorno;
               }
        }
    }
    
    if ( soma_take_compra != 0 ) return soma_take_compra;
    else if ( soma_stop_compra != 0 ) return soma_stop_compra;
    else if ( soma_take_venda  != 0 ) return soma_take_venda;
    else if ( soma_stop_venda  != 0 ) return soma_stop_venda;
    
    return retorno;
}

double func_lucro_preju_menssal()
{
  
   double profit_ordens_soma = 0.0;
   int ticket_ordem          = 0;
   int tipo_ordem            = 0; 
  
   datetime    inicio     =  ( TimeGMT() - ( TimeGMT() - TimeLocal() ) - 2592000 );
   MqlDateTime str_inicio; 
   TimeToStruct( inicio, str_inicio );
   str_inicio.hour= 0;
   str_inicio.min = 0;
   str_inicio.sec = 0;
   inicio = StructToTime( str_inicio );
   
   datetime    fim        = TimeGMT() - ( TimeGMT() - TimeLocal() );
   MqlDateTime str_fim;
   TimeToStruct( fim, str_fim );    
   str_fim.hour= 0;
   str_fim.min = 0;
   str_fim.sec = 0;
   fim = StructToTime( str_fim ); 
   
   HistorySelect( inicio, fim );
   
   for ( int i = 0; i < HistoryDealsTotal(); i++ )
   {
       ticket_ordem = HistoryDealGetTicket( i );
       tipo_ordem   = HistoryDealGetInteger( ticket_ordem, DEAL_TYPE );
       
       if ( tipo_ordem ==  DEAL_TYPE_BUY || tipo_ordem ==  DEAL_TYPE_SELL )
          profit_ordens_soma += HistoryDealGetDouble( ticket_ordem, DEAL_PROFIT );
   }
   
   return NormalizeDouble( profit_ordens_soma, 2 );
}

double func_retorno_swap( int swap_compra, int swap_venda )
{
   
   double swapL = NormalizeDouble ( SymbolInfoDouble ( _Symbol, SYMBOL_SWAP_LONG ), 2 );
   double swapS = NormalizeDouble ( SymbolInfoDouble ( _Symbol, SYMBOL_SWAP_SHORT ), 2 );
   double retorno = 0.0;
   
   if ( swap_compra == 1 )
   {
      retorno = swapL;    
   }
   else if ( swap_venda == 1 )
   {
      retorno = swapS; 
   } 
   
   return retorno;
}

double func_total_resgate()
{
     ulong  ticket     = 0;
     int    tipo       = 0;
     double valor      = 0.0;
     double soma_valor = 0;
     string simbolo    = ""; 
     
     HistorySelect( 0, TimeCurrent() );

     for ( int i = 0; i <= HistoryDealsTotal() - 1; i++ )
     {
          ticket = HistoryDealGetTicket( i );
          tipo    = HistoryDealGetInteger( ticket, DEAL_TYPE );
          valor   = HistoryDealGetDouble ( ticket, DEAL_PROFIT );
          simbolo = HistoryDealGetString ( ticket, DEAL_SYMBOL );
             
          if ( tipo == DEAL_TYPE_BALANCE && valor < 0 && simbolo == "" )
          {  
             soma_valor += valor;
          }     
     }
     return ( soma_valor * ( -1 ) );
}

double func_total_depositado()
{
     ulong  ticket  = 0;
     int tipo       = 0;
     double valor = 0.0;
     double soma_valor = 0;
     
     HistorySelect( 0, TimeCurrent() );

     for ( int i = 0; i <= HistoryOrdersTotal() - 1; i++ )
     {
          ticket = HistoryDealGetTicket( i );
          HistoryDealSelect( ticket );
          tipo = HistoryDealGetInteger( ticket, DEAL_TYPE );
          valor = HistoryDealGetDouble( ticket ,DEAL_PROFIT );
          
          if ( tipo == DEAL_TYPE_BALANCE && valor > 0 )
          {  
             soma_valor += valor;
          }     
     }
     return soma_valor;
}

double func_ultimo_deposito()
{
     ulong  ticket  = 0;
     int    tipo    = 0;
     double ultimo_deposito = 0.0;
     double valor   = 0.0;
     
     HistorySelect( 0, TimeCurrent() );
     int total_orders = HistoryDealsTotal();
                        
     for ( int i = total_orders-1; i >= 0; i-- )
     {
          ticket = HistoryDealGetTicket( i ); // Se falhar , retorna 0.
          if ( ticket > 0 )
             ticket = HistoryDealGetTicket( i );
             HistoryDealSelect( ticket );
             tipo   = HistoryDealGetInteger( ticket, DEAL_TYPE );
             valor  = HistoryDealGetDouble ( ticket, DEAL_PROFIT );
             // regras.
             if ( valor > 0 && tipo == DEAL_TYPE_BALANCE )
               ultimo_deposito = valor; 
     }
     return ultimo_deposito;
}

// Se po parâmtro ficar 0, então retorna valor do pip da última ordem.
double retorna_valor_pip( double LotSize = 0 )
{
    double retorno = 0.0;
    
    if ( LotSize > 0 )
       retorno = ((((SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_VALUE))*_Point)/(SymbolInfoDouble(Symbol(),SYMBOL_TRADE_TICK_SIZE))) * LotSize);
    else  
        retorno = (((SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_VALUE))*_Point)/(SymbolInfoDouble(Symbol(),SYMBOL_TRADE_TICK_SIZE)));
      
    return NormalizeDouble ( retorno, 2 );
}

// ( breakeven )
bool func_preservar_capital( int preservar_capital = 50, int magic_number = 0 )
{
    
    double stop_ordem     = 0.0;
    double preco_abertura = 0.0;
    double comissao_ordem = 0.0;
    double swap_ordem     = 0.0;
    long   ticket         = 0.0;
    int    tipo_ordem     = 0;
    double preco_corrente = PositionGetDouble( POSITION_PRICE_CURRENT );
    double lote_entrada   = 0.0;
    double take_profit    = PositionGetDouble( POSITION_TP );
    string simbolo_ordem  = "";   
    
    for ( int i = 0; i < PositionsTotal(); i++ )
    {      
           
           ticket = PositionGetTicket( i );
           PositionSelectByTicket ( ticket );
                 
           // Selecionando valores da orden.
           
           simbolo_ordem  = PositionGetString ( POSITION_SYMBOL );
           if ( simbolo_ordem != Symbol() ) continue;
           preco_abertura = PositionGetDouble ( POSITION_PRICE_OPEN );
           //comissao_ordem = cposinfo.Commission();
           swap_ordem     = PositionGetDouble ( POSITION_SWAP );
           tipo_ordem     = PositionGetInteger( POSITION_TYPE );
           stop_ordem     = PositionGetDouble ( POSITION_SL );
           lote_entrada   = PositionGetDouble ( POSITION_VOLUME );        
           
           // Diferença de pontos entre abertura e preço corrente.
           double diff      = ( ( preco_abertura - preco_corrente ) / _Point );
           if ( diff < 0 ) diff = diff * ( -1 );
           double breakeven = 0.0; // contém o novo preço do stopLoss.    
           
           if ( tipo_ordem  ==  ORDER_TYPE_BUY  && 
                diff >= preservar_capital       &&
                preco_corrente > preco_abertura &&
                stop_ordem < preco_abertura )
           {
              printf("Tentativa Entrada BreakEven p/ Compra...: ");
              breakeven = ( preco_abertura + ( 10 * _Point ) );
              ctrade.PositionModify( ticket, breakeven, take_profit );
              printf(ctrade.ResultRetcode() );
           }
           if ( tipo_ordem  ==  ORDER_TYPE_SELL  && 
                diff >= preservar_capital        &&
                preco_corrente < preco_abertura  &&
                stop_ordem > preco_abertura )
           {
               printf("Tentativa Entrada BreakEven p/ Venda...: "); 
               breakeven = ( preco_abertura - ( 10 * _Point ) );
               ctrade.PositionModify( ticket, breakeven, take_profit );
               printf( ctrade.ResultRetcode() );
           }   
           
    } // FOR p/ busca das ordens.     
    return false;            
}

bool func_trailling_stop( int param_tralling_stop, int step_loss, int magic_number )
{

    long   order_ticket   = 0;
    double preco_abertura = 0.0;
    double preco_corrente = 0.0;  
    double stop_loss      = 0.0;
    double take_profit    = 0.0;
    double stop_level     = SymbolInfoInteger( _Symbol, SYMBOL_TRADE_STOPS_LEVEL );  
    int    tipo_ordem     = 0;
     
    // Se trailling é 0, então sair.
    if ( param_tralling_stop <= 0 ) return false;
    if ( param_tralling_stop < stop_level ) param_tralling_stop = stop_level;
    
    for ( int i = PositionsTotal() - 1; i >= 0; i-- )
    {
        if (  magic_number != PositionGetInteger( POSITION_MAGIC ) )
            continue;
             
        // Selecionando dados fundamentais da ordem.
        order_ticket   = PositionGetTicket( i );
        OrderSelect( order_ticket );
        stop_loss      = PositionGetDouble ( POSITION_SL );
        preco_abertura = PositionGetDouble ( POSITION_PRICE_OPEN );
        preco_corrente = PositionGetDouble ( POSITION_PRICE_CURRENT ); // Preço corrente do ativo. 
        take_profit    = PositionGetDouble ( POSITION_TP );    
        tipo_ordem     = PositionGetInteger( POSITION_TYPE ); 
             
        // Calculando a diferença do preço de abertura e o preço corrente.
        int diff = ( ( preco_corrente - preco_abertura ) / _Point );
         
        // Verificando se a diferença entre( entrada e definição de trailling_stop correspondem ).
        bool result_diff_compra = false;
        if ( tipo_ordem == ORDER_TYPE_BUY && diff >= param_tralling_stop )
        {  
           result_diff_compra = true;
        }

        bool result_diff_venda = false;
        if ( tipo_ordem == ORDER_TYPE_SELL && diff < 0 && ( diff * ( -1 ) >= param_tralling_stop ) )
        {
           result_diff_venda = true;
        }
            
        // Alterando a posição de preço do stopLoss e setando na nova posição. 
        if ( result_diff_compra == true && diff > 0 )
        {   
            stop_loss = ( stop_loss + ( 1 * _Point ) );         
            ctrade.PositionModify( order_ticket, stop_loss, take_profit );                   
        }
    }
    return false;
}

void func_abrir_ordem()
{

    if ( str_abertura_ordem.type == ORDER_TYPE_BUY )
    {   
        
        bool res = ctrade.Buy( str_abertura_ordem.volume, 
                               str_abertura_ordem.symbol, 
                               str_abertura_ordem.price,
                               str_abertura_ordem.sl, 
                               str_abertura_ordem.tp,"Painel_entrada_v1.0" );
        if ( !res )
        {
           Alert("Entrada Buy não pode ser finalizada, error : "+GetLastError());
        }                       
     
    }else if ( str_abertura_ordem.type == ORDER_TYPE_SELL ){
        
        bool res = ctrade.Sell( str_abertura_ordem.volume, 
                                str_abertura_ordem.symbol, 
                                str_abertura_ordem.price,
                                str_abertura_ordem.sl, 
                                str_abertura_ordem.tp,"Painel_entrada_v1.0" );
        if ( !res )
        {
           Alert("Entrada Sell não pode ser finalizada, error : "+GetLastError());
        }
    }  
}

/* Variáveis externa nesta função :
    - 
   

*/
double func_calculo_lote( bool usar_margem_livre)  
{
    // Casas decimais do Browker.
    double points = _Point;  
    double digits = _Digits;
    // Selecionando a moeda da conta.
    string moeda_corrent = AccountInfoString( ACCOUNT_CURRENCY );
    double freeMargem = 0.0;
    // Verificando a escolha de usar o valor livre da margem ou o valor do balanço p/ o cálculo.
    if ( usar_margem_livre == true )
    {
       freeMargem = AccountInfoDouble( ACCOUNT_MARGIN_FREE );
    }
    else
    {
       freeMargem = AccountInfoDouble( ACCOUNT_BALANCE );
    }
    // Calculando o valor do Pip.
    //double PipValue = ((((SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_VALUE))*point)/(SymbolInfoDouble(Symbol(),SYMBOL_TRADE_TICK_SIZE))) * LotSize);
    double PipValue = (((SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_VALUE))*points)/(SymbolInfoDouble(Symbol(),SYMBOL_TRADE_TICK_SIZE)));
    
    // Formula p/ obter o Lote.
    double lote = percentagem_entrada_param * freeMargem / ( PipValue * stop_loss_param );
    // Truncando o lote p/ 2 casas decimais.
    lote = floor( lote * 100 ) / 100;
    
    return lote;
}

/* Se 'lucro_preju' =  0 - retorna soma negativas.
   Se 'lucro_preju' =  1 - retorna somas positivas. 
   Se 'lucro_preju' =  2 - retorna a soma de todas as ordens do dia. 
*/   
double func_lucro_preju_diario( int lucro_preju )
{
   
   datetime    inicio     = ( TimeGMT() - ( TimeGMT() - TimeLocal() ) );
   MqlDateTime str_inicio; 
   TimeToStruct( inicio, str_inicio );
   str_inicio.hour= 0;
   str_inicio.min = 0;
   str_inicio.sec = 0;
   inicio = StructToTime( str_inicio );
   
   datetime    fim        = ( TimeGMT() - ( TimeGMT() - TimeLocal() ) );
   MqlDateTime str_fim;
   TimeToStruct( fim, str_fim );
   str_fim.hour= 23;
   str_fim.min = 59;
   str_fim.sec = 59;
   fim = StructToTime( str_fim );
   
   HistorySelect( inicio, fim );
   
   ulong  ordem_ticket = 0;   
   double profit       = 0.0;
   double soma_negat   = 0.0;
   double soma_posit   = 0.0;
   double soma_total   = 0.0;
   int    tipo_ordem   = 0;
    
   for ( int i = 0; i <= HistoryDealsTotal(); i++ )
   {
       ordem_ticket = HistoryDealGetTicket ( i );  
       profit       = HistoryDealGetDouble ( ordem_ticket, DEAL_PROFIT );
       tipo_ordem   = HistoryDealGetInteger( ordem_ticket, DEAL_TYPE );
       
       if ( tipo_ordem == DEAL_TYPE_BUY || tipo_ordem == DEAL_TYPE_SELL )
       {
          if ( profit > 0 )     soma_posit += profit;
          else if ( profit < 0 )soma_negat += profit;
          soma_total += profit; 
       }
   }
    
   if ( lucro_preju == 0 )       return NormalizeDouble( soma_negat, 2 );
   else if ( lucro_preju == 1 )  return NormalizeDouble( soma_posit, 2 );
   else if ( lucro_preju == 2 )  return NormalizeDouble( soma_total, 2 );
   
   return 0.0;   
} 

double func_lucro_preju_semanal( int lucro_preju )
{
   
   datetime    inicio     = ( ( TimeGMT() - ( TimeGMT() - TimeLocal() ) ) - 604800 );
   MqlDateTime str_inicio; 
   TimeToStruct( inicio, str_inicio );
   str_inicio.hour= 0;
   str_inicio.min = 0;
   str_inicio.sec = 0;
   inicio = StructToTime( str_inicio );
   
   datetime    fim        = ( TimeGMT() - ( TimeGMT() - TimeLocal() ) );
   MqlDateTime str_fim;
   TimeToStruct( fim, str_fim );
   str_fim.hour= 0;
   str_fim.min = 0;
   str_fim.sec = 0;
   fim = StructToTime( str_fim );    
   HistorySelect( inicio, fim ); 
   
   ulong  ordem_ticket = 0;   
   double soma_profit  = 0.0;
   double soma_stop    = 0.0;
   double profit_ordem = 0.0;
   double soma_total   = 0.0;
   
   for ( int i = 0; i <= HistoryDealsTotal(); i++ )
   {
       ordem_ticket = HistoryDealGetTicket( i );  
       profit_ordem = HistoryDealGetDouble( ordem_ticket, DEAL_PROFIT );
       soma_total   += profit_ordem;
       
       if ( profit_ordem > 0 ) soma_profit += soma_profit;
       soma_stop += soma_profit; 
       soma_total += soma_profit;          
   }
   
   if ( lucro_preju == 1 )       return NormalizeDouble( soma_profit, 2 );
   else if ( lucro_preju == 0 )  return NormalizeDouble( soma_stop,   2 );
   else if ( lucro_preju == -1 ) return NormalizeDouble( soma_total,  2 );
   
   return 0.0;   
}

int func_ordens_positivas_atual()
{
     int    total_ordens = PositionsTotal();
     int    cont_ordens_positivas = 0;
     double profit_ordem = 0.0;
     ulong  ticket_ordem = 0;
     int    tipo_ordem   = 0;
         
     for ( int i = 0; i < total_ordens; i++ )
     {
         ticket_ordem = PositionGetTicket( i ); 
         OrderSelect( ticket_ordem );
         profit_ordem = PositionGetDouble( POSITION_PROFIT );
         tipo_ordem   = PositionGetInteger( POSITION_TYPE );  
         
         if ( tipo_ordem == POSITION_TYPE_BUY || tipo_ordem == POSITION_TYPE_SELL )
         {
            if ( profit_ordem > 0 )
               cont_ordens_positivas += 1;
         } 
     }
     
     return cont_ordens_positivas;   
}

int func_ordens_negativas_atual()
{
    int    total_ordens = PositionsTotal();
    int    cont_ordens_negativas = 0;
    double profit_ordem = 0.0;
    ulong  ticket_ordem = 0;
    int    tipo_ordem   = 0;
     
     for ( int i = 0; i < total_ordens; i++ )
     {
         ticket_ordem = PositionGetTicket( i ); 
         OrderSelect( ticket_ordem );
         profit_ordem =  PositionGetDouble( POSITION_PROFIT );
         tipo_ordem   =  PositionGetInteger( POSITION_TYPE );
         
         if ( tipo_ordem == POSITION_TYPE_BUY || tipo_ordem == POSITION_TYPE_SELL ) 
         {
             if ( profit_ordem < 0 )
                cont_ordens_negativas += 1;
         }
     }
     
     return cont_ordens_negativas;
}

// Se 'take_stop' igual a 1 é take senão é stop.
int func_atualiza_take_diario( int take_stop )
{
   ulong  ticket           = 0;
   int    contador_take    = 0;
   int    contador_stop    = 0;
   double profit_ordem     = 0.0;
   int    tipo_ordem       = 0;
   
   datetime    inicio     = TimeLocal() + 10800;
   MqlDateTime str_inicio; 
   TimeToStruct( inicio, str_inicio );
   str_inicio.hour= 0;
   str_inicio.min = 0;
   str_inicio.sec = 0;
   inicio = StructToTime( str_inicio );
   
   datetime    fim        = TimeLocal() + 10800;
   MqlDateTime str_fim;
   TimeToStruct( fim, str_fim );
   str_fim.hour= 23;
   str_fim.min = 59;
   str_fim.sec = 59;
   fim = StructToTime( str_fim );
   
   HistorySelect( inicio, fim );
    
   for ( int i = 0; i <= HistoryDealsTotal(); i++ )
   {
       ticket       = HistoryDealGetTicket( i );
       profit_ordem = HistoryDealGetDouble( ticket, DEAL_PROFIT );
       tipo_ordem   = HistoryDealGetInteger( ticket, DEAL_TYPE );    
       
       if ( tipo_ordem == DEAL_TYPE_BUY || tipo_ordem == DEAL_TYPE_SELL  )
       {
          if ( profit_ordem > 0 )      contador_take += 1;
          else if ( profit_ordem < 0 ) contador_stop += 1; 
       }
   }
   
   if ( take_stop == 1 )     return contador_take;
   else if ( take_stop == 0 )return contador_stop;   
   
   return 0; 
}

// 0 - retorna soma total das ordens.
// 1 - retorna soma das ordens positivas.
// 2 - retorna soma das ordens negativas.
double func_retorno_lucro_preju_and( int param )
{
    int    total_ordens      = PositionsTotal();
    double soma_ordens_todas = 0.0;
    int    tipo_ordem        = 0;
    ulong  ticket_ordem      = 0;  
    double soma_ordens_posit = 0.0;
    double soma_ordens_negat = 0.0;
    double profit            = 0.0;
    
    for ( int i = 0; i < total_ordens; i++ )
    {
         ticket_ordem = PositionGetTicket( i ); 
         OrderSelect( ticket_ordem );
         tipo_ordem   = PositionGetInteger( POSITION_TYPE );
         profit       = PositionGetDouble ( POSITION_PROFIT );     
         
         if ( tipo_ordem == POSITION_TYPE_BUY || tipo_ordem == POSITION_TYPE_SELL )
         {
            if ( profit > 0 ) soma_ordens_posit += profit;
            if ( profit < 0 ) soma_ordens_negat += profit;
            soma_ordens_todas += profit;
         }
            
    }                           
    
    if ( param == 0 )     return soma_ordens_todas;
    else if ( param == 1 )return soma_ordens_posit;
    else if ( param == 2 )return soma_ordens_negat;
    
    return 0.0;
}

string retorna_tipo_conta()
{
    ENUM_ACCOUNT_TRADE_MODE account_type=( ENUM_ACCOUNT_TRADE_MODE )AccountInfoInteger( ACCOUNT_TRADE_MODE ); 
    string tipo_conta = "";
    
    switch( account_type )
    {
        case ACCOUNT_TRADE_MODE_DEMO:
        tipo_conta = "DEMO";
        break;
        
        case ACCOUNT_TRADE_MODE_CONTEST:
        tipo_conta = "TORNEIO";
        break;
        
        case ACCOUNT_TRADE_MODE_REAL:
        tipo_conta = "REAL";
        break;
        
        default: 
        tipo_conta = "?";
        break;
        
     }
  return tipo_conta;     
}

bool analize_regras_abrir_ordem()
{    
    bool retorno = true;    
    
    // ------------------- Verificando Stoploss e TakeProfit Mínimos -------------------.
    
    double stop_level = SymbolInfoInteger( _Symbol, SYMBOL_TRADE_STOPS_LEVEL );
    
    bool res_loss   = ( take_profit_param < stop_level ) ? false : true;
    bool res_profit = ( stop_loss_param < stop_level   ) ? false : true;
    
    if ( res_loss == false || res_profit == false )
    {
       if ( res_loss == false && res_profit == false )
       {
          retorno = false;
          Alert("Take Profit e StopLos falha distância mínima, Erro : "+GetLastError());
       }  
       else if ( res_loss == false )
       {
           retorno = false;
           Alert("StopLos falha distância mínima,              Erro : "+GetLastError());
       }
       else if ( res_profit == false )
       {
           retorno = false;
           Alert("takeProfit falha distância mínima,           Erro : "+GetLastError());
       }
    }
    
    // --------------------- Analizando se tem capital -----------------------
    
    /*
    bool res_check = OrderCheck( str_abertura_ordem, str_abertura_result );
    if ( res_check == false )
    {
       retorno = false;
       Alert( "Não tem capital suficiente, Erro : "+GetLastError() );
    }
    */
    
    return retorno;    
}  

void inicializa_estrutura_abertura( int buy_sell )
{

    MqlTick last_ticket;
    SymbolInfoTick ( _Symbol, last_ticket );
    double preco_entrada = 0.0; 
    if ( buy_sell == ORDER_TYPE_BUY )
       preco_entrada = last_ticket.ask;
    else    
       preco_entrada = last_ticket.bid;
    
    str_abertura_ordem.action      = TRADE_ACTION_DEAL;    // Tipo de operação de negociação.     
    str_abertura_ordem.magic       = magic_number;         // Expert Advisor -conselheiro- ID (número mágico)
    str_abertura_ordem.order       = 0;                    // Bilhetagem da ordem
    str_abertura_ordem.symbol      = Symbol();              // Símbolo de negociação
    str_abertura_ordem.volume      = func_calculo_lote( false );  // Calcula volume de acordo com calculo de percentagem. 
    str_abertura_ordem.price       = preco_entrada;        // Preço
    str_abertura_ordem.stoplimit   = 0.0;                  // Nível StopLimit da ordem( PREÇO )
    str_abertura_ordem.sl          = stop_price_param;     // Nível Stop Loss da ordem( PREÇO )
    str_abertura_ordem.tp          = take_price_param;     // Nível Take Profit da ordem
    str_abertura_ordem.deviation   = 20;                   // Máximo desvio possível a partir do preço requisitado
    str_abertura_ordem.type        = buy_sell;             // Tipo de ordem
    str_abertura_ordem.type_filling= ORDER_FILLING_FOK;    // Tipo de execução da ordem
    str_abertura_ordem.type_time   = last_ticket.time;     // Tipo de expiração da ordem
    str_abertura_ordem.expiration  = 0;                    // Hora de expiração da ordem (para ordens do tipo ORDER_TIME_SPECIFIED))
    str_abertura_ordem.comment     = "Painel_entrada_v1.0";// Comentário sobre a ordem
    str_abertura_ordem.position    = 0;                    // Bilhete da posição
    str_abertura_ordem.position_by = 0;                    // Bilhete para uma posição oposta
}

void converte_take_stop_preco( ENUM_ORDER_TYPE buy_sell )
{
   
    if ( buy_sell == ORDER_TYPE_BUY )
    {
       take_price_param = NormalizeDouble( SymbolInfoDouble ( Symbol(), SYMBOL_ASK ) + take_profit_param * _Point, _Digits);
       stop_price_param = NormalizeDouble( SymbolInfoDouble ( Symbol(), SYMBOL_ASK ) - stop_loss_param   * _Point, _Digits);
    }
    else if ( buy_sell == ORDER_TYPE_SELL )
    {
       take_price_param = NormalizeDouble( SymbolInfoDouble ( Symbol(), SYMBOL_ASK ) - take_profit_param * _Point, _Digits);
       stop_price_param = NormalizeDouble( SymbolInfoDouble ( Symbol(), SYMBOL_ASK ) + stop_loss_param   * _Point, _Digits);
    }

}

// Atualizando as variáveis globais.
void func_atualiza_variaveis_globais()
{
    // Paínel esquerdo.
    simbolo_painel_esquerdo                 = _Symbol;
    tipo_conta_painel_esquerdo              = retorna_tipo_conta();
    valor_pip_painel_esquerdo               = retorna_valor_pip();
    lucro_andamento_painel_esquerdo         = func_retorno_lucro_preju_and( 1 );
    lucro_diario_painel_esquerdo            = func_lucro_preju_diario( 1 );
    lucro_semanal_painel_esquerdo           = func_lucro_preju_semanal( 1 );
    lucro_menssal_painel_esquerdo           = func_lucro_preju_menssal();
    total_depositado_painel_esquerdo        = func_total_depositado();
    total_regate_painel_esquerdo            = func_total_resgate();
    ultimo_deposito_painel_esquerdo         = func_ultimo_deposito();
    ordens_positivas_atuais_painel_esquerdo = func_ordens_positivas_atual();
    ordens_negativas_atuais_painel_esquerdo = func_ordens_negativas_atual();
    profit_positivo_diario_painel_esquerdo  = func_lucro_preju_diario( 1 );
    profit_negativo_diario_painel_esquerdo  = func_lucro_preju_diario( 0 );
    num_ordens_take_diario_painel_esquerdo  = func_atualiza_take_diario( 1 );  
    num_ordens_stop_diario_painel_esquerdo  = func_atualiza_take_diario( 0 );
    
    // Var's retângulo.
    profit_positivo_and_retangulo = func_retorno_lucro_preju_and( 1 );
    profit_negativo_and_retangulo = func_retorno_lucro_preju_and( 0 );
    profit_total_convert_retangulo= func_retorno_lucro_preju_and( 2 ) * cotacao_dolar;

    // Paínel direito.
    spread_painel_direito            = SymbolInfoInteger( Symbol(), SYMBOL_SPREAD );        
    swap_comprado_painel_direito     = SymbolInfoDouble( Symbol(), SYMBOL_SWAP_LONG );
    swap_vendido_painel_direito      = SymbolInfoDouble( Symbol(), SYMBOL_SWAP_SHORT );
    falta_char_candle_painel_direito = func_novo_candle();
    
    // Variáveis que precisam ser zeradas, quando não tem mais ordens abertas.
    func_zerando_variaveis();
    
}

// retorna valor monetário do StopLoss ou TakeProfit.
// 1 para take.
// 0 para stop
double retorna_valor_monetario_sl_tp( int take_stop, ENUM_ORDER_TYPE buy_sell )
{
     double var_resultado    = 0.0;
     double preco_fechamento = 0.0;
     double preco_abertura   = 0.0;

     if ( take_stop == 1 ) 
       preco_fechamento = take_price_param;  
     else
       preco_fechamento = stop_price_param;
     if ( buy_sell == ORDER_TYPE_BUY )
       preco_abertura = SymbolInfoDouble(Symbol(),SYMBOL_ASK);
     else 
       preco_abertura = SymbolInfoDouble(Symbol(),SYMBOL_BID);
        
         
     bool res = OrderCalcProfit( buy_sell, 
                      Symbol(),
                      func_calculo_lote( false ), 
                      preco_abertura,
                      preco_fechamento, 
                      var_resultado );                    
     
     return var_resultado;
}

/* Zerando variáveis quando não tiver mais ordens. */
void func_zerando_variaveis()
{
   
   double orders_total = 0.0;
   orders_total        = OrdersTotal(); 
   
   if ( orders_total == 0 && str_abertura_ordem.symbol != NULL )
   {
      ZeroMemory ( str_abertura_ordem  );
      ZeroMemory ( str_abertura_result );

   }
}

void setando_take_stop_ordens_externas( int take = 300, int stop = 80 )
{

    int magic_n = 0;
    int vet_ticket [ 100 ];
    int indice_vet_ticket = 0;
    
    for ( int i = 0; i < PositionsTotal(); i++ )
    {
       ulong ticket = PositionGetTicket ( i );
       PositionSelectByTicket ( ticket );
       int magic_n = PositionGetInteger ( POSITION_MAGIC );
       int take    = PositionGetDouble  ( POSITION_TP ); 
       int stop    = PositionGetDouble  ( POSITION_SL );
       if ( take == 0 && stop == 0 )
       {
          vet_ticket [ indice_vet_ticket ] = ticket;
          indice_vet_ticket += 1; 
       }   
    }
    
    // Selecionando os tickets do vetor p/ atualzar.
    for ( int i = 0; vet_ticket [ i ] != 0; i++ )
    {
        ulong ticket = vet_ticket [ i ];
        PositionSelectByTicket ( ticket );
        int    tipo_ordem    = PositionGetInteger ( POSITION_TYPE );
        double preco_entrada = PositionGetDouble  ( POSITION_PRICE_OPEN );
        
        if ( tipo_ordem == ORDER_TYPE_BUY )
        {
          take_price_param = NormalizeDouble( preco_entrada + take * _Point, _Digits);
          stop_price_param = NormalizeDouble( preco_entrada - stop * _Point, _Digits);
        }
        else if ( tipo_ordem == ORDER_TYPE_SELL )
       {
          take_price_param = NormalizeDouble( preco_entrada - take * _Point, _Digits);
          stop_price_param = NormalizeDouble( preco_entrada + stop * _Point, _Digits);
       }
    
       ctrade.PositionModify       ( ticket, stop_price_param, take_price_param );
       
    } 
}

// Retorna o primeiro índice do arry cujo valor é igual ao valor procurado.
int func_retorna_indice_array ( long value, long &array[] )
{
    long value_array = 0;
    
    for ( int i = 0; i < ArraySize ( array ); i++ )
    {
       value_array = array [ i ];
       if ( value_array == value )
       {
          return i;
       }
    }
    return -1; 
}