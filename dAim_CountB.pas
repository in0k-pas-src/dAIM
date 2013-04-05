unit dAim_CountB;
{< [ Array In Memory ] in0k © 21.03.2012
//----------------------------------------------------------------------------//
// версия    : 3.0
// библиотека: НЕ типизированный "динамический массив"
// содержание: описание классов и функционал
// =ATENTION=: НИкАких проверок НЕ проводится
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
//    sizeOf(Array,n,z) == 2*sizeOf(pointer) + n*z                            //
//      где:                                                                  \\
//      n - кол-во эл в массиве                                               //
//      z - размер в байтах ОДНОГО элемента массива                           \\
//                                                                            //
//----------------------------------------------------------------------------\\
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


uses {$ifdef _DEBUG_}sysutils{$endif};     //< для отлова ДИНАМИЧЕСКИХ ошибок в дебаге

//-=-=-=-=-=-=-//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=//
//     #       //  описание ТИПОВ
//-=-=-=-=-=-=-//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=//
type
  {указатель на динамический массив}
 tDAIM=pointer;
 tDAIM_sizeOf=word;

 tDAIMb_Count=byte;
 pDAIMb_Count=^tDAIMb_count;

 tDAIMb_Index=tDAIMb_Count;

//-=-=-=-=-=-=-//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=//
//     #       //  ФУНКЦИОНАЛ для работы с массивом
//-=-=-=-=-=-=-//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=//

procedure dAimB_INITialize(var   dAIM:tDAIM);                                                                        overload; {$ifdef _INLINE_} inline; {$endif}
procedure dAimB_INITialize(var   dAIM:tDAIM; const Count:byte; const sizeOf:tDAIM_sizeOf);                           overload; {$ifdef _INLINE_} inline; {$endif}
procedure dAimB_INITialize(var   dAIM:tDAIM; const Count:byte; const sizeOf:tDAIM_sizeOf; const defItemVAL:pointer); overload; {$ifdef _INLINE_} inline; {$endif}
procedure dAimB_FINALize  (var   dAIM:tDAIM; const sizeOf:tDAIM_sizeOf); {$ifdef _INLINE_} inline; {$endif}

//{указатель на элемент}--------------------------------------------------------

function  dAimB_get_pItem (const dAIM:tDAIM; const Index:byte; const sizeOF:tDAIM_sizeOf):pointer;  {$ifdef _INLINE_} inline; {$endif}

//{длинна массива}--------------------------------------------------------------

function  dAimB_getLength (const dAIM:tDAIM):byte;                                                                   overload; {$ifdef _INLINE_} inline; {$endif}
procedure dAimB_setLength (var   dAIM:tDAIM; const Value:byte; const sizeOF:tDAIM_sizeOf; const defItemVAL:pointer); overload; {$ifdef _INLINE_} inline; {$endif}
procedure dAimB_setLength (var   dAIM:tDAIM; const Value:byte; const sizeOF:tDAIM_sizeOf);                           overload; {$ifdef _INLINE_} inline; {$endif}

//{Добавить Удалить}------------------------------------------------------------

procedure dAimB_itemsADD  (var   dAIM:tDAIM; const Index:byte; const Count:byte; const sizeOF:tDAIM_sizeOf);                           overload; {$ifdef _INLINE_} inline; {$endif}
procedure dAimB_itemsADD  (var   dAIM:tDAIM; const Index:byte; const Count:byte; const sizeOF:tDAIM_sizeOf; const defItemVAL:pointer); overload; {$ifdef _INLINE_} inline; {$endif}
procedure dAimB_itemsDEL  (var   dAIM:tDAIM; const Index:byte; const Count:byte; const sizeOF:tDAIM_sizeOf);                           overload; {$ifdef _INLINE_} inline; {$endif}

implementation

//--//--- установочные данные для работы с Массивом ----------------------//--//
type  _tDAIM_tLength_=  byte; //< тип переменной для хранения ДЛИННЫ массива
type  _tDAIM_tItem_  =  byte; //< тип ЭЛЕМЕНТА массива
//--//--------------------------------------------------------------------//--//




             _tDAIM_tIndex_ = _tDAIM_tLength_;          //< ВАЖНЮЧая
             _pDAIM_tLength_=^_tDAIM_tLength_;   //< важНей


const _cDAIM_zLength_=  sizeOf(_tDAIM_tLength_); //< ЕЩЁ важней
const _cDAIM_zItem_  =  sizeOf(_tDAIM_tItem_);   //< ЕЩЁ важней
//--//--------------------------------------------------------------------//--//

{$MACRO ON}
{$define _LENGTH_dAIM:=_pDAIM_tLength_(dAIM)^}

{$if _cDAIM_zLength_=2}
  {$ERROR}
{$endif}
// inSide function
//------------------------------------------------------------------------------
{%region ' inSide`рские фунции, то есть НЕ видимые снаружы :-) '    /hold}

function _clc_pItem(const dAIM:tDAIM; const Index:_tDAIM_tIndex_; const sizeOF:tDAIM_sizeOf):pointer; {$ifdef _INLINE_} inline; {$endif}
begin
    result:=dAIM+_cDAIM_zLength_+Index*sizeOf;
end;


{-D-[ Array in Mem ] (!!! БЕЗ проверок !!!) раскопировать значения
  @param (AIM    обрабатываемый массив)
  @param (start  указатель, с какого момента копировать)
  @param (sizeOF размер в БАЙТах одного элемента массива)
  @param (Value  указатель на значение)
  }
procedure _fillValues_(start:pointer; const Count:SizeInt; const sizeOF:tDAIM_sizeOf; const Value:pointer); {$ifdef _INLINE_} inline; {$endif}
begin
    case sizeOF of
      1 :  FillByte ( byte (start^), Count       , pByte (Value)^); //< sizeOf(byte)
      2 :  FillWord ( word (start^), Count       , pWord (Value)^); //< sizeOf(word)
      4 :  FillDWord( dWord(start^), Count       , pDWord(Value)^); //< sizeOf(word)
      8 :  FillQWord( qWord(start^), Count       , pQWord(Value)^); //< sizeOf(word)
      // косячёкс
      //      else FillByte ( byte (start^), Count*sizeOF, pByte(Value)^ ); //< sizeOf(word)
    end;
end;


{%endregion}
//------------------------------------------------------------------------------
//

// INITialize
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] ИНИЦИАЛИЗИРОВАТЬ }
procedure dAimB_INITialize(var dAIM:tDAIM);
begin
    dAIM:=NIL;
end;

{-D-[ Array in Mem ] ИНИЦИАЛИЗИРОВАТЬ }
procedure dAimB_INITialize(var dAIM:tDAIM; const Count:_tDAIM_tLength_; const sizeOf:tDAIM_sizeOf);
begin
    {$ifdef _DEBUG_}
      if Count =0 then raise Exception.Create('wrong: "Count"==0');
      if sizeOf=0 then raise Exception.Create('wrong: "sizeOf"==0');
    {$endif}
    getMem(dAIM,_cDAIM_zLength_+sizeOf*Count);
   _LENGTH_dAIM:=Count; //< записали значение Количества Элементов
end;

procedure dAimB_INITialize(var dAIM:tDAIM; const Count:_tDAIM_tLength_; const sizeOf:tDAIM_sizeOf; const defItemVAL:pointer);
begin
  {$ifdef _DEBUG_}
    if Count =0 then raise Exception.Create('wrong: "Count"==0');
    if sizeOf=0 then raise Exception.Create('wrong: "sizeOf"==0');
    if defItemVAL=nil then raise Exception.Create('wrong: "defItemVAL"==NIL');
  {$endif}
    dAimB_INITialize(dAIM,Count,sizeOf);
   _fillValues_(dAIM+_cDAIM_zLength_,Count,sizeOF,defItemVAL);
end;

// FINALized
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] ФИНАЛИЗИРОВАТЬ массив, очистить память
  @param(AIM    указатель на массив)
  @param(sizeOF размер в БАЙТах одного элемента массива)
  ---
  *! проверка sizeOf==0 ТОЛЬКО в режиме "DEBUG"
  }
procedure dAimB_FINALize(var dAIM:tDAIM; const sizeOf:tDAIM_sizeOf);
begin
    {$ifdef _DEBUG_}
        if sizeOf=0 then raise Exception.Create('wrong: "sizeOf"==0');
    {$endif}
    if dAIM<>nil then begin
        {$ifdef _DEBUG_}
          if pDAIMb_count(dAIM)^=0 then raise Exception.Create('wrong: "Count"==0');
          if sizeOf=0 then raise Exception.Create('wrong: "sizeOf"==0');
        {$endif}
        Freemem(dAIM,_cDAIM_zLength_+sizeOF*_LENGTH_dAIM); //< зачистили
        dAIM:=NIL;
    end;
end;


// ..pItem
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] Получить указатель на элемент массива
  @param (AIM    обрабатываемый массив)
  @param (Index  номер интерисуемого элемента)
  @param (sizeOF размер в БАЙТах одного элемента массива)
  @return(указатель на элемент; nil - вне диапазона)
  }
function dAimB_get_pItem(const dAIM:tDAIM; const Index:byte; const sizeOF:tDAIM_sizeOf):pointer;
begin
    if (dAIM<>nil)and(Index<_LENGTH_dAIM)
    then result:=_clc_pItem(dAIM,Index,sizeOF)
    else result:=NIL;
end;


// ...Length
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] получить ДЛИННУ массива }
function dAimB_getLength(const dAIM:tDAIM):byte;
begin
    if dAIM<>nil then result:=_LENGTH_dAIM
                 else result:=0;
end;

{-D-[ Array in Mem ] Установить длину массива
  @param (AIM    обрабатываемый массив)
  @param (Value  НОВАЯ длина)
  @param (sizeOF размер в БАЙТах одного элемента массива)
  }
procedure dAimB_setLength(var dAIM:tDAIM; const Value:byte; const sizeOF:tDAIM_sizeOf);
begin
    if Value=0 then dAimB_FINALize(dAIM,sizeOF)
    else begin
        if dAIM=nil then Getmem    (dAIM,_cDAIM_zLength_+sizeOF*Value)
                    else ReAllocMem(dAIM,_cDAIM_zLength_+sizeOF*Value);
       _LENGTH_dAIM:=Value; //< записали значение Количества Элементов
    end;
end;

{-D-[ Array in Mem ] Установить длину массива
  @param (AIM        обрабатываемый массив)
  @param (Value      НОВАЯ длина)
  @param (sizeOF     размер в БАЙТах одного элемента массива)
  @param (defItemVAL указатель на значение элемента по умолчанию)
  ---
  *! если в массив будут добавленны НОВЫЕ элементы, то их значение установится в defItemVAL^
  }
procedure dAimB_setLength(var dAIM:tDAIM; const Value:byte; const sizeOF:tDAIM_sizeOf; const defItemVAL:pointer);
begin
    if Value=0 then dAimB_FINALize(dAIM,sizeOF)
    else begin
        if dAIM=nil then begin
            Getmem(dAIM,_cDAIM_zLength_+sizeOF*Value);
           _LENGTH_dAIM:=0; //< плановый ХАК, для последующей отработки _fillValues_
        end
        else ReAllocMem(dAIM,_cDAIM_zLength_+sizeOF*Value);
        //---
        if _LENGTH_dAIM<Value //< если массив увеличился (использование ХАКА)
        then _fillValues_(_clc_pItem(dAim,_LENGTH_dAIM,sizeOF),Value-_LENGTH_dAIM,sizeOF,defItemVAL);
        //---
       _LENGTH_dAIM:=Value; //< ПЕРЕзаписали значение длинны
    end;
end;


// ДОБАВИТЬ
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] Добавть элементы в массив
  @param (AIM    обрабатываемый массив)
  @param (Index  индекс элемента, НАЧИНАЯ с которого, будут добавленны Новые)
  @param (Count  количество добавляемых элементов)
  @param (sizeOF размер в БАЙТах одного элемента массива)
  ---
  *! если Index больше длинны массива, то массив будет УВЕЛИЧЕН до необходимого
     размера, тоесть до длинны Index+Count
  }
procedure dAimB_itemsADD(var dAIM:tDAIM; const Index:byte; const Count:byte; const sizeOF:tDAIM_sizeOf);
begin
  {$ifdef fpc}
    //!!! благодара FPC реализации move, копирование будет с "конца" отрезка к
    //!!! началу, и о пересечении отрезков копирования можно не беспокоиться
    if Count>0 then begin
        if (dAIM<>nil)and(Index<_LENGTH_dAIM) then begin
            ReallocMem(dAIM,_cDAIM_zLength_+sizeOF*(_LENGTH_dAIM+Count));
            move(//< переносим данные
                  byte(_clc_pItem(dAIM,Index,      sizeOF)^), //< откуда
                  byte(_clc_pItem(dAIM,Index+Count,sizeOF)^), //< куда
                  (_LENGTH_dAIM-Index)*sizeOf                      //< скока
                );
           _LENGTH_dAIM:=_LENGTH_dAIM+Count; //< ПЕРЕзаписали значение длинны
        end
       else begin //< за грани-и-ицей ...тучи ходят хму-у-уро ..
           // сдесь в ЛЮБОМ случае увеличиваем размер массива СПРАВА
           if dAIM=nil then GetMem    (dAIM, _cDAIM_zLength_+(Index+Count)*sizeOF)
                       else ReallocMem(dAIM, _cDAIM_zLength_+(Index+Count)*sizeOF);
          _LENGTH_dAIM:=Index+Count; //< ПЕРЕзаписали значение длинны
       end;
    end;
  {$else}
      {$error function is NOT implemented}
  {$endif}
end;


{-D-[ Array in Mem ] Добавть элементы в массив
  @param (AIM    обрабатываемый массив)
  @param (Index  индекс элемента, НАЧИНАЯ с которого, будут добавленны Новые)
  @param (Count  количество добавляемых элементов)
  @param (sizeOF размер в БАЙТах одного элемента массива)
  ---
  *! если Index больше длинны массива, то массив будет УВЕЛИЧЕН до необходимого
     размера, тоесть до длинны Index+Count
  }
procedure dAimB_itemsADD(var dAIM:tDAIM; const Index:byte; const Count:byte; const sizeOF:tDAIM_sizeOf; const defItemVAL:pointer);
begin
  {$ifdef fpc}
    //!!! благодара FPC реализации move, копирование будет с "конца" отрезка к
    //!!! началу, и о пересечении отрезков копирования можно не беспокоиться
    if Count>0 then begin
        if (dAIM<>nil)and(Index<_LENGTH_dAIM) then begin
            ReallocMem(dAIM,_cDAIM_zLength_+sizeOF*(_LENGTH_dAIM+Count));
            move(//< переносим данные
                  byte(_clc_pItem(dAIM,Index,      sizeOF)^), //< откуда
                  byte(_clc_pItem(dAIM,Index+Count,sizeOF)^), //< куда
                  (_LENGTH_dAIM-Index)*sizeOf                 //< скока
                );
           _fillValues_(dAIM+_cDAIM_zLength_+Index*sizeOF,Count,sizeOF,defItemVAL);
           _LENGTH_dAIM:=_LENGTH_dAIM+Count; //< ПЕРЕзаписали значение длинны
        end
       else begin //< за грани-и-ицей ...тучи ходят хму-у-уро ..
           // сдесь в ЛЮБОМ случае увеличиваем размер массива СПРАВА
           if dAIM=nil then dAimB_INITialize(dAIM, Index+Count,sizeOF,defItemVAL)
           else begin ReallocMem(dAIM, _cDAIM_zLength_+(Index+Count)*sizeOF);
              _fillValues_  (dAIM+_cDAIM_zLength_+_LENGTH_dAIM*sizeOF,
                             Index+Count-_LENGTH_dAIM,
                             sizeOF,defItemVAL);
              _LENGTH_dAIM:=Index+Count; //< ПЕРЕзаписали значение длинны
           end;
       end;
    end;
  {$else}
      {$error function is NOT implemented}
  {$endif}
end;


// DEL
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] Удалить элементы из массива
  @param (AIM    обрабатываемый массив)
  @param (Index  индекс элемента, НАЧИНАЯ с которого, будут УДАЛЕНЫ)
  @param (Count  количество удаляемых элементов)
  @param (sizeOF размер в БАЙТах одного элемента массива)
  ---
  *! проверка dAIM--неПуст ТОЛЬКО в режиме "DEBUG"
  }
procedure dAimB_itemsDEL(var dAIM:tDAIM; const Index:byte; const Count:byte; const sizeOF:tDAIM_sizeOf);
begin
  {$ifdef _DEBUG_}
      if dAIM=nil then raise Exception.Create('"dAIM"==NIL');
  {$endif}
  {$ifdef fpc}
    //!!! благодара FPC реализации move, копирование будет с "конца" отрезка к
    //!!! началу, и о пересечении отрезков копирования можно не беспокоиться
    if (Index<_LENGTH_dAIM)and(0<Count) then begin //< имеет ли смысл
        if (Index=0)and(_LENGTH_dAIM<=Count) then dAimB_FINALize(dAIM,sizeOF)
        else begin
            if (Index+Count)<_LENGTH_dAIM then begin //< надо "передвинуть" содержимое
                move(//< переносим данные
                      byte(_clc_pItem(dAIM,Index+Count,sizeOF)^),  //< откуда
                      byte(_clc_pItem(dAIM,Index      ,sizeOF)^),  //< куда
                            (_LENGTH_dAIM-Index-Count)*sizeOf      //< скока
                    );
               _LENGTH_dAIM:=_LENGTH_dAIM-Count; //< ПЕРЕзаписали значение длинны
            end
            else _LENGTH_dAIM:=Index; //< ПЕРЕзаписали значение длинны
            // изменение размеров
            ReallocMem(dAIM, _cDAIM_zLength_+sizeOF*_LENGTH_dAIM);
         end;
    end;
  {$else}
      {$error function is NOT implemented}
  {$endif}
end;

end.
