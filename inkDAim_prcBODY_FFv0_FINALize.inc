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
// инициализация переменной массива                                           \\
//----------------------------------------------------------------------------//
{-D-[ Array in Mem ] ФИНАЛИЗИРОВАТЬ массив, очистить память. dAIM===NIL }
//--- template call ----------------------------------------------------------//
//procedure dAim_FINALize(var dAIM:pointer);
begin
    if dAIM<>nil then begin
        {$ifdef _DEBUG_}
          if _mInkDAIM_varCOUNT=0 then raise Exception.Create('[dAim]FINALize: dAIM<>nil AND length(dAIM)==0');
        {$endif}
        Freemem(dAIM,_cInkDAIM_zLength_+_cInkDAIM_zItem_*_mInkDAIM_varCOUNT); //< зачистили
    end;
end;


