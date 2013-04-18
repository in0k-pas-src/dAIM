//------------------------------------------------------ in0k © 21.03.2012 ---//
//                                                                            //
//                     O~~                                                    //
//                     O~~      o    ooooo oooo     oooo                      //
//                 O~~ O~~     888    888   8888o   888                       //
//                O~   O~~    8  88   888   88 888o8 88                       //
//                O~   O~~   8oooo88  888   88  888  88                       //
//                 O~~ O~~ o88o  o888o888o o88o  8  o88o                      //
//                                                                            //
//------------------------------------------------------- чернильные пятна ---//
//  НАЙТИ значение элемента                                                   \\
//----------------------------------------------------------------------------//
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
//--- template call ----------------------------------------------------------//
//function dAim_fnd_Value(const dAIM:pointer; const Value:_tInkDAIM_tItem_; out Index:_tInkDAIM_tIndex_):boolean;
begin
    {$ifdef _DEBUG_}
    if  dAIM=nil then raise Exception.Create('[dAim]FIND: dAIM==nil');
    if _mInkDAIM_varCOUNT=0 then raise Exception.Create('[dAim]FIND: dAIM<>nil AND length(dAIM)==0');
    {$endif}
    result:=false;
    Index:=0;
    while index<_mInkDAIM_varCOUNT do begin
        if _pInkDAIM_tItem_(_fInkDAIM_pItem(dAIM,Index))^=Value then begin
            result:=true;
            BREAK;
        end;
    end;
end;

