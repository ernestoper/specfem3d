! Recursive Fortran 95 quicksort routine
! sorts real numbers into ascending numerical order
! Author: Juli Rew, SCD Consulting (juliana@ucar.edu), 9/03
! Based on algorithm from Cormen et al., Introduction to Algorithms,
! 1997 printing

! Made F conformant by Walt Brainerd
!
! modified by Vadim Monteiller (january 2016)
! (add permutation array in input/output)
!
module module_qsort

implicit none
public :: QsortC
private :: Partition

contains

recursive subroutine QsortC(A,Id)
  double precision, intent(in out), dimension(:) :: A
  integer,          intent(in out), dimension(:) :: Id
  integer :: iq

  if(size(A) > 1) then
     call Partition(A, Id, iq)
     call QsortC(A(:iq-1), Id(:iq-1))
     call QsortC(A(iq:), Id(iq:))
  endif
end subroutine QsortC

subroutine Partition(A, Id, marker)
  double precision, intent(in out), dimension(:) :: A
  integer,          intent(in out), dimension(:) :: Id  !! add by VM
  integer, intent(out) :: marker
  integer :: i, j, itmp                                 !! add by VM
  double precision :: temp
  double precision :: x      ! pivot point
  x = A(1)
  i= 0
  j= size(A) + 1

  do
     j = j-1
     do
        if (A(j) <= x) exit
        j = j-1
     end do
     i = i+1
     do
        if (A(i) >= x) exit
        i = i+1
     end do
     if (i < j) then
        ! exchange A(i) and A(j)
        temp = A(i)
        A(i) = A(j)
        A(j) = temp

        !! add by VM 
        itmp  = Id(i) 
        Id(i) = Id(j)
        Id(j) = itmp

     elseif (i == j) then
        marker = i+1
        return
     else
        marker = i
        return
     endif
  end do

end subroutine Partition

end module module_qsort

