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
// инициализация значений массива                                             \\
//----------------------------------------------------------------------------//
{-D-[ Array in Mem ] ЗАПОЛНИТЬ созданный массив ЗНАЧЕНИЯМИ
  @param (dAIM  обрабатываемый массив)
  @param (Value значение, которое будет помещено в КАЖДЫЙ элемент)
  }
//--- template call ----------------------------------------------------------//
//procedure dAim_initVALUES(var dAIM:pointer; const Value:_tInkDAIM_tItem_);
begin
    if dAIM<>nil then begin
       {$ifdef _DEBUG_}
         if _mInkDAIM_varCOUNT=0 then raise Exception.Create('[dAim]initVALUES: dAIM<>nil AND length(dAIM)==0');
       {$endif}
      _mInkDAIM_pFILL(//< заполняем значениями
            _tInkDAIM_tItem_((dAIM+_cInkDAIM_zLength_)^), //< начало
            _mInkDAIM_varCOUNT,                           //< кол-во штук
             Value                                        //< чем заполняем
                     );
    end;
end;

