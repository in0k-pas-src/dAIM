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
//  получить ДЛИННУ массива                                                   \\
//----------------------------------------------------------------------------//
//--- template call ----------------------------------------------------------//
//function dAim_getLength(const dAIM:pointer):byte;
begin
    {$ifdef _DEBUG_}
      if (dAIM<>nil)and(_mInkDAIM_varCOUNT=0) then raise Exception.Create('[dAim]getLength: dAIM<>nil AND length(dAIM)==0');
    {$endif}
    if dAIM<>nil then result:=_mInkDAIM_varCOUNT
                 else result:=0;
end;

