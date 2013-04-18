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
//  установить ДЛИННУ массива                                                 \\
//----------------------------------------------------------------------------//
{-D-[ Array in Mem ] Установить длину массива
  @param (AIM        обрабатываемый массив)
  @param (Value      НОВАЯ длина)
  @param (defItemVAL значение элемента по умолчанию)
  ---
  *! если в массив будут добавленны НОВЫЕ элементы, то их значение установится в defItemVAL
  }
//--- template call ----------------------------------------------------------//
//procedure dAim_setLength(var dAIM:pointer; const Value:_tUsrDAIM_tLength_; const defItemVAL:_tInkDAIM_tItem_);
begin
    if Value=0 then begin //< ЧИСТИМ
        // вызов: inkDAim_FINALize(dAIM)
        {$i inkDAim_prcBODY_FFv0_FINALize.inc}
    end
    else begin
        if dAIM=nil then begin //< оно пустое, надо инициализировать
            // вызов: dAim_INITialize(dAIM,Length==Value,defItemVAL)
            {$define Length:=Value}
            {$i inkDAim_prcBODY_00v2_INITialize.inc};
            {$undef Length}
        end
        else begin
            ReAllocMem(dAIM,_cInkDAIM_zLength_+_cInkDAIM_zItem_*Value);
            if _mInkDAIM_varCOUNT<Value //< если массив увеличился
            then _mInkDAIM_pFILL( //< заполнили значениями, не с самого началаЫ
                    _tInkDAIM_tItem_(_fInkDAIM_pItem(dAIM,_mInkDAIM_varCOUNT)^), //< с какого места
                     Value-_mInkDAIM_varCOUNT, //< скока штук
                     defItemVAL
                     );
           _mInkDAIM_varCOUNT:=Value; //< ПЕРЕзаписали значение длинны
        end;
    end;
end;

