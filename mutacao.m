## Copyright (C) 2018 andre.lunelli
## 
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} mutacao (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: andre.lunelli
## Created: 2018-10-10

function [paiMutacao1, paiMutacao2] = mutacao (paiCrossover1, paiCrossover2)
  global npar;
  pair = ceil(npar * rand(1, npar))(1:2);
  
  tmp = paiCrossover1(pair(2));
  paiCrossover1(pair(2)) = paiCrossover1(pair(1));
  paiCrossover1(pair(1)) = tmp;
  
  tmp = paiCrossover2(pair(2));
  paiCrossover2(pair(2)) = paiCrossover2(pair(1));
  paiCrossover2(pair(1)) = tmp;
  
  paiMutacao1 = paiCrossover1;
  paiMutacao2 = paiCrossover2;  
endfunction
