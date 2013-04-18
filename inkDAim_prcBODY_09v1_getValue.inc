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
//  ПОЛУЧИТЬ значение элемента массива                                        \\
//----------------------------------------------------------------------------//
{-D-[ Array in Mem ] ПОЛУЧИТЬ значение элемента массива
  @param (AIM    обрабатываемый массив)
  @param (Index  номер интерисуемого элемента)
  @return(значение элемента)
  ---
  *! БЕЗ проверки !!! при вылете из диапазонва возможен крах !!!
  *! проверка dAIM--неПуст ТОЛЬКО в режиме "DEBUG"
  *! сообщение о вылете за диапазон ТОЛЬКО в режиме "DEBUG"
  }
//--- template call ----------------------------------------------------------//
//function dAim_get___Val(const dAIM:pointer; const Index:_tInkDAIM_tIndex_):_tInkDAIM_tItem_;
begin
    {$ifdef _DEBUG_}
      if  dAIM=nil then raise Exception.Create('[dAim]get___Val: dAIM==nil');
      if _mInkDAIM_varCOUNT=0 then raise Exception.Create('[dAim]get___Val: dAIM<>nil AND length(dAIM)==0');
      if _mInkDAIM_varCOUNT<Index then raise Exception.Create('[dAim]get___Val: length(dAIM)<Index');
    {$endif}
    result:=_pInkDAIM_tItem_(_fInkDAIM_pItem(dAIM,Index))^;
end;
