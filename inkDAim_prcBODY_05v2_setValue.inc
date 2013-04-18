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
//  УСТАНОВИТЬ значение элемента массива                                        \\
//----------------------------------------------------------------------------//
{-D-[ Array in Mem ] УСТАНОВИТЬ значение элемента массива
  @param (AIM    обрабатываемый массив)
  @param (Index  номер интерисуемого элемента)
  @param (Value  значение элемента)
  ---
  *! вне диапазона НИЧЕГО не пишем
  *! сообщение о вылете за диапазон ТОЛЬКО в режиме "DEBUG"
  }
//--- template call ----------------------------------------------------------//
//procedure dAimB_set_Value(const dAIM:pointer; const Index:_tInkDAIM_tIndex_; const Value:_tInkDAIM_tItem_);
begin
    {$ifdef _DEBUG_}
    if  dAIM=nil then raise Exception.Create('[dAim]get_Value: dAIM==nil');
    if _mInkDAIM_varCOUNT=0 then raise Exception.Create('[dAim]get_Value: dAIM<>nil AND length(dAIM)==0');
    if _mInkDAIM_varCOUNT<Index then raise Exception.Create('[dAim]get_Value: length(dAIM)<Index');
    {$endif}
    if (dAIM<>nil)and(Index<_mInkDAIM_varCOUNT)
    then {$i inkDAim_prcBODY_05v1_setValue.inc}
end;

