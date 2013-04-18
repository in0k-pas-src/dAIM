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
//  Удалить элементы из массива                                               \\
//----------------------------------------------------------------------------//
{-D-[ Array in Mem ] Удалить элементы из массива
  @param (AIM    обрабатываемый массив)
  @param (Index  индекс элемента, НАЧИНАЯ с которого, будут УДАЛЕНЫ)
  @param (Count  количество удаляемых элементов)
  ---
  *! проверка dAIM--неПуст ТОЛЬКО в режиме "DEBUG"
  }
//--- template call ----------------------------------------------------------//
//procedure dAim_itemsDEL(var dAIM:pointer; const Index:_tInkDAIM_tIndex_; const Count:_tUsrDAIM_tLength_);
begin
    {$ifdef _DEBUG_}
      if  dAIM=nil then raise Exception.Create('[dAim]itemsDEL: dAIM==nil');
      if _mInkDAIM_varCOUNT=0 then raise Exception.Create('[dAim]itemsDEL: dAIM<>nil AND length(dAIM)==0');
    {$endif}
  {$ifdef fpc}
    //!!! благодара FPC реализации move, копирование будет с "конца" отрезка к
    //!!! началу, и о пересечении отрезков копирования можно не беспокоиться
    if (Index<_mInkDAIM_varCOUNT)and(0<Count) then begin //< имеет ли смысл
        if (Index=0)and(_mInkDAIM_varCOUNT<=Count) then begin
           //делаем вызов dAim_FINALize
           {$i inkDAim_prcBODY_FFv1_FINALize.inc}
        end
        else begin
            if (Index+Count)<_mInkDAIM_varCOUNT then begin //< надо "передвинуть" содержимое
                move(//< переносим данные
                      byte(_fInkDAIM_pItem(dAIM,Index+Count)^),  //< откуда
                      byte(_fInkDAIM_pItem(dAIM,Index      )^),  //< куда
                     _cInkDAIM_zItem_*(_mInkDAIM_varCOUNT-Index-Count) //< скока
                    );
               _mInkDAIM_varCOUNT:=_mInkDAIM_varCOUNT-Count; //< ПЕРЕзаписали значение длинны
            end
            else _mInkDAIM_varCOUNT:=Index; //< ПЕРЕзаписали значение длинны
            // изменение размеров
            ReallocMem(dAIM, _cInkDAIM_zLength_+_cInkDAIM_zItem_*_mInkDAIM_varCOUNT);
         end;
    end;
  {$else}
      {$error function is NOT implemented}
  {$endif}
end;
