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
//  добавит элементы в массив                                                 \\
//----------------------------------------------------------------------------//
{-D-[ Array in Mem ] Добавть элементы в массив
  @param (AIM    обрабатываемый массив)
  @param (Index  индекс элемента, НАЧИНАЯ с которого, будут добавленны Новые)
  @param (Count  количество добавляемых элементов)
  ---
  *! если Index больше длинны массива, то массив будет УВЕЛИЧЕН до необходимого
     размера, тоесть до длинны Index+Count
  }
//--- template call ----------------------------------------------------------//
//procedure dAim_itemsADD(var dAIM:pointer; const Index:_tInkDAIM_tIndex_; const Count:_tUsrDAIM_tLength_);
begin
  {$ifdef fpc}
    //!!! благодара FPC реализации move, копирование будет с "конца" отрезка к
    //!!! началу, и о пересечении отрезков копирования можно не беспокоиться
    if Count>0 then begin
        if (dAIM<>nil)and(Index<_mInkDAIM_varCOUNT) then begin
            ReallocMem(dAIM,_cInkDAIM_zLength_+_cInkDAIM_zItem_*(_mInkDAIM_varCOUNT+Count));
            move(//< переносим данные
                  byte(_fInkDAIM_pItem(dAIM,Index      )^), //< откуда
                  byte(_fInkDAIM_pItem(dAIM,Index+Count)^), //< куда
                 _cInkDAIM_zItem_*(_mInkDAIM_varCOUNT-Index)      //< скока
                );
           _mInkDAIM_varCOUNT:=_mInkDAIM_varCOUNT+Count; //< ПЕРЕзаписали значение длинны
        end
        else begin //< за грани-и-ицей ...тучи ходят хму-у-уро ..
            // сдесь в ЛЮБОМ случае увеличиваем размер массива СПРАВА
            if dAIM=nil then Getmem    (dAIM,_cInkDAIM_zLength_+_cInkDAIM_zItem_*(Index+Count))
                        else ReAllocMem(dAIM,_cInkDAIM_zLength_+_cInkDAIM_zItem_*(Index+Count));
           _mInkDAIM_varCOUNT:=Index+Count; //< записали значение Количества Элементов
        end;
    end;
  {$else}
      {$error function is NOT implemented}
  {$endif}
end;

