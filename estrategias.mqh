//+------------------------------------------------------------------+
//|                                                  estrategias.mqh |
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
  
  // Analiza se uma ordem acabou de ser aberta ou fechada.
  func_uma_ordem_foi_aberta    ()
  func_uma_ordem_foi_fechada   ()
  
  // Preenche uma estrutura p/ ser enviada por email. 
  func_regras_envio_email()
  func_preenche_estrutura_email()
    
  // Abrir ordem.
  func_abrir_ordem_estrategia  ()
  
  // Funções complementares.
  fun_envia_email              () // Chamada p/ enviar email.
  inicializacoes_oninit        () // Variáveis setadas no escopo OnInit. 
  func_verifica_regras_gerais  () // Verifica todas as regras necessárias p/ abertura de ordens.
  
  // Funções de notícia.
  func_analiza_canlendario     () // Analize de regas das notícias p/ entrar.
  func_carrega_noticias        () // Carrega notícias do dia.
  
  // Funções de Estratégias.
  func_estrategia_mm_tres      ()
  
*/

// --------------------- Variáveis Globais relacionadas a notícias.             ---------
   
MqlCalendarValue   noticias_base  [];
MqlCalendarValue   noticias_cotaco[];
MqlCalendarCountry eventos_base;
MqlCalendarCountry eventos_cotacao; 
datetime           ultimo_tempo; // Guarda o último tempo que a notícia foi baixada.
   

// --------------------- Variáveis de referência p/ envio de histórico p/ email ---------

struct historico_ordens_email
{
    // ------------------ Estatísticas Conta. ------------------
    
    int    total_ordens_abertas_conta;
    string simbolo_ultima_ordem_fechada_conta;                     
    double profit_monetario_ultima_ordem_fechada_conta;
    
    // ------- As 10 últimas ordens. -------
    
    int    cont_positivas_conta;          
    int    cont_negativas_conta;          
    double profit_monetario_posit_conta;  
    double profit_monetario_negat_conta;
    
    // ------------------ Estatísticas Gráfico. ------------------
    
    int    total_ordens_abertas_robo;
    string simbolo_ultima_ordem_fechada_robo;                     
    double profit_monetario_ultima_ordem_fechada_robo;
    
    // ------- As 10 últimas ordens. -------
    
    int    cont_positivas_robo;          
    int    cont_negativas_robo;          
    double profit_monetario_posit_robo;  
    double profit_monetario_negat_robo;
                  
};

historico_ordens_email h_ordens_abertas;

// --------------------- Variáveis Globais controle ordens abertas e fechadas ---------
 
long vetor_ticket []; // Vetor que contém tickets das ordens abertas pelo robô.


// Analizando se as 
bool func_analiza_canlendario() 
{
    int size_base    = ArraySize ( noticias_base   );
    int size_cotacao = ArraySize ( noticias_cotaco );
    int max_niticias = MathMax   ( size_base, size_cotacao );    
    
    if ( size_base == 0 && size_cotacao == 0 )  
      return false;
      
    for ( int i = 0; i < max_niticias; i ++ )
    {  
       
       int nivel_importance = eventos[0].importance;
       
       if ( nivel_importance == CALENDAR_IMPORTANCE_MODERATE || // Importância Média.
            nivel_importance == CALENDAR_IMPORTANCE_HIGH )      // Importância Alta.
       {
          
            return true;          
       }
    } // for       
       
    return false;
}
 
void func_carrega_noticias ()
{

    /*
       MqlCalendarValue   noticias_base  [];
       MqlCalendarValue   noticias_cotaco[];
       MqlCalendarCountry eventos_base;
       MqlCalendarCountry eventos_cotacao; 
       datetime           ultimo_tempo; // Guarda o último tempo que a notícia foi baixada.
    */
            
    // Selecionando moeda Base e Cotação do gráfico.
    string base    = SymbolInfoString ( Symbol(), SYMBOL_CURRENCY_BASE );
    string cotacao = SymbolInfoString ( Symbol(), SYMBOL_CURRENCY_PROFIT );
    
    // Selecionando descrições do país.
    Calendar ( base,    eventos_base );
    CalendarEventByCountry ( cotacao, eventos_cotacao );
        
    if ( TimeCurrent() >= ultimo_tempo + 300  )
    {
       CalendarValueHistory ( noticias_base,TimeCurrent(), 0,eventos_base.code,base );
       CalendarValueHistory ( noticias_cotaco,TimeCurrent(), 0,eventos_cotacao.code,cotacao );
       ultimo_tempo = TimeCurrent();
    }
}

long func_retorna_


// Retorna true quando uma ordem for aberta.
bool func_uma_ordem_foi_aberta()
{
     int total_ordens = PositionsTotal();
     for ( int i = 0; i < total_ordens; i++ )
     {
         long ticket = PositionGetTicket ( i );
         PositionSelectByTicket ( ticket );
         string simbolo    = PositionGetString ( POSITION_SYMBOL );
         string comentario = PositionGetString ( POSITION_COMMENT );
                             
         if ( comentario == "Painel_entrada_v1.0_Auto" && simbolo == Symbol() )
         {  
            if ( ArraySize ( vetor_ticket ) == 0 )
              ArrayResize ( vetor_ticket, ArraySize ( vetor_ticket )+ 1, 0 ); 
            
            // Buscando o ticket no array global de ordens abertas. 
            int res = func_retorna_indice_array ( ticket, vetor_ticket );
            // Se o ticket não for encontrado.
            if ( res == -1 )  
            { 
              vetor_ticket [  ArraySize ( vetor_ticket ) -1 ] = ticket;
              return true;  
            }  
         }
     }
     return false;
}
// Retorna true quando uma ordem for fechada.
bool func_uma_ordem_foi_fechada()
{
    
    // Testando se os tickets do vetor ainda estão abertos.
    for ( int i = 0; i < ArraySize ( vetor_ticket ); i++ )
    {
       long ticket = vetor_ticket [ i ];
       bool res = PositionSelectByTicket ( ticket );
       if ( !res )
       {
          ArrayRemove ( vetor_ticket, i, 1 );
          return true;
       }
    }    
    return false;
}

// Analize de regras p/ envio de email.
void func_regras_envio_email()
{
    
    if ( func_uma_ordem_foi_aberta () == true || func_uma_ordem_foi_fechada() == true )
    {
       string assunto = "";
       if ( func_uma_ordem_foi_aberta () == true )                
       {
          assunto = " Robô Forex - Ordem Aberta. ";
          func_preenche_estrutura_email();
          bool res = fun_envia_email( assunto );
          if ( res )
            Alert ( " Email Enviada com Sucesso...( Ordem Aberta .)" );
          
       } 
       else if ( func_uma_ordem_foi_fechada () == true )
       {
          assunto = " Robô Forex - Ordem Fechada. ";
          func_preenche_estrutura_email();
          bool res = fun_envia_email( assunto );
          if ( res )
            Alert ( " Email Enviada com Sucesso...( Ordem Fechada .)" );  
       }         
    }     
}

void func_preenche_estrutura_email()
{

    int    total_historico       = 0;
    int    ticket                = 0;
    string simbolo_ultima_ordem  = "";
    double profit                = 0.0;                   
    // As 10 últimas ordens.
    int    cont_positivas        = 0;          
    int    cont_negativas        = 0;          
    double profit_monetario_posit= 0.0;  
    double profit_monetario_negat= 0.0;
    
    // total ordens gráfico
    int    total_ordens_grafico  = 0;
    string comentario_grafico    = "";
    
    // ----------------------Preenchendo dados Conta. --------------------
    
    h_ordens_abertas.total_ordens_abertas_conta = PositionsTotal();
    
    // Dados última Ordem.
    HistorySelect ( 0, TimeCurrent() );
    total_historico         = HistoryDealsTotal();
    ticket                  = HistoryDealGetInteger ( total_historico-1, DEAL_TICKET );
    simbolo_ultima_ordem    = HistoryDealGetString  ( ticket,            DEAL_SYMBOL );
    profit                  = HistoryDealGetDouble  ( ticket,            DEAL_PROFIT );                   
    h_ordens_abertas.simbolo_ultima_ordem_fechada_conta          = simbolo_ultima_ordem;                     
    h_ordens_abertas.profit_monetario_ultima_ordem_fechada_conta = profit;
    
    // As 10 últimas ordens fechadas.
    for ( int indice_dez = 0; indice_dez < 10; indice_dez++ )
    {
        total_historico = --total_historico;
        ticket = HistoryDealGetInteger ( total_historico, DEAL_TICKET );
        profit = HistoryDealGetDouble  ( ticket,          DEAL_PROFIT ); 
        if ( profit > 0 )
        {
          cont_positivas         += 1;
          profit_monetario_posit += profit;   
        }
        else if ( profit < 0 )
        {
          cont_positivas         += 1;
          profit_monetario_posit += profit;
        }  
    }
    h_ordens_abertas.cont_positivas_conta         = cont_positivas;          
    h_ordens_abertas.cont_negativas_conta         = cont_negativas;          
    h_ordens_abertas.profit_monetario_posit_conta = profit_monetario_posit;  
    h_ordens_abertas.profit_monetario_negat_conta = profit_monetario_negat;
    
    // ------------------ Estatísticas Gráfico. ------------------  
    
    // Dados última Ordem.
    HistorySelect ( 0, TimeCurrent() );
    total_historico = HistoryDealsTotal();
                      
    for ( int i = 0; i < total_historico; i++ )
    {
       total_historico = --total_historico;
       ticket               = HistoryDealGetInteger ( total_historico, DEAL_TICKET );
       simbolo_ultima_ordem = HistoryDealGetString  ( ticket,          DEAL_SYMBOL );
       profit               = HistoryDealGetDouble  ( ticket,          DEAL_PROFIT );
       comentario_grafico   = PositionGetString     ( POSITION_COMMENT             );  
       if ( simbolo_ultima_ordem == Symbol() && comentario_grafico == "Painel_entrada_v1.0_Auto" ) 
       {
          h_ordens_abertas.simbolo_ultima_ordem_fechada_robo          = simbolo_ultima_ordem;                     
          h_ordens_abertas.profit_monetario_ultima_ordem_fechada_robo = profit;
          break; 
       } 
    }
    
    // Total ordens Abertas.
    for ( int i = 0; i < PositionsTotal(); i++ )
    {
       PositionGetTicket ( i );
       simbolo_ultima_ordem    = PositionGetString ( POSITION_SYMBOL  );
       comentario_grafico      = PositionGetString ( POSITION_COMMENT );
       if ( simbolo_ultima_ordem == Symbol() && comentario_grafico == "Painel_entrada_v1.0_Auto" )
       {
          total_ordens_grafico += 1;
       } 
    } 
    h_ordens_abertas.total_ordens_abertas_robo = total_ordens_grafico;
    
    // As 10 últimas ordens.
    for ( int indice_dez = 0; indice_dez < 10; indice_dez++ )
    {
        total_historico = --total_historico;
        ticket = HistoryDealGetInteger ( total_historico, DEAL_TICKET );
        profit = HistoryDealGetDouble  ( ticket,          DEAL_PROFIT ); 
        if ( profit > 0 )
        {
          cont_positivas         += 1;
          profit_monetario_posit += profit;   
        }
        else if ( profit < 0 )
        {
          cont_negativas         += 1;
          profit_monetario_negat += profit;
        }  
    }
    h_ordens_abertas.cont_positivas_robo         = cont_positivas;          
    h_ordens_abertas.cont_negativas_robo         = cont_negativas;          
    h_ordens_abertas.profit_monetario_posit_robo = profit_monetario_posit;  
    h_ordens_abertas.profit_monetario_negat_robo = profit_monetario_negat;    
}

bool fun_envia_email( string assunto )
{
   
  bool res = SendMail ( assunto,
                        // ------------------ Estatísticas Conta. --------------------
                        "\n---------- Estatísticas Conta. --------------------"+
                        "\n\nTotal Odens                     : "+h_ordens_abertas.total_ordens_abertas_conta+
                        "\nSímbolo Última Ordem Fechada      : "+h_ordens_abertas.simbolo_ultima_ordem_fechada_conta+                     
                        "\nProfit ùltima Ordem fechada       : "+h_ordens_abertas.profit_monetario_ultima_ordem_fechada_conta+
                        // ------- As 10 últimas ordens. -------
                        "\nNúm. Ordens dez Últimas Positivas : "+h_ordens_abertas.cont_positivas_conta+          
                        "\nNúm. Ordens dez Últimas Negativas : "+h_ordens_abertas.cont_negativas_conta+          
                        "\nPofit Somado dez Últimas positivas: "+h_ordens_abertas.profit_monetario_posit_conta+  
                        "\nPofit Somado dez Últimas positivas: "+h_ordens_abertas.profit_monetario_negat_conta+
                        // ------------------ Estatísticas Gráfico. ------------------
                        "\n\n---------- Estatísticas Gráfico. ----------------"+
                        "\n\nTotal Odens                       : "+h_ordens_abertas.total_ordens_abertas_robo+
                        "\nSímbolo Última Ordem Fechada      : "+h_ordens_abertas.simbolo_ultima_ordem_fechada_robo+                     
                        "\nProfit ùltima Ordem fechada       : "+h_ordens_abertas.profit_monetario_ultima_ordem_fechada_robo+
                        // ------- As 10 últimas ordens. -------
                        "\nNúm. Ordens dez Últimas Positivas : "+h_ordens_abertas.cont_positivas_robo+          
                        "\nNúm. Ordens dez Últimas Negativas : "+h_ordens_abertas.cont_negativas_robo+          
                        "\nPofit Somado dez Últimas positivas: "+h_ordens_abertas.profit_monetario_posit_robo+  
                        "\nPofit Somado dez Últimas Negativas: "+h_ordens_abertas.profit_monetario_negat_robo  );
    
    if ( res )
      return true;
      
   return false;   
}

// Inicializando/Setando variavéis elementos.
void inicializacoes_oninit()
{
    // Variáveis e configurações de inicialização de : func_estrategia_mm_tres () 
    ArraySetAsSeries ( mm_trinta_vet,    true );
    ArraySetAsSeries ( mm_cinquenta_vet, true );
    ArraySetAsSeries ( mm_cem_vet,       true );
    ArraySetAsSeries ( rates,            true );
      
}

// Avaliando regras gerais p/ entrar baseado em notícia.
bool func_verifica_regras_gerais()
{
 
    // Verificando se símbolo tem notícia.
    bool res = func_analiza_canlendario();
    // Se o símbolo não tem notícia, então removo do vetor.     
    if ( res )
      return true;                               
    
    return false;
} 

// ------------------ FUNÇÃO ABERTURA ORDEM ------------------------

// Função abrir ordem p/ estratégia.
void func_abrir_ordem_estrategia()
{
    
    
    int    dist_preco= 60;  
    double volume    = 0.90;
    
    // Associando distância ao preço de entrada.
    double pre_buy_dist    = SymbolInfoDouble ( Symbol(), SYMBOL_ASK ) + dist_preco * Point();
    double pre_sell_dist   = SymbolInfoDouble ( Symbol(), SYMBOL_BID ) - dist_preco * Point();
    
    double preco_buy       = NormalizeDouble ( pre_buy_dist, Digits() );
    double price_take_buy  = NormalizeDouble  ( ( preco_buy + 390 ) * _Point, Digits() );
    double price_stop_buy  = NormalizeDouble  ( ( preco_buy - 70  ) * _Point, Digits() );
    ctrade.BuyStop ( volume, preco_buy, Symbol(), price_take_buy, price_stop_buy,ORDER_TIME_GTC,0, "Painel_entrada_v1.0_Auto" );
   
   double preco_sell      = NormalizeDouble ( pre_sell_dist, Digits() );
   double price_take_sell = NormalizeDouble  ( ( preco_sell - 390 ) * _Point, Digits() );
   double price_stop_sell = NormalizeDouble  ( ( preco_sell + 70  ) * _Point, Digits() );
   ctrade.SellStop ( volume,preco_sell,Symbol(),price_take_sell,price_stop_sell,ORDER_TIME_GTC,0,"Painel_entrada_v1.0_Auto" );  
}


// ------------------- Funções de Estratégias. -------------------

/*
   Regras :
     - As médias tem que estar em ordem, todas apontando p/ cima ( Compra ) ou baixa ( Venda ).
     - O preço tem que estar acima da média de 50 p/ Compra ou abaixo Venda.
     - *** Ponto entrada : Candle 1 fecha acima da média de 50 se compra e abaixo se venda.
     - *** Ponto saída   : Acima ou abaixo do preço máximo ou mínimo dos últimos dez candles. 
*/
bool func_estrategia_mm_tres ( int buy_sell )
{   

    // Preenchendo vetorres c/ o dado do Índicador.
    CopyBuffer ( mm_trinta,    0, 0, 3, mm_trinta_vet    );
    CopyBuffer ( mm_cinquenta, 0, 0, 3, mm_cinquenta_vet );
    CopyBuffer ( mm_cem,       0, 0, 3, mm_cem_vet       ); 
    
    // Obtém dados do histórico de preços do gráfico e do período atual p/ a estrutura MqlRates.
    CopyRates ( Symbol(), Period(), 0, 3, rates );
    
    if ( buy_sell == ORDER_TYPE_BUY )
    {  
       // Verificando se as médias estão apontando para cima.
       if ( mm_cem_vet       [ 0 ] > mm_cem_vet       [ 2 ] &&
            mm_cinquenta_vet [ 0 ] > mm_cem_vet       [ 0 ] && mm_cinquenta_vet [ 0 ] > mm_cinquenta_vet [ 2 ]  &&
            mm_trinta_vet    [ 0 ] > mm_cinquenta_vet [ 0 ] && mm_trinta_vet    [ 0 ] > mm_trinta_vet    [ 2 ] )
       {
           // Candle Zero deve abrir abaixo da média de 50 e fechar acima.
           if ( rates [ 0 ].open < mm_cinquenta_vet [ 0 ] && rates [ 0 ].close > mm_cinquenta_vet [ 0 ] )
           {
              return true;
           }
       }     
    }
    if ( buy_sell == ORDER_TYPE_SELL )
    {
      // Verificando se as médias estão apontando para baixo.
      if (  mm_cem_vet       [ 0 ] < mm_cem_vet       [ 2 ] &&
            mm_cinquenta_vet [ 0 ] < mm_cem_vet       [ 0 ] && mm_cinquenta_vet [ 0 ] < mm_cinquenta_vet [ 2 ]  &&
            mm_trinta_vet    [ 0 ] < mm_cinquenta_vet [ 0 ] && mm_trinta_vet    [ 0 ] < mm_trinta_vet    [ 2 ] )         
      { 
         // Candle Zero deve abrir acima da média de 50 e fechar abaixo.
         if ( rates [ 0 ].open > mm_cinquenta_vet [ 0 ] && rates [ 0 ].close < mm_cinquenta_vet [ 0 ] )
         {
           return true;        
         }
      }
    }
    
    return false;   
}

 