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
  @param (AIM        обрабатываемый массив)
  @param (Index      индекс элемента, НАЧИНАЯ с которого, будут добавленны Новые)
  @param (Count      количество добавляемых элементов)
  @param (defItemVAL значение элемента по умолчанию)
  ---
  *! если Index больше длинны массива, то массив будет УВЕЛИЧЕН до необходимого
     размера, тоесть до длинны Index+Count
  *! если в массив будут добавленны НОВЫЕ элементы, то их значение установится в defItemVAL
  }
//--- template call ----------------------------------------------------------//
//procedure dAim_itemsADD(var dAIM:pointer; const Index:_tInkDAIM_tIndex_; const Count:_tUsrDAIM_tLength_; const defItemVAL:_tInkDAIM_tItem_);
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
           _mInkDAIM_pFILL(_tInkDAIM_tItem_(_fInkDAIM_pItem(dAIM,Index)^),Count,defItemVAL);
           _mInkDAIM_varCOUNT:=_mInkDAIM_varCOUNT+Count; //< ПЕРЕзаписали значение длинны
        end
       else begin //< за грани-и-ицей ...тучи ходят хму-у-уро ..
           // сдесь в ЛЮБОМ случае увеличиваем размер массива СПРАВА
           if dAIM=nil then begin
              // делаем вызов
              // dAim_INITialize(var dAIM:pointer; const Length:_tInkDAIM_tLength_; const defItemVAL:_tInkDAIM_tItem_);
              {$define Length:=(Index+Count)} //< !!! скобки ОБЯЗАТЕЛЬНЫ !!!
              {$i inkDAim_prcBODY_00v2_INITialize.inc};
              {$undef Length}
           end
           else begin ReallocMem(dAIM, _cInkDAIM_zLength_+(Index+Count)*_cInkDAIM_zItem_);
              _mInkDAIM_pFILL(_tInkDAIM_tItem_(_fInkDAIM_pItem(dAIM,_mInkDAIM_varCOUNT)^),
                            SizeInt(Index)+SizeInt(Count)-SizeInt(_mInkDAIM_varCOUNT),
                            defItemVAL);
              _mInkDAIM_varCOUNT:=Index+Count; //< ПЕРЕзаписали значение длинны
           end;
       end;
    end;
  {$else}
      {$error function is NOT implemented}
  {$endif}
end;
