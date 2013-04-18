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
//  установить ДЛИННУ массива                                                   \\
//----------------------------------------------------------------------------//
{-D-[ Array in Mem ] Установить длину массива
  @param (AIM   обрабатываемый массив)
  @param (Value НОВАЯ длина)
  }
//--- template call ----------------------------------------------------------//
//procedure dAim_setLength(var dAIM:pointer; const Value:_tUsrDAIM_tLength_);
begin
    if Value=0 then begin //< ЧИСТИМ
        // вызов: inkDAim_FINALize(dAIM)
        {$i inkDAim_prcBODY_FFv0_FINALize.inc}
    end
    else begin
        if dAIM=nil then Getmem    (dAIM,_cInkDAIM_zLength_+_cInkDAIM_zItem_*Value)
                    else ReAllocMem(dAIM,_cInkDAIM_zLength_+_cInkDAIM_zItem_*Value);
       _mInkDAIM_varCOUNT:=Value; //< записали значение Количества Элементов
    end;
end;

