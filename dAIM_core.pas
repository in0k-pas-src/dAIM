unit dAIM_core;
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

//-=-=-=-=-=-=-//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=//
//     #       //  ФУНКЦИОНАЛ для работы с массивом
//-=-=-=-=-=-=-//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=//

procedure dAIM_INITialize(var dAIM:tDAIM; const zLength,zItem,Count:PtrUInt); overload; {$ifdef _INLINE_} inline; {$endif}
procedure dAIM_INITialize(var dAIM:tDAIM);                                    overload; {$ifdef _INLINE_} inline; {$endif}

procedure dAIM_FINALize  (var dAIM:tDAIM; const zLength,zItem:PtrUInt);           {$ifdef _INLINE_} inline; {$endif}

//{указатель на элемент}--------------------------------------------------------
(*
function  AIM_clc_pItem (const AIM:pAIM; const Index:tAIM_index;  const sizeOF:tAIM_sizeOf):pointer; overload; {$ifdef _INLINE_} inline; {$endif}
function  AIM_clc_pItem (var   AIM:rAIM; const Index:tAIM_index;  const sizeOF:tAIM_sizeOf):pointer; overload; {$ifdef _INLINE_} inline; {$endif}

function  AIM_get_pItem (const AIM:pAIM; const Index:tAIM_index;  const sizeOF:tAIM_sizeOf):pointer; overload; {$ifdef _INLINE_} inline; {$endif}
function  AIM_get_pItem (var   AIM:rAIM; const Index:tAIM_index;  const sizeOF:tAIM_sizeOf):pointer; overload; {$ifdef _INLINE_} inline; {$endif}

//{длинна массива}--------------------------------------------------------------

function  AIM_getLength (const AIM:pAIM):tAIM_length;                                        overload; {$ifdef _INLINE_} inline; {$endif}
function  AIM_getLength (var   AIM:rAIM):tAIM_length;                                        overload; {$ifdef _INLINE_} inline; {$endif}

procedure AIM_setLength (const AIM:pAIM; const Value:tAIM_length; const sizeOF:tAIM_sizeOf;  const defItemVAL:pointer); overload; {$ifdef _INLINE_} inline; {$endif}
procedure AIM_setLength (var   AIM:rAIM; const Value:tAIM_length; const sizeOF:tAIM_sizeOf;  const defItemVAL:pointer); overload; {$ifdef _INLINE_} inline; {$endif}

procedure AIM_setLength (const AIM:pAIM; const Value:tAIM_length; const sizeOF:tAIM_sizeOf); overload; {$ifdef _INLINE_} inline; {$endif}
procedure AIM_setLength (var   AIM:rAIM; const Value:tAIM_length; const sizeOF:tAIM_sizeOf); overload; {$ifdef _INLINE_} inline; {$endif}

//{Добавить Удалить}------------------------------------------------------------

procedure AIM_itemsADD  (const AIM:pAIM; const Index:tAIM_index; const Count:tAIM_length; const sizeOF:tAIM_sizeOf; const defItemVAL:pointer); overload; {$ifdef _INLINE_} inline; {$endif}
procedure AIM_itemsADD  (var   AIM:rAIM; const Index:tAIM_index; const Count:tAIM_length; const sizeOF:tAIM_sizeOf; const defItemVAL:pointer); overload; {$ifdef _INLINE_} inline; {$endif}

procedure AIM_itemsADD  (const AIM:pAIM; const Index:tAIM_index; const Count:tAIM_length; const sizeOF:tAIM_sizeOf); overload; {$ifdef _INLINE_} inline; {$endif}
procedure AIM_itemsADD  (var   AIM:rAIM; const Index:tAIM_index; const Count:tAIM_length; const sizeOF:tAIM_sizeOf); overload; {$ifdef _INLINE_} inline; {$endif}

procedure AIM_itemsDEL  (const AIM:pAIM; const Index:tAIM_index; const Count:tAIM_length; const sizeOF:tAIM_sizeOf); overload; {$ifdef _INLINE_} inline; {$endif}
procedure AIM_itemsDEL  (var   AIM:rAIM; const Index:tAIM_index; const Count:tAIM_length; const sizeOF:tAIM_sizeOf); overload; {$ifdef _INLINE_} inline; {$endif}

//------------------------------------------------------------------------------

function  AIM_Create (const Length:tAIM_length; const sizeOF:tAIM_sizeOf; const defItemVAL:pointer):pAIM; overload; {$ifdef _INLINE_} inline; {$endif}
function  AIM_Create (const Length:tAIM_length; const sizeOF:tAIM_sizeOf):pAIM;                           overload; {$ifdef _INLINE_} inline; {$endif}
function  AIM_Create :pAIM;                                                                               overload; {$ifdef _INLINE_} inline; {$endif}
procedure AIM_Destroy(const AIM:pAIM; const sizeOF:tAIM_sizeOf);                                                    {$ifdef _INLINE_} inline; {$endif}
*)
implementation
 (*
// inSide function
//------------------------------------------------------------------------------
{%region ' inSide`рские фунции, то есть НЕ видимые снаружы :-) '    /hold}

{-D-[ Array in Mem ] (!!! БЕЗ проверок !!!) раскопировать значения
  @param (AIM    обрабатываемый массив)
  @param (start  указатель, с какого момента копировать)
  @param (sizeOF размер в БАЙТах одного элемента массива)
  @param (Value  указатель на значение)
  }
procedure _fillValues_(start:pointer; const Count:tAIM_length; const sizeOF:tAIM_sizeOf; const Value:pointer); {$ifdef _INLINE_} inline; {$endif}
begin
    case sizeOF of
     1{sizeOf(byte)} :FillByte ( byte (start^) , Count, pByte (Value)^ );
     2{sizeOf(word)} :FillWord ( word (start^) , Count, pWord (Value)^ );
     4{sizeOf(Dword)}:FillDWord( dWord(start^) , Count, pDWord(Value)^ );
     8{sizeOf(Qword)}:FillQWord( qWord(start^) , Count, pQWord(Value)^ );
     else       FillByte ( byte(start^) , Count*sizeOF, pByte (Value)^ );
    end;
end;

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
procedure dAIM_INITialize(var dAIM:tDAIM; const zLength,zItem,Count:PtrUInt);
begin
    getMem(dAIM)

    with AIM^ do begin
        length:=0;
        p0data:=NIL;
    end;
end;

{-D-[ Array in Mem ] ИНИЦИАЛИЗИРОВАТЬ }
procedure dAIM_INITialize(var dAIM:tDAIM);

procedure AIM_INITialize(var AIM:rAIM);
begin
    with AIM do begin
        length:=0;
        p0data:=NIL;
    end;
end;


// FINALized
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] ФИНАЛИЗИРОВАТЬ массив, очистить память
  @param(AIM    указатель на массив)
  @param(sizeOF размер в БАЙТах одного элемента массива)
  }
procedure AIM_FINALize(const AIM:pAIM; const sizeOF:tAIM_sizeOf);
begin
    with AIM^ do
      if (length<>0)and(p0data<>nil) then begin
          Freemem(p0data, length*sizeOF); //< зачистили
          length:=0;
          p0data:=NIL;
      end
end;

{-D-[ Array in Mem ] ФИНАЛИЗИРОВАТЬ массив, очистить память
  @param(AIM    переменная массив)
  @param(sizeOF размер в БАЙТах одного элемента массива)
  }
procedure AIM_FINALize(var AIM:rAIM; const sizeOF:tAIM_sizeOf);
begin
    with AIM do
      if (length<>0)and(p0data<>nil) then begin
          Freemem(p0data, length*sizeOF); //< зачистили
          length:=0;
          p0data:=NIL;
      end
end;

(*
// getPointer
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] расчитать ЗНАЧЕНИЕ указателя на элемент массива
  @param (AIM    обрабатываемый массив)
  @param (Index  номер интерисуемого элемента)
  @param (sizeOF размер в БАЙТах одного элемента массива)
  @return(указатель на элемент !!! выход за переделы массива не проверяется)
  }
function AIM_clc_pItem(const AIM:pAIM; const Index:tAIM_index; const sizeOF:tAIM_sizeOf):pointer;
begin
    result:=AIM^.p0data+Index*sizeOf;
end;

{-D-[ Array in Mem ] расчитать ЗНАЧЕНИЕ указателя на элемент массива
  @param (AIM    обрабатываемый массив)
  @param (Index  номер интерисуемого элемента)
  @param (sizeOF размер в БАЙТах одного элемента массива)
  @return(указатель на элемент !!! выход за переделы массива не проверяется)
  }
function AIM_clc_pItem(var AIM:rAIM; const Index:tAIM_index; const sizeOF:tAIM_sizeOf):pointer;
begin
    result:=AIM.p0data+Index*sizeOf;
end;

{-D-[ Array in Mem ] Получить указатель на элемент массива
  @param (AIM    обрабатываемый массив)
  @param (Index  номер интерисуемого элемента)
  @param (sizeOF размер в БАЙТах одного элемента массива)
  @return(указатель на элемент; nil - вне диапазона)
  }
function AIM_get_pItem(const AIM:pAIM; const Index:tAIM_index; const sizeOF:tAIM_sizeOf):pointer;
begin
    if Index<AIM^.length then result:=AIM_clc_pItem(AIM,Index,sizeOF)
                         else result:=NIL;
end;

{-D-[ Array in Mem ] Получить указатель на элемент массива
  @param (AIM    обрабатываемый массив)
  @param (Index  номер интерисуемого элемента)
  @param (sizeOF размер в БАЙТах одного элемента массива)
  @return(указатель на элемент; nil - вне диапазона)
  }
function AIM_get_pItem(var AIM:rAIM; const Index:tAIM_index; const sizeOF:tAIM_sizeOf):pointer;
begin
    if Index<AIM.length  then result:=AIM_clc_pItem(AIM,Index,sizeOF)
                         else result:=NIL;
end;


// getLength
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] получить ДЛИННУ массива }
function AIM_getLength(const AIM:pAIM):tAIM_length;
begin
    result:=AIM^.length;
end;

{-D-[ Array in Mem ] получить ДЛИННУ массива }
function AIM_getLength(var AIM:rAIM):tAIM_length;
begin
    result:=AIM.length;
end;


// setLength
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] Установить длину массива
  @param (AIM        обрабатываемый массив)
  @param (Value      НОВАЯ длина)
  @param (sizeOF     размер в БАЙТах одного элемента массива)
  @param (defItemVAL указатель на значение элемента по умолчанию)
  ---
  *! если в массив будут добавленны НОВЫЕ элементы, то их значение установится в defItemVAL^
  }
procedure AIM_setLength(const AIM:pAIM; const Value:tAIM_length; const sizeOF:tAIM_sizeOf; const defItemVAL:pointer);
begin
  with AIM^ do
    if Value<>length then begin
        if Value=0 then AIM_FINALize(AIM,sizeOF)
        else begin
            if Value=0 then AIM_FINALize(AIM,sizeOF)
            else _setLength_(AIM,Value,sizeOF,defItemVAL);
        end;
    end;
end;

{-D-[ Array in Mem ] Установить длину массива
  @param (AIM        обрабатываемый массив)
  @param (Value      НОВАЯ длина)
  @param (sizeOF     размер в БАЙТах одного элемента массива)
  @param (defItemVAL указатель на значение по умолчанию)
  ---
  *! если в массив будут добавленны НОВЫЕ элементы, то их значение установится в defItemVAL^
  }
procedure AIM_setLength(var AIM:rAIM; const Value:tAIM_length; const sizeOF:tAIM_sizeOf; const defItemVAL:pointer);
begin
    AIM_setLength(@AIM,Value,sizeOF,defItemVAL);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

{-D-[ Array in Mem ] Установить длину массива
  @param (AIM    обрабатываемый массив)
  @param (Value  НОВАЯ длина)
  @param (sizeOF размер в БАЙТах одного элемента массива)
  }
procedure AIM_setLength(const AIM:pAIM; const Value:tAIM_length; const sizeOF:tAIM_sizeOf);
begin
  with AIM^ do
    if Value<>length then begin
        if Value=0 then AIM_FINALize(AIM,sizeOF)
        else _setLength_(AIM,Value,sizeOF);
    end;
end;

{-D-[ Array in Mem ] Установить длину массива
  @param (AIM    обрабатываемый массив)
  @param (Value  НОВАЯ длина)
  @param (sizeOF размер в БАЙТах одного элемента массива)
  }
procedure AIM_setLength(var AIM:rAIM; const Value:tAIM_length; const sizeOF:tAIM_sizeOf);
begin
  with AIM do
    if Value<>length then begin
        if Value<>length then begin
            if Value=0 then AIM_FINALize(AIM,sizeOF)
            else _setLength_(@AIM,Value,sizeOF);
        end;
    end;
end;


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
procedure AIM_itemsADD(const AIM:pAIM; const Index:tAIM_index; const Count:tAIM_length; const sizeOF:tAIM_sizeOf);
begin
  {$ifdef fpc}
    //!!! благодара FPC реализации move, копирование будет с "конца" отрезка к
    //!!! началу, и о пересечении отрезков копирования можно не беспокоиться
    if Count>0 then begin
        if (AIM^.length<>0)and(Index<AIM^.length) then begin
            ReallocMem(AIM^.p0data, sizeOF*(AIM^.length+Count));
            move(//< переносим данные
                  byte(AIM_clc_pItem(AIM,Index,      sizeOF)^), //< откуда
                  byte(AIM_clc_pItem(AIM,Index+Count,sizeOF)^), //< куда
                  (AIM^.length-Index)*sizeOf                    //< скока
                );
            AIM^.length:=AIM^.length+count;
        end
       else begin //< за грани-и-ицей ...тучи ходят хму-у-уро ..
           // сдесь в ЛЮБОМ случае увеличиваем размер массива СПРАВА
          _setLength_(AIM,Index+Count,sizeOF)
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
procedure AIM_itemsADD(var AIM:rAIM; const Index:tAIM_index; const Count:tAIM_length; const sizeOF:tAIM_sizeOf);
begin
    AIM_itemsADD(@AIM,Index,Count,sizeOf);
end;


// DEL
//------------------------------------------------------------------------------

{-D-[ Array in Mem ] Удалить элементы из массива
  @param (AIM    обрабатываемый массив)
  @param (Index  индекс элемента, НАЧИНАЯ с которого, будут УДАЛЕНЫ)
  @param (Count  количество удаляемых элементов)
  @param (sizeOF размер в БАЙТах одного элемента массива)
  }
procedure AIM_itemsDEL(const AIM:pAIM; const Index:tAIM_index; const Count:tAIM_length; const sizeOF:tAIM_sizeOf);
begin
  {$ifdef fpc}
    //!!! благодара FPC реализации move, копирование будет с "конца" отрезка к
    //!!! началу, и о пересечении отрезков копирования можно не беспокоиться
    if (0<AIM^.length)and(Index<AIM^.length)and(Count>0) then begin //< имеет ли смысл
        if (Index=0)and(AIM^.length<=Count) then AIM_FINALize(AIM,sizeOF)
        else begin
            if (Index+Count)<AIM^.length then begin //< надо "передвинуть" содержимое
                move(//< переносим данные
                      byte(AIM_clc_pItem(AIM,Index+Count,sizeOF)^),  //< откуда
                      byte(AIM_clc_pItem(AIM,Index      ,sizeOF)^),  //< куда
                      (AIM^.length-Index-Count)*sizeOf               //< скока
                    );
                AIM^.length:=AIM^.length-Count;
            end
            else AIM^.length:=index;
            // изменение размеров
            ReallocMem(AIM^.p0data, AIM^.length*sizeOF);
         end;
    end;
  {$else}
      {$error function is NOT implemented}
  {$endif}
end;

{-D-[ Array in Mem ] Удалить элементы из массива
  @param (AIM    обрабатываемый массив)
  @param (Index  индекс элемента, НАЧИНАЯ с которого, будут УДАЛЕНЫ)
  @param (Count  количество удаляемых элементов)
  @param (sizeOF размер в БАЙТах одного элемента массива)
  }
procedure AIM_itemsDEL(var AIM:rAIM; const Index:tAIM_index; const Count:tAIM_length; const sizeOF:tAIM_sizeOf);
begin
    AIM_itemsDEL(@AIM,Index,Count,sizeOf)
end;
     *)
end.
