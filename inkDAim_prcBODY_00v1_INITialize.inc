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
// инициализация переменной массива
//--- template call ----------------------------------------------------------//
//procedure dAim_INITialize(var dAIM:pointer; const Length:_tInkDAIM_tLength_);
begin
    {$ifdef _DEBUG_}
      if Length=0 then raise Exception.Create('[dAim]INITialize: wrong CALL:  Length==0');
    {$endif}
    getMem(dAIM,_cInkDAIM_zLength_+_cInkDAIM_zItem_*Length);
   _mInkDAIM_varCOUNT:=Length; //< записали значение Количества Элементов
end;

