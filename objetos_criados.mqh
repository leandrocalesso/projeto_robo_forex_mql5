//+------------------------------------------------------------------+
//|                                              objetos_criados.mqh |
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
  
   func_criacao_obj_painel()          - Criação paínel principal esquerdo ( fundo preto ) 
   //------------------------------------
   func_criacao_labels_pc()           - Criação dos labels da coluna principal esquerda. 
   func_criacao_valores_pc()          - Cria as Label's de valores da coluna esquerda principal.
   //------------------------------------
   func_criacao_botoes_fechamento()
   func_criacao_botao_abrir_buy()
   func_criacao_botao_abrir_sell()
   //------------------------------------
   func_criacao_obj_painel_entrada()  - Paínel principal onde se encontra os parâmetros de p/ abertura ordem. 
   
   //------------------------------------
   func_criacao_label_take()
   func_criacao_edit_take()
   
   func_criacao_edit_stop()
   func_criacao_label_stop()
   
   func_criacao_label_preservar_capital() - breakeven
   func_criacao_edit_preservar_capital()  - breakeven
   
   func_criacao_label_risco_capital()
   func_criacao_edit_risco_capital()
   
   func_criacao_label_trailling()
   func_criacao_edit_trailling()
   
   //------------------------------------   
   criar_label_valor_take() - Criar objetos Label que vai setar o valor em dolar TAKE_PROFIT das entradas.
   criar_label_valor_stop() - Criar objetos Label que vai setar o valor em dolar STOP_LOSS das entradas.
   //------------------------------------
   func_redraw_valores_pc()
   //------------------------------------
   func_criacao_painel_direito()
   //------------------------------------
   func_cria_retangulos_andamento()
   //------------------------------------
   inicializa_obj_param_entrada()
   //------------------------------------
*/

int func_cria_retangulos_andamento()
{

     int    tam_fonte_retangulo     = 18; 
     string tipo_fonte_retangulo    = "Agency FB";
     int    x_distancia_retangulo   = 8;
     int    y_distancia_retangulo   = 333;
     int    x_size_retangulo        = 55; 
     int    y_size_retangulo        = 40;
     color  bg_color_retangulo      = clrBlue;
     color  text_color_retangulo    = clrYellow;
     int    border_type_retangulo   = BORDER_RAISED;

     if ( !ObjectCreate( 0, "obj_retangulo_positivo", OBJ_RECTANGLE_LABEL, 0, 0, 0 ) )
      return ( INIT_FAILED );
     if ( !ObjectCreate( 0, "obj_label_positivo_retangulo", OBJ_LABEL, 0, 0, 0 ) )
         return ( INIT_FAILED );
     //------------------------------------------------------------------------------     
     
     if ( !ObjectCreate( 0, "obj_retangulo_negativo", OBJ_RECTANGLE_LABEL, 0, 0, 0 ) )
         return ( INIT_FAILED );
     if ( !ObjectCreate( 0, "obj_label_negativo_retangulo", OBJ_LABEL, 0, 0, 0 ) )
        return ( INIT_FAILED );
     //------------------------------------------------------------------------------  
     if ( !ObjectCreate( 0, "obj_retangulo_real_profit", OBJ_RECTANGLE_LABEL, 0, 0, 0 ) )
        return ( INIT_FAILED );
     if ( !ObjectCreate( 0, "obj_label_real_profit", OBJ_LABEL, 0, 0, 0 ) )
      return ( INIT_FAILED );
     //------------------------------------------------------------------------------ 
      
     // Propriedades Retângulo Positivo.   
     ObjectSetInteger( 0, "obj_retangulo_positivo",OBJPROP_CORNER,      CORNER_LEFT_UPPER );
     ObjectSetInteger( 0, "obj_retangulo_positivo",OBJPROP_ANCHOR,      ANCHOR_LEFT_UPPER );
     ObjectSetInteger( 0,"obj_retangulo_positivo", OBJPROP_XDISTANCE,   x_distancia_retangulo); 
     ObjectSetInteger( 0,"obj_retangulo_positivo", OBJPROP_YDISTANCE,   y_distancia_retangulo); 
     ObjectSetInteger( 0,"obj_retangulo_positivo", OBJPROP_XSIZE,       x_size_retangulo); 
     ObjectSetInteger( 0,"obj_retangulo_positivo", OBJPROP_YSIZE,       y_size_retangulo);   
     ObjectSetInteger( 0,"obj_retangulo_positivo", OBJPROP_BGCOLOR,     bg_color_retangulo); 
     ObjectSetInteger( 0,"obj_retangulo_positivo", OBJPROP_BORDER_TYPE, border_type_retangulo); 

     ObjectSetInteger( 0,"obj_label_positivo_retangulo", OBJPROP_XDISTANCE,x_distancia_retangulo+4); 
     ObjectSetInteger( 0,"obj_label_positivo_retangulo", OBJPROP_YDISTANCE,y_distancia_retangulo+7); 
     ObjectSetInteger( 0,"obj_label_positivo_retangulo", OBJPROP_XSIZE,    x_size_retangulo); 
     ObjectSetInteger( 0,"obj_label_positivo_retangulo", OBJPROP_YSIZE,    y_size_retangulo);   
     ObjectSetString( 0 ,"obj_label_positivo_retangulo", OBJPROP_FONT,     tipo_fonte_retangulo); 
     ObjectSetInteger( 0 ,"obj_label_positivo_retangulo",OBJPROP_FONTSIZE, tam_fonte_retangulo); 
     ObjectSetInteger( 0,"obj_label_positivo_retangulo", OBJPROP_COLOR,    text_color_retangulo); 
     ObjectSetString( 0,"obj_label_positivo_retangulo",  OBJPROP_TEXT,     "+0.0" );
     
     // Propriedades Retângulo Negativo.   
     ObjectSetInteger( 0, "obj_retangulo_negativo", OBJPROP_CORNER,    CORNER_LEFT_UPPER );
     ObjectSetInteger( 0, "obj_retangulo_negativo", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
     ObjectSetInteger( 0,"obj_retangulo_negativo",OBJPROP_XDISTANCE,   x_distancia_retangulo+(x_size_retangulo+1)); 
     ObjectSetInteger( 0,"obj_retangulo_negativo",OBJPROP_YDISTANCE,   y_distancia_retangulo); 
     ObjectSetInteger( 0,"obj_retangulo_negativo",OBJPROP_XSIZE,       x_size_retangulo); 
     ObjectSetInteger( 0,"obj_retangulo_negativo",OBJPROP_YSIZE,       y_size_retangulo);  
     ObjectSetString( 0 ,"obj_retangulo_negativo",OBJPROP_FONT,        tipo_fonte_retangulo); 
     ObjectSetInteger( 0 ,"obj_retangulo_negativo",OBJPROP_FONTSIZE,   tam_fonte_retangulo); 
     ObjectSetInteger( 0,"obj_retangulo_negativo",OBJPROP_COLOR,       text_color_retangulo); 
     ObjectSetInteger( 0,"obj_retangulo_negativo",OBJPROP_BGCOLOR,     clrRed ); 
     ObjectSetInteger( 0,"obj_retangulo_positivo",OBJPROP_BORDER_TYPE, border_type_retangulo);
     ObjectSetString( 0,"obj_retangulo_negativo",OBJPROP_TEXT,         0.0 );
     
     ObjectSetInteger( 0,"obj_label_negativo_retangulo", OBJPROP_XDISTANCE,x_distancia_retangulo+(x_size_retangulo+5)); 
     ObjectSetInteger( 0,"obj_label_negativo_retangulo", OBJPROP_YDISTANCE,y_distancia_retangulo+7); 
     ObjectSetInteger( 0,"obj_label_negativo_retangulo", OBJPROP_XSIZE,    x_size_retangulo); 
     ObjectSetInteger( 0,"obj_label_negativo_retangulo", OBJPROP_YSIZE,    y_size_retangulo);   
     ObjectSetString( 0 ,"obj_label_negativo_retangulo", OBJPROP_FONT,     tipo_fonte_retangulo ); 
     ObjectSetInteger( 0 ,"obj_label_negativo_retangulo",OBJPROP_FONTSIZE, tam_fonte_retangulo); 
     ObjectSetInteger( 0,"obj_label_negativo_retangulo", OBJPROP_COLOR,    text_color_retangulo); 
     ObjectSetString( 0,"obj_label_negativo_retangulo",  OBJPROP_TEXT,     "-0.0" );
     
     // Profit andamento orden aberta.
      // Propriedades Retângulo Positivo.   
     ObjectSetInteger( 0, "obj_retangulo_real_profit",OBJPROP_CORNER,      CORNER_LEFT_UPPER );
     ObjectSetInteger( 0, "obj_retangulo_real_profit",OBJPROP_ANCHOR,      ANCHOR_LEFT_UPPER );
     ObjectSetInteger( 0,"obj_retangulo_real_profit", OBJPROP_XDISTANCE,   x_distancia_retangulo+(x_size_retangulo+ x_size_retangulo+2)); 
     ObjectSetInteger( 0,"obj_retangulo_real_profit", OBJPROP_YDISTANCE,   y_distancia_retangulo); 
     ObjectSetInteger( 0,"obj_retangulo_real_profit", OBJPROP_XSIZE,       x_size_retangulo+23); 
     ObjectSetInteger( 0,"obj_retangulo_real_profit", OBJPROP_YSIZE,       y_size_retangulo);   
     ObjectSetInteger( 0,"obj_retangulo_real_profit", OBJPROP_BGCOLOR,     0X067703 ); 
     ObjectSetInteger( 0,"obj_retangulo_real_profit", OBJPROP_BORDER_TYPE, border_type_retangulo );
     
     ObjectSetInteger( 0,"obj_label_real_profit", OBJPROP_XDISTANCE, x_distancia_retangulo+(x_size_retangulo+x_size_retangulo)+9); 
     ObjectSetInteger( 0,"obj_label_real_profit", OBJPROP_YDISTANCE, y_distancia_retangulo+7); 
     ObjectSetInteger( 0,"obj_label_real_profit", OBJPROP_XSIZE,     x_size_retangulo+5); 
     ObjectSetInteger( 0,"obj_label_real_profit", OBJPROP_YSIZE,     y_size_retangulo);   
     ObjectSetString( 0 ,"obj_label_real_profit", OBJPROP_FONT,      tipo_fonte_retangulo); 
     ObjectSetInteger( 0 ,"obj_label_real_profit",OBJPROP_FONTSIZE,  tam_fonte_retangulo); 
     ObjectSetInteger( 0,"obj_label_real_profit", OBJPROP_COLOR,     text_color_retangulo); 
     ObjectSetString( 0,"obj_label_real_profit",  OBJPROP_TEXT,      "+R$0.0" );
     
     return ( INIT_SUCCEEDED );
}

// Está função cria o objeto Label que vai conter o valor em dolar relacionado ao STOP da entrada na ordem.   
int criar_label_valor_stop()
{
    
    int    tam_fonte       = 19;
    string tipo_fonte      = "Agency FB";
    color  cor_fonte       = clrRed;
    int    dist_horizontal = 294;
    int    dist_vertical   = 302;
    int    largura_valor   = 20;
    int    altura_valor    = 20;

    // Criando o Label de especificaçõ.
    if ( !ObjectCreate( 0,"label_especificacao_stop",OBJ_LABEL,0,0,0 ) )
       return(INIT_FAILED );
    
    if ( !ObjectCreate( 0,"label_valor_stop",OBJ_LABEL,0,0,0 ) )
       return(INIT_FAILED );
    
       
    ObjectSetInteger( 0, "label_especificacao_stop", OBJPROP_CORNER,    CORNER_LEFT_UPPER );
    ObjectSetInteger( 0, "label_especificacao_stop", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
    ObjectSetInteger( 0, "label_especificacao_stop", OBJPROP_XDISTANCE, dist_horizontal);  
    ObjectSetInteger( 0, "label_especificacao_stop", OBJPROP_YDISTANCE, dist_vertical-11 );  
    ObjectSetInteger( 0, "label_especificacao_stop", OBJPROP_FONTSIZE,  tam_fonte-8 );
    ObjectSetInteger( 0, "label_especificacao_stop", OBJPROP_COLOR,     clrRed );   
    ObjectSetString ( 0, "label_especificacao_stop", OBJPROP_TEXT,      "$Stop" );
    ObjectSetString ( 0, "label_especificacao_stop", OBJPROP_FONT,      tipo_fonte );
       
    ObjectSetInteger( 0, "label_valor_stop", OBJPROP_CORNER,   CORNER_LEFT_UPPER );
    ObjectSetInteger( 0, "label_valor_stop", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
    ObjectSetInteger( 0, "label_valor_stop", OBJPROP_XDISTANCE, dist_horizontal );  
    ObjectSetInteger( 0, "label_valor_stop", OBJPROP_YDISTANCE, dist_vertical );  
    ObjectSetInteger( 0, "label_valor_stop", OBJPROP_COLOR,     cor_fonte );
    ObjectSetInteger( 0, "label_valor_stop", OBJPROP_FONTSIZE,  tam_fonte );
    ObjectSetString ( 0, "label_valor_stop", OBJPROP_TEXT,      "0.0" );
    ObjectSetString ( 0, "label_valor_stop", OBJPROP_FONT,      tipo_fonte);
       
    return INIT_SUCCEEDED; 
}

// Está função cria o objeto Label que vai conter o valor em dolar relacionado ao TAKE_PROFIT da entrada na ordem.   
int criar_label_valor_take()
{

    int    tam_fonte       = 19;
    string fonte_label     = "Agency FB";
    color  cor_fonte       = clrBlue;
    int    dist_horizontal = 232;
    int    dist_vertical   = 302;
    int    largura_valor   = 20;
    int    altura_valor    = 20;
    
    // Criando o Label de especificaçõ.
    if ( !ObjectCreate( 0,"label_especificacao_take",OBJ_LABEL,0,0,0 ) )
       return(INIT_FAILED );
    
    if ( !ObjectCreate( 0,"label_valor_take",OBJ_LABEL,0,0,0 ) )
       return(INIT_FAILED );
       
    ObjectSetInteger( 0, "label_especificacao_take", OBJPROP_CORNER,    CORNER_LEFT_UPPER );
    ObjectSetInteger( 0, "label_especificacao_take", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
    ObjectSetInteger( 0, "label_especificacao_take", OBJPROP_XDISTANCE, dist_horizontal);  
    ObjectSetInteger( 0, "label_especificacao_take", OBJPROP_YDISTANCE, dist_vertical-11 );  
    ObjectSetInteger( 0, "label_especificacao_take", OBJPROP_FONTSIZE,  tam_fonte-8 );
    ObjectSetInteger( 0, "label_especificacao_take", OBJPROP_COLOR,     clrRed );   
    ObjectSetString ( 0, "label_especificacao_take", OBJPROP_TEXT,      "$Take" );
    ObjectSetString ( 0, "label_especificacao_take", OBJPROP_FONT,      fonte_label);
       
    ObjectSetInteger( 0, "label_valor_take", OBJPROP_CORNER,    CORNER_LEFT_UPPER );
    ObjectSetInteger( 0, "label_valor_take", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
    ObjectSetInteger( 0, "label_valor_take", OBJPROP_XDISTANCE, dist_horizontal);  
    ObjectSetInteger( 0, "label_valor_take", OBJPROP_YDISTANCE, dist_vertical);  
    ObjectSetInteger( 0, "label_valor_take", OBJPROP_COLOR,     cor_fonte );
    ObjectSetInteger( 0, "label_valor_take", OBJPROP_FONTSIZE,  tam_fonte );
    ObjectSetString ( 0, "label_valor_take", OBJPROP_TEXT,      "0.0" );
    ObjectSetString ( 0, "label_valor_take", OBJPROP_FONT,      fonte_label );
       
    return INIT_SUCCEEDED; 
}

int func_criacao_label_preservar_capital()
{
    
    int    tam_fonte_label_preservar_capital = 12;
    string fonte_label_preservar_capital     = "Agency FB";
    color  cor_fonte_label_preservar_capital = clrRed;
    color  fundo_label_preservar_capital     = clrRed;
    int    dist_horizontal_label_preservar_capital = 217;
    int    dist_vertical_label_preservar_capital   = 190;

    if ( !ObjectCreate( 0,"obj_label_preservarCapital",OBJ_LABEL,0,0,0 ) )
       return(INIT_FAILED );
       
    ObjectSetInteger( 0, "obj_label_preservarCapital",OBJPROP_CORNER,    CORNER_LEFT_UPPER );
    ObjectSetInteger( 0, "obj_label_preservarCapital",OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
    ObjectSetInteger( 0, "obj_label_preservarCapital",OBJPROP_XDISTANCE, dist_horizontal_label_preservar_capital );  
    ObjectSetInteger( 0, "obj_label_preservarCapital",OBJPROP_YDISTANCE, dist_vertical_label_preservar_capital );  
    ObjectSetInteger( 0, "obj_label_preservarCapital",OBJPROP_COLOR,     cor_fonte_label_preservar_capital );
    ObjectSetInteger( 0, "obj_label_preservarCapital",OBJPROP_FONTSIZE,  tam_fonte_label_preservar_capital );
    ObjectSetString( 0, "obj_label_preservarCapital", OBJPROP_TEXT,      "Breakeven" );
    ObjectSetString( 0, "obj_label_preservarCapital", OBJPROP_FONT,      fonte_label_preservar_capital );   
    
    return ( INIT_SUCCEEDED );

} 

int func_criacao_label_risco_capital()
{
    
    int    tam_fonte_label_risco_capital       = 12;
    string fonte_label_risco_capital           = "Agency FB";
    color  cor_fonte_label_risco_capital       = clrRed;
    color  fundo_label_risco_capital           = clrRed;
    int    dist_horizontal_label_risco_capital = 217;
    int    dist_vertical_label_risco_capital   = 206;


    if ( !ObjectCreate( 0,"obj_label_riscoCapital",OBJ_LABEL,0,0,0 ) )
       return(INIT_FAILED );
       
    ObjectSetInteger( 0, "obj_label_riscoCapital",OBJPROP_CORNER,    CORNER_LEFT_UPPER );
    ObjectSetInteger( 0, "obj_label_riscoCapital",OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
    ObjectSetInteger( 0, "obj_label_riscoCapital",OBJPROP_XDISTANCE, dist_horizontal_label_risco_capital );  
    ObjectSetInteger( 0, "obj_label_riscoCapital",OBJPROP_YDISTANCE, dist_vertical_label_risco_capital );  
    ObjectSetInteger( 0, "obj_label_riscoCapital",OBJPROP_COLOR,     cor_fonte_label_risco_capital );
    ObjectSetInteger( 0, "obj_label_riscoCapital",OBJPROP_FONTSIZE,  tam_fonte_label_risco_capital );
    ObjectSetString( 0, "obj_label_riscoCapital", OBJPROP_TEXT,      "Risco Capital" );
    ObjectSetString( 0, "obj_label_riscoCapital", OBJPROP_FONT,      fonte_label_risco_capital );   
    
    return ( INIT_SUCCEEDED );

}


int func_criacao_edit_preservar_capital()
{

   int    tam_fonte_edit_perservar_capital    = 10;
   string tipo_fonte_edit_perservar_capital   = "Agency FB";
   int    x_distancia_edit_perservar_capital  = 287;
   int    y_distancia_edit_perservar_capital  = 190;
   int    x_size_edit_perservar_capital       = 30;
   int    y_size_edit_perservar_capital       = 17;
   color  bg_color_edit_perservar_capital     = clrAqua;
   color  text_color_edit_perservar_capital   = clrBlack;
   color  color_border_edit_perservar_capital = clrSilver;

   if ( !ObjectCreate( 0, "obj_edit_preservar_capital", OBJ_EDIT, 0, 0, 0 ) )
      return ( INIT_FAILED );
        
   ObjectSetInteger( 0,"obj_edit_preservar_capital", OBJPROP_XDISTANCE,    x_distancia_edit_perservar_capital); 
   ObjectSetInteger( 0,"obj_edit_preservar_capital", OBJPROP_YDISTANCE,    y_distancia_edit_perservar_capital); 
   ObjectSetInteger( 0,"obj_edit_preservar_capital", OBJPROP_XSIZE,        x_size_edit_perservar_capital); 
   ObjectSetInteger( 0,"obj_edit_preservar_capital", OBJPROP_YSIZE,        y_size_edit_perservar_capital); 
   ObjectSetInteger( 0,"obj_edit_preservar_capital", OBJPROP_CORNER,       CORNER_LEFT_UPPER ); 
   ObjectSetString ( 0,"obj_edit_preservar_capital", OBJPROP_TEXT,         IntegerToString(50) ); 
   ObjectSetString ( 0,"obj_edit_preservar_capital",OBJPROP_FONT,         tipo_fonte_edit_perservar_capital ); 
   ObjectSetInteger( 0,"obj_edit_preservar_capital",OBJPROP_FONTSIZE,     tam_fonte_edit_perservar_capital ); 
   ObjectSetInteger( 0,"obj_edit_preservar_capital", OBJPROP_COLOR,        text_color_edit_perservar_capital ); 
   ObjectSetInteger( 0,"obj_edit_preservar_capital", OBJPROP_BGCOLOR,      bg_color_edit_perservar_capital ); 
   ObjectSetInteger( 0,"obj_edit_preservar_capital", OBJPROP_BORDER_COLOR, color_border_edit_perservar_capital ); 
   ObjectSetInteger( 0,"obj_edit_preservar_capital", OBJPROP_ALIGN,        ALIGN_CENTER );
   
   return ( INIT_SUCCEEDED );
}                                        

int func_criacao_edit_risco_capital()
{

   int    tam_fonte_edit_risco_capital    = 10;
   string tipo_fonte_edit_risco_capital   = "Agency FB";
   int    x_distancia_edit_risco_capital  = 287;
   int    y_distancia_edit_risco_capital  = 207;
   int    x_size_edit_risco_capital       = 30;
   int    y_size_edit_risco_capital       = 17;
   color  bg_color_edit_risco_capital     = clrAqua;
   color  text_color_edit_risco_capital   = clrBlack;
   color  color_border_edit_risco_capital = clrSilver;
   
   if ( !ObjectCreate( 0, "obj_edit_risco_capital", OBJ_EDIT, 0, 0, 0 ) )
      return ( INIT_FAILED );
        
   ObjectSetInteger( 0,"obj_edit_risco_capital", OBJPROP_XDISTANCE,    x_distancia_edit_risco_capital); 
   ObjectSetInteger( 0,"obj_edit_risco_capital", OBJPROP_YDISTANCE,    y_distancia_edit_risco_capital); 
   ObjectSetInteger( 0,"obj_edit_risco_capital", OBJPROP_XSIZE,        x_size_edit_risco_capital); 
   ObjectSetInteger( 0,"obj_edit_risco_capital", OBJPROP_YSIZE,        y_size_edit_risco_capital); 
   ObjectSetInteger( 0,"obj_edit_risco_capital", OBJPROP_CORNER,       CORNER_LEFT_UPPER ); 
   ObjectSetString( 0,"obj_edit_risco_capital",  OBJPROP_TEXT,         DoubleToString( 0.01,2 ) ); 
   ObjectSetString( 0 ,"obj_edit_risco_capital", OBJPROP_FONT,         tipo_fonte_edit_risco_capital ); 
   ObjectSetInteger( 0 ,"obj_edit_risco_capital",OBJPROP_FONTSIZE,     tam_fonte_edit_risco_capital ); 
   ObjectSetInteger( 0,"obj_edit_risco_capital", OBJPROP_COLOR,        text_color_edit_risco_capital ); 
   ObjectSetInteger( 0,"obj_edit_risco_capital", OBJPROP_BGCOLOR,      bg_color_edit_risco_capital ); 
   ObjectSetInteger( 0,"obj_edit_risco_capital", OBJPROP_BORDER_COLOR, color_border_edit_risco_capital ); 
   ObjectSetInteger( 0,"obj_edit_risco_capital", OBJPROP_ALIGN,        ALIGN_CENTER );
   
   return ( INIT_SUCCEEDED );
}

int func_criacao_obj_painel()
  {
  
    int    x_distancia  = 0;
    int    y_distancia  = 20;
    int    x_size       = 350;
    int    y_size       = 360;
    color  cor_fundo    = clrBlack;
    int    tipo_borda   = BORDER_FLAT;
    color  cor_borda    = clrYellow;

    if ( !ObjectCreate( 0,"painel_principal",OBJ_RECTANGLE_LABEL,0,0,0 ) )
       return ( INIT_FAILED );
       
    ObjectSetInteger( 0, "painel_principal",OBJPROP_CORNER, CORNER_LEFT_UPPER );
    ObjectSetInteger( 0, "painel_principal",OBJPROP_XDISTANCE, x_distancia );    
    ObjectSetInteger( 0, "painel_principal",OBJPROP_YDISTANCE, y_distancia );
    ObjectSetInteger( 0, "painel_principal",OBJPROP_XSIZE, x_size );
    ObjectSetInteger( 0, "painel_principal",OBJPROP_YSIZE, y_size );
    ObjectSetInteger( 0, "painel_principal",OBJPROP_BGCOLOR, cor_fundo );
    ObjectSetInteger( 0, "painel_principal",OBJPROP_BORDER_TYPE, tipo_borda );
    ObjectSetInteger( 0, "painel_principal",OBJPROP_COLOR, cor_borda );
    ObjectSetInteger( 0, "painel_principal",OBJPROP_WIDTH, 2 );
    
    return ( INIT_SUCCEEDED );
}

// Criação dos labels da coluna principal esquerda.
int func_criacao_labels_pc()
{

   string label_obj_cp[34] =  { "label_obj_cp_simbolo",            "Simbolo",
                               "label_obj_cp_tipo_conta",          "Tipo Conta",
                               "label_obj_cp_label_cp_valor_pip",  "Valor Pip",
                               "label_obj_cp_lucro Andamento",     "Lucro Andamento",
                               "label_obj_cp_lucro_Diario",        "Lucro Diário",
                               "label_obj_cp_lucro_semanal",       "Lucro Semanal",
                               "label_obj_cp_lucro_menssal",       "Lucro Menssal",
                               "label_obj_cp_total_depositado",    "Total Depositado", 
                               "label_obj_cp_total_resgate",       "Total Resgate",
                               "label_obj_cp_ultimo_deposito",     "Último Deposito",
                               "label_obj_cp_ordens_posit_atual",  "Ordens Posit. Atual",
                               "label_obj_cp_ordens_negat_atual",  "Ordens Negat. Atual",
                               "label_obj_cp_profit_posit_diário", "Profit. Posit. Diário",
                               "label_obj_cp_profit_negat_diário", "Profit. Negat. Diário",
                               "label_obj_cp_ordens_take_diario",  "Ordens Take Diário",
                               "label_obj_cp_ordens_stop_diario",  "Ordens Stop Diário",
                               "label_obj_cp_profit_conta_total",  ">>> Profit Conta <<< " };
   
   int    tam_fonte_label_pc  = 13;
   string fonte_label_pc      = "Agency FB";
   color  cor_label_pc        = clrWhite;
   color  cor_fundo_pc        = clrRed;
   int    dist_horizontal_pc  = 7;
   int    dist_vertical_pc    = 30;

   int soma_vertical = 0;
   
   for ( int i = 0; i < ArraySize( label_obj_cp ); i++ )
   {
       if ( !ObjectCreate( 0, label_obj_cp[ i ], OBJ_LABEL, 0, 0, 0 ) )
          return ( INIT_FAILED );
       
       ObjectSetInteger( 0, label_obj_cp[ i ], OBJPROP_CORNER,    CORNER_LEFT_UPPER );
       ObjectSetInteger( 0, label_obj_cp[ i ], OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
       ObjectSetInteger( 0, label_obj_cp[ i ], OBJPROP_XDISTANCE, dist_horizontal_pc );  
       ObjectSetInteger( 0, label_obj_cp[ i ], OBJPROP_YDISTANCE, dist_vertical_pc + soma_vertical );  
       ObjectSetInteger( 0, label_obj_cp[ i ], OBJPROP_COLOR,     cor_label_pc );
       ObjectSetInteger( 0, label_obj_cp[ i ], OBJPROP_FONTSIZE,  tam_fonte_label_pc );
       ObjectSetString ( 0, label_obj_cp[ i ], OBJPROP_TEXT,      label_obj_cp[ i+1 ] );  
       ObjectSetString ( 0, label_obj_cp[ i ], OBJPROP_FONT,      fonte_label_pc );
        i += 1;
       soma_vertical += 17;
   }  
    
    
   return( 0 );
}

// Cria as Label's de valores da coluna esquerda principal. 
int func_criacao_valores_pc()
{                            

   int    tam_fonte_valor_pc_valor       = 9;
   string fonte_valor_pc_valor           = "Agency FB";
   color  cor_valor_pc_valor             = clrGreen;
   color  fundo_valor_pc_valor           = clrRed;
   int    dist_horizontal_valor_pc_valor = 120;
   int    dist_vertical_valor_pc_valor   = 30;
   int    dist_vertical_linha            = 17;      
   
   int soma_vertical = 0;
   
   if ( !ObjectCreate( 0, "label_obj_cp_valor_simbolo"   ,            OBJ_LABEL, 0, 0, 0 ) )return ( INIT_FAILED );  
   if ( !ObjectCreate( 0, "label_obj_cp_valor_tipoConta" ,            OBJ_LABEL, 0, 0, 0 ) )return ( INIT_FAILED );
   if ( !ObjectCreate( 0, "label_obj_cp_valor_valorPip"  ,            OBJ_LABEL, 0, 0, 0 ) )return ( INIT_FAILED );
   if ( !ObjectCreate( 0, "label_obj_cp_valor_lucroAndamento" ,       OBJ_LABEL, 0, 0, 0 ) )return ( INIT_FAILED );
   if ( !ObjectCreate( 0, "label_obj_cp_valor_lucroDiario" ,          OBJ_LABEL, 0, 0, 0 ) )return ( INIT_FAILED );
   if ( !ObjectCreate( 0, "label_obj_cp_valor_lucroSemanal",          OBJ_LABEL, 0, 0, 0 ) )return ( INIT_FAILED );
   if ( !ObjectCreate( 0, "label_obj_cp_valor_lucromenssal",          OBJ_LABEL, 0, 0, 0 ) )return ( INIT_FAILED );
   if ( !ObjectCreate( 0, "label_obj_cp_valor_total_depositado" ,     OBJ_LABEL, 0, 0, 0 ) )return ( INIT_FAILED );
   if ( !ObjectCreate( 0, "label_obj_cp_valor_total_resgate" ,        OBJ_LABEL, 0, 0, 0 ) )return ( INIT_FAILED );
   if ( !ObjectCreate( 0, "label_obj_cp_valor_ultimoDeposito" ,       OBJ_LABEL, 0, 0, 0 ) )return ( INIT_FAILED );    
   if ( !ObjectCreate( 0, "label_obj_cp_valor_ordensPositivasAtual" , OBJ_LABEL, 0, 0, 0 ) )return ( INIT_FAILED );    
   if ( !ObjectCreate( 0, "label_obj_cp_valor_ordensNegativasAtual" , OBJ_LABEL, 0, 0, 0 ) )return ( INIT_FAILED );
   if ( !ObjectCreate( 0, "label_obj_cp_valor_profitPositDiario" ,    OBJ_LABEL, 0, 0, 0 ) )return ( INIT_FAILED );
   if ( !ObjectCreate( 0, "label_obj_cp_valor_profitNegatDiario" ,    OBJ_LABEL, 0, 0, 0 ) )return ( INIT_FAILED );
   if ( !ObjectCreate( 0, "label_obj_cp_valor_ordensTakeDiario" ,     OBJ_LABEL, 0, 0, 0 ) )return ( INIT_FAILED );
   if ( !ObjectCreate( 0, "label_obj_cp_valor_ordensStopDiario" ,     OBJ_LABEL, 0, 0, 0 ) )return ( INIT_FAILED );    
   if ( !ObjectCreate( 0, "label_obj_cp_valor_profit_conta_total" ,   OBJ_LABEL, 0, 0, 0 ) )return ( INIT_FAILED );    
       
   ObjectSetInteger( 0, "label_obj_cp_valor_simbolo", OBJPROP_CORNER,    CORNER_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_simbolo", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_simbolo", OBJPROP_XDISTANCE, dist_horizontal_valor_pc_valor );  
   ObjectSetInteger( 0, "label_obj_cp_valor_simbolo", OBJPROP_YDISTANCE, dist_vertical_valor_pc_valor+4 );  
   ObjectSetInteger( 0, "label_obj_cp_valor_simbolo", OBJPROP_COLOR,     cor_valor_pc_valor );
   ObjectSetInteger( 0, "label_obj_cp_valor_simbolo", OBJPROP_FONTSIZE,  tam_fonte_valor_pc_valor );
   ObjectSetString ( 0, "label_obj_cp_valor_simbolo", OBJPROP_TEXT, ": " +"..." );    
   soma_vertical += dist_vertical_linha;    
   
   ObjectSetInteger( 0, "label_obj_cp_valor_tipoConta", OBJPROP_CORNER,    CORNER_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_tipoConta", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_tipoConta", OBJPROP_XDISTANCE, dist_horizontal_valor_pc_valor );  
   ObjectSetInteger( 0, "label_obj_cp_valor_tipoConta", OBJPROP_YDISTANCE, dist_vertical_valor_pc_valor+soma_vertical+4 );  
   ObjectSetInteger( 0, "label_obj_cp_valor_tipoConta", OBJPROP_COLOR,     cor_valor_pc_valor );
   ObjectSetInteger( 0, "label_obj_cp_valor_tipoConta", OBJPROP_FONTSIZE,  tam_fonte_valor_pc_valor );
   ObjectSetString ( 0, "label_obj_cp_valor_tipoConta", OBJPROP_TEXT, ": " +"..." );    
   soma_vertical += dist_vertical_linha;
   
   ObjectSetInteger( 0, "label_obj_cp_valor_valorPip", OBJPROP_CORNER,    CORNER_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_valorPip", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_valorPip", OBJPROP_XDISTANCE, dist_horizontal_valor_pc_valor );  
   ObjectSetInteger( 0, "label_obj_cp_valor_valorPip", OBJPROP_YDISTANCE, dist_vertical_valor_pc_valor+soma_vertical+4 );  
   ObjectSetInteger( 0, "label_obj_cp_valor_valorPip", OBJPROP_COLOR,     cor_valor_pc_valor );
   ObjectSetInteger( 0, "label_obj_cp_valor_valorPip", OBJPROP_FONTSIZE,  tam_fonte_valor_pc_valor );
   ObjectSetString ( 0, "label_obj_cp_valor_valorPip", OBJPROP_TEXT, ": " +"0.0" );    
   soma_vertical += dist_vertical_linha;
   
   ObjectSetInteger( 0, "label_obj_cp_valor_lucroAndamento", OBJPROP_CORNER,    CORNER_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_lucroAndamento", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_lucroAndamento", OBJPROP_XDISTANCE, dist_horizontal_valor_pc_valor );  
   ObjectSetInteger( 0, "label_obj_cp_valor_lucroAndamento", OBJPROP_YDISTANCE, dist_vertical_valor_pc_valor+soma_vertical+4 );  
   ObjectSetInteger( 0, "label_obj_cp_valor_lucroAndamento", OBJPROP_COLOR,     cor_valor_pc_valor );
   ObjectSetInteger( 0, "label_obj_cp_valor_lucroAndamento", OBJPROP_FONTSIZE,  tam_fonte_valor_pc_valor );
   ObjectSetString ( 0, "label_obj_cp_valor_lucroAndamento", OBJPROP_TEXT, ": " +"0.0" );
   soma_vertical += dist_vertical_linha;
       
   ObjectSetInteger( 0, "label_obj_cp_valor_lucroDiario", OBJPROP_CORNER,    CORNER_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_lucroDiario", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_lucroDiario", OBJPROP_XDISTANCE, dist_horizontal_valor_pc_valor );  
   ObjectSetInteger( 0, "label_obj_cp_valor_lucroDiario", OBJPROP_YDISTANCE, dist_vertical_valor_pc_valor+soma_vertical+4 );  
   ObjectSetInteger( 0, "label_obj_cp_valor_lucroDiario", OBJPROP_COLOR,     cor_valor_pc_valor );
   ObjectSetInteger( 0, "label_obj_cp_valor_lucroDiario", OBJPROP_FONTSIZE,  tam_fonte_valor_pc_valor );
   ObjectSetString ( 0, "label_obj_cp_valor_lucroDiario", OBJPROP_TEXT, ": " +"0.0" );
   soma_vertical += dist_vertical_linha;
   
   ObjectSetInteger( 0, "label_obj_cp_valor_lucroSemanal", OBJPROP_CORNER,    CORNER_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_lucroSemanal", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_lucroSemanal", OBJPROP_XDISTANCE, dist_horizontal_valor_pc_valor );  
   ObjectSetInteger( 0, "label_obj_cp_valor_lucroSemanal", OBJPROP_YDISTANCE, dist_vertical_valor_pc_valor+soma_vertical+4 );  
   ObjectSetInteger( 0, "label_obj_cp_valor_lucroSemanal", OBJPROP_COLOR,     cor_valor_pc_valor );
   ObjectSetInteger( 0, "label_obj_cp_valor_lucroSemanal", OBJPROP_FONTSIZE,  tam_fonte_valor_pc_valor );
   ObjectSetString ( 0, "label_obj_cp_valor_lucroSemanal", OBJPROP_TEXT, ": " +"0.0" );
   soma_vertical += dist_vertical_linha;
       
   ObjectSetInteger( 0, "label_obj_cp_valor_lucromenssal", OBJPROP_CORNER,    CORNER_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_lucromenssal", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_lucromenssal", OBJPROP_XDISTANCE, dist_horizontal_valor_pc_valor);  
   ObjectSetInteger( 0, "label_obj_cp_valor_lucromenssal", OBJPROP_YDISTANCE, dist_vertical_valor_pc_valor+soma_vertical+4 );  
   ObjectSetInteger( 0, "label_obj_cp_valor_lucromenssal", OBJPROP_COLOR,     cor_valor_pc_valor );
   ObjectSetInteger( 0, "label_obj_cp_valor_lucromenssal", OBJPROP_FONTSIZE,  tam_fonte_valor_pc_valor );
   ObjectSetString ( 0, "label_obj_cp_valor_lucromenssal", OBJPROP_TEXT, ": " +"0.0" );
   soma_vertical += dist_vertical_linha;
   
   ObjectSetInteger( 0, "label_obj_cp_valor_total_depositado", OBJPROP_CORNER,    CORNER_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_total_depositado", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_total_depositado", OBJPROP_XDISTANCE, dist_horizontal_valor_pc_valor );  
   ObjectSetInteger( 0, "label_obj_cp_valor_total_depositado", OBJPROP_YDISTANCE, dist_vertical_valor_pc_valor+soma_vertical+4 );  
   ObjectSetInteger( 0, "label_obj_cp_valor_total_depositado", OBJPROP_COLOR,     cor_valor_pc_valor );
   ObjectSetInteger( 0, "label_obj_cp_valor_total_depositado", OBJPROP_FONTSIZE,  tam_fonte_valor_pc_valor );
   ObjectSetString ( 0, "label_obj_cp_valor_total_depositado", OBJPROP_TEXT, ": " +"0.0" );
   soma_vertical += dist_vertical_linha;
       
   ObjectSetInteger( 0, "label_obj_cp_valor_total_resgate", OBJPROP_CORNER,    CORNER_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_total_resgate", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_total_resgate", OBJPROP_XDISTANCE, dist_horizontal_valor_pc_valor );  
   ObjectSetInteger( 0, "label_obj_cp_valor_total_resgate", OBJPROP_YDISTANCE, dist_vertical_valor_pc_valor+soma_vertical+4 );  
   ObjectSetInteger( 0, "label_obj_cp_valor_total_resgate", OBJPROP_COLOR,     cor_valor_pc_valor );
   ObjectSetInteger( 0, "label_obj_cp_valor_total_resgate", OBJPROP_FONTSIZE,  tam_fonte_valor_pc_valor );
   ObjectSetString ( 0, "label_obj_cp_valor_total_resgate", OBJPROP_TEXT, ": " +"0.0" );
   soma_vertical += dist_vertical_linha;
   
   ObjectSetInteger( 0, "label_obj_cp_valor_ultimoDeposito", OBJPROP_CORNER,    CORNER_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_ultimoDeposito", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_ultimoDeposito", OBJPROP_XDISTANCE, dist_horizontal_valor_pc_valor );  
   ObjectSetInteger( 0, "label_obj_cp_valor_ultimoDeposito", OBJPROP_YDISTANCE, dist_vertical_valor_pc_valor+soma_vertical+4 );  
   ObjectSetInteger( 0, "label_obj_cp_valor_ultimoDeposito", OBJPROP_COLOR,     cor_valor_pc_valor );
   ObjectSetInteger( 0, "label_obj_cp_valor_ultimoDeposito", OBJPROP_FONTSIZE,  tam_fonte_valor_pc_valor );
   ObjectSetString ( 0, "label_obj_cp_valor_ultimoDeposito", OBJPROP_TEXT, ": " +"0.0" );
   soma_vertical += dist_vertical_linha;
   
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensPositivasAtual", OBJPROP_CORNER,    CORNER_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensPositivasAtual", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensPositivasAtual", OBJPROP_XDISTANCE, dist_horizontal_valor_pc_valor );  
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensPositivasAtual", OBJPROP_YDISTANCE, dist_vertical_valor_pc_valor+soma_vertical+4 );  
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensPositivasAtual", OBJPROP_COLOR,     cor_valor_pc_valor );
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensPositivasAtual", OBJPROP_FONTSIZE,  tam_fonte_valor_pc_valor );
   ObjectSetString ( 0, "label_obj_cp_valor_ordensPositivasAtual", OBJPROP_TEXT, ": " +0 );
   soma_vertical += dist_vertical_linha;
   
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensNegativasAtual", OBJPROP_CORNER,    CORNER_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensNegativasAtual", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensNegativasAtual", OBJPROP_XDISTANCE, dist_horizontal_valor_pc_valor );  
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensNegativasAtual", OBJPROP_YDISTANCE, dist_vertical_valor_pc_valor+soma_vertical+4 );  
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensNegativasAtual", OBJPROP_COLOR,     cor_valor_pc_valor );
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensNegativasAtual", OBJPROP_FONTSIZE,  tam_fonte_valor_pc_valor );
   ObjectSetString ( 0, "label_obj_cp_valor_ordensNegativasAtual", OBJPROP_TEXT, ": " +0 );
   soma_vertical += dist_vertical_linha;
       
   ObjectSetInteger( 0, "label_obj_cp_valor_profitPositDiario", OBJPROP_CORNER,    CORNER_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_profitPositDiario", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_profitPositDiario", OBJPROP_XDISTANCE, dist_horizontal_valor_pc_valor );  
   ObjectSetInteger( 0, "label_obj_cp_valor_profitPositDiario", OBJPROP_YDISTANCE, dist_vertical_valor_pc_valor+soma_vertical+4 );  
   ObjectSetInteger( 0, "label_obj_cp_valor_profitPositDiario", OBJPROP_COLOR,     cor_valor_pc_valor );
   ObjectSetInteger( 0, "label_obj_cp_valor_profitPositDiario", OBJPROP_FONTSIZE,  tam_fonte_valor_pc_valor);
   ObjectSetString ( 0, "label_obj_cp_valor_profitPositDiario", OBJPROP_TEXT, ": " +"0.0" );
   soma_vertical += dist_vertical_linha;
   
   ObjectSetInteger( 0, "label_obj_cp_valor_profitNegatDiario", OBJPROP_CORNER,    CORNER_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_profitNegatDiario", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_profitNegatDiario", OBJPROP_XDISTANCE, dist_horizontal_valor_pc_valor );  
   ObjectSetInteger( 0, "label_obj_cp_valor_profitNegatDiario", OBJPROP_YDISTANCE, dist_vertical_valor_pc_valor+soma_vertical+4 );  
   ObjectSetInteger( 0, "label_obj_cp_valor_profitNegatDiario", OBJPROP_COLOR,     cor_valor_pc_valor );
   ObjectSetInteger( 0, "label_obj_cp_valor_profitNegatDiario", OBJPROP_FONTSIZE,  tam_fonte_valor_pc_valor );
   ObjectSetString ( 0, "label_obj_cp_valor_profitNegatDiario", OBJPROP_TEXT, ": " +"0.0" );
   soma_vertical += dist_vertical_linha;
   
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensTakeDiario", OBJPROP_CORNER,    CORNER_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensTakeDiario", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensTakeDiario", OBJPROP_XDISTANCE, dist_horizontal_valor_pc_valor );  
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensTakeDiario", OBJPROP_YDISTANCE, dist_vertical_valor_pc_valor+soma_vertical+4 );  
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensTakeDiario", OBJPROP_COLOR,     cor_valor_pc_valor);
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensTakeDiario", OBJPROP_FONTSIZE,  tam_fonte_valor_pc_valor );
   ObjectSetString ( 0, "label_obj_cp_valor_ordensTakeDiario", OBJPROP_TEXT, ": " +0 );
   soma_vertical += dist_vertical_linha;
   
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensStopDiario", OBJPROP_CORNER,    CORNER_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensStopDiario", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensStopDiario", OBJPROP_XDISTANCE, dist_horizontal_valor_pc_valor );  
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensStopDiario", OBJPROP_YDISTANCE, dist_vertical_valor_pc_valor+soma_vertical+5 );  
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensStopDiario", OBJPROP_COLOR,     cor_valor_pc_valor);
   ObjectSetInteger( 0, "label_obj_cp_valor_ordensStopDiario", OBJPROP_FONTSIZE,  tam_fonte_valor_pc_valor );
   ObjectSetString ( 0, "label_obj_cp_valor_ordensStopDiario", OBJPROP_TEXT, ": " +0 );
   
   soma_vertical += dist_vertical_linha;
   
   ObjectSetInteger( 0, "label_obj_cp_valor_profit_conta_total", OBJPROP_CORNER,    CORNER_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_profit_conta_total", OBJPROP_ANCHOR,    ANCHOR_LEFT_UPPER );
   ObjectSetInteger( 0, "label_obj_cp_valor_profit_conta_total", OBJPROP_XDISTANCE, dist_horizontal_valor_pc_valor );  
   ObjectSetInteger( 0, "label_obj_cp_valor_profit_conta_total", OBJPROP_YDISTANCE, dist_vertical_valor_pc_valor+soma_vertical+5 );  
   ObjectSetInteger( 0, "label_obj_cp_valor_profit_conta_total", OBJPROP_COLOR,     cor_valor_pc_valor);
   ObjectSetInteger( 0, "label_obj_cp_valor_profit_conta_total", OBJPROP_FONTSIZE,  tam_fonte_valor_pc_valor );
   ObjectSetString ( 0, "label_obj_cp_valor_profit_conta_total", OBJPROP_TEXT, ": " +"[ 0 / 0 / 0 ]" );
   
        
   return( INIT_SUCCEEDED );
}

int func_criacao_botoes_fechamento()
{
   
   int tam_fonte_botao       = 13;
   string tipo_fonte_botao   = "Agency FB";
   int x_distancia_botao     = 210;
   int y_distancia_botao     = 30;
   int x_size_botao          = 130;
   int y_size_botao          = 23;
   color bg_color_botao      = clrBlue;
   color text_color_botao    = clrWhite;
   color  color_border_botao = 0;

   if ( !ObjectCreate( 0, "botao_fechamento_"+1 , OBJ_BUTTON, 0, 0, 0 ) )
      return ( INIT_FAILED );
       
//--- definir coordenadas do botão 
   ObjectSetInteger( 0,"botao_fechamento_"+1,OBJPROP_XDISTANCE,x_distancia_botao); 
   ObjectSetInteger( 0,"botao_fechamento_"+1,OBJPROP_YDISTANCE,y_distancia_botao); 
//--- definir tamanho do botão 
   ObjectSetInteger( 0,"botao_fechamento_"+1,OBJPROP_XSIZE,x_size_botao); 
   ObjectSetInteger( 0,"botao_fechamento_"+1,OBJPROP_YSIZE,y_size_botao); 
//--- determinar o canto do gráfico onde as coordenadas do ponto são definidas 
   ObjectSetInteger( 0,"botao_fechamento_"+1,OBJPROP_CORNER, CORNER_LEFT_UPPER ); 
//--- definir o texto 
   ObjectSetString( 0,"botao_fechamento_"+1,OBJPROP_TEXT, "Fechar todas Ordens" ); 
//--- definir o texto fonte 
   ObjectSetString( 0 ,"botao_fechamento_"+1,OBJPROP_FONT, tipo_fonte_botao ); 
//--- definir tamanho da fonte 
   ObjectSetInteger( 0 ,"botao_fechamento_"+1,OBJPROP_FONTSIZE, tam_fonte_botao ); 
//--- definir a cor do texto 
   ObjectSetInteger( 0,"botao_fechamento_"+1,OBJPROP_COLOR, text_color_botao ); 
//--- definir a cor de fundo 
   ObjectSetInteger( 0,"botao_fechamento_"+1,OBJPROP_BGCOLOR, bg_color_botao ); 
//--- definir a cor da borda 
   ObjectSetInteger( 0,"botao_fechamento_"+1,OBJPROP_BORDER_COLOR, color_border_botao ); 
   
   if ( !ObjectCreate( 0, "botao_fechamento_"+2 , OBJ_BUTTON, 0, 0, 0 ) )
      return ( INIT_FAILED );
       
   ObjectSetInteger( 0,"botao_fechamento_"+2,OBJPROP_XDISTANCE,x_distancia_botao); 
   ObjectSetInteger( 0,"botao_fechamento_"+2,OBJPROP_YDISTANCE,y_distancia_botao+y_size_botao); 
   ObjectSetInteger( 0,"botao_fechamento_"+2,OBJPROP_XSIZE,x_size_botao ); 
   ObjectSetInteger( 0,"botao_fechamento_"+2,OBJPROP_YSIZE,y_size_botao ); 
   ObjectSetInteger( 0,"botao_fechamento_"+2,OBJPROP_CORNER, CORNER_LEFT_UPPER ); 
   ObjectSetString( 0,"botao_fechamento_"+2,OBJPROP_TEXT, "Fechar Ordens. Posit." ); 
   ObjectSetString( 0,"botao_fechamento_"+2,OBJPROP_FONT, tipo_fonte_botao ); 
   ObjectSetInteger( 0,"botao_fechamento_"+2,OBJPROP_FONTSIZE, tam_fonte_botao ); 
   ObjectSetInteger( 0,"botao_fechamento_"+2,OBJPROP_COLOR, text_color_botao); 
   ObjectSetInteger( 0,"botao_fechamento_"+2,OBJPROP_BGCOLOR, bg_color_botao ); 
   ObjectSetInteger( 0,"botao_fechamento_"+2,OBJPROP_BORDER_COLOR, color_border_botao ); 
   
   if ( !ObjectCreate( 0, "botao_fechamento_"+3 , OBJ_BUTTON, 0, 0, 0 ) )
      return ( INIT_FAILED );
      
   ObjectSetInteger( 0,"botao_fechamento_"+3,OBJPROP_XDISTANCE,x_distancia_botao); 
   ObjectSetInteger( 0,"botao_fechamento_"+3,OBJPROP_YDISTANCE,y_distancia_botao+2*y_size_botao); 
   ObjectSetInteger( 0,"botao_fechamento_"+3,OBJPROP_XSIZE,x_size_botao); 
   ObjectSetInteger( 0,"botao_fechamento_"+3,OBJPROP_YSIZE,y_size_botao ); 
   ObjectSetInteger( 0,"botao_fechamento_"+3,OBJPROP_CORNER, CORNER_LEFT_UPPER ); 
   ObjectSetString( 0,"botao_fechamento_"+3,OBJPROP_TEXT, "Fechar Ordens. Negat." ); 
   ObjectSetString( 0,"botao_fechamento_"+3,OBJPROP_FONT, tipo_fonte_botao ); 
   ObjectSetInteger( 0,"botao_fechamento_"+3,OBJPROP_FONTSIZE, tam_fonte_botao ); 
   ObjectSetInteger( 0,"botao_fechamento_"+3,OBJPROP_COLOR, text_color_botao ); 
   ObjectSetInteger( 0,"botao_fechamento_"+3,OBJPROP_BGCOLOR, bg_color_botao ); 
   ObjectSetInteger( 0,"botao_fechamento_"+3,OBJPROP_BORDER_COLOR, color_border_botao ); 
      
   return( 0 );
}

int func_criacao_botao_abrir_buy()
{
   
   int    tam_fonte_botao_abrir_ordem     = 9;
   string tipo_fonte_botao_abrir_ordem    = "Arial";
   int    x_distancia_botao_abrir_ordem   = 218;
   int    y_distancia_botao_abrir_ordem   = 230;
   int    x_size_botao_abrir_ordem        = 115;
   int    y_size_botao_abrir_ordem        = 23;
   color  bg_color_botao_abrir_ordem      = clrRed;
   color  text_color_botao_abrir_ordem    = clrAzure;
   color  color_border_botao_abrir_ordem  = clrBisque;
   string text_botao                      = "Abrir Buy";

   
   if ( !ObjectCreate( 0, "obj_botao_abrir_buy" , OBJ_BUTTON, 0, 0, 0 ) )
      return ( INIT_FAILED );
       
   ObjectSetInteger( 0,"obj_botao_abrir_buy",OBJPROP_XDISTANCE,    x_distancia_botao_abrir_ordem);   
   ObjectSetInteger( 0,"obj_botao_abrir_buy",OBJPROP_YDISTANCE,    y_distancia_botao_abrir_ordem);
   ObjectSetInteger( 0,"obj_botao_abrir_buy",OBJPROP_XSIZE,        x_size_botao_abrir_ordem);  
   ObjectSetInteger( 0,"obj_botao_abrir_buy",OBJPROP_YSIZE,        y_size_botao_abrir_ordem);
   ObjectSetInteger( 0,"obj_botao_abrir_buy",OBJPROP_CORNER, CORNER_LEFT_UPPER ); 
   ObjectSetString( 0,"obj_botao_abrir_buy",OBJPROP_TEXT,          text_botao ); 
   ObjectSetString( 0 ,"obj_botao_abrir_buy",OBJPROP_FONT,         tipo_fonte_botao_abrir_ordem); 
   ObjectSetInteger( 0 ,"obj_botao_abrir_buy",OBJPROP_FONTSIZE,    tam_fonte_botao_abrir_ordem ); 
   ObjectSetInteger( 0,"obj_botao_abrir_buy",OBJPROP_COLOR,        text_color_botao_abrir_ordem ); 
   ObjectSetInteger( 0,"obj_botao_abrir_buy",OBJPROP_BGCOLOR,      bg_color_botao_abrir_ordem ); 
   ObjectSetInteger( 0,"obj_botao_abrir_buy",OBJPROP_BORDER_COLOR, color_border_botao_abrir_ordem ); 
         
   return( INIT_SUCCEEDED );
}

int func_criacao_botao_abrir_sell()
{
   int    tam_fonte_botao_abrir_ordem       = 9;
   string tipo_fonte_botao_abrir_ordem      = "Arial";
   int    x_distancia_botao_abrir_ordem     = 218;
   int    y_distancia_botao_abrir_ordem     = 230+23+2;
   int    x_size_botao_abrir_ordem          = 115;
   int    y_size_botao_abrir_ordem          = 23;
   color  bg_color_botao_abrir_ordem        = clrBlue;
   color  text_color_botao_abrir_ordem      = clrAzure;
   color  color_border_botao_abrir_ordem    = clrBisque;
   string text_botao                        = "Abrir Sell";

   if ( !ObjectCreate( 0, "obj_botao_abrir_sell" , OBJ_BUTTON, 0, 0, 0 ) )
      return ( INIT_FAILED );
       
   ObjectSetInteger( 0,"obj_botao_abrir_sell",OBJPROP_XDISTANCE,x_distancia_botao_abrir_ordem);   
   ObjectSetInteger( 0,"obj_botao_abrir_sell",OBJPROP_YDISTANCE,y_distancia_botao_abrir_ordem);
   ObjectSetInteger( 0,"obj_botao_abrir_sell",OBJPROP_XSIZE,x_size_botao_abrir_ordem);  
   ObjectSetInteger( 0,"obj_botao_abrir_sell",OBJPROP_YSIZE,y_size_botao_abrir_ordem);
   ObjectSetInteger( 0,"obj_botao_abrir_sell",OBJPROP_CORNER, CORNER_LEFT_UPPER ); 
   ObjectSetString( 0,"obj_botao_abrir_sell",OBJPROP_TEXT, text_botao ); 
   ObjectSetString( 0 ,"obj_botao_abrir_sell",OBJPROP_FONT, tipo_fonte_botao_abrir_ordem); 
   ObjectSetInteger( 0 ,"obj_botao_abrir_sell",OBJPROP_FONTSIZE, tam_fonte_botao_abrir_ordem ); 
   ObjectSetInteger( 0,"obj_botao_abrir_sell",OBJPROP_COLOR, text_color_botao_abrir_ordem ); 
   ObjectSetInteger( 0,"obj_botao_abrir_sell",OBJPROP_BGCOLOR, bg_color_botao_abrir_ordem ); 
   ObjectSetInteger( 0,"obj_botao_abrir_sell",OBJPROP_BORDER_COLOR, color_border_botao_abrir_ordem ); 

   return( INIT_SUCCEEDED );
}

// Paínel onde se encontra os parâmetros de p/ abertura ordem.
int func_criacao_obj_painel_entrada()
{

    int x_distancia  = 210;
    int y_distancia  = 120;
    int x_size       = 130;
    int y_size       = 220;
    color cor_fundo  = clrBlack;
    int tipo_borda   = BORDER_FLAT;
    color cor_borda  = clrYellow;

    if ( !ObjectCreate( 0,"painel_entrada",OBJ_RECTANGLE_LABEL,0,0,0 ) )
       return(INIT_FAILED );
       
    ObjectSetInteger( 0, "painel_entrada",OBJPROP_CORNER, CORNER_LEFT_UPPER );
    ObjectSetInteger( 0, "painel_entrada",OBJPROP_XDISTANCE,    x_distancia);    
    ObjectSetInteger( 0, "painel_entrada",OBJPROP_YDISTANCE,    y_distancia);
    ObjectSetInteger( 0, "painel_entrada",OBJPROP_XSIZE,        x_size);
    ObjectSetInteger( 0, "painel_entrada",OBJPROP_YSIZE,        y_size);
    ObjectSetInteger( 0, "painel_entrada",OBJPROP_BGCOLOR,      cor_fundo);
    ObjectSetInteger( 0, "painel_entrada",OBJPROP_BORDER_TYPE,  tipo_borda);
    ObjectSetInteger( 0, "painel_entrada",OBJPROP_COLOR, cor_borda);
    //--- definir a largura da borda plana
   ObjectSetInteger( 0 ,"painel_entrada", OBJPROP_WIDTH, 2);
    
    return 0;
}

int func_criacao_label_take()
{

   int    tam_fonte_label_take = 12;
   string fonte_label_take     = "Agency FB";
   color  cor_label_take       = clrRed;
   color  cor_fundo_take       = clrRed;
   int    dist_horizontal_take = 217;
   int    dist_vertical_take   = 130;

   if ( !ObjectCreate( 0, "label_take" , OBJ_LABEL, 0, 0, 0 ) )
       return ( INIT_FAILED );
       
   ObjectSetInteger( 0, "label_take", OBJPROP_CORNER, CORNER_LEFT_UPPER );
   ObjectSetInteger( 0, "label_take", OBJPROP_ANCHOR, ANCHOR_LEFT_UPPER );
   ObjectSetInteger( 0, "label_take", OBJPROP_XDISTANCE, dist_horizontal_take );  
   ObjectSetInteger( 0, "label_take", OBJPROP_YDISTANCE, dist_vertical_take );  
   ObjectSetInteger( 0, "label_take", OBJPROP_COLOR, cor_label_take );
   ObjectSetInteger( 0, "label_take", OBJPROP_FONTSIZE, tam_fonte_label_take );
   ObjectSetString( 0, "label_take", OBJPROP_TEXT, "TakeProfit" ); 
   ObjectSetString( 0, "label_take", OBJPROP_FONT, fonte_label_take );  
    
   return ( INIT_SUCCEEDED );
}

int func_criacao_label_stop()
{

   int    tam_fonte_label_stop  = 12;
   string fonte_label_stop      = "Agency FB";
   color  cor_label_stop        = clrRed;
   color  cor_fundo_stop        = clrRed;
   int    dist_horizontal_stop  = 217;
   int    dist_vertical_stop    = 147;


   if ( !ObjectCreate( 0, "label_stop" , OBJ_LABEL, 0, 0, 0 ) )
       return ( INIT_FAILED );
       
   ObjectSetInteger( 0, "label_stop", OBJPROP_CORNER, CORNER_LEFT_UPPER );
   ObjectSetInteger( 0, "label_stop", OBJPROP_ANCHOR, ANCHOR_LEFT_UPPER );
   ObjectSetInteger( 0, "label_stop", OBJPROP_XDISTANCE, dist_horizontal_stop );  
   ObjectSetInteger( 0, "label_stop", OBJPROP_YDISTANCE, dist_vertical_stop);  
   ObjectSetInteger( 0, "label_stop", OBJPROP_COLOR, cor_label_stop );
   ObjectSetInteger( 0, "label_stop", OBJPROP_FONTSIZE, tam_fonte_label_stop );
   ObjectSetString( 0, "label_stop", OBJPROP_TEXT, "StopLoss" );  
   ObjectSetString( 0, "label_stop", OBJPROP_FONT, fonte_label_stop );
     
   return ( INIT_SUCCEEDED );
}

int func_criacao_label_trailling()
{

   int    tam_fonte_label_trailing  = 12;
   string fonte_label_trailing      = "Agency FB";
   color  cor_label_trailing        = clrRed;
   color  cor_fundo_trailing        = clrRed;
   int    dist_horizontal_trailing  = 217;
   int    dist_vertical_trailing    = 164;

   if ( !ObjectCreate( 0, "label_trailling" , OBJ_LABEL, 0, 0, 0 ) )
       return ( INIT_FAILED );
       
   ObjectSetInteger( 0, "label_trailling", OBJPROP_CORNER, CORNER_LEFT_UPPER );
   ObjectSetInteger( 0, "label_trailling", OBJPROP_ANCHOR, ANCHOR_LEFT_UPPER );
   ObjectSetInteger( 0, "label_trailling", OBJPROP_XDISTANCE, dist_horizontal_trailing );  
   ObjectSetInteger( 0, "label_trailling", OBJPROP_YDISTANCE, dist_vertical_trailing );  
   ObjectSetInteger( 0, "label_trailling", OBJPROP_COLOR, cor_label_trailing );
   ObjectSetInteger( 0, "label_trailling", OBJPROP_FONTSIZE, tam_fonte_label_trailing );
   ObjectSetString( 0, "label_trailling", OBJPROP_TEXT, "TrallingStop" );  
   ObjectSetString( 0, "label_trailling", OBJPROP_FONT, fonte_label_trailing );
    
   return ( INIT_SUCCEEDED );
}

int func_criacao_edit_take()
{

   int    tam_fonte_edit_take    = 10;
   string tipo_fonte_edit_take   = "Agency FB";
   int    x_distancia_edit_take  = 287;
   int    y_distancia_edit_take  = 130;
   int    x_size_edit_take       = 30;
   int    y_size_edit_take       = 17;
   color  bg_color_edit_take     = clrAqua;
   color  text_color_edit_take   = clrBlack;
   color  color_border_edit_take = clrSilver;

   
   if ( !ObjectCreate( 0, "obj_edit_take", OBJ_EDIT, 0, 0, 0 ) )
      return ( INIT_FAILED );
        
   ObjectSetInteger( 0,"obj_edit_take", OBJPROP_XDISTANCE,    x_distancia_edit_take); 
   ObjectSetInteger( 0,"obj_edit_take", OBJPROP_YDISTANCE,    y_distancia_edit_take); 
   ObjectSetInteger( 0,"obj_edit_take", OBJPROP_XSIZE,        x_size_edit_take); 
   ObjectSetInteger( 0,"obj_edit_take", OBJPROP_YSIZE,        y_size_edit_take); 
   ObjectSetInteger( 0,"obj_edit_take", OBJPROP_CORNER,       CORNER_LEFT_UPPER ); 
   ObjectSetString ( 0,"obj_edit_take", OBJPROP_TEXT,         IntegerToString(300) ); 
   ObjectSetString ( 0,"obj_edit_take", OBJPROP_FONT,         tipo_fonte_edit_take ); 
   ObjectSetInteger( 0,"obj_edit_take", OBJPROP_FONTSIZE,     tam_fonte_edit_take); 
   ObjectSetInteger( 0,"obj_edit_take", OBJPROP_COLOR,        text_color_edit_take); 
   ObjectSetInteger( 0,"obj_edit_take", OBJPROP_BGCOLOR,      bg_color_edit_take); 
   ObjectSetInteger( 0,"obj_edit_take", OBJPROP_BORDER_COLOR, color_border_edit_take ); 
   ObjectSetInteger( 0,"obj_edit_take", OBJPROP_ALIGN,        ALIGN_CENTER );
   
   return ( INIT_SUCCEEDED );
}

int func_criacao_edit_stop()
{

   int    tam_fonte_edit_stop    = 10;
   string tipo_fonte_edit_stop   = "Agency FB";
   int    x_distancia_edit_stop  = 287;
   int    y_distancia_edit_stop  = 147;
   int    x_size_edit_stop       = 30;
   int    y_size_edit_stop       = 17;
   color  bg_color_edit_stop     = clrAqua;
   color  text_color_edit_stop   = clrBlack;
   color  color_border_edit_stop = clrSilver;

   
   if ( !ObjectCreate( 0, "obj_edit_stop", OBJ_EDIT, 0, 0, 0 ) )
      return ( INIT_FAILED );
        
   ObjectSetInteger( 0,"obj_edit_stop",OBJPROP_XDISTANCE,x_distancia_edit_stop); 
   ObjectSetInteger( 0,"obj_edit_stop",OBJPROP_YDISTANCE,y_distancia_edit_stop); 
   ObjectSetInteger( 0,"obj_edit_stop",OBJPROP_XSIZE,x_size_edit_stop); 
   ObjectSetInteger( 0,"obj_edit_stop",OBJPROP_YSIZE,y_size_edit_stop); 
   ObjectSetInteger( 0,"obj_edit_stop",OBJPROP_CORNER, CORNER_LEFT_UPPER ); 
   ObjectSetString( 0,"obj_edit_stop",OBJPROP_TEXT, IntegerToString(80) ); 
   ObjectSetString( 0 ,"obj_edit_stop",OBJPROP_FONT, tipo_fonte_edit_stop ); 
   ObjectSetInteger( 0 ,"obj_edit_stop",OBJPROP_FONTSIZE, tam_fonte_edit_stop); 
   ObjectSetInteger( 0,"obj_edit_stop",OBJPROP_COLOR, text_color_edit_stop ); 
   ObjectSetInteger( 0,"obj_edit_stop",OBJPROP_BGCOLOR, bg_color_edit_stop); 
   ObjectSetInteger( 0,"obj_edit_stop",OBJPROP_BORDER_COLOR, color_border_edit_stop); 
   ObjectSetInteger( 0,"obj_edit_stop",OBJPROP_ALIGN, ALIGN_CENTER );
   return ( INIT_SUCCEEDED );
}

int func_criacao_edit_trailling()
{
   
   int    tam_fonte_edit_trailling    = 10;
   string tipo_fonte_edit_trailling   = "Agency FB";
   int    x_distancia_edit_trailling  = 287;
   int    y_distancia_edit_trailling  = 164;
   int    x_size_edit_trailling       = 30;
   int    y_size_edit_trailling       = 17;
   color  bg_color_edit_trailling     = clrAqua;
   color  text_color_edit_trailling   = clrBlack;
   color  color_border_edit_trailling = clrSilver;

   if ( !ObjectCreate( 0, "obj_edit_trailling", OBJ_EDIT, 0, 0, 0 ) )
      return ( INIT_FAILED );
        
   ObjectSetInteger( 0,"obj_edit_trailling", OBJPROP_XDISTANCE,    x_distancia_edit_trailling); 
   ObjectSetInteger( 0,"obj_edit_trailling", OBJPROP_YDISTANCE,    y_distancia_edit_trailling); 
   ObjectSetInteger( 0,"obj_edit_trailling", OBJPROP_XSIZE,        x_size_edit_trailling); 
   ObjectSetInteger( 0,"obj_edit_trailling", OBJPROP_YSIZE,        y_size_edit_trailling); 
   ObjectSetInteger( 0,"obj_edit_trailling", OBJPROP_CORNER,       CORNER_LEFT_UPPER ); 
   ObjectSetString ( 0,"obj_edit_trailling", OBJPROP_TEXT,         IntegerToString(0) ); 
   ObjectSetString ( 0,"obj_edit_trailling",OBJPROP_FONT,          tipo_fonte_edit_trailling); 
   ObjectSetInteger( 0,"obj_edit_trailling",OBJPROP_FONTSIZE,      tam_fonte_edit_trailling); 
   ObjectSetInteger( 0,"obj_edit_trailling", OBJPROP_COLOR,        text_color_edit_trailling); 
   ObjectSetInteger( 0,"obj_edit_trailling", OBJPROP_BGCOLOR,      bg_color_edit_trailling); 
   ObjectSetInteger( 0,"obj_edit_trailling", OBJPROP_BORDER_COLOR, color_border_edit_trailling ); 
   ObjectSetInteger( 0,"obj_edit_trailling", OBJPROP_ALIGN,        ALIGN_CENTER );
   
   return ( INIT_SUCCEEDED );
}

// Atualiza os objetos do paínel.
int func_redraw_valores_pc()
{
    double em_real = NormalizeDouble( func_lucro_preju_diario( -1 ) * cotacao_dolar, 2 ); 
       
    ObjectSetString( 0, "label_obj_cp_valor_simbolo"             , OBJPROP_TEXT, ": " + simbolo_painel_esquerdo );
    ObjectSetString( 0, "label_obj_cp_valor_tipoConta"           , OBJPROP_TEXT, ": " + tipo_conta_painel_esquerdo );
    ObjectSetString( 0, "label_obj_cp_valor_valorPip"            , OBJPROP_TEXT, ": " + DoubleToString ( valor_pip_painel_esquerdo             , 2 ) );    
    ObjectSetString( 0, "label_obj_cp_valor_lucroAndamento"      , OBJPROP_TEXT, ": " + DoubleToString ( lucro_andamento_painel_esquerdo       , 2 ) );
    ObjectSetString( 0, "label_obj_cp_valor_lucroDiario"         , OBJPROP_TEXT, ": " + DoubleToString ( lucro_diario_painel_esquerdo          , 2 )+" / "+ DoubleToString( em_real, 2 ) );
    ObjectSetString( 0, "label_obj_cp_valor_lucroSemanal"        , OBJPROP_TEXT, ": " + DoubleToString ( lucro_semanal_painel_esquerdo         , 2 ) );
    ObjectSetString( 0, "label_obj_cp_valor_lucromenssal"        , OBJPROP_TEXT, ": " + DoubleToString ( lucro_menssal_painel_esquerdo         , 2 ) );
    ObjectSetString( 0, "label_obj_cp_valor_total_depositado"    , OBJPROP_TEXT, ": " + DoubleToString ( total_depositado_painel_esquerdo      , 2 ) );
    ObjectSetString( 0, "label_obj_cp_valor_total_resgate"       , OBJPROP_TEXT, ": " + DoubleToString ( total_regate_painel_esquerdo          , 2 ) );
    ObjectSetString( 0, "label_obj_cp_valor_ultimoDeposito"      , OBJPROP_TEXT, ": " + DoubleToString ( ultimo_deposito_painel_esquerdo       , 2 ) );
    ObjectSetString( 0, "label_obj_cp_valor_profitPositDiario"   , OBJPROP_TEXT, ": " + DoubleToString ( profit_positivo_diario_painel_esquerdo, 2 ) );
    ObjectSetString( 0, "label_obj_cp_valor_profitNegatDiario"   , OBJPROP_TEXT, ": " + DoubleToString ( profit_negativo_diario_painel_esquerdo, 2 ) );
    ObjectSetString( 0, "label_obj_cp_valor_ordensPositivasAtual", OBJPROP_TEXT, ": " + IntegerToString( ordens_positivas_atuais_painel_esquerdo ) );
    ObjectSetString( 0, "label_obj_cp_valor_ordensNegativasAtual", OBJPROP_TEXT, ": " + IntegerToString( ordens_negativas_atuais_painel_esquerdo ) );
    ObjectSetString( 0, "label_obj_cp_valor_ordensTakeDiario"    , OBJPROP_TEXT, ": " + IntegerToString( num_ordens_take_diario_painel_esquerdo  ) );
    ObjectSetString( 0, "label_obj_cp_valor_ordensStopDiario"    , OBJPROP_TEXT, ": " + IntegerToString( num_ordens_stop_diario_painel_esquerdo  ) );
    //ObjectSetString ( 0, "label_obj_cp_valor_profit_conta_total",  OBJPROP_TEXT, ": " +"[+"+DoubleToString(retorna_dados_conta( 3 ),2)+"/"+DoubleToString(retorna_dados_conta( 2 ), 2)+"]" );
    //ObjectSetString( 0, "obj_label_real_profit",                   OBJPROP_TEXT, ": ");
    
    // Atualizando Profit's monetários em andamento label( valores ) - retângulos.
    ObjectSetString( 0, "obj_label_positivo_retangulo", OBJPROP_TEXT, "+" + DoubleToString( profit_positivo_and_retangulo , 2 ) );
    ObjectSetString( 0, "obj_label_negativo_retangulo", OBJPROP_TEXT,       DoubleToString( profit_negativo_and_retangulo , 2 ) );
    ObjectSetString( 0, "obj_label_real_profit"       , OBJPROP_TEXT, "R$"+ DoubleToString( profit_total_convert_retangulo, 2 ) ); 
    
    // Atualizando estatística do lado direito.     
    ObjectSetString( 0,"label_spread_valor"     ,OBJPROP_TEXT, ": "+spread_painel_direito);
    ObjectSetString( 0,"label_swap_compra_valor",OBJPROP_TEXT, ": "+DoubleToString ( swap_comprado_painel_direito, 2 ) );    
    ObjectSetString( 0,"label_swap_venda_valor" ,OBJPROP_TEXT, ": "+DoubleToString ( swap_vendido_painel_direito, 2 ) );    
    ObjectSetString( 0,"label_novo_candle_valor",OBJPROP_TEXT, ": "+falta_char_candle_painel_direito );
    
    ObjectSetString( 0,"label_valor_take",OBJPROP_TEXT, DoubleToString ( valor_monetario_take, 2 ) );    
    ObjectSetString( 0,"label_valor_stop",OBJPROP_TEXT, DoubleToString ( valor_monetario_stop, 2 ) ); 
    
    return ( 0 );
}
  
int func_criacao_painel_direito()
{
    color backgroud = clrGold;
    
    ENUM_BASE_CORNER  corner            = CORNER_RIGHT_UPPER; // A coordenada está no canto superior direito.
    ENUM_ANCHOR_POINT anchor_declaracao = ANCHOR_RIGHT_UPPER; // Ponto de ancoragem( Declaração ).
    ENUM_ANCHOR_POINT anchor_valor      = ANCHOR_LEFT_UPPER; // Ponto de ancoragem( Declaração ).
     
    if ( ObjectCreate ( 0, "label_spread",            OBJ_LABEL,0, 0, 0 ) == NULL )return ( INIT_FAILED );    
    if ( ObjectCreate ( 0, "label_spread_valor",      OBJ_LABEL,0, 0, 0 ) == NULL )return ( INIT_FAILED );
    if ( ObjectCreate ( 0, "label_swap_compra",       OBJ_LABEL,0, 0, 0 ) == NULL )return ( INIT_FAILED );  
    if ( ObjectCreate ( 0, "label_swap_compra_valor", OBJ_LABEL,0, 0, 0 ) == NULL )return ( INIT_FAILED );
    if ( ObjectCreate ( 0, "label_swap_venda",        OBJ_LABEL,0, 0, 0 ) == NULL )return ( INIT_FAILED );
    if ( ObjectCreate ( 0, "label_swap_venda_valor",  OBJ_LABEL,0, 0, 0 ) == NULL )return ( INIT_FAILED );
    if ( ObjectCreate ( 0, "label_novo_candle",       OBJ_LABEL,0, 0, 0 ) == NULL )return ( INIT_FAILED );
    if ( ObjectCreate ( 0, "label_novo_candle_valor", OBJ_LABEL,0, 0, 0 ) == NULL )return ( INIT_FAILED );   
    
    ObjectSetInteger ( 0, "label_spread", OBJPROP_CORNER,    corner );
    ObjectSetInteger ( 0, "label_spread", OBJPROP_ANCHOR,    anchor_declaracao ); 
    ObjectSetInteger ( 0, "label_spread", OBJPROP_XDISTANCE, 57 );  
    ObjectSetInteger ( 0, "label_spread", OBJPROP_YDISTANCE, 30 );
    ObjectSetInteger ( 0, "label_spread", OBJPROP_COLOR,     backgroud );
    ObjectSetString  ( 0, "label_spread", OBJPROP_TEXT,      "Spread" );
     
    ObjectSetInteger ( 0, "label_spread_valor", OBJPROP_CORNER,    corner ); 
    ObjectSetInteger ( 0, "label_spread_valor", OBJPROP_ANCHOR,    anchor_valor );
    ObjectSetInteger ( 0, "label_spread_valor", OBJPROP_XDISTANCE, 47 );  
    ObjectSetInteger ( 0, "label_spread_valor", OBJPROP_YDISTANCE, 30 );
    ObjectSetInteger ( 0, "label_spread_valor", OBJPROP_COLOR,     backgroud );
    ObjectSetString  ( 0, "label_spread_valor", OBJPROP_TEXT,      ": "+0 );
    
    // =======================================================================
    
    ObjectSetInteger ( 0, "label_swap_compra", OBJPROP_CORNER,    corner); 
    ObjectSetInteger ( 0, "label_swap_compra", OBJPROP_ANCHOR,    anchor_declaracao );
    ObjectSetInteger ( 0, "label_swap_compra", OBJPROP_XDISTANCE, 57 );  
    ObjectSetInteger ( 0, "label_swap_compra", OBJPROP_YDISTANCE, 47 );
    ObjectSetInteger ( 0, "label_swap_compra", OBJPROP_COLOR,     backgroud );
    ObjectSetString  ( 0, "label_swap_compra", OBJPROP_TEXT,      "Swap Compra" );
    
    ObjectSetInteger ( 0, "label_swap_compra_valor", OBJPROP_CORNER,    corner);
    ObjectSetInteger ( 0, "label_swap_compra_valor", OBJPROP_ANCHOR,    anchor_valor );
    ObjectSetInteger ( 0, "label_swap_compra_valor", OBJPROP_XDISTANCE, 47 );  
    ObjectSetInteger ( 0, "label_swap_compra_valor", OBJPROP_YDISTANCE, 47 );
    ObjectSetInteger ( 0, "label_swap_compra_valor", OBJPROP_COLOR,     backgroud );
    ObjectSetString  ( 0, "label_swap_compra_valor", OBJPROP_TEXT,      ": 0.0" );
    
    // =======================================================================
    
    ObjectSetInteger ( 0, "label_swap_venda",  OBJPROP_CORNER,    corner);
    ObjectSetInteger ( 0, "label_swap_venda",  OBJPROP_ANCHOR,    anchor_declaracao );
    ObjectSetInteger ( 0, "label_swap_venda",  OBJPROP_XDISTANCE, 57 );  
    ObjectSetInteger ( 0, "label_swap_venda",  OBJPROP_YDISTANCE, 64 );
    ObjectSetInteger ( 0, "label_swap_venda",  OBJPROP_COLOR,     backgroud );
    ObjectSetString  ( 0, "label_swap_venda",  OBJPROP_TEXT,      "Swap Venda" );
 
    ObjectSetInteger ( 0, "label_swap_venda_valor", OBJPROP_CORNER,    corner); 
    ObjectSetInteger ( 0, "label_swap_venda_valor", OBJPROP_ANCHOR,    anchor_valor );
    ObjectSetInteger ( 0, "label_swap_venda_valor", OBJPROP_XDISTANCE, 47 );  
    ObjectSetInteger ( 0, "label_swap_venda_valor", OBJPROP_YDISTANCE, 64 );
    ObjectSetInteger ( 0, "label_swap_venda_valor", OBJPROP_COLOR,     backgroud );
    ObjectSetString  ( 0, "label_swap_venda_valor", OBJPROP_TEXT,      ": 0.0" );
    // =======================================================================
    
    ObjectSetInteger ( 0, "label_novo_candle",       OBJPROP_CORNER,    corner); 
    ObjectSetInteger ( 0, "label_novo_candle",       OBJPROP_ANCHOR,    anchor_declaracao );
    ObjectSetInteger ( 0, "label_novo_candle",       OBJPROP_XDISTANCE, 57 );  
    ObjectSetInteger ( 0, "label_novo_candle",       OBJPROP_YDISTANCE, 81 );
    ObjectSetInteger ( 0, "label_novo_candle",       OBJPROP_COLOR,     backgroud );
    ObjectSetString  ( 0, "label_novo_candle",       OBJPROP_TEXT,      "Candle fecha em" );
     
    ObjectSetInteger ( 0, "label_novo_candle_valor", OBJPROP_CORNER,    corner );
    ObjectSetInteger ( 0, "label_novo_candle_valor", OBJPROP_ANCHOR,    anchor_valor );
    ObjectSetInteger ( 0, "label_novo_candle_valor", OBJPROP_XDISTANCE, 47 );  
    ObjectSetInteger ( 0, "label_novo_candle_valor", OBJPROP_YDISTANCE, 81 );
    ObjectSetInteger ( 0, "label_novo_candle_valor", OBJPROP_COLOR,     backgroud );
    ObjectSetString  ( 0, "label_novo_candle_valor", OBJPROP_TEXT,      ": 00:00" );
    
    return true;    
}

void inicializa_obj_param_entrada( ENUM_ORDER_TYPE buy_sell )
{ 
   
   take_profit_param         = StringToInteger( ObjectGetString( 0, "obj_edit_take",              OBJPROP_TEXT ) );
   stop_loss_param           = StringToInteger( ObjectGetString( 0, "obj_edit_stop",              OBJPROP_TEXT ) );
   trailling_stop_param      = StringToInteger( ObjectGetString( 0, "obj_edit_trailling",         OBJPROP_TEXT ) );
   preservar_capital_param   = StringToInteger( ObjectGetString( 0, "obj_edit_preservar_capital", OBJPROP_TEXT ) );
   percentagem_entrada_param = StringToDouble ( ObjectGetString( 0, "obj_edit_risco_capital",     OBJPROP_TEXT ) );

}

string func_novo_candle()
{
    long        seconds_period = PeriodSeconds( PERIOD_CURRENT );
    long        time           = iTime ( _Symbol, PERIOD_CURRENT, 0 ); // Retorna o valor do tempo de abertura da barra .
    datetime    tempo_falta    = ( seconds_period - ( TimeCurrent() - time ) ); 
    MqlDateTime str_diff_time;
    TimeToStruct( tempo_falta, str_diff_time );
    
    string retorno = str_diff_time.min+"."+str_diff_time.sec; 
    
    return retorno;
}

bool criando_messageBox( double valor_take, 
                         double valor_stop )
{
    
    bool retorno = false;
    
    int pressButton = MessageBox( "Símbolo : " + _Symbol +
    "\nVolume     : " + str_abertura_ordem.volume+
    "\nTakeProfit : " + take_profit_param + " / Valor Monetário : " + DoubleToString ( valor_take, 2 ) +
    "\nStopLoss   : " + stop_loss_param   + " / Valor Monetário : " + DoubleToString ( valor_stop, 2 ) ,
    "\nInformações de Entrada a Mercado", MB_OKCANCEL );
    
    if ( pressButton == 1 )
      retorno = true;     
      
    return retorno;  
}
  