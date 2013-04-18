unit dAimBB;
{< [ Array In Memory ] in0k © 21.03.2012
//----------------------------------------------------------------------------//
// версия    : 4.0
// библиотека: динамический массив: [Byte(length)|Byte(item)..]
// =ATENTION=: МАЛО проверок в боевом Варианте
//----------------------------------------------------------------------------//}
//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//
//                                                                            //
//                     O~~                                                    //
//                     O~~      o    ooooo oooo     oooo                      //
//                 O~~ O~~     888    888   8888o   888                       //
//                O~   O~~    8  88   888   88 888o8 88                       //
//                O~   O~~   8oooo88  888   88  888  88                       //
//                 O~~ O~~ o88o  o888o888o o88o  8  o88o                      //
//                                                                            //
//----------------------------------------------------------------------------//
//                                                                            \\
//  расход памяти [*]                                                         //
//  =============                                                             \\
//    sizeOf(Array,n,z) == sizeOf(tLength) + n*sizeOf(tItem)                  //
//      где:                                                                  \\
//      tLength - тип для ДЛИНЫ массива                                       //
//      tItem   - тип для ЭЛЕМЕНТА массива                                    \\
//      n       - кол-во эл в массиве                                         //
//                                                                            \\
//----------------------------------------------------------------------------//
interface
{%region /fold}//<---------------------------------------[ compiler directives ]
{}                                                                            {}
{}  //===== по КОМПИЛЯТОРУ =============                                      {}
{}  {$ifdef fpc} //<-- {FPC-Lazarus}                                          {}
{}    {$mode delphi} //< для пущей совместимости  с Delphi                    {}
{}    {$define _INLINE_}                                                      {}
{}  {$else} //---//<-- {Delphi}                                               {}
{}    {$IFDEF SUPPORTS_INLINE}                                                {}
{}      {$define _INLINE_}                                                    {}
{}    {$endif}                                                                {}
{}  {$endif}                                                                  {}
{}                                                                            {}
{}  //===== финальные обобщения ========                                      {}
{}  {$ifOpt D+} //< режим дебуга ВКЛЮЧЕН { "боевой" INLINE }                  {}
{}    {$undef _INLINE_} //< дeбугить просче БЕЗ INLIN`а                       {}
{}  {$endif}                                                                  {}
{}                                                                            {}
{%endregion}//<------------------------------------------[ compiler directives ]
{$define _DEBUG_}
{$define _INLINE_}
//------------------------------------------------------------------------------
{$ifdef _DEBUG_} uses sysutils{$endif}; //< для отлова ДИНАМИЧЕСКИХ ошибок в дебаге

//-=-=-=-=-=-=-//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=//
//     #       //  ФУНКЦИОНАЛ для работы с массивом
//-=-=-=-=-=-=-//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=//

procedure dAimBB_INITialize(var   dAIM:pointer);                                           {$ifdef _INLINE_} inline; {$endif} overload;
procedure dAimBB_INITialize(var   dAIM:pointer; const Length:byte);                        {$ifdef _INLINE_} inline; {$endif} overload;
procedure dAimBB_INITialize(var   dAIM:pointer; const Length:byte; const defItemVAL:byte); {$ifdef _INLINE_} inline; {$endif} overload;
procedure dAimBB_initVALUES(var   dAIM:pointer; const Value :byte);                        {$ifdef _INLINE_} inline; {$endif}

procedure dAimBB_FINAL     (var   dAIM:pointer);                                           {$ifdef _INLINE_} inline; {$endif}
procedure dAimBB_FINALize  (var   dAIM:pointer);                                           {$ifdef _INLINE_} inline; {$endif}

//{длинна массива}--------------------------------------------------------------

function  dAimBB_getLength (const dAIM:pointer):byte;                                      {$ifdef _INLINE_} inline; {$endif} overload;
procedure dAimBB_setLength (var   dAIM:pointer; const Value:byte);                         {$ifdef _INLINE_} inline; {$endif} overload;
procedure dAimBB_setLength (var   dAIM:pointer; const Value:byte; const defItemVAL:byte);  {$ifdef _INLINE_} inline; {$endif} overload;

//{Добавить Удалить}------------------------------------------------------------

procedure dAimBB_itemsADD  (var   dAIM:pointer; const Index:byte; const Count:byte);                        {$ifdef _INLINE_} inline; {$endif} overload;
procedure dAimBB_itemsADD  (var   dAIM:pointer; const Index:byte; const Count:byte; const defItemVAL:byte); {$ifdef _INLINE_} inline; {$endif} overload;
procedure dAimBB_itemsDEL  (var   dAIM:pointer; const Index:byte; const Count:byte);                        {$ifdef _INLINE_} inline; {$endif} overload;

//{ЭЛЕМЕНТ}---------------------------------------------------------------------

function  dAimBB_clc_pItem (const dAIM:pointer; const Index:byte):pointer;           {$ifdef _INLINE_} inline; {$endif}
function  dAimBB_get_pItem (const dAIM:pointer; const Index:byte):pointer;           {$ifdef _INLINE_} inline; {$endif}

function  dAimBB_get___Val (const dAIM:pointer; const Index:byte):byte;              {$ifdef _INLINE_} inline; {$endif}
function  dAimBB_get_Value (const dAIM:pointer; const Index:byte):byte;              {$ifdef _INLINE_} inline; {$endif}
procedure dAimBB_set___Val (const dAIM:pointer; const Index:byte; const Value:byte); {$ifdef _INLINE_} inline; {$endif}
procedure dAimBB_set_Value (const dAIM:pointer; const Index:byte; const Value:byte); {$ifdef _INLINE_} inline; {$endif}

//{поиск}-----------------------------------------------------------------------

function  dAimBB_fnd_Value (const dAIM:pointer; const Value:byte; out   Index:byte):boolean; {$ifdef _INLINE_} inline; {$endif}

implementation

//--//--- установочные данные для работы с Массивом ----------------------//--//
type
  {[users]dAIM тип -- ДЛИННА массива, определяет размер памяти для хранения длины}
  _tUsrDAIM_tLength_=  byte;
  {[users]dAIM тип -- ЭЛЕМЕНТ массива}
  _tUsrDAIM_tItem_  =  byte;
//--//--------------------------------------------------------------------//--//

// CORE - типа ядро, тапа вообще нна-да, важное короче
//------------------------------------------------------------------------------
{$I inkDAim_CORE.inc}

// INITialize
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] ИНИЦИАЛИЗИРОВАТЬ пустой массив }
procedure dAimBB_INITialize(var dAIM:pointer);
begin
  {$i inkDAim_prcBODY_00v0_INITialize.inc}
end;

{-D-[ Array in Mem ] ИНИЦИАЛИЗИРОВАТЬ
  @param (dAIM   обрабатываемый массив)
  @param (Length количесво элементов)
  }
procedure dAimBB_INITialize(var dAIM:pointer; const Length:_tInkDAIM_tLength_);
begin
  {$i inkDAim_prcBODY_00v1_INITialize.inc}
end;

{-D-[ Array in Mem ] ИНИЦИАЛИЗИРОВАТЬ массив ЗНАЧЕНИЯМИ
  @param (dAIM   обрабатываемый массив)
  @param (Length количесво элементов)
  @param (Value  значение, которое будет помещено в КАЖДЫЙ элемент)
  }
procedure dAimBB_INITialize(var dAIM:pointer; const Length:_tInkDAIM_tLength_; const defItemVAL:_tInkDAIM_tItem_);
begin
  {$i inkDAim_prcBODY_00v2_INITialize.inc}
end;

{-D-[ Array in Mem ] ЗАПОЛНИТЬ созданный массив ЗНАЧЕНИЯМИ
  @param (dAIM  обрабатываемый массив)
  @param (Value значение, которое будет помещено в КАЖДЫЙ элемент)
  }
procedure dAimBB_initVALUES(var dAIM:pointer; const Value:_tInkDAIM_tItem_);
begin
  {$i inkDAim_prcBODY_01v0_initVALUES.inc}
end;

// FINALized
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] ФИНАЛИЗИРОВАТЬ массив, ТОЛЬКО очистить память }
procedure dAimBB_FINAL(var dAIM:pointer);
begin
  {$i inkDAim_prcBODY_FFv0_FINALize.inc}
end;

{-D-[ Array in Mem ] ФИНАЛИЗИРОВАТЬ массив, очистить память. dAIM===NIL }
procedure dAimBB_FINALize(var dAIM:pointer);
begin
  {$i inkDAim_prcBODY_FFv1_FINALize.inc}
end;

// ...Length
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] получить ДЛИННУ массива }
function dAimBB_getLength(const dAIM:pointer):_tUsrDAIM_tLength_;
begin
  {$i inkDAim_prcBODY_02v0_getLength.inc}
end;

{-D-[ Array in Mem ] Установить длину массива
  @param (AIM    обрабатываемый массив)
  @param (Value  НОВАЯ длина)
  }
procedure dAimBB_setLength(var dAIM:pointer; const Value:_tUsrDAIM_tLength_);
begin
  {$i inkDAim_prcBODY_03v1_setLength.inc}
end;

{-D-[ Array in Mem ] Установить длину массива
  @param (AIM        обрабатываемый массив)
  @param (Value      НОВАЯ длина)
  @param (defItemVAL значение элемента по умолчанию)
  ---
  *! если в массив будут добавленны НОВЫЕ элементы, то их значение установится в defItemVAL
  }
procedure dAimBB_setLength(var dAIM:pointer; const Value:_tUsrDAIM_tLength_; const defItemVAL:_tInkDAIM_tItem_);
begin
  {$i inkDAim_prcBODY_03v2_setLength.inc}
end;

// ДОБАВИТЬ
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] Добавть элементы в массив
  @param (AIM    обрабатываемый массив)
  @param (Index  индекс элемента, НАЧИНАЯ с которого, будут добавленны Новые)
  @param (Count  количество добавляемых элементов)
  ---
  *! если Index больше длинны массива, то массив будет УВЕЛИЧЕН до необходимого
     размера, тоесть до длинны Index+Count
  }
procedure dAimBB_itemsADD(var dAIM:pointer; const Index:_tInkDAIM_tIndex_; const Count:_tUsrDAIM_tLength_);
begin
  {$i inkDAim_prcBODY_0Av1_itemsADD.inc}
end;

{-D-[ Array in Mem ] Добавть элементы в массив
  @param (AIM        обрабатываемый массив)
  @param (Index      индекс элемента, НАЧИНАЯ с которого, будут добавленны Новые)
  @param (Count      количество добавляемых элементов)
  @param (defItemVAL значение элемента по умолчанию)
  ---
  *! если Index больше длинны массива, то массив будет УВЕЛИЧЕН до необходимого
     размера, тоесть до длинны Index+Count
  *! если в массив будут добавленны НОВЫЕ элементы, то их значение установится в defItemVAL
  }
procedure dAimBB_itemsADD(var dAIM:pointer; const Index:_tInkDAIM_tIndex_; const Count:_tUsrDAIM_tLength_; const defItemVAL:_tInkDAIM_tItem_);
begin
  {$i inkDAim_prcBODY_0Av2_itemsADD.inc}
end;

// DEL
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] Удалить элементы из массива
  @param (AIM    обрабатываемый массив)
  @param (Index  индекс элемента, НАЧИНАЯ с которого, будут УДАЛЕНЫ)
  @param (Count  количество удаляемых элементов)
  ---
  *! проверка dAIM--неПуст ТОЛЬКО в режиме "DEBUG"
  }
procedure dAimBB_itemsDEL(var dAIM:pointer; const Index:_tInkDAIM_tIndex_; const Count:_tUsrDAIM_tLength_);
begin
  {$i inkDAim_prcBODY_0Dv1_itemsDEL.inc}
end;

// ..pItem
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] расчитать указатель на элемент массива
  @param (AIM    обрабатываемый массив)
  @param (Index  номер интерисуемого элемента)
  @return(указатель на элемент)
  ---
  *! проверка dAIM--неПуст ТОЛЬКО в режиме "DEBUG"
  *! сообщение о вылете за диапазон ТОЛЬКО в режиме "DEBUG"
  }
function dAimBB_clc_pItem(const dAIM:pointer; const Index:_tInkDAIM_tIndex_):pointer;
begin
   {$i inkDAim_prcBODY_04v1_pItem.inc}
end;

{-D-[ Array in Mem ] Получить указатель на элемент массива
  @param (AIM    обрабатываемый массив)
  @param (Index  номер интерисуемого элемента)
  @return(указатель на элемент; nil - вне диапазона)
  ---
  *! ВСЕ проверки
  }
function dAimBB_get_pItem(const dAIM:pointer; const Index:_tInkDAIM_tIndex_):pointer;
begin
   {$i inkDAim_prcBODY_04v2_pItem.inc}
end;

// ..getVALUE
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] ПОЛУЧИТЬ значение элемента массива
  @param (AIM    обрабатываемый массив)
  @param (Index  номер интерисуемого элемента)
  @return(значение элемента)
  ---
  *! БЕЗ проверки !!! при вылете из диапазонва возможен крах !!!
  *! сообщение о вылете за диапазон ТОЛЬКО в режиме "DEBUG"
  }
function dAimBB_get___Val(const dAIM:pointer; const Index:_tInkDAIM_tIndex_):_tInkDAIM_tItem_;
begin
   {$i inkDAim_prcBODY_09v1_getValue.inc}
end;

{-D-[ Array in Mem ] ПОЛУЧИТЬ значение элемента массива
  @param (AIM    обрабатываемый массив)
  @param (Index  номер интерисуемого элемента)
  @return(значение элемента)
  ---
  *! вне диапазона НИЧЕГО не читаем
  *! сообщение о вылете за диапазон ТОЛЬКО в режиме "DEBUG"
  }
function dAimBB_get_Value(const dAIM:pointer; const Index:_tInkDAIM_tIndex_):_tInkDAIM_tItem_;
begin
   {$i inkDAim_prcBODY_09v2_getValue.inc}
end;

// ..setVALUE
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] УСТАНОВИТЬ значение элемента массива
  @param (AIM    обрабатываемый массив)
  @param (Index  номер интерисуемого элемента)
  @param (Value  значение элемента)
  ---
  *! БЕЗ проверки !!! при вылете из диапазонва возможен крах !!!
  *! сообщение о вылете за диапазон ТОЛЬКО в режиме "DEBUG"
  }
procedure dAimBB_set___Val(const dAIM:pointer; const Index:_tInkDAIM_tIndex_; const Value:_tInkDAIM_tItem_);
begin
   {$i inkDAim_prcBODY_05v1_setValue.inc}
end;

{-D-[ Array in Mem ] УСТАНОВИТЬ значение элемента массива
  @param (AIM    обрабатываемый массив)
  @param (Index  номер интерисуемого элемента)
  @param (Value  значение элемента)
  ---
  *! вне диапазона НИЧЕГО не пишем
  *! сообщение о вылете за диапазон ТОЛЬКО в режиме "DEBUG"
  }
procedure dAimBB_set_Value(const dAIM:pointer; const Index:_tInkDAIM_tIndex_; const Value:_tInkDAIM_tItem_);
begin
   {$i inkDAim_prcBODY_05v2_setValue.inc}
end;

// ..FIND value
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] НАЙТИ значение элемента, первый встреченный
  @param (AIM    обрабатываемый массив)
  @param (Value  значение элемента)
  @param (Index  номер найденного элемента)
  @return(true - значение найдено; иначе false)
  ---
  *! подходит НЕ для всех типов !
  *! вне диапазона НИЧЕГО не пишем
  *! сообщение о вылете за диапазон ТОЛЬКО в режиме "DEBUG"
  }
function dAimBB_fnd_Value(const dAIM:pointer; const Value:_tInkDAIM_tItem_; out Index:_tInkDAIM_tIndex_):boolean;
begin
   {$i inkDAim_prcBODY_0Fv1_FIND.inc}
end;

end.
