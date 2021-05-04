Program drive_shooting
  !Select case
  !C: note velocità iniziale e velocità finale (determina posizione iniziale)
  !B: note posizione iniziale e velocità finale (determina velocità iniziale)
  !A: note posizione iniziale e finale (determina velocità iniziale)
  
  Use LibraryOde

  Implicit None

  Type(ode_data) :: data
  Type(ode_para) :: para
  Integer :: i,max_i
  Real(rk) :: print_data(5)

  para%eps=1.E-6_rk
  para%max_steps=1000
  para%case='C'
  Allocate(data%y0(2),data%y1(2),data%y(2))
  data%y0=[0._rk,1._rk]
  data%x0=0._rk
  data%y1=[1._rk,0._rk]
  data%x1=1._rk
  data%dx=1.E-3_rk
  data%fun => fun

  If (shooting(data,para)/=0) Stop 'shooting failed'     !Tutto il lavoro lo fa la funzione shooting

  Open(1,file='shooting.dat')
  
  Write(1,*) 'x u du u_exa du_exa'
  max_i=Ceiling(Abs((data%x1-data%x0)/data%dx))+1        !Ceiling prende l'intero più piccolo e ci somma uno (meglio abbondare che deficere)
  Do i=1,max_i                                           !Stampa i dati di u e du salvati in data tramite shooting
     print_data=[data%x0,data%u(1,i),data%u(2,i),Cos(0.5_rk*pi*data%x0)+ &
          2._rk*Sin(0.5_rk*pi*data%x0)-1._rk,-0.5_rk*pi*Sin(0.5_rk*pi*data%x0)+pi*Cos(0.5_rk*pi*data%x0)]
     Write(*,'(E19.12,4(x,E19.12))') print_data
     Write(1,'(E19.12,4(x,E19.12))') print_data
     data%x0=data%x0+data%dx
  EndDo
  
  Close(1)
  
  Print *,'secant steps: ',para%steps

Contains

  Function fun(y,x)
    Implicit None
    Real(rk), Intent(in) :: y(1:),x
    Real(rk) :: fun(1:Size(y))

    fun(1)=y(2)
    fun(2)=-0.25_rk*(pi**2)*(1._rk+y(1))
  End Function fun
  
End Program drive_shooting
