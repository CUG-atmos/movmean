module mo_weight

! PUBLIC :: wsum
! PUBLIC :: wmean

! INTERFACE wsum
!     MODULE PROCEDURE wsum_vec, wsum_mat
! END INTERFACE wsum

! INTERFACE wmean
!     MODULE PROCEDURE wmean_vec, wmean_mat
! END INTERFACE wmean

contains

! movmean_r <- function(x, halfwin = 2L, na.rm = TRUE) {
!   m <- halfwin
!   n <- length(x)
!   y <- rep(NA_real_, n)
!   for (i in 1:n) {
!     i_begin <- pmin(i - m, 1)
!     i_end   <- pmax(i + m, n)
!     y[i] <- mean(x[i_begin:i_end], na.rm = na.rm)
!   }
!   y
! }

subroutine movmean_f90(x, halfwin, n, x_mov) bind(C, name="movmean_f90_")
    INTEGER, INTENT(IN) :: halfwin  
    INTEGER, INTENT(IN) :: n   
    REAL(8)   , dimension(n), intent(in) :: x
    REAL(8)   , dimension(n), intent(OUT) :: x_mov

    integer :: i_begin, i_end

    do i = 1, n
        i_begin = max(i - halfwin , 1)
        i_end = min(i + halfwin, n)
        x_mov(i) = sum(x(i_begin:i_end))/(i_end - i_begin + 1)
    end do
end

! normalize: default false; if true, sum(ws) = 1
real function wsum_vec(mat, ws, mask, normalize, n) bind(C, name="wsum_vec_")
    INTEGER, INTENT(IN) :: n   
    REAL   , dimension(n), intent(in) :: mat
    REAL   , dimension(n), optional, intent(in) :: ws
    LOGICAL, dimension(n), optional, intent(in) :: mask
    LOGICAL,               optional, intent(in) :: normalize
    
    ! implicit none
    ! real :: args
    ! local
    REAL   , dimension(:), allocatable :: vec
    REAL   , dimension(:), allocatable :: ws2
    REAL   , dimension(:), allocatable :: w
    integer :: nrow, ncol, i, j
    real    :: tol
    LOGICAL :: is_weight

    is_weight = present(ws)
    if (present(ws)) ws2 = ws
    ! can't use print here

    if ( .not. present(mask) ) then
        ! no mask
        if (is_weight) then
            if (present(normalize) .and. normalize) ws2 = ws / sum(ws) * size(ws)
            tol = sum(mat * ws2)
        else
            tol = sum(mat)
        endif
    else
        vec = PACK(mat, mask)

        if (is_weight) then
            w   = PACK(ws2, mask)
            if (present(normalize) .and. normalize) w = w / sum(w) * size(w)

            ! allocate( w(count(mask)) )
            tol = sum(vec * w)
            deallocate(w)
        else
            tol = sum(vec)
        endif
        deallocate(vec)
    endif

    wsum_vec = tol
end function wsum_vec

! real function wsum_mat(mat, ws, mask, normalize) bind(C, name="wsum_mat_")
!     ! implicit none
!     ! real :: args
!     REAL   , dimension(:, :), intent(in) :: mat
!     REAL   , dimension(:, :), optional, intent(in) :: ws
!     LOGICAL, dimension(:, :), optional, intent(in) :: mask
!     LOGICAL,                  optional, intent(in) :: normalize
    
!     ! local
!     REAL   , dimension(:, :), allocatable :: ws2
!     REAL   , dimension(:)   , allocatable :: vec
!     REAL   , dimension(:)   , allocatable :: w
    
!     integer :: nrow, ncol, i, j
!     real    :: tol
!     LOGICAL :: is_weight 

!     is_weight = present(ws)
!     if (present(ws)) ws2 = ws
!     ! write (*, *) ws2 !size(ws2, 1), size(ws2, 2)
    
!     if (.not. present(mask)) then
!         if (is_weight) then
!             ! if normalize, sum(w_mask) = 1
!             if (present(normalize) .and. normalize) ws2 = ws / sum(ws) * size(ws)
!             tol = sum(mat * ws2)
!         else
!             tol = sum(mat)
!         endif
!     else
!         vec = PACK(mat, mask)

!         if (is_weight) then
!             w   = PACK(ws2, mask)
!             if (present(normalize) .and. normalize) w = w / sum(w) * size(w)
!             ! write (*, *) w !size(ws2, 1), size(ws2, 2)
!             ! allocate( w(count(mask)) )
!             tol = sum(vec * w)
!             deallocate(w)
!         else
!             tol = sum(vec)
!         endif
!         deallocate(vec)
!     endif
!     wsum_mat = tol
! end function wsum_mat

! real function wmean_vec(mat, ws, mask) bind(C, name="wmean_vec_")
!     ! implicit none
!     REAL   , dimension(:), intent(in) :: mat
!     REAL   , dimension(:), optional, intent(in) :: ws
!     LOGICAL, dimension(:), optional, intent(in) :: mask

!     real tol;
!     integer n;
!     ! local
!     tol = wsum_vec(mat, ws, mask) 

!     if (present(mask)) then
!         n = count(mask)
!     else
!         n = size(mat)
!     endif
!     wmean_vec = tol / n
!     ! write (120, *) tol, n, wmean, 11.0/2
! end function wmean_vec

! real function wmean_mat(mat, ws, mask) bind(C, name="wmean_mat_")
!     ! implicit none
!     REAL   , dimension(:, :), intent(in) :: mat
!     REAL   , dimension(:, :), optional, intent(in) :: ws
!     LOGICAL, dimension(:, :), optional, intent(in) :: mask

!     real tol;
!     integer n;
!     ! local
!     tol = wsum_mat(mat, ws, mask) 

!     if (present(mask)) then
!         n = count(mask)
!     else
!         n = size(mat)
!     endif
!     wmean_mat = tol / n
! end function wmean_mat

end module
