//+------------------------------------------------------------------+
//|                                              Painel_entrada_v1.0 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

/*
   OBJETOS DISCRIMINADOS.
   
      * Paínel Esquerdo. ( Estatística )
        
        Simbolo               > label_obj_cp_simbolo             obj valor : label_obj_cp_valor_simbolo 
        tipo conta            > label_obj_cp_tipo_conta          obj valor : label_obj_cp_valor_tipoConta
        valor pip             > label_obj_cp_label_cp_valor_pip  obj valor : label_obj_cp_valor_valorPip
        lucro andamento       > label_obj_cp_lucro Andamento     obj valor : label_obj_cp_valor_lucroAndamento
        lucro diario          > label_obj_cp_lucro_Diario        obj valor : label_obj_cp_valor_lucroDiario
        lucro semanal         > label_obj_cp_lucro_semanal       obj valor : label_obj_cp_valor_lucroSemanal
        lucro menssal         > label_obj_cp_lucro_menssal       obj valor : label_obj_cp_valor_lucromenssal
        total depositado      > label_obj_cp_total_depositado    obj valor : label_obj_cp_valor_total_depositado
        ordens posit. atual   > label_obj_cp_total_resgate       obj valor : label_obj_cp_valor_total_resgate
        ordens negat. atual   > label_obj_cp_ultimo_deposito     obj valor : label_obj_cp_valor_ultimoDeposito
        profit. posit. diario > label_obj_cp_profit_posit_diário obj valor : label_obj_cp_valor_profitPositDiario 
        profit. negat. diario > label_obj_cp_profit_negat_diário obj valor : label_obj_cp_valor_profitNegatDiario
        ordens take diario    > label_obj_cp_ordens_take_diario  obj valor : label_obj_cp_valor_ordensTakeDiario
        ordens stop diario    > label_obj_cp_ordens_stop_diario  obj valor : label_obj_cp_valor_ordensStopDiario
        >>> profit conta <<<  > label_obj_cp_profit_conta_total  obj valor : label_obj_cp_valor_profit_conta_total
        
      * Retângulos
        Objeto retângulo positivo > obj_retangulo_positivo    valor : obj_label_positivo_retangulo
        Objeto retângulo negativo > obj_retangulo_negativo    valor : obj_label_negativo_retangulo  
        Objeto retângulo soma real> obj_retangulo_real_profit valor : obj_label_real_profit   
          
      * Paínel direito.
        spread          > label_spread       valor : label_spread_valor 
        swap compra     > label_swap_compra  valor : label_swap_compra_valor 
        swap venda      > label_swap_venda   valor : label_swap_venda_valor
        candle fecha em > label_novo_candle  valor : label_novo_candle_valor
        
      * Objetos parâmetros abertura de ordem.
        takeProfit    > label_especificacao_take   edit : obj_edit_take
        stopLoss      > label_especificacao_stop   edit : obj_edit_stop 
        traillingStop > label_trailling            edit : obj_edit_trailling 
        risco capital > obj_label_preservarCapital edit : obj_edit_risco_capital
        breakeven     > obj_label_preservarCapital edit : obj_edit_preservar_capital

      * Label's valor Take e valor Stop.
        label_valor_take
        label_valor_stop 
*/
#include <Trade/trade.mqh         >
#include <funcoes_comuns.mqh      >
#include <objetos_criados.mqh     >
#include <funcoes_fecha_ordens.mqh>
#include <indicadores.mqh         >
#include <estrategias.mqh         >


CTrade ctrade;

input int    magic_number  = 0;
input double cotacao_dolar = 0.0;

// Paínel esquerdo.
string simbolo_painel_esquerdo         = "";
string tipo_conta_painel_esquerdo      = "";
double valor_pip_painel_esquerdo       = 0.0;
double lucro_andamento_painel_esquerdo = 0.0;
double lucro_diario_painel_esquerdo    = 0.0;
double lucro_semanal_painel_esquerdo   = 0.0;
double lucro_menssal_painel_esquerdo   = 0.0;
double total_depositado_painel_esquerdo= 0.0;
double total_regate_painel_esquerdo    = 0.0;
double ultimo_deposito_painel_esquerdo = 0.0;
int    ordens_positivas_atuais_painel_esquerdo = 0;
int    ordens_negativas_atuais_painel_esquerdo = 0;
double profit_positivo_diario_painel_esquerdo  = 0.0;
double profit_negativo_diario_painel_esquerdo  = 0.0;
int    num_ordens_take_diario_painel_esquerdo  = 0;  
int    num_ordens_stop_diario_painel_esquerdo  = 0;

// Paínel direito.
int    spread_painel_direito            = 0;        
double swap_comprado_painel_direito     = 0.0;
double swap_vendido_painel_direito      = 0.0;
string falta_char_candle_painel_direito = "";

// Var's retângulo.
double profit_positivo_and_retangulo = 0.0;
double profit_negativo_and_retangulo = 0.0;
double profit_total_convert_retangulo= 0.0;

// Declarado estruturas e setando memória.
MqlTradeRequest str_abertura_ordem;      /*
                                           ENUM_TRADE_REQUEST_ACTIONS    action;           // Tipo de operação de negociação
                                           ulong                         magic;            // Expert Advisor -conselheiro- ID (número mágico)
                                           ulong                         order;            // Bilhetagem da ordem
                                           string                        symbol;           // Símbolo de negociação
                                           double                        volume;           // Volume solicitado para uma encomenda em lotes
                                           double                        price;            // Preço
                                           double                        stoplimit;        // Nível StopLimit da ordem
                                           double                        sl;               // Nível Stop Loss da ordem
                                           double                        tp;               // Nível Take Profit da ordem
                                           ulong                         deviation;        // Máximo desvio possível a partir do preço requisitado
                                           ENUM_ORDER_TYPE               type;             // Tipo de ordem
                                           ENUM_ORDER_TYPE_FILLING       type_filling;     // Tipo de execução da ordem
                                           ENUM_ORDER_TYPE_TIME          type_time;        // Tipo de expiração da ordem
                                           datetime                      expiration;       // Hora de expiração da ordem (para ordens do tipo ORDER_TIME_SPECIFIED))
                                           string                        comment;          // Comentário sobre a ordem
                                           ulong                         position;         // Bilhete da posição
                                           ulong                         position_by;      // Bilhete para uma posição oposta
                                         */
                                     
// Necessário para o uso do OrderSend().                                       
MqlTradeResult str_abertura_result;      /* uint         retcode;             // Código da resposta
                                            double       balance;             // Saldo após a execução da operação (deal)
                                            double       equity;              // Saldo a mercado (equity) após a execução da operação
                                            double       profit;              // Lucro flutuante
                                            double       margin;              // Requerimentos de Margem
                                            double       margin_free;         // Margem livre
                                            double       margin_level;        // Nível de margem
                                            string       comment;             // Comentário sobre o código da resposta (descrição do erro) 
                                         */

/* Parâmetros de entrada do paínel e variáveis associadas.
   Funções que setam valores nestas variáveis:
     - inicializa_obj_param_entrada ();
     - converte_take_stop_preco     ();
*/
int    take_profit_param         = 0;
double take_price_param          = 0.0;
int    stop_loss_param           = 0;
double stop_price_param          = 0.0;
int    trailling_stop_param      = 0;
int    preservar_capital_param   = 0;
double percentagem_entrada_param = 0;
double valor_monetario_take      = 0.0;
double valor_monetario_stop      = 0.0;

int OnInit()
{
      
   // funções criação de objetos.
   func_criacao_obj_painel();
   // Painel esquerdo estatístico.
   func_criacao_labels_pc();
   func_criacao_valores_pc(); // Label's( valores ) paínel esquerdo.
   // Botões de Fechamento.
   func_criacao_botoes_fechamento();
   func_criacao_obj_painel_entrada();
   
   // ------------------------------------
   
   func_criacao_label_take();
   func_criacao_label_stop();
   func_criacao_label_trailling();
   func_criacao_label_preservar_capital();
   
   // ------------------------------------
   
   func_criacao_edit_take();
   func_criacao_edit_stop();
   func_criacao_edit_trailling();
   func_criacao_edit_preservar_capital();
   
   // ------------------------------------
   
   func_criacao_label_risco_capital();
   func_criacao_edit_risco_capital();
   func_criacao_botao_abrir_buy();
   func_criacao_botao_abrir_sell();
   
   // ---------------- Vai cria label's p/ mostrar o valor do take e stop da ordem aberta ---------.
      
   criar_label_valor_take();
   criar_label_valor_stop();
    
   // ---------------- Criação completa do paínel direito. ----------------
   
   func_criacao_painel_direito();
   // Os 3 retângulos de Profit.
   func_cria_retangulos_andamento(); 
   // Atualiza variáveis globais.
   func_atualiza_variaveis_globais();
   
   // -------------------------- Escopo Sistema Autonômo. ----------------
   
   inicializacoes_oninit();          
  
   return( INIT_SUCCEEDED );
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
     ObjectsDeleteAll( 0, -1, -1 );
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   
   func_atualiza_variaveis_globais();
   func_redraw_valores_pc();
   func_preservar_capital( preservar_capital_param, magic_number ); // BreakEven.
   func_trailling_stop( trailling_stop_param, 1, magic_number );
   func_zerando_variaveis(); // Esvaziando variáveis quando não estiver ordem aberta.
   // Atualizando take, Stop, comentário p/ ordens externas há plataforma.
   setando_take_stop_ordens_externas();
   ObjectsDeleteAll( 0, "autotrade", -1, -1 );
   
   
   // ---------------------------- Procedimentos Autonômos ----------------
   
   func_regras_envio_email();
   bool res = func_verifica_regras_gerais ();
   if ( res )
     func_abrir_ordem_estrategia ();
   func_carrega_noticias() // Carrega notícias do dia. 
 
 }     
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+


//  OnChartEvent() é o handler (manipulador) de um grupo de eventos ChartEvent:
void OnChartEvent(const int id,  // Evento ID
                  const long &lparam,   // Parâmetro de evento de tipo long
                  const double &dparam, // Parâmetro de evento de tipo double
                  const string &sparam) // Parâmetro de evento de tipo string
  {
   if(id == CHARTEVENT_OBJECT_CLICK)
   {
      if(sparam == "botao_fechamento_1")    // Fecha todas as ordens.
        {
         func_fecha_todas_ordens();
        }
      if(sparam == "botao_fechamento_2")    // Fecha todas as ordens positivas.
        {
         func_fecha_todas_positivas();
        }
      if(sparam == "botao_fechamento_3")    // Fecha todas as ordens negativas.
        {
         func_fecha_todas_negativas();
        }
      if(sparam == "obj_botao_abrir_buy")   // Abrir ordem compra.
        {
         ZeroMemory( str_abertura_ordem );
         ZeroMemory( str_abertura_result); 
         inicializa_obj_param_entrada ( ORDER_TYPE_BUY );
         if ( analize_regras_abrir_ordem() == true )
         {
            converte_take_stop_preco     ( ORDER_TYPE_BUY );
            valor_monetario_take = retorna_valor_monetario_sl_tp( 1, ORDER_TYPE_BUY );
            valor_monetario_stop = retorna_valor_monetario_sl_tp( 0, ORDER_TYPE_BUY );
            inicializa_estrutura_abertura( ORDER_TYPE_BUY );
            bool res = criando_messageBox( valor_monetario_take, valor_monetario_stop );
            if ( res )  
              func_abrir_ordem();
         }   
       }
      if( sparam == "obj_botao_abrir_sell")  // Abrir ordem venda. 
      {
         ZeroMemory( str_abertura_ordem );
         ZeroMemory( str_abertura_result);
         inicializa_obj_param_entrada ( ORDER_TYPE_SELL );
         // ------------------- Convertendo Preço + StopLoss e TakeProfit  ----------------     
         if ( analize_regras_abrir_ordem() == true )
         {
           converte_take_stop_preco ( ORDER_TYPE_SELL );
           valor_monetario_take = retorna_valor_monetario_sl_tp( 1, ORDER_TYPE_SELL );
           valor_monetario_stop = retorna_valor_monetario_sl_tp( 0, ORDER_TYPE_SELL );
           inicializa_estrutura_abertura( ORDER_TYPE_SELL );
           bool res = criando_messageBox( valor_monetario_take, valor_monetario_stop );
           if ( res )  
             func_abrir_ordem();
         }     
      }
   }
  }
//+------------------------------------------------------------------+
