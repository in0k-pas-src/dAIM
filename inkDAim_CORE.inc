
//--- про тип ДЛИНА массива
type
{[ink]dAIM тип -- "ДЛИННА массива", определяет размер памяти для хранения длины}
_tInkDAIM_tLength_= _tUsrDAIM_tLength_;
{[ink]dAIM тип -- УКАЗАТЕЛЬ на переменную "ДЛИННА массива"}
_pInkDAIM_tLength_=^_tInkDAIM_tLength_;
const
{[inside] размер в БАЙТах переменной "ДЛИННА массива"}
_cInkDAIM_zLength_= sizeOf(_tInkDAIM_tLength_);


//--- про тип ИНДЕКС-элемента массива

type
{[ink]dAIM тип -- "ИНДЕКС-элемента" массива}
_tInkDAIM_tIndex_ = _tInkDAIM_tLength_;


//--- про ЭЛЕМНТ массива

type
{[ink]dAIM тип -- ЭЛЕМЕНТ массива}
_tInkDAIM_tItem_  =  _tUsrDAIM_tItem_;
{[ink]dAIM тип -- УКАЗАТЕЛЬ на ЭЛЕМЕНТ массива}
_pInkDAIM_tItem_  = ^_tInkDAIM_tItem_;
const
{[ink]dAIM размер в БАЙТах одного ЭЛЕМЕНТА массива}
_cInkDAIM_zItem_  =  sizeOf(_tInkDAIM_tItem_);


//--- ВНУТРЕННИЙ функционал

{$MACRO ON}


{$ifdef CPU32}
procedure FillDWord(var x:pointer;count:SizeInt;value:pointer); overload; inline;
begin
    FillDWord({%H-}DWord(x),count,{%H-}DWord(value))
end;
{$endif}
{$ifdef CPU64}
procedure FillQWord(var x:pointer;count:SizeInt;value:pointer); overload; inline;
begin
    FillQWord({%H-}QWord(x),count,{%H-}QWord(value))
end;
{$endif}

// с помощю этого макроса выходим на функцию ЗАПОЛНЕНИЯ массива значением
{$undef _mInkDAIM_pFILL}
{$IF _cInkDAIM_zItem_=1}
  {$define _mInkDAIM_pFILL:=FillByte}
{$endIF}
{$IF _cInkDAIM_zItem_=2}
  {$define _mInkDAIM_pFILL:=FillWord}
{$endIF}
{$IF _cInkDAIM_zItem_=4}
  {$define _mInkDAIM_pFILL:=FillDWord}
{$endIF}
{$IF _cInkDAIM_zItem_=8}
  {$define _mInkDAIM_pFILL:=FillQWord}
{$endIF}
{$ifNdef _mInkDAIM_pFILL}
  //procedure _fUsrDAIM_FillArray(var x:_tUsrDAIM_tItem_; count:_tUsrDAIM_tLength_; value:_tUsrDAIM_tItem_);
  {$FATAL '_mInkDAIM_pFILL NOT defined for this Item node size'}
{$endIF}

// с помощю этого макроса бурем значение ДЛИННА-Массива
{$define _mInkDAIM_varCOUNT:=_pInkDAIM_tLength_(dAIM)^}


{-D-[ink]dAIM (!!! безПроверок !!!) вычислить указатель на элемент массива
  @param (dAIM  обрабатываемый массив)
  @param (Index индекс интеррисуемого элемента)
  @return(указатель на элемент)
  ---
  * не смог упрятать в макрос o_O
  }
function _fInkDAIM_pItem(const dAIM:pointer; const Index:_tInkDAIM_tIndex_):pointer; {$ifdef _INLINE_} inline; {$endif}
begin
    result:=dAIM+_cInkDAIM_zLength_+Index*_cInkDAIM_zItem_;
end;

