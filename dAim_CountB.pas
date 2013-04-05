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
(*
  {количество элементов в массиве}
 tAIM_length=PtrUInt; //< подгоняем размер под тип POINTER

  {индекс элемента в массиве}
 tAIM_index =tAIM_length;

  {размер одного элемента в БАЙТАХ}
 tAIM_sizeOf=byte;

  {динамический массив}
 rAIM=record
    length:tAIM_length; //< кол-во элементов в массиве
    p0data:pointer;     //< указатель на данные
  end;
*)
  {указатель на динамический массив}
 tDAIM=pointer;
 tDAIM_sizeOf=word;

 tDAIMb_Count=byte;
 pDAIMb_Count=^tDAIMb_count;

 tDAIMb_Index=tDAIMb_Count;

//-=-=-=-=-=-=-//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=//
//     #       //  ФУНКЦИОНАЛ для работы с массивом
//-=-=-=-=-=-=-//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=//

procedure dAimB_INITialize(var   dAIM:tDAIM);                                                                                overload; {$ifdef _INLINE_} inline; {$endif}
procedure dAimB_INITialize(var   dAIM:tDAIM; const Count:tDAIMb_count; const sizeOf:tDAIM_sizeOf);                           overload; {$ifdef _INLINE_} inline; {$endif}
procedure dAimB_INITialize(var   dAIM:tDAIM; const Count:tDAIMb_count; const sizeOf:tDAIM_sizeOf; const defItemVAL:pointer); overload; {$ifdef _INLINE_} inline; {$endif}
procedure dAimB_FINALize  (var   dAIM:tDAIM; const sizeOf:tDAIM_sizeOf); {$ifdef _INLINE_} inline; {$endif}

//{указатель на элемент}--------------------------------------------------------

function  dAimB_clc_pItem (const dAIM:tDAIM; const Index:tDAIMb_Index; const sizeOF:tDAIM_sizeOf):pointer;  {$ifdef _INLINE_} inline; {$endif}
function  dAimB_get_pItem (const dAIM:tDAIM; const Index:tDAIMb_Index; const sizeOF:tDAIM_sizeOf):pointer; overload; {$ifdef _INLINE_} inline; {$endif}

//{длинна массива}--------------------------------------------------------------

function  dAimB_getLength (const dAIM:tDAIM):byte;                                                                  overload; {$ifdef _INLINE_} inline; {$endif}
procedure dAimB_setLength (var   dAIM:tDAIM; const Value:byte; const sizeOF:tDAIM_sizeOf; const defItemVAL:pointer); overload; {$ifdef _INLINE_} inline; {$endif}
procedure dAimB_setLength (var   dAIM:tDAIM; const Value:byte; const sizeOF:tDAIM_sizeOf);                           overload; {$ifdef _INLINE_} inline; {$endif}

//{Добавить Удалить}------------------------------------------------------------

//procedure AIM_itemsADD  (const AIM:pAIM; const Index:tAIM_index; const Count:tAIM_length; const sizeOF:tAIM_sizeOf; const defItemVAL:pointer); overload; {$ifdef _INLINE_} inline; {$endif}
//procedure AIM_itemsADD  (var   AIM:rAIM; const Index:tAIM_index; const Count:tAIM_length; const sizeOF:tAIM_sizeOf; const defItemVAL:pointer); overload; {$ifdef _INLINE_} inline; {$endif}

procedure dAimB_itemsADD  (var   dAIM:tDAIM; const Index:byte; const Count:byte; const sizeOF:tDAIM_sizeOf);                           overload; {$ifdef _INLINE_} inline; {$endif}
procedure dAimB_itemsADD  (var   dAIM:tDAIM; const Index:byte; const Count:byte; const sizeOF:tDAIM_sizeOf; const defItemVAL:pointer); overload; {$ifdef _INLINE_} inline; {$endif}
procedure dAimB_itemsDEL  (var   dAIM:tDAIM; const Index:byte; const Count:byte; const sizeOF:tDAIM_sizeOf);                           overload; {$ifdef _INLINE_} inline; {$endif}

//------------------------------------------------------------------------------
(*
function  AIM_Create (const Length:tAIM_length; const sizeOF:tAIM_sizeOf; const defItemVAL:pointer):pAIM; overload; {$ifdef _INLINE_} inline; {$endif}
function  AIM_Create (const Length:tAIM_length; const sizeOF:tAIM_sizeOf):pAIM;                           overload; {$ifdef _INLINE_} inline; {$endif}
function  AIM_Create :pAIM;                                                                               overload; {$ifdef _INLINE_} inline; {$endif}
procedure AIM_Destroy(const AIM:pAIM; const sizeOF:tAIM_sizeOf);                                                    {$ifdef _INLINE_} inline; {$endif}
*)
implementation

//--//--- размер ОДНОГО элемента массива в БАЙТАХ ------------------------//--//
          const cLengthSize=sizeOf(tDAIMb_count); //< ВАЖНЮЧая
//--//--------------------------------------------------------------------//--//


// inSide function
//------------------------------------------------------------------------------
{%region ' inSide`рские фунции, то есть НЕ видимые снаружы :-) '    /hold}


function _length_(dAIM:tDAIM):byte; {$ifdef _INLINE_} inline; {$endif}
begin
    if dAIM<>nil then result:=pByte(dAIM)^
                  else result:=0
end;

procedure _setVarLength_(dAIM:tDAIM; const Value:byte); inline;
begin
    pByte(dAIM)^:=Value;
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
     1{sizeOf(byte)} :FillByte ( byte (start^) , Count, pByte (Value)^ );
     2{sizeOf(word)} :FillWord ( word (start^) , Count, pWord (Value)^ );
     4{sizeOf(Dword)}:FillDWord( dWord(start^) , Count, pDWord(Value)^ );
     8{sizeOf(Qword)}:FillQWord( qWord(start^) , Count, pQWord(Value)^ );
     else       FillByte ( byte(start^) , Count*sizeOF, pByte (Value)^ );
    end;
end;

(*




{-D-[ Array in Mem ] (!!! БЕЗ проверок !!!) Установить длину массива
  @param (AIM    обрабатываемый массив)
  @param (Value  НОВАЯ длина, БОЛЬШЕ 0)
  @param (sizeOF размер в БАЙТах одного элемента массива)
  }
procedure _setLength_(const AIM:pAIM; const Value:tAIM_length; const sizeOF:tAIM_sizeOf); overload; {$ifdef _INLINE_} inline; {$endif}
begin
    with AIM^ do begin
        if length=0 then GetMem    (p0data, Value*sizeOF)
                    else ReallocMem(p0data, Value*sizeOF);
        length:=Value;
    end;
end;

{-D-[ Array in Mem ] (!!! БЕЗ проверок !!!) Установить длину массива
  @param (AIM     обрабатываемый массив)
  @param (Value   НОВАЯ длина, БОЛЬШЕ 0)
  @param (sizeOF  размер в БАЙТах одного элемента массива)
  @param (itemVAL указатель на значение для НОВЫХ [созданных в процессе изменения размера] элементов массива)
  }
procedure _setLength_(const AIM:pAIM; const Value:tAIM_length; const sizeOF:tAIM_sizeOf; const itemVAL:pointer); overload; {$ifdef _INLINE_} inline; {$endif}
begin
    with AIM^ do begin
        if length=0 then GetMem    (p0data, Value*sizeOF)
                    else ReallocMem(p0data, Value*sizeOF);
       _fillValues_(AIM_clc_pItem(AIM,length,sizeOF),Value-length, sizeOF,itemVAL);
        length:=Value;
    end;
end;
     *)
{%endregion}
//------------------------------------------------------------------------------
//

//function _get_Length_(dIAM:pointer):tDAIMb_count; {$ifdef _INLINE_} inline; {$endif}


(*
{-D-[ Array in Mem ] СОЗДАТЬ пустой ИНИЦИАЛИЗИРОВАННЫЙ массив }
function AIM_Create:pAIM;
begin
    new(result);
    AIM_INITialize(result);
end;

{-D-[ Array in Mem ] СОЗДАТЬ массив и ИНИЦИАЛИЗИРОВАТЬ }
function AIM_Create(const Length:tAIM_length; const sizeOF:tAIM_sizeOf):pAIM;
begin
    result:=AIM_Create;
    AIM_setLength(result,Length,sizeOF);
end;

{-D-[ Array in Mem ] СОЗДАТЬ массив и ИНИЦИАЛИЗИРОВАТЬ его эначениями по УМОЛЧАНИЮ}
function AIM_Create(const Length:tAIM_length; const sizeOF:tAIM_sizeOf; const defItemVAL:pointer):pAIM;
begin
    result:=AIM_Create;
    AIM_setLength(result,Length,sizeOF,defItemVAL);
end;

{-D-[ Array in Mem ] УНИЧТОЖИТЬ экземпляр массива, предварительно ФИНАЛИЗИРОВАВ его}
procedure AIM_Destroy(const AIM:pAIM; const sizeOF:tAIM_sizeOf);
begin
    AIM_FINALize(AIM,sizeOF);
    dispose(AIM);
end;
*)

// INITialize
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] ИНИЦИАЛИЗИРОВАТЬ }
procedure dAimB_INITialize(var dAIM:tDAIM);
begin
    dAIM:=NIL;
end;

{-D-[ Array in Mem ] ИНИЦИАЛИЗИРОВАТЬ }
procedure dAimB_INITialize(var dAIM:tDAIM; const Count:byte; const sizeOf:tDAIM_sizeOf);
begin
    {$ifdef _DEBUG_}
      if Count =0 then raise Exception.Create('wrong: "Count"==0');
      if sizeOf=0 then raise Exception.Create('wrong: "sizeOf"==0');
    {$endif}
    getMem       (dAIM,cLengthSize+sizeOf*Count);
   _setVarLength_(dAIM,Count);
end;

procedure dAimB_INITialize(var dAIM:tDAIM; const Count:tDAIMb_count; const sizeOf:tDAIM_sizeOf; const defItemVAL:pointer);
begin
  {$ifdef _DEBUG_}
    if Count =0 then raise Exception.Create('wrong: "Count"==0');
    if sizeOf=0 then raise Exception.Create('wrong: "sizeOf"==0');
    if defItemVAL=nil then raise Exception.Create('wrong: "defItemVAL"==NIL');
  {$endif}
    dAimB_INITialize(dAIM,Count,sizeOf);
   _fillValues_(dAIM+cLengthSize,Count,sizeOF,defItemVAL);
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
        Freemem(dAIM,cLengthSize+sizeOF*_length_(dAIM)); //< зачистили
        dAIM:=NIL;
    end;
end;


// ..pItem
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] расчитать ЗНАЧЕНИЕ указателя на элемент массива
  @param (AIM    обрабатываемый массив)
  @param (Index  номер интерисуемого элемента)
  @param (sizeOF размер в БАЙТах одного элемента массива)
  @return(указатель на элемент !!! выход за переделы массива не проверяется)
  }
function dAimB_clc_pItem(const dAIM:tDAIM; const Index:byte; const sizeOF:tDAIM_sizeOf):pointer;
begin
    result:=dAIM+cLengthSize+Index*sizeOf;
end;

{-D-[ Array in Mem ] Получить указатель на элемент массива
  @param (AIM    обрабатываемый массив)
  @param (Index  номер интерисуемого элемента)
  @param (sizeOF размер в БАЙТах одного элемента массива)
  @return(указатель на элемент; nil - вне диапазона)
  }
function dAimB_get_pItem(const dAIM:tDAIM; const Index:tDAIMb_Index; const sizeOF:tDAIM_sizeOf):pointer;
begin
    if (dAIM<>nil)and(Index<_length_(dAIM))
    then result:=dAimB_clc_pItem(dAIM,Index,sizeOF)
    else result:=NIL;
end;


// ...Length
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] получить ДЛИННУ массива }
function dAimB_getLength(const dAIM:tDAIM):byte;
begin
    if dAIM<>nil then result:=_length_(dAIM)
    else result:=0;
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
    if Value<>_length_(dAIM) then begin
        if Value=0 then dAimB_FINALize(dAIM,sizeOF)
        else begin
            if dAIM=nil then dAimB_INITialize(dAIM,Value,sizeOF,defItemVAL)
            else begin //< меняются размеры
                ReAllocMem(dAIM,cLengthSize+sizeOF*Value);
                if _length_(dAIM)<Value //< если увеличился
                then _fillValues_(dAimB_clc_pItem(dAim,_length_(dAIM),sizeOF),Value-_length_(dAIM),sizeOF,defItemVAL);
               _setVarLength_(dAIM,Value); //< переустановим длинну
            end;
        end;
    end;
end;

{-D-[ Array in Mem ] Установить длину массива
  @param (AIM    обрабатываемый массив)
  @param (Value  НОВАЯ длина)
  @param (sizeOF размер в БАЙТах одного элемента массива)
  }
procedure dAimB_setLength(var dAIM:tDAIM; const Value:byte; const sizeOF:tDAIM_sizeOf);
begin
    if Value<>_length_(dAIM) then begin
        if Value=0 then dAimB_FINALize(dAIM,sizeOF)
        else begin
            if dAIM=nil then Getmem    (dAIM,cLengthSize+sizeOF*Value)
                        else ReAllocMem(dAIM,cLengthSize+sizeOF*Value);
           _setVarLength_(dAIM,Value);
        end;
    end;
end;

(*
// ДОБАВИТЬ
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] Добавть элементы в массив
  @param (AIM    обрабатываемый массив)
  @param (Index  индекс элемента, НАЧИНАЯ с которого, будут добавленны Новые)
  @param (Count  количество добавляемых элементов)
  @param (sizeOF размер в БАЙТах одного элемента массива)
  @param (defItemVAL указатель на значение по умолчанию)
  ---
  *! если Index больше длинны массива, то массив будет УВЕЛИЧЕН до необходимого
     размера, тоесть до длинны Index+Count
  *! если в массив будут добавленны НОВЫЕ элементы, то их значение установится в defItemVAL^
  }
procedure AIM_itemsADD(const AIM:pAIM; const Index:tAIM_index; const Count:tAIM_length; const sizeOF:tAIM_sizeOf; const defItemVAL:pointer);
begin
  {$ifdef fpc}
    //!!! благодара FPC реализации move, копирование будет с "конца" отрезка к
    //!!! началу, и о пересечении отрезков копирования можно не беспокоиться
    if Count>0 then begin
        if (AIM^.length>0)and(Index<AIM^.length) then begin
            ReallocMem(AIM^.p0data, sizeOF*(AIM^.length+Count));
            move(//< переносим данные
                  byte(AIM_clc_pItem(AIM,Index,      sizeOF)^), //< откуда
                  byte(AIM_clc_pItem(AIM,Index+Count,sizeOF)^), //< куда
                  (AIM^.length-Index)*sizeOf                    //< скока
                );
            AIM^.length:=AIM^.length+count;
           _fillValues_(AIM_clc_pItem(AIM,Index,sizeOF),Count,sizeOF,defItemVAL);
        end
       else begin //< за грани-и-ицей ...тучи ходят хму-у-уро ..
           // сдесь в ЛЮБОМ случае увеличиваем размер массива СПРАВА
          _setLength_(AIM,Index+Count,sizeOF,defItemVAL);
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
  @param (defItemVAL указатель на значение по умолчанию)
  ---
  *! если Index больше длинны массива, то массив будет УВЕЛИЧЕН до необходимого
     размера, тоесть до длинны Index+Count
  *! если в массив будут добавленны НОВЫЕ элементы, то их значение установится в defItemVAL^
  }
procedure AIM_itemsADD(var AIM:rAIM; const Index:tAIM_index; const Count:tAIM_length; const sizeOF:tAIM_sizeOf; const defItemVAL:pointer);
begin
    AIM_itemsADD(@AIM,Index,Count,sizeOF,defItemVAL);
end;

*)
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

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
        if (dAIM<>nil)and(Index<_length_(dAIM)) then begin
            ReallocMem(dAIM,cLengthSize+sizeOF*(_length_(dAIM)+Count));
            move(//< переносим данные
                  byte(dAimB_clc_pItem(dAIM,Index,      sizeOF)^), //< откуда
                  byte(dAimB_clc_pItem(dAIM,Index+Count,sizeOF)^), //< куда
                  (_length_(dAIM)-Index)*sizeOf                 //< скока
                );
           _setVarLength_(dAIM,_length_(dAIM)+Count);
        end
       else begin //< за грани-и-ицей ...тучи ходят хму-у-уро ..
           // сдесь в ЛЮБОМ случае увеличиваем размер массива СПРАВА
           if dAIM=nil then GetMem    (dAIM, cLengthSize+(Index+Count)*sizeOF)
                       else ReallocMem(dAIM, cLengthSize+(Index+Count)*sizeOF);
          _setVarLength_(dAIM,Index+Count);
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
        if (dAIM<>nil)and(Index<_length_(dAIM)) then begin
            ReallocMem(dAIM,cLengthSize+sizeOF*(_length_(dAIM)+Count));
            move(//< переносим данные
                  byte(dAimB_clc_pItem(dAIM,Index,      sizeOF)^), //< откуда
                  byte(dAimB_clc_pItem(dAIM,Index+Count,sizeOF)^), //< куда
                  (_length_(dAIM)-Index)*sizeOf                 //< скока
                );
           _fillValues_  (dAIM+cLengthSize+Index*sizeOF,Count,sizeOF,defItemVAL);
           _setVarLength_(dAIM,_length_(dAIM)+Count);
        end
       else begin //< за грани-и-ицей ...тучи ходят хму-у-уро ..
           // сдесь в ЛЮБОМ случае увеличиваем размер массива СПРАВА
           if dAIM=nil then dAimB_INITialize(dAIM, Index+Count,sizeOF,defItemVAL)
           else begin ReallocMem(dAIM, cLengthSize+(Index+Count)*sizeOF);
              _fillValues_  (dAIM+cLengthSize+_length_(dAIM)*sizeOF,
                             Index+Count-_length_(dAIM),
                             sizeOF,defItemVAL);
              _setVarLength_(dAIM,Index+Count);
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
    if (Index<_length_(dAIM))and(Count>0) then begin //< имеет ли смысл
        if (Index=0)and(_length_(dAIM)<=Count) then dAimB_FINALize(dAIM,sizeOF)
        else begin
            if (Index+Count)<_length_(dAIM) then begin //< надо "передвинуть" содержимое
                move(//< переносим данные
                      byte(dAimB_clc_pItem(dAIM,Index+Count,sizeOF)^),  //< откуда
                      byte(dAimB_clc_pItem(dAIM,Index      ,sizeOF)^),  //< куда
                      (_length_(dAIM)-Index-Count)*sizeOf               //< скока
                    );
               _setVarLength_(dAIM,_length_(dAIM)-Count);
            end
            else _setVarLength_(dAIM,Index);
            // изменение размеров
            ReallocMem(dAIM, cLengthSize+_length_(dAIM)*sizeOF);
         end;
    end;
  {$else}
      {$error function is NOT implemented}
  {$endif}
end;

end.
