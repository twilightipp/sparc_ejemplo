.global _start

_start:
    define (NUM_STEPS, 100)      ! Número de pasos
    define (VISCOSITY, 1000)     ! Viscosidad del medio
    define (MASA, 500)           ! Masa del objeto 

    ! Inicializar registros
    MOV NUM_STEPS, %l0           ! Contador de pasos n = 100
    MOV VISCOSITY, %l1           ! Viscosidad b = 1000
    MOV MASA, %l2                ! Masa m = 500
    MOV %g0, %l3                 ! Posición inicial p = 0 

loop:
    ! Calcular resistencia viscosa: F_visc = -b * v
    VEC_MUL_SCALAR %l1, %v0, %v2  ! F_visc = -b * v 

    ! Calcular fuerza neta: F_total = f + F_visc
    VEC_ADD %v1, %v2, %v3        ! F_total = f + F_visc 

    ! Calcular aceleración: a = F_total / m
    VEC_DIV_SCALAR %v3, %l2, %v4 ! a = F_total / m 

    ! Actualizar velocidad: v = v + (a * t)
    VEC_MUL_SCALAR %v4, %v5, %v6 ! a * t 
    VEC_ADD %v0, %v6, %v0        ! v = v + (a * t)

    ! Actualizar posición: p = p + (v * t)
    VEC_MUL_SCALAR %v0, %v5, %v7 ! v * t 
    VEC_ADD %l3, %v7, %l3        ! p = p + (v * t)

    ! Decrementar contador de pasos
    sub %l0, 1, %l0
    cmp %l0, 0
    bne loop
    nop

end_simulation:
    mov 0, %g1
    ta 0
